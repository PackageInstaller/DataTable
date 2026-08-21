return {
	Play417261001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 417261001
		arg_1_1.duration_ = 12.4

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play417261002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = 7.400000000001

			if var_4_0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_0 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_1 = 0.7

			if arg_1_1.time_ >= var_4_0 + var_4_1 and arg_1_1.time_ < var_4_0 + var_4_1 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_2 = "I16f"

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
				local var_4_7 = arg_1_1.bgs_.I16f

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
					if iter_4_0 ~= "I16f" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_18 = 0
			local var_4_19 = 5
			local var_4_20 = "B13g"

			if var_4_18 < arg_1_1.time_ and arg_1_1.time_ <= var_4_18 + arg_4_0 then
				arg_1_1.timestampController_:SetSelectedState("show")
				arg_1_1.timestampAni_:Play("in")

				arg_1_1.timeTicketbgImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_20)

				arg_1_1.timestampColorController_:SetSelectedState("cold")
				arg_1_1.timeColdImg_:SetAlpha(0.031)

				local var_4_21 = arg_1_1:GetWordFromCfg(501075)
				local var_4_22 = arg_1_1:FormatText(var_4_21.content)

				arg_1_1.text_timeText_.text = var_4_22

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_timeText_)

				local var_4_23 = arg_1_1:GetWordFromCfg(501076)
				local var_4_24 = arg_1_1:FormatText(var_4_23.content)

				arg_1_1.text_siteText_.text = var_4_24

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_siteText_)
			end

			if arg_1_1.time_ >= var_4_18 + var_4_19 and arg_1_1.time_ < var_4_18 + var_4_19 + arg_4_0 then
				AnimatorTools.PlayAnimationWithCallback(arg_1_1.timestampAni_, "out", function()
					arg_1_1.timestampController_:SetSelectedState("hide")
				end)
			end

			local var_4_25 = 5

			if var_4_25 < arg_1_1.time_ and arg_1_1.time_ <= var_4_25 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = false

				arg_1_1:SetGaussion(false)
			end

			local var_4_26 = 1.2

			if var_4_25 <= arg_1_1.time_ and arg_1_1.time_ < var_4_25 + var_4_26 then
				local var_4_27 = (arg_1_1.time_ - var_4_25) / var_4_26
				local var_4_28 = Color.New(0, 0, 0)

				var_4_28.a = Mathf.Lerp(0, 1, var_4_27)
				arg_1_1.mask_.color = var_4_28
			end

			if arg_1_1.time_ >= var_4_25 + var_4_26 and arg_1_1.time_ < var_4_25 + var_4_26 + arg_4_0 then
				local var_4_29 = Color.New(0, 0, 0)

				var_4_29.a = 1
				arg_1_1.mask_.color = var_4_29
			end

			local var_4_30 = 6.2

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = false

				arg_1_1:SetGaussion(false)
			end

			local var_4_31 = 1.2

			if var_4_30 <= arg_1_1.time_ and arg_1_1.time_ < var_4_30 + var_4_31 then
				local var_4_32 = (arg_1_1.time_ - var_4_30) / var_4_31
				local var_4_33 = Color.New(0, 0, 0)

				var_4_33.a = Mathf.Lerp(1, 0, var_4_32)
				arg_1_1.mask_.color = var_4_33
			end

			if arg_1_1.time_ >= var_4_30 + var_4_31 and arg_1_1.time_ < var_4_30 + var_4_31 + arg_4_0 then
				local var_4_34 = Color.New(0, 0, 0)
				local var_4_35 = 0

				arg_1_1.mask_.enabled = false
				var_4_34.a = var_4_35
				arg_1_1.mask_.color = var_4_34
			end

			local var_4_36 = 0

			if var_4_36 < arg_1_1.time_ and arg_1_1.time_ <= var_4_36 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = false

				arg_1_1:SetGaussion(false)
			end

			local var_4_37 = 1

			if var_4_36 <= arg_1_1.time_ and arg_1_1.time_ < var_4_36 + var_4_37 then
				local var_4_38 = (arg_1_1.time_ - var_4_36) / var_4_37
				local var_4_39 = Color.New(0, 0, 0)

				var_4_39.a = Mathf.Lerp(1, 0, var_4_38)
				arg_1_1.mask_.color = var_4_39
			end

			if arg_1_1.time_ >= var_4_36 + var_4_37 and arg_1_1.time_ < var_4_36 + var_4_37 + arg_4_0 then
				local var_4_40 = Color.New(0, 0, 0)
				local var_4_41 = 0

				arg_1_1.mask_.enabled = false
				var_4_40.a = var_4_41
				arg_1_1.mask_.color = var_4_40
			end

			local var_4_42 = 0

			if var_4_42 < arg_1_1.time_ and arg_1_1.time_ <= var_4_42 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_43 = 6.2

			if arg_1_1.time_ >= var_4_42 + var_4_43 and arg_1_1.time_ < var_4_42 + var_4_43 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_44 = 0
			local var_4_45 = 0.2

			if var_4_44 < arg_1_1.time_ and arg_1_1.time_ <= var_4_44 + arg_4_0 then
				local var_4_46 = "play"
				local var_4_47 = "music"

				arg_1_1:AudioAction(var_4_46, var_4_47, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_48 = ""
				local var_4_49 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_49 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_49 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_49

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_49
						arg_1_1.bgmTxt2_.text = var_4_49
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

			local var_4_50 = 5.46666666666667
			local var_4_51 = 1

			if var_4_50 < arg_1_1.time_ and arg_1_1.time_ <= var_4_50 + arg_4_0 then
				local var_4_52 = "play"
				local var_4_53 = "music"

				arg_1_1:AudioAction(var_4_52, var_4_53, "bgm_activity_3_10_story_corg_base", "bgm_activity_3_10_story_corg_base", "bgm_activity_3_10_story_corg_base.awb")

				local var_4_54 = ""
				local var_4_55 = manager.audio:GetAudioName("bgm_activity_3_10_story_corg_base", "bgm_activity_3_10_story_corg_base")

				if var_4_55 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_55 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_55

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_55
						arg_1_1.bgmTxt2_.text = var_4_55
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

			local var_4_56 = 7.4
			local var_4_57 = 1.6

			if var_4_56 < arg_1_1.time_ and arg_1_1.time_ <= var_4_56 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_58 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_58:setOnUpdate(LuaHelper.FloatAction(function(arg_8_0)
					arg_1_1.dialogCg_.alpha = arg_8_0
				end))
				var_4_58:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_58:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_59 = arg_1_1:GetWordFromCfg(417261001)
				local var_4_60 = arg_1_1:FormatText(var_4_59.content)

				arg_1_1.text_.text = var_4_60

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_61 = 64
				local var_4_62 = utf8.len(var_4_60)
				local var_4_63 = var_4_61 <= 0 and var_4_57 or var_4_57 * (var_4_62 / var_4_61)

				if var_4_63 > 0 and var_4_57 < var_4_63 then
					arg_1_1.talkMaxDuration = var_4_63
					var_4_56 = var_4_56 + 0.3

					if var_4_63 + var_4_56 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_63 + var_4_56
					end
				end

				arg_1_1.text_.text = var_4_60
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_64 = var_4_56 + 0.3
			local var_4_65 = math.max(var_4_57, arg_1_1.talkMaxDuration)

			if var_4_64 <= arg_1_1.time_ and arg_1_1.time_ < var_4_64 + var_4_65 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_64) / var_4_65

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_64 + var_4_65 and arg_1_1.time_ < var_4_64 + var_4_65 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play417261002 = function(arg_10_0, arg_10_1)
		arg_10_1.time_ = 0
		arg_10_1.frameCnt_ = 0
		arg_10_1.state_ = "playing"
		arg_10_1.curTalkId_ = 417261002
		arg_10_1.duration_ = 5

		SetActive(arg_10_1.tipsGo_, false)

		function arg_10_1.onSingleLineFinish_()
			arg_10_1.onSingleLineUpdate_ = nil
			arg_10_1.onSingleLineFinish_ = nil
			arg_10_1.state_ = "waiting"
		end

		function arg_10_1.playNext_(arg_12_0)
			if arg_12_0 == 1 then
				arg_10_0:Play417261003(arg_10_1)
			end
		end

		function arg_10_1.onSingleLineUpdate_(arg_13_0)
			local var_13_0 = 0.02
			local var_13_1 = 1

			if var_13_0 < arg_10_1.time_ and arg_10_1.time_ <= var_13_0 + arg_13_0 then
				local var_13_2 = "play"
				local var_13_3 = "effect"

				arg_10_1:AudioAction(var_13_2, var_13_3, "se_story_side_1148", "se_story_1148_applause", "")
			end

			local var_13_4 = 0
			local var_13_5 = 1.85

			if var_13_4 < arg_10_1.time_ and arg_10_1.time_ <= var_13_4 + arg_13_0 then
				arg_10_1.talkMaxDuration = 0
				arg_10_1.dialogCg_.alpha = 1

				arg_10_1.dialog_:SetActive(true)
				SetActive(arg_10_1.leftNameGo_, false)

				arg_10_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_10_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_10_1:RecordName(arg_10_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_10_1.iconTrs_.gameObject, false)
				arg_10_1.callingController_:SetSelectedState("normal")

				local var_13_6 = arg_10_1:GetWordFromCfg(417261002)
				local var_13_7 = arg_10_1:FormatText(var_13_6.content)

				arg_10_1.text_.text = var_13_7

				LuaForUtil.ClearLinePrefixSymbol(arg_10_1.text_)

				local var_13_8 = 74
				local var_13_9 = utf8.len(var_13_7)
				local var_13_10 = var_13_8 <= 0 and var_13_5 or var_13_5 * (var_13_9 / var_13_8)

				if var_13_10 > 0 and var_13_5 < var_13_10 then
					arg_10_1.talkMaxDuration = var_13_10

					if var_13_10 + var_13_4 > arg_10_1.duration_ then
						arg_10_1.duration_ = var_13_10 + var_13_4
					end
				end

				arg_10_1.text_.text = var_13_7
				arg_10_1.typewritter.percent = 0

				arg_10_1.typewritter:SetDirty()
				arg_10_1:ShowNextGo(false)
				arg_10_1:RecordContent(arg_10_1.text_.text)
			end

			local var_13_11 = math.max(var_13_5, arg_10_1.talkMaxDuration)

			if var_13_4 <= arg_10_1.time_ and arg_10_1.time_ < var_13_4 + var_13_11 then
				arg_10_1.typewritter.percent = (arg_10_1.time_ - var_13_4) / var_13_11

				arg_10_1.typewritter:SetDirty()
			end

			if arg_10_1.time_ >= var_13_4 + var_13_11 and arg_10_1.time_ < var_13_4 + var_13_11 + arg_13_0 then
				arg_10_1.typewritter.percent = 1

				arg_10_1.typewritter:SetDirty()
				arg_10_1:ShowNextGo(true)
			end
		end

		arg_10_1.nodeConfigList_ = {}

		arg_10_1:InitPlayNodeList()
	end,
	Play417261003 = function(arg_14_0, arg_14_1)
		arg_14_1.time_ = 0
		arg_14_1.frameCnt_ = 0
		arg_14_1.state_ = "playing"
		arg_14_1.curTalkId_ = 417261003
		arg_14_1.duration_ = 5

		SetActive(arg_14_1.tipsGo_, false)

		function arg_14_1.onSingleLineFinish_()
			arg_14_1.onSingleLineUpdate_ = nil
			arg_14_1.onSingleLineFinish_ = nil
			arg_14_1.state_ = "waiting"
		end

		function arg_14_1.playNext_(arg_16_0)
			if arg_16_0 == 1 then
				arg_14_0:Play417261004(arg_14_1)
			end
		end

		function arg_14_1.onSingleLineUpdate_(arg_17_0)
			local var_17_0 = 0
			local var_17_1 = 1.6

			if var_17_0 < arg_14_1.time_ and arg_14_1.time_ <= var_17_0 + arg_17_0 then
				arg_14_1.talkMaxDuration = 0
				arg_14_1.dialogCg_.alpha = 1

				arg_14_1.dialog_:SetActive(true)
				SetActive(arg_14_1.leftNameGo_, false)

				arg_14_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_14_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_14_1:RecordName(arg_14_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_14_1.iconTrs_.gameObject, false)
				arg_14_1.callingController_:SetSelectedState("normal")

				local var_17_2 = arg_14_1:GetWordFromCfg(417261003)
				local var_17_3 = arg_14_1:FormatText(var_17_2.content)

				arg_14_1.text_.text = var_17_3

				LuaForUtil.ClearLinePrefixSymbol(arg_14_1.text_)

				local var_17_4 = 64
				local var_17_5 = utf8.len(var_17_3)
				local var_17_6 = var_17_4 <= 0 and var_17_1 or var_17_1 * (var_17_5 / var_17_4)

				if var_17_6 > 0 and var_17_1 < var_17_6 then
					arg_14_1.talkMaxDuration = var_17_6

					if var_17_6 + var_17_0 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_6 + var_17_0
					end
				end

				arg_14_1.text_.text = var_17_3
				arg_14_1.typewritter.percent = 0

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(false)
				arg_14_1:RecordContent(arg_14_1.text_.text)
			end

			local var_17_7 = math.max(var_17_1, arg_14_1.talkMaxDuration)

			if var_17_0 <= arg_14_1.time_ and arg_14_1.time_ < var_17_0 + var_17_7 then
				arg_14_1.typewritter.percent = (arg_14_1.time_ - var_17_0) / var_17_7

				arg_14_1.typewritter:SetDirty()
			end

			if arg_14_1.time_ >= var_17_0 + var_17_7 and arg_14_1.time_ < var_17_0 + var_17_7 + arg_17_0 then
				arg_14_1.typewritter.percent = 1

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(true)
			end
		end

		arg_14_1.nodeConfigList_ = {}

		arg_14_1:InitPlayNodeList()
	end,
	Play417261004 = function(arg_18_0, arg_18_1)
		arg_18_1.time_ = 0
		arg_18_1.frameCnt_ = 0
		arg_18_1.state_ = "playing"
		arg_18_1.curTalkId_ = 417261004
		arg_18_1.duration_ = 4.33

		local var_18_0 = {
			zh = 3.2,
			ja = 4.333
		}
		local var_18_1 = manager.audio:GetLocalizationFlag()

		if var_18_0[var_18_1] ~= nil then
			arg_18_1.duration_ = var_18_0[var_18_1]
		end

		SetActive(arg_18_1.tipsGo_, false)

		function arg_18_1.onSingleLineFinish_()
			arg_18_1.onSingleLineUpdate_ = nil
			arg_18_1.onSingleLineFinish_ = nil
			arg_18_1.state_ = "waiting"
		end

		function arg_18_1.playNext_(arg_20_0)
			if arg_20_0 == 1 then
				arg_18_0:Play417261005(arg_18_1)
			end
		end

		function arg_18_1.onSingleLineUpdate_(arg_21_0)
			local var_21_0 = 0
			local var_21_1 = 0.3

			if var_21_0 < arg_18_1.time_ and arg_18_1.time_ <= var_21_0 + arg_21_0 then
				arg_18_1.talkMaxDuration = 0
				arg_18_1.dialogCg_.alpha = 1

				arg_18_1.dialog_:SetActive(true)
				SetActive(arg_18_1.leftNameGo_, true)

				local var_21_2 = arg_18_1:FormatText(StoryNameCfg[468].name)

				arg_18_1.leftNameTxt_.text = var_21_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_18_1.leftNameTxt_.transform)

				arg_18_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_18_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_18_1:RecordName(arg_18_1.leftNameTxt_.text)
				SetActive(arg_18_1.iconTrs_.gameObject, true)
				arg_18_1.iconController_:SetSelectedState("hero")

				arg_18_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10049")

				arg_18_1.callingController_:SetSelectedState("normal")

				arg_18_1.keyicon_.color = Color.New(1, 1, 1)
				arg_18_1.icon_.color = Color.New(1, 1, 1)

				local var_21_3 = arg_18_1:GetWordFromCfg(417261004)
				local var_21_4 = arg_18_1:FormatText(var_21_3.content)

				arg_18_1.text_.text = var_21_4

				LuaForUtil.ClearLinePrefixSymbol(arg_18_1.text_)

				local var_21_5 = 12
				local var_21_6 = utf8.len(var_21_4)
				local var_21_7 = var_21_5 <= 0 and var_21_1 or var_21_1 * (var_21_6 / var_21_5)

				if var_21_7 > 0 and var_21_1 < var_21_7 then
					arg_18_1.talkMaxDuration = var_21_7

					if var_21_7 + var_21_0 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_7 + var_21_0
					end
				end

				arg_18_1.text_.text = var_21_4
				arg_18_1.typewritter.percent = 0

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417261", "417261004", "story_v_out_417261.awb") ~= 0 then
					local var_21_8 = manager.audio:GetVoiceLength("story_v_out_417261", "417261004", "story_v_out_417261.awb") / 1000

					if var_21_8 + var_21_0 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_8 + var_21_0
					end

					if var_21_3.prefab_name ~= "" and arg_18_1.actors_[var_21_3.prefab_name] ~= nil then
						local var_21_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_18_1.actors_[var_21_3.prefab_name].transform, "story_v_out_417261", "417261004", "story_v_out_417261.awb")

						arg_18_1:RecordAudio("417261004", var_21_9)
						arg_18_1:RecordAudio("417261004", var_21_9)
					else
						arg_18_1:AudioAction("play", "voice", "story_v_out_417261", "417261004", "story_v_out_417261.awb")
					end

					arg_18_1:RecordHistoryTalkVoice("story_v_out_417261", "417261004", "story_v_out_417261.awb")
				end

				arg_18_1:RecordContent(arg_18_1.text_.text)
			end

			local var_21_10 = math.max(var_21_1, arg_18_1.talkMaxDuration)

			if var_21_0 <= arg_18_1.time_ and arg_18_1.time_ < var_21_0 + var_21_10 then
				arg_18_1.typewritter.percent = (arg_18_1.time_ - var_21_0) / var_21_10

				arg_18_1.typewritter:SetDirty()
			end

			if arg_18_1.time_ >= var_21_0 + var_21_10 and arg_18_1.time_ < var_21_0 + var_21_10 + arg_21_0 then
				arg_18_1.typewritter.percent = 1

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(true)
			end
		end

		arg_18_1.nodeConfigList_ = {}

		arg_18_1:InitPlayNodeList()
	end,
	Play417261005 = function(arg_22_0, arg_22_1)
		arg_22_1.time_ = 0
		arg_22_1.frameCnt_ = 0
		arg_22_1.state_ = "playing"
		arg_22_1.curTalkId_ = 417261005
		arg_22_1.duration_ = 7.2

		local var_22_0 = {
			zh = 7.2,
			ja = 6.533
		}
		local var_22_1 = manager.audio:GetLocalizationFlag()

		if var_22_0[var_22_1] ~= nil then
			arg_22_1.duration_ = var_22_0[var_22_1]
		end

		SetActive(arg_22_1.tipsGo_, false)

		function arg_22_1.onSingleLineFinish_()
			arg_22_1.onSingleLineUpdate_ = nil
			arg_22_1.onSingleLineFinish_ = nil
			arg_22_1.state_ = "waiting"
		end

		function arg_22_1.playNext_(arg_24_0)
			if arg_24_0 == 1 then
				arg_22_0:Play417261006(arg_22_1)
			end
		end

		function arg_22_1.onSingleLineUpdate_(arg_25_0)
			local var_25_0 = "1034"

			if arg_22_1.actors_[var_25_0] == nil then
				local var_25_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1034")

				if not isNil(var_25_1) then
					local var_25_2 = Object.Instantiate(var_25_1, arg_22_1.canvasGo_.transform)

					var_25_2.transform:SetSiblingIndex(1)

					var_25_2.name = var_25_0
					var_25_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_22_1.actors_[var_25_0] = var_25_2

					local var_25_3 = var_25_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_22_1.isInRecall_ then
						for iter_25_0, iter_25_1 in ipairs(var_25_3) do
							iter_25_1.color = arg_22_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_25_4 = arg_22_1.actors_["1034"]
			local var_25_5 = 0

			if var_25_5 < arg_22_1.time_ and arg_22_1.time_ <= var_25_5 + arg_25_0 and not isNil(var_25_4) and arg_22_1.var_.actorSpriteComps1034 == nil then
				arg_22_1.var_.actorSpriteComps1034 = var_25_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_25_6 = 0.2

			if var_25_5 <= arg_22_1.time_ and arg_22_1.time_ < var_25_5 + var_25_6 and not isNil(var_25_4) then
				local var_25_7 = (arg_22_1.time_ - var_25_5) / var_25_6

				if arg_22_1.var_.actorSpriteComps1034 then
					for iter_25_2, iter_25_3 in pairs(arg_22_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_25_3 then
							if arg_22_1.isInRecall_ then
								local var_25_8 = Mathf.Lerp(iter_25_3.color.r, arg_22_1.hightColor1.r, var_25_7)
								local var_25_9 = Mathf.Lerp(iter_25_3.color.g, arg_22_1.hightColor1.g, var_25_7)
								local var_25_10 = Mathf.Lerp(iter_25_3.color.b, arg_22_1.hightColor1.b, var_25_7)

								iter_25_3.color = Color.New(var_25_8, var_25_9, var_25_10)
							else
								local var_25_11 = Mathf.Lerp(iter_25_3.color.r, 1, var_25_7)

								iter_25_3.color = Color.New(var_25_11, var_25_11, var_25_11)
							end
						end
					end
				end
			end

			if arg_22_1.time_ >= var_25_5 + var_25_6 and arg_22_1.time_ < var_25_5 + var_25_6 + arg_25_0 and not isNil(var_25_4) and arg_22_1.var_.actorSpriteComps1034 then
				for iter_25_4, iter_25_5 in pairs(arg_22_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_25_5 then
						if arg_22_1.isInRecall_ then
							iter_25_5.color = arg_22_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_25_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_22_1.var_.actorSpriteComps1034 = nil
			end

			local var_25_12 = arg_22_1.actors_["1034"].transform
			local var_25_13 = 0

			if var_25_13 < arg_22_1.time_ and arg_22_1.time_ <= var_25_13 + arg_25_0 then
				arg_22_1.var_.moveOldPos1034 = var_25_12.localPosition
				var_25_12.localScale = Vector3.New(1, 1, 1)

				arg_22_1:CheckSpriteTmpPos("1034", 3)

				local var_25_14 = var_25_12.childCount

				for iter_25_6 = 0, var_25_14 - 1 do
					local var_25_15 = var_25_12:GetChild(iter_25_6)

					if var_25_15.name == "split_4" or not string.find(var_25_15.name, "split") then
						var_25_15.gameObject:SetActive(true)
					else
						var_25_15.gameObject:SetActive(false)
					end
				end
			end

			local var_25_16 = 0.001

			if var_25_13 <= arg_22_1.time_ and arg_22_1.time_ < var_25_13 + var_25_16 then
				local var_25_17 = (arg_22_1.time_ - var_25_13) / var_25_16
				local var_25_18 = Vector3.New(0, -331.9, -324)

				var_25_12.localPosition = Vector3.Lerp(arg_22_1.var_.moveOldPos1034, var_25_18, var_25_17)
			end

			if arg_22_1.time_ >= var_25_13 + var_25_16 and arg_22_1.time_ < var_25_13 + var_25_16 + arg_25_0 then
				var_25_12.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_25_19 = 0
			local var_25_20 = 0.775

			if var_25_19 < arg_22_1.time_ and arg_22_1.time_ <= var_25_19 + arg_25_0 then
				arg_22_1.talkMaxDuration = 0
				arg_22_1.dialogCg_.alpha = 1

				arg_22_1.dialog_:SetActive(true)
				SetActive(arg_22_1.leftNameGo_, true)

				local var_25_21 = arg_22_1:FormatText(StoryNameCfg[1109].name)

				arg_22_1.leftNameTxt_.text = var_25_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_22_1.leftNameTxt_.transform)

				arg_22_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_22_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_22_1:RecordName(arg_22_1.leftNameTxt_.text)
				SetActive(arg_22_1.iconTrs_.gameObject, false)
				arg_22_1.callingController_:SetSelectedState("normal")

				local var_25_22 = arg_22_1:GetWordFromCfg(417261005)
				local var_25_23 = arg_22_1:FormatText(var_25_22.content)

				arg_22_1.text_.text = var_25_23

				LuaForUtil.ClearLinePrefixSymbol(arg_22_1.text_)

				local var_25_24 = 31
				local var_25_25 = utf8.len(var_25_23)
				local var_25_26 = var_25_24 <= 0 and var_25_20 or var_25_20 * (var_25_25 / var_25_24)

				if var_25_26 > 0 and var_25_20 < var_25_26 then
					arg_22_1.talkMaxDuration = var_25_26

					if var_25_26 + var_25_19 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_26 + var_25_19
					end
				end

				arg_22_1.text_.text = var_25_23
				arg_22_1.typewritter.percent = 0

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417261", "417261005", "story_v_out_417261.awb") ~= 0 then
					local var_25_27 = manager.audio:GetVoiceLength("story_v_out_417261", "417261005", "story_v_out_417261.awb") / 1000

					if var_25_27 + var_25_19 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_27 + var_25_19
					end

					if var_25_22.prefab_name ~= "" and arg_22_1.actors_[var_25_22.prefab_name] ~= nil then
						local var_25_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_22_1.actors_[var_25_22.prefab_name].transform, "story_v_out_417261", "417261005", "story_v_out_417261.awb")

						arg_22_1:RecordAudio("417261005", var_25_28)
						arg_22_1:RecordAudio("417261005", var_25_28)
					else
						arg_22_1:AudioAction("play", "voice", "story_v_out_417261", "417261005", "story_v_out_417261.awb")
					end

					arg_22_1:RecordHistoryTalkVoice("story_v_out_417261", "417261005", "story_v_out_417261.awb")
				end

				arg_22_1:RecordContent(arg_22_1.text_.text)
			end

			local var_25_29 = math.max(var_25_20, arg_22_1.talkMaxDuration)

			if var_25_19 <= arg_22_1.time_ and arg_22_1.time_ < var_25_19 + var_25_29 then
				arg_22_1.typewritter.percent = (arg_22_1.time_ - var_25_19) / var_25_29

				arg_22_1.typewritter:SetDirty()
			end

			if arg_22_1.time_ >= var_25_19 + var_25_29 and arg_22_1.time_ < var_25_19 + var_25_29 + arg_25_0 then
				arg_22_1.typewritter.percent = 1

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(true)
			end
		end

		arg_22_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_22_1:InitPlayNodeList()
	end,
	Play417261006 = function(arg_26_0, arg_26_1)
		arg_26_1.time_ = 0
		arg_26_1.frameCnt_ = 0
		arg_26_1.state_ = "playing"
		arg_26_1.curTalkId_ = 417261006
		arg_26_1.duration_ = 10.1

		local var_26_0 = {
			zh = 8.566,
			ja = 10.1
		}
		local var_26_1 = manager.audio:GetLocalizationFlag()

		if var_26_0[var_26_1] ~= nil then
			arg_26_1.duration_ = var_26_0[var_26_1]
		end

		SetActive(arg_26_1.tipsGo_, false)

		function arg_26_1.onSingleLineFinish_()
			arg_26_1.onSingleLineUpdate_ = nil
			arg_26_1.onSingleLineFinish_ = nil
			arg_26_1.state_ = "waiting"
		end

		function arg_26_1.playNext_(arg_28_0)
			if arg_28_0 == 1 then
				arg_26_0:Play417261007(arg_26_1)
			end
		end

		function arg_26_1.onSingleLineUpdate_(arg_29_0)
			local var_29_0 = 0
			local var_29_1 = 0.975

			if var_29_0 < arg_26_1.time_ and arg_26_1.time_ <= var_29_0 + arg_29_0 then
				arg_26_1.talkMaxDuration = 0
				arg_26_1.dialogCg_.alpha = 1

				arg_26_1.dialog_:SetActive(true)
				SetActive(arg_26_1.leftNameGo_, true)

				local var_29_2 = arg_26_1:FormatText(StoryNameCfg[1109].name)

				arg_26_1.leftNameTxt_.text = var_29_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_26_1.leftNameTxt_.transform)

				arg_26_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_26_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_26_1:RecordName(arg_26_1.leftNameTxt_.text)
				SetActive(arg_26_1.iconTrs_.gameObject, false)
				arg_26_1.callingController_:SetSelectedState("normal")

				local var_29_3 = arg_26_1:GetWordFromCfg(417261006)
				local var_29_4 = arg_26_1:FormatText(var_29_3.content)

				arg_26_1.text_.text = var_29_4

				LuaForUtil.ClearLinePrefixSymbol(arg_26_1.text_)

				local var_29_5 = 39
				local var_29_6 = utf8.len(var_29_4)
				local var_29_7 = var_29_5 <= 0 and var_29_1 or var_29_1 * (var_29_6 / var_29_5)

				if var_29_7 > 0 and var_29_1 < var_29_7 then
					arg_26_1.talkMaxDuration = var_29_7

					if var_29_7 + var_29_0 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_7 + var_29_0
					end
				end

				arg_26_1.text_.text = var_29_4
				arg_26_1.typewritter.percent = 0

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417261", "417261006", "story_v_out_417261.awb") ~= 0 then
					local var_29_8 = manager.audio:GetVoiceLength("story_v_out_417261", "417261006", "story_v_out_417261.awb") / 1000

					if var_29_8 + var_29_0 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_8 + var_29_0
					end

					if var_29_3.prefab_name ~= "" and arg_26_1.actors_[var_29_3.prefab_name] ~= nil then
						local var_29_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_26_1.actors_[var_29_3.prefab_name].transform, "story_v_out_417261", "417261006", "story_v_out_417261.awb")

						arg_26_1:RecordAudio("417261006", var_29_9)
						arg_26_1:RecordAudio("417261006", var_29_9)
					else
						arg_26_1:AudioAction("play", "voice", "story_v_out_417261", "417261006", "story_v_out_417261.awb")
					end

					arg_26_1:RecordHistoryTalkVoice("story_v_out_417261", "417261006", "story_v_out_417261.awb")
				end

				arg_26_1:RecordContent(arg_26_1.text_.text)
			end

			local var_29_10 = math.max(var_29_1, arg_26_1.talkMaxDuration)

			if var_29_0 <= arg_26_1.time_ and arg_26_1.time_ < var_29_0 + var_29_10 then
				arg_26_1.typewritter.percent = (arg_26_1.time_ - var_29_0) / var_29_10

				arg_26_1.typewritter:SetDirty()
			end

			if arg_26_1.time_ >= var_29_0 + var_29_10 and arg_26_1.time_ < var_29_0 + var_29_10 + arg_29_0 then
				arg_26_1.typewritter.percent = 1

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(true)
			end
		end

		arg_26_1.nodeConfigList_ = {}

		arg_26_1:InitPlayNodeList()
	end,
	Play417261007 = function(arg_30_0, arg_30_1)
		arg_30_1.time_ = 0
		arg_30_1.frameCnt_ = 0
		arg_30_1.state_ = "playing"
		arg_30_1.curTalkId_ = 417261007
		arg_30_1.duration_ = 7.23

		local var_30_0 = {
			zh = 5.633,
			ja = 7.233
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
				arg_30_0:Play417261008(arg_30_1)
			end
		end

		function arg_30_1.onSingleLineUpdate_(arg_33_0)
			local var_33_0 = arg_30_1.actors_["1034"]
			local var_33_1 = 0

			if var_33_1 < arg_30_1.time_ and arg_30_1.time_ <= var_33_1 + arg_33_0 and not isNil(var_33_0) and arg_30_1.var_.actorSpriteComps1034 == nil then
				arg_30_1.var_.actorSpriteComps1034 = var_33_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_33_2 = 0.2

			if var_33_1 <= arg_30_1.time_ and arg_30_1.time_ < var_33_1 + var_33_2 and not isNil(var_33_0) then
				local var_33_3 = (arg_30_1.time_ - var_33_1) / var_33_2

				if arg_30_1.var_.actorSpriteComps1034 then
					for iter_33_0, iter_33_1 in pairs(arg_30_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_33_1 then
							if arg_30_1.isInRecall_ then
								local var_33_4 = Mathf.Lerp(iter_33_1.color.r, arg_30_1.hightColor2.r, var_33_3)
								local var_33_5 = Mathf.Lerp(iter_33_1.color.g, arg_30_1.hightColor2.g, var_33_3)
								local var_33_6 = Mathf.Lerp(iter_33_1.color.b, arg_30_1.hightColor2.b, var_33_3)

								iter_33_1.color = Color.New(var_33_4, var_33_5, var_33_6)
							else
								local var_33_7 = Mathf.Lerp(iter_33_1.color.r, 0.5, var_33_3)

								iter_33_1.color = Color.New(var_33_7, var_33_7, var_33_7)
							end
						end
					end
				end
			end

			if arg_30_1.time_ >= var_33_1 + var_33_2 and arg_30_1.time_ < var_33_1 + var_33_2 + arg_33_0 and not isNil(var_33_0) and arg_30_1.var_.actorSpriteComps1034 then
				for iter_33_2, iter_33_3 in pairs(arg_30_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_33_3 then
						if arg_30_1.isInRecall_ then
							iter_33_3.color = arg_30_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_33_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_30_1.var_.actorSpriteComps1034 = nil
			end

			local var_33_8 = 0
			local var_33_9 = 0.55

			if var_33_8 < arg_30_1.time_ and arg_30_1.time_ <= var_33_8 + arg_33_0 then
				arg_30_1.talkMaxDuration = 0
				arg_30_1.dialogCg_.alpha = 1

				arg_30_1.dialog_:SetActive(true)
				SetActive(arg_30_1.leftNameGo_, true)

				local var_33_10 = arg_30_1:FormatText(StoryNameCfg[468].name)

				arg_30_1.leftNameTxt_.text = var_33_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_30_1.leftNameTxt_.transform)

				arg_30_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_30_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_30_1:RecordName(arg_30_1.leftNameTxt_.text)
				SetActive(arg_30_1.iconTrs_.gameObject, true)
				arg_30_1.iconController_:SetSelectedState("hero")

				arg_30_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10049")

				arg_30_1.callingController_:SetSelectedState("normal")

				arg_30_1.keyicon_.color = Color.New(1, 1, 1)
				arg_30_1.icon_.color = Color.New(1, 1, 1)

				local var_33_11 = arg_30_1:GetWordFromCfg(417261007)
				local var_33_12 = arg_30_1:FormatText(var_33_11.content)

				arg_30_1.text_.text = var_33_12

				LuaForUtil.ClearLinePrefixSymbol(arg_30_1.text_)

				local var_33_13 = 22
				local var_33_14 = utf8.len(var_33_12)
				local var_33_15 = var_33_13 <= 0 and var_33_9 or var_33_9 * (var_33_14 / var_33_13)

				if var_33_15 > 0 and var_33_9 < var_33_15 then
					arg_30_1.talkMaxDuration = var_33_15

					if var_33_15 + var_33_8 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_15 + var_33_8
					end
				end

				arg_30_1.text_.text = var_33_12
				arg_30_1.typewritter.percent = 0

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417261", "417261007", "story_v_out_417261.awb") ~= 0 then
					local var_33_16 = manager.audio:GetVoiceLength("story_v_out_417261", "417261007", "story_v_out_417261.awb") / 1000

					if var_33_16 + var_33_8 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_16 + var_33_8
					end

					if var_33_11.prefab_name ~= "" and arg_30_1.actors_[var_33_11.prefab_name] ~= nil then
						local var_33_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_30_1.actors_[var_33_11.prefab_name].transform, "story_v_out_417261", "417261007", "story_v_out_417261.awb")

						arg_30_1:RecordAudio("417261007", var_33_17)
						arg_30_1:RecordAudio("417261007", var_33_17)
					else
						arg_30_1:AudioAction("play", "voice", "story_v_out_417261", "417261007", "story_v_out_417261.awb")
					end

					arg_30_1:RecordHistoryTalkVoice("story_v_out_417261", "417261007", "story_v_out_417261.awb")
				end

				arg_30_1:RecordContent(arg_30_1.text_.text)
			end

			local var_33_18 = math.max(var_33_9, arg_30_1.talkMaxDuration)

			if var_33_8 <= arg_30_1.time_ and arg_30_1.time_ < var_33_8 + var_33_18 then
				arg_30_1.typewritter.percent = (arg_30_1.time_ - var_33_8) / var_33_18

				arg_30_1.typewritter:SetDirty()
			end

			if arg_30_1.time_ >= var_33_8 + var_33_18 and arg_30_1.time_ < var_33_8 + var_33_18 + arg_33_0 then
				arg_30_1.typewritter.percent = 1

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(true)
			end
		end

		arg_30_1.nodeConfigList_ = {}

		arg_30_1:InitPlayNodeList()
	end,
	Play417261008 = function(arg_34_0, arg_34_1)
		arg_34_1.time_ = 0
		arg_34_1.frameCnt_ = 0
		arg_34_1.state_ = "playing"
		arg_34_1.curTalkId_ = 417261008
		arg_34_1.duration_ = 6.6

		local var_34_0 = {
			zh = 5.4,
			ja = 6.6
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
				arg_34_0:Play417261009(arg_34_1)
			end
		end

		function arg_34_1.onSingleLineUpdate_(arg_37_0)
			local var_37_0 = 0
			local var_37_1 = 0.5

			if var_37_0 < arg_34_1.time_ and arg_34_1.time_ <= var_37_0 + arg_37_0 then
				arg_34_1.talkMaxDuration = 0
				arg_34_1.dialogCg_.alpha = 1

				arg_34_1.dialog_:SetActive(true)
				SetActive(arg_34_1.leftNameGo_, true)

				local var_37_2 = arg_34_1:FormatText(StoryNameCfg[468].name)

				arg_34_1.leftNameTxt_.text = var_37_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_34_1.leftNameTxt_.transform)

				arg_34_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_34_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_34_1:RecordName(arg_34_1.leftNameTxt_.text)
				SetActive(arg_34_1.iconTrs_.gameObject, true)
				arg_34_1.iconController_:SetSelectedState("hero")

				arg_34_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10049")

				arg_34_1.callingController_:SetSelectedState("normal")

				arg_34_1.keyicon_.color = Color.New(1, 1, 1)
				arg_34_1.icon_.color = Color.New(1, 1, 1)

				local var_37_3 = arg_34_1:GetWordFromCfg(417261008)
				local var_37_4 = arg_34_1:FormatText(var_37_3.content)

				arg_34_1.text_.text = var_37_4

				LuaForUtil.ClearLinePrefixSymbol(arg_34_1.text_)

				local var_37_5 = 20
				local var_37_6 = utf8.len(var_37_4)
				local var_37_7 = var_37_5 <= 0 and var_37_1 or var_37_1 * (var_37_6 / var_37_5)

				if var_37_7 > 0 and var_37_1 < var_37_7 then
					arg_34_1.talkMaxDuration = var_37_7

					if var_37_7 + var_37_0 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_7 + var_37_0
					end
				end

				arg_34_1.text_.text = var_37_4
				arg_34_1.typewritter.percent = 0

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417261", "417261008", "story_v_out_417261.awb") ~= 0 then
					local var_37_8 = manager.audio:GetVoiceLength("story_v_out_417261", "417261008", "story_v_out_417261.awb") / 1000

					if var_37_8 + var_37_0 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_8 + var_37_0
					end

					if var_37_3.prefab_name ~= "" and arg_34_1.actors_[var_37_3.prefab_name] ~= nil then
						local var_37_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_34_1.actors_[var_37_3.prefab_name].transform, "story_v_out_417261", "417261008", "story_v_out_417261.awb")

						arg_34_1:RecordAudio("417261008", var_37_9)
						arg_34_1:RecordAudio("417261008", var_37_9)
					else
						arg_34_1:AudioAction("play", "voice", "story_v_out_417261", "417261008", "story_v_out_417261.awb")
					end

					arg_34_1:RecordHistoryTalkVoice("story_v_out_417261", "417261008", "story_v_out_417261.awb")
				end

				arg_34_1:RecordContent(arg_34_1.text_.text)
			end

			local var_37_10 = math.max(var_37_1, arg_34_1.talkMaxDuration)

			if var_37_0 <= arg_34_1.time_ and arg_34_1.time_ < var_37_0 + var_37_10 then
				arg_34_1.typewritter.percent = (arg_34_1.time_ - var_37_0) / var_37_10

				arg_34_1.typewritter:SetDirty()
			end

			if arg_34_1.time_ >= var_37_0 + var_37_10 and arg_34_1.time_ < var_37_0 + var_37_10 + arg_37_0 then
				arg_34_1.typewritter.percent = 1

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(true)
			end
		end

		arg_34_1.nodeConfigList_ = {}

		arg_34_1:InitPlayNodeList()
	end,
	Play417261009 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 417261009
		arg_38_1.duration_ = 5.03

		local var_38_0 = {
			zh = 2.766,
			ja = 5.033
		}
		local var_38_1 = manager.audio:GetLocalizationFlag()

		if var_38_0[var_38_1] ~= nil then
			arg_38_1.duration_ = var_38_0[var_38_1]
		end

		SetActive(arg_38_1.tipsGo_, false)

		function arg_38_1.onSingleLineFinish_()
			arg_38_1.onSingleLineUpdate_ = nil
			arg_38_1.onSingleLineFinish_ = nil
			arg_38_1.state_ = "waiting"
		end

		function arg_38_1.playNext_(arg_40_0)
			if arg_40_0 == 1 then
				arg_38_0:Play417261010(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			local var_41_0 = arg_38_1.actors_["1034"]
			local var_41_1 = 0

			if var_41_1 < arg_38_1.time_ and arg_38_1.time_ <= var_41_1 + arg_41_0 and not isNil(var_41_0) and arg_38_1.var_.actorSpriteComps1034 == nil then
				arg_38_1.var_.actorSpriteComps1034 = var_41_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_41_2 = 0.2

			if var_41_1 <= arg_38_1.time_ and arg_38_1.time_ < var_41_1 + var_41_2 and not isNil(var_41_0) then
				local var_41_3 = (arg_38_1.time_ - var_41_1) / var_41_2

				if arg_38_1.var_.actorSpriteComps1034 then
					for iter_41_0, iter_41_1 in pairs(arg_38_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_41_1 then
							if arg_38_1.isInRecall_ then
								local var_41_4 = Mathf.Lerp(iter_41_1.color.r, arg_38_1.hightColor1.r, var_41_3)
								local var_41_5 = Mathf.Lerp(iter_41_1.color.g, arg_38_1.hightColor1.g, var_41_3)
								local var_41_6 = Mathf.Lerp(iter_41_1.color.b, arg_38_1.hightColor1.b, var_41_3)

								iter_41_1.color = Color.New(var_41_4, var_41_5, var_41_6)
							else
								local var_41_7 = Mathf.Lerp(iter_41_1.color.r, 1, var_41_3)

								iter_41_1.color = Color.New(var_41_7, var_41_7, var_41_7)
							end
						end
					end
				end
			end

			if arg_38_1.time_ >= var_41_1 + var_41_2 and arg_38_1.time_ < var_41_1 + var_41_2 + arg_41_0 and not isNil(var_41_0) and arg_38_1.var_.actorSpriteComps1034 then
				for iter_41_2, iter_41_3 in pairs(arg_38_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_41_3 then
						if arg_38_1.isInRecall_ then
							iter_41_3.color = arg_38_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_41_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_38_1.var_.actorSpriteComps1034 = nil
			end

			local var_41_8 = 0
			local var_41_9 = 0.325

			if var_41_8 < arg_38_1.time_ and arg_38_1.time_ <= var_41_8 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0
				arg_38_1.dialogCg_.alpha = 1

				arg_38_1.dialog_:SetActive(true)
				SetActive(arg_38_1.leftNameGo_, true)

				local var_41_10 = arg_38_1:FormatText(StoryNameCfg[1109].name)

				arg_38_1.leftNameTxt_.text = var_41_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_38_1.leftNameTxt_.transform)

				arg_38_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_38_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_38_1:RecordName(arg_38_1.leftNameTxt_.text)
				SetActive(arg_38_1.iconTrs_.gameObject, false)
				arg_38_1.callingController_:SetSelectedState("normal")

				local var_41_11 = arg_38_1:GetWordFromCfg(417261009)
				local var_41_12 = arg_38_1:FormatText(var_41_11.content)

				arg_38_1.text_.text = var_41_12

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_13 = 13
				local var_41_14 = utf8.len(var_41_12)
				local var_41_15 = var_41_13 <= 0 and var_41_9 or var_41_9 * (var_41_14 / var_41_13)

				if var_41_15 > 0 and var_41_9 < var_41_15 then
					arg_38_1.talkMaxDuration = var_41_15

					if var_41_15 + var_41_8 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_15 + var_41_8
					end
				end

				arg_38_1.text_.text = var_41_12
				arg_38_1.typewritter.percent = 0

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417261", "417261009", "story_v_out_417261.awb") ~= 0 then
					local var_41_16 = manager.audio:GetVoiceLength("story_v_out_417261", "417261009", "story_v_out_417261.awb") / 1000

					if var_41_16 + var_41_8 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_16 + var_41_8
					end

					if var_41_11.prefab_name ~= "" and arg_38_1.actors_[var_41_11.prefab_name] ~= nil then
						local var_41_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_38_1.actors_[var_41_11.prefab_name].transform, "story_v_out_417261", "417261009", "story_v_out_417261.awb")

						arg_38_1:RecordAudio("417261009", var_41_17)
						arg_38_1:RecordAudio("417261009", var_41_17)
					else
						arg_38_1:AudioAction("play", "voice", "story_v_out_417261", "417261009", "story_v_out_417261.awb")
					end

					arg_38_1:RecordHistoryTalkVoice("story_v_out_417261", "417261009", "story_v_out_417261.awb")
				end

				arg_38_1:RecordContent(arg_38_1.text_.text)
			end

			local var_41_18 = math.max(var_41_9, arg_38_1.talkMaxDuration)

			if var_41_8 <= arg_38_1.time_ and arg_38_1.time_ < var_41_8 + var_41_18 then
				arg_38_1.typewritter.percent = (arg_38_1.time_ - var_41_8) / var_41_18

				arg_38_1.typewritter:SetDirty()
			end

			if arg_38_1.time_ >= var_41_8 + var_41_18 and arg_38_1.time_ < var_41_8 + var_41_18 + arg_41_0 then
				arg_38_1.typewritter.percent = 1

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(true)
			end
		end

		arg_38_1.nodeConfigList_ = {}

		arg_38_1:InitPlayNodeList()
	end,
	Play417261010 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 417261010
		arg_42_1.duration_ = 7.8

		local var_42_0 = {
			zh = 4.833,
			ja = 7.8
		}
		local var_42_1 = manager.audio:GetLocalizationFlag()

		if var_42_0[var_42_1] ~= nil then
			arg_42_1.duration_ = var_42_0[var_42_1]
		end

		SetActive(arg_42_1.tipsGo_, false)

		function arg_42_1.onSingleLineFinish_()
			arg_42_1.onSingleLineUpdate_ = nil
			arg_42_1.onSingleLineFinish_ = nil
			arg_42_1.state_ = "waiting"
		end

		function arg_42_1.playNext_(arg_44_0)
			if arg_44_0 == 1 then
				arg_42_0:Play417261011(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			local var_45_0 = arg_42_1.actors_["1034"]
			local var_45_1 = 0

			if var_45_1 < arg_42_1.time_ and arg_42_1.time_ <= var_45_1 + arg_45_0 and not isNil(var_45_0) and arg_42_1.var_.actorSpriteComps1034 == nil then
				arg_42_1.var_.actorSpriteComps1034 = var_45_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_45_2 = 0.2

			if var_45_1 <= arg_42_1.time_ and arg_42_1.time_ < var_45_1 + var_45_2 and not isNil(var_45_0) then
				local var_45_3 = (arg_42_1.time_ - var_45_1) / var_45_2

				if arg_42_1.var_.actorSpriteComps1034 then
					for iter_45_0, iter_45_1 in pairs(arg_42_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_45_1 then
							if arg_42_1.isInRecall_ then
								local var_45_4 = Mathf.Lerp(iter_45_1.color.r, arg_42_1.hightColor2.r, var_45_3)
								local var_45_5 = Mathf.Lerp(iter_45_1.color.g, arg_42_1.hightColor2.g, var_45_3)
								local var_45_6 = Mathf.Lerp(iter_45_1.color.b, arg_42_1.hightColor2.b, var_45_3)

								iter_45_1.color = Color.New(var_45_4, var_45_5, var_45_6)
							else
								local var_45_7 = Mathf.Lerp(iter_45_1.color.r, 0.5, var_45_3)

								iter_45_1.color = Color.New(var_45_7, var_45_7, var_45_7)
							end
						end
					end
				end
			end

			if arg_42_1.time_ >= var_45_1 + var_45_2 and arg_42_1.time_ < var_45_1 + var_45_2 + arg_45_0 and not isNil(var_45_0) and arg_42_1.var_.actorSpriteComps1034 then
				for iter_45_2, iter_45_3 in pairs(arg_42_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_45_3 then
						if arg_42_1.isInRecall_ then
							iter_45_3.color = arg_42_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_45_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_42_1.var_.actorSpriteComps1034 = nil
			end

			local var_45_8 = 0
			local var_45_9 = 0.45

			if var_45_8 < arg_42_1.time_ and arg_42_1.time_ <= var_45_8 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0
				arg_42_1.dialogCg_.alpha = 1

				arg_42_1.dialog_:SetActive(true)
				SetActive(arg_42_1.leftNameGo_, true)

				local var_45_10 = arg_42_1:FormatText(StoryNameCfg[468].name)

				arg_42_1.leftNameTxt_.text = var_45_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_42_1.leftNameTxt_.transform)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1.leftNameTxt_.text)
				SetActive(arg_42_1.iconTrs_.gameObject, true)
				arg_42_1.iconController_:SetSelectedState("hero")

				arg_42_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10049")

				arg_42_1.callingController_:SetSelectedState("normal")

				arg_42_1.keyicon_.color = Color.New(1, 1, 1)
				arg_42_1.icon_.color = Color.New(1, 1, 1)

				local var_45_11 = arg_42_1:GetWordFromCfg(417261010)
				local var_45_12 = arg_42_1:FormatText(var_45_11.content)

				arg_42_1.text_.text = var_45_12

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_13 = 18
				local var_45_14 = utf8.len(var_45_12)
				local var_45_15 = var_45_13 <= 0 and var_45_9 or var_45_9 * (var_45_14 / var_45_13)

				if var_45_15 > 0 and var_45_9 < var_45_15 then
					arg_42_1.talkMaxDuration = var_45_15

					if var_45_15 + var_45_8 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_15 + var_45_8
					end
				end

				arg_42_1.text_.text = var_45_12
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417261", "417261010", "story_v_out_417261.awb") ~= 0 then
					local var_45_16 = manager.audio:GetVoiceLength("story_v_out_417261", "417261010", "story_v_out_417261.awb") / 1000

					if var_45_16 + var_45_8 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_16 + var_45_8
					end

					if var_45_11.prefab_name ~= "" and arg_42_1.actors_[var_45_11.prefab_name] ~= nil then
						local var_45_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_42_1.actors_[var_45_11.prefab_name].transform, "story_v_out_417261", "417261010", "story_v_out_417261.awb")

						arg_42_1:RecordAudio("417261010", var_45_17)
						arg_42_1:RecordAudio("417261010", var_45_17)
					else
						arg_42_1:AudioAction("play", "voice", "story_v_out_417261", "417261010", "story_v_out_417261.awb")
					end

					arg_42_1:RecordHistoryTalkVoice("story_v_out_417261", "417261010", "story_v_out_417261.awb")
				end

				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_18 = math.max(var_45_9, arg_42_1.talkMaxDuration)

			if var_45_8 <= arg_42_1.time_ and arg_42_1.time_ < var_45_8 + var_45_18 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - var_45_8) / var_45_18

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= var_45_8 + var_45_18 and arg_42_1.time_ < var_45_8 + var_45_18 + arg_45_0 then
				arg_42_1.typewritter.percent = 1

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(true)
			end
		end

		arg_42_1.nodeConfigList_ = {}

		arg_42_1:InitPlayNodeList()
	end,
	Play417261011 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 417261011
		arg_46_1.duration_ = 1

		SetActive(arg_46_1.tipsGo_, false)

		function arg_46_1.onSingleLineFinish_()
			arg_46_1.onSingleLineUpdate_ = nil
			arg_46_1.onSingleLineFinish_ = nil
			arg_46_1.state_ = "waiting"
		end

		function arg_46_1.playNext_(arg_48_0)
			if arg_48_0 == 1 then
				arg_46_0:Play417261012(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			local var_49_0 = arg_46_1.actors_["1034"]
			local var_49_1 = 0

			if var_49_1 < arg_46_1.time_ and arg_46_1.time_ <= var_49_1 + arg_49_0 and not isNil(var_49_0) and arg_46_1.var_.actorSpriteComps1034 == nil then
				arg_46_1.var_.actorSpriteComps1034 = var_49_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_49_2 = 0.2

			if var_49_1 <= arg_46_1.time_ and arg_46_1.time_ < var_49_1 + var_49_2 and not isNil(var_49_0) then
				local var_49_3 = (arg_46_1.time_ - var_49_1) / var_49_2

				if arg_46_1.var_.actorSpriteComps1034 then
					for iter_49_0, iter_49_1 in pairs(arg_46_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_49_1 then
							if arg_46_1.isInRecall_ then
								local var_49_4 = Mathf.Lerp(iter_49_1.color.r, arg_46_1.hightColor1.r, var_49_3)
								local var_49_5 = Mathf.Lerp(iter_49_1.color.g, arg_46_1.hightColor1.g, var_49_3)
								local var_49_6 = Mathf.Lerp(iter_49_1.color.b, arg_46_1.hightColor1.b, var_49_3)

								iter_49_1.color = Color.New(var_49_4, var_49_5, var_49_6)
							else
								local var_49_7 = Mathf.Lerp(iter_49_1.color.r, 1, var_49_3)

								iter_49_1.color = Color.New(var_49_7, var_49_7, var_49_7)
							end
						end
					end
				end
			end

			if arg_46_1.time_ >= var_49_1 + var_49_2 and arg_46_1.time_ < var_49_1 + var_49_2 + arg_49_0 and not isNil(var_49_0) and arg_46_1.var_.actorSpriteComps1034 then
				for iter_49_2, iter_49_3 in pairs(arg_46_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_49_3 then
						if arg_46_1.isInRecall_ then
							iter_49_3.color = arg_46_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_49_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_46_1.var_.actorSpriteComps1034 = nil
			end

			local var_49_8 = 0
			local var_49_9 = 0.075

			if var_49_8 < arg_46_1.time_ and arg_46_1.time_ <= var_49_8 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0
				arg_46_1.dialogCg_.alpha = 1

				arg_46_1.dialog_:SetActive(true)
				SetActive(arg_46_1.leftNameGo_, true)

				local var_49_10 = arg_46_1:FormatText(StoryNameCfg[1109].name)

				arg_46_1.leftNameTxt_.text = var_49_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_46_1.leftNameTxt_.transform)

				arg_46_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_46_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_46_1:RecordName(arg_46_1.leftNameTxt_.text)
				SetActive(arg_46_1.iconTrs_.gameObject, false)
				arg_46_1.callingController_:SetSelectedState("normal")

				local var_49_11 = arg_46_1:GetWordFromCfg(417261011)
				local var_49_12 = arg_46_1:FormatText(var_49_11.content)

				arg_46_1.text_.text = var_49_12

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_13 = 3
				local var_49_14 = utf8.len(var_49_12)
				local var_49_15 = var_49_13 <= 0 and var_49_9 or var_49_9 * (var_49_14 / var_49_13)

				if var_49_15 > 0 and var_49_9 < var_49_15 then
					arg_46_1.talkMaxDuration = var_49_15

					if var_49_15 + var_49_8 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_15 + var_49_8
					end
				end

				arg_46_1.text_.text = var_49_12
				arg_46_1.typewritter.percent = 0

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417261", "417261011", "story_v_out_417261.awb") ~= 0 then
					local var_49_16 = manager.audio:GetVoiceLength("story_v_out_417261", "417261011", "story_v_out_417261.awb") / 1000

					if var_49_16 + var_49_8 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_16 + var_49_8
					end

					if var_49_11.prefab_name ~= "" and arg_46_1.actors_[var_49_11.prefab_name] ~= nil then
						local var_49_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_46_1.actors_[var_49_11.prefab_name].transform, "story_v_out_417261", "417261011", "story_v_out_417261.awb")

						arg_46_1:RecordAudio("417261011", var_49_17)
						arg_46_1:RecordAudio("417261011", var_49_17)
					else
						arg_46_1:AudioAction("play", "voice", "story_v_out_417261", "417261011", "story_v_out_417261.awb")
					end

					arg_46_1:RecordHistoryTalkVoice("story_v_out_417261", "417261011", "story_v_out_417261.awb")
				end

				arg_46_1:RecordContent(arg_46_1.text_.text)
			end

			local var_49_18 = math.max(var_49_9, arg_46_1.talkMaxDuration)

			if var_49_8 <= arg_46_1.time_ and arg_46_1.time_ < var_49_8 + var_49_18 then
				arg_46_1.typewritter.percent = (arg_46_1.time_ - var_49_8) / var_49_18

				arg_46_1.typewritter:SetDirty()
			end

			if arg_46_1.time_ >= var_49_8 + var_49_18 and arg_46_1.time_ < var_49_8 + var_49_18 + arg_49_0 then
				arg_46_1.typewritter.percent = 1

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(true)
			end
		end

		arg_46_1.nodeConfigList_ = {}

		arg_46_1:InitPlayNodeList()
	end,
	Play417261012 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 417261012
		arg_50_1.duration_ = 5

		SetActive(arg_50_1.tipsGo_, false)

		function arg_50_1.onSingleLineFinish_()
			arg_50_1.onSingleLineUpdate_ = nil
			arg_50_1.onSingleLineFinish_ = nil
			arg_50_1.state_ = "waiting"
		end

		function arg_50_1.playNext_(arg_52_0)
			if arg_52_0 == 1 then
				arg_50_0:Play417261013(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			local var_53_0 = arg_50_1.actors_["1034"].transform
			local var_53_1 = 0

			if var_53_1 < arg_50_1.time_ and arg_50_1.time_ <= var_53_1 + arg_53_0 then
				arg_50_1.var_.moveOldPos1034 = var_53_0.localPosition
				var_53_0.localScale = Vector3.New(1, 1, 1)

				arg_50_1:CheckSpriteTmpPos("1034", 7)

				local var_53_2 = var_53_0.childCount

				for iter_53_0 = 0, var_53_2 - 1 do
					local var_53_3 = var_53_0:GetChild(iter_53_0)

					if var_53_3.name == "" or not string.find(var_53_3.name, "split") then
						var_53_3.gameObject:SetActive(true)
					else
						var_53_3.gameObject:SetActive(false)
					end
				end
			end

			local var_53_4 = 0.001

			if var_53_1 <= arg_50_1.time_ and arg_50_1.time_ < var_53_1 + var_53_4 then
				local var_53_5 = (arg_50_1.time_ - var_53_1) / var_53_4
				local var_53_6 = Vector3.New(0, -2000, 0)

				var_53_0.localPosition = Vector3.Lerp(arg_50_1.var_.moveOldPos1034, var_53_6, var_53_5)
			end

			if arg_50_1.time_ >= var_53_1 + var_53_4 and arg_50_1.time_ < var_53_1 + var_53_4 + arg_53_0 then
				var_53_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_53_7 = 0
			local var_53_8 = 0.55

			if var_53_7 < arg_50_1.time_ and arg_50_1.time_ <= var_53_7 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, false)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_50_1.iconTrs_.gameObject, false)
				arg_50_1.callingController_:SetSelectedState("normal")

				local var_53_9 = arg_50_1:GetWordFromCfg(417261012)
				local var_53_10 = arg_50_1:FormatText(var_53_9.content)

				arg_50_1.text_.text = var_53_10

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_11 = 22
				local var_53_12 = utf8.len(var_53_10)
				local var_53_13 = var_53_11 <= 0 and var_53_8 or var_53_8 * (var_53_12 / var_53_11)

				if var_53_13 > 0 and var_53_8 < var_53_13 then
					arg_50_1.talkMaxDuration = var_53_13

					if var_53_13 + var_53_7 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_13 + var_53_7
					end
				end

				arg_50_1.text_.text = var_53_10
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)
				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_14 = math.max(var_53_8, arg_50_1.talkMaxDuration)

			if var_53_7 <= arg_50_1.time_ and arg_50_1.time_ < var_53_7 + var_53_14 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - var_53_7) / var_53_14

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= var_53_7 + var_53_14 and arg_50_1.time_ < var_53_7 + var_53_14 + arg_53_0 then
				arg_50_1.typewritter.percent = 1

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(true)
			end
		end

		arg_50_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_50_1:InitPlayNodeList()
	end,
	Play417261013 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 417261013
		arg_54_1.duration_ = 6.6

		local var_54_0 = {
			zh = 3.466,
			ja = 6.6
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
				arg_54_0:Play417261014(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			local var_57_0 = arg_54_1.actors_["1034"].transform
			local var_57_1 = 0

			if var_57_1 < arg_54_1.time_ and arg_54_1.time_ <= var_57_1 + arg_57_0 then
				arg_54_1.var_.moveOldPos1034 = var_57_0.localPosition
				var_57_0.localScale = Vector3.New(1, 1, 1)

				arg_54_1:CheckSpriteTmpPos("1034", 3)

				local var_57_2 = var_57_0.childCount

				for iter_57_0 = 0, var_57_2 - 1 do
					local var_57_3 = var_57_0:GetChild(iter_57_0)

					if var_57_3.name == "split_6" or not string.find(var_57_3.name, "split") then
						var_57_3.gameObject:SetActive(true)
					else
						var_57_3.gameObject:SetActive(false)
					end
				end
			end

			local var_57_4 = 0.001

			if var_57_1 <= arg_54_1.time_ and arg_54_1.time_ < var_57_1 + var_57_4 then
				local var_57_5 = (arg_54_1.time_ - var_57_1) / var_57_4
				local var_57_6 = Vector3.New(0, -331.9, -324)

				var_57_0.localPosition = Vector3.Lerp(arg_54_1.var_.moveOldPos1034, var_57_6, var_57_5)
			end

			if arg_54_1.time_ >= var_57_1 + var_57_4 and arg_54_1.time_ < var_57_1 + var_57_4 + arg_57_0 then
				var_57_0.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_57_7 = arg_54_1.actors_["1034"]
			local var_57_8 = 0

			if var_57_8 < arg_54_1.time_ and arg_54_1.time_ <= var_57_8 + arg_57_0 and not isNil(var_57_7) and arg_54_1.var_.actorSpriteComps1034 == nil then
				arg_54_1.var_.actorSpriteComps1034 = var_57_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_57_9 = 0.2

			if var_57_8 <= arg_54_1.time_ and arg_54_1.time_ < var_57_8 + var_57_9 and not isNil(var_57_7) then
				local var_57_10 = (arg_54_1.time_ - var_57_8) / var_57_9

				if arg_54_1.var_.actorSpriteComps1034 then
					for iter_57_1, iter_57_2 in pairs(arg_54_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_57_2 then
							if arg_54_1.isInRecall_ then
								local var_57_11 = Mathf.Lerp(iter_57_2.color.r, arg_54_1.hightColor1.r, var_57_10)
								local var_57_12 = Mathf.Lerp(iter_57_2.color.g, arg_54_1.hightColor1.g, var_57_10)
								local var_57_13 = Mathf.Lerp(iter_57_2.color.b, arg_54_1.hightColor1.b, var_57_10)

								iter_57_2.color = Color.New(var_57_11, var_57_12, var_57_13)
							else
								local var_57_14 = Mathf.Lerp(iter_57_2.color.r, 1, var_57_10)

								iter_57_2.color = Color.New(var_57_14, var_57_14, var_57_14)
							end
						end
					end
				end
			end

			if arg_54_1.time_ >= var_57_8 + var_57_9 and arg_54_1.time_ < var_57_8 + var_57_9 + arg_57_0 and not isNil(var_57_7) and arg_54_1.var_.actorSpriteComps1034 then
				for iter_57_3, iter_57_4 in pairs(arg_54_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_57_4 then
						if arg_54_1.isInRecall_ then
							iter_57_4.color = arg_54_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_57_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_54_1.var_.actorSpriteComps1034 = nil
			end

			local var_57_15 = 0
			local var_57_16 = 0.425

			if var_57_15 < arg_54_1.time_ and arg_54_1.time_ <= var_57_15 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, true)

				local var_57_17 = arg_54_1:FormatText(StoryNameCfg[1109].name)

				arg_54_1.leftNameTxt_.text = var_57_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_54_1.leftNameTxt_.transform)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1.leftNameTxt_.text)
				SetActive(arg_54_1.iconTrs_.gameObject, false)
				arg_54_1.callingController_:SetSelectedState("normal")

				local var_57_18 = arg_54_1:GetWordFromCfg(417261013)
				local var_57_19 = arg_54_1:FormatText(var_57_18.content)

				arg_54_1.text_.text = var_57_19

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_20 = 17
				local var_57_21 = utf8.len(var_57_19)
				local var_57_22 = var_57_20 <= 0 and var_57_16 or var_57_16 * (var_57_21 / var_57_20)

				if var_57_22 > 0 and var_57_16 < var_57_22 then
					arg_54_1.talkMaxDuration = var_57_22

					if var_57_22 + var_57_15 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_22 + var_57_15
					end
				end

				arg_54_1.text_.text = var_57_19
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417261", "417261013", "story_v_out_417261.awb") ~= 0 then
					local var_57_23 = manager.audio:GetVoiceLength("story_v_out_417261", "417261013", "story_v_out_417261.awb") / 1000

					if var_57_23 + var_57_15 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_23 + var_57_15
					end

					if var_57_18.prefab_name ~= "" and arg_54_1.actors_[var_57_18.prefab_name] ~= nil then
						local var_57_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_54_1.actors_[var_57_18.prefab_name].transform, "story_v_out_417261", "417261013", "story_v_out_417261.awb")

						arg_54_1:RecordAudio("417261013", var_57_24)
						arg_54_1:RecordAudio("417261013", var_57_24)
					else
						arg_54_1:AudioAction("play", "voice", "story_v_out_417261", "417261013", "story_v_out_417261.awb")
					end

					arg_54_1:RecordHistoryTalkVoice("story_v_out_417261", "417261013", "story_v_out_417261.awb")
				end

				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_25 = math.max(var_57_16, arg_54_1.talkMaxDuration)

			if var_57_15 <= arg_54_1.time_ and arg_54_1.time_ < var_57_15 + var_57_25 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - var_57_15) / var_57_25

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= var_57_15 + var_57_25 and arg_54_1.time_ < var_57_15 + var_57_25 + arg_57_0 then
				arg_54_1.typewritter.percent = 1

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(true)
			end
		end

		arg_54_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_54_1:InitPlayNodeList()
	end,
	Play417261014 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 417261014
		arg_58_1.duration_ = 13.13

		local var_58_0 = {
			zh = 9.8,
			ja = 13.133
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
				arg_58_0:Play417261015(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			local var_61_0 = arg_58_1.actors_["1034"]
			local var_61_1 = 0

			if var_61_1 < arg_58_1.time_ and arg_58_1.time_ <= var_61_1 + arg_61_0 and not isNil(var_61_0) and arg_58_1.var_.actorSpriteComps1034 == nil then
				arg_58_1.var_.actorSpriteComps1034 = var_61_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_61_2 = 0.2

			if var_61_1 <= arg_58_1.time_ and arg_58_1.time_ < var_61_1 + var_61_2 and not isNil(var_61_0) then
				local var_61_3 = (arg_58_1.time_ - var_61_1) / var_61_2

				if arg_58_1.var_.actorSpriteComps1034 then
					for iter_61_0, iter_61_1 in pairs(arg_58_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_61_1 then
							if arg_58_1.isInRecall_ then
								local var_61_4 = Mathf.Lerp(iter_61_1.color.r, arg_58_1.hightColor2.r, var_61_3)
								local var_61_5 = Mathf.Lerp(iter_61_1.color.g, arg_58_1.hightColor2.g, var_61_3)
								local var_61_6 = Mathf.Lerp(iter_61_1.color.b, arg_58_1.hightColor2.b, var_61_3)

								iter_61_1.color = Color.New(var_61_4, var_61_5, var_61_6)
							else
								local var_61_7 = Mathf.Lerp(iter_61_1.color.r, 0.5, var_61_3)

								iter_61_1.color = Color.New(var_61_7, var_61_7, var_61_7)
							end
						end
					end
				end
			end

			if arg_58_1.time_ >= var_61_1 + var_61_2 and arg_58_1.time_ < var_61_1 + var_61_2 + arg_61_0 and not isNil(var_61_0) and arg_58_1.var_.actorSpriteComps1034 then
				for iter_61_2, iter_61_3 in pairs(arg_58_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_61_3 then
						if arg_58_1.isInRecall_ then
							iter_61_3.color = arg_58_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_61_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_58_1.var_.actorSpriteComps1034 = nil
			end

			local var_61_8 = 0
			local var_61_9 = 1

			if var_61_8 < arg_58_1.time_ and arg_58_1.time_ <= var_61_8 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, true)

				local var_61_10 = arg_58_1:FormatText(StoryNameCfg[468].name)

				arg_58_1.leftNameTxt_.text = var_61_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, true)
				arg_58_1.iconController_:SetSelectedState("hero")

				arg_58_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10049")

				arg_58_1.callingController_:SetSelectedState("normal")

				arg_58_1.keyicon_.color = Color.New(1, 1, 1)
				arg_58_1.icon_.color = Color.New(1, 1, 1)

				local var_61_11 = arg_58_1:GetWordFromCfg(417261014)
				local var_61_12 = arg_58_1:FormatText(var_61_11.content)

				arg_58_1.text_.text = var_61_12

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_13 = 40
				local var_61_14 = utf8.len(var_61_12)
				local var_61_15 = var_61_13 <= 0 and var_61_9 or var_61_9 * (var_61_14 / var_61_13)

				if var_61_15 > 0 and var_61_9 < var_61_15 then
					arg_58_1.talkMaxDuration = var_61_15

					if var_61_15 + var_61_8 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_15 + var_61_8
					end
				end

				arg_58_1.text_.text = var_61_12
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417261", "417261014", "story_v_out_417261.awb") ~= 0 then
					local var_61_16 = manager.audio:GetVoiceLength("story_v_out_417261", "417261014", "story_v_out_417261.awb") / 1000

					if var_61_16 + var_61_8 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_16 + var_61_8
					end

					if var_61_11.prefab_name ~= "" and arg_58_1.actors_[var_61_11.prefab_name] ~= nil then
						local var_61_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_58_1.actors_[var_61_11.prefab_name].transform, "story_v_out_417261", "417261014", "story_v_out_417261.awb")

						arg_58_1:RecordAudio("417261014", var_61_17)
						arg_58_1:RecordAudio("417261014", var_61_17)
					else
						arg_58_1:AudioAction("play", "voice", "story_v_out_417261", "417261014", "story_v_out_417261.awb")
					end

					arg_58_1:RecordHistoryTalkVoice("story_v_out_417261", "417261014", "story_v_out_417261.awb")
				end

				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_18 = math.max(var_61_9, arg_58_1.talkMaxDuration)

			if var_61_8 <= arg_58_1.time_ and arg_58_1.time_ < var_61_8 + var_61_18 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_8) / var_61_18

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_8 + var_61_18 and arg_58_1.time_ < var_61_8 + var_61_18 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {}

		arg_58_1:InitPlayNodeList()
	end,
	Play417261015 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 417261015
		arg_62_1.duration_ = 16.6

		local var_62_0 = {
			zh = 10.633,
			ja = 16.6
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
				arg_62_0:Play417261016(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			local var_65_0 = 0
			local var_65_1 = 1.025

			if var_65_0 < arg_62_1.time_ and arg_62_1.time_ <= var_65_0 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, true)

				local var_65_2 = arg_62_1:FormatText(StoryNameCfg[468].name)

				arg_62_1.leftNameTxt_.text = var_65_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_62_1.leftNameTxt_.transform)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1.leftNameTxt_.text)
				SetActive(arg_62_1.iconTrs_.gameObject, true)
				arg_62_1.iconController_:SetSelectedState("hero")

				arg_62_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10049")

				arg_62_1.callingController_:SetSelectedState("normal")

				arg_62_1.keyicon_.color = Color.New(1, 1, 1)
				arg_62_1.icon_.color = Color.New(1, 1, 1)

				local var_65_3 = arg_62_1:GetWordFromCfg(417261015)
				local var_65_4 = arg_62_1:FormatText(var_65_3.content)

				arg_62_1.text_.text = var_65_4

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_5 = 41
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

				if manager.audio:GetVoiceLength("story_v_out_417261", "417261015", "story_v_out_417261.awb") ~= 0 then
					local var_65_8 = manager.audio:GetVoiceLength("story_v_out_417261", "417261015", "story_v_out_417261.awb") / 1000

					if var_65_8 + var_65_0 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_8 + var_65_0
					end

					if var_65_3.prefab_name ~= "" and arg_62_1.actors_[var_65_3.prefab_name] ~= nil then
						local var_65_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_62_1.actors_[var_65_3.prefab_name].transform, "story_v_out_417261", "417261015", "story_v_out_417261.awb")

						arg_62_1:RecordAudio("417261015", var_65_9)
						arg_62_1:RecordAudio("417261015", var_65_9)
					else
						arg_62_1:AudioAction("play", "voice", "story_v_out_417261", "417261015", "story_v_out_417261.awb")
					end

					arg_62_1:RecordHistoryTalkVoice("story_v_out_417261", "417261015", "story_v_out_417261.awb")
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
	Play417261016 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 417261016
		arg_66_1.duration_ = 10

		local var_66_0 = {
			zh = 9.766,
			ja = 10
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
				arg_66_0:Play417261017(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			local var_69_0 = 0
			local var_69_1 = 0.825

			if var_69_0 < arg_66_1.time_ and arg_66_1.time_ <= var_69_0 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				local var_69_2 = arg_66_1:FormatText(StoryNameCfg[468].name)

				arg_66_1.leftNameTxt_.text = var_69_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, true)
				arg_66_1.iconController_:SetSelectedState("hero")

				arg_66_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10049")

				arg_66_1.callingController_:SetSelectedState("normal")

				arg_66_1.keyicon_.color = Color.New(1, 1, 1)
				arg_66_1.icon_.color = Color.New(1, 1, 1)

				local var_69_3 = arg_66_1:GetWordFromCfg(417261016)
				local var_69_4 = arg_66_1:FormatText(var_69_3.content)

				arg_66_1.text_.text = var_69_4

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_5 = 33
				local var_69_6 = utf8.len(var_69_4)
				local var_69_7 = var_69_5 <= 0 and var_69_1 or var_69_1 * (var_69_6 / var_69_5)

				if var_69_7 > 0 and var_69_1 < var_69_7 then
					arg_66_1.talkMaxDuration = var_69_7

					if var_69_7 + var_69_0 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_7 + var_69_0
					end
				end

				arg_66_1.text_.text = var_69_4
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417261", "417261016", "story_v_out_417261.awb") ~= 0 then
					local var_69_8 = manager.audio:GetVoiceLength("story_v_out_417261", "417261016", "story_v_out_417261.awb") / 1000

					if var_69_8 + var_69_0 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_8 + var_69_0
					end

					if var_69_3.prefab_name ~= "" and arg_66_1.actors_[var_69_3.prefab_name] ~= nil then
						local var_69_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_66_1.actors_[var_69_3.prefab_name].transform, "story_v_out_417261", "417261016", "story_v_out_417261.awb")

						arg_66_1:RecordAudio("417261016", var_69_9)
						arg_66_1:RecordAudio("417261016", var_69_9)
					else
						arg_66_1:AudioAction("play", "voice", "story_v_out_417261", "417261016", "story_v_out_417261.awb")
					end

					arg_66_1:RecordHistoryTalkVoice("story_v_out_417261", "417261016", "story_v_out_417261.awb")
				end

				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_10 = math.max(var_69_1, arg_66_1.talkMaxDuration)

			if var_69_0 <= arg_66_1.time_ and arg_66_1.time_ < var_69_0 + var_69_10 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_0) / var_69_10

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_0 + var_69_10 and arg_66_1.time_ < var_69_0 + var_69_10 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {}

		arg_66_1:InitPlayNodeList()
	end,
	Play417261017 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 417261017
		arg_70_1.duration_ = 9.53

		local var_70_0 = {
			zh = 7.433,
			ja = 9.533
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
				arg_70_0:Play417261018(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			local var_73_0 = 4

			if var_73_0 < arg_70_1.time_ and arg_70_1.time_ <= var_73_0 + arg_73_0 then
				arg_70_1.allBtn_.enabled = false
			end

			local var_73_1 = 0.0666666666666664

			if arg_70_1.time_ >= var_73_0 + var_73_1 and arg_70_1.time_ < var_73_0 + var_73_1 + arg_73_0 then
				arg_70_1.allBtn_.enabled = true
			end

			local var_73_2 = "ST73"

			if arg_70_1.bgs_[var_73_2] == nil then
				local var_73_3 = Object.Instantiate(arg_70_1.paintGo_)

				var_73_3:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_73_2)
				var_73_3.name = var_73_2
				var_73_3.transform.parent = arg_70_1.stage_.transform
				var_73_3.transform.localPosition = Vector3.New(0, 100, 0)
				arg_70_1.bgs_[var_73_2] = var_73_3
			end

			local var_73_4 = 2

			if var_73_4 < arg_70_1.time_ and arg_70_1.time_ <= var_73_4 + arg_73_0 then
				local var_73_5 = manager.ui.mainCamera.transform.localPosition
				local var_73_6 = Vector3.New(0, 0, 10) + Vector3.New(var_73_5.x, var_73_5.y, 0)
				local var_73_7 = arg_70_1.bgs_.ST73

				var_73_7.transform.localPosition = var_73_6
				var_73_7.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_73_8 = var_73_7:GetComponent("SpriteRenderer")

				if var_73_8 and var_73_8.sprite then
					local var_73_9 = (var_73_7.transform.localPosition - var_73_5).z
					local var_73_10 = manager.ui.mainCameraCom_
					local var_73_11 = 2 * var_73_9 * Mathf.Tan(var_73_10.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_73_12 = var_73_11 * var_73_10.aspect
					local var_73_13 = var_73_8.sprite.bounds.size.x
					local var_73_14 = var_73_8.sprite.bounds.size.y
					local var_73_15 = var_73_12 / var_73_13
					local var_73_16 = var_73_11 / var_73_14
					local var_73_17 = var_73_16 < var_73_15 and var_73_15 or var_73_16

					var_73_7.transform.localScale = Vector3.New(var_73_17, var_73_17, 0)
				end

				for iter_73_0, iter_73_1 in pairs(arg_70_1.bgs_) do
					if iter_73_0 ~= "ST73" then
						iter_73_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_73_18 = 0

			if var_73_18 < arg_70_1.time_ and arg_70_1.time_ <= var_73_18 + arg_73_0 then
				arg_70_1.mask_.enabled = true
				arg_70_1.mask_.raycastTarget = true

				arg_70_1:SetGaussion(false)
			end

			local var_73_19 = 2

			if var_73_18 <= arg_70_1.time_ and arg_70_1.time_ < var_73_18 + var_73_19 then
				local var_73_20 = (arg_70_1.time_ - var_73_18) / var_73_19
				local var_73_21 = Color.New(0, 0, 0)

				var_73_21.a = Mathf.Lerp(0, 1, var_73_20)
				arg_70_1.mask_.color = var_73_21
			end

			if arg_70_1.time_ >= var_73_18 + var_73_19 and arg_70_1.time_ < var_73_18 + var_73_19 + arg_73_0 then
				local var_73_22 = Color.New(0, 0, 0)

				var_73_22.a = 1
				arg_70_1.mask_.color = var_73_22
			end

			local var_73_23 = 2

			if var_73_23 < arg_70_1.time_ and arg_70_1.time_ <= var_73_23 + arg_73_0 then
				arg_70_1.mask_.enabled = true
				arg_70_1.mask_.raycastTarget = true

				arg_70_1:SetGaussion(false)
			end

			local var_73_24 = 2

			if var_73_23 <= arg_70_1.time_ and arg_70_1.time_ < var_73_23 + var_73_24 then
				local var_73_25 = (arg_70_1.time_ - var_73_23) / var_73_24
				local var_73_26 = Color.New(0, 0, 0)

				var_73_26.a = Mathf.Lerp(1, 0, var_73_25)
				arg_70_1.mask_.color = var_73_26
			end

			if arg_70_1.time_ >= var_73_23 + var_73_24 and arg_70_1.time_ < var_73_23 + var_73_24 + arg_73_0 then
				local var_73_27 = Color.New(0, 0, 0)
				local var_73_28 = 0

				arg_70_1.mask_.enabled = false
				var_73_27.a = var_73_28
				arg_70_1.mask_.color = var_73_27
			end

			local var_73_29 = arg_70_1.actors_["1034"].transform
			local var_73_30 = 1.966

			if var_73_30 < arg_70_1.time_ and arg_70_1.time_ <= var_73_30 + arg_73_0 then
				arg_70_1.var_.moveOldPos1034 = var_73_29.localPosition
				var_73_29.localScale = Vector3.New(1, 1, 1)

				arg_70_1:CheckSpriteTmpPos("1034", 7)

				local var_73_31 = var_73_29.childCount

				for iter_73_2 = 0, var_73_31 - 1 do
					local var_73_32 = var_73_29:GetChild(iter_73_2)

					if var_73_32.name == "" or not string.find(var_73_32.name, "split") then
						var_73_32.gameObject:SetActive(true)
					else
						var_73_32.gameObject:SetActive(false)
					end
				end
			end

			local var_73_33 = 0.001

			if var_73_30 <= arg_70_1.time_ and arg_70_1.time_ < var_73_30 + var_73_33 then
				local var_73_34 = (arg_70_1.time_ - var_73_30) / var_73_33
				local var_73_35 = Vector3.New(0, -2000, 0)

				var_73_29.localPosition = Vector3.Lerp(arg_70_1.var_.moveOldPos1034, var_73_35, var_73_34)
			end

			if arg_70_1.time_ >= var_73_30 + var_73_33 and arg_70_1.time_ < var_73_30 + var_73_33 + arg_73_0 then
				var_73_29.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_73_36 = arg_70_1.actors_["1034"].transform
			local var_73_37 = 3.66666666666667

			if var_73_37 < arg_70_1.time_ and arg_70_1.time_ <= var_73_37 + arg_73_0 then
				arg_70_1.var_.moveOldPos1034 = var_73_36.localPosition
				var_73_36.localScale = Vector3.New(1, 1, 1)

				arg_70_1:CheckSpriteTmpPos("1034", 3)

				local var_73_38 = var_73_36.childCount

				for iter_73_3 = 0, var_73_38 - 1 do
					local var_73_39 = var_73_36:GetChild(iter_73_3)

					if var_73_39.name == "split_1" or not string.find(var_73_39.name, "split") then
						var_73_39.gameObject:SetActive(true)
					else
						var_73_39.gameObject:SetActive(false)
					end
				end
			end

			local var_73_40 = 0.001

			if var_73_37 <= arg_70_1.time_ and arg_70_1.time_ < var_73_37 + var_73_40 then
				local var_73_41 = (arg_70_1.time_ - var_73_37) / var_73_40
				local var_73_42 = Vector3.New(0, -331.9, -324)

				var_73_36.localPosition = Vector3.Lerp(arg_70_1.var_.moveOldPos1034, var_73_42, var_73_41)
			end

			if arg_70_1.time_ >= var_73_37 + var_73_40 and arg_70_1.time_ < var_73_37 + var_73_40 + arg_73_0 then
				var_73_36.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_73_43 = arg_70_1.actors_["1034"]
			local var_73_44 = 3.66666666666667

			if var_73_44 < arg_70_1.time_ and arg_70_1.time_ <= var_73_44 + arg_73_0 and not isNil(var_73_43) and arg_70_1.var_.actorSpriteComps1034 == nil then
				arg_70_1.var_.actorSpriteComps1034 = var_73_43:GetComponentsInChildren(typeof(Image), true)
			end

			local var_73_45 = 0.2

			if var_73_44 <= arg_70_1.time_ and arg_70_1.time_ < var_73_44 + var_73_45 and not isNil(var_73_43) then
				local var_73_46 = (arg_70_1.time_ - var_73_44) / var_73_45

				if arg_70_1.var_.actorSpriteComps1034 then
					for iter_73_4, iter_73_5 in pairs(arg_70_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_73_5 then
							if arg_70_1.isInRecall_ then
								local var_73_47 = Mathf.Lerp(iter_73_5.color.r, arg_70_1.hightColor1.r, var_73_46)
								local var_73_48 = Mathf.Lerp(iter_73_5.color.g, arg_70_1.hightColor1.g, var_73_46)
								local var_73_49 = Mathf.Lerp(iter_73_5.color.b, arg_70_1.hightColor1.b, var_73_46)

								iter_73_5.color = Color.New(var_73_47, var_73_48, var_73_49)
							else
								local var_73_50 = Mathf.Lerp(iter_73_5.color.r, 1, var_73_46)

								iter_73_5.color = Color.New(var_73_50, var_73_50, var_73_50)
							end
						end
					end
				end
			end

			if arg_70_1.time_ >= var_73_44 + var_73_45 and arg_70_1.time_ < var_73_44 + var_73_45 + arg_73_0 and not isNil(var_73_43) and arg_70_1.var_.actorSpriteComps1034 then
				for iter_73_6, iter_73_7 in pairs(arg_70_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_73_7 then
						if arg_70_1.isInRecall_ then
							iter_73_7.color = arg_70_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_73_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_70_1.var_.actorSpriteComps1034 = nil
			end

			local var_73_51 = arg_70_1.actors_["1034"]
			local var_73_52 = 3.66666666666667

			if var_73_52 < arg_70_1.time_ and arg_70_1.time_ <= var_73_52 + arg_73_0 then
				local var_73_53 = var_73_51:GetComponentInChildren(typeof(CanvasGroup))

				if var_73_53 then
					arg_70_1.var_.alphaOldValue1034 = var_73_53.alpha
					arg_70_1.var_.characterEffect1034 = var_73_53
				end

				arg_70_1.var_.alphaOldValue1034 = 0
			end

			local var_73_54 = 0.333333333333333

			if var_73_52 <= arg_70_1.time_ and arg_70_1.time_ < var_73_52 + var_73_54 then
				local var_73_55 = (arg_70_1.time_ - var_73_52) / var_73_54
				local var_73_56 = Mathf.Lerp(arg_70_1.var_.alphaOldValue1034, 1, var_73_55)

				if arg_70_1.var_.characterEffect1034 then
					arg_70_1.var_.characterEffect1034.alpha = var_73_56
				end
			end

			if arg_70_1.time_ >= var_73_52 + var_73_54 and arg_70_1.time_ < var_73_52 + var_73_54 + arg_73_0 and arg_70_1.var_.characterEffect1034 then
				arg_70_1.var_.characterEffect1034.alpha = 1
			end

			if arg_70_1.frameCnt_ <= 1 then
				arg_70_1.dialog_:SetActive(false)
			end

			local var_73_57 = 4
			local var_73_58 = 0.2

			if var_73_57 < arg_70_1.time_ and arg_70_1.time_ <= var_73_57 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0

				arg_70_1.dialog_:SetActive(true)

				arg_70_1.dialogCg_.alpha = 0

				local var_73_59 = LeanTween.value(arg_70_1.dialog_, 0, 1, 0.3)

				var_73_59:setOnUpdate(LuaHelper.FloatAction(function(arg_74_0)
					arg_70_1.dialogCg_.alpha = arg_74_0
				end))
				var_73_59:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_70_1.dialog_)
					var_73_59:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_70_1.duration_ = arg_70_1.duration_ + 0.3

				SetActive(arg_70_1.leftNameGo_, true)

				local var_73_60 = arg_70_1:FormatText(StoryNameCfg[1109].name)

				arg_70_1.leftNameTxt_.text = var_73_60

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_70_1.leftNameTxt_.transform)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1.leftNameTxt_.text)
				SetActive(arg_70_1.iconTrs_.gameObject, false)
				arg_70_1.callingController_:SetSelectedState("normal")

				local var_73_61 = arg_70_1:GetWordFromCfg(417261017)
				local var_73_62 = arg_70_1:FormatText(var_73_61.content)

				arg_70_1.text_.text = var_73_62

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_63 = 8
				local var_73_64 = utf8.len(var_73_62)
				local var_73_65 = var_73_63 <= 0 and var_73_58 or var_73_58 * (var_73_64 / var_73_63)

				if var_73_65 > 0 and var_73_58 < var_73_65 then
					arg_70_1.talkMaxDuration = var_73_65
					var_73_57 = var_73_57 + 0.3

					if var_73_65 + var_73_57 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_65 + var_73_57
					end
				end

				arg_70_1.text_.text = var_73_62
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417261", "417261017", "story_v_out_417261.awb") ~= 0 then
					local var_73_66 = manager.audio:GetVoiceLength("story_v_out_417261", "417261017", "story_v_out_417261.awb") / 1000

					if var_73_66 + var_73_57 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_66 + var_73_57
					end

					if var_73_61.prefab_name ~= "" and arg_70_1.actors_[var_73_61.prefab_name] ~= nil then
						local var_73_67 = LuaForUtil.PlayVoiceWithCriLipsync(arg_70_1.actors_[var_73_61.prefab_name].transform, "story_v_out_417261", "417261017", "story_v_out_417261.awb")

						arg_70_1:RecordAudio("417261017", var_73_67)
						arg_70_1:RecordAudio("417261017", var_73_67)
					else
						arg_70_1:AudioAction("play", "voice", "story_v_out_417261", "417261017", "story_v_out_417261.awb")
					end

					arg_70_1:RecordHistoryTalkVoice("story_v_out_417261", "417261017", "story_v_out_417261.awb")
				end

				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_68 = var_73_57 + 0.3
			local var_73_69 = math.max(var_73_58, arg_70_1.talkMaxDuration)

			if var_73_68 <= arg_70_1.time_ and arg_70_1.time_ < var_73_68 + var_73_69 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_68) / var_73_69

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_68 + var_73_69 and arg_70_1.time_ < var_73_68 + var_73_69 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.66666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_70_1:InitPlayNodeList()
	end,
	Play417261018 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 417261018
		arg_76_1.duration_ = 5

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play417261019(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = arg_76_1.actors_["1034"].transform
			local var_79_1 = 0

			if var_79_1 < arg_76_1.time_ and arg_76_1.time_ <= var_79_1 + arg_79_0 then
				arg_76_1.var_.moveOldPos1034 = var_79_0.localPosition
				var_79_0.localScale = Vector3.New(1, 1, 1)

				arg_76_1:CheckSpriteTmpPos("1034", 7)

				local var_79_2 = var_79_0.childCount

				for iter_79_0 = 0, var_79_2 - 1 do
					local var_79_3 = var_79_0:GetChild(iter_79_0)

					if var_79_3.name == "" or not string.find(var_79_3.name, "split") then
						var_79_3.gameObject:SetActive(true)
					else
						var_79_3.gameObject:SetActive(false)
					end
				end
			end

			local var_79_4 = 0.001

			if var_79_1 <= arg_76_1.time_ and arg_76_1.time_ < var_79_1 + var_79_4 then
				local var_79_5 = (arg_76_1.time_ - var_79_1) / var_79_4
				local var_79_6 = Vector3.New(0, -2000, 0)

				var_79_0.localPosition = Vector3.Lerp(arg_76_1.var_.moveOldPos1034, var_79_6, var_79_5)
			end

			if arg_76_1.time_ >= var_79_1 + var_79_4 and arg_76_1.time_ < var_79_1 + var_79_4 + arg_79_0 then
				var_79_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_79_7 = 0.133333333333333
			local var_79_8 = 1

			if var_79_7 < arg_76_1.time_ and arg_76_1.time_ <= var_79_7 + arg_79_0 then
				local var_79_9 = "play"
				local var_79_10 = "effect"

				arg_76_1:AudioAction(var_79_9, var_79_10, "se_story_side_1011", "se_story_side_1011_doorhandle", "")
			end

			local var_79_11 = 0
			local var_79_12 = 1.425

			if var_79_11 < arg_76_1.time_ and arg_76_1.time_ <= var_79_11 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, false)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_13 = arg_76_1:GetWordFromCfg(417261018)
				local var_79_14 = arg_76_1:FormatText(var_79_13.content)

				arg_76_1.text_.text = var_79_14

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_15 = 57
				local var_79_16 = utf8.len(var_79_14)
				local var_79_17 = var_79_15 <= 0 and var_79_12 or var_79_12 * (var_79_16 / var_79_15)

				if var_79_17 > 0 and var_79_12 < var_79_17 then
					arg_76_1.talkMaxDuration = var_79_17

					if var_79_17 + var_79_11 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_17 + var_79_11
					end
				end

				arg_76_1.text_.text = var_79_14
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)
				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_18 = math.max(var_79_12, arg_76_1.talkMaxDuration)

			if var_79_11 <= arg_76_1.time_ and arg_76_1.time_ < var_79_11 + var_79_18 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_11) / var_79_18

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_11 + var_79_18 and arg_76_1.time_ < var_79_11 + var_79_18 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_76_1:InitPlayNodeList()
	end,
	Play417261019 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 417261019
		arg_80_1.duration_ = 3.23

		local var_80_0 = {
			zh = 1.533,
			ja = 3.233
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
				arg_80_0:Play417261020(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = arg_80_1.actors_["1034"]
			local var_83_1 = 0

			if var_83_1 < arg_80_1.time_ and arg_80_1.time_ <= var_83_1 + arg_83_0 and not isNil(var_83_0) and arg_80_1.var_.actorSpriteComps1034 == nil then
				arg_80_1.var_.actorSpriteComps1034 = var_83_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_83_2 = 0.2

			if var_83_1 <= arg_80_1.time_ and arg_80_1.time_ < var_83_1 + var_83_2 and not isNil(var_83_0) then
				local var_83_3 = (arg_80_1.time_ - var_83_1) / var_83_2

				if arg_80_1.var_.actorSpriteComps1034 then
					for iter_83_0, iter_83_1 in pairs(arg_80_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_83_1 then
							if arg_80_1.isInRecall_ then
								local var_83_4 = Mathf.Lerp(iter_83_1.color.r, arg_80_1.hightColor1.r, var_83_3)
								local var_83_5 = Mathf.Lerp(iter_83_1.color.g, arg_80_1.hightColor1.g, var_83_3)
								local var_83_6 = Mathf.Lerp(iter_83_1.color.b, arg_80_1.hightColor1.b, var_83_3)

								iter_83_1.color = Color.New(var_83_4, var_83_5, var_83_6)
							else
								local var_83_7 = Mathf.Lerp(iter_83_1.color.r, 1, var_83_3)

								iter_83_1.color = Color.New(var_83_7, var_83_7, var_83_7)
							end
						end
					end
				end
			end

			if arg_80_1.time_ >= var_83_1 + var_83_2 and arg_80_1.time_ < var_83_1 + var_83_2 + arg_83_0 and not isNil(var_83_0) and arg_80_1.var_.actorSpriteComps1034 then
				for iter_83_2, iter_83_3 in pairs(arg_80_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_83_3 then
						if arg_80_1.isInRecall_ then
							iter_83_3.color = arg_80_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_83_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_80_1.var_.actorSpriteComps1034 = nil
			end

			local var_83_8 = arg_80_1.actors_["1034"].transform
			local var_83_9 = 0

			if var_83_9 < arg_80_1.time_ and arg_80_1.time_ <= var_83_9 + arg_83_0 then
				arg_80_1.var_.moveOldPos1034 = var_83_8.localPosition
				var_83_8.localScale = Vector3.New(1, 1, 1)

				arg_80_1:CheckSpriteTmpPos("1034", 3)

				local var_83_10 = var_83_8.childCount

				for iter_83_4 = 0, var_83_10 - 1 do
					local var_83_11 = var_83_8:GetChild(iter_83_4)

					if var_83_11.name == "split_6" or not string.find(var_83_11.name, "split") then
						var_83_11.gameObject:SetActive(true)
					else
						var_83_11.gameObject:SetActive(false)
					end
				end
			end

			local var_83_12 = 0.001

			if var_83_9 <= arg_80_1.time_ and arg_80_1.time_ < var_83_9 + var_83_12 then
				local var_83_13 = (arg_80_1.time_ - var_83_9) / var_83_12
				local var_83_14 = Vector3.New(0, -331.9, -324)

				var_83_8.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPos1034, var_83_14, var_83_13)
			end

			if arg_80_1.time_ >= var_83_9 + var_83_12 and arg_80_1.time_ < var_83_9 + var_83_12 + arg_83_0 then
				var_83_8.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_83_15 = 0
			local var_83_16 = 0.225

			if var_83_15 < arg_80_1.time_ and arg_80_1.time_ <= var_83_15 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				local var_83_17 = arg_80_1:FormatText(StoryNameCfg[1109].name)

				arg_80_1.leftNameTxt_.text = var_83_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_18 = arg_80_1:GetWordFromCfg(417261019)
				local var_83_19 = arg_80_1:FormatText(var_83_18.content)

				arg_80_1.text_.text = var_83_19

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_20 = 9
				local var_83_21 = utf8.len(var_83_19)
				local var_83_22 = var_83_20 <= 0 and var_83_16 or var_83_16 * (var_83_21 / var_83_20)

				if var_83_22 > 0 and var_83_16 < var_83_22 then
					arg_80_1.talkMaxDuration = var_83_22

					if var_83_22 + var_83_15 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_22 + var_83_15
					end
				end

				arg_80_1.text_.text = var_83_19
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417261", "417261019", "story_v_out_417261.awb") ~= 0 then
					local var_83_23 = manager.audio:GetVoiceLength("story_v_out_417261", "417261019", "story_v_out_417261.awb") / 1000

					if var_83_23 + var_83_15 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_23 + var_83_15
					end

					if var_83_18.prefab_name ~= "" and arg_80_1.actors_[var_83_18.prefab_name] ~= nil then
						local var_83_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_18.prefab_name].transform, "story_v_out_417261", "417261019", "story_v_out_417261.awb")

						arg_80_1:RecordAudio("417261019", var_83_24)
						arg_80_1:RecordAudio("417261019", var_83_24)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_out_417261", "417261019", "story_v_out_417261.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_out_417261", "417261019", "story_v_out_417261.awb")
				end

				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_25 = math.max(var_83_16, arg_80_1.talkMaxDuration)

			if var_83_15 <= arg_80_1.time_ and arg_80_1.time_ < var_83_15 + var_83_25 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_15) / var_83_25

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_15 + var_83_25 and arg_80_1.time_ < var_83_15 + var_83_25 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_80_1:InitPlayNodeList()
	end,
	Play417261020 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 417261020
		arg_84_1.duration_ = 5

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play417261021(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = arg_84_1.actors_["1034"].transform
			local var_87_1 = 0

			if var_87_1 < arg_84_1.time_ and arg_84_1.time_ <= var_87_1 + arg_87_0 then
				arg_84_1.var_.moveOldPos1034 = var_87_0.localPosition
				var_87_0.localScale = Vector3.New(1, 1, 1)

				arg_84_1:CheckSpriteTmpPos("1034", 7)

				local var_87_2 = var_87_0.childCount

				for iter_87_0 = 0, var_87_2 - 1 do
					local var_87_3 = var_87_0:GetChild(iter_87_0)

					if var_87_3.name == "" or not string.find(var_87_3.name, "split") then
						var_87_3.gameObject:SetActive(true)
					else
						var_87_3.gameObject:SetActive(false)
					end
				end
			end

			local var_87_4 = 0.001

			if var_87_1 <= arg_84_1.time_ and arg_84_1.time_ < var_87_1 + var_87_4 then
				local var_87_5 = (arg_84_1.time_ - var_87_1) / var_87_4
				local var_87_6 = Vector3.New(0, -2000, 0)

				var_87_0.localPosition = Vector3.Lerp(arg_84_1.var_.moveOldPos1034, var_87_6, var_87_5)
			end

			if arg_84_1.time_ >= var_87_1 + var_87_4 and arg_84_1.time_ < var_87_1 + var_87_4 + arg_87_0 then
				var_87_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_87_7 = 0.624999999999
			local var_87_8 = 1

			if var_87_7 < arg_84_1.time_ and arg_84_1.time_ <= var_87_7 + arg_87_0 then
				local var_87_9 = "play"
				local var_87_10 = "effect"

				arg_84_1:AudioAction(var_87_9, var_87_10, "se_story_1311", "se_story_1311_partypopper", "")
			end

			local var_87_11 = 0
			local var_87_12 = 1.625

			if var_87_11 < arg_84_1.time_ and arg_84_1.time_ <= var_87_11 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, false)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_13 = arg_84_1:GetWordFromCfg(417261020)
				local var_87_14 = arg_84_1:FormatText(var_87_13.content)

				arg_84_1.text_.text = var_87_14

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_15 = 65
				local var_87_16 = utf8.len(var_87_14)
				local var_87_17 = var_87_15 <= 0 and var_87_12 or var_87_12 * (var_87_16 / var_87_15)

				if var_87_17 > 0 and var_87_12 < var_87_17 then
					arg_84_1.talkMaxDuration = var_87_17

					if var_87_17 + var_87_11 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_17 + var_87_11
					end
				end

				arg_84_1.text_.text = var_87_14
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)
				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_18 = math.max(var_87_12, arg_84_1.talkMaxDuration)

			if var_87_11 <= arg_84_1.time_ and arg_84_1.time_ < var_87_11 + var_87_18 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_11) / var_87_18

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_11 + var_87_18 and arg_84_1.time_ < var_87_11 + var_87_18 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_84_1:InitPlayNodeList()
	end,
	Play417261021 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 417261021
		arg_88_1.duration_ = 5

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play417261022(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = 0
			local var_91_1 = 1.325

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

				local var_91_2 = arg_88_1:GetWordFromCfg(417261021)
				local var_91_3 = arg_88_1:FormatText(var_91_2.content)

				arg_88_1.text_.text = var_91_3

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_4 = 53
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
	Play417261022 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 417261022
		arg_92_1.duration_ = 5.53

		local var_92_0 = {
			zh = 2.833,
			ja = 5.533
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
				arg_92_0:Play417261023(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			local var_95_0 = "10111"

			if arg_92_1.actors_[var_95_0] == nil then
				local var_95_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10111")

				if not isNil(var_95_1) then
					local var_95_2 = Object.Instantiate(var_95_1, arg_92_1.canvasGo_.transform)

					var_95_2.transform:SetSiblingIndex(1)

					var_95_2.name = var_95_0
					var_95_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_92_1.actors_[var_95_0] = var_95_2

					local var_95_3 = var_95_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_92_1.isInRecall_ then
						for iter_95_0, iter_95_1 in ipairs(var_95_3) do
							iter_95_1.color = arg_92_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_95_4 = arg_92_1.actors_["10111"]
			local var_95_5 = 0

			if var_95_5 < arg_92_1.time_ and arg_92_1.time_ <= var_95_5 + arg_95_0 and not isNil(var_95_4) and arg_92_1.var_.actorSpriteComps10111 == nil then
				arg_92_1.var_.actorSpriteComps10111 = var_95_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_95_6 = 0.2

			if var_95_5 <= arg_92_1.time_ and arg_92_1.time_ < var_95_5 + var_95_6 and not isNil(var_95_4) then
				local var_95_7 = (arg_92_1.time_ - var_95_5) / var_95_6

				if arg_92_1.var_.actorSpriteComps10111 then
					for iter_95_2, iter_95_3 in pairs(arg_92_1.var_.actorSpriteComps10111:ToTable()) do
						if iter_95_3 then
							if arg_92_1.isInRecall_ then
								local var_95_8 = Mathf.Lerp(iter_95_3.color.r, arg_92_1.hightColor1.r, var_95_7)
								local var_95_9 = Mathf.Lerp(iter_95_3.color.g, arg_92_1.hightColor1.g, var_95_7)
								local var_95_10 = Mathf.Lerp(iter_95_3.color.b, arg_92_1.hightColor1.b, var_95_7)

								iter_95_3.color = Color.New(var_95_8, var_95_9, var_95_10)
							else
								local var_95_11 = Mathf.Lerp(iter_95_3.color.r, 1, var_95_7)

								iter_95_3.color = Color.New(var_95_11, var_95_11, var_95_11)
							end
						end
					end
				end
			end

			if arg_92_1.time_ >= var_95_5 + var_95_6 and arg_92_1.time_ < var_95_5 + var_95_6 + arg_95_0 and not isNil(var_95_4) and arg_92_1.var_.actorSpriteComps10111 then
				for iter_95_4, iter_95_5 in pairs(arg_92_1.var_.actorSpriteComps10111:ToTable()) do
					if iter_95_5 then
						if arg_92_1.isInRecall_ then
							iter_95_5.color = arg_92_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_95_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_92_1.var_.actorSpriteComps10111 = nil
			end

			local var_95_12 = arg_92_1.actors_["10111"].transform
			local var_95_13 = 0

			if var_95_13 < arg_92_1.time_ and arg_92_1.time_ <= var_95_13 + arg_95_0 then
				arg_92_1.var_.moveOldPos10111 = var_95_12.localPosition
				var_95_12.localScale = Vector3.New(1, 1, 1)

				arg_92_1:CheckSpriteTmpPos("10111", 3)

				local var_95_14 = var_95_12.childCount

				for iter_95_6 = 0, var_95_14 - 1 do
					local var_95_15 = var_95_12:GetChild(iter_95_6)

					if var_95_15.name == "split_2" or not string.find(var_95_15.name, "split") then
						var_95_15.gameObject:SetActive(true)
					else
						var_95_15.gameObject:SetActive(false)
					end
				end
			end

			local var_95_16 = 0.001

			if var_95_13 <= arg_92_1.time_ and arg_92_1.time_ < var_95_13 + var_95_16 then
				local var_95_17 = (arg_92_1.time_ - var_95_13) / var_95_16
				local var_95_18 = Vector3.New(0, -361.1, -274.6)

				var_95_12.localPosition = Vector3.Lerp(arg_92_1.var_.moveOldPos10111, var_95_18, var_95_17)
			end

			if arg_92_1.time_ >= var_95_13 + var_95_16 and arg_92_1.time_ < var_95_13 + var_95_16 + arg_95_0 then
				var_95_12.localPosition = Vector3.New(0, -361.1, -274.6)
			end

			local var_95_19 = 0
			local var_95_20 = 0.275

			if var_95_19 < arg_92_1.time_ and arg_92_1.time_ <= var_95_19 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				local var_95_21 = arg_92_1:FormatText(StoryNameCfg[1125].name)

				arg_92_1.leftNameTxt_.text = var_95_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_22 = arg_92_1:GetWordFromCfg(417261022)
				local var_95_23 = arg_92_1:FormatText(var_95_22.content)

				arg_92_1.text_.text = var_95_23

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_24 = 11
				local var_95_25 = utf8.len(var_95_23)
				local var_95_26 = var_95_24 <= 0 and var_95_20 or var_95_20 * (var_95_25 / var_95_24)

				if var_95_26 > 0 and var_95_20 < var_95_26 then
					arg_92_1.talkMaxDuration = var_95_26

					if var_95_26 + var_95_19 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_26 + var_95_19
					end
				end

				arg_92_1.text_.text = var_95_23
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417261", "417261022", "story_v_out_417261.awb") ~= 0 then
					local var_95_27 = manager.audio:GetVoiceLength("story_v_out_417261", "417261022", "story_v_out_417261.awb") / 1000

					if var_95_27 + var_95_19 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_27 + var_95_19
					end

					if var_95_22.prefab_name ~= "" and arg_92_1.actors_[var_95_22.prefab_name] ~= nil then
						local var_95_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_22.prefab_name].transform, "story_v_out_417261", "417261022", "story_v_out_417261.awb")

						arg_92_1:RecordAudio("417261022", var_95_28)
						arg_92_1:RecordAudio("417261022", var_95_28)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_out_417261", "417261022", "story_v_out_417261.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_out_417261", "417261022", "story_v_out_417261.awb")
				end

				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_29 = math.max(var_95_20, arg_92_1.talkMaxDuration)

			if var_95_19 <= arg_92_1.time_ and arg_92_1.time_ < var_95_19 + var_95_29 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_19) / var_95_29

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_19 + var_95_29 and arg_92_1.time_ < var_95_19 + var_95_29 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10111",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_92_1:InitPlayNodeList()
	end,
	Play417261023 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 417261023
		arg_96_1.duration_ = 4.4

		local var_96_0 = {
			zh = 2.8,
			ja = 4.4
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
				arg_96_0:Play417261024(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			local var_99_0 = arg_96_1.actors_["10111"]
			local var_99_1 = 0

			if var_99_1 < arg_96_1.time_ and arg_96_1.time_ <= var_99_1 + arg_99_0 and not isNil(var_99_0) and arg_96_1.var_.actorSpriteComps10111 == nil then
				arg_96_1.var_.actorSpriteComps10111 = var_99_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_99_2 = 0.2

			if var_99_1 <= arg_96_1.time_ and arg_96_1.time_ < var_99_1 + var_99_2 and not isNil(var_99_0) then
				local var_99_3 = (arg_96_1.time_ - var_99_1) / var_99_2

				if arg_96_1.var_.actorSpriteComps10111 then
					for iter_99_0, iter_99_1 in pairs(arg_96_1.var_.actorSpriteComps10111:ToTable()) do
						if iter_99_1 then
							if arg_96_1.isInRecall_ then
								local var_99_4 = Mathf.Lerp(iter_99_1.color.r, arg_96_1.hightColor2.r, var_99_3)
								local var_99_5 = Mathf.Lerp(iter_99_1.color.g, arg_96_1.hightColor2.g, var_99_3)
								local var_99_6 = Mathf.Lerp(iter_99_1.color.b, arg_96_1.hightColor2.b, var_99_3)

								iter_99_1.color = Color.New(var_99_4, var_99_5, var_99_6)
							else
								local var_99_7 = Mathf.Lerp(iter_99_1.color.r, 0.5, var_99_3)

								iter_99_1.color = Color.New(var_99_7, var_99_7, var_99_7)
							end
						end
					end
				end
			end

			if arg_96_1.time_ >= var_99_1 + var_99_2 and arg_96_1.time_ < var_99_1 + var_99_2 + arg_99_0 and not isNil(var_99_0) and arg_96_1.var_.actorSpriteComps10111 then
				for iter_99_2, iter_99_3 in pairs(arg_96_1.var_.actorSpriteComps10111:ToTable()) do
					if iter_99_3 then
						if arg_96_1.isInRecall_ then
							iter_99_3.color = arg_96_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_99_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_96_1.var_.actorSpriteComps10111 = nil
			end

			local var_99_8 = arg_96_1.actors_["1034"]
			local var_99_9 = 0

			if var_99_9 < arg_96_1.time_ and arg_96_1.time_ <= var_99_9 + arg_99_0 and not isNil(var_99_8) and arg_96_1.var_.actorSpriteComps1034 == nil then
				arg_96_1.var_.actorSpriteComps1034 = var_99_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_99_10 = 0.2

			if var_99_9 <= arg_96_1.time_ and arg_96_1.time_ < var_99_9 + var_99_10 and not isNil(var_99_8) then
				local var_99_11 = (arg_96_1.time_ - var_99_9) / var_99_10

				if arg_96_1.var_.actorSpriteComps1034 then
					for iter_99_4, iter_99_5 in pairs(arg_96_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_99_5 then
							if arg_96_1.isInRecall_ then
								local var_99_12 = Mathf.Lerp(iter_99_5.color.r, arg_96_1.hightColor1.r, var_99_11)
								local var_99_13 = Mathf.Lerp(iter_99_5.color.g, arg_96_1.hightColor1.g, var_99_11)
								local var_99_14 = Mathf.Lerp(iter_99_5.color.b, arg_96_1.hightColor1.b, var_99_11)

								iter_99_5.color = Color.New(var_99_12, var_99_13, var_99_14)
							else
								local var_99_15 = Mathf.Lerp(iter_99_5.color.r, 1, var_99_11)

								iter_99_5.color = Color.New(var_99_15, var_99_15, var_99_15)
							end
						end
					end
				end
			end

			if arg_96_1.time_ >= var_99_9 + var_99_10 and arg_96_1.time_ < var_99_9 + var_99_10 + arg_99_0 and not isNil(var_99_8) and arg_96_1.var_.actorSpriteComps1034 then
				for iter_99_6, iter_99_7 in pairs(arg_96_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_99_7 then
						if arg_96_1.isInRecall_ then
							iter_99_7.color = arg_96_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_99_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_96_1.var_.actorSpriteComps1034 = nil
			end

			local var_99_16 = arg_96_1.actors_["1034"].transform
			local var_99_17 = 0

			if var_99_17 < arg_96_1.time_ and arg_96_1.time_ <= var_99_17 + arg_99_0 then
				arg_96_1.var_.moveOldPos1034 = var_99_16.localPosition
				var_99_16.localScale = Vector3.New(1, 1, 1)

				arg_96_1:CheckSpriteTmpPos("1034", 4)

				local var_99_18 = var_99_16.childCount

				for iter_99_8 = 0, var_99_18 - 1 do
					local var_99_19 = var_99_16:GetChild(iter_99_8)

					if var_99_19.name == "split_1" or not string.find(var_99_19.name, "split") then
						var_99_19.gameObject:SetActive(true)
					else
						var_99_19.gameObject:SetActive(false)
					end
				end
			end

			local var_99_20 = 0.001

			if var_99_17 <= arg_96_1.time_ and arg_96_1.time_ < var_99_17 + var_99_20 then
				local var_99_21 = (arg_96_1.time_ - var_99_17) / var_99_20
				local var_99_22 = Vector3.New(373.7, -331.9, -324)

				var_99_16.localPosition = Vector3.Lerp(arg_96_1.var_.moveOldPos1034, var_99_22, var_99_21)
			end

			if arg_96_1.time_ >= var_99_17 + var_99_20 and arg_96_1.time_ < var_99_17 + var_99_20 + arg_99_0 then
				var_99_16.localPosition = Vector3.New(373.7, -331.9, -324)
			end

			local var_99_23 = arg_96_1.actors_["10111"].transform
			local var_99_24 = 0

			if var_99_24 < arg_96_1.time_ and arg_96_1.time_ <= var_99_24 + arg_99_0 then
				arg_96_1.var_.moveOldPos10111 = var_99_23.localPosition
				var_99_23.localScale = Vector3.New(1, 1, 1)

				arg_96_1:CheckSpriteTmpPos("10111", 2)

				local var_99_25 = var_99_23.childCount

				for iter_99_9 = 0, var_99_25 - 1 do
					local var_99_26 = var_99_23:GetChild(iter_99_9)

					if var_99_26.name == "" or not string.find(var_99_26.name, "split") then
						var_99_26.gameObject:SetActive(true)
					else
						var_99_26.gameObject:SetActive(false)
					end
				end
			end

			local var_99_27 = 0.001

			if var_99_24 <= arg_96_1.time_ and arg_96_1.time_ < var_99_24 + var_99_27 then
				local var_99_28 = (arg_96_1.time_ - var_99_24) / var_99_27
				local var_99_29 = Vector3.New(-390, -361.1, -274.6)

				var_99_23.localPosition = Vector3.Lerp(arg_96_1.var_.moveOldPos10111, var_99_29, var_99_28)
			end

			if arg_96_1.time_ >= var_99_24 + var_99_27 and arg_96_1.time_ < var_99_24 + var_99_27 + arg_99_0 then
				var_99_23.localPosition = Vector3.New(-390, -361.1, -274.6)
			end

			local var_99_30 = 0
			local var_99_31 = 0.225

			if var_99_30 < arg_96_1.time_ and arg_96_1.time_ <= var_99_30 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				local var_99_32 = arg_96_1:FormatText(StoryNameCfg[1109].name)

				arg_96_1.leftNameTxt_.text = var_99_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_33 = arg_96_1:GetWordFromCfg(417261023)
				local var_99_34 = arg_96_1:FormatText(var_99_33.content)

				arg_96_1.text_.text = var_99_34

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_35 = 9
				local var_99_36 = utf8.len(var_99_34)
				local var_99_37 = var_99_35 <= 0 and var_99_31 or var_99_31 * (var_99_36 / var_99_35)

				if var_99_37 > 0 and var_99_31 < var_99_37 then
					arg_96_1.talkMaxDuration = var_99_37

					if var_99_37 + var_99_30 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_37 + var_99_30
					end
				end

				arg_96_1.text_.text = var_99_34
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417261", "417261023", "story_v_out_417261.awb") ~= 0 then
					local var_99_38 = manager.audio:GetVoiceLength("story_v_out_417261", "417261023", "story_v_out_417261.awb") / 1000

					if var_99_38 + var_99_30 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_38 + var_99_30
					end

					if var_99_33.prefab_name ~= "" and arg_96_1.actors_[var_99_33.prefab_name] ~= nil then
						local var_99_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_96_1.actors_[var_99_33.prefab_name].transform, "story_v_out_417261", "417261023", "story_v_out_417261.awb")

						arg_96_1:RecordAudio("417261023", var_99_39)
						arg_96_1:RecordAudio("417261023", var_99_39)
					else
						arg_96_1:AudioAction("play", "voice", "story_v_out_417261", "417261023", "story_v_out_417261.awb")
					end

					arg_96_1:RecordHistoryTalkVoice("story_v_out_417261", "417261023", "story_v_out_417261.awb")
				end

				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_40 = math.max(var_99_31, arg_96_1.talkMaxDuration)

			if var_99_30 <= arg_96_1.time_ and arg_96_1.time_ < var_99_30 + var_99_40 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_30) / var_99_40

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_30 + var_99_40 and arg_96_1.time_ < var_99_30 + var_99_40 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10111",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_96_1:InitPlayNodeList()
	end,
	Play417261024 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 417261024
		arg_100_1.duration_ = 5.23

		local var_100_0 = {
			zh = 4.333,
			ja = 5.233
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
				arg_100_0:Play417261025(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			local var_103_0 = arg_100_1.actors_["10111"]
			local var_103_1 = 0

			if var_103_1 < arg_100_1.time_ and arg_100_1.time_ <= var_103_1 + arg_103_0 and not isNil(var_103_0) and arg_100_1.var_.actorSpriteComps10111 == nil then
				arg_100_1.var_.actorSpriteComps10111 = var_103_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_103_2 = 0.2

			if var_103_1 <= arg_100_1.time_ and arg_100_1.time_ < var_103_1 + var_103_2 and not isNil(var_103_0) then
				local var_103_3 = (arg_100_1.time_ - var_103_1) / var_103_2

				if arg_100_1.var_.actorSpriteComps10111 then
					for iter_103_0, iter_103_1 in pairs(arg_100_1.var_.actorSpriteComps10111:ToTable()) do
						if iter_103_1 then
							if arg_100_1.isInRecall_ then
								local var_103_4 = Mathf.Lerp(iter_103_1.color.r, arg_100_1.hightColor1.r, var_103_3)
								local var_103_5 = Mathf.Lerp(iter_103_1.color.g, arg_100_1.hightColor1.g, var_103_3)
								local var_103_6 = Mathf.Lerp(iter_103_1.color.b, arg_100_1.hightColor1.b, var_103_3)

								iter_103_1.color = Color.New(var_103_4, var_103_5, var_103_6)
							else
								local var_103_7 = Mathf.Lerp(iter_103_1.color.r, 1, var_103_3)

								iter_103_1.color = Color.New(var_103_7, var_103_7, var_103_7)
							end
						end
					end
				end
			end

			if arg_100_1.time_ >= var_103_1 + var_103_2 and arg_100_1.time_ < var_103_1 + var_103_2 + arg_103_0 and not isNil(var_103_0) and arg_100_1.var_.actorSpriteComps10111 then
				for iter_103_2, iter_103_3 in pairs(arg_100_1.var_.actorSpriteComps10111:ToTable()) do
					if iter_103_3 then
						if arg_100_1.isInRecall_ then
							iter_103_3.color = arg_100_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_103_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_100_1.var_.actorSpriteComps10111 = nil
			end

			local var_103_8 = arg_100_1.actors_["1034"]
			local var_103_9 = 0

			if var_103_9 < arg_100_1.time_ and arg_100_1.time_ <= var_103_9 + arg_103_0 and not isNil(var_103_8) and arg_100_1.var_.actorSpriteComps1034 == nil then
				arg_100_1.var_.actorSpriteComps1034 = var_103_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_103_10 = 0.2

			if var_103_9 <= arg_100_1.time_ and arg_100_1.time_ < var_103_9 + var_103_10 and not isNil(var_103_8) then
				local var_103_11 = (arg_100_1.time_ - var_103_9) / var_103_10

				if arg_100_1.var_.actorSpriteComps1034 then
					for iter_103_4, iter_103_5 in pairs(arg_100_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_103_5 then
							if arg_100_1.isInRecall_ then
								local var_103_12 = Mathf.Lerp(iter_103_5.color.r, arg_100_1.hightColor2.r, var_103_11)
								local var_103_13 = Mathf.Lerp(iter_103_5.color.g, arg_100_1.hightColor2.g, var_103_11)
								local var_103_14 = Mathf.Lerp(iter_103_5.color.b, arg_100_1.hightColor2.b, var_103_11)

								iter_103_5.color = Color.New(var_103_12, var_103_13, var_103_14)
							else
								local var_103_15 = Mathf.Lerp(iter_103_5.color.r, 0.5, var_103_11)

								iter_103_5.color = Color.New(var_103_15, var_103_15, var_103_15)
							end
						end
					end
				end
			end

			if arg_100_1.time_ >= var_103_9 + var_103_10 and arg_100_1.time_ < var_103_9 + var_103_10 + arg_103_0 and not isNil(var_103_8) and arg_100_1.var_.actorSpriteComps1034 then
				for iter_103_6, iter_103_7 in pairs(arg_100_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_103_7 then
						if arg_100_1.isInRecall_ then
							iter_103_7.color = arg_100_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_103_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_100_1.var_.actorSpriteComps1034 = nil
			end

			local var_103_16 = arg_100_1.actors_["10111"].transform
			local var_103_17 = 0

			if var_103_17 < arg_100_1.time_ and arg_100_1.time_ <= var_103_17 + arg_103_0 then
				arg_100_1.var_.moveOldPos10111 = var_103_16.localPosition
				var_103_16.localScale = Vector3.New(1, 1, 1)

				arg_100_1:CheckSpriteTmpPos("10111", 2)

				local var_103_18 = var_103_16.childCount

				for iter_103_8 = 0, var_103_18 - 1 do
					local var_103_19 = var_103_16:GetChild(iter_103_8)

					if var_103_19.name == "split_4" or not string.find(var_103_19.name, "split") then
						var_103_19.gameObject:SetActive(true)
					else
						var_103_19.gameObject:SetActive(false)
					end
				end
			end

			local var_103_20 = 0.001

			if var_103_17 <= arg_100_1.time_ and arg_100_1.time_ < var_103_17 + var_103_20 then
				local var_103_21 = (arg_100_1.time_ - var_103_17) / var_103_20
				local var_103_22 = Vector3.New(-390, -361.1, -274.6)

				var_103_16.localPosition = Vector3.Lerp(arg_100_1.var_.moveOldPos10111, var_103_22, var_103_21)
			end

			if arg_100_1.time_ >= var_103_17 + var_103_20 and arg_100_1.time_ < var_103_17 + var_103_20 + arg_103_0 then
				var_103_16.localPosition = Vector3.New(-390, -361.1, -274.6)
			end

			local var_103_23 = 0
			local var_103_24 = 0.55

			if var_103_23 < arg_100_1.time_ and arg_100_1.time_ <= var_103_23 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				local var_103_25 = arg_100_1:FormatText(StoryNameCfg[1125].name)

				arg_100_1.leftNameTxt_.text = var_103_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_26 = arg_100_1:GetWordFromCfg(417261024)
				local var_103_27 = arg_100_1:FormatText(var_103_26.content)

				arg_100_1.text_.text = var_103_27

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_28 = 22
				local var_103_29 = utf8.len(var_103_27)
				local var_103_30 = var_103_28 <= 0 and var_103_24 or var_103_24 * (var_103_29 / var_103_28)

				if var_103_30 > 0 and var_103_24 < var_103_30 then
					arg_100_1.talkMaxDuration = var_103_30

					if var_103_30 + var_103_23 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_30 + var_103_23
					end
				end

				arg_100_1.text_.text = var_103_27
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417261", "417261024", "story_v_out_417261.awb") ~= 0 then
					local var_103_31 = manager.audio:GetVoiceLength("story_v_out_417261", "417261024", "story_v_out_417261.awb") / 1000

					if var_103_31 + var_103_23 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_31 + var_103_23
					end

					if var_103_26.prefab_name ~= "" and arg_100_1.actors_[var_103_26.prefab_name] ~= nil then
						local var_103_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_100_1.actors_[var_103_26.prefab_name].transform, "story_v_out_417261", "417261024", "story_v_out_417261.awb")

						arg_100_1:RecordAudio("417261024", var_103_32)
						arg_100_1:RecordAudio("417261024", var_103_32)
					else
						arg_100_1:AudioAction("play", "voice", "story_v_out_417261", "417261024", "story_v_out_417261.awb")
					end

					arg_100_1:RecordHistoryTalkVoice("story_v_out_417261", "417261024", "story_v_out_417261.awb")
				end

				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_33 = math.max(var_103_24, arg_100_1.talkMaxDuration)

			if var_103_23 <= arg_100_1.time_ and arg_100_1.time_ < var_103_23 + var_103_33 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_23) / var_103_33

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_23 + var_103_33 and arg_100_1.time_ < var_103_23 + var_103_33 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10111",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_100_1:InitPlayNodeList()
	end,
	Play417261025 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 417261025
		arg_104_1.duration_ = 2.67

		local var_104_0 = {
			zh = 1.933,
			ja = 2.666
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
				arg_104_0:Play417261026(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			local var_107_0 = "1095"

			if arg_104_1.actors_[var_107_0] == nil then
				local var_107_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1095")

				if not isNil(var_107_1) then
					local var_107_2 = Object.Instantiate(var_107_1, arg_104_1.canvasGo_.transform)

					var_107_2.transform:SetSiblingIndex(1)

					var_107_2.name = var_107_0
					var_107_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_104_1.actors_[var_107_0] = var_107_2

					local var_107_3 = var_107_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_104_1.isInRecall_ then
						for iter_107_0, iter_107_1 in ipairs(var_107_3) do
							iter_107_1.color = arg_104_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_107_4 = arg_104_1.actors_["1095"]
			local var_107_5 = 0

			if var_107_5 < arg_104_1.time_ and arg_104_1.time_ <= var_107_5 + arg_107_0 and not isNil(var_107_4) and arg_104_1.var_.actorSpriteComps1095 == nil then
				arg_104_1.var_.actorSpriteComps1095 = var_107_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_107_6 = 0.2

			if var_107_5 <= arg_104_1.time_ and arg_104_1.time_ < var_107_5 + var_107_6 and not isNil(var_107_4) then
				local var_107_7 = (arg_104_1.time_ - var_107_5) / var_107_6

				if arg_104_1.var_.actorSpriteComps1095 then
					for iter_107_2, iter_107_3 in pairs(arg_104_1.var_.actorSpriteComps1095:ToTable()) do
						if iter_107_3 then
							if arg_104_1.isInRecall_ then
								local var_107_8 = Mathf.Lerp(iter_107_3.color.r, arg_104_1.hightColor1.r, var_107_7)
								local var_107_9 = Mathf.Lerp(iter_107_3.color.g, arg_104_1.hightColor1.g, var_107_7)
								local var_107_10 = Mathf.Lerp(iter_107_3.color.b, arg_104_1.hightColor1.b, var_107_7)

								iter_107_3.color = Color.New(var_107_8, var_107_9, var_107_10)
							else
								local var_107_11 = Mathf.Lerp(iter_107_3.color.r, 1, var_107_7)

								iter_107_3.color = Color.New(var_107_11, var_107_11, var_107_11)
							end
						end
					end
				end
			end

			if arg_104_1.time_ >= var_107_5 + var_107_6 and arg_104_1.time_ < var_107_5 + var_107_6 + arg_107_0 and not isNil(var_107_4) and arg_104_1.var_.actorSpriteComps1095 then
				for iter_107_4, iter_107_5 in pairs(arg_104_1.var_.actorSpriteComps1095:ToTable()) do
					if iter_107_5 then
						if arg_104_1.isInRecall_ then
							iter_107_5.color = arg_104_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_107_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_104_1.var_.actorSpriteComps1095 = nil
			end

			local var_107_12 = arg_104_1.actors_["10111"]
			local var_107_13 = 0

			if var_107_13 < arg_104_1.time_ and arg_104_1.time_ <= var_107_13 + arg_107_0 and not isNil(var_107_12) and arg_104_1.var_.actorSpriteComps10111 == nil then
				arg_104_1.var_.actorSpriteComps10111 = var_107_12:GetComponentsInChildren(typeof(Image), true)
			end

			local var_107_14 = 0.2

			if var_107_13 <= arg_104_1.time_ and arg_104_1.time_ < var_107_13 + var_107_14 and not isNil(var_107_12) then
				local var_107_15 = (arg_104_1.time_ - var_107_13) / var_107_14

				if arg_104_1.var_.actorSpriteComps10111 then
					for iter_107_6, iter_107_7 in pairs(arg_104_1.var_.actorSpriteComps10111:ToTable()) do
						if iter_107_7 then
							if arg_104_1.isInRecall_ then
								local var_107_16 = Mathf.Lerp(iter_107_7.color.r, arg_104_1.hightColor2.r, var_107_15)
								local var_107_17 = Mathf.Lerp(iter_107_7.color.g, arg_104_1.hightColor2.g, var_107_15)
								local var_107_18 = Mathf.Lerp(iter_107_7.color.b, arg_104_1.hightColor2.b, var_107_15)

								iter_107_7.color = Color.New(var_107_16, var_107_17, var_107_18)
							else
								local var_107_19 = Mathf.Lerp(iter_107_7.color.r, 0.5, var_107_15)

								iter_107_7.color = Color.New(var_107_19, var_107_19, var_107_19)
							end
						end
					end
				end
			end

			if arg_104_1.time_ >= var_107_13 + var_107_14 and arg_104_1.time_ < var_107_13 + var_107_14 + arg_107_0 and not isNil(var_107_12) and arg_104_1.var_.actorSpriteComps10111 then
				for iter_107_8, iter_107_9 in pairs(arg_104_1.var_.actorSpriteComps10111:ToTable()) do
					if iter_107_9 then
						if arg_104_1.isInRecall_ then
							iter_107_9.color = arg_104_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_107_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_104_1.var_.actorSpriteComps10111 = nil
			end

			local var_107_20 = arg_104_1.actors_["1034"].transform
			local var_107_21 = 0

			if var_107_21 < arg_104_1.time_ and arg_104_1.time_ <= var_107_21 + arg_107_0 then
				arg_104_1.var_.moveOldPos1034 = var_107_20.localPosition
				var_107_20.localScale = Vector3.New(1, 1, 1)

				arg_104_1:CheckSpriteTmpPos("1034", 7)

				local var_107_22 = var_107_20.childCount

				for iter_107_10 = 0, var_107_22 - 1 do
					local var_107_23 = var_107_20:GetChild(iter_107_10)

					if var_107_23.name == "" or not string.find(var_107_23.name, "split") then
						var_107_23.gameObject:SetActive(true)
					else
						var_107_23.gameObject:SetActive(false)
					end
				end
			end

			local var_107_24 = 0.001

			if var_107_21 <= arg_104_1.time_ and arg_104_1.time_ < var_107_21 + var_107_24 then
				local var_107_25 = (arg_104_1.time_ - var_107_21) / var_107_24
				local var_107_26 = Vector3.New(0, -2000, 0)

				var_107_20.localPosition = Vector3.Lerp(arg_104_1.var_.moveOldPos1034, var_107_26, var_107_25)
			end

			if arg_104_1.time_ >= var_107_21 + var_107_24 and arg_104_1.time_ < var_107_21 + var_107_24 + arg_107_0 then
				var_107_20.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_107_27 = arg_104_1.actors_["1095"].transform
			local var_107_28 = 0

			if var_107_28 < arg_104_1.time_ and arg_104_1.time_ <= var_107_28 + arg_107_0 then
				arg_104_1.var_.moveOldPos1095 = var_107_27.localPosition
				var_107_27.localScale = Vector3.New(1, 1, 1)

				arg_104_1:CheckSpriteTmpPos("1095", 4)

				local var_107_29 = var_107_27.childCount

				for iter_107_11 = 0, var_107_29 - 1 do
					local var_107_30 = var_107_27:GetChild(iter_107_11)

					if var_107_30.name == "split_2" or not string.find(var_107_30.name, "split") then
						var_107_30.gameObject:SetActive(true)
					else
						var_107_30.gameObject:SetActive(false)
					end
				end
			end

			local var_107_31 = 0.001

			if var_107_28 <= arg_104_1.time_ and arg_104_1.time_ < var_107_28 + var_107_31 then
				local var_107_32 = (arg_104_1.time_ - var_107_28) / var_107_31
				local var_107_33 = Vector3.New(390, -340, -285)

				var_107_27.localPosition = Vector3.Lerp(arg_104_1.var_.moveOldPos1095, var_107_33, var_107_32)
			end

			if arg_104_1.time_ >= var_107_28 + var_107_31 and arg_104_1.time_ < var_107_28 + var_107_31 + arg_107_0 then
				var_107_27.localPosition = Vector3.New(390, -340, -285)
			end

			local var_107_34 = 0
			local var_107_35 = 0.175

			if var_107_34 < arg_104_1.time_ and arg_104_1.time_ <= var_107_34 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				local var_107_36 = arg_104_1:FormatText(StoryNameCfg[471].name)

				arg_104_1.leftNameTxt_.text = var_107_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_37 = arg_104_1:GetWordFromCfg(417261025)
				local var_107_38 = arg_104_1:FormatText(var_107_37.content)

				arg_104_1.text_.text = var_107_38

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_39 = 7
				local var_107_40 = utf8.len(var_107_38)
				local var_107_41 = var_107_39 <= 0 and var_107_35 or var_107_35 * (var_107_40 / var_107_39)

				if var_107_41 > 0 and var_107_35 < var_107_41 then
					arg_104_1.talkMaxDuration = var_107_41

					if var_107_41 + var_107_34 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_41 + var_107_34
					end
				end

				arg_104_1.text_.text = var_107_38
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417261", "417261025", "story_v_out_417261.awb") ~= 0 then
					local var_107_42 = manager.audio:GetVoiceLength("story_v_out_417261", "417261025", "story_v_out_417261.awb") / 1000

					if var_107_42 + var_107_34 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_42 + var_107_34
					end

					if var_107_37.prefab_name ~= "" and arg_104_1.actors_[var_107_37.prefab_name] ~= nil then
						local var_107_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_104_1.actors_[var_107_37.prefab_name].transform, "story_v_out_417261", "417261025", "story_v_out_417261.awb")

						arg_104_1:RecordAudio("417261025", var_107_43)
						arg_104_1:RecordAudio("417261025", var_107_43)
					else
						arg_104_1:AudioAction("play", "voice", "story_v_out_417261", "417261025", "story_v_out_417261.awb")
					end

					arg_104_1:RecordHistoryTalkVoice("story_v_out_417261", "417261025", "story_v_out_417261.awb")
				end

				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_44 = math.max(var_107_35, arg_104_1.talkMaxDuration)

			if var_107_34 <= arg_104_1.time_ and arg_104_1.time_ < var_107_34 + var_107_44 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_34) / var_107_44

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_34 + var_107_44 and arg_104_1.time_ < var_107_34 + var_107_44 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1095",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_104_1:InitPlayNodeList()
	end,
	Play417261026 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 417261026
		arg_108_1.duration_ = 7.67

		local var_108_0 = {
			zh = 4.333,
			ja = 7.666
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
				arg_108_0:Play417261027(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			local var_111_0 = arg_108_1.actors_["1095"].transform
			local var_111_1 = 0

			if var_111_1 < arg_108_1.time_ and arg_108_1.time_ <= var_111_1 + arg_111_0 then
				arg_108_1.var_.moveOldPos1095 = var_111_0.localPosition
				var_111_0.localScale = Vector3.New(1, 1, 1)

				arg_108_1:CheckSpriteTmpPos("1095", 7)

				local var_111_2 = var_111_0.childCount

				for iter_111_0 = 0, var_111_2 - 1 do
					local var_111_3 = var_111_0:GetChild(iter_111_0)

					if var_111_3.name == "" or not string.find(var_111_3.name, "split") then
						var_111_3.gameObject:SetActive(true)
					else
						var_111_3.gameObject:SetActive(false)
					end
				end
			end

			local var_111_4 = 0.001

			if var_111_1 <= arg_108_1.time_ and arg_108_1.time_ < var_111_1 + var_111_4 then
				local var_111_5 = (arg_108_1.time_ - var_111_1) / var_111_4
				local var_111_6 = Vector3.New(0, -2000, 0)

				var_111_0.localPosition = Vector3.Lerp(arg_108_1.var_.moveOldPos1095, var_111_6, var_111_5)
			end

			if arg_108_1.time_ >= var_111_1 + var_111_4 and arg_108_1.time_ < var_111_1 + var_111_4 + arg_111_0 then
				var_111_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_111_7 = arg_108_1.actors_["1034"].transform
			local var_111_8 = 0

			if var_111_8 < arg_108_1.time_ and arg_108_1.time_ <= var_111_8 + arg_111_0 then
				arg_108_1.var_.moveOldPos1034 = var_111_7.localPosition
				var_111_7.localScale = Vector3.New(1, 1, 1)

				arg_108_1:CheckSpriteTmpPos("1034", 4)

				local var_111_9 = var_111_7.childCount

				for iter_111_1 = 0, var_111_9 - 1 do
					local var_111_10 = var_111_7:GetChild(iter_111_1)

					if var_111_10.name == "" or not string.find(var_111_10.name, "split") then
						var_111_10.gameObject:SetActive(true)
					else
						var_111_10.gameObject:SetActive(false)
					end
				end
			end

			local var_111_11 = 0.001

			if var_111_8 <= arg_108_1.time_ and arg_108_1.time_ < var_111_8 + var_111_11 then
				local var_111_12 = (arg_108_1.time_ - var_111_8) / var_111_11
				local var_111_13 = Vector3.New(373.7, -331.9, -324)

				var_111_7.localPosition = Vector3.Lerp(arg_108_1.var_.moveOldPos1034, var_111_13, var_111_12)
			end

			if arg_108_1.time_ >= var_111_8 + var_111_11 and arg_108_1.time_ < var_111_8 + var_111_11 + arg_111_0 then
				var_111_7.localPosition = Vector3.New(373.7, -331.9, -324)
			end

			local var_111_14 = arg_108_1.actors_["1034"]
			local var_111_15 = 0

			if var_111_15 < arg_108_1.time_ and arg_108_1.time_ <= var_111_15 + arg_111_0 and not isNil(var_111_14) and arg_108_1.var_.actorSpriteComps1034 == nil then
				arg_108_1.var_.actorSpriteComps1034 = var_111_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_111_16 = 0.2

			if var_111_15 <= arg_108_1.time_ and arg_108_1.time_ < var_111_15 + var_111_16 and not isNil(var_111_14) then
				local var_111_17 = (arg_108_1.time_ - var_111_15) / var_111_16

				if arg_108_1.var_.actorSpriteComps1034 then
					for iter_111_2, iter_111_3 in pairs(arg_108_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_111_3 then
							if arg_108_1.isInRecall_ then
								local var_111_18 = Mathf.Lerp(iter_111_3.color.r, arg_108_1.hightColor1.r, var_111_17)
								local var_111_19 = Mathf.Lerp(iter_111_3.color.g, arg_108_1.hightColor1.g, var_111_17)
								local var_111_20 = Mathf.Lerp(iter_111_3.color.b, arg_108_1.hightColor1.b, var_111_17)

								iter_111_3.color = Color.New(var_111_18, var_111_19, var_111_20)
							else
								local var_111_21 = Mathf.Lerp(iter_111_3.color.r, 1, var_111_17)

								iter_111_3.color = Color.New(var_111_21, var_111_21, var_111_21)
							end
						end
					end
				end
			end

			if arg_108_1.time_ >= var_111_15 + var_111_16 and arg_108_1.time_ < var_111_15 + var_111_16 + arg_111_0 and not isNil(var_111_14) and arg_108_1.var_.actorSpriteComps1034 then
				for iter_111_4, iter_111_5 in pairs(arg_108_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_111_5 then
						if arg_108_1.isInRecall_ then
							iter_111_5.color = arg_108_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_111_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_108_1.var_.actorSpriteComps1034 = nil
			end

			local var_111_22 = 0
			local var_111_23 = 0.625

			if var_111_22 < arg_108_1.time_ and arg_108_1.time_ <= var_111_22 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				local var_111_24 = arg_108_1:FormatText(StoryNameCfg[1109].name)

				arg_108_1.leftNameTxt_.text = var_111_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_25 = arg_108_1:GetWordFromCfg(417261026)
				local var_111_26 = arg_108_1:FormatText(var_111_25.content)

				arg_108_1.text_.text = var_111_26

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_27 = 25
				local var_111_28 = utf8.len(var_111_26)
				local var_111_29 = var_111_27 <= 0 and var_111_23 or var_111_23 * (var_111_28 / var_111_27)

				if var_111_29 > 0 and var_111_23 < var_111_29 then
					arg_108_1.talkMaxDuration = var_111_29

					if var_111_29 + var_111_22 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_29 + var_111_22
					end
				end

				arg_108_1.text_.text = var_111_26
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417261", "417261026", "story_v_out_417261.awb") ~= 0 then
					local var_111_30 = manager.audio:GetVoiceLength("story_v_out_417261", "417261026", "story_v_out_417261.awb") / 1000

					if var_111_30 + var_111_22 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_30 + var_111_22
					end

					if var_111_25.prefab_name ~= "" and arg_108_1.actors_[var_111_25.prefab_name] ~= nil then
						local var_111_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_108_1.actors_[var_111_25.prefab_name].transform, "story_v_out_417261", "417261026", "story_v_out_417261.awb")

						arg_108_1:RecordAudio("417261026", var_111_31)
						arg_108_1:RecordAudio("417261026", var_111_31)
					else
						arg_108_1:AudioAction("play", "voice", "story_v_out_417261", "417261026", "story_v_out_417261.awb")
					end

					arg_108_1:RecordHistoryTalkVoice("story_v_out_417261", "417261026", "story_v_out_417261.awb")
				end

				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_32 = math.max(var_111_23, arg_108_1.talkMaxDuration)

			if var_111_22 <= arg_108_1.time_ and arg_108_1.time_ < var_111_22 + var_111_32 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_22) / var_111_32

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_22 + var_111_32 and arg_108_1.time_ < var_111_22 + var_111_32 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_108_1:InitPlayNodeList()
	end,
	Play417261027 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 417261027
		arg_112_1.duration_ = 5

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
		end

		function arg_112_1.playNext_(arg_114_0)
			if arg_114_0 == 1 then
				arg_112_0:Play417261028(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			local var_115_0 = arg_112_1.actors_["1034"]
			local var_115_1 = 0

			if var_115_1 < arg_112_1.time_ and arg_112_1.time_ <= var_115_1 + arg_115_0 and not isNil(var_115_0) and arg_112_1.var_.actorSpriteComps1034 == nil then
				arg_112_1.var_.actorSpriteComps1034 = var_115_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_115_2 = 0.2

			if var_115_1 <= arg_112_1.time_ and arg_112_1.time_ < var_115_1 + var_115_2 and not isNil(var_115_0) then
				local var_115_3 = (arg_112_1.time_ - var_115_1) / var_115_2

				if arg_112_1.var_.actorSpriteComps1034 then
					for iter_115_0, iter_115_1 in pairs(arg_112_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_115_1 then
							if arg_112_1.isInRecall_ then
								local var_115_4 = Mathf.Lerp(iter_115_1.color.r, arg_112_1.hightColor2.r, var_115_3)
								local var_115_5 = Mathf.Lerp(iter_115_1.color.g, arg_112_1.hightColor2.g, var_115_3)
								local var_115_6 = Mathf.Lerp(iter_115_1.color.b, arg_112_1.hightColor2.b, var_115_3)

								iter_115_1.color = Color.New(var_115_4, var_115_5, var_115_6)
							else
								local var_115_7 = Mathf.Lerp(iter_115_1.color.r, 0.5, var_115_3)

								iter_115_1.color = Color.New(var_115_7, var_115_7, var_115_7)
							end
						end
					end
				end
			end

			if arg_112_1.time_ >= var_115_1 + var_115_2 and arg_112_1.time_ < var_115_1 + var_115_2 + arg_115_0 and not isNil(var_115_0) and arg_112_1.var_.actorSpriteComps1034 then
				for iter_115_2, iter_115_3 in pairs(arg_112_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_115_3 then
						if arg_112_1.isInRecall_ then
							iter_115_3.color = arg_112_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_115_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_112_1.var_.actorSpriteComps1034 = nil
			end

			local var_115_8 = 0
			local var_115_9 = 1

			if var_115_8 < arg_112_1.time_ and arg_112_1.time_ <= var_115_8 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, false)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_10 = arg_112_1:GetWordFromCfg(417261027)
				local var_115_11 = arg_112_1:FormatText(var_115_10.content)

				arg_112_1.text_.text = var_115_11

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_12 = 40
				local var_115_13 = utf8.len(var_115_11)
				local var_115_14 = var_115_12 <= 0 and var_115_9 or var_115_9 * (var_115_13 / var_115_12)

				if var_115_14 > 0 and var_115_9 < var_115_14 then
					arg_112_1.talkMaxDuration = var_115_14

					if var_115_14 + var_115_8 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_14 + var_115_8
					end
				end

				arg_112_1.text_.text = var_115_11
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)
				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_15 = math.max(var_115_9, arg_112_1.talkMaxDuration)

			if var_115_8 <= arg_112_1.time_ and arg_112_1.time_ < var_115_8 + var_115_15 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_8) / var_115_15

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_8 + var_115_15 and arg_112_1.time_ < var_115_8 + var_115_15 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {}

		arg_112_1:InitPlayNodeList()
	end,
	Play417261028 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 417261028
		arg_116_1.duration_ = 7.3

		local var_116_0 = {
			zh = 2.833,
			ja = 7.3
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
				arg_116_0:Play417261029(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			local var_119_0 = arg_116_1.actors_["1034"]
			local var_119_1 = 0

			if var_119_1 < arg_116_1.time_ and arg_116_1.time_ <= var_119_1 + arg_119_0 and not isNil(var_119_0) and arg_116_1.var_.actorSpriteComps1034 == nil then
				arg_116_1.var_.actorSpriteComps1034 = var_119_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_119_2 = 0.2

			if var_119_1 <= arg_116_1.time_ and arg_116_1.time_ < var_119_1 + var_119_2 and not isNil(var_119_0) then
				local var_119_3 = (arg_116_1.time_ - var_119_1) / var_119_2

				if arg_116_1.var_.actorSpriteComps1034 then
					for iter_119_0, iter_119_1 in pairs(arg_116_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_119_1 then
							if arg_116_1.isInRecall_ then
								local var_119_4 = Mathf.Lerp(iter_119_1.color.r, arg_116_1.hightColor1.r, var_119_3)
								local var_119_5 = Mathf.Lerp(iter_119_1.color.g, arg_116_1.hightColor1.g, var_119_3)
								local var_119_6 = Mathf.Lerp(iter_119_1.color.b, arg_116_1.hightColor1.b, var_119_3)

								iter_119_1.color = Color.New(var_119_4, var_119_5, var_119_6)
							else
								local var_119_7 = Mathf.Lerp(iter_119_1.color.r, 1, var_119_3)

								iter_119_1.color = Color.New(var_119_7, var_119_7, var_119_7)
							end
						end
					end
				end
			end

			if arg_116_1.time_ >= var_119_1 + var_119_2 and arg_116_1.time_ < var_119_1 + var_119_2 + arg_119_0 and not isNil(var_119_0) and arg_116_1.var_.actorSpriteComps1034 then
				for iter_119_2, iter_119_3 in pairs(arg_116_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_119_3 then
						if arg_116_1.isInRecall_ then
							iter_119_3.color = arg_116_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_119_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_116_1.var_.actorSpriteComps1034 = nil
			end

			local var_119_8 = 0
			local var_119_9 = 0.375

			if var_119_8 < arg_116_1.time_ and arg_116_1.time_ <= var_119_8 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				local var_119_10 = arg_116_1:FormatText(StoryNameCfg[1109].name)

				arg_116_1.leftNameTxt_.text = var_119_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_11 = arg_116_1:GetWordFromCfg(417261028)
				local var_119_12 = arg_116_1:FormatText(var_119_11.content)

				arg_116_1.text_.text = var_119_12

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_13 = 15
				local var_119_14 = utf8.len(var_119_12)
				local var_119_15 = var_119_13 <= 0 and var_119_9 or var_119_9 * (var_119_14 / var_119_13)

				if var_119_15 > 0 and var_119_9 < var_119_15 then
					arg_116_1.talkMaxDuration = var_119_15

					if var_119_15 + var_119_8 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_15 + var_119_8
					end
				end

				arg_116_1.text_.text = var_119_12
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417261", "417261028", "story_v_out_417261.awb") ~= 0 then
					local var_119_16 = manager.audio:GetVoiceLength("story_v_out_417261", "417261028", "story_v_out_417261.awb") / 1000

					if var_119_16 + var_119_8 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_16 + var_119_8
					end

					if var_119_11.prefab_name ~= "" and arg_116_1.actors_[var_119_11.prefab_name] ~= nil then
						local var_119_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_116_1.actors_[var_119_11.prefab_name].transform, "story_v_out_417261", "417261028", "story_v_out_417261.awb")

						arg_116_1:RecordAudio("417261028", var_119_17)
						arg_116_1:RecordAudio("417261028", var_119_17)
					else
						arg_116_1:AudioAction("play", "voice", "story_v_out_417261", "417261028", "story_v_out_417261.awb")
					end

					arg_116_1:RecordHistoryTalkVoice("story_v_out_417261", "417261028", "story_v_out_417261.awb")
				end

				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_18 = math.max(var_119_9, arg_116_1.talkMaxDuration)

			if var_119_8 <= arg_116_1.time_ and arg_116_1.time_ < var_119_8 + var_119_18 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_8) / var_119_18

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_8 + var_119_18 and arg_116_1.time_ < var_119_8 + var_119_18 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {}

		arg_116_1:InitPlayNodeList()
	end,
	Play417261029 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 417261029
		arg_120_1.duration_ = 3.83

		local var_120_0 = {
			zh = 2.333,
			ja = 3.833
		}
		local var_120_1 = manager.audio:GetLocalizationFlag()

		if var_120_0[var_120_1] ~= nil then
			arg_120_1.duration_ = var_120_0[var_120_1]
		end

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"
		end

		function arg_120_1.playNext_(arg_122_0)
			if arg_122_0 == 1 then
				arg_120_0:Play417261030(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			local var_123_0 = arg_120_1.actors_["10111"]
			local var_123_1 = 0

			if var_123_1 < arg_120_1.time_ and arg_120_1.time_ <= var_123_1 + arg_123_0 and not isNil(var_123_0) and arg_120_1.var_.actorSpriteComps10111 == nil then
				arg_120_1.var_.actorSpriteComps10111 = var_123_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_123_2 = 0.2

			if var_123_1 <= arg_120_1.time_ and arg_120_1.time_ < var_123_1 + var_123_2 and not isNil(var_123_0) then
				local var_123_3 = (arg_120_1.time_ - var_123_1) / var_123_2

				if arg_120_1.var_.actorSpriteComps10111 then
					for iter_123_0, iter_123_1 in pairs(arg_120_1.var_.actorSpriteComps10111:ToTable()) do
						if iter_123_1 then
							if arg_120_1.isInRecall_ then
								local var_123_4 = Mathf.Lerp(iter_123_1.color.r, arg_120_1.hightColor1.r, var_123_3)
								local var_123_5 = Mathf.Lerp(iter_123_1.color.g, arg_120_1.hightColor1.g, var_123_3)
								local var_123_6 = Mathf.Lerp(iter_123_1.color.b, arg_120_1.hightColor1.b, var_123_3)

								iter_123_1.color = Color.New(var_123_4, var_123_5, var_123_6)
							else
								local var_123_7 = Mathf.Lerp(iter_123_1.color.r, 1, var_123_3)

								iter_123_1.color = Color.New(var_123_7, var_123_7, var_123_7)
							end
						end
					end
				end
			end

			if arg_120_1.time_ >= var_123_1 + var_123_2 and arg_120_1.time_ < var_123_1 + var_123_2 + arg_123_0 and not isNil(var_123_0) and arg_120_1.var_.actorSpriteComps10111 then
				for iter_123_2, iter_123_3 in pairs(arg_120_1.var_.actorSpriteComps10111:ToTable()) do
					if iter_123_3 then
						if arg_120_1.isInRecall_ then
							iter_123_3.color = arg_120_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_123_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_120_1.var_.actorSpriteComps10111 = nil
			end

			local var_123_8 = arg_120_1.actors_["1034"]
			local var_123_9 = 0

			if var_123_9 < arg_120_1.time_ and arg_120_1.time_ <= var_123_9 + arg_123_0 and not isNil(var_123_8) and arg_120_1.var_.actorSpriteComps1034 == nil then
				arg_120_1.var_.actorSpriteComps1034 = var_123_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_123_10 = 0.2

			if var_123_9 <= arg_120_1.time_ and arg_120_1.time_ < var_123_9 + var_123_10 and not isNil(var_123_8) then
				local var_123_11 = (arg_120_1.time_ - var_123_9) / var_123_10

				if arg_120_1.var_.actorSpriteComps1034 then
					for iter_123_4, iter_123_5 in pairs(arg_120_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_123_5 then
							if arg_120_1.isInRecall_ then
								local var_123_12 = Mathf.Lerp(iter_123_5.color.r, arg_120_1.hightColor2.r, var_123_11)
								local var_123_13 = Mathf.Lerp(iter_123_5.color.g, arg_120_1.hightColor2.g, var_123_11)
								local var_123_14 = Mathf.Lerp(iter_123_5.color.b, arg_120_1.hightColor2.b, var_123_11)

								iter_123_5.color = Color.New(var_123_12, var_123_13, var_123_14)
							else
								local var_123_15 = Mathf.Lerp(iter_123_5.color.r, 0.5, var_123_11)

								iter_123_5.color = Color.New(var_123_15, var_123_15, var_123_15)
							end
						end
					end
				end
			end

			if arg_120_1.time_ >= var_123_9 + var_123_10 and arg_120_1.time_ < var_123_9 + var_123_10 + arg_123_0 and not isNil(var_123_8) and arg_120_1.var_.actorSpriteComps1034 then
				for iter_123_6, iter_123_7 in pairs(arg_120_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_123_7 then
						if arg_120_1.isInRecall_ then
							iter_123_7.color = arg_120_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_123_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_120_1.var_.actorSpriteComps1034 = nil
			end

			local var_123_16 = 0
			local var_123_17 = 0.325

			if var_123_16 < arg_120_1.time_ and arg_120_1.time_ <= var_123_16 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				local var_123_18 = arg_120_1:FormatText(StoryNameCfg[1125].name)

				arg_120_1.leftNameTxt_.text = var_123_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_19 = arg_120_1:GetWordFromCfg(417261029)
				local var_123_20 = arg_120_1:FormatText(var_123_19.content)

				arg_120_1.text_.text = var_123_20

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_21 = 13
				local var_123_22 = utf8.len(var_123_20)
				local var_123_23 = var_123_21 <= 0 and var_123_17 or var_123_17 * (var_123_22 / var_123_21)

				if var_123_23 > 0 and var_123_17 < var_123_23 then
					arg_120_1.talkMaxDuration = var_123_23

					if var_123_23 + var_123_16 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_23 + var_123_16
					end
				end

				arg_120_1.text_.text = var_123_20
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417261", "417261029", "story_v_out_417261.awb") ~= 0 then
					local var_123_24 = manager.audio:GetVoiceLength("story_v_out_417261", "417261029", "story_v_out_417261.awb") / 1000

					if var_123_24 + var_123_16 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_24 + var_123_16
					end

					if var_123_19.prefab_name ~= "" and arg_120_1.actors_[var_123_19.prefab_name] ~= nil then
						local var_123_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_120_1.actors_[var_123_19.prefab_name].transform, "story_v_out_417261", "417261029", "story_v_out_417261.awb")

						arg_120_1:RecordAudio("417261029", var_123_25)
						arg_120_1:RecordAudio("417261029", var_123_25)
					else
						arg_120_1:AudioAction("play", "voice", "story_v_out_417261", "417261029", "story_v_out_417261.awb")
					end

					arg_120_1:RecordHistoryTalkVoice("story_v_out_417261", "417261029", "story_v_out_417261.awb")
				end

				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_26 = math.max(var_123_17, arg_120_1.talkMaxDuration)

			if var_123_16 <= arg_120_1.time_ and arg_120_1.time_ < var_123_16 + var_123_26 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_16) / var_123_26

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_16 + var_123_26 and arg_120_1.time_ < var_123_16 + var_123_26 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {}

		arg_120_1:InitPlayNodeList()
	end,
	Play417261030 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 417261030
		arg_124_1.duration_ = 5.33

		local var_124_0 = {
			zh = 4.366,
			ja = 5.333
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
				arg_124_0:Play417261031(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			local var_127_0 = arg_124_1.actors_["10111"]
			local var_127_1 = 0

			if var_127_1 < arg_124_1.time_ and arg_124_1.time_ <= var_127_1 + arg_127_0 and not isNil(var_127_0) and arg_124_1.var_.actorSpriteComps10111 == nil then
				arg_124_1.var_.actorSpriteComps10111 = var_127_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_127_2 = 0.2

			if var_127_1 <= arg_124_1.time_ and arg_124_1.time_ < var_127_1 + var_127_2 and not isNil(var_127_0) then
				local var_127_3 = (arg_124_1.time_ - var_127_1) / var_127_2

				if arg_124_1.var_.actorSpriteComps10111 then
					for iter_127_0, iter_127_1 in pairs(arg_124_1.var_.actorSpriteComps10111:ToTable()) do
						if iter_127_1 then
							if arg_124_1.isInRecall_ then
								local var_127_4 = Mathf.Lerp(iter_127_1.color.r, arg_124_1.hightColor2.r, var_127_3)
								local var_127_5 = Mathf.Lerp(iter_127_1.color.g, arg_124_1.hightColor2.g, var_127_3)
								local var_127_6 = Mathf.Lerp(iter_127_1.color.b, arg_124_1.hightColor2.b, var_127_3)

								iter_127_1.color = Color.New(var_127_4, var_127_5, var_127_6)
							else
								local var_127_7 = Mathf.Lerp(iter_127_1.color.r, 0.5, var_127_3)

								iter_127_1.color = Color.New(var_127_7, var_127_7, var_127_7)
							end
						end
					end
				end
			end

			if arg_124_1.time_ >= var_127_1 + var_127_2 and arg_124_1.time_ < var_127_1 + var_127_2 + arg_127_0 and not isNil(var_127_0) and arg_124_1.var_.actorSpriteComps10111 then
				for iter_127_2, iter_127_3 in pairs(arg_124_1.var_.actorSpriteComps10111:ToTable()) do
					if iter_127_3 then
						if arg_124_1.isInRecall_ then
							iter_127_3.color = arg_124_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_127_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_124_1.var_.actorSpriteComps10111 = nil
			end

			local var_127_8 = arg_124_1.actors_["1034"]
			local var_127_9 = 0

			if var_127_9 < arg_124_1.time_ and arg_124_1.time_ <= var_127_9 + arg_127_0 and not isNil(var_127_8) and arg_124_1.var_.actorSpriteComps1034 == nil then
				arg_124_1.var_.actorSpriteComps1034 = var_127_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_127_10 = 0.2

			if var_127_9 <= arg_124_1.time_ and arg_124_1.time_ < var_127_9 + var_127_10 and not isNil(var_127_8) then
				local var_127_11 = (arg_124_1.time_ - var_127_9) / var_127_10

				if arg_124_1.var_.actorSpriteComps1034 then
					for iter_127_4, iter_127_5 in pairs(arg_124_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_127_5 then
							if arg_124_1.isInRecall_ then
								local var_127_12 = Mathf.Lerp(iter_127_5.color.r, arg_124_1.hightColor1.r, var_127_11)
								local var_127_13 = Mathf.Lerp(iter_127_5.color.g, arg_124_1.hightColor1.g, var_127_11)
								local var_127_14 = Mathf.Lerp(iter_127_5.color.b, arg_124_1.hightColor1.b, var_127_11)

								iter_127_5.color = Color.New(var_127_12, var_127_13, var_127_14)
							else
								local var_127_15 = Mathf.Lerp(iter_127_5.color.r, 1, var_127_11)

								iter_127_5.color = Color.New(var_127_15, var_127_15, var_127_15)
							end
						end
					end
				end
			end

			if arg_124_1.time_ >= var_127_9 + var_127_10 and arg_124_1.time_ < var_127_9 + var_127_10 + arg_127_0 and not isNil(var_127_8) and arg_124_1.var_.actorSpriteComps1034 then
				for iter_127_6, iter_127_7 in pairs(arg_124_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_127_7 then
						if arg_124_1.isInRecall_ then
							iter_127_7.color = arg_124_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_127_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_124_1.var_.actorSpriteComps1034 = nil
			end

			local var_127_16 = 0
			local var_127_17 = 0.475

			if var_127_16 < arg_124_1.time_ and arg_124_1.time_ <= var_127_16 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				local var_127_18 = arg_124_1:FormatText(StoryNameCfg[1109].name)

				arg_124_1.leftNameTxt_.text = var_127_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_19 = arg_124_1:GetWordFromCfg(417261030)
				local var_127_20 = arg_124_1:FormatText(var_127_19.content)

				arg_124_1.text_.text = var_127_20

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_21 = 19
				local var_127_22 = utf8.len(var_127_20)
				local var_127_23 = var_127_21 <= 0 and var_127_17 or var_127_17 * (var_127_22 / var_127_21)

				if var_127_23 > 0 and var_127_17 < var_127_23 then
					arg_124_1.talkMaxDuration = var_127_23

					if var_127_23 + var_127_16 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_23 + var_127_16
					end
				end

				arg_124_1.text_.text = var_127_20
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417261", "417261030", "story_v_out_417261.awb") ~= 0 then
					local var_127_24 = manager.audio:GetVoiceLength("story_v_out_417261", "417261030", "story_v_out_417261.awb") / 1000

					if var_127_24 + var_127_16 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_24 + var_127_16
					end

					if var_127_19.prefab_name ~= "" and arg_124_1.actors_[var_127_19.prefab_name] ~= nil then
						local var_127_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_124_1.actors_[var_127_19.prefab_name].transform, "story_v_out_417261", "417261030", "story_v_out_417261.awb")

						arg_124_1:RecordAudio("417261030", var_127_25)
						arg_124_1:RecordAudio("417261030", var_127_25)
					else
						arg_124_1:AudioAction("play", "voice", "story_v_out_417261", "417261030", "story_v_out_417261.awb")
					end

					arg_124_1:RecordHistoryTalkVoice("story_v_out_417261", "417261030", "story_v_out_417261.awb")
				end

				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_26 = math.max(var_127_17, arg_124_1.talkMaxDuration)

			if var_127_16 <= arg_124_1.time_ and arg_124_1.time_ < var_127_16 + var_127_26 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_16) / var_127_26

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_16 + var_127_26 and arg_124_1.time_ < var_127_16 + var_127_26 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {}

		arg_124_1:InitPlayNodeList()
	end,
	Play417261031 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 417261031
		arg_128_1.duration_ = 11.7

		local var_128_0 = {
			zh = 6.2,
			ja = 11.7
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
				arg_128_0:Play417261032(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			local var_131_0 = 0
			local var_131_1 = 0.775

			if var_131_0 < arg_128_1.time_ and arg_128_1.time_ <= var_131_0 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				local var_131_2 = arg_128_1:FormatText(StoryNameCfg[1109].name)

				arg_128_1.leftNameTxt_.text = var_131_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_3 = arg_128_1:GetWordFromCfg(417261031)
				local var_131_4 = arg_128_1:FormatText(var_131_3.content)

				arg_128_1.text_.text = var_131_4

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_5 = 31
				local var_131_6 = utf8.len(var_131_4)
				local var_131_7 = var_131_5 <= 0 and var_131_1 or var_131_1 * (var_131_6 / var_131_5)

				if var_131_7 > 0 and var_131_1 < var_131_7 then
					arg_128_1.talkMaxDuration = var_131_7

					if var_131_7 + var_131_0 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_7 + var_131_0
					end
				end

				arg_128_1.text_.text = var_131_4
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417261", "417261031", "story_v_out_417261.awb") ~= 0 then
					local var_131_8 = manager.audio:GetVoiceLength("story_v_out_417261", "417261031", "story_v_out_417261.awb") / 1000

					if var_131_8 + var_131_0 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_8 + var_131_0
					end

					if var_131_3.prefab_name ~= "" and arg_128_1.actors_[var_131_3.prefab_name] ~= nil then
						local var_131_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_3.prefab_name].transform, "story_v_out_417261", "417261031", "story_v_out_417261.awb")

						arg_128_1:RecordAudio("417261031", var_131_9)
						arg_128_1:RecordAudio("417261031", var_131_9)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_out_417261", "417261031", "story_v_out_417261.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_out_417261", "417261031", "story_v_out_417261.awb")
				end

				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_10 = math.max(var_131_1, arg_128_1.talkMaxDuration)

			if var_131_0 <= arg_128_1.time_ and arg_128_1.time_ < var_131_0 + var_131_10 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_0) / var_131_10

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_0 + var_131_10 and arg_128_1.time_ < var_131_0 + var_131_10 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {}

		arg_128_1:InitPlayNodeList()
	end,
	Play417261032 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 417261032
		arg_132_1.duration_ = 4.23

		local var_132_0 = {
			zh = 1.733,
			ja = 4.233
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
				arg_132_0:Play417261033(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			local var_135_0 = arg_132_1.actors_["10111"]
			local var_135_1 = 0

			if var_135_1 < arg_132_1.time_ and arg_132_1.time_ <= var_135_1 + arg_135_0 and not isNil(var_135_0) and arg_132_1.var_.actorSpriteComps10111 == nil then
				arg_132_1.var_.actorSpriteComps10111 = var_135_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_135_2 = 0.2

			if var_135_1 <= arg_132_1.time_ and arg_132_1.time_ < var_135_1 + var_135_2 and not isNil(var_135_0) then
				local var_135_3 = (arg_132_1.time_ - var_135_1) / var_135_2

				if arg_132_1.var_.actorSpriteComps10111 then
					for iter_135_0, iter_135_1 in pairs(arg_132_1.var_.actorSpriteComps10111:ToTable()) do
						if iter_135_1 then
							if arg_132_1.isInRecall_ then
								local var_135_4 = Mathf.Lerp(iter_135_1.color.r, arg_132_1.hightColor1.r, var_135_3)
								local var_135_5 = Mathf.Lerp(iter_135_1.color.g, arg_132_1.hightColor1.g, var_135_3)
								local var_135_6 = Mathf.Lerp(iter_135_1.color.b, arg_132_1.hightColor1.b, var_135_3)

								iter_135_1.color = Color.New(var_135_4, var_135_5, var_135_6)
							else
								local var_135_7 = Mathf.Lerp(iter_135_1.color.r, 1, var_135_3)

								iter_135_1.color = Color.New(var_135_7, var_135_7, var_135_7)
							end
						end
					end
				end
			end

			if arg_132_1.time_ >= var_135_1 + var_135_2 and arg_132_1.time_ < var_135_1 + var_135_2 + arg_135_0 and not isNil(var_135_0) and arg_132_1.var_.actorSpriteComps10111 then
				for iter_135_2, iter_135_3 in pairs(arg_132_1.var_.actorSpriteComps10111:ToTable()) do
					if iter_135_3 then
						if arg_132_1.isInRecall_ then
							iter_135_3.color = arg_132_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_135_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_132_1.var_.actorSpriteComps10111 = nil
			end

			local var_135_8 = arg_132_1.actors_["1034"]
			local var_135_9 = 0

			if var_135_9 < arg_132_1.time_ and arg_132_1.time_ <= var_135_9 + arg_135_0 and not isNil(var_135_8) and arg_132_1.var_.actorSpriteComps1034 == nil then
				arg_132_1.var_.actorSpriteComps1034 = var_135_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_135_10 = 0.2

			if var_135_9 <= arg_132_1.time_ and arg_132_1.time_ < var_135_9 + var_135_10 and not isNil(var_135_8) then
				local var_135_11 = (arg_132_1.time_ - var_135_9) / var_135_10

				if arg_132_1.var_.actorSpriteComps1034 then
					for iter_135_4, iter_135_5 in pairs(arg_132_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_135_5 then
							if arg_132_1.isInRecall_ then
								local var_135_12 = Mathf.Lerp(iter_135_5.color.r, arg_132_1.hightColor2.r, var_135_11)
								local var_135_13 = Mathf.Lerp(iter_135_5.color.g, arg_132_1.hightColor2.g, var_135_11)
								local var_135_14 = Mathf.Lerp(iter_135_5.color.b, arg_132_1.hightColor2.b, var_135_11)

								iter_135_5.color = Color.New(var_135_12, var_135_13, var_135_14)
							else
								local var_135_15 = Mathf.Lerp(iter_135_5.color.r, 0.5, var_135_11)

								iter_135_5.color = Color.New(var_135_15, var_135_15, var_135_15)
							end
						end
					end
				end
			end

			if arg_132_1.time_ >= var_135_9 + var_135_10 and arg_132_1.time_ < var_135_9 + var_135_10 + arg_135_0 and not isNil(var_135_8) and arg_132_1.var_.actorSpriteComps1034 then
				for iter_135_6, iter_135_7 in pairs(arg_132_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_135_7 then
						if arg_132_1.isInRecall_ then
							iter_135_7.color = arg_132_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_135_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_132_1.var_.actorSpriteComps1034 = nil
			end

			local var_135_16 = arg_132_1.actors_["10111"].transform
			local var_135_17 = 0

			if var_135_17 < arg_132_1.time_ and arg_132_1.time_ <= var_135_17 + arg_135_0 then
				arg_132_1.var_.moveOldPos10111 = var_135_16.localPosition
				var_135_16.localScale = Vector3.New(1, 1, 1)

				arg_132_1:CheckSpriteTmpPos("10111", 2)

				local var_135_18 = var_135_16.childCount

				for iter_135_8 = 0, var_135_18 - 1 do
					local var_135_19 = var_135_16:GetChild(iter_135_8)

					if var_135_19.name == "split_1" or not string.find(var_135_19.name, "split") then
						var_135_19.gameObject:SetActive(true)
					else
						var_135_19.gameObject:SetActive(false)
					end
				end
			end

			local var_135_20 = 0.001

			if var_135_17 <= arg_132_1.time_ and arg_132_1.time_ < var_135_17 + var_135_20 then
				local var_135_21 = (arg_132_1.time_ - var_135_17) / var_135_20
				local var_135_22 = Vector3.New(-390, -361.1, -274.6)

				var_135_16.localPosition = Vector3.Lerp(arg_132_1.var_.moveOldPos10111, var_135_22, var_135_21)
			end

			if arg_132_1.time_ >= var_135_17 + var_135_20 and arg_132_1.time_ < var_135_17 + var_135_20 + arg_135_0 then
				var_135_16.localPosition = Vector3.New(-390, -361.1, -274.6)
			end

			local var_135_23 = 0
			local var_135_24 = 0.25

			if var_135_23 < arg_132_1.time_ and arg_132_1.time_ <= var_135_23 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				local var_135_25 = arg_132_1:FormatText(StoryNameCfg[1125].name)

				arg_132_1.leftNameTxt_.text = var_135_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_26 = arg_132_1:GetWordFromCfg(417261032)
				local var_135_27 = arg_132_1:FormatText(var_135_26.content)

				arg_132_1.text_.text = var_135_27

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_28 = 10
				local var_135_29 = utf8.len(var_135_27)
				local var_135_30 = var_135_28 <= 0 and var_135_24 or var_135_24 * (var_135_29 / var_135_28)

				if var_135_30 > 0 and var_135_24 < var_135_30 then
					arg_132_1.talkMaxDuration = var_135_30

					if var_135_30 + var_135_23 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_30 + var_135_23
					end
				end

				arg_132_1.text_.text = var_135_27
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417261", "417261032", "story_v_out_417261.awb") ~= 0 then
					local var_135_31 = manager.audio:GetVoiceLength("story_v_out_417261", "417261032", "story_v_out_417261.awb") / 1000

					if var_135_31 + var_135_23 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_31 + var_135_23
					end

					if var_135_26.prefab_name ~= "" and arg_132_1.actors_[var_135_26.prefab_name] ~= nil then
						local var_135_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_26.prefab_name].transform, "story_v_out_417261", "417261032", "story_v_out_417261.awb")

						arg_132_1:RecordAudio("417261032", var_135_32)
						arg_132_1:RecordAudio("417261032", var_135_32)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_out_417261", "417261032", "story_v_out_417261.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_out_417261", "417261032", "story_v_out_417261.awb")
				end

				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_33 = math.max(var_135_24, arg_132_1.talkMaxDuration)

			if var_135_23 <= arg_132_1.time_ and arg_132_1.time_ < var_135_23 + var_135_33 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_23) / var_135_33

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_23 + var_135_33 and arg_132_1.time_ < var_135_23 + var_135_33 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10111",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_132_1:InitPlayNodeList()
	end,
	Play417261033 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 417261033
		arg_136_1.duration_ = 5

		SetActive(arg_136_1.tipsGo_, false)

		function arg_136_1.onSingleLineFinish_()
			arg_136_1.onSingleLineUpdate_ = nil
			arg_136_1.onSingleLineFinish_ = nil
			arg_136_1.state_ = "waiting"
		end

		function arg_136_1.playNext_(arg_138_0)
			if arg_138_0 == 1 then
				arg_136_0:Play417261034(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			local var_139_0 = arg_136_1.actors_["10111"]
			local var_139_1 = 0

			if var_139_1 < arg_136_1.time_ and arg_136_1.time_ <= var_139_1 + arg_139_0 and not isNil(var_139_0) and arg_136_1.var_.actorSpriteComps10111 == nil then
				arg_136_1.var_.actorSpriteComps10111 = var_139_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_139_2 = 0.2

			if var_139_1 <= arg_136_1.time_ and arg_136_1.time_ < var_139_1 + var_139_2 and not isNil(var_139_0) then
				local var_139_3 = (arg_136_1.time_ - var_139_1) / var_139_2

				if arg_136_1.var_.actorSpriteComps10111 then
					for iter_139_0, iter_139_1 in pairs(arg_136_1.var_.actorSpriteComps10111:ToTable()) do
						if iter_139_1 then
							if arg_136_1.isInRecall_ then
								local var_139_4 = Mathf.Lerp(iter_139_1.color.r, arg_136_1.hightColor2.r, var_139_3)
								local var_139_5 = Mathf.Lerp(iter_139_1.color.g, arg_136_1.hightColor2.g, var_139_3)
								local var_139_6 = Mathf.Lerp(iter_139_1.color.b, arg_136_1.hightColor2.b, var_139_3)

								iter_139_1.color = Color.New(var_139_4, var_139_5, var_139_6)
							else
								local var_139_7 = Mathf.Lerp(iter_139_1.color.r, 0.5, var_139_3)

								iter_139_1.color = Color.New(var_139_7, var_139_7, var_139_7)
							end
						end
					end
				end
			end

			if arg_136_1.time_ >= var_139_1 + var_139_2 and arg_136_1.time_ < var_139_1 + var_139_2 + arg_139_0 and not isNil(var_139_0) and arg_136_1.var_.actorSpriteComps10111 then
				for iter_139_2, iter_139_3 in pairs(arg_136_1.var_.actorSpriteComps10111:ToTable()) do
					if iter_139_3 then
						if arg_136_1.isInRecall_ then
							iter_139_3.color = arg_136_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_139_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_136_1.var_.actorSpriteComps10111 = nil
			end

			local var_139_8 = 0
			local var_139_9 = 0.95

			if var_139_8 < arg_136_1.time_ and arg_136_1.time_ <= var_139_8 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, false)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_10 = arg_136_1:GetWordFromCfg(417261033)
				local var_139_11 = arg_136_1:FormatText(var_139_10.content)

				arg_136_1.text_.text = var_139_11

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_12 = 38
				local var_139_13 = utf8.len(var_139_11)
				local var_139_14 = var_139_12 <= 0 and var_139_9 or var_139_9 * (var_139_13 / var_139_12)

				if var_139_14 > 0 and var_139_9 < var_139_14 then
					arg_136_1.talkMaxDuration = var_139_14

					if var_139_14 + var_139_8 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_14 + var_139_8
					end
				end

				arg_136_1.text_.text = var_139_11
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)
				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_15 = math.max(var_139_9, arg_136_1.talkMaxDuration)

			if var_139_8 <= arg_136_1.time_ and arg_136_1.time_ < var_139_8 + var_139_15 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_8) / var_139_15

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_8 + var_139_15 and arg_136_1.time_ < var_139_8 + var_139_15 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {}

		arg_136_1:InitPlayNodeList()
	end,
	Play417261034 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 417261034
		arg_140_1.duration_ = 8.97

		local var_140_0 = {
			zh = 6.266,
			ja = 8.966
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
				arg_140_0:Play417261035(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			local var_143_0 = arg_140_1.actors_["1034"]
			local var_143_1 = 0

			if var_143_1 < arg_140_1.time_ and arg_140_1.time_ <= var_143_1 + arg_143_0 and not isNil(var_143_0) and arg_140_1.var_.actorSpriteComps1034 == nil then
				arg_140_1.var_.actorSpriteComps1034 = var_143_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_143_2 = 0.2

			if var_143_1 <= arg_140_1.time_ and arg_140_1.time_ < var_143_1 + var_143_2 and not isNil(var_143_0) then
				local var_143_3 = (arg_140_1.time_ - var_143_1) / var_143_2

				if arg_140_1.var_.actorSpriteComps1034 then
					for iter_143_0, iter_143_1 in pairs(arg_140_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_143_1 then
							if arg_140_1.isInRecall_ then
								local var_143_4 = Mathf.Lerp(iter_143_1.color.r, arg_140_1.hightColor1.r, var_143_3)
								local var_143_5 = Mathf.Lerp(iter_143_1.color.g, arg_140_1.hightColor1.g, var_143_3)
								local var_143_6 = Mathf.Lerp(iter_143_1.color.b, arg_140_1.hightColor1.b, var_143_3)

								iter_143_1.color = Color.New(var_143_4, var_143_5, var_143_6)
							else
								local var_143_7 = Mathf.Lerp(iter_143_1.color.r, 1, var_143_3)

								iter_143_1.color = Color.New(var_143_7, var_143_7, var_143_7)
							end
						end
					end
				end
			end

			if arg_140_1.time_ >= var_143_1 + var_143_2 and arg_140_1.time_ < var_143_1 + var_143_2 + arg_143_0 and not isNil(var_143_0) and arg_140_1.var_.actorSpriteComps1034 then
				for iter_143_2, iter_143_3 in pairs(arg_140_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_143_3 then
						if arg_140_1.isInRecall_ then
							iter_143_3.color = arg_140_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_143_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_140_1.var_.actorSpriteComps1034 = nil
			end

			local var_143_8 = 0
			local var_143_9 = 0.75

			if var_143_8 < arg_140_1.time_ and arg_140_1.time_ <= var_143_8 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, true)

				local var_143_10 = arg_140_1:FormatText(StoryNameCfg[1109].name)

				arg_140_1.leftNameTxt_.text = var_143_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_140_1.leftNameTxt_.transform)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1.leftNameTxt_.text)
				SetActive(arg_140_1.iconTrs_.gameObject, false)
				arg_140_1.callingController_:SetSelectedState("normal")

				local var_143_11 = arg_140_1:GetWordFromCfg(417261034)
				local var_143_12 = arg_140_1:FormatText(var_143_11.content)

				arg_140_1.text_.text = var_143_12

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_13 = 30
				local var_143_14 = utf8.len(var_143_12)
				local var_143_15 = var_143_13 <= 0 and var_143_9 or var_143_9 * (var_143_14 / var_143_13)

				if var_143_15 > 0 and var_143_9 < var_143_15 then
					arg_140_1.talkMaxDuration = var_143_15

					if var_143_15 + var_143_8 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_15 + var_143_8
					end
				end

				arg_140_1.text_.text = var_143_12
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417261", "417261034", "story_v_out_417261.awb") ~= 0 then
					local var_143_16 = manager.audio:GetVoiceLength("story_v_out_417261", "417261034", "story_v_out_417261.awb") / 1000

					if var_143_16 + var_143_8 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_16 + var_143_8
					end

					if var_143_11.prefab_name ~= "" and arg_140_1.actors_[var_143_11.prefab_name] ~= nil then
						local var_143_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_140_1.actors_[var_143_11.prefab_name].transform, "story_v_out_417261", "417261034", "story_v_out_417261.awb")

						arg_140_1:RecordAudio("417261034", var_143_17)
						arg_140_1:RecordAudio("417261034", var_143_17)
					else
						arg_140_1:AudioAction("play", "voice", "story_v_out_417261", "417261034", "story_v_out_417261.awb")
					end

					arg_140_1:RecordHistoryTalkVoice("story_v_out_417261", "417261034", "story_v_out_417261.awb")
				end

				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_18 = math.max(var_143_9, arg_140_1.talkMaxDuration)

			if var_143_8 <= arg_140_1.time_ and arg_140_1.time_ < var_143_8 + var_143_18 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_8) / var_143_18

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_8 + var_143_18 and arg_140_1.time_ < var_143_8 + var_143_18 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {}

		arg_140_1:InitPlayNodeList()
	end,
	Play417261035 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 417261035
		arg_144_1.duration_ = 5.83

		local var_144_0 = {
			zh = 3.066,
			ja = 5.833
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
				arg_144_0:Play417261036(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			local var_147_0 = "10128"

			if arg_144_1.actors_[var_147_0] == nil then
				local var_147_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10128")

				if not isNil(var_147_1) then
					local var_147_2 = Object.Instantiate(var_147_1, arg_144_1.canvasGo_.transform)

					var_147_2.transform:SetSiblingIndex(1)

					var_147_2.name = var_147_0
					var_147_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_144_1.actors_[var_147_0] = var_147_2

					local var_147_3 = var_147_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_144_1.isInRecall_ then
						for iter_147_0, iter_147_1 in ipairs(var_147_3) do
							iter_147_1.color = arg_144_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_147_4 = arg_144_1.actors_["10128"]
			local var_147_5 = 0

			if var_147_5 < arg_144_1.time_ and arg_144_1.time_ <= var_147_5 + arg_147_0 and not isNil(var_147_4) and arg_144_1.var_.actorSpriteComps10128 == nil then
				arg_144_1.var_.actorSpriteComps10128 = var_147_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_147_6 = 0.2

			if var_147_5 <= arg_144_1.time_ and arg_144_1.time_ < var_147_5 + var_147_6 and not isNil(var_147_4) then
				local var_147_7 = (arg_144_1.time_ - var_147_5) / var_147_6

				if arg_144_1.var_.actorSpriteComps10128 then
					for iter_147_2, iter_147_3 in pairs(arg_144_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_147_3 then
							if arg_144_1.isInRecall_ then
								local var_147_8 = Mathf.Lerp(iter_147_3.color.r, arg_144_1.hightColor1.r, var_147_7)
								local var_147_9 = Mathf.Lerp(iter_147_3.color.g, arg_144_1.hightColor1.g, var_147_7)
								local var_147_10 = Mathf.Lerp(iter_147_3.color.b, arg_144_1.hightColor1.b, var_147_7)

								iter_147_3.color = Color.New(var_147_8, var_147_9, var_147_10)
							else
								local var_147_11 = Mathf.Lerp(iter_147_3.color.r, 1, var_147_7)

								iter_147_3.color = Color.New(var_147_11, var_147_11, var_147_11)
							end
						end
					end
				end
			end

			if arg_144_1.time_ >= var_147_5 + var_147_6 and arg_144_1.time_ < var_147_5 + var_147_6 + arg_147_0 and not isNil(var_147_4) and arg_144_1.var_.actorSpriteComps10128 then
				for iter_147_4, iter_147_5 in pairs(arg_144_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_147_5 then
						if arg_144_1.isInRecall_ then
							iter_147_5.color = arg_144_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_147_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_144_1.var_.actorSpriteComps10128 = nil
			end

			local var_147_12 = arg_144_1.actors_["10128"].transform
			local var_147_13 = 0

			if var_147_13 < arg_144_1.time_ and arg_144_1.time_ <= var_147_13 + arg_147_0 then
				arg_144_1.var_.moveOldPos10128 = var_147_12.localPosition
				var_147_12.localScale = Vector3.New(1, 1, 1)

				arg_144_1:CheckSpriteTmpPos("10128", 4)

				local var_147_14 = var_147_12.childCount

				for iter_147_6 = 0, var_147_14 - 1 do
					local var_147_15 = var_147_12:GetChild(iter_147_6)

					if var_147_15.name == "split_4" or not string.find(var_147_15.name, "split") then
						var_147_15.gameObject:SetActive(true)
					else
						var_147_15.gameObject:SetActive(false)
					end
				end
			end

			local var_147_16 = 0.001

			if var_147_13 <= arg_144_1.time_ and arg_144_1.time_ < var_147_13 + var_147_16 then
				local var_147_17 = (arg_144_1.time_ - var_147_13) / var_147_16
				local var_147_18 = Vector3.New(390, -347, -300)

				var_147_12.localPosition = Vector3.Lerp(arg_144_1.var_.moveOldPos10128, var_147_18, var_147_17)
			end

			if arg_144_1.time_ >= var_147_13 + var_147_16 and arg_144_1.time_ < var_147_13 + var_147_16 + arg_147_0 then
				var_147_12.localPosition = Vector3.New(390, -347, -300)
			end

			local var_147_19 = 0
			local var_147_20 = 0.35

			if var_147_19 < arg_144_1.time_ and arg_144_1.time_ <= var_147_19 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				local var_147_21 = arg_144_1:FormatText(StoryNameCfg[595].name)

				arg_144_1.leftNameTxt_.text = var_147_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, false)
				arg_144_1.callingController_:SetSelectedState("normal")

				local var_147_22 = arg_144_1:GetWordFromCfg(417261035)
				local var_147_23 = arg_144_1:FormatText(var_147_22.content)

				arg_144_1.text_.text = var_147_23

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_24 = 14
				local var_147_25 = utf8.len(var_147_23)
				local var_147_26 = var_147_24 <= 0 and var_147_20 or var_147_20 * (var_147_25 / var_147_24)

				if var_147_26 > 0 and var_147_20 < var_147_26 then
					arg_144_1.talkMaxDuration = var_147_26

					if var_147_26 + var_147_19 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_26 + var_147_19
					end
				end

				arg_144_1.text_.text = var_147_23
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417261", "417261035", "story_v_out_417261.awb") ~= 0 then
					local var_147_27 = manager.audio:GetVoiceLength("story_v_out_417261", "417261035", "story_v_out_417261.awb") / 1000

					if var_147_27 + var_147_19 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_27 + var_147_19
					end

					if var_147_22.prefab_name ~= "" and arg_144_1.actors_[var_147_22.prefab_name] ~= nil then
						local var_147_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_144_1.actors_[var_147_22.prefab_name].transform, "story_v_out_417261", "417261035", "story_v_out_417261.awb")

						arg_144_1:RecordAudio("417261035", var_147_28)
						arg_144_1:RecordAudio("417261035", var_147_28)
					else
						arg_144_1:AudioAction("play", "voice", "story_v_out_417261", "417261035", "story_v_out_417261.awb")
					end

					arg_144_1:RecordHistoryTalkVoice("story_v_out_417261", "417261035", "story_v_out_417261.awb")
				end

				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_29 = math.max(var_147_20, arg_144_1.talkMaxDuration)

			if var_147_19 <= arg_144_1.time_ and arg_144_1.time_ < var_147_19 + var_147_29 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_19) / var_147_29

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_19 + var_147_29 and arg_144_1.time_ < var_147_19 + var_147_29 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_144_1:InitPlayNodeList()
	end,
	Play417261036 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 417261036
		arg_148_1.duration_ = 3.23

		local var_148_0 = {
			zh = 2.4,
			ja = 3.233
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
				arg_148_0:Play417261037(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			local var_151_0 = arg_148_1.actors_["10111"]
			local var_151_1 = 0

			if var_151_1 < arg_148_1.time_ and arg_148_1.time_ <= var_151_1 + arg_151_0 and not isNil(var_151_0) and arg_148_1.var_.actorSpriteComps10111 == nil then
				arg_148_1.var_.actorSpriteComps10111 = var_151_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_151_2 = 0.2

			if var_151_1 <= arg_148_1.time_ and arg_148_1.time_ < var_151_1 + var_151_2 and not isNil(var_151_0) then
				local var_151_3 = (arg_148_1.time_ - var_151_1) / var_151_2

				if arg_148_1.var_.actorSpriteComps10111 then
					for iter_151_0, iter_151_1 in pairs(arg_148_1.var_.actorSpriteComps10111:ToTable()) do
						if iter_151_1 then
							if arg_148_1.isInRecall_ then
								local var_151_4 = Mathf.Lerp(iter_151_1.color.r, arg_148_1.hightColor1.r, var_151_3)
								local var_151_5 = Mathf.Lerp(iter_151_1.color.g, arg_148_1.hightColor1.g, var_151_3)
								local var_151_6 = Mathf.Lerp(iter_151_1.color.b, arg_148_1.hightColor1.b, var_151_3)

								iter_151_1.color = Color.New(var_151_4, var_151_5, var_151_6)
							else
								local var_151_7 = Mathf.Lerp(iter_151_1.color.r, 1, var_151_3)

								iter_151_1.color = Color.New(var_151_7, var_151_7, var_151_7)
							end
						end
					end
				end
			end

			if arg_148_1.time_ >= var_151_1 + var_151_2 and arg_148_1.time_ < var_151_1 + var_151_2 + arg_151_0 and not isNil(var_151_0) and arg_148_1.var_.actorSpriteComps10111 then
				for iter_151_2, iter_151_3 in pairs(arg_148_1.var_.actorSpriteComps10111:ToTable()) do
					if iter_151_3 then
						if arg_148_1.isInRecall_ then
							iter_151_3.color = arg_148_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_151_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_148_1.var_.actorSpriteComps10111 = nil
			end

			local var_151_8 = arg_148_1.actors_["10128"]
			local var_151_9 = 0

			if var_151_9 < arg_148_1.time_ and arg_148_1.time_ <= var_151_9 + arg_151_0 and not isNil(var_151_8) and arg_148_1.var_.actorSpriteComps10128 == nil then
				arg_148_1.var_.actorSpriteComps10128 = var_151_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_151_10 = 0.2

			if var_151_9 <= arg_148_1.time_ and arg_148_1.time_ < var_151_9 + var_151_10 and not isNil(var_151_8) then
				local var_151_11 = (arg_148_1.time_ - var_151_9) / var_151_10

				if arg_148_1.var_.actorSpriteComps10128 then
					for iter_151_4, iter_151_5 in pairs(arg_148_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_151_5 then
							if arg_148_1.isInRecall_ then
								local var_151_12 = Mathf.Lerp(iter_151_5.color.r, arg_148_1.hightColor2.r, var_151_11)
								local var_151_13 = Mathf.Lerp(iter_151_5.color.g, arg_148_1.hightColor2.g, var_151_11)
								local var_151_14 = Mathf.Lerp(iter_151_5.color.b, arg_148_1.hightColor2.b, var_151_11)

								iter_151_5.color = Color.New(var_151_12, var_151_13, var_151_14)
							else
								local var_151_15 = Mathf.Lerp(iter_151_5.color.r, 0.5, var_151_11)

								iter_151_5.color = Color.New(var_151_15, var_151_15, var_151_15)
							end
						end
					end
				end
			end

			if arg_148_1.time_ >= var_151_9 + var_151_10 and arg_148_1.time_ < var_151_9 + var_151_10 + arg_151_0 and not isNil(var_151_8) and arg_148_1.var_.actorSpriteComps10128 then
				for iter_151_6, iter_151_7 in pairs(arg_148_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_151_7 then
						if arg_148_1.isInRecall_ then
							iter_151_7.color = arg_148_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_151_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_148_1.var_.actorSpriteComps10128 = nil
			end

			local var_151_16 = arg_148_1.actors_["10111"].transform
			local var_151_17 = 0

			if var_151_17 < arg_148_1.time_ and arg_148_1.time_ <= var_151_17 + arg_151_0 then
				arg_148_1.var_.moveOldPos10111 = var_151_16.localPosition
				var_151_16.localScale = Vector3.New(1, 1, 1)

				arg_148_1:CheckSpriteTmpPos("10111", 2)

				local var_151_18 = var_151_16.childCount

				for iter_151_8 = 0, var_151_18 - 1 do
					local var_151_19 = var_151_16:GetChild(iter_151_8)

					if var_151_19.name == "split_2" or not string.find(var_151_19.name, "split") then
						var_151_19.gameObject:SetActive(true)
					else
						var_151_19.gameObject:SetActive(false)
					end
				end
			end

			local var_151_20 = 0.001

			if var_151_17 <= arg_148_1.time_ and arg_148_1.time_ < var_151_17 + var_151_20 then
				local var_151_21 = (arg_148_1.time_ - var_151_17) / var_151_20
				local var_151_22 = Vector3.New(-390, -361.1, -274.6)

				var_151_16.localPosition = Vector3.Lerp(arg_148_1.var_.moveOldPos10111, var_151_22, var_151_21)
			end

			if arg_148_1.time_ >= var_151_17 + var_151_20 and arg_148_1.time_ < var_151_17 + var_151_20 + arg_151_0 then
				var_151_16.localPosition = Vector3.New(-390, -361.1, -274.6)
			end

			local var_151_23 = 0
			local var_151_24 = 0.2

			if var_151_23 < arg_148_1.time_ and arg_148_1.time_ <= var_151_23 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, true)

				local var_151_25 = arg_148_1:FormatText(StoryNameCfg[1125].name)

				arg_148_1.leftNameTxt_.text = var_151_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_148_1.leftNameTxt_.transform)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1.leftNameTxt_.text)
				SetActive(arg_148_1.iconTrs_.gameObject, false)
				arg_148_1.callingController_:SetSelectedState("normal")

				local var_151_26 = arg_148_1:GetWordFromCfg(417261036)
				local var_151_27 = arg_148_1:FormatText(var_151_26.content)

				arg_148_1.text_.text = var_151_27

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_28 = 8
				local var_151_29 = utf8.len(var_151_27)
				local var_151_30 = var_151_28 <= 0 and var_151_24 or var_151_24 * (var_151_29 / var_151_28)

				if var_151_30 > 0 and var_151_24 < var_151_30 then
					arg_148_1.talkMaxDuration = var_151_30

					if var_151_30 + var_151_23 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_30 + var_151_23
					end
				end

				arg_148_1.text_.text = var_151_27
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417261", "417261036", "story_v_out_417261.awb") ~= 0 then
					local var_151_31 = manager.audio:GetVoiceLength("story_v_out_417261", "417261036", "story_v_out_417261.awb") / 1000

					if var_151_31 + var_151_23 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_31 + var_151_23
					end

					if var_151_26.prefab_name ~= "" and arg_148_1.actors_[var_151_26.prefab_name] ~= nil then
						local var_151_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_148_1.actors_[var_151_26.prefab_name].transform, "story_v_out_417261", "417261036", "story_v_out_417261.awb")

						arg_148_1:RecordAudio("417261036", var_151_32)
						arg_148_1:RecordAudio("417261036", var_151_32)
					else
						arg_148_1:AudioAction("play", "voice", "story_v_out_417261", "417261036", "story_v_out_417261.awb")
					end

					arg_148_1:RecordHistoryTalkVoice("story_v_out_417261", "417261036", "story_v_out_417261.awb")
				end

				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_33 = math.max(var_151_24, arg_148_1.talkMaxDuration)

			if var_151_23 <= arg_148_1.time_ and arg_148_1.time_ < var_151_23 + var_151_33 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_23) / var_151_33

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_23 + var_151_33 and arg_148_1.time_ < var_151_23 + var_151_33 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10111",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_148_1:InitPlayNodeList()
	end,
	Play417261037 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 417261037
		arg_152_1.duration_ = 7.53

		local var_152_0 = {
			zh = 5.666,
			ja = 7.533
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
				arg_152_0:Play417261038(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			local var_155_0 = 0
			local var_155_1 = 0.625

			if var_155_0 < arg_152_1.time_ and arg_152_1.time_ <= var_155_0 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, true)

				local var_155_2 = arg_152_1:FormatText(StoryNameCfg[1125].name)

				arg_152_1.leftNameTxt_.text = var_155_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_152_1.leftNameTxt_.transform)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1.leftNameTxt_.text)
				SetActive(arg_152_1.iconTrs_.gameObject, false)
				arg_152_1.callingController_:SetSelectedState("normal")

				local var_155_3 = arg_152_1:GetWordFromCfg(417261037)
				local var_155_4 = arg_152_1:FormatText(var_155_3.content)

				arg_152_1.text_.text = var_155_4

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_5 = 25
				local var_155_6 = utf8.len(var_155_4)
				local var_155_7 = var_155_5 <= 0 and var_155_1 or var_155_1 * (var_155_6 / var_155_5)

				if var_155_7 > 0 and var_155_1 < var_155_7 then
					arg_152_1.talkMaxDuration = var_155_7

					if var_155_7 + var_155_0 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_7 + var_155_0
					end
				end

				arg_152_1.text_.text = var_155_4
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417261", "417261037", "story_v_out_417261.awb") ~= 0 then
					local var_155_8 = manager.audio:GetVoiceLength("story_v_out_417261", "417261037", "story_v_out_417261.awb") / 1000

					if var_155_8 + var_155_0 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_8 + var_155_0
					end

					if var_155_3.prefab_name ~= "" and arg_152_1.actors_[var_155_3.prefab_name] ~= nil then
						local var_155_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_152_1.actors_[var_155_3.prefab_name].transform, "story_v_out_417261", "417261037", "story_v_out_417261.awb")

						arg_152_1:RecordAudio("417261037", var_155_9)
						arg_152_1:RecordAudio("417261037", var_155_9)
					else
						arg_152_1:AudioAction("play", "voice", "story_v_out_417261", "417261037", "story_v_out_417261.awb")
					end

					arg_152_1:RecordHistoryTalkVoice("story_v_out_417261", "417261037", "story_v_out_417261.awb")
				end

				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_10 = math.max(var_155_1, arg_152_1.talkMaxDuration)

			if var_155_0 <= arg_152_1.time_ and arg_152_1.time_ < var_155_0 + var_155_10 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - var_155_0) / var_155_10

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= var_155_0 + var_155_10 and arg_152_1.time_ < var_155_0 + var_155_10 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {}

		arg_152_1:InitPlayNodeList()
	end,
	Play417261038 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 417261038
		arg_156_1.duration_ = 5

		SetActive(arg_156_1.tipsGo_, false)

		function arg_156_1.onSingleLineFinish_()
			arg_156_1.onSingleLineUpdate_ = nil
			arg_156_1.onSingleLineFinish_ = nil
			arg_156_1.state_ = "waiting"
		end

		function arg_156_1.playNext_(arg_158_0)
			if arg_158_0 == 1 then
				arg_156_0:Play417261039(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			local var_159_0 = arg_156_1.actors_["10111"].transform
			local var_159_1 = 0

			if var_159_1 < arg_156_1.time_ and arg_156_1.time_ <= var_159_1 + arg_159_0 then
				arg_156_1.var_.moveOldPos10111 = var_159_0.localPosition
				var_159_0.localScale = Vector3.New(1, 1, 1)

				arg_156_1:CheckSpriteTmpPos("10111", 7)

				local var_159_2 = var_159_0.childCount

				for iter_159_0 = 0, var_159_2 - 1 do
					local var_159_3 = var_159_0:GetChild(iter_159_0)

					if var_159_3.name == "" or not string.find(var_159_3.name, "split") then
						var_159_3.gameObject:SetActive(true)
					else
						var_159_3.gameObject:SetActive(false)
					end
				end
			end

			local var_159_4 = 0.001

			if var_159_1 <= arg_156_1.time_ and arg_156_1.time_ < var_159_1 + var_159_4 then
				local var_159_5 = (arg_156_1.time_ - var_159_1) / var_159_4
				local var_159_6 = Vector3.New(0, -2000, 0)

				var_159_0.localPosition = Vector3.Lerp(arg_156_1.var_.moveOldPos10111, var_159_6, var_159_5)
			end

			if arg_156_1.time_ >= var_159_1 + var_159_4 and arg_156_1.time_ < var_159_1 + var_159_4 + arg_159_0 then
				var_159_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_159_7 = arg_156_1.actors_["10128"].transform
			local var_159_8 = 0

			if var_159_8 < arg_156_1.time_ and arg_156_1.time_ <= var_159_8 + arg_159_0 then
				arg_156_1.var_.moveOldPos10128 = var_159_7.localPosition
				var_159_7.localScale = Vector3.New(1, 1, 1)

				arg_156_1:CheckSpriteTmpPos("10128", 7)

				local var_159_9 = var_159_7.childCount

				for iter_159_1 = 0, var_159_9 - 1 do
					local var_159_10 = var_159_7:GetChild(iter_159_1)

					if var_159_10.name == "" or not string.find(var_159_10.name, "split") then
						var_159_10.gameObject:SetActive(true)
					else
						var_159_10.gameObject:SetActive(false)
					end
				end
			end

			local var_159_11 = 0.001

			if var_159_8 <= arg_156_1.time_ and arg_156_1.time_ < var_159_8 + var_159_11 then
				local var_159_12 = (arg_156_1.time_ - var_159_8) / var_159_11
				local var_159_13 = Vector3.New(0, -2000, -300)

				var_159_7.localPosition = Vector3.Lerp(arg_156_1.var_.moveOldPos10128, var_159_13, var_159_12)
			end

			if arg_156_1.time_ >= var_159_8 + var_159_11 and arg_156_1.time_ < var_159_8 + var_159_11 + arg_159_0 then
				var_159_7.localPosition = Vector3.New(0, -2000, -300)
			end

			local var_159_14 = 0
			local var_159_15 = 0.975

			if var_159_14 < arg_156_1.time_ and arg_156_1.time_ <= var_159_14 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, false)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_156_1.iconTrs_.gameObject, false)
				arg_156_1.callingController_:SetSelectedState("normal")

				local var_159_16 = arg_156_1:GetWordFromCfg(417261038)
				local var_159_17 = arg_156_1:FormatText(var_159_16.content)

				arg_156_1.text_.text = var_159_17

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_18 = 39
				local var_159_19 = utf8.len(var_159_17)
				local var_159_20 = var_159_18 <= 0 and var_159_15 or var_159_15 * (var_159_19 / var_159_18)

				if var_159_20 > 0 and var_159_15 < var_159_20 then
					arg_156_1.talkMaxDuration = var_159_20

					if var_159_20 + var_159_14 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_20 + var_159_14
					end
				end

				arg_156_1.text_.text = var_159_17
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)
				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_21 = math.max(var_159_15, arg_156_1.talkMaxDuration)

			if var_159_14 <= arg_156_1.time_ and arg_156_1.time_ < var_159_14 + var_159_21 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_14) / var_159_21

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_14 + var_159_21 and arg_156_1.time_ < var_159_14 + var_159_21 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10111",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_156_1:InitPlayNodeList()
	end,
	Play417261039 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 417261039
		arg_160_1.duration_ = 2.73

		SetActive(arg_160_1.tipsGo_, false)

		function arg_160_1.onSingleLineFinish_()
			arg_160_1.onSingleLineUpdate_ = nil
			arg_160_1.onSingleLineFinish_ = nil
			arg_160_1.state_ = "waiting"
		end

		function arg_160_1.playNext_(arg_162_0)
			if arg_162_0 == 1 then
				arg_160_0:Play417261040(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			local var_163_0 = "STblack"

			if arg_160_1.bgs_[var_163_0] == nil then
				local var_163_1 = Object.Instantiate(arg_160_1.paintGo_)

				var_163_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_163_0)
				var_163_1.name = var_163_0
				var_163_1.transform.parent = arg_160_1.stage_.transform
				var_163_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_160_1.bgs_[var_163_0] = var_163_1
			end

			local var_163_2 = 1.2

			if var_163_2 < arg_160_1.time_ and arg_160_1.time_ <= var_163_2 + arg_163_0 then
				local var_163_3 = manager.ui.mainCamera.transform.localPosition
				local var_163_4 = Vector3.New(0, 0, 10) + Vector3.New(var_163_3.x, var_163_3.y, 0)
				local var_163_5 = arg_160_1.bgs_.STblack

				var_163_5.transform.localPosition = var_163_4
				var_163_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_163_6 = var_163_5:GetComponent("SpriteRenderer")

				if var_163_6 and var_163_6.sprite then
					local var_163_7 = (var_163_5.transform.localPosition - var_163_3).z
					local var_163_8 = manager.ui.mainCameraCom_
					local var_163_9 = 2 * var_163_7 * Mathf.Tan(var_163_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_163_10 = var_163_9 * var_163_8.aspect
					local var_163_11 = var_163_6.sprite.bounds.size.x
					local var_163_12 = var_163_6.sprite.bounds.size.y
					local var_163_13 = var_163_10 / var_163_11
					local var_163_14 = var_163_9 / var_163_12
					local var_163_15 = var_163_14 < var_163_13 and var_163_13 or var_163_14

					var_163_5.transform.localScale = Vector3.New(var_163_15, var_163_15, 0)
				end

				for iter_163_0, iter_163_1 in pairs(arg_160_1.bgs_) do
					if iter_163_0 ~= "STblack" then
						iter_163_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_163_16 = 0

			if var_163_16 < arg_160_1.time_ and arg_160_1.time_ <= var_163_16 + arg_163_0 then
				arg_160_1.mask_.enabled = true
				arg_160_1.mask_.raycastTarget = false

				arg_160_1:SetGaussion(false)
			end

			local var_163_17 = 1.2

			if var_163_16 <= arg_160_1.time_ and arg_160_1.time_ < var_163_16 + var_163_17 then
				local var_163_18 = (arg_160_1.time_ - var_163_16) / var_163_17
				local var_163_19 = Color.New(0, 0, 0)

				var_163_19.a = Mathf.Lerp(0, 1, var_163_18)
				arg_160_1.mask_.color = var_163_19
			end

			if arg_160_1.time_ >= var_163_16 + var_163_17 and arg_160_1.time_ < var_163_16 + var_163_17 + arg_163_0 then
				local var_163_20 = Color.New(0, 0, 0)

				var_163_20.a = 1
				arg_160_1.mask_.color = var_163_20
			end

			local var_163_21 = 1.2

			if var_163_21 < arg_160_1.time_ and arg_160_1.time_ <= var_163_21 + arg_163_0 then
				arg_160_1.mask_.enabled = true
				arg_160_1.mask_.raycastTarget = false

				arg_160_1:SetGaussion(false)
			end

			local var_163_22 = 1.2

			if var_163_21 <= arg_160_1.time_ and arg_160_1.time_ < var_163_21 + var_163_22 then
				local var_163_23 = (arg_160_1.time_ - var_163_21) / var_163_22
				local var_163_24 = Color.New(0, 0, 0)

				var_163_24.a = Mathf.Lerp(1, 0, var_163_23)
				arg_160_1.mask_.color = var_163_24
			end

			if arg_160_1.time_ >= var_163_21 + var_163_22 and arg_160_1.time_ < var_163_21 + var_163_22 + arg_163_0 then
				local var_163_25 = Color.New(0, 0, 0)
				local var_163_26 = 0

				arg_160_1.mask_.enabled = false
				var_163_25.a = var_163_26
				arg_160_1.mask_.color = var_163_25
			end

			local var_163_27 = 1.2

			if var_163_27 < arg_160_1.time_ and arg_160_1.time_ <= var_163_27 + arg_163_0 then
				arg_160_1.fswbg_:SetActive(true)
				arg_160_1.dialog_:SetActive(false)

				arg_160_1.fswtw_.percent = 0

				local var_163_28 = arg_160_1:GetWordFromCfg(417261039)
				local var_163_29 = arg_160_1:FormatText(var_163_28.content)

				arg_160_1.fswt_.text = var_163_29

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.fswt_)

				arg_160_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_160_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_160_1.fswtw_:SetDirty()

				arg_160_1.typewritterCharCountI18N = 0

				SetActive(arg_160_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_160_1:ShowNextGo(false)
			end

			local var_163_30 = 1.86666666666667

			if var_163_30 < arg_160_1.time_ and arg_160_1.time_ <= var_163_30 + arg_163_0 then
				arg_160_1.var_.oldValueTypewriter = arg_160_1.fswtw_.percent

				SetActive(arg_160_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_160_1:ShowNextGo(false)
			end

			local var_163_31 = 13
			local var_163_32 = 0.866666666666667
			local var_163_33 = arg_160_1:GetWordFromCfg(417261039)
			local var_163_34 = arg_160_1:FormatText(var_163_33.content)
			local var_163_35, var_163_36 = arg_160_1:GetPercentByPara(var_163_34, 1)

			if var_163_30 < arg_160_1.time_ and arg_160_1.time_ <= var_163_30 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0

				local var_163_37 = var_163_31 <= 0 and var_163_32 or var_163_32 * ((var_163_36 - arg_160_1.typewritterCharCountI18N) / var_163_31)

				if var_163_37 > 0 and var_163_32 < var_163_37 then
					arg_160_1.talkMaxDuration = var_163_37

					if var_163_37 + var_163_30 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_37 + var_163_30
					end
				end
			end

			local var_163_38 = 0.866666666666667
			local var_163_39 = math.max(var_163_38, arg_160_1.talkMaxDuration)

			if var_163_30 <= arg_160_1.time_ and arg_160_1.time_ < var_163_30 + var_163_39 then
				local var_163_40 = (arg_160_1.time_ - var_163_30) / var_163_39

				arg_160_1.fswtw_.percent = Mathf.Lerp(arg_160_1.var_.oldValueTypewriter, var_163_35, var_163_40)
				arg_160_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_160_1.fswtw_:SetDirty()
			end

			if arg_160_1.time_ >= var_163_30 + var_163_39 and arg_160_1.time_ < var_163_30 + var_163_39 + arg_163_0 then
				arg_160_1.fswtw_.percent = var_163_35

				arg_160_1.fswtw_:SetDirty()
				arg_160_1:ShowNextGo(true)

				arg_160_1.typewritterCharCountI18N = var_163_36
			end

			local var_163_41 = 1.2

			if var_163_41 < arg_160_1.time_ and arg_160_1.time_ <= var_163_41 + arg_163_0 then
				local var_163_42 = arg_160_1.fswbg_.transform:Find("textbox/adapt/content") or arg_160_1.fswbg_.transform:Find("textbox/content")
				local var_163_43 = arg_160_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_163_44 = var_163_42:GetComponent("Text")
				local var_163_45 = var_163_42:GetComponent("RectTransform")

				var_163_44.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_163_45.offsetMin = Vector2.New(0, 0)
				var_163_45.offsetMax = Vector2.New(0, 0)
			end

			local var_163_46 = 0
			local var_163_47 = 0.1

			if var_163_46 < arg_160_1.time_ and arg_160_1.time_ <= var_163_46 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, false)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_160_1.iconTrs_.gameObject, false)
				arg_160_1.callingController_:SetSelectedState("normal")

				local var_163_48 = arg_160_1:GetWordFromCfg(102)
				local var_163_49 = arg_160_1:FormatText(var_163_48.content)

				arg_160_1.text_.text = var_163_49

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_50 = 0
				local var_163_51 = utf8.len(var_163_49)
				local var_163_52 = var_163_50 <= 0 and var_163_47 or var_163_47 * (var_163_51 / var_163_50)

				if var_163_52 > 0 and var_163_47 < var_163_52 then
					arg_160_1.talkMaxDuration = var_163_52

					if var_163_52 + var_163_46 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_52 + var_163_46
					end
				end

				arg_160_1.text_.text = var_163_49
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)
				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_53 = math.max(var_163_47, arg_160_1.talkMaxDuration)

			if var_163_46 <= arg_160_1.time_ and arg_160_1.time_ < var_163_46 + var_163_53 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - var_163_46) / var_163_53

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= var_163_46 + var_163_53 and arg_160_1.time_ < var_163_46 + var_163_53 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {}

		arg_160_1:InitPlayNodeList()
	end,
	Play417261040 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 417261040
		arg_164_1.duration_ = 10.97

		SetActive(arg_164_1.tipsGo_, false)

		function arg_164_1.onSingleLineFinish_()
			arg_164_1.onSingleLineUpdate_ = nil
			arg_164_1.onSingleLineFinish_ = nil
			arg_164_1.state_ = "waiting"
		end

		function arg_164_1.playNext_(arg_166_0)
			if arg_166_0 == 1 then
				arg_164_0:Play417261041(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			local var_167_0 = 5.96666666666667

			if var_167_0 < arg_164_1.time_ and arg_164_1.time_ <= var_167_0 + arg_167_0 then
				arg_164_1.allBtn_.enabled = false
			end

			local var_167_1 = 0.3

			if arg_164_1.time_ >= var_167_0 + var_167_1 and arg_164_1.time_ < var_167_0 + var_167_1 + arg_167_0 then
				arg_164_1.allBtn_.enabled = true
			end

			local var_167_2 = "ST02"

			if arg_164_1.bgs_[var_167_2] == nil then
				local var_167_3 = Object.Instantiate(arg_164_1.paintGo_)

				var_167_3:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_167_2)
				var_167_3.name = var_167_2
				var_167_3.transform.parent = arg_164_1.stage_.transform
				var_167_3.transform.localPosition = Vector3.New(0, 100, 0)
				arg_164_1.bgs_[var_167_2] = var_167_3
			end

			local var_167_4 = 4.96666666666667

			if var_167_4 < arg_164_1.time_ and arg_164_1.time_ <= var_167_4 + arg_167_0 then
				local var_167_5 = manager.ui.mainCamera.transform.localPosition
				local var_167_6 = Vector3.New(0, 0, 10) + Vector3.New(var_167_5.x, var_167_5.y, 0)
				local var_167_7 = arg_164_1.bgs_.ST02

				var_167_7.transform.localPosition = var_167_6
				var_167_7.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_167_8 = var_167_7:GetComponent("SpriteRenderer")

				if var_167_8 and var_167_8.sprite then
					local var_167_9 = (var_167_7.transform.localPosition - var_167_5).z
					local var_167_10 = manager.ui.mainCameraCom_
					local var_167_11 = 2 * var_167_9 * Mathf.Tan(var_167_10.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_167_12 = var_167_11 * var_167_10.aspect
					local var_167_13 = var_167_8.sprite.bounds.size.x
					local var_167_14 = var_167_8.sprite.bounds.size.y
					local var_167_15 = var_167_12 / var_167_13
					local var_167_16 = var_167_11 / var_167_14
					local var_167_17 = var_167_16 < var_167_15 and var_167_15 or var_167_16

					var_167_7.transform.localScale = Vector3.New(var_167_17, var_167_17, 0)
				end

				for iter_167_0, iter_167_1 in pairs(arg_164_1.bgs_) do
					if iter_167_0 ~= "ST02" then
						iter_167_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_167_18 = 0.975

			if var_167_18 < arg_164_1.time_ and arg_164_1.time_ <= var_167_18 + arg_167_0 then
				local var_167_19 = manager.ui.mainCamera.transform.localPosition
				local var_167_20 = Vector3.New(0, 0, 10) + Vector3.New(var_167_19.x, var_167_19.y, 0)
				local var_167_21 = arg_164_1.bgs_.STblack

				var_167_21.transform.localPosition = var_167_20
				var_167_21.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_167_22 = var_167_21:GetComponent("SpriteRenderer")

				if var_167_22 and var_167_22.sprite then
					local var_167_23 = (var_167_21.transform.localPosition - var_167_19).z
					local var_167_24 = manager.ui.mainCameraCom_
					local var_167_25 = 2 * var_167_23 * Mathf.Tan(var_167_24.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_167_26 = var_167_25 * var_167_24.aspect
					local var_167_27 = var_167_22.sprite.bounds.size.x
					local var_167_28 = var_167_22.sprite.bounds.size.y
					local var_167_29 = var_167_26 / var_167_27
					local var_167_30 = var_167_25 / var_167_28
					local var_167_31 = var_167_30 < var_167_29 and var_167_29 or var_167_30

					var_167_21.transform.localScale = Vector3.New(var_167_31, var_167_31, 0)
				end

				for iter_167_2, iter_167_3 in pairs(arg_164_1.bgs_) do
					if iter_167_2 ~= "STblack" then
						iter_167_3.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_167_32 = 0.975

			if var_167_32 < arg_164_1.time_ and arg_164_1.time_ <= var_167_32 + arg_167_0 then
				arg_164_1.cswbg_:SetActive(true)

				local var_167_33 = arg_164_1.cswt_:GetComponent("RectTransform")

				arg_164_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_167_33.offsetMin = Vector2.New(0, 0)
				var_167_33.offsetMax = Vector2.New(0, 0)

				local var_167_34 = arg_164_1:GetWordFromCfg(419123)
				local var_167_35 = arg_164_1:FormatText(var_167_34.content)

				arg_164_1.cswt_.text = var_167_35

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.cswt_)

				arg_164_1.cswt_.fontSize = 120
				arg_164_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_164_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_164_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end

			local var_167_36 = 4.93333333333333

			if var_167_36 < arg_164_1.time_ and arg_164_1.time_ <= var_167_36 + arg_167_0 then
				arg_164_1.cswbg_:SetActive(false)
			end

			local var_167_37 = 0

			if var_167_37 < arg_164_1.time_ and arg_164_1.time_ <= var_167_37 + arg_167_0 then
				arg_164_1.mask_.enabled = true
				arg_164_1.mask_.raycastTarget = true

				arg_164_1:SetGaussion(false)
			end

			local var_167_38 = 0.966666666666667

			if var_167_37 <= arg_164_1.time_ and arg_164_1.time_ < var_167_37 + var_167_38 then
				local var_167_39 = (arg_164_1.time_ - var_167_37) / var_167_38
				local var_167_40 = Color.New(0, 0, 0)

				var_167_40.a = Mathf.Lerp(0, 1, var_167_39)
				arg_164_1.mask_.color = var_167_40
			end

			if arg_164_1.time_ >= var_167_37 + var_167_38 and arg_164_1.time_ < var_167_37 + var_167_38 + arg_167_0 then
				local var_167_41 = Color.New(0, 0, 0)

				var_167_41.a = 1
				arg_164_1.mask_.color = var_167_41
			end

			local var_167_42 = 0.966666666666667

			if var_167_42 < arg_164_1.time_ and arg_164_1.time_ <= var_167_42 + arg_167_0 then
				arg_164_1.mask_.enabled = true
				arg_164_1.mask_.raycastTarget = true

				arg_164_1:SetGaussion(false)
			end

			local var_167_43 = 1.03333333333333

			if var_167_42 <= arg_164_1.time_ and arg_164_1.time_ < var_167_42 + var_167_43 then
				local var_167_44 = (arg_164_1.time_ - var_167_42) / var_167_43
				local var_167_45 = Color.New(0, 0, 0)

				var_167_45.a = Mathf.Lerp(1, 0, var_167_44)
				arg_164_1.mask_.color = var_167_45
			end

			if arg_164_1.time_ >= var_167_42 + var_167_43 and arg_164_1.time_ < var_167_42 + var_167_43 + arg_167_0 then
				local var_167_46 = Color.New(0, 0, 0)
				local var_167_47 = 0

				arg_164_1.mask_.enabled = false
				var_167_46.a = var_167_47
				arg_164_1.mask_.color = var_167_46
			end

			local var_167_48 = 3.63333333333334

			if var_167_48 < arg_164_1.time_ and arg_164_1.time_ <= var_167_48 + arg_167_0 then
				arg_164_1.mask_.enabled = true
				arg_164_1.mask_.raycastTarget = true

				arg_164_1:SetGaussion(false)
			end

			local var_167_49 = 1.31666666666667

			if var_167_48 <= arg_164_1.time_ and arg_164_1.time_ < var_167_48 + var_167_49 then
				local var_167_50 = (arg_164_1.time_ - var_167_48) / var_167_49
				local var_167_51 = Color.New(0, 0, 0)

				var_167_51.a = Mathf.Lerp(0, 1, var_167_50)
				arg_164_1.mask_.color = var_167_51
			end

			if arg_164_1.time_ >= var_167_48 + var_167_49 and arg_164_1.time_ < var_167_48 + var_167_49 + arg_167_0 then
				local var_167_52 = Color.New(0, 0, 0)

				var_167_52.a = 1
				arg_164_1.mask_.color = var_167_52
			end

			local var_167_53 = 4.95

			if var_167_53 < arg_164_1.time_ and arg_164_1.time_ <= var_167_53 + arg_167_0 then
				arg_164_1.mask_.enabled = true
				arg_164_1.mask_.raycastTarget = true

				arg_164_1:SetGaussion(false)
			end

			local var_167_54 = 1

			if var_167_53 <= arg_164_1.time_ and arg_164_1.time_ < var_167_53 + var_167_54 then
				local var_167_55 = (arg_164_1.time_ - var_167_53) / var_167_54
				local var_167_56 = Color.New(0, 0, 0)

				var_167_56.a = Mathf.Lerp(1, 0, var_167_55)
				arg_164_1.mask_.color = var_167_56
			end

			if arg_164_1.time_ >= var_167_53 + var_167_54 and arg_164_1.time_ < var_167_53 + var_167_54 + arg_167_0 then
				local var_167_57 = Color.New(0, 0, 0)
				local var_167_58 = 0

				arg_164_1.mask_.enabled = false
				var_167_57.a = var_167_58
				arg_164_1.mask_.color = var_167_57
			end

			local var_167_59 = 0.9

			if var_167_59 < arg_164_1.time_ and arg_164_1.time_ <= var_167_59 + arg_167_0 then
				arg_164_1.fswbg_:SetActive(false)
				arg_164_1.dialog_:SetActive(false)
				SetActive(arg_164_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_164_1:ShowNextGo(false)
			end

			local var_167_60 = 5.95
			local var_167_61 = 1

			if var_167_60 < arg_164_1.time_ and arg_164_1.time_ <= var_167_60 + arg_167_0 then
				local var_167_62 = "play"
				local var_167_63 = "effect"

				arg_164_1:AudioAction(var_167_62, var_167_63, "se_story_1310", "se_story_1310_plate", "")
			end

			local var_167_64 = 4.7
			local var_167_65 = 1

			if var_167_64 < arg_164_1.time_ and arg_164_1.time_ <= var_167_64 + arg_167_0 then
				local var_167_66 = "play"
				local var_167_67 = "effect"

				arg_164_1:AudioAction(var_167_66, var_167_67, "se_story_side_1068", "se_story_1068_restaurant", "")
			end

			if arg_164_1.frameCnt_ <= 1 then
				arg_164_1.dialog_:SetActive(false)
			end

			local var_167_68 = 5.96666666666667
			local var_167_69 = 0.775

			if var_167_68 < arg_164_1.time_ and arg_164_1.time_ <= var_167_68 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0

				arg_164_1.dialog_:SetActive(true)

				arg_164_1.dialogCg_.alpha = 0

				local var_167_70 = LeanTween.value(arg_164_1.dialog_, 0, 1, 0.3)

				var_167_70:setOnUpdate(LuaHelper.FloatAction(function(arg_168_0)
					arg_164_1.dialogCg_.alpha = arg_168_0
				end))
				var_167_70:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_164_1.dialog_)
					var_167_70:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_164_1.duration_ = arg_164_1.duration_ + 0.3

				SetActive(arg_164_1.leftNameGo_, false)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_164_1.iconTrs_.gameObject, false)
				arg_164_1.callingController_:SetSelectedState("normal")

				local var_167_71 = arg_164_1:GetWordFromCfg(417261040)
				local var_167_72 = arg_164_1:FormatText(var_167_71.content)

				arg_164_1.text_.text = var_167_72

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_73 = 31
				local var_167_74 = utf8.len(var_167_72)
				local var_167_75 = var_167_73 <= 0 and var_167_69 or var_167_69 * (var_167_74 / var_167_73)

				if var_167_75 > 0 and var_167_69 < var_167_75 then
					arg_164_1.talkMaxDuration = var_167_75
					var_167_68 = var_167_68 + 0.3

					if var_167_75 + var_167_68 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_75 + var_167_68
					end
				end

				arg_164_1.text_.text = var_167_72
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)
				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_76 = var_167_68 + 0.3
			local var_167_77 = math.max(var_167_69, arg_164_1.talkMaxDuration)

			if var_167_76 <= arg_164_1.time_ and arg_164_1.time_ < var_167_76 + var_167_77 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - var_167_76) / var_167_77

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= var_167_76 + var_167_77 and arg_164_1.time_ < var_167_76 + var_167_77 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {}

		arg_164_1:InitPlayNodeList()
	end,
	Play417261041 = function(arg_170_0, arg_170_1)
		arg_170_1.time_ = 0
		arg_170_1.frameCnt_ = 0
		arg_170_1.state_ = "playing"
		arg_170_1.curTalkId_ = 417261041
		arg_170_1.duration_ = 5

		SetActive(arg_170_1.tipsGo_, false)

		function arg_170_1.onSingleLineFinish_()
			arg_170_1.onSingleLineUpdate_ = nil
			arg_170_1.onSingleLineFinish_ = nil
			arg_170_1.state_ = "waiting"
		end

		function arg_170_1.playNext_(arg_172_0)
			if arg_172_0 == 1 then
				arg_170_0:Play417261042(arg_170_1)
			end
		end

		function arg_170_1.onSingleLineUpdate_(arg_173_0)
			local var_173_0 = 0
			local var_173_1 = 0.875

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

				local var_173_2 = arg_170_1:GetWordFromCfg(417261041)
				local var_173_3 = arg_170_1:FormatText(var_173_2.content)

				arg_170_1.text_.text = var_173_3

				LuaForUtil.ClearLinePrefixSymbol(arg_170_1.text_)

				local var_173_4 = 35
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
				arg_170_1:RecordContent(arg_170_1.text_.text)
			end

			local var_173_7 = math.max(var_173_1, arg_170_1.talkMaxDuration)

			if var_173_0 <= arg_170_1.time_ and arg_170_1.time_ < var_173_0 + var_173_7 then
				arg_170_1.typewritter.percent = (arg_170_1.time_ - var_173_0) / var_173_7

				arg_170_1.typewritter:SetDirty()
			end

			if arg_170_1.time_ >= var_173_0 + var_173_7 and arg_170_1.time_ < var_173_0 + var_173_7 + arg_173_0 then
				arg_170_1.typewritter.percent = 1

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(true)
			end
		end

		arg_170_1.nodeConfigList_ = {}

		arg_170_1:InitPlayNodeList()
	end,
	Play417261042 = function(arg_174_0, arg_174_1)
		arg_174_1.time_ = 0
		arg_174_1.frameCnt_ = 0
		arg_174_1.state_ = "playing"
		arg_174_1.curTalkId_ = 417261042
		arg_174_1.duration_ = 10.5

		local var_174_0 = {
			zh = 7.7,
			ja = 10.5
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
		end

		function arg_174_1.playNext_(arg_176_0)
			if arg_176_0 == 1 then
				arg_174_0:Play417261043(arg_174_1)
			end
		end

		function arg_174_1.onSingleLineUpdate_(arg_177_0)
			local var_177_0 = "10115"

			if arg_174_1.actors_[var_177_0] == nil then
				local var_177_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10115")

				if not isNil(var_177_1) then
					local var_177_2 = Object.Instantiate(var_177_1, arg_174_1.canvasGo_.transform)

					var_177_2.transform:SetSiblingIndex(1)

					var_177_2.name = var_177_0
					var_177_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_174_1.actors_[var_177_0] = var_177_2

					local var_177_3 = var_177_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_174_1.isInRecall_ then
						for iter_177_0, iter_177_1 in ipairs(var_177_3) do
							iter_177_1.color = arg_174_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_177_4 = arg_174_1.actors_["10115"]
			local var_177_5 = 0

			if var_177_5 < arg_174_1.time_ and arg_174_1.time_ <= var_177_5 + arg_177_0 and not isNil(var_177_4) and arg_174_1.var_.actorSpriteComps10115 == nil then
				arg_174_1.var_.actorSpriteComps10115 = var_177_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_177_6 = 0.2

			if var_177_5 <= arg_174_1.time_ and arg_174_1.time_ < var_177_5 + var_177_6 and not isNil(var_177_4) then
				local var_177_7 = (arg_174_1.time_ - var_177_5) / var_177_6

				if arg_174_1.var_.actorSpriteComps10115 then
					for iter_177_2, iter_177_3 in pairs(arg_174_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_177_3 then
							if arg_174_1.isInRecall_ then
								local var_177_8 = Mathf.Lerp(iter_177_3.color.r, arg_174_1.hightColor1.r, var_177_7)
								local var_177_9 = Mathf.Lerp(iter_177_3.color.g, arg_174_1.hightColor1.g, var_177_7)
								local var_177_10 = Mathf.Lerp(iter_177_3.color.b, arg_174_1.hightColor1.b, var_177_7)

								iter_177_3.color = Color.New(var_177_8, var_177_9, var_177_10)
							else
								local var_177_11 = Mathf.Lerp(iter_177_3.color.r, 1, var_177_7)

								iter_177_3.color = Color.New(var_177_11, var_177_11, var_177_11)
							end
						end
					end
				end
			end

			if arg_174_1.time_ >= var_177_5 + var_177_6 and arg_174_1.time_ < var_177_5 + var_177_6 + arg_177_0 and not isNil(var_177_4) and arg_174_1.var_.actorSpriteComps10115 then
				for iter_177_4, iter_177_5 in pairs(arg_174_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_177_5 then
						if arg_174_1.isInRecall_ then
							iter_177_5.color = arg_174_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_177_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_174_1.var_.actorSpriteComps10115 = nil
			end

			local var_177_12 = arg_174_1.actors_["10115"].transform
			local var_177_13 = 0

			if var_177_13 < arg_174_1.time_ and arg_174_1.time_ <= var_177_13 + arg_177_0 then
				arg_174_1.var_.moveOldPos10115 = var_177_12.localPosition
				var_177_12.localScale = Vector3.New(1, 1, 1)

				arg_174_1:CheckSpriteTmpPos("10115", 3)

				local var_177_14 = var_177_12.childCount

				for iter_177_6 = 0, var_177_14 - 1 do
					local var_177_15 = var_177_12:GetChild(iter_177_6)

					if var_177_15.name == "split_2" or not string.find(var_177_15.name, "split") then
						var_177_15.gameObject:SetActive(true)
					else
						var_177_15.gameObject:SetActive(false)
					end
				end
			end

			local var_177_16 = 0.001

			if var_177_13 <= arg_174_1.time_ and arg_174_1.time_ < var_177_13 + var_177_16 then
				local var_177_17 = (arg_174_1.time_ - var_177_13) / var_177_16
				local var_177_18 = Vector3.New(0, -387.3, -246.2)

				var_177_12.localPosition = Vector3.Lerp(arg_174_1.var_.moveOldPos10115, var_177_18, var_177_17)
			end

			if arg_174_1.time_ >= var_177_13 + var_177_16 and arg_174_1.time_ < var_177_13 + var_177_16 + arg_177_0 then
				var_177_12.localPosition = Vector3.New(0, -387.3, -246.2)
			end

			local var_177_19 = 0
			local var_177_20 = 1

			if var_177_19 < arg_174_1.time_ and arg_174_1.time_ <= var_177_19 + arg_177_0 then
				arg_174_1.talkMaxDuration = 0
				arg_174_1.dialogCg_.alpha = 1

				arg_174_1.dialog_:SetActive(true)
				SetActive(arg_174_1.leftNameGo_, true)

				local var_177_21 = arg_174_1:FormatText(StoryNameCfg[1113].name)

				arg_174_1.leftNameTxt_.text = var_177_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_174_1.leftNameTxt_.transform)

				arg_174_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_174_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_174_1:RecordName(arg_174_1.leftNameTxt_.text)
				SetActive(arg_174_1.iconTrs_.gameObject, false)
				arg_174_1.callingController_:SetSelectedState("normal")

				local var_177_22 = arg_174_1:GetWordFromCfg(417261042)
				local var_177_23 = arg_174_1:FormatText(var_177_22.content)

				arg_174_1.text_.text = var_177_23

				LuaForUtil.ClearLinePrefixSymbol(arg_174_1.text_)

				local var_177_24 = 40
				local var_177_25 = utf8.len(var_177_23)
				local var_177_26 = var_177_24 <= 0 and var_177_20 or var_177_20 * (var_177_25 / var_177_24)

				if var_177_26 > 0 and var_177_20 < var_177_26 then
					arg_174_1.talkMaxDuration = var_177_26

					if var_177_26 + var_177_19 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_26 + var_177_19
					end
				end

				arg_174_1.text_.text = var_177_23
				arg_174_1.typewritter.percent = 0

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417261", "417261042", "story_v_out_417261.awb") ~= 0 then
					local var_177_27 = manager.audio:GetVoiceLength("story_v_out_417261", "417261042", "story_v_out_417261.awb") / 1000

					if var_177_27 + var_177_19 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_27 + var_177_19
					end

					if var_177_22.prefab_name ~= "" and arg_174_1.actors_[var_177_22.prefab_name] ~= nil then
						local var_177_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_174_1.actors_[var_177_22.prefab_name].transform, "story_v_out_417261", "417261042", "story_v_out_417261.awb")

						arg_174_1:RecordAudio("417261042", var_177_28)
						arg_174_1:RecordAudio("417261042", var_177_28)
					else
						arg_174_1:AudioAction("play", "voice", "story_v_out_417261", "417261042", "story_v_out_417261.awb")
					end

					arg_174_1:RecordHistoryTalkVoice("story_v_out_417261", "417261042", "story_v_out_417261.awb")
				end

				arg_174_1:RecordContent(arg_174_1.text_.text)
			end

			local var_177_29 = math.max(var_177_20, arg_174_1.talkMaxDuration)

			if var_177_19 <= arg_174_1.time_ and arg_174_1.time_ < var_177_19 + var_177_29 then
				arg_174_1.typewritter.percent = (arg_174_1.time_ - var_177_19) / var_177_29

				arg_174_1.typewritter:SetDirty()
			end

			if arg_174_1.time_ >= var_177_19 + var_177_29 and arg_174_1.time_ < var_177_19 + var_177_29 + arg_177_0 then
				arg_174_1.typewritter.percent = 1

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(true)
			end
		end

		arg_174_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10115",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_174_1:InitPlayNodeList()
	end,
	Play417261043 = function(arg_178_0, arg_178_1)
		arg_178_1.time_ = 0
		arg_178_1.frameCnt_ = 0
		arg_178_1.state_ = "playing"
		arg_178_1.curTalkId_ = 417261043
		arg_178_1.duration_ = 5.2

		local var_178_0 = {
			zh = 3.566,
			ja = 5.2
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
				arg_178_0:Play417261044(arg_178_1)
			end
		end

		function arg_178_1.onSingleLineUpdate_(arg_181_0)
			local var_181_0 = "10014"

			if arg_178_1.actors_[var_181_0] == nil then
				local var_181_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10014")

				if not isNil(var_181_1) then
					local var_181_2 = Object.Instantiate(var_181_1, arg_178_1.canvasGo_.transform)

					var_181_2.transform:SetSiblingIndex(1)

					var_181_2.name = var_181_0
					var_181_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_178_1.actors_[var_181_0] = var_181_2

					local var_181_3 = var_181_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_178_1.isInRecall_ then
						for iter_181_0, iter_181_1 in ipairs(var_181_3) do
							iter_181_1.color = arg_178_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_181_4 = arg_178_1.actors_["10014"]
			local var_181_5 = 0

			if var_181_5 < arg_178_1.time_ and arg_178_1.time_ <= var_181_5 + arg_181_0 and not isNil(var_181_4) and arg_178_1.var_.actorSpriteComps10014 == nil then
				arg_178_1.var_.actorSpriteComps10014 = var_181_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_181_6 = 0.2

			if var_181_5 <= arg_178_1.time_ and arg_178_1.time_ < var_181_5 + var_181_6 and not isNil(var_181_4) then
				local var_181_7 = (arg_178_1.time_ - var_181_5) / var_181_6

				if arg_178_1.var_.actorSpriteComps10014 then
					for iter_181_2, iter_181_3 in pairs(arg_178_1.var_.actorSpriteComps10014:ToTable()) do
						if iter_181_3 then
							if arg_178_1.isInRecall_ then
								local var_181_8 = Mathf.Lerp(iter_181_3.color.r, arg_178_1.hightColor1.r, var_181_7)
								local var_181_9 = Mathf.Lerp(iter_181_3.color.g, arg_178_1.hightColor1.g, var_181_7)
								local var_181_10 = Mathf.Lerp(iter_181_3.color.b, arg_178_1.hightColor1.b, var_181_7)

								iter_181_3.color = Color.New(var_181_8, var_181_9, var_181_10)
							else
								local var_181_11 = Mathf.Lerp(iter_181_3.color.r, 1, var_181_7)

								iter_181_3.color = Color.New(var_181_11, var_181_11, var_181_11)
							end
						end
					end
				end
			end

			if arg_178_1.time_ >= var_181_5 + var_181_6 and arg_178_1.time_ < var_181_5 + var_181_6 + arg_181_0 and not isNil(var_181_4) and arg_178_1.var_.actorSpriteComps10014 then
				for iter_181_4, iter_181_5 in pairs(arg_178_1.var_.actorSpriteComps10014:ToTable()) do
					if iter_181_5 then
						if arg_178_1.isInRecall_ then
							iter_181_5.color = arg_178_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_181_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_178_1.var_.actorSpriteComps10014 = nil
			end

			local var_181_12 = arg_178_1.actors_["10014"].transform
			local var_181_13 = 0

			if var_181_13 < arg_178_1.time_ and arg_178_1.time_ <= var_181_13 + arg_181_0 then
				arg_178_1.var_.moveOldPos10014 = var_181_12.localPosition
				var_181_12.localScale = Vector3.New(1, 1, 1)

				arg_178_1:CheckSpriteTmpPos("10014", 4)

				local var_181_14 = var_181_12.childCount

				for iter_181_6 = 0, var_181_14 - 1 do
					local var_181_15 = var_181_12:GetChild(iter_181_6)

					if var_181_15.name == "" or not string.find(var_181_15.name, "split") then
						var_181_15.gameObject:SetActive(true)
					else
						var_181_15.gameObject:SetActive(false)
					end
				end
			end

			local var_181_16 = 0.001

			if var_181_13 <= arg_178_1.time_ and arg_178_1.time_ < var_181_13 + var_181_16 then
				local var_181_17 = (arg_178_1.time_ - var_181_13) / var_181_16
				local var_181_18 = Vector3.New(420.9, -430.8, 6.9)

				var_181_12.localPosition = Vector3.Lerp(arg_178_1.var_.moveOldPos10014, var_181_18, var_181_17)
			end

			if arg_178_1.time_ >= var_181_13 + var_181_16 and arg_178_1.time_ < var_181_13 + var_181_16 + arg_181_0 then
				var_181_12.localPosition = Vector3.New(420.9, -430.8, 6.9)
			end

			local var_181_19 = arg_178_1.actors_["10115"]
			local var_181_20 = 0

			if var_181_20 < arg_178_1.time_ and arg_178_1.time_ <= var_181_20 + arg_181_0 and not isNil(var_181_19) and arg_178_1.var_.actorSpriteComps10115 == nil then
				arg_178_1.var_.actorSpriteComps10115 = var_181_19:GetComponentsInChildren(typeof(Image), true)
			end

			local var_181_21 = 0.2

			if var_181_20 <= arg_178_1.time_ and arg_178_1.time_ < var_181_20 + var_181_21 and not isNil(var_181_19) then
				local var_181_22 = (arg_178_1.time_ - var_181_20) / var_181_21

				if arg_178_1.var_.actorSpriteComps10115 then
					for iter_181_7, iter_181_8 in pairs(arg_178_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_181_8 then
							if arg_178_1.isInRecall_ then
								local var_181_23 = Mathf.Lerp(iter_181_8.color.r, arg_178_1.hightColor2.r, var_181_22)
								local var_181_24 = Mathf.Lerp(iter_181_8.color.g, arg_178_1.hightColor2.g, var_181_22)
								local var_181_25 = Mathf.Lerp(iter_181_8.color.b, arg_178_1.hightColor2.b, var_181_22)

								iter_181_8.color = Color.New(var_181_23, var_181_24, var_181_25)
							else
								local var_181_26 = Mathf.Lerp(iter_181_8.color.r, 0.5, var_181_22)

								iter_181_8.color = Color.New(var_181_26, var_181_26, var_181_26)
							end
						end
					end
				end
			end

			if arg_178_1.time_ >= var_181_20 + var_181_21 and arg_178_1.time_ < var_181_20 + var_181_21 + arg_181_0 and not isNil(var_181_19) and arg_178_1.var_.actorSpriteComps10115 then
				for iter_181_9, iter_181_10 in pairs(arg_178_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_181_10 then
						if arg_178_1.isInRecall_ then
							iter_181_10.color = arg_178_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_181_10.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_178_1.var_.actorSpriteComps10115 = nil
			end

			local var_181_27 = arg_178_1.actors_["10115"].transform
			local var_181_28 = 0

			if var_181_28 < arg_178_1.time_ and arg_178_1.time_ <= var_181_28 + arg_181_0 then
				arg_178_1.var_.moveOldPos10115 = var_181_27.localPosition
				var_181_27.localScale = Vector3.New(1, 1, 1)

				arg_178_1:CheckSpriteTmpPos("10115", 2)

				local var_181_29 = var_181_27.childCount

				for iter_181_11 = 0, var_181_29 - 1 do
					local var_181_30 = var_181_27:GetChild(iter_181_11)

					if var_181_30.name == "" or not string.find(var_181_30.name, "split") then
						var_181_30.gameObject:SetActive(true)
					else
						var_181_30.gameObject:SetActive(false)
					end
				end
			end

			local var_181_31 = 0.001

			if var_181_28 <= arg_178_1.time_ and arg_178_1.time_ < var_181_28 + var_181_31 then
				local var_181_32 = (arg_178_1.time_ - var_181_28) / var_181_31
				local var_181_33 = Vector3.New(-390, -387.3, -246.2)

				var_181_27.localPosition = Vector3.Lerp(arg_178_1.var_.moveOldPos10115, var_181_33, var_181_32)
			end

			if arg_178_1.time_ >= var_181_28 + var_181_31 and arg_178_1.time_ < var_181_28 + var_181_31 + arg_181_0 then
				var_181_27.localPosition = Vector3.New(-390, -387.3, -246.2)
			end

			local var_181_34 = 0
			local var_181_35 = 0.425

			if var_181_34 < arg_178_1.time_ and arg_178_1.time_ <= var_181_34 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0
				arg_178_1.dialogCg_.alpha = 1

				arg_178_1.dialog_:SetActive(true)
				SetActive(arg_178_1.leftNameGo_, true)

				local var_181_36 = arg_178_1:FormatText(StoryNameCfg[264].name)

				arg_178_1.leftNameTxt_.text = var_181_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_178_1.leftNameTxt_.transform)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1.leftNameTxt_.text)
				SetActive(arg_178_1.iconTrs_.gameObject, false)
				arg_178_1.callingController_:SetSelectedState("normal")

				local var_181_37 = arg_178_1:GetWordFromCfg(417261043)
				local var_181_38 = arg_178_1:FormatText(var_181_37.content)

				arg_178_1.text_.text = var_181_38

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_39 = 17
				local var_181_40 = utf8.len(var_181_38)
				local var_181_41 = var_181_39 <= 0 and var_181_35 or var_181_35 * (var_181_40 / var_181_39)

				if var_181_41 > 0 and var_181_35 < var_181_41 then
					arg_178_1.talkMaxDuration = var_181_41

					if var_181_41 + var_181_34 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_41 + var_181_34
					end
				end

				arg_178_1.text_.text = var_181_38
				arg_178_1.typewritter.percent = 0

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417261", "417261043", "story_v_out_417261.awb") ~= 0 then
					local var_181_42 = manager.audio:GetVoiceLength("story_v_out_417261", "417261043", "story_v_out_417261.awb") / 1000

					if var_181_42 + var_181_34 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_42 + var_181_34
					end

					if var_181_37.prefab_name ~= "" and arg_178_1.actors_[var_181_37.prefab_name] ~= nil then
						local var_181_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_178_1.actors_[var_181_37.prefab_name].transform, "story_v_out_417261", "417261043", "story_v_out_417261.awb")

						arg_178_1:RecordAudio("417261043", var_181_43)
						arg_178_1:RecordAudio("417261043", var_181_43)
					else
						arg_178_1:AudioAction("play", "voice", "story_v_out_417261", "417261043", "story_v_out_417261.awb")
					end

					arg_178_1:RecordHistoryTalkVoice("story_v_out_417261", "417261043", "story_v_out_417261.awb")
				end

				arg_178_1:RecordContent(arg_178_1.text_.text)
			end

			local var_181_44 = math.max(var_181_35, arg_178_1.talkMaxDuration)

			if var_181_34 <= arg_178_1.time_ and arg_178_1.time_ < var_181_34 + var_181_44 then
				arg_178_1.typewritter.percent = (arg_178_1.time_ - var_181_34) / var_181_44

				arg_178_1.typewritter:SetDirty()
			end

			if arg_178_1.time_ >= var_181_34 + var_181_44 and arg_178_1.time_ < var_181_34 + var_181_44 + arg_181_0 then
				arg_178_1.typewritter.percent = 1

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(true)
			end
		end

		arg_178_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10014",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10115",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_178_1:InitPlayNodeList()
	end,
	Play417261044 = function(arg_182_0, arg_182_1)
		arg_182_1.time_ = 0
		arg_182_1.frameCnt_ = 0
		arg_182_1.state_ = "playing"
		arg_182_1.curTalkId_ = 417261044
		arg_182_1.duration_ = 6.37

		local var_182_0 = {
			zh = 4.2,
			ja = 6.366
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
				arg_182_0:Play417261045(arg_182_1)
			end
		end

		function arg_182_1.onSingleLineUpdate_(arg_185_0)
			local var_185_0 = arg_182_1.actors_["10115"]
			local var_185_1 = 0

			if var_185_1 < arg_182_1.time_ and arg_182_1.time_ <= var_185_1 + arg_185_0 and not isNil(var_185_0) and arg_182_1.var_.actorSpriteComps10115 == nil then
				arg_182_1.var_.actorSpriteComps10115 = var_185_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_185_2 = 0.2

			if var_185_1 <= arg_182_1.time_ and arg_182_1.time_ < var_185_1 + var_185_2 and not isNil(var_185_0) then
				local var_185_3 = (arg_182_1.time_ - var_185_1) / var_185_2

				if arg_182_1.var_.actorSpriteComps10115 then
					for iter_185_0, iter_185_1 in pairs(arg_182_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_185_1 then
							if arg_182_1.isInRecall_ then
								local var_185_4 = Mathf.Lerp(iter_185_1.color.r, arg_182_1.hightColor1.r, var_185_3)
								local var_185_5 = Mathf.Lerp(iter_185_1.color.g, arg_182_1.hightColor1.g, var_185_3)
								local var_185_6 = Mathf.Lerp(iter_185_1.color.b, arg_182_1.hightColor1.b, var_185_3)

								iter_185_1.color = Color.New(var_185_4, var_185_5, var_185_6)
							else
								local var_185_7 = Mathf.Lerp(iter_185_1.color.r, 1, var_185_3)

								iter_185_1.color = Color.New(var_185_7, var_185_7, var_185_7)
							end
						end
					end
				end
			end

			if arg_182_1.time_ >= var_185_1 + var_185_2 and arg_182_1.time_ < var_185_1 + var_185_2 + arg_185_0 and not isNil(var_185_0) and arg_182_1.var_.actorSpriteComps10115 then
				for iter_185_2, iter_185_3 in pairs(arg_182_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_185_3 then
						if arg_182_1.isInRecall_ then
							iter_185_3.color = arg_182_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_185_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_182_1.var_.actorSpriteComps10115 = nil
			end

			local var_185_8 = arg_182_1.actors_["10014"]
			local var_185_9 = 0

			if var_185_9 < arg_182_1.time_ and arg_182_1.time_ <= var_185_9 + arg_185_0 and not isNil(var_185_8) and arg_182_1.var_.actorSpriteComps10014 == nil then
				arg_182_1.var_.actorSpriteComps10014 = var_185_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_185_10 = 0.2

			if var_185_9 <= arg_182_1.time_ and arg_182_1.time_ < var_185_9 + var_185_10 and not isNil(var_185_8) then
				local var_185_11 = (arg_182_1.time_ - var_185_9) / var_185_10

				if arg_182_1.var_.actorSpriteComps10014 then
					for iter_185_4, iter_185_5 in pairs(arg_182_1.var_.actorSpriteComps10014:ToTable()) do
						if iter_185_5 then
							if arg_182_1.isInRecall_ then
								local var_185_12 = Mathf.Lerp(iter_185_5.color.r, arg_182_1.hightColor2.r, var_185_11)
								local var_185_13 = Mathf.Lerp(iter_185_5.color.g, arg_182_1.hightColor2.g, var_185_11)
								local var_185_14 = Mathf.Lerp(iter_185_5.color.b, arg_182_1.hightColor2.b, var_185_11)

								iter_185_5.color = Color.New(var_185_12, var_185_13, var_185_14)
							else
								local var_185_15 = Mathf.Lerp(iter_185_5.color.r, 0.5, var_185_11)

								iter_185_5.color = Color.New(var_185_15, var_185_15, var_185_15)
							end
						end
					end
				end
			end

			if arg_182_1.time_ >= var_185_9 + var_185_10 and arg_182_1.time_ < var_185_9 + var_185_10 + arg_185_0 and not isNil(var_185_8) and arg_182_1.var_.actorSpriteComps10014 then
				for iter_185_6, iter_185_7 in pairs(arg_182_1.var_.actorSpriteComps10014:ToTable()) do
					if iter_185_7 then
						if arg_182_1.isInRecall_ then
							iter_185_7.color = arg_182_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_185_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_182_1.var_.actorSpriteComps10014 = nil
			end

			local var_185_16 = 0
			local var_185_17 = 0.45

			if var_185_16 < arg_182_1.time_ and arg_182_1.time_ <= var_185_16 + arg_185_0 then
				arg_182_1.talkMaxDuration = 0
				arg_182_1.dialogCg_.alpha = 1

				arg_182_1.dialog_:SetActive(true)
				SetActive(arg_182_1.leftNameGo_, true)

				local var_185_18 = arg_182_1:FormatText(StoryNameCfg[1113].name)

				arg_182_1.leftNameTxt_.text = var_185_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_182_1.leftNameTxt_.transform)

				arg_182_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_182_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_182_1:RecordName(arg_182_1.leftNameTxt_.text)
				SetActive(arg_182_1.iconTrs_.gameObject, false)
				arg_182_1.callingController_:SetSelectedState("normal")

				local var_185_19 = arg_182_1:GetWordFromCfg(417261044)
				local var_185_20 = arg_182_1:FormatText(var_185_19.content)

				arg_182_1.text_.text = var_185_20

				LuaForUtil.ClearLinePrefixSymbol(arg_182_1.text_)

				local var_185_21 = 18
				local var_185_22 = utf8.len(var_185_20)
				local var_185_23 = var_185_21 <= 0 and var_185_17 or var_185_17 * (var_185_22 / var_185_21)

				if var_185_23 > 0 and var_185_17 < var_185_23 then
					arg_182_1.talkMaxDuration = var_185_23

					if var_185_23 + var_185_16 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_23 + var_185_16
					end
				end

				arg_182_1.text_.text = var_185_20
				arg_182_1.typewritter.percent = 0

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417261", "417261044", "story_v_out_417261.awb") ~= 0 then
					local var_185_24 = manager.audio:GetVoiceLength("story_v_out_417261", "417261044", "story_v_out_417261.awb") / 1000

					if var_185_24 + var_185_16 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_24 + var_185_16
					end

					if var_185_19.prefab_name ~= "" and arg_182_1.actors_[var_185_19.prefab_name] ~= nil then
						local var_185_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_182_1.actors_[var_185_19.prefab_name].transform, "story_v_out_417261", "417261044", "story_v_out_417261.awb")

						arg_182_1:RecordAudio("417261044", var_185_25)
						arg_182_1:RecordAudio("417261044", var_185_25)
					else
						arg_182_1:AudioAction("play", "voice", "story_v_out_417261", "417261044", "story_v_out_417261.awb")
					end

					arg_182_1:RecordHistoryTalkVoice("story_v_out_417261", "417261044", "story_v_out_417261.awb")
				end

				arg_182_1:RecordContent(arg_182_1.text_.text)
			end

			local var_185_26 = math.max(var_185_17, arg_182_1.talkMaxDuration)

			if var_185_16 <= arg_182_1.time_ and arg_182_1.time_ < var_185_16 + var_185_26 then
				arg_182_1.typewritter.percent = (arg_182_1.time_ - var_185_16) / var_185_26

				arg_182_1.typewritter:SetDirty()
			end

			if arg_182_1.time_ >= var_185_16 + var_185_26 and arg_182_1.time_ < var_185_16 + var_185_26 + arg_185_0 then
				arg_182_1.typewritter.percent = 1

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(true)
			end
		end

		arg_182_1.nodeConfigList_ = {}

		arg_182_1:InitPlayNodeList()
	end,
	Play417261045 = function(arg_186_0, arg_186_1)
		arg_186_1.time_ = 0
		arg_186_1.frameCnt_ = 0
		arg_186_1.state_ = "playing"
		arg_186_1.curTalkId_ = 417261045
		arg_186_1.duration_ = 5.7

		local var_186_0 = {
			zh = 2.9,
			ja = 5.7
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
				arg_186_0:Play417261046(arg_186_1)
			end
		end

		function arg_186_1.onSingleLineUpdate_(arg_189_0)
			local var_189_0 = arg_186_1.actors_["10014"]
			local var_189_1 = 0

			if var_189_1 < arg_186_1.time_ and arg_186_1.time_ <= var_189_1 + arg_189_0 and not isNil(var_189_0) and arg_186_1.var_.actorSpriteComps10014 == nil then
				arg_186_1.var_.actorSpriteComps10014 = var_189_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_189_2 = 0.2

			if var_189_1 <= arg_186_1.time_ and arg_186_1.time_ < var_189_1 + var_189_2 and not isNil(var_189_0) then
				local var_189_3 = (arg_186_1.time_ - var_189_1) / var_189_2

				if arg_186_1.var_.actorSpriteComps10014 then
					for iter_189_0, iter_189_1 in pairs(arg_186_1.var_.actorSpriteComps10014:ToTable()) do
						if iter_189_1 then
							if arg_186_1.isInRecall_ then
								local var_189_4 = Mathf.Lerp(iter_189_1.color.r, arg_186_1.hightColor1.r, var_189_3)
								local var_189_5 = Mathf.Lerp(iter_189_1.color.g, arg_186_1.hightColor1.g, var_189_3)
								local var_189_6 = Mathf.Lerp(iter_189_1.color.b, arg_186_1.hightColor1.b, var_189_3)

								iter_189_1.color = Color.New(var_189_4, var_189_5, var_189_6)
							else
								local var_189_7 = Mathf.Lerp(iter_189_1.color.r, 1, var_189_3)

								iter_189_1.color = Color.New(var_189_7, var_189_7, var_189_7)
							end
						end
					end
				end
			end

			if arg_186_1.time_ >= var_189_1 + var_189_2 and arg_186_1.time_ < var_189_1 + var_189_2 + arg_189_0 and not isNil(var_189_0) and arg_186_1.var_.actorSpriteComps10014 then
				for iter_189_2, iter_189_3 in pairs(arg_186_1.var_.actorSpriteComps10014:ToTable()) do
					if iter_189_3 then
						if arg_186_1.isInRecall_ then
							iter_189_3.color = arg_186_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_189_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_186_1.var_.actorSpriteComps10014 = nil
			end

			local var_189_8 = arg_186_1.actors_["10115"]
			local var_189_9 = 0

			if var_189_9 < arg_186_1.time_ and arg_186_1.time_ <= var_189_9 + arg_189_0 and not isNil(var_189_8) and arg_186_1.var_.actorSpriteComps10115 == nil then
				arg_186_1.var_.actorSpriteComps10115 = var_189_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_189_10 = 0.2

			if var_189_9 <= arg_186_1.time_ and arg_186_1.time_ < var_189_9 + var_189_10 and not isNil(var_189_8) then
				local var_189_11 = (arg_186_1.time_ - var_189_9) / var_189_10

				if arg_186_1.var_.actorSpriteComps10115 then
					for iter_189_4, iter_189_5 in pairs(arg_186_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_189_5 then
							if arg_186_1.isInRecall_ then
								local var_189_12 = Mathf.Lerp(iter_189_5.color.r, arg_186_1.hightColor2.r, var_189_11)
								local var_189_13 = Mathf.Lerp(iter_189_5.color.g, arg_186_1.hightColor2.g, var_189_11)
								local var_189_14 = Mathf.Lerp(iter_189_5.color.b, arg_186_1.hightColor2.b, var_189_11)

								iter_189_5.color = Color.New(var_189_12, var_189_13, var_189_14)
							else
								local var_189_15 = Mathf.Lerp(iter_189_5.color.r, 0.5, var_189_11)

								iter_189_5.color = Color.New(var_189_15, var_189_15, var_189_15)
							end
						end
					end
				end
			end

			if arg_186_1.time_ >= var_189_9 + var_189_10 and arg_186_1.time_ < var_189_9 + var_189_10 + arg_189_0 and not isNil(var_189_8) and arg_186_1.var_.actorSpriteComps10115 then
				for iter_189_6, iter_189_7 in pairs(arg_186_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_189_7 then
						if arg_186_1.isInRecall_ then
							iter_189_7.color = arg_186_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_189_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_186_1.var_.actorSpriteComps10115 = nil
			end

			local var_189_16 = 0
			local var_189_17 = 0.275

			if var_189_16 < arg_186_1.time_ and arg_186_1.time_ <= var_189_16 + arg_189_0 then
				arg_186_1.talkMaxDuration = 0
				arg_186_1.dialogCg_.alpha = 1

				arg_186_1.dialog_:SetActive(true)
				SetActive(arg_186_1.leftNameGo_, true)

				local var_189_18 = arg_186_1:FormatText(StoryNameCfg[264].name)

				arg_186_1.leftNameTxt_.text = var_189_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_186_1.leftNameTxt_.transform)

				arg_186_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_186_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_186_1:RecordName(arg_186_1.leftNameTxt_.text)
				SetActive(arg_186_1.iconTrs_.gameObject, false)
				arg_186_1.callingController_:SetSelectedState("normal")

				local var_189_19 = arg_186_1:GetWordFromCfg(417261045)
				local var_189_20 = arg_186_1:FormatText(var_189_19.content)

				arg_186_1.text_.text = var_189_20

				LuaForUtil.ClearLinePrefixSymbol(arg_186_1.text_)

				local var_189_21 = 11
				local var_189_22 = utf8.len(var_189_20)
				local var_189_23 = var_189_21 <= 0 and var_189_17 or var_189_17 * (var_189_22 / var_189_21)

				if var_189_23 > 0 and var_189_17 < var_189_23 then
					arg_186_1.talkMaxDuration = var_189_23

					if var_189_23 + var_189_16 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_23 + var_189_16
					end
				end

				arg_186_1.text_.text = var_189_20
				arg_186_1.typewritter.percent = 0

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417261", "417261045", "story_v_out_417261.awb") ~= 0 then
					local var_189_24 = manager.audio:GetVoiceLength("story_v_out_417261", "417261045", "story_v_out_417261.awb") / 1000

					if var_189_24 + var_189_16 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_24 + var_189_16
					end

					if var_189_19.prefab_name ~= "" and arg_186_1.actors_[var_189_19.prefab_name] ~= nil then
						local var_189_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_186_1.actors_[var_189_19.prefab_name].transform, "story_v_out_417261", "417261045", "story_v_out_417261.awb")

						arg_186_1:RecordAudio("417261045", var_189_25)
						arg_186_1:RecordAudio("417261045", var_189_25)
					else
						arg_186_1:AudioAction("play", "voice", "story_v_out_417261", "417261045", "story_v_out_417261.awb")
					end

					arg_186_1:RecordHistoryTalkVoice("story_v_out_417261", "417261045", "story_v_out_417261.awb")
				end

				arg_186_1:RecordContent(arg_186_1.text_.text)
			end

			local var_189_26 = math.max(var_189_17, arg_186_1.talkMaxDuration)

			if var_189_16 <= arg_186_1.time_ and arg_186_1.time_ < var_189_16 + var_189_26 then
				arg_186_1.typewritter.percent = (arg_186_1.time_ - var_189_16) / var_189_26

				arg_186_1.typewritter:SetDirty()
			end

			if arg_186_1.time_ >= var_189_16 + var_189_26 and arg_186_1.time_ < var_189_16 + var_189_26 + arg_189_0 then
				arg_186_1.typewritter.percent = 1

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(true)
			end
		end

		arg_186_1.nodeConfigList_ = {}

		arg_186_1:InitPlayNodeList()
	end,
	Play417261046 = function(arg_190_0, arg_190_1)
		arg_190_1.time_ = 0
		arg_190_1.frameCnt_ = 0
		arg_190_1.state_ = "playing"
		arg_190_1.curTalkId_ = 417261046
		arg_190_1.duration_ = 5

		SetActive(arg_190_1.tipsGo_, false)

		function arg_190_1.onSingleLineFinish_()
			arg_190_1.onSingleLineUpdate_ = nil
			arg_190_1.onSingleLineFinish_ = nil
			arg_190_1.state_ = "waiting"
		end

		function arg_190_1.playNext_(arg_192_0)
			if arg_192_0 == 1 then
				arg_190_0:Play417261047(arg_190_1)
			end
		end

		function arg_190_1.onSingleLineUpdate_(arg_193_0)
			local var_193_0 = arg_190_1.actors_["10014"]
			local var_193_1 = 0

			if var_193_1 < arg_190_1.time_ and arg_190_1.time_ <= var_193_1 + arg_193_0 and not isNil(var_193_0) and arg_190_1.var_.actorSpriteComps10014 == nil then
				arg_190_1.var_.actorSpriteComps10014 = var_193_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_193_2 = 0.2

			if var_193_1 <= arg_190_1.time_ and arg_190_1.time_ < var_193_1 + var_193_2 and not isNil(var_193_0) then
				local var_193_3 = (arg_190_1.time_ - var_193_1) / var_193_2

				if arg_190_1.var_.actorSpriteComps10014 then
					for iter_193_0, iter_193_1 in pairs(arg_190_1.var_.actorSpriteComps10014:ToTable()) do
						if iter_193_1 then
							if arg_190_1.isInRecall_ then
								local var_193_4 = Mathf.Lerp(iter_193_1.color.r, arg_190_1.hightColor2.r, var_193_3)
								local var_193_5 = Mathf.Lerp(iter_193_1.color.g, arg_190_1.hightColor2.g, var_193_3)
								local var_193_6 = Mathf.Lerp(iter_193_1.color.b, arg_190_1.hightColor2.b, var_193_3)

								iter_193_1.color = Color.New(var_193_4, var_193_5, var_193_6)
							else
								local var_193_7 = Mathf.Lerp(iter_193_1.color.r, 0.5, var_193_3)

								iter_193_1.color = Color.New(var_193_7, var_193_7, var_193_7)
							end
						end
					end
				end
			end

			if arg_190_1.time_ >= var_193_1 + var_193_2 and arg_190_1.time_ < var_193_1 + var_193_2 + arg_193_0 and not isNil(var_193_0) and arg_190_1.var_.actorSpriteComps10014 then
				for iter_193_2, iter_193_3 in pairs(arg_190_1.var_.actorSpriteComps10014:ToTable()) do
					if iter_193_3 then
						if arg_190_1.isInRecall_ then
							iter_193_3.color = arg_190_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_193_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_190_1.var_.actorSpriteComps10014 = nil
			end

			local var_193_8 = 0
			local var_193_9 = 1

			if var_193_8 < arg_190_1.time_ and arg_190_1.time_ <= var_193_8 + arg_193_0 then
				arg_190_1.talkMaxDuration = 0
				arg_190_1.dialogCg_.alpha = 1

				arg_190_1.dialog_:SetActive(true)
				SetActive(arg_190_1.leftNameGo_, false)

				arg_190_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_190_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_190_1:RecordName(arg_190_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_190_1.iconTrs_.gameObject, false)
				arg_190_1.callingController_:SetSelectedState("normal")

				local var_193_10 = arg_190_1:GetWordFromCfg(417261046)
				local var_193_11 = arg_190_1:FormatText(var_193_10.content)

				arg_190_1.text_.text = var_193_11

				LuaForUtil.ClearLinePrefixSymbol(arg_190_1.text_)

				local var_193_12 = 40
				local var_193_13 = utf8.len(var_193_11)
				local var_193_14 = var_193_12 <= 0 and var_193_9 or var_193_9 * (var_193_13 / var_193_12)

				if var_193_14 > 0 and var_193_9 < var_193_14 then
					arg_190_1.talkMaxDuration = var_193_14

					if var_193_14 + var_193_8 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_14 + var_193_8
					end
				end

				arg_190_1.text_.text = var_193_11
				arg_190_1.typewritter.percent = 0

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(false)
				arg_190_1:RecordContent(arg_190_1.text_.text)
			end

			local var_193_15 = math.max(var_193_9, arg_190_1.talkMaxDuration)

			if var_193_8 <= arg_190_1.time_ and arg_190_1.time_ < var_193_8 + var_193_15 then
				arg_190_1.typewritter.percent = (arg_190_1.time_ - var_193_8) / var_193_15

				arg_190_1.typewritter:SetDirty()
			end

			if arg_190_1.time_ >= var_193_8 + var_193_15 and arg_190_1.time_ < var_193_8 + var_193_15 + arg_193_0 then
				arg_190_1.typewritter.percent = 1

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(true)
			end
		end

		arg_190_1.nodeConfigList_ = {}

		arg_190_1:InitPlayNodeList()
	end,
	Play417261047 = function(arg_194_0, arg_194_1)
		arg_194_1.time_ = 0
		arg_194_1.frameCnt_ = 0
		arg_194_1.state_ = "playing"
		arg_194_1.curTalkId_ = 417261047
		arg_194_1.duration_ = 7.73

		local var_194_0 = {
			zh = 5.366,
			ja = 7.733
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
				arg_194_0:Play417261048(arg_194_1)
			end
		end

		function arg_194_1.onSingleLineUpdate_(arg_197_0)
			local var_197_0 = arg_194_1.actors_["10115"]
			local var_197_1 = 0

			if var_197_1 < arg_194_1.time_ and arg_194_1.time_ <= var_197_1 + arg_197_0 and not isNil(var_197_0) and arg_194_1.var_.actorSpriteComps10115 == nil then
				arg_194_1.var_.actorSpriteComps10115 = var_197_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_197_2 = 0.2

			if var_197_1 <= arg_194_1.time_ and arg_194_1.time_ < var_197_1 + var_197_2 and not isNil(var_197_0) then
				local var_197_3 = (arg_194_1.time_ - var_197_1) / var_197_2

				if arg_194_1.var_.actorSpriteComps10115 then
					for iter_197_0, iter_197_1 in pairs(arg_194_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_197_1 then
							if arg_194_1.isInRecall_ then
								local var_197_4 = Mathf.Lerp(iter_197_1.color.r, arg_194_1.hightColor1.r, var_197_3)
								local var_197_5 = Mathf.Lerp(iter_197_1.color.g, arg_194_1.hightColor1.g, var_197_3)
								local var_197_6 = Mathf.Lerp(iter_197_1.color.b, arg_194_1.hightColor1.b, var_197_3)

								iter_197_1.color = Color.New(var_197_4, var_197_5, var_197_6)
							else
								local var_197_7 = Mathf.Lerp(iter_197_1.color.r, 1, var_197_3)

								iter_197_1.color = Color.New(var_197_7, var_197_7, var_197_7)
							end
						end
					end
				end
			end

			if arg_194_1.time_ >= var_197_1 + var_197_2 and arg_194_1.time_ < var_197_1 + var_197_2 + arg_197_0 and not isNil(var_197_0) and arg_194_1.var_.actorSpriteComps10115 then
				for iter_197_2, iter_197_3 in pairs(arg_194_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_197_3 then
						if arg_194_1.isInRecall_ then
							iter_197_3.color = arg_194_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_197_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_194_1.var_.actorSpriteComps10115 = nil
			end

			local var_197_8 = 0
			local var_197_9 = 0.8

			if var_197_8 < arg_194_1.time_ and arg_194_1.time_ <= var_197_8 + arg_197_0 then
				arg_194_1.talkMaxDuration = 0
				arg_194_1.dialogCg_.alpha = 1

				arg_194_1.dialog_:SetActive(true)
				SetActive(arg_194_1.leftNameGo_, true)

				local var_197_10 = arg_194_1:FormatText(StoryNameCfg[1113].name)

				arg_194_1.leftNameTxt_.text = var_197_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_194_1.leftNameTxt_.transform)

				arg_194_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_194_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_194_1:RecordName(arg_194_1.leftNameTxt_.text)
				SetActive(arg_194_1.iconTrs_.gameObject, false)
				arg_194_1.callingController_:SetSelectedState("normal")

				local var_197_11 = arg_194_1:GetWordFromCfg(417261047)
				local var_197_12 = arg_194_1:FormatText(var_197_11.content)

				arg_194_1.text_.text = var_197_12

				LuaForUtil.ClearLinePrefixSymbol(arg_194_1.text_)

				local var_197_13 = 32
				local var_197_14 = utf8.len(var_197_12)
				local var_197_15 = var_197_13 <= 0 and var_197_9 or var_197_9 * (var_197_14 / var_197_13)

				if var_197_15 > 0 and var_197_9 < var_197_15 then
					arg_194_1.talkMaxDuration = var_197_15

					if var_197_15 + var_197_8 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_15 + var_197_8
					end
				end

				arg_194_1.text_.text = var_197_12
				arg_194_1.typewritter.percent = 0

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417261", "417261047", "story_v_out_417261.awb") ~= 0 then
					local var_197_16 = manager.audio:GetVoiceLength("story_v_out_417261", "417261047", "story_v_out_417261.awb") / 1000

					if var_197_16 + var_197_8 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_16 + var_197_8
					end

					if var_197_11.prefab_name ~= "" and arg_194_1.actors_[var_197_11.prefab_name] ~= nil then
						local var_197_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_194_1.actors_[var_197_11.prefab_name].transform, "story_v_out_417261", "417261047", "story_v_out_417261.awb")

						arg_194_1:RecordAudio("417261047", var_197_17)
						arg_194_1:RecordAudio("417261047", var_197_17)
					else
						arg_194_1:AudioAction("play", "voice", "story_v_out_417261", "417261047", "story_v_out_417261.awb")
					end

					arg_194_1:RecordHistoryTalkVoice("story_v_out_417261", "417261047", "story_v_out_417261.awb")
				end

				arg_194_1:RecordContent(arg_194_1.text_.text)
			end

			local var_197_18 = math.max(var_197_9, arg_194_1.talkMaxDuration)

			if var_197_8 <= arg_194_1.time_ and arg_194_1.time_ < var_197_8 + var_197_18 then
				arg_194_1.typewritter.percent = (arg_194_1.time_ - var_197_8) / var_197_18

				arg_194_1.typewritter:SetDirty()
			end

			if arg_194_1.time_ >= var_197_8 + var_197_18 and arg_194_1.time_ < var_197_8 + var_197_18 + arg_197_0 then
				arg_194_1.typewritter.percent = 1

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(true)
			end
		end

		arg_194_1.nodeConfigList_ = {}

		arg_194_1:InitPlayNodeList()
	end,
	Play417261048 = function(arg_198_0, arg_198_1)
		arg_198_1.time_ = 0
		arg_198_1.frameCnt_ = 0
		arg_198_1.state_ = "playing"
		arg_198_1.curTalkId_ = 417261048
		arg_198_1.duration_ = 2.2

		local var_198_0 = {
			zh = 1.3,
			ja = 2.2
		}
		local var_198_1 = manager.audio:GetLocalizationFlag()

		if var_198_0[var_198_1] ~= nil then
			arg_198_1.duration_ = var_198_0[var_198_1]
		end

		SetActive(arg_198_1.tipsGo_, false)

		function arg_198_1.onSingleLineFinish_()
			arg_198_1.onSingleLineUpdate_ = nil
			arg_198_1.onSingleLineFinish_ = nil
			arg_198_1.state_ = "waiting"
		end

		function arg_198_1.playNext_(arg_200_0)
			if arg_200_0 == 1 then
				arg_198_0:Play417261049(arg_198_1)
			end
		end

		function arg_198_1.onSingleLineUpdate_(arg_201_0)
			local var_201_0 = arg_198_1.actors_["10014"]
			local var_201_1 = 0

			if var_201_1 < arg_198_1.time_ and arg_198_1.time_ <= var_201_1 + arg_201_0 and not isNil(var_201_0) and arg_198_1.var_.actorSpriteComps10014 == nil then
				arg_198_1.var_.actorSpriteComps10014 = var_201_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_201_2 = 0.2

			if var_201_1 <= arg_198_1.time_ and arg_198_1.time_ < var_201_1 + var_201_2 and not isNil(var_201_0) then
				local var_201_3 = (arg_198_1.time_ - var_201_1) / var_201_2

				if arg_198_1.var_.actorSpriteComps10014 then
					for iter_201_0, iter_201_1 in pairs(arg_198_1.var_.actorSpriteComps10014:ToTable()) do
						if iter_201_1 then
							if arg_198_1.isInRecall_ then
								local var_201_4 = Mathf.Lerp(iter_201_1.color.r, arg_198_1.hightColor1.r, var_201_3)
								local var_201_5 = Mathf.Lerp(iter_201_1.color.g, arg_198_1.hightColor1.g, var_201_3)
								local var_201_6 = Mathf.Lerp(iter_201_1.color.b, arg_198_1.hightColor1.b, var_201_3)

								iter_201_1.color = Color.New(var_201_4, var_201_5, var_201_6)
							else
								local var_201_7 = Mathf.Lerp(iter_201_1.color.r, 1, var_201_3)

								iter_201_1.color = Color.New(var_201_7, var_201_7, var_201_7)
							end
						end
					end
				end
			end

			if arg_198_1.time_ >= var_201_1 + var_201_2 and arg_198_1.time_ < var_201_1 + var_201_2 + arg_201_0 and not isNil(var_201_0) and arg_198_1.var_.actorSpriteComps10014 then
				for iter_201_2, iter_201_3 in pairs(arg_198_1.var_.actorSpriteComps10014:ToTable()) do
					if iter_201_3 then
						if arg_198_1.isInRecall_ then
							iter_201_3.color = arg_198_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_201_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_198_1.var_.actorSpriteComps10014 = nil
			end

			local var_201_8 = arg_198_1.actors_["10115"]
			local var_201_9 = 0

			if var_201_9 < arg_198_1.time_ and arg_198_1.time_ <= var_201_9 + arg_201_0 and not isNil(var_201_8) and arg_198_1.var_.actorSpriteComps10115 == nil then
				arg_198_1.var_.actorSpriteComps10115 = var_201_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_201_10 = 0.2

			if var_201_9 <= arg_198_1.time_ and arg_198_1.time_ < var_201_9 + var_201_10 and not isNil(var_201_8) then
				local var_201_11 = (arg_198_1.time_ - var_201_9) / var_201_10

				if arg_198_1.var_.actorSpriteComps10115 then
					for iter_201_4, iter_201_5 in pairs(arg_198_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_201_5 then
							if arg_198_1.isInRecall_ then
								local var_201_12 = Mathf.Lerp(iter_201_5.color.r, arg_198_1.hightColor2.r, var_201_11)
								local var_201_13 = Mathf.Lerp(iter_201_5.color.g, arg_198_1.hightColor2.g, var_201_11)
								local var_201_14 = Mathf.Lerp(iter_201_5.color.b, arg_198_1.hightColor2.b, var_201_11)

								iter_201_5.color = Color.New(var_201_12, var_201_13, var_201_14)
							else
								local var_201_15 = Mathf.Lerp(iter_201_5.color.r, 0.5, var_201_11)

								iter_201_5.color = Color.New(var_201_15, var_201_15, var_201_15)
							end
						end
					end
				end
			end

			if arg_198_1.time_ >= var_201_9 + var_201_10 and arg_198_1.time_ < var_201_9 + var_201_10 + arg_201_0 and not isNil(var_201_8) and arg_198_1.var_.actorSpriteComps10115 then
				for iter_201_6, iter_201_7 in pairs(arg_198_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_201_7 then
						if arg_198_1.isInRecall_ then
							iter_201_7.color = arg_198_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_201_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_198_1.var_.actorSpriteComps10115 = nil
			end

			local var_201_16 = 0
			local var_201_17 = 0.125

			if var_201_16 < arg_198_1.time_ and arg_198_1.time_ <= var_201_16 + arg_201_0 then
				arg_198_1.talkMaxDuration = 0
				arg_198_1.dialogCg_.alpha = 1

				arg_198_1.dialog_:SetActive(true)
				SetActive(arg_198_1.leftNameGo_, true)

				local var_201_18 = arg_198_1:FormatText(StoryNameCfg[264].name)

				arg_198_1.leftNameTxt_.text = var_201_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_198_1.leftNameTxt_.transform)

				arg_198_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_198_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_198_1:RecordName(arg_198_1.leftNameTxt_.text)
				SetActive(arg_198_1.iconTrs_.gameObject, false)
				arg_198_1.callingController_:SetSelectedState("normal")

				local var_201_19 = arg_198_1:GetWordFromCfg(417261048)
				local var_201_20 = arg_198_1:FormatText(var_201_19.content)

				arg_198_1.text_.text = var_201_20

				LuaForUtil.ClearLinePrefixSymbol(arg_198_1.text_)

				local var_201_21 = 5
				local var_201_22 = utf8.len(var_201_20)
				local var_201_23 = var_201_21 <= 0 and var_201_17 or var_201_17 * (var_201_22 / var_201_21)

				if var_201_23 > 0 and var_201_17 < var_201_23 then
					arg_198_1.talkMaxDuration = var_201_23

					if var_201_23 + var_201_16 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_23 + var_201_16
					end
				end

				arg_198_1.text_.text = var_201_20
				arg_198_1.typewritter.percent = 0

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417261", "417261048", "story_v_out_417261.awb") ~= 0 then
					local var_201_24 = manager.audio:GetVoiceLength("story_v_out_417261", "417261048", "story_v_out_417261.awb") / 1000

					if var_201_24 + var_201_16 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_24 + var_201_16
					end

					if var_201_19.prefab_name ~= "" and arg_198_1.actors_[var_201_19.prefab_name] ~= nil then
						local var_201_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_198_1.actors_[var_201_19.prefab_name].transform, "story_v_out_417261", "417261048", "story_v_out_417261.awb")

						arg_198_1:RecordAudio("417261048", var_201_25)
						arg_198_1:RecordAudio("417261048", var_201_25)
					else
						arg_198_1:AudioAction("play", "voice", "story_v_out_417261", "417261048", "story_v_out_417261.awb")
					end

					arg_198_1:RecordHistoryTalkVoice("story_v_out_417261", "417261048", "story_v_out_417261.awb")
				end

				arg_198_1:RecordContent(arg_198_1.text_.text)
			end

			local var_201_26 = math.max(var_201_17, arg_198_1.talkMaxDuration)

			if var_201_16 <= arg_198_1.time_ and arg_198_1.time_ < var_201_16 + var_201_26 then
				arg_198_1.typewritter.percent = (arg_198_1.time_ - var_201_16) / var_201_26

				arg_198_1.typewritter:SetDirty()
			end

			if arg_198_1.time_ >= var_201_16 + var_201_26 and arg_198_1.time_ < var_201_16 + var_201_26 + arg_201_0 then
				arg_198_1.typewritter.percent = 1

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(true)
			end
		end

		arg_198_1.nodeConfigList_ = {}

		arg_198_1:InitPlayNodeList()
	end,
	Play417261049 = function(arg_202_0, arg_202_1)
		arg_202_1.time_ = 0
		arg_202_1.frameCnt_ = 0
		arg_202_1.state_ = "playing"
		arg_202_1.curTalkId_ = 417261049
		arg_202_1.duration_ = 8.73

		local var_202_0 = {
			zh = 6.533,
			ja = 8.733
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
				arg_202_0:Play417261050(arg_202_1)
			end
		end

		function arg_202_1.onSingleLineUpdate_(arg_205_0)
			local var_205_0 = 0
			local var_205_1 = 0.7

			if var_205_0 < arg_202_1.time_ and arg_202_1.time_ <= var_205_0 + arg_205_0 then
				arg_202_1.talkMaxDuration = 0
				arg_202_1.dialogCg_.alpha = 1

				arg_202_1.dialog_:SetActive(true)
				SetActive(arg_202_1.leftNameGo_, true)

				local var_205_2 = arg_202_1:FormatText(StoryNameCfg[264].name)

				arg_202_1.leftNameTxt_.text = var_205_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_202_1.leftNameTxt_.transform)

				arg_202_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_202_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_202_1:RecordName(arg_202_1.leftNameTxt_.text)
				SetActive(arg_202_1.iconTrs_.gameObject, false)
				arg_202_1.callingController_:SetSelectedState("normal")

				local var_205_3 = arg_202_1:GetWordFromCfg(417261049)
				local var_205_4 = arg_202_1:FormatText(var_205_3.content)

				arg_202_1.text_.text = var_205_4

				LuaForUtil.ClearLinePrefixSymbol(arg_202_1.text_)

				local var_205_5 = 28
				local var_205_6 = utf8.len(var_205_4)
				local var_205_7 = var_205_5 <= 0 and var_205_1 or var_205_1 * (var_205_6 / var_205_5)

				if var_205_7 > 0 and var_205_1 < var_205_7 then
					arg_202_1.talkMaxDuration = var_205_7

					if var_205_7 + var_205_0 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_7 + var_205_0
					end
				end

				arg_202_1.text_.text = var_205_4
				arg_202_1.typewritter.percent = 0

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417261", "417261049", "story_v_out_417261.awb") ~= 0 then
					local var_205_8 = manager.audio:GetVoiceLength("story_v_out_417261", "417261049", "story_v_out_417261.awb") / 1000

					if var_205_8 + var_205_0 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_8 + var_205_0
					end

					if var_205_3.prefab_name ~= "" and arg_202_1.actors_[var_205_3.prefab_name] ~= nil then
						local var_205_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_202_1.actors_[var_205_3.prefab_name].transform, "story_v_out_417261", "417261049", "story_v_out_417261.awb")

						arg_202_1:RecordAudio("417261049", var_205_9)
						arg_202_1:RecordAudio("417261049", var_205_9)
					else
						arg_202_1:AudioAction("play", "voice", "story_v_out_417261", "417261049", "story_v_out_417261.awb")
					end

					arg_202_1:RecordHistoryTalkVoice("story_v_out_417261", "417261049", "story_v_out_417261.awb")
				end

				arg_202_1:RecordContent(arg_202_1.text_.text)
			end

			local var_205_10 = math.max(var_205_1, arg_202_1.talkMaxDuration)

			if var_205_0 <= arg_202_1.time_ and arg_202_1.time_ < var_205_0 + var_205_10 then
				arg_202_1.typewritter.percent = (arg_202_1.time_ - var_205_0) / var_205_10

				arg_202_1.typewritter:SetDirty()
			end

			if arg_202_1.time_ >= var_205_0 + var_205_10 and arg_202_1.time_ < var_205_0 + var_205_10 + arg_205_0 then
				arg_202_1.typewritter.percent = 1

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(true)
			end
		end

		arg_202_1.nodeConfigList_ = {}

		arg_202_1:InitPlayNodeList()
	end,
	Play417261050 = function(arg_206_0, arg_206_1)
		arg_206_1.time_ = 0
		arg_206_1.frameCnt_ = 0
		arg_206_1.state_ = "playing"
		arg_206_1.curTalkId_ = 417261050
		arg_206_1.duration_ = 8

		local var_206_0 = {
			zh = 5.233,
			ja = 8
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
				arg_206_0:Play417261051(arg_206_1)
			end
		end

		function arg_206_1.onSingleLineUpdate_(arg_209_0)
			local var_209_0 = 0
			local var_209_1 = 0.6

			if var_209_0 < arg_206_1.time_ and arg_206_1.time_ <= var_209_0 + arg_209_0 then
				arg_206_1.talkMaxDuration = 0
				arg_206_1.dialogCg_.alpha = 1

				arg_206_1.dialog_:SetActive(true)
				SetActive(arg_206_1.leftNameGo_, true)

				local var_209_2 = arg_206_1:FormatText(StoryNameCfg[264].name)

				arg_206_1.leftNameTxt_.text = var_209_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_206_1.leftNameTxt_.transform)

				arg_206_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_206_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_206_1:RecordName(arg_206_1.leftNameTxt_.text)
				SetActive(arg_206_1.iconTrs_.gameObject, false)
				arg_206_1.callingController_:SetSelectedState("normal")

				local var_209_3 = arg_206_1:GetWordFromCfg(417261050)
				local var_209_4 = arg_206_1:FormatText(var_209_3.content)

				arg_206_1.text_.text = var_209_4

				LuaForUtil.ClearLinePrefixSymbol(arg_206_1.text_)

				local var_209_5 = 24
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

				if manager.audio:GetVoiceLength("story_v_out_417261", "417261050", "story_v_out_417261.awb") ~= 0 then
					local var_209_8 = manager.audio:GetVoiceLength("story_v_out_417261", "417261050", "story_v_out_417261.awb") / 1000

					if var_209_8 + var_209_0 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_8 + var_209_0
					end

					if var_209_3.prefab_name ~= "" and arg_206_1.actors_[var_209_3.prefab_name] ~= nil then
						local var_209_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_206_1.actors_[var_209_3.prefab_name].transform, "story_v_out_417261", "417261050", "story_v_out_417261.awb")

						arg_206_1:RecordAudio("417261050", var_209_9)
						arg_206_1:RecordAudio("417261050", var_209_9)
					else
						arg_206_1:AudioAction("play", "voice", "story_v_out_417261", "417261050", "story_v_out_417261.awb")
					end

					arg_206_1:RecordHistoryTalkVoice("story_v_out_417261", "417261050", "story_v_out_417261.awb")
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
	Play417261051 = function(arg_210_0, arg_210_1)
		arg_210_1.time_ = 0
		arg_210_1.frameCnt_ = 0
		arg_210_1.state_ = "playing"
		arg_210_1.curTalkId_ = 417261051
		arg_210_1.duration_ = 5.8

		local var_210_0 = {
			zh = 4.133,
			ja = 5.8
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
				arg_210_0:Play417261052(arg_210_1)
			end
		end

		function arg_210_1.onSingleLineUpdate_(arg_213_0)
			local var_213_0 = arg_210_1.actors_["10014"]
			local var_213_1 = 0

			if var_213_1 < arg_210_1.time_ and arg_210_1.time_ <= var_213_1 + arg_213_0 and not isNil(var_213_0) and arg_210_1.var_.actorSpriteComps10014 == nil then
				arg_210_1.var_.actorSpriteComps10014 = var_213_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_213_2 = 0.2

			if var_213_1 <= arg_210_1.time_ and arg_210_1.time_ < var_213_1 + var_213_2 and not isNil(var_213_0) then
				local var_213_3 = (arg_210_1.time_ - var_213_1) / var_213_2

				if arg_210_1.var_.actorSpriteComps10014 then
					for iter_213_0, iter_213_1 in pairs(arg_210_1.var_.actorSpriteComps10014:ToTable()) do
						if iter_213_1 then
							if arg_210_1.isInRecall_ then
								local var_213_4 = Mathf.Lerp(iter_213_1.color.r, arg_210_1.hightColor2.r, var_213_3)
								local var_213_5 = Mathf.Lerp(iter_213_1.color.g, arg_210_1.hightColor2.g, var_213_3)
								local var_213_6 = Mathf.Lerp(iter_213_1.color.b, arg_210_1.hightColor2.b, var_213_3)

								iter_213_1.color = Color.New(var_213_4, var_213_5, var_213_6)
							else
								local var_213_7 = Mathf.Lerp(iter_213_1.color.r, 0.5, var_213_3)

								iter_213_1.color = Color.New(var_213_7, var_213_7, var_213_7)
							end
						end
					end
				end
			end

			if arg_210_1.time_ >= var_213_1 + var_213_2 and arg_210_1.time_ < var_213_1 + var_213_2 + arg_213_0 and not isNil(var_213_0) and arg_210_1.var_.actorSpriteComps10014 then
				for iter_213_2, iter_213_3 in pairs(arg_210_1.var_.actorSpriteComps10014:ToTable()) do
					if iter_213_3 then
						if arg_210_1.isInRecall_ then
							iter_213_3.color = arg_210_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_213_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_210_1.var_.actorSpriteComps10014 = nil
			end

			local var_213_8 = arg_210_1.actors_["10115"]
			local var_213_9 = 0

			if var_213_9 < arg_210_1.time_ and arg_210_1.time_ <= var_213_9 + arg_213_0 and not isNil(var_213_8) and arg_210_1.var_.actorSpriteComps10115 == nil then
				arg_210_1.var_.actorSpriteComps10115 = var_213_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_213_10 = 0.2

			if var_213_9 <= arg_210_1.time_ and arg_210_1.time_ < var_213_9 + var_213_10 and not isNil(var_213_8) then
				local var_213_11 = (arg_210_1.time_ - var_213_9) / var_213_10

				if arg_210_1.var_.actorSpriteComps10115 then
					for iter_213_4, iter_213_5 in pairs(arg_210_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_213_5 then
							if arg_210_1.isInRecall_ then
								local var_213_12 = Mathf.Lerp(iter_213_5.color.r, arg_210_1.hightColor1.r, var_213_11)
								local var_213_13 = Mathf.Lerp(iter_213_5.color.g, arg_210_1.hightColor1.g, var_213_11)
								local var_213_14 = Mathf.Lerp(iter_213_5.color.b, arg_210_1.hightColor1.b, var_213_11)

								iter_213_5.color = Color.New(var_213_12, var_213_13, var_213_14)
							else
								local var_213_15 = Mathf.Lerp(iter_213_5.color.r, 1, var_213_11)

								iter_213_5.color = Color.New(var_213_15, var_213_15, var_213_15)
							end
						end
					end
				end
			end

			if arg_210_1.time_ >= var_213_9 + var_213_10 and arg_210_1.time_ < var_213_9 + var_213_10 + arg_213_0 and not isNil(var_213_8) and arg_210_1.var_.actorSpriteComps10115 then
				for iter_213_6, iter_213_7 in pairs(arg_210_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_213_7 then
						if arg_210_1.isInRecall_ then
							iter_213_7.color = arg_210_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_213_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_210_1.var_.actorSpriteComps10115 = nil
			end

			local var_213_16 = 0
			local var_213_17 = 0.55

			if var_213_16 < arg_210_1.time_ and arg_210_1.time_ <= var_213_16 + arg_213_0 then
				arg_210_1.talkMaxDuration = 0
				arg_210_1.dialogCg_.alpha = 1

				arg_210_1.dialog_:SetActive(true)
				SetActive(arg_210_1.leftNameGo_, true)

				local var_213_18 = arg_210_1:FormatText(StoryNameCfg[1113].name)

				arg_210_1.leftNameTxt_.text = var_213_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_210_1.leftNameTxt_.transform)

				arg_210_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_210_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_210_1:RecordName(arg_210_1.leftNameTxt_.text)
				SetActive(arg_210_1.iconTrs_.gameObject, false)
				arg_210_1.callingController_:SetSelectedState("normal")

				local var_213_19 = arg_210_1:GetWordFromCfg(417261051)
				local var_213_20 = arg_210_1:FormatText(var_213_19.content)

				arg_210_1.text_.text = var_213_20

				LuaForUtil.ClearLinePrefixSymbol(arg_210_1.text_)

				local var_213_21 = 22
				local var_213_22 = utf8.len(var_213_20)
				local var_213_23 = var_213_21 <= 0 and var_213_17 or var_213_17 * (var_213_22 / var_213_21)

				if var_213_23 > 0 and var_213_17 < var_213_23 then
					arg_210_1.talkMaxDuration = var_213_23

					if var_213_23 + var_213_16 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_23 + var_213_16
					end
				end

				arg_210_1.text_.text = var_213_20
				arg_210_1.typewritter.percent = 0

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417261", "417261051", "story_v_out_417261.awb") ~= 0 then
					local var_213_24 = manager.audio:GetVoiceLength("story_v_out_417261", "417261051", "story_v_out_417261.awb") / 1000

					if var_213_24 + var_213_16 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_24 + var_213_16
					end

					if var_213_19.prefab_name ~= "" and arg_210_1.actors_[var_213_19.prefab_name] ~= nil then
						local var_213_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_210_1.actors_[var_213_19.prefab_name].transform, "story_v_out_417261", "417261051", "story_v_out_417261.awb")

						arg_210_1:RecordAudio("417261051", var_213_25)
						arg_210_1:RecordAudio("417261051", var_213_25)
					else
						arg_210_1:AudioAction("play", "voice", "story_v_out_417261", "417261051", "story_v_out_417261.awb")
					end

					arg_210_1:RecordHistoryTalkVoice("story_v_out_417261", "417261051", "story_v_out_417261.awb")
				end

				arg_210_1:RecordContent(arg_210_1.text_.text)
			end

			local var_213_26 = math.max(var_213_17, arg_210_1.talkMaxDuration)

			if var_213_16 <= arg_210_1.time_ and arg_210_1.time_ < var_213_16 + var_213_26 then
				arg_210_1.typewritter.percent = (arg_210_1.time_ - var_213_16) / var_213_26

				arg_210_1.typewritter:SetDirty()
			end

			if arg_210_1.time_ >= var_213_16 + var_213_26 and arg_210_1.time_ < var_213_16 + var_213_26 + arg_213_0 then
				arg_210_1.typewritter.percent = 1

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(true)
			end
		end

		arg_210_1.nodeConfigList_ = {}

		arg_210_1:InitPlayNodeList()
	end,
	Play417261052 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 417261052
		arg_214_1.duration_ = 5.47

		local var_214_0 = {
			zh = 2.266,
			ja = 5.466
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
				arg_214_0:Play417261053(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			local var_217_0 = arg_214_1.actors_["10014"]
			local var_217_1 = 0

			if var_217_1 < arg_214_1.time_ and arg_214_1.time_ <= var_217_1 + arg_217_0 and not isNil(var_217_0) and arg_214_1.var_.actorSpriteComps10014 == nil then
				arg_214_1.var_.actorSpriteComps10014 = var_217_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_217_2 = 0.2

			if var_217_1 <= arg_214_1.time_ and arg_214_1.time_ < var_217_1 + var_217_2 and not isNil(var_217_0) then
				local var_217_3 = (arg_214_1.time_ - var_217_1) / var_217_2

				if arg_214_1.var_.actorSpriteComps10014 then
					for iter_217_0, iter_217_1 in pairs(arg_214_1.var_.actorSpriteComps10014:ToTable()) do
						if iter_217_1 then
							if arg_214_1.isInRecall_ then
								local var_217_4 = Mathf.Lerp(iter_217_1.color.r, arg_214_1.hightColor1.r, var_217_3)
								local var_217_5 = Mathf.Lerp(iter_217_1.color.g, arg_214_1.hightColor1.g, var_217_3)
								local var_217_6 = Mathf.Lerp(iter_217_1.color.b, arg_214_1.hightColor1.b, var_217_3)

								iter_217_1.color = Color.New(var_217_4, var_217_5, var_217_6)
							else
								local var_217_7 = Mathf.Lerp(iter_217_1.color.r, 1, var_217_3)

								iter_217_1.color = Color.New(var_217_7, var_217_7, var_217_7)
							end
						end
					end
				end
			end

			if arg_214_1.time_ >= var_217_1 + var_217_2 and arg_214_1.time_ < var_217_1 + var_217_2 + arg_217_0 and not isNil(var_217_0) and arg_214_1.var_.actorSpriteComps10014 then
				for iter_217_2, iter_217_3 in pairs(arg_214_1.var_.actorSpriteComps10014:ToTable()) do
					if iter_217_3 then
						if arg_214_1.isInRecall_ then
							iter_217_3.color = arg_214_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_217_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_214_1.var_.actorSpriteComps10014 = nil
			end

			local var_217_8 = arg_214_1.actors_["10115"]
			local var_217_9 = 0

			if var_217_9 < arg_214_1.time_ and arg_214_1.time_ <= var_217_9 + arg_217_0 and not isNil(var_217_8) and arg_214_1.var_.actorSpriteComps10115 == nil then
				arg_214_1.var_.actorSpriteComps10115 = var_217_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_217_10 = 0.2

			if var_217_9 <= arg_214_1.time_ and arg_214_1.time_ < var_217_9 + var_217_10 and not isNil(var_217_8) then
				local var_217_11 = (arg_214_1.time_ - var_217_9) / var_217_10

				if arg_214_1.var_.actorSpriteComps10115 then
					for iter_217_4, iter_217_5 in pairs(arg_214_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_217_5 then
							if arg_214_1.isInRecall_ then
								local var_217_12 = Mathf.Lerp(iter_217_5.color.r, arg_214_1.hightColor2.r, var_217_11)
								local var_217_13 = Mathf.Lerp(iter_217_5.color.g, arg_214_1.hightColor2.g, var_217_11)
								local var_217_14 = Mathf.Lerp(iter_217_5.color.b, arg_214_1.hightColor2.b, var_217_11)

								iter_217_5.color = Color.New(var_217_12, var_217_13, var_217_14)
							else
								local var_217_15 = Mathf.Lerp(iter_217_5.color.r, 0.5, var_217_11)

								iter_217_5.color = Color.New(var_217_15, var_217_15, var_217_15)
							end
						end
					end
				end
			end

			if arg_214_1.time_ >= var_217_9 + var_217_10 and arg_214_1.time_ < var_217_9 + var_217_10 + arg_217_0 and not isNil(var_217_8) and arg_214_1.var_.actorSpriteComps10115 then
				for iter_217_6, iter_217_7 in pairs(arg_214_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_217_7 then
						if arg_214_1.isInRecall_ then
							iter_217_7.color = arg_214_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_217_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_214_1.var_.actorSpriteComps10115 = nil
			end

			local var_217_16 = 0
			local var_217_17 = 0.25

			if var_217_16 < arg_214_1.time_ and arg_214_1.time_ <= var_217_16 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0
				arg_214_1.dialogCg_.alpha = 1

				arg_214_1.dialog_:SetActive(true)
				SetActive(arg_214_1.leftNameGo_, true)

				local var_217_18 = arg_214_1:FormatText(StoryNameCfg[264].name)

				arg_214_1.leftNameTxt_.text = var_217_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_214_1.leftNameTxt_.transform)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1.leftNameTxt_.text)
				SetActive(arg_214_1.iconTrs_.gameObject, false)
				arg_214_1.callingController_:SetSelectedState("normal")

				local var_217_19 = arg_214_1:GetWordFromCfg(417261052)
				local var_217_20 = arg_214_1:FormatText(var_217_19.content)

				arg_214_1.text_.text = var_217_20

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_21 = 10
				local var_217_22 = utf8.len(var_217_20)
				local var_217_23 = var_217_21 <= 0 and var_217_17 or var_217_17 * (var_217_22 / var_217_21)

				if var_217_23 > 0 and var_217_17 < var_217_23 then
					arg_214_1.talkMaxDuration = var_217_23

					if var_217_23 + var_217_16 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_23 + var_217_16
					end
				end

				arg_214_1.text_.text = var_217_20
				arg_214_1.typewritter.percent = 0

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417261", "417261052", "story_v_out_417261.awb") ~= 0 then
					local var_217_24 = manager.audio:GetVoiceLength("story_v_out_417261", "417261052", "story_v_out_417261.awb") / 1000

					if var_217_24 + var_217_16 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_24 + var_217_16
					end

					if var_217_19.prefab_name ~= "" and arg_214_1.actors_[var_217_19.prefab_name] ~= nil then
						local var_217_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_214_1.actors_[var_217_19.prefab_name].transform, "story_v_out_417261", "417261052", "story_v_out_417261.awb")

						arg_214_1:RecordAudio("417261052", var_217_25)
						arg_214_1:RecordAudio("417261052", var_217_25)
					else
						arg_214_1:AudioAction("play", "voice", "story_v_out_417261", "417261052", "story_v_out_417261.awb")
					end

					arg_214_1:RecordHistoryTalkVoice("story_v_out_417261", "417261052", "story_v_out_417261.awb")
				end

				arg_214_1:RecordContent(arg_214_1.text_.text)
			end

			local var_217_26 = math.max(var_217_17, arg_214_1.talkMaxDuration)

			if var_217_16 <= arg_214_1.time_ and arg_214_1.time_ < var_217_16 + var_217_26 then
				arg_214_1.typewritter.percent = (arg_214_1.time_ - var_217_16) / var_217_26

				arg_214_1.typewritter:SetDirty()
			end

			if arg_214_1.time_ >= var_217_16 + var_217_26 and arg_214_1.time_ < var_217_16 + var_217_26 + arg_217_0 then
				arg_214_1.typewritter.percent = 1

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(true)
			end
		end

		arg_214_1.nodeConfigList_ = {}

		arg_214_1:InitPlayNodeList()
	end,
	Play417261053 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 417261053
		arg_218_1.duration_ = 15.17

		local var_218_0 = {
			zh = 11.866,
			ja = 15.166
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
				arg_218_0:Play417261054(arg_218_1)
			end
		end

		function arg_218_1.onSingleLineUpdate_(arg_221_0)
			local var_221_0 = 0
			local var_221_1 = 1.2

			if var_221_0 < arg_218_1.time_ and arg_218_1.time_ <= var_221_0 + arg_221_0 then
				arg_218_1.talkMaxDuration = 0
				arg_218_1.dialogCg_.alpha = 1

				arg_218_1.dialog_:SetActive(true)
				SetActive(arg_218_1.leftNameGo_, true)

				local var_221_2 = arg_218_1:FormatText(StoryNameCfg[264].name)

				arg_218_1.leftNameTxt_.text = var_221_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_218_1.leftNameTxt_.transform)

				arg_218_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_218_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_218_1:RecordName(arg_218_1.leftNameTxt_.text)
				SetActive(arg_218_1.iconTrs_.gameObject, false)
				arg_218_1.callingController_:SetSelectedState("normal")

				local var_221_3 = arg_218_1:GetWordFromCfg(417261053)
				local var_221_4 = arg_218_1:FormatText(var_221_3.content)

				arg_218_1.text_.text = var_221_4

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_5 = 48
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

				if manager.audio:GetVoiceLength("story_v_out_417261", "417261053", "story_v_out_417261.awb") ~= 0 then
					local var_221_8 = manager.audio:GetVoiceLength("story_v_out_417261", "417261053", "story_v_out_417261.awb") / 1000

					if var_221_8 + var_221_0 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_8 + var_221_0
					end

					if var_221_3.prefab_name ~= "" and arg_218_1.actors_[var_221_3.prefab_name] ~= nil then
						local var_221_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_218_1.actors_[var_221_3.prefab_name].transform, "story_v_out_417261", "417261053", "story_v_out_417261.awb")

						arg_218_1:RecordAudio("417261053", var_221_9)
						arg_218_1:RecordAudio("417261053", var_221_9)
					else
						arg_218_1:AudioAction("play", "voice", "story_v_out_417261", "417261053", "story_v_out_417261.awb")
					end

					arg_218_1:RecordHistoryTalkVoice("story_v_out_417261", "417261053", "story_v_out_417261.awb")
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
	Play417261054 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 417261054
		arg_222_1.duration_ = 7.83

		local var_222_0 = {
			zh = 4.2,
			ja = 7.833
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
				arg_222_0:Play417261055(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			local var_225_0 = arg_222_1.actors_["10014"]
			local var_225_1 = 0

			if var_225_1 < arg_222_1.time_ and arg_222_1.time_ <= var_225_1 + arg_225_0 and not isNil(var_225_0) and arg_222_1.var_.actorSpriteComps10014 == nil then
				arg_222_1.var_.actorSpriteComps10014 = var_225_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_225_2 = 0.2

			if var_225_1 <= arg_222_1.time_ and arg_222_1.time_ < var_225_1 + var_225_2 and not isNil(var_225_0) then
				local var_225_3 = (arg_222_1.time_ - var_225_1) / var_225_2

				if arg_222_1.var_.actorSpriteComps10014 then
					for iter_225_0, iter_225_1 in pairs(arg_222_1.var_.actorSpriteComps10014:ToTable()) do
						if iter_225_1 then
							if arg_222_1.isInRecall_ then
								local var_225_4 = Mathf.Lerp(iter_225_1.color.r, arg_222_1.hightColor2.r, var_225_3)
								local var_225_5 = Mathf.Lerp(iter_225_1.color.g, arg_222_1.hightColor2.g, var_225_3)
								local var_225_6 = Mathf.Lerp(iter_225_1.color.b, arg_222_1.hightColor2.b, var_225_3)

								iter_225_1.color = Color.New(var_225_4, var_225_5, var_225_6)
							else
								local var_225_7 = Mathf.Lerp(iter_225_1.color.r, 0.5, var_225_3)

								iter_225_1.color = Color.New(var_225_7, var_225_7, var_225_7)
							end
						end
					end
				end
			end

			if arg_222_1.time_ >= var_225_1 + var_225_2 and arg_222_1.time_ < var_225_1 + var_225_2 + arg_225_0 and not isNil(var_225_0) and arg_222_1.var_.actorSpriteComps10014 then
				for iter_225_2, iter_225_3 in pairs(arg_222_1.var_.actorSpriteComps10014:ToTable()) do
					if iter_225_3 then
						if arg_222_1.isInRecall_ then
							iter_225_3.color = arg_222_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_225_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_222_1.var_.actorSpriteComps10014 = nil
			end

			local var_225_8 = arg_222_1.actors_["10115"]
			local var_225_9 = 0

			if var_225_9 < arg_222_1.time_ and arg_222_1.time_ <= var_225_9 + arg_225_0 and not isNil(var_225_8) and arg_222_1.var_.actorSpriteComps10115 == nil then
				arg_222_1.var_.actorSpriteComps10115 = var_225_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_225_10 = 0.2

			if var_225_9 <= arg_222_1.time_ and arg_222_1.time_ < var_225_9 + var_225_10 and not isNil(var_225_8) then
				local var_225_11 = (arg_222_1.time_ - var_225_9) / var_225_10

				if arg_222_1.var_.actorSpriteComps10115 then
					for iter_225_4, iter_225_5 in pairs(arg_222_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_225_5 then
							if arg_222_1.isInRecall_ then
								local var_225_12 = Mathf.Lerp(iter_225_5.color.r, arg_222_1.hightColor1.r, var_225_11)
								local var_225_13 = Mathf.Lerp(iter_225_5.color.g, arg_222_1.hightColor1.g, var_225_11)
								local var_225_14 = Mathf.Lerp(iter_225_5.color.b, arg_222_1.hightColor1.b, var_225_11)

								iter_225_5.color = Color.New(var_225_12, var_225_13, var_225_14)
							else
								local var_225_15 = Mathf.Lerp(iter_225_5.color.r, 1, var_225_11)

								iter_225_5.color = Color.New(var_225_15, var_225_15, var_225_15)
							end
						end
					end
				end
			end

			if arg_222_1.time_ >= var_225_9 + var_225_10 and arg_222_1.time_ < var_225_9 + var_225_10 + arg_225_0 and not isNil(var_225_8) and arg_222_1.var_.actorSpriteComps10115 then
				for iter_225_6, iter_225_7 in pairs(arg_222_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_225_7 then
						if arg_222_1.isInRecall_ then
							iter_225_7.color = arg_222_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_225_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_222_1.var_.actorSpriteComps10115 = nil
			end

			local var_225_16 = 0
			local var_225_17 = 0.45

			if var_225_16 < arg_222_1.time_ and arg_222_1.time_ <= var_225_16 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0
				arg_222_1.dialogCg_.alpha = 1

				arg_222_1.dialog_:SetActive(true)
				SetActive(arg_222_1.leftNameGo_, true)

				local var_225_18 = arg_222_1:FormatText(StoryNameCfg[1113].name)

				arg_222_1.leftNameTxt_.text = var_225_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_222_1.leftNameTxt_.transform)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1.leftNameTxt_.text)
				SetActive(arg_222_1.iconTrs_.gameObject, false)
				arg_222_1.callingController_:SetSelectedState("normal")

				local var_225_19 = arg_222_1:GetWordFromCfg(417261054)
				local var_225_20 = arg_222_1:FormatText(var_225_19.content)

				arg_222_1.text_.text = var_225_20

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_21 = 18
				local var_225_22 = utf8.len(var_225_20)
				local var_225_23 = var_225_21 <= 0 and var_225_17 or var_225_17 * (var_225_22 / var_225_21)

				if var_225_23 > 0 and var_225_17 < var_225_23 then
					arg_222_1.talkMaxDuration = var_225_23

					if var_225_23 + var_225_16 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_23 + var_225_16
					end
				end

				arg_222_1.text_.text = var_225_20
				arg_222_1.typewritter.percent = 0

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417261", "417261054", "story_v_out_417261.awb") ~= 0 then
					local var_225_24 = manager.audio:GetVoiceLength("story_v_out_417261", "417261054", "story_v_out_417261.awb") / 1000

					if var_225_24 + var_225_16 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_24 + var_225_16
					end

					if var_225_19.prefab_name ~= "" and arg_222_1.actors_[var_225_19.prefab_name] ~= nil then
						local var_225_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_222_1.actors_[var_225_19.prefab_name].transform, "story_v_out_417261", "417261054", "story_v_out_417261.awb")

						arg_222_1:RecordAudio("417261054", var_225_25)
						arg_222_1:RecordAudio("417261054", var_225_25)
					else
						arg_222_1:AudioAction("play", "voice", "story_v_out_417261", "417261054", "story_v_out_417261.awb")
					end

					arg_222_1:RecordHistoryTalkVoice("story_v_out_417261", "417261054", "story_v_out_417261.awb")
				end

				arg_222_1:RecordContent(arg_222_1.text_.text)
			end

			local var_225_26 = math.max(var_225_17, arg_222_1.talkMaxDuration)

			if var_225_16 <= arg_222_1.time_ and arg_222_1.time_ < var_225_16 + var_225_26 then
				arg_222_1.typewritter.percent = (arg_222_1.time_ - var_225_16) / var_225_26

				arg_222_1.typewritter:SetDirty()
			end

			if arg_222_1.time_ >= var_225_16 + var_225_26 and arg_222_1.time_ < var_225_16 + var_225_26 + arg_225_0 then
				arg_222_1.typewritter.percent = 1

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(true)
			end
		end

		arg_222_1.nodeConfigList_ = {}

		arg_222_1:InitPlayNodeList()
	end,
	Play417261055 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 417261055
		arg_226_1.duration_ = 2.67

		local var_226_0 = {
			zh = 2.666,
			ja = 2
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
				arg_226_0:Play417261056(arg_226_1)
			end
		end

		function arg_226_1.onSingleLineUpdate_(arg_229_0)
			local var_229_0 = arg_226_1.actors_["10014"]
			local var_229_1 = 0

			if var_229_1 < arg_226_1.time_ and arg_226_1.time_ <= var_229_1 + arg_229_0 and not isNil(var_229_0) and arg_226_1.var_.actorSpriteComps10014 == nil then
				arg_226_1.var_.actorSpriteComps10014 = var_229_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_229_2 = 0.2

			if var_229_1 <= arg_226_1.time_ and arg_226_1.time_ < var_229_1 + var_229_2 and not isNil(var_229_0) then
				local var_229_3 = (arg_226_1.time_ - var_229_1) / var_229_2

				if arg_226_1.var_.actorSpriteComps10014 then
					for iter_229_0, iter_229_1 in pairs(arg_226_1.var_.actorSpriteComps10014:ToTable()) do
						if iter_229_1 then
							if arg_226_1.isInRecall_ then
								local var_229_4 = Mathf.Lerp(iter_229_1.color.r, arg_226_1.hightColor1.r, var_229_3)
								local var_229_5 = Mathf.Lerp(iter_229_1.color.g, arg_226_1.hightColor1.g, var_229_3)
								local var_229_6 = Mathf.Lerp(iter_229_1.color.b, arg_226_1.hightColor1.b, var_229_3)

								iter_229_1.color = Color.New(var_229_4, var_229_5, var_229_6)
							else
								local var_229_7 = Mathf.Lerp(iter_229_1.color.r, 1, var_229_3)

								iter_229_1.color = Color.New(var_229_7, var_229_7, var_229_7)
							end
						end
					end
				end
			end

			if arg_226_1.time_ >= var_229_1 + var_229_2 and arg_226_1.time_ < var_229_1 + var_229_2 + arg_229_0 and not isNil(var_229_0) and arg_226_1.var_.actorSpriteComps10014 then
				for iter_229_2, iter_229_3 in pairs(arg_226_1.var_.actorSpriteComps10014:ToTable()) do
					if iter_229_3 then
						if arg_226_1.isInRecall_ then
							iter_229_3.color = arg_226_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_229_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_226_1.var_.actorSpriteComps10014 = nil
			end

			local var_229_8 = arg_226_1.actors_["10115"]
			local var_229_9 = 0

			if var_229_9 < arg_226_1.time_ and arg_226_1.time_ <= var_229_9 + arg_229_0 and not isNil(var_229_8) and arg_226_1.var_.actorSpriteComps10115 == nil then
				arg_226_1.var_.actorSpriteComps10115 = var_229_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_229_10 = 0.2

			if var_229_9 <= arg_226_1.time_ and arg_226_1.time_ < var_229_9 + var_229_10 and not isNil(var_229_8) then
				local var_229_11 = (arg_226_1.time_ - var_229_9) / var_229_10

				if arg_226_1.var_.actorSpriteComps10115 then
					for iter_229_4, iter_229_5 in pairs(arg_226_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_229_5 then
							if arg_226_1.isInRecall_ then
								local var_229_12 = Mathf.Lerp(iter_229_5.color.r, arg_226_1.hightColor2.r, var_229_11)
								local var_229_13 = Mathf.Lerp(iter_229_5.color.g, arg_226_1.hightColor2.g, var_229_11)
								local var_229_14 = Mathf.Lerp(iter_229_5.color.b, arg_226_1.hightColor2.b, var_229_11)

								iter_229_5.color = Color.New(var_229_12, var_229_13, var_229_14)
							else
								local var_229_15 = Mathf.Lerp(iter_229_5.color.r, 0.5, var_229_11)

								iter_229_5.color = Color.New(var_229_15, var_229_15, var_229_15)
							end
						end
					end
				end
			end

			if arg_226_1.time_ >= var_229_9 + var_229_10 and arg_226_1.time_ < var_229_9 + var_229_10 + arg_229_0 and not isNil(var_229_8) and arg_226_1.var_.actorSpriteComps10115 then
				for iter_229_6, iter_229_7 in pairs(arg_226_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_229_7 then
						if arg_226_1.isInRecall_ then
							iter_229_7.color = arg_226_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_229_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_226_1.var_.actorSpriteComps10115 = nil
			end

			local var_229_16 = 0
			local var_229_17 = 0.225

			if var_229_16 < arg_226_1.time_ and arg_226_1.time_ <= var_229_16 + arg_229_0 then
				arg_226_1.talkMaxDuration = 0
				arg_226_1.dialogCg_.alpha = 1

				arg_226_1.dialog_:SetActive(true)
				SetActive(arg_226_1.leftNameGo_, true)

				local var_229_18 = arg_226_1:FormatText(StoryNameCfg[264].name)

				arg_226_1.leftNameTxt_.text = var_229_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_226_1.leftNameTxt_.transform)

				arg_226_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_226_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_226_1:RecordName(arg_226_1.leftNameTxt_.text)
				SetActive(arg_226_1.iconTrs_.gameObject, false)
				arg_226_1.callingController_:SetSelectedState("normal")

				local var_229_19 = arg_226_1:GetWordFromCfg(417261055)
				local var_229_20 = arg_226_1:FormatText(var_229_19.content)

				arg_226_1.text_.text = var_229_20

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_21 = 9
				local var_229_22 = utf8.len(var_229_20)
				local var_229_23 = var_229_21 <= 0 and var_229_17 or var_229_17 * (var_229_22 / var_229_21)

				if var_229_23 > 0 and var_229_17 < var_229_23 then
					arg_226_1.talkMaxDuration = var_229_23

					if var_229_23 + var_229_16 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_23 + var_229_16
					end
				end

				arg_226_1.text_.text = var_229_20
				arg_226_1.typewritter.percent = 0

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417261", "417261055", "story_v_out_417261.awb") ~= 0 then
					local var_229_24 = manager.audio:GetVoiceLength("story_v_out_417261", "417261055", "story_v_out_417261.awb") / 1000

					if var_229_24 + var_229_16 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_24 + var_229_16
					end

					if var_229_19.prefab_name ~= "" and arg_226_1.actors_[var_229_19.prefab_name] ~= nil then
						local var_229_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_226_1.actors_[var_229_19.prefab_name].transform, "story_v_out_417261", "417261055", "story_v_out_417261.awb")

						arg_226_1:RecordAudio("417261055", var_229_25)
						arg_226_1:RecordAudio("417261055", var_229_25)
					else
						arg_226_1:AudioAction("play", "voice", "story_v_out_417261", "417261055", "story_v_out_417261.awb")
					end

					arg_226_1:RecordHistoryTalkVoice("story_v_out_417261", "417261055", "story_v_out_417261.awb")
				end

				arg_226_1:RecordContent(arg_226_1.text_.text)
			end

			local var_229_26 = math.max(var_229_17, arg_226_1.talkMaxDuration)

			if var_229_16 <= arg_226_1.time_ and arg_226_1.time_ < var_229_16 + var_229_26 then
				arg_226_1.typewritter.percent = (arg_226_1.time_ - var_229_16) / var_229_26

				arg_226_1.typewritter:SetDirty()
			end

			if arg_226_1.time_ >= var_229_16 + var_229_26 and arg_226_1.time_ < var_229_16 + var_229_26 + arg_229_0 then
				arg_226_1.typewritter.percent = 1

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(true)
			end
		end

		arg_226_1.nodeConfigList_ = {}

		arg_226_1:InitPlayNodeList()
	end,
	Play417261056 = function(arg_230_0, arg_230_1)
		arg_230_1.time_ = 0
		arg_230_1.frameCnt_ = 0
		arg_230_1.state_ = "playing"
		arg_230_1.curTalkId_ = 417261056
		arg_230_1.duration_ = 12.4

		local var_230_0 = {
			zh = 10,
			ja = 12.4
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
				arg_230_0:Play417261057(arg_230_1)
			end
		end

		function arg_230_1.onSingleLineUpdate_(arg_233_0)
			local var_233_0 = arg_230_1.actors_["10014"]
			local var_233_1 = 0

			if var_233_1 < arg_230_1.time_ and arg_230_1.time_ <= var_233_1 + arg_233_0 and not isNil(var_233_0) and arg_230_1.var_.actorSpriteComps10014 == nil then
				arg_230_1.var_.actorSpriteComps10014 = var_233_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_233_2 = 0.2

			if var_233_1 <= arg_230_1.time_ and arg_230_1.time_ < var_233_1 + var_233_2 and not isNil(var_233_0) then
				local var_233_3 = (arg_230_1.time_ - var_233_1) / var_233_2

				if arg_230_1.var_.actorSpriteComps10014 then
					for iter_233_0, iter_233_1 in pairs(arg_230_1.var_.actorSpriteComps10014:ToTable()) do
						if iter_233_1 then
							if arg_230_1.isInRecall_ then
								local var_233_4 = Mathf.Lerp(iter_233_1.color.r, arg_230_1.hightColor1.r, var_233_3)
								local var_233_5 = Mathf.Lerp(iter_233_1.color.g, arg_230_1.hightColor1.g, var_233_3)
								local var_233_6 = Mathf.Lerp(iter_233_1.color.b, arg_230_1.hightColor1.b, var_233_3)

								iter_233_1.color = Color.New(var_233_4, var_233_5, var_233_6)
							else
								local var_233_7 = Mathf.Lerp(iter_233_1.color.r, 1, var_233_3)

								iter_233_1.color = Color.New(var_233_7, var_233_7, var_233_7)
							end
						end
					end
				end
			end

			if arg_230_1.time_ >= var_233_1 + var_233_2 and arg_230_1.time_ < var_233_1 + var_233_2 + arg_233_0 and not isNil(var_233_0) and arg_230_1.var_.actorSpriteComps10014 then
				for iter_233_2, iter_233_3 in pairs(arg_230_1.var_.actorSpriteComps10014:ToTable()) do
					if iter_233_3 then
						if arg_230_1.isInRecall_ then
							iter_233_3.color = arg_230_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_233_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_230_1.var_.actorSpriteComps10014 = nil
			end

			local var_233_8 = arg_230_1.actors_["10115"]
			local var_233_9 = 0

			if var_233_9 < arg_230_1.time_ and arg_230_1.time_ <= var_233_9 + arg_233_0 and not isNil(var_233_8) and arg_230_1.var_.actorSpriteComps10115 == nil then
				arg_230_1.var_.actorSpriteComps10115 = var_233_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_233_10 = 0.2

			if var_233_9 <= arg_230_1.time_ and arg_230_1.time_ < var_233_9 + var_233_10 and not isNil(var_233_8) then
				local var_233_11 = (arg_230_1.time_ - var_233_9) / var_233_10

				if arg_230_1.var_.actorSpriteComps10115 then
					for iter_233_4, iter_233_5 in pairs(arg_230_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_233_5 then
							if arg_230_1.isInRecall_ then
								local var_233_12 = Mathf.Lerp(iter_233_5.color.r, arg_230_1.hightColor2.r, var_233_11)
								local var_233_13 = Mathf.Lerp(iter_233_5.color.g, arg_230_1.hightColor2.g, var_233_11)
								local var_233_14 = Mathf.Lerp(iter_233_5.color.b, arg_230_1.hightColor2.b, var_233_11)

								iter_233_5.color = Color.New(var_233_12, var_233_13, var_233_14)
							else
								local var_233_15 = Mathf.Lerp(iter_233_5.color.r, 0.5, var_233_11)

								iter_233_5.color = Color.New(var_233_15, var_233_15, var_233_15)
							end
						end
					end
				end
			end

			if arg_230_1.time_ >= var_233_9 + var_233_10 and arg_230_1.time_ < var_233_9 + var_233_10 + arg_233_0 and not isNil(var_233_8) and arg_230_1.var_.actorSpriteComps10115 then
				for iter_233_6, iter_233_7 in pairs(arg_230_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_233_7 then
						if arg_230_1.isInRecall_ then
							iter_233_7.color = arg_230_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_233_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_230_1.var_.actorSpriteComps10115 = nil
			end

			local var_233_16 = 0
			local var_233_17 = 1.225

			if var_233_16 < arg_230_1.time_ and arg_230_1.time_ <= var_233_16 + arg_233_0 then
				arg_230_1.talkMaxDuration = 0
				arg_230_1.dialogCg_.alpha = 1

				arg_230_1.dialog_:SetActive(true)
				SetActive(arg_230_1.leftNameGo_, true)

				local var_233_18 = arg_230_1:FormatText(StoryNameCfg[264].name)

				arg_230_1.leftNameTxt_.text = var_233_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_230_1.leftNameTxt_.transform)

				arg_230_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_230_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_230_1:RecordName(arg_230_1.leftNameTxt_.text)
				SetActive(arg_230_1.iconTrs_.gameObject, false)
				arg_230_1.callingController_:SetSelectedState("normal")

				local var_233_19 = arg_230_1:GetWordFromCfg(417261056)
				local var_233_20 = arg_230_1:FormatText(var_233_19.content)

				arg_230_1.text_.text = var_233_20

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_21 = 49
				local var_233_22 = utf8.len(var_233_20)
				local var_233_23 = var_233_21 <= 0 and var_233_17 or var_233_17 * (var_233_22 / var_233_21)

				if var_233_23 > 0 and var_233_17 < var_233_23 then
					arg_230_1.talkMaxDuration = var_233_23

					if var_233_23 + var_233_16 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_23 + var_233_16
					end
				end

				arg_230_1.text_.text = var_233_20
				arg_230_1.typewritter.percent = 0

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417261", "417261056", "story_v_out_417261.awb") ~= 0 then
					local var_233_24 = manager.audio:GetVoiceLength("story_v_out_417261", "417261056", "story_v_out_417261.awb") / 1000

					if var_233_24 + var_233_16 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_24 + var_233_16
					end

					if var_233_19.prefab_name ~= "" and arg_230_1.actors_[var_233_19.prefab_name] ~= nil then
						local var_233_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_230_1.actors_[var_233_19.prefab_name].transform, "story_v_out_417261", "417261056", "story_v_out_417261.awb")

						arg_230_1:RecordAudio("417261056", var_233_25)
						arg_230_1:RecordAudio("417261056", var_233_25)
					else
						arg_230_1:AudioAction("play", "voice", "story_v_out_417261", "417261056", "story_v_out_417261.awb")
					end

					arg_230_1:RecordHistoryTalkVoice("story_v_out_417261", "417261056", "story_v_out_417261.awb")
				end

				arg_230_1:RecordContent(arg_230_1.text_.text)
			end

			local var_233_26 = math.max(var_233_17, arg_230_1.talkMaxDuration)

			if var_233_16 <= arg_230_1.time_ and arg_230_1.time_ < var_233_16 + var_233_26 then
				arg_230_1.typewritter.percent = (arg_230_1.time_ - var_233_16) / var_233_26

				arg_230_1.typewritter:SetDirty()
			end

			if arg_230_1.time_ >= var_233_16 + var_233_26 and arg_230_1.time_ < var_233_16 + var_233_26 + arg_233_0 then
				arg_230_1.typewritter.percent = 1

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(true)
			end
		end

		arg_230_1.nodeConfigList_ = {}

		arg_230_1:InitPlayNodeList()
	end,
	Play417261057 = function(arg_234_0, arg_234_1)
		arg_234_1.time_ = 0
		arg_234_1.frameCnt_ = 0
		arg_234_1.state_ = "playing"
		arg_234_1.curTalkId_ = 417261057
		arg_234_1.duration_ = 7

		local var_234_0 = {
			zh = 4.733,
			ja = 7
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
				arg_234_0:Play417261058(arg_234_1)
			end
		end

		function arg_234_1.onSingleLineUpdate_(arg_237_0)
			local var_237_0 = arg_234_1.actors_["10014"]
			local var_237_1 = 0

			if var_237_1 < arg_234_1.time_ and arg_234_1.time_ <= var_237_1 + arg_237_0 and not isNil(var_237_0) and arg_234_1.var_.actorSpriteComps10014 == nil then
				arg_234_1.var_.actorSpriteComps10014 = var_237_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_237_2 = 0.2

			if var_237_1 <= arg_234_1.time_ and arg_234_1.time_ < var_237_1 + var_237_2 and not isNil(var_237_0) then
				local var_237_3 = (arg_234_1.time_ - var_237_1) / var_237_2

				if arg_234_1.var_.actorSpriteComps10014 then
					for iter_237_0, iter_237_1 in pairs(arg_234_1.var_.actorSpriteComps10014:ToTable()) do
						if iter_237_1 then
							if arg_234_1.isInRecall_ then
								local var_237_4 = Mathf.Lerp(iter_237_1.color.r, arg_234_1.hightColor2.r, var_237_3)
								local var_237_5 = Mathf.Lerp(iter_237_1.color.g, arg_234_1.hightColor2.g, var_237_3)
								local var_237_6 = Mathf.Lerp(iter_237_1.color.b, arg_234_1.hightColor2.b, var_237_3)

								iter_237_1.color = Color.New(var_237_4, var_237_5, var_237_6)
							else
								local var_237_7 = Mathf.Lerp(iter_237_1.color.r, 0.5, var_237_3)

								iter_237_1.color = Color.New(var_237_7, var_237_7, var_237_7)
							end
						end
					end
				end
			end

			if arg_234_1.time_ >= var_237_1 + var_237_2 and arg_234_1.time_ < var_237_1 + var_237_2 + arg_237_0 and not isNil(var_237_0) and arg_234_1.var_.actorSpriteComps10014 then
				for iter_237_2, iter_237_3 in pairs(arg_234_1.var_.actorSpriteComps10014:ToTable()) do
					if iter_237_3 then
						if arg_234_1.isInRecall_ then
							iter_237_3.color = arg_234_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_237_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_234_1.var_.actorSpriteComps10014 = nil
			end

			local var_237_8 = arg_234_1.actors_["10115"]
			local var_237_9 = 0

			if var_237_9 < arg_234_1.time_ and arg_234_1.time_ <= var_237_9 + arg_237_0 and not isNil(var_237_8) and arg_234_1.var_.actorSpriteComps10115 == nil then
				arg_234_1.var_.actorSpriteComps10115 = var_237_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_237_10 = 0.2

			if var_237_9 <= arg_234_1.time_ and arg_234_1.time_ < var_237_9 + var_237_10 and not isNil(var_237_8) then
				local var_237_11 = (arg_234_1.time_ - var_237_9) / var_237_10

				if arg_234_1.var_.actorSpriteComps10115 then
					for iter_237_4, iter_237_5 in pairs(arg_234_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_237_5 then
							if arg_234_1.isInRecall_ then
								local var_237_12 = Mathf.Lerp(iter_237_5.color.r, arg_234_1.hightColor1.r, var_237_11)
								local var_237_13 = Mathf.Lerp(iter_237_5.color.g, arg_234_1.hightColor1.g, var_237_11)
								local var_237_14 = Mathf.Lerp(iter_237_5.color.b, arg_234_1.hightColor1.b, var_237_11)

								iter_237_5.color = Color.New(var_237_12, var_237_13, var_237_14)
							else
								local var_237_15 = Mathf.Lerp(iter_237_5.color.r, 1, var_237_11)

								iter_237_5.color = Color.New(var_237_15, var_237_15, var_237_15)
							end
						end
					end
				end
			end

			if arg_234_1.time_ >= var_237_9 + var_237_10 and arg_234_1.time_ < var_237_9 + var_237_10 + arg_237_0 and not isNil(var_237_8) and arg_234_1.var_.actorSpriteComps10115 then
				for iter_237_6, iter_237_7 in pairs(arg_234_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_237_7 then
						if arg_234_1.isInRecall_ then
							iter_237_7.color = arg_234_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_237_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_234_1.var_.actorSpriteComps10115 = nil
			end

			local var_237_16 = 0
			local var_237_17 = 0.45

			if var_237_16 < arg_234_1.time_ and arg_234_1.time_ <= var_237_16 + arg_237_0 then
				arg_234_1.talkMaxDuration = 0
				arg_234_1.dialogCg_.alpha = 1

				arg_234_1.dialog_:SetActive(true)
				SetActive(arg_234_1.leftNameGo_, true)

				local var_237_18 = arg_234_1:FormatText(StoryNameCfg[1113].name)

				arg_234_1.leftNameTxt_.text = var_237_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_234_1.leftNameTxt_.transform)

				arg_234_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_234_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_234_1:RecordName(arg_234_1.leftNameTxt_.text)
				SetActive(arg_234_1.iconTrs_.gameObject, false)
				arg_234_1.callingController_:SetSelectedState("normal")

				local var_237_19 = arg_234_1:GetWordFromCfg(417261057)
				local var_237_20 = arg_234_1:FormatText(var_237_19.content)

				arg_234_1.text_.text = var_237_20

				LuaForUtil.ClearLinePrefixSymbol(arg_234_1.text_)

				local var_237_21 = 18
				local var_237_22 = utf8.len(var_237_20)
				local var_237_23 = var_237_21 <= 0 and var_237_17 or var_237_17 * (var_237_22 / var_237_21)

				if var_237_23 > 0 and var_237_17 < var_237_23 then
					arg_234_1.talkMaxDuration = var_237_23

					if var_237_23 + var_237_16 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_23 + var_237_16
					end
				end

				arg_234_1.text_.text = var_237_20
				arg_234_1.typewritter.percent = 0

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417261", "417261057", "story_v_out_417261.awb") ~= 0 then
					local var_237_24 = manager.audio:GetVoiceLength("story_v_out_417261", "417261057", "story_v_out_417261.awb") / 1000

					if var_237_24 + var_237_16 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_24 + var_237_16
					end

					if var_237_19.prefab_name ~= "" and arg_234_1.actors_[var_237_19.prefab_name] ~= nil then
						local var_237_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_234_1.actors_[var_237_19.prefab_name].transform, "story_v_out_417261", "417261057", "story_v_out_417261.awb")

						arg_234_1:RecordAudio("417261057", var_237_25)
						arg_234_1:RecordAudio("417261057", var_237_25)
					else
						arg_234_1:AudioAction("play", "voice", "story_v_out_417261", "417261057", "story_v_out_417261.awb")
					end

					arg_234_1:RecordHistoryTalkVoice("story_v_out_417261", "417261057", "story_v_out_417261.awb")
				end

				arg_234_1:RecordContent(arg_234_1.text_.text)
			end

			local var_237_26 = math.max(var_237_17, arg_234_1.talkMaxDuration)

			if var_237_16 <= arg_234_1.time_ and arg_234_1.time_ < var_237_16 + var_237_26 then
				arg_234_1.typewritter.percent = (arg_234_1.time_ - var_237_16) / var_237_26

				arg_234_1.typewritter:SetDirty()
			end

			if arg_234_1.time_ >= var_237_16 + var_237_26 and arg_234_1.time_ < var_237_16 + var_237_26 + arg_237_0 then
				arg_234_1.typewritter.percent = 1

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(true)
			end
		end

		arg_234_1.nodeConfigList_ = {}

		arg_234_1:InitPlayNodeList()
	end,
	Play417261058 = function(arg_238_0, arg_238_1)
		arg_238_1.time_ = 0
		arg_238_1.frameCnt_ = 0
		arg_238_1.state_ = "playing"
		arg_238_1.curTalkId_ = 417261058
		arg_238_1.duration_ = 8.8

		local var_238_0 = {
			zh = 5.066,
			ja = 8.8
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
				arg_238_0:Play417261059(arg_238_1)
			end
		end

		function arg_238_1.onSingleLineUpdate_(arg_241_0)
			local var_241_0 = 0
			local var_241_1 = 0.65

			if var_241_0 < arg_238_1.time_ and arg_238_1.time_ <= var_241_0 + arg_241_0 then
				arg_238_1.talkMaxDuration = 0
				arg_238_1.dialogCg_.alpha = 1

				arg_238_1.dialog_:SetActive(true)
				SetActive(arg_238_1.leftNameGo_, true)

				local var_241_2 = arg_238_1:FormatText(StoryNameCfg[1113].name)

				arg_238_1.leftNameTxt_.text = var_241_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_238_1.leftNameTxt_.transform)

				arg_238_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_238_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_238_1:RecordName(arg_238_1.leftNameTxt_.text)
				SetActive(arg_238_1.iconTrs_.gameObject, false)
				arg_238_1.callingController_:SetSelectedState("normal")

				local var_241_3 = arg_238_1:GetWordFromCfg(417261058)
				local var_241_4 = arg_238_1:FormatText(var_241_3.content)

				arg_238_1.text_.text = var_241_4

				LuaForUtil.ClearLinePrefixSymbol(arg_238_1.text_)

				local var_241_5 = 26
				local var_241_6 = utf8.len(var_241_4)
				local var_241_7 = var_241_5 <= 0 and var_241_1 or var_241_1 * (var_241_6 / var_241_5)

				if var_241_7 > 0 and var_241_1 < var_241_7 then
					arg_238_1.talkMaxDuration = var_241_7

					if var_241_7 + var_241_0 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_7 + var_241_0
					end
				end

				arg_238_1.text_.text = var_241_4
				arg_238_1.typewritter.percent = 0

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417261", "417261058", "story_v_out_417261.awb") ~= 0 then
					local var_241_8 = manager.audio:GetVoiceLength("story_v_out_417261", "417261058", "story_v_out_417261.awb") / 1000

					if var_241_8 + var_241_0 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_8 + var_241_0
					end

					if var_241_3.prefab_name ~= "" and arg_238_1.actors_[var_241_3.prefab_name] ~= nil then
						local var_241_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_238_1.actors_[var_241_3.prefab_name].transform, "story_v_out_417261", "417261058", "story_v_out_417261.awb")

						arg_238_1:RecordAudio("417261058", var_241_9)
						arg_238_1:RecordAudio("417261058", var_241_9)
					else
						arg_238_1:AudioAction("play", "voice", "story_v_out_417261", "417261058", "story_v_out_417261.awb")
					end

					arg_238_1:RecordHistoryTalkVoice("story_v_out_417261", "417261058", "story_v_out_417261.awb")
				end

				arg_238_1:RecordContent(arg_238_1.text_.text)
			end

			local var_241_10 = math.max(var_241_1, arg_238_1.talkMaxDuration)

			if var_241_0 <= arg_238_1.time_ and arg_238_1.time_ < var_241_0 + var_241_10 then
				arg_238_1.typewritter.percent = (arg_238_1.time_ - var_241_0) / var_241_10

				arg_238_1.typewritter:SetDirty()
			end

			if arg_238_1.time_ >= var_241_0 + var_241_10 and arg_238_1.time_ < var_241_0 + var_241_10 + arg_241_0 then
				arg_238_1.typewritter.percent = 1

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(true)
			end
		end

		arg_238_1.nodeConfigList_ = {}

		arg_238_1:InitPlayNodeList()
	end,
	Play417261059 = function(arg_242_0, arg_242_1)
		arg_242_1.time_ = 0
		arg_242_1.frameCnt_ = 0
		arg_242_1.state_ = "playing"
		arg_242_1.curTalkId_ = 417261059
		arg_242_1.duration_ = 3.83

		SetActive(arg_242_1.tipsGo_, false)

		function arg_242_1.onSingleLineFinish_()
			arg_242_1.onSingleLineUpdate_ = nil
			arg_242_1.onSingleLineFinish_ = nil
			arg_242_1.state_ = "waiting"
		end

		function arg_242_1.playNext_(arg_244_0)
			if arg_244_0 == 1 then
				arg_242_0:Play417261060(arg_242_1)
			end
		end

		function arg_242_1.onSingleLineUpdate_(arg_245_0)
			local var_245_0 = arg_242_1.actors_["10014"].transform
			local var_245_1 = 0.966

			if var_245_1 < arg_242_1.time_ and arg_242_1.time_ <= var_245_1 + arg_245_0 then
				arg_242_1.var_.moveOldPos10014 = var_245_0.localPosition
				var_245_0.localScale = Vector3.New(1, 1, 1)

				arg_242_1:CheckSpriteTmpPos("10014", 7)

				local var_245_2 = var_245_0.childCount

				for iter_245_0 = 0, var_245_2 - 1 do
					local var_245_3 = var_245_0:GetChild(iter_245_0)

					if var_245_3.name == "" or not string.find(var_245_3.name, "split") then
						var_245_3.gameObject:SetActive(true)
					else
						var_245_3.gameObject:SetActive(false)
					end
				end
			end

			local var_245_4 = 0.001

			if var_245_1 <= arg_242_1.time_ and arg_242_1.time_ < var_245_1 + var_245_4 then
				local var_245_5 = (arg_242_1.time_ - var_245_1) / var_245_4
				local var_245_6 = Vector3.New(0, -2000, -40)

				var_245_0.localPosition = Vector3.Lerp(arg_242_1.var_.moveOldPos10014, var_245_6, var_245_5)
			end

			if arg_242_1.time_ >= var_245_1 + var_245_4 and arg_242_1.time_ < var_245_1 + var_245_4 + arg_245_0 then
				var_245_0.localPosition = Vector3.New(0, -2000, -40)
			end

			local var_245_7 = arg_242_1.actors_["10115"].transform
			local var_245_8 = 0.966

			if var_245_8 < arg_242_1.time_ and arg_242_1.time_ <= var_245_8 + arg_245_0 then
				arg_242_1.var_.moveOldPos10115 = var_245_7.localPosition
				var_245_7.localScale = Vector3.New(1, 1, 1)

				arg_242_1:CheckSpriteTmpPos("10115", 7)

				local var_245_9 = var_245_7.childCount

				for iter_245_1 = 0, var_245_9 - 1 do
					local var_245_10 = var_245_7:GetChild(iter_245_1)

					if var_245_10.name == "" or not string.find(var_245_10.name, "split") then
						var_245_10.gameObject:SetActive(true)
					else
						var_245_10.gameObject:SetActive(false)
					end
				end
			end

			local var_245_11 = 0.001

			if var_245_8 <= arg_242_1.time_ and arg_242_1.time_ < var_245_8 + var_245_11 then
				local var_245_12 = (arg_242_1.time_ - var_245_8) / var_245_11
				local var_245_13 = Vector3.New(0, -2000, 0)

				var_245_7.localPosition = Vector3.Lerp(arg_242_1.var_.moveOldPos10115, var_245_13, var_245_12)
			end

			if arg_242_1.time_ >= var_245_8 + var_245_11 and arg_242_1.time_ < var_245_8 + var_245_11 + arg_245_0 then
				var_245_7.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_245_14 = 0

			if var_245_14 < arg_242_1.time_ and arg_242_1.time_ <= var_245_14 + arg_245_0 then
				arg_242_1.mask_.enabled = true
				arg_242_1.mask_.raycastTarget = true

				arg_242_1:SetGaussion(false)
			end

			local var_245_15 = 1

			if var_245_14 <= arg_242_1.time_ and arg_242_1.time_ < var_245_14 + var_245_15 then
				local var_245_16 = (arg_242_1.time_ - var_245_14) / var_245_15
				local var_245_17 = Color.New(0, 0, 0)

				var_245_17.a = Mathf.Lerp(0, 1, var_245_16)
				arg_242_1.mask_.color = var_245_17
			end

			if arg_242_1.time_ >= var_245_14 + var_245_15 and arg_242_1.time_ < var_245_14 + var_245_15 + arg_245_0 then
				local var_245_18 = Color.New(0, 0, 0)

				var_245_18.a = 1
				arg_242_1.mask_.color = var_245_18
			end

			local var_245_19 = 1

			if var_245_19 < arg_242_1.time_ and arg_242_1.time_ <= var_245_19 + arg_245_0 then
				arg_242_1.mask_.enabled = true
				arg_242_1.mask_.raycastTarget = true

				arg_242_1:SetGaussion(false)
			end

			local var_245_20 = 1

			if var_245_19 <= arg_242_1.time_ and arg_242_1.time_ < var_245_19 + var_245_20 then
				local var_245_21 = (arg_242_1.time_ - var_245_19) / var_245_20
				local var_245_22 = Color.New(0, 0, 0)

				var_245_22.a = Mathf.Lerp(1, 0, var_245_21)
				arg_242_1.mask_.color = var_245_22
			end

			if arg_242_1.time_ >= var_245_19 + var_245_20 and arg_242_1.time_ < var_245_19 + var_245_20 + arg_245_0 then
				local var_245_23 = Color.New(0, 0, 0)
				local var_245_24 = 0

				arg_242_1.mask_.enabled = false
				var_245_23.a = var_245_24
				arg_242_1.mask_.color = var_245_23
			end

			local var_245_25 = 1

			if var_245_25 < arg_242_1.time_ and arg_242_1.time_ <= var_245_25 + arg_245_0 then
				local var_245_26 = manager.ui.mainCamera.transform.localPosition
				local var_245_27 = Vector3.New(0, 0, 10) + Vector3.New(var_245_26.x, var_245_26.y, 0)
				local var_245_28 = arg_242_1.bgs_.STblack

				var_245_28.transform.localPosition = var_245_27
				var_245_28.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_245_29 = var_245_28:GetComponent("SpriteRenderer")

				if var_245_29 and var_245_29.sprite then
					local var_245_30 = (var_245_28.transform.localPosition - var_245_26).z
					local var_245_31 = manager.ui.mainCameraCom_
					local var_245_32 = 2 * var_245_30 * Mathf.Tan(var_245_31.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_245_33 = var_245_32 * var_245_31.aspect
					local var_245_34 = var_245_29.sprite.bounds.size.x
					local var_245_35 = var_245_29.sprite.bounds.size.y
					local var_245_36 = var_245_33 / var_245_34
					local var_245_37 = var_245_32 / var_245_35
					local var_245_38 = var_245_37 < var_245_36 and var_245_36 or var_245_37

					var_245_28.transform.localScale = Vector3.New(var_245_38, var_245_38, 0)
				end

				for iter_245_2, iter_245_3 in pairs(arg_242_1.bgs_) do
					if iter_245_2 ~= "STblack" then
						iter_245_3.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_245_39 = 1

			if var_245_39 < arg_242_1.time_ and arg_242_1.time_ <= var_245_39 + arg_245_0 then
				arg_242_1.cswbg_:SetActive(true)

				local var_245_40 = arg_242_1.cswt_:GetComponent("RectTransform")

				arg_242_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_245_40.offsetMin = Vector2.New(0, 0)
				var_245_40.offsetMax = Vector2.New(0, 0)

				local var_245_41 = arg_242_1:GetWordFromCfg(419124)
				local var_245_42 = arg_242_1:FormatText(var_245_41.content)

				arg_242_1.cswt_.text = var_245_42

				LuaForUtil.ClearLinePrefixSymbol(arg_242_1.cswt_)

				arg_242_1.cswt_.fontSize = 120
				arg_242_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_242_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_242_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end

			local var_245_43 = 1

			if var_245_43 < arg_242_1.time_ and arg_242_1.time_ <= var_245_43 + arg_245_0 then
				local var_245_44 = arg_242_1.fswbg_.transform:Find("textbox/adapt/content") or arg_242_1.fswbg_.transform:Find("textbox/content")
				local var_245_45 = arg_242_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_245_46 = var_245_44:GetComponent("Text")
				local var_245_47 = var_245_44:GetComponent("RectTransform")

				var_245_46.alignment = UnityEngine.TextAnchor.LowerCenter
				var_245_47.offsetMin = Vector2.New(0, 0)
				var_245_47.offsetMax = Vector2.New(0, 0)
			end

			local var_245_48 = 1

			if var_245_48 < arg_242_1.time_ and arg_242_1.time_ <= var_245_48 + arg_245_0 then
				arg_242_1.fswbg_:SetActive(true)
				arg_242_1.dialog_:SetActive(false)

				arg_242_1.fswtw_.percent = 0

				local var_245_49 = arg_242_1:GetWordFromCfg(417261059)
				local var_245_50 = arg_242_1:FormatText(var_245_49.content)

				arg_242_1.fswt_.text = var_245_50

				LuaForUtil.ClearLinePrefixSymbol(arg_242_1.fswt_)

				arg_242_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_242_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_242_1.fswtw_:SetDirty()

				arg_242_1.typewritterCharCountI18N = 0

				SetActive(arg_242_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_242_1:ShowNextGo(false)
			end

			local var_245_51 = 1.66666666666667

			if var_245_51 < arg_242_1.time_ and arg_242_1.time_ <= var_245_51 + arg_245_0 then
				arg_242_1.var_.oldValueTypewriter = arg_242_1.fswtw_.percent

				SetActive(arg_242_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_242_1:ShowNextGo(false)
			end

			local var_245_52 = 7
			local var_245_53 = 0.466666666666667
			local var_245_54 = arg_242_1:GetWordFromCfg(417261059)
			local var_245_55 = arg_242_1:FormatText(var_245_54.content)
			local var_245_56, var_245_57 = arg_242_1:GetPercentByPara(var_245_55, 1)

			if var_245_51 < arg_242_1.time_ and arg_242_1.time_ <= var_245_51 + arg_245_0 then
				arg_242_1.talkMaxDuration = 0

				local var_245_58 = var_245_52 <= 0 and var_245_53 or var_245_53 * ((var_245_57 - arg_242_1.typewritterCharCountI18N) / var_245_52)

				if var_245_58 > 0 and var_245_53 < var_245_58 then
					arg_242_1.talkMaxDuration = var_245_58

					if var_245_58 + var_245_51 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_58 + var_245_51
					end
				end
			end

			local var_245_59 = 0.466666666666667
			local var_245_60 = math.max(var_245_59, arg_242_1.talkMaxDuration)

			if var_245_51 <= arg_242_1.time_ and arg_242_1.time_ < var_245_51 + var_245_60 then
				local var_245_61 = (arg_242_1.time_ - var_245_51) / var_245_60

				arg_242_1.fswtw_.percent = Mathf.Lerp(arg_242_1.var_.oldValueTypewriter, var_245_56, var_245_61)
				arg_242_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_242_1.fswtw_:SetDirty()
			end

			if arg_242_1.time_ >= var_245_51 + var_245_60 and arg_242_1.time_ < var_245_51 + var_245_60 + arg_245_0 then
				arg_242_1.fswtw_.percent = var_245_56

				arg_242_1.fswtw_:SetDirty()
				arg_242_1:ShowNextGo(true)

				arg_242_1.typewritterCharCountI18N = var_245_57
			end

			local var_245_62 = 1
			local var_245_63 = 1

			if var_245_62 < arg_242_1.time_ and arg_242_1.time_ <= var_245_62 + arg_245_0 then
				local var_245_64 = "play"
				local var_245_65 = "music"

				arg_242_1:AudioAction(var_245_64, var_245_65, "story_v_out_417261", "417261059", "story_v_out_417261.awb")

				local var_245_66 = ""
				local var_245_67 = manager.audio:GetAudioName("story_v_out_417261", "417261059")

				if var_245_67 ~= "" then
					if arg_242_1.bgmTxt_.text ~= var_245_67 and arg_242_1.bgmTxt_.text ~= "" then
						if arg_242_1.bgmTxt2_.text ~= "" then
							arg_242_1.bgmTxt_.text = arg_242_1.bgmTxt2_.text
						end

						arg_242_1.bgmTxt2_.text = var_245_67

						arg_242_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_242_1.bgmTxt_.text = var_245_67
						arg_242_1.bgmTxt2_.text = var_245_67
					end

					if arg_242_1.bgmTimer then
						arg_242_1.bgmTimer:Stop()

						arg_242_1.bgmTimer = nil
					end

					if arg_242_1.settingData.show_music_name == 1 then
						arg_242_1.musicController:SetSelectedState("show")
						arg_242_1.musicAnimator_:Play("open", 0, 0)

						if arg_242_1.settingData.music_time ~= 0 then
							arg_242_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_242_1.settingData.music_time), function()
								if arg_242_1 == nil or isNil(arg_242_1.bgmTxt_) then
									return
								end

								arg_242_1.musicController:SetSelectedState("hide")
								arg_242_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_245_68 = 0.566666666666667
			local var_245_69 = 1

			if var_245_68 < arg_242_1.time_ and arg_242_1.time_ <= var_245_68 + arg_245_0 then
				local var_245_70 = "stop"
				local var_245_71 = "effect"

				arg_242_1:AudioAction(var_245_70, var_245_71, "se_story_side_1068", "se_story_1068_restaurant", "")
			end
		end

		arg_242_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10014",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10115",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_242_1:InitPlayNodeList()
	end,
	Play417261060 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 417261060
		arg_247_1.duration_ = 4.57

		SetActive(arg_247_1.tipsGo_, false)

		function arg_247_1.onSingleLineFinish_()
			arg_247_1.onSingleLineUpdate_ = nil
			arg_247_1.onSingleLineFinish_ = nil
			arg_247_1.state_ = "waiting"
		end

		function arg_247_1.playNext_(arg_249_0)
			if arg_249_0 == 1 then
				arg_247_0:Play417261061(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			local var_250_0 = 0

			if var_250_0 < arg_247_1.time_ and arg_247_1.time_ <= var_250_0 + arg_250_0 then
				arg_247_1.fswbg_:SetActive(true)
				arg_247_1.dialog_:SetActive(false)

				arg_247_1.fswtw_.percent = 0

				local var_250_1 = arg_247_1:GetWordFromCfg(417261060)
				local var_250_2 = arg_247_1:FormatText(var_250_1.content)

				arg_247_1.fswt_.text = var_250_2

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.fswt_)

				arg_247_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_247_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_247_1.fswtw_:SetDirty()

				arg_247_1.typewritterCharCountI18N = 0

				SetActive(arg_247_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_247_1:ShowNextGo(false)
			end

			local var_250_3 = 0.1

			if var_250_3 < arg_247_1.time_ and arg_247_1.time_ <= var_250_3 + arg_250_0 then
				arg_247_1.var_.oldValueTypewriter = arg_247_1.fswtw_.percent

				SetActive(arg_247_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_247_1:ShowNextGo(false)
			end

			local var_250_4 = 44
			local var_250_5 = 2.93333333333333
			local var_250_6 = arg_247_1:GetWordFromCfg(417261060)
			local var_250_7 = arg_247_1:FormatText(var_250_6.content)
			local var_250_8, var_250_9 = arg_247_1:GetPercentByPara(var_250_7, 1)

			if var_250_3 < arg_247_1.time_ and arg_247_1.time_ <= var_250_3 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0

				local var_250_10 = var_250_4 <= 0 and var_250_5 or var_250_5 * ((var_250_9 - arg_247_1.typewritterCharCountI18N) / var_250_4)

				if var_250_10 > 0 and var_250_5 < var_250_10 then
					arg_247_1.talkMaxDuration = var_250_10

					if var_250_10 + var_250_3 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_10 + var_250_3
					end
				end
			end

			local var_250_11 = 2.93333333333333
			local var_250_12 = math.max(var_250_11, arg_247_1.talkMaxDuration)

			if var_250_3 <= arg_247_1.time_ and arg_247_1.time_ < var_250_3 + var_250_12 then
				local var_250_13 = (arg_247_1.time_ - var_250_3) / var_250_12

				arg_247_1.fswtw_.percent = Mathf.Lerp(arg_247_1.var_.oldValueTypewriter, var_250_8, var_250_13)
				arg_247_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_247_1.fswtw_:SetDirty()
			end

			if arg_247_1.time_ >= var_250_3 + var_250_12 and arg_247_1.time_ < var_250_3 + var_250_12 + arg_250_0 then
				arg_247_1.fswtw_.percent = var_250_8

				arg_247_1.fswtw_:SetDirty()
				arg_247_1:ShowNextGo(true)

				arg_247_1.typewritterCharCountI18N = var_250_9
			end

			local var_250_14 = 0.1
			local var_250_15 = 1

			if var_250_14 < arg_247_1.time_ and arg_247_1.time_ <= var_250_14 + arg_250_0 then
				local var_250_16 = "play"
				local var_250_17 = "music"

				arg_247_1:AudioAction(var_250_16, var_250_17, "story_v_out_417261", "417261060", "story_v_out_417261.awb")

				local var_250_18 = ""
				local var_250_19 = manager.audio:GetAudioName("story_v_out_417261", "417261060")

				if var_250_19 ~= "" then
					if arg_247_1.bgmTxt_.text ~= var_250_19 and arg_247_1.bgmTxt_.text ~= "" then
						if arg_247_1.bgmTxt2_.text ~= "" then
							arg_247_1.bgmTxt_.text = arg_247_1.bgmTxt2_.text
						end

						arg_247_1.bgmTxt2_.text = var_250_19

						arg_247_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_247_1.bgmTxt_.text = var_250_19
						arg_247_1.bgmTxt2_.text = var_250_19
					end

					if arg_247_1.bgmTimer then
						arg_247_1.bgmTimer:Stop()

						arg_247_1.bgmTimer = nil
					end

					if arg_247_1.settingData.show_music_name == 1 then
						arg_247_1.musicController:SetSelectedState("show")
						arg_247_1.musicAnimator_:Play("open", 0, 0)

						if arg_247_1.settingData.music_time ~= 0 then
							arg_247_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_247_1.settingData.music_time), function()
								if arg_247_1 == nil or isNil(arg_247_1.bgmTxt_) then
									return
								end

								arg_247_1.musicController:SetSelectedState("hide")
								arg_247_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end
		end

		arg_247_1.nodeConfigList_ = {}

		arg_247_1:InitPlayNodeList()
	end,
	Play417261061 = function(arg_252_0, arg_252_1)
		arg_252_1.time_ = 0
		arg_252_1.frameCnt_ = 0
		arg_252_1.state_ = "playing"
		arg_252_1.curTalkId_ = 417261061
		arg_252_1.duration_ = 1

		SetActive(arg_252_1.tipsGo_, false)

		function arg_252_1.onSingleLineFinish_()
			arg_252_1.onSingleLineUpdate_ = nil
			arg_252_1.onSingleLineFinish_ = nil
			arg_252_1.state_ = "waiting"
		end

		function arg_252_1.playNext_(arg_254_0)
			if arg_254_0 == 1 then
				arg_252_0:Play417261062(arg_252_1)
			end
		end

		function arg_252_1.onSingleLineUpdate_(arg_255_0)
			local var_255_0 = 0

			if var_255_0 < arg_252_1.time_ and arg_252_1.time_ <= var_255_0 + arg_255_0 then
				arg_252_1.fswbg_:SetActive(true)
				arg_252_1.dialog_:SetActive(false)

				arg_252_1.fswtw_.percent = 0

				local var_255_1 = arg_252_1:GetWordFromCfg(417261061)
				local var_255_2 = arg_252_1:FormatText(var_255_1.content)

				arg_252_1.fswt_.text = var_255_2

				LuaForUtil.ClearLinePrefixSymbol(arg_252_1.fswt_)

				arg_252_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_252_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_252_1.fswtw_:SetDirty()

				arg_252_1.typewritterCharCountI18N = 0

				SetActive(arg_252_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_252_1:ShowNextGo(false)
			end

			local var_255_3 = 0.0999999999999999

			if var_255_3 < arg_252_1.time_ and arg_252_1.time_ <= var_255_3 + arg_255_0 then
				arg_252_1.var_.oldValueTypewriter = arg_252_1.fswtw_.percent

				SetActive(arg_252_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_252_1:ShowNextGo(false)
			end

			local var_255_4 = 7
			local var_255_5 = 0.466666666666667
			local var_255_6 = arg_252_1:GetWordFromCfg(417261061)
			local var_255_7 = arg_252_1:FormatText(var_255_6.content)
			local var_255_8, var_255_9 = arg_252_1:GetPercentByPara(var_255_7, 1)

			if var_255_3 < arg_252_1.time_ and arg_252_1.time_ <= var_255_3 + arg_255_0 then
				arg_252_1.talkMaxDuration = 0

				local var_255_10 = var_255_4 <= 0 and var_255_5 or var_255_5 * ((var_255_9 - arg_252_1.typewritterCharCountI18N) / var_255_4)

				if var_255_10 > 0 and var_255_5 < var_255_10 then
					arg_252_1.talkMaxDuration = var_255_10

					if var_255_10 + var_255_3 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_10 + var_255_3
					end
				end
			end

			local var_255_11 = 0.466666666666667
			local var_255_12 = math.max(var_255_11, arg_252_1.talkMaxDuration)

			if var_255_3 <= arg_252_1.time_ and arg_252_1.time_ < var_255_3 + var_255_12 then
				local var_255_13 = (arg_252_1.time_ - var_255_3) / var_255_12

				arg_252_1.fswtw_.percent = Mathf.Lerp(arg_252_1.var_.oldValueTypewriter, var_255_8, var_255_13)
				arg_252_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_252_1.fswtw_:SetDirty()
			end

			if arg_252_1.time_ >= var_255_3 + var_255_12 and arg_252_1.time_ < var_255_3 + var_255_12 + arg_255_0 then
				arg_252_1.fswtw_.percent = var_255_8

				arg_252_1.fswtw_:SetDirty()
				arg_252_1:ShowNextGo(true)

				arg_252_1.typewritterCharCountI18N = var_255_9
			end

			local var_255_14 = 0
			local var_255_15 = 1
			local var_255_16 = manager.audio:GetVoiceLength("story_v_out_417261", "417261061", "story_v_out_417261.awb") / 1000

			if var_255_16 > 0 and var_255_15 < var_255_16 and var_255_16 + var_255_14 > arg_252_1.duration_ then
				local var_255_17 = var_255_16

				arg_252_1.duration_ = var_255_16 + var_255_14
			end

			if var_255_14 < arg_252_1.time_ and arg_252_1.time_ <= var_255_14 + arg_255_0 then
				local var_255_18 = "play"
				local var_255_19 = "voice"

				arg_252_1:AudioAction(var_255_18, var_255_19, "story_v_out_417261", "417261061", "story_v_out_417261.awb")
			end
		end

		arg_252_1.nodeConfigList_ = {}

		arg_252_1:InitPlayNodeList()
	end,
	Play417261062 = function(arg_256_0, arg_256_1)
		arg_256_1.time_ = 0
		arg_256_1.frameCnt_ = 0
		arg_256_1.state_ = "playing"
		arg_256_1.curTalkId_ = 417261062
		arg_256_1.duration_ = 1.77

		SetActive(arg_256_1.tipsGo_, false)

		function arg_256_1.onSingleLineFinish_()
			arg_256_1.onSingleLineUpdate_ = nil
			arg_256_1.onSingleLineFinish_ = nil
			arg_256_1.state_ = "waiting"
		end

		function arg_256_1.playNext_(arg_258_0)
			if arg_258_0 == 1 then
				arg_256_0:Play417261063(arg_256_1)
			end
		end

		function arg_256_1.onSingleLineUpdate_(arg_259_0)
			local var_259_0 = 0

			if var_259_0 < arg_256_1.time_ and arg_256_1.time_ <= var_259_0 + arg_259_0 then
				arg_256_1.fswbg_:SetActive(true)
				arg_256_1.dialog_:SetActive(false)

				arg_256_1.fswtw_.percent = 0

				local var_259_1 = arg_256_1:GetWordFromCfg(417261062)
				local var_259_2 = arg_256_1:FormatText(var_259_1.content)

				arg_256_1.fswt_.text = var_259_2

				LuaForUtil.ClearLinePrefixSymbol(arg_256_1.fswt_)

				arg_256_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_256_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_256_1.fswtw_:SetDirty()

				arg_256_1.typewritterCharCountI18N = 0

				SetActive(arg_256_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_256_1:ShowNextGo(false)
			end

			local var_259_3 = 0.0999999999999999

			if var_259_3 < arg_256_1.time_ and arg_256_1.time_ <= var_259_3 + arg_259_0 then
				arg_256_1.var_.oldValueTypewriter = arg_256_1.fswtw_.percent

				SetActive(arg_256_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_256_1:ShowNextGo(false)
			end

			local var_259_4 = 25
			local var_259_5 = 1.66666666666667
			local var_259_6 = arg_256_1:GetWordFromCfg(417261062)
			local var_259_7 = arg_256_1:FormatText(var_259_6.content)
			local var_259_8, var_259_9 = arg_256_1:GetPercentByPara(var_259_7, 1)

			if var_259_3 < arg_256_1.time_ and arg_256_1.time_ <= var_259_3 + arg_259_0 then
				arg_256_1.talkMaxDuration = 0

				local var_259_10 = var_259_4 <= 0 and var_259_5 or var_259_5 * ((var_259_9 - arg_256_1.typewritterCharCountI18N) / var_259_4)

				if var_259_10 > 0 and var_259_5 < var_259_10 then
					arg_256_1.talkMaxDuration = var_259_10

					if var_259_10 + var_259_3 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_10 + var_259_3
					end
				end
			end

			local var_259_11 = 1.66666666666667
			local var_259_12 = math.max(var_259_11, arg_256_1.talkMaxDuration)

			if var_259_3 <= arg_256_1.time_ and arg_256_1.time_ < var_259_3 + var_259_12 then
				local var_259_13 = (arg_256_1.time_ - var_259_3) / var_259_12

				arg_256_1.fswtw_.percent = Mathf.Lerp(arg_256_1.var_.oldValueTypewriter, var_259_8, var_259_13)
				arg_256_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_256_1.fswtw_:SetDirty()
			end

			if arg_256_1.time_ >= var_259_3 + var_259_12 and arg_256_1.time_ < var_259_3 + var_259_12 + arg_259_0 then
				arg_256_1.fswtw_.percent = var_259_8

				arg_256_1.fswtw_:SetDirty()
				arg_256_1:ShowNextGo(true)

				arg_256_1.typewritterCharCountI18N = var_259_9
			end

			local var_259_14 = 0
			local var_259_15 = 1
			local var_259_16 = manager.audio:GetVoiceLength("story_v_out_417261", "417261062", "story_v_out_417261.awb") / 1000

			if var_259_16 > 0 and var_259_15 < var_259_16 and var_259_16 + var_259_14 > arg_256_1.duration_ then
				local var_259_17 = var_259_16

				arg_256_1.duration_ = var_259_16 + var_259_14
			end

			if var_259_14 < arg_256_1.time_ and arg_256_1.time_ <= var_259_14 + arg_259_0 then
				local var_259_18 = "play"
				local var_259_19 = "voice"

				arg_256_1:AudioAction(var_259_18, var_259_19, "story_v_out_417261", "417261062", "story_v_out_417261.awb")
			end
		end

		arg_256_1.nodeConfigList_ = {}

		arg_256_1:InitPlayNodeList()
	end,
	Play417261063 = function(arg_260_0, arg_260_1)
		arg_260_1.time_ = 0
		arg_260_1.frameCnt_ = 0
		arg_260_1.state_ = "playing"
		arg_260_1.curTalkId_ = 417261063
		arg_260_1.duration_ = 1

		SetActive(arg_260_1.tipsGo_, false)

		function arg_260_1.onSingleLineFinish_()
			arg_260_1.onSingleLineUpdate_ = nil
			arg_260_1.onSingleLineFinish_ = nil
			arg_260_1.state_ = "waiting"
		end

		function arg_260_1.playNext_(arg_262_0)
			if arg_262_0 == 1 then
				arg_260_0:Play417261064(arg_260_1)
			end
		end

		function arg_260_1.onSingleLineUpdate_(arg_263_0)
			local var_263_0 = 0

			if var_263_0 < arg_260_1.time_ and arg_260_1.time_ <= var_263_0 + arg_263_0 then
				arg_260_1.fswbg_:SetActive(true)
				arg_260_1.dialog_:SetActive(false)

				arg_260_1.fswtw_.percent = 0

				local var_263_1 = arg_260_1:GetWordFromCfg(417261063)
				local var_263_2 = arg_260_1:FormatText(var_263_1.content)

				arg_260_1.fswt_.text = var_263_2

				LuaForUtil.ClearLinePrefixSymbol(arg_260_1.fswt_)

				arg_260_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_260_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_260_1.fswtw_:SetDirty()

				arg_260_1.typewritterCharCountI18N = 0

				SetActive(arg_260_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_260_1:ShowNextGo(false)
			end

			local var_263_3 = 0.0999999999999999

			if var_263_3 < arg_260_1.time_ and arg_260_1.time_ <= var_263_3 + arg_263_0 then
				arg_260_1.var_.oldValueTypewriter = arg_260_1.fswtw_.percent

				SetActive(arg_260_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_260_1:ShowNextGo(false)
			end

			local var_263_4 = 9
			local var_263_5 = 0.6
			local var_263_6 = arg_260_1:GetWordFromCfg(417261063)
			local var_263_7 = arg_260_1:FormatText(var_263_6.content)
			local var_263_8, var_263_9 = arg_260_1:GetPercentByPara(var_263_7, 1)

			if var_263_3 < arg_260_1.time_ and arg_260_1.time_ <= var_263_3 + arg_263_0 then
				arg_260_1.talkMaxDuration = 0

				local var_263_10 = var_263_4 <= 0 and var_263_5 or var_263_5 * ((var_263_9 - arg_260_1.typewritterCharCountI18N) / var_263_4)

				if var_263_10 > 0 and var_263_5 < var_263_10 then
					arg_260_1.talkMaxDuration = var_263_10

					if var_263_10 + var_263_3 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_10 + var_263_3
					end
				end
			end

			local var_263_11 = 0.6
			local var_263_12 = math.max(var_263_11, arg_260_1.talkMaxDuration)

			if var_263_3 <= arg_260_1.time_ and arg_260_1.time_ < var_263_3 + var_263_12 then
				local var_263_13 = (arg_260_1.time_ - var_263_3) / var_263_12

				arg_260_1.fswtw_.percent = Mathf.Lerp(arg_260_1.var_.oldValueTypewriter, var_263_8, var_263_13)
				arg_260_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_260_1.fswtw_:SetDirty()
			end

			if arg_260_1.time_ >= var_263_3 + var_263_12 and arg_260_1.time_ < var_263_3 + var_263_12 + arg_263_0 then
				arg_260_1.fswtw_.percent = var_263_8

				arg_260_1.fswtw_:SetDirty()
				arg_260_1:ShowNextGo(true)

				arg_260_1.typewritterCharCountI18N = var_263_9
			end

			local var_263_14 = 0
			local var_263_15 = 1
			local var_263_16 = manager.audio:GetVoiceLength("story_v_out_417261", "417261063", "story_v_out_417261.awb") / 1000

			if var_263_16 > 0 and var_263_15 < var_263_16 and var_263_16 + var_263_14 > arg_260_1.duration_ then
				local var_263_17 = var_263_16

				arg_260_1.duration_ = var_263_16 + var_263_14
			end

			if var_263_14 < arg_260_1.time_ and arg_260_1.time_ <= var_263_14 + arg_263_0 then
				local var_263_18 = "play"
				local var_263_19 = "voice"

				arg_260_1:AudioAction(var_263_18, var_263_19, "story_v_out_417261", "417261063", "story_v_out_417261.awb")
			end
		end

		arg_260_1.nodeConfigList_ = {}

		arg_260_1:InitPlayNodeList()
	end,
	Play417261064 = function(arg_264_0, arg_264_1)
		arg_264_1.time_ = 0
		arg_264_1.frameCnt_ = 0
		arg_264_1.state_ = "playing"
		arg_264_1.curTalkId_ = 417261064
		arg_264_1.duration_ = 10.1

		local var_264_0 = {
			zh = 7.966,
			ja = 10.1
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
				arg_264_0:Play417261065(arg_264_1)
			end
		end

		function arg_264_1.onSingleLineUpdate_(arg_267_0)
			local var_267_0 = 1

			if var_267_0 < arg_264_1.time_ and arg_264_1.time_ <= var_267_0 + arg_267_0 then
				local var_267_1 = manager.ui.mainCamera.transform.localPosition
				local var_267_2 = Vector3.New(0, 0, 10) + Vector3.New(var_267_1.x, var_267_1.y, 0)
				local var_267_3 = arg_264_1.bgs_.I16f

				var_267_3.transform.localPosition = var_267_2
				var_267_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_267_4 = var_267_3:GetComponent("SpriteRenderer")

				if var_267_4 and var_267_4.sprite then
					local var_267_5 = (var_267_3.transform.localPosition - var_267_1).z
					local var_267_6 = manager.ui.mainCameraCom_
					local var_267_7 = 2 * var_267_5 * Mathf.Tan(var_267_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_267_8 = var_267_7 * var_267_6.aspect
					local var_267_9 = var_267_4.sprite.bounds.size.x
					local var_267_10 = var_267_4.sprite.bounds.size.y
					local var_267_11 = var_267_8 / var_267_9
					local var_267_12 = var_267_7 / var_267_10
					local var_267_13 = var_267_12 < var_267_11 and var_267_11 or var_267_12

					var_267_3.transform.localScale = Vector3.New(var_267_13, var_267_13, 0)
				end

				for iter_267_0, iter_267_1 in pairs(arg_264_1.bgs_) do
					if iter_267_0 ~= "I16f" then
						iter_267_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_267_14 = 3

			if var_267_14 < arg_264_1.time_ and arg_264_1.time_ <= var_267_14 + arg_267_0 then
				arg_264_1.allBtn_.enabled = false
			end

			local var_267_15 = 0.3

			if arg_264_1.time_ >= var_267_14 + var_267_15 and arg_264_1.time_ < var_267_14 + var_267_15 + arg_267_0 then
				arg_264_1.allBtn_.enabled = true
			end

			local var_267_16 = 0

			if var_267_16 < arg_264_1.time_ and arg_264_1.time_ <= var_267_16 + arg_267_0 then
				arg_264_1.mask_.enabled = true
				arg_264_1.mask_.raycastTarget = true

				arg_264_1:SetGaussion(false)
			end

			local var_267_17 = 1

			if var_267_16 <= arg_264_1.time_ and arg_264_1.time_ < var_267_16 + var_267_17 then
				local var_267_18 = (arg_264_1.time_ - var_267_16) / var_267_17
				local var_267_19 = Color.New(0, 0, 0)

				var_267_19.a = Mathf.Lerp(0, 1, var_267_18)
				arg_264_1.mask_.color = var_267_19
			end

			if arg_264_1.time_ >= var_267_16 + var_267_17 and arg_264_1.time_ < var_267_16 + var_267_17 + arg_267_0 then
				local var_267_20 = Color.New(0, 0, 0)

				var_267_20.a = 1
				arg_264_1.mask_.color = var_267_20
			end

			local var_267_21 = 1

			if var_267_21 < arg_264_1.time_ and arg_264_1.time_ <= var_267_21 + arg_267_0 then
				arg_264_1.mask_.enabled = true
				arg_264_1.mask_.raycastTarget = true

				arg_264_1:SetGaussion(false)
			end

			local var_267_22 = 2

			if var_267_21 <= arg_264_1.time_ and arg_264_1.time_ < var_267_21 + var_267_22 then
				local var_267_23 = (arg_264_1.time_ - var_267_21) / var_267_22
				local var_267_24 = Color.New(0, 0, 0)

				var_267_24.a = Mathf.Lerp(1, 0, var_267_23)
				arg_264_1.mask_.color = var_267_24
			end

			if arg_264_1.time_ >= var_267_21 + var_267_22 and arg_264_1.time_ < var_267_21 + var_267_22 + arg_267_0 then
				local var_267_25 = Color.New(0, 0, 0)
				local var_267_26 = 0

				arg_264_1.mask_.enabled = false
				var_267_25.a = var_267_26
				arg_264_1.mask_.color = var_267_25
			end

			local var_267_27 = 0.900666666666667

			if var_267_27 < arg_264_1.time_ and arg_264_1.time_ <= var_267_27 + arg_267_0 then
				arg_264_1.fswbg_:SetActive(false)
				arg_264_1.dialog_:SetActive(false)
				SetActive(arg_264_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_264_1:ShowNextGo(false)
			end

			local var_267_28 = 0.900666666666667

			if var_267_28 < arg_264_1.time_ and arg_264_1.time_ <= var_267_28 + arg_267_0 then
				arg_264_1.cswbg_:SetActive(false)
			end

			local var_267_29 = 2.63333333333333
			local var_267_30 = 1

			if var_267_29 < arg_264_1.time_ and arg_264_1.time_ <= var_267_29 + arg_267_0 then
				local var_267_31 = "play"
				local var_267_32 = "effect"

				arg_264_1:AudioAction(var_267_31, var_267_32, "se_story_1311", "se_story_1311_thunder02", "")
			end

			local var_267_33 = 0.466666666666667
			local var_267_34 = 1

			if var_267_33 < arg_264_1.time_ and arg_264_1.time_ <= var_267_33 + arg_267_0 then
				local var_267_35 = "play"
				local var_267_36 = "effect"

				arg_264_1:AudioAction(var_267_35, var_267_36, "se_story_1311", "se_story_1311_wind", "")
			end

			if arg_264_1.frameCnt_ <= 1 then
				arg_264_1.dialog_:SetActive(false)
			end

			local var_267_37 = 3
			local var_267_38 = 0.5

			if var_267_37 < arg_264_1.time_ and arg_264_1.time_ <= var_267_37 + arg_267_0 then
				arg_264_1.talkMaxDuration = 0

				arg_264_1.dialog_:SetActive(true)

				arg_264_1.dialogCg_.alpha = 0

				local var_267_39 = LeanTween.value(arg_264_1.dialog_, 0, 1, 0.3)

				var_267_39:setOnUpdate(LuaHelper.FloatAction(function(arg_268_0)
					arg_264_1.dialogCg_.alpha = arg_268_0
				end))
				var_267_39:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_264_1.dialog_)
					var_267_39:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_264_1.duration_ = arg_264_1.duration_ + 0.3

				SetActive(arg_264_1.leftNameGo_, true)

				local var_267_40 = arg_264_1:FormatText(StoryNameCfg[1111].name)

				arg_264_1.leftNameTxt_.text = var_267_40

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_264_1.leftNameTxt_.transform)

				arg_264_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_264_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_264_1:RecordName(arg_264_1.leftNameTxt_.text)
				SetActive(arg_264_1.iconTrs_.gameObject, true)
				arg_264_1.iconController_:SetSelectedState("hero")

				arg_264_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2069")

				arg_264_1.callingController_:SetSelectedState("normal")

				arg_264_1.keyicon_.color = Color.New(1, 1, 1)
				arg_264_1.icon_.color = Color.New(1, 1, 1)

				local var_267_41 = arg_264_1:GetWordFromCfg(417261064)
				local var_267_42 = arg_264_1:FormatText(var_267_41.content)

				arg_264_1.text_.text = var_267_42

				LuaForUtil.ClearLinePrefixSymbol(arg_264_1.text_)

				local var_267_43 = 20
				local var_267_44 = utf8.len(var_267_42)
				local var_267_45 = var_267_43 <= 0 and var_267_38 or var_267_38 * (var_267_44 / var_267_43)

				if var_267_45 > 0 and var_267_38 < var_267_45 then
					arg_264_1.talkMaxDuration = var_267_45
					var_267_37 = var_267_37 + 0.3

					if var_267_45 + var_267_37 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_45 + var_267_37
					end
				end

				arg_264_1.text_.text = var_267_42
				arg_264_1.typewritter.percent = 0

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417261", "417261064", "story_v_out_417261.awb") ~= 0 then
					local var_267_46 = manager.audio:GetVoiceLength("story_v_out_417261", "417261064", "story_v_out_417261.awb") / 1000

					if var_267_46 + var_267_37 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_46 + var_267_37
					end

					if var_267_41.prefab_name ~= "" and arg_264_1.actors_[var_267_41.prefab_name] ~= nil then
						local var_267_47 = LuaForUtil.PlayVoiceWithCriLipsync(arg_264_1.actors_[var_267_41.prefab_name].transform, "story_v_out_417261", "417261064", "story_v_out_417261.awb")

						arg_264_1:RecordAudio("417261064", var_267_47)
						arg_264_1:RecordAudio("417261064", var_267_47)
					else
						arg_264_1:AudioAction("play", "voice", "story_v_out_417261", "417261064", "story_v_out_417261.awb")
					end

					arg_264_1:RecordHistoryTalkVoice("story_v_out_417261", "417261064", "story_v_out_417261.awb")
				end

				arg_264_1:RecordContent(arg_264_1.text_.text)
			end

			local var_267_48 = var_267_37 + 0.3
			local var_267_49 = math.max(var_267_38, arg_264_1.talkMaxDuration)

			if var_267_48 <= arg_264_1.time_ and arg_264_1.time_ < var_267_48 + var_267_49 then
				arg_264_1.typewritter.percent = (arg_264_1.time_ - var_267_48) / var_267_49

				arg_264_1.typewritter:SetDirty()
			end

			if arg_264_1.time_ >= var_267_48 + var_267_49 and arg_264_1.time_ < var_267_48 + var_267_49 + arg_267_0 then
				arg_264_1.typewritter.percent = 1

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(true)
			end
		end

		arg_264_1.nodeConfigList_ = {}

		arg_264_1:InitPlayNodeList()
	end,
	Play417261065 = function(arg_270_0, arg_270_1)
		arg_270_1.time_ = 0
		arg_270_1.frameCnt_ = 0
		arg_270_1.state_ = "playing"
		arg_270_1.curTalkId_ = 417261065
		arg_270_1.duration_ = 4.77

		local var_270_0 = {
			zh = 2.4,
			ja = 4.766
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
				arg_270_0:Play417261066(arg_270_1)
			end
		end

		function arg_270_1.onSingleLineUpdate_(arg_273_0)
			local var_273_0 = arg_270_1.actors_["1034"]
			local var_273_1 = 0

			if var_273_1 < arg_270_1.time_ and arg_270_1.time_ <= var_273_1 + arg_273_0 and not isNil(var_273_0) and arg_270_1.var_.actorSpriteComps1034 == nil then
				arg_270_1.var_.actorSpriteComps1034 = var_273_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_273_2 = 0.2

			if var_273_1 <= arg_270_1.time_ and arg_270_1.time_ < var_273_1 + var_273_2 and not isNil(var_273_0) then
				local var_273_3 = (arg_270_1.time_ - var_273_1) / var_273_2

				if arg_270_1.var_.actorSpriteComps1034 then
					for iter_273_0, iter_273_1 in pairs(arg_270_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_273_1 then
							if arg_270_1.isInRecall_ then
								local var_273_4 = Mathf.Lerp(iter_273_1.color.r, arg_270_1.hightColor1.r, var_273_3)
								local var_273_5 = Mathf.Lerp(iter_273_1.color.g, arg_270_1.hightColor1.g, var_273_3)
								local var_273_6 = Mathf.Lerp(iter_273_1.color.b, arg_270_1.hightColor1.b, var_273_3)

								iter_273_1.color = Color.New(var_273_4, var_273_5, var_273_6)
							else
								local var_273_7 = Mathf.Lerp(iter_273_1.color.r, 1, var_273_3)

								iter_273_1.color = Color.New(var_273_7, var_273_7, var_273_7)
							end
						end
					end
				end
			end

			if arg_270_1.time_ >= var_273_1 + var_273_2 and arg_270_1.time_ < var_273_1 + var_273_2 + arg_273_0 and not isNil(var_273_0) and arg_270_1.var_.actorSpriteComps1034 then
				for iter_273_2, iter_273_3 in pairs(arg_270_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_273_3 then
						if arg_270_1.isInRecall_ then
							iter_273_3.color = arg_270_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_273_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_270_1.var_.actorSpriteComps1034 = nil
			end

			local var_273_8 = arg_270_1.actors_["1034"].transform
			local var_273_9 = 0

			if var_273_9 < arg_270_1.time_ and arg_270_1.time_ <= var_273_9 + arg_273_0 then
				arg_270_1.var_.moveOldPos1034 = var_273_8.localPosition
				var_273_8.localScale = Vector3.New(1, 1, 1)

				arg_270_1:CheckSpriteTmpPos("1034", 3)

				local var_273_10 = var_273_8.childCount

				for iter_273_4 = 0, var_273_10 - 1 do
					local var_273_11 = var_273_8:GetChild(iter_273_4)

					if var_273_11.name == "split_6" or not string.find(var_273_11.name, "split") then
						var_273_11.gameObject:SetActive(true)
					else
						var_273_11.gameObject:SetActive(false)
					end
				end
			end

			local var_273_12 = 0.001

			if var_273_9 <= arg_270_1.time_ and arg_270_1.time_ < var_273_9 + var_273_12 then
				local var_273_13 = (arg_270_1.time_ - var_273_9) / var_273_12
				local var_273_14 = Vector3.New(0, -331.9, -324)

				var_273_8.localPosition = Vector3.Lerp(arg_270_1.var_.moveOldPos1034, var_273_14, var_273_13)
			end

			if arg_270_1.time_ >= var_273_9 + var_273_12 and arg_270_1.time_ < var_273_9 + var_273_12 + arg_273_0 then
				var_273_8.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_273_15 = 0
			local var_273_16 = 0.225

			if var_273_15 < arg_270_1.time_ and arg_270_1.time_ <= var_273_15 + arg_273_0 then
				arg_270_1.talkMaxDuration = 0
				arg_270_1.dialogCg_.alpha = 1

				arg_270_1.dialog_:SetActive(true)
				SetActive(arg_270_1.leftNameGo_, true)

				local var_273_17 = arg_270_1:FormatText(StoryNameCfg[1109].name)

				arg_270_1.leftNameTxt_.text = var_273_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_270_1.leftNameTxt_.transform)

				arg_270_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_270_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_270_1:RecordName(arg_270_1.leftNameTxt_.text)
				SetActive(arg_270_1.iconTrs_.gameObject, false)
				arg_270_1.callingController_:SetSelectedState("normal")

				local var_273_18 = arg_270_1:GetWordFromCfg(417261065)
				local var_273_19 = arg_270_1:FormatText(var_273_18.content)

				arg_270_1.text_.text = var_273_19

				LuaForUtil.ClearLinePrefixSymbol(arg_270_1.text_)

				local var_273_20 = 9
				local var_273_21 = utf8.len(var_273_19)
				local var_273_22 = var_273_20 <= 0 and var_273_16 or var_273_16 * (var_273_21 / var_273_20)

				if var_273_22 > 0 and var_273_16 < var_273_22 then
					arg_270_1.talkMaxDuration = var_273_22

					if var_273_22 + var_273_15 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_22 + var_273_15
					end
				end

				arg_270_1.text_.text = var_273_19
				arg_270_1.typewritter.percent = 0

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417261", "417261065", "story_v_out_417261.awb") ~= 0 then
					local var_273_23 = manager.audio:GetVoiceLength("story_v_out_417261", "417261065", "story_v_out_417261.awb") / 1000

					if var_273_23 + var_273_15 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_23 + var_273_15
					end

					if var_273_18.prefab_name ~= "" and arg_270_1.actors_[var_273_18.prefab_name] ~= nil then
						local var_273_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_270_1.actors_[var_273_18.prefab_name].transform, "story_v_out_417261", "417261065", "story_v_out_417261.awb")

						arg_270_1:RecordAudio("417261065", var_273_24)
						arg_270_1:RecordAudio("417261065", var_273_24)
					else
						arg_270_1:AudioAction("play", "voice", "story_v_out_417261", "417261065", "story_v_out_417261.awb")
					end

					arg_270_1:RecordHistoryTalkVoice("story_v_out_417261", "417261065", "story_v_out_417261.awb")
				end

				arg_270_1:RecordContent(arg_270_1.text_.text)
			end

			local var_273_25 = math.max(var_273_16, arg_270_1.talkMaxDuration)

			if var_273_15 <= arg_270_1.time_ and arg_270_1.time_ < var_273_15 + var_273_25 then
				arg_270_1.typewritter.percent = (arg_270_1.time_ - var_273_15) / var_273_25

				arg_270_1.typewritter:SetDirty()
			end

			if arg_270_1.time_ >= var_273_15 + var_273_25 and arg_270_1.time_ < var_273_15 + var_273_25 + arg_273_0 then
				arg_270_1.typewritter.percent = 1

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(true)
			end
		end

		arg_270_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_270_1:InitPlayNodeList()
	end,
	Play417261066 = function(arg_274_0, arg_274_1)
		arg_274_1.time_ = 0
		arg_274_1.frameCnt_ = 0
		arg_274_1.state_ = "playing"
		arg_274_1.curTalkId_ = 417261066
		arg_274_1.duration_ = 5

		SetActive(arg_274_1.tipsGo_, false)

		function arg_274_1.onSingleLineFinish_()
			arg_274_1.onSingleLineUpdate_ = nil
			arg_274_1.onSingleLineFinish_ = nil
			arg_274_1.state_ = "waiting"
		end

		function arg_274_1.playNext_(arg_276_0)
			if arg_276_0 == 1 then
				arg_274_0:Play417261067(arg_274_1)
			end
		end

		function arg_274_1.onSingleLineUpdate_(arg_277_0)
			local var_277_0 = arg_274_1.actors_["1034"]
			local var_277_1 = 0

			if var_277_1 < arg_274_1.time_ and arg_274_1.time_ <= var_277_1 + arg_277_0 and not isNil(var_277_0) and arg_274_1.var_.actorSpriteComps1034 == nil then
				arg_274_1.var_.actorSpriteComps1034 = var_277_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_277_2 = 0.2

			if var_277_1 <= arg_274_1.time_ and arg_274_1.time_ < var_277_1 + var_277_2 and not isNil(var_277_0) then
				local var_277_3 = (arg_274_1.time_ - var_277_1) / var_277_2

				if arg_274_1.var_.actorSpriteComps1034 then
					for iter_277_0, iter_277_1 in pairs(arg_274_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_277_1 then
							if arg_274_1.isInRecall_ then
								local var_277_4 = Mathf.Lerp(iter_277_1.color.r, arg_274_1.hightColor2.r, var_277_3)
								local var_277_5 = Mathf.Lerp(iter_277_1.color.g, arg_274_1.hightColor2.g, var_277_3)
								local var_277_6 = Mathf.Lerp(iter_277_1.color.b, arg_274_1.hightColor2.b, var_277_3)

								iter_277_1.color = Color.New(var_277_4, var_277_5, var_277_6)
							else
								local var_277_7 = Mathf.Lerp(iter_277_1.color.r, 0.5, var_277_3)

								iter_277_1.color = Color.New(var_277_7, var_277_7, var_277_7)
							end
						end
					end
				end
			end

			if arg_274_1.time_ >= var_277_1 + var_277_2 and arg_274_1.time_ < var_277_1 + var_277_2 + arg_277_0 and not isNil(var_277_0) and arg_274_1.var_.actorSpriteComps1034 then
				for iter_277_2, iter_277_3 in pairs(arg_274_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_277_3 then
						if arg_274_1.isInRecall_ then
							iter_277_3.color = arg_274_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_277_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_274_1.var_.actorSpriteComps1034 = nil
			end

			local var_277_8 = 0
			local var_277_9 = 1.425

			if var_277_8 < arg_274_1.time_ and arg_274_1.time_ <= var_277_8 + arg_277_0 then
				arg_274_1.talkMaxDuration = 0
				arg_274_1.dialogCg_.alpha = 1

				arg_274_1.dialog_:SetActive(true)
				SetActive(arg_274_1.leftNameGo_, false)

				arg_274_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_274_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_274_1:RecordName(arg_274_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_274_1.iconTrs_.gameObject, false)
				arg_274_1.callingController_:SetSelectedState("normal")

				local var_277_10 = arg_274_1:GetWordFromCfg(417261066)
				local var_277_11 = arg_274_1:FormatText(var_277_10.content)

				arg_274_1.text_.text = var_277_11

				LuaForUtil.ClearLinePrefixSymbol(arg_274_1.text_)

				local var_277_12 = 57
				local var_277_13 = utf8.len(var_277_11)
				local var_277_14 = var_277_12 <= 0 and var_277_9 or var_277_9 * (var_277_13 / var_277_12)

				if var_277_14 > 0 and var_277_9 < var_277_14 then
					arg_274_1.talkMaxDuration = var_277_14

					if var_277_14 + var_277_8 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_14 + var_277_8
					end
				end

				arg_274_1.text_.text = var_277_11
				arg_274_1.typewritter.percent = 0

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(false)
				arg_274_1:RecordContent(arg_274_1.text_.text)
			end

			local var_277_15 = math.max(var_277_9, arg_274_1.talkMaxDuration)

			if var_277_8 <= arg_274_1.time_ and arg_274_1.time_ < var_277_8 + var_277_15 then
				arg_274_1.typewritter.percent = (arg_274_1.time_ - var_277_8) / var_277_15

				arg_274_1.typewritter:SetDirty()
			end

			if arg_274_1.time_ >= var_277_8 + var_277_15 and arg_274_1.time_ < var_277_8 + var_277_15 + arg_277_0 then
				arg_274_1.typewritter.percent = 1

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(true)
			end
		end

		arg_274_1.nodeConfigList_ = {}

		arg_274_1:InitPlayNodeList()
	end,
	Play417261067 = function(arg_278_0, arg_278_1)
		arg_278_1.time_ = 0
		arg_278_1.frameCnt_ = 0
		arg_278_1.state_ = "playing"
		arg_278_1.curTalkId_ = 417261067
		arg_278_1.duration_ = 3.97

		local var_278_0 = {
			zh = 2.733,
			ja = 3.966
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
				arg_278_0:Play417261068(arg_278_1)
			end
		end

		function arg_278_1.onSingleLineUpdate_(arg_281_0)
			local var_281_0 = arg_278_1.actors_["1034"]
			local var_281_1 = 0

			if var_281_1 < arg_278_1.time_ and arg_278_1.time_ <= var_281_1 + arg_281_0 and not isNil(var_281_0) and arg_278_1.var_.actorSpriteComps1034 == nil then
				arg_278_1.var_.actorSpriteComps1034 = var_281_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_281_2 = 0.2

			if var_281_1 <= arg_278_1.time_ and arg_278_1.time_ < var_281_1 + var_281_2 and not isNil(var_281_0) then
				local var_281_3 = (arg_278_1.time_ - var_281_1) / var_281_2

				if arg_278_1.var_.actorSpriteComps1034 then
					for iter_281_0, iter_281_1 in pairs(arg_278_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_281_1 then
							if arg_278_1.isInRecall_ then
								local var_281_4 = Mathf.Lerp(iter_281_1.color.r, arg_278_1.hightColor2.r, var_281_3)
								local var_281_5 = Mathf.Lerp(iter_281_1.color.g, arg_278_1.hightColor2.g, var_281_3)
								local var_281_6 = Mathf.Lerp(iter_281_1.color.b, arg_278_1.hightColor2.b, var_281_3)

								iter_281_1.color = Color.New(var_281_4, var_281_5, var_281_6)
							else
								local var_281_7 = Mathf.Lerp(iter_281_1.color.r, 0.5, var_281_3)

								iter_281_1.color = Color.New(var_281_7, var_281_7, var_281_7)
							end
						end
					end
				end
			end

			if arg_278_1.time_ >= var_281_1 + var_281_2 and arg_278_1.time_ < var_281_1 + var_281_2 + arg_281_0 and not isNil(var_281_0) and arg_278_1.var_.actorSpriteComps1034 then
				for iter_281_2, iter_281_3 in pairs(arg_278_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_281_3 then
						if arg_278_1.isInRecall_ then
							iter_281_3.color = arg_278_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_281_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_278_1.var_.actorSpriteComps1034 = nil
			end

			local var_281_8 = arg_278_1.actors_["1034"].transform
			local var_281_9 = 0

			if var_281_9 < arg_278_1.time_ and arg_278_1.time_ <= var_281_9 + arg_281_0 then
				arg_278_1.var_.moveOldPos1034 = var_281_8.localPosition
				var_281_8.localScale = Vector3.New(1, 1, 1)

				arg_278_1:CheckSpriteTmpPos("1034", 2)

				local var_281_10 = var_281_8.childCount

				for iter_281_4 = 0, var_281_10 - 1 do
					local var_281_11 = var_281_8:GetChild(iter_281_4)

					if var_281_11.name == "split_6" or not string.find(var_281_11.name, "split") then
						var_281_11.gameObject:SetActive(true)
					else
						var_281_11.gameObject:SetActive(false)
					end
				end
			end

			local var_281_12 = 0.001

			if var_281_9 <= arg_278_1.time_ and arg_278_1.time_ < var_281_9 + var_281_12 then
				local var_281_13 = (arg_278_1.time_ - var_281_9) / var_281_12
				local var_281_14 = Vector3.New(-390, -331.9, -324)

				var_281_8.localPosition = Vector3.Lerp(arg_278_1.var_.moveOldPos1034, var_281_14, var_281_13)
			end

			if arg_278_1.time_ >= var_281_9 + var_281_12 and arg_278_1.time_ < var_281_9 + var_281_12 + arg_281_0 then
				var_281_8.localPosition = Vector3.New(-390, -331.9, -324)
			end

			local var_281_15 = arg_278_1.actors_["10128"]
			local var_281_16 = 0

			if var_281_16 < arg_278_1.time_ and arg_278_1.time_ <= var_281_16 + arg_281_0 and not isNil(var_281_15) and arg_278_1.var_.actorSpriteComps10128 == nil then
				arg_278_1.var_.actorSpriteComps10128 = var_281_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_281_17 = 0.2

			if var_281_16 <= arg_278_1.time_ and arg_278_1.time_ < var_281_16 + var_281_17 and not isNil(var_281_15) then
				local var_281_18 = (arg_278_1.time_ - var_281_16) / var_281_17

				if arg_278_1.var_.actorSpriteComps10128 then
					for iter_281_5, iter_281_6 in pairs(arg_278_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_281_6 then
							if arg_278_1.isInRecall_ then
								local var_281_19 = Mathf.Lerp(iter_281_6.color.r, arg_278_1.hightColor1.r, var_281_18)
								local var_281_20 = Mathf.Lerp(iter_281_6.color.g, arg_278_1.hightColor1.g, var_281_18)
								local var_281_21 = Mathf.Lerp(iter_281_6.color.b, arg_278_1.hightColor1.b, var_281_18)

								iter_281_6.color = Color.New(var_281_19, var_281_20, var_281_21)
							else
								local var_281_22 = Mathf.Lerp(iter_281_6.color.r, 1, var_281_18)

								iter_281_6.color = Color.New(var_281_22, var_281_22, var_281_22)
							end
						end
					end
				end
			end

			if arg_278_1.time_ >= var_281_16 + var_281_17 and arg_278_1.time_ < var_281_16 + var_281_17 + arg_281_0 and not isNil(var_281_15) and arg_278_1.var_.actorSpriteComps10128 then
				for iter_281_7, iter_281_8 in pairs(arg_278_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_281_8 then
						if arg_278_1.isInRecall_ then
							iter_281_8.color = arg_278_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_281_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_278_1.var_.actorSpriteComps10128 = nil
			end

			local var_281_23 = arg_278_1.actors_["10128"].transform
			local var_281_24 = 0

			if var_281_24 < arg_278_1.time_ and arg_278_1.time_ <= var_281_24 + arg_281_0 then
				arg_278_1.var_.moveOldPos10128 = var_281_23.localPosition
				var_281_23.localScale = Vector3.New(1, 1, 1)

				arg_278_1:CheckSpriteTmpPos("10128", 4)

				local var_281_25 = var_281_23.childCount

				for iter_281_9 = 0, var_281_25 - 1 do
					local var_281_26 = var_281_23:GetChild(iter_281_9)

					if var_281_26.name == "" or not string.find(var_281_26.name, "split") then
						var_281_26.gameObject:SetActive(true)
					else
						var_281_26.gameObject:SetActive(false)
					end
				end
			end

			local var_281_27 = 0.001

			if var_281_24 <= arg_278_1.time_ and arg_278_1.time_ < var_281_24 + var_281_27 then
				local var_281_28 = (arg_278_1.time_ - var_281_24) / var_281_27
				local var_281_29 = Vector3.New(390, -347, -300)

				var_281_23.localPosition = Vector3.Lerp(arg_278_1.var_.moveOldPos10128, var_281_29, var_281_28)
			end

			if arg_278_1.time_ >= var_281_24 + var_281_27 and arg_278_1.time_ < var_281_24 + var_281_27 + arg_281_0 then
				var_281_23.localPosition = Vector3.New(390, -347, -300)
			end

			local var_281_30 = 0
			local var_281_31 = 0.325

			if var_281_30 < arg_278_1.time_ and arg_278_1.time_ <= var_281_30 + arg_281_0 then
				arg_278_1.talkMaxDuration = 0
				arg_278_1.dialogCg_.alpha = 1

				arg_278_1.dialog_:SetActive(true)
				SetActive(arg_278_1.leftNameGo_, true)

				local var_281_32 = arg_278_1:FormatText(StoryNameCfg[595].name)

				arg_278_1.leftNameTxt_.text = var_281_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_278_1.leftNameTxt_.transform)

				arg_278_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_278_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_278_1:RecordName(arg_278_1.leftNameTxt_.text)
				SetActive(arg_278_1.iconTrs_.gameObject, false)
				arg_278_1.callingController_:SetSelectedState("normal")

				local var_281_33 = arg_278_1:GetWordFromCfg(417261067)
				local var_281_34 = arg_278_1:FormatText(var_281_33.content)

				arg_278_1.text_.text = var_281_34

				LuaForUtil.ClearLinePrefixSymbol(arg_278_1.text_)

				local var_281_35 = 13
				local var_281_36 = utf8.len(var_281_34)
				local var_281_37 = var_281_35 <= 0 and var_281_31 or var_281_31 * (var_281_36 / var_281_35)

				if var_281_37 > 0 and var_281_31 < var_281_37 then
					arg_278_1.talkMaxDuration = var_281_37

					if var_281_37 + var_281_30 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_37 + var_281_30
					end
				end

				arg_278_1.text_.text = var_281_34
				arg_278_1.typewritter.percent = 0

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417261", "417261067", "story_v_out_417261.awb") ~= 0 then
					local var_281_38 = manager.audio:GetVoiceLength("story_v_out_417261", "417261067", "story_v_out_417261.awb") / 1000

					if var_281_38 + var_281_30 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_38 + var_281_30
					end

					if var_281_33.prefab_name ~= "" and arg_278_1.actors_[var_281_33.prefab_name] ~= nil then
						local var_281_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_278_1.actors_[var_281_33.prefab_name].transform, "story_v_out_417261", "417261067", "story_v_out_417261.awb")

						arg_278_1:RecordAudio("417261067", var_281_39)
						arg_278_1:RecordAudio("417261067", var_281_39)
					else
						arg_278_1:AudioAction("play", "voice", "story_v_out_417261", "417261067", "story_v_out_417261.awb")
					end

					arg_278_1:RecordHistoryTalkVoice("story_v_out_417261", "417261067", "story_v_out_417261.awb")
				end

				arg_278_1:RecordContent(arg_278_1.text_.text)
			end

			local var_281_40 = math.max(var_281_31, arg_278_1.talkMaxDuration)

			if var_281_30 <= arg_278_1.time_ and arg_278_1.time_ < var_281_30 + var_281_40 then
				arg_278_1.typewritter.percent = (arg_278_1.time_ - var_281_30) / var_281_40

				arg_278_1.typewritter:SetDirty()
			end

			if arg_278_1.time_ >= var_281_30 + var_281_40 and arg_278_1.time_ < var_281_30 + var_281_40 + arg_281_0 then
				arg_278_1.typewritter.percent = 1

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(true)
			end
		end

		arg_278_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_278_1:InitPlayNodeList()
	end,
	Play417261068 = function(arg_282_0, arg_282_1)
		arg_282_1.time_ = 0
		arg_282_1.frameCnt_ = 0
		arg_282_1.state_ = "playing"
		arg_282_1.curTalkId_ = 417261068
		arg_282_1.duration_ = 5.6

		local var_282_0 = {
			zh = 3.466,
			ja = 5.6
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
				arg_282_0:Play417261069(arg_282_1)
			end
		end

		function arg_282_1.onSingleLineUpdate_(arg_285_0)
			local var_285_0 = arg_282_1.actors_["1034"]
			local var_285_1 = 0

			if var_285_1 < arg_282_1.time_ and arg_282_1.time_ <= var_285_1 + arg_285_0 and not isNil(var_285_0) and arg_282_1.var_.actorSpriteComps1034 == nil then
				arg_282_1.var_.actorSpriteComps1034 = var_285_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_285_2 = 0.2

			if var_285_1 <= arg_282_1.time_ and arg_282_1.time_ < var_285_1 + var_285_2 and not isNil(var_285_0) then
				local var_285_3 = (arg_282_1.time_ - var_285_1) / var_285_2

				if arg_282_1.var_.actorSpriteComps1034 then
					for iter_285_0, iter_285_1 in pairs(arg_282_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_285_1 then
							if arg_282_1.isInRecall_ then
								local var_285_4 = Mathf.Lerp(iter_285_1.color.r, arg_282_1.hightColor1.r, var_285_3)
								local var_285_5 = Mathf.Lerp(iter_285_1.color.g, arg_282_1.hightColor1.g, var_285_3)
								local var_285_6 = Mathf.Lerp(iter_285_1.color.b, arg_282_1.hightColor1.b, var_285_3)

								iter_285_1.color = Color.New(var_285_4, var_285_5, var_285_6)
							else
								local var_285_7 = Mathf.Lerp(iter_285_1.color.r, 1, var_285_3)

								iter_285_1.color = Color.New(var_285_7, var_285_7, var_285_7)
							end
						end
					end
				end
			end

			if arg_282_1.time_ >= var_285_1 + var_285_2 and arg_282_1.time_ < var_285_1 + var_285_2 + arg_285_0 and not isNil(var_285_0) and arg_282_1.var_.actorSpriteComps1034 then
				for iter_285_2, iter_285_3 in pairs(arg_282_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_285_3 then
						if arg_282_1.isInRecall_ then
							iter_285_3.color = arg_282_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_285_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_282_1.var_.actorSpriteComps1034 = nil
			end

			local var_285_8 = arg_282_1.actors_["10128"]
			local var_285_9 = 0

			if var_285_9 < arg_282_1.time_ and arg_282_1.time_ <= var_285_9 + arg_285_0 and not isNil(var_285_8) and arg_282_1.var_.actorSpriteComps10128 == nil then
				arg_282_1.var_.actorSpriteComps10128 = var_285_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_285_10 = 0.2

			if var_285_9 <= arg_282_1.time_ and arg_282_1.time_ < var_285_9 + var_285_10 and not isNil(var_285_8) then
				local var_285_11 = (arg_282_1.time_ - var_285_9) / var_285_10

				if arg_282_1.var_.actorSpriteComps10128 then
					for iter_285_4, iter_285_5 in pairs(arg_282_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_285_5 then
							if arg_282_1.isInRecall_ then
								local var_285_12 = Mathf.Lerp(iter_285_5.color.r, arg_282_1.hightColor2.r, var_285_11)
								local var_285_13 = Mathf.Lerp(iter_285_5.color.g, arg_282_1.hightColor2.g, var_285_11)
								local var_285_14 = Mathf.Lerp(iter_285_5.color.b, arg_282_1.hightColor2.b, var_285_11)

								iter_285_5.color = Color.New(var_285_12, var_285_13, var_285_14)
							else
								local var_285_15 = Mathf.Lerp(iter_285_5.color.r, 0.5, var_285_11)

								iter_285_5.color = Color.New(var_285_15, var_285_15, var_285_15)
							end
						end
					end
				end
			end

			if arg_282_1.time_ >= var_285_9 + var_285_10 and arg_282_1.time_ < var_285_9 + var_285_10 + arg_285_0 and not isNil(var_285_8) and arg_282_1.var_.actorSpriteComps10128 then
				for iter_285_6, iter_285_7 in pairs(arg_282_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_285_7 then
						if arg_282_1.isInRecall_ then
							iter_285_7.color = arg_282_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_285_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_282_1.var_.actorSpriteComps10128 = nil
			end

			local var_285_16 = 0
			local var_285_17 = 0.35

			if var_285_16 < arg_282_1.time_ and arg_282_1.time_ <= var_285_16 + arg_285_0 then
				arg_282_1.talkMaxDuration = 0
				arg_282_1.dialogCg_.alpha = 1

				arg_282_1.dialog_:SetActive(true)
				SetActive(arg_282_1.leftNameGo_, true)

				local var_285_18 = arg_282_1:FormatText(StoryNameCfg[1109].name)

				arg_282_1.leftNameTxt_.text = var_285_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_282_1.leftNameTxt_.transform)

				arg_282_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_282_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_282_1:RecordName(arg_282_1.leftNameTxt_.text)
				SetActive(arg_282_1.iconTrs_.gameObject, false)
				arg_282_1.callingController_:SetSelectedState("normal")

				local var_285_19 = arg_282_1:GetWordFromCfg(417261068)
				local var_285_20 = arg_282_1:FormatText(var_285_19.content)

				arg_282_1.text_.text = var_285_20

				LuaForUtil.ClearLinePrefixSymbol(arg_282_1.text_)

				local var_285_21 = 14
				local var_285_22 = utf8.len(var_285_20)
				local var_285_23 = var_285_21 <= 0 and var_285_17 or var_285_17 * (var_285_22 / var_285_21)

				if var_285_23 > 0 and var_285_17 < var_285_23 then
					arg_282_1.talkMaxDuration = var_285_23

					if var_285_23 + var_285_16 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_23 + var_285_16
					end
				end

				arg_282_1.text_.text = var_285_20
				arg_282_1.typewritter.percent = 0

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417261", "417261068", "story_v_out_417261.awb") ~= 0 then
					local var_285_24 = manager.audio:GetVoiceLength("story_v_out_417261", "417261068", "story_v_out_417261.awb") / 1000

					if var_285_24 + var_285_16 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_24 + var_285_16
					end

					if var_285_19.prefab_name ~= "" and arg_282_1.actors_[var_285_19.prefab_name] ~= nil then
						local var_285_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_282_1.actors_[var_285_19.prefab_name].transform, "story_v_out_417261", "417261068", "story_v_out_417261.awb")

						arg_282_1:RecordAudio("417261068", var_285_25)
						arg_282_1:RecordAudio("417261068", var_285_25)
					else
						arg_282_1:AudioAction("play", "voice", "story_v_out_417261", "417261068", "story_v_out_417261.awb")
					end

					arg_282_1:RecordHistoryTalkVoice("story_v_out_417261", "417261068", "story_v_out_417261.awb")
				end

				arg_282_1:RecordContent(arg_282_1.text_.text)
			end

			local var_285_26 = math.max(var_285_17, arg_282_1.talkMaxDuration)

			if var_285_16 <= arg_282_1.time_ and arg_282_1.time_ < var_285_16 + var_285_26 then
				arg_282_1.typewritter.percent = (arg_282_1.time_ - var_285_16) / var_285_26

				arg_282_1.typewritter:SetDirty()
			end

			if arg_282_1.time_ >= var_285_16 + var_285_26 and arg_282_1.time_ < var_285_16 + var_285_26 + arg_285_0 then
				arg_282_1.typewritter.percent = 1

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(true)
			end
		end

		arg_282_1.nodeConfigList_ = {}

		arg_282_1:InitPlayNodeList()
	end,
	Play417261069 = function(arg_286_0, arg_286_1)
		arg_286_1.time_ = 0
		arg_286_1.frameCnt_ = 0
		arg_286_1.state_ = "playing"
		arg_286_1.curTalkId_ = 417261069
		arg_286_1.duration_ = 4.17

		local var_286_0 = {
			zh = 2.7,
			ja = 4.166
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
				arg_286_0:Play417261070(arg_286_1)
			end
		end

		function arg_286_1.onSingleLineUpdate_(arg_289_0)
			local var_289_0 = 0
			local var_289_1 = 0.325

			if var_289_0 < arg_286_1.time_ and arg_286_1.time_ <= var_289_0 + arg_289_0 then
				arg_286_1.talkMaxDuration = 0
				arg_286_1.dialogCg_.alpha = 1

				arg_286_1.dialog_:SetActive(true)
				SetActive(arg_286_1.leftNameGo_, true)

				local var_289_2 = arg_286_1:FormatText(StoryNameCfg[1109].name)

				arg_286_1.leftNameTxt_.text = var_289_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_286_1.leftNameTxt_.transform)

				arg_286_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_286_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_286_1:RecordName(arg_286_1.leftNameTxt_.text)
				SetActive(arg_286_1.iconTrs_.gameObject, false)
				arg_286_1.callingController_:SetSelectedState("normal")

				local var_289_3 = arg_286_1:GetWordFromCfg(417261069)
				local var_289_4 = arg_286_1:FormatText(var_289_3.content)

				arg_286_1.text_.text = var_289_4

				LuaForUtil.ClearLinePrefixSymbol(arg_286_1.text_)

				local var_289_5 = 13
				local var_289_6 = utf8.len(var_289_4)
				local var_289_7 = var_289_5 <= 0 and var_289_1 or var_289_1 * (var_289_6 / var_289_5)

				if var_289_7 > 0 and var_289_1 < var_289_7 then
					arg_286_1.talkMaxDuration = var_289_7

					if var_289_7 + var_289_0 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_7 + var_289_0
					end
				end

				arg_286_1.text_.text = var_289_4
				arg_286_1.typewritter.percent = 0

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417261", "417261069", "story_v_out_417261.awb") ~= 0 then
					local var_289_8 = manager.audio:GetVoiceLength("story_v_out_417261", "417261069", "story_v_out_417261.awb") / 1000

					if var_289_8 + var_289_0 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_8 + var_289_0
					end

					if var_289_3.prefab_name ~= "" and arg_286_1.actors_[var_289_3.prefab_name] ~= nil then
						local var_289_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_286_1.actors_[var_289_3.prefab_name].transform, "story_v_out_417261", "417261069", "story_v_out_417261.awb")

						arg_286_1:RecordAudio("417261069", var_289_9)
						arg_286_1:RecordAudio("417261069", var_289_9)
					else
						arg_286_1:AudioAction("play", "voice", "story_v_out_417261", "417261069", "story_v_out_417261.awb")
					end

					arg_286_1:RecordHistoryTalkVoice("story_v_out_417261", "417261069", "story_v_out_417261.awb")
				end

				arg_286_1:RecordContent(arg_286_1.text_.text)
			end

			local var_289_10 = math.max(var_289_1, arg_286_1.talkMaxDuration)

			if var_289_0 <= arg_286_1.time_ and arg_286_1.time_ < var_289_0 + var_289_10 then
				arg_286_1.typewritter.percent = (arg_286_1.time_ - var_289_0) / var_289_10

				arg_286_1.typewritter:SetDirty()
			end

			if arg_286_1.time_ >= var_289_0 + var_289_10 and arg_286_1.time_ < var_289_0 + var_289_10 + arg_289_0 then
				arg_286_1.typewritter.percent = 1

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(true)
			end
		end

		arg_286_1.nodeConfigList_ = {}

		arg_286_1:InitPlayNodeList()
	end,
	Play417261070 = function(arg_290_0, arg_290_1)
		arg_290_1.time_ = 0
		arg_290_1.frameCnt_ = 0
		arg_290_1.state_ = "playing"
		arg_290_1.curTalkId_ = 417261070
		arg_290_1.duration_ = 2.93

		local var_290_0 = {
			zh = 2.9,
			ja = 2.933
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
				arg_290_0:Play417261071(arg_290_1)
			end
		end

		function arg_290_1.onSingleLineUpdate_(arg_293_0)
			local var_293_0 = arg_290_1.actors_["1034"]
			local var_293_1 = 0

			if var_293_1 < arg_290_1.time_ and arg_290_1.time_ <= var_293_1 + arg_293_0 and not isNil(var_293_0) and arg_290_1.var_.actorSpriteComps1034 == nil then
				arg_290_1.var_.actorSpriteComps1034 = var_293_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_293_2 = 0.2

			if var_293_1 <= arg_290_1.time_ and arg_290_1.time_ < var_293_1 + var_293_2 and not isNil(var_293_0) then
				local var_293_3 = (arg_290_1.time_ - var_293_1) / var_293_2

				if arg_290_1.var_.actorSpriteComps1034 then
					for iter_293_0, iter_293_1 in pairs(arg_290_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_293_1 then
							if arg_290_1.isInRecall_ then
								local var_293_4 = Mathf.Lerp(iter_293_1.color.r, arg_290_1.hightColor2.r, var_293_3)
								local var_293_5 = Mathf.Lerp(iter_293_1.color.g, arg_290_1.hightColor2.g, var_293_3)
								local var_293_6 = Mathf.Lerp(iter_293_1.color.b, arg_290_1.hightColor2.b, var_293_3)

								iter_293_1.color = Color.New(var_293_4, var_293_5, var_293_6)
							else
								local var_293_7 = Mathf.Lerp(iter_293_1.color.r, 0.5, var_293_3)

								iter_293_1.color = Color.New(var_293_7, var_293_7, var_293_7)
							end
						end
					end
				end
			end

			if arg_290_1.time_ >= var_293_1 + var_293_2 and arg_290_1.time_ < var_293_1 + var_293_2 + arg_293_0 and not isNil(var_293_0) and arg_290_1.var_.actorSpriteComps1034 then
				for iter_293_2, iter_293_3 in pairs(arg_290_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_293_3 then
						if arg_290_1.isInRecall_ then
							iter_293_3.color = arg_290_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_293_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_290_1.var_.actorSpriteComps1034 = nil
			end

			local var_293_8 = arg_290_1.actors_["10128"]
			local var_293_9 = 0

			if var_293_9 < arg_290_1.time_ and arg_290_1.time_ <= var_293_9 + arg_293_0 and not isNil(var_293_8) and arg_290_1.var_.actorSpriteComps10128 == nil then
				arg_290_1.var_.actorSpriteComps10128 = var_293_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_293_10 = 0.2

			if var_293_9 <= arg_290_1.time_ and arg_290_1.time_ < var_293_9 + var_293_10 and not isNil(var_293_8) then
				local var_293_11 = (arg_290_1.time_ - var_293_9) / var_293_10

				if arg_290_1.var_.actorSpriteComps10128 then
					for iter_293_4, iter_293_5 in pairs(arg_290_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_293_5 then
							if arg_290_1.isInRecall_ then
								local var_293_12 = Mathf.Lerp(iter_293_5.color.r, arg_290_1.hightColor1.r, var_293_11)
								local var_293_13 = Mathf.Lerp(iter_293_5.color.g, arg_290_1.hightColor1.g, var_293_11)
								local var_293_14 = Mathf.Lerp(iter_293_5.color.b, arg_290_1.hightColor1.b, var_293_11)

								iter_293_5.color = Color.New(var_293_12, var_293_13, var_293_14)
							else
								local var_293_15 = Mathf.Lerp(iter_293_5.color.r, 1, var_293_11)

								iter_293_5.color = Color.New(var_293_15, var_293_15, var_293_15)
							end
						end
					end
				end
			end

			if arg_290_1.time_ >= var_293_9 + var_293_10 and arg_290_1.time_ < var_293_9 + var_293_10 + arg_293_0 and not isNil(var_293_8) and arg_290_1.var_.actorSpriteComps10128 then
				for iter_293_6, iter_293_7 in pairs(arg_290_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_293_7 then
						if arg_290_1.isInRecall_ then
							iter_293_7.color = arg_290_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_293_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_290_1.var_.actorSpriteComps10128 = nil
			end

			local var_293_16 = 0
			local var_293_17 = 0.425

			if var_293_16 < arg_290_1.time_ and arg_290_1.time_ <= var_293_16 + arg_293_0 then
				arg_290_1.talkMaxDuration = 0
				arg_290_1.dialogCg_.alpha = 1

				arg_290_1.dialog_:SetActive(true)
				SetActive(arg_290_1.leftNameGo_, true)

				local var_293_18 = arg_290_1:FormatText(StoryNameCfg[595].name)

				arg_290_1.leftNameTxt_.text = var_293_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_290_1.leftNameTxt_.transform)

				arg_290_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_290_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_290_1:RecordName(arg_290_1.leftNameTxt_.text)
				SetActive(arg_290_1.iconTrs_.gameObject, false)
				arg_290_1.callingController_:SetSelectedState("normal")

				local var_293_19 = arg_290_1:GetWordFromCfg(417261070)
				local var_293_20 = arg_290_1:FormatText(var_293_19.content)

				arg_290_1.text_.text = var_293_20

				LuaForUtil.ClearLinePrefixSymbol(arg_290_1.text_)

				local var_293_21 = 17
				local var_293_22 = utf8.len(var_293_20)
				local var_293_23 = var_293_21 <= 0 and var_293_17 or var_293_17 * (var_293_22 / var_293_21)

				if var_293_23 > 0 and var_293_17 < var_293_23 then
					arg_290_1.talkMaxDuration = var_293_23

					if var_293_23 + var_293_16 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_23 + var_293_16
					end
				end

				arg_290_1.text_.text = var_293_20
				arg_290_1.typewritter.percent = 0

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417261", "417261070", "story_v_out_417261.awb") ~= 0 then
					local var_293_24 = manager.audio:GetVoiceLength("story_v_out_417261", "417261070", "story_v_out_417261.awb") / 1000

					if var_293_24 + var_293_16 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_24 + var_293_16
					end

					if var_293_19.prefab_name ~= "" and arg_290_1.actors_[var_293_19.prefab_name] ~= nil then
						local var_293_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_290_1.actors_[var_293_19.prefab_name].transform, "story_v_out_417261", "417261070", "story_v_out_417261.awb")

						arg_290_1:RecordAudio("417261070", var_293_25)
						arg_290_1:RecordAudio("417261070", var_293_25)
					else
						arg_290_1:AudioAction("play", "voice", "story_v_out_417261", "417261070", "story_v_out_417261.awb")
					end

					arg_290_1:RecordHistoryTalkVoice("story_v_out_417261", "417261070", "story_v_out_417261.awb")
				end

				arg_290_1:RecordContent(arg_290_1.text_.text)
			end

			local var_293_26 = math.max(var_293_17, arg_290_1.talkMaxDuration)

			if var_293_16 <= arg_290_1.time_ and arg_290_1.time_ < var_293_16 + var_293_26 then
				arg_290_1.typewritter.percent = (arg_290_1.time_ - var_293_16) / var_293_26

				arg_290_1.typewritter:SetDirty()
			end

			if arg_290_1.time_ >= var_293_16 + var_293_26 and arg_290_1.time_ < var_293_16 + var_293_26 + arg_293_0 then
				arg_290_1.typewritter.percent = 1

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(true)
			end
		end

		arg_290_1.nodeConfigList_ = {}

		arg_290_1:InitPlayNodeList()
	end,
	Play417261071 = function(arg_294_0, arg_294_1)
		arg_294_1.time_ = 0
		arg_294_1.frameCnt_ = 0
		arg_294_1.state_ = "playing"
		arg_294_1.curTalkId_ = 417261071
		arg_294_1.duration_ = 4.53

		local var_294_0 = {
			zh = 3.766,
			ja = 4.533
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
				arg_294_0:Play417261072(arg_294_1)
			end
		end

		function arg_294_1.onSingleLineUpdate_(arg_297_0)
			local var_297_0 = 0
			local var_297_1 = 0.525

			if var_297_0 < arg_294_1.time_ and arg_294_1.time_ <= var_297_0 + arg_297_0 then
				arg_294_1.talkMaxDuration = 0
				arg_294_1.dialogCg_.alpha = 1

				arg_294_1.dialog_:SetActive(true)
				SetActive(arg_294_1.leftNameGo_, true)

				local var_297_2 = arg_294_1:FormatText(StoryNameCfg[595].name)

				arg_294_1.leftNameTxt_.text = var_297_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_294_1.leftNameTxt_.transform)

				arg_294_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_294_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_294_1:RecordName(arg_294_1.leftNameTxt_.text)
				SetActive(arg_294_1.iconTrs_.gameObject, false)
				arg_294_1.callingController_:SetSelectedState("normal")

				local var_297_3 = arg_294_1:GetWordFromCfg(417261071)
				local var_297_4 = arg_294_1:FormatText(var_297_3.content)

				arg_294_1.text_.text = var_297_4

				LuaForUtil.ClearLinePrefixSymbol(arg_294_1.text_)

				local var_297_5 = 21
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

				if manager.audio:GetVoiceLength("story_v_out_417261", "417261071", "story_v_out_417261.awb") ~= 0 then
					local var_297_8 = manager.audio:GetVoiceLength("story_v_out_417261", "417261071", "story_v_out_417261.awb") / 1000

					if var_297_8 + var_297_0 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_8 + var_297_0
					end

					if var_297_3.prefab_name ~= "" and arg_294_1.actors_[var_297_3.prefab_name] ~= nil then
						local var_297_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_294_1.actors_[var_297_3.prefab_name].transform, "story_v_out_417261", "417261071", "story_v_out_417261.awb")

						arg_294_1:RecordAudio("417261071", var_297_9)
						arg_294_1:RecordAudio("417261071", var_297_9)
					else
						arg_294_1:AudioAction("play", "voice", "story_v_out_417261", "417261071", "story_v_out_417261.awb")
					end

					arg_294_1:RecordHistoryTalkVoice("story_v_out_417261", "417261071", "story_v_out_417261.awb")
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
	Play417261072 = function(arg_298_0, arg_298_1)
		arg_298_1.time_ = 0
		arg_298_1.frameCnt_ = 0
		arg_298_1.state_ = "playing"
		arg_298_1.curTalkId_ = 417261072
		arg_298_1.duration_ = 5.3

		local var_298_0 = {
			zh = 3.4,
			ja = 5.3
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
				arg_298_0:Play417261073(arg_298_1)
			end
		end

		function arg_298_1.onSingleLineUpdate_(arg_301_0)
			local var_301_0 = arg_298_1.actors_["1034"]
			local var_301_1 = 0

			if var_301_1 < arg_298_1.time_ and arg_298_1.time_ <= var_301_1 + arg_301_0 and not isNil(var_301_0) and arg_298_1.var_.actorSpriteComps1034 == nil then
				arg_298_1.var_.actorSpriteComps1034 = var_301_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_301_2 = 0.2

			if var_301_1 <= arg_298_1.time_ and arg_298_1.time_ < var_301_1 + var_301_2 and not isNil(var_301_0) then
				local var_301_3 = (arg_298_1.time_ - var_301_1) / var_301_2

				if arg_298_1.var_.actorSpriteComps1034 then
					for iter_301_0, iter_301_1 in pairs(arg_298_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_301_1 then
							if arg_298_1.isInRecall_ then
								local var_301_4 = Mathf.Lerp(iter_301_1.color.r, arg_298_1.hightColor1.r, var_301_3)
								local var_301_5 = Mathf.Lerp(iter_301_1.color.g, arg_298_1.hightColor1.g, var_301_3)
								local var_301_6 = Mathf.Lerp(iter_301_1.color.b, arg_298_1.hightColor1.b, var_301_3)

								iter_301_1.color = Color.New(var_301_4, var_301_5, var_301_6)
							else
								local var_301_7 = Mathf.Lerp(iter_301_1.color.r, 1, var_301_3)

								iter_301_1.color = Color.New(var_301_7, var_301_7, var_301_7)
							end
						end
					end
				end
			end

			if arg_298_1.time_ >= var_301_1 + var_301_2 and arg_298_1.time_ < var_301_1 + var_301_2 + arg_301_0 and not isNil(var_301_0) and arg_298_1.var_.actorSpriteComps1034 then
				for iter_301_2, iter_301_3 in pairs(arg_298_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_301_3 then
						if arg_298_1.isInRecall_ then
							iter_301_3.color = arg_298_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_301_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_298_1.var_.actorSpriteComps1034 = nil
			end

			local var_301_8 = arg_298_1.actors_["10128"]
			local var_301_9 = 0

			if var_301_9 < arg_298_1.time_ and arg_298_1.time_ <= var_301_9 + arg_301_0 and not isNil(var_301_8) and arg_298_1.var_.actorSpriteComps10128 == nil then
				arg_298_1.var_.actorSpriteComps10128 = var_301_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_301_10 = 0.2

			if var_301_9 <= arg_298_1.time_ and arg_298_1.time_ < var_301_9 + var_301_10 and not isNil(var_301_8) then
				local var_301_11 = (arg_298_1.time_ - var_301_9) / var_301_10

				if arg_298_1.var_.actorSpriteComps10128 then
					for iter_301_4, iter_301_5 in pairs(arg_298_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_301_5 then
							if arg_298_1.isInRecall_ then
								local var_301_12 = Mathf.Lerp(iter_301_5.color.r, arg_298_1.hightColor2.r, var_301_11)
								local var_301_13 = Mathf.Lerp(iter_301_5.color.g, arg_298_1.hightColor2.g, var_301_11)
								local var_301_14 = Mathf.Lerp(iter_301_5.color.b, arg_298_1.hightColor2.b, var_301_11)

								iter_301_5.color = Color.New(var_301_12, var_301_13, var_301_14)
							else
								local var_301_15 = Mathf.Lerp(iter_301_5.color.r, 0.5, var_301_11)

								iter_301_5.color = Color.New(var_301_15, var_301_15, var_301_15)
							end
						end
					end
				end
			end

			if arg_298_1.time_ >= var_301_9 + var_301_10 and arg_298_1.time_ < var_301_9 + var_301_10 + arg_301_0 and not isNil(var_301_8) and arg_298_1.var_.actorSpriteComps10128 then
				for iter_301_6, iter_301_7 in pairs(arg_298_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_301_7 then
						if arg_298_1.isInRecall_ then
							iter_301_7.color = arg_298_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_301_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_298_1.var_.actorSpriteComps10128 = nil
			end

			local var_301_16 = arg_298_1.actors_["1034"].transform
			local var_301_17 = 0

			if var_301_17 < arg_298_1.time_ and arg_298_1.time_ <= var_301_17 + arg_301_0 then
				arg_298_1.var_.moveOldPos1034 = var_301_16.localPosition
				var_301_16.localScale = Vector3.New(1, 1, 1)

				arg_298_1:CheckSpriteTmpPos("1034", 2)

				local var_301_18 = var_301_16.childCount

				for iter_301_8 = 0, var_301_18 - 1 do
					local var_301_19 = var_301_16:GetChild(iter_301_8)

					if var_301_19.name == "split_5" or not string.find(var_301_19.name, "split") then
						var_301_19.gameObject:SetActive(true)
					else
						var_301_19.gameObject:SetActive(false)
					end
				end
			end

			local var_301_20 = 0.001

			if var_301_17 <= arg_298_1.time_ and arg_298_1.time_ < var_301_17 + var_301_20 then
				local var_301_21 = (arg_298_1.time_ - var_301_17) / var_301_20
				local var_301_22 = Vector3.New(-390, -331.9, -324)

				var_301_16.localPosition = Vector3.Lerp(arg_298_1.var_.moveOldPos1034, var_301_22, var_301_21)
			end

			if arg_298_1.time_ >= var_301_17 + var_301_20 and arg_298_1.time_ < var_301_17 + var_301_20 + arg_301_0 then
				var_301_16.localPosition = Vector3.New(-390, -331.9, -324)
			end

			local var_301_23 = 0
			local var_301_24 = 0.325

			if var_301_23 < arg_298_1.time_ and arg_298_1.time_ <= var_301_23 + arg_301_0 then
				arg_298_1.talkMaxDuration = 0
				arg_298_1.dialogCg_.alpha = 1

				arg_298_1.dialog_:SetActive(true)
				SetActive(arg_298_1.leftNameGo_, true)

				local var_301_25 = arg_298_1:FormatText(StoryNameCfg[1109].name)

				arg_298_1.leftNameTxt_.text = var_301_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_298_1.leftNameTxt_.transform)

				arg_298_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_298_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_298_1:RecordName(arg_298_1.leftNameTxt_.text)
				SetActive(arg_298_1.iconTrs_.gameObject, false)
				arg_298_1.callingController_:SetSelectedState("normal")

				local var_301_26 = arg_298_1:GetWordFromCfg(417261072)
				local var_301_27 = arg_298_1:FormatText(var_301_26.content)

				arg_298_1.text_.text = var_301_27

				LuaForUtil.ClearLinePrefixSymbol(arg_298_1.text_)

				local var_301_28 = 13
				local var_301_29 = utf8.len(var_301_27)
				local var_301_30 = var_301_28 <= 0 and var_301_24 or var_301_24 * (var_301_29 / var_301_28)

				if var_301_30 > 0 and var_301_24 < var_301_30 then
					arg_298_1.talkMaxDuration = var_301_30

					if var_301_30 + var_301_23 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_30 + var_301_23
					end
				end

				arg_298_1.text_.text = var_301_27
				arg_298_1.typewritter.percent = 0

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417261", "417261072", "story_v_out_417261.awb") ~= 0 then
					local var_301_31 = manager.audio:GetVoiceLength("story_v_out_417261", "417261072", "story_v_out_417261.awb") / 1000

					if var_301_31 + var_301_23 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_31 + var_301_23
					end

					if var_301_26.prefab_name ~= "" and arg_298_1.actors_[var_301_26.prefab_name] ~= nil then
						local var_301_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_298_1.actors_[var_301_26.prefab_name].transform, "story_v_out_417261", "417261072", "story_v_out_417261.awb")

						arg_298_1:RecordAudio("417261072", var_301_32)
						arg_298_1:RecordAudio("417261072", var_301_32)
					else
						arg_298_1:AudioAction("play", "voice", "story_v_out_417261", "417261072", "story_v_out_417261.awb")
					end

					arg_298_1:RecordHistoryTalkVoice("story_v_out_417261", "417261072", "story_v_out_417261.awb")
				end

				arg_298_1:RecordContent(arg_298_1.text_.text)
			end

			local var_301_33 = math.max(var_301_24, arg_298_1.talkMaxDuration)

			if var_301_23 <= arg_298_1.time_ and arg_298_1.time_ < var_301_23 + var_301_33 then
				arg_298_1.typewritter.percent = (arg_298_1.time_ - var_301_23) / var_301_33

				arg_298_1.typewritter:SetDirty()
			end

			if arg_298_1.time_ >= var_301_23 + var_301_33 and arg_298_1.time_ < var_301_23 + var_301_33 + arg_301_0 then
				arg_298_1.typewritter.percent = 1

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(true)
			end
		end

		arg_298_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_298_1:InitPlayNodeList()
	end,
	Play417261073 = function(arg_302_0, arg_302_1)
		arg_302_1.time_ = 0
		arg_302_1.frameCnt_ = 0
		arg_302_1.state_ = "playing"
		arg_302_1.curTalkId_ = 417261073
		arg_302_1.duration_ = 1.93

		local var_302_0 = {
			zh = 1.633,
			ja = 1.933
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
				arg_302_0:Play417261074(arg_302_1)
			end
		end

		function arg_302_1.onSingleLineUpdate_(arg_305_0)
			local var_305_0 = arg_302_1.actors_["1034"]
			local var_305_1 = 0

			if var_305_1 < arg_302_1.time_ and arg_302_1.time_ <= var_305_1 + arg_305_0 and not isNil(var_305_0) and arg_302_1.var_.actorSpriteComps1034 == nil then
				arg_302_1.var_.actorSpriteComps1034 = var_305_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_305_2 = 0.2

			if var_305_1 <= arg_302_1.time_ and arg_302_1.time_ < var_305_1 + var_305_2 and not isNil(var_305_0) then
				local var_305_3 = (arg_302_1.time_ - var_305_1) / var_305_2

				if arg_302_1.var_.actorSpriteComps1034 then
					for iter_305_0, iter_305_1 in pairs(arg_302_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_305_1 then
							if arg_302_1.isInRecall_ then
								local var_305_4 = Mathf.Lerp(iter_305_1.color.r, arg_302_1.hightColor2.r, var_305_3)
								local var_305_5 = Mathf.Lerp(iter_305_1.color.g, arg_302_1.hightColor2.g, var_305_3)
								local var_305_6 = Mathf.Lerp(iter_305_1.color.b, arg_302_1.hightColor2.b, var_305_3)

								iter_305_1.color = Color.New(var_305_4, var_305_5, var_305_6)
							else
								local var_305_7 = Mathf.Lerp(iter_305_1.color.r, 0.5, var_305_3)

								iter_305_1.color = Color.New(var_305_7, var_305_7, var_305_7)
							end
						end
					end
				end
			end

			if arg_302_1.time_ >= var_305_1 + var_305_2 and arg_302_1.time_ < var_305_1 + var_305_2 + arg_305_0 and not isNil(var_305_0) and arg_302_1.var_.actorSpriteComps1034 then
				for iter_305_2, iter_305_3 in pairs(arg_302_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_305_3 then
						if arg_302_1.isInRecall_ then
							iter_305_3.color = arg_302_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_305_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_302_1.var_.actorSpriteComps1034 = nil
			end

			local var_305_8 = arg_302_1.actors_["10128"]
			local var_305_9 = 0

			if var_305_9 < arg_302_1.time_ and arg_302_1.time_ <= var_305_9 + arg_305_0 and not isNil(var_305_8) and arg_302_1.var_.actorSpriteComps10128 == nil then
				arg_302_1.var_.actorSpriteComps10128 = var_305_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_305_10 = 0.2

			if var_305_9 <= arg_302_1.time_ and arg_302_1.time_ < var_305_9 + var_305_10 and not isNil(var_305_8) then
				local var_305_11 = (arg_302_1.time_ - var_305_9) / var_305_10

				if arg_302_1.var_.actorSpriteComps10128 then
					for iter_305_4, iter_305_5 in pairs(arg_302_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_305_5 then
							if arg_302_1.isInRecall_ then
								local var_305_12 = Mathf.Lerp(iter_305_5.color.r, arg_302_1.hightColor1.r, var_305_11)
								local var_305_13 = Mathf.Lerp(iter_305_5.color.g, arg_302_1.hightColor1.g, var_305_11)
								local var_305_14 = Mathf.Lerp(iter_305_5.color.b, arg_302_1.hightColor1.b, var_305_11)

								iter_305_5.color = Color.New(var_305_12, var_305_13, var_305_14)
							else
								local var_305_15 = Mathf.Lerp(iter_305_5.color.r, 1, var_305_11)

								iter_305_5.color = Color.New(var_305_15, var_305_15, var_305_15)
							end
						end
					end
				end
			end

			if arg_302_1.time_ >= var_305_9 + var_305_10 and arg_302_1.time_ < var_305_9 + var_305_10 + arg_305_0 and not isNil(var_305_8) and arg_302_1.var_.actorSpriteComps10128 then
				for iter_305_6, iter_305_7 in pairs(arg_302_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_305_7 then
						if arg_302_1.isInRecall_ then
							iter_305_7.color = arg_302_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_305_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_302_1.var_.actorSpriteComps10128 = nil
			end

			local var_305_16 = 0
			local var_305_17 = 0.175

			if var_305_16 < arg_302_1.time_ and arg_302_1.time_ <= var_305_16 + arg_305_0 then
				arg_302_1.talkMaxDuration = 0
				arg_302_1.dialogCg_.alpha = 1

				arg_302_1.dialog_:SetActive(true)
				SetActive(arg_302_1.leftNameGo_, true)

				local var_305_18 = arg_302_1:FormatText(StoryNameCfg[595].name)

				arg_302_1.leftNameTxt_.text = var_305_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_302_1.leftNameTxt_.transform)

				arg_302_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_302_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_302_1:RecordName(arg_302_1.leftNameTxt_.text)
				SetActive(arg_302_1.iconTrs_.gameObject, false)
				arg_302_1.callingController_:SetSelectedState("normal")

				local var_305_19 = arg_302_1:GetWordFromCfg(417261073)
				local var_305_20 = arg_302_1:FormatText(var_305_19.content)

				arg_302_1.text_.text = var_305_20

				LuaForUtil.ClearLinePrefixSymbol(arg_302_1.text_)

				local var_305_21 = 7
				local var_305_22 = utf8.len(var_305_20)
				local var_305_23 = var_305_21 <= 0 and var_305_17 or var_305_17 * (var_305_22 / var_305_21)

				if var_305_23 > 0 and var_305_17 < var_305_23 then
					arg_302_1.talkMaxDuration = var_305_23

					if var_305_23 + var_305_16 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_23 + var_305_16
					end
				end

				arg_302_1.text_.text = var_305_20
				arg_302_1.typewritter.percent = 0

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417261", "417261073", "story_v_out_417261.awb") ~= 0 then
					local var_305_24 = manager.audio:GetVoiceLength("story_v_out_417261", "417261073", "story_v_out_417261.awb") / 1000

					if var_305_24 + var_305_16 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_24 + var_305_16
					end

					if var_305_19.prefab_name ~= "" and arg_302_1.actors_[var_305_19.prefab_name] ~= nil then
						local var_305_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_302_1.actors_[var_305_19.prefab_name].transform, "story_v_out_417261", "417261073", "story_v_out_417261.awb")

						arg_302_1:RecordAudio("417261073", var_305_25)
						arg_302_1:RecordAudio("417261073", var_305_25)
					else
						arg_302_1:AudioAction("play", "voice", "story_v_out_417261", "417261073", "story_v_out_417261.awb")
					end

					arg_302_1:RecordHistoryTalkVoice("story_v_out_417261", "417261073", "story_v_out_417261.awb")
				end

				arg_302_1:RecordContent(arg_302_1.text_.text)
			end

			local var_305_26 = math.max(var_305_17, arg_302_1.talkMaxDuration)

			if var_305_16 <= arg_302_1.time_ and arg_302_1.time_ < var_305_16 + var_305_26 then
				arg_302_1.typewritter.percent = (arg_302_1.time_ - var_305_16) / var_305_26

				arg_302_1.typewritter:SetDirty()
			end

			if arg_302_1.time_ >= var_305_16 + var_305_26 and arg_302_1.time_ < var_305_16 + var_305_26 + arg_305_0 then
				arg_302_1.typewritter.percent = 1

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(true)
			end
		end

		arg_302_1.nodeConfigList_ = {}

		arg_302_1:InitPlayNodeList()
	end,
	Play417261074 = function(arg_306_0, arg_306_1)
		arg_306_1.time_ = 0
		arg_306_1.frameCnt_ = 0
		arg_306_1.state_ = "playing"
		arg_306_1.curTalkId_ = 417261074
		arg_306_1.duration_ = 5.5

		local var_306_0 = {
			zh = 4.6,
			ja = 5.5
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
				arg_306_0:Play417261075(arg_306_1)
			end
		end

		function arg_306_1.onSingleLineUpdate_(arg_309_0)
			local var_309_0 = arg_306_1.actors_["1034"]
			local var_309_1 = 0

			if var_309_1 < arg_306_1.time_ and arg_306_1.time_ <= var_309_1 + arg_309_0 and not isNil(var_309_0) and arg_306_1.var_.actorSpriteComps1034 == nil then
				arg_306_1.var_.actorSpriteComps1034 = var_309_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_309_2 = 0.2

			if var_309_1 <= arg_306_1.time_ and arg_306_1.time_ < var_309_1 + var_309_2 and not isNil(var_309_0) then
				local var_309_3 = (arg_306_1.time_ - var_309_1) / var_309_2

				if arg_306_1.var_.actorSpriteComps1034 then
					for iter_309_0, iter_309_1 in pairs(arg_306_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_309_1 then
							if arg_306_1.isInRecall_ then
								local var_309_4 = Mathf.Lerp(iter_309_1.color.r, arg_306_1.hightColor1.r, var_309_3)
								local var_309_5 = Mathf.Lerp(iter_309_1.color.g, arg_306_1.hightColor1.g, var_309_3)
								local var_309_6 = Mathf.Lerp(iter_309_1.color.b, arg_306_1.hightColor1.b, var_309_3)

								iter_309_1.color = Color.New(var_309_4, var_309_5, var_309_6)
							else
								local var_309_7 = Mathf.Lerp(iter_309_1.color.r, 1, var_309_3)

								iter_309_1.color = Color.New(var_309_7, var_309_7, var_309_7)
							end
						end
					end
				end
			end

			if arg_306_1.time_ >= var_309_1 + var_309_2 and arg_306_1.time_ < var_309_1 + var_309_2 + arg_309_0 and not isNil(var_309_0) and arg_306_1.var_.actorSpriteComps1034 then
				for iter_309_2, iter_309_3 in pairs(arg_306_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_309_3 then
						if arg_306_1.isInRecall_ then
							iter_309_3.color = arg_306_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_309_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_306_1.var_.actorSpriteComps1034 = nil
			end

			local var_309_8 = arg_306_1.actors_["10128"]
			local var_309_9 = 0

			if var_309_9 < arg_306_1.time_ and arg_306_1.time_ <= var_309_9 + arg_309_0 and not isNil(var_309_8) and arg_306_1.var_.actorSpriteComps10128 == nil then
				arg_306_1.var_.actorSpriteComps10128 = var_309_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_309_10 = 0.2

			if var_309_9 <= arg_306_1.time_ and arg_306_1.time_ < var_309_9 + var_309_10 and not isNil(var_309_8) then
				local var_309_11 = (arg_306_1.time_ - var_309_9) / var_309_10

				if arg_306_1.var_.actorSpriteComps10128 then
					for iter_309_4, iter_309_5 in pairs(arg_306_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_309_5 then
							if arg_306_1.isInRecall_ then
								local var_309_12 = Mathf.Lerp(iter_309_5.color.r, arg_306_1.hightColor2.r, var_309_11)
								local var_309_13 = Mathf.Lerp(iter_309_5.color.g, arg_306_1.hightColor2.g, var_309_11)
								local var_309_14 = Mathf.Lerp(iter_309_5.color.b, arg_306_1.hightColor2.b, var_309_11)

								iter_309_5.color = Color.New(var_309_12, var_309_13, var_309_14)
							else
								local var_309_15 = Mathf.Lerp(iter_309_5.color.r, 0.5, var_309_11)

								iter_309_5.color = Color.New(var_309_15, var_309_15, var_309_15)
							end
						end
					end
				end
			end

			if arg_306_1.time_ >= var_309_9 + var_309_10 and arg_306_1.time_ < var_309_9 + var_309_10 + arg_309_0 and not isNil(var_309_8) and arg_306_1.var_.actorSpriteComps10128 then
				for iter_309_6, iter_309_7 in pairs(arg_306_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_309_7 then
						if arg_306_1.isInRecall_ then
							iter_309_7.color = arg_306_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_309_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_306_1.var_.actorSpriteComps10128 = nil
			end

			local var_309_16 = arg_306_1.actors_["1034"].transform
			local var_309_17 = 0

			if var_309_17 < arg_306_1.time_ and arg_306_1.time_ <= var_309_17 + arg_309_0 then
				arg_306_1.var_.moveOldPos1034 = var_309_16.localPosition
				var_309_16.localScale = Vector3.New(1, 1, 1)

				arg_306_1:CheckSpriteTmpPos("1034", 2)

				local var_309_18 = var_309_16.childCount

				for iter_309_8 = 0, var_309_18 - 1 do
					local var_309_19 = var_309_16:GetChild(iter_309_8)

					if var_309_19.name == "split_6" or not string.find(var_309_19.name, "split") then
						var_309_19.gameObject:SetActive(true)
					else
						var_309_19.gameObject:SetActive(false)
					end
				end
			end

			local var_309_20 = 0.001

			if var_309_17 <= arg_306_1.time_ and arg_306_1.time_ < var_309_17 + var_309_20 then
				local var_309_21 = (arg_306_1.time_ - var_309_17) / var_309_20
				local var_309_22 = Vector3.New(-390, -331.9, -324)

				var_309_16.localPosition = Vector3.Lerp(arg_306_1.var_.moveOldPos1034, var_309_22, var_309_21)
			end

			if arg_306_1.time_ >= var_309_17 + var_309_20 and arg_306_1.time_ < var_309_17 + var_309_20 + arg_309_0 then
				var_309_16.localPosition = Vector3.New(-390, -331.9, -324)
			end

			local var_309_23 = 0
			local var_309_24 = 0.5

			if var_309_23 < arg_306_1.time_ and arg_306_1.time_ <= var_309_23 + arg_309_0 then
				arg_306_1.talkMaxDuration = 0
				arg_306_1.dialogCg_.alpha = 1

				arg_306_1.dialog_:SetActive(true)
				SetActive(arg_306_1.leftNameGo_, true)

				local var_309_25 = arg_306_1:FormatText(StoryNameCfg[1109].name)

				arg_306_1.leftNameTxt_.text = var_309_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_306_1.leftNameTxt_.transform)

				arg_306_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_306_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_306_1:RecordName(arg_306_1.leftNameTxt_.text)
				SetActive(arg_306_1.iconTrs_.gameObject, false)
				arg_306_1.callingController_:SetSelectedState("normal")

				local var_309_26 = arg_306_1:GetWordFromCfg(417261074)
				local var_309_27 = arg_306_1:FormatText(var_309_26.content)

				arg_306_1.text_.text = var_309_27

				LuaForUtil.ClearLinePrefixSymbol(arg_306_1.text_)

				local var_309_28 = 20
				local var_309_29 = utf8.len(var_309_27)
				local var_309_30 = var_309_28 <= 0 and var_309_24 or var_309_24 * (var_309_29 / var_309_28)

				if var_309_30 > 0 and var_309_24 < var_309_30 then
					arg_306_1.talkMaxDuration = var_309_30

					if var_309_30 + var_309_23 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_30 + var_309_23
					end
				end

				arg_306_1.text_.text = var_309_27
				arg_306_1.typewritter.percent = 0

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417261", "417261074", "story_v_out_417261.awb") ~= 0 then
					local var_309_31 = manager.audio:GetVoiceLength("story_v_out_417261", "417261074", "story_v_out_417261.awb") / 1000

					if var_309_31 + var_309_23 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_31 + var_309_23
					end

					if var_309_26.prefab_name ~= "" and arg_306_1.actors_[var_309_26.prefab_name] ~= nil then
						local var_309_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_306_1.actors_[var_309_26.prefab_name].transform, "story_v_out_417261", "417261074", "story_v_out_417261.awb")

						arg_306_1:RecordAudio("417261074", var_309_32)
						arg_306_1:RecordAudio("417261074", var_309_32)
					else
						arg_306_1:AudioAction("play", "voice", "story_v_out_417261", "417261074", "story_v_out_417261.awb")
					end

					arg_306_1:RecordHistoryTalkVoice("story_v_out_417261", "417261074", "story_v_out_417261.awb")
				end

				arg_306_1:RecordContent(arg_306_1.text_.text)
			end

			local var_309_33 = math.max(var_309_24, arg_306_1.talkMaxDuration)

			if var_309_23 <= arg_306_1.time_ and arg_306_1.time_ < var_309_23 + var_309_33 then
				arg_306_1.typewritter.percent = (arg_306_1.time_ - var_309_23) / var_309_33

				arg_306_1.typewritter:SetDirty()
			end

			if arg_306_1.time_ >= var_309_23 + var_309_33 and arg_306_1.time_ < var_309_23 + var_309_33 + arg_309_0 then
				arg_306_1.typewritter.percent = 1

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(true)
			end
		end

		arg_306_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_306_1:InitPlayNodeList()
	end,
	Play417261075 = function(arg_310_0, arg_310_1)
		arg_310_1.time_ = 0
		arg_310_1.frameCnt_ = 0
		arg_310_1.state_ = "playing"
		arg_310_1.curTalkId_ = 417261075
		arg_310_1.duration_ = 2.3

		local var_310_0 = {
			zh = 2.1,
			ja = 2.3
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
				arg_310_0:Play417261076(arg_310_1)
			end
		end

		function arg_310_1.onSingleLineUpdate_(arg_313_0)
			local var_313_0 = arg_310_1.actors_["1034"]
			local var_313_1 = 0

			if var_313_1 < arg_310_1.time_ and arg_310_1.time_ <= var_313_1 + arg_313_0 and not isNil(var_313_0) and arg_310_1.var_.actorSpriteComps1034 == nil then
				arg_310_1.var_.actorSpriteComps1034 = var_313_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_313_2 = 0.2

			if var_313_1 <= arg_310_1.time_ and arg_310_1.time_ < var_313_1 + var_313_2 and not isNil(var_313_0) then
				local var_313_3 = (arg_310_1.time_ - var_313_1) / var_313_2

				if arg_310_1.var_.actorSpriteComps1034 then
					for iter_313_0, iter_313_1 in pairs(arg_310_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_313_1 then
							if arg_310_1.isInRecall_ then
								local var_313_4 = Mathf.Lerp(iter_313_1.color.r, arg_310_1.hightColor2.r, var_313_3)
								local var_313_5 = Mathf.Lerp(iter_313_1.color.g, arg_310_1.hightColor2.g, var_313_3)
								local var_313_6 = Mathf.Lerp(iter_313_1.color.b, arg_310_1.hightColor2.b, var_313_3)

								iter_313_1.color = Color.New(var_313_4, var_313_5, var_313_6)
							else
								local var_313_7 = Mathf.Lerp(iter_313_1.color.r, 0.5, var_313_3)

								iter_313_1.color = Color.New(var_313_7, var_313_7, var_313_7)
							end
						end
					end
				end
			end

			if arg_310_1.time_ >= var_313_1 + var_313_2 and arg_310_1.time_ < var_313_1 + var_313_2 + arg_313_0 and not isNil(var_313_0) and arg_310_1.var_.actorSpriteComps1034 then
				for iter_313_2, iter_313_3 in pairs(arg_310_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_313_3 then
						if arg_310_1.isInRecall_ then
							iter_313_3.color = arg_310_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_313_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_310_1.var_.actorSpriteComps1034 = nil
			end

			local var_313_8 = arg_310_1.actors_["10128"]
			local var_313_9 = 0

			if var_313_9 < arg_310_1.time_ and arg_310_1.time_ <= var_313_9 + arg_313_0 and not isNil(var_313_8) and arg_310_1.var_.actorSpriteComps10128 == nil then
				arg_310_1.var_.actorSpriteComps10128 = var_313_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_313_10 = 0.2

			if var_313_9 <= arg_310_1.time_ and arg_310_1.time_ < var_313_9 + var_313_10 and not isNil(var_313_8) then
				local var_313_11 = (arg_310_1.time_ - var_313_9) / var_313_10

				if arg_310_1.var_.actorSpriteComps10128 then
					for iter_313_4, iter_313_5 in pairs(arg_310_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_313_5 then
							if arg_310_1.isInRecall_ then
								local var_313_12 = Mathf.Lerp(iter_313_5.color.r, arg_310_1.hightColor1.r, var_313_11)
								local var_313_13 = Mathf.Lerp(iter_313_5.color.g, arg_310_1.hightColor1.g, var_313_11)
								local var_313_14 = Mathf.Lerp(iter_313_5.color.b, arg_310_1.hightColor1.b, var_313_11)

								iter_313_5.color = Color.New(var_313_12, var_313_13, var_313_14)
							else
								local var_313_15 = Mathf.Lerp(iter_313_5.color.r, 1, var_313_11)

								iter_313_5.color = Color.New(var_313_15, var_313_15, var_313_15)
							end
						end
					end
				end
			end

			if arg_310_1.time_ >= var_313_9 + var_313_10 and arg_310_1.time_ < var_313_9 + var_313_10 + arg_313_0 and not isNil(var_313_8) and arg_310_1.var_.actorSpriteComps10128 then
				for iter_313_6, iter_313_7 in pairs(arg_310_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_313_7 then
						if arg_310_1.isInRecall_ then
							iter_313_7.color = arg_310_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_313_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_310_1.var_.actorSpriteComps10128 = nil
			end

			local var_313_16 = 0
			local var_313_17 = 0.25

			if var_313_16 < arg_310_1.time_ and arg_310_1.time_ <= var_313_16 + arg_313_0 then
				arg_310_1.talkMaxDuration = 0
				arg_310_1.dialogCg_.alpha = 1

				arg_310_1.dialog_:SetActive(true)
				SetActive(arg_310_1.leftNameGo_, true)

				local var_313_18 = arg_310_1:FormatText(StoryNameCfg[595].name)

				arg_310_1.leftNameTxt_.text = var_313_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_310_1.leftNameTxt_.transform)

				arg_310_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_310_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_310_1:RecordName(arg_310_1.leftNameTxt_.text)
				SetActive(arg_310_1.iconTrs_.gameObject, false)
				arg_310_1.callingController_:SetSelectedState("normal")

				local var_313_19 = arg_310_1:GetWordFromCfg(417261075)
				local var_313_20 = arg_310_1:FormatText(var_313_19.content)

				arg_310_1.text_.text = var_313_20

				LuaForUtil.ClearLinePrefixSymbol(arg_310_1.text_)

				local var_313_21 = 10
				local var_313_22 = utf8.len(var_313_20)
				local var_313_23 = var_313_21 <= 0 and var_313_17 or var_313_17 * (var_313_22 / var_313_21)

				if var_313_23 > 0 and var_313_17 < var_313_23 then
					arg_310_1.talkMaxDuration = var_313_23

					if var_313_23 + var_313_16 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_23 + var_313_16
					end
				end

				arg_310_1.text_.text = var_313_20
				arg_310_1.typewritter.percent = 0

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417261", "417261075", "story_v_out_417261.awb") ~= 0 then
					local var_313_24 = manager.audio:GetVoiceLength("story_v_out_417261", "417261075", "story_v_out_417261.awb") / 1000

					if var_313_24 + var_313_16 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_24 + var_313_16
					end

					if var_313_19.prefab_name ~= "" and arg_310_1.actors_[var_313_19.prefab_name] ~= nil then
						local var_313_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_310_1.actors_[var_313_19.prefab_name].transform, "story_v_out_417261", "417261075", "story_v_out_417261.awb")

						arg_310_1:RecordAudio("417261075", var_313_25)
						arg_310_1:RecordAudio("417261075", var_313_25)
					else
						arg_310_1:AudioAction("play", "voice", "story_v_out_417261", "417261075", "story_v_out_417261.awb")
					end

					arg_310_1:RecordHistoryTalkVoice("story_v_out_417261", "417261075", "story_v_out_417261.awb")
				end

				arg_310_1:RecordContent(arg_310_1.text_.text)
			end

			local var_313_26 = math.max(var_313_17, arg_310_1.talkMaxDuration)

			if var_313_16 <= arg_310_1.time_ and arg_310_1.time_ < var_313_16 + var_313_26 then
				arg_310_1.typewritter.percent = (arg_310_1.time_ - var_313_16) / var_313_26

				arg_310_1.typewritter:SetDirty()
			end

			if arg_310_1.time_ >= var_313_16 + var_313_26 and arg_310_1.time_ < var_313_16 + var_313_26 + arg_313_0 then
				arg_310_1.typewritter.percent = 1

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(true)
			end
		end

		arg_310_1.nodeConfigList_ = {}

		arg_310_1:InitPlayNodeList()
	end,
	Play417261076 = function(arg_314_0, arg_314_1)
		arg_314_1.time_ = 0
		arg_314_1.frameCnt_ = 0
		arg_314_1.state_ = "playing"
		arg_314_1.curTalkId_ = 417261076
		arg_314_1.duration_ = 5

		SetActive(arg_314_1.tipsGo_, false)

		function arg_314_1.onSingleLineFinish_()
			arg_314_1.onSingleLineUpdate_ = nil
			arg_314_1.onSingleLineFinish_ = nil
			arg_314_1.state_ = "waiting"
		end

		function arg_314_1.playNext_(arg_316_0)
			if arg_316_0 == 1 then
				arg_314_0:Play417261077(arg_314_1)
			end
		end

		function arg_314_1.onSingleLineUpdate_(arg_317_0)
			local var_317_0 = arg_314_1.actors_["1034"]
			local var_317_1 = 0

			if var_317_1 < arg_314_1.time_ and arg_314_1.time_ <= var_317_1 + arg_317_0 and not isNil(var_317_0) and arg_314_1.var_.actorSpriteComps1034 == nil then
				arg_314_1.var_.actorSpriteComps1034 = var_317_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_317_2 = 0.2

			if var_317_1 <= arg_314_1.time_ and arg_314_1.time_ < var_317_1 + var_317_2 and not isNil(var_317_0) then
				local var_317_3 = (arg_314_1.time_ - var_317_1) / var_317_2

				if arg_314_1.var_.actorSpriteComps1034 then
					for iter_317_0, iter_317_1 in pairs(arg_314_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_317_1 then
							if arg_314_1.isInRecall_ then
								local var_317_4 = Mathf.Lerp(iter_317_1.color.r, arg_314_1.hightColor2.r, var_317_3)
								local var_317_5 = Mathf.Lerp(iter_317_1.color.g, arg_314_1.hightColor2.g, var_317_3)
								local var_317_6 = Mathf.Lerp(iter_317_1.color.b, arg_314_1.hightColor2.b, var_317_3)

								iter_317_1.color = Color.New(var_317_4, var_317_5, var_317_6)
							else
								local var_317_7 = Mathf.Lerp(iter_317_1.color.r, 0.5, var_317_3)

								iter_317_1.color = Color.New(var_317_7, var_317_7, var_317_7)
							end
						end
					end
				end
			end

			if arg_314_1.time_ >= var_317_1 + var_317_2 and arg_314_1.time_ < var_317_1 + var_317_2 + arg_317_0 and not isNil(var_317_0) and arg_314_1.var_.actorSpriteComps1034 then
				for iter_317_2, iter_317_3 in pairs(arg_314_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_317_3 then
						if arg_314_1.isInRecall_ then
							iter_317_3.color = arg_314_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_317_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_314_1.var_.actorSpriteComps1034 = nil
			end

			local var_317_8 = arg_314_1.actors_["10128"]
			local var_317_9 = 0

			if var_317_9 < arg_314_1.time_ and arg_314_1.time_ <= var_317_9 + arg_317_0 and not isNil(var_317_8) and arg_314_1.var_.actorSpriteComps10128 == nil then
				arg_314_1.var_.actorSpriteComps10128 = var_317_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_317_10 = 0.2

			if var_317_9 <= arg_314_1.time_ and arg_314_1.time_ < var_317_9 + var_317_10 and not isNil(var_317_8) then
				local var_317_11 = (arg_314_1.time_ - var_317_9) / var_317_10

				if arg_314_1.var_.actorSpriteComps10128 then
					for iter_317_4, iter_317_5 in pairs(arg_314_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_317_5 then
							if arg_314_1.isInRecall_ then
								local var_317_12 = Mathf.Lerp(iter_317_5.color.r, arg_314_1.hightColor2.r, var_317_11)
								local var_317_13 = Mathf.Lerp(iter_317_5.color.g, arg_314_1.hightColor2.g, var_317_11)
								local var_317_14 = Mathf.Lerp(iter_317_5.color.b, arg_314_1.hightColor2.b, var_317_11)

								iter_317_5.color = Color.New(var_317_12, var_317_13, var_317_14)
							else
								local var_317_15 = Mathf.Lerp(iter_317_5.color.r, 0.5, var_317_11)

								iter_317_5.color = Color.New(var_317_15, var_317_15, var_317_15)
							end
						end
					end
				end
			end

			if arg_314_1.time_ >= var_317_9 + var_317_10 and arg_314_1.time_ < var_317_9 + var_317_10 + arg_317_0 and not isNil(var_317_8) and arg_314_1.var_.actorSpriteComps10128 then
				for iter_317_6, iter_317_7 in pairs(arg_314_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_317_7 then
						if arg_314_1.isInRecall_ then
							iter_317_7.color = arg_314_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_317_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_314_1.var_.actorSpriteComps10128 = nil
			end

			local var_317_16 = 0
			local var_317_17 = 1.45

			if var_317_16 < arg_314_1.time_ and arg_314_1.time_ <= var_317_16 + arg_317_0 then
				arg_314_1.talkMaxDuration = 0
				arg_314_1.dialogCg_.alpha = 1

				arg_314_1.dialog_:SetActive(true)
				SetActive(arg_314_1.leftNameGo_, false)

				arg_314_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_314_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_314_1:RecordName(arg_314_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_314_1.iconTrs_.gameObject, false)
				arg_314_1.callingController_:SetSelectedState("normal")

				local var_317_18 = arg_314_1:GetWordFromCfg(417261076)
				local var_317_19 = arg_314_1:FormatText(var_317_18.content)

				arg_314_1.text_.text = var_317_19

				LuaForUtil.ClearLinePrefixSymbol(arg_314_1.text_)

				local var_317_20 = 58
				local var_317_21 = utf8.len(var_317_19)
				local var_317_22 = var_317_20 <= 0 and var_317_17 or var_317_17 * (var_317_21 / var_317_20)

				if var_317_22 > 0 and var_317_17 < var_317_22 then
					arg_314_1.talkMaxDuration = var_317_22

					if var_317_22 + var_317_16 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_22 + var_317_16
					end
				end

				arg_314_1.text_.text = var_317_19
				arg_314_1.typewritter.percent = 0

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(false)
				arg_314_1:RecordContent(arg_314_1.text_.text)
			end

			local var_317_23 = math.max(var_317_17, arg_314_1.talkMaxDuration)

			if var_317_16 <= arg_314_1.time_ and arg_314_1.time_ < var_317_16 + var_317_23 then
				arg_314_1.typewritter.percent = (arg_314_1.time_ - var_317_16) / var_317_23

				arg_314_1.typewritter:SetDirty()
			end

			if arg_314_1.time_ >= var_317_16 + var_317_23 and arg_314_1.time_ < var_317_16 + var_317_23 + arg_317_0 then
				arg_314_1.typewritter.percent = 1

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(true)
			end
		end

		arg_314_1.nodeConfigList_ = {}

		arg_314_1:InitPlayNodeList()
	end,
	Play417261077 = function(arg_318_0, arg_318_1)
		arg_318_1.time_ = 0
		arg_318_1.frameCnt_ = 0
		arg_318_1.state_ = "playing"
		arg_318_1.curTalkId_ = 417261077
		arg_318_1.duration_ = 9.6

		local var_318_0 = {
			zh = 6.5,
			ja = 9.6
		}
		local var_318_1 = manager.audio:GetLocalizationFlag()

		if var_318_0[var_318_1] ~= nil then
			arg_318_1.duration_ = var_318_0[var_318_1]
		end

		SetActive(arg_318_1.tipsGo_, false)

		function arg_318_1.onSingleLineFinish_()
			arg_318_1.onSingleLineUpdate_ = nil
			arg_318_1.onSingleLineFinish_ = nil
			arg_318_1.state_ = "waiting"
		end

		function arg_318_1.playNext_(arg_320_0)
			if arg_320_0 == 1 then
				arg_318_0:Play417261078(arg_318_1)
			end
		end

		function arg_318_1.onSingleLineUpdate_(arg_321_0)
			local var_321_0 = arg_318_1.actors_["1034"]
			local var_321_1 = 0

			if var_321_1 < arg_318_1.time_ and arg_318_1.time_ <= var_321_1 + arg_321_0 and not isNil(var_321_0) and arg_318_1.var_.actorSpriteComps1034 == nil then
				arg_318_1.var_.actorSpriteComps1034 = var_321_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_321_2 = 0.2

			if var_321_1 <= arg_318_1.time_ and arg_318_1.time_ < var_321_1 + var_321_2 and not isNil(var_321_0) then
				local var_321_3 = (arg_318_1.time_ - var_321_1) / var_321_2

				if arg_318_1.var_.actorSpriteComps1034 then
					for iter_321_0, iter_321_1 in pairs(arg_318_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_321_1 then
							if arg_318_1.isInRecall_ then
								local var_321_4 = Mathf.Lerp(iter_321_1.color.r, arg_318_1.hightColor2.r, var_321_3)
								local var_321_5 = Mathf.Lerp(iter_321_1.color.g, arg_318_1.hightColor2.g, var_321_3)
								local var_321_6 = Mathf.Lerp(iter_321_1.color.b, arg_318_1.hightColor2.b, var_321_3)

								iter_321_1.color = Color.New(var_321_4, var_321_5, var_321_6)
							else
								local var_321_7 = Mathf.Lerp(iter_321_1.color.r, 0.5, var_321_3)

								iter_321_1.color = Color.New(var_321_7, var_321_7, var_321_7)
							end
						end
					end
				end
			end

			if arg_318_1.time_ >= var_321_1 + var_321_2 and arg_318_1.time_ < var_321_1 + var_321_2 + arg_321_0 and not isNil(var_321_0) and arg_318_1.var_.actorSpriteComps1034 then
				for iter_321_2, iter_321_3 in pairs(arg_318_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_321_3 then
						if arg_318_1.isInRecall_ then
							iter_321_3.color = arg_318_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_321_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_318_1.var_.actorSpriteComps1034 = nil
			end

			local var_321_8 = arg_318_1.actors_["10128"]
			local var_321_9 = 0

			if var_321_9 < arg_318_1.time_ and arg_318_1.time_ <= var_321_9 + arg_321_0 and not isNil(var_321_8) and arg_318_1.var_.actorSpriteComps10128 == nil then
				arg_318_1.var_.actorSpriteComps10128 = var_321_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_321_10 = 0.2

			if var_321_9 <= arg_318_1.time_ and arg_318_1.time_ < var_321_9 + var_321_10 and not isNil(var_321_8) then
				local var_321_11 = (arg_318_1.time_ - var_321_9) / var_321_10

				if arg_318_1.var_.actorSpriteComps10128 then
					for iter_321_4, iter_321_5 in pairs(arg_318_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_321_5 then
							if arg_318_1.isInRecall_ then
								local var_321_12 = Mathf.Lerp(iter_321_5.color.r, arg_318_1.hightColor1.r, var_321_11)
								local var_321_13 = Mathf.Lerp(iter_321_5.color.g, arg_318_1.hightColor1.g, var_321_11)
								local var_321_14 = Mathf.Lerp(iter_321_5.color.b, arg_318_1.hightColor1.b, var_321_11)

								iter_321_5.color = Color.New(var_321_12, var_321_13, var_321_14)
							else
								local var_321_15 = Mathf.Lerp(iter_321_5.color.r, 1, var_321_11)

								iter_321_5.color = Color.New(var_321_15, var_321_15, var_321_15)
							end
						end
					end
				end
			end

			if arg_318_1.time_ >= var_321_9 + var_321_10 and arg_318_1.time_ < var_321_9 + var_321_10 + arg_321_0 and not isNil(var_321_8) and arg_318_1.var_.actorSpriteComps10128 then
				for iter_321_6, iter_321_7 in pairs(arg_318_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_321_7 then
						if arg_318_1.isInRecall_ then
							iter_321_7.color = arg_318_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_321_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_318_1.var_.actorSpriteComps10128 = nil
			end

			local var_321_16 = 0
			local var_321_17 = 0.9

			if var_321_16 < arg_318_1.time_ and arg_318_1.time_ <= var_321_16 + arg_321_0 then
				arg_318_1.talkMaxDuration = 0
				arg_318_1.dialogCg_.alpha = 1

				arg_318_1.dialog_:SetActive(true)
				SetActive(arg_318_1.leftNameGo_, true)

				local var_321_18 = arg_318_1:FormatText(StoryNameCfg[595].name)

				arg_318_1.leftNameTxt_.text = var_321_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_318_1.leftNameTxt_.transform)

				arg_318_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_318_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_318_1:RecordName(arg_318_1.leftNameTxt_.text)
				SetActive(arg_318_1.iconTrs_.gameObject, false)
				arg_318_1.callingController_:SetSelectedState("normal")

				local var_321_19 = arg_318_1:GetWordFromCfg(417261077)
				local var_321_20 = arg_318_1:FormatText(var_321_19.content)

				arg_318_1.text_.text = var_321_20

				LuaForUtil.ClearLinePrefixSymbol(arg_318_1.text_)

				local var_321_21 = 36
				local var_321_22 = utf8.len(var_321_20)
				local var_321_23 = var_321_21 <= 0 and var_321_17 or var_321_17 * (var_321_22 / var_321_21)

				if var_321_23 > 0 and var_321_17 < var_321_23 then
					arg_318_1.talkMaxDuration = var_321_23

					if var_321_23 + var_321_16 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_23 + var_321_16
					end
				end

				arg_318_1.text_.text = var_321_20
				arg_318_1.typewritter.percent = 0

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417261", "417261077", "story_v_out_417261.awb") ~= 0 then
					local var_321_24 = manager.audio:GetVoiceLength("story_v_out_417261", "417261077", "story_v_out_417261.awb") / 1000

					if var_321_24 + var_321_16 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_24 + var_321_16
					end

					if var_321_19.prefab_name ~= "" and arg_318_1.actors_[var_321_19.prefab_name] ~= nil then
						local var_321_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_318_1.actors_[var_321_19.prefab_name].transform, "story_v_out_417261", "417261077", "story_v_out_417261.awb")

						arg_318_1:RecordAudio("417261077", var_321_25)
						arg_318_1:RecordAudio("417261077", var_321_25)
					else
						arg_318_1:AudioAction("play", "voice", "story_v_out_417261", "417261077", "story_v_out_417261.awb")
					end

					arg_318_1:RecordHistoryTalkVoice("story_v_out_417261", "417261077", "story_v_out_417261.awb")
				end

				arg_318_1:RecordContent(arg_318_1.text_.text)
			end

			local var_321_26 = math.max(var_321_17, arg_318_1.talkMaxDuration)

			if var_321_16 <= arg_318_1.time_ and arg_318_1.time_ < var_321_16 + var_321_26 then
				arg_318_1.typewritter.percent = (arg_318_1.time_ - var_321_16) / var_321_26

				arg_318_1.typewritter:SetDirty()
			end

			if arg_318_1.time_ >= var_321_16 + var_321_26 and arg_318_1.time_ < var_321_16 + var_321_26 + arg_321_0 then
				arg_318_1.typewritter.percent = 1

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(true)
			end
		end

		arg_318_1.nodeConfigList_ = {}

		arg_318_1:InitPlayNodeList()
	end,
	Play417261078 = function(arg_322_0, arg_322_1)
		arg_322_1.time_ = 0
		arg_322_1.frameCnt_ = 0
		arg_322_1.state_ = "playing"
		arg_322_1.curTalkId_ = 417261078
		arg_322_1.duration_ = 11.2

		local var_322_0 = {
			zh = 7.4,
			ja = 11.2
		}
		local var_322_1 = manager.audio:GetLocalizationFlag()

		if var_322_0[var_322_1] ~= nil then
			arg_322_1.duration_ = var_322_0[var_322_1]
		end

		SetActive(arg_322_1.tipsGo_, false)

		function arg_322_1.onSingleLineFinish_()
			arg_322_1.onSingleLineUpdate_ = nil
			arg_322_1.onSingleLineFinish_ = nil
			arg_322_1.state_ = "waiting"
		end

		function arg_322_1.playNext_(arg_324_0)
			if arg_324_0 == 1 then
				arg_322_0:Play417261079(arg_322_1)
			end
		end

		function arg_322_1.onSingleLineUpdate_(arg_325_0)
			local var_325_0 = 0
			local var_325_1 = 0.9

			if var_325_0 < arg_322_1.time_ and arg_322_1.time_ <= var_325_0 + arg_325_0 then
				arg_322_1.talkMaxDuration = 0
				arg_322_1.dialogCg_.alpha = 1

				arg_322_1.dialog_:SetActive(true)
				SetActive(arg_322_1.leftNameGo_, true)

				local var_325_2 = arg_322_1:FormatText(StoryNameCfg[595].name)

				arg_322_1.leftNameTxt_.text = var_325_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_322_1.leftNameTxt_.transform)

				arg_322_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_322_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_322_1:RecordName(arg_322_1.leftNameTxt_.text)
				SetActive(arg_322_1.iconTrs_.gameObject, false)
				arg_322_1.callingController_:SetSelectedState("normal")

				local var_325_3 = arg_322_1:GetWordFromCfg(417261078)
				local var_325_4 = arg_322_1:FormatText(var_325_3.content)

				arg_322_1.text_.text = var_325_4

				LuaForUtil.ClearLinePrefixSymbol(arg_322_1.text_)

				local var_325_5 = 36
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

				if manager.audio:GetVoiceLength("story_v_out_417261", "417261078", "story_v_out_417261.awb") ~= 0 then
					local var_325_8 = manager.audio:GetVoiceLength("story_v_out_417261", "417261078", "story_v_out_417261.awb") / 1000

					if var_325_8 + var_325_0 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_8 + var_325_0
					end

					if var_325_3.prefab_name ~= "" and arg_322_1.actors_[var_325_3.prefab_name] ~= nil then
						local var_325_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_322_1.actors_[var_325_3.prefab_name].transform, "story_v_out_417261", "417261078", "story_v_out_417261.awb")

						arg_322_1:RecordAudio("417261078", var_325_9)
						arg_322_1:RecordAudio("417261078", var_325_9)
					else
						arg_322_1:AudioAction("play", "voice", "story_v_out_417261", "417261078", "story_v_out_417261.awb")
					end

					arg_322_1:RecordHistoryTalkVoice("story_v_out_417261", "417261078", "story_v_out_417261.awb")
				end

				arg_322_1:RecordContent(arg_322_1.text_.text)
			end

			local var_325_10 = math.max(var_325_1, arg_322_1.talkMaxDuration)

			if var_325_0 <= arg_322_1.time_ and arg_322_1.time_ < var_325_0 + var_325_10 then
				arg_322_1.typewritter.percent = (arg_322_1.time_ - var_325_0) / var_325_10

				arg_322_1.typewritter:SetDirty()
			end

			if arg_322_1.time_ >= var_325_0 + var_325_10 and arg_322_1.time_ < var_325_0 + var_325_10 + arg_325_0 then
				arg_322_1.typewritter.percent = 1

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(true)
			end
		end

		arg_322_1.nodeConfigList_ = {}

		arg_322_1:InitPlayNodeList()
	end,
	Play417261079 = function(arg_326_0, arg_326_1)
		arg_326_1.time_ = 0
		arg_326_1.frameCnt_ = 0
		arg_326_1.state_ = "playing"
		arg_326_1.curTalkId_ = 417261079
		arg_326_1.duration_ = 5

		SetActive(arg_326_1.tipsGo_, false)

		function arg_326_1.onSingleLineFinish_()
			arg_326_1.onSingleLineUpdate_ = nil
			arg_326_1.onSingleLineFinish_ = nil
			arg_326_1.state_ = "waiting"
		end

		function arg_326_1.playNext_(arg_328_0)
			if arg_328_0 == 1 then
				arg_326_0:Play417261080(arg_326_1)
			end
		end

		function arg_326_1.onSingleLineUpdate_(arg_329_0)
			local var_329_0 = arg_326_1.actors_["1034"].transform
			local var_329_1 = 0

			if var_329_1 < arg_326_1.time_ and arg_326_1.time_ <= var_329_1 + arg_329_0 then
				arg_326_1.var_.moveOldPos1034 = var_329_0.localPosition
				var_329_0.localScale = Vector3.New(1, 1, 1)

				arg_326_1:CheckSpriteTmpPos("1034", 7)

				local var_329_2 = var_329_0.childCount

				for iter_329_0 = 0, var_329_2 - 1 do
					local var_329_3 = var_329_0:GetChild(iter_329_0)

					if var_329_3.name == "" or not string.find(var_329_3.name, "split") then
						var_329_3.gameObject:SetActive(true)
					else
						var_329_3.gameObject:SetActive(false)
					end
				end
			end

			local var_329_4 = 0.001

			if var_329_1 <= arg_326_1.time_ and arg_326_1.time_ < var_329_1 + var_329_4 then
				local var_329_5 = (arg_326_1.time_ - var_329_1) / var_329_4
				local var_329_6 = Vector3.New(0, -2000, 0)

				var_329_0.localPosition = Vector3.Lerp(arg_326_1.var_.moveOldPos1034, var_329_6, var_329_5)
			end

			if arg_326_1.time_ >= var_329_1 + var_329_4 and arg_326_1.time_ < var_329_1 + var_329_4 + arg_329_0 then
				var_329_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_329_7 = arg_326_1.actors_["10128"].transform
			local var_329_8 = 0

			if var_329_8 < arg_326_1.time_ and arg_326_1.time_ <= var_329_8 + arg_329_0 then
				arg_326_1.var_.moveOldPos10128 = var_329_7.localPosition
				var_329_7.localScale = Vector3.New(1, 1, 1)

				arg_326_1:CheckSpriteTmpPos("10128", 7)

				local var_329_9 = var_329_7.childCount

				for iter_329_1 = 0, var_329_9 - 1 do
					local var_329_10 = var_329_7:GetChild(iter_329_1)

					if var_329_10.name == "" or not string.find(var_329_10.name, "split") then
						var_329_10.gameObject:SetActive(true)
					else
						var_329_10.gameObject:SetActive(false)
					end
				end
			end

			local var_329_11 = 0.001

			if var_329_8 <= arg_326_1.time_ and arg_326_1.time_ < var_329_8 + var_329_11 then
				local var_329_12 = (arg_326_1.time_ - var_329_8) / var_329_11
				local var_329_13 = Vector3.New(0, -2000, -300)

				var_329_7.localPosition = Vector3.Lerp(arg_326_1.var_.moveOldPos10128, var_329_13, var_329_12)
			end

			if arg_326_1.time_ >= var_329_8 + var_329_11 and arg_326_1.time_ < var_329_8 + var_329_11 + arg_329_0 then
				var_329_7.localPosition = Vector3.New(0, -2000, -300)
			end

			local var_329_14 = 0
			local var_329_15 = 0.85

			if var_329_14 < arg_326_1.time_ and arg_326_1.time_ <= var_329_14 + arg_329_0 then
				arg_326_1.talkMaxDuration = 0
				arg_326_1.dialogCg_.alpha = 1

				arg_326_1.dialog_:SetActive(true)
				SetActive(arg_326_1.leftNameGo_, false)

				arg_326_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_326_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_326_1:RecordName(arg_326_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_326_1.iconTrs_.gameObject, false)
				arg_326_1.callingController_:SetSelectedState("normal")

				local var_329_16 = arg_326_1:GetWordFromCfg(417261079)
				local var_329_17 = arg_326_1:FormatText(var_329_16.content)

				arg_326_1.text_.text = var_329_17

				LuaForUtil.ClearLinePrefixSymbol(arg_326_1.text_)

				local var_329_18 = 34
				local var_329_19 = utf8.len(var_329_17)
				local var_329_20 = var_329_18 <= 0 and var_329_15 or var_329_15 * (var_329_19 / var_329_18)

				if var_329_20 > 0 and var_329_15 < var_329_20 then
					arg_326_1.talkMaxDuration = var_329_20

					if var_329_20 + var_329_14 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_20 + var_329_14
					end
				end

				arg_326_1.text_.text = var_329_17
				arg_326_1.typewritter.percent = 0

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(false)
				arg_326_1:RecordContent(arg_326_1.text_.text)
			end

			local var_329_21 = math.max(var_329_15, arg_326_1.talkMaxDuration)

			if var_329_14 <= arg_326_1.time_ and arg_326_1.time_ < var_329_14 + var_329_21 then
				arg_326_1.typewritter.percent = (arg_326_1.time_ - var_329_14) / var_329_21

				arg_326_1.typewritter:SetDirty()
			end

			if arg_326_1.time_ >= var_329_14 + var_329_21 and arg_326_1.time_ < var_329_14 + var_329_21 + arg_329_0 then
				arg_326_1.typewritter.percent = 1

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(true)
			end
		end

		arg_326_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_326_1:InitPlayNodeList()
	end,
	Play417261080 = function(arg_330_0, arg_330_1)
		arg_330_1.time_ = 0
		arg_330_1.frameCnt_ = 0
		arg_330_1.state_ = "playing"
		arg_330_1.curTalkId_ = 417261080
		arg_330_1.duration_ = 5

		SetActive(arg_330_1.tipsGo_, false)

		function arg_330_1.onSingleLineFinish_()
			arg_330_1.onSingleLineUpdate_ = nil
			arg_330_1.onSingleLineFinish_ = nil
			arg_330_1.state_ = "waiting"
		end

		function arg_330_1.playNext_(arg_332_0)
			if arg_332_0 == 1 then
				arg_330_0:Play417261081(arg_330_1)
			end
		end

		function arg_330_1.onSingleLineUpdate_(arg_333_0)
			local var_333_0 = 0
			local var_333_1 = 1.475

			if var_333_0 < arg_330_1.time_ and arg_330_1.time_ <= var_333_0 + arg_333_0 then
				arg_330_1.talkMaxDuration = 0
				arg_330_1.dialogCg_.alpha = 1

				arg_330_1.dialog_:SetActive(true)
				SetActive(arg_330_1.leftNameGo_, false)

				arg_330_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_330_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_330_1:RecordName(arg_330_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_330_1.iconTrs_.gameObject, false)
				arg_330_1.callingController_:SetSelectedState("normal")

				local var_333_2 = arg_330_1:GetWordFromCfg(417261080)
				local var_333_3 = arg_330_1:FormatText(var_333_2.content)

				arg_330_1.text_.text = var_333_3

				LuaForUtil.ClearLinePrefixSymbol(arg_330_1.text_)

				local var_333_4 = 59
				local var_333_5 = utf8.len(var_333_3)
				local var_333_6 = var_333_4 <= 0 and var_333_1 or var_333_1 * (var_333_5 / var_333_4)

				if var_333_6 > 0 and var_333_1 < var_333_6 then
					arg_330_1.talkMaxDuration = var_333_6

					if var_333_6 + var_333_0 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_6 + var_333_0
					end
				end

				arg_330_1.text_.text = var_333_3
				arg_330_1.typewritter.percent = 0

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(false)
				arg_330_1:RecordContent(arg_330_1.text_.text)
			end

			local var_333_7 = math.max(var_333_1, arg_330_1.talkMaxDuration)

			if var_333_0 <= arg_330_1.time_ and arg_330_1.time_ < var_333_0 + var_333_7 then
				arg_330_1.typewritter.percent = (arg_330_1.time_ - var_333_0) / var_333_7

				arg_330_1.typewritter:SetDirty()
			end

			if arg_330_1.time_ >= var_333_0 + var_333_7 and arg_330_1.time_ < var_333_0 + var_333_7 + arg_333_0 then
				arg_330_1.typewritter.percent = 1

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(true)
			end
		end

		arg_330_1.nodeConfigList_ = {}

		arg_330_1:InitPlayNodeList()
	end,
	Play417261081 = function(arg_334_0, arg_334_1)
		arg_334_1.time_ = 0
		arg_334_1.frameCnt_ = 0
		arg_334_1.state_ = "playing"
		arg_334_1.curTalkId_ = 417261081
		arg_334_1.duration_ = 9.77

		local var_334_0 = {
			zh = 4.033,
			ja = 9.766
		}
		local var_334_1 = manager.audio:GetLocalizationFlag()

		if var_334_0[var_334_1] ~= nil then
			arg_334_1.duration_ = var_334_0[var_334_1]
		end

		SetActive(arg_334_1.tipsGo_, false)

		function arg_334_1.onSingleLineFinish_()
			arg_334_1.onSingleLineUpdate_ = nil
			arg_334_1.onSingleLineFinish_ = nil
			arg_334_1.state_ = "waiting"
		end

		function arg_334_1.playNext_(arg_336_0)
			if arg_336_0 == 1 then
				arg_334_0:Play417261082(arg_334_1)
			end
		end

		function arg_334_1.onSingleLineUpdate_(arg_337_0)
			local var_337_0 = arg_334_1.actors_["10128"]
			local var_337_1 = 0

			if var_337_1 < arg_334_1.time_ and arg_334_1.time_ <= var_337_1 + arg_337_0 and not isNil(var_337_0) and arg_334_1.var_.actorSpriteComps10128 == nil then
				arg_334_1.var_.actorSpriteComps10128 = var_337_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_337_2 = 0.2

			if var_337_1 <= arg_334_1.time_ and arg_334_1.time_ < var_337_1 + var_337_2 and not isNil(var_337_0) then
				local var_337_3 = (arg_334_1.time_ - var_337_1) / var_337_2

				if arg_334_1.var_.actorSpriteComps10128 then
					for iter_337_0, iter_337_1 in pairs(arg_334_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_337_1 then
							if arg_334_1.isInRecall_ then
								local var_337_4 = Mathf.Lerp(iter_337_1.color.r, arg_334_1.hightColor1.r, var_337_3)
								local var_337_5 = Mathf.Lerp(iter_337_1.color.g, arg_334_1.hightColor1.g, var_337_3)
								local var_337_6 = Mathf.Lerp(iter_337_1.color.b, arg_334_1.hightColor1.b, var_337_3)

								iter_337_1.color = Color.New(var_337_4, var_337_5, var_337_6)
							else
								local var_337_7 = Mathf.Lerp(iter_337_1.color.r, 1, var_337_3)

								iter_337_1.color = Color.New(var_337_7, var_337_7, var_337_7)
							end
						end
					end
				end
			end

			if arg_334_1.time_ >= var_337_1 + var_337_2 and arg_334_1.time_ < var_337_1 + var_337_2 + arg_337_0 and not isNil(var_337_0) and arg_334_1.var_.actorSpriteComps10128 then
				for iter_337_2, iter_337_3 in pairs(arg_334_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_337_3 then
						if arg_334_1.isInRecall_ then
							iter_337_3.color = arg_334_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_337_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_334_1.var_.actorSpriteComps10128 = nil
			end

			local var_337_8 = arg_334_1.actors_["10128"].transform
			local var_337_9 = 0

			if var_337_9 < arg_334_1.time_ and arg_334_1.time_ <= var_337_9 + arg_337_0 then
				arg_334_1.var_.moveOldPos10128 = var_337_8.localPosition
				var_337_8.localScale = Vector3.New(1, 1, 1)

				arg_334_1:CheckSpriteTmpPos("10128", 3)

				local var_337_10 = var_337_8.childCount

				for iter_337_4 = 0, var_337_10 - 1 do
					local var_337_11 = var_337_8:GetChild(iter_337_4)

					if var_337_11.name == "" or not string.find(var_337_11.name, "split") then
						var_337_11.gameObject:SetActive(true)
					else
						var_337_11.gameObject:SetActive(false)
					end
				end
			end

			local var_337_12 = 0.001

			if var_337_9 <= arg_334_1.time_ and arg_334_1.time_ < var_337_9 + var_337_12 then
				local var_337_13 = (arg_334_1.time_ - var_337_9) / var_337_12
				local var_337_14 = Vector3.New(0, -347, -300)

				var_337_8.localPosition = Vector3.Lerp(arg_334_1.var_.moveOldPos10128, var_337_14, var_337_13)
			end

			if arg_334_1.time_ >= var_337_9 + var_337_12 and arg_334_1.time_ < var_337_9 + var_337_12 + arg_337_0 then
				var_337_8.localPosition = Vector3.New(0, -347, -300)
			end

			local var_337_15 = 0
			local var_337_16 = 0.6

			if var_337_15 < arg_334_1.time_ and arg_334_1.time_ <= var_337_15 + arg_337_0 then
				arg_334_1.talkMaxDuration = 0
				arg_334_1.dialogCg_.alpha = 1

				arg_334_1.dialog_:SetActive(true)
				SetActive(arg_334_1.leftNameGo_, true)

				local var_337_17 = arg_334_1:FormatText(StoryNameCfg[595].name)

				arg_334_1.leftNameTxt_.text = var_337_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_334_1.leftNameTxt_.transform)

				arg_334_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_334_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_334_1:RecordName(arg_334_1.leftNameTxt_.text)
				SetActive(arg_334_1.iconTrs_.gameObject, false)
				arg_334_1.callingController_:SetSelectedState("normal")

				local var_337_18 = arg_334_1:GetWordFromCfg(417261081)
				local var_337_19 = arg_334_1:FormatText(var_337_18.content)

				arg_334_1.text_.text = var_337_19

				LuaForUtil.ClearLinePrefixSymbol(arg_334_1.text_)

				local var_337_20 = 24
				local var_337_21 = utf8.len(var_337_19)
				local var_337_22 = var_337_20 <= 0 and var_337_16 or var_337_16 * (var_337_21 / var_337_20)

				if var_337_22 > 0 and var_337_16 < var_337_22 then
					arg_334_1.talkMaxDuration = var_337_22

					if var_337_22 + var_337_15 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_22 + var_337_15
					end
				end

				arg_334_1.text_.text = var_337_19
				arg_334_1.typewritter.percent = 0

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417261", "417261081", "story_v_out_417261.awb") ~= 0 then
					local var_337_23 = manager.audio:GetVoiceLength("story_v_out_417261", "417261081", "story_v_out_417261.awb") / 1000

					if var_337_23 + var_337_15 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_23 + var_337_15
					end

					if var_337_18.prefab_name ~= "" and arg_334_1.actors_[var_337_18.prefab_name] ~= nil then
						local var_337_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_334_1.actors_[var_337_18.prefab_name].transform, "story_v_out_417261", "417261081", "story_v_out_417261.awb")

						arg_334_1:RecordAudio("417261081", var_337_24)
						arg_334_1:RecordAudio("417261081", var_337_24)
					else
						arg_334_1:AudioAction("play", "voice", "story_v_out_417261", "417261081", "story_v_out_417261.awb")
					end

					arg_334_1:RecordHistoryTalkVoice("story_v_out_417261", "417261081", "story_v_out_417261.awb")
				end

				arg_334_1:RecordContent(arg_334_1.text_.text)
			end

			local var_337_25 = math.max(var_337_16, arg_334_1.talkMaxDuration)

			if var_337_15 <= arg_334_1.time_ and arg_334_1.time_ < var_337_15 + var_337_25 then
				arg_334_1.typewritter.percent = (arg_334_1.time_ - var_337_15) / var_337_25

				arg_334_1.typewritter:SetDirty()
			end

			if arg_334_1.time_ >= var_337_15 + var_337_25 and arg_334_1.time_ < var_337_15 + var_337_25 + arg_337_0 then
				arg_334_1.typewritter.percent = 1

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(true)
			end
		end

		arg_334_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_334_1:InitPlayNodeList()
	end,
	Play417261082 = function(arg_338_0, arg_338_1)
		arg_338_1.time_ = 0
		arg_338_1.frameCnt_ = 0
		arg_338_1.state_ = "playing"
		arg_338_1.curTalkId_ = 417261082
		arg_338_1.duration_ = 1.67

		local var_338_0 = {
			zh = 1.366,
			ja = 1.666
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
				arg_338_0:Play417261083(arg_338_1)
			end
		end

		function arg_338_1.onSingleLineUpdate_(arg_341_0)
			local var_341_0 = arg_338_1.actors_["1034"]
			local var_341_1 = 0

			if var_341_1 < arg_338_1.time_ and arg_338_1.time_ <= var_341_1 + arg_341_0 and not isNil(var_341_0) and arg_338_1.var_.actorSpriteComps1034 == nil then
				arg_338_1.var_.actorSpriteComps1034 = var_341_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_341_2 = 0.2

			if var_341_1 <= arg_338_1.time_ and arg_338_1.time_ < var_341_1 + var_341_2 and not isNil(var_341_0) then
				local var_341_3 = (arg_338_1.time_ - var_341_1) / var_341_2

				if arg_338_1.var_.actorSpriteComps1034 then
					for iter_341_0, iter_341_1 in pairs(arg_338_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_341_1 then
							if arg_338_1.isInRecall_ then
								local var_341_4 = Mathf.Lerp(iter_341_1.color.r, arg_338_1.hightColor1.r, var_341_3)
								local var_341_5 = Mathf.Lerp(iter_341_1.color.g, arg_338_1.hightColor1.g, var_341_3)
								local var_341_6 = Mathf.Lerp(iter_341_1.color.b, arg_338_1.hightColor1.b, var_341_3)

								iter_341_1.color = Color.New(var_341_4, var_341_5, var_341_6)
							else
								local var_341_7 = Mathf.Lerp(iter_341_1.color.r, 1, var_341_3)

								iter_341_1.color = Color.New(var_341_7, var_341_7, var_341_7)
							end
						end
					end
				end
			end

			if arg_338_1.time_ >= var_341_1 + var_341_2 and arg_338_1.time_ < var_341_1 + var_341_2 + arg_341_0 and not isNil(var_341_0) and arg_338_1.var_.actorSpriteComps1034 then
				for iter_341_2, iter_341_3 in pairs(arg_338_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_341_3 then
						if arg_338_1.isInRecall_ then
							iter_341_3.color = arg_338_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_341_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_338_1.var_.actorSpriteComps1034 = nil
			end

			local var_341_8 = arg_338_1.actors_["1034"].transform
			local var_341_9 = 0

			if var_341_9 < arg_338_1.time_ and arg_338_1.time_ <= var_341_9 + arg_341_0 then
				arg_338_1.var_.moveOldPos1034 = var_341_8.localPosition
				var_341_8.localScale = Vector3.New(1, 1, 1)

				arg_338_1:CheckSpriteTmpPos("1034", 3)

				local var_341_10 = var_341_8.childCount

				for iter_341_4 = 0, var_341_10 - 1 do
					local var_341_11 = var_341_8:GetChild(iter_341_4)

					if var_341_11.name == "split_1" or not string.find(var_341_11.name, "split") then
						var_341_11.gameObject:SetActive(true)
					else
						var_341_11.gameObject:SetActive(false)
					end
				end
			end

			local var_341_12 = 0.001

			if var_341_9 <= arg_338_1.time_ and arg_338_1.time_ < var_341_9 + var_341_12 then
				local var_341_13 = (arg_338_1.time_ - var_341_9) / var_341_12
				local var_341_14 = Vector3.New(0, -331.9, -324)

				var_341_8.localPosition = Vector3.Lerp(arg_338_1.var_.moveOldPos1034, var_341_14, var_341_13)
			end

			if arg_338_1.time_ >= var_341_9 + var_341_12 and arg_338_1.time_ < var_341_9 + var_341_12 + arg_341_0 then
				var_341_8.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_341_15 = arg_338_1.actors_["10128"].transform
			local var_341_16 = 0

			if var_341_16 < arg_338_1.time_ and arg_338_1.time_ <= var_341_16 + arg_341_0 then
				arg_338_1.var_.moveOldPos10128 = var_341_15.localPosition
				var_341_15.localScale = Vector3.New(1, 1, 1)

				arg_338_1:CheckSpriteTmpPos("10128", 7)

				local var_341_17 = var_341_15.childCount

				for iter_341_5 = 0, var_341_17 - 1 do
					local var_341_18 = var_341_15:GetChild(iter_341_5)

					if var_341_18.name == "" or not string.find(var_341_18.name, "split") then
						var_341_18.gameObject:SetActive(true)
					else
						var_341_18.gameObject:SetActive(false)
					end
				end
			end

			local var_341_19 = 0.001

			if var_341_16 <= arg_338_1.time_ and arg_338_1.time_ < var_341_16 + var_341_19 then
				local var_341_20 = (arg_338_1.time_ - var_341_16) / var_341_19
				local var_341_21 = Vector3.New(0, -2000, -300)

				var_341_15.localPosition = Vector3.Lerp(arg_338_1.var_.moveOldPos10128, var_341_21, var_341_20)
			end

			if arg_338_1.time_ >= var_341_16 + var_341_19 and arg_338_1.time_ < var_341_16 + var_341_19 + arg_341_0 then
				var_341_15.localPosition = Vector3.New(0, -2000, -300)
			end

			local var_341_22 = 0
			local var_341_23 = 0.125

			if var_341_22 < arg_338_1.time_ and arg_338_1.time_ <= var_341_22 + arg_341_0 then
				arg_338_1.talkMaxDuration = 0
				arg_338_1.dialogCg_.alpha = 1

				arg_338_1.dialog_:SetActive(true)
				SetActive(arg_338_1.leftNameGo_, true)

				local var_341_24 = arg_338_1:FormatText(StoryNameCfg[1109].name)

				arg_338_1.leftNameTxt_.text = var_341_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_338_1.leftNameTxt_.transform)

				arg_338_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_338_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_338_1:RecordName(arg_338_1.leftNameTxt_.text)
				SetActive(arg_338_1.iconTrs_.gameObject, false)
				arg_338_1.callingController_:SetSelectedState("normal")

				local var_341_25 = arg_338_1:GetWordFromCfg(417261082)
				local var_341_26 = arg_338_1:FormatText(var_341_25.content)

				arg_338_1.text_.text = var_341_26

				LuaForUtil.ClearLinePrefixSymbol(arg_338_1.text_)

				local var_341_27 = 5
				local var_341_28 = utf8.len(var_341_26)
				local var_341_29 = var_341_27 <= 0 and var_341_23 or var_341_23 * (var_341_28 / var_341_27)

				if var_341_29 > 0 and var_341_23 < var_341_29 then
					arg_338_1.talkMaxDuration = var_341_29

					if var_341_29 + var_341_22 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_29 + var_341_22
					end
				end

				arg_338_1.text_.text = var_341_26
				arg_338_1.typewritter.percent = 0

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417261", "417261082", "story_v_out_417261.awb") ~= 0 then
					local var_341_30 = manager.audio:GetVoiceLength("story_v_out_417261", "417261082", "story_v_out_417261.awb") / 1000

					if var_341_30 + var_341_22 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_30 + var_341_22
					end

					if var_341_25.prefab_name ~= "" and arg_338_1.actors_[var_341_25.prefab_name] ~= nil then
						local var_341_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_338_1.actors_[var_341_25.prefab_name].transform, "story_v_out_417261", "417261082", "story_v_out_417261.awb")

						arg_338_1:RecordAudio("417261082", var_341_31)
						arg_338_1:RecordAudio("417261082", var_341_31)
					else
						arg_338_1:AudioAction("play", "voice", "story_v_out_417261", "417261082", "story_v_out_417261.awb")
					end

					arg_338_1:RecordHistoryTalkVoice("story_v_out_417261", "417261082", "story_v_out_417261.awb")
				end

				arg_338_1:RecordContent(arg_338_1.text_.text)
			end

			local var_341_32 = math.max(var_341_23, arg_338_1.talkMaxDuration)

			if var_341_22 <= arg_338_1.time_ and arg_338_1.time_ < var_341_22 + var_341_32 then
				arg_338_1.typewritter.percent = (arg_338_1.time_ - var_341_22) / var_341_32

				arg_338_1.typewritter:SetDirty()
			end

			if arg_338_1.time_ >= var_341_22 + var_341_32 and arg_338_1.time_ < var_341_22 + var_341_32 + arg_341_0 then
				arg_338_1.typewritter.percent = 1

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(true)
			end
		end

		arg_338_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_338_1:InitPlayNodeList()
	end,
	Play417261083 = function(arg_342_0, arg_342_1)
		arg_342_1.time_ = 0
		arg_342_1.frameCnt_ = 0
		arg_342_1.state_ = "playing"
		arg_342_1.curTalkId_ = 417261083
		arg_342_1.duration_ = 5

		SetActive(arg_342_1.tipsGo_, false)

		function arg_342_1.onSingleLineFinish_()
			arg_342_1.onSingleLineUpdate_ = nil
			arg_342_1.onSingleLineFinish_ = nil
			arg_342_1.state_ = "waiting"
		end

		function arg_342_1.playNext_(arg_344_0)
			if arg_344_0 == 1 then
				arg_342_0:Play417261084(arg_342_1)
			end
		end

		function arg_342_1.onSingleLineUpdate_(arg_345_0)
			local var_345_0 = arg_342_1.actors_["1034"]
			local var_345_1 = 0

			if var_345_1 < arg_342_1.time_ and arg_342_1.time_ <= var_345_1 + arg_345_0 and not isNil(var_345_0) and arg_342_1.var_.actorSpriteComps1034 == nil then
				arg_342_1.var_.actorSpriteComps1034 = var_345_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_345_2 = 0.2

			if var_345_1 <= arg_342_1.time_ and arg_342_1.time_ < var_345_1 + var_345_2 and not isNil(var_345_0) then
				local var_345_3 = (arg_342_1.time_ - var_345_1) / var_345_2

				if arg_342_1.var_.actorSpriteComps1034 then
					for iter_345_0, iter_345_1 in pairs(arg_342_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_345_1 then
							if arg_342_1.isInRecall_ then
								local var_345_4 = Mathf.Lerp(iter_345_1.color.r, arg_342_1.hightColor2.r, var_345_3)
								local var_345_5 = Mathf.Lerp(iter_345_1.color.g, arg_342_1.hightColor2.g, var_345_3)
								local var_345_6 = Mathf.Lerp(iter_345_1.color.b, arg_342_1.hightColor2.b, var_345_3)

								iter_345_1.color = Color.New(var_345_4, var_345_5, var_345_6)
							else
								local var_345_7 = Mathf.Lerp(iter_345_1.color.r, 0.5, var_345_3)

								iter_345_1.color = Color.New(var_345_7, var_345_7, var_345_7)
							end
						end
					end
				end
			end

			if arg_342_1.time_ >= var_345_1 + var_345_2 and arg_342_1.time_ < var_345_1 + var_345_2 + arg_345_0 and not isNil(var_345_0) and arg_342_1.var_.actorSpriteComps1034 then
				for iter_345_2, iter_345_3 in pairs(arg_342_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_345_3 then
						if arg_342_1.isInRecall_ then
							iter_345_3.color = arg_342_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_345_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_342_1.var_.actorSpriteComps1034 = nil
			end

			local var_345_8 = 0.02
			local var_345_9 = 1

			if var_345_8 < arg_342_1.time_ and arg_342_1.time_ <= var_345_8 + arg_345_0 then
				local var_345_10 = "play"
				local var_345_11 = "effect"

				arg_342_1:AudioAction(var_345_10, var_345_11, "se_story_1310", "se_story_1310_cardoor01", "")
			end

			local var_345_12 = 0
			local var_345_13 = 0.75

			if var_345_12 < arg_342_1.time_ and arg_342_1.time_ <= var_345_12 + arg_345_0 then
				arg_342_1.talkMaxDuration = 0
				arg_342_1.dialogCg_.alpha = 1

				arg_342_1.dialog_:SetActive(true)
				SetActive(arg_342_1.leftNameGo_, false)

				arg_342_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_342_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_342_1:RecordName(arg_342_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_342_1.iconTrs_.gameObject, false)
				arg_342_1.callingController_:SetSelectedState("normal")

				local var_345_14 = arg_342_1:GetWordFromCfg(417261083)
				local var_345_15 = arg_342_1:FormatText(var_345_14.content)

				arg_342_1.text_.text = var_345_15

				LuaForUtil.ClearLinePrefixSymbol(arg_342_1.text_)

				local var_345_16 = 30
				local var_345_17 = utf8.len(var_345_15)
				local var_345_18 = var_345_16 <= 0 and var_345_13 or var_345_13 * (var_345_17 / var_345_16)

				if var_345_18 > 0 and var_345_13 < var_345_18 then
					arg_342_1.talkMaxDuration = var_345_18

					if var_345_18 + var_345_12 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_18 + var_345_12
					end
				end

				arg_342_1.text_.text = var_345_15
				arg_342_1.typewritter.percent = 0

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(false)
				arg_342_1:RecordContent(arg_342_1.text_.text)
			end

			local var_345_19 = math.max(var_345_13, arg_342_1.talkMaxDuration)

			if var_345_12 <= arg_342_1.time_ and arg_342_1.time_ < var_345_12 + var_345_19 then
				arg_342_1.typewritter.percent = (arg_342_1.time_ - var_345_12) / var_345_19

				arg_342_1.typewritter:SetDirty()
			end

			if arg_342_1.time_ >= var_345_12 + var_345_19 and arg_342_1.time_ < var_345_12 + var_345_19 + arg_345_0 then
				arg_342_1.typewritter.percent = 1

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(true)
			end
		end

		arg_342_1.nodeConfigList_ = {}

		arg_342_1:InitPlayNodeList()
	end,
	Play417261084 = function(arg_346_0, arg_346_1)
		arg_346_1.time_ = 0
		arg_346_1.frameCnt_ = 0
		arg_346_1.state_ = "playing"
		arg_346_1.curTalkId_ = 417261084
		arg_346_1.duration_ = 6.93

		local var_346_0 = {
			zh = 3.466,
			ja = 6.933
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
				arg_346_0:Play417261085(arg_346_1)
			end
		end

		function arg_346_1.onSingleLineUpdate_(arg_349_0)
			local var_349_0 = arg_346_1.actors_["1034"]
			local var_349_1 = 0

			if var_349_1 < arg_346_1.time_ and arg_346_1.time_ <= var_349_1 + arg_349_0 and not isNil(var_349_0) and arg_346_1.var_.actorSpriteComps1034 == nil then
				arg_346_1.var_.actorSpriteComps1034 = var_349_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_349_2 = 0.2

			if var_349_1 <= arg_346_1.time_ and arg_346_1.time_ < var_349_1 + var_349_2 and not isNil(var_349_0) then
				local var_349_3 = (arg_346_1.time_ - var_349_1) / var_349_2

				if arg_346_1.var_.actorSpriteComps1034 then
					for iter_349_0, iter_349_1 in pairs(arg_346_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_349_1 then
							if arg_346_1.isInRecall_ then
								local var_349_4 = Mathf.Lerp(iter_349_1.color.r, arg_346_1.hightColor1.r, var_349_3)
								local var_349_5 = Mathf.Lerp(iter_349_1.color.g, arg_346_1.hightColor1.g, var_349_3)
								local var_349_6 = Mathf.Lerp(iter_349_1.color.b, arg_346_1.hightColor1.b, var_349_3)

								iter_349_1.color = Color.New(var_349_4, var_349_5, var_349_6)
							else
								local var_349_7 = Mathf.Lerp(iter_349_1.color.r, 1, var_349_3)

								iter_349_1.color = Color.New(var_349_7, var_349_7, var_349_7)
							end
						end
					end
				end
			end

			if arg_346_1.time_ >= var_349_1 + var_349_2 and arg_346_1.time_ < var_349_1 + var_349_2 + arg_349_0 and not isNil(var_349_0) and arg_346_1.var_.actorSpriteComps1034 then
				for iter_349_2, iter_349_3 in pairs(arg_346_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_349_3 then
						if arg_346_1.isInRecall_ then
							iter_349_3.color = arg_346_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_349_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_346_1.var_.actorSpriteComps1034 = nil
			end

			local var_349_8 = arg_346_1.actors_["1034"].transform
			local var_349_9 = 0

			if var_349_9 < arg_346_1.time_ and arg_346_1.time_ <= var_349_9 + arg_349_0 then
				arg_346_1.var_.moveOldPos1034 = var_349_8.localPosition
				var_349_8.localScale = Vector3.New(1, 1, 1)

				arg_346_1:CheckSpriteTmpPos("1034", 3)

				local var_349_10 = var_349_8.childCount

				for iter_349_4 = 0, var_349_10 - 1 do
					local var_349_11 = var_349_8:GetChild(iter_349_4)

					if var_349_11.name == "" or not string.find(var_349_11.name, "split") then
						var_349_11.gameObject:SetActive(true)
					else
						var_349_11.gameObject:SetActive(false)
					end
				end
			end

			local var_349_12 = 0.001

			if var_349_9 <= arg_346_1.time_ and arg_346_1.time_ < var_349_9 + var_349_12 then
				local var_349_13 = (arg_346_1.time_ - var_349_9) / var_349_12
				local var_349_14 = Vector3.New(0, -331.9, -324)

				var_349_8.localPosition = Vector3.Lerp(arg_346_1.var_.moveOldPos1034, var_349_14, var_349_13)
			end

			if arg_346_1.time_ >= var_349_9 + var_349_12 and arg_346_1.time_ < var_349_9 + var_349_12 + arg_349_0 then
				var_349_8.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_349_15 = 0
			local var_349_16 = 0.5

			if var_349_15 < arg_346_1.time_ and arg_346_1.time_ <= var_349_15 + arg_349_0 then
				arg_346_1.talkMaxDuration = 0
				arg_346_1.dialogCg_.alpha = 1

				arg_346_1.dialog_:SetActive(true)
				SetActive(arg_346_1.leftNameGo_, true)

				local var_349_17 = arg_346_1:FormatText(StoryNameCfg[1109].name)

				arg_346_1.leftNameTxt_.text = var_349_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_346_1.leftNameTxt_.transform)

				arg_346_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_346_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_346_1:RecordName(arg_346_1.leftNameTxt_.text)
				SetActive(arg_346_1.iconTrs_.gameObject, false)
				arg_346_1.callingController_:SetSelectedState("normal")

				local var_349_18 = arg_346_1:GetWordFromCfg(417261084)
				local var_349_19 = arg_346_1:FormatText(var_349_18.content)

				arg_346_1.text_.text = var_349_19

				LuaForUtil.ClearLinePrefixSymbol(arg_346_1.text_)

				local var_349_20 = 20
				local var_349_21 = utf8.len(var_349_19)
				local var_349_22 = var_349_20 <= 0 and var_349_16 or var_349_16 * (var_349_21 / var_349_20)

				if var_349_22 > 0 and var_349_16 < var_349_22 then
					arg_346_1.talkMaxDuration = var_349_22

					if var_349_22 + var_349_15 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_22 + var_349_15
					end
				end

				arg_346_1.text_.text = var_349_19
				arg_346_1.typewritter.percent = 0

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417261", "417261084", "story_v_out_417261.awb") ~= 0 then
					local var_349_23 = manager.audio:GetVoiceLength("story_v_out_417261", "417261084", "story_v_out_417261.awb") / 1000

					if var_349_23 + var_349_15 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_23 + var_349_15
					end

					if var_349_18.prefab_name ~= "" and arg_346_1.actors_[var_349_18.prefab_name] ~= nil then
						local var_349_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_346_1.actors_[var_349_18.prefab_name].transform, "story_v_out_417261", "417261084", "story_v_out_417261.awb")

						arg_346_1:RecordAudio("417261084", var_349_24)
						arg_346_1:RecordAudio("417261084", var_349_24)
					else
						arg_346_1:AudioAction("play", "voice", "story_v_out_417261", "417261084", "story_v_out_417261.awb")
					end

					arg_346_1:RecordHistoryTalkVoice("story_v_out_417261", "417261084", "story_v_out_417261.awb")
				end

				arg_346_1:RecordContent(arg_346_1.text_.text)
			end

			local var_349_25 = math.max(var_349_16, arg_346_1.talkMaxDuration)

			if var_349_15 <= arg_346_1.time_ and arg_346_1.time_ < var_349_15 + var_349_25 then
				arg_346_1.typewritter.percent = (arg_346_1.time_ - var_349_15) / var_349_25

				arg_346_1.typewritter:SetDirty()
			end

			if arg_346_1.time_ >= var_349_15 + var_349_25 and arg_346_1.time_ < var_349_15 + var_349_25 + arg_349_0 then
				arg_346_1.typewritter.percent = 1

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(true)
			end
		end

		arg_346_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_346_1:InitPlayNodeList()
	end,
	Play417261085 = function(arg_350_0, arg_350_1)
		arg_350_1.time_ = 0
		arg_350_1.frameCnt_ = 0
		arg_350_1.state_ = "playing"
		arg_350_1.curTalkId_ = 417261085
		arg_350_1.duration_ = 5

		SetActive(arg_350_1.tipsGo_, false)

		function arg_350_1.onSingleLineFinish_()
			arg_350_1.onSingleLineUpdate_ = nil
			arg_350_1.onSingleLineFinish_ = nil
			arg_350_1.state_ = "waiting"
		end

		function arg_350_1.playNext_(arg_352_0)
			if arg_352_0 == 1 then
				arg_350_0:Play417261086(arg_350_1)
			end
		end

		function arg_350_1.onSingleLineUpdate_(arg_353_0)
			local var_353_0 = arg_350_1.actors_["1034"].transform
			local var_353_1 = 0

			if var_353_1 < arg_350_1.time_ and arg_350_1.time_ <= var_353_1 + arg_353_0 then
				arg_350_1.var_.moveOldPos1034 = var_353_0.localPosition
				var_353_0.localScale = Vector3.New(1, 1, 1)

				arg_350_1:CheckSpriteTmpPos("1034", 7)

				local var_353_2 = var_353_0.childCount

				for iter_353_0 = 0, var_353_2 - 1 do
					local var_353_3 = var_353_0:GetChild(iter_353_0)

					if var_353_3.name == "" or not string.find(var_353_3.name, "split") then
						var_353_3.gameObject:SetActive(true)
					else
						var_353_3.gameObject:SetActive(false)
					end
				end
			end

			local var_353_4 = 0.001

			if var_353_1 <= arg_350_1.time_ and arg_350_1.time_ < var_353_1 + var_353_4 then
				local var_353_5 = (arg_350_1.time_ - var_353_1) / var_353_4
				local var_353_6 = Vector3.New(0, -2000, 0)

				var_353_0.localPosition = Vector3.Lerp(arg_350_1.var_.moveOldPos1034, var_353_6, var_353_5)
			end

			if arg_350_1.time_ >= var_353_1 + var_353_4 and arg_350_1.time_ < var_353_1 + var_353_4 + arg_353_0 then
				var_353_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_353_7 = 0.02
			local var_353_8 = 1

			if var_353_7 < arg_350_1.time_ and arg_350_1.time_ <= var_353_7 + arg_353_0 then
				local var_353_9 = "play"
				local var_353_10 = "effect"

				arg_350_1:AudioAction(var_353_9, var_353_10, "se_story_1310", "se_story_1310_car02", "")
			end

			local var_353_11 = 0
			local var_353_12 = 0.9

			if var_353_11 < arg_350_1.time_ and arg_350_1.time_ <= var_353_11 + arg_353_0 then
				arg_350_1.talkMaxDuration = 0
				arg_350_1.dialogCg_.alpha = 1

				arg_350_1.dialog_:SetActive(true)
				SetActive(arg_350_1.leftNameGo_, false)

				arg_350_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_350_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_350_1:RecordName(arg_350_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_350_1.iconTrs_.gameObject, false)
				arg_350_1.callingController_:SetSelectedState("normal")

				local var_353_13 = arg_350_1:GetWordFromCfg(417261085)
				local var_353_14 = arg_350_1:FormatText(var_353_13.content)

				arg_350_1.text_.text = var_353_14

				LuaForUtil.ClearLinePrefixSymbol(arg_350_1.text_)

				local var_353_15 = 36
				local var_353_16 = utf8.len(var_353_14)
				local var_353_17 = var_353_15 <= 0 and var_353_12 or var_353_12 * (var_353_16 / var_353_15)

				if var_353_17 > 0 and var_353_12 < var_353_17 then
					arg_350_1.talkMaxDuration = var_353_17

					if var_353_17 + var_353_11 > arg_350_1.duration_ then
						arg_350_1.duration_ = var_353_17 + var_353_11
					end
				end

				arg_350_1.text_.text = var_353_14
				arg_350_1.typewritter.percent = 0

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(false)
				arg_350_1:RecordContent(arg_350_1.text_.text)
			end

			local var_353_18 = math.max(var_353_12, arg_350_1.talkMaxDuration)

			if var_353_11 <= arg_350_1.time_ and arg_350_1.time_ < var_353_11 + var_353_18 then
				arg_350_1.typewritter.percent = (arg_350_1.time_ - var_353_11) / var_353_18

				arg_350_1.typewritter:SetDirty()
			end

			if arg_350_1.time_ >= var_353_11 + var_353_18 and arg_350_1.time_ < var_353_11 + var_353_18 + arg_353_0 then
				arg_350_1.typewritter.percent = 1

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(true)
			end
		end

		arg_350_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_350_1:InitPlayNodeList()
	end,
	Play417261086 = function(arg_354_0, arg_354_1)
		arg_354_1.time_ = 0
		arg_354_1.frameCnt_ = 0
		arg_354_1.state_ = "playing"
		arg_354_1.curTalkId_ = 417261086
		arg_354_1.duration_ = 4.17

		SetActive(arg_354_1.tipsGo_, false)

		function arg_354_1.onSingleLineFinish_()
			arg_354_1.onSingleLineUpdate_ = nil
			arg_354_1.onSingleLineFinish_ = nil
			arg_354_1.state_ = "waiting"
		end

		function arg_354_1.playNext_(arg_356_0)
			if arg_356_0 == 1 then
				arg_354_0:Play417261087(arg_354_1)
			end
		end

		function arg_354_1.onSingleLineUpdate_(arg_357_0)
			local var_357_0 = 0

			if var_357_0 < arg_354_1.time_ and arg_354_1.time_ <= var_357_0 + arg_357_0 then
				arg_354_1.mask_.enabled = true
				arg_354_1.mask_.raycastTarget = true

				arg_354_1:SetGaussion(false)
			end

			local var_357_1 = 1

			if var_357_0 <= arg_354_1.time_ and arg_354_1.time_ < var_357_0 + var_357_1 then
				local var_357_2 = (arg_354_1.time_ - var_357_0) / var_357_1
				local var_357_3 = Color.New(0, 0, 0)

				var_357_3.a = Mathf.Lerp(0, 1, var_357_2)
				arg_354_1.mask_.color = var_357_3
			end

			if arg_354_1.time_ >= var_357_0 + var_357_1 and arg_354_1.time_ < var_357_0 + var_357_1 + arg_357_0 then
				local var_357_4 = Color.New(0, 0, 0)

				var_357_4.a = 1
				arg_354_1.mask_.color = var_357_4
			end

			local var_357_5 = 1

			if var_357_5 < arg_354_1.time_ and arg_354_1.time_ <= var_357_5 + arg_357_0 then
				arg_354_1.mask_.enabled = true
				arg_354_1.mask_.raycastTarget = true

				arg_354_1:SetGaussion(false)
			end

			local var_357_6 = 1

			if var_357_5 <= arg_354_1.time_ and arg_354_1.time_ < var_357_5 + var_357_6 then
				local var_357_7 = (arg_354_1.time_ - var_357_5) / var_357_6
				local var_357_8 = Color.New(0, 0, 0)

				var_357_8.a = Mathf.Lerp(1, 0, var_357_7)
				arg_354_1.mask_.color = var_357_8
			end

			if arg_354_1.time_ >= var_357_5 + var_357_6 and arg_354_1.time_ < var_357_5 + var_357_6 + arg_357_0 then
				local var_357_9 = Color.New(0, 0, 0)
				local var_357_10 = 0

				arg_354_1.mask_.enabled = false
				var_357_9.a = var_357_10
				arg_354_1.mask_.color = var_357_9
			end

			local var_357_11 = 1

			if var_357_11 < arg_354_1.time_ and arg_354_1.time_ <= var_357_11 + arg_357_0 then
				local var_357_12 = manager.ui.mainCamera.transform.localPosition
				local var_357_13 = Vector3.New(0, 0, 10) + Vector3.New(var_357_12.x, var_357_12.y, 0)
				local var_357_14 = arg_354_1.bgs_.STblack

				var_357_14.transform.localPosition = var_357_13
				var_357_14.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_357_15 = var_357_14:GetComponent("SpriteRenderer")

				if var_357_15 and var_357_15.sprite then
					local var_357_16 = (var_357_14.transform.localPosition - var_357_12).z
					local var_357_17 = manager.ui.mainCameraCom_
					local var_357_18 = 2 * var_357_16 * Mathf.Tan(var_357_17.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_357_19 = var_357_18 * var_357_17.aspect
					local var_357_20 = var_357_15.sprite.bounds.size.x
					local var_357_21 = var_357_15.sprite.bounds.size.y
					local var_357_22 = var_357_19 / var_357_20
					local var_357_23 = var_357_18 / var_357_21
					local var_357_24 = var_357_23 < var_357_22 and var_357_22 or var_357_23

					var_357_14.transform.localScale = Vector3.New(var_357_24, var_357_24, 0)
				end

				for iter_357_0, iter_357_1 in pairs(arg_354_1.bgs_) do
					if iter_357_0 ~= "STblack" then
						iter_357_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_357_25 = 1

			if var_357_25 < arg_354_1.time_ and arg_354_1.time_ <= var_357_25 + arg_357_0 then
				arg_354_1.cswbg_:SetActive(true)

				local var_357_26 = arg_354_1.cswt_:GetComponent("RectTransform")

				arg_354_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_357_26.offsetMin = Vector2.New(0, 0)
				var_357_26.offsetMax = Vector2.New(0, 0)

				local var_357_27 = arg_354_1:GetWordFromCfg(419125)
				local var_357_28 = arg_354_1:FormatText(var_357_27.content)

				arg_354_1.cswt_.text = var_357_28

				LuaForUtil.ClearLinePrefixSymbol(arg_354_1.cswt_)

				arg_354_1.cswt_.fontSize = 120
				arg_354_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_354_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_354_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end

			local var_357_29 = 1

			if var_357_29 < arg_354_1.time_ and arg_354_1.time_ <= var_357_29 + arg_357_0 then
				local var_357_30 = arg_354_1.fswbg_.transform:Find("textbox/adapt/content") or arg_354_1.fswbg_.transform:Find("textbox/content")
				local var_357_31 = arg_354_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_357_32 = var_357_30:GetComponent("Text")
				local var_357_33 = var_357_30:GetComponent("RectTransform")

				var_357_32.alignment = UnityEngine.TextAnchor.LowerCenter
				var_357_33.offsetMin = Vector2.New(0, 0)
				var_357_33.offsetMax = Vector2.New(0, 0)
			end

			local var_357_34 = 1

			if var_357_34 < arg_354_1.time_ and arg_354_1.time_ <= var_357_34 + arg_357_0 then
				arg_354_1.fswbg_:SetActive(true)
				arg_354_1.dialog_:SetActive(false)

				arg_354_1.fswtw_.percent = 0

				local var_357_35 = arg_354_1:GetWordFromCfg(417261086)
				local var_357_36 = arg_354_1:FormatText(var_357_35.content)

				arg_354_1.fswt_.text = var_357_36

				LuaForUtil.ClearLinePrefixSymbol(arg_354_1.fswt_)

				arg_354_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_354_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_354_1.fswtw_:SetDirty()

				arg_354_1.typewritterCharCountI18N = 0

				SetActive(arg_354_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_354_1:ShowNextGo(false)
			end

			local var_357_37 = 1.36666666666667

			if var_357_37 < arg_354_1.time_ and arg_354_1.time_ <= var_357_37 + arg_357_0 then
				arg_354_1.var_.oldValueTypewriter = arg_354_1.fswtw_.percent

				SetActive(arg_354_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_354_1:ShowNextGo(false)
			end

			local var_357_38 = 30
			local var_357_39 = 2
			local var_357_40 = arg_354_1:GetWordFromCfg(417261086)
			local var_357_41 = arg_354_1:FormatText(var_357_40.content)
			local var_357_42, var_357_43 = arg_354_1:GetPercentByPara(var_357_41, 1)

			if var_357_37 < arg_354_1.time_ and arg_354_1.time_ <= var_357_37 + arg_357_0 then
				arg_354_1.talkMaxDuration = 0

				local var_357_44 = var_357_38 <= 0 and var_357_39 or var_357_39 * ((var_357_43 - arg_354_1.typewritterCharCountI18N) / var_357_38)

				if var_357_44 > 0 and var_357_39 < var_357_44 then
					arg_354_1.talkMaxDuration = var_357_44

					if var_357_44 + var_357_37 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_44 + var_357_37
					end
				end
			end

			local var_357_45 = 2
			local var_357_46 = math.max(var_357_45, arg_354_1.talkMaxDuration)

			if var_357_37 <= arg_354_1.time_ and arg_354_1.time_ < var_357_37 + var_357_46 then
				local var_357_47 = (arg_354_1.time_ - var_357_37) / var_357_46

				arg_354_1.fswtw_.percent = Mathf.Lerp(arg_354_1.var_.oldValueTypewriter, var_357_42, var_357_47)
				arg_354_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_354_1.fswtw_:SetDirty()
			end

			if arg_354_1.time_ >= var_357_37 + var_357_46 and arg_354_1.time_ < var_357_37 + var_357_46 + arg_357_0 then
				arg_354_1.fswtw_.percent = var_357_42

				arg_354_1.fswtw_:SetDirty()
				arg_354_1:ShowNextGo(true)

				arg_354_1.typewritterCharCountI18N = var_357_43
			end

			local var_357_48 = 2.36666666666667
			local var_357_49 = 1

			if var_357_48 < arg_354_1.time_ and arg_354_1.time_ <= var_357_48 + arg_357_0 then
				local var_357_50 = "play"
				local var_357_51 = "effect"

				arg_354_1:AudioAction(var_357_50, var_357_51, "se_story_side_1148", "se_story_1148_vibrate", "")
			end
		end

		arg_354_1.nodeConfigList_ = {}

		arg_354_1:InitPlayNodeList()
	end,
	Play417261087 = function(arg_358_0, arg_358_1)
		arg_358_1.time_ = 0
		arg_358_1.frameCnt_ = 0
		arg_358_1.state_ = "playing"
		arg_358_1.curTalkId_ = 417261087
		arg_358_1.duration_ = 2.43

		SetActive(arg_358_1.tipsGo_, false)

		function arg_358_1.onSingleLineFinish_()
			arg_358_1.onSingleLineUpdate_ = nil
			arg_358_1.onSingleLineFinish_ = nil
			arg_358_1.state_ = "waiting"
		end

		function arg_358_1.playNext_(arg_360_0)
			if arg_360_0 == 1 then
				arg_358_0:Play417261088(arg_358_1)
			end
		end

		function arg_358_1.onSingleLineUpdate_(arg_361_0)
			local var_361_0 = 0

			if var_361_0 < arg_358_1.time_ and arg_358_1.time_ <= var_361_0 + arg_361_0 then
				arg_358_1.fswbg_:SetActive(true)
				arg_358_1.dialog_:SetActive(false)

				arg_358_1.fswtw_.percent = 0

				local var_361_1 = arg_358_1:GetWordFromCfg(417261087)
				local var_361_2 = arg_358_1:FormatText(var_361_1.content)

				arg_358_1.fswt_.text = var_361_2

				LuaForUtil.ClearLinePrefixSymbol(arg_358_1.fswt_)

				arg_358_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_358_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_358_1.fswtw_:SetDirty()

				arg_358_1.typewritterCharCountI18N = 0

				SetActive(arg_358_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_358_1:ShowNextGo(false)
			end

			local var_361_3 = 0.0999999999999999

			if var_361_3 < arg_358_1.time_ and arg_358_1.time_ <= var_361_3 + arg_361_0 then
				arg_358_1.var_.oldValueTypewriter = arg_358_1.fswtw_.percent

				SetActive(arg_358_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_358_1:ShowNextGo(false)
			end

			local var_361_4 = 35
			local var_361_5 = 2.33333333333333
			local var_361_6 = arg_358_1:GetWordFromCfg(417261087)
			local var_361_7 = arg_358_1:FormatText(var_361_6.content)
			local var_361_8, var_361_9 = arg_358_1:GetPercentByPara(var_361_7, 1)

			if var_361_3 < arg_358_1.time_ and arg_358_1.time_ <= var_361_3 + arg_361_0 then
				arg_358_1.talkMaxDuration = 0

				local var_361_10 = var_361_4 <= 0 and var_361_5 or var_361_5 * ((var_361_9 - arg_358_1.typewritterCharCountI18N) / var_361_4)

				if var_361_10 > 0 and var_361_5 < var_361_10 then
					arg_358_1.talkMaxDuration = var_361_10

					if var_361_10 + var_361_3 > arg_358_1.duration_ then
						arg_358_1.duration_ = var_361_10 + var_361_3
					end
				end
			end

			local var_361_11 = 2.33333333333333
			local var_361_12 = math.max(var_361_11, arg_358_1.talkMaxDuration)

			if var_361_3 <= arg_358_1.time_ and arg_358_1.time_ < var_361_3 + var_361_12 then
				local var_361_13 = (arg_358_1.time_ - var_361_3) / var_361_12

				arg_358_1.fswtw_.percent = Mathf.Lerp(arg_358_1.var_.oldValueTypewriter, var_361_8, var_361_13)
				arg_358_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_358_1.fswtw_:SetDirty()
			end

			if arg_358_1.time_ >= var_361_3 + var_361_12 and arg_358_1.time_ < var_361_3 + var_361_12 + arg_361_0 then
				arg_358_1.fswtw_.percent = var_361_8

				arg_358_1.fswtw_:SetDirty()
				arg_358_1:ShowNextGo(true)

				arg_358_1.typewritterCharCountI18N = var_361_9
			end
		end

		arg_358_1.nodeConfigList_ = {}

		arg_358_1:InitPlayNodeList()
	end,
	Play417261088 = function(arg_362_0, arg_362_1)
		arg_362_1.time_ = 0
		arg_362_1.frameCnt_ = 0
		arg_362_1.state_ = "playing"
		arg_362_1.curTalkId_ = 417261088
		arg_362_1.duration_ = 2.86

		SetActive(arg_362_1.tipsGo_, false)

		function arg_362_1.onSingleLineFinish_()
			arg_362_1.onSingleLineUpdate_ = nil
			arg_362_1.onSingleLineFinish_ = nil
			arg_362_1.state_ = "waiting"
		end

		function arg_362_1.playNext_(arg_364_0)
			if arg_364_0 == 1 then
				arg_362_0:Play417261089(arg_362_1)
			end
		end

		function arg_362_1.onSingleLineUpdate_(arg_365_0)
			local var_365_0 = 0.966

			if var_365_0 < arg_362_1.time_ and arg_362_1.time_ <= var_365_0 + arg_365_0 then
				arg_362_1.cswbg_:SetActive(false)
			end

			local var_365_1 = 1

			if var_365_1 < arg_362_1.time_ and arg_362_1.time_ <= var_365_1 + arg_365_0 then
				local var_365_2 = manager.ui.mainCamera.transform.localPosition
				local var_365_3 = Vector3.New(0, 0, 10) + Vector3.New(var_365_2.x, var_365_2.y, 0)
				local var_365_4 = arg_362_1.bgs_.STblack

				var_365_4.transform.localPosition = var_365_3
				var_365_4.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_365_5 = var_365_4:GetComponent("SpriteRenderer")

				if var_365_5 and var_365_5.sprite then
					local var_365_6 = (var_365_4.transform.localPosition - var_365_2).z
					local var_365_7 = manager.ui.mainCameraCom_
					local var_365_8 = 2 * var_365_6 * Mathf.Tan(var_365_7.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_365_9 = var_365_8 * var_365_7.aspect
					local var_365_10 = var_365_5.sprite.bounds.size.x
					local var_365_11 = var_365_5.sprite.bounds.size.y
					local var_365_12 = var_365_9 / var_365_10
					local var_365_13 = var_365_8 / var_365_11
					local var_365_14 = var_365_13 < var_365_12 and var_365_12 or var_365_13

					var_365_4.transform.localScale = Vector3.New(var_365_14, var_365_14, 0)
				end

				for iter_365_0, iter_365_1 in pairs(arg_362_1.bgs_) do
					if iter_365_0 ~= "STblack" then
						iter_365_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_365_15 = 0

			if var_365_15 < arg_362_1.time_ and arg_362_1.time_ <= var_365_15 + arg_365_0 then
				arg_362_1.mask_.enabled = true
				arg_362_1.mask_.raycastTarget = true

				arg_362_1:SetGaussion(false)
			end

			local var_365_16 = 1

			if var_365_15 <= arg_362_1.time_ and arg_362_1.time_ < var_365_15 + var_365_16 then
				local var_365_17 = (arg_362_1.time_ - var_365_15) / var_365_16
				local var_365_18 = Color.New(0, 0, 0)

				var_365_18.a = Mathf.Lerp(0, 1, var_365_17)
				arg_362_1.mask_.color = var_365_18
			end

			if arg_362_1.time_ >= var_365_15 + var_365_16 and arg_362_1.time_ < var_365_15 + var_365_16 + arg_365_0 then
				local var_365_19 = Color.New(0, 0, 0)

				var_365_19.a = 1
				arg_362_1.mask_.color = var_365_19
			end

			local var_365_20 = 1

			if var_365_20 < arg_362_1.time_ and arg_362_1.time_ <= var_365_20 + arg_365_0 then
				arg_362_1.mask_.enabled = true
				arg_362_1.mask_.raycastTarget = true

				arg_362_1:SetGaussion(false)
			end

			local var_365_21 = 1

			if var_365_20 <= arg_362_1.time_ and arg_362_1.time_ < var_365_20 + var_365_21 then
				local var_365_22 = (arg_362_1.time_ - var_365_20) / var_365_21
				local var_365_23 = Color.New(0, 0, 0)

				var_365_23.a = Mathf.Lerp(1, 0, var_365_22)
				arg_362_1.mask_.color = var_365_23
			end

			if arg_362_1.time_ >= var_365_20 + var_365_21 and arg_362_1.time_ < var_365_20 + var_365_21 + arg_365_0 then
				local var_365_24 = Color.New(0, 0, 0)
				local var_365_25 = 0

				arg_362_1.mask_.enabled = false
				var_365_24.a = var_365_25
				arg_362_1.mask_.color = var_365_24
			end

			local var_365_26 = 1

			if var_365_26 < arg_362_1.time_ and arg_362_1.time_ <= var_365_26 + arg_365_0 then
				arg_362_1.fswbg_:SetActive(true)
				arg_362_1.dialog_:SetActive(false)

				arg_362_1.fswtw_.percent = 0

				local var_365_27 = arg_362_1:GetWordFromCfg(417261088)
				local var_365_28 = arg_362_1:FormatText(var_365_27.content)

				arg_362_1.fswt_.text = var_365_28

				LuaForUtil.ClearLinePrefixSymbol(arg_362_1.fswt_)

				arg_362_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_362_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_362_1.fswtw_:SetDirty()

				arg_362_1.typewritterCharCountI18N = 0

				SetActive(arg_362_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_362_1:ShowNextGo(false)
			end

			local var_365_29 = 1.33333333333333

			if var_365_29 < arg_362_1.time_ and arg_362_1.time_ <= var_365_29 + arg_365_0 then
				arg_362_1.var_.oldValueTypewriter = arg_362_1.fswtw_.percent

				SetActive(arg_362_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_362_1:ShowNextGo(false)
			end

			local var_365_30 = 9
			local var_365_31 = 0.6
			local var_365_32 = arg_362_1:GetWordFromCfg(417261088)
			local var_365_33 = arg_362_1:FormatText(var_365_32.content)
			local var_365_34, var_365_35 = arg_362_1:GetPercentByPara(var_365_33, 1)

			if var_365_29 < arg_362_1.time_ and arg_362_1.time_ <= var_365_29 + arg_365_0 then
				arg_362_1.talkMaxDuration = 0

				local var_365_36 = var_365_30 <= 0 and var_365_31 or var_365_31 * ((var_365_35 - arg_362_1.typewritterCharCountI18N) / var_365_30)

				if var_365_36 > 0 and var_365_31 < var_365_36 then
					arg_362_1.talkMaxDuration = var_365_36

					if var_365_36 + var_365_29 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_36 + var_365_29
					end
				end
			end

			local var_365_37 = 0.6
			local var_365_38 = math.max(var_365_37, arg_362_1.talkMaxDuration)

			if var_365_29 <= arg_362_1.time_ and arg_362_1.time_ < var_365_29 + var_365_38 then
				local var_365_39 = (arg_362_1.time_ - var_365_29) / var_365_38

				arg_362_1.fswtw_.percent = Mathf.Lerp(arg_362_1.var_.oldValueTypewriter, var_365_34, var_365_39)
				arg_362_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_362_1.fswtw_:SetDirty()
			end

			if arg_362_1.time_ >= var_365_29 + var_365_38 and arg_362_1.time_ < var_365_29 + var_365_38 + arg_365_0 then
				arg_362_1.fswtw_.percent = var_365_34

				arg_362_1.fswtw_:SetDirty()
				arg_362_1:ShowNextGo(true)

				arg_362_1.typewritterCharCountI18N = var_365_35
			end

			local var_365_40 = 1

			if var_365_40 < arg_362_1.time_ and arg_362_1.time_ <= var_365_40 + arg_365_0 then
				local var_365_41 = arg_362_1.fswbg_.transform:Find("textbox/adapt/content") or arg_362_1.fswbg_.transform:Find("textbox/content")
				local var_365_42 = arg_362_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_365_43 = var_365_41:GetComponent("Text")
				local var_365_44 = var_365_41:GetComponent("RectTransform")

				var_365_43.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_365_44.offsetMin = Vector2.New(0, 0)
				var_365_44.offsetMax = Vector2.New(0, 0)
			end

			local var_365_45 = 1
			local var_365_46 = 1
			local var_365_47 = manager.audio:GetVoiceLength("story_v_out_417261", "417261088", "story_v_out_417261.awb") / 1000

			if var_365_47 > 0 and var_365_46 < var_365_47 and var_365_47 + var_365_45 > arg_362_1.duration_ then
				local var_365_48 = var_365_47

				arg_362_1.duration_ = var_365_47 + var_365_45
			end

			if var_365_45 < arg_362_1.time_ and arg_362_1.time_ <= var_365_45 + arg_365_0 then
				local var_365_49 = "play"
				local var_365_50 = "voice"

				arg_362_1:AudioAction(var_365_49, var_365_50, "story_v_out_417261", "417261088", "story_v_out_417261.awb")
			end

			local var_365_51 = 1.33333333333333
			local var_365_52 = 1

			if var_365_51 < arg_362_1.time_ and arg_362_1.time_ <= var_365_51 + arg_365_0 then
				local var_365_53 = "play"
				local var_365_54 = "effect"

				arg_362_1:AudioAction(var_365_53, var_365_54, "se_story_1311", "se_story_1311_thunder03", "")
			end

			local var_365_55 = manager.ui.mainCamera.transform
			local var_365_56 = 1.33333333333333

			if var_365_56 < arg_362_1.time_ and arg_362_1.time_ <= var_365_56 + arg_365_0 then
				local var_365_57 = arg_362_1.var_.effect10892
				local var_365_58
				local var_365_59 = var_365_55

				if not var_365_57 then
					var_365_57 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Lightning_in"), var_365_59)
					var_365_57.name = "10892"
					arg_362_1.var_.effect10892 = var_365_57
				else
					var_365_57.transform:SetParent(var_365_59)
				end

				var_365_57.transform.localPosition = Vector3.New(0, 0, 0)
				var_365_57.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_365_60 = manager.ui.mainCameraCom_
				local var_365_61 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(var_365_60.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_365_62 = var_365_57.transform:GetComponentsInChildren(typeof(Transform), true):ToTable()
				local var_365_63 = 15
				local var_365_64 = 2 * var_365_63 * Mathf.Tan(var_365_60.fieldOfView * 0.5 * Mathf.Deg2Rad) * var_365_60.aspect
				local var_365_65 = 1
				local var_365_66 = 1.7777777777777777

				if var_365_66 < var_365_60.aspect then
					var_365_65 = var_365_64 / (2 * var_365_63 * Mathf.Tan(15 * Mathf.Deg2Rad) * var_365_66)
				end

				for iter_365_2, iter_365_3 in ipairs(var_365_62) do
					local var_365_67 = iter_365_3.transform.localScale

					iter_365_3.transform.localScale = Vector3.New(var_365_67.x / var_365_61 * var_365_65, var_365_67.y / var_365_61, var_365_67.z)
				end
			end

			local var_365_68 = manager.ui.mainCamera.transform
			local var_365_69 = 2.225

			if var_365_69 < arg_362_1.time_ and arg_362_1.time_ <= var_365_69 + arg_365_0 then
				local var_365_70 = arg_362_1.var_.effect10892

				if var_365_70 then
					Object.Destroy(var_365_70)

					arg_362_1.var_.effect10892 = nil
				end
			end
		end

		arg_362_1.nodeConfigList_ = {}

		arg_362_1:InitPlayNodeList()
	end,
	Play417261089 = function(arg_366_0, arg_366_1)
		arg_366_1.time_ = 0
		arg_366_1.frameCnt_ = 0
		arg_366_1.state_ = "playing"
		arg_366_1.curTalkId_ = 417261089
		arg_366_1.duration_ = 3

		SetActive(arg_366_1.tipsGo_, false)

		function arg_366_1.onSingleLineFinish_()
			arg_366_1.onSingleLineUpdate_ = nil
			arg_366_1.onSingleLineFinish_ = nil
			arg_366_1.state_ = "waiting"
			arg_366_1.auto_ = false
		end

		function arg_366_1.playNext_(arg_368_0)
			arg_366_1.onStoryFinished_()
		end

		function arg_366_1.onSingleLineUpdate_(arg_369_0)
			local var_369_0 = 1

			if var_369_0 < arg_366_1.time_ and arg_366_1.time_ <= var_369_0 + arg_369_0 then
				arg_366_1.cswbg_:SetActive(true)

				local var_369_1 = arg_366_1.cswt_:GetComponent("RectTransform")

				arg_366_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_369_1.offsetMin = Vector2.New(0, 0)
				var_369_1.offsetMax = Vector2.New(0, 0)

				local var_369_2 = arg_366_1:GetWordFromCfg(419126)
				local var_369_3 = arg_366_1:FormatText(var_369_2.content)

				arg_366_1.cswt_.text = var_369_3

				LuaForUtil.ClearLinePrefixSymbol(arg_366_1.cswt_)

				arg_366_1.cswt_.fontSize = 120
				arg_366_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_366_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_366_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end

			local var_369_4 = 0

			if var_369_4 < arg_366_1.time_ and arg_366_1.time_ <= var_369_4 + arg_369_0 then
				arg_366_1.mask_.enabled = true
				arg_366_1.mask_.raycastTarget = true

				arg_366_1:SetGaussion(false)
			end

			local var_369_5 = 1

			if var_369_4 <= arg_366_1.time_ and arg_366_1.time_ < var_369_4 + var_369_5 then
				local var_369_6 = (arg_366_1.time_ - var_369_4) / var_369_5
				local var_369_7 = Color.New(0, 0, 0)

				var_369_7.a = Mathf.Lerp(0, 1, var_369_6)
				arg_366_1.mask_.color = var_369_7
			end

			if arg_366_1.time_ >= var_369_4 + var_369_5 and arg_366_1.time_ < var_369_4 + var_369_5 + arg_369_0 then
				local var_369_8 = Color.New(0, 0, 0)

				var_369_8.a = 1
				arg_366_1.mask_.color = var_369_8
			end

			local var_369_9 = 1

			if var_369_9 < arg_366_1.time_ and arg_366_1.time_ <= var_369_9 + arg_369_0 then
				arg_366_1.mask_.enabled = true
				arg_366_1.mask_.raycastTarget = true

				arg_366_1:SetGaussion(false)
			end

			local var_369_10 = 1

			if var_369_9 <= arg_366_1.time_ and arg_366_1.time_ < var_369_9 + var_369_10 then
				local var_369_11 = (arg_366_1.time_ - var_369_9) / var_369_10
				local var_369_12 = Color.New(0, 0, 0)

				var_369_12.a = Mathf.Lerp(1, 0, var_369_11)
				arg_366_1.mask_.color = var_369_12
			end

			if arg_366_1.time_ >= var_369_9 + var_369_10 and arg_366_1.time_ < var_369_9 + var_369_10 + arg_369_0 then
				local var_369_13 = Color.New(0, 0, 0)
				local var_369_14 = 0

				arg_366_1.mask_.enabled = false
				var_369_13.a = var_369_14
				arg_366_1.mask_.color = var_369_13
			end

			local var_369_15 = 0.9

			if var_369_15 < arg_366_1.time_ and arg_366_1.time_ <= var_369_15 + arg_369_0 then
				arg_366_1.fswbg_:SetActive(false)
				arg_366_1.dialog_:SetActive(false)
				SetActive(arg_366_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_366_1:ShowNextGo(false)
			end

			local var_369_16 = manager.ui.mainCamera.transform
			local var_369_17 = 1

			if var_369_17 < arg_366_1.time_ and arg_366_1.time_ <= var_369_17 + arg_369_0 then
				local var_369_18 = arg_366_1.var_.effect10891
				local var_369_19
				local var_369_20 = var_369_16

				if not var_369_18 then
					var_369_18 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_rain_heavymax_1"), var_369_20)
					var_369_18.name = "10891"
					arg_366_1.var_.effect10891 = var_369_18
				else
					var_369_18.transform:SetParent(var_369_20)
				end

				var_369_18.transform.localPosition = Vector3.New(0, 0, 0)
				var_369_18.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_369_21 = manager.ui.mainCameraCom_
				local var_369_22 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(var_369_21.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_369_23 = var_369_18.transform:GetComponentsInChildren(typeof(Transform), true):ToTable()
				local var_369_24 = 15
				local var_369_25 = 2 * var_369_24 * Mathf.Tan(var_369_21.fieldOfView * 0.5 * Mathf.Deg2Rad) * var_369_21.aspect
				local var_369_26 = 1
				local var_369_27 = 1.7777777777777777

				if var_369_27 < var_369_21.aspect then
					var_369_26 = var_369_25 / (2 * var_369_24 * Mathf.Tan(15 * Mathf.Deg2Rad) * var_369_27)
				end

				for iter_369_0, iter_369_1 in ipairs(var_369_23) do
					local var_369_28 = iter_369_1.transform.localScale

					iter_369_1.transform.localScale = Vector3.New(var_369_28.x / var_369_22 * var_369_26, var_369_28.y / var_369_22, var_369_28.z)
				end
			end

			local var_369_29 = 1
			local var_369_30 = 1

			if var_369_29 < arg_366_1.time_ and arg_366_1.time_ <= var_369_29 + arg_369_0 then
				local var_369_31 = "play"
				local var_369_32 = "effect"

				arg_366_1:AudioAction(var_369_31, var_369_32, "se_story_1212", "se_story_1210_thunderrain_loop", "")
			end
		end

		arg_366_1.nodeConfigList_ = {}

		arg_366_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/I16f",
		"TextureConfig/Background/B13g",
		"TextureConfig/Background/ST73",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/ST02"
	},
	voices = {
		"story_v_out_417261.awb"
	}
}
