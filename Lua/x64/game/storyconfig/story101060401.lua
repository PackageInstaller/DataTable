return {
	Play106041001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 106041001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play106041002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "S0607"

			if arg_1_1.bgs_[var_4_0] == nil then
				local var_4_1 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_0)
				var_4_1.name = var_4_0
				var_4_1.transform.parent = arg_1_1.stage_.transform
				var_4_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_0] = var_4_1
			end

			local var_4_2 = arg_1_1.bgs_.S0607
			local var_4_3 = 0

			if var_4_3 < arg_1_1.time_ and arg_1_1.time_ <= var_4_3 + arg_4_0 then
				local var_4_4 = var_4_2:GetComponent("SpriteRenderer")

				if var_4_4 then
					arg_1_1.var_.alphaOldValueS0607 = var_4_4.color.a
					arg_1_1.var_.alphaMatValueS0607 = var_4_4
				end

				arg_1_1.var_.alphaOldValueS0607 = 0
			end

			local var_4_5 = 1.5

			if var_4_3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_3 + var_4_5 then
				local var_4_6 = (arg_1_1.time_ - var_4_3) / var_4_5
				local var_4_7 = Mathf.Lerp(arg_1_1.var_.alphaOldValueS0607, 1, var_4_6)

				if arg_1_1.var_.alphaMatValueS0607 then
					local var_4_8 = arg_1_1.var_.alphaMatValueS0607.color

					var_4_8.a = var_4_7
					arg_1_1.var_.alphaMatValueS0607.color = var_4_8
				end
			end

			if arg_1_1.time_ >= var_4_3 + var_4_5 and arg_1_1.time_ < var_4_3 + var_4_5 + arg_4_0 and arg_1_1.var_.alphaMatValueS0607 then
				local var_4_9 = arg_1_1.var_.alphaMatValueS0607
				local var_4_10 = var_4_9.color

				var_4_10.a = 1
				var_4_9.color = var_4_10
			end

			local var_4_11 = 0

			if var_4_11 < arg_1_1.time_ and arg_1_1.time_ <= var_4_11 + arg_4_0 then
				local var_4_12 = manager.ui.mainCamera.transform.localPosition
				local var_4_13 = Vector3.New(0, 0, 10) + Vector3.New(var_4_12.x, var_4_12.y, 0)
				local var_4_14 = arg_1_1.bgs_.S0607

				var_4_14.transform.localPosition = var_4_13
				var_4_14.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_15 = var_4_14:GetComponent("SpriteRenderer")

				if var_4_15 and var_4_15.sprite then
					local var_4_16 = (var_4_14.transform.localPosition - var_4_12).z
					local var_4_17 = manager.ui.mainCameraCom_
					local var_4_18 = 2 * var_4_16 * Mathf.Tan(var_4_17.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_4_19 = var_4_18 * var_4_17.aspect
					local var_4_20 = var_4_15.sprite.bounds.size.x
					local var_4_21 = var_4_15.sprite.bounds.size.y
					local var_4_22 = var_4_19 / var_4_20
					local var_4_23 = var_4_18 / var_4_21
					local var_4_24 = var_4_23 < var_4_22 and var_4_22 or var_4_23

					var_4_14.transform.localScale = Vector3.New(var_4_24, var_4_24, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "S0607" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_25 = 0
			local var_4_26 = 1

			if var_4_25 < arg_1_1.time_ and arg_1_1.time_ <= var_4_25 + arg_4_0 then
				local var_4_27 = "play"
				local var_4_28 = "music"

				arg_1_1:AudioAction(var_4_27, var_4_28, "bgm_story_scheme", "bgm_story_scheme", "bgm_story_scheme.awb")

				local var_4_29 = ""
				local var_4_30 = manager.audio:GetAudioName("bgm_story_scheme", "bgm_story_scheme")

				if var_4_30 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_30 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_30

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_30
						arg_1_1.bgmTxt2_.text = var_4_30
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

			local var_4_31 = 0

			if var_4_31 < arg_1_1.time_ and arg_1_1.time_ <= var_4_31 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_32 = 1.5

			if arg_1_1.time_ >= var_4_31 + var_4_32 and arg_1_1.time_ < var_4_31 + var_4_32 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_33 = 2
			local var_4_34 = 0.7

			if var_4_33 < arg_1_1.time_ and arg_1_1.time_ <= var_4_33 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_35 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_35:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_35:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_35:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_36 = arg_1_1:GetWordFromCfg(106041001)
				local var_4_37 = arg_1_1:FormatText(var_4_36.content)

				arg_1_1.text_.text = var_4_37

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_38 = 28
				local var_4_39 = utf8.len(var_4_37)
				local var_4_40 = var_4_38 <= 0 and var_4_34 or var_4_34 * (var_4_39 / var_4_38)

				if var_4_40 > 0 and var_4_34 < var_4_40 then
					arg_1_1.talkMaxDuration = var_4_40
					var_4_33 = var_4_33 + 0.3

					if var_4_40 + var_4_33 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_40 + var_4_33
					end
				end

				arg_1_1.text_.text = var_4_37
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_41 = var_4_33 + 0.3
			local var_4_42 = math.max(var_4_34, arg_1_1.talkMaxDuration)

			if var_4_41 <= arg_1_1.time_ and arg_1_1.time_ < var_4_41 + var_4_42 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_41) / var_4_42

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_41 + var_4_42 and arg_1_1.time_ < var_4_41 + var_4_42 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play106041002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 106041002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play106041003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 0
			local var_11_1 = 0.725

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

				local var_11_2 = arg_8_1:GetWordFromCfg(106041002)
				local var_11_3 = arg_8_1:FormatText(var_11_2.content)

				arg_8_1.text_.text = var_11_3

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_4 = 29
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
	Play106041003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 106041003
		arg_12_1.duration_ = 7.47

		local var_12_0 = {
			ja = 5.733,
			ko = 4.766,
			zh = 7.466,
			en = 6.066
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
				arg_12_0:Play106041004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 0
			local var_15_1 = 0.625

			if var_15_0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_0 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				local var_15_2 = arg_12_1:FormatText(StoryNameCfg[80].name)

				arg_12_1.leftNameTxt_.text = var_15_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, true)
				arg_12_1.iconController_:SetSelectedState("hero")

				arg_12_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10004")

				arg_12_1.callingController_:SetSelectedState("normal")

				arg_12_1.keyicon_.color = Color.New(1, 1, 1)
				arg_12_1.icon_.color = Color.New(1, 1, 1)

				local var_15_3 = arg_12_1:GetWordFromCfg(106041003)
				local var_15_4 = arg_12_1:FormatText(var_15_3.content)

				arg_12_1.text_.text = var_15_4

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_5 = 25
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

				if manager.audio:GetVoiceLength("story_v_out_106041", "106041003", "story_v_out_106041.awb") ~= 0 then
					local var_15_8 = manager.audio:GetVoiceLength("story_v_out_106041", "106041003", "story_v_out_106041.awb") / 1000

					if var_15_8 + var_15_0 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_8 + var_15_0
					end

					if var_15_3.prefab_name ~= "" and arg_12_1.actors_[var_15_3.prefab_name] ~= nil then
						local var_15_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_3.prefab_name].transform, "story_v_out_106041", "106041003", "story_v_out_106041.awb")

						arg_12_1:RecordAudio("106041003", var_15_9)
						arg_12_1:RecordAudio("106041003", var_15_9)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_106041", "106041003", "story_v_out_106041.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_106041", "106041003", "story_v_out_106041.awb")
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
	Play106041004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 106041004
		arg_16_1.duration_ = 12

		local var_16_0 = {
			ja = 8.933,
			ko = 8.533,
			zh = 11.133,
			en = 12
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
				arg_16_0:Play106041005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = 0
			local var_19_1 = 0.975

			if var_19_0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_0 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				local var_19_2 = arg_16_1:FormatText(StoryNameCfg[81].name)

				arg_16_1.leftNameTxt_.text = var_19_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_3 = arg_16_1:GetWordFromCfg(106041004)
				local var_19_4 = arg_16_1:FormatText(var_19_3.content)

				arg_16_1.text_.text = var_19_4

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_5 = 39
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

				if manager.audio:GetVoiceLength("story_v_out_106041", "106041004", "story_v_out_106041.awb") ~= 0 then
					local var_19_8 = manager.audio:GetVoiceLength("story_v_out_106041", "106041004", "story_v_out_106041.awb") / 1000

					if var_19_8 + var_19_0 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_8 + var_19_0
					end

					if var_19_3.prefab_name ~= "" and arg_16_1.actors_[var_19_3.prefab_name] ~= nil then
						local var_19_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_3.prefab_name].transform, "story_v_out_106041", "106041004", "story_v_out_106041.awb")

						arg_16_1:RecordAudio("106041004", var_19_9)
						arg_16_1:RecordAudio("106041004", var_19_9)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_106041", "106041004", "story_v_out_106041.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_106041", "106041004", "story_v_out_106041.awb")
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
	Play106041005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 106041005
		arg_20_1.duration_ = 15.13

		local var_20_0 = {
			ja = 15.133,
			ko = 9.8,
			zh = 14.566,
			en = 13.133
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
				arg_20_0:Play106041006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = 0
			local var_23_1 = 1.1

			if var_23_0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_0 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				local var_23_2 = arg_20_1:FormatText(StoryNameCfg[80].name)

				arg_20_1.leftNameTxt_.text = var_23_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, true)
				arg_20_1.iconController_:SetSelectedState("hero")

				arg_20_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10004")

				arg_20_1.callingController_:SetSelectedState("normal")

				arg_20_1.keyicon_.color = Color.New(1, 1, 1)
				arg_20_1.icon_.color = Color.New(1, 1, 1)

				local var_23_3 = arg_20_1:GetWordFromCfg(106041005)
				local var_23_4 = arg_20_1:FormatText(var_23_3.content)

				arg_20_1.text_.text = var_23_4

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_5 = 45
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

				if manager.audio:GetVoiceLength("story_v_out_106041", "106041005", "story_v_out_106041.awb") ~= 0 then
					local var_23_8 = manager.audio:GetVoiceLength("story_v_out_106041", "106041005", "story_v_out_106041.awb") / 1000

					if var_23_8 + var_23_0 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_8 + var_23_0
					end

					if var_23_3.prefab_name ~= "" and arg_20_1.actors_[var_23_3.prefab_name] ~= nil then
						local var_23_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_3.prefab_name].transform, "story_v_out_106041", "106041005", "story_v_out_106041.awb")

						arg_20_1:RecordAudio("106041005", var_23_9)
						arg_20_1:RecordAudio("106041005", var_23_9)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_106041", "106041005", "story_v_out_106041.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_106041", "106041005", "story_v_out_106041.awb")
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
	Play106041006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 106041006
		arg_24_1.duration_ = 11.43

		local var_24_0 = {
			ja = 9.133,
			ko = 8.133,
			zh = 9.5,
			en = 11.433
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
				arg_24_0:Play106041007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = 0
			local var_27_1 = 0.85

			if var_27_0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_0 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				local var_27_2 = arg_24_1:FormatText(StoryNameCfg[81].name)

				arg_24_1.leftNameTxt_.text = var_27_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, true)
				arg_24_1.iconController_:SetSelectedState("hero")

				arg_24_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10003")

				arg_24_1.callingController_:SetSelectedState("normal")

				arg_24_1.keyicon_.color = Color.New(1, 1, 1)
				arg_24_1.icon_.color = Color.New(1, 1, 1)

				local var_27_3 = arg_24_1:GetWordFromCfg(106041006)
				local var_27_4 = arg_24_1:FormatText(var_27_3.content)

				arg_24_1.text_.text = var_27_4

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_5 = 34
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

				if manager.audio:GetVoiceLength("story_v_out_106041", "106041006", "story_v_out_106041.awb") ~= 0 then
					local var_27_8 = manager.audio:GetVoiceLength("story_v_out_106041", "106041006", "story_v_out_106041.awb") / 1000

					if var_27_8 + var_27_0 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_8 + var_27_0
					end

					if var_27_3.prefab_name ~= "" and arg_24_1.actors_[var_27_3.prefab_name] ~= nil then
						local var_27_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_3.prefab_name].transform, "story_v_out_106041", "106041006", "story_v_out_106041.awb")

						arg_24_1:RecordAudio("106041006", var_27_9)
						arg_24_1:RecordAudio("106041006", var_27_9)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_106041", "106041006", "story_v_out_106041.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_106041", "106041006", "story_v_out_106041.awb")
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
	Play106041007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 106041007
		arg_28_1.duration_ = 10.9

		local var_28_0 = {
			ja = 10.9,
			ko = 6.133,
			zh = 9.633,
			en = 6.133
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
				arg_28_0:Play106041008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = 0
			local var_31_1 = 0.625

			if var_31_0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_0 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				local var_31_2 = arg_28_1:FormatText(StoryNameCfg[80].name)

				arg_28_1.leftNameTxt_.text = var_31_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, true)
				arg_28_1.iconController_:SetSelectedState("hero")

				arg_28_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10004")

				arg_28_1.callingController_:SetSelectedState("normal")

				arg_28_1.keyicon_.color = Color.New(1, 1, 1)
				arg_28_1.icon_.color = Color.New(1, 1, 1)

				local var_31_3 = arg_28_1:GetWordFromCfg(106041007)
				local var_31_4 = arg_28_1:FormatText(var_31_3.content)

				arg_28_1.text_.text = var_31_4

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_5 = 25
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

				if manager.audio:GetVoiceLength("story_v_out_106041", "106041007", "story_v_out_106041.awb") ~= 0 then
					local var_31_8 = manager.audio:GetVoiceLength("story_v_out_106041", "106041007", "story_v_out_106041.awb") / 1000

					if var_31_8 + var_31_0 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_8 + var_31_0
					end

					if var_31_3.prefab_name ~= "" and arg_28_1.actors_[var_31_3.prefab_name] ~= nil then
						local var_31_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_3.prefab_name].transform, "story_v_out_106041", "106041007", "story_v_out_106041.awb")

						arg_28_1:RecordAudio("106041007", var_31_9)
						arg_28_1:RecordAudio("106041007", var_31_9)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_106041", "106041007", "story_v_out_106041.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_106041", "106041007", "story_v_out_106041.awb")
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
	Play106041008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 106041008
		arg_32_1.duration_ = 9.27

		local var_32_0 = {
			ja = 9.266,
			ko = 7.666,
			zh = 7.433,
			en = 6.633
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
				arg_32_0:Play106041009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = 0
			local var_35_1 = 0.65

			if var_35_0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_0 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				local var_35_2 = arg_32_1:FormatText(StoryNameCfg[81].name)

				arg_32_1.leftNameTxt_.text = var_35_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, true)
				arg_32_1.iconController_:SetSelectedState("hero")

				arg_32_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10003")

				arg_32_1.callingController_:SetSelectedState("normal")

				arg_32_1.keyicon_.color = Color.New(1, 1, 1)
				arg_32_1.icon_.color = Color.New(1, 1, 1)

				local var_35_3 = arg_32_1:GetWordFromCfg(106041008)
				local var_35_4 = arg_32_1:FormatText(var_35_3.content)

				arg_32_1.text_.text = var_35_4

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_5 = 30
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

				if manager.audio:GetVoiceLength("story_v_out_106041", "106041008", "story_v_out_106041.awb") ~= 0 then
					local var_35_8 = manager.audio:GetVoiceLength("story_v_out_106041", "106041008", "story_v_out_106041.awb") / 1000

					if var_35_8 + var_35_0 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_8 + var_35_0
					end

					if var_35_3.prefab_name ~= "" and arg_32_1.actors_[var_35_3.prefab_name] ~= nil then
						local var_35_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_3.prefab_name].transform, "story_v_out_106041", "106041008", "story_v_out_106041.awb")

						arg_32_1:RecordAudio("106041008", var_35_9)
						arg_32_1:RecordAudio("106041008", var_35_9)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_106041", "106041008", "story_v_out_106041.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_106041", "106041008", "story_v_out_106041.awb")
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
	Play106041009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 106041009
		arg_36_1.duration_ = 17.1

		local var_36_0 = {
			ja = 12.833,
			ko = 10.933,
			zh = 10.733,
			en = 17.1
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
				arg_36_0:Play106041010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = 0
			local var_39_1 = 1.1

			if var_39_0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_0 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				local var_39_2 = arg_36_1:FormatText(StoryNameCfg[81].name)

				arg_36_1.leftNameTxt_.text = var_39_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, true)
				arg_36_1.iconController_:SetSelectedState("hero")

				arg_36_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10003")

				arg_36_1.callingController_:SetSelectedState("normal")

				arg_36_1.keyicon_.color = Color.New(1, 1, 1)
				arg_36_1.icon_.color = Color.New(1, 1, 1)

				local var_39_3 = arg_36_1:GetWordFromCfg(106041009)
				local var_39_4 = arg_36_1:FormatText(var_39_3.content)

				arg_36_1.text_.text = var_39_4

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_5 = 44
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

				if manager.audio:GetVoiceLength("story_v_out_106041", "106041009", "story_v_out_106041.awb") ~= 0 then
					local var_39_8 = manager.audio:GetVoiceLength("story_v_out_106041", "106041009", "story_v_out_106041.awb") / 1000

					if var_39_8 + var_39_0 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_8 + var_39_0
					end

					if var_39_3.prefab_name ~= "" and arg_36_1.actors_[var_39_3.prefab_name] ~= nil then
						local var_39_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_3.prefab_name].transform, "story_v_out_106041", "106041009", "story_v_out_106041.awb")

						arg_36_1:RecordAudio("106041009", var_39_9)
						arg_36_1:RecordAudio("106041009", var_39_9)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_106041", "106041009", "story_v_out_106041.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_106041", "106041009", "story_v_out_106041.awb")
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
	Play106041010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 106041010
		arg_40_1.duration_ = 4.27

		local var_40_0 = {
			ja = 3.433,
			ko = 3.833,
			zh = 4.266,
			en = 2.266
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
				arg_40_0:Play106041011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = 0
			local var_43_1 = 0.3

			if var_43_0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_0 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				local var_43_2 = arg_40_1:FormatText(StoryNameCfg[80].name)

				arg_40_1.leftNameTxt_.text = var_43_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, true)
				arg_40_1.iconController_:SetSelectedState("hero")

				arg_40_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10004")

				arg_40_1.callingController_:SetSelectedState("normal")

				arg_40_1.keyicon_.color = Color.New(1, 1, 1)
				arg_40_1.icon_.color = Color.New(1, 1, 1)

				local var_43_3 = arg_40_1:GetWordFromCfg(106041010)
				local var_43_4 = arg_40_1:FormatText(var_43_3.content)

				arg_40_1.text_.text = var_43_4

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_5 = 12
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

				if manager.audio:GetVoiceLength("story_v_out_106041", "106041010", "story_v_out_106041.awb") ~= 0 then
					local var_43_8 = manager.audio:GetVoiceLength("story_v_out_106041", "106041010", "story_v_out_106041.awb") / 1000

					if var_43_8 + var_43_0 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_8 + var_43_0
					end

					if var_43_3.prefab_name ~= "" and arg_40_1.actors_[var_43_3.prefab_name] ~= nil then
						local var_43_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_3.prefab_name].transform, "story_v_out_106041", "106041010", "story_v_out_106041.awb")

						arg_40_1:RecordAudio("106041010", var_43_9)
						arg_40_1:RecordAudio("106041010", var_43_9)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_106041", "106041010", "story_v_out_106041.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_106041", "106041010", "story_v_out_106041.awb")
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
	Play106041011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 106041011
		arg_44_1.duration_ = 10.87

		local var_44_0 = {
			ja = 10.866,
			ko = 5.3,
			zh = 5.566,
			en = 4.1
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
				arg_44_0:Play106041012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = 0
			local var_47_1 = 0.475

			if var_47_0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_0 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				local var_47_2 = arg_44_1:FormatText(StoryNameCfg[81].name)

				arg_44_1.leftNameTxt_.text = var_47_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, true)
				arg_44_1.iconController_:SetSelectedState("hero")

				arg_44_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10003")

				arg_44_1.callingController_:SetSelectedState("normal")

				arg_44_1.keyicon_.color = Color.New(1, 1, 1)
				arg_44_1.icon_.color = Color.New(1, 1, 1)

				local var_47_3 = arg_44_1:GetWordFromCfg(106041011)
				local var_47_4 = arg_44_1:FormatText(var_47_3.content)

				arg_44_1.text_.text = var_47_4

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_5 = 19
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

				if manager.audio:GetVoiceLength("story_v_out_106041", "106041011", "story_v_out_106041.awb") ~= 0 then
					local var_47_8 = manager.audio:GetVoiceLength("story_v_out_106041", "106041011", "story_v_out_106041.awb") / 1000

					if var_47_8 + var_47_0 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_8 + var_47_0
					end

					if var_47_3.prefab_name ~= "" and arg_44_1.actors_[var_47_3.prefab_name] ~= nil then
						local var_47_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_3.prefab_name].transform, "story_v_out_106041", "106041011", "story_v_out_106041.awb")

						arg_44_1:RecordAudio("106041011", var_47_9)
						arg_44_1:RecordAudio("106041011", var_47_9)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_106041", "106041011", "story_v_out_106041.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_106041", "106041011", "story_v_out_106041.awb")
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
	Play106041012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 106041012
		arg_48_1.duration_ = 5

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play106041013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = 0
			local var_51_1 = 0.875

			if var_51_0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_0 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, false)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_2 = arg_48_1:GetWordFromCfg(106041012)
				local var_51_3 = arg_48_1:FormatText(var_51_2.content)

				arg_48_1.text_.text = var_51_3

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_4 = 35
				local var_51_5 = utf8.len(var_51_3)
				local var_51_6 = var_51_4 <= 0 and var_51_1 or var_51_1 * (var_51_5 / var_51_4)

				if var_51_6 > 0 and var_51_1 < var_51_6 then
					arg_48_1.talkMaxDuration = var_51_6

					if var_51_6 + var_51_0 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_6 + var_51_0
					end
				end

				arg_48_1.text_.text = var_51_3
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)
				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_7 = math.max(var_51_1, arg_48_1.talkMaxDuration)

			if var_51_0 <= arg_48_1.time_ and arg_48_1.time_ < var_51_0 + var_51_7 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_0) / var_51_7

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_0 + var_51_7 and arg_48_1.time_ < var_51_0 + var_51_7 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play106041013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 106041013
		arg_52_1.duration_ = 11.63

		local var_52_0 = {
			ja = 11.1,
			ko = 10.066,
			zh = 9.166,
			en = 11.633
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
				arg_52_0:Play106041014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = 0
			local var_55_1 = 1.075

			if var_55_0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_0 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				local var_55_2 = arg_52_1:FormatText(StoryNameCfg[81].name)

				arg_52_1.leftNameTxt_.text = var_55_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, true)
				arg_52_1.iconController_:SetSelectedState("hero")

				arg_52_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10003")

				arg_52_1.callingController_:SetSelectedState("normal")

				arg_52_1.keyicon_.color = Color.New(1, 1, 1)
				arg_52_1.icon_.color = Color.New(1, 1, 1)

				local var_55_3 = arg_52_1:GetWordFromCfg(106041013)
				local var_55_4 = arg_52_1:FormatText(var_55_3.content)

				arg_52_1.text_.text = var_55_4

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_5 = 43
				local var_55_6 = utf8.len(var_55_4)
				local var_55_7 = var_55_5 <= 0 and var_55_1 or var_55_1 * (var_55_6 / var_55_5)

				if var_55_7 > 0 and var_55_1 < var_55_7 then
					arg_52_1.talkMaxDuration = var_55_7

					if var_55_7 + var_55_0 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_7 + var_55_0
					end
				end

				arg_52_1.text_.text = var_55_4
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106041", "106041013", "story_v_out_106041.awb") ~= 0 then
					local var_55_8 = manager.audio:GetVoiceLength("story_v_out_106041", "106041013", "story_v_out_106041.awb") / 1000

					if var_55_8 + var_55_0 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_8 + var_55_0
					end

					if var_55_3.prefab_name ~= "" and arg_52_1.actors_[var_55_3.prefab_name] ~= nil then
						local var_55_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_3.prefab_name].transform, "story_v_out_106041", "106041013", "story_v_out_106041.awb")

						arg_52_1:RecordAudio("106041013", var_55_9)
						arg_52_1:RecordAudio("106041013", var_55_9)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_106041", "106041013", "story_v_out_106041.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_106041", "106041013", "story_v_out_106041.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_10 = math.max(var_55_1, arg_52_1.talkMaxDuration)

			if var_55_0 <= arg_52_1.time_ and arg_52_1.time_ < var_55_0 + var_55_10 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_0) / var_55_10

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_0 + var_55_10 and arg_52_1.time_ < var_55_0 + var_55_10 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play106041014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 106041014
		arg_56_1.duration_ = 5.13

		local var_56_0 = {
			ja = 5.133,
			ko = 3.133,
			zh = 4.233,
			en = 4.8
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
				arg_56_0:Play106041015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = 0
			local var_59_1 = 0.325

			if var_59_0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_0 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				local var_59_2 = arg_56_1:FormatText(StoryNameCfg[80].name)

				arg_56_1.leftNameTxt_.text = var_59_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, true)
				arg_56_1.iconController_:SetSelectedState("hero")

				arg_56_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10004")

				arg_56_1.callingController_:SetSelectedState("normal")

				arg_56_1.keyicon_.color = Color.New(1, 1, 1)
				arg_56_1.icon_.color = Color.New(1, 1, 1)

				local var_59_3 = arg_56_1:GetWordFromCfg(106041014)
				local var_59_4 = arg_56_1:FormatText(var_59_3.content)

				arg_56_1.text_.text = var_59_4

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_5 = 13
				local var_59_6 = utf8.len(var_59_4)
				local var_59_7 = var_59_5 <= 0 and var_59_1 or var_59_1 * (var_59_6 / var_59_5)

				if var_59_7 > 0 and var_59_1 < var_59_7 then
					arg_56_1.talkMaxDuration = var_59_7

					if var_59_7 + var_59_0 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_7 + var_59_0
					end
				end

				arg_56_1.text_.text = var_59_4
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106041", "106041014", "story_v_out_106041.awb") ~= 0 then
					local var_59_8 = manager.audio:GetVoiceLength("story_v_out_106041", "106041014", "story_v_out_106041.awb") / 1000

					if var_59_8 + var_59_0 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_8 + var_59_0
					end

					if var_59_3.prefab_name ~= "" and arg_56_1.actors_[var_59_3.prefab_name] ~= nil then
						local var_59_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_3.prefab_name].transform, "story_v_out_106041", "106041014", "story_v_out_106041.awb")

						arg_56_1:RecordAudio("106041014", var_59_9)
						arg_56_1:RecordAudio("106041014", var_59_9)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_106041", "106041014", "story_v_out_106041.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_106041", "106041014", "story_v_out_106041.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_10 = math.max(var_59_1, arg_56_1.talkMaxDuration)

			if var_59_0 <= arg_56_1.time_ and arg_56_1.time_ < var_59_0 + var_59_10 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_0) / var_59_10

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_0 + var_59_10 and arg_56_1.time_ < var_59_0 + var_59_10 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play106041015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 106041015
		arg_60_1.duration_ = 5

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play106041016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = 0
			local var_63_1 = 1

			if var_63_0 < arg_60_1.time_ and arg_60_1.time_ <= var_63_0 + arg_63_0 then
				local var_63_2 = "play"
				local var_63_3 = "effect"

				arg_60_1:AudioAction(var_63_2, var_63_3, "se_story_6", "se_story_6_play_chess", "")
			end

			local var_63_4 = 0
			local var_63_5 = 0.05

			if var_63_4 < arg_60_1.time_ and arg_60_1.time_ <= var_63_4 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, false)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_6 = arg_60_1:GetWordFromCfg(106041015)
				local var_63_7 = arg_60_1:FormatText(var_63_6.content)

				arg_60_1.text_.text = var_63_7

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_8 = 2
				local var_63_9 = utf8.len(var_63_7)
				local var_63_10 = var_63_8 <= 0 and var_63_5 or var_63_5 * (var_63_9 / var_63_8)

				if var_63_10 > 0 and var_63_5 < var_63_10 then
					arg_60_1.talkMaxDuration = var_63_10

					if var_63_10 + var_63_4 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_10 + var_63_4
					end
				end

				arg_60_1.text_.text = var_63_7
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)
				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_11 = math.max(var_63_5, arg_60_1.talkMaxDuration)

			if var_63_4 <= arg_60_1.time_ and arg_60_1.time_ < var_63_4 + var_63_11 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_4) / var_63_11

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_4 + var_63_11 and arg_60_1.time_ < var_63_4 + var_63_11 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play106041016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 106041016
		arg_64_1.duration_ = 5.7

		local var_64_0 = {
			ja = 5.7,
			ko = 3.6,
			zh = 5.433,
			en = 4.466
		}
		local var_64_1 = manager.audio:GetLocalizationFlag()

		if var_64_0[var_64_1] ~= nil then
			arg_64_1.duration_ = var_64_0[var_64_1]
		end

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play106041017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = 0
			local var_67_1 = 0.475

			if var_67_0 < arg_64_1.time_ and arg_64_1.time_ <= var_67_0 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				local var_67_2 = arg_64_1:FormatText(StoryNameCfg[80].name)

				arg_64_1.leftNameTxt_.text = var_67_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, true)
				arg_64_1.iconController_:SetSelectedState("hero")

				arg_64_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10004")

				arg_64_1.callingController_:SetSelectedState("normal")

				arg_64_1.keyicon_.color = Color.New(1, 1, 1)
				arg_64_1.icon_.color = Color.New(1, 1, 1)

				local var_67_3 = arg_64_1:GetWordFromCfg(106041016)
				local var_67_4 = arg_64_1:FormatText(var_67_3.content)

				arg_64_1.text_.text = var_67_4

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_5 = 19
				local var_67_6 = utf8.len(var_67_4)
				local var_67_7 = var_67_5 <= 0 and var_67_1 or var_67_1 * (var_67_6 / var_67_5)

				if var_67_7 > 0 and var_67_1 < var_67_7 then
					arg_64_1.talkMaxDuration = var_67_7

					if var_67_7 + var_67_0 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_7 + var_67_0
					end
				end

				arg_64_1.text_.text = var_67_4
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106041", "106041016", "story_v_out_106041.awb") ~= 0 then
					local var_67_8 = manager.audio:GetVoiceLength("story_v_out_106041", "106041016", "story_v_out_106041.awb") / 1000

					if var_67_8 + var_67_0 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_8 + var_67_0
					end

					if var_67_3.prefab_name ~= "" and arg_64_1.actors_[var_67_3.prefab_name] ~= nil then
						local var_67_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_3.prefab_name].transform, "story_v_out_106041", "106041016", "story_v_out_106041.awb")

						arg_64_1:RecordAudio("106041016", var_67_9)
						arg_64_1:RecordAudio("106041016", var_67_9)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_106041", "106041016", "story_v_out_106041.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_106041", "106041016", "story_v_out_106041.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_10 = math.max(var_67_1, arg_64_1.talkMaxDuration)

			if var_67_0 <= arg_64_1.time_ and arg_64_1.time_ < var_67_0 + var_67_10 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_0) / var_67_10

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_0 + var_67_10 and arg_64_1.time_ < var_67_0 + var_67_10 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {}

		arg_64_1:InitPlayNodeList()
	end,
	Play106041017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 106041017
		arg_68_1.duration_ = 10.8

		local var_68_0 = {
			ja = 4.133,
			ko = 4.4,
			zh = 10.8,
			en = 8.2
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
				arg_68_0:Play106041018(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = 0
			local var_71_1 = 0.725

			if var_71_0 < arg_68_1.time_ and arg_68_1.time_ <= var_71_0 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				local var_71_2 = arg_68_1:FormatText(StoryNameCfg[81].name)

				arg_68_1.leftNameTxt_.text = var_71_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, true)
				arg_68_1.iconController_:SetSelectedState("hero")

				arg_68_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10003")

				arg_68_1.callingController_:SetSelectedState("normal")

				arg_68_1.keyicon_.color = Color.New(1, 1, 1)
				arg_68_1.icon_.color = Color.New(1, 1, 1)

				local var_71_3 = arg_68_1:GetWordFromCfg(106041017)
				local var_71_4 = arg_68_1:FormatText(var_71_3.content)

				arg_68_1.text_.text = var_71_4

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_5 = 28
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

				if manager.audio:GetVoiceLength("story_v_out_106041", "106041017", "story_v_out_106041.awb") ~= 0 then
					local var_71_8 = manager.audio:GetVoiceLength("story_v_out_106041", "106041017", "story_v_out_106041.awb") / 1000

					if var_71_8 + var_71_0 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_8 + var_71_0
					end

					if var_71_3.prefab_name ~= "" and arg_68_1.actors_[var_71_3.prefab_name] ~= nil then
						local var_71_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_3.prefab_name].transform, "story_v_out_106041", "106041017", "story_v_out_106041.awb")

						arg_68_1:RecordAudio("106041017", var_71_9)
						arg_68_1:RecordAudio("106041017", var_71_9)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_106041", "106041017", "story_v_out_106041.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_106041", "106041017", "story_v_out_106041.awb")
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
	Play106041018 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 106041018
		arg_72_1.duration_ = 10.23

		local var_72_0 = {
			ja = 9.166,
			ko = 9.466,
			zh = 10.233,
			en = 7.166
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
				arg_72_0:Play106041019(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = 0
			local var_75_1 = 0.85

			if var_75_0 < arg_72_1.time_ and arg_72_1.time_ <= var_75_0 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				local var_75_2 = arg_72_1:FormatText(StoryNameCfg[80].name)

				arg_72_1.leftNameTxt_.text = var_75_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, true)
				arg_72_1.iconController_:SetSelectedState("hero")

				arg_72_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10004")

				arg_72_1.callingController_:SetSelectedState("normal")

				arg_72_1.keyicon_.color = Color.New(1, 1, 1)
				arg_72_1.icon_.color = Color.New(1, 1, 1)

				local var_75_3 = arg_72_1:GetWordFromCfg(106041018)
				local var_75_4 = arg_72_1:FormatText(var_75_3.content)

				arg_72_1.text_.text = var_75_4

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_5 = 34
				local var_75_6 = utf8.len(var_75_4)
				local var_75_7 = var_75_5 <= 0 and var_75_1 or var_75_1 * (var_75_6 / var_75_5)

				if var_75_7 > 0 and var_75_1 < var_75_7 then
					arg_72_1.talkMaxDuration = var_75_7

					if var_75_7 + var_75_0 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_7 + var_75_0
					end
				end

				arg_72_1.text_.text = var_75_4
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106041", "106041018", "story_v_out_106041.awb") ~= 0 then
					local var_75_8 = manager.audio:GetVoiceLength("story_v_out_106041", "106041018", "story_v_out_106041.awb") / 1000

					if var_75_8 + var_75_0 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_8 + var_75_0
					end

					if var_75_3.prefab_name ~= "" and arg_72_1.actors_[var_75_3.prefab_name] ~= nil then
						local var_75_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_3.prefab_name].transform, "story_v_out_106041", "106041018", "story_v_out_106041.awb")

						arg_72_1:RecordAudio("106041018", var_75_9)
						arg_72_1:RecordAudio("106041018", var_75_9)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_106041", "106041018", "story_v_out_106041.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_106041", "106041018", "story_v_out_106041.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_10 = math.max(var_75_1, arg_72_1.talkMaxDuration)

			if var_75_0 <= arg_72_1.time_ and arg_72_1.time_ < var_75_0 + var_75_10 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_0) / var_75_10

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_0 + var_75_10 and arg_72_1.time_ < var_75_0 + var_75_10 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {}

		arg_72_1:InitPlayNodeList()
	end,
	Play106041019 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 106041019
		arg_76_1.duration_ = 14.7

		local var_76_0 = {
			ja = 14.7,
			ko = 11.133,
			zh = 10.433,
			en = 10.633
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
				arg_76_0:Play106041020(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = 0
			local var_79_1 = 1.075

			if var_79_0 < arg_76_1.time_ and arg_76_1.time_ <= var_79_0 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				local var_79_2 = arg_76_1:FormatText(StoryNameCfg[80].name)

				arg_76_1.leftNameTxt_.text = var_79_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, true)
				arg_76_1.iconController_:SetSelectedState("hero")

				arg_76_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10004")

				arg_76_1.callingController_:SetSelectedState("normal")

				arg_76_1.keyicon_.color = Color.New(1, 1, 1)
				arg_76_1.icon_.color = Color.New(1, 1, 1)

				local var_79_3 = arg_76_1:GetWordFromCfg(106041019)
				local var_79_4 = arg_76_1:FormatText(var_79_3.content)

				arg_76_1.text_.text = var_79_4

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_5 = 43
				local var_79_6 = utf8.len(var_79_4)
				local var_79_7 = var_79_5 <= 0 and var_79_1 or var_79_1 * (var_79_6 / var_79_5)

				if var_79_7 > 0 and var_79_1 < var_79_7 then
					arg_76_1.talkMaxDuration = var_79_7

					if var_79_7 + var_79_0 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_7 + var_79_0
					end
				end

				arg_76_1.text_.text = var_79_4
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106041", "106041019", "story_v_out_106041.awb") ~= 0 then
					local var_79_8 = manager.audio:GetVoiceLength("story_v_out_106041", "106041019", "story_v_out_106041.awb") / 1000

					if var_79_8 + var_79_0 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_8 + var_79_0
					end

					if var_79_3.prefab_name ~= "" and arg_76_1.actors_[var_79_3.prefab_name] ~= nil then
						local var_79_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_3.prefab_name].transform, "story_v_out_106041", "106041019", "story_v_out_106041.awb")

						arg_76_1:RecordAudio("106041019", var_79_9)
						arg_76_1:RecordAudio("106041019", var_79_9)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_106041", "106041019", "story_v_out_106041.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_106041", "106041019", "story_v_out_106041.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_10 = math.max(var_79_1, arg_76_1.talkMaxDuration)

			if var_79_0 <= arg_76_1.time_ and arg_76_1.time_ < var_79_0 + var_79_10 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_0) / var_79_10

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_0 + var_79_10 and arg_76_1.time_ < var_79_0 + var_79_10 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {}

		arg_76_1:InitPlayNodeList()
	end,
	Play106041020 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 106041020
		arg_80_1.duration_ = 16.33

		local var_80_0 = {
			ja = 16.333,
			ko = 10.933,
			zh = 11.866,
			en = 9.7
		}
		local var_80_1 = manager.audio:GetLocalizationFlag()

		if var_80_0[var_80_1] ~= nil then
			arg_80_1.duration_ = var_80_0[var_80_1]
		end

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play106041021(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = 0
			local var_83_1 = 1

			if var_83_0 < arg_80_1.time_ and arg_80_1.time_ <= var_83_0 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				local var_83_2 = arg_80_1:FormatText(StoryNameCfg[80].name)

				arg_80_1.leftNameTxt_.text = var_83_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, true)
				arg_80_1.iconController_:SetSelectedState("hero")

				arg_80_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10004")

				arg_80_1.callingController_:SetSelectedState("normal")

				arg_80_1.keyicon_.color = Color.New(1, 1, 1)
				arg_80_1.icon_.color = Color.New(1, 1, 1)

				local var_83_3 = arg_80_1:GetWordFromCfg(106041020)
				local var_83_4 = arg_80_1:FormatText(var_83_3.content)

				arg_80_1.text_.text = var_83_4

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_5 = 40
				local var_83_6 = utf8.len(var_83_4)
				local var_83_7 = var_83_5 <= 0 and var_83_1 or var_83_1 * (var_83_6 / var_83_5)

				if var_83_7 > 0 and var_83_1 < var_83_7 then
					arg_80_1.talkMaxDuration = var_83_7

					if var_83_7 + var_83_0 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_7 + var_83_0
					end
				end

				arg_80_1.text_.text = var_83_4
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106041", "106041020", "story_v_out_106041.awb") ~= 0 then
					local var_83_8 = manager.audio:GetVoiceLength("story_v_out_106041", "106041020", "story_v_out_106041.awb") / 1000

					if var_83_8 + var_83_0 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_8 + var_83_0
					end

					if var_83_3.prefab_name ~= "" and arg_80_1.actors_[var_83_3.prefab_name] ~= nil then
						local var_83_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_3.prefab_name].transform, "story_v_out_106041", "106041020", "story_v_out_106041.awb")

						arg_80_1:RecordAudio("106041020", var_83_9)
						arg_80_1:RecordAudio("106041020", var_83_9)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_out_106041", "106041020", "story_v_out_106041.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_out_106041", "106041020", "story_v_out_106041.awb")
				end

				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_10 = math.max(var_83_1, arg_80_1.talkMaxDuration)

			if var_83_0 <= arg_80_1.time_ and arg_80_1.time_ < var_83_0 + var_83_10 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_0) / var_83_10

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_0 + var_83_10 and arg_80_1.time_ < var_83_0 + var_83_10 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {}

		arg_80_1:InitPlayNodeList()
	end,
	Play106041021 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 106041021
		arg_84_1.duration_ = 12.5

		local var_84_0 = {
			ja = 12.5,
			ko = 7.4,
			zh = 9.066,
			en = 10.6
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
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play106041022(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = 0
			local var_87_1 = 0.8

			if var_87_0 < arg_84_1.time_ and arg_84_1.time_ <= var_87_0 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				local var_87_2 = arg_84_1:FormatText(StoryNameCfg[80].name)

				arg_84_1.leftNameTxt_.text = var_87_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, true)
				arg_84_1.iconController_:SetSelectedState("hero")

				arg_84_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10004")

				arg_84_1.callingController_:SetSelectedState("normal")

				arg_84_1.keyicon_.color = Color.New(1, 1, 1)
				arg_84_1.icon_.color = Color.New(1, 1, 1)

				local var_87_3 = arg_84_1:GetWordFromCfg(106041021)
				local var_87_4 = arg_84_1:FormatText(var_87_3.content)

				arg_84_1.text_.text = var_87_4

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_5 = 32
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

				if manager.audio:GetVoiceLength("story_v_out_106041", "106041021", "story_v_out_106041.awb") ~= 0 then
					local var_87_8 = manager.audio:GetVoiceLength("story_v_out_106041", "106041021", "story_v_out_106041.awb") / 1000

					if var_87_8 + var_87_0 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_8 + var_87_0
					end

					if var_87_3.prefab_name ~= "" and arg_84_1.actors_[var_87_3.prefab_name] ~= nil then
						local var_87_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_3.prefab_name].transform, "story_v_out_106041", "106041021", "story_v_out_106041.awb")

						arg_84_1:RecordAudio("106041021", var_87_9)
						arg_84_1:RecordAudio("106041021", var_87_9)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_out_106041", "106041021", "story_v_out_106041.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_out_106041", "106041021", "story_v_out_106041.awb")
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
	Play106041022 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 106041022
		arg_88_1.duration_ = 16.87

		local var_88_0 = {
			ja = 16.866,
			ko = 16.233,
			zh = 14.633,
			en = 11.833
		}
		local var_88_1 = manager.audio:GetLocalizationFlag()

		if var_88_0[var_88_1] ~= nil then
			arg_88_1.duration_ = var_88_0[var_88_1]
		end

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play106041023(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = 0
			local var_91_1 = 1.6

			if var_91_0 < arg_88_1.time_ and arg_88_1.time_ <= var_91_0 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				local var_91_2 = arg_88_1:FormatText(StoryNameCfg[80].name)

				arg_88_1.leftNameTxt_.text = var_91_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, true)
				arg_88_1.iconController_:SetSelectedState("hero")

				arg_88_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10004")

				arg_88_1.callingController_:SetSelectedState("normal")

				arg_88_1.keyicon_.color = Color.New(1, 1, 1)
				arg_88_1.icon_.color = Color.New(1, 1, 1)

				local var_91_3 = arg_88_1:GetWordFromCfg(106041022)
				local var_91_4 = arg_88_1:FormatText(var_91_3.content)

				arg_88_1.text_.text = var_91_4

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_5 = 47
				local var_91_6 = utf8.len(var_91_4)
				local var_91_7 = var_91_5 <= 0 and var_91_1 or var_91_1 * (var_91_6 / var_91_5)

				if var_91_7 > 0 and var_91_1 < var_91_7 then
					arg_88_1.talkMaxDuration = var_91_7

					if var_91_7 + var_91_0 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_7 + var_91_0
					end
				end

				arg_88_1.text_.text = var_91_4
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106041", "106041022", "story_v_out_106041.awb") ~= 0 then
					local var_91_8 = manager.audio:GetVoiceLength("story_v_out_106041", "106041022", "story_v_out_106041.awb") / 1000

					if var_91_8 + var_91_0 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_8 + var_91_0
					end

					if var_91_3.prefab_name ~= "" and arg_88_1.actors_[var_91_3.prefab_name] ~= nil then
						local var_91_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_88_1.actors_[var_91_3.prefab_name].transform, "story_v_out_106041", "106041022", "story_v_out_106041.awb")

						arg_88_1:RecordAudio("106041022", var_91_9)
						arg_88_1:RecordAudio("106041022", var_91_9)
					else
						arg_88_1:AudioAction("play", "voice", "story_v_out_106041", "106041022", "story_v_out_106041.awb")
					end

					arg_88_1:RecordHistoryTalkVoice("story_v_out_106041", "106041022", "story_v_out_106041.awb")
				end

				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_10 = math.max(var_91_1, arg_88_1.talkMaxDuration)

			if var_91_0 <= arg_88_1.time_ and arg_88_1.time_ < var_91_0 + var_91_10 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_0) / var_91_10

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_0 + var_91_10 and arg_88_1.time_ < var_91_0 + var_91_10 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {}

		arg_88_1:InitPlayNodeList()
	end,
	Play106041023 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 106041023
		arg_92_1.duration_ = 16.87

		local var_92_0 = {
			ja = 16.866,
			ko = 9.766,
			zh = 14.866,
			en = 15.066
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
				arg_92_0:Play106041024(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			local var_95_0 = 0
			local var_95_1 = 1.275

			if var_95_0 < arg_92_1.time_ and arg_92_1.time_ <= var_95_0 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				local var_95_2 = arg_92_1:FormatText(StoryNameCfg[80].name)

				arg_92_1.leftNameTxt_.text = var_95_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, true)
				arg_92_1.iconController_:SetSelectedState("hero")

				arg_92_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10004")

				arg_92_1.callingController_:SetSelectedState("normal")

				arg_92_1.keyicon_.color = Color.New(1, 1, 1)
				arg_92_1.icon_.color = Color.New(1, 1, 1)

				local var_95_3 = arg_92_1:GetWordFromCfg(106041023)
				local var_95_4 = arg_92_1:FormatText(var_95_3.content)

				arg_92_1.text_.text = var_95_4

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_5 = 51
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

				if manager.audio:GetVoiceLength("story_v_out_106041", "106041023", "story_v_out_106041.awb") ~= 0 then
					local var_95_8 = manager.audio:GetVoiceLength("story_v_out_106041", "106041023", "story_v_out_106041.awb") / 1000

					if var_95_8 + var_95_0 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_8 + var_95_0
					end

					if var_95_3.prefab_name ~= "" and arg_92_1.actors_[var_95_3.prefab_name] ~= nil then
						local var_95_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_3.prefab_name].transform, "story_v_out_106041", "106041023", "story_v_out_106041.awb")

						arg_92_1:RecordAudio("106041023", var_95_9)
						arg_92_1:RecordAudio("106041023", var_95_9)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_out_106041", "106041023", "story_v_out_106041.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_out_106041", "106041023", "story_v_out_106041.awb")
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
	Play106041024 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 106041024
		arg_96_1.duration_ = 11.3

		local var_96_0 = {
			ja = 11.3,
			ko = 7,
			zh = 7.366,
			en = 6
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
				arg_96_0:Play106041025(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			local var_99_0 = 0
			local var_99_1 = 0.675

			if var_99_0 < arg_96_1.time_ and arg_96_1.time_ <= var_99_0 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				local var_99_2 = arg_96_1:FormatText(StoryNameCfg[81].name)

				arg_96_1.leftNameTxt_.text = var_99_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, true)
				arg_96_1.iconController_:SetSelectedState("hero")

				arg_96_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10003")

				arg_96_1.callingController_:SetSelectedState("normal")

				arg_96_1.keyicon_.color = Color.New(1, 1, 1)
				arg_96_1.icon_.color = Color.New(1, 1, 1)

				local var_99_3 = arg_96_1:GetWordFromCfg(106041024)
				local var_99_4 = arg_96_1:FormatText(var_99_3.content)

				arg_96_1.text_.text = var_99_4

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_5 = 26
				local var_99_6 = utf8.len(var_99_4)
				local var_99_7 = var_99_5 <= 0 and var_99_1 or var_99_1 * (var_99_6 / var_99_5)

				if var_99_7 > 0 and var_99_1 < var_99_7 then
					arg_96_1.talkMaxDuration = var_99_7

					if var_99_7 + var_99_0 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_7 + var_99_0
					end
				end

				arg_96_1.text_.text = var_99_4
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106041", "106041024", "story_v_out_106041.awb") ~= 0 then
					local var_99_8 = manager.audio:GetVoiceLength("story_v_out_106041", "106041024", "story_v_out_106041.awb") / 1000

					if var_99_8 + var_99_0 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_8 + var_99_0
					end

					if var_99_3.prefab_name ~= "" and arg_96_1.actors_[var_99_3.prefab_name] ~= nil then
						local var_99_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_96_1.actors_[var_99_3.prefab_name].transform, "story_v_out_106041", "106041024", "story_v_out_106041.awb")

						arg_96_1:RecordAudio("106041024", var_99_9)
						arg_96_1:RecordAudio("106041024", var_99_9)
					else
						arg_96_1:AudioAction("play", "voice", "story_v_out_106041", "106041024", "story_v_out_106041.awb")
					end

					arg_96_1:RecordHistoryTalkVoice("story_v_out_106041", "106041024", "story_v_out_106041.awb")
				end

				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_10 = math.max(var_99_1, arg_96_1.talkMaxDuration)

			if var_99_0 <= arg_96_1.time_ and arg_96_1.time_ < var_99_0 + var_99_10 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_0) / var_99_10

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_0 + var_99_10 and arg_96_1.time_ < var_99_0 + var_99_10 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {}

		arg_96_1:InitPlayNodeList()
	end,
	Play106041025 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 106041025
		arg_100_1.duration_ = 22.53

		local var_100_0 = {
			ja = 20.366,
			ko = 12.366,
			zh = 21.3,
			en = 22.533
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
				arg_100_0:Play106041026(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			local var_103_0 = 0
			local var_103_1 = 1.725

			if var_103_0 < arg_100_1.time_ and arg_100_1.time_ <= var_103_0 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				local var_103_2 = arg_100_1:FormatText(StoryNameCfg[80].name)

				arg_100_1.leftNameTxt_.text = var_103_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, true)
				arg_100_1.iconController_:SetSelectedState("hero")

				arg_100_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10004")

				arg_100_1.callingController_:SetSelectedState("normal")

				arg_100_1.keyicon_.color = Color.New(1, 1, 1)
				arg_100_1.icon_.color = Color.New(1, 1, 1)

				local var_103_3 = arg_100_1:GetWordFromCfg(106041025)
				local var_103_4 = arg_100_1:FormatText(var_103_3.content)

				arg_100_1.text_.text = var_103_4

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_5 = 70
				local var_103_6 = utf8.len(var_103_4)
				local var_103_7 = var_103_5 <= 0 and var_103_1 or var_103_1 * (var_103_6 / var_103_5)

				if var_103_7 > 0 and var_103_1 < var_103_7 then
					arg_100_1.talkMaxDuration = var_103_7

					if var_103_7 + var_103_0 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_7 + var_103_0
					end
				end

				arg_100_1.text_.text = var_103_4
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106041", "106041025", "story_v_out_106041.awb") ~= 0 then
					local var_103_8 = manager.audio:GetVoiceLength("story_v_out_106041", "106041025", "story_v_out_106041.awb") / 1000

					if var_103_8 + var_103_0 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_8 + var_103_0
					end

					if var_103_3.prefab_name ~= "" and arg_100_1.actors_[var_103_3.prefab_name] ~= nil then
						local var_103_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_100_1.actors_[var_103_3.prefab_name].transform, "story_v_out_106041", "106041025", "story_v_out_106041.awb")

						arg_100_1:RecordAudio("106041025", var_103_9)
						arg_100_1:RecordAudio("106041025", var_103_9)
					else
						arg_100_1:AudioAction("play", "voice", "story_v_out_106041", "106041025", "story_v_out_106041.awb")
					end

					arg_100_1:RecordHistoryTalkVoice("story_v_out_106041", "106041025", "story_v_out_106041.awb")
				end

				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_10 = math.max(var_103_1, arg_100_1.talkMaxDuration)

			if var_103_0 <= arg_100_1.time_ and arg_100_1.time_ < var_103_0 + var_103_10 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_0) / var_103_10

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_0 + var_103_10 and arg_100_1.time_ < var_103_0 + var_103_10 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {}

		arg_100_1:InitPlayNodeList()
	end,
	Play106041026 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 106041026
		arg_104_1.duration_ = 18.13

		local var_104_0 = {
			ja = 18.133,
			ko = 11,
			zh = 13.766,
			en = 10.6
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
				arg_104_0:Play106041027(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			local var_107_0 = 0
			local var_107_1 = 1.2

			if var_107_0 < arg_104_1.time_ and arg_104_1.time_ <= var_107_0 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				local var_107_2 = arg_104_1:FormatText(StoryNameCfg[80].name)

				arg_104_1.leftNameTxt_.text = var_107_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, true)
				arg_104_1.iconController_:SetSelectedState("hero")

				arg_104_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10004")

				arg_104_1.callingController_:SetSelectedState("normal")

				arg_104_1.keyicon_.color = Color.New(1, 1, 1)
				arg_104_1.icon_.color = Color.New(1, 1, 1)

				local var_107_3 = arg_104_1:GetWordFromCfg(106041026)
				local var_107_4 = arg_104_1:FormatText(var_107_3.content)

				arg_104_1.text_.text = var_107_4

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_5 = 48
				local var_107_6 = utf8.len(var_107_4)
				local var_107_7 = var_107_5 <= 0 and var_107_1 or var_107_1 * (var_107_6 / var_107_5)

				if var_107_7 > 0 and var_107_1 < var_107_7 then
					arg_104_1.talkMaxDuration = var_107_7

					if var_107_7 + var_107_0 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_7 + var_107_0
					end
				end

				arg_104_1.text_.text = var_107_4
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106041", "106041026", "story_v_out_106041.awb") ~= 0 then
					local var_107_8 = manager.audio:GetVoiceLength("story_v_out_106041", "106041026", "story_v_out_106041.awb") / 1000

					if var_107_8 + var_107_0 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_8 + var_107_0
					end

					if var_107_3.prefab_name ~= "" and arg_104_1.actors_[var_107_3.prefab_name] ~= nil then
						local var_107_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_104_1.actors_[var_107_3.prefab_name].transform, "story_v_out_106041", "106041026", "story_v_out_106041.awb")

						arg_104_1:RecordAudio("106041026", var_107_9)
						arg_104_1:RecordAudio("106041026", var_107_9)
					else
						arg_104_1:AudioAction("play", "voice", "story_v_out_106041", "106041026", "story_v_out_106041.awb")
					end

					arg_104_1:RecordHistoryTalkVoice("story_v_out_106041", "106041026", "story_v_out_106041.awb")
				end

				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_10 = math.max(var_107_1, arg_104_1.talkMaxDuration)

			if var_107_0 <= arg_104_1.time_ and arg_104_1.time_ < var_107_0 + var_107_10 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_0) / var_107_10

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_0 + var_107_10 and arg_104_1.time_ < var_107_0 + var_107_10 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {}

		arg_104_1:InitPlayNodeList()
	end,
	Play106041027 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 106041027
		arg_108_1.duration_ = 2.17

		local var_108_0 = {
			ja = 1.633,
			ko = 1.733,
			zh = 1.4,
			en = 2.166
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
				arg_108_0:Play106041028(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			local var_111_0 = 0
			local var_111_1 = 0.05

			if var_111_0 < arg_108_1.time_ and arg_108_1.time_ <= var_111_0 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				local var_111_2 = arg_108_1:FormatText(StoryNameCfg[81].name)

				arg_108_1.leftNameTxt_.text = var_111_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, true)
				arg_108_1.iconController_:SetSelectedState("hero")

				arg_108_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10003")

				arg_108_1.callingController_:SetSelectedState("normal")

				arg_108_1.keyicon_.color = Color.New(1, 1, 1)
				arg_108_1.icon_.color = Color.New(1, 1, 1)

				local var_111_3 = arg_108_1:GetWordFromCfg(106041027)
				local var_111_4 = arg_108_1:FormatText(var_111_3.content)

				arg_108_1.text_.text = var_111_4

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_5 = 2
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

				if manager.audio:GetVoiceLength("story_v_out_106041", "106041027", "story_v_out_106041.awb") ~= 0 then
					local var_111_8 = manager.audio:GetVoiceLength("story_v_out_106041", "106041027", "story_v_out_106041.awb") / 1000

					if var_111_8 + var_111_0 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_8 + var_111_0
					end

					if var_111_3.prefab_name ~= "" and arg_108_1.actors_[var_111_3.prefab_name] ~= nil then
						local var_111_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_108_1.actors_[var_111_3.prefab_name].transform, "story_v_out_106041", "106041027", "story_v_out_106041.awb")

						arg_108_1:RecordAudio("106041027", var_111_9)
						arg_108_1:RecordAudio("106041027", var_111_9)
					else
						arg_108_1:AudioAction("play", "voice", "story_v_out_106041", "106041027", "story_v_out_106041.awb")
					end

					arg_108_1:RecordHistoryTalkVoice("story_v_out_106041", "106041027", "story_v_out_106041.awb")
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
	Play106041028 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 106041028
		arg_112_1.duration_ = 6.2

		local var_112_0 = {
			ja = 6.2,
			ko = 5.766,
			zh = 5.6,
			en = 4.833
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
				arg_112_0:Play106041029(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			local var_115_0 = "3004_tpose"

			if arg_112_1.actors_[var_115_0] == nil then
				local var_115_1 = Asset.Load("Char/" .. "3004_tpose")

				if not isNil(var_115_1) then
					local var_115_2 = Object.Instantiate(Asset.Load("Char/" .. "3004_tpose"), arg_112_1.stage_.transform)

					var_115_2.name = var_115_0
					var_115_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_112_1.actors_[var_115_0] = var_115_2

					local var_115_3 = var_115_2:GetComponentInChildren(typeof(CharacterEffect))

					var_115_3.enabled = true

					local var_115_4 = GameObjectTools.GetOrAddComponent(var_115_2, typeof(DynamicBoneHelper))

					if var_115_4 then
						var_115_4:EnableDynamicBone(false)
					end

					arg_112_1:ShowWeapon(var_115_3.transform, false)

					arg_112_1.var_[var_115_0 .. "Animator"] = var_115_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_112_1.var_[var_115_0 .. "Animator"].applyRootMotion = true
					arg_112_1.var_[var_115_0 .. "LipSync"] = var_115_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_115_5 = arg_112_1.actors_["3004_tpose"]
			local var_115_6 = 2

			if var_115_6 < arg_112_1.time_ and arg_112_1.time_ <= var_115_6 + arg_115_0 and not isNil(var_115_5) and arg_112_1.var_.characterEffect3004_tpose == nil then
				arg_112_1.var_.characterEffect3004_tpose = var_115_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_115_7 = 0.1

			if var_115_6 <= arg_112_1.time_ and arg_112_1.time_ < var_115_6 + var_115_7 and not isNil(var_115_5) then
				local var_115_8 = (arg_112_1.time_ - var_115_6) / var_115_7

				if arg_112_1.var_.characterEffect3004_tpose and not isNil(var_115_5) then
					arg_112_1.var_.characterEffect3004_tpose.fillFlat = false
				end
			end

			if arg_112_1.time_ >= var_115_6 + var_115_7 and arg_112_1.time_ < var_115_6 + var_115_7 + arg_115_0 and not isNil(var_115_5) and arg_112_1.var_.characterEffect3004_tpose then
				arg_112_1.var_.characterEffect3004_tpose.fillFlat = false
			end

			local var_115_9 = arg_112_1.bgs_.S0607
			local var_115_10 = 0

			if var_115_10 < arg_112_1.time_ and arg_112_1.time_ <= var_115_10 + arg_115_0 then
				local var_115_11 = var_115_9:GetComponent("SpriteRenderer")

				if var_115_11 then
					arg_112_1.var_.alphaOldValueS0607 = var_115_11.color.a
					arg_112_1.var_.alphaMatValueS0607 = var_115_11
				end

				arg_112_1.var_.alphaOldValueS0607 = 1
			end

			local var_115_12 = 1.5

			if var_115_10 <= arg_112_1.time_ and arg_112_1.time_ < var_115_10 + var_115_12 then
				local var_115_13 = (arg_112_1.time_ - var_115_10) / var_115_12
				local var_115_14 = Mathf.Lerp(arg_112_1.var_.alphaOldValueS0607, 0, var_115_13)

				if arg_112_1.var_.alphaMatValueS0607 then
					local var_115_15 = arg_112_1.var_.alphaMatValueS0607.color

					var_115_15.a = var_115_14
					arg_112_1.var_.alphaMatValueS0607.color = var_115_15
				end
			end

			if arg_112_1.time_ >= var_115_10 + var_115_12 and arg_112_1.time_ < var_115_10 + var_115_12 + arg_115_0 and arg_112_1.var_.alphaMatValueS0607 then
				local var_115_16 = arg_112_1.var_.alphaMatValueS0607
				local var_115_17 = var_115_16.color

				var_115_17.a = 0
				var_115_16.color = var_115_17
			end

			local var_115_18 = arg_112_1.bgs_.S0607.transform
			local var_115_19 = 1.5

			if var_115_19 < arg_112_1.time_ and arg_112_1.time_ <= var_115_19 + arg_115_0 then
				arg_112_1.var_.moveOldPosS0607 = var_115_18.localPosition
			end

			local var_115_20 = 0.001

			if var_115_19 <= arg_112_1.time_ and arg_112_1.time_ < var_115_19 + var_115_20 then
				local var_115_21 = (arg_112_1.time_ - var_115_19) / var_115_20
				local var_115_22 = Vector3.New(0, -100, 10)

				var_115_18.localPosition = Vector3.Lerp(arg_112_1.var_.moveOldPosS0607, var_115_22, var_115_21)
			end

			if arg_112_1.time_ >= var_115_19 + var_115_20 and arg_112_1.time_ < var_115_19 + var_115_20 + arg_115_0 then
				var_115_18.localPosition = Vector3.New(0, -100, 10)
			end

			local var_115_23 = "ST06a"

			if arg_112_1.bgs_[var_115_23] == nil then
				local var_115_24 = Object.Instantiate(arg_112_1.paintGo_)

				var_115_24:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_115_23)
				var_115_24.name = var_115_23
				var_115_24.transform.parent = arg_112_1.stage_.transform
				var_115_24.transform.localPosition = Vector3.New(0, 100, 0)
				arg_112_1.bgs_[var_115_23] = var_115_24
			end

			local var_115_25 = arg_112_1.bgs_.ST06a
			local var_115_26 = 1.5

			if var_115_26 < arg_112_1.time_ and arg_112_1.time_ <= var_115_26 + arg_115_0 then
				local var_115_27 = var_115_25:GetComponent("SpriteRenderer")

				if var_115_27 then
					arg_112_1.var_.alphaOldValueST06a = var_115_27.color.a
					arg_112_1.var_.alphaMatValueST06a = var_115_27
				end

				arg_112_1.var_.alphaOldValueST06a = 0
			end

			local var_115_28 = 1.5

			if var_115_26 <= arg_112_1.time_ and arg_112_1.time_ < var_115_26 + var_115_28 then
				local var_115_29 = (arg_112_1.time_ - var_115_26) / var_115_28
				local var_115_30 = Mathf.Lerp(arg_112_1.var_.alphaOldValueST06a, 1, var_115_29)

				if arg_112_1.var_.alphaMatValueST06a then
					local var_115_31 = arg_112_1.var_.alphaMatValueST06a.color

					var_115_31.a = var_115_30
					arg_112_1.var_.alphaMatValueST06a.color = var_115_31
				end
			end

			if arg_112_1.time_ >= var_115_26 + var_115_28 and arg_112_1.time_ < var_115_26 + var_115_28 + arg_115_0 and arg_112_1.var_.alphaMatValueST06a then
				local var_115_32 = arg_112_1.var_.alphaMatValueST06a
				local var_115_33 = var_115_32.color

				var_115_33.a = 1
				var_115_32.color = var_115_33
			end

			local var_115_34 = 1.5

			if var_115_34 < arg_112_1.time_ and arg_112_1.time_ <= var_115_34 + arg_115_0 then
				local var_115_35 = manager.ui.mainCamera.transform.localPosition
				local var_115_36 = Vector3.New(0, 0, 10) + Vector3.New(var_115_35.x, var_115_35.y, 0)
				local var_115_37 = arg_112_1.bgs_.ST06a

				var_115_37.transform.localPosition = var_115_36
				var_115_37.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_115_38 = var_115_37:GetComponent("SpriteRenderer")

				if var_115_38 and var_115_38.sprite then
					local var_115_39 = (var_115_37.transform.localPosition - var_115_35).z
					local var_115_40 = manager.ui.mainCameraCom_
					local var_115_41 = 2 * var_115_39 * Mathf.Tan(var_115_40.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_115_42 = var_115_41 * var_115_40.aspect
					local var_115_43 = var_115_38.sprite.bounds.size.x
					local var_115_44 = var_115_38.sprite.bounds.size.y
					local var_115_45 = var_115_42 / var_115_43
					local var_115_46 = var_115_41 / var_115_44
					local var_115_47 = var_115_46 < var_115_45 and var_115_45 or var_115_46

					var_115_37.transform.localScale = Vector3.New(var_115_47, var_115_47, 0)
				end

				for iter_115_0, iter_115_1 in pairs(arg_112_1.bgs_) do
					if iter_115_0 ~= "ST06a" then
						iter_115_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_115_48 = arg_112_1.actors_["3004_tpose"].transform
			local var_115_49 = 2

			if var_115_49 < arg_112_1.time_ and arg_112_1.time_ <= var_115_49 + arg_115_0 then
				arg_112_1.var_.moveOldPos3004_tpose = var_115_48.localPosition

				local var_115_50 = GameObjectTools.GetOrAddComponent(var_115_48.gameObject, typeof(DynamicBoneHelper))

				if var_115_50 then
					var_115_50:EnableDynamicBone(false)
				end
			end

			local var_115_51 = 0.001

			if var_115_49 <= arg_112_1.time_ and arg_112_1.time_ < var_115_49 + var_115_51 then
				local var_115_52 = (arg_112_1.time_ - var_115_49) / var_115_51
				local var_115_53 = Vector3.New(-0.7, -2.22, -3.1)

				var_115_48.localPosition = Vector3.Lerp(arg_112_1.var_.moveOldPos3004_tpose, var_115_53, var_115_52)

				local var_115_54 = manager.ui.mainCamera.transform.position - var_115_48.position

				var_115_48.forward = Vector3.New(var_115_54.x, var_115_54.y, var_115_54.z)

				local var_115_55 = var_115_48.localEulerAngles

				var_115_55.z = 0
				var_115_55.x = 0
				var_115_48.localEulerAngles = var_115_55
			end

			if arg_112_1.time_ >= var_115_49 + var_115_51 and arg_112_1.time_ < var_115_49 + var_115_51 + arg_115_0 then
				var_115_48.localPosition = Vector3.New(-0.7, -2.22, -3.1)

				local var_115_56 = manager.ui.mainCamera.transform.position - var_115_48.position

				var_115_48.forward = Vector3.New(var_115_56.x, var_115_56.y, var_115_56.z)

				local var_115_57 = var_115_48.localEulerAngles

				var_115_57.z = 0
				var_115_57.x = 0
				var_115_48.localEulerAngles = var_115_57

				local var_115_58 = GameObjectTools.GetOrAddComponent(var_115_48.gameObject, typeof(DynamicBoneHelper))

				if var_115_58 then
					var_115_58:EnableDynamicBone(true)
				end
			end

			local var_115_59 = 2

			if var_115_59 < arg_112_1.time_ and arg_112_1.time_ <= var_115_59 + arg_115_0 then
				arg_112_1:PlayTimeline("3004_tpose", "StoryTimeline/CharAction/story3004/story3004action/3004action1_1")
			end

			local var_115_60 = 0

			if var_115_60 < arg_112_1.time_ and arg_112_1.time_ <= var_115_60 + arg_115_0 then
				arg_112_1.allBtn_.enabled = false
			end

			local var_115_61 = 2

			if arg_112_1.time_ >= var_115_60 + var_115_61 and arg_112_1.time_ < var_115_60 + var_115_61 + arg_115_0 then
				arg_112_1.allBtn_.enabled = true
			end

			if arg_112_1.frameCnt_ <= 1 then
				arg_112_1.dialog_:SetActive(false)
			end

			local var_115_62 = 2
			local var_115_63 = 0.25

			if var_115_62 < arg_112_1.time_ and arg_112_1.time_ <= var_115_62 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0

				arg_112_1.dialog_:SetActive(true)

				arg_112_1.dialogCg_.alpha = 0

				local var_115_64 = LeanTween.value(arg_112_1.dialog_, 0, 1, 0.3)

				var_115_64:setOnUpdate(LuaHelper.FloatAction(function(arg_116_0)
					arg_112_1.dialogCg_.alpha = arg_116_0
				end))
				var_115_64:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_112_1.dialog_)
					var_115_64:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_112_1.duration_ = arg_112_1.duration_ + 0.3

				SetActive(arg_112_1.leftNameGo_, true)

				local var_115_65 = arg_112_1:FormatText(StoryNameCfg[82].name)

				arg_112_1.leftNameTxt_.text = var_115_65

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_66 = arg_112_1:GetWordFromCfg(106041028)
				local var_115_67 = arg_112_1:FormatText(var_115_66.content)

				arg_112_1.text_.text = var_115_67

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_68 = 10
				local var_115_69 = utf8.len(var_115_67)
				local var_115_70 = var_115_68 <= 0 and var_115_63 or var_115_63 * (var_115_69 / var_115_68)

				if var_115_70 > 0 and var_115_63 < var_115_70 then
					arg_112_1.talkMaxDuration = var_115_70
					var_115_62 = var_115_62 + 0.3

					if var_115_70 + var_115_62 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_70 + var_115_62
					end
				end

				arg_112_1.text_.text = var_115_67
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106041", "106041028", "story_v_out_106041.awb") ~= 0 then
					local var_115_71 = manager.audio:GetVoiceLength("story_v_out_106041", "106041028", "story_v_out_106041.awb") / 1000

					if var_115_71 + var_115_62 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_71 + var_115_62
					end

					if var_115_66.prefab_name ~= "" and arg_112_1.actors_[var_115_66.prefab_name] ~= nil then
						local var_115_72 = LuaForUtil.PlayVoiceWithCriLipsync(arg_112_1.actors_[var_115_66.prefab_name].transform, "story_v_out_106041", "106041028", "story_v_out_106041.awb")

						arg_112_1:RecordAudio("106041028", var_115_72)
						arg_112_1:RecordAudio("106041028", var_115_72)
					else
						arg_112_1:AudioAction("play", "voice", "story_v_out_106041", "106041028", "story_v_out_106041.awb")
					end

					arg_112_1:RecordHistoryTalkVoice("story_v_out_106041", "106041028", "story_v_out_106041.awb")
				end

				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_73 = var_115_62 + 0.3
			local var_115_74 = math.max(var_115_63, arg_112_1.talkMaxDuration)

			if var_115_73 <= arg_112_1.time_ and arg_112_1.time_ < var_115_73 + var_115_74 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_73) / var_115_74

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_73 + var_115_74 and arg_112_1.time_ < var_115_73 + var_115_74 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "S0607",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 1.5,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "3004_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_112_1:InitPlayNodeList()
	end,
	Play106041029 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 106041029
		arg_118_1.duration_ = 6.4

		local var_118_0 = {
			ja = 6.4,
			ko = 4.066,
			zh = 4.833,
			en = 5.966
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
				arg_118_0:Play106041030(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			local var_121_0 = arg_118_1.actors_["3004_tpose"]
			local var_121_1 = 0

			if var_121_1 < arg_118_1.time_ and arg_118_1.time_ <= var_121_1 + arg_121_0 and not isNil(var_121_0) and arg_118_1.var_.characterEffect3004_tpose == nil then
				arg_118_1.var_.characterEffect3004_tpose = var_121_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_121_2 = 0.1

			if var_121_1 <= arg_118_1.time_ and arg_118_1.time_ < var_121_1 + var_121_2 and not isNil(var_121_0) then
				local var_121_3 = (arg_118_1.time_ - var_121_1) / var_121_2

				if arg_118_1.var_.characterEffect3004_tpose and not isNil(var_121_0) then
					local var_121_4 = Mathf.Lerp(0, 0.5, var_121_3)

					arg_118_1.var_.characterEffect3004_tpose.fillFlat = true
					arg_118_1.var_.characterEffect3004_tpose.fillRatio = var_121_4
				end
			end

			if arg_118_1.time_ >= var_121_1 + var_121_2 and arg_118_1.time_ < var_121_1 + var_121_2 + arg_121_0 and not isNil(var_121_0) and arg_118_1.var_.characterEffect3004_tpose then
				local var_121_5 = 0.5

				arg_118_1.var_.characterEffect3004_tpose.fillFlat = true
				arg_118_1.var_.characterEffect3004_tpose.fillRatio = var_121_5
			end

			local var_121_6 = "10004ui_story"

			if arg_118_1.actors_[var_121_6] == nil then
				local var_121_7 = Asset.Load("Char/" .. "10004ui_story")

				if not isNil(var_121_7) then
					local var_121_8 = Object.Instantiate(Asset.Load("Char/" .. "10004ui_story"), arg_118_1.stage_.transform)

					var_121_8.name = var_121_6
					var_121_8.transform.localPosition = Vector3.New(0, 100, 0)
					arg_118_1.actors_[var_121_6] = var_121_8

					local var_121_9 = var_121_8:GetComponentInChildren(typeof(CharacterEffect))

					var_121_9.enabled = true

					local var_121_10 = GameObjectTools.GetOrAddComponent(var_121_8, typeof(DynamicBoneHelper))

					if var_121_10 then
						var_121_10:EnableDynamicBone(false)
					end

					arg_118_1:ShowWeapon(var_121_9.transform, false)

					arg_118_1.var_[var_121_6 .. "Animator"] = var_121_9.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_118_1.var_[var_121_6 .. "Animator"].applyRootMotion = true
					arg_118_1.var_[var_121_6 .. "LipSync"] = var_121_9.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_121_11 = arg_118_1.actors_["10004ui_story"]
			local var_121_12 = 0

			if var_121_12 < arg_118_1.time_ and arg_118_1.time_ <= var_121_12 + arg_121_0 and not isNil(var_121_11) and arg_118_1.var_.characterEffect10004ui_story == nil then
				arg_118_1.var_.characterEffect10004ui_story = var_121_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_121_13 = 0.1

			if var_121_12 <= arg_118_1.time_ and arg_118_1.time_ < var_121_12 + var_121_13 and not isNil(var_121_11) then
				local var_121_14 = (arg_118_1.time_ - var_121_12) / var_121_13

				if arg_118_1.var_.characterEffect10004ui_story and not isNil(var_121_11) then
					arg_118_1.var_.characterEffect10004ui_story.fillFlat = false
				end
			end

			if arg_118_1.time_ >= var_121_12 + var_121_13 and arg_118_1.time_ < var_121_12 + var_121_13 + arg_121_0 and not isNil(var_121_11) and arg_118_1.var_.characterEffect10004ui_story then
				arg_118_1.var_.characterEffect10004ui_story.fillFlat = false
			end

			local var_121_15 = arg_118_1.actors_["10004ui_story"].transform
			local var_121_16 = 0

			if var_121_16 < arg_118_1.time_ and arg_118_1.time_ <= var_121_16 + arg_121_0 then
				arg_118_1.var_.moveOldPos10004ui_story = var_121_15.localPosition
			end

			local var_121_17 = 0.001

			if var_121_16 <= arg_118_1.time_ and arg_118_1.time_ < var_121_16 + var_121_17 then
				local var_121_18 = (arg_118_1.time_ - var_121_16) / var_121_17
				local var_121_19 = Vector3.New(0.7, -1.1, -5.6)

				var_121_15.localPosition = Vector3.Lerp(arg_118_1.var_.moveOldPos10004ui_story, var_121_19, var_121_18)

				local var_121_20 = manager.ui.mainCamera.transform.position - var_121_15.position

				var_121_15.forward = Vector3.New(var_121_20.x, var_121_20.y, var_121_20.z)

				local var_121_21 = var_121_15.localEulerAngles

				var_121_21.z = 0
				var_121_21.x = 0
				var_121_15.localEulerAngles = var_121_21
			end

			if arg_118_1.time_ >= var_121_16 + var_121_17 and arg_118_1.time_ < var_121_16 + var_121_17 + arg_121_0 then
				var_121_15.localPosition = Vector3.New(0.7, -1.1, -5.6)

				local var_121_22 = manager.ui.mainCamera.transform.position - var_121_15.position

				var_121_15.forward = Vector3.New(var_121_22.x, var_121_22.y, var_121_22.z)

				local var_121_23 = var_121_15.localEulerAngles

				var_121_23.z = 0
				var_121_23.x = 0
				var_121_15.localEulerAngles = var_121_23
			end

			local var_121_24 = 0

			if var_121_24 < arg_118_1.time_ and arg_118_1.time_ <= var_121_24 + arg_121_0 then
				arg_118_1:PlayTimeline("10004ui_story", "StoryTimeline/CharAction/story10004/story10004action/10004action5_1")
			end

			local var_121_25 = 0

			if var_121_25 < arg_118_1.time_ and arg_118_1.time_ <= var_121_25 + arg_121_0 then
				arg_118_1:PlayTimeline("10004ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_121_26 = 0
			local var_121_27 = 0.425

			if var_121_26 < arg_118_1.time_ and arg_118_1.time_ <= var_121_26 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, true)

				local var_121_28 = arg_118_1:FormatText(StoryNameCfg[80].name)

				arg_118_1.leftNameTxt_.text = var_121_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_118_1.leftNameTxt_.transform)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1.leftNameTxt_.text)
				SetActive(arg_118_1.iconTrs_.gameObject, false)
				arg_118_1.callingController_:SetSelectedState("normal")

				local var_121_29 = arg_118_1:GetWordFromCfg(106041029)
				local var_121_30 = arg_118_1:FormatText(var_121_29.content)

				arg_118_1.text_.text = var_121_30

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_31 = 17
				local var_121_32 = utf8.len(var_121_30)
				local var_121_33 = var_121_31 <= 0 and var_121_27 or var_121_27 * (var_121_32 / var_121_31)

				if var_121_33 > 0 and var_121_27 < var_121_33 then
					arg_118_1.talkMaxDuration = var_121_33

					if var_121_33 + var_121_26 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_33 + var_121_26
					end
				end

				arg_118_1.text_.text = var_121_30
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106041", "106041029", "story_v_out_106041.awb") ~= 0 then
					local var_121_34 = manager.audio:GetVoiceLength("story_v_out_106041", "106041029", "story_v_out_106041.awb") / 1000

					if var_121_34 + var_121_26 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_34 + var_121_26
					end

					if var_121_29.prefab_name ~= "" and arg_118_1.actors_[var_121_29.prefab_name] ~= nil then
						local var_121_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_118_1.actors_[var_121_29.prefab_name].transform, "story_v_out_106041", "106041029", "story_v_out_106041.awb")

						arg_118_1:RecordAudio("106041029", var_121_35)
						arg_118_1:RecordAudio("106041029", var_121_35)
					else
						arg_118_1:AudioAction("play", "voice", "story_v_out_106041", "106041029", "story_v_out_106041.awb")
					end

					arg_118_1:RecordHistoryTalkVoice("story_v_out_106041", "106041029", "story_v_out_106041.awb")
				end

				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_36 = math.max(var_121_27, arg_118_1.talkMaxDuration)

			if var_121_26 <= arg_118_1.time_ and arg_118_1.time_ < var_121_26 + var_121_36 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - var_121_26) / var_121_36

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= var_121_26 + var_121_36 and arg_118_1.time_ < var_121_26 + var_121_36 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10004ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_118_1:InitPlayNodeList()
	end,
	Play106041030 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 106041030
		arg_122_1.duration_ = 5.6

		local var_122_0 = {
			ja = 5.6,
			ko = 2.266,
			zh = 2.933,
			en = 2.5
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
				arg_122_0:Play106041031(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			local var_125_0 = arg_122_1.actors_["10004ui_story"].transform
			local var_125_1 = 0

			if var_125_1 < arg_122_1.time_ and arg_122_1.time_ <= var_125_1 + arg_125_0 then
				arg_122_1.var_.moveOldPos10004ui_story = var_125_0.localPosition
			end

			local var_125_2 = 0.001

			if var_125_1 <= arg_122_1.time_ and arg_122_1.time_ < var_125_1 + var_125_2 then
				local var_125_3 = (arg_122_1.time_ - var_125_1) / var_125_2
				local var_125_4 = Vector3.New(0, 100, 0)

				var_125_0.localPosition = Vector3.Lerp(arg_122_1.var_.moveOldPos10004ui_story, var_125_4, var_125_3)

				local var_125_5 = manager.ui.mainCamera.transform.position - var_125_0.position

				var_125_0.forward = Vector3.New(var_125_5.x, var_125_5.y, var_125_5.z)

				local var_125_6 = var_125_0.localEulerAngles

				var_125_6.z = 0
				var_125_6.x = 0
				var_125_0.localEulerAngles = var_125_6
			end

			if arg_122_1.time_ >= var_125_1 + var_125_2 and arg_122_1.time_ < var_125_1 + var_125_2 + arg_125_0 then
				var_125_0.localPosition = Vector3.New(0, 100, 0)

				local var_125_7 = manager.ui.mainCamera.transform.position - var_125_0.position

				var_125_0.forward = Vector3.New(var_125_7.x, var_125_7.y, var_125_7.z)

				local var_125_8 = var_125_0.localEulerAngles

				var_125_8.z = 0
				var_125_8.x = 0
				var_125_0.localEulerAngles = var_125_8
			end

			local var_125_9 = "10003ui_story"

			if arg_122_1.actors_[var_125_9] == nil then
				local var_125_10 = Asset.Load("Char/" .. "10003ui_story")

				if not isNil(var_125_10) then
					local var_125_11 = Object.Instantiate(Asset.Load("Char/" .. "10003ui_story"), arg_122_1.stage_.transform)

					var_125_11.name = var_125_9
					var_125_11.transform.localPosition = Vector3.New(0, 100, 0)
					arg_122_1.actors_[var_125_9] = var_125_11

					local var_125_12 = var_125_11:GetComponentInChildren(typeof(CharacterEffect))

					var_125_12.enabled = true

					local var_125_13 = GameObjectTools.GetOrAddComponent(var_125_11, typeof(DynamicBoneHelper))

					if var_125_13 then
						var_125_13:EnableDynamicBone(false)
					end

					arg_122_1:ShowWeapon(var_125_12.transform, false)

					arg_122_1.var_[var_125_9 .. "Animator"] = var_125_12.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_122_1.var_[var_125_9 .. "Animator"].applyRootMotion = true
					arg_122_1.var_[var_125_9 .. "LipSync"] = var_125_12.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_125_14 = arg_122_1.actors_["10003ui_story"].transform
			local var_125_15 = 0

			if var_125_15 < arg_122_1.time_ and arg_122_1.time_ <= var_125_15 + arg_125_0 then
				arg_122_1.var_.moveOldPos10003ui_story = var_125_14.localPosition
			end

			local var_125_16 = 0.001

			if var_125_15 <= arg_122_1.time_ and arg_122_1.time_ < var_125_15 + var_125_16 then
				local var_125_17 = (arg_122_1.time_ - var_125_15) / var_125_16
				local var_125_18 = Vector3.New(0.7, -1.05, -5.9)

				var_125_14.localPosition = Vector3.Lerp(arg_122_1.var_.moveOldPos10003ui_story, var_125_18, var_125_17)

				local var_125_19 = manager.ui.mainCamera.transform.position - var_125_14.position

				var_125_14.forward = Vector3.New(var_125_19.x, var_125_19.y, var_125_19.z)

				local var_125_20 = var_125_14.localEulerAngles

				var_125_20.z = 0
				var_125_20.x = 0
				var_125_14.localEulerAngles = var_125_20
			end

			if arg_122_1.time_ >= var_125_15 + var_125_16 and arg_122_1.time_ < var_125_15 + var_125_16 + arg_125_0 then
				var_125_14.localPosition = Vector3.New(0.7, -1.05, -5.9)

				local var_125_21 = manager.ui.mainCamera.transform.position - var_125_14.position

				var_125_14.forward = Vector3.New(var_125_21.x, var_125_21.y, var_125_21.z)

				local var_125_22 = var_125_14.localEulerAngles

				var_125_22.z = 0
				var_125_22.x = 0
				var_125_14.localEulerAngles = var_125_22
			end

			local var_125_23 = 0

			if var_125_23 < arg_122_1.time_ and arg_122_1.time_ <= var_125_23 + arg_125_0 then
				arg_122_1:PlayTimeline("10003ui_story", "StoryTimeline/CharAction/story10003/story10003action/10003action1_1")
			end

			local var_125_24 = arg_122_1.actors_["10003ui_story"]
			local var_125_25 = 0

			if var_125_25 < arg_122_1.time_ and arg_122_1.time_ <= var_125_25 + arg_125_0 and not isNil(var_125_24) and arg_122_1.var_.characterEffect10003ui_story == nil then
				arg_122_1.var_.characterEffect10003ui_story = var_125_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_125_26 = 0.1

			if var_125_25 <= arg_122_1.time_ and arg_122_1.time_ < var_125_25 + var_125_26 and not isNil(var_125_24) then
				local var_125_27 = (arg_122_1.time_ - var_125_25) / var_125_26

				if arg_122_1.var_.characterEffect10003ui_story and not isNil(var_125_24) then
					arg_122_1.var_.characterEffect10003ui_story.fillFlat = false
				end
			end

			if arg_122_1.time_ >= var_125_25 + var_125_26 and arg_122_1.time_ < var_125_25 + var_125_26 + arg_125_0 and not isNil(var_125_24) and arg_122_1.var_.characterEffect10003ui_story then
				arg_122_1.var_.characterEffect10003ui_story.fillFlat = false
			end

			local var_125_28 = 0

			if var_125_28 < arg_122_1.time_ and arg_122_1.time_ <= var_125_28 + arg_125_0 then
				arg_122_1:PlayTimeline("10003ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_125_29 = 0
			local var_125_30 = 0.2

			if var_125_29 < arg_122_1.time_ and arg_122_1.time_ <= var_125_29 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, true)

				local var_125_31 = arg_122_1:FormatText(StoryNameCfg[81].name)

				arg_122_1.leftNameTxt_.text = var_125_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_122_1.leftNameTxt_.transform)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1.leftNameTxt_.text)
				SetActive(arg_122_1.iconTrs_.gameObject, false)
				arg_122_1.callingController_:SetSelectedState("normal")

				local var_125_32 = arg_122_1:GetWordFromCfg(106041030)
				local var_125_33 = arg_122_1:FormatText(var_125_32.content)

				arg_122_1.text_.text = var_125_33

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_34 = 8
				local var_125_35 = utf8.len(var_125_33)
				local var_125_36 = var_125_34 <= 0 and var_125_30 or var_125_30 * (var_125_35 / var_125_34)

				if var_125_36 > 0 and var_125_30 < var_125_36 then
					arg_122_1.talkMaxDuration = var_125_36

					if var_125_36 + var_125_29 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_36 + var_125_29
					end
				end

				arg_122_1.text_.text = var_125_33
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106041", "106041030", "story_v_out_106041.awb") ~= 0 then
					local var_125_37 = manager.audio:GetVoiceLength("story_v_out_106041", "106041030", "story_v_out_106041.awb") / 1000

					if var_125_37 + var_125_29 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_37 + var_125_29
					end

					if var_125_32.prefab_name ~= "" and arg_122_1.actors_[var_125_32.prefab_name] ~= nil then
						local var_125_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_122_1.actors_[var_125_32.prefab_name].transform, "story_v_out_106041", "106041030", "story_v_out_106041.awb")

						arg_122_1:RecordAudio("106041030", var_125_38)
						arg_122_1:RecordAudio("106041030", var_125_38)
					else
						arg_122_1:AudioAction("play", "voice", "story_v_out_106041", "106041030", "story_v_out_106041.awb")
					end

					arg_122_1:RecordHistoryTalkVoice("story_v_out_106041", "106041030", "story_v_out_106041.awb")
				end

				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_39 = math.max(var_125_30, arg_122_1.talkMaxDuration)

			if var_125_29 <= arg_122_1.time_ and arg_122_1.time_ < var_125_29 + var_125_39 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_29) / var_125_39

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_29 + var_125_39 and arg_122_1.time_ < var_125_29 + var_125_39 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10004ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_122_1:InitPlayNodeList()
	end,
	Play106041031 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 106041031
		arg_126_1.duration_ = 7.33

		local var_126_0 = {
			ja = 6.866,
			ko = 5.3,
			zh = 7.166,
			en = 7.333
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
				arg_126_0:Play106041032(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			local var_129_0 = arg_126_1.actors_["3004_tpose"]
			local var_129_1 = 0

			if var_129_1 < arg_126_1.time_ and arg_126_1.time_ <= var_129_1 + arg_129_0 and not isNil(var_129_0) and arg_126_1.var_.characterEffect3004_tpose == nil then
				arg_126_1.var_.characterEffect3004_tpose = var_129_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_129_2 = 0.1

			if var_129_1 <= arg_126_1.time_ and arg_126_1.time_ < var_129_1 + var_129_2 and not isNil(var_129_0) then
				local var_129_3 = (arg_126_1.time_ - var_129_1) / var_129_2

				if arg_126_1.var_.characterEffect3004_tpose and not isNil(var_129_0) then
					arg_126_1.var_.characterEffect3004_tpose.fillFlat = false
				end
			end

			if arg_126_1.time_ >= var_129_1 + var_129_2 and arg_126_1.time_ < var_129_1 + var_129_2 + arg_129_0 and not isNil(var_129_0) and arg_126_1.var_.characterEffect3004_tpose then
				arg_126_1.var_.characterEffect3004_tpose.fillFlat = false
			end

			local var_129_4 = arg_126_1.actors_["10003ui_story"].transform
			local var_129_5 = 0

			if var_129_5 < arg_126_1.time_ and arg_126_1.time_ <= var_129_5 + arg_129_0 then
				arg_126_1.var_.moveOldPos10003ui_story = var_129_4.localPosition
			end

			local var_129_6 = 0.001

			if var_129_5 <= arg_126_1.time_ and arg_126_1.time_ < var_129_5 + var_129_6 then
				local var_129_7 = (arg_126_1.time_ - var_129_5) / var_129_6
				local var_129_8 = Vector3.New(0.7, -1.05, -5.9)

				var_129_4.localPosition = Vector3.Lerp(arg_126_1.var_.moveOldPos10003ui_story, var_129_8, var_129_7)

				local var_129_9 = manager.ui.mainCamera.transform.position - var_129_4.position

				var_129_4.forward = Vector3.New(var_129_9.x, var_129_9.y, var_129_9.z)

				local var_129_10 = var_129_4.localEulerAngles

				var_129_10.z = 0
				var_129_10.x = 0
				var_129_4.localEulerAngles = var_129_10
			end

			if arg_126_1.time_ >= var_129_5 + var_129_6 and arg_126_1.time_ < var_129_5 + var_129_6 + arg_129_0 then
				var_129_4.localPosition = Vector3.New(0.7, -1.05, -5.9)

				local var_129_11 = manager.ui.mainCamera.transform.position - var_129_4.position

				var_129_4.forward = Vector3.New(var_129_11.x, var_129_11.y, var_129_11.z)

				local var_129_12 = var_129_4.localEulerAngles

				var_129_12.z = 0
				var_129_12.x = 0
				var_129_4.localEulerAngles = var_129_12
			end

			local var_129_13 = arg_126_1.actors_["10003ui_story"]
			local var_129_14 = 0

			if var_129_14 < arg_126_1.time_ and arg_126_1.time_ <= var_129_14 + arg_129_0 and not isNil(var_129_13) and arg_126_1.var_.characterEffect10003ui_story == nil then
				arg_126_1.var_.characterEffect10003ui_story = var_129_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_129_15 = 0.1

			if var_129_14 <= arg_126_1.time_ and arg_126_1.time_ < var_129_14 + var_129_15 and not isNil(var_129_13) then
				local var_129_16 = (arg_126_1.time_ - var_129_14) / var_129_15

				if arg_126_1.var_.characterEffect10003ui_story and not isNil(var_129_13) then
					local var_129_17 = Mathf.Lerp(0, 0.5, var_129_16)

					arg_126_1.var_.characterEffect10003ui_story.fillFlat = true
					arg_126_1.var_.characterEffect10003ui_story.fillRatio = var_129_17
				end
			end

			if arg_126_1.time_ >= var_129_14 + var_129_15 and arg_126_1.time_ < var_129_14 + var_129_15 + arg_129_0 and not isNil(var_129_13) and arg_126_1.var_.characterEffect10003ui_story then
				local var_129_18 = 0.5

				arg_126_1.var_.characterEffect10003ui_story.fillFlat = true
				arg_126_1.var_.characterEffect10003ui_story.fillRatio = var_129_18
			end

			local var_129_19 = 0
			local var_129_20 = 0.475

			if var_129_19 < arg_126_1.time_ and arg_126_1.time_ <= var_129_19 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, true)

				local var_129_21 = arg_126_1:FormatText(StoryNameCfg[82].name)

				arg_126_1.leftNameTxt_.text = var_129_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_126_1.leftNameTxt_.transform)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1.leftNameTxt_.text)
				SetActive(arg_126_1.iconTrs_.gameObject, false)
				arg_126_1.callingController_:SetSelectedState("normal")

				local var_129_22 = arg_126_1:GetWordFromCfg(106041031)
				local var_129_23 = arg_126_1:FormatText(var_129_22.content)

				arg_126_1.text_.text = var_129_23

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_24 = 20
				local var_129_25 = utf8.len(var_129_23)
				local var_129_26 = var_129_24 <= 0 and var_129_20 or var_129_20 * (var_129_25 / var_129_24)

				if var_129_26 > 0 and var_129_20 < var_129_26 then
					arg_126_1.talkMaxDuration = var_129_26

					if var_129_26 + var_129_19 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_26 + var_129_19
					end
				end

				arg_126_1.text_.text = var_129_23
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106041", "106041031", "story_v_out_106041.awb") ~= 0 then
					local var_129_27 = manager.audio:GetVoiceLength("story_v_out_106041", "106041031", "story_v_out_106041.awb") / 1000

					if var_129_27 + var_129_19 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_27 + var_129_19
					end

					if var_129_22.prefab_name ~= "" and arg_126_1.actors_[var_129_22.prefab_name] ~= nil then
						local var_129_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_126_1.actors_[var_129_22.prefab_name].transform, "story_v_out_106041", "106041031", "story_v_out_106041.awb")

						arg_126_1:RecordAudio("106041031", var_129_28)
						arg_126_1:RecordAudio("106041031", var_129_28)
					else
						arg_126_1:AudioAction("play", "voice", "story_v_out_106041", "106041031", "story_v_out_106041.awb")
					end

					arg_126_1:RecordHistoryTalkVoice("story_v_out_106041", "106041031", "story_v_out_106041.awb")
				end

				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_29 = math.max(var_129_20, arg_126_1.talkMaxDuration)

			if var_129_19 <= arg_126_1.time_ and arg_126_1.time_ < var_129_19 + var_129_29 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - var_129_19) / var_129_29

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= var_129_19 + var_129_29 and arg_126_1.time_ < var_129_19 + var_129_29 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_126_1:InitPlayNodeList()
	end,
	Play106041032 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 106041032
		arg_130_1.duration_ = 4.17

		local var_130_0 = {
			ja = 3.166,
			ko = 1.999999999999,
			zh = 3.333,
			en = 4.166
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
				arg_130_0:Play106041033(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			local var_133_0 = arg_130_1.actors_["3004_tpose"]
			local var_133_1 = 0

			if var_133_1 < arg_130_1.time_ and arg_130_1.time_ <= var_133_1 + arg_133_0 and not isNil(var_133_0) and arg_130_1.var_.characterEffect3004_tpose == nil then
				arg_130_1.var_.characterEffect3004_tpose = var_133_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_133_2 = 0.1

			if var_133_1 <= arg_130_1.time_ and arg_130_1.time_ < var_133_1 + var_133_2 and not isNil(var_133_0) then
				local var_133_3 = (arg_130_1.time_ - var_133_1) / var_133_2

				if arg_130_1.var_.characterEffect3004_tpose and not isNil(var_133_0) then
					local var_133_4 = Mathf.Lerp(0, 0.5, var_133_3)

					arg_130_1.var_.characterEffect3004_tpose.fillFlat = true
					arg_130_1.var_.characterEffect3004_tpose.fillRatio = var_133_4
				end
			end

			if arg_130_1.time_ >= var_133_1 + var_133_2 and arg_130_1.time_ < var_133_1 + var_133_2 + arg_133_0 and not isNil(var_133_0) and arg_130_1.var_.characterEffect3004_tpose then
				local var_133_5 = 0.5

				arg_130_1.var_.characterEffect3004_tpose.fillFlat = true
				arg_130_1.var_.characterEffect3004_tpose.fillRatio = var_133_5
			end

			local var_133_6 = arg_130_1.actors_["10003ui_story"]
			local var_133_7 = 0

			if var_133_7 < arg_130_1.time_ and arg_130_1.time_ <= var_133_7 + arg_133_0 and not isNil(var_133_6) and arg_130_1.var_.characterEffect10003ui_story == nil then
				arg_130_1.var_.characterEffect10003ui_story = var_133_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_133_8 = 0.1

			if var_133_7 <= arg_130_1.time_ and arg_130_1.time_ < var_133_7 + var_133_8 and not isNil(var_133_6) then
				local var_133_9 = (arg_130_1.time_ - var_133_7) / var_133_8

				if arg_130_1.var_.characterEffect10003ui_story and not isNil(var_133_6) then
					arg_130_1.var_.characterEffect10003ui_story.fillFlat = false
				end
			end

			if arg_130_1.time_ >= var_133_7 + var_133_8 and arg_130_1.time_ < var_133_7 + var_133_8 + arg_133_0 and not isNil(var_133_6) and arg_130_1.var_.characterEffect10003ui_story then
				arg_130_1.var_.characterEffect10003ui_story.fillFlat = false
			end

			local var_133_10 = 0

			if var_133_10 < arg_130_1.time_ and arg_130_1.time_ <= var_133_10 + arg_133_0 then
				arg_130_1:PlayTimeline("10003ui_story", "StoryTimeline/CharAction/story10003/story10003action/10003action5_1")
			end

			local var_133_11 = 0

			if var_133_11 < arg_130_1.time_ and arg_130_1.time_ <= var_133_11 + arg_133_0 then
				arg_130_1:PlayTimeline("10003ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_133_12 = 0
			local var_133_13 = 0.325

			if var_133_12 < arg_130_1.time_ and arg_130_1.time_ <= var_133_12 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, true)

				local var_133_14 = arg_130_1:FormatText(StoryNameCfg[81].name)

				arg_130_1.leftNameTxt_.text = var_133_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_130_1.leftNameTxt_.transform)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1.leftNameTxt_.text)
				SetActive(arg_130_1.iconTrs_.gameObject, false)
				arg_130_1.callingController_:SetSelectedState("normal")

				local var_133_15 = arg_130_1:GetWordFromCfg(106041032)
				local var_133_16 = arg_130_1:FormatText(var_133_15.content)

				arg_130_1.text_.text = var_133_16

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_17 = 13
				local var_133_18 = utf8.len(var_133_16)
				local var_133_19 = var_133_17 <= 0 and var_133_13 or var_133_13 * (var_133_18 / var_133_17)

				if var_133_19 > 0 and var_133_13 < var_133_19 then
					arg_130_1.talkMaxDuration = var_133_19

					if var_133_19 + var_133_12 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_19 + var_133_12
					end
				end

				arg_130_1.text_.text = var_133_16
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106041", "106041032", "story_v_out_106041.awb") ~= 0 then
					local var_133_20 = manager.audio:GetVoiceLength("story_v_out_106041", "106041032", "story_v_out_106041.awb") / 1000

					if var_133_20 + var_133_12 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_20 + var_133_12
					end

					if var_133_15.prefab_name ~= "" and arg_130_1.actors_[var_133_15.prefab_name] ~= nil then
						local var_133_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_130_1.actors_[var_133_15.prefab_name].transform, "story_v_out_106041", "106041032", "story_v_out_106041.awb")

						arg_130_1:RecordAudio("106041032", var_133_21)
						arg_130_1:RecordAudio("106041032", var_133_21)
					else
						arg_130_1:AudioAction("play", "voice", "story_v_out_106041", "106041032", "story_v_out_106041.awb")
					end

					arg_130_1:RecordHistoryTalkVoice("story_v_out_106041", "106041032", "story_v_out_106041.awb")
				end

				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_22 = math.max(var_133_13, arg_130_1.talkMaxDuration)

			if var_133_12 <= arg_130_1.time_ and arg_130_1.time_ < var_133_12 + var_133_22 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - var_133_12) / var_133_22

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= var_133_12 + var_133_22 and arg_130_1.time_ < var_133_12 + var_133_22 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {}

		arg_130_1:InitPlayNodeList()
	end,
	Play106041033 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 106041033
		arg_134_1.duration_ = 12.2

		local var_134_0 = {
			ja = 12.2,
			ko = 7.233,
			zh = 10.433,
			en = 9.133
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
				arg_134_0:Play106041034(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			local var_137_0 = arg_134_1.actors_["3004_tpose"]
			local var_137_1 = 0

			if var_137_1 < arg_134_1.time_ and arg_134_1.time_ <= var_137_1 + arg_137_0 and not isNil(var_137_0) and arg_134_1.var_.characterEffect3004_tpose == nil then
				arg_134_1.var_.characterEffect3004_tpose = var_137_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_137_2 = 0.1

			if var_137_1 <= arg_134_1.time_ and arg_134_1.time_ < var_137_1 + var_137_2 and not isNil(var_137_0) then
				local var_137_3 = (arg_134_1.time_ - var_137_1) / var_137_2

				if arg_134_1.var_.characterEffect3004_tpose and not isNil(var_137_0) then
					arg_134_1.var_.characterEffect3004_tpose.fillFlat = false
				end
			end

			if arg_134_1.time_ >= var_137_1 + var_137_2 and arg_134_1.time_ < var_137_1 + var_137_2 + arg_137_0 and not isNil(var_137_0) and arg_134_1.var_.characterEffect3004_tpose then
				arg_134_1.var_.characterEffect3004_tpose.fillFlat = false
			end

			local var_137_4 = arg_134_1.actors_["10003ui_story"]
			local var_137_5 = 0

			if var_137_5 < arg_134_1.time_ and arg_134_1.time_ <= var_137_5 + arg_137_0 and not isNil(var_137_4) and arg_134_1.var_.characterEffect10003ui_story == nil then
				arg_134_1.var_.characterEffect10003ui_story = var_137_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_137_6 = 0.1

			if var_137_5 <= arg_134_1.time_ and arg_134_1.time_ < var_137_5 + var_137_6 and not isNil(var_137_4) then
				local var_137_7 = (arg_134_1.time_ - var_137_5) / var_137_6

				if arg_134_1.var_.characterEffect10003ui_story and not isNil(var_137_4) then
					local var_137_8 = Mathf.Lerp(0, 0.5, var_137_7)

					arg_134_1.var_.characterEffect10003ui_story.fillFlat = true
					arg_134_1.var_.characterEffect10003ui_story.fillRatio = var_137_8
				end
			end

			if arg_134_1.time_ >= var_137_5 + var_137_6 and arg_134_1.time_ < var_137_5 + var_137_6 + arg_137_0 and not isNil(var_137_4) and arg_134_1.var_.characterEffect10003ui_story then
				local var_137_9 = 0.5

				arg_134_1.var_.characterEffect10003ui_story.fillFlat = true
				arg_134_1.var_.characterEffect10003ui_story.fillRatio = var_137_9
			end

			local var_137_10 = 0
			local var_137_11 = 0.85

			if var_137_10 < arg_134_1.time_ and arg_134_1.time_ <= var_137_10 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, true)

				local var_137_12 = arg_134_1:FormatText(StoryNameCfg[82].name)

				arg_134_1.leftNameTxt_.text = var_137_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_134_1.leftNameTxt_.transform)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1.leftNameTxt_.text)
				SetActive(arg_134_1.iconTrs_.gameObject, false)
				arg_134_1.callingController_:SetSelectedState("normal")

				local var_137_13 = arg_134_1:GetWordFromCfg(106041033)
				local var_137_14 = arg_134_1:FormatText(var_137_13.content)

				arg_134_1.text_.text = var_137_14

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_15 = 34
				local var_137_16 = utf8.len(var_137_14)
				local var_137_17 = var_137_15 <= 0 and var_137_11 or var_137_11 * (var_137_16 / var_137_15)

				if var_137_17 > 0 and var_137_11 < var_137_17 then
					arg_134_1.talkMaxDuration = var_137_17

					if var_137_17 + var_137_10 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_17 + var_137_10
					end
				end

				arg_134_1.text_.text = var_137_14
				arg_134_1.typewritter.percent = 0

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106041", "106041033", "story_v_out_106041.awb") ~= 0 then
					local var_137_18 = manager.audio:GetVoiceLength("story_v_out_106041", "106041033", "story_v_out_106041.awb") / 1000

					if var_137_18 + var_137_10 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_18 + var_137_10
					end

					if var_137_13.prefab_name ~= "" and arg_134_1.actors_[var_137_13.prefab_name] ~= nil then
						local var_137_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_134_1.actors_[var_137_13.prefab_name].transform, "story_v_out_106041", "106041033", "story_v_out_106041.awb")

						arg_134_1:RecordAudio("106041033", var_137_19)
						arg_134_1:RecordAudio("106041033", var_137_19)
					else
						arg_134_1:AudioAction("play", "voice", "story_v_out_106041", "106041033", "story_v_out_106041.awb")
					end

					arg_134_1:RecordHistoryTalkVoice("story_v_out_106041", "106041033", "story_v_out_106041.awb")
				end

				arg_134_1:RecordContent(arg_134_1.text_.text)
			end

			local var_137_20 = math.max(var_137_11, arg_134_1.talkMaxDuration)

			if var_137_10 <= arg_134_1.time_ and arg_134_1.time_ < var_137_10 + var_137_20 then
				arg_134_1.typewritter.percent = (arg_134_1.time_ - var_137_10) / var_137_20

				arg_134_1.typewritter:SetDirty()
			end

			if arg_134_1.time_ >= var_137_10 + var_137_20 and arg_134_1.time_ < var_137_10 + var_137_20 + arg_137_0 then
				arg_134_1.typewritter.percent = 1

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(true)
			end
		end

		arg_134_1.nodeConfigList_ = {}

		arg_134_1:InitPlayNodeList()
	end,
	Play106041034 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 106041034
		arg_138_1.duration_ = 2.1

		local var_138_0 = {
			ja = 1.999999999999,
			ko = 1.999999999999,
			zh = 2.1,
			en = 1.999999999999
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
				arg_138_0:Play106041035(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			local var_141_0 = arg_138_1.actors_["3004_tpose"]
			local var_141_1 = 0

			if var_141_1 < arg_138_1.time_ and arg_138_1.time_ <= var_141_1 + arg_141_0 and not isNil(var_141_0) and arg_138_1.var_.characterEffect3004_tpose == nil then
				arg_138_1.var_.characterEffect3004_tpose = var_141_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_141_2 = 0.1

			if var_141_1 <= arg_138_1.time_ and arg_138_1.time_ < var_141_1 + var_141_2 and not isNil(var_141_0) then
				local var_141_3 = (arg_138_1.time_ - var_141_1) / var_141_2

				if arg_138_1.var_.characterEffect3004_tpose and not isNil(var_141_0) then
					local var_141_4 = Mathf.Lerp(0, 0.5, var_141_3)

					arg_138_1.var_.characterEffect3004_tpose.fillFlat = true
					arg_138_1.var_.characterEffect3004_tpose.fillRatio = var_141_4
				end
			end

			if arg_138_1.time_ >= var_141_1 + var_141_2 and arg_138_1.time_ < var_141_1 + var_141_2 + arg_141_0 and not isNil(var_141_0) and arg_138_1.var_.characterEffect3004_tpose then
				local var_141_5 = 0.5

				arg_138_1.var_.characterEffect3004_tpose.fillFlat = true
				arg_138_1.var_.characterEffect3004_tpose.fillRatio = var_141_5
			end

			local var_141_6 = arg_138_1.actors_["10003ui_story"]
			local var_141_7 = 0

			if var_141_7 < arg_138_1.time_ and arg_138_1.time_ <= var_141_7 + arg_141_0 and not isNil(var_141_6) and arg_138_1.var_.characterEffect10003ui_story == nil then
				arg_138_1.var_.characterEffect10003ui_story = var_141_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_141_8 = 0.1

			if var_141_7 <= arg_138_1.time_ and arg_138_1.time_ < var_141_7 + var_141_8 and not isNil(var_141_6) then
				local var_141_9 = (arg_138_1.time_ - var_141_7) / var_141_8

				if arg_138_1.var_.characterEffect10003ui_story and not isNil(var_141_6) then
					arg_138_1.var_.characterEffect10003ui_story.fillFlat = false
				end
			end

			if arg_138_1.time_ >= var_141_7 + var_141_8 and arg_138_1.time_ < var_141_7 + var_141_8 + arg_141_0 and not isNil(var_141_6) and arg_138_1.var_.characterEffect10003ui_story then
				arg_138_1.var_.characterEffect10003ui_story.fillFlat = false
			end

			local var_141_10 = 0

			if var_141_10 < arg_138_1.time_ and arg_138_1.time_ <= var_141_10 + arg_141_0 then
				arg_138_1:PlayTimeline("10003ui_story", "StoryTimeline/CharAction/story10003/story10003actionlink/10003action453")
			end

			local var_141_11 = 0

			if var_141_11 < arg_138_1.time_ and arg_138_1.time_ <= var_141_11 + arg_141_0 then
				arg_138_1:PlayTimeline("10003ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_141_12 = 0
			local var_141_13 = 0.125

			if var_141_12 < arg_138_1.time_ and arg_138_1.time_ <= var_141_12 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, true)

				local var_141_14 = arg_138_1:FormatText(StoryNameCfg[81].name)

				arg_138_1.leftNameTxt_.text = var_141_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_138_1.leftNameTxt_.transform)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1.leftNameTxt_.text)
				SetActive(arg_138_1.iconTrs_.gameObject, false)
				arg_138_1.callingController_:SetSelectedState("normal")

				local var_141_15 = arg_138_1:GetWordFromCfg(106041034)
				local var_141_16 = arg_138_1:FormatText(var_141_15.content)

				arg_138_1.text_.text = var_141_16

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_17 = 5
				local var_141_18 = utf8.len(var_141_16)
				local var_141_19 = var_141_17 <= 0 and var_141_13 or var_141_13 * (var_141_18 / var_141_17)

				if var_141_19 > 0 and var_141_13 < var_141_19 then
					arg_138_1.talkMaxDuration = var_141_19

					if var_141_19 + var_141_12 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_19 + var_141_12
					end
				end

				arg_138_1.text_.text = var_141_16
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106041", "106041034", "story_v_out_106041.awb") ~= 0 then
					local var_141_20 = manager.audio:GetVoiceLength("story_v_out_106041", "106041034", "story_v_out_106041.awb") / 1000

					if var_141_20 + var_141_12 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_20 + var_141_12
					end

					if var_141_15.prefab_name ~= "" and arg_138_1.actors_[var_141_15.prefab_name] ~= nil then
						local var_141_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_138_1.actors_[var_141_15.prefab_name].transform, "story_v_out_106041", "106041034", "story_v_out_106041.awb")

						arg_138_1:RecordAudio("106041034", var_141_21)
						arg_138_1:RecordAudio("106041034", var_141_21)
					else
						arg_138_1:AudioAction("play", "voice", "story_v_out_106041", "106041034", "story_v_out_106041.awb")
					end

					arg_138_1:RecordHistoryTalkVoice("story_v_out_106041", "106041034", "story_v_out_106041.awb")
				end

				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_22 = math.max(var_141_13, arg_138_1.talkMaxDuration)

			if var_141_12 <= arg_138_1.time_ and arg_138_1.time_ < var_141_12 + var_141_22 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - var_141_12) / var_141_22

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= var_141_12 + var_141_22 and arg_138_1.time_ < var_141_12 + var_141_22 + arg_141_0 then
				arg_138_1.typewritter.percent = 1

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(true)
			end
		end

		arg_138_1.nodeConfigList_ = {}

		arg_138_1:InitPlayNodeList()
	end,
	Play106041035 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 106041035
		arg_142_1.duration_ = 5.37

		local var_142_0 = {
			ja = 4.5,
			ko = 3.5,
			zh = 5.366,
			en = 4.433
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
				arg_142_0:Play106041036(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			local var_145_0 = arg_142_1.actors_["10004ui_story"]
			local var_145_1 = 0

			if var_145_1 < arg_142_1.time_ and arg_142_1.time_ <= var_145_1 + arg_145_0 and not isNil(var_145_0) and arg_142_1.var_.characterEffect10004ui_story == nil then
				arg_142_1.var_.characterEffect10004ui_story = var_145_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_145_2 = 0.1

			if var_145_1 <= arg_142_1.time_ and arg_142_1.time_ < var_145_1 + var_145_2 and not isNil(var_145_0) then
				local var_145_3 = (arg_142_1.time_ - var_145_1) / var_145_2

				if arg_142_1.var_.characterEffect10004ui_story and not isNil(var_145_0) then
					arg_142_1.var_.characterEffect10004ui_story.fillFlat = false
				end
			end

			if arg_142_1.time_ >= var_145_1 + var_145_2 and arg_142_1.time_ < var_145_1 + var_145_2 + arg_145_0 and not isNil(var_145_0) and arg_142_1.var_.characterEffect10004ui_story then
				arg_142_1.var_.characterEffect10004ui_story.fillFlat = false
			end

			local var_145_4 = arg_142_1.actors_["10003ui_story"]
			local var_145_5 = 0

			if var_145_5 < arg_142_1.time_ and arg_142_1.time_ <= var_145_5 + arg_145_0 and not isNil(var_145_4) and arg_142_1.var_.characterEffect10003ui_story == nil then
				arg_142_1.var_.characterEffect10003ui_story = var_145_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_145_6 = 0.1

			if var_145_5 <= arg_142_1.time_ and arg_142_1.time_ < var_145_5 + var_145_6 and not isNil(var_145_4) then
				local var_145_7 = (arg_142_1.time_ - var_145_5) / var_145_6

				if arg_142_1.var_.characterEffect10003ui_story and not isNil(var_145_4) then
					local var_145_8 = Mathf.Lerp(0, 0.5, var_145_7)

					arg_142_1.var_.characterEffect10003ui_story.fillFlat = true
					arg_142_1.var_.characterEffect10003ui_story.fillRatio = var_145_8
				end
			end

			if arg_142_1.time_ >= var_145_5 + var_145_6 and arg_142_1.time_ < var_145_5 + var_145_6 + arg_145_0 and not isNil(var_145_4) and arg_142_1.var_.characterEffect10003ui_story then
				local var_145_9 = 0.5

				arg_142_1.var_.characterEffect10003ui_story.fillFlat = true
				arg_142_1.var_.characterEffect10003ui_story.fillRatio = var_145_9
			end

			local var_145_10 = 0

			if var_145_10 < arg_142_1.time_ and arg_142_1.time_ <= var_145_10 + arg_145_0 then
				arg_142_1:PlayTimeline("10004ui_story", "StoryTimeline/CharAction/story10004/story10004action/10004action5_1")
			end

			local var_145_11 = arg_142_1.actors_["10004ui_story"].transform
			local var_145_12 = 0

			if var_145_12 < arg_142_1.time_ and arg_142_1.time_ <= var_145_12 + arg_145_0 then
				arg_142_1.var_.moveOldPos10004ui_story = var_145_11.localPosition
			end

			local var_145_13 = 0.001

			if var_145_12 <= arg_142_1.time_ and arg_142_1.time_ < var_145_12 + var_145_13 then
				local var_145_14 = (arg_142_1.time_ - var_145_12) / var_145_13
				local var_145_15 = Vector3.New(-0.7, -1.1, -5.6)

				var_145_11.localPosition = Vector3.Lerp(arg_142_1.var_.moveOldPos10004ui_story, var_145_15, var_145_14)

				local var_145_16 = manager.ui.mainCamera.transform.position - var_145_11.position

				var_145_11.forward = Vector3.New(var_145_16.x, var_145_16.y, var_145_16.z)

				local var_145_17 = var_145_11.localEulerAngles

				var_145_17.z = 0
				var_145_17.x = 0
				var_145_11.localEulerAngles = var_145_17
			end

			if arg_142_1.time_ >= var_145_12 + var_145_13 and arg_142_1.time_ < var_145_12 + var_145_13 + arg_145_0 then
				var_145_11.localPosition = Vector3.New(-0.7, -1.1, -5.6)

				local var_145_18 = manager.ui.mainCamera.transform.position - var_145_11.position

				var_145_11.forward = Vector3.New(var_145_18.x, var_145_18.y, var_145_18.z)

				local var_145_19 = var_145_11.localEulerAngles

				var_145_19.z = 0
				var_145_19.x = 0
				var_145_11.localEulerAngles = var_145_19
			end

			local var_145_20 = arg_142_1.actors_["3004_tpose"].transform
			local var_145_21 = 0

			if var_145_21 < arg_142_1.time_ and arg_142_1.time_ <= var_145_21 + arg_145_0 then
				arg_142_1.var_.moveOldPos3004_tpose = var_145_20.localPosition

				local var_145_22 = GameObjectTools.GetOrAddComponent(var_145_20.gameObject, typeof(DynamicBoneHelper))

				if var_145_22 then
					var_145_22:EnableDynamicBone(false)
				end
			end

			local var_145_23 = 0.001

			if var_145_21 <= arg_142_1.time_ and arg_142_1.time_ < var_145_21 + var_145_23 then
				local var_145_24 = (arg_142_1.time_ - var_145_21) / var_145_23
				local var_145_25 = Vector3.New(0, 100, 0)

				var_145_20.localPosition = Vector3.Lerp(arg_142_1.var_.moveOldPos3004_tpose, var_145_25, var_145_24)

				local var_145_26 = manager.ui.mainCamera.transform.position - var_145_20.position

				var_145_20.forward = Vector3.New(var_145_26.x, var_145_26.y, var_145_26.z)

				local var_145_27 = var_145_20.localEulerAngles

				var_145_27.z = 0
				var_145_27.x = 0
				var_145_20.localEulerAngles = var_145_27
			end

			if arg_142_1.time_ >= var_145_21 + var_145_23 and arg_142_1.time_ < var_145_21 + var_145_23 + arg_145_0 then
				var_145_20.localPosition = Vector3.New(0, 100, 0)

				local var_145_28 = manager.ui.mainCamera.transform.position - var_145_20.position

				var_145_20.forward = Vector3.New(var_145_28.x, var_145_28.y, var_145_28.z)

				local var_145_29 = var_145_20.localEulerAngles

				var_145_29.z = 0
				var_145_29.x = 0
				var_145_20.localEulerAngles = var_145_29

				local var_145_30 = GameObjectTools.GetOrAddComponent(var_145_20.gameObject, typeof(DynamicBoneHelper))

				if var_145_30 then
					var_145_30:EnableDynamicBone(true)
				end
			end

			local var_145_31 = 0

			if var_145_31 < arg_142_1.time_ and arg_142_1.time_ <= var_145_31 + arg_145_0 then
				arg_142_1:PlayTimeline("10004ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_145_32 = 0

			if var_145_32 < arg_142_1.time_ and arg_142_1.time_ <= var_145_32 + arg_145_0 then
				arg_142_1:PlayTimeline("10003ui_story", "StoryTimeline/CharAction/story10003/story10003action/10003action3_2")
			end

			local var_145_33 = 0
			local var_145_34 = 0.3

			if var_145_33 < arg_142_1.time_ and arg_142_1.time_ <= var_145_33 + arg_145_0 then
				arg_142_1.talkMaxDuration = 0
				arg_142_1.dialogCg_.alpha = 1

				arg_142_1.dialog_:SetActive(true)
				SetActive(arg_142_1.leftNameGo_, true)

				local var_145_35 = arg_142_1:FormatText(StoryNameCfg[80].name)

				arg_142_1.leftNameTxt_.text = var_145_35

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_142_1.leftNameTxt_.transform)

				arg_142_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_142_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_142_1:RecordName(arg_142_1.leftNameTxt_.text)
				SetActive(arg_142_1.iconTrs_.gameObject, false)
				arg_142_1.callingController_:SetSelectedState("normal")

				local var_145_36 = arg_142_1:GetWordFromCfg(106041035)
				local var_145_37 = arg_142_1:FormatText(var_145_36.content)

				arg_142_1.text_.text = var_145_37

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_38 = 12
				local var_145_39 = utf8.len(var_145_37)
				local var_145_40 = var_145_38 <= 0 and var_145_34 or var_145_34 * (var_145_39 / var_145_38)

				if var_145_40 > 0 and var_145_34 < var_145_40 then
					arg_142_1.talkMaxDuration = var_145_40

					if var_145_40 + var_145_33 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_40 + var_145_33
					end
				end

				arg_142_1.text_.text = var_145_37
				arg_142_1.typewritter.percent = 0

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106041", "106041035", "story_v_out_106041.awb") ~= 0 then
					local var_145_41 = manager.audio:GetVoiceLength("story_v_out_106041", "106041035", "story_v_out_106041.awb") / 1000

					if var_145_41 + var_145_33 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_41 + var_145_33
					end

					if var_145_36.prefab_name ~= "" and arg_142_1.actors_[var_145_36.prefab_name] ~= nil then
						local var_145_42 = LuaForUtil.PlayVoiceWithCriLipsync(arg_142_1.actors_[var_145_36.prefab_name].transform, "story_v_out_106041", "106041035", "story_v_out_106041.awb")

						arg_142_1:RecordAudio("106041035", var_145_42)
						arg_142_1:RecordAudio("106041035", var_145_42)
					else
						arg_142_1:AudioAction("play", "voice", "story_v_out_106041", "106041035", "story_v_out_106041.awb")
					end

					arg_142_1:RecordHistoryTalkVoice("story_v_out_106041", "106041035", "story_v_out_106041.awb")
				end

				arg_142_1:RecordContent(arg_142_1.text_.text)
			end

			local var_145_43 = math.max(var_145_34, arg_142_1.talkMaxDuration)

			if var_145_33 <= arg_142_1.time_ and arg_142_1.time_ < var_145_33 + var_145_43 then
				arg_142_1.typewritter.percent = (arg_142_1.time_ - var_145_33) / var_145_43

				arg_142_1.typewritter:SetDirty()
			end

			if arg_142_1.time_ >= var_145_33 + var_145_43 and arg_142_1.time_ < var_145_33 + var_145_43 + arg_145_0 then
				arg_142_1.typewritter.percent = 1

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(true)
			end
		end

		arg_142_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10004ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "3004_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_142_1:InitPlayNodeList()
	end,
	Play106041036 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 106041036
		arg_146_1.duration_ = 7.93

		local var_146_0 = {
			ja = 6.533,
			ko = 6.666,
			zh = 7.933,
			en = 7.066
		}
		local var_146_1 = manager.audio:GetLocalizationFlag()

		if var_146_0[var_146_1] ~= nil then
			arg_146_1.duration_ = var_146_0[var_146_1]
		end

		SetActive(arg_146_1.tipsGo_, false)

		function arg_146_1.onSingleLineFinish_()
			arg_146_1.onSingleLineUpdate_ = nil
			arg_146_1.onSingleLineFinish_ = nil
			arg_146_1.state_ = "waiting"
		end

		function arg_146_1.playNext_(arg_148_0)
			if arg_148_0 == 1 then
				arg_146_0:Play106041037(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			local var_149_0 = 0

			if var_149_0 < arg_146_1.time_ and arg_146_1.time_ <= var_149_0 + arg_149_0 then
				arg_146_1:PlayTimeline("10004ui_story", "StoryTimeline/CharAction/story10004/story10004action/10004action5_2")
			end

			local var_149_1 = 0

			if var_149_1 < arg_146_1.time_ and arg_146_1.time_ <= var_149_1 + arg_149_0 then
				arg_146_1:PlayTimeline("10004ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_149_2 = 0
			local var_149_3 = 0.775

			if var_149_2 < arg_146_1.time_ and arg_146_1.time_ <= var_149_2 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0
				arg_146_1.dialogCg_.alpha = 1

				arg_146_1.dialog_:SetActive(true)
				SetActive(arg_146_1.leftNameGo_, true)

				local var_149_4 = arg_146_1:FormatText(StoryNameCfg[80].name)

				arg_146_1.leftNameTxt_.text = var_149_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_146_1.leftNameTxt_.transform)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1.leftNameTxt_.text)
				SetActive(arg_146_1.iconTrs_.gameObject, false)
				arg_146_1.callingController_:SetSelectedState("normal")

				local var_149_5 = arg_146_1:GetWordFromCfg(106041036)
				local var_149_6 = arg_146_1:FormatText(var_149_5.content)

				arg_146_1.text_.text = var_149_6

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_7 = 31
				local var_149_8 = utf8.len(var_149_6)
				local var_149_9 = var_149_7 <= 0 and var_149_3 or var_149_3 * (var_149_8 / var_149_7)

				if var_149_9 > 0 and var_149_3 < var_149_9 then
					arg_146_1.talkMaxDuration = var_149_9

					if var_149_9 + var_149_2 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_9 + var_149_2
					end
				end

				arg_146_1.text_.text = var_149_6
				arg_146_1.typewritter.percent = 0

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106041", "106041036", "story_v_out_106041.awb") ~= 0 then
					local var_149_10 = manager.audio:GetVoiceLength("story_v_out_106041", "106041036", "story_v_out_106041.awb") / 1000

					if var_149_10 + var_149_2 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_10 + var_149_2
					end

					if var_149_5.prefab_name ~= "" and arg_146_1.actors_[var_149_5.prefab_name] ~= nil then
						local var_149_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_146_1.actors_[var_149_5.prefab_name].transform, "story_v_out_106041", "106041036", "story_v_out_106041.awb")

						arg_146_1:RecordAudio("106041036", var_149_11)
						arg_146_1:RecordAudio("106041036", var_149_11)
					else
						arg_146_1:AudioAction("play", "voice", "story_v_out_106041", "106041036", "story_v_out_106041.awb")
					end

					arg_146_1:RecordHistoryTalkVoice("story_v_out_106041", "106041036", "story_v_out_106041.awb")
				end

				arg_146_1:RecordContent(arg_146_1.text_.text)
			end

			local var_149_12 = math.max(var_149_3, arg_146_1.talkMaxDuration)

			if var_149_2 <= arg_146_1.time_ and arg_146_1.time_ < var_149_2 + var_149_12 then
				arg_146_1.typewritter.percent = (arg_146_1.time_ - var_149_2) / var_149_12

				arg_146_1.typewritter:SetDirty()
			end

			if arg_146_1.time_ >= var_149_2 + var_149_12 and arg_146_1.time_ < var_149_2 + var_149_12 + arg_149_0 then
				arg_146_1.typewritter.percent = 1

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(true)
			end
		end

		arg_146_1.nodeConfigList_ = {}

		arg_146_1:InitPlayNodeList()
	end,
	Play106041037 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 106041037
		arg_150_1.duration_ = 11.47

		local var_150_0 = {
			ja = 10.9,
			ko = 7.633,
			zh = 11.466,
			en = 11.433
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
				arg_150_0:Play106041038(arg_150_1)
			end
		end

		function arg_150_1.onSingleLineUpdate_(arg_153_0)
			local var_153_0 = 0

			if var_153_0 < arg_150_1.time_ and arg_150_1.time_ <= var_153_0 + arg_153_0 then
				arg_150_1:PlayTimeline("10004ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_153_1 = 0
			local var_153_2 = 1.125

			if var_153_1 < arg_150_1.time_ and arg_150_1.time_ <= var_153_1 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0
				arg_150_1.dialogCg_.alpha = 1

				arg_150_1.dialog_:SetActive(true)
				SetActive(arg_150_1.leftNameGo_, true)

				local var_153_3 = arg_150_1:FormatText(StoryNameCfg[80].name)

				arg_150_1.leftNameTxt_.text = var_153_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_150_1.leftNameTxt_.transform)

				arg_150_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_150_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_150_1:RecordName(arg_150_1.leftNameTxt_.text)
				SetActive(arg_150_1.iconTrs_.gameObject, false)
				arg_150_1.callingController_:SetSelectedState("normal")

				local var_153_4 = arg_150_1:GetWordFromCfg(106041037)
				local var_153_5 = arg_150_1:FormatText(var_153_4.content)

				arg_150_1.text_.text = var_153_5

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_6 = 45
				local var_153_7 = utf8.len(var_153_5)
				local var_153_8 = var_153_6 <= 0 and var_153_2 or var_153_2 * (var_153_7 / var_153_6)

				if var_153_8 > 0 and var_153_2 < var_153_8 then
					arg_150_1.talkMaxDuration = var_153_8

					if var_153_8 + var_153_1 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_8 + var_153_1
					end
				end

				arg_150_1.text_.text = var_153_5
				arg_150_1.typewritter.percent = 0

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106041", "106041037", "story_v_out_106041.awb") ~= 0 then
					local var_153_9 = manager.audio:GetVoiceLength("story_v_out_106041", "106041037", "story_v_out_106041.awb") / 1000

					if var_153_9 + var_153_1 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_9 + var_153_1
					end

					if var_153_4.prefab_name ~= "" and arg_150_1.actors_[var_153_4.prefab_name] ~= nil then
						local var_153_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_150_1.actors_[var_153_4.prefab_name].transform, "story_v_out_106041", "106041037", "story_v_out_106041.awb")

						arg_150_1:RecordAudio("106041037", var_153_10)
						arg_150_1:RecordAudio("106041037", var_153_10)
					else
						arg_150_1:AudioAction("play", "voice", "story_v_out_106041", "106041037", "story_v_out_106041.awb")
					end

					arg_150_1:RecordHistoryTalkVoice("story_v_out_106041", "106041037", "story_v_out_106041.awb")
				end

				arg_150_1:RecordContent(arg_150_1.text_.text)
			end

			local var_153_11 = math.max(var_153_2, arg_150_1.talkMaxDuration)

			if var_153_1 <= arg_150_1.time_ and arg_150_1.time_ < var_153_1 + var_153_11 then
				arg_150_1.typewritter.percent = (arg_150_1.time_ - var_153_1) / var_153_11

				arg_150_1.typewritter:SetDirty()
			end

			if arg_150_1.time_ >= var_153_1 + var_153_11 and arg_150_1.time_ < var_153_1 + var_153_11 + arg_153_0 then
				arg_150_1.typewritter.percent = 1

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(true)
			end
		end

		arg_150_1.nodeConfigList_ = {}

		arg_150_1:InitPlayNodeList()
	end,
	Play106041038 = function(arg_154_0, arg_154_1)
		arg_154_1.time_ = 0
		arg_154_1.frameCnt_ = 0
		arg_154_1.state_ = "playing"
		arg_154_1.curTalkId_ = 106041038
		arg_154_1.duration_ = 8.03

		local var_154_0 = {
			ja = 8.033,
			ko = 2.933,
			zh = 5.433,
			en = 5.033
		}
		local var_154_1 = manager.audio:GetLocalizationFlag()

		if var_154_0[var_154_1] ~= nil then
			arg_154_1.duration_ = var_154_0[var_154_1]
		end

		SetActive(arg_154_1.tipsGo_, false)

		function arg_154_1.onSingleLineFinish_()
			arg_154_1.onSingleLineUpdate_ = nil
			arg_154_1.onSingleLineFinish_ = nil
			arg_154_1.state_ = "waiting"
		end

		function arg_154_1.playNext_(arg_156_0)
			if arg_156_0 == 1 then
				arg_154_0:Play106041039(arg_154_1)
			end
		end

		function arg_154_1.onSingleLineUpdate_(arg_157_0)
			local var_157_0 = 0

			if var_157_0 < arg_154_1.time_ and arg_154_1.time_ <= var_157_0 + arg_157_0 then
				arg_154_1:PlayTimeline("10004ui_story", "StoryTimeline/CharAction/story10004/story10004action/10004action3_1")
			end

			local var_157_1 = 0

			if var_157_1 < arg_154_1.time_ and arg_154_1.time_ <= var_157_1 + arg_157_0 then
				arg_154_1:PlayTimeline("10004ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_157_2 = 0
			local var_157_3 = 0.45

			if var_157_2 < arg_154_1.time_ and arg_154_1.time_ <= var_157_2 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0
				arg_154_1.dialogCg_.alpha = 1

				arg_154_1.dialog_:SetActive(true)
				SetActive(arg_154_1.leftNameGo_, true)

				local var_157_4 = arg_154_1:FormatText(StoryNameCfg[80].name)

				arg_154_1.leftNameTxt_.text = var_157_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_154_1.leftNameTxt_.transform)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1.leftNameTxt_.text)
				SetActive(arg_154_1.iconTrs_.gameObject, false)
				arg_154_1.callingController_:SetSelectedState("normal")

				local var_157_5 = arg_154_1:GetWordFromCfg(106041038)
				local var_157_6 = arg_154_1:FormatText(var_157_5.content)

				arg_154_1.text_.text = var_157_6

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_7 = 19
				local var_157_8 = utf8.len(var_157_6)
				local var_157_9 = var_157_7 <= 0 and var_157_3 or var_157_3 * (var_157_8 / var_157_7)

				if var_157_9 > 0 and var_157_3 < var_157_9 then
					arg_154_1.talkMaxDuration = var_157_9

					if var_157_9 + var_157_2 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_9 + var_157_2
					end
				end

				arg_154_1.text_.text = var_157_6
				arg_154_1.typewritter.percent = 0

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106041", "106041038", "story_v_out_106041.awb") ~= 0 then
					local var_157_10 = manager.audio:GetVoiceLength("story_v_out_106041", "106041038", "story_v_out_106041.awb") / 1000

					if var_157_10 + var_157_2 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_10 + var_157_2
					end

					if var_157_5.prefab_name ~= "" and arg_154_1.actors_[var_157_5.prefab_name] ~= nil then
						local var_157_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_154_1.actors_[var_157_5.prefab_name].transform, "story_v_out_106041", "106041038", "story_v_out_106041.awb")

						arg_154_1:RecordAudio("106041038", var_157_11)
						arg_154_1:RecordAudio("106041038", var_157_11)
					else
						arg_154_1:AudioAction("play", "voice", "story_v_out_106041", "106041038", "story_v_out_106041.awb")
					end

					arg_154_1:RecordHistoryTalkVoice("story_v_out_106041", "106041038", "story_v_out_106041.awb")
				end

				arg_154_1:RecordContent(arg_154_1.text_.text)
			end

			local var_157_12 = math.max(var_157_3, arg_154_1.talkMaxDuration)

			if var_157_2 <= arg_154_1.time_ and arg_154_1.time_ < var_157_2 + var_157_12 then
				arg_154_1.typewritter.percent = (arg_154_1.time_ - var_157_2) / var_157_12

				arg_154_1.typewritter:SetDirty()
			end

			if arg_154_1.time_ >= var_157_2 + var_157_12 and arg_154_1.time_ < var_157_2 + var_157_12 + arg_157_0 then
				arg_154_1.typewritter.percent = 1

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(true)
			end
		end

		arg_154_1.nodeConfigList_ = {}

		arg_154_1:InitPlayNodeList()
	end,
	Play106041039 = function(arg_158_0, arg_158_1)
		arg_158_1.time_ = 0
		arg_158_1.frameCnt_ = 0
		arg_158_1.state_ = "playing"
		arg_158_1.curTalkId_ = 106041039
		arg_158_1.duration_ = 6.07

		local var_158_0 = {
			ja = 6.066,
			ko = 5.1,
			zh = 5.1,
			en = 5.3
		}
		local var_158_1 = manager.audio:GetLocalizationFlag()

		if var_158_0[var_158_1] ~= nil then
			arg_158_1.duration_ = var_158_0[var_158_1]
		end

		SetActive(arg_158_1.tipsGo_, false)

		function arg_158_1.onSingleLineFinish_()
			arg_158_1.onSingleLineUpdate_ = nil
			arg_158_1.onSingleLineFinish_ = nil
			arg_158_1.state_ = "waiting"
		end

		function arg_158_1.playNext_(arg_160_0)
			if arg_160_0 == 1 then
				arg_158_0:Play106041040(arg_158_1)
			end
		end

		function arg_158_1.onSingleLineUpdate_(arg_161_0)
			local var_161_0 = 0

			if var_161_0 < arg_158_1.time_ and arg_158_1.time_ <= var_161_0 + arg_161_0 then
				arg_158_1:PlayTimeline("10003ui_story", "StoryTimeline/CharAction/story10003/story10003action/10003action4_1")
			end

			local var_161_1 = arg_158_1.actors_["10003ui_story"]
			local var_161_2 = 0

			if var_161_2 < arg_158_1.time_ and arg_158_1.time_ <= var_161_2 + arg_161_0 and not isNil(var_161_1) and arg_158_1.var_.characterEffect10003ui_story == nil then
				arg_158_1.var_.characterEffect10003ui_story = var_161_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_161_3 = 0.2

			if var_161_2 <= arg_158_1.time_ and arg_158_1.time_ < var_161_2 + var_161_3 and not isNil(var_161_1) then
				local var_161_4 = (arg_158_1.time_ - var_161_2) / var_161_3

				if arg_158_1.var_.characterEffect10003ui_story and not isNil(var_161_1) then
					arg_158_1.var_.characterEffect10003ui_story.fillFlat = false
				end
			end

			if arg_158_1.time_ >= var_161_2 + var_161_3 and arg_158_1.time_ < var_161_2 + var_161_3 + arg_161_0 and not isNil(var_161_1) and arg_158_1.var_.characterEffect10003ui_story then
				arg_158_1.var_.characterEffect10003ui_story.fillFlat = false
			end

			local var_161_5 = arg_158_1.actors_["10004ui_story"]
			local var_161_6 = 0

			if var_161_6 < arg_158_1.time_ and arg_158_1.time_ <= var_161_6 + arg_161_0 and not isNil(var_161_5) and arg_158_1.var_.characterEffect10004ui_story == nil then
				arg_158_1.var_.characterEffect10004ui_story = var_161_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_161_7 = 0.2

			if var_161_6 <= arg_158_1.time_ and arg_158_1.time_ < var_161_6 + var_161_7 and not isNil(var_161_5) then
				local var_161_8 = (arg_158_1.time_ - var_161_6) / var_161_7

				if arg_158_1.var_.characterEffect10004ui_story and not isNil(var_161_5) then
					local var_161_9 = Mathf.Lerp(0, 0.5, var_161_8)

					arg_158_1.var_.characterEffect10004ui_story.fillFlat = true
					arg_158_1.var_.characterEffect10004ui_story.fillRatio = var_161_9
				end
			end

			if arg_158_1.time_ >= var_161_6 + var_161_7 and arg_158_1.time_ < var_161_6 + var_161_7 + arg_161_0 and not isNil(var_161_5) and arg_158_1.var_.characterEffect10004ui_story then
				local var_161_10 = 0.5

				arg_158_1.var_.characterEffect10004ui_story.fillFlat = true
				arg_158_1.var_.characterEffect10004ui_story.fillRatio = var_161_10
			end

			local var_161_11 = 0

			if var_161_11 < arg_158_1.time_ and arg_158_1.time_ <= var_161_11 + arg_161_0 then
				arg_158_1:PlayTimeline("10003ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_161_12 = 0
			local var_161_13 = 0.525

			if var_161_12 < arg_158_1.time_ and arg_158_1.time_ <= var_161_12 + arg_161_0 then
				arg_158_1.talkMaxDuration = 0
				arg_158_1.dialogCg_.alpha = 1

				arg_158_1.dialog_:SetActive(true)
				SetActive(arg_158_1.leftNameGo_, true)

				local var_161_14 = arg_158_1:FormatText(StoryNameCfg[81].name)

				arg_158_1.leftNameTxt_.text = var_161_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_158_1.leftNameTxt_.transform)

				arg_158_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_158_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_158_1:RecordName(arg_158_1.leftNameTxt_.text)
				SetActive(arg_158_1.iconTrs_.gameObject, false)
				arg_158_1.callingController_:SetSelectedState("normal")

				local var_161_15 = arg_158_1:GetWordFromCfg(106041039)
				local var_161_16 = arg_158_1:FormatText(var_161_15.content)

				arg_158_1.text_.text = var_161_16

				LuaForUtil.ClearLinePrefixSymbol(arg_158_1.text_)

				local var_161_17 = 21
				local var_161_18 = utf8.len(var_161_16)
				local var_161_19 = var_161_17 <= 0 and var_161_13 or var_161_13 * (var_161_18 / var_161_17)

				if var_161_19 > 0 and var_161_13 < var_161_19 then
					arg_158_1.talkMaxDuration = var_161_19

					if var_161_19 + var_161_12 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_19 + var_161_12
					end
				end

				arg_158_1.text_.text = var_161_16
				arg_158_1.typewritter.percent = 0

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106041", "106041039", "story_v_out_106041.awb") ~= 0 then
					local var_161_20 = manager.audio:GetVoiceLength("story_v_out_106041", "106041039", "story_v_out_106041.awb") / 1000

					if var_161_20 + var_161_12 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_20 + var_161_12
					end

					if var_161_15.prefab_name ~= "" and arg_158_1.actors_[var_161_15.prefab_name] ~= nil then
						local var_161_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_158_1.actors_[var_161_15.prefab_name].transform, "story_v_out_106041", "106041039", "story_v_out_106041.awb")

						arg_158_1:RecordAudio("106041039", var_161_21)
						arg_158_1:RecordAudio("106041039", var_161_21)
					else
						arg_158_1:AudioAction("play", "voice", "story_v_out_106041", "106041039", "story_v_out_106041.awb")
					end

					arg_158_1:RecordHistoryTalkVoice("story_v_out_106041", "106041039", "story_v_out_106041.awb")
				end

				arg_158_1:RecordContent(arg_158_1.text_.text)
			end

			local var_161_22 = math.max(var_161_13, arg_158_1.talkMaxDuration)

			if var_161_12 <= arg_158_1.time_ and arg_158_1.time_ < var_161_12 + var_161_22 then
				arg_158_1.typewritter.percent = (arg_158_1.time_ - var_161_12) / var_161_22

				arg_158_1.typewritter:SetDirty()
			end

			if arg_158_1.time_ >= var_161_12 + var_161_22 and arg_158_1.time_ < var_161_12 + var_161_22 + arg_161_0 then
				arg_158_1.typewritter.percent = 1

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(true)
			end
		end

		arg_158_1.nodeConfigList_ = {}

		arg_158_1:InitPlayNodeList()
	end,
	Play106041040 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 106041040
		arg_162_1.duration_ = 8.5

		local var_162_0 = {
			ja = 6.766,
			ko = 5.6,
			zh = 8.5,
			en = 7.966
		}
		local var_162_1 = manager.audio:GetLocalizationFlag()

		if var_162_0[var_162_1] ~= nil then
			arg_162_1.duration_ = var_162_0[var_162_1]
		end

		SetActive(arg_162_1.tipsGo_, false)

		function arg_162_1.onSingleLineFinish_()
			arg_162_1.onSingleLineUpdate_ = nil
			arg_162_1.onSingleLineFinish_ = nil
			arg_162_1.state_ = "waiting"
		end

		function arg_162_1.playNext_(arg_164_0)
			if arg_164_0 == 1 then
				arg_162_0:Play106041041(arg_162_1)
			end
		end

		function arg_162_1.onSingleLineUpdate_(arg_165_0)
			local var_165_0 = arg_162_1.actors_["10003ui_story"]
			local var_165_1 = 0

			if var_165_1 < arg_162_1.time_ and arg_162_1.time_ <= var_165_1 + arg_165_0 and not isNil(var_165_0) and arg_162_1.var_.characterEffect10003ui_story == nil then
				arg_162_1.var_.characterEffect10003ui_story = var_165_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_165_2 = 0.2

			if var_165_1 <= arg_162_1.time_ and arg_162_1.time_ < var_165_1 + var_165_2 and not isNil(var_165_0) then
				local var_165_3 = (arg_162_1.time_ - var_165_1) / var_165_2

				if arg_162_1.var_.characterEffect10003ui_story and not isNil(var_165_0) then
					local var_165_4 = Mathf.Lerp(0, 0.5, var_165_3)

					arg_162_1.var_.characterEffect10003ui_story.fillFlat = true
					arg_162_1.var_.characterEffect10003ui_story.fillRatio = var_165_4
				end
			end

			if arg_162_1.time_ >= var_165_1 + var_165_2 and arg_162_1.time_ < var_165_1 + var_165_2 + arg_165_0 and not isNil(var_165_0) and arg_162_1.var_.characterEffect10003ui_story then
				local var_165_5 = 0.5

				arg_162_1.var_.characterEffect10003ui_story.fillFlat = true
				arg_162_1.var_.characterEffect10003ui_story.fillRatio = var_165_5
			end

			local var_165_6 = arg_162_1.actors_["10004ui_story"]
			local var_165_7 = 0

			if var_165_7 < arg_162_1.time_ and arg_162_1.time_ <= var_165_7 + arg_165_0 and not isNil(var_165_6) and arg_162_1.var_.characterEffect10004ui_story == nil then
				arg_162_1.var_.characterEffect10004ui_story = var_165_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_165_8 = 0.2

			if var_165_7 <= arg_162_1.time_ and arg_162_1.time_ < var_165_7 + var_165_8 and not isNil(var_165_6) then
				local var_165_9 = (arg_162_1.time_ - var_165_7) / var_165_8

				if arg_162_1.var_.characterEffect10004ui_story and not isNil(var_165_6) then
					arg_162_1.var_.characterEffect10004ui_story.fillFlat = false
				end
			end

			if arg_162_1.time_ >= var_165_7 + var_165_8 and arg_162_1.time_ < var_165_7 + var_165_8 + arg_165_0 and not isNil(var_165_6) and arg_162_1.var_.characterEffect10004ui_story then
				arg_162_1.var_.characterEffect10004ui_story.fillFlat = false
			end

			local var_165_10 = 0

			if var_165_10 < arg_162_1.time_ and arg_162_1.time_ <= var_165_10 + arg_165_0 then
				arg_162_1:PlayTimeline("10004ui_story", "StoryTimeline/CharAction/story10004/story10004actionlink/10004action432")
			end

			local var_165_11 = 0

			if var_165_11 < arg_162_1.time_ and arg_162_1.time_ <= var_165_11 + arg_165_0 then
				arg_162_1:PlayTimeline("10004ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_165_12 = 0
			local var_165_13 = 0.8

			if var_165_12 < arg_162_1.time_ and arg_162_1.time_ <= var_165_12 + arg_165_0 then
				arg_162_1.talkMaxDuration = 0
				arg_162_1.dialogCg_.alpha = 1

				arg_162_1.dialog_:SetActive(true)
				SetActive(arg_162_1.leftNameGo_, true)

				local var_165_14 = arg_162_1:FormatText(StoryNameCfg[80].name)

				arg_162_1.leftNameTxt_.text = var_165_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_162_1.leftNameTxt_.transform)

				arg_162_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_162_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_162_1:RecordName(arg_162_1.leftNameTxt_.text)
				SetActive(arg_162_1.iconTrs_.gameObject, false)
				arg_162_1.callingController_:SetSelectedState("normal")

				local var_165_15 = arg_162_1:GetWordFromCfg(106041040)
				local var_165_16 = arg_162_1:FormatText(var_165_15.content)

				arg_162_1.text_.text = var_165_16

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_17 = 32
				local var_165_18 = utf8.len(var_165_16)
				local var_165_19 = var_165_17 <= 0 and var_165_13 or var_165_13 * (var_165_18 / var_165_17)

				if var_165_19 > 0 and var_165_13 < var_165_19 then
					arg_162_1.talkMaxDuration = var_165_19

					if var_165_19 + var_165_12 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_19 + var_165_12
					end
				end

				arg_162_1.text_.text = var_165_16
				arg_162_1.typewritter.percent = 0

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106041", "106041040", "story_v_out_106041.awb") ~= 0 then
					local var_165_20 = manager.audio:GetVoiceLength("story_v_out_106041", "106041040", "story_v_out_106041.awb") / 1000

					if var_165_20 + var_165_12 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_20 + var_165_12
					end

					if var_165_15.prefab_name ~= "" and arg_162_1.actors_[var_165_15.prefab_name] ~= nil then
						local var_165_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_162_1.actors_[var_165_15.prefab_name].transform, "story_v_out_106041", "106041040", "story_v_out_106041.awb")

						arg_162_1:RecordAudio("106041040", var_165_21)
						arg_162_1:RecordAudio("106041040", var_165_21)
					else
						arg_162_1:AudioAction("play", "voice", "story_v_out_106041", "106041040", "story_v_out_106041.awb")
					end

					arg_162_1:RecordHistoryTalkVoice("story_v_out_106041", "106041040", "story_v_out_106041.awb")
				end

				arg_162_1:RecordContent(arg_162_1.text_.text)
			end

			local var_165_22 = math.max(var_165_13, arg_162_1.talkMaxDuration)

			if var_165_12 <= arg_162_1.time_ and arg_162_1.time_ < var_165_12 + var_165_22 then
				arg_162_1.typewritter.percent = (arg_162_1.time_ - var_165_12) / var_165_22

				arg_162_1.typewritter:SetDirty()
			end

			if arg_162_1.time_ >= var_165_12 + var_165_22 and arg_162_1.time_ < var_165_12 + var_165_22 + arg_165_0 then
				arg_162_1.typewritter.percent = 1

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(true)
			end
		end

		arg_162_1.nodeConfigList_ = {}

		arg_162_1:InitPlayNodeList()
	end,
	Play106041041 = function(arg_166_0, arg_166_1)
		arg_166_1.time_ = 0
		arg_166_1.frameCnt_ = 0
		arg_166_1.state_ = "playing"
		arg_166_1.curTalkId_ = 106041041
		arg_166_1.duration_ = 15.67

		local var_166_0 = {
			ja = 15.666,
			ko = 10.566,
			zh = 13.466,
			en = 12.066
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
				arg_166_0:Play106041042(arg_166_1)
			end
		end

		function arg_166_1.onSingleLineUpdate_(arg_169_0)
			local var_169_0 = 0

			if var_169_0 < arg_166_1.time_ and arg_166_1.time_ <= var_169_0 + arg_169_0 then
				arg_166_1:PlayTimeline("10004ui_story", "StoryTimeline/CharAction/story10004/story10004actionlink/10004action425")
			end

			local var_169_1 = 0

			if var_169_1 < arg_166_1.time_ and arg_166_1.time_ <= var_169_1 + arg_169_0 then
				arg_166_1:PlayTimeline("10004ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_169_2 = 0
			local var_169_3 = 1.2

			if var_169_2 < arg_166_1.time_ and arg_166_1.time_ <= var_169_2 + arg_169_0 then
				arg_166_1.talkMaxDuration = 0
				arg_166_1.dialogCg_.alpha = 1

				arg_166_1.dialog_:SetActive(true)
				SetActive(arg_166_1.leftNameGo_, true)

				local var_169_4 = arg_166_1:FormatText(StoryNameCfg[80].name)

				arg_166_1.leftNameTxt_.text = var_169_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_166_1.leftNameTxt_.transform)

				arg_166_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_166_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_166_1:RecordName(arg_166_1.leftNameTxt_.text)
				SetActive(arg_166_1.iconTrs_.gameObject, false)
				arg_166_1.callingController_:SetSelectedState("normal")

				local var_169_5 = arg_166_1:GetWordFromCfg(106041041)
				local var_169_6 = arg_166_1:FormatText(var_169_5.content)

				arg_166_1.text_.text = var_169_6

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.text_)

				local var_169_7 = 48
				local var_169_8 = utf8.len(var_169_6)
				local var_169_9 = var_169_7 <= 0 and var_169_3 or var_169_3 * (var_169_8 / var_169_7)

				if var_169_9 > 0 and var_169_3 < var_169_9 then
					arg_166_1.talkMaxDuration = var_169_9

					if var_169_9 + var_169_2 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_9 + var_169_2
					end
				end

				arg_166_1.text_.text = var_169_6
				arg_166_1.typewritter.percent = 0

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106041", "106041041", "story_v_out_106041.awb") ~= 0 then
					local var_169_10 = manager.audio:GetVoiceLength("story_v_out_106041", "106041041", "story_v_out_106041.awb") / 1000

					if var_169_10 + var_169_2 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_10 + var_169_2
					end

					if var_169_5.prefab_name ~= "" and arg_166_1.actors_[var_169_5.prefab_name] ~= nil then
						local var_169_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_166_1.actors_[var_169_5.prefab_name].transform, "story_v_out_106041", "106041041", "story_v_out_106041.awb")

						arg_166_1:RecordAudio("106041041", var_169_11)
						arg_166_1:RecordAudio("106041041", var_169_11)
					else
						arg_166_1:AudioAction("play", "voice", "story_v_out_106041", "106041041", "story_v_out_106041.awb")
					end

					arg_166_1:RecordHistoryTalkVoice("story_v_out_106041", "106041041", "story_v_out_106041.awb")
				end

				arg_166_1:RecordContent(arg_166_1.text_.text)
			end

			local var_169_12 = math.max(var_169_3, arg_166_1.talkMaxDuration)

			if var_169_2 <= arg_166_1.time_ and arg_166_1.time_ < var_169_2 + var_169_12 then
				arg_166_1.typewritter.percent = (arg_166_1.time_ - var_169_2) / var_169_12

				arg_166_1.typewritter:SetDirty()
			end

			if arg_166_1.time_ >= var_169_2 + var_169_12 and arg_166_1.time_ < var_169_2 + var_169_12 + arg_169_0 then
				arg_166_1.typewritter.percent = 1

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(true)
			end
		end

		arg_166_1.nodeConfigList_ = {}

		arg_166_1:InitPlayNodeList()
	end,
	Play106041042 = function(arg_170_0, arg_170_1)
		arg_170_1.time_ = 0
		arg_170_1.frameCnt_ = 0
		arg_170_1.state_ = "playing"
		arg_170_1.curTalkId_ = 106041042
		arg_170_1.duration_ = 11.03

		local var_170_0 = {
			ja = 10.733,
			ko = 6.766,
			zh = 11.033,
			en = 8.433
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
				arg_170_0:Play106041043(arg_170_1)
			end
		end

		function arg_170_1.onSingleLineUpdate_(arg_173_0)
			local var_173_0 = 0

			if var_173_0 < arg_170_1.time_ and arg_170_1.time_ <= var_173_0 + arg_173_0 then
				arg_170_1:PlayTimeline("10004ui_story", "StoryTimeline/CharAction/story10004/story10004action/10004action5_2")
			end

			local var_173_1 = 0

			if var_173_1 < arg_170_1.time_ and arg_170_1.time_ <= var_173_1 + arg_173_0 then
				arg_170_1:PlayTimeline("10004ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_173_2 = 0
			local var_173_3 = 0.875

			if var_173_2 < arg_170_1.time_ and arg_170_1.time_ <= var_173_2 + arg_173_0 then
				arg_170_1.talkMaxDuration = 0
				arg_170_1.dialogCg_.alpha = 1

				arg_170_1.dialog_:SetActive(true)
				SetActive(arg_170_1.leftNameGo_, true)

				local var_173_4 = arg_170_1:FormatText(StoryNameCfg[80].name)

				arg_170_1.leftNameTxt_.text = var_173_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_170_1.leftNameTxt_.transform)

				arg_170_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_170_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_170_1:RecordName(arg_170_1.leftNameTxt_.text)
				SetActive(arg_170_1.iconTrs_.gameObject, false)
				arg_170_1.callingController_:SetSelectedState("normal")

				local var_173_5 = arg_170_1:GetWordFromCfg(106041042)
				local var_173_6 = arg_170_1:FormatText(var_173_5.content)

				arg_170_1.text_.text = var_173_6

				LuaForUtil.ClearLinePrefixSymbol(arg_170_1.text_)

				local var_173_7 = 35
				local var_173_8 = utf8.len(var_173_6)
				local var_173_9 = var_173_7 <= 0 and var_173_3 or var_173_3 * (var_173_8 / var_173_7)

				if var_173_9 > 0 and var_173_3 < var_173_9 then
					arg_170_1.talkMaxDuration = var_173_9

					if var_173_9 + var_173_2 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_9 + var_173_2
					end
				end

				arg_170_1.text_.text = var_173_6
				arg_170_1.typewritter.percent = 0

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106041", "106041042", "story_v_out_106041.awb") ~= 0 then
					local var_173_10 = manager.audio:GetVoiceLength("story_v_out_106041", "106041042", "story_v_out_106041.awb") / 1000

					if var_173_10 + var_173_2 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_10 + var_173_2
					end

					if var_173_5.prefab_name ~= "" and arg_170_1.actors_[var_173_5.prefab_name] ~= nil then
						local var_173_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_170_1.actors_[var_173_5.prefab_name].transform, "story_v_out_106041", "106041042", "story_v_out_106041.awb")

						arg_170_1:RecordAudio("106041042", var_173_11)
						arg_170_1:RecordAudio("106041042", var_173_11)
					else
						arg_170_1:AudioAction("play", "voice", "story_v_out_106041", "106041042", "story_v_out_106041.awb")
					end

					arg_170_1:RecordHistoryTalkVoice("story_v_out_106041", "106041042", "story_v_out_106041.awb")
				end

				arg_170_1:RecordContent(arg_170_1.text_.text)
			end

			local var_173_12 = math.max(var_173_3, arg_170_1.talkMaxDuration)

			if var_173_2 <= arg_170_1.time_ and arg_170_1.time_ < var_173_2 + var_173_12 then
				arg_170_1.typewritter.percent = (arg_170_1.time_ - var_173_2) / var_173_12

				arg_170_1.typewritter:SetDirty()
			end

			if arg_170_1.time_ >= var_173_2 + var_173_12 and arg_170_1.time_ < var_173_2 + var_173_12 + arg_173_0 then
				arg_170_1.typewritter.percent = 1

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(true)
			end
		end

		arg_170_1.nodeConfigList_ = {}

		arg_170_1:InitPlayNodeList()
	end,
	Play106041043 = function(arg_174_0, arg_174_1)
		arg_174_1.time_ = 0
		arg_174_1.frameCnt_ = 0
		arg_174_1.state_ = "playing"
		arg_174_1.curTalkId_ = 106041043
		arg_174_1.duration_ = 4.97

		local var_174_0 = {
			ja = 4.966,
			ko = 2.3,
			zh = 2.7,
			en = 2.133
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
			arg_174_1.auto_ = false
		end

		function arg_174_1.playNext_(arg_176_0)
			arg_174_1.onStoryFinished_()
		end

		function arg_174_1.onSingleLineUpdate_(arg_177_0)
			local var_177_0 = 0

			if var_177_0 < arg_174_1.time_ and arg_174_1.time_ <= var_177_0 + arg_177_0 then
				arg_174_1:PlayTimeline("10004ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_177_1 = 0
			local var_177_2 = 0.175

			if var_177_1 < arg_174_1.time_ and arg_174_1.time_ <= var_177_1 + arg_177_0 then
				arg_174_1.talkMaxDuration = 0
				arg_174_1.dialogCg_.alpha = 1

				arg_174_1.dialog_:SetActive(true)
				SetActive(arg_174_1.leftNameGo_, true)

				local var_177_3 = arg_174_1:FormatText(StoryNameCfg[80].name)

				arg_174_1.leftNameTxt_.text = var_177_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_174_1.leftNameTxt_.transform)

				arg_174_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_174_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_174_1:RecordName(arg_174_1.leftNameTxt_.text)
				SetActive(arg_174_1.iconTrs_.gameObject, false)
				arg_174_1.callingController_:SetSelectedState("normal")

				local var_177_4 = arg_174_1:GetWordFromCfg(106041043)
				local var_177_5 = arg_174_1:FormatText(var_177_4.content)

				arg_174_1.text_.text = var_177_5

				LuaForUtil.ClearLinePrefixSymbol(arg_174_1.text_)

				local var_177_6 = 7
				local var_177_7 = utf8.len(var_177_5)
				local var_177_8 = var_177_6 <= 0 and var_177_2 or var_177_2 * (var_177_7 / var_177_6)

				if var_177_8 > 0 and var_177_2 < var_177_8 then
					arg_174_1.talkMaxDuration = var_177_8

					if var_177_8 + var_177_1 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_8 + var_177_1
					end
				end

				arg_174_1.text_.text = var_177_5
				arg_174_1.typewritter.percent = 0

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106041", "106041043", "story_v_out_106041.awb") ~= 0 then
					local var_177_9 = manager.audio:GetVoiceLength("story_v_out_106041", "106041043", "story_v_out_106041.awb") / 1000

					if var_177_9 + var_177_1 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_9 + var_177_1
					end

					if var_177_4.prefab_name ~= "" and arg_174_1.actors_[var_177_4.prefab_name] ~= nil then
						local var_177_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_174_1.actors_[var_177_4.prefab_name].transform, "story_v_out_106041", "106041043", "story_v_out_106041.awb")

						arg_174_1:RecordAudio("106041043", var_177_10)
						arg_174_1:RecordAudio("106041043", var_177_10)
					else
						arg_174_1:AudioAction("play", "voice", "story_v_out_106041", "106041043", "story_v_out_106041.awb")
					end

					arg_174_1:RecordHistoryTalkVoice("story_v_out_106041", "106041043", "story_v_out_106041.awb")
				end

				arg_174_1:RecordContent(arg_174_1.text_.text)
			end

			local var_177_11 = math.max(var_177_2, arg_174_1.talkMaxDuration)

			if var_177_1 <= arg_174_1.time_ and arg_174_1.time_ < var_177_1 + var_177_11 then
				arg_174_1.typewritter.percent = (arg_174_1.time_ - var_177_1) / var_177_11

				arg_174_1.typewritter:SetDirty()
			end

			if arg_174_1.time_ >= var_177_1 + var_177_11 and arg_174_1.time_ < var_177_1 + var_177_11 + arg_177_0 then
				arg_174_1.typewritter.percent = 1

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(true)
			end
		end

		arg_174_1.nodeConfigList_ = {}

		arg_174_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/S0607",
		"TextureConfig/Background/ST06a"
	},
	voices = {
		"story_v_out_106041.awb"
	}
}
