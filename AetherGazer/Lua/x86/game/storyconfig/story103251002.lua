return {
	Play325102001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 325102001
		arg_1_1.duration_ = 4.5

		local var_1_0 = {
			zh = 4.066,
			ja = 4.5
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
				arg_1_0:Play325102002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "J29g"

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
				local var_4_5 = arg_1_1.bgs_.J29g

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
					if iter_4_0 ~= "J29g" then
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

				arg_1_1:AudioAction(var_4_26, var_4_27, "se_story_143", "se_story_143_amb_drone_dark", "")
			end

			local var_4_28 = 0
			local var_4_29 = 1

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				local var_4_30 = "play"
				local var_4_31 = "music"

				arg_1_1:AudioAction(var_4_30, var_4_31, "bgm_activity_5_1_story_jianzhong", "bgm_activity_5_1_story_jianzhong", "bgm_activity_5_1_story_jianzhong.awb")

				local var_4_32 = ""
				local var_4_33 = manager.audio:GetAudioName("bgm_activity_5_1_story_jianzhong", "bgm_activity_5_1_story_jianzhong")

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
			local var_4_35 = 0.175

			if var_4_34 < arg_1_1.time_ and arg_1_1.time_ <= var_4_34 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_36 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_36:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_36:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_36:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_37 = arg_1_1:FormatText(StoryNameCfg[1455].name)

				arg_1_1.leftNameTxt_.text = var_4_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_38 = arg_1_1:GetWordFromCfg(325102001)
				local var_4_39 = arg_1_1:FormatText(var_4_38.content)

				arg_1_1.text_.text = var_4_39

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_40 = 7
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

				if manager.audio:GetVoiceLength("story_v_out_325102", "325102001", "story_v_out_325102.awb") ~= 0 then
					local var_4_43 = manager.audio:GetVoiceLength("story_v_out_325102", "325102001", "story_v_out_325102.awb") / 1000

					if var_4_43 + var_4_34 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_43 + var_4_34
					end

					if var_4_38.prefab_name ~= "" and arg_1_1.actors_[var_4_38.prefab_name] ~= nil then
						local var_4_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_38.prefab_name].transform, "story_v_out_325102", "325102001", "story_v_out_325102.awb")

						arg_1_1:RecordAudio("325102001", var_4_44)
						arg_1_1:RecordAudio("325102001", var_4_44)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_325102", "325102001", "story_v_out_325102.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_325102", "325102001", "story_v_out_325102.awb")
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
	Play325102002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 325102002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play325102003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 0
			local var_11_1 = 1.625

			if var_11_0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_0 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, false)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_2 = arg_8_1:GetWordFromCfg(325102002)
				local var_11_3 = arg_8_1:FormatText(var_11_2.content)

				arg_8_1.text_.text = var_11_3

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_4 = 65
				local var_11_5 = utf8.len(var_11_3)
				local var_11_6 = var_11_4 <= 0 and var_11_1 or var_11_1 * (var_11_5 / var_11_4)

				if var_11_6 > 0 and var_11_1 < var_11_6 then
					arg_8_1.talkMaxDuration = var_11_6

					if var_11_6 + var_11_0 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_6 + var_11_0
					end
				end

				arg_8_1.text_.text = var_11_3
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)
				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_7 = math.max(var_11_1, arg_8_1.talkMaxDuration)

			if var_11_0 <= arg_8_1.time_ and arg_8_1.time_ < var_11_0 + var_11_7 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_0) / var_11_7

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_0 + var_11_7 and arg_8_1.time_ < var_11_0 + var_11_7 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play325102003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 325102003
		arg_12_1.duration_ = 1.63

		local var_12_0 = {
			zh = 1.2,
			ja = 1.633
		}
		local var_12_1 = manager.audio:GetLocalizationFlag()

		if var_12_0[var_12_1] ~= nil then
			arg_12_1.duration_ = var_12_0[var_12_1]
		end

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play325102004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 0
			local var_15_1 = 0.125

			if var_15_0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_0 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				local var_15_2 = arg_12_1:FormatText(StoryNameCfg[1467].name)

				arg_12_1.leftNameTxt_.text = var_15_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, true)
				arg_12_1.iconController_:SetSelectedState("hero")

				arg_12_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1077")

				arg_12_1.callingController_:SetSelectedState("normal")

				arg_12_1.keyicon_.color = Color.New(1, 1, 1)
				arg_12_1.icon_.color = Color.New(1, 1, 1)

				local var_15_3 = arg_12_1:GetWordFromCfg(325102003)
				local var_15_4 = arg_12_1:FormatText(var_15_3.content)

				arg_12_1.text_.text = var_15_4

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_5 = 5
				local var_15_6 = utf8.len(var_15_4)
				local var_15_7 = var_15_5 <= 0 and var_15_1 or var_15_1 * (var_15_6 / var_15_5)

				if var_15_7 > 0 and var_15_1 < var_15_7 then
					arg_12_1.talkMaxDuration = var_15_7

					if var_15_7 + var_15_0 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_7 + var_15_0
					end
				end

				arg_12_1.text_.text = var_15_4
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325102", "325102003", "story_v_out_325102.awb") ~= 0 then
					local var_15_8 = manager.audio:GetVoiceLength("story_v_out_325102", "325102003", "story_v_out_325102.awb") / 1000

					if var_15_8 + var_15_0 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_8 + var_15_0
					end

					if var_15_3.prefab_name ~= "" and arg_12_1.actors_[var_15_3.prefab_name] ~= nil then
						local var_15_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_3.prefab_name].transform, "story_v_out_325102", "325102003", "story_v_out_325102.awb")

						arg_12_1:RecordAudio("325102003", var_15_9)
						arg_12_1:RecordAudio("325102003", var_15_9)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_325102", "325102003", "story_v_out_325102.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_325102", "325102003", "story_v_out_325102.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_10 = math.max(var_15_1, arg_12_1.talkMaxDuration)

			if var_15_0 <= arg_12_1.time_ and arg_12_1.time_ < var_15_0 + var_15_10 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_0) / var_15_10

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_0 + var_15_10 and arg_12_1.time_ < var_15_0 + var_15_10 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play325102004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 325102004
		arg_16_1.duration_ = 2

		local var_16_0 = {
			zh = 1.266,
			ja = 2
		}
		local var_16_1 = manager.audio:GetLocalizationFlag()

		if var_16_0[var_16_1] ~= nil then
			arg_16_1.duration_ = var_16_0[var_16_1]
		end

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play325102005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = 0
			local var_19_1 = 0.15

			if var_19_0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_0 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				local var_19_2 = arg_16_1:FormatText(StoryNameCfg[1455].name)

				arg_16_1.leftNameTxt_.text = var_19_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, true)
				arg_16_1.iconController_:SetSelectedState("hero")

				arg_16_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_16_1.callingController_:SetSelectedState("normal")

				arg_16_1.keyicon_.color = Color.New(1, 1, 1)
				arg_16_1.icon_.color = Color.New(1, 1, 1)

				local var_19_3 = arg_16_1:GetWordFromCfg(325102004)
				local var_19_4 = arg_16_1:FormatText(var_19_3.content)

				arg_16_1.text_.text = var_19_4

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_5 = 6
				local var_19_6 = utf8.len(var_19_4)
				local var_19_7 = var_19_5 <= 0 and var_19_1 or var_19_1 * (var_19_6 / var_19_5)

				if var_19_7 > 0 and var_19_1 < var_19_7 then
					arg_16_1.talkMaxDuration = var_19_7

					if var_19_7 + var_19_0 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_7 + var_19_0
					end
				end

				arg_16_1.text_.text = var_19_4
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325102", "325102004", "story_v_out_325102.awb") ~= 0 then
					local var_19_8 = manager.audio:GetVoiceLength("story_v_out_325102", "325102004", "story_v_out_325102.awb") / 1000

					if var_19_8 + var_19_0 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_8 + var_19_0
					end

					if var_19_3.prefab_name ~= "" and arg_16_1.actors_[var_19_3.prefab_name] ~= nil then
						local var_19_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_3.prefab_name].transform, "story_v_out_325102", "325102004", "story_v_out_325102.awb")

						arg_16_1:RecordAudio("325102004", var_19_9)
						arg_16_1:RecordAudio("325102004", var_19_9)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_325102", "325102004", "story_v_out_325102.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_325102", "325102004", "story_v_out_325102.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_10 = math.max(var_19_1, arg_16_1.talkMaxDuration)

			if var_19_0 <= arg_16_1.time_ and arg_16_1.time_ < var_19_0 + var_19_10 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_0) / var_19_10

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_0 + var_19_10 and arg_16_1.time_ < var_19_0 + var_19_10 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play325102005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 325102005
		arg_20_1.duration_ = 6.17

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play325102006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = "1077ui_story"

			if arg_20_1.actors_[var_23_0] == nil then
				local var_23_1 = Asset.Load("Char/" .. "1077ui_story")

				if not isNil(var_23_1) then
					local var_23_2 = Object.Instantiate(Asset.Load("Char/" .. "1077ui_story"), arg_20_1.stage_.transform)

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

			local var_23_5 = arg_20_1.actors_["1077ui_story"].transform
			local var_23_6 = 0

			if var_23_6 < arg_20_1.time_ and arg_20_1.time_ <= var_23_6 + arg_23_0 then
				arg_20_1.var_.moveOldPos1077ui_story = var_23_5.localPosition

				local var_23_7 = GameObjectTools.GetOrAddComponent(var_23_5.gameObject, typeof(DynamicBoneHelper))

				if var_23_7 then
					var_23_7:EnableDynamicBone(false)
				end
			end

			local var_23_8 = 0.001

			if var_23_6 <= arg_20_1.time_ and arg_20_1.time_ < var_23_6 + var_23_8 then
				local var_23_9 = (arg_20_1.time_ - var_23_6) / var_23_8
				local var_23_10 = Vector3.New(0, 100, 0)

				var_23_5.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos1077ui_story, var_23_10, var_23_9)

				local var_23_11 = manager.ui.mainCamera.transform.position - var_23_5.position

				var_23_5.forward = Vector3.New(var_23_11.x, var_23_11.y, var_23_11.z)

				local var_23_12 = var_23_5.localEulerAngles

				var_23_12.z = 0
				var_23_12.x = 0
				var_23_5.localEulerAngles = var_23_12
			end

			if arg_20_1.time_ >= var_23_6 + var_23_8 and arg_20_1.time_ < var_23_6 + var_23_8 + arg_23_0 then
				var_23_5.localPosition = Vector3.New(0, 100, 0)

				local var_23_13 = manager.ui.mainCamera.transform.position - var_23_5.position

				var_23_5.forward = Vector3.New(var_23_13.x, var_23_13.y, var_23_13.z)

				local var_23_14 = var_23_5.localEulerAngles

				var_23_14.z = 0
				var_23_14.x = 0
				var_23_5.localEulerAngles = var_23_14

				local var_23_15 = GameObjectTools.GetOrAddComponent(var_23_5.gameObject, typeof(DynamicBoneHelper))

				if var_23_15 then
					var_23_15:EnableDynamicBone(true)
				end
			end

			local var_23_16 = "1059ui_story"

			if arg_20_1.actors_[var_23_16] == nil then
				local var_23_17 = Asset.Load("Char/" .. "1059ui_story")

				if not isNil(var_23_17) then
					local var_23_18 = Object.Instantiate(Asset.Load("Char/" .. "1059ui_story"), arg_20_1.stage_.transform)

					var_23_18.name = var_23_16
					var_23_18.transform.localPosition = Vector3.New(0, 100, 0)
					arg_20_1.actors_[var_23_16] = var_23_18

					local var_23_19 = var_23_18:GetComponentInChildren(typeof(CharacterEffect))

					var_23_19.enabled = true

					local var_23_20 = GameObjectTools.GetOrAddComponent(var_23_18, typeof(DynamicBoneHelper))

					if var_23_20 then
						var_23_20:EnableDynamicBone(false)
					end

					arg_20_1:ShowWeapon(var_23_19.transform, false)

					arg_20_1.var_[var_23_16 .. "Animator"] = var_23_19.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_20_1.var_[var_23_16 .. "Animator"].applyRootMotion = true
					arg_20_1.var_[var_23_16 .. "LipSync"] = var_23_19.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_23_21 = arg_20_1.actors_["1059ui_story"]
			local var_23_22 = 0

			if var_23_22 < arg_20_1.time_ and arg_20_1.time_ <= var_23_22 + arg_23_0 and not isNil(var_23_21) and arg_20_1.var_.characterEffect1059ui_story == nil then
				arg_20_1.var_.characterEffect1059ui_story = var_23_21:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_23 = 0.200000002980232

			if var_23_22 <= arg_20_1.time_ and arg_20_1.time_ < var_23_22 + var_23_23 and not isNil(var_23_21) then
				local var_23_24 = (arg_20_1.time_ - var_23_22) / var_23_23

				if arg_20_1.var_.characterEffect1059ui_story and not isNil(var_23_21) then
					local var_23_25 = Mathf.Lerp(0, 0.5, var_23_24)

					arg_20_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_20_1.var_.characterEffect1059ui_story.fillRatio = var_23_25
				end
			end

			if arg_20_1.time_ >= var_23_22 + var_23_23 and arg_20_1.time_ < var_23_22 + var_23_23 + arg_23_0 and not isNil(var_23_21) and arg_20_1.var_.characterEffect1059ui_story then
				local var_23_26 = 0.5

				arg_20_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_20_1.var_.characterEffect1059ui_story.fillRatio = var_23_26
			end

			local var_23_27 = manager.ui.mainCamera.transform
			local var_23_28 = 0

			if var_23_28 < arg_20_1.time_ and arg_20_1.time_ <= var_23_28 + arg_23_0 then
				local var_23_29 = arg_20_1.var_.effect43243
				local var_23_30
				local var_23_31 = var_23_27

				if not var_23_29 then
					var_23_29 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_emp"), var_23_31)
					var_23_29.name = "43243"
					arg_20_1.var_.effect43243 = var_23_29
				else
					var_23_29.transform:SetParent(var_23_31)
				end

				var_23_29.transform.localPosition = Vector3.New(0, 0, 0)
				var_23_29.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_23_32 = 0.266666666666667

			if var_23_32 < arg_20_1.time_ and arg_20_1.time_ <= var_23_32 + arg_23_0 then
				arg_20_1.mask_.enabled = true
				arg_20_1.mask_.raycastTarget = true

				arg_20_1:SetGaussion(false)
			end

			local var_23_33 = 0.733333333333333

			if var_23_32 <= arg_20_1.time_ and arg_20_1.time_ < var_23_32 + var_23_33 then
				local var_23_34 = (arg_20_1.time_ - var_23_32) / var_23_33
				local var_23_35 = Color.New(1, 1, 1)

				var_23_35.a = Mathf.Lerp(1, 0, var_23_34)
				arg_20_1.mask_.color = var_23_35
			end

			if arg_20_1.time_ >= var_23_32 + var_23_33 and arg_20_1.time_ < var_23_32 + var_23_33 + arg_23_0 then
				local var_23_36 = Color.New(1, 1, 1)
				local var_23_37 = 0

				arg_20_1.mask_.enabled = false
				var_23_36.a = var_23_37
				arg_20_1.mask_.color = var_23_36
			end

			local var_23_38 = 0

			if var_23_38 < arg_20_1.time_ and arg_20_1.time_ <= var_23_38 + arg_23_0 then
				arg_20_1.allBtn_.enabled = false
			end

			local var_23_39 = 1.43333333333333

			if arg_20_1.time_ >= var_23_38 + var_23_39 and arg_20_1.time_ < var_23_38 + var_23_39 + arg_23_0 then
				arg_20_1.allBtn_.enabled = true
			end

			local var_23_40 = 0.5
			local var_23_41 = 1

			if var_23_40 < arg_20_1.time_ and arg_20_1.time_ <= var_23_40 + arg_23_0 then
				local var_23_42 = "play"
				local var_23_43 = "effect"

				arg_20_1:AudioAction(var_23_42, var_23_43, "se_story_134_01", "se_story_134_01_flash", "")
			end

			if arg_20_1.frameCnt_ <= 1 then
				arg_20_1.dialog_:SetActive(false)
			end

			local var_23_44 = 1.16666666666667
			local var_23_45 = 1.2

			if var_23_44 < arg_20_1.time_ and arg_20_1.time_ <= var_23_44 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0

				arg_20_1.dialog_:SetActive(true)

				arg_20_1.dialogCg_.alpha = 0

				local var_23_46 = LeanTween.value(arg_20_1.dialog_, 0, 1, 0.3)

				var_23_46:setOnUpdate(LuaHelper.FloatAction(function(arg_24_0)
					arg_20_1.dialogCg_.alpha = arg_24_0
				end))
				var_23_46:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_20_1.dialog_)
					var_23_46:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_20_1.duration_ = arg_20_1.duration_ + 0.3

				SetActive(arg_20_1.leftNameGo_, false)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_47 = arg_20_1:GetWordFromCfg(325102005)
				local var_23_48 = arg_20_1:FormatText(var_23_47.content)

				arg_20_1.text_.text = var_23_48

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_49 = 48
				local var_23_50 = utf8.len(var_23_48)
				local var_23_51 = var_23_49 <= 0 and var_23_45 or var_23_45 * (var_23_50 / var_23_49)

				if var_23_51 > 0 and var_23_45 < var_23_51 then
					arg_20_1.talkMaxDuration = var_23_51
					var_23_44 = var_23_44 + 0.3

					if var_23_51 + var_23_44 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_51 + var_23_44
					end
				end

				arg_20_1.text_.text = var_23_48
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)
				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_52 = var_23_44 + 0.3
			local var_23_53 = math.max(var_23_45, arg_20_1.talkMaxDuration)

			if var_23_52 <= arg_20_1.time_ and arg_20_1.time_ < var_23_52 + var_23_53 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_52) / var_23_53

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_52 + var_23_53 and arg_20_1.time_ < var_23_52 + var_23_53 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
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
	Play325102006 = function(arg_26_0, arg_26_1)
		arg_26_1.time_ = 0
		arg_26_1.frameCnt_ = 0
		arg_26_1.state_ = "playing"
		arg_26_1.curTalkId_ = 325102006
		arg_26_1.duration_ = 5

		SetActive(arg_26_1.tipsGo_, false)

		function arg_26_1.onSingleLineFinish_()
			arg_26_1.onSingleLineUpdate_ = nil
			arg_26_1.onSingleLineFinish_ = nil
			arg_26_1.state_ = "waiting"
		end

		function arg_26_1.playNext_(arg_28_0)
			if arg_28_0 == 1 then
				arg_26_0:Play325102007(arg_26_1)
			end
		end

		function arg_26_1.onSingleLineUpdate_(arg_29_0)
			local var_29_0 = 0.5
			local var_29_1 = 1

			if var_29_0 < arg_26_1.time_ and arg_26_1.time_ <= var_29_0 + arg_29_0 then
				local var_29_2 = "play"
				local var_29_3 = "effect"

				arg_26_1:AudioAction(var_29_2, var_29_3, "se_story_150", "se_story_150_sword07", "")
			end

			local var_29_4 = 0
			local var_29_5 = 1.15

			if var_29_4 < arg_26_1.time_ and arg_26_1.time_ <= var_29_4 + arg_29_0 then
				arg_26_1.talkMaxDuration = 0
				arg_26_1.dialogCg_.alpha = 1

				arg_26_1.dialog_:SetActive(true)
				SetActive(arg_26_1.leftNameGo_, false)

				arg_26_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_26_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_26_1:RecordName(arg_26_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_26_1.iconTrs_.gameObject, false)
				arg_26_1.callingController_:SetSelectedState("normal")

				local var_29_6 = arg_26_1:GetWordFromCfg(325102006)
				local var_29_7 = arg_26_1:FormatText(var_29_6.content)

				arg_26_1.text_.text = var_29_7

				LuaForUtil.ClearLinePrefixSymbol(arg_26_1.text_)

				local var_29_8 = 46
				local var_29_9 = utf8.len(var_29_7)
				local var_29_10 = var_29_8 <= 0 and var_29_5 or var_29_5 * (var_29_9 / var_29_8)

				if var_29_10 > 0 and var_29_5 < var_29_10 then
					arg_26_1.talkMaxDuration = var_29_10

					if var_29_10 + var_29_4 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_10 + var_29_4
					end
				end

				arg_26_1.text_.text = var_29_7
				arg_26_1.typewritter.percent = 0

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(false)
				arg_26_1:RecordContent(arg_26_1.text_.text)
			end

			local var_29_11 = math.max(var_29_5, arg_26_1.talkMaxDuration)

			if var_29_4 <= arg_26_1.time_ and arg_26_1.time_ < var_29_4 + var_29_11 then
				arg_26_1.typewritter.percent = (arg_26_1.time_ - var_29_4) / var_29_11

				arg_26_1.typewritter:SetDirty()
			end

			if arg_26_1.time_ >= var_29_4 + var_29_11 and arg_26_1.time_ < var_29_4 + var_29_11 + arg_29_0 then
				arg_26_1.typewritter.percent = 1

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(true)
			end
		end

		arg_26_1.nodeConfigList_ = {}

		arg_26_1:InitPlayNodeList()
	end,
	Play325102007 = function(arg_30_0, arg_30_1)
		arg_30_1.time_ = 0
		arg_30_1.frameCnt_ = 0
		arg_30_1.state_ = "playing"
		arg_30_1.curTalkId_ = 325102007
		arg_30_1.duration_ = 3.43

		local var_30_0 = {
			zh = 3.433,
			ja = 2.466
		}
		local var_30_1 = manager.audio:GetLocalizationFlag()

		if var_30_0[var_30_1] ~= nil then
			arg_30_1.duration_ = var_30_0[var_30_1]
		end

		SetActive(arg_30_1.tipsGo_, false)

		function arg_30_1.onSingleLineFinish_()
			arg_30_1.onSingleLineUpdate_ = nil
			arg_30_1.onSingleLineFinish_ = nil
			arg_30_1.state_ = "waiting"
		end

		function arg_30_1.playNext_(arg_32_0)
			if arg_32_0 == 1 then
				arg_30_0:Play325102008(arg_30_1)
			end
		end

		function arg_30_1.onSingleLineUpdate_(arg_33_0)
			local var_33_0 = 0
			local var_33_1 = 0.2

			if var_33_0 < arg_30_1.time_ and arg_30_1.time_ <= var_33_0 + arg_33_0 then
				arg_30_1.talkMaxDuration = 0
				arg_30_1.dialogCg_.alpha = 1

				arg_30_1.dialog_:SetActive(true)
				SetActive(arg_30_1.leftNameGo_, true)

				local var_33_2 = arg_30_1:FormatText(StoryNameCfg[1455].name)

				arg_30_1.leftNameTxt_.text = var_33_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_30_1.leftNameTxt_.transform)

				arg_30_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_30_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_30_1:RecordName(arg_30_1.leftNameTxt_.text)
				SetActive(arg_30_1.iconTrs_.gameObject, true)
				arg_30_1.iconController_:SetSelectedState("hero")

				arg_30_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_30_1.callingController_:SetSelectedState("normal")

				arg_30_1.keyicon_.color = Color.New(1, 1, 1)
				arg_30_1.icon_.color = Color.New(1, 1, 1)

				local var_33_3 = arg_30_1:GetWordFromCfg(325102007)
				local var_33_4 = arg_30_1:FormatText(var_33_3.content)

				arg_30_1.text_.text = var_33_4

				LuaForUtil.ClearLinePrefixSymbol(arg_30_1.text_)

				local var_33_5 = 8
				local var_33_6 = utf8.len(var_33_4)
				local var_33_7 = var_33_5 <= 0 and var_33_1 or var_33_1 * (var_33_6 / var_33_5)

				if var_33_7 > 0 and var_33_1 < var_33_7 then
					arg_30_1.talkMaxDuration = var_33_7

					if var_33_7 + var_33_0 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_7 + var_33_0
					end
				end

				arg_30_1.text_.text = var_33_4
				arg_30_1.typewritter.percent = 0

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325102", "325102007", "story_v_out_325102.awb") ~= 0 then
					local var_33_8 = manager.audio:GetVoiceLength("story_v_out_325102", "325102007", "story_v_out_325102.awb") / 1000

					if var_33_8 + var_33_0 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_8 + var_33_0
					end

					if var_33_3.prefab_name ~= "" and arg_30_1.actors_[var_33_3.prefab_name] ~= nil then
						local var_33_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_30_1.actors_[var_33_3.prefab_name].transform, "story_v_out_325102", "325102007", "story_v_out_325102.awb")

						arg_30_1:RecordAudio("325102007", var_33_9)
						arg_30_1:RecordAudio("325102007", var_33_9)
					else
						arg_30_1:AudioAction("play", "voice", "story_v_out_325102", "325102007", "story_v_out_325102.awb")
					end

					arg_30_1:RecordHistoryTalkVoice("story_v_out_325102", "325102007", "story_v_out_325102.awb")
				end

				arg_30_1:RecordContent(arg_30_1.text_.text)
			end

			local var_33_10 = math.max(var_33_1, arg_30_1.talkMaxDuration)

			if var_33_0 <= arg_30_1.time_ and arg_30_1.time_ < var_33_0 + var_33_10 then
				arg_30_1.typewritter.percent = (arg_30_1.time_ - var_33_0) / var_33_10

				arg_30_1.typewritter:SetDirty()
			end

			if arg_30_1.time_ >= var_33_0 + var_33_10 and arg_30_1.time_ < var_33_0 + var_33_10 + arg_33_0 then
				arg_30_1.typewritter.percent = 1

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(true)
			end
		end

		arg_30_1.nodeConfigList_ = {}

		arg_30_1:InitPlayNodeList()
	end,
	Play325102008 = function(arg_34_0, arg_34_1)
		arg_34_1.time_ = 0
		arg_34_1.frameCnt_ = 0
		arg_34_1.state_ = "playing"
		arg_34_1.curTalkId_ = 325102008
		arg_34_1.duration_ = 9.97

		local var_34_0 = {
			zh = 9.86633333333333,
			ja = 9.96633333333333
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
				arg_34_0:Play325102009(arg_34_1)
			end
		end

		function arg_34_1.onSingleLineUpdate_(arg_37_0)
			local var_37_0 = 2

			if var_37_0 < arg_34_1.time_ and arg_34_1.time_ <= var_37_0 + arg_37_0 then
				local var_37_1 = manager.ui.mainCamera.transform.localPosition
				local var_37_2 = Vector3.New(0, 0, 10) + Vector3.New(var_37_1.x, var_37_1.y, 0)
				local var_37_3 = arg_34_1.bgs_.J29g

				var_37_3.transform.localPosition = var_37_2
				var_37_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_37_4 = var_37_3:GetComponent("SpriteRenderer")

				if var_37_4 and var_37_4.sprite then
					local var_37_5 = (var_37_3.transform.localPosition - var_37_1).z
					local var_37_6 = manager.ui.mainCameraCom_
					local var_37_7 = 2 * var_37_5 * Mathf.Tan(var_37_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_37_8 = var_37_7 * var_37_6.aspect
					local var_37_9 = var_37_4.sprite.bounds.size.x
					local var_37_10 = var_37_4.sprite.bounds.size.y
					local var_37_11 = var_37_8 / var_37_9
					local var_37_12 = var_37_7 / var_37_10
					local var_37_13 = var_37_12 < var_37_11 and var_37_11 or var_37_12

					var_37_3.transform.localScale = Vector3.New(var_37_13, var_37_13, 0)
				end

				for iter_37_0, iter_37_1 in pairs(arg_34_1.bgs_) do
					if iter_37_0 ~= "J29g" then
						iter_37_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_37_14 = 0

			if var_37_14 < arg_34_1.time_ and arg_34_1.time_ <= var_37_14 + arg_37_0 then
				arg_34_1.allBtn_.enabled = false
			end

			local var_37_15 = 0.3

			if arg_34_1.time_ >= var_37_14 + var_37_15 and arg_34_1.time_ < var_37_14 + var_37_15 + arg_37_0 then
				arg_34_1.allBtn_.enabled = true
			end

			local var_37_16 = 0

			if var_37_16 < arg_34_1.time_ and arg_34_1.time_ <= var_37_16 + arg_37_0 then
				arg_34_1.mask_.enabled = true
				arg_34_1.mask_.raycastTarget = true

				arg_34_1:SetGaussion(false)
			end

			local var_37_17 = 2

			if var_37_16 <= arg_34_1.time_ and arg_34_1.time_ < var_37_16 + var_37_17 then
				local var_37_18 = (arg_34_1.time_ - var_37_16) / var_37_17
				local var_37_19 = Color.New(0, 0, 0)

				var_37_19.a = Mathf.Lerp(0, 1, var_37_18)
				arg_34_1.mask_.color = var_37_19
			end

			if arg_34_1.time_ >= var_37_16 + var_37_17 and arg_34_1.time_ < var_37_16 + var_37_17 + arg_37_0 then
				local var_37_20 = Color.New(0, 0, 0)

				var_37_20.a = 1
				arg_34_1.mask_.color = var_37_20
			end

			local var_37_21 = 2

			if var_37_21 < arg_34_1.time_ and arg_34_1.time_ <= var_37_21 + arg_37_0 then
				arg_34_1.mask_.enabled = true
				arg_34_1.mask_.raycastTarget = true

				arg_34_1:SetGaussion(false)
			end

			local var_37_22 = 2

			if var_37_21 <= arg_34_1.time_ and arg_34_1.time_ < var_37_21 + var_37_22 then
				local var_37_23 = (arg_34_1.time_ - var_37_21) / var_37_22
				local var_37_24 = Color.New(0, 0, 0)

				var_37_24.a = Mathf.Lerp(1, 0, var_37_23)
				arg_34_1.mask_.color = var_37_24
			end

			if arg_34_1.time_ >= var_37_21 + var_37_22 and arg_34_1.time_ < var_37_21 + var_37_22 + arg_37_0 then
				local var_37_25 = Color.New(0, 0, 0)
				local var_37_26 = 0

				arg_34_1.mask_.enabled = false
				var_37_25.a = var_37_26
				arg_34_1.mask_.color = var_37_25
			end

			local var_37_27 = arg_34_1.actors_["1077ui_story"].transform
			local var_37_28 = 3.4

			if var_37_28 < arg_34_1.time_ and arg_34_1.time_ <= var_37_28 + arg_37_0 then
				arg_34_1.var_.moveOldPos1077ui_story = var_37_27.localPosition

				local var_37_29 = GameObjectTools.GetOrAddComponent(var_37_27.gameObject, typeof(DynamicBoneHelper))

				if var_37_29 then
					var_37_29:EnableDynamicBone(false)
				end
			end

			local var_37_30 = 0.001

			if var_37_28 <= arg_34_1.time_ and arg_34_1.time_ < var_37_28 + var_37_30 then
				local var_37_31 = (arg_34_1.time_ - var_37_28) / var_37_30
				local var_37_32 = Vector3.New(-0.03, -1.02, -5.92)

				var_37_27.localPosition = Vector3.Lerp(arg_34_1.var_.moveOldPos1077ui_story, var_37_32, var_37_31)

				local var_37_33 = manager.ui.mainCamera.transform.position - var_37_27.position

				var_37_27.forward = Vector3.New(var_37_33.x, var_37_33.y, var_37_33.z)

				local var_37_34 = var_37_27.localEulerAngles

				var_37_34.z = 0
				var_37_34.x = 0
				var_37_27.localEulerAngles = var_37_34
			end

			if arg_34_1.time_ >= var_37_28 + var_37_30 and arg_34_1.time_ < var_37_28 + var_37_30 + arg_37_0 then
				var_37_27.localPosition = Vector3.New(-0.03, -1.02, -5.92)

				local var_37_35 = manager.ui.mainCamera.transform.position - var_37_27.position

				var_37_27.forward = Vector3.New(var_37_35.x, var_37_35.y, var_37_35.z)

				local var_37_36 = var_37_27.localEulerAngles

				var_37_36.z = 0
				var_37_36.x = 0
				var_37_27.localEulerAngles = var_37_36

				local var_37_37 = GameObjectTools.GetOrAddComponent(var_37_27.gameObject, typeof(DynamicBoneHelper))

				if var_37_37 then
					var_37_37:EnableDynamicBone(true)
				end
			end

			local var_37_38 = arg_34_1.actors_["1077ui_story"]
			local var_37_39 = 3.4

			if var_37_39 < arg_34_1.time_ and arg_34_1.time_ <= var_37_39 + arg_37_0 and not isNil(var_37_38) and arg_34_1.var_.characterEffect1077ui_story == nil then
				arg_34_1.var_.characterEffect1077ui_story = var_37_38:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_37_40 = 0.200000002980232

			if var_37_39 <= arg_34_1.time_ and arg_34_1.time_ < var_37_39 + var_37_40 and not isNil(var_37_38) then
				local var_37_41 = (arg_34_1.time_ - var_37_39) / var_37_40

				if arg_34_1.var_.characterEffect1077ui_story and not isNil(var_37_38) then
					arg_34_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_34_1.time_ >= var_37_39 + var_37_40 and arg_34_1.time_ < var_37_39 + var_37_40 + arg_37_0 and not isNil(var_37_38) and arg_34_1.var_.characterEffect1077ui_story then
				arg_34_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_37_42 = 3.43400000184774

			if var_37_42 < arg_34_1.time_ and arg_34_1.time_ <= var_37_42 + arg_37_0 then
				arg_34_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action7_1")
			end

			local var_37_43 = 0

			if var_37_43 < arg_34_1.time_ and arg_34_1.time_ <= var_37_43 + arg_37_0 then
				arg_34_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_37_44 = 3.43400000184774

			if var_37_44 < arg_34_1.time_ and arg_34_1.time_ <= var_37_44 + arg_37_0 then
				arg_34_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			if arg_34_1.frameCnt_ <= 1 then
				arg_34_1.dialog_:SetActive(false)
			end

			local var_37_45 = 3.73333333333333
			local var_37_46 = 0.725

			if var_37_45 < arg_34_1.time_ and arg_34_1.time_ <= var_37_45 + arg_37_0 then
				arg_34_1.talkMaxDuration = 0

				arg_34_1.dialog_:SetActive(true)

				arg_34_1.dialogCg_.alpha = 0

				local var_37_47 = LeanTween.value(arg_34_1.dialog_, 0, 1, 0.3)

				var_37_47:setOnUpdate(LuaHelper.FloatAction(function(arg_38_0)
					arg_34_1.dialogCg_.alpha = arg_38_0
				end))
				var_37_47:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_34_1.dialog_)
					var_37_47:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_34_1.duration_ = arg_34_1.duration_ + 0.3

				SetActive(arg_34_1.leftNameGo_, true)

				local var_37_48 = arg_34_1:FormatText(StoryNameCfg[1467].name)

				arg_34_1.leftNameTxt_.text = var_37_48

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_34_1.leftNameTxt_.transform)

				arg_34_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_34_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_34_1:RecordName(arg_34_1.leftNameTxt_.text)
				SetActive(arg_34_1.iconTrs_.gameObject, false)
				arg_34_1.callingController_:SetSelectedState("normal")

				local var_37_49 = arg_34_1:GetWordFromCfg(325102008)
				local var_37_50 = arg_34_1:FormatText(var_37_49.content)

				arg_34_1.text_.text = var_37_50

				LuaForUtil.ClearLinePrefixSymbol(arg_34_1.text_)

				local var_37_51 = 29
				local var_37_52 = utf8.len(var_37_50)
				local var_37_53 = var_37_51 <= 0 and var_37_46 or var_37_46 * (var_37_52 / var_37_51)

				if var_37_53 > 0 and var_37_46 < var_37_53 then
					arg_34_1.talkMaxDuration = var_37_53
					var_37_45 = var_37_45 + 0.3

					if var_37_53 + var_37_45 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_53 + var_37_45
					end
				end

				arg_34_1.text_.text = var_37_50
				arg_34_1.typewritter.percent = 0

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325102", "325102008", "story_v_out_325102.awb") ~= 0 then
					local var_37_54 = manager.audio:GetVoiceLength("story_v_out_325102", "325102008", "story_v_out_325102.awb") / 1000

					if var_37_54 + var_37_45 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_54 + var_37_45
					end

					if var_37_49.prefab_name ~= "" and arg_34_1.actors_[var_37_49.prefab_name] ~= nil then
						local var_37_55 = LuaForUtil.PlayVoiceWithCriLipsync(arg_34_1.actors_[var_37_49.prefab_name].transform, "story_v_out_325102", "325102008", "story_v_out_325102.awb")

						arg_34_1:RecordAudio("325102008", var_37_55)
						arg_34_1:RecordAudio("325102008", var_37_55)
					else
						arg_34_1:AudioAction("play", "voice", "story_v_out_325102", "325102008", "story_v_out_325102.awb")
					end

					arg_34_1:RecordHistoryTalkVoice("story_v_out_325102", "325102008", "story_v_out_325102.awb")
				end

				arg_34_1:RecordContent(arg_34_1.text_.text)
			end

			local var_37_56 = var_37_45 + 0.3
			local var_37_57 = math.max(var_37_46, arg_34_1.talkMaxDuration)

			if var_37_56 <= arg_34_1.time_ and arg_34_1.time_ < var_37_56 + var_37_57 then
				arg_34_1.typewritter.percent = (arg_34_1.time_ - var_37_56) / var_37_57

				arg_34_1.typewritter:SetDirty()
			end

			if arg_34_1.time_ >= var_37_56 + var_37_57 and arg_34_1.time_ < var_37_56 + var_37_57 + arg_37_0 then
				arg_34_1.typewritter.percent = 1

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(true)
			end
		end

		arg_34_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.4,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_34_1:InitPlayNodeList()
	end,
	Play325102009 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 325102009
		arg_40_1.duration_ = 3.97

		local var_40_0 = {
			zh = 2.3,
			ja = 3.966
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
				arg_40_0:Play325102010(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = 0
			local var_43_1 = 0.175

			if var_43_0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_0 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				local var_43_2 = arg_40_1:FormatText(StoryNameCfg[1467].name)

				arg_40_1.leftNameTxt_.text = var_43_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_3 = arg_40_1:GetWordFromCfg(325102009)
				local var_43_4 = arg_40_1:FormatText(var_43_3.content)

				arg_40_1.text_.text = var_43_4

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_5 = 7
				local var_43_6 = utf8.len(var_43_4)
				local var_43_7 = var_43_5 <= 0 and var_43_1 or var_43_1 * (var_43_6 / var_43_5)

				if var_43_7 > 0 and var_43_1 < var_43_7 then
					arg_40_1.talkMaxDuration = var_43_7

					if var_43_7 + var_43_0 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_7 + var_43_0
					end
				end

				arg_40_1.text_.text = var_43_4
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325102", "325102009", "story_v_out_325102.awb") ~= 0 then
					local var_43_8 = manager.audio:GetVoiceLength("story_v_out_325102", "325102009", "story_v_out_325102.awb") / 1000

					if var_43_8 + var_43_0 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_8 + var_43_0
					end

					if var_43_3.prefab_name ~= "" and arg_40_1.actors_[var_43_3.prefab_name] ~= nil then
						local var_43_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_3.prefab_name].transform, "story_v_out_325102", "325102009", "story_v_out_325102.awb")

						arg_40_1:RecordAudio("325102009", var_43_9)
						arg_40_1:RecordAudio("325102009", var_43_9)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_325102", "325102009", "story_v_out_325102.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_325102", "325102009", "story_v_out_325102.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_10 = math.max(var_43_1, arg_40_1.talkMaxDuration)

			if var_43_0 <= arg_40_1.time_ and arg_40_1.time_ < var_43_0 + var_43_10 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_0) / var_43_10

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_0 + var_43_10 and arg_40_1.time_ < var_43_0 + var_43_10 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play325102010 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 325102010
		arg_44_1.duration_ = 5

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play325102011(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = arg_44_1.actors_["1077ui_story"].transform
			local var_47_1 = 0

			if var_47_1 < arg_44_1.time_ and arg_44_1.time_ <= var_47_1 + arg_47_0 then
				arg_44_1.var_.moveOldPos1077ui_story = var_47_0.localPosition

				local var_47_2 = GameObjectTools.GetOrAddComponent(var_47_0.gameObject, typeof(DynamicBoneHelper))

				if var_47_2 then
					var_47_2:EnableDynamicBone(false)
				end
			end

			local var_47_3 = 0.001

			if var_47_1 <= arg_44_1.time_ and arg_44_1.time_ < var_47_1 + var_47_3 then
				local var_47_4 = (arg_44_1.time_ - var_47_1) / var_47_3
				local var_47_5 = Vector3.New(0, 100, 0)

				var_47_0.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos1077ui_story, var_47_5, var_47_4)

				local var_47_6 = manager.ui.mainCamera.transform.position - var_47_0.position

				var_47_0.forward = Vector3.New(var_47_6.x, var_47_6.y, var_47_6.z)

				local var_47_7 = var_47_0.localEulerAngles

				var_47_7.z = 0
				var_47_7.x = 0
				var_47_0.localEulerAngles = var_47_7
			end

			if arg_44_1.time_ >= var_47_1 + var_47_3 and arg_44_1.time_ < var_47_1 + var_47_3 + arg_47_0 then
				var_47_0.localPosition = Vector3.New(0, 100, 0)

				local var_47_8 = manager.ui.mainCamera.transform.position - var_47_0.position

				var_47_0.forward = Vector3.New(var_47_8.x, var_47_8.y, var_47_8.z)

				local var_47_9 = var_47_0.localEulerAngles

				var_47_9.z = 0
				var_47_9.x = 0
				var_47_0.localEulerAngles = var_47_9

				local var_47_10 = GameObjectTools.GetOrAddComponent(var_47_0.gameObject, typeof(DynamicBoneHelper))

				if var_47_10 then
					var_47_10:EnableDynamicBone(true)
				end
			end

			local var_47_11 = arg_44_1.actors_["1077ui_story"]
			local var_47_12 = 0

			if var_47_12 < arg_44_1.time_ and arg_44_1.time_ <= var_47_12 + arg_47_0 and not isNil(var_47_11) and arg_44_1.var_.characterEffect1077ui_story == nil then
				arg_44_1.var_.characterEffect1077ui_story = var_47_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_13 = 0.200000002980232

			if var_47_12 <= arg_44_1.time_ and arg_44_1.time_ < var_47_12 + var_47_13 and not isNil(var_47_11) then
				local var_47_14 = (arg_44_1.time_ - var_47_12) / var_47_13

				if arg_44_1.var_.characterEffect1077ui_story and not isNil(var_47_11) then
					local var_47_15 = Mathf.Lerp(0, 0.5, var_47_14)

					arg_44_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_44_1.var_.characterEffect1077ui_story.fillRatio = var_47_15
				end
			end

			if arg_44_1.time_ >= var_47_12 + var_47_13 and arg_44_1.time_ < var_47_12 + var_47_13 + arg_47_0 and not isNil(var_47_11) and arg_44_1.var_.characterEffect1077ui_story then
				local var_47_16 = 0.5

				arg_44_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_44_1.var_.characterEffect1077ui_story.fillRatio = var_47_16
			end

			local var_47_17 = 0.5
			local var_47_18 = 1

			if var_47_17 < arg_44_1.time_ and arg_44_1.time_ <= var_47_17 + arg_47_0 then
				local var_47_19 = "play"
				local var_47_20 = "effect"

				arg_44_1:AudioAction(var_47_19, var_47_20, "se_story_122_03", "se_story_122_03_laser", "")
			end

			local var_47_21 = 0
			local var_47_22 = 1.1

			if var_47_21 < arg_44_1.time_ and arg_44_1.time_ <= var_47_21 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, false)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_23 = arg_44_1:GetWordFromCfg(325102010)
				local var_47_24 = arg_44_1:FormatText(var_47_23.content)

				arg_44_1.text_.text = var_47_24

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_25 = 44
				local var_47_26 = utf8.len(var_47_24)
				local var_47_27 = var_47_25 <= 0 and var_47_22 or var_47_22 * (var_47_26 / var_47_25)

				if var_47_27 > 0 and var_47_22 < var_47_27 then
					arg_44_1.talkMaxDuration = var_47_27

					if var_47_27 + var_47_21 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_27 + var_47_21
					end
				end

				arg_44_1.text_.text = var_47_24
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)
				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_28 = math.max(var_47_22, arg_44_1.talkMaxDuration)

			if var_47_21 <= arg_44_1.time_ and arg_44_1.time_ < var_47_21 + var_47_28 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_21) / var_47_28

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_21 + var_47_28 and arg_44_1.time_ < var_47_21 + var_47_28 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
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
	Play325102011 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 325102011
		arg_48_1.duration_ = 8.13

		local var_48_0 = {
			zh = 5.7,
			ja = 8.133
		}
		local var_48_1 = manager.audio:GetLocalizationFlag()

		if var_48_0[var_48_1] ~= nil then
			arg_48_1.duration_ = var_48_0[var_48_1]
		end

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play325102012(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = 0
			local var_51_1 = 0.5

			if var_51_0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_0 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				local var_51_2 = arg_48_1:FormatText(StoryNameCfg[1455].name)

				arg_48_1.leftNameTxt_.text = var_51_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, true)
				arg_48_1.iconController_:SetSelectedState("hero")

				arg_48_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_48_1.callingController_:SetSelectedState("normal")

				arg_48_1.keyicon_.color = Color.New(1, 1, 1)
				arg_48_1.icon_.color = Color.New(1, 1, 1)

				local var_51_3 = arg_48_1:GetWordFromCfg(325102011)
				local var_51_4 = arg_48_1:FormatText(var_51_3.content)

				arg_48_1.text_.text = var_51_4

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_5 = 20
				local var_51_6 = utf8.len(var_51_4)
				local var_51_7 = var_51_5 <= 0 and var_51_1 or var_51_1 * (var_51_6 / var_51_5)

				if var_51_7 > 0 and var_51_1 < var_51_7 then
					arg_48_1.talkMaxDuration = var_51_7

					if var_51_7 + var_51_0 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_7 + var_51_0
					end
				end

				arg_48_1.text_.text = var_51_4
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325102", "325102011", "story_v_out_325102.awb") ~= 0 then
					local var_51_8 = manager.audio:GetVoiceLength("story_v_out_325102", "325102011", "story_v_out_325102.awb") / 1000

					if var_51_8 + var_51_0 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_8 + var_51_0
					end

					if var_51_3.prefab_name ~= "" and arg_48_1.actors_[var_51_3.prefab_name] ~= nil then
						local var_51_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_3.prefab_name].transform, "story_v_out_325102", "325102011", "story_v_out_325102.awb")

						arg_48_1:RecordAudio("325102011", var_51_9)
						arg_48_1:RecordAudio("325102011", var_51_9)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_325102", "325102011", "story_v_out_325102.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_325102", "325102011", "story_v_out_325102.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_10 = math.max(var_51_1, arg_48_1.talkMaxDuration)

			if var_51_0 <= arg_48_1.time_ and arg_48_1.time_ < var_51_0 + var_51_10 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_0) / var_51_10

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_0 + var_51_10 and arg_48_1.time_ < var_51_0 + var_51_10 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play325102012 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 325102012
		arg_52_1.duration_ = 5.87

		local var_52_0 = {
			zh = 2.5,
			ja = 5.866
		}
		local var_52_1 = manager.audio:GetLocalizationFlag()

		if var_52_0[var_52_1] ~= nil then
			arg_52_1.duration_ = var_52_0[var_52_1]
		end

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play325102013(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = arg_52_1.actors_["1077ui_story"].transform
			local var_55_1 = 0

			if var_55_1 < arg_52_1.time_ and arg_52_1.time_ <= var_55_1 + arg_55_0 then
				arg_52_1.var_.moveOldPos1077ui_story = var_55_0.localPosition

				local var_55_2 = GameObjectTools.GetOrAddComponent(var_55_0.gameObject, typeof(DynamicBoneHelper))

				if var_55_2 then
					var_55_2:EnableDynamicBone(false)
				end
			end

			local var_55_3 = 0.001

			if var_55_1 <= arg_52_1.time_ and arg_52_1.time_ < var_55_1 + var_55_3 then
				local var_55_4 = (arg_52_1.time_ - var_55_1) / var_55_3
				local var_55_5 = Vector3.New(-0.03, -1.02, -5.92)

				var_55_0.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPos1077ui_story, var_55_5, var_55_4)

				local var_55_6 = manager.ui.mainCamera.transform.position - var_55_0.position

				var_55_0.forward = Vector3.New(var_55_6.x, var_55_6.y, var_55_6.z)

				local var_55_7 = var_55_0.localEulerAngles

				var_55_7.z = 0
				var_55_7.x = 0
				var_55_0.localEulerAngles = var_55_7
			end

			if arg_52_1.time_ >= var_55_1 + var_55_3 and arg_52_1.time_ < var_55_1 + var_55_3 + arg_55_0 then
				var_55_0.localPosition = Vector3.New(-0.03, -1.02, -5.92)

				local var_55_8 = manager.ui.mainCamera.transform.position - var_55_0.position

				var_55_0.forward = Vector3.New(var_55_8.x, var_55_8.y, var_55_8.z)

				local var_55_9 = var_55_0.localEulerAngles

				var_55_9.z = 0
				var_55_9.x = 0
				var_55_0.localEulerAngles = var_55_9

				local var_55_10 = GameObjectTools.GetOrAddComponent(var_55_0.gameObject, typeof(DynamicBoneHelper))

				if var_55_10 then
					var_55_10:EnableDynamicBone(true)
				end
			end

			local var_55_11 = arg_52_1.actors_["1077ui_story"]
			local var_55_12 = 0

			if var_55_12 < arg_52_1.time_ and arg_52_1.time_ <= var_55_12 + arg_55_0 and not isNil(var_55_11) and arg_52_1.var_.characterEffect1077ui_story == nil then
				arg_52_1.var_.characterEffect1077ui_story = var_55_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_13 = 0.200000002980232

			if var_55_12 <= arg_52_1.time_ and arg_52_1.time_ < var_55_12 + var_55_13 and not isNil(var_55_11) then
				local var_55_14 = (arg_52_1.time_ - var_55_12) / var_55_13

				if arg_52_1.var_.characterEffect1077ui_story and not isNil(var_55_11) then
					arg_52_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_52_1.time_ >= var_55_12 + var_55_13 and arg_52_1.time_ < var_55_12 + var_55_13 + arg_55_0 and not isNil(var_55_11) and arg_52_1.var_.characterEffect1077ui_story then
				arg_52_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_55_15 = 0

			if var_55_15 < arg_52_1.time_ and arg_52_1.time_ <= var_55_15 + arg_55_0 then
				arg_52_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action7_2")
			end

			local var_55_16 = 0

			if var_55_16 < arg_52_1.time_ and arg_52_1.time_ <= var_55_16 + arg_55_0 then
				arg_52_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_55_17 = 0
			local var_55_18 = 0.35

			if var_55_17 < arg_52_1.time_ and arg_52_1.time_ <= var_55_17 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				local var_55_19 = arg_52_1:FormatText(StoryNameCfg[1467].name)

				arg_52_1.leftNameTxt_.text = var_55_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_20 = arg_52_1:GetWordFromCfg(325102012)
				local var_55_21 = arg_52_1:FormatText(var_55_20.content)

				arg_52_1.text_.text = var_55_21

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_22 = 14
				local var_55_23 = utf8.len(var_55_21)
				local var_55_24 = var_55_22 <= 0 and var_55_18 or var_55_18 * (var_55_23 / var_55_22)

				if var_55_24 > 0 and var_55_18 < var_55_24 then
					arg_52_1.talkMaxDuration = var_55_24

					if var_55_24 + var_55_17 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_24 + var_55_17
					end
				end

				arg_52_1.text_.text = var_55_21
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325102", "325102012", "story_v_out_325102.awb") ~= 0 then
					local var_55_25 = manager.audio:GetVoiceLength("story_v_out_325102", "325102012", "story_v_out_325102.awb") / 1000

					if var_55_25 + var_55_17 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_25 + var_55_17
					end

					if var_55_20.prefab_name ~= "" and arg_52_1.actors_[var_55_20.prefab_name] ~= nil then
						local var_55_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_20.prefab_name].transform, "story_v_out_325102", "325102012", "story_v_out_325102.awb")

						arg_52_1:RecordAudio("325102012", var_55_26)
						arg_52_1:RecordAudio("325102012", var_55_26)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_325102", "325102012", "story_v_out_325102.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_325102", "325102012", "story_v_out_325102.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_27 = math.max(var_55_18, arg_52_1.talkMaxDuration)

			if var_55_17 <= arg_52_1.time_ and arg_52_1.time_ < var_55_17 + var_55_27 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_17) / var_55_27

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_17 + var_55_27 and arg_52_1.time_ < var_55_17 + var_55_27 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_52_1:InitPlayNodeList()
	end,
	Play325102013 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 325102013
		arg_56_1.duration_ = 5.4

		local var_56_0 = {
			zh = 4.066,
			ja = 5.4
		}
		local var_56_1 = manager.audio:GetLocalizationFlag()

		if var_56_0[var_56_1] ~= nil then
			arg_56_1.duration_ = var_56_0[var_56_1]
		end

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play325102014(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = arg_56_1.actors_["1077ui_story"]
			local var_59_1 = 0

			if var_59_1 < arg_56_1.time_ and arg_56_1.time_ <= var_59_1 + arg_59_0 and not isNil(var_59_0) and arg_56_1.var_.characterEffect1077ui_story == nil then
				arg_56_1.var_.characterEffect1077ui_story = var_59_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_2 = 0.200000002980232

			if var_59_1 <= arg_56_1.time_ and arg_56_1.time_ < var_59_1 + var_59_2 and not isNil(var_59_0) then
				local var_59_3 = (arg_56_1.time_ - var_59_1) / var_59_2

				if arg_56_1.var_.characterEffect1077ui_story and not isNil(var_59_0) then
					local var_59_4 = Mathf.Lerp(0, 0.5, var_59_3)

					arg_56_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_56_1.var_.characterEffect1077ui_story.fillRatio = var_59_4
				end
			end

			if arg_56_1.time_ >= var_59_1 + var_59_2 and arg_56_1.time_ < var_59_1 + var_59_2 + arg_59_0 and not isNil(var_59_0) and arg_56_1.var_.characterEffect1077ui_story then
				local var_59_5 = 0.5

				arg_56_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_56_1.var_.characterEffect1077ui_story.fillRatio = var_59_5
			end

			local var_59_6 = 0
			local var_59_7 = 0.475

			if var_59_6 < arg_56_1.time_ and arg_56_1.time_ <= var_59_6 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				local var_59_8 = arg_56_1:FormatText(StoryNameCfg[1455].name)

				arg_56_1.leftNameTxt_.text = var_59_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, true)
				arg_56_1.iconController_:SetSelectedState("hero")

				arg_56_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_56_1.callingController_:SetSelectedState("normal")

				arg_56_1.keyicon_.color = Color.New(1, 1, 1)
				arg_56_1.icon_.color = Color.New(1, 1, 1)

				local var_59_9 = arg_56_1:GetWordFromCfg(325102013)
				local var_59_10 = arg_56_1:FormatText(var_59_9.content)

				arg_56_1.text_.text = var_59_10

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_11 = 19
				local var_59_12 = utf8.len(var_59_10)
				local var_59_13 = var_59_11 <= 0 and var_59_7 or var_59_7 * (var_59_12 / var_59_11)

				if var_59_13 > 0 and var_59_7 < var_59_13 then
					arg_56_1.talkMaxDuration = var_59_13

					if var_59_13 + var_59_6 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_13 + var_59_6
					end
				end

				arg_56_1.text_.text = var_59_10
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325102", "325102013", "story_v_out_325102.awb") ~= 0 then
					local var_59_14 = manager.audio:GetVoiceLength("story_v_out_325102", "325102013", "story_v_out_325102.awb") / 1000

					if var_59_14 + var_59_6 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_14 + var_59_6
					end

					if var_59_9.prefab_name ~= "" and arg_56_1.actors_[var_59_9.prefab_name] ~= nil then
						local var_59_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_9.prefab_name].transform, "story_v_out_325102", "325102013", "story_v_out_325102.awb")

						arg_56_1:RecordAudio("325102013", var_59_15)
						arg_56_1:RecordAudio("325102013", var_59_15)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_325102", "325102013", "story_v_out_325102.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_325102", "325102013", "story_v_out_325102.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_16 = math.max(var_59_7, arg_56_1.talkMaxDuration)

			if var_59_6 <= arg_56_1.time_ and arg_56_1.time_ < var_59_6 + var_59_16 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_6) / var_59_16

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_6 + var_59_16 and arg_56_1.time_ < var_59_6 + var_59_16 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play325102014 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 325102014
		arg_60_1.duration_ = 2.47

		local var_60_0 = {
			zh = 2.2,
			ja = 2.466
		}
		local var_60_1 = manager.audio:GetLocalizationFlag()

		if var_60_0[var_60_1] ~= nil then
			arg_60_1.duration_ = var_60_0[var_60_1]
		end

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play325102015(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = arg_60_1.actors_["1077ui_story"]
			local var_63_1 = 0

			if var_63_1 < arg_60_1.time_ and arg_60_1.time_ <= var_63_1 + arg_63_0 and not isNil(var_63_0) and arg_60_1.var_.characterEffect1077ui_story == nil then
				arg_60_1.var_.characterEffect1077ui_story = var_63_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_2 = 0.200000002980232

			if var_63_1 <= arg_60_1.time_ and arg_60_1.time_ < var_63_1 + var_63_2 and not isNil(var_63_0) then
				local var_63_3 = (arg_60_1.time_ - var_63_1) / var_63_2

				if arg_60_1.var_.characterEffect1077ui_story and not isNil(var_63_0) then
					arg_60_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_60_1.time_ >= var_63_1 + var_63_2 and arg_60_1.time_ < var_63_1 + var_63_2 + arg_63_0 and not isNil(var_63_0) and arg_60_1.var_.characterEffect1077ui_story then
				arg_60_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_63_4 = 0
			local var_63_5 = 0.3

			if var_63_4 < arg_60_1.time_ and arg_60_1.time_ <= var_63_4 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				local var_63_6 = arg_60_1:FormatText(StoryNameCfg[1467].name)

				arg_60_1.leftNameTxt_.text = var_63_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_7 = arg_60_1:GetWordFromCfg(325102014)
				local var_63_8 = arg_60_1:FormatText(var_63_7.content)

				arg_60_1.text_.text = var_63_8

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_9 = 12
				local var_63_10 = utf8.len(var_63_8)
				local var_63_11 = var_63_9 <= 0 and var_63_5 or var_63_5 * (var_63_10 / var_63_9)

				if var_63_11 > 0 and var_63_5 < var_63_11 then
					arg_60_1.talkMaxDuration = var_63_11

					if var_63_11 + var_63_4 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_11 + var_63_4
					end
				end

				arg_60_1.text_.text = var_63_8
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325102", "325102014", "story_v_out_325102.awb") ~= 0 then
					local var_63_12 = manager.audio:GetVoiceLength("story_v_out_325102", "325102014", "story_v_out_325102.awb") / 1000

					if var_63_12 + var_63_4 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_12 + var_63_4
					end

					if var_63_7.prefab_name ~= "" and arg_60_1.actors_[var_63_7.prefab_name] ~= nil then
						local var_63_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_7.prefab_name].transform, "story_v_out_325102", "325102014", "story_v_out_325102.awb")

						arg_60_1:RecordAudio("325102014", var_63_13)
						arg_60_1:RecordAudio("325102014", var_63_13)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_325102", "325102014", "story_v_out_325102.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_325102", "325102014", "story_v_out_325102.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_14 = math.max(var_63_5, arg_60_1.talkMaxDuration)

			if var_63_4 <= arg_60_1.time_ and arg_60_1.time_ < var_63_4 + var_63_14 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_4) / var_63_14

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_4 + var_63_14 and arg_60_1.time_ < var_63_4 + var_63_14 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play325102015 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 325102015
		arg_64_1.duration_ = 5

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play325102016(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = arg_64_1.actors_["1059ui_story"].transform
			local var_67_1 = 0

			if var_67_1 < arg_64_1.time_ and arg_64_1.time_ <= var_67_1 + arg_67_0 then
				arg_64_1.var_.moveOldPos1059ui_story = var_67_0.localPosition
			end

			local var_67_2 = 0.001

			if var_67_1 <= arg_64_1.time_ and arg_64_1.time_ < var_67_1 + var_67_2 then
				local var_67_3 = (arg_64_1.time_ - var_67_1) / var_67_2
				local var_67_4 = Vector3.New(0, 100, 0)

				var_67_0.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos1059ui_story, var_67_4, var_67_3)

				local var_67_5 = manager.ui.mainCamera.transform.position - var_67_0.position

				var_67_0.forward = Vector3.New(var_67_5.x, var_67_5.y, var_67_5.z)

				local var_67_6 = var_67_0.localEulerAngles

				var_67_6.z = 0
				var_67_6.x = 0
				var_67_0.localEulerAngles = var_67_6
			end

			if arg_64_1.time_ >= var_67_1 + var_67_2 and arg_64_1.time_ < var_67_1 + var_67_2 + arg_67_0 then
				var_67_0.localPosition = Vector3.New(0, 100, 0)

				local var_67_7 = manager.ui.mainCamera.transform.position - var_67_0.position

				var_67_0.forward = Vector3.New(var_67_7.x, var_67_7.y, var_67_7.z)

				local var_67_8 = var_67_0.localEulerAngles

				var_67_8.z = 0
				var_67_8.x = 0
				var_67_0.localEulerAngles = var_67_8
			end

			local var_67_9 = arg_64_1.actors_["1077ui_story"].transform
			local var_67_10 = 0

			if var_67_10 < arg_64_1.time_ and arg_64_1.time_ <= var_67_10 + arg_67_0 then
				arg_64_1.var_.moveOldPos1077ui_story = var_67_9.localPosition

				local var_67_11 = GameObjectTools.GetOrAddComponent(var_67_9.gameObject, typeof(DynamicBoneHelper))

				if var_67_11 then
					var_67_11:EnableDynamicBone(false)
				end
			end

			local var_67_12 = 0.001

			if var_67_10 <= arg_64_1.time_ and arg_64_1.time_ < var_67_10 + var_67_12 then
				local var_67_13 = (arg_64_1.time_ - var_67_10) / var_67_12
				local var_67_14 = Vector3.New(0, 100, 0)

				var_67_9.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos1077ui_story, var_67_14, var_67_13)

				local var_67_15 = manager.ui.mainCamera.transform.position - var_67_9.position

				var_67_9.forward = Vector3.New(var_67_15.x, var_67_15.y, var_67_15.z)

				local var_67_16 = var_67_9.localEulerAngles

				var_67_16.z = 0
				var_67_16.x = 0
				var_67_9.localEulerAngles = var_67_16
			end

			if arg_64_1.time_ >= var_67_10 + var_67_12 and arg_64_1.time_ < var_67_10 + var_67_12 + arg_67_0 then
				var_67_9.localPosition = Vector3.New(0, 100, 0)

				local var_67_17 = manager.ui.mainCamera.transform.position - var_67_9.position

				var_67_9.forward = Vector3.New(var_67_17.x, var_67_17.y, var_67_17.z)

				local var_67_18 = var_67_9.localEulerAngles

				var_67_18.z = 0
				var_67_18.x = 0
				var_67_9.localEulerAngles = var_67_18

				local var_67_19 = GameObjectTools.GetOrAddComponent(var_67_9.gameObject, typeof(DynamicBoneHelper))

				if var_67_19 then
					var_67_19:EnableDynamicBone(true)
				end
			end

			local var_67_20 = arg_64_1.actors_["1077ui_story"]
			local var_67_21 = 0

			if var_67_21 < arg_64_1.time_ and arg_64_1.time_ <= var_67_21 + arg_67_0 and not isNil(var_67_20) and arg_64_1.var_.characterEffect1077ui_story == nil then
				arg_64_1.var_.characterEffect1077ui_story = var_67_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_22 = 0.200000002980232

			if var_67_21 <= arg_64_1.time_ and arg_64_1.time_ < var_67_21 + var_67_22 and not isNil(var_67_20) then
				local var_67_23 = (arg_64_1.time_ - var_67_21) / var_67_22

				if arg_64_1.var_.characterEffect1077ui_story and not isNil(var_67_20) then
					local var_67_24 = Mathf.Lerp(0, 0.5, var_67_23)

					arg_64_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_64_1.var_.characterEffect1077ui_story.fillRatio = var_67_24
				end
			end

			if arg_64_1.time_ >= var_67_21 + var_67_22 and arg_64_1.time_ < var_67_21 + var_67_22 + arg_67_0 and not isNil(var_67_20) and arg_64_1.var_.characterEffect1077ui_story then
				local var_67_25 = 0.5

				arg_64_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_64_1.var_.characterEffect1077ui_story.fillRatio = var_67_25
			end

			local var_67_26 = 0
			local var_67_27 = 1.125

			if var_67_26 < arg_64_1.time_ and arg_64_1.time_ <= var_67_26 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, false)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_28 = arg_64_1:GetWordFromCfg(325102015)
				local var_67_29 = arg_64_1:FormatText(var_67_28.content)

				arg_64_1.text_.text = var_67_29

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_30 = 45
				local var_67_31 = utf8.len(var_67_29)
				local var_67_32 = var_67_30 <= 0 and var_67_27 or var_67_27 * (var_67_31 / var_67_30)

				if var_67_32 > 0 and var_67_27 < var_67_32 then
					arg_64_1.talkMaxDuration = var_67_32

					if var_67_32 + var_67_26 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_32 + var_67_26
					end
				end

				arg_64_1.text_.text = var_67_29
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)
				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_33 = math.max(var_67_27, arg_64_1.talkMaxDuration)

			if var_67_26 <= arg_64_1.time_ and arg_64_1.time_ < var_67_26 + var_67_33 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_26) / var_67_33

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_26 + var_67_33 and arg_64_1.time_ < var_67_26 + var_67_33 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_64_1:InitPlayNodeList()
	end,
	Play325102016 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 325102016
		arg_68_1.duration_ = 4.23

		local var_68_0 = {
			zh = 4.233,
			ja = 4.166
		}
		local var_68_1 = manager.audio:GetLocalizationFlag()

		if var_68_0[var_68_1] ~= nil then
			arg_68_1.duration_ = var_68_0[var_68_1]
		end

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"
		end

		function arg_68_1.playNext_(arg_70_0)
			if arg_70_0 == 1 then
				arg_68_0:Play325102017(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = 0
			local var_71_1 = 0.475

			if var_71_0 < arg_68_1.time_ and arg_68_1.time_ <= var_71_0 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				local var_71_2 = arg_68_1:FormatText(StoryNameCfg[1455].name)

				arg_68_1.leftNameTxt_.text = var_71_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, true)
				arg_68_1.iconController_:SetSelectedState("hero")

				arg_68_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_68_1.callingController_:SetSelectedState("normal")

				arg_68_1.keyicon_.color = Color.New(1, 1, 1)
				arg_68_1.icon_.color = Color.New(1, 1, 1)

				local var_71_3 = arg_68_1:GetWordFromCfg(325102016)
				local var_71_4 = arg_68_1:FormatText(var_71_3.content)

				arg_68_1.text_.text = var_71_4

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_5 = 19
				local var_71_6 = utf8.len(var_71_4)
				local var_71_7 = var_71_5 <= 0 and var_71_1 or var_71_1 * (var_71_6 / var_71_5)

				if var_71_7 > 0 and var_71_1 < var_71_7 then
					arg_68_1.talkMaxDuration = var_71_7

					if var_71_7 + var_71_0 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_7 + var_71_0
					end
				end

				arg_68_1.text_.text = var_71_4
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325102", "325102016", "story_v_out_325102.awb") ~= 0 then
					local var_71_8 = manager.audio:GetVoiceLength("story_v_out_325102", "325102016", "story_v_out_325102.awb") / 1000

					if var_71_8 + var_71_0 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_8 + var_71_0
					end

					if var_71_3.prefab_name ~= "" and arg_68_1.actors_[var_71_3.prefab_name] ~= nil then
						local var_71_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_3.prefab_name].transform, "story_v_out_325102", "325102016", "story_v_out_325102.awb")

						arg_68_1:RecordAudio("325102016", var_71_9)
						arg_68_1:RecordAudio("325102016", var_71_9)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_325102", "325102016", "story_v_out_325102.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_325102", "325102016", "story_v_out_325102.awb")
				end

				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_10 = math.max(var_71_1, arg_68_1.talkMaxDuration)

			if var_71_0 <= arg_68_1.time_ and arg_68_1.time_ < var_71_0 + var_71_10 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_0) / var_71_10

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_0 + var_71_10 and arg_68_1.time_ < var_71_0 + var_71_10 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {}

		arg_68_1:InitPlayNodeList()
	end,
	Play325102017 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 325102017
		arg_72_1.duration_ = 9.87

		local var_72_0 = {
			zh = 4.2,
			ja = 9.866
		}
		local var_72_1 = manager.audio:GetLocalizationFlag()

		if var_72_0[var_72_1] ~= nil then
			arg_72_1.duration_ = var_72_0[var_72_1]
		end

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play325102018(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = arg_72_1.actors_["1077ui_story"].transform
			local var_75_1 = 0

			if var_75_1 < arg_72_1.time_ and arg_72_1.time_ <= var_75_1 + arg_75_0 then
				arg_72_1.var_.moveOldPos1077ui_story = var_75_0.localPosition

				local var_75_2 = GameObjectTools.GetOrAddComponent(var_75_0.gameObject, typeof(DynamicBoneHelper))

				if var_75_2 then
					var_75_2:EnableDynamicBone(false)
				end
			end

			local var_75_3 = 0.001

			if var_75_1 <= arg_72_1.time_ and arg_72_1.time_ < var_75_1 + var_75_3 then
				local var_75_4 = (arg_72_1.time_ - var_75_1) / var_75_3
				local var_75_5 = Vector3.New(0, 100, 0)

				var_75_0.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPos1077ui_story, var_75_5, var_75_4)

				local var_75_6 = manager.ui.mainCamera.transform.position - var_75_0.position

				var_75_0.forward = Vector3.New(var_75_6.x, var_75_6.y, var_75_6.z)

				local var_75_7 = var_75_0.localEulerAngles

				var_75_7.z = 0
				var_75_7.x = 0
				var_75_0.localEulerAngles = var_75_7
			end

			if arg_72_1.time_ >= var_75_1 + var_75_3 and arg_72_1.time_ < var_75_1 + var_75_3 + arg_75_0 then
				var_75_0.localPosition = Vector3.New(0, 100, 0)

				local var_75_8 = manager.ui.mainCamera.transform.position - var_75_0.position

				var_75_0.forward = Vector3.New(var_75_8.x, var_75_8.y, var_75_8.z)

				local var_75_9 = var_75_0.localEulerAngles

				var_75_9.z = 0
				var_75_9.x = 0
				var_75_0.localEulerAngles = var_75_9

				local var_75_10 = GameObjectTools.GetOrAddComponent(var_75_0.gameObject, typeof(DynamicBoneHelper))

				if var_75_10 then
					var_75_10:EnableDynamicBone(true)
				end
			end

			local var_75_11 = arg_72_1.actors_["1077ui_story"]
			local var_75_12 = 0

			if var_75_12 < arg_72_1.time_ and arg_72_1.time_ <= var_75_12 + arg_75_0 and not isNil(var_75_11) and arg_72_1.var_.characterEffect1077ui_story == nil then
				arg_72_1.var_.characterEffect1077ui_story = var_75_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_13 = 0.200000002980232

			if var_75_12 <= arg_72_1.time_ and arg_72_1.time_ < var_75_12 + var_75_13 and not isNil(var_75_11) then
				local var_75_14 = (arg_72_1.time_ - var_75_12) / var_75_13

				if arg_72_1.var_.characterEffect1077ui_story and not isNil(var_75_11) then
					arg_72_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_72_1.time_ >= var_75_12 + var_75_13 and arg_72_1.time_ < var_75_12 + var_75_13 + arg_75_0 and not isNil(var_75_11) and arg_72_1.var_.characterEffect1077ui_story then
				arg_72_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_75_15 = 0
			local var_75_16 = 0.6

			if var_75_15 < arg_72_1.time_ and arg_72_1.time_ <= var_75_15 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				local var_75_17 = arg_72_1:FormatText(StoryNameCfg[1467].name)

				arg_72_1.leftNameTxt_.text = var_75_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, true)
				arg_72_1.iconController_:SetSelectedState("hero")

				arg_72_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1077")

				arg_72_1.callingController_:SetSelectedState("normal")

				arg_72_1.keyicon_.color = Color.New(1, 1, 1)
				arg_72_1.icon_.color = Color.New(1, 1, 1)

				local var_75_18 = arg_72_1:GetWordFromCfg(325102017)
				local var_75_19 = arg_72_1:FormatText(var_75_18.content)

				arg_72_1.text_.text = var_75_19

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_20 = 24
				local var_75_21 = utf8.len(var_75_19)
				local var_75_22 = var_75_20 <= 0 and var_75_16 or var_75_16 * (var_75_21 / var_75_20)

				if var_75_22 > 0 and var_75_16 < var_75_22 then
					arg_72_1.talkMaxDuration = var_75_22

					if var_75_22 + var_75_15 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_22 + var_75_15
					end
				end

				arg_72_1.text_.text = var_75_19
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325102", "325102017", "story_v_out_325102.awb") ~= 0 then
					local var_75_23 = manager.audio:GetVoiceLength("story_v_out_325102", "325102017", "story_v_out_325102.awb") / 1000

					if var_75_23 + var_75_15 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_23 + var_75_15
					end

					if var_75_18.prefab_name ~= "" and arg_72_1.actors_[var_75_18.prefab_name] ~= nil then
						local var_75_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_18.prefab_name].transform, "story_v_out_325102", "325102017", "story_v_out_325102.awb")

						arg_72_1:RecordAudio("325102017", var_75_24)
						arg_72_1:RecordAudio("325102017", var_75_24)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_325102", "325102017", "story_v_out_325102.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_325102", "325102017", "story_v_out_325102.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_25 = math.max(var_75_16, arg_72_1.talkMaxDuration)

			if var_75_15 <= arg_72_1.time_ and arg_72_1.time_ < var_75_15 + var_75_25 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_15) / var_75_25

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_15 + var_75_25 and arg_72_1.time_ < var_75_15 + var_75_25 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_72_1:InitPlayNodeList()
	end,
	Play325102018 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 325102018
		arg_76_1.duration_ = 1.73

		local var_76_0 = {
			zh = 1.433,
			ja = 1.733
		}
		local var_76_1 = manager.audio:GetLocalizationFlag()

		if var_76_0[var_76_1] ~= nil then
			arg_76_1.duration_ = var_76_0[var_76_1]
		end

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play325102019(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = arg_76_1.actors_["1077ui_story"]
			local var_79_1 = 0

			if var_79_1 < arg_76_1.time_ and arg_76_1.time_ <= var_79_1 + arg_79_0 and not isNil(var_79_0) and arg_76_1.var_.characterEffect1077ui_story == nil then
				arg_76_1.var_.characterEffect1077ui_story = var_79_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_2 = 0.200000002980232

			if var_79_1 <= arg_76_1.time_ and arg_76_1.time_ < var_79_1 + var_79_2 and not isNil(var_79_0) then
				local var_79_3 = (arg_76_1.time_ - var_79_1) / var_79_2

				if arg_76_1.var_.characterEffect1077ui_story and not isNil(var_79_0) then
					local var_79_4 = Mathf.Lerp(0, 0.5, var_79_3)

					arg_76_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_76_1.var_.characterEffect1077ui_story.fillRatio = var_79_4
				end
			end

			if arg_76_1.time_ >= var_79_1 + var_79_2 and arg_76_1.time_ < var_79_1 + var_79_2 + arg_79_0 and not isNil(var_79_0) and arg_76_1.var_.characterEffect1077ui_story then
				local var_79_5 = 0.5

				arg_76_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_76_1.var_.characterEffect1077ui_story.fillRatio = var_79_5
			end

			local var_79_6 = 0
			local var_79_7 = 0.125

			if var_79_6 < arg_76_1.time_ and arg_76_1.time_ <= var_79_6 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				local var_79_8 = arg_76_1:FormatText(StoryNameCfg[1455].name)

				arg_76_1.leftNameTxt_.text = var_79_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, true)
				arg_76_1.iconController_:SetSelectedState("hero")

				arg_76_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_76_1.callingController_:SetSelectedState("normal")

				arg_76_1.keyicon_.color = Color.New(1, 1, 1)
				arg_76_1.icon_.color = Color.New(1, 1, 1)

				local var_79_9 = arg_76_1:GetWordFromCfg(325102018)
				local var_79_10 = arg_76_1:FormatText(var_79_9.content)

				arg_76_1.text_.text = var_79_10

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_11 = 5
				local var_79_12 = utf8.len(var_79_10)
				local var_79_13 = var_79_11 <= 0 and var_79_7 or var_79_7 * (var_79_12 / var_79_11)

				if var_79_13 > 0 and var_79_7 < var_79_13 then
					arg_76_1.talkMaxDuration = var_79_13

					if var_79_13 + var_79_6 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_13 + var_79_6
					end
				end

				arg_76_1.text_.text = var_79_10
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325102", "325102018", "story_v_out_325102.awb") ~= 0 then
					local var_79_14 = manager.audio:GetVoiceLength("story_v_out_325102", "325102018", "story_v_out_325102.awb") / 1000

					if var_79_14 + var_79_6 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_14 + var_79_6
					end

					if var_79_9.prefab_name ~= "" and arg_76_1.actors_[var_79_9.prefab_name] ~= nil then
						local var_79_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_9.prefab_name].transform, "story_v_out_325102", "325102018", "story_v_out_325102.awb")

						arg_76_1:RecordAudio("325102018", var_79_15)
						arg_76_1:RecordAudio("325102018", var_79_15)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_325102", "325102018", "story_v_out_325102.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_325102", "325102018", "story_v_out_325102.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_16 = math.max(var_79_7, arg_76_1.talkMaxDuration)

			if var_79_6 <= arg_76_1.time_ and arg_76_1.time_ < var_79_6 + var_79_16 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_6) / var_79_16

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_6 + var_79_16 and arg_76_1.time_ < var_79_6 + var_79_16 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {}

		arg_76_1:InitPlayNodeList()
	end,
	Play325102019 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 325102019
		arg_80_1.duration_ = 5.9

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play325102020(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = arg_80_1.actors_["1059ui_story"].transform
			local var_83_1 = 0

			if var_83_1 < arg_80_1.time_ and arg_80_1.time_ <= var_83_1 + arg_83_0 then
				arg_80_1.var_.moveOldPos1059ui_story = var_83_0.localPosition
			end

			local var_83_2 = 0.001

			if var_83_1 <= arg_80_1.time_ and arg_80_1.time_ < var_83_1 + var_83_2 then
				local var_83_3 = (arg_80_1.time_ - var_83_1) / var_83_2
				local var_83_4 = Vector3.New(0, 100, 0)

				var_83_0.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPos1059ui_story, var_83_4, var_83_3)

				local var_83_5 = manager.ui.mainCamera.transform.position - var_83_0.position

				var_83_0.forward = Vector3.New(var_83_5.x, var_83_5.y, var_83_5.z)

				local var_83_6 = var_83_0.localEulerAngles

				var_83_6.z = 0
				var_83_6.x = 0
				var_83_0.localEulerAngles = var_83_6
			end

			if arg_80_1.time_ >= var_83_1 + var_83_2 and arg_80_1.time_ < var_83_1 + var_83_2 + arg_83_0 then
				var_83_0.localPosition = Vector3.New(0, 100, 0)

				local var_83_7 = manager.ui.mainCamera.transform.position - var_83_0.position

				var_83_0.forward = Vector3.New(var_83_7.x, var_83_7.y, var_83_7.z)

				local var_83_8 = var_83_0.localEulerAngles

				var_83_8.z = 0
				var_83_8.x = 0
				var_83_0.localEulerAngles = var_83_8
			end

			local var_83_9 = arg_80_1.actors_["1077ui_story"].transform
			local var_83_10 = 0

			if var_83_10 < arg_80_1.time_ and arg_80_1.time_ <= var_83_10 + arg_83_0 then
				arg_80_1.var_.moveOldPos1077ui_story = var_83_9.localPosition

				local var_83_11 = GameObjectTools.GetOrAddComponent(var_83_9.gameObject, typeof(DynamicBoneHelper))

				if var_83_11 then
					var_83_11:EnableDynamicBone(false)
				end
			end

			local var_83_12 = 0.001

			if var_83_10 <= arg_80_1.time_ and arg_80_1.time_ < var_83_10 + var_83_12 then
				local var_83_13 = (arg_80_1.time_ - var_83_10) / var_83_12
				local var_83_14 = Vector3.New(0, 100, 0)

				var_83_9.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPos1077ui_story, var_83_14, var_83_13)

				local var_83_15 = manager.ui.mainCamera.transform.position - var_83_9.position

				var_83_9.forward = Vector3.New(var_83_15.x, var_83_15.y, var_83_15.z)

				local var_83_16 = var_83_9.localEulerAngles

				var_83_16.z = 0
				var_83_16.x = 0
				var_83_9.localEulerAngles = var_83_16
			end

			if arg_80_1.time_ >= var_83_10 + var_83_12 and arg_80_1.time_ < var_83_10 + var_83_12 + arg_83_0 then
				var_83_9.localPosition = Vector3.New(0, 100, 0)

				local var_83_17 = manager.ui.mainCamera.transform.position - var_83_9.position

				var_83_9.forward = Vector3.New(var_83_17.x, var_83_17.y, var_83_17.z)

				local var_83_18 = var_83_9.localEulerAngles

				var_83_18.z = 0
				var_83_18.x = 0
				var_83_9.localEulerAngles = var_83_18

				local var_83_19 = GameObjectTools.GetOrAddComponent(var_83_9.gameObject, typeof(DynamicBoneHelper))

				if var_83_19 then
					var_83_19:EnableDynamicBone(true)
				end
			end

			local var_83_20 = arg_80_1.actors_["1059ui_story"]
			local var_83_21 = 0

			if var_83_21 < arg_80_1.time_ and arg_80_1.time_ <= var_83_21 + arg_83_0 and not isNil(var_83_20) and arg_80_1.var_.characterEffect1059ui_story == nil then
				arg_80_1.var_.characterEffect1059ui_story = var_83_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_22 = 0.200000002980232

			if var_83_21 <= arg_80_1.time_ and arg_80_1.time_ < var_83_21 + var_83_22 and not isNil(var_83_20) then
				local var_83_23 = (arg_80_1.time_ - var_83_21) / var_83_22

				if arg_80_1.var_.characterEffect1059ui_story and not isNil(var_83_20) then
					local var_83_24 = Mathf.Lerp(0, 0.5, var_83_23)

					arg_80_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_80_1.var_.characterEffect1059ui_story.fillRatio = var_83_24
				end
			end

			if arg_80_1.time_ >= var_83_21 + var_83_22 and arg_80_1.time_ < var_83_21 + var_83_22 + arg_83_0 and not isNil(var_83_20) and arg_80_1.var_.characterEffect1059ui_story then
				local var_83_25 = 0.5

				arg_80_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_80_1.var_.characterEffect1059ui_story.fillRatio = var_83_25
			end

			local var_83_26 = manager.ui.mainCamera.transform
			local var_83_27 = 0

			if var_83_27 < arg_80_1.time_ and arg_80_1.time_ <= var_83_27 + arg_83_0 then
				local var_83_28 = arg_80_1.var_.effect4324
				local var_83_29
				local var_83_30 = var_83_26

				if not var_83_28 then
					var_83_28 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_ripple"), var_83_30)
					var_83_28.name = "4324"
					arg_80_1.var_.effect4324 = var_83_28
				else
					var_83_28.transform:SetParent(var_83_30)
				end

				var_83_28.transform.localPosition = Vector3.New(0, 0, 0)
				var_83_28.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_83_31 = 1.7777777777777777
				local var_83_32 = Screen.width / Screen.height
				local var_83_33 = var_83_32 / var_83_31
				local var_83_34 = Mathf.Max(var_83_31 / var_83_32, 1)

				var_83_28.transform.localScale = Vector3.New(var_83_28.transform.localScale.x * var_83_33, var_83_28.transform.localScale.y * var_83_34, var_83_28.transform.localScale.z)
			end

			local var_83_35 = manager.ui.mainCamera.transform
			local var_83_36 = 1.86666666666667

			if var_83_36 < arg_80_1.time_ and arg_80_1.time_ <= var_83_36 + arg_83_0 then
				local var_83_37 = arg_80_1.var_.effect4324

				if var_83_37 then
					Object.Destroy(var_83_37)

					arg_80_1.var_.effect4324 = nil
				end
			end

			local var_83_38 = 0

			if var_83_38 < arg_80_1.time_ and arg_80_1.time_ <= var_83_38 + arg_83_0 then
				arg_80_1.allBtn_.enabled = false
			end

			local var_83_39 = 1.43333333333333

			if arg_80_1.time_ >= var_83_38 + var_83_39 and arg_80_1.time_ < var_83_38 + var_83_39 + arg_83_0 then
				arg_80_1.allBtn_.enabled = true
			end

			local var_83_40 = 0.3
			local var_83_41 = 1

			if var_83_40 < arg_80_1.time_ and arg_80_1.time_ <= var_83_40 + arg_83_0 then
				local var_83_42 = "play"
				local var_83_43 = "effect"

				arg_80_1:AudioAction(var_83_42, var_83_43, "se_story_122_01", "se_story_122_01_smoke", "")
			end

			local var_83_44 = 1.3
			local var_83_45 = 1

			if var_83_44 < arg_80_1.time_ and arg_80_1.time_ <= var_83_44 + arg_83_0 then
				local var_83_46 = "play"
				local var_83_47 = "effect"

				arg_80_1:AudioAction(var_83_46, var_83_47, "se_story_141", "se_story_141_foley_cloth", "")
			end

			if arg_80_1.frameCnt_ <= 1 then
				arg_80_1.dialog_:SetActive(false)
			end

			local var_83_48 = 0.9
			local var_83_49 = 1.375

			if var_83_48 < arg_80_1.time_ and arg_80_1.time_ <= var_83_48 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0

				arg_80_1.dialog_:SetActive(true)

				arg_80_1.dialogCg_.alpha = 0

				local var_83_50 = LeanTween.value(arg_80_1.dialog_, 0, 1, 0.3)

				var_83_50:setOnUpdate(LuaHelper.FloatAction(function(arg_84_0)
					arg_80_1.dialogCg_.alpha = arg_84_0
				end))
				var_83_50:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_80_1.dialog_)
					var_83_50:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_80_1.duration_ = arg_80_1.duration_ + 0.3

				SetActive(arg_80_1.leftNameGo_, false)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_51 = arg_80_1:GetWordFromCfg(325102019)
				local var_83_52 = arg_80_1:FormatText(var_83_51.content)

				arg_80_1.text_.text = var_83_52

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_53 = 55
				local var_83_54 = utf8.len(var_83_52)
				local var_83_55 = var_83_53 <= 0 and var_83_49 or var_83_49 * (var_83_54 / var_83_53)

				if var_83_55 > 0 and var_83_49 < var_83_55 then
					arg_80_1.talkMaxDuration = var_83_55
					var_83_48 = var_83_48 + 0.3

					if var_83_55 + var_83_48 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_55 + var_83_48
					end
				end

				arg_80_1.text_.text = var_83_52
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)
				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_56 = var_83_48 + 0.3
			local var_83_57 = math.max(var_83_49, arg_80_1.talkMaxDuration)

			if var_83_56 <= arg_80_1.time_ and arg_80_1.time_ < var_83_56 + var_83_57 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_56) / var_83_57

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_56 + var_83_57 and arg_80_1.time_ < var_83_56 + var_83_57 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_80_1:InitPlayNodeList()
	end,
	Play325102020 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 325102020
		arg_86_1.duration_ = 3.23

		local var_86_0 = {
			zh = 3,
			ja = 3.233
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
				arg_86_0:Play325102021(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			local var_89_0 = 0
			local var_89_1 = 0.3

			if var_89_0 < arg_86_1.time_ and arg_86_1.time_ <= var_89_0 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, true)

				local var_89_2 = arg_86_1:FormatText(StoryNameCfg[1455].name)

				arg_86_1.leftNameTxt_.text = var_89_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, true)
				arg_86_1.iconController_:SetSelectedState("hero")

				arg_86_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_86_1.callingController_:SetSelectedState("normal")

				arg_86_1.keyicon_.color = Color.New(1, 1, 1)
				arg_86_1.icon_.color = Color.New(1, 1, 1)

				local var_89_3 = arg_86_1:GetWordFromCfg(325102020)
				local var_89_4 = arg_86_1:FormatText(var_89_3.content)

				arg_86_1.text_.text = var_89_4

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_5 = 12
				local var_89_6 = utf8.len(var_89_4)
				local var_89_7 = var_89_5 <= 0 and var_89_1 or var_89_1 * (var_89_6 / var_89_5)

				if var_89_7 > 0 and var_89_1 < var_89_7 then
					arg_86_1.talkMaxDuration = var_89_7

					if var_89_7 + var_89_0 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_7 + var_89_0
					end
				end

				arg_86_1.text_.text = var_89_4
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325102", "325102020", "story_v_out_325102.awb") ~= 0 then
					local var_89_8 = manager.audio:GetVoiceLength("story_v_out_325102", "325102020", "story_v_out_325102.awb") / 1000

					if var_89_8 + var_89_0 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_8 + var_89_0
					end

					if var_89_3.prefab_name ~= "" and arg_86_1.actors_[var_89_3.prefab_name] ~= nil then
						local var_89_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_86_1.actors_[var_89_3.prefab_name].transform, "story_v_out_325102", "325102020", "story_v_out_325102.awb")

						arg_86_1:RecordAudio("325102020", var_89_9)
						arg_86_1:RecordAudio("325102020", var_89_9)
					else
						arg_86_1:AudioAction("play", "voice", "story_v_out_325102", "325102020", "story_v_out_325102.awb")
					end

					arg_86_1:RecordHistoryTalkVoice("story_v_out_325102", "325102020", "story_v_out_325102.awb")
				end

				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_10 = math.max(var_89_1, arg_86_1.talkMaxDuration)

			if var_89_0 <= arg_86_1.time_ and arg_86_1.time_ < var_89_0 + var_89_10 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_0) / var_89_10

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_0 + var_89_10 and arg_86_1.time_ < var_89_0 + var_89_10 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {}

		arg_86_1:InitPlayNodeList()
	end,
	Play325102021 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 325102021
		arg_90_1.duration_ = 5

		SetActive(arg_90_1.tipsGo_, false)

		function arg_90_1.onSingleLineFinish_()
			arg_90_1.onSingleLineUpdate_ = nil
			arg_90_1.onSingleLineFinish_ = nil
			arg_90_1.state_ = "waiting"
		end

		function arg_90_1.playNext_(arg_92_0)
			if arg_92_0 == 1 then
				arg_90_0:Play325102022(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			local var_93_0 = 0.3
			local var_93_1 = 1

			if var_93_0 < arg_90_1.time_ and arg_90_1.time_ <= var_93_0 + arg_93_0 then
				local var_93_2 = "play"
				local var_93_3 = "effect"

				arg_90_1:AudioAction(var_93_2, var_93_3, "se_story_150", "se_story_150_sword03", "")
			end

			local var_93_4 = 0
			local var_93_5 = 0.775

			if var_93_4 < arg_90_1.time_ and arg_90_1.time_ <= var_93_4 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, false)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_6 = arg_90_1:GetWordFromCfg(325102021)
				local var_93_7 = arg_90_1:FormatText(var_93_6.content)

				arg_90_1.text_.text = var_93_7

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_8 = 31
				local var_93_9 = utf8.len(var_93_7)
				local var_93_10 = var_93_8 <= 0 and var_93_5 or var_93_5 * (var_93_9 / var_93_8)

				if var_93_10 > 0 and var_93_5 < var_93_10 then
					arg_90_1.talkMaxDuration = var_93_10

					if var_93_10 + var_93_4 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_10 + var_93_4
					end
				end

				arg_90_1.text_.text = var_93_7
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)
				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_11 = math.max(var_93_5, arg_90_1.talkMaxDuration)

			if var_93_4 <= arg_90_1.time_ and arg_90_1.time_ < var_93_4 + var_93_11 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_4) / var_93_11

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_4 + var_93_11 and arg_90_1.time_ < var_93_4 + var_93_11 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {}

		arg_90_1:InitPlayNodeList()
	end,
	Play325102022 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 325102022
		arg_94_1.duration_ = 4.23

		local var_94_0 = {
			zh = 3.033,
			ja = 4.233
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
				arg_94_0:Play325102023(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			local var_97_0 = arg_94_1.actors_["1077ui_story"].transform
			local var_97_1 = 0

			if var_97_1 < arg_94_1.time_ and arg_94_1.time_ <= var_97_1 + arg_97_0 then
				arg_94_1.var_.moveOldPos1077ui_story = var_97_0.localPosition

				local var_97_2 = GameObjectTools.GetOrAddComponent(var_97_0.gameObject, typeof(DynamicBoneHelper))

				if var_97_2 then
					var_97_2:EnableDynamicBone(false)
				end
			end

			local var_97_3 = 0.001

			if var_97_1 <= arg_94_1.time_ and arg_94_1.time_ < var_97_1 + var_97_3 then
				local var_97_4 = (arg_94_1.time_ - var_97_1) / var_97_3
				local var_97_5 = Vector3.New(-0.03, -1.02, -5.92)

				var_97_0.localPosition = Vector3.Lerp(arg_94_1.var_.moveOldPos1077ui_story, var_97_5, var_97_4)

				local var_97_6 = manager.ui.mainCamera.transform.position - var_97_0.position

				var_97_0.forward = Vector3.New(var_97_6.x, var_97_6.y, var_97_6.z)

				local var_97_7 = var_97_0.localEulerAngles

				var_97_7.z = 0
				var_97_7.x = 0
				var_97_0.localEulerAngles = var_97_7
			end

			if arg_94_1.time_ >= var_97_1 + var_97_3 and arg_94_1.time_ < var_97_1 + var_97_3 + arg_97_0 then
				var_97_0.localPosition = Vector3.New(-0.03, -1.02, -5.92)

				local var_97_8 = manager.ui.mainCamera.transform.position - var_97_0.position

				var_97_0.forward = Vector3.New(var_97_8.x, var_97_8.y, var_97_8.z)

				local var_97_9 = var_97_0.localEulerAngles

				var_97_9.z = 0
				var_97_9.x = 0
				var_97_0.localEulerAngles = var_97_9

				local var_97_10 = GameObjectTools.GetOrAddComponent(var_97_0.gameObject, typeof(DynamicBoneHelper))

				if var_97_10 then
					var_97_10:EnableDynamicBone(true)
				end
			end

			local var_97_11 = arg_94_1.actors_["1077ui_story"]
			local var_97_12 = 0

			if var_97_12 < arg_94_1.time_ and arg_94_1.time_ <= var_97_12 + arg_97_0 and not isNil(var_97_11) and arg_94_1.var_.characterEffect1077ui_story == nil then
				arg_94_1.var_.characterEffect1077ui_story = var_97_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_97_13 = 0.200000002980232

			if var_97_12 <= arg_94_1.time_ and arg_94_1.time_ < var_97_12 + var_97_13 and not isNil(var_97_11) then
				local var_97_14 = (arg_94_1.time_ - var_97_12) / var_97_13

				if arg_94_1.var_.characterEffect1077ui_story and not isNil(var_97_11) then
					arg_94_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_94_1.time_ >= var_97_12 + var_97_13 and arg_94_1.time_ < var_97_12 + var_97_13 + arg_97_0 and not isNil(var_97_11) and arg_94_1.var_.characterEffect1077ui_story then
				arg_94_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_97_15 = 0

			if var_97_15 < arg_94_1.time_ and arg_94_1.time_ <= var_97_15 + arg_97_0 then
				arg_94_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action1_1")
			end

			local var_97_16 = 0

			if var_97_16 < arg_94_1.time_ and arg_94_1.time_ <= var_97_16 + arg_97_0 then
				arg_94_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_97_17 = 0
			local var_97_18 = 0.45

			if var_97_17 < arg_94_1.time_ and arg_94_1.time_ <= var_97_17 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				local var_97_19 = arg_94_1:FormatText(StoryNameCfg[1467].name)

				arg_94_1.leftNameTxt_.text = var_97_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_20 = arg_94_1:GetWordFromCfg(325102022)
				local var_97_21 = arg_94_1:FormatText(var_97_20.content)

				arg_94_1.text_.text = var_97_21

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_22 = 18
				local var_97_23 = utf8.len(var_97_21)
				local var_97_24 = var_97_22 <= 0 and var_97_18 or var_97_18 * (var_97_23 / var_97_22)

				if var_97_24 > 0 and var_97_18 < var_97_24 then
					arg_94_1.talkMaxDuration = var_97_24

					if var_97_24 + var_97_17 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_24 + var_97_17
					end
				end

				arg_94_1.text_.text = var_97_21
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325102", "325102022", "story_v_out_325102.awb") ~= 0 then
					local var_97_25 = manager.audio:GetVoiceLength("story_v_out_325102", "325102022", "story_v_out_325102.awb") / 1000

					if var_97_25 + var_97_17 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_25 + var_97_17
					end

					if var_97_20.prefab_name ~= "" and arg_94_1.actors_[var_97_20.prefab_name] ~= nil then
						local var_97_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_94_1.actors_[var_97_20.prefab_name].transform, "story_v_out_325102", "325102022", "story_v_out_325102.awb")

						arg_94_1:RecordAudio("325102022", var_97_26)
						arg_94_1:RecordAudio("325102022", var_97_26)
					else
						arg_94_1:AudioAction("play", "voice", "story_v_out_325102", "325102022", "story_v_out_325102.awb")
					end

					arg_94_1:RecordHistoryTalkVoice("story_v_out_325102", "325102022", "story_v_out_325102.awb")
				end

				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_27 = math.max(var_97_18, arg_94_1.talkMaxDuration)

			if var_97_17 <= arg_94_1.time_ and arg_94_1.time_ < var_97_17 + var_97_27 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_17) / var_97_27

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_17 + var_97_27 and arg_94_1.time_ < var_97_17 + var_97_27 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_94_1:InitPlayNodeList()
	end,
	Play325102023 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 325102023
		arg_98_1.duration_ = 4.3

		local var_98_0 = {
			zh = 3.166,
			ja = 4.3
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
				arg_98_0:Play325102024(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			local var_101_0 = arg_98_1.actors_["1077ui_story"]
			local var_101_1 = 0

			if var_101_1 < arg_98_1.time_ and arg_98_1.time_ <= var_101_1 + arg_101_0 and not isNil(var_101_0) and arg_98_1.var_.characterEffect1077ui_story == nil then
				arg_98_1.var_.characterEffect1077ui_story = var_101_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_101_2 = 0.200000002980232

			if var_101_1 <= arg_98_1.time_ and arg_98_1.time_ < var_101_1 + var_101_2 and not isNil(var_101_0) then
				local var_101_3 = (arg_98_1.time_ - var_101_1) / var_101_2

				if arg_98_1.var_.characterEffect1077ui_story and not isNil(var_101_0) then
					local var_101_4 = Mathf.Lerp(0, 0.5, var_101_3)

					arg_98_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_98_1.var_.characterEffect1077ui_story.fillRatio = var_101_4
				end
			end

			if arg_98_1.time_ >= var_101_1 + var_101_2 and arg_98_1.time_ < var_101_1 + var_101_2 + arg_101_0 and not isNil(var_101_0) and arg_98_1.var_.characterEffect1077ui_story then
				local var_101_5 = 0.5

				arg_98_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_98_1.var_.characterEffect1077ui_story.fillRatio = var_101_5
			end

			local var_101_6 = 0
			local var_101_7 = 0.275

			if var_101_6 < arg_98_1.time_ and arg_98_1.time_ <= var_101_6 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				local var_101_8 = arg_98_1:FormatText(StoryNameCfg[1455].name)

				arg_98_1.leftNameTxt_.text = var_101_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, true)
				arg_98_1.iconController_:SetSelectedState("hero")

				arg_98_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_98_1.callingController_:SetSelectedState("normal")

				arg_98_1.keyicon_.color = Color.New(1, 1, 1)
				arg_98_1.icon_.color = Color.New(1, 1, 1)

				local var_101_9 = arg_98_1:GetWordFromCfg(325102023)
				local var_101_10 = arg_98_1:FormatText(var_101_9.content)

				arg_98_1.text_.text = var_101_10

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_11 = 11
				local var_101_12 = utf8.len(var_101_10)
				local var_101_13 = var_101_11 <= 0 and var_101_7 or var_101_7 * (var_101_12 / var_101_11)

				if var_101_13 > 0 and var_101_7 < var_101_13 then
					arg_98_1.talkMaxDuration = var_101_13

					if var_101_13 + var_101_6 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_13 + var_101_6
					end
				end

				arg_98_1.text_.text = var_101_10
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325102", "325102023", "story_v_out_325102.awb") ~= 0 then
					local var_101_14 = manager.audio:GetVoiceLength("story_v_out_325102", "325102023", "story_v_out_325102.awb") / 1000

					if var_101_14 + var_101_6 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_14 + var_101_6
					end

					if var_101_9.prefab_name ~= "" and arg_98_1.actors_[var_101_9.prefab_name] ~= nil then
						local var_101_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_98_1.actors_[var_101_9.prefab_name].transform, "story_v_out_325102", "325102023", "story_v_out_325102.awb")

						arg_98_1:RecordAudio("325102023", var_101_15)
						arg_98_1:RecordAudio("325102023", var_101_15)
					else
						arg_98_1:AudioAction("play", "voice", "story_v_out_325102", "325102023", "story_v_out_325102.awb")
					end

					arg_98_1:RecordHistoryTalkVoice("story_v_out_325102", "325102023", "story_v_out_325102.awb")
				end

				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_16 = math.max(var_101_7, arg_98_1.talkMaxDuration)

			if var_101_6 <= arg_98_1.time_ and arg_98_1.time_ < var_101_6 + var_101_16 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_6) / var_101_16

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_6 + var_101_16 and arg_98_1.time_ < var_101_6 + var_101_16 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {}

		arg_98_1:InitPlayNodeList()
	end,
	Play325102024 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 325102024
		arg_102_1.duration_ = 13.33

		local var_102_0 = {
			zh = 6.3,
			ja = 13.333
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
				arg_102_0:Play325102025(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			local var_105_0 = 0
			local var_105_1 = 0.5

			if var_105_0 < arg_102_1.time_ and arg_102_1.time_ <= var_105_0 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				local var_105_2 = arg_102_1:FormatText(StoryNameCfg[1455].name)

				arg_102_1.leftNameTxt_.text = var_105_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, true)
				arg_102_1.iconController_:SetSelectedState("hero")

				arg_102_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_102_1.callingController_:SetSelectedState("normal")

				arg_102_1.keyicon_.color = Color.New(1, 1, 1)
				arg_102_1.icon_.color = Color.New(1, 1, 1)

				local var_105_3 = arg_102_1:GetWordFromCfg(325102024)
				local var_105_4 = arg_102_1:FormatText(var_105_3.content)

				arg_102_1.text_.text = var_105_4

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_5 = 20
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

				if manager.audio:GetVoiceLength("story_v_out_325102", "325102024", "story_v_out_325102.awb") ~= 0 then
					local var_105_8 = manager.audio:GetVoiceLength("story_v_out_325102", "325102024", "story_v_out_325102.awb") / 1000

					if var_105_8 + var_105_0 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_8 + var_105_0
					end

					if var_105_3.prefab_name ~= "" and arg_102_1.actors_[var_105_3.prefab_name] ~= nil then
						local var_105_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_102_1.actors_[var_105_3.prefab_name].transform, "story_v_out_325102", "325102024", "story_v_out_325102.awb")

						arg_102_1:RecordAudio("325102024", var_105_9)
						arg_102_1:RecordAudio("325102024", var_105_9)
					else
						arg_102_1:AudioAction("play", "voice", "story_v_out_325102", "325102024", "story_v_out_325102.awb")
					end

					arg_102_1:RecordHistoryTalkVoice("story_v_out_325102", "325102024", "story_v_out_325102.awb")
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
	Play325102025 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 325102025
		arg_106_1.duration_ = 5

		SetActive(arg_106_1.tipsGo_, false)

		function arg_106_1.onSingleLineFinish_()
			arg_106_1.onSingleLineUpdate_ = nil
			arg_106_1.onSingleLineFinish_ = nil
			arg_106_1.state_ = "waiting"
		end

		function arg_106_1.playNext_(arg_108_0)
			if arg_108_0 == 1 then
				arg_106_0:Play325102026(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			local var_109_0 = arg_106_1.actors_["1059ui_story"].transform
			local var_109_1 = 0

			if var_109_1 < arg_106_1.time_ and arg_106_1.time_ <= var_109_1 + arg_109_0 then
				arg_106_1.var_.moveOldPos1059ui_story = var_109_0.localPosition
			end

			local var_109_2 = 0.001

			if var_109_1 <= arg_106_1.time_ and arg_106_1.time_ < var_109_1 + var_109_2 then
				local var_109_3 = (arg_106_1.time_ - var_109_1) / var_109_2
				local var_109_4 = Vector3.New(0, 100, 0)

				var_109_0.localPosition = Vector3.Lerp(arg_106_1.var_.moveOldPos1059ui_story, var_109_4, var_109_3)

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

			local var_109_9 = arg_106_1.actors_["1077ui_story"].transform
			local var_109_10 = 0

			if var_109_10 < arg_106_1.time_ and arg_106_1.time_ <= var_109_10 + arg_109_0 then
				arg_106_1.var_.moveOldPos1077ui_story = var_109_9.localPosition

				local var_109_11 = GameObjectTools.GetOrAddComponent(var_109_9.gameObject, typeof(DynamicBoneHelper))

				if var_109_11 then
					var_109_11:EnableDynamicBone(false)
				end
			end

			local var_109_12 = 0.001

			if var_109_10 <= arg_106_1.time_ and arg_106_1.time_ < var_109_10 + var_109_12 then
				local var_109_13 = (arg_106_1.time_ - var_109_10) / var_109_12
				local var_109_14 = Vector3.New(0, 100, 0)

				var_109_9.localPosition = Vector3.Lerp(arg_106_1.var_.moveOldPos1077ui_story, var_109_14, var_109_13)

				local var_109_15 = manager.ui.mainCamera.transform.position - var_109_9.position

				var_109_9.forward = Vector3.New(var_109_15.x, var_109_15.y, var_109_15.z)

				local var_109_16 = var_109_9.localEulerAngles

				var_109_16.z = 0
				var_109_16.x = 0
				var_109_9.localEulerAngles = var_109_16
			end

			if arg_106_1.time_ >= var_109_10 + var_109_12 and arg_106_1.time_ < var_109_10 + var_109_12 + arg_109_0 then
				var_109_9.localPosition = Vector3.New(0, 100, 0)

				local var_109_17 = manager.ui.mainCamera.transform.position - var_109_9.position

				var_109_9.forward = Vector3.New(var_109_17.x, var_109_17.y, var_109_17.z)

				local var_109_18 = var_109_9.localEulerAngles

				var_109_18.z = 0
				var_109_18.x = 0
				var_109_9.localEulerAngles = var_109_18

				local var_109_19 = GameObjectTools.GetOrAddComponent(var_109_9.gameObject, typeof(DynamicBoneHelper))

				if var_109_19 then
					var_109_19:EnableDynamicBone(true)
				end
			end

			local var_109_20 = 0.3
			local var_109_21 = 1

			if var_109_20 < arg_106_1.time_ and arg_106_1.time_ <= var_109_20 + arg_109_0 then
				local var_109_22 = "play"
				local var_109_23 = "effect"

				arg_106_1:AudioAction(var_109_22, var_109_23, "se_story_6", "se_story_6_draw_out02", "")
			end

			local var_109_24 = 0
			local var_109_25 = 0.975

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

				local var_109_26 = arg_106_1:GetWordFromCfg(325102025)
				local var_109_27 = arg_106_1:FormatText(var_109_26.content)

				arg_106_1.text_.text = var_109_27

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_28 = 39
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
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1077ui_story",
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
	Play325102026 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 325102026
		arg_110_1.duration_ = 5

		SetActive(arg_110_1.tipsGo_, false)

		function arg_110_1.onSingleLineFinish_()
			arg_110_1.onSingleLineUpdate_ = nil
			arg_110_1.onSingleLineFinish_ = nil
			arg_110_1.state_ = "waiting"
		end

		function arg_110_1.playNext_(arg_112_0)
			if arg_112_0 == 1 then
				arg_110_0:Play325102027(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			local var_113_0 = 0
			local var_113_1 = 1.15

			if var_113_0 < arg_110_1.time_ and arg_110_1.time_ <= var_113_0 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, false)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_110_1.iconTrs_.gameObject, false)
				arg_110_1.callingController_:SetSelectedState("normal")

				local var_113_2 = arg_110_1:GetWordFromCfg(325102026)
				local var_113_3 = arg_110_1:FormatText(var_113_2.content)

				arg_110_1.text_.text = var_113_3

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_4 = 46
				local var_113_5 = utf8.len(var_113_3)
				local var_113_6 = var_113_4 <= 0 and var_113_1 or var_113_1 * (var_113_5 / var_113_4)

				if var_113_6 > 0 and var_113_1 < var_113_6 then
					arg_110_1.talkMaxDuration = var_113_6

					if var_113_6 + var_113_0 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_6 + var_113_0
					end
				end

				arg_110_1.text_.text = var_113_3
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)
				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_7 = math.max(var_113_1, arg_110_1.talkMaxDuration)

			if var_113_0 <= arg_110_1.time_ and arg_110_1.time_ < var_113_0 + var_113_7 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_0) / var_113_7

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_0 + var_113_7 and arg_110_1.time_ < var_113_0 + var_113_7 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {}

		arg_110_1:InitPlayNodeList()
	end,
	Play325102027 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 325102027
		arg_114_1.duration_ = 2.93

		local var_114_0 = {
			zh = 1.4,
			ja = 2.933
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
				arg_114_0:Play325102028(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			local var_117_0 = 0
			local var_117_1 = 0.225

			if var_117_0 < arg_114_1.time_ and arg_114_1.time_ <= var_117_0 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, true)

				local var_117_2 = arg_114_1:FormatText(StoryNameCfg[1455].name)

				arg_114_1.leftNameTxt_.text = var_117_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_114_1.leftNameTxt_.transform)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1.leftNameTxt_.text)
				SetActive(arg_114_1.iconTrs_.gameObject, true)
				arg_114_1.iconController_:SetSelectedState("hero")

				arg_114_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_114_1.callingController_:SetSelectedState("normal")

				arg_114_1.keyicon_.color = Color.New(1, 1, 1)
				arg_114_1.icon_.color = Color.New(1, 1, 1)

				local var_117_3 = arg_114_1:GetWordFromCfg(325102027)
				local var_117_4 = arg_114_1:FormatText(var_117_3.content)

				arg_114_1.text_.text = var_117_4

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_5 = 9
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

				if manager.audio:GetVoiceLength("story_v_out_325102", "325102027", "story_v_out_325102.awb") ~= 0 then
					local var_117_8 = manager.audio:GetVoiceLength("story_v_out_325102", "325102027", "story_v_out_325102.awb") / 1000

					if var_117_8 + var_117_0 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_8 + var_117_0
					end

					if var_117_3.prefab_name ~= "" and arg_114_1.actors_[var_117_3.prefab_name] ~= nil then
						local var_117_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_114_1.actors_[var_117_3.prefab_name].transform, "story_v_out_325102", "325102027", "story_v_out_325102.awb")

						arg_114_1:RecordAudio("325102027", var_117_9)
						arg_114_1:RecordAudio("325102027", var_117_9)
					else
						arg_114_1:AudioAction("play", "voice", "story_v_out_325102", "325102027", "story_v_out_325102.awb")
					end

					arg_114_1:RecordHistoryTalkVoice("story_v_out_325102", "325102027", "story_v_out_325102.awb")
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
	Play325102028 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 325102028
		arg_118_1.duration_ = 2.33

		local var_118_0 = {
			zh = 1.999999999999,
			ja = 2.333
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
				arg_118_0:Play325102029(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			local var_121_0 = arg_118_1.actors_["1077ui_story"].transform
			local var_121_1 = 0

			if var_121_1 < arg_118_1.time_ and arg_118_1.time_ <= var_121_1 + arg_121_0 then
				arg_118_1.var_.moveOldPos1077ui_story = var_121_0.localPosition

				local var_121_2 = GameObjectTools.GetOrAddComponent(var_121_0.gameObject, typeof(DynamicBoneHelper))

				if var_121_2 then
					var_121_2:EnableDynamicBone(false)
				end
			end

			local var_121_3 = 0.001

			if var_121_1 <= arg_118_1.time_ and arg_118_1.time_ < var_121_1 + var_121_3 then
				local var_121_4 = (arg_118_1.time_ - var_121_1) / var_121_3
				local var_121_5 = Vector3.New(-0.03, -1.02, -5.92)

				var_121_0.localPosition = Vector3.Lerp(arg_118_1.var_.moveOldPos1077ui_story, var_121_5, var_121_4)

				local var_121_6 = manager.ui.mainCamera.transform.position - var_121_0.position

				var_121_0.forward = Vector3.New(var_121_6.x, var_121_6.y, var_121_6.z)

				local var_121_7 = var_121_0.localEulerAngles

				var_121_7.z = 0
				var_121_7.x = 0
				var_121_0.localEulerAngles = var_121_7
			end

			if arg_118_1.time_ >= var_121_1 + var_121_3 and arg_118_1.time_ < var_121_1 + var_121_3 + arg_121_0 then
				var_121_0.localPosition = Vector3.New(-0.03, -1.02, -5.92)

				local var_121_8 = manager.ui.mainCamera.transform.position - var_121_0.position

				var_121_0.forward = Vector3.New(var_121_8.x, var_121_8.y, var_121_8.z)

				local var_121_9 = var_121_0.localEulerAngles

				var_121_9.z = 0
				var_121_9.x = 0
				var_121_0.localEulerAngles = var_121_9

				local var_121_10 = GameObjectTools.GetOrAddComponent(var_121_0.gameObject, typeof(DynamicBoneHelper))

				if var_121_10 then
					var_121_10:EnableDynamicBone(true)
				end
			end

			local var_121_11 = arg_118_1.actors_["1077ui_story"]
			local var_121_12 = 0

			if var_121_12 < arg_118_1.time_ and arg_118_1.time_ <= var_121_12 + arg_121_0 and not isNil(var_121_11) and arg_118_1.var_.characterEffect1077ui_story == nil then
				arg_118_1.var_.characterEffect1077ui_story = var_121_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_121_13 = 0.200000002980232

			if var_121_12 <= arg_118_1.time_ and arg_118_1.time_ < var_121_12 + var_121_13 and not isNil(var_121_11) then
				local var_121_14 = (arg_118_1.time_ - var_121_12) / var_121_13

				if arg_118_1.var_.characterEffect1077ui_story and not isNil(var_121_11) then
					arg_118_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_118_1.time_ >= var_121_12 + var_121_13 and arg_118_1.time_ < var_121_12 + var_121_13 + arg_121_0 and not isNil(var_121_11) and arg_118_1.var_.characterEffect1077ui_story then
				arg_118_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_121_15 = 0

			if var_121_15 < arg_118_1.time_ and arg_118_1.time_ <= var_121_15 + arg_121_0 then
				arg_118_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action2_1")
			end

			local var_121_16 = 0

			if var_121_16 < arg_118_1.time_ and arg_118_1.time_ <= var_121_16 + arg_121_0 then
				arg_118_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_121_17 = 0
			local var_121_18 = 0.3

			if var_121_17 < arg_118_1.time_ and arg_118_1.time_ <= var_121_17 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, true)

				local var_121_19 = arg_118_1:FormatText(StoryNameCfg[1467].name)

				arg_118_1.leftNameTxt_.text = var_121_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_118_1.leftNameTxt_.transform)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1.leftNameTxt_.text)
				SetActive(arg_118_1.iconTrs_.gameObject, false)
				arg_118_1.callingController_:SetSelectedState("normal")

				local var_121_20 = arg_118_1:GetWordFromCfg(325102028)
				local var_121_21 = arg_118_1:FormatText(var_121_20.content)

				arg_118_1.text_.text = var_121_21

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_22 = 12
				local var_121_23 = utf8.len(var_121_21)
				local var_121_24 = var_121_22 <= 0 and var_121_18 or var_121_18 * (var_121_23 / var_121_22)

				if var_121_24 > 0 and var_121_18 < var_121_24 then
					arg_118_1.talkMaxDuration = var_121_24

					if var_121_24 + var_121_17 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_24 + var_121_17
					end
				end

				arg_118_1.text_.text = var_121_21
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325102", "325102028", "story_v_out_325102.awb") ~= 0 then
					local var_121_25 = manager.audio:GetVoiceLength("story_v_out_325102", "325102028", "story_v_out_325102.awb") / 1000

					if var_121_25 + var_121_17 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_25 + var_121_17
					end

					if var_121_20.prefab_name ~= "" and arg_118_1.actors_[var_121_20.prefab_name] ~= nil then
						local var_121_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_118_1.actors_[var_121_20.prefab_name].transform, "story_v_out_325102", "325102028", "story_v_out_325102.awb")

						arg_118_1:RecordAudio("325102028", var_121_26)
						arg_118_1:RecordAudio("325102028", var_121_26)
					else
						arg_118_1:AudioAction("play", "voice", "story_v_out_325102", "325102028", "story_v_out_325102.awb")
					end

					arg_118_1:RecordHistoryTalkVoice("story_v_out_325102", "325102028", "story_v_out_325102.awb")
				end

				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_27 = math.max(var_121_18, arg_118_1.talkMaxDuration)

			if var_121_17 <= arg_118_1.time_ and arg_118_1.time_ < var_121_17 + var_121_27 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - var_121_17) / var_121_27

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= var_121_17 + var_121_27 and arg_118_1.time_ < var_121_17 + var_121_27 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_118_1:InitPlayNodeList()
	end,
	Play325102029 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 325102029
		arg_122_1.duration_ = 6.4

		local var_122_0 = {
			zh = 6.4,
			ja = 4.866
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
				arg_122_0:Play325102030(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			local var_125_0 = 0

			if var_125_0 < arg_122_1.time_ and arg_122_1.time_ <= var_125_0 + arg_125_0 then
				arg_122_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077actionlink/1077action426")
			end

			local var_125_1 = 0

			if var_125_1 < arg_122_1.time_ and arg_122_1.time_ <= var_125_1 + arg_125_0 then
				arg_122_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileC_biyan", "EmotionTimelineAnimator")
			end

			local var_125_2 = 0
			local var_125_3 = 0.7

			if var_125_2 < arg_122_1.time_ and arg_122_1.time_ <= var_125_2 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, true)

				local var_125_4 = arg_122_1:FormatText(StoryNameCfg[1467].name)

				arg_122_1.leftNameTxt_.text = var_125_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_122_1.leftNameTxt_.transform)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1.leftNameTxt_.text)
				SetActive(arg_122_1.iconTrs_.gameObject, false)
				arg_122_1.callingController_:SetSelectedState("normal")

				local var_125_5 = arg_122_1:GetWordFromCfg(325102029)
				local var_125_6 = arg_122_1:FormatText(var_125_5.content)

				arg_122_1.text_.text = var_125_6

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_7 = 28
				local var_125_8 = utf8.len(var_125_6)
				local var_125_9 = var_125_7 <= 0 and var_125_3 or var_125_3 * (var_125_8 / var_125_7)

				if var_125_9 > 0 and var_125_3 < var_125_9 then
					arg_122_1.talkMaxDuration = var_125_9

					if var_125_9 + var_125_2 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_9 + var_125_2
					end
				end

				arg_122_1.text_.text = var_125_6
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325102", "325102029", "story_v_out_325102.awb") ~= 0 then
					local var_125_10 = manager.audio:GetVoiceLength("story_v_out_325102", "325102029", "story_v_out_325102.awb") / 1000

					if var_125_10 + var_125_2 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_10 + var_125_2
					end

					if var_125_5.prefab_name ~= "" and arg_122_1.actors_[var_125_5.prefab_name] ~= nil then
						local var_125_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_122_1.actors_[var_125_5.prefab_name].transform, "story_v_out_325102", "325102029", "story_v_out_325102.awb")

						arg_122_1:RecordAudio("325102029", var_125_11)
						arg_122_1:RecordAudio("325102029", var_125_11)
					else
						arg_122_1:AudioAction("play", "voice", "story_v_out_325102", "325102029", "story_v_out_325102.awb")
					end

					arg_122_1:RecordHistoryTalkVoice("story_v_out_325102", "325102029", "story_v_out_325102.awb")
				end

				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_12 = math.max(var_125_3, arg_122_1.talkMaxDuration)

			if var_125_2 <= arg_122_1.time_ and arg_122_1.time_ < var_125_2 + var_125_12 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_2) / var_125_12

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_2 + var_125_12 and arg_122_1.time_ < var_125_2 + var_125_12 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {}

		arg_122_1:InitPlayNodeList()
	end,
	Play325102030 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 325102030
		arg_126_1.duration_ = 1.33

		local var_126_0 = {
			zh = 0.999999999999,
			ja = 1.333
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
				arg_126_0:Play325102031(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			local var_129_0 = arg_126_1.actors_["1077ui_story"]
			local var_129_1 = 0

			if var_129_1 < arg_126_1.time_ and arg_126_1.time_ <= var_129_1 + arg_129_0 and not isNil(var_129_0) and arg_126_1.var_.characterEffect1077ui_story == nil then
				arg_126_1.var_.characterEffect1077ui_story = var_129_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_129_2 = 0.200000002980232

			if var_129_1 <= arg_126_1.time_ and arg_126_1.time_ < var_129_1 + var_129_2 and not isNil(var_129_0) then
				local var_129_3 = (arg_126_1.time_ - var_129_1) / var_129_2

				if arg_126_1.var_.characterEffect1077ui_story and not isNil(var_129_0) then
					local var_129_4 = Mathf.Lerp(0, 0.5, var_129_3)

					arg_126_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_126_1.var_.characterEffect1077ui_story.fillRatio = var_129_4
				end
			end

			if arg_126_1.time_ >= var_129_1 + var_129_2 and arg_126_1.time_ < var_129_1 + var_129_2 + arg_129_0 and not isNil(var_129_0) and arg_126_1.var_.characterEffect1077ui_story then
				local var_129_5 = 0.5

				arg_126_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_126_1.var_.characterEffect1077ui_story.fillRatio = var_129_5
			end

			local var_129_6 = 0
			local var_129_7 = 0.05

			if var_129_6 < arg_126_1.time_ and arg_126_1.time_ <= var_129_6 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, true)

				local var_129_8 = arg_126_1:FormatText(StoryNameCfg[1455].name)

				arg_126_1.leftNameTxt_.text = var_129_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_126_1.leftNameTxt_.transform)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1.leftNameTxt_.text)
				SetActive(arg_126_1.iconTrs_.gameObject, true)
				arg_126_1.iconController_:SetSelectedState("hero")

				arg_126_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_126_1.callingController_:SetSelectedState("normal")

				arg_126_1.keyicon_.color = Color.New(1, 1, 1)
				arg_126_1.icon_.color = Color.New(1, 1, 1)

				local var_129_9 = arg_126_1:GetWordFromCfg(325102030)
				local var_129_10 = arg_126_1:FormatText(var_129_9.content)

				arg_126_1.text_.text = var_129_10

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_11 = 2
				local var_129_12 = utf8.len(var_129_10)
				local var_129_13 = var_129_11 <= 0 and var_129_7 or var_129_7 * (var_129_12 / var_129_11)

				if var_129_13 > 0 and var_129_7 < var_129_13 then
					arg_126_1.talkMaxDuration = var_129_13

					if var_129_13 + var_129_6 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_13 + var_129_6
					end
				end

				arg_126_1.text_.text = var_129_10
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325102", "325102030", "story_v_out_325102.awb") ~= 0 then
					local var_129_14 = manager.audio:GetVoiceLength("story_v_out_325102", "325102030", "story_v_out_325102.awb") / 1000

					if var_129_14 + var_129_6 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_14 + var_129_6
					end

					if var_129_9.prefab_name ~= "" and arg_126_1.actors_[var_129_9.prefab_name] ~= nil then
						local var_129_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_126_1.actors_[var_129_9.prefab_name].transform, "story_v_out_325102", "325102030", "story_v_out_325102.awb")

						arg_126_1:RecordAudio("325102030", var_129_15)
						arg_126_1:RecordAudio("325102030", var_129_15)
					else
						arg_126_1:AudioAction("play", "voice", "story_v_out_325102", "325102030", "story_v_out_325102.awb")
					end

					arg_126_1:RecordHistoryTalkVoice("story_v_out_325102", "325102030", "story_v_out_325102.awb")
				end

				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_16 = math.max(var_129_7, arg_126_1.talkMaxDuration)

			if var_129_6 <= arg_126_1.time_ and arg_126_1.time_ < var_129_6 + var_129_16 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - var_129_6) / var_129_16

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= var_129_6 + var_129_16 and arg_126_1.time_ < var_129_6 + var_129_16 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {}

		arg_126_1:InitPlayNodeList()
	end,
	Play325102031 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 325102031
		arg_130_1.duration_ = 5

		SetActive(arg_130_1.tipsGo_, false)

		function arg_130_1.onSingleLineFinish_()
			arg_130_1.onSingleLineUpdate_ = nil
			arg_130_1.onSingleLineFinish_ = nil
			arg_130_1.state_ = "waiting"
		end

		function arg_130_1.playNext_(arg_132_0)
			if arg_132_0 == 1 then
				arg_130_0:Play325102032(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			local var_133_0 = arg_130_1.actors_["1059ui_story"].transform
			local var_133_1 = 0

			if var_133_1 < arg_130_1.time_ and arg_130_1.time_ <= var_133_1 + arg_133_0 then
				arg_130_1.var_.moveOldPos1059ui_story = var_133_0.localPosition
			end

			local var_133_2 = 0.001

			if var_133_1 <= arg_130_1.time_ and arg_130_1.time_ < var_133_1 + var_133_2 then
				local var_133_3 = (arg_130_1.time_ - var_133_1) / var_133_2
				local var_133_4 = Vector3.New(0, 100, 0)

				var_133_0.localPosition = Vector3.Lerp(arg_130_1.var_.moveOldPos1059ui_story, var_133_4, var_133_3)

				local var_133_5 = manager.ui.mainCamera.transform.position - var_133_0.position

				var_133_0.forward = Vector3.New(var_133_5.x, var_133_5.y, var_133_5.z)

				local var_133_6 = var_133_0.localEulerAngles

				var_133_6.z = 0
				var_133_6.x = 0
				var_133_0.localEulerAngles = var_133_6
			end

			if arg_130_1.time_ >= var_133_1 + var_133_2 and arg_130_1.time_ < var_133_1 + var_133_2 + arg_133_0 then
				var_133_0.localPosition = Vector3.New(0, 100, 0)

				local var_133_7 = manager.ui.mainCamera.transform.position - var_133_0.position

				var_133_0.forward = Vector3.New(var_133_7.x, var_133_7.y, var_133_7.z)

				local var_133_8 = var_133_0.localEulerAngles

				var_133_8.z = 0
				var_133_8.x = 0
				var_133_0.localEulerAngles = var_133_8
			end

			local var_133_9 = arg_130_1.actors_["1077ui_story"].transform
			local var_133_10 = 0

			if var_133_10 < arg_130_1.time_ and arg_130_1.time_ <= var_133_10 + arg_133_0 then
				arg_130_1.var_.moveOldPos1077ui_story = var_133_9.localPosition

				local var_133_11 = GameObjectTools.GetOrAddComponent(var_133_9.gameObject, typeof(DynamicBoneHelper))

				if var_133_11 then
					var_133_11:EnableDynamicBone(false)
				end
			end

			local var_133_12 = 0.001

			if var_133_10 <= arg_130_1.time_ and arg_130_1.time_ < var_133_10 + var_133_12 then
				local var_133_13 = (arg_130_1.time_ - var_133_10) / var_133_12
				local var_133_14 = Vector3.New(0, 100, 0)

				var_133_9.localPosition = Vector3.Lerp(arg_130_1.var_.moveOldPos1077ui_story, var_133_14, var_133_13)

				local var_133_15 = manager.ui.mainCamera.transform.position - var_133_9.position

				var_133_9.forward = Vector3.New(var_133_15.x, var_133_15.y, var_133_15.z)

				local var_133_16 = var_133_9.localEulerAngles

				var_133_16.z = 0
				var_133_16.x = 0
				var_133_9.localEulerAngles = var_133_16
			end

			if arg_130_1.time_ >= var_133_10 + var_133_12 and arg_130_1.time_ < var_133_10 + var_133_12 + arg_133_0 then
				var_133_9.localPosition = Vector3.New(0, 100, 0)

				local var_133_17 = manager.ui.mainCamera.transform.position - var_133_9.position

				var_133_9.forward = Vector3.New(var_133_17.x, var_133_17.y, var_133_17.z)

				local var_133_18 = var_133_9.localEulerAngles

				var_133_18.z = 0
				var_133_18.x = 0
				var_133_9.localEulerAngles = var_133_18

				local var_133_19 = GameObjectTools.GetOrAddComponent(var_133_9.gameObject, typeof(DynamicBoneHelper))

				if var_133_19 then
					var_133_19:EnableDynamicBone(true)
				end
			end

			local var_133_20 = arg_130_1.actors_["1059ui_story"]
			local var_133_21 = 0

			if var_133_21 < arg_130_1.time_ and arg_130_1.time_ <= var_133_21 + arg_133_0 and not isNil(var_133_20) and arg_130_1.var_.characterEffect1059ui_story == nil then
				arg_130_1.var_.characterEffect1059ui_story = var_133_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_133_22 = 0.200000002980232

			if var_133_21 <= arg_130_1.time_ and arg_130_1.time_ < var_133_21 + var_133_22 and not isNil(var_133_20) then
				local var_133_23 = (arg_130_1.time_ - var_133_21) / var_133_22

				if arg_130_1.var_.characterEffect1059ui_story and not isNil(var_133_20) then
					local var_133_24 = Mathf.Lerp(0, 0.5, var_133_23)

					arg_130_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_130_1.var_.characterEffect1059ui_story.fillRatio = var_133_24
				end
			end

			if arg_130_1.time_ >= var_133_21 + var_133_22 and arg_130_1.time_ < var_133_21 + var_133_22 + arg_133_0 and not isNil(var_133_20) and arg_130_1.var_.characterEffect1059ui_story then
				local var_133_25 = 0.5

				arg_130_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_130_1.var_.characterEffect1059ui_story.fillRatio = var_133_25
			end

			local var_133_26 = 0
			local var_133_27 = 1.175

			if var_133_26 < arg_130_1.time_ and arg_130_1.time_ <= var_133_26 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, false)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_130_1.iconTrs_.gameObject, false)
				arg_130_1.callingController_:SetSelectedState("normal")

				local var_133_28 = arg_130_1:GetWordFromCfg(325102031)
				local var_133_29 = arg_130_1:FormatText(var_133_28.content)

				arg_130_1.text_.text = var_133_29

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_30 = 47
				local var_133_31 = utf8.len(var_133_29)
				local var_133_32 = var_133_30 <= 0 and var_133_27 or var_133_27 * (var_133_31 / var_133_30)

				if var_133_32 > 0 and var_133_27 < var_133_32 then
					arg_130_1.talkMaxDuration = var_133_32

					if var_133_32 + var_133_26 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_32 + var_133_26
					end
				end

				arg_130_1.text_.text = var_133_29
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)
				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_33 = math.max(var_133_27, arg_130_1.talkMaxDuration)

			if var_133_26 <= arg_130_1.time_ and arg_130_1.time_ < var_133_26 + var_133_33 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - var_133_26) / var_133_33

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= var_133_26 + var_133_33 and arg_130_1.time_ < var_133_26 + var_133_33 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1077ui_story",
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
	Play325102032 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 325102032
		arg_134_1.duration_ = 5.3

		local var_134_0 = {
			zh = 3.133,
			ja = 5.3
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
				arg_134_0:Play325102033(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			local var_137_0 = arg_134_1.actors_["1077ui_story"].transform
			local var_137_1 = 0

			if var_137_1 < arg_134_1.time_ and arg_134_1.time_ <= var_137_1 + arg_137_0 then
				arg_134_1.var_.moveOldPos1077ui_story = var_137_0.localPosition

				local var_137_2 = GameObjectTools.GetOrAddComponent(var_137_0.gameObject, typeof(DynamicBoneHelper))

				if var_137_2 then
					var_137_2:EnableDynamicBone(false)
				end
			end

			local var_137_3 = 0.001

			if var_137_1 <= arg_134_1.time_ and arg_134_1.time_ < var_137_1 + var_137_3 then
				local var_137_4 = (arg_134_1.time_ - var_137_1) / var_137_3
				local var_137_5 = Vector3.New(-0.03, -1.02, -5.92)

				var_137_0.localPosition = Vector3.Lerp(arg_134_1.var_.moveOldPos1077ui_story, var_137_5, var_137_4)

				local var_137_6 = manager.ui.mainCamera.transform.position - var_137_0.position

				var_137_0.forward = Vector3.New(var_137_6.x, var_137_6.y, var_137_6.z)

				local var_137_7 = var_137_0.localEulerAngles

				var_137_7.z = 0
				var_137_7.x = 0
				var_137_0.localEulerAngles = var_137_7
			end

			if arg_134_1.time_ >= var_137_1 + var_137_3 and arg_134_1.time_ < var_137_1 + var_137_3 + arg_137_0 then
				var_137_0.localPosition = Vector3.New(-0.03, -1.02, -5.92)

				local var_137_8 = manager.ui.mainCamera.transform.position - var_137_0.position

				var_137_0.forward = Vector3.New(var_137_8.x, var_137_8.y, var_137_8.z)

				local var_137_9 = var_137_0.localEulerAngles

				var_137_9.z = 0
				var_137_9.x = 0
				var_137_0.localEulerAngles = var_137_9

				local var_137_10 = GameObjectTools.GetOrAddComponent(var_137_0.gameObject, typeof(DynamicBoneHelper))

				if var_137_10 then
					var_137_10:EnableDynamicBone(true)
				end
			end

			local var_137_11 = arg_134_1.actors_["1077ui_story"]
			local var_137_12 = 0

			if var_137_12 < arg_134_1.time_ and arg_134_1.time_ <= var_137_12 + arg_137_0 and not isNil(var_137_11) and arg_134_1.var_.characterEffect1077ui_story == nil then
				arg_134_1.var_.characterEffect1077ui_story = var_137_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_137_13 = 0.200000002980232

			if var_137_12 <= arg_134_1.time_ and arg_134_1.time_ < var_137_12 + var_137_13 and not isNil(var_137_11) then
				local var_137_14 = (arg_134_1.time_ - var_137_12) / var_137_13

				if arg_134_1.var_.characterEffect1077ui_story and not isNil(var_137_11) then
					arg_134_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_134_1.time_ >= var_137_12 + var_137_13 and arg_134_1.time_ < var_137_12 + var_137_13 + arg_137_0 and not isNil(var_137_11) and arg_134_1.var_.characterEffect1077ui_story then
				arg_134_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_137_15 = 0

			if var_137_15 < arg_134_1.time_ and arg_134_1.time_ <= var_137_15 + arg_137_0 then
				arg_134_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_137_16 = 0
			local var_137_17 = 1

			if var_137_16 < arg_134_1.time_ and arg_134_1.time_ <= var_137_16 + arg_137_0 then
				local var_137_18 = "play"
				local var_137_19 = "effect"

				arg_134_1:AudioAction(var_137_18, var_137_19, "se_story_123_01", "se_story_123_01_explosion", "")
			end

			local var_137_20 = 0
			local var_137_21 = 0.35

			if var_137_20 < arg_134_1.time_ and arg_134_1.time_ <= var_137_20 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, true)

				local var_137_22 = arg_134_1:FormatText(StoryNameCfg[1467].name)

				arg_134_1.leftNameTxt_.text = var_137_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_134_1.leftNameTxt_.transform)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1.leftNameTxt_.text)
				SetActive(arg_134_1.iconTrs_.gameObject, false)
				arg_134_1.callingController_:SetSelectedState("normal")

				local var_137_23 = arg_134_1:GetWordFromCfg(325102032)
				local var_137_24 = arg_134_1:FormatText(var_137_23.content)

				arg_134_1.text_.text = var_137_24

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_25 = 14
				local var_137_26 = utf8.len(var_137_24)
				local var_137_27 = var_137_25 <= 0 and var_137_21 or var_137_21 * (var_137_26 / var_137_25)

				if var_137_27 > 0 and var_137_21 < var_137_27 then
					arg_134_1.talkMaxDuration = var_137_27

					if var_137_27 + var_137_20 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_27 + var_137_20
					end
				end

				arg_134_1.text_.text = var_137_24
				arg_134_1.typewritter.percent = 0

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325102", "325102032", "story_v_out_325102.awb") ~= 0 then
					local var_137_28 = manager.audio:GetVoiceLength("story_v_out_325102", "325102032", "story_v_out_325102.awb") / 1000

					if var_137_28 + var_137_20 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_28 + var_137_20
					end

					if var_137_23.prefab_name ~= "" and arg_134_1.actors_[var_137_23.prefab_name] ~= nil then
						local var_137_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_134_1.actors_[var_137_23.prefab_name].transform, "story_v_out_325102", "325102032", "story_v_out_325102.awb")

						arg_134_1:RecordAudio("325102032", var_137_29)
						arg_134_1:RecordAudio("325102032", var_137_29)
					else
						arg_134_1:AudioAction("play", "voice", "story_v_out_325102", "325102032", "story_v_out_325102.awb")
					end

					arg_134_1:RecordHistoryTalkVoice("story_v_out_325102", "325102032", "story_v_out_325102.awb")
				end

				arg_134_1:RecordContent(arg_134_1.text_.text)
			end

			local var_137_30 = math.max(var_137_21, arg_134_1.talkMaxDuration)

			if var_137_20 <= arg_134_1.time_ and arg_134_1.time_ < var_137_20 + var_137_30 then
				arg_134_1.typewritter.percent = (arg_134_1.time_ - var_137_20) / var_137_30

				arg_134_1.typewritter:SetDirty()
			end

			if arg_134_1.time_ >= var_137_20 + var_137_30 and arg_134_1.time_ < var_137_20 + var_137_30 + arg_137_0 then
				arg_134_1.typewritter.percent = 1

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(true)
			end
		end

		arg_134_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_134_1:InitPlayNodeList()
	end,
	Play325102033 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 325102033
		arg_138_1.duration_ = 6.43

		local var_138_0 = {
			zh = 6.43333333333333,
			ja = 5.83333333333333
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
				arg_138_0:Play325102034(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			local var_141_0 = arg_138_1.actors_["1077ui_story"].transform
			local var_141_1 = 0

			if var_141_1 < arg_138_1.time_ and arg_138_1.time_ <= var_141_1 + arg_141_0 then
				arg_138_1.var_.moveOldPos1077ui_story = var_141_0.localPosition

				local var_141_2 = GameObjectTools.GetOrAddComponent(var_141_0.gameObject, typeof(DynamicBoneHelper))

				if var_141_2 then
					var_141_2:EnableDynamicBone(false)
				end
			end

			local var_141_3 = 0.001

			if var_141_1 <= arg_138_1.time_ and arg_138_1.time_ < var_141_1 + var_141_3 then
				local var_141_4 = (arg_138_1.time_ - var_141_1) / var_141_3
				local var_141_5 = Vector3.New(0, 100, 0)

				var_141_0.localPosition = Vector3.Lerp(arg_138_1.var_.moveOldPos1077ui_story, var_141_5, var_141_4)

				local var_141_6 = manager.ui.mainCamera.transform.position - var_141_0.position

				var_141_0.forward = Vector3.New(var_141_6.x, var_141_6.y, var_141_6.z)

				local var_141_7 = var_141_0.localEulerAngles

				var_141_7.z = 0
				var_141_7.x = 0
				var_141_0.localEulerAngles = var_141_7
			end

			if arg_138_1.time_ >= var_141_1 + var_141_3 and arg_138_1.time_ < var_141_1 + var_141_3 + arg_141_0 then
				var_141_0.localPosition = Vector3.New(0, 100, 0)

				local var_141_8 = manager.ui.mainCamera.transform.position - var_141_0.position

				var_141_0.forward = Vector3.New(var_141_8.x, var_141_8.y, var_141_8.z)

				local var_141_9 = var_141_0.localEulerAngles

				var_141_9.z = 0
				var_141_9.x = 0
				var_141_0.localEulerAngles = var_141_9

				local var_141_10 = GameObjectTools.GetOrAddComponent(var_141_0.gameObject, typeof(DynamicBoneHelper))

				if var_141_10 then
					var_141_10:EnableDynamicBone(true)
				end
			end

			local var_141_11 = manager.ui.mainCamera.transform
			local var_141_12 = 0

			if var_141_12 < arg_138_1.time_ and arg_138_1.time_ <= var_141_12 + arg_141_0 then
				local var_141_13 = arg_138_1.var_.effect46546
				local var_141_14
				local var_141_15 = var_141_11

				if not var_141_13 then
					var_141_13 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_rockfall"), var_141_15)
					var_141_13.name = "46546"
					arg_138_1.var_.effect46546 = var_141_13
				else
					var_141_13.transform:SetParent(var_141_15)
				end

				var_141_13.transform.localPosition = Vector3.New(0, 0, -2.74)
				var_141_13.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_141_16 = 1.7777777777777777
				local var_141_17 = Screen.width / Screen.height
				local var_141_18 = var_141_17 / var_141_16
				local var_141_19 = Mathf.Max(var_141_16 / var_141_17, 1)

				var_141_13.transform.localScale = Vector3.New(var_141_13.transform.localScale.x * var_141_18, var_141_13.transform.localScale.y * var_141_19, var_141_13.transform.localScale.z)
			end

			local var_141_20 = 0

			if var_141_20 < arg_138_1.time_ and arg_138_1.time_ <= var_141_20 + arg_141_0 then
				arg_138_1.allBtn_.enabled = false
			end

			local var_141_21 = 2.05833333333333

			if arg_138_1.time_ >= var_141_20 + var_141_21 and arg_138_1.time_ < var_141_20 + var_141_21 + arg_141_0 then
				arg_138_1.allBtn_.enabled = true
			end

			local var_141_22 = manager.ui.mainCamera.transform
			local var_141_23 = 0

			if var_141_23 < arg_138_1.time_ and arg_138_1.time_ <= var_141_23 + arg_141_0 then
				local var_141_24 = arg_138_1.var_.effectsdsdsd
				local var_141_25
				local var_141_26 = var_141_22

				if not var_141_24 then
					var_141_24 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_heibaishan"), var_141_26)
					var_141_24.name = "sdsdsd"
					arg_138_1.var_.effectsdsdsd = var_141_24
				else
					var_141_24.transform:SetParent(var_141_26)
				end

				var_141_24.transform.localPosition = Vector3.New(0, 0, 0)
				var_141_24.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_141_27 = 1.7777777777777777
				local var_141_28 = Screen.width / Screen.height
				local var_141_29 = var_141_28 / var_141_27
				local var_141_30 = Mathf.Max(var_141_27 / var_141_28, 1)

				var_141_24.transform.localScale = Vector3.New(var_141_24.transform.localScale.x * var_141_29, var_141_24.transform.localScale.y * var_141_30, var_141_24.transform.localScale.z)
			end

			local var_141_31 = manager.ui.mainCamera.transform
			local var_141_32 = 2.05833333333333

			if var_141_32 < arg_138_1.time_ and arg_138_1.time_ <= var_141_32 + arg_141_0 then
				local var_141_33 = arg_138_1.var_.effectsdsdsd

				if var_141_33 then
					Object.Destroy(var_141_33)

					arg_138_1.var_.effectsdsdsd = nil
				end
			end

			local var_141_34 = 0
			local var_141_35 = 1.06666666666667

			if var_141_34 < arg_138_1.time_ and arg_138_1.time_ <= var_141_34 + arg_141_0 then
				local var_141_36 = "play"
				local var_141_37 = "effect"

				arg_138_1:AudioAction(var_141_36, var_141_37, "se_story_123_01", "se_story_123_01_explosion", "")
			end

			if arg_138_1.frameCnt_ <= 1 then
				arg_138_1.dialog_:SetActive(false)
			end

			local var_141_38 = 1.73333333333333
			local var_141_39 = 0.325

			if var_141_38 < arg_138_1.time_ and arg_138_1.time_ <= var_141_38 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0

				arg_138_1.dialog_:SetActive(true)

				arg_138_1.dialogCg_.alpha = 0

				local var_141_40 = LeanTween.value(arg_138_1.dialog_, 0, 1, 0.3)

				var_141_40:setOnUpdate(LuaHelper.FloatAction(function(arg_142_0)
					arg_138_1.dialogCg_.alpha = arg_142_0
				end))
				var_141_40:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_138_1.dialog_)
					var_141_40:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_138_1.duration_ = arg_138_1.duration_ + 0.3

				SetActive(arg_138_1.leftNameGo_, true)

				local var_141_41 = arg_138_1:FormatText(StoryNameCfg[1455].name)

				arg_138_1.leftNameTxt_.text = var_141_41

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_138_1.leftNameTxt_.transform)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1.leftNameTxt_.text)
				SetActive(arg_138_1.iconTrs_.gameObject, true)
				arg_138_1.iconController_:SetSelectedState("hero")

				arg_138_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_138_1.callingController_:SetSelectedState("normal")

				arg_138_1.keyicon_.color = Color.New(1, 1, 1)
				arg_138_1.icon_.color = Color.New(1, 1, 1)

				local var_141_42 = arg_138_1:GetWordFromCfg(325102033)
				local var_141_43 = arg_138_1:FormatText(var_141_42.content)

				arg_138_1.text_.text = var_141_43

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_44 = 13
				local var_141_45 = utf8.len(var_141_43)
				local var_141_46 = var_141_44 <= 0 and var_141_39 or var_141_39 * (var_141_45 / var_141_44)

				if var_141_46 > 0 and var_141_39 < var_141_46 then
					arg_138_1.talkMaxDuration = var_141_46
					var_141_38 = var_141_38 + 0.3

					if var_141_46 + var_141_38 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_46 + var_141_38
					end
				end

				arg_138_1.text_.text = var_141_43
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325102", "325102033", "story_v_out_325102.awb") ~= 0 then
					local var_141_47 = manager.audio:GetVoiceLength("story_v_out_325102", "325102033", "story_v_out_325102.awb") / 1000

					if var_141_47 + var_141_38 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_47 + var_141_38
					end

					if var_141_42.prefab_name ~= "" and arg_138_1.actors_[var_141_42.prefab_name] ~= nil then
						local var_141_48 = LuaForUtil.PlayVoiceWithCriLipsync(arg_138_1.actors_[var_141_42.prefab_name].transform, "story_v_out_325102", "325102033", "story_v_out_325102.awb")

						arg_138_1:RecordAudio("325102033", var_141_48)
						arg_138_1:RecordAudio("325102033", var_141_48)
					else
						arg_138_1:AudioAction("play", "voice", "story_v_out_325102", "325102033", "story_v_out_325102.awb")
					end

					arg_138_1:RecordHistoryTalkVoice("story_v_out_325102", "325102033", "story_v_out_325102.awb")
				end

				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_49 = var_141_38 + 0.3
			local var_141_50 = math.max(var_141_39, arg_138_1.talkMaxDuration)

			if var_141_49 <= arg_138_1.time_ and arg_138_1.time_ < var_141_49 + var_141_50 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - var_141_49) / var_141_50

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= var_141_49 + var_141_50 and arg_138_1.time_ < var_141_49 + var_141_50 + arg_141_0 then
				arg_138_1.typewritter.percent = 1

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(true)
			end
		end

		arg_138_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "",
				frequencyGain = 1,
				className = "StoryShakeNode",
				noiseSettingsAssetPath = "Camera/Noise/6D_Shake",
				duration = 1.06666666666667,
				amplitudeGain = 1,
				startTime = 0.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.None,
				shakeTarget = StoryPlayerConst.SHAKE_TARGET.CAMERA
			},
			{
				assetPath = "",
				actorName = "",
				frequencyGain = 1,
				className = "StoryShakeNode",
				noiseSettingsAssetPath = "Camera/Noise/6D_Shake",
				duration = 1.06666666666667,
				amplitudeGain = 1,
				startTime = 0.666666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.None,
				shakeTarget = StoryPlayerConst.SHAKE_TARGET.CAMERA
			},
			{
				assetPath = "",
				actorName = "",
				frequency = 9,
				className = "StoryShakeNode",
				duration = 1.36862460188568,
				startTime = 0.164708731447657,
				actorType = StoryPlayerConst.ACTOR_TYPE.None,
				shakeTarget = StoryPlayerConst.SHAKE_TARGET.DIALOG_HEAD,
				offset = Vector3.New(6, 0.2, 0.1)
			}
		}

		arg_138_1:InitPlayNodeList()
	end,
	Play325102034 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 325102034
		arg_144_1.duration_ = 5

		SetActive(arg_144_1.tipsGo_, false)

		function arg_144_1.onSingleLineFinish_()
			arg_144_1.onSingleLineUpdate_ = nil
			arg_144_1.onSingleLineFinish_ = nil
			arg_144_1.state_ = "waiting"
		end

		function arg_144_1.playNext_(arg_146_0)
			if arg_146_0 == 1 then
				arg_144_0:Play325102035(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			local var_147_0 = arg_144_1.actors_["1059ui_story"].transform
			local var_147_1 = 0

			if var_147_1 < arg_144_1.time_ and arg_144_1.time_ <= var_147_1 + arg_147_0 then
				arg_144_1.var_.moveOldPos1059ui_story = var_147_0.localPosition
			end

			local var_147_2 = 0.001

			if var_147_1 <= arg_144_1.time_ and arg_144_1.time_ < var_147_1 + var_147_2 then
				local var_147_3 = (arg_144_1.time_ - var_147_1) / var_147_2
				local var_147_4 = Vector3.New(0, 100, 0)

				var_147_0.localPosition = Vector3.Lerp(arg_144_1.var_.moveOldPos1059ui_story, var_147_4, var_147_3)

				local var_147_5 = manager.ui.mainCamera.transform.position - var_147_0.position

				var_147_0.forward = Vector3.New(var_147_5.x, var_147_5.y, var_147_5.z)

				local var_147_6 = var_147_0.localEulerAngles

				var_147_6.z = 0
				var_147_6.x = 0
				var_147_0.localEulerAngles = var_147_6
			end

			if arg_144_1.time_ >= var_147_1 + var_147_2 and arg_144_1.time_ < var_147_1 + var_147_2 + arg_147_0 then
				var_147_0.localPosition = Vector3.New(0, 100, 0)

				local var_147_7 = manager.ui.mainCamera.transform.position - var_147_0.position

				var_147_0.forward = Vector3.New(var_147_7.x, var_147_7.y, var_147_7.z)

				local var_147_8 = var_147_0.localEulerAngles

				var_147_8.z = 0
				var_147_8.x = 0
				var_147_0.localEulerAngles = var_147_8
			end

			local var_147_9 = arg_144_1.actors_["1077ui_story"].transform
			local var_147_10 = 0

			if var_147_10 < arg_144_1.time_ and arg_144_1.time_ <= var_147_10 + arg_147_0 then
				arg_144_1.var_.moveOldPos1077ui_story = var_147_9.localPosition

				local var_147_11 = GameObjectTools.GetOrAddComponent(var_147_9.gameObject, typeof(DynamicBoneHelper))

				if var_147_11 then
					var_147_11:EnableDynamicBone(false)
				end
			end

			local var_147_12 = 0.001

			if var_147_10 <= arg_144_1.time_ and arg_144_1.time_ < var_147_10 + var_147_12 then
				local var_147_13 = (arg_144_1.time_ - var_147_10) / var_147_12
				local var_147_14 = Vector3.New(0, 100, 0)

				var_147_9.localPosition = Vector3.Lerp(arg_144_1.var_.moveOldPos1077ui_story, var_147_14, var_147_13)

				local var_147_15 = manager.ui.mainCamera.transform.position - var_147_9.position

				var_147_9.forward = Vector3.New(var_147_15.x, var_147_15.y, var_147_15.z)

				local var_147_16 = var_147_9.localEulerAngles

				var_147_16.z = 0
				var_147_16.x = 0
				var_147_9.localEulerAngles = var_147_16
			end

			if arg_144_1.time_ >= var_147_10 + var_147_12 and arg_144_1.time_ < var_147_10 + var_147_12 + arg_147_0 then
				var_147_9.localPosition = Vector3.New(0, 100, 0)

				local var_147_17 = manager.ui.mainCamera.transform.position - var_147_9.position

				var_147_9.forward = Vector3.New(var_147_17.x, var_147_17.y, var_147_17.z)

				local var_147_18 = var_147_9.localEulerAngles

				var_147_18.z = 0
				var_147_18.x = 0
				var_147_9.localEulerAngles = var_147_18

				local var_147_19 = GameObjectTools.GetOrAddComponent(var_147_9.gameObject, typeof(DynamicBoneHelper))

				if var_147_19 then
					var_147_19:EnableDynamicBone(true)
				end
			end

			local var_147_20 = arg_144_1.actors_["1059ui_story"]
			local var_147_21 = 0

			if var_147_21 < arg_144_1.time_ and arg_144_1.time_ <= var_147_21 + arg_147_0 and not isNil(var_147_20) and arg_144_1.var_.characterEffect1059ui_story == nil then
				arg_144_1.var_.characterEffect1059ui_story = var_147_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_147_22 = 0.200000002980232

			if var_147_21 <= arg_144_1.time_ and arg_144_1.time_ < var_147_21 + var_147_22 and not isNil(var_147_20) then
				local var_147_23 = (arg_144_1.time_ - var_147_21) / var_147_22

				if arg_144_1.var_.characterEffect1059ui_story and not isNil(var_147_20) then
					local var_147_24 = Mathf.Lerp(0, 0.5, var_147_23)

					arg_144_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_144_1.var_.characterEffect1059ui_story.fillRatio = var_147_24
				end
			end

			if arg_144_1.time_ >= var_147_21 + var_147_22 and arg_144_1.time_ < var_147_21 + var_147_22 + arg_147_0 and not isNil(var_147_20) and arg_144_1.var_.characterEffect1059ui_story then
				local var_147_25 = 0.5

				arg_144_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_144_1.var_.characterEffect1059ui_story.fillRatio = var_147_25
			end

			local var_147_26 = 0
			local var_147_27 = 1

			if var_147_26 < arg_144_1.time_ and arg_144_1.time_ <= var_147_26 + arg_147_0 then
				local var_147_28 = "play"
				local var_147_29 = "effect"

				arg_144_1:AudioAction(var_147_28, var_147_29, "ui_battle", "ui_battle_stopbgm", "")
			end

			local var_147_30 = 0
			local var_147_31 = 0.85

			if var_147_30 < arg_144_1.time_ and arg_144_1.time_ <= var_147_30 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, false)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_144_1.iconTrs_.gameObject, false)
				arg_144_1.callingController_:SetSelectedState("normal")

				local var_147_32 = arg_144_1:GetWordFromCfg(325102034)
				local var_147_33 = arg_144_1:FormatText(var_147_32.content)

				arg_144_1.text_.text = var_147_33

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_34 = 34
				local var_147_35 = utf8.len(var_147_33)
				local var_147_36 = var_147_34 <= 0 and var_147_31 or var_147_31 * (var_147_35 / var_147_34)

				if var_147_36 > 0 and var_147_31 < var_147_36 then
					arg_144_1.talkMaxDuration = var_147_36

					if var_147_36 + var_147_30 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_36 + var_147_30
					end
				end

				arg_144_1.text_.text = var_147_33
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)
				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_37 = math.max(var_147_31, arg_144_1.talkMaxDuration)

			if var_147_30 <= arg_144_1.time_ and arg_144_1.time_ < var_147_30 + var_147_37 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_30) / var_147_37

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_30 + var_147_37 and arg_144_1.time_ < var_147_30 + var_147_37 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1077ui_story",
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
	Play325102035 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 325102035
		arg_148_1.duration_ = 7.77

		SetActive(arg_148_1.tipsGo_, false)

		function arg_148_1.onSingleLineFinish_()
			arg_148_1.onSingleLineUpdate_ = nil
			arg_148_1.onSingleLineFinish_ = nil
			arg_148_1.state_ = "waiting"
		end

		function arg_148_1.playNext_(arg_150_0)
			if arg_150_0 == 1 then
				arg_148_0:Play325102036(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			local var_151_0 = "J22f"

			if arg_148_1.bgs_[var_151_0] == nil then
				local var_151_1 = Object.Instantiate(arg_148_1.paintGo_)

				var_151_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_151_0)
				var_151_1.name = var_151_0
				var_151_1.transform.parent = arg_148_1.stage_.transform
				var_151_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_148_1.bgs_[var_151_0] = var_151_1
			end

			local var_151_2 = 1.5

			if var_151_2 < arg_148_1.time_ and arg_148_1.time_ <= var_151_2 + arg_151_0 then
				local var_151_3 = manager.ui.mainCamera.transform.localPosition
				local var_151_4 = Vector3.New(0, 0, 10) + Vector3.New(var_151_3.x, var_151_3.y, 0)
				local var_151_5 = arg_148_1.bgs_.J22f

				var_151_5.transform.localPosition = var_151_4
				var_151_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_151_6 = var_151_5:GetComponent("SpriteRenderer")

				if var_151_6 and var_151_6.sprite then
					local var_151_7 = (var_151_5.transform.localPosition - var_151_3).z
					local var_151_8 = manager.ui.mainCameraCom_
					local var_151_9 = 2 * var_151_7 * Mathf.Tan(var_151_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_151_10 = var_151_9 * var_151_8.aspect
					local var_151_11 = var_151_6.sprite.bounds.size.x
					local var_151_12 = var_151_6.sprite.bounds.size.y
					local var_151_13 = var_151_10 / var_151_11
					local var_151_14 = var_151_9 / var_151_12
					local var_151_15 = var_151_14 < var_151_13 and var_151_13 or var_151_14

					var_151_5.transform.localScale = Vector3.New(var_151_15, var_151_15, 0)
				end

				for iter_151_0, iter_151_1 in pairs(arg_148_1.bgs_) do
					if iter_151_0 ~= "J22f" then
						iter_151_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_151_16 = 1.5

			if var_151_16 < arg_148_1.time_ and arg_148_1.time_ <= var_151_16 + arg_151_0 then
				arg_148_1.allBtn_.enabled = false
			end

			local var_151_17 = 0.3

			if arg_148_1.time_ >= var_151_16 + var_151_17 and arg_148_1.time_ < var_151_16 + var_151_17 + arg_151_0 then
				arg_148_1.allBtn_.enabled = true
			end

			local var_151_18 = 0

			if var_151_18 < arg_148_1.time_ and arg_148_1.time_ <= var_151_18 + arg_151_0 then
				arg_148_1.mask_.enabled = true
				arg_148_1.mask_.raycastTarget = true

				arg_148_1:SetGaussion(false)
			end

			local var_151_19 = 1.5

			if var_151_18 <= arg_148_1.time_ and arg_148_1.time_ < var_151_18 + var_151_19 then
				local var_151_20 = (arg_148_1.time_ - var_151_18) / var_151_19
				local var_151_21 = Color.New(0, 0, 0)

				var_151_21.a = Mathf.Lerp(0, 1, var_151_20)
				arg_148_1.mask_.color = var_151_21
			end

			if arg_148_1.time_ >= var_151_18 + var_151_19 and arg_148_1.time_ < var_151_18 + var_151_19 + arg_151_0 then
				local var_151_22 = Color.New(0, 0, 0)

				var_151_22.a = 1
				arg_148_1.mask_.color = var_151_22
			end

			local var_151_23 = 1.5

			if var_151_23 < arg_148_1.time_ and arg_148_1.time_ <= var_151_23 + arg_151_0 then
				arg_148_1.mask_.enabled = true
				arg_148_1.mask_.raycastTarget = true

				arg_148_1:SetGaussion(false)
			end

			local var_151_24 = 2

			if var_151_23 <= arg_148_1.time_ and arg_148_1.time_ < var_151_23 + var_151_24 then
				local var_151_25 = (arg_148_1.time_ - var_151_23) / var_151_24
				local var_151_26 = Color.New(0, 0, 0)

				var_151_26.a = Mathf.Lerp(1, 0, var_151_25)
				arg_148_1.mask_.color = var_151_26
			end

			if arg_148_1.time_ >= var_151_23 + var_151_24 and arg_148_1.time_ < var_151_23 + var_151_24 + arg_151_0 then
				local var_151_27 = Color.New(0, 0, 0)
				local var_151_28 = 0

				arg_148_1.mask_.enabled = false
				var_151_27.a = var_151_28
				arg_148_1.mask_.color = var_151_27
			end

			local var_151_29 = manager.ui.mainCamera.transform
			local var_151_30 = 1.5

			if var_151_30 < arg_148_1.time_ and arg_148_1.time_ <= var_151_30 + arg_151_0 then
				local var_151_31 = arg_148_1.var_.effect46546

				if var_151_31 then
					Object.Destroy(var_151_31)

					arg_148_1.var_.effect46546 = nil
				end
			end

			local var_151_32 = 1.2
			local var_151_33 = 1

			if var_151_32 < arg_148_1.time_ and arg_148_1.time_ <= var_151_32 + arg_151_0 then
				local var_151_34 = "play"
				local var_151_35 = "effect"

				arg_148_1:AudioAction(var_151_34, var_151_35, "se_story_148", "se_story_148_amb_lost_city", "")
			end

			local var_151_36 = 1.4
			local var_151_37 = 1

			if var_151_36 < arg_148_1.time_ and arg_148_1.time_ <= var_151_36 + arg_151_0 then
				local var_151_38 = "play"
				local var_151_39 = "effect"

				arg_148_1:AudioAction(var_151_38, var_151_39, "se_story_148", "se_story_148_footstep04", "")
			end

			local var_151_40 = 0
			local var_151_41 = 1

			if var_151_40 < arg_148_1.time_ and arg_148_1.time_ <= var_151_40 + arg_151_0 then
				local var_151_42 = "play"
				local var_151_43 = "music"

				arg_148_1:AudioAction(var_151_42, var_151_43, "bgm_activity_2_0_story_oldtown", "bgm_activity_2_0_story_oldtown", "bgm_activity_2_0_story_oldtown.awb")

				local var_151_44 = ""
				local var_151_45 = manager.audio:GetAudioName("bgm_activity_2_0_story_oldtown", "bgm_activity_2_0_story_oldtown")

				if var_151_45 ~= "" then
					if arg_148_1.bgmTxt_.text ~= var_151_45 and arg_148_1.bgmTxt_.text ~= "" then
						if arg_148_1.bgmTxt2_.text ~= "" then
							arg_148_1.bgmTxt_.text = arg_148_1.bgmTxt2_.text
						end

						arg_148_1.bgmTxt2_.text = var_151_45

						arg_148_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_148_1.bgmTxt_.text = var_151_45
						arg_148_1.bgmTxt2_.text = var_151_45
					end

					if arg_148_1.bgmTimer then
						arg_148_1.bgmTimer:Stop()

						arg_148_1.bgmTimer = nil
					end

					if arg_148_1.settingData.show_music_name == 1 then
						arg_148_1.musicController:SetSelectedState("show")
						arg_148_1.musicAnimator_:Play("open", 0, 0)

						if arg_148_1.settingData.music_time ~= 0 then
							arg_148_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_148_1.settingData.music_time), function()
								if arg_148_1 == nil or isNil(arg_148_1.bgmTxt_) then
									return
								end

								arg_148_1.musicController:SetSelectedState("hide")
								arg_148_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_148_1.frameCnt_ <= 1 then
				arg_148_1.dialog_:SetActive(false)
			end

			local var_151_46 = 2.76666666666667
			local var_151_47 = 1.15

			if var_151_46 < arg_148_1.time_ and arg_148_1.time_ <= var_151_46 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0

				arg_148_1.dialog_:SetActive(true)

				arg_148_1.dialogCg_.alpha = 0

				local var_151_48 = LeanTween.value(arg_148_1.dialog_, 0, 1, 0.3)

				var_151_48:setOnUpdate(LuaHelper.FloatAction(function(arg_153_0)
					arg_148_1.dialogCg_.alpha = arg_153_0
				end))
				var_151_48:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_148_1.dialog_)
					var_151_48:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_148_1.duration_ = arg_148_1.duration_ + 0.3

				SetActive(arg_148_1.leftNameGo_, false)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_148_1.iconTrs_.gameObject, false)
				arg_148_1.callingController_:SetSelectedState("normal")

				local var_151_49 = arg_148_1:GetWordFromCfg(325102035)
				local var_151_50 = arg_148_1:FormatText(var_151_49.content)

				arg_148_1.text_.text = var_151_50

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_51 = 46
				local var_151_52 = utf8.len(var_151_50)
				local var_151_53 = var_151_51 <= 0 and var_151_47 or var_151_47 * (var_151_52 / var_151_51)

				if var_151_53 > 0 and var_151_47 < var_151_53 then
					arg_148_1.talkMaxDuration = var_151_53
					var_151_46 = var_151_46 + 0.3

					if var_151_53 + var_151_46 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_53 + var_151_46
					end
				end

				arg_148_1.text_.text = var_151_50
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)
				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_54 = var_151_46 + 0.3
			local var_151_55 = math.max(var_151_47, arg_148_1.talkMaxDuration)

			if var_151_54 <= arg_148_1.time_ and arg_148_1.time_ < var_151_54 + var_151_55 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_54) / var_151_55

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_54 + var_151_55 and arg_148_1.time_ < var_151_54 + var_151_55 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {}

		arg_148_1:InitPlayNodeList()
	end,
	Play325102036 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 325102036
		arg_155_1.duration_ = 5

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play325102037(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = 0
			local var_158_1 = 1

			if var_158_0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_0 + arg_158_0 then
				local var_158_2 = "play"
				local var_158_3 = "effect"

				arg_155_1:AudioAction(var_158_2, var_158_3, "se_story_side_1093", "se_story_1093_message_calling", "")
			end

			local var_158_4 = 0
			local var_158_5 = 1.1

			if var_158_4 < arg_155_1.time_ and arg_155_1.time_ <= var_158_4 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, false)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_6 = arg_155_1:GetWordFromCfg(325102036)
				local var_158_7 = arg_155_1:FormatText(var_158_6.content)

				arg_155_1.text_.text = var_158_7

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_8 = 44
				local var_158_9 = utf8.len(var_158_7)
				local var_158_10 = var_158_8 <= 0 and var_158_5 or var_158_5 * (var_158_9 / var_158_8)

				if var_158_10 > 0 and var_158_5 < var_158_10 then
					arg_155_1.talkMaxDuration = var_158_10

					if var_158_10 + var_158_4 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_10 + var_158_4
					end
				end

				arg_155_1.text_.text = var_158_7
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)
				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_11 = math.max(var_158_5, arg_155_1.talkMaxDuration)

			if var_158_4 <= arg_155_1.time_ and arg_155_1.time_ < var_158_4 + var_158_11 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_4) / var_158_11

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_4 + var_158_11 and arg_155_1.time_ < var_158_4 + var_158_11 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {}

		arg_155_1:InitPlayNodeList()
	end,
	Play325102037 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 325102037
		arg_159_1.duration_ = 5.37

		local var_159_0 = {
			zh = 2.3,
			ja = 5.366
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
				arg_159_0:Play325102038(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = arg_159_1.actors_["1077ui_story"].transform
			local var_162_1 = 0

			if var_162_1 < arg_159_1.time_ and arg_159_1.time_ <= var_162_1 + arg_162_0 then
				arg_159_1.var_.moveOldPos1077ui_story = var_162_0.localPosition

				local var_162_2 = GameObjectTools.GetOrAddComponent(var_162_0.gameObject, typeof(DynamicBoneHelper))

				if var_162_2 then
					var_162_2:EnableDynamicBone(false)
				end
			end

			local var_162_3 = 0.001

			if var_162_1 <= arg_159_1.time_ and arg_159_1.time_ < var_162_1 + var_162_3 then
				local var_162_4 = (arg_159_1.time_ - var_162_1) / var_162_3
				local var_162_5 = Vector3.New(-0.03, -1.02, -5.92)

				var_162_0.localPosition = Vector3.Lerp(arg_159_1.var_.moveOldPos1077ui_story, var_162_5, var_162_4)

				local var_162_6 = manager.ui.mainCamera.transform.position - var_162_0.position

				var_162_0.forward = Vector3.New(var_162_6.x, var_162_6.y, var_162_6.z)

				local var_162_7 = var_162_0.localEulerAngles

				var_162_7.z = 0
				var_162_7.x = 0
				var_162_0.localEulerAngles = var_162_7
			end

			if arg_159_1.time_ >= var_162_1 + var_162_3 and arg_159_1.time_ < var_162_1 + var_162_3 + arg_162_0 then
				var_162_0.localPosition = Vector3.New(-0.03, -1.02, -5.92)

				local var_162_8 = manager.ui.mainCamera.transform.position - var_162_0.position

				var_162_0.forward = Vector3.New(var_162_8.x, var_162_8.y, var_162_8.z)

				local var_162_9 = var_162_0.localEulerAngles

				var_162_9.z = 0
				var_162_9.x = 0
				var_162_0.localEulerAngles = var_162_9

				local var_162_10 = GameObjectTools.GetOrAddComponent(var_162_0.gameObject, typeof(DynamicBoneHelper))

				if var_162_10 then
					var_162_10:EnableDynamicBone(true)
				end
			end

			local var_162_11 = arg_159_1.actors_["1077ui_story"]
			local var_162_12 = 0

			if var_162_12 < arg_159_1.time_ and arg_159_1.time_ <= var_162_12 + arg_162_0 and not isNil(var_162_11) and arg_159_1.var_.characterEffect1077ui_story == nil then
				arg_159_1.var_.characterEffect1077ui_story = var_162_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_162_13 = 0.200000002980232

			if var_162_12 <= arg_159_1.time_ and arg_159_1.time_ < var_162_12 + var_162_13 and not isNil(var_162_11) then
				local var_162_14 = (arg_159_1.time_ - var_162_12) / var_162_13

				if arg_159_1.var_.characterEffect1077ui_story and not isNil(var_162_11) then
					arg_159_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_159_1.time_ >= var_162_12 + var_162_13 and arg_159_1.time_ < var_162_12 + var_162_13 + arg_162_0 and not isNil(var_162_11) and arg_159_1.var_.characterEffect1077ui_story then
				arg_159_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_162_15 = 0

			if var_162_15 < arg_159_1.time_ and arg_159_1.time_ <= var_162_15 + arg_162_0 then
				arg_159_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action1_1")
			end

			local var_162_16 = 0

			if var_162_16 < arg_159_1.time_ and arg_159_1.time_ <= var_162_16 + arg_162_0 then
				arg_159_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_162_17 = 0
			local var_162_18 = 0.35

			if var_162_17 < arg_159_1.time_ and arg_159_1.time_ <= var_162_17 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				local var_162_19 = arg_159_1:FormatText(StoryNameCfg[1467].name)

				arg_159_1.leftNameTxt_.text = var_162_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_20 = arg_159_1:GetWordFromCfg(325102037)
				local var_162_21 = arg_159_1:FormatText(var_162_20.content)

				arg_159_1.text_.text = var_162_21

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_22 = 14
				local var_162_23 = utf8.len(var_162_21)
				local var_162_24 = var_162_22 <= 0 and var_162_18 or var_162_18 * (var_162_23 / var_162_22)

				if var_162_24 > 0 and var_162_18 < var_162_24 then
					arg_159_1.talkMaxDuration = var_162_24

					if var_162_24 + var_162_17 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_24 + var_162_17
					end
				end

				arg_159_1.text_.text = var_162_21
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325102", "325102037", "story_v_out_325102.awb") ~= 0 then
					local var_162_25 = manager.audio:GetVoiceLength("story_v_out_325102", "325102037", "story_v_out_325102.awb") / 1000

					if var_162_25 + var_162_17 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_25 + var_162_17
					end

					if var_162_20.prefab_name ~= "" and arg_159_1.actors_[var_162_20.prefab_name] ~= nil then
						local var_162_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_20.prefab_name].transform, "story_v_out_325102", "325102037", "story_v_out_325102.awb")

						arg_159_1:RecordAudio("325102037", var_162_26)
						arg_159_1:RecordAudio("325102037", var_162_26)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_325102", "325102037", "story_v_out_325102.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_325102", "325102037", "story_v_out_325102.awb")
				end

				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_27 = math.max(var_162_18, arg_159_1.talkMaxDuration)

			if var_162_17 <= arg_159_1.time_ and arg_159_1.time_ < var_162_17 + var_162_27 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_17) / var_162_27

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_17 + var_162_27 and arg_159_1.time_ < var_162_17 + var_162_27 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_159_1:InitPlayNodeList()
	end,
	Play325102038 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 325102038
		arg_163_1.duration_ = 4.5

		local var_163_0 = {
			zh = 3.366,
			ja = 4.5
		}
		local var_163_1 = manager.audio:GetLocalizationFlag()

		if var_163_0[var_163_1] ~= nil then
			arg_163_1.duration_ = var_163_0[var_163_1]
		end

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play325102039(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = 0
			local var_166_1 = 0.475

			if var_166_0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_0 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				local var_166_2 = arg_163_1:FormatText(StoryNameCfg[1467].name)

				arg_163_1.leftNameTxt_.text = var_166_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_3 = arg_163_1:GetWordFromCfg(325102038)
				local var_166_4 = arg_163_1:FormatText(var_166_3.content)

				arg_163_1.text_.text = var_166_4

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_5 = 19
				local var_166_6 = utf8.len(var_166_4)
				local var_166_7 = var_166_5 <= 0 and var_166_1 or var_166_1 * (var_166_6 / var_166_5)

				if var_166_7 > 0 and var_166_1 < var_166_7 then
					arg_163_1.talkMaxDuration = var_166_7

					if var_166_7 + var_166_0 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_7 + var_166_0
					end
				end

				arg_163_1.text_.text = var_166_4
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325102", "325102038", "story_v_out_325102.awb") ~= 0 then
					local var_166_8 = manager.audio:GetVoiceLength("story_v_out_325102", "325102038", "story_v_out_325102.awb") / 1000

					if var_166_8 + var_166_0 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_8 + var_166_0
					end

					if var_166_3.prefab_name ~= "" and arg_163_1.actors_[var_166_3.prefab_name] ~= nil then
						local var_166_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_3.prefab_name].transform, "story_v_out_325102", "325102038", "story_v_out_325102.awb")

						arg_163_1:RecordAudio("325102038", var_166_9)
						arg_163_1:RecordAudio("325102038", var_166_9)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_325102", "325102038", "story_v_out_325102.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_325102", "325102038", "story_v_out_325102.awb")
				end

				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_10 = math.max(var_166_1, arg_163_1.talkMaxDuration)

			if var_166_0 <= arg_163_1.time_ and arg_163_1.time_ < var_166_0 + var_166_10 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_0) / var_166_10

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_0 + var_166_10 and arg_163_1.time_ < var_166_0 + var_166_10 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {}

		arg_163_1:InitPlayNodeList()
	end,
	Play325102039 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 325102039
		arg_167_1.duration_ = 5

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play325102040(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = arg_167_1.actors_["1077ui_story"].transform
			local var_170_1 = 0

			if var_170_1 < arg_167_1.time_ and arg_167_1.time_ <= var_170_1 + arg_170_0 then
				arg_167_1.var_.moveOldPos1077ui_story = var_170_0.localPosition

				local var_170_2 = GameObjectTools.GetOrAddComponent(var_170_0.gameObject, typeof(DynamicBoneHelper))

				if var_170_2 then
					var_170_2:EnableDynamicBone(false)
				end
			end

			local var_170_3 = 0.001

			if var_170_1 <= arg_167_1.time_ and arg_167_1.time_ < var_170_1 + var_170_3 then
				local var_170_4 = (arg_167_1.time_ - var_170_1) / var_170_3
				local var_170_5 = Vector3.New(0, 100, 0)

				var_170_0.localPosition = Vector3.Lerp(arg_167_1.var_.moveOldPos1077ui_story, var_170_5, var_170_4)

				local var_170_6 = manager.ui.mainCamera.transform.position - var_170_0.position

				var_170_0.forward = Vector3.New(var_170_6.x, var_170_6.y, var_170_6.z)

				local var_170_7 = var_170_0.localEulerAngles

				var_170_7.z = 0
				var_170_7.x = 0
				var_170_0.localEulerAngles = var_170_7
			end

			if arg_167_1.time_ >= var_170_1 + var_170_3 and arg_167_1.time_ < var_170_1 + var_170_3 + arg_170_0 then
				var_170_0.localPosition = Vector3.New(0, 100, 0)

				local var_170_8 = manager.ui.mainCamera.transform.position - var_170_0.position

				var_170_0.forward = Vector3.New(var_170_8.x, var_170_8.y, var_170_8.z)

				local var_170_9 = var_170_0.localEulerAngles

				var_170_9.z = 0
				var_170_9.x = 0
				var_170_0.localEulerAngles = var_170_9

				local var_170_10 = GameObjectTools.GetOrAddComponent(var_170_0.gameObject, typeof(DynamicBoneHelper))

				if var_170_10 then
					var_170_10:EnableDynamicBone(true)
				end
			end

			local var_170_11 = arg_167_1.actors_["1077ui_story"]
			local var_170_12 = 0

			if var_170_12 < arg_167_1.time_ and arg_167_1.time_ <= var_170_12 + arg_170_0 and not isNil(var_170_11) and arg_167_1.var_.characterEffect1077ui_story == nil then
				arg_167_1.var_.characterEffect1077ui_story = var_170_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_170_13 = 0.200000002980232

			if var_170_12 <= arg_167_1.time_ and arg_167_1.time_ < var_170_12 + var_170_13 and not isNil(var_170_11) then
				local var_170_14 = (arg_167_1.time_ - var_170_12) / var_170_13

				if arg_167_1.var_.characterEffect1077ui_story and not isNil(var_170_11) then
					local var_170_15 = Mathf.Lerp(0, 0.5, var_170_14)

					arg_167_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_167_1.var_.characterEffect1077ui_story.fillRatio = var_170_15
				end
			end

			if arg_167_1.time_ >= var_170_12 + var_170_13 and arg_167_1.time_ < var_170_12 + var_170_13 + arg_170_0 and not isNil(var_170_11) and arg_167_1.var_.characterEffect1077ui_story then
				local var_170_16 = 0.5

				arg_167_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_167_1.var_.characterEffect1077ui_story.fillRatio = var_170_16
			end

			local var_170_17 = 0
			local var_170_18 = 1.05

			if var_170_17 < arg_167_1.time_ and arg_167_1.time_ <= var_170_17 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, false)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_19 = arg_167_1:GetWordFromCfg(325102039)
				local var_170_20 = arg_167_1:FormatText(var_170_19.content)

				arg_167_1.text_.text = var_170_20

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_21 = 42
				local var_170_22 = utf8.len(var_170_20)
				local var_170_23 = var_170_21 <= 0 and var_170_18 or var_170_18 * (var_170_22 / var_170_21)

				if var_170_23 > 0 and var_170_18 < var_170_23 then
					arg_167_1.talkMaxDuration = var_170_23

					if var_170_23 + var_170_17 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_23 + var_170_17
					end
				end

				arg_167_1.text_.text = var_170_20
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)
				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_24 = math.max(var_170_18, arg_167_1.talkMaxDuration)

			if var_170_17 <= arg_167_1.time_ and arg_167_1.time_ < var_170_17 + var_170_24 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_17) / var_170_24

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_17 + var_170_24 and arg_167_1.time_ < var_170_17 + var_170_24 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_167_1:InitPlayNodeList()
	end,
	Play325102040 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 325102040
		arg_171_1.duration_ = 5

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play325102041(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = "1061ui_story"

			if arg_171_1.actors_[var_174_0] == nil then
				local var_174_1 = Asset.Load("Char/" .. "1061ui_story")

				if not isNil(var_174_1) then
					local var_174_2 = Object.Instantiate(Asset.Load("Char/" .. "1061ui_story"), arg_171_1.stage_.transform)

					var_174_2.name = var_174_0
					var_174_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_171_1.actors_[var_174_0] = var_174_2

					local var_174_3 = var_174_2:GetComponentInChildren(typeof(CharacterEffect))

					var_174_3.enabled = true

					local var_174_4 = GameObjectTools.GetOrAddComponent(var_174_2, typeof(DynamicBoneHelper))

					if var_174_4 then
						var_174_4:EnableDynamicBone(false)
					end

					arg_171_1:ShowWeapon(var_174_3.transform, false)

					arg_171_1.var_[var_174_0 .. "Animator"] = var_174_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_171_1.var_[var_174_0 .. "Animator"].applyRootMotion = true
					arg_171_1.var_[var_174_0 .. "LipSync"] = var_174_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_174_5 = arg_171_1.actors_["1061ui_story"].transform
			local var_174_6 = 0

			if var_174_6 < arg_171_1.time_ and arg_171_1.time_ <= var_174_6 + arg_174_0 then
				arg_171_1.var_.moveOldPos1061ui_story = var_174_5.localPosition
			end

			local var_174_7 = 0.001

			if var_174_6 <= arg_171_1.time_ and arg_171_1.time_ < var_174_6 + var_174_7 then
				local var_174_8 = (arg_171_1.time_ - var_174_6) / var_174_7
				local var_174_9 = Vector3.New(0, -1.18, -6.15)

				var_174_5.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos1061ui_story, var_174_9, var_174_8)

				local var_174_10 = manager.ui.mainCamera.transform.position - var_174_5.position

				var_174_5.forward = Vector3.New(var_174_10.x, var_174_10.y, var_174_10.z)

				local var_174_11 = var_174_5.localEulerAngles

				var_174_11.z = 0
				var_174_11.x = 0
				var_174_5.localEulerAngles = var_174_11
			end

			if arg_171_1.time_ >= var_174_6 + var_174_7 and arg_171_1.time_ < var_174_6 + var_174_7 + arg_174_0 then
				var_174_5.localPosition = Vector3.New(0, -1.18, -6.15)

				local var_174_12 = manager.ui.mainCamera.transform.position - var_174_5.position

				var_174_5.forward = Vector3.New(var_174_12.x, var_174_12.y, var_174_12.z)

				local var_174_13 = var_174_5.localEulerAngles

				var_174_13.z = 0
				var_174_13.x = 0
				var_174_5.localEulerAngles = var_174_13
			end

			local var_174_14 = arg_171_1.actors_["1061ui_story"]
			local var_174_15 = 0

			if var_174_15 < arg_171_1.time_ and arg_171_1.time_ <= var_174_15 + arg_174_0 and not isNil(var_174_14) and arg_171_1.var_.characterEffect1061ui_story == nil then
				arg_171_1.var_.characterEffect1061ui_story = var_174_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_16 = 0.200000002980232

			if var_174_15 <= arg_171_1.time_ and arg_171_1.time_ < var_174_15 + var_174_16 and not isNil(var_174_14) then
				local var_174_17 = (arg_171_1.time_ - var_174_15) / var_174_16

				if arg_171_1.var_.characterEffect1061ui_story and not isNil(var_174_14) then
					arg_171_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_171_1.time_ >= var_174_15 + var_174_16 and arg_171_1.time_ < var_174_15 + var_174_16 + arg_174_0 and not isNil(var_174_14) and arg_171_1.var_.characterEffect1061ui_story then
				arg_171_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_174_18 = 0

			if var_174_18 < arg_171_1.time_ and arg_171_1.time_ <= var_174_18 + arg_174_0 then
				arg_171_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action2_1")
			end

			local var_174_19 = 0

			if var_174_19 < arg_171_1.time_ and arg_171_1.time_ <= var_174_19 + arg_174_0 then
				arg_171_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_174_20 = arg_171_1.actors_["1061ui_story"]
			local var_174_21 = 0
			local var_174_22 = 5

			if var_174_21 < arg_171_1.time_ and arg_171_1.time_ <= var_174_21 + arg_174_0 then
				if arg_171_1.var_.characterEffect1061ui_story == nil then
					arg_171_1.var_.characterEffect1061ui_story = var_174_20:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_171_1.var_.characterEffect1061ui_story.imageEffect:turnOn(false)
			end

			local var_174_23 = arg_171_1.actors_["1061ui_story"]
			local var_174_24 = 0

			if var_174_24 < arg_171_1.time_ and arg_171_1.time_ <= var_174_24 + arg_174_0 then
				if arg_171_1.var_.characterEffect1061ui_story == nil then
					arg_171_1.var_.characterEffect1061ui_story = var_174_23:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_174_25 = arg_171_1.var_.characterEffect1061ui_story

				var_174_25.imageEffect:turnOff()

				var_174_25.interferenceEffect.enabled = true
				var_174_25.interferenceEffect.noise = 0.001
				var_174_25.interferenceEffect.simTimeScale = 1
				var_174_25.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			local var_174_26 = 0
			local var_174_27 = 0.2

			if var_174_26 < arg_171_1.time_ and arg_171_1.time_ <= var_174_26 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				local var_174_28 = arg_171_1:FormatText(StoryNameCfg[612].name)

				arg_171_1.leftNameTxt_.text = var_174_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_29 = arg_171_1:GetWordFromCfg(325102040)
				local var_174_30 = arg_171_1:FormatText(var_174_29.content)

				arg_171_1.text_.text = var_174_30

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_31 = 8
				local var_174_32 = utf8.len(var_174_30)
				local var_174_33 = var_174_31 <= 0 and var_174_27 or var_174_27 * (var_174_32 / var_174_31)

				if var_174_33 > 0 and var_174_27 < var_174_33 then
					arg_171_1.talkMaxDuration = var_174_33

					if var_174_33 + var_174_26 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_33 + var_174_26
					end
				end

				arg_171_1.text_.text = var_174_30
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325102", "325102040", "story_v_out_325102.awb") ~= 0 then
					local var_174_34 = manager.audio:GetVoiceLength("story_v_out_325102", "325102040", "story_v_out_325102.awb") / 1000

					if var_174_34 + var_174_26 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_34 + var_174_26
					end

					if var_174_29.prefab_name ~= "" and arg_171_1.actors_[var_174_29.prefab_name] ~= nil then
						local var_174_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_29.prefab_name].transform, "story_v_out_325102", "325102040", "story_v_out_325102.awb")

						arg_171_1:RecordAudio("325102040", var_174_35)
						arg_171_1:RecordAudio("325102040", var_174_35)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_out_325102", "325102040", "story_v_out_325102.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_out_325102", "325102040", "story_v_out_325102.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_36 = math.max(var_174_27, arg_171_1.talkMaxDuration)

			if var_174_26 <= arg_171_1.time_ and arg_171_1.time_ < var_174_26 + var_174_36 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_26) / var_174_36

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_26 + var_174_36 and arg_171_1.time_ < var_174_26 + var_174_36 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {
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

		arg_171_1:InitPlayNodeList()
	end,
	Play325102041 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 325102041
		arg_175_1.duration_ = 2.5

		local var_175_0 = {
			zh = 2.433,
			ja = 2.5
		}
		local var_175_1 = manager.audio:GetLocalizationFlag()

		if var_175_0[var_175_1] ~= nil then
			arg_175_1.duration_ = var_175_0[var_175_1]
		end

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play325102042(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = arg_175_1.actors_["1061ui_story"].transform
			local var_178_1 = 0

			if var_178_1 < arg_175_1.time_ and arg_175_1.time_ <= var_178_1 + arg_178_0 then
				arg_175_1.var_.moveOldPos1061ui_story = var_178_0.localPosition
			end

			local var_178_2 = 0.001

			if var_178_1 <= arg_175_1.time_ and arg_175_1.time_ < var_178_1 + var_178_2 then
				local var_178_3 = (arg_175_1.time_ - var_178_1) / var_178_2
				local var_178_4 = Vector3.New(-0.7, -1.18, -6.15)

				var_178_0.localPosition = Vector3.Lerp(arg_175_1.var_.moveOldPos1061ui_story, var_178_4, var_178_3)

				local var_178_5 = manager.ui.mainCamera.transform.position - var_178_0.position

				var_178_0.forward = Vector3.New(var_178_5.x, var_178_5.y, var_178_5.z)

				local var_178_6 = var_178_0.localEulerAngles

				var_178_6.z = 0
				var_178_6.x = 0
				var_178_0.localEulerAngles = var_178_6
			end

			if arg_175_1.time_ >= var_178_1 + var_178_2 and arg_175_1.time_ < var_178_1 + var_178_2 + arg_178_0 then
				var_178_0.localPosition = Vector3.New(-0.7, -1.18, -6.15)

				local var_178_7 = manager.ui.mainCamera.transform.position - var_178_0.position

				var_178_0.forward = Vector3.New(var_178_7.x, var_178_7.y, var_178_7.z)

				local var_178_8 = var_178_0.localEulerAngles

				var_178_8.z = 0
				var_178_8.x = 0
				var_178_0.localEulerAngles = var_178_8
			end

			local var_178_9 = arg_175_1.actors_["1077ui_story"].transform
			local var_178_10 = 0

			if var_178_10 < arg_175_1.time_ and arg_175_1.time_ <= var_178_10 + arg_178_0 then
				arg_175_1.var_.moveOldPos1077ui_story = var_178_9.localPosition

				local var_178_11 = GameObjectTools.GetOrAddComponent(var_178_9.gameObject, typeof(DynamicBoneHelper))

				if var_178_11 then
					var_178_11:EnableDynamicBone(false)
				end
			end

			local var_178_12 = 0.001

			if var_178_10 <= arg_175_1.time_ and arg_175_1.time_ < var_178_10 + var_178_12 then
				local var_178_13 = (arg_175_1.time_ - var_178_10) / var_178_12
				local var_178_14 = Vector3.New(0.8, -1.02, -5.92)

				var_178_9.localPosition = Vector3.Lerp(arg_175_1.var_.moveOldPos1077ui_story, var_178_14, var_178_13)

				local var_178_15 = manager.ui.mainCamera.transform.position - var_178_9.position

				var_178_9.forward = Vector3.New(var_178_15.x, var_178_15.y, var_178_15.z)

				local var_178_16 = var_178_9.localEulerAngles

				var_178_16.z = 0
				var_178_16.x = 0
				var_178_9.localEulerAngles = var_178_16
			end

			if arg_175_1.time_ >= var_178_10 + var_178_12 and arg_175_1.time_ < var_178_10 + var_178_12 + arg_178_0 then
				var_178_9.localPosition = Vector3.New(0.8, -1.02, -5.92)

				local var_178_17 = manager.ui.mainCamera.transform.position - var_178_9.position

				var_178_9.forward = Vector3.New(var_178_17.x, var_178_17.y, var_178_17.z)

				local var_178_18 = var_178_9.localEulerAngles

				var_178_18.z = 0
				var_178_18.x = 0
				var_178_9.localEulerAngles = var_178_18

				local var_178_19 = GameObjectTools.GetOrAddComponent(var_178_9.gameObject, typeof(DynamicBoneHelper))

				if var_178_19 then
					var_178_19:EnableDynamicBone(true)
				end
			end

			local var_178_20 = arg_175_1.actors_["1077ui_story"]
			local var_178_21 = 0

			if var_178_21 < arg_175_1.time_ and arg_175_1.time_ <= var_178_21 + arg_178_0 and not isNil(var_178_20) and arg_175_1.var_.characterEffect1077ui_story == nil then
				arg_175_1.var_.characterEffect1077ui_story = var_178_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_178_22 = 0.200000002980232

			if var_178_21 <= arg_175_1.time_ and arg_175_1.time_ < var_178_21 + var_178_22 and not isNil(var_178_20) then
				local var_178_23 = (arg_175_1.time_ - var_178_21) / var_178_22

				if arg_175_1.var_.characterEffect1077ui_story and not isNil(var_178_20) then
					arg_175_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_175_1.time_ >= var_178_21 + var_178_22 and arg_175_1.time_ < var_178_21 + var_178_22 + arg_178_0 and not isNil(var_178_20) and arg_175_1.var_.characterEffect1077ui_story then
				arg_175_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_178_24 = arg_175_1.actors_["1061ui_story"]
			local var_178_25 = 0

			if var_178_25 < arg_175_1.time_ and arg_175_1.time_ <= var_178_25 + arg_178_0 and not isNil(var_178_24) and arg_175_1.var_.characterEffect1061ui_story == nil then
				arg_175_1.var_.characterEffect1061ui_story = var_178_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_178_26 = 0.200000002980232

			if var_178_25 <= arg_175_1.time_ and arg_175_1.time_ < var_178_25 + var_178_26 and not isNil(var_178_24) then
				local var_178_27 = (arg_175_1.time_ - var_178_25) / var_178_26

				if arg_175_1.var_.characterEffect1061ui_story and not isNil(var_178_24) then
					local var_178_28 = Mathf.Lerp(0, 0.5, var_178_27)

					arg_175_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_175_1.var_.characterEffect1061ui_story.fillRatio = var_178_28
				end
			end

			if arg_175_1.time_ >= var_178_25 + var_178_26 and arg_175_1.time_ < var_178_25 + var_178_26 + arg_178_0 and not isNil(var_178_24) and arg_175_1.var_.characterEffect1061ui_story then
				local var_178_29 = 0.5

				arg_175_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_175_1.var_.characterEffect1061ui_story.fillRatio = var_178_29
			end

			local var_178_30 = 0

			if var_178_30 < arg_175_1.time_ and arg_175_1.time_ <= var_178_30 + arg_178_0 then
				arg_175_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action8_1")
			end

			local var_178_31 = 0

			if var_178_31 < arg_175_1.time_ and arg_175_1.time_ <= var_178_31 + arg_178_0 then
				arg_175_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_178_32 = 0
			local var_178_33 = 0.275

			if var_178_32 < arg_175_1.time_ and arg_175_1.time_ <= var_178_32 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				local var_178_34 = arg_175_1:FormatText(StoryNameCfg[1467].name)

				arg_175_1.leftNameTxt_.text = var_178_34

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_35 = arg_175_1:GetWordFromCfg(325102041)
				local var_178_36 = arg_175_1:FormatText(var_178_35.content)

				arg_175_1.text_.text = var_178_36

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_37 = 11
				local var_178_38 = utf8.len(var_178_36)
				local var_178_39 = var_178_37 <= 0 and var_178_33 or var_178_33 * (var_178_38 / var_178_37)

				if var_178_39 > 0 and var_178_33 < var_178_39 then
					arg_175_1.talkMaxDuration = var_178_39

					if var_178_39 + var_178_32 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_39 + var_178_32
					end
				end

				arg_175_1.text_.text = var_178_36
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325102", "325102041", "story_v_out_325102.awb") ~= 0 then
					local var_178_40 = manager.audio:GetVoiceLength("story_v_out_325102", "325102041", "story_v_out_325102.awb") / 1000

					if var_178_40 + var_178_32 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_40 + var_178_32
					end

					if var_178_35.prefab_name ~= "" and arg_175_1.actors_[var_178_35.prefab_name] ~= nil then
						local var_178_41 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_35.prefab_name].transform, "story_v_out_325102", "325102041", "story_v_out_325102.awb")

						arg_175_1:RecordAudio("325102041", var_178_41)
						arg_175_1:RecordAudio("325102041", var_178_41)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_out_325102", "325102041", "story_v_out_325102.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_out_325102", "325102041", "story_v_out_325102.awb")
				end

				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_42 = math.max(var_178_33, arg_175_1.talkMaxDuration)

			if var_178_32 <= arg_175_1.time_ and arg_175_1.time_ < var_178_32 + var_178_42 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_32) / var_178_42

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_32 + var_178_42 and arg_175_1.time_ < var_178_32 + var_178_42 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {
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
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_175_1:InitPlayNodeList()
	end,
	Play325102042 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 325102042
		arg_179_1.duration_ = 3.83

		local var_179_0 = {
			zh = 3.833,
			ja = 3.766
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
				arg_179_0:Play325102043(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = arg_179_1.actors_["1061ui_story"]
			local var_182_1 = 0

			if var_182_1 < arg_179_1.time_ and arg_179_1.time_ <= var_182_1 + arg_182_0 and not isNil(var_182_0) and arg_179_1.var_.characterEffect1061ui_story == nil then
				arg_179_1.var_.characterEffect1061ui_story = var_182_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_182_2 = 0.200000002980232

			if var_182_1 <= arg_179_1.time_ and arg_179_1.time_ < var_182_1 + var_182_2 and not isNil(var_182_0) then
				local var_182_3 = (arg_179_1.time_ - var_182_1) / var_182_2

				if arg_179_1.var_.characterEffect1061ui_story and not isNil(var_182_0) then
					arg_179_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_179_1.time_ >= var_182_1 + var_182_2 and arg_179_1.time_ < var_182_1 + var_182_2 + arg_182_0 and not isNil(var_182_0) and arg_179_1.var_.characterEffect1061ui_story then
				arg_179_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_182_4 = arg_179_1.actors_["1077ui_story"]
			local var_182_5 = 0

			if var_182_5 < arg_179_1.time_ and arg_179_1.time_ <= var_182_5 + arg_182_0 and not isNil(var_182_4) and arg_179_1.var_.characterEffect1077ui_story == nil then
				arg_179_1.var_.characterEffect1077ui_story = var_182_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_182_6 = 0.200000002980232

			if var_182_5 <= arg_179_1.time_ and arg_179_1.time_ < var_182_5 + var_182_6 and not isNil(var_182_4) then
				local var_182_7 = (arg_179_1.time_ - var_182_5) / var_182_6

				if arg_179_1.var_.characterEffect1077ui_story and not isNil(var_182_4) then
					local var_182_8 = Mathf.Lerp(0, 0.5, var_182_7)

					arg_179_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_179_1.var_.characterEffect1077ui_story.fillRatio = var_182_8
				end
			end

			if arg_179_1.time_ >= var_182_5 + var_182_6 and arg_179_1.time_ < var_182_5 + var_182_6 + arg_182_0 and not isNil(var_182_4) and arg_179_1.var_.characterEffect1077ui_story then
				local var_182_9 = 0.5

				arg_179_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_179_1.var_.characterEffect1077ui_story.fillRatio = var_182_9
			end

			local var_182_10 = 0

			if var_182_10 < arg_179_1.time_ and arg_179_1.time_ <= var_182_10 + arg_182_0 then
				arg_179_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action2_2")
			end

			local var_182_11 = 0
			local var_182_12 = 0.4

			if var_182_11 < arg_179_1.time_ and arg_179_1.time_ <= var_182_11 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				local var_182_13 = arg_179_1:FormatText(StoryNameCfg[612].name)

				arg_179_1.leftNameTxt_.text = var_182_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_14 = arg_179_1:GetWordFromCfg(325102042)
				local var_182_15 = arg_179_1:FormatText(var_182_14.content)

				arg_179_1.text_.text = var_182_15

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_16 = 16
				local var_182_17 = utf8.len(var_182_15)
				local var_182_18 = var_182_16 <= 0 and var_182_12 or var_182_12 * (var_182_17 / var_182_16)

				if var_182_18 > 0 and var_182_12 < var_182_18 then
					arg_179_1.talkMaxDuration = var_182_18

					if var_182_18 + var_182_11 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_18 + var_182_11
					end
				end

				arg_179_1.text_.text = var_182_15
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325102", "325102042", "story_v_out_325102.awb") ~= 0 then
					local var_182_19 = manager.audio:GetVoiceLength("story_v_out_325102", "325102042", "story_v_out_325102.awb") / 1000

					if var_182_19 + var_182_11 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_19 + var_182_11
					end

					if var_182_14.prefab_name ~= "" and arg_179_1.actors_[var_182_14.prefab_name] ~= nil then
						local var_182_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_14.prefab_name].transform, "story_v_out_325102", "325102042", "story_v_out_325102.awb")

						arg_179_1:RecordAudio("325102042", var_182_20)
						arg_179_1:RecordAudio("325102042", var_182_20)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_out_325102", "325102042", "story_v_out_325102.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_out_325102", "325102042", "story_v_out_325102.awb")
				end

				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_21 = math.max(var_182_12, arg_179_1.talkMaxDuration)

			if var_182_11 <= arg_179_1.time_ and arg_179_1.time_ < var_182_11 + var_182_21 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_11) / var_182_21

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_11 + var_182_21 and arg_179_1.time_ < var_182_11 + var_182_21 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play325102043 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 325102043
		arg_183_1.duration_ = 6

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play325102044(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = arg_183_1.actors_["1077ui_story"]
			local var_186_1 = 0

			if var_186_1 < arg_183_1.time_ and arg_183_1.time_ <= var_186_1 + arg_186_0 and not isNil(var_186_0) and arg_183_1.var_.characterEffect1077ui_story == nil then
				arg_183_1.var_.characterEffect1077ui_story = var_186_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_186_2 = 0.200000002980232

			if var_186_1 <= arg_183_1.time_ and arg_183_1.time_ < var_186_1 + var_186_2 and not isNil(var_186_0) then
				local var_186_3 = (arg_183_1.time_ - var_186_1) / var_186_2

				if arg_183_1.var_.characterEffect1077ui_story and not isNil(var_186_0) then
					arg_183_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_183_1.time_ >= var_186_1 + var_186_2 and arg_183_1.time_ < var_186_1 + var_186_2 + arg_186_0 and not isNil(var_186_0) and arg_183_1.var_.characterEffect1077ui_story then
				arg_183_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_186_4 = arg_183_1.actors_["1061ui_story"]
			local var_186_5 = 0

			if var_186_5 < arg_183_1.time_ and arg_183_1.time_ <= var_186_5 + arg_186_0 and not isNil(var_186_4) and arg_183_1.var_.characterEffect1061ui_story == nil then
				arg_183_1.var_.characterEffect1061ui_story = var_186_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_186_6 = 0.200000002980232

			if var_186_5 <= arg_183_1.time_ and arg_183_1.time_ < var_186_5 + var_186_6 and not isNil(var_186_4) then
				local var_186_7 = (arg_183_1.time_ - var_186_5) / var_186_6

				if arg_183_1.var_.characterEffect1061ui_story and not isNil(var_186_4) then
					local var_186_8 = Mathf.Lerp(0, 0.5, var_186_7)

					arg_183_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_183_1.var_.characterEffect1061ui_story.fillRatio = var_186_8
				end
			end

			if arg_183_1.time_ >= var_186_5 + var_186_6 and arg_183_1.time_ < var_186_5 + var_186_6 + arg_186_0 and not isNil(var_186_4) and arg_183_1.var_.characterEffect1061ui_story then
				local var_186_9 = 0.5

				arg_183_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_183_1.var_.characterEffect1061ui_story.fillRatio = var_186_9
			end

			local var_186_10 = 0
			local var_186_11 = 0.9

			if var_186_10 < arg_183_1.time_ and arg_183_1.time_ <= var_186_10 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				local var_186_12 = arg_183_1:FormatText(StoryNameCfg[1467].name)

				arg_183_1.leftNameTxt_.text = var_186_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_13 = arg_183_1:GetWordFromCfg(325102043)
				local var_186_14 = arg_183_1:FormatText(var_186_13.content)

				arg_183_1.text_.text = var_186_14

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_15 = 33
				local var_186_16 = utf8.len(var_186_14)
				local var_186_17 = var_186_15 <= 0 and var_186_11 or var_186_11 * (var_186_16 / var_186_15)

				if var_186_17 > 0 and var_186_11 < var_186_17 then
					arg_183_1.talkMaxDuration = var_186_17

					if var_186_17 + var_186_10 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_17 + var_186_10
					end
				end

				arg_183_1.text_.text = var_186_14
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325102", "325102043", "story_v_out_325102.awb") ~= 0 then
					local var_186_18 = manager.audio:GetVoiceLength("story_v_out_325102", "325102043", "story_v_out_325102.awb") / 1000

					if var_186_18 + var_186_10 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_18 + var_186_10
					end

					if var_186_13.prefab_name ~= "" and arg_183_1.actors_[var_186_13.prefab_name] ~= nil then
						local var_186_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_13.prefab_name].transform, "story_v_out_325102", "325102043", "story_v_out_325102.awb")

						arg_183_1:RecordAudio("325102043", var_186_19)
						arg_183_1:RecordAudio("325102043", var_186_19)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_out_325102", "325102043", "story_v_out_325102.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_out_325102", "325102043", "story_v_out_325102.awb")
				end

				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_20 = math.max(var_186_11, arg_183_1.talkMaxDuration)

			if var_186_10 <= arg_183_1.time_ and arg_183_1.time_ < var_186_10 + var_186_20 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_10) / var_186_20

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_10 + var_186_20 and arg_183_1.time_ < var_186_10 + var_186_20 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {}

		arg_183_1:InitPlayNodeList()
	end,
	Play325102044 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 325102044
		arg_187_1.duration_ = 10.1

		local var_187_0 = {
			zh = 6.9,
			ja = 10.1
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
				arg_187_0:Play325102045(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = 0

			if var_190_0 < arg_187_1.time_ and arg_187_1.time_ <= var_190_0 + arg_190_0 then
				arg_187_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action8_2")
			end

			local var_190_1 = 0

			if var_190_1 < arg_187_1.time_ and arg_187_1.time_ <= var_190_1 + arg_190_0 then
				arg_187_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_190_2 = 0
			local var_190_3 = 1

			if var_190_2 < arg_187_1.time_ and arg_187_1.time_ <= var_190_2 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				local var_190_4 = arg_187_1:FormatText(StoryNameCfg[1467].name)

				arg_187_1.leftNameTxt_.text = var_190_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_5 = arg_187_1:GetWordFromCfg(325102044)
				local var_190_6 = arg_187_1:FormatText(var_190_5.content)

				arg_187_1.text_.text = var_190_6

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_7 = 40
				local var_190_8 = utf8.len(var_190_6)
				local var_190_9 = var_190_7 <= 0 and var_190_3 or var_190_3 * (var_190_8 / var_190_7)

				if var_190_9 > 0 and var_190_3 < var_190_9 then
					arg_187_1.talkMaxDuration = var_190_9

					if var_190_9 + var_190_2 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_9 + var_190_2
					end
				end

				arg_187_1.text_.text = var_190_6
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325102", "325102044", "story_v_out_325102.awb") ~= 0 then
					local var_190_10 = manager.audio:GetVoiceLength("story_v_out_325102", "325102044", "story_v_out_325102.awb") / 1000

					if var_190_10 + var_190_2 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_10 + var_190_2
					end

					if var_190_5.prefab_name ~= "" and arg_187_1.actors_[var_190_5.prefab_name] ~= nil then
						local var_190_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_187_1.actors_[var_190_5.prefab_name].transform, "story_v_out_325102", "325102044", "story_v_out_325102.awb")

						arg_187_1:RecordAudio("325102044", var_190_11)
						arg_187_1:RecordAudio("325102044", var_190_11)
					else
						arg_187_1:AudioAction("play", "voice", "story_v_out_325102", "325102044", "story_v_out_325102.awb")
					end

					arg_187_1:RecordHistoryTalkVoice("story_v_out_325102", "325102044", "story_v_out_325102.awb")
				end

				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_12 = math.max(var_190_3, arg_187_1.talkMaxDuration)

			if var_190_2 <= arg_187_1.time_ and arg_187_1.time_ < var_190_2 + var_190_12 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_2) / var_190_12

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_2 + var_190_12 and arg_187_1.time_ < var_190_2 + var_190_12 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play325102045 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 325102045
		arg_191_1.duration_ = 4.13

		local var_191_0 = {
			zh = 4.133,
			ja = 3.866
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
				arg_191_0:Play325102046(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = 0
			local var_194_1 = 0.6

			if var_194_0 < arg_191_1.time_ and arg_191_1.time_ <= var_194_0 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				local var_194_2 = arg_191_1:FormatText(StoryNameCfg[1467].name)

				arg_191_1.leftNameTxt_.text = var_194_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_3 = arg_191_1:GetWordFromCfg(325102045)
				local var_194_4 = arg_191_1:FormatText(var_194_3.content)

				arg_191_1.text_.text = var_194_4

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_5 = 24
				local var_194_6 = utf8.len(var_194_4)
				local var_194_7 = var_194_5 <= 0 and var_194_1 or var_194_1 * (var_194_6 / var_194_5)

				if var_194_7 > 0 and var_194_1 < var_194_7 then
					arg_191_1.talkMaxDuration = var_194_7

					if var_194_7 + var_194_0 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_7 + var_194_0
					end
				end

				arg_191_1.text_.text = var_194_4
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325102", "325102045", "story_v_out_325102.awb") ~= 0 then
					local var_194_8 = manager.audio:GetVoiceLength("story_v_out_325102", "325102045", "story_v_out_325102.awb") / 1000

					if var_194_8 + var_194_0 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_8 + var_194_0
					end

					if var_194_3.prefab_name ~= "" and arg_191_1.actors_[var_194_3.prefab_name] ~= nil then
						local var_194_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_3.prefab_name].transform, "story_v_out_325102", "325102045", "story_v_out_325102.awb")

						arg_191_1:RecordAudio("325102045", var_194_9)
						arg_191_1:RecordAudio("325102045", var_194_9)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_out_325102", "325102045", "story_v_out_325102.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_out_325102", "325102045", "story_v_out_325102.awb")
				end

				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_10 = math.max(var_194_1, arg_191_1.talkMaxDuration)

			if var_194_0 <= arg_191_1.time_ and arg_191_1.time_ < var_194_0 + var_194_10 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_0) / var_194_10

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_0 + var_194_10 and arg_191_1.time_ < var_194_0 + var_194_10 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {}

		arg_191_1:InitPlayNodeList()
	end,
	Play325102046 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 325102046
		arg_195_1.duration_ = 5

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play325102047(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = arg_195_1.actors_["1077ui_story"].transform
			local var_198_1 = 0

			if var_198_1 < arg_195_1.time_ and arg_195_1.time_ <= var_198_1 + arg_198_0 then
				arg_195_1.var_.moveOldPos1077ui_story = var_198_0.localPosition

				local var_198_2 = GameObjectTools.GetOrAddComponent(var_198_0.gameObject, typeof(DynamicBoneHelper))

				if var_198_2 then
					var_198_2:EnableDynamicBone(false)
				end
			end

			local var_198_3 = 0.001

			if var_198_1 <= arg_195_1.time_ and arg_195_1.time_ < var_198_1 + var_198_3 then
				local var_198_4 = (arg_195_1.time_ - var_198_1) / var_198_3
				local var_198_5 = Vector3.New(0, 100, 0)

				var_198_0.localPosition = Vector3.Lerp(arg_195_1.var_.moveOldPos1077ui_story, var_198_5, var_198_4)

				local var_198_6 = manager.ui.mainCamera.transform.position - var_198_0.position

				var_198_0.forward = Vector3.New(var_198_6.x, var_198_6.y, var_198_6.z)

				local var_198_7 = var_198_0.localEulerAngles

				var_198_7.z = 0
				var_198_7.x = 0
				var_198_0.localEulerAngles = var_198_7
			end

			if arg_195_1.time_ >= var_198_1 + var_198_3 and arg_195_1.time_ < var_198_1 + var_198_3 + arg_198_0 then
				var_198_0.localPosition = Vector3.New(0, 100, 0)

				local var_198_8 = manager.ui.mainCamera.transform.position - var_198_0.position

				var_198_0.forward = Vector3.New(var_198_8.x, var_198_8.y, var_198_8.z)

				local var_198_9 = var_198_0.localEulerAngles

				var_198_9.z = 0
				var_198_9.x = 0
				var_198_0.localEulerAngles = var_198_9

				local var_198_10 = GameObjectTools.GetOrAddComponent(var_198_0.gameObject, typeof(DynamicBoneHelper))

				if var_198_10 then
					var_198_10:EnableDynamicBone(true)
				end
			end

			local var_198_11 = arg_195_1.actors_["1061ui_story"].transform
			local var_198_12 = 0

			if var_198_12 < arg_195_1.time_ and arg_195_1.time_ <= var_198_12 + arg_198_0 then
				arg_195_1.var_.moveOldPos1061ui_story = var_198_11.localPosition
			end

			local var_198_13 = 0.001

			if var_198_12 <= arg_195_1.time_ and arg_195_1.time_ < var_198_12 + var_198_13 then
				local var_198_14 = (arg_195_1.time_ - var_198_12) / var_198_13
				local var_198_15 = Vector3.New(0, 100, 0)

				var_198_11.localPosition = Vector3.Lerp(arg_195_1.var_.moveOldPos1061ui_story, var_198_15, var_198_14)

				local var_198_16 = manager.ui.mainCamera.transform.position - var_198_11.position

				var_198_11.forward = Vector3.New(var_198_16.x, var_198_16.y, var_198_16.z)

				local var_198_17 = var_198_11.localEulerAngles

				var_198_17.z = 0
				var_198_17.x = 0
				var_198_11.localEulerAngles = var_198_17
			end

			if arg_195_1.time_ >= var_198_12 + var_198_13 and arg_195_1.time_ < var_198_12 + var_198_13 + arg_198_0 then
				var_198_11.localPosition = Vector3.New(0, 100, 0)

				local var_198_18 = manager.ui.mainCamera.transform.position - var_198_11.position

				var_198_11.forward = Vector3.New(var_198_18.x, var_198_18.y, var_198_18.z)

				local var_198_19 = var_198_11.localEulerAngles

				var_198_19.z = 0
				var_198_19.x = 0
				var_198_11.localEulerAngles = var_198_19
			end

			local var_198_20 = arg_195_1.actors_["1077ui_story"]
			local var_198_21 = 0

			if var_198_21 < arg_195_1.time_ and arg_195_1.time_ <= var_198_21 + arg_198_0 and not isNil(var_198_20) and arg_195_1.var_.characterEffect1077ui_story == nil then
				arg_195_1.var_.characterEffect1077ui_story = var_198_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_198_22 = 0.200000002980232

			if var_198_21 <= arg_195_1.time_ and arg_195_1.time_ < var_198_21 + var_198_22 and not isNil(var_198_20) then
				local var_198_23 = (arg_195_1.time_ - var_198_21) / var_198_22

				if arg_195_1.var_.characterEffect1077ui_story and not isNil(var_198_20) then
					local var_198_24 = Mathf.Lerp(0, 0.5, var_198_23)

					arg_195_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_195_1.var_.characterEffect1077ui_story.fillRatio = var_198_24
				end
			end

			if arg_195_1.time_ >= var_198_21 + var_198_22 and arg_195_1.time_ < var_198_21 + var_198_22 + arg_198_0 and not isNil(var_198_20) and arg_195_1.var_.characterEffect1077ui_story then
				local var_198_25 = 0.5

				arg_195_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_195_1.var_.characterEffect1077ui_story.fillRatio = var_198_25
			end

			local var_198_26 = 0.7
			local var_198_27 = 1

			if var_198_26 < arg_195_1.time_ and arg_195_1.time_ <= var_198_26 + arg_198_0 then
				local var_198_28 = "play"
				local var_198_29 = "effect"

				arg_195_1:AudioAction(var_198_28, var_198_29, "se_story_7", "se_story_7_leaves", "")
			end

			local var_198_30 = 0
			local var_198_31 = 1.675

			if var_198_30 < arg_195_1.time_ and arg_195_1.time_ <= var_198_30 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, false)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_32 = arg_195_1:GetWordFromCfg(325102046)
				local var_198_33 = arg_195_1:FormatText(var_198_32.content)

				arg_195_1.text_.text = var_198_33

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_34 = 67
				local var_198_35 = utf8.len(var_198_33)
				local var_198_36 = var_198_34 <= 0 and var_198_31 or var_198_31 * (var_198_35 / var_198_34)

				if var_198_36 > 0 and var_198_31 < var_198_36 then
					arg_195_1.talkMaxDuration = var_198_36

					if var_198_36 + var_198_30 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_36 + var_198_30
					end
				end

				arg_195_1.text_.text = var_198_33
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)
				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_37 = math.max(var_198_31, arg_195_1.talkMaxDuration)

			if var_198_30 <= arg_195_1.time_ and arg_195_1.time_ < var_198_30 + var_198_37 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_30) / var_198_37

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_30 + var_198_37 and arg_195_1.time_ < var_198_30 + var_198_37 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
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

		arg_195_1:InitPlayNodeList()
	end,
	Play325102047 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 325102047
		arg_199_1.duration_ = 5

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play325102048(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = 0
			local var_202_1 = 0.625

			if var_202_0 < arg_199_1.time_ and arg_199_1.time_ <= var_202_0 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, false)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_2 = arg_199_1:GetWordFromCfg(325102047)
				local var_202_3 = arg_199_1:FormatText(var_202_2.content)

				arg_199_1.text_.text = var_202_3

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_4 = 25
				local var_202_5 = utf8.len(var_202_3)
				local var_202_6 = var_202_4 <= 0 and var_202_1 or var_202_1 * (var_202_5 / var_202_4)

				if var_202_6 > 0 and var_202_1 < var_202_6 then
					arg_199_1.talkMaxDuration = var_202_6

					if var_202_6 + var_202_0 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_6 + var_202_0
					end
				end

				arg_199_1.text_.text = var_202_3
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)
				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_7 = math.max(var_202_1, arg_199_1.talkMaxDuration)

			if var_202_0 <= arg_199_1.time_ and arg_199_1.time_ < var_202_0 + var_202_7 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_0) / var_202_7

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_0 + var_202_7 and arg_199_1.time_ < var_202_0 + var_202_7 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {}

		arg_199_1:InitPlayNodeList()
	end,
	Play325102048 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 325102048
		arg_203_1.duration_ = 2.47

		local var_203_0 = {
			zh = 1.999999999999,
			ja = 2.466
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
				arg_203_0:Play325102049(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			local var_206_0 = arg_203_1.actors_["1061ui_story"].transform
			local var_206_1 = 0

			if var_206_1 < arg_203_1.time_ and arg_203_1.time_ <= var_206_1 + arg_206_0 then
				arg_203_1.var_.moveOldPos1061ui_story = var_206_0.localPosition
			end

			local var_206_2 = 0.001

			if var_206_1 <= arg_203_1.time_ and arg_203_1.time_ < var_206_1 + var_206_2 then
				local var_206_3 = (arg_203_1.time_ - var_206_1) / var_206_2
				local var_206_4 = Vector3.New(0, 100, 0)

				var_206_0.localPosition = Vector3.Lerp(arg_203_1.var_.moveOldPos1061ui_story, var_206_4, var_206_3)

				local var_206_5 = manager.ui.mainCamera.transform.position - var_206_0.position

				var_206_0.forward = Vector3.New(var_206_5.x, var_206_5.y, var_206_5.z)

				local var_206_6 = var_206_0.localEulerAngles

				var_206_6.z = 0
				var_206_6.x = 0
				var_206_0.localEulerAngles = var_206_6
			end

			if arg_203_1.time_ >= var_206_1 + var_206_2 and arg_203_1.time_ < var_206_1 + var_206_2 + arg_206_0 then
				var_206_0.localPosition = Vector3.New(0, 100, 0)

				local var_206_7 = manager.ui.mainCamera.transform.position - var_206_0.position

				var_206_0.forward = Vector3.New(var_206_7.x, var_206_7.y, var_206_7.z)

				local var_206_8 = var_206_0.localEulerAngles

				var_206_8.z = 0
				var_206_8.x = 0
				var_206_0.localEulerAngles = var_206_8
			end

			local var_206_9 = arg_203_1.actors_["1061ui_story"]
			local var_206_10 = 0

			if var_206_10 < arg_203_1.time_ and arg_203_1.time_ <= var_206_10 + arg_206_0 and not isNil(var_206_9) and arg_203_1.var_.characterEffect1061ui_story == nil then
				arg_203_1.var_.characterEffect1061ui_story = var_206_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_206_11 = 0.200000002980232

			if var_206_10 <= arg_203_1.time_ and arg_203_1.time_ < var_206_10 + var_206_11 and not isNil(var_206_9) then
				local var_206_12 = (arg_203_1.time_ - var_206_10) / var_206_11

				if arg_203_1.var_.characterEffect1061ui_story and not isNil(var_206_9) then
					arg_203_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_203_1.time_ >= var_206_10 + var_206_11 and arg_203_1.time_ < var_206_10 + var_206_11 + arg_206_0 and not isNil(var_206_9) and arg_203_1.var_.characterEffect1061ui_story then
				arg_203_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_206_13 = 0

			if var_206_13 < arg_203_1.time_ and arg_203_1.time_ <= var_206_13 + arg_206_0 then
				arg_203_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action1_1")
			end

			local var_206_14 = 0

			if var_206_14 < arg_203_1.time_ and arg_203_1.time_ <= var_206_14 + arg_206_0 then
				arg_203_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_206_15 = 0
			local var_206_16 = 0.075

			if var_206_15 < arg_203_1.time_ and arg_203_1.time_ <= var_206_15 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				local var_206_17 = arg_203_1:FormatText(StoryNameCfg[612].name)

				arg_203_1.leftNameTxt_.text = var_206_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, true)
				arg_203_1.iconController_:SetSelectedState("hero")

				arg_203_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1061_split_1")

				arg_203_1.callingController_:SetSelectedState("calling")

				arg_203_1.keyicon_.color = Color.New(1, 1, 1)
				arg_203_1.icon_.color = Color.New(1, 1, 1)

				local var_206_18 = arg_203_1:GetWordFromCfg(325102048)
				local var_206_19 = arg_203_1:FormatText(var_206_18.content)

				arg_203_1.text_.text = var_206_19

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_20 = 3
				local var_206_21 = utf8.len(var_206_19)
				local var_206_22 = var_206_20 <= 0 and var_206_16 or var_206_16 * (var_206_21 / var_206_20)

				if var_206_22 > 0 and var_206_16 < var_206_22 then
					arg_203_1.talkMaxDuration = var_206_22

					if var_206_22 + var_206_15 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_22 + var_206_15
					end
				end

				arg_203_1.text_.text = var_206_19
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325102", "325102048", "story_v_out_325102.awb") ~= 0 then
					local var_206_23 = manager.audio:GetVoiceLength("story_v_out_325102", "325102048", "story_v_out_325102.awb") / 1000

					if var_206_23 + var_206_15 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_23 + var_206_15
					end

					if var_206_18.prefab_name ~= "" and arg_203_1.actors_[var_206_18.prefab_name] ~= nil then
						local var_206_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_18.prefab_name].transform, "story_v_out_325102", "325102048", "story_v_out_325102.awb")

						arg_203_1:RecordAudio("325102048", var_206_24)
						arg_203_1:RecordAudio("325102048", var_206_24)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_out_325102", "325102048", "story_v_out_325102.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_out_325102", "325102048", "story_v_out_325102.awb")
				end

				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_25 = math.max(var_206_16, arg_203_1.talkMaxDuration)

			if var_206_15 <= arg_203_1.time_ and arg_203_1.time_ < var_206_15 + var_206_25 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_15) / var_206_25

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_15 + var_206_25 and arg_203_1.time_ < var_206_15 + var_206_25 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {
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

		arg_203_1:InitPlayNodeList()
	end,
	Play325102049 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 325102049
		arg_207_1.duration_ = 3.3

		local var_207_0 = {
			zh = 3,
			ja = 3.3
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
				arg_207_0:Play325102050(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			local var_210_0 = arg_207_1.actors_["1061ui_story"].transform
			local var_210_1 = 0

			if var_210_1 < arg_207_1.time_ and arg_207_1.time_ <= var_210_1 + arg_210_0 then
				arg_207_1.var_.moveOldPos1061ui_story = var_210_0.localPosition
			end

			local var_210_2 = 0.001

			if var_210_1 <= arg_207_1.time_ and arg_207_1.time_ < var_210_1 + var_210_2 then
				local var_210_3 = (arg_207_1.time_ - var_210_1) / var_210_2
				local var_210_4 = Vector3.New(0, 100, 0)

				var_210_0.localPosition = Vector3.Lerp(arg_207_1.var_.moveOldPos1061ui_story, var_210_4, var_210_3)

				local var_210_5 = manager.ui.mainCamera.transform.position - var_210_0.position

				var_210_0.forward = Vector3.New(var_210_5.x, var_210_5.y, var_210_5.z)

				local var_210_6 = var_210_0.localEulerAngles

				var_210_6.z = 0
				var_210_6.x = 0
				var_210_0.localEulerAngles = var_210_6
			end

			if arg_207_1.time_ >= var_210_1 + var_210_2 and arg_207_1.time_ < var_210_1 + var_210_2 + arg_210_0 then
				var_210_0.localPosition = Vector3.New(0, 100, 0)

				local var_210_7 = manager.ui.mainCamera.transform.position - var_210_0.position

				var_210_0.forward = Vector3.New(var_210_7.x, var_210_7.y, var_210_7.z)

				local var_210_8 = var_210_0.localEulerAngles

				var_210_8.z = 0
				var_210_8.x = 0
				var_210_0.localEulerAngles = var_210_8
			end

			local var_210_9 = arg_207_1.actors_["1077ui_story"].transform
			local var_210_10 = 0

			if var_210_10 < arg_207_1.time_ and arg_207_1.time_ <= var_210_10 + arg_210_0 then
				arg_207_1.var_.moveOldPos1077ui_story = var_210_9.localPosition

				local var_210_11 = GameObjectTools.GetOrAddComponent(var_210_9.gameObject, typeof(DynamicBoneHelper))

				if var_210_11 then
					var_210_11:EnableDynamicBone(false)
				end
			end

			local var_210_12 = 0.001

			if var_210_10 <= arg_207_1.time_ and arg_207_1.time_ < var_210_10 + var_210_12 then
				local var_210_13 = (arg_207_1.time_ - var_210_10) / var_210_12
				local var_210_14 = Vector3.New(0, 100, 0)

				var_210_9.localPosition = Vector3.Lerp(arg_207_1.var_.moveOldPos1077ui_story, var_210_14, var_210_13)

				local var_210_15 = manager.ui.mainCamera.transform.position - var_210_9.position

				var_210_9.forward = Vector3.New(var_210_15.x, var_210_15.y, var_210_15.z)

				local var_210_16 = var_210_9.localEulerAngles

				var_210_16.z = 0
				var_210_16.x = 0
				var_210_9.localEulerAngles = var_210_16
			end

			if arg_207_1.time_ >= var_210_10 + var_210_12 and arg_207_1.time_ < var_210_10 + var_210_12 + arg_210_0 then
				var_210_9.localPosition = Vector3.New(0, 100, 0)

				local var_210_17 = manager.ui.mainCamera.transform.position - var_210_9.position

				var_210_9.forward = Vector3.New(var_210_17.x, var_210_17.y, var_210_17.z)

				local var_210_18 = var_210_9.localEulerAngles

				var_210_18.z = 0
				var_210_18.x = 0
				var_210_9.localEulerAngles = var_210_18

				local var_210_19 = GameObjectTools.GetOrAddComponent(var_210_9.gameObject, typeof(DynamicBoneHelper))

				if var_210_19 then
					var_210_19:EnableDynamicBone(true)
				end
			end

			local var_210_20 = arg_207_1.actors_["1077ui_story"]
			local var_210_21 = 0

			if var_210_21 < arg_207_1.time_ and arg_207_1.time_ <= var_210_21 + arg_210_0 and not isNil(var_210_20) and arg_207_1.var_.characterEffect1077ui_story == nil then
				arg_207_1.var_.characterEffect1077ui_story = var_210_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_22 = 0.200000002980232

			if var_210_21 <= arg_207_1.time_ and arg_207_1.time_ < var_210_21 + var_210_22 and not isNil(var_210_20) then
				local var_210_23 = (arg_207_1.time_ - var_210_21) / var_210_22

				if arg_207_1.var_.characterEffect1077ui_story and not isNil(var_210_20) then
					arg_207_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_207_1.time_ >= var_210_21 + var_210_22 and arg_207_1.time_ < var_210_21 + var_210_22 + arg_210_0 and not isNil(var_210_20) and arg_207_1.var_.characterEffect1077ui_story then
				arg_207_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_210_24 = arg_207_1.actors_["1061ui_story"]
			local var_210_25 = 0

			if var_210_25 < arg_207_1.time_ and arg_207_1.time_ <= var_210_25 + arg_210_0 and not isNil(var_210_24) and arg_207_1.var_.characterEffect1061ui_story == nil then
				arg_207_1.var_.characterEffect1061ui_story = var_210_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_26 = 0.200000002980232

			if var_210_25 <= arg_207_1.time_ and arg_207_1.time_ < var_210_25 + var_210_26 and not isNil(var_210_24) then
				local var_210_27 = (arg_207_1.time_ - var_210_25) / var_210_26

				if arg_207_1.var_.characterEffect1061ui_story and not isNil(var_210_24) then
					local var_210_28 = Mathf.Lerp(0, 0.5, var_210_27)

					arg_207_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_207_1.var_.characterEffect1061ui_story.fillRatio = var_210_28
				end
			end

			if arg_207_1.time_ >= var_210_25 + var_210_26 and arg_207_1.time_ < var_210_25 + var_210_26 + arg_210_0 and not isNil(var_210_24) and arg_207_1.var_.characterEffect1061ui_story then
				local var_210_29 = 0.5

				arg_207_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_207_1.var_.characterEffect1061ui_story.fillRatio = var_210_29
			end

			local var_210_30 = 0

			if var_210_30 < arg_207_1.time_ and arg_207_1.time_ <= var_210_30 + arg_210_0 then
				arg_207_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action1_1")
			end

			local var_210_31 = 0

			if var_210_31 < arg_207_1.time_ and arg_207_1.time_ <= var_210_31 + arg_210_0 then
				arg_207_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_210_32 = 0
			local var_210_33 = 0.3

			if var_210_32 < arg_207_1.time_ and arg_207_1.time_ <= var_210_32 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				local var_210_34 = arg_207_1:FormatText(StoryNameCfg[1467].name)

				arg_207_1.leftNameTxt_.text = var_210_34

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, true)
				arg_207_1.iconController_:SetSelectedState("hero")

				arg_207_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1077")

				arg_207_1.callingController_:SetSelectedState("normal")

				arg_207_1.keyicon_.color = Color.New(1, 1, 1)
				arg_207_1.icon_.color = Color.New(1, 1, 1)

				local var_210_35 = arg_207_1:GetWordFromCfg(325102049)
				local var_210_36 = arg_207_1:FormatText(var_210_35.content)

				arg_207_1.text_.text = var_210_36

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_37 = 12
				local var_210_38 = utf8.len(var_210_36)
				local var_210_39 = var_210_37 <= 0 and var_210_33 or var_210_33 * (var_210_38 / var_210_37)

				if var_210_39 > 0 and var_210_33 < var_210_39 then
					arg_207_1.talkMaxDuration = var_210_39

					if var_210_39 + var_210_32 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_39 + var_210_32
					end
				end

				arg_207_1.text_.text = var_210_36
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325102", "325102049", "story_v_out_325102.awb") ~= 0 then
					local var_210_40 = manager.audio:GetVoiceLength("story_v_out_325102", "325102049", "story_v_out_325102.awb") / 1000

					if var_210_40 + var_210_32 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_40 + var_210_32
					end

					if var_210_35.prefab_name ~= "" and arg_207_1.actors_[var_210_35.prefab_name] ~= nil then
						local var_210_41 = LuaForUtil.PlayVoiceWithCriLipsync(arg_207_1.actors_[var_210_35.prefab_name].transform, "story_v_out_325102", "325102049", "story_v_out_325102.awb")

						arg_207_1:RecordAudio("325102049", var_210_41)
						arg_207_1:RecordAudio("325102049", var_210_41)
					else
						arg_207_1:AudioAction("play", "voice", "story_v_out_325102", "325102049", "story_v_out_325102.awb")
					end

					arg_207_1:RecordHistoryTalkVoice("story_v_out_325102", "325102049", "story_v_out_325102.awb")
				end

				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_42 = math.max(var_210_33, arg_207_1.talkMaxDuration)

			if var_210_32 <= arg_207_1.time_ and arg_207_1.time_ < var_210_32 + var_210_42 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_32) / var_210_42

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_32 + var_210_42 and arg_207_1.time_ < var_210_32 + var_210_42 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {
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
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_207_1:InitPlayNodeList()
	end,
	Play325102050 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 325102050
		arg_211_1.duration_ = 10.8

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play325102051(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			local var_214_0 = arg_211_1.actors_["1077ui_story"].transform
			local var_214_1 = 0

			if var_214_1 < arg_211_1.time_ and arg_211_1.time_ <= var_214_1 + arg_214_0 then
				arg_211_1.var_.moveOldPos1077ui_story = var_214_0.localPosition

				local var_214_2 = GameObjectTools.GetOrAddComponent(var_214_0.gameObject, typeof(DynamicBoneHelper))

				if var_214_2 then
					var_214_2:EnableDynamicBone(false)
				end
			end

			local var_214_3 = 0.001

			if var_214_1 <= arg_211_1.time_ and arg_211_1.time_ < var_214_1 + var_214_3 then
				local var_214_4 = (arg_211_1.time_ - var_214_1) / var_214_3
				local var_214_5 = Vector3.New(0, 100, 0)

				var_214_0.localPosition = Vector3.Lerp(arg_211_1.var_.moveOldPos1077ui_story, var_214_5, var_214_4)

				local var_214_6 = manager.ui.mainCamera.transform.position - var_214_0.position

				var_214_0.forward = Vector3.New(var_214_6.x, var_214_6.y, var_214_6.z)

				local var_214_7 = var_214_0.localEulerAngles

				var_214_7.z = 0
				var_214_7.x = 0
				var_214_0.localEulerAngles = var_214_7
			end

			if arg_211_1.time_ >= var_214_1 + var_214_3 and arg_211_1.time_ < var_214_1 + var_214_3 + arg_214_0 then
				var_214_0.localPosition = Vector3.New(0, 100, 0)

				local var_214_8 = manager.ui.mainCamera.transform.position - var_214_0.position

				var_214_0.forward = Vector3.New(var_214_8.x, var_214_8.y, var_214_8.z)

				local var_214_9 = var_214_0.localEulerAngles

				var_214_9.z = 0
				var_214_9.x = 0
				var_214_0.localEulerAngles = var_214_9

				local var_214_10 = GameObjectTools.GetOrAddComponent(var_214_0.gameObject, typeof(DynamicBoneHelper))

				if var_214_10 then
					var_214_10:EnableDynamicBone(true)
				end
			end

			local var_214_11 = arg_211_1.actors_["1061ui_story"].transform
			local var_214_12 = 0

			if var_214_12 < arg_211_1.time_ and arg_211_1.time_ <= var_214_12 + arg_214_0 then
				arg_211_1.var_.moveOldPos1061ui_story = var_214_11.localPosition
			end

			local var_214_13 = 0.001

			if var_214_12 <= arg_211_1.time_ and arg_211_1.time_ < var_214_12 + var_214_13 then
				local var_214_14 = (arg_211_1.time_ - var_214_12) / var_214_13
				local var_214_15 = Vector3.New(0, 100, 0)

				var_214_11.localPosition = Vector3.Lerp(arg_211_1.var_.moveOldPos1061ui_story, var_214_15, var_214_14)

				local var_214_16 = manager.ui.mainCamera.transform.position - var_214_11.position

				var_214_11.forward = Vector3.New(var_214_16.x, var_214_16.y, var_214_16.z)

				local var_214_17 = var_214_11.localEulerAngles

				var_214_17.z = 0
				var_214_17.x = 0
				var_214_11.localEulerAngles = var_214_17
			end

			if arg_211_1.time_ >= var_214_12 + var_214_13 and arg_211_1.time_ < var_214_12 + var_214_13 + arg_214_0 then
				var_214_11.localPosition = Vector3.New(0, 100, 0)

				local var_214_18 = manager.ui.mainCamera.transform.position - var_214_11.position

				var_214_11.forward = Vector3.New(var_214_18.x, var_214_18.y, var_214_18.z)

				local var_214_19 = var_214_11.localEulerAngles

				var_214_19.z = 0
				var_214_19.x = 0
				var_214_11.localEulerAngles = var_214_19
			end

			local var_214_20 = arg_211_1.actors_["1077ui_story"]
			local var_214_21 = 0

			if var_214_21 < arg_211_1.time_ and arg_211_1.time_ <= var_214_21 + arg_214_0 and not isNil(var_214_20) and arg_211_1.var_.characterEffect1077ui_story == nil then
				arg_211_1.var_.characterEffect1077ui_story = var_214_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_214_22 = 0.200000002980232

			if var_214_21 <= arg_211_1.time_ and arg_211_1.time_ < var_214_21 + var_214_22 and not isNil(var_214_20) then
				local var_214_23 = (arg_211_1.time_ - var_214_21) / var_214_22

				if arg_211_1.var_.characterEffect1077ui_story and not isNil(var_214_20) then
					local var_214_24 = Mathf.Lerp(0, 0.5, var_214_23)

					arg_211_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_211_1.var_.characterEffect1077ui_story.fillRatio = var_214_24
				end
			end

			if arg_211_1.time_ >= var_214_21 + var_214_22 and arg_211_1.time_ < var_214_21 + var_214_22 + arg_214_0 and not isNil(var_214_20) and arg_211_1.var_.characterEffect1077ui_story then
				local var_214_25 = 0.5

				arg_211_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_211_1.var_.characterEffect1077ui_story.fillRatio = var_214_25
			end

			local var_214_26 = manager.ui.mainCamera.transform
			local var_214_27 = 0

			if var_214_27 < arg_211_1.time_ and arg_211_1.time_ <= var_214_27 + arg_214_0 then
				local var_214_28 = arg_211_1.var_.effect32323
				local var_214_29
				local var_214_30 = var_214_26

				if not var_214_28 then
					var_214_28 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_heiwu"), var_214_30)
					var_214_28.name = "32323"
					arg_211_1.var_.effect32323 = var_214_28
				else
					var_214_28.transform:SetParent(var_214_30)
				end

				var_214_28.transform.localPosition = Vector3.New(0.66, -0.12, 0.38)
				var_214_28.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_214_31 = manager.ui.mainCamera.transform
			local var_214_32 = 5.03333333333333

			if var_214_32 < arg_211_1.time_ and arg_211_1.time_ <= var_214_32 + arg_214_0 then
				local var_214_33 = arg_211_1.var_.effect32323

				if var_214_33 then
					Object.Destroy(var_214_33)

					arg_211_1.var_.effect32323 = nil
				end
			end

			local var_214_34 = manager.ui.mainCamera.transform
			local var_214_35 = 0.733333333333333

			if var_214_35 < arg_211_1.time_ and arg_211_1.time_ <= var_214_35 + arg_214_0 then
				local var_214_36 = arg_211_1.var_.effect323231
				local var_214_37
				local var_214_38 = var_214_34

				if not var_214_36 then
					var_214_36 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_heiwu"), var_214_38)
					var_214_36.name = "323231"
					arg_211_1.var_.effect323231 = var_214_36
				else
					var_214_36.transform:SetParent(var_214_38)
				end

				var_214_36.transform.localPosition = Vector3.New(-0.66, -0.18, -0.04)
				var_214_36.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_214_39 = manager.ui.mainCamera.transform
			local var_214_40 = 5.76666666666667

			if var_214_40 < arg_211_1.time_ and arg_211_1.time_ <= var_214_40 + arg_214_0 then
				local var_214_41 = arg_211_1.var_.effect323231

				if var_214_41 then
					Object.Destroy(var_214_41)

					arg_211_1.var_.effect323231 = nil
				end
			end

			local var_214_42 = 0

			if var_214_42 < arg_211_1.time_ and arg_211_1.time_ <= var_214_42 + arg_214_0 then
				arg_211_1.allBtn_.enabled = false
			end

			local var_214_43 = 4.13333333333333

			if arg_211_1.time_ >= var_214_42 + var_214_43 and arg_211_1.time_ < var_214_42 + var_214_43 + arg_214_0 then
				arg_211_1.allBtn_.enabled = true
			end

			if arg_211_1.frameCnt_ <= 1 then
				arg_211_1.dialog_:SetActive(false)
			end

			local var_214_44 = 1.56666666666667
			local var_214_45 = 1.325

			if var_214_44 < arg_211_1.time_ and arg_211_1.time_ <= var_214_44 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0

				arg_211_1.dialog_:SetActive(true)

				arg_211_1.dialogCg_.alpha = 0

				local var_214_46 = LeanTween.value(arg_211_1.dialog_, 0, 1, 0.3)

				var_214_46:setOnUpdate(LuaHelper.FloatAction(function(arg_215_0)
					arg_211_1.dialogCg_.alpha = arg_215_0
				end))
				var_214_46:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_211_1.dialog_)
					var_214_46:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_211_1.duration_ = arg_211_1.duration_ + 0.3

				SetActive(arg_211_1.leftNameGo_, false)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_47 = arg_211_1:GetWordFromCfg(325102050)
				local var_214_48 = arg_211_1:FormatText(var_214_47.content)

				arg_211_1.text_.text = var_214_48

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_49 = 53
				local var_214_50 = utf8.len(var_214_48)
				local var_214_51 = var_214_49 <= 0 and var_214_45 or var_214_45 * (var_214_50 / var_214_49)

				if var_214_51 > 0 and var_214_45 < var_214_51 then
					arg_211_1.talkMaxDuration = var_214_51
					var_214_44 = var_214_44 + 0.3

					if var_214_51 + var_214_44 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_51 + var_214_44
					end
				end

				arg_211_1.text_.text = var_214_48
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)
				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_52 = var_214_44 + 0.3
			local var_214_53 = math.max(var_214_45, arg_211_1.talkMaxDuration)

			if var_214_52 <= arg_211_1.time_ and arg_211_1.time_ < var_214_52 + var_214_53 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_52) / var_214_53

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_52 + var_214_53 and arg_211_1.time_ < var_214_52 + var_214_53 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
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

		arg_211_1:InitPlayNodeList()
	end,
	Play325102051 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 325102051
		arg_217_1.duration_ = 4.63

		local var_217_0 = {
			zh = 2.833,
			ja = 4.633
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
				arg_217_0:Play325102052(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = arg_217_1.actors_["1077ui_story"].transform
			local var_220_1 = 0

			if var_220_1 < arg_217_1.time_ and arg_217_1.time_ <= var_220_1 + arg_220_0 then
				arg_217_1.var_.moveOldPos1077ui_story = var_220_0.localPosition

				local var_220_2 = GameObjectTools.GetOrAddComponent(var_220_0.gameObject, typeof(DynamicBoneHelper))

				if var_220_2 then
					var_220_2:EnableDynamicBone(false)
				end
			end

			local var_220_3 = 0.001

			if var_220_1 <= arg_217_1.time_ and arg_217_1.time_ < var_220_1 + var_220_3 then
				local var_220_4 = (arg_217_1.time_ - var_220_1) / var_220_3
				local var_220_5 = Vector3.New(-0.03, -1.02, -5.92)

				var_220_0.localPosition = Vector3.Lerp(arg_217_1.var_.moveOldPos1077ui_story, var_220_5, var_220_4)

				local var_220_6 = manager.ui.mainCamera.transform.position - var_220_0.position

				var_220_0.forward = Vector3.New(var_220_6.x, var_220_6.y, var_220_6.z)

				local var_220_7 = var_220_0.localEulerAngles

				var_220_7.z = 0
				var_220_7.x = 0
				var_220_0.localEulerAngles = var_220_7
			end

			if arg_217_1.time_ >= var_220_1 + var_220_3 and arg_217_1.time_ < var_220_1 + var_220_3 + arg_220_0 then
				var_220_0.localPosition = Vector3.New(-0.03, -1.02, -5.92)

				local var_220_8 = manager.ui.mainCamera.transform.position - var_220_0.position

				var_220_0.forward = Vector3.New(var_220_8.x, var_220_8.y, var_220_8.z)

				local var_220_9 = var_220_0.localEulerAngles

				var_220_9.z = 0
				var_220_9.x = 0
				var_220_0.localEulerAngles = var_220_9

				local var_220_10 = GameObjectTools.GetOrAddComponent(var_220_0.gameObject, typeof(DynamicBoneHelper))

				if var_220_10 then
					var_220_10:EnableDynamicBone(true)
				end
			end

			local var_220_11 = arg_217_1.actors_["1077ui_story"]
			local var_220_12 = 0

			if var_220_12 < arg_217_1.time_ and arg_217_1.time_ <= var_220_12 + arg_220_0 and not isNil(var_220_11) and arg_217_1.var_.characterEffect1077ui_story == nil then
				arg_217_1.var_.characterEffect1077ui_story = var_220_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_220_13 = 0.200000002980232

			if var_220_12 <= arg_217_1.time_ and arg_217_1.time_ < var_220_12 + var_220_13 and not isNil(var_220_11) then
				local var_220_14 = (arg_217_1.time_ - var_220_12) / var_220_13

				if arg_217_1.var_.characterEffect1077ui_story and not isNil(var_220_11) then
					arg_217_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_217_1.time_ >= var_220_12 + var_220_13 and arg_217_1.time_ < var_220_12 + var_220_13 + arg_220_0 and not isNil(var_220_11) and arg_217_1.var_.characterEffect1077ui_story then
				arg_217_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_220_15 = 0

			if var_220_15 < arg_217_1.time_ and arg_217_1.time_ <= var_220_15 + arg_220_0 then
				arg_217_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action1_1")
			end

			local var_220_16 = 0

			if var_220_16 < arg_217_1.time_ and arg_217_1.time_ <= var_220_16 + arg_220_0 then
				arg_217_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_220_17 = 0
			local var_220_18 = 0.375

			if var_220_17 < arg_217_1.time_ and arg_217_1.time_ <= var_220_17 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				local var_220_19 = arg_217_1:FormatText(StoryNameCfg[1467].name)

				arg_217_1.leftNameTxt_.text = var_220_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_20 = arg_217_1:GetWordFromCfg(325102051)
				local var_220_21 = arg_217_1:FormatText(var_220_20.content)

				arg_217_1.text_.text = var_220_21

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_22 = 15
				local var_220_23 = utf8.len(var_220_21)
				local var_220_24 = var_220_22 <= 0 and var_220_18 or var_220_18 * (var_220_23 / var_220_22)

				if var_220_24 > 0 and var_220_18 < var_220_24 then
					arg_217_1.talkMaxDuration = var_220_24

					if var_220_24 + var_220_17 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_24 + var_220_17
					end
				end

				arg_217_1.text_.text = var_220_21
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325102", "325102051", "story_v_out_325102.awb") ~= 0 then
					local var_220_25 = manager.audio:GetVoiceLength("story_v_out_325102", "325102051", "story_v_out_325102.awb") / 1000

					if var_220_25 + var_220_17 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_25 + var_220_17
					end

					if var_220_20.prefab_name ~= "" and arg_217_1.actors_[var_220_20.prefab_name] ~= nil then
						local var_220_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_217_1.actors_[var_220_20.prefab_name].transform, "story_v_out_325102", "325102051", "story_v_out_325102.awb")

						arg_217_1:RecordAudio("325102051", var_220_26)
						arg_217_1:RecordAudio("325102051", var_220_26)
					else
						arg_217_1:AudioAction("play", "voice", "story_v_out_325102", "325102051", "story_v_out_325102.awb")
					end

					arg_217_1:RecordHistoryTalkVoice("story_v_out_325102", "325102051", "story_v_out_325102.awb")
				end

				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_27 = math.max(var_220_18, arg_217_1.talkMaxDuration)

			if var_220_17 <= arg_217_1.time_ and arg_217_1.time_ < var_220_17 + var_220_27 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_17) / var_220_27

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_17 + var_220_27 and arg_217_1.time_ < var_220_17 + var_220_27 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
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
	Play325102052 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 325102052
		arg_221_1.duration_ = 13.5

		local var_221_0 = {
			zh = 8,
			ja = 13.5
		}
		local var_221_1 = manager.audio:GetLocalizationFlag()

		if var_221_0[var_221_1] ~= nil then
			arg_221_1.duration_ = var_221_0[var_221_1]
		end

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play325102053(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			local var_224_0 = arg_221_1.actors_["1077ui_story"].transform
			local var_224_1 = 0

			if var_224_1 < arg_221_1.time_ and arg_221_1.time_ <= var_224_1 + arg_224_0 then
				arg_221_1.var_.moveOldPos1077ui_story = var_224_0.localPosition

				local var_224_2 = GameObjectTools.GetOrAddComponent(var_224_0.gameObject, typeof(DynamicBoneHelper))

				if var_224_2 then
					var_224_2:EnableDynamicBone(false)
				end
			end

			local var_224_3 = 0.001

			if var_224_1 <= arg_221_1.time_ and arg_221_1.time_ < var_224_1 + var_224_3 then
				local var_224_4 = (arg_221_1.time_ - var_224_1) / var_224_3
				local var_224_5 = Vector3.New(-0.83, -1.02, -5.92)

				var_224_0.localPosition = Vector3.Lerp(arg_221_1.var_.moveOldPos1077ui_story, var_224_5, var_224_4)

				local var_224_6 = manager.ui.mainCamera.transform.position - var_224_0.position

				var_224_0.forward = Vector3.New(var_224_6.x, var_224_6.y, var_224_6.z)

				local var_224_7 = var_224_0.localEulerAngles

				var_224_7.z = 0
				var_224_7.x = 0
				var_224_0.localEulerAngles = var_224_7
			end

			if arg_221_1.time_ >= var_224_1 + var_224_3 and arg_221_1.time_ < var_224_1 + var_224_3 + arg_224_0 then
				var_224_0.localPosition = Vector3.New(-0.83, -1.02, -5.92)

				local var_224_8 = manager.ui.mainCamera.transform.position - var_224_0.position

				var_224_0.forward = Vector3.New(var_224_8.x, var_224_8.y, var_224_8.z)

				local var_224_9 = var_224_0.localEulerAngles

				var_224_9.z = 0
				var_224_9.x = 0
				var_224_0.localEulerAngles = var_224_9

				local var_224_10 = GameObjectTools.GetOrAddComponent(var_224_0.gameObject, typeof(DynamicBoneHelper))

				if var_224_10 then
					var_224_10:EnableDynamicBone(true)
				end
			end

			local var_224_11 = arg_221_1.actors_["1061ui_story"].transform
			local var_224_12 = 0

			if var_224_12 < arg_221_1.time_ and arg_221_1.time_ <= var_224_12 + arg_224_0 then
				arg_221_1.var_.moveOldPos1061ui_story = var_224_11.localPosition
			end

			local var_224_13 = 0.001

			if var_224_12 <= arg_221_1.time_ and arg_221_1.time_ < var_224_12 + var_224_13 then
				local var_224_14 = (arg_221_1.time_ - var_224_12) / var_224_13
				local var_224_15 = Vector3.New(0.7, -1.18, -6.15)

				var_224_11.localPosition = Vector3.Lerp(arg_221_1.var_.moveOldPos1061ui_story, var_224_15, var_224_14)

				local var_224_16 = manager.ui.mainCamera.transform.position - var_224_11.position

				var_224_11.forward = Vector3.New(var_224_16.x, var_224_16.y, var_224_16.z)

				local var_224_17 = var_224_11.localEulerAngles

				var_224_17.z = 0
				var_224_17.x = 0
				var_224_11.localEulerAngles = var_224_17
			end

			if arg_221_1.time_ >= var_224_12 + var_224_13 and arg_221_1.time_ < var_224_12 + var_224_13 + arg_224_0 then
				var_224_11.localPosition = Vector3.New(0.7, -1.18, -6.15)

				local var_224_18 = manager.ui.mainCamera.transform.position - var_224_11.position

				var_224_11.forward = Vector3.New(var_224_18.x, var_224_18.y, var_224_18.z)

				local var_224_19 = var_224_11.localEulerAngles

				var_224_19.z = 0
				var_224_19.x = 0
				var_224_11.localEulerAngles = var_224_19
			end

			local var_224_20 = arg_221_1.actors_["1061ui_story"]
			local var_224_21 = 0

			if var_224_21 < arg_221_1.time_ and arg_221_1.time_ <= var_224_21 + arg_224_0 and not isNil(var_224_20) and arg_221_1.var_.characterEffect1061ui_story == nil then
				arg_221_1.var_.characterEffect1061ui_story = var_224_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_224_22 = 0.200000002980232

			if var_224_21 <= arg_221_1.time_ and arg_221_1.time_ < var_224_21 + var_224_22 and not isNil(var_224_20) then
				local var_224_23 = (arg_221_1.time_ - var_224_21) / var_224_22

				if arg_221_1.var_.characterEffect1061ui_story and not isNil(var_224_20) then
					arg_221_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_221_1.time_ >= var_224_21 + var_224_22 and arg_221_1.time_ < var_224_21 + var_224_22 + arg_224_0 and not isNil(var_224_20) and arg_221_1.var_.characterEffect1061ui_story then
				arg_221_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_224_24 = arg_221_1.actors_["1077ui_story"]
			local var_224_25 = 0

			if var_224_25 < arg_221_1.time_ and arg_221_1.time_ <= var_224_25 + arg_224_0 and not isNil(var_224_24) and arg_221_1.var_.characterEffect1077ui_story == nil then
				arg_221_1.var_.characterEffect1077ui_story = var_224_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_224_26 = 0.200000002980232

			if var_224_25 <= arg_221_1.time_ and arg_221_1.time_ < var_224_25 + var_224_26 and not isNil(var_224_24) then
				local var_224_27 = (arg_221_1.time_ - var_224_25) / var_224_26

				if arg_221_1.var_.characterEffect1077ui_story and not isNil(var_224_24) then
					local var_224_28 = Mathf.Lerp(0, 0.5, var_224_27)

					arg_221_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_221_1.var_.characterEffect1077ui_story.fillRatio = var_224_28
				end
			end

			if arg_221_1.time_ >= var_224_25 + var_224_26 and arg_221_1.time_ < var_224_25 + var_224_26 + arg_224_0 and not isNil(var_224_24) and arg_221_1.var_.characterEffect1077ui_story then
				local var_224_29 = 0.5

				arg_221_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_221_1.var_.characterEffect1077ui_story.fillRatio = var_224_29
			end

			local var_224_30 = 0

			if var_224_30 < arg_221_1.time_ and arg_221_1.time_ <= var_224_30 + arg_224_0 then
				arg_221_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action5_1")
			end

			local var_224_31 = 0
			local var_224_32 = 0.975

			if var_224_31 < arg_221_1.time_ and arg_221_1.time_ <= var_224_31 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				local var_224_33 = arg_221_1:FormatText(StoryNameCfg[612].name)

				arg_221_1.leftNameTxt_.text = var_224_33

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_34 = arg_221_1:GetWordFromCfg(325102052)
				local var_224_35 = arg_221_1:FormatText(var_224_34.content)

				arg_221_1.text_.text = var_224_35

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_36 = 39
				local var_224_37 = utf8.len(var_224_35)
				local var_224_38 = var_224_36 <= 0 and var_224_32 or var_224_32 * (var_224_37 / var_224_36)

				if var_224_38 > 0 and var_224_32 < var_224_38 then
					arg_221_1.talkMaxDuration = var_224_38

					if var_224_38 + var_224_31 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_38 + var_224_31
					end
				end

				arg_221_1.text_.text = var_224_35
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325102", "325102052", "story_v_out_325102.awb") ~= 0 then
					local var_224_39 = manager.audio:GetVoiceLength("story_v_out_325102", "325102052", "story_v_out_325102.awb") / 1000

					if var_224_39 + var_224_31 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_39 + var_224_31
					end

					if var_224_34.prefab_name ~= "" and arg_221_1.actors_[var_224_34.prefab_name] ~= nil then
						local var_224_40 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_34.prefab_name].transform, "story_v_out_325102", "325102052", "story_v_out_325102.awb")

						arg_221_1:RecordAudio("325102052", var_224_40)
						arg_221_1:RecordAudio("325102052", var_224_40)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_out_325102", "325102052", "story_v_out_325102.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_out_325102", "325102052", "story_v_out_325102.awb")
				end

				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_41 = math.max(var_224_32, arg_221_1.talkMaxDuration)

			if var_224_31 <= arg_221_1.time_ and arg_221_1.time_ < var_224_31 + var_224_41 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_31) / var_224_41

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_31 + var_224_41 and arg_221_1.time_ < var_224_31 + var_224_41 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
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

		arg_221_1:InitPlayNodeList()
	end,
	Play325102053 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 325102053
		arg_225_1.duration_ = 4.03

		local var_225_0 = {
			zh = 2.3,
			ja = 4.033
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
				arg_225_0:Play325102054(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = 0
			local var_228_1 = 0.35

			if var_228_0 < arg_225_1.time_ and arg_225_1.time_ <= var_228_0 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				local var_228_2 = arg_225_1:FormatText(StoryNameCfg[612].name)

				arg_225_1.leftNameTxt_.text = var_228_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_3 = arg_225_1:GetWordFromCfg(325102053)
				local var_228_4 = arg_225_1:FormatText(var_228_3.content)

				arg_225_1.text_.text = var_228_4

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_5 = 14
				local var_228_6 = utf8.len(var_228_4)
				local var_228_7 = var_228_5 <= 0 and var_228_1 or var_228_1 * (var_228_6 / var_228_5)

				if var_228_7 > 0 and var_228_1 < var_228_7 then
					arg_225_1.talkMaxDuration = var_228_7

					if var_228_7 + var_228_0 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_7 + var_228_0
					end
				end

				arg_225_1.text_.text = var_228_4
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325102", "325102053", "story_v_out_325102.awb") ~= 0 then
					local var_228_8 = manager.audio:GetVoiceLength("story_v_out_325102", "325102053", "story_v_out_325102.awb") / 1000

					if var_228_8 + var_228_0 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_8 + var_228_0
					end

					if var_228_3.prefab_name ~= "" and arg_225_1.actors_[var_228_3.prefab_name] ~= nil then
						local var_228_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_225_1.actors_[var_228_3.prefab_name].transform, "story_v_out_325102", "325102053", "story_v_out_325102.awb")

						arg_225_1:RecordAudio("325102053", var_228_9)
						arg_225_1:RecordAudio("325102053", var_228_9)
					else
						arg_225_1:AudioAction("play", "voice", "story_v_out_325102", "325102053", "story_v_out_325102.awb")
					end

					arg_225_1:RecordHistoryTalkVoice("story_v_out_325102", "325102053", "story_v_out_325102.awb")
				end

				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_10 = math.max(var_228_1, arg_225_1.talkMaxDuration)

			if var_228_0 <= arg_225_1.time_ and arg_225_1.time_ < var_228_0 + var_228_10 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_0) / var_228_10

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_0 + var_228_10 and arg_225_1.time_ < var_228_0 + var_228_10 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {}

		arg_225_1:InitPlayNodeList()
	end,
	Play325102054 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 325102054
		arg_229_1.duration_ = 11.5

		local var_229_0 = {
			zh = 3.7,
			ja = 11.5
		}
		local var_229_1 = manager.audio:GetLocalizationFlag()

		if var_229_0[var_229_1] ~= nil then
			arg_229_1.duration_ = var_229_0[var_229_1]
		end

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play325102055(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = arg_229_1.actors_["1077ui_story"]
			local var_232_1 = 0

			if var_232_1 < arg_229_1.time_ and arg_229_1.time_ <= var_232_1 + arg_232_0 and not isNil(var_232_0) and arg_229_1.var_.characterEffect1077ui_story == nil then
				arg_229_1.var_.characterEffect1077ui_story = var_232_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_232_2 = 0.200000002980232

			if var_232_1 <= arg_229_1.time_ and arg_229_1.time_ < var_232_1 + var_232_2 and not isNil(var_232_0) then
				local var_232_3 = (arg_229_1.time_ - var_232_1) / var_232_2

				if arg_229_1.var_.characterEffect1077ui_story and not isNil(var_232_0) then
					arg_229_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_229_1.time_ >= var_232_1 + var_232_2 and arg_229_1.time_ < var_232_1 + var_232_2 + arg_232_0 and not isNil(var_232_0) and arg_229_1.var_.characterEffect1077ui_story then
				arg_229_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_232_4 = arg_229_1.actors_["1061ui_story"]
			local var_232_5 = 0

			if var_232_5 < arg_229_1.time_ and arg_229_1.time_ <= var_232_5 + arg_232_0 and not isNil(var_232_4) and arg_229_1.var_.characterEffect1061ui_story == nil then
				arg_229_1.var_.characterEffect1061ui_story = var_232_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_232_6 = 0.200000002980232

			if var_232_5 <= arg_229_1.time_ and arg_229_1.time_ < var_232_5 + var_232_6 and not isNil(var_232_4) then
				local var_232_7 = (arg_229_1.time_ - var_232_5) / var_232_6

				if arg_229_1.var_.characterEffect1061ui_story and not isNil(var_232_4) then
					local var_232_8 = Mathf.Lerp(0, 0.5, var_232_7)

					arg_229_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_229_1.var_.characterEffect1061ui_story.fillRatio = var_232_8
				end
			end

			if arg_229_1.time_ >= var_232_5 + var_232_6 and arg_229_1.time_ < var_232_5 + var_232_6 + arg_232_0 and not isNil(var_232_4) and arg_229_1.var_.characterEffect1061ui_story then
				local var_232_9 = 0.5

				arg_229_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_229_1.var_.characterEffect1061ui_story.fillRatio = var_232_9
			end

			local var_232_10 = 0

			if var_232_10 < arg_229_1.time_ and arg_229_1.time_ <= var_232_10 + arg_232_0 then
				arg_229_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action2_1")
			end

			local var_232_11 = 0

			if var_232_11 < arg_229_1.time_ and arg_229_1.time_ <= var_232_11 + arg_232_0 then
				arg_229_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_232_12 = 0
			local var_232_13 = 0.425

			if var_232_12 < arg_229_1.time_ and arg_229_1.time_ <= var_232_12 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				local var_232_14 = arg_229_1:FormatText(StoryNameCfg[1467].name)

				arg_229_1.leftNameTxt_.text = var_232_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_15 = arg_229_1:GetWordFromCfg(325102054)
				local var_232_16 = arg_229_1:FormatText(var_232_15.content)

				arg_229_1.text_.text = var_232_16

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_17 = 17
				local var_232_18 = utf8.len(var_232_16)
				local var_232_19 = var_232_17 <= 0 and var_232_13 or var_232_13 * (var_232_18 / var_232_17)

				if var_232_19 > 0 and var_232_13 < var_232_19 then
					arg_229_1.talkMaxDuration = var_232_19

					if var_232_19 + var_232_12 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_19 + var_232_12
					end
				end

				arg_229_1.text_.text = var_232_16
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325102", "325102054", "story_v_out_325102.awb") ~= 0 then
					local var_232_20 = manager.audio:GetVoiceLength("story_v_out_325102", "325102054", "story_v_out_325102.awb") / 1000

					if var_232_20 + var_232_12 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_20 + var_232_12
					end

					if var_232_15.prefab_name ~= "" and arg_229_1.actors_[var_232_15.prefab_name] ~= nil then
						local var_232_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_15.prefab_name].transform, "story_v_out_325102", "325102054", "story_v_out_325102.awb")

						arg_229_1:RecordAudio("325102054", var_232_21)
						arg_229_1:RecordAudio("325102054", var_232_21)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_out_325102", "325102054", "story_v_out_325102.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_out_325102", "325102054", "story_v_out_325102.awb")
				end

				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_22 = math.max(var_232_13, arg_229_1.talkMaxDuration)

			if var_232_12 <= arg_229_1.time_ and arg_229_1.time_ < var_232_12 + var_232_22 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_12) / var_232_22

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_12 + var_232_22 and arg_229_1.time_ < var_232_12 + var_232_22 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {}

		arg_229_1:InitPlayNodeList()
	end,
	Play325102055 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 325102055
		arg_233_1.duration_ = 5

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play325102056(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			local var_236_0 = arg_233_1.actors_["1077ui_story"].transform
			local var_236_1 = 0

			if var_236_1 < arg_233_1.time_ and arg_233_1.time_ <= var_236_1 + arg_236_0 then
				arg_233_1.var_.moveOldPos1077ui_story = var_236_0.localPosition

				local var_236_2 = GameObjectTools.GetOrAddComponent(var_236_0.gameObject, typeof(DynamicBoneHelper))

				if var_236_2 then
					var_236_2:EnableDynamicBone(false)
				end
			end

			local var_236_3 = 0.001

			if var_236_1 <= arg_233_1.time_ and arg_233_1.time_ < var_236_1 + var_236_3 then
				local var_236_4 = (arg_233_1.time_ - var_236_1) / var_236_3
				local var_236_5 = Vector3.New(0, 100, 0)

				var_236_0.localPosition = Vector3.Lerp(arg_233_1.var_.moveOldPos1077ui_story, var_236_5, var_236_4)

				local var_236_6 = manager.ui.mainCamera.transform.position - var_236_0.position

				var_236_0.forward = Vector3.New(var_236_6.x, var_236_6.y, var_236_6.z)

				local var_236_7 = var_236_0.localEulerAngles

				var_236_7.z = 0
				var_236_7.x = 0
				var_236_0.localEulerAngles = var_236_7
			end

			if arg_233_1.time_ >= var_236_1 + var_236_3 and arg_233_1.time_ < var_236_1 + var_236_3 + arg_236_0 then
				var_236_0.localPosition = Vector3.New(0, 100, 0)

				local var_236_8 = manager.ui.mainCamera.transform.position - var_236_0.position

				var_236_0.forward = Vector3.New(var_236_8.x, var_236_8.y, var_236_8.z)

				local var_236_9 = var_236_0.localEulerAngles

				var_236_9.z = 0
				var_236_9.x = 0
				var_236_0.localEulerAngles = var_236_9

				local var_236_10 = GameObjectTools.GetOrAddComponent(var_236_0.gameObject, typeof(DynamicBoneHelper))

				if var_236_10 then
					var_236_10:EnableDynamicBone(true)
				end
			end

			local var_236_11 = arg_233_1.actors_["1061ui_story"].transform
			local var_236_12 = 0

			if var_236_12 < arg_233_1.time_ and arg_233_1.time_ <= var_236_12 + arg_236_0 then
				arg_233_1.var_.moveOldPos1061ui_story = var_236_11.localPosition
			end

			local var_236_13 = 0.001

			if var_236_12 <= arg_233_1.time_ and arg_233_1.time_ < var_236_12 + var_236_13 then
				local var_236_14 = (arg_233_1.time_ - var_236_12) / var_236_13
				local var_236_15 = Vector3.New(0, 100, 0)

				var_236_11.localPosition = Vector3.Lerp(arg_233_1.var_.moveOldPos1061ui_story, var_236_15, var_236_14)

				local var_236_16 = manager.ui.mainCamera.transform.position - var_236_11.position

				var_236_11.forward = Vector3.New(var_236_16.x, var_236_16.y, var_236_16.z)

				local var_236_17 = var_236_11.localEulerAngles

				var_236_17.z = 0
				var_236_17.x = 0
				var_236_11.localEulerAngles = var_236_17
			end

			if arg_233_1.time_ >= var_236_12 + var_236_13 and arg_233_1.time_ < var_236_12 + var_236_13 + arg_236_0 then
				var_236_11.localPosition = Vector3.New(0, 100, 0)

				local var_236_18 = manager.ui.mainCamera.transform.position - var_236_11.position

				var_236_11.forward = Vector3.New(var_236_18.x, var_236_18.y, var_236_18.z)

				local var_236_19 = var_236_11.localEulerAngles

				var_236_19.z = 0
				var_236_19.x = 0
				var_236_11.localEulerAngles = var_236_19
			end

			local var_236_20 = arg_233_1.actors_["1077ui_story"]
			local var_236_21 = 0

			if var_236_21 < arg_233_1.time_ and arg_233_1.time_ <= var_236_21 + arg_236_0 and not isNil(var_236_20) and arg_233_1.var_.characterEffect1077ui_story == nil then
				arg_233_1.var_.characterEffect1077ui_story = var_236_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_236_22 = 0.200000002980232

			if var_236_21 <= arg_233_1.time_ and arg_233_1.time_ < var_236_21 + var_236_22 and not isNil(var_236_20) then
				local var_236_23 = (arg_233_1.time_ - var_236_21) / var_236_22

				if arg_233_1.var_.characterEffect1077ui_story and not isNil(var_236_20) then
					local var_236_24 = Mathf.Lerp(0, 0.5, var_236_23)

					arg_233_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_233_1.var_.characterEffect1077ui_story.fillRatio = var_236_24
				end
			end

			if arg_233_1.time_ >= var_236_21 + var_236_22 and arg_233_1.time_ < var_236_21 + var_236_22 + arg_236_0 and not isNil(var_236_20) and arg_233_1.var_.characterEffect1077ui_story then
				local var_236_25 = 0.5

				arg_233_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_233_1.var_.characterEffect1077ui_story.fillRatio = var_236_25
			end

			local var_236_26 = 0
			local var_236_27 = 1.05

			if var_236_26 < arg_233_1.time_ and arg_233_1.time_ <= var_236_26 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, false)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_28 = arg_233_1:GetWordFromCfg(325102055)
				local var_236_29 = arg_233_1:FormatText(var_236_28.content)

				arg_233_1.text_.text = var_236_29

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_30 = 42
				local var_236_31 = utf8.len(var_236_29)
				local var_236_32 = var_236_30 <= 0 and var_236_27 or var_236_27 * (var_236_31 / var_236_30)

				if var_236_32 > 0 and var_236_27 < var_236_32 then
					arg_233_1.talkMaxDuration = var_236_32

					if var_236_32 + var_236_26 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_32 + var_236_26
					end
				end

				arg_233_1.text_.text = var_236_29
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)
				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_33 = math.max(var_236_27, arg_233_1.talkMaxDuration)

			if var_236_26 <= arg_233_1.time_ and arg_233_1.time_ < var_236_26 + var_236_33 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_26) / var_236_33

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_26 + var_236_33 and arg_233_1.time_ < var_236_26 + var_236_33 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
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

		arg_233_1:InitPlayNodeList()
	end,
	Play325102056 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 325102056
		arg_237_1.duration_ = 5

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play325102057(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			local var_240_0 = 0
			local var_240_1 = 0.75

			if var_240_0 < arg_237_1.time_ and arg_237_1.time_ <= var_240_0 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, false)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_2 = arg_237_1:GetWordFromCfg(325102056)
				local var_240_3 = arg_237_1:FormatText(var_240_2.content)

				arg_237_1.text_.text = var_240_3

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_4 = 30
				local var_240_5 = utf8.len(var_240_3)
				local var_240_6 = var_240_4 <= 0 and var_240_1 or var_240_1 * (var_240_5 / var_240_4)

				if var_240_6 > 0 and var_240_1 < var_240_6 then
					arg_237_1.talkMaxDuration = var_240_6

					if var_240_6 + var_240_0 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_6 + var_240_0
					end
				end

				arg_237_1.text_.text = var_240_3
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)
				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_7 = math.max(var_240_1, arg_237_1.talkMaxDuration)

			if var_240_0 <= arg_237_1.time_ and arg_237_1.time_ < var_240_0 + var_240_7 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_0) / var_240_7

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_0 + var_240_7 and arg_237_1.time_ < var_240_0 + var_240_7 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {}

		arg_237_1:InitPlayNodeList()
	end,
	Play325102057 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 325102057
		arg_241_1.duration_ = 13.63

		local var_241_0 = {
			zh = 10.5333333333333,
			ja = 13.6333333333333
		}
		local var_241_1 = manager.audio:GetLocalizationFlag()

		if var_241_0[var_241_1] ~= nil then
			arg_241_1.duration_ = var_241_0[var_241_1]
		end

		SetActive(arg_241_1.tipsGo_, false)

		function arg_241_1.onSingleLineFinish_()
			arg_241_1.onSingleLineUpdate_ = nil
			arg_241_1.onSingleLineFinish_ = nil
			arg_241_1.state_ = "waiting"
		end

		function arg_241_1.playNext_(arg_243_0)
			if arg_243_0 == 1 then
				arg_241_0:Play325102058(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			local var_244_0 = "J03h"

			if arg_241_1.bgs_[var_244_0] == nil then
				local var_244_1 = Object.Instantiate(arg_241_1.paintGo_)

				var_244_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_244_0)
				var_244_1.name = var_244_0
				var_244_1.transform.parent = arg_241_1.stage_.transform
				var_244_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_241_1.bgs_[var_244_0] = var_244_1
			end

			local var_244_2 = 1.43333333333333

			if var_244_2 < arg_241_1.time_ and arg_241_1.time_ <= var_244_2 + arg_244_0 then
				local var_244_3 = manager.ui.mainCamera.transform.localPosition
				local var_244_4 = Vector3.New(0, 0, 10) + Vector3.New(var_244_3.x, var_244_3.y, 0)
				local var_244_5 = arg_241_1.bgs_.J03h

				var_244_5.transform.localPosition = var_244_4
				var_244_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_244_6 = var_244_5:GetComponent("SpriteRenderer")

				if var_244_6 and var_244_6.sprite then
					local var_244_7 = (var_244_5.transform.localPosition - var_244_3).z
					local var_244_8 = manager.ui.mainCameraCom_
					local var_244_9 = 2 * var_244_7 * Mathf.Tan(var_244_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_244_10 = var_244_9 * var_244_8.aspect
					local var_244_11 = var_244_6.sprite.bounds.size.x
					local var_244_12 = var_244_6.sprite.bounds.size.y
					local var_244_13 = var_244_10 / var_244_11
					local var_244_14 = var_244_9 / var_244_12
					local var_244_15 = var_244_14 < var_244_13 and var_244_13 or var_244_14

					var_244_5.transform.localScale = Vector3.New(var_244_15, var_244_15, 0)
				end

				for iter_244_0, iter_244_1 in pairs(arg_241_1.bgs_) do
					if iter_244_0 ~= "J03h" then
						iter_244_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_244_16 = 0

			if var_244_16 < arg_241_1.time_ and arg_241_1.time_ <= var_244_16 + arg_244_0 then
				arg_241_1.allBtn_.enabled = false
			end

			local var_244_17 = 0.3

			if arg_241_1.time_ >= var_244_16 + var_244_17 and arg_241_1.time_ < var_244_16 + var_244_17 + arg_244_0 then
				arg_241_1.allBtn_.enabled = true
			end

			local var_244_18 = 0

			if var_244_18 < arg_241_1.time_ and arg_241_1.time_ <= var_244_18 + arg_244_0 then
				arg_241_1.mask_.enabled = true
				arg_241_1.mask_.raycastTarget = true

				arg_241_1:SetGaussion(false)
			end

			local var_244_19 = 1.43333333333333

			if var_244_18 <= arg_241_1.time_ and arg_241_1.time_ < var_244_18 + var_244_19 then
				local var_244_20 = (arg_241_1.time_ - var_244_18) / var_244_19
				local var_244_21 = Color.New(0, 0, 0)

				var_244_21.a = Mathf.Lerp(0, 1, var_244_20)
				arg_241_1.mask_.color = var_244_21
			end

			if arg_241_1.time_ >= var_244_18 + var_244_19 and arg_241_1.time_ < var_244_18 + var_244_19 + arg_244_0 then
				local var_244_22 = Color.New(0, 0, 0)

				var_244_22.a = 1
				arg_241_1.mask_.color = var_244_22
			end

			local var_244_23 = 1.43333333333333

			if var_244_23 < arg_241_1.time_ and arg_241_1.time_ <= var_244_23 + arg_244_0 then
				arg_241_1.mask_.enabled = true
				arg_241_1.mask_.raycastTarget = true

				arg_241_1:SetGaussion(false)
			end

			local var_244_24 = 1.4

			if var_244_23 <= arg_241_1.time_ and arg_241_1.time_ < var_244_23 + var_244_24 then
				local var_244_25 = (arg_241_1.time_ - var_244_23) / var_244_24
				local var_244_26 = Color.New(0, 0, 0)

				var_244_26.a = Mathf.Lerp(1, 0, var_244_25)
				arg_241_1.mask_.color = var_244_26
			end

			if arg_241_1.time_ >= var_244_23 + var_244_24 and arg_241_1.time_ < var_244_23 + var_244_24 + arg_244_0 then
				local var_244_27 = Color.New(0, 0, 0)
				local var_244_28 = 0

				arg_241_1.mask_.enabled = false
				var_244_27.a = var_244_28
				arg_241_1.mask_.color = var_244_27
			end

			local var_244_29 = arg_241_1.actors_["1061ui_story"].transform
			local var_244_30 = 2.6333333303531

			if var_244_30 < arg_241_1.time_ and arg_241_1.time_ <= var_244_30 + arg_244_0 then
				arg_241_1.var_.moveOldPos1061ui_story = var_244_29.localPosition
			end

			local var_244_31 = 0.001

			if var_244_30 <= arg_241_1.time_ and arg_241_1.time_ < var_244_30 + var_244_31 then
				local var_244_32 = (arg_241_1.time_ - var_244_30) / var_244_31
				local var_244_33 = Vector3.New(0, -1.18, -6.15)

				var_244_29.localPosition = Vector3.Lerp(arg_241_1.var_.moveOldPos1061ui_story, var_244_33, var_244_32)

				local var_244_34 = manager.ui.mainCamera.transform.position - var_244_29.position

				var_244_29.forward = Vector3.New(var_244_34.x, var_244_34.y, var_244_34.z)

				local var_244_35 = var_244_29.localEulerAngles

				var_244_35.z = 0
				var_244_35.x = 0
				var_244_29.localEulerAngles = var_244_35
			end

			if arg_241_1.time_ >= var_244_30 + var_244_31 and arg_241_1.time_ < var_244_30 + var_244_31 + arg_244_0 then
				var_244_29.localPosition = Vector3.New(0, -1.18, -6.15)

				local var_244_36 = manager.ui.mainCamera.transform.position - var_244_29.position

				var_244_29.forward = Vector3.New(var_244_36.x, var_244_36.y, var_244_36.z)

				local var_244_37 = var_244_29.localEulerAngles

				var_244_37.z = 0
				var_244_37.x = 0
				var_244_29.localEulerAngles = var_244_37
			end

			local var_244_38 = arg_241_1.actors_["1061ui_story"]
			local var_244_39 = 2.6333333303531

			if var_244_39 < arg_241_1.time_ and arg_241_1.time_ <= var_244_39 + arg_244_0 and not isNil(var_244_38) and arg_241_1.var_.characterEffect1061ui_story == nil then
				arg_241_1.var_.characterEffect1061ui_story = var_244_38:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_244_40 = 0.200000002980232

			if var_244_39 <= arg_241_1.time_ and arg_241_1.time_ < var_244_39 + var_244_40 and not isNil(var_244_38) then
				local var_244_41 = (arg_241_1.time_ - var_244_39) / var_244_40

				if arg_241_1.var_.characterEffect1061ui_story and not isNil(var_244_38) then
					arg_241_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_241_1.time_ >= var_244_39 + var_244_40 and arg_241_1.time_ < var_244_39 + var_244_40 + arg_244_0 and not isNil(var_244_38) and arg_241_1.var_.characterEffect1061ui_story then
				arg_241_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_244_42 = 2.6333333303531

			if var_244_42 < arg_241_1.time_ and arg_241_1.time_ <= var_244_42 + arg_244_0 then
				arg_241_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action1_1")
			end

			local var_244_43 = arg_241_1.actors_["1061ui_story"]
			local var_244_44 = 2.6333333303531
			local var_244_45 = 5

			if var_244_44 < arg_241_1.time_ and arg_241_1.time_ <= var_244_44 + arg_244_0 then
				if arg_241_1.var_.characterEffect1061ui_story == nil then
					arg_241_1.var_.characterEffect1061ui_story = var_244_43:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_241_1.var_.characterEffect1061ui_story.imageEffect:turnOff()
			end

			local var_244_46 = arg_241_1.actors_["1061ui_story"]
			local var_244_47 = 2.6333333303531

			if var_244_47 < arg_241_1.time_ and arg_241_1.time_ <= var_244_47 + arg_244_0 then
				if arg_241_1.var_.characterEffect1061ui_story == nil then
					arg_241_1.var_.characterEffect1061ui_story = var_244_46:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_244_48 = arg_241_1.var_.characterEffect1061ui_story

				var_244_48.imageEffect:turnOff()

				var_244_48.interferenceEffect.enabled = false
				var_244_48.interferenceEffect.noise = 0.001
				var_244_48.interferenceEffect.simTimeScale = 1
				var_244_48.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			local var_244_49 = 1.43333333333333

			arg_241_1.isInRecall_ = false

			if var_244_49 < arg_241_1.time_ and arg_241_1.time_ <= var_244_49 + arg_244_0 then
				arg_241_1.screenFilterGo_:SetActive(true)

				arg_241_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile.asset")

				for iter_244_2, iter_244_3 in pairs(arg_241_1.actors_) do
					local var_244_50 = iter_244_3:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_244_4, iter_244_5 in ipairs(var_244_50) do
						if iter_244_5.color.r > 0.51 then
							iter_244_5.color = Color.New(1, 1, 1)
						else
							iter_244_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_244_51 = 0.034000001847744

			if var_244_49 <= arg_241_1.time_ and arg_241_1.time_ < var_244_49 + var_244_51 then
				local var_244_52 = (arg_241_1.time_ - var_244_49) / var_244_51

				arg_241_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, var_244_52)
			end

			if arg_241_1.time_ >= var_244_49 + var_244_51 and arg_241_1.time_ < var_244_49 + var_244_51 + arg_244_0 then
				arg_241_1.screenFilterEffect_.weight = 1
			end

			if arg_241_1.frameCnt_ <= 1 then
				arg_241_1.dialog_:SetActive(false)
			end

			local var_244_53 = 2.83333333333333
			local var_244_54 = 0.9

			if var_244_53 < arg_241_1.time_ and arg_241_1.time_ <= var_244_53 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0

				arg_241_1.dialog_:SetActive(true)

				arg_241_1.dialogCg_.alpha = 0

				local var_244_55 = LeanTween.value(arg_241_1.dialog_, 0, 1, 0.3)

				var_244_55:setOnUpdate(LuaHelper.FloatAction(function(arg_245_0)
					arg_241_1.dialogCg_.alpha = arg_245_0
				end))
				var_244_55:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_241_1.dialog_)
					var_244_55:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_241_1.duration_ = arg_241_1.duration_ + 0.3

				SetActive(arg_241_1.leftNameGo_, true)

				local var_244_56 = arg_241_1:FormatText(StoryNameCfg[612].name)

				arg_241_1.leftNameTxt_.text = var_244_56

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_57 = arg_241_1:GetWordFromCfg(325102057)
				local var_244_58 = arg_241_1:FormatText(var_244_57.content)

				arg_241_1.text_.text = var_244_58

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_59 = 36
				local var_244_60 = utf8.len(var_244_58)
				local var_244_61 = var_244_59 <= 0 and var_244_54 or var_244_54 * (var_244_60 / var_244_59)

				if var_244_61 > 0 and var_244_54 < var_244_61 then
					arg_241_1.talkMaxDuration = var_244_61
					var_244_53 = var_244_53 + 0.3

					if var_244_61 + var_244_53 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_61 + var_244_53
					end
				end

				arg_241_1.text_.text = var_244_58
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325102", "325102057", "story_v_out_325102.awb") ~= 0 then
					local var_244_62 = manager.audio:GetVoiceLength("story_v_out_325102", "325102057", "story_v_out_325102.awb") / 1000

					if var_244_62 + var_244_53 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_62 + var_244_53
					end

					if var_244_57.prefab_name ~= "" and arg_241_1.actors_[var_244_57.prefab_name] ~= nil then
						local var_244_63 = LuaForUtil.PlayVoiceWithCriLipsync(arg_241_1.actors_[var_244_57.prefab_name].transform, "story_v_out_325102", "325102057", "story_v_out_325102.awb")

						arg_241_1:RecordAudio("325102057", var_244_63)
						arg_241_1:RecordAudio("325102057", var_244_63)
					else
						arg_241_1:AudioAction("play", "voice", "story_v_out_325102", "325102057", "story_v_out_325102.awb")
					end

					arg_241_1:RecordHistoryTalkVoice("story_v_out_325102", "325102057", "story_v_out_325102.awb")
				end

				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_64 = var_244_53 + 0.3
			local var_244_65 = math.max(var_244_54, arg_241_1.talkMaxDuration)

			if var_244_64 <= arg_241_1.time_ and arg_241_1.time_ < var_244_64 + var_244_65 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_64) / var_244_65

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_64 + var_244_65 and arg_241_1.time_ < var_244_64 + var_244_65 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2.6333333303531,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_241_1:InitPlayNodeList()
	end,
	Play325102058 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 325102058
		arg_247_1.duration_ = 12.2

		local var_247_0 = {
			zh = 9.866,
			ja = 12.2
		}
		local var_247_1 = manager.audio:GetLocalizationFlag()

		if var_247_0[var_247_1] ~= nil then
			arg_247_1.duration_ = var_247_0[var_247_1]
		end

		SetActive(arg_247_1.tipsGo_, false)

		function arg_247_1.onSingleLineFinish_()
			arg_247_1.onSingleLineUpdate_ = nil
			arg_247_1.onSingleLineFinish_ = nil
			arg_247_1.state_ = "waiting"
		end

		function arg_247_1.playNext_(arg_249_0)
			if arg_249_0 == 1 then
				arg_247_0:Play325102059(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			local var_250_0 = 0
			local var_250_1 = 1.1

			if var_250_0 < arg_247_1.time_ and arg_247_1.time_ <= var_250_0 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				local var_250_2 = arg_247_1:FormatText(StoryNameCfg[612].name)

				arg_247_1.leftNameTxt_.text = var_250_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_3 = arg_247_1:GetWordFromCfg(325102058)
				local var_250_4 = arg_247_1:FormatText(var_250_3.content)

				arg_247_1.text_.text = var_250_4

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_5 = 44
				local var_250_6 = utf8.len(var_250_4)
				local var_250_7 = var_250_5 <= 0 and var_250_1 or var_250_1 * (var_250_6 / var_250_5)

				if var_250_7 > 0 and var_250_1 < var_250_7 then
					arg_247_1.talkMaxDuration = var_250_7

					if var_250_7 + var_250_0 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_7 + var_250_0
					end
				end

				arg_247_1.text_.text = var_250_4
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325102", "325102058", "story_v_out_325102.awb") ~= 0 then
					local var_250_8 = manager.audio:GetVoiceLength("story_v_out_325102", "325102058", "story_v_out_325102.awb") / 1000

					if var_250_8 + var_250_0 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_8 + var_250_0
					end

					if var_250_3.prefab_name ~= "" and arg_247_1.actors_[var_250_3.prefab_name] ~= nil then
						local var_250_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_247_1.actors_[var_250_3.prefab_name].transform, "story_v_out_325102", "325102058", "story_v_out_325102.awb")

						arg_247_1:RecordAudio("325102058", var_250_9)
						arg_247_1:RecordAudio("325102058", var_250_9)
					else
						arg_247_1:AudioAction("play", "voice", "story_v_out_325102", "325102058", "story_v_out_325102.awb")
					end

					arg_247_1:RecordHistoryTalkVoice("story_v_out_325102", "325102058", "story_v_out_325102.awb")
				end

				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_10 = math.max(var_250_1, arg_247_1.talkMaxDuration)

			if var_250_0 <= arg_247_1.time_ and arg_247_1.time_ < var_250_0 + var_250_10 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_0) / var_250_10

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_0 + var_250_10 and arg_247_1.time_ < var_250_0 + var_250_10 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {}

		arg_247_1:InitPlayNodeList()
	end,
	Play325102059 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 325102059
		arg_251_1.duration_ = 9.17

		local var_251_0 = {
			zh = 8.499999999999,
			ja = 9.165999999999
		}
		local var_251_1 = manager.audio:GetLocalizationFlag()

		if var_251_0[var_251_1] ~= nil then
			arg_251_1.duration_ = var_251_0[var_251_1]
		end

		SetActive(arg_251_1.tipsGo_, false)

		function arg_251_1.onSingleLineFinish_()
			arg_251_1.onSingleLineUpdate_ = nil
			arg_251_1.onSingleLineFinish_ = nil
			arg_251_1.state_ = "waiting"
		end

		function arg_251_1.playNext_(arg_253_0)
			if arg_253_0 == 1 then
				arg_251_0:Play325102060(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			local var_254_0 = 1.66666666666667

			if var_254_0 < arg_251_1.time_ and arg_251_1.time_ <= var_254_0 + arg_254_0 then
				local var_254_1 = manager.ui.mainCamera.transform.localPosition
				local var_254_2 = Vector3.New(0, 0, 10) + Vector3.New(var_254_1.x, var_254_1.y, 0)
				local var_254_3 = arg_251_1.bgs_.J22f

				var_254_3.transform.localPosition = var_254_2
				var_254_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_254_4 = var_254_3:GetComponent("SpriteRenderer")

				if var_254_4 and var_254_4.sprite then
					local var_254_5 = (var_254_3.transform.localPosition - var_254_1).z
					local var_254_6 = manager.ui.mainCameraCom_
					local var_254_7 = 2 * var_254_5 * Mathf.Tan(var_254_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_254_8 = var_254_7 * var_254_6.aspect
					local var_254_9 = var_254_4.sprite.bounds.size.x
					local var_254_10 = var_254_4.sprite.bounds.size.y
					local var_254_11 = var_254_8 / var_254_9
					local var_254_12 = var_254_7 / var_254_10
					local var_254_13 = var_254_12 < var_254_11 and var_254_11 or var_254_12

					var_254_3.transform.localScale = Vector3.New(var_254_13, var_254_13, 0)
				end

				for iter_254_0, iter_254_1 in pairs(arg_251_1.bgs_) do
					if iter_254_0 ~= "J22f" then
						iter_254_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_254_14 = 1.66666666666667

			if var_254_14 < arg_251_1.time_ and arg_251_1.time_ <= var_254_14 + arg_254_0 then
				arg_251_1.allBtn_.enabled = false
			end

			local var_254_15 = 0.3

			if arg_251_1.time_ >= var_254_14 + var_254_15 and arg_251_1.time_ < var_254_14 + var_254_15 + arg_254_0 then
				arg_251_1.allBtn_.enabled = true
			end

			local var_254_16 = 0

			if var_254_16 < arg_251_1.time_ and arg_251_1.time_ <= var_254_16 + arg_254_0 then
				arg_251_1.mask_.enabled = true
				arg_251_1.mask_.raycastTarget = true

				arg_251_1:SetGaussion(false)
			end

			local var_254_17 = 1.66666666666667

			if var_254_16 <= arg_251_1.time_ and arg_251_1.time_ < var_254_16 + var_254_17 then
				local var_254_18 = (arg_251_1.time_ - var_254_16) / var_254_17
				local var_254_19 = Color.New(0, 0, 0)

				var_254_19.a = Mathf.Lerp(0, 1, var_254_18)
				arg_251_1.mask_.color = var_254_19
			end

			if arg_251_1.time_ >= var_254_16 + var_254_17 and arg_251_1.time_ < var_254_16 + var_254_17 + arg_254_0 then
				local var_254_20 = Color.New(0, 0, 0)

				var_254_20.a = 1
				arg_251_1.mask_.color = var_254_20
			end

			local var_254_21 = 1.66666666666667

			if var_254_21 < arg_251_1.time_ and arg_251_1.time_ <= var_254_21 + arg_254_0 then
				arg_251_1.mask_.enabled = true
				arg_251_1.mask_.raycastTarget = true

				arg_251_1:SetGaussion(false)
			end

			local var_254_22 = 2

			if var_254_21 <= arg_251_1.time_ and arg_251_1.time_ < var_254_21 + var_254_22 then
				local var_254_23 = (arg_251_1.time_ - var_254_21) / var_254_22
				local var_254_24 = Color.New(0, 0, 0)

				var_254_24.a = Mathf.Lerp(1, 0, var_254_23)
				arg_251_1.mask_.color = var_254_24
			end

			if arg_251_1.time_ >= var_254_21 + var_254_22 and arg_251_1.time_ < var_254_21 + var_254_22 + arg_254_0 then
				local var_254_25 = Color.New(0, 0, 0)
				local var_254_26 = 0

				arg_251_1.mask_.enabled = false
				var_254_25.a = var_254_26
				arg_251_1.mask_.color = var_254_25
			end

			local var_254_27 = arg_251_1.actors_["1061ui_story"].transform
			local var_254_28 = 1.66666666666667

			if var_254_28 < arg_251_1.time_ and arg_251_1.time_ <= var_254_28 + arg_254_0 then
				arg_251_1.var_.moveOldPos1061ui_story = var_254_27.localPosition
			end

			local var_254_29 = 0.001

			if var_254_28 <= arg_251_1.time_ and arg_251_1.time_ < var_254_28 + var_254_29 then
				local var_254_30 = (arg_251_1.time_ - var_254_28) / var_254_29
				local var_254_31 = Vector3.New(0, 100, 0)

				var_254_27.localPosition = Vector3.Lerp(arg_251_1.var_.moveOldPos1061ui_story, var_254_31, var_254_30)

				local var_254_32 = manager.ui.mainCamera.transform.position - var_254_27.position

				var_254_27.forward = Vector3.New(var_254_32.x, var_254_32.y, var_254_32.z)

				local var_254_33 = var_254_27.localEulerAngles

				var_254_33.z = 0
				var_254_33.x = 0
				var_254_27.localEulerAngles = var_254_33
			end

			if arg_251_1.time_ >= var_254_28 + var_254_29 and arg_251_1.time_ < var_254_28 + var_254_29 + arg_254_0 then
				var_254_27.localPosition = Vector3.New(0, 100, 0)

				local var_254_34 = manager.ui.mainCamera.transform.position - var_254_27.position

				var_254_27.forward = Vector3.New(var_254_34.x, var_254_34.y, var_254_34.z)

				local var_254_35 = var_254_27.localEulerAngles

				var_254_35.z = 0
				var_254_35.x = 0
				var_254_27.localEulerAngles = var_254_35
			end

			local var_254_36 = arg_251_1.actors_["1077ui_story"].transform
			local var_254_37 = 3.4

			if var_254_37 < arg_251_1.time_ and arg_251_1.time_ <= var_254_37 + arg_254_0 then
				arg_251_1.var_.moveOldPos1077ui_story = var_254_36.localPosition

				local var_254_38 = GameObjectTools.GetOrAddComponent(var_254_36.gameObject, typeof(DynamicBoneHelper))

				if var_254_38 then
					var_254_38:EnableDynamicBone(false)
				end
			end

			local var_254_39 = 0.001

			if var_254_37 <= arg_251_1.time_ and arg_251_1.time_ < var_254_37 + var_254_39 then
				local var_254_40 = (arg_251_1.time_ - var_254_37) / var_254_39
				local var_254_41 = Vector3.New(-0.03, -1.02, -5.92)

				var_254_36.localPosition = Vector3.Lerp(arg_251_1.var_.moveOldPos1077ui_story, var_254_41, var_254_40)

				local var_254_42 = manager.ui.mainCamera.transform.position - var_254_36.position

				var_254_36.forward = Vector3.New(var_254_42.x, var_254_42.y, var_254_42.z)

				local var_254_43 = var_254_36.localEulerAngles

				var_254_43.z = 0
				var_254_43.x = 0
				var_254_36.localEulerAngles = var_254_43
			end

			if arg_251_1.time_ >= var_254_37 + var_254_39 and arg_251_1.time_ < var_254_37 + var_254_39 + arg_254_0 then
				var_254_36.localPosition = Vector3.New(-0.03, -1.02, -5.92)

				local var_254_44 = manager.ui.mainCamera.transform.position - var_254_36.position

				var_254_36.forward = Vector3.New(var_254_44.x, var_254_44.y, var_254_44.z)

				local var_254_45 = var_254_36.localEulerAngles

				var_254_45.z = 0
				var_254_45.x = 0
				var_254_36.localEulerAngles = var_254_45

				local var_254_46 = GameObjectTools.GetOrAddComponent(var_254_36.gameObject, typeof(DynamicBoneHelper))

				if var_254_46 then
					var_254_46:EnableDynamicBone(true)
				end
			end

			local var_254_47 = arg_251_1.actors_["1077ui_story"]
			local var_254_48 = 3.4

			if var_254_48 < arg_251_1.time_ and arg_251_1.time_ <= var_254_48 + arg_254_0 and not isNil(var_254_47) and arg_251_1.var_.characterEffect1077ui_story == nil then
				arg_251_1.var_.characterEffect1077ui_story = var_254_47:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_254_49 = 0.55

			if var_254_48 <= arg_251_1.time_ and arg_251_1.time_ < var_254_48 + var_254_49 and not isNil(var_254_47) then
				local var_254_50 = (arg_251_1.time_ - var_254_48) / var_254_49

				if arg_251_1.var_.characterEffect1077ui_story and not isNil(var_254_47) then
					arg_251_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_251_1.time_ >= var_254_48 + var_254_49 and arg_251_1.time_ < var_254_48 + var_254_49 + arg_254_0 and not isNil(var_254_47) and arg_251_1.var_.characterEffect1077ui_story then
				arg_251_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_254_51 = arg_251_1.actors_["1061ui_story"]
			local var_254_52 = 1.66666666666667

			if var_254_52 < arg_251_1.time_ and arg_251_1.time_ <= var_254_52 + arg_254_0 and not isNil(var_254_51) and arg_251_1.var_.characterEffect1061ui_story == nil then
				arg_251_1.var_.characterEffect1061ui_story = var_254_51:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_254_53 = 0.200000002980232

			if var_254_52 <= arg_251_1.time_ and arg_251_1.time_ < var_254_52 + var_254_53 and not isNil(var_254_51) then
				local var_254_54 = (arg_251_1.time_ - var_254_52) / var_254_53

				if arg_251_1.var_.characterEffect1061ui_story and not isNil(var_254_51) then
					local var_254_55 = Mathf.Lerp(0, 0.5, var_254_54)

					arg_251_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_251_1.var_.characterEffect1061ui_story.fillRatio = var_254_55
				end
			end

			if arg_251_1.time_ >= var_254_52 + var_254_53 and arg_251_1.time_ < var_254_52 + var_254_53 + arg_254_0 and not isNil(var_254_51) and arg_251_1.var_.characterEffect1061ui_story then
				local var_254_56 = 0.5

				arg_251_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_251_1.var_.characterEffect1061ui_story.fillRatio = var_254_56
			end

			local var_254_57 = 1.66666666666667

			arg_251_1.isInRecall_ = false

			if var_254_57 < arg_251_1.time_ and arg_251_1.time_ <= var_254_57 + arg_254_0 then
				arg_251_1.screenFilterGo_:SetActive(false)

				for iter_254_2, iter_254_3 in pairs(arg_251_1.actors_) do
					local var_254_58 = iter_254_3:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_254_4, iter_254_5 in ipairs(var_254_58) do
						if iter_254_5.color.r > 0.51 then
							iter_254_5.color = Color.New(1, 1, 1)
						else
							iter_254_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_254_59 = 0.034000001847744

			if var_254_57 <= arg_251_1.time_ and arg_251_1.time_ < var_254_57 + var_254_59 then
				local var_254_60 = (arg_251_1.time_ - var_254_57) / var_254_59

				arg_251_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, var_254_60)
			end

			if arg_251_1.time_ >= var_254_57 + var_254_59 and arg_251_1.time_ < var_254_57 + var_254_59 + arg_254_0 then
				arg_251_1.screenFilterEffect_.weight = 0
			end

			local var_254_61 = 3.4

			if var_254_61 < arg_251_1.time_ and arg_251_1.time_ <= var_254_61 + arg_254_0 then
				arg_251_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action2_2")
			end

			if arg_251_1.frameCnt_ <= 1 then
				arg_251_1.dialog_:SetActive(false)
			end

			local var_254_62 = 3.399999999999
			local var_254_63 = 0.55

			if var_254_62 < arg_251_1.time_ and arg_251_1.time_ <= var_254_62 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0

				arg_251_1.dialog_:SetActive(true)

				arg_251_1.dialogCg_.alpha = 0

				local var_254_64 = LeanTween.value(arg_251_1.dialog_, 0, 1, 0.3)

				var_254_64:setOnUpdate(LuaHelper.FloatAction(function(arg_255_0)
					arg_251_1.dialogCg_.alpha = arg_255_0
				end))
				var_254_64:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_251_1.dialog_)
					var_254_64:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_251_1.duration_ = arg_251_1.duration_ + 0.3

				SetActive(arg_251_1.leftNameGo_, true)

				local var_254_65 = arg_251_1:FormatText(StoryNameCfg[1467].name)

				arg_251_1.leftNameTxt_.text = var_254_65

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, false)
				arg_251_1.callingController_:SetSelectedState("normal")

				local var_254_66 = arg_251_1:GetWordFromCfg(325102059)
				local var_254_67 = arg_251_1:FormatText(var_254_66.content)

				arg_251_1.text_.text = var_254_67

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_68 = 22
				local var_254_69 = utf8.len(var_254_67)
				local var_254_70 = var_254_68 <= 0 and var_254_63 or var_254_63 * (var_254_69 / var_254_68)

				if var_254_70 > 0 and var_254_63 < var_254_70 then
					arg_251_1.talkMaxDuration = var_254_70
					var_254_62 = var_254_62 + 0.3

					if var_254_70 + var_254_62 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_70 + var_254_62
					end
				end

				arg_251_1.text_.text = var_254_67
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325102", "325102059", "story_v_out_325102.awb") ~= 0 then
					local var_254_71 = manager.audio:GetVoiceLength("story_v_out_325102", "325102059", "story_v_out_325102.awb") / 1000

					if var_254_71 + var_254_62 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_71 + var_254_62
					end

					if var_254_66.prefab_name ~= "" and arg_251_1.actors_[var_254_66.prefab_name] ~= nil then
						local var_254_72 = LuaForUtil.PlayVoiceWithCriLipsync(arg_251_1.actors_[var_254_66.prefab_name].transform, "story_v_out_325102", "325102059", "story_v_out_325102.awb")

						arg_251_1:RecordAudio("325102059", var_254_72)
						arg_251_1:RecordAudio("325102059", var_254_72)
					else
						arg_251_1:AudioAction("play", "voice", "story_v_out_325102", "325102059", "story_v_out_325102.awb")
					end

					arg_251_1:RecordHistoryTalkVoice("story_v_out_325102", "325102059", "story_v_out_325102.awb")
				end

				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_73 = var_254_62 + 0.3
			local var_254_74 = math.max(var_254_63, arg_251_1.talkMaxDuration)

			if var_254_73 <= arg_251_1.time_ and arg_251_1.time_ < var_254_73 + var_254_74 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_73) / var_254_74

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_73 + var_254_74 and arg_251_1.time_ < var_254_73 + var_254_74 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.66666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.4,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_251_1:InitPlayNodeList()
	end,
	Play325102060 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 325102060
		arg_257_1.duration_ = 5

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
		end

		function arg_257_1.playNext_(arg_259_0)
			if arg_259_0 == 1 then
				arg_257_0:Play325102061(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			local var_260_0 = arg_257_1.actors_["1077ui_story"].transform
			local var_260_1 = 0

			if var_260_1 < arg_257_1.time_ and arg_257_1.time_ <= var_260_1 + arg_260_0 then
				arg_257_1.var_.moveOldPos1077ui_story = var_260_0.localPosition

				local var_260_2 = GameObjectTools.GetOrAddComponent(var_260_0.gameObject, typeof(DynamicBoneHelper))

				if var_260_2 then
					var_260_2:EnableDynamicBone(false)
				end
			end

			local var_260_3 = 0.001

			if var_260_1 <= arg_257_1.time_ and arg_257_1.time_ < var_260_1 + var_260_3 then
				local var_260_4 = (arg_257_1.time_ - var_260_1) / var_260_3
				local var_260_5 = Vector3.New(0, 100, 0)

				var_260_0.localPosition = Vector3.Lerp(arg_257_1.var_.moveOldPos1077ui_story, var_260_5, var_260_4)

				local var_260_6 = manager.ui.mainCamera.transform.position - var_260_0.position

				var_260_0.forward = Vector3.New(var_260_6.x, var_260_6.y, var_260_6.z)

				local var_260_7 = var_260_0.localEulerAngles

				var_260_7.z = 0
				var_260_7.x = 0
				var_260_0.localEulerAngles = var_260_7
			end

			if arg_257_1.time_ >= var_260_1 + var_260_3 and arg_257_1.time_ < var_260_1 + var_260_3 + arg_260_0 then
				var_260_0.localPosition = Vector3.New(0, 100, 0)

				local var_260_8 = manager.ui.mainCamera.transform.position - var_260_0.position

				var_260_0.forward = Vector3.New(var_260_8.x, var_260_8.y, var_260_8.z)

				local var_260_9 = var_260_0.localEulerAngles

				var_260_9.z = 0
				var_260_9.x = 0
				var_260_0.localEulerAngles = var_260_9

				local var_260_10 = GameObjectTools.GetOrAddComponent(var_260_0.gameObject, typeof(DynamicBoneHelper))

				if var_260_10 then
					var_260_10:EnableDynamicBone(true)
				end
			end

			local var_260_11 = arg_257_1.actors_["1077ui_story"]
			local var_260_12 = 0

			if var_260_12 < arg_257_1.time_ and arg_257_1.time_ <= var_260_12 + arg_260_0 and not isNil(var_260_11) and arg_257_1.var_.characterEffect1077ui_story == nil then
				arg_257_1.var_.characterEffect1077ui_story = var_260_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_260_13 = 0.200000002980232

			if var_260_12 <= arg_257_1.time_ and arg_257_1.time_ < var_260_12 + var_260_13 and not isNil(var_260_11) then
				local var_260_14 = (arg_257_1.time_ - var_260_12) / var_260_13

				if arg_257_1.var_.characterEffect1077ui_story and not isNil(var_260_11) then
					local var_260_15 = Mathf.Lerp(0, 0.5, var_260_14)

					arg_257_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_257_1.var_.characterEffect1077ui_story.fillRatio = var_260_15
				end
			end

			if arg_257_1.time_ >= var_260_12 + var_260_13 and arg_257_1.time_ < var_260_12 + var_260_13 + arg_260_0 and not isNil(var_260_11) and arg_257_1.var_.characterEffect1077ui_story then
				local var_260_16 = 0.5

				arg_257_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_257_1.var_.characterEffect1077ui_story.fillRatio = var_260_16
			end

			local var_260_17 = 0
			local var_260_18 = 1.375

			if var_260_17 < arg_257_1.time_ and arg_257_1.time_ <= var_260_17 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, false)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_19 = arg_257_1:GetWordFromCfg(325102060)
				local var_260_20 = arg_257_1:FormatText(var_260_19.content)

				arg_257_1.text_.text = var_260_20

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_21 = 55
				local var_260_22 = utf8.len(var_260_20)
				local var_260_23 = var_260_21 <= 0 and var_260_18 or var_260_18 * (var_260_22 / var_260_21)

				if var_260_23 > 0 and var_260_18 < var_260_23 then
					arg_257_1.talkMaxDuration = var_260_23

					if var_260_23 + var_260_17 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_23 + var_260_17
					end
				end

				arg_257_1.text_.text = var_260_20
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)
				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_24 = math.max(var_260_18, arg_257_1.talkMaxDuration)

			if var_260_17 <= arg_257_1.time_ and arg_257_1.time_ < var_260_17 + var_260_24 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_17) / var_260_24

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_17 + var_260_24 and arg_257_1.time_ < var_260_17 + var_260_24 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_257_1:InitPlayNodeList()
	end,
	Play325102061 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 325102061
		arg_261_1.duration_ = 10.73

		local var_261_0 = {
			zh = 8.233,
			ja = 10.733
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
				arg_261_0:Play325102062(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			local var_264_0 = arg_261_1.actors_["1077ui_story"].transform
			local var_264_1 = 0

			if var_264_1 < arg_261_1.time_ and arg_261_1.time_ <= var_264_1 + arg_264_0 then
				arg_261_1.var_.moveOldPos1077ui_story = var_264_0.localPosition

				local var_264_2 = GameObjectTools.GetOrAddComponent(var_264_0.gameObject, typeof(DynamicBoneHelper))

				if var_264_2 then
					var_264_2:EnableDynamicBone(false)
				end
			end

			local var_264_3 = 0.001

			if var_264_1 <= arg_261_1.time_ and arg_261_1.time_ < var_264_1 + var_264_3 then
				local var_264_4 = (arg_261_1.time_ - var_264_1) / var_264_3
				local var_264_5 = Vector3.New(-0.03, -1.02, -5.92)

				var_264_0.localPosition = Vector3.Lerp(arg_261_1.var_.moveOldPos1077ui_story, var_264_5, var_264_4)

				local var_264_6 = manager.ui.mainCamera.transform.position - var_264_0.position

				var_264_0.forward = Vector3.New(var_264_6.x, var_264_6.y, var_264_6.z)

				local var_264_7 = var_264_0.localEulerAngles

				var_264_7.z = 0
				var_264_7.x = 0
				var_264_0.localEulerAngles = var_264_7
			end

			if arg_261_1.time_ >= var_264_1 + var_264_3 and arg_261_1.time_ < var_264_1 + var_264_3 + arg_264_0 then
				var_264_0.localPosition = Vector3.New(-0.03, -1.02, -5.92)

				local var_264_8 = manager.ui.mainCamera.transform.position - var_264_0.position

				var_264_0.forward = Vector3.New(var_264_8.x, var_264_8.y, var_264_8.z)

				local var_264_9 = var_264_0.localEulerAngles

				var_264_9.z = 0
				var_264_9.x = 0
				var_264_0.localEulerAngles = var_264_9

				local var_264_10 = GameObjectTools.GetOrAddComponent(var_264_0.gameObject, typeof(DynamicBoneHelper))

				if var_264_10 then
					var_264_10:EnableDynamicBone(true)
				end
			end

			local var_264_11 = arg_261_1.actors_["1077ui_story"]
			local var_264_12 = 0

			if var_264_12 < arg_261_1.time_ and arg_261_1.time_ <= var_264_12 + arg_264_0 and not isNil(var_264_11) and arg_261_1.var_.characterEffect1077ui_story == nil then
				arg_261_1.var_.characterEffect1077ui_story = var_264_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_264_13 = 0.200000002980232

			if var_264_12 <= arg_261_1.time_ and arg_261_1.time_ < var_264_12 + var_264_13 and not isNil(var_264_11) then
				local var_264_14 = (arg_261_1.time_ - var_264_12) / var_264_13

				if arg_261_1.var_.characterEffect1077ui_story and not isNil(var_264_11) then
					arg_261_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_261_1.time_ >= var_264_12 + var_264_13 and arg_261_1.time_ < var_264_12 + var_264_13 + arg_264_0 and not isNil(var_264_11) and arg_261_1.var_.characterEffect1077ui_story then
				arg_261_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_264_15 = 0

			if var_264_15 < arg_261_1.time_ and arg_261_1.time_ <= var_264_15 + arg_264_0 then
				arg_261_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action1_1")
			end

			local var_264_16 = 0

			if var_264_16 < arg_261_1.time_ and arg_261_1.time_ <= var_264_16 + arg_264_0 then
				arg_261_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_264_17 = 0
			local var_264_18 = 0.95

			if var_264_17 < arg_261_1.time_ and arg_261_1.time_ <= var_264_17 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				local var_264_19 = arg_261_1:FormatText(StoryNameCfg[1467].name)

				arg_261_1.leftNameTxt_.text = var_264_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_20 = arg_261_1:GetWordFromCfg(325102061)
				local var_264_21 = arg_261_1:FormatText(var_264_20.content)

				arg_261_1.text_.text = var_264_21

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_22 = 38
				local var_264_23 = utf8.len(var_264_21)
				local var_264_24 = var_264_22 <= 0 and var_264_18 or var_264_18 * (var_264_23 / var_264_22)

				if var_264_24 > 0 and var_264_18 < var_264_24 then
					arg_261_1.talkMaxDuration = var_264_24

					if var_264_24 + var_264_17 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_24 + var_264_17
					end
				end

				arg_261_1.text_.text = var_264_21
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325102", "325102061", "story_v_out_325102.awb") ~= 0 then
					local var_264_25 = manager.audio:GetVoiceLength("story_v_out_325102", "325102061", "story_v_out_325102.awb") / 1000

					if var_264_25 + var_264_17 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_25 + var_264_17
					end

					if var_264_20.prefab_name ~= "" and arg_261_1.actors_[var_264_20.prefab_name] ~= nil then
						local var_264_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_261_1.actors_[var_264_20.prefab_name].transform, "story_v_out_325102", "325102061", "story_v_out_325102.awb")

						arg_261_1:RecordAudio("325102061", var_264_26)
						arg_261_1:RecordAudio("325102061", var_264_26)
					else
						arg_261_1:AudioAction("play", "voice", "story_v_out_325102", "325102061", "story_v_out_325102.awb")
					end

					arg_261_1:RecordHistoryTalkVoice("story_v_out_325102", "325102061", "story_v_out_325102.awb")
				end

				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_27 = math.max(var_264_18, arg_261_1.talkMaxDuration)

			if var_264_17 <= arg_261_1.time_ and arg_261_1.time_ < var_264_17 + var_264_27 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_17) / var_264_27

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_17 + var_264_27 and arg_261_1.time_ < var_264_17 + var_264_27 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
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
	Play325102062 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 325102062
		arg_265_1.duration_ = 9.57

		local var_265_0 = {
			zh = 4.3,
			ja = 9.566
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
				arg_265_0:Play325102063(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			local var_268_0 = 0
			local var_268_1 = 0.575

			if var_268_0 < arg_265_1.time_ and arg_265_1.time_ <= var_268_0 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				local var_268_2 = arg_265_1:FormatText(StoryNameCfg[1467].name)

				arg_265_1.leftNameTxt_.text = var_268_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_3 = arg_265_1:GetWordFromCfg(325102062)
				local var_268_4 = arg_265_1:FormatText(var_268_3.content)

				arg_265_1.text_.text = var_268_4

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_5 = 23
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

				if manager.audio:GetVoiceLength("story_v_out_325102", "325102062", "story_v_out_325102.awb") ~= 0 then
					local var_268_8 = manager.audio:GetVoiceLength("story_v_out_325102", "325102062", "story_v_out_325102.awb") / 1000

					if var_268_8 + var_268_0 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_8 + var_268_0
					end

					if var_268_3.prefab_name ~= "" and arg_265_1.actors_[var_268_3.prefab_name] ~= nil then
						local var_268_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_265_1.actors_[var_268_3.prefab_name].transform, "story_v_out_325102", "325102062", "story_v_out_325102.awb")

						arg_265_1:RecordAudio("325102062", var_268_9)
						arg_265_1:RecordAudio("325102062", var_268_9)
					else
						arg_265_1:AudioAction("play", "voice", "story_v_out_325102", "325102062", "story_v_out_325102.awb")
					end

					arg_265_1:RecordHistoryTalkVoice("story_v_out_325102", "325102062", "story_v_out_325102.awb")
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
	Play325102063 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 325102063
		arg_269_1.duration_ = 18.23

		local var_269_0 = {
			zh = 11.4333333333333,
			ja = 18.2333333333333
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
				arg_269_0:Play325102064(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			local var_272_0 = 1.43333333333333

			if var_272_0 < arg_269_1.time_ and arg_269_1.time_ <= var_272_0 + arg_272_0 then
				local var_272_1 = manager.ui.mainCamera.transform.localPosition
				local var_272_2 = Vector3.New(0, 0, 10) + Vector3.New(var_272_1.x, var_272_1.y, 0)
				local var_272_3 = arg_269_1.bgs_.J29g

				var_272_3.transform.localPosition = var_272_2
				var_272_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_272_4 = var_272_3:GetComponent("SpriteRenderer")

				if var_272_4 and var_272_4.sprite then
					local var_272_5 = (var_272_3.transform.localPosition - var_272_1).z
					local var_272_6 = manager.ui.mainCameraCom_
					local var_272_7 = 2 * var_272_5 * Mathf.Tan(var_272_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_272_8 = var_272_7 * var_272_6.aspect
					local var_272_9 = var_272_4.sprite.bounds.size.x
					local var_272_10 = var_272_4.sprite.bounds.size.y
					local var_272_11 = var_272_8 / var_272_9
					local var_272_12 = var_272_7 / var_272_10
					local var_272_13 = var_272_12 < var_272_11 and var_272_11 or var_272_12

					var_272_3.transform.localScale = Vector3.New(var_272_13, var_272_13, 0)
				end

				for iter_272_0, iter_272_1 in pairs(arg_269_1.bgs_) do
					if iter_272_0 ~= "J29g" then
						iter_272_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_272_14 = 0

			if var_272_14 < arg_269_1.time_ and arg_269_1.time_ <= var_272_14 + arg_272_0 then
				arg_269_1.allBtn_.enabled = false
			end

			local var_272_15 = 0.3

			if arg_269_1.time_ >= var_272_14 + var_272_15 and arg_269_1.time_ < var_272_14 + var_272_15 + arg_272_0 then
				arg_269_1.allBtn_.enabled = true
			end

			local var_272_16 = arg_269_1.actors_["1077ui_story"].transform
			local var_272_17 = 1.46733333518108

			if var_272_17 < arg_269_1.time_ and arg_269_1.time_ <= var_272_17 + arg_272_0 then
				arg_269_1.var_.moveOldPos1077ui_story = var_272_16.localPosition

				local var_272_18 = GameObjectTools.GetOrAddComponent(var_272_16.gameObject, typeof(DynamicBoneHelper))

				if var_272_18 then
					var_272_18:EnableDynamicBone(false)
				end
			end

			local var_272_19 = 0.001

			if var_272_17 <= arg_269_1.time_ and arg_269_1.time_ < var_272_17 + var_272_19 then
				local var_272_20 = (arg_269_1.time_ - var_272_17) / var_272_19
				local var_272_21 = Vector3.New(0, 100, 0)

				var_272_16.localPosition = Vector3.Lerp(arg_269_1.var_.moveOldPos1077ui_story, var_272_21, var_272_20)

				local var_272_22 = manager.ui.mainCamera.transform.position - var_272_16.position

				var_272_16.forward = Vector3.New(var_272_22.x, var_272_22.y, var_272_22.z)

				local var_272_23 = var_272_16.localEulerAngles

				var_272_23.z = 0
				var_272_23.x = 0
				var_272_16.localEulerAngles = var_272_23
			end

			if arg_269_1.time_ >= var_272_17 + var_272_19 and arg_269_1.time_ < var_272_17 + var_272_19 + arg_272_0 then
				var_272_16.localPosition = Vector3.New(0, 100, 0)

				local var_272_24 = manager.ui.mainCamera.transform.position - var_272_16.position

				var_272_16.forward = Vector3.New(var_272_24.x, var_272_24.y, var_272_24.z)

				local var_272_25 = var_272_16.localEulerAngles

				var_272_25.z = 0
				var_272_25.x = 0
				var_272_16.localEulerAngles = var_272_25

				local var_272_26 = GameObjectTools.GetOrAddComponent(var_272_16.gameObject, typeof(DynamicBoneHelper))

				if var_272_26 then
					var_272_26:EnableDynamicBone(true)
				end
			end

			local var_272_27 = arg_269_1.actors_["1059ui_story"]
			local var_272_28 = 1.46733333518108

			if var_272_28 < arg_269_1.time_ and arg_269_1.time_ <= var_272_28 + arg_272_0 and not isNil(var_272_27) and arg_269_1.var_.characterEffect1059ui_story == nil then
				arg_269_1.var_.characterEffect1059ui_story = var_272_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_272_29 = 0.200000002980232

			if var_272_28 <= arg_269_1.time_ and arg_269_1.time_ < var_272_28 + var_272_29 and not isNil(var_272_27) then
				local var_272_30 = (arg_269_1.time_ - var_272_28) / var_272_29

				if arg_269_1.var_.characterEffect1059ui_story and not isNil(var_272_27) then
					arg_269_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_269_1.time_ >= var_272_28 + var_272_29 and arg_269_1.time_ < var_272_28 + var_272_29 + arg_272_0 and not isNil(var_272_27) and arg_269_1.var_.characterEffect1059ui_story then
				arg_269_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_272_31 = 1.43333333333333

			arg_269_1.isInRecall_ = false

			if var_272_31 < arg_269_1.time_ and arg_269_1.time_ <= var_272_31 + arg_272_0 then
				arg_269_1.screenFilterGo_:SetActive(true)

				arg_269_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile.asset")

				for iter_272_2, iter_272_3 in pairs(arg_269_1.actors_) do
					local var_272_32 = iter_272_3:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_272_4, iter_272_5 in ipairs(var_272_32) do
						if iter_272_5.color.r > 0.51 then
							iter_272_5.color = Color.New(1, 1, 1)
						else
							iter_272_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_272_33 = 0.034000001847744

			if var_272_31 <= arg_269_1.time_ and arg_269_1.time_ < var_272_31 + var_272_33 then
				local var_272_34 = (arg_269_1.time_ - var_272_31) / var_272_33

				arg_269_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, var_272_34)
			end

			if arg_269_1.time_ >= var_272_31 + var_272_33 and arg_269_1.time_ < var_272_31 + var_272_33 + arg_272_0 then
				arg_269_1.screenFilterEffect_.weight = 1
			end

			local var_272_35 = 0

			if var_272_35 < arg_269_1.time_ and arg_269_1.time_ <= var_272_35 + arg_272_0 then
				arg_269_1.mask_.enabled = true
				arg_269_1.mask_.raycastTarget = true

				arg_269_1:SetGaussion(false)
			end

			local var_272_36 = 1.43333333333333

			if var_272_35 <= arg_269_1.time_ and arg_269_1.time_ < var_272_35 + var_272_36 then
				local var_272_37 = (arg_269_1.time_ - var_272_35) / var_272_36
				local var_272_38 = Color.New(0, 0, 0)

				var_272_38.a = Mathf.Lerp(0, 1, var_272_37)
				arg_269_1.mask_.color = var_272_38
			end

			if arg_269_1.time_ >= var_272_35 + var_272_36 and arg_269_1.time_ < var_272_35 + var_272_36 + arg_272_0 then
				local var_272_39 = Color.New(0, 0, 0)

				var_272_39.a = 1
				arg_269_1.mask_.color = var_272_39
			end

			local var_272_40 = 1.43333333333333

			if var_272_40 < arg_269_1.time_ and arg_269_1.time_ <= var_272_40 + arg_272_0 then
				arg_269_1.mask_.enabled = true
				arg_269_1.mask_.raycastTarget = true

				arg_269_1:SetGaussion(false)
			end

			local var_272_41 = 1.4

			if var_272_40 <= arg_269_1.time_ and arg_269_1.time_ < var_272_40 + var_272_41 then
				local var_272_42 = (arg_269_1.time_ - var_272_40) / var_272_41
				local var_272_43 = Color.New(0, 0, 0)

				var_272_43.a = Mathf.Lerp(1, 0, var_272_42)
				arg_269_1.mask_.color = var_272_43
			end

			if arg_269_1.time_ >= var_272_40 + var_272_41 and arg_269_1.time_ < var_272_40 + var_272_41 + arg_272_0 then
				local var_272_44 = Color.New(0, 0, 0)
				local var_272_45 = 0

				arg_269_1.mask_.enabled = false
				var_272_44.a = var_272_45
				arg_269_1.mask_.color = var_272_44
			end

			if arg_269_1.frameCnt_ <= 1 then
				arg_269_1.dialog_:SetActive(false)
			end

			local var_272_46 = 2.73333333333333
			local var_272_47 = 1.175

			if var_272_46 < arg_269_1.time_ and arg_269_1.time_ <= var_272_46 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0

				arg_269_1.dialog_:SetActive(true)

				arg_269_1.dialogCg_.alpha = 0

				local var_272_48 = LeanTween.value(arg_269_1.dialog_, 0, 1, 0.3)

				var_272_48:setOnUpdate(LuaHelper.FloatAction(function(arg_273_0)
					arg_269_1.dialogCg_.alpha = arg_273_0
				end))
				var_272_48:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_269_1.dialog_)
					var_272_48:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_269_1.duration_ = arg_269_1.duration_ + 0.3

				SetActive(arg_269_1.leftNameGo_, true)

				local var_272_49 = arg_269_1:FormatText(StoryNameCfg[1455].name)

				arg_269_1.leftNameTxt_.text = var_272_49

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, true)
				arg_269_1.iconController_:SetSelectedState("hero")

				arg_269_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_269_1.callingController_:SetSelectedState("normal")

				arg_269_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_269_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_272_50 = arg_269_1:GetWordFromCfg(325102063)
				local var_272_51 = arg_269_1:FormatText(var_272_50.content)

				arg_269_1.text_.text = var_272_51

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_52 = 47
				local var_272_53 = utf8.len(var_272_51)
				local var_272_54 = var_272_52 <= 0 and var_272_47 or var_272_47 * (var_272_53 / var_272_52)

				if var_272_54 > 0 and var_272_47 < var_272_54 then
					arg_269_1.talkMaxDuration = var_272_54
					var_272_46 = var_272_46 + 0.3

					if var_272_54 + var_272_46 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_54 + var_272_46
					end
				end

				arg_269_1.text_.text = var_272_51
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325102", "325102063", "story_v_out_325102.awb") ~= 0 then
					local var_272_55 = manager.audio:GetVoiceLength("story_v_out_325102", "325102063", "story_v_out_325102.awb") / 1000

					if var_272_55 + var_272_46 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_55 + var_272_46
					end

					if var_272_50.prefab_name ~= "" and arg_269_1.actors_[var_272_50.prefab_name] ~= nil then
						local var_272_56 = LuaForUtil.PlayVoiceWithCriLipsync(arg_269_1.actors_[var_272_50.prefab_name].transform, "story_v_out_325102", "325102063", "story_v_out_325102.awb")

						arg_269_1:RecordAudio("325102063", var_272_56)
						arg_269_1:RecordAudio("325102063", var_272_56)
					else
						arg_269_1:AudioAction("play", "voice", "story_v_out_325102", "325102063", "story_v_out_325102.awb")
					end

					arg_269_1:RecordHistoryTalkVoice("story_v_out_325102", "325102063", "story_v_out_325102.awb")
				end

				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_57 = var_272_46 + 0.3
			local var_272_58 = math.max(var_272_47, arg_269_1.talkMaxDuration)

			if var_272_57 <= arg_269_1.time_ and arg_269_1.time_ < var_272_57 + var_272_58 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_57) / var_272_58

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_57 + var_272_58 and arg_269_1.time_ < var_272_57 + var_272_58 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.46733333518108,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_269_1:InitPlayNodeList()
	end,
	Play325102064 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 325102064
		arg_275_1.duration_ = 16.27

		local var_275_0 = {
			zh = 9.76599999815225,
			ja = 16.2659999981523
		}
		local var_275_1 = manager.audio:GetLocalizationFlag()

		if var_275_0[var_275_1] ~= nil then
			arg_275_1.duration_ = var_275_0[var_275_1]
		end

		SetActive(arg_275_1.tipsGo_, false)

		function arg_275_1.onSingleLineFinish_()
			arg_275_1.onSingleLineUpdate_ = nil
			arg_275_1.onSingleLineFinish_ = nil
			arg_275_1.state_ = "waiting"
		end

		function arg_275_1.playNext_(arg_277_0)
			if arg_277_0 == 1 then
				arg_275_0:Play325102065(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			local var_278_0 = 0.9

			if var_278_0 < arg_275_1.time_ and arg_275_1.time_ <= var_278_0 + arg_278_0 then
				local var_278_1 = manager.ui.mainCamera.transform.localPosition
				local var_278_2 = Vector3.New(0, 0, 10) + Vector3.New(var_278_1.x, var_278_1.y, 0)
				local var_278_3 = arg_275_1.bgs_.J22f

				var_278_3.transform.localPosition = var_278_2
				var_278_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_278_4 = var_278_3:GetComponent("SpriteRenderer")

				if var_278_4 and var_278_4.sprite then
					local var_278_5 = (var_278_3.transform.localPosition - var_278_1).z
					local var_278_6 = manager.ui.mainCameraCom_
					local var_278_7 = 2 * var_278_5 * Mathf.Tan(var_278_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_278_8 = var_278_7 * var_278_6.aspect
					local var_278_9 = var_278_4.sprite.bounds.size.x
					local var_278_10 = var_278_4.sprite.bounds.size.y
					local var_278_11 = var_278_8 / var_278_9
					local var_278_12 = var_278_7 / var_278_10
					local var_278_13 = var_278_12 < var_278_11 and var_278_11 or var_278_12

					var_278_3.transform.localScale = Vector3.New(var_278_13, var_278_13, 0)
				end

				for iter_278_0, iter_278_1 in pairs(arg_275_1.bgs_) do
					if iter_278_0 ~= "J22f" then
						iter_278_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_278_14 = arg_275_1.actors_["1077ui_story"]
			local var_278_15 = 2.36599999815226

			if var_278_15 < arg_275_1.time_ and arg_275_1.time_ <= var_278_15 + arg_278_0 and not isNil(var_278_14) and arg_275_1.var_.characterEffect1077ui_story == nil then
				arg_275_1.var_.characterEffect1077ui_story = var_278_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_278_16 = 0.300666668514411

			if var_278_15 <= arg_275_1.time_ and arg_275_1.time_ < var_278_15 + var_278_16 and not isNil(var_278_14) then
				local var_278_17 = (arg_275_1.time_ - var_278_15) / var_278_16

				if arg_275_1.var_.characterEffect1077ui_story and not isNil(var_278_14) then
					arg_275_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_275_1.time_ >= var_278_15 + var_278_16 and arg_275_1.time_ < var_278_15 + var_278_16 + arg_278_0 and not isNil(var_278_14) and arg_275_1.var_.characterEffect1077ui_story then
				arg_275_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_278_18 = 2.36599999815226

			if var_278_18 < arg_275_1.time_ and arg_275_1.time_ <= var_278_18 + arg_278_0 then
				arg_275_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_278_19 = 0

			if var_278_19 < arg_275_1.time_ and arg_275_1.time_ <= var_278_19 + arg_278_0 then
				arg_275_1.mask_.enabled = true
				arg_275_1.mask_.raycastTarget = true

				arg_275_1:SetGaussion(false)
			end

			local var_278_20 = 0.899999999999999

			if var_278_19 <= arg_275_1.time_ and arg_275_1.time_ < var_278_19 + var_278_20 then
				local var_278_21 = (arg_275_1.time_ - var_278_19) / var_278_20
				local var_278_22 = Color.New(0, 0, 0)

				var_278_22.a = Mathf.Lerp(0, 1, var_278_21)
				arg_275_1.mask_.color = var_278_22
			end

			if arg_275_1.time_ >= var_278_19 + var_278_20 and arg_275_1.time_ < var_278_19 + var_278_20 + arg_278_0 then
				local var_278_23 = Color.New(0, 0, 0)

				var_278_23.a = 1
				arg_275_1.mask_.color = var_278_23
			end

			local var_278_24 = 0.899999999999999

			if var_278_24 < arg_275_1.time_ and arg_275_1.time_ <= var_278_24 + arg_278_0 then
				arg_275_1.mask_.enabled = true
				arg_275_1.mask_.raycastTarget = true

				arg_275_1:SetGaussion(false)
			end

			local var_278_25 = 1.53333333333333

			if var_278_24 <= arg_275_1.time_ and arg_275_1.time_ < var_278_24 + var_278_25 then
				local var_278_26 = (arg_275_1.time_ - var_278_24) / var_278_25
				local var_278_27 = Color.New(0, 0, 0)

				var_278_27.a = Mathf.Lerp(1, 0, var_278_26)
				arg_275_1.mask_.color = var_278_27
			end

			if arg_275_1.time_ >= var_278_24 + var_278_25 and arg_275_1.time_ < var_278_24 + var_278_25 + arg_278_0 then
				local var_278_28 = Color.New(0, 0, 0)
				local var_278_29 = 0

				arg_275_1.mask_.enabled = false
				var_278_28.a = var_278_29
				arg_275_1.mask_.color = var_278_28
			end

			local var_278_30 = arg_275_1.actors_["1077ui_story"].transform
			local var_278_31 = 2.36599999815226

			if var_278_31 < arg_275_1.time_ and arg_275_1.time_ <= var_278_31 + arg_278_0 then
				arg_275_1.var_.moveOldPos1077ui_story = var_278_30.localPosition

				local var_278_32 = GameObjectTools.GetOrAddComponent(var_278_30.gameObject, typeof(DynamicBoneHelper))

				if var_278_32 then
					var_278_32:EnableDynamicBone(false)
				end
			end

			local var_278_33 = 0.001

			if var_278_31 <= arg_275_1.time_ and arg_275_1.time_ < var_278_31 + var_278_33 then
				local var_278_34 = (arg_275_1.time_ - var_278_31) / var_278_33
				local var_278_35 = Vector3.New(-0.03, -1.02, -5.92)

				var_278_30.localPosition = Vector3.Lerp(arg_275_1.var_.moveOldPos1077ui_story, var_278_35, var_278_34)

				local var_278_36 = manager.ui.mainCamera.transform.position - var_278_30.position

				var_278_30.forward = Vector3.New(var_278_36.x, var_278_36.y, var_278_36.z)

				local var_278_37 = var_278_30.localEulerAngles

				var_278_37.z = 0
				var_278_37.x = 0
				var_278_30.localEulerAngles = var_278_37
			end

			if arg_275_1.time_ >= var_278_31 + var_278_33 and arg_275_1.time_ < var_278_31 + var_278_33 + arg_278_0 then
				var_278_30.localPosition = Vector3.New(-0.03, -1.02, -5.92)

				local var_278_38 = manager.ui.mainCamera.transform.position - var_278_30.position

				var_278_30.forward = Vector3.New(var_278_38.x, var_278_38.y, var_278_38.z)

				local var_278_39 = var_278_30.localEulerAngles

				var_278_39.z = 0
				var_278_39.x = 0
				var_278_30.localEulerAngles = var_278_39

				local var_278_40 = GameObjectTools.GetOrAddComponent(var_278_30.gameObject, typeof(DynamicBoneHelper))

				if var_278_40 then
					var_278_40:EnableDynamicBone(true)
				end
			end

			local var_278_41 = arg_275_1.actors_["1077ui_story"]
			local var_278_42 = 2.36599999815226

			if var_278_42 < arg_275_1.time_ and arg_275_1.time_ <= var_278_42 + arg_278_0 and not isNil(var_278_41) and arg_275_1.var_.characterEffect1077ui_story == nil then
				arg_275_1.var_.characterEffect1077ui_story = var_278_41:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_278_43 = 0.55

			if var_278_42 <= arg_275_1.time_ and arg_275_1.time_ < var_278_42 + var_278_43 and not isNil(var_278_41) then
				local var_278_44 = (arg_275_1.time_ - var_278_42) / var_278_43

				if arg_275_1.var_.characterEffect1077ui_story and not isNil(var_278_41) then
					arg_275_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_275_1.time_ >= var_278_42 + var_278_43 and arg_275_1.time_ < var_278_42 + var_278_43 + arg_278_0 and not isNil(var_278_41) and arg_275_1.var_.characterEffect1077ui_story then
				arg_275_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_278_45 = 0.9

			arg_275_1.isInRecall_ = false

			if var_278_45 < arg_275_1.time_ and arg_275_1.time_ <= var_278_45 + arg_278_0 then
				arg_275_1.screenFilterGo_:SetActive(false)

				for iter_278_2, iter_278_3 in pairs(arg_275_1.actors_) do
					local var_278_46 = iter_278_3:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_278_4, iter_278_5 in ipairs(var_278_46) do
						if iter_278_5.color.r > 0.51 then
							iter_278_5.color = Color.New(1, 1, 1)
						else
							iter_278_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_278_47 = 0.034000001847744

			if var_278_45 <= arg_275_1.time_ and arg_275_1.time_ < var_278_45 + var_278_47 then
				local var_278_48 = (arg_275_1.time_ - var_278_45) / var_278_47

				arg_275_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, var_278_48)
			end

			if arg_275_1.time_ >= var_278_45 + var_278_47 and arg_275_1.time_ < var_278_45 + var_278_47 + arg_278_0 then
				arg_275_1.screenFilterEffect_.weight = 0
			end

			local var_278_49 = 2.36599999815226

			if var_278_49 < arg_275_1.time_ and arg_275_1.time_ <= var_278_49 + arg_278_0 then
				arg_275_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action1_1")
			end

			local var_278_50 = 0.9

			if var_278_50 < arg_275_1.time_ and arg_275_1.time_ <= var_278_50 + arg_278_0 then
				local var_278_51 = manager.ui.mainCamera.transform.localPosition
				local var_278_52 = Vector3.New(0, 0, 10) + Vector3.New(var_278_51.x, var_278_51.y, 0)
				local var_278_53 = arg_275_1.bgs_.J22f

				var_278_53.transform.localPosition = var_278_52
				var_278_53.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_278_54 = var_278_53:GetComponent("SpriteRenderer")

				if var_278_54 and var_278_54.sprite then
					local var_278_55 = (var_278_53.transform.localPosition - var_278_51).z
					local var_278_56 = manager.ui.mainCameraCom_
					local var_278_57 = 2 * var_278_55 * Mathf.Tan(var_278_56.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_278_58 = var_278_57 * var_278_56.aspect
					local var_278_59 = var_278_54.sprite.bounds.size.x
					local var_278_60 = var_278_54.sprite.bounds.size.y
					local var_278_61 = var_278_58 / var_278_59
					local var_278_62 = var_278_57 / var_278_60
					local var_278_63 = var_278_62 < var_278_61 and var_278_61 or var_278_62

					var_278_53.transform.localScale = Vector3.New(var_278_63, var_278_63, 0)
				end

				for iter_278_6, iter_278_7 in pairs(arg_275_1.bgs_) do
					if iter_278_6 ~= "J22f" then
						iter_278_7.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if arg_275_1.frameCnt_ <= 1 then
				arg_275_1.dialog_:SetActive(false)
			end

			local var_278_64 = 2.46599999815226
			local var_278_65 = 0.85

			if var_278_64 < arg_275_1.time_ and arg_275_1.time_ <= var_278_64 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0

				arg_275_1.dialog_:SetActive(true)

				arg_275_1.dialogCg_.alpha = 0

				local var_278_66 = LeanTween.value(arg_275_1.dialog_, 0, 1, 0.3)

				var_278_66:setOnUpdate(LuaHelper.FloatAction(function(arg_279_0)
					arg_275_1.dialogCg_.alpha = arg_279_0
				end))
				var_278_66:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_275_1.dialog_)
					var_278_66:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_275_1.duration_ = arg_275_1.duration_ + 0.3

				SetActive(arg_275_1.leftNameGo_, true)

				local var_278_67 = arg_275_1:FormatText(StoryNameCfg[1467].name)

				arg_275_1.leftNameTxt_.text = var_278_67

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_275_1.leftNameTxt_.transform)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1.leftNameTxt_.text)
				SetActive(arg_275_1.iconTrs_.gameObject, false)
				arg_275_1.callingController_:SetSelectedState("normal")

				local var_278_68 = arg_275_1:GetWordFromCfg(325102064)
				local var_278_69 = arg_275_1:FormatText(var_278_68.content)

				arg_275_1.text_.text = var_278_69

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_70 = 34
				local var_278_71 = utf8.len(var_278_69)
				local var_278_72 = var_278_70 <= 0 and var_278_65 or var_278_65 * (var_278_71 / var_278_70)

				if var_278_72 > 0 and var_278_65 < var_278_72 then
					arg_275_1.talkMaxDuration = var_278_72
					var_278_64 = var_278_64 + 0.3

					if var_278_72 + var_278_64 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_72 + var_278_64
					end
				end

				arg_275_1.text_.text = var_278_69
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325102", "325102064", "story_v_out_325102.awb") ~= 0 then
					local var_278_73 = manager.audio:GetVoiceLength("story_v_out_325102", "325102064", "story_v_out_325102.awb") / 1000

					if var_278_73 + var_278_64 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_73 + var_278_64
					end

					if var_278_68.prefab_name ~= "" and arg_275_1.actors_[var_278_68.prefab_name] ~= nil then
						local var_278_74 = LuaForUtil.PlayVoiceWithCriLipsync(arg_275_1.actors_[var_278_68.prefab_name].transform, "story_v_out_325102", "325102064", "story_v_out_325102.awb")

						arg_275_1:RecordAudio("325102064", var_278_74)
						arg_275_1:RecordAudio("325102064", var_278_74)
					else
						arg_275_1:AudioAction("play", "voice", "story_v_out_325102", "325102064", "story_v_out_325102.awb")
					end

					arg_275_1:RecordHistoryTalkVoice("story_v_out_325102", "325102064", "story_v_out_325102.awb")
				end

				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_75 = var_278_64 + 0.3
			local var_278_76 = math.max(var_278_65, arg_275_1.talkMaxDuration)

			if var_278_75 <= arg_275_1.time_ and arg_275_1.time_ < var_278_75 + var_278_76 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - var_278_75) / var_278_76

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= var_278_75 + var_278_76 and arg_275_1.time_ < var_278_75 + var_278_76 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2.36599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_275_1:InitPlayNodeList()
	end,
	Play325102065 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 325102065
		arg_281_1.duration_ = 4.93

		local var_281_0 = {
			zh = 4.133,
			ja = 4.933
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
				arg_281_0:Play325102066(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			local var_284_0 = 0

			if var_284_0 < arg_281_1.time_ and arg_281_1.time_ <= var_284_0 + arg_284_0 then
				arg_281_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action3_1")
			end

			local var_284_1 = 0

			if var_284_1 < arg_281_1.time_ and arg_281_1.time_ <= var_284_1 + arg_284_0 then
				arg_281_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_284_2 = 0
			local var_284_3 = 0.525

			if var_284_2 < arg_281_1.time_ and arg_281_1.time_ <= var_284_2 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				local var_284_4 = arg_281_1:FormatText(StoryNameCfg[1467].name)

				arg_281_1.leftNameTxt_.text = var_284_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_5 = arg_281_1:GetWordFromCfg(325102065)
				local var_284_6 = arg_281_1:FormatText(var_284_5.content)

				arg_281_1.text_.text = var_284_6

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_7 = 21
				local var_284_8 = utf8.len(var_284_6)
				local var_284_9 = var_284_7 <= 0 and var_284_3 or var_284_3 * (var_284_8 / var_284_7)

				if var_284_9 > 0 and var_284_3 < var_284_9 then
					arg_281_1.talkMaxDuration = var_284_9

					if var_284_9 + var_284_2 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_9 + var_284_2
					end
				end

				arg_281_1.text_.text = var_284_6
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325102", "325102065", "story_v_out_325102.awb") ~= 0 then
					local var_284_10 = manager.audio:GetVoiceLength("story_v_out_325102", "325102065", "story_v_out_325102.awb") / 1000

					if var_284_10 + var_284_2 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_10 + var_284_2
					end

					if var_284_5.prefab_name ~= "" and arg_281_1.actors_[var_284_5.prefab_name] ~= nil then
						local var_284_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_281_1.actors_[var_284_5.prefab_name].transform, "story_v_out_325102", "325102065", "story_v_out_325102.awb")

						arg_281_1:RecordAudio("325102065", var_284_11)
						arg_281_1:RecordAudio("325102065", var_284_11)
					else
						arg_281_1:AudioAction("play", "voice", "story_v_out_325102", "325102065", "story_v_out_325102.awb")
					end

					arg_281_1:RecordHistoryTalkVoice("story_v_out_325102", "325102065", "story_v_out_325102.awb")
				end

				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_12 = math.max(var_284_3, arg_281_1.talkMaxDuration)

			if var_284_2 <= arg_281_1.time_ and arg_281_1.time_ < var_284_2 + var_284_12 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_2) / var_284_12

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_2 + var_284_12 and arg_281_1.time_ < var_284_2 + var_284_12 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {}

		arg_281_1:InitPlayNodeList()
	end,
	Play325102066 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 325102066
		arg_285_1.duration_ = 10.6

		local var_285_0 = {
			zh = 7.633,
			ja = 10.6
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
				arg_285_0:Play325102067(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			local var_288_0 = 0
			local var_288_1 = 0.925

			if var_288_0 < arg_285_1.time_ and arg_285_1.time_ <= var_288_0 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				local var_288_2 = arg_285_1:FormatText(StoryNameCfg[1467].name)

				arg_285_1.leftNameTxt_.text = var_288_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, false)
				arg_285_1.callingController_:SetSelectedState("normal")

				local var_288_3 = arg_285_1:GetWordFromCfg(325102066)
				local var_288_4 = arg_285_1:FormatText(var_288_3.content)

				arg_285_1.text_.text = var_288_4

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_5 = 37
				local var_288_6 = utf8.len(var_288_4)
				local var_288_7 = var_288_5 <= 0 and var_288_1 or var_288_1 * (var_288_6 / var_288_5)

				if var_288_7 > 0 and var_288_1 < var_288_7 then
					arg_285_1.talkMaxDuration = var_288_7

					if var_288_7 + var_288_0 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_7 + var_288_0
					end
				end

				arg_285_1.text_.text = var_288_4
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325102", "325102066", "story_v_out_325102.awb") ~= 0 then
					local var_288_8 = manager.audio:GetVoiceLength("story_v_out_325102", "325102066", "story_v_out_325102.awb") / 1000

					if var_288_8 + var_288_0 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_8 + var_288_0
					end

					if var_288_3.prefab_name ~= "" and arg_285_1.actors_[var_288_3.prefab_name] ~= nil then
						local var_288_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_285_1.actors_[var_288_3.prefab_name].transform, "story_v_out_325102", "325102066", "story_v_out_325102.awb")

						arg_285_1:RecordAudio("325102066", var_288_9)
						arg_285_1:RecordAudio("325102066", var_288_9)
					else
						arg_285_1:AudioAction("play", "voice", "story_v_out_325102", "325102066", "story_v_out_325102.awb")
					end

					arg_285_1:RecordHistoryTalkVoice("story_v_out_325102", "325102066", "story_v_out_325102.awb")
				end

				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_10 = math.max(var_288_1, arg_285_1.talkMaxDuration)

			if var_288_0 <= arg_285_1.time_ and arg_285_1.time_ < var_288_0 + var_288_10 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_0) / var_288_10

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_0 + var_288_10 and arg_285_1.time_ < var_288_0 + var_288_10 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {}

		arg_285_1:InitPlayNodeList()
	end,
	Play325102067 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 325102067
		arg_289_1.duration_ = 14.29

		local var_289_0 = {
			zh = 7.79133333333333,
			ja = 14.2913333333333
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
				arg_289_0:Play325102068(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			local var_292_0 = 1.43333333333333

			if var_292_0 < arg_289_1.time_ and arg_289_1.time_ <= var_292_0 + arg_292_0 then
				local var_292_1 = manager.ui.mainCamera.transform.localPosition
				local var_292_2 = Vector3.New(0, 0, 10) + Vector3.New(var_292_1.x, var_292_1.y, 0)
				local var_292_3 = arg_289_1.bgs_.J29g

				var_292_3.transform.localPosition = var_292_2
				var_292_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_292_4 = var_292_3:GetComponent("SpriteRenderer")

				if var_292_4 and var_292_4.sprite then
					local var_292_5 = (var_292_3.transform.localPosition - var_292_1).z
					local var_292_6 = manager.ui.mainCameraCom_
					local var_292_7 = 2 * var_292_5 * Mathf.Tan(var_292_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_292_8 = var_292_7 * var_292_6.aspect
					local var_292_9 = var_292_4.sprite.bounds.size.x
					local var_292_10 = var_292_4.sprite.bounds.size.y
					local var_292_11 = var_292_8 / var_292_9
					local var_292_12 = var_292_7 / var_292_10
					local var_292_13 = var_292_12 < var_292_11 and var_292_11 or var_292_12

					var_292_3.transform.localScale = Vector3.New(var_292_13, var_292_13, 0)
				end

				for iter_292_0, iter_292_1 in pairs(arg_289_1.bgs_) do
					if iter_292_0 ~= "J29g" then
						iter_292_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_292_14 = 1.43333333333333

			arg_289_1.isInRecall_ = false

			if var_292_14 < arg_289_1.time_ and arg_289_1.time_ <= var_292_14 + arg_292_0 then
				arg_289_1.screenFilterGo_:SetActive(true)

				arg_289_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile.asset")

				for iter_292_2, iter_292_3 in pairs(arg_289_1.actors_) do
					local var_292_15 = iter_292_3:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_292_4, iter_292_5 in ipairs(var_292_15) do
						if iter_292_5.color.r > 0.51 then
							iter_292_5.color = Color.New(1, 1, 1)
						else
							iter_292_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_292_16 = 0.034000001847744

			if var_292_14 <= arg_289_1.time_ and arg_289_1.time_ < var_292_14 + var_292_16 then
				local var_292_17 = (arg_289_1.time_ - var_292_14) / var_292_16

				arg_289_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, var_292_17)
			end

			if arg_289_1.time_ >= var_292_14 + var_292_16 and arg_289_1.time_ < var_292_14 + var_292_16 + arg_292_0 then
				arg_289_1.screenFilterEffect_.weight = 1
			end

			local var_292_18 = 0

			if var_292_18 < arg_289_1.time_ and arg_289_1.time_ <= var_292_18 + arg_292_0 then
				arg_289_1.mask_.enabled = true
				arg_289_1.mask_.raycastTarget = true

				arg_289_1:SetGaussion(false)
			end

			local var_292_19 = 1.43333333333333

			if var_292_18 <= arg_289_1.time_ and arg_289_1.time_ < var_292_18 + var_292_19 then
				local var_292_20 = (arg_289_1.time_ - var_292_18) / var_292_19
				local var_292_21 = Color.New(0, 0, 0)

				var_292_21.a = Mathf.Lerp(0, 1, var_292_20)
				arg_289_1.mask_.color = var_292_21
			end

			if arg_289_1.time_ >= var_292_18 + var_292_19 and arg_289_1.time_ < var_292_18 + var_292_19 + arg_292_0 then
				local var_292_22 = Color.New(0, 0, 0)

				var_292_22.a = 1
				arg_289_1.mask_.color = var_292_22
			end

			local var_292_23 = 1.43333333333333

			if var_292_23 < arg_289_1.time_ and arg_289_1.time_ <= var_292_23 + arg_292_0 then
				arg_289_1.mask_.enabled = true
				arg_289_1.mask_.raycastTarget = true

				arg_289_1:SetGaussion(false)
			end

			local var_292_24 = 1.4

			if var_292_23 <= arg_289_1.time_ and arg_289_1.time_ < var_292_23 + var_292_24 then
				local var_292_25 = (arg_289_1.time_ - var_292_23) / var_292_24
				local var_292_26 = Color.New(0, 0, 0)

				var_292_26.a = Mathf.Lerp(1, 0, var_292_25)
				arg_289_1.mask_.color = var_292_26
			end

			if arg_289_1.time_ >= var_292_23 + var_292_24 and arg_289_1.time_ < var_292_23 + var_292_24 + arg_292_0 then
				local var_292_27 = Color.New(0, 0, 0)
				local var_292_28 = 0

				arg_289_1.mask_.enabled = false
				var_292_27.a = var_292_28
				arg_289_1.mask_.color = var_292_27
			end

			local var_292_29 = arg_289_1.actors_["1077ui_story"].transform
			local var_292_30 = 1.43333333333333

			if var_292_30 < arg_289_1.time_ and arg_289_1.time_ <= var_292_30 + arg_292_0 then
				arg_289_1.var_.moveOldPos1077ui_story = var_292_29.localPosition

				local var_292_31 = GameObjectTools.GetOrAddComponent(var_292_29.gameObject, typeof(DynamicBoneHelper))

				if var_292_31 then
					var_292_31:EnableDynamicBone(false)
				end
			end

			local var_292_32 = 0.001

			if var_292_30 <= arg_289_1.time_ and arg_289_1.time_ < var_292_30 + var_292_32 then
				local var_292_33 = (arg_289_1.time_ - var_292_30) / var_292_32
				local var_292_34 = Vector3.New(0, 100, 0)

				var_292_29.localPosition = Vector3.Lerp(arg_289_1.var_.moveOldPos1077ui_story, var_292_34, var_292_33)

				local var_292_35 = manager.ui.mainCamera.transform.position - var_292_29.position

				var_292_29.forward = Vector3.New(var_292_35.x, var_292_35.y, var_292_35.z)

				local var_292_36 = var_292_29.localEulerAngles

				var_292_36.z = 0
				var_292_36.x = 0
				var_292_29.localEulerAngles = var_292_36
			end

			if arg_289_1.time_ >= var_292_30 + var_292_32 and arg_289_1.time_ < var_292_30 + var_292_32 + arg_292_0 then
				var_292_29.localPosition = Vector3.New(0, 100, 0)

				local var_292_37 = manager.ui.mainCamera.transform.position - var_292_29.position

				var_292_29.forward = Vector3.New(var_292_37.x, var_292_37.y, var_292_37.z)

				local var_292_38 = var_292_29.localEulerAngles

				var_292_38.z = 0
				var_292_38.x = 0
				var_292_29.localEulerAngles = var_292_38

				local var_292_39 = GameObjectTools.GetOrAddComponent(var_292_29.gameObject, typeof(DynamicBoneHelper))

				if var_292_39 then
					var_292_39:EnableDynamicBone(true)
				end
			end

			if arg_289_1.frameCnt_ <= 1 then
				arg_289_1.dialog_:SetActive(false)
			end

			local var_292_40 = 2.85833333333333
			local var_292_41 = 0.575

			if var_292_40 < arg_289_1.time_ and arg_289_1.time_ <= var_292_40 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0

				arg_289_1.dialog_:SetActive(true)

				arg_289_1.dialogCg_.alpha = 0

				local var_292_42 = LeanTween.value(arg_289_1.dialog_, 0, 1, 0.3)

				var_292_42:setOnUpdate(LuaHelper.FloatAction(function(arg_293_0)
					arg_289_1.dialogCg_.alpha = arg_293_0
				end))
				var_292_42:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_289_1.dialog_)
					var_292_42:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_289_1.duration_ = arg_289_1.duration_ + 0.3

				SetActive(arg_289_1.leftNameGo_, true)

				local var_292_43 = arg_289_1:FormatText(StoryNameCfg[1455].name)

				arg_289_1.leftNameTxt_.text = var_292_43

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, true)
				arg_289_1.iconController_:SetSelectedState("hero")

				arg_289_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_289_1.callingController_:SetSelectedState("normal")

				arg_289_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_289_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_292_44 = arg_289_1:GetWordFromCfg(325102067)
				local var_292_45 = arg_289_1:FormatText(var_292_44.content)

				arg_289_1.text_.text = var_292_45

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_46 = 23
				local var_292_47 = utf8.len(var_292_45)
				local var_292_48 = var_292_46 <= 0 and var_292_41 or var_292_41 * (var_292_47 / var_292_46)

				if var_292_48 > 0 and var_292_41 < var_292_48 then
					arg_289_1.talkMaxDuration = var_292_48
					var_292_40 = var_292_40 + 0.3

					if var_292_48 + var_292_40 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_48 + var_292_40
					end
				end

				arg_289_1.text_.text = var_292_45
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325102", "325102067", "story_v_out_325102.awb") ~= 0 then
					local var_292_49 = manager.audio:GetVoiceLength("story_v_out_325102", "325102067", "story_v_out_325102.awb") / 1000

					if var_292_49 + var_292_40 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_49 + var_292_40
					end

					if var_292_44.prefab_name ~= "" and arg_289_1.actors_[var_292_44.prefab_name] ~= nil then
						local var_292_50 = LuaForUtil.PlayVoiceWithCriLipsync(arg_289_1.actors_[var_292_44.prefab_name].transform, "story_v_out_325102", "325102067", "story_v_out_325102.awb")

						arg_289_1:RecordAudio("325102067", var_292_50)
						arg_289_1:RecordAudio("325102067", var_292_50)
					else
						arg_289_1:AudioAction("play", "voice", "story_v_out_325102", "325102067", "story_v_out_325102.awb")
					end

					arg_289_1:RecordHistoryTalkVoice("story_v_out_325102", "325102067", "story_v_out_325102.awb")
				end

				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_51 = var_292_40 + 0.3
			local var_292_52 = math.max(var_292_41, arg_289_1.talkMaxDuration)

			if var_292_51 <= arg_289_1.time_ and arg_289_1.time_ < var_292_51 + var_292_52 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - var_292_51) / var_292_52

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= var_292_51 + var_292_52 and arg_289_1.time_ < var_292_51 + var_292_52 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.43333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_289_1:InitPlayNodeList()
	end,
	Play325102068 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 325102068
		arg_295_1.duration_ = 16.17

		local var_295_0 = {
			zh = 8.133,
			ja = 16.166
		}
		local var_295_1 = manager.audio:GetLocalizationFlag()

		if var_295_0[var_295_1] ~= nil then
			arg_295_1.duration_ = var_295_0[var_295_1]
		end

		SetActive(arg_295_1.tipsGo_, false)

		function arg_295_1.onSingleLineFinish_()
			arg_295_1.onSingleLineUpdate_ = nil
			arg_295_1.onSingleLineFinish_ = nil
			arg_295_1.state_ = "waiting"
		end

		function arg_295_1.playNext_(arg_297_0)
			if arg_297_0 == 1 then
				arg_295_0:Play325102069(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			local var_298_0 = 0
			local var_298_1 = 1.05

			if var_298_0 < arg_295_1.time_ and arg_295_1.time_ <= var_298_0 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, true)

				local var_298_2 = arg_295_1:FormatText(StoryNameCfg[1455].name)

				arg_295_1.leftNameTxt_.text = var_298_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_295_1.leftNameTxt_.transform)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1.leftNameTxt_.text)
				SetActive(arg_295_1.iconTrs_.gameObject, true)
				arg_295_1.iconController_:SetSelectedState("hero")

				arg_295_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_295_1.callingController_:SetSelectedState("normal")

				arg_295_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_295_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_298_3 = arg_295_1:GetWordFromCfg(325102068)
				local var_298_4 = arg_295_1:FormatText(var_298_3.content)

				arg_295_1.text_.text = var_298_4

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_5 = 42
				local var_298_6 = utf8.len(var_298_4)
				local var_298_7 = var_298_5 <= 0 and var_298_1 or var_298_1 * (var_298_6 / var_298_5)

				if var_298_7 > 0 and var_298_1 < var_298_7 then
					arg_295_1.talkMaxDuration = var_298_7

					if var_298_7 + var_298_0 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_7 + var_298_0
					end
				end

				arg_295_1.text_.text = var_298_4
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325102", "325102068", "story_v_out_325102.awb") ~= 0 then
					local var_298_8 = manager.audio:GetVoiceLength("story_v_out_325102", "325102068", "story_v_out_325102.awb") / 1000

					if var_298_8 + var_298_0 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_8 + var_298_0
					end

					if var_298_3.prefab_name ~= "" and arg_295_1.actors_[var_298_3.prefab_name] ~= nil then
						local var_298_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_295_1.actors_[var_298_3.prefab_name].transform, "story_v_out_325102", "325102068", "story_v_out_325102.awb")

						arg_295_1:RecordAudio("325102068", var_298_9)
						arg_295_1:RecordAudio("325102068", var_298_9)
					else
						arg_295_1:AudioAction("play", "voice", "story_v_out_325102", "325102068", "story_v_out_325102.awb")
					end

					arg_295_1:RecordHistoryTalkVoice("story_v_out_325102", "325102068", "story_v_out_325102.awb")
				end

				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_10 = math.max(var_298_1, arg_295_1.talkMaxDuration)

			if var_298_0 <= arg_295_1.time_ and arg_295_1.time_ < var_298_0 + var_298_10 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - var_298_0) / var_298_10

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= var_298_0 + var_298_10 and arg_295_1.time_ < var_298_0 + var_298_10 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {}

		arg_295_1:InitPlayNodeList()
	end,
	Play325102069 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 325102069
		arg_299_1.duration_ = 12.73

		local var_299_0 = {
			zh = 11.1996666666667,
			ja = 12.7326666666667
		}
		local var_299_1 = manager.audio:GetLocalizationFlag()

		if var_299_0[var_299_1] ~= nil then
			arg_299_1.duration_ = var_299_0[var_299_1]
		end

		SetActive(arg_299_1.tipsGo_, false)

		function arg_299_1.onSingleLineFinish_()
			arg_299_1.onSingleLineUpdate_ = nil
			arg_299_1.onSingleLineFinish_ = nil
			arg_299_1.state_ = "waiting"
		end

		function arg_299_1.playNext_(arg_301_0)
			if arg_301_0 == 1 then
				arg_299_0:Play325102070(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			local var_302_0 = 1.26666666666667

			if var_302_0 < arg_299_1.time_ and arg_299_1.time_ <= var_302_0 + arg_302_0 then
				local var_302_1 = manager.ui.mainCamera.transform.localPosition
				local var_302_2 = Vector3.New(0, 0, 10) + Vector3.New(var_302_1.x, var_302_1.y, 0)
				local var_302_3 = arg_299_1.bgs_.J22f

				var_302_3.transform.localPosition = var_302_2
				var_302_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_302_4 = var_302_3:GetComponent("SpriteRenderer")

				if var_302_4 and var_302_4.sprite then
					local var_302_5 = (var_302_3.transform.localPosition - var_302_1).z
					local var_302_6 = manager.ui.mainCameraCom_
					local var_302_7 = 2 * var_302_5 * Mathf.Tan(var_302_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_302_8 = var_302_7 * var_302_6.aspect
					local var_302_9 = var_302_4.sprite.bounds.size.x
					local var_302_10 = var_302_4.sprite.bounds.size.y
					local var_302_11 = var_302_8 / var_302_9
					local var_302_12 = var_302_7 / var_302_10
					local var_302_13 = var_302_12 < var_302_11 and var_302_11 or var_302_12

					var_302_3.transform.localScale = Vector3.New(var_302_13, var_302_13, 0)
				end

				for iter_302_0, iter_302_1 in pairs(arg_299_1.bgs_) do
					if iter_302_0 ~= "J22f" then
						iter_302_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_302_14 = arg_299_1.actors_["1077ui_story"]
			local var_302_15 = 3

			if var_302_15 < arg_299_1.time_ and arg_299_1.time_ <= var_302_15 + arg_302_0 and not isNil(var_302_14) and arg_299_1.var_.characterEffect1077ui_story == nil then
				arg_299_1.var_.characterEffect1077ui_story = var_302_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_302_16 = 0.200000002980232

			if var_302_15 <= arg_299_1.time_ and arg_299_1.time_ < var_302_15 + var_302_16 and not isNil(var_302_14) then
				local var_302_17 = (arg_299_1.time_ - var_302_15) / var_302_16

				if arg_299_1.var_.characterEffect1077ui_story and not isNil(var_302_14) then
					arg_299_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_299_1.time_ >= var_302_15 + var_302_16 and arg_299_1.time_ < var_302_15 + var_302_16 + arg_302_0 and not isNil(var_302_14) and arg_299_1.var_.characterEffect1077ui_story then
				arg_299_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_302_18 = 0

			if var_302_18 < arg_299_1.time_ and arg_299_1.time_ <= var_302_18 + arg_302_0 then
				arg_299_1.mask_.enabled = true
				arg_299_1.mask_.raycastTarget = true

				arg_299_1:SetGaussion(false)
			end

			local var_302_19 = 1.26666666666667

			if var_302_18 <= arg_299_1.time_ and arg_299_1.time_ < var_302_18 + var_302_19 then
				local var_302_20 = (arg_299_1.time_ - var_302_18) / var_302_19
				local var_302_21 = Color.New(0, 0, 0)

				var_302_21.a = Mathf.Lerp(0, 1, var_302_20)
				arg_299_1.mask_.color = var_302_21
			end

			if arg_299_1.time_ >= var_302_18 + var_302_19 and arg_299_1.time_ < var_302_18 + var_302_19 + arg_302_0 then
				local var_302_22 = Color.New(0, 0, 0)

				var_302_22.a = 1
				arg_299_1.mask_.color = var_302_22
			end

			local var_302_23 = 1.26666666666667

			if var_302_23 < arg_299_1.time_ and arg_299_1.time_ <= var_302_23 + arg_302_0 then
				arg_299_1.mask_.enabled = true
				arg_299_1.mask_.raycastTarget = true

				arg_299_1:SetGaussion(false)
			end

			local var_302_24 = 2

			if var_302_23 <= arg_299_1.time_ and arg_299_1.time_ < var_302_23 + var_302_24 then
				local var_302_25 = (arg_299_1.time_ - var_302_23) / var_302_24
				local var_302_26 = Color.New(0, 0, 0)

				var_302_26.a = Mathf.Lerp(1, 0, var_302_25)
				arg_299_1.mask_.color = var_302_26
			end

			if arg_299_1.time_ >= var_302_23 + var_302_24 and arg_299_1.time_ < var_302_23 + var_302_24 + arg_302_0 then
				local var_302_27 = Color.New(0, 0, 0)
				local var_302_28 = 0

				arg_299_1.mask_.enabled = false
				var_302_27.a = var_302_28
				arg_299_1.mask_.color = var_302_27
			end

			local var_302_29 = arg_299_1.actors_["1077ui_story"].transform
			local var_302_30 = 2.64279113151133

			if var_302_30 < arg_299_1.time_ and arg_299_1.time_ <= var_302_30 + arg_302_0 then
				arg_299_1.var_.moveOldPos1077ui_story = var_302_29.localPosition

				local var_302_31 = GameObjectTools.GetOrAddComponent(var_302_29.gameObject, typeof(DynamicBoneHelper))

				if var_302_31 then
					var_302_31:EnableDynamicBone(false)
				end
			end

			local var_302_32 = 0.001

			if var_302_30 <= arg_299_1.time_ and arg_299_1.time_ < var_302_30 + var_302_32 then
				local var_302_33 = (arg_299_1.time_ - var_302_30) / var_302_32
				local var_302_34 = Vector3.New(-0.03, -1.02, -5.92)

				var_302_29.localPosition = Vector3.Lerp(arg_299_1.var_.moveOldPos1077ui_story, var_302_34, var_302_33)

				local var_302_35 = manager.ui.mainCamera.transform.position - var_302_29.position

				var_302_29.forward = Vector3.New(var_302_35.x, var_302_35.y, var_302_35.z)

				local var_302_36 = var_302_29.localEulerAngles

				var_302_36.z = 0
				var_302_36.x = 0
				var_302_29.localEulerAngles = var_302_36
			end

			if arg_299_1.time_ >= var_302_30 + var_302_32 and arg_299_1.time_ < var_302_30 + var_302_32 + arg_302_0 then
				var_302_29.localPosition = Vector3.New(-0.03, -1.02, -5.92)

				local var_302_37 = manager.ui.mainCamera.transform.position - var_302_29.position

				var_302_29.forward = Vector3.New(var_302_37.x, var_302_37.y, var_302_37.z)

				local var_302_38 = var_302_29.localEulerAngles

				var_302_38.z = 0
				var_302_38.x = 0
				var_302_29.localEulerAngles = var_302_38

				local var_302_39 = GameObjectTools.GetOrAddComponent(var_302_29.gameObject, typeof(DynamicBoneHelper))

				if var_302_39 then
					var_302_39:EnableDynamicBone(true)
				end
			end

			local var_302_40 = arg_299_1.actors_["1077ui_story"]
			local var_302_41 = 2.64279113151133

			if var_302_41 < arg_299_1.time_ and arg_299_1.time_ <= var_302_41 + arg_302_0 and not isNil(var_302_40) and arg_299_1.var_.characterEffect1077ui_story == nil then
				arg_299_1.var_.characterEffect1077ui_story = var_302_40:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_302_42 = 0.55

			if var_302_41 <= arg_299_1.time_ and arg_299_1.time_ < var_302_41 + var_302_42 and not isNil(var_302_40) then
				local var_302_43 = (arg_299_1.time_ - var_302_41) / var_302_42

				if arg_299_1.var_.characterEffect1077ui_story and not isNil(var_302_40) then
					arg_299_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_299_1.time_ >= var_302_41 + var_302_42 and arg_299_1.time_ < var_302_41 + var_302_42 + arg_302_0 and not isNil(var_302_40) and arg_299_1.var_.characterEffect1077ui_story then
				arg_299_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_302_44 = 1.26666666666667

			arg_299_1.isInRecall_ = false

			if var_302_44 < arg_299_1.time_ and arg_299_1.time_ <= var_302_44 + arg_302_0 then
				arg_299_1.screenFilterGo_:SetActive(false)

				for iter_302_2, iter_302_3 in pairs(arg_299_1.actors_) do
					local var_302_45 = iter_302_3:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_302_4, iter_302_5 in ipairs(var_302_45) do
						if iter_302_5.color.r > 0.51 then
							iter_302_5.color = Color.New(1, 1, 1)
						else
							iter_302_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_302_46 = 0.034000001847744

			if var_302_44 <= arg_299_1.time_ and arg_299_1.time_ < var_302_44 + var_302_46 then
				local var_302_47 = (arg_299_1.time_ - var_302_44) / var_302_46

				arg_299_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, var_302_47)
			end

			if arg_299_1.time_ >= var_302_44 + var_302_46 and arg_299_1.time_ < var_302_44 + var_302_46 + arg_302_0 then
				arg_299_1.screenFilterEffect_.weight = 0
			end

			local var_302_48 = 2.64279113151133

			if var_302_48 < arg_299_1.time_ and arg_299_1.time_ <= var_302_48 + arg_302_0 then
				arg_299_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action3_2")
			end

			local var_302_49 = 1.26666666666667

			if var_302_49 < arg_299_1.time_ and arg_299_1.time_ <= var_302_49 + arg_302_0 then
				local var_302_50 = manager.ui.mainCamera.transform.localPosition
				local var_302_51 = Vector3.New(0, 0, 10) + Vector3.New(var_302_50.x, var_302_50.y, 0)
				local var_302_52 = arg_299_1.bgs_.J22f

				var_302_52.transform.localPosition = var_302_51
				var_302_52.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_302_53 = var_302_52:GetComponent("SpriteRenderer")

				if var_302_53 and var_302_53.sprite then
					local var_302_54 = (var_302_52.transform.localPosition - var_302_50).z
					local var_302_55 = manager.ui.mainCameraCom_
					local var_302_56 = 2 * var_302_54 * Mathf.Tan(var_302_55.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_302_57 = var_302_56 * var_302_55.aspect
					local var_302_58 = var_302_53.sprite.bounds.size.x
					local var_302_59 = var_302_53.sprite.bounds.size.y
					local var_302_60 = var_302_57 / var_302_58
					local var_302_61 = var_302_56 / var_302_59
					local var_302_62 = var_302_61 < var_302_60 and var_302_60 or var_302_61

					var_302_52.transform.localScale = Vector3.New(var_302_62, var_302_62, 0)
				end

				for iter_302_6, iter_302_7 in pairs(arg_299_1.bgs_) do
					if iter_302_6 ~= "J22f" then
						iter_302_7.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if arg_299_1.frameCnt_ <= 1 then
				arg_299_1.dialog_:SetActive(false)
			end

			local var_302_63 = 2.86666666666667
			local var_302_64 = 0.9

			if var_302_63 < arg_299_1.time_ and arg_299_1.time_ <= var_302_63 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0

				arg_299_1.dialog_:SetActive(true)

				arg_299_1.dialogCg_.alpha = 0

				local var_302_65 = LeanTween.value(arg_299_1.dialog_, 0, 1, 0.3)

				var_302_65:setOnUpdate(LuaHelper.FloatAction(function(arg_303_0)
					arg_299_1.dialogCg_.alpha = arg_303_0
				end))
				var_302_65:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_299_1.dialog_)
					var_302_65:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_299_1.duration_ = arg_299_1.duration_ + 0.3

				SetActive(arg_299_1.leftNameGo_, true)

				local var_302_66 = arg_299_1:FormatText(StoryNameCfg[1467].name)

				arg_299_1.leftNameTxt_.text = var_302_66

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_299_1.leftNameTxt_.transform)

				arg_299_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_299_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_299_1:RecordName(arg_299_1.leftNameTxt_.text)
				SetActive(arg_299_1.iconTrs_.gameObject, false)
				arg_299_1.callingController_:SetSelectedState("normal")

				local var_302_67 = arg_299_1:GetWordFromCfg(325102069)
				local var_302_68 = arg_299_1:FormatText(var_302_67.content)

				arg_299_1.text_.text = var_302_68

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_69 = 36
				local var_302_70 = utf8.len(var_302_68)
				local var_302_71 = var_302_69 <= 0 and var_302_64 or var_302_64 * (var_302_70 / var_302_69)

				if var_302_71 > 0 and var_302_64 < var_302_71 then
					arg_299_1.talkMaxDuration = var_302_71
					var_302_63 = var_302_63 + 0.3

					if var_302_71 + var_302_63 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_71 + var_302_63
					end
				end

				arg_299_1.text_.text = var_302_68
				arg_299_1.typewritter.percent = 0

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325102", "325102069", "story_v_out_325102.awb") ~= 0 then
					local var_302_72 = manager.audio:GetVoiceLength("story_v_out_325102", "325102069", "story_v_out_325102.awb") / 1000

					if var_302_72 + var_302_63 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_72 + var_302_63
					end

					if var_302_67.prefab_name ~= "" and arg_299_1.actors_[var_302_67.prefab_name] ~= nil then
						local var_302_73 = LuaForUtil.PlayVoiceWithCriLipsync(arg_299_1.actors_[var_302_67.prefab_name].transform, "story_v_out_325102", "325102069", "story_v_out_325102.awb")

						arg_299_1:RecordAudio("325102069", var_302_73)
						arg_299_1:RecordAudio("325102069", var_302_73)
					else
						arg_299_1:AudioAction("play", "voice", "story_v_out_325102", "325102069", "story_v_out_325102.awb")
					end

					arg_299_1:RecordHistoryTalkVoice("story_v_out_325102", "325102069", "story_v_out_325102.awb")
				end

				arg_299_1:RecordContent(arg_299_1.text_.text)
			end

			local var_302_74 = var_302_63 + 0.3
			local var_302_75 = math.max(var_302_64, arg_299_1.talkMaxDuration)

			if var_302_74 <= arg_299_1.time_ and arg_299_1.time_ < var_302_74 + var_302_75 then
				arg_299_1.typewritter.percent = (arg_299_1.time_ - var_302_74) / var_302_75

				arg_299_1.typewritter:SetDirty()
			end

			if arg_299_1.time_ >= var_302_74 + var_302_75 and arg_299_1.time_ < var_302_74 + var_302_75 + arg_302_0 then
				arg_299_1.typewritter.percent = 1

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(true)
			end
		end

		arg_299_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2.64279113151133,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_299_1:InitPlayNodeList()
	end,
	Play325102070 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 325102070
		arg_305_1.duration_ = 7.73

		local var_305_0 = {
			zh = 6.866,
			ja = 7.733
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
				arg_305_0:Play325102071(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			local var_308_0 = 0
			local var_308_1 = 0.825

			if var_308_0 < arg_305_1.time_ and arg_305_1.time_ <= var_308_0 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, true)

				local var_308_2 = arg_305_1:FormatText(StoryNameCfg[1467].name)

				arg_305_1.leftNameTxt_.text = var_308_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_305_1.leftNameTxt_.transform)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1.leftNameTxt_.text)
				SetActive(arg_305_1.iconTrs_.gameObject, false)
				arg_305_1.callingController_:SetSelectedState("normal")

				local var_308_3 = arg_305_1:GetWordFromCfg(325102070)
				local var_308_4 = arg_305_1:FormatText(var_308_3.content)

				arg_305_1.text_.text = var_308_4

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_5 = 33
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

				if manager.audio:GetVoiceLength("story_v_out_325102", "325102070", "story_v_out_325102.awb") ~= 0 then
					local var_308_8 = manager.audio:GetVoiceLength("story_v_out_325102", "325102070", "story_v_out_325102.awb") / 1000

					if var_308_8 + var_308_0 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_8 + var_308_0
					end

					if var_308_3.prefab_name ~= "" and arg_305_1.actors_[var_308_3.prefab_name] ~= nil then
						local var_308_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_305_1.actors_[var_308_3.prefab_name].transform, "story_v_out_325102", "325102070", "story_v_out_325102.awb")

						arg_305_1:RecordAudio("325102070", var_308_9)
						arg_305_1:RecordAudio("325102070", var_308_9)
					else
						arg_305_1:AudioAction("play", "voice", "story_v_out_325102", "325102070", "story_v_out_325102.awb")
					end

					arg_305_1:RecordHistoryTalkVoice("story_v_out_325102", "325102070", "story_v_out_325102.awb")
				end

				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_10 = math.max(var_308_1, arg_305_1.talkMaxDuration)

			if var_308_0 <= arg_305_1.time_ and arg_305_1.time_ < var_308_0 + var_308_10 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - var_308_0) / var_308_10

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= var_308_0 + var_308_10 and arg_305_1.time_ < var_308_0 + var_308_10 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {}

		arg_305_1:InitPlayNodeList()
	end,
	Play325102071 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 325102071
		arg_309_1.duration_ = 8.83

		local var_309_0 = {
			zh = 4.4,
			ja = 8.833
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
				arg_309_0:Play325102072(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			local var_312_0 = 0
			local var_312_1 = 0.55

			if var_312_0 < arg_309_1.time_ and arg_309_1.time_ <= var_312_0 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, true)

				local var_312_2 = arg_309_1:FormatText(StoryNameCfg[1467].name)

				arg_309_1.leftNameTxt_.text = var_312_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_309_1.leftNameTxt_.transform)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1.leftNameTxt_.text)
				SetActive(arg_309_1.iconTrs_.gameObject, false)
				arg_309_1.callingController_:SetSelectedState("normal")

				local var_312_3 = arg_309_1:GetWordFromCfg(325102071)
				local var_312_4 = arg_309_1:FormatText(var_312_3.content)

				arg_309_1.text_.text = var_312_4

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_5 = 22
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

				if manager.audio:GetVoiceLength("story_v_out_325102", "325102071", "story_v_out_325102.awb") ~= 0 then
					local var_312_8 = manager.audio:GetVoiceLength("story_v_out_325102", "325102071", "story_v_out_325102.awb") / 1000

					if var_312_8 + var_312_0 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_8 + var_312_0
					end

					if var_312_3.prefab_name ~= "" and arg_309_1.actors_[var_312_3.prefab_name] ~= nil then
						local var_312_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_309_1.actors_[var_312_3.prefab_name].transform, "story_v_out_325102", "325102071", "story_v_out_325102.awb")

						arg_309_1:RecordAudio("325102071", var_312_9)
						arg_309_1:RecordAudio("325102071", var_312_9)
					else
						arg_309_1:AudioAction("play", "voice", "story_v_out_325102", "325102071", "story_v_out_325102.awb")
					end

					arg_309_1:RecordHistoryTalkVoice("story_v_out_325102", "325102071", "story_v_out_325102.awb")
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
	Play325102072 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 325102072
		arg_313_1.duration_ = 5

		SetActive(arg_313_1.tipsGo_, false)

		function arg_313_1.onSingleLineFinish_()
			arg_313_1.onSingleLineUpdate_ = nil
			arg_313_1.onSingleLineFinish_ = nil
			arg_313_1.state_ = "waiting"
		end

		function arg_313_1.playNext_(arg_315_0)
			if arg_315_0 == 1 then
				arg_313_0:Play325102073(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			local var_316_0 = arg_313_1.actors_["1059ui_story"].transform
			local var_316_1 = 0

			if var_316_1 < arg_313_1.time_ and arg_313_1.time_ <= var_316_1 + arg_316_0 then
				arg_313_1.var_.moveOldPos1059ui_story = var_316_0.localPosition
			end

			local var_316_2 = 0.001

			if var_316_1 <= arg_313_1.time_ and arg_313_1.time_ < var_316_1 + var_316_2 then
				local var_316_3 = (arg_313_1.time_ - var_316_1) / var_316_2
				local var_316_4 = Vector3.New(0, 100, 0)

				var_316_0.localPosition = Vector3.Lerp(arg_313_1.var_.moveOldPos1059ui_story, var_316_4, var_316_3)

				local var_316_5 = manager.ui.mainCamera.transform.position - var_316_0.position

				var_316_0.forward = Vector3.New(var_316_5.x, var_316_5.y, var_316_5.z)

				local var_316_6 = var_316_0.localEulerAngles

				var_316_6.z = 0
				var_316_6.x = 0
				var_316_0.localEulerAngles = var_316_6
			end

			if arg_313_1.time_ >= var_316_1 + var_316_2 and arg_313_1.time_ < var_316_1 + var_316_2 + arg_316_0 then
				var_316_0.localPosition = Vector3.New(0, 100, 0)

				local var_316_7 = manager.ui.mainCamera.transform.position - var_316_0.position

				var_316_0.forward = Vector3.New(var_316_7.x, var_316_7.y, var_316_7.z)

				local var_316_8 = var_316_0.localEulerAngles

				var_316_8.z = 0
				var_316_8.x = 0
				var_316_0.localEulerAngles = var_316_8
			end

			local var_316_9 = arg_313_1.actors_["1077ui_story"].transform
			local var_316_10 = 0

			if var_316_10 < arg_313_1.time_ and arg_313_1.time_ <= var_316_10 + arg_316_0 then
				arg_313_1.var_.moveOldPos1077ui_story = var_316_9.localPosition

				local var_316_11 = GameObjectTools.GetOrAddComponent(var_316_9.gameObject, typeof(DynamicBoneHelper))

				if var_316_11 then
					var_316_11:EnableDynamicBone(false)
				end
			end

			local var_316_12 = 0.001

			if var_316_10 <= arg_313_1.time_ and arg_313_1.time_ < var_316_10 + var_316_12 then
				local var_316_13 = (arg_313_1.time_ - var_316_10) / var_316_12
				local var_316_14 = Vector3.New(0, 100, 0)

				var_316_9.localPosition = Vector3.Lerp(arg_313_1.var_.moveOldPos1077ui_story, var_316_14, var_316_13)

				local var_316_15 = manager.ui.mainCamera.transform.position - var_316_9.position

				var_316_9.forward = Vector3.New(var_316_15.x, var_316_15.y, var_316_15.z)

				local var_316_16 = var_316_9.localEulerAngles

				var_316_16.z = 0
				var_316_16.x = 0
				var_316_9.localEulerAngles = var_316_16
			end

			if arg_313_1.time_ >= var_316_10 + var_316_12 and arg_313_1.time_ < var_316_10 + var_316_12 + arg_316_0 then
				var_316_9.localPosition = Vector3.New(0, 100, 0)

				local var_316_17 = manager.ui.mainCamera.transform.position - var_316_9.position

				var_316_9.forward = Vector3.New(var_316_17.x, var_316_17.y, var_316_17.z)

				local var_316_18 = var_316_9.localEulerAngles

				var_316_18.z = 0
				var_316_18.x = 0
				var_316_9.localEulerAngles = var_316_18

				local var_316_19 = GameObjectTools.GetOrAddComponent(var_316_9.gameObject, typeof(DynamicBoneHelper))

				if var_316_19 then
					var_316_19:EnableDynamicBone(true)
				end
			end

			local var_316_20 = arg_313_1.actors_["1077ui_story"]
			local var_316_21 = 0

			if var_316_21 < arg_313_1.time_ and arg_313_1.time_ <= var_316_21 + arg_316_0 and not isNil(var_316_20) and arg_313_1.var_.characterEffect1077ui_story == nil then
				arg_313_1.var_.characterEffect1077ui_story = var_316_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_316_22 = 0.200000002980232

			if var_316_21 <= arg_313_1.time_ and arg_313_1.time_ < var_316_21 + var_316_22 and not isNil(var_316_20) then
				local var_316_23 = (arg_313_1.time_ - var_316_21) / var_316_22

				if arg_313_1.var_.characterEffect1077ui_story and not isNil(var_316_20) then
					local var_316_24 = Mathf.Lerp(0, 0.5, var_316_23)

					arg_313_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_313_1.var_.characterEffect1077ui_story.fillRatio = var_316_24
				end
			end

			if arg_313_1.time_ >= var_316_21 + var_316_22 and arg_313_1.time_ < var_316_21 + var_316_22 + arg_316_0 and not isNil(var_316_20) and arg_313_1.var_.characterEffect1077ui_story then
				local var_316_25 = 0.5

				arg_313_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_313_1.var_.characterEffect1077ui_story.fillRatio = var_316_25
			end

			local var_316_26 = 0
			local var_316_27 = 1.3

			if var_316_26 < arg_313_1.time_ and arg_313_1.time_ <= var_316_26 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, false)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_313_1.iconTrs_.gameObject, false)
				arg_313_1.callingController_:SetSelectedState("normal")

				local var_316_28 = arg_313_1:GetWordFromCfg(325102072)
				local var_316_29 = arg_313_1:FormatText(var_316_28.content)

				arg_313_1.text_.text = var_316_29

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_30 = 52
				local var_316_31 = utf8.len(var_316_29)
				local var_316_32 = var_316_30 <= 0 and var_316_27 or var_316_27 * (var_316_31 / var_316_30)

				if var_316_32 > 0 and var_316_27 < var_316_32 then
					arg_313_1.talkMaxDuration = var_316_32

					if var_316_32 + var_316_26 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_32 + var_316_26
					end
				end

				arg_313_1.text_.text = var_316_29
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)
				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_33 = math.max(var_316_27, arg_313_1.talkMaxDuration)

			if var_316_26 <= arg_313_1.time_ and arg_313_1.time_ < var_316_26 + var_316_33 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_26) / var_316_33

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_26 + var_316_33 and arg_313_1.time_ < var_316_26 + var_316_33 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_313_1:InitPlayNodeList()
	end,
	Play325102073 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 325102073
		arg_317_1.duration_ = 5

		SetActive(arg_317_1.tipsGo_, false)

		function arg_317_1.onSingleLineFinish_()
			arg_317_1.onSingleLineUpdate_ = nil
			arg_317_1.onSingleLineFinish_ = nil
			arg_317_1.state_ = "waiting"
		end

		function arg_317_1.playNext_(arg_319_0)
			if arg_319_0 == 1 then
				arg_317_0:Play325102074(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			local var_320_0 = 0
			local var_320_1 = 0.675

			if var_320_0 < arg_317_1.time_ and arg_317_1.time_ <= var_320_0 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, false)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_317_1.iconTrs_.gameObject, false)
				arg_317_1.callingController_:SetSelectedState("normal")

				local var_320_2 = arg_317_1:GetWordFromCfg(325102073)
				local var_320_3 = arg_317_1:FormatText(var_320_2.content)

				arg_317_1.text_.text = var_320_3

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_4 = 27
				local var_320_5 = utf8.len(var_320_3)
				local var_320_6 = var_320_4 <= 0 and var_320_1 or var_320_1 * (var_320_5 / var_320_4)

				if var_320_6 > 0 and var_320_1 < var_320_6 then
					arg_317_1.talkMaxDuration = var_320_6

					if var_320_6 + var_320_0 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_6 + var_320_0
					end
				end

				arg_317_1.text_.text = var_320_3
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)
				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_7 = math.max(var_320_1, arg_317_1.talkMaxDuration)

			if var_320_0 <= arg_317_1.time_ and arg_317_1.time_ < var_320_0 + var_320_7 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - var_320_0) / var_320_7

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= var_320_0 + var_320_7 and arg_317_1.time_ < var_320_0 + var_320_7 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {}

		arg_317_1:InitPlayNodeList()
	end,
	Play325102074 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 325102074
		arg_321_1.duration_ = 5.43

		local var_321_0 = {
			zh = 3.4,
			ja = 5.433
		}
		local var_321_1 = manager.audio:GetLocalizationFlag()

		if var_321_0[var_321_1] ~= nil then
			arg_321_1.duration_ = var_321_0[var_321_1]
		end

		SetActive(arg_321_1.tipsGo_, false)

		function arg_321_1.onSingleLineFinish_()
			arg_321_1.onSingleLineUpdate_ = nil
			arg_321_1.onSingleLineFinish_ = nil
			arg_321_1.state_ = "waiting"
		end

		function arg_321_1.playNext_(arg_323_0)
			if arg_323_0 == 1 then
				arg_321_0:Play325102075(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			local var_324_0 = arg_321_1.actors_["1077ui_story"].transform
			local var_324_1 = 0

			if var_324_1 < arg_321_1.time_ and arg_321_1.time_ <= var_324_1 + arg_324_0 then
				arg_321_1.var_.moveOldPos1077ui_story = var_324_0.localPosition

				local var_324_2 = GameObjectTools.GetOrAddComponent(var_324_0.gameObject, typeof(DynamicBoneHelper))

				if var_324_2 then
					var_324_2:EnableDynamicBone(false)
				end
			end

			local var_324_3 = 0.001

			if var_324_1 <= arg_321_1.time_ and arg_321_1.time_ < var_324_1 + var_324_3 then
				local var_324_4 = (arg_321_1.time_ - var_324_1) / var_324_3
				local var_324_5 = Vector3.New(-0.03, -1.02, -5.92)

				var_324_0.localPosition = Vector3.Lerp(arg_321_1.var_.moveOldPos1077ui_story, var_324_5, var_324_4)

				local var_324_6 = manager.ui.mainCamera.transform.position - var_324_0.position

				var_324_0.forward = Vector3.New(var_324_6.x, var_324_6.y, var_324_6.z)

				local var_324_7 = var_324_0.localEulerAngles

				var_324_7.z = 0
				var_324_7.x = 0
				var_324_0.localEulerAngles = var_324_7
			end

			if arg_321_1.time_ >= var_324_1 + var_324_3 and arg_321_1.time_ < var_324_1 + var_324_3 + arg_324_0 then
				var_324_0.localPosition = Vector3.New(-0.03, -1.02, -5.92)

				local var_324_8 = manager.ui.mainCamera.transform.position - var_324_0.position

				var_324_0.forward = Vector3.New(var_324_8.x, var_324_8.y, var_324_8.z)

				local var_324_9 = var_324_0.localEulerAngles

				var_324_9.z = 0
				var_324_9.x = 0
				var_324_0.localEulerAngles = var_324_9

				local var_324_10 = GameObjectTools.GetOrAddComponent(var_324_0.gameObject, typeof(DynamicBoneHelper))

				if var_324_10 then
					var_324_10:EnableDynamicBone(true)
				end
			end

			local var_324_11 = arg_321_1.actors_["1077ui_story"]
			local var_324_12 = 0

			if var_324_12 < arg_321_1.time_ and arg_321_1.time_ <= var_324_12 + arg_324_0 and not isNil(var_324_11) and arg_321_1.var_.characterEffect1077ui_story == nil then
				arg_321_1.var_.characterEffect1077ui_story = var_324_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_324_13 = 0.200000002980232

			if var_324_12 <= arg_321_1.time_ and arg_321_1.time_ < var_324_12 + var_324_13 and not isNil(var_324_11) then
				local var_324_14 = (arg_321_1.time_ - var_324_12) / var_324_13

				if arg_321_1.var_.characterEffect1077ui_story and not isNil(var_324_11) then
					arg_321_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_321_1.time_ >= var_324_12 + var_324_13 and arg_321_1.time_ < var_324_12 + var_324_13 + arg_324_0 and not isNil(var_324_11) and arg_321_1.var_.characterEffect1077ui_story then
				arg_321_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_324_15 = 0

			if var_324_15 < arg_321_1.time_ and arg_321_1.time_ <= var_324_15 + arg_324_0 then
				arg_321_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action6_1")
			end

			local var_324_16 = 0

			if var_324_16 < arg_321_1.time_ and arg_321_1.time_ <= var_324_16 + arg_324_0 then
				arg_321_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_324_17 = 0
			local var_324_18 = 0.25

			if var_324_17 < arg_321_1.time_ and arg_321_1.time_ <= var_324_17 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, true)

				local var_324_19 = arg_321_1:FormatText(StoryNameCfg[1467].name)

				arg_321_1.leftNameTxt_.text = var_324_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_321_1.leftNameTxt_.transform)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1.leftNameTxt_.text)
				SetActive(arg_321_1.iconTrs_.gameObject, false)
				arg_321_1.callingController_:SetSelectedState("normal")

				local var_324_20 = arg_321_1:GetWordFromCfg(325102074)
				local var_324_21 = arg_321_1:FormatText(var_324_20.content)

				arg_321_1.text_.text = var_324_21

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_22 = 10
				local var_324_23 = utf8.len(var_324_21)
				local var_324_24 = var_324_22 <= 0 and var_324_18 or var_324_18 * (var_324_23 / var_324_22)

				if var_324_24 > 0 and var_324_18 < var_324_24 then
					arg_321_1.talkMaxDuration = var_324_24

					if var_324_24 + var_324_17 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_24 + var_324_17
					end
				end

				arg_321_1.text_.text = var_324_21
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325102", "325102074", "story_v_out_325102.awb") ~= 0 then
					local var_324_25 = manager.audio:GetVoiceLength("story_v_out_325102", "325102074", "story_v_out_325102.awb") / 1000

					if var_324_25 + var_324_17 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_25 + var_324_17
					end

					if var_324_20.prefab_name ~= "" and arg_321_1.actors_[var_324_20.prefab_name] ~= nil then
						local var_324_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_321_1.actors_[var_324_20.prefab_name].transform, "story_v_out_325102", "325102074", "story_v_out_325102.awb")

						arg_321_1:RecordAudio("325102074", var_324_26)
						arg_321_1:RecordAudio("325102074", var_324_26)
					else
						arg_321_1:AudioAction("play", "voice", "story_v_out_325102", "325102074", "story_v_out_325102.awb")
					end

					arg_321_1:RecordHistoryTalkVoice("story_v_out_325102", "325102074", "story_v_out_325102.awb")
				end

				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_27 = math.max(var_324_18, arg_321_1.talkMaxDuration)

			if var_324_17 <= arg_321_1.time_ and arg_321_1.time_ < var_324_17 + var_324_27 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - var_324_17) / var_324_27

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= var_324_17 + var_324_27 and arg_321_1.time_ < var_324_17 + var_324_27 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_321_1:InitPlayNodeList()
	end,
	Play325102075 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 325102075
		arg_325_1.duration_ = 11.57

		local var_325_0 = {
			zh = 8.49933333333333,
			ja = 11.5663333333333
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
				arg_325_0:Play325102076(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			local var_328_0 = 1.43333333333333

			if var_328_0 < arg_325_1.time_ and arg_325_1.time_ <= var_328_0 + arg_328_0 then
				local var_328_1 = manager.ui.mainCamera.transform.localPosition
				local var_328_2 = Vector3.New(0, 0, 10) + Vector3.New(var_328_1.x, var_328_1.y, 0)
				local var_328_3 = arg_325_1.bgs_.J29g

				var_328_3.transform.localPosition = var_328_2
				var_328_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_328_4 = var_328_3:GetComponent("SpriteRenderer")

				if var_328_4 and var_328_4.sprite then
					local var_328_5 = (var_328_3.transform.localPosition - var_328_1).z
					local var_328_6 = manager.ui.mainCameraCom_
					local var_328_7 = 2 * var_328_5 * Mathf.Tan(var_328_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_328_8 = var_328_7 * var_328_6.aspect
					local var_328_9 = var_328_4.sprite.bounds.size.x
					local var_328_10 = var_328_4.sprite.bounds.size.y
					local var_328_11 = var_328_8 / var_328_9
					local var_328_12 = var_328_7 / var_328_10
					local var_328_13 = var_328_12 < var_328_11 and var_328_11 or var_328_12

					var_328_3.transform.localScale = Vector3.New(var_328_13, var_328_13, 0)
				end

				for iter_328_0, iter_328_1 in pairs(arg_325_1.bgs_) do
					if iter_328_0 ~= "J29g" then
						iter_328_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_328_14 = 1.43333333333333

			arg_325_1.isInRecall_ = false

			if var_328_14 < arg_325_1.time_ and arg_325_1.time_ <= var_328_14 + arg_328_0 then
				arg_325_1.screenFilterGo_:SetActive(true)

				arg_325_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile.asset")

				for iter_328_2, iter_328_3 in pairs(arg_325_1.actors_) do
					local var_328_15 = iter_328_3:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_328_4, iter_328_5 in ipairs(var_328_15) do
						if iter_328_5.color.r > 0.51 then
							iter_328_5.color = Color.New(1, 1, 1)
						else
							iter_328_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_328_16 = 0.034000001847744

			if var_328_14 <= arg_325_1.time_ and arg_325_1.time_ < var_328_14 + var_328_16 then
				local var_328_17 = (arg_325_1.time_ - var_328_14) / var_328_16

				arg_325_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, var_328_17)
			end

			if arg_325_1.time_ >= var_328_14 + var_328_16 and arg_325_1.time_ < var_328_14 + var_328_16 + arg_328_0 then
				arg_325_1.screenFilterEffect_.weight = 1
			end

			local var_328_18 = 0

			if var_328_18 < arg_325_1.time_ and arg_325_1.time_ <= var_328_18 + arg_328_0 then
				arg_325_1.mask_.enabled = true
				arg_325_1.mask_.raycastTarget = true

				arg_325_1:SetGaussion(false)
			end

			local var_328_19 = 1.43333333333333

			if var_328_18 <= arg_325_1.time_ and arg_325_1.time_ < var_328_18 + var_328_19 then
				local var_328_20 = (arg_325_1.time_ - var_328_18) / var_328_19
				local var_328_21 = Color.New(0, 0, 0)

				var_328_21.a = Mathf.Lerp(0, 1, var_328_20)
				arg_325_1.mask_.color = var_328_21
			end

			if arg_325_1.time_ >= var_328_18 + var_328_19 and arg_325_1.time_ < var_328_18 + var_328_19 + arg_328_0 then
				local var_328_22 = Color.New(0, 0, 0)

				var_328_22.a = 1
				arg_325_1.mask_.color = var_328_22
			end

			local var_328_23 = 1.43333333333333

			if var_328_23 < arg_325_1.time_ and arg_325_1.time_ <= var_328_23 + arg_328_0 then
				arg_325_1.mask_.enabled = true
				arg_325_1.mask_.raycastTarget = true

				arg_325_1:SetGaussion(false)
			end

			local var_328_24 = 1.4

			if var_328_23 <= arg_325_1.time_ and arg_325_1.time_ < var_328_23 + var_328_24 then
				local var_328_25 = (arg_325_1.time_ - var_328_23) / var_328_24
				local var_328_26 = Color.New(0, 0, 0)

				var_328_26.a = Mathf.Lerp(1, 0, var_328_25)
				arg_325_1.mask_.color = var_328_26
			end

			if arg_325_1.time_ >= var_328_23 + var_328_24 and arg_325_1.time_ < var_328_23 + var_328_24 + arg_328_0 then
				local var_328_27 = Color.New(0, 0, 0)
				local var_328_28 = 0

				arg_325_1.mask_.enabled = false
				var_328_27.a = var_328_28
				arg_325_1.mask_.color = var_328_27
			end

			local var_328_29 = 2.53333333333333

			if var_328_29 < arg_325_1.time_ and arg_325_1.time_ <= var_328_29 + arg_328_0 then
				arg_325_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action1_1")
			end

			local var_328_30 = arg_325_1.actors_["1077ui_story"].transform
			local var_328_31 = 2.53333333333333

			if var_328_31 < arg_325_1.time_ and arg_325_1.time_ <= var_328_31 + arg_328_0 then
				arg_325_1.var_.moveOldPos1077ui_story = var_328_30.localPosition

				local var_328_32 = GameObjectTools.GetOrAddComponent(var_328_30.gameObject, typeof(DynamicBoneHelper))

				if var_328_32 then
					var_328_32:EnableDynamicBone(false)
				end
			end

			local var_328_33 = 0.001

			if var_328_31 <= arg_325_1.time_ and arg_325_1.time_ < var_328_31 + var_328_33 then
				local var_328_34 = (arg_325_1.time_ - var_328_31) / var_328_33
				local var_328_35 = Vector3.New(-0.03, -1.02, -5.92)

				var_328_30.localPosition = Vector3.Lerp(arg_325_1.var_.moveOldPos1077ui_story, var_328_35, var_328_34)

				local var_328_36 = manager.ui.mainCamera.transform.position - var_328_30.position

				var_328_30.forward = Vector3.New(var_328_36.x, var_328_36.y, var_328_36.z)

				local var_328_37 = var_328_30.localEulerAngles

				var_328_37.z = 0
				var_328_37.x = 0
				var_328_30.localEulerAngles = var_328_37
			end

			if arg_325_1.time_ >= var_328_31 + var_328_33 and arg_325_1.time_ < var_328_31 + var_328_33 + arg_328_0 then
				var_328_30.localPosition = Vector3.New(-0.03, -1.02, -5.92)

				local var_328_38 = manager.ui.mainCamera.transform.position - var_328_30.position

				var_328_30.forward = Vector3.New(var_328_38.x, var_328_38.y, var_328_38.z)

				local var_328_39 = var_328_30.localEulerAngles

				var_328_39.z = 0
				var_328_39.x = 0
				var_328_30.localEulerAngles = var_328_39

				local var_328_40 = GameObjectTools.GetOrAddComponent(var_328_30.gameObject, typeof(DynamicBoneHelper))

				if var_328_40 then
					var_328_40:EnableDynamicBone(true)
				end
			end

			local var_328_41 = arg_325_1.actors_["1077ui_story"]
			local var_328_42 = 2.53333333333333

			if var_328_42 < arg_325_1.time_ and arg_325_1.time_ <= var_328_42 + arg_328_0 and not isNil(var_328_41) and arg_325_1.var_.characterEffect1077ui_story == nil then
				arg_325_1.var_.characterEffect1077ui_story = var_328_41:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_328_43 = 0.533333333333333

			if var_328_42 <= arg_325_1.time_ and arg_325_1.time_ < var_328_42 + var_328_43 and not isNil(var_328_41) then
				local var_328_44 = (arg_325_1.time_ - var_328_42) / var_328_43

				if arg_325_1.var_.characterEffect1077ui_story and not isNil(var_328_41) then
					arg_325_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_325_1.time_ >= var_328_42 + var_328_43 and arg_325_1.time_ < var_328_42 + var_328_43 + arg_328_0 and not isNil(var_328_41) and arg_325_1.var_.characterEffect1077ui_story then
				arg_325_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_328_45 = 2.53333333333333

			if var_328_45 < arg_325_1.time_ and arg_325_1.time_ <= var_328_45 + arg_328_0 then
				arg_325_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action1_1")
			end

			local var_328_46 = arg_325_1.actors_["1077ui_story"]
			local var_328_47 = 2.53333333333333

			if var_328_47 < arg_325_1.time_ and arg_325_1.time_ <= var_328_47 + arg_328_0 and not isNil(var_328_46) and arg_325_1.var_.characterEffect1077ui_story == nil then
				arg_325_1.var_.characterEffect1077ui_story = var_328_46:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_328_48 = 0.200000002980232

			if var_328_47 <= arg_325_1.time_ and arg_325_1.time_ < var_328_47 + var_328_48 and not isNil(var_328_46) then
				local var_328_49 = (arg_325_1.time_ - var_328_47) / var_328_48

				if arg_325_1.var_.characterEffect1077ui_story and not isNil(var_328_46) then
					arg_325_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_325_1.time_ >= var_328_47 + var_328_48 and arg_325_1.time_ < var_328_47 + var_328_48 + arg_328_0 and not isNil(var_328_46) and arg_325_1.var_.characterEffect1077ui_story then
				arg_325_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_328_50 = arg_325_1.actors_["1077ui_story"].transform
			local var_328_51 = 1.43333333333333

			if var_328_51 < arg_325_1.time_ and arg_325_1.time_ <= var_328_51 + arg_328_0 then
				arg_325_1.var_.moveOldPos1077ui_story = var_328_50.localPosition

				local var_328_52 = GameObjectTools.GetOrAddComponent(var_328_50.gameObject, typeof(DynamicBoneHelper))

				if var_328_52 then
					var_328_52:EnableDynamicBone(false)
				end
			end

			local var_328_53 = 0.001

			if var_328_51 <= arg_325_1.time_ and arg_325_1.time_ < var_328_51 + var_328_53 then
				local var_328_54 = (arg_325_1.time_ - var_328_51) / var_328_53
				local var_328_55 = Vector3.New(0, 100, 0)

				var_328_50.localPosition = Vector3.Lerp(arg_325_1.var_.moveOldPos1077ui_story, var_328_55, var_328_54)

				local var_328_56 = manager.ui.mainCamera.transform.position - var_328_50.position

				var_328_50.forward = Vector3.New(var_328_56.x, var_328_56.y, var_328_56.z)

				local var_328_57 = var_328_50.localEulerAngles

				var_328_57.z = 0
				var_328_57.x = 0
				var_328_50.localEulerAngles = var_328_57
			end

			if arg_325_1.time_ >= var_328_51 + var_328_53 and arg_325_1.time_ < var_328_51 + var_328_53 + arg_328_0 then
				var_328_50.localPosition = Vector3.New(0, 100, 0)

				local var_328_58 = manager.ui.mainCamera.transform.position - var_328_50.position

				var_328_50.forward = Vector3.New(var_328_58.x, var_328_58.y, var_328_58.z)

				local var_328_59 = var_328_50.localEulerAngles

				var_328_59.z = 0
				var_328_59.x = 0
				var_328_50.localEulerAngles = var_328_59

				local var_328_60 = GameObjectTools.GetOrAddComponent(var_328_50.gameObject, typeof(DynamicBoneHelper))

				if var_328_60 then
					var_328_60:EnableDynamicBone(true)
				end
			end

			if arg_325_1.frameCnt_ <= 1 then
				arg_325_1.dialog_:SetActive(false)
			end

			local var_328_61 = 2.83333333333333
			local var_328_62 = 0.775

			if var_328_61 < arg_325_1.time_ and arg_325_1.time_ <= var_328_61 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0

				arg_325_1.dialog_:SetActive(true)

				arg_325_1.dialogCg_.alpha = 0

				local var_328_63 = LeanTween.value(arg_325_1.dialog_, 0, 1, 0.3)

				var_328_63:setOnUpdate(LuaHelper.FloatAction(function(arg_329_0)
					arg_325_1.dialogCg_.alpha = arg_329_0
				end))
				var_328_63:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_325_1.dialog_)
					var_328_63:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_325_1.duration_ = arg_325_1.duration_ + 0.3

				SetActive(arg_325_1.leftNameGo_, true)

				local var_328_64 = arg_325_1:FormatText(StoryNameCfg[1467].name)

				arg_325_1.leftNameTxt_.text = var_328_64

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_325_1.leftNameTxt_.transform)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1.leftNameTxt_.text)
				SetActive(arg_325_1.iconTrs_.gameObject, false)
				arg_325_1.callingController_:SetSelectedState("normal")

				local var_328_65 = arg_325_1:GetWordFromCfg(325102075)
				local var_328_66 = arg_325_1:FormatText(var_328_65.content)

				arg_325_1.text_.text = var_328_66

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_67 = 31
				local var_328_68 = utf8.len(var_328_66)
				local var_328_69 = var_328_67 <= 0 and var_328_62 or var_328_62 * (var_328_68 / var_328_67)

				if var_328_69 > 0 and var_328_62 < var_328_69 then
					arg_325_1.talkMaxDuration = var_328_69
					var_328_61 = var_328_61 + 0.3

					if var_328_69 + var_328_61 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_69 + var_328_61
					end
				end

				arg_325_1.text_.text = var_328_66
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325102", "325102075", "story_v_out_325102.awb") ~= 0 then
					local var_328_70 = manager.audio:GetVoiceLength("story_v_out_325102", "325102075", "story_v_out_325102.awb") / 1000

					if var_328_70 + var_328_61 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_70 + var_328_61
					end

					if var_328_65.prefab_name ~= "" and arg_325_1.actors_[var_328_65.prefab_name] ~= nil then
						local var_328_71 = LuaForUtil.PlayVoiceWithCriLipsync(arg_325_1.actors_[var_328_65.prefab_name].transform, "story_v_out_325102", "325102075", "story_v_out_325102.awb")

						arg_325_1:RecordAudio("325102075", var_328_71)
						arg_325_1:RecordAudio("325102075", var_328_71)
					else
						arg_325_1:AudioAction("play", "voice", "story_v_out_325102", "325102075", "story_v_out_325102.awb")
					end

					arg_325_1:RecordHistoryTalkVoice("story_v_out_325102", "325102075", "story_v_out_325102.awb")
				end

				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_72 = var_328_61 + 0.3
			local var_328_73 = math.max(var_328_62, arg_325_1.talkMaxDuration)

			if var_328_72 <= arg_325_1.time_ and arg_325_1.time_ < var_328_72 + var_328_73 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - var_328_72) / var_328_73

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= var_328_72 + var_328_73 and arg_325_1.time_ < var_328_72 + var_328_73 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2.53333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.43333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_325_1:InitPlayNodeList()
	end,
	Play325102076 = function(arg_331_0, arg_331_1)
		arg_331_1.time_ = 0
		arg_331_1.frameCnt_ = 0
		arg_331_1.state_ = "playing"
		arg_331_1.curTalkId_ = 325102076
		arg_331_1.duration_ = 6.93

		local var_331_0 = {
			zh = 4.733,
			ja = 6.933
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
				arg_331_0:Play325102077(arg_331_1)
			end
		end

		function arg_331_1.onSingleLineUpdate_(arg_334_0)
			local var_334_0 = arg_331_1.actors_["1059ui_story"]
			local var_334_1 = 0

			if var_334_1 < arg_331_1.time_ and arg_331_1.time_ <= var_334_1 + arg_334_0 and not isNil(var_334_0) and arg_331_1.var_.characterEffect1059ui_story == nil then
				arg_331_1.var_.characterEffect1059ui_story = var_334_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_334_2 = 0.200000002980232

			if var_334_1 <= arg_331_1.time_ and arg_331_1.time_ < var_334_1 + var_334_2 and not isNil(var_334_0) then
				local var_334_3 = (arg_331_1.time_ - var_334_1) / var_334_2

				if arg_331_1.var_.characterEffect1059ui_story and not isNil(var_334_0) then
					arg_331_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_331_1.time_ >= var_334_1 + var_334_2 and arg_331_1.time_ < var_334_1 + var_334_2 + arg_334_0 and not isNil(var_334_0) and arg_331_1.var_.characterEffect1059ui_story then
				arg_331_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_334_4 = arg_331_1.actors_["1077ui_story"]
			local var_334_5 = 0

			if var_334_5 < arg_331_1.time_ and arg_331_1.time_ <= var_334_5 + arg_334_0 and not isNil(var_334_4) and arg_331_1.var_.characterEffect1077ui_story == nil then
				arg_331_1.var_.characterEffect1077ui_story = var_334_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_334_6 = 0.200000002980232

			if var_334_5 <= arg_331_1.time_ and arg_331_1.time_ < var_334_5 + var_334_6 and not isNil(var_334_4) then
				local var_334_7 = (arg_331_1.time_ - var_334_5) / var_334_6

				if arg_331_1.var_.characterEffect1077ui_story and not isNil(var_334_4) then
					local var_334_8 = Mathf.Lerp(0, 0.5, var_334_7)

					arg_331_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_331_1.var_.characterEffect1077ui_story.fillRatio = var_334_8
				end
			end

			if arg_331_1.time_ >= var_334_5 + var_334_6 and arg_331_1.time_ < var_334_5 + var_334_6 + arg_334_0 and not isNil(var_334_4) and arg_331_1.var_.characterEffect1077ui_story then
				local var_334_9 = 0.5

				arg_331_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_331_1.var_.characterEffect1077ui_story.fillRatio = var_334_9
			end

			local var_334_10 = 0
			local var_334_11 = 0.55

			if var_334_10 < arg_331_1.time_ and arg_331_1.time_ <= var_334_10 + arg_334_0 then
				arg_331_1.talkMaxDuration = 0
				arg_331_1.dialogCg_.alpha = 1

				arg_331_1.dialog_:SetActive(true)
				SetActive(arg_331_1.leftNameGo_, true)

				local var_334_12 = arg_331_1:FormatText(StoryNameCfg[1455].name)

				arg_331_1.leftNameTxt_.text = var_334_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_331_1.leftNameTxt_.transform)

				arg_331_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_331_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_331_1:RecordName(arg_331_1.leftNameTxt_.text)
				SetActive(arg_331_1.iconTrs_.gameObject, true)
				arg_331_1.iconController_:SetSelectedState("hero")

				arg_331_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_331_1.callingController_:SetSelectedState("normal")

				arg_331_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_331_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_334_13 = arg_331_1:GetWordFromCfg(325102076)
				local var_334_14 = arg_331_1:FormatText(var_334_13.content)

				arg_331_1.text_.text = var_334_14

				LuaForUtil.ClearLinePrefixSymbol(arg_331_1.text_)

				local var_334_15 = 22
				local var_334_16 = utf8.len(var_334_14)
				local var_334_17 = var_334_15 <= 0 and var_334_11 or var_334_11 * (var_334_16 / var_334_15)

				if var_334_17 > 0 and var_334_11 < var_334_17 then
					arg_331_1.talkMaxDuration = var_334_17

					if var_334_17 + var_334_10 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_17 + var_334_10
					end
				end

				arg_331_1.text_.text = var_334_14
				arg_331_1.typewritter.percent = 0

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325102", "325102076", "story_v_out_325102.awb") ~= 0 then
					local var_334_18 = manager.audio:GetVoiceLength("story_v_out_325102", "325102076", "story_v_out_325102.awb") / 1000

					if var_334_18 + var_334_10 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_18 + var_334_10
					end

					if var_334_13.prefab_name ~= "" and arg_331_1.actors_[var_334_13.prefab_name] ~= nil then
						local var_334_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_331_1.actors_[var_334_13.prefab_name].transform, "story_v_out_325102", "325102076", "story_v_out_325102.awb")

						arg_331_1:RecordAudio("325102076", var_334_19)
						arg_331_1:RecordAudio("325102076", var_334_19)
					else
						arg_331_1:AudioAction("play", "voice", "story_v_out_325102", "325102076", "story_v_out_325102.awb")
					end

					arg_331_1:RecordHistoryTalkVoice("story_v_out_325102", "325102076", "story_v_out_325102.awb")
				end

				arg_331_1:RecordContent(arg_331_1.text_.text)
			end

			local var_334_20 = math.max(var_334_11, arg_331_1.talkMaxDuration)

			if var_334_10 <= arg_331_1.time_ and arg_331_1.time_ < var_334_10 + var_334_20 then
				arg_331_1.typewritter.percent = (arg_331_1.time_ - var_334_10) / var_334_20

				arg_331_1.typewritter:SetDirty()
			end

			if arg_331_1.time_ >= var_334_10 + var_334_20 and arg_331_1.time_ < var_334_10 + var_334_20 + arg_334_0 then
				arg_331_1.typewritter.percent = 1

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(true)
			end
		end

		arg_331_1.nodeConfigList_ = {}

		arg_331_1:InitPlayNodeList()
	end,
	Play325102077 = function(arg_335_0, arg_335_1)
		arg_335_1.time_ = 0
		arg_335_1.frameCnt_ = 0
		arg_335_1.state_ = "playing"
		arg_335_1.curTalkId_ = 325102077
		arg_335_1.duration_ = 16.97

		local var_335_0 = {
			zh = 11.2,
			ja = 16.966
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
				arg_335_0:Play325102078(arg_335_1)
			end
		end

		function arg_335_1.onSingleLineUpdate_(arg_338_0)
			local var_338_0 = 0
			local var_338_1 = 1.375

			if var_338_0 < arg_335_1.time_ and arg_335_1.time_ <= var_338_0 + arg_338_0 then
				arg_335_1.talkMaxDuration = 0
				arg_335_1.dialogCg_.alpha = 1

				arg_335_1.dialog_:SetActive(true)
				SetActive(arg_335_1.leftNameGo_, true)

				local var_338_2 = arg_335_1:FormatText(StoryNameCfg[1455].name)

				arg_335_1.leftNameTxt_.text = var_338_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_335_1.leftNameTxt_.transform)

				arg_335_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_335_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_335_1:RecordName(arg_335_1.leftNameTxt_.text)
				SetActive(arg_335_1.iconTrs_.gameObject, true)
				arg_335_1.iconController_:SetSelectedState("hero")

				arg_335_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_335_1.callingController_:SetSelectedState("normal")

				arg_335_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_335_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_338_3 = arg_335_1:GetWordFromCfg(325102077)
				local var_338_4 = arg_335_1:FormatText(var_338_3.content)

				arg_335_1.text_.text = var_338_4

				LuaForUtil.ClearLinePrefixSymbol(arg_335_1.text_)

				local var_338_5 = 55
				local var_338_6 = utf8.len(var_338_4)
				local var_338_7 = var_338_5 <= 0 and var_338_1 or var_338_1 * (var_338_6 / var_338_5)

				if var_338_7 > 0 and var_338_1 < var_338_7 then
					arg_335_1.talkMaxDuration = var_338_7

					if var_338_7 + var_338_0 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_7 + var_338_0
					end
				end

				arg_335_1.text_.text = var_338_4
				arg_335_1.typewritter.percent = 0

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325102", "325102077", "story_v_out_325102.awb") ~= 0 then
					local var_338_8 = manager.audio:GetVoiceLength("story_v_out_325102", "325102077", "story_v_out_325102.awb") / 1000

					if var_338_8 + var_338_0 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_8 + var_338_0
					end

					if var_338_3.prefab_name ~= "" and arg_335_1.actors_[var_338_3.prefab_name] ~= nil then
						local var_338_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_335_1.actors_[var_338_3.prefab_name].transform, "story_v_out_325102", "325102077", "story_v_out_325102.awb")

						arg_335_1:RecordAudio("325102077", var_338_9)
						arg_335_1:RecordAudio("325102077", var_338_9)
					else
						arg_335_1:AudioAction("play", "voice", "story_v_out_325102", "325102077", "story_v_out_325102.awb")
					end

					arg_335_1:RecordHistoryTalkVoice("story_v_out_325102", "325102077", "story_v_out_325102.awb")
				end

				arg_335_1:RecordContent(arg_335_1.text_.text)
			end

			local var_338_10 = math.max(var_338_1, arg_335_1.talkMaxDuration)

			if var_338_0 <= arg_335_1.time_ and arg_335_1.time_ < var_338_0 + var_338_10 then
				arg_335_1.typewritter.percent = (arg_335_1.time_ - var_338_0) / var_338_10

				arg_335_1.typewritter:SetDirty()
			end

			if arg_335_1.time_ >= var_338_0 + var_338_10 and arg_335_1.time_ < var_338_0 + var_338_10 + arg_338_0 then
				arg_335_1.typewritter.percent = 1

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(true)
			end
		end

		arg_335_1.nodeConfigList_ = {}

		arg_335_1:InitPlayNodeList()
	end,
	Play325102078 = function(arg_339_0, arg_339_1)
		arg_339_1.time_ = 0
		arg_339_1.frameCnt_ = 0
		arg_339_1.state_ = "playing"
		arg_339_1.curTalkId_ = 325102078
		arg_339_1.duration_ = 7.17

		local var_339_0 = {
			zh = 6.93333333631356,
			ja = 7.16633333631357
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
				arg_339_0:Play325102079(arg_339_1)
			end
		end

		function arg_339_1.onSingleLineUpdate_(arg_342_0)
			local var_342_0 = 1.26666666666667

			if var_342_0 < arg_339_1.time_ and arg_339_1.time_ <= var_342_0 + arg_342_0 then
				local var_342_1 = manager.ui.mainCamera.transform.localPosition
				local var_342_2 = Vector3.New(0, 0, 10) + Vector3.New(var_342_1.x, var_342_1.y, 0)
				local var_342_3 = arg_339_1.bgs_.J22f

				var_342_3.transform.localPosition = var_342_2
				var_342_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_342_4 = var_342_3:GetComponent("SpriteRenderer")

				if var_342_4 and var_342_4.sprite then
					local var_342_5 = (var_342_3.transform.localPosition - var_342_1).z
					local var_342_6 = manager.ui.mainCameraCom_
					local var_342_7 = 2 * var_342_5 * Mathf.Tan(var_342_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_342_8 = var_342_7 * var_342_6.aspect
					local var_342_9 = var_342_4.sprite.bounds.size.x
					local var_342_10 = var_342_4.sprite.bounds.size.y
					local var_342_11 = var_342_8 / var_342_9
					local var_342_12 = var_342_7 / var_342_10
					local var_342_13 = var_342_12 < var_342_11 and var_342_11 or var_342_12

					var_342_3.transform.localScale = Vector3.New(var_342_13, var_342_13, 0)
				end

				for iter_342_0, iter_342_1 in pairs(arg_339_1.bgs_) do
					if iter_342_0 ~= "J22f" then
						iter_342_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_342_14 = arg_339_1.actors_["1077ui_story"]
			local var_342_15 = 2.63333333333333

			if var_342_15 < arg_339_1.time_ and arg_339_1.time_ <= var_342_15 + arg_342_0 and not isNil(var_342_14) and arg_339_1.var_.characterEffect1077ui_story == nil then
				arg_339_1.var_.characterEffect1077ui_story = var_342_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_342_16 = 0.200000002980232

			if var_342_15 <= arg_339_1.time_ and arg_339_1.time_ < var_342_15 + var_342_16 and not isNil(var_342_14) then
				local var_342_17 = (arg_339_1.time_ - var_342_15) / var_342_16

				if arg_339_1.var_.characterEffect1077ui_story and not isNil(var_342_14) then
					arg_339_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_339_1.time_ >= var_342_15 + var_342_16 and arg_339_1.time_ < var_342_15 + var_342_16 + arg_342_0 and not isNil(var_342_14) and arg_339_1.var_.characterEffect1077ui_story then
				arg_339_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_342_18 = 0

			if var_342_18 < arg_339_1.time_ and arg_339_1.time_ <= var_342_18 + arg_342_0 then
				arg_339_1.mask_.enabled = true
				arg_339_1.mask_.raycastTarget = true

				arg_339_1:SetGaussion(false)
			end

			local var_342_19 = 1.26666666666667

			if var_342_18 <= arg_339_1.time_ and arg_339_1.time_ < var_342_18 + var_342_19 then
				local var_342_20 = (arg_339_1.time_ - var_342_18) / var_342_19
				local var_342_21 = Color.New(0, 0, 0)

				var_342_21.a = Mathf.Lerp(0, 1, var_342_20)
				arg_339_1.mask_.color = var_342_21
			end

			if arg_339_1.time_ >= var_342_18 + var_342_19 and arg_339_1.time_ < var_342_18 + var_342_19 + arg_342_0 then
				local var_342_22 = Color.New(0, 0, 0)

				var_342_22.a = 1
				arg_339_1.mask_.color = var_342_22
			end

			local var_342_23 = 1.26666666666667

			if var_342_23 < arg_339_1.time_ and arg_339_1.time_ <= var_342_23 + arg_342_0 then
				arg_339_1.mask_.enabled = true
				arg_339_1.mask_.raycastTarget = true

				arg_339_1:SetGaussion(false)
			end

			local var_342_24 = 1.73333333333333

			if var_342_23 <= arg_339_1.time_ and arg_339_1.time_ < var_342_23 + var_342_24 then
				local var_342_25 = (arg_339_1.time_ - var_342_23) / var_342_24
				local var_342_26 = Color.New(0, 0, 0)

				var_342_26.a = Mathf.Lerp(1, 0, var_342_25)
				arg_339_1.mask_.color = var_342_26
			end

			if arg_339_1.time_ >= var_342_23 + var_342_24 and arg_339_1.time_ < var_342_23 + var_342_24 + arg_342_0 then
				local var_342_27 = Color.New(0, 0, 0)
				local var_342_28 = 0

				arg_339_1.mask_.enabled = false
				var_342_27.a = var_342_28
				arg_339_1.mask_.color = var_342_27
			end

			local var_342_29 = arg_339_1.actors_["1077ui_story"].transform
			local var_342_30 = 2.63333333333333

			if var_342_30 < arg_339_1.time_ and arg_339_1.time_ <= var_342_30 + arg_342_0 then
				arg_339_1.var_.moveOldPos1077ui_story = var_342_29.localPosition

				local var_342_31 = GameObjectTools.GetOrAddComponent(var_342_29.gameObject, typeof(DynamicBoneHelper))

				if var_342_31 then
					var_342_31:EnableDynamicBone(false)
				end
			end

			local var_342_32 = 0.001

			if var_342_30 <= arg_339_1.time_ and arg_339_1.time_ < var_342_30 + var_342_32 then
				local var_342_33 = (arg_339_1.time_ - var_342_30) / var_342_32
				local var_342_34 = Vector3.New(-0.03, -1.02, -5.92)

				var_342_29.localPosition = Vector3.Lerp(arg_339_1.var_.moveOldPos1077ui_story, var_342_34, var_342_33)

				local var_342_35 = manager.ui.mainCamera.transform.position - var_342_29.position

				var_342_29.forward = Vector3.New(var_342_35.x, var_342_35.y, var_342_35.z)

				local var_342_36 = var_342_29.localEulerAngles

				var_342_36.z = 0
				var_342_36.x = 0
				var_342_29.localEulerAngles = var_342_36
			end

			if arg_339_1.time_ >= var_342_30 + var_342_32 and arg_339_1.time_ < var_342_30 + var_342_32 + arg_342_0 then
				var_342_29.localPosition = Vector3.New(-0.03, -1.02, -5.92)

				local var_342_37 = manager.ui.mainCamera.transform.position - var_342_29.position

				var_342_29.forward = Vector3.New(var_342_37.x, var_342_37.y, var_342_37.z)

				local var_342_38 = var_342_29.localEulerAngles

				var_342_38.z = 0
				var_342_38.x = 0
				var_342_29.localEulerAngles = var_342_38

				local var_342_39 = GameObjectTools.GetOrAddComponent(var_342_29.gameObject, typeof(DynamicBoneHelper))

				if var_342_39 then
					var_342_39:EnableDynamicBone(true)
				end
			end

			local var_342_40 = arg_339_1.actors_["1077ui_story"]
			local var_342_41 = 2.63333333333333

			if var_342_41 < arg_339_1.time_ and arg_339_1.time_ <= var_342_41 + arg_342_0 and not isNil(var_342_40) and arg_339_1.var_.characterEffect1077ui_story == nil then
				arg_339_1.var_.characterEffect1077ui_story = var_342_40:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_342_42 = 0.55

			if var_342_41 <= arg_339_1.time_ and arg_339_1.time_ < var_342_41 + var_342_42 and not isNil(var_342_40) then
				local var_342_43 = (arg_339_1.time_ - var_342_41) / var_342_42

				if arg_339_1.var_.characterEffect1077ui_story and not isNil(var_342_40) then
					arg_339_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_339_1.time_ >= var_342_41 + var_342_42 and arg_339_1.time_ < var_342_41 + var_342_42 + arg_342_0 and not isNil(var_342_40) and arg_339_1.var_.characterEffect1077ui_story then
				arg_339_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_342_44 = 1.26666666666667

			arg_339_1.isInRecall_ = false

			if var_342_44 < arg_339_1.time_ and arg_339_1.time_ <= var_342_44 + arg_342_0 then
				arg_339_1.screenFilterGo_:SetActive(false)

				for iter_342_2, iter_342_3 in pairs(arg_339_1.actors_) do
					local var_342_45 = iter_342_3:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_342_4, iter_342_5 in ipairs(var_342_45) do
						if iter_342_5.color.r > 0.51 then
							iter_342_5.color = Color.New(1, 1, 1)
						else
							iter_342_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_342_46 = 0.034000001847744

			if var_342_44 <= arg_339_1.time_ and arg_339_1.time_ < var_342_44 + var_342_46 then
				local var_342_47 = (arg_339_1.time_ - var_342_44) / var_342_46

				arg_339_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, var_342_47)
			end

			if arg_339_1.time_ >= var_342_44 + var_342_46 and arg_339_1.time_ < var_342_44 + var_342_46 + arg_342_0 then
				arg_339_1.screenFilterEffect_.weight = 0
			end

			local var_342_48 = 2.63333333333333

			if var_342_48 < arg_339_1.time_ and arg_339_1.time_ <= var_342_48 + arg_342_0 then
				arg_339_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action6_2")
			end

			local var_342_49 = arg_339_1.actors_["1077ui_story"].transform
			local var_342_50 = 1.26666666666667

			if var_342_50 < arg_339_1.time_ and arg_339_1.time_ <= var_342_50 + arg_342_0 then
				arg_339_1.var_.moveOldPos1077ui_story = var_342_49.localPosition

				local var_342_51 = GameObjectTools.GetOrAddComponent(var_342_49.gameObject, typeof(DynamicBoneHelper))

				if var_342_51 then
					var_342_51:EnableDynamicBone(false)
				end
			end

			local var_342_52 = 0.001

			if var_342_50 <= arg_339_1.time_ and arg_339_1.time_ < var_342_50 + var_342_52 then
				local var_342_53 = (arg_339_1.time_ - var_342_50) / var_342_52
				local var_342_54 = Vector3.New(0, 100, 0)

				var_342_49.localPosition = Vector3.Lerp(arg_339_1.var_.moveOldPos1077ui_story, var_342_54, var_342_53)

				local var_342_55 = manager.ui.mainCamera.transform.position - var_342_49.position

				var_342_49.forward = Vector3.New(var_342_55.x, var_342_55.y, var_342_55.z)

				local var_342_56 = var_342_49.localEulerAngles

				var_342_56.z = 0
				var_342_56.x = 0
				var_342_49.localEulerAngles = var_342_56
			end

			if arg_339_1.time_ >= var_342_50 + var_342_52 and arg_339_1.time_ < var_342_50 + var_342_52 + arg_342_0 then
				var_342_49.localPosition = Vector3.New(0, 100, 0)

				local var_342_57 = manager.ui.mainCamera.transform.position - var_342_49.position

				var_342_49.forward = Vector3.New(var_342_57.x, var_342_57.y, var_342_57.z)

				local var_342_58 = var_342_49.localEulerAngles

				var_342_58.z = 0
				var_342_58.x = 0
				var_342_49.localEulerAngles = var_342_58

				local var_342_59 = GameObjectTools.GetOrAddComponent(var_342_49.gameObject, typeof(DynamicBoneHelper))

				if var_342_59 then
					var_342_59:EnableDynamicBone(true)
				end
			end

			if arg_339_1.frameCnt_ <= 1 then
				arg_339_1.dialog_:SetActive(false)
			end

			local var_342_60 = 2.83333333631357
			local var_342_61 = 0.45

			if var_342_60 < arg_339_1.time_ and arg_339_1.time_ <= var_342_60 + arg_342_0 then
				arg_339_1.talkMaxDuration = 0

				arg_339_1.dialog_:SetActive(true)

				arg_339_1.dialogCg_.alpha = 0

				local var_342_62 = LeanTween.value(arg_339_1.dialog_, 0, 1, 0.3)

				var_342_62:setOnUpdate(LuaHelper.FloatAction(function(arg_343_0)
					arg_339_1.dialogCg_.alpha = arg_343_0
				end))
				var_342_62:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_339_1.dialog_)
					var_342_62:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_339_1.duration_ = arg_339_1.duration_ + 0.3

				SetActive(arg_339_1.leftNameGo_, true)

				local var_342_63 = arg_339_1:FormatText(StoryNameCfg[1467].name)

				arg_339_1.leftNameTxt_.text = var_342_63

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_339_1.leftNameTxt_.transform)

				arg_339_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_339_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_339_1:RecordName(arg_339_1.leftNameTxt_.text)
				SetActive(arg_339_1.iconTrs_.gameObject, false)
				arg_339_1.callingController_:SetSelectedState("normal")

				local var_342_64 = arg_339_1:GetWordFromCfg(325102078)
				local var_342_65 = arg_339_1:FormatText(var_342_64.content)

				arg_339_1.text_.text = var_342_65

				LuaForUtil.ClearLinePrefixSymbol(arg_339_1.text_)

				local var_342_66 = 18
				local var_342_67 = utf8.len(var_342_65)
				local var_342_68 = var_342_66 <= 0 and var_342_61 or var_342_61 * (var_342_67 / var_342_66)

				if var_342_68 > 0 and var_342_61 < var_342_68 then
					arg_339_1.talkMaxDuration = var_342_68
					var_342_60 = var_342_60 + 0.3

					if var_342_68 + var_342_60 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_68 + var_342_60
					end
				end

				arg_339_1.text_.text = var_342_65
				arg_339_1.typewritter.percent = 0

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325102", "325102078", "story_v_out_325102.awb") ~= 0 then
					local var_342_69 = manager.audio:GetVoiceLength("story_v_out_325102", "325102078", "story_v_out_325102.awb") / 1000

					if var_342_69 + var_342_60 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_69 + var_342_60
					end

					if var_342_64.prefab_name ~= "" and arg_339_1.actors_[var_342_64.prefab_name] ~= nil then
						local var_342_70 = LuaForUtil.PlayVoiceWithCriLipsync(arg_339_1.actors_[var_342_64.prefab_name].transform, "story_v_out_325102", "325102078", "story_v_out_325102.awb")

						arg_339_1:RecordAudio("325102078", var_342_70)
						arg_339_1:RecordAudio("325102078", var_342_70)
					else
						arg_339_1:AudioAction("play", "voice", "story_v_out_325102", "325102078", "story_v_out_325102.awb")
					end

					arg_339_1:RecordHistoryTalkVoice("story_v_out_325102", "325102078", "story_v_out_325102.awb")
				end

				arg_339_1:RecordContent(arg_339_1.text_.text)
			end

			local var_342_71 = var_342_60 + 0.3
			local var_342_72 = math.max(var_342_61, arg_339_1.talkMaxDuration)

			if var_342_71 <= arg_339_1.time_ and arg_339_1.time_ < var_342_71 + var_342_72 then
				arg_339_1.typewritter.percent = (arg_339_1.time_ - var_342_71) / var_342_72

				arg_339_1.typewritter:SetDirty()
			end

			if arg_339_1.time_ >= var_342_71 + var_342_72 and arg_339_1.time_ < var_342_71 + var_342_72 + arg_342_0 then
				arg_339_1.typewritter.percent = 1

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(true)
			end
		end

		arg_339_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2.63333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.26666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_339_1:InitPlayNodeList()
	end,
	Play325102079 = function(arg_345_0, arg_345_1)
		arg_345_1.time_ = 0
		arg_345_1.frameCnt_ = 0
		arg_345_1.state_ = "playing"
		arg_345_1.curTalkId_ = 325102079
		arg_345_1.duration_ = 11.3

		local var_345_0 = {
			zh = 11.3,
			ja = 11
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
				arg_345_0:Play325102080(arg_345_1)
			end
		end

		function arg_345_1.onSingleLineUpdate_(arg_348_0)
			local var_348_0 = 0
			local var_348_1 = 0.975

			if var_348_0 < arg_345_1.time_ and arg_345_1.time_ <= var_348_0 + arg_348_0 then
				arg_345_1.talkMaxDuration = 0
				arg_345_1.dialogCg_.alpha = 1

				arg_345_1.dialog_:SetActive(true)
				SetActive(arg_345_1.leftNameGo_, true)

				local var_348_2 = arg_345_1:FormatText(StoryNameCfg[1467].name)

				arg_345_1.leftNameTxt_.text = var_348_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_345_1.leftNameTxt_.transform)

				arg_345_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_345_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_345_1:RecordName(arg_345_1.leftNameTxt_.text)
				SetActive(arg_345_1.iconTrs_.gameObject, false)
				arg_345_1.callingController_:SetSelectedState("normal")

				local var_348_3 = arg_345_1:GetWordFromCfg(325102079)
				local var_348_4 = arg_345_1:FormatText(var_348_3.content)

				arg_345_1.text_.text = var_348_4

				LuaForUtil.ClearLinePrefixSymbol(arg_345_1.text_)

				local var_348_5 = 39
				local var_348_6 = utf8.len(var_348_4)
				local var_348_7 = var_348_5 <= 0 and var_348_1 or var_348_1 * (var_348_6 / var_348_5)

				if var_348_7 > 0 and var_348_1 < var_348_7 then
					arg_345_1.talkMaxDuration = var_348_7

					if var_348_7 + var_348_0 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_7 + var_348_0
					end
				end

				arg_345_1.text_.text = var_348_4
				arg_345_1.typewritter.percent = 0

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325102", "325102079", "story_v_out_325102.awb") ~= 0 then
					local var_348_8 = manager.audio:GetVoiceLength("story_v_out_325102", "325102079", "story_v_out_325102.awb") / 1000

					if var_348_8 + var_348_0 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_8 + var_348_0
					end

					if var_348_3.prefab_name ~= "" and arg_345_1.actors_[var_348_3.prefab_name] ~= nil then
						local var_348_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_345_1.actors_[var_348_3.prefab_name].transform, "story_v_out_325102", "325102079", "story_v_out_325102.awb")

						arg_345_1:RecordAudio("325102079", var_348_9)
						arg_345_1:RecordAudio("325102079", var_348_9)
					else
						arg_345_1:AudioAction("play", "voice", "story_v_out_325102", "325102079", "story_v_out_325102.awb")
					end

					arg_345_1:RecordHistoryTalkVoice("story_v_out_325102", "325102079", "story_v_out_325102.awb")
				end

				arg_345_1:RecordContent(arg_345_1.text_.text)
			end

			local var_348_10 = math.max(var_348_1, arg_345_1.talkMaxDuration)

			if var_348_0 <= arg_345_1.time_ and arg_345_1.time_ < var_348_0 + var_348_10 then
				arg_345_1.typewritter.percent = (arg_345_1.time_ - var_348_0) / var_348_10

				arg_345_1.typewritter:SetDirty()
			end

			if arg_345_1.time_ >= var_348_0 + var_348_10 and arg_345_1.time_ < var_348_0 + var_348_10 + arg_348_0 then
				arg_345_1.typewritter.percent = 1

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(true)
			end
		end

		arg_345_1.nodeConfigList_ = {}

		arg_345_1:InitPlayNodeList()
	end,
	Play325102080 = function(arg_349_0, arg_349_1)
		arg_349_1.time_ = 0
		arg_349_1.frameCnt_ = 0
		arg_349_1.state_ = "playing"
		arg_349_1.curTalkId_ = 325102080
		arg_349_1.duration_ = 5

		SetActive(arg_349_1.tipsGo_, false)

		function arg_349_1.onSingleLineFinish_()
			arg_349_1.onSingleLineUpdate_ = nil
			arg_349_1.onSingleLineFinish_ = nil
			arg_349_1.state_ = "waiting"
		end

		function arg_349_1.playNext_(arg_351_0)
			if arg_351_0 == 1 then
				arg_349_0:Play325102081(arg_349_1)
			end
		end

		function arg_349_1.onSingleLineUpdate_(arg_352_0)
			local var_352_0 = arg_349_1.actors_["1059ui_story"].transform
			local var_352_1 = 0

			if var_352_1 < arg_349_1.time_ and arg_349_1.time_ <= var_352_1 + arg_352_0 then
				arg_349_1.var_.moveOldPos1059ui_story = var_352_0.localPosition
			end

			local var_352_2 = 0.001

			if var_352_1 <= arg_349_1.time_ and arg_349_1.time_ < var_352_1 + var_352_2 then
				local var_352_3 = (arg_349_1.time_ - var_352_1) / var_352_2
				local var_352_4 = Vector3.New(0, 100, 0)

				var_352_0.localPosition = Vector3.Lerp(arg_349_1.var_.moveOldPos1059ui_story, var_352_4, var_352_3)

				local var_352_5 = manager.ui.mainCamera.transform.position - var_352_0.position

				var_352_0.forward = Vector3.New(var_352_5.x, var_352_5.y, var_352_5.z)

				local var_352_6 = var_352_0.localEulerAngles

				var_352_6.z = 0
				var_352_6.x = 0
				var_352_0.localEulerAngles = var_352_6
			end

			if arg_349_1.time_ >= var_352_1 + var_352_2 and arg_349_1.time_ < var_352_1 + var_352_2 + arg_352_0 then
				var_352_0.localPosition = Vector3.New(0, 100, 0)

				local var_352_7 = manager.ui.mainCamera.transform.position - var_352_0.position

				var_352_0.forward = Vector3.New(var_352_7.x, var_352_7.y, var_352_7.z)

				local var_352_8 = var_352_0.localEulerAngles

				var_352_8.z = 0
				var_352_8.x = 0
				var_352_0.localEulerAngles = var_352_8
			end

			local var_352_9 = arg_349_1.actors_["1077ui_story"].transform
			local var_352_10 = 0

			if var_352_10 < arg_349_1.time_ and arg_349_1.time_ <= var_352_10 + arg_352_0 then
				arg_349_1.var_.moveOldPos1077ui_story = var_352_9.localPosition

				local var_352_11 = GameObjectTools.GetOrAddComponent(var_352_9.gameObject, typeof(DynamicBoneHelper))

				if var_352_11 then
					var_352_11:EnableDynamicBone(false)
				end
			end

			local var_352_12 = 0.001

			if var_352_10 <= arg_349_1.time_ and arg_349_1.time_ < var_352_10 + var_352_12 then
				local var_352_13 = (arg_349_1.time_ - var_352_10) / var_352_12
				local var_352_14 = Vector3.New(0, 100, 0)

				var_352_9.localPosition = Vector3.Lerp(arg_349_1.var_.moveOldPos1077ui_story, var_352_14, var_352_13)

				local var_352_15 = manager.ui.mainCamera.transform.position - var_352_9.position

				var_352_9.forward = Vector3.New(var_352_15.x, var_352_15.y, var_352_15.z)

				local var_352_16 = var_352_9.localEulerAngles

				var_352_16.z = 0
				var_352_16.x = 0
				var_352_9.localEulerAngles = var_352_16
			end

			if arg_349_1.time_ >= var_352_10 + var_352_12 and arg_349_1.time_ < var_352_10 + var_352_12 + arg_352_0 then
				var_352_9.localPosition = Vector3.New(0, 100, 0)

				local var_352_17 = manager.ui.mainCamera.transform.position - var_352_9.position

				var_352_9.forward = Vector3.New(var_352_17.x, var_352_17.y, var_352_17.z)

				local var_352_18 = var_352_9.localEulerAngles

				var_352_18.z = 0
				var_352_18.x = 0
				var_352_9.localEulerAngles = var_352_18

				local var_352_19 = GameObjectTools.GetOrAddComponent(var_352_9.gameObject, typeof(DynamicBoneHelper))

				if var_352_19 then
					var_352_19:EnableDynamicBone(true)
				end
			end

			local var_352_20 = arg_349_1.actors_["1077ui_story"]
			local var_352_21 = 0

			if var_352_21 < arg_349_1.time_ and arg_349_1.time_ <= var_352_21 + arg_352_0 and not isNil(var_352_20) and arg_349_1.var_.characterEffect1077ui_story == nil then
				arg_349_1.var_.characterEffect1077ui_story = var_352_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_352_22 = 0.200000002980232

			if var_352_21 <= arg_349_1.time_ and arg_349_1.time_ < var_352_21 + var_352_22 and not isNil(var_352_20) then
				local var_352_23 = (arg_349_1.time_ - var_352_21) / var_352_22

				if arg_349_1.var_.characterEffect1077ui_story and not isNil(var_352_20) then
					local var_352_24 = Mathf.Lerp(0, 0.5, var_352_23)

					arg_349_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_349_1.var_.characterEffect1077ui_story.fillRatio = var_352_24
				end
			end

			if arg_349_1.time_ >= var_352_21 + var_352_22 and arg_349_1.time_ < var_352_21 + var_352_22 + arg_352_0 and not isNil(var_352_20) and arg_349_1.var_.characterEffect1077ui_story then
				local var_352_25 = 0.5

				arg_349_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_349_1.var_.characterEffect1077ui_story.fillRatio = var_352_25
			end

			local var_352_26 = 0
			local var_352_27 = 1.075

			if var_352_26 < arg_349_1.time_ and arg_349_1.time_ <= var_352_26 + arg_352_0 then
				arg_349_1.talkMaxDuration = 0
				arg_349_1.dialogCg_.alpha = 1

				arg_349_1.dialog_:SetActive(true)
				SetActive(arg_349_1.leftNameGo_, false)

				arg_349_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_349_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_349_1:RecordName(arg_349_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_349_1.iconTrs_.gameObject, false)
				arg_349_1.callingController_:SetSelectedState("normal")

				local var_352_28 = arg_349_1:GetWordFromCfg(325102080)
				local var_352_29 = arg_349_1:FormatText(var_352_28.content)

				arg_349_1.text_.text = var_352_29

				LuaForUtil.ClearLinePrefixSymbol(arg_349_1.text_)

				local var_352_30 = 43
				local var_352_31 = utf8.len(var_352_29)
				local var_352_32 = var_352_30 <= 0 and var_352_27 or var_352_27 * (var_352_31 / var_352_30)

				if var_352_32 > 0 and var_352_27 < var_352_32 then
					arg_349_1.talkMaxDuration = var_352_32

					if var_352_32 + var_352_26 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_32 + var_352_26
					end
				end

				arg_349_1.text_.text = var_352_29
				arg_349_1.typewritter.percent = 0

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(false)
				arg_349_1:RecordContent(arg_349_1.text_.text)
			end

			local var_352_33 = math.max(var_352_27, arg_349_1.talkMaxDuration)

			if var_352_26 <= arg_349_1.time_ and arg_349_1.time_ < var_352_26 + var_352_33 then
				arg_349_1.typewritter.percent = (arg_349_1.time_ - var_352_26) / var_352_33

				arg_349_1.typewritter:SetDirty()
			end

			if arg_349_1.time_ >= var_352_26 + var_352_33 and arg_349_1.time_ < var_352_26 + var_352_33 + arg_352_0 then
				arg_349_1.typewritter.percent = 1

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(true)
			end
		end

		arg_349_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_349_1:InitPlayNodeList()
	end,
	Play325102081 = function(arg_353_0, arg_353_1)
		arg_353_1.time_ = 0
		arg_353_1.frameCnt_ = 0
		arg_353_1.state_ = "playing"
		arg_353_1.curTalkId_ = 325102081
		arg_353_1.duration_ = 5.47

		local var_353_0 = {
			zh = 4.133,
			ja = 5.466
		}
		local var_353_1 = manager.audio:GetLocalizationFlag()

		if var_353_0[var_353_1] ~= nil then
			arg_353_1.duration_ = var_353_0[var_353_1]
		end

		SetActive(arg_353_1.tipsGo_, false)

		function arg_353_1.onSingleLineFinish_()
			arg_353_1.onSingleLineUpdate_ = nil
			arg_353_1.onSingleLineFinish_ = nil
			arg_353_1.state_ = "waiting"
		end

		function arg_353_1.playNext_(arg_355_0)
			if arg_355_0 == 1 then
				arg_353_0:Play325102082(arg_353_1)
			end
		end

		function arg_353_1.onSingleLineUpdate_(arg_356_0)
			local var_356_0 = arg_353_1.actors_["1077ui_story"].transform
			local var_356_1 = 0

			if var_356_1 < arg_353_1.time_ and arg_353_1.time_ <= var_356_1 + arg_356_0 then
				arg_353_1.var_.moveOldPos1077ui_story = var_356_0.localPosition

				local var_356_2 = GameObjectTools.GetOrAddComponent(var_356_0.gameObject, typeof(DynamicBoneHelper))

				if var_356_2 then
					var_356_2:EnableDynamicBone(false)
				end
			end

			local var_356_3 = 0.001

			if var_356_1 <= arg_353_1.time_ and arg_353_1.time_ < var_356_1 + var_356_3 then
				local var_356_4 = (arg_353_1.time_ - var_356_1) / var_356_3
				local var_356_5 = Vector3.New(-0.03, -1.02, -5.92)

				var_356_0.localPosition = Vector3.Lerp(arg_353_1.var_.moveOldPos1077ui_story, var_356_5, var_356_4)

				local var_356_6 = manager.ui.mainCamera.transform.position - var_356_0.position

				var_356_0.forward = Vector3.New(var_356_6.x, var_356_6.y, var_356_6.z)

				local var_356_7 = var_356_0.localEulerAngles

				var_356_7.z = 0
				var_356_7.x = 0
				var_356_0.localEulerAngles = var_356_7
			end

			if arg_353_1.time_ >= var_356_1 + var_356_3 and arg_353_1.time_ < var_356_1 + var_356_3 + arg_356_0 then
				var_356_0.localPosition = Vector3.New(-0.03, -1.02, -5.92)

				local var_356_8 = manager.ui.mainCamera.transform.position - var_356_0.position

				var_356_0.forward = Vector3.New(var_356_8.x, var_356_8.y, var_356_8.z)

				local var_356_9 = var_356_0.localEulerAngles

				var_356_9.z = 0
				var_356_9.x = 0
				var_356_0.localEulerAngles = var_356_9

				local var_356_10 = GameObjectTools.GetOrAddComponent(var_356_0.gameObject, typeof(DynamicBoneHelper))

				if var_356_10 then
					var_356_10:EnableDynamicBone(true)
				end
			end

			local var_356_11 = arg_353_1.actors_["1077ui_story"]
			local var_356_12 = 0

			if var_356_12 < arg_353_1.time_ and arg_353_1.time_ <= var_356_12 + arg_356_0 and not isNil(var_356_11) and arg_353_1.var_.characterEffect1077ui_story == nil then
				arg_353_1.var_.characterEffect1077ui_story = var_356_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_356_13 = 0.200000002980232

			if var_356_12 <= arg_353_1.time_ and arg_353_1.time_ < var_356_12 + var_356_13 and not isNil(var_356_11) then
				local var_356_14 = (arg_353_1.time_ - var_356_12) / var_356_13

				if arg_353_1.var_.characterEffect1077ui_story and not isNil(var_356_11) then
					arg_353_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_353_1.time_ >= var_356_12 + var_356_13 and arg_353_1.time_ < var_356_12 + var_356_13 + arg_356_0 and not isNil(var_356_11) and arg_353_1.var_.characterEffect1077ui_story then
				arg_353_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_356_15 = 0

			if var_356_15 < arg_353_1.time_ and arg_353_1.time_ <= var_356_15 + arg_356_0 then
				arg_353_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action1_1")
			end

			local var_356_16 = 0

			if var_356_16 < arg_353_1.time_ and arg_353_1.time_ <= var_356_16 + arg_356_0 then
				arg_353_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_356_17 = 0
			local var_356_18 = 0.625

			if var_356_17 < arg_353_1.time_ and arg_353_1.time_ <= var_356_17 + arg_356_0 then
				arg_353_1.talkMaxDuration = 0
				arg_353_1.dialogCg_.alpha = 1

				arg_353_1.dialog_:SetActive(true)
				SetActive(arg_353_1.leftNameGo_, true)

				local var_356_19 = arg_353_1:FormatText(StoryNameCfg[1467].name)

				arg_353_1.leftNameTxt_.text = var_356_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_353_1.leftNameTxt_.transform)

				arg_353_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_353_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_353_1:RecordName(arg_353_1.leftNameTxt_.text)
				SetActive(arg_353_1.iconTrs_.gameObject, false)
				arg_353_1.callingController_:SetSelectedState("normal")

				local var_356_20 = arg_353_1:GetWordFromCfg(325102081)
				local var_356_21 = arg_353_1:FormatText(var_356_20.content)

				arg_353_1.text_.text = var_356_21

				LuaForUtil.ClearLinePrefixSymbol(arg_353_1.text_)

				local var_356_22 = 25
				local var_356_23 = utf8.len(var_356_21)
				local var_356_24 = var_356_22 <= 0 and var_356_18 or var_356_18 * (var_356_23 / var_356_22)

				if var_356_24 > 0 and var_356_18 < var_356_24 then
					arg_353_1.talkMaxDuration = var_356_24

					if var_356_24 + var_356_17 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_24 + var_356_17
					end
				end

				arg_353_1.text_.text = var_356_21
				arg_353_1.typewritter.percent = 0

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325102", "325102081", "story_v_out_325102.awb") ~= 0 then
					local var_356_25 = manager.audio:GetVoiceLength("story_v_out_325102", "325102081", "story_v_out_325102.awb") / 1000

					if var_356_25 + var_356_17 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_25 + var_356_17
					end

					if var_356_20.prefab_name ~= "" and arg_353_1.actors_[var_356_20.prefab_name] ~= nil then
						local var_356_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_353_1.actors_[var_356_20.prefab_name].transform, "story_v_out_325102", "325102081", "story_v_out_325102.awb")

						arg_353_1:RecordAudio("325102081", var_356_26)
						arg_353_1:RecordAudio("325102081", var_356_26)
					else
						arg_353_1:AudioAction("play", "voice", "story_v_out_325102", "325102081", "story_v_out_325102.awb")
					end

					arg_353_1:RecordHistoryTalkVoice("story_v_out_325102", "325102081", "story_v_out_325102.awb")
				end

				arg_353_1:RecordContent(arg_353_1.text_.text)
			end

			local var_356_27 = math.max(var_356_18, arg_353_1.talkMaxDuration)

			if var_356_17 <= arg_353_1.time_ and arg_353_1.time_ < var_356_17 + var_356_27 then
				arg_353_1.typewritter.percent = (arg_353_1.time_ - var_356_17) / var_356_27

				arg_353_1.typewritter:SetDirty()
			end

			if arg_353_1.time_ >= var_356_17 + var_356_27 and arg_353_1.time_ < var_356_17 + var_356_27 + arg_356_0 then
				arg_353_1.typewritter.percent = 1

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(true)
			end
		end

		arg_353_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_353_1:InitPlayNodeList()
	end,
	Play325102082 = function(arg_357_0, arg_357_1)
		arg_357_1.time_ = 0
		arg_357_1.frameCnt_ = 0
		arg_357_1.state_ = "playing"
		arg_357_1.curTalkId_ = 325102082
		arg_357_1.duration_ = 5

		SetActive(arg_357_1.tipsGo_, false)

		function arg_357_1.onSingleLineFinish_()
			arg_357_1.onSingleLineUpdate_ = nil
			arg_357_1.onSingleLineFinish_ = nil
			arg_357_1.state_ = "waiting"
		end

		function arg_357_1.playNext_(arg_359_0)
			if arg_359_0 == 1 then
				arg_357_0:Play325102083(arg_357_1)
			end
		end

		function arg_357_1.onSingleLineUpdate_(arg_360_0)
			local var_360_0 = arg_357_1.actors_["1077ui_story"].transform
			local var_360_1 = 0

			if var_360_1 < arg_357_1.time_ and arg_357_1.time_ <= var_360_1 + arg_360_0 then
				arg_357_1.var_.moveOldPos1077ui_story = var_360_0.localPosition

				local var_360_2 = GameObjectTools.GetOrAddComponent(var_360_0.gameObject, typeof(DynamicBoneHelper))

				if var_360_2 then
					var_360_2:EnableDynamicBone(false)
				end
			end

			local var_360_3 = 0.001

			if var_360_1 <= arg_357_1.time_ and arg_357_1.time_ < var_360_1 + var_360_3 then
				local var_360_4 = (arg_357_1.time_ - var_360_1) / var_360_3
				local var_360_5 = Vector3.New(0, 100, 0)

				var_360_0.localPosition = Vector3.Lerp(arg_357_1.var_.moveOldPos1077ui_story, var_360_5, var_360_4)

				local var_360_6 = manager.ui.mainCamera.transform.position - var_360_0.position

				var_360_0.forward = Vector3.New(var_360_6.x, var_360_6.y, var_360_6.z)

				local var_360_7 = var_360_0.localEulerAngles

				var_360_7.z = 0
				var_360_7.x = 0
				var_360_0.localEulerAngles = var_360_7
			end

			if arg_357_1.time_ >= var_360_1 + var_360_3 and arg_357_1.time_ < var_360_1 + var_360_3 + arg_360_0 then
				var_360_0.localPosition = Vector3.New(0, 100, 0)

				local var_360_8 = manager.ui.mainCamera.transform.position - var_360_0.position

				var_360_0.forward = Vector3.New(var_360_8.x, var_360_8.y, var_360_8.z)

				local var_360_9 = var_360_0.localEulerAngles

				var_360_9.z = 0
				var_360_9.x = 0
				var_360_0.localEulerAngles = var_360_9

				local var_360_10 = GameObjectTools.GetOrAddComponent(var_360_0.gameObject, typeof(DynamicBoneHelper))

				if var_360_10 then
					var_360_10:EnableDynamicBone(true)
				end
			end

			local var_360_11 = arg_357_1.actors_["1077ui_story"]
			local var_360_12 = 0

			if var_360_12 < arg_357_1.time_ and arg_357_1.time_ <= var_360_12 + arg_360_0 and not isNil(var_360_11) and arg_357_1.var_.characterEffect1077ui_story == nil then
				arg_357_1.var_.characterEffect1077ui_story = var_360_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_360_13 = 0.200000002980232

			if var_360_12 <= arg_357_1.time_ and arg_357_1.time_ < var_360_12 + var_360_13 and not isNil(var_360_11) then
				local var_360_14 = (arg_357_1.time_ - var_360_12) / var_360_13

				if arg_357_1.var_.characterEffect1077ui_story and not isNil(var_360_11) then
					local var_360_15 = Mathf.Lerp(0, 0.5, var_360_14)

					arg_357_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_357_1.var_.characterEffect1077ui_story.fillRatio = var_360_15
				end
			end

			if arg_357_1.time_ >= var_360_12 + var_360_13 and arg_357_1.time_ < var_360_12 + var_360_13 + arg_360_0 and not isNil(var_360_11) and arg_357_1.var_.characterEffect1077ui_story then
				local var_360_16 = 0.5

				arg_357_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_357_1.var_.characterEffect1077ui_story.fillRatio = var_360_16
			end

			local var_360_17 = 0
			local var_360_18 = 0.725

			if var_360_17 < arg_357_1.time_ and arg_357_1.time_ <= var_360_17 + arg_360_0 then
				arg_357_1.talkMaxDuration = 0
				arg_357_1.dialogCg_.alpha = 1

				arg_357_1.dialog_:SetActive(true)
				SetActive(arg_357_1.leftNameGo_, false)

				arg_357_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_357_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_357_1:RecordName(arg_357_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_357_1.iconTrs_.gameObject, false)
				arg_357_1.callingController_:SetSelectedState("normal")

				local var_360_19 = arg_357_1:GetWordFromCfg(325102082)
				local var_360_20 = arg_357_1:FormatText(var_360_19.content)

				arg_357_1.text_.text = var_360_20

				LuaForUtil.ClearLinePrefixSymbol(arg_357_1.text_)

				local var_360_21 = 29
				local var_360_22 = utf8.len(var_360_20)
				local var_360_23 = var_360_21 <= 0 and var_360_18 or var_360_18 * (var_360_22 / var_360_21)

				if var_360_23 > 0 and var_360_18 < var_360_23 then
					arg_357_1.talkMaxDuration = var_360_23

					if var_360_23 + var_360_17 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_23 + var_360_17
					end
				end

				arg_357_1.text_.text = var_360_20
				arg_357_1.typewritter.percent = 0

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(false)
				arg_357_1:RecordContent(arg_357_1.text_.text)
			end

			local var_360_24 = math.max(var_360_18, arg_357_1.talkMaxDuration)

			if var_360_17 <= arg_357_1.time_ and arg_357_1.time_ < var_360_17 + var_360_24 then
				arg_357_1.typewritter.percent = (arg_357_1.time_ - var_360_17) / var_360_24

				arg_357_1.typewritter:SetDirty()
			end

			if arg_357_1.time_ >= var_360_17 + var_360_24 and arg_357_1.time_ < var_360_17 + var_360_24 + arg_360_0 then
				arg_357_1.typewritter.percent = 1

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(true)
			end
		end

		arg_357_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_357_1:InitPlayNodeList()
	end,
	Play325102083 = function(arg_361_0, arg_361_1)
		arg_361_1.time_ = 0
		arg_361_1.frameCnt_ = 0
		arg_361_1.state_ = "playing"
		arg_361_1.curTalkId_ = 325102083
		arg_361_1.duration_ = 5.73

		local var_361_0 = {
			zh = 5.733,
			ja = 4.566
		}
		local var_361_1 = manager.audio:GetLocalizationFlag()

		if var_361_0[var_361_1] ~= nil then
			arg_361_1.duration_ = var_361_0[var_361_1]
		end

		SetActive(arg_361_1.tipsGo_, false)

		function arg_361_1.onSingleLineFinish_()
			arg_361_1.onSingleLineUpdate_ = nil
			arg_361_1.onSingleLineFinish_ = nil
			arg_361_1.state_ = "waiting"
			arg_361_1.auto_ = false
		end

		function arg_361_1.playNext_(arg_363_0)
			arg_361_1.onStoryFinished_()
		end

		function arg_361_1.onSingleLineUpdate_(arg_364_0)
			local var_364_0 = arg_361_1.actors_["1077ui_story"].transform
			local var_364_1 = 0

			if var_364_1 < arg_361_1.time_ and arg_361_1.time_ <= var_364_1 + arg_364_0 then
				arg_361_1.var_.moveOldPos1077ui_story = var_364_0.localPosition

				local var_364_2 = GameObjectTools.GetOrAddComponent(var_364_0.gameObject, typeof(DynamicBoneHelper))

				if var_364_2 then
					var_364_2:EnableDynamicBone(false)
				end
			end

			local var_364_3 = 0.001

			if var_364_1 <= arg_361_1.time_ and arg_361_1.time_ < var_364_1 + var_364_3 then
				local var_364_4 = (arg_361_1.time_ - var_364_1) / var_364_3
				local var_364_5 = Vector3.New(-0.03, -1.02, -5.92)

				var_364_0.localPosition = Vector3.Lerp(arg_361_1.var_.moveOldPos1077ui_story, var_364_5, var_364_4)

				local var_364_6 = manager.ui.mainCamera.transform.position - var_364_0.position

				var_364_0.forward = Vector3.New(var_364_6.x, var_364_6.y, var_364_6.z)

				local var_364_7 = var_364_0.localEulerAngles

				var_364_7.z = 0
				var_364_7.x = 0
				var_364_0.localEulerAngles = var_364_7
			end

			if arg_361_1.time_ >= var_364_1 + var_364_3 and arg_361_1.time_ < var_364_1 + var_364_3 + arg_364_0 then
				var_364_0.localPosition = Vector3.New(-0.03, -1.02, -5.92)

				local var_364_8 = manager.ui.mainCamera.transform.position - var_364_0.position

				var_364_0.forward = Vector3.New(var_364_8.x, var_364_8.y, var_364_8.z)

				local var_364_9 = var_364_0.localEulerAngles

				var_364_9.z = 0
				var_364_9.x = 0
				var_364_0.localEulerAngles = var_364_9

				local var_364_10 = GameObjectTools.GetOrAddComponent(var_364_0.gameObject, typeof(DynamicBoneHelper))

				if var_364_10 then
					var_364_10:EnableDynamicBone(true)
				end
			end

			local var_364_11 = arg_361_1.actors_["1077ui_story"]
			local var_364_12 = 0

			if var_364_12 < arg_361_1.time_ and arg_361_1.time_ <= var_364_12 + arg_364_0 and not isNil(var_364_11) and arg_361_1.var_.characterEffect1077ui_story == nil then
				arg_361_1.var_.characterEffect1077ui_story = var_364_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_364_13 = 0.200000002980232

			if var_364_12 <= arg_361_1.time_ and arg_361_1.time_ < var_364_12 + var_364_13 and not isNil(var_364_11) then
				local var_364_14 = (arg_361_1.time_ - var_364_12) / var_364_13

				if arg_361_1.var_.characterEffect1077ui_story and not isNil(var_364_11) then
					arg_361_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_361_1.time_ >= var_364_12 + var_364_13 and arg_361_1.time_ < var_364_12 + var_364_13 + arg_364_0 and not isNil(var_364_11) and arg_361_1.var_.characterEffect1077ui_story then
				arg_361_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_364_15 = 0
			local var_364_16 = 1

			if var_364_15 < arg_361_1.time_ and arg_361_1.time_ <= var_364_15 + arg_364_0 then
				local var_364_17 = "play"
				local var_364_18 = "effect"

				arg_361_1:AudioAction(var_364_17, var_364_18, "ui_battle", "ui_battle_stopbgm", "")
			end

			local var_364_19 = 0
			local var_364_20 = 0.525

			if var_364_19 < arg_361_1.time_ and arg_361_1.time_ <= var_364_19 + arg_364_0 then
				arg_361_1.talkMaxDuration = 0
				arg_361_1.dialogCg_.alpha = 1

				arg_361_1.dialog_:SetActive(true)
				SetActive(arg_361_1.leftNameGo_, true)

				local var_364_21 = arg_361_1:FormatText(StoryNameCfg[1467].name)

				arg_361_1.leftNameTxt_.text = var_364_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_361_1.leftNameTxt_.transform)

				arg_361_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_361_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_361_1:RecordName(arg_361_1.leftNameTxt_.text)
				SetActive(arg_361_1.iconTrs_.gameObject, false)
				arg_361_1.callingController_:SetSelectedState("normal")

				local var_364_22 = arg_361_1:GetWordFromCfg(325102083)
				local var_364_23 = arg_361_1:FormatText(var_364_22.content)

				arg_361_1.text_.text = var_364_23

				LuaForUtil.ClearLinePrefixSymbol(arg_361_1.text_)

				local var_364_24 = 21
				local var_364_25 = utf8.len(var_364_23)
				local var_364_26 = var_364_24 <= 0 and var_364_20 or var_364_20 * (var_364_25 / var_364_24)

				if var_364_26 > 0 and var_364_20 < var_364_26 then
					arg_361_1.talkMaxDuration = var_364_26

					if var_364_26 + var_364_19 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_26 + var_364_19
					end
				end

				arg_361_1.text_.text = var_364_23
				arg_361_1.typewritter.percent = 0

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325102", "325102083", "story_v_out_325102.awb") ~= 0 then
					local var_364_27 = manager.audio:GetVoiceLength("story_v_out_325102", "325102083", "story_v_out_325102.awb") / 1000

					if var_364_27 + var_364_19 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_27 + var_364_19
					end

					if var_364_22.prefab_name ~= "" and arg_361_1.actors_[var_364_22.prefab_name] ~= nil then
						local var_364_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_361_1.actors_[var_364_22.prefab_name].transform, "story_v_out_325102", "325102083", "story_v_out_325102.awb")

						arg_361_1:RecordAudio("325102083", var_364_28)
						arg_361_1:RecordAudio("325102083", var_364_28)
					else
						arg_361_1:AudioAction("play", "voice", "story_v_out_325102", "325102083", "story_v_out_325102.awb")
					end

					arg_361_1:RecordHistoryTalkVoice("story_v_out_325102", "325102083", "story_v_out_325102.awb")
				end

				arg_361_1:RecordContent(arg_361_1.text_.text)
			end

			local var_364_29 = math.max(var_364_20, arg_361_1.talkMaxDuration)

			if var_364_19 <= arg_361_1.time_ and arg_361_1.time_ < var_364_19 + var_364_29 then
				arg_361_1.typewritter.percent = (arg_361_1.time_ - var_364_19) / var_364_29

				arg_361_1.typewritter:SetDirty()
			end

			if arg_361_1.time_ >= var_364_19 + var_364_29 and arg_361_1.time_ < var_364_19 + var_364_29 + arg_364_0 then
				arg_361_1.typewritter.percent = 1

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(true)
			end
		end

		arg_361_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_361_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/J29g",
		"TextureConfig/Background/J22f",
		"TextureConfig/Background/J03h"
	},
	voices = {
		"story_v_out_325102.awb"
	}
}
