return {
	Play325041001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 325041001
		arg_1_1.duration_ = 6.2

		local var_1_0 = {
			zh = 6.166,
			ja = 6.2
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
				arg_1_0:Play325041002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "J24g"

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
				local var_4_5 = arg_1_1.bgs_.J24g

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
					if iter_4_0 ~= "J24g" then
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

				arg_1_1:AudioAction(var_4_26, var_4_27, "se_story_148", "se_story_148_amb_wind", "")
			end

			local var_4_28 = 1
			local var_4_29 = 1

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				local var_4_30 = "play"
				local var_4_31 = "music"

				arg_1_1:AudioAction(var_4_30, var_4_31, "bgm_activity_4_8_story_mountain_kunlun", "bgm_activity_4_8_story_mountain_kunlun", "bgm_activity_4_8_story_mountain_kunlun.awb")

				local var_4_32 = ""
				local var_4_33 = manager.audio:GetAudioName("bgm_activity_4_8_story_mountain_kunlun", "bgm_activity_4_8_story_mountain_kunlun")

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
			local var_4_35 = 0.425

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

				local var_4_37 = arg_1_1:FormatText(StoryNameCfg[1467].name)

				arg_1_1.leftNameTxt_.text = var_4_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1077")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_38 = arg_1_1:GetWordFromCfg(325041001)
				local var_4_39 = arg_1_1:FormatText(var_4_38.content)

				arg_1_1.text_.text = var_4_39

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_40 = 17
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

				if manager.audio:GetVoiceLength("story_v_out_325041", "325041001", "story_v_out_325041.awb") ~= 0 then
					local var_4_43 = manager.audio:GetVoiceLength("story_v_out_325041", "325041001", "story_v_out_325041.awb") / 1000

					if var_4_43 + var_4_34 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_43 + var_4_34
					end

					if var_4_38.prefab_name ~= "" and arg_1_1.actors_[var_4_38.prefab_name] ~= nil then
						local var_4_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_38.prefab_name].transform, "story_v_out_325041", "325041001", "story_v_out_325041.awb")

						arg_1_1:RecordAudio("325041001", var_4_44)
						arg_1_1:RecordAudio("325041001", var_4_44)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_325041", "325041001", "story_v_out_325041.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_325041", "325041001", "story_v_out_325041.awb")
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
	Play325041002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 325041002
		arg_8_1.duration_ = 4.33

		local var_8_0 = {
			zh = 2.2,
			ja = 4.333
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
				arg_8_0:Play325041003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 0
			local var_11_1 = 0.225

			if var_11_0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_0 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				local var_11_2 = arg_8_1:FormatText(StoryNameCfg[1467].name)

				arg_8_1.leftNameTxt_.text = var_11_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, true)
				arg_8_1.iconController_:SetSelectedState("hero")

				arg_8_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1077")

				arg_8_1.callingController_:SetSelectedState("normal")

				arg_8_1.keyicon_.color = Color.New(1, 1, 1)
				arg_8_1.icon_.color = Color.New(1, 1, 1)

				local var_11_3 = arg_8_1:GetWordFromCfg(325041002)
				local var_11_4 = arg_8_1:FormatText(var_11_3.content)

				arg_8_1.text_.text = var_11_4

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_5 = 9
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

				if manager.audio:GetVoiceLength("story_v_out_325041", "325041002", "story_v_out_325041.awb") ~= 0 then
					local var_11_8 = manager.audio:GetVoiceLength("story_v_out_325041", "325041002", "story_v_out_325041.awb") / 1000

					if var_11_8 + var_11_0 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_8 + var_11_0
					end

					if var_11_3.prefab_name ~= "" and arg_8_1.actors_[var_11_3.prefab_name] ~= nil then
						local var_11_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_3.prefab_name].transform, "story_v_out_325041", "325041002", "story_v_out_325041.awb")

						arg_8_1:RecordAudio("325041002", var_11_9)
						arg_8_1:RecordAudio("325041002", var_11_9)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_325041", "325041002", "story_v_out_325041.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_325041", "325041002", "story_v_out_325041.awb")
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
	Play325041003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 325041003
		arg_12_1.duration_ = 5.3

		local var_12_0 = {
			zh = 4.133,
			ja = 5.3
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
				arg_12_0:Play325041004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 0
			local var_15_1 = 0.375

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

				local var_15_3 = arg_12_1:GetWordFromCfg(325041003)
				local var_15_4 = arg_12_1:FormatText(var_15_3.content)

				arg_12_1.text_.text = var_15_4

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_5 = 15
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

				if manager.audio:GetVoiceLength("story_v_out_325041", "325041003", "story_v_out_325041.awb") ~= 0 then
					local var_15_8 = manager.audio:GetVoiceLength("story_v_out_325041", "325041003", "story_v_out_325041.awb") / 1000

					if var_15_8 + var_15_0 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_8 + var_15_0
					end

					if var_15_3.prefab_name ~= "" and arg_12_1.actors_[var_15_3.prefab_name] ~= nil then
						local var_15_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_3.prefab_name].transform, "story_v_out_325041", "325041003", "story_v_out_325041.awb")

						arg_12_1:RecordAudio("325041003", var_15_9)
						arg_12_1:RecordAudio("325041003", var_15_9)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_325041", "325041003", "story_v_out_325041.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_325041", "325041003", "story_v_out_325041.awb")
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
	Play325041004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 325041004
		arg_16_1.duration_ = 6.77

		local var_16_0 = {
			zh = 6.766,
			ja = 6.5
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
				arg_16_0:Play325041005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = 0
			local var_19_1 = 0.675

			if var_19_0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_0 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				local var_19_2 = arg_16_1:FormatText(StoryNameCfg[1467].name)

				arg_16_1.leftNameTxt_.text = var_19_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, true)
				arg_16_1.iconController_:SetSelectedState("hero")

				arg_16_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1077")

				arg_16_1.callingController_:SetSelectedState("normal")

				arg_16_1.keyicon_.color = Color.New(1, 1, 1)
				arg_16_1.icon_.color = Color.New(1, 1, 1)

				local var_19_3 = arg_16_1:GetWordFromCfg(325041004)
				local var_19_4 = arg_16_1:FormatText(var_19_3.content)

				arg_16_1.text_.text = var_19_4

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_5 = 27
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

				if manager.audio:GetVoiceLength("story_v_out_325041", "325041004", "story_v_out_325041.awb") ~= 0 then
					local var_19_8 = manager.audio:GetVoiceLength("story_v_out_325041", "325041004", "story_v_out_325041.awb") / 1000

					if var_19_8 + var_19_0 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_8 + var_19_0
					end

					if var_19_3.prefab_name ~= "" and arg_16_1.actors_[var_19_3.prefab_name] ~= nil then
						local var_19_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_3.prefab_name].transform, "story_v_out_325041", "325041004", "story_v_out_325041.awb")

						arg_16_1:RecordAudio("325041004", var_19_9)
						arg_16_1:RecordAudio("325041004", var_19_9)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_325041", "325041004", "story_v_out_325041.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_325041", "325041004", "story_v_out_325041.awb")
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
	Play325041005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 325041005
		arg_20_1.duration_ = 5

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play325041006(arg_20_1)
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

			local var_23_16 = arg_20_1.actors_["1077ui_story"]
			local var_23_17 = 0

			if var_23_17 < arg_20_1.time_ and arg_20_1.time_ <= var_23_17 + arg_23_0 and not isNil(var_23_16) and arg_20_1.var_.characterEffect1077ui_story == nil then
				arg_20_1.var_.characterEffect1077ui_story = var_23_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_18 = 0.200000002980232

			if var_23_17 <= arg_20_1.time_ and arg_20_1.time_ < var_23_17 + var_23_18 and not isNil(var_23_16) then
				local var_23_19 = (arg_20_1.time_ - var_23_17) / var_23_18

				if arg_20_1.var_.characterEffect1077ui_story and not isNil(var_23_16) then
					local var_23_20 = Mathf.Lerp(0, 0.5, var_23_19)

					arg_20_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_20_1.var_.characterEffect1077ui_story.fillRatio = var_23_20
				end
			end

			if arg_20_1.time_ >= var_23_17 + var_23_18 and arg_20_1.time_ < var_23_17 + var_23_18 + arg_23_0 and not isNil(var_23_16) and arg_20_1.var_.characterEffect1077ui_story then
				local var_23_21 = 0.5

				arg_20_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_20_1.var_.characterEffect1077ui_story.fillRatio = var_23_21
			end

			local var_23_22 = 0
			local var_23_23 = 1.05

			if var_23_22 < arg_20_1.time_ and arg_20_1.time_ <= var_23_22 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, false)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_24 = arg_20_1:GetWordFromCfg(325041005)
				local var_23_25 = arg_20_1:FormatText(var_23_24.content)

				arg_20_1.text_.text = var_23_25

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_26 = 42
				local var_23_27 = utf8.len(var_23_25)
				local var_23_28 = var_23_26 <= 0 and var_23_23 or var_23_23 * (var_23_27 / var_23_26)

				if var_23_28 > 0 and var_23_23 < var_23_28 then
					arg_20_1.talkMaxDuration = var_23_28

					if var_23_28 + var_23_22 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_28 + var_23_22
					end
				end

				arg_20_1.text_.text = var_23_25
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)
				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_29 = math.max(var_23_23, arg_20_1.talkMaxDuration)

			if var_23_22 <= arg_20_1.time_ and arg_20_1.time_ < var_23_22 + var_23_29 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_22) / var_23_29

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_22 + var_23_29 and arg_20_1.time_ < var_23_22 + var_23_29 + arg_23_0 then
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
	Play325041006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 325041006
		arg_24_1.duration_ = 5

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play325041007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = 0
			local var_27_1 = 0.925

			if var_27_0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_0 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, false)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_2 = arg_24_1:GetWordFromCfg(325041006)
				local var_27_3 = arg_24_1:FormatText(var_27_2.content)

				arg_24_1.text_.text = var_27_3

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_4 = 38
				local var_27_5 = utf8.len(var_27_3)
				local var_27_6 = var_27_4 <= 0 and var_27_1 or var_27_1 * (var_27_5 / var_27_4)

				if var_27_6 > 0 and var_27_1 < var_27_6 then
					arg_24_1.talkMaxDuration = var_27_6

					if var_27_6 + var_27_0 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_6 + var_27_0
					end
				end

				arg_24_1.text_.text = var_27_3
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)
				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_7 = math.max(var_27_1, arg_24_1.talkMaxDuration)

			if var_27_0 <= arg_24_1.time_ and arg_24_1.time_ < var_27_0 + var_27_7 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_0) / var_27_7

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_0 + var_27_7 and arg_24_1.time_ < var_27_0 + var_27_7 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play325041007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 325041007
		arg_28_1.duration_ = 9.1

		local var_28_0 = {
			zh = 9.1,
			ja = 8.566
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
				arg_28_0:Play325041008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = arg_28_1.actors_["1077ui_story"].transform
			local var_31_1 = 0

			if var_31_1 < arg_28_1.time_ and arg_28_1.time_ <= var_31_1 + arg_31_0 then
				arg_28_1.var_.moveOldPos1077ui_story = var_31_0.localPosition

				local var_31_2 = GameObjectTools.GetOrAddComponent(var_31_0.gameObject, typeof(DynamicBoneHelper))

				if var_31_2 then
					var_31_2:EnableDynamicBone(false)
				end
			end

			local var_31_3 = 0.001

			if var_31_1 <= arg_28_1.time_ and arg_28_1.time_ < var_31_1 + var_31_3 then
				local var_31_4 = (arg_28_1.time_ - var_31_1) / var_31_3
				local var_31_5 = Vector3.New(-0.03, -1.02, -5.92)

				var_31_0.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos1077ui_story, var_31_5, var_31_4)

				local var_31_6 = manager.ui.mainCamera.transform.position - var_31_0.position

				var_31_0.forward = Vector3.New(var_31_6.x, var_31_6.y, var_31_6.z)

				local var_31_7 = var_31_0.localEulerAngles

				var_31_7.z = 0
				var_31_7.x = 0
				var_31_0.localEulerAngles = var_31_7
			end

			if arg_28_1.time_ >= var_31_1 + var_31_3 and arg_28_1.time_ < var_31_1 + var_31_3 + arg_31_0 then
				var_31_0.localPosition = Vector3.New(-0.03, -1.02, -5.92)

				local var_31_8 = manager.ui.mainCamera.transform.position - var_31_0.position

				var_31_0.forward = Vector3.New(var_31_8.x, var_31_8.y, var_31_8.z)

				local var_31_9 = var_31_0.localEulerAngles

				var_31_9.z = 0
				var_31_9.x = 0
				var_31_0.localEulerAngles = var_31_9

				local var_31_10 = GameObjectTools.GetOrAddComponent(var_31_0.gameObject, typeof(DynamicBoneHelper))

				if var_31_10 then
					var_31_10:EnableDynamicBone(true)
				end
			end

			local var_31_11 = arg_28_1.actors_["1077ui_story"]
			local var_31_12 = 0

			if var_31_12 < arg_28_1.time_ and arg_28_1.time_ <= var_31_12 + arg_31_0 and not isNil(var_31_11) and arg_28_1.var_.characterEffect1077ui_story == nil then
				arg_28_1.var_.characterEffect1077ui_story = var_31_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_13 = 0.200000002980232

			if var_31_12 <= arg_28_1.time_ and arg_28_1.time_ < var_31_12 + var_31_13 and not isNil(var_31_11) then
				local var_31_14 = (arg_28_1.time_ - var_31_12) / var_31_13

				if arg_28_1.var_.characterEffect1077ui_story and not isNil(var_31_11) then
					arg_28_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_28_1.time_ >= var_31_12 + var_31_13 and arg_28_1.time_ < var_31_12 + var_31_13 + arg_31_0 and not isNil(var_31_11) and arg_28_1.var_.characterEffect1077ui_story then
				arg_28_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_31_15 = 0

			if var_31_15 < arg_28_1.time_ and arg_28_1.time_ <= var_31_15 + arg_31_0 then
				arg_28_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action8_1")
			end

			local var_31_16 = 0

			if var_31_16 < arg_28_1.time_ and arg_28_1.time_ <= var_31_16 + arg_31_0 then
				arg_28_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_31_17 = 0
			local var_31_18 = 0.575

			if var_31_17 < arg_28_1.time_ and arg_28_1.time_ <= var_31_17 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				local var_31_19 = arg_28_1:FormatText(StoryNameCfg[1467].name)

				arg_28_1.leftNameTxt_.text = var_31_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_20 = arg_28_1:GetWordFromCfg(325041007)
				local var_31_21 = arg_28_1:FormatText(var_31_20.content)

				arg_28_1.text_.text = var_31_21

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_22 = 23
				local var_31_23 = utf8.len(var_31_21)
				local var_31_24 = var_31_22 <= 0 and var_31_18 or var_31_18 * (var_31_23 / var_31_22)

				if var_31_24 > 0 and var_31_18 < var_31_24 then
					arg_28_1.talkMaxDuration = var_31_24

					if var_31_24 + var_31_17 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_24 + var_31_17
					end
				end

				arg_28_1.text_.text = var_31_21
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325041", "325041007", "story_v_out_325041.awb") ~= 0 then
					local var_31_25 = manager.audio:GetVoiceLength("story_v_out_325041", "325041007", "story_v_out_325041.awb") / 1000

					if var_31_25 + var_31_17 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_25 + var_31_17
					end

					if var_31_20.prefab_name ~= "" and arg_28_1.actors_[var_31_20.prefab_name] ~= nil then
						local var_31_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_20.prefab_name].transform, "story_v_out_325041", "325041007", "story_v_out_325041.awb")

						arg_28_1:RecordAudio("325041007", var_31_26)
						arg_28_1:RecordAudio("325041007", var_31_26)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_325041", "325041007", "story_v_out_325041.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_325041", "325041007", "story_v_out_325041.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_27 = math.max(var_31_18, arg_28_1.talkMaxDuration)

			if var_31_17 <= arg_28_1.time_ and arg_28_1.time_ < var_31_17 + var_31_27 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_17) / var_31_27

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_17 + var_31_27 and arg_28_1.time_ < var_31_17 + var_31_27 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {
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

		arg_28_1:InitPlayNodeList()
	end,
	Play325041008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 325041008
		arg_32_1.duration_ = 5

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play325041009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = arg_32_1.actors_["1077ui_story"]
			local var_35_1 = 0

			if var_35_1 < arg_32_1.time_ and arg_32_1.time_ <= var_35_1 + arg_35_0 and not isNil(var_35_0) and arg_32_1.var_.characterEffect1077ui_story == nil then
				arg_32_1.var_.characterEffect1077ui_story = var_35_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_2 = 0.200000002980232

			if var_35_1 <= arg_32_1.time_ and arg_32_1.time_ < var_35_1 + var_35_2 and not isNil(var_35_0) then
				local var_35_3 = (arg_32_1.time_ - var_35_1) / var_35_2

				if arg_32_1.var_.characterEffect1077ui_story and not isNil(var_35_0) then
					local var_35_4 = Mathf.Lerp(0, 0.5, var_35_3)

					arg_32_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_32_1.var_.characterEffect1077ui_story.fillRatio = var_35_4
				end
			end

			if arg_32_1.time_ >= var_35_1 + var_35_2 and arg_32_1.time_ < var_35_1 + var_35_2 + arg_35_0 and not isNil(var_35_0) and arg_32_1.var_.characterEffect1077ui_story then
				local var_35_5 = 0.5

				arg_32_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_32_1.var_.characterEffect1077ui_story.fillRatio = var_35_5
			end

			local var_35_6 = 0
			local var_35_7 = 0.75

			if var_35_6 < arg_32_1.time_ and arg_32_1.time_ <= var_35_6 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, false)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_8 = arg_32_1:GetWordFromCfg(325041008)
				local var_35_9 = arg_32_1:FormatText(var_35_8.content)

				arg_32_1.text_.text = var_35_9

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_10 = 30
				local var_35_11 = utf8.len(var_35_9)
				local var_35_12 = var_35_10 <= 0 and var_35_7 or var_35_7 * (var_35_11 / var_35_10)

				if var_35_12 > 0 and var_35_7 < var_35_12 then
					arg_32_1.talkMaxDuration = var_35_12

					if var_35_12 + var_35_6 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_12 + var_35_6
					end
				end

				arg_32_1.text_.text = var_35_9
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)
				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_13 = math.max(var_35_7, arg_32_1.talkMaxDuration)

			if var_35_6 <= arg_32_1.time_ and arg_32_1.time_ < var_35_6 + var_35_13 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_6) / var_35_13

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_6 + var_35_13 and arg_32_1.time_ < var_35_6 + var_35_13 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play325041009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 325041009
		arg_36_1.duration_ = 7.33

		local var_36_0 = {
			zh = 7.333,
			ja = 5.366
		}
		local var_36_1 = manager.audio:GetLocalizationFlag()

		if var_36_0[var_36_1] ~= nil then
			arg_36_1.duration_ = var_36_0[var_36_1]
		end

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play325041010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = arg_36_1.actors_["1077ui_story"]
			local var_39_1 = 0

			if var_39_1 < arg_36_1.time_ and arg_36_1.time_ <= var_39_1 + arg_39_0 and not isNil(var_39_0) and arg_36_1.var_.characterEffect1077ui_story == nil then
				arg_36_1.var_.characterEffect1077ui_story = var_39_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_2 = 0.200000002980232

			if var_39_1 <= arg_36_1.time_ and arg_36_1.time_ < var_39_1 + var_39_2 and not isNil(var_39_0) then
				local var_39_3 = (arg_36_1.time_ - var_39_1) / var_39_2

				if arg_36_1.var_.characterEffect1077ui_story and not isNil(var_39_0) then
					arg_36_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_36_1.time_ >= var_39_1 + var_39_2 and arg_36_1.time_ < var_39_1 + var_39_2 + arg_39_0 and not isNil(var_39_0) and arg_36_1.var_.characterEffect1077ui_story then
				arg_36_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_39_4 = 0

			if var_39_4 < arg_36_1.time_ and arg_36_1.time_ <= var_39_4 + arg_39_0 then
				arg_36_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action8_2")
			end

			local var_39_5 = 0
			local var_39_6 = 0.7

			if var_39_5 < arg_36_1.time_ and arg_36_1.time_ <= var_39_5 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				local var_39_7 = arg_36_1:FormatText(StoryNameCfg[1467].name)

				arg_36_1.leftNameTxt_.text = var_39_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_8 = arg_36_1:GetWordFromCfg(325041009)
				local var_39_9 = arg_36_1:FormatText(var_39_8.content)

				arg_36_1.text_.text = var_39_9

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_10 = 28
				local var_39_11 = utf8.len(var_39_9)
				local var_39_12 = var_39_10 <= 0 and var_39_6 or var_39_6 * (var_39_11 / var_39_10)

				if var_39_12 > 0 and var_39_6 < var_39_12 then
					arg_36_1.talkMaxDuration = var_39_12

					if var_39_12 + var_39_5 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_12 + var_39_5
					end
				end

				arg_36_1.text_.text = var_39_9
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325041", "325041009", "story_v_out_325041.awb") ~= 0 then
					local var_39_13 = manager.audio:GetVoiceLength("story_v_out_325041", "325041009", "story_v_out_325041.awb") / 1000

					if var_39_13 + var_39_5 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_13 + var_39_5
					end

					if var_39_8.prefab_name ~= "" and arg_36_1.actors_[var_39_8.prefab_name] ~= nil then
						local var_39_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_8.prefab_name].transform, "story_v_out_325041", "325041009", "story_v_out_325041.awb")

						arg_36_1:RecordAudio("325041009", var_39_14)
						arg_36_1:RecordAudio("325041009", var_39_14)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_325041", "325041009", "story_v_out_325041.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_325041", "325041009", "story_v_out_325041.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_15 = math.max(var_39_6, arg_36_1.talkMaxDuration)

			if var_39_5 <= arg_36_1.time_ and arg_36_1.time_ < var_39_5 + var_39_15 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_5) / var_39_15

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_5 + var_39_15 and arg_36_1.time_ < var_39_5 + var_39_15 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play325041010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 325041010
		arg_40_1.duration_ = 5

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play325041011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = arg_40_1.actors_["1077ui_story"].transform
			local var_43_1 = 0

			if var_43_1 < arg_40_1.time_ and arg_40_1.time_ <= var_43_1 + arg_43_0 then
				arg_40_1.var_.moveOldPos1077ui_story = var_43_0.localPosition

				local var_43_2 = GameObjectTools.GetOrAddComponent(var_43_0.gameObject, typeof(DynamicBoneHelper))

				if var_43_2 then
					var_43_2:EnableDynamicBone(false)
				end
			end

			local var_43_3 = 0.001

			if var_43_1 <= arg_40_1.time_ and arg_40_1.time_ < var_43_1 + var_43_3 then
				local var_43_4 = (arg_40_1.time_ - var_43_1) / var_43_3
				local var_43_5 = Vector3.New(0, 100, 0)

				var_43_0.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos1077ui_story, var_43_5, var_43_4)

				local var_43_6 = manager.ui.mainCamera.transform.position - var_43_0.position

				var_43_0.forward = Vector3.New(var_43_6.x, var_43_6.y, var_43_6.z)

				local var_43_7 = var_43_0.localEulerAngles

				var_43_7.z = 0
				var_43_7.x = 0
				var_43_0.localEulerAngles = var_43_7
			end

			if arg_40_1.time_ >= var_43_1 + var_43_3 and arg_40_1.time_ < var_43_1 + var_43_3 + arg_43_0 then
				var_43_0.localPosition = Vector3.New(0, 100, 0)

				local var_43_8 = manager.ui.mainCamera.transform.position - var_43_0.position

				var_43_0.forward = Vector3.New(var_43_8.x, var_43_8.y, var_43_8.z)

				local var_43_9 = var_43_0.localEulerAngles

				var_43_9.z = 0
				var_43_9.x = 0
				var_43_0.localEulerAngles = var_43_9

				local var_43_10 = GameObjectTools.GetOrAddComponent(var_43_0.gameObject, typeof(DynamicBoneHelper))

				if var_43_10 then
					var_43_10:EnableDynamicBone(true)
				end
			end

			local var_43_11 = arg_40_1.actors_["1077ui_story"]
			local var_43_12 = 0

			if var_43_12 < arg_40_1.time_ and arg_40_1.time_ <= var_43_12 + arg_43_0 and not isNil(var_43_11) and arg_40_1.var_.characterEffect1077ui_story == nil then
				arg_40_1.var_.characterEffect1077ui_story = var_43_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_13 = 0.200000002980232

			if var_43_12 <= arg_40_1.time_ and arg_40_1.time_ < var_43_12 + var_43_13 and not isNil(var_43_11) then
				local var_43_14 = (arg_40_1.time_ - var_43_12) / var_43_13

				if arg_40_1.var_.characterEffect1077ui_story and not isNil(var_43_11) then
					local var_43_15 = Mathf.Lerp(0, 0.5, var_43_14)

					arg_40_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_40_1.var_.characterEffect1077ui_story.fillRatio = var_43_15
				end
			end

			if arg_40_1.time_ >= var_43_12 + var_43_13 and arg_40_1.time_ < var_43_12 + var_43_13 + arg_43_0 and not isNil(var_43_11) and arg_40_1.var_.characterEffect1077ui_story then
				local var_43_16 = 0.5

				arg_40_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_40_1.var_.characterEffect1077ui_story.fillRatio = var_43_16
			end

			local var_43_17 = 0

			if var_43_17 < arg_40_1.time_ and arg_40_1.time_ <= var_43_17 + arg_43_0 then
				arg_40_1.allBtn_.enabled = false
			end

			local var_43_18 = 1.43333333333333

			if arg_40_1.time_ >= var_43_17 + var_43_18 and arg_40_1.time_ < var_43_17 + var_43_18 + arg_43_0 then
				arg_40_1.allBtn_.enabled = true
			end

			local var_43_19 = 0.1
			local var_43_20 = 1

			if var_43_19 < arg_40_1.time_ and arg_40_1.time_ <= var_43_19 + arg_43_0 then
				local var_43_21 = "play"
				local var_43_22 = "effect"

				arg_40_1:AudioAction(var_43_21, var_43_22, "se_story_151", "se_story_151_open", "")
			end

			local var_43_23 = 0
			local var_43_24 = 0.85

			if var_43_23 < arg_40_1.time_ and arg_40_1.time_ <= var_43_23 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, false)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_25 = arg_40_1:GetWordFromCfg(325041010)
				local var_43_26 = arg_40_1:FormatText(var_43_25.content)

				arg_40_1.text_.text = var_43_26

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_27 = 34
				local var_43_28 = utf8.len(var_43_26)
				local var_43_29 = var_43_27 <= 0 and var_43_24 or var_43_24 * (var_43_28 / var_43_27)

				if var_43_29 > 0 and var_43_24 < var_43_29 then
					arg_40_1.talkMaxDuration = var_43_29

					if var_43_29 + var_43_23 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_29 + var_43_23
					end
				end

				arg_40_1.text_.text = var_43_26
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)
				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_30 = math.max(var_43_24, arg_40_1.talkMaxDuration)

			if var_43_23 <= arg_40_1.time_ and arg_40_1.time_ < var_43_23 + var_43_30 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_23) / var_43_30

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_23 + var_43_30 and arg_40_1.time_ < var_43_23 + var_43_30 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {
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
				frequency = 10,
				className = "StoryShakeNode",
				duration = 0.933333333333333,
				startTime = 0.200000002980232,
				actorType = StoryPlayerConst.ACTOR_TYPE.None,
				shakeTarget = StoryPlayerConst.SHAKE_TARGET.DIALOG,
				offset = Vector3.New(5, 0.1, 0.1)
			}
		}

		arg_40_1:InitPlayNodeList()
	end,
	Play325041011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 325041011
		arg_44_1.duration_ = 7.8

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play325041012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = "ST2005"

			if arg_44_1.bgs_[var_47_0] == nil then
				local var_47_1 = Object.Instantiate(arg_44_1.paintGo_)

				var_47_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_47_0)
				var_47_1.name = var_47_0
				var_47_1.transform.parent = arg_44_1.stage_.transform
				var_47_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_44_1.bgs_[var_47_0] = var_47_1
			end

			local var_47_2 = 0.9

			if var_47_2 < arg_44_1.time_ and arg_44_1.time_ <= var_47_2 + arg_47_0 then
				local var_47_3 = manager.ui.mainCamera.transform.localPosition
				local var_47_4 = Vector3.New(0, 0, 10) + Vector3.New(var_47_3.x, var_47_3.y, 0)
				local var_47_5 = arg_44_1.bgs_.ST2005

				var_47_5.transform.localPosition = var_47_4
				var_47_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_47_6 = var_47_5:GetComponent("SpriteRenderer")

				if var_47_6 and var_47_6.sprite then
					local var_47_7 = (var_47_5.transform.localPosition - var_47_3).z
					local var_47_8 = manager.ui.mainCameraCom_
					local var_47_9 = 2 * var_47_7 * Mathf.Tan(var_47_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_47_10 = var_47_9 * var_47_8.aspect
					local var_47_11 = var_47_6.sprite.bounds.size.x
					local var_47_12 = var_47_6.sprite.bounds.size.y
					local var_47_13 = var_47_10 / var_47_11
					local var_47_14 = var_47_9 / var_47_12
					local var_47_15 = var_47_14 < var_47_13 and var_47_13 or var_47_14

					var_47_5.transform.localScale = Vector3.New(var_47_15, var_47_15, 0)
				end

				for iter_47_0, iter_47_1 in pairs(arg_44_1.bgs_) do
					if iter_47_0 ~= "ST2005" then
						iter_47_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_47_16 = 0

			if var_47_16 < arg_44_1.time_ and arg_44_1.time_ <= var_47_16 + arg_47_0 then
				arg_44_1.allBtn_.enabled = false
			end

			local var_47_17 = 0.3

			if arg_44_1.time_ >= var_47_16 + var_47_17 and arg_44_1.time_ < var_47_16 + var_47_17 + arg_47_0 then
				arg_44_1.allBtn_.enabled = true
			end

			local var_47_18 = 0

			if var_47_18 < arg_44_1.time_ and arg_44_1.time_ <= var_47_18 + arg_47_0 then
				arg_44_1.mask_.enabled = true
				arg_44_1.mask_.raycastTarget = true

				arg_44_1:SetGaussion(false)
			end

			local var_47_19 = 0.9

			if var_47_18 <= arg_44_1.time_ and arg_44_1.time_ < var_47_18 + var_47_19 then
				local var_47_20 = (arg_44_1.time_ - var_47_18) / var_47_19
				local var_47_21 = Color.New(0, 0, 0)

				var_47_21.a = Mathf.Lerp(0, 1, var_47_20)
				arg_44_1.mask_.color = var_47_21
			end

			if arg_44_1.time_ >= var_47_18 + var_47_19 and arg_44_1.time_ < var_47_18 + var_47_19 + arg_47_0 then
				local var_47_22 = Color.New(0, 0, 0)

				var_47_22.a = 1
				arg_44_1.mask_.color = var_47_22
			end

			local var_47_23 = 0.9

			if var_47_23 < arg_44_1.time_ and arg_44_1.time_ <= var_47_23 + arg_47_0 then
				arg_44_1.mask_.enabled = true
				arg_44_1.mask_.raycastTarget = true

				arg_44_1:SetGaussion(false)
			end

			local var_47_24 = 1.9

			if var_47_23 <= arg_44_1.time_ and arg_44_1.time_ < var_47_23 + var_47_24 then
				local var_47_25 = (arg_44_1.time_ - var_47_23) / var_47_24
				local var_47_26 = Color.New(0, 0, 0)

				var_47_26.a = Mathf.Lerp(1, 0, var_47_25)
				arg_44_1.mask_.color = var_47_26
			end

			if arg_44_1.time_ >= var_47_23 + var_47_24 and arg_44_1.time_ < var_47_23 + var_47_24 + arg_47_0 then
				local var_47_27 = Color.New(0, 0, 0)
				local var_47_28 = 0

				arg_44_1.mask_.enabled = false
				var_47_27.a = var_47_28
				arg_44_1.mask_.color = var_47_27
			end

			local var_47_29 = 1.2
			local var_47_30 = 1

			if var_47_29 < arg_44_1.time_ and arg_44_1.time_ <= var_47_29 + arg_47_0 then
				local var_47_31 = "play"
				local var_47_32 = "effect"

				arg_44_1:AudioAction(var_47_31, var_47_32, "se_story_148", "se_story_148_amb_ice_cave", "")
			end

			local var_47_33 = 0.1
			local var_47_34 = 1

			if var_47_33 < arg_44_1.time_ and arg_44_1.time_ <= var_47_33 + arg_47_0 then
				local var_47_35 = "stop"
				local var_47_36 = "effect"

				arg_44_1:AudioAction(var_47_35, var_47_36, "se_story_148", "se_story_148_amb_wind", "")
			end

			if arg_44_1.frameCnt_ <= 1 then
				arg_44_1.dialog_:SetActive(false)
			end

			local var_47_37 = 2.8
			local var_47_38 = 0.8

			if var_47_37 < arg_44_1.time_ and arg_44_1.time_ <= var_47_37 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0

				arg_44_1.dialog_:SetActive(true)

				arg_44_1.dialogCg_.alpha = 0

				local var_47_39 = LeanTween.value(arg_44_1.dialog_, 0, 1, 0.3)

				var_47_39:setOnUpdate(LuaHelper.FloatAction(function(arg_48_0)
					arg_44_1.dialogCg_.alpha = arg_48_0
				end))
				var_47_39:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_44_1.dialog_)
					var_47_39:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_44_1.duration_ = arg_44_1.duration_ + 0.3

				SetActive(arg_44_1.leftNameGo_, false)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_40 = arg_44_1:GetWordFromCfg(325041011)
				local var_47_41 = arg_44_1:FormatText(var_47_40.content)

				arg_44_1.text_.text = var_47_41

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_42 = 32
				local var_47_43 = utf8.len(var_47_41)
				local var_47_44 = var_47_42 <= 0 and var_47_38 or var_47_38 * (var_47_43 / var_47_42)

				if var_47_44 > 0 and var_47_38 < var_47_44 then
					arg_44_1.talkMaxDuration = var_47_44
					var_47_37 = var_47_37 + 0.3

					if var_47_44 + var_47_37 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_44 + var_47_37
					end
				end

				arg_44_1.text_.text = var_47_41
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)
				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_45 = var_47_37 + 0.3
			local var_47_46 = math.max(var_47_38, arg_44_1.talkMaxDuration)

			if var_47_45 <= arg_44_1.time_ and arg_44_1.time_ < var_47_45 + var_47_46 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_45) / var_47_46

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_45 + var_47_46 and arg_44_1.time_ < var_47_45 + var_47_46 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play325041012 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 325041012
		arg_50_1.duration_ = 5

		SetActive(arg_50_1.tipsGo_, false)

		function arg_50_1.onSingleLineFinish_()
			arg_50_1.onSingleLineUpdate_ = nil
			arg_50_1.onSingleLineFinish_ = nil
			arg_50_1.state_ = "waiting"
		end

		function arg_50_1.playNext_(arg_52_0)
			if arg_52_0 == 1 then
				arg_50_0:Play325041013(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			local var_53_0 = 0
			local var_53_1 = 1.35

			if var_53_0 < arg_50_1.time_ and arg_50_1.time_ <= var_53_0 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, false)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_50_1.iconTrs_.gameObject, false)
				arg_50_1.callingController_:SetSelectedState("normal")

				local var_53_2 = arg_50_1:GetWordFromCfg(325041012)
				local var_53_3 = arg_50_1:FormatText(var_53_2.content)

				arg_50_1.text_.text = var_53_3

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_4 = 54
				local var_53_5 = utf8.len(var_53_3)
				local var_53_6 = var_53_4 <= 0 and var_53_1 or var_53_1 * (var_53_5 / var_53_4)

				if var_53_6 > 0 and var_53_1 < var_53_6 then
					arg_50_1.talkMaxDuration = var_53_6

					if var_53_6 + var_53_0 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_6 + var_53_0
					end
				end

				arg_50_1.text_.text = var_53_3
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)
				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_7 = math.max(var_53_1, arg_50_1.talkMaxDuration)

			if var_53_0 <= arg_50_1.time_ and arg_50_1.time_ < var_53_0 + var_53_7 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - var_53_0) / var_53_7

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= var_53_0 + var_53_7 and arg_50_1.time_ < var_53_0 + var_53_7 + arg_53_0 then
				arg_50_1.typewritter.percent = 1

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(true)
			end
		end

		arg_50_1.nodeConfigList_ = {}

		arg_50_1:InitPlayNodeList()
	end,
	Play325041013 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 325041013
		arg_54_1.duration_ = 2.63

		local var_54_0 = {
			zh = 1.4,
			ja = 2.633
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
				arg_54_0:Play325041014(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			local var_57_0 = 0
			local var_57_1 = 0.1

			if var_57_0 < arg_54_1.time_ and arg_54_1.time_ <= var_57_0 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, true)

				local var_57_2 = arg_54_1:FormatText(StoryNameCfg[1454].name)

				arg_54_1.leftNameTxt_.text = var_57_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_54_1.leftNameTxt_.transform)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1.leftNameTxt_.text)
				SetActive(arg_54_1.iconTrs_.gameObject, true)
				arg_54_1.iconController_:SetSelectedState("hero")

				arg_54_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10169")

				arg_54_1.callingController_:SetSelectedState("normal")

				arg_54_1.keyicon_.color = Color.New(1, 1, 1)
				arg_54_1.icon_.color = Color.New(1, 1, 1)

				local var_57_3 = arg_54_1:GetWordFromCfg(325041013)
				local var_57_4 = arg_54_1:FormatText(var_57_3.content)

				arg_54_1.text_.text = var_57_4

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_5 = 4
				local var_57_6 = utf8.len(var_57_4)
				local var_57_7 = var_57_5 <= 0 and var_57_1 or var_57_1 * (var_57_6 / var_57_5)

				if var_57_7 > 0 and var_57_1 < var_57_7 then
					arg_54_1.talkMaxDuration = var_57_7

					if var_57_7 + var_57_0 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_7 + var_57_0
					end
				end

				arg_54_1.text_.text = var_57_4
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325041", "325041013", "story_v_out_325041.awb") ~= 0 then
					local var_57_8 = manager.audio:GetVoiceLength("story_v_out_325041", "325041013", "story_v_out_325041.awb") / 1000

					if var_57_8 + var_57_0 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_8 + var_57_0
					end

					if var_57_3.prefab_name ~= "" and arg_54_1.actors_[var_57_3.prefab_name] ~= nil then
						local var_57_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_54_1.actors_[var_57_3.prefab_name].transform, "story_v_out_325041", "325041013", "story_v_out_325041.awb")

						arg_54_1:RecordAudio("325041013", var_57_9)
						arg_54_1:RecordAudio("325041013", var_57_9)
					else
						arg_54_1:AudioAction("play", "voice", "story_v_out_325041", "325041013", "story_v_out_325041.awb")
					end

					arg_54_1:RecordHistoryTalkVoice("story_v_out_325041", "325041013", "story_v_out_325041.awb")
				end

				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_10 = math.max(var_57_1, arg_54_1.talkMaxDuration)

			if var_57_0 <= arg_54_1.time_ and arg_54_1.time_ < var_57_0 + var_57_10 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - var_57_0) / var_57_10

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= var_57_0 + var_57_10 and arg_54_1.time_ < var_57_0 + var_57_10 + arg_57_0 then
				arg_54_1.typewritter.percent = 1

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(true)
			end
		end

		arg_54_1.nodeConfigList_ = {}

		arg_54_1:InitPlayNodeList()
	end,
	Play325041014 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 325041014
		arg_58_1.duration_ = 3.2

		local var_58_0 = {
			zh = 3.2,
			ja = 3.066
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
				arg_58_0:Play325041015(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			local var_61_0 = arg_58_1.actors_["1077ui_story"].transform
			local var_61_1 = 0

			if var_61_1 < arg_58_1.time_ and arg_58_1.time_ <= var_61_1 + arg_61_0 then
				arg_58_1.var_.moveOldPos1077ui_story = var_61_0.localPosition

				local var_61_2 = GameObjectTools.GetOrAddComponent(var_61_0.gameObject, typeof(DynamicBoneHelper))

				if var_61_2 then
					var_61_2:EnableDynamicBone(false)
				end
			end

			local var_61_3 = 0.001

			if var_61_1 <= arg_58_1.time_ and arg_58_1.time_ < var_61_1 + var_61_3 then
				local var_61_4 = (arg_58_1.time_ - var_61_1) / var_61_3
				local var_61_5 = Vector3.New(0, 100, 0)

				var_61_0.localPosition = Vector3.Lerp(arg_58_1.var_.moveOldPos1077ui_story, var_61_5, var_61_4)

				local var_61_6 = manager.ui.mainCamera.transform.position - var_61_0.position

				var_61_0.forward = Vector3.New(var_61_6.x, var_61_6.y, var_61_6.z)

				local var_61_7 = var_61_0.localEulerAngles

				var_61_7.z = 0
				var_61_7.x = 0
				var_61_0.localEulerAngles = var_61_7
			end

			if arg_58_1.time_ >= var_61_1 + var_61_3 and arg_58_1.time_ < var_61_1 + var_61_3 + arg_61_0 then
				var_61_0.localPosition = Vector3.New(0, 100, 0)

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

			local var_61_11 = arg_58_1.actors_["1077ui_story"]
			local var_61_12 = 0

			if var_61_12 < arg_58_1.time_ and arg_58_1.time_ <= var_61_12 + arg_61_0 and not isNil(var_61_11) and arg_58_1.var_.characterEffect1077ui_story == nil then
				arg_58_1.var_.characterEffect1077ui_story = var_61_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_61_13 = 0.200000002980232

			if var_61_12 <= arg_58_1.time_ and arg_58_1.time_ < var_61_12 + var_61_13 and not isNil(var_61_11) then
				local var_61_14 = (arg_58_1.time_ - var_61_12) / var_61_13

				if arg_58_1.var_.characterEffect1077ui_story and not isNil(var_61_11) then
					arg_58_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_58_1.time_ >= var_61_12 + var_61_13 and arg_58_1.time_ < var_61_12 + var_61_13 + arg_61_0 and not isNil(var_61_11) and arg_58_1.var_.characterEffect1077ui_story then
				arg_58_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_61_15 = 0

			if var_61_15 < arg_58_1.time_ and arg_58_1.time_ <= var_61_15 + arg_61_0 then
				arg_58_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action1_1")
			end

			local var_61_16 = 0

			if var_61_16 < arg_58_1.time_ and arg_58_1.time_ <= var_61_16 + arg_61_0 then
				arg_58_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_61_17 = 0
			local var_61_18 = 0.15

			if var_61_17 < arg_58_1.time_ and arg_58_1.time_ <= var_61_17 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, true)

				local var_61_19 = arg_58_1:FormatText(StoryNameCfg[1467].name)

				arg_58_1.leftNameTxt_.text = var_61_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, true)
				arg_58_1.iconController_:SetSelectedState("hero")

				arg_58_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1077")

				arg_58_1.callingController_:SetSelectedState("normal")

				arg_58_1.keyicon_.color = Color.New(1, 1, 1)
				arg_58_1.icon_.color = Color.New(1, 1, 1)

				local var_61_20 = arg_58_1:GetWordFromCfg(325041014)
				local var_61_21 = arg_58_1:FormatText(var_61_20.content)

				arg_58_1.text_.text = var_61_21

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_22 = 6
				local var_61_23 = utf8.len(var_61_21)
				local var_61_24 = var_61_22 <= 0 and var_61_18 or var_61_18 * (var_61_23 / var_61_22)

				if var_61_24 > 0 and var_61_18 < var_61_24 then
					arg_58_1.talkMaxDuration = var_61_24

					if var_61_24 + var_61_17 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_24 + var_61_17
					end
				end

				arg_58_1.text_.text = var_61_21
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325041", "325041014", "story_v_out_325041.awb") ~= 0 then
					local var_61_25 = manager.audio:GetVoiceLength("story_v_out_325041", "325041014", "story_v_out_325041.awb") / 1000

					if var_61_25 + var_61_17 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_25 + var_61_17
					end

					if var_61_20.prefab_name ~= "" and arg_58_1.actors_[var_61_20.prefab_name] ~= nil then
						local var_61_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_58_1.actors_[var_61_20.prefab_name].transform, "story_v_out_325041", "325041014", "story_v_out_325041.awb")

						arg_58_1:RecordAudio("325041014", var_61_26)
						arg_58_1:RecordAudio("325041014", var_61_26)
					else
						arg_58_1:AudioAction("play", "voice", "story_v_out_325041", "325041014", "story_v_out_325041.awb")
					end

					arg_58_1:RecordHistoryTalkVoice("story_v_out_325041", "325041014", "story_v_out_325041.awb")
				end

				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_27 = math.max(var_61_18, arg_58_1.talkMaxDuration)

			if var_61_17 <= arg_58_1.time_ and arg_58_1.time_ < var_61_17 + var_61_27 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_17) / var_61_27

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_17 + var_61_27 and arg_58_1.time_ < var_61_17 + var_61_27 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {
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

		arg_58_1:InitPlayNodeList()
	end,
	Play325041015 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 325041015
		arg_62_1.duration_ = 5

		SetActive(arg_62_1.tipsGo_, false)

		function arg_62_1.onSingleLineFinish_()
			arg_62_1.onSingleLineUpdate_ = nil
			arg_62_1.onSingleLineFinish_ = nil
			arg_62_1.state_ = "waiting"
		end

		function arg_62_1.playNext_(arg_64_0)
			if arg_64_0 == 1 then
				arg_62_0:Play325041016(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			local var_65_0 = arg_62_1.actors_["1077ui_story"].transform
			local var_65_1 = 0

			if var_65_1 < arg_62_1.time_ and arg_62_1.time_ <= var_65_1 + arg_65_0 then
				arg_62_1.var_.moveOldPos1077ui_story = var_65_0.localPosition

				local var_65_2 = GameObjectTools.GetOrAddComponent(var_65_0.gameObject, typeof(DynamicBoneHelper))

				if var_65_2 then
					var_65_2:EnableDynamicBone(false)
				end
			end

			local var_65_3 = 0.001

			if var_65_1 <= arg_62_1.time_ and arg_62_1.time_ < var_65_1 + var_65_3 then
				local var_65_4 = (arg_62_1.time_ - var_65_1) / var_65_3
				local var_65_5 = Vector3.New(0, 100, 0)

				var_65_0.localPosition = Vector3.Lerp(arg_62_1.var_.moveOldPos1077ui_story, var_65_5, var_65_4)

				local var_65_6 = manager.ui.mainCamera.transform.position - var_65_0.position

				var_65_0.forward = Vector3.New(var_65_6.x, var_65_6.y, var_65_6.z)

				local var_65_7 = var_65_0.localEulerAngles

				var_65_7.z = 0
				var_65_7.x = 0
				var_65_0.localEulerAngles = var_65_7
			end

			if arg_62_1.time_ >= var_65_1 + var_65_3 and arg_62_1.time_ < var_65_1 + var_65_3 + arg_65_0 then
				var_65_0.localPosition = Vector3.New(0, 100, 0)

				local var_65_8 = manager.ui.mainCamera.transform.position - var_65_0.position

				var_65_0.forward = Vector3.New(var_65_8.x, var_65_8.y, var_65_8.z)

				local var_65_9 = var_65_0.localEulerAngles

				var_65_9.z = 0
				var_65_9.x = 0
				var_65_0.localEulerAngles = var_65_9

				local var_65_10 = GameObjectTools.GetOrAddComponent(var_65_0.gameObject, typeof(DynamicBoneHelper))

				if var_65_10 then
					var_65_10:EnableDynamicBone(true)
				end
			end

			local var_65_11 = arg_62_1.actors_["1077ui_story"]
			local var_65_12 = 0

			if var_65_12 < arg_62_1.time_ and arg_62_1.time_ <= var_65_12 + arg_65_0 and not isNil(var_65_11) and arg_62_1.var_.characterEffect1077ui_story == nil then
				arg_62_1.var_.characterEffect1077ui_story = var_65_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_65_13 = 0.200000002980232

			if var_65_12 <= arg_62_1.time_ and arg_62_1.time_ < var_65_12 + var_65_13 and not isNil(var_65_11) then
				local var_65_14 = (arg_62_1.time_ - var_65_12) / var_65_13

				if arg_62_1.var_.characterEffect1077ui_story and not isNil(var_65_11) then
					local var_65_15 = Mathf.Lerp(0, 0.5, var_65_14)

					arg_62_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_62_1.var_.characterEffect1077ui_story.fillRatio = var_65_15
				end
			end

			if arg_62_1.time_ >= var_65_12 + var_65_13 and arg_62_1.time_ < var_65_12 + var_65_13 + arg_65_0 and not isNil(var_65_11) and arg_62_1.var_.characterEffect1077ui_story then
				local var_65_16 = 0.5

				arg_62_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_62_1.var_.characterEffect1077ui_story.fillRatio = var_65_16
			end

			local var_65_17 = 0
			local var_65_18 = 0.75

			if var_65_17 < arg_62_1.time_ and arg_62_1.time_ <= var_65_17 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, false)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_62_1.iconTrs_.gameObject, false)
				arg_62_1.callingController_:SetSelectedState("normal")

				local var_65_19 = arg_62_1:GetWordFromCfg(325041015)
				local var_65_20 = arg_62_1:FormatText(var_65_19.content)

				arg_62_1.text_.text = var_65_20

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_21 = 30
				local var_65_22 = utf8.len(var_65_20)
				local var_65_23 = var_65_21 <= 0 and var_65_18 or var_65_18 * (var_65_22 / var_65_21)

				if var_65_23 > 0 and var_65_18 < var_65_23 then
					arg_62_1.talkMaxDuration = var_65_23

					if var_65_23 + var_65_17 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_23 + var_65_17
					end
				end

				arg_62_1.text_.text = var_65_20
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)
				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_24 = math.max(var_65_18, arg_62_1.talkMaxDuration)

			if var_65_17 <= arg_62_1.time_ and arg_62_1.time_ < var_65_17 + var_65_24 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - var_65_17) / var_65_24

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= var_65_17 + var_65_24 and arg_62_1.time_ < var_65_17 + var_65_24 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {
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

		arg_62_1:InitPlayNodeList()
	end,
	Play325041016 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 325041016
		arg_66_1.duration_ = 5

		SetActive(arg_66_1.tipsGo_, false)

		function arg_66_1.onSingleLineFinish_()
			arg_66_1.onSingleLineUpdate_ = nil
			arg_66_1.onSingleLineFinish_ = nil
			arg_66_1.state_ = "waiting"
		end

		function arg_66_1.playNext_(arg_68_0)
			if arg_68_0 == 1 then
				arg_66_0:Play325041017(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			local var_69_0 = 0
			local var_69_1 = 0.6

			if var_69_0 < arg_66_1.time_ and arg_66_1.time_ <= var_69_0 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, false)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_2 = arg_66_1:GetWordFromCfg(325041016)
				local var_69_3 = arg_66_1:FormatText(var_69_2.content)

				arg_66_1.text_.text = var_69_3

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_4 = 24
				local var_69_5 = utf8.len(var_69_3)
				local var_69_6 = var_69_4 <= 0 and var_69_1 or var_69_1 * (var_69_5 / var_69_4)

				if var_69_6 > 0 and var_69_1 < var_69_6 then
					arg_66_1.talkMaxDuration = var_69_6

					if var_69_6 + var_69_0 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_6 + var_69_0
					end
				end

				arg_66_1.text_.text = var_69_3
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)
				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_7 = math.max(var_69_1, arg_66_1.talkMaxDuration)

			if var_69_0 <= arg_66_1.time_ and arg_66_1.time_ < var_69_0 + var_69_7 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_0) / var_69_7

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_0 + var_69_7 and arg_66_1.time_ < var_69_0 + var_69_7 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {}

		arg_66_1:InitPlayNodeList()
	end,
	Play325041017 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 325041017
		arg_70_1.duration_ = 7.83

		local var_70_0 = {
			zh = 5.666,
			ja = 7.833
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
				arg_70_0:Play325041018(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			local var_73_0 = 0
			local var_73_1 = 0.35

			if var_73_0 < arg_70_1.time_ and arg_70_1.time_ <= var_73_0 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, true)

				local var_73_2 = arg_70_1:FormatText(StoryNameCfg[1454].name)

				arg_70_1.leftNameTxt_.text = var_73_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_70_1.leftNameTxt_.transform)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1.leftNameTxt_.text)
				SetActive(arg_70_1.iconTrs_.gameObject, true)
				arg_70_1.iconController_:SetSelectedState("hero")

				arg_70_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10169")

				arg_70_1.callingController_:SetSelectedState("normal")

				arg_70_1.keyicon_.color = Color.New(1, 1, 1)
				arg_70_1.icon_.color = Color.New(1, 1, 1)

				local var_73_3 = arg_70_1:GetWordFromCfg(325041017)
				local var_73_4 = arg_70_1:FormatText(var_73_3.content)

				arg_70_1.text_.text = var_73_4

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_5 = 14
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

				if manager.audio:GetVoiceLength("story_v_out_325041", "325041017", "story_v_out_325041.awb") ~= 0 then
					local var_73_8 = manager.audio:GetVoiceLength("story_v_out_325041", "325041017", "story_v_out_325041.awb") / 1000

					if var_73_8 + var_73_0 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_8 + var_73_0
					end

					if var_73_3.prefab_name ~= "" and arg_70_1.actors_[var_73_3.prefab_name] ~= nil then
						local var_73_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_70_1.actors_[var_73_3.prefab_name].transform, "story_v_out_325041", "325041017", "story_v_out_325041.awb")

						arg_70_1:RecordAudio("325041017", var_73_9)
						arg_70_1:RecordAudio("325041017", var_73_9)
					else
						arg_70_1:AudioAction("play", "voice", "story_v_out_325041", "325041017", "story_v_out_325041.awb")
					end

					arg_70_1:RecordHistoryTalkVoice("story_v_out_325041", "325041017", "story_v_out_325041.awb")
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
	Play325041018 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 325041018
		arg_74_1.duration_ = 2.57

		local var_74_0 = {
			zh = 0.999999999999,
			ja = 2.566
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
				arg_74_0:Play325041019(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			local var_77_0 = arg_74_1.actors_["1077ui_story"].transform
			local var_77_1 = 0

			if var_77_1 < arg_74_1.time_ and arg_74_1.time_ <= var_77_1 + arg_77_0 then
				arg_74_1.var_.moveOldPos1077ui_story = var_77_0.localPosition

				local var_77_2 = GameObjectTools.GetOrAddComponent(var_77_0.gameObject, typeof(DynamicBoneHelper))

				if var_77_2 then
					var_77_2:EnableDynamicBone(false)
				end
			end

			local var_77_3 = 0.001

			if var_77_1 <= arg_74_1.time_ and arg_74_1.time_ < var_77_1 + var_77_3 then
				local var_77_4 = (arg_74_1.time_ - var_77_1) / var_77_3
				local var_77_5 = Vector3.New(0, 100, 0)

				var_77_0.localPosition = Vector3.Lerp(arg_74_1.var_.moveOldPos1077ui_story, var_77_5, var_77_4)

				local var_77_6 = manager.ui.mainCamera.transform.position - var_77_0.position

				var_77_0.forward = Vector3.New(var_77_6.x, var_77_6.y, var_77_6.z)

				local var_77_7 = var_77_0.localEulerAngles

				var_77_7.z = 0
				var_77_7.x = 0
				var_77_0.localEulerAngles = var_77_7
			end

			if arg_74_1.time_ >= var_77_1 + var_77_3 and arg_74_1.time_ < var_77_1 + var_77_3 + arg_77_0 then
				var_77_0.localPosition = Vector3.New(0, 100, 0)

				local var_77_8 = manager.ui.mainCamera.transform.position - var_77_0.position

				var_77_0.forward = Vector3.New(var_77_8.x, var_77_8.y, var_77_8.z)

				local var_77_9 = var_77_0.localEulerAngles

				var_77_9.z = 0
				var_77_9.x = 0
				var_77_0.localEulerAngles = var_77_9

				local var_77_10 = GameObjectTools.GetOrAddComponent(var_77_0.gameObject, typeof(DynamicBoneHelper))

				if var_77_10 then
					var_77_10:EnableDynamicBone(true)
				end
			end

			local var_77_11 = arg_74_1.actors_["1077ui_story"]
			local var_77_12 = 0

			if var_77_12 < arg_74_1.time_ and arg_74_1.time_ <= var_77_12 + arg_77_0 and not isNil(var_77_11) and arg_74_1.var_.characterEffect1077ui_story == nil then
				arg_74_1.var_.characterEffect1077ui_story = var_77_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_77_13 = 0.200000002980232

			if var_77_12 <= arg_74_1.time_ and arg_74_1.time_ < var_77_12 + var_77_13 and not isNil(var_77_11) then
				local var_77_14 = (arg_74_1.time_ - var_77_12) / var_77_13

				if arg_74_1.var_.characterEffect1077ui_story and not isNil(var_77_11) then
					arg_74_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_74_1.time_ >= var_77_12 + var_77_13 and arg_74_1.time_ < var_77_12 + var_77_13 + arg_77_0 and not isNil(var_77_11) and arg_74_1.var_.characterEffect1077ui_story then
				arg_74_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_77_15 = 0
			local var_77_16 = 0.075

			if var_77_15 < arg_74_1.time_ and arg_74_1.time_ <= var_77_15 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, true)

				local var_77_17 = arg_74_1:FormatText(StoryNameCfg[1467].name)

				arg_74_1.leftNameTxt_.text = var_77_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_74_1.leftNameTxt_.transform)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1.leftNameTxt_.text)
				SetActive(arg_74_1.iconTrs_.gameObject, true)
				arg_74_1.iconController_:SetSelectedState("hero")

				arg_74_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1077")

				arg_74_1.callingController_:SetSelectedState("normal")

				arg_74_1.keyicon_.color = Color.New(1, 1, 1)
				arg_74_1.icon_.color = Color.New(1, 1, 1)

				local var_77_18 = arg_74_1:GetWordFromCfg(325041018)
				local var_77_19 = arg_74_1:FormatText(var_77_18.content)

				arg_74_1.text_.text = var_77_19

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_20 = 3
				local var_77_21 = utf8.len(var_77_19)
				local var_77_22 = var_77_20 <= 0 and var_77_16 or var_77_16 * (var_77_21 / var_77_20)

				if var_77_22 > 0 and var_77_16 < var_77_22 then
					arg_74_1.talkMaxDuration = var_77_22

					if var_77_22 + var_77_15 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_22 + var_77_15
					end
				end

				arg_74_1.text_.text = var_77_19
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325041", "325041018", "story_v_out_325041.awb") ~= 0 then
					local var_77_23 = manager.audio:GetVoiceLength("story_v_out_325041", "325041018", "story_v_out_325041.awb") / 1000

					if var_77_23 + var_77_15 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_23 + var_77_15
					end

					if var_77_18.prefab_name ~= "" and arg_74_1.actors_[var_77_18.prefab_name] ~= nil then
						local var_77_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_74_1.actors_[var_77_18.prefab_name].transform, "story_v_out_325041", "325041018", "story_v_out_325041.awb")

						arg_74_1:RecordAudio("325041018", var_77_24)
						arg_74_1:RecordAudio("325041018", var_77_24)
					else
						arg_74_1:AudioAction("play", "voice", "story_v_out_325041", "325041018", "story_v_out_325041.awb")
					end

					arg_74_1:RecordHistoryTalkVoice("story_v_out_325041", "325041018", "story_v_out_325041.awb")
				end

				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_25 = math.max(var_77_16, arg_74_1.talkMaxDuration)

			if var_77_15 <= arg_74_1.time_ and arg_74_1.time_ < var_77_15 + var_77_25 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_15) / var_77_25

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_15 + var_77_25 and arg_74_1.time_ < var_77_15 + var_77_25 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {
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

		arg_74_1:InitPlayNodeList()
	end,
	Play325041019 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 325041019
		arg_78_1.duration_ = 2.37

		local var_78_0 = {
			zh = 1.266,
			ja = 2.366
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
				arg_78_0:Play325041020(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			local var_81_0 = arg_78_1.actors_["1077ui_story"]
			local var_81_1 = 0

			if var_81_1 < arg_78_1.time_ and arg_78_1.time_ <= var_81_1 + arg_81_0 and not isNil(var_81_0) and arg_78_1.var_.characterEffect1077ui_story == nil then
				arg_78_1.var_.characterEffect1077ui_story = var_81_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_81_2 = 0.200000002980232

			if var_81_1 <= arg_78_1.time_ and arg_78_1.time_ < var_81_1 + var_81_2 and not isNil(var_81_0) then
				local var_81_3 = (arg_78_1.time_ - var_81_1) / var_81_2

				if arg_78_1.var_.characterEffect1077ui_story and not isNil(var_81_0) then
					local var_81_4 = Mathf.Lerp(0, 0.5, var_81_3)

					arg_78_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_78_1.var_.characterEffect1077ui_story.fillRatio = var_81_4
				end
			end

			if arg_78_1.time_ >= var_81_1 + var_81_2 and arg_78_1.time_ < var_81_1 + var_81_2 + arg_81_0 and not isNil(var_81_0) and arg_78_1.var_.characterEffect1077ui_story then
				local var_81_5 = 0.5

				arg_78_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_78_1.var_.characterEffect1077ui_story.fillRatio = var_81_5
			end

			local var_81_6 = 0
			local var_81_7 = 0.1

			if var_81_6 < arg_78_1.time_ and arg_78_1.time_ <= var_81_6 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, true)

				local var_81_8 = arg_78_1:FormatText(StoryNameCfg[1454].name)

				arg_78_1.leftNameTxt_.text = var_81_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_78_1.leftNameTxt_.transform)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1.leftNameTxt_.text)
				SetActive(arg_78_1.iconTrs_.gameObject, true)
				arg_78_1.iconController_:SetSelectedState("hero")

				arg_78_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10169")

				arg_78_1.callingController_:SetSelectedState("normal")

				arg_78_1.keyicon_.color = Color.New(1, 1, 1)
				arg_78_1.icon_.color = Color.New(1, 1, 1)

				local var_81_9 = arg_78_1:GetWordFromCfg(325041019)
				local var_81_10 = arg_78_1:FormatText(var_81_9.content)

				arg_78_1.text_.text = var_81_10

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_11 = 4
				local var_81_12 = utf8.len(var_81_10)
				local var_81_13 = var_81_11 <= 0 and var_81_7 or var_81_7 * (var_81_12 / var_81_11)

				if var_81_13 > 0 and var_81_7 < var_81_13 then
					arg_78_1.talkMaxDuration = var_81_13

					if var_81_13 + var_81_6 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_13 + var_81_6
					end
				end

				arg_78_1.text_.text = var_81_10
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325041", "325041019", "story_v_out_325041.awb") ~= 0 then
					local var_81_14 = manager.audio:GetVoiceLength("story_v_out_325041", "325041019", "story_v_out_325041.awb") / 1000

					if var_81_14 + var_81_6 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_14 + var_81_6
					end

					if var_81_9.prefab_name ~= "" and arg_78_1.actors_[var_81_9.prefab_name] ~= nil then
						local var_81_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_78_1.actors_[var_81_9.prefab_name].transform, "story_v_out_325041", "325041019", "story_v_out_325041.awb")

						arg_78_1:RecordAudio("325041019", var_81_15)
						arg_78_1:RecordAudio("325041019", var_81_15)
					else
						arg_78_1:AudioAction("play", "voice", "story_v_out_325041", "325041019", "story_v_out_325041.awb")
					end

					arg_78_1:RecordHistoryTalkVoice("story_v_out_325041", "325041019", "story_v_out_325041.awb")
				end

				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_16 = math.max(var_81_7, arg_78_1.talkMaxDuration)

			if var_81_6 <= arg_78_1.time_ and arg_78_1.time_ < var_81_6 + var_81_16 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_6) / var_81_16

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_6 + var_81_16 and arg_78_1.time_ < var_81_6 + var_81_16 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {}

		arg_78_1:InitPlayNodeList()
	end,
	Play325041020 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 325041020
		arg_82_1.duration_ = 6.57

		local var_82_0 = {
			zh = 5.733,
			ja = 6.566
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
				arg_82_0:Play325041021(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			local var_85_0 = 0
			local var_85_1 = 0.5

			if var_85_0 < arg_82_1.time_ and arg_82_1.time_ <= var_85_0 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				local var_85_2 = arg_82_1:FormatText(StoryNameCfg[1467].name)

				arg_82_1.leftNameTxt_.text = var_85_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, true)
				arg_82_1.iconController_:SetSelectedState("hero")

				arg_82_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1077")

				arg_82_1.callingController_:SetSelectedState("normal")

				arg_82_1.keyicon_.color = Color.New(1, 1, 1)
				arg_82_1.icon_.color = Color.New(1, 1, 1)

				local var_85_3 = arg_82_1:GetWordFromCfg(325041020)
				local var_85_4 = arg_82_1:FormatText(var_85_3.content)

				arg_82_1.text_.text = var_85_4

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_5 = 20
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

				if manager.audio:GetVoiceLength("story_v_out_325041", "325041020", "story_v_out_325041.awb") ~= 0 then
					local var_85_8 = manager.audio:GetVoiceLength("story_v_out_325041", "325041020", "story_v_out_325041.awb") / 1000

					if var_85_8 + var_85_0 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_8 + var_85_0
					end

					if var_85_3.prefab_name ~= "" and arg_82_1.actors_[var_85_3.prefab_name] ~= nil then
						local var_85_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_82_1.actors_[var_85_3.prefab_name].transform, "story_v_out_325041", "325041020", "story_v_out_325041.awb")

						arg_82_1:RecordAudio("325041020", var_85_9)
						arg_82_1:RecordAudio("325041020", var_85_9)
					else
						arg_82_1:AudioAction("play", "voice", "story_v_out_325041", "325041020", "story_v_out_325041.awb")
					end

					arg_82_1:RecordHistoryTalkVoice("story_v_out_325041", "325041020", "story_v_out_325041.awb")
				end

				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_10 = math.max(var_85_1, arg_82_1.talkMaxDuration)

			if var_85_0 <= arg_82_1.time_ and arg_82_1.time_ < var_85_0 + var_85_10 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_0) / var_85_10

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_0 + var_85_10 and arg_82_1.time_ < var_85_0 + var_85_10 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {}

		arg_82_1:InitPlayNodeList()
	end,
	Play325041021 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 325041021
		arg_86_1.duration_ = 7.6

		SetActive(arg_86_1.tipsGo_, false)

		function arg_86_1.onSingleLineFinish_()
			arg_86_1.onSingleLineUpdate_ = nil
			arg_86_1.onSingleLineFinish_ = nil
			arg_86_1.state_ = "waiting"
		end

		function arg_86_1.playNext_(arg_88_0)
			if arg_88_0 == 1 then
				arg_86_0:Play325041022(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			local var_89_0 = 1.3

			if var_89_0 < arg_86_1.time_ and arg_86_1.time_ <= var_89_0 + arg_89_0 then
				local var_89_1 = manager.ui.mainCamera.transform.localPosition
				local var_89_2 = Vector3.New(0, 0, 10) + Vector3.New(var_89_1.x, var_89_1.y, 0)
				local var_89_3 = arg_86_1.bgs_.ST2005

				var_89_3.transform.localPosition = var_89_2
				var_89_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_89_4 = var_89_3:GetComponent("SpriteRenderer")

				if var_89_4 and var_89_4.sprite then
					local var_89_5 = (var_89_3.transform.localPosition - var_89_1).z
					local var_89_6 = manager.ui.mainCameraCom_
					local var_89_7 = 2 * var_89_5 * Mathf.Tan(var_89_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_89_8 = var_89_7 * var_89_6.aspect
					local var_89_9 = var_89_4.sprite.bounds.size.x
					local var_89_10 = var_89_4.sprite.bounds.size.y
					local var_89_11 = var_89_8 / var_89_9
					local var_89_12 = var_89_7 / var_89_10
					local var_89_13 = var_89_12 < var_89_11 and var_89_11 or var_89_12

					var_89_3.transform.localScale = Vector3.New(var_89_13, var_89_13, 0)
				end

				for iter_89_0, iter_89_1 in pairs(arg_86_1.bgs_) do
					if iter_89_0 ~= "ST2005" then
						iter_89_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_89_14 = 1.4

			if var_89_14 < arg_86_1.time_ and arg_86_1.time_ <= var_89_14 + arg_89_0 then
				arg_86_1.allBtn_.enabled = false
			end

			local var_89_15 = 0.3

			if arg_86_1.time_ >= var_89_14 + var_89_15 and arg_86_1.time_ < var_89_14 + var_89_15 + arg_89_0 then
				arg_86_1.allBtn_.enabled = true
			end

			local var_89_16 = 0

			if var_89_16 < arg_86_1.time_ and arg_86_1.time_ <= var_89_16 + arg_89_0 then
				arg_86_1.mask_.enabled = true
				arg_86_1.mask_.raycastTarget = true

				arg_86_1:SetGaussion(false)
			end

			local var_89_17 = 1.3

			if var_89_16 <= arg_86_1.time_ and arg_86_1.time_ < var_89_16 + var_89_17 then
				local var_89_18 = (arg_86_1.time_ - var_89_16) / var_89_17
				local var_89_19 = Color.New(0, 0, 0)

				var_89_19.a = Mathf.Lerp(0, 1, var_89_18)
				arg_86_1.mask_.color = var_89_19
			end

			if arg_86_1.time_ >= var_89_16 + var_89_17 and arg_86_1.time_ < var_89_16 + var_89_17 + arg_89_0 then
				local var_89_20 = Color.New(0, 0, 0)

				var_89_20.a = 1
				arg_86_1.mask_.color = var_89_20
			end

			local var_89_21 = 1.3

			if var_89_21 < arg_86_1.time_ and arg_86_1.time_ <= var_89_21 + arg_89_0 then
				arg_86_1.mask_.enabled = true
				arg_86_1.mask_.raycastTarget = true

				arg_86_1:SetGaussion(false)
			end

			local var_89_22 = 2

			if var_89_21 <= arg_86_1.time_ and arg_86_1.time_ < var_89_21 + var_89_22 then
				local var_89_23 = (arg_86_1.time_ - var_89_21) / var_89_22
				local var_89_24 = Color.New(0, 0, 0)

				var_89_24.a = Mathf.Lerp(1, 0, var_89_23)
				arg_86_1.mask_.color = var_89_24
			end

			if arg_86_1.time_ >= var_89_21 + var_89_22 and arg_86_1.time_ < var_89_21 + var_89_22 + arg_89_0 then
				local var_89_25 = Color.New(0, 0, 0)
				local var_89_26 = 0

				arg_86_1.mask_.enabled = false
				var_89_25.a = var_89_26
				arg_86_1.mask_.color = var_89_25
			end

			local var_89_27 = arg_86_1.actors_["1077ui_story"].transform
			local var_89_28 = 1.3

			if var_89_28 < arg_86_1.time_ and arg_86_1.time_ <= var_89_28 + arg_89_0 then
				arg_86_1.var_.moveOldPos1077ui_story = var_89_27.localPosition

				local var_89_29 = GameObjectTools.GetOrAddComponent(var_89_27.gameObject, typeof(DynamicBoneHelper))

				if var_89_29 then
					var_89_29:EnableDynamicBone(false)
				end
			end

			local var_89_30 = 0.001

			if var_89_28 <= arg_86_1.time_ and arg_86_1.time_ < var_89_28 + var_89_30 then
				local var_89_31 = (arg_86_1.time_ - var_89_28) / var_89_30
				local var_89_32 = Vector3.New(0, 100, 0)

				var_89_27.localPosition = Vector3.Lerp(arg_86_1.var_.moveOldPos1077ui_story, var_89_32, var_89_31)

				local var_89_33 = manager.ui.mainCamera.transform.position - var_89_27.position

				var_89_27.forward = Vector3.New(var_89_33.x, var_89_33.y, var_89_33.z)

				local var_89_34 = var_89_27.localEulerAngles

				var_89_34.z = 0
				var_89_34.x = 0
				var_89_27.localEulerAngles = var_89_34
			end

			if arg_86_1.time_ >= var_89_28 + var_89_30 and arg_86_1.time_ < var_89_28 + var_89_30 + arg_89_0 then
				var_89_27.localPosition = Vector3.New(0, 100, 0)

				local var_89_35 = manager.ui.mainCamera.transform.position - var_89_27.position

				var_89_27.forward = Vector3.New(var_89_35.x, var_89_35.y, var_89_35.z)

				local var_89_36 = var_89_27.localEulerAngles

				var_89_36.z = 0
				var_89_36.x = 0
				var_89_27.localEulerAngles = var_89_36

				local var_89_37 = GameObjectTools.GetOrAddComponent(var_89_27.gameObject, typeof(DynamicBoneHelper))

				if var_89_37 then
					var_89_37:EnableDynamicBone(true)
				end
			end

			local var_89_38 = arg_86_1.actors_["1077ui_story"]
			local var_89_39 = 1.3

			if var_89_39 < arg_86_1.time_ and arg_86_1.time_ <= var_89_39 + arg_89_0 and not isNil(var_89_38) and arg_86_1.var_.characterEffect1077ui_story == nil then
				arg_86_1.var_.characterEffect1077ui_story = var_89_38:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_89_40 = 0.200000002980232

			if var_89_39 <= arg_86_1.time_ and arg_86_1.time_ < var_89_39 + var_89_40 and not isNil(var_89_38) then
				local var_89_41 = (arg_86_1.time_ - var_89_39) / var_89_40

				if arg_86_1.var_.characterEffect1077ui_story and not isNil(var_89_38) then
					local var_89_42 = Mathf.Lerp(0, 0.5, var_89_41)

					arg_86_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_86_1.var_.characterEffect1077ui_story.fillRatio = var_89_42
				end
			end

			if arg_86_1.time_ >= var_89_39 + var_89_40 and arg_86_1.time_ < var_89_39 + var_89_40 + arg_89_0 and not isNil(var_89_38) and arg_86_1.var_.characterEffect1077ui_story then
				local var_89_43 = 0.5

				arg_86_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_86_1.var_.characterEffect1077ui_story.fillRatio = var_89_43
			end

			if arg_86_1.frameCnt_ <= 1 then
				arg_86_1.dialog_:SetActive(false)
			end

			local var_89_44 = 2.6
			local var_89_45 = 0.9

			if var_89_44 < arg_86_1.time_ and arg_86_1.time_ <= var_89_44 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0

				arg_86_1.dialog_:SetActive(true)

				arg_86_1.dialogCg_.alpha = 0

				local var_89_46 = LeanTween.value(arg_86_1.dialog_, 0, 1, 0.3)

				var_89_46:setOnUpdate(LuaHelper.FloatAction(function(arg_90_0)
					arg_86_1.dialogCg_.alpha = arg_90_0
				end))
				var_89_46:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_86_1.dialog_)
					var_89_46:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_86_1.duration_ = arg_86_1.duration_ + 0.3

				SetActive(arg_86_1.leftNameGo_, false)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_47 = arg_86_1:GetWordFromCfg(325041021)
				local var_89_48 = arg_86_1:FormatText(var_89_47.content)

				arg_86_1.text_.text = var_89_48

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_49 = 36
				local var_89_50 = utf8.len(var_89_48)
				local var_89_51 = var_89_49 <= 0 and var_89_45 or var_89_45 * (var_89_50 / var_89_49)

				if var_89_51 > 0 and var_89_45 < var_89_51 then
					arg_86_1.talkMaxDuration = var_89_51
					var_89_44 = var_89_44 + 0.3

					if var_89_51 + var_89_44 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_51 + var_89_44
					end
				end

				arg_86_1.text_.text = var_89_48
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)
				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_52 = var_89_44 + 0.3
			local var_89_53 = math.max(var_89_45, arg_86_1.talkMaxDuration)

			if var_89_52 <= arg_86_1.time_ and arg_86_1.time_ < var_89_52 + var_89_53 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_52) / var_89_53

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_52 + var_89_53 and arg_86_1.time_ < var_89_52 + var_89_53 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.3,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_86_1:InitPlayNodeList()
	end,
	Play325041022 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 325041022
		arg_92_1.duration_ = 3.8

		local var_92_0 = {
			zh = 2.1,
			ja = 3.8
		}
		local var_92_1 = manager.audio:GetLocalizationFlag()

		if var_92_0[var_92_1] ~= nil then
			arg_92_1.duration_ = var_92_0[var_92_1]
		end

		SetActive(arg_92_1.tipsGo_, false)

		function arg_92_1.onSingleLineFinish_()
			arg_92_1.onSingleLineUpdate_ = nil
			arg_92_1.onSingleLineFinish_ = nil
			arg_92_1.state_ = "waiting"
		end

		function arg_92_1.playNext_(arg_94_0)
			if arg_94_0 == 1 then
				arg_92_0:Play325041023(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			local var_95_0 = 0
			local var_95_1 = 0.225

			if var_95_0 < arg_92_1.time_ and arg_92_1.time_ <= var_95_0 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				local var_95_2 = arg_92_1:FormatText(StoryNameCfg[1454].name)

				arg_92_1.leftNameTxt_.text = var_95_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, true)
				arg_92_1.iconController_:SetSelectedState("hero")

				arg_92_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10169")

				arg_92_1.callingController_:SetSelectedState("normal")

				arg_92_1.keyicon_.color = Color.New(1, 1, 1)
				arg_92_1.icon_.color = Color.New(1, 1, 1)

				local var_95_3 = arg_92_1:GetWordFromCfg(325041022)
				local var_95_4 = arg_92_1:FormatText(var_95_3.content)

				arg_92_1.text_.text = var_95_4

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_5 = 9
				local var_95_6 = utf8.len(var_95_4)
				local var_95_7 = var_95_5 <= 0 and var_95_1 or var_95_1 * (var_95_6 / var_95_5)

				if var_95_7 > 0 and var_95_1 < var_95_7 then
					arg_92_1.talkMaxDuration = var_95_7

					if var_95_7 + var_95_0 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_7 + var_95_0
					end
				end

				arg_92_1.text_.text = var_95_4
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325041", "325041022", "story_v_out_325041.awb") ~= 0 then
					local var_95_8 = manager.audio:GetVoiceLength("story_v_out_325041", "325041022", "story_v_out_325041.awb") / 1000

					if var_95_8 + var_95_0 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_8 + var_95_0
					end

					if var_95_3.prefab_name ~= "" and arg_92_1.actors_[var_95_3.prefab_name] ~= nil then
						local var_95_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_3.prefab_name].transform, "story_v_out_325041", "325041022", "story_v_out_325041.awb")

						arg_92_1:RecordAudio("325041022", var_95_9)
						arg_92_1:RecordAudio("325041022", var_95_9)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_out_325041", "325041022", "story_v_out_325041.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_out_325041", "325041022", "story_v_out_325041.awb")
				end

				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_10 = math.max(var_95_1, arg_92_1.talkMaxDuration)

			if var_95_0 <= arg_92_1.time_ and arg_92_1.time_ < var_95_0 + var_95_10 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_0) / var_95_10

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_0 + var_95_10 and arg_92_1.time_ < var_95_0 + var_95_10 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {}

		arg_92_1:InitPlayNodeList()
	end,
	Play325041023 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 325041023
		arg_96_1.duration_ = 7.33

		local var_96_0 = {
			zh = 4.466,
			ja = 7.333
		}
		local var_96_1 = manager.audio:GetLocalizationFlag()

		if var_96_0[var_96_1] ~= nil then
			arg_96_1.duration_ = var_96_0[var_96_1]
		end

		SetActive(arg_96_1.tipsGo_, false)

		function arg_96_1.onSingleLineFinish_()
			arg_96_1.onSingleLineUpdate_ = nil
			arg_96_1.onSingleLineFinish_ = nil
			arg_96_1.state_ = "waiting"
		end

		function arg_96_1.playNext_(arg_98_0)
			if arg_98_0 == 1 then
				arg_96_0:Play325041024(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			local var_99_0 = arg_96_1.actors_["1077ui_story"].transform
			local var_99_1 = 0

			if var_99_1 < arg_96_1.time_ and arg_96_1.time_ <= var_99_1 + arg_99_0 then
				arg_96_1.var_.moveOldPos1077ui_story = var_99_0.localPosition

				local var_99_2 = GameObjectTools.GetOrAddComponent(var_99_0.gameObject, typeof(DynamicBoneHelper))

				if var_99_2 then
					var_99_2:EnableDynamicBone(false)
				end
			end

			local var_99_3 = 0.001

			if var_99_1 <= arg_96_1.time_ and arg_96_1.time_ < var_99_1 + var_99_3 then
				local var_99_4 = (arg_96_1.time_ - var_99_1) / var_99_3
				local var_99_5 = Vector3.New(-0.03, -1.02, -5.92)

				var_99_0.localPosition = Vector3.Lerp(arg_96_1.var_.moveOldPos1077ui_story, var_99_5, var_99_4)

				local var_99_6 = manager.ui.mainCamera.transform.position - var_99_0.position

				var_99_0.forward = Vector3.New(var_99_6.x, var_99_6.y, var_99_6.z)

				local var_99_7 = var_99_0.localEulerAngles

				var_99_7.z = 0
				var_99_7.x = 0
				var_99_0.localEulerAngles = var_99_7
			end

			if arg_96_1.time_ >= var_99_1 + var_99_3 and arg_96_1.time_ < var_99_1 + var_99_3 + arg_99_0 then
				var_99_0.localPosition = Vector3.New(-0.03, -1.02, -5.92)

				local var_99_8 = manager.ui.mainCamera.transform.position - var_99_0.position

				var_99_0.forward = Vector3.New(var_99_8.x, var_99_8.y, var_99_8.z)

				local var_99_9 = var_99_0.localEulerAngles

				var_99_9.z = 0
				var_99_9.x = 0
				var_99_0.localEulerAngles = var_99_9

				local var_99_10 = GameObjectTools.GetOrAddComponent(var_99_0.gameObject, typeof(DynamicBoneHelper))

				if var_99_10 then
					var_99_10:EnableDynamicBone(true)
				end
			end

			local var_99_11 = arg_96_1.actors_["1077ui_story"]
			local var_99_12 = 0

			if var_99_12 < arg_96_1.time_ and arg_96_1.time_ <= var_99_12 + arg_99_0 and not isNil(var_99_11) and arg_96_1.var_.characterEffect1077ui_story == nil then
				arg_96_1.var_.characterEffect1077ui_story = var_99_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_13 = 0.200000002980232

			if var_99_12 <= arg_96_1.time_ and arg_96_1.time_ < var_99_12 + var_99_13 and not isNil(var_99_11) then
				local var_99_14 = (arg_96_1.time_ - var_99_12) / var_99_13

				if arg_96_1.var_.characterEffect1077ui_story and not isNil(var_99_11) then
					arg_96_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_96_1.time_ >= var_99_12 + var_99_13 and arg_96_1.time_ < var_99_12 + var_99_13 + arg_99_0 and not isNil(var_99_11) and arg_96_1.var_.characterEffect1077ui_story then
				arg_96_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_99_15 = 0

			if var_99_15 < arg_96_1.time_ and arg_96_1.time_ <= var_99_15 + arg_99_0 then
				arg_96_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action7_1")
			end

			local var_99_16 = 0
			local var_99_17 = 0.3

			if var_99_16 < arg_96_1.time_ and arg_96_1.time_ <= var_99_16 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				local var_99_18 = arg_96_1:FormatText(StoryNameCfg[1467].name)

				arg_96_1.leftNameTxt_.text = var_99_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_19 = arg_96_1:GetWordFromCfg(325041023)
				local var_99_20 = arg_96_1:FormatText(var_99_19.content)

				arg_96_1.text_.text = var_99_20

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_21 = 12
				local var_99_22 = utf8.len(var_99_20)
				local var_99_23 = var_99_21 <= 0 and var_99_17 or var_99_17 * (var_99_22 / var_99_21)

				if var_99_23 > 0 and var_99_17 < var_99_23 then
					arg_96_1.talkMaxDuration = var_99_23

					if var_99_23 + var_99_16 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_23 + var_99_16
					end
				end

				arg_96_1.text_.text = var_99_20
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325041", "325041023", "story_v_out_325041.awb") ~= 0 then
					local var_99_24 = manager.audio:GetVoiceLength("story_v_out_325041", "325041023", "story_v_out_325041.awb") / 1000

					if var_99_24 + var_99_16 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_24 + var_99_16
					end

					if var_99_19.prefab_name ~= "" and arg_96_1.actors_[var_99_19.prefab_name] ~= nil then
						local var_99_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_96_1.actors_[var_99_19.prefab_name].transform, "story_v_out_325041", "325041023", "story_v_out_325041.awb")

						arg_96_1:RecordAudio("325041023", var_99_25)
						arg_96_1:RecordAudio("325041023", var_99_25)
					else
						arg_96_1:AudioAction("play", "voice", "story_v_out_325041", "325041023", "story_v_out_325041.awb")
					end

					arg_96_1:RecordHistoryTalkVoice("story_v_out_325041", "325041023", "story_v_out_325041.awb")
				end

				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_26 = math.max(var_99_17, arg_96_1.talkMaxDuration)

			if var_99_16 <= arg_96_1.time_ and arg_96_1.time_ < var_99_16 + var_99_26 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_16) / var_99_26

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_16 + var_99_26 and arg_96_1.time_ < var_99_16 + var_99_26 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {
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

		arg_96_1:InitPlayNodeList()
	end,
	Play325041024 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 325041024
		arg_100_1.duration_ = 15.33

		local var_100_0 = {
			zh = 8.566,
			ja = 15.333
		}
		local var_100_1 = manager.audio:GetLocalizationFlag()

		if var_100_0[var_100_1] ~= nil then
			arg_100_1.duration_ = var_100_0[var_100_1]
		end

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play325041025(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			local var_103_0 = arg_100_1.actors_["1077ui_story"]
			local var_103_1 = 0

			if var_103_1 < arg_100_1.time_ and arg_100_1.time_ <= var_103_1 + arg_103_0 and not isNil(var_103_0) and arg_100_1.var_.characterEffect1077ui_story == nil then
				arg_100_1.var_.characterEffect1077ui_story = var_103_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_103_2 = 0.200000002980232

			if var_103_1 <= arg_100_1.time_ and arg_100_1.time_ < var_103_1 + var_103_2 and not isNil(var_103_0) then
				local var_103_3 = (arg_100_1.time_ - var_103_1) / var_103_2

				if arg_100_1.var_.characterEffect1077ui_story and not isNil(var_103_0) then
					local var_103_4 = Mathf.Lerp(0, 0.5, var_103_3)

					arg_100_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_100_1.var_.characterEffect1077ui_story.fillRatio = var_103_4
				end
			end

			if arg_100_1.time_ >= var_103_1 + var_103_2 and arg_100_1.time_ < var_103_1 + var_103_2 + arg_103_0 and not isNil(var_103_0) and arg_100_1.var_.characterEffect1077ui_story then
				local var_103_5 = 0.5

				arg_100_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_100_1.var_.characterEffect1077ui_story.fillRatio = var_103_5
			end

			local var_103_6 = 0
			local var_103_7 = 0.825

			if var_103_6 < arg_100_1.time_ and arg_100_1.time_ <= var_103_6 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				local var_103_8 = arg_100_1:FormatText(StoryNameCfg[1454].name)

				arg_100_1.leftNameTxt_.text = var_103_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, true)
				arg_100_1.iconController_:SetSelectedState("hero")

				arg_100_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10169")

				arg_100_1.callingController_:SetSelectedState("normal")

				arg_100_1.keyicon_.color = Color.New(1, 1, 1)
				arg_100_1.icon_.color = Color.New(1, 1, 1)

				local var_103_9 = arg_100_1:GetWordFromCfg(325041024)
				local var_103_10 = arg_100_1:FormatText(var_103_9.content)

				arg_100_1.text_.text = var_103_10

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_11 = 33
				local var_103_12 = utf8.len(var_103_10)
				local var_103_13 = var_103_11 <= 0 and var_103_7 or var_103_7 * (var_103_12 / var_103_11)

				if var_103_13 > 0 and var_103_7 < var_103_13 then
					arg_100_1.talkMaxDuration = var_103_13

					if var_103_13 + var_103_6 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_13 + var_103_6
					end
				end

				arg_100_1.text_.text = var_103_10
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325041", "325041024", "story_v_out_325041.awb") ~= 0 then
					local var_103_14 = manager.audio:GetVoiceLength("story_v_out_325041", "325041024", "story_v_out_325041.awb") / 1000

					if var_103_14 + var_103_6 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_14 + var_103_6
					end

					if var_103_9.prefab_name ~= "" and arg_100_1.actors_[var_103_9.prefab_name] ~= nil then
						local var_103_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_100_1.actors_[var_103_9.prefab_name].transform, "story_v_out_325041", "325041024", "story_v_out_325041.awb")

						arg_100_1:RecordAudio("325041024", var_103_15)
						arg_100_1:RecordAudio("325041024", var_103_15)
					else
						arg_100_1:AudioAction("play", "voice", "story_v_out_325041", "325041024", "story_v_out_325041.awb")
					end

					arg_100_1:RecordHistoryTalkVoice("story_v_out_325041", "325041024", "story_v_out_325041.awb")
				end

				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_16 = math.max(var_103_7, arg_100_1.talkMaxDuration)

			if var_103_6 <= arg_100_1.time_ and arg_100_1.time_ < var_103_6 + var_103_16 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_6) / var_103_16

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_6 + var_103_16 and arg_100_1.time_ < var_103_6 + var_103_16 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {}

		arg_100_1:InitPlayNodeList()
	end,
	Play325041025 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 325041025
		arg_104_1.duration_ = 9.17

		local var_104_0 = {
			zh = 6.7,
			ja = 9.166
		}
		local var_104_1 = manager.audio:GetLocalizationFlag()

		if var_104_0[var_104_1] ~= nil then
			arg_104_1.duration_ = var_104_0[var_104_1]
		end

		SetActive(arg_104_1.tipsGo_, false)

		function arg_104_1.onSingleLineFinish_()
			arg_104_1.onSingleLineUpdate_ = nil
			arg_104_1.onSingleLineFinish_ = nil
			arg_104_1.state_ = "waiting"
		end

		function arg_104_1.playNext_(arg_106_0)
			if arg_106_0 == 1 then
				arg_104_0:Play325041026(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			local var_107_0 = arg_104_1.actors_["1077ui_story"]
			local var_107_1 = 0

			if var_107_1 < arg_104_1.time_ and arg_104_1.time_ <= var_107_1 + arg_107_0 and not isNil(var_107_0) and arg_104_1.var_.characterEffect1077ui_story == nil then
				arg_104_1.var_.characterEffect1077ui_story = var_107_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_107_2 = 0.200000002980232

			if var_107_1 <= arg_104_1.time_ and arg_104_1.time_ < var_107_1 + var_107_2 and not isNil(var_107_0) then
				local var_107_3 = (arg_104_1.time_ - var_107_1) / var_107_2

				if arg_104_1.var_.characterEffect1077ui_story and not isNil(var_107_0) then
					arg_104_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_104_1.time_ >= var_107_1 + var_107_2 and arg_104_1.time_ < var_107_1 + var_107_2 + arg_107_0 and not isNil(var_107_0) and arg_104_1.var_.characterEffect1077ui_story then
				arg_104_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_107_4 = 0

			if var_107_4 < arg_104_1.time_ and arg_104_1.time_ <= var_107_4 + arg_107_0 then
				arg_104_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077actionlink/1077action475")
			end

			local var_107_5 = 0

			if var_107_5 < arg_104_1.time_ and arg_104_1.time_ <= var_107_5 + arg_107_0 then
				arg_104_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_107_6 = 0
			local var_107_7 = 0.7

			if var_107_6 < arg_104_1.time_ and arg_104_1.time_ <= var_107_6 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				local var_107_8 = arg_104_1:FormatText(StoryNameCfg[1467].name)

				arg_104_1.leftNameTxt_.text = var_107_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_9 = arg_104_1:GetWordFromCfg(325041025)
				local var_107_10 = arg_104_1:FormatText(var_107_9.content)

				arg_104_1.text_.text = var_107_10

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_11 = 28
				local var_107_12 = utf8.len(var_107_10)
				local var_107_13 = var_107_11 <= 0 and var_107_7 or var_107_7 * (var_107_12 / var_107_11)

				if var_107_13 > 0 and var_107_7 < var_107_13 then
					arg_104_1.talkMaxDuration = var_107_13

					if var_107_13 + var_107_6 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_13 + var_107_6
					end
				end

				arg_104_1.text_.text = var_107_10
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325041", "325041025", "story_v_out_325041.awb") ~= 0 then
					local var_107_14 = manager.audio:GetVoiceLength("story_v_out_325041", "325041025", "story_v_out_325041.awb") / 1000

					if var_107_14 + var_107_6 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_14 + var_107_6
					end

					if var_107_9.prefab_name ~= "" and arg_104_1.actors_[var_107_9.prefab_name] ~= nil then
						local var_107_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_104_1.actors_[var_107_9.prefab_name].transform, "story_v_out_325041", "325041025", "story_v_out_325041.awb")

						arg_104_1:RecordAudio("325041025", var_107_15)
						arg_104_1:RecordAudio("325041025", var_107_15)
					else
						arg_104_1:AudioAction("play", "voice", "story_v_out_325041", "325041025", "story_v_out_325041.awb")
					end

					arg_104_1:RecordHistoryTalkVoice("story_v_out_325041", "325041025", "story_v_out_325041.awb")
				end

				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_16 = math.max(var_107_7, arg_104_1.talkMaxDuration)

			if var_107_6 <= arg_104_1.time_ and arg_104_1.time_ < var_107_6 + var_107_16 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_6) / var_107_16

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_6 + var_107_16 and arg_104_1.time_ < var_107_6 + var_107_16 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {}

		arg_104_1:InitPlayNodeList()
	end,
	Play325041026 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 325041026
		arg_108_1.duration_ = 6.87

		local var_108_0 = {
			zh = 3.7,
			ja = 6.866
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
				arg_108_0:Play325041027(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			local var_111_0 = 0
			local var_111_1 = 0.425

			if var_111_0 < arg_108_1.time_ and arg_108_1.time_ <= var_111_0 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				local var_111_2 = arg_108_1:FormatText(StoryNameCfg[1467].name)

				arg_108_1.leftNameTxt_.text = var_111_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_3 = arg_108_1:GetWordFromCfg(325041026)
				local var_111_4 = arg_108_1:FormatText(var_111_3.content)

				arg_108_1.text_.text = var_111_4

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_5 = 17
				local var_111_6 = utf8.len(var_111_4)
				local var_111_7 = var_111_5 <= 0 and var_111_1 or var_111_1 * (var_111_6 / var_111_5)

				if var_111_7 > 0 and var_111_1 < var_111_7 then
					arg_108_1.talkMaxDuration = var_111_7

					if var_111_7 + var_111_0 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_7 + var_111_0
					end
				end

				arg_108_1.text_.text = var_111_4
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325041", "325041026", "story_v_out_325041.awb") ~= 0 then
					local var_111_8 = manager.audio:GetVoiceLength("story_v_out_325041", "325041026", "story_v_out_325041.awb") / 1000

					if var_111_8 + var_111_0 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_8 + var_111_0
					end

					if var_111_3.prefab_name ~= "" and arg_108_1.actors_[var_111_3.prefab_name] ~= nil then
						local var_111_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_108_1.actors_[var_111_3.prefab_name].transform, "story_v_out_325041", "325041026", "story_v_out_325041.awb")

						arg_108_1:RecordAudio("325041026", var_111_9)
						arg_108_1:RecordAudio("325041026", var_111_9)
					else
						arg_108_1:AudioAction("play", "voice", "story_v_out_325041", "325041026", "story_v_out_325041.awb")
					end

					arg_108_1:RecordHistoryTalkVoice("story_v_out_325041", "325041026", "story_v_out_325041.awb")
				end

				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_10 = math.max(var_111_1, arg_108_1.talkMaxDuration)

			if var_111_0 <= arg_108_1.time_ and arg_108_1.time_ < var_111_0 + var_111_10 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_0) / var_111_10

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_0 + var_111_10 and arg_108_1.time_ < var_111_0 + var_111_10 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {}

		arg_108_1:InitPlayNodeList()
	end,
	Play325041027 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 325041027
		arg_112_1.duration_ = 6.93

		local var_112_0 = {
			zh = 3.433,
			ja = 6.933
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
				arg_112_0:Play325041028(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			local var_115_0 = arg_112_1.actors_["1077ui_story"]
			local var_115_1 = 0

			if var_115_1 < arg_112_1.time_ and arg_112_1.time_ <= var_115_1 + arg_115_0 and not isNil(var_115_0) and arg_112_1.var_.characterEffect1077ui_story == nil then
				arg_112_1.var_.characterEffect1077ui_story = var_115_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_115_2 = 0.200000002980232

			if var_115_1 <= arg_112_1.time_ and arg_112_1.time_ < var_115_1 + var_115_2 and not isNil(var_115_0) then
				local var_115_3 = (arg_112_1.time_ - var_115_1) / var_115_2

				if arg_112_1.var_.characterEffect1077ui_story and not isNil(var_115_0) then
					local var_115_4 = Mathf.Lerp(0, 0.5, var_115_3)

					arg_112_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_112_1.var_.characterEffect1077ui_story.fillRatio = var_115_4
				end
			end

			if arg_112_1.time_ >= var_115_1 + var_115_2 and arg_112_1.time_ < var_115_1 + var_115_2 + arg_115_0 and not isNil(var_115_0) and arg_112_1.var_.characterEffect1077ui_story then
				local var_115_5 = 0.5

				arg_112_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_112_1.var_.characterEffect1077ui_story.fillRatio = var_115_5
			end

			local var_115_6 = 0
			local var_115_7 = 0.325

			if var_115_6 < arg_112_1.time_ and arg_112_1.time_ <= var_115_6 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				local var_115_8 = arg_112_1:FormatText(StoryNameCfg[1454].name)

				arg_112_1.leftNameTxt_.text = var_115_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, true)
				arg_112_1.iconController_:SetSelectedState("hero")

				arg_112_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10169")

				arg_112_1.callingController_:SetSelectedState("normal")

				arg_112_1.keyicon_.color = Color.New(1, 1, 1)
				arg_112_1.icon_.color = Color.New(1, 1, 1)

				local var_115_9 = arg_112_1:GetWordFromCfg(325041027)
				local var_115_10 = arg_112_1:FormatText(var_115_9.content)

				arg_112_1.text_.text = var_115_10

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_11 = 13
				local var_115_12 = utf8.len(var_115_10)
				local var_115_13 = var_115_11 <= 0 and var_115_7 or var_115_7 * (var_115_12 / var_115_11)

				if var_115_13 > 0 and var_115_7 < var_115_13 then
					arg_112_1.talkMaxDuration = var_115_13

					if var_115_13 + var_115_6 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_13 + var_115_6
					end
				end

				arg_112_1.text_.text = var_115_10
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325041", "325041027", "story_v_out_325041.awb") ~= 0 then
					local var_115_14 = manager.audio:GetVoiceLength("story_v_out_325041", "325041027", "story_v_out_325041.awb") / 1000

					if var_115_14 + var_115_6 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_14 + var_115_6
					end

					if var_115_9.prefab_name ~= "" and arg_112_1.actors_[var_115_9.prefab_name] ~= nil then
						local var_115_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_112_1.actors_[var_115_9.prefab_name].transform, "story_v_out_325041", "325041027", "story_v_out_325041.awb")

						arg_112_1:RecordAudio("325041027", var_115_15)
						arg_112_1:RecordAudio("325041027", var_115_15)
					else
						arg_112_1:AudioAction("play", "voice", "story_v_out_325041", "325041027", "story_v_out_325041.awb")
					end

					arg_112_1:RecordHistoryTalkVoice("story_v_out_325041", "325041027", "story_v_out_325041.awb")
				end

				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_16 = math.max(var_115_7, arg_112_1.talkMaxDuration)

			if var_115_6 <= arg_112_1.time_ and arg_112_1.time_ < var_115_6 + var_115_16 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_6) / var_115_16

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_6 + var_115_16 and arg_112_1.time_ < var_115_6 + var_115_16 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {}

		arg_112_1:InitPlayNodeList()
	end,
	Play325041028 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 325041028
		arg_116_1.duration_ = 10.13

		local var_116_0 = {
			zh = 6.266,
			ja = 10.133
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
				arg_116_0:Play325041029(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			local var_119_0 = arg_116_1.actors_["1077ui_story"]
			local var_119_1 = 0

			if var_119_1 < arg_116_1.time_ and arg_116_1.time_ <= var_119_1 + arg_119_0 and not isNil(var_119_0) and arg_116_1.var_.characterEffect1077ui_story == nil then
				arg_116_1.var_.characterEffect1077ui_story = var_119_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_119_2 = 0.200000002980232

			if var_119_1 <= arg_116_1.time_ and arg_116_1.time_ < var_119_1 + var_119_2 and not isNil(var_119_0) then
				local var_119_3 = (arg_116_1.time_ - var_119_1) / var_119_2

				if arg_116_1.var_.characterEffect1077ui_story and not isNil(var_119_0) then
					arg_116_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_116_1.time_ >= var_119_1 + var_119_2 and arg_116_1.time_ < var_119_1 + var_119_2 + arg_119_0 and not isNil(var_119_0) and arg_116_1.var_.characterEffect1077ui_story then
				arg_116_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_119_4 = 0

			if var_119_4 < arg_116_1.time_ and arg_116_1.time_ <= var_119_4 + arg_119_0 then
				arg_116_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action5_2")
			end

			local var_119_5 = 0

			if var_119_5 < arg_116_1.time_ and arg_116_1.time_ <= var_119_5 + arg_119_0 then
				arg_116_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_119_6 = 0
			local var_119_7 = 0.525

			if var_119_6 < arg_116_1.time_ and arg_116_1.time_ <= var_119_6 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				local var_119_8 = arg_116_1:FormatText(StoryNameCfg[1467].name)

				arg_116_1.leftNameTxt_.text = var_119_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_9 = arg_116_1:GetWordFromCfg(325041028)
				local var_119_10 = arg_116_1:FormatText(var_119_9.content)

				arg_116_1.text_.text = var_119_10

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_11 = 21
				local var_119_12 = utf8.len(var_119_10)
				local var_119_13 = var_119_11 <= 0 and var_119_7 or var_119_7 * (var_119_12 / var_119_11)

				if var_119_13 > 0 and var_119_7 < var_119_13 then
					arg_116_1.talkMaxDuration = var_119_13

					if var_119_13 + var_119_6 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_13 + var_119_6
					end
				end

				arg_116_1.text_.text = var_119_10
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325041", "325041028", "story_v_out_325041.awb") ~= 0 then
					local var_119_14 = manager.audio:GetVoiceLength("story_v_out_325041", "325041028", "story_v_out_325041.awb") / 1000

					if var_119_14 + var_119_6 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_14 + var_119_6
					end

					if var_119_9.prefab_name ~= "" and arg_116_1.actors_[var_119_9.prefab_name] ~= nil then
						local var_119_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_116_1.actors_[var_119_9.prefab_name].transform, "story_v_out_325041", "325041028", "story_v_out_325041.awb")

						arg_116_1:RecordAudio("325041028", var_119_15)
						arg_116_1:RecordAudio("325041028", var_119_15)
					else
						arg_116_1:AudioAction("play", "voice", "story_v_out_325041", "325041028", "story_v_out_325041.awb")
					end

					arg_116_1:RecordHistoryTalkVoice("story_v_out_325041", "325041028", "story_v_out_325041.awb")
				end

				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_16 = math.max(var_119_7, arg_116_1.talkMaxDuration)

			if var_119_6 <= arg_116_1.time_ and arg_116_1.time_ < var_119_6 + var_119_16 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_6) / var_119_16

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_6 + var_119_16 and arg_116_1.time_ < var_119_6 + var_119_16 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {}

		arg_116_1:InitPlayNodeList()
	end,
	Play325041029 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 325041029
		arg_120_1.duration_ = 5

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"
		end

		function arg_120_1.playNext_(arg_122_0)
			if arg_122_0 == 1 then
				arg_120_0:Play325041030(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			local var_123_0 = arg_120_1.actors_["1077ui_story"].transform
			local var_123_1 = 0

			if var_123_1 < arg_120_1.time_ and arg_120_1.time_ <= var_123_1 + arg_123_0 then
				arg_120_1.var_.moveOldPos1077ui_story = var_123_0.localPosition

				local var_123_2 = GameObjectTools.GetOrAddComponent(var_123_0.gameObject, typeof(DynamicBoneHelper))

				if var_123_2 then
					var_123_2:EnableDynamicBone(false)
				end
			end

			local var_123_3 = 0.001

			if var_123_1 <= arg_120_1.time_ and arg_120_1.time_ < var_123_1 + var_123_3 then
				local var_123_4 = (arg_120_1.time_ - var_123_1) / var_123_3
				local var_123_5 = Vector3.New(0, 100, 0)

				var_123_0.localPosition = Vector3.Lerp(arg_120_1.var_.moveOldPos1077ui_story, var_123_5, var_123_4)

				local var_123_6 = manager.ui.mainCamera.transform.position - var_123_0.position

				var_123_0.forward = Vector3.New(var_123_6.x, var_123_6.y, var_123_6.z)

				local var_123_7 = var_123_0.localEulerAngles

				var_123_7.z = 0
				var_123_7.x = 0
				var_123_0.localEulerAngles = var_123_7
			end

			if arg_120_1.time_ >= var_123_1 + var_123_3 and arg_120_1.time_ < var_123_1 + var_123_3 + arg_123_0 then
				var_123_0.localPosition = Vector3.New(0, 100, 0)

				local var_123_8 = manager.ui.mainCamera.transform.position - var_123_0.position

				var_123_0.forward = Vector3.New(var_123_8.x, var_123_8.y, var_123_8.z)

				local var_123_9 = var_123_0.localEulerAngles

				var_123_9.z = 0
				var_123_9.x = 0
				var_123_0.localEulerAngles = var_123_9

				local var_123_10 = GameObjectTools.GetOrAddComponent(var_123_0.gameObject, typeof(DynamicBoneHelper))

				if var_123_10 then
					var_123_10:EnableDynamicBone(true)
				end
			end

			local var_123_11 = arg_120_1.actors_["1077ui_story"]
			local var_123_12 = 0

			if var_123_12 < arg_120_1.time_ and arg_120_1.time_ <= var_123_12 + arg_123_0 and not isNil(var_123_11) and arg_120_1.var_.characterEffect1077ui_story == nil then
				arg_120_1.var_.characterEffect1077ui_story = var_123_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_123_13 = 0.200000002980232

			if var_123_12 <= arg_120_1.time_ and arg_120_1.time_ < var_123_12 + var_123_13 and not isNil(var_123_11) then
				local var_123_14 = (arg_120_1.time_ - var_123_12) / var_123_13

				if arg_120_1.var_.characterEffect1077ui_story and not isNil(var_123_11) then
					local var_123_15 = Mathf.Lerp(0, 0.5, var_123_14)

					arg_120_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_120_1.var_.characterEffect1077ui_story.fillRatio = var_123_15
				end
			end

			if arg_120_1.time_ >= var_123_12 + var_123_13 and arg_120_1.time_ < var_123_12 + var_123_13 + arg_123_0 and not isNil(var_123_11) and arg_120_1.var_.characterEffect1077ui_story then
				local var_123_16 = 0.5

				arg_120_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_120_1.var_.characterEffect1077ui_story.fillRatio = var_123_16
			end

			local var_123_17 = 0.6
			local var_123_18 = 1

			if var_123_17 < arg_120_1.time_ and arg_120_1.time_ <= var_123_17 + arg_123_0 then
				local var_123_19 = "play"
				local var_123_20 = "effect"

				arg_120_1:AudioAction(var_123_19, var_123_20, "se_story_148", "se_story_148_cloth", "")
			end

			local var_123_21 = 0
			local var_123_22 = 0.95

			if var_123_21 < arg_120_1.time_ and arg_120_1.time_ <= var_123_21 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, false)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_23 = arg_120_1:GetWordFromCfg(325041029)
				local var_123_24 = arg_120_1:FormatText(var_123_23.content)

				arg_120_1.text_.text = var_123_24

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_25 = 38
				local var_123_26 = utf8.len(var_123_24)
				local var_123_27 = var_123_25 <= 0 and var_123_22 or var_123_22 * (var_123_26 / var_123_25)

				if var_123_27 > 0 and var_123_22 < var_123_27 then
					arg_120_1.talkMaxDuration = var_123_27

					if var_123_27 + var_123_21 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_27 + var_123_21
					end
				end

				arg_120_1.text_.text = var_123_24
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)
				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_28 = math.max(var_123_22, arg_120_1.talkMaxDuration)

			if var_123_21 <= arg_120_1.time_ and arg_120_1.time_ < var_123_21 + var_123_28 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_21) / var_123_28

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_21 + var_123_28 and arg_120_1.time_ < var_123_21 + var_123_28 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {
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

		arg_120_1:InitPlayNodeList()
	end,
	Play325041030 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 325041030
		arg_124_1.duration_ = 7.17

		local var_124_0 = {
			zh = 7.166,
			ja = 5.8
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
				arg_124_0:Play325041031(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			local var_127_0 = arg_124_1.actors_["1077ui_story"].transform
			local var_127_1 = 0

			if var_127_1 < arg_124_1.time_ and arg_124_1.time_ <= var_127_1 + arg_127_0 then
				arg_124_1.var_.moveOldPos1077ui_story = var_127_0.localPosition

				local var_127_2 = GameObjectTools.GetOrAddComponent(var_127_0.gameObject, typeof(DynamicBoneHelper))

				if var_127_2 then
					var_127_2:EnableDynamicBone(false)
				end
			end

			local var_127_3 = 0.001

			if var_127_1 <= arg_124_1.time_ and arg_124_1.time_ < var_127_1 + var_127_3 then
				local var_127_4 = (arg_124_1.time_ - var_127_1) / var_127_3
				local var_127_5 = Vector3.New(-0.03, -1.02, -5.92)

				var_127_0.localPosition = Vector3.Lerp(arg_124_1.var_.moveOldPos1077ui_story, var_127_5, var_127_4)

				local var_127_6 = manager.ui.mainCamera.transform.position - var_127_0.position

				var_127_0.forward = Vector3.New(var_127_6.x, var_127_6.y, var_127_6.z)

				local var_127_7 = var_127_0.localEulerAngles

				var_127_7.z = 0
				var_127_7.x = 0
				var_127_0.localEulerAngles = var_127_7
			end

			if arg_124_1.time_ >= var_127_1 + var_127_3 and arg_124_1.time_ < var_127_1 + var_127_3 + arg_127_0 then
				var_127_0.localPosition = Vector3.New(-0.03, -1.02, -5.92)

				local var_127_8 = manager.ui.mainCamera.transform.position - var_127_0.position

				var_127_0.forward = Vector3.New(var_127_8.x, var_127_8.y, var_127_8.z)

				local var_127_9 = var_127_0.localEulerAngles

				var_127_9.z = 0
				var_127_9.x = 0
				var_127_0.localEulerAngles = var_127_9

				local var_127_10 = GameObjectTools.GetOrAddComponent(var_127_0.gameObject, typeof(DynamicBoneHelper))

				if var_127_10 then
					var_127_10:EnableDynamicBone(true)
				end
			end

			local var_127_11 = arg_124_1.actors_["1077ui_story"]
			local var_127_12 = 0

			if var_127_12 < arg_124_1.time_ and arg_124_1.time_ <= var_127_12 + arg_127_0 and not isNil(var_127_11) and arg_124_1.var_.characterEffect1077ui_story == nil then
				arg_124_1.var_.characterEffect1077ui_story = var_127_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_127_13 = 0.200000002980232

			if var_127_12 <= arg_124_1.time_ and arg_124_1.time_ < var_127_12 + var_127_13 and not isNil(var_127_11) then
				local var_127_14 = (arg_124_1.time_ - var_127_12) / var_127_13

				if arg_124_1.var_.characterEffect1077ui_story and not isNil(var_127_11) then
					arg_124_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_124_1.time_ >= var_127_12 + var_127_13 and arg_124_1.time_ < var_127_12 + var_127_13 + arg_127_0 and not isNil(var_127_11) and arg_124_1.var_.characterEffect1077ui_story then
				arg_124_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_127_15 = 0
			local var_127_16 = 0.6

			if var_127_15 < arg_124_1.time_ and arg_124_1.time_ <= var_127_15 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				local var_127_17 = arg_124_1:FormatText(StoryNameCfg[1467].name)

				arg_124_1.leftNameTxt_.text = var_127_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_18 = arg_124_1:GetWordFromCfg(325041030)
				local var_127_19 = arg_124_1:FormatText(var_127_18.content)

				arg_124_1.text_.text = var_127_19

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_20 = 24
				local var_127_21 = utf8.len(var_127_19)
				local var_127_22 = var_127_20 <= 0 and var_127_16 or var_127_16 * (var_127_21 / var_127_20)

				if var_127_22 > 0 and var_127_16 < var_127_22 then
					arg_124_1.talkMaxDuration = var_127_22

					if var_127_22 + var_127_15 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_22 + var_127_15
					end
				end

				arg_124_1.text_.text = var_127_19
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325041", "325041030", "story_v_out_325041.awb") ~= 0 then
					local var_127_23 = manager.audio:GetVoiceLength("story_v_out_325041", "325041030", "story_v_out_325041.awb") / 1000

					if var_127_23 + var_127_15 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_23 + var_127_15
					end

					if var_127_18.prefab_name ~= "" and arg_124_1.actors_[var_127_18.prefab_name] ~= nil then
						local var_127_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_124_1.actors_[var_127_18.prefab_name].transform, "story_v_out_325041", "325041030", "story_v_out_325041.awb")

						arg_124_1:RecordAudio("325041030", var_127_24)
						arg_124_1:RecordAudio("325041030", var_127_24)
					else
						arg_124_1:AudioAction("play", "voice", "story_v_out_325041", "325041030", "story_v_out_325041.awb")
					end

					arg_124_1:RecordHistoryTalkVoice("story_v_out_325041", "325041030", "story_v_out_325041.awb")
				end

				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_25 = math.max(var_127_16, arg_124_1.talkMaxDuration)

			if var_127_15 <= arg_124_1.time_ and arg_124_1.time_ < var_127_15 + var_127_25 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_15) / var_127_25

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_15 + var_127_25 and arg_124_1.time_ < var_127_15 + var_127_25 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {
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

		arg_124_1:InitPlayNodeList()
	end,
	Play325041031 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 325041031
		arg_128_1.duration_ = 16.17

		local var_128_0 = {
			zh = 12.166,
			ja = 16.166
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
				arg_128_0:Play325041032(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			local var_131_0 = 0

			if var_131_0 < arg_128_1.time_ and arg_128_1.time_ <= var_131_0 + arg_131_0 then
				arg_128_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action3_1")
			end

			local var_131_1 = 0

			if var_131_1 < arg_128_1.time_ and arg_128_1.time_ <= var_131_1 + arg_131_0 then
				arg_128_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_131_2 = 0
			local var_131_3 = 0.975

			if var_131_2 < arg_128_1.time_ and arg_128_1.time_ <= var_131_2 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				local var_131_4 = arg_128_1:FormatText(StoryNameCfg[1467].name)

				arg_128_1.leftNameTxt_.text = var_131_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_5 = arg_128_1:GetWordFromCfg(325041031)
				local var_131_6 = arg_128_1:FormatText(var_131_5.content)

				arg_128_1.text_.text = var_131_6

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_7 = 39
				local var_131_8 = utf8.len(var_131_6)
				local var_131_9 = var_131_7 <= 0 and var_131_3 or var_131_3 * (var_131_8 / var_131_7)

				if var_131_9 > 0 and var_131_3 < var_131_9 then
					arg_128_1.talkMaxDuration = var_131_9

					if var_131_9 + var_131_2 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_9 + var_131_2
					end
				end

				arg_128_1.text_.text = var_131_6
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325041", "325041031", "story_v_out_325041.awb") ~= 0 then
					local var_131_10 = manager.audio:GetVoiceLength("story_v_out_325041", "325041031", "story_v_out_325041.awb") / 1000

					if var_131_10 + var_131_2 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_10 + var_131_2
					end

					if var_131_5.prefab_name ~= "" and arg_128_1.actors_[var_131_5.prefab_name] ~= nil then
						local var_131_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_5.prefab_name].transform, "story_v_out_325041", "325041031", "story_v_out_325041.awb")

						arg_128_1:RecordAudio("325041031", var_131_11)
						arg_128_1:RecordAudio("325041031", var_131_11)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_out_325041", "325041031", "story_v_out_325041.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_out_325041", "325041031", "story_v_out_325041.awb")
				end

				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_12 = math.max(var_131_3, arg_128_1.talkMaxDuration)

			if var_131_2 <= arg_128_1.time_ and arg_128_1.time_ < var_131_2 + var_131_12 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_2) / var_131_12

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_2 + var_131_12 and arg_128_1.time_ < var_131_2 + var_131_12 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {}

		arg_128_1:InitPlayNodeList()
	end,
	Play325041032 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 325041032
		arg_132_1.duration_ = 3.23

		local var_132_0 = {
			zh = 2.833,
			ja = 3.233
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
				arg_132_0:Play325041033(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			local var_135_0 = arg_132_1.actors_["1077ui_story"]
			local var_135_1 = 0

			if var_135_1 < arg_132_1.time_ and arg_132_1.time_ <= var_135_1 + arg_135_0 and not isNil(var_135_0) and arg_132_1.var_.characterEffect1077ui_story == nil then
				arg_132_1.var_.characterEffect1077ui_story = var_135_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_135_2 = 0.200000002980232

			if var_135_1 <= arg_132_1.time_ and arg_132_1.time_ < var_135_1 + var_135_2 and not isNil(var_135_0) then
				local var_135_3 = (arg_132_1.time_ - var_135_1) / var_135_2

				if arg_132_1.var_.characterEffect1077ui_story and not isNil(var_135_0) then
					local var_135_4 = Mathf.Lerp(0, 0.5, var_135_3)

					arg_132_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_132_1.var_.characterEffect1077ui_story.fillRatio = var_135_4
				end
			end

			if arg_132_1.time_ >= var_135_1 + var_135_2 and arg_132_1.time_ < var_135_1 + var_135_2 + arg_135_0 and not isNil(var_135_0) and arg_132_1.var_.characterEffect1077ui_story then
				local var_135_5 = 0.5

				arg_132_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_132_1.var_.characterEffect1077ui_story.fillRatio = var_135_5
			end

			local var_135_6 = 0
			local var_135_7 = 0.275

			if var_135_6 < arg_132_1.time_ and arg_132_1.time_ <= var_135_6 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				local var_135_8 = arg_132_1:FormatText(StoryNameCfg[1454].name)

				arg_132_1.leftNameTxt_.text = var_135_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, true)
				arg_132_1.iconController_:SetSelectedState("hero")

				arg_132_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10169")

				arg_132_1.callingController_:SetSelectedState("normal")

				arg_132_1.keyicon_.color = Color.New(1, 1, 1)
				arg_132_1.icon_.color = Color.New(1, 1, 1)

				local var_135_9 = arg_132_1:GetWordFromCfg(325041032)
				local var_135_10 = arg_132_1:FormatText(var_135_9.content)

				arg_132_1.text_.text = var_135_10

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_11 = 11
				local var_135_12 = utf8.len(var_135_10)
				local var_135_13 = var_135_11 <= 0 and var_135_7 or var_135_7 * (var_135_12 / var_135_11)

				if var_135_13 > 0 and var_135_7 < var_135_13 then
					arg_132_1.talkMaxDuration = var_135_13

					if var_135_13 + var_135_6 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_13 + var_135_6
					end
				end

				arg_132_1.text_.text = var_135_10
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325041", "325041032", "story_v_out_325041.awb") ~= 0 then
					local var_135_14 = manager.audio:GetVoiceLength("story_v_out_325041", "325041032", "story_v_out_325041.awb") / 1000

					if var_135_14 + var_135_6 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_14 + var_135_6
					end

					if var_135_9.prefab_name ~= "" and arg_132_1.actors_[var_135_9.prefab_name] ~= nil then
						local var_135_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_9.prefab_name].transform, "story_v_out_325041", "325041032", "story_v_out_325041.awb")

						arg_132_1:RecordAudio("325041032", var_135_15)
						arg_132_1:RecordAudio("325041032", var_135_15)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_out_325041", "325041032", "story_v_out_325041.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_out_325041", "325041032", "story_v_out_325041.awb")
				end

				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_16 = math.max(var_135_7, arg_132_1.talkMaxDuration)

			if var_135_6 <= arg_132_1.time_ and arg_132_1.time_ < var_135_6 + var_135_16 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_6) / var_135_16

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_6 + var_135_16 and arg_132_1.time_ < var_135_6 + var_135_16 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {}

		arg_132_1:InitPlayNodeList()
	end,
	Play325041033 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 325041033
		arg_136_1.duration_ = 11.27

		local var_136_0 = {
			zh = 10.7,
			ja = 11.266
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
				arg_136_0:Play325041034(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			local var_139_0 = arg_136_1.actors_["1077ui_story"]
			local var_139_1 = 0

			if var_139_1 < arg_136_1.time_ and arg_136_1.time_ <= var_139_1 + arg_139_0 and not isNil(var_139_0) and arg_136_1.var_.characterEffect1077ui_story == nil then
				arg_136_1.var_.characterEffect1077ui_story = var_139_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_139_2 = 0.200000002980232

			if var_139_1 <= arg_136_1.time_ and arg_136_1.time_ < var_139_1 + var_139_2 and not isNil(var_139_0) then
				local var_139_3 = (arg_136_1.time_ - var_139_1) / var_139_2

				if arg_136_1.var_.characterEffect1077ui_story and not isNil(var_139_0) then
					arg_136_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_136_1.time_ >= var_139_1 + var_139_2 and arg_136_1.time_ < var_139_1 + var_139_2 + arg_139_0 and not isNil(var_139_0) and arg_136_1.var_.characterEffect1077ui_story then
				arg_136_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_139_4 = 0
			local var_139_5 = 1.15

			if var_139_4 < arg_136_1.time_ and arg_136_1.time_ <= var_139_4 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				local var_139_6 = arg_136_1:FormatText(StoryNameCfg[1467].name)

				arg_136_1.leftNameTxt_.text = var_139_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_7 = arg_136_1:GetWordFromCfg(325041033)
				local var_139_8 = arg_136_1:FormatText(var_139_7.content)

				arg_136_1.text_.text = var_139_8

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_9 = 46
				local var_139_10 = utf8.len(var_139_8)
				local var_139_11 = var_139_9 <= 0 and var_139_5 or var_139_5 * (var_139_10 / var_139_9)

				if var_139_11 > 0 and var_139_5 < var_139_11 then
					arg_136_1.talkMaxDuration = var_139_11

					if var_139_11 + var_139_4 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_11 + var_139_4
					end
				end

				arg_136_1.text_.text = var_139_8
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325041", "325041033", "story_v_out_325041.awb") ~= 0 then
					local var_139_12 = manager.audio:GetVoiceLength("story_v_out_325041", "325041033", "story_v_out_325041.awb") / 1000

					if var_139_12 + var_139_4 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_12 + var_139_4
					end

					if var_139_7.prefab_name ~= "" and arg_136_1.actors_[var_139_7.prefab_name] ~= nil then
						local var_139_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_136_1.actors_[var_139_7.prefab_name].transform, "story_v_out_325041", "325041033", "story_v_out_325041.awb")

						arg_136_1:RecordAudio("325041033", var_139_13)
						arg_136_1:RecordAudio("325041033", var_139_13)
					else
						arg_136_1:AudioAction("play", "voice", "story_v_out_325041", "325041033", "story_v_out_325041.awb")
					end

					arg_136_1:RecordHistoryTalkVoice("story_v_out_325041", "325041033", "story_v_out_325041.awb")
				end

				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_14 = math.max(var_139_5, arg_136_1.talkMaxDuration)

			if var_139_4 <= arg_136_1.time_ and arg_136_1.time_ < var_139_4 + var_139_14 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_4) / var_139_14

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_4 + var_139_14 and arg_136_1.time_ < var_139_4 + var_139_14 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {}

		arg_136_1:InitPlayNodeList()
	end,
	Play325041034 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 325041034
		arg_140_1.duration_ = 14.37

		local var_140_0 = {
			zh = 9.1,
			ja = 14.366
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
				arg_140_0:Play325041035(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			local var_143_0 = arg_140_1.actors_["1077ui_story"]
			local var_143_1 = 0

			if var_143_1 < arg_140_1.time_ and arg_140_1.time_ <= var_143_1 + arg_143_0 and not isNil(var_143_0) and arg_140_1.var_.characterEffect1077ui_story == nil then
				arg_140_1.var_.characterEffect1077ui_story = var_143_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_143_2 = 0.200000002980232

			if var_143_1 <= arg_140_1.time_ and arg_140_1.time_ < var_143_1 + var_143_2 and not isNil(var_143_0) then
				local var_143_3 = (arg_140_1.time_ - var_143_1) / var_143_2

				if arg_140_1.var_.characterEffect1077ui_story and not isNil(var_143_0) then
					local var_143_4 = Mathf.Lerp(0, 0.5, var_143_3)

					arg_140_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_140_1.var_.characterEffect1077ui_story.fillRatio = var_143_4
				end
			end

			if arg_140_1.time_ >= var_143_1 + var_143_2 and arg_140_1.time_ < var_143_1 + var_143_2 + arg_143_0 and not isNil(var_143_0) and arg_140_1.var_.characterEffect1077ui_story then
				local var_143_5 = 0.5

				arg_140_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_140_1.var_.characterEffect1077ui_story.fillRatio = var_143_5
			end

			local var_143_6 = 0
			local var_143_7 = 0.85

			if var_143_6 < arg_140_1.time_ and arg_140_1.time_ <= var_143_6 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, true)

				local var_143_8 = arg_140_1:FormatText(StoryNameCfg[1454].name)

				arg_140_1.leftNameTxt_.text = var_143_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_140_1.leftNameTxt_.transform)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1.leftNameTxt_.text)
				SetActive(arg_140_1.iconTrs_.gameObject, true)
				arg_140_1.iconController_:SetSelectedState("hero")

				arg_140_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10169")

				arg_140_1.callingController_:SetSelectedState("normal")

				arg_140_1.keyicon_.color = Color.New(1, 1, 1)
				arg_140_1.icon_.color = Color.New(1, 1, 1)

				local var_143_9 = arg_140_1:GetWordFromCfg(325041034)
				local var_143_10 = arg_140_1:FormatText(var_143_9.content)

				arg_140_1.text_.text = var_143_10

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_11 = 34
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

				if manager.audio:GetVoiceLength("story_v_out_325041", "325041034", "story_v_out_325041.awb") ~= 0 then
					local var_143_14 = manager.audio:GetVoiceLength("story_v_out_325041", "325041034", "story_v_out_325041.awb") / 1000

					if var_143_14 + var_143_6 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_14 + var_143_6
					end

					if var_143_9.prefab_name ~= "" and arg_140_1.actors_[var_143_9.prefab_name] ~= nil then
						local var_143_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_140_1.actors_[var_143_9.prefab_name].transform, "story_v_out_325041", "325041034", "story_v_out_325041.awb")

						arg_140_1:RecordAudio("325041034", var_143_15)
						arg_140_1:RecordAudio("325041034", var_143_15)
					else
						arg_140_1:AudioAction("play", "voice", "story_v_out_325041", "325041034", "story_v_out_325041.awb")
					end

					arg_140_1:RecordHistoryTalkVoice("story_v_out_325041", "325041034", "story_v_out_325041.awb")
				end

				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_16 = math.max(var_143_7, arg_140_1.talkMaxDuration)

			if var_143_6 <= arg_140_1.time_ and arg_140_1.time_ < var_143_6 + var_143_16 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_6) / var_143_16

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_6 + var_143_16 and arg_140_1.time_ < var_143_6 + var_143_16 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {}

		arg_140_1:InitPlayNodeList()
	end,
	Play325041035 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 325041035
		arg_144_1.duration_ = 9.7

		local var_144_0 = {
			zh = 5.266,
			ja = 9.7
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
				arg_144_0:Play325041036(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			local var_147_0 = 0
			local var_147_1 = 0.625

			if var_147_0 < arg_144_1.time_ and arg_144_1.time_ <= var_147_0 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				local var_147_2 = arg_144_1:FormatText(StoryNameCfg[1454].name)

				arg_144_1.leftNameTxt_.text = var_147_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, true)
				arg_144_1.iconController_:SetSelectedState("hero")

				arg_144_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10169")

				arg_144_1.callingController_:SetSelectedState("normal")

				arg_144_1.keyicon_.color = Color.New(1, 1, 1)
				arg_144_1.icon_.color = Color.New(1, 1, 1)

				local var_147_3 = arg_144_1:GetWordFromCfg(325041035)
				local var_147_4 = arg_144_1:FormatText(var_147_3.content)

				arg_144_1.text_.text = var_147_4

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_5 = 25
				local var_147_6 = utf8.len(var_147_4)
				local var_147_7 = var_147_5 <= 0 and var_147_1 or var_147_1 * (var_147_6 / var_147_5)

				if var_147_7 > 0 and var_147_1 < var_147_7 then
					arg_144_1.talkMaxDuration = var_147_7

					if var_147_7 + var_147_0 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_7 + var_147_0
					end
				end

				arg_144_1.text_.text = var_147_4
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325041", "325041035", "story_v_out_325041.awb") ~= 0 then
					local var_147_8 = manager.audio:GetVoiceLength("story_v_out_325041", "325041035", "story_v_out_325041.awb") / 1000

					if var_147_8 + var_147_0 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_8 + var_147_0
					end

					if var_147_3.prefab_name ~= "" and arg_144_1.actors_[var_147_3.prefab_name] ~= nil then
						local var_147_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_144_1.actors_[var_147_3.prefab_name].transform, "story_v_out_325041", "325041035", "story_v_out_325041.awb")

						arg_144_1:RecordAudio("325041035", var_147_9)
						arg_144_1:RecordAudio("325041035", var_147_9)
					else
						arg_144_1:AudioAction("play", "voice", "story_v_out_325041", "325041035", "story_v_out_325041.awb")
					end

					arg_144_1:RecordHistoryTalkVoice("story_v_out_325041", "325041035", "story_v_out_325041.awb")
				end

				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_10 = math.max(var_147_1, arg_144_1.talkMaxDuration)

			if var_147_0 <= arg_144_1.time_ and arg_144_1.time_ < var_147_0 + var_147_10 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_0) / var_147_10

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_0 + var_147_10 and arg_144_1.time_ < var_147_0 + var_147_10 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {}

		arg_144_1:InitPlayNodeList()
	end,
	Play325041036 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 325041036
		arg_148_1.duration_ = 3.9

		local var_148_0 = {
			zh = 2.8,
			ja = 3.9
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
				arg_148_0:Play325041037(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			local var_151_0 = arg_148_1.actors_["1077ui_story"]
			local var_151_1 = 0

			if var_151_1 < arg_148_1.time_ and arg_148_1.time_ <= var_151_1 + arg_151_0 and not isNil(var_151_0) and arg_148_1.var_.characterEffect1077ui_story == nil then
				arg_148_1.var_.characterEffect1077ui_story = var_151_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_151_2 = 0.200000002980232

			if var_151_1 <= arg_148_1.time_ and arg_148_1.time_ < var_151_1 + var_151_2 and not isNil(var_151_0) then
				local var_151_3 = (arg_148_1.time_ - var_151_1) / var_151_2

				if arg_148_1.var_.characterEffect1077ui_story and not isNil(var_151_0) then
					arg_148_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_148_1.time_ >= var_151_1 + var_151_2 and arg_148_1.time_ < var_151_1 + var_151_2 + arg_151_0 and not isNil(var_151_0) and arg_148_1.var_.characterEffect1077ui_story then
				arg_148_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_151_4 = 0

			if var_151_4 < arg_148_1.time_ and arg_148_1.time_ <= var_151_4 + arg_151_0 then
				arg_148_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action3_2")
			end

			local var_151_5 = 0

			if var_151_5 < arg_148_1.time_ and arg_148_1.time_ <= var_151_5 + arg_151_0 then
				arg_148_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_151_6 = 0
			local var_151_7 = 0.3

			if var_151_6 < arg_148_1.time_ and arg_148_1.time_ <= var_151_6 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, true)

				local var_151_8 = arg_148_1:FormatText(StoryNameCfg[1467].name)

				arg_148_1.leftNameTxt_.text = var_151_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_148_1.leftNameTxt_.transform)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1.leftNameTxt_.text)
				SetActive(arg_148_1.iconTrs_.gameObject, false)
				arg_148_1.callingController_:SetSelectedState("normal")

				local var_151_9 = arg_148_1:GetWordFromCfg(325041036)
				local var_151_10 = arg_148_1:FormatText(var_151_9.content)

				arg_148_1.text_.text = var_151_10

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_11 = 12
				local var_151_12 = utf8.len(var_151_10)
				local var_151_13 = var_151_11 <= 0 and var_151_7 or var_151_7 * (var_151_12 / var_151_11)

				if var_151_13 > 0 and var_151_7 < var_151_13 then
					arg_148_1.talkMaxDuration = var_151_13

					if var_151_13 + var_151_6 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_13 + var_151_6
					end
				end

				arg_148_1.text_.text = var_151_10
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325041", "325041036", "story_v_out_325041.awb") ~= 0 then
					local var_151_14 = manager.audio:GetVoiceLength("story_v_out_325041", "325041036", "story_v_out_325041.awb") / 1000

					if var_151_14 + var_151_6 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_14 + var_151_6
					end

					if var_151_9.prefab_name ~= "" and arg_148_1.actors_[var_151_9.prefab_name] ~= nil then
						local var_151_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_148_1.actors_[var_151_9.prefab_name].transform, "story_v_out_325041", "325041036", "story_v_out_325041.awb")

						arg_148_1:RecordAudio("325041036", var_151_15)
						arg_148_1:RecordAudio("325041036", var_151_15)
					else
						arg_148_1:AudioAction("play", "voice", "story_v_out_325041", "325041036", "story_v_out_325041.awb")
					end

					arg_148_1:RecordHistoryTalkVoice("story_v_out_325041", "325041036", "story_v_out_325041.awb")
				end

				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_16 = math.max(var_151_7, arg_148_1.talkMaxDuration)

			if var_151_6 <= arg_148_1.time_ and arg_148_1.time_ < var_151_6 + var_151_16 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_6) / var_151_16

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_6 + var_151_16 and arg_148_1.time_ < var_151_6 + var_151_16 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {}

		arg_148_1:InitPlayNodeList()
	end,
	Play325041037 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 325041037
		arg_152_1.duration_ = 5.8

		local var_152_0 = {
			zh = 3.066,
			ja = 5.8
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
				arg_152_0:Play325041038(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			local var_155_0 = arg_152_1.actors_["1077ui_story"]
			local var_155_1 = 0

			if var_155_1 < arg_152_1.time_ and arg_152_1.time_ <= var_155_1 + arg_155_0 and not isNil(var_155_0) and arg_152_1.var_.characterEffect1077ui_story == nil then
				arg_152_1.var_.characterEffect1077ui_story = var_155_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_155_2 = 0.200000002980232

			if var_155_1 <= arg_152_1.time_ and arg_152_1.time_ < var_155_1 + var_155_2 and not isNil(var_155_0) then
				local var_155_3 = (arg_152_1.time_ - var_155_1) / var_155_2

				if arg_152_1.var_.characterEffect1077ui_story and not isNil(var_155_0) then
					local var_155_4 = Mathf.Lerp(0, 0.5, var_155_3)

					arg_152_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_152_1.var_.characterEffect1077ui_story.fillRatio = var_155_4
				end
			end

			if arg_152_1.time_ >= var_155_1 + var_155_2 and arg_152_1.time_ < var_155_1 + var_155_2 + arg_155_0 and not isNil(var_155_0) and arg_152_1.var_.characterEffect1077ui_story then
				local var_155_5 = 0.5

				arg_152_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_152_1.var_.characterEffect1077ui_story.fillRatio = var_155_5
			end

			local var_155_6 = 0
			local var_155_7 = 0.2

			if var_155_6 < arg_152_1.time_ and arg_152_1.time_ <= var_155_6 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, true)

				local var_155_8 = arg_152_1:FormatText(StoryNameCfg[1454].name)

				arg_152_1.leftNameTxt_.text = var_155_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_152_1.leftNameTxt_.transform)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1.leftNameTxt_.text)
				SetActive(arg_152_1.iconTrs_.gameObject, true)
				arg_152_1.iconController_:SetSelectedState("hero")

				arg_152_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10169")

				arg_152_1.callingController_:SetSelectedState("normal")

				arg_152_1.keyicon_.color = Color.New(1, 1, 1)
				arg_152_1.icon_.color = Color.New(1, 1, 1)

				local var_155_9 = arg_152_1:GetWordFromCfg(325041037)
				local var_155_10 = arg_152_1:FormatText(var_155_9.content)

				arg_152_1.text_.text = var_155_10

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_11 = 8
				local var_155_12 = utf8.len(var_155_10)
				local var_155_13 = var_155_11 <= 0 and var_155_7 or var_155_7 * (var_155_12 / var_155_11)

				if var_155_13 > 0 and var_155_7 < var_155_13 then
					arg_152_1.talkMaxDuration = var_155_13

					if var_155_13 + var_155_6 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_13 + var_155_6
					end
				end

				arg_152_1.text_.text = var_155_10
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325041", "325041037", "story_v_out_325041.awb") ~= 0 then
					local var_155_14 = manager.audio:GetVoiceLength("story_v_out_325041", "325041037", "story_v_out_325041.awb") / 1000

					if var_155_14 + var_155_6 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_14 + var_155_6
					end

					if var_155_9.prefab_name ~= "" and arg_152_1.actors_[var_155_9.prefab_name] ~= nil then
						local var_155_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_152_1.actors_[var_155_9.prefab_name].transform, "story_v_out_325041", "325041037", "story_v_out_325041.awb")

						arg_152_1:RecordAudio("325041037", var_155_15)
						arg_152_1:RecordAudio("325041037", var_155_15)
					else
						arg_152_1:AudioAction("play", "voice", "story_v_out_325041", "325041037", "story_v_out_325041.awb")
					end

					arg_152_1:RecordHistoryTalkVoice("story_v_out_325041", "325041037", "story_v_out_325041.awb")
				end

				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_16 = math.max(var_155_7, arg_152_1.talkMaxDuration)

			if var_155_6 <= arg_152_1.time_ and arg_152_1.time_ < var_155_6 + var_155_16 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - var_155_6) / var_155_16

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= var_155_6 + var_155_16 and arg_152_1.time_ < var_155_6 + var_155_16 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {}

		arg_152_1:InitPlayNodeList()
	end,
	Play325041038 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 325041038
		arg_156_1.duration_ = 11.3

		local var_156_0 = {
			zh = 7.9,
			ja = 11.3
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
				arg_156_0:Play325041039(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			local var_159_0 = arg_156_1.actors_["1077ui_story"]
			local var_159_1 = 0

			if var_159_1 < arg_156_1.time_ and arg_156_1.time_ <= var_159_1 + arg_159_0 and not isNil(var_159_0) and arg_156_1.var_.characterEffect1077ui_story == nil then
				arg_156_1.var_.characterEffect1077ui_story = var_159_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_159_2 = 0.200000002980232

			if var_159_1 <= arg_156_1.time_ and arg_156_1.time_ < var_159_1 + var_159_2 and not isNil(var_159_0) then
				local var_159_3 = (arg_156_1.time_ - var_159_1) / var_159_2

				if arg_156_1.var_.characterEffect1077ui_story and not isNil(var_159_0) then
					arg_156_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_156_1.time_ >= var_159_1 + var_159_2 and arg_156_1.time_ < var_159_1 + var_159_2 + arg_159_0 and not isNil(var_159_0) and arg_156_1.var_.characterEffect1077ui_story then
				arg_156_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_159_4 = 0
			local var_159_5 = 0.925

			if var_159_4 < arg_156_1.time_ and arg_156_1.time_ <= var_159_4 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, true)

				local var_159_6 = arg_156_1:FormatText(StoryNameCfg[1467].name)

				arg_156_1.leftNameTxt_.text = var_159_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_156_1.leftNameTxt_.transform)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1.leftNameTxt_.text)
				SetActive(arg_156_1.iconTrs_.gameObject, false)
				arg_156_1.callingController_:SetSelectedState("normal")

				local var_159_7 = arg_156_1:GetWordFromCfg(325041038)
				local var_159_8 = arg_156_1:FormatText(var_159_7.content)

				arg_156_1.text_.text = var_159_8

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_9 = 37
				local var_159_10 = utf8.len(var_159_8)
				local var_159_11 = var_159_9 <= 0 and var_159_5 or var_159_5 * (var_159_10 / var_159_9)

				if var_159_11 > 0 and var_159_5 < var_159_11 then
					arg_156_1.talkMaxDuration = var_159_11

					if var_159_11 + var_159_4 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_11 + var_159_4
					end
				end

				arg_156_1.text_.text = var_159_8
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325041", "325041038", "story_v_out_325041.awb") ~= 0 then
					local var_159_12 = manager.audio:GetVoiceLength("story_v_out_325041", "325041038", "story_v_out_325041.awb") / 1000

					if var_159_12 + var_159_4 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_12 + var_159_4
					end

					if var_159_7.prefab_name ~= "" and arg_156_1.actors_[var_159_7.prefab_name] ~= nil then
						local var_159_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_156_1.actors_[var_159_7.prefab_name].transform, "story_v_out_325041", "325041038", "story_v_out_325041.awb")

						arg_156_1:RecordAudio("325041038", var_159_13)
						arg_156_1:RecordAudio("325041038", var_159_13)
					else
						arg_156_1:AudioAction("play", "voice", "story_v_out_325041", "325041038", "story_v_out_325041.awb")
					end

					arg_156_1:RecordHistoryTalkVoice("story_v_out_325041", "325041038", "story_v_out_325041.awb")
				end

				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_14 = math.max(var_159_5, arg_156_1.talkMaxDuration)

			if var_159_4 <= arg_156_1.time_ and arg_156_1.time_ < var_159_4 + var_159_14 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_4) / var_159_14

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_4 + var_159_14 and arg_156_1.time_ < var_159_4 + var_159_14 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {}

		arg_156_1:InitPlayNodeList()
	end,
	Play325041039 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 325041039
		arg_160_1.duration_ = 11.7

		local var_160_0 = {
			zh = 11.7,
			ja = 10
		}
		local var_160_1 = manager.audio:GetLocalizationFlag()

		if var_160_0[var_160_1] ~= nil then
			arg_160_1.duration_ = var_160_0[var_160_1]
		end

		SetActive(arg_160_1.tipsGo_, false)

		function arg_160_1.onSingleLineFinish_()
			arg_160_1.onSingleLineUpdate_ = nil
			arg_160_1.onSingleLineFinish_ = nil
			arg_160_1.state_ = "waiting"
		end

		function arg_160_1.playNext_(arg_162_0)
			if arg_162_0 == 1 then
				arg_160_0:Play325041040(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			local var_163_0 = 0

			if var_163_0 < arg_160_1.time_ and arg_160_1.time_ <= var_163_0 + arg_163_0 then
				arg_160_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action5_1")
			end

			local var_163_1 = 0

			if var_163_1 < arg_160_1.time_ and arg_160_1.time_ <= var_163_1 + arg_163_0 then
				arg_160_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_163_2 = 0
			local var_163_3 = 1.175

			if var_163_2 < arg_160_1.time_ and arg_160_1.time_ <= var_163_2 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, true)

				local var_163_4 = arg_160_1:FormatText(StoryNameCfg[1467].name)

				arg_160_1.leftNameTxt_.text = var_163_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_160_1.leftNameTxt_.transform)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1.leftNameTxt_.text)
				SetActive(arg_160_1.iconTrs_.gameObject, false)
				arg_160_1.callingController_:SetSelectedState("normal")

				local var_163_5 = arg_160_1:GetWordFromCfg(325041039)
				local var_163_6 = arg_160_1:FormatText(var_163_5.content)

				arg_160_1.text_.text = var_163_6

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_7 = 47
				local var_163_8 = utf8.len(var_163_6)
				local var_163_9 = var_163_7 <= 0 and var_163_3 or var_163_3 * (var_163_8 / var_163_7)

				if var_163_9 > 0 and var_163_3 < var_163_9 then
					arg_160_1.talkMaxDuration = var_163_9

					if var_163_9 + var_163_2 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_9 + var_163_2
					end
				end

				arg_160_1.text_.text = var_163_6
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325041", "325041039", "story_v_out_325041.awb") ~= 0 then
					local var_163_10 = manager.audio:GetVoiceLength("story_v_out_325041", "325041039", "story_v_out_325041.awb") / 1000

					if var_163_10 + var_163_2 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_10 + var_163_2
					end

					if var_163_5.prefab_name ~= "" and arg_160_1.actors_[var_163_5.prefab_name] ~= nil then
						local var_163_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_160_1.actors_[var_163_5.prefab_name].transform, "story_v_out_325041", "325041039", "story_v_out_325041.awb")

						arg_160_1:RecordAudio("325041039", var_163_11)
						arg_160_1:RecordAudio("325041039", var_163_11)
					else
						arg_160_1:AudioAction("play", "voice", "story_v_out_325041", "325041039", "story_v_out_325041.awb")
					end

					arg_160_1:RecordHistoryTalkVoice("story_v_out_325041", "325041039", "story_v_out_325041.awb")
				end

				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_12 = math.max(var_163_3, arg_160_1.talkMaxDuration)

			if var_163_2 <= arg_160_1.time_ and arg_160_1.time_ < var_163_2 + var_163_12 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - var_163_2) / var_163_12

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= var_163_2 + var_163_12 and arg_160_1.time_ < var_163_2 + var_163_12 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {}

		arg_160_1:InitPlayNodeList()
	end,
	Play325041040 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 325041040
		arg_164_1.duration_ = 12.13

		local var_164_0 = {
			zh = 4.833,
			ja = 12.133
		}
		local var_164_1 = manager.audio:GetLocalizationFlag()

		if var_164_0[var_164_1] ~= nil then
			arg_164_1.duration_ = var_164_0[var_164_1]
		end

		SetActive(arg_164_1.tipsGo_, false)

		function arg_164_1.onSingleLineFinish_()
			arg_164_1.onSingleLineUpdate_ = nil
			arg_164_1.onSingleLineFinish_ = nil
			arg_164_1.state_ = "waiting"
		end

		function arg_164_1.playNext_(arg_166_0)
			if arg_166_0 == 1 then
				arg_164_0:Play325041041(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			local var_167_0 = 0
			local var_167_1 = 0.575

			if var_167_0 < arg_164_1.time_ and arg_164_1.time_ <= var_167_0 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0
				arg_164_1.dialogCg_.alpha = 1

				arg_164_1.dialog_:SetActive(true)
				SetActive(arg_164_1.leftNameGo_, true)

				local var_167_2 = arg_164_1:FormatText(StoryNameCfg[1467].name)

				arg_164_1.leftNameTxt_.text = var_167_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_164_1.leftNameTxt_.transform)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1.leftNameTxt_.text)
				SetActive(arg_164_1.iconTrs_.gameObject, false)
				arg_164_1.callingController_:SetSelectedState("normal")

				local var_167_3 = arg_164_1:GetWordFromCfg(325041040)
				local var_167_4 = arg_164_1:FormatText(var_167_3.content)

				arg_164_1.text_.text = var_167_4

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_5 = 23
				local var_167_6 = utf8.len(var_167_4)
				local var_167_7 = var_167_5 <= 0 and var_167_1 or var_167_1 * (var_167_6 / var_167_5)

				if var_167_7 > 0 and var_167_1 < var_167_7 then
					arg_164_1.talkMaxDuration = var_167_7

					if var_167_7 + var_167_0 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_7 + var_167_0
					end
				end

				arg_164_1.text_.text = var_167_4
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325041", "325041040", "story_v_out_325041.awb") ~= 0 then
					local var_167_8 = manager.audio:GetVoiceLength("story_v_out_325041", "325041040", "story_v_out_325041.awb") / 1000

					if var_167_8 + var_167_0 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_8 + var_167_0
					end

					if var_167_3.prefab_name ~= "" and arg_164_1.actors_[var_167_3.prefab_name] ~= nil then
						local var_167_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_164_1.actors_[var_167_3.prefab_name].transform, "story_v_out_325041", "325041040", "story_v_out_325041.awb")

						arg_164_1:RecordAudio("325041040", var_167_9)
						arg_164_1:RecordAudio("325041040", var_167_9)
					else
						arg_164_1:AudioAction("play", "voice", "story_v_out_325041", "325041040", "story_v_out_325041.awb")
					end

					arg_164_1:RecordHistoryTalkVoice("story_v_out_325041", "325041040", "story_v_out_325041.awb")
				end

				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_10 = math.max(var_167_1, arg_164_1.talkMaxDuration)

			if var_167_0 <= arg_164_1.time_ and arg_164_1.time_ < var_167_0 + var_167_10 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - var_167_0) / var_167_10

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= var_167_0 + var_167_10 and arg_164_1.time_ < var_167_0 + var_167_10 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {}

		arg_164_1:InitPlayNodeList()
	end,
	Play325041041 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 325041041
		arg_168_1.duration_ = 2.73

		local var_168_0 = {
			zh = 2,
			ja = 2.733
		}
		local var_168_1 = manager.audio:GetLocalizationFlag()

		if var_168_0[var_168_1] ~= nil then
			arg_168_1.duration_ = var_168_0[var_168_1]
		end

		SetActive(arg_168_1.tipsGo_, false)

		function arg_168_1.onSingleLineFinish_()
			arg_168_1.onSingleLineUpdate_ = nil
			arg_168_1.onSingleLineFinish_ = nil
			arg_168_1.state_ = "waiting"
		end

		function arg_168_1.playNext_(arg_170_0)
			if arg_170_0 == 1 then
				arg_168_0:Play325041042(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			local var_171_0 = arg_168_1.actors_["1077ui_story"]
			local var_171_1 = 0

			if var_171_1 < arg_168_1.time_ and arg_168_1.time_ <= var_171_1 + arg_171_0 and not isNil(var_171_0) and arg_168_1.var_.characterEffect1077ui_story == nil then
				arg_168_1.var_.characterEffect1077ui_story = var_171_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_171_2 = 0.200000002980232

			if var_171_1 <= arg_168_1.time_ and arg_168_1.time_ < var_171_1 + var_171_2 and not isNil(var_171_0) then
				local var_171_3 = (arg_168_1.time_ - var_171_1) / var_171_2

				if arg_168_1.var_.characterEffect1077ui_story and not isNil(var_171_0) then
					local var_171_4 = Mathf.Lerp(0, 0.5, var_171_3)

					arg_168_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_168_1.var_.characterEffect1077ui_story.fillRatio = var_171_4
				end
			end

			if arg_168_1.time_ >= var_171_1 + var_171_2 and arg_168_1.time_ < var_171_1 + var_171_2 + arg_171_0 and not isNil(var_171_0) and arg_168_1.var_.characterEffect1077ui_story then
				local var_171_5 = 0.5

				arg_168_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_168_1.var_.characterEffect1077ui_story.fillRatio = var_171_5
			end

			local var_171_6 = 0
			local var_171_7 = 0.225

			if var_171_6 < arg_168_1.time_ and arg_168_1.time_ <= var_171_6 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0
				arg_168_1.dialogCg_.alpha = 1

				arg_168_1.dialog_:SetActive(true)
				SetActive(arg_168_1.leftNameGo_, true)

				local var_171_8 = arg_168_1:FormatText(StoryNameCfg[1454].name)

				arg_168_1.leftNameTxt_.text = var_171_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_168_1.leftNameTxt_.transform)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1.leftNameTxt_.text)
				SetActive(arg_168_1.iconTrs_.gameObject, true)
				arg_168_1.iconController_:SetSelectedState("hero")

				arg_168_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10169")

				arg_168_1.callingController_:SetSelectedState("normal")

				arg_168_1.keyicon_.color = Color.New(1, 1, 1)
				arg_168_1.icon_.color = Color.New(1, 1, 1)

				local var_171_9 = arg_168_1:GetWordFromCfg(325041041)
				local var_171_10 = arg_168_1:FormatText(var_171_9.content)

				arg_168_1.text_.text = var_171_10

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_11 = 9
				local var_171_12 = utf8.len(var_171_10)
				local var_171_13 = var_171_11 <= 0 and var_171_7 or var_171_7 * (var_171_12 / var_171_11)

				if var_171_13 > 0 and var_171_7 < var_171_13 then
					arg_168_1.talkMaxDuration = var_171_13

					if var_171_13 + var_171_6 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_13 + var_171_6
					end
				end

				arg_168_1.text_.text = var_171_10
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325041", "325041041", "story_v_out_325041.awb") ~= 0 then
					local var_171_14 = manager.audio:GetVoiceLength("story_v_out_325041", "325041041", "story_v_out_325041.awb") / 1000

					if var_171_14 + var_171_6 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_14 + var_171_6
					end

					if var_171_9.prefab_name ~= "" and arg_168_1.actors_[var_171_9.prefab_name] ~= nil then
						local var_171_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_168_1.actors_[var_171_9.prefab_name].transform, "story_v_out_325041", "325041041", "story_v_out_325041.awb")

						arg_168_1:RecordAudio("325041041", var_171_15)
						arg_168_1:RecordAudio("325041041", var_171_15)
					else
						arg_168_1:AudioAction("play", "voice", "story_v_out_325041", "325041041", "story_v_out_325041.awb")
					end

					arg_168_1:RecordHistoryTalkVoice("story_v_out_325041", "325041041", "story_v_out_325041.awb")
				end

				arg_168_1:RecordContent(arg_168_1.text_.text)
			end

			local var_171_16 = math.max(var_171_7, arg_168_1.talkMaxDuration)

			if var_171_6 <= arg_168_1.time_ and arg_168_1.time_ < var_171_6 + var_171_16 then
				arg_168_1.typewritter.percent = (arg_168_1.time_ - var_171_6) / var_171_16

				arg_168_1.typewritter:SetDirty()
			end

			if arg_168_1.time_ >= var_171_6 + var_171_16 and arg_168_1.time_ < var_171_6 + var_171_16 + arg_171_0 then
				arg_168_1.typewritter.percent = 1

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(true)
			end
		end

		arg_168_1.nodeConfigList_ = {}

		arg_168_1:InitPlayNodeList()
	end,
	Play325041042 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 325041042
		arg_172_1.duration_ = 8

		local var_172_0 = {
			zh = 5.4,
			ja = 8
		}
		local var_172_1 = manager.audio:GetLocalizationFlag()

		if var_172_0[var_172_1] ~= nil then
			arg_172_1.duration_ = var_172_0[var_172_1]
		end

		SetActive(arg_172_1.tipsGo_, false)

		function arg_172_1.onSingleLineFinish_()
			arg_172_1.onSingleLineUpdate_ = nil
			arg_172_1.onSingleLineFinish_ = nil
			arg_172_1.state_ = "waiting"
		end

		function arg_172_1.playNext_(arg_174_0)
			if arg_174_0 == 1 then
				arg_172_0:Play325041043(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			local var_175_0 = arg_172_1.actors_["1077ui_story"]
			local var_175_1 = 0

			if var_175_1 < arg_172_1.time_ and arg_172_1.time_ <= var_175_1 + arg_175_0 and not isNil(var_175_0) and arg_172_1.var_.characterEffect1077ui_story == nil then
				arg_172_1.var_.characterEffect1077ui_story = var_175_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_175_2 = 0.200000002980232

			if var_175_1 <= arg_172_1.time_ and arg_172_1.time_ < var_175_1 + var_175_2 and not isNil(var_175_0) then
				local var_175_3 = (arg_172_1.time_ - var_175_1) / var_175_2

				if arg_172_1.var_.characterEffect1077ui_story and not isNil(var_175_0) then
					arg_172_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_172_1.time_ >= var_175_1 + var_175_2 and arg_172_1.time_ < var_175_1 + var_175_2 + arg_175_0 and not isNil(var_175_0) and arg_172_1.var_.characterEffect1077ui_story then
				arg_172_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_175_4 = 0

			if var_175_4 < arg_172_1.time_ and arg_172_1.time_ <= var_175_4 + arg_175_0 then
				arg_172_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action5_2")
			end

			local var_175_5 = 0
			local var_175_6 = 0.625

			if var_175_5 < arg_172_1.time_ and arg_172_1.time_ <= var_175_5 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, true)

				local var_175_7 = arg_172_1:FormatText(StoryNameCfg[1467].name)

				arg_172_1.leftNameTxt_.text = var_175_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_172_1.leftNameTxt_.transform)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1.leftNameTxt_.text)
				SetActive(arg_172_1.iconTrs_.gameObject, false)
				arg_172_1.callingController_:SetSelectedState("normal")

				local var_175_8 = arg_172_1:GetWordFromCfg(325041042)
				local var_175_9 = arg_172_1:FormatText(var_175_8.content)

				arg_172_1.text_.text = var_175_9

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_10 = 25
				local var_175_11 = utf8.len(var_175_9)
				local var_175_12 = var_175_10 <= 0 and var_175_6 or var_175_6 * (var_175_11 / var_175_10)

				if var_175_12 > 0 and var_175_6 < var_175_12 then
					arg_172_1.talkMaxDuration = var_175_12

					if var_175_12 + var_175_5 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_12 + var_175_5
					end
				end

				arg_172_1.text_.text = var_175_9
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325041", "325041042", "story_v_out_325041.awb") ~= 0 then
					local var_175_13 = manager.audio:GetVoiceLength("story_v_out_325041", "325041042", "story_v_out_325041.awb") / 1000

					if var_175_13 + var_175_5 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_13 + var_175_5
					end

					if var_175_8.prefab_name ~= "" and arg_172_1.actors_[var_175_8.prefab_name] ~= nil then
						local var_175_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_172_1.actors_[var_175_8.prefab_name].transform, "story_v_out_325041", "325041042", "story_v_out_325041.awb")

						arg_172_1:RecordAudio("325041042", var_175_14)
						arg_172_1:RecordAudio("325041042", var_175_14)
					else
						arg_172_1:AudioAction("play", "voice", "story_v_out_325041", "325041042", "story_v_out_325041.awb")
					end

					arg_172_1:RecordHistoryTalkVoice("story_v_out_325041", "325041042", "story_v_out_325041.awb")
				end

				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_15 = math.max(var_175_6, arg_172_1.talkMaxDuration)

			if var_175_5 <= arg_172_1.time_ and arg_172_1.time_ < var_175_5 + var_175_15 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - var_175_5) / var_175_15

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= var_175_5 + var_175_15 and arg_172_1.time_ < var_175_5 + var_175_15 + arg_175_0 then
				arg_172_1.typewritter.percent = 1

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(true)
			end
		end

		arg_172_1.nodeConfigList_ = {}

		arg_172_1:InitPlayNodeList()
	end,
	Play325041043 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 325041043
		arg_176_1.duration_ = 14.57

		local var_176_0 = {
			zh = 13.2,
			ja = 14.566
		}
		local var_176_1 = manager.audio:GetLocalizationFlag()

		if var_176_0[var_176_1] ~= nil then
			arg_176_1.duration_ = var_176_0[var_176_1]
		end

		SetActive(arg_176_1.tipsGo_, false)

		function arg_176_1.onSingleLineFinish_()
			arg_176_1.onSingleLineUpdate_ = nil
			arg_176_1.onSingleLineFinish_ = nil
			arg_176_1.state_ = "waiting"
		end

		function arg_176_1.playNext_(arg_178_0)
			if arg_178_0 == 1 then
				arg_176_0:Play325041044(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			local var_179_0 = 0
			local var_179_1 = 1.275

			if var_179_0 < arg_176_1.time_ and arg_176_1.time_ <= var_179_0 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0
				arg_176_1.dialogCg_.alpha = 1

				arg_176_1.dialog_:SetActive(true)
				SetActive(arg_176_1.leftNameGo_, true)

				local var_179_2 = arg_176_1:FormatText(StoryNameCfg[1467].name)

				arg_176_1.leftNameTxt_.text = var_179_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_176_1.leftNameTxt_.transform)

				arg_176_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_176_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_176_1:RecordName(arg_176_1.leftNameTxt_.text)
				SetActive(arg_176_1.iconTrs_.gameObject, false)
				arg_176_1.callingController_:SetSelectedState("normal")

				local var_179_3 = arg_176_1:GetWordFromCfg(325041043)
				local var_179_4 = arg_176_1:FormatText(var_179_3.content)

				arg_176_1.text_.text = var_179_4

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.text_)

				local var_179_5 = 51
				local var_179_6 = utf8.len(var_179_4)
				local var_179_7 = var_179_5 <= 0 and var_179_1 or var_179_1 * (var_179_6 / var_179_5)

				if var_179_7 > 0 and var_179_1 < var_179_7 then
					arg_176_1.talkMaxDuration = var_179_7

					if var_179_7 + var_179_0 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_7 + var_179_0
					end
				end

				arg_176_1.text_.text = var_179_4
				arg_176_1.typewritter.percent = 0

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325041", "325041043", "story_v_out_325041.awb") ~= 0 then
					local var_179_8 = manager.audio:GetVoiceLength("story_v_out_325041", "325041043", "story_v_out_325041.awb") / 1000

					if var_179_8 + var_179_0 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_8 + var_179_0
					end

					if var_179_3.prefab_name ~= "" and arg_176_1.actors_[var_179_3.prefab_name] ~= nil then
						local var_179_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_176_1.actors_[var_179_3.prefab_name].transform, "story_v_out_325041", "325041043", "story_v_out_325041.awb")

						arg_176_1:RecordAudio("325041043", var_179_9)
						arg_176_1:RecordAudio("325041043", var_179_9)
					else
						arg_176_1:AudioAction("play", "voice", "story_v_out_325041", "325041043", "story_v_out_325041.awb")
					end

					arg_176_1:RecordHistoryTalkVoice("story_v_out_325041", "325041043", "story_v_out_325041.awb")
				end

				arg_176_1:RecordContent(arg_176_1.text_.text)
			end

			local var_179_10 = math.max(var_179_1, arg_176_1.talkMaxDuration)

			if var_179_0 <= arg_176_1.time_ and arg_176_1.time_ < var_179_0 + var_179_10 then
				arg_176_1.typewritter.percent = (arg_176_1.time_ - var_179_0) / var_179_10

				arg_176_1.typewritter:SetDirty()
			end

			if arg_176_1.time_ >= var_179_0 + var_179_10 and arg_176_1.time_ < var_179_0 + var_179_10 + arg_179_0 then
				arg_176_1.typewritter.percent = 1

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(true)
			end
		end

		arg_176_1.nodeConfigList_ = {}

		arg_176_1:InitPlayNodeList()
	end,
	Play325041044 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 325041044
		arg_180_1.duration_ = 5

		SetActive(arg_180_1.tipsGo_, false)

		function arg_180_1.onSingleLineFinish_()
			arg_180_1.onSingleLineUpdate_ = nil
			arg_180_1.onSingleLineFinish_ = nil
			arg_180_1.state_ = "waiting"
		end

		function arg_180_1.playNext_(arg_182_0)
			if arg_182_0 == 1 then
				arg_180_0:Play325041045(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			local var_183_0 = arg_180_1.actors_["1077ui_story"].transform
			local var_183_1 = 0

			if var_183_1 < arg_180_1.time_ and arg_180_1.time_ <= var_183_1 + arg_183_0 then
				arg_180_1.var_.moveOldPos1077ui_story = var_183_0.localPosition

				local var_183_2 = GameObjectTools.GetOrAddComponent(var_183_0.gameObject, typeof(DynamicBoneHelper))

				if var_183_2 then
					var_183_2:EnableDynamicBone(false)
				end
			end

			local var_183_3 = 0.001

			if var_183_1 <= arg_180_1.time_ and arg_180_1.time_ < var_183_1 + var_183_3 then
				local var_183_4 = (arg_180_1.time_ - var_183_1) / var_183_3
				local var_183_5 = Vector3.New(0, 100, 0)

				var_183_0.localPosition = Vector3.Lerp(arg_180_1.var_.moveOldPos1077ui_story, var_183_5, var_183_4)

				local var_183_6 = manager.ui.mainCamera.transform.position - var_183_0.position

				var_183_0.forward = Vector3.New(var_183_6.x, var_183_6.y, var_183_6.z)

				local var_183_7 = var_183_0.localEulerAngles

				var_183_7.z = 0
				var_183_7.x = 0
				var_183_0.localEulerAngles = var_183_7
			end

			if arg_180_1.time_ >= var_183_1 + var_183_3 and arg_180_1.time_ < var_183_1 + var_183_3 + arg_183_0 then
				var_183_0.localPosition = Vector3.New(0, 100, 0)

				local var_183_8 = manager.ui.mainCamera.transform.position - var_183_0.position

				var_183_0.forward = Vector3.New(var_183_8.x, var_183_8.y, var_183_8.z)

				local var_183_9 = var_183_0.localEulerAngles

				var_183_9.z = 0
				var_183_9.x = 0
				var_183_0.localEulerAngles = var_183_9

				local var_183_10 = GameObjectTools.GetOrAddComponent(var_183_0.gameObject, typeof(DynamicBoneHelper))

				if var_183_10 then
					var_183_10:EnableDynamicBone(true)
				end
			end

			local var_183_11 = arg_180_1.actors_["1077ui_story"]
			local var_183_12 = 0

			if var_183_12 < arg_180_1.time_ and arg_180_1.time_ <= var_183_12 + arg_183_0 and not isNil(var_183_11) and arg_180_1.var_.characterEffect1077ui_story == nil then
				arg_180_1.var_.characterEffect1077ui_story = var_183_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_183_13 = 0.200000002980232

			if var_183_12 <= arg_180_1.time_ and arg_180_1.time_ < var_183_12 + var_183_13 and not isNil(var_183_11) then
				local var_183_14 = (arg_180_1.time_ - var_183_12) / var_183_13

				if arg_180_1.var_.characterEffect1077ui_story and not isNil(var_183_11) then
					local var_183_15 = Mathf.Lerp(0, 0.5, var_183_14)

					arg_180_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_180_1.var_.characterEffect1077ui_story.fillRatio = var_183_15
				end
			end

			if arg_180_1.time_ >= var_183_12 + var_183_13 and arg_180_1.time_ < var_183_12 + var_183_13 + arg_183_0 and not isNil(var_183_11) and arg_180_1.var_.characterEffect1077ui_story then
				local var_183_16 = 0.5

				arg_180_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_180_1.var_.characterEffect1077ui_story.fillRatio = var_183_16
			end

			local var_183_17 = 0
			local var_183_18 = 1.3

			if var_183_17 < arg_180_1.time_ and arg_180_1.time_ <= var_183_17 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0
				arg_180_1.dialogCg_.alpha = 1

				arg_180_1.dialog_:SetActive(true)
				SetActive(arg_180_1.leftNameGo_, false)

				arg_180_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_180_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_180_1:RecordName(arg_180_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_180_1.iconTrs_.gameObject, false)
				arg_180_1.callingController_:SetSelectedState("normal")

				local var_183_19 = arg_180_1:GetWordFromCfg(325041044)
				local var_183_20 = arg_180_1:FormatText(var_183_19.content)

				arg_180_1.text_.text = var_183_20

				LuaForUtil.ClearLinePrefixSymbol(arg_180_1.text_)

				local var_183_21 = 52
				local var_183_22 = utf8.len(var_183_20)
				local var_183_23 = var_183_21 <= 0 and var_183_18 or var_183_18 * (var_183_22 / var_183_21)

				if var_183_23 > 0 and var_183_18 < var_183_23 then
					arg_180_1.talkMaxDuration = var_183_23

					if var_183_23 + var_183_17 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_23 + var_183_17
					end
				end

				arg_180_1.text_.text = var_183_20
				arg_180_1.typewritter.percent = 0

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(false)
				arg_180_1:RecordContent(arg_180_1.text_.text)
			end

			local var_183_24 = math.max(var_183_18, arg_180_1.talkMaxDuration)

			if var_183_17 <= arg_180_1.time_ and arg_180_1.time_ < var_183_17 + var_183_24 then
				arg_180_1.typewritter.percent = (arg_180_1.time_ - var_183_17) / var_183_24

				arg_180_1.typewritter:SetDirty()
			end

			if arg_180_1.time_ >= var_183_17 + var_183_24 and arg_180_1.time_ < var_183_17 + var_183_24 + arg_183_0 then
				arg_180_1.typewritter.percent = 1

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(true)
			end
		end

		arg_180_1.nodeConfigList_ = {
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

		arg_180_1:InitPlayNodeList()
	end,
	Play325041045 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 325041045
		arg_184_1.duration_ = 6.93

		local var_184_0 = {
			zh = 4.633,
			ja = 6.933
		}
		local var_184_1 = manager.audio:GetLocalizationFlag()

		if var_184_0[var_184_1] ~= nil then
			arg_184_1.duration_ = var_184_0[var_184_1]
		end

		SetActive(arg_184_1.tipsGo_, false)

		function arg_184_1.onSingleLineFinish_()
			arg_184_1.onSingleLineUpdate_ = nil
			arg_184_1.onSingleLineFinish_ = nil
			arg_184_1.state_ = "waiting"
		end

		function arg_184_1.playNext_(arg_186_0)
			if arg_186_0 == 1 then
				arg_184_0:Play325041046(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			local var_187_0 = arg_184_1.actors_["1077ui_story"].transform
			local var_187_1 = 0

			if var_187_1 < arg_184_1.time_ and arg_184_1.time_ <= var_187_1 + arg_187_0 then
				arg_184_1.var_.moveOldPos1077ui_story = var_187_0.localPosition

				local var_187_2 = GameObjectTools.GetOrAddComponent(var_187_0.gameObject, typeof(DynamicBoneHelper))

				if var_187_2 then
					var_187_2:EnableDynamicBone(false)
				end
			end

			local var_187_3 = 0.001

			if var_187_1 <= arg_184_1.time_ and arg_184_1.time_ < var_187_1 + var_187_3 then
				local var_187_4 = (arg_184_1.time_ - var_187_1) / var_187_3
				local var_187_5 = Vector3.New(-0.03, -1.02, -5.92)

				var_187_0.localPosition = Vector3.Lerp(arg_184_1.var_.moveOldPos1077ui_story, var_187_5, var_187_4)

				local var_187_6 = manager.ui.mainCamera.transform.position - var_187_0.position

				var_187_0.forward = Vector3.New(var_187_6.x, var_187_6.y, var_187_6.z)

				local var_187_7 = var_187_0.localEulerAngles

				var_187_7.z = 0
				var_187_7.x = 0
				var_187_0.localEulerAngles = var_187_7
			end

			if arg_184_1.time_ >= var_187_1 + var_187_3 and arg_184_1.time_ < var_187_1 + var_187_3 + arg_187_0 then
				var_187_0.localPosition = Vector3.New(-0.03, -1.02, -5.92)

				local var_187_8 = manager.ui.mainCamera.transform.position - var_187_0.position

				var_187_0.forward = Vector3.New(var_187_8.x, var_187_8.y, var_187_8.z)

				local var_187_9 = var_187_0.localEulerAngles

				var_187_9.z = 0
				var_187_9.x = 0
				var_187_0.localEulerAngles = var_187_9

				local var_187_10 = GameObjectTools.GetOrAddComponent(var_187_0.gameObject, typeof(DynamicBoneHelper))

				if var_187_10 then
					var_187_10:EnableDynamicBone(true)
				end
			end

			local var_187_11 = arg_184_1.actors_["1077ui_story"]
			local var_187_12 = 0

			if var_187_12 < arg_184_1.time_ and arg_184_1.time_ <= var_187_12 + arg_187_0 and not isNil(var_187_11) and arg_184_1.var_.characterEffect1077ui_story == nil then
				arg_184_1.var_.characterEffect1077ui_story = var_187_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_187_13 = 0.200000002980232

			if var_187_12 <= arg_184_1.time_ and arg_184_1.time_ < var_187_12 + var_187_13 and not isNil(var_187_11) then
				local var_187_14 = (arg_184_1.time_ - var_187_12) / var_187_13

				if arg_184_1.var_.characterEffect1077ui_story and not isNil(var_187_11) then
					arg_184_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_184_1.time_ >= var_187_12 + var_187_13 and arg_184_1.time_ < var_187_12 + var_187_13 + arg_187_0 and not isNil(var_187_11) and arg_184_1.var_.characterEffect1077ui_story then
				arg_184_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_187_15 = 0

			if var_187_15 < arg_184_1.time_ and arg_184_1.time_ <= var_187_15 + arg_187_0 then
				arg_184_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action2_1")
			end

			local var_187_16 = 0

			if var_187_16 < arg_184_1.time_ and arg_184_1.time_ <= var_187_16 + arg_187_0 then
				arg_184_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_187_17 = 0
			local var_187_18 = 0.375

			if var_187_17 < arg_184_1.time_ and arg_184_1.time_ <= var_187_17 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0
				arg_184_1.dialogCg_.alpha = 1

				arg_184_1.dialog_:SetActive(true)
				SetActive(arg_184_1.leftNameGo_, true)

				local var_187_19 = arg_184_1:FormatText(StoryNameCfg[1467].name)

				arg_184_1.leftNameTxt_.text = var_187_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_184_1.leftNameTxt_.transform)

				arg_184_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_184_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_184_1:RecordName(arg_184_1.leftNameTxt_.text)
				SetActive(arg_184_1.iconTrs_.gameObject, false)
				arg_184_1.callingController_:SetSelectedState("normal")

				local var_187_20 = arg_184_1:GetWordFromCfg(325041045)
				local var_187_21 = arg_184_1:FormatText(var_187_20.content)

				arg_184_1.text_.text = var_187_21

				LuaForUtil.ClearLinePrefixSymbol(arg_184_1.text_)

				local var_187_22 = 15
				local var_187_23 = utf8.len(var_187_21)
				local var_187_24 = var_187_22 <= 0 and var_187_18 or var_187_18 * (var_187_23 / var_187_22)

				if var_187_24 > 0 and var_187_18 < var_187_24 then
					arg_184_1.talkMaxDuration = var_187_24

					if var_187_24 + var_187_17 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_24 + var_187_17
					end
				end

				arg_184_1.text_.text = var_187_21
				arg_184_1.typewritter.percent = 0

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325041", "325041045", "story_v_out_325041.awb") ~= 0 then
					local var_187_25 = manager.audio:GetVoiceLength("story_v_out_325041", "325041045", "story_v_out_325041.awb") / 1000

					if var_187_25 + var_187_17 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_25 + var_187_17
					end

					if var_187_20.prefab_name ~= "" and arg_184_1.actors_[var_187_20.prefab_name] ~= nil then
						local var_187_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_184_1.actors_[var_187_20.prefab_name].transform, "story_v_out_325041", "325041045", "story_v_out_325041.awb")

						arg_184_1:RecordAudio("325041045", var_187_26)
						arg_184_1:RecordAudio("325041045", var_187_26)
					else
						arg_184_1:AudioAction("play", "voice", "story_v_out_325041", "325041045", "story_v_out_325041.awb")
					end

					arg_184_1:RecordHistoryTalkVoice("story_v_out_325041", "325041045", "story_v_out_325041.awb")
				end

				arg_184_1:RecordContent(arg_184_1.text_.text)
			end

			local var_187_27 = math.max(var_187_18, arg_184_1.talkMaxDuration)

			if var_187_17 <= arg_184_1.time_ and arg_184_1.time_ < var_187_17 + var_187_27 then
				arg_184_1.typewritter.percent = (arg_184_1.time_ - var_187_17) / var_187_27

				arg_184_1.typewritter:SetDirty()
			end

			if arg_184_1.time_ >= var_187_17 + var_187_27 and arg_184_1.time_ < var_187_17 + var_187_27 + arg_187_0 then
				arg_184_1.typewritter.percent = 1

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(true)
			end
		end

		arg_184_1.nodeConfigList_ = {
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

		arg_184_1:InitPlayNodeList()
	end,
	Play325041046 = function(arg_188_0, arg_188_1)
		arg_188_1.time_ = 0
		arg_188_1.frameCnt_ = 0
		arg_188_1.state_ = "playing"
		arg_188_1.curTalkId_ = 325041046
		arg_188_1.duration_ = 6.6

		local var_188_0 = {
			zh = 3.666,
			ja = 6.6
		}
		local var_188_1 = manager.audio:GetLocalizationFlag()

		if var_188_0[var_188_1] ~= nil then
			arg_188_1.duration_ = var_188_0[var_188_1]
		end

		SetActive(arg_188_1.tipsGo_, false)

		function arg_188_1.onSingleLineFinish_()
			arg_188_1.onSingleLineUpdate_ = nil
			arg_188_1.onSingleLineFinish_ = nil
			arg_188_1.state_ = "waiting"
		end

		function arg_188_1.playNext_(arg_190_0)
			if arg_190_0 == 1 then
				arg_188_0:Play325041047(arg_188_1)
			end
		end

		function arg_188_1.onSingleLineUpdate_(arg_191_0)
			local var_191_0 = arg_188_1.actors_["1077ui_story"]
			local var_191_1 = 0

			if var_191_1 < arg_188_1.time_ and arg_188_1.time_ <= var_191_1 + arg_191_0 and not isNil(var_191_0) and arg_188_1.var_.characterEffect1077ui_story == nil then
				arg_188_1.var_.characterEffect1077ui_story = var_191_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_191_2 = 0.200000002980232

			if var_191_1 <= arg_188_1.time_ and arg_188_1.time_ < var_191_1 + var_191_2 and not isNil(var_191_0) then
				local var_191_3 = (arg_188_1.time_ - var_191_1) / var_191_2

				if arg_188_1.var_.characterEffect1077ui_story and not isNil(var_191_0) then
					local var_191_4 = Mathf.Lerp(0, 0.5, var_191_3)

					arg_188_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_188_1.var_.characterEffect1077ui_story.fillRatio = var_191_4
				end
			end

			if arg_188_1.time_ >= var_191_1 + var_191_2 and arg_188_1.time_ < var_191_1 + var_191_2 + arg_191_0 and not isNil(var_191_0) and arg_188_1.var_.characterEffect1077ui_story then
				local var_191_5 = 0.5

				arg_188_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_188_1.var_.characterEffect1077ui_story.fillRatio = var_191_5
			end

			local var_191_6 = 0
			local var_191_7 = 0.325

			if var_191_6 < arg_188_1.time_ and arg_188_1.time_ <= var_191_6 + arg_191_0 then
				arg_188_1.talkMaxDuration = 0
				arg_188_1.dialogCg_.alpha = 1

				arg_188_1.dialog_:SetActive(true)
				SetActive(arg_188_1.leftNameGo_, true)

				local var_191_8 = arg_188_1:FormatText(StoryNameCfg[1454].name)

				arg_188_1.leftNameTxt_.text = var_191_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_188_1.leftNameTxt_.transform)

				arg_188_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_188_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_188_1:RecordName(arg_188_1.leftNameTxt_.text)
				SetActive(arg_188_1.iconTrs_.gameObject, true)
				arg_188_1.iconController_:SetSelectedState("hero")

				arg_188_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10169")

				arg_188_1.callingController_:SetSelectedState("normal")

				arg_188_1.keyicon_.color = Color.New(1, 1, 1)
				arg_188_1.icon_.color = Color.New(1, 1, 1)

				local var_191_9 = arg_188_1:GetWordFromCfg(325041046)
				local var_191_10 = arg_188_1:FormatText(var_191_9.content)

				arg_188_1.text_.text = var_191_10

				LuaForUtil.ClearLinePrefixSymbol(arg_188_1.text_)

				local var_191_11 = 13
				local var_191_12 = utf8.len(var_191_10)
				local var_191_13 = var_191_11 <= 0 and var_191_7 or var_191_7 * (var_191_12 / var_191_11)

				if var_191_13 > 0 and var_191_7 < var_191_13 then
					arg_188_1.talkMaxDuration = var_191_13

					if var_191_13 + var_191_6 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_13 + var_191_6
					end
				end

				arg_188_1.text_.text = var_191_10
				arg_188_1.typewritter.percent = 0

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325041", "325041046", "story_v_out_325041.awb") ~= 0 then
					local var_191_14 = manager.audio:GetVoiceLength("story_v_out_325041", "325041046", "story_v_out_325041.awb") / 1000

					if var_191_14 + var_191_6 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_14 + var_191_6
					end

					if var_191_9.prefab_name ~= "" and arg_188_1.actors_[var_191_9.prefab_name] ~= nil then
						local var_191_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_188_1.actors_[var_191_9.prefab_name].transform, "story_v_out_325041", "325041046", "story_v_out_325041.awb")

						arg_188_1:RecordAudio("325041046", var_191_15)
						arg_188_1:RecordAudio("325041046", var_191_15)
					else
						arg_188_1:AudioAction("play", "voice", "story_v_out_325041", "325041046", "story_v_out_325041.awb")
					end

					arg_188_1:RecordHistoryTalkVoice("story_v_out_325041", "325041046", "story_v_out_325041.awb")
				end

				arg_188_1:RecordContent(arg_188_1.text_.text)
			end

			local var_191_16 = math.max(var_191_7, arg_188_1.talkMaxDuration)

			if var_191_6 <= arg_188_1.time_ and arg_188_1.time_ < var_191_6 + var_191_16 then
				arg_188_1.typewritter.percent = (arg_188_1.time_ - var_191_6) / var_191_16

				arg_188_1.typewritter:SetDirty()
			end

			if arg_188_1.time_ >= var_191_6 + var_191_16 and arg_188_1.time_ < var_191_6 + var_191_16 + arg_191_0 then
				arg_188_1.typewritter.percent = 1

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(true)
			end
		end

		arg_188_1.nodeConfigList_ = {}

		arg_188_1:InitPlayNodeList()
	end,
	Play325041047 = function(arg_192_0, arg_192_1)
		arg_192_1.time_ = 0
		arg_192_1.frameCnt_ = 0
		arg_192_1.state_ = "playing"
		arg_192_1.curTalkId_ = 325041047
		arg_192_1.duration_ = 8.5

		local var_192_0 = {
			zh = 5.766,
			ja = 8.5
		}
		local var_192_1 = manager.audio:GetLocalizationFlag()

		if var_192_0[var_192_1] ~= nil then
			arg_192_1.duration_ = var_192_0[var_192_1]
		end

		SetActive(arg_192_1.tipsGo_, false)

		function arg_192_1.onSingleLineFinish_()
			arg_192_1.onSingleLineUpdate_ = nil
			arg_192_1.onSingleLineFinish_ = nil
			arg_192_1.state_ = "waiting"
		end

		function arg_192_1.playNext_(arg_194_0)
			if arg_194_0 == 1 then
				arg_192_0:Play325041048(arg_192_1)
			end
		end

		function arg_192_1.onSingleLineUpdate_(arg_195_0)
			local var_195_0 = arg_192_1.actors_["1077ui_story"]
			local var_195_1 = 0

			if var_195_1 < arg_192_1.time_ and arg_192_1.time_ <= var_195_1 + arg_195_0 and not isNil(var_195_0) and arg_192_1.var_.characterEffect1077ui_story == nil then
				arg_192_1.var_.characterEffect1077ui_story = var_195_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_195_2 = 0.200000002980232

			if var_195_1 <= arg_192_1.time_ and arg_192_1.time_ < var_195_1 + var_195_2 and not isNil(var_195_0) then
				local var_195_3 = (arg_192_1.time_ - var_195_1) / var_195_2

				if arg_192_1.var_.characterEffect1077ui_story and not isNil(var_195_0) then
					arg_192_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_192_1.time_ >= var_195_1 + var_195_2 and arg_192_1.time_ < var_195_1 + var_195_2 + arg_195_0 and not isNil(var_195_0) and arg_192_1.var_.characterEffect1077ui_story then
				arg_192_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_195_4 = 0
			local var_195_5 = 0.7

			if var_195_4 < arg_192_1.time_ and arg_192_1.time_ <= var_195_4 + arg_195_0 then
				arg_192_1.talkMaxDuration = 0
				arg_192_1.dialogCg_.alpha = 1

				arg_192_1.dialog_:SetActive(true)
				SetActive(arg_192_1.leftNameGo_, true)

				local var_195_6 = arg_192_1:FormatText(StoryNameCfg[1467].name)

				arg_192_1.leftNameTxt_.text = var_195_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_192_1.leftNameTxt_.transform)

				arg_192_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_192_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_192_1:RecordName(arg_192_1.leftNameTxt_.text)
				SetActive(arg_192_1.iconTrs_.gameObject, false)
				arg_192_1.callingController_:SetSelectedState("normal")

				local var_195_7 = arg_192_1:GetWordFromCfg(325041047)
				local var_195_8 = arg_192_1:FormatText(var_195_7.content)

				arg_192_1.text_.text = var_195_8

				LuaForUtil.ClearLinePrefixSymbol(arg_192_1.text_)

				local var_195_9 = 28
				local var_195_10 = utf8.len(var_195_8)
				local var_195_11 = var_195_9 <= 0 and var_195_5 or var_195_5 * (var_195_10 / var_195_9)

				if var_195_11 > 0 and var_195_5 < var_195_11 then
					arg_192_1.talkMaxDuration = var_195_11

					if var_195_11 + var_195_4 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_11 + var_195_4
					end
				end

				arg_192_1.text_.text = var_195_8
				arg_192_1.typewritter.percent = 0

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325041", "325041047", "story_v_out_325041.awb") ~= 0 then
					local var_195_12 = manager.audio:GetVoiceLength("story_v_out_325041", "325041047", "story_v_out_325041.awb") / 1000

					if var_195_12 + var_195_4 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_12 + var_195_4
					end

					if var_195_7.prefab_name ~= "" and arg_192_1.actors_[var_195_7.prefab_name] ~= nil then
						local var_195_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_192_1.actors_[var_195_7.prefab_name].transform, "story_v_out_325041", "325041047", "story_v_out_325041.awb")

						arg_192_1:RecordAudio("325041047", var_195_13)
						arg_192_1:RecordAudio("325041047", var_195_13)
					else
						arg_192_1:AudioAction("play", "voice", "story_v_out_325041", "325041047", "story_v_out_325041.awb")
					end

					arg_192_1:RecordHistoryTalkVoice("story_v_out_325041", "325041047", "story_v_out_325041.awb")
				end

				arg_192_1:RecordContent(arg_192_1.text_.text)
			end

			local var_195_14 = math.max(var_195_5, arg_192_1.talkMaxDuration)

			if var_195_4 <= arg_192_1.time_ and arg_192_1.time_ < var_195_4 + var_195_14 then
				arg_192_1.typewritter.percent = (arg_192_1.time_ - var_195_4) / var_195_14

				arg_192_1.typewritter:SetDirty()
			end

			if arg_192_1.time_ >= var_195_4 + var_195_14 and arg_192_1.time_ < var_195_4 + var_195_14 + arg_195_0 then
				arg_192_1.typewritter.percent = 1

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(true)
			end
		end

		arg_192_1.nodeConfigList_ = {}

		arg_192_1:InitPlayNodeList()
	end,
	Play325041048 = function(arg_196_0, arg_196_1)
		arg_196_1.time_ = 0
		arg_196_1.frameCnt_ = 0
		arg_196_1.state_ = "playing"
		arg_196_1.curTalkId_ = 325041048
		arg_196_1.duration_ = 5.07

		local var_196_0 = {
			zh = 3.666,
			ja = 5.066
		}
		local var_196_1 = manager.audio:GetLocalizationFlag()

		if var_196_0[var_196_1] ~= nil then
			arg_196_1.duration_ = var_196_0[var_196_1]
		end

		SetActive(arg_196_1.tipsGo_, false)

		function arg_196_1.onSingleLineFinish_()
			arg_196_1.onSingleLineUpdate_ = nil
			arg_196_1.onSingleLineFinish_ = nil
			arg_196_1.state_ = "waiting"
		end

		function arg_196_1.playNext_(arg_198_0)
			if arg_198_0 == 1 then
				arg_196_0:Play325041049(arg_196_1)
			end
		end

		function arg_196_1.onSingleLineUpdate_(arg_199_0)
			local var_199_0 = 0

			if var_199_0 < arg_196_1.time_ and arg_196_1.time_ <= var_199_0 + arg_199_0 then
				arg_196_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action2_2")
			end

			local var_199_1 = 0
			local var_199_2 = 0.45

			if var_199_1 < arg_196_1.time_ and arg_196_1.time_ <= var_199_1 + arg_199_0 then
				arg_196_1.talkMaxDuration = 0
				arg_196_1.dialogCg_.alpha = 1

				arg_196_1.dialog_:SetActive(true)
				SetActive(arg_196_1.leftNameGo_, true)

				local var_199_3 = arg_196_1:FormatText(StoryNameCfg[1467].name)

				arg_196_1.leftNameTxt_.text = var_199_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_196_1.leftNameTxt_.transform)

				arg_196_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_196_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_196_1:RecordName(arg_196_1.leftNameTxt_.text)
				SetActive(arg_196_1.iconTrs_.gameObject, false)
				arg_196_1.callingController_:SetSelectedState("normal")

				local var_199_4 = arg_196_1:GetWordFromCfg(325041048)
				local var_199_5 = arg_196_1:FormatText(var_199_4.content)

				arg_196_1.text_.text = var_199_5

				LuaForUtil.ClearLinePrefixSymbol(arg_196_1.text_)

				local var_199_6 = 18
				local var_199_7 = utf8.len(var_199_5)
				local var_199_8 = var_199_6 <= 0 and var_199_2 or var_199_2 * (var_199_7 / var_199_6)

				if var_199_8 > 0 and var_199_2 < var_199_8 then
					arg_196_1.talkMaxDuration = var_199_8

					if var_199_8 + var_199_1 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_8 + var_199_1
					end
				end

				arg_196_1.text_.text = var_199_5
				arg_196_1.typewritter.percent = 0

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325041", "325041048", "story_v_out_325041.awb") ~= 0 then
					local var_199_9 = manager.audio:GetVoiceLength("story_v_out_325041", "325041048", "story_v_out_325041.awb") / 1000

					if var_199_9 + var_199_1 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_9 + var_199_1
					end

					if var_199_4.prefab_name ~= "" and arg_196_1.actors_[var_199_4.prefab_name] ~= nil then
						local var_199_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_196_1.actors_[var_199_4.prefab_name].transform, "story_v_out_325041", "325041048", "story_v_out_325041.awb")

						arg_196_1:RecordAudio("325041048", var_199_10)
						arg_196_1:RecordAudio("325041048", var_199_10)
					else
						arg_196_1:AudioAction("play", "voice", "story_v_out_325041", "325041048", "story_v_out_325041.awb")
					end

					arg_196_1:RecordHistoryTalkVoice("story_v_out_325041", "325041048", "story_v_out_325041.awb")
				end

				arg_196_1:RecordContent(arg_196_1.text_.text)
			end

			local var_199_11 = math.max(var_199_2, arg_196_1.talkMaxDuration)

			if var_199_1 <= arg_196_1.time_ and arg_196_1.time_ < var_199_1 + var_199_11 then
				arg_196_1.typewritter.percent = (arg_196_1.time_ - var_199_1) / var_199_11

				arg_196_1.typewritter:SetDirty()
			end

			if arg_196_1.time_ >= var_199_1 + var_199_11 and arg_196_1.time_ < var_199_1 + var_199_11 + arg_199_0 then
				arg_196_1.typewritter.percent = 1

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(true)
			end
		end

		arg_196_1.nodeConfigList_ = {}

		arg_196_1:InitPlayNodeList()
	end,
	Play325041049 = function(arg_200_0, arg_200_1)
		arg_200_1.time_ = 0
		arg_200_1.frameCnt_ = 0
		arg_200_1.state_ = "playing"
		arg_200_1.curTalkId_ = 325041049
		arg_200_1.duration_ = 5.07

		local var_200_0 = {
			zh = 5.066,
			ja = 4.5
		}
		local var_200_1 = manager.audio:GetLocalizationFlag()

		if var_200_0[var_200_1] ~= nil then
			arg_200_1.duration_ = var_200_0[var_200_1]
		end

		SetActive(arg_200_1.tipsGo_, false)

		function arg_200_1.onSingleLineFinish_()
			arg_200_1.onSingleLineUpdate_ = nil
			arg_200_1.onSingleLineFinish_ = nil
			arg_200_1.state_ = "waiting"
		end

		function arg_200_1.playNext_(arg_202_0)
			if arg_202_0 == 1 then
				arg_200_0:Play325041050(arg_200_1)
			end
		end

		function arg_200_1.onSingleLineUpdate_(arg_203_0)
			local var_203_0 = arg_200_1.actors_["1077ui_story"]
			local var_203_1 = 0

			if var_203_1 < arg_200_1.time_ and arg_200_1.time_ <= var_203_1 + arg_203_0 and not isNil(var_203_0) and arg_200_1.var_.characterEffect1077ui_story == nil then
				arg_200_1.var_.characterEffect1077ui_story = var_203_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_203_2 = 0.200000002980232

			if var_203_1 <= arg_200_1.time_ and arg_200_1.time_ < var_203_1 + var_203_2 and not isNil(var_203_0) then
				local var_203_3 = (arg_200_1.time_ - var_203_1) / var_203_2

				if arg_200_1.var_.characterEffect1077ui_story and not isNil(var_203_0) then
					local var_203_4 = Mathf.Lerp(0, 0.5, var_203_3)

					arg_200_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_200_1.var_.characterEffect1077ui_story.fillRatio = var_203_4
				end
			end

			if arg_200_1.time_ >= var_203_1 + var_203_2 and arg_200_1.time_ < var_203_1 + var_203_2 + arg_203_0 and not isNil(var_203_0) and arg_200_1.var_.characterEffect1077ui_story then
				local var_203_5 = 0.5

				arg_200_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_200_1.var_.characterEffect1077ui_story.fillRatio = var_203_5
			end

			local var_203_6 = 0
			local var_203_7 = 0.4

			if var_203_6 < arg_200_1.time_ and arg_200_1.time_ <= var_203_6 + arg_203_0 then
				arg_200_1.talkMaxDuration = 0
				arg_200_1.dialogCg_.alpha = 1

				arg_200_1.dialog_:SetActive(true)
				SetActive(arg_200_1.leftNameGo_, true)

				local var_203_8 = arg_200_1:FormatText(StoryNameCfg[1454].name)

				arg_200_1.leftNameTxt_.text = var_203_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_200_1.leftNameTxt_.transform)

				arg_200_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_200_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_200_1:RecordName(arg_200_1.leftNameTxt_.text)
				SetActive(arg_200_1.iconTrs_.gameObject, true)
				arg_200_1.iconController_:SetSelectedState("hero")

				arg_200_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10169")

				arg_200_1.callingController_:SetSelectedState("normal")

				arg_200_1.keyicon_.color = Color.New(1, 1, 1)
				arg_200_1.icon_.color = Color.New(1, 1, 1)

				local var_203_9 = arg_200_1:GetWordFromCfg(325041049)
				local var_203_10 = arg_200_1:FormatText(var_203_9.content)

				arg_200_1.text_.text = var_203_10

				LuaForUtil.ClearLinePrefixSymbol(arg_200_1.text_)

				local var_203_11 = 16
				local var_203_12 = utf8.len(var_203_10)
				local var_203_13 = var_203_11 <= 0 and var_203_7 or var_203_7 * (var_203_12 / var_203_11)

				if var_203_13 > 0 and var_203_7 < var_203_13 then
					arg_200_1.talkMaxDuration = var_203_13

					if var_203_13 + var_203_6 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_13 + var_203_6
					end
				end

				arg_200_1.text_.text = var_203_10
				arg_200_1.typewritter.percent = 0

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325041", "325041049", "story_v_out_325041.awb") ~= 0 then
					local var_203_14 = manager.audio:GetVoiceLength("story_v_out_325041", "325041049", "story_v_out_325041.awb") / 1000

					if var_203_14 + var_203_6 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_14 + var_203_6
					end

					if var_203_9.prefab_name ~= "" and arg_200_1.actors_[var_203_9.prefab_name] ~= nil then
						local var_203_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_200_1.actors_[var_203_9.prefab_name].transform, "story_v_out_325041", "325041049", "story_v_out_325041.awb")

						arg_200_1:RecordAudio("325041049", var_203_15)
						arg_200_1:RecordAudio("325041049", var_203_15)
					else
						arg_200_1:AudioAction("play", "voice", "story_v_out_325041", "325041049", "story_v_out_325041.awb")
					end

					arg_200_1:RecordHistoryTalkVoice("story_v_out_325041", "325041049", "story_v_out_325041.awb")
				end

				arg_200_1:RecordContent(arg_200_1.text_.text)
			end

			local var_203_16 = math.max(var_203_7, arg_200_1.talkMaxDuration)

			if var_203_6 <= arg_200_1.time_ and arg_200_1.time_ < var_203_6 + var_203_16 then
				arg_200_1.typewritter.percent = (arg_200_1.time_ - var_203_6) / var_203_16

				arg_200_1.typewritter:SetDirty()
			end

			if arg_200_1.time_ >= var_203_6 + var_203_16 and arg_200_1.time_ < var_203_6 + var_203_16 + arg_203_0 then
				arg_200_1.typewritter.percent = 1

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(true)
			end
		end

		arg_200_1.nodeConfigList_ = {}

		arg_200_1:InitPlayNodeList()
	end,
	Play325041050 = function(arg_204_0, arg_204_1)
		arg_204_1.time_ = 0
		arg_204_1.frameCnt_ = 0
		arg_204_1.state_ = "playing"
		arg_204_1.curTalkId_ = 325041050
		arg_204_1.duration_ = 7.23

		local var_204_0 = {
			zh = 5.633,
			ja = 7.233
		}
		local var_204_1 = manager.audio:GetLocalizationFlag()

		if var_204_0[var_204_1] ~= nil then
			arg_204_1.duration_ = var_204_0[var_204_1]
		end

		SetActive(arg_204_1.tipsGo_, false)

		function arg_204_1.onSingleLineFinish_()
			arg_204_1.onSingleLineUpdate_ = nil
			arg_204_1.onSingleLineFinish_ = nil
			arg_204_1.state_ = "waiting"
		end

		function arg_204_1.playNext_(arg_206_0)
			if arg_206_0 == 1 then
				arg_204_0:Play325041051(arg_204_1)
			end
		end

		function arg_204_1.onSingleLineUpdate_(arg_207_0)
			local var_207_0 = arg_204_1.actors_["1077ui_story"]
			local var_207_1 = 0

			if var_207_1 < arg_204_1.time_ and arg_204_1.time_ <= var_207_1 + arg_207_0 and not isNil(var_207_0) and arg_204_1.var_.characterEffect1077ui_story == nil then
				arg_204_1.var_.characterEffect1077ui_story = var_207_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_207_2 = 0.200000002980232

			if var_207_1 <= arg_204_1.time_ and arg_204_1.time_ < var_207_1 + var_207_2 and not isNil(var_207_0) then
				local var_207_3 = (arg_204_1.time_ - var_207_1) / var_207_2

				if arg_204_1.var_.characterEffect1077ui_story and not isNil(var_207_0) then
					arg_204_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_204_1.time_ >= var_207_1 + var_207_2 and arg_204_1.time_ < var_207_1 + var_207_2 + arg_207_0 and not isNil(var_207_0) and arg_204_1.var_.characterEffect1077ui_story then
				arg_204_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_207_4 = 0
			local var_207_5 = 0.775

			if var_207_4 < arg_204_1.time_ and arg_204_1.time_ <= var_207_4 + arg_207_0 then
				arg_204_1.talkMaxDuration = 0
				arg_204_1.dialogCg_.alpha = 1

				arg_204_1.dialog_:SetActive(true)
				SetActive(arg_204_1.leftNameGo_, true)

				local var_207_6 = arg_204_1:FormatText(StoryNameCfg[1467].name)

				arg_204_1.leftNameTxt_.text = var_207_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_204_1.leftNameTxt_.transform)

				arg_204_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_204_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_204_1:RecordName(arg_204_1.leftNameTxt_.text)
				SetActive(arg_204_1.iconTrs_.gameObject, false)
				arg_204_1.callingController_:SetSelectedState("normal")

				local var_207_7 = arg_204_1:GetWordFromCfg(325041050)
				local var_207_8 = arg_204_1:FormatText(var_207_7.content)

				arg_204_1.text_.text = var_207_8

				LuaForUtil.ClearLinePrefixSymbol(arg_204_1.text_)

				local var_207_9 = 31
				local var_207_10 = utf8.len(var_207_8)
				local var_207_11 = var_207_9 <= 0 and var_207_5 or var_207_5 * (var_207_10 / var_207_9)

				if var_207_11 > 0 and var_207_5 < var_207_11 then
					arg_204_1.talkMaxDuration = var_207_11

					if var_207_11 + var_207_4 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_11 + var_207_4
					end
				end

				arg_204_1.text_.text = var_207_8
				arg_204_1.typewritter.percent = 0

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325041", "325041050", "story_v_out_325041.awb") ~= 0 then
					local var_207_12 = manager.audio:GetVoiceLength("story_v_out_325041", "325041050", "story_v_out_325041.awb") / 1000

					if var_207_12 + var_207_4 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_12 + var_207_4
					end

					if var_207_7.prefab_name ~= "" and arg_204_1.actors_[var_207_7.prefab_name] ~= nil then
						local var_207_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_204_1.actors_[var_207_7.prefab_name].transform, "story_v_out_325041", "325041050", "story_v_out_325041.awb")

						arg_204_1:RecordAudio("325041050", var_207_13)
						arg_204_1:RecordAudio("325041050", var_207_13)
					else
						arg_204_1:AudioAction("play", "voice", "story_v_out_325041", "325041050", "story_v_out_325041.awb")
					end

					arg_204_1:RecordHistoryTalkVoice("story_v_out_325041", "325041050", "story_v_out_325041.awb")
				end

				arg_204_1:RecordContent(arg_204_1.text_.text)
			end

			local var_207_14 = math.max(var_207_5, arg_204_1.talkMaxDuration)

			if var_207_4 <= arg_204_1.time_ and arg_204_1.time_ < var_207_4 + var_207_14 then
				arg_204_1.typewritter.percent = (arg_204_1.time_ - var_207_4) / var_207_14

				arg_204_1.typewritter:SetDirty()
			end

			if arg_204_1.time_ >= var_207_4 + var_207_14 and arg_204_1.time_ < var_207_4 + var_207_14 + arg_207_0 then
				arg_204_1.typewritter.percent = 1

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(true)
			end
		end

		arg_204_1.nodeConfigList_ = {}

		arg_204_1:InitPlayNodeList()
	end,
	Play325041051 = function(arg_208_0, arg_208_1)
		arg_208_1.time_ = 0
		arg_208_1.frameCnt_ = 0
		arg_208_1.state_ = "playing"
		arg_208_1.curTalkId_ = 325041051
		arg_208_1.duration_ = 4.33

		local var_208_0 = {
			zh = 1.633,
			ja = 4.333
		}
		local var_208_1 = manager.audio:GetLocalizationFlag()

		if var_208_0[var_208_1] ~= nil then
			arg_208_1.duration_ = var_208_0[var_208_1]
		end

		SetActive(arg_208_1.tipsGo_, false)

		function arg_208_1.onSingleLineFinish_()
			arg_208_1.onSingleLineUpdate_ = nil
			arg_208_1.onSingleLineFinish_ = nil
			arg_208_1.state_ = "waiting"
		end

		function arg_208_1.playNext_(arg_210_0)
			if arg_210_0 == 1 then
				arg_208_0:Play325041052(arg_208_1)
			end
		end

		function arg_208_1.onSingleLineUpdate_(arg_211_0)
			local var_211_0 = arg_208_1.actors_["1077ui_story"]
			local var_211_1 = 0

			if var_211_1 < arg_208_1.time_ and arg_208_1.time_ <= var_211_1 + arg_211_0 and not isNil(var_211_0) and arg_208_1.var_.characterEffect1077ui_story == nil then
				arg_208_1.var_.characterEffect1077ui_story = var_211_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_211_2 = 0.200000002980232

			if var_211_1 <= arg_208_1.time_ and arg_208_1.time_ < var_211_1 + var_211_2 and not isNil(var_211_0) then
				local var_211_3 = (arg_208_1.time_ - var_211_1) / var_211_2

				if arg_208_1.var_.characterEffect1077ui_story and not isNil(var_211_0) then
					local var_211_4 = Mathf.Lerp(0, 0.5, var_211_3)

					arg_208_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_208_1.var_.characterEffect1077ui_story.fillRatio = var_211_4
				end
			end

			if arg_208_1.time_ >= var_211_1 + var_211_2 and arg_208_1.time_ < var_211_1 + var_211_2 + arg_211_0 and not isNil(var_211_0) and arg_208_1.var_.characterEffect1077ui_story then
				local var_211_5 = 0.5

				arg_208_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_208_1.var_.characterEffect1077ui_story.fillRatio = var_211_5
			end

			local var_211_6 = 0
			local var_211_7 = 0.425

			if var_211_6 < arg_208_1.time_ and arg_208_1.time_ <= var_211_6 + arg_211_0 then
				arg_208_1.talkMaxDuration = 0
				arg_208_1.dialogCg_.alpha = 1

				arg_208_1.dialog_:SetActive(true)
				SetActive(arg_208_1.leftNameGo_, true)

				local var_211_8 = arg_208_1:FormatText(StoryNameCfg[1454].name)

				arg_208_1.leftNameTxt_.text = var_211_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_208_1.leftNameTxt_.transform)

				arg_208_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_208_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_208_1:RecordName(arg_208_1.leftNameTxt_.text)
				SetActive(arg_208_1.iconTrs_.gameObject, true)
				arg_208_1.iconController_:SetSelectedState("hero")

				arg_208_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10169")

				arg_208_1.callingController_:SetSelectedState("normal")

				arg_208_1.keyicon_.color = Color.New(1, 1, 1)
				arg_208_1.icon_.color = Color.New(1, 1, 1)

				local var_211_9 = arg_208_1:GetWordFromCfg(325041051)
				local var_211_10 = arg_208_1:FormatText(var_211_9.content)

				arg_208_1.text_.text = var_211_10

				LuaForUtil.ClearLinePrefixSymbol(arg_208_1.text_)

				local var_211_11 = 17
				local var_211_12 = utf8.len(var_211_10)
				local var_211_13 = var_211_11 <= 0 and var_211_7 or var_211_7 * (var_211_12 / var_211_11)

				if var_211_13 > 0 and var_211_7 < var_211_13 then
					arg_208_1.talkMaxDuration = var_211_13

					if var_211_13 + var_211_6 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_13 + var_211_6
					end
				end

				arg_208_1.text_.text = var_211_10
				arg_208_1.typewritter.percent = 0

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325041", "325041051", "story_v_out_325041.awb") ~= 0 then
					local var_211_14 = manager.audio:GetVoiceLength("story_v_out_325041", "325041051", "story_v_out_325041.awb") / 1000

					if var_211_14 + var_211_6 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_14 + var_211_6
					end

					if var_211_9.prefab_name ~= "" and arg_208_1.actors_[var_211_9.prefab_name] ~= nil then
						local var_211_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_208_1.actors_[var_211_9.prefab_name].transform, "story_v_out_325041", "325041051", "story_v_out_325041.awb")

						arg_208_1:RecordAudio("325041051", var_211_15)
						arg_208_1:RecordAudio("325041051", var_211_15)
					else
						arg_208_1:AudioAction("play", "voice", "story_v_out_325041", "325041051", "story_v_out_325041.awb")
					end

					arg_208_1:RecordHistoryTalkVoice("story_v_out_325041", "325041051", "story_v_out_325041.awb")
				end

				arg_208_1:RecordContent(arg_208_1.text_.text)
			end

			local var_211_16 = math.max(var_211_7, arg_208_1.talkMaxDuration)

			if var_211_6 <= arg_208_1.time_ and arg_208_1.time_ < var_211_6 + var_211_16 then
				arg_208_1.typewritter.percent = (arg_208_1.time_ - var_211_6) / var_211_16

				arg_208_1.typewritter:SetDirty()
			end

			if arg_208_1.time_ >= var_211_6 + var_211_16 and arg_208_1.time_ < var_211_6 + var_211_16 + arg_211_0 then
				arg_208_1.typewritter.percent = 1

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(true)
			end
		end

		arg_208_1.nodeConfigList_ = {}

		arg_208_1:InitPlayNodeList()
	end,
	Play325041052 = function(arg_212_0, arg_212_1)
		arg_212_1.time_ = 0
		arg_212_1.frameCnt_ = 0
		arg_212_1.state_ = "playing"
		arg_212_1.curTalkId_ = 325041052
		arg_212_1.duration_ = 11.4

		local var_212_0 = {
			zh = 8.366,
			ja = 11.4
		}
		local var_212_1 = manager.audio:GetLocalizationFlag()

		if var_212_0[var_212_1] ~= nil then
			arg_212_1.duration_ = var_212_0[var_212_1]
		end

		SetActive(arg_212_1.tipsGo_, false)

		function arg_212_1.onSingleLineFinish_()
			arg_212_1.onSingleLineUpdate_ = nil
			arg_212_1.onSingleLineFinish_ = nil
			arg_212_1.state_ = "waiting"
		end

		function arg_212_1.playNext_(arg_214_0)
			if arg_214_0 == 1 then
				arg_212_0:Play325041053(arg_212_1)
			end
		end

		function arg_212_1.onSingleLineUpdate_(arg_215_0)
			local var_215_0 = arg_212_1.actors_["1077ui_story"]
			local var_215_1 = 0

			if var_215_1 < arg_212_1.time_ and arg_212_1.time_ <= var_215_1 + arg_215_0 and not isNil(var_215_0) and arg_212_1.var_.characterEffect1077ui_story == nil then
				arg_212_1.var_.characterEffect1077ui_story = var_215_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_215_2 = 0.200000002980232

			if var_215_1 <= arg_212_1.time_ and arg_212_1.time_ < var_215_1 + var_215_2 and not isNil(var_215_0) then
				local var_215_3 = (arg_212_1.time_ - var_215_1) / var_215_2

				if arg_212_1.var_.characterEffect1077ui_story and not isNil(var_215_0) then
					arg_212_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_212_1.time_ >= var_215_1 + var_215_2 and arg_212_1.time_ < var_215_1 + var_215_2 + arg_215_0 and not isNil(var_215_0) and arg_212_1.var_.characterEffect1077ui_story then
				arg_212_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_215_4 = 0

			if var_215_4 < arg_212_1.time_ and arg_212_1.time_ <= var_215_4 + arg_215_0 then
				arg_212_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action1_1")
			end

			local var_215_5 = 0

			if var_215_5 < arg_212_1.time_ and arg_212_1.time_ <= var_215_5 + arg_215_0 then
				arg_212_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_215_6 = 0
			local var_215_7 = 0.725

			if var_215_6 < arg_212_1.time_ and arg_212_1.time_ <= var_215_6 + arg_215_0 then
				arg_212_1.talkMaxDuration = 0
				arg_212_1.dialogCg_.alpha = 1

				arg_212_1.dialog_:SetActive(true)
				SetActive(arg_212_1.leftNameGo_, true)

				local var_215_8 = arg_212_1:FormatText(StoryNameCfg[1467].name)

				arg_212_1.leftNameTxt_.text = var_215_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_212_1.leftNameTxt_.transform)

				arg_212_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_212_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_212_1:RecordName(arg_212_1.leftNameTxt_.text)
				SetActive(arg_212_1.iconTrs_.gameObject, false)
				arg_212_1.callingController_:SetSelectedState("normal")

				local var_215_9 = arg_212_1:GetWordFromCfg(325041052)
				local var_215_10 = arg_212_1:FormatText(var_215_9.content)

				arg_212_1.text_.text = var_215_10

				LuaForUtil.ClearLinePrefixSymbol(arg_212_1.text_)

				local var_215_11 = 29
				local var_215_12 = utf8.len(var_215_10)
				local var_215_13 = var_215_11 <= 0 and var_215_7 or var_215_7 * (var_215_12 / var_215_11)

				if var_215_13 > 0 and var_215_7 < var_215_13 then
					arg_212_1.talkMaxDuration = var_215_13

					if var_215_13 + var_215_6 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_13 + var_215_6
					end
				end

				arg_212_1.text_.text = var_215_10
				arg_212_1.typewritter.percent = 0

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325041", "325041052", "story_v_out_325041.awb") ~= 0 then
					local var_215_14 = manager.audio:GetVoiceLength("story_v_out_325041", "325041052", "story_v_out_325041.awb") / 1000

					if var_215_14 + var_215_6 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_14 + var_215_6
					end

					if var_215_9.prefab_name ~= "" and arg_212_1.actors_[var_215_9.prefab_name] ~= nil then
						local var_215_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_212_1.actors_[var_215_9.prefab_name].transform, "story_v_out_325041", "325041052", "story_v_out_325041.awb")

						arg_212_1:RecordAudio("325041052", var_215_15)
						arg_212_1:RecordAudio("325041052", var_215_15)
					else
						arg_212_1:AudioAction("play", "voice", "story_v_out_325041", "325041052", "story_v_out_325041.awb")
					end

					arg_212_1:RecordHistoryTalkVoice("story_v_out_325041", "325041052", "story_v_out_325041.awb")
				end

				arg_212_1:RecordContent(arg_212_1.text_.text)
			end

			local var_215_16 = math.max(var_215_7, arg_212_1.talkMaxDuration)

			if var_215_6 <= arg_212_1.time_ and arg_212_1.time_ < var_215_6 + var_215_16 then
				arg_212_1.typewritter.percent = (arg_212_1.time_ - var_215_6) / var_215_16

				arg_212_1.typewritter:SetDirty()
			end

			if arg_212_1.time_ >= var_215_6 + var_215_16 and arg_212_1.time_ < var_215_6 + var_215_16 + arg_215_0 then
				arg_212_1.typewritter.percent = 1

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(true)
			end
		end

		arg_212_1.nodeConfigList_ = {}

		arg_212_1:InitPlayNodeList()
	end,
	Play325041053 = function(arg_216_0, arg_216_1)
		arg_216_1.time_ = 0
		arg_216_1.frameCnt_ = 0
		arg_216_1.state_ = "playing"
		arg_216_1.curTalkId_ = 325041053
		arg_216_1.duration_ = 6.87

		local var_216_0 = {
			zh = 3.3,
			ja = 6.866
		}
		local var_216_1 = manager.audio:GetLocalizationFlag()

		if var_216_0[var_216_1] ~= nil then
			arg_216_1.duration_ = var_216_0[var_216_1]
		end

		SetActive(arg_216_1.tipsGo_, false)

		function arg_216_1.onSingleLineFinish_()
			arg_216_1.onSingleLineUpdate_ = nil
			arg_216_1.onSingleLineFinish_ = nil
			arg_216_1.state_ = "waiting"
		end

		function arg_216_1.playNext_(arg_218_0)
			if arg_218_0 == 1 then
				arg_216_0:Play325041054(arg_216_1)
			end
		end

		function arg_216_1.onSingleLineUpdate_(arg_219_0)
			local var_219_0 = arg_216_1.actors_["1077ui_story"]
			local var_219_1 = 0

			if var_219_1 < arg_216_1.time_ and arg_216_1.time_ <= var_219_1 + arg_219_0 and not isNil(var_219_0) and arg_216_1.var_.characterEffect1077ui_story == nil then
				arg_216_1.var_.characterEffect1077ui_story = var_219_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_219_2 = 0.200000002980232

			if var_219_1 <= arg_216_1.time_ and arg_216_1.time_ < var_219_1 + var_219_2 and not isNil(var_219_0) then
				local var_219_3 = (arg_216_1.time_ - var_219_1) / var_219_2

				if arg_216_1.var_.characterEffect1077ui_story and not isNil(var_219_0) then
					local var_219_4 = Mathf.Lerp(0, 0.5, var_219_3)

					arg_216_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_216_1.var_.characterEffect1077ui_story.fillRatio = var_219_4
				end
			end

			if arg_216_1.time_ >= var_219_1 + var_219_2 and arg_216_1.time_ < var_219_1 + var_219_2 + arg_219_0 and not isNil(var_219_0) and arg_216_1.var_.characterEffect1077ui_story then
				local var_219_5 = 0.5

				arg_216_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_216_1.var_.characterEffect1077ui_story.fillRatio = var_219_5
			end

			local var_219_6 = 0
			local var_219_7 = 0.25

			if var_219_6 < arg_216_1.time_ and arg_216_1.time_ <= var_219_6 + arg_219_0 then
				arg_216_1.talkMaxDuration = 0
				arg_216_1.dialogCg_.alpha = 1

				arg_216_1.dialog_:SetActive(true)
				SetActive(arg_216_1.leftNameGo_, true)

				local var_219_8 = arg_216_1:FormatText(StoryNameCfg[1454].name)

				arg_216_1.leftNameTxt_.text = var_219_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_216_1.leftNameTxt_.transform)

				arg_216_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_216_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_216_1:RecordName(arg_216_1.leftNameTxt_.text)
				SetActive(arg_216_1.iconTrs_.gameObject, true)
				arg_216_1.iconController_:SetSelectedState("hero")

				arg_216_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10169")

				arg_216_1.callingController_:SetSelectedState("normal")

				arg_216_1.keyicon_.color = Color.New(1, 1, 1)
				arg_216_1.icon_.color = Color.New(1, 1, 1)

				local var_219_9 = arg_216_1:GetWordFromCfg(325041053)
				local var_219_10 = arg_216_1:FormatText(var_219_9.content)

				arg_216_1.text_.text = var_219_10

				LuaForUtil.ClearLinePrefixSymbol(arg_216_1.text_)

				local var_219_11 = 10
				local var_219_12 = utf8.len(var_219_10)
				local var_219_13 = var_219_11 <= 0 and var_219_7 or var_219_7 * (var_219_12 / var_219_11)

				if var_219_13 > 0 and var_219_7 < var_219_13 then
					arg_216_1.talkMaxDuration = var_219_13

					if var_219_13 + var_219_6 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_13 + var_219_6
					end
				end

				arg_216_1.text_.text = var_219_10
				arg_216_1.typewritter.percent = 0

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325041", "325041053", "story_v_out_325041.awb") ~= 0 then
					local var_219_14 = manager.audio:GetVoiceLength("story_v_out_325041", "325041053", "story_v_out_325041.awb") / 1000

					if var_219_14 + var_219_6 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_14 + var_219_6
					end

					if var_219_9.prefab_name ~= "" and arg_216_1.actors_[var_219_9.prefab_name] ~= nil then
						local var_219_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_216_1.actors_[var_219_9.prefab_name].transform, "story_v_out_325041", "325041053", "story_v_out_325041.awb")

						arg_216_1:RecordAudio("325041053", var_219_15)
						arg_216_1:RecordAudio("325041053", var_219_15)
					else
						arg_216_1:AudioAction("play", "voice", "story_v_out_325041", "325041053", "story_v_out_325041.awb")
					end

					arg_216_1:RecordHistoryTalkVoice("story_v_out_325041", "325041053", "story_v_out_325041.awb")
				end

				arg_216_1:RecordContent(arg_216_1.text_.text)
			end

			local var_219_16 = math.max(var_219_7, arg_216_1.talkMaxDuration)

			if var_219_6 <= arg_216_1.time_ and arg_216_1.time_ < var_219_6 + var_219_16 then
				arg_216_1.typewritter.percent = (arg_216_1.time_ - var_219_6) / var_219_16

				arg_216_1.typewritter:SetDirty()
			end

			if arg_216_1.time_ >= var_219_6 + var_219_16 and arg_216_1.time_ < var_219_6 + var_219_16 + arg_219_0 then
				arg_216_1.typewritter.percent = 1

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(true)
			end
		end

		arg_216_1.nodeConfigList_ = {}

		arg_216_1:InitPlayNodeList()
	end,
	Play325041054 = function(arg_220_0, arg_220_1)
		arg_220_1.time_ = 0
		arg_220_1.frameCnt_ = 0
		arg_220_1.state_ = "playing"
		arg_220_1.curTalkId_ = 325041054
		arg_220_1.duration_ = 5.6

		local var_220_0 = {
			zh = 4.6,
			ja = 5.6
		}
		local var_220_1 = manager.audio:GetLocalizationFlag()

		if var_220_0[var_220_1] ~= nil then
			arg_220_1.duration_ = var_220_0[var_220_1]
		end

		SetActive(arg_220_1.tipsGo_, false)

		function arg_220_1.onSingleLineFinish_()
			arg_220_1.onSingleLineUpdate_ = nil
			arg_220_1.onSingleLineFinish_ = nil
			arg_220_1.state_ = "waiting"
		end

		function arg_220_1.playNext_(arg_222_0)
			if arg_222_0 == 1 then
				arg_220_0:Play325041055(arg_220_1)
			end
		end

		function arg_220_1.onSingleLineUpdate_(arg_223_0)
			local var_223_0 = arg_220_1.actors_["1077ui_story"]
			local var_223_1 = 0

			if var_223_1 < arg_220_1.time_ and arg_220_1.time_ <= var_223_1 + arg_223_0 and not isNil(var_223_0) and arg_220_1.var_.characterEffect1077ui_story == nil then
				arg_220_1.var_.characterEffect1077ui_story = var_223_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_223_2 = 0.200000002980232

			if var_223_1 <= arg_220_1.time_ and arg_220_1.time_ < var_223_1 + var_223_2 and not isNil(var_223_0) then
				local var_223_3 = (arg_220_1.time_ - var_223_1) / var_223_2

				if arg_220_1.var_.characterEffect1077ui_story and not isNil(var_223_0) then
					arg_220_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_220_1.time_ >= var_223_1 + var_223_2 and arg_220_1.time_ < var_223_1 + var_223_2 + arg_223_0 and not isNil(var_223_0) and arg_220_1.var_.characterEffect1077ui_story then
				arg_220_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_223_4 = 0

			if var_223_4 < arg_220_1.time_ and arg_220_1.time_ <= var_223_4 + arg_223_0 then
				arg_220_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action7_1")
			end

			local var_223_5 = 0

			if var_223_5 < arg_220_1.time_ and arg_220_1.time_ <= var_223_5 + arg_223_0 then
				arg_220_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_223_6 = 0
			local var_223_7 = 0.4

			if var_223_6 < arg_220_1.time_ and arg_220_1.time_ <= var_223_6 + arg_223_0 then
				arg_220_1.talkMaxDuration = 0
				arg_220_1.dialogCg_.alpha = 1

				arg_220_1.dialog_:SetActive(true)
				SetActive(arg_220_1.leftNameGo_, true)

				local var_223_8 = arg_220_1:FormatText(StoryNameCfg[1467].name)

				arg_220_1.leftNameTxt_.text = var_223_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_220_1.leftNameTxt_.transform)

				arg_220_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_220_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_220_1:RecordName(arg_220_1.leftNameTxt_.text)
				SetActive(arg_220_1.iconTrs_.gameObject, false)
				arg_220_1.callingController_:SetSelectedState("normal")

				local var_223_9 = arg_220_1:GetWordFromCfg(325041054)
				local var_223_10 = arg_220_1:FormatText(var_223_9.content)

				arg_220_1.text_.text = var_223_10

				LuaForUtil.ClearLinePrefixSymbol(arg_220_1.text_)

				local var_223_11 = 16
				local var_223_12 = utf8.len(var_223_10)
				local var_223_13 = var_223_11 <= 0 and var_223_7 or var_223_7 * (var_223_12 / var_223_11)

				if var_223_13 > 0 and var_223_7 < var_223_13 then
					arg_220_1.talkMaxDuration = var_223_13

					if var_223_13 + var_223_6 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_13 + var_223_6
					end
				end

				arg_220_1.text_.text = var_223_10
				arg_220_1.typewritter.percent = 0

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325041", "325041054", "story_v_out_325041.awb") ~= 0 then
					local var_223_14 = manager.audio:GetVoiceLength("story_v_out_325041", "325041054", "story_v_out_325041.awb") / 1000

					if var_223_14 + var_223_6 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_14 + var_223_6
					end

					if var_223_9.prefab_name ~= "" and arg_220_1.actors_[var_223_9.prefab_name] ~= nil then
						local var_223_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_220_1.actors_[var_223_9.prefab_name].transform, "story_v_out_325041", "325041054", "story_v_out_325041.awb")

						arg_220_1:RecordAudio("325041054", var_223_15)
						arg_220_1:RecordAudio("325041054", var_223_15)
					else
						arg_220_1:AudioAction("play", "voice", "story_v_out_325041", "325041054", "story_v_out_325041.awb")
					end

					arg_220_1:RecordHistoryTalkVoice("story_v_out_325041", "325041054", "story_v_out_325041.awb")
				end

				arg_220_1:RecordContent(arg_220_1.text_.text)
			end

			local var_223_16 = math.max(var_223_7, arg_220_1.talkMaxDuration)

			if var_223_6 <= arg_220_1.time_ and arg_220_1.time_ < var_223_6 + var_223_16 then
				arg_220_1.typewritter.percent = (arg_220_1.time_ - var_223_6) / var_223_16

				arg_220_1.typewritter:SetDirty()
			end

			if arg_220_1.time_ >= var_223_6 + var_223_16 and arg_220_1.time_ < var_223_6 + var_223_16 + arg_223_0 then
				arg_220_1.typewritter.percent = 1

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(true)
			end
		end

		arg_220_1.nodeConfigList_ = {}

		arg_220_1:InitPlayNodeList()
	end,
	Play325041055 = function(arg_224_0, arg_224_1)
		arg_224_1.time_ = 0
		arg_224_1.frameCnt_ = 0
		arg_224_1.state_ = "playing"
		arg_224_1.curTalkId_ = 325041055
		arg_224_1.duration_ = 16.03

		local var_224_0 = {
			zh = 11.1,
			ja = 16.033
		}
		local var_224_1 = manager.audio:GetLocalizationFlag()

		if var_224_0[var_224_1] ~= nil then
			arg_224_1.duration_ = var_224_0[var_224_1]
		end

		SetActive(arg_224_1.tipsGo_, false)

		function arg_224_1.onSingleLineFinish_()
			arg_224_1.onSingleLineUpdate_ = nil
			arg_224_1.onSingleLineFinish_ = nil
			arg_224_1.state_ = "waiting"
		end

		function arg_224_1.playNext_(arg_226_0)
			if arg_226_0 == 1 then
				arg_224_0:Play325041056(arg_224_1)
			end
		end

		function arg_224_1.onSingleLineUpdate_(arg_227_0)
			local var_227_0 = arg_224_1.actors_["1077ui_story"]
			local var_227_1 = 0

			if var_227_1 < arg_224_1.time_ and arg_224_1.time_ <= var_227_1 + arg_227_0 and not isNil(var_227_0) and arg_224_1.var_.characterEffect1077ui_story == nil then
				arg_224_1.var_.characterEffect1077ui_story = var_227_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_227_2 = 0.200000002980232

			if var_227_1 <= arg_224_1.time_ and arg_224_1.time_ < var_227_1 + var_227_2 and not isNil(var_227_0) then
				local var_227_3 = (arg_224_1.time_ - var_227_1) / var_227_2

				if arg_224_1.var_.characterEffect1077ui_story and not isNil(var_227_0) then
					local var_227_4 = Mathf.Lerp(0, 0.5, var_227_3)

					arg_224_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_224_1.var_.characterEffect1077ui_story.fillRatio = var_227_4
				end
			end

			if arg_224_1.time_ >= var_227_1 + var_227_2 and arg_224_1.time_ < var_227_1 + var_227_2 + arg_227_0 and not isNil(var_227_0) and arg_224_1.var_.characterEffect1077ui_story then
				local var_227_5 = 0.5

				arg_224_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_224_1.var_.characterEffect1077ui_story.fillRatio = var_227_5
			end

			local var_227_6 = 0
			local var_227_7 = 1.1

			if var_227_6 < arg_224_1.time_ and arg_224_1.time_ <= var_227_6 + arg_227_0 then
				arg_224_1.talkMaxDuration = 0
				arg_224_1.dialogCg_.alpha = 1

				arg_224_1.dialog_:SetActive(true)
				SetActive(arg_224_1.leftNameGo_, true)

				local var_227_8 = arg_224_1:FormatText(StoryNameCfg[1454].name)

				arg_224_1.leftNameTxt_.text = var_227_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_224_1.leftNameTxt_.transform)

				arg_224_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_224_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_224_1:RecordName(arg_224_1.leftNameTxt_.text)
				SetActive(arg_224_1.iconTrs_.gameObject, true)
				arg_224_1.iconController_:SetSelectedState("hero")

				arg_224_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10169")

				arg_224_1.callingController_:SetSelectedState("normal")

				arg_224_1.keyicon_.color = Color.New(1, 1, 1)
				arg_224_1.icon_.color = Color.New(1, 1, 1)

				local var_227_9 = arg_224_1:GetWordFromCfg(325041055)
				local var_227_10 = arg_224_1:FormatText(var_227_9.content)

				arg_224_1.text_.text = var_227_10

				LuaForUtil.ClearLinePrefixSymbol(arg_224_1.text_)

				local var_227_11 = 44
				local var_227_12 = utf8.len(var_227_10)
				local var_227_13 = var_227_11 <= 0 and var_227_7 or var_227_7 * (var_227_12 / var_227_11)

				if var_227_13 > 0 and var_227_7 < var_227_13 then
					arg_224_1.talkMaxDuration = var_227_13

					if var_227_13 + var_227_6 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_13 + var_227_6
					end
				end

				arg_224_1.text_.text = var_227_10
				arg_224_1.typewritter.percent = 0

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325041", "325041055", "story_v_out_325041.awb") ~= 0 then
					local var_227_14 = manager.audio:GetVoiceLength("story_v_out_325041", "325041055", "story_v_out_325041.awb") / 1000

					if var_227_14 + var_227_6 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_14 + var_227_6
					end

					if var_227_9.prefab_name ~= "" and arg_224_1.actors_[var_227_9.prefab_name] ~= nil then
						local var_227_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_224_1.actors_[var_227_9.prefab_name].transform, "story_v_out_325041", "325041055", "story_v_out_325041.awb")

						arg_224_1:RecordAudio("325041055", var_227_15)
						arg_224_1:RecordAudio("325041055", var_227_15)
					else
						arg_224_1:AudioAction("play", "voice", "story_v_out_325041", "325041055", "story_v_out_325041.awb")
					end

					arg_224_1:RecordHistoryTalkVoice("story_v_out_325041", "325041055", "story_v_out_325041.awb")
				end

				arg_224_1:RecordContent(arg_224_1.text_.text)
			end

			local var_227_16 = math.max(var_227_7, arg_224_1.talkMaxDuration)

			if var_227_6 <= arg_224_1.time_ and arg_224_1.time_ < var_227_6 + var_227_16 then
				arg_224_1.typewritter.percent = (arg_224_1.time_ - var_227_6) / var_227_16

				arg_224_1.typewritter:SetDirty()
			end

			if arg_224_1.time_ >= var_227_6 + var_227_16 and arg_224_1.time_ < var_227_6 + var_227_16 + arg_227_0 then
				arg_224_1.typewritter.percent = 1

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(true)
			end
		end

		arg_224_1.nodeConfigList_ = {}

		arg_224_1:InitPlayNodeList()
	end,
	Play325041056 = function(arg_228_0, arg_228_1)
		arg_228_1.time_ = 0
		arg_228_1.frameCnt_ = 0
		arg_228_1.state_ = "playing"
		arg_228_1.curTalkId_ = 325041056
		arg_228_1.duration_ = 19.83

		local var_228_0 = {
			zh = 11.5,
			ja = 19.833
		}
		local var_228_1 = manager.audio:GetLocalizationFlag()

		if var_228_0[var_228_1] ~= nil then
			arg_228_1.duration_ = var_228_0[var_228_1]
		end

		SetActive(arg_228_1.tipsGo_, false)

		function arg_228_1.onSingleLineFinish_()
			arg_228_1.onSingleLineUpdate_ = nil
			arg_228_1.onSingleLineFinish_ = nil
			arg_228_1.state_ = "waiting"
		end

		function arg_228_1.playNext_(arg_230_0)
			if arg_230_0 == 1 then
				arg_228_0:Play325041057(arg_228_1)
			end
		end

		function arg_228_1.onSingleLineUpdate_(arg_231_0)
			local var_231_0 = 0
			local var_231_1 = 1.15

			if var_231_0 < arg_228_1.time_ and arg_228_1.time_ <= var_231_0 + arg_231_0 then
				arg_228_1.talkMaxDuration = 0
				arg_228_1.dialogCg_.alpha = 1

				arg_228_1.dialog_:SetActive(true)
				SetActive(arg_228_1.leftNameGo_, true)

				local var_231_2 = arg_228_1:FormatText(StoryNameCfg[1454].name)

				arg_228_1.leftNameTxt_.text = var_231_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_228_1.leftNameTxt_.transform)

				arg_228_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_228_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_228_1:RecordName(arg_228_1.leftNameTxt_.text)
				SetActive(arg_228_1.iconTrs_.gameObject, true)
				arg_228_1.iconController_:SetSelectedState("hero")

				arg_228_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10169")

				arg_228_1.callingController_:SetSelectedState("normal")

				arg_228_1.keyicon_.color = Color.New(1, 1, 1)
				arg_228_1.icon_.color = Color.New(1, 1, 1)

				local var_231_3 = arg_228_1:GetWordFromCfg(325041056)
				local var_231_4 = arg_228_1:FormatText(var_231_3.content)

				arg_228_1.text_.text = var_231_4

				LuaForUtil.ClearLinePrefixSymbol(arg_228_1.text_)

				local var_231_5 = 46
				local var_231_6 = utf8.len(var_231_4)
				local var_231_7 = var_231_5 <= 0 and var_231_1 or var_231_1 * (var_231_6 / var_231_5)

				if var_231_7 > 0 and var_231_1 < var_231_7 then
					arg_228_1.talkMaxDuration = var_231_7

					if var_231_7 + var_231_0 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_7 + var_231_0
					end
				end

				arg_228_1.text_.text = var_231_4
				arg_228_1.typewritter.percent = 0

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325041", "325041056", "story_v_out_325041.awb") ~= 0 then
					local var_231_8 = manager.audio:GetVoiceLength("story_v_out_325041", "325041056", "story_v_out_325041.awb") / 1000

					if var_231_8 + var_231_0 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_8 + var_231_0
					end

					if var_231_3.prefab_name ~= "" and arg_228_1.actors_[var_231_3.prefab_name] ~= nil then
						local var_231_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_228_1.actors_[var_231_3.prefab_name].transform, "story_v_out_325041", "325041056", "story_v_out_325041.awb")

						arg_228_1:RecordAudio("325041056", var_231_9)
						arg_228_1:RecordAudio("325041056", var_231_9)
					else
						arg_228_1:AudioAction("play", "voice", "story_v_out_325041", "325041056", "story_v_out_325041.awb")
					end

					arg_228_1:RecordHistoryTalkVoice("story_v_out_325041", "325041056", "story_v_out_325041.awb")
				end

				arg_228_1:RecordContent(arg_228_1.text_.text)
			end

			local var_231_10 = math.max(var_231_1, arg_228_1.talkMaxDuration)

			if var_231_0 <= arg_228_1.time_ and arg_228_1.time_ < var_231_0 + var_231_10 then
				arg_228_1.typewritter.percent = (arg_228_1.time_ - var_231_0) / var_231_10

				arg_228_1.typewritter:SetDirty()
			end

			if arg_228_1.time_ >= var_231_0 + var_231_10 and arg_228_1.time_ < var_231_0 + var_231_10 + arg_231_0 then
				arg_228_1.typewritter.percent = 1

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(true)
			end
		end

		arg_228_1.nodeConfigList_ = {}

		arg_228_1:InitPlayNodeList()
	end,
	Play325041057 = function(arg_232_0, arg_232_1)
		arg_232_1.time_ = 0
		arg_232_1.frameCnt_ = 0
		arg_232_1.state_ = "playing"
		arg_232_1.curTalkId_ = 325041057
		arg_232_1.duration_ = 9.1

		local var_232_0 = {
			zh = 8.1,
			ja = 9.1
		}
		local var_232_1 = manager.audio:GetLocalizationFlag()

		if var_232_0[var_232_1] ~= nil then
			arg_232_1.duration_ = var_232_0[var_232_1]
		end

		SetActive(arg_232_1.tipsGo_, false)

		function arg_232_1.onSingleLineFinish_()
			arg_232_1.onSingleLineUpdate_ = nil
			arg_232_1.onSingleLineFinish_ = nil
			arg_232_1.state_ = "waiting"
		end

		function arg_232_1.playNext_(arg_234_0)
			if arg_234_0 == 1 then
				arg_232_0:Play325041058(arg_232_1)
			end
		end

		function arg_232_1.onSingleLineUpdate_(arg_235_0)
			local var_235_0 = arg_232_1.actors_["1077ui_story"]
			local var_235_1 = 0

			if var_235_1 < arg_232_1.time_ and arg_232_1.time_ <= var_235_1 + arg_235_0 and not isNil(var_235_0) and arg_232_1.var_.characterEffect1077ui_story == nil then
				arg_232_1.var_.characterEffect1077ui_story = var_235_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_235_2 = 0.200000002980232

			if var_235_1 <= arg_232_1.time_ and arg_232_1.time_ < var_235_1 + var_235_2 and not isNil(var_235_0) then
				local var_235_3 = (arg_232_1.time_ - var_235_1) / var_235_2

				if arg_232_1.var_.characterEffect1077ui_story and not isNil(var_235_0) then
					arg_232_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_232_1.time_ >= var_235_1 + var_235_2 and arg_232_1.time_ < var_235_1 + var_235_2 + arg_235_0 and not isNil(var_235_0) and arg_232_1.var_.characterEffect1077ui_story then
				arg_232_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_235_4 = 0

			if var_235_4 < arg_232_1.time_ and arg_232_1.time_ <= var_235_4 + arg_235_0 then
				arg_232_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action7_2")
			end

			local var_235_5 = 0
			local var_235_6 = 0.8

			if var_235_5 < arg_232_1.time_ and arg_232_1.time_ <= var_235_5 + arg_235_0 then
				arg_232_1.talkMaxDuration = 0
				arg_232_1.dialogCg_.alpha = 1

				arg_232_1.dialog_:SetActive(true)
				SetActive(arg_232_1.leftNameGo_, true)

				local var_235_7 = arg_232_1:FormatText(StoryNameCfg[1467].name)

				arg_232_1.leftNameTxt_.text = var_235_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_232_1.leftNameTxt_.transform)

				arg_232_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_232_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_232_1:RecordName(arg_232_1.leftNameTxt_.text)
				SetActive(arg_232_1.iconTrs_.gameObject, false)
				arg_232_1.callingController_:SetSelectedState("normal")

				local var_235_8 = arg_232_1:GetWordFromCfg(325041057)
				local var_235_9 = arg_232_1:FormatText(var_235_8.content)

				arg_232_1.text_.text = var_235_9

				LuaForUtil.ClearLinePrefixSymbol(arg_232_1.text_)

				local var_235_10 = 32
				local var_235_11 = utf8.len(var_235_9)
				local var_235_12 = var_235_10 <= 0 and var_235_6 or var_235_6 * (var_235_11 / var_235_10)

				if var_235_12 > 0 and var_235_6 < var_235_12 then
					arg_232_1.talkMaxDuration = var_235_12

					if var_235_12 + var_235_5 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_12 + var_235_5
					end
				end

				arg_232_1.text_.text = var_235_9
				arg_232_1.typewritter.percent = 0

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325041", "325041057", "story_v_out_325041.awb") ~= 0 then
					local var_235_13 = manager.audio:GetVoiceLength("story_v_out_325041", "325041057", "story_v_out_325041.awb") / 1000

					if var_235_13 + var_235_5 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_13 + var_235_5
					end

					if var_235_8.prefab_name ~= "" and arg_232_1.actors_[var_235_8.prefab_name] ~= nil then
						local var_235_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_232_1.actors_[var_235_8.prefab_name].transform, "story_v_out_325041", "325041057", "story_v_out_325041.awb")

						arg_232_1:RecordAudio("325041057", var_235_14)
						arg_232_1:RecordAudio("325041057", var_235_14)
					else
						arg_232_1:AudioAction("play", "voice", "story_v_out_325041", "325041057", "story_v_out_325041.awb")
					end

					arg_232_1:RecordHistoryTalkVoice("story_v_out_325041", "325041057", "story_v_out_325041.awb")
				end

				arg_232_1:RecordContent(arg_232_1.text_.text)
			end

			local var_235_15 = math.max(var_235_6, arg_232_1.talkMaxDuration)

			if var_235_5 <= arg_232_1.time_ and arg_232_1.time_ < var_235_5 + var_235_15 then
				arg_232_1.typewritter.percent = (arg_232_1.time_ - var_235_5) / var_235_15

				arg_232_1.typewritter:SetDirty()
			end

			if arg_232_1.time_ >= var_235_5 + var_235_15 and arg_232_1.time_ < var_235_5 + var_235_15 + arg_235_0 then
				arg_232_1.typewritter.percent = 1

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(true)
			end
		end

		arg_232_1.nodeConfigList_ = {}

		arg_232_1:InitPlayNodeList()
	end,
	Play325041058 = function(arg_236_0, arg_236_1)
		arg_236_1.time_ = 0
		arg_236_1.frameCnt_ = 0
		arg_236_1.state_ = "playing"
		arg_236_1.curTalkId_ = 325041058
		arg_236_1.duration_ = 6.37

		local var_236_0 = {
			zh = 2.4,
			ja = 6.366
		}
		local var_236_1 = manager.audio:GetLocalizationFlag()

		if var_236_0[var_236_1] ~= nil then
			arg_236_1.duration_ = var_236_0[var_236_1]
		end

		SetActive(arg_236_1.tipsGo_, false)

		function arg_236_1.onSingleLineFinish_()
			arg_236_1.onSingleLineUpdate_ = nil
			arg_236_1.onSingleLineFinish_ = nil
			arg_236_1.state_ = "waiting"
		end

		function arg_236_1.playNext_(arg_238_0)
			if arg_238_0 == 1 then
				arg_236_0:Play325041059(arg_236_1)
			end
		end

		function arg_236_1.onSingleLineUpdate_(arg_239_0)
			local var_239_0 = arg_236_1.actors_["1077ui_story"]
			local var_239_1 = 0

			if var_239_1 < arg_236_1.time_ and arg_236_1.time_ <= var_239_1 + arg_239_0 and not isNil(var_239_0) and arg_236_1.var_.characterEffect1077ui_story == nil then
				arg_236_1.var_.characterEffect1077ui_story = var_239_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_239_2 = 0.200000002980232

			if var_239_1 <= arg_236_1.time_ and arg_236_1.time_ < var_239_1 + var_239_2 and not isNil(var_239_0) then
				local var_239_3 = (arg_236_1.time_ - var_239_1) / var_239_2

				if arg_236_1.var_.characterEffect1077ui_story and not isNil(var_239_0) then
					local var_239_4 = Mathf.Lerp(0, 0.5, var_239_3)

					arg_236_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_236_1.var_.characterEffect1077ui_story.fillRatio = var_239_4
				end
			end

			if arg_236_1.time_ >= var_239_1 + var_239_2 and arg_236_1.time_ < var_239_1 + var_239_2 + arg_239_0 and not isNil(var_239_0) and arg_236_1.var_.characterEffect1077ui_story then
				local var_239_5 = 0.5

				arg_236_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_236_1.var_.characterEffect1077ui_story.fillRatio = var_239_5
			end

			local var_239_6 = 0
			local var_239_7 = 0.225

			if var_239_6 < arg_236_1.time_ and arg_236_1.time_ <= var_239_6 + arg_239_0 then
				arg_236_1.talkMaxDuration = 0
				arg_236_1.dialogCg_.alpha = 1

				arg_236_1.dialog_:SetActive(true)
				SetActive(arg_236_1.leftNameGo_, true)

				local var_239_8 = arg_236_1:FormatText(StoryNameCfg[1454].name)

				arg_236_1.leftNameTxt_.text = var_239_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_236_1.leftNameTxt_.transform)

				arg_236_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_236_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_236_1:RecordName(arg_236_1.leftNameTxt_.text)
				SetActive(arg_236_1.iconTrs_.gameObject, true)
				arg_236_1.iconController_:SetSelectedState("hero")

				arg_236_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10169")

				arg_236_1.callingController_:SetSelectedState("normal")

				arg_236_1.keyicon_.color = Color.New(1, 1, 1)
				arg_236_1.icon_.color = Color.New(1, 1, 1)

				local var_239_9 = arg_236_1:GetWordFromCfg(325041058)
				local var_239_10 = arg_236_1:FormatText(var_239_9.content)

				arg_236_1.text_.text = var_239_10

				LuaForUtil.ClearLinePrefixSymbol(arg_236_1.text_)

				local var_239_11 = 9
				local var_239_12 = utf8.len(var_239_10)
				local var_239_13 = var_239_11 <= 0 and var_239_7 or var_239_7 * (var_239_12 / var_239_11)

				if var_239_13 > 0 and var_239_7 < var_239_13 then
					arg_236_1.talkMaxDuration = var_239_13

					if var_239_13 + var_239_6 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_13 + var_239_6
					end
				end

				arg_236_1.text_.text = var_239_10
				arg_236_1.typewritter.percent = 0

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325041", "325041058", "story_v_out_325041.awb") ~= 0 then
					local var_239_14 = manager.audio:GetVoiceLength("story_v_out_325041", "325041058", "story_v_out_325041.awb") / 1000

					if var_239_14 + var_239_6 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_14 + var_239_6
					end

					if var_239_9.prefab_name ~= "" and arg_236_1.actors_[var_239_9.prefab_name] ~= nil then
						local var_239_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_236_1.actors_[var_239_9.prefab_name].transform, "story_v_out_325041", "325041058", "story_v_out_325041.awb")

						arg_236_1:RecordAudio("325041058", var_239_15)
						arg_236_1:RecordAudio("325041058", var_239_15)
					else
						arg_236_1:AudioAction("play", "voice", "story_v_out_325041", "325041058", "story_v_out_325041.awb")
					end

					arg_236_1:RecordHistoryTalkVoice("story_v_out_325041", "325041058", "story_v_out_325041.awb")
				end

				arg_236_1:RecordContent(arg_236_1.text_.text)
			end

			local var_239_16 = math.max(var_239_7, arg_236_1.talkMaxDuration)

			if var_239_6 <= arg_236_1.time_ and arg_236_1.time_ < var_239_6 + var_239_16 then
				arg_236_1.typewritter.percent = (arg_236_1.time_ - var_239_6) / var_239_16

				arg_236_1.typewritter:SetDirty()
			end

			if arg_236_1.time_ >= var_239_6 + var_239_16 and arg_236_1.time_ < var_239_6 + var_239_16 + arg_239_0 then
				arg_236_1.typewritter.percent = 1

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(true)
			end
		end

		arg_236_1.nodeConfigList_ = {}

		arg_236_1:InitPlayNodeList()
	end,
	Play325041059 = function(arg_240_0, arg_240_1)
		arg_240_1.time_ = 0
		arg_240_1.frameCnt_ = 0
		arg_240_1.state_ = "playing"
		arg_240_1.curTalkId_ = 325041059
		arg_240_1.duration_ = 8.63

		local var_240_0 = {
			zh = 7.133,
			ja = 8.633
		}
		local var_240_1 = manager.audio:GetLocalizationFlag()

		if var_240_0[var_240_1] ~= nil then
			arg_240_1.duration_ = var_240_0[var_240_1]
		end

		SetActive(arg_240_1.tipsGo_, false)

		function arg_240_1.onSingleLineFinish_()
			arg_240_1.onSingleLineUpdate_ = nil
			arg_240_1.onSingleLineFinish_ = nil
			arg_240_1.state_ = "waiting"
		end

		function arg_240_1.playNext_(arg_242_0)
			if arg_242_0 == 1 then
				arg_240_0:Play325041060(arg_240_1)
			end
		end

		function arg_240_1.onSingleLineUpdate_(arg_243_0)
			local var_243_0 = arg_240_1.actors_["1077ui_story"]
			local var_243_1 = 0

			if var_243_1 < arg_240_1.time_ and arg_240_1.time_ <= var_243_1 + arg_243_0 and not isNil(var_243_0) and arg_240_1.var_.characterEffect1077ui_story == nil then
				arg_240_1.var_.characterEffect1077ui_story = var_243_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_243_2 = 0.200000002980232

			if var_243_1 <= arg_240_1.time_ and arg_240_1.time_ < var_243_1 + var_243_2 and not isNil(var_243_0) then
				local var_243_3 = (arg_240_1.time_ - var_243_1) / var_243_2

				if arg_240_1.var_.characterEffect1077ui_story and not isNil(var_243_0) then
					arg_240_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_240_1.time_ >= var_243_1 + var_243_2 and arg_240_1.time_ < var_243_1 + var_243_2 + arg_243_0 and not isNil(var_243_0) and arg_240_1.var_.characterEffect1077ui_story then
				arg_240_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_243_4 = 0
			local var_243_5 = 0.775

			if var_243_4 < arg_240_1.time_ and arg_240_1.time_ <= var_243_4 + arg_243_0 then
				arg_240_1.talkMaxDuration = 0
				arg_240_1.dialogCg_.alpha = 1

				arg_240_1.dialog_:SetActive(true)
				SetActive(arg_240_1.leftNameGo_, true)

				local var_243_6 = arg_240_1:FormatText(StoryNameCfg[1467].name)

				arg_240_1.leftNameTxt_.text = var_243_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_240_1.leftNameTxt_.transform)

				arg_240_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_240_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_240_1:RecordName(arg_240_1.leftNameTxt_.text)
				SetActive(arg_240_1.iconTrs_.gameObject, false)
				arg_240_1.callingController_:SetSelectedState("normal")

				local var_243_7 = arg_240_1:GetWordFromCfg(325041059)
				local var_243_8 = arg_240_1:FormatText(var_243_7.content)

				arg_240_1.text_.text = var_243_8

				LuaForUtil.ClearLinePrefixSymbol(arg_240_1.text_)

				local var_243_9 = 31
				local var_243_10 = utf8.len(var_243_8)
				local var_243_11 = var_243_9 <= 0 and var_243_5 or var_243_5 * (var_243_10 / var_243_9)

				if var_243_11 > 0 and var_243_5 < var_243_11 then
					arg_240_1.talkMaxDuration = var_243_11

					if var_243_11 + var_243_4 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_11 + var_243_4
					end
				end

				arg_240_1.text_.text = var_243_8
				arg_240_1.typewritter.percent = 0

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325041", "325041059", "story_v_out_325041.awb") ~= 0 then
					local var_243_12 = manager.audio:GetVoiceLength("story_v_out_325041", "325041059", "story_v_out_325041.awb") / 1000

					if var_243_12 + var_243_4 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_12 + var_243_4
					end

					if var_243_7.prefab_name ~= "" and arg_240_1.actors_[var_243_7.prefab_name] ~= nil then
						local var_243_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_240_1.actors_[var_243_7.prefab_name].transform, "story_v_out_325041", "325041059", "story_v_out_325041.awb")

						arg_240_1:RecordAudio("325041059", var_243_13)
						arg_240_1:RecordAudio("325041059", var_243_13)
					else
						arg_240_1:AudioAction("play", "voice", "story_v_out_325041", "325041059", "story_v_out_325041.awb")
					end

					arg_240_1:RecordHistoryTalkVoice("story_v_out_325041", "325041059", "story_v_out_325041.awb")
				end

				arg_240_1:RecordContent(arg_240_1.text_.text)
			end

			local var_243_14 = math.max(var_243_5, arg_240_1.talkMaxDuration)

			if var_243_4 <= arg_240_1.time_ and arg_240_1.time_ < var_243_4 + var_243_14 then
				arg_240_1.typewritter.percent = (arg_240_1.time_ - var_243_4) / var_243_14

				arg_240_1.typewritter:SetDirty()
			end

			if arg_240_1.time_ >= var_243_4 + var_243_14 and arg_240_1.time_ < var_243_4 + var_243_14 + arg_243_0 then
				arg_240_1.typewritter.percent = 1

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(true)
			end
		end

		arg_240_1.nodeConfigList_ = {}

		arg_240_1:InitPlayNodeList()
	end,
	Play325041060 = function(arg_244_0, arg_244_1)
		arg_244_1.time_ = 0
		arg_244_1.frameCnt_ = 0
		arg_244_1.state_ = "playing"
		arg_244_1.curTalkId_ = 325041060
		arg_244_1.duration_ = 4.2

		local var_244_0 = {
			zh = 4.033,
			ja = 4.2
		}
		local var_244_1 = manager.audio:GetLocalizationFlag()

		if var_244_0[var_244_1] ~= nil then
			arg_244_1.duration_ = var_244_0[var_244_1]
		end

		SetActive(arg_244_1.tipsGo_, false)

		function arg_244_1.onSingleLineFinish_()
			arg_244_1.onSingleLineUpdate_ = nil
			arg_244_1.onSingleLineFinish_ = nil
			arg_244_1.state_ = "waiting"
		end

		function arg_244_1.playNext_(arg_246_0)
			if arg_246_0 == 1 then
				arg_244_0:Play325041061(arg_244_1)
			end
		end

		function arg_244_1.onSingleLineUpdate_(arg_247_0)
			local var_247_0 = arg_244_1.actors_["1077ui_story"]
			local var_247_1 = 0

			if var_247_1 < arg_244_1.time_ and arg_244_1.time_ <= var_247_1 + arg_247_0 and not isNil(var_247_0) and arg_244_1.var_.characterEffect1077ui_story == nil then
				arg_244_1.var_.characterEffect1077ui_story = var_247_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_247_2 = 0.200000002980232

			if var_247_1 <= arg_244_1.time_ and arg_244_1.time_ < var_247_1 + var_247_2 and not isNil(var_247_0) then
				local var_247_3 = (arg_244_1.time_ - var_247_1) / var_247_2

				if arg_244_1.var_.characterEffect1077ui_story and not isNil(var_247_0) then
					local var_247_4 = Mathf.Lerp(0, 0.5, var_247_3)

					arg_244_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_244_1.var_.characterEffect1077ui_story.fillRatio = var_247_4
				end
			end

			if arg_244_1.time_ >= var_247_1 + var_247_2 and arg_244_1.time_ < var_247_1 + var_247_2 + arg_247_0 and not isNil(var_247_0) and arg_244_1.var_.characterEffect1077ui_story then
				local var_247_5 = 0.5

				arg_244_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_244_1.var_.characterEffect1077ui_story.fillRatio = var_247_5
			end

			local var_247_6 = 0
			local var_247_7 = 0.275

			if var_247_6 < arg_244_1.time_ and arg_244_1.time_ <= var_247_6 + arg_247_0 then
				arg_244_1.talkMaxDuration = 0
				arg_244_1.dialogCg_.alpha = 1

				arg_244_1.dialog_:SetActive(true)
				SetActive(arg_244_1.leftNameGo_, true)

				local var_247_8 = arg_244_1:FormatText(StoryNameCfg[1454].name)

				arg_244_1.leftNameTxt_.text = var_247_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_244_1.leftNameTxt_.transform)

				arg_244_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_244_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_244_1:RecordName(arg_244_1.leftNameTxt_.text)
				SetActive(arg_244_1.iconTrs_.gameObject, true)
				arg_244_1.iconController_:SetSelectedState("hero")

				arg_244_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10169")

				arg_244_1.callingController_:SetSelectedState("normal")

				arg_244_1.keyicon_.color = Color.New(1, 1, 1)
				arg_244_1.icon_.color = Color.New(1, 1, 1)

				local var_247_9 = arg_244_1:GetWordFromCfg(325041060)
				local var_247_10 = arg_244_1:FormatText(var_247_9.content)

				arg_244_1.text_.text = var_247_10

				LuaForUtil.ClearLinePrefixSymbol(arg_244_1.text_)

				local var_247_11 = 11
				local var_247_12 = utf8.len(var_247_10)
				local var_247_13 = var_247_11 <= 0 and var_247_7 or var_247_7 * (var_247_12 / var_247_11)

				if var_247_13 > 0 and var_247_7 < var_247_13 then
					arg_244_1.talkMaxDuration = var_247_13

					if var_247_13 + var_247_6 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_13 + var_247_6
					end
				end

				arg_244_1.text_.text = var_247_10
				arg_244_1.typewritter.percent = 0

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325041", "325041060", "story_v_out_325041.awb") ~= 0 then
					local var_247_14 = manager.audio:GetVoiceLength("story_v_out_325041", "325041060", "story_v_out_325041.awb") / 1000

					if var_247_14 + var_247_6 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_14 + var_247_6
					end

					if var_247_9.prefab_name ~= "" and arg_244_1.actors_[var_247_9.prefab_name] ~= nil then
						local var_247_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_244_1.actors_[var_247_9.prefab_name].transform, "story_v_out_325041", "325041060", "story_v_out_325041.awb")

						arg_244_1:RecordAudio("325041060", var_247_15)
						arg_244_1:RecordAudio("325041060", var_247_15)
					else
						arg_244_1:AudioAction("play", "voice", "story_v_out_325041", "325041060", "story_v_out_325041.awb")
					end

					arg_244_1:RecordHistoryTalkVoice("story_v_out_325041", "325041060", "story_v_out_325041.awb")
				end

				arg_244_1:RecordContent(arg_244_1.text_.text)
			end

			local var_247_16 = math.max(var_247_7, arg_244_1.talkMaxDuration)

			if var_247_6 <= arg_244_1.time_ and arg_244_1.time_ < var_247_6 + var_247_16 then
				arg_244_1.typewritter.percent = (arg_244_1.time_ - var_247_6) / var_247_16

				arg_244_1.typewritter:SetDirty()
			end

			if arg_244_1.time_ >= var_247_6 + var_247_16 and arg_244_1.time_ < var_247_6 + var_247_16 + arg_247_0 then
				arg_244_1.typewritter.percent = 1

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(true)
			end
		end

		arg_244_1.nodeConfigList_ = {}

		arg_244_1:InitPlayNodeList()
	end,
	Play325041061 = function(arg_248_0, arg_248_1)
		arg_248_1.time_ = 0
		arg_248_1.frameCnt_ = 0
		arg_248_1.state_ = "playing"
		arg_248_1.curTalkId_ = 325041061
		arg_248_1.duration_ = 9.6

		local var_248_0 = {
			zh = 7.5,
			ja = 9.6
		}
		local var_248_1 = manager.audio:GetLocalizationFlag()

		if var_248_0[var_248_1] ~= nil then
			arg_248_1.duration_ = var_248_0[var_248_1]
		end

		SetActive(arg_248_1.tipsGo_, false)

		function arg_248_1.onSingleLineFinish_()
			arg_248_1.onSingleLineUpdate_ = nil
			arg_248_1.onSingleLineFinish_ = nil
			arg_248_1.state_ = "waiting"
		end

		function arg_248_1.playNext_(arg_250_0)
			if arg_250_0 == 1 then
				arg_248_0:Play325041062(arg_248_1)
			end
		end

		function arg_248_1.onSingleLineUpdate_(arg_251_0)
			local var_251_0 = arg_248_1.actors_["1077ui_story"]
			local var_251_1 = 0

			if var_251_1 < arg_248_1.time_ and arg_248_1.time_ <= var_251_1 + arg_251_0 and not isNil(var_251_0) and arg_248_1.var_.characterEffect1077ui_story == nil then
				arg_248_1.var_.characterEffect1077ui_story = var_251_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_251_2 = 0.200000002980232

			if var_251_1 <= arg_248_1.time_ and arg_248_1.time_ < var_251_1 + var_251_2 and not isNil(var_251_0) then
				local var_251_3 = (arg_248_1.time_ - var_251_1) / var_251_2

				if arg_248_1.var_.characterEffect1077ui_story and not isNil(var_251_0) then
					arg_248_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_248_1.time_ >= var_251_1 + var_251_2 and arg_248_1.time_ < var_251_1 + var_251_2 + arg_251_0 and not isNil(var_251_0) and arg_248_1.var_.characterEffect1077ui_story then
				arg_248_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_251_4 = 0
			local var_251_5 = 0.8

			if var_251_4 < arg_248_1.time_ and arg_248_1.time_ <= var_251_4 + arg_251_0 then
				arg_248_1.talkMaxDuration = 0
				arg_248_1.dialogCg_.alpha = 1

				arg_248_1.dialog_:SetActive(true)
				SetActive(arg_248_1.leftNameGo_, true)

				local var_251_6 = arg_248_1:FormatText(StoryNameCfg[1467].name)

				arg_248_1.leftNameTxt_.text = var_251_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_248_1.leftNameTxt_.transform)

				arg_248_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_248_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_248_1:RecordName(arg_248_1.leftNameTxt_.text)
				SetActive(arg_248_1.iconTrs_.gameObject, false)
				arg_248_1.callingController_:SetSelectedState("normal")

				local var_251_7 = arg_248_1:GetWordFromCfg(325041061)
				local var_251_8 = arg_248_1:FormatText(var_251_7.content)

				arg_248_1.text_.text = var_251_8

				LuaForUtil.ClearLinePrefixSymbol(arg_248_1.text_)

				local var_251_9 = 32
				local var_251_10 = utf8.len(var_251_8)
				local var_251_11 = var_251_9 <= 0 and var_251_5 or var_251_5 * (var_251_10 / var_251_9)

				if var_251_11 > 0 and var_251_5 < var_251_11 then
					arg_248_1.talkMaxDuration = var_251_11

					if var_251_11 + var_251_4 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_11 + var_251_4
					end
				end

				arg_248_1.text_.text = var_251_8
				arg_248_1.typewritter.percent = 0

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325041", "325041061", "story_v_out_325041.awb") ~= 0 then
					local var_251_12 = manager.audio:GetVoiceLength("story_v_out_325041", "325041061", "story_v_out_325041.awb") / 1000

					if var_251_12 + var_251_4 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_12 + var_251_4
					end

					if var_251_7.prefab_name ~= "" and arg_248_1.actors_[var_251_7.prefab_name] ~= nil then
						local var_251_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_248_1.actors_[var_251_7.prefab_name].transform, "story_v_out_325041", "325041061", "story_v_out_325041.awb")

						arg_248_1:RecordAudio("325041061", var_251_13)
						arg_248_1:RecordAudio("325041061", var_251_13)
					else
						arg_248_1:AudioAction("play", "voice", "story_v_out_325041", "325041061", "story_v_out_325041.awb")
					end

					arg_248_1:RecordHistoryTalkVoice("story_v_out_325041", "325041061", "story_v_out_325041.awb")
				end

				arg_248_1:RecordContent(arg_248_1.text_.text)
			end

			local var_251_14 = math.max(var_251_5, arg_248_1.talkMaxDuration)

			if var_251_4 <= arg_248_1.time_ and arg_248_1.time_ < var_251_4 + var_251_14 then
				arg_248_1.typewritter.percent = (arg_248_1.time_ - var_251_4) / var_251_14

				arg_248_1.typewritter:SetDirty()
			end

			if arg_248_1.time_ >= var_251_4 + var_251_14 and arg_248_1.time_ < var_251_4 + var_251_14 + arg_251_0 then
				arg_248_1.typewritter.percent = 1

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(true)
			end
		end

		arg_248_1.nodeConfigList_ = {}

		arg_248_1:InitPlayNodeList()
	end,
	Play325041062 = function(arg_252_0, arg_252_1)
		arg_252_1.time_ = 0
		arg_252_1.frameCnt_ = 0
		arg_252_1.state_ = "playing"
		arg_252_1.curTalkId_ = 325041062
		arg_252_1.duration_ = 7.6

		local var_252_0 = {
			zh = 7.6,
			ja = 6.4
		}
		local var_252_1 = manager.audio:GetLocalizationFlag()

		if var_252_0[var_252_1] ~= nil then
			arg_252_1.duration_ = var_252_0[var_252_1]
		end

		SetActive(arg_252_1.tipsGo_, false)

		function arg_252_1.onSingleLineFinish_()
			arg_252_1.onSingleLineUpdate_ = nil
			arg_252_1.onSingleLineFinish_ = nil
			arg_252_1.state_ = "waiting"
		end

		function arg_252_1.playNext_(arg_254_0)
			if arg_254_0 == 1 then
				arg_252_0:Play325041063(arg_252_1)
			end
		end

		function arg_252_1.onSingleLineUpdate_(arg_255_0)
			local var_255_0 = 0

			if var_255_0 < arg_252_1.time_ and arg_252_1.time_ <= var_255_0 + arg_255_0 then
				arg_252_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_255_1 = 0

			if var_255_1 < arg_252_1.time_ and arg_252_1.time_ <= var_255_1 + arg_255_0 then
				arg_252_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action5_1")
			end

			local var_255_2 = 0
			local var_255_3 = 0.925

			if var_255_2 < arg_252_1.time_ and arg_252_1.time_ <= var_255_2 + arg_255_0 then
				arg_252_1.talkMaxDuration = 0
				arg_252_1.dialogCg_.alpha = 1

				arg_252_1.dialog_:SetActive(true)
				SetActive(arg_252_1.leftNameGo_, true)

				local var_255_4 = arg_252_1:FormatText(StoryNameCfg[1467].name)

				arg_252_1.leftNameTxt_.text = var_255_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_252_1.leftNameTxt_.transform)

				arg_252_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_252_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_252_1:RecordName(arg_252_1.leftNameTxt_.text)
				SetActive(arg_252_1.iconTrs_.gameObject, false)
				arg_252_1.callingController_:SetSelectedState("normal")

				local var_255_5 = arg_252_1:GetWordFromCfg(325041062)
				local var_255_6 = arg_252_1:FormatText(var_255_5.content)

				arg_252_1.text_.text = var_255_6

				LuaForUtil.ClearLinePrefixSymbol(arg_252_1.text_)

				local var_255_7 = 37
				local var_255_8 = utf8.len(var_255_6)
				local var_255_9 = var_255_7 <= 0 and var_255_3 or var_255_3 * (var_255_8 / var_255_7)

				if var_255_9 > 0 and var_255_3 < var_255_9 then
					arg_252_1.talkMaxDuration = var_255_9

					if var_255_9 + var_255_2 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_9 + var_255_2
					end
				end

				arg_252_1.text_.text = var_255_6
				arg_252_1.typewritter.percent = 0

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325041", "325041062", "story_v_out_325041.awb") ~= 0 then
					local var_255_10 = manager.audio:GetVoiceLength("story_v_out_325041", "325041062", "story_v_out_325041.awb") / 1000

					if var_255_10 + var_255_2 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_10 + var_255_2
					end

					if var_255_5.prefab_name ~= "" and arg_252_1.actors_[var_255_5.prefab_name] ~= nil then
						local var_255_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_252_1.actors_[var_255_5.prefab_name].transform, "story_v_out_325041", "325041062", "story_v_out_325041.awb")

						arg_252_1:RecordAudio("325041062", var_255_11)
						arg_252_1:RecordAudio("325041062", var_255_11)
					else
						arg_252_1:AudioAction("play", "voice", "story_v_out_325041", "325041062", "story_v_out_325041.awb")
					end

					arg_252_1:RecordHistoryTalkVoice("story_v_out_325041", "325041062", "story_v_out_325041.awb")
				end

				arg_252_1:RecordContent(arg_252_1.text_.text)
			end

			local var_255_12 = math.max(var_255_3, arg_252_1.talkMaxDuration)

			if var_255_2 <= arg_252_1.time_ and arg_252_1.time_ < var_255_2 + var_255_12 then
				arg_252_1.typewritter.percent = (arg_252_1.time_ - var_255_2) / var_255_12

				arg_252_1.typewritter:SetDirty()
			end

			if arg_252_1.time_ >= var_255_2 + var_255_12 and arg_252_1.time_ < var_255_2 + var_255_12 + arg_255_0 then
				arg_252_1.typewritter.percent = 1

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(true)
			end
		end

		arg_252_1.nodeConfigList_ = {}

		arg_252_1:InitPlayNodeList()
	end,
	Play325041063 = function(arg_256_0, arg_256_1)
		arg_256_1.time_ = 0
		arg_256_1.frameCnt_ = 0
		arg_256_1.state_ = "playing"
		arg_256_1.curTalkId_ = 325041063
		arg_256_1.duration_ = 9

		local var_256_0 = {
			zh = 8.033,
			ja = 9
		}
		local var_256_1 = manager.audio:GetLocalizationFlag()

		if var_256_0[var_256_1] ~= nil then
			arg_256_1.duration_ = var_256_0[var_256_1]
		end

		SetActive(arg_256_1.tipsGo_, false)

		function arg_256_1.onSingleLineFinish_()
			arg_256_1.onSingleLineUpdate_ = nil
			arg_256_1.onSingleLineFinish_ = nil
			arg_256_1.state_ = "waiting"
		end

		function arg_256_1.playNext_(arg_258_0)
			if arg_258_0 == 1 then
				arg_256_0:Play325041064(arg_256_1)
			end
		end

		function arg_256_1.onSingleLineUpdate_(arg_259_0)
			local var_259_0 = arg_256_1.actors_["1077ui_story"]
			local var_259_1 = 0

			if var_259_1 < arg_256_1.time_ and arg_256_1.time_ <= var_259_1 + arg_259_0 and not isNil(var_259_0) and arg_256_1.var_.characterEffect1077ui_story == nil then
				arg_256_1.var_.characterEffect1077ui_story = var_259_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_259_2 = 0.200000002980232

			if var_259_1 <= arg_256_1.time_ and arg_256_1.time_ < var_259_1 + var_259_2 and not isNil(var_259_0) then
				local var_259_3 = (arg_256_1.time_ - var_259_1) / var_259_2

				if arg_256_1.var_.characterEffect1077ui_story and not isNil(var_259_0) then
					local var_259_4 = Mathf.Lerp(0, 0.5, var_259_3)

					arg_256_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_256_1.var_.characterEffect1077ui_story.fillRatio = var_259_4
				end
			end

			if arg_256_1.time_ >= var_259_1 + var_259_2 and arg_256_1.time_ < var_259_1 + var_259_2 + arg_259_0 and not isNil(var_259_0) and arg_256_1.var_.characterEffect1077ui_story then
				local var_259_5 = 0.5

				arg_256_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_256_1.var_.characterEffect1077ui_story.fillRatio = var_259_5
			end

			local var_259_6 = 0
			local var_259_7 = 0.775

			if var_259_6 < arg_256_1.time_ and arg_256_1.time_ <= var_259_6 + arg_259_0 then
				arg_256_1.talkMaxDuration = 0
				arg_256_1.dialogCg_.alpha = 1

				arg_256_1.dialog_:SetActive(true)
				SetActive(arg_256_1.leftNameGo_, true)

				local var_259_8 = arg_256_1:FormatText(StoryNameCfg[1454].name)

				arg_256_1.leftNameTxt_.text = var_259_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_256_1.leftNameTxt_.transform)

				arg_256_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_256_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_256_1:RecordName(arg_256_1.leftNameTxt_.text)
				SetActive(arg_256_1.iconTrs_.gameObject, true)
				arg_256_1.iconController_:SetSelectedState("hero")

				arg_256_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10169")

				arg_256_1.callingController_:SetSelectedState("normal")

				arg_256_1.keyicon_.color = Color.New(1, 1, 1)
				arg_256_1.icon_.color = Color.New(1, 1, 1)

				local var_259_9 = arg_256_1:GetWordFromCfg(325041063)
				local var_259_10 = arg_256_1:FormatText(var_259_9.content)

				arg_256_1.text_.text = var_259_10

				LuaForUtil.ClearLinePrefixSymbol(arg_256_1.text_)

				local var_259_11 = 31
				local var_259_12 = utf8.len(var_259_10)
				local var_259_13 = var_259_11 <= 0 and var_259_7 or var_259_7 * (var_259_12 / var_259_11)

				if var_259_13 > 0 and var_259_7 < var_259_13 then
					arg_256_1.talkMaxDuration = var_259_13

					if var_259_13 + var_259_6 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_13 + var_259_6
					end
				end

				arg_256_1.text_.text = var_259_10
				arg_256_1.typewritter.percent = 0

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325041", "325041063", "story_v_out_325041.awb") ~= 0 then
					local var_259_14 = manager.audio:GetVoiceLength("story_v_out_325041", "325041063", "story_v_out_325041.awb") / 1000

					if var_259_14 + var_259_6 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_14 + var_259_6
					end

					if var_259_9.prefab_name ~= "" and arg_256_1.actors_[var_259_9.prefab_name] ~= nil then
						local var_259_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_256_1.actors_[var_259_9.prefab_name].transform, "story_v_out_325041", "325041063", "story_v_out_325041.awb")

						arg_256_1:RecordAudio("325041063", var_259_15)
						arg_256_1:RecordAudio("325041063", var_259_15)
					else
						arg_256_1:AudioAction("play", "voice", "story_v_out_325041", "325041063", "story_v_out_325041.awb")
					end

					arg_256_1:RecordHistoryTalkVoice("story_v_out_325041", "325041063", "story_v_out_325041.awb")
				end

				arg_256_1:RecordContent(arg_256_1.text_.text)
			end

			local var_259_16 = math.max(var_259_7, arg_256_1.talkMaxDuration)

			if var_259_6 <= arg_256_1.time_ and arg_256_1.time_ < var_259_6 + var_259_16 then
				arg_256_1.typewritter.percent = (arg_256_1.time_ - var_259_6) / var_259_16

				arg_256_1.typewritter:SetDirty()
			end

			if arg_256_1.time_ >= var_259_6 + var_259_16 and arg_256_1.time_ < var_259_6 + var_259_16 + arg_259_0 then
				arg_256_1.typewritter.percent = 1

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(true)
			end
		end

		arg_256_1.nodeConfigList_ = {}

		arg_256_1:InitPlayNodeList()
	end,
	Play325041064 = function(arg_260_0, arg_260_1)
		arg_260_1.time_ = 0
		arg_260_1.frameCnt_ = 0
		arg_260_1.state_ = "playing"
		arg_260_1.curTalkId_ = 325041064
		arg_260_1.duration_ = 6.4

		local var_260_0 = {
			zh = 5.733,
			ja = 6.4
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
				arg_260_0:Play325041065(arg_260_1)
			end
		end

		function arg_260_1.onSingleLineUpdate_(arg_263_0)
			local var_263_0 = 0
			local var_263_1 = 0.5

			if var_263_0 < arg_260_1.time_ and arg_260_1.time_ <= var_263_0 + arg_263_0 then
				arg_260_1.talkMaxDuration = 0
				arg_260_1.dialogCg_.alpha = 1

				arg_260_1.dialog_:SetActive(true)
				SetActive(arg_260_1.leftNameGo_, true)

				local var_263_2 = arg_260_1:FormatText(StoryNameCfg[1454].name)

				arg_260_1.leftNameTxt_.text = var_263_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_260_1.leftNameTxt_.transform)

				arg_260_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_260_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_260_1:RecordName(arg_260_1.leftNameTxt_.text)
				SetActive(arg_260_1.iconTrs_.gameObject, true)
				arg_260_1.iconController_:SetSelectedState("hero")

				arg_260_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10169")

				arg_260_1.callingController_:SetSelectedState("normal")

				arg_260_1.keyicon_.color = Color.New(1, 1, 1)
				arg_260_1.icon_.color = Color.New(1, 1, 1)

				local var_263_3 = arg_260_1:GetWordFromCfg(325041064)
				local var_263_4 = arg_260_1:FormatText(var_263_3.content)

				arg_260_1.text_.text = var_263_4

				LuaForUtil.ClearLinePrefixSymbol(arg_260_1.text_)

				local var_263_5 = 20
				local var_263_6 = utf8.len(var_263_4)
				local var_263_7 = var_263_5 <= 0 and var_263_1 or var_263_1 * (var_263_6 / var_263_5)

				if var_263_7 > 0 and var_263_1 < var_263_7 then
					arg_260_1.talkMaxDuration = var_263_7

					if var_263_7 + var_263_0 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_7 + var_263_0
					end
				end

				arg_260_1.text_.text = var_263_4
				arg_260_1.typewritter.percent = 0

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325041", "325041064", "story_v_out_325041.awb") ~= 0 then
					local var_263_8 = manager.audio:GetVoiceLength("story_v_out_325041", "325041064", "story_v_out_325041.awb") / 1000

					if var_263_8 + var_263_0 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_8 + var_263_0
					end

					if var_263_3.prefab_name ~= "" and arg_260_1.actors_[var_263_3.prefab_name] ~= nil then
						local var_263_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_260_1.actors_[var_263_3.prefab_name].transform, "story_v_out_325041", "325041064", "story_v_out_325041.awb")

						arg_260_1:RecordAudio("325041064", var_263_9)
						arg_260_1:RecordAudio("325041064", var_263_9)
					else
						arg_260_1:AudioAction("play", "voice", "story_v_out_325041", "325041064", "story_v_out_325041.awb")
					end

					arg_260_1:RecordHistoryTalkVoice("story_v_out_325041", "325041064", "story_v_out_325041.awb")
				end

				arg_260_1:RecordContent(arg_260_1.text_.text)
			end

			local var_263_10 = math.max(var_263_1, arg_260_1.talkMaxDuration)

			if var_263_0 <= arg_260_1.time_ and arg_260_1.time_ < var_263_0 + var_263_10 then
				arg_260_1.typewritter.percent = (arg_260_1.time_ - var_263_0) / var_263_10

				arg_260_1.typewritter:SetDirty()
			end

			if arg_260_1.time_ >= var_263_0 + var_263_10 and arg_260_1.time_ < var_263_0 + var_263_10 + arg_263_0 then
				arg_260_1.typewritter.percent = 1

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(true)
			end
		end

		arg_260_1.nodeConfigList_ = {}

		arg_260_1:InitPlayNodeList()
	end,
	Play325041065 = function(arg_264_0, arg_264_1)
		arg_264_1.time_ = 0
		arg_264_1.frameCnt_ = 0
		arg_264_1.state_ = "playing"
		arg_264_1.curTalkId_ = 325041065
		arg_264_1.duration_ = 12.33

		local var_264_0 = {
			zh = 10.9,
			ja = 12.333
		}
		local var_264_1 = manager.audio:GetLocalizationFlag()

		if var_264_0[var_264_1] ~= nil then
			arg_264_1.duration_ = var_264_0[var_264_1]
		end

		SetActive(arg_264_1.tipsGo_, false)

		function arg_264_1.onSingleLineFinish_()
			arg_264_1.onSingleLineUpdate_ = nil
			arg_264_1.onSingleLineFinish_ = nil
			arg_264_1.state_ = "waiting"
		end

		function arg_264_1.playNext_(arg_266_0)
			if arg_266_0 == 1 then
				arg_264_0:Play325041066(arg_264_1)
			end
		end

		function arg_264_1.onSingleLineUpdate_(arg_267_0)
			local var_267_0 = 0
			local var_267_1 = 1.075

			if var_267_0 < arg_264_1.time_ and arg_264_1.time_ <= var_267_0 + arg_267_0 then
				arg_264_1.talkMaxDuration = 0
				arg_264_1.dialogCg_.alpha = 1

				arg_264_1.dialog_:SetActive(true)
				SetActive(arg_264_1.leftNameGo_, true)

				local var_267_2 = arg_264_1:FormatText(StoryNameCfg[1454].name)

				arg_264_1.leftNameTxt_.text = var_267_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_264_1.leftNameTxt_.transform)

				arg_264_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_264_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_264_1:RecordName(arg_264_1.leftNameTxt_.text)
				SetActive(arg_264_1.iconTrs_.gameObject, true)
				arg_264_1.iconController_:SetSelectedState("hero")

				arg_264_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10169")

				arg_264_1.callingController_:SetSelectedState("normal")

				arg_264_1.keyicon_.color = Color.New(1, 1, 1)
				arg_264_1.icon_.color = Color.New(1, 1, 1)

				local var_267_3 = arg_264_1:GetWordFromCfg(325041065)
				local var_267_4 = arg_264_1:FormatText(var_267_3.content)

				arg_264_1.text_.text = var_267_4

				LuaForUtil.ClearLinePrefixSymbol(arg_264_1.text_)

				local var_267_5 = 43
				local var_267_6 = utf8.len(var_267_4)
				local var_267_7 = var_267_5 <= 0 and var_267_1 or var_267_1 * (var_267_6 / var_267_5)

				if var_267_7 > 0 and var_267_1 < var_267_7 then
					arg_264_1.talkMaxDuration = var_267_7

					if var_267_7 + var_267_0 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_7 + var_267_0
					end
				end

				arg_264_1.text_.text = var_267_4
				arg_264_1.typewritter.percent = 0

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325041", "325041065", "story_v_out_325041.awb") ~= 0 then
					local var_267_8 = manager.audio:GetVoiceLength("story_v_out_325041", "325041065", "story_v_out_325041.awb") / 1000

					if var_267_8 + var_267_0 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_8 + var_267_0
					end

					if var_267_3.prefab_name ~= "" and arg_264_1.actors_[var_267_3.prefab_name] ~= nil then
						local var_267_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_264_1.actors_[var_267_3.prefab_name].transform, "story_v_out_325041", "325041065", "story_v_out_325041.awb")

						arg_264_1:RecordAudio("325041065", var_267_9)
						arg_264_1:RecordAudio("325041065", var_267_9)
					else
						arg_264_1:AudioAction("play", "voice", "story_v_out_325041", "325041065", "story_v_out_325041.awb")
					end

					arg_264_1:RecordHistoryTalkVoice("story_v_out_325041", "325041065", "story_v_out_325041.awb")
				end

				arg_264_1:RecordContent(arg_264_1.text_.text)
			end

			local var_267_10 = math.max(var_267_1, arg_264_1.talkMaxDuration)

			if var_267_0 <= arg_264_1.time_ and arg_264_1.time_ < var_267_0 + var_267_10 then
				arg_264_1.typewritter.percent = (arg_264_1.time_ - var_267_0) / var_267_10

				arg_264_1.typewritter:SetDirty()
			end

			if arg_264_1.time_ >= var_267_0 + var_267_10 and arg_264_1.time_ < var_267_0 + var_267_10 + arg_267_0 then
				arg_264_1.typewritter.percent = 1

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(true)
			end
		end

		arg_264_1.nodeConfigList_ = {}

		arg_264_1:InitPlayNodeList()
	end,
	Play325041066 = function(arg_268_0, arg_268_1)
		arg_268_1.time_ = 0
		arg_268_1.frameCnt_ = 0
		arg_268_1.state_ = "playing"
		arg_268_1.curTalkId_ = 325041066
		arg_268_1.duration_ = 16.47

		local var_268_0 = {
			zh = 9.466,
			ja = 16.466
		}
		local var_268_1 = manager.audio:GetLocalizationFlag()

		if var_268_0[var_268_1] ~= nil then
			arg_268_1.duration_ = var_268_0[var_268_1]
		end

		SetActive(arg_268_1.tipsGo_, false)

		function arg_268_1.onSingleLineFinish_()
			arg_268_1.onSingleLineUpdate_ = nil
			arg_268_1.onSingleLineFinish_ = nil
			arg_268_1.state_ = "waiting"
		end

		function arg_268_1.playNext_(arg_270_0)
			if arg_270_0 == 1 then
				arg_268_0:Play325041067(arg_268_1)
			end
		end

		function arg_268_1.onSingleLineUpdate_(arg_271_0)
			local var_271_0 = 0
			local var_271_1 = 0.9

			if var_271_0 < arg_268_1.time_ and arg_268_1.time_ <= var_271_0 + arg_271_0 then
				arg_268_1.talkMaxDuration = 0
				arg_268_1.dialogCg_.alpha = 1

				arg_268_1.dialog_:SetActive(true)
				SetActive(arg_268_1.leftNameGo_, true)

				local var_271_2 = arg_268_1:FormatText(StoryNameCfg[1454].name)

				arg_268_1.leftNameTxt_.text = var_271_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_268_1.leftNameTxt_.transform)

				arg_268_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_268_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_268_1:RecordName(arg_268_1.leftNameTxt_.text)
				SetActive(arg_268_1.iconTrs_.gameObject, true)
				arg_268_1.iconController_:SetSelectedState("hero")

				arg_268_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10169")

				arg_268_1.callingController_:SetSelectedState("normal")

				arg_268_1.keyicon_.color = Color.New(1, 1, 1)
				arg_268_1.icon_.color = Color.New(1, 1, 1)

				local var_271_3 = arg_268_1:GetWordFromCfg(325041066)
				local var_271_4 = arg_268_1:FormatText(var_271_3.content)

				arg_268_1.text_.text = var_271_4

				LuaForUtil.ClearLinePrefixSymbol(arg_268_1.text_)

				local var_271_5 = 36
				local var_271_6 = utf8.len(var_271_4)
				local var_271_7 = var_271_5 <= 0 and var_271_1 or var_271_1 * (var_271_6 / var_271_5)

				if var_271_7 > 0 and var_271_1 < var_271_7 then
					arg_268_1.talkMaxDuration = var_271_7

					if var_271_7 + var_271_0 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_7 + var_271_0
					end
				end

				arg_268_1.text_.text = var_271_4
				arg_268_1.typewritter.percent = 0

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325041", "325041066", "story_v_out_325041.awb") ~= 0 then
					local var_271_8 = manager.audio:GetVoiceLength("story_v_out_325041", "325041066", "story_v_out_325041.awb") / 1000

					if var_271_8 + var_271_0 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_8 + var_271_0
					end

					if var_271_3.prefab_name ~= "" and arg_268_1.actors_[var_271_3.prefab_name] ~= nil then
						local var_271_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_268_1.actors_[var_271_3.prefab_name].transform, "story_v_out_325041", "325041066", "story_v_out_325041.awb")

						arg_268_1:RecordAudio("325041066", var_271_9)
						arg_268_1:RecordAudio("325041066", var_271_9)
					else
						arg_268_1:AudioAction("play", "voice", "story_v_out_325041", "325041066", "story_v_out_325041.awb")
					end

					arg_268_1:RecordHistoryTalkVoice("story_v_out_325041", "325041066", "story_v_out_325041.awb")
				end

				arg_268_1:RecordContent(arg_268_1.text_.text)
			end

			local var_271_10 = math.max(var_271_1, arg_268_1.talkMaxDuration)

			if var_271_0 <= arg_268_1.time_ and arg_268_1.time_ < var_271_0 + var_271_10 then
				arg_268_1.typewritter.percent = (arg_268_1.time_ - var_271_0) / var_271_10

				arg_268_1.typewritter:SetDirty()
			end

			if arg_268_1.time_ >= var_271_0 + var_271_10 and arg_268_1.time_ < var_271_0 + var_271_10 + arg_271_0 then
				arg_268_1.typewritter.percent = 1

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(true)
			end
		end

		arg_268_1.nodeConfigList_ = {}

		arg_268_1:InitPlayNodeList()
	end,
	Play325041067 = function(arg_272_0, arg_272_1)
		arg_272_1.time_ = 0
		arg_272_1.frameCnt_ = 0
		arg_272_1.state_ = "playing"
		arg_272_1.curTalkId_ = 325041067
		arg_272_1.duration_ = 9.8

		local var_272_0 = {
			zh = 4.833,
			ja = 9.8
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
				arg_272_0:Play325041068(arg_272_1)
			end
		end

		function arg_272_1.onSingleLineUpdate_(arg_275_0)
			local var_275_0 = arg_272_1.actors_["1077ui_story"]
			local var_275_1 = 0

			if var_275_1 < arg_272_1.time_ and arg_272_1.time_ <= var_275_1 + arg_275_0 and not isNil(var_275_0) and arg_272_1.var_.characterEffect1077ui_story == nil then
				arg_272_1.var_.characterEffect1077ui_story = var_275_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_275_2 = 0.200000002980232

			if var_275_1 <= arg_272_1.time_ and arg_272_1.time_ < var_275_1 + var_275_2 and not isNil(var_275_0) then
				local var_275_3 = (arg_272_1.time_ - var_275_1) / var_275_2

				if arg_272_1.var_.characterEffect1077ui_story and not isNil(var_275_0) then
					arg_272_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_272_1.time_ >= var_275_1 + var_275_2 and arg_272_1.time_ < var_275_1 + var_275_2 + arg_275_0 and not isNil(var_275_0) and arg_272_1.var_.characterEffect1077ui_story then
				arg_272_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_275_4 = 0

			if var_275_4 < arg_272_1.time_ and arg_272_1.time_ <= var_275_4 + arg_275_0 then
				arg_272_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action5_2")
			end

			local var_275_5 = 0

			if var_275_5 < arg_272_1.time_ and arg_272_1.time_ <= var_275_5 + arg_275_0 then
				arg_272_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_275_6 = 0
			local var_275_7 = 0.55

			if var_275_6 < arg_272_1.time_ and arg_272_1.time_ <= var_275_6 + arg_275_0 then
				arg_272_1.talkMaxDuration = 0
				arg_272_1.dialogCg_.alpha = 1

				arg_272_1.dialog_:SetActive(true)
				SetActive(arg_272_1.leftNameGo_, true)

				local var_275_8 = arg_272_1:FormatText(StoryNameCfg[1467].name)

				arg_272_1.leftNameTxt_.text = var_275_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_272_1.leftNameTxt_.transform)

				arg_272_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_272_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_272_1:RecordName(arg_272_1.leftNameTxt_.text)
				SetActive(arg_272_1.iconTrs_.gameObject, false)
				arg_272_1.callingController_:SetSelectedState("normal")

				local var_275_9 = arg_272_1:GetWordFromCfg(325041067)
				local var_275_10 = arg_272_1:FormatText(var_275_9.content)

				arg_272_1.text_.text = var_275_10

				LuaForUtil.ClearLinePrefixSymbol(arg_272_1.text_)

				local var_275_11 = 22
				local var_275_12 = utf8.len(var_275_10)
				local var_275_13 = var_275_11 <= 0 and var_275_7 or var_275_7 * (var_275_12 / var_275_11)

				if var_275_13 > 0 and var_275_7 < var_275_13 then
					arg_272_1.talkMaxDuration = var_275_13

					if var_275_13 + var_275_6 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_13 + var_275_6
					end
				end

				arg_272_1.text_.text = var_275_10
				arg_272_1.typewritter.percent = 0

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325041", "325041067", "story_v_out_325041.awb") ~= 0 then
					local var_275_14 = manager.audio:GetVoiceLength("story_v_out_325041", "325041067", "story_v_out_325041.awb") / 1000

					if var_275_14 + var_275_6 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_14 + var_275_6
					end

					if var_275_9.prefab_name ~= "" and arg_272_1.actors_[var_275_9.prefab_name] ~= nil then
						local var_275_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_272_1.actors_[var_275_9.prefab_name].transform, "story_v_out_325041", "325041067", "story_v_out_325041.awb")

						arg_272_1:RecordAudio("325041067", var_275_15)
						arg_272_1:RecordAudio("325041067", var_275_15)
					else
						arg_272_1:AudioAction("play", "voice", "story_v_out_325041", "325041067", "story_v_out_325041.awb")
					end

					arg_272_1:RecordHistoryTalkVoice("story_v_out_325041", "325041067", "story_v_out_325041.awb")
				end

				arg_272_1:RecordContent(arg_272_1.text_.text)
			end

			local var_275_16 = math.max(var_275_7, arg_272_1.talkMaxDuration)

			if var_275_6 <= arg_272_1.time_ and arg_272_1.time_ < var_275_6 + var_275_16 then
				arg_272_1.typewritter.percent = (arg_272_1.time_ - var_275_6) / var_275_16

				arg_272_1.typewritter:SetDirty()
			end

			if arg_272_1.time_ >= var_275_6 + var_275_16 and arg_272_1.time_ < var_275_6 + var_275_16 + arg_275_0 then
				arg_272_1.typewritter.percent = 1

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(true)
			end
		end

		arg_272_1.nodeConfigList_ = {}

		arg_272_1:InitPlayNodeList()
	end,
	Play325041068 = function(arg_276_0, arg_276_1)
		arg_276_1.time_ = 0
		arg_276_1.frameCnt_ = 0
		arg_276_1.state_ = "playing"
		arg_276_1.curTalkId_ = 325041068
		arg_276_1.duration_ = 2.2

		local var_276_0 = {
			zh = 1.2,
			ja = 2.2
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
				arg_276_0:Play325041069(arg_276_1)
			end
		end

		function arg_276_1.onSingleLineUpdate_(arg_279_0)
			local var_279_0 = arg_276_1.actors_["1077ui_story"]
			local var_279_1 = 0

			if var_279_1 < arg_276_1.time_ and arg_276_1.time_ <= var_279_1 + arg_279_0 and not isNil(var_279_0) and arg_276_1.var_.characterEffect1077ui_story == nil then
				arg_276_1.var_.characterEffect1077ui_story = var_279_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_279_2 = 0.200000002980232

			if var_279_1 <= arg_276_1.time_ and arg_276_1.time_ < var_279_1 + var_279_2 and not isNil(var_279_0) then
				local var_279_3 = (arg_276_1.time_ - var_279_1) / var_279_2

				if arg_276_1.var_.characterEffect1077ui_story and not isNil(var_279_0) then
					local var_279_4 = Mathf.Lerp(0, 0.5, var_279_3)

					arg_276_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_276_1.var_.characterEffect1077ui_story.fillRatio = var_279_4
				end
			end

			if arg_276_1.time_ >= var_279_1 + var_279_2 and arg_276_1.time_ < var_279_1 + var_279_2 + arg_279_0 and not isNil(var_279_0) and arg_276_1.var_.characterEffect1077ui_story then
				local var_279_5 = 0.5

				arg_276_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_276_1.var_.characterEffect1077ui_story.fillRatio = var_279_5
			end

			local var_279_6 = 0
			local var_279_7 = 0.05

			if var_279_6 < arg_276_1.time_ and arg_276_1.time_ <= var_279_6 + arg_279_0 then
				arg_276_1.talkMaxDuration = 0
				arg_276_1.dialogCg_.alpha = 1

				arg_276_1.dialog_:SetActive(true)
				SetActive(arg_276_1.leftNameGo_, true)

				local var_279_8 = arg_276_1:FormatText(StoryNameCfg[1454].name)

				arg_276_1.leftNameTxt_.text = var_279_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_276_1.leftNameTxt_.transform)

				arg_276_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_276_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_276_1:RecordName(arg_276_1.leftNameTxt_.text)
				SetActive(arg_276_1.iconTrs_.gameObject, true)
				arg_276_1.iconController_:SetSelectedState("hero")

				arg_276_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10169")

				arg_276_1.callingController_:SetSelectedState("normal")

				arg_276_1.keyicon_.color = Color.New(1, 1, 1)
				arg_276_1.icon_.color = Color.New(1, 1, 1)

				local var_279_9 = arg_276_1:GetWordFromCfg(325041068)
				local var_279_10 = arg_276_1:FormatText(var_279_9.content)

				arg_276_1.text_.text = var_279_10

				LuaForUtil.ClearLinePrefixSymbol(arg_276_1.text_)

				local var_279_11 = 2
				local var_279_12 = utf8.len(var_279_10)
				local var_279_13 = var_279_11 <= 0 and var_279_7 or var_279_7 * (var_279_12 / var_279_11)

				if var_279_13 > 0 and var_279_7 < var_279_13 then
					arg_276_1.talkMaxDuration = var_279_13

					if var_279_13 + var_279_6 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_13 + var_279_6
					end
				end

				arg_276_1.text_.text = var_279_10
				arg_276_1.typewritter.percent = 0

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325041", "325041068", "story_v_out_325041.awb") ~= 0 then
					local var_279_14 = manager.audio:GetVoiceLength("story_v_out_325041", "325041068", "story_v_out_325041.awb") / 1000

					if var_279_14 + var_279_6 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_14 + var_279_6
					end

					if var_279_9.prefab_name ~= "" and arg_276_1.actors_[var_279_9.prefab_name] ~= nil then
						local var_279_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_276_1.actors_[var_279_9.prefab_name].transform, "story_v_out_325041", "325041068", "story_v_out_325041.awb")

						arg_276_1:RecordAudio("325041068", var_279_15)
						arg_276_1:RecordAudio("325041068", var_279_15)
					else
						arg_276_1:AudioAction("play", "voice", "story_v_out_325041", "325041068", "story_v_out_325041.awb")
					end

					arg_276_1:RecordHistoryTalkVoice("story_v_out_325041", "325041068", "story_v_out_325041.awb")
				end

				arg_276_1:RecordContent(arg_276_1.text_.text)
			end

			local var_279_16 = math.max(var_279_7, arg_276_1.talkMaxDuration)

			if var_279_6 <= arg_276_1.time_ and arg_276_1.time_ < var_279_6 + var_279_16 then
				arg_276_1.typewritter.percent = (arg_276_1.time_ - var_279_6) / var_279_16

				arg_276_1.typewritter:SetDirty()
			end

			if arg_276_1.time_ >= var_279_6 + var_279_16 and arg_276_1.time_ < var_279_6 + var_279_16 + arg_279_0 then
				arg_276_1.typewritter.percent = 1

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(true)
			end
		end

		arg_276_1.nodeConfigList_ = {}

		arg_276_1:InitPlayNodeList()
	end,
	Play325041069 = function(arg_280_0, arg_280_1)
		arg_280_1.time_ = 0
		arg_280_1.frameCnt_ = 0
		arg_280_1.state_ = "playing"
		arg_280_1.curTalkId_ = 325041069
		arg_280_1.duration_ = 7.3

		local var_280_0 = {
			zh = 4.2,
			ja = 7.3
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
				arg_280_0:Play325041070(arg_280_1)
			end
		end

		function arg_280_1.onSingleLineUpdate_(arg_283_0)
			local var_283_0 = arg_280_1.actors_["1077ui_story"]
			local var_283_1 = 0

			if var_283_1 < arg_280_1.time_ and arg_280_1.time_ <= var_283_1 + arg_283_0 and not isNil(var_283_0) and arg_280_1.var_.characterEffect1077ui_story == nil then
				arg_280_1.var_.characterEffect1077ui_story = var_283_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_283_2 = 0.200000002980232

			if var_283_1 <= arg_280_1.time_ and arg_280_1.time_ < var_283_1 + var_283_2 and not isNil(var_283_0) then
				local var_283_3 = (arg_280_1.time_ - var_283_1) / var_283_2

				if arg_280_1.var_.characterEffect1077ui_story and not isNil(var_283_0) then
					arg_280_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_280_1.time_ >= var_283_1 + var_283_2 and arg_280_1.time_ < var_283_1 + var_283_2 + arg_283_0 and not isNil(var_283_0) and arg_280_1.var_.characterEffect1077ui_story then
				arg_280_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_283_4 = 0
			local var_283_5 = 0.525

			if var_283_4 < arg_280_1.time_ and arg_280_1.time_ <= var_283_4 + arg_283_0 then
				arg_280_1.talkMaxDuration = 0
				arg_280_1.dialogCg_.alpha = 1

				arg_280_1.dialog_:SetActive(true)
				SetActive(arg_280_1.leftNameGo_, true)

				local var_283_6 = arg_280_1:FormatText(StoryNameCfg[1467].name)

				arg_280_1.leftNameTxt_.text = var_283_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_280_1.leftNameTxt_.transform)

				arg_280_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_280_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_280_1:RecordName(arg_280_1.leftNameTxt_.text)
				SetActive(arg_280_1.iconTrs_.gameObject, false)
				arg_280_1.callingController_:SetSelectedState("normal")

				local var_283_7 = arg_280_1:GetWordFromCfg(325041069)
				local var_283_8 = arg_280_1:FormatText(var_283_7.content)

				arg_280_1.text_.text = var_283_8

				LuaForUtil.ClearLinePrefixSymbol(arg_280_1.text_)

				local var_283_9 = 21
				local var_283_10 = utf8.len(var_283_8)
				local var_283_11 = var_283_9 <= 0 and var_283_5 or var_283_5 * (var_283_10 / var_283_9)

				if var_283_11 > 0 and var_283_5 < var_283_11 then
					arg_280_1.talkMaxDuration = var_283_11

					if var_283_11 + var_283_4 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_11 + var_283_4
					end
				end

				arg_280_1.text_.text = var_283_8
				arg_280_1.typewritter.percent = 0

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325041", "325041069", "story_v_out_325041.awb") ~= 0 then
					local var_283_12 = manager.audio:GetVoiceLength("story_v_out_325041", "325041069", "story_v_out_325041.awb") / 1000

					if var_283_12 + var_283_4 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_12 + var_283_4
					end

					if var_283_7.prefab_name ~= "" and arg_280_1.actors_[var_283_7.prefab_name] ~= nil then
						local var_283_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_280_1.actors_[var_283_7.prefab_name].transform, "story_v_out_325041", "325041069", "story_v_out_325041.awb")

						arg_280_1:RecordAudio("325041069", var_283_13)
						arg_280_1:RecordAudio("325041069", var_283_13)
					else
						arg_280_1:AudioAction("play", "voice", "story_v_out_325041", "325041069", "story_v_out_325041.awb")
					end

					arg_280_1:RecordHistoryTalkVoice("story_v_out_325041", "325041069", "story_v_out_325041.awb")
				end

				arg_280_1:RecordContent(arg_280_1.text_.text)
			end

			local var_283_14 = math.max(var_283_5, arg_280_1.talkMaxDuration)

			if var_283_4 <= arg_280_1.time_ and arg_280_1.time_ < var_283_4 + var_283_14 then
				arg_280_1.typewritter.percent = (arg_280_1.time_ - var_283_4) / var_283_14

				arg_280_1.typewritter:SetDirty()
			end

			if arg_280_1.time_ >= var_283_4 + var_283_14 and arg_280_1.time_ < var_283_4 + var_283_14 + arg_283_0 then
				arg_280_1.typewritter.percent = 1

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(true)
			end
		end

		arg_280_1.nodeConfigList_ = {}

		arg_280_1:InitPlayNodeList()
	end,
	Play325041070 = function(arg_284_0, arg_284_1)
		arg_284_1.time_ = 0
		arg_284_1.frameCnt_ = 0
		arg_284_1.state_ = "playing"
		arg_284_1.curTalkId_ = 325041070
		arg_284_1.duration_ = 17.4

		local var_284_0 = {
			zh = 8.633,
			ja = 17.4
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
			arg_284_1.auto_ = false
		end

		function arg_284_1.playNext_(arg_286_0)
			arg_284_1.onStoryFinished_()
		end

		function arg_284_1.onSingleLineUpdate_(arg_287_0)
			local var_287_0 = 0

			if var_287_0 < arg_284_1.time_ and arg_284_1.time_ <= var_287_0 + arg_287_0 then
				arg_284_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action1_1")
			end

			local var_287_1 = 0
			local var_287_2 = 1

			if var_287_1 < arg_284_1.time_ and arg_284_1.time_ <= var_287_1 + arg_287_0 then
				local var_287_3 = "play"
				local var_287_4 = "effect"

				arg_284_1:AudioAction(var_287_3, var_287_4, "ui_battle", "ui_battle_stopbgm", "")
			end

			local var_287_5 = 0
			local var_287_6 = 0.925

			if var_287_5 < arg_284_1.time_ and arg_284_1.time_ <= var_287_5 + arg_287_0 then
				arg_284_1.talkMaxDuration = 0
				arg_284_1.dialogCg_.alpha = 1

				arg_284_1.dialog_:SetActive(true)
				SetActive(arg_284_1.leftNameGo_, true)

				local var_287_7 = arg_284_1:FormatText(StoryNameCfg[1467].name)

				arg_284_1.leftNameTxt_.text = var_287_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_284_1.leftNameTxt_.transform)

				arg_284_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_284_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_284_1:RecordName(arg_284_1.leftNameTxt_.text)
				SetActive(arg_284_1.iconTrs_.gameObject, false)
				arg_284_1.callingController_:SetSelectedState("normal")

				local var_287_8 = arg_284_1:GetWordFromCfg(325041070)
				local var_287_9 = arg_284_1:FormatText(var_287_8.content)

				arg_284_1.text_.text = var_287_9

				LuaForUtil.ClearLinePrefixSymbol(arg_284_1.text_)

				local var_287_10 = 37
				local var_287_11 = utf8.len(var_287_9)
				local var_287_12 = var_287_10 <= 0 and var_287_6 or var_287_6 * (var_287_11 / var_287_10)

				if var_287_12 > 0 and var_287_6 < var_287_12 then
					arg_284_1.talkMaxDuration = var_287_12

					if var_287_12 + var_287_5 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_12 + var_287_5
					end
				end

				arg_284_1.text_.text = var_287_9
				arg_284_1.typewritter.percent = 0

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325041", "325041070", "story_v_out_325041.awb") ~= 0 then
					local var_287_13 = manager.audio:GetVoiceLength("story_v_out_325041", "325041070", "story_v_out_325041.awb") / 1000

					if var_287_13 + var_287_5 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_13 + var_287_5
					end

					if var_287_8.prefab_name ~= "" and arg_284_1.actors_[var_287_8.prefab_name] ~= nil then
						local var_287_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_284_1.actors_[var_287_8.prefab_name].transform, "story_v_out_325041", "325041070", "story_v_out_325041.awb")

						arg_284_1:RecordAudio("325041070", var_287_14)
						arg_284_1:RecordAudio("325041070", var_287_14)
					else
						arg_284_1:AudioAction("play", "voice", "story_v_out_325041", "325041070", "story_v_out_325041.awb")
					end

					arg_284_1:RecordHistoryTalkVoice("story_v_out_325041", "325041070", "story_v_out_325041.awb")
				end

				arg_284_1:RecordContent(arg_284_1.text_.text)
			end

			local var_287_15 = math.max(var_287_6, arg_284_1.talkMaxDuration)

			if var_287_5 <= arg_284_1.time_ and arg_284_1.time_ < var_287_5 + var_287_15 then
				arg_284_1.typewritter.percent = (arg_284_1.time_ - var_287_5) / var_287_15

				arg_284_1.typewritter:SetDirty()
			end

			if arg_284_1.time_ >= var_287_5 + var_287_15 and arg_284_1.time_ < var_287_5 + var_287_15 + arg_287_0 then
				arg_284_1.typewritter.percent = 1

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(true)
			end
		end

		arg_284_1.nodeConfigList_ = {}

		arg_284_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/J24g",
		"TextureConfig/Background/ST2005"
	},
	voices = {
		"story_v_out_325041.awb"
	}
}
