return {
	Play111072001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 111072001
		arg_1_1.duration_ = 6.5

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play111072002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "D09"

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
				local var_4_5 = arg_1_1.bgs_.D09

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
					if iter_4_0 ~= "D09" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = arg_1_1.bgs_.D09
			local var_4_17 = 0

			if var_4_17 < arg_1_1.time_ and arg_1_1.time_ <= var_4_17 + arg_4_0 then
				local var_4_18 = var_4_16:GetComponent("SpriteRenderer")

				if var_4_18 then
					arg_1_1.var_.alphaOldValueD09 = var_4_18.color.a
					arg_1_1.var_.alphaMatValueD09 = var_4_18
				end

				arg_1_1.var_.alphaOldValueD09 = 0
			end

			local var_4_19 = 1.5

			if var_4_17 <= arg_1_1.time_ and arg_1_1.time_ < var_4_17 + var_4_19 then
				local var_4_20 = (arg_1_1.time_ - var_4_17) / var_4_19
				local var_4_21 = Mathf.Lerp(arg_1_1.var_.alphaOldValueD09, 1, var_4_20)

				if arg_1_1.var_.alphaMatValueD09 then
					local var_4_22 = arg_1_1.var_.alphaMatValueD09.color

					var_4_22.a = var_4_21
					arg_1_1.var_.alphaMatValueD09.color = var_4_22
				end
			end

			if arg_1_1.time_ >= var_4_17 + var_4_19 and arg_1_1.time_ < var_4_17 + var_4_19 + arg_4_0 and arg_1_1.var_.alphaMatValueD09 then
				local var_4_23 = arg_1_1.var_.alphaMatValueD09
				local var_4_24 = var_4_23.color

				var_4_24.a = 1
				var_4_23.color = var_4_24
			end

			local var_4_25 = 0

			if var_4_25 < arg_1_1.time_ and arg_1_1.time_ <= var_4_25 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_26 = 1.5

			if arg_1_1.time_ >= var_4_25 + var_4_26 and arg_1_1.time_ < var_4_25 + var_4_26 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_27 = 0
			local var_4_28 = 1

			if var_4_27 < arg_1_1.time_ and arg_1_1.time_ <= var_4_27 + arg_4_0 then
				local var_4_29 = "play"
				local var_4_30 = "music"

				arg_1_1:AudioAction(var_4_29, var_4_30, "bgm_activity_1_1_hel_story", "bgm_activity_1_1_hel_story", "bgm_activity_1_1_hel_story.awb")

				local var_4_31 = ""
				local var_4_32 = manager.audio:GetAudioName("bgm_activity_1_1_hel_story", "bgm_activity_1_1_hel_story")

				if var_4_32 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_32 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_32

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_32
						arg_1_1.bgmTxt2_.text = var_4_32
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

			local var_4_33 = 1.5
			local var_4_34 = 1.075

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

				local var_4_36 = arg_1_1:GetWordFromCfg(111072001)
				local var_4_37 = arg_1_1:FormatText(var_4_36.content)

				arg_1_1.text_.text = var_4_37

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_38 = 43
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
	Play111072002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 111072002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play111072003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 0
			local var_11_1 = 0.825

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

				local var_11_2 = arg_8_1:GetWordFromCfg(111072002)
				local var_11_3 = arg_8_1:FormatText(var_11_2.content)

				arg_8_1.text_.text = var_11_3

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_4 = 33
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
	Play111072003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 111072003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play111072004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 0
			local var_15_1 = 1.175

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

				local var_15_2 = arg_12_1:GetWordFromCfg(111072003)
				local var_15_3 = arg_12_1:FormatText(var_15_2.content)

				arg_12_1.text_.text = var_15_3

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_4 = 47
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
	Play111072004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 111072004
		arg_16_1.duration_ = 4.13

		local var_16_0 = {
			ja = 3.266,
			ko = 3.433,
			zh = 4.133,
			en = 2.5
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
				arg_16_0:Play111072005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = 0
			local var_19_1 = 0.3

			if var_19_0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_0 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				local var_19_2 = arg_16_1:FormatText(StoryNameCfg[189].name)

				arg_16_1.leftNameTxt_.text = var_19_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, true)
				arg_16_1.iconController_:SetSelectedState("hero")

				arg_16_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_vina")

				arg_16_1.callingController_:SetSelectedState("normal")

				arg_16_1.keyicon_.color = Color.New(1, 1, 1)
				arg_16_1.icon_.color = Color.New(1, 1, 1)

				local var_19_3 = arg_16_1:GetWordFromCfg(111072004)
				local var_19_4 = arg_16_1:FormatText(var_19_3.content)

				arg_16_1.text_.text = var_19_4

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_5 = 12
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

				if manager.audio:GetVoiceLength("story_v_out_111072", "111072004", "story_v_out_111072.awb") ~= 0 then
					local var_19_8 = manager.audio:GetVoiceLength("story_v_out_111072", "111072004", "story_v_out_111072.awb") / 1000

					if var_19_8 + var_19_0 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_8 + var_19_0
					end

					if var_19_3.prefab_name ~= "" and arg_16_1.actors_[var_19_3.prefab_name] ~= nil then
						local var_19_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_3.prefab_name].transform, "story_v_out_111072", "111072004", "story_v_out_111072.awb")

						arg_16_1:RecordAudio("111072004", var_19_9)
						arg_16_1:RecordAudio("111072004", var_19_9)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_111072", "111072004", "story_v_out_111072.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_111072", "111072004", "story_v_out_111072.awb")
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
	Play111072005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 111072005
		arg_20_1.duration_ = 5

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play111072006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = 0
			local var_23_1 = 0.35

			if var_23_0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_0 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				local var_23_2 = arg_20_1:FormatText(StoryNameCfg[7].name)

				arg_20_1.leftNameTxt_.text = var_23_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, true)
				arg_20_1.iconController_:SetSelectedState("hero")

				arg_20_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_20_1.callingController_:SetSelectedState("normal")

				arg_20_1.keyicon_.color = Color.New(1, 1, 1)
				arg_20_1.icon_.color = Color.New(1, 1, 1)

				local var_23_3 = arg_20_1:GetWordFromCfg(111072005)
				local var_23_4 = arg_20_1:FormatText(var_23_3.content)

				arg_20_1.text_.text = var_23_4

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_5 = 14
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
				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_8 = math.max(var_23_1, arg_20_1.talkMaxDuration)

			if var_23_0 <= arg_20_1.time_ and arg_20_1.time_ < var_23_0 + var_23_8 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_0) / var_23_8

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_0 + var_23_8 and arg_20_1.time_ < var_23_0 + var_23_8 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play111072006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 111072006
		arg_24_1.duration_ = 3.23

		local var_24_0 = {
			ja = 2.7,
			ko = 3.1,
			zh = 3,
			en = 3.233
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
				arg_24_0:Play111072007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = 0
			local var_27_1 = 0.175

			if var_27_0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_0 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				local var_27_2 = arg_24_1:FormatText(StoryNameCfg[189].name)

				arg_24_1.leftNameTxt_.text = var_27_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, true)
				arg_24_1.iconController_:SetSelectedState("hero")

				arg_24_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_vina")

				arg_24_1.callingController_:SetSelectedState("normal")

				arg_24_1.keyicon_.color = Color.New(1, 1, 1)
				arg_24_1.icon_.color = Color.New(1, 1, 1)

				local var_27_3 = arg_24_1:GetWordFromCfg(111072006)
				local var_27_4 = arg_24_1:FormatText(var_27_3.content)

				arg_24_1.text_.text = var_27_4

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_5 = 7
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

				if manager.audio:GetVoiceLength("story_v_out_111072", "111072006", "story_v_out_111072.awb") ~= 0 then
					local var_27_8 = manager.audio:GetVoiceLength("story_v_out_111072", "111072006", "story_v_out_111072.awb") / 1000

					if var_27_8 + var_27_0 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_8 + var_27_0
					end

					if var_27_3.prefab_name ~= "" and arg_24_1.actors_[var_27_3.prefab_name] ~= nil then
						local var_27_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_3.prefab_name].transform, "story_v_out_111072", "111072006", "story_v_out_111072.awb")

						arg_24_1:RecordAudio("111072006", var_27_9)
						arg_24_1:RecordAudio("111072006", var_27_9)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_111072", "111072006", "story_v_out_111072.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_111072", "111072006", "story_v_out_111072.awb")
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
	Play111072007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 111072007
		arg_28_1.duration_ = 6.87

		local var_28_0 = {
			ja = 6.866,
			ko = 4.666,
			zh = 3.266,
			en = 1.9
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
				arg_28_0:Play111072008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = 0
			local var_31_1 = 0.425

			if var_31_0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_0 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				local var_31_2 = arg_28_1:FormatText(StoryNameCfg[189].name)

				arg_28_1.leftNameTxt_.text = var_31_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, true)
				arg_28_1.iconController_:SetSelectedState("hero")

				arg_28_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_vina")

				arg_28_1.callingController_:SetSelectedState("normal")

				arg_28_1.keyicon_.color = Color.New(1, 1, 1)
				arg_28_1.icon_.color = Color.New(1, 1, 1)

				local var_31_3 = arg_28_1:GetWordFromCfg(111072007)
				local var_31_4 = arg_28_1:FormatText(var_31_3.content)

				arg_28_1.text_.text = var_31_4

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_5 = 11
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

				if manager.audio:GetVoiceLength("story_v_out_111072", "111072007", "story_v_out_111072.awb") ~= 0 then
					local var_31_8 = manager.audio:GetVoiceLength("story_v_out_111072", "111072007", "story_v_out_111072.awb") / 1000

					if var_31_8 + var_31_0 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_8 + var_31_0
					end

					if var_31_3.prefab_name ~= "" and arg_28_1.actors_[var_31_3.prefab_name] ~= nil then
						local var_31_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_3.prefab_name].transform, "story_v_out_111072", "111072007", "story_v_out_111072.awb")

						arg_28_1:RecordAudio("111072007", var_31_9)
						arg_28_1:RecordAudio("111072007", var_31_9)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_111072", "111072007", "story_v_out_111072.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_111072", "111072007", "story_v_out_111072.awb")
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
	Play111072008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 111072008
		arg_32_1.duration_ = 11.47

		local var_32_0 = {
			ja = 6.233,
			ko = 8.666,
			zh = 11.466,
			en = 7.4
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
				arg_32_0:Play111072009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = 0
			local var_35_1 = 1

			if var_35_0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_0 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				local var_35_2 = arg_32_1:FormatText(StoryNameCfg[189].name)

				arg_32_1.leftNameTxt_.text = var_35_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, true)
				arg_32_1.iconController_:SetSelectedState("hero")

				arg_32_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_vina")

				arg_32_1.callingController_:SetSelectedState("normal")

				arg_32_1.keyicon_.color = Color.New(1, 1, 1)
				arg_32_1.icon_.color = Color.New(1, 1, 1)

				local var_35_3 = arg_32_1:GetWordFromCfg(111072008)
				local var_35_4 = arg_32_1:FormatText(var_35_3.content)

				arg_32_1.text_.text = var_35_4

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_5 = 41
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

				if manager.audio:GetVoiceLength("story_v_out_111072", "111072008", "story_v_out_111072.awb") ~= 0 then
					local var_35_8 = manager.audio:GetVoiceLength("story_v_out_111072", "111072008", "story_v_out_111072.awb") / 1000

					if var_35_8 + var_35_0 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_8 + var_35_0
					end

					if var_35_3.prefab_name ~= "" and arg_32_1.actors_[var_35_3.prefab_name] ~= nil then
						local var_35_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_3.prefab_name].transform, "story_v_out_111072", "111072008", "story_v_out_111072.awb")

						arg_32_1:RecordAudio("111072008", var_35_9)
						arg_32_1:RecordAudio("111072008", var_35_9)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_111072", "111072008", "story_v_out_111072.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_111072", "111072008", "story_v_out_111072.awb")
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
	Play111072009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 111072009
		arg_36_1.duration_ = 5

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play111072010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = 0
			local var_39_1 = 0.475

			if var_39_0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_0 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				local var_39_2 = arg_36_1:FormatText(StoryNameCfg[7].name)

				arg_36_1.leftNameTxt_.text = var_39_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, true)
				arg_36_1.iconController_:SetSelectedState("hero")

				arg_36_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_36_1.callingController_:SetSelectedState("normal")

				arg_36_1.keyicon_.color = Color.New(1, 1, 1)
				arg_36_1.icon_.color = Color.New(1, 1, 1)

				local var_39_3 = arg_36_1:GetWordFromCfg(111072009)
				local var_39_4 = arg_36_1:FormatText(var_39_3.content)

				arg_36_1.text_.text = var_39_4

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_5 = 19
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
				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_8 = math.max(var_39_1, arg_36_1.talkMaxDuration)

			if var_39_0 <= arg_36_1.time_ and arg_36_1.time_ < var_39_0 + var_39_8 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_0) / var_39_8

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_0 + var_39_8 and arg_36_1.time_ < var_39_0 + var_39_8 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play111072010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 111072010
		arg_40_1.duration_ = 5.4

		local var_40_0 = {
			ja = 2.433,
			ko = 3.133,
			zh = 5.4,
			en = 4
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
				arg_40_0:Play111072011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = 0
			local var_43_1 = 0.325

			if var_43_0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_0 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				local var_43_2 = arg_40_1:FormatText(StoryNameCfg[189].name)

				arg_40_1.leftNameTxt_.text = var_43_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, true)
				arg_40_1.iconController_:SetSelectedState("hero")

				arg_40_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_vina")

				arg_40_1.callingController_:SetSelectedState("normal")

				arg_40_1.keyicon_.color = Color.New(1, 1, 1)
				arg_40_1.icon_.color = Color.New(1, 1, 1)

				local var_43_3 = arg_40_1:GetWordFromCfg(111072010)
				local var_43_4 = arg_40_1:FormatText(var_43_3.content)

				arg_40_1.text_.text = var_43_4

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_5 = 11
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

				if manager.audio:GetVoiceLength("story_v_out_111072", "111072010", "story_v_out_111072.awb") ~= 0 then
					local var_43_8 = manager.audio:GetVoiceLength("story_v_out_111072", "111072010", "story_v_out_111072.awb") / 1000

					if var_43_8 + var_43_0 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_8 + var_43_0
					end

					if var_43_3.prefab_name ~= "" and arg_40_1.actors_[var_43_3.prefab_name] ~= nil then
						local var_43_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_3.prefab_name].transform, "story_v_out_111072", "111072010", "story_v_out_111072.awb")

						arg_40_1:RecordAudio("111072010", var_43_9)
						arg_40_1:RecordAudio("111072010", var_43_9)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_111072", "111072010", "story_v_out_111072.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_111072", "111072010", "story_v_out_111072.awb")
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
	Play111072011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 111072011
		arg_44_1.duration_ = 5

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play111072012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = 0
			local var_47_1 = 0.05

			if var_47_0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_0 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				local var_47_2 = arg_44_1:FormatText(StoryNameCfg[7].name)

				arg_44_1.leftNameTxt_.text = var_47_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, true)
				arg_44_1.iconController_:SetSelectedState("hero")

				arg_44_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_44_1.callingController_:SetSelectedState("normal")

				arg_44_1.keyicon_.color = Color.New(1, 1, 1)
				arg_44_1.icon_.color = Color.New(1, 1, 1)

				local var_47_3 = arg_44_1:GetWordFromCfg(111072011)
				local var_47_4 = arg_44_1:FormatText(var_47_3.content)

				arg_44_1.text_.text = var_47_4

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_5 = 2
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
				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_8 = math.max(var_47_1, arg_44_1.talkMaxDuration)

			if var_47_0 <= arg_44_1.time_ and arg_44_1.time_ < var_47_0 + var_47_8 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_0) / var_47_8

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_0 + var_47_8 and arg_44_1.time_ < var_47_0 + var_47_8 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play111072012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 111072012
		arg_48_1.duration_ = 4.07

		local var_48_0 = {
			ja = 3.5,
			ko = 1.933,
			zh = 4.066,
			en = 2.766
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
				arg_48_0:Play111072013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = 0
			local var_51_1 = 0.125

			if var_51_0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_0 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				local var_51_2 = arg_48_1:FormatText(StoryNameCfg[189].name)

				arg_48_1.leftNameTxt_.text = var_51_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, true)
				arg_48_1.iconController_:SetSelectedState("hero")

				arg_48_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_vina")

				arg_48_1.callingController_:SetSelectedState("normal")

				arg_48_1.keyicon_.color = Color.New(1, 1, 1)
				arg_48_1.icon_.color = Color.New(1, 1, 1)

				local var_51_3 = arg_48_1:GetWordFromCfg(111072012)
				local var_51_4 = arg_48_1:FormatText(var_51_3.content)

				arg_48_1.text_.text = var_51_4

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_5 = 6
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

				if manager.audio:GetVoiceLength("story_v_out_111072", "111072012", "story_v_out_111072.awb") ~= 0 then
					local var_51_8 = manager.audio:GetVoiceLength("story_v_out_111072", "111072012", "story_v_out_111072.awb") / 1000

					if var_51_8 + var_51_0 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_8 + var_51_0
					end

					if var_51_3.prefab_name ~= "" and arg_48_1.actors_[var_51_3.prefab_name] ~= nil then
						local var_51_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_3.prefab_name].transform, "story_v_out_111072", "111072012", "story_v_out_111072.awb")

						arg_48_1:RecordAudio("111072012", var_51_9)
						arg_48_1:RecordAudio("111072012", var_51_9)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_111072", "111072012", "story_v_out_111072.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_111072", "111072012", "story_v_out_111072.awb")
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
	Play111072013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 111072013
		arg_52_1.duration_ = 5

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play111072014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = 0
			local var_55_1 = 0.975

			if var_55_0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_0 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, false)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_2 = arg_52_1:GetWordFromCfg(111072013)
				local var_55_3 = arg_52_1:FormatText(var_55_2.content)

				arg_52_1.text_.text = var_55_3

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_4 = 39
				local var_55_5 = utf8.len(var_55_3)
				local var_55_6 = var_55_4 <= 0 and var_55_1 or var_55_1 * (var_55_5 / var_55_4)

				if var_55_6 > 0 and var_55_1 < var_55_6 then
					arg_52_1.talkMaxDuration = var_55_6

					if var_55_6 + var_55_0 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_6 + var_55_0
					end
				end

				arg_52_1.text_.text = var_55_3
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)
				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_7 = math.max(var_55_1, arg_52_1.talkMaxDuration)

			if var_55_0 <= arg_52_1.time_ and arg_52_1.time_ < var_55_0 + var_55_7 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_0) / var_55_7

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_0 + var_55_7 and arg_52_1.time_ < var_55_0 + var_55_7 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play111072014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 111072014
		arg_56_1.duration_ = 5

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play111072015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = 0
			local var_59_1 = 0.6

			if var_59_0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_0 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				local var_59_2 = arg_56_1:FormatText(StoryNameCfg[7].name)

				arg_56_1.leftNameTxt_.text = var_59_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, true)
				arg_56_1.iconController_:SetSelectedState("hero")

				arg_56_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_56_1.callingController_:SetSelectedState("normal")

				arg_56_1.keyicon_.color = Color.New(1, 1, 1)
				arg_56_1.icon_.color = Color.New(1, 1, 1)

				local var_59_3 = arg_56_1:GetWordFromCfg(111072014)
				local var_59_4 = arg_56_1:FormatText(var_59_3.content)

				arg_56_1.text_.text = var_59_4

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_5 = 24
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
				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_8 = math.max(var_59_1, arg_56_1.talkMaxDuration)

			if var_59_0 <= arg_56_1.time_ and arg_56_1.time_ < var_59_0 + var_59_8 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_0) / var_59_8

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_0 + var_59_8 and arg_56_1.time_ < var_59_0 + var_59_8 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play111072015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 111072015
		arg_60_1.duration_ = 4.7

		local var_60_0 = {
			ja = 2.2,
			ko = 3.766,
			zh = 4.7,
			en = 4.1
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
				arg_60_0:Play111072016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = 0
			local var_63_1 = 0.4

			if var_63_0 < arg_60_1.time_ and arg_60_1.time_ <= var_63_0 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				local var_63_2 = arg_60_1:FormatText(StoryNameCfg[189].name)

				arg_60_1.leftNameTxt_.text = var_63_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, true)
				arg_60_1.iconController_:SetSelectedState("hero")

				arg_60_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_vina")

				arg_60_1.callingController_:SetSelectedState("normal")

				arg_60_1.keyicon_.color = Color.New(1, 1, 1)
				arg_60_1.icon_.color = Color.New(1, 1, 1)

				local var_63_3 = arg_60_1:GetWordFromCfg(111072015)
				local var_63_4 = arg_60_1:FormatText(var_63_3.content)

				arg_60_1.text_.text = var_63_4

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_5 = 15
				local var_63_6 = utf8.len(var_63_4)
				local var_63_7 = var_63_5 <= 0 and var_63_1 or var_63_1 * (var_63_6 / var_63_5)

				if var_63_7 > 0 and var_63_1 < var_63_7 then
					arg_60_1.talkMaxDuration = var_63_7

					if var_63_7 + var_63_0 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_7 + var_63_0
					end
				end

				arg_60_1.text_.text = var_63_4
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111072", "111072015", "story_v_out_111072.awb") ~= 0 then
					local var_63_8 = manager.audio:GetVoiceLength("story_v_out_111072", "111072015", "story_v_out_111072.awb") / 1000

					if var_63_8 + var_63_0 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_8 + var_63_0
					end

					if var_63_3.prefab_name ~= "" and arg_60_1.actors_[var_63_3.prefab_name] ~= nil then
						local var_63_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_3.prefab_name].transform, "story_v_out_111072", "111072015", "story_v_out_111072.awb")

						arg_60_1:RecordAudio("111072015", var_63_9)
						arg_60_1:RecordAudio("111072015", var_63_9)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_111072", "111072015", "story_v_out_111072.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_111072", "111072015", "story_v_out_111072.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_10 = math.max(var_63_1, arg_60_1.talkMaxDuration)

			if var_63_0 <= arg_60_1.time_ and arg_60_1.time_ < var_63_0 + var_63_10 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_0) / var_63_10

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_0 + var_63_10 and arg_60_1.time_ < var_63_0 + var_63_10 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play111072016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 111072016
		arg_64_1.duration_ = 5

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play111072017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = 0
			local var_67_1 = 0.125

			if var_67_0 < arg_64_1.time_ and arg_64_1.time_ <= var_67_0 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				local var_67_2 = arg_64_1:FormatText(StoryNameCfg[7].name)

				arg_64_1.leftNameTxt_.text = var_67_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, true)
				arg_64_1.iconController_:SetSelectedState("hero")

				arg_64_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_64_1.callingController_:SetSelectedState("normal")

				arg_64_1.keyicon_.color = Color.New(1, 1, 1)
				arg_64_1.icon_.color = Color.New(1, 1, 1)

				local var_67_3 = arg_64_1:GetWordFromCfg(111072016)
				local var_67_4 = arg_64_1:FormatText(var_67_3.content)

				arg_64_1.text_.text = var_67_4

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_5 = 5
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
				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_8 = math.max(var_67_1, arg_64_1.talkMaxDuration)

			if var_67_0 <= arg_64_1.time_ and arg_64_1.time_ < var_67_0 + var_67_8 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_0) / var_67_8

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_0 + var_67_8 and arg_64_1.time_ < var_67_0 + var_67_8 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {}

		arg_64_1:InitPlayNodeList()
	end,
	Play111072017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 111072017
		arg_68_1.duration_ = 5

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"
		end

		function arg_68_1.playNext_(arg_70_0)
			if arg_70_0 == 1 then
				arg_68_0:Play111072018(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = 0
			local var_71_1 = 1.2

			if var_71_0 < arg_68_1.time_ and arg_68_1.time_ <= var_71_0 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, false)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_2 = arg_68_1:GetWordFromCfg(111072017)
				local var_71_3 = arg_68_1:FormatText(var_71_2.content)

				arg_68_1.text_.text = var_71_3

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_4 = 48
				local var_71_5 = utf8.len(var_71_3)
				local var_71_6 = var_71_4 <= 0 and var_71_1 or var_71_1 * (var_71_5 / var_71_4)

				if var_71_6 > 0 and var_71_1 < var_71_6 then
					arg_68_1.talkMaxDuration = var_71_6

					if var_71_6 + var_71_0 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_6 + var_71_0
					end
				end

				arg_68_1.text_.text = var_71_3
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)
				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_7 = math.max(var_71_1, arg_68_1.talkMaxDuration)

			if var_71_0 <= arg_68_1.time_ and arg_68_1.time_ < var_71_0 + var_71_7 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_0) / var_71_7

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_0 + var_71_7 and arg_68_1.time_ < var_71_0 + var_71_7 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {}

		arg_68_1:InitPlayNodeList()
	end,
	Play111072018 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 111072018
		arg_72_1.duration_ = 5

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play111072019(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = 0
			local var_75_1 = 0.925

			if var_75_0 < arg_72_1.time_ and arg_72_1.time_ <= var_75_0 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, false)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_2 = arg_72_1:GetWordFromCfg(111072018)
				local var_75_3 = arg_72_1:FormatText(var_75_2.content)

				arg_72_1.text_.text = var_75_3

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_4 = 37
				local var_75_5 = utf8.len(var_75_3)
				local var_75_6 = var_75_4 <= 0 and var_75_1 or var_75_1 * (var_75_5 / var_75_4)

				if var_75_6 > 0 and var_75_1 < var_75_6 then
					arg_72_1.talkMaxDuration = var_75_6

					if var_75_6 + var_75_0 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_6 + var_75_0
					end
				end

				arg_72_1.text_.text = var_75_3
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)
				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_7 = math.max(var_75_1, arg_72_1.talkMaxDuration)

			if var_75_0 <= arg_72_1.time_ and arg_72_1.time_ < var_75_0 + var_75_7 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_0) / var_75_7

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_0 + var_75_7 and arg_72_1.time_ < var_75_0 + var_75_7 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {}

		arg_72_1:InitPlayNodeList()
	end,
	Play111072019 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 111072019
		arg_76_1.duration_ = 5

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play111072020(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = 0
			local var_79_1 = 0.075

			if var_79_0 < arg_76_1.time_ and arg_76_1.time_ <= var_79_0 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				local var_79_2 = arg_76_1:FormatText(StoryNameCfg[7].name)

				arg_76_1.leftNameTxt_.text = var_79_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, true)
				arg_76_1.iconController_:SetSelectedState("hero")

				arg_76_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_76_1.callingController_:SetSelectedState("normal")

				arg_76_1.keyicon_.color = Color.New(1, 1, 1)
				arg_76_1.icon_.color = Color.New(1, 1, 1)

				local var_79_3 = arg_76_1:GetWordFromCfg(111072019)
				local var_79_4 = arg_76_1:FormatText(var_79_3.content)

				arg_76_1.text_.text = var_79_4

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_5 = 3
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
				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_8 = math.max(var_79_1, arg_76_1.talkMaxDuration)

			if var_79_0 <= arg_76_1.time_ and arg_76_1.time_ < var_79_0 + var_79_8 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_0) / var_79_8

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_0 + var_79_8 and arg_76_1.time_ < var_79_0 + var_79_8 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {}

		arg_76_1:InitPlayNodeList()
	end,
	Play111072020 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 111072020
		arg_80_1.duration_ = 2.9

		local var_80_0 = {
			ja = 1.5,
			ko = 1.466,
			zh = 2.9,
			en = 1.766
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
				arg_80_0:Play111072021(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = 0
			local var_83_1 = 0.125

			if var_83_0 < arg_80_1.time_ and arg_80_1.time_ <= var_83_0 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				local var_83_2 = arg_80_1:FormatText(StoryNameCfg[189].name)

				arg_80_1.leftNameTxt_.text = var_83_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, true)
				arg_80_1.iconController_:SetSelectedState("hero")

				arg_80_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_vina")

				arg_80_1.callingController_:SetSelectedState("normal")

				arg_80_1.keyicon_.color = Color.New(1, 1, 1)
				arg_80_1.icon_.color = Color.New(1, 1, 1)

				local var_83_3 = arg_80_1:GetWordFromCfg(111072020)
				local var_83_4 = arg_80_1:FormatText(var_83_3.content)

				arg_80_1.text_.text = var_83_4

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_5 = 5
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

				if manager.audio:GetVoiceLength("story_v_out_111072", "111072020", "story_v_out_111072.awb") ~= 0 then
					local var_83_8 = manager.audio:GetVoiceLength("story_v_out_111072", "111072020", "story_v_out_111072.awb") / 1000

					if var_83_8 + var_83_0 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_8 + var_83_0
					end

					if var_83_3.prefab_name ~= "" and arg_80_1.actors_[var_83_3.prefab_name] ~= nil then
						local var_83_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_3.prefab_name].transform, "story_v_out_111072", "111072020", "story_v_out_111072.awb")

						arg_80_1:RecordAudio("111072020", var_83_9)
						arg_80_1:RecordAudio("111072020", var_83_9)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_out_111072", "111072020", "story_v_out_111072.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_out_111072", "111072020", "story_v_out_111072.awb")
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
	Play111072021 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 111072021
		arg_84_1.duration_ = 5

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play111072022(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = 0
			local var_87_1 = 0.75

			if var_87_0 < arg_84_1.time_ and arg_84_1.time_ <= var_87_0 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, false)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_2 = arg_84_1:GetWordFromCfg(111072021)
				local var_87_3 = arg_84_1:FormatText(var_87_2.content)

				arg_84_1.text_.text = var_87_3

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_4 = 30
				local var_87_5 = utf8.len(var_87_3)
				local var_87_6 = var_87_4 <= 0 and var_87_1 or var_87_1 * (var_87_5 / var_87_4)

				if var_87_6 > 0 and var_87_1 < var_87_6 then
					arg_84_1.talkMaxDuration = var_87_6

					if var_87_6 + var_87_0 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_6 + var_87_0
					end
				end

				arg_84_1.text_.text = var_87_3
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)
				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_7 = math.max(var_87_1, arg_84_1.talkMaxDuration)

			if var_87_0 <= arg_84_1.time_ and arg_84_1.time_ < var_87_0 + var_87_7 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_0) / var_87_7

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_0 + var_87_7 and arg_84_1.time_ < var_87_0 + var_87_7 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {}

		arg_84_1:InitPlayNodeList()
	end,
	Play111072022 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 111072022
		arg_88_1.duration_ = 5

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play111072023(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = 0
			local var_91_1 = 1.075

			if var_91_0 < arg_88_1.time_ and arg_88_1.time_ <= var_91_0 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, false)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_2 = arg_88_1:GetWordFromCfg(111072022)
				local var_91_3 = arg_88_1:FormatText(var_91_2.content)

				arg_88_1.text_.text = var_91_3

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_4 = 43
				local var_91_5 = utf8.len(var_91_3)
				local var_91_6 = var_91_4 <= 0 and var_91_1 or var_91_1 * (var_91_5 / var_91_4)

				if var_91_6 > 0 and var_91_1 < var_91_6 then
					arg_88_1.talkMaxDuration = var_91_6

					if var_91_6 + var_91_0 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_6 + var_91_0
					end
				end

				arg_88_1.text_.text = var_91_3
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)
				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_7 = math.max(var_91_1, arg_88_1.talkMaxDuration)

			if var_91_0 <= arg_88_1.time_ and arg_88_1.time_ < var_91_0 + var_91_7 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_0) / var_91_7

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_0 + var_91_7 and arg_88_1.time_ < var_91_0 + var_91_7 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {}

		arg_88_1:InitPlayNodeList()
	end,
	Play111072023 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 111072023
		arg_92_1.duration_ = 8

		SetActive(arg_92_1.tipsGo_, false)

		function arg_92_1.onSingleLineFinish_()
			arg_92_1.onSingleLineUpdate_ = nil
			arg_92_1.onSingleLineFinish_ = nil
			arg_92_1.state_ = "waiting"
		end

		function arg_92_1.playNext_(arg_94_0)
			if arg_94_0 == 1 then
				arg_92_0:Play111072024(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			local var_95_0 = "D06a"

			if arg_92_1.bgs_[var_95_0] == nil then
				local var_95_1 = Object.Instantiate(arg_92_1.paintGo_)

				var_95_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_95_0)
				var_95_1.name = var_95_0
				var_95_1.transform.parent = arg_92_1.stage_.transform
				var_95_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_92_1.bgs_[var_95_0] = var_95_1
			end

			local var_95_2 = 1.5

			if var_95_2 < arg_92_1.time_ and arg_92_1.time_ <= var_95_2 + arg_95_0 then
				local var_95_3 = manager.ui.mainCamera.transform.localPosition
				local var_95_4 = Vector3.New(0, 0, 10) + Vector3.New(var_95_3.x, var_95_3.y, 0)
				local var_95_5 = arg_92_1.bgs_.D06a

				var_95_5.transform.localPosition = var_95_4
				var_95_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_95_6 = var_95_5:GetComponent("SpriteRenderer")

				if var_95_6 and var_95_6.sprite then
					local var_95_7 = (var_95_5.transform.localPosition - var_95_3).z
					local var_95_8 = manager.ui.mainCameraCom_
					local var_95_9 = 2 * var_95_7 * Mathf.Tan(var_95_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_95_10 = var_95_9 * var_95_8.aspect
					local var_95_11 = var_95_6.sprite.bounds.size.x
					local var_95_12 = var_95_6.sprite.bounds.size.y
					local var_95_13 = var_95_10 / var_95_11
					local var_95_14 = var_95_9 / var_95_12
					local var_95_15 = var_95_14 < var_95_13 and var_95_13 or var_95_14

					var_95_5.transform.localScale = Vector3.New(var_95_15, var_95_15, 0)
				end

				for iter_95_0, iter_95_1 in pairs(arg_92_1.bgs_) do
					if iter_95_0 ~= "D06a" then
						iter_95_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_95_16 = arg_92_1.bgs_.D06a
			local var_95_17 = 1.5

			if var_95_17 < arg_92_1.time_ and arg_92_1.time_ <= var_95_17 + arg_95_0 then
				local var_95_18 = var_95_16:GetComponent("SpriteRenderer")

				if var_95_18 then
					arg_92_1.var_.alphaOldValueD06a = var_95_18.color.a
					arg_92_1.var_.alphaMatValueD06a = var_95_18
				end

				arg_92_1.var_.alphaOldValueD06a = 0
			end

			local var_95_19 = 1.5

			if var_95_17 <= arg_92_1.time_ and arg_92_1.time_ < var_95_17 + var_95_19 then
				local var_95_20 = (arg_92_1.time_ - var_95_17) / var_95_19
				local var_95_21 = Mathf.Lerp(arg_92_1.var_.alphaOldValueD06a, 1, var_95_20)

				if arg_92_1.var_.alphaMatValueD06a then
					local var_95_22 = arg_92_1.var_.alphaMatValueD06a.color

					var_95_22.a = var_95_21
					arg_92_1.var_.alphaMatValueD06a.color = var_95_22
				end
			end

			if arg_92_1.time_ >= var_95_17 + var_95_19 and arg_92_1.time_ < var_95_17 + var_95_19 + arg_95_0 and arg_92_1.var_.alphaMatValueD06a then
				local var_95_23 = arg_92_1.var_.alphaMatValueD06a
				local var_95_24 = var_95_23.color

				var_95_24.a = 1
				var_95_23.color = var_95_24
			end

			local var_95_25 = arg_92_1.bgs_.D09
			local var_95_26 = 0

			if var_95_26 < arg_92_1.time_ and arg_92_1.time_ <= var_95_26 + arg_95_0 then
				local var_95_27 = var_95_25:GetComponent("SpriteRenderer")

				if var_95_27 then
					arg_92_1.var_.alphaOldValueD09 = var_95_27.color.a
					arg_92_1.var_.alphaMatValueD09 = var_95_27
				end

				arg_92_1.var_.alphaOldValueD09 = 1
			end

			local var_95_28 = 1.5

			if var_95_26 <= arg_92_1.time_ and arg_92_1.time_ < var_95_26 + var_95_28 then
				local var_95_29 = (arg_92_1.time_ - var_95_26) / var_95_28
				local var_95_30 = Mathf.Lerp(arg_92_1.var_.alphaOldValueD09, 0, var_95_29)

				if arg_92_1.var_.alphaMatValueD09 then
					local var_95_31 = arg_92_1.var_.alphaMatValueD09.color

					var_95_31.a = var_95_30
					arg_92_1.var_.alphaMatValueD09.color = var_95_31
				end
			end

			if arg_92_1.time_ >= var_95_26 + var_95_28 and arg_92_1.time_ < var_95_26 + var_95_28 + arg_95_0 and arg_92_1.var_.alphaMatValueD09 then
				local var_95_32 = arg_92_1.var_.alphaMatValueD09
				local var_95_33 = var_95_32.color

				var_95_33.a = 0
				var_95_32.color = var_95_33
			end

			local var_95_34 = 0

			if var_95_34 < arg_92_1.time_ and arg_92_1.time_ <= var_95_34 + arg_95_0 then
				arg_92_1.allBtn_.enabled = false
			end

			local var_95_35 = 3

			if arg_92_1.time_ >= var_95_34 + var_95_35 and arg_92_1.time_ < var_95_34 + var_95_35 + arg_95_0 then
				arg_92_1.allBtn_.enabled = true
			end

			if arg_92_1.frameCnt_ <= 1 then
				arg_92_1.dialog_:SetActive(false)
			end

			local var_95_36 = 3
			local var_95_37 = 0.925

			if var_95_36 < arg_92_1.time_ and arg_92_1.time_ <= var_95_36 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0

				arg_92_1.dialog_:SetActive(true)

				arg_92_1.dialogCg_.alpha = 0

				local var_95_38 = LeanTween.value(arg_92_1.dialog_, 0, 1, 0.3)

				var_95_38:setOnUpdate(LuaHelper.FloatAction(function(arg_96_0)
					arg_92_1.dialogCg_.alpha = arg_96_0
				end))
				var_95_38:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_92_1.dialog_)
					var_95_38:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_92_1.duration_ = arg_92_1.duration_ + 0.3

				SetActive(arg_92_1.leftNameGo_, false)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_39 = arg_92_1:GetWordFromCfg(111072023)
				local var_95_40 = arg_92_1:FormatText(var_95_39.content)

				arg_92_1.text_.text = var_95_40

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_41 = 37
				local var_95_42 = utf8.len(var_95_40)
				local var_95_43 = var_95_41 <= 0 and var_95_37 or var_95_37 * (var_95_42 / var_95_41)

				if var_95_43 > 0 and var_95_37 < var_95_43 then
					arg_92_1.talkMaxDuration = var_95_43
					var_95_36 = var_95_36 + 0.3

					if var_95_43 + var_95_36 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_43 + var_95_36
					end
				end

				arg_92_1.text_.text = var_95_40
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)
				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_44 = var_95_36 + 0.3
			local var_95_45 = math.max(var_95_37, arg_92_1.talkMaxDuration)

			if var_95_44 <= arg_92_1.time_ and arg_92_1.time_ < var_95_44 + var_95_45 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_44) / var_95_45

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_44 + var_95_45 and arg_92_1.time_ < var_95_44 + var_95_45 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {}

		arg_92_1:InitPlayNodeList()
	end,
	Play111072024 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 111072024
		arg_98_1.duration_ = 4.2

		local var_98_0 = {
			ja = 2.1,
			ko = 4.066,
			zh = 4.2,
			en = 2.8
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
				arg_98_0:Play111072025(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			local var_101_0 = "1048ui_story"

			if arg_98_1.actors_[var_101_0] == nil then
				local var_101_1 = Asset.Load("Char/" .. "1048ui_story")

				if not isNil(var_101_1) then
					local var_101_2 = Object.Instantiate(Asset.Load("Char/" .. "1048ui_story"), arg_98_1.stage_.transform)

					var_101_2.name = var_101_0
					var_101_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_98_1.actors_[var_101_0] = var_101_2

					local var_101_3 = var_101_2:GetComponentInChildren(typeof(CharacterEffect))

					var_101_3.enabled = true

					local var_101_4 = GameObjectTools.GetOrAddComponent(var_101_2, typeof(DynamicBoneHelper))

					if var_101_4 then
						var_101_4:EnableDynamicBone(false)
					end

					arg_98_1:ShowWeapon(var_101_3.transform, false)

					arg_98_1.var_[var_101_0 .. "Animator"] = var_101_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_98_1.var_[var_101_0 .. "Animator"].applyRootMotion = true
					arg_98_1.var_[var_101_0 .. "LipSync"] = var_101_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_101_5 = arg_98_1.actors_["1048ui_story"].transform
			local var_101_6 = 0

			if var_101_6 < arg_98_1.time_ and arg_98_1.time_ <= var_101_6 + arg_101_0 then
				arg_98_1.var_.moveOldPos1048ui_story = var_101_5.localPosition
			end

			local var_101_7 = 0.001

			if var_101_6 <= arg_98_1.time_ and arg_98_1.time_ < var_101_6 + var_101_7 then
				local var_101_8 = (arg_98_1.time_ - var_101_6) / var_101_7
				local var_101_9 = Vector3.New(-0.7, -0.8, -6.2)

				var_101_5.localPosition = Vector3.Lerp(arg_98_1.var_.moveOldPos1048ui_story, var_101_9, var_101_8)

				local var_101_10 = manager.ui.mainCamera.transform.position - var_101_5.position

				var_101_5.forward = Vector3.New(var_101_10.x, var_101_10.y, var_101_10.z)

				local var_101_11 = var_101_5.localEulerAngles

				var_101_11.z = 0
				var_101_11.x = 0
				var_101_5.localEulerAngles = var_101_11
			end

			if arg_98_1.time_ >= var_101_6 + var_101_7 and arg_98_1.time_ < var_101_6 + var_101_7 + arg_101_0 then
				var_101_5.localPosition = Vector3.New(-0.7, -0.8, -6.2)

				local var_101_12 = manager.ui.mainCamera.transform.position - var_101_5.position

				var_101_5.forward = Vector3.New(var_101_12.x, var_101_12.y, var_101_12.z)

				local var_101_13 = var_101_5.localEulerAngles

				var_101_13.z = 0
				var_101_13.x = 0
				var_101_5.localEulerAngles = var_101_13
			end

			local var_101_14 = 0

			if var_101_14 < arg_98_1.time_ and arg_98_1.time_ <= var_101_14 + arg_101_0 then
				arg_98_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/story1048/story1048action/1048action9_1")
			end

			local var_101_15 = 0

			if var_101_15 < arg_98_1.time_ and arg_98_1.time_ <= var_101_15 + arg_101_0 then
				arg_98_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_101_16 = arg_98_1.actors_["1048ui_story"]
			local var_101_17 = 0

			if var_101_17 < arg_98_1.time_ and arg_98_1.time_ <= var_101_17 + arg_101_0 and not isNil(var_101_16) and arg_98_1.var_.characterEffect1048ui_story == nil then
				arg_98_1.var_.characterEffect1048ui_story = var_101_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_101_18 = 0.2

			if var_101_17 <= arg_98_1.time_ and arg_98_1.time_ < var_101_17 + var_101_18 and not isNil(var_101_16) then
				local var_101_19 = (arg_98_1.time_ - var_101_17) / var_101_18

				if arg_98_1.var_.characterEffect1048ui_story and not isNil(var_101_16) then
					arg_98_1.var_.characterEffect1048ui_story.fillFlat = false
				end
			end

			if arg_98_1.time_ >= var_101_17 + var_101_18 and arg_98_1.time_ < var_101_17 + var_101_18 + arg_101_0 and not isNil(var_101_16) and arg_98_1.var_.characterEffect1048ui_story then
				arg_98_1.var_.characterEffect1048ui_story.fillFlat = false
			end

			local var_101_20 = 0
			local var_101_21 = 0.3

			if var_101_20 < arg_98_1.time_ and arg_98_1.time_ <= var_101_20 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				local var_101_22 = arg_98_1:FormatText(StoryNameCfg[8].name)

				arg_98_1.leftNameTxt_.text = var_101_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_23 = arg_98_1:GetWordFromCfg(111072024)
				local var_101_24 = arg_98_1:FormatText(var_101_23.content)

				arg_98_1.text_.text = var_101_24

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_25 = 12
				local var_101_26 = utf8.len(var_101_24)
				local var_101_27 = var_101_25 <= 0 and var_101_21 or var_101_21 * (var_101_26 / var_101_25)

				if var_101_27 > 0 and var_101_21 < var_101_27 then
					arg_98_1.talkMaxDuration = var_101_27

					if var_101_27 + var_101_20 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_27 + var_101_20
					end
				end

				arg_98_1.text_.text = var_101_24
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111072", "111072024", "story_v_out_111072.awb") ~= 0 then
					local var_101_28 = manager.audio:GetVoiceLength("story_v_out_111072", "111072024", "story_v_out_111072.awb") / 1000

					if var_101_28 + var_101_20 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_28 + var_101_20
					end

					if var_101_23.prefab_name ~= "" and arg_98_1.actors_[var_101_23.prefab_name] ~= nil then
						local var_101_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_98_1.actors_[var_101_23.prefab_name].transform, "story_v_out_111072", "111072024", "story_v_out_111072.awb")

						arg_98_1:RecordAudio("111072024", var_101_29)
						arg_98_1:RecordAudio("111072024", var_101_29)
					else
						arg_98_1:AudioAction("play", "voice", "story_v_out_111072", "111072024", "story_v_out_111072.awb")
					end

					arg_98_1:RecordHistoryTalkVoice("story_v_out_111072", "111072024", "story_v_out_111072.awb")
				end

				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_30 = math.max(var_101_21, arg_98_1.talkMaxDuration)

			if var_101_20 <= arg_98_1.time_ and arg_98_1.time_ < var_101_20 + var_101_30 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_20) / var_101_30

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_20 + var_101_30 and arg_98_1.time_ < var_101_20 + var_101_30 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1048ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_98_1:InitPlayNodeList()
	end,
	Play111072025 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 111072025
		arg_102_1.duration_ = 6.23

		local var_102_0 = {
			ja = 6.233,
			ko = 2.833,
			zh = 1.999999999999,
			en = 2.633
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
				arg_102_0:Play111072026(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			local var_105_0 = "1039ui_story"

			if arg_102_1.actors_[var_105_0] == nil then
				local var_105_1 = Asset.Load("Char/" .. "1039ui_story")

				if not isNil(var_105_1) then
					local var_105_2 = Object.Instantiate(Asset.Load("Char/" .. "1039ui_story"), arg_102_1.stage_.transform)

					var_105_2.name = var_105_0
					var_105_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_102_1.actors_[var_105_0] = var_105_2

					local var_105_3 = var_105_2:GetComponentInChildren(typeof(CharacterEffect))

					var_105_3.enabled = true

					local var_105_4 = GameObjectTools.GetOrAddComponent(var_105_2, typeof(DynamicBoneHelper))

					if var_105_4 then
						var_105_4:EnableDynamicBone(false)
					end

					arg_102_1:ShowWeapon(var_105_3.transform, false)

					arg_102_1.var_[var_105_0 .. "Animator"] = var_105_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_102_1.var_[var_105_0 .. "Animator"].applyRootMotion = true
					arg_102_1.var_[var_105_0 .. "LipSync"] = var_105_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_105_5 = arg_102_1.actors_["1039ui_story"].transform
			local var_105_6 = 0

			if var_105_6 < arg_102_1.time_ and arg_102_1.time_ <= var_105_6 + arg_105_0 then
				arg_102_1.var_.moveOldPos1039ui_story = var_105_5.localPosition
			end

			local var_105_7 = 0.001

			if var_105_6 <= arg_102_1.time_ and arg_102_1.time_ < var_105_6 + var_105_7 then
				local var_105_8 = (arg_102_1.time_ - var_105_6) / var_105_7
				local var_105_9 = Vector3.New(0.7, -1.01, -5.9)

				var_105_5.localPosition = Vector3.Lerp(arg_102_1.var_.moveOldPos1039ui_story, var_105_9, var_105_8)

				local var_105_10 = manager.ui.mainCamera.transform.position - var_105_5.position

				var_105_5.forward = Vector3.New(var_105_10.x, var_105_10.y, var_105_10.z)

				local var_105_11 = var_105_5.localEulerAngles

				var_105_11.z = 0
				var_105_11.x = 0
				var_105_5.localEulerAngles = var_105_11
			end

			if arg_102_1.time_ >= var_105_6 + var_105_7 and arg_102_1.time_ < var_105_6 + var_105_7 + arg_105_0 then
				var_105_5.localPosition = Vector3.New(0.7, -1.01, -5.9)

				local var_105_12 = manager.ui.mainCamera.transform.position - var_105_5.position

				var_105_5.forward = Vector3.New(var_105_12.x, var_105_12.y, var_105_12.z)

				local var_105_13 = var_105_5.localEulerAngles

				var_105_13.z = 0
				var_105_13.x = 0
				var_105_5.localEulerAngles = var_105_13
			end

			local var_105_14 = 0

			if var_105_14 < arg_102_1.time_ and arg_102_1.time_ <= var_105_14 + arg_105_0 then
				arg_102_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action5_1")
			end

			local var_105_15 = 0

			if var_105_15 < arg_102_1.time_ and arg_102_1.time_ <= var_105_15 + arg_105_0 then
				arg_102_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2204cva")
			end

			local var_105_16 = arg_102_1.actors_["1039ui_story"]
			local var_105_17 = 0

			if var_105_17 < arg_102_1.time_ and arg_102_1.time_ <= var_105_17 + arg_105_0 and not isNil(var_105_16) and arg_102_1.var_.characterEffect1039ui_story == nil then
				arg_102_1.var_.characterEffect1039ui_story = var_105_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_105_18 = 0.2

			if var_105_17 <= arg_102_1.time_ and arg_102_1.time_ < var_105_17 + var_105_18 and not isNil(var_105_16) then
				local var_105_19 = (arg_102_1.time_ - var_105_17) / var_105_18

				if arg_102_1.var_.characterEffect1039ui_story and not isNil(var_105_16) then
					arg_102_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_102_1.time_ >= var_105_17 + var_105_18 and arg_102_1.time_ < var_105_17 + var_105_18 + arg_105_0 and not isNil(var_105_16) and arg_102_1.var_.characterEffect1039ui_story then
				arg_102_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_105_20 = arg_102_1.actors_["1048ui_story"]
			local var_105_21 = 0

			if var_105_21 < arg_102_1.time_ and arg_102_1.time_ <= var_105_21 + arg_105_0 and not isNil(var_105_20) and arg_102_1.var_.characterEffect1048ui_story == nil then
				arg_102_1.var_.characterEffect1048ui_story = var_105_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_105_22 = 0.2

			if var_105_21 <= arg_102_1.time_ and arg_102_1.time_ < var_105_21 + var_105_22 and not isNil(var_105_20) then
				local var_105_23 = (arg_102_1.time_ - var_105_21) / var_105_22

				if arg_102_1.var_.characterEffect1048ui_story and not isNil(var_105_20) then
					local var_105_24 = Mathf.Lerp(0, 0.5, var_105_23)

					arg_102_1.var_.characterEffect1048ui_story.fillFlat = true
					arg_102_1.var_.characterEffect1048ui_story.fillRatio = var_105_24
				end
			end

			if arg_102_1.time_ >= var_105_21 + var_105_22 and arg_102_1.time_ < var_105_21 + var_105_22 + arg_105_0 and not isNil(var_105_20) and arg_102_1.var_.characterEffect1048ui_story then
				local var_105_25 = 0.5

				arg_102_1.var_.characterEffect1048ui_story.fillFlat = true
				arg_102_1.var_.characterEffect1048ui_story.fillRatio = var_105_25
			end

			local var_105_26 = 0
			local var_105_27 = 0.225

			if var_105_26 < arg_102_1.time_ and arg_102_1.time_ <= var_105_26 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				local var_105_28 = arg_102_1:FormatText(StoryNameCfg[9].name)

				arg_102_1.leftNameTxt_.text = var_105_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_29 = arg_102_1:GetWordFromCfg(111072025)
				local var_105_30 = arg_102_1:FormatText(var_105_29.content)

				arg_102_1.text_.text = var_105_30

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_31 = 9
				local var_105_32 = utf8.len(var_105_30)
				local var_105_33 = var_105_31 <= 0 and var_105_27 or var_105_27 * (var_105_32 / var_105_31)

				if var_105_33 > 0 and var_105_27 < var_105_33 then
					arg_102_1.talkMaxDuration = var_105_33

					if var_105_33 + var_105_26 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_33 + var_105_26
					end
				end

				arg_102_1.text_.text = var_105_30
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111072", "111072025", "story_v_out_111072.awb") ~= 0 then
					local var_105_34 = manager.audio:GetVoiceLength("story_v_out_111072", "111072025", "story_v_out_111072.awb") / 1000

					if var_105_34 + var_105_26 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_34 + var_105_26
					end

					if var_105_29.prefab_name ~= "" and arg_102_1.actors_[var_105_29.prefab_name] ~= nil then
						local var_105_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_102_1.actors_[var_105_29.prefab_name].transform, "story_v_out_111072", "111072025", "story_v_out_111072.awb")

						arg_102_1:RecordAudio("111072025", var_105_35)
						arg_102_1:RecordAudio("111072025", var_105_35)
					else
						arg_102_1:AudioAction("play", "voice", "story_v_out_111072", "111072025", "story_v_out_111072.awb")
					end

					arg_102_1:RecordHistoryTalkVoice("story_v_out_111072", "111072025", "story_v_out_111072.awb")
				end

				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_36 = math.max(var_105_27, arg_102_1.talkMaxDuration)

			if var_105_26 <= arg_102_1.time_ and arg_102_1.time_ < var_105_26 + var_105_36 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_26) / var_105_36

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_26 + var_105_36 and arg_102_1.time_ < var_105_26 + var_105_36 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_102_1:InitPlayNodeList()
	end,
	Play111072026 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 111072026
		arg_106_1.duration_ = 5

		SetActive(arg_106_1.tipsGo_, false)

		function arg_106_1.onSingleLineFinish_()
			arg_106_1.onSingleLineUpdate_ = nil
			arg_106_1.onSingleLineFinish_ = nil
			arg_106_1.state_ = "waiting"
		end

		function arg_106_1.playNext_(arg_108_0)
			if arg_108_0 == 1 then
				arg_106_0:Play111072027(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			local var_109_0 = 0
			local var_109_1 = 0.65

			if var_109_0 < arg_106_1.time_ and arg_106_1.time_ <= var_109_0 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, false)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_2 = arg_106_1:GetWordFromCfg(111072026)
				local var_109_3 = arg_106_1:FormatText(var_109_2.content)

				arg_106_1.text_.text = var_109_3

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_4 = 26
				local var_109_5 = utf8.len(var_109_3)
				local var_109_6 = var_109_4 <= 0 and var_109_1 or var_109_1 * (var_109_5 / var_109_4)

				if var_109_6 > 0 and var_109_1 < var_109_6 then
					arg_106_1.talkMaxDuration = var_109_6

					if var_109_6 + var_109_0 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_6 + var_109_0
					end
				end

				arg_106_1.text_.text = var_109_3
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)
				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_7 = math.max(var_109_1, arg_106_1.talkMaxDuration)

			if var_109_0 <= arg_106_1.time_ and arg_106_1.time_ < var_109_0 + var_109_7 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_0) / var_109_7

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_0 + var_109_7 and arg_106_1.time_ < var_109_0 + var_109_7 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {}

		arg_106_1:InitPlayNodeList()
	end,
	Play111072027 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 111072027
		arg_110_1.duration_ = 5

		SetActive(arg_110_1.tipsGo_, false)

		function arg_110_1.onSingleLineFinish_()
			arg_110_1.onSingleLineUpdate_ = nil
			arg_110_1.onSingleLineFinish_ = nil
			arg_110_1.state_ = "waiting"
		end

		function arg_110_1.playNext_(arg_112_0)
			if arg_112_0 == 1 then
				arg_110_0:Play111072028(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			local var_113_0 = 0
			local var_113_1 = 0.8

			if var_113_0 < arg_110_1.time_ and arg_110_1.time_ <= var_113_0 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				local var_113_2 = arg_110_1:FormatText(StoryNameCfg[7].name)

				arg_110_1.leftNameTxt_.text = var_113_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, true)
				arg_110_1.iconController_:SetSelectedState("hero")

				arg_110_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_110_1.callingController_:SetSelectedState("normal")

				arg_110_1.keyicon_.color = Color.New(1, 1, 1)
				arg_110_1.icon_.color = Color.New(1, 1, 1)

				local var_113_3 = arg_110_1:GetWordFromCfg(111072027)
				local var_113_4 = arg_110_1:FormatText(var_113_3.content)

				arg_110_1.text_.text = var_113_4

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_5 = 32
				local var_113_6 = utf8.len(var_113_4)
				local var_113_7 = var_113_5 <= 0 and var_113_1 or var_113_1 * (var_113_6 / var_113_5)

				if var_113_7 > 0 and var_113_1 < var_113_7 then
					arg_110_1.talkMaxDuration = var_113_7

					if var_113_7 + var_113_0 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_7 + var_113_0
					end
				end

				arg_110_1.text_.text = var_113_4
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)
				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_8 = math.max(var_113_1, arg_110_1.talkMaxDuration)

			if var_113_0 <= arg_110_1.time_ and arg_110_1.time_ < var_113_0 + var_113_8 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_0) / var_113_8

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_0 + var_113_8 and arg_110_1.time_ < var_113_0 + var_113_8 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {}

		arg_110_1:InitPlayNodeList()
	end,
	Play111072028 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 111072028
		arg_114_1.duration_ = 5

		SetActive(arg_114_1.tipsGo_, false)

		function arg_114_1.onSingleLineFinish_()
			arg_114_1.onSingleLineUpdate_ = nil
			arg_114_1.onSingleLineFinish_ = nil
			arg_114_1.state_ = "waiting"
		end

		function arg_114_1.playNext_(arg_116_0)
			if arg_116_0 == 1 then
				arg_114_0:Play111072029(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			local var_117_0 = 0
			local var_117_1 = 0.975

			if var_117_0 < arg_114_1.time_ and arg_114_1.time_ <= var_117_0 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, false)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_114_1.iconTrs_.gameObject, false)
				arg_114_1.callingController_:SetSelectedState("normal")

				local var_117_2 = arg_114_1:GetWordFromCfg(111072028)
				local var_117_3 = arg_114_1:FormatText(var_117_2.content)

				arg_114_1.text_.text = var_117_3

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_4 = 39
				local var_117_5 = utf8.len(var_117_3)
				local var_117_6 = var_117_4 <= 0 and var_117_1 or var_117_1 * (var_117_5 / var_117_4)

				if var_117_6 > 0 and var_117_1 < var_117_6 then
					arg_114_1.talkMaxDuration = var_117_6

					if var_117_6 + var_117_0 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_6 + var_117_0
					end
				end

				arg_114_1.text_.text = var_117_3
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)
				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_7 = math.max(var_117_1, arg_114_1.talkMaxDuration)

			if var_117_0 <= arg_114_1.time_ and arg_114_1.time_ < var_117_0 + var_117_7 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - var_117_0) / var_117_7

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= var_117_0 + var_117_7 and arg_114_1.time_ < var_117_0 + var_117_7 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {}

		arg_114_1:InitPlayNodeList()
	end,
	Play111072029 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 111072029
		arg_118_1.duration_ = 9.77

		local var_118_0 = {
			ja = 3.233,
			ko = 8.266,
			zh = 9.766,
			en = 7.8
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
				arg_118_0:Play111072030(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			local var_121_0 = 0

			if var_121_0 < arg_118_1.time_ and arg_118_1.time_ <= var_121_0 + arg_121_0 then
				arg_118_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039actionlink/1039action453")
			end

			local var_121_1 = 0

			if var_121_1 < arg_118_1.time_ and arg_118_1.time_ <= var_121_1 + arg_121_0 then
				arg_118_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_121_2 = arg_118_1.actors_["1039ui_story"]
			local var_121_3 = 0

			if var_121_3 < arg_118_1.time_ and arg_118_1.time_ <= var_121_3 + arg_121_0 and not isNil(var_121_2) and arg_118_1.var_.characterEffect1039ui_story == nil then
				arg_118_1.var_.characterEffect1039ui_story = var_121_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_121_4 = 0.2

			if var_121_3 <= arg_118_1.time_ and arg_118_1.time_ < var_121_3 + var_121_4 and not isNil(var_121_2) then
				local var_121_5 = (arg_118_1.time_ - var_121_3) / var_121_4

				if arg_118_1.var_.characterEffect1039ui_story and not isNil(var_121_2) then
					arg_118_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_118_1.time_ >= var_121_3 + var_121_4 and arg_118_1.time_ < var_121_3 + var_121_4 + arg_121_0 and not isNil(var_121_2) and arg_118_1.var_.characterEffect1039ui_story then
				arg_118_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_121_6 = 0
			local var_121_7 = 0.825

			if var_121_6 < arg_118_1.time_ and arg_118_1.time_ <= var_121_6 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, true)

				local var_121_8 = arg_118_1:FormatText(StoryNameCfg[9].name)

				arg_118_1.leftNameTxt_.text = var_121_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_118_1.leftNameTxt_.transform)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1.leftNameTxt_.text)
				SetActive(arg_118_1.iconTrs_.gameObject, false)
				arg_118_1.callingController_:SetSelectedState("normal")

				local var_121_9 = arg_118_1:GetWordFromCfg(111072029)
				local var_121_10 = arg_118_1:FormatText(var_121_9.content)

				arg_118_1.text_.text = var_121_10

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_11 = 33
				local var_121_12 = utf8.len(var_121_10)
				local var_121_13 = var_121_11 <= 0 and var_121_7 or var_121_7 * (var_121_12 / var_121_11)

				if var_121_13 > 0 and var_121_7 < var_121_13 then
					arg_118_1.talkMaxDuration = var_121_13

					if var_121_13 + var_121_6 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_13 + var_121_6
					end
				end

				arg_118_1.text_.text = var_121_10
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111072", "111072029", "story_v_out_111072.awb") ~= 0 then
					local var_121_14 = manager.audio:GetVoiceLength("story_v_out_111072", "111072029", "story_v_out_111072.awb") / 1000

					if var_121_14 + var_121_6 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_14 + var_121_6
					end

					if var_121_9.prefab_name ~= "" and arg_118_1.actors_[var_121_9.prefab_name] ~= nil then
						local var_121_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_118_1.actors_[var_121_9.prefab_name].transform, "story_v_out_111072", "111072029", "story_v_out_111072.awb")

						arg_118_1:RecordAudio("111072029", var_121_15)
						arg_118_1:RecordAudio("111072029", var_121_15)
					else
						arg_118_1:AudioAction("play", "voice", "story_v_out_111072", "111072029", "story_v_out_111072.awb")
					end

					arg_118_1:RecordHistoryTalkVoice("story_v_out_111072", "111072029", "story_v_out_111072.awb")
				end

				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_16 = math.max(var_121_7, arg_118_1.talkMaxDuration)

			if var_121_6 <= arg_118_1.time_ and arg_118_1.time_ < var_121_6 + var_121_16 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - var_121_6) / var_121_16

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= var_121_6 + var_121_16 and arg_118_1.time_ < var_121_6 + var_121_16 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {}

		arg_118_1:InitPlayNodeList()
	end,
	Play111072030 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 111072030
		arg_122_1.duration_ = 6

		local var_122_0 = {
			ja = 5.966,
			ko = 5.566,
			zh = 4.466,
			en = 6
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
				arg_122_0:Play111072031(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			local var_125_0 = 0

			if var_125_0 < arg_122_1.time_ and arg_122_1.time_ <= var_125_0 + arg_125_0 then
				arg_122_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/story1048/story1048actionlink/1048action493")
			end

			local var_125_1 = 0

			if var_125_1 < arg_122_1.time_ and arg_122_1.time_ <= var_125_1 + arg_125_0 then
				arg_122_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_125_2 = arg_122_1.actors_["1048ui_story"]
			local var_125_3 = 0

			if var_125_3 < arg_122_1.time_ and arg_122_1.time_ <= var_125_3 + arg_125_0 and not isNil(var_125_2) and arg_122_1.var_.characterEffect1048ui_story == nil then
				arg_122_1.var_.characterEffect1048ui_story = var_125_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_125_4 = 0.2

			if var_125_3 <= arg_122_1.time_ and arg_122_1.time_ < var_125_3 + var_125_4 and not isNil(var_125_2) then
				local var_125_5 = (arg_122_1.time_ - var_125_3) / var_125_4

				if arg_122_1.var_.characterEffect1048ui_story and not isNil(var_125_2) then
					arg_122_1.var_.characterEffect1048ui_story.fillFlat = false
				end
			end

			if arg_122_1.time_ >= var_125_3 + var_125_4 and arg_122_1.time_ < var_125_3 + var_125_4 + arg_125_0 and not isNil(var_125_2) and arg_122_1.var_.characterEffect1048ui_story then
				arg_122_1.var_.characterEffect1048ui_story.fillFlat = false
			end

			local var_125_6 = arg_122_1.actors_["1039ui_story"]
			local var_125_7 = 0

			if var_125_7 < arg_122_1.time_ and arg_122_1.time_ <= var_125_7 + arg_125_0 and not isNil(var_125_6) and arg_122_1.var_.characterEffect1039ui_story == nil then
				arg_122_1.var_.characterEffect1039ui_story = var_125_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_125_8 = 0.2

			if var_125_7 <= arg_122_1.time_ and arg_122_1.time_ < var_125_7 + var_125_8 and not isNil(var_125_6) then
				local var_125_9 = (arg_122_1.time_ - var_125_7) / var_125_8

				if arg_122_1.var_.characterEffect1039ui_story and not isNil(var_125_6) then
					local var_125_10 = Mathf.Lerp(0, 0.5, var_125_9)

					arg_122_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_122_1.var_.characterEffect1039ui_story.fillRatio = var_125_10
				end
			end

			if arg_122_1.time_ >= var_125_7 + var_125_8 and arg_122_1.time_ < var_125_7 + var_125_8 + arg_125_0 and not isNil(var_125_6) and arg_122_1.var_.characterEffect1039ui_story then
				local var_125_11 = 0.5

				arg_122_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_122_1.var_.characterEffect1039ui_story.fillRatio = var_125_11
			end

			local var_125_12 = 0
			local var_125_13 = 0.5

			if var_125_12 < arg_122_1.time_ and arg_122_1.time_ <= var_125_12 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, true)

				local var_125_14 = arg_122_1:FormatText(StoryNameCfg[8].name)

				arg_122_1.leftNameTxt_.text = var_125_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_122_1.leftNameTxt_.transform)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1.leftNameTxt_.text)
				SetActive(arg_122_1.iconTrs_.gameObject, false)
				arg_122_1.callingController_:SetSelectedState("normal")

				local var_125_15 = arg_122_1:GetWordFromCfg(111072030)
				local var_125_16 = arg_122_1:FormatText(var_125_15.content)

				arg_122_1.text_.text = var_125_16

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_17 = 20
				local var_125_18 = utf8.len(var_125_16)
				local var_125_19 = var_125_17 <= 0 and var_125_13 or var_125_13 * (var_125_18 / var_125_17)

				if var_125_19 > 0 and var_125_13 < var_125_19 then
					arg_122_1.talkMaxDuration = var_125_19

					if var_125_19 + var_125_12 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_19 + var_125_12
					end
				end

				arg_122_1.text_.text = var_125_16
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111072", "111072030", "story_v_out_111072.awb") ~= 0 then
					local var_125_20 = manager.audio:GetVoiceLength("story_v_out_111072", "111072030", "story_v_out_111072.awb") / 1000

					if var_125_20 + var_125_12 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_20 + var_125_12
					end

					if var_125_15.prefab_name ~= "" and arg_122_1.actors_[var_125_15.prefab_name] ~= nil then
						local var_125_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_122_1.actors_[var_125_15.prefab_name].transform, "story_v_out_111072", "111072030", "story_v_out_111072.awb")

						arg_122_1:RecordAudio("111072030", var_125_21)
						arg_122_1:RecordAudio("111072030", var_125_21)
					else
						arg_122_1:AudioAction("play", "voice", "story_v_out_111072", "111072030", "story_v_out_111072.awb")
					end

					arg_122_1:RecordHistoryTalkVoice("story_v_out_111072", "111072030", "story_v_out_111072.awb")
				end

				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_22 = math.max(var_125_13, arg_122_1.talkMaxDuration)

			if var_125_12 <= arg_122_1.time_ and arg_122_1.time_ < var_125_12 + var_125_22 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_12) / var_125_22

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_12 + var_125_22 and arg_122_1.time_ < var_125_12 + var_125_22 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {}

		arg_122_1:InitPlayNodeList()
	end,
	Play111072031 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 111072031
		arg_126_1.duration_ = 4.57

		local var_126_0 = {
			ja = 4.566,
			ko = 3.633,
			zh = 3.3,
			en = 3.333
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
				arg_126_0:Play111072032(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			local var_129_0 = "1084ui_story"

			if arg_126_1.actors_[var_129_0] == nil then
				local var_129_1 = Asset.Load("Char/" .. "1084ui_story")

				if not isNil(var_129_1) then
					local var_129_2 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_126_1.stage_.transform)

					var_129_2.name = var_129_0
					var_129_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_126_1.actors_[var_129_0] = var_129_2

					local var_129_3 = var_129_2:GetComponentInChildren(typeof(CharacterEffect))

					var_129_3.enabled = true

					local var_129_4 = GameObjectTools.GetOrAddComponent(var_129_2, typeof(DynamicBoneHelper))

					if var_129_4 then
						var_129_4:EnableDynamicBone(false)
					end

					arg_126_1:ShowWeapon(var_129_3.transform, false)

					arg_126_1.var_[var_129_0 .. "Animator"] = var_129_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_126_1.var_[var_129_0 .. "Animator"].applyRootMotion = true
					arg_126_1.var_[var_129_0 .. "LipSync"] = var_129_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_129_5 = arg_126_1.actors_["1084ui_story"].transform
			local var_129_6 = 0

			if var_129_6 < arg_126_1.time_ and arg_126_1.time_ <= var_129_6 + arg_129_0 then
				arg_126_1.var_.moveOldPos1084ui_story = var_129_5.localPosition
			end

			local var_129_7 = 0.001

			if var_129_6 <= arg_126_1.time_ and arg_126_1.time_ < var_129_6 + var_129_7 then
				local var_129_8 = (arg_126_1.time_ - var_129_6) / var_129_7
				local var_129_9 = Vector3.New(-0.7, -0.97, -6)

				var_129_5.localPosition = Vector3.Lerp(arg_126_1.var_.moveOldPos1084ui_story, var_129_9, var_129_8)

				local var_129_10 = manager.ui.mainCamera.transform.position - var_129_5.position

				var_129_5.forward = Vector3.New(var_129_10.x, var_129_10.y, var_129_10.z)

				local var_129_11 = var_129_5.localEulerAngles

				var_129_11.z = 0
				var_129_11.x = 0
				var_129_5.localEulerAngles = var_129_11
			end

			if arg_126_1.time_ >= var_129_6 + var_129_7 and arg_126_1.time_ < var_129_6 + var_129_7 + arg_129_0 then
				var_129_5.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_129_12 = manager.ui.mainCamera.transform.position - var_129_5.position

				var_129_5.forward = Vector3.New(var_129_12.x, var_129_12.y, var_129_12.z)

				local var_129_13 = var_129_5.localEulerAngles

				var_129_13.z = 0
				var_129_13.x = 0
				var_129_5.localEulerAngles = var_129_13
			end

			local var_129_14 = 0

			if var_129_14 < arg_126_1.time_ and arg_126_1.time_ <= var_129_14 + arg_129_0 then
				arg_126_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			local var_129_15 = 0

			if var_129_15 < arg_126_1.time_ and arg_126_1.time_ <= var_129_15 + arg_129_0 then
				arg_126_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_129_16 = arg_126_1.actors_["1084ui_story"]
			local var_129_17 = 0

			if var_129_17 < arg_126_1.time_ and arg_126_1.time_ <= var_129_17 + arg_129_0 and not isNil(var_129_16) and arg_126_1.var_.characterEffect1084ui_story == nil then
				arg_126_1.var_.characterEffect1084ui_story = var_129_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_129_18 = 0.2

			if var_129_17 <= arg_126_1.time_ and arg_126_1.time_ < var_129_17 + var_129_18 and not isNil(var_129_16) then
				local var_129_19 = (arg_126_1.time_ - var_129_17) / var_129_18

				if arg_126_1.var_.characterEffect1084ui_story and not isNil(var_129_16) then
					arg_126_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_126_1.time_ >= var_129_17 + var_129_18 and arg_126_1.time_ < var_129_17 + var_129_18 + arg_129_0 and not isNil(var_129_16) and arg_126_1.var_.characterEffect1084ui_story then
				arg_126_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_129_20 = arg_126_1.actors_["1048ui_story"]
			local var_129_21 = 0

			if var_129_21 < arg_126_1.time_ and arg_126_1.time_ <= var_129_21 + arg_129_0 and not isNil(var_129_20) and arg_126_1.var_.characterEffect1048ui_story == nil then
				arg_126_1.var_.characterEffect1048ui_story = var_129_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_129_22 = 0.2

			if var_129_21 <= arg_126_1.time_ and arg_126_1.time_ < var_129_21 + var_129_22 and not isNil(var_129_20) then
				local var_129_23 = (arg_126_1.time_ - var_129_21) / var_129_22

				if arg_126_1.var_.characterEffect1048ui_story and not isNil(var_129_20) then
					local var_129_24 = Mathf.Lerp(0, 0.5, var_129_23)

					arg_126_1.var_.characterEffect1048ui_story.fillFlat = true
					arg_126_1.var_.characterEffect1048ui_story.fillRatio = var_129_24
				end
			end

			if arg_126_1.time_ >= var_129_21 + var_129_22 and arg_126_1.time_ < var_129_21 + var_129_22 + arg_129_0 and not isNil(var_129_20) and arg_126_1.var_.characterEffect1048ui_story then
				local var_129_25 = 0.5

				arg_126_1.var_.characterEffect1048ui_story.fillFlat = true
				arg_126_1.var_.characterEffect1048ui_story.fillRatio = var_129_25
			end

			local var_129_26 = arg_126_1.actors_["1048ui_story"].transform
			local var_129_27 = 0

			if var_129_27 < arg_126_1.time_ and arg_126_1.time_ <= var_129_27 + arg_129_0 then
				arg_126_1.var_.moveOldPos1048ui_story = var_129_26.localPosition
			end

			local var_129_28 = 0.001

			if var_129_27 <= arg_126_1.time_ and arg_126_1.time_ < var_129_27 + var_129_28 then
				local var_129_29 = (arg_126_1.time_ - var_129_27) / var_129_28
				local var_129_30 = Vector3.New(0, 100, 0)

				var_129_26.localPosition = Vector3.Lerp(arg_126_1.var_.moveOldPos1048ui_story, var_129_30, var_129_29)

				local var_129_31 = manager.ui.mainCamera.transform.position - var_129_26.position

				var_129_26.forward = Vector3.New(var_129_31.x, var_129_31.y, var_129_31.z)

				local var_129_32 = var_129_26.localEulerAngles

				var_129_32.z = 0
				var_129_32.x = 0
				var_129_26.localEulerAngles = var_129_32
			end

			if arg_126_1.time_ >= var_129_27 + var_129_28 and arg_126_1.time_ < var_129_27 + var_129_28 + arg_129_0 then
				var_129_26.localPosition = Vector3.New(0, 100, 0)

				local var_129_33 = manager.ui.mainCamera.transform.position - var_129_26.position

				var_129_26.forward = Vector3.New(var_129_33.x, var_129_33.y, var_129_33.z)

				local var_129_34 = var_129_26.localEulerAngles

				var_129_34.z = 0
				var_129_34.x = 0
				var_129_26.localEulerAngles = var_129_34
			end

			local var_129_35 = 0
			local var_129_36 = 0.35

			if var_129_35 < arg_126_1.time_ and arg_126_1.time_ <= var_129_35 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, true)

				local var_129_37 = arg_126_1:FormatText(StoryNameCfg[6].name)

				arg_126_1.leftNameTxt_.text = var_129_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_126_1.leftNameTxt_.transform)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1.leftNameTxt_.text)
				SetActive(arg_126_1.iconTrs_.gameObject, false)
				arg_126_1.callingController_:SetSelectedState("normal")

				local var_129_38 = arg_126_1:GetWordFromCfg(111072031)
				local var_129_39 = arg_126_1:FormatText(var_129_38.content)

				arg_126_1.text_.text = var_129_39

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_40 = 14
				local var_129_41 = utf8.len(var_129_39)
				local var_129_42 = var_129_40 <= 0 and var_129_36 or var_129_36 * (var_129_41 / var_129_40)

				if var_129_42 > 0 and var_129_36 < var_129_42 then
					arg_126_1.talkMaxDuration = var_129_42

					if var_129_42 + var_129_35 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_42 + var_129_35
					end
				end

				arg_126_1.text_.text = var_129_39
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111072", "111072031", "story_v_out_111072.awb") ~= 0 then
					local var_129_43 = manager.audio:GetVoiceLength("story_v_out_111072", "111072031", "story_v_out_111072.awb") / 1000

					if var_129_43 + var_129_35 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_43 + var_129_35
					end

					if var_129_38.prefab_name ~= "" and arg_126_1.actors_[var_129_38.prefab_name] ~= nil then
						local var_129_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_126_1.actors_[var_129_38.prefab_name].transform, "story_v_out_111072", "111072031", "story_v_out_111072.awb")

						arg_126_1:RecordAudio("111072031", var_129_44)
						arg_126_1:RecordAudio("111072031", var_129_44)
					else
						arg_126_1:AudioAction("play", "voice", "story_v_out_111072", "111072031", "story_v_out_111072.awb")
					end

					arg_126_1:RecordHistoryTalkVoice("story_v_out_111072", "111072031", "story_v_out_111072.awb")
				end

				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_45 = math.max(var_129_36, arg_126_1.talkMaxDuration)

			if var_129_35 <= arg_126_1.time_ and arg_126_1.time_ < var_129_35 + var_129_45 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - var_129_35) / var_129_45

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= var_129_35 + var_129_45 and arg_126_1.time_ < var_129_35 + var_129_45 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1048ui_story",
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
	Play111072032 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 111072032
		arg_130_1.duration_ = 5.1

		local var_130_0 = {
			ja = 5.1,
			ko = 2.6,
			zh = 2.1,
			en = 2.1
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
				arg_130_0:Play111072033(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			local var_133_0 = 0

			if var_133_0 < arg_130_1.time_ and arg_130_1.time_ <= var_133_0 + arg_133_0 then
				arg_130_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039actionlink/1039action432")
			end

			local var_133_1 = 0

			if var_133_1 < arg_130_1.time_ and arg_130_1.time_ <= var_133_1 + arg_133_0 then
				arg_130_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_133_2 = arg_130_1.actors_["1039ui_story"]
			local var_133_3 = 0

			if var_133_3 < arg_130_1.time_ and arg_130_1.time_ <= var_133_3 + arg_133_0 and not isNil(var_133_2) and arg_130_1.var_.characterEffect1039ui_story == nil then
				arg_130_1.var_.characterEffect1039ui_story = var_133_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_133_4 = 0.2

			if var_133_3 <= arg_130_1.time_ and arg_130_1.time_ < var_133_3 + var_133_4 and not isNil(var_133_2) then
				local var_133_5 = (arg_130_1.time_ - var_133_3) / var_133_4

				if arg_130_1.var_.characterEffect1039ui_story and not isNil(var_133_2) then
					arg_130_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_130_1.time_ >= var_133_3 + var_133_4 and arg_130_1.time_ < var_133_3 + var_133_4 + arg_133_0 and not isNil(var_133_2) and arg_130_1.var_.characterEffect1039ui_story then
				arg_130_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_133_6 = arg_130_1.actors_["1084ui_story"]
			local var_133_7 = 0

			if var_133_7 < arg_130_1.time_ and arg_130_1.time_ <= var_133_7 + arg_133_0 and not isNil(var_133_6) and arg_130_1.var_.characterEffect1084ui_story == nil then
				arg_130_1.var_.characterEffect1084ui_story = var_133_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_133_8 = 0.2

			if var_133_7 <= arg_130_1.time_ and arg_130_1.time_ < var_133_7 + var_133_8 and not isNil(var_133_6) then
				local var_133_9 = (arg_130_1.time_ - var_133_7) / var_133_8

				if arg_130_1.var_.characterEffect1084ui_story and not isNil(var_133_6) then
					local var_133_10 = Mathf.Lerp(0, 0.5, var_133_9)

					arg_130_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_130_1.var_.characterEffect1084ui_story.fillRatio = var_133_10
				end
			end

			if arg_130_1.time_ >= var_133_7 + var_133_8 and arg_130_1.time_ < var_133_7 + var_133_8 + arg_133_0 and not isNil(var_133_6) and arg_130_1.var_.characterEffect1084ui_story then
				local var_133_11 = 0.5

				arg_130_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_130_1.var_.characterEffect1084ui_story.fillRatio = var_133_11
			end

			local var_133_12 = 0
			local var_133_13 = 0.325

			if var_133_12 < arg_130_1.time_ and arg_130_1.time_ <= var_133_12 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, true)

				local var_133_14 = arg_130_1:FormatText(StoryNameCfg[9].name)

				arg_130_1.leftNameTxt_.text = var_133_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_130_1.leftNameTxt_.transform)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1.leftNameTxt_.text)
				SetActive(arg_130_1.iconTrs_.gameObject, false)
				arg_130_1.callingController_:SetSelectedState("normal")

				local var_133_15 = arg_130_1:GetWordFromCfg(111072032)
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

				if manager.audio:GetVoiceLength("story_v_out_111072", "111072032", "story_v_out_111072.awb") ~= 0 then
					local var_133_20 = manager.audio:GetVoiceLength("story_v_out_111072", "111072032", "story_v_out_111072.awb") / 1000

					if var_133_20 + var_133_12 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_20 + var_133_12
					end

					if var_133_15.prefab_name ~= "" and arg_130_1.actors_[var_133_15.prefab_name] ~= nil then
						local var_133_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_130_1.actors_[var_133_15.prefab_name].transform, "story_v_out_111072", "111072032", "story_v_out_111072.awb")

						arg_130_1:RecordAudio("111072032", var_133_21)
						arg_130_1:RecordAudio("111072032", var_133_21)
					else
						arg_130_1:AudioAction("play", "voice", "story_v_out_111072", "111072032", "story_v_out_111072.awb")
					end

					arg_130_1:RecordHistoryTalkVoice("story_v_out_111072", "111072032", "story_v_out_111072.awb")
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
	Play111072033 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 111072033
		arg_134_1.duration_ = 5

		SetActive(arg_134_1.tipsGo_, false)

		function arg_134_1.onSingleLineFinish_()
			arg_134_1.onSingleLineUpdate_ = nil
			arg_134_1.onSingleLineFinish_ = nil
			arg_134_1.state_ = "waiting"
		end

		function arg_134_1.playNext_(arg_136_0)
			if arg_136_0 == 1 then
				arg_134_0:Play111072034(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			local var_137_0 = arg_134_1.actors_["1039ui_story"]
			local var_137_1 = 0

			if var_137_1 < arg_134_1.time_ and arg_134_1.time_ <= var_137_1 + arg_137_0 and not isNil(var_137_0) and arg_134_1.var_.characterEffect1039ui_story == nil then
				arg_134_1.var_.characterEffect1039ui_story = var_137_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_137_2 = 0.2

			if var_137_1 <= arg_134_1.time_ and arg_134_1.time_ < var_137_1 + var_137_2 and not isNil(var_137_0) then
				local var_137_3 = (arg_134_1.time_ - var_137_1) / var_137_2

				if arg_134_1.var_.characterEffect1039ui_story and not isNil(var_137_0) then
					local var_137_4 = Mathf.Lerp(0, 0.5, var_137_3)

					arg_134_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_134_1.var_.characterEffect1039ui_story.fillRatio = var_137_4
				end
			end

			if arg_134_1.time_ >= var_137_1 + var_137_2 and arg_134_1.time_ < var_137_1 + var_137_2 + arg_137_0 and not isNil(var_137_0) and arg_134_1.var_.characterEffect1039ui_story then
				local var_137_5 = 0.5

				arg_134_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_134_1.var_.characterEffect1039ui_story.fillRatio = var_137_5
			end

			local var_137_6 = 0
			local var_137_7 = 0.825

			if var_137_6 < arg_134_1.time_ and arg_134_1.time_ <= var_137_6 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, true)

				local var_137_8 = arg_134_1:FormatText(StoryNameCfg[7].name)

				arg_134_1.leftNameTxt_.text = var_137_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_134_1.leftNameTxt_.transform)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1.leftNameTxt_.text)
				SetActive(arg_134_1.iconTrs_.gameObject, true)
				arg_134_1.iconController_:SetSelectedState("hero")

				arg_134_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_134_1.callingController_:SetSelectedState("normal")

				arg_134_1.keyicon_.color = Color.New(1, 1, 1)
				arg_134_1.icon_.color = Color.New(1, 1, 1)

				local var_137_9 = arg_134_1:GetWordFromCfg(111072033)
				local var_137_10 = arg_134_1:FormatText(var_137_9.content)

				arg_134_1.text_.text = var_137_10

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_11 = 33
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
				arg_134_1:RecordContent(arg_134_1.text_.text)
			end

			local var_137_14 = math.max(var_137_7, arg_134_1.talkMaxDuration)

			if var_137_6 <= arg_134_1.time_ and arg_134_1.time_ < var_137_6 + var_137_14 then
				arg_134_1.typewritter.percent = (arg_134_1.time_ - var_137_6) / var_137_14

				arg_134_1.typewritter:SetDirty()
			end

			if arg_134_1.time_ >= var_137_6 + var_137_14 and arg_134_1.time_ < var_137_6 + var_137_14 + arg_137_0 then
				arg_134_1.typewritter.percent = 1

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(true)
			end
		end

		arg_134_1.nodeConfigList_ = {}

		arg_134_1:InitPlayNodeList()
	end,
	Play111072034 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 111072034
		arg_138_1.duration_ = 10.2

		local var_138_0 = {
			ja = 7.4,
			ko = 6.566,
			zh = 10.2,
			en = 8.766
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
				arg_138_0:Play111072035(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			local var_141_0 = 0

			if var_141_0 < arg_138_1.time_ and arg_138_1.time_ <= var_141_0 + arg_141_0 then
				arg_138_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action436")
			end

			local var_141_1 = 0

			if var_141_1 < arg_138_1.time_ and arg_138_1.time_ <= var_141_1 + arg_141_0 then
				arg_138_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_141_2 = arg_138_1.actors_["1084ui_story"]
			local var_141_3 = 0

			if var_141_3 < arg_138_1.time_ and arg_138_1.time_ <= var_141_3 + arg_141_0 and not isNil(var_141_2) and arg_138_1.var_.characterEffect1084ui_story == nil then
				arg_138_1.var_.characterEffect1084ui_story = var_141_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_141_4 = 0.2

			if var_141_3 <= arg_138_1.time_ and arg_138_1.time_ < var_141_3 + var_141_4 and not isNil(var_141_2) then
				local var_141_5 = (arg_138_1.time_ - var_141_3) / var_141_4

				if arg_138_1.var_.characterEffect1084ui_story and not isNil(var_141_2) then
					arg_138_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_138_1.time_ >= var_141_3 + var_141_4 and arg_138_1.time_ < var_141_3 + var_141_4 + arg_141_0 and not isNil(var_141_2) and arg_138_1.var_.characterEffect1084ui_story then
				arg_138_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_141_6 = 0
			local var_141_7 = 1

			if var_141_6 < arg_138_1.time_ and arg_138_1.time_ <= var_141_6 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, true)

				local var_141_8 = arg_138_1:FormatText(StoryNameCfg[6].name)

				arg_138_1.leftNameTxt_.text = var_141_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_138_1.leftNameTxt_.transform)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1.leftNameTxt_.text)
				SetActive(arg_138_1.iconTrs_.gameObject, false)
				arg_138_1.callingController_:SetSelectedState("normal")

				local var_141_9 = arg_138_1:GetWordFromCfg(111072034)
				local var_141_10 = arg_138_1:FormatText(var_141_9.content)

				arg_138_1.text_.text = var_141_10

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_11 = 40
				local var_141_12 = utf8.len(var_141_10)
				local var_141_13 = var_141_11 <= 0 and var_141_7 or var_141_7 * (var_141_12 / var_141_11)

				if var_141_13 > 0 and var_141_7 < var_141_13 then
					arg_138_1.talkMaxDuration = var_141_13

					if var_141_13 + var_141_6 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_13 + var_141_6
					end
				end

				arg_138_1.text_.text = var_141_10
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111072", "111072034", "story_v_out_111072.awb") ~= 0 then
					local var_141_14 = manager.audio:GetVoiceLength("story_v_out_111072", "111072034", "story_v_out_111072.awb") / 1000

					if var_141_14 + var_141_6 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_14 + var_141_6
					end

					if var_141_9.prefab_name ~= "" and arg_138_1.actors_[var_141_9.prefab_name] ~= nil then
						local var_141_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_138_1.actors_[var_141_9.prefab_name].transform, "story_v_out_111072", "111072034", "story_v_out_111072.awb")

						arg_138_1:RecordAudio("111072034", var_141_15)
						arg_138_1:RecordAudio("111072034", var_141_15)
					else
						arg_138_1:AudioAction("play", "voice", "story_v_out_111072", "111072034", "story_v_out_111072.awb")
					end

					arg_138_1:RecordHistoryTalkVoice("story_v_out_111072", "111072034", "story_v_out_111072.awb")
				end

				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_16 = math.max(var_141_7, arg_138_1.talkMaxDuration)

			if var_141_6 <= arg_138_1.time_ and arg_138_1.time_ < var_141_6 + var_141_16 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - var_141_6) / var_141_16

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= var_141_6 + var_141_16 and arg_138_1.time_ < var_141_6 + var_141_16 + arg_141_0 then
				arg_138_1.typewritter.percent = 1

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(true)
			end
		end

		arg_138_1.nodeConfigList_ = {}

		arg_138_1:InitPlayNodeList()
	end,
	Play111072035 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 111072035
		arg_142_1.duration_ = 10.83

		local var_142_0 = {
			ja = 10.833,
			ko = 7.566,
			zh = 9.5,
			en = 10.766
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
				arg_142_0:Play111072036(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			local var_145_0 = arg_142_1.actors_["1084ui_story"]
			local var_145_1 = 0

			if var_145_1 < arg_142_1.time_ and arg_142_1.time_ <= var_145_1 + arg_145_0 and not isNil(var_145_0) and arg_142_1.var_.characterEffect1084ui_story == nil then
				arg_142_1.var_.characterEffect1084ui_story = var_145_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_145_2 = 0.2

			if var_145_1 <= arg_142_1.time_ and arg_142_1.time_ < var_145_1 + var_145_2 and not isNil(var_145_0) then
				local var_145_3 = (arg_142_1.time_ - var_145_1) / var_145_2

				if arg_142_1.var_.characterEffect1084ui_story and not isNil(var_145_0) then
					local var_145_4 = Mathf.Lerp(0, 0.5, var_145_3)

					arg_142_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_142_1.var_.characterEffect1084ui_story.fillRatio = var_145_4
				end
			end

			if arg_142_1.time_ >= var_145_1 + var_145_2 and arg_142_1.time_ < var_145_1 + var_145_2 + arg_145_0 and not isNil(var_145_0) and arg_142_1.var_.characterEffect1084ui_story then
				local var_145_5 = 0.5

				arg_142_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_142_1.var_.characterEffect1084ui_story.fillRatio = var_145_5
			end

			local var_145_6 = 0

			if var_145_6 < arg_142_1.time_ and arg_142_1.time_ <= var_145_6 + arg_145_0 then
				arg_142_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_145_7 = arg_142_1.actors_["1039ui_story"]
			local var_145_8 = 0

			if var_145_8 < arg_142_1.time_ and arg_142_1.time_ <= var_145_8 + arg_145_0 and not isNil(var_145_7) and arg_142_1.var_.characterEffect1039ui_story == nil then
				arg_142_1.var_.characterEffect1039ui_story = var_145_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_145_9 = 0.2

			if var_145_8 <= arg_142_1.time_ and arg_142_1.time_ < var_145_8 + var_145_9 and not isNil(var_145_7) then
				local var_145_10 = (arg_142_1.time_ - var_145_8) / var_145_9

				if arg_142_1.var_.characterEffect1039ui_story and not isNil(var_145_7) then
					arg_142_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_142_1.time_ >= var_145_8 + var_145_9 and arg_142_1.time_ < var_145_8 + var_145_9 + arg_145_0 and not isNil(var_145_7) and arg_142_1.var_.characterEffect1039ui_story then
				arg_142_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_145_11 = 0
			local var_145_12 = 1.2

			if var_145_11 < arg_142_1.time_ and arg_142_1.time_ <= var_145_11 + arg_145_0 then
				arg_142_1.talkMaxDuration = 0
				arg_142_1.dialogCg_.alpha = 1

				arg_142_1.dialog_:SetActive(true)
				SetActive(arg_142_1.leftNameGo_, true)

				local var_145_13 = arg_142_1:FormatText(StoryNameCfg[9].name)

				arg_142_1.leftNameTxt_.text = var_145_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_142_1.leftNameTxt_.transform)

				arg_142_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_142_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_142_1:RecordName(arg_142_1.leftNameTxt_.text)
				SetActive(arg_142_1.iconTrs_.gameObject, false)
				arg_142_1.callingController_:SetSelectedState("normal")

				local var_145_14 = arg_142_1:GetWordFromCfg(111072035)
				local var_145_15 = arg_142_1:FormatText(var_145_14.content)

				arg_142_1.text_.text = var_145_15

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_16 = 48
				local var_145_17 = utf8.len(var_145_15)
				local var_145_18 = var_145_16 <= 0 and var_145_12 or var_145_12 * (var_145_17 / var_145_16)

				if var_145_18 > 0 and var_145_12 < var_145_18 then
					arg_142_1.talkMaxDuration = var_145_18

					if var_145_18 + var_145_11 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_18 + var_145_11
					end
				end

				arg_142_1.text_.text = var_145_15
				arg_142_1.typewritter.percent = 0

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111072", "111072035", "story_v_out_111072.awb") ~= 0 then
					local var_145_19 = manager.audio:GetVoiceLength("story_v_out_111072", "111072035", "story_v_out_111072.awb") / 1000

					if var_145_19 + var_145_11 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_19 + var_145_11
					end

					if var_145_14.prefab_name ~= "" and arg_142_1.actors_[var_145_14.prefab_name] ~= nil then
						local var_145_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_142_1.actors_[var_145_14.prefab_name].transform, "story_v_out_111072", "111072035", "story_v_out_111072.awb")

						arg_142_1:RecordAudio("111072035", var_145_20)
						arg_142_1:RecordAudio("111072035", var_145_20)
					else
						arg_142_1:AudioAction("play", "voice", "story_v_out_111072", "111072035", "story_v_out_111072.awb")
					end

					arg_142_1:RecordHistoryTalkVoice("story_v_out_111072", "111072035", "story_v_out_111072.awb")
				end

				arg_142_1:RecordContent(arg_142_1.text_.text)
			end

			local var_145_21 = math.max(var_145_12, arg_142_1.talkMaxDuration)

			if var_145_11 <= arg_142_1.time_ and arg_142_1.time_ < var_145_11 + var_145_21 then
				arg_142_1.typewritter.percent = (arg_142_1.time_ - var_145_11) / var_145_21

				arg_142_1.typewritter:SetDirty()
			end

			if arg_142_1.time_ >= var_145_11 + var_145_21 and arg_142_1.time_ < var_145_11 + var_145_21 + arg_145_0 then
				arg_142_1.typewritter.percent = 1

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(true)
			end
		end

		arg_142_1.nodeConfigList_ = {}

		arg_142_1:InitPlayNodeList()
	end,
	Play111072036 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 111072036
		arg_146_1.duration_ = 5

		SetActive(arg_146_1.tipsGo_, false)

		function arg_146_1.onSingleLineFinish_()
			arg_146_1.onSingleLineUpdate_ = nil
			arg_146_1.onSingleLineFinish_ = nil
			arg_146_1.state_ = "waiting"
		end

		function arg_146_1.playNext_(arg_148_0)
			if arg_148_0 == 1 then
				arg_146_0:Play111072037(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			local var_149_0 = arg_146_1.actors_["1084ui_story"].transform
			local var_149_1 = 0

			if var_149_1 < arg_146_1.time_ and arg_146_1.time_ <= var_149_1 + arg_149_0 then
				arg_146_1.var_.moveOldPos1084ui_story = var_149_0.localPosition
			end

			local var_149_2 = 0.001

			if var_149_1 <= arg_146_1.time_ and arg_146_1.time_ < var_149_1 + var_149_2 then
				local var_149_3 = (arg_146_1.time_ - var_149_1) / var_149_2
				local var_149_4 = Vector3.New(0, 100, 0)

				var_149_0.localPosition = Vector3.Lerp(arg_146_1.var_.moveOldPos1084ui_story, var_149_4, var_149_3)

				local var_149_5 = manager.ui.mainCamera.transform.position - var_149_0.position

				var_149_0.forward = Vector3.New(var_149_5.x, var_149_5.y, var_149_5.z)

				local var_149_6 = var_149_0.localEulerAngles

				var_149_6.z = 0
				var_149_6.x = 0
				var_149_0.localEulerAngles = var_149_6
			end

			if arg_146_1.time_ >= var_149_1 + var_149_2 and arg_146_1.time_ < var_149_1 + var_149_2 + arg_149_0 then
				var_149_0.localPosition = Vector3.New(0, 100, 0)

				local var_149_7 = manager.ui.mainCamera.transform.position - var_149_0.position

				var_149_0.forward = Vector3.New(var_149_7.x, var_149_7.y, var_149_7.z)

				local var_149_8 = var_149_0.localEulerAngles

				var_149_8.z = 0
				var_149_8.x = 0
				var_149_0.localEulerAngles = var_149_8
			end

			local var_149_9 = arg_146_1.actors_["1048ui_story"].transform
			local var_149_10 = 0

			if var_149_10 < arg_146_1.time_ and arg_146_1.time_ <= var_149_10 + arg_149_0 then
				arg_146_1.var_.moveOldPos1048ui_story = var_149_9.localPosition
			end

			local var_149_11 = 0.001

			if var_149_10 <= arg_146_1.time_ and arg_146_1.time_ < var_149_10 + var_149_11 then
				local var_149_12 = (arg_146_1.time_ - var_149_10) / var_149_11
				local var_149_13 = Vector3.New(0, 100, 0)

				var_149_9.localPosition = Vector3.Lerp(arg_146_1.var_.moveOldPos1048ui_story, var_149_13, var_149_12)

				local var_149_14 = manager.ui.mainCamera.transform.position - var_149_9.position

				var_149_9.forward = Vector3.New(var_149_14.x, var_149_14.y, var_149_14.z)

				local var_149_15 = var_149_9.localEulerAngles

				var_149_15.z = 0
				var_149_15.x = 0
				var_149_9.localEulerAngles = var_149_15
			end

			if arg_146_1.time_ >= var_149_10 + var_149_11 and arg_146_1.time_ < var_149_10 + var_149_11 + arg_149_0 then
				var_149_9.localPosition = Vector3.New(0, 100, 0)

				local var_149_16 = manager.ui.mainCamera.transform.position - var_149_9.position

				var_149_9.forward = Vector3.New(var_149_16.x, var_149_16.y, var_149_16.z)

				local var_149_17 = var_149_9.localEulerAngles

				var_149_17.z = 0
				var_149_17.x = 0
				var_149_9.localEulerAngles = var_149_17
			end

			local var_149_18 = arg_146_1.actors_["1039ui_story"].transform
			local var_149_19 = 0

			if var_149_19 < arg_146_1.time_ and arg_146_1.time_ <= var_149_19 + arg_149_0 then
				arg_146_1.var_.moveOldPos1039ui_story = var_149_18.localPosition
			end

			local var_149_20 = 0.001

			if var_149_19 <= arg_146_1.time_ and arg_146_1.time_ < var_149_19 + var_149_20 then
				local var_149_21 = (arg_146_1.time_ - var_149_19) / var_149_20
				local var_149_22 = Vector3.New(0, 100, 0)

				var_149_18.localPosition = Vector3.Lerp(arg_146_1.var_.moveOldPos1039ui_story, var_149_22, var_149_21)

				local var_149_23 = manager.ui.mainCamera.transform.position - var_149_18.position

				var_149_18.forward = Vector3.New(var_149_23.x, var_149_23.y, var_149_23.z)

				local var_149_24 = var_149_18.localEulerAngles

				var_149_24.z = 0
				var_149_24.x = 0
				var_149_18.localEulerAngles = var_149_24
			end

			if arg_146_1.time_ >= var_149_19 + var_149_20 and arg_146_1.time_ < var_149_19 + var_149_20 + arg_149_0 then
				var_149_18.localPosition = Vector3.New(0, 100, 0)

				local var_149_25 = manager.ui.mainCamera.transform.position - var_149_18.position

				var_149_18.forward = Vector3.New(var_149_25.x, var_149_25.y, var_149_25.z)

				local var_149_26 = var_149_18.localEulerAngles

				var_149_26.z = 0
				var_149_26.x = 0
				var_149_18.localEulerAngles = var_149_26
			end

			local var_149_27 = 0
			local var_149_28 = 1

			if var_149_27 < arg_146_1.time_ and arg_146_1.time_ <= var_149_27 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0
				arg_146_1.dialogCg_.alpha = 1

				arg_146_1.dialog_:SetActive(true)
				SetActive(arg_146_1.leftNameGo_, false)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_146_1.iconTrs_.gameObject, false)
				arg_146_1.callingController_:SetSelectedState("normal")

				local var_149_29 = arg_146_1:GetWordFromCfg(111072036)
				local var_149_30 = arg_146_1:FormatText(var_149_29.content)

				arg_146_1.text_.text = var_149_30

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_31 = 40
				local var_149_32 = utf8.len(var_149_30)
				local var_149_33 = var_149_31 <= 0 and var_149_28 or var_149_28 * (var_149_32 / var_149_31)

				if var_149_33 > 0 and var_149_28 < var_149_33 then
					arg_146_1.talkMaxDuration = var_149_33

					if var_149_33 + var_149_27 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_33 + var_149_27
					end
				end

				arg_146_1.text_.text = var_149_30
				arg_146_1.typewritter.percent = 0

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(false)
				arg_146_1:RecordContent(arg_146_1.text_.text)
			end

			local var_149_34 = math.max(var_149_28, arg_146_1.talkMaxDuration)

			if var_149_27 <= arg_146_1.time_ and arg_146_1.time_ < var_149_27 + var_149_34 then
				arg_146_1.typewritter.percent = (arg_146_1.time_ - var_149_27) / var_149_34

				arg_146_1.typewritter:SetDirty()
			end

			if arg_146_1.time_ >= var_149_27 + var_149_34 and arg_146_1.time_ < var_149_27 + var_149_34 + arg_149_0 then
				arg_146_1.typewritter.percent = 1

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(true)
			end
		end

		arg_146_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1048ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_146_1:InitPlayNodeList()
	end,
	Play111072037 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 111072037
		arg_150_1.duration_ = 5

		SetActive(arg_150_1.tipsGo_, false)

		function arg_150_1.onSingleLineFinish_()
			arg_150_1.onSingleLineUpdate_ = nil
			arg_150_1.onSingleLineFinish_ = nil
			arg_150_1.state_ = "waiting"
		end

		function arg_150_1.playNext_(arg_152_0)
			if arg_152_0 == 1 then
				arg_150_0:Play111072038(arg_150_1)
			end
		end

		function arg_150_1.onSingleLineUpdate_(arg_153_0)
			local var_153_0 = 0
			local var_153_1 = 1.375

			if var_153_0 < arg_150_1.time_ and arg_150_1.time_ <= var_153_0 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0
				arg_150_1.dialogCg_.alpha = 1

				arg_150_1.dialog_:SetActive(true)
				SetActive(arg_150_1.leftNameGo_, false)

				arg_150_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_150_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_150_1:RecordName(arg_150_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_150_1.iconTrs_.gameObject, false)
				arg_150_1.callingController_:SetSelectedState("normal")

				local var_153_2 = arg_150_1:GetWordFromCfg(111072037)
				local var_153_3 = arg_150_1:FormatText(var_153_2.content)

				arg_150_1.text_.text = var_153_3

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_4 = 55
				local var_153_5 = utf8.len(var_153_3)
				local var_153_6 = var_153_4 <= 0 and var_153_1 or var_153_1 * (var_153_5 / var_153_4)

				if var_153_6 > 0 and var_153_1 < var_153_6 then
					arg_150_1.talkMaxDuration = var_153_6

					if var_153_6 + var_153_0 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_6 + var_153_0
					end
				end

				arg_150_1.text_.text = var_153_3
				arg_150_1.typewritter.percent = 0

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(false)
				arg_150_1:RecordContent(arg_150_1.text_.text)
			end

			local var_153_7 = math.max(var_153_1, arg_150_1.talkMaxDuration)

			if var_153_0 <= arg_150_1.time_ and arg_150_1.time_ < var_153_0 + var_153_7 then
				arg_150_1.typewritter.percent = (arg_150_1.time_ - var_153_0) / var_153_7

				arg_150_1.typewritter:SetDirty()
			end

			if arg_150_1.time_ >= var_153_0 + var_153_7 and arg_150_1.time_ < var_153_0 + var_153_7 + arg_153_0 then
				arg_150_1.typewritter.percent = 1

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(true)
			end
		end

		arg_150_1.nodeConfigList_ = {}

		arg_150_1:InitPlayNodeList()
	end,
	Play111072038 = function(arg_154_0, arg_154_1)
		arg_154_1.time_ = 0
		arg_154_1.frameCnt_ = 0
		arg_154_1.state_ = "playing"
		arg_154_1.curTalkId_ = 111072038
		arg_154_1.duration_ = 5.07

		local var_154_0 = {
			ja = 5.066,
			ko = 4.7,
			zh = 4.366,
			en = 3
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
				arg_154_0:Play111072039(arg_154_1)
			end
		end

		function arg_154_1.onSingleLineUpdate_(arg_157_0)
			local var_157_0 = 0
			local var_157_1 = 0.35

			if var_157_0 < arg_154_1.time_ and arg_154_1.time_ <= var_157_0 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0
				arg_154_1.dialogCg_.alpha = 1

				arg_154_1.dialog_:SetActive(true)
				SetActive(arg_154_1.leftNameGo_, true)

				local var_157_2 = arg_154_1:FormatText(StoryNameCfg[189].name)

				arg_154_1.leftNameTxt_.text = var_157_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_154_1.leftNameTxt_.transform)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1.leftNameTxt_.text)
				SetActive(arg_154_1.iconTrs_.gameObject, true)
				arg_154_1.iconController_:SetSelectedState("hero")

				arg_154_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_vina")

				arg_154_1.callingController_:SetSelectedState("normal")

				arg_154_1.keyicon_.color = Color.New(1, 1, 1)
				arg_154_1.icon_.color = Color.New(1, 1, 1)

				local var_157_3 = arg_154_1:GetWordFromCfg(111072038)
				local var_157_4 = arg_154_1:FormatText(var_157_3.content)

				arg_154_1.text_.text = var_157_4

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_5 = 7
				local var_157_6 = utf8.len(var_157_4)
				local var_157_7 = var_157_5 <= 0 and var_157_1 or var_157_1 * (var_157_6 / var_157_5)

				if var_157_7 > 0 and var_157_1 < var_157_7 then
					arg_154_1.talkMaxDuration = var_157_7

					if var_157_7 + var_157_0 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_7 + var_157_0
					end
				end

				arg_154_1.text_.text = var_157_4
				arg_154_1.typewritter.percent = 0

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111072", "111072038", "story_v_out_111072.awb") ~= 0 then
					local var_157_8 = manager.audio:GetVoiceLength("story_v_out_111072", "111072038", "story_v_out_111072.awb") / 1000

					if var_157_8 + var_157_0 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_8 + var_157_0
					end

					if var_157_3.prefab_name ~= "" and arg_154_1.actors_[var_157_3.prefab_name] ~= nil then
						local var_157_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_154_1.actors_[var_157_3.prefab_name].transform, "story_v_out_111072", "111072038", "story_v_out_111072.awb")

						arg_154_1:RecordAudio("111072038", var_157_9)
						arg_154_1:RecordAudio("111072038", var_157_9)
					else
						arg_154_1:AudioAction("play", "voice", "story_v_out_111072", "111072038", "story_v_out_111072.awb")
					end

					arg_154_1:RecordHistoryTalkVoice("story_v_out_111072", "111072038", "story_v_out_111072.awb")
				end

				arg_154_1:RecordContent(arg_154_1.text_.text)
			end

			local var_157_10 = math.max(var_157_1, arg_154_1.talkMaxDuration)

			if var_157_0 <= arg_154_1.time_ and arg_154_1.time_ < var_157_0 + var_157_10 then
				arg_154_1.typewritter.percent = (arg_154_1.time_ - var_157_0) / var_157_10

				arg_154_1.typewritter:SetDirty()
			end

			if arg_154_1.time_ >= var_157_0 + var_157_10 and arg_154_1.time_ < var_157_0 + var_157_10 + arg_157_0 then
				arg_154_1.typewritter.percent = 1

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(true)
			end
		end

		arg_154_1.nodeConfigList_ = {}

		arg_154_1:InitPlayNodeList()
	end,
	Play111072039 = function(arg_158_0, arg_158_1)
		arg_158_1.time_ = 0
		arg_158_1.frameCnt_ = 0
		arg_158_1.state_ = "playing"
		arg_158_1.curTalkId_ = 111072039
		arg_158_1.duration_ = 8.23

		local var_158_0 = {
			ja = 3.6,
			ko = 8.233,
			zh = 4.866,
			en = 2.3
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
				arg_158_0:Play111072040(arg_158_1)
			end
		end

		function arg_158_1.onSingleLineUpdate_(arg_161_0)
			local var_161_0 = 0
			local var_161_1 = 0.475

			if var_161_0 < arg_158_1.time_ and arg_158_1.time_ <= var_161_0 + arg_161_0 then
				arg_158_1.talkMaxDuration = 0
				arg_158_1.dialogCg_.alpha = 1

				arg_158_1.dialog_:SetActive(true)
				SetActive(arg_158_1.leftNameGo_, true)

				local var_161_2 = arg_158_1:FormatText(StoryNameCfg[189].name)

				arg_158_1.leftNameTxt_.text = var_161_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_158_1.leftNameTxt_.transform)

				arg_158_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_158_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_158_1:RecordName(arg_158_1.leftNameTxt_.text)
				SetActive(arg_158_1.iconTrs_.gameObject, true)
				arg_158_1.iconController_:SetSelectedState("hero")

				arg_158_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_vina")

				arg_158_1.callingController_:SetSelectedState("normal")

				arg_158_1.keyicon_.color = Color.New(1, 1, 1)
				arg_158_1.icon_.color = Color.New(1, 1, 1)

				local var_161_3 = arg_158_1:GetWordFromCfg(111072039)
				local var_161_4 = arg_158_1:FormatText(var_161_3.content)

				arg_158_1.text_.text = var_161_4

				LuaForUtil.ClearLinePrefixSymbol(arg_158_1.text_)

				local var_161_5 = 14
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

				if manager.audio:GetVoiceLength("story_v_out_111072", "111072039", "story_v_out_111072.awb") ~= 0 then
					local var_161_8 = manager.audio:GetVoiceLength("story_v_out_111072", "111072039", "story_v_out_111072.awb") / 1000

					if var_161_8 + var_161_0 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_8 + var_161_0
					end

					if var_161_3.prefab_name ~= "" and arg_158_1.actors_[var_161_3.prefab_name] ~= nil then
						local var_161_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_158_1.actors_[var_161_3.prefab_name].transform, "story_v_out_111072", "111072039", "story_v_out_111072.awb")

						arg_158_1:RecordAudio("111072039", var_161_9)
						arg_158_1:RecordAudio("111072039", var_161_9)
					else
						arg_158_1:AudioAction("play", "voice", "story_v_out_111072", "111072039", "story_v_out_111072.awb")
					end

					arg_158_1:RecordHistoryTalkVoice("story_v_out_111072", "111072039", "story_v_out_111072.awb")
				end

				arg_158_1:RecordContent(arg_158_1.text_.text)
			end

			local var_161_10 = math.max(var_161_1, arg_158_1.talkMaxDuration)

			if var_161_0 <= arg_158_1.time_ and arg_158_1.time_ < var_161_0 + var_161_10 then
				arg_158_1.typewritter.percent = (arg_158_1.time_ - var_161_0) / var_161_10

				arg_158_1.typewritter:SetDirty()
			end

			if arg_158_1.time_ >= var_161_0 + var_161_10 and arg_158_1.time_ < var_161_0 + var_161_10 + arg_161_0 then
				arg_158_1.typewritter.percent = 1

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(true)
			end
		end

		arg_158_1.nodeConfigList_ = {}

		arg_158_1:InitPlayNodeList()
	end,
	Play111072040 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 111072040
		arg_162_1.duration_ = 5

		SetActive(arg_162_1.tipsGo_, false)

		function arg_162_1.onSingleLineFinish_()
			arg_162_1.onSingleLineUpdate_ = nil
			arg_162_1.onSingleLineFinish_ = nil
			arg_162_1.state_ = "waiting"
		end

		function arg_162_1.playNext_(arg_164_0)
			if arg_164_0 == 1 then
				arg_162_0:Play111072041(arg_162_1)
			end
		end

		function arg_162_1.onSingleLineUpdate_(arg_165_0)
			local var_165_0 = 0
			local var_165_1 = 0.9

			if var_165_0 < arg_162_1.time_ and arg_162_1.time_ <= var_165_0 + arg_165_0 then
				arg_162_1.talkMaxDuration = 0
				arg_162_1.dialogCg_.alpha = 1

				arg_162_1.dialog_:SetActive(true)
				SetActive(arg_162_1.leftNameGo_, false)

				arg_162_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_162_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_162_1:RecordName(arg_162_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_162_1.iconTrs_.gameObject, false)
				arg_162_1.callingController_:SetSelectedState("normal")

				local var_165_2 = arg_162_1:GetWordFromCfg(111072040)
				local var_165_3 = arg_162_1:FormatText(var_165_2.content)

				arg_162_1.text_.text = var_165_3

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_4 = 36
				local var_165_5 = utf8.len(var_165_3)
				local var_165_6 = var_165_4 <= 0 and var_165_1 or var_165_1 * (var_165_5 / var_165_4)

				if var_165_6 > 0 and var_165_1 < var_165_6 then
					arg_162_1.talkMaxDuration = var_165_6

					if var_165_6 + var_165_0 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_6 + var_165_0
					end
				end

				arg_162_1.text_.text = var_165_3
				arg_162_1.typewritter.percent = 0

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(false)
				arg_162_1:RecordContent(arg_162_1.text_.text)
			end

			local var_165_7 = math.max(var_165_1, arg_162_1.talkMaxDuration)

			if var_165_0 <= arg_162_1.time_ and arg_162_1.time_ < var_165_0 + var_165_7 then
				arg_162_1.typewritter.percent = (arg_162_1.time_ - var_165_0) / var_165_7

				arg_162_1.typewritter:SetDirty()
			end

			if arg_162_1.time_ >= var_165_0 + var_165_7 and arg_162_1.time_ < var_165_0 + var_165_7 + arg_165_0 then
				arg_162_1.typewritter.percent = 1

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(true)
			end
		end

		arg_162_1.nodeConfigList_ = {}

		arg_162_1:InitPlayNodeList()
	end,
	Play111072041 = function(arg_166_0, arg_166_1)
		arg_166_1.time_ = 0
		arg_166_1.frameCnt_ = 0
		arg_166_1.state_ = "playing"
		arg_166_1.curTalkId_ = 111072041
		arg_166_1.duration_ = 5

		SetActive(arg_166_1.tipsGo_, false)

		function arg_166_1.onSingleLineFinish_()
			arg_166_1.onSingleLineUpdate_ = nil
			arg_166_1.onSingleLineFinish_ = nil
			arg_166_1.state_ = "waiting"
		end

		function arg_166_1.playNext_(arg_168_0)
			if arg_168_0 == 1 then
				arg_166_0:Play111072042(arg_166_1)
			end
		end

		function arg_166_1.onSingleLineUpdate_(arg_169_0)
			local var_169_0 = 0
			local var_169_1 = 0.75

			if var_169_0 < arg_166_1.time_ and arg_166_1.time_ <= var_169_0 + arg_169_0 then
				arg_166_1.talkMaxDuration = 0
				arg_166_1.dialogCg_.alpha = 1

				arg_166_1.dialog_:SetActive(true)
				SetActive(arg_166_1.leftNameGo_, false)

				arg_166_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_166_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_166_1:RecordName(arg_166_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_166_1.iconTrs_.gameObject, false)
				arg_166_1.callingController_:SetSelectedState("normal")

				local var_169_2 = arg_166_1:GetWordFromCfg(111072041)
				local var_169_3 = arg_166_1:FormatText(var_169_2.content)

				arg_166_1.text_.text = var_169_3

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.text_)

				local var_169_4 = 30
				local var_169_5 = utf8.len(var_169_3)
				local var_169_6 = var_169_4 <= 0 and var_169_1 or var_169_1 * (var_169_5 / var_169_4)

				if var_169_6 > 0 and var_169_1 < var_169_6 then
					arg_166_1.talkMaxDuration = var_169_6

					if var_169_6 + var_169_0 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_6 + var_169_0
					end
				end

				arg_166_1.text_.text = var_169_3
				arg_166_1.typewritter.percent = 0

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(false)
				arg_166_1:RecordContent(arg_166_1.text_.text)
			end

			local var_169_7 = math.max(var_169_1, arg_166_1.talkMaxDuration)

			if var_169_0 <= arg_166_1.time_ and arg_166_1.time_ < var_169_0 + var_169_7 then
				arg_166_1.typewritter.percent = (arg_166_1.time_ - var_169_0) / var_169_7

				arg_166_1.typewritter:SetDirty()
			end

			if arg_166_1.time_ >= var_169_0 + var_169_7 and arg_166_1.time_ < var_169_0 + var_169_7 + arg_169_0 then
				arg_166_1.typewritter.percent = 1

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(true)
			end
		end

		arg_166_1.nodeConfigList_ = {}

		arg_166_1:InitPlayNodeList()
	end,
	Play111072042 = function(arg_170_0, arg_170_1)
		arg_170_1.time_ = 0
		arg_170_1.frameCnt_ = 0
		arg_170_1.state_ = "playing"
		arg_170_1.curTalkId_ = 111072042
		arg_170_1.duration_ = 3.5

		local var_170_0 = {
			ja = 3.5,
			ko = 0.999999999999,
			zh = 0.999999999999,
			en = 0.999999999999
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
				arg_170_0:Play111072043(arg_170_1)
			end
		end

		function arg_170_1.onSingleLineUpdate_(arg_173_0)
			local var_173_0 = 0
			local var_173_1 = 0.225

			if var_173_0 < arg_170_1.time_ and arg_170_1.time_ <= var_173_0 + arg_173_0 then
				arg_170_1.talkMaxDuration = 0
				arg_170_1.dialogCg_.alpha = 1

				arg_170_1.dialog_:SetActive(true)
				SetActive(arg_170_1.leftNameGo_, false)

				arg_170_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_170_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_170_1:RecordName(arg_170_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_170_1.iconTrs_.gameObject, false)
				arg_170_1.callingController_:SetSelectedState("normal")

				local var_173_2 = arg_170_1:GetWordFromCfg(111072042)
				local var_173_3 = arg_170_1:FormatText(var_173_2.content)

				arg_170_1.text_.text = var_173_3

				LuaForUtil.ClearLinePrefixSymbol(arg_170_1.text_)

				local var_173_4 = 9
				local var_173_5 = utf8.len(var_173_3)
				local var_173_6 = var_173_4 <= 0 and var_173_1 or var_173_1 * (var_173_5 / var_173_4)

				if var_173_6 > 0 and var_173_1 < var_173_6 then
					arg_170_1.talkMaxDuration = var_173_6

					if var_173_6 + var_173_0 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_6 + var_173_0
					end
				end

				arg_170_1.text_.text = var_173_3
				arg_170_1.typewritter.percent = 0

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111072", "111072042", "story_v_out_111072.awb") ~= 0 then
					local var_173_7 = manager.audio:GetVoiceLength("story_v_out_111072", "111072042", "story_v_out_111072.awb") / 1000

					if var_173_7 + var_173_0 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_7 + var_173_0
					end

					if var_173_2.prefab_name ~= "" and arg_170_1.actors_[var_173_2.prefab_name] ~= nil then
						local var_173_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_170_1.actors_[var_173_2.prefab_name].transform, "story_v_out_111072", "111072042", "story_v_out_111072.awb")

						arg_170_1:RecordAudio("111072042", var_173_8)
						arg_170_1:RecordAudio("111072042", var_173_8)
					else
						arg_170_1:AudioAction("play", "voice", "story_v_out_111072", "111072042", "story_v_out_111072.awb")
					end

					arg_170_1:RecordHistoryTalkVoice("story_v_out_111072", "111072042", "story_v_out_111072.awb")
				end

				arg_170_1:RecordContent(arg_170_1.text_.text)
			end

			local var_173_9 = math.max(var_173_1, arg_170_1.talkMaxDuration)

			if var_173_0 <= arg_170_1.time_ and arg_170_1.time_ < var_173_0 + var_173_9 then
				arg_170_1.typewritter.percent = (arg_170_1.time_ - var_173_0) / var_173_9

				arg_170_1.typewritter:SetDirty()
			end

			if arg_170_1.time_ >= var_173_0 + var_173_9 and arg_170_1.time_ < var_173_0 + var_173_9 + arg_173_0 then
				arg_170_1.typewritter.percent = 1

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(true)
			end
		end

		arg_170_1.nodeConfigList_ = {}

		arg_170_1:InitPlayNodeList()
	end,
	Play111072043 = function(arg_174_0, arg_174_1)
		arg_174_1.time_ = 0
		arg_174_1.frameCnt_ = 0
		arg_174_1.state_ = "playing"
		arg_174_1.curTalkId_ = 111072043
		arg_174_1.duration_ = 5

		SetActive(arg_174_1.tipsGo_, false)

		function arg_174_1.onSingleLineFinish_()
			arg_174_1.onSingleLineUpdate_ = nil
			arg_174_1.onSingleLineFinish_ = nil
			arg_174_1.state_ = "waiting"
		end

		function arg_174_1.playNext_(arg_176_0)
			if arg_176_0 == 1 then
				arg_174_0:Play111072044(arg_174_1)
			end
		end

		function arg_174_1.onSingleLineUpdate_(arg_177_0)
			local var_177_0 = 0
			local var_177_1 = 1.075

			if var_177_0 < arg_174_1.time_ and arg_174_1.time_ <= var_177_0 + arg_177_0 then
				arg_174_1.talkMaxDuration = 0
				arg_174_1.dialogCg_.alpha = 1

				arg_174_1.dialog_:SetActive(true)
				SetActive(arg_174_1.leftNameGo_, false)

				arg_174_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_174_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_174_1:RecordName(arg_174_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_174_1.iconTrs_.gameObject, false)
				arg_174_1.callingController_:SetSelectedState("normal")

				local var_177_2 = arg_174_1:GetWordFromCfg(111072043)
				local var_177_3 = arg_174_1:FormatText(var_177_2.content)

				arg_174_1.text_.text = var_177_3

				LuaForUtil.ClearLinePrefixSymbol(arg_174_1.text_)

				local var_177_4 = 43
				local var_177_5 = utf8.len(var_177_3)
				local var_177_6 = var_177_4 <= 0 and var_177_1 or var_177_1 * (var_177_5 / var_177_4)

				if var_177_6 > 0 and var_177_1 < var_177_6 then
					arg_174_1.talkMaxDuration = var_177_6

					if var_177_6 + var_177_0 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_6 + var_177_0
					end
				end

				arg_174_1.text_.text = var_177_3
				arg_174_1.typewritter.percent = 0

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(false)
				arg_174_1:RecordContent(arg_174_1.text_.text)
			end

			local var_177_7 = math.max(var_177_1, arg_174_1.talkMaxDuration)

			if var_177_0 <= arg_174_1.time_ and arg_174_1.time_ < var_177_0 + var_177_7 then
				arg_174_1.typewritter.percent = (arg_174_1.time_ - var_177_0) / var_177_7

				arg_174_1.typewritter:SetDirty()
			end

			if arg_174_1.time_ >= var_177_0 + var_177_7 and arg_174_1.time_ < var_177_0 + var_177_7 + arg_177_0 then
				arg_174_1.typewritter.percent = 1

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(true)
			end
		end

		arg_174_1.nodeConfigList_ = {}

		arg_174_1:InitPlayNodeList()
	end,
	Play111072044 = function(arg_178_0, arg_178_1)
		arg_178_1.time_ = 0
		arg_178_1.frameCnt_ = 0
		arg_178_1.state_ = "playing"
		arg_178_1.curTalkId_ = 111072044
		arg_178_1.duration_ = 7.97

		local var_178_0 = {
			ja = 7.966,
			ko = 4.566,
			zh = 5.966,
			en = 5.966
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
				arg_178_0:Play111072045(arg_178_1)
			end
		end

		function arg_178_1.onSingleLineUpdate_(arg_181_0)
			local var_181_0 = 0
			local var_181_1 = 0.55

			if var_181_0 < arg_178_1.time_ and arg_178_1.time_ <= var_181_0 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0
				arg_178_1.dialogCg_.alpha = 1

				arg_178_1.dialog_:SetActive(true)
				SetActive(arg_178_1.leftNameGo_, true)

				local var_181_2 = arg_178_1:FormatText(StoryNameCfg[181].name)

				arg_178_1.leftNameTxt_.text = var_181_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_178_1.leftNameTxt_.transform)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1.leftNameTxt_.text)
				SetActive(arg_178_1.iconTrs_.gameObject, true)
				arg_178_1.iconController_:SetSelectedState("hero")

				arg_178_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1094")

				arg_178_1.callingController_:SetSelectedState("normal")

				arg_178_1.keyicon_.color = Color.New(1, 1, 1)
				arg_178_1.icon_.color = Color.New(1, 1, 1)

				local var_181_3 = arg_178_1:GetWordFromCfg(111072044)
				local var_181_4 = arg_178_1:FormatText(var_181_3.content)

				arg_178_1.text_.text = var_181_4

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_5 = 22
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

				if manager.audio:GetVoiceLength("story_v_out_111072", "111072044", "story_v_out_111072.awb") ~= 0 then
					local var_181_8 = manager.audio:GetVoiceLength("story_v_out_111072", "111072044", "story_v_out_111072.awb") / 1000

					if var_181_8 + var_181_0 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_8 + var_181_0
					end

					if var_181_3.prefab_name ~= "" and arg_178_1.actors_[var_181_3.prefab_name] ~= nil then
						local var_181_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_178_1.actors_[var_181_3.prefab_name].transform, "story_v_out_111072", "111072044", "story_v_out_111072.awb")

						arg_178_1:RecordAudio("111072044", var_181_9)
						arg_178_1:RecordAudio("111072044", var_181_9)
					else
						arg_178_1:AudioAction("play", "voice", "story_v_out_111072", "111072044", "story_v_out_111072.awb")
					end

					arg_178_1:RecordHistoryTalkVoice("story_v_out_111072", "111072044", "story_v_out_111072.awb")
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
	Play111072045 = function(arg_182_0, arg_182_1)
		arg_182_1.time_ = 0
		arg_182_1.frameCnt_ = 0
		arg_182_1.state_ = "playing"
		arg_182_1.curTalkId_ = 111072045
		arg_182_1.duration_ = 6.7

		local var_182_0 = {
			ja = 6.7,
			ko = 2.966,
			zh = 3.633,
			en = 2.666
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
				arg_182_0:Play111072046(arg_182_1)
			end
		end

		function arg_182_1.onSingleLineUpdate_(arg_185_0)
			local var_185_0 = 0
			local var_185_1 = 0.375

			if var_185_0 < arg_182_1.time_ and arg_182_1.time_ <= var_185_0 + arg_185_0 then
				arg_182_1.talkMaxDuration = 0
				arg_182_1.dialogCg_.alpha = 1

				arg_182_1.dialog_:SetActive(true)
				SetActive(arg_182_1.leftNameGo_, true)

				local var_185_2 = arg_182_1:FormatText(StoryNameCfg[181].name)

				arg_182_1.leftNameTxt_.text = var_185_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_182_1.leftNameTxt_.transform)

				arg_182_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_182_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_182_1:RecordName(arg_182_1.leftNameTxt_.text)
				SetActive(arg_182_1.iconTrs_.gameObject, true)
				arg_182_1.iconController_:SetSelectedState("hero")

				arg_182_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1094")

				arg_182_1.callingController_:SetSelectedState("normal")

				arg_182_1.keyicon_.color = Color.New(1, 1, 1)
				arg_182_1.icon_.color = Color.New(1, 1, 1)

				local var_185_3 = arg_182_1:GetWordFromCfg(111072045)
				local var_185_4 = arg_182_1:FormatText(var_185_3.content)

				arg_182_1.text_.text = var_185_4

				LuaForUtil.ClearLinePrefixSymbol(arg_182_1.text_)

				local var_185_5 = 13
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

				if manager.audio:GetVoiceLength("story_v_out_111072", "111072045", "story_v_out_111072.awb") ~= 0 then
					local var_185_8 = manager.audio:GetVoiceLength("story_v_out_111072", "111072045", "story_v_out_111072.awb") / 1000

					if var_185_8 + var_185_0 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_8 + var_185_0
					end

					if var_185_3.prefab_name ~= "" and arg_182_1.actors_[var_185_3.prefab_name] ~= nil then
						local var_185_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_182_1.actors_[var_185_3.prefab_name].transform, "story_v_out_111072", "111072045", "story_v_out_111072.awb")

						arg_182_1:RecordAudio("111072045", var_185_9)
						arg_182_1:RecordAudio("111072045", var_185_9)
					else
						arg_182_1:AudioAction("play", "voice", "story_v_out_111072", "111072045", "story_v_out_111072.awb")
					end

					arg_182_1:RecordHistoryTalkVoice("story_v_out_111072", "111072045", "story_v_out_111072.awb")
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
	Play111072046 = function(arg_186_0, arg_186_1)
		arg_186_1.time_ = 0
		arg_186_1.frameCnt_ = 0
		arg_186_1.state_ = "playing"
		arg_186_1.curTalkId_ = 111072046
		arg_186_1.duration_ = 6.07

		local var_186_0 = {
			ja = 6.066,
			ko = 5.2,
			zh = 5.466,
			en = 5.666
		}
		local var_186_1 = manager.audio:GetLocalizationFlag()

		if var_186_0[var_186_1] ~= nil then
			arg_186_1.duration_ = var_186_0[var_186_1]
		end

		SetActive(arg_186_1.tipsGo_, false)

		function arg_186_1.onSingleLineFinish_()
			arg_186_1.onSingleLineUpdate_ = nil
			arg_186_1.onSingleLineFinish_ = nil
			arg_186_1.state_ = "waiting"
		end

		function arg_186_1.playNext_(arg_188_0)
			if arg_188_0 == 1 then
				arg_186_0:Play111072047(arg_186_1)
			end
		end

		function arg_186_1.onSingleLineUpdate_(arg_189_0)
			local var_189_0 = 0
			local var_189_1 = 0.625

			if var_189_0 < arg_186_1.time_ and arg_186_1.time_ <= var_189_0 + arg_189_0 then
				arg_186_1.talkMaxDuration = 0
				arg_186_1.dialogCg_.alpha = 1

				arg_186_1.dialog_:SetActive(true)
				SetActive(arg_186_1.leftNameGo_, true)

				local var_189_2 = arg_186_1:FormatText(StoryNameCfg[181].name)

				arg_186_1.leftNameTxt_.text = var_189_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_186_1.leftNameTxt_.transform)

				arg_186_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_186_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_186_1:RecordName(arg_186_1.leftNameTxt_.text)
				SetActive(arg_186_1.iconTrs_.gameObject, true)
				arg_186_1.iconController_:SetSelectedState("hero")

				arg_186_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1094")

				arg_186_1.callingController_:SetSelectedState("normal")

				arg_186_1.keyicon_.color = Color.New(1, 1, 1)
				arg_186_1.icon_.color = Color.New(1, 1, 1)

				local var_189_3 = arg_186_1:GetWordFromCfg(111072046)
				local var_189_4 = arg_186_1:FormatText(var_189_3.content)

				arg_186_1.text_.text = var_189_4

				LuaForUtil.ClearLinePrefixSymbol(arg_186_1.text_)

				local var_189_5 = 25
				local var_189_6 = utf8.len(var_189_4)
				local var_189_7 = var_189_5 <= 0 and var_189_1 or var_189_1 * (var_189_6 / var_189_5)

				if var_189_7 > 0 and var_189_1 < var_189_7 then
					arg_186_1.talkMaxDuration = var_189_7

					if var_189_7 + var_189_0 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_7 + var_189_0
					end
				end

				arg_186_1.text_.text = var_189_4
				arg_186_1.typewritter.percent = 0

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111072", "111072046", "story_v_out_111072.awb") ~= 0 then
					local var_189_8 = manager.audio:GetVoiceLength("story_v_out_111072", "111072046", "story_v_out_111072.awb") / 1000

					if var_189_8 + var_189_0 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_8 + var_189_0
					end

					if var_189_3.prefab_name ~= "" and arg_186_1.actors_[var_189_3.prefab_name] ~= nil then
						local var_189_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_186_1.actors_[var_189_3.prefab_name].transform, "story_v_out_111072", "111072046", "story_v_out_111072.awb")

						arg_186_1:RecordAudio("111072046", var_189_9)
						arg_186_1:RecordAudio("111072046", var_189_9)
					else
						arg_186_1:AudioAction("play", "voice", "story_v_out_111072", "111072046", "story_v_out_111072.awb")
					end

					arg_186_1:RecordHistoryTalkVoice("story_v_out_111072", "111072046", "story_v_out_111072.awb")
				end

				arg_186_1:RecordContent(arg_186_1.text_.text)
			end

			local var_189_10 = math.max(var_189_1, arg_186_1.talkMaxDuration)

			if var_189_0 <= arg_186_1.time_ and arg_186_1.time_ < var_189_0 + var_189_10 then
				arg_186_1.typewritter.percent = (arg_186_1.time_ - var_189_0) / var_189_10

				arg_186_1.typewritter:SetDirty()
			end

			if arg_186_1.time_ >= var_189_0 + var_189_10 and arg_186_1.time_ < var_189_0 + var_189_10 + arg_189_0 then
				arg_186_1.typewritter.percent = 1

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(true)
			end
		end

		arg_186_1.nodeConfigList_ = {}

		arg_186_1:InitPlayNodeList()
	end,
	Play111072047 = function(arg_190_0, arg_190_1)
		arg_190_1.time_ = 0
		arg_190_1.frameCnt_ = 0
		arg_190_1.state_ = "playing"
		arg_190_1.curTalkId_ = 111072047
		arg_190_1.duration_ = 7.1

		local var_190_0 = {
			ja = 7.1,
			ko = 2.466,
			zh = 2.3,
			en = 2.7
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
				arg_190_0:Play111072048(arg_190_1)
			end
		end

		function arg_190_1.onSingleLineUpdate_(arg_193_0)
			local var_193_0 = 0
			local var_193_1 = 0.375

			if var_193_0 < arg_190_1.time_ and arg_190_1.time_ <= var_193_0 + arg_193_0 then
				arg_190_1.talkMaxDuration = 0
				arg_190_1.dialogCg_.alpha = 1

				arg_190_1.dialog_:SetActive(true)
				SetActive(arg_190_1.leftNameGo_, true)

				local var_193_2 = arg_190_1:FormatText(StoryNameCfg[181].name)

				arg_190_1.leftNameTxt_.text = var_193_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_190_1.leftNameTxt_.transform)

				arg_190_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_190_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_190_1:RecordName(arg_190_1.leftNameTxt_.text)
				SetActive(arg_190_1.iconTrs_.gameObject, true)
				arg_190_1.iconController_:SetSelectedState("hero")

				arg_190_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1094")

				arg_190_1.callingController_:SetSelectedState("normal")

				arg_190_1.keyicon_.color = Color.New(1, 1, 1)
				arg_190_1.icon_.color = Color.New(1, 1, 1)

				local var_193_3 = arg_190_1:GetWordFromCfg(111072047)
				local var_193_4 = arg_190_1:FormatText(var_193_3.content)

				arg_190_1.text_.text = var_193_4

				LuaForUtil.ClearLinePrefixSymbol(arg_190_1.text_)

				local var_193_5 = 13
				local var_193_6 = utf8.len(var_193_4)
				local var_193_7 = var_193_5 <= 0 and var_193_1 or var_193_1 * (var_193_6 / var_193_5)

				if var_193_7 > 0 and var_193_1 < var_193_7 then
					arg_190_1.talkMaxDuration = var_193_7

					if var_193_7 + var_193_0 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_7 + var_193_0
					end
				end

				arg_190_1.text_.text = var_193_4
				arg_190_1.typewritter.percent = 0

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111072", "111072047", "story_v_out_111072.awb") ~= 0 then
					local var_193_8 = manager.audio:GetVoiceLength("story_v_out_111072", "111072047", "story_v_out_111072.awb") / 1000

					if var_193_8 + var_193_0 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_8 + var_193_0
					end

					if var_193_3.prefab_name ~= "" and arg_190_1.actors_[var_193_3.prefab_name] ~= nil then
						local var_193_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_190_1.actors_[var_193_3.prefab_name].transform, "story_v_out_111072", "111072047", "story_v_out_111072.awb")

						arg_190_1:RecordAudio("111072047", var_193_9)
						arg_190_1:RecordAudio("111072047", var_193_9)
					else
						arg_190_1:AudioAction("play", "voice", "story_v_out_111072", "111072047", "story_v_out_111072.awb")
					end

					arg_190_1:RecordHistoryTalkVoice("story_v_out_111072", "111072047", "story_v_out_111072.awb")
				end

				arg_190_1:RecordContent(arg_190_1.text_.text)
			end

			local var_193_10 = math.max(var_193_1, arg_190_1.talkMaxDuration)

			if var_193_0 <= arg_190_1.time_ and arg_190_1.time_ < var_193_0 + var_193_10 then
				arg_190_1.typewritter.percent = (arg_190_1.time_ - var_193_0) / var_193_10

				arg_190_1.typewritter:SetDirty()
			end

			if arg_190_1.time_ >= var_193_0 + var_193_10 and arg_190_1.time_ < var_193_0 + var_193_10 + arg_193_0 then
				arg_190_1.typewritter.percent = 1

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(true)
			end
		end

		arg_190_1.nodeConfigList_ = {}

		arg_190_1:InitPlayNodeList()
	end,
	Play111072048 = function(arg_194_0, arg_194_1)
		arg_194_1.time_ = 0
		arg_194_1.frameCnt_ = 0
		arg_194_1.state_ = "playing"
		arg_194_1.curTalkId_ = 111072048
		arg_194_1.duration_ = 5.37

		local var_194_0 = {
			ja = 3.8,
			ko = 3,
			zh = 4.033,
			en = 5.366
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
				arg_194_0:Play111072049(arg_194_1)
			end
		end

		function arg_194_1.onSingleLineUpdate_(arg_197_0)
			local var_197_0 = 0
			local var_197_1 = 0.25

			if var_197_0 < arg_194_1.time_ and arg_194_1.time_ <= var_197_0 + arg_197_0 then
				arg_194_1.talkMaxDuration = 0
				arg_194_1.dialogCg_.alpha = 1

				arg_194_1.dialog_:SetActive(true)
				SetActive(arg_194_1.leftNameGo_, true)

				local var_197_2 = arg_194_1:FormatText(StoryNameCfg[181].name)

				arg_194_1.leftNameTxt_.text = var_197_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_194_1.leftNameTxt_.transform)

				arg_194_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_194_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_194_1:RecordName(arg_194_1.leftNameTxt_.text)
				SetActive(arg_194_1.iconTrs_.gameObject, true)
				arg_194_1.iconController_:SetSelectedState("hero")

				arg_194_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1094")

				arg_194_1.callingController_:SetSelectedState("normal")

				arg_194_1.keyicon_.color = Color.New(1, 1, 1)
				arg_194_1.icon_.color = Color.New(1, 1, 1)

				local var_197_3 = arg_194_1:GetWordFromCfg(111072048)
				local var_197_4 = arg_194_1:FormatText(var_197_3.content)

				arg_194_1.text_.text = var_197_4

				LuaForUtil.ClearLinePrefixSymbol(arg_194_1.text_)

				local var_197_5 = 10
				local var_197_6 = utf8.len(var_197_4)
				local var_197_7 = var_197_5 <= 0 and var_197_1 or var_197_1 * (var_197_6 / var_197_5)

				if var_197_7 > 0 and var_197_1 < var_197_7 then
					arg_194_1.talkMaxDuration = var_197_7

					if var_197_7 + var_197_0 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_7 + var_197_0
					end
				end

				arg_194_1.text_.text = var_197_4
				arg_194_1.typewritter.percent = 0

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111072", "111072048", "story_v_out_111072.awb") ~= 0 then
					local var_197_8 = manager.audio:GetVoiceLength("story_v_out_111072", "111072048", "story_v_out_111072.awb") / 1000

					if var_197_8 + var_197_0 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_8 + var_197_0
					end

					if var_197_3.prefab_name ~= "" and arg_194_1.actors_[var_197_3.prefab_name] ~= nil then
						local var_197_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_194_1.actors_[var_197_3.prefab_name].transform, "story_v_out_111072", "111072048", "story_v_out_111072.awb")

						arg_194_1:RecordAudio("111072048", var_197_9)
						arg_194_1:RecordAudio("111072048", var_197_9)
					else
						arg_194_1:AudioAction("play", "voice", "story_v_out_111072", "111072048", "story_v_out_111072.awb")
					end

					arg_194_1:RecordHistoryTalkVoice("story_v_out_111072", "111072048", "story_v_out_111072.awb")
				end

				arg_194_1:RecordContent(arg_194_1.text_.text)
			end

			local var_197_10 = math.max(var_197_1, arg_194_1.talkMaxDuration)

			if var_197_0 <= arg_194_1.time_ and arg_194_1.time_ < var_197_0 + var_197_10 then
				arg_194_1.typewritter.percent = (arg_194_1.time_ - var_197_0) / var_197_10

				arg_194_1.typewritter:SetDirty()
			end

			if arg_194_1.time_ >= var_197_0 + var_197_10 and arg_194_1.time_ < var_197_0 + var_197_10 + arg_197_0 then
				arg_194_1.typewritter.percent = 1

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(true)
			end
		end

		arg_194_1.nodeConfigList_ = {}

		arg_194_1:InitPlayNodeList()
	end,
	Play111072049 = function(arg_198_0, arg_198_1)
		arg_198_1.time_ = 0
		arg_198_1.frameCnt_ = 0
		arg_198_1.state_ = "playing"
		arg_198_1.curTalkId_ = 111072049
		arg_198_1.duration_ = 5

		SetActive(arg_198_1.tipsGo_, false)

		function arg_198_1.onSingleLineFinish_()
			arg_198_1.onSingleLineUpdate_ = nil
			arg_198_1.onSingleLineFinish_ = nil
			arg_198_1.state_ = "waiting"
		end

		function arg_198_1.playNext_(arg_200_0)
			if arg_200_0 == 1 then
				arg_198_0:Play111072050(arg_198_1)
			end
		end

		function arg_198_1.onSingleLineUpdate_(arg_201_0)
			local var_201_0 = 0
			local var_201_1 = 0.7

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

				local var_201_2 = arg_198_1:GetWordFromCfg(111072049)
				local var_201_3 = arg_198_1:FormatText(var_201_2.content)

				arg_198_1.text_.text = var_201_3

				LuaForUtil.ClearLinePrefixSymbol(arg_198_1.text_)

				local var_201_4 = 28
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
	Play111072050 = function(arg_202_0, arg_202_1)
		arg_202_1.time_ = 0
		arg_202_1.frameCnt_ = 0
		arg_202_1.state_ = "playing"
		arg_202_1.curTalkId_ = 111072050
		arg_202_1.duration_ = 11.53

		local var_202_0 = {
			ja = 11.266,
			ko = 9.933,
			zh = 10.6,
			en = 11.533
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
				arg_202_0:Play111072051(arg_202_1)
			end
		end

		function arg_202_1.onSingleLineUpdate_(arg_205_0)
			local var_205_0 = "ST10"

			if arg_202_1.bgs_[var_205_0] == nil then
				local var_205_1 = Object.Instantiate(arg_202_1.paintGo_)

				var_205_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_205_0)
				var_205_1.name = var_205_0
				var_205_1.transform.parent = arg_202_1.stage_.transform
				var_205_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_202_1.bgs_[var_205_0] = var_205_1
			end

			local var_205_2 = 2

			if var_205_2 < arg_202_1.time_ and arg_202_1.time_ <= var_205_2 + arg_205_0 then
				local var_205_3 = manager.ui.mainCamera.transform.localPosition
				local var_205_4 = Vector3.New(0, 0, 10) + Vector3.New(var_205_3.x, var_205_3.y, 0)
				local var_205_5 = arg_202_1.bgs_.ST10

				var_205_5.transform.localPosition = var_205_4
				var_205_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_205_6 = var_205_5:GetComponent("SpriteRenderer")

				if var_205_6 and var_205_6.sprite then
					local var_205_7 = (var_205_5.transform.localPosition - var_205_3).z
					local var_205_8 = manager.ui.mainCameraCom_
					local var_205_9 = 2 * var_205_7 * Mathf.Tan(var_205_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_205_10 = var_205_9 * var_205_8.aspect
					local var_205_11 = var_205_6.sprite.bounds.size.x
					local var_205_12 = var_205_6.sprite.bounds.size.y
					local var_205_13 = var_205_10 / var_205_11
					local var_205_14 = var_205_9 / var_205_12
					local var_205_15 = var_205_14 < var_205_13 and var_205_13 or var_205_14

					var_205_5.transform.localScale = Vector3.New(var_205_15, var_205_15, 0)
				end

				for iter_205_0, iter_205_1 in pairs(arg_202_1.bgs_) do
					if iter_205_0 ~= "ST10" then
						iter_205_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_205_16 = 0

			if var_205_16 < arg_202_1.time_ and arg_202_1.time_ <= var_205_16 + arg_205_0 then
				arg_202_1.mask_.enabled = true
				arg_202_1.mask_.raycastTarget = true

				arg_202_1:SetGaussion(false)
			end

			local var_205_17 = 2

			if var_205_16 <= arg_202_1.time_ and arg_202_1.time_ < var_205_16 + var_205_17 then
				local var_205_18 = (arg_202_1.time_ - var_205_16) / var_205_17
				local var_205_19 = Color.New(0, 0, 0)

				var_205_19.a = Mathf.Lerp(0, 1, var_205_18)
				arg_202_1.mask_.color = var_205_19
			end

			if arg_202_1.time_ >= var_205_16 + var_205_17 and arg_202_1.time_ < var_205_16 + var_205_17 + arg_205_0 then
				local var_205_20 = Color.New(0, 0, 0)

				var_205_20.a = 1
				arg_202_1.mask_.color = var_205_20
			end

			local var_205_21 = 2

			if var_205_21 < arg_202_1.time_ and arg_202_1.time_ <= var_205_21 + arg_205_0 then
				arg_202_1.mask_.enabled = true
				arg_202_1.mask_.raycastTarget = true

				arg_202_1:SetGaussion(false)
			end

			local var_205_22 = 2

			if var_205_21 <= arg_202_1.time_ and arg_202_1.time_ < var_205_21 + var_205_22 then
				local var_205_23 = (arg_202_1.time_ - var_205_21) / var_205_22
				local var_205_24 = Color.New(0, 0, 0)

				var_205_24.a = Mathf.Lerp(1, 0, var_205_23)
				arg_202_1.mask_.color = var_205_24
			end

			if arg_202_1.time_ >= var_205_21 + var_205_22 and arg_202_1.time_ < var_205_21 + var_205_22 + arg_205_0 then
				local var_205_25 = Color.New(0, 0, 0)
				local var_205_26 = 0

				arg_202_1.mask_.enabled = false
				var_205_25.a = var_205_26
				arg_202_1.mask_.color = var_205_25
			end

			local var_205_27 = "1019ui_story"

			if arg_202_1.actors_[var_205_27] == nil then
				local var_205_28 = Asset.Load("Char/" .. "1019ui_story")

				if not isNil(var_205_28) then
					local var_205_29 = Object.Instantiate(Asset.Load("Char/" .. "1019ui_story"), arg_202_1.stage_.transform)

					var_205_29.name = var_205_27
					var_205_29.transform.localPosition = Vector3.New(0, 100, 0)
					arg_202_1.actors_[var_205_27] = var_205_29

					local var_205_30 = var_205_29:GetComponentInChildren(typeof(CharacterEffect))

					var_205_30.enabled = true

					local var_205_31 = GameObjectTools.GetOrAddComponent(var_205_29, typeof(DynamicBoneHelper))

					if var_205_31 then
						var_205_31:EnableDynamicBone(false)
					end

					arg_202_1:ShowWeapon(var_205_30.transform, false)

					arg_202_1.var_[var_205_27 .. "Animator"] = var_205_30.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_202_1.var_[var_205_27 .. "Animator"].applyRootMotion = true
					arg_202_1.var_[var_205_27 .. "LipSync"] = var_205_30.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_205_32 = arg_202_1.actors_["1019ui_story"].transform
			local var_205_33 = 3

			if var_205_33 < arg_202_1.time_ and arg_202_1.time_ <= var_205_33 + arg_205_0 then
				arg_202_1.var_.moveOldPos1019ui_story = var_205_32.localPosition
			end

			local var_205_34 = 0.001

			if var_205_33 <= arg_202_1.time_ and arg_202_1.time_ < var_205_33 + var_205_34 then
				local var_205_35 = (arg_202_1.time_ - var_205_33) / var_205_34
				local var_205_36 = Vector3.New(-0.2, -1.08, -5.9)

				var_205_32.localPosition = Vector3.Lerp(arg_202_1.var_.moveOldPos1019ui_story, var_205_36, var_205_35)

				local var_205_37 = manager.ui.mainCamera.transform.position - var_205_32.position

				var_205_32.forward = Vector3.New(var_205_37.x, var_205_37.y, var_205_37.z)

				local var_205_38 = var_205_32.localEulerAngles

				var_205_38.z = 0
				var_205_38.x = 0
				var_205_32.localEulerAngles = var_205_38
			end

			if arg_202_1.time_ >= var_205_33 + var_205_34 and arg_202_1.time_ < var_205_33 + var_205_34 + arg_205_0 then
				var_205_32.localPosition = Vector3.New(-0.2, -1.08, -5.9)

				local var_205_39 = manager.ui.mainCamera.transform.position - var_205_32.position

				var_205_32.forward = Vector3.New(var_205_39.x, var_205_39.y, var_205_39.z)

				local var_205_40 = var_205_32.localEulerAngles

				var_205_40.z = 0
				var_205_40.x = 0
				var_205_32.localEulerAngles = var_205_40
			end

			local var_205_41 = 3

			if var_205_41 < arg_202_1.time_ and arg_202_1.time_ <= var_205_41 + arg_205_0 then
				arg_202_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action6_1")
			end

			local var_205_42 = 3

			if var_205_42 < arg_202_1.time_ and arg_202_1.time_ <= var_205_42 + arg_205_0 then
				arg_202_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_205_43 = arg_202_1.actors_["1019ui_story"]
			local var_205_44 = 3

			if var_205_44 < arg_202_1.time_ and arg_202_1.time_ <= var_205_44 + arg_205_0 and not isNil(var_205_43) and arg_202_1.var_.characterEffect1019ui_story == nil then
				arg_202_1.var_.characterEffect1019ui_story = var_205_43:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_205_45 = 0.2

			if var_205_44 <= arg_202_1.time_ and arg_202_1.time_ < var_205_44 + var_205_45 and not isNil(var_205_43) then
				local var_205_46 = (arg_202_1.time_ - var_205_44) / var_205_45

				if arg_202_1.var_.characterEffect1019ui_story and not isNil(var_205_43) then
					arg_202_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_202_1.time_ >= var_205_44 + var_205_45 and arg_202_1.time_ < var_205_44 + var_205_45 + arg_205_0 and not isNil(var_205_43) and arg_202_1.var_.characterEffect1019ui_story then
				arg_202_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_205_47 = 0

			if var_205_47 < arg_202_1.time_ and arg_202_1.time_ <= var_205_47 + arg_205_0 then
				arg_202_1.allBtn_.enabled = false
			end

			local var_205_48 = 3

			if arg_202_1.time_ >= var_205_47 + var_205_48 and arg_202_1.time_ < var_205_47 + var_205_48 + arg_205_0 then
				arg_202_1.allBtn_.enabled = true
			end

			if arg_202_1.frameCnt_ <= 1 then
				arg_202_1.dialog_:SetActive(false)
			end

			local var_205_49 = 4
			local var_205_50 = 0.85

			if var_205_49 < arg_202_1.time_ and arg_202_1.time_ <= var_205_49 + arg_205_0 then
				arg_202_1.talkMaxDuration = 0

				arg_202_1.dialog_:SetActive(true)

				arg_202_1.dialogCg_.alpha = 0

				local var_205_51 = LeanTween.value(arg_202_1.dialog_, 0, 1, 0.3)

				var_205_51:setOnUpdate(LuaHelper.FloatAction(function(arg_206_0)
					arg_202_1.dialogCg_.alpha = arg_206_0
				end))
				var_205_51:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_202_1.dialog_)
					var_205_51:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_202_1.duration_ = arg_202_1.duration_ + 0.3

				SetActive(arg_202_1.leftNameGo_, true)

				local var_205_52 = arg_202_1:FormatText(StoryNameCfg[13].name)

				arg_202_1.leftNameTxt_.text = var_205_52

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_202_1.leftNameTxt_.transform)

				arg_202_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_202_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_202_1:RecordName(arg_202_1.leftNameTxt_.text)
				SetActive(arg_202_1.iconTrs_.gameObject, false)
				arg_202_1.callingController_:SetSelectedState("normal")

				local var_205_53 = arg_202_1:GetWordFromCfg(111072050)
				local var_205_54 = arg_202_1:FormatText(var_205_53.content)

				arg_202_1.text_.text = var_205_54

				LuaForUtil.ClearLinePrefixSymbol(arg_202_1.text_)

				local var_205_55 = 33
				local var_205_56 = utf8.len(var_205_54)
				local var_205_57 = var_205_55 <= 0 and var_205_50 or var_205_50 * (var_205_56 / var_205_55)

				if var_205_57 > 0 and var_205_50 < var_205_57 then
					arg_202_1.talkMaxDuration = var_205_57
					var_205_49 = var_205_49 + 0.3

					if var_205_57 + var_205_49 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_57 + var_205_49
					end
				end

				arg_202_1.text_.text = var_205_54
				arg_202_1.typewritter.percent = 0

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111072", "111072050", "story_v_out_111072.awb") ~= 0 then
					local var_205_58 = manager.audio:GetVoiceLength("story_v_out_111072", "111072050", "story_v_out_111072.awb") / 1000

					if var_205_58 + var_205_49 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_58 + var_205_49
					end

					if var_205_53.prefab_name ~= "" and arg_202_1.actors_[var_205_53.prefab_name] ~= nil then
						local var_205_59 = LuaForUtil.PlayVoiceWithCriLipsync(arg_202_1.actors_[var_205_53.prefab_name].transform, "story_v_out_111072", "111072050", "story_v_out_111072.awb")

						arg_202_1:RecordAudio("111072050", var_205_59)
						arg_202_1:RecordAudio("111072050", var_205_59)
					else
						arg_202_1:AudioAction("play", "voice", "story_v_out_111072", "111072050", "story_v_out_111072.awb")
					end

					arg_202_1:RecordHistoryTalkVoice("story_v_out_111072", "111072050", "story_v_out_111072.awb")
				end

				arg_202_1:RecordContent(arg_202_1.text_.text)
			end

			local var_205_60 = var_205_49 + 0.3
			local var_205_61 = math.max(var_205_50, arg_202_1.talkMaxDuration)

			if var_205_60 <= arg_202_1.time_ and arg_202_1.time_ < var_205_60 + var_205_61 then
				arg_202_1.typewritter.percent = (arg_202_1.time_ - var_205_60) / var_205_61

				arg_202_1.typewritter:SetDirty()
			end

			if arg_202_1.time_ >= var_205_60 + var_205_61 and arg_202_1.time_ < var_205_60 + var_205_61 + arg_205_0 then
				arg_202_1.typewritter.percent = 1

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(true)
			end
		end

		arg_202_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_202_1:InitPlayNodeList()
	end,
	Play111072051 = function(arg_208_0, arg_208_1)
		arg_208_1.time_ = 0
		arg_208_1.frameCnt_ = 0
		arg_208_1.state_ = "playing"
		arg_208_1.curTalkId_ = 111072051
		arg_208_1.duration_ = 12.33

		local var_208_0 = {
			ja = 12.333,
			ko = 8.833,
			zh = 7.8,
			en = 9.066
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
				arg_208_0:Play111072052(arg_208_1)
			end
		end

		function arg_208_1.onSingleLineUpdate_(arg_211_0)
			local var_211_0 = 0

			if var_211_0 < arg_208_1.time_ and arg_208_1.time_ <= var_211_0 + arg_211_0 then
				arg_208_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_211_1 = arg_208_1.actors_["1019ui_story"]
			local var_211_2 = 0

			if var_211_2 < arg_208_1.time_ and arg_208_1.time_ <= var_211_2 + arg_211_0 and not isNil(var_211_1) and arg_208_1.var_.characterEffect1019ui_story == nil then
				arg_208_1.var_.characterEffect1019ui_story = var_211_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_211_3 = 0.2

			if var_211_2 <= arg_208_1.time_ and arg_208_1.time_ < var_211_2 + var_211_3 and not isNil(var_211_1) then
				local var_211_4 = (arg_208_1.time_ - var_211_2) / var_211_3

				if arg_208_1.var_.characterEffect1019ui_story and not isNil(var_211_1) then
					arg_208_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_208_1.time_ >= var_211_2 + var_211_3 and arg_208_1.time_ < var_211_2 + var_211_3 + arg_211_0 and not isNil(var_211_1) and arg_208_1.var_.characterEffect1019ui_story then
				arg_208_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_211_5 = 0
			local var_211_6 = 1.15

			if var_211_5 < arg_208_1.time_ and arg_208_1.time_ <= var_211_5 + arg_211_0 then
				arg_208_1.talkMaxDuration = 0
				arg_208_1.dialogCg_.alpha = 1

				arg_208_1.dialog_:SetActive(true)
				SetActive(arg_208_1.leftNameGo_, true)

				local var_211_7 = arg_208_1:FormatText(StoryNameCfg[13].name)

				arg_208_1.leftNameTxt_.text = var_211_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_208_1.leftNameTxt_.transform)

				arg_208_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_208_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_208_1:RecordName(arg_208_1.leftNameTxt_.text)
				SetActive(arg_208_1.iconTrs_.gameObject, false)
				arg_208_1.callingController_:SetSelectedState("normal")

				local var_211_8 = arg_208_1:GetWordFromCfg(111072051)
				local var_211_9 = arg_208_1:FormatText(var_211_8.content)

				arg_208_1.text_.text = var_211_9

				LuaForUtil.ClearLinePrefixSymbol(arg_208_1.text_)

				local var_211_10 = 46
				local var_211_11 = utf8.len(var_211_9)
				local var_211_12 = var_211_10 <= 0 and var_211_6 or var_211_6 * (var_211_11 / var_211_10)

				if var_211_12 > 0 and var_211_6 < var_211_12 then
					arg_208_1.talkMaxDuration = var_211_12

					if var_211_12 + var_211_5 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_12 + var_211_5
					end
				end

				arg_208_1.text_.text = var_211_9
				arg_208_1.typewritter.percent = 0

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111072", "111072051", "story_v_out_111072.awb") ~= 0 then
					local var_211_13 = manager.audio:GetVoiceLength("story_v_out_111072", "111072051", "story_v_out_111072.awb") / 1000

					if var_211_13 + var_211_5 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_13 + var_211_5
					end

					if var_211_8.prefab_name ~= "" and arg_208_1.actors_[var_211_8.prefab_name] ~= nil then
						local var_211_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_208_1.actors_[var_211_8.prefab_name].transform, "story_v_out_111072", "111072051", "story_v_out_111072.awb")

						arg_208_1:RecordAudio("111072051", var_211_14)
						arg_208_1:RecordAudio("111072051", var_211_14)
					else
						arg_208_1:AudioAction("play", "voice", "story_v_out_111072", "111072051", "story_v_out_111072.awb")
					end

					arg_208_1:RecordHistoryTalkVoice("story_v_out_111072", "111072051", "story_v_out_111072.awb")
				end

				arg_208_1:RecordContent(arg_208_1.text_.text)
			end

			local var_211_15 = math.max(var_211_6, arg_208_1.talkMaxDuration)

			if var_211_5 <= arg_208_1.time_ and arg_208_1.time_ < var_211_5 + var_211_15 then
				arg_208_1.typewritter.percent = (arg_208_1.time_ - var_211_5) / var_211_15

				arg_208_1.typewritter:SetDirty()
			end

			if arg_208_1.time_ >= var_211_5 + var_211_15 and arg_208_1.time_ < var_211_5 + var_211_15 + arg_211_0 then
				arg_208_1.typewritter.percent = 1

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(true)
			end
		end

		arg_208_1.nodeConfigList_ = {}

		arg_208_1:InitPlayNodeList()
	end,
	Play111072052 = function(arg_212_0, arg_212_1)
		arg_212_1.time_ = 0
		arg_212_1.frameCnt_ = 0
		arg_212_1.state_ = "playing"
		arg_212_1.curTalkId_ = 111072052
		arg_212_1.duration_ = 5

		SetActive(arg_212_1.tipsGo_, false)

		function arg_212_1.onSingleLineFinish_()
			arg_212_1.onSingleLineUpdate_ = nil
			arg_212_1.onSingleLineFinish_ = nil
			arg_212_1.state_ = "waiting"
		end

		function arg_212_1.playNext_(arg_214_0)
			if arg_214_0 == 1 then
				arg_212_0:Play111072053(arg_212_1)
			end
		end

		function arg_212_1.onSingleLineUpdate_(arg_215_0)
			local var_215_0 = arg_212_1.actors_["1019ui_story"]
			local var_215_1 = 0

			if var_215_1 < arg_212_1.time_ and arg_212_1.time_ <= var_215_1 + arg_215_0 and not isNil(var_215_0) and arg_212_1.var_.characterEffect1019ui_story == nil then
				arg_212_1.var_.characterEffect1019ui_story = var_215_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_215_2 = 0.2

			if var_215_1 <= arg_212_1.time_ and arg_212_1.time_ < var_215_1 + var_215_2 and not isNil(var_215_0) then
				local var_215_3 = (arg_212_1.time_ - var_215_1) / var_215_2

				if arg_212_1.var_.characterEffect1019ui_story and not isNil(var_215_0) then
					local var_215_4 = Mathf.Lerp(0, 0.5, var_215_3)

					arg_212_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_212_1.var_.characterEffect1019ui_story.fillRatio = var_215_4
				end
			end

			if arg_212_1.time_ >= var_215_1 + var_215_2 and arg_212_1.time_ < var_215_1 + var_215_2 + arg_215_0 and not isNil(var_215_0) and arg_212_1.var_.characterEffect1019ui_story then
				local var_215_5 = 0.5

				arg_212_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_212_1.var_.characterEffect1019ui_story.fillRatio = var_215_5
			end

			local var_215_6 = 0
			local var_215_7 = 0.25

			if var_215_6 < arg_212_1.time_ and arg_212_1.time_ <= var_215_6 + arg_215_0 then
				arg_212_1.talkMaxDuration = 0
				arg_212_1.dialogCg_.alpha = 1

				arg_212_1.dialog_:SetActive(true)
				SetActive(arg_212_1.leftNameGo_, true)

				local var_215_8 = arg_212_1:FormatText(StoryNameCfg[7].name)

				arg_212_1.leftNameTxt_.text = var_215_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_212_1.leftNameTxt_.transform)

				arg_212_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_212_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_212_1:RecordName(arg_212_1.leftNameTxt_.text)
				SetActive(arg_212_1.iconTrs_.gameObject, true)
				arg_212_1.iconController_:SetSelectedState("hero")

				arg_212_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_212_1.callingController_:SetSelectedState("normal")

				arg_212_1.keyicon_.color = Color.New(1, 1, 1)
				arg_212_1.icon_.color = Color.New(1, 1, 1)

				local var_215_9 = arg_212_1:GetWordFromCfg(111072052)
				local var_215_10 = arg_212_1:FormatText(var_215_9.content)

				arg_212_1.text_.text = var_215_10

				LuaForUtil.ClearLinePrefixSymbol(arg_212_1.text_)

				local var_215_11 = 10
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
				arg_212_1:RecordContent(arg_212_1.text_.text)
			end

			local var_215_14 = math.max(var_215_7, arg_212_1.talkMaxDuration)

			if var_215_6 <= arg_212_1.time_ and arg_212_1.time_ < var_215_6 + var_215_14 then
				arg_212_1.typewritter.percent = (arg_212_1.time_ - var_215_6) / var_215_14

				arg_212_1.typewritter:SetDirty()
			end

			if arg_212_1.time_ >= var_215_6 + var_215_14 and arg_212_1.time_ < var_215_6 + var_215_14 + arg_215_0 then
				arg_212_1.typewritter.percent = 1

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(true)
			end
		end

		arg_212_1.nodeConfigList_ = {}

		arg_212_1:InitPlayNodeList()
	end,
	Play111072053 = function(arg_216_0, arg_216_1)
		arg_216_1.time_ = 0
		arg_216_1.frameCnt_ = 0
		arg_216_1.state_ = "playing"
		arg_216_1.curTalkId_ = 111072053
		arg_216_1.duration_ = 15.57

		local var_216_0 = {
			ja = 15.566,
			ko = 11.266,
			zh = 10.1,
			en = 12.5
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
				arg_216_0:Play111072054(arg_216_1)
			end
		end

		function arg_216_1.onSingleLineUpdate_(arg_219_0)
			local var_219_0 = 0

			if var_219_0 < arg_216_1.time_ and arg_216_1.time_ <= var_219_0 + arg_219_0 then
				arg_216_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_219_1 = arg_216_1.actors_["1019ui_story"]
			local var_219_2 = 0

			if var_219_2 < arg_216_1.time_ and arg_216_1.time_ <= var_219_2 + arg_219_0 and not isNil(var_219_1) and arg_216_1.var_.characterEffect1019ui_story == nil then
				arg_216_1.var_.characterEffect1019ui_story = var_219_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_219_3 = 0.2

			if var_219_2 <= arg_216_1.time_ and arg_216_1.time_ < var_219_2 + var_219_3 and not isNil(var_219_1) then
				local var_219_4 = (arg_216_1.time_ - var_219_2) / var_219_3

				if arg_216_1.var_.characterEffect1019ui_story and not isNil(var_219_1) then
					arg_216_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_216_1.time_ >= var_219_2 + var_219_3 and arg_216_1.time_ < var_219_2 + var_219_3 + arg_219_0 and not isNil(var_219_1) and arg_216_1.var_.characterEffect1019ui_story then
				arg_216_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_219_5 = 0
			local var_219_6 = 1.25

			if var_219_5 < arg_216_1.time_ and arg_216_1.time_ <= var_219_5 + arg_219_0 then
				arg_216_1.talkMaxDuration = 0
				arg_216_1.dialogCg_.alpha = 1

				arg_216_1.dialog_:SetActive(true)
				SetActive(arg_216_1.leftNameGo_, true)

				local var_219_7 = arg_216_1:FormatText(StoryNameCfg[13].name)

				arg_216_1.leftNameTxt_.text = var_219_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_216_1.leftNameTxt_.transform)

				arg_216_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_216_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_216_1:RecordName(arg_216_1.leftNameTxt_.text)
				SetActive(arg_216_1.iconTrs_.gameObject, false)
				arg_216_1.callingController_:SetSelectedState("normal")

				local var_219_8 = arg_216_1:GetWordFromCfg(111072053)
				local var_219_9 = arg_216_1:FormatText(var_219_8.content)

				arg_216_1.text_.text = var_219_9

				LuaForUtil.ClearLinePrefixSymbol(arg_216_1.text_)

				local var_219_10 = 50
				local var_219_11 = utf8.len(var_219_9)
				local var_219_12 = var_219_10 <= 0 and var_219_6 or var_219_6 * (var_219_11 / var_219_10)

				if var_219_12 > 0 and var_219_6 < var_219_12 then
					arg_216_1.talkMaxDuration = var_219_12

					if var_219_12 + var_219_5 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_12 + var_219_5
					end
				end

				arg_216_1.text_.text = var_219_9
				arg_216_1.typewritter.percent = 0

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111072", "111072053", "story_v_out_111072.awb") ~= 0 then
					local var_219_13 = manager.audio:GetVoiceLength("story_v_out_111072", "111072053", "story_v_out_111072.awb") / 1000

					if var_219_13 + var_219_5 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_13 + var_219_5
					end

					if var_219_8.prefab_name ~= "" and arg_216_1.actors_[var_219_8.prefab_name] ~= nil then
						local var_219_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_216_1.actors_[var_219_8.prefab_name].transform, "story_v_out_111072", "111072053", "story_v_out_111072.awb")

						arg_216_1:RecordAudio("111072053", var_219_14)
						arg_216_1:RecordAudio("111072053", var_219_14)
					else
						arg_216_1:AudioAction("play", "voice", "story_v_out_111072", "111072053", "story_v_out_111072.awb")
					end

					arg_216_1:RecordHistoryTalkVoice("story_v_out_111072", "111072053", "story_v_out_111072.awb")
				end

				arg_216_1:RecordContent(arg_216_1.text_.text)
			end

			local var_219_15 = math.max(var_219_6, arg_216_1.talkMaxDuration)

			if var_219_5 <= arg_216_1.time_ and arg_216_1.time_ < var_219_5 + var_219_15 then
				arg_216_1.typewritter.percent = (arg_216_1.time_ - var_219_5) / var_219_15

				arg_216_1.typewritter:SetDirty()
			end

			if arg_216_1.time_ >= var_219_5 + var_219_15 and arg_216_1.time_ < var_219_5 + var_219_15 + arg_219_0 then
				arg_216_1.typewritter.percent = 1

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(true)
			end
		end

		arg_216_1.nodeConfigList_ = {}

		arg_216_1:InitPlayNodeList()
	end,
	Play111072054 = function(arg_220_0, arg_220_1)
		arg_220_1.time_ = 0
		arg_220_1.frameCnt_ = 0
		arg_220_1.state_ = "playing"
		arg_220_1.curTalkId_ = 111072054
		arg_220_1.duration_ = 14.2

		local var_220_0 = {
			ja = 13.033,
			ko = 12.766,
			zh = 12.333,
			en = 14.2
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
				arg_220_0:Play111072055(arg_220_1)
			end
		end

		function arg_220_1.onSingleLineUpdate_(arg_223_0)
			local var_223_0 = 0

			if var_223_0 < arg_220_1.time_ and arg_220_1.time_ <= var_223_0 + arg_223_0 then
				arg_220_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_223_1 = 0
			local var_223_2 = 1.55

			if var_223_1 < arg_220_1.time_ and arg_220_1.time_ <= var_223_1 + arg_223_0 then
				arg_220_1.talkMaxDuration = 0
				arg_220_1.dialogCg_.alpha = 1

				arg_220_1.dialog_:SetActive(true)
				SetActive(arg_220_1.leftNameGo_, true)

				local var_223_3 = arg_220_1:FormatText(StoryNameCfg[13].name)

				arg_220_1.leftNameTxt_.text = var_223_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_220_1.leftNameTxt_.transform)

				arg_220_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_220_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_220_1:RecordName(arg_220_1.leftNameTxt_.text)
				SetActive(arg_220_1.iconTrs_.gameObject, false)
				arg_220_1.callingController_:SetSelectedState("normal")

				local var_223_4 = arg_220_1:GetWordFromCfg(111072054)
				local var_223_5 = arg_220_1:FormatText(var_223_4.content)

				arg_220_1.text_.text = var_223_5

				LuaForUtil.ClearLinePrefixSymbol(arg_220_1.text_)

				local var_223_6 = 62
				local var_223_7 = utf8.len(var_223_5)
				local var_223_8 = var_223_6 <= 0 and var_223_2 or var_223_2 * (var_223_7 / var_223_6)

				if var_223_8 > 0 and var_223_2 < var_223_8 then
					arg_220_1.talkMaxDuration = var_223_8

					if var_223_8 + var_223_1 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_8 + var_223_1
					end
				end

				arg_220_1.text_.text = var_223_5
				arg_220_1.typewritter.percent = 0

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111072", "111072054", "story_v_out_111072.awb") ~= 0 then
					local var_223_9 = manager.audio:GetVoiceLength("story_v_out_111072", "111072054", "story_v_out_111072.awb") / 1000

					if var_223_9 + var_223_1 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_9 + var_223_1
					end

					if var_223_4.prefab_name ~= "" and arg_220_1.actors_[var_223_4.prefab_name] ~= nil then
						local var_223_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_220_1.actors_[var_223_4.prefab_name].transform, "story_v_out_111072", "111072054", "story_v_out_111072.awb")

						arg_220_1:RecordAudio("111072054", var_223_10)
						arg_220_1:RecordAudio("111072054", var_223_10)
					else
						arg_220_1:AudioAction("play", "voice", "story_v_out_111072", "111072054", "story_v_out_111072.awb")
					end

					arg_220_1:RecordHistoryTalkVoice("story_v_out_111072", "111072054", "story_v_out_111072.awb")
				end

				arg_220_1:RecordContent(arg_220_1.text_.text)
			end

			local var_223_11 = math.max(var_223_2, arg_220_1.talkMaxDuration)

			if var_223_1 <= arg_220_1.time_ and arg_220_1.time_ < var_223_1 + var_223_11 then
				arg_220_1.typewritter.percent = (arg_220_1.time_ - var_223_1) / var_223_11

				arg_220_1.typewritter:SetDirty()
			end

			if arg_220_1.time_ >= var_223_1 + var_223_11 and arg_220_1.time_ < var_223_1 + var_223_11 + arg_223_0 then
				arg_220_1.typewritter.percent = 1

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(true)
			end
		end

		arg_220_1.nodeConfigList_ = {}

		arg_220_1:InitPlayNodeList()
	end,
	Play111072055 = function(arg_224_0, arg_224_1)
		arg_224_1.time_ = 0
		arg_224_1.frameCnt_ = 0
		arg_224_1.state_ = "playing"
		arg_224_1.curTalkId_ = 111072055
		arg_224_1.duration_ = 5

		SetActive(arg_224_1.tipsGo_, false)

		function arg_224_1.onSingleLineFinish_()
			arg_224_1.onSingleLineUpdate_ = nil
			arg_224_1.onSingleLineFinish_ = nil
			arg_224_1.state_ = "waiting"
		end

		function arg_224_1.playNext_(arg_226_0)
			if arg_226_0 == 1 then
				arg_224_0:Play111072056(arg_224_1)
			end
		end

		function arg_224_1.onSingleLineUpdate_(arg_227_0)
			local var_227_0 = arg_224_1.actors_["1019ui_story"]
			local var_227_1 = 0

			if var_227_1 < arg_224_1.time_ and arg_224_1.time_ <= var_227_1 + arg_227_0 and not isNil(var_227_0) and arg_224_1.var_.characterEffect1019ui_story == nil then
				arg_224_1.var_.characterEffect1019ui_story = var_227_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_227_2 = 0.2

			if var_227_1 <= arg_224_1.time_ and arg_224_1.time_ < var_227_1 + var_227_2 and not isNil(var_227_0) then
				local var_227_3 = (arg_224_1.time_ - var_227_1) / var_227_2

				if arg_224_1.var_.characterEffect1019ui_story and not isNil(var_227_0) then
					local var_227_4 = Mathf.Lerp(0, 0.5, var_227_3)

					arg_224_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_224_1.var_.characterEffect1019ui_story.fillRatio = var_227_4
				end
			end

			if arg_224_1.time_ >= var_227_1 + var_227_2 and arg_224_1.time_ < var_227_1 + var_227_2 + arg_227_0 and not isNil(var_227_0) and arg_224_1.var_.characterEffect1019ui_story then
				local var_227_5 = 0.5

				arg_224_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_224_1.var_.characterEffect1019ui_story.fillRatio = var_227_5
			end

			local var_227_6 = 0
			local var_227_7 = 0.875

			if var_227_6 < arg_224_1.time_ and arg_224_1.time_ <= var_227_6 + arg_227_0 then
				arg_224_1.talkMaxDuration = 0
				arg_224_1.dialogCg_.alpha = 1

				arg_224_1.dialog_:SetActive(true)
				SetActive(arg_224_1.leftNameGo_, true)

				local var_227_8 = arg_224_1:FormatText(StoryNameCfg[7].name)

				arg_224_1.leftNameTxt_.text = var_227_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_224_1.leftNameTxt_.transform)

				arg_224_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_224_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_224_1:RecordName(arg_224_1.leftNameTxt_.text)
				SetActive(arg_224_1.iconTrs_.gameObject, true)
				arg_224_1.iconController_:SetSelectedState("hero")

				arg_224_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_224_1.callingController_:SetSelectedState("normal")

				arg_224_1.keyicon_.color = Color.New(1, 1, 1)
				arg_224_1.icon_.color = Color.New(1, 1, 1)

				local var_227_9 = arg_224_1:GetWordFromCfg(111072055)
				local var_227_10 = arg_224_1:FormatText(var_227_9.content)

				arg_224_1.text_.text = var_227_10

				LuaForUtil.ClearLinePrefixSymbol(arg_224_1.text_)

				local var_227_11 = 35
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
				arg_224_1:RecordContent(arg_224_1.text_.text)
			end

			local var_227_14 = math.max(var_227_7, arg_224_1.talkMaxDuration)

			if var_227_6 <= arg_224_1.time_ and arg_224_1.time_ < var_227_6 + var_227_14 then
				arg_224_1.typewritter.percent = (arg_224_1.time_ - var_227_6) / var_227_14

				arg_224_1.typewritter:SetDirty()
			end

			if arg_224_1.time_ >= var_227_6 + var_227_14 and arg_224_1.time_ < var_227_6 + var_227_14 + arg_227_0 then
				arg_224_1.typewritter.percent = 1

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(true)
			end
		end

		arg_224_1.nodeConfigList_ = {}

		arg_224_1:InitPlayNodeList()
	end,
	Play111072056 = function(arg_228_0, arg_228_1)
		arg_228_1.time_ = 0
		arg_228_1.frameCnt_ = 0
		arg_228_1.state_ = "playing"
		arg_228_1.curTalkId_ = 111072056
		arg_228_1.duration_ = 10.4

		local var_228_0 = {
			ja = 10.4,
			ko = 7.866,
			zh = 10.366,
			en = 10.4
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
				arg_228_0:Play111072057(arg_228_1)
			end
		end

		function arg_228_1.onSingleLineUpdate_(arg_231_0)
			local var_231_0 = 0

			if var_231_0 < arg_228_1.time_ and arg_228_1.time_ <= var_231_0 + arg_231_0 then
				arg_228_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action462")
			end

			local var_231_1 = 0

			if var_231_1 < arg_228_1.time_ and arg_228_1.time_ <= var_231_1 + arg_231_0 then
				arg_228_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_231_2 = arg_228_1.actors_["1019ui_story"]
			local var_231_3 = 0

			if var_231_3 < arg_228_1.time_ and arg_228_1.time_ <= var_231_3 + arg_231_0 and not isNil(var_231_2) and arg_228_1.var_.characterEffect1019ui_story == nil then
				arg_228_1.var_.characterEffect1019ui_story = var_231_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_231_4 = 0.2

			if var_231_3 <= arg_228_1.time_ and arg_228_1.time_ < var_231_3 + var_231_4 and not isNil(var_231_2) then
				local var_231_5 = (arg_228_1.time_ - var_231_3) / var_231_4

				if arg_228_1.var_.characterEffect1019ui_story and not isNil(var_231_2) then
					arg_228_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_228_1.time_ >= var_231_3 + var_231_4 and arg_228_1.time_ < var_231_3 + var_231_4 + arg_231_0 and not isNil(var_231_2) and arg_228_1.var_.characterEffect1019ui_story then
				arg_228_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_231_6 = 0
			local var_231_7 = 1

			if var_231_6 < arg_228_1.time_ and arg_228_1.time_ <= var_231_6 + arg_231_0 then
				arg_228_1.talkMaxDuration = 0
				arg_228_1.dialogCg_.alpha = 1

				arg_228_1.dialog_:SetActive(true)
				SetActive(arg_228_1.leftNameGo_, true)

				local var_231_8 = arg_228_1:FormatText(StoryNameCfg[13].name)

				arg_228_1.leftNameTxt_.text = var_231_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_228_1.leftNameTxt_.transform)

				arg_228_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_228_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_228_1:RecordName(arg_228_1.leftNameTxt_.text)
				SetActive(arg_228_1.iconTrs_.gameObject, false)
				arg_228_1.callingController_:SetSelectedState("normal")

				local var_231_9 = arg_228_1:GetWordFromCfg(111072056)
				local var_231_10 = arg_228_1:FormatText(var_231_9.content)

				arg_228_1.text_.text = var_231_10

				LuaForUtil.ClearLinePrefixSymbol(arg_228_1.text_)

				local var_231_11 = 40
				local var_231_12 = utf8.len(var_231_10)
				local var_231_13 = var_231_11 <= 0 and var_231_7 or var_231_7 * (var_231_12 / var_231_11)

				if var_231_13 > 0 and var_231_7 < var_231_13 then
					arg_228_1.talkMaxDuration = var_231_13

					if var_231_13 + var_231_6 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_13 + var_231_6
					end
				end

				arg_228_1.text_.text = var_231_10
				arg_228_1.typewritter.percent = 0

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111072", "111072056", "story_v_out_111072.awb") ~= 0 then
					local var_231_14 = manager.audio:GetVoiceLength("story_v_out_111072", "111072056", "story_v_out_111072.awb") / 1000

					if var_231_14 + var_231_6 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_14 + var_231_6
					end

					if var_231_9.prefab_name ~= "" and arg_228_1.actors_[var_231_9.prefab_name] ~= nil then
						local var_231_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_228_1.actors_[var_231_9.prefab_name].transform, "story_v_out_111072", "111072056", "story_v_out_111072.awb")

						arg_228_1:RecordAudio("111072056", var_231_15)
						arg_228_1:RecordAudio("111072056", var_231_15)
					else
						arg_228_1:AudioAction("play", "voice", "story_v_out_111072", "111072056", "story_v_out_111072.awb")
					end

					arg_228_1:RecordHistoryTalkVoice("story_v_out_111072", "111072056", "story_v_out_111072.awb")
				end

				arg_228_1:RecordContent(arg_228_1.text_.text)
			end

			local var_231_16 = math.max(var_231_7, arg_228_1.talkMaxDuration)

			if var_231_6 <= arg_228_1.time_ and arg_228_1.time_ < var_231_6 + var_231_16 then
				arg_228_1.typewritter.percent = (arg_228_1.time_ - var_231_6) / var_231_16

				arg_228_1.typewritter:SetDirty()
			end

			if arg_228_1.time_ >= var_231_6 + var_231_16 and arg_228_1.time_ < var_231_6 + var_231_16 + arg_231_0 then
				arg_228_1.typewritter.percent = 1

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(true)
			end
		end

		arg_228_1.nodeConfigList_ = {}

		arg_228_1:InitPlayNodeList()
	end,
	Play111072057 = function(arg_232_0, arg_232_1)
		arg_232_1.time_ = 0
		arg_232_1.frameCnt_ = 0
		arg_232_1.state_ = "playing"
		arg_232_1.curTalkId_ = 111072057
		arg_232_1.duration_ = 17.3

		local var_232_0 = {
			ja = 9.766,
			ko = 16.833,
			zh = 15.1,
			en = 17.3
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
				arg_232_0:Play111072058(arg_232_1)
			end
		end

		function arg_232_1.onSingleLineUpdate_(arg_235_0)
			local var_235_0 = 0

			if var_235_0 < arg_232_1.time_ and arg_232_1.time_ <= var_235_0 + arg_235_0 then
				arg_232_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_235_1 = 0
			local var_235_2 = 1.625

			if var_235_1 < arg_232_1.time_ and arg_232_1.time_ <= var_235_1 + arg_235_0 then
				arg_232_1.talkMaxDuration = 0
				arg_232_1.dialogCg_.alpha = 1

				arg_232_1.dialog_:SetActive(true)
				SetActive(arg_232_1.leftNameGo_, true)

				local var_235_3 = arg_232_1:FormatText(StoryNameCfg[13].name)

				arg_232_1.leftNameTxt_.text = var_235_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_232_1.leftNameTxt_.transform)

				arg_232_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_232_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_232_1:RecordName(arg_232_1.leftNameTxt_.text)
				SetActive(arg_232_1.iconTrs_.gameObject, false)
				arg_232_1.callingController_:SetSelectedState("normal")

				local var_235_4 = arg_232_1:GetWordFromCfg(111072057)
				local var_235_5 = arg_232_1:FormatText(var_235_4.content)

				arg_232_1.text_.text = var_235_5

				LuaForUtil.ClearLinePrefixSymbol(arg_232_1.text_)

				local var_235_6 = 64
				local var_235_7 = utf8.len(var_235_5)
				local var_235_8 = var_235_6 <= 0 and var_235_2 or var_235_2 * (var_235_7 / var_235_6)

				if var_235_8 > 0 and var_235_2 < var_235_8 then
					arg_232_1.talkMaxDuration = var_235_8

					if var_235_8 + var_235_1 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_8 + var_235_1
					end
				end

				arg_232_1.text_.text = var_235_5
				arg_232_1.typewritter.percent = 0

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111072", "111072057", "story_v_out_111072.awb") ~= 0 then
					local var_235_9 = manager.audio:GetVoiceLength("story_v_out_111072", "111072057", "story_v_out_111072.awb") / 1000

					if var_235_9 + var_235_1 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_9 + var_235_1
					end

					if var_235_4.prefab_name ~= "" and arg_232_1.actors_[var_235_4.prefab_name] ~= nil then
						local var_235_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_232_1.actors_[var_235_4.prefab_name].transform, "story_v_out_111072", "111072057", "story_v_out_111072.awb")

						arg_232_1:RecordAudio("111072057", var_235_10)
						arg_232_1:RecordAudio("111072057", var_235_10)
					else
						arg_232_1:AudioAction("play", "voice", "story_v_out_111072", "111072057", "story_v_out_111072.awb")
					end

					arg_232_1:RecordHistoryTalkVoice("story_v_out_111072", "111072057", "story_v_out_111072.awb")
				end

				arg_232_1:RecordContent(arg_232_1.text_.text)
			end

			local var_235_11 = math.max(var_235_2, arg_232_1.talkMaxDuration)

			if var_235_1 <= arg_232_1.time_ and arg_232_1.time_ < var_235_1 + var_235_11 then
				arg_232_1.typewritter.percent = (arg_232_1.time_ - var_235_1) / var_235_11

				arg_232_1.typewritter:SetDirty()
			end

			if arg_232_1.time_ >= var_235_1 + var_235_11 and arg_232_1.time_ < var_235_1 + var_235_11 + arg_235_0 then
				arg_232_1.typewritter.percent = 1

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(true)
			end
		end

		arg_232_1.nodeConfigList_ = {}

		arg_232_1:InitPlayNodeList()
	end,
	Play111072058 = function(arg_236_0, arg_236_1)
		arg_236_1.time_ = 0
		arg_236_1.frameCnt_ = 0
		arg_236_1.state_ = "playing"
		arg_236_1.curTalkId_ = 111072058
		arg_236_1.duration_ = 5

		SetActive(arg_236_1.tipsGo_, false)

		function arg_236_1.onSingleLineFinish_()
			arg_236_1.onSingleLineUpdate_ = nil
			arg_236_1.onSingleLineFinish_ = nil
			arg_236_1.state_ = "waiting"
		end

		function arg_236_1.playNext_(arg_238_0)
			if arg_238_0 == 1 then
				arg_236_0:Play111072059(arg_236_1)
			end
		end

		function arg_236_1.onSingleLineUpdate_(arg_239_0)
			local var_239_0 = arg_236_1.actors_["1019ui_story"]
			local var_239_1 = 0

			if var_239_1 < arg_236_1.time_ and arg_236_1.time_ <= var_239_1 + arg_239_0 and not isNil(var_239_0) and arg_236_1.var_.characterEffect1019ui_story == nil then
				arg_236_1.var_.characterEffect1019ui_story = var_239_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_239_2 = 0.2

			if var_239_1 <= arg_236_1.time_ and arg_236_1.time_ < var_239_1 + var_239_2 and not isNil(var_239_0) then
				local var_239_3 = (arg_236_1.time_ - var_239_1) / var_239_2

				if arg_236_1.var_.characterEffect1019ui_story and not isNil(var_239_0) then
					local var_239_4 = Mathf.Lerp(0, 0.5, var_239_3)

					arg_236_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_236_1.var_.characterEffect1019ui_story.fillRatio = var_239_4
				end
			end

			if arg_236_1.time_ >= var_239_1 + var_239_2 and arg_236_1.time_ < var_239_1 + var_239_2 + arg_239_0 and not isNil(var_239_0) and arg_236_1.var_.characterEffect1019ui_story then
				local var_239_5 = 0.5

				arg_236_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_236_1.var_.characterEffect1019ui_story.fillRatio = var_239_5
			end

			local var_239_6 = 0
			local var_239_7 = 0.475

			if var_239_6 < arg_236_1.time_ and arg_236_1.time_ <= var_239_6 + arg_239_0 then
				arg_236_1.talkMaxDuration = 0
				arg_236_1.dialogCg_.alpha = 1

				arg_236_1.dialog_:SetActive(true)
				SetActive(arg_236_1.leftNameGo_, true)

				local var_239_8 = arg_236_1:FormatText(StoryNameCfg[7].name)

				arg_236_1.leftNameTxt_.text = var_239_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_236_1.leftNameTxt_.transform)

				arg_236_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_236_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_236_1:RecordName(arg_236_1.leftNameTxt_.text)
				SetActive(arg_236_1.iconTrs_.gameObject, true)
				arg_236_1.iconController_:SetSelectedState("hero")

				arg_236_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_236_1.callingController_:SetSelectedState("normal")

				arg_236_1.keyicon_.color = Color.New(1, 1, 1)
				arg_236_1.icon_.color = Color.New(1, 1, 1)

				local var_239_9 = arg_236_1:GetWordFromCfg(111072058)
				local var_239_10 = arg_236_1:FormatText(var_239_9.content)

				arg_236_1.text_.text = var_239_10

				LuaForUtil.ClearLinePrefixSymbol(arg_236_1.text_)

				local var_239_11 = 19
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
				arg_236_1:RecordContent(arg_236_1.text_.text)
			end

			local var_239_14 = math.max(var_239_7, arg_236_1.talkMaxDuration)

			if var_239_6 <= arg_236_1.time_ and arg_236_1.time_ < var_239_6 + var_239_14 then
				arg_236_1.typewritter.percent = (arg_236_1.time_ - var_239_6) / var_239_14

				arg_236_1.typewritter:SetDirty()
			end

			if arg_236_1.time_ >= var_239_6 + var_239_14 and arg_236_1.time_ < var_239_6 + var_239_14 + arg_239_0 then
				arg_236_1.typewritter.percent = 1

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(true)
			end
		end

		arg_236_1.nodeConfigList_ = {}

		arg_236_1:InitPlayNodeList()
	end,
	Play111072059 = function(arg_240_0, arg_240_1)
		arg_240_1.time_ = 0
		arg_240_1.frameCnt_ = 0
		arg_240_1.state_ = "playing"
		arg_240_1.curTalkId_ = 111072059
		arg_240_1.duration_ = 13.8

		local var_240_0 = {
			ja = 13.133,
			ko = 11.633,
			zh = 11.733,
			en = 13.8
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
				arg_240_0:Play111072060(arg_240_1)
			end
		end

		function arg_240_1.onSingleLineUpdate_(arg_243_0)
			local var_243_0 = 0

			if var_243_0 < arg_240_1.time_ and arg_240_1.time_ <= var_243_0 + arg_243_0 then
				arg_240_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action425")
			end

			local var_243_1 = 0

			if var_243_1 < arg_240_1.time_ and arg_240_1.time_ <= var_243_1 + arg_243_0 then
				arg_240_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_243_2 = arg_240_1.actors_["1019ui_story"]
			local var_243_3 = 0

			if var_243_3 < arg_240_1.time_ and arg_240_1.time_ <= var_243_3 + arg_243_0 and not isNil(var_243_2) and arg_240_1.var_.characterEffect1019ui_story == nil then
				arg_240_1.var_.characterEffect1019ui_story = var_243_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_243_4 = 0.2

			if var_243_3 <= arg_240_1.time_ and arg_240_1.time_ < var_243_3 + var_243_4 and not isNil(var_243_2) then
				local var_243_5 = (arg_240_1.time_ - var_243_3) / var_243_4

				if arg_240_1.var_.characterEffect1019ui_story and not isNil(var_243_2) then
					arg_240_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_240_1.time_ >= var_243_3 + var_243_4 and arg_240_1.time_ < var_243_3 + var_243_4 + arg_243_0 and not isNil(var_243_2) and arg_240_1.var_.characterEffect1019ui_story then
				arg_240_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_243_6 = 0
			local var_243_7 = 1.25

			if var_243_6 < arg_240_1.time_ and arg_240_1.time_ <= var_243_6 + arg_243_0 then
				arg_240_1.talkMaxDuration = 0
				arg_240_1.dialogCg_.alpha = 1

				arg_240_1.dialog_:SetActive(true)
				SetActive(arg_240_1.leftNameGo_, true)

				local var_243_8 = arg_240_1:FormatText(StoryNameCfg[13].name)

				arg_240_1.leftNameTxt_.text = var_243_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_240_1.leftNameTxt_.transform)

				arg_240_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_240_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_240_1:RecordName(arg_240_1.leftNameTxt_.text)
				SetActive(arg_240_1.iconTrs_.gameObject, false)
				arg_240_1.callingController_:SetSelectedState("normal")

				local var_243_9 = arg_240_1:GetWordFromCfg(111072059)
				local var_243_10 = arg_240_1:FormatText(var_243_9.content)

				arg_240_1.text_.text = var_243_10

				LuaForUtil.ClearLinePrefixSymbol(arg_240_1.text_)

				local var_243_11 = 50
				local var_243_12 = utf8.len(var_243_10)
				local var_243_13 = var_243_11 <= 0 and var_243_7 or var_243_7 * (var_243_12 / var_243_11)

				if var_243_13 > 0 and var_243_7 < var_243_13 then
					arg_240_1.talkMaxDuration = var_243_13

					if var_243_13 + var_243_6 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_13 + var_243_6
					end
				end

				arg_240_1.text_.text = var_243_10
				arg_240_1.typewritter.percent = 0

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111072", "111072059", "story_v_out_111072.awb") ~= 0 then
					local var_243_14 = manager.audio:GetVoiceLength("story_v_out_111072", "111072059", "story_v_out_111072.awb") / 1000

					if var_243_14 + var_243_6 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_14 + var_243_6
					end

					if var_243_9.prefab_name ~= "" and arg_240_1.actors_[var_243_9.prefab_name] ~= nil then
						local var_243_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_240_1.actors_[var_243_9.prefab_name].transform, "story_v_out_111072", "111072059", "story_v_out_111072.awb")

						arg_240_1:RecordAudio("111072059", var_243_15)
						arg_240_1:RecordAudio("111072059", var_243_15)
					else
						arg_240_1:AudioAction("play", "voice", "story_v_out_111072", "111072059", "story_v_out_111072.awb")
					end

					arg_240_1:RecordHistoryTalkVoice("story_v_out_111072", "111072059", "story_v_out_111072.awb")
				end

				arg_240_1:RecordContent(arg_240_1.text_.text)
			end

			local var_243_16 = math.max(var_243_7, arg_240_1.talkMaxDuration)

			if var_243_6 <= arg_240_1.time_ and arg_240_1.time_ < var_243_6 + var_243_16 then
				arg_240_1.typewritter.percent = (arg_240_1.time_ - var_243_6) / var_243_16

				arg_240_1.typewritter:SetDirty()
			end

			if arg_240_1.time_ >= var_243_6 + var_243_16 and arg_240_1.time_ < var_243_6 + var_243_16 + arg_243_0 then
				arg_240_1.typewritter.percent = 1

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(true)
			end
		end

		arg_240_1.nodeConfigList_ = {}

		arg_240_1:InitPlayNodeList()
	end,
	Play111072060 = function(arg_244_0, arg_244_1)
		arg_244_1.time_ = 0
		arg_244_1.frameCnt_ = 0
		arg_244_1.state_ = "playing"
		arg_244_1.curTalkId_ = 111072060
		arg_244_1.duration_ = 8.97

		local var_244_0 = {
			ja = 7.7,
			ko = 5.7,
			zh = 6.566,
			en = 8.966
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
				arg_244_0:Play111072061(arg_244_1)
			end
		end

		function arg_244_1.onSingleLineUpdate_(arg_247_0)
			local var_247_0 = 0

			if var_247_0 < arg_244_1.time_ and arg_244_1.time_ <= var_247_0 + arg_247_0 then
				arg_244_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_247_1 = 0
			local var_247_2 = 0.75

			if var_247_1 < arg_244_1.time_ and arg_244_1.time_ <= var_247_1 + arg_247_0 then
				arg_244_1.talkMaxDuration = 0
				arg_244_1.dialogCg_.alpha = 1

				arg_244_1.dialog_:SetActive(true)
				SetActive(arg_244_1.leftNameGo_, true)

				local var_247_3 = arg_244_1:FormatText(StoryNameCfg[13].name)

				arg_244_1.leftNameTxt_.text = var_247_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_244_1.leftNameTxt_.transform)

				arg_244_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_244_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_244_1:RecordName(arg_244_1.leftNameTxt_.text)
				SetActive(arg_244_1.iconTrs_.gameObject, false)
				arg_244_1.callingController_:SetSelectedState("normal")

				local var_247_4 = arg_244_1:GetWordFromCfg(111072060)
				local var_247_5 = arg_244_1:FormatText(var_247_4.content)

				arg_244_1.text_.text = var_247_5

				LuaForUtil.ClearLinePrefixSymbol(arg_244_1.text_)

				local var_247_6 = 30
				local var_247_7 = utf8.len(var_247_5)
				local var_247_8 = var_247_6 <= 0 and var_247_2 or var_247_2 * (var_247_7 / var_247_6)

				if var_247_8 > 0 and var_247_2 < var_247_8 then
					arg_244_1.talkMaxDuration = var_247_8

					if var_247_8 + var_247_1 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_8 + var_247_1
					end
				end

				arg_244_1.text_.text = var_247_5
				arg_244_1.typewritter.percent = 0

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111072", "111072060", "story_v_out_111072.awb") ~= 0 then
					local var_247_9 = manager.audio:GetVoiceLength("story_v_out_111072", "111072060", "story_v_out_111072.awb") / 1000

					if var_247_9 + var_247_1 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_9 + var_247_1
					end

					if var_247_4.prefab_name ~= "" and arg_244_1.actors_[var_247_4.prefab_name] ~= nil then
						local var_247_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_244_1.actors_[var_247_4.prefab_name].transform, "story_v_out_111072", "111072060", "story_v_out_111072.awb")

						arg_244_1:RecordAudio("111072060", var_247_10)
						arg_244_1:RecordAudio("111072060", var_247_10)
					else
						arg_244_1:AudioAction("play", "voice", "story_v_out_111072", "111072060", "story_v_out_111072.awb")
					end

					arg_244_1:RecordHistoryTalkVoice("story_v_out_111072", "111072060", "story_v_out_111072.awb")
				end

				arg_244_1:RecordContent(arg_244_1.text_.text)
			end

			local var_247_11 = math.max(var_247_2, arg_244_1.talkMaxDuration)

			if var_247_1 <= arg_244_1.time_ and arg_244_1.time_ < var_247_1 + var_247_11 then
				arg_244_1.typewritter.percent = (arg_244_1.time_ - var_247_1) / var_247_11

				arg_244_1.typewritter:SetDirty()
			end

			if arg_244_1.time_ >= var_247_1 + var_247_11 and arg_244_1.time_ < var_247_1 + var_247_11 + arg_247_0 then
				arg_244_1.typewritter.percent = 1

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(true)
			end
		end

		arg_244_1.nodeConfigList_ = {}

		arg_244_1:InitPlayNodeList()
	end,
	Play111072061 = function(arg_248_0, arg_248_1)
		arg_248_1.time_ = 0
		arg_248_1.frameCnt_ = 0
		arg_248_1.state_ = "playing"
		arg_248_1.curTalkId_ = 111072061
		arg_248_1.duration_ = 5

		SetActive(arg_248_1.tipsGo_, false)

		function arg_248_1.onSingleLineFinish_()
			arg_248_1.onSingleLineUpdate_ = nil
			arg_248_1.onSingleLineFinish_ = nil
			arg_248_1.state_ = "waiting"
			arg_248_1.auto_ = false
		end

		function arg_248_1.playNext_(arg_250_0)
			arg_248_1.onStoryFinished_()
		end

		function arg_248_1.onSingleLineUpdate_(arg_251_0)
			local var_251_0 = 0
			local var_251_1 = 0.475

			if var_251_0 < arg_248_1.time_ and arg_248_1.time_ <= var_251_0 + arg_251_0 then
				arg_248_1.talkMaxDuration = 0
				arg_248_1.dialogCg_.alpha = 1

				arg_248_1.dialog_:SetActive(true)
				SetActive(arg_248_1.leftNameGo_, true)

				local var_251_2 = arg_248_1:FormatText(StoryNameCfg[7].name)

				arg_248_1.leftNameTxt_.text = var_251_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_248_1.leftNameTxt_.transform)

				arg_248_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_248_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_248_1:RecordName(arg_248_1.leftNameTxt_.text)
				SetActive(arg_248_1.iconTrs_.gameObject, true)
				arg_248_1.iconController_:SetSelectedState("hero")

				arg_248_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_248_1.callingController_:SetSelectedState("normal")

				arg_248_1.keyicon_.color = Color.New(1, 1, 1)
				arg_248_1.icon_.color = Color.New(1, 1, 1)

				local var_251_3 = arg_248_1:GetWordFromCfg(111072061)
				local var_251_4 = arg_248_1:FormatText(var_251_3.content)

				arg_248_1.text_.text = var_251_4

				LuaForUtil.ClearLinePrefixSymbol(arg_248_1.text_)

				local var_251_5 = 19
				local var_251_6 = utf8.len(var_251_4)
				local var_251_7 = var_251_5 <= 0 and var_251_1 or var_251_1 * (var_251_6 / var_251_5)

				if var_251_7 > 0 and var_251_1 < var_251_7 then
					arg_248_1.talkMaxDuration = var_251_7

					if var_251_7 + var_251_0 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_7 + var_251_0
					end
				end

				arg_248_1.text_.text = var_251_4
				arg_248_1.typewritter.percent = 0

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(false)
				arg_248_1:RecordContent(arg_248_1.text_.text)
			end

			local var_251_8 = math.max(var_251_1, arg_248_1.talkMaxDuration)

			if var_251_0 <= arg_248_1.time_ and arg_248_1.time_ < var_251_0 + var_251_8 then
				arg_248_1.typewritter.percent = (arg_248_1.time_ - var_251_0) / var_251_8

				arg_248_1.typewritter:SetDirty()
			end

			if arg_248_1.time_ >= var_251_0 + var_251_8 and arg_248_1.time_ < var_251_0 + var_251_8 + arg_251_0 then
				arg_248_1.typewritter.percent = 1

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(true)
			end
		end

		arg_248_1.nodeConfigList_ = {}

		arg_248_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/D09",
		"TextureConfig/Background/D06a",
		"TextureConfig/Background/ST10"
	},
	voices = {
		"story_v_out_111072.awb"
	}
}
