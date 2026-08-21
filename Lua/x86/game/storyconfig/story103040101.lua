return {
	Play304011001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 304011001
		arg_1_1.duration_ = 6.2

		local var_1_0 = {
			zh = 5.833,
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
				arg_1_0:Play304011002(arg_1_1)
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

			local var_4_24 = 0.2
			local var_4_25 = 1

			if var_4_24 < arg_1_1.time_ and arg_1_1.time_ <= var_4_24 + arg_4_0 then
				local var_4_26 = "play"
				local var_4_27 = "effect"

				arg_1_1:AudioAction(var_4_26, var_4_27, "se_story_145", "se_story_145_amb_drone_haizhen", "")
			end

			local var_4_28 = 1
			local var_4_29 = 1

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				local var_4_30 = "play"
				local var_4_31 = "music"

				arg_1_1:AudioAction(var_4_30, var_4_31, "bgm_story_scheme", "bgm_story_scheme", "bgm_story_scheme.awb")

				local var_4_32 = ""
				local var_4_33 = manager.audio:GetAudioName("bgm_story_scheme", "bgm_story_scheme")

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

				arg_1_1:AudioAction(var_4_36, var_4_37, "ui_battle", "ui_battle_stopbgm", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_38 = 1.9
			local var_4_39 = 0.325

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

				local var_4_41 = arg_1_1:FormatText(StoryNameCfg[36].name)

				arg_1_1.leftNameTxt_.text = var_4_41

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_42 = arg_1_1:GetWordFromCfg(304011001)
				local var_4_43 = arg_1_1:FormatText(var_4_42.content)

				arg_1_1.text_.text = var_4_43

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_44 = 13
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

				if manager.audio:GetVoiceLength("story_v_out_304011", "304011001", "story_v_out_304011.awb") ~= 0 then
					local var_4_47 = manager.audio:GetVoiceLength("story_v_out_304011", "304011001", "story_v_out_304011.awb") / 1000

					if var_4_47 + var_4_38 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_47 + var_4_38
					end

					if var_4_42.prefab_name ~= "" and arg_1_1.actors_[var_4_42.prefab_name] ~= nil then
						local var_4_48 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_42.prefab_name].transform, "story_v_out_304011", "304011001", "story_v_out_304011.awb")

						arg_1_1:RecordAudio("304011001", var_4_48)
						arg_1_1:RecordAudio("304011001", var_4_48)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_304011", "304011001", "story_v_out_304011.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_304011", "304011001", "story_v_out_304011.awb")
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
	Play304011002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 304011002
		arg_8_1.duration_ = 6.17

		local var_8_0 = {
			zh = 6.166,
			ja = 5.933
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
				arg_8_0:Play304011003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 0
			local var_11_1 = 0.625

			if var_11_0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_0 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				local var_11_2 = arg_8_1:FormatText(StoryNameCfg[36].name)

				arg_8_1.leftNameTxt_.text = var_11_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_3 = arg_8_1:GetWordFromCfg(304011002)
				local var_11_4 = arg_8_1:FormatText(var_11_3.content)

				arg_8_1.text_.text = var_11_4

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_5 = 25
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

				if manager.audio:GetVoiceLength("story_v_out_304011", "304011002", "story_v_out_304011.awb") ~= 0 then
					local var_11_8 = manager.audio:GetVoiceLength("story_v_out_304011", "304011002", "story_v_out_304011.awb") / 1000

					if var_11_8 + var_11_0 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_8 + var_11_0
					end

					if var_11_3.prefab_name ~= "" and arg_8_1.actors_[var_11_3.prefab_name] ~= nil then
						local var_11_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_3.prefab_name].transform, "story_v_out_304011", "304011002", "story_v_out_304011.awb")

						arg_8_1:RecordAudio("304011002", var_11_9)
						arg_8_1:RecordAudio("304011002", var_11_9)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_304011", "304011002", "story_v_out_304011.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_304011", "304011002", "story_v_out_304011.awb")
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
	Play304011003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 304011003
		arg_12_1.duration_ = 8.13

		local var_12_0 = {
			zh = 7.666,
			ja = 8.133
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
				arg_12_0:Play304011004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 0
			local var_15_1 = 0.725

			if var_15_0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_0 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				local var_15_2 = arg_12_1:FormatText(StoryNameCfg[36].name)

				arg_12_1.leftNameTxt_.text = var_15_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_3 = arg_12_1:GetWordFromCfg(304011003)
				local var_15_4 = arg_12_1:FormatText(var_15_3.content)

				arg_12_1.text_.text = var_15_4

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_5 = 29
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

				if manager.audio:GetVoiceLength("story_v_out_304011", "304011003", "story_v_out_304011.awb") ~= 0 then
					local var_15_8 = manager.audio:GetVoiceLength("story_v_out_304011", "304011003", "story_v_out_304011.awb") / 1000

					if var_15_8 + var_15_0 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_8 + var_15_0
					end

					if var_15_3.prefab_name ~= "" and arg_12_1.actors_[var_15_3.prefab_name] ~= nil then
						local var_15_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_3.prefab_name].transform, "story_v_out_304011", "304011003", "story_v_out_304011.awb")

						arg_12_1:RecordAudio("304011003", var_15_9)
						arg_12_1:RecordAudio("304011003", var_15_9)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_304011", "304011003", "story_v_out_304011.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_304011", "304011003", "story_v_out_304011.awb")
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
	Play304011004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 304011004
		arg_16_1.duration_ = 5.63

		local var_16_0 = {
			zh = 3.233,
			ja = 5.633
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
				arg_16_0:Play304011005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = 0
			local var_19_1 = 0.325

			if var_19_0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_0 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				local var_19_2 = arg_16_1:FormatText(StoryNameCfg[36].name)

				arg_16_1.leftNameTxt_.text = var_19_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_3 = arg_16_1:GetWordFromCfg(304011004)
				local var_19_4 = arg_16_1:FormatText(var_19_3.content)

				arg_16_1.text_.text = var_19_4

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_5 = 13
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

				if manager.audio:GetVoiceLength("story_v_out_304011", "304011004", "story_v_out_304011.awb") ~= 0 then
					local var_19_8 = manager.audio:GetVoiceLength("story_v_out_304011", "304011004", "story_v_out_304011.awb") / 1000

					if var_19_8 + var_19_0 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_8 + var_19_0
					end

					if var_19_3.prefab_name ~= "" and arg_16_1.actors_[var_19_3.prefab_name] ~= nil then
						local var_19_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_3.prefab_name].transform, "story_v_out_304011", "304011004", "story_v_out_304011.awb")

						arg_16_1:RecordAudio("304011004", var_19_9)
						arg_16_1:RecordAudio("304011004", var_19_9)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_304011", "304011004", "story_v_out_304011.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_304011", "304011004", "story_v_out_304011.awb")
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
	Play304011005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 304011005
		arg_20_1.duration_ = 4.83

		local var_20_0 = {
			zh = 4.833,
			ja = 4.466
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
				arg_20_0:Play304011006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = 0
			local var_23_1 = 0.4

			if var_23_0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_0 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				local var_23_2 = arg_20_1:FormatText(StoryNameCfg[36].name)

				arg_20_1.leftNameTxt_.text = var_23_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_3 = arg_20_1:GetWordFromCfg(304011005)
				local var_23_4 = arg_20_1:FormatText(var_23_3.content)

				arg_20_1.text_.text = var_23_4

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_5 = 16
				local var_23_6 = utf8.len(var_23_4)
				local var_23_7 = var_23_5 <= 0 and var_23_1 or var_23_1 * (var_23_6 / var_23_5)

				if var_23_7 > 0 and var_23_1 < var_23_7 then
					arg_20_1.talkMaxDuration = var_23_7

					if var_23_7 + var_23_0 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_7 + var_23_0
					end
				end

				arg_20_1.text_.text = var_23_4
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304011", "304011005", "story_v_out_304011.awb") ~= 0 then
					local var_23_8 = manager.audio:GetVoiceLength("story_v_out_304011", "304011005", "story_v_out_304011.awb") / 1000

					if var_23_8 + var_23_0 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_8 + var_23_0
					end

					if var_23_3.prefab_name ~= "" and arg_20_1.actors_[var_23_3.prefab_name] ~= nil then
						local var_23_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_3.prefab_name].transform, "story_v_out_304011", "304011005", "story_v_out_304011.awb")

						arg_20_1:RecordAudio("304011005", var_23_9)
						arg_20_1:RecordAudio("304011005", var_23_9)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_304011", "304011005", "story_v_out_304011.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_304011", "304011005", "story_v_out_304011.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_10 = math.max(var_23_1, arg_20_1.talkMaxDuration)

			if var_23_0 <= arg_20_1.time_ and arg_20_1.time_ < var_23_0 + var_23_10 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_0) / var_23_10

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_0 + var_23_10 and arg_20_1.time_ < var_23_0 + var_23_10 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play304011006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 304011006
		arg_24_1.duration_ = 5.37

		local var_24_0 = {
			zh = 5.366,
			ja = 5.266
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
				arg_24_0:Play304011007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = 0
			local var_27_1 = 0.475

			if var_27_0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_0 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				local var_27_2 = arg_24_1:FormatText(StoryNameCfg[36].name)

				arg_24_1.leftNameTxt_.text = var_27_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_3 = arg_24_1:GetWordFromCfg(304011006)
				local var_27_4 = arg_24_1:FormatText(var_27_3.content)

				arg_24_1.text_.text = var_27_4

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_5 = 19
				local var_27_6 = utf8.len(var_27_4)
				local var_27_7 = var_27_5 <= 0 and var_27_1 or var_27_1 * (var_27_6 / var_27_5)

				if var_27_7 > 0 and var_27_1 < var_27_7 then
					arg_24_1.talkMaxDuration = var_27_7

					if var_27_7 + var_27_0 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_7 + var_27_0
					end
				end

				arg_24_1.text_.text = var_27_4
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304011", "304011006", "story_v_out_304011.awb") ~= 0 then
					local var_27_8 = manager.audio:GetVoiceLength("story_v_out_304011", "304011006", "story_v_out_304011.awb") / 1000

					if var_27_8 + var_27_0 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_8 + var_27_0
					end

					if var_27_3.prefab_name ~= "" and arg_24_1.actors_[var_27_3.prefab_name] ~= nil then
						local var_27_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_3.prefab_name].transform, "story_v_out_304011", "304011006", "story_v_out_304011.awb")

						arg_24_1:RecordAudio("304011006", var_27_9)
						arg_24_1:RecordAudio("304011006", var_27_9)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_304011", "304011006", "story_v_out_304011.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_304011", "304011006", "story_v_out_304011.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_10 = math.max(var_27_1, arg_24_1.talkMaxDuration)

			if var_27_0 <= arg_24_1.time_ and arg_24_1.time_ < var_27_0 + var_27_10 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_0) / var_27_10

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_0 + var_27_10 and arg_24_1.time_ < var_27_0 + var_27_10 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play304011007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 304011007
		arg_28_1.duration_ = 6

		local var_28_0 = {
			zh = 5.2,
			ja = 6
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
				arg_28_0:Play304011008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = 0
			local var_31_1 = 0.5

			if var_31_0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_0 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				local var_31_2 = arg_28_1:FormatText(StoryNameCfg[36].name)

				arg_28_1.leftNameTxt_.text = var_31_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_3 = arg_28_1:GetWordFromCfg(304011007)
				local var_31_4 = arg_28_1:FormatText(var_31_3.content)

				arg_28_1.text_.text = var_31_4

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_5 = 20
				local var_31_6 = utf8.len(var_31_4)
				local var_31_7 = var_31_5 <= 0 and var_31_1 or var_31_1 * (var_31_6 / var_31_5)

				if var_31_7 > 0 and var_31_1 < var_31_7 then
					arg_28_1.talkMaxDuration = var_31_7

					if var_31_7 + var_31_0 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_7 + var_31_0
					end
				end

				arg_28_1.text_.text = var_31_4
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304011", "304011007", "story_v_out_304011.awb") ~= 0 then
					local var_31_8 = manager.audio:GetVoiceLength("story_v_out_304011", "304011007", "story_v_out_304011.awb") / 1000

					if var_31_8 + var_31_0 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_8 + var_31_0
					end

					if var_31_3.prefab_name ~= "" and arg_28_1.actors_[var_31_3.prefab_name] ~= nil then
						local var_31_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_3.prefab_name].transform, "story_v_out_304011", "304011007", "story_v_out_304011.awb")

						arg_28_1:RecordAudio("304011007", var_31_9)
						arg_28_1:RecordAudio("304011007", var_31_9)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_304011", "304011007", "story_v_out_304011.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_304011", "304011007", "story_v_out_304011.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_10 = math.max(var_31_1, arg_28_1.talkMaxDuration)

			if var_31_0 <= arg_28_1.time_ and arg_28_1.time_ < var_31_0 + var_31_10 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_0) / var_31_10

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_0 + var_31_10 and arg_28_1.time_ < var_31_0 + var_31_10 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play304011008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 304011008
		arg_32_1.duration_ = 9.97

		local var_32_0 = {
			zh = 6.1,
			ja = 9.966
		}
		local var_32_1 = manager.audio:GetLocalizationFlag()

		if var_32_0[var_32_1] ~= nil then
			arg_32_1.duration_ = var_32_0[var_32_1]
		end

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play304011009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = 0
			local var_35_1 = 0.725

			if var_35_0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_0 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				local var_35_2 = arg_32_1:FormatText(StoryNameCfg[36].name)

				arg_32_1.leftNameTxt_.text = var_35_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_3 = arg_32_1:GetWordFromCfg(304011008)
				local var_35_4 = arg_32_1:FormatText(var_35_3.content)

				arg_32_1.text_.text = var_35_4

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_5 = 29
				local var_35_6 = utf8.len(var_35_4)
				local var_35_7 = var_35_5 <= 0 and var_35_1 or var_35_1 * (var_35_6 / var_35_5)

				if var_35_7 > 0 and var_35_1 < var_35_7 then
					arg_32_1.talkMaxDuration = var_35_7

					if var_35_7 + var_35_0 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_7 + var_35_0
					end
				end

				arg_32_1.text_.text = var_35_4
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304011", "304011008", "story_v_out_304011.awb") ~= 0 then
					local var_35_8 = manager.audio:GetVoiceLength("story_v_out_304011", "304011008", "story_v_out_304011.awb") / 1000

					if var_35_8 + var_35_0 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_8 + var_35_0
					end

					if var_35_3.prefab_name ~= "" and arg_32_1.actors_[var_35_3.prefab_name] ~= nil then
						local var_35_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_3.prefab_name].transform, "story_v_out_304011", "304011008", "story_v_out_304011.awb")

						arg_32_1:RecordAudio("304011008", var_35_9)
						arg_32_1:RecordAudio("304011008", var_35_9)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_304011", "304011008", "story_v_out_304011.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_304011", "304011008", "story_v_out_304011.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_10 = math.max(var_35_1, arg_32_1.talkMaxDuration)

			if var_35_0 <= arg_32_1.time_ and arg_32_1.time_ < var_35_0 + var_35_10 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_0) / var_35_10

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_0 + var_35_10 and arg_32_1.time_ < var_35_0 + var_35_10 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play304011009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 304011009
		arg_36_1.duration_ = 7.67

		local var_36_0 = {
			zh = 7.666,
			ja = 5.633
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
				arg_36_0:Play304011010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = 0
			local var_39_1 = 0.725

			if var_39_0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_0 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				local var_39_2 = arg_36_1:FormatText(StoryNameCfg[36].name)

				arg_36_1.leftNameTxt_.text = var_39_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_3 = arg_36_1:GetWordFromCfg(304011009)
				local var_39_4 = arg_36_1:FormatText(var_39_3.content)

				arg_36_1.text_.text = var_39_4

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_5 = 29
				local var_39_6 = utf8.len(var_39_4)
				local var_39_7 = var_39_5 <= 0 and var_39_1 or var_39_1 * (var_39_6 / var_39_5)

				if var_39_7 > 0 and var_39_1 < var_39_7 then
					arg_36_1.talkMaxDuration = var_39_7

					if var_39_7 + var_39_0 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_7 + var_39_0
					end
				end

				arg_36_1.text_.text = var_39_4
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304011", "304011009", "story_v_out_304011.awb") ~= 0 then
					local var_39_8 = manager.audio:GetVoiceLength("story_v_out_304011", "304011009", "story_v_out_304011.awb") / 1000

					if var_39_8 + var_39_0 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_8 + var_39_0
					end

					if var_39_3.prefab_name ~= "" and arg_36_1.actors_[var_39_3.prefab_name] ~= nil then
						local var_39_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_3.prefab_name].transform, "story_v_out_304011", "304011009", "story_v_out_304011.awb")

						arg_36_1:RecordAudio("304011009", var_39_9)
						arg_36_1:RecordAudio("304011009", var_39_9)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_304011", "304011009", "story_v_out_304011.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_304011", "304011009", "story_v_out_304011.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_10 = math.max(var_39_1, arg_36_1.talkMaxDuration)

			if var_39_0 <= arg_36_1.time_ and arg_36_1.time_ < var_39_0 + var_39_10 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_0) / var_39_10

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_0 + var_39_10 and arg_36_1.time_ < var_39_0 + var_39_10 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play304011010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 304011010
		arg_40_1.duration_ = 5

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play304011011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = 0
			local var_43_1 = 1.025

			if var_43_0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_0 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, false)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_2 = arg_40_1:GetWordFromCfg(304011010)
				local var_43_3 = arg_40_1:FormatText(var_43_2.content)

				arg_40_1.text_.text = var_43_3

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_4 = 41
				local var_43_5 = utf8.len(var_43_3)
				local var_43_6 = var_43_4 <= 0 and var_43_1 or var_43_1 * (var_43_5 / var_43_4)

				if var_43_6 > 0 and var_43_1 < var_43_6 then
					arg_40_1.talkMaxDuration = var_43_6

					if var_43_6 + var_43_0 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_6 + var_43_0
					end
				end

				arg_40_1.text_.text = var_43_3
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)
				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_7 = math.max(var_43_1, arg_40_1.talkMaxDuration)

			if var_43_0 <= arg_40_1.time_ and arg_40_1.time_ < var_43_0 + var_43_7 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_0) / var_43_7

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_0 + var_43_7 and arg_40_1.time_ < var_43_0 + var_43_7 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play304011011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 304011011
		arg_44_1.duration_ = 5.2

		local var_44_0 = {
			zh = 5.2,
			ja = 4
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
				arg_44_0:Play304011012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = 0
			local var_47_1 = 0.45

			if var_47_0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_0 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				local var_47_2 = arg_44_1:FormatText(StoryNameCfg[36].name)

				arg_44_1.leftNameTxt_.text = var_47_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_3 = arg_44_1:GetWordFromCfg(304011011)
				local var_47_4 = arg_44_1:FormatText(var_47_3.content)

				arg_44_1.text_.text = var_47_4

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_5 = 18
				local var_47_6 = utf8.len(var_47_4)
				local var_47_7 = var_47_5 <= 0 and var_47_1 or var_47_1 * (var_47_6 / var_47_5)

				if var_47_7 > 0 and var_47_1 < var_47_7 then
					arg_44_1.talkMaxDuration = var_47_7

					if var_47_7 + var_47_0 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_7 + var_47_0
					end
				end

				arg_44_1.text_.text = var_47_4
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304011", "304011011", "story_v_out_304011.awb") ~= 0 then
					local var_47_8 = manager.audio:GetVoiceLength("story_v_out_304011", "304011011", "story_v_out_304011.awb") / 1000

					if var_47_8 + var_47_0 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_8 + var_47_0
					end

					if var_47_3.prefab_name ~= "" and arg_44_1.actors_[var_47_3.prefab_name] ~= nil then
						local var_47_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_3.prefab_name].transform, "story_v_out_304011", "304011011", "story_v_out_304011.awb")

						arg_44_1:RecordAudio("304011011", var_47_9)
						arg_44_1:RecordAudio("304011011", var_47_9)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_304011", "304011011", "story_v_out_304011.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_304011", "304011011", "story_v_out_304011.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_10 = math.max(var_47_1, arg_44_1.talkMaxDuration)

			if var_47_0 <= arg_44_1.time_ and arg_44_1.time_ < var_47_0 + var_47_10 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_0) / var_47_10

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_0 + var_47_10 and arg_44_1.time_ < var_47_0 + var_47_10 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play304011012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 304011012
		arg_48_1.duration_ = 8.97

		local var_48_0 = {
			zh = 8.966,
			ja = 2.6
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
				arg_48_0:Play304011013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = 0
			local var_51_1 = 1

			if var_51_0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_0 + arg_51_0 then
				local var_51_2 = "play"
				local var_51_3 = "effect"

				arg_48_1:AudioAction(var_51_2, var_51_3, "ui_battle", "ui_battle_stopbgm", "")
			end

			local var_51_4 = 0
			local var_51_5 = 0.6

			if var_51_4 < arg_48_1.time_ and arg_48_1.time_ <= var_51_4 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				local var_51_6 = arg_48_1:FormatText(StoryNameCfg[36].name)

				arg_48_1.leftNameTxt_.text = var_51_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_7 = arg_48_1:GetWordFromCfg(304011012)
				local var_51_8 = arg_48_1:FormatText(var_51_7.content)

				arg_48_1.text_.text = var_51_8

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_9 = 24
				local var_51_10 = utf8.len(var_51_8)
				local var_51_11 = var_51_9 <= 0 and var_51_5 or var_51_5 * (var_51_10 / var_51_9)

				if var_51_11 > 0 and var_51_5 < var_51_11 then
					arg_48_1.talkMaxDuration = var_51_11

					if var_51_11 + var_51_4 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_11 + var_51_4
					end
				end

				arg_48_1.text_.text = var_51_8
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304011", "304011012", "story_v_out_304011.awb") ~= 0 then
					local var_51_12 = manager.audio:GetVoiceLength("story_v_out_304011", "304011012", "story_v_out_304011.awb") / 1000

					if var_51_12 + var_51_4 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_12 + var_51_4
					end

					if var_51_7.prefab_name ~= "" and arg_48_1.actors_[var_51_7.prefab_name] ~= nil then
						local var_51_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_7.prefab_name].transform, "story_v_out_304011", "304011012", "story_v_out_304011.awb")

						arg_48_1:RecordAudio("304011012", var_51_13)
						arg_48_1:RecordAudio("304011012", var_51_13)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_304011", "304011012", "story_v_out_304011.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_304011", "304011012", "story_v_out_304011.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_14 = math.max(var_51_5, arg_48_1.talkMaxDuration)

			if var_51_4 <= arg_48_1.time_ and arg_48_1.time_ < var_51_4 + var_51_14 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_4) / var_51_14

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_4 + var_51_14 and arg_48_1.time_ < var_51_4 + var_51_14 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play304011013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 304011013
		arg_52_1.duration_ = 4.2

		local var_52_0 = {
			zh = 4.199666666666,
			ja = 3.599666666666
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
				arg_52_0:Play304011014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = "A00"

			if arg_52_1.bgs_[var_55_0] == nil then
				local var_55_1 = Object.Instantiate(arg_52_1.paintGo_)

				var_55_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_55_0)
				var_55_1.name = var_55_0
				var_55_1.transform.parent = arg_52_1.stage_.transform
				var_55_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_52_1.bgs_[var_55_0] = var_55_1
			end

			local var_55_2 = 1.13333333333333

			if var_55_2 < arg_52_1.time_ and arg_52_1.time_ <= var_55_2 + arg_55_0 then
				local var_55_3 = manager.ui.mainCamera.transform.localPosition
				local var_55_4 = Vector3.New(0, 0, 10) + Vector3.New(var_55_3.x, var_55_3.y, 0)
				local var_55_5 = arg_52_1.bgs_.A00

				var_55_5.transform.localPosition = var_55_4
				var_55_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_55_6 = var_55_5:GetComponent("SpriteRenderer")

				if var_55_6 and var_55_6.sprite then
					local var_55_7 = (var_55_5.transform.localPosition - var_55_3).z
					local var_55_8 = manager.ui.mainCameraCom_
					local var_55_9 = 2 * var_55_7 * Mathf.Tan(var_55_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_55_10 = var_55_9 * var_55_8.aspect
					local var_55_11 = var_55_6.sprite.bounds.size.x
					local var_55_12 = var_55_6.sprite.bounds.size.y
					local var_55_13 = var_55_10 / var_55_11
					local var_55_14 = var_55_9 / var_55_12
					local var_55_15 = var_55_14 < var_55_13 and var_55_13 or var_55_14

					var_55_5.transform.localScale = Vector3.New(var_55_15, var_55_15, 0)
				end

				for iter_55_0, iter_55_1 in pairs(arg_52_1.bgs_) do
					if iter_55_0 ~= "A00" then
						iter_55_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_55_16 = 0

			if var_55_16 < arg_52_1.time_ and arg_52_1.time_ <= var_55_16 + arg_55_0 then
				arg_52_1.allBtn_.enabled = false
			end

			local var_55_17 = 0.3

			if arg_52_1.time_ >= var_55_16 + var_55_17 and arg_52_1.time_ < var_55_16 + var_55_17 + arg_55_0 then
				arg_52_1.allBtn_.enabled = true
			end

			local var_55_18 = 0

			if var_55_18 < arg_52_1.time_ and arg_52_1.time_ <= var_55_18 + arg_55_0 then
				arg_52_1.mask_.enabled = true
				arg_52_1.mask_.raycastTarget = true

				arg_52_1:SetGaussion(false)
			end

			local var_55_19 = 1.13333333333333

			if var_55_18 <= arg_52_1.time_ and arg_52_1.time_ < var_55_18 + var_55_19 then
				local var_55_20 = (arg_52_1.time_ - var_55_18) / var_55_19
				local var_55_21 = Color.New(0, 0, 0)

				var_55_21.a = Mathf.Lerp(0, 1, var_55_20)
				arg_52_1.mask_.color = var_55_21
			end

			if arg_52_1.time_ >= var_55_18 + var_55_19 and arg_52_1.time_ < var_55_18 + var_55_19 + arg_55_0 then
				local var_55_22 = Color.New(0, 0, 0)

				var_55_22.a = 1
				arg_52_1.mask_.color = var_55_22
			end

			local var_55_23 = 1.13333333333333

			if var_55_23 < arg_52_1.time_ and arg_52_1.time_ <= var_55_23 + arg_55_0 then
				arg_52_1.mask_.enabled = true
				arg_52_1.mask_.raycastTarget = true

				arg_52_1:SetGaussion(false)
			end

			local var_55_24 = 1.13333333333333

			if var_55_23 <= arg_52_1.time_ and arg_52_1.time_ < var_55_23 + var_55_24 then
				local var_55_25 = (arg_52_1.time_ - var_55_23) / var_55_24
				local var_55_26 = Color.New(0, 0, 0)

				var_55_26.a = Mathf.Lerp(1, 0, var_55_25)
				arg_52_1.mask_.color = var_55_26
			end

			if arg_52_1.time_ >= var_55_23 + var_55_24 and arg_52_1.time_ < var_55_23 + var_55_24 + arg_55_0 then
				local var_55_27 = Color.New(0, 0, 0)
				local var_55_28 = 0

				arg_52_1.mask_.enabled = false
				var_55_27.a = var_55_28
				arg_52_1.mask_.color = var_55_27
			end

			local var_55_29 = "1084ui_story"

			if arg_52_1.actors_[var_55_29] == nil then
				local var_55_30 = Asset.Load("Char/" .. "1084ui_story")

				if not isNil(var_55_30) then
					local var_55_31 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_52_1.stage_.transform)

					var_55_31.name = var_55_29
					var_55_31.transform.localPosition = Vector3.New(0, 100, 0)
					arg_52_1.actors_[var_55_29] = var_55_31

					local var_55_32 = var_55_31:GetComponentInChildren(typeof(CharacterEffect))

					var_55_32.enabled = true

					local var_55_33 = GameObjectTools.GetOrAddComponent(var_55_31, typeof(DynamicBoneHelper))

					if var_55_33 then
						var_55_33:EnableDynamicBone(false)
					end

					arg_52_1:ShowWeapon(var_55_32.transform, false)

					arg_52_1.var_[var_55_29 .. "Animator"] = var_55_32.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_52_1.var_[var_55_29 .. "Animator"].applyRootMotion = true
					arg_52_1.var_[var_55_29 .. "LipSync"] = var_55_32.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_55_34 = arg_52_1.actors_["1084ui_story"]
			local var_55_35 = 0

			if var_55_35 < arg_52_1.time_ and arg_52_1.time_ <= var_55_35 + arg_55_0 and not isNil(var_55_34) and arg_52_1.var_.characterEffect1084ui_story == nil then
				arg_52_1.var_.characterEffect1084ui_story = var_55_34:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_36 = 0.200000002980232

			if var_55_35 <= arg_52_1.time_ and arg_52_1.time_ < var_55_35 + var_55_36 and not isNil(var_55_34) then
				local var_55_37 = (arg_52_1.time_ - var_55_35) / var_55_36

				if arg_52_1.var_.characterEffect1084ui_story and not isNil(var_55_34) then
					arg_52_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_52_1.time_ >= var_55_35 + var_55_36 and arg_52_1.time_ < var_55_35 + var_55_36 + arg_55_0 and not isNil(var_55_34) and arg_52_1.var_.characterEffect1084ui_story then
				arg_52_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_55_38 = 1.2
			local var_55_39 = 1

			if var_55_38 < arg_52_1.time_ and arg_52_1.time_ <= var_55_38 + arg_55_0 then
				local var_55_40 = "play"
				local var_55_41 = "effect"

				arg_52_1:AudioAction(var_55_40, var_55_41, "se_story_142", "se_story_142_amb_commandroom", "")
			end

			local var_55_42 = 0.2
			local var_55_43 = 1

			if var_55_42 < arg_52_1.time_ and arg_52_1.time_ <= var_55_42 + arg_55_0 then
				local var_55_44 = "stop"
				local var_55_45 = "effect"

				arg_52_1:AudioAction(var_55_44, var_55_45, "se_story_145", "se_story_145_amb_drone_haizhen", "")
			end

			local var_55_46 = 1
			local var_55_47 = 1

			if var_55_46 < arg_52_1.time_ and arg_52_1.time_ <= var_55_46 + arg_55_0 then
				local var_55_48 = "play"
				local var_55_49 = "music"

				arg_52_1:AudioAction(var_55_48, var_55_49, "bgm_story_office_new", "bgm_story_office_new", "bgm_story_office_new.awb")

				local var_55_50 = ""
				local var_55_51 = manager.audio:GetAudioName("bgm_story_office_new", "bgm_story_office_new")

				if var_55_51 ~= "" then
					if arg_52_1.bgmTxt_.text ~= var_55_51 and arg_52_1.bgmTxt_.text ~= "" then
						if arg_52_1.bgmTxt2_.text ~= "" then
							arg_52_1.bgmTxt_.text = arg_52_1.bgmTxt2_.text
						end

						arg_52_1.bgmTxt2_.text = var_55_51

						arg_52_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_52_1.bgmTxt_.text = var_55_51
						arg_52_1.bgmTxt2_.text = var_55_51
					end

					if arg_52_1.bgmTimer then
						arg_52_1.bgmTimer:Stop()

						arg_52_1.bgmTimer = nil
					end

					if arg_52_1.settingData.show_music_name == 1 then
						arg_52_1.musicController:SetSelectedState("show")
						arg_52_1.musicAnimator_:Play("open", 0, 0)

						if arg_52_1.settingData.music_time ~= 0 then
							arg_52_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_52_1.settingData.music_time), function()
								if arg_52_1 == nil or isNil(arg_52_1.bgmTxt_) then
									return
								end

								arg_52_1.musicController:SetSelectedState("hide")
								arg_52_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_52_1.frameCnt_ <= 1 then
				arg_52_1.dialog_:SetActive(false)
			end

			local var_55_52 = 2.266666666666
			local var_55_53 = 0.433333333333334

			if var_55_52 < arg_52_1.time_ and arg_52_1.time_ <= var_55_52 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0

				arg_52_1.dialog_:SetActive(true)

				arg_52_1.dialogCg_.alpha = 0

				local var_55_54 = LeanTween.value(arg_52_1.dialog_, 0, 1, 0.3)

				var_55_54:setOnUpdate(LuaHelper.FloatAction(function(arg_57_0)
					arg_52_1.dialogCg_.alpha = arg_57_0
				end))
				var_55_54:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_52_1.dialog_)
					var_55_54:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_52_1.duration_ = arg_52_1.duration_ + 0.3

				SetActive(arg_52_1.leftNameGo_, true)

				local var_55_55 = arg_52_1:FormatText(StoryNameCfg[6].name)

				arg_52_1.leftNameTxt_.text = var_55_55

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, true)
				arg_52_1.iconController_:SetSelectedState("hero")

				arg_52_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_52_1.callingController_:SetSelectedState("normal")

				arg_52_1.keyicon_.color = Color.New(1, 1, 1)
				arg_52_1.icon_.color = Color.New(1, 1, 1)

				local var_55_56 = arg_52_1:GetWordFromCfg(304011013)
				local var_55_57 = arg_52_1:FormatText(var_55_56.content)

				arg_52_1.text_.text = var_55_57

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_58 = 9
				local var_55_59 = utf8.len(var_55_57)
				local var_55_60 = var_55_58 <= 0 and var_55_53 or var_55_53 * (var_55_59 / var_55_58)

				if var_55_60 > 0 and var_55_53 < var_55_60 then
					arg_52_1.talkMaxDuration = var_55_60
					var_55_52 = var_55_52 + 0.3

					if var_55_60 + var_55_52 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_60 + var_55_52
					end
				end

				arg_52_1.text_.text = var_55_57
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304011", "304011013", "story_v_out_304011.awb") ~= 0 then
					local var_55_61 = manager.audio:GetVoiceLength("story_v_out_304011", "304011013", "story_v_out_304011.awb") / 1000

					if var_55_61 + var_55_52 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_61 + var_55_52
					end

					if var_55_56.prefab_name ~= "" and arg_52_1.actors_[var_55_56.prefab_name] ~= nil then
						local var_55_62 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_56.prefab_name].transform, "story_v_out_304011", "304011013", "story_v_out_304011.awb")

						arg_52_1:RecordAudio("304011013", var_55_62)
						arg_52_1:RecordAudio("304011013", var_55_62)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_304011", "304011013", "story_v_out_304011.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_304011", "304011013", "story_v_out_304011.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_63 = var_55_52 + 0.3
			local var_55_64 = math.max(var_55_53, arg_52_1.talkMaxDuration)

			if var_55_63 <= arg_52_1.time_ and arg_52_1.time_ < var_55_63 + var_55_64 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_63) / var_55_64

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_63 + var_55_64 and arg_52_1.time_ < var_55_63 + var_55_64 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play304011014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 304011014
		arg_59_1.duration_ = 5

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"
		end

		function arg_59_1.playNext_(arg_61_0)
			if arg_61_0 == 1 then
				arg_59_0:Play304011015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = arg_59_1.actors_["1084ui_story"]
			local var_62_1 = 0

			if var_62_1 < arg_59_1.time_ and arg_59_1.time_ <= var_62_1 + arg_62_0 and not isNil(var_62_0) and arg_59_1.var_.characterEffect1084ui_story == nil then
				arg_59_1.var_.characterEffect1084ui_story = var_62_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_62_2 = 0.200000002980232

			if var_62_1 <= arg_59_1.time_ and arg_59_1.time_ < var_62_1 + var_62_2 and not isNil(var_62_0) then
				local var_62_3 = (arg_59_1.time_ - var_62_1) / var_62_2

				if arg_59_1.var_.characterEffect1084ui_story and not isNil(var_62_0) then
					local var_62_4 = Mathf.Lerp(0, 0.5, var_62_3)

					arg_59_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_59_1.var_.characterEffect1084ui_story.fillRatio = var_62_4
				end
			end

			if arg_59_1.time_ >= var_62_1 + var_62_2 and arg_59_1.time_ < var_62_1 + var_62_2 + arg_62_0 and not isNil(var_62_0) and arg_59_1.var_.characterEffect1084ui_story then
				local var_62_5 = 0.5

				arg_59_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_59_1.var_.characterEffect1084ui_story.fillRatio = var_62_5
			end

			local var_62_6 = 0
			local var_62_7 = 1.8

			if var_62_6 < arg_59_1.time_ and arg_59_1.time_ <= var_62_6 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, false)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_8 = arg_59_1:GetWordFromCfg(304011014)
				local var_62_9 = arg_59_1:FormatText(var_62_8.content)

				arg_59_1.text_.text = var_62_9

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_10 = 84
				local var_62_11 = utf8.len(var_62_9)
				local var_62_12 = var_62_10 <= 0 and var_62_7 or var_62_7 * (var_62_11 / var_62_10)

				if var_62_12 > 0 and var_62_7 < var_62_12 then
					arg_59_1.talkMaxDuration = var_62_12

					if var_62_12 + var_62_6 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_12 + var_62_6
					end
				end

				arg_59_1.text_.text = var_62_9
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)
				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_13 = math.max(var_62_7, arg_59_1.talkMaxDuration)

			if var_62_6 <= arg_59_1.time_ and arg_59_1.time_ < var_62_6 + var_62_13 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_6) / var_62_13

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_6 + var_62_13 and arg_59_1.time_ < var_62_6 + var_62_13 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {}

		arg_59_1:InitPlayNodeList()
	end,
	Play304011015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 304011015
		arg_63_1.duration_ = 5

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play304011016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = 0
			local var_66_1 = 1.025

			if var_66_0 < arg_63_1.time_ and arg_63_1.time_ <= var_66_0 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, false)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_2 = arg_63_1:GetWordFromCfg(304011015)
				local var_66_3 = arg_63_1:FormatText(var_66_2.content)

				arg_63_1.text_.text = var_66_3

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_4 = 41
				local var_66_5 = utf8.len(var_66_3)
				local var_66_6 = var_66_4 <= 0 and var_66_1 or var_66_1 * (var_66_5 / var_66_4)

				if var_66_6 > 0 and var_66_1 < var_66_6 then
					arg_63_1.talkMaxDuration = var_66_6

					if var_66_6 + var_66_0 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_6 + var_66_0
					end
				end

				arg_63_1.text_.text = var_66_3
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)
				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_7 = math.max(var_66_1, arg_63_1.talkMaxDuration)

			if var_66_0 <= arg_63_1.time_ and arg_63_1.time_ < var_66_0 + var_66_7 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_0) / var_66_7

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_0 + var_66_7 and arg_63_1.time_ < var_66_0 + var_66_7 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {}

		arg_63_1:InitPlayNodeList()
	end,
	Play304011016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 304011016
		arg_67_1.duration_ = 2.23

		local var_67_0 = {
			zh = 2.233,
			ja = 1.999999999999
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
				arg_67_0:Play304011017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = arg_67_1.actors_["1084ui_story"].transform
			local var_70_1 = 0

			if var_70_1 < arg_67_1.time_ and arg_67_1.time_ <= var_70_1 + arg_70_0 then
				arg_67_1.var_.moveOldPos1084ui_story = var_70_0.localPosition
			end

			local var_70_2 = 0.001

			if var_70_1 <= arg_67_1.time_ and arg_67_1.time_ < var_70_1 + var_70_2 then
				local var_70_3 = (arg_67_1.time_ - var_70_1) / var_70_2
				local var_70_4 = Vector3.New(0, -0.97, -6)

				var_70_0.localPosition = Vector3.Lerp(arg_67_1.var_.moveOldPos1084ui_story, var_70_4, var_70_3)

				local var_70_5 = manager.ui.mainCamera.transform.position - var_70_0.position

				var_70_0.forward = Vector3.New(var_70_5.x, var_70_5.y, var_70_5.z)

				local var_70_6 = var_70_0.localEulerAngles

				var_70_6.z = 0
				var_70_6.x = 0
				var_70_0.localEulerAngles = var_70_6
			end

			if arg_67_1.time_ >= var_70_1 + var_70_2 and arg_67_1.time_ < var_70_1 + var_70_2 + arg_70_0 then
				var_70_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_70_7 = manager.ui.mainCamera.transform.position - var_70_0.position

				var_70_0.forward = Vector3.New(var_70_7.x, var_70_7.y, var_70_7.z)

				local var_70_8 = var_70_0.localEulerAngles

				var_70_8.z = 0
				var_70_8.x = 0
				var_70_0.localEulerAngles = var_70_8
			end

			local var_70_9 = arg_67_1.actors_["1084ui_story"]
			local var_70_10 = 0

			if var_70_10 < arg_67_1.time_ and arg_67_1.time_ <= var_70_10 + arg_70_0 and not isNil(var_70_9) and arg_67_1.var_.characterEffect1084ui_story == nil then
				arg_67_1.var_.characterEffect1084ui_story = var_70_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_70_11 = 0.200000002980232

			if var_70_10 <= arg_67_1.time_ and arg_67_1.time_ < var_70_10 + var_70_11 and not isNil(var_70_9) then
				local var_70_12 = (arg_67_1.time_ - var_70_10) / var_70_11

				if arg_67_1.var_.characterEffect1084ui_story and not isNil(var_70_9) then
					arg_67_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_67_1.time_ >= var_70_10 + var_70_11 and arg_67_1.time_ < var_70_10 + var_70_11 + arg_70_0 and not isNil(var_70_9) and arg_67_1.var_.characterEffect1084ui_story then
				arg_67_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_70_13 = 0

			if var_70_13 < arg_67_1.time_ and arg_67_1.time_ <= var_70_13 + arg_70_0 then
				arg_67_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action2_1")
			end

			local var_70_14 = 0

			if var_70_14 < arg_67_1.time_ and arg_67_1.time_ <= var_70_14 + arg_70_0 then
				arg_67_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_70_15 = 0
			local var_70_16 = 0.275

			if var_70_15 < arg_67_1.time_ and arg_67_1.time_ <= var_70_15 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				local var_70_17 = arg_67_1:FormatText(StoryNameCfg[6].name)

				arg_67_1.leftNameTxt_.text = var_70_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_18 = arg_67_1:GetWordFromCfg(304011016)
				local var_70_19 = arg_67_1:FormatText(var_70_18.content)

				arg_67_1.text_.text = var_70_19

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_20 = 11
				local var_70_21 = utf8.len(var_70_19)
				local var_70_22 = var_70_20 <= 0 and var_70_16 or var_70_16 * (var_70_21 / var_70_20)

				if var_70_22 > 0 and var_70_16 < var_70_22 then
					arg_67_1.talkMaxDuration = var_70_22

					if var_70_22 + var_70_15 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_22 + var_70_15
					end
				end

				arg_67_1.text_.text = var_70_19
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304011", "304011016", "story_v_out_304011.awb") ~= 0 then
					local var_70_23 = manager.audio:GetVoiceLength("story_v_out_304011", "304011016", "story_v_out_304011.awb") / 1000

					if var_70_23 + var_70_15 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_23 + var_70_15
					end

					if var_70_18.prefab_name ~= "" and arg_67_1.actors_[var_70_18.prefab_name] ~= nil then
						local var_70_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_18.prefab_name].transform, "story_v_out_304011", "304011016", "story_v_out_304011.awb")

						arg_67_1:RecordAudio("304011016", var_70_24)
						arg_67_1:RecordAudio("304011016", var_70_24)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_304011", "304011016", "story_v_out_304011.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_304011", "304011016", "story_v_out_304011.awb")
				end

				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_25 = math.max(var_70_16, arg_67_1.talkMaxDuration)

			if var_70_15 <= arg_67_1.time_ and arg_67_1.time_ < var_70_15 + var_70_25 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_15) / var_70_25

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_15 + var_70_25 and arg_67_1.time_ < var_70_15 + var_70_25 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_67_1:InitPlayNodeList()
	end,
	Play304011017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 304011017
		arg_71_1.duration_ = 5

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play304011018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = arg_71_1.actors_["1084ui_story"]
			local var_74_1 = 0

			if var_74_1 < arg_71_1.time_ and arg_71_1.time_ <= var_74_1 + arg_74_0 and not isNil(var_74_0) and arg_71_1.var_.characterEffect1084ui_story == nil then
				arg_71_1.var_.characterEffect1084ui_story = var_74_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_2 = 0.200000002980232

			if var_74_1 <= arg_71_1.time_ and arg_71_1.time_ < var_74_1 + var_74_2 and not isNil(var_74_0) then
				local var_74_3 = (arg_71_1.time_ - var_74_1) / var_74_2

				if arg_71_1.var_.characterEffect1084ui_story and not isNil(var_74_0) then
					local var_74_4 = Mathf.Lerp(0, 0.5, var_74_3)

					arg_71_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_71_1.var_.characterEffect1084ui_story.fillRatio = var_74_4
				end
			end

			if arg_71_1.time_ >= var_74_1 + var_74_2 and arg_71_1.time_ < var_74_1 + var_74_2 + arg_74_0 and not isNil(var_74_0) and arg_71_1.var_.characterEffect1084ui_story then
				local var_74_5 = 0.5

				arg_71_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_71_1.var_.characterEffect1084ui_story.fillRatio = var_74_5
			end

			local var_74_6 = 0
			local var_74_7 = 0.475

			if var_74_6 < arg_71_1.time_ and arg_71_1.time_ <= var_74_6 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				local var_74_8 = arg_71_1:FormatText(StoryNameCfg[7].name)

				arg_71_1.leftNameTxt_.text = var_74_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, true)
				arg_71_1.iconController_:SetSelectedState("hero")

				arg_71_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_71_1.callingController_:SetSelectedState("normal")

				arg_71_1.keyicon_.color = Color.New(1, 1, 1)
				arg_71_1.icon_.color = Color.New(1, 1, 1)

				local var_74_9 = arg_71_1:GetWordFromCfg(304011017)
				local var_74_10 = arg_71_1:FormatText(var_74_9.content)

				arg_71_1.text_.text = var_74_10

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_11 = 19
				local var_74_12 = utf8.len(var_74_10)
				local var_74_13 = var_74_11 <= 0 and var_74_7 or var_74_7 * (var_74_12 / var_74_11)

				if var_74_13 > 0 and var_74_7 < var_74_13 then
					arg_71_1.talkMaxDuration = var_74_13

					if var_74_13 + var_74_6 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_13 + var_74_6
					end
				end

				arg_71_1.text_.text = var_74_10
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)
				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_14 = math.max(var_74_7, arg_71_1.talkMaxDuration)

			if var_74_6 <= arg_71_1.time_ and arg_71_1.time_ < var_74_6 + var_74_14 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_6) / var_74_14

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_6 + var_74_14 and arg_71_1.time_ < var_74_6 + var_74_14 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {}

		arg_71_1:InitPlayNodeList()
	end,
	Play304011018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 304011018
		arg_75_1.duration_ = 3.73

		local var_75_0 = {
			zh = 3.733,
			ja = 2.966
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
				arg_75_0:Play304011019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = "1019ui_story"

			if arg_75_1.actors_[var_78_0] == nil then
				local var_78_1 = Asset.Load("Char/" .. "1019ui_story")

				if not isNil(var_78_1) then
					local var_78_2 = Object.Instantiate(Asset.Load("Char/" .. "1019ui_story"), arg_75_1.stage_.transform)

					var_78_2.name = var_78_0
					var_78_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_75_1.actors_[var_78_0] = var_78_2

					local var_78_3 = var_78_2:GetComponentInChildren(typeof(CharacterEffect))

					var_78_3.enabled = true

					local var_78_4 = GameObjectTools.GetOrAddComponent(var_78_2, typeof(DynamicBoneHelper))

					if var_78_4 then
						var_78_4:EnableDynamicBone(false)
					end

					arg_75_1:ShowWeapon(var_78_3.transform, false)

					arg_75_1.var_[var_78_0 .. "Animator"] = var_78_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_75_1.var_[var_78_0 .. "Animator"].applyRootMotion = true
					arg_75_1.var_[var_78_0 .. "LipSync"] = var_78_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_78_5 = arg_75_1.actors_["1019ui_story"].transform
			local var_78_6 = 0

			if var_78_6 < arg_75_1.time_ and arg_75_1.time_ <= var_78_6 + arg_78_0 then
				arg_75_1.var_.moveOldPos1019ui_story = var_78_5.localPosition
			end

			local var_78_7 = 0.001

			if var_78_6 <= arg_75_1.time_ and arg_75_1.time_ < var_78_6 + var_78_7 then
				local var_78_8 = (arg_75_1.time_ - var_78_6) / var_78_7
				local var_78_9 = Vector3.New(-0.2, -1.08, -5.9)

				var_78_5.localPosition = Vector3.Lerp(arg_75_1.var_.moveOldPos1019ui_story, var_78_9, var_78_8)

				local var_78_10 = manager.ui.mainCamera.transform.position - var_78_5.position

				var_78_5.forward = Vector3.New(var_78_10.x, var_78_10.y, var_78_10.z)

				local var_78_11 = var_78_5.localEulerAngles

				var_78_11.z = 0
				var_78_11.x = 0
				var_78_5.localEulerAngles = var_78_11
			end

			if arg_75_1.time_ >= var_78_6 + var_78_7 and arg_75_1.time_ < var_78_6 + var_78_7 + arg_78_0 then
				var_78_5.localPosition = Vector3.New(-0.2, -1.08, -5.9)

				local var_78_12 = manager.ui.mainCamera.transform.position - var_78_5.position

				var_78_5.forward = Vector3.New(var_78_12.x, var_78_12.y, var_78_12.z)

				local var_78_13 = var_78_5.localEulerAngles

				var_78_13.z = 0
				var_78_13.x = 0
				var_78_5.localEulerAngles = var_78_13
			end

			local var_78_14 = arg_75_1.actors_["1084ui_story"].transform
			local var_78_15 = 0

			if var_78_15 < arg_75_1.time_ and arg_75_1.time_ <= var_78_15 + arg_78_0 then
				arg_75_1.var_.moveOldPos1084ui_story = var_78_14.localPosition
			end

			local var_78_16 = 0.001

			if var_78_15 <= arg_75_1.time_ and arg_75_1.time_ < var_78_15 + var_78_16 then
				local var_78_17 = (arg_75_1.time_ - var_78_15) / var_78_16
				local var_78_18 = Vector3.New(0, 100, 0)

				var_78_14.localPosition = Vector3.Lerp(arg_75_1.var_.moveOldPos1084ui_story, var_78_18, var_78_17)

				local var_78_19 = manager.ui.mainCamera.transform.position - var_78_14.position

				var_78_14.forward = Vector3.New(var_78_19.x, var_78_19.y, var_78_19.z)

				local var_78_20 = var_78_14.localEulerAngles

				var_78_20.z = 0
				var_78_20.x = 0
				var_78_14.localEulerAngles = var_78_20
			end

			if arg_75_1.time_ >= var_78_15 + var_78_16 and arg_75_1.time_ < var_78_15 + var_78_16 + arg_78_0 then
				var_78_14.localPosition = Vector3.New(0, 100, 0)

				local var_78_21 = manager.ui.mainCamera.transform.position - var_78_14.position

				var_78_14.forward = Vector3.New(var_78_21.x, var_78_21.y, var_78_21.z)

				local var_78_22 = var_78_14.localEulerAngles

				var_78_22.z = 0
				var_78_22.x = 0
				var_78_14.localEulerAngles = var_78_22
			end

			local var_78_23 = arg_75_1.actors_["1019ui_story"]
			local var_78_24 = 0

			if var_78_24 < arg_75_1.time_ and arg_75_1.time_ <= var_78_24 + arg_78_0 and not isNil(var_78_23) and arg_75_1.var_.characterEffect1019ui_story == nil then
				arg_75_1.var_.characterEffect1019ui_story = var_78_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_78_25 = 0.200000002980232

			if var_78_24 <= arg_75_1.time_ and arg_75_1.time_ < var_78_24 + var_78_25 and not isNil(var_78_23) then
				local var_78_26 = (arg_75_1.time_ - var_78_24) / var_78_25

				if arg_75_1.var_.characterEffect1019ui_story and not isNil(var_78_23) then
					arg_75_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_75_1.time_ >= var_78_24 + var_78_25 and arg_75_1.time_ < var_78_24 + var_78_25 + arg_78_0 and not isNil(var_78_23) and arg_75_1.var_.characterEffect1019ui_story then
				arg_75_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_78_27 = 0

			if var_78_27 < arg_75_1.time_ and arg_75_1.time_ <= var_78_27 + arg_78_0 then
				arg_75_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action5_1")
			end

			local var_78_28 = 0

			if var_78_28 < arg_75_1.time_ and arg_75_1.time_ <= var_78_28 + arg_78_0 then
				arg_75_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_78_29 = 0
			local var_78_30 = 0.65

			if var_78_29 < arg_75_1.time_ and arg_75_1.time_ <= var_78_29 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				local var_78_31 = arg_75_1:FormatText(StoryNameCfg[13].name)

				arg_75_1.leftNameTxt_.text = var_78_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_32 = arg_75_1:GetWordFromCfg(304011018)
				local var_78_33 = arg_75_1:FormatText(var_78_32.content)

				arg_75_1.text_.text = var_78_33

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_34 = 26
				local var_78_35 = utf8.len(var_78_33)
				local var_78_36 = var_78_34 <= 0 and var_78_30 or var_78_30 * (var_78_35 / var_78_34)

				if var_78_36 > 0 and var_78_30 < var_78_36 then
					arg_75_1.talkMaxDuration = var_78_36

					if var_78_36 + var_78_29 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_36 + var_78_29
					end
				end

				arg_75_1.text_.text = var_78_33
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304011", "304011018", "story_v_out_304011.awb") ~= 0 then
					local var_78_37 = manager.audio:GetVoiceLength("story_v_out_304011", "304011018", "story_v_out_304011.awb") / 1000

					if var_78_37 + var_78_29 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_37 + var_78_29
					end

					if var_78_32.prefab_name ~= "" and arg_75_1.actors_[var_78_32.prefab_name] ~= nil then
						local var_78_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_32.prefab_name].transform, "story_v_out_304011", "304011018", "story_v_out_304011.awb")

						arg_75_1:RecordAudio("304011018", var_78_38)
						arg_75_1:RecordAudio("304011018", var_78_38)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_out_304011", "304011018", "story_v_out_304011.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_out_304011", "304011018", "story_v_out_304011.awb")
				end

				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_39 = math.max(var_78_30, arg_75_1.talkMaxDuration)

			if var_78_29 <= arg_75_1.time_ and arg_75_1.time_ < var_78_29 + var_78_39 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_29) / var_78_39

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_29 + var_78_39 and arg_75_1.time_ < var_78_29 + var_78_39 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_75_1:InitPlayNodeList()
	end,
	Play304011019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 304011019
		arg_79_1.duration_ = 5

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play304011020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = arg_79_1.actors_["1019ui_story"]
			local var_82_1 = 0

			if var_82_1 < arg_79_1.time_ and arg_79_1.time_ <= var_82_1 + arg_82_0 and not isNil(var_82_0) and arg_79_1.var_.characterEffect1019ui_story == nil then
				arg_79_1.var_.characterEffect1019ui_story = var_82_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_2 = 0.200000002980232

			if var_82_1 <= arg_79_1.time_ and arg_79_1.time_ < var_82_1 + var_82_2 and not isNil(var_82_0) then
				local var_82_3 = (arg_79_1.time_ - var_82_1) / var_82_2

				if arg_79_1.var_.characterEffect1019ui_story and not isNil(var_82_0) then
					local var_82_4 = Mathf.Lerp(0, 0.5, var_82_3)

					arg_79_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_79_1.var_.characterEffect1019ui_story.fillRatio = var_82_4
				end
			end

			if arg_79_1.time_ >= var_82_1 + var_82_2 and arg_79_1.time_ < var_82_1 + var_82_2 + arg_82_0 and not isNil(var_82_0) and arg_79_1.var_.characterEffect1019ui_story then
				local var_82_5 = 0.5

				arg_79_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_79_1.var_.characterEffect1019ui_story.fillRatio = var_82_5
			end

			local var_82_6 = 0
			local var_82_7 = 0.525

			if var_82_6 < arg_79_1.time_ and arg_79_1.time_ <= var_82_6 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				local var_82_8 = arg_79_1:FormatText(StoryNameCfg[7].name)

				arg_79_1.leftNameTxt_.text = var_82_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, true)
				arg_79_1.iconController_:SetSelectedState("hero")

				arg_79_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_79_1.callingController_:SetSelectedState("normal")

				arg_79_1.keyicon_.color = Color.New(1, 1, 1)
				arg_79_1.icon_.color = Color.New(1, 1, 1)

				local var_82_9 = arg_79_1:GetWordFromCfg(304011019)
				local var_82_10 = arg_79_1:FormatText(var_82_9.content)

				arg_79_1.text_.text = var_82_10

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_11 = 21
				local var_82_12 = utf8.len(var_82_10)
				local var_82_13 = var_82_11 <= 0 and var_82_7 or var_82_7 * (var_82_12 / var_82_11)

				if var_82_13 > 0 and var_82_7 < var_82_13 then
					arg_79_1.talkMaxDuration = var_82_13

					if var_82_13 + var_82_6 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_13 + var_82_6
					end
				end

				arg_79_1.text_.text = var_82_10
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)
				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_14 = math.max(var_82_7, arg_79_1.talkMaxDuration)

			if var_82_6 <= arg_79_1.time_ and arg_79_1.time_ < var_82_6 + var_82_14 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_6) / var_82_14

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_6 + var_82_14 and arg_79_1.time_ < var_82_6 + var_82_14 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play304011020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 304011020
		arg_83_1.duration_ = 8.77

		local var_83_0 = {
			zh = 5.6,
			ja = 8.766
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
				arg_83_0:Play304011021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = arg_83_1.actors_["1019ui_story"]
			local var_86_1 = 0

			if var_86_1 < arg_83_1.time_ and arg_83_1.time_ <= var_86_1 + arg_86_0 and not isNil(var_86_0) and arg_83_1.var_.characterEffect1019ui_story == nil then
				arg_83_1.var_.characterEffect1019ui_story = var_86_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_86_2 = 0.200000002980232

			if var_86_1 <= arg_83_1.time_ and arg_83_1.time_ < var_86_1 + var_86_2 and not isNil(var_86_0) then
				local var_86_3 = (arg_83_1.time_ - var_86_1) / var_86_2

				if arg_83_1.var_.characterEffect1019ui_story and not isNil(var_86_0) then
					arg_83_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_83_1.time_ >= var_86_1 + var_86_2 and arg_83_1.time_ < var_86_1 + var_86_2 + arg_86_0 and not isNil(var_86_0) and arg_83_1.var_.characterEffect1019ui_story then
				arg_83_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_86_4 = 0

			if var_86_4 < arg_83_1.time_ and arg_83_1.time_ <= var_86_4 + arg_86_0 then
				arg_83_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action5_2")
			end

			local var_86_5 = 0
			local var_86_6 = 0.725

			if var_86_5 < arg_83_1.time_ and arg_83_1.time_ <= var_86_5 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				local var_86_7 = arg_83_1:FormatText(StoryNameCfg[13].name)

				arg_83_1.leftNameTxt_.text = var_86_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_8 = arg_83_1:GetWordFromCfg(304011020)
				local var_86_9 = arg_83_1:FormatText(var_86_8.content)

				arg_83_1.text_.text = var_86_9

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_10 = 29
				local var_86_11 = utf8.len(var_86_9)
				local var_86_12 = var_86_10 <= 0 and var_86_6 or var_86_6 * (var_86_11 / var_86_10)

				if var_86_12 > 0 and var_86_6 < var_86_12 then
					arg_83_1.talkMaxDuration = var_86_12

					if var_86_12 + var_86_5 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_12 + var_86_5
					end
				end

				arg_83_1.text_.text = var_86_9
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304011", "304011020", "story_v_out_304011.awb") ~= 0 then
					local var_86_13 = manager.audio:GetVoiceLength("story_v_out_304011", "304011020", "story_v_out_304011.awb") / 1000

					if var_86_13 + var_86_5 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_13 + var_86_5
					end

					if var_86_8.prefab_name ~= "" and arg_83_1.actors_[var_86_8.prefab_name] ~= nil then
						local var_86_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_8.prefab_name].transform, "story_v_out_304011", "304011020", "story_v_out_304011.awb")

						arg_83_1:RecordAudio("304011020", var_86_14)
						arg_83_1:RecordAudio("304011020", var_86_14)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_out_304011", "304011020", "story_v_out_304011.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_out_304011", "304011020", "story_v_out_304011.awb")
				end

				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_15 = math.max(var_86_6, arg_83_1.talkMaxDuration)

			if var_86_5 <= arg_83_1.time_ and arg_83_1.time_ < var_86_5 + var_86_15 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_5) / var_86_15

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_5 + var_86_15 and arg_83_1.time_ < var_86_5 + var_86_15 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play304011021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 304011021
		arg_87_1.duration_ = 5

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play304011022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = arg_87_1.actors_["1019ui_story"]
			local var_90_1 = 0

			if var_90_1 < arg_87_1.time_ and arg_87_1.time_ <= var_90_1 + arg_90_0 and not isNil(var_90_0) and arg_87_1.var_.characterEffect1019ui_story == nil then
				arg_87_1.var_.characterEffect1019ui_story = var_90_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_90_2 = 0.200000002980232

			if var_90_1 <= arg_87_1.time_ and arg_87_1.time_ < var_90_1 + var_90_2 and not isNil(var_90_0) then
				local var_90_3 = (arg_87_1.time_ - var_90_1) / var_90_2

				if arg_87_1.var_.characterEffect1019ui_story and not isNil(var_90_0) then
					local var_90_4 = Mathf.Lerp(0, 0.5, var_90_3)

					arg_87_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_87_1.var_.characterEffect1019ui_story.fillRatio = var_90_4
				end
			end

			if arg_87_1.time_ >= var_90_1 + var_90_2 and arg_87_1.time_ < var_90_1 + var_90_2 + arg_90_0 and not isNil(var_90_0) and arg_87_1.var_.characterEffect1019ui_story then
				local var_90_5 = 0.5

				arg_87_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_87_1.var_.characterEffect1019ui_story.fillRatio = var_90_5
			end

			local var_90_6 = 0
			local var_90_7 = 0.4

			if var_90_6 < arg_87_1.time_ and arg_87_1.time_ <= var_90_6 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				local var_90_8 = arg_87_1:FormatText(StoryNameCfg[7].name)

				arg_87_1.leftNameTxt_.text = var_90_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, true)
				arg_87_1.iconController_:SetSelectedState("hero")

				arg_87_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_87_1.callingController_:SetSelectedState("normal")

				arg_87_1.keyicon_.color = Color.New(1, 1, 1)
				arg_87_1.icon_.color = Color.New(1, 1, 1)

				local var_90_9 = arg_87_1:GetWordFromCfg(304011021)
				local var_90_10 = arg_87_1:FormatText(var_90_9.content)

				arg_87_1.text_.text = var_90_10

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_11 = 16
				local var_90_12 = utf8.len(var_90_10)
				local var_90_13 = var_90_11 <= 0 and var_90_7 or var_90_7 * (var_90_12 / var_90_11)

				if var_90_13 > 0 and var_90_7 < var_90_13 then
					arg_87_1.talkMaxDuration = var_90_13

					if var_90_13 + var_90_6 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_13 + var_90_6
					end
				end

				arg_87_1.text_.text = var_90_10
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)
				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_14 = math.max(var_90_7, arg_87_1.talkMaxDuration)

			if var_90_6 <= arg_87_1.time_ and arg_87_1.time_ < var_90_6 + var_90_14 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_6) / var_90_14

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_6 + var_90_14 and arg_87_1.time_ < var_90_6 + var_90_14 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {}

		arg_87_1:InitPlayNodeList()
	end,
	Play304011022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 304011022
		arg_91_1.duration_ = 9.17

		local var_91_0 = {
			zh = 4.6,
			ja = 9.166
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
				arg_91_0:Play304011023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			local var_94_0 = arg_91_1.actors_["1019ui_story"]
			local var_94_1 = 0

			if var_94_1 < arg_91_1.time_ and arg_91_1.time_ <= var_94_1 + arg_94_0 and not isNil(var_94_0) and arg_91_1.var_.characterEffect1019ui_story == nil then
				arg_91_1.var_.characterEffect1019ui_story = var_94_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_94_2 = 0.200000002980232

			if var_94_1 <= arg_91_1.time_ and arg_91_1.time_ < var_94_1 + var_94_2 and not isNil(var_94_0) then
				local var_94_3 = (arg_91_1.time_ - var_94_1) / var_94_2

				if arg_91_1.var_.characterEffect1019ui_story and not isNil(var_94_0) then
					arg_91_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_91_1.time_ >= var_94_1 + var_94_2 and arg_91_1.time_ < var_94_1 + var_94_2 + arg_94_0 and not isNil(var_94_0) and arg_91_1.var_.characterEffect1019ui_story then
				arg_91_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_94_4 = 0
			local var_94_5 = 0.45

			if var_94_4 < arg_91_1.time_ and arg_91_1.time_ <= var_94_4 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				local var_94_6 = arg_91_1:FormatText(StoryNameCfg[13].name)

				arg_91_1.leftNameTxt_.text = var_94_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_7 = arg_91_1:GetWordFromCfg(304011022)
				local var_94_8 = arg_91_1:FormatText(var_94_7.content)

				arg_91_1.text_.text = var_94_8

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_9 = 18
				local var_94_10 = utf8.len(var_94_8)
				local var_94_11 = var_94_9 <= 0 and var_94_5 or var_94_5 * (var_94_10 / var_94_9)

				if var_94_11 > 0 and var_94_5 < var_94_11 then
					arg_91_1.talkMaxDuration = var_94_11

					if var_94_11 + var_94_4 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_11 + var_94_4
					end
				end

				arg_91_1.text_.text = var_94_8
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304011", "304011022", "story_v_out_304011.awb") ~= 0 then
					local var_94_12 = manager.audio:GetVoiceLength("story_v_out_304011", "304011022", "story_v_out_304011.awb") / 1000

					if var_94_12 + var_94_4 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_12 + var_94_4
					end

					if var_94_7.prefab_name ~= "" and arg_91_1.actors_[var_94_7.prefab_name] ~= nil then
						local var_94_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_91_1.actors_[var_94_7.prefab_name].transform, "story_v_out_304011", "304011022", "story_v_out_304011.awb")

						arg_91_1:RecordAudio("304011022", var_94_13)
						arg_91_1:RecordAudio("304011022", var_94_13)
					else
						arg_91_1:AudioAction("play", "voice", "story_v_out_304011", "304011022", "story_v_out_304011.awb")
					end

					arg_91_1:RecordHistoryTalkVoice("story_v_out_304011", "304011022", "story_v_out_304011.awb")
				end

				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_14 = math.max(var_94_5, arg_91_1.talkMaxDuration)

			if var_94_4 <= arg_91_1.time_ and arg_91_1.time_ < var_94_4 + var_94_14 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_4) / var_94_14

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_4 + var_94_14 and arg_91_1.time_ < var_94_4 + var_94_14 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {}

		arg_91_1:InitPlayNodeList()
	end,
	Play304011023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 304011023
		arg_95_1.duration_ = 5

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play304011024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			local var_98_0 = arg_95_1.actors_["1019ui_story"]
			local var_98_1 = 0

			if var_98_1 < arg_95_1.time_ and arg_95_1.time_ <= var_98_1 + arg_98_0 and not isNil(var_98_0) and arg_95_1.var_.characterEffect1019ui_story == nil then
				arg_95_1.var_.characterEffect1019ui_story = var_98_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_98_2 = 0.200000002980232

			if var_98_1 <= arg_95_1.time_ and arg_95_1.time_ < var_98_1 + var_98_2 and not isNil(var_98_0) then
				local var_98_3 = (arg_95_1.time_ - var_98_1) / var_98_2

				if arg_95_1.var_.characterEffect1019ui_story and not isNil(var_98_0) then
					local var_98_4 = Mathf.Lerp(0, 0.5, var_98_3)

					arg_95_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_95_1.var_.characterEffect1019ui_story.fillRatio = var_98_4
				end
			end

			if arg_95_1.time_ >= var_98_1 + var_98_2 and arg_95_1.time_ < var_98_1 + var_98_2 + arg_98_0 and not isNil(var_98_0) and arg_95_1.var_.characterEffect1019ui_story then
				local var_98_5 = 0.5

				arg_95_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_95_1.var_.characterEffect1019ui_story.fillRatio = var_98_5
			end

			local var_98_6 = 0
			local var_98_7 = 0.975

			if var_98_6 < arg_95_1.time_ and arg_95_1.time_ <= var_98_6 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				local var_98_8 = arg_95_1:FormatText(StoryNameCfg[7].name)

				arg_95_1.leftNameTxt_.text = var_98_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, true)
				arg_95_1.iconController_:SetSelectedState("hero")

				arg_95_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_95_1.callingController_:SetSelectedState("normal")

				arg_95_1.keyicon_.color = Color.New(1, 1, 1)
				arg_95_1.icon_.color = Color.New(1, 1, 1)

				local var_98_9 = arg_95_1:GetWordFromCfg(304011023)
				local var_98_10 = arg_95_1:FormatText(var_98_9.content)

				arg_95_1.text_.text = var_98_10

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_11 = 39
				local var_98_12 = utf8.len(var_98_10)
				local var_98_13 = var_98_11 <= 0 and var_98_7 or var_98_7 * (var_98_12 / var_98_11)

				if var_98_13 > 0 and var_98_7 < var_98_13 then
					arg_95_1.talkMaxDuration = var_98_13

					if var_98_13 + var_98_6 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_13 + var_98_6
					end
				end

				arg_95_1.text_.text = var_98_10
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)
				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_14 = math.max(var_98_7, arg_95_1.talkMaxDuration)

			if var_98_6 <= arg_95_1.time_ and arg_95_1.time_ < var_98_6 + var_98_14 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_6) / var_98_14

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_6 + var_98_14 and arg_95_1.time_ < var_98_6 + var_98_14 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {}

		arg_95_1:InitPlayNodeList()
	end,
	Play304011024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 304011024
		arg_99_1.duration_ = 12.27

		local var_99_0 = {
			zh = 10.466,
			ja = 12.266
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
				arg_99_0:Play304011025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = arg_99_1.actors_["1019ui_story"]
			local var_102_1 = 0

			if var_102_1 < arg_99_1.time_ and arg_99_1.time_ <= var_102_1 + arg_102_0 and not isNil(var_102_0) and arg_99_1.var_.characterEffect1019ui_story == nil then
				arg_99_1.var_.characterEffect1019ui_story = var_102_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_102_2 = 0.200000002980232

			if var_102_1 <= arg_99_1.time_ and arg_99_1.time_ < var_102_1 + var_102_2 and not isNil(var_102_0) then
				local var_102_3 = (arg_99_1.time_ - var_102_1) / var_102_2

				if arg_99_1.var_.characterEffect1019ui_story and not isNil(var_102_0) then
					arg_99_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_99_1.time_ >= var_102_1 + var_102_2 and arg_99_1.time_ < var_102_1 + var_102_2 + arg_102_0 and not isNil(var_102_0) and arg_99_1.var_.characterEffect1019ui_story then
				arg_99_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_102_4 = 0

			if var_102_4 < arg_99_1.time_ and arg_99_1.time_ <= var_102_4 + arg_102_0 then
				arg_99_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action2_1")
			end

			local var_102_5 = 0

			if var_102_5 < arg_99_1.time_ and arg_99_1.time_ <= var_102_5 + arg_102_0 then
				arg_99_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_102_6 = 0
			local var_102_7 = 1.025

			if var_102_6 < arg_99_1.time_ and arg_99_1.time_ <= var_102_6 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				local var_102_8 = arg_99_1:FormatText(StoryNameCfg[13].name)

				arg_99_1.leftNameTxt_.text = var_102_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_9 = arg_99_1:GetWordFromCfg(304011024)
				local var_102_10 = arg_99_1:FormatText(var_102_9.content)

				arg_99_1.text_.text = var_102_10

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_11 = 41
				local var_102_12 = utf8.len(var_102_10)
				local var_102_13 = var_102_11 <= 0 and var_102_7 or var_102_7 * (var_102_12 / var_102_11)

				if var_102_13 > 0 and var_102_7 < var_102_13 then
					arg_99_1.talkMaxDuration = var_102_13

					if var_102_13 + var_102_6 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_13 + var_102_6
					end
				end

				arg_99_1.text_.text = var_102_10
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304011", "304011024", "story_v_out_304011.awb") ~= 0 then
					local var_102_14 = manager.audio:GetVoiceLength("story_v_out_304011", "304011024", "story_v_out_304011.awb") / 1000

					if var_102_14 + var_102_6 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_14 + var_102_6
					end

					if var_102_9.prefab_name ~= "" and arg_99_1.actors_[var_102_9.prefab_name] ~= nil then
						local var_102_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_99_1.actors_[var_102_9.prefab_name].transform, "story_v_out_304011", "304011024", "story_v_out_304011.awb")

						arg_99_1:RecordAudio("304011024", var_102_15)
						arg_99_1:RecordAudio("304011024", var_102_15)
					else
						arg_99_1:AudioAction("play", "voice", "story_v_out_304011", "304011024", "story_v_out_304011.awb")
					end

					arg_99_1:RecordHistoryTalkVoice("story_v_out_304011", "304011024", "story_v_out_304011.awb")
				end

				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_16 = math.max(var_102_7, arg_99_1.talkMaxDuration)

			if var_102_6 <= arg_99_1.time_ and arg_99_1.time_ < var_102_6 + var_102_16 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_6) / var_102_16

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_6 + var_102_16 and arg_99_1.time_ < var_102_6 + var_102_16 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {}

		arg_99_1:InitPlayNodeList()
	end,
	Play304011025 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 304011025
		arg_103_1.duration_ = 5.03

		local var_103_0 = {
			zh = 3.266,
			ja = 5.033
		}
		local var_103_1 = manager.audio:GetLocalizationFlag()

		if var_103_0[var_103_1] ~= nil then
			arg_103_1.duration_ = var_103_0[var_103_1]
		end

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play304011026(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			local var_106_0 = 0
			local var_106_1 = 0.4

			if var_106_0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_0 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				local var_106_2 = arg_103_1:FormatText(StoryNameCfg[13].name)

				arg_103_1.leftNameTxt_.text = var_106_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_3 = arg_103_1:GetWordFromCfg(304011025)
				local var_106_4 = arg_103_1:FormatText(var_106_3.content)

				arg_103_1.text_.text = var_106_4

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_5 = 16
				local var_106_6 = utf8.len(var_106_4)
				local var_106_7 = var_106_5 <= 0 and var_106_1 or var_106_1 * (var_106_6 / var_106_5)

				if var_106_7 > 0 and var_106_1 < var_106_7 then
					arg_103_1.talkMaxDuration = var_106_7

					if var_106_7 + var_106_0 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_7 + var_106_0
					end
				end

				arg_103_1.text_.text = var_106_4
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304011", "304011025", "story_v_out_304011.awb") ~= 0 then
					local var_106_8 = manager.audio:GetVoiceLength("story_v_out_304011", "304011025", "story_v_out_304011.awb") / 1000

					if var_106_8 + var_106_0 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_8 + var_106_0
					end

					if var_106_3.prefab_name ~= "" and arg_103_1.actors_[var_106_3.prefab_name] ~= nil then
						local var_106_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_3.prefab_name].transform, "story_v_out_304011", "304011025", "story_v_out_304011.awb")

						arg_103_1:RecordAudio("304011025", var_106_9)
						arg_103_1:RecordAudio("304011025", var_106_9)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_out_304011", "304011025", "story_v_out_304011.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_out_304011", "304011025", "story_v_out_304011.awb")
				end

				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_10 = math.max(var_106_1, arg_103_1.talkMaxDuration)

			if var_106_0 <= arg_103_1.time_ and arg_103_1.time_ < var_106_0 + var_106_10 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_0) / var_106_10

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_0 + var_106_10 and arg_103_1.time_ < var_106_0 + var_106_10 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {}

		arg_103_1:InitPlayNodeList()
	end,
	Play304011026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 304011026
		arg_107_1.duration_ = 5

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play304011027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			local var_110_0 = arg_107_1.actors_["1019ui_story"]
			local var_110_1 = 0

			if var_110_1 < arg_107_1.time_ and arg_107_1.time_ <= var_110_1 + arg_110_0 and not isNil(var_110_0) and arg_107_1.var_.characterEffect1019ui_story == nil then
				arg_107_1.var_.characterEffect1019ui_story = var_110_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_110_2 = 0.200000002980232

			if var_110_1 <= arg_107_1.time_ and arg_107_1.time_ < var_110_1 + var_110_2 and not isNil(var_110_0) then
				local var_110_3 = (arg_107_1.time_ - var_110_1) / var_110_2

				if arg_107_1.var_.characterEffect1019ui_story and not isNil(var_110_0) then
					local var_110_4 = Mathf.Lerp(0, 0.5, var_110_3)

					arg_107_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_107_1.var_.characterEffect1019ui_story.fillRatio = var_110_4
				end
			end

			if arg_107_1.time_ >= var_110_1 + var_110_2 and arg_107_1.time_ < var_110_1 + var_110_2 + arg_110_0 and not isNil(var_110_0) and arg_107_1.var_.characterEffect1019ui_story then
				local var_110_5 = 0.5

				arg_107_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_107_1.var_.characterEffect1019ui_story.fillRatio = var_110_5
			end

			local var_110_6 = 0
			local var_110_7 = 0.45

			if var_110_6 < arg_107_1.time_ and arg_107_1.time_ <= var_110_6 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				local var_110_8 = arg_107_1:FormatText(StoryNameCfg[7].name)

				arg_107_1.leftNameTxt_.text = var_110_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, true)
				arg_107_1.iconController_:SetSelectedState("hero")

				arg_107_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_107_1.callingController_:SetSelectedState("normal")

				arg_107_1.keyicon_.color = Color.New(1, 1, 1)
				arg_107_1.icon_.color = Color.New(1, 1, 1)

				local var_110_9 = arg_107_1:GetWordFromCfg(304011026)
				local var_110_10 = arg_107_1:FormatText(var_110_9.content)

				arg_107_1.text_.text = var_110_10

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_11 = 18
				local var_110_12 = utf8.len(var_110_10)
				local var_110_13 = var_110_11 <= 0 and var_110_7 or var_110_7 * (var_110_12 / var_110_11)

				if var_110_13 > 0 and var_110_7 < var_110_13 then
					arg_107_1.talkMaxDuration = var_110_13

					if var_110_13 + var_110_6 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_13 + var_110_6
					end
				end

				arg_107_1.text_.text = var_110_10
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)
				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_14 = math.max(var_110_7, arg_107_1.talkMaxDuration)

			if var_110_6 <= arg_107_1.time_ and arg_107_1.time_ < var_110_6 + var_110_14 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_6) / var_110_14

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_6 + var_110_14 and arg_107_1.time_ < var_110_6 + var_110_14 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {}

		arg_107_1:InitPlayNodeList()
	end,
	Play304011027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 304011027
		arg_111_1.duration_ = 6.9

		local var_111_0 = {
			zh = 4.666,
			ja = 6.9
		}
		local var_111_1 = manager.audio:GetLocalizationFlag()

		if var_111_0[var_111_1] ~= nil then
			arg_111_1.duration_ = var_111_0[var_111_1]
		end

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play304011028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = arg_111_1.actors_["1019ui_story"]
			local var_114_1 = 0

			if var_114_1 < arg_111_1.time_ and arg_111_1.time_ <= var_114_1 + arg_114_0 and not isNil(var_114_0) and arg_111_1.var_.characterEffect1019ui_story == nil then
				arg_111_1.var_.characterEffect1019ui_story = var_114_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_114_2 = 0.200000002980232

			if var_114_1 <= arg_111_1.time_ and arg_111_1.time_ < var_114_1 + var_114_2 and not isNil(var_114_0) then
				local var_114_3 = (arg_111_1.time_ - var_114_1) / var_114_2

				if arg_111_1.var_.characterEffect1019ui_story and not isNil(var_114_0) then
					arg_111_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_111_1.time_ >= var_114_1 + var_114_2 and arg_111_1.time_ < var_114_1 + var_114_2 + arg_114_0 and not isNil(var_114_0) and arg_111_1.var_.characterEffect1019ui_story then
				arg_111_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_114_4 = 0

			if var_114_4 < arg_111_1.time_ and arg_111_1.time_ <= var_114_4 + arg_114_0 then
				arg_111_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action426")
			end

			local var_114_5 = 0

			if var_114_5 < arg_111_1.time_ and arg_111_1.time_ <= var_114_5 + arg_114_0 then
				arg_111_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_114_6 = 0
			local var_114_7 = 0.55

			if var_114_6 < arg_111_1.time_ and arg_111_1.time_ <= var_114_6 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				local var_114_8 = arg_111_1:FormatText(StoryNameCfg[13].name)

				arg_111_1.leftNameTxt_.text = var_114_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_9 = arg_111_1:GetWordFromCfg(304011027)
				local var_114_10 = arg_111_1:FormatText(var_114_9.content)

				arg_111_1.text_.text = var_114_10

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_11 = 22
				local var_114_12 = utf8.len(var_114_10)
				local var_114_13 = var_114_11 <= 0 and var_114_7 or var_114_7 * (var_114_12 / var_114_11)

				if var_114_13 > 0 and var_114_7 < var_114_13 then
					arg_111_1.talkMaxDuration = var_114_13

					if var_114_13 + var_114_6 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_13 + var_114_6
					end
				end

				arg_111_1.text_.text = var_114_10
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304011", "304011027", "story_v_out_304011.awb") ~= 0 then
					local var_114_14 = manager.audio:GetVoiceLength("story_v_out_304011", "304011027", "story_v_out_304011.awb") / 1000

					if var_114_14 + var_114_6 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_14 + var_114_6
					end

					if var_114_9.prefab_name ~= "" and arg_111_1.actors_[var_114_9.prefab_name] ~= nil then
						local var_114_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_9.prefab_name].transform, "story_v_out_304011", "304011027", "story_v_out_304011.awb")

						arg_111_1:RecordAudio("304011027", var_114_15)
						arg_111_1:RecordAudio("304011027", var_114_15)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_304011", "304011027", "story_v_out_304011.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_304011", "304011027", "story_v_out_304011.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_16 = math.max(var_114_7, arg_111_1.talkMaxDuration)

			if var_114_6 <= arg_111_1.time_ and arg_111_1.time_ < var_114_6 + var_114_16 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_6) / var_114_16

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_6 + var_114_16 and arg_111_1.time_ < var_114_6 + var_114_16 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play304011028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 304011028
		arg_115_1.duration_ = 5

		SetActive(arg_115_1.tipsGo_, false)

		function arg_115_1.onSingleLineFinish_()
			arg_115_1.onSingleLineUpdate_ = nil
			arg_115_1.onSingleLineFinish_ = nil
			arg_115_1.state_ = "waiting"
		end

		function arg_115_1.playNext_(arg_117_0)
			if arg_117_0 == 1 then
				arg_115_0:Play304011029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = arg_115_1.actors_["1019ui_story"]
			local var_118_1 = 0

			if var_118_1 < arg_115_1.time_ and arg_115_1.time_ <= var_118_1 + arg_118_0 and not isNil(var_118_0) and arg_115_1.var_.characterEffect1019ui_story == nil then
				arg_115_1.var_.characterEffect1019ui_story = var_118_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_2 = 0.200000002980232

			if var_118_1 <= arg_115_1.time_ and arg_115_1.time_ < var_118_1 + var_118_2 and not isNil(var_118_0) then
				local var_118_3 = (arg_115_1.time_ - var_118_1) / var_118_2

				if arg_115_1.var_.characterEffect1019ui_story and not isNil(var_118_0) then
					local var_118_4 = Mathf.Lerp(0, 0.5, var_118_3)

					arg_115_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_115_1.var_.characterEffect1019ui_story.fillRatio = var_118_4
				end
			end

			if arg_115_1.time_ >= var_118_1 + var_118_2 and arg_115_1.time_ < var_118_1 + var_118_2 + arg_118_0 and not isNil(var_118_0) and arg_115_1.var_.characterEffect1019ui_story then
				local var_118_5 = 0.5

				arg_115_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_115_1.var_.characterEffect1019ui_story.fillRatio = var_118_5
			end

			local var_118_6 = 0
			local var_118_7 = 0.225

			if var_118_6 < arg_115_1.time_ and arg_115_1.time_ <= var_118_6 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				local var_118_8 = arg_115_1:FormatText(StoryNameCfg[7].name)

				arg_115_1.leftNameTxt_.text = var_118_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, true)
				arg_115_1.iconController_:SetSelectedState("hero")

				arg_115_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_115_1.callingController_:SetSelectedState("normal")

				arg_115_1.keyicon_.color = Color.New(1, 1, 1)
				arg_115_1.icon_.color = Color.New(1, 1, 1)

				local var_118_9 = arg_115_1:GetWordFromCfg(304011028)
				local var_118_10 = arg_115_1:FormatText(var_118_9.content)

				arg_115_1.text_.text = var_118_10

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_11 = 9
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
				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_14 = math.max(var_118_7, arg_115_1.talkMaxDuration)

			if var_118_6 <= arg_115_1.time_ and arg_115_1.time_ < var_118_6 + var_118_14 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_6) / var_118_14

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_6 + var_118_14 and arg_115_1.time_ < var_118_6 + var_118_14 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {}

		arg_115_1:InitPlayNodeList()
	end,
	Play304011029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 304011029
		arg_119_1.duration_ = 5

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play304011030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = 0
			local var_122_1 = 0.6

			if var_122_0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_0 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				local var_122_2 = arg_119_1:FormatText(StoryNameCfg[7].name)

				arg_119_1.leftNameTxt_.text = var_122_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, true)
				arg_119_1.iconController_:SetSelectedState("hero")

				arg_119_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_119_1.callingController_:SetSelectedState("normal")

				arg_119_1.keyicon_.color = Color.New(1, 1, 1)
				arg_119_1.icon_.color = Color.New(1, 1, 1)

				local var_122_3 = arg_119_1:GetWordFromCfg(304011029)
				local var_122_4 = arg_119_1:FormatText(var_122_3.content)

				arg_119_1.text_.text = var_122_4

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_5 = 24
				local var_122_6 = utf8.len(var_122_4)
				local var_122_7 = var_122_5 <= 0 and var_122_1 or var_122_1 * (var_122_6 / var_122_5)

				if var_122_7 > 0 and var_122_1 < var_122_7 then
					arg_119_1.talkMaxDuration = var_122_7

					if var_122_7 + var_122_0 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_7 + var_122_0
					end
				end

				arg_119_1.text_.text = var_122_4
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)
				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_8 = math.max(var_122_1, arg_119_1.talkMaxDuration)

			if var_122_0 <= arg_119_1.time_ and arg_119_1.time_ < var_122_0 + var_122_8 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_0) / var_122_8

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_0 + var_122_8 and arg_119_1.time_ < var_122_0 + var_122_8 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {}

		arg_119_1:InitPlayNodeList()
	end,
	Play304011030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 304011030
		arg_123_1.duration_ = 5.23

		local var_123_0 = {
			zh = 5.233,
			ja = 3.8
		}
		local var_123_1 = manager.audio:GetLocalizationFlag()

		if var_123_0[var_123_1] ~= nil then
			arg_123_1.duration_ = var_123_0[var_123_1]
		end

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play304011031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = arg_123_1.actors_["1019ui_story"]
			local var_126_1 = 0

			if var_126_1 < arg_123_1.time_ and arg_123_1.time_ <= var_126_1 + arg_126_0 and not isNil(var_126_0) and arg_123_1.var_.characterEffect1019ui_story == nil then
				arg_123_1.var_.characterEffect1019ui_story = var_126_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_2 = 0.200000002980232

			if var_126_1 <= arg_123_1.time_ and arg_123_1.time_ < var_126_1 + var_126_2 and not isNil(var_126_0) then
				local var_126_3 = (arg_123_1.time_ - var_126_1) / var_126_2

				if arg_123_1.var_.characterEffect1019ui_story and not isNil(var_126_0) then
					arg_123_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_123_1.time_ >= var_126_1 + var_126_2 and arg_123_1.time_ < var_126_1 + var_126_2 + arg_126_0 and not isNil(var_126_0) and arg_123_1.var_.characterEffect1019ui_story then
				arg_123_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_126_4 = 0

			if var_126_4 < arg_123_1.time_ and arg_123_1.time_ <= var_126_4 + arg_126_0 then
				arg_123_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action6_2")
			end

			local var_126_5 = 0

			if var_126_5 < arg_123_1.time_ and arg_123_1.time_ <= var_126_5 + arg_126_0 then
				arg_123_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_126_6 = 0
			local var_126_7 = 0.6

			if var_126_6 < arg_123_1.time_ and arg_123_1.time_ <= var_126_6 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				local var_126_8 = arg_123_1:FormatText(StoryNameCfg[13].name)

				arg_123_1.leftNameTxt_.text = var_126_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_9 = arg_123_1:GetWordFromCfg(304011030)
				local var_126_10 = arg_123_1:FormatText(var_126_9.content)

				arg_123_1.text_.text = var_126_10

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_11 = 24
				local var_126_12 = utf8.len(var_126_10)
				local var_126_13 = var_126_11 <= 0 and var_126_7 or var_126_7 * (var_126_12 / var_126_11)

				if var_126_13 > 0 and var_126_7 < var_126_13 then
					arg_123_1.talkMaxDuration = var_126_13

					if var_126_13 + var_126_6 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_13 + var_126_6
					end
				end

				arg_123_1.text_.text = var_126_10
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304011", "304011030", "story_v_out_304011.awb") ~= 0 then
					local var_126_14 = manager.audio:GetVoiceLength("story_v_out_304011", "304011030", "story_v_out_304011.awb") / 1000

					if var_126_14 + var_126_6 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_14 + var_126_6
					end

					if var_126_9.prefab_name ~= "" and arg_123_1.actors_[var_126_9.prefab_name] ~= nil then
						local var_126_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_9.prefab_name].transform, "story_v_out_304011", "304011030", "story_v_out_304011.awb")

						arg_123_1:RecordAudio("304011030", var_126_15)
						arg_123_1:RecordAudio("304011030", var_126_15)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_304011", "304011030", "story_v_out_304011.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_304011", "304011030", "story_v_out_304011.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_16 = math.max(var_126_7, arg_123_1.talkMaxDuration)

			if var_126_6 <= arg_123_1.time_ and arg_123_1.time_ < var_126_6 + var_126_16 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_6) / var_126_16

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_6 + var_126_16 and arg_123_1.time_ < var_126_6 + var_126_16 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play304011031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 304011031
		arg_127_1.duration_ = 8.9

		local var_127_0 = {
			zh = 5.533,
			ja = 8.9
		}
		local var_127_1 = manager.audio:GetLocalizationFlag()

		if var_127_0[var_127_1] ~= nil then
			arg_127_1.duration_ = var_127_0[var_127_1]
		end

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play304011032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = 0
			local var_130_1 = 0.775

			if var_130_0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_0 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				local var_130_2 = arg_127_1:FormatText(StoryNameCfg[13].name)

				arg_127_1.leftNameTxt_.text = var_130_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_3 = arg_127_1:GetWordFromCfg(304011031)
				local var_130_4 = arg_127_1:FormatText(var_130_3.content)

				arg_127_1.text_.text = var_130_4

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_5 = 31
				local var_130_6 = utf8.len(var_130_4)
				local var_130_7 = var_130_5 <= 0 and var_130_1 or var_130_1 * (var_130_6 / var_130_5)

				if var_130_7 > 0 and var_130_1 < var_130_7 then
					arg_127_1.talkMaxDuration = var_130_7

					if var_130_7 + var_130_0 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_7 + var_130_0
					end
				end

				arg_127_1.text_.text = var_130_4
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304011", "304011031", "story_v_out_304011.awb") ~= 0 then
					local var_130_8 = manager.audio:GetVoiceLength("story_v_out_304011", "304011031", "story_v_out_304011.awb") / 1000

					if var_130_8 + var_130_0 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_8 + var_130_0
					end

					if var_130_3.prefab_name ~= "" and arg_127_1.actors_[var_130_3.prefab_name] ~= nil then
						local var_130_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_3.prefab_name].transform, "story_v_out_304011", "304011031", "story_v_out_304011.awb")

						arg_127_1:RecordAudio("304011031", var_130_9)
						arg_127_1:RecordAudio("304011031", var_130_9)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_304011", "304011031", "story_v_out_304011.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_304011", "304011031", "story_v_out_304011.awb")
				end

				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_10 = math.max(var_130_1, arg_127_1.talkMaxDuration)

			if var_130_0 <= arg_127_1.time_ and arg_127_1.time_ < var_130_0 + var_130_10 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_0) / var_130_10

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_0 + var_130_10 and arg_127_1.time_ < var_130_0 + var_130_10 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play304011032 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 304011032
		arg_131_1.duration_ = 5

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play304011033(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = arg_131_1.actors_["1019ui_story"].transform
			local var_134_1 = 0

			if var_134_1 < arg_131_1.time_ and arg_131_1.time_ <= var_134_1 + arg_134_0 then
				arg_131_1.var_.moveOldPos1019ui_story = var_134_0.localPosition
			end

			local var_134_2 = 0.001

			if var_134_1 <= arg_131_1.time_ and arg_131_1.time_ < var_134_1 + var_134_2 then
				local var_134_3 = (arg_131_1.time_ - var_134_1) / var_134_2
				local var_134_4 = Vector3.New(0, 100, 0)

				var_134_0.localPosition = Vector3.Lerp(arg_131_1.var_.moveOldPos1019ui_story, var_134_4, var_134_3)

				local var_134_5 = manager.ui.mainCamera.transform.position - var_134_0.position

				var_134_0.forward = Vector3.New(var_134_5.x, var_134_5.y, var_134_5.z)

				local var_134_6 = var_134_0.localEulerAngles

				var_134_6.z = 0
				var_134_6.x = 0
				var_134_0.localEulerAngles = var_134_6
			end

			if arg_131_1.time_ >= var_134_1 + var_134_2 and arg_131_1.time_ < var_134_1 + var_134_2 + arg_134_0 then
				var_134_0.localPosition = Vector3.New(0, 100, 0)

				local var_134_7 = manager.ui.mainCamera.transform.position - var_134_0.position

				var_134_0.forward = Vector3.New(var_134_7.x, var_134_7.y, var_134_7.z)

				local var_134_8 = var_134_0.localEulerAngles

				var_134_8.z = 0
				var_134_8.x = 0
				var_134_0.localEulerAngles = var_134_8
			end

			local var_134_9 = arg_131_1.actors_["1019ui_story"]
			local var_134_10 = 0

			if var_134_10 < arg_131_1.time_ and arg_131_1.time_ <= var_134_10 + arg_134_0 and not isNil(var_134_9) and arg_131_1.var_.characterEffect1019ui_story == nil then
				arg_131_1.var_.characterEffect1019ui_story = var_134_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_11 = 0.200000002980232

			if var_134_10 <= arg_131_1.time_ and arg_131_1.time_ < var_134_10 + var_134_11 and not isNil(var_134_9) then
				local var_134_12 = (arg_131_1.time_ - var_134_10) / var_134_11

				if arg_131_1.var_.characterEffect1019ui_story and not isNil(var_134_9) then
					local var_134_13 = Mathf.Lerp(0, 0.5, var_134_12)

					arg_131_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_131_1.var_.characterEffect1019ui_story.fillRatio = var_134_13
				end
			end

			if arg_131_1.time_ >= var_134_10 + var_134_11 and arg_131_1.time_ < var_134_10 + var_134_11 + arg_134_0 and not isNil(var_134_9) and arg_131_1.var_.characterEffect1019ui_story then
				local var_134_14 = 0.5

				arg_131_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_131_1.var_.characterEffect1019ui_story.fillRatio = var_134_14
			end

			local var_134_15 = 0
			local var_134_16 = 1.175

			if var_134_15 < arg_131_1.time_ and arg_131_1.time_ <= var_134_15 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, false)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_17 = arg_131_1:GetWordFromCfg(304011032)
				local var_134_18 = arg_131_1:FormatText(var_134_17.content)

				arg_131_1.text_.text = var_134_18

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_19 = 47
				local var_134_20 = utf8.len(var_134_18)
				local var_134_21 = var_134_19 <= 0 and var_134_16 or var_134_16 * (var_134_20 / var_134_19)

				if var_134_21 > 0 and var_134_16 < var_134_21 then
					arg_131_1.talkMaxDuration = var_134_21

					if var_134_21 + var_134_15 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_21 + var_134_15
					end
				end

				arg_131_1.text_.text = var_134_18
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)
				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_22 = math.max(var_134_16, arg_131_1.talkMaxDuration)

			if var_134_15 <= arg_131_1.time_ and arg_131_1.time_ < var_134_15 + var_134_22 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_15) / var_134_22

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_15 + var_134_22 and arg_131_1.time_ < var_134_15 + var_134_22 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {
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

		arg_131_1:InitPlayNodeList()
	end,
	Play304011033 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 304011033
		arg_135_1.duration_ = 5

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play304011034(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = 0
			local var_138_1 = 0.25

			if var_138_0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_0 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				local var_138_2 = arg_135_1:FormatText(StoryNameCfg[7].name)

				arg_135_1.leftNameTxt_.text = var_138_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, true)
				arg_135_1.iconController_:SetSelectedState("hero")

				arg_135_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_135_1.callingController_:SetSelectedState("normal")

				arg_135_1.keyicon_.color = Color.New(1, 1, 1)
				arg_135_1.icon_.color = Color.New(1, 1, 1)

				local var_138_3 = arg_135_1:GetWordFromCfg(304011033)
				local var_138_4 = arg_135_1:FormatText(var_138_3.content)

				arg_135_1.text_.text = var_138_4

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_5 = 10
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
				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_8 = math.max(var_138_1, arg_135_1.talkMaxDuration)

			if var_138_0 <= arg_135_1.time_ and arg_135_1.time_ < var_138_0 + var_138_8 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_0) / var_138_8

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_0 + var_138_8 and arg_135_1.time_ < var_138_0 + var_138_8 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play304011034 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 304011034
		arg_139_1.duration_ = 4.2

		local var_139_0 = {
			zh = 4,
			ja = 4.2
		}
		local var_139_1 = manager.audio:GetLocalizationFlag()

		if var_139_0[var_139_1] ~= nil then
			arg_139_1.duration_ = var_139_0[var_139_1]
		end

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play304011035(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = arg_139_1.actors_["1019ui_story"].transform
			local var_142_1 = 0

			if var_142_1 < arg_139_1.time_ and arg_139_1.time_ <= var_142_1 + arg_142_0 then
				arg_139_1.var_.moveOldPos1019ui_story = var_142_0.localPosition
			end

			local var_142_2 = 0.001

			if var_142_1 <= arg_139_1.time_ and arg_139_1.time_ < var_142_1 + var_142_2 then
				local var_142_3 = (arg_139_1.time_ - var_142_1) / var_142_2
				local var_142_4 = Vector3.New(-0.2, -1.08, -5.9)

				var_142_0.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos1019ui_story, var_142_4, var_142_3)

				local var_142_5 = manager.ui.mainCamera.transform.position - var_142_0.position

				var_142_0.forward = Vector3.New(var_142_5.x, var_142_5.y, var_142_5.z)

				local var_142_6 = var_142_0.localEulerAngles

				var_142_6.z = 0
				var_142_6.x = 0
				var_142_0.localEulerAngles = var_142_6
			end

			if arg_139_1.time_ >= var_142_1 + var_142_2 and arg_139_1.time_ < var_142_1 + var_142_2 + arg_142_0 then
				var_142_0.localPosition = Vector3.New(-0.2, -1.08, -5.9)

				local var_142_7 = manager.ui.mainCamera.transform.position - var_142_0.position

				var_142_0.forward = Vector3.New(var_142_7.x, var_142_7.y, var_142_7.z)

				local var_142_8 = var_142_0.localEulerAngles

				var_142_8.z = 0
				var_142_8.x = 0
				var_142_0.localEulerAngles = var_142_8
			end

			local var_142_9 = arg_139_1.actors_["1019ui_story"]
			local var_142_10 = 0

			if var_142_10 < arg_139_1.time_ and arg_139_1.time_ <= var_142_10 + arg_142_0 and not isNil(var_142_9) and arg_139_1.var_.characterEffect1019ui_story == nil then
				arg_139_1.var_.characterEffect1019ui_story = var_142_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_11 = 0.200000002980232

			if var_142_10 <= arg_139_1.time_ and arg_139_1.time_ < var_142_10 + var_142_11 and not isNil(var_142_9) then
				local var_142_12 = (arg_139_1.time_ - var_142_10) / var_142_11

				if arg_139_1.var_.characterEffect1019ui_story and not isNil(var_142_9) then
					arg_139_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_139_1.time_ >= var_142_10 + var_142_11 and arg_139_1.time_ < var_142_10 + var_142_11 + arg_142_0 and not isNil(var_142_9) and arg_139_1.var_.characterEffect1019ui_story then
				arg_139_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_142_13 = 0

			if var_142_13 < arg_139_1.time_ and arg_139_1.time_ <= var_142_13 + arg_142_0 then
				arg_139_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_142_14 = 0
			local var_142_15 = 0.525

			if var_142_14 < arg_139_1.time_ and arg_139_1.time_ <= var_142_14 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				local var_142_16 = arg_139_1:FormatText(StoryNameCfg[13].name)

				arg_139_1.leftNameTxt_.text = var_142_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_17 = arg_139_1:GetWordFromCfg(304011034)
				local var_142_18 = arg_139_1:FormatText(var_142_17.content)

				arg_139_1.text_.text = var_142_18

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_19 = 21
				local var_142_20 = utf8.len(var_142_18)
				local var_142_21 = var_142_19 <= 0 and var_142_15 or var_142_15 * (var_142_20 / var_142_19)

				if var_142_21 > 0 and var_142_15 < var_142_21 then
					arg_139_1.talkMaxDuration = var_142_21

					if var_142_21 + var_142_14 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_21 + var_142_14
					end
				end

				arg_139_1.text_.text = var_142_18
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304011", "304011034", "story_v_out_304011.awb") ~= 0 then
					local var_142_22 = manager.audio:GetVoiceLength("story_v_out_304011", "304011034", "story_v_out_304011.awb") / 1000

					if var_142_22 + var_142_14 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_22 + var_142_14
					end

					if var_142_17.prefab_name ~= "" and arg_139_1.actors_[var_142_17.prefab_name] ~= nil then
						local var_142_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_17.prefab_name].transform, "story_v_out_304011", "304011034", "story_v_out_304011.awb")

						arg_139_1:RecordAudio("304011034", var_142_23)
						arg_139_1:RecordAudio("304011034", var_142_23)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_304011", "304011034", "story_v_out_304011.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_304011", "304011034", "story_v_out_304011.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_24 = math.max(var_142_15, arg_139_1.talkMaxDuration)

			if var_142_14 <= arg_139_1.time_ and arg_139_1.time_ < var_142_14 + var_142_24 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_14) / var_142_24

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_14 + var_142_24 and arg_139_1.time_ < var_142_14 + var_142_24 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {
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

		arg_139_1:InitPlayNodeList()
	end,
	Play304011035 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 304011035
		arg_143_1.duration_ = 5

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play304011036(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = arg_143_1.actors_["1019ui_story"]
			local var_146_1 = 0

			if var_146_1 < arg_143_1.time_ and arg_143_1.time_ <= var_146_1 + arg_146_0 and not isNil(var_146_0) and arg_143_1.var_.characterEffect1019ui_story == nil then
				arg_143_1.var_.characterEffect1019ui_story = var_146_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_2 = 0.200000002980232

			if var_146_1 <= arg_143_1.time_ and arg_143_1.time_ < var_146_1 + var_146_2 and not isNil(var_146_0) then
				local var_146_3 = (arg_143_1.time_ - var_146_1) / var_146_2

				if arg_143_1.var_.characterEffect1019ui_story and not isNil(var_146_0) then
					local var_146_4 = Mathf.Lerp(0, 0.5, var_146_3)

					arg_143_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_143_1.var_.characterEffect1019ui_story.fillRatio = var_146_4
				end
			end

			if arg_143_1.time_ >= var_146_1 + var_146_2 and arg_143_1.time_ < var_146_1 + var_146_2 + arg_146_0 and not isNil(var_146_0) and arg_143_1.var_.characterEffect1019ui_story then
				local var_146_5 = 0.5

				arg_143_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_143_1.var_.characterEffect1019ui_story.fillRatio = var_146_5
			end

			local var_146_6 = 0
			local var_146_7 = 1.2

			if var_146_6 < arg_143_1.time_ and arg_143_1.time_ <= var_146_6 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				local var_146_8 = arg_143_1:FormatText(StoryNameCfg[7].name)

				arg_143_1.leftNameTxt_.text = var_146_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, true)
				arg_143_1.iconController_:SetSelectedState("hero")

				arg_143_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_143_1.callingController_:SetSelectedState("normal")

				arg_143_1.keyicon_.color = Color.New(1, 1, 1)
				arg_143_1.icon_.color = Color.New(1, 1, 1)

				local var_146_9 = arg_143_1:GetWordFromCfg(304011035)
				local var_146_10 = arg_143_1:FormatText(var_146_9.content)

				arg_143_1.text_.text = var_146_10

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_11 = 48
				local var_146_12 = utf8.len(var_146_10)
				local var_146_13 = var_146_11 <= 0 and var_146_7 or var_146_7 * (var_146_12 / var_146_11)

				if var_146_13 > 0 and var_146_7 < var_146_13 then
					arg_143_1.talkMaxDuration = var_146_13

					if var_146_13 + var_146_6 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_13 + var_146_6
					end
				end

				arg_143_1.text_.text = var_146_10
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)
				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_14 = math.max(var_146_7, arg_143_1.talkMaxDuration)

			if var_146_6 <= arg_143_1.time_ and arg_143_1.time_ < var_146_6 + var_146_14 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_6) / var_146_14

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_6 + var_146_14 and arg_143_1.time_ < var_146_6 + var_146_14 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play304011036 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 304011036
		arg_147_1.duration_ = 5

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play304011037(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = 0
			local var_150_1 = 0.7

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

				arg_147_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_147_1.callingController_:SetSelectedState("normal")

				arg_147_1.keyicon_.color = Color.New(1, 1, 1)
				arg_147_1.icon_.color = Color.New(1, 1, 1)

				local var_150_3 = arg_147_1:GetWordFromCfg(304011036)
				local var_150_4 = arg_147_1:FormatText(var_150_3.content)

				arg_147_1.text_.text = var_150_4

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_5 = 28
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
	Play304011037 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 304011037
		arg_151_1.duration_ = 3.7

		local var_151_0 = {
			zh = 3.7,
			ja = 3.233
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
				arg_151_0:Play304011038(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = arg_151_1.actors_["1019ui_story"]
			local var_154_1 = 0

			if var_154_1 < arg_151_1.time_ and arg_151_1.time_ <= var_154_1 + arg_154_0 and not isNil(var_154_0) and arg_151_1.var_.characterEffect1019ui_story == nil then
				arg_151_1.var_.characterEffect1019ui_story = var_154_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_2 = 0.200000002980232

			if var_154_1 <= arg_151_1.time_ and arg_151_1.time_ < var_154_1 + var_154_2 and not isNil(var_154_0) then
				local var_154_3 = (arg_151_1.time_ - var_154_1) / var_154_2

				if arg_151_1.var_.characterEffect1019ui_story and not isNil(var_154_0) then
					arg_151_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_151_1.time_ >= var_154_1 + var_154_2 and arg_151_1.time_ < var_154_1 + var_154_2 + arg_154_0 and not isNil(var_154_0) and arg_151_1.var_.characterEffect1019ui_story then
				arg_151_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_154_4 = 0

			if var_154_4 < arg_151_1.time_ and arg_151_1.time_ <= var_154_4 + arg_154_0 then
				arg_151_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action7_1")
			end

			local var_154_5 = 0

			if var_154_5 < arg_151_1.time_ and arg_151_1.time_ <= var_154_5 + arg_154_0 then
				arg_151_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_154_6 = 0
			local var_154_7 = 0.425

			if var_154_6 < arg_151_1.time_ and arg_151_1.time_ <= var_154_6 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				local var_154_8 = arg_151_1:FormatText(StoryNameCfg[13].name)

				arg_151_1.leftNameTxt_.text = var_154_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_9 = arg_151_1:GetWordFromCfg(304011037)
				local var_154_10 = arg_151_1:FormatText(var_154_9.content)

				arg_151_1.text_.text = var_154_10

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_11 = 17
				local var_154_12 = utf8.len(var_154_10)
				local var_154_13 = var_154_11 <= 0 and var_154_7 or var_154_7 * (var_154_12 / var_154_11)

				if var_154_13 > 0 and var_154_7 < var_154_13 then
					arg_151_1.talkMaxDuration = var_154_13

					if var_154_13 + var_154_6 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_13 + var_154_6
					end
				end

				arg_151_1.text_.text = var_154_10
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304011", "304011037", "story_v_out_304011.awb") ~= 0 then
					local var_154_14 = manager.audio:GetVoiceLength("story_v_out_304011", "304011037", "story_v_out_304011.awb") / 1000

					if var_154_14 + var_154_6 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_14 + var_154_6
					end

					if var_154_9.prefab_name ~= "" and arg_151_1.actors_[var_154_9.prefab_name] ~= nil then
						local var_154_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_9.prefab_name].transform, "story_v_out_304011", "304011037", "story_v_out_304011.awb")

						arg_151_1:RecordAudio("304011037", var_154_15)
						arg_151_1:RecordAudio("304011037", var_154_15)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_304011", "304011037", "story_v_out_304011.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_304011", "304011037", "story_v_out_304011.awb")
				end

				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_16 = math.max(var_154_7, arg_151_1.talkMaxDuration)

			if var_154_6 <= arg_151_1.time_ and arg_151_1.time_ < var_154_6 + var_154_16 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_6) / var_154_16

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_6 + var_154_16 and arg_151_1.time_ < var_154_6 + var_154_16 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play304011038 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 304011038
		arg_155_1.duration_ = 5

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play304011039(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = arg_155_1.actors_["1019ui_story"]
			local var_158_1 = 0

			if var_158_1 < arg_155_1.time_ and arg_155_1.time_ <= var_158_1 + arg_158_0 and not isNil(var_158_0) and arg_155_1.var_.characterEffect1019ui_story == nil then
				arg_155_1.var_.characterEffect1019ui_story = var_158_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_158_2 = 0.200000002980232

			if var_158_1 <= arg_155_1.time_ and arg_155_1.time_ < var_158_1 + var_158_2 and not isNil(var_158_0) then
				local var_158_3 = (arg_155_1.time_ - var_158_1) / var_158_2

				if arg_155_1.var_.characterEffect1019ui_story and not isNil(var_158_0) then
					local var_158_4 = Mathf.Lerp(0, 0.5, var_158_3)

					arg_155_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_155_1.var_.characterEffect1019ui_story.fillRatio = var_158_4
				end
			end

			if arg_155_1.time_ >= var_158_1 + var_158_2 and arg_155_1.time_ < var_158_1 + var_158_2 + arg_158_0 and not isNil(var_158_0) and arg_155_1.var_.characterEffect1019ui_story then
				local var_158_5 = 0.5

				arg_155_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_155_1.var_.characterEffect1019ui_story.fillRatio = var_158_5
			end

			local var_158_6 = 0
			local var_158_7 = 0.55

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

				arg_155_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_155_1.callingController_:SetSelectedState("normal")

				arg_155_1.keyicon_.color = Color.New(1, 1, 1)
				arg_155_1.icon_.color = Color.New(1, 1, 1)

				local var_158_9 = arg_155_1:GetWordFromCfg(304011038)
				local var_158_10 = arg_155_1:FormatText(var_158_9.content)

				arg_155_1.text_.text = var_158_10

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_11 = 22
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
	Play304011039 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 304011039
		arg_159_1.duration_ = 5

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play304011040(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = 0
			local var_162_1 = 0.95

			if var_162_0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_0 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				local var_162_2 = arg_159_1:FormatText(StoryNameCfg[7].name)

				arg_159_1.leftNameTxt_.text = var_162_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, true)
				arg_159_1.iconController_:SetSelectedState("hero")

				arg_159_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_159_1.callingController_:SetSelectedState("normal")

				arg_159_1.keyicon_.color = Color.New(1, 1, 1)
				arg_159_1.icon_.color = Color.New(1, 1, 1)

				local var_162_3 = arg_159_1:GetWordFromCfg(304011039)
				local var_162_4 = arg_159_1:FormatText(var_162_3.content)

				arg_159_1.text_.text = var_162_4

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_5 = 38
				local var_162_6 = utf8.len(var_162_4)
				local var_162_7 = var_162_5 <= 0 and var_162_1 or var_162_1 * (var_162_6 / var_162_5)

				if var_162_7 > 0 and var_162_1 < var_162_7 then
					arg_159_1.talkMaxDuration = var_162_7

					if var_162_7 + var_162_0 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_7 + var_162_0
					end
				end

				arg_159_1.text_.text = var_162_4
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)
				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_8 = math.max(var_162_1, arg_159_1.talkMaxDuration)

			if var_162_0 <= arg_159_1.time_ and arg_159_1.time_ < var_162_0 + var_162_8 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_0) / var_162_8

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_0 + var_162_8 and arg_159_1.time_ < var_162_0 + var_162_8 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play304011040 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 304011040
		arg_163_1.duration_ = 5.6

		local var_163_0 = {
			zh = 5.266,
			ja = 5.6
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
				arg_163_0:Play304011041(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = arg_163_1.actors_["1019ui_story"]
			local var_166_1 = 0

			if var_166_1 < arg_163_1.time_ and arg_163_1.time_ <= var_166_1 + arg_166_0 and not isNil(var_166_0) and arg_163_1.var_.characterEffect1019ui_story == nil then
				arg_163_1.var_.characterEffect1019ui_story = var_166_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_166_2 = 0.200000002980232

			if var_166_1 <= arg_163_1.time_ and arg_163_1.time_ < var_166_1 + var_166_2 and not isNil(var_166_0) then
				local var_166_3 = (arg_163_1.time_ - var_166_1) / var_166_2

				if arg_163_1.var_.characterEffect1019ui_story and not isNil(var_166_0) then
					arg_163_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_163_1.time_ >= var_166_1 + var_166_2 and arg_163_1.time_ < var_166_1 + var_166_2 + arg_166_0 and not isNil(var_166_0) and arg_163_1.var_.characterEffect1019ui_story then
				arg_163_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_166_4 = 0

			if var_166_4 < arg_163_1.time_ and arg_163_1.time_ <= var_166_4 + arg_166_0 then
				arg_163_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action7_2")
			end

			local var_166_5 = 0
			local var_166_6 = 0.6

			if var_166_5 < arg_163_1.time_ and arg_163_1.time_ <= var_166_5 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				local var_166_7 = arg_163_1:FormatText(StoryNameCfg[13].name)

				arg_163_1.leftNameTxt_.text = var_166_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_8 = arg_163_1:GetWordFromCfg(304011040)
				local var_166_9 = arg_163_1:FormatText(var_166_8.content)

				arg_163_1.text_.text = var_166_9

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_10 = 24
				local var_166_11 = utf8.len(var_166_9)
				local var_166_12 = var_166_10 <= 0 and var_166_6 or var_166_6 * (var_166_11 / var_166_10)

				if var_166_12 > 0 and var_166_6 < var_166_12 then
					arg_163_1.talkMaxDuration = var_166_12

					if var_166_12 + var_166_5 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_12 + var_166_5
					end
				end

				arg_163_1.text_.text = var_166_9
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304011", "304011040", "story_v_out_304011.awb") ~= 0 then
					local var_166_13 = manager.audio:GetVoiceLength("story_v_out_304011", "304011040", "story_v_out_304011.awb") / 1000

					if var_166_13 + var_166_5 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_13 + var_166_5
					end

					if var_166_8.prefab_name ~= "" and arg_163_1.actors_[var_166_8.prefab_name] ~= nil then
						local var_166_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_8.prefab_name].transform, "story_v_out_304011", "304011040", "story_v_out_304011.awb")

						arg_163_1:RecordAudio("304011040", var_166_14)
						arg_163_1:RecordAudio("304011040", var_166_14)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_304011", "304011040", "story_v_out_304011.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_304011", "304011040", "story_v_out_304011.awb")
				end

				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_15 = math.max(var_166_6, arg_163_1.talkMaxDuration)

			if var_166_5 <= arg_163_1.time_ and arg_163_1.time_ < var_166_5 + var_166_15 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_5) / var_166_15

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_5 + var_166_15 and arg_163_1.time_ < var_166_5 + var_166_15 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {}

		arg_163_1:InitPlayNodeList()
	end,
	Play304011041 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 304011041
		arg_167_1.duration_ = 4.6

		local var_167_0 = {
			zh = 4.6,
			ja = 4.4
		}
		local var_167_1 = manager.audio:GetLocalizationFlag()

		if var_167_0[var_167_1] ~= nil then
			arg_167_1.duration_ = var_167_0[var_167_1]
		end

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play304011042(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = 0

			if var_170_0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_0 + arg_170_0 then
				arg_167_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action1_1")
			end

			local var_170_1 = 0

			if var_170_1 < arg_167_1.time_ and arg_167_1.time_ <= var_170_1 + arg_170_0 then
				arg_167_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_170_2 = 0
			local var_170_3 = 0.575

			if var_170_2 < arg_167_1.time_ and arg_167_1.time_ <= var_170_2 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				local var_170_4 = arg_167_1:FormatText(StoryNameCfg[13].name)

				arg_167_1.leftNameTxt_.text = var_170_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_5 = arg_167_1:GetWordFromCfg(304011041)
				local var_170_6 = arg_167_1:FormatText(var_170_5.content)

				arg_167_1.text_.text = var_170_6

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_7 = 23
				local var_170_8 = utf8.len(var_170_6)
				local var_170_9 = var_170_7 <= 0 and var_170_3 or var_170_3 * (var_170_8 / var_170_7)

				if var_170_9 > 0 and var_170_3 < var_170_9 then
					arg_167_1.talkMaxDuration = var_170_9

					if var_170_9 + var_170_2 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_9 + var_170_2
					end
				end

				arg_167_1.text_.text = var_170_6
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304011", "304011041", "story_v_out_304011.awb") ~= 0 then
					local var_170_10 = manager.audio:GetVoiceLength("story_v_out_304011", "304011041", "story_v_out_304011.awb") / 1000

					if var_170_10 + var_170_2 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_10 + var_170_2
					end

					if var_170_5.prefab_name ~= "" and arg_167_1.actors_[var_170_5.prefab_name] ~= nil then
						local var_170_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_5.prefab_name].transform, "story_v_out_304011", "304011041", "story_v_out_304011.awb")

						arg_167_1:RecordAudio("304011041", var_170_11)
						arg_167_1:RecordAudio("304011041", var_170_11)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_304011", "304011041", "story_v_out_304011.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_304011", "304011041", "story_v_out_304011.awb")
				end

				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_12 = math.max(var_170_3, arg_167_1.talkMaxDuration)

			if var_170_2 <= arg_167_1.time_ and arg_167_1.time_ < var_170_2 + var_170_12 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_2) / var_170_12

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_2 + var_170_12 and arg_167_1.time_ < var_170_2 + var_170_12 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {}

		arg_167_1:InitPlayNodeList()
	end,
	Play304011042 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 304011042
		arg_171_1.duration_ = 5

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play304011043(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = arg_171_1.actors_["1019ui_story"]
			local var_174_1 = 0

			if var_174_1 < arg_171_1.time_ and arg_171_1.time_ <= var_174_1 + arg_174_0 and not isNil(var_174_0) and arg_171_1.var_.characterEffect1019ui_story == nil then
				arg_171_1.var_.characterEffect1019ui_story = var_174_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_2 = 0.200000002980232

			if var_174_1 <= arg_171_1.time_ and arg_171_1.time_ < var_174_1 + var_174_2 and not isNil(var_174_0) then
				local var_174_3 = (arg_171_1.time_ - var_174_1) / var_174_2

				if arg_171_1.var_.characterEffect1019ui_story and not isNil(var_174_0) then
					local var_174_4 = Mathf.Lerp(0, 0.5, var_174_3)

					arg_171_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_171_1.var_.characterEffect1019ui_story.fillRatio = var_174_4
				end
			end

			if arg_171_1.time_ >= var_174_1 + var_174_2 and arg_171_1.time_ < var_174_1 + var_174_2 + arg_174_0 and not isNil(var_174_0) and arg_171_1.var_.characterEffect1019ui_story then
				local var_174_5 = 0.5

				arg_171_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_171_1.var_.characterEffect1019ui_story.fillRatio = var_174_5
			end

			local var_174_6 = 0
			local var_174_7 = 0.6

			if var_174_6 < arg_171_1.time_ and arg_171_1.time_ <= var_174_6 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				local var_174_8 = arg_171_1:FormatText(StoryNameCfg[7].name)

				arg_171_1.leftNameTxt_.text = var_174_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, true)
				arg_171_1.iconController_:SetSelectedState("hero")

				arg_171_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_171_1.callingController_:SetSelectedState("normal")

				arg_171_1.keyicon_.color = Color.New(1, 1, 1)
				arg_171_1.icon_.color = Color.New(1, 1, 1)

				local var_174_9 = arg_171_1:GetWordFromCfg(304011042)
				local var_174_10 = arg_171_1:FormatText(var_174_9.content)

				arg_171_1.text_.text = var_174_10

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_11 = 24
				local var_174_12 = utf8.len(var_174_10)
				local var_174_13 = var_174_11 <= 0 and var_174_7 or var_174_7 * (var_174_12 / var_174_11)

				if var_174_13 > 0 and var_174_7 < var_174_13 then
					arg_171_1.talkMaxDuration = var_174_13

					if var_174_13 + var_174_6 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_13 + var_174_6
					end
				end

				arg_171_1.text_.text = var_174_10
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)
				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_14 = math.max(var_174_7, arg_171_1.talkMaxDuration)

			if var_174_6 <= arg_171_1.time_ and arg_171_1.time_ < var_174_6 + var_174_14 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_6) / var_174_14

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_6 + var_174_14 and arg_171_1.time_ < var_174_6 + var_174_14 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {}

		arg_171_1:InitPlayNodeList()
	end,
	Play304011043 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 304011043
		arg_175_1.duration_ = 5

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play304011044(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = 0
			local var_178_1 = 0.6

			if var_178_0 < arg_175_1.time_ and arg_175_1.time_ <= var_178_0 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				local var_178_2 = arg_175_1:FormatText(StoryNameCfg[7].name)

				arg_175_1.leftNameTxt_.text = var_178_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, true)
				arg_175_1.iconController_:SetSelectedState("hero")

				arg_175_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_175_1.callingController_:SetSelectedState("normal")

				arg_175_1.keyicon_.color = Color.New(1, 1, 1)
				arg_175_1.icon_.color = Color.New(1, 1, 1)

				local var_178_3 = arg_175_1:GetWordFromCfg(304011043)
				local var_178_4 = arg_175_1:FormatText(var_178_3.content)

				arg_175_1.text_.text = var_178_4

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_5 = 24
				local var_178_6 = utf8.len(var_178_4)
				local var_178_7 = var_178_5 <= 0 and var_178_1 or var_178_1 * (var_178_6 / var_178_5)

				if var_178_7 > 0 and var_178_1 < var_178_7 then
					arg_175_1.talkMaxDuration = var_178_7

					if var_178_7 + var_178_0 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_7 + var_178_0
					end
				end

				arg_175_1.text_.text = var_178_4
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)
				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_8 = math.max(var_178_1, arg_175_1.talkMaxDuration)

			if var_178_0 <= arg_175_1.time_ and arg_175_1.time_ < var_178_0 + var_178_8 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_0) / var_178_8

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_0 + var_178_8 and arg_175_1.time_ < var_178_0 + var_178_8 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {}

		arg_175_1:InitPlayNodeList()
	end,
	Play304011044 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 304011044
		arg_179_1.duration_ = 16.17

		local var_179_0 = {
			zh = 9.6,
			ja = 16.166
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
				arg_179_0:Play304011045(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = arg_179_1.actors_["1019ui_story"]
			local var_182_1 = 0

			if var_182_1 < arg_179_1.time_ and arg_179_1.time_ <= var_182_1 + arg_182_0 and not isNil(var_182_0) and arg_179_1.var_.characterEffect1019ui_story == nil then
				arg_179_1.var_.characterEffect1019ui_story = var_182_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_182_2 = 0.200000002980232

			if var_182_1 <= arg_179_1.time_ and arg_179_1.time_ < var_182_1 + var_182_2 and not isNil(var_182_0) then
				local var_182_3 = (arg_179_1.time_ - var_182_1) / var_182_2

				if arg_179_1.var_.characterEffect1019ui_story and not isNil(var_182_0) then
					arg_179_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_179_1.time_ >= var_182_1 + var_182_2 and arg_179_1.time_ < var_182_1 + var_182_2 + arg_182_0 and not isNil(var_182_0) and arg_179_1.var_.characterEffect1019ui_story then
				arg_179_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_182_4 = 0
			local var_182_5 = 1.15

			if var_182_4 < arg_179_1.time_ and arg_179_1.time_ <= var_182_4 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				local var_182_6 = arg_179_1:FormatText(StoryNameCfg[13].name)

				arg_179_1.leftNameTxt_.text = var_182_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_7 = arg_179_1:GetWordFromCfg(304011044)
				local var_182_8 = arg_179_1:FormatText(var_182_7.content)

				arg_179_1.text_.text = var_182_8

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_9 = 46
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

				if manager.audio:GetVoiceLength("story_v_out_304011", "304011044", "story_v_out_304011.awb") ~= 0 then
					local var_182_12 = manager.audio:GetVoiceLength("story_v_out_304011", "304011044", "story_v_out_304011.awb") / 1000

					if var_182_12 + var_182_4 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_12 + var_182_4
					end

					if var_182_7.prefab_name ~= "" and arg_179_1.actors_[var_182_7.prefab_name] ~= nil then
						local var_182_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_7.prefab_name].transform, "story_v_out_304011", "304011044", "story_v_out_304011.awb")

						arg_179_1:RecordAudio("304011044", var_182_13)
						arg_179_1:RecordAudio("304011044", var_182_13)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_out_304011", "304011044", "story_v_out_304011.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_out_304011", "304011044", "story_v_out_304011.awb")
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
	Play304011045 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 304011045
		arg_183_1.duration_ = 5.07

		local var_183_0 = {
			zh = 4.066,
			ja = 5.066
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
				arg_183_0:Play304011046(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = 0

			if var_186_0 < arg_183_1.time_ and arg_183_1.time_ <= var_186_0 + arg_186_0 then
				arg_183_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action5_1")
			end

			local var_186_1 = 0

			if var_186_1 < arg_183_1.time_ and arg_183_1.time_ <= var_186_1 + arg_186_0 then
				arg_183_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_186_2 = 0
			local var_186_3 = 0.525

			if var_186_2 < arg_183_1.time_ and arg_183_1.time_ <= var_186_2 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				local var_186_4 = arg_183_1:FormatText(StoryNameCfg[13].name)

				arg_183_1.leftNameTxt_.text = var_186_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_5 = arg_183_1:GetWordFromCfg(304011045)
				local var_186_6 = arg_183_1:FormatText(var_186_5.content)

				arg_183_1.text_.text = var_186_6

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_7 = 21
				local var_186_8 = utf8.len(var_186_6)
				local var_186_9 = var_186_7 <= 0 and var_186_3 or var_186_3 * (var_186_8 / var_186_7)

				if var_186_9 > 0 and var_186_3 < var_186_9 then
					arg_183_1.talkMaxDuration = var_186_9

					if var_186_9 + var_186_2 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_9 + var_186_2
					end
				end

				arg_183_1.text_.text = var_186_6
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304011", "304011045", "story_v_out_304011.awb") ~= 0 then
					local var_186_10 = manager.audio:GetVoiceLength("story_v_out_304011", "304011045", "story_v_out_304011.awb") / 1000

					if var_186_10 + var_186_2 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_10 + var_186_2
					end

					if var_186_5.prefab_name ~= "" and arg_183_1.actors_[var_186_5.prefab_name] ~= nil then
						local var_186_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_5.prefab_name].transform, "story_v_out_304011", "304011045", "story_v_out_304011.awb")

						arg_183_1:RecordAudio("304011045", var_186_11)
						arg_183_1:RecordAudio("304011045", var_186_11)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_out_304011", "304011045", "story_v_out_304011.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_out_304011", "304011045", "story_v_out_304011.awb")
				end

				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_12 = math.max(var_186_3, arg_183_1.talkMaxDuration)

			if var_186_2 <= arg_183_1.time_ and arg_183_1.time_ < var_186_2 + var_186_12 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_2) / var_186_12

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_2 + var_186_12 and arg_183_1.time_ < var_186_2 + var_186_12 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {}

		arg_183_1:InitPlayNodeList()
	end,
	Play304011046 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 304011046
		arg_187_1.duration_ = 5

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play304011047(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = arg_187_1.actors_["1019ui_story"].transform
			local var_190_1 = 0

			if var_190_1 < arg_187_1.time_ and arg_187_1.time_ <= var_190_1 + arg_190_0 then
				arg_187_1.var_.moveOldPos1019ui_story = var_190_0.localPosition
			end

			local var_190_2 = 0.001

			if var_190_1 <= arg_187_1.time_ and arg_187_1.time_ < var_190_1 + var_190_2 then
				local var_190_3 = (arg_187_1.time_ - var_190_1) / var_190_2
				local var_190_4 = Vector3.New(0, 100, 0)

				var_190_0.localPosition = Vector3.Lerp(arg_187_1.var_.moveOldPos1019ui_story, var_190_4, var_190_3)

				local var_190_5 = manager.ui.mainCamera.transform.position - var_190_0.position

				var_190_0.forward = Vector3.New(var_190_5.x, var_190_5.y, var_190_5.z)

				local var_190_6 = var_190_0.localEulerAngles

				var_190_6.z = 0
				var_190_6.x = 0
				var_190_0.localEulerAngles = var_190_6
			end

			if arg_187_1.time_ >= var_190_1 + var_190_2 and arg_187_1.time_ < var_190_1 + var_190_2 + arg_190_0 then
				var_190_0.localPosition = Vector3.New(0, 100, 0)

				local var_190_7 = manager.ui.mainCamera.transform.position - var_190_0.position

				var_190_0.forward = Vector3.New(var_190_7.x, var_190_7.y, var_190_7.z)

				local var_190_8 = var_190_0.localEulerAngles

				var_190_8.z = 0
				var_190_8.x = 0
				var_190_0.localEulerAngles = var_190_8
			end

			local var_190_9 = arg_187_1.actors_["1019ui_story"]
			local var_190_10 = 0

			if var_190_10 < arg_187_1.time_ and arg_187_1.time_ <= var_190_10 + arg_190_0 and not isNil(var_190_9) and arg_187_1.var_.characterEffect1019ui_story == nil then
				arg_187_1.var_.characterEffect1019ui_story = var_190_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_11 = 0.200000002980232

			if var_190_10 <= arg_187_1.time_ and arg_187_1.time_ < var_190_10 + var_190_11 and not isNil(var_190_9) then
				local var_190_12 = (arg_187_1.time_ - var_190_10) / var_190_11

				if arg_187_1.var_.characterEffect1019ui_story and not isNil(var_190_9) then
					local var_190_13 = Mathf.Lerp(0, 0.5, var_190_12)

					arg_187_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_187_1.var_.characterEffect1019ui_story.fillRatio = var_190_13
				end
			end

			if arg_187_1.time_ >= var_190_10 + var_190_11 and arg_187_1.time_ < var_190_10 + var_190_11 + arg_190_0 and not isNil(var_190_9) and arg_187_1.var_.characterEffect1019ui_story then
				local var_190_14 = 0.5

				arg_187_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_187_1.var_.characterEffect1019ui_story.fillRatio = var_190_14
			end

			local var_190_15 = 0
			local var_190_16 = 1.05

			if var_190_15 < arg_187_1.time_ and arg_187_1.time_ <= var_190_15 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, false)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_17 = arg_187_1:GetWordFromCfg(304011046)
				local var_190_18 = arg_187_1:FormatText(var_190_17.content)

				arg_187_1.text_.text = var_190_18

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_19 = 42
				local var_190_20 = utf8.len(var_190_18)
				local var_190_21 = var_190_19 <= 0 and var_190_16 or var_190_16 * (var_190_20 / var_190_19)

				if var_190_21 > 0 and var_190_16 < var_190_21 then
					arg_187_1.talkMaxDuration = var_190_21

					if var_190_21 + var_190_15 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_21 + var_190_15
					end
				end

				arg_187_1.text_.text = var_190_18
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)
				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_22 = math.max(var_190_16, arg_187_1.talkMaxDuration)

			if var_190_15 <= arg_187_1.time_ and arg_187_1.time_ < var_190_15 + var_190_22 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_15) / var_190_22

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_15 + var_190_22 and arg_187_1.time_ < var_190_15 + var_190_22 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {
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

		arg_187_1:InitPlayNodeList()
	end,
	Play304011047 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 304011047
		arg_191_1.duration_ = 5

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play304011048(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = 0
			local var_194_1 = 0.575

			if var_194_0 < arg_191_1.time_ and arg_191_1.time_ <= var_194_0 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				local var_194_2 = arg_191_1:FormatText(StoryNameCfg[7].name)

				arg_191_1.leftNameTxt_.text = var_194_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, true)
				arg_191_1.iconController_:SetSelectedState("hero")

				arg_191_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_191_1.callingController_:SetSelectedState("normal")

				arg_191_1.keyicon_.color = Color.New(1, 1, 1)
				arg_191_1.icon_.color = Color.New(1, 1, 1)

				local var_194_3 = arg_191_1:GetWordFromCfg(304011047)
				local var_194_4 = arg_191_1:FormatText(var_194_3.content)

				arg_191_1.text_.text = var_194_4

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_5 = 23
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
				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_8 = math.max(var_194_1, arg_191_1.talkMaxDuration)

			if var_194_0 <= arg_191_1.time_ and arg_191_1.time_ < var_194_0 + var_194_8 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_0) / var_194_8

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_0 + var_194_8 and arg_191_1.time_ < var_194_0 + var_194_8 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {}

		arg_191_1:InitPlayNodeList()
	end,
	Play304011048 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 304011048
		arg_195_1.duration_ = 5

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play304011049(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = 0
			local var_198_1 = 0.625

			if var_198_0 < arg_195_1.time_ and arg_195_1.time_ <= var_198_0 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				local var_198_2 = arg_195_1:FormatText(StoryNameCfg[7].name)

				arg_195_1.leftNameTxt_.text = var_198_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, true)
				arg_195_1.iconController_:SetSelectedState("hero")

				arg_195_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_195_1.callingController_:SetSelectedState("normal")

				arg_195_1.keyicon_.color = Color.New(1, 1, 1)
				arg_195_1.icon_.color = Color.New(1, 1, 1)

				local var_198_3 = arg_195_1:GetWordFromCfg(304011048)
				local var_198_4 = arg_195_1:FormatText(var_198_3.content)

				arg_195_1.text_.text = var_198_4

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_5 = 25
				local var_198_6 = utf8.len(var_198_4)
				local var_198_7 = var_198_5 <= 0 and var_198_1 or var_198_1 * (var_198_6 / var_198_5)

				if var_198_7 > 0 and var_198_1 < var_198_7 then
					arg_195_1.talkMaxDuration = var_198_7

					if var_198_7 + var_198_0 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_7 + var_198_0
					end
				end

				arg_195_1.text_.text = var_198_4
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)
				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_8 = math.max(var_198_1, arg_195_1.talkMaxDuration)

			if var_198_0 <= arg_195_1.time_ and arg_195_1.time_ < var_198_0 + var_198_8 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_0) / var_198_8

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_0 + var_198_8 and arg_195_1.time_ < var_198_0 + var_198_8 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {}

		arg_195_1:InitPlayNodeList()
	end,
	Play304011049 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 304011049
		arg_199_1.duration_ = 6.67

		local var_199_0 = {
			zh = 4.8,
			ja = 6.666
		}
		local var_199_1 = manager.audio:GetLocalizationFlag()

		if var_199_0[var_199_1] ~= nil then
			arg_199_1.duration_ = var_199_0[var_199_1]
		end

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play304011050(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = arg_199_1.actors_["1019ui_story"].transform
			local var_202_1 = 0

			if var_202_1 < arg_199_1.time_ and arg_199_1.time_ <= var_202_1 + arg_202_0 then
				arg_199_1.var_.moveOldPos1019ui_story = var_202_0.localPosition
			end

			local var_202_2 = 0.001

			if var_202_1 <= arg_199_1.time_ and arg_199_1.time_ < var_202_1 + var_202_2 then
				local var_202_3 = (arg_199_1.time_ - var_202_1) / var_202_2
				local var_202_4 = Vector3.New(-0.2, -1.08, -5.9)

				var_202_0.localPosition = Vector3.Lerp(arg_199_1.var_.moveOldPos1019ui_story, var_202_4, var_202_3)

				local var_202_5 = manager.ui.mainCamera.transform.position - var_202_0.position

				var_202_0.forward = Vector3.New(var_202_5.x, var_202_5.y, var_202_5.z)

				local var_202_6 = var_202_0.localEulerAngles

				var_202_6.z = 0
				var_202_6.x = 0
				var_202_0.localEulerAngles = var_202_6
			end

			if arg_199_1.time_ >= var_202_1 + var_202_2 and arg_199_1.time_ < var_202_1 + var_202_2 + arg_202_0 then
				var_202_0.localPosition = Vector3.New(-0.2, -1.08, -5.9)

				local var_202_7 = manager.ui.mainCamera.transform.position - var_202_0.position

				var_202_0.forward = Vector3.New(var_202_7.x, var_202_7.y, var_202_7.z)

				local var_202_8 = var_202_0.localEulerAngles

				var_202_8.z = 0
				var_202_8.x = 0
				var_202_0.localEulerAngles = var_202_8
			end

			local var_202_9 = arg_199_1.actors_["1019ui_story"]
			local var_202_10 = 0

			if var_202_10 < arg_199_1.time_ and arg_199_1.time_ <= var_202_10 + arg_202_0 and not isNil(var_202_9) and arg_199_1.var_.characterEffect1019ui_story == nil then
				arg_199_1.var_.characterEffect1019ui_story = var_202_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_202_11 = 0.200000002980232

			if var_202_10 <= arg_199_1.time_ and arg_199_1.time_ < var_202_10 + var_202_11 and not isNil(var_202_9) then
				local var_202_12 = (arg_199_1.time_ - var_202_10) / var_202_11

				if arg_199_1.var_.characterEffect1019ui_story and not isNil(var_202_9) then
					arg_199_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_199_1.time_ >= var_202_10 + var_202_11 and arg_199_1.time_ < var_202_10 + var_202_11 + arg_202_0 and not isNil(var_202_9) and arg_199_1.var_.characterEffect1019ui_story then
				arg_199_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_202_13 = 0

			if var_202_13 < arg_199_1.time_ and arg_199_1.time_ <= var_202_13 + arg_202_0 then
				arg_199_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action5_2")
			end

			local var_202_14 = 0

			if var_202_14 < arg_199_1.time_ and arg_199_1.time_ <= var_202_14 + arg_202_0 then
				arg_199_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_202_15 = 0
			local var_202_16 = 0.575

			if var_202_15 < arg_199_1.time_ and arg_199_1.time_ <= var_202_15 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				local var_202_17 = arg_199_1:FormatText(StoryNameCfg[13].name)

				arg_199_1.leftNameTxt_.text = var_202_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_18 = arg_199_1:GetWordFromCfg(304011049)
				local var_202_19 = arg_199_1:FormatText(var_202_18.content)

				arg_199_1.text_.text = var_202_19

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_20 = 23
				local var_202_21 = utf8.len(var_202_19)
				local var_202_22 = var_202_20 <= 0 and var_202_16 or var_202_16 * (var_202_21 / var_202_20)

				if var_202_22 > 0 and var_202_16 < var_202_22 then
					arg_199_1.talkMaxDuration = var_202_22

					if var_202_22 + var_202_15 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_22 + var_202_15
					end
				end

				arg_199_1.text_.text = var_202_19
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304011", "304011049", "story_v_out_304011.awb") ~= 0 then
					local var_202_23 = manager.audio:GetVoiceLength("story_v_out_304011", "304011049", "story_v_out_304011.awb") / 1000

					if var_202_23 + var_202_15 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_23 + var_202_15
					end

					if var_202_18.prefab_name ~= "" and arg_199_1.actors_[var_202_18.prefab_name] ~= nil then
						local var_202_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_199_1.actors_[var_202_18.prefab_name].transform, "story_v_out_304011", "304011049", "story_v_out_304011.awb")

						arg_199_1:RecordAudio("304011049", var_202_24)
						arg_199_1:RecordAudio("304011049", var_202_24)
					else
						arg_199_1:AudioAction("play", "voice", "story_v_out_304011", "304011049", "story_v_out_304011.awb")
					end

					arg_199_1:RecordHistoryTalkVoice("story_v_out_304011", "304011049", "story_v_out_304011.awb")
				end

				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_25 = math.max(var_202_16, arg_199_1.talkMaxDuration)

			if var_202_15 <= arg_199_1.time_ and arg_199_1.time_ < var_202_15 + var_202_25 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_15) / var_202_25

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_15 + var_202_25 and arg_199_1.time_ < var_202_15 + var_202_25 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {
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

		arg_199_1:InitPlayNodeList()
	end,
	Play304011050 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 304011050
		arg_203_1.duration_ = 9.73

		local var_203_0 = {
			zh = 9.733,
			ja = 9.2
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
				arg_203_0:Play304011051(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			local var_206_0 = "B10f"

			if arg_203_1.bgs_[var_206_0] == nil then
				local var_206_1 = Object.Instantiate(arg_203_1.paintGo_)

				var_206_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_206_0)
				var_206_1.name = var_206_0
				var_206_1.transform.parent = arg_203_1.stage_.transform
				var_206_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_203_1.bgs_[var_206_0] = var_206_1
			end

			local var_206_2 = 5.43333333333333

			if var_206_2 < arg_203_1.time_ and arg_203_1.time_ <= var_206_2 + arg_206_0 then
				local var_206_3 = manager.ui.mainCamera.transform.localPosition
				local var_206_4 = Vector3.New(0, 0, 10) + Vector3.New(var_206_3.x, var_206_3.y, 0)
				local var_206_5 = arg_203_1.bgs_.B10f

				var_206_5.transform.localPosition = var_206_4
				var_206_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_206_6 = var_206_5:GetComponent("SpriteRenderer")

				if var_206_6 and var_206_6.sprite then
					local var_206_7 = (var_206_5.transform.localPosition - var_206_3).z
					local var_206_8 = manager.ui.mainCameraCom_
					local var_206_9 = 2 * var_206_7 * Mathf.Tan(var_206_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_206_10 = var_206_9 * var_206_8.aspect
					local var_206_11 = var_206_6.sprite.bounds.size.x
					local var_206_12 = var_206_6.sprite.bounds.size.y
					local var_206_13 = var_206_10 / var_206_11
					local var_206_14 = var_206_9 / var_206_12
					local var_206_15 = var_206_14 < var_206_13 and var_206_13 or var_206_14

					var_206_5.transform.localScale = Vector3.New(var_206_15, var_206_15, 0)
				end

				for iter_206_0, iter_206_1 in pairs(arg_203_1.bgs_) do
					if iter_206_0 ~= "B10f" then
						iter_206_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_206_16 = 1.23333333333333

			if var_206_16 < arg_203_1.time_ and arg_203_1.time_ <= var_206_16 + arg_206_0 then
				arg_203_1.allBtn_.enabled = false
			end

			local var_206_17 = 0.3

			if arg_203_1.time_ >= var_206_16 + var_206_17 and arg_203_1.time_ < var_206_16 + var_206_17 + arg_206_0 then
				arg_203_1.allBtn_.enabled = true
			end

			local var_206_18 = 0

			if var_206_18 < arg_203_1.time_ and arg_203_1.time_ <= var_206_18 + arg_206_0 then
				arg_203_1.mask_.enabled = true
				arg_203_1.mask_.raycastTarget = true

				arg_203_1:SetGaussion(false)
			end

			local var_206_19 = 1.23333333333333

			if var_206_18 <= arg_203_1.time_ and arg_203_1.time_ < var_206_18 + var_206_19 then
				local var_206_20 = (arg_203_1.time_ - var_206_18) / var_206_19
				local var_206_21 = Color.New(0, 0, 0)

				var_206_21.a = Mathf.Lerp(0, 1, var_206_20)
				arg_203_1.mask_.color = var_206_21
			end

			if arg_203_1.time_ >= var_206_18 + var_206_19 and arg_203_1.time_ < var_206_18 + var_206_19 + arg_206_0 then
				local var_206_22 = Color.New(0, 0, 0)

				var_206_22.a = 1
				arg_203_1.mask_.color = var_206_22
			end

			local var_206_23 = 1.23333333333333

			if var_206_23 < arg_203_1.time_ and arg_203_1.time_ <= var_206_23 + arg_206_0 then
				arg_203_1.mask_.enabled = true
				arg_203_1.mask_.raycastTarget = true

				arg_203_1:SetGaussion(false)
			end

			local var_206_24 = 2

			if var_206_23 <= arg_203_1.time_ and arg_203_1.time_ < var_206_23 + var_206_24 then
				local var_206_25 = (arg_203_1.time_ - var_206_23) / var_206_24
				local var_206_26 = Color.New(0, 0, 0)

				var_206_26.a = Mathf.Lerp(1, 0, var_206_25)
				arg_203_1.mask_.color = var_206_26
			end

			if arg_203_1.time_ >= var_206_23 + var_206_24 and arg_203_1.time_ < var_206_23 + var_206_24 + arg_206_0 then
				local var_206_27 = Color.New(0, 0, 0)
				local var_206_28 = 0

				arg_203_1.mask_.enabled = false
				var_206_27.a = var_206_28
				arg_203_1.mask_.color = var_206_27
			end

			local var_206_29 = arg_203_1.actors_["1019ui_story"]
			local var_206_30 = 1.23333333333333

			if var_206_30 < arg_203_1.time_ and arg_203_1.time_ <= var_206_30 + arg_206_0 and not isNil(var_206_29) and arg_203_1.var_.characterEffect1019ui_story == nil then
				arg_203_1.var_.characterEffect1019ui_story = var_206_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_206_31 = 0.200000002980232

			if var_206_30 <= arg_203_1.time_ and arg_203_1.time_ < var_206_30 + var_206_31 and not isNil(var_206_29) then
				local var_206_32 = (arg_203_1.time_ - var_206_30) / var_206_31

				if arg_203_1.var_.characterEffect1019ui_story and not isNil(var_206_29) then
					local var_206_33 = Mathf.Lerp(0, 0.5, var_206_32)

					arg_203_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_203_1.var_.characterEffect1019ui_story.fillRatio = var_206_33
				end
			end

			if arg_203_1.time_ >= var_206_30 + var_206_31 and arg_203_1.time_ < var_206_30 + var_206_31 + arg_206_0 and not isNil(var_206_29) and arg_203_1.var_.characterEffect1019ui_story then
				local var_206_34 = 0.5

				arg_203_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_203_1.var_.characterEffect1019ui_story.fillRatio = var_206_34
			end

			local var_206_35 = arg_203_1.actors_["1019ui_story"].transform
			local var_206_36 = 1.23333333333333

			if var_206_36 < arg_203_1.time_ and arg_203_1.time_ <= var_206_36 + arg_206_0 then
				arg_203_1.var_.moveOldPos1019ui_story = var_206_35.localPosition
			end

			local var_206_37 = 0.001

			if var_206_36 <= arg_203_1.time_ and arg_203_1.time_ < var_206_36 + var_206_37 then
				local var_206_38 = (arg_203_1.time_ - var_206_36) / var_206_37
				local var_206_39 = Vector3.New(0, 100, 0)

				var_206_35.localPosition = Vector3.Lerp(arg_203_1.var_.moveOldPos1019ui_story, var_206_39, var_206_38)

				local var_206_40 = manager.ui.mainCamera.transform.position - var_206_35.position

				var_206_35.forward = Vector3.New(var_206_40.x, var_206_40.y, var_206_40.z)

				local var_206_41 = var_206_35.localEulerAngles

				var_206_41.z = 0
				var_206_41.x = 0
				var_206_35.localEulerAngles = var_206_41
			end

			if arg_203_1.time_ >= var_206_36 + var_206_37 and arg_203_1.time_ < var_206_36 + var_206_37 + arg_206_0 then
				var_206_35.localPosition = Vector3.New(0, 100, 0)

				local var_206_42 = manager.ui.mainCamera.transform.position - var_206_35.position

				var_206_35.forward = Vector3.New(var_206_42.x, var_206_42.y, var_206_42.z)

				local var_206_43 = var_206_35.localEulerAngles

				var_206_43.z = 0
				var_206_43.x = 0
				var_206_35.localEulerAngles = var_206_43
			end

			local var_206_44 = 1.23333333333333
			local var_206_45 = 3
			local var_206_46 = "B10f"

			if var_206_44 < arg_203_1.time_ and arg_203_1.time_ <= var_206_44 + arg_206_0 then
				arg_203_1.timestampController_:SetSelectedState("show")
				arg_203_1.timestampAni_:Play("in")

				arg_203_1.timeTicketbgImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_206_46)

				arg_203_1.timestampColorController_:SetSelectedState("cold")
				arg_203_1.timeColdImg_:SetAlpha(0.031)

				local var_206_47 = arg_203_1:GetWordFromCfg(102)
				local var_206_48 = arg_203_1:FormatText(var_206_47.content)

				arg_203_1.text_timeText_.text = var_206_48
				arg_203_1.text_timeText_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_timeText_)

				local var_206_49 = arg_203_1:GetWordFromCfg(501132)
				local var_206_50 = arg_203_1:FormatText(var_206_49.content)

				arg_203_1.text_siteText_.text = var_206_50

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_siteText_)
			end

			if arg_203_1.time_ >= var_206_44 + var_206_45 and arg_203_1.time_ < var_206_44 + var_206_45 + arg_206_0 then
				AnimatorTools.PlayAnimationWithCallback(arg_203_1.timestampAni_, "out", function()
					arg_203_1.timestampController_:SetSelectedState("hide")
				end)
			end

			local var_206_51 = 4.23333333333333

			if var_206_51 < arg_203_1.time_ and arg_203_1.time_ <= var_206_51 + arg_206_0 then
				arg_203_1.mask_.enabled = true
				arg_203_1.mask_.raycastTarget = true

				arg_203_1:SetGaussion(false)
			end

			local var_206_52 = 1.2

			if var_206_51 <= arg_203_1.time_ and arg_203_1.time_ < var_206_51 + var_206_52 then
				local var_206_53 = (arg_203_1.time_ - var_206_51) / var_206_52
				local var_206_54 = Color.New(0, 0, 0)

				var_206_54.a = Mathf.Lerp(0, 1, var_206_53)
				arg_203_1.mask_.color = var_206_54
			end

			if arg_203_1.time_ >= var_206_51 + var_206_52 and arg_203_1.time_ < var_206_51 + var_206_52 + arg_206_0 then
				local var_206_55 = Color.New(0, 0, 0)

				var_206_55.a = 1
				arg_203_1.mask_.color = var_206_55
			end

			local var_206_56 = 5.43333333333333

			if var_206_56 < arg_203_1.time_ and arg_203_1.time_ <= var_206_56 + arg_206_0 then
				arg_203_1.mask_.enabled = true
				arg_203_1.mask_.raycastTarget = true

				arg_203_1:SetGaussion(false)
			end

			local var_206_57 = 1.26666666666667

			if var_206_56 <= arg_203_1.time_ and arg_203_1.time_ < var_206_56 + var_206_57 then
				local var_206_58 = (arg_203_1.time_ - var_206_56) / var_206_57
				local var_206_59 = Color.New(0, 0, 0)

				var_206_59.a = Mathf.Lerp(1, 0, var_206_58)
				arg_203_1.mask_.color = var_206_59
			end

			if arg_203_1.time_ >= var_206_56 + var_206_57 and arg_203_1.time_ < var_206_56 + var_206_57 + arg_206_0 then
				local var_206_60 = Color.New(0, 0, 0)
				local var_206_61 = 0

				arg_203_1.mask_.enabled = false
				var_206_60.a = var_206_61
				arg_203_1.mask_.color = var_206_60
			end

			local var_206_62 = 3.03333333333333

			if var_206_62 < arg_203_1.time_ and arg_203_1.time_ <= var_206_62 + arg_206_0 then
				arg_203_1.allBtn_.enabled = false
			end

			local var_206_63 = 3.9

			if arg_203_1.time_ >= var_206_62 + var_206_63 and arg_203_1.time_ < var_206_62 + var_206_63 + arg_206_0 then
				arg_203_1.allBtn_.enabled = true
			end

			local var_206_64 = 1.2
			local var_206_65 = 1

			if var_206_64 < arg_203_1.time_ and arg_203_1.time_ <= var_206_64 + arg_206_0 then
				local var_206_66 = "play"
				local var_206_67 = "effect"

				arg_203_1:AudioAction(var_206_66, var_206_67, "se_story_142", "se_story_142_amb_city_street", "")
			end

			local var_206_68 = 0.2
			local var_206_69 = 1

			if var_206_68 < arg_203_1.time_ and arg_203_1.time_ <= var_206_68 + arg_206_0 then
				local var_206_70 = "stop"
				local var_206_71 = "effect"

				arg_203_1:AudioAction(var_206_70, var_206_71, "se_story_142", "se_story_142_amb_command room", "")
			end

			if arg_203_1.frameCnt_ <= 1 then
				arg_203_1.dialog_:SetActive(false)
			end

			local var_206_72 = 6.7
			local var_206_73 = 0.35

			if var_206_72 < arg_203_1.time_ and arg_203_1.time_ <= var_206_72 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0

				arg_203_1.dialog_:SetActive(true)

				arg_203_1.dialogCg_.alpha = 0

				local var_206_74 = LeanTween.value(arg_203_1.dialog_, 0, 1, 0.3)

				var_206_74:setOnUpdate(LuaHelper.FloatAction(function(arg_208_0)
					arg_203_1.dialogCg_.alpha = arg_208_0
				end))
				var_206_74:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_203_1.dialog_)
					var_206_74:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_203_1.duration_ = arg_203_1.duration_ + 0.3

				SetActive(arg_203_1.leftNameGo_, true)

				local var_206_75 = arg_203_1:FormatText(StoryNameCfg[23].name)

				arg_203_1.leftNameTxt_.text = var_206_75

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, true)
				arg_203_1.iconController_:SetSelectedState("hero")

				arg_203_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwc")

				arg_203_1.callingController_:SetSelectedState("normal")

				arg_203_1.keyicon_.color = Color.New(1, 1, 1)
				arg_203_1.icon_.color = Color.New(1, 1, 1)

				local var_206_76 = arg_203_1:GetWordFromCfg(304011050)
				local var_206_77 = arg_203_1:FormatText(var_206_76.content)

				arg_203_1.text_.text = var_206_77

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_78 = 14
				local var_206_79 = utf8.len(var_206_77)
				local var_206_80 = var_206_78 <= 0 and var_206_73 or var_206_73 * (var_206_79 / var_206_78)

				if var_206_80 > 0 and var_206_73 < var_206_80 then
					arg_203_1.talkMaxDuration = var_206_80
					var_206_72 = var_206_72 + 0.3

					if var_206_80 + var_206_72 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_80 + var_206_72
					end
				end

				arg_203_1.text_.text = var_206_77
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304011", "304011050", "story_v_out_304011.awb") ~= 0 then
					local var_206_81 = manager.audio:GetVoiceLength("story_v_out_304011", "304011050", "story_v_out_304011.awb") / 1000

					if var_206_81 + var_206_72 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_81 + var_206_72
					end

					if var_206_76.prefab_name ~= "" and arg_203_1.actors_[var_206_76.prefab_name] ~= nil then
						local var_206_82 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_76.prefab_name].transform, "story_v_out_304011", "304011050", "story_v_out_304011.awb")

						arg_203_1:RecordAudio("304011050", var_206_82)
						arg_203_1:RecordAudio("304011050", var_206_82)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_out_304011", "304011050", "story_v_out_304011.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_out_304011", "304011050", "story_v_out_304011.awb")
				end

				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_83 = var_206_72 + 0.3
			local var_206_84 = math.max(var_206_73, arg_203_1.talkMaxDuration)

			if var_206_83 <= arg_203_1.time_ and arg_203_1.time_ < var_206_83 + var_206_84 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_83) / var_206_84

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_83 + var_206_84 and arg_203_1.time_ < var_206_83 + var_206_84 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.23333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_203_1:InitPlayNodeList()
	end,
	Play304011051 = function(arg_210_0, arg_210_1)
		arg_210_1.time_ = 0
		arg_210_1.frameCnt_ = 0
		arg_210_1.state_ = "playing"
		arg_210_1.curTalkId_ = 304011051
		arg_210_1.duration_ = 5

		SetActive(arg_210_1.tipsGo_, false)

		function arg_210_1.onSingleLineFinish_()
			arg_210_1.onSingleLineUpdate_ = nil
			arg_210_1.onSingleLineFinish_ = nil
			arg_210_1.state_ = "waiting"
		end

		function arg_210_1.playNext_(arg_212_0)
			if arg_212_0 == 1 then
				arg_210_0:Play304011052(arg_210_1)
			end
		end

		function arg_210_1.onSingleLineUpdate_(arg_213_0)
			local var_213_0 = 1.2
			local var_213_1 = 1

			if var_213_0 < arg_210_1.time_ and arg_210_1.time_ <= var_213_0 + arg_213_0 then
				local var_213_2 = "play"
				local var_213_3 = "effect"

				arg_210_1:AudioAction(var_213_2, var_213_3, "se_story_152", "se_story_152_camera", "")
			end

			local var_213_4 = 0
			local var_213_5 = 1.175

			if var_213_4 < arg_210_1.time_ and arg_210_1.time_ <= var_213_4 + arg_213_0 then
				arg_210_1.talkMaxDuration = 0
				arg_210_1.dialogCg_.alpha = 1

				arg_210_1.dialog_:SetActive(true)
				SetActive(arg_210_1.leftNameGo_, false)

				arg_210_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_210_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_210_1:RecordName(arg_210_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_210_1.iconTrs_.gameObject, false)
				arg_210_1.callingController_:SetSelectedState("normal")

				local var_213_6 = arg_210_1:GetWordFromCfg(304011051)
				local var_213_7 = arg_210_1:FormatText(var_213_6.content)

				arg_210_1.text_.text = var_213_7

				LuaForUtil.ClearLinePrefixSymbol(arg_210_1.text_)

				local var_213_8 = 47
				local var_213_9 = utf8.len(var_213_7)
				local var_213_10 = var_213_8 <= 0 and var_213_5 or var_213_5 * (var_213_9 / var_213_8)

				if var_213_10 > 0 and var_213_5 < var_213_10 then
					arg_210_1.talkMaxDuration = var_213_10

					if var_213_10 + var_213_4 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_10 + var_213_4
					end
				end

				arg_210_1.text_.text = var_213_7
				arg_210_1.typewritter.percent = 0

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(false)
				arg_210_1:RecordContent(arg_210_1.text_.text)
			end

			local var_213_11 = math.max(var_213_5, arg_210_1.talkMaxDuration)

			if var_213_4 <= arg_210_1.time_ and arg_210_1.time_ < var_213_4 + var_213_11 then
				arg_210_1.typewritter.percent = (arg_210_1.time_ - var_213_4) / var_213_11

				arg_210_1.typewritter:SetDirty()
			end

			if arg_210_1.time_ >= var_213_4 + var_213_11 and arg_210_1.time_ < var_213_4 + var_213_11 + arg_213_0 then
				arg_210_1.typewritter.percent = 1

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(true)
			end
		end

		arg_210_1.nodeConfigList_ = {}

		arg_210_1:InitPlayNodeList()
	end,
	Play304011052 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 304011052
		arg_214_1.duration_ = 5

		SetActive(arg_214_1.tipsGo_, false)

		function arg_214_1.onSingleLineFinish_()
			arg_214_1.onSingleLineUpdate_ = nil
			arg_214_1.onSingleLineFinish_ = nil
			arg_214_1.state_ = "waiting"
		end

		function arg_214_1.playNext_(arg_216_0)
			if arg_216_0 == 1 then
				arg_214_0:Play304011053(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			local var_217_0 = 0
			local var_217_1 = 1.125

			if var_217_0 < arg_214_1.time_ and arg_214_1.time_ <= var_217_0 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0
				arg_214_1.dialogCg_.alpha = 1

				arg_214_1.dialog_:SetActive(true)
				SetActive(arg_214_1.leftNameGo_, false)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_214_1.iconTrs_.gameObject, false)
				arg_214_1.callingController_:SetSelectedState("normal")

				local var_217_2 = arg_214_1:GetWordFromCfg(304011052)
				local var_217_3 = arg_214_1:FormatText(var_217_2.content)

				arg_214_1.text_.text = var_217_3

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_4 = 45
				local var_217_5 = utf8.len(var_217_3)
				local var_217_6 = var_217_4 <= 0 and var_217_1 or var_217_1 * (var_217_5 / var_217_4)

				if var_217_6 > 0 and var_217_1 < var_217_6 then
					arg_214_1.talkMaxDuration = var_217_6

					if var_217_6 + var_217_0 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_6 + var_217_0
					end
				end

				arg_214_1.text_.text = var_217_3
				arg_214_1.typewritter.percent = 0

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(false)
				arg_214_1:RecordContent(arg_214_1.text_.text)
			end

			local var_217_7 = math.max(var_217_1, arg_214_1.talkMaxDuration)

			if var_217_0 <= arg_214_1.time_ and arg_214_1.time_ < var_217_0 + var_217_7 then
				arg_214_1.typewritter.percent = (arg_214_1.time_ - var_217_0) / var_217_7

				arg_214_1.typewritter:SetDirty()
			end

			if arg_214_1.time_ >= var_217_0 + var_217_7 and arg_214_1.time_ < var_217_0 + var_217_7 + arg_217_0 then
				arg_214_1.typewritter.percent = 1

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(true)
			end
		end

		arg_214_1.nodeConfigList_ = {}

		arg_214_1:InitPlayNodeList()
	end,
	Play304011053 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 304011053
		arg_218_1.duration_ = 8.3

		local var_218_0 = {
			zh = 8.166,
			ja = 8.3
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
				arg_218_0:Play304011054(arg_218_1)
			end
		end

		function arg_218_1.onSingleLineUpdate_(arg_221_0)
			local var_221_0 = 0
			local var_221_1 = 1.025

			if var_221_0 < arg_218_1.time_ and arg_218_1.time_ <= var_221_0 + arg_221_0 then
				arg_218_1.talkMaxDuration = 0
				arg_218_1.dialogCg_.alpha = 1

				arg_218_1.dialog_:SetActive(true)
				SetActive(arg_218_1.leftNameGo_, true)

				local var_221_2 = arg_218_1:FormatText(StoryNameCfg[23].name)

				arg_218_1.leftNameTxt_.text = var_221_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_218_1.leftNameTxt_.transform)

				arg_218_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_218_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_218_1:RecordName(arg_218_1.leftNameTxt_.text)
				SetActive(arg_218_1.iconTrs_.gameObject, true)
				arg_218_1.iconController_:SetSelectedState("hero")

				arg_218_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwc")

				arg_218_1.callingController_:SetSelectedState("normal")

				arg_218_1.keyicon_.color = Color.New(1, 1, 1)
				arg_218_1.icon_.color = Color.New(1, 1, 1)

				local var_221_3 = arg_218_1:GetWordFromCfg(304011053)
				local var_221_4 = arg_218_1:FormatText(var_221_3.content)

				arg_218_1.text_.text = var_221_4

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_5 = 41
				local var_221_6 = utf8.len(var_221_4)
				local var_221_7 = var_221_5 <= 0 and var_221_1 or var_221_1 * (var_221_6 / var_221_5)

				if var_221_7 > 0 and var_221_1 < var_221_7 then
					arg_218_1.talkMaxDuration = var_221_7

					if var_221_7 + var_221_0 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_7 + var_221_0
					end
				end

				arg_218_1.text_.text = var_221_4
				arg_218_1.typewritter.percent = 0

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304011", "304011053", "story_v_out_304011.awb") ~= 0 then
					local var_221_8 = manager.audio:GetVoiceLength("story_v_out_304011", "304011053", "story_v_out_304011.awb") / 1000

					if var_221_8 + var_221_0 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_8 + var_221_0
					end

					if var_221_3.prefab_name ~= "" and arg_218_1.actors_[var_221_3.prefab_name] ~= nil then
						local var_221_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_218_1.actors_[var_221_3.prefab_name].transform, "story_v_out_304011", "304011053", "story_v_out_304011.awb")

						arg_218_1:RecordAudio("304011053", var_221_9)
						arg_218_1:RecordAudio("304011053", var_221_9)
					else
						arg_218_1:AudioAction("play", "voice", "story_v_out_304011", "304011053", "story_v_out_304011.awb")
					end

					arg_218_1:RecordHistoryTalkVoice("story_v_out_304011", "304011053", "story_v_out_304011.awb")
				end

				arg_218_1:RecordContent(arg_218_1.text_.text)
			end

			local var_221_10 = math.max(var_221_1, arg_218_1.talkMaxDuration)

			if var_221_0 <= arg_218_1.time_ and arg_218_1.time_ < var_221_0 + var_221_10 then
				arg_218_1.typewritter.percent = (arg_218_1.time_ - var_221_0) / var_221_10

				arg_218_1.typewritter:SetDirty()
			end

			if arg_218_1.time_ >= var_221_0 + var_221_10 and arg_218_1.time_ < var_221_0 + var_221_10 + arg_221_0 then
				arg_218_1.typewritter.percent = 1

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(true)
			end
		end

		arg_218_1.nodeConfigList_ = {}

		arg_218_1:InitPlayNodeList()
	end,
	Play304011054 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 304011054
		arg_222_1.duration_ = 8.67

		local var_222_0 = {
			zh = 8.666,
			ja = 8.6
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
				arg_222_0:Play304011055(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			local var_225_0 = "10001_tpose"

			if arg_222_1.actors_[var_225_0] == nil then
				local var_225_1 = Asset.Load("Char/" .. "10001_tpose")

				if not isNil(var_225_1) then
					local var_225_2 = Object.Instantiate(Asset.Load("Char/" .. "10001_tpose"), arg_222_1.stage_.transform)

					var_225_2.name = var_225_0
					var_225_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_222_1.actors_[var_225_0] = var_225_2

					local var_225_3 = var_225_2:GetComponentInChildren(typeof(CharacterEffect))

					var_225_3.enabled = true

					local var_225_4 = GameObjectTools.GetOrAddComponent(var_225_2, typeof(DynamicBoneHelper))

					if var_225_4 then
						var_225_4:EnableDynamicBone(false)
					end

					arg_222_1:ShowWeapon(var_225_3.transform, false)

					arg_222_1.var_[var_225_0 .. "Animator"] = var_225_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_222_1.var_[var_225_0 .. "Animator"].applyRootMotion = true
					arg_222_1.var_[var_225_0 .. "LipSync"] = var_225_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_225_5 = arg_222_1.actors_["10001_tpose"].transform
			local var_225_6 = 0

			if var_225_6 < arg_222_1.time_ and arg_222_1.time_ <= var_225_6 + arg_225_0 then
				arg_222_1.var_.moveOldPos10001_tpose = var_225_5.localPosition

				local var_225_7 = GameObjectTools.GetOrAddComponent(var_225_5.gameObject, typeof(DynamicBoneHelper))

				if var_225_7 then
					var_225_7:EnableDynamicBone(false)
				end
			end

			local var_225_8 = 0.001

			if var_225_6 <= arg_222_1.time_ and arg_222_1.time_ < var_225_6 + var_225_8 then
				local var_225_9 = (arg_222_1.time_ - var_225_6) / var_225_8
				local var_225_10 = Vector3.New(0, -1.23, -5.8)

				var_225_5.localPosition = Vector3.Lerp(arg_222_1.var_.moveOldPos10001_tpose, var_225_10, var_225_9)

				local var_225_11 = manager.ui.mainCamera.transform.position - var_225_5.position

				var_225_5.forward = Vector3.New(var_225_11.x, var_225_11.y, var_225_11.z)

				local var_225_12 = var_225_5.localEulerAngles

				var_225_12.z = 0
				var_225_12.x = 0
				var_225_5.localEulerAngles = var_225_12
			end

			if arg_222_1.time_ >= var_225_6 + var_225_8 and arg_222_1.time_ < var_225_6 + var_225_8 + arg_225_0 then
				var_225_5.localPosition = Vector3.New(0, -1.23, -5.8)

				local var_225_13 = manager.ui.mainCamera.transform.position - var_225_5.position

				var_225_5.forward = Vector3.New(var_225_13.x, var_225_13.y, var_225_13.z)

				local var_225_14 = var_225_5.localEulerAngles

				var_225_14.z = 0
				var_225_14.x = 0
				var_225_5.localEulerAngles = var_225_14

				local var_225_15 = GameObjectTools.GetOrAddComponent(var_225_5.gameObject, typeof(DynamicBoneHelper))

				if var_225_15 then
					var_225_15:EnableDynamicBone(true)
				end
			end

			local var_225_16 = arg_222_1.actors_["10001_tpose"]
			local var_225_17 = 0

			if var_225_17 < arg_222_1.time_ and arg_222_1.time_ <= var_225_17 + arg_225_0 and not isNil(var_225_16) and arg_222_1.var_.characterEffect10001_tpose == nil then
				arg_222_1.var_.characterEffect10001_tpose = var_225_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_225_18 = 0.200000002980232

			if var_225_17 <= arg_222_1.time_ and arg_222_1.time_ < var_225_17 + var_225_18 and not isNil(var_225_16) then
				local var_225_19 = (arg_222_1.time_ - var_225_17) / var_225_18

				if arg_222_1.var_.characterEffect10001_tpose and not isNil(var_225_16) then
					arg_222_1.var_.characterEffect10001_tpose.fillFlat = false
				end
			end

			if arg_222_1.time_ >= var_225_17 + var_225_18 and arg_222_1.time_ < var_225_17 + var_225_18 + arg_225_0 and not isNil(var_225_16) and arg_222_1.var_.characterEffect10001_tpose then
				arg_222_1.var_.characterEffect10001_tpose.fillFlat = false
			end

			local var_225_20 = 0

			if var_225_20 < arg_222_1.time_ and arg_222_1.time_ <= var_225_20 + arg_225_0 then
				arg_222_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/story10001/story10001action/10001action4_1")
			end

			local var_225_21 = 0

			if var_225_21 < arg_222_1.time_ and arg_222_1.time_ <= var_225_21 + arg_225_0 then
				arg_222_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_225_22 = 0
			local var_225_23 = 1.025

			if var_225_22 < arg_222_1.time_ and arg_222_1.time_ <= var_225_22 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0
				arg_222_1.dialogCg_.alpha = 1

				arg_222_1.dialog_:SetActive(true)
				SetActive(arg_222_1.leftNameGo_, true)

				local var_225_24 = arg_222_1:FormatText(StoryNameCfg[24].name)

				arg_222_1.leftNameTxt_.text = var_225_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_222_1.leftNameTxt_.transform)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1.leftNameTxt_.text)
				SetActive(arg_222_1.iconTrs_.gameObject, false)
				arg_222_1.callingController_:SetSelectedState("normal")

				local var_225_25 = arg_222_1:GetWordFromCfg(304011054)
				local var_225_26 = arg_222_1:FormatText(var_225_25.content)

				arg_222_1.text_.text = var_225_26

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_27 = 41
				local var_225_28 = utf8.len(var_225_26)
				local var_225_29 = var_225_27 <= 0 and var_225_23 or var_225_23 * (var_225_28 / var_225_27)

				if var_225_29 > 0 and var_225_23 < var_225_29 then
					arg_222_1.talkMaxDuration = var_225_29

					if var_225_29 + var_225_22 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_29 + var_225_22
					end
				end

				arg_222_1.text_.text = var_225_26
				arg_222_1.typewritter.percent = 0

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304011", "304011054", "story_v_out_304011.awb") ~= 0 then
					local var_225_30 = manager.audio:GetVoiceLength("story_v_out_304011", "304011054", "story_v_out_304011.awb") / 1000

					if var_225_30 + var_225_22 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_30 + var_225_22
					end

					if var_225_25.prefab_name ~= "" and arg_222_1.actors_[var_225_25.prefab_name] ~= nil then
						local var_225_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_222_1.actors_[var_225_25.prefab_name].transform, "story_v_out_304011", "304011054", "story_v_out_304011.awb")

						arg_222_1:RecordAudio("304011054", var_225_31)
						arg_222_1:RecordAudio("304011054", var_225_31)
					else
						arg_222_1:AudioAction("play", "voice", "story_v_out_304011", "304011054", "story_v_out_304011.awb")
					end

					arg_222_1:RecordHistoryTalkVoice("story_v_out_304011", "304011054", "story_v_out_304011.awb")
				end

				arg_222_1:RecordContent(arg_222_1.text_.text)
			end

			local var_225_32 = math.max(var_225_23, arg_222_1.talkMaxDuration)

			if var_225_22 <= arg_222_1.time_ and arg_222_1.time_ < var_225_22 + var_225_32 then
				arg_222_1.typewritter.percent = (arg_222_1.time_ - var_225_22) / var_225_32

				arg_222_1.typewritter:SetDirty()
			end

			if arg_222_1.time_ >= var_225_22 + var_225_32 and arg_222_1.time_ < var_225_22 + var_225_32 + arg_225_0 then
				arg_222_1.typewritter.percent = 1

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(true)
			end
		end

		arg_222_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10001_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_222_1:InitPlayNodeList()
	end,
	Play304011055 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 304011055
		arg_226_1.duration_ = 12.2

		local var_226_0 = {
			zh = 12.2,
			ja = 12.033
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
				arg_226_0:Play304011056(arg_226_1)
			end
		end

		function arg_226_1.onSingleLineUpdate_(arg_229_0)
			local var_229_0 = arg_226_1.actors_["10001_tpose"]
			local var_229_1 = 0

			if var_229_1 < arg_226_1.time_ and arg_226_1.time_ <= var_229_1 + arg_229_0 and not isNil(var_229_0) and arg_226_1.var_.characterEffect10001_tpose == nil then
				arg_226_1.var_.characterEffect10001_tpose = var_229_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_229_2 = 0.200000002980232

			if var_229_1 <= arg_226_1.time_ and arg_226_1.time_ < var_229_1 + var_229_2 and not isNil(var_229_0) then
				local var_229_3 = (arg_226_1.time_ - var_229_1) / var_229_2

				if arg_226_1.var_.characterEffect10001_tpose and not isNil(var_229_0) then
					local var_229_4 = Mathf.Lerp(0, 0.5, var_229_3)

					arg_226_1.var_.characterEffect10001_tpose.fillFlat = true
					arg_226_1.var_.characterEffect10001_tpose.fillRatio = var_229_4
				end
			end

			if arg_226_1.time_ >= var_229_1 + var_229_2 and arg_226_1.time_ < var_229_1 + var_229_2 + arg_229_0 and not isNil(var_229_0) and arg_226_1.var_.characterEffect10001_tpose then
				local var_229_5 = 0.5

				arg_226_1.var_.characterEffect10001_tpose.fillFlat = true
				arg_226_1.var_.characterEffect10001_tpose.fillRatio = var_229_5
			end

			local var_229_6 = 0
			local var_229_7 = 1.575

			if var_229_6 < arg_226_1.time_ and arg_226_1.time_ <= var_229_6 + arg_229_0 then
				arg_226_1.talkMaxDuration = 0
				arg_226_1.dialogCg_.alpha = 1

				arg_226_1.dialog_:SetActive(true)
				SetActive(arg_226_1.leftNameGo_, true)

				local var_229_8 = arg_226_1:FormatText(StoryNameCfg[25].name)

				arg_226_1.leftNameTxt_.text = var_229_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_226_1.leftNameTxt_.transform)

				arg_226_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_226_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_226_1:RecordName(arg_226_1.leftNameTxt_.text)
				SetActive(arg_226_1.iconTrs_.gameObject, true)
				arg_226_1.iconController_:SetSelectedState("hero")

				arg_226_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_clerkb")

				arg_226_1.callingController_:SetSelectedState("normal")

				arg_226_1.keyicon_.color = Color.New(1, 1, 1)
				arg_226_1.icon_.color = Color.New(1, 1, 1)

				local var_229_9 = arg_226_1:GetWordFromCfg(304011055)
				local var_229_10 = arg_226_1:FormatText(var_229_9.content)

				arg_226_1.text_.text = var_229_10

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_11 = 63
				local var_229_12 = utf8.len(var_229_10)
				local var_229_13 = var_229_11 <= 0 and var_229_7 or var_229_7 * (var_229_12 / var_229_11)

				if var_229_13 > 0 and var_229_7 < var_229_13 then
					arg_226_1.talkMaxDuration = var_229_13

					if var_229_13 + var_229_6 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_13 + var_229_6
					end
				end

				arg_226_1.text_.text = var_229_10
				arg_226_1.typewritter.percent = 0

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304011", "304011055", "story_v_out_304011.awb") ~= 0 then
					local var_229_14 = manager.audio:GetVoiceLength("story_v_out_304011", "304011055", "story_v_out_304011.awb") / 1000

					if var_229_14 + var_229_6 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_14 + var_229_6
					end

					if var_229_9.prefab_name ~= "" and arg_226_1.actors_[var_229_9.prefab_name] ~= nil then
						local var_229_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_226_1.actors_[var_229_9.prefab_name].transform, "story_v_out_304011", "304011055", "story_v_out_304011.awb")

						arg_226_1:RecordAudio("304011055", var_229_15)
						arg_226_1:RecordAudio("304011055", var_229_15)
					else
						arg_226_1:AudioAction("play", "voice", "story_v_out_304011", "304011055", "story_v_out_304011.awb")
					end

					arg_226_1:RecordHistoryTalkVoice("story_v_out_304011", "304011055", "story_v_out_304011.awb")
				end

				arg_226_1:RecordContent(arg_226_1.text_.text)
			end

			local var_229_16 = math.max(var_229_7, arg_226_1.talkMaxDuration)

			if var_229_6 <= arg_226_1.time_ and arg_226_1.time_ < var_229_6 + var_229_16 then
				arg_226_1.typewritter.percent = (arg_226_1.time_ - var_229_6) / var_229_16

				arg_226_1.typewritter:SetDirty()
			end

			if arg_226_1.time_ >= var_229_6 + var_229_16 and arg_226_1.time_ < var_229_6 + var_229_16 + arg_229_0 then
				arg_226_1.typewritter.percent = 1

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(true)
			end
		end

		arg_226_1.nodeConfigList_ = {}

		arg_226_1:InitPlayNodeList()
	end,
	Play304011056 = function(arg_230_0, arg_230_1)
		arg_230_1.time_ = 0
		arg_230_1.frameCnt_ = 0
		arg_230_1.state_ = "playing"
		arg_230_1.curTalkId_ = 304011056
		arg_230_1.duration_ = 11.8

		local var_230_0 = {
			zh = 8.066,
			ja = 11.8
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
				arg_230_0:Play304011057(arg_230_1)
			end
		end

		function arg_230_1.onSingleLineUpdate_(arg_233_0)
			local var_233_0 = arg_230_1.actors_["10001_tpose"]
			local var_233_1 = 0

			if var_233_1 < arg_230_1.time_ and arg_230_1.time_ <= var_233_1 + arg_233_0 and not isNil(var_233_0) and arg_230_1.var_.characterEffect10001_tpose == nil then
				arg_230_1.var_.characterEffect10001_tpose = var_233_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_233_2 = 0.200000002980232

			if var_233_1 <= arg_230_1.time_ and arg_230_1.time_ < var_233_1 + var_233_2 and not isNil(var_233_0) then
				local var_233_3 = (arg_230_1.time_ - var_233_1) / var_233_2

				if arg_230_1.var_.characterEffect10001_tpose and not isNil(var_233_0) then
					arg_230_1.var_.characterEffect10001_tpose.fillFlat = false
				end
			end

			if arg_230_1.time_ >= var_233_1 + var_233_2 and arg_230_1.time_ < var_233_1 + var_233_2 + arg_233_0 and not isNil(var_233_0) and arg_230_1.var_.characterEffect10001_tpose then
				arg_230_1.var_.characterEffect10001_tpose.fillFlat = false
			end

			local var_233_4 = 0

			if var_233_4 < arg_230_1.time_ and arg_230_1.time_ <= var_233_4 + arg_233_0 then
				arg_230_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/story10001/story10001actionlink/10001action442")
			end

			local var_233_5 = 0

			if var_233_5 < arg_230_1.time_ and arg_230_1.time_ <= var_233_5 + arg_233_0 then
				arg_230_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_233_6 = 0
			local var_233_7 = 0.825

			if var_233_6 < arg_230_1.time_ and arg_230_1.time_ <= var_233_6 + arg_233_0 then
				arg_230_1.talkMaxDuration = 0
				arg_230_1.dialogCg_.alpha = 1

				arg_230_1.dialog_:SetActive(true)
				SetActive(arg_230_1.leftNameGo_, true)

				local var_233_8 = arg_230_1:FormatText(StoryNameCfg[24].name)

				arg_230_1.leftNameTxt_.text = var_233_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_230_1.leftNameTxt_.transform)

				arg_230_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_230_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_230_1:RecordName(arg_230_1.leftNameTxt_.text)
				SetActive(arg_230_1.iconTrs_.gameObject, false)
				arg_230_1.callingController_:SetSelectedState("normal")

				local var_233_9 = arg_230_1:GetWordFromCfg(304011056)
				local var_233_10 = arg_230_1:FormatText(var_233_9.content)

				arg_230_1.text_.text = var_233_10

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_11 = 33
				local var_233_12 = utf8.len(var_233_10)
				local var_233_13 = var_233_11 <= 0 and var_233_7 or var_233_7 * (var_233_12 / var_233_11)

				if var_233_13 > 0 and var_233_7 < var_233_13 then
					arg_230_1.talkMaxDuration = var_233_13

					if var_233_13 + var_233_6 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_13 + var_233_6
					end
				end

				arg_230_1.text_.text = var_233_10
				arg_230_1.typewritter.percent = 0

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304011", "304011056", "story_v_out_304011.awb") ~= 0 then
					local var_233_14 = manager.audio:GetVoiceLength("story_v_out_304011", "304011056", "story_v_out_304011.awb") / 1000

					if var_233_14 + var_233_6 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_14 + var_233_6
					end

					if var_233_9.prefab_name ~= "" and arg_230_1.actors_[var_233_9.prefab_name] ~= nil then
						local var_233_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_230_1.actors_[var_233_9.prefab_name].transform, "story_v_out_304011", "304011056", "story_v_out_304011.awb")

						arg_230_1:RecordAudio("304011056", var_233_15)
						arg_230_1:RecordAudio("304011056", var_233_15)
					else
						arg_230_1:AudioAction("play", "voice", "story_v_out_304011", "304011056", "story_v_out_304011.awb")
					end

					arg_230_1:RecordHistoryTalkVoice("story_v_out_304011", "304011056", "story_v_out_304011.awb")
				end

				arg_230_1:RecordContent(arg_230_1.text_.text)
			end

			local var_233_16 = math.max(var_233_7, arg_230_1.talkMaxDuration)

			if var_233_6 <= arg_230_1.time_ and arg_230_1.time_ < var_233_6 + var_233_16 then
				arg_230_1.typewritter.percent = (arg_230_1.time_ - var_233_6) / var_233_16

				arg_230_1.typewritter:SetDirty()
			end

			if arg_230_1.time_ >= var_233_6 + var_233_16 and arg_230_1.time_ < var_233_6 + var_233_16 + arg_233_0 then
				arg_230_1.typewritter.percent = 1

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(true)
			end
		end

		arg_230_1.nodeConfigList_ = {}

		arg_230_1:InitPlayNodeList()
	end,
	Play304011057 = function(arg_234_0, arg_234_1)
		arg_234_1.time_ = 0
		arg_234_1.frameCnt_ = 0
		arg_234_1.state_ = "playing"
		arg_234_1.curTalkId_ = 304011057
		arg_234_1.duration_ = 7.13

		local var_234_0 = {
			zh = 4.433,
			ja = 7.133
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
				arg_234_0:Play304011058(arg_234_1)
			end
		end

		function arg_234_1.onSingleLineUpdate_(arg_237_0)
			local var_237_0 = arg_234_1.actors_["10001_tpose"]
			local var_237_1 = 0

			if var_237_1 < arg_234_1.time_ and arg_234_1.time_ <= var_237_1 + arg_237_0 and not isNil(var_237_0) and arg_234_1.var_.characterEffect10001_tpose == nil then
				arg_234_1.var_.characterEffect10001_tpose = var_237_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_237_2 = 0.200000002980232

			if var_237_1 <= arg_234_1.time_ and arg_234_1.time_ < var_237_1 + var_237_2 and not isNil(var_237_0) then
				local var_237_3 = (arg_234_1.time_ - var_237_1) / var_237_2

				if arg_234_1.var_.characterEffect10001_tpose and not isNil(var_237_0) then
					local var_237_4 = Mathf.Lerp(0, 0.5, var_237_3)

					arg_234_1.var_.characterEffect10001_tpose.fillFlat = true
					arg_234_1.var_.characterEffect10001_tpose.fillRatio = var_237_4
				end
			end

			if arg_234_1.time_ >= var_237_1 + var_237_2 and arg_234_1.time_ < var_237_1 + var_237_2 + arg_237_0 and not isNil(var_237_0) and arg_234_1.var_.characterEffect10001_tpose then
				local var_237_5 = 0.5

				arg_234_1.var_.characterEffect10001_tpose.fillFlat = true
				arg_234_1.var_.characterEffect10001_tpose.fillRatio = var_237_5
			end

			local var_237_6 = 0
			local var_237_7 = 0.525

			if var_237_6 < arg_234_1.time_ and arg_234_1.time_ <= var_237_6 + arg_237_0 then
				arg_234_1.talkMaxDuration = 0
				arg_234_1.dialogCg_.alpha = 1

				arg_234_1.dialog_:SetActive(true)
				SetActive(arg_234_1.leftNameGo_, true)

				local var_237_8 = arg_234_1:FormatText(StoryNameCfg[25].name)

				arg_234_1.leftNameTxt_.text = var_237_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_234_1.leftNameTxt_.transform)

				arg_234_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_234_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_234_1:RecordName(arg_234_1.leftNameTxt_.text)
				SetActive(arg_234_1.iconTrs_.gameObject, true)
				arg_234_1.iconController_:SetSelectedState("hero")

				arg_234_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_clerkb")

				arg_234_1.callingController_:SetSelectedState("normal")

				arg_234_1.keyicon_.color = Color.New(1, 1, 1)
				arg_234_1.icon_.color = Color.New(1, 1, 1)

				local var_237_9 = arg_234_1:GetWordFromCfg(304011057)
				local var_237_10 = arg_234_1:FormatText(var_237_9.content)

				arg_234_1.text_.text = var_237_10

				LuaForUtil.ClearLinePrefixSymbol(arg_234_1.text_)

				local var_237_11 = 21
				local var_237_12 = utf8.len(var_237_10)
				local var_237_13 = var_237_11 <= 0 and var_237_7 or var_237_7 * (var_237_12 / var_237_11)

				if var_237_13 > 0 and var_237_7 < var_237_13 then
					arg_234_1.talkMaxDuration = var_237_13

					if var_237_13 + var_237_6 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_13 + var_237_6
					end
				end

				arg_234_1.text_.text = var_237_10
				arg_234_1.typewritter.percent = 0

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304011", "304011057", "story_v_out_304011.awb") ~= 0 then
					local var_237_14 = manager.audio:GetVoiceLength("story_v_out_304011", "304011057", "story_v_out_304011.awb") / 1000

					if var_237_14 + var_237_6 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_14 + var_237_6
					end

					if var_237_9.prefab_name ~= "" and arg_234_1.actors_[var_237_9.prefab_name] ~= nil then
						local var_237_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_234_1.actors_[var_237_9.prefab_name].transform, "story_v_out_304011", "304011057", "story_v_out_304011.awb")

						arg_234_1:RecordAudio("304011057", var_237_15)
						arg_234_1:RecordAudio("304011057", var_237_15)
					else
						arg_234_1:AudioAction("play", "voice", "story_v_out_304011", "304011057", "story_v_out_304011.awb")
					end

					arg_234_1:RecordHistoryTalkVoice("story_v_out_304011", "304011057", "story_v_out_304011.awb")
				end

				arg_234_1:RecordContent(arg_234_1.text_.text)
			end

			local var_237_16 = math.max(var_237_7, arg_234_1.talkMaxDuration)

			if var_237_6 <= arg_234_1.time_ and arg_234_1.time_ < var_237_6 + var_237_16 then
				arg_234_1.typewritter.percent = (arg_234_1.time_ - var_237_6) / var_237_16

				arg_234_1.typewritter:SetDirty()
			end

			if arg_234_1.time_ >= var_237_6 + var_237_16 and arg_234_1.time_ < var_237_6 + var_237_16 + arg_237_0 then
				arg_234_1.typewritter.percent = 1

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(true)
			end
		end

		arg_234_1.nodeConfigList_ = {}

		arg_234_1:InitPlayNodeList()
	end,
	Play304011058 = function(arg_238_0, arg_238_1)
		arg_238_1.time_ = 0
		arg_238_1.frameCnt_ = 0
		arg_238_1.state_ = "playing"
		arg_238_1.curTalkId_ = 304011058
		arg_238_1.duration_ = 13

		local var_238_0 = {
			zh = 10.733,
			ja = 13
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
				arg_238_0:Play304011059(arg_238_1)
			end
		end

		function arg_238_1.onSingleLineUpdate_(arg_241_0)
			local var_241_0 = arg_238_1.actors_["10001_tpose"]
			local var_241_1 = 0

			if var_241_1 < arg_238_1.time_ and arg_238_1.time_ <= var_241_1 + arg_241_0 and not isNil(var_241_0) and arg_238_1.var_.characterEffect10001_tpose == nil then
				arg_238_1.var_.characterEffect10001_tpose = var_241_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_241_2 = 0.200000002980232

			if var_241_1 <= arg_238_1.time_ and arg_238_1.time_ < var_241_1 + var_241_2 and not isNil(var_241_0) then
				local var_241_3 = (arg_238_1.time_ - var_241_1) / var_241_2

				if arg_238_1.var_.characterEffect10001_tpose and not isNil(var_241_0) then
					arg_238_1.var_.characterEffect10001_tpose.fillFlat = false
				end
			end

			if arg_238_1.time_ >= var_241_1 + var_241_2 and arg_238_1.time_ < var_241_1 + var_241_2 + arg_241_0 and not isNil(var_241_0) and arg_238_1.var_.characterEffect10001_tpose then
				arg_238_1.var_.characterEffect10001_tpose.fillFlat = false
			end

			local var_241_4 = 0
			local var_241_5 = 1.125

			if var_241_4 < arg_238_1.time_ and arg_238_1.time_ <= var_241_4 + arg_241_0 then
				arg_238_1.talkMaxDuration = 0
				arg_238_1.dialogCg_.alpha = 1

				arg_238_1.dialog_:SetActive(true)
				SetActive(arg_238_1.leftNameGo_, true)

				local var_241_6 = arg_238_1:FormatText(StoryNameCfg[24].name)

				arg_238_1.leftNameTxt_.text = var_241_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_238_1.leftNameTxt_.transform)

				arg_238_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_238_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_238_1:RecordName(arg_238_1.leftNameTxt_.text)
				SetActive(arg_238_1.iconTrs_.gameObject, false)
				arg_238_1.callingController_:SetSelectedState("normal")

				local var_241_7 = arg_238_1:GetWordFromCfg(304011058)
				local var_241_8 = arg_238_1:FormatText(var_241_7.content)

				arg_238_1.text_.text = var_241_8

				LuaForUtil.ClearLinePrefixSymbol(arg_238_1.text_)

				local var_241_9 = 45
				local var_241_10 = utf8.len(var_241_8)
				local var_241_11 = var_241_9 <= 0 and var_241_5 or var_241_5 * (var_241_10 / var_241_9)

				if var_241_11 > 0 and var_241_5 < var_241_11 then
					arg_238_1.talkMaxDuration = var_241_11

					if var_241_11 + var_241_4 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_11 + var_241_4
					end
				end

				arg_238_1.text_.text = var_241_8
				arg_238_1.typewritter.percent = 0

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304011", "304011058", "story_v_out_304011.awb") ~= 0 then
					local var_241_12 = manager.audio:GetVoiceLength("story_v_out_304011", "304011058", "story_v_out_304011.awb") / 1000

					if var_241_12 + var_241_4 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_12 + var_241_4
					end

					if var_241_7.prefab_name ~= "" and arg_238_1.actors_[var_241_7.prefab_name] ~= nil then
						local var_241_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_238_1.actors_[var_241_7.prefab_name].transform, "story_v_out_304011", "304011058", "story_v_out_304011.awb")

						arg_238_1:RecordAudio("304011058", var_241_13)
						arg_238_1:RecordAudio("304011058", var_241_13)
					else
						arg_238_1:AudioAction("play", "voice", "story_v_out_304011", "304011058", "story_v_out_304011.awb")
					end

					arg_238_1:RecordHistoryTalkVoice("story_v_out_304011", "304011058", "story_v_out_304011.awb")
				end

				arg_238_1:RecordContent(arg_238_1.text_.text)
			end

			local var_241_14 = math.max(var_241_5, arg_238_1.talkMaxDuration)

			if var_241_4 <= arg_238_1.time_ and arg_238_1.time_ < var_241_4 + var_241_14 then
				arg_238_1.typewritter.percent = (arg_238_1.time_ - var_241_4) / var_241_14

				arg_238_1.typewritter:SetDirty()
			end

			if arg_238_1.time_ >= var_241_4 + var_241_14 and arg_238_1.time_ < var_241_4 + var_241_14 + arg_241_0 then
				arg_238_1.typewritter.percent = 1

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(true)
			end
		end

		arg_238_1.nodeConfigList_ = {}

		arg_238_1:InitPlayNodeList()
	end,
	Play304011059 = function(arg_242_0, arg_242_1)
		arg_242_1.time_ = 0
		arg_242_1.frameCnt_ = 0
		arg_242_1.state_ = "playing"
		arg_242_1.curTalkId_ = 304011059
		arg_242_1.duration_ = 5.43

		local var_242_0 = {
			zh = 5.433,
			ja = 5.133
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
				arg_242_0:Play304011060(arg_242_1)
			end
		end

		function arg_242_1.onSingleLineUpdate_(arg_245_0)
			local var_245_0 = arg_242_1.actors_["10001_tpose"]
			local var_245_1 = 0

			if var_245_1 < arg_242_1.time_ and arg_242_1.time_ <= var_245_1 + arg_245_0 and not isNil(var_245_0) and arg_242_1.var_.characterEffect10001_tpose == nil then
				arg_242_1.var_.characterEffect10001_tpose = var_245_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_245_2 = 0.200000002980232

			if var_245_1 <= arg_242_1.time_ and arg_242_1.time_ < var_245_1 + var_245_2 and not isNil(var_245_0) then
				local var_245_3 = (arg_242_1.time_ - var_245_1) / var_245_2

				if arg_242_1.var_.characterEffect10001_tpose and not isNil(var_245_0) then
					local var_245_4 = Mathf.Lerp(0, 0.5, var_245_3)

					arg_242_1.var_.characterEffect10001_tpose.fillFlat = true
					arg_242_1.var_.characterEffect10001_tpose.fillRatio = var_245_4
				end
			end

			if arg_242_1.time_ >= var_245_1 + var_245_2 and arg_242_1.time_ < var_245_1 + var_245_2 + arg_245_0 and not isNil(var_245_0) and arg_242_1.var_.characterEffect10001_tpose then
				local var_245_5 = 0.5

				arg_242_1.var_.characterEffect10001_tpose.fillFlat = true
				arg_242_1.var_.characterEffect10001_tpose.fillRatio = var_245_5
			end

			local var_245_6 = 0
			local var_245_7 = 0.625

			if var_245_6 < arg_242_1.time_ and arg_242_1.time_ <= var_245_6 + arg_245_0 then
				arg_242_1.talkMaxDuration = 0
				arg_242_1.dialogCg_.alpha = 1

				arg_242_1.dialog_:SetActive(true)
				SetActive(arg_242_1.leftNameGo_, true)

				local var_245_8 = arg_242_1:FormatText(StoryNameCfg[23].name)

				arg_242_1.leftNameTxt_.text = var_245_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_242_1.leftNameTxt_.transform)

				arg_242_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_242_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_242_1:RecordName(arg_242_1.leftNameTxt_.text)
				SetActive(arg_242_1.iconTrs_.gameObject, true)
				arg_242_1.iconController_:SetSelectedState("hero")

				arg_242_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwc")

				arg_242_1.callingController_:SetSelectedState("normal")

				arg_242_1.keyicon_.color = Color.New(1, 1, 1)
				arg_242_1.icon_.color = Color.New(1, 1, 1)

				local var_245_9 = arg_242_1:GetWordFromCfg(304011059)
				local var_245_10 = arg_242_1:FormatText(var_245_9.content)

				arg_242_1.text_.text = var_245_10

				LuaForUtil.ClearLinePrefixSymbol(arg_242_1.text_)

				local var_245_11 = 25
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

				if manager.audio:GetVoiceLength("story_v_out_304011", "304011059", "story_v_out_304011.awb") ~= 0 then
					local var_245_14 = manager.audio:GetVoiceLength("story_v_out_304011", "304011059", "story_v_out_304011.awb") / 1000

					if var_245_14 + var_245_6 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_14 + var_245_6
					end

					if var_245_9.prefab_name ~= "" and arg_242_1.actors_[var_245_9.prefab_name] ~= nil then
						local var_245_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_242_1.actors_[var_245_9.prefab_name].transform, "story_v_out_304011", "304011059", "story_v_out_304011.awb")

						arg_242_1:RecordAudio("304011059", var_245_15)
						arg_242_1:RecordAudio("304011059", var_245_15)
					else
						arg_242_1:AudioAction("play", "voice", "story_v_out_304011", "304011059", "story_v_out_304011.awb")
					end

					arg_242_1:RecordHistoryTalkVoice("story_v_out_304011", "304011059", "story_v_out_304011.awb")
				end

				arg_242_1:RecordContent(arg_242_1.text_.text)
			end

			local var_245_16 = math.max(var_245_7, arg_242_1.talkMaxDuration)

			if var_245_6 <= arg_242_1.time_ and arg_242_1.time_ < var_245_6 + var_245_16 then
				arg_242_1.typewritter.percent = (arg_242_1.time_ - var_245_6) / var_245_16

				arg_242_1.typewritter:SetDirty()
			end

			if arg_242_1.time_ >= var_245_6 + var_245_16 and arg_242_1.time_ < var_245_6 + var_245_16 + arg_245_0 then
				arg_242_1.typewritter.percent = 1

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(true)
			end
		end

		arg_242_1.nodeConfigList_ = {}

		arg_242_1:InitPlayNodeList()
	end,
	Play304011060 = function(arg_246_0, arg_246_1)
		arg_246_1.time_ = 0
		arg_246_1.frameCnt_ = 0
		arg_246_1.state_ = "playing"
		arg_246_1.curTalkId_ = 304011060
		arg_246_1.duration_ = 7.1

		local var_246_0 = {
			zh = 4.9,
			ja = 7.1
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
				arg_246_0:Play304011061(arg_246_1)
			end
		end

		function arg_246_1.onSingleLineUpdate_(arg_249_0)
			local var_249_0 = "3008ui_story"

			if arg_246_1.actors_[var_249_0] == nil then
				local var_249_1 = Asset.Load("Char/" .. "3008ui_story")

				if not isNil(var_249_1) then
					local var_249_2 = Object.Instantiate(Asset.Load("Char/" .. "3008ui_story"), arg_246_1.stage_.transform)

					var_249_2.name = var_249_0
					var_249_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_246_1.actors_[var_249_0] = var_249_2

					local var_249_3 = var_249_2:GetComponentInChildren(typeof(CharacterEffect))

					var_249_3.enabled = true

					local var_249_4 = GameObjectTools.GetOrAddComponent(var_249_2, typeof(DynamicBoneHelper))

					if var_249_4 then
						var_249_4:EnableDynamicBone(false)
					end

					arg_246_1:ShowWeapon(var_249_3.transform, false)

					arg_246_1.var_[var_249_0 .. "Animator"] = var_249_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_246_1.var_[var_249_0 .. "Animator"].applyRootMotion = true
					arg_246_1.var_[var_249_0 .. "LipSync"] = var_249_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_249_5 = arg_246_1.actors_["3008ui_story"]
			local var_249_6 = 0

			if var_249_6 < arg_246_1.time_ and arg_246_1.time_ <= var_249_6 + arg_249_0 and not isNil(var_249_5) and arg_246_1.var_.characterEffect3008ui_story == nil then
				arg_246_1.var_.characterEffect3008ui_story = var_249_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_249_7 = 0.200000002980232

			if var_249_6 <= arg_246_1.time_ and arg_246_1.time_ < var_249_6 + var_249_7 and not isNil(var_249_5) then
				local var_249_8 = (arg_246_1.time_ - var_249_6) / var_249_7

				if arg_246_1.var_.characterEffect3008ui_story and not isNil(var_249_5) then
					arg_246_1.var_.characterEffect3008ui_story.fillFlat = false
				end
			end

			if arg_246_1.time_ >= var_249_6 + var_249_7 and arg_246_1.time_ < var_249_6 + var_249_7 + arg_249_0 and not isNil(var_249_5) and arg_246_1.var_.characterEffect3008ui_story then
				arg_246_1.var_.characterEffect3008ui_story.fillFlat = false
			end

			local var_249_9 = arg_246_1.actors_["10001_tpose"].transform
			local var_249_10 = 0

			if var_249_10 < arg_246_1.time_ and arg_246_1.time_ <= var_249_10 + arg_249_0 then
				arg_246_1.var_.moveOldPos10001_tpose = var_249_9.localPosition

				local var_249_11 = GameObjectTools.GetOrAddComponent(var_249_9.gameObject, typeof(DynamicBoneHelper))

				if var_249_11 then
					var_249_11:EnableDynamicBone(false)
				end
			end

			local var_249_12 = 0.001

			if var_249_10 <= arg_246_1.time_ and arg_246_1.time_ < var_249_10 + var_249_12 then
				local var_249_13 = (arg_246_1.time_ - var_249_10) / var_249_12
				local var_249_14 = Vector3.New(0, 100, 0)

				var_249_9.localPosition = Vector3.Lerp(arg_246_1.var_.moveOldPos10001_tpose, var_249_14, var_249_13)

				local var_249_15 = manager.ui.mainCamera.transform.position - var_249_9.position

				var_249_9.forward = Vector3.New(var_249_15.x, var_249_15.y, var_249_15.z)

				local var_249_16 = var_249_9.localEulerAngles

				var_249_16.z = 0
				var_249_16.x = 0
				var_249_9.localEulerAngles = var_249_16
			end

			if arg_246_1.time_ >= var_249_10 + var_249_12 and arg_246_1.time_ < var_249_10 + var_249_12 + arg_249_0 then
				var_249_9.localPosition = Vector3.New(0, 100, 0)

				local var_249_17 = manager.ui.mainCamera.transform.position - var_249_9.position

				var_249_9.forward = Vector3.New(var_249_17.x, var_249_17.y, var_249_17.z)

				local var_249_18 = var_249_9.localEulerAngles

				var_249_18.z = 0
				var_249_18.x = 0
				var_249_9.localEulerAngles = var_249_18

				local var_249_19 = GameObjectTools.GetOrAddComponent(var_249_9.gameObject, typeof(DynamicBoneHelper))

				if var_249_19 then
					var_249_19:EnableDynamicBone(true)
				end
			end

			local var_249_20 = 0
			local var_249_21 = 0.525

			if var_249_20 < arg_246_1.time_ and arg_246_1.time_ <= var_249_20 + arg_249_0 then
				arg_246_1.talkMaxDuration = 0
				arg_246_1.dialogCg_.alpha = 1

				arg_246_1.dialog_:SetActive(true)
				SetActive(arg_246_1.leftNameGo_, true)

				local var_249_22 = arg_246_1:FormatText(StoryNameCfg[36].name)

				arg_246_1.leftNameTxt_.text = var_249_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_246_1.leftNameTxt_.transform)

				arg_246_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_246_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_246_1:RecordName(arg_246_1.leftNameTxt_.text)
				SetActive(arg_246_1.iconTrs_.gameObject, true)
				arg_246_1.iconController_:SetSelectedState("hero")

				arg_246_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3008")

				arg_246_1.callingController_:SetSelectedState("normal")

				arg_246_1.keyicon_.color = Color.New(1, 1, 1)
				arg_246_1.icon_.color = Color.New(1, 1, 1)

				local var_249_23 = arg_246_1:GetWordFromCfg(304011060)
				local var_249_24 = arg_246_1:FormatText(var_249_23.content)

				arg_246_1.text_.text = var_249_24

				LuaForUtil.ClearLinePrefixSymbol(arg_246_1.text_)

				local var_249_25 = 21
				local var_249_26 = utf8.len(var_249_24)
				local var_249_27 = var_249_25 <= 0 and var_249_21 or var_249_21 * (var_249_26 / var_249_25)

				if var_249_27 > 0 and var_249_21 < var_249_27 then
					arg_246_1.talkMaxDuration = var_249_27

					if var_249_27 + var_249_20 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_27 + var_249_20
					end
				end

				arg_246_1.text_.text = var_249_24
				arg_246_1.typewritter.percent = 0

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304011", "304011060", "story_v_out_304011.awb") ~= 0 then
					local var_249_28 = manager.audio:GetVoiceLength("story_v_out_304011", "304011060", "story_v_out_304011.awb") / 1000

					if var_249_28 + var_249_20 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_28 + var_249_20
					end

					if var_249_23.prefab_name ~= "" and arg_246_1.actors_[var_249_23.prefab_name] ~= nil then
						local var_249_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_246_1.actors_[var_249_23.prefab_name].transform, "story_v_out_304011", "304011060", "story_v_out_304011.awb")

						arg_246_1:RecordAudio("304011060", var_249_29)
						arg_246_1:RecordAudio("304011060", var_249_29)
					else
						arg_246_1:AudioAction("play", "voice", "story_v_out_304011", "304011060", "story_v_out_304011.awb")
					end

					arg_246_1:RecordHistoryTalkVoice("story_v_out_304011", "304011060", "story_v_out_304011.awb")
				end

				arg_246_1:RecordContent(arg_246_1.text_.text)
			end

			local var_249_30 = math.max(var_249_21, arg_246_1.talkMaxDuration)

			if var_249_20 <= arg_246_1.time_ and arg_246_1.time_ < var_249_20 + var_249_30 then
				arg_246_1.typewritter.percent = (arg_246_1.time_ - var_249_20) / var_249_30

				arg_246_1.typewritter:SetDirty()
			end

			if arg_246_1.time_ >= var_249_20 + var_249_30 and arg_246_1.time_ < var_249_20 + var_249_30 + arg_249_0 then
				arg_246_1.typewritter.percent = 1

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(true)
			end
		end

		arg_246_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10001_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_246_1:InitPlayNodeList()
	end,
	Play304011061 = function(arg_250_0, arg_250_1)
		arg_250_1.time_ = 0
		arg_250_1.frameCnt_ = 0
		arg_250_1.state_ = "playing"
		arg_250_1.curTalkId_ = 304011061
		arg_250_1.duration_ = 3.4

		local var_250_0 = {
			zh = 3.4,
			ja = 1.999999999999
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
				arg_250_0:Play304011062(arg_250_1)
			end
		end

		function arg_250_1.onSingleLineUpdate_(arg_253_0)
			local var_253_0 = "2020_tpose"

			if arg_250_1.actors_[var_253_0] == nil then
				local var_253_1 = Asset.Load("Char/" .. "2020_tpose")

				if not isNil(var_253_1) then
					local var_253_2 = Object.Instantiate(Asset.Load("Char/" .. "2020_tpose"), arg_250_1.stage_.transform)

					var_253_2.name = var_253_0
					var_253_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_250_1.actors_[var_253_0] = var_253_2

					local var_253_3 = var_253_2:GetComponentInChildren(typeof(CharacterEffect))

					var_253_3.enabled = true

					local var_253_4 = GameObjectTools.GetOrAddComponent(var_253_2, typeof(DynamicBoneHelper))

					if var_253_4 then
						var_253_4:EnableDynamicBone(false)
					end

					arg_250_1:ShowWeapon(var_253_3.transform, false)

					arg_250_1.var_[var_253_0 .. "Animator"] = var_253_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_250_1.var_[var_253_0 .. "Animator"].applyRootMotion = true
					arg_250_1.var_[var_253_0 .. "LipSync"] = var_253_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_253_5 = arg_250_1.actors_["2020_tpose"].transform
			local var_253_6 = 0

			if var_253_6 < arg_250_1.time_ and arg_250_1.time_ <= var_253_6 + arg_253_0 then
				arg_250_1.var_.moveOldPos2020_tpose = var_253_5.localPosition

				local var_253_7 = GameObjectTools.GetOrAddComponent(var_253_5.gameObject, typeof(DynamicBoneHelper))

				if var_253_7 then
					var_253_7:EnableDynamicBone(false)
				end
			end

			local var_253_8 = 0.001

			if var_253_6 <= arg_250_1.time_ and arg_250_1.time_ < var_253_6 + var_253_8 then
				local var_253_9 = (arg_250_1.time_ - var_253_6) / var_253_8
				local var_253_10 = Vector3.New(0, -1.2, -4.1)

				var_253_5.localPosition = Vector3.Lerp(arg_250_1.var_.moveOldPos2020_tpose, var_253_10, var_253_9)

				local var_253_11 = manager.ui.mainCamera.transform.position - var_253_5.position

				var_253_5.forward = Vector3.New(var_253_11.x, var_253_11.y, var_253_11.z)

				local var_253_12 = var_253_5.localEulerAngles

				var_253_12.z = 0
				var_253_12.x = 0
				var_253_5.localEulerAngles = var_253_12
			end

			if arg_250_1.time_ >= var_253_6 + var_253_8 and arg_250_1.time_ < var_253_6 + var_253_8 + arg_253_0 then
				var_253_5.localPosition = Vector3.New(0, -1.2, -4.1)

				local var_253_13 = manager.ui.mainCamera.transform.position - var_253_5.position

				var_253_5.forward = Vector3.New(var_253_13.x, var_253_13.y, var_253_13.z)

				local var_253_14 = var_253_5.localEulerAngles

				var_253_14.z = 0
				var_253_14.x = 0
				var_253_5.localEulerAngles = var_253_14

				local var_253_15 = GameObjectTools.GetOrAddComponent(var_253_5.gameObject, typeof(DynamicBoneHelper))

				if var_253_15 then
					var_253_15:EnableDynamicBone(true)
				end
			end

			local var_253_16 = arg_250_1.actors_["2020_tpose"]
			local var_253_17 = 0

			if var_253_17 < arg_250_1.time_ and arg_250_1.time_ <= var_253_17 + arg_253_0 and not isNil(var_253_16) and arg_250_1.var_.characterEffect2020_tpose == nil then
				arg_250_1.var_.characterEffect2020_tpose = var_253_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_253_18 = 0.200000002980232

			if var_253_17 <= arg_250_1.time_ and arg_250_1.time_ < var_253_17 + var_253_18 and not isNil(var_253_16) then
				local var_253_19 = (arg_250_1.time_ - var_253_17) / var_253_18

				if arg_250_1.var_.characterEffect2020_tpose and not isNil(var_253_16) then
					arg_250_1.var_.characterEffect2020_tpose.fillFlat = false
				end
			end

			if arg_250_1.time_ >= var_253_17 + var_253_18 and arg_250_1.time_ < var_253_17 + var_253_18 + arg_253_0 and not isNil(var_253_16) and arg_250_1.var_.characterEffect2020_tpose then
				arg_250_1.var_.characterEffect2020_tpose.fillFlat = false
			end

			local var_253_20 = arg_250_1.actors_["3008ui_story"]
			local var_253_21 = 0

			if var_253_21 < arg_250_1.time_ and arg_250_1.time_ <= var_253_21 + arg_253_0 and not isNil(var_253_20) and arg_250_1.var_.characterEffect3008ui_story == nil then
				arg_250_1.var_.characterEffect3008ui_story = var_253_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_253_22 = 0.200000002980232

			if var_253_21 <= arg_250_1.time_ and arg_250_1.time_ < var_253_21 + var_253_22 and not isNil(var_253_20) then
				local var_253_23 = (arg_250_1.time_ - var_253_21) / var_253_22

				if arg_250_1.var_.characterEffect3008ui_story and not isNil(var_253_20) then
					local var_253_24 = Mathf.Lerp(0, 0.5, var_253_23)

					arg_250_1.var_.characterEffect3008ui_story.fillFlat = true
					arg_250_1.var_.characterEffect3008ui_story.fillRatio = var_253_24
				end
			end

			if arg_250_1.time_ >= var_253_21 + var_253_22 and arg_250_1.time_ < var_253_21 + var_253_22 + arg_253_0 and not isNil(var_253_20) and arg_250_1.var_.characterEffect3008ui_story then
				local var_253_25 = 0.5

				arg_250_1.var_.characterEffect3008ui_story.fillFlat = true
				arg_250_1.var_.characterEffect3008ui_story.fillRatio = var_253_25
			end

			local var_253_26 = 0

			if var_253_26 < arg_250_1.time_ and arg_250_1.time_ <= var_253_26 + arg_253_0 then
				arg_250_1:PlayTimeline("2020_tpose", "StoryTimeline/CharAction/story2020/story2020action/2020action1_1")
			end

			local var_253_27 = 0
			local var_253_28 = 0.4

			if var_253_27 < arg_250_1.time_ and arg_250_1.time_ <= var_253_27 + arg_253_0 then
				arg_250_1.talkMaxDuration = 0
				arg_250_1.dialogCg_.alpha = 1

				arg_250_1.dialog_:SetActive(true)
				SetActive(arg_250_1.leftNameGo_, true)

				local var_253_29 = arg_250_1:FormatText(StoryNameCfg[19].name)

				arg_250_1.leftNameTxt_.text = var_253_29

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_250_1.leftNameTxt_.transform)

				arg_250_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_250_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_250_1:RecordName(arg_250_1.leftNameTxt_.text)
				SetActive(arg_250_1.iconTrs_.gameObject, false)
				arg_250_1.callingController_:SetSelectedState("normal")

				local var_253_30 = arg_250_1:GetWordFromCfg(304011061)
				local var_253_31 = arg_250_1:FormatText(var_253_30.content)

				arg_250_1.text_.text = var_253_31

				LuaForUtil.ClearLinePrefixSymbol(arg_250_1.text_)

				local var_253_32 = 16
				local var_253_33 = utf8.len(var_253_31)
				local var_253_34 = var_253_32 <= 0 and var_253_28 or var_253_28 * (var_253_33 / var_253_32)

				if var_253_34 > 0 and var_253_28 < var_253_34 then
					arg_250_1.talkMaxDuration = var_253_34

					if var_253_34 + var_253_27 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_34 + var_253_27
					end
				end

				arg_250_1.text_.text = var_253_31
				arg_250_1.typewritter.percent = 0

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304011", "304011061", "story_v_out_304011.awb") ~= 0 then
					local var_253_35 = manager.audio:GetVoiceLength("story_v_out_304011", "304011061", "story_v_out_304011.awb") / 1000

					if var_253_35 + var_253_27 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_35 + var_253_27
					end

					if var_253_30.prefab_name ~= "" and arg_250_1.actors_[var_253_30.prefab_name] ~= nil then
						local var_253_36 = LuaForUtil.PlayVoiceWithCriLipsync(arg_250_1.actors_[var_253_30.prefab_name].transform, "story_v_out_304011", "304011061", "story_v_out_304011.awb")

						arg_250_1:RecordAudio("304011061", var_253_36)
						arg_250_1:RecordAudio("304011061", var_253_36)
					else
						arg_250_1:AudioAction("play", "voice", "story_v_out_304011", "304011061", "story_v_out_304011.awb")
					end

					arg_250_1:RecordHistoryTalkVoice("story_v_out_304011", "304011061", "story_v_out_304011.awb")
				end

				arg_250_1:RecordContent(arg_250_1.text_.text)
			end

			local var_253_37 = math.max(var_253_28, arg_250_1.talkMaxDuration)

			if var_253_27 <= arg_250_1.time_ and arg_250_1.time_ < var_253_27 + var_253_37 then
				arg_250_1.typewritter.percent = (arg_250_1.time_ - var_253_27) / var_253_37

				arg_250_1.typewritter:SetDirty()
			end

			if arg_250_1.time_ >= var_253_27 + var_253_37 and arg_250_1.time_ < var_253_27 + var_253_37 + arg_253_0 then
				arg_250_1.typewritter.percent = 1

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(true)
			end
		end

		arg_250_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2020_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_250_1:InitPlayNodeList()
	end,
	Play304011062 = function(arg_254_0, arg_254_1)
		arg_254_1.time_ = 0
		arg_254_1.frameCnt_ = 0
		arg_254_1.state_ = "playing"
		arg_254_1.curTalkId_ = 304011062
		arg_254_1.duration_ = 6.3

		local var_254_0 = {
			zh = 5.133,
			ja = 6.3
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
				arg_254_0:Play304011063(arg_254_1)
			end
		end

		function arg_254_1.onSingleLineUpdate_(arg_257_0)
			local var_257_0 = 0
			local var_257_1 = 0.55

			if var_257_0 < arg_254_1.time_ and arg_254_1.time_ <= var_257_0 + arg_257_0 then
				arg_254_1.talkMaxDuration = 0
				arg_254_1.dialogCg_.alpha = 1

				arg_254_1.dialog_:SetActive(true)
				SetActive(arg_254_1.leftNameGo_, true)

				local var_257_2 = arg_254_1:FormatText(StoryNameCfg[19].name)

				arg_254_1.leftNameTxt_.text = var_257_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_254_1.leftNameTxt_.transform)

				arg_254_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_254_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_254_1:RecordName(arg_254_1.leftNameTxt_.text)
				SetActive(arg_254_1.iconTrs_.gameObject, false)
				arg_254_1.callingController_:SetSelectedState("normal")

				local var_257_3 = arg_254_1:GetWordFromCfg(304011062)
				local var_257_4 = arg_254_1:FormatText(var_257_3.content)

				arg_254_1.text_.text = var_257_4

				LuaForUtil.ClearLinePrefixSymbol(arg_254_1.text_)

				local var_257_5 = 22
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

				if manager.audio:GetVoiceLength("story_v_out_304011", "304011062", "story_v_out_304011.awb") ~= 0 then
					local var_257_8 = manager.audio:GetVoiceLength("story_v_out_304011", "304011062", "story_v_out_304011.awb") / 1000

					if var_257_8 + var_257_0 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_8 + var_257_0
					end

					if var_257_3.prefab_name ~= "" and arg_254_1.actors_[var_257_3.prefab_name] ~= nil then
						local var_257_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_254_1.actors_[var_257_3.prefab_name].transform, "story_v_out_304011", "304011062", "story_v_out_304011.awb")

						arg_254_1:RecordAudio("304011062", var_257_9)
						arg_254_1:RecordAudio("304011062", var_257_9)
					else
						arg_254_1:AudioAction("play", "voice", "story_v_out_304011", "304011062", "story_v_out_304011.awb")
					end

					arg_254_1:RecordHistoryTalkVoice("story_v_out_304011", "304011062", "story_v_out_304011.awb")
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
	Play304011063 = function(arg_258_0, arg_258_1)
		arg_258_1.time_ = 0
		arg_258_1.frameCnt_ = 0
		arg_258_1.state_ = "playing"
		arg_258_1.curTalkId_ = 304011063
		arg_258_1.duration_ = 5

		SetActive(arg_258_1.tipsGo_, false)

		function arg_258_1.onSingleLineFinish_()
			arg_258_1.onSingleLineUpdate_ = nil
			arg_258_1.onSingleLineFinish_ = nil
			arg_258_1.state_ = "waiting"
		end

		function arg_258_1.playNext_(arg_260_0)
			if arg_260_0 == 1 then
				arg_258_0:Play304011064(arg_258_1)
			end
		end

		function arg_258_1.onSingleLineUpdate_(arg_261_0)
			local var_261_0 = arg_258_1.actors_["2020_tpose"].transform
			local var_261_1 = 0

			if var_261_1 < arg_258_1.time_ and arg_258_1.time_ <= var_261_1 + arg_261_0 then
				arg_258_1.var_.moveOldPos2020_tpose = var_261_0.localPosition

				local var_261_2 = GameObjectTools.GetOrAddComponent(var_261_0.gameObject, typeof(DynamicBoneHelper))

				if var_261_2 then
					var_261_2:EnableDynamicBone(false)
				end
			end

			local var_261_3 = 0.001

			if var_261_1 <= arg_258_1.time_ and arg_258_1.time_ < var_261_1 + var_261_3 then
				local var_261_4 = (arg_258_1.time_ - var_261_1) / var_261_3
				local var_261_5 = Vector3.New(0, 100, 0)

				var_261_0.localPosition = Vector3.Lerp(arg_258_1.var_.moveOldPos2020_tpose, var_261_5, var_261_4)

				local var_261_6 = manager.ui.mainCamera.transform.position - var_261_0.position

				var_261_0.forward = Vector3.New(var_261_6.x, var_261_6.y, var_261_6.z)

				local var_261_7 = var_261_0.localEulerAngles

				var_261_7.z = 0
				var_261_7.x = 0
				var_261_0.localEulerAngles = var_261_7
			end

			if arg_258_1.time_ >= var_261_1 + var_261_3 and arg_258_1.time_ < var_261_1 + var_261_3 + arg_261_0 then
				var_261_0.localPosition = Vector3.New(0, 100, 0)

				local var_261_8 = manager.ui.mainCamera.transform.position - var_261_0.position

				var_261_0.forward = Vector3.New(var_261_8.x, var_261_8.y, var_261_8.z)

				local var_261_9 = var_261_0.localEulerAngles

				var_261_9.z = 0
				var_261_9.x = 0
				var_261_0.localEulerAngles = var_261_9

				local var_261_10 = GameObjectTools.GetOrAddComponent(var_261_0.gameObject, typeof(DynamicBoneHelper))

				if var_261_10 then
					var_261_10:EnableDynamicBone(true)
				end
			end

			local var_261_11 = arg_258_1.actors_["2020ui_story"]
			local var_261_12 = 0

			if var_261_12 < arg_258_1.time_ and arg_258_1.time_ <= var_261_12 + arg_261_0 and not isNil(var_261_11) and arg_258_1.var_.characterEffect2020ui_story == nil then
				arg_258_1.var_.characterEffect2020ui_story = var_261_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_261_13 = 0.200000002980232

			if var_261_12 <= arg_258_1.time_ and arg_258_1.time_ < var_261_12 + var_261_13 and not isNil(var_261_11) then
				local var_261_14 = (arg_258_1.time_ - var_261_12) / var_261_13

				if arg_258_1.var_.characterEffect2020ui_story and not isNil(var_261_11) then
					local var_261_15 = Mathf.Lerp(0, 0.5, var_261_14)

					arg_258_1.var_.characterEffect2020ui_story.fillFlat = true
					arg_258_1.var_.characterEffect2020ui_story.fillRatio = var_261_15
				end
			end

			if arg_258_1.time_ >= var_261_12 + var_261_13 and arg_258_1.time_ < var_261_12 + var_261_13 + arg_261_0 and not isNil(var_261_11) and arg_258_1.var_.characterEffect2020ui_story then
				local var_261_16 = 0.5

				arg_258_1.var_.characterEffect2020ui_story.fillFlat = true
				arg_258_1.var_.characterEffect2020ui_story.fillRatio = var_261_16
			end

			local var_261_17 = 0
			local var_261_18 = 1.45

			if var_261_17 < arg_258_1.time_ and arg_258_1.time_ <= var_261_17 + arg_261_0 then
				arg_258_1.talkMaxDuration = 0
				arg_258_1.dialogCg_.alpha = 1

				arg_258_1.dialog_:SetActive(true)
				SetActive(arg_258_1.leftNameGo_, false)

				arg_258_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_258_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_258_1:RecordName(arg_258_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_258_1.iconTrs_.gameObject, false)
				arg_258_1.callingController_:SetSelectedState("normal")

				local var_261_19 = arg_258_1:GetWordFromCfg(304011063)
				local var_261_20 = arg_258_1:FormatText(var_261_19.content)

				arg_258_1.text_.text = var_261_20

				LuaForUtil.ClearLinePrefixSymbol(arg_258_1.text_)

				local var_261_21 = 58
				local var_261_22 = utf8.len(var_261_20)
				local var_261_23 = var_261_21 <= 0 and var_261_18 or var_261_18 * (var_261_22 / var_261_21)

				if var_261_23 > 0 and var_261_18 < var_261_23 then
					arg_258_1.talkMaxDuration = var_261_23

					if var_261_23 + var_261_17 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_23 + var_261_17
					end
				end

				arg_258_1.text_.text = var_261_20
				arg_258_1.typewritter.percent = 0

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(false)
				arg_258_1:RecordContent(arg_258_1.text_.text)
			end

			local var_261_24 = math.max(var_261_18, arg_258_1.talkMaxDuration)

			if var_261_17 <= arg_258_1.time_ and arg_258_1.time_ < var_261_17 + var_261_24 then
				arg_258_1.typewritter.percent = (arg_258_1.time_ - var_261_17) / var_261_24

				arg_258_1.typewritter:SetDirty()
			end

			if arg_258_1.time_ >= var_261_17 + var_261_24 and arg_258_1.time_ < var_261_17 + var_261_24 + arg_261_0 then
				arg_258_1.typewritter.percent = 1

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(true)
			end
		end

		arg_258_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2020_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_258_1:InitPlayNodeList()
	end,
	Play304011064 = function(arg_262_0, arg_262_1)
		arg_262_1.time_ = 0
		arg_262_1.frameCnt_ = 0
		arg_262_1.state_ = "playing"
		arg_262_1.curTalkId_ = 304011064
		arg_262_1.duration_ = 5

		SetActive(arg_262_1.tipsGo_, false)

		function arg_262_1.onSingleLineFinish_()
			arg_262_1.onSingleLineUpdate_ = nil
			arg_262_1.onSingleLineFinish_ = nil
			arg_262_1.state_ = "waiting"
		end

		function arg_262_1.playNext_(arg_264_0)
			if arg_264_0 == 1 then
				arg_262_0:Play304011065(arg_262_1)
			end
		end

		function arg_262_1.onSingleLineUpdate_(arg_265_0)
			local var_265_0 = 0
			local var_265_1 = 1.075

			if var_265_0 < arg_262_1.time_ and arg_262_1.time_ <= var_265_0 + arg_265_0 then
				arg_262_1.talkMaxDuration = 0
				arg_262_1.dialogCg_.alpha = 1

				arg_262_1.dialog_:SetActive(true)
				SetActive(arg_262_1.leftNameGo_, false)

				arg_262_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_262_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_262_1:RecordName(arg_262_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_262_1.iconTrs_.gameObject, false)
				arg_262_1.callingController_:SetSelectedState("normal")

				local var_265_2 = arg_262_1:GetWordFromCfg(304011064)
				local var_265_3 = arg_262_1:FormatText(var_265_2.content)

				arg_262_1.text_.text = var_265_3

				LuaForUtil.ClearLinePrefixSymbol(arg_262_1.text_)

				local var_265_4 = 43
				local var_265_5 = utf8.len(var_265_3)
				local var_265_6 = var_265_4 <= 0 and var_265_1 or var_265_1 * (var_265_5 / var_265_4)

				if var_265_6 > 0 and var_265_1 < var_265_6 then
					arg_262_1.talkMaxDuration = var_265_6

					if var_265_6 + var_265_0 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_6 + var_265_0
					end
				end

				arg_262_1.text_.text = var_265_3
				arg_262_1.typewritter.percent = 0

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(false)
				arg_262_1:RecordContent(arg_262_1.text_.text)
			end

			local var_265_7 = math.max(var_265_1, arg_262_1.talkMaxDuration)

			if var_265_0 <= arg_262_1.time_ and arg_262_1.time_ < var_265_0 + var_265_7 then
				arg_262_1.typewritter.percent = (arg_262_1.time_ - var_265_0) / var_265_7

				arg_262_1.typewritter:SetDirty()
			end

			if arg_262_1.time_ >= var_265_0 + var_265_7 and arg_262_1.time_ < var_265_0 + var_265_7 + arg_265_0 then
				arg_262_1.typewritter.percent = 1

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(true)
			end
		end

		arg_262_1.nodeConfigList_ = {}

		arg_262_1:InitPlayNodeList()
	end,
	Play304011065 = function(arg_266_0, arg_266_1)
		arg_266_1.time_ = 0
		arg_266_1.frameCnt_ = 0
		arg_266_1.state_ = "playing"
		arg_266_1.curTalkId_ = 304011065
		arg_266_1.duration_ = 7.73

		local var_266_0 = {
			zh = 6.166,
			ja = 7.733
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
				arg_266_0:Play304011066(arg_266_1)
			end
		end

		function arg_266_1.onSingleLineUpdate_(arg_269_0)
			local var_269_0 = "1148ui_story"

			if arg_266_1.actors_[var_269_0] == nil then
				local var_269_1 = Asset.Load("Char/" .. "1148ui_story")

				if not isNil(var_269_1) then
					local var_269_2 = Object.Instantiate(Asset.Load("Char/" .. "1148ui_story"), arg_266_1.stage_.transform)

					var_269_2.name = var_269_0
					var_269_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_266_1.actors_[var_269_0] = var_269_2

					local var_269_3 = var_269_2:GetComponentInChildren(typeof(CharacterEffect))

					var_269_3.enabled = true

					local var_269_4 = GameObjectTools.GetOrAddComponent(var_269_2, typeof(DynamicBoneHelper))

					if var_269_4 then
						var_269_4:EnableDynamicBone(false)
					end

					arg_266_1:ShowWeapon(var_269_3.transform, false)

					arg_266_1.var_[var_269_0 .. "Animator"] = var_269_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_266_1.var_[var_269_0 .. "Animator"].applyRootMotion = true
					arg_266_1.var_[var_269_0 .. "LipSync"] = var_269_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_269_5 = arg_266_1.actors_["1148ui_story"].transform
			local var_269_6 = 0

			if var_269_6 < arg_266_1.time_ and arg_266_1.time_ <= var_269_6 + arg_269_0 then
				arg_266_1.var_.moveOldPos1148ui_story = var_269_5.localPosition
			end

			local var_269_7 = 0.001

			if var_269_6 <= arg_266_1.time_ and arg_266_1.time_ < var_269_6 + var_269_7 then
				local var_269_8 = (arg_266_1.time_ - var_269_6) / var_269_7
				local var_269_9 = Vector3.New(0, -0.8, -6.2)

				var_269_5.localPosition = Vector3.Lerp(arg_266_1.var_.moveOldPos1148ui_story, var_269_9, var_269_8)

				local var_269_10 = manager.ui.mainCamera.transform.position - var_269_5.position

				var_269_5.forward = Vector3.New(var_269_10.x, var_269_10.y, var_269_10.z)

				local var_269_11 = var_269_5.localEulerAngles

				var_269_11.z = 0
				var_269_11.x = 0
				var_269_5.localEulerAngles = var_269_11
			end

			if arg_266_1.time_ >= var_269_6 + var_269_7 and arg_266_1.time_ < var_269_6 + var_269_7 + arg_269_0 then
				var_269_5.localPosition = Vector3.New(0, -0.8, -6.2)

				local var_269_12 = manager.ui.mainCamera.transform.position - var_269_5.position

				var_269_5.forward = Vector3.New(var_269_12.x, var_269_12.y, var_269_12.z)

				local var_269_13 = var_269_5.localEulerAngles

				var_269_13.z = 0
				var_269_13.x = 0
				var_269_5.localEulerAngles = var_269_13
			end

			local var_269_14 = arg_266_1.actors_["1148ui_story"]
			local var_269_15 = 0

			if var_269_15 < arg_266_1.time_ and arg_266_1.time_ <= var_269_15 + arg_269_0 and not isNil(var_269_14) and arg_266_1.var_.characterEffect1148ui_story == nil then
				arg_266_1.var_.characterEffect1148ui_story = var_269_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_269_16 = 0.200000002980232

			if var_269_15 <= arg_266_1.time_ and arg_266_1.time_ < var_269_15 + var_269_16 and not isNil(var_269_14) then
				local var_269_17 = (arg_266_1.time_ - var_269_15) / var_269_16

				if arg_266_1.var_.characterEffect1148ui_story and not isNil(var_269_14) then
					arg_266_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_266_1.time_ >= var_269_15 + var_269_16 and arg_266_1.time_ < var_269_15 + var_269_16 + arg_269_0 and not isNil(var_269_14) and arg_266_1.var_.characterEffect1148ui_story then
				arg_266_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_269_18 = 0

			if var_269_18 < arg_266_1.time_ and arg_266_1.time_ <= var_269_18 + arg_269_0 then
				arg_266_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action7_1")
			end

			local var_269_19 = 0

			if var_269_19 < arg_266_1.time_ and arg_266_1.time_ <= var_269_19 + arg_269_0 then
				arg_266_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_269_20 = 0
			local var_269_21 = 0.725

			if var_269_20 < arg_266_1.time_ and arg_266_1.time_ <= var_269_20 + arg_269_0 then
				arg_266_1.talkMaxDuration = 0
				arg_266_1.dialogCg_.alpha = 1

				arg_266_1.dialog_:SetActive(true)
				SetActive(arg_266_1.leftNameGo_, true)

				local var_269_22 = arg_266_1:FormatText(StoryNameCfg[8].name)

				arg_266_1.leftNameTxt_.text = var_269_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_266_1.leftNameTxt_.transform)

				arg_266_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_266_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_266_1:RecordName(arg_266_1.leftNameTxt_.text)
				SetActive(arg_266_1.iconTrs_.gameObject, false)
				arg_266_1.callingController_:SetSelectedState("normal")

				local var_269_23 = arg_266_1:GetWordFromCfg(304011065)
				local var_269_24 = arg_266_1:FormatText(var_269_23.content)

				arg_266_1.text_.text = var_269_24

				LuaForUtil.ClearLinePrefixSymbol(arg_266_1.text_)

				local var_269_25 = 29
				local var_269_26 = utf8.len(var_269_24)
				local var_269_27 = var_269_25 <= 0 and var_269_21 or var_269_21 * (var_269_26 / var_269_25)

				if var_269_27 > 0 and var_269_21 < var_269_27 then
					arg_266_1.talkMaxDuration = var_269_27

					if var_269_27 + var_269_20 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_27 + var_269_20
					end
				end

				arg_266_1.text_.text = var_269_24
				arg_266_1.typewritter.percent = 0

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304011", "304011065", "story_v_out_304011.awb") ~= 0 then
					local var_269_28 = manager.audio:GetVoiceLength("story_v_out_304011", "304011065", "story_v_out_304011.awb") / 1000

					if var_269_28 + var_269_20 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_28 + var_269_20
					end

					if var_269_23.prefab_name ~= "" and arg_266_1.actors_[var_269_23.prefab_name] ~= nil then
						local var_269_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_266_1.actors_[var_269_23.prefab_name].transform, "story_v_out_304011", "304011065", "story_v_out_304011.awb")

						arg_266_1:RecordAudio("304011065", var_269_29)
						arg_266_1:RecordAudio("304011065", var_269_29)
					else
						arg_266_1:AudioAction("play", "voice", "story_v_out_304011", "304011065", "story_v_out_304011.awb")
					end

					arg_266_1:RecordHistoryTalkVoice("story_v_out_304011", "304011065", "story_v_out_304011.awb")
				end

				arg_266_1:RecordContent(arg_266_1.text_.text)
			end

			local var_269_30 = math.max(var_269_21, arg_266_1.talkMaxDuration)

			if var_269_20 <= arg_266_1.time_ and arg_266_1.time_ < var_269_20 + var_269_30 then
				arg_266_1.typewritter.percent = (arg_266_1.time_ - var_269_20) / var_269_30

				arg_266_1.typewritter:SetDirty()
			end

			if arg_266_1.time_ >= var_269_20 + var_269_30 and arg_266_1.time_ < var_269_20 + var_269_30 + arg_269_0 then
				arg_266_1.typewritter.percent = 1

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(true)
			end
		end

		arg_266_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_266_1:InitPlayNodeList()
	end,
	Play304011066 = function(arg_270_0, arg_270_1)
		arg_270_1.time_ = 0
		arg_270_1.frameCnt_ = 0
		arg_270_1.state_ = "playing"
		arg_270_1.curTalkId_ = 304011066
		arg_270_1.duration_ = 5.93

		local var_270_0 = {
			zh = 4.933,
			ja = 5.933
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
				arg_270_0:Play304011067(arg_270_1)
			end
		end

		function arg_270_1.onSingleLineUpdate_(arg_273_0)
			local var_273_0 = 0

			if var_273_0 < arg_270_1.time_ and arg_270_1.time_ <= var_273_0 + arg_273_0 then
				arg_270_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action7_2")
			end

			local var_273_1 = 0

			if var_273_1 < arg_270_1.time_ and arg_270_1.time_ <= var_273_1 + arg_273_0 then
				arg_270_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_273_2 = 0
			local var_273_3 = 0.6

			if var_273_2 < arg_270_1.time_ and arg_270_1.time_ <= var_273_2 + arg_273_0 then
				arg_270_1.talkMaxDuration = 0
				arg_270_1.dialogCg_.alpha = 1

				arg_270_1.dialog_:SetActive(true)
				SetActive(arg_270_1.leftNameGo_, true)

				local var_273_4 = arg_270_1:FormatText(StoryNameCfg[8].name)

				arg_270_1.leftNameTxt_.text = var_273_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_270_1.leftNameTxt_.transform)

				arg_270_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_270_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_270_1:RecordName(arg_270_1.leftNameTxt_.text)
				SetActive(arg_270_1.iconTrs_.gameObject, false)
				arg_270_1.callingController_:SetSelectedState("normal")

				local var_273_5 = arg_270_1:GetWordFromCfg(304011066)
				local var_273_6 = arg_270_1:FormatText(var_273_5.content)

				arg_270_1.text_.text = var_273_6

				LuaForUtil.ClearLinePrefixSymbol(arg_270_1.text_)

				local var_273_7 = 24
				local var_273_8 = utf8.len(var_273_6)
				local var_273_9 = var_273_7 <= 0 and var_273_3 or var_273_3 * (var_273_8 / var_273_7)

				if var_273_9 > 0 and var_273_3 < var_273_9 then
					arg_270_1.talkMaxDuration = var_273_9

					if var_273_9 + var_273_2 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_9 + var_273_2
					end
				end

				arg_270_1.text_.text = var_273_6
				arg_270_1.typewritter.percent = 0

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304011", "304011066", "story_v_out_304011.awb") ~= 0 then
					local var_273_10 = manager.audio:GetVoiceLength("story_v_out_304011", "304011066", "story_v_out_304011.awb") / 1000

					if var_273_10 + var_273_2 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_10 + var_273_2
					end

					if var_273_5.prefab_name ~= "" and arg_270_1.actors_[var_273_5.prefab_name] ~= nil then
						local var_273_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_270_1.actors_[var_273_5.prefab_name].transform, "story_v_out_304011", "304011066", "story_v_out_304011.awb")

						arg_270_1:RecordAudio("304011066", var_273_11)
						arg_270_1:RecordAudio("304011066", var_273_11)
					else
						arg_270_1:AudioAction("play", "voice", "story_v_out_304011", "304011066", "story_v_out_304011.awb")
					end

					arg_270_1:RecordHistoryTalkVoice("story_v_out_304011", "304011066", "story_v_out_304011.awb")
				end

				arg_270_1:RecordContent(arg_270_1.text_.text)
			end

			local var_273_12 = math.max(var_273_3, arg_270_1.talkMaxDuration)

			if var_273_2 <= arg_270_1.time_ and arg_270_1.time_ < var_273_2 + var_273_12 then
				arg_270_1.typewritter.percent = (arg_270_1.time_ - var_273_2) / var_273_12

				arg_270_1.typewritter:SetDirty()
			end

			if arg_270_1.time_ >= var_273_2 + var_273_12 and arg_270_1.time_ < var_273_2 + var_273_12 + arg_273_0 then
				arg_270_1.typewritter.percent = 1

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(true)
			end
		end

		arg_270_1.nodeConfigList_ = {}

		arg_270_1:InitPlayNodeList()
	end,
	Play304011067 = function(arg_274_0, arg_274_1)
		arg_274_1.time_ = 0
		arg_274_1.frameCnt_ = 0
		arg_274_1.state_ = "playing"
		arg_274_1.curTalkId_ = 304011067
		arg_274_1.duration_ = 6.83

		local var_274_0 = {
			zh = 5.833,
			ja = 6.833
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
				arg_274_0:Play304011068(arg_274_1)
			end
		end

		function arg_274_1.onSingleLineUpdate_(arg_277_0)
			local var_277_0 = "1059ui_story"

			if arg_274_1.actors_[var_277_0] == nil then
				local var_277_1 = Asset.Load("Char/" .. "1059ui_story")

				if not isNil(var_277_1) then
					local var_277_2 = Object.Instantiate(Asset.Load("Char/" .. "1059ui_story"), arg_274_1.stage_.transform)

					var_277_2.name = var_277_0
					var_277_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_274_1.actors_[var_277_0] = var_277_2

					local var_277_3 = var_277_2:GetComponentInChildren(typeof(CharacterEffect))

					var_277_3.enabled = true

					local var_277_4 = GameObjectTools.GetOrAddComponent(var_277_2, typeof(DynamicBoneHelper))

					if var_277_4 then
						var_277_4:EnableDynamicBone(false)
					end

					arg_274_1:ShowWeapon(var_277_3.transform, false)

					arg_274_1.var_[var_277_0 .. "Animator"] = var_277_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_274_1.var_[var_277_0 .. "Animator"].applyRootMotion = true
					arg_274_1.var_[var_277_0 .. "LipSync"] = var_277_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_277_5 = arg_274_1.actors_["1059ui_story"].transform
			local var_277_6 = 0

			if var_277_6 < arg_274_1.time_ and arg_274_1.time_ <= var_277_6 + arg_277_0 then
				arg_274_1.var_.moveOldPos1059ui_story = var_277_5.localPosition
			end

			local var_277_7 = 0.001

			if var_277_6 <= arg_274_1.time_ and arg_274_1.time_ < var_277_6 + var_277_7 then
				local var_277_8 = (arg_274_1.time_ - var_277_6) / var_277_7
				local var_277_9 = Vector3.New(-0.7, -1.05, -6)

				var_277_5.localPosition = Vector3.Lerp(arg_274_1.var_.moveOldPos1059ui_story, var_277_9, var_277_8)

				local var_277_10 = manager.ui.mainCamera.transform.position - var_277_5.position

				var_277_5.forward = Vector3.New(var_277_10.x, var_277_10.y, var_277_10.z)

				local var_277_11 = var_277_5.localEulerAngles

				var_277_11.z = 0
				var_277_11.x = 0
				var_277_5.localEulerAngles = var_277_11
			end

			if arg_274_1.time_ >= var_277_6 + var_277_7 and arg_274_1.time_ < var_277_6 + var_277_7 + arg_277_0 then
				var_277_5.localPosition = Vector3.New(-0.7, -1.05, -6)

				local var_277_12 = manager.ui.mainCamera.transform.position - var_277_5.position

				var_277_5.forward = Vector3.New(var_277_12.x, var_277_12.y, var_277_12.z)

				local var_277_13 = var_277_5.localEulerAngles

				var_277_13.z = 0
				var_277_13.x = 0
				var_277_5.localEulerAngles = var_277_13
			end

			local var_277_14 = arg_274_1.actors_["1148ui_story"].transform
			local var_277_15 = 0

			if var_277_15 < arg_274_1.time_ and arg_274_1.time_ <= var_277_15 + arg_277_0 then
				arg_274_1.var_.moveOldPos1148ui_story = var_277_14.localPosition
			end

			local var_277_16 = 0.001

			if var_277_15 <= arg_274_1.time_ and arg_274_1.time_ < var_277_15 + var_277_16 then
				local var_277_17 = (arg_274_1.time_ - var_277_15) / var_277_16
				local var_277_18 = Vector3.New(0.7, -0.8, -6.2)

				var_277_14.localPosition = Vector3.Lerp(arg_274_1.var_.moveOldPos1148ui_story, var_277_18, var_277_17)

				local var_277_19 = manager.ui.mainCamera.transform.position - var_277_14.position

				var_277_14.forward = Vector3.New(var_277_19.x, var_277_19.y, var_277_19.z)

				local var_277_20 = var_277_14.localEulerAngles

				var_277_20.z = 0
				var_277_20.x = 0
				var_277_14.localEulerAngles = var_277_20
			end

			if arg_274_1.time_ >= var_277_15 + var_277_16 and arg_274_1.time_ < var_277_15 + var_277_16 + arg_277_0 then
				var_277_14.localPosition = Vector3.New(0.7, -0.8, -6.2)

				local var_277_21 = manager.ui.mainCamera.transform.position - var_277_14.position

				var_277_14.forward = Vector3.New(var_277_21.x, var_277_21.y, var_277_21.z)

				local var_277_22 = var_277_14.localEulerAngles

				var_277_22.z = 0
				var_277_22.x = 0
				var_277_14.localEulerAngles = var_277_22
			end

			local var_277_23 = arg_274_1.actors_["1059ui_story"]
			local var_277_24 = 0

			if var_277_24 < arg_274_1.time_ and arg_274_1.time_ <= var_277_24 + arg_277_0 and not isNil(var_277_23) and arg_274_1.var_.characterEffect1059ui_story == nil then
				arg_274_1.var_.characterEffect1059ui_story = var_277_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_277_25 = 0.200000002980232

			if var_277_24 <= arg_274_1.time_ and arg_274_1.time_ < var_277_24 + var_277_25 and not isNil(var_277_23) then
				local var_277_26 = (arg_274_1.time_ - var_277_24) / var_277_25

				if arg_274_1.var_.characterEffect1059ui_story and not isNil(var_277_23) then
					arg_274_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_274_1.time_ >= var_277_24 + var_277_25 and arg_274_1.time_ < var_277_24 + var_277_25 + arg_277_0 and not isNil(var_277_23) and arg_274_1.var_.characterEffect1059ui_story then
				arg_274_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_277_27 = arg_274_1.actors_["1148ui_story"]
			local var_277_28 = 0

			if var_277_28 < arg_274_1.time_ and arg_274_1.time_ <= var_277_28 + arg_277_0 and not isNil(var_277_27) and arg_274_1.var_.characterEffect1148ui_story == nil then
				arg_274_1.var_.characterEffect1148ui_story = var_277_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_277_29 = 0.200000002980232

			if var_277_28 <= arg_274_1.time_ and arg_274_1.time_ < var_277_28 + var_277_29 and not isNil(var_277_27) then
				local var_277_30 = (arg_274_1.time_ - var_277_28) / var_277_29

				if arg_274_1.var_.characterEffect1148ui_story and not isNil(var_277_27) then
					local var_277_31 = Mathf.Lerp(0, 0.5, var_277_30)

					arg_274_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_274_1.var_.characterEffect1148ui_story.fillRatio = var_277_31
				end
			end

			if arg_274_1.time_ >= var_277_28 + var_277_29 and arg_274_1.time_ < var_277_28 + var_277_29 + arg_277_0 and not isNil(var_277_27) and arg_274_1.var_.characterEffect1148ui_story then
				local var_277_32 = 0.5

				arg_274_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_274_1.var_.characterEffect1148ui_story.fillRatio = var_277_32
			end

			local var_277_33 = 0

			if var_277_33 < arg_274_1.time_ and arg_274_1.time_ <= var_277_33 + arg_277_0 then
				arg_274_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059action/1059action4_1")
			end

			local var_277_34 = 0

			if var_277_34 < arg_274_1.time_ and arg_274_1.time_ <= var_277_34 + arg_277_0 then
				arg_274_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_277_35 = 0
			local var_277_36 = 0.65

			if var_277_35 < arg_274_1.time_ and arg_274_1.time_ <= var_277_35 + arg_277_0 then
				arg_274_1.talkMaxDuration = 0
				arg_274_1.dialogCg_.alpha = 1

				arg_274_1.dialog_:SetActive(true)
				SetActive(arg_274_1.leftNameGo_, true)

				local var_277_37 = arg_274_1:FormatText(StoryNameCfg[28].name)

				arg_274_1.leftNameTxt_.text = var_277_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_274_1.leftNameTxt_.transform)

				arg_274_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_274_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_274_1:RecordName(arg_274_1.leftNameTxt_.text)
				SetActive(arg_274_1.iconTrs_.gameObject, false)
				arg_274_1.callingController_:SetSelectedState("normal")

				local var_277_38 = arg_274_1:GetWordFromCfg(304011067)
				local var_277_39 = arg_274_1:FormatText(var_277_38.content)

				arg_274_1.text_.text = var_277_39

				LuaForUtil.ClearLinePrefixSymbol(arg_274_1.text_)

				local var_277_40 = 26
				local var_277_41 = utf8.len(var_277_39)
				local var_277_42 = var_277_40 <= 0 and var_277_36 or var_277_36 * (var_277_41 / var_277_40)

				if var_277_42 > 0 and var_277_36 < var_277_42 then
					arg_274_1.talkMaxDuration = var_277_42

					if var_277_42 + var_277_35 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_42 + var_277_35
					end
				end

				arg_274_1.text_.text = var_277_39
				arg_274_1.typewritter.percent = 0

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304011", "304011067", "story_v_out_304011.awb") ~= 0 then
					local var_277_43 = manager.audio:GetVoiceLength("story_v_out_304011", "304011067", "story_v_out_304011.awb") / 1000

					if var_277_43 + var_277_35 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_43 + var_277_35
					end

					if var_277_38.prefab_name ~= "" and arg_274_1.actors_[var_277_38.prefab_name] ~= nil then
						local var_277_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_274_1.actors_[var_277_38.prefab_name].transform, "story_v_out_304011", "304011067", "story_v_out_304011.awb")

						arg_274_1:RecordAudio("304011067", var_277_44)
						arg_274_1:RecordAudio("304011067", var_277_44)
					else
						arg_274_1:AudioAction("play", "voice", "story_v_out_304011", "304011067", "story_v_out_304011.awb")
					end

					arg_274_1:RecordHistoryTalkVoice("story_v_out_304011", "304011067", "story_v_out_304011.awb")
				end

				arg_274_1:RecordContent(arg_274_1.text_.text)
			end

			local var_277_45 = math.max(var_277_36, arg_274_1.talkMaxDuration)

			if var_277_35 <= arg_274_1.time_ and arg_274_1.time_ < var_277_35 + var_277_45 then
				arg_274_1.typewritter.percent = (arg_274_1.time_ - var_277_35) / var_277_45

				arg_274_1.typewritter:SetDirty()
			end

			if arg_274_1.time_ >= var_277_35 + var_277_45 and arg_274_1.time_ < var_277_35 + var_277_45 + arg_277_0 then
				arg_274_1.typewritter.percent = 1

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(true)
			end
		end

		arg_274_1.nodeConfigList_ = {
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
				actorName = "1148ui_story",
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
	Play304011068 = function(arg_278_0, arg_278_1)
		arg_278_1.time_ = 0
		arg_278_1.frameCnt_ = 0
		arg_278_1.state_ = "playing"
		arg_278_1.curTalkId_ = 304011068
		arg_278_1.duration_ = 10.6

		local var_278_0 = {
			zh = 9.566,
			ja = 10.6
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
				arg_278_0:Play304011069(arg_278_1)
			end
		end

		function arg_278_1.onSingleLineUpdate_(arg_281_0)
			local var_281_0 = 0
			local var_281_1 = 1.25

			if var_281_0 < arg_278_1.time_ and arg_278_1.time_ <= var_281_0 + arg_281_0 then
				arg_278_1.talkMaxDuration = 0
				arg_278_1.dialogCg_.alpha = 1

				arg_278_1.dialog_:SetActive(true)
				SetActive(arg_278_1.leftNameGo_, true)

				local var_281_2 = arg_278_1:FormatText(StoryNameCfg[28].name)

				arg_278_1.leftNameTxt_.text = var_281_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_278_1.leftNameTxt_.transform)

				arg_278_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_278_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_278_1:RecordName(arg_278_1.leftNameTxt_.text)
				SetActive(arg_278_1.iconTrs_.gameObject, false)
				arg_278_1.callingController_:SetSelectedState("normal")

				local var_281_3 = arg_278_1:GetWordFromCfg(304011068)
				local var_281_4 = arg_278_1:FormatText(var_281_3.content)

				arg_278_1.text_.text = var_281_4

				LuaForUtil.ClearLinePrefixSymbol(arg_278_1.text_)

				local var_281_5 = 50
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

				if manager.audio:GetVoiceLength("story_v_out_304011", "304011068", "story_v_out_304011.awb") ~= 0 then
					local var_281_8 = manager.audio:GetVoiceLength("story_v_out_304011", "304011068", "story_v_out_304011.awb") / 1000

					if var_281_8 + var_281_0 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_8 + var_281_0
					end

					if var_281_3.prefab_name ~= "" and arg_278_1.actors_[var_281_3.prefab_name] ~= nil then
						local var_281_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_278_1.actors_[var_281_3.prefab_name].transform, "story_v_out_304011", "304011068", "story_v_out_304011.awb")

						arg_278_1:RecordAudio("304011068", var_281_9)
						arg_278_1:RecordAudio("304011068", var_281_9)
					else
						arg_278_1:AudioAction("play", "voice", "story_v_out_304011", "304011068", "story_v_out_304011.awb")
					end

					arg_278_1:RecordHistoryTalkVoice("story_v_out_304011", "304011068", "story_v_out_304011.awb")
				end

				arg_278_1:RecordContent(arg_278_1.text_.text)
			end

			local var_281_10 = math.max(var_281_1, arg_278_1.talkMaxDuration)

			if var_281_0 <= arg_278_1.time_ and arg_278_1.time_ < var_281_0 + var_281_10 then
				arg_278_1.typewritter.percent = (arg_278_1.time_ - var_281_0) / var_281_10

				arg_278_1.typewritter:SetDirty()
			end

			if arg_278_1.time_ >= var_281_0 + var_281_10 and arg_278_1.time_ < var_281_0 + var_281_10 + arg_281_0 then
				arg_278_1.typewritter.percent = 1

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(true)
			end
		end

		arg_278_1.nodeConfigList_ = {}

		arg_278_1:InitPlayNodeList()
	end,
	Play304011069 = function(arg_282_0, arg_282_1)
		arg_282_1.time_ = 0
		arg_282_1.frameCnt_ = 0
		arg_282_1.state_ = "playing"
		arg_282_1.curTalkId_ = 304011069
		arg_282_1.duration_ = 6.13

		local var_282_0 = {
			zh = 4.1,
			ja = 6.133
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
				arg_282_0:Play304011070(arg_282_1)
			end
		end

		function arg_282_1.onSingleLineUpdate_(arg_285_0)
			local var_285_0 = arg_282_1.actors_["1148ui_story"]
			local var_285_1 = 0

			if var_285_1 < arg_282_1.time_ and arg_282_1.time_ <= var_285_1 + arg_285_0 and not isNil(var_285_0) and arg_282_1.var_.characterEffect1148ui_story == nil then
				arg_282_1.var_.characterEffect1148ui_story = var_285_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_285_2 = 0.200000002980232

			if var_285_1 <= arg_282_1.time_ and arg_282_1.time_ < var_285_1 + var_285_2 and not isNil(var_285_0) then
				local var_285_3 = (arg_282_1.time_ - var_285_1) / var_285_2

				if arg_282_1.var_.characterEffect1148ui_story and not isNil(var_285_0) then
					arg_282_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_282_1.time_ >= var_285_1 + var_285_2 and arg_282_1.time_ < var_285_1 + var_285_2 + arg_285_0 and not isNil(var_285_0) and arg_282_1.var_.characterEffect1148ui_story then
				arg_282_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_285_4 = arg_282_1.actors_["1059ui_story"]
			local var_285_5 = 0

			if var_285_5 < arg_282_1.time_ and arg_282_1.time_ <= var_285_5 + arg_285_0 and not isNil(var_285_4) and arg_282_1.var_.characterEffect1059ui_story == nil then
				arg_282_1.var_.characterEffect1059ui_story = var_285_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_285_6 = 0.200000002980232

			if var_285_5 <= arg_282_1.time_ and arg_282_1.time_ < var_285_5 + var_285_6 and not isNil(var_285_4) then
				local var_285_7 = (arg_282_1.time_ - var_285_5) / var_285_6

				if arg_282_1.var_.characterEffect1059ui_story and not isNil(var_285_4) then
					local var_285_8 = Mathf.Lerp(0, 0.5, var_285_7)

					arg_282_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_282_1.var_.characterEffect1059ui_story.fillRatio = var_285_8
				end
			end

			if arg_282_1.time_ >= var_285_5 + var_285_6 and arg_282_1.time_ < var_285_5 + var_285_6 + arg_285_0 and not isNil(var_285_4) and arg_282_1.var_.characterEffect1059ui_story then
				local var_285_9 = 0.5

				arg_282_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_282_1.var_.characterEffect1059ui_story.fillRatio = var_285_9
			end

			local var_285_10 = 0
			local var_285_11 = 0.475

			if var_285_10 < arg_282_1.time_ and arg_282_1.time_ <= var_285_10 + arg_285_0 then
				arg_282_1.talkMaxDuration = 0
				arg_282_1.dialogCg_.alpha = 1

				arg_282_1.dialog_:SetActive(true)
				SetActive(arg_282_1.leftNameGo_, true)

				local var_285_12 = arg_282_1:FormatText(StoryNameCfg[8].name)

				arg_282_1.leftNameTxt_.text = var_285_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_282_1.leftNameTxt_.transform)

				arg_282_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_282_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_282_1:RecordName(arg_282_1.leftNameTxt_.text)
				SetActive(arg_282_1.iconTrs_.gameObject, false)
				arg_282_1.callingController_:SetSelectedState("normal")

				local var_285_13 = arg_282_1:GetWordFromCfg(304011069)
				local var_285_14 = arg_282_1:FormatText(var_285_13.content)

				arg_282_1.text_.text = var_285_14

				LuaForUtil.ClearLinePrefixSymbol(arg_282_1.text_)

				local var_285_15 = 19
				local var_285_16 = utf8.len(var_285_14)
				local var_285_17 = var_285_15 <= 0 and var_285_11 or var_285_11 * (var_285_16 / var_285_15)

				if var_285_17 > 0 and var_285_11 < var_285_17 then
					arg_282_1.talkMaxDuration = var_285_17

					if var_285_17 + var_285_10 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_17 + var_285_10
					end
				end

				arg_282_1.text_.text = var_285_14
				arg_282_1.typewritter.percent = 0

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304011", "304011069", "story_v_out_304011.awb") ~= 0 then
					local var_285_18 = manager.audio:GetVoiceLength("story_v_out_304011", "304011069", "story_v_out_304011.awb") / 1000

					if var_285_18 + var_285_10 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_18 + var_285_10
					end

					if var_285_13.prefab_name ~= "" and arg_282_1.actors_[var_285_13.prefab_name] ~= nil then
						local var_285_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_282_1.actors_[var_285_13.prefab_name].transform, "story_v_out_304011", "304011069", "story_v_out_304011.awb")

						arg_282_1:RecordAudio("304011069", var_285_19)
						arg_282_1:RecordAudio("304011069", var_285_19)
					else
						arg_282_1:AudioAction("play", "voice", "story_v_out_304011", "304011069", "story_v_out_304011.awb")
					end

					arg_282_1:RecordHistoryTalkVoice("story_v_out_304011", "304011069", "story_v_out_304011.awb")
				end

				arg_282_1:RecordContent(arg_282_1.text_.text)
			end

			local var_285_20 = math.max(var_285_11, arg_282_1.talkMaxDuration)

			if var_285_10 <= arg_282_1.time_ and arg_282_1.time_ < var_285_10 + var_285_20 then
				arg_282_1.typewritter.percent = (arg_282_1.time_ - var_285_10) / var_285_20

				arg_282_1.typewritter:SetDirty()
			end

			if arg_282_1.time_ >= var_285_10 + var_285_20 and arg_282_1.time_ < var_285_10 + var_285_20 + arg_285_0 then
				arg_282_1.typewritter.percent = 1

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(true)
			end
		end

		arg_282_1.nodeConfigList_ = {}

		arg_282_1:InitPlayNodeList()
	end,
	Play304011070 = function(arg_286_0, arg_286_1)
		arg_286_1.time_ = 0
		arg_286_1.frameCnt_ = 0
		arg_286_1.state_ = "playing"
		arg_286_1.curTalkId_ = 304011070
		arg_286_1.duration_ = 5.47

		local var_286_0 = {
			zh = 5.333,
			ja = 5.466
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
				arg_286_0:Play304011071(arg_286_1)
			end
		end

		function arg_286_1.onSingleLineUpdate_(arg_289_0)
			local var_289_0 = 0

			if var_289_0 < arg_286_1.time_ and arg_286_1.time_ <= var_289_0 + arg_289_0 then
				arg_286_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action5_1")
			end

			local var_289_1 = 0

			if var_289_1 < arg_286_1.time_ and arg_286_1.time_ <= var_289_1 + arg_289_0 then
				arg_286_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_289_2 = 0
			local var_289_3 = 0.7

			if var_289_2 < arg_286_1.time_ and arg_286_1.time_ <= var_289_2 + arg_289_0 then
				arg_286_1.talkMaxDuration = 0
				arg_286_1.dialogCg_.alpha = 1

				arg_286_1.dialog_:SetActive(true)
				SetActive(arg_286_1.leftNameGo_, true)

				local var_289_4 = arg_286_1:FormatText(StoryNameCfg[8].name)

				arg_286_1.leftNameTxt_.text = var_289_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_286_1.leftNameTxt_.transform)

				arg_286_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_286_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_286_1:RecordName(arg_286_1.leftNameTxt_.text)
				SetActive(arg_286_1.iconTrs_.gameObject, false)
				arg_286_1.callingController_:SetSelectedState("normal")

				local var_289_5 = arg_286_1:GetWordFromCfg(304011070)
				local var_289_6 = arg_286_1:FormatText(var_289_5.content)

				arg_286_1.text_.text = var_289_6

				LuaForUtil.ClearLinePrefixSymbol(arg_286_1.text_)

				local var_289_7 = 28
				local var_289_8 = utf8.len(var_289_6)
				local var_289_9 = var_289_7 <= 0 and var_289_3 or var_289_3 * (var_289_8 / var_289_7)

				if var_289_9 > 0 and var_289_3 < var_289_9 then
					arg_286_1.talkMaxDuration = var_289_9

					if var_289_9 + var_289_2 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_9 + var_289_2
					end
				end

				arg_286_1.text_.text = var_289_6
				arg_286_1.typewritter.percent = 0

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304011", "304011070", "story_v_out_304011.awb") ~= 0 then
					local var_289_10 = manager.audio:GetVoiceLength("story_v_out_304011", "304011070", "story_v_out_304011.awb") / 1000

					if var_289_10 + var_289_2 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_10 + var_289_2
					end

					if var_289_5.prefab_name ~= "" and arg_286_1.actors_[var_289_5.prefab_name] ~= nil then
						local var_289_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_286_1.actors_[var_289_5.prefab_name].transform, "story_v_out_304011", "304011070", "story_v_out_304011.awb")

						arg_286_1:RecordAudio("304011070", var_289_11)
						arg_286_1:RecordAudio("304011070", var_289_11)
					else
						arg_286_1:AudioAction("play", "voice", "story_v_out_304011", "304011070", "story_v_out_304011.awb")
					end

					arg_286_1:RecordHistoryTalkVoice("story_v_out_304011", "304011070", "story_v_out_304011.awb")
				end

				arg_286_1:RecordContent(arg_286_1.text_.text)
			end

			local var_289_12 = math.max(var_289_3, arg_286_1.talkMaxDuration)

			if var_289_2 <= arg_286_1.time_ and arg_286_1.time_ < var_289_2 + var_289_12 then
				arg_286_1.typewritter.percent = (arg_286_1.time_ - var_289_2) / var_289_12

				arg_286_1.typewritter:SetDirty()
			end

			if arg_286_1.time_ >= var_289_2 + var_289_12 and arg_286_1.time_ < var_289_2 + var_289_12 + arg_289_0 then
				arg_286_1.typewritter.percent = 1

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(true)
			end
		end

		arg_286_1.nodeConfigList_ = {}

		arg_286_1:InitPlayNodeList()
	end,
	Play304011071 = function(arg_290_0, arg_290_1)
		arg_290_1.time_ = 0
		arg_290_1.frameCnt_ = 0
		arg_290_1.state_ = "playing"
		arg_290_1.curTalkId_ = 304011071
		arg_290_1.duration_ = 5.8

		local var_290_0 = {
			zh = 2.6,
			ja = 5.8
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
				arg_290_0:Play304011072(arg_290_1)
			end
		end

		function arg_290_1.onSingleLineUpdate_(arg_293_0)
			local var_293_0 = arg_290_1.actors_["1059ui_story"]
			local var_293_1 = 0

			if var_293_1 < arg_290_1.time_ and arg_290_1.time_ <= var_293_1 + arg_293_0 and not isNil(var_293_0) and arg_290_1.var_.characterEffect1059ui_story == nil then
				arg_290_1.var_.characterEffect1059ui_story = var_293_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_293_2 = 0.200000002980232

			if var_293_1 <= arg_290_1.time_ and arg_290_1.time_ < var_293_1 + var_293_2 and not isNil(var_293_0) then
				local var_293_3 = (arg_290_1.time_ - var_293_1) / var_293_2

				if arg_290_1.var_.characterEffect1059ui_story and not isNil(var_293_0) then
					arg_290_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_290_1.time_ >= var_293_1 + var_293_2 and arg_290_1.time_ < var_293_1 + var_293_2 + arg_293_0 and not isNil(var_293_0) and arg_290_1.var_.characterEffect1059ui_story then
				arg_290_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_293_4 = arg_290_1.actors_["1148ui_story"]
			local var_293_5 = 0

			if var_293_5 < arg_290_1.time_ and arg_290_1.time_ <= var_293_5 + arg_293_0 and not isNil(var_293_4) and arg_290_1.var_.characterEffect1148ui_story == nil then
				arg_290_1.var_.characterEffect1148ui_story = var_293_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_293_6 = 0.200000002980232

			if var_293_5 <= arg_290_1.time_ and arg_290_1.time_ < var_293_5 + var_293_6 and not isNil(var_293_4) then
				local var_293_7 = (arg_290_1.time_ - var_293_5) / var_293_6

				if arg_290_1.var_.characterEffect1148ui_story and not isNil(var_293_4) then
					local var_293_8 = Mathf.Lerp(0, 0.5, var_293_7)

					arg_290_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_290_1.var_.characterEffect1148ui_story.fillRatio = var_293_8
				end
			end

			if arg_290_1.time_ >= var_293_5 + var_293_6 and arg_290_1.time_ < var_293_5 + var_293_6 + arg_293_0 and not isNil(var_293_4) and arg_290_1.var_.characterEffect1148ui_story then
				local var_293_9 = 0.5

				arg_290_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_290_1.var_.characterEffect1148ui_story.fillRatio = var_293_9
			end

			local var_293_10 = 0

			if var_293_10 < arg_290_1.time_ and arg_290_1.time_ <= var_293_10 + arg_293_0 then
				arg_290_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059actionlink/1059action443")
			end

			local var_293_11 = 0
			local var_293_12 = 0.275

			if var_293_11 < arg_290_1.time_ and arg_290_1.time_ <= var_293_11 + arg_293_0 then
				arg_290_1.talkMaxDuration = 0
				arg_290_1.dialogCg_.alpha = 1

				arg_290_1.dialog_:SetActive(true)
				SetActive(arg_290_1.leftNameGo_, true)

				local var_293_13 = arg_290_1:FormatText(StoryNameCfg[28].name)

				arg_290_1.leftNameTxt_.text = var_293_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_290_1.leftNameTxt_.transform)

				arg_290_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_290_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_290_1:RecordName(arg_290_1.leftNameTxt_.text)
				SetActive(arg_290_1.iconTrs_.gameObject, false)
				arg_290_1.callingController_:SetSelectedState("normal")

				local var_293_14 = arg_290_1:GetWordFromCfg(304011071)
				local var_293_15 = arg_290_1:FormatText(var_293_14.content)

				arg_290_1.text_.text = var_293_15

				LuaForUtil.ClearLinePrefixSymbol(arg_290_1.text_)

				local var_293_16 = 11
				local var_293_17 = utf8.len(var_293_15)
				local var_293_18 = var_293_16 <= 0 and var_293_12 or var_293_12 * (var_293_17 / var_293_16)

				if var_293_18 > 0 and var_293_12 < var_293_18 then
					arg_290_1.talkMaxDuration = var_293_18

					if var_293_18 + var_293_11 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_18 + var_293_11
					end
				end

				arg_290_1.text_.text = var_293_15
				arg_290_1.typewritter.percent = 0

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304011", "304011071", "story_v_out_304011.awb") ~= 0 then
					local var_293_19 = manager.audio:GetVoiceLength("story_v_out_304011", "304011071", "story_v_out_304011.awb") / 1000

					if var_293_19 + var_293_11 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_19 + var_293_11
					end

					if var_293_14.prefab_name ~= "" and arg_290_1.actors_[var_293_14.prefab_name] ~= nil then
						local var_293_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_290_1.actors_[var_293_14.prefab_name].transform, "story_v_out_304011", "304011071", "story_v_out_304011.awb")

						arg_290_1:RecordAudio("304011071", var_293_20)
						arg_290_1:RecordAudio("304011071", var_293_20)
					else
						arg_290_1:AudioAction("play", "voice", "story_v_out_304011", "304011071", "story_v_out_304011.awb")
					end

					arg_290_1:RecordHistoryTalkVoice("story_v_out_304011", "304011071", "story_v_out_304011.awb")
				end

				arg_290_1:RecordContent(arg_290_1.text_.text)
			end

			local var_293_21 = math.max(var_293_12, arg_290_1.talkMaxDuration)

			if var_293_11 <= arg_290_1.time_ and arg_290_1.time_ < var_293_11 + var_293_21 then
				arg_290_1.typewritter.percent = (arg_290_1.time_ - var_293_11) / var_293_21

				arg_290_1.typewritter:SetDirty()
			end

			if arg_290_1.time_ >= var_293_11 + var_293_21 and arg_290_1.time_ < var_293_11 + var_293_21 + arg_293_0 then
				arg_290_1.typewritter.percent = 1

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(true)
			end
		end

		arg_290_1.nodeConfigList_ = {}

		arg_290_1:InitPlayNodeList()
	end,
	Play304011072 = function(arg_294_0, arg_294_1)
		arg_294_1.time_ = 0
		arg_294_1.frameCnt_ = 0
		arg_294_1.state_ = "playing"
		arg_294_1.curTalkId_ = 304011072
		arg_294_1.duration_ = 10.5

		local var_294_0 = {
			zh = 4.266,
			ja = 10.5
		}
		local var_294_1 = manager.audio:GetLocalizationFlag()

		if var_294_0[var_294_1] ~= nil then
			arg_294_1.duration_ = var_294_0[var_294_1]
		end

		SetActive(arg_294_1.tipsGo_, false)

		function arg_294_1.onSingleLineFinish_()
			arg_294_1.onSingleLineUpdate_ = nil
			arg_294_1.onSingleLineFinish_ = nil
			arg_294_1.state_ = "waiting"
		end

		function arg_294_1.playNext_(arg_296_0)
			if arg_296_0 == 1 then
				arg_294_0:Play304011073(arg_294_1)
			end
		end

		function arg_294_1.onSingleLineUpdate_(arg_297_0)
			local var_297_0 = 0
			local var_297_1 = 0.6

			if var_297_0 < arg_294_1.time_ and arg_294_1.time_ <= var_297_0 + arg_297_0 then
				arg_294_1.talkMaxDuration = 0
				arg_294_1.dialogCg_.alpha = 1

				arg_294_1.dialog_:SetActive(true)
				SetActive(arg_294_1.leftNameGo_, true)

				local var_297_2 = arg_294_1:FormatText(StoryNameCfg[28].name)

				arg_294_1.leftNameTxt_.text = var_297_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_294_1.leftNameTxt_.transform)

				arg_294_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_294_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_294_1:RecordName(arg_294_1.leftNameTxt_.text)
				SetActive(arg_294_1.iconTrs_.gameObject, false)
				arg_294_1.callingController_:SetSelectedState("normal")

				local var_297_3 = arg_294_1:GetWordFromCfg(304011072)
				local var_297_4 = arg_294_1:FormatText(var_297_3.content)

				arg_294_1.text_.text = var_297_4

				LuaForUtil.ClearLinePrefixSymbol(arg_294_1.text_)

				local var_297_5 = 24
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

				if manager.audio:GetVoiceLength("story_v_out_304011", "304011072", "story_v_out_304011.awb") ~= 0 then
					local var_297_8 = manager.audio:GetVoiceLength("story_v_out_304011", "304011072", "story_v_out_304011.awb") / 1000

					if var_297_8 + var_297_0 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_8 + var_297_0
					end

					if var_297_3.prefab_name ~= "" and arg_294_1.actors_[var_297_3.prefab_name] ~= nil then
						local var_297_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_294_1.actors_[var_297_3.prefab_name].transform, "story_v_out_304011", "304011072", "story_v_out_304011.awb")

						arg_294_1:RecordAudio("304011072", var_297_9)
						arg_294_1:RecordAudio("304011072", var_297_9)
					else
						arg_294_1:AudioAction("play", "voice", "story_v_out_304011", "304011072", "story_v_out_304011.awb")
					end

					arg_294_1:RecordHistoryTalkVoice("story_v_out_304011", "304011072", "story_v_out_304011.awb")
				end

				arg_294_1:RecordContent(arg_294_1.text_.text)
			end

			local var_297_10 = math.max(var_297_1, arg_294_1.talkMaxDuration)

			if var_297_0 <= arg_294_1.time_ and arg_294_1.time_ < var_297_0 + var_297_10 then
				arg_294_1.typewritter.percent = (arg_294_1.time_ - var_297_0) / var_297_10

				arg_294_1.typewritter:SetDirty()
			end

			if arg_294_1.time_ >= var_297_0 + var_297_10 and arg_294_1.time_ < var_297_0 + var_297_10 + arg_297_0 then
				arg_294_1.typewritter.percent = 1

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(true)
			end
		end

		arg_294_1.nodeConfigList_ = {}

		arg_294_1:InitPlayNodeList()
	end,
	Play304011073 = function(arg_298_0, arg_298_1)
		arg_298_1.time_ = 0
		arg_298_1.frameCnt_ = 0
		arg_298_1.state_ = "playing"
		arg_298_1.curTalkId_ = 304011073
		arg_298_1.duration_ = 6.37

		local var_298_0 = {
			zh = 4.366,
			ja = 6.366
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
				arg_298_0:Play304011074(arg_298_1)
			end
		end

		function arg_298_1.onSingleLineUpdate_(arg_301_0)
			local var_301_0 = arg_298_1.actors_["1148ui_story"]
			local var_301_1 = 0

			if var_301_1 < arg_298_1.time_ and arg_298_1.time_ <= var_301_1 + arg_301_0 and not isNil(var_301_0) and arg_298_1.var_.characterEffect1148ui_story == nil then
				arg_298_1.var_.characterEffect1148ui_story = var_301_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_301_2 = 0.200000002980232

			if var_301_1 <= arg_298_1.time_ and arg_298_1.time_ < var_301_1 + var_301_2 and not isNil(var_301_0) then
				local var_301_3 = (arg_298_1.time_ - var_301_1) / var_301_2

				if arg_298_1.var_.characterEffect1148ui_story and not isNil(var_301_0) then
					arg_298_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_298_1.time_ >= var_301_1 + var_301_2 and arg_298_1.time_ < var_301_1 + var_301_2 + arg_301_0 and not isNil(var_301_0) and arg_298_1.var_.characterEffect1148ui_story then
				arg_298_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_301_4 = arg_298_1.actors_["1059ui_story"]
			local var_301_5 = 0

			if var_301_5 < arg_298_1.time_ and arg_298_1.time_ <= var_301_5 + arg_301_0 and not isNil(var_301_4) and arg_298_1.var_.characterEffect1059ui_story == nil then
				arg_298_1.var_.characterEffect1059ui_story = var_301_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_301_6 = 0.200000002980232

			if var_301_5 <= arg_298_1.time_ and arg_298_1.time_ < var_301_5 + var_301_6 and not isNil(var_301_4) then
				local var_301_7 = (arg_298_1.time_ - var_301_5) / var_301_6

				if arg_298_1.var_.characterEffect1059ui_story and not isNil(var_301_4) then
					local var_301_8 = Mathf.Lerp(0, 0.5, var_301_7)

					arg_298_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_298_1.var_.characterEffect1059ui_story.fillRatio = var_301_8
				end
			end

			if arg_298_1.time_ >= var_301_5 + var_301_6 and arg_298_1.time_ < var_301_5 + var_301_6 + arg_301_0 and not isNil(var_301_4) and arg_298_1.var_.characterEffect1059ui_story then
				local var_301_9 = 0.5

				arg_298_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_298_1.var_.characterEffect1059ui_story.fillRatio = var_301_9
			end

			local var_301_10 = 0

			if var_301_10 < arg_298_1.time_ and arg_298_1.time_ <= var_301_10 + arg_301_0 then
				arg_298_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action5_2")
			end

			local var_301_11 = 0

			if var_301_11 < arg_298_1.time_ and arg_298_1.time_ <= var_301_11 + arg_301_0 then
				arg_298_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_301_12 = 0
			local var_301_13 = 0.4

			if var_301_12 < arg_298_1.time_ and arg_298_1.time_ <= var_301_12 + arg_301_0 then
				arg_298_1.talkMaxDuration = 0
				arg_298_1.dialogCg_.alpha = 1

				arg_298_1.dialog_:SetActive(true)
				SetActive(arg_298_1.leftNameGo_, true)

				local var_301_14 = arg_298_1:FormatText(StoryNameCfg[8].name)

				arg_298_1.leftNameTxt_.text = var_301_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_298_1.leftNameTxt_.transform)

				arg_298_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_298_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_298_1:RecordName(arg_298_1.leftNameTxt_.text)
				SetActive(arg_298_1.iconTrs_.gameObject, false)
				arg_298_1.callingController_:SetSelectedState("normal")

				local var_301_15 = arg_298_1:GetWordFromCfg(304011073)
				local var_301_16 = arg_298_1:FormatText(var_301_15.content)

				arg_298_1.text_.text = var_301_16

				LuaForUtil.ClearLinePrefixSymbol(arg_298_1.text_)

				local var_301_17 = 16
				local var_301_18 = utf8.len(var_301_16)
				local var_301_19 = var_301_17 <= 0 and var_301_13 or var_301_13 * (var_301_18 / var_301_17)

				if var_301_19 > 0 and var_301_13 < var_301_19 then
					arg_298_1.talkMaxDuration = var_301_19

					if var_301_19 + var_301_12 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_19 + var_301_12
					end
				end

				arg_298_1.text_.text = var_301_16
				arg_298_1.typewritter.percent = 0

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304011", "304011073", "story_v_out_304011.awb") ~= 0 then
					local var_301_20 = manager.audio:GetVoiceLength("story_v_out_304011", "304011073", "story_v_out_304011.awb") / 1000

					if var_301_20 + var_301_12 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_20 + var_301_12
					end

					if var_301_15.prefab_name ~= "" and arg_298_1.actors_[var_301_15.prefab_name] ~= nil then
						local var_301_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_298_1.actors_[var_301_15.prefab_name].transform, "story_v_out_304011", "304011073", "story_v_out_304011.awb")

						arg_298_1:RecordAudio("304011073", var_301_21)
						arg_298_1:RecordAudio("304011073", var_301_21)
					else
						arg_298_1:AudioAction("play", "voice", "story_v_out_304011", "304011073", "story_v_out_304011.awb")
					end

					arg_298_1:RecordHistoryTalkVoice("story_v_out_304011", "304011073", "story_v_out_304011.awb")
				end

				arg_298_1:RecordContent(arg_298_1.text_.text)
			end

			local var_301_22 = math.max(var_301_13, arg_298_1.talkMaxDuration)

			if var_301_12 <= arg_298_1.time_ and arg_298_1.time_ < var_301_12 + var_301_22 then
				arg_298_1.typewritter.percent = (arg_298_1.time_ - var_301_12) / var_301_22

				arg_298_1.typewritter:SetDirty()
			end

			if arg_298_1.time_ >= var_301_12 + var_301_22 and arg_298_1.time_ < var_301_12 + var_301_22 + arg_301_0 then
				arg_298_1.typewritter.percent = 1

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(true)
			end
		end

		arg_298_1.nodeConfigList_ = {}

		arg_298_1:InitPlayNodeList()
	end,
	Play304011074 = function(arg_302_0, arg_302_1)
		arg_302_1.time_ = 0
		arg_302_1.frameCnt_ = 0
		arg_302_1.state_ = "playing"
		arg_302_1.curTalkId_ = 304011074
		arg_302_1.duration_ = 7.8

		local var_302_0 = {
			zh = 4.533,
			ja = 7.8
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
				arg_302_0:Play304011075(arg_302_1)
			end
		end

		function arg_302_1.onSingleLineUpdate_(arg_305_0)
			local var_305_0 = arg_302_1.actors_["1059ui_story"]
			local var_305_1 = 0

			if var_305_1 < arg_302_1.time_ and arg_302_1.time_ <= var_305_1 + arg_305_0 and not isNil(var_305_0) and arg_302_1.var_.characterEffect1059ui_story == nil then
				arg_302_1.var_.characterEffect1059ui_story = var_305_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_305_2 = 0.200000002980232

			if var_305_1 <= arg_302_1.time_ and arg_302_1.time_ < var_305_1 + var_305_2 and not isNil(var_305_0) then
				local var_305_3 = (arg_302_1.time_ - var_305_1) / var_305_2

				if arg_302_1.var_.characterEffect1059ui_story and not isNil(var_305_0) then
					arg_302_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_302_1.time_ >= var_305_1 + var_305_2 and arg_302_1.time_ < var_305_1 + var_305_2 + arg_305_0 and not isNil(var_305_0) and arg_302_1.var_.characterEffect1059ui_story then
				arg_302_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_305_4 = arg_302_1.actors_["1148ui_story"]
			local var_305_5 = 0

			if var_305_5 < arg_302_1.time_ and arg_302_1.time_ <= var_305_5 + arg_305_0 and not isNil(var_305_4) and arg_302_1.var_.characterEffect1148ui_story == nil then
				arg_302_1.var_.characterEffect1148ui_story = var_305_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_305_6 = 0.200000002980232

			if var_305_5 <= arg_302_1.time_ and arg_302_1.time_ < var_305_5 + var_305_6 and not isNil(var_305_4) then
				local var_305_7 = (arg_302_1.time_ - var_305_5) / var_305_6

				if arg_302_1.var_.characterEffect1148ui_story and not isNil(var_305_4) then
					local var_305_8 = Mathf.Lerp(0, 0.5, var_305_7)

					arg_302_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_302_1.var_.characterEffect1148ui_story.fillRatio = var_305_8
				end
			end

			if arg_302_1.time_ >= var_305_5 + var_305_6 and arg_302_1.time_ < var_305_5 + var_305_6 + arg_305_0 and not isNil(var_305_4) and arg_302_1.var_.characterEffect1148ui_story then
				local var_305_9 = 0.5

				arg_302_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_302_1.var_.characterEffect1148ui_story.fillRatio = var_305_9
			end

			local var_305_10 = 0

			if var_305_10 < arg_302_1.time_ and arg_302_1.time_ <= var_305_10 + arg_305_0 then
				arg_302_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059action/1059action3_2")
			end

			local var_305_11 = 0

			if var_305_11 < arg_302_1.time_ and arg_302_1.time_ <= var_305_11 + arg_305_0 then
				arg_302_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_305_12 = 0
			local var_305_13 = 0.65

			if var_305_12 < arg_302_1.time_ and arg_302_1.time_ <= var_305_12 + arg_305_0 then
				arg_302_1.talkMaxDuration = 0
				arg_302_1.dialogCg_.alpha = 1

				arg_302_1.dialog_:SetActive(true)
				SetActive(arg_302_1.leftNameGo_, true)

				local var_305_14 = arg_302_1:FormatText(StoryNameCfg[28].name)

				arg_302_1.leftNameTxt_.text = var_305_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_302_1.leftNameTxt_.transform)

				arg_302_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_302_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_302_1:RecordName(arg_302_1.leftNameTxt_.text)
				SetActive(arg_302_1.iconTrs_.gameObject, false)
				arg_302_1.callingController_:SetSelectedState("normal")

				local var_305_15 = arg_302_1:GetWordFromCfg(304011074)
				local var_305_16 = arg_302_1:FormatText(var_305_15.content)

				arg_302_1.text_.text = var_305_16

				LuaForUtil.ClearLinePrefixSymbol(arg_302_1.text_)

				local var_305_17 = 26
				local var_305_18 = utf8.len(var_305_16)
				local var_305_19 = var_305_17 <= 0 and var_305_13 or var_305_13 * (var_305_18 / var_305_17)

				if var_305_19 > 0 and var_305_13 < var_305_19 then
					arg_302_1.talkMaxDuration = var_305_19

					if var_305_19 + var_305_12 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_19 + var_305_12
					end
				end

				arg_302_1.text_.text = var_305_16
				arg_302_1.typewritter.percent = 0

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304011", "304011074", "story_v_out_304011.awb") ~= 0 then
					local var_305_20 = manager.audio:GetVoiceLength("story_v_out_304011", "304011074", "story_v_out_304011.awb") / 1000

					if var_305_20 + var_305_12 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_20 + var_305_12
					end

					if var_305_15.prefab_name ~= "" and arg_302_1.actors_[var_305_15.prefab_name] ~= nil then
						local var_305_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_302_1.actors_[var_305_15.prefab_name].transform, "story_v_out_304011", "304011074", "story_v_out_304011.awb")

						arg_302_1:RecordAudio("304011074", var_305_21)
						arg_302_1:RecordAudio("304011074", var_305_21)
					else
						arg_302_1:AudioAction("play", "voice", "story_v_out_304011", "304011074", "story_v_out_304011.awb")
					end

					arg_302_1:RecordHistoryTalkVoice("story_v_out_304011", "304011074", "story_v_out_304011.awb")
				end

				arg_302_1:RecordContent(arg_302_1.text_.text)
			end

			local var_305_22 = math.max(var_305_13, arg_302_1.talkMaxDuration)

			if var_305_12 <= arg_302_1.time_ and arg_302_1.time_ < var_305_12 + var_305_22 then
				arg_302_1.typewritter.percent = (arg_302_1.time_ - var_305_12) / var_305_22

				arg_302_1.typewritter:SetDirty()
			end

			if arg_302_1.time_ >= var_305_12 + var_305_22 and arg_302_1.time_ < var_305_12 + var_305_22 + arg_305_0 then
				arg_302_1.typewritter.percent = 1

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(true)
			end
		end

		arg_302_1.nodeConfigList_ = {}

		arg_302_1:InitPlayNodeList()
	end,
	Play304011075 = function(arg_306_0, arg_306_1)
		arg_306_1.time_ = 0
		arg_306_1.frameCnt_ = 0
		arg_306_1.state_ = "playing"
		arg_306_1.curTalkId_ = 304011075
		arg_306_1.duration_ = 5.2

		local var_306_0 = {
			zh = 5.2,
			ja = 3.666
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
				arg_306_0:Play304011076(arg_306_1)
			end
		end

		function arg_306_1.onSingleLineUpdate_(arg_309_0)
			local var_309_0 = 0
			local var_309_1 = 0.675

			if var_309_0 < arg_306_1.time_ and arg_306_1.time_ <= var_309_0 + arg_309_0 then
				arg_306_1.talkMaxDuration = 0
				arg_306_1.dialogCg_.alpha = 1

				arg_306_1.dialog_:SetActive(true)
				SetActive(arg_306_1.leftNameGo_, true)

				local var_309_2 = arg_306_1:FormatText(StoryNameCfg[28].name)

				arg_306_1.leftNameTxt_.text = var_309_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_306_1.leftNameTxt_.transform)

				arg_306_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_306_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_306_1:RecordName(arg_306_1.leftNameTxt_.text)
				SetActive(arg_306_1.iconTrs_.gameObject, false)
				arg_306_1.callingController_:SetSelectedState("normal")

				local var_309_3 = arg_306_1:GetWordFromCfg(304011075)
				local var_309_4 = arg_306_1:FormatText(var_309_3.content)

				arg_306_1.text_.text = var_309_4

				LuaForUtil.ClearLinePrefixSymbol(arg_306_1.text_)

				local var_309_5 = 27
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

				if manager.audio:GetVoiceLength("story_v_out_304011", "304011075", "story_v_out_304011.awb") ~= 0 then
					local var_309_8 = manager.audio:GetVoiceLength("story_v_out_304011", "304011075", "story_v_out_304011.awb") / 1000

					if var_309_8 + var_309_0 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_8 + var_309_0
					end

					if var_309_3.prefab_name ~= "" and arg_306_1.actors_[var_309_3.prefab_name] ~= nil then
						local var_309_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_306_1.actors_[var_309_3.prefab_name].transform, "story_v_out_304011", "304011075", "story_v_out_304011.awb")

						arg_306_1:RecordAudio("304011075", var_309_9)
						arg_306_1:RecordAudio("304011075", var_309_9)
					else
						arg_306_1:AudioAction("play", "voice", "story_v_out_304011", "304011075", "story_v_out_304011.awb")
					end

					arg_306_1:RecordHistoryTalkVoice("story_v_out_304011", "304011075", "story_v_out_304011.awb")
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
	Play304011076 = function(arg_310_0, arg_310_1)
		arg_310_1.time_ = 0
		arg_310_1.frameCnt_ = 0
		arg_310_1.state_ = "playing"
		arg_310_1.curTalkId_ = 304011076
		arg_310_1.duration_ = 2.17

		SetActive(arg_310_1.tipsGo_, false)

		function arg_310_1.onSingleLineFinish_()
			arg_310_1.onSingleLineUpdate_ = nil
			arg_310_1.onSingleLineFinish_ = nil
			arg_310_1.state_ = "waiting"
		end

		function arg_310_1.playNext_(arg_312_0)
			if arg_312_0 == 1 then
				arg_310_0:Play304011077(arg_310_1)
			end
		end

		function arg_310_1.onSingleLineUpdate_(arg_313_0)
			local var_313_0 = arg_310_1.actors_["1059ui_story"].transform
			local var_313_1 = 0

			if var_313_1 < arg_310_1.time_ and arg_310_1.time_ <= var_313_1 + arg_313_0 then
				arg_310_1.var_.moveOldPos1059ui_story = var_313_0.localPosition
			end

			local var_313_2 = 0.001

			if var_313_1 <= arg_310_1.time_ and arg_310_1.time_ < var_313_1 + var_313_2 then
				local var_313_3 = (arg_310_1.time_ - var_313_1) / var_313_2
				local var_313_4 = Vector3.New(0, 100, 0)

				var_313_0.localPosition = Vector3.Lerp(arg_310_1.var_.moveOldPos1059ui_story, var_313_4, var_313_3)

				local var_313_5 = manager.ui.mainCamera.transform.position - var_313_0.position

				var_313_0.forward = Vector3.New(var_313_5.x, var_313_5.y, var_313_5.z)

				local var_313_6 = var_313_0.localEulerAngles

				var_313_6.z = 0
				var_313_6.x = 0
				var_313_0.localEulerAngles = var_313_6
			end

			if arg_310_1.time_ >= var_313_1 + var_313_2 and arg_310_1.time_ < var_313_1 + var_313_2 + arg_313_0 then
				var_313_0.localPosition = Vector3.New(0, 100, 0)

				local var_313_7 = manager.ui.mainCamera.transform.position - var_313_0.position

				var_313_0.forward = Vector3.New(var_313_7.x, var_313_7.y, var_313_7.z)

				local var_313_8 = var_313_0.localEulerAngles

				var_313_8.z = 0
				var_313_8.x = 0
				var_313_0.localEulerAngles = var_313_8
			end

			local var_313_9 = arg_310_1.actors_["1148ui_story"].transform
			local var_313_10 = 0

			if var_313_10 < arg_310_1.time_ and arg_310_1.time_ <= var_313_10 + arg_313_0 then
				arg_310_1.var_.moveOldPos1148ui_story = var_313_9.localPosition
			end

			local var_313_11 = 0.001

			if var_313_10 <= arg_310_1.time_ and arg_310_1.time_ < var_313_10 + var_313_11 then
				local var_313_12 = (arg_310_1.time_ - var_313_10) / var_313_11
				local var_313_13 = Vector3.New(0, 100, 0)

				var_313_9.localPosition = Vector3.Lerp(arg_310_1.var_.moveOldPos1148ui_story, var_313_13, var_313_12)

				local var_313_14 = manager.ui.mainCamera.transform.position - var_313_9.position

				var_313_9.forward = Vector3.New(var_313_14.x, var_313_14.y, var_313_14.z)

				local var_313_15 = var_313_9.localEulerAngles

				var_313_15.z = 0
				var_313_15.x = 0
				var_313_9.localEulerAngles = var_313_15
			end

			if arg_310_1.time_ >= var_313_10 + var_313_11 and arg_310_1.time_ < var_313_10 + var_313_11 + arg_313_0 then
				var_313_9.localPosition = Vector3.New(0, 100, 0)

				local var_313_16 = manager.ui.mainCamera.transform.position - var_313_9.position

				var_313_9.forward = Vector3.New(var_313_16.x, var_313_16.y, var_313_16.z)

				local var_313_17 = var_313_9.localEulerAngles

				var_313_17.z = 0
				var_313_17.x = 0
				var_313_9.localEulerAngles = var_313_17
			end

			local var_313_18 = arg_310_1.actors_["1059ui_story"]
			local var_313_19 = 0

			if var_313_19 < arg_310_1.time_ and arg_310_1.time_ <= var_313_19 + arg_313_0 and not isNil(var_313_18) and arg_310_1.var_.characterEffect1059ui_story == nil then
				arg_310_1.var_.characterEffect1059ui_story = var_313_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_313_20 = 0.200000002980232

			if var_313_19 <= arg_310_1.time_ and arg_310_1.time_ < var_313_19 + var_313_20 and not isNil(var_313_18) then
				local var_313_21 = (arg_310_1.time_ - var_313_19) / var_313_20

				if arg_310_1.var_.characterEffect1059ui_story and not isNil(var_313_18) then
					local var_313_22 = Mathf.Lerp(0, 0.5, var_313_21)

					arg_310_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_310_1.var_.characterEffect1059ui_story.fillRatio = var_313_22
				end
			end

			if arg_310_1.time_ >= var_313_19 + var_313_20 and arg_310_1.time_ < var_313_19 + var_313_20 + arg_313_0 and not isNil(var_313_18) and arg_310_1.var_.characterEffect1059ui_story then
				local var_313_23 = 0.5

				arg_310_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_310_1.var_.characterEffect1059ui_story.fillRatio = var_313_23
			end

			local var_313_24 = 0

			if var_313_24 < arg_310_1.time_ and arg_310_1.time_ <= var_313_24 + arg_313_0 then
				arg_310_1.allBtn_.enabled = false
			end

			local var_313_25 = 1.55

			if arg_310_1.time_ >= var_313_24 + var_313_25 and arg_310_1.time_ < var_313_24 + var_313_25 + arg_313_0 then
				arg_310_1.allBtn_.enabled = true
			end

			local var_313_26 = 0
			local var_313_27 = 1

			if var_313_26 < arg_310_1.time_ and arg_310_1.time_ <= var_313_26 + arg_313_0 then
				local var_313_28 = "play"
				local var_313_29 = "effect"

				arg_310_1:AudioAction(var_313_28, var_313_29, "ui_battle", "ui_battle_stopbgm", "")
			end

			if arg_310_1.frameCnt_ <= 1 then
				arg_310_1.dialog_:SetActive(false)
			end

			local var_313_30 = 0.766666666666667
			local var_313_31 = 1.4

			if var_313_30 < arg_310_1.time_ and arg_310_1.time_ <= var_313_30 + arg_313_0 then
				arg_310_1.talkMaxDuration = 0

				arg_310_1.dialog_:SetActive(true)

				arg_310_1.dialogCg_.alpha = 0

				local var_313_32 = LeanTween.value(arg_310_1.dialog_, 0, 1, 0.3)

				var_313_32:setOnUpdate(LuaHelper.FloatAction(function(arg_314_0)
					arg_310_1.dialogCg_.alpha = arg_314_0
				end))
				var_313_32:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_310_1.dialog_)
					var_313_32:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_310_1.duration_ = arg_310_1.duration_ + 0.3

				SetActive(arg_310_1.leftNameGo_, false)

				arg_310_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_310_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_310_1:RecordName(arg_310_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_310_1.iconTrs_.gameObject, false)
				arg_310_1.callingController_:SetSelectedState("normal")

				local var_313_33 = arg_310_1:GetWordFromCfg(304011076)
				local var_313_34 = arg_310_1:FormatText(var_313_33.content)

				arg_310_1.text_.text = var_313_34

				LuaForUtil.ClearLinePrefixSymbol(arg_310_1.text_)

				local var_313_35 = 56
				local var_313_36 = utf8.len(var_313_34)
				local var_313_37 = var_313_35 <= 0 and var_313_31 or var_313_31 * (var_313_36 / var_313_35)

				if var_313_37 > 0 and var_313_31 < var_313_37 then
					arg_310_1.talkMaxDuration = var_313_37
					var_313_30 = var_313_30 + 0.3

					if var_313_37 + var_313_30 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_37 + var_313_30
					end
				end

				arg_310_1.text_.text = var_313_34
				arg_310_1.typewritter.percent = 0

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304011", "304011076", "story_v_out_304011.awb") ~= 0 then
					local var_313_38 = manager.audio:GetVoiceLength("story_v_out_304011", "304011076", "story_v_out_304011.awb") / 1000

					if var_313_38 + var_313_30 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_38 + var_313_30
					end

					if var_313_33.prefab_name ~= "" and arg_310_1.actors_[var_313_33.prefab_name] ~= nil then
						local var_313_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_310_1.actors_[var_313_33.prefab_name].transform, "story_v_out_304011", "304011076", "story_v_out_304011.awb")

						arg_310_1:RecordAudio("304011076", var_313_39)
						arg_310_1:RecordAudio("304011076", var_313_39)
					else
						arg_310_1:AudioAction("play", "voice", "story_v_out_304011", "304011076", "story_v_out_304011.awb")
					end

					arg_310_1:RecordHistoryTalkVoice("story_v_out_304011", "304011076", "story_v_out_304011.awb")
				end

				arg_310_1:RecordContent(arg_310_1.text_.text)
			end

			local var_313_40 = var_313_30 + 0.3
			local var_313_41 = math.max(var_313_31, arg_310_1.talkMaxDuration)

			if var_313_40 <= arg_310_1.time_ and arg_310_1.time_ < var_313_40 + var_313_41 then
				arg_310_1.typewritter.percent = (arg_310_1.time_ - var_313_40) / var_313_41

				arg_310_1.typewritter:SetDirty()
			end

			if arg_310_1.time_ >= var_313_40 + var_313_41 and arg_310_1.time_ < var_313_40 + var_313_41 + arg_313_0 then
				arg_310_1.typewritter.percent = 1

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(true)
			end
		end

		arg_310_1.nodeConfigList_ = {
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
				actorName = "1148ui_story",
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
				frequencyGain = 2,
				className = "StoryShakeNode",
				noiseSettingsAssetPath = "Camera/Noise/6D_Shake",
				duration = 0.799999997019768,
				amplitudeGain = 0.3,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.None,
				shakeTarget = StoryPlayerConst.SHAKE_TARGET.CAMERA
			}
		}

		arg_310_1:InitPlayNodeList()
	end,
	Play304011077 = function(arg_316_0, arg_316_1)
		arg_316_1.time_ = 0
		arg_316_1.frameCnt_ = 0
		arg_316_1.state_ = "playing"
		arg_316_1.curTalkId_ = 304011077
		arg_316_1.duration_ = 9.1

		local var_316_0 = {
			zh = 9.1,
			ja = 3.499999999999
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
				arg_316_0:Play304011078(arg_316_1)
			end
		end

		function arg_316_1.onSingleLineUpdate_(arg_319_0)
			local var_319_0 = arg_316_1.actors_["2044ui_story"]
			local var_319_1 = 0

			if var_319_1 < arg_316_1.time_ and arg_316_1.time_ <= var_319_1 + arg_319_0 and not isNil(var_319_0) and arg_316_1.var_.characterEffect2044ui_story == nil then
				arg_316_1.var_.characterEffect2044ui_story = var_319_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_319_2 = 0.200000002980232

			if var_319_1 <= arg_316_1.time_ and arg_316_1.time_ < var_319_1 + var_319_2 and not isNil(var_319_0) then
				local var_319_3 = (arg_316_1.time_ - var_319_1) / var_319_2

				if arg_316_1.var_.characterEffect2044ui_story and not isNil(var_319_0) then
					arg_316_1.var_.characterEffect2044ui_story.fillFlat = false
				end
			end

			if arg_316_1.time_ >= var_319_1 + var_319_2 and arg_316_1.time_ < var_319_1 + var_319_2 + arg_319_0 and not isNil(var_319_0) and arg_316_1.var_.characterEffect2044ui_story then
				arg_316_1.var_.characterEffect2044ui_story.fillFlat = false
			end

			local var_319_4 = manager.ui.mainCamera.transform
			local var_319_5 = 0

			if var_319_5 < arg_316_1.time_ and arg_316_1.time_ <= var_319_5 + arg_319_0 then
				local var_319_6 = arg_316_1.var_.effectQWE
				local var_319_7
				local var_319_8 = var_319_4

				if not var_319_6 then
					var_319_6 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_error"), var_319_8)
					var_319_6.name = "QWE"
					arg_316_1.var_.effectQWE = var_319_6
				else
					var_319_6.transform:SetParent(var_319_8)
				end

				var_319_6.transform.localPosition = Vector3.New(0, 0, 0)
				var_319_6.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_319_9 = 1.7777777777777777
				local var_319_10 = Screen.width / Screen.height
				local var_319_11 = var_319_10 / var_319_9
				local var_319_12 = Mathf.Max(var_319_9 / var_319_10, 1)

				var_319_6.transform.localScale = Vector3.New(var_319_6.transform.localScale.x * var_319_11, var_319_6.transform.localScale.y * var_319_12, var_319_6.transform.localScale.z)
			end

			local var_319_13 = manager.ui.mainCamera.transform
			local var_319_14 = 1.75

			if var_319_14 < arg_316_1.time_ and arg_316_1.time_ <= var_319_14 + arg_319_0 then
				local var_319_15 = arg_316_1.var_.effectQWE

				if var_319_15 then
					Object.Destroy(var_319_15)

					arg_316_1.var_.effectQWE = nil
				end
			end

			local var_319_16 = 0

			if var_319_16 < arg_316_1.time_ and arg_316_1.time_ <= var_319_16 + arg_319_0 then
				arg_316_1.allBtn_.enabled = false
			end

			local var_319_17 = 1.33333333333333

			if arg_316_1.time_ >= var_319_16 + var_319_17 and arg_316_1.time_ < var_319_16 + var_319_17 + arg_319_0 then
				arg_316_1.allBtn_.enabled = true
			end

			local var_319_18 = 1
			local var_319_19 = 1

			if var_319_18 < arg_316_1.time_ and arg_316_1.time_ <= var_319_18 + arg_319_0 then
				local var_319_20 = "play"
				local var_319_21 = "music"

				arg_316_1:AudioAction(var_319_20, var_319_21, "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1.awb")

				local var_319_22 = ""
				local var_319_23 = manager.audio:GetAudioName("bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1")

				if var_319_23 ~= "" then
					if arg_316_1.bgmTxt_.text ~= var_319_23 and arg_316_1.bgmTxt_.text ~= "" then
						if arg_316_1.bgmTxt2_.text ~= "" then
							arg_316_1.bgmTxt_.text = arg_316_1.bgmTxt2_.text
						end

						arg_316_1.bgmTxt2_.text = var_319_23

						arg_316_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_316_1.bgmTxt_.text = var_319_23
						arg_316_1.bgmTxt2_.text = var_319_23
					end

					if arg_316_1.bgmTimer then
						arg_316_1.bgmTimer:Stop()

						arg_316_1.bgmTimer = nil
					end

					if arg_316_1.settingData.show_music_name == 1 then
						arg_316_1.musicController:SetSelectedState("show")
						arg_316_1.musicAnimator_:Play("open", 0, 0)

						if arg_316_1.settingData.music_time ~= 0 then
							arg_316_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_316_1.settingData.music_time), function()
								if arg_316_1 == nil or isNil(arg_316_1.bgmTxt_) then
									return
								end

								arg_316_1.musicController:SetSelectedState("hide")
								arg_316_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_316_1.frameCnt_ <= 1 then
				arg_316_1.dialog_:SetActive(false)
			end

			local var_319_24 = 1
			local var_319_25 = 0.75

			if var_319_24 < arg_316_1.time_ and arg_316_1.time_ <= var_319_24 + arg_319_0 then
				arg_316_1.talkMaxDuration = 0

				arg_316_1.dialog_:SetActive(true)

				arg_316_1.dialogCg_.alpha = 0

				local var_319_26 = LeanTween.value(arg_316_1.dialog_, 0, 1, 0.3)

				var_319_26:setOnUpdate(LuaHelper.FloatAction(function(arg_321_0)
					arg_316_1.dialogCg_.alpha = arg_321_0
				end))
				var_319_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_316_1.dialog_)
					var_319_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_316_1.duration_ = arg_316_1.duration_ + 0.3

				SetActive(arg_316_1.leftNameGo_, true)

				local var_319_27 = arg_316_1:FormatText(StoryNameCfg[29].name)

				arg_316_1.leftNameTxt_.text = var_319_27

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_316_1.leftNameTxt_.transform)

				arg_316_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_316_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_316_1:RecordName(arg_316_1.leftNameTxt_.text)
				SetActive(arg_316_1.iconTrs_.gameObject, true)
				arg_316_1.iconController_:SetSelectedState("hero")

				arg_316_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2044")

				arg_316_1.callingController_:SetSelectedState("normal")

				arg_316_1.keyicon_.color = Color.New(1, 1, 1)
				arg_316_1.icon_.color = Color.New(1, 1, 1)

				local var_319_28 = arg_316_1:GetWordFromCfg(304011077)
				local var_319_29 = arg_316_1:FormatText(var_319_28.content)

				arg_316_1.text_.text = var_319_29

				LuaForUtil.ClearLinePrefixSymbol(arg_316_1.text_)

				local var_319_30 = 30
				local var_319_31 = utf8.len(var_319_29)
				local var_319_32 = var_319_30 <= 0 and var_319_25 or var_319_25 * (var_319_31 / var_319_30)

				if var_319_32 > 0 and var_319_25 < var_319_32 then
					arg_316_1.talkMaxDuration = var_319_32
					var_319_24 = var_319_24 + 0.3

					if var_319_32 + var_319_24 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_32 + var_319_24
					end
				end

				arg_316_1.text_.text = var_319_29
				arg_316_1.typewritter.percent = 0

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304011", "304011077", "story_v_out_304011.awb") ~= 0 then
					local var_319_33 = manager.audio:GetVoiceLength("story_v_out_304011", "304011077", "story_v_out_304011.awb") / 1000

					if var_319_33 + var_319_24 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_33 + var_319_24
					end

					if var_319_28.prefab_name ~= "" and arg_316_1.actors_[var_319_28.prefab_name] ~= nil then
						local var_319_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_316_1.actors_[var_319_28.prefab_name].transform, "story_v_out_304011", "304011077", "story_v_out_304011.awb")

						arg_316_1:RecordAudio("304011077", var_319_34)
						arg_316_1:RecordAudio("304011077", var_319_34)
					else
						arg_316_1:AudioAction("play", "voice", "story_v_out_304011", "304011077", "story_v_out_304011.awb")
					end

					arg_316_1:RecordHistoryTalkVoice("story_v_out_304011", "304011077", "story_v_out_304011.awb")
				end

				arg_316_1:RecordContent(arg_316_1.text_.text)
			end

			local var_319_35 = var_319_24 + 0.3
			local var_319_36 = math.max(var_319_25, arg_316_1.talkMaxDuration)

			if var_319_35 <= arg_316_1.time_ and arg_316_1.time_ < var_319_35 + var_319_36 then
				arg_316_1.typewritter.percent = (arg_316_1.time_ - var_319_35) / var_319_36

				arg_316_1.typewritter:SetDirty()
			end

			if arg_316_1.time_ >= var_319_35 + var_319_36 and arg_316_1.time_ < var_319_35 + var_319_36 + arg_319_0 then
				arg_316_1.typewritter.percent = 1

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(true)
			end
		end

		arg_316_1.nodeConfigList_ = {}

		arg_316_1:InitPlayNodeList()
	end,
	Play304011078 = function(arg_323_0, arg_323_1)
		arg_323_1.time_ = 0
		arg_323_1.frameCnt_ = 0
		arg_323_1.state_ = "playing"
		arg_323_1.curTalkId_ = 304011078
		arg_323_1.duration_ = 5

		SetActive(arg_323_1.tipsGo_, false)

		function arg_323_1.onSingleLineFinish_()
			arg_323_1.onSingleLineUpdate_ = nil
			arg_323_1.onSingleLineFinish_ = nil
			arg_323_1.state_ = "waiting"
		end

		function arg_323_1.playNext_(arg_325_0)
			if arg_325_0 == 1 then
				arg_323_0:Play304011079(arg_323_1)
			end
		end

		function arg_323_1.onSingleLineUpdate_(arg_326_0)
			local var_326_0 = arg_323_1.actors_["2044ui_story"]
			local var_326_1 = 0

			if var_326_1 < arg_323_1.time_ and arg_323_1.time_ <= var_326_1 + arg_326_0 and not isNil(var_326_0) and arg_323_1.var_.characterEffect2044ui_story == nil then
				arg_323_1.var_.characterEffect2044ui_story = var_326_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_326_2 = 0.200000002980232

			if var_326_1 <= arg_323_1.time_ and arg_323_1.time_ < var_326_1 + var_326_2 and not isNil(var_326_0) then
				local var_326_3 = (arg_323_1.time_ - var_326_1) / var_326_2

				if arg_323_1.var_.characterEffect2044ui_story and not isNil(var_326_0) then
					local var_326_4 = Mathf.Lerp(0, 0.5, var_326_3)

					arg_323_1.var_.characterEffect2044ui_story.fillFlat = true
					arg_323_1.var_.characterEffect2044ui_story.fillRatio = var_326_4
				end
			end

			if arg_323_1.time_ >= var_326_1 + var_326_2 and arg_323_1.time_ < var_326_1 + var_326_2 + arg_326_0 and not isNil(var_326_0) and arg_323_1.var_.characterEffect2044ui_story then
				local var_326_5 = 0.5

				arg_323_1.var_.characterEffect2044ui_story.fillFlat = true
				arg_323_1.var_.characterEffect2044ui_story.fillRatio = var_326_5
			end

			local var_326_6 = 0
			local var_326_7 = 0.95

			if var_326_6 < arg_323_1.time_ and arg_323_1.time_ <= var_326_6 + arg_326_0 then
				arg_323_1.talkMaxDuration = 0
				arg_323_1.dialogCg_.alpha = 1

				arg_323_1.dialog_:SetActive(true)
				SetActive(arg_323_1.leftNameGo_, false)

				arg_323_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_323_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_323_1:RecordName(arg_323_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_323_1.iconTrs_.gameObject, false)
				arg_323_1.callingController_:SetSelectedState("normal")

				local var_326_8 = arg_323_1:GetWordFromCfg(304011078)
				local var_326_9 = arg_323_1:FormatText(var_326_8.content)

				arg_323_1.text_.text = var_326_9

				LuaForUtil.ClearLinePrefixSymbol(arg_323_1.text_)

				local var_326_10 = 38
				local var_326_11 = utf8.len(var_326_9)
				local var_326_12 = var_326_10 <= 0 and var_326_7 or var_326_7 * (var_326_11 / var_326_10)

				if var_326_12 > 0 and var_326_7 < var_326_12 then
					arg_323_1.talkMaxDuration = var_326_12

					if var_326_12 + var_326_6 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_12 + var_326_6
					end
				end

				arg_323_1.text_.text = var_326_9
				arg_323_1.typewritter.percent = 0

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(false)
				arg_323_1:RecordContent(arg_323_1.text_.text)
			end

			local var_326_13 = math.max(var_326_7, arg_323_1.talkMaxDuration)

			if var_326_6 <= arg_323_1.time_ and arg_323_1.time_ < var_326_6 + var_326_13 then
				arg_323_1.typewritter.percent = (arg_323_1.time_ - var_326_6) / var_326_13

				arg_323_1.typewritter:SetDirty()
			end

			if arg_323_1.time_ >= var_326_6 + var_326_13 and arg_323_1.time_ < var_326_6 + var_326_13 + arg_326_0 then
				arg_323_1.typewritter.percent = 1

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(true)
			end
		end

		arg_323_1.nodeConfigList_ = {}

		arg_323_1:InitPlayNodeList()
	end,
	Play304011079 = function(arg_327_0, arg_327_1)
		arg_327_1.time_ = 0
		arg_327_1.frameCnt_ = 0
		arg_327_1.state_ = "playing"
		arg_327_1.curTalkId_ = 304011079
		arg_327_1.duration_ = 5

		SetActive(arg_327_1.tipsGo_, false)

		function arg_327_1.onSingleLineFinish_()
			arg_327_1.onSingleLineUpdate_ = nil
			arg_327_1.onSingleLineFinish_ = nil
			arg_327_1.state_ = "waiting"
		end

		function arg_327_1.playNext_(arg_329_0)
			if arg_329_0 == 1 then
				arg_327_0:Play304011080(arg_327_1)
			end
		end

		function arg_327_1.onSingleLineUpdate_(arg_330_0)
			local var_330_0 = 0.2
			local var_330_1 = 1

			if var_330_0 < arg_327_1.time_ and arg_327_1.time_ <= var_330_0 + arg_330_0 then
				local var_330_2 = "play"
				local var_330_3 = "effect"

				arg_327_1:AudioAction(var_330_2, var_330_3, "se_story_141", "se_story_141_amb_crowd_escape", "")
			end

			local var_330_4 = 0.2
			local var_330_5 = 1

			if var_330_4 < arg_327_1.time_ and arg_327_1.time_ <= var_330_4 + arg_330_0 then
				local var_330_6 = "play"
				local var_330_7 = "effect"

				arg_327_1:AudioAction(var_330_6, var_330_7, "se_story", "se_story_robot_short", "")
			end

			local var_330_8 = 0
			local var_330_9 = 1.325

			if var_330_8 < arg_327_1.time_ and arg_327_1.time_ <= var_330_8 + arg_330_0 then
				arg_327_1.talkMaxDuration = 0
				arg_327_1.dialogCg_.alpha = 1

				arg_327_1.dialog_:SetActive(true)
				SetActive(arg_327_1.leftNameGo_, false)

				arg_327_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_327_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_327_1:RecordName(arg_327_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_327_1.iconTrs_.gameObject, false)
				arg_327_1.callingController_:SetSelectedState("normal")

				local var_330_10 = arg_327_1:GetWordFromCfg(304011079)
				local var_330_11 = arg_327_1:FormatText(var_330_10.content)

				arg_327_1.text_.text = var_330_11

				LuaForUtil.ClearLinePrefixSymbol(arg_327_1.text_)

				local var_330_12 = 53
				local var_330_13 = utf8.len(var_330_11)
				local var_330_14 = var_330_12 <= 0 and var_330_9 or var_330_9 * (var_330_13 / var_330_12)

				if var_330_14 > 0 and var_330_9 < var_330_14 then
					arg_327_1.talkMaxDuration = var_330_14

					if var_330_14 + var_330_8 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_14 + var_330_8
					end
				end

				arg_327_1.text_.text = var_330_11
				arg_327_1.typewritter.percent = 0

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(false)
				arg_327_1:RecordContent(arg_327_1.text_.text)
			end

			local var_330_15 = math.max(var_330_9, arg_327_1.talkMaxDuration)

			if var_330_8 <= arg_327_1.time_ and arg_327_1.time_ < var_330_8 + var_330_15 then
				arg_327_1.typewritter.percent = (arg_327_1.time_ - var_330_8) / var_330_15

				arg_327_1.typewritter:SetDirty()
			end

			if arg_327_1.time_ >= var_330_8 + var_330_15 and arg_327_1.time_ < var_330_8 + var_330_15 + arg_330_0 then
				arg_327_1.typewritter.percent = 1

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(true)
			end
		end

		arg_327_1.nodeConfigList_ = {}

		arg_327_1:InitPlayNodeList()
	end,
	Play304011080 = function(arg_331_0, arg_331_1)
		arg_331_1.time_ = 0
		arg_331_1.frameCnt_ = 0
		arg_331_1.state_ = "playing"
		arg_331_1.curTalkId_ = 304011080
		arg_331_1.duration_ = 3

		local var_331_0 = {
			zh = 3,
			ja = 1.333
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
				arg_331_0:Play304011081(arg_331_1)
			end
		end

		function arg_331_1.onSingleLineUpdate_(arg_334_0)
			local var_334_0 = arg_331_1.actors_["2044ui_story"]
			local var_334_1 = 0

			if var_334_1 < arg_331_1.time_ and arg_331_1.time_ <= var_334_1 + arg_334_0 and not isNil(var_334_0) and arg_331_1.var_.characterEffect2044ui_story == nil then
				arg_331_1.var_.characterEffect2044ui_story = var_334_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_334_2 = 0.200000002980232

			if var_334_1 <= arg_331_1.time_ and arg_331_1.time_ < var_334_1 + var_334_2 and not isNil(var_334_0) then
				local var_334_3 = (arg_331_1.time_ - var_334_1) / var_334_2

				if arg_331_1.var_.characterEffect2044ui_story and not isNil(var_334_0) then
					arg_331_1.var_.characterEffect2044ui_story.fillFlat = false
				end
			end

			if arg_331_1.time_ >= var_334_1 + var_334_2 and arg_331_1.time_ < var_334_1 + var_334_2 + arg_334_0 and not isNil(var_334_0) and arg_331_1.var_.characterEffect2044ui_story then
				arg_331_1.var_.characterEffect2044ui_story.fillFlat = false
			end

			local var_334_4 = 0.2
			local var_334_5 = 1

			if var_334_4 < arg_331_1.time_ and arg_331_1.time_ <= var_334_4 + arg_334_0 then
				local var_334_6 = "stop"
				local var_334_7 = "effect"

				arg_331_1:AudioAction(var_334_6, var_334_7, "se_story_141", "se_story_141_amb_crowd_escape", "")
			end

			local var_334_8 = 0
			local var_334_9 = 0.275

			if var_334_8 < arg_331_1.time_ and arg_331_1.time_ <= var_334_8 + arg_334_0 then
				arg_331_1.talkMaxDuration = 0
				arg_331_1.dialogCg_.alpha = 1

				arg_331_1.dialog_:SetActive(true)
				SetActive(arg_331_1.leftNameGo_, true)

				local var_334_10 = arg_331_1:FormatText(StoryNameCfg[29].name)

				arg_331_1.leftNameTxt_.text = var_334_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_331_1.leftNameTxt_.transform)

				arg_331_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_331_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_331_1:RecordName(arg_331_1.leftNameTxt_.text)
				SetActive(arg_331_1.iconTrs_.gameObject, true)
				arg_331_1.iconController_:SetSelectedState("hero")

				arg_331_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2044")

				arg_331_1.callingController_:SetSelectedState("normal")

				arg_331_1.keyicon_.color = Color.New(1, 1, 1)
				arg_331_1.icon_.color = Color.New(1, 1, 1)

				local var_334_11 = arg_331_1:GetWordFromCfg(304011080)
				local var_334_12 = arg_331_1:FormatText(var_334_11.content)

				arg_331_1.text_.text = var_334_12

				LuaForUtil.ClearLinePrefixSymbol(arg_331_1.text_)

				local var_334_13 = 11
				local var_334_14 = utf8.len(var_334_12)
				local var_334_15 = var_334_13 <= 0 and var_334_9 or var_334_9 * (var_334_14 / var_334_13)

				if var_334_15 > 0 and var_334_9 < var_334_15 then
					arg_331_1.talkMaxDuration = var_334_15

					if var_334_15 + var_334_8 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_15 + var_334_8
					end
				end

				arg_331_1.text_.text = var_334_12
				arg_331_1.typewritter.percent = 0

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304011", "304011080", "story_v_out_304011.awb") ~= 0 then
					local var_334_16 = manager.audio:GetVoiceLength("story_v_out_304011", "304011080", "story_v_out_304011.awb") / 1000

					if var_334_16 + var_334_8 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_16 + var_334_8
					end

					if var_334_11.prefab_name ~= "" and arg_331_1.actors_[var_334_11.prefab_name] ~= nil then
						local var_334_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_331_1.actors_[var_334_11.prefab_name].transform, "story_v_out_304011", "304011080", "story_v_out_304011.awb")

						arg_331_1:RecordAudio("304011080", var_334_17)
						arg_331_1:RecordAudio("304011080", var_334_17)
					else
						arg_331_1:AudioAction("play", "voice", "story_v_out_304011", "304011080", "story_v_out_304011.awb")
					end

					arg_331_1:RecordHistoryTalkVoice("story_v_out_304011", "304011080", "story_v_out_304011.awb")
				end

				arg_331_1:RecordContent(arg_331_1.text_.text)
			end

			local var_334_18 = math.max(var_334_9, arg_331_1.talkMaxDuration)

			if var_334_8 <= arg_331_1.time_ and arg_331_1.time_ < var_334_8 + var_334_18 then
				arg_331_1.typewritter.percent = (arg_331_1.time_ - var_334_8) / var_334_18

				arg_331_1.typewritter:SetDirty()
			end

			if arg_331_1.time_ >= var_334_8 + var_334_18 and arg_331_1.time_ < var_334_8 + var_334_18 + arg_334_0 then
				arg_331_1.typewritter.percent = 1

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(true)
			end
		end

		arg_331_1.nodeConfigList_ = {}

		arg_331_1:InitPlayNodeList()
	end,
	Play304011081 = function(arg_335_0, arg_335_1)
		arg_335_1.time_ = 0
		arg_335_1.frameCnt_ = 0
		arg_335_1.state_ = "playing"
		arg_335_1.curTalkId_ = 304011081
		arg_335_1.duration_ = 3.23

		local var_335_0 = {
			zh = 3.233,
			ja = 2.133
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
				arg_335_0:Play304011082(arg_335_1)
			end
		end

		function arg_335_1.onSingleLineUpdate_(arg_338_0)
			local var_338_0 = arg_335_1.actors_["1059ui_story"].transform
			local var_338_1 = 0

			if var_338_1 < arg_335_1.time_ and arg_335_1.time_ <= var_338_1 + arg_338_0 then
				arg_335_1.var_.moveOldPos1059ui_story = var_338_0.localPosition
			end

			local var_338_2 = 0.001

			if var_338_1 <= arg_335_1.time_ and arg_335_1.time_ < var_338_1 + var_338_2 then
				local var_338_3 = (arg_335_1.time_ - var_338_1) / var_338_2
				local var_338_4 = Vector3.New(-0.7, -1.05, -6)

				var_338_0.localPosition = Vector3.Lerp(arg_335_1.var_.moveOldPos1059ui_story, var_338_4, var_338_3)

				local var_338_5 = manager.ui.mainCamera.transform.position - var_338_0.position

				var_338_0.forward = Vector3.New(var_338_5.x, var_338_5.y, var_338_5.z)

				local var_338_6 = var_338_0.localEulerAngles

				var_338_6.z = 0
				var_338_6.x = 0
				var_338_0.localEulerAngles = var_338_6
			end

			if arg_335_1.time_ >= var_338_1 + var_338_2 and arg_335_1.time_ < var_338_1 + var_338_2 + arg_338_0 then
				var_338_0.localPosition = Vector3.New(-0.7, -1.05, -6)

				local var_338_7 = manager.ui.mainCamera.transform.position - var_338_0.position

				var_338_0.forward = Vector3.New(var_338_7.x, var_338_7.y, var_338_7.z)

				local var_338_8 = var_338_0.localEulerAngles

				var_338_8.z = 0
				var_338_8.x = 0
				var_338_0.localEulerAngles = var_338_8
			end

			local var_338_9 = arg_335_1.actors_["1059ui_story"]
			local var_338_10 = 0

			if var_338_10 < arg_335_1.time_ and arg_335_1.time_ <= var_338_10 + arg_338_0 and not isNil(var_338_9) and arg_335_1.var_.characterEffect1059ui_story == nil then
				arg_335_1.var_.characterEffect1059ui_story = var_338_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_338_11 = 0.200000002980232

			if var_338_10 <= arg_335_1.time_ and arg_335_1.time_ < var_338_10 + var_338_11 and not isNil(var_338_9) then
				local var_338_12 = (arg_335_1.time_ - var_338_10) / var_338_11

				if arg_335_1.var_.characterEffect1059ui_story and not isNil(var_338_9) then
					arg_335_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_335_1.time_ >= var_338_10 + var_338_11 and arg_335_1.time_ < var_338_10 + var_338_11 + arg_338_0 and not isNil(var_338_9) and arg_335_1.var_.characterEffect1059ui_story then
				arg_335_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_338_13 = arg_335_1.actors_["2044ui_story"]
			local var_338_14 = 0

			if var_338_14 < arg_335_1.time_ and arg_335_1.time_ <= var_338_14 + arg_338_0 and not isNil(var_338_13) and arg_335_1.var_.characterEffect2044ui_story == nil then
				arg_335_1.var_.characterEffect2044ui_story = var_338_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_338_15 = 0.200000002980232

			if var_338_14 <= arg_335_1.time_ and arg_335_1.time_ < var_338_14 + var_338_15 and not isNil(var_338_13) then
				local var_338_16 = (arg_335_1.time_ - var_338_14) / var_338_15

				if arg_335_1.var_.characterEffect2044ui_story and not isNil(var_338_13) then
					local var_338_17 = Mathf.Lerp(0, 0.5, var_338_16)

					arg_335_1.var_.characterEffect2044ui_story.fillFlat = true
					arg_335_1.var_.characterEffect2044ui_story.fillRatio = var_338_17
				end
			end

			if arg_335_1.time_ >= var_338_14 + var_338_15 and arg_335_1.time_ < var_338_14 + var_338_15 + arg_338_0 and not isNil(var_338_13) and arg_335_1.var_.characterEffect2044ui_story then
				local var_338_18 = 0.5

				arg_335_1.var_.characterEffect2044ui_story.fillFlat = true
				arg_335_1.var_.characterEffect2044ui_story.fillRatio = var_338_18
			end

			local var_338_19 = 0

			if var_338_19 < arg_335_1.time_ and arg_335_1.time_ <= var_338_19 + arg_338_0 then
				arg_335_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059action/1059action2_1")
			end

			local var_338_20 = 0

			if var_338_20 < arg_335_1.time_ and arg_335_1.time_ <= var_338_20 + arg_338_0 then
				arg_335_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_338_21 = 0
			local var_338_22 = 0.325

			if var_338_21 < arg_335_1.time_ and arg_335_1.time_ <= var_338_21 + arg_338_0 then
				arg_335_1.talkMaxDuration = 0
				arg_335_1.dialogCg_.alpha = 1

				arg_335_1.dialog_:SetActive(true)
				SetActive(arg_335_1.leftNameGo_, true)

				local var_338_23 = arg_335_1:FormatText(StoryNameCfg[28].name)

				arg_335_1.leftNameTxt_.text = var_338_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_335_1.leftNameTxt_.transform)

				arg_335_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_335_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_335_1:RecordName(arg_335_1.leftNameTxt_.text)
				SetActive(arg_335_1.iconTrs_.gameObject, false)
				arg_335_1.callingController_:SetSelectedState("normal")

				local var_338_24 = arg_335_1:GetWordFromCfg(304011081)
				local var_338_25 = arg_335_1:FormatText(var_338_24.content)

				arg_335_1.text_.text = var_338_25

				LuaForUtil.ClearLinePrefixSymbol(arg_335_1.text_)

				local var_338_26 = 13
				local var_338_27 = utf8.len(var_338_25)
				local var_338_28 = var_338_26 <= 0 and var_338_22 or var_338_22 * (var_338_27 / var_338_26)

				if var_338_28 > 0 and var_338_22 < var_338_28 then
					arg_335_1.talkMaxDuration = var_338_28

					if var_338_28 + var_338_21 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_28 + var_338_21
					end
				end

				arg_335_1.text_.text = var_338_25
				arg_335_1.typewritter.percent = 0

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304011", "304011081", "story_v_out_304011.awb") ~= 0 then
					local var_338_29 = manager.audio:GetVoiceLength("story_v_out_304011", "304011081", "story_v_out_304011.awb") / 1000

					if var_338_29 + var_338_21 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_29 + var_338_21
					end

					if var_338_24.prefab_name ~= "" and arg_335_1.actors_[var_338_24.prefab_name] ~= nil then
						local var_338_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_335_1.actors_[var_338_24.prefab_name].transform, "story_v_out_304011", "304011081", "story_v_out_304011.awb")

						arg_335_1:RecordAudio("304011081", var_338_30)
						arg_335_1:RecordAudio("304011081", var_338_30)
					else
						arg_335_1:AudioAction("play", "voice", "story_v_out_304011", "304011081", "story_v_out_304011.awb")
					end

					arg_335_1:RecordHistoryTalkVoice("story_v_out_304011", "304011081", "story_v_out_304011.awb")
				end

				arg_335_1:RecordContent(arg_335_1.text_.text)
			end

			local var_338_31 = math.max(var_338_22, arg_335_1.talkMaxDuration)

			if var_338_21 <= arg_335_1.time_ and arg_335_1.time_ < var_338_21 + var_338_31 then
				arg_335_1.typewritter.percent = (arg_335_1.time_ - var_338_21) / var_338_31

				arg_335_1.typewritter:SetDirty()
			end

			if arg_335_1.time_ >= var_338_21 + var_338_31 and arg_335_1.time_ < var_338_21 + var_338_31 + arg_338_0 then
				arg_335_1.typewritter.percent = 1

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(true)
			end
		end

		arg_335_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_335_1:InitPlayNodeList()
	end,
	Play304011082 = function(arg_339_0, arg_339_1)
		arg_339_1.time_ = 0
		arg_339_1.frameCnt_ = 0
		arg_339_1.state_ = "playing"
		arg_339_1.curTalkId_ = 304011082
		arg_339_1.duration_ = 4.5

		local var_339_0 = {
			zh = 3.466,
			ja = 4.5
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
				arg_339_0:Play304011083(arg_339_1)
			end
		end

		function arg_339_1.onSingleLineUpdate_(arg_342_0)
			local var_342_0 = arg_339_1.actors_["1148ui_story"].transform
			local var_342_1 = 0

			if var_342_1 < arg_339_1.time_ and arg_339_1.time_ <= var_342_1 + arg_342_0 then
				arg_339_1.var_.moveOldPos1148ui_story = var_342_0.localPosition
			end

			local var_342_2 = 0.001

			if var_342_1 <= arg_339_1.time_ and arg_339_1.time_ < var_342_1 + var_342_2 then
				local var_342_3 = (arg_339_1.time_ - var_342_1) / var_342_2
				local var_342_4 = Vector3.New(0.7, -0.8, -6.2)

				var_342_0.localPosition = Vector3.Lerp(arg_339_1.var_.moveOldPos1148ui_story, var_342_4, var_342_3)

				local var_342_5 = manager.ui.mainCamera.transform.position - var_342_0.position

				var_342_0.forward = Vector3.New(var_342_5.x, var_342_5.y, var_342_5.z)

				local var_342_6 = var_342_0.localEulerAngles

				var_342_6.z = 0
				var_342_6.x = 0
				var_342_0.localEulerAngles = var_342_6
			end

			if arg_339_1.time_ >= var_342_1 + var_342_2 and arg_339_1.time_ < var_342_1 + var_342_2 + arg_342_0 then
				var_342_0.localPosition = Vector3.New(0.7, -0.8, -6.2)

				local var_342_7 = manager.ui.mainCamera.transform.position - var_342_0.position

				var_342_0.forward = Vector3.New(var_342_7.x, var_342_7.y, var_342_7.z)

				local var_342_8 = var_342_0.localEulerAngles

				var_342_8.z = 0
				var_342_8.x = 0
				var_342_0.localEulerAngles = var_342_8
			end

			local var_342_9 = arg_339_1.actors_["1148ui_story"]
			local var_342_10 = 0

			if var_342_10 < arg_339_1.time_ and arg_339_1.time_ <= var_342_10 + arg_342_0 and not isNil(var_342_9) and arg_339_1.var_.characterEffect1148ui_story == nil then
				arg_339_1.var_.characterEffect1148ui_story = var_342_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_342_11 = 0.200000002980232

			if var_342_10 <= arg_339_1.time_ and arg_339_1.time_ < var_342_10 + var_342_11 and not isNil(var_342_9) then
				local var_342_12 = (arg_339_1.time_ - var_342_10) / var_342_11

				if arg_339_1.var_.characterEffect1148ui_story and not isNil(var_342_9) then
					arg_339_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_339_1.time_ >= var_342_10 + var_342_11 and arg_339_1.time_ < var_342_10 + var_342_11 + arg_342_0 and not isNil(var_342_9) and arg_339_1.var_.characterEffect1148ui_story then
				arg_339_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_342_13 = arg_339_1.actors_["1059ui_story"]
			local var_342_14 = 0

			if var_342_14 < arg_339_1.time_ and arg_339_1.time_ <= var_342_14 + arg_342_0 and not isNil(var_342_13) and arg_339_1.var_.characterEffect1059ui_story == nil then
				arg_339_1.var_.characterEffect1059ui_story = var_342_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_342_15 = 0.200000002980232

			if var_342_14 <= arg_339_1.time_ and arg_339_1.time_ < var_342_14 + var_342_15 and not isNil(var_342_13) then
				local var_342_16 = (arg_339_1.time_ - var_342_14) / var_342_15

				if arg_339_1.var_.characterEffect1059ui_story and not isNil(var_342_13) then
					local var_342_17 = Mathf.Lerp(0, 0.5, var_342_16)

					arg_339_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_339_1.var_.characterEffect1059ui_story.fillRatio = var_342_17
				end
			end

			if arg_339_1.time_ >= var_342_14 + var_342_15 and arg_339_1.time_ < var_342_14 + var_342_15 + arg_342_0 and not isNil(var_342_13) and arg_339_1.var_.characterEffect1059ui_story then
				local var_342_18 = 0.5

				arg_339_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_339_1.var_.characterEffect1059ui_story.fillRatio = var_342_18
			end

			local var_342_19 = 0

			if var_342_19 < arg_339_1.time_ and arg_339_1.time_ <= var_342_19 + arg_342_0 then
				arg_339_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action5_1")
			end

			local var_342_20 = 0

			if var_342_20 < arg_339_1.time_ and arg_339_1.time_ <= var_342_20 + arg_342_0 then
				arg_339_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_342_21 = 0
			local var_342_22 = 0.375

			if var_342_21 < arg_339_1.time_ and arg_339_1.time_ <= var_342_21 + arg_342_0 then
				arg_339_1.talkMaxDuration = 0
				arg_339_1.dialogCg_.alpha = 1

				arg_339_1.dialog_:SetActive(true)
				SetActive(arg_339_1.leftNameGo_, true)

				local var_342_23 = arg_339_1:FormatText(StoryNameCfg[8].name)

				arg_339_1.leftNameTxt_.text = var_342_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_339_1.leftNameTxt_.transform)

				arg_339_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_339_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_339_1:RecordName(arg_339_1.leftNameTxt_.text)
				SetActive(arg_339_1.iconTrs_.gameObject, false)
				arg_339_1.callingController_:SetSelectedState("normal")

				local var_342_24 = arg_339_1:GetWordFromCfg(304011082)
				local var_342_25 = arg_339_1:FormatText(var_342_24.content)

				arg_339_1.text_.text = var_342_25

				LuaForUtil.ClearLinePrefixSymbol(arg_339_1.text_)

				local var_342_26 = 15
				local var_342_27 = utf8.len(var_342_25)
				local var_342_28 = var_342_26 <= 0 and var_342_22 or var_342_22 * (var_342_27 / var_342_26)

				if var_342_28 > 0 and var_342_22 < var_342_28 then
					arg_339_1.talkMaxDuration = var_342_28

					if var_342_28 + var_342_21 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_28 + var_342_21
					end
				end

				arg_339_1.text_.text = var_342_25
				arg_339_1.typewritter.percent = 0

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304011", "304011082", "story_v_out_304011.awb") ~= 0 then
					local var_342_29 = manager.audio:GetVoiceLength("story_v_out_304011", "304011082", "story_v_out_304011.awb") / 1000

					if var_342_29 + var_342_21 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_29 + var_342_21
					end

					if var_342_24.prefab_name ~= "" and arg_339_1.actors_[var_342_24.prefab_name] ~= nil then
						local var_342_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_339_1.actors_[var_342_24.prefab_name].transform, "story_v_out_304011", "304011082", "story_v_out_304011.awb")

						arg_339_1:RecordAudio("304011082", var_342_30)
						arg_339_1:RecordAudio("304011082", var_342_30)
					else
						arg_339_1:AudioAction("play", "voice", "story_v_out_304011", "304011082", "story_v_out_304011.awb")
					end

					arg_339_1:RecordHistoryTalkVoice("story_v_out_304011", "304011082", "story_v_out_304011.awb")
				end

				arg_339_1:RecordContent(arg_339_1.text_.text)
			end

			local var_342_31 = math.max(var_342_22, arg_339_1.talkMaxDuration)

			if var_342_21 <= arg_339_1.time_ and arg_339_1.time_ < var_342_21 + var_342_31 then
				arg_339_1.typewritter.percent = (arg_339_1.time_ - var_342_21) / var_342_31

				arg_339_1.typewritter:SetDirty()
			end

			if arg_339_1.time_ >= var_342_21 + var_342_31 and arg_339_1.time_ < var_342_21 + var_342_31 + arg_342_0 then
				arg_339_1.typewritter.percent = 1

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(true)
			end
		end

		arg_339_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_339_1:InitPlayNodeList()
	end,
	Play304011083 = function(arg_343_0, arg_343_1)
		arg_343_1.time_ = 0
		arg_343_1.frameCnt_ = 0
		arg_343_1.state_ = "playing"
		arg_343_1.curTalkId_ = 304011083
		arg_343_1.duration_ = 5.03

		local var_343_0 = {
			zh = 3.866,
			ja = 5.033
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
			arg_343_1.auto_ = false
		end

		function arg_343_1.playNext_(arg_345_0)
			arg_343_1.onStoryFinished_()
		end

		function arg_343_1.onSingleLineUpdate_(arg_346_0)
			local var_346_0 = 0
			local var_346_1 = 0.425

			if var_346_0 < arg_343_1.time_ and arg_343_1.time_ <= var_346_0 + arg_346_0 then
				arg_343_1.talkMaxDuration = 0
				arg_343_1.dialogCg_.alpha = 1

				arg_343_1.dialog_:SetActive(true)
				SetActive(arg_343_1.leftNameGo_, true)

				local var_346_2 = arg_343_1:FormatText(StoryNameCfg[8].name)

				arg_343_1.leftNameTxt_.text = var_346_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_343_1.leftNameTxt_.transform)

				arg_343_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_343_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_343_1:RecordName(arg_343_1.leftNameTxt_.text)
				SetActive(arg_343_1.iconTrs_.gameObject, false)
				arg_343_1.callingController_:SetSelectedState("normal")

				local var_346_3 = arg_343_1:GetWordFromCfg(304011083)
				local var_346_4 = arg_343_1:FormatText(var_346_3.content)

				arg_343_1.text_.text = var_346_4

				LuaForUtil.ClearLinePrefixSymbol(arg_343_1.text_)

				local var_346_5 = 17
				local var_346_6 = utf8.len(var_346_4)
				local var_346_7 = var_346_5 <= 0 and var_346_1 or var_346_1 * (var_346_6 / var_346_5)

				if var_346_7 > 0 and var_346_1 < var_346_7 then
					arg_343_1.talkMaxDuration = var_346_7

					if var_346_7 + var_346_0 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_7 + var_346_0
					end
				end

				arg_343_1.text_.text = var_346_4
				arg_343_1.typewritter.percent = 0

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304011", "304011083", "story_v_out_304011.awb") ~= 0 then
					local var_346_8 = manager.audio:GetVoiceLength("story_v_out_304011", "304011083", "story_v_out_304011.awb") / 1000

					if var_346_8 + var_346_0 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_8 + var_346_0
					end

					if var_346_3.prefab_name ~= "" and arg_343_1.actors_[var_346_3.prefab_name] ~= nil then
						local var_346_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_343_1.actors_[var_346_3.prefab_name].transform, "story_v_out_304011", "304011083", "story_v_out_304011.awb")

						arg_343_1:RecordAudio("304011083", var_346_9)
						arg_343_1:RecordAudio("304011083", var_346_9)
					else
						arg_343_1:AudioAction("play", "voice", "story_v_out_304011", "304011083", "story_v_out_304011.awb")
					end

					arg_343_1:RecordHistoryTalkVoice("story_v_out_304011", "304011083", "story_v_out_304011.awb")
				end

				arg_343_1:RecordContent(arg_343_1.text_.text)
			end

			local var_346_10 = math.max(var_346_1, arg_343_1.talkMaxDuration)

			if var_346_0 <= arg_343_1.time_ and arg_343_1.time_ < var_346_0 + var_346_10 then
				arg_343_1.typewritter.percent = (arg_343_1.time_ - var_346_0) / var_346_10

				arg_343_1.typewritter:SetDirty()
			end

			if arg_343_1.time_ >= var_346_0 + var_346_10 and arg_343_1.time_ < var_346_0 + var_346_10 + arg_346_0 then
				arg_343_1.typewritter.percent = 1

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(true)
			end
		end

		arg_343_1.nodeConfigList_ = {}

		arg_343_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/A00",
		"TextureConfig/Background/B10f"
	},
	voices = {
		"story_v_out_304011.awb"
	}
}
