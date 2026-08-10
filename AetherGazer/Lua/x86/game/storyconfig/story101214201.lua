return {
	Play121421001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 121421001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play121421002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "ST37"

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
				local var_4_5 = arg_1_1.bgs_.ST37

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
					if iter_4_0 ~= "ST37" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = 0

			if var_4_16 < arg_1_1.time_ and arg_1_1.time_ <= var_4_16 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_17 = 2

			if var_4_16 <= arg_1_1.time_ and arg_1_1.time_ < var_4_16 + var_4_17 then
				local var_4_18 = (arg_1_1.time_ - var_4_16) / var_4_17
				local var_4_19 = Color.New(0, 0, 0)

				var_4_19.a = Mathf.Lerp(1, 0, var_4_18)
				arg_1_1.mask_.color = var_4_19
			end

			if arg_1_1.time_ >= var_4_16 + var_4_17 and arg_1_1.time_ < var_4_16 + var_4_17 + arg_4_0 then
				local var_4_20 = Color.New(0, 0, 0)
				local var_4_21 = 0

				arg_1_1.mask_.enabled = false
				var_4_20.a = var_4_21
				arg_1_1.mask_.color = var_4_20
			end

			local var_4_22 = 0
			local var_4_23 = 0.0666666666666667

			if var_4_22 < arg_1_1.time_ and arg_1_1.time_ <= var_4_22 + arg_4_0 then
				local var_4_24 = "play"
				local var_4_25 = "music"

				arg_1_1:AudioAction(var_4_24, var_4_25, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_26 = ""
				local var_4_27 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_27 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_27 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_27

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_27
						arg_1_1.bgmTxt2_.text = var_4_27
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

			local var_4_28 = 0.133333333333333
			local var_4_29 = 1

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				local var_4_30 = "play"
				local var_4_31 = "music"

				arg_1_1:AudioAction(var_4_30, var_4_31, "bgm_side_daily04", "bgm_side_daily04", "bgm_side_daily04.awb")

				local var_4_32 = ""
				local var_4_33 = manager.audio:GetAudioName("bgm_side_daily04", "bgm_side_daily04")

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

			local var_4_34 = 0.266666666666667
			local var_4_35 = 1

			if var_4_34 < arg_1_1.time_ and arg_1_1.time_ <= var_4_34 + arg_4_0 then
				local var_4_36 = "play"
				local var_4_37 = "effect"

				arg_1_1:AudioAction(var_4_36, var_4_37, "se_story_side_1080", "se_story_1080_knock", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_38 = 2
			local var_4_39 = 0.1

			if var_4_38 < arg_1_1.time_ and arg_1_1.time_ <= var_4_38 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_40 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_40:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_40:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_40:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_41 = arg_1_1:GetWordFromCfg(121421001)
				local var_4_42 = arg_1_1:FormatText(var_4_41.content)

				arg_1_1.text_.text = var_4_42

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_43 = 4
				local var_4_44 = utf8.len(var_4_42)
				local var_4_45 = var_4_43 <= 0 and var_4_39 or var_4_39 * (var_4_44 / var_4_43)

				if var_4_45 > 0 and var_4_39 < var_4_45 then
					arg_1_1.talkMaxDuration = var_4_45
					var_4_38 = var_4_38 + 0.3

					if var_4_45 + var_4_38 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_45 + var_4_38
					end
				end

				arg_1_1.text_.text = var_4_42
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_46 = var_4_38 + 0.3
			local var_4_47 = math.max(var_4_39, arg_1_1.talkMaxDuration)

			if var_4_46 <= arg_1_1.time_ and arg_1_1.time_ < var_4_46 + var_4_47 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_46) / var_4_47

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_46 + var_4_47 and arg_1_1.time_ < var_4_46 + var_4_47 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play121421002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 121421002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play121421003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0
			local var_12_1 = 0.975

			if var_12_0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, false)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_2 = arg_9_1:GetWordFromCfg(121421002)
				local var_12_3 = arg_9_1:FormatText(var_12_2.content)

				arg_9_1.text_.text = var_12_3

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_4 = 39
				local var_12_5 = utf8.len(var_12_3)
				local var_12_6 = var_12_4 <= 0 and var_12_1 or var_12_1 * (var_12_5 / var_12_4)

				if var_12_6 > 0 and var_12_1 < var_12_6 then
					arg_9_1.talkMaxDuration = var_12_6

					if var_12_6 + var_12_0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_6 + var_12_0
					end
				end

				arg_9_1.text_.text = var_12_3
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_7 = math.max(var_12_1, arg_9_1.talkMaxDuration)

			if var_12_0 <= arg_9_1.time_ and arg_9_1.time_ < var_12_0 + var_12_7 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_0) / var_12_7

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_0 + var_12_7 and arg_9_1.time_ < var_12_0 + var_12_7 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play121421003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 121421003
		arg_13_1.duration_ = 5.5

		local var_13_0 = {
			ja = 5.5,
			ko = 2.566,
			zh = 2.566
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
				arg_13_0:Play121421004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0
			local var_16_1 = 0.3

			if var_16_0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_2 = arg_13_1:FormatText(StoryNameCfg[431].name)

				arg_13_1.leftNameTxt_.text = var_16_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_3 = arg_13_1:GetWordFromCfg(121421003)
				local var_16_4 = arg_13_1:FormatText(var_16_3.content)

				arg_13_1.text_.text = var_16_4

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_5 = 12
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

				if manager.audio:GetVoiceLength("story_v_out_121421", "121421003", "story_v_out_121421.awb") ~= 0 then
					local var_16_8 = manager.audio:GetVoiceLength("story_v_out_121421", "121421003", "story_v_out_121421.awb") / 1000

					if var_16_8 + var_16_0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_8 + var_16_0
					end

					if var_16_3.prefab_name ~= "" and arg_13_1.actors_[var_16_3.prefab_name] ~= nil then
						local var_16_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_3.prefab_name].transform, "story_v_out_121421", "121421003", "story_v_out_121421.awb")

						arg_13_1:RecordAudio("121421003", var_16_9)
						arg_13_1:RecordAudio("121421003", var_16_9)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_121421", "121421003", "story_v_out_121421.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_121421", "121421003", "story_v_out_121421.awb")
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
	Play121421004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 121421004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play121421005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0
			local var_20_1 = 0.125

			if var_20_0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_0 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_2 = arg_17_1:FormatText(StoryNameCfg[7].name)

				arg_17_1.leftNameTxt_.text = var_20_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, true)
				arg_17_1.iconController_:SetSelectedState("hero")

				arg_17_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_17_1.callingController_:SetSelectedState("normal")

				arg_17_1.keyicon_.color = Color.New(1, 1, 1)
				arg_17_1.icon_.color = Color.New(1, 1, 1)

				local var_20_3 = arg_17_1:GetWordFromCfg(121421004)
				local var_20_4 = arg_17_1:FormatText(var_20_3.content)

				arg_17_1.text_.text = var_20_4

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_5 = 5
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
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_8 = math.max(var_20_1, arg_17_1.talkMaxDuration)

			if var_20_0 <= arg_17_1.time_ and arg_17_1.time_ < var_20_0 + var_20_8 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_0) / var_20_8

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_0 + var_20_8 and arg_17_1.time_ < var_20_0 + var_20_8 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play121421005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 121421005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play121421006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0
			local var_24_1 = 0.85

			if var_24_0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_0 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, false)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_2 = arg_21_1:GetWordFromCfg(121421005)
				local var_24_3 = arg_21_1:FormatText(var_24_2.content)

				arg_21_1.text_.text = var_24_3

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_4 = 34
				local var_24_5 = utf8.len(var_24_3)
				local var_24_6 = var_24_4 <= 0 and var_24_1 or var_24_1 * (var_24_5 / var_24_4)

				if var_24_6 > 0 and var_24_1 < var_24_6 then
					arg_21_1.talkMaxDuration = var_24_6

					if var_24_6 + var_24_0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_6 + var_24_0
					end
				end

				arg_21_1.text_.text = var_24_3
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_7 = math.max(var_24_1, arg_21_1.talkMaxDuration)

			if var_24_0 <= arg_21_1.time_ and arg_21_1.time_ < var_24_0 + var_24_7 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_0) / var_24_7

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_0 + var_24_7 and arg_21_1.time_ < var_24_0 + var_24_7 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play121421006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 121421006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play121421007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0
			local var_28_1 = 0.475

			if var_28_0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_0 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_2 = arg_25_1:FormatText(StoryNameCfg[7].name)

				arg_25_1.leftNameTxt_.text = var_28_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, true)
				arg_25_1.iconController_:SetSelectedState("hero")

				arg_25_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_25_1.callingController_:SetSelectedState("normal")

				arg_25_1.keyicon_.color = Color.New(1, 1, 1)
				arg_25_1.icon_.color = Color.New(1, 1, 1)

				local var_28_3 = arg_25_1:GetWordFromCfg(121421006)
				local var_28_4 = arg_25_1:FormatText(var_28_3.content)

				arg_25_1.text_.text = var_28_4

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_5 = 19
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
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_8 = math.max(var_28_1, arg_25_1.talkMaxDuration)

			if var_28_0 <= arg_25_1.time_ and arg_25_1.time_ < var_28_0 + var_28_8 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_0) / var_28_8

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_0 + var_28_8 and arg_25_1.time_ < var_28_0 + var_28_8 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play121421007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 121421007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play121421008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 0
			local var_32_1 = 0.925

			if var_32_0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_2 = arg_29_1:FormatText(StoryNameCfg[7].name)

				arg_29_1.leftNameTxt_.text = var_32_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, true)
				arg_29_1.iconController_:SetSelectedState("hero")

				arg_29_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_29_1.callingController_:SetSelectedState("normal")

				arg_29_1.keyicon_.color = Color.New(1, 1, 1)
				arg_29_1.icon_.color = Color.New(1, 1, 1)

				local var_32_3 = arg_29_1:GetWordFromCfg(121421007)
				local var_32_4 = arg_29_1:FormatText(var_32_3.content)

				arg_29_1.text_.text = var_32_4

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_5 = 37
				local var_32_6 = utf8.len(var_32_4)
				local var_32_7 = var_32_5 <= 0 and var_32_1 or var_32_1 * (var_32_6 / var_32_5)

				if var_32_7 > 0 and var_32_1 < var_32_7 then
					arg_29_1.talkMaxDuration = var_32_7

					if var_32_7 + var_32_0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_7 + var_32_0
					end
				end

				arg_29_1.text_.text = var_32_4
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_8 = math.max(var_32_1, arg_29_1.talkMaxDuration)

			if var_32_0 <= arg_29_1.time_ and arg_29_1.time_ < var_32_0 + var_32_8 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_0) / var_32_8

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_0 + var_32_8 and arg_29_1.time_ < var_32_0 + var_32_8 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play121421008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 121421008
		arg_33_1.duration_ = 5.27

		local var_33_0 = {
			ja = 5.266,
			ko = 4.266,
			zh = 4.266
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
				arg_33_0:Play121421009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = "1084ui_story"

			if arg_33_1.actors_[var_36_0] == nil then
				local var_36_1 = Asset.Load("Char/" .. "1084ui_story")

				if not isNil(var_36_1) then
					local var_36_2 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_33_1.stage_.transform)

					var_36_2.name = var_36_0
					var_36_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_33_1.actors_[var_36_0] = var_36_2

					local var_36_3 = var_36_2:GetComponentInChildren(typeof(CharacterEffect))

					var_36_3.enabled = true

					local var_36_4 = GameObjectTools.GetOrAddComponent(var_36_2, typeof(DynamicBoneHelper))

					if var_36_4 then
						var_36_4:EnableDynamicBone(false)
					end

					arg_33_1:ShowWeapon(var_36_3.transform, false)

					arg_33_1.var_[var_36_0 .. "Animator"] = var_36_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_33_1.var_[var_36_0 .. "Animator"].applyRootMotion = true
					arg_33_1.var_[var_36_0 .. "LipSync"] = var_36_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_36_5 = arg_33_1.actors_["1084ui_story"].transform
			local var_36_6 = 0

			if var_36_6 < arg_33_1.time_ and arg_33_1.time_ <= var_36_6 + arg_36_0 then
				arg_33_1.var_.moveOldPos1084ui_story = var_36_5.localPosition
			end

			local var_36_7 = 0.001

			if var_36_6 <= arg_33_1.time_ and arg_33_1.time_ < var_36_6 + var_36_7 then
				local var_36_8 = (arg_33_1.time_ - var_36_6) / var_36_7
				local var_36_9 = Vector3.New(0, -0.97, -6)

				var_36_5.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos1084ui_story, var_36_9, var_36_8)

				local var_36_10 = manager.ui.mainCamera.transform.position - var_36_5.position

				var_36_5.forward = Vector3.New(var_36_10.x, var_36_10.y, var_36_10.z)

				local var_36_11 = var_36_5.localEulerAngles

				var_36_11.z = 0
				var_36_11.x = 0
				var_36_5.localEulerAngles = var_36_11
			end

			if arg_33_1.time_ >= var_36_6 + var_36_7 and arg_33_1.time_ < var_36_6 + var_36_7 + arg_36_0 then
				var_36_5.localPosition = Vector3.New(0, -0.97, -6)

				local var_36_12 = manager.ui.mainCamera.transform.position - var_36_5.position

				var_36_5.forward = Vector3.New(var_36_12.x, var_36_12.y, var_36_12.z)

				local var_36_13 = var_36_5.localEulerAngles

				var_36_13.z = 0
				var_36_13.x = 0
				var_36_5.localEulerAngles = var_36_13
			end

			local var_36_14 = arg_33_1.actors_["1084ui_story"]
			local var_36_15 = 0

			if var_36_15 < arg_33_1.time_ and arg_33_1.time_ <= var_36_15 + arg_36_0 and not isNil(var_36_14) and arg_33_1.var_.characterEffect1084ui_story == nil then
				arg_33_1.var_.characterEffect1084ui_story = var_36_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_16 = 0.200000002980232

			if var_36_15 <= arg_33_1.time_ and arg_33_1.time_ < var_36_15 + var_36_16 and not isNil(var_36_14) then
				local var_36_17 = (arg_33_1.time_ - var_36_15) / var_36_16

				if arg_33_1.var_.characterEffect1084ui_story and not isNil(var_36_14) then
					arg_33_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= var_36_15 + var_36_16 and arg_33_1.time_ < var_36_15 + var_36_16 + arg_36_0 and not isNil(var_36_14) and arg_33_1.var_.characterEffect1084ui_story then
				arg_33_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_36_18 = 0

			if var_36_18 < arg_33_1.time_ and arg_33_1.time_ <= var_36_18 + arg_36_0 then
				arg_33_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action4_1")
			end

			local var_36_19 = 0

			if var_36_19 < arg_33_1.time_ and arg_33_1.time_ <= var_36_19 + arg_36_0 then
				arg_33_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_36_20 = 0
			local var_36_21 = 0.525

			if var_36_20 < arg_33_1.time_ and arg_33_1.time_ <= var_36_20 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_22 = arg_33_1:FormatText(StoryNameCfg[6].name)

				arg_33_1.leftNameTxt_.text = var_36_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_23 = arg_33_1:GetWordFromCfg(121421008)
				local var_36_24 = arg_33_1:FormatText(var_36_23.content)

				arg_33_1.text_.text = var_36_24

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_25 = 21
				local var_36_26 = utf8.len(var_36_24)
				local var_36_27 = var_36_25 <= 0 and var_36_21 or var_36_21 * (var_36_26 / var_36_25)

				if var_36_27 > 0 and var_36_21 < var_36_27 then
					arg_33_1.talkMaxDuration = var_36_27

					if var_36_27 + var_36_20 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_27 + var_36_20
					end
				end

				arg_33_1.text_.text = var_36_24
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121421", "121421008", "story_v_out_121421.awb") ~= 0 then
					local var_36_28 = manager.audio:GetVoiceLength("story_v_out_121421", "121421008", "story_v_out_121421.awb") / 1000

					if var_36_28 + var_36_20 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_28 + var_36_20
					end

					if var_36_23.prefab_name ~= "" and arg_33_1.actors_[var_36_23.prefab_name] ~= nil then
						local var_36_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_23.prefab_name].transform, "story_v_out_121421", "121421008", "story_v_out_121421.awb")

						arg_33_1:RecordAudio("121421008", var_36_29)
						arg_33_1:RecordAudio("121421008", var_36_29)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_121421", "121421008", "story_v_out_121421.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_121421", "121421008", "story_v_out_121421.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_30 = math.max(var_36_21, arg_33_1.talkMaxDuration)

			if var_36_20 <= arg_33_1.time_ and arg_33_1.time_ < var_36_20 + var_36_30 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_20) / var_36_30

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_20 + var_36_30 and arg_33_1.time_ < var_36_20 + var_36_30 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
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

		arg_33_1:InitPlayNodeList()
	end,
	Play121421009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 121421009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play121421010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = arg_37_1.actors_["1084ui_story"].transform
			local var_40_1 = 0

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 then
				arg_37_1.var_.moveOldPos1084ui_story = var_40_0.localPosition
			end

			local var_40_2 = 0.001

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_2 then
				local var_40_3 = (arg_37_1.time_ - var_40_1) / var_40_2
				local var_40_4 = Vector3.New(0, 100, 0)

				var_40_0.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos1084ui_story, var_40_4, var_40_3)

				local var_40_5 = manager.ui.mainCamera.transform.position - var_40_0.position

				var_40_0.forward = Vector3.New(var_40_5.x, var_40_5.y, var_40_5.z)

				local var_40_6 = var_40_0.localEulerAngles

				var_40_6.z = 0
				var_40_6.x = 0
				var_40_0.localEulerAngles = var_40_6
			end

			if arg_37_1.time_ >= var_40_1 + var_40_2 and arg_37_1.time_ < var_40_1 + var_40_2 + arg_40_0 then
				var_40_0.localPosition = Vector3.New(0, 100, 0)

				local var_40_7 = manager.ui.mainCamera.transform.position - var_40_0.position

				var_40_0.forward = Vector3.New(var_40_7.x, var_40_7.y, var_40_7.z)

				local var_40_8 = var_40_0.localEulerAngles

				var_40_8.z = 0
				var_40_8.x = 0
				var_40_0.localEulerAngles = var_40_8
			end

			local var_40_9 = arg_37_1.actors_["1084ui_story"]
			local var_40_10 = 0

			if var_40_10 < arg_37_1.time_ and arg_37_1.time_ <= var_40_10 + arg_40_0 and not isNil(var_40_9) and arg_37_1.var_.characterEffect1084ui_story == nil then
				arg_37_1.var_.characterEffect1084ui_story = var_40_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_11 = 0.200000002980232

			if var_40_10 <= arg_37_1.time_ and arg_37_1.time_ < var_40_10 + var_40_11 and not isNil(var_40_9) then
				local var_40_12 = (arg_37_1.time_ - var_40_10) / var_40_11

				if arg_37_1.var_.characterEffect1084ui_story and not isNil(var_40_9) then
					local var_40_13 = Mathf.Lerp(0, 0.5, var_40_12)

					arg_37_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_37_1.var_.characterEffect1084ui_story.fillRatio = var_40_13
				end
			end

			if arg_37_1.time_ >= var_40_10 + var_40_11 and arg_37_1.time_ < var_40_10 + var_40_11 + arg_40_0 and not isNil(var_40_9) and arg_37_1.var_.characterEffect1084ui_story then
				local var_40_14 = 0.5

				arg_37_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_37_1.var_.characterEffect1084ui_story.fillRatio = var_40_14
			end

			local var_40_15 = 0
			local var_40_16 = 0.875

			if var_40_15 < arg_37_1.time_ and arg_37_1.time_ <= var_40_15 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, false)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_17 = arg_37_1:GetWordFromCfg(121421009)
				local var_40_18 = arg_37_1:FormatText(var_40_17.content)

				arg_37_1.text_.text = var_40_18

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_19 = 35
				local var_40_20 = utf8.len(var_40_18)
				local var_40_21 = var_40_19 <= 0 and var_40_16 or var_40_16 * (var_40_20 / var_40_19)

				if var_40_21 > 0 and var_40_16 < var_40_21 then
					arg_37_1.talkMaxDuration = var_40_21

					if var_40_21 + var_40_15 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_21 + var_40_15
					end
				end

				arg_37_1.text_.text = var_40_18
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_22 = math.max(var_40_16, arg_37_1.talkMaxDuration)

			if var_40_15 <= arg_37_1.time_ and arg_37_1.time_ < var_40_15 + var_40_22 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_15) / var_40_22

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_15 + var_40_22 and arg_37_1.time_ < var_40_15 + var_40_22 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
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

		arg_37_1:InitPlayNodeList()
	end,
	Play121421010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 121421010
		arg_41_1.duration_ = 14.17

		local var_41_0 = {
			ja = 14.166,
			ko = 9.6,
			zh = 9.6
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
				arg_41_0:Play121421011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = 0
			local var_44_1 = 1.25

			if var_44_0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_0 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_2 = arg_41_1:FormatText(StoryNameCfg[368].name)

				arg_41_1.leftNameTxt_.text = var_44_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, true)
				arg_41_1.iconController_:SetSelectedState("hero")

				arg_41_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_reporterw")

				arg_41_1.callingController_:SetSelectedState("normal")

				arg_41_1.keyicon_.color = Color.New(1, 1, 1)
				arg_41_1.icon_.color = Color.New(1, 1, 1)

				local var_44_3 = arg_41_1:GetWordFromCfg(121421010)
				local var_44_4 = arg_41_1:FormatText(var_44_3.content)

				arg_41_1.text_.text = var_44_4

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_5 = 50
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

				if manager.audio:GetVoiceLength("story_v_out_121421", "121421010", "story_v_out_121421.awb") ~= 0 then
					local var_44_8 = manager.audio:GetVoiceLength("story_v_out_121421", "121421010", "story_v_out_121421.awb") / 1000

					if var_44_8 + var_44_0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_8 + var_44_0
					end

					if var_44_3.prefab_name ~= "" and arg_41_1.actors_[var_44_3.prefab_name] ~= nil then
						local var_44_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_3.prefab_name].transform, "story_v_out_121421", "121421010", "story_v_out_121421.awb")

						arg_41_1:RecordAudio("121421010", var_44_9)
						arg_41_1:RecordAudio("121421010", var_44_9)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_121421", "121421010", "story_v_out_121421.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_121421", "121421010", "story_v_out_121421.awb")
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
	Play121421011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 121421011
		arg_45_1.duration_ = 14.6

		local var_45_0 = {
			ja = 14.6,
			ko = 11.5,
			zh = 11.5
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
				arg_45_0:Play121421012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 0
			local var_48_1 = 1.35

			if var_48_0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_0 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_2 = arg_45_1:FormatText(StoryNameCfg[368].name)

				arg_45_1.leftNameTxt_.text = var_48_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, true)
				arg_45_1.iconController_:SetSelectedState("hero")

				arg_45_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_reporterw")

				arg_45_1.callingController_:SetSelectedState("normal")

				arg_45_1.keyicon_.color = Color.New(1, 1, 1)
				arg_45_1.icon_.color = Color.New(1, 1, 1)

				local var_48_3 = arg_45_1:GetWordFromCfg(121421011)
				local var_48_4 = arg_45_1:FormatText(var_48_3.content)

				arg_45_1.text_.text = var_48_4

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_5 = 54
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

				if manager.audio:GetVoiceLength("story_v_out_121421", "121421011", "story_v_out_121421.awb") ~= 0 then
					local var_48_8 = manager.audio:GetVoiceLength("story_v_out_121421", "121421011", "story_v_out_121421.awb") / 1000

					if var_48_8 + var_48_0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_8 + var_48_0
					end

					if var_48_3.prefab_name ~= "" and arg_45_1.actors_[var_48_3.prefab_name] ~= nil then
						local var_48_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_3.prefab_name].transform, "story_v_out_121421", "121421011", "story_v_out_121421.awb")

						arg_45_1:RecordAudio("121421011", var_48_9)
						arg_45_1:RecordAudio("121421011", var_48_9)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_121421", "121421011", "story_v_out_121421.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_121421", "121421011", "story_v_out_121421.awb")
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
	Play121421012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 121421012
		arg_49_1.duration_ = 13.87

		local var_49_0 = {
			ja = 13.866,
			ko = 11.2,
			zh = 11.2
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
				arg_49_0:Play121421013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 0
			local var_52_1 = 1.4

			if var_52_0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_0 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_2 = arg_49_1:FormatText(StoryNameCfg[368].name)

				arg_49_1.leftNameTxt_.text = var_52_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, true)
				arg_49_1.iconController_:SetSelectedState("hero")

				arg_49_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_reporterw")

				arg_49_1.callingController_:SetSelectedState("normal")

				arg_49_1.keyicon_.color = Color.New(1, 1, 1)
				arg_49_1.icon_.color = Color.New(1, 1, 1)

				local var_52_3 = arg_49_1:GetWordFromCfg(121421012)
				local var_52_4 = arg_49_1:FormatText(var_52_3.content)

				arg_49_1.text_.text = var_52_4

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_5 = 56
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

				if manager.audio:GetVoiceLength("story_v_out_121421", "121421012", "story_v_out_121421.awb") ~= 0 then
					local var_52_8 = manager.audio:GetVoiceLength("story_v_out_121421", "121421012", "story_v_out_121421.awb") / 1000

					if var_52_8 + var_52_0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_8 + var_52_0
					end

					if var_52_3.prefab_name ~= "" and arg_49_1.actors_[var_52_3.prefab_name] ~= nil then
						local var_52_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_3.prefab_name].transform, "story_v_out_121421", "121421012", "story_v_out_121421.awb")

						arg_49_1:RecordAudio("121421012", var_52_9)
						arg_49_1:RecordAudio("121421012", var_52_9)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_121421", "121421012", "story_v_out_121421.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_121421", "121421012", "story_v_out_121421.awb")
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
	Play121421013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 121421013
		arg_53_1.duration_ = 12.97

		local var_53_0 = {
			ja = 12.966,
			ko = 9.733,
			zh = 9.733
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
				arg_53_0:Play121421014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 0
			local var_56_1 = 1.175

			if var_56_0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_2 = arg_53_1:FormatText(StoryNameCfg[368].name)

				arg_53_1.leftNameTxt_.text = var_56_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, true)
				arg_53_1.iconController_:SetSelectedState("hero")

				arg_53_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_reporterw")

				arg_53_1.callingController_:SetSelectedState("normal")

				arg_53_1.keyicon_.color = Color.New(1, 1, 1)
				arg_53_1.icon_.color = Color.New(1, 1, 1)

				local var_56_3 = arg_53_1:GetWordFromCfg(121421013)
				local var_56_4 = arg_53_1:FormatText(var_56_3.content)

				arg_53_1.text_.text = var_56_4

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_5 = 47
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

				if manager.audio:GetVoiceLength("story_v_out_121421", "121421013", "story_v_out_121421.awb") ~= 0 then
					local var_56_8 = manager.audio:GetVoiceLength("story_v_out_121421", "121421013", "story_v_out_121421.awb") / 1000

					if var_56_8 + var_56_0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_8 + var_56_0
					end

					if var_56_3.prefab_name ~= "" and arg_53_1.actors_[var_56_3.prefab_name] ~= nil then
						local var_56_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_3.prefab_name].transform, "story_v_out_121421", "121421013", "story_v_out_121421.awb")

						arg_53_1:RecordAudio("121421013", var_56_9)
						arg_53_1:RecordAudio("121421013", var_56_9)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_121421", "121421013", "story_v_out_121421.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_121421", "121421013", "story_v_out_121421.awb")
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
	Play121421014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 121421014
		arg_57_1.duration_ = 5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play121421015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = 0
			local var_60_1 = 1.175

			if var_60_0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_0 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_2 = arg_57_1:FormatText(StoryNameCfg[7].name)

				arg_57_1.leftNameTxt_.text = var_60_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, true)
				arg_57_1.iconController_:SetSelectedState("hero")

				arg_57_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_57_1.callingController_:SetSelectedState("normal")

				arg_57_1.keyicon_.color = Color.New(1, 1, 1)
				arg_57_1.icon_.color = Color.New(1, 1, 1)

				local var_60_3 = arg_57_1:GetWordFromCfg(121421014)
				local var_60_4 = arg_57_1:FormatText(var_60_3.content)

				arg_57_1.text_.text = var_60_4

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_5 = 47
				local var_60_6 = utf8.len(var_60_4)
				local var_60_7 = var_60_5 <= 0 and var_60_1 or var_60_1 * (var_60_6 / var_60_5)

				if var_60_7 > 0 and var_60_1 < var_60_7 then
					arg_57_1.talkMaxDuration = var_60_7

					if var_60_7 + var_60_0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_7 + var_60_0
					end
				end

				arg_57_1.text_.text = var_60_4
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)
				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_8 = math.max(var_60_1, arg_57_1.talkMaxDuration)

			if var_60_0 <= arg_57_1.time_ and arg_57_1.time_ < var_60_0 + var_60_8 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_0) / var_60_8

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_0 + var_60_8 and arg_57_1.time_ < var_60_0 + var_60_8 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play121421015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 121421015
		arg_61_1.duration_ = 5

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play121421016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = 0
			local var_64_1 = 0.5

			if var_64_0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_0 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_2 = arg_61_1:FormatText(StoryNameCfg[7].name)

				arg_61_1.leftNameTxt_.text = var_64_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, true)
				arg_61_1.iconController_:SetSelectedState("hero")

				arg_61_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_61_1.callingController_:SetSelectedState("normal")

				arg_61_1.keyicon_.color = Color.New(1, 1, 1)
				arg_61_1.icon_.color = Color.New(1, 1, 1)

				local var_64_3 = arg_61_1:GetWordFromCfg(121421015)
				local var_64_4 = arg_61_1:FormatText(var_64_3.content)

				arg_61_1.text_.text = var_64_4

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_5 = 20
				local var_64_6 = utf8.len(var_64_4)
				local var_64_7 = var_64_5 <= 0 and var_64_1 or var_64_1 * (var_64_6 / var_64_5)

				if var_64_7 > 0 and var_64_1 < var_64_7 then
					arg_61_1.talkMaxDuration = var_64_7

					if var_64_7 + var_64_0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_7 + var_64_0
					end
				end

				arg_61_1.text_.text = var_64_4
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)
				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_8 = math.max(var_64_1, arg_61_1.talkMaxDuration)

			if var_64_0 <= arg_61_1.time_ and arg_61_1.time_ < var_64_0 + var_64_8 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_0) / var_64_8

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_0 + var_64_8 and arg_61_1.time_ < var_64_0 + var_64_8 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play121421016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 121421016
		arg_65_1.duration_ = 5.37

		local var_65_0 = {
			ja = 5.366,
			ko = 2.1,
			zh = 2.1
		}
		local var_65_1 = manager.audio:GetLocalizationFlag()

		if var_65_0[var_65_1] ~= nil then
			arg_65_1.duration_ = var_65_0[var_65_1]
		end

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play121421017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = arg_65_1.actors_["1084ui_story"].transform
			local var_68_1 = 0

			if var_68_1 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 then
				arg_65_1.var_.moveOldPos1084ui_story = var_68_0.localPosition
			end

			local var_68_2 = 0.001

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_2 then
				local var_68_3 = (arg_65_1.time_ - var_68_1) / var_68_2
				local var_68_4 = Vector3.New(0, -0.97, -6)

				var_68_0.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos1084ui_story, var_68_4, var_68_3)

				local var_68_5 = manager.ui.mainCamera.transform.position - var_68_0.position

				var_68_0.forward = Vector3.New(var_68_5.x, var_68_5.y, var_68_5.z)

				local var_68_6 = var_68_0.localEulerAngles

				var_68_6.z = 0
				var_68_6.x = 0
				var_68_0.localEulerAngles = var_68_6
			end

			if arg_65_1.time_ >= var_68_1 + var_68_2 and arg_65_1.time_ < var_68_1 + var_68_2 + arg_68_0 then
				var_68_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_68_7 = manager.ui.mainCamera.transform.position - var_68_0.position

				var_68_0.forward = Vector3.New(var_68_7.x, var_68_7.y, var_68_7.z)

				local var_68_8 = var_68_0.localEulerAngles

				var_68_8.z = 0
				var_68_8.x = 0
				var_68_0.localEulerAngles = var_68_8
			end

			local var_68_9 = arg_65_1.actors_["1084ui_story"]
			local var_68_10 = 0

			if var_68_10 < arg_65_1.time_ and arg_65_1.time_ <= var_68_10 + arg_68_0 and not isNil(var_68_9) and arg_65_1.var_.characterEffect1084ui_story == nil then
				arg_65_1.var_.characterEffect1084ui_story = var_68_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_11 = 0.200000002980232

			if var_68_10 <= arg_65_1.time_ and arg_65_1.time_ < var_68_10 + var_68_11 and not isNil(var_68_9) then
				local var_68_12 = (arg_65_1.time_ - var_68_10) / var_68_11

				if arg_65_1.var_.characterEffect1084ui_story and not isNil(var_68_9) then
					arg_65_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= var_68_10 + var_68_11 and arg_65_1.time_ < var_68_10 + var_68_11 + arg_68_0 and not isNil(var_68_9) and arg_65_1.var_.characterEffect1084ui_story then
				arg_65_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_68_13 = 0

			if var_68_13 < arg_65_1.time_ and arg_65_1.time_ <= var_68_13 + arg_68_0 then
				arg_65_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_68_14 = 0

			if var_68_14 < arg_65_1.time_ and arg_65_1.time_ <= var_68_14 + arg_68_0 then
				arg_65_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action12_1")
			end

			local var_68_15 = 0
			local var_68_16 = 0.25

			if var_68_15 < arg_65_1.time_ and arg_65_1.time_ <= var_68_15 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_17 = arg_65_1:FormatText(StoryNameCfg[6].name)

				arg_65_1.leftNameTxt_.text = var_68_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_18 = arg_65_1:GetWordFromCfg(121421016)
				local var_68_19 = arg_65_1:FormatText(var_68_18.content)

				arg_65_1.text_.text = var_68_19

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_20 = 10
				local var_68_21 = utf8.len(var_68_19)
				local var_68_22 = var_68_20 <= 0 and var_68_16 or var_68_16 * (var_68_21 / var_68_20)

				if var_68_22 > 0 and var_68_16 < var_68_22 then
					arg_65_1.talkMaxDuration = var_68_22

					if var_68_22 + var_68_15 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_22 + var_68_15
					end
				end

				arg_65_1.text_.text = var_68_19
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121421", "121421016", "story_v_out_121421.awb") ~= 0 then
					local var_68_23 = manager.audio:GetVoiceLength("story_v_out_121421", "121421016", "story_v_out_121421.awb") / 1000

					if var_68_23 + var_68_15 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_23 + var_68_15
					end

					if var_68_18.prefab_name ~= "" and arg_65_1.actors_[var_68_18.prefab_name] ~= nil then
						local var_68_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_18.prefab_name].transform, "story_v_out_121421", "121421016", "story_v_out_121421.awb")

						arg_65_1:RecordAudio("121421016", var_68_24)
						arg_65_1:RecordAudio("121421016", var_68_24)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_121421", "121421016", "story_v_out_121421.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_121421", "121421016", "story_v_out_121421.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_25 = math.max(var_68_16, arg_65_1.talkMaxDuration)

			if var_68_15 <= arg_65_1.time_ and arg_65_1.time_ < var_68_15 + var_68_25 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_15) / var_68_25

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_15 + var_68_25 and arg_65_1.time_ < var_68_15 + var_68_25 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {
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

		arg_65_1:InitPlayNodeList()
	end,
	Play121421017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 121421017
		arg_69_1.duration_ = 6.2

		local var_69_0 = {
			ja = 6.033,
			ko = 6.2,
			zh = 6.2
		}
		local var_69_1 = manager.audio:GetLocalizationFlag()

		if var_69_0[var_69_1] ~= nil then
			arg_69_1.duration_ = var_69_0[var_69_1]
		end

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play121421018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = 0
			local var_72_1 = 0.925

			if var_72_0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_0 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_2 = arg_69_1:FormatText(StoryNameCfg[6].name)

				arg_69_1.leftNameTxt_.text = var_72_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_3 = arg_69_1:GetWordFromCfg(121421017)
				local var_72_4 = arg_69_1:FormatText(var_72_3.content)

				arg_69_1.text_.text = var_72_4

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_5 = 37
				local var_72_6 = utf8.len(var_72_4)
				local var_72_7 = var_72_5 <= 0 and var_72_1 or var_72_1 * (var_72_6 / var_72_5)

				if var_72_7 > 0 and var_72_1 < var_72_7 then
					arg_69_1.talkMaxDuration = var_72_7

					if var_72_7 + var_72_0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_7 + var_72_0
					end
				end

				arg_69_1.text_.text = var_72_4
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121421", "121421017", "story_v_out_121421.awb") ~= 0 then
					local var_72_8 = manager.audio:GetVoiceLength("story_v_out_121421", "121421017", "story_v_out_121421.awb") / 1000

					if var_72_8 + var_72_0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_8 + var_72_0
					end

					if var_72_3.prefab_name ~= "" and arg_69_1.actors_[var_72_3.prefab_name] ~= nil then
						local var_72_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_3.prefab_name].transform, "story_v_out_121421", "121421017", "story_v_out_121421.awb")

						arg_69_1:RecordAudio("121421017", var_72_9)
						arg_69_1:RecordAudio("121421017", var_72_9)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_121421", "121421017", "story_v_out_121421.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_121421", "121421017", "story_v_out_121421.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_10 = math.max(var_72_1, arg_69_1.talkMaxDuration)

			if var_72_0 <= arg_69_1.time_ and arg_69_1.time_ < var_72_0 + var_72_10 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_0) / var_72_10

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_0 + var_72_10 and arg_69_1.time_ < var_72_0 + var_72_10 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play121421018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 121421018
		arg_73_1.duration_ = 5

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play121421019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = arg_73_1.actors_["1084ui_story"]
			local var_76_1 = 0

			if var_76_1 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 and not isNil(var_76_0) and arg_73_1.var_.characterEffect1084ui_story == nil then
				arg_73_1.var_.characterEffect1084ui_story = var_76_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_2 = 0.200000002980232

			if var_76_1 <= arg_73_1.time_ and arg_73_1.time_ < var_76_1 + var_76_2 and not isNil(var_76_0) then
				local var_76_3 = (arg_73_1.time_ - var_76_1) / var_76_2

				if arg_73_1.var_.characterEffect1084ui_story and not isNil(var_76_0) then
					local var_76_4 = Mathf.Lerp(0, 0.5, var_76_3)

					arg_73_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_73_1.var_.characterEffect1084ui_story.fillRatio = var_76_4
				end
			end

			if arg_73_1.time_ >= var_76_1 + var_76_2 and arg_73_1.time_ < var_76_1 + var_76_2 + arg_76_0 and not isNil(var_76_0) and arg_73_1.var_.characterEffect1084ui_story then
				local var_76_5 = 0.5

				arg_73_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_73_1.var_.characterEffect1084ui_story.fillRatio = var_76_5
			end

			local var_76_6 = 0
			local var_76_7 = 0.25

			if var_76_6 < arg_73_1.time_ and arg_73_1.time_ <= var_76_6 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				local var_76_8 = arg_73_1:FormatText(StoryNameCfg[7].name)

				arg_73_1.leftNameTxt_.text = var_76_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, true)
				arg_73_1.iconController_:SetSelectedState("hero")

				arg_73_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_73_1.callingController_:SetSelectedState("normal")

				arg_73_1.keyicon_.color = Color.New(1, 1, 1)
				arg_73_1.icon_.color = Color.New(1, 1, 1)

				local var_76_9 = arg_73_1:GetWordFromCfg(121421018)
				local var_76_10 = arg_73_1:FormatText(var_76_9.content)

				arg_73_1.text_.text = var_76_10

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_11 = 10
				local var_76_12 = utf8.len(var_76_10)
				local var_76_13 = var_76_11 <= 0 and var_76_7 or var_76_7 * (var_76_12 / var_76_11)

				if var_76_13 > 0 and var_76_7 < var_76_13 then
					arg_73_1.talkMaxDuration = var_76_13

					if var_76_13 + var_76_6 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_13 + var_76_6
					end
				end

				arg_73_1.text_.text = var_76_10
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)
				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_14 = math.max(var_76_7, arg_73_1.talkMaxDuration)

			if var_76_6 <= arg_73_1.time_ and arg_73_1.time_ < var_76_6 + var_76_14 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_6) / var_76_14

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_6 + var_76_14 and arg_73_1.time_ < var_76_6 + var_76_14 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play121421019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 121421019
		arg_77_1.duration_ = 5

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play121421020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = 0
			local var_80_1 = 0.9

			if var_80_0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_0 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				local var_80_2 = arg_77_1:FormatText(StoryNameCfg[7].name)

				arg_77_1.leftNameTxt_.text = var_80_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, true)
				arg_77_1.iconController_:SetSelectedState("hero")

				arg_77_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_77_1.callingController_:SetSelectedState("normal")

				arg_77_1.keyicon_.color = Color.New(1, 1, 1)
				arg_77_1.icon_.color = Color.New(1, 1, 1)

				local var_80_3 = arg_77_1:GetWordFromCfg(121421019)
				local var_80_4 = arg_77_1:FormatText(var_80_3.content)

				arg_77_1.text_.text = var_80_4

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_5 = 36
				local var_80_6 = utf8.len(var_80_4)
				local var_80_7 = var_80_5 <= 0 and var_80_1 or var_80_1 * (var_80_6 / var_80_5)

				if var_80_7 > 0 and var_80_1 < var_80_7 then
					arg_77_1.talkMaxDuration = var_80_7

					if var_80_7 + var_80_0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_7 + var_80_0
					end
				end

				arg_77_1.text_.text = var_80_4
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)
				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_8 = math.max(var_80_1, arg_77_1.talkMaxDuration)

			if var_80_0 <= arg_77_1.time_ and arg_77_1.time_ < var_80_0 + var_80_8 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_0) / var_80_8

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_0 + var_80_8 and arg_77_1.time_ < var_80_0 + var_80_8 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play121421020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 121421020
		arg_81_1.duration_ = 5.83

		local var_81_0 = {
			ja = 5.833,
			ko = 5.466,
			zh = 5.466
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
				arg_81_0:Play121421021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = arg_81_1.actors_["1084ui_story"]
			local var_84_1 = 0

			if var_84_1 < arg_81_1.time_ and arg_81_1.time_ <= var_84_1 + arg_84_0 and not isNil(var_84_0) and arg_81_1.var_.characterEffect1084ui_story == nil then
				arg_81_1.var_.characterEffect1084ui_story = var_84_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_2 = 0.200000002980232

			if var_84_1 <= arg_81_1.time_ and arg_81_1.time_ < var_84_1 + var_84_2 and not isNil(var_84_0) then
				local var_84_3 = (arg_81_1.time_ - var_84_1) / var_84_2

				if arg_81_1.var_.characterEffect1084ui_story and not isNil(var_84_0) then
					arg_81_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_81_1.time_ >= var_84_1 + var_84_2 and arg_81_1.time_ < var_84_1 + var_84_2 + arg_84_0 and not isNil(var_84_0) and arg_81_1.var_.characterEffect1084ui_story then
				arg_81_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_84_4 = 0

			if var_84_4 < arg_81_1.time_ and arg_81_1.time_ <= var_84_4 + arg_84_0 then
				arg_81_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action41213")
			end

			local var_84_5 = 0
			local var_84_6 = 0.525

			if var_84_5 < arg_81_1.time_ and arg_81_1.time_ <= var_84_5 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				local var_84_7 = arg_81_1:FormatText(StoryNameCfg[6].name)

				arg_81_1.leftNameTxt_.text = var_84_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_8 = arg_81_1:GetWordFromCfg(121421020)
				local var_84_9 = arg_81_1:FormatText(var_84_8.content)

				arg_81_1.text_.text = var_84_9

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_10 = 21
				local var_84_11 = utf8.len(var_84_9)
				local var_84_12 = var_84_10 <= 0 and var_84_6 or var_84_6 * (var_84_11 / var_84_10)

				if var_84_12 > 0 and var_84_6 < var_84_12 then
					arg_81_1.talkMaxDuration = var_84_12

					if var_84_12 + var_84_5 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_12 + var_84_5
					end
				end

				arg_81_1.text_.text = var_84_9
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121421", "121421020", "story_v_out_121421.awb") ~= 0 then
					local var_84_13 = manager.audio:GetVoiceLength("story_v_out_121421", "121421020", "story_v_out_121421.awb") / 1000

					if var_84_13 + var_84_5 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_13 + var_84_5
					end

					if var_84_8.prefab_name ~= "" and arg_81_1.actors_[var_84_8.prefab_name] ~= nil then
						local var_84_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_8.prefab_name].transform, "story_v_out_121421", "121421020", "story_v_out_121421.awb")

						arg_81_1:RecordAudio("121421020", var_84_14)
						arg_81_1:RecordAudio("121421020", var_84_14)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_121421", "121421020", "story_v_out_121421.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_121421", "121421020", "story_v_out_121421.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_15 = math.max(var_84_6, arg_81_1.talkMaxDuration)

			if var_84_5 <= arg_81_1.time_ and arg_81_1.time_ < var_84_5 + var_84_15 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_5) / var_84_15

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_5 + var_84_15 and arg_81_1.time_ < var_84_5 + var_84_15 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play121421021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 121421021
		arg_85_1.duration_ = 5

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play121421022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = arg_85_1.actors_["1084ui_story"]
			local var_88_1 = 0

			if var_88_1 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 and not isNil(var_88_0) and arg_85_1.var_.characterEffect1084ui_story == nil then
				arg_85_1.var_.characterEffect1084ui_story = var_88_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_2 = 0.200000002980232

			if var_88_1 <= arg_85_1.time_ and arg_85_1.time_ < var_88_1 + var_88_2 and not isNil(var_88_0) then
				local var_88_3 = (arg_85_1.time_ - var_88_1) / var_88_2

				if arg_85_1.var_.characterEffect1084ui_story and not isNil(var_88_0) then
					local var_88_4 = Mathf.Lerp(0, 0.5, var_88_3)

					arg_85_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_85_1.var_.characterEffect1084ui_story.fillRatio = var_88_4
				end
			end

			if arg_85_1.time_ >= var_88_1 + var_88_2 and arg_85_1.time_ < var_88_1 + var_88_2 + arg_88_0 and not isNil(var_88_0) and arg_85_1.var_.characterEffect1084ui_story then
				local var_88_5 = 0.5

				arg_85_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_85_1.var_.characterEffect1084ui_story.fillRatio = var_88_5
			end

			local var_88_6 = 0
			local var_88_7 = 0.95

			if var_88_6 < arg_85_1.time_ and arg_85_1.time_ <= var_88_6 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				local var_88_8 = arg_85_1:FormatText(StoryNameCfg[7].name)

				arg_85_1.leftNameTxt_.text = var_88_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, true)
				arg_85_1.iconController_:SetSelectedState("hero")

				arg_85_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_85_1.callingController_:SetSelectedState("normal")

				arg_85_1.keyicon_.color = Color.New(1, 1, 1)
				arg_85_1.icon_.color = Color.New(1, 1, 1)

				local var_88_9 = arg_85_1:GetWordFromCfg(121421021)
				local var_88_10 = arg_85_1:FormatText(var_88_9.content)

				arg_85_1.text_.text = var_88_10

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_11 = 38
				local var_88_12 = utf8.len(var_88_10)
				local var_88_13 = var_88_11 <= 0 and var_88_7 or var_88_7 * (var_88_12 / var_88_11)

				if var_88_13 > 0 and var_88_7 < var_88_13 then
					arg_85_1.talkMaxDuration = var_88_13

					if var_88_13 + var_88_6 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_13 + var_88_6
					end
				end

				arg_85_1.text_.text = var_88_10
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)
				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_14 = math.max(var_88_7, arg_85_1.talkMaxDuration)

			if var_88_6 <= arg_85_1.time_ and arg_85_1.time_ < var_88_6 + var_88_14 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_6) / var_88_14

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_6 + var_88_14 and arg_85_1.time_ < var_88_6 + var_88_14 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play121421022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 121421022
		arg_89_1.duration_ = 5

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play121421023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = 0
			local var_92_1 = 0.425

			if var_92_0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_0 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				local var_92_2 = arg_89_1:FormatText(StoryNameCfg[7].name)

				arg_89_1.leftNameTxt_.text = var_92_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, true)
				arg_89_1.iconController_:SetSelectedState("hero")

				arg_89_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_89_1.callingController_:SetSelectedState("normal")

				arg_89_1.keyicon_.color = Color.New(1, 1, 1)
				arg_89_1.icon_.color = Color.New(1, 1, 1)

				local var_92_3 = arg_89_1:GetWordFromCfg(121421022)
				local var_92_4 = arg_89_1:FormatText(var_92_3.content)

				arg_89_1.text_.text = var_92_4

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_5 = 17
				local var_92_6 = utf8.len(var_92_4)
				local var_92_7 = var_92_5 <= 0 and var_92_1 or var_92_1 * (var_92_6 / var_92_5)

				if var_92_7 > 0 and var_92_1 < var_92_7 then
					arg_89_1.talkMaxDuration = var_92_7

					if var_92_7 + var_92_0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_7 + var_92_0
					end
				end

				arg_89_1.text_.text = var_92_4
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)
				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_8 = math.max(var_92_1, arg_89_1.talkMaxDuration)

			if var_92_0 <= arg_89_1.time_ and arg_89_1.time_ < var_92_0 + var_92_8 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_0) / var_92_8

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_0 + var_92_8 and arg_89_1.time_ < var_92_0 + var_92_8 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play121421023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 121421023
		arg_93_1.duration_ = 9

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play121421024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = "ST29"

			if arg_93_1.bgs_[var_96_0] == nil then
				local var_96_1 = Object.Instantiate(arg_93_1.paintGo_)

				var_96_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_96_0)
				var_96_1.name = var_96_0
				var_96_1.transform.parent = arg_93_1.stage_.transform
				var_96_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_93_1.bgs_[var_96_0] = var_96_1
			end

			local var_96_2 = 2

			if var_96_2 < arg_93_1.time_ and arg_93_1.time_ <= var_96_2 + arg_96_0 then
				local var_96_3 = manager.ui.mainCamera.transform.localPosition
				local var_96_4 = Vector3.New(0, 0, 10) + Vector3.New(var_96_3.x, var_96_3.y, 0)
				local var_96_5 = arg_93_1.bgs_.ST29

				var_96_5.transform.localPosition = var_96_4
				var_96_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_96_6 = var_96_5:GetComponent("SpriteRenderer")

				if var_96_6 and var_96_6.sprite then
					local var_96_7 = (var_96_5.transform.localPosition - var_96_3).z
					local var_96_8 = manager.ui.mainCameraCom_
					local var_96_9 = 2 * var_96_7 * Mathf.Tan(var_96_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_96_10 = var_96_9 * var_96_8.aspect
					local var_96_11 = var_96_6.sprite.bounds.size.x
					local var_96_12 = var_96_6.sprite.bounds.size.y
					local var_96_13 = var_96_10 / var_96_11
					local var_96_14 = var_96_9 / var_96_12
					local var_96_15 = var_96_14 < var_96_13 and var_96_13 or var_96_14

					var_96_5.transform.localScale = Vector3.New(var_96_15, var_96_15, 0)
				end

				for iter_96_0, iter_96_1 in pairs(arg_93_1.bgs_) do
					if iter_96_0 ~= "ST29" then
						iter_96_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_96_16 = 0

			if var_96_16 < arg_93_1.time_ and arg_93_1.time_ <= var_96_16 + arg_96_0 then
				arg_93_1.mask_.enabled = true
				arg_93_1.mask_.raycastTarget = true

				arg_93_1:SetGaussion(false)
			end

			local var_96_17 = 2

			if var_96_16 <= arg_93_1.time_ and arg_93_1.time_ < var_96_16 + var_96_17 then
				local var_96_18 = (arg_93_1.time_ - var_96_16) / var_96_17
				local var_96_19 = Color.New(0, 0, 0)

				var_96_19.a = Mathf.Lerp(0, 1, var_96_18)
				arg_93_1.mask_.color = var_96_19
			end

			if arg_93_1.time_ >= var_96_16 + var_96_17 and arg_93_1.time_ < var_96_16 + var_96_17 + arg_96_0 then
				local var_96_20 = Color.New(0, 0, 0)

				var_96_20.a = 1
				arg_93_1.mask_.color = var_96_20
			end

			local var_96_21 = 2

			if var_96_21 < arg_93_1.time_ and arg_93_1.time_ <= var_96_21 + arg_96_0 then
				arg_93_1.mask_.enabled = true
				arg_93_1.mask_.raycastTarget = true

				arg_93_1:SetGaussion(false)
			end

			local var_96_22 = 2

			if var_96_21 <= arg_93_1.time_ and arg_93_1.time_ < var_96_21 + var_96_22 then
				local var_96_23 = (arg_93_1.time_ - var_96_21) / var_96_22
				local var_96_24 = Color.New(0, 0, 0)

				var_96_24.a = Mathf.Lerp(1, 0, var_96_23)
				arg_93_1.mask_.color = var_96_24
			end

			if arg_93_1.time_ >= var_96_21 + var_96_22 and arg_93_1.time_ < var_96_21 + var_96_22 + arg_96_0 then
				local var_96_25 = Color.New(0, 0, 0)
				local var_96_26 = 0

				arg_93_1.mask_.enabled = false
				var_96_25.a = var_96_26
				arg_93_1.mask_.color = var_96_25
			end

			local var_96_27 = arg_93_1.actors_["1084ui_story"].transform
			local var_96_28 = 1.96599999815226

			if var_96_28 < arg_93_1.time_ and arg_93_1.time_ <= var_96_28 + arg_96_0 then
				arg_93_1.var_.moveOldPos1084ui_story = var_96_27.localPosition
			end

			local var_96_29 = 0.001

			if var_96_28 <= arg_93_1.time_ and arg_93_1.time_ < var_96_28 + var_96_29 then
				local var_96_30 = (arg_93_1.time_ - var_96_28) / var_96_29
				local var_96_31 = Vector3.New(0, 100, 0)

				var_96_27.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos1084ui_story, var_96_31, var_96_30)

				local var_96_32 = manager.ui.mainCamera.transform.position - var_96_27.position

				var_96_27.forward = Vector3.New(var_96_32.x, var_96_32.y, var_96_32.z)

				local var_96_33 = var_96_27.localEulerAngles

				var_96_33.z = 0
				var_96_33.x = 0
				var_96_27.localEulerAngles = var_96_33
			end

			if arg_93_1.time_ >= var_96_28 + var_96_29 and arg_93_1.time_ < var_96_28 + var_96_29 + arg_96_0 then
				var_96_27.localPosition = Vector3.New(0, 100, 0)

				local var_96_34 = manager.ui.mainCamera.transform.position - var_96_27.position

				var_96_27.forward = Vector3.New(var_96_34.x, var_96_34.y, var_96_34.z)

				local var_96_35 = var_96_27.localEulerAngles

				var_96_35.z = 0
				var_96_35.x = 0
				var_96_27.localEulerAngles = var_96_35
			end

			local var_96_36 = arg_93_1.actors_["1084ui_story"]
			local var_96_37 = 1.96599999815226

			if var_96_37 < arg_93_1.time_ and arg_93_1.time_ <= var_96_37 + arg_96_0 and not isNil(var_96_36) and arg_93_1.var_.characterEffect1084ui_story == nil then
				arg_93_1.var_.characterEffect1084ui_story = var_96_36:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_38 = 0.034000001847744

			if var_96_37 <= arg_93_1.time_ and arg_93_1.time_ < var_96_37 + var_96_38 and not isNil(var_96_36) then
				local var_96_39 = (arg_93_1.time_ - var_96_37) / var_96_38

				if arg_93_1.var_.characterEffect1084ui_story and not isNil(var_96_36) then
					local var_96_40 = Mathf.Lerp(0, 0.5, var_96_39)

					arg_93_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_93_1.var_.characterEffect1084ui_story.fillRatio = var_96_40
				end
			end

			if arg_93_1.time_ >= var_96_37 + var_96_38 and arg_93_1.time_ < var_96_37 + var_96_38 + arg_96_0 and not isNil(var_96_36) and arg_93_1.var_.characterEffect1084ui_story then
				local var_96_41 = 0.5

				arg_93_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_93_1.var_.characterEffect1084ui_story.fillRatio = var_96_41
			end

			local var_96_42 = 2.33333333333333
			local var_96_43 = 1

			if var_96_42 < arg_93_1.time_ and arg_93_1.time_ <= var_96_42 + arg_96_0 then
				local var_96_44 = "play"
				local var_96_45 = "effect"

				arg_93_1:AudioAction(var_96_44, var_96_45, "se_story_side_1096", "se_story_1096_crowd_loop", "")
			end

			if arg_93_1.frameCnt_ <= 1 then
				arg_93_1.dialog_:SetActive(false)
			end

			local var_96_46 = 3.999999999999
			local var_96_47 = 1.2

			if var_96_46 < arg_93_1.time_ and arg_93_1.time_ <= var_96_46 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0

				arg_93_1.dialog_:SetActive(true)

				arg_93_1.dialogCg_.alpha = 0

				local var_96_48 = LeanTween.value(arg_93_1.dialog_, 0, 1, 0.3)

				var_96_48:setOnUpdate(LuaHelper.FloatAction(function(arg_97_0)
					arg_93_1.dialogCg_.alpha = arg_97_0
				end))
				var_96_48:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_93_1.dialog_)
					var_96_48:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_93_1.duration_ = arg_93_1.duration_ + 0.3

				SetActive(arg_93_1.leftNameGo_, false)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_49 = arg_93_1:GetWordFromCfg(121421023)
				local var_96_50 = arg_93_1:FormatText(var_96_49.content)

				arg_93_1.text_.text = var_96_50

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_51 = 48
				local var_96_52 = utf8.len(var_96_50)
				local var_96_53 = var_96_51 <= 0 and var_96_47 or var_96_47 * (var_96_52 / var_96_51)

				if var_96_53 > 0 and var_96_47 < var_96_53 then
					arg_93_1.talkMaxDuration = var_96_53
					var_96_46 = var_96_46 + 0.3

					if var_96_53 + var_96_46 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_53 + var_96_46
					end
				end

				arg_93_1.text_.text = var_96_50
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)
				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_54 = var_96_46 + 0.3
			local var_96_55 = math.max(var_96_47, arg_93_1.talkMaxDuration)

			if var_96_54 <= arg_93_1.time_ and arg_93_1.time_ < var_96_54 + var_96_55 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_54) / var_96_55

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_54 + var_96_55 and arg_93_1.time_ < var_96_54 + var_96_55 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_93_1:InitPlayNodeList()
	end,
	Play121421024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 121421024
		arg_99_1.duration_ = 5

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play121421025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = 0
			local var_102_1 = 1.025

			if var_102_0 < arg_99_1.time_ and arg_99_1.time_ <= var_102_0 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, false)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_2 = arg_99_1:GetWordFromCfg(121421024)
				local var_102_3 = arg_99_1:FormatText(var_102_2.content)

				arg_99_1.text_.text = var_102_3

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_4 = 41
				local var_102_5 = utf8.len(var_102_3)
				local var_102_6 = var_102_4 <= 0 and var_102_1 or var_102_1 * (var_102_5 / var_102_4)

				if var_102_6 > 0 and var_102_1 < var_102_6 then
					arg_99_1.talkMaxDuration = var_102_6

					if var_102_6 + var_102_0 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_6 + var_102_0
					end
				end

				arg_99_1.text_.text = var_102_3
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)
				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_7 = math.max(var_102_1, arg_99_1.talkMaxDuration)

			if var_102_0 <= arg_99_1.time_ and arg_99_1.time_ < var_102_0 + var_102_7 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_0) / var_102_7

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_0 + var_102_7 and arg_99_1.time_ < var_102_0 + var_102_7 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {}

		arg_99_1:InitPlayNodeList()
	end,
	Play121421025 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 121421025
		arg_103_1.duration_ = 6.13

		local var_103_0 = {
			ja = 6.133,
			ko = 6.066,
			zh = 6.066
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
				arg_103_0:Play121421026(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			local var_106_0 = "1072ui_story"

			if arg_103_1.actors_[var_106_0] == nil then
				local var_106_1 = Asset.Load("Char/" .. "1072ui_story")

				if not isNil(var_106_1) then
					local var_106_2 = Object.Instantiate(Asset.Load("Char/" .. "1072ui_story"), arg_103_1.stage_.transform)

					var_106_2.name = var_106_0
					var_106_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_103_1.actors_[var_106_0] = var_106_2

					local var_106_3 = var_106_2:GetComponentInChildren(typeof(CharacterEffect))

					var_106_3.enabled = true

					local var_106_4 = GameObjectTools.GetOrAddComponent(var_106_2, typeof(DynamicBoneHelper))

					if var_106_4 then
						var_106_4:EnableDynamicBone(false)
					end

					arg_103_1:ShowWeapon(var_106_3.transform, false)

					arg_103_1.var_[var_106_0 .. "Animator"] = var_106_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_103_1.var_[var_106_0 .. "Animator"].applyRootMotion = true
					arg_103_1.var_[var_106_0 .. "LipSync"] = var_106_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_106_5 = arg_103_1.actors_["1072ui_story"].transform
			local var_106_6 = 0

			if var_106_6 < arg_103_1.time_ and arg_103_1.time_ <= var_106_6 + arg_106_0 then
				arg_103_1.var_.moveOldPos1072ui_story = var_106_5.localPosition
			end

			local var_106_7 = 0.001

			if var_106_6 <= arg_103_1.time_ and arg_103_1.time_ < var_106_6 + var_106_7 then
				local var_106_8 = (arg_103_1.time_ - var_106_6) / var_106_7
				local var_106_9 = Vector3.New(-0.7, -0.71, -6)

				var_106_5.localPosition = Vector3.Lerp(arg_103_1.var_.moveOldPos1072ui_story, var_106_9, var_106_8)

				local var_106_10 = manager.ui.mainCamera.transform.position - var_106_5.position

				var_106_5.forward = Vector3.New(var_106_10.x, var_106_10.y, var_106_10.z)

				local var_106_11 = var_106_5.localEulerAngles

				var_106_11.z = 0
				var_106_11.x = 0
				var_106_5.localEulerAngles = var_106_11
			end

			if arg_103_1.time_ >= var_106_6 + var_106_7 and arg_103_1.time_ < var_106_6 + var_106_7 + arg_106_0 then
				var_106_5.localPosition = Vector3.New(-0.7, -0.71, -6)

				local var_106_12 = manager.ui.mainCamera.transform.position - var_106_5.position

				var_106_5.forward = Vector3.New(var_106_12.x, var_106_12.y, var_106_12.z)

				local var_106_13 = var_106_5.localEulerAngles

				var_106_13.z = 0
				var_106_13.x = 0
				var_106_5.localEulerAngles = var_106_13
			end

			local var_106_14 = arg_103_1.actors_["1072ui_story"]
			local var_106_15 = 0

			if var_106_15 < arg_103_1.time_ and arg_103_1.time_ <= var_106_15 + arg_106_0 and not isNil(var_106_14) and arg_103_1.var_.characterEffect1072ui_story == nil then
				arg_103_1.var_.characterEffect1072ui_story = var_106_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_106_16 = 0.200000002980232

			if var_106_15 <= arg_103_1.time_ and arg_103_1.time_ < var_106_15 + var_106_16 and not isNil(var_106_14) then
				local var_106_17 = (arg_103_1.time_ - var_106_15) / var_106_16

				if arg_103_1.var_.characterEffect1072ui_story and not isNil(var_106_14) then
					arg_103_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_103_1.time_ >= var_106_15 + var_106_16 and arg_103_1.time_ < var_106_15 + var_106_16 + arg_106_0 and not isNil(var_106_14) and arg_103_1.var_.characterEffect1072ui_story then
				arg_103_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_106_18 = 0

			if var_106_18 < arg_103_1.time_ and arg_103_1.time_ <= var_106_18 + arg_106_0 then
				arg_103_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action1_1")
			end

			local var_106_19 = 0

			if var_106_19 < arg_103_1.time_ and arg_103_1.time_ <= var_106_19 + arg_106_0 then
				arg_103_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_106_20 = "10042ui_story"

			if arg_103_1.actors_[var_106_20] == nil then
				local var_106_21 = Asset.Load("Char/" .. "10042ui_story")

				if not isNil(var_106_21) then
					local var_106_22 = Object.Instantiate(Asset.Load("Char/" .. "10042ui_story"), arg_103_1.stage_.transform)

					var_106_22.name = var_106_20
					var_106_22.transform.localPosition = Vector3.New(0, 100, 0)
					arg_103_1.actors_[var_106_20] = var_106_22

					local var_106_23 = var_106_22:GetComponentInChildren(typeof(CharacterEffect))

					var_106_23.enabled = true

					local var_106_24 = GameObjectTools.GetOrAddComponent(var_106_22, typeof(DynamicBoneHelper))

					if var_106_24 then
						var_106_24:EnableDynamicBone(false)
					end

					arg_103_1:ShowWeapon(var_106_23.transform, false)

					arg_103_1.var_[var_106_20 .. "Animator"] = var_106_23.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_103_1.var_[var_106_20 .. "Animator"].applyRootMotion = true
					arg_103_1.var_[var_106_20 .. "LipSync"] = var_106_23.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_106_25 = arg_103_1.actors_["10042ui_story"].transform
			local var_106_26 = 0

			if var_106_26 < arg_103_1.time_ and arg_103_1.time_ <= var_106_26 + arg_106_0 then
				arg_103_1.var_.moveOldPos10042ui_story = var_106_25.localPosition
			end

			local var_106_27 = 0.001

			if var_106_26 <= arg_103_1.time_ and arg_103_1.time_ < var_106_26 + var_106_27 then
				local var_106_28 = (arg_103_1.time_ - var_106_26) / var_106_27
				local var_106_29 = Vector3.New(0.7, -1.12, -6.2)

				var_106_25.localPosition = Vector3.Lerp(arg_103_1.var_.moveOldPos10042ui_story, var_106_29, var_106_28)

				local var_106_30 = manager.ui.mainCamera.transform.position - var_106_25.position

				var_106_25.forward = Vector3.New(var_106_30.x, var_106_30.y, var_106_30.z)

				local var_106_31 = var_106_25.localEulerAngles

				var_106_31.z = 0
				var_106_31.x = 0
				var_106_25.localEulerAngles = var_106_31
			end

			if arg_103_1.time_ >= var_106_26 + var_106_27 and arg_103_1.time_ < var_106_26 + var_106_27 + arg_106_0 then
				var_106_25.localPosition = Vector3.New(0.7, -1.12, -6.2)

				local var_106_32 = manager.ui.mainCamera.transform.position - var_106_25.position

				var_106_25.forward = Vector3.New(var_106_32.x, var_106_32.y, var_106_32.z)

				local var_106_33 = var_106_25.localEulerAngles

				var_106_33.z = 0
				var_106_33.x = 0
				var_106_25.localEulerAngles = var_106_33
			end

			local var_106_34 = arg_103_1.actors_["10042ui_story"]
			local var_106_35 = 0

			if var_106_35 < arg_103_1.time_ and arg_103_1.time_ <= var_106_35 + arg_106_0 and not isNil(var_106_34) and arg_103_1.var_.characterEffect10042ui_story == nil then
				arg_103_1.var_.characterEffect10042ui_story = var_106_34:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_106_36 = 0.0166666666666667

			if var_106_35 <= arg_103_1.time_ and arg_103_1.time_ < var_106_35 + var_106_36 and not isNil(var_106_34) then
				local var_106_37 = (arg_103_1.time_ - var_106_35) / var_106_36

				if arg_103_1.var_.characterEffect10042ui_story and not isNil(var_106_34) then
					local var_106_38 = Mathf.Lerp(0, 0.5, var_106_37)

					arg_103_1.var_.characterEffect10042ui_story.fillFlat = true
					arg_103_1.var_.characterEffect10042ui_story.fillRatio = var_106_38
				end
			end

			if arg_103_1.time_ >= var_106_35 + var_106_36 and arg_103_1.time_ < var_106_35 + var_106_36 + arg_106_0 and not isNil(var_106_34) and arg_103_1.var_.characterEffect10042ui_story then
				local var_106_39 = 0.5

				arg_103_1.var_.characterEffect10042ui_story.fillFlat = true
				arg_103_1.var_.characterEffect10042ui_story.fillRatio = var_106_39
			end

			local var_106_40 = 0

			if var_106_40 < arg_103_1.time_ and arg_103_1.time_ <= var_106_40 + arg_106_0 then
				arg_103_1:PlayTimeline("10042ui_story", "StoryTimeline/CharAction/story10042/story10042action/10042action1_1")
			end

			local var_106_41 = 0
			local var_106_42 = 0.85

			if var_106_41 < arg_103_1.time_ and arg_103_1.time_ <= var_106_41 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				local var_106_43 = arg_103_1:FormatText(StoryNameCfg[379].name)

				arg_103_1.leftNameTxt_.text = var_106_43

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_44 = arg_103_1:GetWordFromCfg(121421025)
				local var_106_45 = arg_103_1:FormatText(var_106_44.content)

				arg_103_1.text_.text = var_106_45

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_46 = 34
				local var_106_47 = utf8.len(var_106_45)
				local var_106_48 = var_106_46 <= 0 and var_106_42 or var_106_42 * (var_106_47 / var_106_46)

				if var_106_48 > 0 and var_106_42 < var_106_48 then
					arg_103_1.talkMaxDuration = var_106_48

					if var_106_48 + var_106_41 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_48 + var_106_41
					end
				end

				arg_103_1.text_.text = var_106_45
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121421", "121421025", "story_v_out_121421.awb") ~= 0 then
					local var_106_49 = manager.audio:GetVoiceLength("story_v_out_121421", "121421025", "story_v_out_121421.awb") / 1000

					if var_106_49 + var_106_41 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_49 + var_106_41
					end

					if var_106_44.prefab_name ~= "" and arg_103_1.actors_[var_106_44.prefab_name] ~= nil then
						local var_106_50 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_44.prefab_name].transform, "story_v_out_121421", "121421025", "story_v_out_121421.awb")

						arg_103_1:RecordAudio("121421025", var_106_50)
						arg_103_1:RecordAudio("121421025", var_106_50)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_out_121421", "121421025", "story_v_out_121421.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_out_121421", "121421025", "story_v_out_121421.awb")
				end

				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_51 = math.max(var_106_42, arg_103_1.talkMaxDuration)

			if var_106_41 <= arg_103_1.time_ and arg_103_1.time_ < var_106_41 + var_106_51 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_41) / var_106_51

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_41 + var_106_51 and arg_103_1.time_ < var_106_41 + var_106_51 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {
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
				actorName = "10042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_103_1:InitPlayNodeList()
	end,
	Play121421026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 121421026
		arg_107_1.duration_ = 11.9

		local var_107_0 = {
			ja = 11.9,
			ko = 6.3,
			zh = 6.3
		}
		local var_107_1 = manager.audio:GetLocalizationFlag()

		if var_107_0[var_107_1] ~= nil then
			arg_107_1.duration_ = var_107_0[var_107_1]
		end

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play121421027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			local var_110_0 = arg_107_1.actors_["10042ui_story"]
			local var_110_1 = 0

			if var_110_1 < arg_107_1.time_ and arg_107_1.time_ <= var_110_1 + arg_110_0 and not isNil(var_110_0) and arg_107_1.var_.characterEffect10042ui_story == nil then
				arg_107_1.var_.characterEffect10042ui_story = var_110_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_110_2 = 0.200000002980232

			if var_110_1 <= arg_107_1.time_ and arg_107_1.time_ < var_110_1 + var_110_2 and not isNil(var_110_0) then
				local var_110_3 = (arg_107_1.time_ - var_110_1) / var_110_2

				if arg_107_1.var_.characterEffect10042ui_story and not isNil(var_110_0) then
					arg_107_1.var_.characterEffect10042ui_story.fillFlat = false
				end
			end

			if arg_107_1.time_ >= var_110_1 + var_110_2 and arg_107_1.time_ < var_110_1 + var_110_2 + arg_110_0 and not isNil(var_110_0) and arg_107_1.var_.characterEffect10042ui_story then
				arg_107_1.var_.characterEffect10042ui_story.fillFlat = false
			end

			local var_110_4 = 0

			if var_110_4 < arg_107_1.time_ and arg_107_1.time_ <= var_110_4 + arg_110_0 then
				arg_107_1:PlayTimeline("10042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_110_5 = arg_107_1.actors_["1072ui_story"]
			local var_110_6 = 0

			if var_110_6 < arg_107_1.time_ and arg_107_1.time_ <= var_110_6 + arg_110_0 and not isNil(var_110_5) and arg_107_1.var_.characterEffect1072ui_story == nil then
				arg_107_1.var_.characterEffect1072ui_story = var_110_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_110_7 = 0.200000002980232

			if var_110_6 <= arg_107_1.time_ and arg_107_1.time_ < var_110_6 + var_110_7 and not isNil(var_110_5) then
				local var_110_8 = (arg_107_1.time_ - var_110_6) / var_110_7

				if arg_107_1.var_.characterEffect1072ui_story and not isNil(var_110_5) then
					local var_110_9 = Mathf.Lerp(0, 0.5, var_110_8)

					arg_107_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_107_1.var_.characterEffect1072ui_story.fillRatio = var_110_9
				end
			end

			if arg_107_1.time_ >= var_110_6 + var_110_7 and arg_107_1.time_ < var_110_6 + var_110_7 + arg_110_0 and not isNil(var_110_5) and arg_107_1.var_.characterEffect1072ui_story then
				local var_110_10 = 0.5

				arg_107_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_107_1.var_.characterEffect1072ui_story.fillRatio = var_110_10
			end

			local var_110_11 = 0
			local var_110_12 = 0.875

			if var_110_11 < arg_107_1.time_ and arg_107_1.time_ <= var_110_11 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				local var_110_13 = arg_107_1:FormatText(StoryNameCfg[388].name)

				arg_107_1.leftNameTxt_.text = var_110_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_14 = arg_107_1:GetWordFromCfg(121421026)
				local var_110_15 = arg_107_1:FormatText(var_110_14.content)

				arg_107_1.text_.text = var_110_15

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_16 = 35
				local var_110_17 = utf8.len(var_110_15)
				local var_110_18 = var_110_16 <= 0 and var_110_12 or var_110_12 * (var_110_17 / var_110_16)

				if var_110_18 > 0 and var_110_12 < var_110_18 then
					arg_107_1.talkMaxDuration = var_110_18

					if var_110_18 + var_110_11 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_18 + var_110_11
					end
				end

				arg_107_1.text_.text = var_110_15
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121421", "121421026", "story_v_out_121421.awb") ~= 0 then
					local var_110_19 = manager.audio:GetVoiceLength("story_v_out_121421", "121421026", "story_v_out_121421.awb") / 1000

					if var_110_19 + var_110_11 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_19 + var_110_11
					end

					if var_110_14.prefab_name ~= "" and arg_107_1.actors_[var_110_14.prefab_name] ~= nil then
						local var_110_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_14.prefab_name].transform, "story_v_out_121421", "121421026", "story_v_out_121421.awb")

						arg_107_1:RecordAudio("121421026", var_110_20)
						arg_107_1:RecordAudio("121421026", var_110_20)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_out_121421", "121421026", "story_v_out_121421.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_out_121421", "121421026", "story_v_out_121421.awb")
				end

				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_21 = math.max(var_110_12, arg_107_1.talkMaxDuration)

			if var_110_11 <= arg_107_1.time_ and arg_107_1.time_ < var_110_11 + var_110_21 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_11) / var_110_21

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_11 + var_110_21 and arg_107_1.time_ < var_110_11 + var_110_21 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {}

		arg_107_1:InitPlayNodeList()
	end,
	Play121421027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 121421027
		arg_111_1.duration_ = 8.3

		local var_111_0 = {
			ja = 6.3,
			ko = 8.3,
			zh = 8.3
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
				arg_111_0:Play121421028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = 0

			if var_114_0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_0 + arg_114_0 then
				arg_111_1:PlayTimeline("10042ui_story", "StoryTimeline/CharAction/story10042/story10042action/10042action3_1")
			end

			local var_114_1 = 0

			if var_114_1 < arg_111_1.time_ and arg_111_1.time_ <= var_114_1 + arg_114_0 then
				arg_111_1:PlayTimeline("10042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_114_2 = 0
			local var_114_3 = 1.025

			if var_114_2 < arg_111_1.time_ and arg_111_1.time_ <= var_114_2 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				local var_114_4 = arg_111_1:FormatText(StoryNameCfg[388].name)

				arg_111_1.leftNameTxt_.text = var_114_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_5 = arg_111_1:GetWordFromCfg(121421027)
				local var_114_6 = arg_111_1:FormatText(var_114_5.content)

				arg_111_1.text_.text = var_114_6

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_7 = 41
				local var_114_8 = utf8.len(var_114_6)
				local var_114_9 = var_114_7 <= 0 and var_114_3 or var_114_3 * (var_114_8 / var_114_7)

				if var_114_9 > 0 and var_114_3 < var_114_9 then
					arg_111_1.talkMaxDuration = var_114_9

					if var_114_9 + var_114_2 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_9 + var_114_2
					end
				end

				arg_111_1.text_.text = var_114_6
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121421", "121421027", "story_v_out_121421.awb") ~= 0 then
					local var_114_10 = manager.audio:GetVoiceLength("story_v_out_121421", "121421027", "story_v_out_121421.awb") / 1000

					if var_114_10 + var_114_2 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_10 + var_114_2
					end

					if var_114_5.prefab_name ~= "" and arg_111_1.actors_[var_114_5.prefab_name] ~= nil then
						local var_114_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_5.prefab_name].transform, "story_v_out_121421", "121421027", "story_v_out_121421.awb")

						arg_111_1:RecordAudio("121421027", var_114_11)
						arg_111_1:RecordAudio("121421027", var_114_11)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_121421", "121421027", "story_v_out_121421.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_121421", "121421027", "story_v_out_121421.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_12 = math.max(var_114_3, arg_111_1.talkMaxDuration)

			if var_114_2 <= arg_111_1.time_ and arg_111_1.time_ < var_114_2 + var_114_12 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_2) / var_114_12

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_2 + var_114_12 and arg_111_1.time_ < var_114_2 + var_114_12 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play121421028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 121421028
		arg_115_1.duration_ = 7.17

		local var_115_0 = {
			ja = 7.166,
			ko = 3.2,
			zh = 3.2
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
				arg_115_0:Play121421029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = arg_115_1.actors_["1072ui_story"]
			local var_118_1 = 0

			if var_118_1 < arg_115_1.time_ and arg_115_1.time_ <= var_118_1 + arg_118_0 and not isNil(var_118_0) and arg_115_1.var_.characterEffect1072ui_story == nil then
				arg_115_1.var_.characterEffect1072ui_story = var_118_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_2 = 0.200000002980232

			if var_118_1 <= arg_115_1.time_ and arg_115_1.time_ < var_118_1 + var_118_2 and not isNil(var_118_0) then
				local var_118_3 = (arg_115_1.time_ - var_118_1) / var_118_2

				if arg_115_1.var_.characterEffect1072ui_story and not isNil(var_118_0) then
					arg_115_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_115_1.time_ >= var_118_1 + var_118_2 and arg_115_1.time_ < var_118_1 + var_118_2 + arg_118_0 and not isNil(var_118_0) and arg_115_1.var_.characterEffect1072ui_story then
				arg_115_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_118_4 = 0

			if var_118_4 < arg_115_1.time_ and arg_115_1.time_ <= var_118_4 + arg_118_0 then
				arg_115_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action5_1")
			end

			local var_118_5 = 0

			if var_118_5 < arg_115_1.time_ and arg_115_1.time_ <= var_118_5 + arg_118_0 then
				arg_115_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_118_6 = arg_115_1.actors_["10042ui_story"]
			local var_118_7 = 0

			if var_118_7 < arg_115_1.time_ and arg_115_1.time_ <= var_118_7 + arg_118_0 and not isNil(var_118_6) and arg_115_1.var_.characterEffect10042ui_story == nil then
				arg_115_1.var_.characterEffect10042ui_story = var_118_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_8 = 0.200000002980232

			if var_118_7 <= arg_115_1.time_ and arg_115_1.time_ < var_118_7 + var_118_8 and not isNil(var_118_6) then
				local var_118_9 = (arg_115_1.time_ - var_118_7) / var_118_8

				if arg_115_1.var_.characterEffect10042ui_story and not isNil(var_118_6) then
					local var_118_10 = Mathf.Lerp(0, 0.5, var_118_9)

					arg_115_1.var_.characterEffect10042ui_story.fillFlat = true
					arg_115_1.var_.characterEffect10042ui_story.fillRatio = var_118_10
				end
			end

			if arg_115_1.time_ >= var_118_7 + var_118_8 and arg_115_1.time_ < var_118_7 + var_118_8 + arg_118_0 and not isNil(var_118_6) and arg_115_1.var_.characterEffect10042ui_story then
				local var_118_11 = 0.5

				arg_115_1.var_.characterEffect10042ui_story.fillFlat = true
				arg_115_1.var_.characterEffect10042ui_story.fillRatio = var_118_11
			end

			local var_118_12 = 0
			local var_118_13 = 0.35

			if var_118_12 < arg_115_1.time_ and arg_115_1.time_ <= var_118_12 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				local var_118_14 = arg_115_1:FormatText(StoryNameCfg[379].name)

				arg_115_1.leftNameTxt_.text = var_118_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_15 = arg_115_1:GetWordFromCfg(121421028)
				local var_118_16 = arg_115_1:FormatText(var_118_15.content)

				arg_115_1.text_.text = var_118_16

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_17 = 14
				local var_118_18 = utf8.len(var_118_16)
				local var_118_19 = var_118_17 <= 0 and var_118_13 or var_118_13 * (var_118_18 / var_118_17)

				if var_118_19 > 0 and var_118_13 < var_118_19 then
					arg_115_1.talkMaxDuration = var_118_19

					if var_118_19 + var_118_12 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_19 + var_118_12
					end
				end

				arg_115_1.text_.text = var_118_16
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121421", "121421028", "story_v_out_121421.awb") ~= 0 then
					local var_118_20 = manager.audio:GetVoiceLength("story_v_out_121421", "121421028", "story_v_out_121421.awb") / 1000

					if var_118_20 + var_118_12 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_20 + var_118_12
					end

					if var_118_15.prefab_name ~= "" and arg_115_1.actors_[var_118_15.prefab_name] ~= nil then
						local var_118_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_15.prefab_name].transform, "story_v_out_121421", "121421028", "story_v_out_121421.awb")

						arg_115_1:RecordAudio("121421028", var_118_21)
						arg_115_1:RecordAudio("121421028", var_118_21)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_121421", "121421028", "story_v_out_121421.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_121421", "121421028", "story_v_out_121421.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_22 = math.max(var_118_13, arg_115_1.talkMaxDuration)

			if var_118_12 <= arg_115_1.time_ and arg_115_1.time_ < var_118_12 + var_118_22 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_12) / var_118_22

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_12 + var_118_22 and arg_115_1.time_ < var_118_12 + var_118_22 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {}

		arg_115_1:InitPlayNodeList()
	end,
	Play121421029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 121421029
		arg_119_1.duration_ = 10.6

		local var_119_0 = {
			ja = 7.1,
			ko = 10.6,
			zh = 10.6
		}
		local var_119_1 = manager.audio:GetLocalizationFlag()

		if var_119_0[var_119_1] ~= nil then
			arg_119_1.duration_ = var_119_0[var_119_1]
		end

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play121421030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = arg_119_1.actors_["10042ui_story"]
			local var_122_1 = 0

			if var_122_1 < arg_119_1.time_ and arg_119_1.time_ <= var_122_1 + arg_122_0 and not isNil(var_122_0) and arg_119_1.var_.characterEffect10042ui_story == nil then
				arg_119_1.var_.characterEffect10042ui_story = var_122_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_2 = 0.200000002980232

			if var_122_1 <= arg_119_1.time_ and arg_119_1.time_ < var_122_1 + var_122_2 and not isNil(var_122_0) then
				local var_122_3 = (arg_119_1.time_ - var_122_1) / var_122_2

				if arg_119_1.var_.characterEffect10042ui_story and not isNil(var_122_0) then
					arg_119_1.var_.characterEffect10042ui_story.fillFlat = false
				end
			end

			if arg_119_1.time_ >= var_122_1 + var_122_2 and arg_119_1.time_ < var_122_1 + var_122_2 + arg_122_0 and not isNil(var_122_0) and arg_119_1.var_.characterEffect10042ui_story then
				arg_119_1.var_.characterEffect10042ui_story.fillFlat = false
			end

			local var_122_4 = 0

			if var_122_4 < arg_119_1.time_ and arg_119_1.time_ <= var_122_4 + arg_122_0 then
				arg_119_1:PlayTimeline("10042ui_story", "StoryTimeline/CharAction/story10042/story10042action/10042action3_2")
			end

			local var_122_5 = 0

			if var_122_5 < arg_119_1.time_ and arg_119_1.time_ <= var_122_5 + arg_122_0 then
				arg_119_1:PlayTimeline("10042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_122_6 = arg_119_1.actors_["1072ui_story"]
			local var_122_7 = 0

			if var_122_7 < arg_119_1.time_ and arg_119_1.time_ <= var_122_7 + arg_122_0 and not isNil(var_122_6) and arg_119_1.var_.characterEffect1072ui_story == nil then
				arg_119_1.var_.characterEffect1072ui_story = var_122_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_8 = 0.200000002980232

			if var_122_7 <= arg_119_1.time_ and arg_119_1.time_ < var_122_7 + var_122_8 and not isNil(var_122_6) then
				local var_122_9 = (arg_119_1.time_ - var_122_7) / var_122_8

				if arg_119_1.var_.characterEffect1072ui_story and not isNil(var_122_6) then
					local var_122_10 = Mathf.Lerp(0, 0.5, var_122_9)

					arg_119_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_119_1.var_.characterEffect1072ui_story.fillRatio = var_122_10
				end
			end

			if arg_119_1.time_ >= var_122_7 + var_122_8 and arg_119_1.time_ < var_122_7 + var_122_8 + arg_122_0 and not isNil(var_122_6) and arg_119_1.var_.characterEffect1072ui_story then
				local var_122_11 = 0.5

				arg_119_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_119_1.var_.characterEffect1072ui_story.fillRatio = var_122_11
			end

			local var_122_12 = 0
			local var_122_13 = 1.05

			if var_122_12 < arg_119_1.time_ and arg_119_1.time_ <= var_122_12 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				local var_122_14 = arg_119_1:FormatText(StoryNameCfg[388].name)

				arg_119_1.leftNameTxt_.text = var_122_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_15 = arg_119_1:GetWordFromCfg(121421029)
				local var_122_16 = arg_119_1:FormatText(var_122_15.content)

				arg_119_1.text_.text = var_122_16

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_17 = 42
				local var_122_18 = utf8.len(var_122_16)
				local var_122_19 = var_122_17 <= 0 and var_122_13 or var_122_13 * (var_122_18 / var_122_17)

				if var_122_19 > 0 and var_122_13 < var_122_19 then
					arg_119_1.talkMaxDuration = var_122_19

					if var_122_19 + var_122_12 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_19 + var_122_12
					end
				end

				arg_119_1.text_.text = var_122_16
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121421", "121421029", "story_v_out_121421.awb") ~= 0 then
					local var_122_20 = manager.audio:GetVoiceLength("story_v_out_121421", "121421029", "story_v_out_121421.awb") / 1000

					if var_122_20 + var_122_12 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_20 + var_122_12
					end

					if var_122_15.prefab_name ~= "" and arg_119_1.actors_[var_122_15.prefab_name] ~= nil then
						local var_122_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_15.prefab_name].transform, "story_v_out_121421", "121421029", "story_v_out_121421.awb")

						arg_119_1:RecordAudio("121421029", var_122_21)
						arg_119_1:RecordAudio("121421029", var_122_21)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_121421", "121421029", "story_v_out_121421.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_121421", "121421029", "story_v_out_121421.awb")
				end

				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_22 = math.max(var_122_13, arg_119_1.talkMaxDuration)

			if var_122_12 <= arg_119_1.time_ and arg_119_1.time_ < var_122_12 + var_122_22 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_12) / var_122_22

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_12 + var_122_22 and arg_119_1.time_ < var_122_12 + var_122_22 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {}

		arg_119_1:InitPlayNodeList()
	end,
	Play121421030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 121421030
		arg_123_1.duration_ = 4.93

		local var_123_0 = {
			ja = 4.933,
			ko = 4.633,
			zh = 4.633
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
				arg_123_0:Play121421031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = 0
			local var_126_1 = 0.525

			if var_126_0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_0 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				local var_126_2 = arg_123_1:FormatText(StoryNameCfg[388].name)

				arg_123_1.leftNameTxt_.text = var_126_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_3 = arg_123_1:GetWordFromCfg(121421030)
				local var_126_4 = arg_123_1:FormatText(var_126_3.content)

				arg_123_1.text_.text = var_126_4

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_5 = 21
				local var_126_6 = utf8.len(var_126_4)
				local var_126_7 = var_126_5 <= 0 and var_126_1 or var_126_1 * (var_126_6 / var_126_5)

				if var_126_7 > 0 and var_126_1 < var_126_7 then
					arg_123_1.talkMaxDuration = var_126_7

					if var_126_7 + var_126_0 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_7 + var_126_0
					end
				end

				arg_123_1.text_.text = var_126_4
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121421", "121421030", "story_v_out_121421.awb") ~= 0 then
					local var_126_8 = manager.audio:GetVoiceLength("story_v_out_121421", "121421030", "story_v_out_121421.awb") / 1000

					if var_126_8 + var_126_0 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_8 + var_126_0
					end

					if var_126_3.prefab_name ~= "" and arg_123_1.actors_[var_126_3.prefab_name] ~= nil then
						local var_126_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_3.prefab_name].transform, "story_v_out_121421", "121421030", "story_v_out_121421.awb")

						arg_123_1:RecordAudio("121421030", var_126_9)
						arg_123_1:RecordAudio("121421030", var_126_9)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_121421", "121421030", "story_v_out_121421.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_121421", "121421030", "story_v_out_121421.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_10 = math.max(var_126_1, arg_123_1.talkMaxDuration)

			if var_126_0 <= arg_123_1.time_ and arg_123_1.time_ < var_126_0 + var_126_10 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_0) / var_126_10

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_0 + var_126_10 and arg_123_1.time_ < var_126_0 + var_126_10 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play121421031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 121421031
		arg_127_1.duration_ = 12.63

		local var_127_0 = {
			ja = 12.633,
			ko = 7.466,
			zh = 7.466
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
				arg_127_0:Play121421032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = arg_127_1.actors_["1072ui_story"]
			local var_130_1 = 0

			if var_130_1 < arg_127_1.time_ and arg_127_1.time_ <= var_130_1 + arg_130_0 and not isNil(var_130_0) and arg_127_1.var_.characterEffect1072ui_story == nil then
				arg_127_1.var_.characterEffect1072ui_story = var_130_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_2 = 0.200000002980232

			if var_130_1 <= arg_127_1.time_ and arg_127_1.time_ < var_130_1 + var_130_2 and not isNil(var_130_0) then
				local var_130_3 = (arg_127_1.time_ - var_130_1) / var_130_2

				if arg_127_1.var_.characterEffect1072ui_story and not isNil(var_130_0) then
					arg_127_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_127_1.time_ >= var_130_1 + var_130_2 and arg_127_1.time_ < var_130_1 + var_130_2 + arg_130_0 and not isNil(var_130_0) and arg_127_1.var_.characterEffect1072ui_story then
				arg_127_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_130_4 = 0

			if var_130_4 < arg_127_1.time_ and arg_127_1.time_ <= var_130_4 + arg_130_0 then
				arg_127_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072actionlink/1072action456")
			end

			local var_130_5 = 0

			if var_130_5 < arg_127_1.time_ and arg_127_1.time_ <= var_130_5 + arg_130_0 then
				arg_127_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_130_6 = arg_127_1.actors_["10042ui_story"]
			local var_130_7 = 0

			if var_130_7 < arg_127_1.time_ and arg_127_1.time_ <= var_130_7 + arg_130_0 and not isNil(var_130_6) and arg_127_1.var_.characterEffect10042ui_story == nil then
				arg_127_1.var_.characterEffect10042ui_story = var_130_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_8 = 0.200000002980232

			if var_130_7 <= arg_127_1.time_ and arg_127_1.time_ < var_130_7 + var_130_8 and not isNil(var_130_6) then
				local var_130_9 = (arg_127_1.time_ - var_130_7) / var_130_8

				if arg_127_1.var_.characterEffect10042ui_story and not isNil(var_130_6) then
					local var_130_10 = Mathf.Lerp(0, 0.5, var_130_9)

					arg_127_1.var_.characterEffect10042ui_story.fillFlat = true
					arg_127_1.var_.characterEffect10042ui_story.fillRatio = var_130_10
				end
			end

			if arg_127_1.time_ >= var_130_7 + var_130_8 and arg_127_1.time_ < var_130_7 + var_130_8 + arg_130_0 and not isNil(var_130_6) and arg_127_1.var_.characterEffect10042ui_story then
				local var_130_11 = 0.5

				arg_127_1.var_.characterEffect10042ui_story.fillFlat = true
				arg_127_1.var_.characterEffect10042ui_story.fillRatio = var_130_11
			end

			local var_130_12 = 0
			local var_130_13 = 0.875

			if var_130_12 < arg_127_1.time_ and arg_127_1.time_ <= var_130_12 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				local var_130_14 = arg_127_1:FormatText(StoryNameCfg[379].name)

				arg_127_1.leftNameTxt_.text = var_130_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_15 = arg_127_1:GetWordFromCfg(121421031)
				local var_130_16 = arg_127_1:FormatText(var_130_15.content)

				arg_127_1.text_.text = var_130_16

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_17 = 35
				local var_130_18 = utf8.len(var_130_16)
				local var_130_19 = var_130_17 <= 0 and var_130_13 or var_130_13 * (var_130_18 / var_130_17)

				if var_130_19 > 0 and var_130_13 < var_130_19 then
					arg_127_1.talkMaxDuration = var_130_19

					if var_130_19 + var_130_12 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_19 + var_130_12
					end
				end

				arg_127_1.text_.text = var_130_16
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121421", "121421031", "story_v_out_121421.awb") ~= 0 then
					local var_130_20 = manager.audio:GetVoiceLength("story_v_out_121421", "121421031", "story_v_out_121421.awb") / 1000

					if var_130_20 + var_130_12 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_20 + var_130_12
					end

					if var_130_15.prefab_name ~= "" and arg_127_1.actors_[var_130_15.prefab_name] ~= nil then
						local var_130_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_15.prefab_name].transform, "story_v_out_121421", "121421031", "story_v_out_121421.awb")

						arg_127_1:RecordAudio("121421031", var_130_21)
						arg_127_1:RecordAudio("121421031", var_130_21)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_121421", "121421031", "story_v_out_121421.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_121421", "121421031", "story_v_out_121421.awb")
				end

				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_22 = math.max(var_130_13, arg_127_1.talkMaxDuration)

			if var_130_12 <= arg_127_1.time_ and arg_127_1.time_ < var_130_12 + var_130_22 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_12) / var_130_22

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_12 + var_130_22 and arg_127_1.time_ < var_130_12 + var_130_22 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play121421032 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 121421032
		arg_131_1.duration_ = 8.33

		local var_131_0 = {
			ja = 8.333,
			ko = 5.9,
			zh = 5.9
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
				arg_131_0:Play121421033(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = 0
			local var_134_1 = 0.65

			if var_134_0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_0 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				local var_134_2 = arg_131_1:FormatText(StoryNameCfg[379].name)

				arg_131_1.leftNameTxt_.text = var_134_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_3 = arg_131_1:GetWordFromCfg(121421032)
				local var_134_4 = arg_131_1:FormatText(var_134_3.content)

				arg_131_1.text_.text = var_134_4

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_5 = 26
				local var_134_6 = utf8.len(var_134_4)
				local var_134_7 = var_134_5 <= 0 and var_134_1 or var_134_1 * (var_134_6 / var_134_5)

				if var_134_7 > 0 and var_134_1 < var_134_7 then
					arg_131_1.talkMaxDuration = var_134_7

					if var_134_7 + var_134_0 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_7 + var_134_0
					end
				end

				arg_131_1.text_.text = var_134_4
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121421", "121421032", "story_v_out_121421.awb") ~= 0 then
					local var_134_8 = manager.audio:GetVoiceLength("story_v_out_121421", "121421032", "story_v_out_121421.awb") / 1000

					if var_134_8 + var_134_0 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_8 + var_134_0
					end

					if var_134_3.prefab_name ~= "" and arg_131_1.actors_[var_134_3.prefab_name] ~= nil then
						local var_134_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_3.prefab_name].transform, "story_v_out_121421", "121421032", "story_v_out_121421.awb")

						arg_131_1:RecordAudio("121421032", var_134_9)
						arg_131_1:RecordAudio("121421032", var_134_9)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_121421", "121421032", "story_v_out_121421.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_121421", "121421032", "story_v_out_121421.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_10 = math.max(var_134_1, arg_131_1.talkMaxDuration)

			if var_134_0 <= arg_131_1.time_ and arg_131_1.time_ < var_134_0 + var_134_10 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_0) / var_134_10

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_0 + var_134_10 and arg_131_1.time_ < var_134_0 + var_134_10 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play121421033 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 121421033
		arg_135_1.duration_ = 13.6

		local var_135_0 = {
			ja = 13.6,
			ko = 9.666,
			zh = 9.666
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
				arg_135_0:Play121421034(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = arg_135_1.actors_["10042ui_story"]
			local var_138_1 = 0

			if var_138_1 < arg_135_1.time_ and arg_135_1.time_ <= var_138_1 + arg_138_0 and not isNil(var_138_0) and arg_135_1.var_.characterEffect10042ui_story == nil then
				arg_135_1.var_.characterEffect10042ui_story = var_138_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_2 = 0.200000002980232

			if var_138_1 <= arg_135_1.time_ and arg_135_1.time_ < var_138_1 + var_138_2 and not isNil(var_138_0) then
				local var_138_3 = (arg_135_1.time_ - var_138_1) / var_138_2

				if arg_135_1.var_.characterEffect10042ui_story and not isNil(var_138_0) then
					arg_135_1.var_.characterEffect10042ui_story.fillFlat = false
				end
			end

			if arg_135_1.time_ >= var_138_1 + var_138_2 and arg_135_1.time_ < var_138_1 + var_138_2 + arg_138_0 and not isNil(var_138_0) and arg_135_1.var_.characterEffect10042ui_story then
				arg_135_1.var_.characterEffect10042ui_story.fillFlat = false
			end

			local var_138_4 = arg_135_1.actors_["1072ui_story"]
			local var_138_5 = 0

			if var_138_5 < arg_135_1.time_ and arg_135_1.time_ <= var_138_5 + arg_138_0 and not isNil(var_138_4) and arg_135_1.var_.characterEffect1072ui_story == nil then
				arg_135_1.var_.characterEffect1072ui_story = var_138_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_6 = 0.200000002980232

			if var_138_5 <= arg_135_1.time_ and arg_135_1.time_ < var_138_5 + var_138_6 and not isNil(var_138_4) then
				local var_138_7 = (arg_135_1.time_ - var_138_5) / var_138_6

				if arg_135_1.var_.characterEffect1072ui_story and not isNil(var_138_4) then
					local var_138_8 = Mathf.Lerp(0, 0.5, var_138_7)

					arg_135_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_135_1.var_.characterEffect1072ui_story.fillRatio = var_138_8
				end
			end

			if arg_135_1.time_ >= var_138_5 + var_138_6 and arg_135_1.time_ < var_138_5 + var_138_6 + arg_138_0 and not isNil(var_138_4) and arg_135_1.var_.characterEffect1072ui_story then
				local var_138_9 = 0.5

				arg_135_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_135_1.var_.characterEffect1072ui_story.fillRatio = var_138_9
			end

			local var_138_10 = 0
			local var_138_11 = 1.125

			if var_138_10 < arg_135_1.time_ and arg_135_1.time_ <= var_138_10 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				local var_138_12 = arg_135_1:FormatText(StoryNameCfg[388].name)

				arg_135_1.leftNameTxt_.text = var_138_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_13 = arg_135_1:GetWordFromCfg(121421033)
				local var_138_14 = arg_135_1:FormatText(var_138_13.content)

				arg_135_1.text_.text = var_138_14

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_15 = 45
				local var_138_16 = utf8.len(var_138_14)
				local var_138_17 = var_138_15 <= 0 and var_138_11 or var_138_11 * (var_138_16 / var_138_15)

				if var_138_17 > 0 and var_138_11 < var_138_17 then
					arg_135_1.talkMaxDuration = var_138_17

					if var_138_17 + var_138_10 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_17 + var_138_10
					end
				end

				arg_135_1.text_.text = var_138_14
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121421", "121421033", "story_v_out_121421.awb") ~= 0 then
					local var_138_18 = manager.audio:GetVoiceLength("story_v_out_121421", "121421033", "story_v_out_121421.awb") / 1000

					if var_138_18 + var_138_10 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_18 + var_138_10
					end

					if var_138_13.prefab_name ~= "" and arg_135_1.actors_[var_138_13.prefab_name] ~= nil then
						local var_138_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_13.prefab_name].transform, "story_v_out_121421", "121421033", "story_v_out_121421.awb")

						arg_135_1:RecordAudio("121421033", var_138_19)
						arg_135_1:RecordAudio("121421033", var_138_19)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_121421", "121421033", "story_v_out_121421.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_121421", "121421033", "story_v_out_121421.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_20 = math.max(var_138_11, arg_135_1.talkMaxDuration)

			if var_138_10 <= arg_135_1.time_ and arg_135_1.time_ < var_138_10 + var_138_20 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_10) / var_138_20

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_10 + var_138_20 and arg_135_1.time_ < var_138_10 + var_138_20 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play121421034 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 121421034
		arg_139_1.duration_ = 7.2

		local var_139_0 = {
			ja = 5.2,
			ko = 7.2,
			zh = 7.2
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
				arg_139_0:Play121421035(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = arg_139_1.actors_["10042ui_story"].transform
			local var_142_1 = 0

			if var_142_1 < arg_139_1.time_ and arg_139_1.time_ <= var_142_1 + arg_142_0 then
				arg_139_1.var_.moveOldPos10042ui_story = var_142_0.localPosition
			end

			local var_142_2 = 0.001

			if var_142_1 <= arg_139_1.time_ and arg_139_1.time_ < var_142_1 + var_142_2 then
				local var_142_3 = (arg_139_1.time_ - var_142_1) / var_142_2
				local var_142_4 = Vector3.New(0.7, -1.12, -6.2)

				var_142_0.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos10042ui_story, var_142_4, var_142_3)

				local var_142_5 = manager.ui.mainCamera.transform.position - var_142_0.position

				var_142_0.forward = Vector3.New(var_142_5.x, var_142_5.y, var_142_5.z)

				local var_142_6 = var_142_0.localEulerAngles

				var_142_6.z = 0
				var_142_6.x = 0
				var_142_0.localEulerAngles = var_142_6
			end

			if arg_139_1.time_ >= var_142_1 + var_142_2 and arg_139_1.time_ < var_142_1 + var_142_2 + arg_142_0 then
				var_142_0.localPosition = Vector3.New(0.7, -1.12, -6.2)

				local var_142_7 = manager.ui.mainCamera.transform.position - var_142_0.position

				var_142_0.forward = Vector3.New(var_142_7.x, var_142_7.y, var_142_7.z)

				local var_142_8 = var_142_0.localEulerAngles

				var_142_8.z = 0
				var_142_8.x = 0
				var_142_0.localEulerAngles = var_142_8
			end

			local var_142_9 = 0

			if var_142_9 < arg_139_1.time_ and arg_139_1.time_ <= var_142_9 + arg_142_0 then
				arg_139_1:PlayTimeline("10042ui_story", "StoryTimeline/CharAction/story10042/story10042action/10042action1_1")
			end

			local var_142_10 = 0

			if var_142_10 < arg_139_1.time_ and arg_139_1.time_ <= var_142_10 + arg_142_0 then
				arg_139_1:PlayTimeline("10042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_142_11 = 0
			local var_142_12 = 0.975

			if var_142_11 < arg_139_1.time_ and arg_139_1.time_ <= var_142_11 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				local var_142_13 = arg_139_1:FormatText(StoryNameCfg[388].name)

				arg_139_1.leftNameTxt_.text = var_142_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_14 = arg_139_1:GetWordFromCfg(121421034)
				local var_142_15 = arg_139_1:FormatText(var_142_14.content)

				arg_139_1.text_.text = var_142_15

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_16 = 39
				local var_142_17 = utf8.len(var_142_15)
				local var_142_18 = var_142_16 <= 0 and var_142_12 or var_142_12 * (var_142_17 / var_142_16)

				if var_142_18 > 0 and var_142_12 < var_142_18 then
					arg_139_1.talkMaxDuration = var_142_18

					if var_142_18 + var_142_11 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_18 + var_142_11
					end
				end

				arg_139_1.text_.text = var_142_15
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121421", "121421034", "story_v_out_121421.awb") ~= 0 then
					local var_142_19 = manager.audio:GetVoiceLength("story_v_out_121421", "121421034", "story_v_out_121421.awb") / 1000

					if var_142_19 + var_142_11 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_19 + var_142_11
					end

					if var_142_14.prefab_name ~= "" and arg_139_1.actors_[var_142_14.prefab_name] ~= nil then
						local var_142_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_14.prefab_name].transform, "story_v_out_121421", "121421034", "story_v_out_121421.awb")

						arg_139_1:RecordAudio("121421034", var_142_20)
						arg_139_1:RecordAudio("121421034", var_142_20)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_121421", "121421034", "story_v_out_121421.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_121421", "121421034", "story_v_out_121421.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_21 = math.max(var_142_12, arg_139_1.talkMaxDuration)

			if var_142_11 <= arg_139_1.time_ and arg_139_1.time_ < var_142_11 + var_142_21 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_11) / var_142_21

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_11 + var_142_21 and arg_139_1.time_ < var_142_11 + var_142_21 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10042ui_story",
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
	Play121421035 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 121421035
		arg_143_1.duration_ = 12.7

		local var_143_0 = {
			ja = 12.7,
			ko = 9.466,
			zh = 9.466
		}
		local var_143_1 = manager.audio:GetLocalizationFlag()

		if var_143_0[var_143_1] ~= nil then
			arg_143_1.duration_ = var_143_0[var_143_1]
		end

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play121421036(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = 0
			local var_146_1 = 1.05

			if var_146_0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_0 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				local var_146_2 = arg_143_1:FormatText(StoryNameCfg[388].name)

				arg_143_1.leftNameTxt_.text = var_146_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_3 = arg_143_1:GetWordFromCfg(121421035)
				local var_146_4 = arg_143_1:FormatText(var_146_3.content)

				arg_143_1.text_.text = var_146_4

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_5 = 42
				local var_146_6 = utf8.len(var_146_4)
				local var_146_7 = var_146_5 <= 0 and var_146_1 or var_146_1 * (var_146_6 / var_146_5)

				if var_146_7 > 0 and var_146_1 < var_146_7 then
					arg_143_1.talkMaxDuration = var_146_7

					if var_146_7 + var_146_0 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_7 + var_146_0
					end
				end

				arg_143_1.text_.text = var_146_4
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121421", "121421035", "story_v_out_121421.awb") ~= 0 then
					local var_146_8 = manager.audio:GetVoiceLength("story_v_out_121421", "121421035", "story_v_out_121421.awb") / 1000

					if var_146_8 + var_146_0 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_8 + var_146_0
					end

					if var_146_3.prefab_name ~= "" and arg_143_1.actors_[var_146_3.prefab_name] ~= nil then
						local var_146_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_3.prefab_name].transform, "story_v_out_121421", "121421035", "story_v_out_121421.awb")

						arg_143_1:RecordAudio("121421035", var_146_9)
						arg_143_1:RecordAudio("121421035", var_146_9)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_121421", "121421035", "story_v_out_121421.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_121421", "121421035", "story_v_out_121421.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_10 = math.max(var_146_1, arg_143_1.talkMaxDuration)

			if var_146_0 <= arg_143_1.time_ and arg_143_1.time_ < var_146_0 + var_146_10 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_0) / var_146_10

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_0 + var_146_10 and arg_143_1.time_ < var_146_0 + var_146_10 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play121421036 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 121421036
		arg_147_1.duration_ = 3.83

		local var_147_0 = {
			ja = 3.5,
			ko = 3.833,
			zh = 3.833
		}
		local var_147_1 = manager.audio:GetLocalizationFlag()

		if var_147_0[var_147_1] ~= nil then
			arg_147_1.duration_ = var_147_0[var_147_1]
		end

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play121421037(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = arg_147_1.actors_["1072ui_story"]
			local var_150_1 = 0

			if var_150_1 < arg_147_1.time_ and arg_147_1.time_ <= var_150_1 + arg_150_0 and not isNil(var_150_0) and arg_147_1.var_.characterEffect1072ui_story == nil then
				arg_147_1.var_.characterEffect1072ui_story = var_150_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_2 = 0.200000002980232

			if var_150_1 <= arg_147_1.time_ and arg_147_1.time_ < var_150_1 + var_150_2 and not isNil(var_150_0) then
				local var_150_3 = (arg_147_1.time_ - var_150_1) / var_150_2

				if arg_147_1.var_.characterEffect1072ui_story and not isNil(var_150_0) then
					arg_147_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_147_1.time_ >= var_150_1 + var_150_2 and arg_147_1.time_ < var_150_1 + var_150_2 + arg_150_0 and not isNil(var_150_0) and arg_147_1.var_.characterEffect1072ui_story then
				arg_147_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_150_4 = 0

			if var_150_4 < arg_147_1.time_ and arg_147_1.time_ <= var_150_4 + arg_150_0 then
				arg_147_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_150_5 = arg_147_1.actors_["10042ui_story"]
			local var_150_6 = 0

			if var_150_6 < arg_147_1.time_ and arg_147_1.time_ <= var_150_6 + arg_150_0 and not isNil(var_150_5) and arg_147_1.var_.characterEffect10042ui_story == nil then
				arg_147_1.var_.characterEffect10042ui_story = var_150_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_7 = 0.200000002980232

			if var_150_6 <= arg_147_1.time_ and arg_147_1.time_ < var_150_6 + var_150_7 and not isNil(var_150_5) then
				local var_150_8 = (arg_147_1.time_ - var_150_6) / var_150_7

				if arg_147_1.var_.characterEffect10042ui_story and not isNil(var_150_5) then
					local var_150_9 = Mathf.Lerp(0, 0.5, var_150_8)

					arg_147_1.var_.characterEffect10042ui_story.fillFlat = true
					arg_147_1.var_.characterEffect10042ui_story.fillRatio = var_150_9
				end
			end

			if arg_147_1.time_ >= var_150_6 + var_150_7 and arg_147_1.time_ < var_150_6 + var_150_7 + arg_150_0 and not isNil(var_150_5) and arg_147_1.var_.characterEffect10042ui_story then
				local var_150_10 = 0.5

				arg_147_1.var_.characterEffect10042ui_story.fillFlat = true
				arg_147_1.var_.characterEffect10042ui_story.fillRatio = var_150_10
			end

			local var_150_11 = 0
			local var_150_12 = 0.15

			if var_150_11 < arg_147_1.time_ and arg_147_1.time_ <= var_150_11 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				local var_150_13 = arg_147_1:FormatText(StoryNameCfg[379].name)

				arg_147_1.leftNameTxt_.text = var_150_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_14 = arg_147_1:GetWordFromCfg(121421036)
				local var_150_15 = arg_147_1:FormatText(var_150_14.content)

				arg_147_1.text_.text = var_150_15

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_16 = 6
				local var_150_17 = utf8.len(var_150_15)
				local var_150_18 = var_150_16 <= 0 and var_150_12 or var_150_12 * (var_150_17 / var_150_16)

				if var_150_18 > 0 and var_150_12 < var_150_18 then
					arg_147_1.talkMaxDuration = var_150_18

					if var_150_18 + var_150_11 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_18 + var_150_11
					end
				end

				arg_147_1.text_.text = var_150_15
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121421", "121421036", "story_v_out_121421.awb") ~= 0 then
					local var_150_19 = manager.audio:GetVoiceLength("story_v_out_121421", "121421036", "story_v_out_121421.awb") / 1000

					if var_150_19 + var_150_11 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_19 + var_150_11
					end

					if var_150_14.prefab_name ~= "" and arg_147_1.actors_[var_150_14.prefab_name] ~= nil then
						local var_150_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_14.prefab_name].transform, "story_v_out_121421", "121421036", "story_v_out_121421.awb")

						arg_147_1:RecordAudio("121421036", var_150_20)
						arg_147_1:RecordAudio("121421036", var_150_20)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_121421", "121421036", "story_v_out_121421.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_121421", "121421036", "story_v_out_121421.awb")
				end

				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_21 = math.max(var_150_12, arg_147_1.talkMaxDuration)

			if var_150_11 <= arg_147_1.time_ and arg_147_1.time_ < var_150_11 + var_150_21 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_11) / var_150_21

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_11 + var_150_21 and arg_147_1.time_ < var_150_11 + var_150_21 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play121421037 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 121421037
		arg_151_1.duration_ = 10.3

		local var_151_0 = {
			ja = 9.533,
			ko = 10.3,
			zh = 10.3
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
				arg_151_0:Play121421038(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = arg_151_1.actors_["10042ui_story"]
			local var_154_1 = 0

			if var_154_1 < arg_151_1.time_ and arg_151_1.time_ <= var_154_1 + arg_154_0 and not isNil(var_154_0) and arg_151_1.var_.characterEffect10042ui_story == nil then
				arg_151_1.var_.characterEffect10042ui_story = var_154_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_2 = 0.200000002980232

			if var_154_1 <= arg_151_1.time_ and arg_151_1.time_ < var_154_1 + var_154_2 and not isNil(var_154_0) then
				local var_154_3 = (arg_151_1.time_ - var_154_1) / var_154_2

				if arg_151_1.var_.characterEffect10042ui_story and not isNil(var_154_0) then
					arg_151_1.var_.characterEffect10042ui_story.fillFlat = false
				end
			end

			if arg_151_1.time_ >= var_154_1 + var_154_2 and arg_151_1.time_ < var_154_1 + var_154_2 + arg_154_0 and not isNil(var_154_0) and arg_151_1.var_.characterEffect10042ui_story then
				arg_151_1.var_.characterEffect10042ui_story.fillFlat = false
			end

			local var_154_4 = 0

			if var_154_4 < arg_151_1.time_ and arg_151_1.time_ <= var_154_4 + arg_154_0 then
				arg_151_1:PlayTimeline("10042ui_story", "StoryTimeline/CharAction/story10042/story10042action/10042action2_1")
			end

			local var_154_5 = 0

			if var_154_5 < arg_151_1.time_ and arg_151_1.time_ <= var_154_5 + arg_154_0 then
				arg_151_1:PlayTimeline("10042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_154_6 = arg_151_1.actors_["1072ui_story"]
			local var_154_7 = 0

			if var_154_7 < arg_151_1.time_ and arg_151_1.time_ <= var_154_7 + arg_154_0 and not isNil(var_154_6) and arg_151_1.var_.characterEffect1072ui_story == nil then
				arg_151_1.var_.characterEffect1072ui_story = var_154_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_8 = 0.200000002980232

			if var_154_7 <= arg_151_1.time_ and arg_151_1.time_ < var_154_7 + var_154_8 and not isNil(var_154_6) then
				local var_154_9 = (arg_151_1.time_ - var_154_7) / var_154_8

				if arg_151_1.var_.characterEffect1072ui_story and not isNil(var_154_6) then
					local var_154_10 = Mathf.Lerp(0, 0.5, var_154_9)

					arg_151_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_151_1.var_.characterEffect1072ui_story.fillRatio = var_154_10
				end
			end

			if arg_151_1.time_ >= var_154_7 + var_154_8 and arg_151_1.time_ < var_154_7 + var_154_8 + arg_154_0 and not isNil(var_154_6) and arg_151_1.var_.characterEffect1072ui_story then
				local var_154_11 = 0.5

				arg_151_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_151_1.var_.characterEffect1072ui_story.fillRatio = var_154_11
			end

			local var_154_12 = 0
			local var_154_13 = 1.225

			if var_154_12 < arg_151_1.time_ and arg_151_1.time_ <= var_154_12 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				local var_154_14 = arg_151_1:FormatText(StoryNameCfg[388].name)

				arg_151_1.leftNameTxt_.text = var_154_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_15 = arg_151_1:GetWordFromCfg(121421037)
				local var_154_16 = arg_151_1:FormatText(var_154_15.content)

				arg_151_1.text_.text = var_154_16

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_17 = 49
				local var_154_18 = utf8.len(var_154_16)
				local var_154_19 = var_154_17 <= 0 and var_154_13 or var_154_13 * (var_154_18 / var_154_17)

				if var_154_19 > 0 and var_154_13 < var_154_19 then
					arg_151_1.talkMaxDuration = var_154_19

					if var_154_19 + var_154_12 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_19 + var_154_12
					end
				end

				arg_151_1.text_.text = var_154_16
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121421", "121421037", "story_v_out_121421.awb") ~= 0 then
					local var_154_20 = manager.audio:GetVoiceLength("story_v_out_121421", "121421037", "story_v_out_121421.awb") / 1000

					if var_154_20 + var_154_12 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_20 + var_154_12
					end

					if var_154_15.prefab_name ~= "" and arg_151_1.actors_[var_154_15.prefab_name] ~= nil then
						local var_154_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_15.prefab_name].transform, "story_v_out_121421", "121421037", "story_v_out_121421.awb")

						arg_151_1:RecordAudio("121421037", var_154_21)
						arg_151_1:RecordAudio("121421037", var_154_21)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_121421", "121421037", "story_v_out_121421.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_121421", "121421037", "story_v_out_121421.awb")
				end

				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_22 = math.max(var_154_13, arg_151_1.talkMaxDuration)

			if var_154_12 <= arg_151_1.time_ and arg_151_1.time_ < var_154_12 + var_154_22 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_12) / var_154_22

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_12 + var_154_22 and arg_151_1.time_ < var_154_12 + var_154_22 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play121421038 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 121421038
		arg_155_1.duration_ = 14.7

		local var_155_0 = {
			ja = 14.7,
			ko = 11.433,
			zh = 11.433
		}
		local var_155_1 = manager.audio:GetLocalizationFlag()

		if var_155_0[var_155_1] ~= nil then
			arg_155_1.duration_ = var_155_0[var_155_1]
		end

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play121421039(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = 0
			local var_158_1 = 1.275

			if var_158_0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_0 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				local var_158_2 = arg_155_1:FormatText(StoryNameCfg[388].name)

				arg_155_1.leftNameTxt_.text = var_158_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_3 = arg_155_1:GetWordFromCfg(121421038)
				local var_158_4 = arg_155_1:FormatText(var_158_3.content)

				arg_155_1.text_.text = var_158_4

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_5 = 51
				local var_158_6 = utf8.len(var_158_4)
				local var_158_7 = var_158_5 <= 0 and var_158_1 or var_158_1 * (var_158_6 / var_158_5)

				if var_158_7 > 0 and var_158_1 < var_158_7 then
					arg_155_1.talkMaxDuration = var_158_7

					if var_158_7 + var_158_0 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_7 + var_158_0
					end
				end

				arg_155_1.text_.text = var_158_4
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121421", "121421038", "story_v_out_121421.awb") ~= 0 then
					local var_158_8 = manager.audio:GetVoiceLength("story_v_out_121421", "121421038", "story_v_out_121421.awb") / 1000

					if var_158_8 + var_158_0 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_8 + var_158_0
					end

					if var_158_3.prefab_name ~= "" and arg_155_1.actors_[var_158_3.prefab_name] ~= nil then
						local var_158_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_3.prefab_name].transform, "story_v_out_121421", "121421038", "story_v_out_121421.awb")

						arg_155_1:RecordAudio("121421038", var_158_9)
						arg_155_1:RecordAudio("121421038", var_158_9)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_121421", "121421038", "story_v_out_121421.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_121421", "121421038", "story_v_out_121421.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_10 = math.max(var_158_1, arg_155_1.talkMaxDuration)

			if var_158_0 <= arg_155_1.time_ and arg_155_1.time_ < var_158_0 + var_158_10 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_0) / var_158_10

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_0 + var_158_10 and arg_155_1.time_ < var_158_0 + var_158_10 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {}

		arg_155_1:InitPlayNodeList()
	end,
	Play121421039 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 121421039
		arg_159_1.duration_ = 7.77

		local var_159_0 = {
			ja = 3.966,
			ko = 7.766,
			zh = 7.766
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
				arg_159_0:Play121421040(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = 0
			local var_162_1 = 0.725

			if var_162_0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_0 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				local var_162_2 = arg_159_1:FormatText(StoryNameCfg[388].name)

				arg_159_1.leftNameTxt_.text = var_162_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_3 = arg_159_1:GetWordFromCfg(121421039)
				local var_162_4 = arg_159_1:FormatText(var_162_3.content)

				arg_159_1.text_.text = var_162_4

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_5 = 29
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

				if manager.audio:GetVoiceLength("story_v_out_121421", "121421039", "story_v_out_121421.awb") ~= 0 then
					local var_162_8 = manager.audio:GetVoiceLength("story_v_out_121421", "121421039", "story_v_out_121421.awb") / 1000

					if var_162_8 + var_162_0 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_8 + var_162_0
					end

					if var_162_3.prefab_name ~= "" and arg_159_1.actors_[var_162_3.prefab_name] ~= nil then
						local var_162_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_3.prefab_name].transform, "story_v_out_121421", "121421039", "story_v_out_121421.awb")

						arg_159_1:RecordAudio("121421039", var_162_9)
						arg_159_1:RecordAudio("121421039", var_162_9)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_121421", "121421039", "story_v_out_121421.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_121421", "121421039", "story_v_out_121421.awb")
				end

				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_10 = math.max(var_162_1, arg_159_1.talkMaxDuration)

			if var_162_0 <= arg_159_1.time_ and arg_159_1.time_ < var_162_0 + var_162_10 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_0) / var_162_10

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_0 + var_162_10 and arg_159_1.time_ < var_162_0 + var_162_10 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play121421040 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 121421040
		arg_163_1.duration_ = 5

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play121421041(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = arg_163_1.actors_["1072ui_story"].transform
			local var_166_1 = 0

			if var_166_1 < arg_163_1.time_ and arg_163_1.time_ <= var_166_1 + arg_166_0 then
				arg_163_1.var_.moveOldPos1072ui_story = var_166_0.localPosition
			end

			local var_166_2 = 0.001

			if var_166_1 <= arg_163_1.time_ and arg_163_1.time_ < var_166_1 + var_166_2 then
				local var_166_3 = (arg_163_1.time_ - var_166_1) / var_166_2
				local var_166_4 = Vector3.New(0, 100, 0)

				var_166_0.localPosition = Vector3.Lerp(arg_163_1.var_.moveOldPos1072ui_story, var_166_4, var_166_3)

				local var_166_5 = manager.ui.mainCamera.transform.position - var_166_0.position

				var_166_0.forward = Vector3.New(var_166_5.x, var_166_5.y, var_166_5.z)

				local var_166_6 = var_166_0.localEulerAngles

				var_166_6.z = 0
				var_166_6.x = 0
				var_166_0.localEulerAngles = var_166_6
			end

			if arg_163_1.time_ >= var_166_1 + var_166_2 and arg_163_1.time_ < var_166_1 + var_166_2 + arg_166_0 then
				var_166_0.localPosition = Vector3.New(0, 100, 0)

				local var_166_7 = manager.ui.mainCamera.transform.position - var_166_0.position

				var_166_0.forward = Vector3.New(var_166_7.x, var_166_7.y, var_166_7.z)

				local var_166_8 = var_166_0.localEulerAngles

				var_166_8.z = 0
				var_166_8.x = 0
				var_166_0.localEulerAngles = var_166_8
			end

			local var_166_9 = arg_163_1.actors_["1072ui_story"]
			local var_166_10 = 0

			if var_166_10 < arg_163_1.time_ and arg_163_1.time_ <= var_166_10 + arg_166_0 and not isNil(var_166_9) and arg_163_1.var_.characterEffect1072ui_story == nil then
				arg_163_1.var_.characterEffect1072ui_story = var_166_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_166_11 = 0.034000001847744

			if var_166_10 <= arg_163_1.time_ and arg_163_1.time_ < var_166_10 + var_166_11 and not isNil(var_166_9) then
				local var_166_12 = (arg_163_1.time_ - var_166_10) / var_166_11

				if arg_163_1.var_.characterEffect1072ui_story and not isNil(var_166_9) then
					local var_166_13 = Mathf.Lerp(0, 0.5, var_166_12)

					arg_163_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_163_1.var_.characterEffect1072ui_story.fillRatio = var_166_13
				end
			end

			if arg_163_1.time_ >= var_166_10 + var_166_11 and arg_163_1.time_ < var_166_10 + var_166_11 + arg_166_0 and not isNil(var_166_9) and arg_163_1.var_.characterEffect1072ui_story then
				local var_166_14 = 0.5

				arg_163_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_163_1.var_.characterEffect1072ui_story.fillRatio = var_166_14
			end

			local var_166_15 = arg_163_1.actors_["10042ui_story"].transform
			local var_166_16 = 0

			if var_166_16 < arg_163_1.time_ and arg_163_1.time_ <= var_166_16 + arg_166_0 then
				arg_163_1.var_.moveOldPos10042ui_story = var_166_15.localPosition
			end

			local var_166_17 = 0.001

			if var_166_16 <= arg_163_1.time_ and arg_163_1.time_ < var_166_16 + var_166_17 then
				local var_166_18 = (arg_163_1.time_ - var_166_16) / var_166_17
				local var_166_19 = Vector3.New(0, 100, 0)

				var_166_15.localPosition = Vector3.Lerp(arg_163_1.var_.moveOldPos10042ui_story, var_166_19, var_166_18)

				local var_166_20 = manager.ui.mainCamera.transform.position - var_166_15.position

				var_166_15.forward = Vector3.New(var_166_20.x, var_166_20.y, var_166_20.z)

				local var_166_21 = var_166_15.localEulerAngles

				var_166_21.z = 0
				var_166_21.x = 0
				var_166_15.localEulerAngles = var_166_21
			end

			if arg_163_1.time_ >= var_166_16 + var_166_17 and arg_163_1.time_ < var_166_16 + var_166_17 + arg_166_0 then
				var_166_15.localPosition = Vector3.New(0, 100, 0)

				local var_166_22 = manager.ui.mainCamera.transform.position - var_166_15.position

				var_166_15.forward = Vector3.New(var_166_22.x, var_166_22.y, var_166_22.z)

				local var_166_23 = var_166_15.localEulerAngles

				var_166_23.z = 0
				var_166_23.x = 0
				var_166_15.localEulerAngles = var_166_23
			end

			local var_166_24 = arg_163_1.actors_["10042ui_story"]
			local var_166_25 = 0

			if var_166_25 < arg_163_1.time_ and arg_163_1.time_ <= var_166_25 + arg_166_0 and not isNil(var_166_24) and arg_163_1.var_.characterEffect10042ui_story == nil then
				arg_163_1.var_.characterEffect10042ui_story = var_166_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_166_26 = 0.034000001847744

			if var_166_25 <= arg_163_1.time_ and arg_163_1.time_ < var_166_25 + var_166_26 and not isNil(var_166_24) then
				local var_166_27 = (arg_163_1.time_ - var_166_25) / var_166_26

				if arg_163_1.var_.characterEffect10042ui_story and not isNil(var_166_24) then
					local var_166_28 = Mathf.Lerp(0, 0.5, var_166_27)

					arg_163_1.var_.characterEffect10042ui_story.fillFlat = true
					arg_163_1.var_.characterEffect10042ui_story.fillRatio = var_166_28
				end
			end

			if arg_163_1.time_ >= var_166_25 + var_166_26 and arg_163_1.time_ < var_166_25 + var_166_26 + arg_166_0 and not isNil(var_166_24) and arg_163_1.var_.characterEffect10042ui_story then
				local var_166_29 = 0.5

				arg_163_1.var_.characterEffect10042ui_story.fillFlat = true
				arg_163_1.var_.characterEffect10042ui_story.fillRatio = var_166_29
			end

			local var_166_30 = 0
			local var_166_31 = 0.333333333333333

			if var_166_30 < arg_163_1.time_ and arg_163_1.time_ <= var_166_30 + arg_166_0 then
				local var_166_32 = "stop"
				local var_166_33 = "music"

				arg_163_1:AudioAction(var_166_32, var_166_33, "se_story_side_1096", "se_story_1096_crowd_loop", "")

				local var_166_34 = ""
				local var_166_35 = manager.audio:GetAudioName("se_story_side_1096", "se_story_1096_crowd_loop")

				if var_166_35 ~= "" then
					if arg_163_1.bgmTxt_.text ~= var_166_35 and arg_163_1.bgmTxt_.text ~= "" then
						if arg_163_1.bgmTxt2_.text ~= "" then
							arg_163_1.bgmTxt_.text = arg_163_1.bgmTxt2_.text
						end

						arg_163_1.bgmTxt2_.text = var_166_35

						arg_163_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_163_1.bgmTxt_.text = var_166_35
						arg_163_1.bgmTxt2_.text = var_166_35
					end

					if arg_163_1.bgmTimer then
						arg_163_1.bgmTimer:Stop()

						arg_163_1.bgmTimer = nil
					end

					if arg_163_1.settingData.show_music_name == 1 then
						arg_163_1.musicController:SetSelectedState("show")
						arg_163_1.musicAnimator_:Play("open", 0, 0)

						if arg_163_1.settingData.music_time ~= 0 then
							arg_163_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_163_1.settingData.music_time), function()
								if arg_163_1 == nil or isNil(arg_163_1.bgmTxt_) then
									return
								end

								arg_163_1.musicController:SetSelectedState("hide")
								arg_163_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_166_36 = 0
			local var_166_37 = 1.1

			if var_166_36 < arg_163_1.time_ and arg_163_1.time_ <= var_166_36 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, false)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_38 = arg_163_1:GetWordFromCfg(121421040)
				local var_166_39 = arg_163_1:FormatText(var_166_38.content)

				arg_163_1.text_.text = var_166_39

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_40 = 44
				local var_166_41 = utf8.len(var_166_39)
				local var_166_42 = var_166_40 <= 0 and var_166_37 or var_166_37 * (var_166_41 / var_166_40)

				if var_166_42 > 0 and var_166_37 < var_166_42 then
					arg_163_1.talkMaxDuration = var_166_42

					if var_166_42 + var_166_36 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_42 + var_166_36
					end
				end

				arg_163_1.text_.text = var_166_39
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)
				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_43 = math.max(var_166_37, arg_163_1.talkMaxDuration)

			if var_166_36 <= arg_163_1.time_ and arg_163_1.time_ < var_166_36 + var_166_43 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_36) / var_166_43

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_36 + var_166_43 and arg_163_1.time_ < var_166_36 + var_166_43 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {
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
				actorName = "10042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_163_1:InitPlayNodeList()
	end,
	Play121421041 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 121421041
		arg_168_1.duration_ = 5

		SetActive(arg_168_1.tipsGo_, false)

		function arg_168_1.onSingleLineFinish_()
			arg_168_1.onSingleLineUpdate_ = nil
			arg_168_1.onSingleLineFinish_ = nil
			arg_168_1.state_ = "waiting"
		end

		function arg_168_1.playNext_(arg_170_0)
			if arg_170_0 == 1 then
				arg_168_0:Play121421042(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			local var_171_0 = 0
			local var_171_1 = 1.375

			if var_171_0 < arg_168_1.time_ and arg_168_1.time_ <= var_171_0 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0
				arg_168_1.dialogCg_.alpha = 1

				arg_168_1.dialog_:SetActive(true)
				SetActive(arg_168_1.leftNameGo_, false)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_168_1.iconTrs_.gameObject, false)
				arg_168_1.callingController_:SetSelectedState("normal")

				local var_171_2 = arg_168_1:GetWordFromCfg(121421041)
				local var_171_3 = arg_168_1:FormatText(var_171_2.content)

				arg_168_1.text_.text = var_171_3

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_4 = 55
				local var_171_5 = utf8.len(var_171_3)
				local var_171_6 = var_171_4 <= 0 and var_171_1 or var_171_1 * (var_171_5 / var_171_4)

				if var_171_6 > 0 and var_171_1 < var_171_6 then
					arg_168_1.talkMaxDuration = var_171_6

					if var_171_6 + var_171_0 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_6 + var_171_0
					end
				end

				arg_168_1.text_.text = var_171_3
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)
				arg_168_1:RecordContent(arg_168_1.text_.text)
			end

			local var_171_7 = math.max(var_171_1, arg_168_1.talkMaxDuration)

			if var_171_0 <= arg_168_1.time_ and arg_168_1.time_ < var_171_0 + var_171_7 then
				arg_168_1.typewritter.percent = (arg_168_1.time_ - var_171_0) / var_171_7

				arg_168_1.typewritter:SetDirty()
			end

			if arg_168_1.time_ >= var_171_0 + var_171_7 and arg_168_1.time_ < var_171_0 + var_171_7 + arg_171_0 then
				arg_168_1.typewritter.percent = 1

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(true)
			end
		end

		arg_168_1.nodeConfigList_ = {}

		arg_168_1:InitPlayNodeList()
	end,
	Play121421042 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 121421042
		arg_172_1.duration_ = 1.7

		local var_172_0 = {
			ja = 1.7,
			ko = 1.3,
			zh = 1.3
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
				arg_172_0:Play121421043(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			local var_175_0 = 0
			local var_175_1 = 0.15

			if var_175_0 < arg_172_1.time_ and arg_172_1.time_ <= var_175_0 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, true)

				local var_175_2 = arg_172_1:FormatText(StoryNameCfg[432].name)

				arg_172_1.leftNameTxt_.text = var_175_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_172_1.leftNameTxt_.transform)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1.leftNameTxt_.text)
				SetActive(arg_172_1.iconTrs_.gameObject, true)
				arg_172_1.iconController_:SetSelectedState("hero")

				arg_172_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwa")

				arg_172_1.callingController_:SetSelectedState("normal")

				arg_172_1.keyicon_.color = Color.New(1, 1, 1)
				arg_172_1.icon_.color = Color.New(1, 1, 1)

				local var_175_3 = arg_172_1:GetWordFromCfg(121421042)
				local var_175_4 = arg_172_1:FormatText(var_175_3.content)

				arg_172_1.text_.text = var_175_4

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_5 = 6
				local var_175_6 = utf8.len(var_175_4)
				local var_175_7 = var_175_5 <= 0 and var_175_1 or var_175_1 * (var_175_6 / var_175_5)

				if var_175_7 > 0 and var_175_1 < var_175_7 then
					arg_172_1.talkMaxDuration = var_175_7

					if var_175_7 + var_175_0 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_7 + var_175_0
					end
				end

				arg_172_1.text_.text = var_175_4
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121421", "121421042", "story_v_out_121421.awb") ~= 0 then
					local var_175_8 = manager.audio:GetVoiceLength("story_v_out_121421", "121421042", "story_v_out_121421.awb") / 1000

					if var_175_8 + var_175_0 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_8 + var_175_0
					end

					if var_175_3.prefab_name ~= "" and arg_172_1.actors_[var_175_3.prefab_name] ~= nil then
						local var_175_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_172_1.actors_[var_175_3.prefab_name].transform, "story_v_out_121421", "121421042", "story_v_out_121421.awb")

						arg_172_1:RecordAudio("121421042", var_175_9)
						arg_172_1:RecordAudio("121421042", var_175_9)
					else
						arg_172_1:AudioAction("play", "voice", "story_v_out_121421", "121421042", "story_v_out_121421.awb")
					end

					arg_172_1:RecordHistoryTalkVoice("story_v_out_121421", "121421042", "story_v_out_121421.awb")
				end

				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_10 = math.max(var_175_1, arg_172_1.talkMaxDuration)

			if var_175_0 <= arg_172_1.time_ and arg_172_1.time_ < var_175_0 + var_175_10 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - var_175_0) / var_175_10

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= var_175_0 + var_175_10 and arg_172_1.time_ < var_175_0 + var_175_10 + arg_175_0 then
				arg_172_1.typewritter.percent = 1

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(true)
			end
		end

		arg_172_1.nodeConfigList_ = {}

		arg_172_1:InitPlayNodeList()
	end,
	Play121421043 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 121421043
		arg_176_1.duration_ = 12.27

		local var_176_0 = {
			ja = 12.266,
			ko = 7.733,
			zh = 7.733
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
				arg_176_0:Play121421044(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			local var_179_0 = arg_176_1.actors_["1072ui_story"].transform
			local var_179_1 = 0

			if var_179_1 < arg_176_1.time_ and arg_176_1.time_ <= var_179_1 + arg_179_0 then
				arg_176_1.var_.moveOldPos1072ui_story = var_179_0.localPosition
			end

			local var_179_2 = 0.001

			if var_179_1 <= arg_176_1.time_ and arg_176_1.time_ < var_179_1 + var_179_2 then
				local var_179_3 = (arg_176_1.time_ - var_179_1) / var_179_2
				local var_179_4 = Vector3.New(0, -0.71, -6)

				var_179_0.localPosition = Vector3.Lerp(arg_176_1.var_.moveOldPos1072ui_story, var_179_4, var_179_3)

				local var_179_5 = manager.ui.mainCamera.transform.position - var_179_0.position

				var_179_0.forward = Vector3.New(var_179_5.x, var_179_5.y, var_179_5.z)

				local var_179_6 = var_179_0.localEulerAngles

				var_179_6.z = 0
				var_179_6.x = 0
				var_179_0.localEulerAngles = var_179_6
			end

			if arg_176_1.time_ >= var_179_1 + var_179_2 and arg_176_1.time_ < var_179_1 + var_179_2 + arg_179_0 then
				var_179_0.localPosition = Vector3.New(0, -0.71, -6)

				local var_179_7 = manager.ui.mainCamera.transform.position - var_179_0.position

				var_179_0.forward = Vector3.New(var_179_7.x, var_179_7.y, var_179_7.z)

				local var_179_8 = var_179_0.localEulerAngles

				var_179_8.z = 0
				var_179_8.x = 0
				var_179_0.localEulerAngles = var_179_8
			end

			local var_179_9 = arg_176_1.actors_["1072ui_story"]
			local var_179_10 = 0

			if var_179_10 < arg_176_1.time_ and arg_176_1.time_ <= var_179_10 + arg_179_0 and not isNil(var_179_9) and arg_176_1.var_.characterEffect1072ui_story == nil then
				arg_176_1.var_.characterEffect1072ui_story = var_179_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_179_11 = 0.200000002980232

			if var_179_10 <= arg_176_1.time_ and arg_176_1.time_ < var_179_10 + var_179_11 and not isNil(var_179_9) then
				local var_179_12 = (arg_176_1.time_ - var_179_10) / var_179_11

				if arg_176_1.var_.characterEffect1072ui_story and not isNil(var_179_9) then
					arg_176_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_176_1.time_ >= var_179_10 + var_179_11 and arg_176_1.time_ < var_179_10 + var_179_11 + arg_179_0 and not isNil(var_179_9) and arg_176_1.var_.characterEffect1072ui_story then
				arg_176_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_179_13 = 0

			if var_179_13 < arg_176_1.time_ and arg_176_1.time_ <= var_179_13 + arg_179_0 then
				arg_176_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action1_1")
			end

			local var_179_14 = 0

			if var_179_14 < arg_176_1.time_ and arg_176_1.time_ <= var_179_14 + arg_179_0 then
				arg_176_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_179_15 = 0
			local var_179_16 = 0.775

			if var_179_15 < arg_176_1.time_ and arg_176_1.time_ <= var_179_15 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0
				arg_176_1.dialogCg_.alpha = 1

				arg_176_1.dialog_:SetActive(true)
				SetActive(arg_176_1.leftNameGo_, true)

				local var_179_17 = arg_176_1:FormatText(StoryNameCfg[379].name)

				arg_176_1.leftNameTxt_.text = var_179_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_176_1.leftNameTxt_.transform)

				arg_176_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_176_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_176_1:RecordName(arg_176_1.leftNameTxt_.text)
				SetActive(arg_176_1.iconTrs_.gameObject, false)
				arg_176_1.callingController_:SetSelectedState("normal")

				local var_179_18 = arg_176_1:GetWordFromCfg(121421043)
				local var_179_19 = arg_176_1:FormatText(var_179_18.content)

				arg_176_1.text_.text = var_179_19

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.text_)

				local var_179_20 = 31
				local var_179_21 = utf8.len(var_179_19)
				local var_179_22 = var_179_20 <= 0 and var_179_16 or var_179_16 * (var_179_21 / var_179_20)

				if var_179_22 > 0 and var_179_16 < var_179_22 then
					arg_176_1.talkMaxDuration = var_179_22

					if var_179_22 + var_179_15 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_22 + var_179_15
					end
				end

				arg_176_1.text_.text = var_179_19
				arg_176_1.typewritter.percent = 0

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121421", "121421043", "story_v_out_121421.awb") ~= 0 then
					local var_179_23 = manager.audio:GetVoiceLength("story_v_out_121421", "121421043", "story_v_out_121421.awb") / 1000

					if var_179_23 + var_179_15 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_23 + var_179_15
					end

					if var_179_18.prefab_name ~= "" and arg_176_1.actors_[var_179_18.prefab_name] ~= nil then
						local var_179_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_176_1.actors_[var_179_18.prefab_name].transform, "story_v_out_121421", "121421043", "story_v_out_121421.awb")

						arg_176_1:RecordAudio("121421043", var_179_24)
						arg_176_1:RecordAudio("121421043", var_179_24)
					else
						arg_176_1:AudioAction("play", "voice", "story_v_out_121421", "121421043", "story_v_out_121421.awb")
					end

					arg_176_1:RecordHistoryTalkVoice("story_v_out_121421", "121421043", "story_v_out_121421.awb")
				end

				arg_176_1:RecordContent(arg_176_1.text_.text)
			end

			local var_179_25 = math.max(var_179_16, arg_176_1.talkMaxDuration)

			if var_179_15 <= arg_176_1.time_ and arg_176_1.time_ < var_179_15 + var_179_25 then
				arg_176_1.typewritter.percent = (arg_176_1.time_ - var_179_15) / var_179_25

				arg_176_1.typewritter:SetDirty()
			end

			if arg_176_1.time_ >= var_179_15 + var_179_25 and arg_176_1.time_ < var_179_15 + var_179_25 + arg_179_0 then
				arg_176_1.typewritter.percent = 1

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(true)
			end
		end

		arg_176_1.nodeConfigList_ = {
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

		arg_176_1:InitPlayNodeList()
	end,
	Play121421044 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 121421044
		arg_180_1.duration_ = 10.2

		local var_180_0 = {
			ja = 10.2,
			ko = 6.633,
			zh = 6.633
		}
		local var_180_1 = manager.audio:GetLocalizationFlag()

		if var_180_0[var_180_1] ~= nil then
			arg_180_1.duration_ = var_180_0[var_180_1]
		end

		SetActive(arg_180_1.tipsGo_, false)

		function arg_180_1.onSingleLineFinish_()
			arg_180_1.onSingleLineUpdate_ = nil
			arg_180_1.onSingleLineFinish_ = nil
			arg_180_1.state_ = "waiting"
		end

		function arg_180_1.playNext_(arg_182_0)
			if arg_182_0 == 1 then
				arg_180_0:Play121421045(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			local var_183_0 = 0

			if var_183_0 < arg_180_1.time_ and arg_180_1.time_ <= var_183_0 + arg_183_0 then
				arg_180_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action7_1")
			end

			local var_183_1 = 0

			if var_183_1 < arg_180_1.time_ and arg_180_1.time_ <= var_183_1 + arg_183_0 then
				arg_180_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_183_2 = 0
			local var_183_3 = 0.825

			if var_183_2 < arg_180_1.time_ and arg_180_1.time_ <= var_183_2 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0
				arg_180_1.dialogCg_.alpha = 1

				arg_180_1.dialog_:SetActive(true)
				SetActive(arg_180_1.leftNameGo_, true)

				local var_183_4 = arg_180_1:FormatText(StoryNameCfg[379].name)

				arg_180_1.leftNameTxt_.text = var_183_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_180_1.leftNameTxt_.transform)

				arg_180_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_180_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_180_1:RecordName(arg_180_1.leftNameTxt_.text)
				SetActive(arg_180_1.iconTrs_.gameObject, false)
				arg_180_1.callingController_:SetSelectedState("normal")

				local var_183_5 = arg_180_1:GetWordFromCfg(121421044)
				local var_183_6 = arg_180_1:FormatText(var_183_5.content)

				arg_180_1.text_.text = var_183_6

				LuaForUtil.ClearLinePrefixSymbol(arg_180_1.text_)

				local var_183_7 = 33
				local var_183_8 = utf8.len(var_183_6)
				local var_183_9 = var_183_7 <= 0 and var_183_3 or var_183_3 * (var_183_8 / var_183_7)

				if var_183_9 > 0 and var_183_3 < var_183_9 then
					arg_180_1.talkMaxDuration = var_183_9

					if var_183_9 + var_183_2 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_9 + var_183_2
					end
				end

				arg_180_1.text_.text = var_183_6
				arg_180_1.typewritter.percent = 0

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121421", "121421044", "story_v_out_121421.awb") ~= 0 then
					local var_183_10 = manager.audio:GetVoiceLength("story_v_out_121421", "121421044", "story_v_out_121421.awb") / 1000

					if var_183_10 + var_183_2 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_10 + var_183_2
					end

					if var_183_5.prefab_name ~= "" and arg_180_1.actors_[var_183_5.prefab_name] ~= nil then
						local var_183_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_180_1.actors_[var_183_5.prefab_name].transform, "story_v_out_121421", "121421044", "story_v_out_121421.awb")

						arg_180_1:RecordAudio("121421044", var_183_11)
						arg_180_1:RecordAudio("121421044", var_183_11)
					else
						arg_180_1:AudioAction("play", "voice", "story_v_out_121421", "121421044", "story_v_out_121421.awb")
					end

					arg_180_1:RecordHistoryTalkVoice("story_v_out_121421", "121421044", "story_v_out_121421.awb")
				end

				arg_180_1:RecordContent(arg_180_1.text_.text)
			end

			local var_183_12 = math.max(var_183_3, arg_180_1.talkMaxDuration)

			if var_183_2 <= arg_180_1.time_ and arg_180_1.time_ < var_183_2 + var_183_12 then
				arg_180_1.typewritter.percent = (arg_180_1.time_ - var_183_2) / var_183_12

				arg_180_1.typewritter:SetDirty()
			end

			if arg_180_1.time_ >= var_183_2 + var_183_12 and arg_180_1.time_ < var_183_2 + var_183_12 + arg_183_0 then
				arg_180_1.typewritter.percent = 1

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(true)
			end
		end

		arg_180_1.nodeConfigList_ = {}

		arg_180_1:InitPlayNodeList()
	end,
	Play121421045 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 121421045
		arg_184_1.duration_ = 6.5

		local var_184_0 = {
			ja = 6.5,
			ko = 4.066,
			zh = 4.066
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
				arg_184_0:Play121421046(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			local var_187_0 = arg_184_1.actors_["1072ui_story"]
			local var_187_1 = 0

			if var_187_1 < arg_184_1.time_ and arg_184_1.time_ <= var_187_1 + arg_187_0 and not isNil(var_187_0) and arg_184_1.var_.characterEffect1072ui_story == nil then
				arg_184_1.var_.characterEffect1072ui_story = var_187_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_187_2 = 0.200000002980232

			if var_187_1 <= arg_184_1.time_ and arg_184_1.time_ < var_187_1 + var_187_2 and not isNil(var_187_0) then
				local var_187_3 = (arg_184_1.time_ - var_187_1) / var_187_2

				if arg_184_1.var_.characterEffect1072ui_story and not isNil(var_187_0) then
					local var_187_4 = Mathf.Lerp(0, 0.5, var_187_3)

					arg_184_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_184_1.var_.characterEffect1072ui_story.fillRatio = var_187_4
				end
			end

			if arg_184_1.time_ >= var_187_1 + var_187_2 and arg_184_1.time_ < var_187_1 + var_187_2 + arg_187_0 and not isNil(var_187_0) and arg_184_1.var_.characterEffect1072ui_story then
				local var_187_5 = 0.5

				arg_184_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_184_1.var_.characterEffect1072ui_story.fillRatio = var_187_5
			end

			local var_187_6 = 0
			local var_187_7 = 0.45

			if var_187_6 < arg_184_1.time_ and arg_184_1.time_ <= var_187_6 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0
				arg_184_1.dialogCg_.alpha = 1

				arg_184_1.dialog_:SetActive(true)
				SetActive(arg_184_1.leftNameGo_, true)

				local var_187_8 = arg_184_1:FormatText(StoryNameCfg[432].name)

				arg_184_1.leftNameTxt_.text = var_187_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_184_1.leftNameTxt_.transform)

				arg_184_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_184_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_184_1:RecordName(arg_184_1.leftNameTxt_.text)
				SetActive(arg_184_1.iconTrs_.gameObject, true)
				arg_184_1.iconController_:SetSelectedState("hero")

				arg_184_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwa")

				arg_184_1.callingController_:SetSelectedState("normal")

				arg_184_1.keyicon_.color = Color.New(1, 1, 1)
				arg_184_1.icon_.color = Color.New(1, 1, 1)

				local var_187_9 = arg_184_1:GetWordFromCfg(121421045)
				local var_187_10 = arg_184_1:FormatText(var_187_9.content)

				arg_184_1.text_.text = var_187_10

				LuaForUtil.ClearLinePrefixSymbol(arg_184_1.text_)

				local var_187_11 = 18
				local var_187_12 = utf8.len(var_187_10)
				local var_187_13 = var_187_11 <= 0 and var_187_7 or var_187_7 * (var_187_12 / var_187_11)

				if var_187_13 > 0 and var_187_7 < var_187_13 then
					arg_184_1.talkMaxDuration = var_187_13

					if var_187_13 + var_187_6 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_13 + var_187_6
					end
				end

				arg_184_1.text_.text = var_187_10
				arg_184_1.typewritter.percent = 0

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121421", "121421045", "story_v_out_121421.awb") ~= 0 then
					local var_187_14 = manager.audio:GetVoiceLength("story_v_out_121421", "121421045", "story_v_out_121421.awb") / 1000

					if var_187_14 + var_187_6 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_14 + var_187_6
					end

					if var_187_9.prefab_name ~= "" and arg_184_1.actors_[var_187_9.prefab_name] ~= nil then
						local var_187_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_184_1.actors_[var_187_9.prefab_name].transform, "story_v_out_121421", "121421045", "story_v_out_121421.awb")

						arg_184_1:RecordAudio("121421045", var_187_15)
						arg_184_1:RecordAudio("121421045", var_187_15)
					else
						arg_184_1:AudioAction("play", "voice", "story_v_out_121421", "121421045", "story_v_out_121421.awb")
					end

					arg_184_1:RecordHistoryTalkVoice("story_v_out_121421", "121421045", "story_v_out_121421.awb")
				end

				arg_184_1:RecordContent(arg_184_1.text_.text)
			end

			local var_187_16 = math.max(var_187_7, arg_184_1.talkMaxDuration)

			if var_187_6 <= arg_184_1.time_ and arg_184_1.time_ < var_187_6 + var_187_16 then
				arg_184_1.typewritter.percent = (arg_184_1.time_ - var_187_6) / var_187_16

				arg_184_1.typewritter:SetDirty()
			end

			if arg_184_1.time_ >= var_187_6 + var_187_16 and arg_184_1.time_ < var_187_6 + var_187_16 + arg_187_0 then
				arg_184_1.typewritter.percent = 1

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(true)
			end
		end

		arg_184_1.nodeConfigList_ = {}

		arg_184_1:InitPlayNodeList()
	end,
	Play121421046 = function(arg_188_0, arg_188_1)
		arg_188_1.time_ = 0
		arg_188_1.frameCnt_ = 0
		arg_188_1.state_ = "playing"
		arg_188_1.curTalkId_ = 121421046
		arg_188_1.duration_ = 8.3

		local var_188_0 = {
			ja = 8.3,
			ko = 7.366,
			zh = 7.366
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
				arg_188_0:Play121421047(arg_188_1)
			end
		end

		function arg_188_1.onSingleLineUpdate_(arg_191_0)
			local var_191_0 = arg_188_1.actors_["1072ui_story"]
			local var_191_1 = 0

			if var_191_1 < arg_188_1.time_ and arg_188_1.time_ <= var_191_1 + arg_191_0 and not isNil(var_191_0) and arg_188_1.var_.characterEffect1072ui_story == nil then
				arg_188_1.var_.characterEffect1072ui_story = var_191_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_191_2 = 0.200000002980232

			if var_191_1 <= arg_188_1.time_ and arg_188_1.time_ < var_191_1 + var_191_2 and not isNil(var_191_0) then
				local var_191_3 = (arg_188_1.time_ - var_191_1) / var_191_2

				if arg_188_1.var_.characterEffect1072ui_story and not isNil(var_191_0) then
					arg_188_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_188_1.time_ >= var_191_1 + var_191_2 and arg_188_1.time_ < var_191_1 + var_191_2 + arg_191_0 and not isNil(var_191_0) and arg_188_1.var_.characterEffect1072ui_story then
				arg_188_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_191_4 = 0

			if var_191_4 < arg_188_1.time_ and arg_188_1.time_ <= var_191_4 + arg_191_0 then
				arg_188_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action7_2")
			end

			local var_191_5 = 0

			if var_191_5 < arg_188_1.time_ and arg_188_1.time_ <= var_191_5 + arg_191_0 then
				arg_188_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_191_6 = 0
			local var_191_7 = 0.75

			if var_191_6 < arg_188_1.time_ and arg_188_1.time_ <= var_191_6 + arg_191_0 then
				arg_188_1.talkMaxDuration = 0
				arg_188_1.dialogCg_.alpha = 1

				arg_188_1.dialog_:SetActive(true)
				SetActive(arg_188_1.leftNameGo_, true)

				local var_191_8 = arg_188_1:FormatText(StoryNameCfg[379].name)

				arg_188_1.leftNameTxt_.text = var_191_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_188_1.leftNameTxt_.transform)

				arg_188_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_188_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_188_1:RecordName(arg_188_1.leftNameTxt_.text)
				SetActive(arg_188_1.iconTrs_.gameObject, false)
				arg_188_1.callingController_:SetSelectedState("normal")

				local var_191_9 = arg_188_1:GetWordFromCfg(121421046)
				local var_191_10 = arg_188_1:FormatText(var_191_9.content)

				arg_188_1.text_.text = var_191_10

				LuaForUtil.ClearLinePrefixSymbol(arg_188_1.text_)

				local var_191_11 = 30
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

				if manager.audio:GetVoiceLength("story_v_out_121421", "121421046", "story_v_out_121421.awb") ~= 0 then
					local var_191_14 = manager.audio:GetVoiceLength("story_v_out_121421", "121421046", "story_v_out_121421.awb") / 1000

					if var_191_14 + var_191_6 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_14 + var_191_6
					end

					if var_191_9.prefab_name ~= "" and arg_188_1.actors_[var_191_9.prefab_name] ~= nil then
						local var_191_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_188_1.actors_[var_191_9.prefab_name].transform, "story_v_out_121421", "121421046", "story_v_out_121421.awb")

						arg_188_1:RecordAudio("121421046", var_191_15)
						arg_188_1:RecordAudio("121421046", var_191_15)
					else
						arg_188_1:AudioAction("play", "voice", "story_v_out_121421", "121421046", "story_v_out_121421.awb")
					end

					arg_188_1:RecordHistoryTalkVoice("story_v_out_121421", "121421046", "story_v_out_121421.awb")
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
	Play121421047 = function(arg_192_0, arg_192_1)
		arg_192_1.time_ = 0
		arg_192_1.frameCnt_ = 0
		arg_192_1.state_ = "playing"
		arg_192_1.curTalkId_ = 121421047
		arg_192_1.duration_ = 7.1

		local var_192_0 = {
			ja = 7.033,
			ko = 7.1,
			zh = 7.1
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
				arg_192_0:Play121421048(arg_192_1)
			end
		end

		function arg_192_1.onSingleLineUpdate_(arg_195_0)
			local var_195_0 = 0
			local var_195_1 = 0.85

			if var_195_0 < arg_192_1.time_ and arg_192_1.time_ <= var_195_0 + arg_195_0 then
				arg_192_1.talkMaxDuration = 0
				arg_192_1.dialogCg_.alpha = 1

				arg_192_1.dialog_:SetActive(true)
				SetActive(arg_192_1.leftNameGo_, true)

				local var_195_2 = arg_192_1:FormatText(StoryNameCfg[379].name)

				arg_192_1.leftNameTxt_.text = var_195_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_192_1.leftNameTxt_.transform)

				arg_192_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_192_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_192_1:RecordName(arg_192_1.leftNameTxt_.text)
				SetActive(arg_192_1.iconTrs_.gameObject, false)
				arg_192_1.callingController_:SetSelectedState("normal")

				local var_195_3 = arg_192_1:GetWordFromCfg(121421047)
				local var_195_4 = arg_192_1:FormatText(var_195_3.content)

				arg_192_1.text_.text = var_195_4

				LuaForUtil.ClearLinePrefixSymbol(arg_192_1.text_)

				local var_195_5 = 34
				local var_195_6 = utf8.len(var_195_4)
				local var_195_7 = var_195_5 <= 0 and var_195_1 or var_195_1 * (var_195_6 / var_195_5)

				if var_195_7 > 0 and var_195_1 < var_195_7 then
					arg_192_1.talkMaxDuration = var_195_7

					if var_195_7 + var_195_0 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_7 + var_195_0
					end
				end

				arg_192_1.text_.text = var_195_4
				arg_192_1.typewritter.percent = 0

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121421", "121421047", "story_v_out_121421.awb") ~= 0 then
					local var_195_8 = manager.audio:GetVoiceLength("story_v_out_121421", "121421047", "story_v_out_121421.awb") / 1000

					if var_195_8 + var_195_0 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_8 + var_195_0
					end

					if var_195_3.prefab_name ~= "" and arg_192_1.actors_[var_195_3.prefab_name] ~= nil then
						local var_195_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_192_1.actors_[var_195_3.prefab_name].transform, "story_v_out_121421", "121421047", "story_v_out_121421.awb")

						arg_192_1:RecordAudio("121421047", var_195_9)
						arg_192_1:RecordAudio("121421047", var_195_9)
					else
						arg_192_1:AudioAction("play", "voice", "story_v_out_121421", "121421047", "story_v_out_121421.awb")
					end

					arg_192_1:RecordHistoryTalkVoice("story_v_out_121421", "121421047", "story_v_out_121421.awb")
				end

				arg_192_1:RecordContent(arg_192_1.text_.text)
			end

			local var_195_10 = math.max(var_195_1, arg_192_1.talkMaxDuration)

			if var_195_0 <= arg_192_1.time_ and arg_192_1.time_ < var_195_0 + var_195_10 then
				arg_192_1.typewritter.percent = (arg_192_1.time_ - var_195_0) / var_195_10

				arg_192_1.typewritter:SetDirty()
			end

			if arg_192_1.time_ >= var_195_0 + var_195_10 and arg_192_1.time_ < var_195_0 + var_195_10 + arg_195_0 then
				arg_192_1.typewritter.percent = 1

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(true)
			end
		end

		arg_192_1.nodeConfigList_ = {}

		arg_192_1:InitPlayNodeList()
	end,
	Play121421048 = function(arg_196_0, arg_196_1)
		arg_196_1.time_ = 0
		arg_196_1.frameCnt_ = 0
		arg_196_1.state_ = "playing"
		arg_196_1.curTalkId_ = 121421048
		arg_196_1.duration_ = 8.6

		local var_196_0 = {
			ja = 8.6,
			ko = 5.933,
			zh = 5.933
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
				arg_196_0:Play121421049(arg_196_1)
			end
		end

		function arg_196_1.onSingleLineUpdate_(arg_199_0)
			local var_199_0 = 0
			local var_199_1 = 0.675

			if var_199_0 < arg_196_1.time_ and arg_196_1.time_ <= var_199_0 + arg_199_0 then
				arg_196_1.talkMaxDuration = 0
				arg_196_1.dialogCg_.alpha = 1

				arg_196_1.dialog_:SetActive(true)
				SetActive(arg_196_1.leftNameGo_, true)

				local var_199_2 = arg_196_1:FormatText(StoryNameCfg[379].name)

				arg_196_1.leftNameTxt_.text = var_199_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_196_1.leftNameTxt_.transform)

				arg_196_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_196_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_196_1:RecordName(arg_196_1.leftNameTxt_.text)
				SetActive(arg_196_1.iconTrs_.gameObject, false)
				arg_196_1.callingController_:SetSelectedState("normal")

				local var_199_3 = arg_196_1:GetWordFromCfg(121421048)
				local var_199_4 = arg_196_1:FormatText(var_199_3.content)

				arg_196_1.text_.text = var_199_4

				LuaForUtil.ClearLinePrefixSymbol(arg_196_1.text_)

				local var_199_5 = 27
				local var_199_6 = utf8.len(var_199_4)
				local var_199_7 = var_199_5 <= 0 and var_199_1 or var_199_1 * (var_199_6 / var_199_5)

				if var_199_7 > 0 and var_199_1 < var_199_7 then
					arg_196_1.talkMaxDuration = var_199_7

					if var_199_7 + var_199_0 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_7 + var_199_0
					end
				end

				arg_196_1.text_.text = var_199_4
				arg_196_1.typewritter.percent = 0

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121421", "121421048", "story_v_out_121421.awb") ~= 0 then
					local var_199_8 = manager.audio:GetVoiceLength("story_v_out_121421", "121421048", "story_v_out_121421.awb") / 1000

					if var_199_8 + var_199_0 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_8 + var_199_0
					end

					if var_199_3.prefab_name ~= "" and arg_196_1.actors_[var_199_3.prefab_name] ~= nil then
						local var_199_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_196_1.actors_[var_199_3.prefab_name].transform, "story_v_out_121421", "121421048", "story_v_out_121421.awb")

						arg_196_1:RecordAudio("121421048", var_199_9)
						arg_196_1:RecordAudio("121421048", var_199_9)
					else
						arg_196_1:AudioAction("play", "voice", "story_v_out_121421", "121421048", "story_v_out_121421.awb")
					end

					arg_196_1:RecordHistoryTalkVoice("story_v_out_121421", "121421048", "story_v_out_121421.awb")
				end

				arg_196_1:RecordContent(arg_196_1.text_.text)
			end

			local var_199_10 = math.max(var_199_1, arg_196_1.talkMaxDuration)

			if var_199_0 <= arg_196_1.time_ and arg_196_1.time_ < var_199_0 + var_199_10 then
				arg_196_1.typewritter.percent = (arg_196_1.time_ - var_199_0) / var_199_10

				arg_196_1.typewritter:SetDirty()
			end

			if arg_196_1.time_ >= var_199_0 + var_199_10 and arg_196_1.time_ < var_199_0 + var_199_10 + arg_199_0 then
				arg_196_1.typewritter.percent = 1

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(true)
			end
		end

		arg_196_1.nodeConfigList_ = {}

		arg_196_1:InitPlayNodeList()
	end,
	Play121421049 = function(arg_200_0, arg_200_1)
		arg_200_1.time_ = 0
		arg_200_1.frameCnt_ = 0
		arg_200_1.state_ = "playing"
		arg_200_1.curTalkId_ = 121421049
		arg_200_1.duration_ = 3.93

		local var_200_0 = {
			ja = 3.933,
			ko = 2.333,
			zh = 2.333
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
				arg_200_0:Play121421050(arg_200_1)
			end
		end

		function arg_200_1.onSingleLineUpdate_(arg_203_0)
			local var_203_0 = arg_200_1.actors_["1072ui_story"]
			local var_203_1 = 0

			if var_203_1 < arg_200_1.time_ and arg_200_1.time_ <= var_203_1 + arg_203_0 and not isNil(var_203_0) and arg_200_1.var_.characterEffect1072ui_story == nil then
				arg_200_1.var_.characterEffect1072ui_story = var_203_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_203_2 = 0.200000002980232

			if var_203_1 <= arg_200_1.time_ and arg_200_1.time_ < var_203_1 + var_203_2 and not isNil(var_203_0) then
				local var_203_3 = (arg_200_1.time_ - var_203_1) / var_203_2

				if arg_200_1.var_.characterEffect1072ui_story and not isNil(var_203_0) then
					local var_203_4 = Mathf.Lerp(0, 0.5, var_203_3)

					arg_200_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_200_1.var_.characterEffect1072ui_story.fillRatio = var_203_4
				end
			end

			if arg_200_1.time_ >= var_203_1 + var_203_2 and arg_200_1.time_ < var_203_1 + var_203_2 + arg_203_0 and not isNil(var_203_0) and arg_200_1.var_.characterEffect1072ui_story then
				local var_203_5 = 0.5

				arg_200_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_200_1.var_.characterEffect1072ui_story.fillRatio = var_203_5
			end

			local var_203_6 = 0
			local var_203_7 = 0.325

			if var_203_6 < arg_200_1.time_ and arg_200_1.time_ <= var_203_6 + arg_203_0 then
				arg_200_1.talkMaxDuration = 0
				arg_200_1.dialogCg_.alpha = 1

				arg_200_1.dialog_:SetActive(true)
				SetActive(arg_200_1.leftNameGo_, true)

				local var_203_8 = arg_200_1:FormatText(StoryNameCfg[432].name)

				arg_200_1.leftNameTxt_.text = var_203_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_200_1.leftNameTxt_.transform)

				arg_200_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_200_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_200_1:RecordName(arg_200_1.leftNameTxt_.text)
				SetActive(arg_200_1.iconTrs_.gameObject, true)
				arg_200_1.iconController_:SetSelectedState("hero")

				arg_200_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwa")

				arg_200_1.callingController_:SetSelectedState("normal")

				arg_200_1.keyicon_.color = Color.New(1, 1, 1)
				arg_200_1.icon_.color = Color.New(1, 1, 1)

				local var_203_9 = arg_200_1:GetWordFromCfg(121421049)
				local var_203_10 = arg_200_1:FormatText(var_203_9.content)

				arg_200_1.text_.text = var_203_10

				LuaForUtil.ClearLinePrefixSymbol(arg_200_1.text_)

				local var_203_11 = 13
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

				if manager.audio:GetVoiceLength("story_v_out_121421", "121421049", "story_v_out_121421.awb") ~= 0 then
					local var_203_14 = manager.audio:GetVoiceLength("story_v_out_121421", "121421049", "story_v_out_121421.awb") / 1000

					if var_203_14 + var_203_6 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_14 + var_203_6
					end

					if var_203_9.prefab_name ~= "" and arg_200_1.actors_[var_203_9.prefab_name] ~= nil then
						local var_203_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_200_1.actors_[var_203_9.prefab_name].transform, "story_v_out_121421", "121421049", "story_v_out_121421.awb")

						arg_200_1:RecordAudio("121421049", var_203_15)
						arg_200_1:RecordAudio("121421049", var_203_15)
					else
						arg_200_1:AudioAction("play", "voice", "story_v_out_121421", "121421049", "story_v_out_121421.awb")
					end

					arg_200_1:RecordHistoryTalkVoice("story_v_out_121421", "121421049", "story_v_out_121421.awb")
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
	Play121421050 = function(arg_204_0, arg_204_1)
		arg_204_1.time_ = 0
		arg_204_1.frameCnt_ = 0
		arg_204_1.state_ = "playing"
		arg_204_1.curTalkId_ = 121421050
		arg_204_1.duration_ = 14.8

		local var_204_0 = {
			ja = 14.8,
			ko = 10,
			zh = 10
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
				arg_204_0:Play121421051(arg_204_1)
			end
		end

		function arg_204_1.onSingleLineUpdate_(arg_207_0)
			local var_207_0 = arg_204_1.actors_["1072ui_story"]
			local var_207_1 = 0

			if var_207_1 < arg_204_1.time_ and arg_204_1.time_ <= var_207_1 + arg_207_0 and not isNil(var_207_0) and arg_204_1.var_.characterEffect1072ui_story == nil then
				arg_204_1.var_.characterEffect1072ui_story = var_207_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_207_2 = 0.200000002980232

			if var_207_1 <= arg_204_1.time_ and arg_204_1.time_ < var_207_1 + var_207_2 and not isNil(var_207_0) then
				local var_207_3 = (arg_204_1.time_ - var_207_1) / var_207_2

				if arg_204_1.var_.characterEffect1072ui_story and not isNil(var_207_0) then
					arg_204_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_204_1.time_ >= var_207_1 + var_207_2 and arg_204_1.time_ < var_207_1 + var_207_2 + arg_207_0 and not isNil(var_207_0) and arg_204_1.var_.characterEffect1072ui_story then
				arg_204_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_207_4 = 0

			if var_207_4 < arg_204_1.time_ and arg_204_1.time_ <= var_207_4 + arg_207_0 then
				arg_204_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action1_1")
			end

			local var_207_5 = 0

			if var_207_5 < arg_204_1.time_ and arg_204_1.time_ <= var_207_5 + arg_207_0 then
				arg_204_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_207_6 = 0
			local var_207_7 = 1.05

			if var_207_6 < arg_204_1.time_ and arg_204_1.time_ <= var_207_6 + arg_207_0 then
				arg_204_1.talkMaxDuration = 0
				arg_204_1.dialogCg_.alpha = 1

				arg_204_1.dialog_:SetActive(true)
				SetActive(arg_204_1.leftNameGo_, true)

				local var_207_8 = arg_204_1:FormatText(StoryNameCfg[379].name)

				arg_204_1.leftNameTxt_.text = var_207_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_204_1.leftNameTxt_.transform)

				arg_204_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_204_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_204_1:RecordName(arg_204_1.leftNameTxt_.text)
				SetActive(arg_204_1.iconTrs_.gameObject, false)
				arg_204_1.callingController_:SetSelectedState("normal")

				local var_207_9 = arg_204_1:GetWordFromCfg(121421050)
				local var_207_10 = arg_204_1:FormatText(var_207_9.content)

				arg_204_1.text_.text = var_207_10

				LuaForUtil.ClearLinePrefixSymbol(arg_204_1.text_)

				local var_207_11 = 42
				local var_207_12 = utf8.len(var_207_10)
				local var_207_13 = var_207_11 <= 0 and var_207_7 or var_207_7 * (var_207_12 / var_207_11)

				if var_207_13 > 0 and var_207_7 < var_207_13 then
					arg_204_1.talkMaxDuration = var_207_13

					if var_207_13 + var_207_6 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_13 + var_207_6
					end
				end

				arg_204_1.text_.text = var_207_10
				arg_204_1.typewritter.percent = 0

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121421", "121421050", "story_v_out_121421.awb") ~= 0 then
					local var_207_14 = manager.audio:GetVoiceLength("story_v_out_121421", "121421050", "story_v_out_121421.awb") / 1000

					if var_207_14 + var_207_6 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_14 + var_207_6
					end

					if var_207_9.prefab_name ~= "" and arg_204_1.actors_[var_207_9.prefab_name] ~= nil then
						local var_207_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_204_1.actors_[var_207_9.prefab_name].transform, "story_v_out_121421", "121421050", "story_v_out_121421.awb")

						arg_204_1:RecordAudio("121421050", var_207_15)
						arg_204_1:RecordAudio("121421050", var_207_15)
					else
						arg_204_1:AudioAction("play", "voice", "story_v_out_121421", "121421050", "story_v_out_121421.awb")
					end

					arg_204_1:RecordHistoryTalkVoice("story_v_out_121421", "121421050", "story_v_out_121421.awb")
				end

				arg_204_1:RecordContent(arg_204_1.text_.text)
			end

			local var_207_16 = math.max(var_207_7, arg_204_1.talkMaxDuration)

			if var_207_6 <= arg_204_1.time_ and arg_204_1.time_ < var_207_6 + var_207_16 then
				arg_204_1.typewritter.percent = (arg_204_1.time_ - var_207_6) / var_207_16

				arg_204_1.typewritter:SetDirty()
			end

			if arg_204_1.time_ >= var_207_6 + var_207_16 and arg_204_1.time_ < var_207_6 + var_207_16 + arg_207_0 then
				arg_204_1.typewritter.percent = 1

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(true)
			end
		end

		arg_204_1.nodeConfigList_ = {}

		arg_204_1:InitPlayNodeList()
	end,
	Play121421051 = function(arg_208_0, arg_208_1)
		arg_208_1.time_ = 0
		arg_208_1.frameCnt_ = 0
		arg_208_1.state_ = "playing"
		arg_208_1.curTalkId_ = 121421051
		arg_208_1.duration_ = 5.97

		local var_208_0 = {
			ja = 2.7,
			ko = 5.966,
			zh = 5.966
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
				arg_208_0:Play121421052(arg_208_1)
			end
		end

		function arg_208_1.onSingleLineUpdate_(arg_211_0)
			local var_211_0 = 0

			if var_211_0 < arg_208_1.time_ and arg_208_1.time_ <= var_211_0 + arg_211_0 then
				arg_208_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action4_1")
			end

			local var_211_1 = 0
			local var_211_2 = 0.8

			if var_211_1 < arg_208_1.time_ and arg_208_1.time_ <= var_211_1 + arg_211_0 then
				arg_208_1.talkMaxDuration = 0
				arg_208_1.dialogCg_.alpha = 1

				arg_208_1.dialog_:SetActive(true)
				SetActive(arg_208_1.leftNameGo_, true)

				local var_211_3 = arg_208_1:FormatText(StoryNameCfg[379].name)

				arg_208_1.leftNameTxt_.text = var_211_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_208_1.leftNameTxt_.transform)

				arg_208_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_208_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_208_1:RecordName(arg_208_1.leftNameTxt_.text)
				SetActive(arg_208_1.iconTrs_.gameObject, false)
				arg_208_1.callingController_:SetSelectedState("normal")

				local var_211_4 = arg_208_1:GetWordFromCfg(121421051)
				local var_211_5 = arg_208_1:FormatText(var_211_4.content)

				arg_208_1.text_.text = var_211_5

				LuaForUtil.ClearLinePrefixSymbol(arg_208_1.text_)

				local var_211_6 = 32
				local var_211_7 = utf8.len(var_211_5)
				local var_211_8 = var_211_6 <= 0 and var_211_2 or var_211_2 * (var_211_7 / var_211_6)

				if var_211_8 > 0 and var_211_2 < var_211_8 then
					arg_208_1.talkMaxDuration = var_211_8

					if var_211_8 + var_211_1 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_8 + var_211_1
					end
				end

				arg_208_1.text_.text = var_211_5
				arg_208_1.typewritter.percent = 0

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121421", "121421051", "story_v_out_121421.awb") ~= 0 then
					local var_211_9 = manager.audio:GetVoiceLength("story_v_out_121421", "121421051", "story_v_out_121421.awb") / 1000

					if var_211_9 + var_211_1 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_9 + var_211_1
					end

					if var_211_4.prefab_name ~= "" and arg_208_1.actors_[var_211_4.prefab_name] ~= nil then
						local var_211_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_208_1.actors_[var_211_4.prefab_name].transform, "story_v_out_121421", "121421051", "story_v_out_121421.awb")

						arg_208_1:RecordAudio("121421051", var_211_10)
						arg_208_1:RecordAudio("121421051", var_211_10)
					else
						arg_208_1:AudioAction("play", "voice", "story_v_out_121421", "121421051", "story_v_out_121421.awb")
					end

					arg_208_1:RecordHistoryTalkVoice("story_v_out_121421", "121421051", "story_v_out_121421.awb")
				end

				arg_208_1:RecordContent(arg_208_1.text_.text)
			end

			local var_211_11 = math.max(var_211_2, arg_208_1.talkMaxDuration)

			if var_211_1 <= arg_208_1.time_ and arg_208_1.time_ < var_211_1 + var_211_11 then
				arg_208_1.typewritter.percent = (arg_208_1.time_ - var_211_1) / var_211_11

				arg_208_1.typewritter:SetDirty()
			end

			if arg_208_1.time_ >= var_211_1 + var_211_11 and arg_208_1.time_ < var_211_1 + var_211_11 + arg_211_0 then
				arg_208_1.typewritter.percent = 1

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(true)
			end
		end

		arg_208_1.nodeConfigList_ = {}

		arg_208_1:InitPlayNodeList()
	end,
	Play121421052 = function(arg_212_0, arg_212_1)
		arg_212_1.time_ = 0
		arg_212_1.frameCnt_ = 0
		arg_212_1.state_ = "playing"
		arg_212_1.curTalkId_ = 121421052
		arg_212_1.duration_ = 7.77

		local var_212_0 = {
			ja = 7.766,
			ko = 7.433,
			zh = 7.433
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
				arg_212_0:Play121421053(arg_212_1)
			end
		end

		function arg_212_1.onSingleLineUpdate_(arg_215_0)
			local var_215_0 = 0

			if var_215_0 < arg_212_1.time_ and arg_212_1.time_ <= var_215_0 + arg_215_0 then
				arg_212_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action4_2")
			end

			local var_215_1 = 0

			if var_215_1 < arg_212_1.time_ and arg_212_1.time_ <= var_215_1 + arg_215_0 then
				arg_212_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_215_2 = 0
			local var_215_3 = 0.925

			if var_215_2 < arg_212_1.time_ and arg_212_1.time_ <= var_215_2 + arg_215_0 then
				arg_212_1.talkMaxDuration = 0
				arg_212_1.dialogCg_.alpha = 1

				arg_212_1.dialog_:SetActive(true)
				SetActive(arg_212_1.leftNameGo_, true)

				local var_215_4 = arg_212_1:FormatText(StoryNameCfg[379].name)

				arg_212_1.leftNameTxt_.text = var_215_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_212_1.leftNameTxt_.transform)

				arg_212_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_212_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_212_1:RecordName(arg_212_1.leftNameTxt_.text)
				SetActive(arg_212_1.iconTrs_.gameObject, false)
				arg_212_1.callingController_:SetSelectedState("normal")

				local var_215_5 = arg_212_1:GetWordFromCfg(121421052)
				local var_215_6 = arg_212_1:FormatText(var_215_5.content)

				arg_212_1.text_.text = var_215_6

				LuaForUtil.ClearLinePrefixSymbol(arg_212_1.text_)

				local var_215_7 = 37
				local var_215_8 = utf8.len(var_215_6)
				local var_215_9 = var_215_7 <= 0 and var_215_3 or var_215_3 * (var_215_8 / var_215_7)

				if var_215_9 > 0 and var_215_3 < var_215_9 then
					arg_212_1.talkMaxDuration = var_215_9

					if var_215_9 + var_215_2 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_9 + var_215_2
					end
				end

				arg_212_1.text_.text = var_215_6
				arg_212_1.typewritter.percent = 0

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121421", "121421052", "story_v_out_121421.awb") ~= 0 then
					local var_215_10 = manager.audio:GetVoiceLength("story_v_out_121421", "121421052", "story_v_out_121421.awb") / 1000

					if var_215_10 + var_215_2 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_10 + var_215_2
					end

					if var_215_5.prefab_name ~= "" and arg_212_1.actors_[var_215_5.prefab_name] ~= nil then
						local var_215_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_212_1.actors_[var_215_5.prefab_name].transform, "story_v_out_121421", "121421052", "story_v_out_121421.awb")

						arg_212_1:RecordAudio("121421052", var_215_11)
						arg_212_1:RecordAudio("121421052", var_215_11)
					else
						arg_212_1:AudioAction("play", "voice", "story_v_out_121421", "121421052", "story_v_out_121421.awb")
					end

					arg_212_1:RecordHistoryTalkVoice("story_v_out_121421", "121421052", "story_v_out_121421.awb")
				end

				arg_212_1:RecordContent(arg_212_1.text_.text)
			end

			local var_215_12 = math.max(var_215_3, arg_212_1.talkMaxDuration)

			if var_215_2 <= arg_212_1.time_ and arg_212_1.time_ < var_215_2 + var_215_12 then
				arg_212_1.typewritter.percent = (arg_212_1.time_ - var_215_2) / var_215_12

				arg_212_1.typewritter:SetDirty()
			end

			if arg_212_1.time_ >= var_215_2 + var_215_12 and arg_212_1.time_ < var_215_2 + var_215_12 + arg_215_0 then
				arg_212_1.typewritter.percent = 1

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(true)
			end
		end

		arg_212_1.nodeConfigList_ = {}

		arg_212_1:InitPlayNodeList()
	end,
	Play121421053 = function(arg_216_0, arg_216_1)
		arg_216_1.time_ = 0
		arg_216_1.frameCnt_ = 0
		arg_216_1.state_ = "playing"
		arg_216_1.curTalkId_ = 121421053
		arg_216_1.duration_ = 5

		SetActive(arg_216_1.tipsGo_, false)

		function arg_216_1.onSingleLineFinish_()
			arg_216_1.onSingleLineUpdate_ = nil
			arg_216_1.onSingleLineFinish_ = nil
			arg_216_1.state_ = "waiting"
		end

		function arg_216_1.playNext_(arg_218_0)
			if arg_218_0 == 1 then
				arg_216_0:Play121421054(arg_216_1)
			end
		end

		function arg_216_1.onSingleLineUpdate_(arg_219_0)
			local var_219_0 = arg_216_1.actors_["1072ui_story"]
			local var_219_1 = 0

			if var_219_1 < arg_216_1.time_ and arg_216_1.time_ <= var_219_1 + arg_219_0 and not isNil(var_219_0) and arg_216_1.var_.characterEffect1072ui_story == nil then
				arg_216_1.var_.characterEffect1072ui_story = var_219_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_219_2 = 0.034000001847744

			if var_219_1 <= arg_216_1.time_ and arg_216_1.time_ < var_219_1 + var_219_2 and not isNil(var_219_0) then
				local var_219_3 = (arg_216_1.time_ - var_219_1) / var_219_2

				if arg_216_1.var_.characterEffect1072ui_story and not isNil(var_219_0) then
					local var_219_4 = Mathf.Lerp(0, 0.5, var_219_3)

					arg_216_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_216_1.var_.characterEffect1072ui_story.fillRatio = var_219_4
				end
			end

			if arg_216_1.time_ >= var_219_1 + var_219_2 and arg_216_1.time_ < var_219_1 + var_219_2 + arg_219_0 and not isNil(var_219_0) and arg_216_1.var_.characterEffect1072ui_story then
				local var_219_5 = 0.5

				arg_216_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_216_1.var_.characterEffect1072ui_story.fillRatio = var_219_5
			end

			local var_219_6 = arg_216_1.actors_["1072ui_story"].transform
			local var_219_7 = 0

			if var_219_7 < arg_216_1.time_ and arg_216_1.time_ <= var_219_7 + arg_219_0 then
				arg_216_1.var_.moveOldPos1072ui_story = var_219_6.localPosition
			end

			local var_219_8 = 0.001

			if var_219_7 <= arg_216_1.time_ and arg_216_1.time_ < var_219_7 + var_219_8 then
				local var_219_9 = (arg_216_1.time_ - var_219_7) / var_219_8
				local var_219_10 = Vector3.New(0, 100, 0)

				var_219_6.localPosition = Vector3.Lerp(arg_216_1.var_.moveOldPos1072ui_story, var_219_10, var_219_9)

				local var_219_11 = manager.ui.mainCamera.transform.position - var_219_6.position

				var_219_6.forward = Vector3.New(var_219_11.x, var_219_11.y, var_219_11.z)

				local var_219_12 = var_219_6.localEulerAngles

				var_219_12.z = 0
				var_219_12.x = 0
				var_219_6.localEulerAngles = var_219_12
			end

			if arg_216_1.time_ >= var_219_7 + var_219_8 and arg_216_1.time_ < var_219_7 + var_219_8 + arg_219_0 then
				var_219_6.localPosition = Vector3.New(0, 100, 0)

				local var_219_13 = manager.ui.mainCamera.transform.position - var_219_6.position

				var_219_6.forward = Vector3.New(var_219_13.x, var_219_13.y, var_219_13.z)

				local var_219_14 = var_219_6.localEulerAngles

				var_219_14.z = 0
				var_219_14.x = 0
				var_219_6.localEulerAngles = var_219_14
			end

			local var_219_15 = 0
			local var_219_16 = 0.875

			if var_219_15 < arg_216_1.time_ and arg_216_1.time_ <= var_219_15 + arg_219_0 then
				arg_216_1.talkMaxDuration = 0
				arg_216_1.dialogCg_.alpha = 1

				arg_216_1.dialog_:SetActive(true)
				SetActive(arg_216_1.leftNameGo_, false)

				arg_216_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_216_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_216_1:RecordName(arg_216_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_216_1.iconTrs_.gameObject, false)
				arg_216_1.callingController_:SetSelectedState("normal")

				local var_219_17 = arg_216_1:GetWordFromCfg(121421053)
				local var_219_18 = arg_216_1:FormatText(var_219_17.content)

				arg_216_1.text_.text = var_219_18

				LuaForUtil.ClearLinePrefixSymbol(arg_216_1.text_)

				local var_219_19 = 35
				local var_219_20 = utf8.len(var_219_18)
				local var_219_21 = var_219_19 <= 0 and var_219_16 or var_219_16 * (var_219_20 / var_219_19)

				if var_219_21 > 0 and var_219_16 < var_219_21 then
					arg_216_1.talkMaxDuration = var_219_21

					if var_219_21 + var_219_15 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_21 + var_219_15
					end
				end

				arg_216_1.text_.text = var_219_18
				arg_216_1.typewritter.percent = 0

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(false)
				arg_216_1:RecordContent(arg_216_1.text_.text)
			end

			local var_219_22 = math.max(var_219_16, arg_216_1.talkMaxDuration)

			if var_219_15 <= arg_216_1.time_ and arg_216_1.time_ < var_219_15 + var_219_22 then
				arg_216_1.typewritter.percent = (arg_216_1.time_ - var_219_15) / var_219_22

				arg_216_1.typewritter:SetDirty()
			end

			if arg_216_1.time_ >= var_219_15 + var_219_22 and arg_216_1.time_ < var_219_15 + var_219_22 + arg_219_0 then
				arg_216_1.typewritter.percent = 1

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(true)
			end
		end

		arg_216_1.nodeConfigList_ = {
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

		arg_216_1:InitPlayNodeList()
	end,
	Play121421054 = function(arg_220_0, arg_220_1)
		arg_220_1.time_ = 0
		arg_220_1.frameCnt_ = 0
		arg_220_1.state_ = "playing"
		arg_220_1.curTalkId_ = 121421054
		arg_220_1.duration_ = 5

		SetActive(arg_220_1.tipsGo_, false)

		function arg_220_1.onSingleLineFinish_()
			arg_220_1.onSingleLineUpdate_ = nil
			arg_220_1.onSingleLineFinish_ = nil
			arg_220_1.state_ = "waiting"
		end

		function arg_220_1.playNext_(arg_222_0)
			if arg_222_0 == 1 then
				arg_220_0:Play121421055(arg_220_1)
			end
		end

		function arg_220_1.onSingleLineUpdate_(arg_223_0)
			local var_223_0 = 0
			local var_223_1 = 1.075

			if var_223_0 < arg_220_1.time_ and arg_220_1.time_ <= var_223_0 + arg_223_0 then
				arg_220_1.talkMaxDuration = 0
				arg_220_1.dialogCg_.alpha = 1

				arg_220_1.dialog_:SetActive(true)
				SetActive(arg_220_1.leftNameGo_, false)

				arg_220_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_220_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_220_1:RecordName(arg_220_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_220_1.iconTrs_.gameObject, false)
				arg_220_1.callingController_:SetSelectedState("normal")

				local var_223_2 = arg_220_1:GetWordFromCfg(121421054)
				local var_223_3 = arg_220_1:FormatText(var_223_2.content)

				arg_220_1.text_.text = var_223_3

				LuaForUtil.ClearLinePrefixSymbol(arg_220_1.text_)

				local var_223_4 = 43
				local var_223_5 = utf8.len(var_223_3)
				local var_223_6 = var_223_4 <= 0 and var_223_1 or var_223_1 * (var_223_5 / var_223_4)

				if var_223_6 > 0 and var_223_1 < var_223_6 then
					arg_220_1.talkMaxDuration = var_223_6

					if var_223_6 + var_223_0 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_6 + var_223_0
					end
				end

				arg_220_1.text_.text = var_223_3
				arg_220_1.typewritter.percent = 0

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(false)
				arg_220_1:RecordContent(arg_220_1.text_.text)
			end

			local var_223_7 = math.max(var_223_1, arg_220_1.talkMaxDuration)

			if var_223_0 <= arg_220_1.time_ and arg_220_1.time_ < var_223_0 + var_223_7 then
				arg_220_1.typewritter.percent = (arg_220_1.time_ - var_223_0) / var_223_7

				arg_220_1.typewritter:SetDirty()
			end

			if arg_220_1.time_ >= var_223_0 + var_223_7 and arg_220_1.time_ < var_223_0 + var_223_7 + arg_223_0 then
				arg_220_1.typewritter.percent = 1

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(true)
			end
		end

		arg_220_1.nodeConfigList_ = {}

		arg_220_1:InitPlayNodeList()
	end,
	Play121421055 = function(arg_224_0, arg_224_1)
		arg_224_1.time_ = 0
		arg_224_1.frameCnt_ = 0
		arg_224_1.state_ = "playing"
		arg_224_1.curTalkId_ = 121421055
		arg_224_1.duration_ = 4.27

		local var_224_0 = {
			ja = 4.266,
			ko = 1.999999999999,
			zh = 1.999999999999
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
				arg_224_0:Play121421056(arg_224_1)
			end
		end

		function arg_224_1.onSingleLineUpdate_(arg_227_0)
			local var_227_0 = arg_224_1.actors_["10042ui_story"].transform
			local var_227_1 = 0

			if var_227_1 < arg_224_1.time_ and arg_224_1.time_ <= var_227_1 + arg_227_0 then
				arg_224_1.var_.moveOldPos10042ui_story = var_227_0.localPosition
			end

			local var_227_2 = 0.001

			if var_227_1 <= arg_224_1.time_ and arg_224_1.time_ < var_227_1 + var_227_2 then
				local var_227_3 = (arg_224_1.time_ - var_227_1) / var_227_2
				local var_227_4 = Vector3.New(0, -1.12, -6.2)

				var_227_0.localPosition = Vector3.Lerp(arg_224_1.var_.moveOldPos10042ui_story, var_227_4, var_227_3)

				local var_227_5 = manager.ui.mainCamera.transform.position - var_227_0.position

				var_227_0.forward = Vector3.New(var_227_5.x, var_227_5.y, var_227_5.z)

				local var_227_6 = var_227_0.localEulerAngles

				var_227_6.z = 0
				var_227_6.x = 0
				var_227_0.localEulerAngles = var_227_6
			end

			if arg_224_1.time_ >= var_227_1 + var_227_2 and arg_224_1.time_ < var_227_1 + var_227_2 + arg_227_0 then
				var_227_0.localPosition = Vector3.New(0, -1.12, -6.2)

				local var_227_7 = manager.ui.mainCamera.transform.position - var_227_0.position

				var_227_0.forward = Vector3.New(var_227_7.x, var_227_7.y, var_227_7.z)

				local var_227_8 = var_227_0.localEulerAngles

				var_227_8.z = 0
				var_227_8.x = 0
				var_227_0.localEulerAngles = var_227_8
			end

			local var_227_9 = arg_224_1.actors_["10042ui_story"]
			local var_227_10 = 0

			if var_227_10 < arg_224_1.time_ and arg_224_1.time_ <= var_227_10 + arg_227_0 and not isNil(var_227_9) and arg_224_1.var_.characterEffect10042ui_story == nil then
				arg_224_1.var_.characterEffect10042ui_story = var_227_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_227_11 = 0.200000002980232

			if var_227_10 <= arg_224_1.time_ and arg_224_1.time_ < var_227_10 + var_227_11 and not isNil(var_227_9) then
				local var_227_12 = (arg_224_1.time_ - var_227_10) / var_227_11

				if arg_224_1.var_.characterEffect10042ui_story and not isNil(var_227_9) then
					arg_224_1.var_.characterEffect10042ui_story.fillFlat = false
				end
			end

			if arg_224_1.time_ >= var_227_10 + var_227_11 and arg_224_1.time_ < var_227_10 + var_227_11 + arg_227_0 and not isNil(var_227_9) and arg_224_1.var_.characterEffect10042ui_story then
				arg_224_1.var_.characterEffect10042ui_story.fillFlat = false
			end

			local var_227_13 = 0

			if var_227_13 < arg_224_1.time_ and arg_224_1.time_ <= var_227_13 + arg_227_0 then
				arg_224_1:PlayTimeline("10042ui_story", "StoryTimeline/CharAction/story10042/story10042action/10042action1_1")
			end

			local var_227_14 = 0

			if var_227_14 < arg_224_1.time_ and arg_224_1.time_ <= var_227_14 + arg_227_0 then
				arg_224_1:PlayTimeline("10042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_227_15 = 0
			local var_227_16 = 0.15

			if var_227_15 < arg_224_1.time_ and arg_224_1.time_ <= var_227_15 + arg_227_0 then
				arg_224_1.talkMaxDuration = 0
				arg_224_1.dialogCg_.alpha = 1

				arg_224_1.dialog_:SetActive(true)
				SetActive(arg_224_1.leftNameGo_, true)

				local var_227_17 = arg_224_1:FormatText(StoryNameCfg[388].name)

				arg_224_1.leftNameTxt_.text = var_227_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_224_1.leftNameTxt_.transform)

				arg_224_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_224_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_224_1:RecordName(arg_224_1.leftNameTxt_.text)
				SetActive(arg_224_1.iconTrs_.gameObject, false)
				arg_224_1.callingController_:SetSelectedState("normal")

				local var_227_18 = arg_224_1:GetWordFromCfg(121421055)
				local var_227_19 = arg_224_1:FormatText(var_227_18.content)

				arg_224_1.text_.text = var_227_19

				LuaForUtil.ClearLinePrefixSymbol(arg_224_1.text_)

				local var_227_20 = 6
				local var_227_21 = utf8.len(var_227_19)
				local var_227_22 = var_227_20 <= 0 and var_227_16 or var_227_16 * (var_227_21 / var_227_20)

				if var_227_22 > 0 and var_227_16 < var_227_22 then
					arg_224_1.talkMaxDuration = var_227_22

					if var_227_22 + var_227_15 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_22 + var_227_15
					end
				end

				arg_224_1.text_.text = var_227_19
				arg_224_1.typewritter.percent = 0

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121421", "121421055", "story_v_out_121421.awb") ~= 0 then
					local var_227_23 = manager.audio:GetVoiceLength("story_v_out_121421", "121421055", "story_v_out_121421.awb") / 1000

					if var_227_23 + var_227_15 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_23 + var_227_15
					end

					if var_227_18.prefab_name ~= "" and arg_224_1.actors_[var_227_18.prefab_name] ~= nil then
						local var_227_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_224_1.actors_[var_227_18.prefab_name].transform, "story_v_out_121421", "121421055", "story_v_out_121421.awb")

						arg_224_1:RecordAudio("121421055", var_227_24)
						arg_224_1:RecordAudio("121421055", var_227_24)
					else
						arg_224_1:AudioAction("play", "voice", "story_v_out_121421", "121421055", "story_v_out_121421.awb")
					end

					arg_224_1:RecordHistoryTalkVoice("story_v_out_121421", "121421055", "story_v_out_121421.awb")
				end

				arg_224_1:RecordContent(arg_224_1.text_.text)
			end

			local var_227_25 = math.max(var_227_16, arg_224_1.talkMaxDuration)

			if var_227_15 <= arg_224_1.time_ and arg_224_1.time_ < var_227_15 + var_227_25 then
				arg_224_1.typewritter.percent = (arg_224_1.time_ - var_227_15) / var_227_25

				arg_224_1.typewritter:SetDirty()
			end

			if arg_224_1.time_ >= var_227_15 + var_227_25 and arg_224_1.time_ < var_227_15 + var_227_25 + arg_227_0 then
				arg_224_1.typewritter.percent = 1

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(true)
			end
		end

		arg_224_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_224_1:InitPlayNodeList()
	end,
	Play121421056 = function(arg_228_0, arg_228_1)
		arg_228_1.time_ = 0
		arg_228_1.frameCnt_ = 0
		arg_228_1.state_ = "playing"
		arg_228_1.curTalkId_ = 121421056
		arg_228_1.duration_ = 5

		SetActive(arg_228_1.tipsGo_, false)

		function arg_228_1.onSingleLineFinish_()
			arg_228_1.onSingleLineUpdate_ = nil
			arg_228_1.onSingleLineFinish_ = nil
			arg_228_1.state_ = "waiting"
		end

		function arg_228_1.playNext_(arg_230_0)
			if arg_230_0 == 1 then
				arg_228_0:Play121421057(arg_228_1)
			end
		end

		function arg_228_1.onSingleLineUpdate_(arg_231_0)
			local var_231_0 = arg_228_1.actors_["10042ui_story"]
			local var_231_1 = 0

			if var_231_1 < arg_228_1.time_ and arg_228_1.time_ <= var_231_1 + arg_231_0 and not isNil(var_231_0) and arg_228_1.var_.characterEffect10042ui_story == nil then
				arg_228_1.var_.characterEffect10042ui_story = var_231_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_231_2 = 0.200000002980232

			if var_231_1 <= arg_228_1.time_ and arg_228_1.time_ < var_231_1 + var_231_2 and not isNil(var_231_0) then
				local var_231_3 = (arg_228_1.time_ - var_231_1) / var_231_2

				if arg_228_1.var_.characterEffect10042ui_story and not isNil(var_231_0) then
					local var_231_4 = Mathf.Lerp(0, 0.5, var_231_3)

					arg_228_1.var_.characterEffect10042ui_story.fillFlat = true
					arg_228_1.var_.characterEffect10042ui_story.fillRatio = var_231_4
				end
			end

			if arg_228_1.time_ >= var_231_1 + var_231_2 and arg_228_1.time_ < var_231_1 + var_231_2 + arg_231_0 and not isNil(var_231_0) and arg_228_1.var_.characterEffect10042ui_story then
				local var_231_5 = 0.5

				arg_228_1.var_.characterEffect10042ui_story.fillFlat = true
				arg_228_1.var_.characterEffect10042ui_story.fillRatio = var_231_5
			end

			local var_231_6 = 0
			local var_231_7 = 0.075

			if var_231_6 < arg_228_1.time_ and arg_228_1.time_ <= var_231_6 + arg_231_0 then
				arg_228_1.talkMaxDuration = 0
				arg_228_1.dialogCg_.alpha = 1

				arg_228_1.dialog_:SetActive(true)
				SetActive(arg_228_1.leftNameGo_, true)

				local var_231_8 = arg_228_1:FormatText(StoryNameCfg[7].name)

				arg_228_1.leftNameTxt_.text = var_231_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_228_1.leftNameTxt_.transform)

				arg_228_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_228_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_228_1:RecordName(arg_228_1.leftNameTxt_.text)
				SetActive(arg_228_1.iconTrs_.gameObject, true)
				arg_228_1.iconController_:SetSelectedState("hero")

				arg_228_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_228_1.callingController_:SetSelectedState("normal")

				arg_228_1.keyicon_.color = Color.New(1, 1, 1)
				arg_228_1.icon_.color = Color.New(1, 1, 1)

				local var_231_9 = arg_228_1:GetWordFromCfg(121421056)
				local var_231_10 = arg_228_1:FormatText(var_231_9.content)

				arg_228_1.text_.text = var_231_10

				LuaForUtil.ClearLinePrefixSymbol(arg_228_1.text_)

				local var_231_11 = 3
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
				arg_228_1:RecordContent(arg_228_1.text_.text)
			end

			local var_231_14 = math.max(var_231_7, arg_228_1.talkMaxDuration)

			if var_231_6 <= arg_228_1.time_ and arg_228_1.time_ < var_231_6 + var_231_14 then
				arg_228_1.typewritter.percent = (arg_228_1.time_ - var_231_6) / var_231_14

				arg_228_1.typewritter:SetDirty()
			end

			if arg_228_1.time_ >= var_231_6 + var_231_14 and arg_228_1.time_ < var_231_6 + var_231_14 + arg_231_0 then
				arg_228_1.typewritter.percent = 1

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(true)
			end
		end

		arg_228_1.nodeConfigList_ = {}

		arg_228_1:InitPlayNodeList()
	end,
	Play121421057 = function(arg_232_0, arg_232_1)
		arg_232_1.time_ = 0
		arg_232_1.frameCnt_ = 0
		arg_232_1.state_ = "playing"
		arg_232_1.curTalkId_ = 121421057
		arg_232_1.duration_ = 5

		SetActive(arg_232_1.tipsGo_, false)

		function arg_232_1.onSingleLineFinish_()
			arg_232_1.onSingleLineUpdate_ = nil
			arg_232_1.onSingleLineFinish_ = nil
			arg_232_1.state_ = "waiting"
		end

		function arg_232_1.playNext_(arg_234_0)
			if arg_234_0 == 1 then
				arg_232_0:Play121421058(arg_232_1)
			end
		end

		function arg_232_1.onSingleLineUpdate_(arg_235_0)
			local var_235_0 = 0
			local var_235_1 = 0.95

			if var_235_0 < arg_232_1.time_ and arg_232_1.time_ <= var_235_0 + arg_235_0 then
				arg_232_1.talkMaxDuration = 0
				arg_232_1.dialogCg_.alpha = 1

				arg_232_1.dialog_:SetActive(true)
				SetActive(arg_232_1.leftNameGo_, false)

				arg_232_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_232_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_232_1:RecordName(arg_232_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_232_1.iconTrs_.gameObject, false)
				arg_232_1.callingController_:SetSelectedState("normal")

				local var_235_2 = arg_232_1:GetWordFromCfg(121421057)
				local var_235_3 = arg_232_1:FormatText(var_235_2.content)

				arg_232_1.text_.text = var_235_3

				LuaForUtil.ClearLinePrefixSymbol(arg_232_1.text_)

				local var_235_4 = 38
				local var_235_5 = utf8.len(var_235_3)
				local var_235_6 = var_235_4 <= 0 and var_235_1 or var_235_1 * (var_235_5 / var_235_4)

				if var_235_6 > 0 and var_235_1 < var_235_6 then
					arg_232_1.talkMaxDuration = var_235_6

					if var_235_6 + var_235_0 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_6 + var_235_0
					end
				end

				arg_232_1.text_.text = var_235_3
				arg_232_1.typewritter.percent = 0

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(false)
				arg_232_1:RecordContent(arg_232_1.text_.text)
			end

			local var_235_7 = math.max(var_235_1, arg_232_1.talkMaxDuration)

			if var_235_0 <= arg_232_1.time_ and arg_232_1.time_ < var_235_0 + var_235_7 then
				arg_232_1.typewritter.percent = (arg_232_1.time_ - var_235_0) / var_235_7

				arg_232_1.typewritter:SetDirty()
			end

			if arg_232_1.time_ >= var_235_0 + var_235_7 and arg_232_1.time_ < var_235_0 + var_235_7 + arg_235_0 then
				arg_232_1.typewritter.percent = 1

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(true)
			end
		end

		arg_232_1.nodeConfigList_ = {}

		arg_232_1:InitPlayNodeList()
	end,
	Play121421058 = function(arg_236_0, arg_236_1)
		arg_236_1.time_ = 0
		arg_236_1.frameCnt_ = 0
		arg_236_1.state_ = "playing"
		arg_236_1.curTalkId_ = 121421058
		arg_236_1.duration_ = 14.13

		local var_236_0 = {
			ja = 14.133,
			ko = 6.233,
			zh = 6.233
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
				arg_236_0:Play121421059(arg_236_1)
			end
		end

		function arg_236_1.onSingleLineUpdate_(arg_239_0)
			local var_239_0 = arg_236_1.actors_["10042ui_story"]
			local var_239_1 = 0

			if var_239_1 < arg_236_1.time_ and arg_236_1.time_ <= var_239_1 + arg_239_0 and not isNil(var_239_0) and arg_236_1.var_.characterEffect10042ui_story == nil then
				arg_236_1.var_.characterEffect10042ui_story = var_239_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_239_2 = 0.200000002980232

			if var_239_1 <= arg_236_1.time_ and arg_236_1.time_ < var_239_1 + var_239_2 and not isNil(var_239_0) then
				local var_239_3 = (arg_236_1.time_ - var_239_1) / var_239_2

				if arg_236_1.var_.characterEffect10042ui_story and not isNil(var_239_0) then
					arg_236_1.var_.characterEffect10042ui_story.fillFlat = false
				end
			end

			if arg_236_1.time_ >= var_239_1 + var_239_2 and arg_236_1.time_ < var_239_1 + var_239_2 + arg_239_0 and not isNil(var_239_0) and arg_236_1.var_.characterEffect10042ui_story then
				arg_236_1.var_.characterEffect10042ui_story.fillFlat = false
			end

			local var_239_4 = 0

			if var_239_4 < arg_236_1.time_ and arg_236_1.time_ <= var_239_4 + arg_239_0 then
				arg_236_1:PlayTimeline("10042ui_story", "StoryTimeline/CharAction/story10042/story10042action/10042action1_1")
			end

			local var_239_5 = 0

			if var_239_5 < arg_236_1.time_ and arg_236_1.time_ <= var_239_5 + arg_239_0 then
				arg_236_1:PlayTimeline("10042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_239_6 = 0
			local var_239_7 = 0.575

			if var_239_6 < arg_236_1.time_ and arg_236_1.time_ <= var_239_6 + arg_239_0 then
				arg_236_1.talkMaxDuration = 0
				arg_236_1.dialogCg_.alpha = 1

				arg_236_1.dialog_:SetActive(true)
				SetActive(arg_236_1.leftNameGo_, true)

				local var_239_8 = arg_236_1:FormatText(StoryNameCfg[388].name)

				arg_236_1.leftNameTxt_.text = var_239_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_236_1.leftNameTxt_.transform)

				arg_236_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_236_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_236_1:RecordName(arg_236_1.leftNameTxt_.text)
				SetActive(arg_236_1.iconTrs_.gameObject, false)
				arg_236_1.callingController_:SetSelectedState("normal")

				local var_239_9 = arg_236_1:GetWordFromCfg(121421058)
				local var_239_10 = arg_236_1:FormatText(var_239_9.content)

				arg_236_1.text_.text = var_239_10

				LuaForUtil.ClearLinePrefixSymbol(arg_236_1.text_)

				local var_239_11 = 23
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

				if manager.audio:GetVoiceLength("story_v_out_121421", "121421058", "story_v_out_121421.awb") ~= 0 then
					local var_239_14 = manager.audio:GetVoiceLength("story_v_out_121421", "121421058", "story_v_out_121421.awb") / 1000

					if var_239_14 + var_239_6 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_14 + var_239_6
					end

					if var_239_9.prefab_name ~= "" and arg_236_1.actors_[var_239_9.prefab_name] ~= nil then
						local var_239_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_236_1.actors_[var_239_9.prefab_name].transform, "story_v_out_121421", "121421058", "story_v_out_121421.awb")

						arg_236_1:RecordAudio("121421058", var_239_15)
						arg_236_1:RecordAudio("121421058", var_239_15)
					else
						arg_236_1:AudioAction("play", "voice", "story_v_out_121421", "121421058", "story_v_out_121421.awb")
					end

					arg_236_1:RecordHistoryTalkVoice("story_v_out_121421", "121421058", "story_v_out_121421.awb")
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
	Play121421059 = function(arg_240_0, arg_240_1)
		arg_240_1.time_ = 0
		arg_240_1.frameCnt_ = 0
		arg_240_1.state_ = "playing"
		arg_240_1.curTalkId_ = 121421059
		arg_240_1.duration_ = 5

		SetActive(arg_240_1.tipsGo_, false)

		function arg_240_1.onSingleLineFinish_()
			arg_240_1.onSingleLineUpdate_ = nil
			arg_240_1.onSingleLineFinish_ = nil
			arg_240_1.state_ = "waiting"
		end

		function arg_240_1.playNext_(arg_242_0)
			if arg_242_0 == 1 then
				arg_240_0:Play121421060(arg_240_1)
			end
		end

		function arg_240_1.onSingleLineUpdate_(arg_243_0)
			local var_243_0 = arg_240_1.actors_["10042ui_story"]
			local var_243_1 = 0

			if var_243_1 < arg_240_1.time_ and arg_240_1.time_ <= var_243_1 + arg_243_0 and not isNil(var_243_0) and arg_240_1.var_.characterEffect10042ui_story == nil then
				arg_240_1.var_.characterEffect10042ui_story = var_243_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_243_2 = 0.200000002980232

			if var_243_1 <= arg_240_1.time_ and arg_240_1.time_ < var_243_1 + var_243_2 and not isNil(var_243_0) then
				local var_243_3 = (arg_240_1.time_ - var_243_1) / var_243_2

				if arg_240_1.var_.characterEffect10042ui_story and not isNil(var_243_0) then
					local var_243_4 = Mathf.Lerp(0, 0.5, var_243_3)

					arg_240_1.var_.characterEffect10042ui_story.fillFlat = true
					arg_240_1.var_.characterEffect10042ui_story.fillRatio = var_243_4
				end
			end

			if arg_240_1.time_ >= var_243_1 + var_243_2 and arg_240_1.time_ < var_243_1 + var_243_2 + arg_243_0 and not isNil(var_243_0) and arg_240_1.var_.characterEffect10042ui_story then
				local var_243_5 = 0.5

				arg_240_1.var_.characterEffect10042ui_story.fillFlat = true
				arg_240_1.var_.characterEffect10042ui_story.fillRatio = var_243_5
			end

			local var_243_6 = 0
			local var_243_7 = 0.8

			if var_243_6 < arg_240_1.time_ and arg_240_1.time_ <= var_243_6 + arg_243_0 then
				arg_240_1.talkMaxDuration = 0
				arg_240_1.dialogCg_.alpha = 1

				arg_240_1.dialog_:SetActive(true)
				SetActive(arg_240_1.leftNameGo_, false)

				arg_240_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_240_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_240_1:RecordName(arg_240_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_240_1.iconTrs_.gameObject, false)
				arg_240_1.callingController_:SetSelectedState("normal")

				local var_243_8 = arg_240_1:GetWordFromCfg(121421059)
				local var_243_9 = arg_240_1:FormatText(var_243_8.content)

				arg_240_1.text_.text = var_243_9

				LuaForUtil.ClearLinePrefixSymbol(arg_240_1.text_)

				local var_243_10 = 32
				local var_243_11 = utf8.len(var_243_9)
				local var_243_12 = var_243_10 <= 0 and var_243_7 or var_243_7 * (var_243_11 / var_243_10)

				if var_243_12 > 0 and var_243_7 < var_243_12 then
					arg_240_1.talkMaxDuration = var_243_12

					if var_243_12 + var_243_6 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_12 + var_243_6
					end
				end

				arg_240_1.text_.text = var_243_9
				arg_240_1.typewritter.percent = 0

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(false)
				arg_240_1:RecordContent(arg_240_1.text_.text)
			end

			local var_243_13 = math.max(var_243_7, arg_240_1.talkMaxDuration)

			if var_243_6 <= arg_240_1.time_ and arg_240_1.time_ < var_243_6 + var_243_13 then
				arg_240_1.typewritter.percent = (arg_240_1.time_ - var_243_6) / var_243_13

				arg_240_1.typewritter:SetDirty()
			end

			if arg_240_1.time_ >= var_243_6 + var_243_13 and arg_240_1.time_ < var_243_6 + var_243_13 + arg_243_0 then
				arg_240_1.typewritter.percent = 1

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(true)
			end
		end

		arg_240_1.nodeConfigList_ = {}

		arg_240_1:InitPlayNodeList()
	end,
	Play121421060 = function(arg_244_0, arg_244_1)
		arg_244_1.time_ = 0
		arg_244_1.frameCnt_ = 0
		arg_244_1.state_ = "playing"
		arg_244_1.curTalkId_ = 121421060
		arg_244_1.duration_ = 5

		SetActive(arg_244_1.tipsGo_, false)

		function arg_244_1.onSingleLineFinish_()
			arg_244_1.onSingleLineUpdate_ = nil
			arg_244_1.onSingleLineFinish_ = nil
			arg_244_1.state_ = "waiting"
		end

		function arg_244_1.playNext_(arg_246_0)
			if arg_246_0 == 1 then
				arg_244_0:Play121421061(arg_244_1)
			end
		end

		function arg_244_1.onSingleLineUpdate_(arg_247_0)
			local var_247_0 = 0
			local var_247_1 = 1.2

			if var_247_0 < arg_244_1.time_ and arg_244_1.time_ <= var_247_0 + arg_247_0 then
				arg_244_1.talkMaxDuration = 0
				arg_244_1.dialogCg_.alpha = 1

				arg_244_1.dialog_:SetActive(true)
				SetActive(arg_244_1.leftNameGo_, false)

				arg_244_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_244_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_244_1:RecordName(arg_244_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_244_1.iconTrs_.gameObject, false)
				arg_244_1.callingController_:SetSelectedState("normal")

				local var_247_2 = arg_244_1:GetWordFromCfg(121421060)
				local var_247_3 = arg_244_1:FormatText(var_247_2.content)

				arg_244_1.text_.text = var_247_3

				LuaForUtil.ClearLinePrefixSymbol(arg_244_1.text_)

				local var_247_4 = 48
				local var_247_5 = utf8.len(var_247_3)
				local var_247_6 = var_247_4 <= 0 and var_247_1 or var_247_1 * (var_247_5 / var_247_4)

				if var_247_6 > 0 and var_247_1 < var_247_6 then
					arg_244_1.talkMaxDuration = var_247_6

					if var_247_6 + var_247_0 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_6 + var_247_0
					end
				end

				arg_244_1.text_.text = var_247_3
				arg_244_1.typewritter.percent = 0

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(false)
				arg_244_1:RecordContent(arg_244_1.text_.text)
			end

			local var_247_7 = math.max(var_247_1, arg_244_1.talkMaxDuration)

			if var_247_0 <= arg_244_1.time_ and arg_244_1.time_ < var_247_0 + var_247_7 then
				arg_244_1.typewritter.percent = (arg_244_1.time_ - var_247_0) / var_247_7

				arg_244_1.typewritter:SetDirty()
			end

			if arg_244_1.time_ >= var_247_0 + var_247_7 and arg_244_1.time_ < var_247_0 + var_247_7 + arg_247_0 then
				arg_244_1.typewritter.percent = 1

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(true)
			end
		end

		arg_244_1.nodeConfigList_ = {}

		arg_244_1:InitPlayNodeList()
	end,
	Play121421061 = function(arg_248_0, arg_248_1)
		arg_248_1.time_ = 0
		arg_248_1.frameCnt_ = 0
		arg_248_1.state_ = "playing"
		arg_248_1.curTalkId_ = 121421061
		arg_248_1.duration_ = 5

		SetActive(arg_248_1.tipsGo_, false)

		function arg_248_1.onSingleLineFinish_()
			arg_248_1.onSingleLineUpdate_ = nil
			arg_248_1.onSingleLineFinish_ = nil
			arg_248_1.state_ = "waiting"
		end

		function arg_248_1.playNext_(arg_250_0)
			if arg_250_0 == 1 then
				arg_248_0:Play121421062(arg_248_1)
			end
		end

		function arg_248_1.onSingleLineUpdate_(arg_251_0)
			local var_251_0 = 0
			local var_251_1 = 0.225

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

				local var_251_3 = arg_248_1:GetWordFromCfg(121421061)
				local var_251_4 = arg_248_1:FormatText(var_251_3.content)

				arg_248_1.text_.text = var_251_4

				LuaForUtil.ClearLinePrefixSymbol(arg_248_1.text_)

				local var_251_5 = 9
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
	Play121421062 = function(arg_252_0, arg_252_1)
		arg_252_1.time_ = 0
		arg_252_1.frameCnt_ = 0
		arg_252_1.state_ = "playing"
		arg_252_1.curTalkId_ = 121421062
		arg_252_1.duration_ = 7.4

		local var_252_0 = {
			ja = 6.9,
			ko = 7.4,
			zh = 7.4
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
				arg_252_0:Play121421063(arg_252_1)
			end
		end

		function arg_252_1.onSingleLineUpdate_(arg_255_0)
			local var_255_0 = arg_252_1.actors_["10042ui_story"]
			local var_255_1 = 0

			if var_255_1 < arg_252_1.time_ and arg_252_1.time_ <= var_255_1 + arg_255_0 and not isNil(var_255_0) and arg_252_1.var_.characterEffect10042ui_story == nil then
				arg_252_1.var_.characterEffect10042ui_story = var_255_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_255_2 = 0.200000002980232

			if var_255_1 <= arg_252_1.time_ and arg_252_1.time_ < var_255_1 + var_255_2 and not isNil(var_255_0) then
				local var_255_3 = (arg_252_1.time_ - var_255_1) / var_255_2

				if arg_252_1.var_.characterEffect10042ui_story and not isNil(var_255_0) then
					arg_252_1.var_.characterEffect10042ui_story.fillFlat = false
				end
			end

			if arg_252_1.time_ >= var_255_1 + var_255_2 and arg_252_1.time_ < var_255_1 + var_255_2 + arg_255_0 and not isNil(var_255_0) and arg_252_1.var_.characterEffect10042ui_story then
				arg_252_1.var_.characterEffect10042ui_story.fillFlat = false
			end

			local var_255_4 = 0
			local var_255_5 = 0.6

			if var_255_4 < arg_252_1.time_ and arg_252_1.time_ <= var_255_4 + arg_255_0 then
				arg_252_1.talkMaxDuration = 0
				arg_252_1.dialogCg_.alpha = 1

				arg_252_1.dialog_:SetActive(true)
				SetActive(arg_252_1.leftNameGo_, true)

				local var_255_6 = arg_252_1:FormatText(StoryNameCfg[388].name)

				arg_252_1.leftNameTxt_.text = var_255_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_252_1.leftNameTxt_.transform)

				arg_252_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_252_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_252_1:RecordName(arg_252_1.leftNameTxt_.text)
				SetActive(arg_252_1.iconTrs_.gameObject, false)
				arg_252_1.callingController_:SetSelectedState("normal")

				local var_255_7 = arg_252_1:GetWordFromCfg(121421062)
				local var_255_8 = arg_252_1:FormatText(var_255_7.content)

				arg_252_1.text_.text = var_255_8

				LuaForUtil.ClearLinePrefixSymbol(arg_252_1.text_)

				local var_255_9 = 24
				local var_255_10 = utf8.len(var_255_8)
				local var_255_11 = var_255_9 <= 0 and var_255_5 or var_255_5 * (var_255_10 / var_255_9)

				if var_255_11 > 0 and var_255_5 < var_255_11 then
					arg_252_1.talkMaxDuration = var_255_11

					if var_255_11 + var_255_4 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_11 + var_255_4
					end
				end

				arg_252_1.text_.text = var_255_8
				arg_252_1.typewritter.percent = 0

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121421", "121421062", "story_v_out_121421.awb") ~= 0 then
					local var_255_12 = manager.audio:GetVoiceLength("story_v_out_121421", "121421062", "story_v_out_121421.awb") / 1000

					if var_255_12 + var_255_4 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_12 + var_255_4
					end

					if var_255_7.prefab_name ~= "" and arg_252_1.actors_[var_255_7.prefab_name] ~= nil then
						local var_255_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_252_1.actors_[var_255_7.prefab_name].transform, "story_v_out_121421", "121421062", "story_v_out_121421.awb")

						arg_252_1:RecordAudio("121421062", var_255_13)
						arg_252_1:RecordAudio("121421062", var_255_13)
					else
						arg_252_1:AudioAction("play", "voice", "story_v_out_121421", "121421062", "story_v_out_121421.awb")
					end

					arg_252_1:RecordHistoryTalkVoice("story_v_out_121421", "121421062", "story_v_out_121421.awb")
				end

				arg_252_1:RecordContent(arg_252_1.text_.text)
			end

			local var_255_14 = math.max(var_255_5, arg_252_1.talkMaxDuration)

			if var_255_4 <= arg_252_1.time_ and arg_252_1.time_ < var_255_4 + var_255_14 then
				arg_252_1.typewritter.percent = (arg_252_1.time_ - var_255_4) / var_255_14

				arg_252_1.typewritter:SetDirty()
			end

			if arg_252_1.time_ >= var_255_4 + var_255_14 and arg_252_1.time_ < var_255_4 + var_255_14 + arg_255_0 then
				arg_252_1.typewritter.percent = 1

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(true)
			end
		end

		arg_252_1.nodeConfigList_ = {}

		arg_252_1:InitPlayNodeList()
	end,
	Play121421063 = function(arg_256_0, arg_256_1)
		arg_256_1.time_ = 0
		arg_256_1.frameCnt_ = 0
		arg_256_1.state_ = "playing"
		arg_256_1.curTalkId_ = 121421063
		arg_256_1.duration_ = 9.87

		local var_256_0 = {
			ja = 9.7,
			ko = 9.866,
			zh = 9.866
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
				arg_256_0:Play121421064(arg_256_1)
			end
		end

		function arg_256_1.onSingleLineUpdate_(arg_259_0)
			local var_259_0 = 0
			local var_259_1 = 1.175

			if var_259_0 < arg_256_1.time_ and arg_256_1.time_ <= var_259_0 + arg_259_0 then
				arg_256_1.talkMaxDuration = 0
				arg_256_1.dialogCg_.alpha = 1

				arg_256_1.dialog_:SetActive(true)
				SetActive(arg_256_1.leftNameGo_, true)

				local var_259_2 = arg_256_1:FormatText(StoryNameCfg[388].name)

				arg_256_1.leftNameTxt_.text = var_259_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_256_1.leftNameTxt_.transform)

				arg_256_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_256_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_256_1:RecordName(arg_256_1.leftNameTxt_.text)
				SetActive(arg_256_1.iconTrs_.gameObject, false)
				arg_256_1.callingController_:SetSelectedState("normal")

				local var_259_3 = arg_256_1:GetWordFromCfg(121421063)
				local var_259_4 = arg_256_1:FormatText(var_259_3.content)

				arg_256_1.text_.text = var_259_4

				LuaForUtil.ClearLinePrefixSymbol(arg_256_1.text_)

				local var_259_5 = 47
				local var_259_6 = utf8.len(var_259_4)
				local var_259_7 = var_259_5 <= 0 and var_259_1 or var_259_1 * (var_259_6 / var_259_5)

				if var_259_7 > 0 and var_259_1 < var_259_7 then
					arg_256_1.talkMaxDuration = var_259_7

					if var_259_7 + var_259_0 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_7 + var_259_0
					end
				end

				arg_256_1.text_.text = var_259_4
				arg_256_1.typewritter.percent = 0

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121421", "121421063", "story_v_out_121421.awb") ~= 0 then
					local var_259_8 = manager.audio:GetVoiceLength("story_v_out_121421", "121421063", "story_v_out_121421.awb") / 1000

					if var_259_8 + var_259_0 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_8 + var_259_0
					end

					if var_259_3.prefab_name ~= "" and arg_256_1.actors_[var_259_3.prefab_name] ~= nil then
						local var_259_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_256_1.actors_[var_259_3.prefab_name].transform, "story_v_out_121421", "121421063", "story_v_out_121421.awb")

						arg_256_1:RecordAudio("121421063", var_259_9)
						arg_256_1:RecordAudio("121421063", var_259_9)
					else
						arg_256_1:AudioAction("play", "voice", "story_v_out_121421", "121421063", "story_v_out_121421.awb")
					end

					arg_256_1:RecordHistoryTalkVoice("story_v_out_121421", "121421063", "story_v_out_121421.awb")
				end

				arg_256_1:RecordContent(arg_256_1.text_.text)
			end

			local var_259_10 = math.max(var_259_1, arg_256_1.talkMaxDuration)

			if var_259_0 <= arg_256_1.time_ and arg_256_1.time_ < var_259_0 + var_259_10 then
				arg_256_1.typewritter.percent = (arg_256_1.time_ - var_259_0) / var_259_10

				arg_256_1.typewritter:SetDirty()
			end

			if arg_256_1.time_ >= var_259_0 + var_259_10 and arg_256_1.time_ < var_259_0 + var_259_10 + arg_259_0 then
				arg_256_1.typewritter.percent = 1

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(true)
			end
		end

		arg_256_1.nodeConfigList_ = {}

		arg_256_1:InitPlayNodeList()
	end,
	Play121421064 = function(arg_260_0, arg_260_1)
		arg_260_1.time_ = 0
		arg_260_1.frameCnt_ = 0
		arg_260_1.state_ = "playing"
		arg_260_1.curTalkId_ = 121421064
		arg_260_1.duration_ = 7.03

		local var_260_0 = {
			ja = 7.033,
			ko = 3.7,
			zh = 3.7
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
				arg_260_0:Play121421065(arg_260_1)
			end
		end

		function arg_260_1.onSingleLineUpdate_(arg_263_0)
			local var_263_0 = arg_260_1.actors_["1084ui_story"].transform
			local var_263_1 = 0

			if var_263_1 < arg_260_1.time_ and arg_260_1.time_ <= var_263_1 + arg_263_0 then
				arg_260_1.var_.moveOldPos1084ui_story = var_263_0.localPosition
			end

			local var_263_2 = 0.001

			if var_263_1 <= arg_260_1.time_ and arg_260_1.time_ < var_263_1 + var_263_2 then
				local var_263_3 = (arg_260_1.time_ - var_263_1) / var_263_2
				local var_263_4 = Vector3.New(0.7, -0.97, -6)

				var_263_0.localPosition = Vector3.Lerp(arg_260_1.var_.moveOldPos1084ui_story, var_263_4, var_263_3)

				local var_263_5 = manager.ui.mainCamera.transform.position - var_263_0.position

				var_263_0.forward = Vector3.New(var_263_5.x, var_263_5.y, var_263_5.z)

				local var_263_6 = var_263_0.localEulerAngles

				var_263_6.z = 0
				var_263_6.x = 0
				var_263_0.localEulerAngles = var_263_6
			end

			if arg_260_1.time_ >= var_263_1 + var_263_2 and arg_260_1.time_ < var_263_1 + var_263_2 + arg_263_0 then
				var_263_0.localPosition = Vector3.New(0.7, -0.97, -6)

				local var_263_7 = manager.ui.mainCamera.transform.position - var_263_0.position

				var_263_0.forward = Vector3.New(var_263_7.x, var_263_7.y, var_263_7.z)

				local var_263_8 = var_263_0.localEulerAngles

				var_263_8.z = 0
				var_263_8.x = 0
				var_263_0.localEulerAngles = var_263_8
			end

			local var_263_9 = arg_260_1.actors_["1084ui_story"]
			local var_263_10 = 0

			if var_263_10 < arg_260_1.time_ and arg_260_1.time_ <= var_263_10 + arg_263_0 and not isNil(var_263_9) and arg_260_1.var_.characterEffect1084ui_story == nil then
				arg_260_1.var_.characterEffect1084ui_story = var_263_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_263_11 = 0.200000002980232

			if var_263_10 <= arg_260_1.time_ and arg_260_1.time_ < var_263_10 + var_263_11 and not isNil(var_263_9) then
				local var_263_12 = (arg_260_1.time_ - var_263_10) / var_263_11

				if arg_260_1.var_.characterEffect1084ui_story and not isNil(var_263_9) then
					arg_260_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_260_1.time_ >= var_263_10 + var_263_11 and arg_260_1.time_ < var_263_10 + var_263_11 + arg_263_0 and not isNil(var_263_9) and arg_260_1.var_.characterEffect1084ui_story then
				arg_260_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_263_13 = 0

			if var_263_13 < arg_260_1.time_ and arg_260_1.time_ <= var_263_13 + arg_263_0 then
				arg_260_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			local var_263_14 = 0

			if var_263_14 < arg_260_1.time_ and arg_260_1.time_ <= var_263_14 + arg_263_0 then
				arg_260_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_263_15 = arg_260_1.actors_["10042ui_story"]
			local var_263_16 = 0

			if var_263_16 < arg_260_1.time_ and arg_260_1.time_ <= var_263_16 + arg_263_0 and not isNil(var_263_15) and arg_260_1.var_.characterEffect10042ui_story == nil then
				arg_260_1.var_.characterEffect10042ui_story = var_263_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_263_17 = 0.200000002980232

			if var_263_16 <= arg_260_1.time_ and arg_260_1.time_ < var_263_16 + var_263_17 and not isNil(var_263_15) then
				local var_263_18 = (arg_260_1.time_ - var_263_16) / var_263_17

				if arg_260_1.var_.characterEffect10042ui_story and not isNil(var_263_15) then
					local var_263_19 = Mathf.Lerp(0, 0.5, var_263_18)

					arg_260_1.var_.characterEffect10042ui_story.fillFlat = true
					arg_260_1.var_.characterEffect10042ui_story.fillRatio = var_263_19
				end
			end

			if arg_260_1.time_ >= var_263_16 + var_263_17 and arg_260_1.time_ < var_263_16 + var_263_17 + arg_263_0 and not isNil(var_263_15) and arg_260_1.var_.characterEffect10042ui_story then
				local var_263_20 = 0.5

				arg_260_1.var_.characterEffect10042ui_story.fillFlat = true
				arg_260_1.var_.characterEffect10042ui_story.fillRatio = var_263_20
			end

			local var_263_21 = arg_260_1.actors_["10042ui_story"].transform
			local var_263_22 = 0

			if var_263_22 < arg_260_1.time_ and arg_260_1.time_ <= var_263_22 + arg_263_0 then
				arg_260_1.var_.moveOldPos10042ui_story = var_263_21.localPosition
			end

			local var_263_23 = 0.001

			if var_263_22 <= arg_260_1.time_ and arg_260_1.time_ < var_263_22 + var_263_23 then
				local var_263_24 = (arg_260_1.time_ - var_263_22) / var_263_23
				local var_263_25 = Vector3.New(-0.7, -1.12, -6.2)

				var_263_21.localPosition = Vector3.Lerp(arg_260_1.var_.moveOldPos10042ui_story, var_263_25, var_263_24)

				local var_263_26 = manager.ui.mainCamera.transform.position - var_263_21.position

				var_263_21.forward = Vector3.New(var_263_26.x, var_263_26.y, var_263_26.z)

				local var_263_27 = var_263_21.localEulerAngles

				var_263_27.z = 0
				var_263_27.x = 0
				var_263_21.localEulerAngles = var_263_27
			end

			if arg_260_1.time_ >= var_263_22 + var_263_23 and arg_260_1.time_ < var_263_22 + var_263_23 + arg_263_0 then
				var_263_21.localPosition = Vector3.New(-0.7, -1.12, -6.2)

				local var_263_28 = manager.ui.mainCamera.transform.position - var_263_21.position

				var_263_21.forward = Vector3.New(var_263_28.x, var_263_28.y, var_263_28.z)

				local var_263_29 = var_263_21.localEulerAngles

				var_263_29.z = 0
				var_263_29.x = 0
				var_263_21.localEulerAngles = var_263_29
			end

			local var_263_30 = 0
			local var_263_31 = 0.475

			if var_263_30 < arg_260_1.time_ and arg_260_1.time_ <= var_263_30 + arg_263_0 then
				arg_260_1.talkMaxDuration = 0
				arg_260_1.dialogCg_.alpha = 1

				arg_260_1.dialog_:SetActive(true)
				SetActive(arg_260_1.leftNameGo_, true)

				local var_263_32 = arg_260_1:FormatText(StoryNameCfg[6].name)

				arg_260_1.leftNameTxt_.text = var_263_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_260_1.leftNameTxt_.transform)

				arg_260_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_260_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_260_1:RecordName(arg_260_1.leftNameTxt_.text)
				SetActive(arg_260_1.iconTrs_.gameObject, false)
				arg_260_1.callingController_:SetSelectedState("normal")

				local var_263_33 = arg_260_1:GetWordFromCfg(121421064)
				local var_263_34 = arg_260_1:FormatText(var_263_33.content)

				arg_260_1.text_.text = var_263_34

				LuaForUtil.ClearLinePrefixSymbol(arg_260_1.text_)

				local var_263_35 = 19
				local var_263_36 = utf8.len(var_263_34)
				local var_263_37 = var_263_35 <= 0 and var_263_31 or var_263_31 * (var_263_36 / var_263_35)

				if var_263_37 > 0 and var_263_31 < var_263_37 then
					arg_260_1.talkMaxDuration = var_263_37

					if var_263_37 + var_263_30 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_37 + var_263_30
					end
				end

				arg_260_1.text_.text = var_263_34
				arg_260_1.typewritter.percent = 0

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121421", "121421064", "story_v_out_121421.awb") ~= 0 then
					local var_263_38 = manager.audio:GetVoiceLength("story_v_out_121421", "121421064", "story_v_out_121421.awb") / 1000

					if var_263_38 + var_263_30 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_38 + var_263_30
					end

					if var_263_33.prefab_name ~= "" and arg_260_1.actors_[var_263_33.prefab_name] ~= nil then
						local var_263_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_260_1.actors_[var_263_33.prefab_name].transform, "story_v_out_121421", "121421064", "story_v_out_121421.awb")

						arg_260_1:RecordAudio("121421064", var_263_39)
						arg_260_1:RecordAudio("121421064", var_263_39)
					else
						arg_260_1:AudioAction("play", "voice", "story_v_out_121421", "121421064", "story_v_out_121421.awb")
					end

					arg_260_1:RecordHistoryTalkVoice("story_v_out_121421", "121421064", "story_v_out_121421.awb")
				end

				arg_260_1:RecordContent(arg_260_1.text_.text)
			end

			local var_263_40 = math.max(var_263_31, arg_260_1.talkMaxDuration)

			if var_263_30 <= arg_260_1.time_ and arg_260_1.time_ < var_263_30 + var_263_40 then
				arg_260_1.typewritter.percent = (arg_260_1.time_ - var_263_30) / var_263_40

				arg_260_1.typewritter:SetDirty()
			end

			if arg_260_1.time_ >= var_263_30 + var_263_40 and arg_260_1.time_ < var_263_30 + var_263_40 + arg_263_0 then
				arg_260_1.typewritter.percent = 1

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(true)
			end
		end

		arg_260_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_260_1:InitPlayNodeList()
	end,
	Play121421065 = function(arg_264_0, arg_264_1)
		arg_264_1.time_ = 0
		arg_264_1.frameCnt_ = 0
		arg_264_1.state_ = "playing"
		arg_264_1.curTalkId_ = 121421065
		arg_264_1.duration_ = 12.13

		local var_264_0 = {
			ja = 12.133,
			ko = 7.833,
			zh = 7.833
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
				arg_264_0:Play121421066(arg_264_1)
			end
		end

		function arg_264_1.onSingleLineUpdate_(arg_267_0)
			local var_267_0 = arg_264_1.actors_["10042ui_story"]
			local var_267_1 = 0

			if var_267_1 < arg_264_1.time_ and arg_264_1.time_ <= var_267_1 + arg_267_0 and not isNil(var_267_0) and arg_264_1.var_.characterEffect10042ui_story == nil then
				arg_264_1.var_.characterEffect10042ui_story = var_267_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_267_2 = 0.200000002980232

			if var_267_1 <= arg_264_1.time_ and arg_264_1.time_ < var_267_1 + var_267_2 and not isNil(var_267_0) then
				local var_267_3 = (arg_264_1.time_ - var_267_1) / var_267_2

				if arg_264_1.var_.characterEffect10042ui_story and not isNil(var_267_0) then
					arg_264_1.var_.characterEffect10042ui_story.fillFlat = false
				end
			end

			if arg_264_1.time_ >= var_267_1 + var_267_2 and arg_264_1.time_ < var_267_1 + var_267_2 + arg_267_0 and not isNil(var_267_0) and arg_264_1.var_.characterEffect10042ui_story then
				arg_264_1.var_.characterEffect10042ui_story.fillFlat = false
			end

			local var_267_4 = 0

			if var_267_4 < arg_264_1.time_ and arg_264_1.time_ <= var_267_4 + arg_267_0 then
				arg_264_1:PlayTimeline("10042ui_story", "StoryTimeline/CharAction/story10042/story10042action/10042action3_1")
			end

			local var_267_5 = 0

			if var_267_5 < arg_264_1.time_ and arg_264_1.time_ <= var_267_5 + arg_267_0 then
				arg_264_1:PlayTimeline("10042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_267_6 = arg_264_1.actors_["1084ui_story"]
			local var_267_7 = 0

			if var_267_7 < arg_264_1.time_ and arg_264_1.time_ <= var_267_7 + arg_267_0 and not isNil(var_267_6) and arg_264_1.var_.characterEffect1084ui_story == nil then
				arg_264_1.var_.characterEffect1084ui_story = var_267_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_267_8 = 0.200000002980232

			if var_267_7 <= arg_264_1.time_ and arg_264_1.time_ < var_267_7 + var_267_8 and not isNil(var_267_6) then
				local var_267_9 = (arg_264_1.time_ - var_267_7) / var_267_8

				if arg_264_1.var_.characterEffect1084ui_story and not isNil(var_267_6) then
					local var_267_10 = Mathf.Lerp(0, 0.5, var_267_9)

					arg_264_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_264_1.var_.characterEffect1084ui_story.fillRatio = var_267_10
				end
			end

			if arg_264_1.time_ >= var_267_7 + var_267_8 and arg_264_1.time_ < var_267_7 + var_267_8 + arg_267_0 and not isNil(var_267_6) and arg_264_1.var_.characterEffect1084ui_story then
				local var_267_11 = 0.5

				arg_264_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_264_1.var_.characterEffect1084ui_story.fillRatio = var_267_11
			end

			local var_267_12 = 0
			local var_267_13 = 1.05

			if var_267_12 < arg_264_1.time_ and arg_264_1.time_ <= var_267_12 + arg_267_0 then
				arg_264_1.talkMaxDuration = 0
				arg_264_1.dialogCg_.alpha = 1

				arg_264_1.dialog_:SetActive(true)
				SetActive(arg_264_1.leftNameGo_, true)

				local var_267_14 = arg_264_1:FormatText(StoryNameCfg[388].name)

				arg_264_1.leftNameTxt_.text = var_267_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_264_1.leftNameTxt_.transform)

				arg_264_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_264_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_264_1:RecordName(arg_264_1.leftNameTxt_.text)
				SetActive(arg_264_1.iconTrs_.gameObject, false)
				arg_264_1.callingController_:SetSelectedState("normal")

				local var_267_15 = arg_264_1:GetWordFromCfg(121421065)
				local var_267_16 = arg_264_1:FormatText(var_267_15.content)

				arg_264_1.text_.text = var_267_16

				LuaForUtil.ClearLinePrefixSymbol(arg_264_1.text_)

				local var_267_17 = 42
				local var_267_18 = utf8.len(var_267_16)
				local var_267_19 = var_267_17 <= 0 and var_267_13 or var_267_13 * (var_267_18 / var_267_17)

				if var_267_19 > 0 and var_267_13 < var_267_19 then
					arg_264_1.talkMaxDuration = var_267_19

					if var_267_19 + var_267_12 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_19 + var_267_12
					end
				end

				arg_264_1.text_.text = var_267_16
				arg_264_1.typewritter.percent = 0

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121421", "121421065", "story_v_out_121421.awb") ~= 0 then
					local var_267_20 = manager.audio:GetVoiceLength("story_v_out_121421", "121421065", "story_v_out_121421.awb") / 1000

					if var_267_20 + var_267_12 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_20 + var_267_12
					end

					if var_267_15.prefab_name ~= "" and arg_264_1.actors_[var_267_15.prefab_name] ~= nil then
						local var_267_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_264_1.actors_[var_267_15.prefab_name].transform, "story_v_out_121421", "121421065", "story_v_out_121421.awb")

						arg_264_1:RecordAudio("121421065", var_267_21)
						arg_264_1:RecordAudio("121421065", var_267_21)
					else
						arg_264_1:AudioAction("play", "voice", "story_v_out_121421", "121421065", "story_v_out_121421.awb")
					end

					arg_264_1:RecordHistoryTalkVoice("story_v_out_121421", "121421065", "story_v_out_121421.awb")
				end

				arg_264_1:RecordContent(arg_264_1.text_.text)
			end

			local var_267_22 = math.max(var_267_13, arg_264_1.talkMaxDuration)

			if var_267_12 <= arg_264_1.time_ and arg_264_1.time_ < var_267_12 + var_267_22 then
				arg_264_1.typewritter.percent = (arg_264_1.time_ - var_267_12) / var_267_22

				arg_264_1.typewritter:SetDirty()
			end

			if arg_264_1.time_ >= var_267_12 + var_267_22 and arg_264_1.time_ < var_267_12 + var_267_22 + arg_267_0 then
				arg_264_1.typewritter.percent = 1

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(true)
			end
		end

		arg_264_1.nodeConfigList_ = {}

		arg_264_1:InitPlayNodeList()
	end,
	Play121421066 = function(arg_268_0, arg_268_1)
		arg_268_1.time_ = 0
		arg_268_1.frameCnt_ = 0
		arg_268_1.state_ = "playing"
		arg_268_1.curTalkId_ = 121421066
		arg_268_1.duration_ = 16.83

		local var_268_0 = {
			ja = 16.833,
			ko = 10.6,
			zh = 10.6
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
				arg_268_0:Play121421067(arg_268_1)
			end
		end

		function arg_268_1.onSingleLineUpdate_(arg_271_0)
			local var_271_0 = 0
			local var_271_1 = 1.075

			if var_271_0 < arg_268_1.time_ and arg_268_1.time_ <= var_271_0 + arg_271_0 then
				arg_268_1.talkMaxDuration = 0
				arg_268_1.dialogCg_.alpha = 1

				arg_268_1.dialog_:SetActive(true)
				SetActive(arg_268_1.leftNameGo_, true)

				local var_271_2 = arg_268_1:FormatText(StoryNameCfg[388].name)

				arg_268_1.leftNameTxt_.text = var_271_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_268_1.leftNameTxt_.transform)

				arg_268_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_268_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_268_1:RecordName(arg_268_1.leftNameTxt_.text)
				SetActive(arg_268_1.iconTrs_.gameObject, false)
				arg_268_1.callingController_:SetSelectedState("normal")

				local var_271_3 = arg_268_1:GetWordFromCfg(121421066)
				local var_271_4 = arg_268_1:FormatText(var_271_3.content)

				arg_268_1.text_.text = var_271_4

				LuaForUtil.ClearLinePrefixSymbol(arg_268_1.text_)

				local var_271_5 = 43
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

				if manager.audio:GetVoiceLength("story_v_out_121421", "121421066", "story_v_out_121421.awb") ~= 0 then
					local var_271_8 = manager.audio:GetVoiceLength("story_v_out_121421", "121421066", "story_v_out_121421.awb") / 1000

					if var_271_8 + var_271_0 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_8 + var_271_0
					end

					if var_271_3.prefab_name ~= "" and arg_268_1.actors_[var_271_3.prefab_name] ~= nil then
						local var_271_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_268_1.actors_[var_271_3.prefab_name].transform, "story_v_out_121421", "121421066", "story_v_out_121421.awb")

						arg_268_1:RecordAudio("121421066", var_271_9)
						arg_268_1:RecordAudio("121421066", var_271_9)
					else
						arg_268_1:AudioAction("play", "voice", "story_v_out_121421", "121421066", "story_v_out_121421.awb")
					end

					arg_268_1:RecordHistoryTalkVoice("story_v_out_121421", "121421066", "story_v_out_121421.awb")
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
	Play121421067 = function(arg_272_0, arg_272_1)
		arg_272_1.time_ = 0
		arg_272_1.frameCnt_ = 0
		arg_272_1.state_ = "playing"
		arg_272_1.curTalkId_ = 121421067
		arg_272_1.duration_ = 12.3

		local var_272_0 = {
			ja = 12.3,
			ko = 6,
			zh = 6
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
				arg_272_0:Play121421068(arg_272_1)
			end
		end

		function arg_272_1.onSingleLineUpdate_(arg_275_0)
			local var_275_0 = arg_272_1.actors_["1084ui_story"]
			local var_275_1 = 0

			if var_275_1 < arg_272_1.time_ and arg_272_1.time_ <= var_275_1 + arg_275_0 and not isNil(var_275_0) and arg_272_1.var_.characterEffect1084ui_story == nil then
				arg_272_1.var_.characterEffect1084ui_story = var_275_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_275_2 = 0.200000002980232

			if var_275_1 <= arg_272_1.time_ and arg_272_1.time_ < var_275_1 + var_275_2 and not isNil(var_275_0) then
				local var_275_3 = (arg_272_1.time_ - var_275_1) / var_275_2

				if arg_272_1.var_.characterEffect1084ui_story and not isNil(var_275_0) then
					arg_272_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_272_1.time_ >= var_275_1 + var_275_2 and arg_272_1.time_ < var_275_1 + var_275_2 + arg_275_0 and not isNil(var_275_0) and arg_272_1.var_.characterEffect1084ui_story then
				arg_272_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_275_4 = 0

			if var_275_4 < arg_272_1.time_ and arg_272_1.time_ <= var_275_4 + arg_275_0 then
				arg_272_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action41312")
			end

			local var_275_5 = 0

			if var_275_5 < arg_272_1.time_ and arg_272_1.time_ <= var_275_5 + arg_275_0 then
				arg_272_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_275_6 = arg_272_1.actors_["10042ui_story"]
			local var_275_7 = 0

			if var_275_7 < arg_272_1.time_ and arg_272_1.time_ <= var_275_7 + arg_275_0 and not isNil(var_275_6) and arg_272_1.var_.characterEffect10042ui_story == nil then
				arg_272_1.var_.characterEffect10042ui_story = var_275_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_275_8 = 0.200000002980232

			if var_275_7 <= arg_272_1.time_ and arg_272_1.time_ < var_275_7 + var_275_8 and not isNil(var_275_6) then
				local var_275_9 = (arg_272_1.time_ - var_275_7) / var_275_8

				if arg_272_1.var_.characterEffect10042ui_story and not isNil(var_275_6) then
					local var_275_10 = Mathf.Lerp(0, 0.5, var_275_9)

					arg_272_1.var_.characterEffect10042ui_story.fillFlat = true
					arg_272_1.var_.characterEffect10042ui_story.fillRatio = var_275_10
				end
			end

			if arg_272_1.time_ >= var_275_7 + var_275_8 and arg_272_1.time_ < var_275_7 + var_275_8 + arg_275_0 and not isNil(var_275_6) and arg_272_1.var_.characterEffect10042ui_story then
				local var_275_11 = 0.5

				arg_272_1.var_.characterEffect10042ui_story.fillFlat = true
				arg_272_1.var_.characterEffect10042ui_story.fillRatio = var_275_11
			end

			local var_275_12 = 0
			local var_275_13 = 0.925

			if var_275_12 < arg_272_1.time_ and arg_272_1.time_ <= var_275_12 + arg_275_0 then
				arg_272_1.talkMaxDuration = 0
				arg_272_1.dialogCg_.alpha = 1

				arg_272_1.dialog_:SetActive(true)
				SetActive(arg_272_1.leftNameGo_, true)

				local var_275_14 = arg_272_1:FormatText(StoryNameCfg[6].name)

				arg_272_1.leftNameTxt_.text = var_275_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_272_1.leftNameTxt_.transform)

				arg_272_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_272_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_272_1:RecordName(arg_272_1.leftNameTxt_.text)
				SetActive(arg_272_1.iconTrs_.gameObject, false)
				arg_272_1.callingController_:SetSelectedState("normal")

				local var_275_15 = arg_272_1:GetWordFromCfg(121421067)
				local var_275_16 = arg_272_1:FormatText(var_275_15.content)

				arg_272_1.text_.text = var_275_16

				LuaForUtil.ClearLinePrefixSymbol(arg_272_1.text_)

				local var_275_17 = 37
				local var_275_18 = utf8.len(var_275_16)
				local var_275_19 = var_275_17 <= 0 and var_275_13 or var_275_13 * (var_275_18 / var_275_17)

				if var_275_19 > 0 and var_275_13 < var_275_19 then
					arg_272_1.talkMaxDuration = var_275_19

					if var_275_19 + var_275_12 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_19 + var_275_12
					end
				end

				arg_272_1.text_.text = var_275_16
				arg_272_1.typewritter.percent = 0

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121421", "121421067", "story_v_out_121421.awb") ~= 0 then
					local var_275_20 = manager.audio:GetVoiceLength("story_v_out_121421", "121421067", "story_v_out_121421.awb") / 1000

					if var_275_20 + var_275_12 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_20 + var_275_12
					end

					if var_275_15.prefab_name ~= "" and arg_272_1.actors_[var_275_15.prefab_name] ~= nil then
						local var_275_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_272_1.actors_[var_275_15.prefab_name].transform, "story_v_out_121421", "121421067", "story_v_out_121421.awb")

						arg_272_1:RecordAudio("121421067", var_275_21)
						arg_272_1:RecordAudio("121421067", var_275_21)
					else
						arg_272_1:AudioAction("play", "voice", "story_v_out_121421", "121421067", "story_v_out_121421.awb")
					end

					arg_272_1:RecordHistoryTalkVoice("story_v_out_121421", "121421067", "story_v_out_121421.awb")
				end

				arg_272_1:RecordContent(arg_272_1.text_.text)
			end

			local var_275_22 = math.max(var_275_13, arg_272_1.talkMaxDuration)

			if var_275_12 <= arg_272_1.time_ and arg_272_1.time_ < var_275_12 + var_275_22 then
				arg_272_1.typewritter.percent = (arg_272_1.time_ - var_275_12) / var_275_22

				arg_272_1.typewritter:SetDirty()
			end

			if arg_272_1.time_ >= var_275_12 + var_275_22 and arg_272_1.time_ < var_275_12 + var_275_22 + arg_275_0 then
				arg_272_1.typewritter.percent = 1

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(true)
			end
		end

		arg_272_1.nodeConfigList_ = {}

		arg_272_1:InitPlayNodeList()
	end,
	Play121421068 = function(arg_276_0, arg_276_1)
		arg_276_1.time_ = 0
		arg_276_1.frameCnt_ = 0
		arg_276_1.state_ = "playing"
		arg_276_1.curTalkId_ = 121421068
		arg_276_1.duration_ = 5.7

		local var_276_0 = {
			ja = 5.5,
			ko = 5.7,
			zh = 5.7
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
				arg_276_0:Play121421069(arg_276_1)
			end
		end

		function arg_276_1.onSingleLineUpdate_(arg_279_0)
			local var_279_0 = arg_276_1.actors_["10042ui_story"]
			local var_279_1 = 0

			if var_279_1 < arg_276_1.time_ and arg_276_1.time_ <= var_279_1 + arg_279_0 and not isNil(var_279_0) and arg_276_1.var_.characterEffect10042ui_story == nil then
				arg_276_1.var_.characterEffect10042ui_story = var_279_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_279_2 = 0.200000002980232

			if var_279_1 <= arg_276_1.time_ and arg_276_1.time_ < var_279_1 + var_279_2 and not isNil(var_279_0) then
				local var_279_3 = (arg_276_1.time_ - var_279_1) / var_279_2

				if arg_276_1.var_.characterEffect10042ui_story and not isNil(var_279_0) then
					arg_276_1.var_.characterEffect10042ui_story.fillFlat = false
				end
			end

			if arg_276_1.time_ >= var_279_1 + var_279_2 and arg_276_1.time_ < var_279_1 + var_279_2 + arg_279_0 and not isNil(var_279_0) and arg_276_1.var_.characterEffect10042ui_story then
				arg_276_1.var_.characterEffect10042ui_story.fillFlat = false
			end

			local var_279_4 = 0

			if var_279_4 < arg_276_1.time_ and arg_276_1.time_ <= var_279_4 + arg_279_0 then
				arg_276_1:PlayTimeline("10042ui_story", "StoryTimeline/CharAction/story10042/story10042action/10042action3_2")
			end

			local var_279_5 = 0

			if var_279_5 < arg_276_1.time_ and arg_276_1.time_ <= var_279_5 + arg_279_0 then
				arg_276_1:PlayTimeline("10042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_279_6 = arg_276_1.actors_["1084ui_story"]
			local var_279_7 = 0

			if var_279_7 < arg_276_1.time_ and arg_276_1.time_ <= var_279_7 + arg_279_0 and not isNil(var_279_6) and arg_276_1.var_.characterEffect1084ui_story == nil then
				arg_276_1.var_.characterEffect1084ui_story = var_279_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_279_8 = 0.200000002980232

			if var_279_7 <= arg_276_1.time_ and arg_276_1.time_ < var_279_7 + var_279_8 and not isNil(var_279_6) then
				local var_279_9 = (arg_276_1.time_ - var_279_7) / var_279_8

				if arg_276_1.var_.characterEffect1084ui_story and not isNil(var_279_6) then
					local var_279_10 = Mathf.Lerp(0, 0.5, var_279_9)

					arg_276_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_276_1.var_.characterEffect1084ui_story.fillRatio = var_279_10
				end
			end

			if arg_276_1.time_ >= var_279_7 + var_279_8 and arg_276_1.time_ < var_279_7 + var_279_8 + arg_279_0 and not isNil(var_279_6) and arg_276_1.var_.characterEffect1084ui_story then
				local var_279_11 = 0.5

				arg_276_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_276_1.var_.characterEffect1084ui_story.fillRatio = var_279_11
			end

			local var_279_12 = 0
			local var_279_13 = 0.325

			if var_279_12 < arg_276_1.time_ and arg_276_1.time_ <= var_279_12 + arg_279_0 then
				arg_276_1.talkMaxDuration = 0
				arg_276_1.dialogCg_.alpha = 1

				arg_276_1.dialog_:SetActive(true)
				SetActive(arg_276_1.leftNameGo_, true)

				local var_279_14 = arg_276_1:FormatText(StoryNameCfg[388].name)

				arg_276_1.leftNameTxt_.text = var_279_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_276_1.leftNameTxt_.transform)

				arg_276_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_276_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_276_1:RecordName(arg_276_1.leftNameTxt_.text)
				SetActive(arg_276_1.iconTrs_.gameObject, false)
				arg_276_1.callingController_:SetSelectedState("normal")

				local var_279_15 = arg_276_1:GetWordFromCfg(121421068)
				local var_279_16 = arg_276_1:FormatText(var_279_15.content)

				arg_276_1.text_.text = var_279_16

				LuaForUtil.ClearLinePrefixSymbol(arg_276_1.text_)

				local var_279_17 = 10
				local var_279_18 = utf8.len(var_279_16)
				local var_279_19 = var_279_17 <= 0 and var_279_13 or var_279_13 * (var_279_18 / var_279_17)

				if var_279_19 > 0 and var_279_13 < var_279_19 then
					arg_276_1.talkMaxDuration = var_279_19

					if var_279_19 + var_279_12 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_19 + var_279_12
					end
				end

				arg_276_1.text_.text = var_279_16
				arg_276_1.typewritter.percent = 0

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121421", "121421068", "story_v_out_121421.awb") ~= 0 then
					local var_279_20 = manager.audio:GetVoiceLength("story_v_out_121421", "121421068", "story_v_out_121421.awb") / 1000

					if var_279_20 + var_279_12 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_20 + var_279_12
					end

					if var_279_15.prefab_name ~= "" and arg_276_1.actors_[var_279_15.prefab_name] ~= nil then
						local var_279_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_276_1.actors_[var_279_15.prefab_name].transform, "story_v_out_121421", "121421068", "story_v_out_121421.awb")

						arg_276_1:RecordAudio("121421068", var_279_21)
						arg_276_1:RecordAudio("121421068", var_279_21)
					else
						arg_276_1:AudioAction("play", "voice", "story_v_out_121421", "121421068", "story_v_out_121421.awb")
					end

					arg_276_1:RecordHistoryTalkVoice("story_v_out_121421", "121421068", "story_v_out_121421.awb")
				end

				arg_276_1:RecordContent(arg_276_1.text_.text)
			end

			local var_279_22 = math.max(var_279_13, arg_276_1.talkMaxDuration)

			if var_279_12 <= arg_276_1.time_ and arg_276_1.time_ < var_279_12 + var_279_22 then
				arg_276_1.typewritter.percent = (arg_276_1.time_ - var_279_12) / var_279_22

				arg_276_1.typewritter:SetDirty()
			end

			if arg_276_1.time_ >= var_279_12 + var_279_22 and arg_276_1.time_ < var_279_12 + var_279_22 + arg_279_0 then
				arg_276_1.typewritter.percent = 1

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(true)
			end
		end

		arg_276_1.nodeConfigList_ = {}

		arg_276_1:InitPlayNodeList()
	end,
	Play121421069 = function(arg_280_0, arg_280_1)
		arg_280_1.time_ = 0
		arg_280_1.frameCnt_ = 0
		arg_280_1.state_ = "playing"
		arg_280_1.curTalkId_ = 121421069
		arg_280_1.duration_ = 12.1

		local var_280_0 = {
			ja = 12.1,
			ko = 6.466,
			zh = 6.466
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
				arg_280_0:Play121421070(arg_280_1)
			end
		end

		function arg_280_1.onSingleLineUpdate_(arg_283_0)
			local var_283_0 = 0
			local var_283_1 = 0.7

			if var_283_0 < arg_280_1.time_ and arg_280_1.time_ <= var_283_0 + arg_283_0 then
				arg_280_1.talkMaxDuration = 0
				arg_280_1.dialogCg_.alpha = 1

				arg_280_1.dialog_:SetActive(true)
				SetActive(arg_280_1.leftNameGo_, true)

				local var_283_2 = arg_280_1:FormatText(StoryNameCfg[388].name)

				arg_280_1.leftNameTxt_.text = var_283_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_280_1.leftNameTxt_.transform)

				arg_280_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_280_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_280_1:RecordName(arg_280_1.leftNameTxt_.text)
				SetActive(arg_280_1.iconTrs_.gameObject, false)
				arg_280_1.callingController_:SetSelectedState("normal")

				local var_283_3 = arg_280_1:GetWordFromCfg(121421069)
				local var_283_4 = arg_280_1:FormatText(var_283_3.content)

				arg_280_1.text_.text = var_283_4

				LuaForUtil.ClearLinePrefixSymbol(arg_280_1.text_)

				local var_283_5 = 28
				local var_283_6 = utf8.len(var_283_4)
				local var_283_7 = var_283_5 <= 0 and var_283_1 or var_283_1 * (var_283_6 / var_283_5)

				if var_283_7 > 0 and var_283_1 < var_283_7 then
					arg_280_1.talkMaxDuration = var_283_7

					if var_283_7 + var_283_0 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_7 + var_283_0
					end
				end

				arg_280_1.text_.text = var_283_4
				arg_280_1.typewritter.percent = 0

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121421", "121421069", "story_v_out_121421.awb") ~= 0 then
					local var_283_8 = manager.audio:GetVoiceLength("story_v_out_121421", "121421069", "story_v_out_121421.awb") / 1000

					if var_283_8 + var_283_0 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_8 + var_283_0
					end

					if var_283_3.prefab_name ~= "" and arg_280_1.actors_[var_283_3.prefab_name] ~= nil then
						local var_283_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_280_1.actors_[var_283_3.prefab_name].transform, "story_v_out_121421", "121421069", "story_v_out_121421.awb")

						arg_280_1:RecordAudio("121421069", var_283_9)
						arg_280_1:RecordAudio("121421069", var_283_9)
					else
						arg_280_1:AudioAction("play", "voice", "story_v_out_121421", "121421069", "story_v_out_121421.awb")
					end

					arg_280_1:RecordHistoryTalkVoice("story_v_out_121421", "121421069", "story_v_out_121421.awb")
				end

				arg_280_1:RecordContent(arg_280_1.text_.text)
			end

			local var_283_10 = math.max(var_283_1, arg_280_1.talkMaxDuration)

			if var_283_0 <= arg_280_1.time_ and arg_280_1.time_ < var_283_0 + var_283_10 then
				arg_280_1.typewritter.percent = (arg_280_1.time_ - var_283_0) / var_283_10

				arg_280_1.typewritter:SetDirty()
			end

			if arg_280_1.time_ >= var_283_0 + var_283_10 and arg_280_1.time_ < var_283_0 + var_283_10 + arg_283_0 then
				arg_280_1.typewritter.percent = 1

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(true)
			end
		end

		arg_280_1.nodeConfigList_ = {}

		arg_280_1:InitPlayNodeList()
	end,
	Play121421070 = function(arg_284_0, arg_284_1)
		arg_284_1.time_ = 0
		arg_284_1.frameCnt_ = 0
		arg_284_1.state_ = "playing"
		arg_284_1.curTalkId_ = 121421070
		arg_284_1.duration_ = 11.47

		local var_284_0 = {
			ja = 10.9,
			ko = 11.466,
			zh = 11.466
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
		end

		function arg_284_1.playNext_(arg_286_0)
			if arg_286_0 == 1 then
				arg_284_0:Play121421071(arg_284_1)
			end
		end

		function arg_284_1.onSingleLineUpdate_(arg_287_0)
			local var_287_0 = 0

			if var_287_0 < arg_284_1.time_ and arg_284_1.time_ <= var_287_0 + arg_287_0 then
				arg_284_1:PlayTimeline("10042ui_story", "StoryTimeline/CharAction/story10042/story10042action/10042action1_1")
			end

			local var_287_1 = 0

			if var_287_1 < arg_284_1.time_ and arg_284_1.time_ <= var_287_1 + arg_287_0 then
				arg_284_1:PlayTimeline("10042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_287_2 = 0
			local var_287_3 = 1.275

			if var_287_2 < arg_284_1.time_ and arg_284_1.time_ <= var_287_2 + arg_287_0 then
				arg_284_1.talkMaxDuration = 0
				arg_284_1.dialogCg_.alpha = 1

				arg_284_1.dialog_:SetActive(true)
				SetActive(arg_284_1.leftNameGo_, true)

				local var_287_4 = arg_284_1:FormatText(StoryNameCfg[388].name)

				arg_284_1.leftNameTxt_.text = var_287_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_284_1.leftNameTxt_.transform)

				arg_284_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_284_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_284_1:RecordName(arg_284_1.leftNameTxt_.text)
				SetActive(arg_284_1.iconTrs_.gameObject, false)
				arg_284_1.callingController_:SetSelectedState("normal")

				local var_287_5 = arg_284_1:GetWordFromCfg(121421070)
				local var_287_6 = arg_284_1:FormatText(var_287_5.content)

				arg_284_1.text_.text = var_287_6

				LuaForUtil.ClearLinePrefixSymbol(arg_284_1.text_)

				local var_287_7 = 51
				local var_287_8 = utf8.len(var_287_6)
				local var_287_9 = var_287_7 <= 0 and var_287_3 or var_287_3 * (var_287_8 / var_287_7)

				if var_287_9 > 0 and var_287_3 < var_287_9 then
					arg_284_1.talkMaxDuration = var_287_9

					if var_287_9 + var_287_2 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_9 + var_287_2
					end
				end

				arg_284_1.text_.text = var_287_6
				arg_284_1.typewritter.percent = 0

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121421", "121421070", "story_v_out_121421.awb") ~= 0 then
					local var_287_10 = manager.audio:GetVoiceLength("story_v_out_121421", "121421070", "story_v_out_121421.awb") / 1000

					if var_287_10 + var_287_2 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_10 + var_287_2
					end

					if var_287_5.prefab_name ~= "" and arg_284_1.actors_[var_287_5.prefab_name] ~= nil then
						local var_287_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_284_1.actors_[var_287_5.prefab_name].transform, "story_v_out_121421", "121421070", "story_v_out_121421.awb")

						arg_284_1:RecordAudio("121421070", var_287_11)
						arg_284_1:RecordAudio("121421070", var_287_11)
					else
						arg_284_1:AudioAction("play", "voice", "story_v_out_121421", "121421070", "story_v_out_121421.awb")
					end

					arg_284_1:RecordHistoryTalkVoice("story_v_out_121421", "121421070", "story_v_out_121421.awb")
				end

				arg_284_1:RecordContent(arg_284_1.text_.text)
			end

			local var_287_12 = math.max(var_287_3, arg_284_1.talkMaxDuration)

			if var_287_2 <= arg_284_1.time_ and arg_284_1.time_ < var_287_2 + var_287_12 then
				arg_284_1.typewritter.percent = (arg_284_1.time_ - var_287_2) / var_287_12

				arg_284_1.typewritter:SetDirty()
			end

			if arg_284_1.time_ >= var_287_2 + var_287_12 and arg_284_1.time_ < var_287_2 + var_287_12 + arg_287_0 then
				arg_284_1.typewritter.percent = 1

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(true)
			end
		end

		arg_284_1.nodeConfigList_ = {}

		arg_284_1:InitPlayNodeList()
	end,
	Play121421071 = function(arg_288_0, arg_288_1)
		arg_288_1.time_ = 0
		arg_288_1.frameCnt_ = 0
		arg_288_1.state_ = "playing"
		arg_288_1.curTalkId_ = 121421071
		arg_288_1.duration_ = 17.1

		local var_288_0 = {
			ja = 17.1,
			ko = 12.433,
			zh = 12.433
		}
		local var_288_1 = manager.audio:GetLocalizationFlag()

		if var_288_0[var_288_1] ~= nil then
			arg_288_1.duration_ = var_288_0[var_288_1]
		end

		SetActive(arg_288_1.tipsGo_, false)

		function arg_288_1.onSingleLineFinish_()
			arg_288_1.onSingleLineUpdate_ = nil
			arg_288_1.onSingleLineFinish_ = nil
			arg_288_1.state_ = "waiting"
		end

		function arg_288_1.playNext_(arg_290_0)
			if arg_290_0 == 1 then
				arg_288_0:Play121421072(arg_288_1)
			end
		end

		function arg_288_1.onSingleLineUpdate_(arg_291_0)
			local var_291_0 = 0
			local var_291_1 = 1.275

			if var_291_0 < arg_288_1.time_ and arg_288_1.time_ <= var_291_0 + arg_291_0 then
				arg_288_1.talkMaxDuration = 0
				arg_288_1.dialogCg_.alpha = 1

				arg_288_1.dialog_:SetActive(true)
				SetActive(arg_288_1.leftNameGo_, true)

				local var_291_2 = arg_288_1:FormatText(StoryNameCfg[388].name)

				arg_288_1.leftNameTxt_.text = var_291_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_288_1.leftNameTxt_.transform)

				arg_288_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_288_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_288_1:RecordName(arg_288_1.leftNameTxt_.text)
				SetActive(arg_288_1.iconTrs_.gameObject, false)
				arg_288_1.callingController_:SetSelectedState("normal")

				local var_291_3 = arg_288_1:GetWordFromCfg(121421071)
				local var_291_4 = arg_288_1:FormatText(var_291_3.content)

				arg_288_1.text_.text = var_291_4

				LuaForUtil.ClearLinePrefixSymbol(arg_288_1.text_)

				local var_291_5 = 51
				local var_291_6 = utf8.len(var_291_4)
				local var_291_7 = var_291_5 <= 0 and var_291_1 or var_291_1 * (var_291_6 / var_291_5)

				if var_291_7 > 0 and var_291_1 < var_291_7 then
					arg_288_1.talkMaxDuration = var_291_7

					if var_291_7 + var_291_0 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_7 + var_291_0
					end
				end

				arg_288_1.text_.text = var_291_4
				arg_288_1.typewritter.percent = 0

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121421", "121421071", "story_v_out_121421.awb") ~= 0 then
					local var_291_8 = manager.audio:GetVoiceLength("story_v_out_121421", "121421071", "story_v_out_121421.awb") / 1000

					if var_291_8 + var_291_0 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_8 + var_291_0
					end

					if var_291_3.prefab_name ~= "" and arg_288_1.actors_[var_291_3.prefab_name] ~= nil then
						local var_291_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_288_1.actors_[var_291_3.prefab_name].transform, "story_v_out_121421", "121421071", "story_v_out_121421.awb")

						arg_288_1:RecordAudio("121421071", var_291_9)
						arg_288_1:RecordAudio("121421071", var_291_9)
					else
						arg_288_1:AudioAction("play", "voice", "story_v_out_121421", "121421071", "story_v_out_121421.awb")
					end

					arg_288_1:RecordHistoryTalkVoice("story_v_out_121421", "121421071", "story_v_out_121421.awb")
				end

				arg_288_1:RecordContent(arg_288_1.text_.text)
			end

			local var_291_10 = math.max(var_291_1, arg_288_1.talkMaxDuration)

			if var_291_0 <= arg_288_1.time_ and arg_288_1.time_ < var_291_0 + var_291_10 then
				arg_288_1.typewritter.percent = (arg_288_1.time_ - var_291_0) / var_291_10

				arg_288_1.typewritter:SetDirty()
			end

			if arg_288_1.time_ >= var_291_0 + var_291_10 and arg_288_1.time_ < var_291_0 + var_291_10 + arg_291_0 then
				arg_288_1.typewritter.percent = 1

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(true)
			end
		end

		arg_288_1.nodeConfigList_ = {}

		arg_288_1:InitPlayNodeList()
	end,
	Play121421072 = function(arg_292_0, arg_292_1)
		arg_292_1.time_ = 0
		arg_292_1.frameCnt_ = 0
		arg_292_1.state_ = "playing"
		arg_292_1.curTalkId_ = 121421072
		arg_292_1.duration_ = 15.23

		local var_292_0 = {
			ja = 15.233,
			ko = 6.133,
			zh = 6.133
		}
		local var_292_1 = manager.audio:GetLocalizationFlag()

		if var_292_0[var_292_1] ~= nil then
			arg_292_1.duration_ = var_292_0[var_292_1]
		end

		SetActive(arg_292_1.tipsGo_, false)

		function arg_292_1.onSingleLineFinish_()
			arg_292_1.onSingleLineUpdate_ = nil
			arg_292_1.onSingleLineFinish_ = nil
			arg_292_1.state_ = "waiting"
		end

		function arg_292_1.playNext_(arg_294_0)
			if arg_294_0 == 1 then
				arg_292_0:Play121421073(arg_292_1)
			end
		end

		function arg_292_1.onSingleLineUpdate_(arg_295_0)
			local var_295_0 = 0
			local var_295_1 = 0.775

			if var_295_0 < arg_292_1.time_ and arg_292_1.time_ <= var_295_0 + arg_295_0 then
				arg_292_1.talkMaxDuration = 0
				arg_292_1.dialogCg_.alpha = 1

				arg_292_1.dialog_:SetActive(true)
				SetActive(arg_292_1.leftNameGo_, true)

				local var_295_2 = arg_292_1:FormatText(StoryNameCfg[388].name)

				arg_292_1.leftNameTxt_.text = var_295_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_292_1.leftNameTxt_.transform)

				arg_292_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_292_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_292_1:RecordName(arg_292_1.leftNameTxt_.text)
				SetActive(arg_292_1.iconTrs_.gameObject, false)
				arg_292_1.callingController_:SetSelectedState("normal")

				local var_295_3 = arg_292_1:GetWordFromCfg(121421072)
				local var_295_4 = arg_292_1:FormatText(var_295_3.content)

				arg_292_1.text_.text = var_295_4

				LuaForUtil.ClearLinePrefixSymbol(arg_292_1.text_)

				local var_295_5 = 31
				local var_295_6 = utf8.len(var_295_4)
				local var_295_7 = var_295_5 <= 0 and var_295_1 or var_295_1 * (var_295_6 / var_295_5)

				if var_295_7 > 0 and var_295_1 < var_295_7 then
					arg_292_1.talkMaxDuration = var_295_7

					if var_295_7 + var_295_0 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_7 + var_295_0
					end
				end

				arg_292_1.text_.text = var_295_4
				arg_292_1.typewritter.percent = 0

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121421", "121421072", "story_v_out_121421.awb") ~= 0 then
					local var_295_8 = manager.audio:GetVoiceLength("story_v_out_121421", "121421072", "story_v_out_121421.awb") / 1000

					if var_295_8 + var_295_0 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_8 + var_295_0
					end

					if var_295_3.prefab_name ~= "" and arg_292_1.actors_[var_295_3.prefab_name] ~= nil then
						local var_295_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_292_1.actors_[var_295_3.prefab_name].transform, "story_v_out_121421", "121421072", "story_v_out_121421.awb")

						arg_292_1:RecordAudio("121421072", var_295_9)
						arg_292_1:RecordAudio("121421072", var_295_9)
					else
						arg_292_1:AudioAction("play", "voice", "story_v_out_121421", "121421072", "story_v_out_121421.awb")
					end

					arg_292_1:RecordHistoryTalkVoice("story_v_out_121421", "121421072", "story_v_out_121421.awb")
				end

				arg_292_1:RecordContent(arg_292_1.text_.text)
			end

			local var_295_10 = math.max(var_295_1, arg_292_1.talkMaxDuration)

			if var_295_0 <= arg_292_1.time_ and arg_292_1.time_ < var_295_0 + var_295_10 then
				arg_292_1.typewritter.percent = (arg_292_1.time_ - var_295_0) / var_295_10

				arg_292_1.typewritter:SetDirty()
			end

			if arg_292_1.time_ >= var_295_0 + var_295_10 and arg_292_1.time_ < var_295_0 + var_295_10 + arg_295_0 then
				arg_292_1.typewritter.percent = 1

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(true)
			end
		end

		arg_292_1.nodeConfigList_ = {}

		arg_292_1:InitPlayNodeList()
	end,
	Play121421073 = function(arg_296_0, arg_296_1)
		arg_296_1.time_ = 0
		arg_296_1.frameCnt_ = 0
		arg_296_1.state_ = "playing"
		arg_296_1.curTalkId_ = 121421073
		arg_296_1.duration_ = 5

		SetActive(arg_296_1.tipsGo_, false)

		function arg_296_1.onSingleLineFinish_()
			arg_296_1.onSingleLineUpdate_ = nil
			arg_296_1.onSingleLineFinish_ = nil
			arg_296_1.state_ = "waiting"
		end

		function arg_296_1.playNext_(arg_298_0)
			if arg_298_0 == 1 then
				arg_296_0:Play121421074(arg_296_1)
			end
		end

		function arg_296_1.onSingleLineUpdate_(arg_299_0)
			local var_299_0 = arg_296_1.actors_["10042ui_story"]
			local var_299_1 = 0

			if var_299_1 < arg_296_1.time_ and arg_296_1.time_ <= var_299_1 + arg_299_0 and not isNil(var_299_0) and arg_296_1.var_.characterEffect10042ui_story == nil then
				arg_296_1.var_.characterEffect10042ui_story = var_299_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_299_2 = 0.200000002980232

			if var_299_1 <= arg_296_1.time_ and arg_296_1.time_ < var_299_1 + var_299_2 and not isNil(var_299_0) then
				local var_299_3 = (arg_296_1.time_ - var_299_1) / var_299_2

				if arg_296_1.var_.characterEffect10042ui_story and not isNil(var_299_0) then
					local var_299_4 = Mathf.Lerp(0, 0.5, var_299_3)

					arg_296_1.var_.characterEffect10042ui_story.fillFlat = true
					arg_296_1.var_.characterEffect10042ui_story.fillRatio = var_299_4
				end
			end

			if arg_296_1.time_ >= var_299_1 + var_299_2 and arg_296_1.time_ < var_299_1 + var_299_2 + arg_299_0 and not isNil(var_299_0) and arg_296_1.var_.characterEffect10042ui_story then
				local var_299_5 = 0.5

				arg_296_1.var_.characterEffect10042ui_story.fillFlat = true
				arg_296_1.var_.characterEffect10042ui_story.fillRatio = var_299_5
			end

			local var_299_6 = 0
			local var_299_7 = 0.225

			if var_299_6 < arg_296_1.time_ and arg_296_1.time_ <= var_299_6 + arg_299_0 then
				arg_296_1.talkMaxDuration = 0
				arg_296_1.dialogCg_.alpha = 1

				arg_296_1.dialog_:SetActive(true)
				SetActive(arg_296_1.leftNameGo_, true)

				local var_299_8 = arg_296_1:FormatText(StoryNameCfg[7].name)

				arg_296_1.leftNameTxt_.text = var_299_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_296_1.leftNameTxt_.transform)

				arg_296_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_296_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_296_1:RecordName(arg_296_1.leftNameTxt_.text)
				SetActive(arg_296_1.iconTrs_.gameObject, true)
				arg_296_1.iconController_:SetSelectedState("hero")

				arg_296_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_296_1.callingController_:SetSelectedState("normal")

				arg_296_1.keyicon_.color = Color.New(1, 1, 1)
				arg_296_1.icon_.color = Color.New(1, 1, 1)

				local var_299_9 = arg_296_1:GetWordFromCfg(121421073)
				local var_299_10 = arg_296_1:FormatText(var_299_9.content)

				arg_296_1.text_.text = var_299_10

				LuaForUtil.ClearLinePrefixSymbol(arg_296_1.text_)

				local var_299_11 = 9
				local var_299_12 = utf8.len(var_299_10)
				local var_299_13 = var_299_11 <= 0 and var_299_7 or var_299_7 * (var_299_12 / var_299_11)

				if var_299_13 > 0 and var_299_7 < var_299_13 then
					arg_296_1.talkMaxDuration = var_299_13

					if var_299_13 + var_299_6 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_13 + var_299_6
					end
				end

				arg_296_1.text_.text = var_299_10
				arg_296_1.typewritter.percent = 0

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(false)
				arg_296_1:RecordContent(arg_296_1.text_.text)
			end

			local var_299_14 = math.max(var_299_7, arg_296_1.talkMaxDuration)

			if var_299_6 <= arg_296_1.time_ and arg_296_1.time_ < var_299_6 + var_299_14 then
				arg_296_1.typewritter.percent = (arg_296_1.time_ - var_299_6) / var_299_14

				arg_296_1.typewritter:SetDirty()
			end

			if arg_296_1.time_ >= var_299_6 + var_299_14 and arg_296_1.time_ < var_299_6 + var_299_14 + arg_299_0 then
				arg_296_1.typewritter.percent = 1

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(true)
			end
		end

		arg_296_1.nodeConfigList_ = {}

		arg_296_1:InitPlayNodeList()
	end,
	Play121421074 = function(arg_300_0, arg_300_1)
		arg_300_1.time_ = 0
		arg_300_1.frameCnt_ = 0
		arg_300_1.state_ = "playing"
		arg_300_1.curTalkId_ = 121421074
		arg_300_1.duration_ = 14.2

		local var_300_0 = {
			ja = 14.2,
			ko = 4.433,
			zh = 4.433
		}
		local var_300_1 = manager.audio:GetLocalizationFlag()

		if var_300_0[var_300_1] ~= nil then
			arg_300_1.duration_ = var_300_0[var_300_1]
		end

		SetActive(arg_300_1.tipsGo_, false)

		function arg_300_1.onSingleLineFinish_()
			arg_300_1.onSingleLineUpdate_ = nil
			arg_300_1.onSingleLineFinish_ = nil
			arg_300_1.state_ = "waiting"
		end

		function arg_300_1.playNext_(arg_302_0)
			if arg_302_0 == 1 then
				arg_300_0:Play121421075(arg_300_1)
			end
		end

		function arg_300_1.onSingleLineUpdate_(arg_303_0)
			local var_303_0 = arg_300_1.actors_["10042ui_story"]
			local var_303_1 = 0

			if var_303_1 < arg_300_1.time_ and arg_300_1.time_ <= var_303_1 + arg_303_0 and not isNil(var_303_0) and arg_300_1.var_.characterEffect10042ui_story == nil then
				arg_300_1.var_.characterEffect10042ui_story = var_303_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_303_2 = 0.200000002980232

			if var_303_1 <= arg_300_1.time_ and arg_300_1.time_ < var_303_1 + var_303_2 and not isNil(var_303_0) then
				local var_303_3 = (arg_300_1.time_ - var_303_1) / var_303_2

				if arg_300_1.var_.characterEffect10042ui_story and not isNil(var_303_0) then
					arg_300_1.var_.characterEffect10042ui_story.fillFlat = false
				end
			end

			if arg_300_1.time_ >= var_303_1 + var_303_2 and arg_300_1.time_ < var_303_1 + var_303_2 + arg_303_0 and not isNil(var_303_0) and arg_300_1.var_.characterEffect10042ui_story then
				arg_300_1.var_.characterEffect10042ui_story.fillFlat = false
			end

			local var_303_4 = 0

			if var_303_4 < arg_300_1.time_ and arg_300_1.time_ <= var_303_4 + arg_303_0 then
				arg_300_1:PlayTimeline("10042ui_story", "StoryTimeline/CharAction/story10042/story10042action/10042action1_1")
			end

			local var_303_5 = 0

			if var_303_5 < arg_300_1.time_ and arg_300_1.time_ <= var_303_5 + arg_303_0 then
				arg_300_1:PlayTimeline("10042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_303_6 = 0
			local var_303_7 = 0.55

			if var_303_6 < arg_300_1.time_ and arg_300_1.time_ <= var_303_6 + arg_303_0 then
				arg_300_1.talkMaxDuration = 0
				arg_300_1.dialogCg_.alpha = 1

				arg_300_1.dialog_:SetActive(true)
				SetActive(arg_300_1.leftNameGo_, true)

				local var_303_8 = arg_300_1:FormatText(StoryNameCfg[388].name)

				arg_300_1.leftNameTxt_.text = var_303_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_300_1.leftNameTxt_.transform)

				arg_300_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_300_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_300_1:RecordName(arg_300_1.leftNameTxt_.text)
				SetActive(arg_300_1.iconTrs_.gameObject, false)
				arg_300_1.callingController_:SetSelectedState("normal")

				local var_303_9 = arg_300_1:GetWordFromCfg(121421074)
				local var_303_10 = arg_300_1:FormatText(var_303_9.content)

				arg_300_1.text_.text = var_303_10

				LuaForUtil.ClearLinePrefixSymbol(arg_300_1.text_)

				local var_303_11 = 22
				local var_303_12 = utf8.len(var_303_10)
				local var_303_13 = var_303_11 <= 0 and var_303_7 or var_303_7 * (var_303_12 / var_303_11)

				if var_303_13 > 0 and var_303_7 < var_303_13 then
					arg_300_1.talkMaxDuration = var_303_13

					if var_303_13 + var_303_6 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_13 + var_303_6
					end
				end

				arg_300_1.text_.text = var_303_10
				arg_300_1.typewritter.percent = 0

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121421", "121421074", "story_v_out_121421.awb") ~= 0 then
					local var_303_14 = manager.audio:GetVoiceLength("story_v_out_121421", "121421074", "story_v_out_121421.awb") / 1000

					if var_303_14 + var_303_6 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_14 + var_303_6
					end

					if var_303_9.prefab_name ~= "" and arg_300_1.actors_[var_303_9.prefab_name] ~= nil then
						local var_303_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_300_1.actors_[var_303_9.prefab_name].transform, "story_v_out_121421", "121421074", "story_v_out_121421.awb")

						arg_300_1:RecordAudio("121421074", var_303_15)
						arg_300_1:RecordAudio("121421074", var_303_15)
					else
						arg_300_1:AudioAction("play", "voice", "story_v_out_121421", "121421074", "story_v_out_121421.awb")
					end

					arg_300_1:RecordHistoryTalkVoice("story_v_out_121421", "121421074", "story_v_out_121421.awb")
				end

				arg_300_1:RecordContent(arg_300_1.text_.text)
			end

			local var_303_16 = math.max(var_303_7, arg_300_1.talkMaxDuration)

			if var_303_6 <= arg_300_1.time_ and arg_300_1.time_ < var_303_6 + var_303_16 then
				arg_300_1.typewritter.percent = (arg_300_1.time_ - var_303_6) / var_303_16

				arg_300_1.typewritter:SetDirty()
			end

			if arg_300_1.time_ >= var_303_6 + var_303_16 and arg_300_1.time_ < var_303_6 + var_303_16 + arg_303_0 then
				arg_300_1.typewritter.percent = 1

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(true)
			end
		end

		arg_300_1.nodeConfigList_ = {}

		arg_300_1:InitPlayNodeList()
	end,
	Play121421075 = function(arg_304_0, arg_304_1)
		arg_304_1.time_ = 0
		arg_304_1.frameCnt_ = 0
		arg_304_1.state_ = "playing"
		arg_304_1.curTalkId_ = 121421075
		arg_304_1.duration_ = 9.13

		local var_304_0 = {
			ja = 9.133,
			ko = 8.6,
			zh = 8.6
		}
		local var_304_1 = manager.audio:GetLocalizationFlag()

		if var_304_0[var_304_1] ~= nil then
			arg_304_1.duration_ = var_304_0[var_304_1]
		end

		SetActive(arg_304_1.tipsGo_, false)

		function arg_304_1.onSingleLineFinish_()
			arg_304_1.onSingleLineUpdate_ = nil
			arg_304_1.onSingleLineFinish_ = nil
			arg_304_1.state_ = "waiting"
		end

		function arg_304_1.playNext_(arg_306_0)
			if arg_306_0 == 1 then
				arg_304_0:Play121421076(arg_304_1)
			end
		end

		function arg_304_1.onSingleLineUpdate_(arg_307_0)
			local var_307_0 = 0
			local var_307_1 = 0.825

			if var_307_0 < arg_304_1.time_ and arg_304_1.time_ <= var_307_0 + arg_307_0 then
				arg_304_1.talkMaxDuration = 0
				arg_304_1.dialogCg_.alpha = 1

				arg_304_1.dialog_:SetActive(true)
				SetActive(arg_304_1.leftNameGo_, true)

				local var_307_2 = arg_304_1:FormatText(StoryNameCfg[388].name)

				arg_304_1.leftNameTxt_.text = var_307_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_304_1.leftNameTxt_.transform)

				arg_304_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_304_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_304_1:RecordName(arg_304_1.leftNameTxt_.text)
				SetActive(arg_304_1.iconTrs_.gameObject, false)
				arg_304_1.callingController_:SetSelectedState("normal")

				local var_307_3 = arg_304_1:GetWordFromCfg(121421075)
				local var_307_4 = arg_304_1:FormatText(var_307_3.content)

				arg_304_1.text_.text = var_307_4

				LuaForUtil.ClearLinePrefixSymbol(arg_304_1.text_)

				local var_307_5 = 33
				local var_307_6 = utf8.len(var_307_4)
				local var_307_7 = var_307_5 <= 0 and var_307_1 or var_307_1 * (var_307_6 / var_307_5)

				if var_307_7 > 0 and var_307_1 < var_307_7 then
					arg_304_1.talkMaxDuration = var_307_7

					if var_307_7 + var_307_0 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_7 + var_307_0
					end
				end

				arg_304_1.text_.text = var_307_4
				arg_304_1.typewritter.percent = 0

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121421", "121421075", "story_v_out_121421.awb") ~= 0 then
					local var_307_8 = manager.audio:GetVoiceLength("story_v_out_121421", "121421075", "story_v_out_121421.awb") / 1000

					if var_307_8 + var_307_0 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_8 + var_307_0
					end

					if var_307_3.prefab_name ~= "" and arg_304_1.actors_[var_307_3.prefab_name] ~= nil then
						local var_307_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_304_1.actors_[var_307_3.prefab_name].transform, "story_v_out_121421", "121421075", "story_v_out_121421.awb")

						arg_304_1:RecordAudio("121421075", var_307_9)
						arg_304_1:RecordAudio("121421075", var_307_9)
					else
						arg_304_1:AudioAction("play", "voice", "story_v_out_121421", "121421075", "story_v_out_121421.awb")
					end

					arg_304_1:RecordHistoryTalkVoice("story_v_out_121421", "121421075", "story_v_out_121421.awb")
				end

				arg_304_1:RecordContent(arg_304_1.text_.text)
			end

			local var_307_10 = math.max(var_307_1, arg_304_1.talkMaxDuration)

			if var_307_0 <= arg_304_1.time_ and arg_304_1.time_ < var_307_0 + var_307_10 then
				arg_304_1.typewritter.percent = (arg_304_1.time_ - var_307_0) / var_307_10

				arg_304_1.typewritter:SetDirty()
			end

			if arg_304_1.time_ >= var_307_0 + var_307_10 and arg_304_1.time_ < var_307_0 + var_307_10 + arg_307_0 then
				arg_304_1.typewritter.percent = 1

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(true)
			end
		end

		arg_304_1.nodeConfigList_ = {}

		arg_304_1:InitPlayNodeList()
	end,
	Play121421076 = function(arg_308_0, arg_308_1)
		arg_308_1.time_ = 0
		arg_308_1.frameCnt_ = 0
		arg_308_1.state_ = "playing"
		arg_308_1.curTalkId_ = 121421076
		arg_308_1.duration_ = 5

		SetActive(arg_308_1.tipsGo_, false)

		function arg_308_1.onSingleLineFinish_()
			arg_308_1.onSingleLineUpdate_ = nil
			arg_308_1.onSingleLineFinish_ = nil
			arg_308_1.state_ = "waiting"
		end

		function arg_308_1.playNext_(arg_310_0)
			if arg_310_0 == 1 then
				arg_308_0:Play121421077(arg_308_1)
			end
		end

		function arg_308_1.onSingleLineUpdate_(arg_311_0)
			local var_311_0 = arg_308_1.actors_["10042ui_story"].transform
			local var_311_1 = 0

			if var_311_1 < arg_308_1.time_ and arg_308_1.time_ <= var_311_1 + arg_311_0 then
				arg_308_1.var_.moveOldPos10042ui_story = var_311_0.localPosition
			end

			local var_311_2 = 0.001

			if var_311_1 <= arg_308_1.time_ and arg_308_1.time_ < var_311_1 + var_311_2 then
				local var_311_3 = (arg_308_1.time_ - var_311_1) / var_311_2
				local var_311_4 = Vector3.New(0, 100, 0)

				var_311_0.localPosition = Vector3.Lerp(arg_308_1.var_.moveOldPos10042ui_story, var_311_4, var_311_3)

				local var_311_5 = manager.ui.mainCamera.transform.position - var_311_0.position

				var_311_0.forward = Vector3.New(var_311_5.x, var_311_5.y, var_311_5.z)

				local var_311_6 = var_311_0.localEulerAngles

				var_311_6.z = 0
				var_311_6.x = 0
				var_311_0.localEulerAngles = var_311_6
			end

			if arg_308_1.time_ >= var_311_1 + var_311_2 and arg_308_1.time_ < var_311_1 + var_311_2 + arg_311_0 then
				var_311_0.localPosition = Vector3.New(0, 100, 0)

				local var_311_7 = manager.ui.mainCamera.transform.position - var_311_0.position

				var_311_0.forward = Vector3.New(var_311_7.x, var_311_7.y, var_311_7.z)

				local var_311_8 = var_311_0.localEulerAngles

				var_311_8.z = 0
				var_311_8.x = 0
				var_311_0.localEulerAngles = var_311_8
			end

			local var_311_9 = arg_308_1.actors_["10042ui_story"]
			local var_311_10 = 0

			if var_311_10 < arg_308_1.time_ and arg_308_1.time_ <= var_311_10 + arg_311_0 and not isNil(var_311_9) and arg_308_1.var_.characterEffect10042ui_story == nil then
				arg_308_1.var_.characterEffect10042ui_story = var_311_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_311_11 = 0.200000002980232

			if var_311_10 <= arg_308_1.time_ and arg_308_1.time_ < var_311_10 + var_311_11 and not isNil(var_311_9) then
				local var_311_12 = (arg_308_1.time_ - var_311_10) / var_311_11

				if arg_308_1.var_.characterEffect10042ui_story and not isNil(var_311_9) then
					local var_311_13 = Mathf.Lerp(0, 0.5, var_311_12)

					arg_308_1.var_.characterEffect10042ui_story.fillFlat = true
					arg_308_1.var_.characterEffect10042ui_story.fillRatio = var_311_13
				end
			end

			if arg_308_1.time_ >= var_311_10 + var_311_11 and arg_308_1.time_ < var_311_10 + var_311_11 + arg_311_0 and not isNil(var_311_9) and arg_308_1.var_.characterEffect10042ui_story then
				local var_311_14 = 0.5

				arg_308_1.var_.characterEffect10042ui_story.fillFlat = true
				arg_308_1.var_.characterEffect10042ui_story.fillRatio = var_311_14
			end

			local var_311_15 = arg_308_1.actors_["1084ui_story"].transform
			local var_311_16 = 0

			if var_311_16 < arg_308_1.time_ and arg_308_1.time_ <= var_311_16 + arg_311_0 then
				arg_308_1.var_.moveOldPos1084ui_story = var_311_15.localPosition
			end

			local var_311_17 = 0.001

			if var_311_16 <= arg_308_1.time_ and arg_308_1.time_ < var_311_16 + var_311_17 then
				local var_311_18 = (arg_308_1.time_ - var_311_16) / var_311_17
				local var_311_19 = Vector3.New(0, 100, 0)

				var_311_15.localPosition = Vector3.Lerp(arg_308_1.var_.moveOldPos1084ui_story, var_311_19, var_311_18)

				local var_311_20 = manager.ui.mainCamera.transform.position - var_311_15.position

				var_311_15.forward = Vector3.New(var_311_20.x, var_311_20.y, var_311_20.z)

				local var_311_21 = var_311_15.localEulerAngles

				var_311_21.z = 0
				var_311_21.x = 0
				var_311_15.localEulerAngles = var_311_21
			end

			if arg_308_1.time_ >= var_311_16 + var_311_17 and arg_308_1.time_ < var_311_16 + var_311_17 + arg_311_0 then
				var_311_15.localPosition = Vector3.New(0, 100, 0)

				local var_311_22 = manager.ui.mainCamera.transform.position - var_311_15.position

				var_311_15.forward = Vector3.New(var_311_22.x, var_311_22.y, var_311_22.z)

				local var_311_23 = var_311_15.localEulerAngles

				var_311_23.z = 0
				var_311_23.x = 0
				var_311_15.localEulerAngles = var_311_23
			end

			local var_311_24 = arg_308_1.actors_["1084ui_story"]
			local var_311_25 = 0

			if var_311_25 < arg_308_1.time_ and arg_308_1.time_ <= var_311_25 + arg_311_0 and not isNil(var_311_24) and arg_308_1.var_.characterEffect1084ui_story == nil then
				arg_308_1.var_.characterEffect1084ui_story = var_311_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_311_26 = 0.200000002980232

			if var_311_25 <= arg_308_1.time_ and arg_308_1.time_ < var_311_25 + var_311_26 and not isNil(var_311_24) then
				local var_311_27 = (arg_308_1.time_ - var_311_25) / var_311_26

				if arg_308_1.var_.characterEffect1084ui_story and not isNil(var_311_24) then
					local var_311_28 = Mathf.Lerp(0, 0.5, var_311_27)

					arg_308_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_308_1.var_.characterEffect1084ui_story.fillRatio = var_311_28
				end
			end

			if arg_308_1.time_ >= var_311_25 + var_311_26 and arg_308_1.time_ < var_311_25 + var_311_26 + arg_311_0 and not isNil(var_311_24) and arg_308_1.var_.characterEffect1084ui_story then
				local var_311_29 = 0.5

				arg_308_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_308_1.var_.characterEffect1084ui_story.fillRatio = var_311_29
			end

			local var_311_30 = 0
			local var_311_31 = 0.925

			if var_311_30 < arg_308_1.time_ and arg_308_1.time_ <= var_311_30 + arg_311_0 then
				arg_308_1.talkMaxDuration = 0
				arg_308_1.dialogCg_.alpha = 1

				arg_308_1.dialog_:SetActive(true)
				SetActive(arg_308_1.leftNameGo_, false)

				arg_308_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_308_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_308_1:RecordName(arg_308_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_308_1.iconTrs_.gameObject, false)
				arg_308_1.callingController_:SetSelectedState("normal")

				local var_311_32 = arg_308_1:GetWordFromCfg(121421076)
				local var_311_33 = arg_308_1:FormatText(var_311_32.content)

				arg_308_1.text_.text = var_311_33

				LuaForUtil.ClearLinePrefixSymbol(arg_308_1.text_)

				local var_311_34 = 37
				local var_311_35 = utf8.len(var_311_33)
				local var_311_36 = var_311_34 <= 0 and var_311_31 or var_311_31 * (var_311_35 / var_311_34)

				if var_311_36 > 0 and var_311_31 < var_311_36 then
					arg_308_1.talkMaxDuration = var_311_36

					if var_311_36 + var_311_30 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_36 + var_311_30
					end
				end

				arg_308_1.text_.text = var_311_33
				arg_308_1.typewritter.percent = 0

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(false)
				arg_308_1:RecordContent(arg_308_1.text_.text)
			end

			local var_311_37 = math.max(var_311_31, arg_308_1.talkMaxDuration)

			if var_311_30 <= arg_308_1.time_ and arg_308_1.time_ < var_311_30 + var_311_37 then
				arg_308_1.typewritter.percent = (arg_308_1.time_ - var_311_30) / var_311_37

				arg_308_1.typewritter:SetDirty()
			end

			if arg_308_1.time_ >= var_311_30 + var_311_37 and arg_308_1.time_ < var_311_30 + var_311_37 + arg_311_0 then
				arg_308_1.typewritter.percent = 1

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(true)
			end
		end

		arg_308_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10042ui_story",
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

		arg_308_1:InitPlayNodeList()
	end,
	Play121421077 = function(arg_312_0, arg_312_1)
		arg_312_1.time_ = 0
		arg_312_1.frameCnt_ = 0
		arg_312_1.state_ = "playing"
		arg_312_1.curTalkId_ = 121421077
		arg_312_1.duration_ = 8.77

		local var_312_0 = {
			ja = 8.766,
			ko = 7.9,
			zh = 7.9
		}
		local var_312_1 = manager.audio:GetLocalizationFlag()

		if var_312_0[var_312_1] ~= nil then
			arg_312_1.duration_ = var_312_0[var_312_1]
		end

		SetActive(arg_312_1.tipsGo_, false)

		function arg_312_1.onSingleLineFinish_()
			arg_312_1.onSingleLineUpdate_ = nil
			arg_312_1.onSingleLineFinish_ = nil
			arg_312_1.state_ = "waiting"
		end

		function arg_312_1.playNext_(arg_314_0)
			if arg_314_0 == 1 then
				arg_312_0:Play121421078(arg_312_1)
			end
		end

		function arg_312_1.onSingleLineUpdate_(arg_315_0)
			local var_315_0 = arg_312_1.actors_["1084ui_story"].transform
			local var_315_1 = 0

			if var_315_1 < arg_312_1.time_ and arg_312_1.time_ <= var_315_1 + arg_315_0 then
				arg_312_1.var_.moveOldPos1084ui_story = var_315_0.localPosition
			end

			local var_315_2 = 0.001

			if var_315_1 <= arg_312_1.time_ and arg_312_1.time_ < var_315_1 + var_315_2 then
				local var_315_3 = (arg_312_1.time_ - var_315_1) / var_315_2
				local var_315_4 = Vector3.New(0, -0.97, -6)

				var_315_0.localPosition = Vector3.Lerp(arg_312_1.var_.moveOldPos1084ui_story, var_315_4, var_315_3)

				local var_315_5 = manager.ui.mainCamera.transform.position - var_315_0.position

				var_315_0.forward = Vector3.New(var_315_5.x, var_315_5.y, var_315_5.z)

				local var_315_6 = var_315_0.localEulerAngles

				var_315_6.z = 0
				var_315_6.x = 0
				var_315_0.localEulerAngles = var_315_6
			end

			if arg_312_1.time_ >= var_315_1 + var_315_2 and arg_312_1.time_ < var_315_1 + var_315_2 + arg_315_0 then
				var_315_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_315_7 = manager.ui.mainCamera.transform.position - var_315_0.position

				var_315_0.forward = Vector3.New(var_315_7.x, var_315_7.y, var_315_7.z)

				local var_315_8 = var_315_0.localEulerAngles

				var_315_8.z = 0
				var_315_8.x = 0
				var_315_0.localEulerAngles = var_315_8
			end

			local var_315_9 = arg_312_1.actors_["1084ui_story"]
			local var_315_10 = 0

			if var_315_10 < arg_312_1.time_ and arg_312_1.time_ <= var_315_10 + arg_315_0 and not isNil(var_315_9) and arg_312_1.var_.characterEffect1084ui_story == nil then
				arg_312_1.var_.characterEffect1084ui_story = var_315_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_315_11 = 0.200000002980232

			if var_315_10 <= arg_312_1.time_ and arg_312_1.time_ < var_315_10 + var_315_11 and not isNil(var_315_9) then
				local var_315_12 = (arg_312_1.time_ - var_315_10) / var_315_11

				if arg_312_1.var_.characterEffect1084ui_story and not isNil(var_315_9) then
					arg_312_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_312_1.time_ >= var_315_10 + var_315_11 and arg_312_1.time_ < var_315_10 + var_315_11 + arg_315_0 and not isNil(var_315_9) and arg_312_1.var_.characterEffect1084ui_story then
				arg_312_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_315_13 = 0

			if var_315_13 < arg_312_1.time_ and arg_312_1.time_ <= var_315_13 + arg_315_0 then
				arg_312_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_315_14 = 0

			if var_315_14 < arg_312_1.time_ and arg_312_1.time_ <= var_315_14 + arg_315_0 then
				arg_312_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_315_15 = 0
			local var_315_16 = 1.075

			if var_315_15 < arg_312_1.time_ and arg_312_1.time_ <= var_315_15 + arg_315_0 then
				arg_312_1.talkMaxDuration = 0
				arg_312_1.dialogCg_.alpha = 1

				arg_312_1.dialog_:SetActive(true)
				SetActive(arg_312_1.leftNameGo_, true)

				local var_315_17 = arg_312_1:FormatText(StoryNameCfg[6].name)

				arg_312_1.leftNameTxt_.text = var_315_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_312_1.leftNameTxt_.transform)

				arg_312_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_312_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_312_1:RecordName(arg_312_1.leftNameTxt_.text)
				SetActive(arg_312_1.iconTrs_.gameObject, false)
				arg_312_1.callingController_:SetSelectedState("normal")

				local var_315_18 = arg_312_1:GetWordFromCfg(121421077)
				local var_315_19 = arg_312_1:FormatText(var_315_18.content)

				arg_312_1.text_.text = var_315_19

				LuaForUtil.ClearLinePrefixSymbol(arg_312_1.text_)

				local var_315_20 = 43
				local var_315_21 = utf8.len(var_315_19)
				local var_315_22 = var_315_20 <= 0 and var_315_16 or var_315_16 * (var_315_21 / var_315_20)

				if var_315_22 > 0 and var_315_16 < var_315_22 then
					arg_312_1.talkMaxDuration = var_315_22

					if var_315_22 + var_315_15 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_22 + var_315_15
					end
				end

				arg_312_1.text_.text = var_315_19
				arg_312_1.typewritter.percent = 0

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121421", "121421077", "story_v_out_121421.awb") ~= 0 then
					local var_315_23 = manager.audio:GetVoiceLength("story_v_out_121421", "121421077", "story_v_out_121421.awb") / 1000

					if var_315_23 + var_315_15 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_23 + var_315_15
					end

					if var_315_18.prefab_name ~= "" and arg_312_1.actors_[var_315_18.prefab_name] ~= nil then
						local var_315_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_312_1.actors_[var_315_18.prefab_name].transform, "story_v_out_121421", "121421077", "story_v_out_121421.awb")

						arg_312_1:RecordAudio("121421077", var_315_24)
						arg_312_1:RecordAudio("121421077", var_315_24)
					else
						arg_312_1:AudioAction("play", "voice", "story_v_out_121421", "121421077", "story_v_out_121421.awb")
					end

					arg_312_1:RecordHistoryTalkVoice("story_v_out_121421", "121421077", "story_v_out_121421.awb")
				end

				arg_312_1:RecordContent(arg_312_1.text_.text)
			end

			local var_315_25 = math.max(var_315_16, arg_312_1.talkMaxDuration)

			if var_315_15 <= arg_312_1.time_ and arg_312_1.time_ < var_315_15 + var_315_25 then
				arg_312_1.typewritter.percent = (arg_312_1.time_ - var_315_15) / var_315_25

				arg_312_1.typewritter:SetDirty()
			end

			if arg_312_1.time_ >= var_315_15 + var_315_25 and arg_312_1.time_ < var_315_15 + var_315_25 + arg_315_0 then
				arg_312_1.typewritter.percent = 1

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(true)
			end
		end

		arg_312_1.nodeConfigList_ = {
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

		arg_312_1:InitPlayNodeList()
	end,
	Play121421078 = function(arg_316_0, arg_316_1)
		arg_316_1.time_ = 0
		arg_316_1.frameCnt_ = 0
		arg_316_1.state_ = "playing"
		arg_316_1.curTalkId_ = 121421078
		arg_316_1.duration_ = 5

		SetActive(arg_316_1.tipsGo_, false)

		function arg_316_1.onSingleLineFinish_()
			arg_316_1.onSingleLineUpdate_ = nil
			arg_316_1.onSingleLineFinish_ = nil
			arg_316_1.state_ = "waiting"
		end

		function arg_316_1.playNext_(arg_318_0)
			if arg_318_0 == 1 then
				arg_316_0:Play121421079(arg_316_1)
			end
		end

		function arg_316_1.onSingleLineUpdate_(arg_319_0)
			local var_319_0 = arg_316_1.actors_["1084ui_story"]
			local var_319_1 = 0

			if var_319_1 < arg_316_1.time_ and arg_316_1.time_ <= var_319_1 + arg_319_0 and not isNil(var_319_0) and arg_316_1.var_.characterEffect1084ui_story == nil then
				arg_316_1.var_.characterEffect1084ui_story = var_319_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_319_2 = 0.200000002980232

			if var_319_1 <= arg_316_1.time_ and arg_316_1.time_ < var_319_1 + var_319_2 and not isNil(var_319_0) then
				local var_319_3 = (arg_316_1.time_ - var_319_1) / var_319_2

				if arg_316_1.var_.characterEffect1084ui_story and not isNil(var_319_0) then
					local var_319_4 = Mathf.Lerp(0, 0.5, var_319_3)

					arg_316_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_316_1.var_.characterEffect1084ui_story.fillRatio = var_319_4
				end
			end

			if arg_316_1.time_ >= var_319_1 + var_319_2 and arg_316_1.time_ < var_319_1 + var_319_2 + arg_319_0 and not isNil(var_319_0) and arg_316_1.var_.characterEffect1084ui_story then
				local var_319_5 = 0.5

				arg_316_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_316_1.var_.characterEffect1084ui_story.fillRatio = var_319_5
			end

			local var_319_6 = 0
			local var_319_7 = 0.675

			if var_319_6 < arg_316_1.time_ and arg_316_1.time_ <= var_319_6 + arg_319_0 then
				arg_316_1.talkMaxDuration = 0
				arg_316_1.dialogCg_.alpha = 1

				arg_316_1.dialog_:SetActive(true)
				SetActive(arg_316_1.leftNameGo_, true)

				local var_319_8 = arg_316_1:FormatText(StoryNameCfg[7].name)

				arg_316_1.leftNameTxt_.text = var_319_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_316_1.leftNameTxt_.transform)

				arg_316_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_316_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_316_1:RecordName(arg_316_1.leftNameTxt_.text)
				SetActive(arg_316_1.iconTrs_.gameObject, true)
				arg_316_1.iconController_:SetSelectedState("hero")

				arg_316_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_316_1.callingController_:SetSelectedState("normal")

				arg_316_1.keyicon_.color = Color.New(1, 1, 1)
				arg_316_1.icon_.color = Color.New(1, 1, 1)

				local var_319_9 = arg_316_1:GetWordFromCfg(121421078)
				local var_319_10 = arg_316_1:FormatText(var_319_9.content)

				arg_316_1.text_.text = var_319_10

				LuaForUtil.ClearLinePrefixSymbol(arg_316_1.text_)

				local var_319_11 = 27
				local var_319_12 = utf8.len(var_319_10)
				local var_319_13 = var_319_11 <= 0 and var_319_7 or var_319_7 * (var_319_12 / var_319_11)

				if var_319_13 > 0 and var_319_7 < var_319_13 then
					arg_316_1.talkMaxDuration = var_319_13

					if var_319_13 + var_319_6 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_13 + var_319_6
					end
				end

				arg_316_1.text_.text = var_319_10
				arg_316_1.typewritter.percent = 0

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(false)
				arg_316_1:RecordContent(arg_316_1.text_.text)
			end

			local var_319_14 = math.max(var_319_7, arg_316_1.talkMaxDuration)

			if var_319_6 <= arg_316_1.time_ and arg_316_1.time_ < var_319_6 + var_319_14 then
				arg_316_1.typewritter.percent = (arg_316_1.time_ - var_319_6) / var_319_14

				arg_316_1.typewritter:SetDirty()
			end

			if arg_316_1.time_ >= var_319_6 + var_319_14 and arg_316_1.time_ < var_319_6 + var_319_14 + arg_319_0 then
				arg_316_1.typewritter.percent = 1

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(true)
			end
		end

		arg_316_1.nodeConfigList_ = {}

		arg_316_1:InitPlayNodeList()
	end,
	Play121421079 = function(arg_320_0, arg_320_1)
		arg_320_1.time_ = 0
		arg_320_1.frameCnt_ = 0
		arg_320_1.state_ = "playing"
		arg_320_1.curTalkId_ = 121421079
		arg_320_1.duration_ = 13.1

		local var_320_0 = {
			ja = 13.1,
			ko = 10.9,
			zh = 10.9
		}
		local var_320_1 = manager.audio:GetLocalizationFlag()

		if var_320_0[var_320_1] ~= nil then
			arg_320_1.duration_ = var_320_0[var_320_1]
		end

		SetActive(arg_320_1.tipsGo_, false)

		function arg_320_1.onSingleLineFinish_()
			arg_320_1.onSingleLineUpdate_ = nil
			arg_320_1.onSingleLineFinish_ = nil
			arg_320_1.state_ = "waiting"
		end

		function arg_320_1.playNext_(arg_322_0)
			if arg_322_0 == 1 then
				arg_320_0:Play121421080(arg_320_1)
			end
		end

		function arg_320_1.onSingleLineUpdate_(arg_323_0)
			local var_323_0 = arg_320_1.actors_["1084ui_story"]
			local var_323_1 = 0

			if var_323_1 < arg_320_1.time_ and arg_320_1.time_ <= var_323_1 + arg_323_0 and not isNil(var_323_0) and arg_320_1.var_.characterEffect1084ui_story == nil then
				arg_320_1.var_.characterEffect1084ui_story = var_323_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_323_2 = 0.200000002980232

			if var_323_1 <= arg_320_1.time_ and arg_320_1.time_ < var_323_1 + var_323_2 and not isNil(var_323_0) then
				local var_323_3 = (arg_320_1.time_ - var_323_1) / var_323_2

				if arg_320_1.var_.characterEffect1084ui_story and not isNil(var_323_0) then
					arg_320_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_320_1.time_ >= var_323_1 + var_323_2 and arg_320_1.time_ < var_323_1 + var_323_2 + arg_323_0 and not isNil(var_323_0) and arg_320_1.var_.characterEffect1084ui_story then
				arg_320_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_323_4 = 0

			if var_323_4 < arg_320_1.time_ and arg_320_1.time_ <= var_323_4 + arg_323_0 then
				arg_320_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_1")
			end

			local var_323_5 = 0

			if var_323_5 < arg_320_1.time_ and arg_320_1.time_ <= var_323_5 + arg_323_0 then
				arg_320_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_323_6 = 0
			local var_323_7 = 1.325

			if var_323_6 < arg_320_1.time_ and arg_320_1.time_ <= var_323_6 + arg_323_0 then
				arg_320_1.talkMaxDuration = 0
				arg_320_1.dialogCg_.alpha = 1

				arg_320_1.dialog_:SetActive(true)
				SetActive(arg_320_1.leftNameGo_, true)

				local var_323_8 = arg_320_1:FormatText(StoryNameCfg[6].name)

				arg_320_1.leftNameTxt_.text = var_323_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_320_1.leftNameTxt_.transform)

				arg_320_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_320_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_320_1:RecordName(arg_320_1.leftNameTxt_.text)
				SetActive(arg_320_1.iconTrs_.gameObject, false)
				arg_320_1.callingController_:SetSelectedState("normal")

				local var_323_9 = arg_320_1:GetWordFromCfg(121421079)
				local var_323_10 = arg_320_1:FormatText(var_323_9.content)

				arg_320_1.text_.text = var_323_10

				LuaForUtil.ClearLinePrefixSymbol(arg_320_1.text_)

				local var_323_11 = 53
				local var_323_12 = utf8.len(var_323_10)
				local var_323_13 = var_323_11 <= 0 and var_323_7 or var_323_7 * (var_323_12 / var_323_11)

				if var_323_13 > 0 and var_323_7 < var_323_13 then
					arg_320_1.talkMaxDuration = var_323_13

					if var_323_13 + var_323_6 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_13 + var_323_6
					end
				end

				arg_320_1.text_.text = var_323_10
				arg_320_1.typewritter.percent = 0

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121421", "121421079", "story_v_out_121421.awb") ~= 0 then
					local var_323_14 = manager.audio:GetVoiceLength("story_v_out_121421", "121421079", "story_v_out_121421.awb") / 1000

					if var_323_14 + var_323_6 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_14 + var_323_6
					end

					if var_323_9.prefab_name ~= "" and arg_320_1.actors_[var_323_9.prefab_name] ~= nil then
						local var_323_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_320_1.actors_[var_323_9.prefab_name].transform, "story_v_out_121421", "121421079", "story_v_out_121421.awb")

						arg_320_1:RecordAudio("121421079", var_323_15)
						arg_320_1:RecordAudio("121421079", var_323_15)
					else
						arg_320_1:AudioAction("play", "voice", "story_v_out_121421", "121421079", "story_v_out_121421.awb")
					end

					arg_320_1:RecordHistoryTalkVoice("story_v_out_121421", "121421079", "story_v_out_121421.awb")
				end

				arg_320_1:RecordContent(arg_320_1.text_.text)
			end

			local var_323_16 = math.max(var_323_7, arg_320_1.talkMaxDuration)

			if var_323_6 <= arg_320_1.time_ and arg_320_1.time_ < var_323_6 + var_323_16 then
				arg_320_1.typewritter.percent = (arg_320_1.time_ - var_323_6) / var_323_16

				arg_320_1.typewritter:SetDirty()
			end

			if arg_320_1.time_ >= var_323_6 + var_323_16 and arg_320_1.time_ < var_323_6 + var_323_16 + arg_323_0 then
				arg_320_1.typewritter.percent = 1

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(true)
			end
		end

		arg_320_1.nodeConfigList_ = {}

		arg_320_1:InitPlayNodeList()
	end,
	Play121421080 = function(arg_324_0, arg_324_1)
		arg_324_1.time_ = 0
		arg_324_1.frameCnt_ = 0
		arg_324_1.state_ = "playing"
		arg_324_1.curTalkId_ = 121421080
		arg_324_1.duration_ = 5

		SetActive(arg_324_1.tipsGo_, false)

		function arg_324_1.onSingleLineFinish_()
			arg_324_1.onSingleLineUpdate_ = nil
			arg_324_1.onSingleLineFinish_ = nil
			arg_324_1.state_ = "waiting"
		end

		function arg_324_1.playNext_(arg_326_0)
			if arg_326_0 == 1 then
				arg_324_0:Play121421081(arg_324_1)
			end
		end

		function arg_324_1.onSingleLineUpdate_(arg_327_0)
			local var_327_0 = arg_324_1.actors_["1084ui_story"]
			local var_327_1 = 0

			if var_327_1 < arg_324_1.time_ and arg_324_1.time_ <= var_327_1 + arg_327_0 and not isNil(var_327_0) and arg_324_1.var_.characterEffect1084ui_story == nil then
				arg_324_1.var_.characterEffect1084ui_story = var_327_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_327_2 = 0.200000002980232

			if var_327_1 <= arg_324_1.time_ and arg_324_1.time_ < var_327_1 + var_327_2 and not isNil(var_327_0) then
				local var_327_3 = (arg_324_1.time_ - var_327_1) / var_327_2

				if arg_324_1.var_.characterEffect1084ui_story and not isNil(var_327_0) then
					local var_327_4 = Mathf.Lerp(0, 0.5, var_327_3)

					arg_324_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_324_1.var_.characterEffect1084ui_story.fillRatio = var_327_4
				end
			end

			if arg_324_1.time_ >= var_327_1 + var_327_2 and arg_324_1.time_ < var_327_1 + var_327_2 + arg_327_0 and not isNil(var_327_0) and arg_324_1.var_.characterEffect1084ui_story then
				local var_327_5 = 0.5

				arg_324_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_324_1.var_.characterEffect1084ui_story.fillRatio = var_327_5
			end

			local var_327_6 = 0
			local var_327_7 = 0.75

			if var_327_6 < arg_324_1.time_ and arg_324_1.time_ <= var_327_6 + arg_327_0 then
				arg_324_1.talkMaxDuration = 0
				arg_324_1.dialogCg_.alpha = 1

				arg_324_1.dialog_:SetActive(true)
				SetActive(arg_324_1.leftNameGo_, true)

				local var_327_8 = arg_324_1:FormatText(StoryNameCfg[7].name)

				arg_324_1.leftNameTxt_.text = var_327_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_324_1.leftNameTxt_.transform)

				arg_324_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_324_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_324_1:RecordName(arg_324_1.leftNameTxt_.text)
				SetActive(arg_324_1.iconTrs_.gameObject, true)
				arg_324_1.iconController_:SetSelectedState("hero")

				arg_324_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_324_1.callingController_:SetSelectedState("normal")

				arg_324_1.keyicon_.color = Color.New(1, 1, 1)
				arg_324_1.icon_.color = Color.New(1, 1, 1)

				local var_327_9 = arg_324_1:GetWordFromCfg(121421080)
				local var_327_10 = arg_324_1:FormatText(var_327_9.content)

				arg_324_1.text_.text = var_327_10

				LuaForUtil.ClearLinePrefixSymbol(arg_324_1.text_)

				local var_327_11 = 30
				local var_327_12 = utf8.len(var_327_10)
				local var_327_13 = var_327_11 <= 0 and var_327_7 or var_327_7 * (var_327_12 / var_327_11)

				if var_327_13 > 0 and var_327_7 < var_327_13 then
					arg_324_1.talkMaxDuration = var_327_13

					if var_327_13 + var_327_6 > arg_324_1.duration_ then
						arg_324_1.duration_ = var_327_13 + var_327_6
					end
				end

				arg_324_1.text_.text = var_327_10
				arg_324_1.typewritter.percent = 0

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(false)
				arg_324_1:RecordContent(arg_324_1.text_.text)
			end

			local var_327_14 = math.max(var_327_7, arg_324_1.talkMaxDuration)

			if var_327_6 <= arg_324_1.time_ and arg_324_1.time_ < var_327_6 + var_327_14 then
				arg_324_1.typewritter.percent = (arg_324_1.time_ - var_327_6) / var_327_14

				arg_324_1.typewritter:SetDirty()
			end

			if arg_324_1.time_ >= var_327_6 + var_327_14 and arg_324_1.time_ < var_327_6 + var_327_14 + arg_327_0 then
				arg_324_1.typewritter.percent = 1

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(true)
			end
		end

		arg_324_1.nodeConfigList_ = {}

		arg_324_1:InitPlayNodeList()
	end,
	Play121421081 = function(arg_328_0, arg_328_1)
		arg_328_1.time_ = 0
		arg_328_1.frameCnt_ = 0
		arg_328_1.state_ = "playing"
		arg_328_1.curTalkId_ = 121421081
		arg_328_1.duration_ = 5

		SetActive(arg_328_1.tipsGo_, false)

		function arg_328_1.onSingleLineFinish_()
			arg_328_1.onSingleLineUpdate_ = nil
			arg_328_1.onSingleLineFinish_ = nil
			arg_328_1.state_ = "waiting"
		end

		function arg_328_1.playNext_(arg_330_0)
			if arg_330_0 == 1 then
				arg_328_0:Play121421082(arg_328_1)
			end
		end

		function arg_328_1.onSingleLineUpdate_(arg_331_0)
			local var_331_0 = 0
			local var_331_1 = 0.325

			if var_331_0 < arg_328_1.time_ and arg_328_1.time_ <= var_331_0 + arg_331_0 then
				arg_328_1.talkMaxDuration = 0
				arg_328_1.dialogCg_.alpha = 1

				arg_328_1.dialog_:SetActive(true)
				SetActive(arg_328_1.leftNameGo_, true)

				local var_331_2 = arg_328_1:FormatText(StoryNameCfg[7].name)

				arg_328_1.leftNameTxt_.text = var_331_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_328_1.leftNameTxt_.transform)

				arg_328_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_328_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_328_1:RecordName(arg_328_1.leftNameTxt_.text)
				SetActive(arg_328_1.iconTrs_.gameObject, true)
				arg_328_1.iconController_:SetSelectedState("hero")

				arg_328_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_328_1.callingController_:SetSelectedState("normal")

				arg_328_1.keyicon_.color = Color.New(1, 1, 1)
				arg_328_1.icon_.color = Color.New(1, 1, 1)

				local var_331_3 = arg_328_1:GetWordFromCfg(121421081)
				local var_331_4 = arg_328_1:FormatText(var_331_3.content)

				arg_328_1.text_.text = var_331_4

				LuaForUtil.ClearLinePrefixSymbol(arg_328_1.text_)

				local var_331_5 = 13
				local var_331_6 = utf8.len(var_331_4)
				local var_331_7 = var_331_5 <= 0 and var_331_1 or var_331_1 * (var_331_6 / var_331_5)

				if var_331_7 > 0 and var_331_1 < var_331_7 then
					arg_328_1.talkMaxDuration = var_331_7

					if var_331_7 + var_331_0 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_7 + var_331_0
					end
				end

				arg_328_1.text_.text = var_331_4
				arg_328_1.typewritter.percent = 0

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(false)
				arg_328_1:RecordContent(arg_328_1.text_.text)
			end

			local var_331_8 = math.max(var_331_1, arg_328_1.talkMaxDuration)

			if var_331_0 <= arg_328_1.time_ and arg_328_1.time_ < var_331_0 + var_331_8 then
				arg_328_1.typewritter.percent = (arg_328_1.time_ - var_331_0) / var_331_8

				arg_328_1.typewritter:SetDirty()
			end

			if arg_328_1.time_ >= var_331_0 + var_331_8 and arg_328_1.time_ < var_331_0 + var_331_8 + arg_331_0 then
				arg_328_1.typewritter.percent = 1

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(true)
			end
		end

		arg_328_1.nodeConfigList_ = {}

		arg_328_1:InitPlayNodeList()
	end,
	Play121421082 = function(arg_332_0, arg_332_1)
		arg_332_1.time_ = 0
		arg_332_1.frameCnt_ = 0
		arg_332_1.state_ = "playing"
		arg_332_1.curTalkId_ = 121421082
		arg_332_1.duration_ = 4.73

		local var_332_0 = {
			ja = 4.733,
			ko = 2.666,
			zh = 2.666
		}
		local var_332_1 = manager.audio:GetLocalizationFlag()

		if var_332_0[var_332_1] ~= nil then
			arg_332_1.duration_ = var_332_0[var_332_1]
		end

		SetActive(arg_332_1.tipsGo_, false)

		function arg_332_1.onSingleLineFinish_()
			arg_332_1.onSingleLineUpdate_ = nil
			arg_332_1.onSingleLineFinish_ = nil
			arg_332_1.state_ = "waiting"
		end

		function arg_332_1.playNext_(arg_334_0)
			if arg_334_0 == 1 then
				arg_332_0:Play121421083(arg_332_1)
			end
		end

		function arg_332_1.onSingleLineUpdate_(arg_335_0)
			local var_335_0 = arg_332_1.actors_["1084ui_story"].transform
			local var_335_1 = 0

			if var_335_1 < arg_332_1.time_ and arg_332_1.time_ <= var_335_1 + arg_335_0 then
				arg_332_1.var_.moveOldPos1084ui_story = var_335_0.localPosition
			end

			local var_335_2 = 0.001

			if var_335_1 <= arg_332_1.time_ and arg_332_1.time_ < var_335_1 + var_335_2 then
				local var_335_3 = (arg_332_1.time_ - var_335_1) / var_335_2
				local var_335_4 = Vector3.New(0, 100, 0)

				var_335_0.localPosition = Vector3.Lerp(arg_332_1.var_.moveOldPos1084ui_story, var_335_4, var_335_3)

				local var_335_5 = manager.ui.mainCamera.transform.position - var_335_0.position

				var_335_0.forward = Vector3.New(var_335_5.x, var_335_5.y, var_335_5.z)

				local var_335_6 = var_335_0.localEulerAngles

				var_335_6.z = 0
				var_335_6.x = 0
				var_335_0.localEulerAngles = var_335_6
			end

			if arg_332_1.time_ >= var_335_1 + var_335_2 and arg_332_1.time_ < var_335_1 + var_335_2 + arg_335_0 then
				var_335_0.localPosition = Vector3.New(0, 100, 0)

				local var_335_7 = manager.ui.mainCamera.transform.position - var_335_0.position

				var_335_0.forward = Vector3.New(var_335_7.x, var_335_7.y, var_335_7.z)

				local var_335_8 = var_335_0.localEulerAngles

				var_335_8.z = 0
				var_335_8.x = 0
				var_335_0.localEulerAngles = var_335_8
			end

			local var_335_9 = arg_332_1.actors_["1084ui_story"]
			local var_335_10 = 0

			if var_335_10 < arg_332_1.time_ and arg_332_1.time_ <= var_335_10 + arg_335_0 and not isNil(var_335_9) and arg_332_1.var_.characterEffect1084ui_story == nil then
				arg_332_1.var_.characterEffect1084ui_story = var_335_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_335_11 = 0.200000002980232

			if var_335_10 <= arg_332_1.time_ and arg_332_1.time_ < var_335_10 + var_335_11 and not isNil(var_335_9) then
				local var_335_12 = (arg_332_1.time_ - var_335_10) / var_335_11

				if arg_332_1.var_.characterEffect1084ui_story and not isNil(var_335_9) then
					local var_335_13 = Mathf.Lerp(0, 0.5, var_335_12)

					arg_332_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_332_1.var_.characterEffect1084ui_story.fillRatio = var_335_13
				end
			end

			if arg_332_1.time_ >= var_335_10 + var_335_11 and arg_332_1.time_ < var_335_10 + var_335_11 + arg_335_0 and not isNil(var_335_9) and arg_332_1.var_.characterEffect1084ui_story then
				local var_335_14 = 0.5

				arg_332_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_332_1.var_.characterEffect1084ui_story.fillRatio = var_335_14
			end

			local var_335_15 = arg_332_1.actors_["1072ui_story"].transform
			local var_335_16 = 0

			if var_335_16 < arg_332_1.time_ and arg_332_1.time_ <= var_335_16 + arg_335_0 then
				arg_332_1.var_.moveOldPos1072ui_story = var_335_15.localPosition
			end

			local var_335_17 = 0.001

			if var_335_16 <= arg_332_1.time_ and arg_332_1.time_ < var_335_16 + var_335_17 then
				local var_335_18 = (arg_332_1.time_ - var_335_16) / var_335_17
				local var_335_19 = Vector3.New(0, -0.71, -6)

				var_335_15.localPosition = Vector3.Lerp(arg_332_1.var_.moveOldPos1072ui_story, var_335_19, var_335_18)

				local var_335_20 = manager.ui.mainCamera.transform.position - var_335_15.position

				var_335_15.forward = Vector3.New(var_335_20.x, var_335_20.y, var_335_20.z)

				local var_335_21 = var_335_15.localEulerAngles

				var_335_21.z = 0
				var_335_21.x = 0
				var_335_15.localEulerAngles = var_335_21
			end

			if arg_332_1.time_ >= var_335_16 + var_335_17 and arg_332_1.time_ < var_335_16 + var_335_17 + arg_335_0 then
				var_335_15.localPosition = Vector3.New(0, -0.71, -6)

				local var_335_22 = manager.ui.mainCamera.transform.position - var_335_15.position

				var_335_15.forward = Vector3.New(var_335_22.x, var_335_22.y, var_335_22.z)

				local var_335_23 = var_335_15.localEulerAngles

				var_335_23.z = 0
				var_335_23.x = 0
				var_335_15.localEulerAngles = var_335_23
			end

			local var_335_24 = arg_332_1.actors_["1072ui_story"]
			local var_335_25 = 0

			if var_335_25 < arg_332_1.time_ and arg_332_1.time_ <= var_335_25 + arg_335_0 and not isNil(var_335_24) and arg_332_1.var_.characterEffect1072ui_story == nil then
				arg_332_1.var_.characterEffect1072ui_story = var_335_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_335_26 = 0.200000002980232

			if var_335_25 <= arg_332_1.time_ and arg_332_1.time_ < var_335_25 + var_335_26 and not isNil(var_335_24) then
				local var_335_27 = (arg_332_1.time_ - var_335_25) / var_335_26

				if arg_332_1.var_.characterEffect1072ui_story and not isNil(var_335_24) then
					arg_332_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_332_1.time_ >= var_335_25 + var_335_26 and arg_332_1.time_ < var_335_25 + var_335_26 + arg_335_0 and not isNil(var_335_24) and arg_332_1.var_.characterEffect1072ui_story then
				arg_332_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_335_28 = 0

			if var_335_28 < arg_332_1.time_ and arg_332_1.time_ <= var_335_28 + arg_335_0 then
				arg_332_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action1_1")
			end

			local var_335_29 = 0

			if var_335_29 < arg_332_1.time_ and arg_332_1.time_ <= var_335_29 + arg_335_0 then
				arg_332_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_335_30 = 0
			local var_335_31 = 0.125

			if var_335_30 < arg_332_1.time_ and arg_332_1.time_ <= var_335_30 + arg_335_0 then
				arg_332_1.talkMaxDuration = 0
				arg_332_1.dialogCg_.alpha = 1

				arg_332_1.dialog_:SetActive(true)
				SetActive(arg_332_1.leftNameGo_, true)

				local var_335_32 = arg_332_1:FormatText(StoryNameCfg[379].name)

				arg_332_1.leftNameTxt_.text = var_335_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_332_1.leftNameTxt_.transform)

				arg_332_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_332_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_332_1:RecordName(arg_332_1.leftNameTxt_.text)
				SetActive(arg_332_1.iconTrs_.gameObject, false)
				arg_332_1.callingController_:SetSelectedState("normal")

				local var_335_33 = arg_332_1:GetWordFromCfg(121421082)
				local var_335_34 = arg_332_1:FormatText(var_335_33.content)

				arg_332_1.text_.text = var_335_34

				LuaForUtil.ClearLinePrefixSymbol(arg_332_1.text_)

				local var_335_35 = 5
				local var_335_36 = utf8.len(var_335_34)
				local var_335_37 = var_335_35 <= 0 and var_335_31 or var_335_31 * (var_335_36 / var_335_35)

				if var_335_37 > 0 and var_335_31 < var_335_37 then
					arg_332_1.talkMaxDuration = var_335_37

					if var_335_37 + var_335_30 > arg_332_1.duration_ then
						arg_332_1.duration_ = var_335_37 + var_335_30
					end
				end

				arg_332_1.text_.text = var_335_34
				arg_332_1.typewritter.percent = 0

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121421", "121421082", "story_v_out_121421.awb") ~= 0 then
					local var_335_38 = manager.audio:GetVoiceLength("story_v_out_121421", "121421082", "story_v_out_121421.awb") / 1000

					if var_335_38 + var_335_30 > arg_332_1.duration_ then
						arg_332_1.duration_ = var_335_38 + var_335_30
					end

					if var_335_33.prefab_name ~= "" and arg_332_1.actors_[var_335_33.prefab_name] ~= nil then
						local var_335_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_332_1.actors_[var_335_33.prefab_name].transform, "story_v_out_121421", "121421082", "story_v_out_121421.awb")

						arg_332_1:RecordAudio("121421082", var_335_39)
						arg_332_1:RecordAudio("121421082", var_335_39)
					else
						arg_332_1:AudioAction("play", "voice", "story_v_out_121421", "121421082", "story_v_out_121421.awb")
					end

					arg_332_1:RecordHistoryTalkVoice("story_v_out_121421", "121421082", "story_v_out_121421.awb")
				end

				arg_332_1:RecordContent(arg_332_1.text_.text)
			end

			local var_335_40 = math.max(var_335_31, arg_332_1.talkMaxDuration)

			if var_335_30 <= arg_332_1.time_ and arg_332_1.time_ < var_335_30 + var_335_40 then
				arg_332_1.typewritter.percent = (arg_332_1.time_ - var_335_30) / var_335_40

				arg_332_1.typewritter:SetDirty()
			end

			if arg_332_1.time_ >= var_335_30 + var_335_40 and arg_332_1.time_ < var_335_30 + var_335_40 + arg_335_0 then
				arg_332_1.typewritter.percent = 1

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(true)
			end
		end

		arg_332_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_332_1:InitPlayNodeList()
	end,
	Play121421083 = function(arg_336_0, arg_336_1)
		arg_336_1.time_ = 0
		arg_336_1.frameCnt_ = 0
		arg_336_1.state_ = "playing"
		arg_336_1.curTalkId_ = 121421083
		arg_336_1.duration_ = 5

		SetActive(arg_336_1.tipsGo_, false)

		function arg_336_1.onSingleLineFinish_()
			arg_336_1.onSingleLineUpdate_ = nil
			arg_336_1.onSingleLineFinish_ = nil
			arg_336_1.state_ = "waiting"
		end

		function arg_336_1.playNext_(arg_338_0)
			if arg_338_0 == 1 then
				arg_336_0:Play121421084(arg_336_1)
			end
		end

		function arg_336_1.onSingleLineUpdate_(arg_339_0)
			local var_339_0 = arg_336_1.actors_["1072ui_story"]
			local var_339_1 = 0

			if var_339_1 < arg_336_1.time_ and arg_336_1.time_ <= var_339_1 + arg_339_0 and not isNil(var_339_0) and arg_336_1.var_.characterEffect1072ui_story == nil then
				arg_336_1.var_.characterEffect1072ui_story = var_339_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_339_2 = 0.200000002980232

			if var_339_1 <= arg_336_1.time_ and arg_336_1.time_ < var_339_1 + var_339_2 and not isNil(var_339_0) then
				local var_339_3 = (arg_336_1.time_ - var_339_1) / var_339_2

				if arg_336_1.var_.characterEffect1072ui_story and not isNil(var_339_0) then
					local var_339_4 = Mathf.Lerp(0, 0.5, var_339_3)

					arg_336_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_336_1.var_.characterEffect1072ui_story.fillRatio = var_339_4
				end
			end

			if arg_336_1.time_ >= var_339_1 + var_339_2 and arg_336_1.time_ < var_339_1 + var_339_2 + arg_339_0 and not isNil(var_339_0) and arg_336_1.var_.characterEffect1072ui_story then
				local var_339_5 = 0.5

				arg_336_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_336_1.var_.characterEffect1072ui_story.fillRatio = var_339_5
			end

			local var_339_6 = 0
			local var_339_7 = 1.2

			if var_339_6 < arg_336_1.time_ and arg_336_1.time_ <= var_339_6 + arg_339_0 then
				arg_336_1.talkMaxDuration = 0
				arg_336_1.dialogCg_.alpha = 1

				arg_336_1.dialog_:SetActive(true)
				SetActive(arg_336_1.leftNameGo_, false)

				arg_336_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_336_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_336_1:RecordName(arg_336_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_336_1.iconTrs_.gameObject, false)
				arg_336_1.callingController_:SetSelectedState("normal")

				local var_339_8 = arg_336_1:GetWordFromCfg(121421083)
				local var_339_9 = arg_336_1:FormatText(var_339_8.content)

				arg_336_1.text_.text = var_339_9

				LuaForUtil.ClearLinePrefixSymbol(arg_336_1.text_)

				local var_339_10 = 48
				local var_339_11 = utf8.len(var_339_9)
				local var_339_12 = var_339_10 <= 0 and var_339_7 or var_339_7 * (var_339_11 / var_339_10)

				if var_339_12 > 0 and var_339_7 < var_339_12 then
					arg_336_1.talkMaxDuration = var_339_12

					if var_339_12 + var_339_6 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_12 + var_339_6
					end
				end

				arg_336_1.text_.text = var_339_9
				arg_336_1.typewritter.percent = 0

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(false)
				arg_336_1:RecordContent(arg_336_1.text_.text)
			end

			local var_339_13 = math.max(var_339_7, arg_336_1.talkMaxDuration)

			if var_339_6 <= arg_336_1.time_ and arg_336_1.time_ < var_339_6 + var_339_13 then
				arg_336_1.typewritter.percent = (arg_336_1.time_ - var_339_6) / var_339_13

				arg_336_1.typewritter:SetDirty()
			end

			if arg_336_1.time_ >= var_339_6 + var_339_13 and arg_336_1.time_ < var_339_6 + var_339_13 + arg_339_0 then
				arg_336_1.typewritter.percent = 1

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(true)
			end
		end

		arg_336_1.nodeConfigList_ = {}

		arg_336_1:InitPlayNodeList()
	end,
	Play121421084 = function(arg_340_0, arg_340_1)
		arg_340_1.time_ = 0
		arg_340_1.frameCnt_ = 0
		arg_340_1.state_ = "playing"
		arg_340_1.curTalkId_ = 121421084
		arg_340_1.duration_ = 6.53

		local var_340_0 = {
			ja = 3.766,
			ko = 6.533,
			zh = 6.533
		}
		local var_340_1 = manager.audio:GetLocalizationFlag()

		if var_340_0[var_340_1] ~= nil then
			arg_340_1.duration_ = var_340_0[var_340_1]
		end

		SetActive(arg_340_1.tipsGo_, false)

		function arg_340_1.onSingleLineFinish_()
			arg_340_1.onSingleLineUpdate_ = nil
			arg_340_1.onSingleLineFinish_ = nil
			arg_340_1.state_ = "waiting"
		end

		function arg_340_1.playNext_(arg_342_0)
			if arg_342_0 == 1 then
				arg_340_0:Play121421085(arg_340_1)
			end
		end

		function arg_340_1.onSingleLineUpdate_(arg_343_0)
			local var_343_0 = arg_340_1.actors_["1072ui_story"].transform
			local var_343_1 = 0

			if var_343_1 < arg_340_1.time_ and arg_340_1.time_ <= var_343_1 + arg_343_0 then
				arg_340_1.var_.moveOldPos1072ui_story = var_343_0.localPosition
			end

			local var_343_2 = 0.001

			if var_343_1 <= arg_340_1.time_ and arg_340_1.time_ < var_343_1 + var_343_2 then
				local var_343_3 = (arg_340_1.time_ - var_343_1) / var_343_2
				local var_343_4 = Vector3.New(-0.7, -0.71, -6)

				var_343_0.localPosition = Vector3.Lerp(arg_340_1.var_.moveOldPos1072ui_story, var_343_4, var_343_3)

				local var_343_5 = manager.ui.mainCamera.transform.position - var_343_0.position

				var_343_0.forward = Vector3.New(var_343_5.x, var_343_5.y, var_343_5.z)

				local var_343_6 = var_343_0.localEulerAngles

				var_343_6.z = 0
				var_343_6.x = 0
				var_343_0.localEulerAngles = var_343_6
			end

			if arg_340_1.time_ >= var_343_1 + var_343_2 and arg_340_1.time_ < var_343_1 + var_343_2 + arg_343_0 then
				var_343_0.localPosition = Vector3.New(-0.7, -0.71, -6)

				local var_343_7 = manager.ui.mainCamera.transform.position - var_343_0.position

				var_343_0.forward = Vector3.New(var_343_7.x, var_343_7.y, var_343_7.z)

				local var_343_8 = var_343_0.localEulerAngles

				var_343_8.z = 0
				var_343_8.x = 0
				var_343_0.localEulerAngles = var_343_8
			end

			local var_343_9 = arg_340_1.actors_["1072ui_story"]
			local var_343_10 = 0

			if var_343_10 < arg_340_1.time_ and arg_340_1.time_ <= var_343_10 + arg_343_0 and not isNil(var_343_9) and arg_340_1.var_.characterEffect1072ui_story == nil then
				arg_340_1.var_.characterEffect1072ui_story = var_343_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_343_11 = 0.200000002980232

			if var_343_10 <= arg_340_1.time_ and arg_340_1.time_ < var_343_10 + var_343_11 and not isNil(var_343_9) then
				local var_343_12 = (arg_340_1.time_ - var_343_10) / var_343_11

				if arg_340_1.var_.characterEffect1072ui_story and not isNil(var_343_9) then
					arg_340_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_340_1.time_ >= var_343_10 + var_343_11 and arg_340_1.time_ < var_343_10 + var_343_11 + arg_343_0 and not isNil(var_343_9) and arg_340_1.var_.characterEffect1072ui_story then
				arg_340_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_343_13 = 0

			if var_343_13 < arg_340_1.time_ and arg_340_1.time_ <= var_343_13 + arg_343_0 then
				arg_340_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action3_1")
			end

			local var_343_14 = 0

			if var_343_14 < arg_340_1.time_ and arg_340_1.time_ <= var_343_14 + arg_343_0 then
				arg_340_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_343_15 = arg_340_1.actors_["1084ui_story"].transform
			local var_343_16 = 0

			if var_343_16 < arg_340_1.time_ and arg_340_1.time_ <= var_343_16 + arg_343_0 then
				arg_340_1.var_.moveOldPos1084ui_story = var_343_15.localPosition
			end

			local var_343_17 = 0.001

			if var_343_16 <= arg_340_1.time_ and arg_340_1.time_ < var_343_16 + var_343_17 then
				local var_343_18 = (arg_340_1.time_ - var_343_16) / var_343_17
				local var_343_19 = Vector3.New(0.7, -0.97, -6)

				var_343_15.localPosition = Vector3.Lerp(arg_340_1.var_.moveOldPos1084ui_story, var_343_19, var_343_18)

				local var_343_20 = manager.ui.mainCamera.transform.position - var_343_15.position

				var_343_15.forward = Vector3.New(var_343_20.x, var_343_20.y, var_343_20.z)

				local var_343_21 = var_343_15.localEulerAngles

				var_343_21.z = 0
				var_343_21.x = 0
				var_343_15.localEulerAngles = var_343_21
			end

			if arg_340_1.time_ >= var_343_16 + var_343_17 and arg_340_1.time_ < var_343_16 + var_343_17 + arg_343_0 then
				var_343_15.localPosition = Vector3.New(0.7, -0.97, -6)

				local var_343_22 = manager.ui.mainCamera.transform.position - var_343_15.position

				var_343_15.forward = Vector3.New(var_343_22.x, var_343_22.y, var_343_22.z)

				local var_343_23 = var_343_15.localEulerAngles

				var_343_23.z = 0
				var_343_23.x = 0
				var_343_15.localEulerAngles = var_343_23
			end

			local var_343_24 = arg_340_1.actors_["1084ui_story"]
			local var_343_25 = 0

			if var_343_25 < arg_340_1.time_ and arg_340_1.time_ <= var_343_25 + arg_343_0 and not isNil(var_343_24) and arg_340_1.var_.characterEffect1084ui_story == nil then
				arg_340_1.var_.characterEffect1084ui_story = var_343_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_343_26 = 0.200000002980232

			if var_343_25 <= arg_340_1.time_ and arg_340_1.time_ < var_343_25 + var_343_26 and not isNil(var_343_24) then
				local var_343_27 = (arg_340_1.time_ - var_343_25) / var_343_26

				if arg_340_1.var_.characterEffect1084ui_story and not isNil(var_343_24) then
					local var_343_28 = Mathf.Lerp(0, 0.5, var_343_27)

					arg_340_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_340_1.var_.characterEffect1084ui_story.fillRatio = var_343_28
				end
			end

			if arg_340_1.time_ >= var_343_25 + var_343_26 and arg_340_1.time_ < var_343_25 + var_343_26 + arg_343_0 and not isNil(var_343_24) and arg_340_1.var_.characterEffect1084ui_story then
				local var_343_29 = 0.5

				arg_340_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_340_1.var_.characterEffect1084ui_story.fillRatio = var_343_29
			end

			local var_343_30 = 0

			if var_343_30 < arg_340_1.time_ and arg_340_1.time_ <= var_343_30 + arg_343_0 then
				arg_340_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_343_31 = 0
			local var_343_32 = 0.55

			if var_343_31 < arg_340_1.time_ and arg_340_1.time_ <= var_343_31 + arg_343_0 then
				arg_340_1.talkMaxDuration = 0
				arg_340_1.dialogCg_.alpha = 1

				arg_340_1.dialog_:SetActive(true)
				SetActive(arg_340_1.leftNameGo_, true)

				local var_343_33 = arg_340_1:FormatText(StoryNameCfg[379].name)

				arg_340_1.leftNameTxt_.text = var_343_33

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_340_1.leftNameTxt_.transform)

				arg_340_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_340_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_340_1:RecordName(arg_340_1.leftNameTxt_.text)
				SetActive(arg_340_1.iconTrs_.gameObject, false)
				arg_340_1.callingController_:SetSelectedState("normal")

				local var_343_34 = arg_340_1:GetWordFromCfg(121421084)
				local var_343_35 = arg_340_1:FormatText(var_343_34.content)

				arg_340_1.text_.text = var_343_35

				LuaForUtil.ClearLinePrefixSymbol(arg_340_1.text_)

				local var_343_36 = 22
				local var_343_37 = utf8.len(var_343_35)
				local var_343_38 = var_343_36 <= 0 and var_343_32 or var_343_32 * (var_343_37 / var_343_36)

				if var_343_38 > 0 and var_343_32 < var_343_38 then
					arg_340_1.talkMaxDuration = var_343_38

					if var_343_38 + var_343_31 > arg_340_1.duration_ then
						arg_340_1.duration_ = var_343_38 + var_343_31
					end
				end

				arg_340_1.text_.text = var_343_35
				arg_340_1.typewritter.percent = 0

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121421", "121421084", "story_v_out_121421.awb") ~= 0 then
					local var_343_39 = manager.audio:GetVoiceLength("story_v_out_121421", "121421084", "story_v_out_121421.awb") / 1000

					if var_343_39 + var_343_31 > arg_340_1.duration_ then
						arg_340_1.duration_ = var_343_39 + var_343_31
					end

					if var_343_34.prefab_name ~= "" and arg_340_1.actors_[var_343_34.prefab_name] ~= nil then
						local var_343_40 = LuaForUtil.PlayVoiceWithCriLipsync(arg_340_1.actors_[var_343_34.prefab_name].transform, "story_v_out_121421", "121421084", "story_v_out_121421.awb")

						arg_340_1:RecordAudio("121421084", var_343_40)
						arg_340_1:RecordAudio("121421084", var_343_40)
					else
						arg_340_1:AudioAction("play", "voice", "story_v_out_121421", "121421084", "story_v_out_121421.awb")
					end

					arg_340_1:RecordHistoryTalkVoice("story_v_out_121421", "121421084", "story_v_out_121421.awb")
				end

				arg_340_1:RecordContent(arg_340_1.text_.text)
			end

			local var_343_41 = math.max(var_343_32, arg_340_1.talkMaxDuration)

			if var_343_31 <= arg_340_1.time_ and arg_340_1.time_ < var_343_31 + var_343_41 then
				arg_340_1.typewritter.percent = (arg_340_1.time_ - var_343_31) / var_343_41

				arg_340_1.typewritter:SetDirty()
			end

			if arg_340_1.time_ >= var_343_31 + var_343_41 and arg_340_1.time_ < var_343_31 + var_343_41 + arg_343_0 then
				arg_340_1.typewritter.percent = 1

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(true)
			end
		end

		arg_340_1.nodeConfigList_ = {
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
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_340_1:InitPlayNodeList()
	end,
	Play121421085 = function(arg_344_0, arg_344_1)
		arg_344_1.time_ = 0
		arg_344_1.frameCnt_ = 0
		arg_344_1.state_ = "playing"
		arg_344_1.curTalkId_ = 121421085
		arg_344_1.duration_ = 8.07

		local var_344_0 = {
			ja = 8.066,
			ko = 4.6,
			zh = 4.6
		}
		local var_344_1 = manager.audio:GetLocalizationFlag()

		if var_344_0[var_344_1] ~= nil then
			arg_344_1.duration_ = var_344_0[var_344_1]
		end

		SetActive(arg_344_1.tipsGo_, false)

		function arg_344_1.onSingleLineFinish_()
			arg_344_1.onSingleLineUpdate_ = nil
			arg_344_1.onSingleLineFinish_ = nil
			arg_344_1.state_ = "waiting"
		end

		function arg_344_1.playNext_(arg_346_0)
			if arg_346_0 == 1 then
				arg_344_0:Play121421086(arg_344_1)
			end
		end

		function arg_344_1.onSingleLineUpdate_(arg_347_0)
			local var_347_0 = arg_344_1.actors_["1084ui_story"]
			local var_347_1 = 0

			if var_347_1 < arg_344_1.time_ and arg_344_1.time_ <= var_347_1 + arg_347_0 and not isNil(var_347_0) and arg_344_1.var_.characterEffect1084ui_story == nil then
				arg_344_1.var_.characterEffect1084ui_story = var_347_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_347_2 = 0.200000002980232

			if var_347_1 <= arg_344_1.time_ and arg_344_1.time_ < var_347_1 + var_347_2 and not isNil(var_347_0) then
				local var_347_3 = (arg_344_1.time_ - var_347_1) / var_347_2

				if arg_344_1.var_.characterEffect1084ui_story and not isNil(var_347_0) then
					arg_344_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_344_1.time_ >= var_347_1 + var_347_2 and arg_344_1.time_ < var_347_1 + var_347_2 + arg_347_0 and not isNil(var_347_0) and arg_344_1.var_.characterEffect1084ui_story then
				arg_344_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_347_4 = 0

			if var_347_4 < arg_344_1.time_ and arg_344_1.time_ <= var_347_4 + arg_347_0 then
				arg_344_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			local var_347_5 = 0

			if var_347_5 < arg_344_1.time_ and arg_344_1.time_ <= var_347_5 + arg_347_0 then
				arg_344_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_347_6 = arg_344_1.actors_["1072ui_story"]
			local var_347_7 = 0

			if var_347_7 < arg_344_1.time_ and arg_344_1.time_ <= var_347_7 + arg_347_0 and not isNil(var_347_6) and arg_344_1.var_.characterEffect1072ui_story == nil then
				arg_344_1.var_.characterEffect1072ui_story = var_347_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_347_8 = 0.200000002980232

			if var_347_7 <= arg_344_1.time_ and arg_344_1.time_ < var_347_7 + var_347_8 and not isNil(var_347_6) then
				local var_347_9 = (arg_344_1.time_ - var_347_7) / var_347_8

				if arg_344_1.var_.characterEffect1072ui_story and not isNil(var_347_6) then
					local var_347_10 = Mathf.Lerp(0, 0.5, var_347_9)

					arg_344_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_344_1.var_.characterEffect1072ui_story.fillRatio = var_347_10
				end
			end

			if arg_344_1.time_ >= var_347_7 + var_347_8 and arg_344_1.time_ < var_347_7 + var_347_8 + arg_347_0 and not isNil(var_347_6) and arg_344_1.var_.characterEffect1072ui_story then
				local var_347_11 = 0.5

				arg_344_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_344_1.var_.characterEffect1072ui_story.fillRatio = var_347_11
			end

			local var_347_12 = 0
			local var_347_13 = 0.6

			if var_347_12 < arg_344_1.time_ and arg_344_1.time_ <= var_347_12 + arg_347_0 then
				arg_344_1.talkMaxDuration = 0
				arg_344_1.dialogCg_.alpha = 1

				arg_344_1.dialog_:SetActive(true)
				SetActive(arg_344_1.leftNameGo_, true)

				local var_347_14 = arg_344_1:FormatText(StoryNameCfg[6].name)

				arg_344_1.leftNameTxt_.text = var_347_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_344_1.leftNameTxt_.transform)

				arg_344_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_344_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_344_1:RecordName(arg_344_1.leftNameTxt_.text)
				SetActive(arg_344_1.iconTrs_.gameObject, false)
				arg_344_1.callingController_:SetSelectedState("normal")

				local var_347_15 = arg_344_1:GetWordFromCfg(121421085)
				local var_347_16 = arg_344_1:FormatText(var_347_15.content)

				arg_344_1.text_.text = var_347_16

				LuaForUtil.ClearLinePrefixSymbol(arg_344_1.text_)

				local var_347_17 = 24
				local var_347_18 = utf8.len(var_347_16)
				local var_347_19 = var_347_17 <= 0 and var_347_13 or var_347_13 * (var_347_18 / var_347_17)

				if var_347_19 > 0 and var_347_13 < var_347_19 then
					arg_344_1.talkMaxDuration = var_347_19

					if var_347_19 + var_347_12 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_19 + var_347_12
					end
				end

				arg_344_1.text_.text = var_347_16
				arg_344_1.typewritter.percent = 0

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121421", "121421085", "story_v_out_121421.awb") ~= 0 then
					local var_347_20 = manager.audio:GetVoiceLength("story_v_out_121421", "121421085", "story_v_out_121421.awb") / 1000

					if var_347_20 + var_347_12 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_20 + var_347_12
					end

					if var_347_15.prefab_name ~= "" and arg_344_1.actors_[var_347_15.prefab_name] ~= nil then
						local var_347_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_344_1.actors_[var_347_15.prefab_name].transform, "story_v_out_121421", "121421085", "story_v_out_121421.awb")

						arg_344_1:RecordAudio("121421085", var_347_21)
						arg_344_1:RecordAudio("121421085", var_347_21)
					else
						arg_344_1:AudioAction("play", "voice", "story_v_out_121421", "121421085", "story_v_out_121421.awb")
					end

					arg_344_1:RecordHistoryTalkVoice("story_v_out_121421", "121421085", "story_v_out_121421.awb")
				end

				arg_344_1:RecordContent(arg_344_1.text_.text)
			end

			local var_347_22 = math.max(var_347_13, arg_344_1.talkMaxDuration)

			if var_347_12 <= arg_344_1.time_ and arg_344_1.time_ < var_347_12 + var_347_22 then
				arg_344_1.typewritter.percent = (arg_344_1.time_ - var_347_12) / var_347_22

				arg_344_1.typewritter:SetDirty()
			end

			if arg_344_1.time_ >= var_347_12 + var_347_22 and arg_344_1.time_ < var_347_12 + var_347_22 + arg_347_0 then
				arg_344_1.typewritter.percent = 1

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(true)
			end
		end

		arg_344_1.nodeConfigList_ = {}

		arg_344_1:InitPlayNodeList()
	end,
	Play121421086 = function(arg_348_0, arg_348_1)
		arg_348_1.time_ = 0
		arg_348_1.frameCnt_ = 0
		arg_348_1.state_ = "playing"
		arg_348_1.curTalkId_ = 121421086
		arg_348_1.duration_ = 7.6

		local var_348_0 = {
			ja = 6.133,
			ko = 7.6,
			zh = 7.6
		}
		local var_348_1 = manager.audio:GetLocalizationFlag()

		if var_348_0[var_348_1] ~= nil then
			arg_348_1.duration_ = var_348_0[var_348_1]
		end

		SetActive(arg_348_1.tipsGo_, false)

		function arg_348_1.onSingleLineFinish_()
			arg_348_1.onSingleLineUpdate_ = nil
			arg_348_1.onSingleLineFinish_ = nil
			arg_348_1.state_ = "waiting"
		end

		function arg_348_1.playNext_(arg_350_0)
			if arg_350_0 == 1 then
				arg_348_0:Play121421087(arg_348_1)
			end
		end

		function arg_348_1.onSingleLineUpdate_(arg_351_0)
			local var_351_0 = 0
			local var_351_1 = 0.9

			if var_351_0 < arg_348_1.time_ and arg_348_1.time_ <= var_351_0 + arg_351_0 then
				arg_348_1.talkMaxDuration = 0
				arg_348_1.dialogCg_.alpha = 1

				arg_348_1.dialog_:SetActive(true)
				SetActive(arg_348_1.leftNameGo_, true)

				local var_351_2 = arg_348_1:FormatText(StoryNameCfg[6].name)

				arg_348_1.leftNameTxt_.text = var_351_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_348_1.leftNameTxt_.transform)

				arg_348_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_348_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_348_1:RecordName(arg_348_1.leftNameTxt_.text)
				SetActive(arg_348_1.iconTrs_.gameObject, false)
				arg_348_1.callingController_:SetSelectedState("normal")

				local var_351_3 = arg_348_1:GetWordFromCfg(121421086)
				local var_351_4 = arg_348_1:FormatText(var_351_3.content)

				arg_348_1.text_.text = var_351_4

				LuaForUtil.ClearLinePrefixSymbol(arg_348_1.text_)

				local var_351_5 = 36
				local var_351_6 = utf8.len(var_351_4)
				local var_351_7 = var_351_5 <= 0 and var_351_1 or var_351_1 * (var_351_6 / var_351_5)

				if var_351_7 > 0 and var_351_1 < var_351_7 then
					arg_348_1.talkMaxDuration = var_351_7

					if var_351_7 + var_351_0 > arg_348_1.duration_ then
						arg_348_1.duration_ = var_351_7 + var_351_0
					end
				end

				arg_348_1.text_.text = var_351_4
				arg_348_1.typewritter.percent = 0

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121421", "121421086", "story_v_out_121421.awb") ~= 0 then
					local var_351_8 = manager.audio:GetVoiceLength("story_v_out_121421", "121421086", "story_v_out_121421.awb") / 1000

					if var_351_8 + var_351_0 > arg_348_1.duration_ then
						arg_348_1.duration_ = var_351_8 + var_351_0
					end

					if var_351_3.prefab_name ~= "" and arg_348_1.actors_[var_351_3.prefab_name] ~= nil then
						local var_351_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_348_1.actors_[var_351_3.prefab_name].transform, "story_v_out_121421", "121421086", "story_v_out_121421.awb")

						arg_348_1:RecordAudio("121421086", var_351_9)
						arg_348_1:RecordAudio("121421086", var_351_9)
					else
						arg_348_1:AudioAction("play", "voice", "story_v_out_121421", "121421086", "story_v_out_121421.awb")
					end

					arg_348_1:RecordHistoryTalkVoice("story_v_out_121421", "121421086", "story_v_out_121421.awb")
				end

				arg_348_1:RecordContent(arg_348_1.text_.text)
			end

			local var_351_10 = math.max(var_351_1, arg_348_1.talkMaxDuration)

			if var_351_0 <= arg_348_1.time_ and arg_348_1.time_ < var_351_0 + var_351_10 then
				arg_348_1.typewritter.percent = (arg_348_1.time_ - var_351_0) / var_351_10

				arg_348_1.typewritter:SetDirty()
			end

			if arg_348_1.time_ >= var_351_0 + var_351_10 and arg_348_1.time_ < var_351_0 + var_351_10 + arg_351_0 then
				arg_348_1.typewritter.percent = 1

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(true)
			end
		end

		arg_348_1.nodeConfigList_ = {}

		arg_348_1:InitPlayNodeList()
	end,
	Play121421087 = function(arg_352_0, arg_352_1)
		arg_352_1.time_ = 0
		arg_352_1.frameCnt_ = 0
		arg_352_1.state_ = "playing"
		arg_352_1.curTalkId_ = 121421087
		arg_352_1.duration_ = 9.03

		local var_352_0 = {
			ja = 8.9,
			ko = 9.033,
			zh = 9.033
		}
		local var_352_1 = manager.audio:GetLocalizationFlag()

		if var_352_0[var_352_1] ~= nil then
			arg_352_1.duration_ = var_352_0[var_352_1]
		end

		SetActive(arg_352_1.tipsGo_, false)

		function arg_352_1.onSingleLineFinish_()
			arg_352_1.onSingleLineUpdate_ = nil
			arg_352_1.onSingleLineFinish_ = nil
			arg_352_1.state_ = "waiting"
		end

		function arg_352_1.playNext_(arg_354_0)
			if arg_354_0 == 1 then
				arg_352_0:Play121421088(arg_352_1)
			end
		end

		function arg_352_1.onSingleLineUpdate_(arg_355_0)
			local var_355_0 = arg_352_1.actors_["1072ui_story"]
			local var_355_1 = 0

			if var_355_1 < arg_352_1.time_ and arg_352_1.time_ <= var_355_1 + arg_355_0 and not isNil(var_355_0) and arg_352_1.var_.characterEffect1072ui_story == nil then
				arg_352_1.var_.characterEffect1072ui_story = var_355_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_355_2 = 0.200000002980232

			if var_355_1 <= arg_352_1.time_ and arg_352_1.time_ < var_355_1 + var_355_2 and not isNil(var_355_0) then
				local var_355_3 = (arg_352_1.time_ - var_355_1) / var_355_2

				if arg_352_1.var_.characterEffect1072ui_story and not isNil(var_355_0) then
					arg_352_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_352_1.time_ >= var_355_1 + var_355_2 and arg_352_1.time_ < var_355_1 + var_355_2 + arg_355_0 and not isNil(var_355_0) and arg_352_1.var_.characterEffect1072ui_story then
				arg_352_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_355_4 = 0

			if var_355_4 < arg_352_1.time_ and arg_352_1.time_ <= var_355_4 + arg_355_0 then
				arg_352_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action3_2")
			end

			local var_355_5 = 0

			if var_355_5 < arg_352_1.time_ and arg_352_1.time_ <= var_355_5 + arg_355_0 then
				arg_352_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_355_6 = arg_352_1.actors_["1084ui_story"]
			local var_355_7 = 0

			if var_355_7 < arg_352_1.time_ and arg_352_1.time_ <= var_355_7 + arg_355_0 and not isNil(var_355_6) and arg_352_1.var_.characterEffect1084ui_story == nil then
				arg_352_1.var_.characterEffect1084ui_story = var_355_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_355_8 = 0.200000002980232

			if var_355_7 <= arg_352_1.time_ and arg_352_1.time_ < var_355_7 + var_355_8 and not isNil(var_355_6) then
				local var_355_9 = (arg_352_1.time_ - var_355_7) / var_355_8

				if arg_352_1.var_.characterEffect1084ui_story and not isNil(var_355_6) then
					local var_355_10 = Mathf.Lerp(0, 0.5, var_355_9)

					arg_352_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_352_1.var_.characterEffect1084ui_story.fillRatio = var_355_10
				end
			end

			if arg_352_1.time_ >= var_355_7 + var_355_8 and arg_352_1.time_ < var_355_7 + var_355_8 + arg_355_0 and not isNil(var_355_6) and arg_352_1.var_.characterEffect1084ui_story then
				local var_355_11 = 0.5

				arg_352_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_352_1.var_.characterEffect1084ui_story.fillRatio = var_355_11
			end

			local var_355_12 = 0
			local var_355_13 = 0.9

			if var_355_12 < arg_352_1.time_ and arg_352_1.time_ <= var_355_12 + arg_355_0 then
				arg_352_1.talkMaxDuration = 0
				arg_352_1.dialogCg_.alpha = 1

				arg_352_1.dialog_:SetActive(true)
				SetActive(arg_352_1.leftNameGo_, true)

				local var_355_14 = arg_352_1:FormatText(StoryNameCfg[379].name)

				arg_352_1.leftNameTxt_.text = var_355_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_352_1.leftNameTxt_.transform)

				arg_352_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_352_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_352_1:RecordName(arg_352_1.leftNameTxt_.text)
				SetActive(arg_352_1.iconTrs_.gameObject, false)
				arg_352_1.callingController_:SetSelectedState("normal")

				local var_355_15 = arg_352_1:GetWordFromCfg(121421087)
				local var_355_16 = arg_352_1:FormatText(var_355_15.content)

				arg_352_1.text_.text = var_355_16

				LuaForUtil.ClearLinePrefixSymbol(arg_352_1.text_)

				local var_355_17 = 36
				local var_355_18 = utf8.len(var_355_16)
				local var_355_19 = var_355_17 <= 0 and var_355_13 or var_355_13 * (var_355_18 / var_355_17)

				if var_355_19 > 0 and var_355_13 < var_355_19 then
					arg_352_1.talkMaxDuration = var_355_19

					if var_355_19 + var_355_12 > arg_352_1.duration_ then
						arg_352_1.duration_ = var_355_19 + var_355_12
					end
				end

				arg_352_1.text_.text = var_355_16
				arg_352_1.typewritter.percent = 0

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121421", "121421087", "story_v_out_121421.awb") ~= 0 then
					local var_355_20 = manager.audio:GetVoiceLength("story_v_out_121421", "121421087", "story_v_out_121421.awb") / 1000

					if var_355_20 + var_355_12 > arg_352_1.duration_ then
						arg_352_1.duration_ = var_355_20 + var_355_12
					end

					if var_355_15.prefab_name ~= "" and arg_352_1.actors_[var_355_15.prefab_name] ~= nil then
						local var_355_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_352_1.actors_[var_355_15.prefab_name].transform, "story_v_out_121421", "121421087", "story_v_out_121421.awb")

						arg_352_1:RecordAudio("121421087", var_355_21)
						arg_352_1:RecordAudio("121421087", var_355_21)
					else
						arg_352_1:AudioAction("play", "voice", "story_v_out_121421", "121421087", "story_v_out_121421.awb")
					end

					arg_352_1:RecordHistoryTalkVoice("story_v_out_121421", "121421087", "story_v_out_121421.awb")
				end

				arg_352_1:RecordContent(arg_352_1.text_.text)
			end

			local var_355_22 = math.max(var_355_13, arg_352_1.talkMaxDuration)

			if var_355_12 <= arg_352_1.time_ and arg_352_1.time_ < var_355_12 + var_355_22 then
				arg_352_1.typewritter.percent = (arg_352_1.time_ - var_355_12) / var_355_22

				arg_352_1.typewritter:SetDirty()
			end

			if arg_352_1.time_ >= var_355_12 + var_355_22 and arg_352_1.time_ < var_355_12 + var_355_22 + arg_355_0 then
				arg_352_1.typewritter.percent = 1

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(true)
			end
		end

		arg_352_1.nodeConfigList_ = {}

		arg_352_1:InitPlayNodeList()
	end,
	Play121421088 = function(arg_356_0, arg_356_1)
		arg_356_1.time_ = 0
		arg_356_1.frameCnt_ = 0
		arg_356_1.state_ = "playing"
		arg_356_1.curTalkId_ = 121421088
		arg_356_1.duration_ = 12.77

		local var_356_0 = {
			ja = 12.766,
			ko = 10.666,
			zh = 10.666
		}
		local var_356_1 = manager.audio:GetLocalizationFlag()

		if var_356_0[var_356_1] ~= nil then
			arg_356_1.duration_ = var_356_0[var_356_1]
		end

		SetActive(arg_356_1.tipsGo_, false)

		function arg_356_1.onSingleLineFinish_()
			arg_356_1.onSingleLineUpdate_ = nil
			arg_356_1.onSingleLineFinish_ = nil
			arg_356_1.state_ = "waiting"
		end

		function arg_356_1.playNext_(arg_358_0)
			if arg_358_0 == 1 then
				arg_356_0:Play121421089(arg_356_1)
			end
		end

		function arg_356_1.onSingleLineUpdate_(arg_359_0)
			local var_359_0 = 0
			local var_359_1 = 1.225

			if var_359_0 < arg_356_1.time_ and arg_356_1.time_ <= var_359_0 + arg_359_0 then
				arg_356_1.talkMaxDuration = 0
				arg_356_1.dialogCg_.alpha = 1

				arg_356_1.dialog_:SetActive(true)
				SetActive(arg_356_1.leftNameGo_, true)

				local var_359_2 = arg_356_1:FormatText(StoryNameCfg[379].name)

				arg_356_1.leftNameTxt_.text = var_359_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_356_1.leftNameTxt_.transform)

				arg_356_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_356_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_356_1:RecordName(arg_356_1.leftNameTxt_.text)
				SetActive(arg_356_1.iconTrs_.gameObject, false)
				arg_356_1.callingController_:SetSelectedState("normal")

				local var_359_3 = arg_356_1:GetWordFromCfg(121421088)
				local var_359_4 = arg_356_1:FormatText(var_359_3.content)

				arg_356_1.text_.text = var_359_4

				LuaForUtil.ClearLinePrefixSymbol(arg_356_1.text_)

				local var_359_5 = 49
				local var_359_6 = utf8.len(var_359_4)
				local var_359_7 = var_359_5 <= 0 and var_359_1 or var_359_1 * (var_359_6 / var_359_5)

				if var_359_7 > 0 and var_359_1 < var_359_7 then
					arg_356_1.talkMaxDuration = var_359_7

					if var_359_7 + var_359_0 > arg_356_1.duration_ then
						arg_356_1.duration_ = var_359_7 + var_359_0
					end
				end

				arg_356_1.text_.text = var_359_4
				arg_356_1.typewritter.percent = 0

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121421", "121421088", "story_v_out_121421.awb") ~= 0 then
					local var_359_8 = manager.audio:GetVoiceLength("story_v_out_121421", "121421088", "story_v_out_121421.awb") / 1000

					if var_359_8 + var_359_0 > arg_356_1.duration_ then
						arg_356_1.duration_ = var_359_8 + var_359_0
					end

					if var_359_3.prefab_name ~= "" and arg_356_1.actors_[var_359_3.prefab_name] ~= nil then
						local var_359_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_356_1.actors_[var_359_3.prefab_name].transform, "story_v_out_121421", "121421088", "story_v_out_121421.awb")

						arg_356_1:RecordAudio("121421088", var_359_9)
						arg_356_1:RecordAudio("121421088", var_359_9)
					else
						arg_356_1:AudioAction("play", "voice", "story_v_out_121421", "121421088", "story_v_out_121421.awb")
					end

					arg_356_1:RecordHistoryTalkVoice("story_v_out_121421", "121421088", "story_v_out_121421.awb")
				end

				arg_356_1:RecordContent(arg_356_1.text_.text)
			end

			local var_359_10 = math.max(var_359_1, arg_356_1.talkMaxDuration)

			if var_359_0 <= arg_356_1.time_ and arg_356_1.time_ < var_359_0 + var_359_10 then
				arg_356_1.typewritter.percent = (arg_356_1.time_ - var_359_0) / var_359_10

				arg_356_1.typewritter:SetDirty()
			end

			if arg_356_1.time_ >= var_359_0 + var_359_10 and arg_356_1.time_ < var_359_0 + var_359_10 + arg_359_0 then
				arg_356_1.typewritter.percent = 1

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(true)
			end
		end

		arg_356_1.nodeConfigList_ = {}

		arg_356_1:InitPlayNodeList()
	end,
	Play121421089 = function(arg_360_0, arg_360_1)
		arg_360_1.time_ = 0
		arg_360_1.frameCnt_ = 0
		arg_360_1.state_ = "playing"
		arg_360_1.curTalkId_ = 121421089
		arg_360_1.duration_ = 11.07

		local var_360_0 = {
			ja = 8.866,
			ko = 11.066,
			zh = 11.066
		}
		local var_360_1 = manager.audio:GetLocalizationFlag()

		if var_360_0[var_360_1] ~= nil then
			arg_360_1.duration_ = var_360_0[var_360_1]
		end

		SetActive(arg_360_1.tipsGo_, false)

		function arg_360_1.onSingleLineFinish_()
			arg_360_1.onSingleLineUpdate_ = nil
			arg_360_1.onSingleLineFinish_ = nil
			arg_360_1.state_ = "waiting"
		end

		function arg_360_1.playNext_(arg_362_0)
			if arg_362_0 == 1 then
				arg_360_0:Play121421090(arg_360_1)
			end
		end

		function arg_360_1.onSingleLineUpdate_(arg_363_0)
			local var_363_0 = 0
			local var_363_1 = 1.075

			if var_363_0 < arg_360_1.time_ and arg_360_1.time_ <= var_363_0 + arg_363_0 then
				arg_360_1.talkMaxDuration = 0
				arg_360_1.dialogCg_.alpha = 1

				arg_360_1.dialog_:SetActive(true)
				SetActive(arg_360_1.leftNameGo_, true)

				local var_363_2 = arg_360_1:FormatText(StoryNameCfg[379].name)

				arg_360_1.leftNameTxt_.text = var_363_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_360_1.leftNameTxt_.transform)

				arg_360_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_360_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_360_1:RecordName(arg_360_1.leftNameTxt_.text)
				SetActive(arg_360_1.iconTrs_.gameObject, false)
				arg_360_1.callingController_:SetSelectedState("normal")

				local var_363_3 = arg_360_1:GetWordFromCfg(121421089)
				local var_363_4 = arg_360_1:FormatText(var_363_3.content)

				arg_360_1.text_.text = var_363_4

				LuaForUtil.ClearLinePrefixSymbol(arg_360_1.text_)

				local var_363_5 = 43
				local var_363_6 = utf8.len(var_363_4)
				local var_363_7 = var_363_5 <= 0 and var_363_1 or var_363_1 * (var_363_6 / var_363_5)

				if var_363_7 > 0 and var_363_1 < var_363_7 then
					arg_360_1.talkMaxDuration = var_363_7

					if var_363_7 + var_363_0 > arg_360_1.duration_ then
						arg_360_1.duration_ = var_363_7 + var_363_0
					end
				end

				arg_360_1.text_.text = var_363_4
				arg_360_1.typewritter.percent = 0

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121421", "121421089", "story_v_out_121421.awb") ~= 0 then
					local var_363_8 = manager.audio:GetVoiceLength("story_v_out_121421", "121421089", "story_v_out_121421.awb") / 1000

					if var_363_8 + var_363_0 > arg_360_1.duration_ then
						arg_360_1.duration_ = var_363_8 + var_363_0
					end

					if var_363_3.prefab_name ~= "" and arg_360_1.actors_[var_363_3.prefab_name] ~= nil then
						local var_363_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_360_1.actors_[var_363_3.prefab_name].transform, "story_v_out_121421", "121421089", "story_v_out_121421.awb")

						arg_360_1:RecordAudio("121421089", var_363_9)
						arg_360_1:RecordAudio("121421089", var_363_9)
					else
						arg_360_1:AudioAction("play", "voice", "story_v_out_121421", "121421089", "story_v_out_121421.awb")
					end

					arg_360_1:RecordHistoryTalkVoice("story_v_out_121421", "121421089", "story_v_out_121421.awb")
				end

				arg_360_1:RecordContent(arg_360_1.text_.text)
			end

			local var_363_10 = math.max(var_363_1, arg_360_1.talkMaxDuration)

			if var_363_0 <= arg_360_1.time_ and arg_360_1.time_ < var_363_0 + var_363_10 then
				arg_360_1.typewritter.percent = (arg_360_1.time_ - var_363_0) / var_363_10

				arg_360_1.typewritter:SetDirty()
			end

			if arg_360_1.time_ >= var_363_0 + var_363_10 and arg_360_1.time_ < var_363_0 + var_363_10 + arg_363_0 then
				arg_360_1.typewritter.percent = 1

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(true)
			end
		end

		arg_360_1.nodeConfigList_ = {}

		arg_360_1:InitPlayNodeList()
	end,
	Play121421090 = function(arg_364_0, arg_364_1)
		arg_364_1.time_ = 0
		arg_364_1.frameCnt_ = 0
		arg_364_1.state_ = "playing"
		arg_364_1.curTalkId_ = 121421090
		arg_364_1.duration_ = 12.67

		local var_364_0 = {
			ja = 10.833,
			ko = 12.666,
			zh = 12.666
		}
		local var_364_1 = manager.audio:GetLocalizationFlag()

		if var_364_0[var_364_1] ~= nil then
			arg_364_1.duration_ = var_364_0[var_364_1]
		end

		SetActive(arg_364_1.tipsGo_, false)

		function arg_364_1.onSingleLineFinish_()
			arg_364_1.onSingleLineUpdate_ = nil
			arg_364_1.onSingleLineFinish_ = nil
			arg_364_1.state_ = "waiting"
		end

		function arg_364_1.playNext_(arg_366_0)
			if arg_366_0 == 1 then
				arg_364_0:Play121421091(arg_364_1)
			end
		end

		function arg_364_1.onSingleLineUpdate_(arg_367_0)
			local var_367_0 = 0
			local var_367_1 = 1.075

			if var_367_0 < arg_364_1.time_ and arg_364_1.time_ <= var_367_0 + arg_367_0 then
				arg_364_1.talkMaxDuration = 0
				arg_364_1.dialogCg_.alpha = 1

				arg_364_1.dialog_:SetActive(true)
				SetActive(arg_364_1.leftNameGo_, true)

				local var_367_2 = arg_364_1:FormatText(StoryNameCfg[379].name)

				arg_364_1.leftNameTxt_.text = var_367_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_364_1.leftNameTxt_.transform)

				arg_364_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_364_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_364_1:RecordName(arg_364_1.leftNameTxt_.text)
				SetActive(arg_364_1.iconTrs_.gameObject, false)
				arg_364_1.callingController_:SetSelectedState("normal")

				local var_367_3 = arg_364_1:GetWordFromCfg(121421090)
				local var_367_4 = arg_364_1:FormatText(var_367_3.content)

				arg_364_1.text_.text = var_367_4

				LuaForUtil.ClearLinePrefixSymbol(arg_364_1.text_)

				local var_367_5 = 43
				local var_367_6 = utf8.len(var_367_4)
				local var_367_7 = var_367_5 <= 0 and var_367_1 or var_367_1 * (var_367_6 / var_367_5)

				if var_367_7 > 0 and var_367_1 < var_367_7 then
					arg_364_1.talkMaxDuration = var_367_7

					if var_367_7 + var_367_0 > arg_364_1.duration_ then
						arg_364_1.duration_ = var_367_7 + var_367_0
					end
				end

				arg_364_1.text_.text = var_367_4
				arg_364_1.typewritter.percent = 0

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121421", "121421090", "story_v_out_121421.awb") ~= 0 then
					local var_367_8 = manager.audio:GetVoiceLength("story_v_out_121421", "121421090", "story_v_out_121421.awb") / 1000

					if var_367_8 + var_367_0 > arg_364_1.duration_ then
						arg_364_1.duration_ = var_367_8 + var_367_0
					end

					if var_367_3.prefab_name ~= "" and arg_364_1.actors_[var_367_3.prefab_name] ~= nil then
						local var_367_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_364_1.actors_[var_367_3.prefab_name].transform, "story_v_out_121421", "121421090", "story_v_out_121421.awb")

						arg_364_1:RecordAudio("121421090", var_367_9)
						arg_364_1:RecordAudio("121421090", var_367_9)
					else
						arg_364_1:AudioAction("play", "voice", "story_v_out_121421", "121421090", "story_v_out_121421.awb")
					end

					arg_364_1:RecordHistoryTalkVoice("story_v_out_121421", "121421090", "story_v_out_121421.awb")
				end

				arg_364_1:RecordContent(arg_364_1.text_.text)
			end

			local var_367_10 = math.max(var_367_1, arg_364_1.talkMaxDuration)

			if var_367_0 <= arg_364_1.time_ and arg_364_1.time_ < var_367_0 + var_367_10 then
				arg_364_1.typewritter.percent = (arg_364_1.time_ - var_367_0) / var_367_10

				arg_364_1.typewritter:SetDirty()
			end

			if arg_364_1.time_ >= var_367_0 + var_367_10 and arg_364_1.time_ < var_367_0 + var_367_10 + arg_367_0 then
				arg_364_1.typewritter.percent = 1

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(true)
			end
		end

		arg_364_1.nodeConfigList_ = {}

		arg_364_1:InitPlayNodeList()
	end,
	Play121421091 = function(arg_368_0, arg_368_1)
		arg_368_1.time_ = 0
		arg_368_1.frameCnt_ = 0
		arg_368_1.state_ = "playing"
		arg_368_1.curTalkId_ = 121421091
		arg_368_1.duration_ = 8.1

		local var_368_0 = {
			ja = 8.1,
			ko = 7.066,
			zh = 7.066
		}
		local var_368_1 = manager.audio:GetLocalizationFlag()

		if var_368_0[var_368_1] ~= nil then
			arg_368_1.duration_ = var_368_0[var_368_1]
		end

		SetActive(arg_368_1.tipsGo_, false)

		function arg_368_1.onSingleLineFinish_()
			arg_368_1.onSingleLineUpdate_ = nil
			arg_368_1.onSingleLineFinish_ = nil
			arg_368_1.state_ = "waiting"
		end

		function arg_368_1.playNext_(arg_370_0)
			if arg_370_0 == 1 then
				arg_368_0:Play121421092(arg_368_1)
			end
		end

		function arg_368_1.onSingleLineUpdate_(arg_371_0)
			local var_371_0 = 0

			if var_371_0 < arg_368_1.time_ and arg_368_1.time_ <= var_371_0 + arg_371_0 then
				arg_368_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_371_1 = 0
			local var_371_2 = 0.925

			if var_371_1 < arg_368_1.time_ and arg_368_1.time_ <= var_371_1 + arg_371_0 then
				arg_368_1.talkMaxDuration = 0
				arg_368_1.dialogCg_.alpha = 1

				arg_368_1.dialog_:SetActive(true)
				SetActive(arg_368_1.leftNameGo_, true)

				local var_371_3 = arg_368_1:FormatText(StoryNameCfg[379].name)

				arg_368_1.leftNameTxt_.text = var_371_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_368_1.leftNameTxt_.transform)

				arg_368_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_368_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_368_1:RecordName(arg_368_1.leftNameTxt_.text)
				SetActive(arg_368_1.iconTrs_.gameObject, false)
				arg_368_1.callingController_:SetSelectedState("normal")

				local var_371_4 = arg_368_1:GetWordFromCfg(121421091)
				local var_371_5 = arg_368_1:FormatText(var_371_4.content)

				arg_368_1.text_.text = var_371_5

				LuaForUtil.ClearLinePrefixSymbol(arg_368_1.text_)

				local var_371_6 = 36
				local var_371_7 = utf8.len(var_371_5)
				local var_371_8 = var_371_6 <= 0 and var_371_2 or var_371_2 * (var_371_7 / var_371_6)

				if var_371_8 > 0 and var_371_2 < var_371_8 then
					arg_368_1.talkMaxDuration = var_371_8

					if var_371_8 + var_371_1 > arg_368_1.duration_ then
						arg_368_1.duration_ = var_371_8 + var_371_1
					end
				end

				arg_368_1.text_.text = var_371_5
				arg_368_1.typewritter.percent = 0

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121421", "121421091", "story_v_out_121421.awb") ~= 0 then
					local var_371_9 = manager.audio:GetVoiceLength("story_v_out_121421", "121421091", "story_v_out_121421.awb") / 1000

					if var_371_9 + var_371_1 > arg_368_1.duration_ then
						arg_368_1.duration_ = var_371_9 + var_371_1
					end

					if var_371_4.prefab_name ~= "" and arg_368_1.actors_[var_371_4.prefab_name] ~= nil then
						local var_371_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_368_1.actors_[var_371_4.prefab_name].transform, "story_v_out_121421", "121421091", "story_v_out_121421.awb")

						arg_368_1:RecordAudio("121421091", var_371_10)
						arg_368_1:RecordAudio("121421091", var_371_10)
					else
						arg_368_1:AudioAction("play", "voice", "story_v_out_121421", "121421091", "story_v_out_121421.awb")
					end

					arg_368_1:RecordHistoryTalkVoice("story_v_out_121421", "121421091", "story_v_out_121421.awb")
				end

				arg_368_1:RecordContent(arg_368_1.text_.text)
			end

			local var_371_11 = math.max(var_371_2, arg_368_1.talkMaxDuration)

			if var_371_1 <= arg_368_1.time_ and arg_368_1.time_ < var_371_1 + var_371_11 then
				arg_368_1.typewritter.percent = (arg_368_1.time_ - var_371_1) / var_371_11

				arg_368_1.typewritter:SetDirty()
			end

			if arg_368_1.time_ >= var_371_1 + var_371_11 and arg_368_1.time_ < var_371_1 + var_371_11 + arg_371_0 then
				arg_368_1.typewritter.percent = 1

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(true)
			end
		end

		arg_368_1.nodeConfigList_ = {}

		arg_368_1:InitPlayNodeList()
	end,
	Play121421092 = function(arg_372_0, arg_372_1)
		arg_372_1.time_ = 0
		arg_372_1.frameCnt_ = 0
		arg_372_1.state_ = "playing"
		arg_372_1.curTalkId_ = 121421092
		arg_372_1.duration_ = 10.1

		local var_372_0 = {
			ja = 10.1,
			ko = 7.433,
			zh = 7.433
		}
		local var_372_1 = manager.audio:GetLocalizationFlag()

		if var_372_0[var_372_1] ~= nil then
			arg_372_1.duration_ = var_372_0[var_372_1]
		end

		SetActive(arg_372_1.tipsGo_, false)

		function arg_372_1.onSingleLineFinish_()
			arg_372_1.onSingleLineUpdate_ = nil
			arg_372_1.onSingleLineFinish_ = nil
			arg_372_1.state_ = "waiting"
		end

		function arg_372_1.playNext_(arg_374_0)
			if arg_374_0 == 1 then
				arg_372_0:Play121421093(arg_372_1)
			end
		end

		function arg_372_1.onSingleLineUpdate_(arg_375_0)
			local var_375_0 = arg_372_1.actors_["1084ui_story"]
			local var_375_1 = 0

			if var_375_1 < arg_372_1.time_ and arg_372_1.time_ <= var_375_1 + arg_375_0 and not isNil(var_375_0) and arg_372_1.var_.characterEffect1084ui_story == nil then
				arg_372_1.var_.characterEffect1084ui_story = var_375_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_375_2 = 0.200000002980232

			if var_375_1 <= arg_372_1.time_ and arg_372_1.time_ < var_375_1 + var_375_2 and not isNil(var_375_0) then
				local var_375_3 = (arg_372_1.time_ - var_375_1) / var_375_2

				if arg_372_1.var_.characterEffect1084ui_story and not isNil(var_375_0) then
					arg_372_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_372_1.time_ >= var_375_1 + var_375_2 and arg_372_1.time_ < var_375_1 + var_375_2 + arg_375_0 and not isNil(var_375_0) and arg_372_1.var_.characterEffect1084ui_story then
				arg_372_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_375_4 = arg_372_1.actors_["1072ui_story"]
			local var_375_5 = 0

			if var_375_5 < arg_372_1.time_ and arg_372_1.time_ <= var_375_5 + arg_375_0 and not isNil(var_375_4) and arg_372_1.var_.characterEffect1072ui_story == nil then
				arg_372_1.var_.characterEffect1072ui_story = var_375_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_375_6 = 0.200000002980232

			if var_375_5 <= arg_372_1.time_ and arg_372_1.time_ < var_375_5 + var_375_6 and not isNil(var_375_4) then
				local var_375_7 = (arg_372_1.time_ - var_375_5) / var_375_6

				if arg_372_1.var_.characterEffect1072ui_story and not isNil(var_375_4) then
					local var_375_8 = Mathf.Lerp(0, 0.5, var_375_7)

					arg_372_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_372_1.var_.characterEffect1072ui_story.fillRatio = var_375_8
				end
			end

			if arg_372_1.time_ >= var_375_5 + var_375_6 and arg_372_1.time_ < var_375_5 + var_375_6 + arg_375_0 and not isNil(var_375_4) and arg_372_1.var_.characterEffect1072ui_story then
				local var_375_9 = 0.5

				arg_372_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_372_1.var_.characterEffect1072ui_story.fillRatio = var_375_9
			end

			local var_375_10 = 0
			local var_375_11 = 0.95

			if var_375_10 < arg_372_1.time_ and arg_372_1.time_ <= var_375_10 + arg_375_0 then
				arg_372_1.talkMaxDuration = 0
				arg_372_1.dialogCg_.alpha = 1

				arg_372_1.dialog_:SetActive(true)
				SetActive(arg_372_1.leftNameGo_, true)

				local var_375_12 = arg_372_1:FormatText(StoryNameCfg[6].name)

				arg_372_1.leftNameTxt_.text = var_375_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_372_1.leftNameTxt_.transform)

				arg_372_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_372_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_372_1:RecordName(arg_372_1.leftNameTxt_.text)
				SetActive(arg_372_1.iconTrs_.gameObject, false)
				arg_372_1.callingController_:SetSelectedState("normal")

				local var_375_13 = arg_372_1:GetWordFromCfg(121421092)
				local var_375_14 = arg_372_1:FormatText(var_375_13.content)

				arg_372_1.text_.text = var_375_14

				LuaForUtil.ClearLinePrefixSymbol(arg_372_1.text_)

				local var_375_15 = 38
				local var_375_16 = utf8.len(var_375_14)
				local var_375_17 = var_375_15 <= 0 and var_375_11 or var_375_11 * (var_375_16 / var_375_15)

				if var_375_17 > 0 and var_375_11 < var_375_17 then
					arg_372_1.talkMaxDuration = var_375_17

					if var_375_17 + var_375_10 > arg_372_1.duration_ then
						arg_372_1.duration_ = var_375_17 + var_375_10
					end
				end

				arg_372_1.text_.text = var_375_14
				arg_372_1.typewritter.percent = 0

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121421", "121421092", "story_v_out_121421.awb") ~= 0 then
					local var_375_18 = manager.audio:GetVoiceLength("story_v_out_121421", "121421092", "story_v_out_121421.awb") / 1000

					if var_375_18 + var_375_10 > arg_372_1.duration_ then
						arg_372_1.duration_ = var_375_18 + var_375_10
					end

					if var_375_13.prefab_name ~= "" and arg_372_1.actors_[var_375_13.prefab_name] ~= nil then
						local var_375_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_372_1.actors_[var_375_13.prefab_name].transform, "story_v_out_121421", "121421092", "story_v_out_121421.awb")

						arg_372_1:RecordAudio("121421092", var_375_19)
						arg_372_1:RecordAudio("121421092", var_375_19)
					else
						arg_372_1:AudioAction("play", "voice", "story_v_out_121421", "121421092", "story_v_out_121421.awb")
					end

					arg_372_1:RecordHistoryTalkVoice("story_v_out_121421", "121421092", "story_v_out_121421.awb")
				end

				arg_372_1:RecordContent(arg_372_1.text_.text)
			end

			local var_375_20 = math.max(var_375_11, arg_372_1.talkMaxDuration)

			if var_375_10 <= arg_372_1.time_ and arg_372_1.time_ < var_375_10 + var_375_20 then
				arg_372_1.typewritter.percent = (arg_372_1.time_ - var_375_10) / var_375_20

				arg_372_1.typewritter:SetDirty()
			end

			if arg_372_1.time_ >= var_375_10 + var_375_20 and arg_372_1.time_ < var_375_10 + var_375_20 + arg_375_0 then
				arg_372_1.typewritter.percent = 1

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(true)
			end
		end

		arg_372_1.nodeConfigList_ = {}

		arg_372_1:InitPlayNodeList()
	end,
	Play121421093 = function(arg_376_0, arg_376_1)
		arg_376_1.time_ = 0
		arg_376_1.frameCnt_ = 0
		arg_376_1.state_ = "playing"
		arg_376_1.curTalkId_ = 121421093
		arg_376_1.duration_ = 4.27

		local var_376_0 = {
			ja = 4.266,
			ko = 2.233,
			zh = 2.233
		}
		local var_376_1 = manager.audio:GetLocalizationFlag()

		if var_376_0[var_376_1] ~= nil then
			arg_376_1.duration_ = var_376_0[var_376_1]
		end

		SetActive(arg_376_1.tipsGo_, false)

		function arg_376_1.onSingleLineFinish_()
			arg_376_1.onSingleLineUpdate_ = nil
			arg_376_1.onSingleLineFinish_ = nil
			arg_376_1.state_ = "waiting"
		end

		function arg_376_1.playNext_(arg_378_0)
			if arg_378_0 == 1 then
				arg_376_0:Play121421094(arg_376_1)
			end
		end

		function arg_376_1.onSingleLineUpdate_(arg_379_0)
			local var_379_0 = 0
			local var_379_1 = 0.225

			if var_379_0 < arg_376_1.time_ and arg_376_1.time_ <= var_379_0 + arg_379_0 then
				arg_376_1.talkMaxDuration = 0
				arg_376_1.dialogCg_.alpha = 1

				arg_376_1.dialog_:SetActive(true)
				SetActive(arg_376_1.leftNameGo_, true)

				local var_379_2 = arg_376_1:FormatText(StoryNameCfg[6].name)

				arg_376_1.leftNameTxt_.text = var_379_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_376_1.leftNameTxt_.transform)

				arg_376_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_376_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_376_1:RecordName(arg_376_1.leftNameTxt_.text)
				SetActive(arg_376_1.iconTrs_.gameObject, false)
				arg_376_1.callingController_:SetSelectedState("normal")

				local var_379_3 = arg_376_1:GetWordFromCfg(121421093)
				local var_379_4 = arg_376_1:FormatText(var_379_3.content)

				arg_376_1.text_.text = var_379_4

				LuaForUtil.ClearLinePrefixSymbol(arg_376_1.text_)

				local var_379_5 = 9
				local var_379_6 = utf8.len(var_379_4)
				local var_379_7 = var_379_5 <= 0 and var_379_1 or var_379_1 * (var_379_6 / var_379_5)

				if var_379_7 > 0 and var_379_1 < var_379_7 then
					arg_376_1.talkMaxDuration = var_379_7

					if var_379_7 + var_379_0 > arg_376_1.duration_ then
						arg_376_1.duration_ = var_379_7 + var_379_0
					end
				end

				arg_376_1.text_.text = var_379_4
				arg_376_1.typewritter.percent = 0

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121421", "121421093", "story_v_out_121421.awb") ~= 0 then
					local var_379_8 = manager.audio:GetVoiceLength("story_v_out_121421", "121421093", "story_v_out_121421.awb") / 1000

					if var_379_8 + var_379_0 > arg_376_1.duration_ then
						arg_376_1.duration_ = var_379_8 + var_379_0
					end

					if var_379_3.prefab_name ~= "" and arg_376_1.actors_[var_379_3.prefab_name] ~= nil then
						local var_379_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_376_1.actors_[var_379_3.prefab_name].transform, "story_v_out_121421", "121421093", "story_v_out_121421.awb")

						arg_376_1:RecordAudio("121421093", var_379_9)
						arg_376_1:RecordAudio("121421093", var_379_9)
					else
						arg_376_1:AudioAction("play", "voice", "story_v_out_121421", "121421093", "story_v_out_121421.awb")
					end

					arg_376_1:RecordHistoryTalkVoice("story_v_out_121421", "121421093", "story_v_out_121421.awb")
				end

				arg_376_1:RecordContent(arg_376_1.text_.text)
			end

			local var_379_10 = math.max(var_379_1, arg_376_1.talkMaxDuration)

			if var_379_0 <= arg_376_1.time_ and arg_376_1.time_ < var_379_0 + var_379_10 then
				arg_376_1.typewritter.percent = (arg_376_1.time_ - var_379_0) / var_379_10

				arg_376_1.typewritter:SetDirty()
			end

			if arg_376_1.time_ >= var_379_0 + var_379_10 and arg_376_1.time_ < var_379_0 + var_379_10 + arg_379_0 then
				arg_376_1.typewritter.percent = 1

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(true)
			end
		end

		arg_376_1.nodeConfigList_ = {}

		arg_376_1:InitPlayNodeList()
	end,
	Play121421094 = function(arg_380_0, arg_380_1)
		arg_380_1.time_ = 0
		arg_380_1.frameCnt_ = 0
		arg_380_1.state_ = "playing"
		arg_380_1.curTalkId_ = 121421094
		arg_380_1.duration_ = 12.03

		local var_380_0 = {
			ja = 12.033,
			ko = 8.966,
			zh = 8.966
		}
		local var_380_1 = manager.audio:GetLocalizationFlag()

		if var_380_0[var_380_1] ~= nil then
			arg_380_1.duration_ = var_380_0[var_380_1]
		end

		SetActive(arg_380_1.tipsGo_, false)

		function arg_380_1.onSingleLineFinish_()
			arg_380_1.onSingleLineUpdate_ = nil
			arg_380_1.onSingleLineFinish_ = nil
			arg_380_1.state_ = "waiting"
		end

		function arg_380_1.playNext_(arg_382_0)
			if arg_382_0 == 1 then
				arg_380_0:Play121421095(arg_380_1)
			end
		end

		function arg_380_1.onSingleLineUpdate_(arg_383_0)
			local var_383_0 = arg_380_1.actors_["1072ui_story"]
			local var_383_1 = 0

			if var_383_1 < arg_380_1.time_ and arg_380_1.time_ <= var_383_1 + arg_383_0 and not isNil(var_383_0) and arg_380_1.var_.characterEffect1072ui_story == nil then
				arg_380_1.var_.characterEffect1072ui_story = var_383_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_383_2 = 0.200000002980232

			if var_383_1 <= arg_380_1.time_ and arg_380_1.time_ < var_383_1 + var_383_2 and not isNil(var_383_0) then
				local var_383_3 = (arg_380_1.time_ - var_383_1) / var_383_2

				if arg_380_1.var_.characterEffect1072ui_story and not isNil(var_383_0) then
					arg_380_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_380_1.time_ >= var_383_1 + var_383_2 and arg_380_1.time_ < var_383_1 + var_383_2 + arg_383_0 and not isNil(var_383_0) and arg_380_1.var_.characterEffect1072ui_story then
				arg_380_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_383_4 = 0

			if var_383_4 < arg_380_1.time_ and arg_380_1.time_ <= var_383_4 + arg_383_0 then
				arg_380_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action3_1")
			end

			local var_383_5 = 0

			if var_383_5 < arg_380_1.time_ and arg_380_1.time_ <= var_383_5 + arg_383_0 then
				arg_380_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0203cva")
			end

			local var_383_6 = arg_380_1.actors_["1084ui_story"]
			local var_383_7 = 0

			if var_383_7 < arg_380_1.time_ and arg_380_1.time_ <= var_383_7 + arg_383_0 and not isNil(var_383_6) and arg_380_1.var_.characterEffect1084ui_story == nil then
				arg_380_1.var_.characterEffect1084ui_story = var_383_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_383_8 = 0.200000002980232

			if var_383_7 <= arg_380_1.time_ and arg_380_1.time_ < var_383_7 + var_383_8 and not isNil(var_383_6) then
				local var_383_9 = (arg_380_1.time_ - var_383_7) / var_383_8

				if arg_380_1.var_.characterEffect1084ui_story and not isNil(var_383_6) then
					local var_383_10 = Mathf.Lerp(0, 0.5, var_383_9)

					arg_380_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_380_1.var_.characterEffect1084ui_story.fillRatio = var_383_10
				end
			end

			if arg_380_1.time_ >= var_383_7 + var_383_8 and arg_380_1.time_ < var_383_7 + var_383_8 + arg_383_0 and not isNil(var_383_6) and arg_380_1.var_.characterEffect1084ui_story then
				local var_383_11 = 0.5

				arg_380_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_380_1.var_.characterEffect1084ui_story.fillRatio = var_383_11
			end

			local var_383_12 = 0
			local var_383_13 = 0.85

			if var_383_12 < arg_380_1.time_ and arg_380_1.time_ <= var_383_12 + arg_383_0 then
				arg_380_1.talkMaxDuration = 0
				arg_380_1.dialogCg_.alpha = 1

				arg_380_1.dialog_:SetActive(true)
				SetActive(arg_380_1.leftNameGo_, true)

				local var_383_14 = arg_380_1:FormatText(StoryNameCfg[379].name)

				arg_380_1.leftNameTxt_.text = var_383_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_380_1.leftNameTxt_.transform)

				arg_380_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_380_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_380_1:RecordName(arg_380_1.leftNameTxt_.text)
				SetActive(arg_380_1.iconTrs_.gameObject, false)
				arg_380_1.callingController_:SetSelectedState("normal")

				local var_383_15 = arg_380_1:GetWordFromCfg(121421094)
				local var_383_16 = arg_380_1:FormatText(var_383_15.content)

				arg_380_1.text_.text = var_383_16

				LuaForUtil.ClearLinePrefixSymbol(arg_380_1.text_)

				local var_383_17 = 34
				local var_383_18 = utf8.len(var_383_16)
				local var_383_19 = var_383_17 <= 0 and var_383_13 or var_383_13 * (var_383_18 / var_383_17)

				if var_383_19 > 0 and var_383_13 < var_383_19 then
					arg_380_1.talkMaxDuration = var_383_19

					if var_383_19 + var_383_12 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_19 + var_383_12
					end
				end

				arg_380_1.text_.text = var_383_16
				arg_380_1.typewritter.percent = 0

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121421", "121421094", "story_v_out_121421.awb") ~= 0 then
					local var_383_20 = manager.audio:GetVoiceLength("story_v_out_121421", "121421094", "story_v_out_121421.awb") / 1000

					if var_383_20 + var_383_12 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_20 + var_383_12
					end

					if var_383_15.prefab_name ~= "" and arg_380_1.actors_[var_383_15.prefab_name] ~= nil then
						local var_383_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_380_1.actors_[var_383_15.prefab_name].transform, "story_v_out_121421", "121421094", "story_v_out_121421.awb")

						arg_380_1:RecordAudio("121421094", var_383_21)
						arg_380_1:RecordAudio("121421094", var_383_21)
					else
						arg_380_1:AudioAction("play", "voice", "story_v_out_121421", "121421094", "story_v_out_121421.awb")
					end

					arg_380_1:RecordHistoryTalkVoice("story_v_out_121421", "121421094", "story_v_out_121421.awb")
				end

				arg_380_1:RecordContent(arg_380_1.text_.text)
			end

			local var_383_22 = math.max(var_383_13, arg_380_1.talkMaxDuration)

			if var_383_12 <= arg_380_1.time_ and arg_380_1.time_ < var_383_12 + var_383_22 then
				arg_380_1.typewritter.percent = (arg_380_1.time_ - var_383_12) / var_383_22

				arg_380_1.typewritter:SetDirty()
			end

			if arg_380_1.time_ >= var_383_12 + var_383_22 and arg_380_1.time_ < var_383_12 + var_383_22 + arg_383_0 then
				arg_380_1.typewritter.percent = 1

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(true)
			end
		end

		arg_380_1.nodeConfigList_ = {}

		arg_380_1:InitPlayNodeList()
	end,
	Play121421095 = function(arg_384_0, arg_384_1)
		arg_384_1.time_ = 0
		arg_384_1.frameCnt_ = 0
		arg_384_1.state_ = "playing"
		arg_384_1.curTalkId_ = 121421095
		arg_384_1.duration_ = 10.53

		local var_384_0 = {
			ja = 10.533,
			ko = 10.066,
			zh = 10.066
		}
		local var_384_1 = manager.audio:GetLocalizationFlag()

		if var_384_0[var_384_1] ~= nil then
			arg_384_1.duration_ = var_384_0[var_384_1]
		end

		SetActive(arg_384_1.tipsGo_, false)

		function arg_384_1.onSingleLineFinish_()
			arg_384_1.onSingleLineUpdate_ = nil
			arg_384_1.onSingleLineFinish_ = nil
			arg_384_1.state_ = "waiting"
		end

		function arg_384_1.playNext_(arg_386_0)
			if arg_386_0 == 1 then
				arg_384_0:Play121421096(arg_384_1)
			end
		end

		function arg_384_1.onSingleLineUpdate_(arg_387_0)
			local var_387_0 = 0

			if var_387_0 < arg_384_1.time_ and arg_384_1.time_ <= var_387_0 + arg_387_0 then
				arg_384_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action3_2")
			end

			local var_387_1 = 0

			if var_387_1 < arg_384_1.time_ and arg_384_1.time_ <= var_387_1 + arg_387_0 then
				arg_384_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_387_2 = 0
			local var_387_3 = 1.475

			if var_387_2 < arg_384_1.time_ and arg_384_1.time_ <= var_387_2 + arg_387_0 then
				arg_384_1.talkMaxDuration = 0
				arg_384_1.dialogCg_.alpha = 1

				arg_384_1.dialog_:SetActive(true)
				SetActive(arg_384_1.leftNameGo_, true)

				local var_387_4 = arg_384_1:FormatText(StoryNameCfg[379].name)

				arg_384_1.leftNameTxt_.text = var_387_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_384_1.leftNameTxt_.transform)

				arg_384_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_384_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_384_1:RecordName(arg_384_1.leftNameTxt_.text)
				SetActive(arg_384_1.iconTrs_.gameObject, false)
				arg_384_1.callingController_:SetSelectedState("normal")

				local var_387_5 = arg_384_1:GetWordFromCfg(121421095)
				local var_387_6 = arg_384_1:FormatText(var_387_5.content)

				arg_384_1.text_.text = var_387_6

				LuaForUtil.ClearLinePrefixSymbol(arg_384_1.text_)

				local var_387_7 = 59
				local var_387_8 = utf8.len(var_387_6)
				local var_387_9 = var_387_7 <= 0 and var_387_3 or var_387_3 * (var_387_8 / var_387_7)

				if var_387_9 > 0 and var_387_3 < var_387_9 then
					arg_384_1.talkMaxDuration = var_387_9

					if var_387_9 + var_387_2 > arg_384_1.duration_ then
						arg_384_1.duration_ = var_387_9 + var_387_2
					end
				end

				arg_384_1.text_.text = var_387_6
				arg_384_1.typewritter.percent = 0

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121421", "121421095", "story_v_out_121421.awb") ~= 0 then
					local var_387_10 = manager.audio:GetVoiceLength("story_v_out_121421", "121421095", "story_v_out_121421.awb") / 1000

					if var_387_10 + var_387_2 > arg_384_1.duration_ then
						arg_384_1.duration_ = var_387_10 + var_387_2
					end

					if var_387_5.prefab_name ~= "" and arg_384_1.actors_[var_387_5.prefab_name] ~= nil then
						local var_387_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_384_1.actors_[var_387_5.prefab_name].transform, "story_v_out_121421", "121421095", "story_v_out_121421.awb")

						arg_384_1:RecordAudio("121421095", var_387_11)
						arg_384_1:RecordAudio("121421095", var_387_11)
					else
						arg_384_1:AudioAction("play", "voice", "story_v_out_121421", "121421095", "story_v_out_121421.awb")
					end

					arg_384_1:RecordHistoryTalkVoice("story_v_out_121421", "121421095", "story_v_out_121421.awb")
				end

				arg_384_1:RecordContent(arg_384_1.text_.text)
			end

			local var_387_12 = math.max(var_387_3, arg_384_1.talkMaxDuration)

			if var_387_2 <= arg_384_1.time_ and arg_384_1.time_ < var_387_2 + var_387_12 then
				arg_384_1.typewritter.percent = (arg_384_1.time_ - var_387_2) / var_387_12

				arg_384_1.typewritter:SetDirty()
			end

			if arg_384_1.time_ >= var_387_2 + var_387_12 and arg_384_1.time_ < var_387_2 + var_387_12 + arg_387_0 then
				arg_384_1.typewritter.percent = 1

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(true)
			end
		end

		arg_384_1.nodeConfigList_ = {}

		arg_384_1:InitPlayNodeList()
	end,
	Play121421096 = function(arg_388_0, arg_388_1)
		arg_388_1.time_ = 0
		arg_388_1.frameCnt_ = 0
		arg_388_1.state_ = "playing"
		arg_388_1.curTalkId_ = 121421096
		arg_388_1.duration_ = 0.2

		SetActive(arg_388_1.tipsGo_, false)

		function arg_388_1.onSingleLineFinish_()
			arg_388_1.onSingleLineUpdate_ = nil
			arg_388_1.onSingleLineFinish_ = nil
			arg_388_1.state_ = "waiting"

			SetActive(arg_388_1.choicesGo_, true)

			for iter_389_0, iter_389_1 in ipairs(arg_388_1.choices_) do
				local var_389_0 = iter_389_0 <= 2

				SetActive(iter_389_1.go, var_389_0)
			end

			arg_388_1.choices_[1].txt.text = arg_388_1:FormatText(StoryChoiceCfg[395].name)
			arg_388_1.choices_[2].txt.text = arg_388_1:FormatText(StoryChoiceCfg[396].name)
		end

		function arg_388_1.playNext_(arg_390_0)
			if arg_390_0 == 1 then
				arg_388_0:Play121421097(arg_388_1)
			end

			if arg_390_0 == 2 then
				arg_388_0:Play121421098(arg_388_1)
			end

			arg_388_1:RecordChoiceLog(121421096, 395, 396)
		end

		function arg_388_1.onSingleLineUpdate_(arg_391_0)
			local var_391_0 = arg_388_1.actors_["1072ui_story"]
			local var_391_1 = 0

			if var_391_1 < arg_388_1.time_ and arg_388_1.time_ <= var_391_1 + arg_391_0 and not isNil(var_391_0) and arg_388_1.var_.characterEffect1072ui_story == nil then
				arg_388_1.var_.characterEffect1072ui_story = var_391_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_391_2 = 0.200000002980232

			if var_391_1 <= arg_388_1.time_ and arg_388_1.time_ < var_391_1 + var_391_2 and not isNil(var_391_0) then
				local var_391_3 = (arg_388_1.time_ - var_391_1) / var_391_2

				if arg_388_1.var_.characterEffect1072ui_story and not isNil(var_391_0) then
					local var_391_4 = Mathf.Lerp(0, 0.5, var_391_3)

					arg_388_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_388_1.var_.characterEffect1072ui_story.fillRatio = var_391_4
				end
			end

			if arg_388_1.time_ >= var_391_1 + var_391_2 and arg_388_1.time_ < var_391_1 + var_391_2 + arg_391_0 and not isNil(var_391_0) and arg_388_1.var_.characterEffect1072ui_story then
				local var_391_5 = 0.5

				arg_388_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_388_1.var_.characterEffect1072ui_story.fillRatio = var_391_5
			end

			local var_391_6 = 0

			if var_391_6 < arg_388_1.time_ and arg_388_1.time_ <= var_391_6 + arg_391_0 then
				arg_388_1.allBtn_.enabled = false
			end

			local var_391_7 = 0.200000002980232

			if arg_388_1.time_ >= var_391_6 + var_391_7 and arg_388_1.time_ < var_391_6 + var_391_7 + arg_391_0 then
				arg_388_1.allBtn_.enabled = true
			end
		end

		arg_388_1.nodeConfigList_ = {}

		arg_388_1:InitPlayNodeList()
	end,
	Play121421097 = function(arg_392_0, arg_392_1)
		arg_392_1.time_ = 0
		arg_392_1.frameCnt_ = 0
		arg_392_1.state_ = "playing"
		arg_392_1.curTalkId_ = 121421097
		arg_392_1.duration_ = 12.37

		local var_392_0 = {
			ja = 12.366,
			ko = 9.433,
			zh = 9.433
		}
		local var_392_1 = manager.audio:GetLocalizationFlag()

		if var_392_0[var_392_1] ~= nil then
			arg_392_1.duration_ = var_392_0[var_392_1]
		end

		SetActive(arg_392_1.tipsGo_, false)

		function arg_392_1.onSingleLineFinish_()
			arg_392_1.onSingleLineUpdate_ = nil
			arg_392_1.onSingleLineFinish_ = nil
			arg_392_1.state_ = "waiting"
		end

		function arg_392_1.playNext_(arg_394_0)
			if arg_394_0 == 1 then
				arg_392_0:Play121421098(arg_392_1)
			end
		end

		function arg_392_1.onSingleLineUpdate_(arg_395_0)
			local var_395_0 = arg_392_1.actors_["1072ui_story"]
			local var_395_1 = 0

			if var_395_1 < arg_392_1.time_ and arg_392_1.time_ <= var_395_1 + arg_395_0 and not isNil(var_395_0) and arg_392_1.var_.characterEffect1072ui_story == nil then
				arg_392_1.var_.characterEffect1072ui_story = var_395_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_395_2 = 0.200000002980232

			if var_395_1 <= arg_392_1.time_ and arg_392_1.time_ < var_395_1 + var_395_2 and not isNil(var_395_0) then
				local var_395_3 = (arg_392_1.time_ - var_395_1) / var_395_2

				if arg_392_1.var_.characterEffect1072ui_story and not isNil(var_395_0) then
					arg_392_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_392_1.time_ >= var_395_1 + var_395_2 and arg_392_1.time_ < var_395_1 + var_395_2 + arg_395_0 and not isNil(var_395_0) and arg_392_1.var_.characterEffect1072ui_story then
				arg_392_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_395_4 = 0
			local var_395_5 = 1.05

			if var_395_4 < arg_392_1.time_ and arg_392_1.time_ <= var_395_4 + arg_395_0 then
				arg_392_1.talkMaxDuration = 0
				arg_392_1.dialogCg_.alpha = 1

				arg_392_1.dialog_:SetActive(true)
				SetActive(arg_392_1.leftNameGo_, true)

				local var_395_6 = arg_392_1:FormatText(StoryNameCfg[379].name)

				arg_392_1.leftNameTxt_.text = var_395_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_392_1.leftNameTxt_.transform)

				arg_392_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_392_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_392_1:RecordName(arg_392_1.leftNameTxt_.text)
				SetActive(arg_392_1.iconTrs_.gameObject, false)
				arg_392_1.callingController_:SetSelectedState("normal")

				local var_395_7 = arg_392_1:GetWordFromCfg(121421097)
				local var_395_8 = arg_392_1:FormatText(var_395_7.content)

				arg_392_1.text_.text = var_395_8

				LuaForUtil.ClearLinePrefixSymbol(arg_392_1.text_)

				local var_395_9 = 42
				local var_395_10 = utf8.len(var_395_8)
				local var_395_11 = var_395_9 <= 0 and var_395_5 or var_395_5 * (var_395_10 / var_395_9)

				if var_395_11 > 0 and var_395_5 < var_395_11 then
					arg_392_1.talkMaxDuration = var_395_11

					if var_395_11 + var_395_4 > arg_392_1.duration_ then
						arg_392_1.duration_ = var_395_11 + var_395_4
					end
				end

				arg_392_1.text_.text = var_395_8
				arg_392_1.typewritter.percent = 0

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121421", "121421097", "story_v_out_121421.awb") ~= 0 then
					local var_395_12 = manager.audio:GetVoiceLength("story_v_out_121421", "121421097", "story_v_out_121421.awb") / 1000

					if var_395_12 + var_395_4 > arg_392_1.duration_ then
						arg_392_1.duration_ = var_395_12 + var_395_4
					end

					if var_395_7.prefab_name ~= "" and arg_392_1.actors_[var_395_7.prefab_name] ~= nil then
						local var_395_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_392_1.actors_[var_395_7.prefab_name].transform, "story_v_out_121421", "121421097", "story_v_out_121421.awb")

						arg_392_1:RecordAudio("121421097", var_395_13)
						arg_392_1:RecordAudio("121421097", var_395_13)
					else
						arg_392_1:AudioAction("play", "voice", "story_v_out_121421", "121421097", "story_v_out_121421.awb")
					end

					arg_392_1:RecordHistoryTalkVoice("story_v_out_121421", "121421097", "story_v_out_121421.awb")
				end

				arg_392_1:RecordContent(arg_392_1.text_.text)
			end

			local var_395_14 = math.max(var_395_5, arg_392_1.talkMaxDuration)

			if var_395_4 <= arg_392_1.time_ and arg_392_1.time_ < var_395_4 + var_395_14 then
				arg_392_1.typewritter.percent = (arg_392_1.time_ - var_395_4) / var_395_14

				arg_392_1.typewritter:SetDirty()
			end

			if arg_392_1.time_ >= var_395_4 + var_395_14 and arg_392_1.time_ < var_395_4 + var_395_14 + arg_395_0 then
				arg_392_1.typewritter.percent = 1

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(true)
			end
		end

		arg_392_1.nodeConfigList_ = {}

		arg_392_1:InitPlayNodeList()
	end,
	Play121421098 = function(arg_396_0, arg_396_1)
		arg_396_1.time_ = 0
		arg_396_1.frameCnt_ = 0
		arg_396_1.state_ = "playing"
		arg_396_1.curTalkId_ = 121421098
		arg_396_1.duration_ = 10.4

		local var_396_0 = {
			ja = 10.4,
			ko = 8.4,
			zh = 8.4
		}
		local var_396_1 = manager.audio:GetLocalizationFlag()

		if var_396_0[var_396_1] ~= nil then
			arg_396_1.duration_ = var_396_0[var_396_1]
		end

		SetActive(arg_396_1.tipsGo_, false)

		function arg_396_1.onSingleLineFinish_()
			arg_396_1.onSingleLineUpdate_ = nil
			arg_396_1.onSingleLineFinish_ = nil
			arg_396_1.state_ = "waiting"
		end

		function arg_396_1.playNext_(arg_398_0)
			if arg_398_0 == 1 then
				arg_396_0:Play121421099(arg_396_1)
			end
		end

		function arg_396_1.onSingleLineUpdate_(arg_399_0)
			local var_399_0 = 0
			local var_399_1 = 1

			if var_399_0 < arg_396_1.time_ and arg_396_1.time_ <= var_399_0 + arg_399_0 then
				arg_396_1.talkMaxDuration = 0
				arg_396_1.dialogCg_.alpha = 1

				arg_396_1.dialog_:SetActive(true)
				SetActive(arg_396_1.leftNameGo_, true)

				local var_399_2 = arg_396_1:FormatText(StoryNameCfg[379].name)

				arg_396_1.leftNameTxt_.text = var_399_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_396_1.leftNameTxt_.transform)

				arg_396_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_396_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_396_1:RecordName(arg_396_1.leftNameTxt_.text)
				SetActive(arg_396_1.iconTrs_.gameObject, false)
				arg_396_1.callingController_:SetSelectedState("normal")

				local var_399_3 = arg_396_1:GetWordFromCfg(121421098)
				local var_399_4 = arg_396_1:FormatText(var_399_3.content)

				arg_396_1.text_.text = var_399_4

				LuaForUtil.ClearLinePrefixSymbol(arg_396_1.text_)

				local var_399_5 = 40
				local var_399_6 = utf8.len(var_399_4)
				local var_399_7 = var_399_5 <= 0 and var_399_1 or var_399_1 * (var_399_6 / var_399_5)

				if var_399_7 > 0 and var_399_1 < var_399_7 then
					arg_396_1.talkMaxDuration = var_399_7

					if var_399_7 + var_399_0 > arg_396_1.duration_ then
						arg_396_1.duration_ = var_399_7 + var_399_0
					end
				end

				arg_396_1.text_.text = var_399_4
				arg_396_1.typewritter.percent = 0

				arg_396_1.typewritter:SetDirty()
				arg_396_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121421", "121421098", "story_v_out_121421.awb") ~= 0 then
					local var_399_8 = manager.audio:GetVoiceLength("story_v_out_121421", "121421098", "story_v_out_121421.awb") / 1000

					if var_399_8 + var_399_0 > arg_396_1.duration_ then
						arg_396_1.duration_ = var_399_8 + var_399_0
					end

					if var_399_3.prefab_name ~= "" and arg_396_1.actors_[var_399_3.prefab_name] ~= nil then
						local var_399_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_396_1.actors_[var_399_3.prefab_name].transform, "story_v_out_121421", "121421098", "story_v_out_121421.awb")

						arg_396_1:RecordAudio("121421098", var_399_9)
						arg_396_1:RecordAudio("121421098", var_399_9)
					else
						arg_396_1:AudioAction("play", "voice", "story_v_out_121421", "121421098", "story_v_out_121421.awb")
					end

					arg_396_1:RecordHistoryTalkVoice("story_v_out_121421", "121421098", "story_v_out_121421.awb")
				end

				arg_396_1:RecordContent(arg_396_1.text_.text)
			end

			local var_399_10 = math.max(var_399_1, arg_396_1.talkMaxDuration)

			if var_399_0 <= arg_396_1.time_ and arg_396_1.time_ < var_399_0 + var_399_10 then
				arg_396_1.typewritter.percent = (arg_396_1.time_ - var_399_0) / var_399_10

				arg_396_1.typewritter:SetDirty()
			end

			if arg_396_1.time_ >= var_399_0 + var_399_10 and arg_396_1.time_ < var_399_0 + var_399_10 + arg_399_0 then
				arg_396_1.typewritter.percent = 1

				arg_396_1.typewritter:SetDirty()
				arg_396_1:ShowNextGo(true)
			end
		end

		arg_396_1.nodeConfigList_ = {}

		arg_396_1:InitPlayNodeList()
	end,
	Play121421099 = function(arg_400_0, arg_400_1)
		arg_400_1.time_ = 0
		arg_400_1.frameCnt_ = 0
		arg_400_1.state_ = "playing"
		arg_400_1.curTalkId_ = 121421099
		arg_400_1.duration_ = 9.93

		local var_400_0 = {
			ja = 9.933,
			ko = 7.3,
			zh = 7.3
		}
		local var_400_1 = manager.audio:GetLocalizationFlag()

		if var_400_0[var_400_1] ~= nil then
			arg_400_1.duration_ = var_400_0[var_400_1]
		end

		SetActive(arg_400_1.tipsGo_, false)

		function arg_400_1.onSingleLineFinish_()
			arg_400_1.onSingleLineUpdate_ = nil
			arg_400_1.onSingleLineFinish_ = nil
			arg_400_1.state_ = "waiting"
		end

		function arg_400_1.playNext_(arg_402_0)
			if arg_402_0 == 1 then
				arg_400_0:Play121421100(arg_400_1)
			end
		end

		function arg_400_1.onSingleLineUpdate_(arg_403_0)
			local var_403_0 = 0
			local var_403_1 = 0.875

			if var_403_0 < arg_400_1.time_ and arg_400_1.time_ <= var_403_0 + arg_403_0 then
				arg_400_1.talkMaxDuration = 0
				arg_400_1.dialogCg_.alpha = 1

				arg_400_1.dialog_:SetActive(true)
				SetActive(arg_400_1.leftNameGo_, true)

				local var_403_2 = arg_400_1:FormatText(StoryNameCfg[379].name)

				arg_400_1.leftNameTxt_.text = var_403_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_400_1.leftNameTxt_.transform)

				arg_400_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_400_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_400_1:RecordName(arg_400_1.leftNameTxt_.text)
				SetActive(arg_400_1.iconTrs_.gameObject, false)
				arg_400_1.callingController_:SetSelectedState("normal")

				local var_403_3 = arg_400_1:GetWordFromCfg(121421099)
				local var_403_4 = arg_400_1:FormatText(var_403_3.content)

				arg_400_1.text_.text = var_403_4

				LuaForUtil.ClearLinePrefixSymbol(arg_400_1.text_)

				local var_403_5 = 35
				local var_403_6 = utf8.len(var_403_4)
				local var_403_7 = var_403_5 <= 0 and var_403_1 or var_403_1 * (var_403_6 / var_403_5)

				if var_403_7 > 0 and var_403_1 < var_403_7 then
					arg_400_1.talkMaxDuration = var_403_7

					if var_403_7 + var_403_0 > arg_400_1.duration_ then
						arg_400_1.duration_ = var_403_7 + var_403_0
					end
				end

				arg_400_1.text_.text = var_403_4
				arg_400_1.typewritter.percent = 0

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121421", "121421099", "story_v_out_121421.awb") ~= 0 then
					local var_403_8 = manager.audio:GetVoiceLength("story_v_out_121421", "121421099", "story_v_out_121421.awb") / 1000

					if var_403_8 + var_403_0 > arg_400_1.duration_ then
						arg_400_1.duration_ = var_403_8 + var_403_0
					end

					if var_403_3.prefab_name ~= "" and arg_400_1.actors_[var_403_3.prefab_name] ~= nil then
						local var_403_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_400_1.actors_[var_403_3.prefab_name].transform, "story_v_out_121421", "121421099", "story_v_out_121421.awb")

						arg_400_1:RecordAudio("121421099", var_403_9)
						arg_400_1:RecordAudio("121421099", var_403_9)
					else
						arg_400_1:AudioAction("play", "voice", "story_v_out_121421", "121421099", "story_v_out_121421.awb")
					end

					arg_400_1:RecordHistoryTalkVoice("story_v_out_121421", "121421099", "story_v_out_121421.awb")
				end

				arg_400_1:RecordContent(arg_400_1.text_.text)
			end

			local var_403_10 = math.max(var_403_1, arg_400_1.talkMaxDuration)

			if var_403_0 <= arg_400_1.time_ and arg_400_1.time_ < var_403_0 + var_403_10 then
				arg_400_1.typewritter.percent = (arg_400_1.time_ - var_403_0) / var_403_10

				arg_400_1.typewritter:SetDirty()
			end

			if arg_400_1.time_ >= var_403_0 + var_403_10 and arg_400_1.time_ < var_403_0 + var_403_10 + arg_403_0 then
				arg_400_1.typewritter.percent = 1

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(true)
			end
		end

		arg_400_1.nodeConfigList_ = {}

		arg_400_1:InitPlayNodeList()
	end,
	Play121421100 = function(arg_404_0, arg_404_1)
		arg_404_1.time_ = 0
		arg_404_1.frameCnt_ = 0
		arg_404_1.state_ = "playing"
		arg_404_1.curTalkId_ = 121421100
		arg_404_1.duration_ = 6.8

		local var_404_0 = {
			ja = 6.7,
			ko = 6.8,
			zh = 6.8
		}
		local var_404_1 = manager.audio:GetLocalizationFlag()

		if var_404_0[var_404_1] ~= nil then
			arg_404_1.duration_ = var_404_0[var_404_1]
		end

		SetActive(arg_404_1.tipsGo_, false)

		function arg_404_1.onSingleLineFinish_()
			arg_404_1.onSingleLineUpdate_ = nil
			arg_404_1.onSingleLineFinish_ = nil
			arg_404_1.state_ = "waiting"
		end

		function arg_404_1.playNext_(arg_406_0)
			if arg_406_0 == 1 then
				arg_404_0:Play121421101(arg_404_1)
			end
		end

		function arg_404_1.onSingleLineUpdate_(arg_407_0)
			local var_407_0 = arg_404_1.actors_["1084ui_story"]
			local var_407_1 = 0

			if var_407_1 < arg_404_1.time_ and arg_404_1.time_ <= var_407_1 + arg_407_0 and not isNil(var_407_0) and arg_404_1.var_.characterEffect1084ui_story == nil then
				arg_404_1.var_.characterEffect1084ui_story = var_407_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_407_2 = 0.200000002980232

			if var_407_1 <= arg_404_1.time_ and arg_404_1.time_ < var_407_1 + var_407_2 and not isNil(var_407_0) then
				local var_407_3 = (arg_404_1.time_ - var_407_1) / var_407_2

				if arg_404_1.var_.characterEffect1084ui_story and not isNil(var_407_0) then
					arg_404_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_404_1.time_ >= var_407_1 + var_407_2 and arg_404_1.time_ < var_407_1 + var_407_2 + arg_407_0 and not isNil(var_407_0) and arg_404_1.var_.characterEffect1084ui_story then
				arg_404_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_407_4 = 0

			if var_407_4 < arg_404_1.time_ and arg_404_1.time_ <= var_407_4 + arg_407_0 then
				arg_404_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_2")
			end

			local var_407_5 = 0

			if var_407_5 < arg_404_1.time_ and arg_404_1.time_ <= var_407_5 + arg_407_0 then
				arg_404_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_407_6 = arg_404_1.actors_["1072ui_story"]
			local var_407_7 = 0

			if var_407_7 < arg_404_1.time_ and arg_404_1.time_ <= var_407_7 + arg_407_0 and not isNil(var_407_6) and arg_404_1.var_.characterEffect1072ui_story == nil then
				arg_404_1.var_.characterEffect1072ui_story = var_407_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_407_8 = 0.200000002980232

			if var_407_7 <= arg_404_1.time_ and arg_404_1.time_ < var_407_7 + var_407_8 and not isNil(var_407_6) then
				local var_407_9 = (arg_404_1.time_ - var_407_7) / var_407_8

				if arg_404_1.var_.characterEffect1072ui_story and not isNil(var_407_6) then
					local var_407_10 = Mathf.Lerp(0, 0.5, var_407_9)

					arg_404_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_404_1.var_.characterEffect1072ui_story.fillRatio = var_407_10
				end
			end

			if arg_404_1.time_ >= var_407_7 + var_407_8 and arg_404_1.time_ < var_407_7 + var_407_8 + arg_407_0 and not isNil(var_407_6) and arg_404_1.var_.characterEffect1072ui_story then
				local var_407_11 = 0.5

				arg_404_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_404_1.var_.characterEffect1072ui_story.fillRatio = var_407_11
			end

			local var_407_12 = 0
			local var_407_13 = 0.6

			if var_407_12 < arg_404_1.time_ and arg_404_1.time_ <= var_407_12 + arg_407_0 then
				arg_404_1.talkMaxDuration = 0
				arg_404_1.dialogCg_.alpha = 1

				arg_404_1.dialog_:SetActive(true)
				SetActive(arg_404_1.leftNameGo_, true)

				local var_407_14 = arg_404_1:FormatText(StoryNameCfg[6].name)

				arg_404_1.leftNameTxt_.text = var_407_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_404_1.leftNameTxt_.transform)

				arg_404_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_404_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_404_1:RecordName(arg_404_1.leftNameTxt_.text)
				SetActive(arg_404_1.iconTrs_.gameObject, false)
				arg_404_1.callingController_:SetSelectedState("normal")

				local var_407_15 = arg_404_1:GetWordFromCfg(121421100)
				local var_407_16 = arg_404_1:FormatText(var_407_15.content)

				arg_404_1.text_.text = var_407_16

				LuaForUtil.ClearLinePrefixSymbol(arg_404_1.text_)

				local var_407_17 = 24
				local var_407_18 = utf8.len(var_407_16)
				local var_407_19 = var_407_17 <= 0 and var_407_13 or var_407_13 * (var_407_18 / var_407_17)

				if var_407_19 > 0 and var_407_13 < var_407_19 then
					arg_404_1.talkMaxDuration = var_407_19

					if var_407_19 + var_407_12 > arg_404_1.duration_ then
						arg_404_1.duration_ = var_407_19 + var_407_12
					end
				end

				arg_404_1.text_.text = var_407_16
				arg_404_1.typewritter.percent = 0

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121421", "121421100", "story_v_out_121421.awb") ~= 0 then
					local var_407_20 = manager.audio:GetVoiceLength("story_v_out_121421", "121421100", "story_v_out_121421.awb") / 1000

					if var_407_20 + var_407_12 > arg_404_1.duration_ then
						arg_404_1.duration_ = var_407_20 + var_407_12
					end

					if var_407_15.prefab_name ~= "" and arg_404_1.actors_[var_407_15.prefab_name] ~= nil then
						local var_407_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_404_1.actors_[var_407_15.prefab_name].transform, "story_v_out_121421", "121421100", "story_v_out_121421.awb")

						arg_404_1:RecordAudio("121421100", var_407_21)
						arg_404_1:RecordAudio("121421100", var_407_21)
					else
						arg_404_1:AudioAction("play", "voice", "story_v_out_121421", "121421100", "story_v_out_121421.awb")
					end

					arg_404_1:RecordHistoryTalkVoice("story_v_out_121421", "121421100", "story_v_out_121421.awb")
				end

				arg_404_1:RecordContent(arg_404_1.text_.text)
			end

			local var_407_22 = math.max(var_407_13, arg_404_1.talkMaxDuration)

			if var_407_12 <= arg_404_1.time_ and arg_404_1.time_ < var_407_12 + var_407_22 then
				arg_404_1.typewritter.percent = (arg_404_1.time_ - var_407_12) / var_407_22

				arg_404_1.typewritter:SetDirty()
			end

			if arg_404_1.time_ >= var_407_12 + var_407_22 and arg_404_1.time_ < var_407_12 + var_407_22 + arg_407_0 then
				arg_404_1.typewritter.percent = 1

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(true)
			end
		end

		arg_404_1.nodeConfigList_ = {}

		arg_404_1:InitPlayNodeList()
	end,
	Play121421101 = function(arg_408_0, arg_408_1)
		arg_408_1.time_ = 0
		arg_408_1.frameCnt_ = 0
		arg_408_1.state_ = "playing"
		arg_408_1.curTalkId_ = 121421101
		arg_408_1.duration_ = 10.1

		local var_408_0 = {
			ja = 8.2,
			ko = 10.1,
			zh = 10.1
		}
		local var_408_1 = manager.audio:GetLocalizationFlag()

		if var_408_0[var_408_1] ~= nil then
			arg_408_1.duration_ = var_408_0[var_408_1]
		end

		SetActive(arg_408_1.tipsGo_, false)

		function arg_408_1.onSingleLineFinish_()
			arg_408_1.onSingleLineUpdate_ = nil
			arg_408_1.onSingleLineFinish_ = nil
			arg_408_1.state_ = "waiting"
		end

		function arg_408_1.playNext_(arg_410_0)
			if arg_410_0 == 1 then
				arg_408_0:Play121421102(arg_408_1)
			end
		end

		function arg_408_1.onSingleLineUpdate_(arg_411_0)
			local var_411_0 = arg_408_1.actors_["1072ui_story"]
			local var_411_1 = 0

			if var_411_1 < arg_408_1.time_ and arg_408_1.time_ <= var_411_1 + arg_411_0 and not isNil(var_411_0) and arg_408_1.var_.characterEffect1072ui_story == nil then
				arg_408_1.var_.characterEffect1072ui_story = var_411_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_411_2 = 0.200000002980232

			if var_411_1 <= arg_408_1.time_ and arg_408_1.time_ < var_411_1 + var_411_2 and not isNil(var_411_0) then
				local var_411_3 = (arg_408_1.time_ - var_411_1) / var_411_2

				if arg_408_1.var_.characterEffect1072ui_story and not isNil(var_411_0) then
					arg_408_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_408_1.time_ >= var_411_1 + var_411_2 and arg_408_1.time_ < var_411_1 + var_411_2 + arg_411_0 and not isNil(var_411_0) and arg_408_1.var_.characterEffect1072ui_story then
				arg_408_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_411_4 = 0

			if var_411_4 < arg_408_1.time_ and arg_408_1.time_ <= var_411_4 + arg_411_0 then
				arg_408_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_411_5 = arg_408_1.actors_["1084ui_story"]
			local var_411_6 = 0

			if var_411_6 < arg_408_1.time_ and arg_408_1.time_ <= var_411_6 + arg_411_0 and not isNil(var_411_5) and arg_408_1.var_.characterEffect1084ui_story == nil then
				arg_408_1.var_.characterEffect1084ui_story = var_411_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_411_7 = 0.200000002980232

			if var_411_6 <= arg_408_1.time_ and arg_408_1.time_ < var_411_6 + var_411_7 and not isNil(var_411_5) then
				local var_411_8 = (arg_408_1.time_ - var_411_6) / var_411_7

				if arg_408_1.var_.characterEffect1084ui_story and not isNil(var_411_5) then
					local var_411_9 = Mathf.Lerp(0, 0.5, var_411_8)

					arg_408_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_408_1.var_.characterEffect1084ui_story.fillRatio = var_411_9
				end
			end

			if arg_408_1.time_ >= var_411_6 + var_411_7 and arg_408_1.time_ < var_411_6 + var_411_7 + arg_411_0 and not isNil(var_411_5) and arg_408_1.var_.characterEffect1084ui_story then
				local var_411_10 = 0.5

				arg_408_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_408_1.var_.characterEffect1084ui_story.fillRatio = var_411_10
			end

			local var_411_11 = 0
			local var_411_12 = 1.2

			if var_411_11 < arg_408_1.time_ and arg_408_1.time_ <= var_411_11 + arg_411_0 then
				arg_408_1.talkMaxDuration = 0
				arg_408_1.dialogCg_.alpha = 1

				arg_408_1.dialog_:SetActive(true)
				SetActive(arg_408_1.leftNameGo_, true)

				local var_411_13 = arg_408_1:FormatText(StoryNameCfg[379].name)

				arg_408_1.leftNameTxt_.text = var_411_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_408_1.leftNameTxt_.transform)

				arg_408_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_408_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_408_1:RecordName(arg_408_1.leftNameTxt_.text)
				SetActive(arg_408_1.iconTrs_.gameObject, false)
				arg_408_1.callingController_:SetSelectedState("normal")

				local var_411_14 = arg_408_1:GetWordFromCfg(121421101)
				local var_411_15 = arg_408_1:FormatText(var_411_14.content)

				arg_408_1.text_.text = var_411_15

				LuaForUtil.ClearLinePrefixSymbol(arg_408_1.text_)

				local var_411_16 = 48
				local var_411_17 = utf8.len(var_411_15)
				local var_411_18 = var_411_16 <= 0 and var_411_12 or var_411_12 * (var_411_17 / var_411_16)

				if var_411_18 > 0 and var_411_12 < var_411_18 then
					arg_408_1.talkMaxDuration = var_411_18

					if var_411_18 + var_411_11 > arg_408_1.duration_ then
						arg_408_1.duration_ = var_411_18 + var_411_11
					end
				end

				arg_408_1.text_.text = var_411_15
				arg_408_1.typewritter.percent = 0

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121421", "121421101", "story_v_out_121421.awb") ~= 0 then
					local var_411_19 = manager.audio:GetVoiceLength("story_v_out_121421", "121421101", "story_v_out_121421.awb") / 1000

					if var_411_19 + var_411_11 > arg_408_1.duration_ then
						arg_408_1.duration_ = var_411_19 + var_411_11
					end

					if var_411_14.prefab_name ~= "" and arg_408_1.actors_[var_411_14.prefab_name] ~= nil then
						local var_411_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_408_1.actors_[var_411_14.prefab_name].transform, "story_v_out_121421", "121421101", "story_v_out_121421.awb")

						arg_408_1:RecordAudio("121421101", var_411_20)
						arg_408_1:RecordAudio("121421101", var_411_20)
					else
						arg_408_1:AudioAction("play", "voice", "story_v_out_121421", "121421101", "story_v_out_121421.awb")
					end

					arg_408_1:RecordHistoryTalkVoice("story_v_out_121421", "121421101", "story_v_out_121421.awb")
				end

				arg_408_1:RecordContent(arg_408_1.text_.text)
			end

			local var_411_21 = math.max(var_411_12, arg_408_1.talkMaxDuration)

			if var_411_11 <= arg_408_1.time_ and arg_408_1.time_ < var_411_11 + var_411_21 then
				arg_408_1.typewritter.percent = (arg_408_1.time_ - var_411_11) / var_411_21

				arg_408_1.typewritter:SetDirty()
			end

			if arg_408_1.time_ >= var_411_11 + var_411_21 and arg_408_1.time_ < var_411_11 + var_411_21 + arg_411_0 then
				arg_408_1.typewritter.percent = 1

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(true)
			end
		end

		arg_408_1.nodeConfigList_ = {}

		arg_408_1:InitPlayNodeList()
	end,
	Play121421102 = function(arg_412_0, arg_412_1)
		arg_412_1.time_ = 0
		arg_412_1.frameCnt_ = 0
		arg_412_1.state_ = "playing"
		arg_412_1.curTalkId_ = 121421102
		arg_412_1.duration_ = 9.7

		local var_412_0 = {
			ja = 5.733,
			ko = 9.7,
			zh = 9.7
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
				arg_412_0:Play121421103(arg_412_1)
			end
		end

		function arg_412_1.onSingleLineUpdate_(arg_415_0)
			local var_415_0 = 0
			local var_415_1 = 0.95

			if var_415_0 < arg_412_1.time_ and arg_412_1.time_ <= var_415_0 + arg_415_0 then
				arg_412_1.talkMaxDuration = 0
				arg_412_1.dialogCg_.alpha = 1

				arg_412_1.dialog_:SetActive(true)
				SetActive(arg_412_1.leftNameGo_, true)

				local var_415_2 = arg_412_1:FormatText(StoryNameCfg[379].name)

				arg_412_1.leftNameTxt_.text = var_415_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_412_1.leftNameTxt_.transform)

				arg_412_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_412_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_412_1:RecordName(arg_412_1.leftNameTxt_.text)
				SetActive(arg_412_1.iconTrs_.gameObject, false)
				arg_412_1.callingController_:SetSelectedState("normal")

				local var_415_3 = arg_412_1:GetWordFromCfg(121421102)
				local var_415_4 = arg_412_1:FormatText(var_415_3.content)

				arg_412_1.text_.text = var_415_4

				LuaForUtil.ClearLinePrefixSymbol(arg_412_1.text_)

				local var_415_5 = 38
				local var_415_6 = utf8.len(var_415_4)
				local var_415_7 = var_415_5 <= 0 and var_415_1 or var_415_1 * (var_415_6 / var_415_5)

				if var_415_7 > 0 and var_415_1 < var_415_7 then
					arg_412_1.talkMaxDuration = var_415_7

					if var_415_7 + var_415_0 > arg_412_1.duration_ then
						arg_412_1.duration_ = var_415_7 + var_415_0
					end
				end

				arg_412_1.text_.text = var_415_4
				arg_412_1.typewritter.percent = 0

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121421", "121421102", "story_v_out_121421.awb") ~= 0 then
					local var_415_8 = manager.audio:GetVoiceLength("story_v_out_121421", "121421102", "story_v_out_121421.awb") / 1000

					if var_415_8 + var_415_0 > arg_412_1.duration_ then
						arg_412_1.duration_ = var_415_8 + var_415_0
					end

					if var_415_3.prefab_name ~= "" and arg_412_1.actors_[var_415_3.prefab_name] ~= nil then
						local var_415_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_412_1.actors_[var_415_3.prefab_name].transform, "story_v_out_121421", "121421102", "story_v_out_121421.awb")

						arg_412_1:RecordAudio("121421102", var_415_9)
						arg_412_1:RecordAudio("121421102", var_415_9)
					else
						arg_412_1:AudioAction("play", "voice", "story_v_out_121421", "121421102", "story_v_out_121421.awb")
					end

					arg_412_1:RecordHistoryTalkVoice("story_v_out_121421", "121421102", "story_v_out_121421.awb")
				end

				arg_412_1:RecordContent(arg_412_1.text_.text)
			end

			local var_415_10 = math.max(var_415_1, arg_412_1.talkMaxDuration)

			if var_415_0 <= arg_412_1.time_ and arg_412_1.time_ < var_415_0 + var_415_10 then
				arg_412_1.typewritter.percent = (arg_412_1.time_ - var_415_0) / var_415_10

				arg_412_1.typewritter:SetDirty()
			end

			if arg_412_1.time_ >= var_415_0 + var_415_10 and arg_412_1.time_ < var_415_0 + var_415_10 + arg_415_0 then
				arg_412_1.typewritter.percent = 1

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(true)
			end
		end

		arg_412_1.nodeConfigList_ = {}

		arg_412_1:InitPlayNodeList()
	end,
	Play121421103 = function(arg_416_0, arg_416_1)
		arg_416_1.time_ = 0
		arg_416_1.frameCnt_ = 0
		arg_416_1.state_ = "playing"
		arg_416_1.curTalkId_ = 121421103
		arg_416_1.duration_ = 5

		SetActive(arg_416_1.tipsGo_, false)

		function arg_416_1.onSingleLineFinish_()
			arg_416_1.onSingleLineUpdate_ = nil
			arg_416_1.onSingleLineFinish_ = nil
			arg_416_1.state_ = "waiting"
		end

		function arg_416_1.playNext_(arg_418_0)
			if arg_418_0 == 1 then
				arg_416_0:Play121421104(arg_416_1)
			end
		end

		function arg_416_1.onSingleLineUpdate_(arg_419_0)
			local var_419_0 = arg_416_1.actors_["1072ui_story"]
			local var_419_1 = 0

			if var_419_1 < arg_416_1.time_ and arg_416_1.time_ <= var_419_1 + arg_419_0 and not isNil(var_419_0) and arg_416_1.var_.characterEffect1072ui_story == nil then
				arg_416_1.var_.characterEffect1072ui_story = var_419_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_419_2 = 0.200000002980232

			if var_419_1 <= arg_416_1.time_ and arg_416_1.time_ < var_419_1 + var_419_2 and not isNil(var_419_0) then
				local var_419_3 = (arg_416_1.time_ - var_419_1) / var_419_2

				if arg_416_1.var_.characterEffect1072ui_story and not isNil(var_419_0) then
					local var_419_4 = Mathf.Lerp(0, 0.5, var_419_3)

					arg_416_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_416_1.var_.characterEffect1072ui_story.fillRatio = var_419_4
				end
			end

			if arg_416_1.time_ >= var_419_1 + var_419_2 and arg_416_1.time_ < var_419_1 + var_419_2 + arg_419_0 and not isNil(var_419_0) and arg_416_1.var_.characterEffect1072ui_story then
				local var_419_5 = 0.5

				arg_416_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_416_1.var_.characterEffect1072ui_story.fillRatio = var_419_5
			end

			local var_419_6 = 0
			local var_419_7 = 0.25

			if var_419_6 < arg_416_1.time_ and arg_416_1.time_ <= var_419_6 + arg_419_0 then
				arg_416_1.talkMaxDuration = 0
				arg_416_1.dialogCg_.alpha = 1

				arg_416_1.dialog_:SetActive(true)
				SetActive(arg_416_1.leftNameGo_, true)

				local var_419_8 = arg_416_1:FormatText(StoryNameCfg[7].name)

				arg_416_1.leftNameTxt_.text = var_419_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_416_1.leftNameTxt_.transform)

				arg_416_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_416_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_416_1:RecordName(arg_416_1.leftNameTxt_.text)
				SetActive(arg_416_1.iconTrs_.gameObject, true)
				arg_416_1.iconController_:SetSelectedState("hero")

				arg_416_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_416_1.callingController_:SetSelectedState("normal")

				arg_416_1.keyicon_.color = Color.New(1, 1, 1)
				arg_416_1.icon_.color = Color.New(1, 1, 1)

				local var_419_9 = arg_416_1:GetWordFromCfg(121421103)
				local var_419_10 = arg_416_1:FormatText(var_419_9.content)

				arg_416_1.text_.text = var_419_10

				LuaForUtil.ClearLinePrefixSymbol(arg_416_1.text_)

				local var_419_11 = 10
				local var_419_12 = utf8.len(var_419_10)
				local var_419_13 = var_419_11 <= 0 and var_419_7 or var_419_7 * (var_419_12 / var_419_11)

				if var_419_13 > 0 and var_419_7 < var_419_13 then
					arg_416_1.talkMaxDuration = var_419_13

					if var_419_13 + var_419_6 > arg_416_1.duration_ then
						arg_416_1.duration_ = var_419_13 + var_419_6
					end
				end

				arg_416_1.text_.text = var_419_10
				arg_416_1.typewritter.percent = 0

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(false)
				arg_416_1:RecordContent(arg_416_1.text_.text)
			end

			local var_419_14 = math.max(var_419_7, arg_416_1.talkMaxDuration)

			if var_419_6 <= arg_416_1.time_ and arg_416_1.time_ < var_419_6 + var_419_14 then
				arg_416_1.typewritter.percent = (arg_416_1.time_ - var_419_6) / var_419_14

				arg_416_1.typewritter:SetDirty()
			end

			if arg_416_1.time_ >= var_419_6 + var_419_14 and arg_416_1.time_ < var_419_6 + var_419_14 + arg_419_0 then
				arg_416_1.typewritter.percent = 1

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(true)
			end
		end

		arg_416_1.nodeConfigList_ = {}

		arg_416_1:InitPlayNodeList()
	end,
	Play121421104 = function(arg_420_0, arg_420_1)
		arg_420_1.time_ = 0
		arg_420_1.frameCnt_ = 0
		arg_420_1.state_ = "playing"
		arg_420_1.curTalkId_ = 121421104
		arg_420_1.duration_ = 11.97

		local var_420_0 = {
			ja = 11.966,
			ko = 8.1,
			zh = 8.1
		}
		local var_420_1 = manager.audio:GetLocalizationFlag()

		if var_420_0[var_420_1] ~= nil then
			arg_420_1.duration_ = var_420_0[var_420_1]
		end

		SetActive(arg_420_1.tipsGo_, false)

		function arg_420_1.onSingleLineFinish_()
			arg_420_1.onSingleLineUpdate_ = nil
			arg_420_1.onSingleLineFinish_ = nil
			arg_420_1.state_ = "waiting"
		end

		function arg_420_1.playNext_(arg_422_0)
			if arg_422_0 == 1 then
				arg_420_0:Play121421105(arg_420_1)
			end
		end

		function arg_420_1.onSingleLineUpdate_(arg_423_0)
			local var_423_0 = arg_420_1.actors_["1072ui_story"]
			local var_423_1 = 0

			if var_423_1 < arg_420_1.time_ and arg_420_1.time_ <= var_423_1 + arg_423_0 and not isNil(var_423_0) and arg_420_1.var_.characterEffect1072ui_story == nil then
				arg_420_1.var_.characterEffect1072ui_story = var_423_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_423_2 = 0.200000002980232

			if var_423_1 <= arg_420_1.time_ and arg_420_1.time_ < var_423_1 + var_423_2 and not isNil(var_423_0) then
				local var_423_3 = (arg_420_1.time_ - var_423_1) / var_423_2

				if arg_420_1.var_.characterEffect1072ui_story and not isNil(var_423_0) then
					arg_420_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_420_1.time_ >= var_423_1 + var_423_2 and arg_420_1.time_ < var_423_1 + var_423_2 + arg_423_0 and not isNil(var_423_0) and arg_420_1.var_.characterEffect1072ui_story then
				arg_420_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_423_4 = 0

			if var_423_4 < arg_420_1.time_ and arg_420_1.time_ <= var_423_4 + arg_423_0 then
				arg_420_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action2_1")
			end

			local var_423_5 = 0

			if var_423_5 < arg_420_1.time_ and arg_420_1.time_ <= var_423_5 + arg_423_0 then
				arg_420_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_423_6 = 0
			local var_423_7 = 0.95

			if var_423_6 < arg_420_1.time_ and arg_420_1.time_ <= var_423_6 + arg_423_0 then
				arg_420_1.talkMaxDuration = 0
				arg_420_1.dialogCg_.alpha = 1

				arg_420_1.dialog_:SetActive(true)
				SetActive(arg_420_1.leftNameGo_, true)

				local var_423_8 = arg_420_1:FormatText(StoryNameCfg[379].name)

				arg_420_1.leftNameTxt_.text = var_423_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_420_1.leftNameTxt_.transform)

				arg_420_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_420_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_420_1:RecordName(arg_420_1.leftNameTxt_.text)
				SetActive(arg_420_1.iconTrs_.gameObject, false)
				arg_420_1.callingController_:SetSelectedState("normal")

				local var_423_9 = arg_420_1:GetWordFromCfg(121421104)
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

				if manager.audio:GetVoiceLength("story_v_out_121421", "121421104", "story_v_out_121421.awb") ~= 0 then
					local var_423_14 = manager.audio:GetVoiceLength("story_v_out_121421", "121421104", "story_v_out_121421.awb") / 1000

					if var_423_14 + var_423_6 > arg_420_1.duration_ then
						arg_420_1.duration_ = var_423_14 + var_423_6
					end

					if var_423_9.prefab_name ~= "" and arg_420_1.actors_[var_423_9.prefab_name] ~= nil then
						local var_423_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_420_1.actors_[var_423_9.prefab_name].transform, "story_v_out_121421", "121421104", "story_v_out_121421.awb")

						arg_420_1:RecordAudio("121421104", var_423_15)
						arg_420_1:RecordAudio("121421104", var_423_15)
					else
						arg_420_1:AudioAction("play", "voice", "story_v_out_121421", "121421104", "story_v_out_121421.awb")
					end

					arg_420_1:RecordHistoryTalkVoice("story_v_out_121421", "121421104", "story_v_out_121421.awb")
				end

				arg_420_1:RecordContent(arg_420_1.text_.text)
			end

			local var_423_16 = math.max(var_423_7, arg_420_1.talkMaxDuration)

			if var_423_6 <= arg_420_1.time_ and arg_420_1.time_ < var_423_6 + var_423_16 then
				arg_420_1.typewritter.percent = (arg_420_1.time_ - var_423_6) / var_423_16

				arg_420_1.typewritter:SetDirty()
			end

			if arg_420_1.time_ >= var_423_6 + var_423_16 and arg_420_1.time_ < var_423_6 + var_423_16 + arg_423_0 then
				arg_420_1.typewritter.percent = 1

				arg_420_1.typewritter:SetDirty()
				arg_420_1:ShowNextGo(true)
			end
		end

		arg_420_1.nodeConfigList_ = {}

		arg_420_1:InitPlayNodeList()
	end,
	Play121421105 = function(arg_424_0, arg_424_1)
		arg_424_1.time_ = 0
		arg_424_1.frameCnt_ = 0
		arg_424_1.state_ = "playing"
		arg_424_1.curTalkId_ = 121421105
		arg_424_1.duration_ = 7

		local var_424_0 = {
			ja = 6.633,
			ko = 7,
			zh = 7
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
				arg_424_0:Play121421106(arg_424_1)
			end
		end

		function arg_424_1.onSingleLineUpdate_(arg_427_0)
			local var_427_0 = 0

			if var_427_0 < arg_424_1.time_ and arg_424_1.time_ <= var_427_0 + arg_427_0 then
				arg_424_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action2_2")
			end

			local var_427_1 = 0

			if var_427_1 < arg_424_1.time_ and arg_424_1.time_ <= var_427_1 + arg_427_0 then
				arg_424_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_427_2 = 0
			local var_427_3 = 0.95

			if var_427_2 < arg_424_1.time_ and arg_424_1.time_ <= var_427_2 + arg_427_0 then
				arg_424_1.talkMaxDuration = 0
				arg_424_1.dialogCg_.alpha = 1

				arg_424_1.dialog_:SetActive(true)
				SetActive(arg_424_1.leftNameGo_, true)

				local var_427_4 = arg_424_1:FormatText(StoryNameCfg[379].name)

				arg_424_1.leftNameTxt_.text = var_427_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_424_1.leftNameTxt_.transform)

				arg_424_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_424_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_424_1:RecordName(arg_424_1.leftNameTxt_.text)
				SetActive(arg_424_1.iconTrs_.gameObject, false)
				arg_424_1.callingController_:SetSelectedState("normal")

				local var_427_5 = arg_424_1:GetWordFromCfg(121421105)
				local var_427_6 = arg_424_1:FormatText(var_427_5.content)

				arg_424_1.text_.text = var_427_6

				LuaForUtil.ClearLinePrefixSymbol(arg_424_1.text_)

				local var_427_7 = 38
				local var_427_8 = utf8.len(var_427_6)
				local var_427_9 = var_427_7 <= 0 and var_427_3 or var_427_3 * (var_427_8 / var_427_7)

				if var_427_9 > 0 and var_427_3 < var_427_9 then
					arg_424_1.talkMaxDuration = var_427_9

					if var_427_9 + var_427_2 > arg_424_1.duration_ then
						arg_424_1.duration_ = var_427_9 + var_427_2
					end
				end

				arg_424_1.text_.text = var_427_6
				arg_424_1.typewritter.percent = 0

				arg_424_1.typewritter:SetDirty()
				arg_424_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121421", "121421105", "story_v_out_121421.awb") ~= 0 then
					local var_427_10 = manager.audio:GetVoiceLength("story_v_out_121421", "121421105", "story_v_out_121421.awb") / 1000

					if var_427_10 + var_427_2 > arg_424_1.duration_ then
						arg_424_1.duration_ = var_427_10 + var_427_2
					end

					if var_427_5.prefab_name ~= "" and arg_424_1.actors_[var_427_5.prefab_name] ~= nil then
						local var_427_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_424_1.actors_[var_427_5.prefab_name].transform, "story_v_out_121421", "121421105", "story_v_out_121421.awb")

						arg_424_1:RecordAudio("121421105", var_427_11)
						arg_424_1:RecordAudio("121421105", var_427_11)
					else
						arg_424_1:AudioAction("play", "voice", "story_v_out_121421", "121421105", "story_v_out_121421.awb")
					end

					arg_424_1:RecordHistoryTalkVoice("story_v_out_121421", "121421105", "story_v_out_121421.awb")
				end

				arg_424_1:RecordContent(arg_424_1.text_.text)
			end

			local var_427_12 = math.max(var_427_3, arg_424_1.talkMaxDuration)

			if var_427_2 <= arg_424_1.time_ and arg_424_1.time_ < var_427_2 + var_427_12 then
				arg_424_1.typewritter.percent = (arg_424_1.time_ - var_427_2) / var_427_12

				arg_424_1.typewritter:SetDirty()
			end

			if arg_424_1.time_ >= var_427_2 + var_427_12 and arg_424_1.time_ < var_427_2 + var_427_12 + arg_427_0 then
				arg_424_1.typewritter.percent = 1

				arg_424_1.typewritter:SetDirty()
				arg_424_1:ShowNextGo(true)
			end
		end

		arg_424_1.nodeConfigList_ = {}

		arg_424_1:InitPlayNodeList()
	end,
	Play121421106 = function(arg_428_0, arg_428_1)
		arg_428_1.time_ = 0
		arg_428_1.frameCnt_ = 0
		arg_428_1.state_ = "playing"
		arg_428_1.curTalkId_ = 121421106
		arg_428_1.duration_ = 8.97

		local var_428_0 = {
			ja = 8.866,
			ko = 8.966,
			zh = 8.966
		}
		local var_428_1 = manager.audio:GetLocalizationFlag()

		if var_428_0[var_428_1] ~= nil then
			arg_428_1.duration_ = var_428_0[var_428_1]
		end

		SetActive(arg_428_1.tipsGo_, false)

		function arg_428_1.onSingleLineFinish_()
			arg_428_1.onSingleLineUpdate_ = nil
			arg_428_1.onSingleLineFinish_ = nil
			arg_428_1.state_ = "waiting"
		end

		function arg_428_1.playNext_(arg_430_0)
			if arg_430_0 == 1 then
				arg_428_0:Play121421107(arg_428_1)
			end
		end

		function arg_428_1.onSingleLineUpdate_(arg_431_0)
			local var_431_0 = 0

			if var_431_0 < arg_428_1.time_ and arg_428_1.time_ <= var_431_0 + arg_431_0 then
				arg_428_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action6_1")
			end

			local var_431_1 = 0

			if var_431_1 < arg_428_1.time_ and arg_428_1.time_ <= var_431_1 + arg_431_0 then
				arg_428_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_431_2 = 0
			local var_431_3 = 0.95

			if var_431_2 < arg_428_1.time_ and arg_428_1.time_ <= var_431_2 + arg_431_0 then
				arg_428_1.talkMaxDuration = 0
				arg_428_1.dialogCg_.alpha = 1

				arg_428_1.dialog_:SetActive(true)
				SetActive(arg_428_1.leftNameGo_, true)

				local var_431_4 = arg_428_1:FormatText(StoryNameCfg[379].name)

				arg_428_1.leftNameTxt_.text = var_431_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_428_1.leftNameTxt_.transform)

				arg_428_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_428_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_428_1:RecordName(arg_428_1.leftNameTxt_.text)
				SetActive(arg_428_1.iconTrs_.gameObject, false)
				arg_428_1.callingController_:SetSelectedState("normal")

				local var_431_5 = arg_428_1:GetWordFromCfg(121421106)
				local var_431_6 = arg_428_1:FormatText(var_431_5.content)

				arg_428_1.text_.text = var_431_6

				LuaForUtil.ClearLinePrefixSymbol(arg_428_1.text_)

				local var_431_7 = 38
				local var_431_8 = utf8.len(var_431_6)
				local var_431_9 = var_431_7 <= 0 and var_431_3 or var_431_3 * (var_431_8 / var_431_7)

				if var_431_9 > 0 and var_431_3 < var_431_9 then
					arg_428_1.talkMaxDuration = var_431_9

					if var_431_9 + var_431_2 > arg_428_1.duration_ then
						arg_428_1.duration_ = var_431_9 + var_431_2
					end
				end

				arg_428_1.text_.text = var_431_6
				arg_428_1.typewritter.percent = 0

				arg_428_1.typewritter:SetDirty()
				arg_428_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121421", "121421106", "story_v_out_121421.awb") ~= 0 then
					local var_431_10 = manager.audio:GetVoiceLength("story_v_out_121421", "121421106", "story_v_out_121421.awb") / 1000

					if var_431_10 + var_431_2 > arg_428_1.duration_ then
						arg_428_1.duration_ = var_431_10 + var_431_2
					end

					if var_431_5.prefab_name ~= "" and arg_428_1.actors_[var_431_5.prefab_name] ~= nil then
						local var_431_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_428_1.actors_[var_431_5.prefab_name].transform, "story_v_out_121421", "121421106", "story_v_out_121421.awb")

						arg_428_1:RecordAudio("121421106", var_431_11)
						arg_428_1:RecordAudio("121421106", var_431_11)
					else
						arg_428_1:AudioAction("play", "voice", "story_v_out_121421", "121421106", "story_v_out_121421.awb")
					end

					arg_428_1:RecordHistoryTalkVoice("story_v_out_121421", "121421106", "story_v_out_121421.awb")
				end

				arg_428_1:RecordContent(arg_428_1.text_.text)
			end

			local var_431_12 = math.max(var_431_3, arg_428_1.talkMaxDuration)

			if var_431_2 <= arg_428_1.time_ and arg_428_1.time_ < var_431_2 + var_431_12 then
				arg_428_1.typewritter.percent = (arg_428_1.time_ - var_431_2) / var_431_12

				arg_428_1.typewritter:SetDirty()
			end

			if arg_428_1.time_ >= var_431_2 + var_431_12 and arg_428_1.time_ < var_431_2 + var_431_12 + arg_431_0 then
				arg_428_1.typewritter.percent = 1

				arg_428_1.typewritter:SetDirty()
				arg_428_1:ShowNextGo(true)
			end
		end

		arg_428_1.nodeConfigList_ = {}

		arg_428_1:InitPlayNodeList()
	end,
	Play121421107 = function(arg_432_0, arg_432_1)
		arg_432_1.time_ = 0
		arg_432_1.frameCnt_ = 0
		arg_432_1.state_ = "playing"
		arg_432_1.curTalkId_ = 121421107
		arg_432_1.duration_ = 12.93

		local var_432_0 = {
			ja = 10.166,
			ko = 12.933,
			zh = 12.933
		}
		local var_432_1 = manager.audio:GetLocalizationFlag()

		if var_432_0[var_432_1] ~= nil then
			arg_432_1.duration_ = var_432_0[var_432_1]
		end

		SetActive(arg_432_1.tipsGo_, false)

		function arg_432_1.onSingleLineFinish_()
			arg_432_1.onSingleLineUpdate_ = nil
			arg_432_1.onSingleLineFinish_ = nil
			arg_432_1.state_ = "waiting"
		end

		function arg_432_1.playNext_(arg_434_0)
			if arg_434_0 == 1 then
				arg_432_0:Play121421108(arg_432_1)
			end
		end

		function arg_432_1.onSingleLineUpdate_(arg_435_0)
			local var_435_0 = 0
			local var_435_1 = 1.4

			if var_435_0 < arg_432_1.time_ and arg_432_1.time_ <= var_435_0 + arg_435_0 then
				arg_432_1.talkMaxDuration = 0
				arg_432_1.dialogCg_.alpha = 1

				arg_432_1.dialog_:SetActive(true)
				SetActive(arg_432_1.leftNameGo_, true)

				local var_435_2 = arg_432_1:FormatText(StoryNameCfg[379].name)

				arg_432_1.leftNameTxt_.text = var_435_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_432_1.leftNameTxt_.transform)

				arg_432_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_432_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_432_1:RecordName(arg_432_1.leftNameTxt_.text)
				SetActive(arg_432_1.iconTrs_.gameObject, false)
				arg_432_1.callingController_:SetSelectedState("normal")

				local var_435_3 = arg_432_1:GetWordFromCfg(121421107)
				local var_435_4 = arg_432_1:FormatText(var_435_3.content)

				arg_432_1.text_.text = var_435_4

				LuaForUtil.ClearLinePrefixSymbol(arg_432_1.text_)

				local var_435_5 = 56
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

				if manager.audio:GetVoiceLength("story_v_out_121421", "121421107", "story_v_out_121421.awb") ~= 0 then
					local var_435_8 = manager.audio:GetVoiceLength("story_v_out_121421", "121421107", "story_v_out_121421.awb") / 1000

					if var_435_8 + var_435_0 > arg_432_1.duration_ then
						arg_432_1.duration_ = var_435_8 + var_435_0
					end

					if var_435_3.prefab_name ~= "" and arg_432_1.actors_[var_435_3.prefab_name] ~= nil then
						local var_435_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_432_1.actors_[var_435_3.prefab_name].transform, "story_v_out_121421", "121421107", "story_v_out_121421.awb")

						arg_432_1:RecordAudio("121421107", var_435_9)
						arg_432_1:RecordAudio("121421107", var_435_9)
					else
						arg_432_1:AudioAction("play", "voice", "story_v_out_121421", "121421107", "story_v_out_121421.awb")
					end

					arg_432_1:RecordHistoryTalkVoice("story_v_out_121421", "121421107", "story_v_out_121421.awb")
				end

				arg_432_1:RecordContent(arg_432_1.text_.text)
			end

			local var_435_10 = math.max(var_435_1, arg_432_1.talkMaxDuration)

			if var_435_0 <= arg_432_1.time_ and arg_432_1.time_ < var_435_0 + var_435_10 then
				arg_432_1.typewritter.percent = (arg_432_1.time_ - var_435_0) / var_435_10

				arg_432_1.typewritter:SetDirty()
			end

			if arg_432_1.time_ >= var_435_0 + var_435_10 and arg_432_1.time_ < var_435_0 + var_435_10 + arg_435_0 then
				arg_432_1.typewritter.percent = 1

				arg_432_1.typewritter:SetDirty()
				arg_432_1:ShowNextGo(true)
			end
		end

		arg_432_1.nodeConfigList_ = {}

		arg_432_1:InitPlayNodeList()
	end,
	Play121421108 = function(arg_436_0, arg_436_1)
		arg_436_1.time_ = 0
		arg_436_1.frameCnt_ = 0
		arg_436_1.state_ = "playing"
		arg_436_1.curTalkId_ = 121421108
		arg_436_1.duration_ = 6.6

		local var_436_0 = {
			ja = 6.6,
			ko = 5.166,
			zh = 5.166
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
				arg_436_0:Play121421109(arg_436_1)
			end
		end

		function arg_436_1.onSingleLineUpdate_(arg_439_0)
			local var_439_0 = 0
			local var_439_1 = 0.4

			if var_439_0 < arg_436_1.time_ and arg_436_1.time_ <= var_439_0 + arg_439_0 then
				arg_436_1.talkMaxDuration = 0
				arg_436_1.dialogCg_.alpha = 1

				arg_436_1.dialog_:SetActive(true)
				SetActive(arg_436_1.leftNameGo_, true)

				local var_439_2 = arg_436_1:FormatText(StoryNameCfg[379].name)

				arg_436_1.leftNameTxt_.text = var_439_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_436_1.leftNameTxt_.transform)

				arg_436_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_436_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_436_1:RecordName(arg_436_1.leftNameTxt_.text)
				SetActive(arg_436_1.iconTrs_.gameObject, false)
				arg_436_1.callingController_:SetSelectedState("normal")

				local var_439_3 = arg_436_1:GetWordFromCfg(121421108)
				local var_439_4 = arg_436_1:FormatText(var_439_3.content)

				arg_436_1.text_.text = var_439_4

				LuaForUtil.ClearLinePrefixSymbol(arg_436_1.text_)

				local var_439_5 = 16
				local var_439_6 = utf8.len(var_439_4)
				local var_439_7 = var_439_5 <= 0 and var_439_1 or var_439_1 * (var_439_6 / var_439_5)

				if var_439_7 > 0 and var_439_1 < var_439_7 then
					arg_436_1.talkMaxDuration = var_439_7

					if var_439_7 + var_439_0 > arg_436_1.duration_ then
						arg_436_1.duration_ = var_439_7 + var_439_0
					end
				end

				arg_436_1.text_.text = var_439_4
				arg_436_1.typewritter.percent = 0

				arg_436_1.typewritter:SetDirty()
				arg_436_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121421", "121421108", "story_v_out_121421.awb") ~= 0 then
					local var_439_8 = manager.audio:GetVoiceLength("story_v_out_121421", "121421108", "story_v_out_121421.awb") / 1000

					if var_439_8 + var_439_0 > arg_436_1.duration_ then
						arg_436_1.duration_ = var_439_8 + var_439_0
					end

					if var_439_3.prefab_name ~= "" and arg_436_1.actors_[var_439_3.prefab_name] ~= nil then
						local var_439_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_436_1.actors_[var_439_3.prefab_name].transform, "story_v_out_121421", "121421108", "story_v_out_121421.awb")

						arg_436_1:RecordAudio("121421108", var_439_9)
						arg_436_1:RecordAudio("121421108", var_439_9)
					else
						arg_436_1:AudioAction("play", "voice", "story_v_out_121421", "121421108", "story_v_out_121421.awb")
					end

					arg_436_1:RecordHistoryTalkVoice("story_v_out_121421", "121421108", "story_v_out_121421.awb")
				end

				arg_436_1:RecordContent(arg_436_1.text_.text)
			end

			local var_439_10 = math.max(var_439_1, arg_436_1.talkMaxDuration)

			if var_439_0 <= arg_436_1.time_ and arg_436_1.time_ < var_439_0 + var_439_10 then
				arg_436_1.typewritter.percent = (arg_436_1.time_ - var_439_0) / var_439_10

				arg_436_1.typewritter:SetDirty()
			end

			if arg_436_1.time_ >= var_439_0 + var_439_10 and arg_436_1.time_ < var_439_0 + var_439_10 + arg_439_0 then
				arg_436_1.typewritter.percent = 1

				arg_436_1.typewritter:SetDirty()
				arg_436_1:ShowNextGo(true)
			end
		end

		arg_436_1.nodeConfigList_ = {}

		arg_436_1:InitPlayNodeList()
	end,
	Play121421109 = function(arg_440_0, arg_440_1)
		arg_440_1.time_ = 0
		arg_440_1.frameCnt_ = 0
		arg_440_1.state_ = "playing"
		arg_440_1.curTalkId_ = 121421109
		arg_440_1.duration_ = 2

		SetActive(arg_440_1.tipsGo_, false)

		function arg_440_1.onSingleLineFinish_()
			arg_440_1.onSingleLineUpdate_ = nil
			arg_440_1.onSingleLineFinish_ = nil
			arg_440_1.state_ = "waiting"
		end

		function arg_440_1.playNext_(arg_442_0)
			if arg_442_0 == 1 then
				arg_440_0:Play121421110(arg_440_1)
			end
		end

		function arg_440_1.onSingleLineUpdate_(arg_443_0)
			local var_443_0 = arg_440_1.actors_["1084ui_story"]
			local var_443_1 = 0

			if var_443_1 < arg_440_1.time_ and arg_440_1.time_ <= var_443_1 + arg_443_0 and not isNil(var_443_0) and arg_440_1.var_.characterEffect1084ui_story == nil then
				arg_440_1.var_.characterEffect1084ui_story = var_443_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_443_2 = 0.200000002980232

			if var_443_1 <= arg_440_1.time_ and arg_440_1.time_ < var_443_1 + var_443_2 and not isNil(var_443_0) then
				local var_443_3 = (arg_440_1.time_ - var_443_1) / var_443_2

				if arg_440_1.var_.characterEffect1084ui_story and not isNil(var_443_0) then
					arg_440_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_440_1.time_ >= var_443_1 + var_443_2 and arg_440_1.time_ < var_443_1 + var_443_2 + arg_443_0 and not isNil(var_443_0) and arg_440_1.var_.characterEffect1084ui_story then
				arg_440_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_443_4 = 0

			if var_443_4 < arg_440_1.time_ and arg_440_1.time_ <= var_443_4 + arg_443_0 then
				arg_440_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_443_5 = arg_440_1.actors_["1072ui_story"]
			local var_443_6 = 0

			if var_443_6 < arg_440_1.time_ and arg_440_1.time_ <= var_443_6 + arg_443_0 and not isNil(var_443_5) and arg_440_1.var_.characterEffect1072ui_story == nil then
				arg_440_1.var_.characterEffect1072ui_story = var_443_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_443_7 = 0.200000002980232

			if var_443_6 <= arg_440_1.time_ and arg_440_1.time_ < var_443_6 + var_443_7 and not isNil(var_443_5) then
				local var_443_8 = (arg_440_1.time_ - var_443_6) / var_443_7

				if arg_440_1.var_.characterEffect1072ui_story and not isNil(var_443_5) then
					local var_443_9 = Mathf.Lerp(0, 0.5, var_443_8)

					arg_440_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_440_1.var_.characterEffect1072ui_story.fillRatio = var_443_9
				end
			end

			if arg_440_1.time_ >= var_443_6 + var_443_7 and arg_440_1.time_ < var_443_6 + var_443_7 + arg_443_0 and not isNil(var_443_5) and arg_440_1.var_.characterEffect1072ui_story then
				local var_443_10 = 0.5

				arg_440_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_440_1.var_.characterEffect1072ui_story.fillRatio = var_443_10
			end

			local var_443_11 = 0
			local var_443_12 = 0.15

			if var_443_11 < arg_440_1.time_ and arg_440_1.time_ <= var_443_11 + arg_443_0 then
				arg_440_1.talkMaxDuration = 0
				arg_440_1.dialogCg_.alpha = 1

				arg_440_1.dialog_:SetActive(true)
				SetActive(arg_440_1.leftNameGo_, true)

				local var_443_13 = arg_440_1:FormatText(StoryNameCfg[6].name)

				arg_440_1.leftNameTxt_.text = var_443_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_440_1.leftNameTxt_.transform)

				arg_440_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_440_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_440_1:RecordName(arg_440_1.leftNameTxt_.text)
				SetActive(arg_440_1.iconTrs_.gameObject, false)
				arg_440_1.callingController_:SetSelectedState("normal")

				local var_443_14 = arg_440_1:GetWordFromCfg(121421109)
				local var_443_15 = arg_440_1:FormatText(var_443_14.content)

				arg_440_1.text_.text = var_443_15

				LuaForUtil.ClearLinePrefixSymbol(arg_440_1.text_)

				local var_443_16 = 6
				local var_443_17 = utf8.len(var_443_15)
				local var_443_18 = var_443_16 <= 0 and var_443_12 or var_443_12 * (var_443_17 / var_443_16)

				if var_443_18 > 0 and var_443_12 < var_443_18 then
					arg_440_1.talkMaxDuration = var_443_18

					if var_443_18 + var_443_11 > arg_440_1.duration_ then
						arg_440_1.duration_ = var_443_18 + var_443_11
					end
				end

				arg_440_1.text_.text = var_443_15
				arg_440_1.typewritter.percent = 0

				arg_440_1.typewritter:SetDirty()
				arg_440_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121421", "121421109", "story_v_out_121421.awb") ~= 0 then
					local var_443_19 = manager.audio:GetVoiceLength("story_v_out_121421", "121421109", "story_v_out_121421.awb") / 1000

					if var_443_19 + var_443_11 > arg_440_1.duration_ then
						arg_440_1.duration_ = var_443_19 + var_443_11
					end

					if var_443_14.prefab_name ~= "" and arg_440_1.actors_[var_443_14.prefab_name] ~= nil then
						local var_443_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_440_1.actors_[var_443_14.prefab_name].transform, "story_v_out_121421", "121421109", "story_v_out_121421.awb")

						arg_440_1:RecordAudio("121421109", var_443_20)
						arg_440_1:RecordAudio("121421109", var_443_20)
					else
						arg_440_1:AudioAction("play", "voice", "story_v_out_121421", "121421109", "story_v_out_121421.awb")
					end

					arg_440_1:RecordHistoryTalkVoice("story_v_out_121421", "121421109", "story_v_out_121421.awb")
				end

				arg_440_1:RecordContent(arg_440_1.text_.text)
			end

			local var_443_21 = math.max(var_443_12, arg_440_1.talkMaxDuration)

			if var_443_11 <= arg_440_1.time_ and arg_440_1.time_ < var_443_11 + var_443_21 then
				arg_440_1.typewritter.percent = (arg_440_1.time_ - var_443_11) / var_443_21

				arg_440_1.typewritter:SetDirty()
			end

			if arg_440_1.time_ >= var_443_11 + var_443_21 and arg_440_1.time_ < var_443_11 + var_443_21 + arg_443_0 then
				arg_440_1.typewritter.percent = 1

				arg_440_1.typewritter:SetDirty()
				arg_440_1:ShowNextGo(true)
			end
		end

		arg_440_1.nodeConfigList_ = {}

		arg_440_1:InitPlayNodeList()
	end,
	Play121421110 = function(arg_444_0, arg_444_1)
		arg_444_1.time_ = 0
		arg_444_1.frameCnt_ = 0
		arg_444_1.state_ = "playing"
		arg_444_1.curTalkId_ = 121421110
		arg_444_1.duration_ = 5

		SetActive(arg_444_1.tipsGo_, false)

		function arg_444_1.onSingleLineFinish_()
			arg_444_1.onSingleLineUpdate_ = nil
			arg_444_1.onSingleLineFinish_ = nil
			arg_444_1.state_ = "waiting"
		end

		function arg_444_1.playNext_(arg_446_0)
			if arg_446_0 == 1 then
				arg_444_0:Play121421111(arg_444_1)
			end
		end

		function arg_444_1.onSingleLineUpdate_(arg_447_0)
			local var_447_0 = arg_444_1.actors_["1072ui_story"].transform
			local var_447_1 = 0

			if var_447_1 < arg_444_1.time_ and arg_444_1.time_ <= var_447_1 + arg_447_0 then
				arg_444_1.var_.moveOldPos1072ui_story = var_447_0.localPosition
			end

			local var_447_2 = 0.001

			if var_447_1 <= arg_444_1.time_ and arg_444_1.time_ < var_447_1 + var_447_2 then
				local var_447_3 = (arg_444_1.time_ - var_447_1) / var_447_2
				local var_447_4 = Vector3.New(0, 100, 0)

				var_447_0.localPosition = Vector3.Lerp(arg_444_1.var_.moveOldPos1072ui_story, var_447_4, var_447_3)

				local var_447_5 = manager.ui.mainCamera.transform.position - var_447_0.position

				var_447_0.forward = Vector3.New(var_447_5.x, var_447_5.y, var_447_5.z)

				local var_447_6 = var_447_0.localEulerAngles

				var_447_6.z = 0
				var_447_6.x = 0
				var_447_0.localEulerAngles = var_447_6
			end

			if arg_444_1.time_ >= var_447_1 + var_447_2 and arg_444_1.time_ < var_447_1 + var_447_2 + arg_447_0 then
				var_447_0.localPosition = Vector3.New(0, 100, 0)

				local var_447_7 = manager.ui.mainCamera.transform.position - var_447_0.position

				var_447_0.forward = Vector3.New(var_447_7.x, var_447_7.y, var_447_7.z)

				local var_447_8 = var_447_0.localEulerAngles

				var_447_8.z = 0
				var_447_8.x = 0
				var_447_0.localEulerAngles = var_447_8
			end

			local var_447_9 = arg_444_1.actors_["1072ui_story"]
			local var_447_10 = 0

			if var_447_10 < arg_444_1.time_ and arg_444_1.time_ <= var_447_10 + arg_447_0 and not isNil(var_447_9) and arg_444_1.var_.characterEffect1072ui_story == nil then
				arg_444_1.var_.characterEffect1072ui_story = var_447_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_447_11 = 0.200000002980232

			if var_447_10 <= arg_444_1.time_ and arg_444_1.time_ < var_447_10 + var_447_11 and not isNil(var_447_9) then
				local var_447_12 = (arg_444_1.time_ - var_447_10) / var_447_11

				if arg_444_1.var_.characterEffect1072ui_story and not isNil(var_447_9) then
					local var_447_13 = Mathf.Lerp(0, 0.5, var_447_12)

					arg_444_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_444_1.var_.characterEffect1072ui_story.fillRatio = var_447_13
				end
			end

			if arg_444_1.time_ >= var_447_10 + var_447_11 and arg_444_1.time_ < var_447_10 + var_447_11 + arg_447_0 and not isNil(var_447_9) and arg_444_1.var_.characterEffect1072ui_story then
				local var_447_14 = 0.5

				arg_444_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_444_1.var_.characterEffect1072ui_story.fillRatio = var_447_14
			end

			local var_447_15 = arg_444_1.actors_["1084ui_story"].transform
			local var_447_16 = 0

			if var_447_16 < arg_444_1.time_ and arg_444_1.time_ <= var_447_16 + arg_447_0 then
				arg_444_1.var_.moveOldPos1084ui_story = var_447_15.localPosition
			end

			local var_447_17 = 0.001

			if var_447_16 <= arg_444_1.time_ and arg_444_1.time_ < var_447_16 + var_447_17 then
				local var_447_18 = (arg_444_1.time_ - var_447_16) / var_447_17
				local var_447_19 = Vector3.New(0, 100, 0)

				var_447_15.localPosition = Vector3.Lerp(arg_444_1.var_.moveOldPos1084ui_story, var_447_19, var_447_18)

				local var_447_20 = manager.ui.mainCamera.transform.position - var_447_15.position

				var_447_15.forward = Vector3.New(var_447_20.x, var_447_20.y, var_447_20.z)

				local var_447_21 = var_447_15.localEulerAngles

				var_447_21.z = 0
				var_447_21.x = 0
				var_447_15.localEulerAngles = var_447_21
			end

			if arg_444_1.time_ >= var_447_16 + var_447_17 and arg_444_1.time_ < var_447_16 + var_447_17 + arg_447_0 then
				var_447_15.localPosition = Vector3.New(0, 100, 0)

				local var_447_22 = manager.ui.mainCamera.transform.position - var_447_15.position

				var_447_15.forward = Vector3.New(var_447_22.x, var_447_22.y, var_447_22.z)

				local var_447_23 = var_447_15.localEulerAngles

				var_447_23.z = 0
				var_447_23.x = 0
				var_447_15.localEulerAngles = var_447_23
			end

			local var_447_24 = arg_444_1.actors_["1084ui_story"]
			local var_447_25 = 0

			if var_447_25 < arg_444_1.time_ and arg_444_1.time_ <= var_447_25 + arg_447_0 and not isNil(var_447_24) and arg_444_1.var_.characterEffect1084ui_story == nil then
				arg_444_1.var_.characterEffect1084ui_story = var_447_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_447_26 = 0.200000002980232

			if var_447_25 <= arg_444_1.time_ and arg_444_1.time_ < var_447_25 + var_447_26 and not isNil(var_447_24) then
				local var_447_27 = (arg_444_1.time_ - var_447_25) / var_447_26

				if arg_444_1.var_.characterEffect1084ui_story and not isNil(var_447_24) then
					local var_447_28 = Mathf.Lerp(0, 0.5, var_447_27)

					arg_444_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_444_1.var_.characterEffect1084ui_story.fillRatio = var_447_28
				end
			end

			if arg_444_1.time_ >= var_447_25 + var_447_26 and arg_444_1.time_ < var_447_25 + var_447_26 + arg_447_0 and not isNil(var_447_24) and arg_444_1.var_.characterEffect1084ui_story then
				local var_447_29 = 0.5

				arg_444_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_444_1.var_.characterEffect1084ui_story.fillRatio = var_447_29
			end

			local var_447_30 = 0
			local var_447_31 = 0.725

			if var_447_30 < arg_444_1.time_ and arg_444_1.time_ <= var_447_30 + arg_447_0 then
				arg_444_1.talkMaxDuration = 0
				arg_444_1.dialogCg_.alpha = 1

				arg_444_1.dialog_:SetActive(true)
				SetActive(arg_444_1.leftNameGo_, false)

				arg_444_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_444_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_444_1:RecordName(arg_444_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_444_1.iconTrs_.gameObject, false)
				arg_444_1.callingController_:SetSelectedState("normal")

				local var_447_32 = arg_444_1:GetWordFromCfg(121421110)
				local var_447_33 = arg_444_1:FormatText(var_447_32.content)

				arg_444_1.text_.text = var_447_33

				LuaForUtil.ClearLinePrefixSymbol(arg_444_1.text_)

				local var_447_34 = 29
				local var_447_35 = utf8.len(var_447_33)
				local var_447_36 = var_447_34 <= 0 and var_447_31 or var_447_31 * (var_447_35 / var_447_34)

				if var_447_36 > 0 and var_447_31 < var_447_36 then
					arg_444_1.talkMaxDuration = var_447_36

					if var_447_36 + var_447_30 > arg_444_1.duration_ then
						arg_444_1.duration_ = var_447_36 + var_447_30
					end
				end

				arg_444_1.text_.text = var_447_33
				arg_444_1.typewritter.percent = 0

				arg_444_1.typewritter:SetDirty()
				arg_444_1:ShowNextGo(false)
				arg_444_1:RecordContent(arg_444_1.text_.text)
			end

			local var_447_37 = math.max(var_447_31, arg_444_1.talkMaxDuration)

			if var_447_30 <= arg_444_1.time_ and arg_444_1.time_ < var_447_30 + var_447_37 then
				arg_444_1.typewritter.percent = (arg_444_1.time_ - var_447_30) / var_447_37

				arg_444_1.typewritter:SetDirty()
			end

			if arg_444_1.time_ >= var_447_30 + var_447_37 and arg_444_1.time_ < var_447_30 + var_447_37 + arg_447_0 then
				arg_444_1.typewritter.percent = 1

				arg_444_1.typewritter:SetDirty()
				arg_444_1:ShowNextGo(true)
			end
		end

		arg_444_1.nodeConfigList_ = {
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
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_444_1:InitPlayNodeList()
	end,
	Play121421111 = function(arg_448_0, arg_448_1)
		arg_448_1.time_ = 0
		arg_448_1.frameCnt_ = 0
		arg_448_1.state_ = "playing"
		arg_448_1.curTalkId_ = 121421111
		arg_448_1.duration_ = 9.8

		local var_448_0 = {
			ja = 9.80000000298023,
			ko = 5.76600000298023,
			zh = 5.76600000298023
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
				arg_448_0:Play121421112(arg_448_1)
			end
		end

		function arg_448_1.onSingleLineUpdate_(arg_451_0)
			local var_451_0 = "ST12"

			if arg_448_1.bgs_[var_451_0] == nil then
				local var_451_1 = Object.Instantiate(arg_448_1.paintGo_)

				var_451_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_451_0)
				var_451_1.name = var_451_0
				var_451_1.transform.parent = arg_448_1.stage_.transform
				var_451_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_448_1.bgs_[var_451_0] = var_451_1
			end

			local var_451_2 = 1

			if var_451_2 < arg_448_1.time_ and arg_448_1.time_ <= var_451_2 + arg_451_0 then
				local var_451_3 = manager.ui.mainCamera.transform.localPosition
				local var_451_4 = Vector3.New(0, 0, 10) + Vector3.New(var_451_3.x, var_451_3.y, 0)
				local var_451_5 = arg_448_1.bgs_.ST12

				var_451_5.transform.localPosition = var_451_4
				var_451_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_451_6 = var_451_5:GetComponent("SpriteRenderer")

				if var_451_6 and var_451_6.sprite then
					local var_451_7 = (var_451_5.transform.localPosition - var_451_3).z
					local var_451_8 = manager.ui.mainCameraCom_
					local var_451_9 = 2 * var_451_7 * Mathf.Tan(var_451_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_451_10 = var_451_9 * var_451_8.aspect
					local var_451_11 = var_451_6.sprite.bounds.size.x
					local var_451_12 = var_451_6.sprite.bounds.size.y
					local var_451_13 = var_451_10 / var_451_11
					local var_451_14 = var_451_9 / var_451_12
					local var_451_15 = var_451_14 < var_451_13 and var_451_13 or var_451_14

					var_451_5.transform.localScale = Vector3.New(var_451_15, var_451_15, 0)
				end

				for iter_451_0, iter_451_1 in pairs(arg_448_1.bgs_) do
					if iter_451_0 ~= "ST12" then
						iter_451_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_451_16 = "1029ui_story"

			if arg_448_1.actors_[var_451_16] == nil then
				local var_451_17 = Asset.Load("Char/" .. "1029ui_story")

				if not isNil(var_451_17) then
					local var_451_18 = Object.Instantiate(Asset.Load("Char/" .. "1029ui_story"), arg_448_1.stage_.transform)

					var_451_18.name = var_451_16
					var_451_18.transform.localPosition = Vector3.New(0, 100, 0)
					arg_448_1.actors_[var_451_16] = var_451_18

					local var_451_19 = var_451_18:GetComponentInChildren(typeof(CharacterEffect))

					var_451_19.enabled = true

					local var_451_20 = GameObjectTools.GetOrAddComponent(var_451_18, typeof(DynamicBoneHelper))

					if var_451_20 then
						var_451_20:EnableDynamicBone(false)
					end

					arg_448_1:ShowWeapon(var_451_19.transform, false)

					arg_448_1.var_[var_451_16 .. "Animator"] = var_451_19.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_448_1.var_[var_451_16 .. "Animator"].applyRootMotion = true
					arg_448_1.var_[var_451_16 .. "LipSync"] = var_451_19.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_451_21 = arg_448_1.actors_["1029ui_story"].transform
			local var_451_22 = 1.8

			if var_451_22 < arg_448_1.time_ and arg_448_1.time_ <= var_451_22 + arg_451_0 then
				arg_448_1.var_.moveOldPos1029ui_story = var_451_21.localPosition
			end

			local var_451_23 = 0.001

			if var_451_22 <= arg_448_1.time_ and arg_448_1.time_ < var_451_22 + var_451_23 then
				local var_451_24 = (arg_448_1.time_ - var_451_22) / var_451_23
				local var_451_25 = Vector3.New(0, -1.09, -6.2)

				var_451_21.localPosition = Vector3.Lerp(arg_448_1.var_.moveOldPos1029ui_story, var_451_25, var_451_24)

				local var_451_26 = manager.ui.mainCamera.transform.position - var_451_21.position

				var_451_21.forward = Vector3.New(var_451_26.x, var_451_26.y, var_451_26.z)

				local var_451_27 = var_451_21.localEulerAngles

				var_451_27.z = 0
				var_451_27.x = 0
				var_451_21.localEulerAngles = var_451_27
			end

			if arg_448_1.time_ >= var_451_22 + var_451_23 and arg_448_1.time_ < var_451_22 + var_451_23 + arg_451_0 then
				var_451_21.localPosition = Vector3.New(0, -1.09, -6.2)

				local var_451_28 = manager.ui.mainCamera.transform.position - var_451_21.position

				var_451_21.forward = Vector3.New(var_451_28.x, var_451_28.y, var_451_28.z)

				local var_451_29 = var_451_21.localEulerAngles

				var_451_29.z = 0
				var_451_29.x = 0
				var_451_21.localEulerAngles = var_451_29
			end

			local var_451_30 = arg_448_1.actors_["1029ui_story"]
			local var_451_31 = 1.8

			if var_451_31 < arg_448_1.time_ and arg_448_1.time_ <= var_451_31 + arg_451_0 and not isNil(var_451_30) and arg_448_1.var_.characterEffect1029ui_story == nil then
				arg_448_1.var_.characterEffect1029ui_story = var_451_30:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_451_32 = 0.200000002980232

			if var_451_31 <= arg_448_1.time_ and arg_448_1.time_ < var_451_31 + var_451_32 and not isNil(var_451_30) then
				local var_451_33 = (arg_448_1.time_ - var_451_31) / var_451_32

				if arg_448_1.var_.characterEffect1029ui_story and not isNil(var_451_30) then
					arg_448_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_448_1.time_ >= var_451_31 + var_451_32 and arg_448_1.time_ < var_451_31 + var_451_32 + arg_451_0 and not isNil(var_451_30) and arg_448_1.var_.characterEffect1029ui_story then
				arg_448_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_451_34 = 1.8

			if var_451_34 < arg_448_1.time_ and arg_448_1.time_ <= var_451_34 + arg_451_0 then
				arg_448_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action4_1")
			end

			local var_451_35 = 1.8

			if var_451_35 < arg_448_1.time_ and arg_448_1.time_ <= var_451_35 + arg_451_0 then
				arg_448_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_451_36 = 0

			if var_451_36 < arg_448_1.time_ and arg_448_1.time_ <= var_451_36 + arg_451_0 then
				arg_448_1.mask_.enabled = true
				arg_448_1.mask_.raycastTarget = true

				arg_448_1:SetGaussion(false)
			end

			local var_451_37 = 1

			if var_451_36 <= arg_448_1.time_ and arg_448_1.time_ < var_451_36 + var_451_37 then
				local var_451_38 = (arg_448_1.time_ - var_451_36) / var_451_37
				local var_451_39 = Color.New(0, 0, 0)

				var_451_39.a = Mathf.Lerp(0, 1, var_451_38)
				arg_448_1.mask_.color = var_451_39
			end

			if arg_448_1.time_ >= var_451_36 + var_451_37 and arg_448_1.time_ < var_451_36 + var_451_37 + arg_451_0 then
				local var_451_40 = Color.New(0, 0, 0)

				var_451_40.a = 1
				arg_448_1.mask_.color = var_451_40
			end

			local var_451_41 = 1

			if var_451_41 < arg_448_1.time_ and arg_448_1.time_ <= var_451_41 + arg_451_0 then
				arg_448_1.mask_.enabled = true
				arg_448_1.mask_.raycastTarget = true

				arg_448_1:SetGaussion(false)
			end

			local var_451_42 = 1

			if var_451_41 <= arg_448_1.time_ and arg_448_1.time_ < var_451_41 + var_451_42 then
				local var_451_43 = (arg_448_1.time_ - var_451_41) / var_451_42
				local var_451_44 = Color.New(0, 0, 0)

				var_451_44.a = Mathf.Lerp(1, 0, var_451_43)
				arg_448_1.mask_.color = var_451_44
			end

			if arg_448_1.time_ >= var_451_41 + var_451_42 and arg_448_1.time_ < var_451_41 + var_451_42 + arg_451_0 then
				local var_451_45 = Color.New(0, 0, 0)
				local var_451_46 = 0

				arg_448_1.mask_.enabled = false
				var_451_45.a = var_451_46
				arg_448_1.mask_.color = var_451_45
			end

			local var_451_47 = 1

			arg_448_1.isInRecall_ = false

			if var_451_47 < arg_448_1.time_ and arg_448_1.time_ <= var_451_47 + arg_451_0 then
				arg_448_1.screenFilterGo_:SetActive(true)

				arg_448_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile")

				for iter_451_2, iter_451_3 in pairs(arg_448_1.actors_) do
					local var_451_48 = iter_451_3:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_451_4, iter_451_5 in ipairs(var_451_48) do
						if iter_451_5.color.r > 0.51 then
							iter_451_5.color = Color.New(1, 1, 1)
						else
							iter_451_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_451_49 = 0.1

			if var_451_47 <= arg_448_1.time_ and arg_448_1.time_ < var_451_47 + var_451_49 then
				local var_451_50 = (arg_448_1.time_ - var_451_47) / var_451_49

				arg_448_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, var_451_50)
			end

			if arg_448_1.time_ >= var_451_47 + var_451_49 and arg_448_1.time_ < var_451_47 + var_451_49 + arg_451_0 then
				arg_448_1.screenFilterEffect_.weight = 1
			end

			local var_451_51 = arg_448_1.actors_["1029ui_story"]
			local var_451_52 = 1.8

			if var_451_52 < arg_448_1.time_ and arg_448_1.time_ <= var_451_52 + arg_451_0 then
				if arg_448_1.var_.characterEffect1029ui_story == nil then
					arg_448_1.var_.characterEffect1029ui_story = var_451_51:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_451_53 = arg_448_1.var_.characterEffect1029ui_story

				var_451_53.imageEffect:turnOff()

				var_451_53.interferenceEffect.enabled = true
				var_451_53.interferenceEffect.noise = 0.001
				var_451_53.interferenceEffect.simTimeScale = 1
				var_451_53.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			local var_451_54 = arg_448_1.actors_["1029ui_story"]
			local var_451_55 = 1.8
			local var_451_56 = 0.1

			if var_451_55 < arg_448_1.time_ and arg_448_1.time_ <= var_451_55 + arg_451_0 then
				if arg_448_1.var_.characterEffect1029ui_story == nil then
					arg_448_1.var_.characterEffect1029ui_story = var_451_54:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_448_1.var_.characterEffect1029ui_story.imageEffect:turnOn(false)
			end

			if arg_448_1.frameCnt_ <= 1 then
				arg_448_1.dialog_:SetActive(false)
			end

			local var_451_57 = 2.00000000298023
			local var_451_58 = 0.5

			if var_451_57 < arg_448_1.time_ and arg_448_1.time_ <= var_451_57 + arg_451_0 then
				arg_448_1.talkMaxDuration = 0

				arg_448_1.dialog_:SetActive(true)

				arg_448_1.dialogCg_.alpha = 0

				local var_451_59 = LeanTween.value(arg_448_1.dialog_, 0, 1, 0.3)

				var_451_59:setOnUpdate(LuaHelper.FloatAction(function(arg_452_0)
					arg_448_1.dialogCg_.alpha = arg_452_0
				end))
				var_451_59:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_448_1.dialog_)
					var_451_59:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_448_1.duration_ = arg_448_1.duration_ + 0.3

				SetActive(arg_448_1.leftNameGo_, true)

				local var_451_60 = arg_448_1:FormatText(StoryNameCfg[319].name)

				arg_448_1.leftNameTxt_.text = var_451_60

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_448_1.leftNameTxt_.transform)

				arg_448_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_448_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_448_1:RecordName(arg_448_1.leftNameTxt_.text)
				SetActive(arg_448_1.iconTrs_.gameObject, false)
				arg_448_1.callingController_:SetSelectedState("normal")

				local var_451_61 = arg_448_1:GetWordFromCfg(121421111)
				local var_451_62 = arg_448_1:FormatText(var_451_61.content)

				arg_448_1.text_.text = var_451_62

				LuaForUtil.ClearLinePrefixSymbol(arg_448_1.text_)

				local var_451_63 = 20
				local var_451_64 = utf8.len(var_451_62)
				local var_451_65 = var_451_63 <= 0 and var_451_58 or var_451_58 * (var_451_64 / var_451_63)

				if var_451_65 > 0 and var_451_58 < var_451_65 then
					arg_448_1.talkMaxDuration = var_451_65
					var_451_57 = var_451_57 + 0.3

					if var_451_65 + var_451_57 > arg_448_1.duration_ then
						arg_448_1.duration_ = var_451_65 + var_451_57
					end
				end

				arg_448_1.text_.text = var_451_62
				arg_448_1.typewritter.percent = 0

				arg_448_1.typewritter:SetDirty()
				arg_448_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121421", "121421111", "story_v_out_121421.awb") ~= 0 then
					local var_451_66 = manager.audio:GetVoiceLength("story_v_out_121421", "121421111", "story_v_out_121421.awb") / 1000

					if var_451_66 + var_451_57 > arg_448_1.duration_ then
						arg_448_1.duration_ = var_451_66 + var_451_57
					end

					if var_451_61.prefab_name ~= "" and arg_448_1.actors_[var_451_61.prefab_name] ~= nil then
						local var_451_67 = LuaForUtil.PlayVoiceWithCriLipsync(arg_448_1.actors_[var_451_61.prefab_name].transform, "story_v_out_121421", "121421111", "story_v_out_121421.awb")

						arg_448_1:RecordAudio("121421111", var_451_67)
						arg_448_1:RecordAudio("121421111", var_451_67)
					else
						arg_448_1:AudioAction("play", "voice", "story_v_out_121421", "121421111", "story_v_out_121421.awb")
					end

					arg_448_1:RecordHistoryTalkVoice("story_v_out_121421", "121421111", "story_v_out_121421.awb")
				end

				arg_448_1:RecordContent(arg_448_1.text_.text)
			end

			local var_451_68 = var_451_57 + 0.3
			local var_451_69 = math.max(var_451_58, arg_448_1.talkMaxDuration)

			if var_451_68 <= arg_448_1.time_ and arg_448_1.time_ < var_451_68 + var_451_69 then
				arg_448_1.typewritter.percent = (arg_448_1.time_ - var_451_68) / var_451_69

				arg_448_1.typewritter:SetDirty()
			end

			if arg_448_1.time_ >= var_451_68 + var_451_69 and arg_448_1.time_ < var_451_68 + var_451_69 + arg_451_0 then
				arg_448_1.typewritter.percent = 1

				arg_448_1.typewritter:SetDirty()
				arg_448_1:ShowNextGo(true)
			end
		end

		arg_448_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1029ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_448_1:InitPlayNodeList()
	end,
	Play121421112 = function(arg_454_0, arg_454_1)
		arg_454_1.time_ = 0
		arg_454_1.frameCnt_ = 0
		arg_454_1.state_ = "playing"
		arg_454_1.curTalkId_ = 121421112
		arg_454_1.duration_ = 3.9

		local var_454_0 = {
			ja = 3.9,
			ko = 2.666,
			zh = 2.666
		}
		local var_454_1 = manager.audio:GetLocalizationFlag()

		if var_454_0[var_454_1] ~= nil then
			arg_454_1.duration_ = var_454_0[var_454_1]
		end

		SetActive(arg_454_1.tipsGo_, false)

		function arg_454_1.onSingleLineFinish_()
			arg_454_1.onSingleLineUpdate_ = nil
			arg_454_1.onSingleLineFinish_ = nil
			arg_454_1.state_ = "waiting"
		end

		function arg_454_1.playNext_(arg_456_0)
			if arg_456_0 == 1 then
				arg_454_0:Play121421113(arg_454_1)
			end
		end

		function arg_454_1.onSingleLineUpdate_(arg_457_0)
			local var_457_0 = 0
			local var_457_1 = 0.325

			if var_457_0 < arg_454_1.time_ and arg_454_1.time_ <= var_457_0 + arg_457_0 then
				arg_454_1.talkMaxDuration = 0
				arg_454_1.dialogCg_.alpha = 1

				arg_454_1.dialog_:SetActive(true)
				SetActive(arg_454_1.leftNameGo_, true)

				local var_457_2 = arg_454_1:FormatText(StoryNameCfg[319].name)

				arg_454_1.leftNameTxt_.text = var_457_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_454_1.leftNameTxt_.transform)

				arg_454_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_454_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_454_1:RecordName(arg_454_1.leftNameTxt_.text)
				SetActive(arg_454_1.iconTrs_.gameObject, false)
				arg_454_1.callingController_:SetSelectedState("normal")

				local var_457_3 = arg_454_1:GetWordFromCfg(121421112)
				local var_457_4 = arg_454_1:FormatText(var_457_3.content)

				arg_454_1.text_.text = var_457_4

				LuaForUtil.ClearLinePrefixSymbol(arg_454_1.text_)

				local var_457_5 = 13
				local var_457_6 = utf8.len(var_457_4)
				local var_457_7 = var_457_5 <= 0 and var_457_1 or var_457_1 * (var_457_6 / var_457_5)

				if var_457_7 > 0 and var_457_1 < var_457_7 then
					arg_454_1.talkMaxDuration = var_457_7

					if var_457_7 + var_457_0 > arg_454_1.duration_ then
						arg_454_1.duration_ = var_457_7 + var_457_0
					end
				end

				arg_454_1.text_.text = var_457_4
				arg_454_1.typewritter.percent = 0

				arg_454_1.typewritter:SetDirty()
				arg_454_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121421", "121421112", "story_v_out_121421.awb") ~= 0 then
					local var_457_8 = manager.audio:GetVoiceLength("story_v_out_121421", "121421112", "story_v_out_121421.awb") / 1000

					if var_457_8 + var_457_0 > arg_454_1.duration_ then
						arg_454_1.duration_ = var_457_8 + var_457_0
					end

					if var_457_3.prefab_name ~= "" and arg_454_1.actors_[var_457_3.prefab_name] ~= nil then
						local var_457_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_454_1.actors_[var_457_3.prefab_name].transform, "story_v_out_121421", "121421112", "story_v_out_121421.awb")

						arg_454_1:RecordAudio("121421112", var_457_9)
						arg_454_1:RecordAudio("121421112", var_457_9)
					else
						arg_454_1:AudioAction("play", "voice", "story_v_out_121421", "121421112", "story_v_out_121421.awb")
					end

					arg_454_1:RecordHistoryTalkVoice("story_v_out_121421", "121421112", "story_v_out_121421.awb")
				end

				arg_454_1:RecordContent(arg_454_1.text_.text)
			end

			local var_457_10 = math.max(var_457_1, arg_454_1.talkMaxDuration)

			if var_457_0 <= arg_454_1.time_ and arg_454_1.time_ < var_457_0 + var_457_10 then
				arg_454_1.typewritter.percent = (arg_454_1.time_ - var_457_0) / var_457_10

				arg_454_1.typewritter:SetDirty()
			end

			if arg_454_1.time_ >= var_457_0 + var_457_10 and arg_454_1.time_ < var_457_0 + var_457_10 + arg_457_0 then
				arg_454_1.typewritter.percent = 1

				arg_454_1.typewritter:SetDirty()
				arg_454_1:ShowNextGo(true)
			end
		end

		arg_454_1.nodeConfigList_ = {}

		arg_454_1:InitPlayNodeList()
	end,
	Play121421113 = function(arg_458_0, arg_458_1)
		arg_458_1.time_ = 0
		arg_458_1.frameCnt_ = 0
		arg_458_1.state_ = "playing"
		arg_458_1.curTalkId_ = 121421113
		arg_458_1.duration_ = 7

		SetActive(arg_458_1.tipsGo_, false)

		function arg_458_1.onSingleLineFinish_()
			arg_458_1.onSingleLineUpdate_ = nil
			arg_458_1.onSingleLineFinish_ = nil
			arg_458_1.state_ = "waiting"
		end

		function arg_458_1.playNext_(arg_460_0)
			if arg_460_0 == 1 then
				arg_458_0:Play121421114(arg_458_1)
			end
		end

		function arg_458_1.onSingleLineUpdate_(arg_461_0)
			local var_461_0 = arg_458_1.actors_["1029ui_story"].transform
			local var_461_1 = 0.965999998152256

			if var_461_1 < arg_458_1.time_ and arg_458_1.time_ <= var_461_1 + arg_461_0 then
				arg_458_1.var_.moveOldPos1029ui_story = var_461_0.localPosition
			end

			local var_461_2 = 0.001

			if var_461_1 <= arg_458_1.time_ and arg_458_1.time_ < var_461_1 + var_461_2 then
				local var_461_3 = (arg_458_1.time_ - var_461_1) / var_461_2
				local var_461_4 = Vector3.New(0, 100, 0)

				var_461_0.localPosition = Vector3.Lerp(arg_458_1.var_.moveOldPos1029ui_story, var_461_4, var_461_3)

				local var_461_5 = manager.ui.mainCamera.transform.position - var_461_0.position

				var_461_0.forward = Vector3.New(var_461_5.x, var_461_5.y, var_461_5.z)

				local var_461_6 = var_461_0.localEulerAngles

				var_461_6.z = 0
				var_461_6.x = 0
				var_461_0.localEulerAngles = var_461_6
			end

			if arg_458_1.time_ >= var_461_1 + var_461_2 and arg_458_1.time_ < var_461_1 + var_461_2 + arg_461_0 then
				var_461_0.localPosition = Vector3.New(0, 100, 0)

				local var_461_7 = manager.ui.mainCamera.transform.position - var_461_0.position

				var_461_0.forward = Vector3.New(var_461_7.x, var_461_7.y, var_461_7.z)

				local var_461_8 = var_461_0.localEulerAngles

				var_461_8.z = 0
				var_461_8.x = 0
				var_461_0.localEulerAngles = var_461_8
			end

			local var_461_9 = arg_458_1.actors_["1029ui_story"]
			local var_461_10 = 0.965999998152256

			if var_461_10 < arg_458_1.time_ and arg_458_1.time_ <= var_461_10 + arg_461_0 and not isNil(var_461_9) and arg_458_1.var_.characterEffect1029ui_story == nil then
				arg_458_1.var_.characterEffect1029ui_story = var_461_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_461_11 = 0.034000001847744

			if var_461_10 <= arg_458_1.time_ and arg_458_1.time_ < var_461_10 + var_461_11 and not isNil(var_461_9) then
				local var_461_12 = (arg_458_1.time_ - var_461_10) / var_461_11

				if arg_458_1.var_.characterEffect1029ui_story and not isNil(var_461_9) then
					local var_461_13 = Mathf.Lerp(0, 0.5, var_461_12)

					arg_458_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_458_1.var_.characterEffect1029ui_story.fillRatio = var_461_13
				end
			end

			if arg_458_1.time_ >= var_461_10 + var_461_11 and arg_458_1.time_ < var_461_10 + var_461_11 + arg_461_0 and not isNil(var_461_9) and arg_458_1.var_.characterEffect1029ui_story then
				local var_461_14 = 0.5

				arg_458_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_458_1.var_.characterEffect1029ui_story.fillRatio = var_461_14
			end

			local var_461_15 = 0

			if var_461_15 < arg_458_1.time_ and arg_458_1.time_ <= var_461_15 + arg_461_0 then
				arg_458_1.mask_.enabled = true
				arg_458_1.mask_.raycastTarget = true

				arg_458_1:SetGaussion(false)
			end

			local var_461_16 = 1

			if var_461_15 <= arg_458_1.time_ and arg_458_1.time_ < var_461_15 + var_461_16 then
				local var_461_17 = (arg_458_1.time_ - var_461_15) / var_461_16
				local var_461_18 = Color.New(0, 0, 0)

				var_461_18.a = Mathf.Lerp(0, 1, var_461_17)
				arg_458_1.mask_.color = var_461_18
			end

			if arg_458_1.time_ >= var_461_15 + var_461_16 and arg_458_1.time_ < var_461_15 + var_461_16 + arg_461_0 then
				local var_461_19 = Color.New(0, 0, 0)

				var_461_19.a = 1
				arg_458_1.mask_.color = var_461_19
			end

			local var_461_20 = 1

			if var_461_20 < arg_458_1.time_ and arg_458_1.time_ <= var_461_20 + arg_461_0 then
				arg_458_1.mask_.enabled = true
				arg_458_1.mask_.raycastTarget = true

				arg_458_1:SetGaussion(false)
			end

			local var_461_21 = 1

			if var_461_20 <= arg_458_1.time_ and arg_458_1.time_ < var_461_20 + var_461_21 then
				local var_461_22 = (arg_458_1.time_ - var_461_20) / var_461_21
				local var_461_23 = Color.New(0, 0, 0)

				var_461_23.a = Mathf.Lerp(1, 0, var_461_22)
				arg_458_1.mask_.color = var_461_23
			end

			if arg_458_1.time_ >= var_461_20 + var_461_21 and arg_458_1.time_ < var_461_20 + var_461_21 + arg_461_0 then
				local var_461_24 = Color.New(0, 0, 0)
				local var_461_25 = 0

				arg_458_1.mask_.enabled = false
				var_461_24.a = var_461_25
				arg_458_1.mask_.color = var_461_24
			end

			local var_461_26 = 0.983333333333333

			arg_458_1.isInRecall_ = false

			if var_461_26 < arg_458_1.time_ and arg_458_1.time_ <= var_461_26 + arg_461_0 then
				arg_458_1.screenFilterGo_:SetActive(false)

				for iter_461_0, iter_461_1 in pairs(arg_458_1.actors_) do
					local var_461_27 = iter_461_1:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_461_2, iter_461_3 in ipairs(var_461_27) do
						if iter_461_3.color.r > 0.51 then
							iter_461_3.color = Color.New(1, 1, 1)
						else
							iter_461_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_461_28 = 0.0166666666666667

			if var_461_26 <= arg_458_1.time_ and arg_458_1.time_ < var_461_26 + var_461_28 then
				local var_461_29 = (arg_458_1.time_ - var_461_26) / var_461_28

				arg_458_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, var_461_29)
			end

			if arg_458_1.time_ >= var_461_26 + var_461_28 and arg_458_1.time_ < var_461_26 + var_461_28 + arg_461_0 then
				arg_458_1.screenFilterEffect_.weight = 0
			end

			local var_461_30 = arg_458_1.actors_["1072ui_story"].transform
			local var_461_31 = 1

			if var_461_31 < arg_458_1.time_ and arg_458_1.time_ <= var_461_31 + arg_461_0 then
				arg_458_1.var_.moveOldPos1072ui_story = var_461_30.localPosition
			end

			local var_461_32 = 0.001

			if var_461_31 <= arg_458_1.time_ and arg_458_1.time_ < var_461_31 + var_461_32 then
				local var_461_33 = (arg_458_1.time_ - var_461_31) / var_461_32
				local var_461_34 = Vector3.New(0, -0.71, -6)

				var_461_30.localPosition = Vector3.Lerp(arg_458_1.var_.moveOldPos1072ui_story, var_461_34, var_461_33)

				local var_461_35 = manager.ui.mainCamera.transform.position - var_461_30.position

				var_461_30.forward = Vector3.New(var_461_35.x, var_461_35.y, var_461_35.z)

				local var_461_36 = var_461_30.localEulerAngles

				var_461_36.z = 0
				var_461_36.x = 0
				var_461_30.localEulerAngles = var_461_36
			end

			if arg_458_1.time_ >= var_461_31 + var_461_32 and arg_458_1.time_ < var_461_31 + var_461_32 + arg_461_0 then
				var_461_30.localPosition = Vector3.New(0, -0.71, -6)

				local var_461_37 = manager.ui.mainCamera.transform.position - var_461_30.position

				var_461_30.forward = Vector3.New(var_461_37.x, var_461_37.y, var_461_37.z)

				local var_461_38 = var_461_30.localEulerAngles

				var_461_38.z = 0
				var_461_38.x = 0
				var_461_30.localEulerAngles = var_461_38
			end

			local var_461_39 = arg_458_1.actors_["1072ui_story"]
			local var_461_40 = 1

			if var_461_40 < arg_458_1.time_ and arg_458_1.time_ <= var_461_40 + arg_461_0 and not isNil(var_461_39) and arg_458_1.var_.characterEffect1072ui_story == nil then
				arg_458_1.var_.characterEffect1072ui_story = var_461_39:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_461_41 = 0.034000001847744

			if var_461_40 <= arg_458_1.time_ and arg_458_1.time_ < var_461_40 + var_461_41 and not isNil(var_461_39) then
				local var_461_42 = (arg_458_1.time_ - var_461_40) / var_461_41

				if arg_458_1.var_.characterEffect1072ui_story and not isNil(var_461_39) then
					local var_461_43 = Mathf.Lerp(0, 0.5, var_461_42)

					arg_458_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_458_1.var_.characterEffect1072ui_story.fillRatio = var_461_43
				end
			end

			if arg_458_1.time_ >= var_461_40 + var_461_41 and arg_458_1.time_ < var_461_40 + var_461_41 + arg_461_0 and not isNil(var_461_39) and arg_458_1.var_.characterEffect1072ui_story then
				local var_461_44 = 0.5

				arg_458_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_458_1.var_.characterEffect1072ui_story.fillRatio = var_461_44
			end

			local var_461_45 = 1

			if var_461_45 < arg_458_1.time_ and arg_458_1.time_ <= var_461_45 + arg_461_0 then
				local var_461_46 = manager.ui.mainCamera.transform.localPosition
				local var_461_47 = Vector3.New(0, 0, 10) + Vector3.New(var_461_46.x, var_461_46.y, 0)
				local var_461_48 = arg_458_1.bgs_.ST29

				var_461_48.transform.localPosition = var_461_47
				var_461_48.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_461_49 = var_461_48:GetComponent("SpriteRenderer")

				if var_461_49 and var_461_49.sprite then
					local var_461_50 = (var_461_48.transform.localPosition - var_461_46).z
					local var_461_51 = manager.ui.mainCameraCom_
					local var_461_52 = 2 * var_461_50 * Mathf.Tan(var_461_51.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_461_53 = var_461_52 * var_461_51.aspect
					local var_461_54 = var_461_49.sprite.bounds.size.x
					local var_461_55 = var_461_49.sprite.bounds.size.y
					local var_461_56 = var_461_53 / var_461_54
					local var_461_57 = var_461_52 / var_461_55
					local var_461_58 = var_461_57 < var_461_56 and var_461_56 or var_461_57

					var_461_48.transform.localScale = Vector3.New(var_461_58, var_461_58, 0)
				end

				for iter_461_4, iter_461_5 in pairs(arg_458_1.bgs_) do
					if iter_461_4 ~= "ST29" then
						iter_461_5.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if arg_458_1.frameCnt_ <= 1 then
				arg_458_1.dialog_:SetActive(false)
			end

			local var_461_59 = 1.999999999999
			local var_461_60 = 0.525

			if var_461_59 < arg_458_1.time_ and arg_458_1.time_ <= var_461_59 + arg_461_0 then
				arg_458_1.talkMaxDuration = 0

				arg_458_1.dialog_:SetActive(true)

				arg_458_1.dialogCg_.alpha = 0

				local var_461_61 = LeanTween.value(arg_458_1.dialog_, 0, 1, 0.3)

				var_461_61:setOnUpdate(LuaHelper.FloatAction(function(arg_462_0)
					arg_458_1.dialogCg_.alpha = arg_462_0
				end))
				var_461_61:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_458_1.dialog_)
					var_461_61:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_458_1.duration_ = arg_458_1.duration_ + 0.3

				SetActive(arg_458_1.leftNameGo_, true)

				local var_461_62 = arg_458_1:FormatText(StoryNameCfg[7].name)

				arg_458_1.leftNameTxt_.text = var_461_62

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_458_1.leftNameTxt_.transform)

				arg_458_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_458_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_458_1:RecordName(arg_458_1.leftNameTxt_.text)
				SetActive(arg_458_1.iconTrs_.gameObject, true)
				arg_458_1.iconController_:SetSelectedState("hero")

				arg_458_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_458_1.callingController_:SetSelectedState("normal")

				arg_458_1.keyicon_.color = Color.New(1, 1, 1)
				arg_458_1.icon_.color = Color.New(1, 1, 1)

				local var_461_63 = arg_458_1:GetWordFromCfg(121421113)
				local var_461_64 = arg_458_1:FormatText(var_461_63.content)

				arg_458_1.text_.text = var_461_64

				LuaForUtil.ClearLinePrefixSymbol(arg_458_1.text_)

				local var_461_65 = 21
				local var_461_66 = utf8.len(var_461_64)
				local var_461_67 = var_461_65 <= 0 and var_461_60 or var_461_60 * (var_461_66 / var_461_65)

				if var_461_67 > 0 and var_461_60 < var_461_67 then
					arg_458_1.talkMaxDuration = var_461_67
					var_461_59 = var_461_59 + 0.3

					if var_461_67 + var_461_59 > arg_458_1.duration_ then
						arg_458_1.duration_ = var_461_67 + var_461_59
					end
				end

				arg_458_1.text_.text = var_461_64
				arg_458_1.typewritter.percent = 0

				arg_458_1.typewritter:SetDirty()
				arg_458_1:ShowNextGo(false)
				arg_458_1:RecordContent(arg_458_1.text_.text)
			end

			local var_461_68 = var_461_59 + 0.3
			local var_461_69 = math.max(var_461_60, arg_458_1.talkMaxDuration)

			if var_461_68 <= arg_458_1.time_ and arg_458_1.time_ < var_461_68 + var_461_69 then
				arg_458_1.typewritter.percent = (arg_458_1.time_ - var_461_68) / var_461_69

				arg_458_1.typewritter:SetDirty()
			end

			if arg_458_1.time_ >= var_461_68 + var_461_69 and arg_458_1.time_ < var_461_68 + var_461_69 + arg_461_0 then
				arg_458_1.typewritter.percent = 1

				arg_458_1.typewritter:SetDirty()
				arg_458_1:ShowNextGo(true)
			end
		end

		arg_458_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1029ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0.965999998152256,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_458_1:InitPlayNodeList()
	end,
	Play121421114 = function(arg_464_0, arg_464_1)
		arg_464_1.time_ = 0
		arg_464_1.frameCnt_ = 0
		arg_464_1.state_ = "playing"
		arg_464_1.curTalkId_ = 121421114
		arg_464_1.duration_ = 5.1

		local var_464_0 = {
			ja = 5.1,
			ko = 4.233,
			zh = 4.233
		}
		local var_464_1 = manager.audio:GetLocalizationFlag()

		if var_464_0[var_464_1] ~= nil then
			arg_464_1.duration_ = var_464_0[var_464_1]
		end

		SetActive(arg_464_1.tipsGo_, false)

		function arg_464_1.onSingleLineFinish_()
			arg_464_1.onSingleLineUpdate_ = nil
			arg_464_1.onSingleLineFinish_ = nil
			arg_464_1.state_ = "waiting"
		end

		function arg_464_1.playNext_(arg_466_0)
			if arg_466_0 == 1 then
				arg_464_0:Play121421115(arg_464_1)
			end
		end

		function arg_464_1.onSingleLineUpdate_(arg_467_0)
			local var_467_0 = arg_464_1.actors_["1072ui_story"].transform
			local var_467_1 = 0

			if var_467_1 < arg_464_1.time_ and arg_464_1.time_ <= var_467_1 + arg_467_0 then
				arg_464_1.var_.moveOldPos1072ui_story = var_467_0.localPosition
			end

			local var_467_2 = 0.001

			if var_467_1 <= arg_464_1.time_ and arg_464_1.time_ < var_467_1 + var_467_2 then
				local var_467_3 = (arg_464_1.time_ - var_467_1) / var_467_2
				local var_467_4 = Vector3.New(0, -0.71, -6)

				var_467_0.localPosition = Vector3.Lerp(arg_464_1.var_.moveOldPos1072ui_story, var_467_4, var_467_3)

				local var_467_5 = manager.ui.mainCamera.transform.position - var_467_0.position

				var_467_0.forward = Vector3.New(var_467_5.x, var_467_5.y, var_467_5.z)

				local var_467_6 = var_467_0.localEulerAngles

				var_467_6.z = 0
				var_467_6.x = 0
				var_467_0.localEulerAngles = var_467_6
			end

			if arg_464_1.time_ >= var_467_1 + var_467_2 and arg_464_1.time_ < var_467_1 + var_467_2 + arg_467_0 then
				var_467_0.localPosition = Vector3.New(0, -0.71, -6)

				local var_467_7 = manager.ui.mainCamera.transform.position - var_467_0.position

				var_467_0.forward = Vector3.New(var_467_7.x, var_467_7.y, var_467_7.z)

				local var_467_8 = var_467_0.localEulerAngles

				var_467_8.z = 0
				var_467_8.x = 0
				var_467_0.localEulerAngles = var_467_8
			end

			local var_467_9 = arg_464_1.actors_["1072ui_story"]
			local var_467_10 = 0

			if var_467_10 < arg_464_1.time_ and arg_464_1.time_ <= var_467_10 + arg_467_0 and not isNil(var_467_9) and arg_464_1.var_.characterEffect1072ui_story == nil then
				arg_464_1.var_.characterEffect1072ui_story = var_467_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_467_11 = 0.200000002980232

			if var_467_10 <= arg_464_1.time_ and arg_464_1.time_ < var_467_10 + var_467_11 and not isNil(var_467_9) then
				local var_467_12 = (arg_464_1.time_ - var_467_10) / var_467_11

				if arg_464_1.var_.characterEffect1072ui_story and not isNil(var_467_9) then
					arg_464_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_464_1.time_ >= var_467_10 + var_467_11 and arg_464_1.time_ < var_467_10 + var_467_11 + arg_467_0 and not isNil(var_467_9) and arg_464_1.var_.characterEffect1072ui_story then
				arg_464_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_467_13 = 0

			if var_467_13 < arg_464_1.time_ and arg_464_1.time_ <= var_467_13 + arg_467_0 then
				arg_464_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072actionlink/1072action467")
			end

			local var_467_14 = 0

			if var_467_14 < arg_464_1.time_ and arg_464_1.time_ <= var_467_14 + arg_467_0 then
				arg_464_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_467_15 = 0
			local var_467_16 = 0.3

			if var_467_15 < arg_464_1.time_ and arg_464_1.time_ <= var_467_15 + arg_467_0 then
				arg_464_1.talkMaxDuration = 0
				arg_464_1.dialogCg_.alpha = 1

				arg_464_1.dialog_:SetActive(true)
				SetActive(arg_464_1.leftNameGo_, true)

				local var_467_17 = arg_464_1:FormatText(StoryNameCfg[379].name)

				arg_464_1.leftNameTxt_.text = var_467_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_464_1.leftNameTxt_.transform)

				arg_464_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_464_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_464_1:RecordName(arg_464_1.leftNameTxt_.text)
				SetActive(arg_464_1.iconTrs_.gameObject, false)
				arg_464_1.callingController_:SetSelectedState("normal")

				local var_467_18 = arg_464_1:GetWordFromCfg(121421114)
				local var_467_19 = arg_464_1:FormatText(var_467_18.content)

				arg_464_1.text_.text = var_467_19

				LuaForUtil.ClearLinePrefixSymbol(arg_464_1.text_)

				local var_467_20 = 12
				local var_467_21 = utf8.len(var_467_19)
				local var_467_22 = var_467_20 <= 0 and var_467_16 or var_467_16 * (var_467_21 / var_467_20)

				if var_467_22 > 0 and var_467_16 < var_467_22 then
					arg_464_1.talkMaxDuration = var_467_22

					if var_467_22 + var_467_15 > arg_464_1.duration_ then
						arg_464_1.duration_ = var_467_22 + var_467_15
					end
				end

				arg_464_1.text_.text = var_467_19
				arg_464_1.typewritter.percent = 0

				arg_464_1.typewritter:SetDirty()
				arg_464_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121421", "121421114", "story_v_out_121421.awb") ~= 0 then
					local var_467_23 = manager.audio:GetVoiceLength("story_v_out_121421", "121421114", "story_v_out_121421.awb") / 1000

					if var_467_23 + var_467_15 > arg_464_1.duration_ then
						arg_464_1.duration_ = var_467_23 + var_467_15
					end

					if var_467_18.prefab_name ~= "" and arg_464_1.actors_[var_467_18.prefab_name] ~= nil then
						local var_467_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_464_1.actors_[var_467_18.prefab_name].transform, "story_v_out_121421", "121421114", "story_v_out_121421.awb")

						arg_464_1:RecordAudio("121421114", var_467_24)
						arg_464_1:RecordAudio("121421114", var_467_24)
					else
						arg_464_1:AudioAction("play", "voice", "story_v_out_121421", "121421114", "story_v_out_121421.awb")
					end

					arg_464_1:RecordHistoryTalkVoice("story_v_out_121421", "121421114", "story_v_out_121421.awb")
				end

				arg_464_1:RecordContent(arg_464_1.text_.text)
			end

			local var_467_25 = math.max(var_467_16, arg_464_1.talkMaxDuration)

			if var_467_15 <= arg_464_1.time_ and arg_464_1.time_ < var_467_15 + var_467_25 then
				arg_464_1.typewritter.percent = (arg_464_1.time_ - var_467_15) / var_467_25

				arg_464_1.typewritter:SetDirty()
			end

			if arg_464_1.time_ >= var_467_15 + var_467_25 and arg_464_1.time_ < var_467_15 + var_467_25 + arg_467_0 then
				arg_464_1.typewritter.percent = 1

				arg_464_1.typewritter:SetDirty()
				arg_464_1:ShowNextGo(true)
			end
		end

		arg_464_1.nodeConfigList_ = {
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

		arg_464_1:InitPlayNodeList()
	end,
	Play121421115 = function(arg_468_0, arg_468_1)
		arg_468_1.time_ = 0
		arg_468_1.frameCnt_ = 0
		arg_468_1.state_ = "playing"
		arg_468_1.curTalkId_ = 121421115
		arg_468_1.duration_ = 5

		SetActive(arg_468_1.tipsGo_, false)

		function arg_468_1.onSingleLineFinish_()
			arg_468_1.onSingleLineUpdate_ = nil
			arg_468_1.onSingleLineFinish_ = nil
			arg_468_1.state_ = "waiting"
		end

		function arg_468_1.playNext_(arg_470_0)
			if arg_470_0 == 1 then
				arg_468_0:Play121421116(arg_468_1)
			end
		end

		function arg_468_1.onSingleLineUpdate_(arg_471_0)
			local var_471_0 = arg_468_1.actors_["1072ui_story"]
			local var_471_1 = 0

			if var_471_1 < arg_468_1.time_ and arg_468_1.time_ <= var_471_1 + arg_471_0 and not isNil(var_471_0) and arg_468_1.var_.characterEffect1072ui_story == nil then
				arg_468_1.var_.characterEffect1072ui_story = var_471_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_471_2 = 0.200000002980232

			if var_471_1 <= arg_468_1.time_ and arg_468_1.time_ < var_471_1 + var_471_2 and not isNil(var_471_0) then
				local var_471_3 = (arg_468_1.time_ - var_471_1) / var_471_2

				if arg_468_1.var_.characterEffect1072ui_story and not isNil(var_471_0) then
					local var_471_4 = Mathf.Lerp(0, 0.5, var_471_3)

					arg_468_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_468_1.var_.characterEffect1072ui_story.fillRatio = var_471_4
				end
			end

			if arg_468_1.time_ >= var_471_1 + var_471_2 and arg_468_1.time_ < var_471_1 + var_471_2 + arg_471_0 and not isNil(var_471_0) and arg_468_1.var_.characterEffect1072ui_story then
				local var_471_5 = 0.5

				arg_468_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_468_1.var_.characterEffect1072ui_story.fillRatio = var_471_5
			end

			local var_471_6 = 0

			if var_471_6 < arg_468_1.time_ and arg_468_1.time_ <= var_471_6 + arg_471_0 then
				arg_468_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action7_2")
			end

			local var_471_7 = 0

			if var_471_7 < arg_468_1.time_ and arg_468_1.time_ <= var_471_7 + arg_471_0 then
				arg_468_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_471_8 = 0
			local var_471_9 = 0.35

			if var_471_8 < arg_468_1.time_ and arg_468_1.time_ <= var_471_8 + arg_471_0 then
				arg_468_1.talkMaxDuration = 0
				arg_468_1.dialogCg_.alpha = 1

				arg_468_1.dialog_:SetActive(true)
				SetActive(arg_468_1.leftNameGo_, true)

				local var_471_10 = arg_468_1:FormatText(StoryNameCfg[7].name)

				arg_468_1.leftNameTxt_.text = var_471_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_468_1.leftNameTxt_.transform)

				arg_468_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_468_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_468_1:RecordName(arg_468_1.leftNameTxt_.text)
				SetActive(arg_468_1.iconTrs_.gameObject, true)
				arg_468_1.iconController_:SetSelectedState("hero")

				arg_468_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_468_1.callingController_:SetSelectedState("normal")

				arg_468_1.keyicon_.color = Color.New(1, 1, 1)
				arg_468_1.icon_.color = Color.New(1, 1, 1)

				local var_471_11 = arg_468_1:GetWordFromCfg(121421115)
				local var_471_12 = arg_468_1:FormatText(var_471_11.content)

				arg_468_1.text_.text = var_471_12

				LuaForUtil.ClearLinePrefixSymbol(arg_468_1.text_)

				local var_471_13 = 14
				local var_471_14 = utf8.len(var_471_12)
				local var_471_15 = var_471_13 <= 0 and var_471_9 or var_471_9 * (var_471_14 / var_471_13)

				if var_471_15 > 0 and var_471_9 < var_471_15 then
					arg_468_1.talkMaxDuration = var_471_15

					if var_471_15 + var_471_8 > arg_468_1.duration_ then
						arg_468_1.duration_ = var_471_15 + var_471_8
					end
				end

				arg_468_1.text_.text = var_471_12
				arg_468_1.typewritter.percent = 0

				arg_468_1.typewritter:SetDirty()
				arg_468_1:ShowNextGo(false)
				arg_468_1:RecordContent(arg_468_1.text_.text)
			end

			local var_471_16 = math.max(var_471_9, arg_468_1.talkMaxDuration)

			if var_471_8 <= arg_468_1.time_ and arg_468_1.time_ < var_471_8 + var_471_16 then
				arg_468_1.typewritter.percent = (arg_468_1.time_ - var_471_8) / var_471_16

				arg_468_1.typewritter:SetDirty()
			end

			if arg_468_1.time_ >= var_471_8 + var_471_16 and arg_468_1.time_ < var_471_8 + var_471_16 + arg_471_0 then
				arg_468_1.typewritter.percent = 1

				arg_468_1.typewritter:SetDirty()
				arg_468_1:ShowNextGo(true)
			end
		end

		arg_468_1.nodeConfigList_ = {}

		arg_468_1:InitPlayNodeList()
	end,
	Play121421116 = function(arg_472_0, arg_472_1)
		arg_472_1.time_ = 0
		arg_472_1.frameCnt_ = 0
		arg_472_1.state_ = "playing"
		arg_472_1.curTalkId_ = 121421116
		arg_472_1.duration_ = 8.47

		local var_472_0 = {
			ja = 8.466,
			ko = 3.633,
			zh = 3.633
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
		end

		function arg_472_1.playNext_(arg_474_0)
			if arg_474_0 == 1 then
				arg_472_0:Play121421117(arg_472_1)
			end
		end

		function arg_472_1.onSingleLineUpdate_(arg_475_0)
			local var_475_0 = arg_472_1.actors_["1072ui_story"]
			local var_475_1 = 0

			if var_475_1 < arg_472_1.time_ and arg_472_1.time_ <= var_475_1 + arg_475_0 and not isNil(var_475_0) and arg_472_1.var_.characterEffect1072ui_story == nil then
				arg_472_1.var_.characterEffect1072ui_story = var_475_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_475_2 = 0.200000002980232

			if var_475_1 <= arg_472_1.time_ and arg_472_1.time_ < var_475_1 + var_475_2 and not isNil(var_475_0) then
				local var_475_3 = (arg_472_1.time_ - var_475_1) / var_475_2

				if arg_472_1.var_.characterEffect1072ui_story and not isNil(var_475_0) then
					arg_472_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_472_1.time_ >= var_475_1 + var_475_2 and arg_472_1.time_ < var_475_1 + var_475_2 + arg_475_0 and not isNil(var_475_0) and arg_472_1.var_.characterEffect1072ui_story then
				arg_472_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_475_4 = 0

			if var_475_4 < arg_472_1.time_ and arg_472_1.time_ <= var_475_4 + arg_475_0 then
				arg_472_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_475_5 = 0
			local var_475_6 = 0.4

			if var_475_5 < arg_472_1.time_ and arg_472_1.time_ <= var_475_5 + arg_475_0 then
				arg_472_1.talkMaxDuration = 0
				arg_472_1.dialogCg_.alpha = 1

				arg_472_1.dialog_:SetActive(true)
				SetActive(arg_472_1.leftNameGo_, true)

				local var_475_7 = arg_472_1:FormatText(StoryNameCfg[379].name)

				arg_472_1.leftNameTxt_.text = var_475_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_472_1.leftNameTxt_.transform)

				arg_472_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_472_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_472_1:RecordName(arg_472_1.leftNameTxt_.text)
				SetActive(arg_472_1.iconTrs_.gameObject, false)
				arg_472_1.callingController_:SetSelectedState("normal")

				local var_475_8 = arg_472_1:GetWordFromCfg(121421116)
				local var_475_9 = arg_472_1:FormatText(var_475_8.content)

				arg_472_1.text_.text = var_475_9

				LuaForUtil.ClearLinePrefixSymbol(arg_472_1.text_)

				local var_475_10 = 16
				local var_475_11 = utf8.len(var_475_9)
				local var_475_12 = var_475_10 <= 0 and var_475_6 or var_475_6 * (var_475_11 / var_475_10)

				if var_475_12 > 0 and var_475_6 < var_475_12 then
					arg_472_1.talkMaxDuration = var_475_12

					if var_475_12 + var_475_5 > arg_472_1.duration_ then
						arg_472_1.duration_ = var_475_12 + var_475_5
					end
				end

				arg_472_1.text_.text = var_475_9
				arg_472_1.typewritter.percent = 0

				arg_472_1.typewritter:SetDirty()
				arg_472_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121421", "121421116", "story_v_out_121421.awb") ~= 0 then
					local var_475_13 = manager.audio:GetVoiceLength("story_v_out_121421", "121421116", "story_v_out_121421.awb") / 1000

					if var_475_13 + var_475_5 > arg_472_1.duration_ then
						arg_472_1.duration_ = var_475_13 + var_475_5
					end

					if var_475_8.prefab_name ~= "" and arg_472_1.actors_[var_475_8.prefab_name] ~= nil then
						local var_475_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_472_1.actors_[var_475_8.prefab_name].transform, "story_v_out_121421", "121421116", "story_v_out_121421.awb")

						arg_472_1:RecordAudio("121421116", var_475_14)
						arg_472_1:RecordAudio("121421116", var_475_14)
					else
						arg_472_1:AudioAction("play", "voice", "story_v_out_121421", "121421116", "story_v_out_121421.awb")
					end

					arg_472_1:RecordHistoryTalkVoice("story_v_out_121421", "121421116", "story_v_out_121421.awb")
				end

				arg_472_1:RecordContent(arg_472_1.text_.text)
			end

			local var_475_15 = math.max(var_475_6, arg_472_1.talkMaxDuration)

			if var_475_5 <= arg_472_1.time_ and arg_472_1.time_ < var_475_5 + var_475_15 then
				arg_472_1.typewritter.percent = (arg_472_1.time_ - var_475_5) / var_475_15

				arg_472_1.typewritter:SetDirty()
			end

			if arg_472_1.time_ >= var_475_5 + var_475_15 and arg_472_1.time_ < var_475_5 + var_475_15 + arg_475_0 then
				arg_472_1.typewritter.percent = 1

				arg_472_1.typewritter:SetDirty()
				arg_472_1:ShowNextGo(true)
			end
		end

		arg_472_1.nodeConfigList_ = {}

		arg_472_1:InitPlayNodeList()
	end,
	Play121421117 = function(arg_476_0, arg_476_1)
		arg_476_1.time_ = 0
		arg_476_1.frameCnt_ = 0
		arg_476_1.state_ = "playing"
		arg_476_1.curTalkId_ = 121421117
		arg_476_1.duration_ = 5

		SetActive(arg_476_1.tipsGo_, false)

		function arg_476_1.onSingleLineFinish_()
			arg_476_1.onSingleLineUpdate_ = nil
			arg_476_1.onSingleLineFinish_ = nil
			arg_476_1.state_ = "waiting"
		end

		function arg_476_1.playNext_(arg_478_0)
			if arg_478_0 == 1 then
				arg_476_0:Play121421118(arg_476_1)
			end
		end

		function arg_476_1.onSingleLineUpdate_(arg_479_0)
			local var_479_0 = arg_476_1.actors_["1072ui_story"]
			local var_479_1 = 0

			if var_479_1 < arg_476_1.time_ and arg_476_1.time_ <= var_479_1 + arg_479_0 and not isNil(var_479_0) and arg_476_1.var_.characterEffect1072ui_story == nil then
				arg_476_1.var_.characterEffect1072ui_story = var_479_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_479_2 = 0.200000002980232

			if var_479_1 <= arg_476_1.time_ and arg_476_1.time_ < var_479_1 + var_479_2 and not isNil(var_479_0) then
				local var_479_3 = (arg_476_1.time_ - var_479_1) / var_479_2

				if arg_476_1.var_.characterEffect1072ui_story and not isNil(var_479_0) then
					local var_479_4 = Mathf.Lerp(0, 0.5, var_479_3)

					arg_476_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_476_1.var_.characterEffect1072ui_story.fillRatio = var_479_4
				end
			end

			if arg_476_1.time_ >= var_479_1 + var_479_2 and arg_476_1.time_ < var_479_1 + var_479_2 + arg_479_0 and not isNil(var_479_0) and arg_476_1.var_.characterEffect1072ui_story then
				local var_479_5 = 0.5

				arg_476_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_476_1.var_.characterEffect1072ui_story.fillRatio = var_479_5
			end

			local var_479_6 = 0
			local var_479_7 = 0.175

			if var_479_6 < arg_476_1.time_ and arg_476_1.time_ <= var_479_6 + arg_479_0 then
				arg_476_1.talkMaxDuration = 0
				arg_476_1.dialogCg_.alpha = 1

				arg_476_1.dialog_:SetActive(true)
				SetActive(arg_476_1.leftNameGo_, true)

				local var_479_8 = arg_476_1:FormatText(StoryNameCfg[7].name)

				arg_476_1.leftNameTxt_.text = var_479_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_476_1.leftNameTxt_.transform)

				arg_476_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_476_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_476_1:RecordName(arg_476_1.leftNameTxt_.text)
				SetActive(arg_476_1.iconTrs_.gameObject, true)
				arg_476_1.iconController_:SetSelectedState("hero")

				arg_476_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_476_1.callingController_:SetSelectedState("normal")

				arg_476_1.keyicon_.color = Color.New(1, 1, 1)
				arg_476_1.icon_.color = Color.New(1, 1, 1)

				local var_479_9 = arg_476_1:GetWordFromCfg(121421117)
				local var_479_10 = arg_476_1:FormatText(var_479_9.content)

				arg_476_1.text_.text = var_479_10

				LuaForUtil.ClearLinePrefixSymbol(arg_476_1.text_)

				local var_479_11 = 7
				local var_479_12 = utf8.len(var_479_10)
				local var_479_13 = var_479_11 <= 0 and var_479_7 or var_479_7 * (var_479_12 / var_479_11)

				if var_479_13 > 0 and var_479_7 < var_479_13 then
					arg_476_1.talkMaxDuration = var_479_13

					if var_479_13 + var_479_6 > arg_476_1.duration_ then
						arg_476_1.duration_ = var_479_13 + var_479_6
					end
				end

				arg_476_1.text_.text = var_479_10
				arg_476_1.typewritter.percent = 0

				arg_476_1.typewritter:SetDirty()
				arg_476_1:ShowNextGo(false)
				arg_476_1:RecordContent(arg_476_1.text_.text)
			end

			local var_479_14 = math.max(var_479_7, arg_476_1.talkMaxDuration)

			if var_479_6 <= arg_476_1.time_ and arg_476_1.time_ < var_479_6 + var_479_14 then
				arg_476_1.typewritter.percent = (arg_476_1.time_ - var_479_6) / var_479_14

				arg_476_1.typewritter:SetDirty()
			end

			if arg_476_1.time_ >= var_479_6 + var_479_14 and arg_476_1.time_ < var_479_6 + var_479_14 + arg_479_0 then
				arg_476_1.typewritter.percent = 1

				arg_476_1.typewritter:SetDirty()
				arg_476_1:ShowNextGo(true)
			end
		end

		arg_476_1.nodeConfigList_ = {}

		arg_476_1:InitPlayNodeList()
	end,
	Play121421118 = function(arg_480_0, arg_480_1)
		arg_480_1.time_ = 0
		arg_480_1.frameCnt_ = 0
		arg_480_1.state_ = "playing"
		arg_480_1.curTalkId_ = 121421118
		arg_480_1.duration_ = 5

		SetActive(arg_480_1.tipsGo_, false)

		function arg_480_1.onSingleLineFinish_()
			arg_480_1.onSingleLineUpdate_ = nil
			arg_480_1.onSingleLineFinish_ = nil
			arg_480_1.state_ = "waiting"
		end

		function arg_480_1.playNext_(arg_482_0)
			if arg_482_0 == 1 then
				arg_480_0:Play121421119(arg_480_1)
			end
		end

		function arg_480_1.onSingleLineUpdate_(arg_483_0)
			local var_483_0 = 0
			local var_483_1 = 0.45

			if var_483_0 < arg_480_1.time_ and arg_480_1.time_ <= var_483_0 + arg_483_0 then
				arg_480_1.talkMaxDuration = 0
				arg_480_1.dialogCg_.alpha = 1

				arg_480_1.dialog_:SetActive(true)
				SetActive(arg_480_1.leftNameGo_, true)

				local var_483_2 = arg_480_1:FormatText(StoryNameCfg[7].name)

				arg_480_1.leftNameTxt_.text = var_483_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_480_1.leftNameTxt_.transform)

				arg_480_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_480_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_480_1:RecordName(arg_480_1.leftNameTxt_.text)
				SetActive(arg_480_1.iconTrs_.gameObject, true)
				arg_480_1.iconController_:SetSelectedState("hero")

				arg_480_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_480_1.callingController_:SetSelectedState("normal")

				arg_480_1.keyicon_.color = Color.New(1, 1, 1)
				arg_480_1.icon_.color = Color.New(1, 1, 1)

				local var_483_3 = arg_480_1:GetWordFromCfg(121421118)
				local var_483_4 = arg_480_1:FormatText(var_483_3.content)

				arg_480_1.text_.text = var_483_4

				LuaForUtil.ClearLinePrefixSymbol(arg_480_1.text_)

				local var_483_5 = 18
				local var_483_6 = utf8.len(var_483_4)
				local var_483_7 = var_483_5 <= 0 and var_483_1 or var_483_1 * (var_483_6 / var_483_5)

				if var_483_7 > 0 and var_483_1 < var_483_7 then
					arg_480_1.talkMaxDuration = var_483_7

					if var_483_7 + var_483_0 > arg_480_1.duration_ then
						arg_480_1.duration_ = var_483_7 + var_483_0
					end
				end

				arg_480_1.text_.text = var_483_4
				arg_480_1.typewritter.percent = 0

				arg_480_1.typewritter:SetDirty()
				arg_480_1:ShowNextGo(false)
				arg_480_1:RecordContent(arg_480_1.text_.text)
			end

			local var_483_8 = math.max(var_483_1, arg_480_1.talkMaxDuration)

			if var_483_0 <= arg_480_1.time_ and arg_480_1.time_ < var_483_0 + var_483_8 then
				arg_480_1.typewritter.percent = (arg_480_1.time_ - var_483_0) / var_483_8

				arg_480_1.typewritter:SetDirty()
			end

			if arg_480_1.time_ >= var_483_0 + var_483_8 and arg_480_1.time_ < var_483_0 + var_483_8 + arg_483_0 then
				arg_480_1.typewritter.percent = 1

				arg_480_1.typewritter:SetDirty()
				arg_480_1:ShowNextGo(true)
			end
		end

		arg_480_1.nodeConfigList_ = {}

		arg_480_1:InitPlayNodeList()
	end,
	Play121421119 = function(arg_484_0, arg_484_1)
		arg_484_1.time_ = 0
		arg_484_1.frameCnt_ = 0
		arg_484_1.state_ = "playing"
		arg_484_1.curTalkId_ = 121421119
		arg_484_1.duration_ = 2.37

		local var_484_0 = {
			ja = 1.999999999999,
			ko = 2.366,
			zh = 2.366
		}
		local var_484_1 = manager.audio:GetLocalizationFlag()

		if var_484_0[var_484_1] ~= nil then
			arg_484_1.duration_ = var_484_0[var_484_1]
		end

		SetActive(arg_484_1.tipsGo_, false)

		function arg_484_1.onSingleLineFinish_()
			arg_484_1.onSingleLineUpdate_ = nil
			arg_484_1.onSingleLineFinish_ = nil
			arg_484_1.state_ = "waiting"
		end

		function arg_484_1.playNext_(arg_486_0)
			if arg_486_0 == 1 then
				arg_484_0:Play121421120(arg_484_1)
			end
		end

		function arg_484_1.onSingleLineUpdate_(arg_487_0)
			local var_487_0 = arg_484_1.actors_["1072ui_story"].transform
			local var_487_1 = 0

			if var_487_1 < arg_484_1.time_ and arg_484_1.time_ <= var_487_1 + arg_487_0 then
				arg_484_1.var_.moveOldPos1072ui_story = var_487_0.localPosition
			end

			local var_487_2 = 0.001

			if var_487_1 <= arg_484_1.time_ and arg_484_1.time_ < var_487_1 + var_487_2 then
				local var_487_3 = (arg_484_1.time_ - var_487_1) / var_487_2
				local var_487_4 = Vector3.New(0, 100, 0)

				var_487_0.localPosition = Vector3.Lerp(arg_484_1.var_.moveOldPos1072ui_story, var_487_4, var_487_3)

				local var_487_5 = manager.ui.mainCamera.transform.position - var_487_0.position

				var_487_0.forward = Vector3.New(var_487_5.x, var_487_5.y, var_487_5.z)

				local var_487_6 = var_487_0.localEulerAngles

				var_487_6.z = 0
				var_487_6.x = 0
				var_487_0.localEulerAngles = var_487_6
			end

			if arg_484_1.time_ >= var_487_1 + var_487_2 and arg_484_1.time_ < var_487_1 + var_487_2 + arg_487_0 then
				var_487_0.localPosition = Vector3.New(0, 100, 0)

				local var_487_7 = manager.ui.mainCamera.transform.position - var_487_0.position

				var_487_0.forward = Vector3.New(var_487_7.x, var_487_7.y, var_487_7.z)

				local var_487_8 = var_487_0.localEulerAngles

				var_487_8.z = 0
				var_487_8.x = 0
				var_487_0.localEulerAngles = var_487_8
			end

			local var_487_9 = arg_484_1.actors_["1072ui_story"]
			local var_487_10 = 0

			if var_487_10 < arg_484_1.time_ and arg_484_1.time_ <= var_487_10 + arg_487_0 and not isNil(var_487_9) and arg_484_1.var_.characterEffect1072ui_story == nil then
				arg_484_1.var_.characterEffect1072ui_story = var_487_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_487_11 = 0.200000002980232

			if var_487_10 <= arg_484_1.time_ and arg_484_1.time_ < var_487_10 + var_487_11 and not isNil(var_487_9) then
				local var_487_12 = (arg_484_1.time_ - var_487_10) / var_487_11

				if arg_484_1.var_.characterEffect1072ui_story and not isNil(var_487_9) then
					local var_487_13 = Mathf.Lerp(0, 0.5, var_487_12)

					arg_484_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_484_1.var_.characterEffect1072ui_story.fillRatio = var_487_13
				end
			end

			if arg_484_1.time_ >= var_487_10 + var_487_11 and arg_484_1.time_ < var_487_10 + var_487_11 + arg_487_0 and not isNil(var_487_9) and arg_484_1.var_.characterEffect1072ui_story then
				local var_487_14 = 0.5

				arg_484_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_484_1.var_.characterEffect1072ui_story.fillRatio = var_487_14
			end

			local var_487_15 = arg_484_1.actors_["1084ui_story"].transform
			local var_487_16 = 0

			if var_487_16 < arg_484_1.time_ and arg_484_1.time_ <= var_487_16 + arg_487_0 then
				arg_484_1.var_.moveOldPos1084ui_story = var_487_15.localPosition
			end

			local var_487_17 = 0.001

			if var_487_16 <= arg_484_1.time_ and arg_484_1.time_ < var_487_16 + var_487_17 then
				local var_487_18 = (arg_484_1.time_ - var_487_16) / var_487_17
				local var_487_19 = Vector3.New(0, -0.97, -6)

				var_487_15.localPosition = Vector3.Lerp(arg_484_1.var_.moveOldPos1084ui_story, var_487_19, var_487_18)

				local var_487_20 = manager.ui.mainCamera.transform.position - var_487_15.position

				var_487_15.forward = Vector3.New(var_487_20.x, var_487_20.y, var_487_20.z)

				local var_487_21 = var_487_15.localEulerAngles

				var_487_21.z = 0
				var_487_21.x = 0
				var_487_15.localEulerAngles = var_487_21
			end

			if arg_484_1.time_ >= var_487_16 + var_487_17 and arg_484_1.time_ < var_487_16 + var_487_17 + arg_487_0 then
				var_487_15.localPosition = Vector3.New(0, -0.97, -6)

				local var_487_22 = manager.ui.mainCamera.transform.position - var_487_15.position

				var_487_15.forward = Vector3.New(var_487_22.x, var_487_22.y, var_487_22.z)

				local var_487_23 = var_487_15.localEulerAngles

				var_487_23.z = 0
				var_487_23.x = 0
				var_487_15.localEulerAngles = var_487_23
			end

			local var_487_24 = arg_484_1.actors_["1084ui_story"]
			local var_487_25 = 0

			if var_487_25 < arg_484_1.time_ and arg_484_1.time_ <= var_487_25 + arg_487_0 and not isNil(var_487_24) and arg_484_1.var_.characterEffect1084ui_story == nil then
				arg_484_1.var_.characterEffect1084ui_story = var_487_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_487_26 = 0.200000002980232

			if var_487_25 <= arg_484_1.time_ and arg_484_1.time_ < var_487_25 + var_487_26 and not isNil(var_487_24) then
				local var_487_27 = (arg_484_1.time_ - var_487_25) / var_487_26

				if arg_484_1.var_.characterEffect1084ui_story and not isNil(var_487_24) then
					arg_484_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_484_1.time_ >= var_487_25 + var_487_26 and arg_484_1.time_ < var_487_25 + var_487_26 + arg_487_0 and not isNil(var_487_24) and arg_484_1.var_.characterEffect1084ui_story then
				arg_484_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_487_28 = 0

			if var_487_28 < arg_484_1.time_ and arg_484_1.time_ <= var_487_28 + arg_487_0 then
				arg_484_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_487_29 = 0

			if var_487_29 < arg_484_1.time_ and arg_484_1.time_ <= var_487_29 + arg_487_0 then
				arg_484_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_487_30 = 0
			local var_487_31 = 0.075

			if var_487_30 < arg_484_1.time_ and arg_484_1.time_ <= var_487_30 + arg_487_0 then
				arg_484_1.talkMaxDuration = 0
				arg_484_1.dialogCg_.alpha = 1

				arg_484_1.dialog_:SetActive(true)
				SetActive(arg_484_1.leftNameGo_, true)

				local var_487_32 = arg_484_1:FormatText(StoryNameCfg[6].name)

				arg_484_1.leftNameTxt_.text = var_487_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_484_1.leftNameTxt_.transform)

				arg_484_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_484_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_484_1:RecordName(arg_484_1.leftNameTxt_.text)
				SetActive(arg_484_1.iconTrs_.gameObject, false)
				arg_484_1.callingController_:SetSelectedState("normal")

				local var_487_33 = arg_484_1:GetWordFromCfg(121421119)
				local var_487_34 = arg_484_1:FormatText(var_487_33.content)

				arg_484_1.text_.text = var_487_34

				LuaForUtil.ClearLinePrefixSymbol(arg_484_1.text_)

				local var_487_35 = 3
				local var_487_36 = utf8.len(var_487_34)
				local var_487_37 = var_487_35 <= 0 and var_487_31 or var_487_31 * (var_487_36 / var_487_35)

				if var_487_37 > 0 and var_487_31 < var_487_37 then
					arg_484_1.talkMaxDuration = var_487_37

					if var_487_37 + var_487_30 > arg_484_1.duration_ then
						arg_484_1.duration_ = var_487_37 + var_487_30
					end
				end

				arg_484_1.text_.text = var_487_34
				arg_484_1.typewritter.percent = 0

				arg_484_1.typewritter:SetDirty()
				arg_484_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121421", "121421119", "story_v_out_121421.awb") ~= 0 then
					local var_487_38 = manager.audio:GetVoiceLength("story_v_out_121421", "121421119", "story_v_out_121421.awb") / 1000

					if var_487_38 + var_487_30 > arg_484_1.duration_ then
						arg_484_1.duration_ = var_487_38 + var_487_30
					end

					if var_487_33.prefab_name ~= "" and arg_484_1.actors_[var_487_33.prefab_name] ~= nil then
						local var_487_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_484_1.actors_[var_487_33.prefab_name].transform, "story_v_out_121421", "121421119", "story_v_out_121421.awb")

						arg_484_1:RecordAudio("121421119", var_487_39)
						arg_484_1:RecordAudio("121421119", var_487_39)
					else
						arg_484_1:AudioAction("play", "voice", "story_v_out_121421", "121421119", "story_v_out_121421.awb")
					end

					arg_484_1:RecordHistoryTalkVoice("story_v_out_121421", "121421119", "story_v_out_121421.awb")
				end

				arg_484_1:RecordContent(arg_484_1.text_.text)
			end

			local var_487_40 = math.max(var_487_31, arg_484_1.talkMaxDuration)

			if var_487_30 <= arg_484_1.time_ and arg_484_1.time_ < var_487_30 + var_487_40 then
				arg_484_1.typewritter.percent = (arg_484_1.time_ - var_487_30) / var_487_40

				arg_484_1.typewritter:SetDirty()
			end

			if arg_484_1.time_ >= var_487_30 + var_487_40 and arg_484_1.time_ < var_487_30 + var_487_40 + arg_487_0 then
				arg_484_1.typewritter.percent = 1

				arg_484_1.typewritter:SetDirty()
				arg_484_1:ShowNextGo(true)
			end
		end

		arg_484_1.nodeConfigList_ = {
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
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_484_1:InitPlayNodeList()
	end,
	Play121421120 = function(arg_488_0, arg_488_1)
		arg_488_1.time_ = 0
		arg_488_1.frameCnt_ = 0
		arg_488_1.state_ = "playing"
		arg_488_1.curTalkId_ = 121421120
		arg_488_1.duration_ = 5.8

		SetActive(arg_488_1.tipsGo_, false)

		function arg_488_1.onSingleLineFinish_()
			arg_488_1.onSingleLineUpdate_ = nil
			arg_488_1.onSingleLineFinish_ = nil
			arg_488_1.state_ = "waiting"
		end

		function arg_488_1.playNext_(arg_490_0)
			if arg_490_0 == 1 then
				arg_488_0:Play121421121(arg_488_1)
			end
		end

		function arg_488_1.onSingleLineUpdate_(arg_491_0)
			local var_491_0 = arg_488_1.actors_["1084ui_story"].transform
			local var_491_1 = 1.96599999815226

			if var_491_1 < arg_488_1.time_ and arg_488_1.time_ <= var_491_1 + arg_491_0 then
				arg_488_1.var_.moveOldPos1084ui_story = var_491_0.localPosition
			end

			local var_491_2 = 0.001

			if var_491_1 <= arg_488_1.time_ and arg_488_1.time_ < var_491_1 + var_491_2 then
				local var_491_3 = (arg_488_1.time_ - var_491_1) / var_491_2
				local var_491_4 = Vector3.New(0, 100, 0)

				var_491_0.localPosition = Vector3.Lerp(arg_488_1.var_.moveOldPos1084ui_story, var_491_4, var_491_3)

				local var_491_5 = manager.ui.mainCamera.transform.position - var_491_0.position

				var_491_0.forward = Vector3.New(var_491_5.x, var_491_5.y, var_491_5.z)

				local var_491_6 = var_491_0.localEulerAngles

				var_491_6.z = 0
				var_491_6.x = 0
				var_491_0.localEulerAngles = var_491_6
			end

			if arg_488_1.time_ >= var_491_1 + var_491_2 and arg_488_1.time_ < var_491_1 + var_491_2 + arg_491_0 then
				var_491_0.localPosition = Vector3.New(0, 100, 0)

				local var_491_7 = manager.ui.mainCamera.transform.position - var_491_0.position

				var_491_0.forward = Vector3.New(var_491_7.x, var_491_7.y, var_491_7.z)

				local var_491_8 = var_491_0.localEulerAngles

				var_491_8.z = 0
				var_491_8.x = 0
				var_491_0.localEulerAngles = var_491_8
			end

			local var_491_9 = arg_488_1.actors_["1084ui_story"]
			local var_491_10 = 1.96599999815226

			if var_491_10 < arg_488_1.time_ and arg_488_1.time_ <= var_491_10 + arg_491_0 and not isNil(var_491_9) and arg_488_1.var_.characterEffect1084ui_story == nil then
				arg_488_1.var_.characterEffect1084ui_story = var_491_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_491_11 = 0.034000001847744

			if var_491_10 <= arg_488_1.time_ and arg_488_1.time_ < var_491_10 + var_491_11 and not isNil(var_491_9) then
				local var_491_12 = (arg_488_1.time_ - var_491_10) / var_491_11

				if arg_488_1.var_.characterEffect1084ui_story and not isNil(var_491_9) then
					local var_491_13 = Mathf.Lerp(0, 0.5, var_491_12)

					arg_488_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_488_1.var_.characterEffect1084ui_story.fillRatio = var_491_13
				end
			end

			if arg_488_1.time_ >= var_491_10 + var_491_11 and arg_488_1.time_ < var_491_10 + var_491_11 + arg_491_0 and not isNil(var_491_9) and arg_488_1.var_.characterEffect1084ui_story then
				local var_491_14 = 0.5

				arg_488_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_488_1.var_.characterEffect1084ui_story.fillRatio = var_491_14
			end

			local var_491_15 = arg_488_1.actors_["1072ui_story"].transform
			local var_491_16 = 3.8

			if var_491_16 < arg_488_1.time_ and arg_488_1.time_ <= var_491_16 + arg_491_0 then
				arg_488_1.var_.moveOldPos1072ui_story = var_491_15.localPosition
			end

			local var_491_17 = 0.001

			if var_491_16 <= arg_488_1.time_ and arg_488_1.time_ < var_491_16 + var_491_17 then
				local var_491_18 = (arg_488_1.time_ - var_491_16) / var_491_17
				local var_491_19 = Vector3.New(0, -0.71, -6)

				var_491_15.localPosition = Vector3.Lerp(arg_488_1.var_.moveOldPos1072ui_story, var_491_19, var_491_18)

				local var_491_20 = manager.ui.mainCamera.transform.position - var_491_15.position

				var_491_15.forward = Vector3.New(var_491_20.x, var_491_20.y, var_491_20.z)

				local var_491_21 = var_491_15.localEulerAngles

				var_491_21.z = 0
				var_491_21.x = 0
				var_491_15.localEulerAngles = var_491_21
			end

			if arg_488_1.time_ >= var_491_16 + var_491_17 and arg_488_1.time_ < var_491_16 + var_491_17 + arg_491_0 then
				var_491_15.localPosition = Vector3.New(0, -0.71, -6)

				local var_491_22 = manager.ui.mainCamera.transform.position - var_491_15.position

				var_491_15.forward = Vector3.New(var_491_22.x, var_491_22.y, var_491_22.z)

				local var_491_23 = var_491_15.localEulerAngles

				var_491_23.z = 0
				var_491_23.x = 0
				var_491_15.localEulerAngles = var_491_23
			end

			local var_491_24 = arg_488_1.actors_["1072ui_story"]
			local var_491_25 = 3.8

			if var_491_25 < arg_488_1.time_ and arg_488_1.time_ <= var_491_25 + arg_491_0 and not isNil(var_491_24) and arg_488_1.var_.characterEffect1072ui_story == nil then
				arg_488_1.var_.characterEffect1072ui_story = var_491_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_491_26 = 0.200000002980232

			if var_491_25 <= arg_488_1.time_ and arg_488_1.time_ < var_491_25 + var_491_26 and not isNil(var_491_24) then
				local var_491_27 = (arg_488_1.time_ - var_491_25) / var_491_26

				if arg_488_1.var_.characterEffect1072ui_story and not isNil(var_491_24) then
					arg_488_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_488_1.time_ >= var_491_25 + var_491_26 and arg_488_1.time_ < var_491_25 + var_491_26 + arg_491_0 and not isNil(var_491_24) and arg_488_1.var_.characterEffect1072ui_story then
				arg_488_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_491_28 = 3.8

			if var_491_28 < arg_488_1.time_ and arg_488_1.time_ <= var_491_28 + arg_491_0 then
				arg_488_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action1_1")
			end

			local var_491_29 = 3.8

			if var_491_29 < arg_488_1.time_ and arg_488_1.time_ <= var_491_29 + arg_491_0 then
				arg_488_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_491_30 = 0

			if var_491_30 < arg_488_1.time_ and arg_488_1.time_ <= var_491_30 + arg_491_0 then
				arg_488_1.mask_.enabled = true
				arg_488_1.mask_.raycastTarget = true

				arg_488_1:SetGaussion(false)
			end

			local var_491_31 = 2

			if var_491_30 <= arg_488_1.time_ and arg_488_1.time_ < var_491_30 + var_491_31 then
				local var_491_32 = (arg_488_1.time_ - var_491_30) / var_491_31
				local var_491_33 = Color.New(0, 0, 0)

				var_491_33.a = Mathf.Lerp(0, 1, var_491_32)
				arg_488_1.mask_.color = var_491_33
			end

			if arg_488_1.time_ >= var_491_30 + var_491_31 and arg_488_1.time_ < var_491_30 + var_491_31 + arg_491_0 then
				local var_491_34 = Color.New(0, 0, 0)

				var_491_34.a = 1
				arg_488_1.mask_.color = var_491_34
			end

			local var_491_35 = 2

			if var_491_35 < arg_488_1.time_ and arg_488_1.time_ <= var_491_35 + arg_491_0 then
				arg_488_1.mask_.enabled = true
				arg_488_1.mask_.raycastTarget = true

				arg_488_1:SetGaussion(false)
			end

			local var_491_36 = 2

			if var_491_35 <= arg_488_1.time_ and arg_488_1.time_ < var_491_35 + var_491_36 then
				local var_491_37 = (arg_488_1.time_ - var_491_35) / var_491_36
				local var_491_38 = Color.New(0, 0, 0)

				var_491_38.a = Mathf.Lerp(1, 0, var_491_37)
				arg_488_1.mask_.color = var_491_38
			end

			if arg_488_1.time_ >= var_491_35 + var_491_36 and arg_488_1.time_ < var_491_35 + var_491_36 + arg_491_0 then
				local var_491_39 = Color.New(0, 0, 0)
				local var_491_40 = 0

				arg_488_1.mask_.enabled = false
				var_491_39.a = var_491_40
				arg_488_1.mask_.color = var_491_39
			end

			if arg_488_1.frameCnt_ <= 1 then
				arg_488_1.dialog_:SetActive(false)
			end

			local var_491_41 = 4
			local var_491_42 = 0.05

			if var_491_41 < arg_488_1.time_ and arg_488_1.time_ <= var_491_41 + arg_491_0 then
				arg_488_1.talkMaxDuration = 0

				arg_488_1.dialog_:SetActive(true)

				arg_488_1.dialogCg_.alpha = 0

				local var_491_43 = LeanTween.value(arg_488_1.dialog_, 0, 1, 0.3)

				var_491_43:setOnUpdate(LuaHelper.FloatAction(function(arg_492_0)
					arg_488_1.dialogCg_.alpha = arg_492_0
				end))
				var_491_43:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_488_1.dialog_)
					var_491_43:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_488_1.duration_ = arg_488_1.duration_ + 0.3

				SetActive(arg_488_1.leftNameGo_, true)

				local var_491_44 = arg_488_1:FormatText(StoryNameCfg[379].name)

				arg_488_1.leftNameTxt_.text = var_491_44

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_488_1.leftNameTxt_.transform)

				arg_488_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_488_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_488_1:RecordName(arg_488_1.leftNameTxt_.text)
				SetActive(arg_488_1.iconTrs_.gameObject, false)
				arg_488_1.callingController_:SetSelectedState("normal")

				local var_491_45 = arg_488_1:GetWordFromCfg(121421120)
				local var_491_46 = arg_488_1:FormatText(var_491_45.content)

				arg_488_1.text_.text = var_491_46

				LuaForUtil.ClearLinePrefixSymbol(arg_488_1.text_)

				local var_491_47 = 2
				local var_491_48 = utf8.len(var_491_46)
				local var_491_49 = var_491_47 <= 0 and var_491_42 or var_491_42 * (var_491_48 / var_491_47)

				if var_491_49 > 0 and var_491_42 < var_491_49 then
					arg_488_1.talkMaxDuration = var_491_49
					var_491_41 = var_491_41 + 0.3

					if var_491_49 + var_491_41 > arg_488_1.duration_ then
						arg_488_1.duration_ = var_491_49 + var_491_41
					end
				end

				arg_488_1.text_.text = var_491_46
				arg_488_1.typewritter.percent = 0

				arg_488_1.typewritter:SetDirty()
				arg_488_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121421", "121421120", "story_v_out_121421.awb") ~= 0 then
					local var_491_50 = manager.audio:GetVoiceLength("story_v_out_121421", "121421120", "story_v_out_121421.awb") / 1000

					if var_491_50 + var_491_41 > arg_488_1.duration_ then
						arg_488_1.duration_ = var_491_50 + var_491_41
					end

					if var_491_45.prefab_name ~= "" and arg_488_1.actors_[var_491_45.prefab_name] ~= nil then
						local var_491_51 = LuaForUtil.PlayVoiceWithCriLipsync(arg_488_1.actors_[var_491_45.prefab_name].transform, "story_v_out_121421", "121421120", "story_v_out_121421.awb")

						arg_488_1:RecordAudio("121421120", var_491_51)
						arg_488_1:RecordAudio("121421120", var_491_51)
					else
						arg_488_1:AudioAction("play", "voice", "story_v_out_121421", "121421120", "story_v_out_121421.awb")
					end

					arg_488_1:RecordHistoryTalkVoice("story_v_out_121421", "121421120", "story_v_out_121421.awb")
				end

				arg_488_1:RecordContent(arg_488_1.text_.text)
			end

			local var_491_52 = var_491_41 + 0.3
			local var_491_53 = math.max(var_491_42, arg_488_1.talkMaxDuration)

			if var_491_52 <= arg_488_1.time_ and arg_488_1.time_ < var_491_52 + var_491_53 then
				arg_488_1.typewritter.percent = (arg_488_1.time_ - var_491_52) / var_491_53

				arg_488_1.typewritter:SetDirty()
			end

			if arg_488_1.time_ >= var_491_52 + var_491_53 and arg_488_1.time_ < var_491_52 + var_491_53 + arg_491_0 then
				arg_488_1.typewritter.percent = 1

				arg_488_1.typewritter:SetDirty()
				arg_488_1:ShowNextGo(true)
			end
		end

		arg_488_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_488_1:InitPlayNodeList()
	end,
	Play121421121 = function(arg_494_0, arg_494_1)
		arg_494_1.time_ = 0
		arg_494_1.frameCnt_ = 0
		arg_494_1.state_ = "playing"
		arg_494_1.curTalkId_ = 121421121
		arg_494_1.duration_ = 5

		SetActive(arg_494_1.tipsGo_, false)

		function arg_494_1.onSingleLineFinish_()
			arg_494_1.onSingleLineUpdate_ = nil
			arg_494_1.onSingleLineFinish_ = nil
			arg_494_1.state_ = "waiting"
		end

		function arg_494_1.playNext_(arg_496_0)
			if arg_496_0 == 1 then
				arg_494_0:Play121421122(arg_494_1)
			end
		end

		function arg_494_1.onSingleLineUpdate_(arg_497_0)
			local var_497_0 = arg_494_1.actors_["1072ui_story"].transform
			local var_497_1 = 0

			if var_497_1 < arg_494_1.time_ and arg_494_1.time_ <= var_497_1 + arg_497_0 then
				arg_494_1.var_.moveOldPos1072ui_story = var_497_0.localPosition
			end

			local var_497_2 = 0.001

			if var_497_1 <= arg_494_1.time_ and arg_494_1.time_ < var_497_1 + var_497_2 then
				local var_497_3 = (arg_494_1.time_ - var_497_1) / var_497_2
				local var_497_4 = Vector3.New(0, 100, 0)

				var_497_0.localPosition = Vector3.Lerp(arg_494_1.var_.moveOldPos1072ui_story, var_497_4, var_497_3)

				local var_497_5 = manager.ui.mainCamera.transform.position - var_497_0.position

				var_497_0.forward = Vector3.New(var_497_5.x, var_497_5.y, var_497_5.z)

				local var_497_6 = var_497_0.localEulerAngles

				var_497_6.z = 0
				var_497_6.x = 0
				var_497_0.localEulerAngles = var_497_6
			end

			if arg_494_1.time_ >= var_497_1 + var_497_2 and arg_494_1.time_ < var_497_1 + var_497_2 + arg_497_0 then
				var_497_0.localPosition = Vector3.New(0, 100, 0)

				local var_497_7 = manager.ui.mainCamera.transform.position - var_497_0.position

				var_497_0.forward = Vector3.New(var_497_7.x, var_497_7.y, var_497_7.z)

				local var_497_8 = var_497_0.localEulerAngles

				var_497_8.z = 0
				var_497_8.x = 0
				var_497_0.localEulerAngles = var_497_8
			end

			local var_497_9 = arg_494_1.actors_["1072ui_story"]
			local var_497_10 = 0

			if var_497_10 < arg_494_1.time_ and arg_494_1.time_ <= var_497_10 + arg_497_0 and not isNil(var_497_9) and arg_494_1.var_.characterEffect1072ui_story == nil then
				arg_494_1.var_.characterEffect1072ui_story = var_497_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_497_11 = 0.034000001847744

			if var_497_10 <= arg_494_1.time_ and arg_494_1.time_ < var_497_10 + var_497_11 and not isNil(var_497_9) then
				local var_497_12 = (arg_494_1.time_ - var_497_10) / var_497_11

				if arg_494_1.var_.characterEffect1072ui_story and not isNil(var_497_9) then
					local var_497_13 = Mathf.Lerp(0, 0.5, var_497_12)

					arg_494_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_494_1.var_.characterEffect1072ui_story.fillRatio = var_497_13
				end
			end

			if arg_494_1.time_ >= var_497_10 + var_497_11 and arg_494_1.time_ < var_497_10 + var_497_11 + arg_497_0 and not isNil(var_497_9) and arg_494_1.var_.characterEffect1072ui_story then
				local var_497_14 = 0.5

				arg_494_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_494_1.var_.characterEffect1072ui_story.fillRatio = var_497_14
			end

			local var_497_15 = 0
			local var_497_16 = 0.925

			if var_497_15 < arg_494_1.time_ and arg_494_1.time_ <= var_497_15 + arg_497_0 then
				arg_494_1.talkMaxDuration = 0
				arg_494_1.dialogCg_.alpha = 1

				arg_494_1.dialog_:SetActive(true)
				SetActive(arg_494_1.leftNameGo_, false)

				arg_494_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_494_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_494_1:RecordName(arg_494_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_494_1.iconTrs_.gameObject, false)
				arg_494_1.callingController_:SetSelectedState("normal")

				local var_497_17 = arg_494_1:GetWordFromCfg(121421121)
				local var_497_18 = arg_494_1:FormatText(var_497_17.content)

				arg_494_1.text_.text = var_497_18

				LuaForUtil.ClearLinePrefixSymbol(arg_494_1.text_)

				local var_497_19 = 37
				local var_497_20 = utf8.len(var_497_18)
				local var_497_21 = var_497_19 <= 0 and var_497_16 or var_497_16 * (var_497_20 / var_497_19)

				if var_497_21 > 0 and var_497_16 < var_497_21 then
					arg_494_1.talkMaxDuration = var_497_21

					if var_497_21 + var_497_15 > arg_494_1.duration_ then
						arg_494_1.duration_ = var_497_21 + var_497_15
					end
				end

				arg_494_1.text_.text = var_497_18
				arg_494_1.typewritter.percent = 0

				arg_494_1.typewritter:SetDirty()
				arg_494_1:ShowNextGo(false)
				arg_494_1:RecordContent(arg_494_1.text_.text)
			end

			local var_497_22 = math.max(var_497_16, arg_494_1.talkMaxDuration)

			if var_497_15 <= arg_494_1.time_ and arg_494_1.time_ < var_497_15 + var_497_22 then
				arg_494_1.typewritter.percent = (arg_494_1.time_ - var_497_15) / var_497_22

				arg_494_1.typewritter:SetDirty()
			end

			if arg_494_1.time_ >= var_497_15 + var_497_22 and arg_494_1.time_ < var_497_15 + var_497_22 + arg_497_0 then
				arg_494_1.typewritter.percent = 1

				arg_494_1.typewritter:SetDirty()
				arg_494_1:ShowNextGo(true)
			end
		end

		arg_494_1.nodeConfigList_ = {
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

		arg_494_1:InitPlayNodeList()
	end,
	Play121421122 = function(arg_498_0, arg_498_1)
		arg_498_1.time_ = 0
		arg_498_1.frameCnt_ = 0
		arg_498_1.state_ = "playing"
		arg_498_1.curTalkId_ = 121421122
		arg_498_1.duration_ = 5

		SetActive(arg_498_1.tipsGo_, false)

		function arg_498_1.onSingleLineFinish_()
			arg_498_1.onSingleLineUpdate_ = nil
			arg_498_1.onSingleLineFinish_ = nil
			arg_498_1.state_ = "waiting"
		end

		function arg_498_1.playNext_(arg_500_0)
			if arg_500_0 == 1 then
				arg_498_0:Play121421123(arg_498_1)
			end
		end

		function arg_498_1.onSingleLineUpdate_(arg_501_0)
			local var_501_0 = 0
			local var_501_1 = 1.4

			if var_501_0 < arg_498_1.time_ and arg_498_1.time_ <= var_501_0 + arg_501_0 then
				arg_498_1.talkMaxDuration = 0
				arg_498_1.dialogCg_.alpha = 1

				arg_498_1.dialog_:SetActive(true)
				SetActive(arg_498_1.leftNameGo_, false)

				arg_498_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_498_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_498_1:RecordName(arg_498_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_498_1.iconTrs_.gameObject, false)
				arg_498_1.callingController_:SetSelectedState("normal")

				local var_501_2 = arg_498_1:GetWordFromCfg(121421122)
				local var_501_3 = arg_498_1:FormatText(var_501_2.content)

				arg_498_1.text_.text = var_501_3

				LuaForUtil.ClearLinePrefixSymbol(arg_498_1.text_)

				local var_501_4 = 56
				local var_501_5 = utf8.len(var_501_3)
				local var_501_6 = var_501_4 <= 0 and var_501_1 or var_501_1 * (var_501_5 / var_501_4)

				if var_501_6 > 0 and var_501_1 < var_501_6 then
					arg_498_1.talkMaxDuration = var_501_6

					if var_501_6 + var_501_0 > arg_498_1.duration_ then
						arg_498_1.duration_ = var_501_6 + var_501_0
					end
				end

				arg_498_1.text_.text = var_501_3
				arg_498_1.typewritter.percent = 0

				arg_498_1.typewritter:SetDirty()
				arg_498_1:ShowNextGo(false)
				arg_498_1:RecordContent(arg_498_1.text_.text)
			end

			local var_501_7 = math.max(var_501_1, arg_498_1.talkMaxDuration)

			if var_501_0 <= arg_498_1.time_ and arg_498_1.time_ < var_501_0 + var_501_7 then
				arg_498_1.typewritter.percent = (arg_498_1.time_ - var_501_0) / var_501_7

				arg_498_1.typewritter:SetDirty()
			end

			if arg_498_1.time_ >= var_501_0 + var_501_7 and arg_498_1.time_ < var_501_0 + var_501_7 + arg_501_0 then
				arg_498_1.typewritter.percent = 1

				arg_498_1.typewritter:SetDirty()
				arg_498_1:ShowNextGo(true)
			end
		end

		arg_498_1.nodeConfigList_ = {}

		arg_498_1:InitPlayNodeList()
	end,
	Play121421123 = function(arg_502_0, arg_502_1)
		arg_502_1.time_ = 0
		arg_502_1.frameCnt_ = 0
		arg_502_1.state_ = "playing"
		arg_502_1.curTalkId_ = 121421123
		arg_502_1.duration_ = 5

		SetActive(arg_502_1.tipsGo_, false)

		function arg_502_1.onSingleLineFinish_()
			arg_502_1.onSingleLineUpdate_ = nil
			arg_502_1.onSingleLineFinish_ = nil
			arg_502_1.state_ = "waiting"
		end

		function arg_502_1.playNext_(arg_504_0)
			if arg_504_0 == 1 then
				arg_502_0:Play121421124(arg_502_1)
			end
		end

		function arg_502_1.onSingleLineUpdate_(arg_505_0)
			local var_505_0 = 0
			local var_505_1 = 0.4

			if var_505_0 < arg_502_1.time_ and arg_502_1.time_ <= var_505_0 + arg_505_0 then
				local var_505_2 = "play"
				local var_505_3 = "effect"

				arg_502_1:AudioAction(var_505_2, var_505_3, "se_story_15", "se_story_15_didi", "")
			end

			local var_505_4 = 0
			local var_505_5 = 0.125

			if var_505_4 < arg_502_1.time_ and arg_502_1.time_ <= var_505_4 + arg_505_0 then
				arg_502_1.talkMaxDuration = 0
				arg_502_1.dialogCg_.alpha = 1

				arg_502_1.dialog_:SetActive(true)
				SetActive(arg_502_1.leftNameGo_, false)

				arg_502_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_502_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_502_1:RecordName(arg_502_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_502_1.iconTrs_.gameObject, false)
				arg_502_1.callingController_:SetSelectedState("normal")

				local var_505_6 = arg_502_1:GetWordFromCfg(121421123)
				local var_505_7 = arg_502_1:FormatText(var_505_6.content)

				arg_502_1.text_.text = var_505_7

				LuaForUtil.ClearLinePrefixSymbol(arg_502_1.text_)

				local var_505_8 = 5
				local var_505_9 = utf8.len(var_505_7)
				local var_505_10 = var_505_8 <= 0 and var_505_5 or var_505_5 * (var_505_9 / var_505_8)

				if var_505_10 > 0 and var_505_5 < var_505_10 then
					arg_502_1.talkMaxDuration = var_505_10

					if var_505_10 + var_505_4 > arg_502_1.duration_ then
						arg_502_1.duration_ = var_505_10 + var_505_4
					end
				end

				arg_502_1.text_.text = var_505_7
				arg_502_1.typewritter.percent = 0

				arg_502_1.typewritter:SetDirty()
				arg_502_1:ShowNextGo(false)
				arg_502_1:RecordContent(arg_502_1.text_.text)
			end

			local var_505_11 = math.max(var_505_5, arg_502_1.talkMaxDuration)

			if var_505_4 <= arg_502_1.time_ and arg_502_1.time_ < var_505_4 + var_505_11 then
				arg_502_1.typewritter.percent = (arg_502_1.time_ - var_505_4) / var_505_11

				arg_502_1.typewritter:SetDirty()
			end

			if arg_502_1.time_ >= var_505_4 + var_505_11 and arg_502_1.time_ < var_505_4 + var_505_11 + arg_505_0 then
				arg_502_1.typewritter.percent = 1

				arg_502_1.typewritter:SetDirty()
				arg_502_1:ShowNextGo(true)
			end
		end

		arg_502_1.nodeConfigList_ = {}

		arg_502_1:InitPlayNodeList()
	end,
	Play121421124 = function(arg_506_0, arg_506_1)
		arg_506_1.time_ = 0
		arg_506_1.frameCnt_ = 0
		arg_506_1.state_ = "playing"
		arg_506_1.curTalkId_ = 121421124
		arg_506_1.duration_ = 3.77

		local var_506_0 = {
			ja = 3.766,
			ko = 2.766,
			zh = 2.766
		}
		local var_506_1 = manager.audio:GetLocalizationFlag()

		if var_506_0[var_506_1] ~= nil then
			arg_506_1.duration_ = var_506_0[var_506_1]
		end

		SetActive(arg_506_1.tipsGo_, false)

		function arg_506_1.onSingleLineFinish_()
			arg_506_1.onSingleLineUpdate_ = nil
			arg_506_1.onSingleLineFinish_ = nil
			arg_506_1.state_ = "waiting"
		end

		function arg_506_1.playNext_(arg_508_0)
			if arg_508_0 == 1 then
				arg_506_0:Play121421125(arg_506_1)
			end
		end

		function arg_506_1.onSingleLineUpdate_(arg_509_0)
			local var_509_0 = arg_506_1.actors_["1072ui_story"].transform
			local var_509_1 = 0

			if var_509_1 < arg_506_1.time_ and arg_506_1.time_ <= var_509_1 + arg_509_0 then
				arg_506_1.var_.moveOldPos1072ui_story = var_509_0.localPosition
			end

			local var_509_2 = 0.001

			if var_509_1 <= arg_506_1.time_ and arg_506_1.time_ < var_509_1 + var_509_2 then
				local var_509_3 = (arg_506_1.time_ - var_509_1) / var_509_2
				local var_509_4 = Vector3.New(0, -0.71, -6)

				var_509_0.localPosition = Vector3.Lerp(arg_506_1.var_.moveOldPos1072ui_story, var_509_4, var_509_3)

				local var_509_5 = manager.ui.mainCamera.transform.position - var_509_0.position

				var_509_0.forward = Vector3.New(var_509_5.x, var_509_5.y, var_509_5.z)

				local var_509_6 = var_509_0.localEulerAngles

				var_509_6.z = 0
				var_509_6.x = 0
				var_509_0.localEulerAngles = var_509_6
			end

			if arg_506_1.time_ >= var_509_1 + var_509_2 and arg_506_1.time_ < var_509_1 + var_509_2 + arg_509_0 then
				var_509_0.localPosition = Vector3.New(0, -0.71, -6)

				local var_509_7 = manager.ui.mainCamera.transform.position - var_509_0.position

				var_509_0.forward = Vector3.New(var_509_7.x, var_509_7.y, var_509_7.z)

				local var_509_8 = var_509_0.localEulerAngles

				var_509_8.z = 0
				var_509_8.x = 0
				var_509_0.localEulerAngles = var_509_8
			end

			local var_509_9 = arg_506_1.actors_["1072ui_story"]
			local var_509_10 = 0

			if var_509_10 < arg_506_1.time_ and arg_506_1.time_ <= var_509_10 + arg_509_0 and not isNil(var_509_9) and arg_506_1.var_.characterEffect1072ui_story == nil then
				arg_506_1.var_.characterEffect1072ui_story = var_509_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_509_11 = 0.200000002980232

			if var_509_10 <= arg_506_1.time_ and arg_506_1.time_ < var_509_10 + var_509_11 and not isNil(var_509_9) then
				local var_509_12 = (arg_506_1.time_ - var_509_10) / var_509_11

				if arg_506_1.var_.characterEffect1072ui_story and not isNil(var_509_9) then
					arg_506_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_506_1.time_ >= var_509_10 + var_509_11 and arg_506_1.time_ < var_509_10 + var_509_11 + arg_509_0 and not isNil(var_509_9) and arg_506_1.var_.characterEffect1072ui_story then
				arg_506_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_509_13 = 0

			if var_509_13 < arg_506_1.time_ and arg_506_1.time_ <= var_509_13 + arg_509_0 then
				arg_506_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action1_1")
			end

			local var_509_14 = 0

			if var_509_14 < arg_506_1.time_ and arg_506_1.time_ <= var_509_14 + arg_509_0 then
				arg_506_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_509_15 = 0
			local var_509_16 = 0.25

			if var_509_15 < arg_506_1.time_ and arg_506_1.time_ <= var_509_15 + arg_509_0 then
				arg_506_1.talkMaxDuration = 0
				arg_506_1.dialogCg_.alpha = 1

				arg_506_1.dialog_:SetActive(true)
				SetActive(arg_506_1.leftNameGo_, true)

				local var_509_17 = arg_506_1:FormatText(StoryNameCfg[379].name)

				arg_506_1.leftNameTxt_.text = var_509_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_506_1.leftNameTxt_.transform)

				arg_506_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_506_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_506_1:RecordName(arg_506_1.leftNameTxt_.text)
				SetActive(arg_506_1.iconTrs_.gameObject, false)
				arg_506_1.callingController_:SetSelectedState("normal")

				local var_509_18 = arg_506_1:GetWordFromCfg(121421124)
				local var_509_19 = arg_506_1:FormatText(var_509_18.content)

				arg_506_1.text_.text = var_509_19

				LuaForUtil.ClearLinePrefixSymbol(arg_506_1.text_)

				local var_509_20 = 9
				local var_509_21 = utf8.len(var_509_19)
				local var_509_22 = var_509_20 <= 0 and var_509_16 or var_509_16 * (var_509_21 / var_509_20)

				if var_509_22 > 0 and var_509_16 < var_509_22 then
					arg_506_1.talkMaxDuration = var_509_22

					if var_509_22 + var_509_15 > arg_506_1.duration_ then
						arg_506_1.duration_ = var_509_22 + var_509_15
					end
				end

				arg_506_1.text_.text = var_509_19
				arg_506_1.typewritter.percent = 0

				arg_506_1.typewritter:SetDirty()
				arg_506_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121421", "121421124", "story_v_out_121421.awb") ~= 0 then
					local var_509_23 = manager.audio:GetVoiceLength("story_v_out_121421", "121421124", "story_v_out_121421.awb") / 1000

					if var_509_23 + var_509_15 > arg_506_1.duration_ then
						arg_506_1.duration_ = var_509_23 + var_509_15
					end

					if var_509_18.prefab_name ~= "" and arg_506_1.actors_[var_509_18.prefab_name] ~= nil then
						local var_509_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_506_1.actors_[var_509_18.prefab_name].transform, "story_v_out_121421", "121421124", "story_v_out_121421.awb")

						arg_506_1:RecordAudio("121421124", var_509_24)
						arg_506_1:RecordAudio("121421124", var_509_24)
					else
						arg_506_1:AudioAction("play", "voice", "story_v_out_121421", "121421124", "story_v_out_121421.awb")
					end

					arg_506_1:RecordHistoryTalkVoice("story_v_out_121421", "121421124", "story_v_out_121421.awb")
				end

				arg_506_1:RecordContent(arg_506_1.text_.text)
			end

			local var_509_25 = math.max(var_509_16, arg_506_1.talkMaxDuration)

			if var_509_15 <= arg_506_1.time_ and arg_506_1.time_ < var_509_15 + var_509_25 then
				arg_506_1.typewritter.percent = (arg_506_1.time_ - var_509_15) / var_509_25

				arg_506_1.typewritter:SetDirty()
			end

			if arg_506_1.time_ >= var_509_15 + var_509_25 and arg_506_1.time_ < var_509_15 + var_509_25 + arg_509_0 then
				arg_506_1.typewritter.percent = 1

				arg_506_1.typewritter:SetDirty()
				arg_506_1:ShowNextGo(true)
			end
		end

		arg_506_1.nodeConfigList_ = {
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

		arg_506_1:InitPlayNodeList()
	end,
	Play121421125 = function(arg_510_0, arg_510_1)
		arg_510_1.time_ = 0
		arg_510_1.frameCnt_ = 0
		arg_510_1.state_ = "playing"
		arg_510_1.curTalkId_ = 121421125
		arg_510_1.duration_ = 5

		SetActive(arg_510_1.tipsGo_, false)

		function arg_510_1.onSingleLineFinish_()
			arg_510_1.onSingleLineUpdate_ = nil
			arg_510_1.onSingleLineFinish_ = nil
			arg_510_1.state_ = "waiting"
			arg_510_1.auto_ = false
		end

		function arg_510_1.playNext_(arg_512_0)
			arg_510_1.onStoryFinished_()
		end

		function arg_510_1.onSingleLineUpdate_(arg_513_0)
			local var_513_0 = arg_510_1.actors_["1072ui_story"].transform
			local var_513_1 = 0

			if var_513_1 < arg_510_1.time_ and arg_510_1.time_ <= var_513_1 + arg_513_0 then
				arg_510_1.var_.moveOldPos1072ui_story = var_513_0.localPosition
			end

			local var_513_2 = 0.001

			if var_513_1 <= arg_510_1.time_ and arg_510_1.time_ < var_513_1 + var_513_2 then
				local var_513_3 = (arg_510_1.time_ - var_513_1) / var_513_2
				local var_513_4 = Vector3.New(0, 100, 0)

				var_513_0.localPosition = Vector3.Lerp(arg_510_1.var_.moveOldPos1072ui_story, var_513_4, var_513_3)

				local var_513_5 = manager.ui.mainCamera.transform.position - var_513_0.position

				var_513_0.forward = Vector3.New(var_513_5.x, var_513_5.y, var_513_5.z)

				local var_513_6 = var_513_0.localEulerAngles

				var_513_6.z = 0
				var_513_6.x = 0
				var_513_0.localEulerAngles = var_513_6
			end

			if arg_510_1.time_ >= var_513_1 + var_513_2 and arg_510_1.time_ < var_513_1 + var_513_2 + arg_513_0 then
				var_513_0.localPosition = Vector3.New(0, 100, 0)

				local var_513_7 = manager.ui.mainCamera.transform.position - var_513_0.position

				var_513_0.forward = Vector3.New(var_513_7.x, var_513_7.y, var_513_7.z)

				local var_513_8 = var_513_0.localEulerAngles

				var_513_8.z = 0
				var_513_8.x = 0
				var_513_0.localEulerAngles = var_513_8
			end

			local var_513_9 = arg_510_1.actors_["1072ui_story"]
			local var_513_10 = 0

			if var_513_10 < arg_510_1.time_ and arg_510_1.time_ <= var_513_10 + arg_513_0 and not isNil(var_513_9) and arg_510_1.var_.characterEffect1072ui_story == nil then
				arg_510_1.var_.characterEffect1072ui_story = var_513_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_513_11 = 0.200000002980232

			if var_513_10 <= arg_510_1.time_ and arg_510_1.time_ < var_513_10 + var_513_11 and not isNil(var_513_9) then
				local var_513_12 = (arg_510_1.time_ - var_513_10) / var_513_11

				if arg_510_1.var_.characterEffect1072ui_story and not isNil(var_513_9) then
					local var_513_13 = Mathf.Lerp(0, 0.5, var_513_12)

					arg_510_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_510_1.var_.characterEffect1072ui_story.fillRatio = var_513_13
				end
			end

			if arg_510_1.time_ >= var_513_10 + var_513_11 and arg_510_1.time_ < var_513_10 + var_513_11 + arg_513_0 and not isNil(var_513_9) and arg_510_1.var_.characterEffect1072ui_story then
				local var_513_14 = 0.5

				arg_510_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_510_1.var_.characterEffect1072ui_story.fillRatio = var_513_14
			end

			local var_513_15 = 0
			local var_513_16 = 0.525

			if var_513_15 < arg_510_1.time_ and arg_510_1.time_ <= var_513_15 + arg_513_0 then
				arg_510_1.talkMaxDuration = 0
				arg_510_1.dialogCg_.alpha = 1

				arg_510_1.dialog_:SetActive(true)
				SetActive(arg_510_1.leftNameGo_, false)

				arg_510_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_510_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_510_1:RecordName(arg_510_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_510_1.iconTrs_.gameObject, false)
				arg_510_1.callingController_:SetSelectedState("normal")

				local var_513_17 = arg_510_1:GetWordFromCfg(121421125)
				local var_513_18 = arg_510_1:FormatText(var_513_17.content)

				arg_510_1.text_.text = var_513_18

				LuaForUtil.ClearLinePrefixSymbol(arg_510_1.text_)

				local var_513_19 = 20
				local var_513_20 = utf8.len(var_513_18)
				local var_513_21 = var_513_19 <= 0 and var_513_16 or var_513_16 * (var_513_20 / var_513_19)

				if var_513_21 > 0 and var_513_16 < var_513_21 then
					arg_510_1.talkMaxDuration = var_513_21

					if var_513_21 + var_513_15 > arg_510_1.duration_ then
						arg_510_1.duration_ = var_513_21 + var_513_15
					end
				end

				arg_510_1.text_.text = var_513_18
				arg_510_1.typewritter.percent = 0

				arg_510_1.typewritter:SetDirty()
				arg_510_1:ShowNextGo(false)
				arg_510_1:RecordContent(arg_510_1.text_.text)
			end

			local var_513_22 = math.max(var_513_16, arg_510_1.talkMaxDuration)

			if var_513_15 <= arg_510_1.time_ and arg_510_1.time_ < var_513_15 + var_513_22 then
				arg_510_1.typewritter.percent = (arg_510_1.time_ - var_513_15) / var_513_22

				arg_510_1.typewritter:SetDirty()
			end

			if arg_510_1.time_ >= var_513_15 + var_513_22 and arg_510_1.time_ < var_513_15 + var_513_22 + arg_513_0 then
				arg_510_1.typewritter.percent = 1

				arg_510_1.typewritter:SetDirty()
				arg_510_1:ShowNextGo(true)
			end
		end

		arg_510_1.nodeConfigList_ = {
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

		arg_510_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST37",
		"TextureConfig/Background/ST29",
		"TextureConfig/Background/ST12"
	},
	voices = {
		"story_v_out_121421.awb"
	}
}
