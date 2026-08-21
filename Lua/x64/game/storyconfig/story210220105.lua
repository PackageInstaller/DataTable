return {
	Play1102205001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 1102205001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play1102205002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "F03_2"

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
				local var_4_5 = arg_1_1.bgs_.F03_2

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
					if iter_4_0 ~= "F03_2" then
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
				local var_4_21 = Color.New(1, 1, 1)

				var_4_21.a = Mathf.Lerp(1, 0, var_4_20)
				arg_1_1.mask_.color = var_4_21
			end

			if arg_1_1.time_ >= var_4_18 + var_4_19 and arg_1_1.time_ < var_4_18 + var_4_19 + arg_4_0 then
				local var_4_22 = Color.New(1, 1, 1)
				local var_4_23 = 0

				arg_1_1.mask_.enabled = false
				var_4_22.a = var_4_23
				arg_1_1.mask_.color = var_4_22
			end

			local var_4_24 = 0.666666666666667

			if var_4_24 < arg_1_1.time_ and arg_1_1.time_ <= var_4_24 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_25 = 1.33333333333333

			if var_4_24 <= arg_1_1.time_ and arg_1_1.time_ < var_4_24 + var_4_25 then
				local var_4_26 = (arg_1_1.time_ - var_4_24) / var_4_25
				local var_4_27 = Color.New(1, 1, 1)

				var_4_27.a = Mathf.Lerp(1, 0, var_4_26)
				arg_1_1.mask_.color = var_4_27
			end

			if arg_1_1.time_ >= var_4_24 + var_4_25 and arg_1_1.time_ < var_4_24 + var_4_25 + arg_4_0 then
				local var_4_28 = Color.New(1, 1, 1)
				local var_4_29 = 0

				arg_1_1.mask_.enabled = false
				var_4_28.a = var_4_29
				arg_1_1.mask_.color = var_4_28
			end

			local var_4_30 = 0
			local var_4_31 = 1

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				local var_4_32 = "play"
				local var_4_33 = "effect"

				arg_1_1:AudioAction(var_4_32, var_4_33, "se_story_140", "se_story_140_camera02", "")
			end

			local var_4_34 = 0.633333333333333
			local var_4_35 = 1

			if var_4_34 < arg_1_1.time_ and arg_1_1.time_ <= var_4_34 + arg_4_0 then
				local var_4_36 = "play"
				local var_4_37 = "effect"

				arg_1_1:AudioAction(var_4_36, var_4_37, "se_story_122_03", "se_story_122_03_camera", "")
			end

			local var_4_38 = 1.36666666666667
			local var_4_39 = 1

			if var_4_38 < arg_1_1.time_ and arg_1_1.time_ <= var_4_38 + arg_4_0 then
				local var_4_40 = "play"
				local var_4_41 = "effect"

				arg_1_1:AudioAction(var_4_40, var_4_41, "se_story_16", "se_story_16_street_loop", "")
			end

			local var_4_42 = 0
			local var_4_43 = 0.3

			if var_4_42 < arg_1_1.time_ and arg_1_1.time_ <= var_4_42 + arg_4_0 then
				local var_4_44 = "play"
				local var_4_45 = "music"

				arg_1_1:AudioAction(var_4_44, var_4_45, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_46 = ""
				local var_4_47 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_47 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_47 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_47

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_47
						arg_1_1.bgmTxt2_.text = var_4_47
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

			local var_4_48 = 1.46666666666667
			local var_4_49 = 1

			if var_4_48 < arg_1_1.time_ and arg_1_1.time_ <= var_4_48 + arg_4_0 then
				local var_4_50 = "play"
				local var_4_51 = "music"

				arg_1_1:AudioAction(var_4_50, var_4_51, "bgm_activity_1_3_story_outdoor", "bgm_activity_1_3_story_outdoor", "bgm_activity_1_3_story_outdoor.awb")

				local var_4_52 = ""
				local var_4_53 = manager.audio:GetAudioName("bgm_activity_1_3_story_outdoor", "bgm_activity_1_3_story_outdoor")

				if var_4_53 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_53 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_53

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_53
						arg_1_1.bgmTxt2_.text = var_4_53
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

			local var_4_54 = 2
			local var_4_55 = 1.125

			if var_4_54 < arg_1_1.time_ and arg_1_1.time_ <= var_4_54 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_56 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_56:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_56:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_56:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_57 = arg_1_1:GetWordFromCfg(1102205001)
				local var_4_58 = arg_1_1:FormatText(var_4_57.content)

				arg_1_1.text_.text = var_4_58

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_59 = 45
				local var_4_60 = utf8.len(var_4_58)
				local var_4_61 = var_4_59 <= 0 and var_4_55 or var_4_55 * (var_4_60 / var_4_59)

				if var_4_61 > 0 and var_4_55 < var_4_61 then
					arg_1_1.talkMaxDuration = var_4_61
					var_4_54 = var_4_54 + 0.3

					if var_4_61 + var_4_54 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_61 + var_4_54
					end
				end

				arg_1_1.text_.text = var_4_58
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_62 = var_4_54 + 0.3
			local var_4_63 = math.max(var_4_55, arg_1_1.talkMaxDuration)

			if var_4_62 <= arg_1_1.time_ and arg_1_1.time_ < var_4_62 + var_4_63 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_62) / var_4_63

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_62 + var_4_63 and arg_1_1.time_ < var_4_62 + var_4_63 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play1102205002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 1102205002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play1102205003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0
			local var_12_1 = 0.925

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

				local var_12_2 = arg_9_1:GetWordFromCfg(1102205002)
				local var_12_3 = arg_9_1:FormatText(var_12_2.content)

				arg_9_1.text_.text = var_12_3

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_4 = 37
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
	Play1102205003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 1102205003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play1102205004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0
			local var_16_1 = 0.4

			if var_16_0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_2 = arg_13_1:FormatText(StoryNameCfg[7].name)

				arg_13_1.leftNameTxt_.text = var_16_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, true)
				arg_13_1.iconController_:SetSelectedState("hero")

				arg_13_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_13_1.callingController_:SetSelectedState("normal")

				arg_13_1.keyicon_.color = Color.New(1, 1, 1)
				arg_13_1.icon_.color = Color.New(1, 1, 1)

				local var_16_3 = arg_13_1:GetWordFromCfg(1102205003)
				local var_16_4 = arg_13_1:FormatText(var_16_3.content)

				arg_13_1.text_.text = var_16_4

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_5 = 16
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
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_8 = math.max(var_16_1, arg_13_1.talkMaxDuration)

			if var_16_0 <= arg_13_1.time_ and arg_13_1.time_ < var_16_0 + var_16_8 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_0) / var_16_8

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_0 + var_16_8 and arg_13_1.time_ < var_16_0 + var_16_8 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play1102205004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 1102205004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play1102205005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0
			local var_20_1 = 1.075

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

				local var_20_2 = arg_17_1:GetWordFromCfg(1102205004)
				local var_20_3 = arg_17_1:FormatText(var_20_2.content)

				arg_17_1.text_.text = var_20_3

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_4 = 43
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
	Play1102205005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 1102205005
		arg_21_1.duration_ = 2.9

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play1102205006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = "1022ui_story"

			if arg_21_1.actors_[var_24_0] == nil then
				local var_24_1 = Asset.Load("Char/" .. "1022ui_story")

				if not isNil(var_24_1) then
					local var_24_2 = Object.Instantiate(Asset.Load("Char/" .. "1022ui_story"), arg_21_1.stage_.transform)

					var_24_2.name = var_24_0
					var_24_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_21_1.actors_[var_24_0] = var_24_2

					local var_24_3 = var_24_2:GetComponentInChildren(typeof(CharacterEffect))

					var_24_3.enabled = true

					local var_24_4 = GameObjectTools.GetOrAddComponent(var_24_2, typeof(DynamicBoneHelper))

					if var_24_4 then
						var_24_4:EnableDynamicBone(false)
					end

					arg_21_1:ShowWeapon(var_24_3.transform, false)

					arg_21_1.var_[var_24_0 .. "Animator"] = var_24_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_21_1.var_[var_24_0 .. "Animator"].applyRootMotion = true
					arg_21_1.var_[var_24_0 .. "LipSync"] = var_24_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_24_5 = arg_21_1.actors_["1022ui_story"].transform
			local var_24_6 = 0

			if var_24_6 < arg_21_1.time_ and arg_21_1.time_ <= var_24_6 + arg_24_0 then
				arg_21_1.var_.moveOldPos1022ui_story = var_24_5.localPosition
			end

			local var_24_7 = 0.001

			if var_24_6 <= arg_21_1.time_ and arg_21_1.time_ < var_24_6 + var_24_7 then
				local var_24_8 = (arg_21_1.time_ - var_24_6) / var_24_7
				local var_24_9 = Vector3.New(0, -1.08, -6)

				var_24_5.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1022ui_story, var_24_9, var_24_8)

				local var_24_10 = manager.ui.mainCamera.transform.position - var_24_5.position

				var_24_5.forward = Vector3.New(var_24_10.x, var_24_10.y, var_24_10.z)

				local var_24_11 = var_24_5.localEulerAngles

				var_24_11.z = 0
				var_24_11.x = 0
				var_24_5.localEulerAngles = var_24_11
			end

			if arg_21_1.time_ >= var_24_6 + var_24_7 and arg_21_1.time_ < var_24_6 + var_24_7 + arg_24_0 then
				var_24_5.localPosition = Vector3.New(0, -1.08, -6)

				local var_24_12 = manager.ui.mainCamera.transform.position - var_24_5.position

				var_24_5.forward = Vector3.New(var_24_12.x, var_24_12.y, var_24_12.z)

				local var_24_13 = var_24_5.localEulerAngles

				var_24_13.z = 0
				var_24_13.x = 0
				var_24_5.localEulerAngles = var_24_13
			end

			local var_24_14 = arg_21_1.actors_["1022ui_story"]
			local var_24_15 = 0

			if var_24_15 < arg_21_1.time_ and arg_21_1.time_ <= var_24_15 + arg_24_0 and not isNil(var_24_14) and arg_21_1.var_.characterEffect1022ui_story == nil then
				arg_21_1.var_.characterEffect1022ui_story = var_24_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_16 = 0.200000002980232

			if var_24_15 <= arg_21_1.time_ and arg_21_1.time_ < var_24_15 + var_24_16 and not isNil(var_24_14) then
				local var_24_17 = (arg_21_1.time_ - var_24_15) / var_24_16

				if arg_21_1.var_.characterEffect1022ui_story and not isNil(var_24_14) then
					arg_21_1.var_.characterEffect1022ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= var_24_15 + var_24_16 and arg_21_1.time_ < var_24_15 + var_24_16 + arg_24_0 and not isNil(var_24_14) and arg_21_1.var_.characterEffect1022ui_story then
				arg_21_1.var_.characterEffect1022ui_story.fillFlat = false
			end

			local var_24_18 = 0

			if var_24_18 < arg_21_1.time_ and arg_21_1.time_ <= var_24_18 + arg_24_0 then
				arg_21_1:PlayTimeline("1022ui_story", "StoryTimeline/CharAction/story1022/story1022action/1022action3_1")
			end

			local var_24_19 = 0

			if var_24_19 < arg_21_1.time_ and arg_21_1.time_ <= var_24_19 + arg_24_0 then
				arg_21_1:PlayTimeline("1022ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_24_20 = 0
			local var_24_21 = 0.275

			if var_24_20 < arg_21_1.time_ and arg_21_1.time_ <= var_24_20 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_22 = arg_21_1:FormatText(StoryNameCfg[259].name)

				arg_21_1.leftNameTxt_.text = var_24_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_23 = arg_21_1:GetWordFromCfg(1102205005)
				local var_24_24 = arg_21_1:FormatText(var_24_23.content)

				arg_21_1.text_.text = var_24_24

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_25 = 11
				local var_24_26 = utf8.len(var_24_24)
				local var_24_27 = var_24_25 <= 0 and var_24_21 or var_24_21 * (var_24_26 / var_24_25)

				if var_24_27 > 0 and var_24_21 < var_24_27 then
					arg_21_1.talkMaxDuration = var_24_27

					if var_24_27 + var_24_20 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_27 + var_24_20
					end
				end

				arg_21_1.text_.text = var_24_24
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205005", "story_v_side_new_1102205.awb") ~= 0 then
					local var_24_28 = manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205005", "story_v_side_new_1102205.awb") / 1000

					if var_24_28 + var_24_20 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_28 + var_24_20
					end

					if var_24_23.prefab_name ~= "" and arg_21_1.actors_[var_24_23.prefab_name] ~= nil then
						local var_24_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_23.prefab_name].transform, "story_v_side_new_1102205", "1102205005", "story_v_side_new_1102205.awb")

						arg_21_1:RecordAudio("1102205005", var_24_29)
						arg_21_1:RecordAudio("1102205005", var_24_29)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_side_new_1102205", "1102205005", "story_v_side_new_1102205.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_side_new_1102205", "1102205005", "story_v_side_new_1102205.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_30 = math.max(var_24_21, arg_21_1.talkMaxDuration)

			if var_24_20 <= arg_21_1.time_ and arg_21_1.time_ < var_24_20 + var_24_30 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_20) / var_24_30

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_20 + var_24_30 and arg_21_1.time_ < var_24_20 + var_24_30 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1022ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_21_1:InitPlayNodeList()
	end,
	Play1102205006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 1102205006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play1102205007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = arg_25_1.actors_["1022ui_story"]
			local var_28_1 = 0

			if var_28_1 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.characterEffect1022ui_story == nil then
				arg_25_1.var_.characterEffect1022ui_story = var_28_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_2 = 0.200000002980232

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_2 and not isNil(var_28_0) then
				local var_28_3 = (arg_25_1.time_ - var_28_1) / var_28_2

				if arg_25_1.var_.characterEffect1022ui_story and not isNil(var_28_0) then
					local var_28_4 = Mathf.Lerp(0, 0.5, var_28_3)

					arg_25_1.var_.characterEffect1022ui_story.fillFlat = true
					arg_25_1.var_.characterEffect1022ui_story.fillRatio = var_28_4
				end
			end

			if arg_25_1.time_ >= var_28_1 + var_28_2 and arg_25_1.time_ < var_28_1 + var_28_2 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.characterEffect1022ui_story then
				local var_28_5 = 0.5

				arg_25_1.var_.characterEffect1022ui_story.fillFlat = true
				arg_25_1.var_.characterEffect1022ui_story.fillRatio = var_28_5
			end

			local var_28_6 = 0
			local var_28_7 = 1.05

			if var_28_6 < arg_25_1.time_ and arg_25_1.time_ <= var_28_6 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, false)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_8 = arg_25_1:GetWordFromCfg(1102205006)
				local var_28_9 = arg_25_1:FormatText(var_28_8.content)

				arg_25_1.text_.text = var_28_9

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_10 = 42
				local var_28_11 = utf8.len(var_28_9)
				local var_28_12 = var_28_10 <= 0 and var_28_7 or var_28_7 * (var_28_11 / var_28_10)

				if var_28_12 > 0 and var_28_7 < var_28_12 then
					arg_25_1.talkMaxDuration = var_28_12

					if var_28_12 + var_28_6 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_12 + var_28_6
					end
				end

				arg_25_1.text_.text = var_28_9
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_13 = math.max(var_28_7, arg_25_1.talkMaxDuration)

			if var_28_6 <= arg_25_1.time_ and arg_25_1.time_ < var_28_6 + var_28_13 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_6) / var_28_13

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_6 + var_28_13 and arg_25_1.time_ < var_28_6 + var_28_13 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play1102205007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 1102205007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play1102205008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 0
			local var_32_1 = 0.3

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

				arg_29_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_29_1.callingController_:SetSelectedState("normal")

				arg_29_1.keyicon_.color = Color.New(1, 1, 1)
				arg_29_1.icon_.color = Color.New(1, 1, 1)

				local var_32_3 = arg_29_1:GetWordFromCfg(1102205007)
				local var_32_4 = arg_29_1:FormatText(var_32_3.content)

				arg_29_1.text_.text = var_32_4

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_5 = 12
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
	Play1102205008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 1102205008
		arg_33_1.duration_ = 2.73

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play1102205009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = arg_33_1.actors_["1022ui_story"]
			local var_36_1 = 0

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.characterEffect1022ui_story == nil then
				arg_33_1.var_.characterEffect1022ui_story = var_36_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_2 = 0.200000002980232

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_2 and not isNil(var_36_0) then
				local var_36_3 = (arg_33_1.time_ - var_36_1) / var_36_2

				if arg_33_1.var_.characterEffect1022ui_story and not isNil(var_36_0) then
					arg_33_1.var_.characterEffect1022ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= var_36_1 + var_36_2 and arg_33_1.time_ < var_36_1 + var_36_2 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.characterEffect1022ui_story then
				arg_33_1.var_.characterEffect1022ui_story.fillFlat = false
			end

			local var_36_4 = 0

			if var_36_4 < arg_33_1.time_ and arg_33_1.time_ <= var_36_4 + arg_36_0 then
				arg_33_1:PlayTimeline("1022ui_story", "StoryTimeline/CharAction/story1022/story1022action/1022action3_2")
			end

			local var_36_5 = 0

			if var_36_5 < arg_33_1.time_ and arg_33_1.time_ <= var_36_5 + arg_36_0 then
				arg_33_1:PlayTimeline("1022ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_36_6 = 0
			local var_36_7 = 0.35

			if var_36_6 < arg_33_1.time_ and arg_33_1.time_ <= var_36_6 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_8 = arg_33_1:FormatText(StoryNameCfg[259].name)

				arg_33_1.leftNameTxt_.text = var_36_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_9 = arg_33_1:GetWordFromCfg(1102205008)
				local var_36_10 = arg_33_1:FormatText(var_36_9.content)

				arg_33_1.text_.text = var_36_10

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_11 = 14
				local var_36_12 = utf8.len(var_36_10)
				local var_36_13 = var_36_11 <= 0 and var_36_7 or var_36_7 * (var_36_12 / var_36_11)

				if var_36_13 > 0 and var_36_7 < var_36_13 then
					arg_33_1.talkMaxDuration = var_36_13

					if var_36_13 + var_36_6 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_13 + var_36_6
					end
				end

				arg_33_1.text_.text = var_36_10
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205008", "story_v_side_new_1102205.awb") ~= 0 then
					local var_36_14 = manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205008", "story_v_side_new_1102205.awb") / 1000

					if var_36_14 + var_36_6 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_14 + var_36_6
					end

					if var_36_9.prefab_name ~= "" and arg_33_1.actors_[var_36_9.prefab_name] ~= nil then
						local var_36_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_9.prefab_name].transform, "story_v_side_new_1102205", "1102205008", "story_v_side_new_1102205.awb")

						arg_33_1:RecordAudio("1102205008", var_36_15)
						arg_33_1:RecordAudio("1102205008", var_36_15)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_side_new_1102205", "1102205008", "story_v_side_new_1102205.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_side_new_1102205", "1102205008", "story_v_side_new_1102205.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_16 = math.max(var_36_7, arg_33_1.talkMaxDuration)

			if var_36_6 <= arg_33_1.time_ and arg_33_1.time_ < var_36_6 + var_36_16 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_6) / var_36_16

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_6 + var_36_16 and arg_33_1.time_ < var_36_6 + var_36_16 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play1102205009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 1102205009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play1102205010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = arg_37_1.actors_["1022ui_story"].transform
			local var_40_1 = 0

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 then
				arg_37_1.var_.moveOldPos1022ui_story = var_40_0.localPosition
			end

			local var_40_2 = 0.001

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_2 then
				local var_40_3 = (arg_37_1.time_ - var_40_1) / var_40_2
				local var_40_4 = Vector3.New(0, 100, 0)

				var_40_0.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos1022ui_story, var_40_4, var_40_3)

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

			local var_40_9 = arg_37_1.actors_["1022ui_story"]
			local var_40_10 = 0

			if var_40_10 < arg_37_1.time_ and arg_37_1.time_ <= var_40_10 + arg_40_0 and not isNil(var_40_9) and arg_37_1.var_.characterEffect1022ui_story == nil then
				arg_37_1.var_.characterEffect1022ui_story = var_40_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_11 = 0.200000002980232

			if var_40_10 <= arg_37_1.time_ and arg_37_1.time_ < var_40_10 + var_40_11 and not isNil(var_40_9) then
				local var_40_12 = (arg_37_1.time_ - var_40_10) / var_40_11

				if arg_37_1.var_.characterEffect1022ui_story and not isNil(var_40_9) then
					local var_40_13 = Mathf.Lerp(0, 0.5, var_40_12)

					arg_37_1.var_.characterEffect1022ui_story.fillFlat = true
					arg_37_1.var_.characterEffect1022ui_story.fillRatio = var_40_13
				end
			end

			if arg_37_1.time_ >= var_40_10 + var_40_11 and arg_37_1.time_ < var_40_10 + var_40_11 + arg_40_0 and not isNil(var_40_9) and arg_37_1.var_.characterEffect1022ui_story then
				local var_40_14 = 0.5

				arg_37_1.var_.characterEffect1022ui_story.fillFlat = true
				arg_37_1.var_.characterEffect1022ui_story.fillRatio = var_40_14
			end

			local var_40_15 = 0
			local var_40_16 = 0.95

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

				local var_40_17 = arg_37_1:GetWordFromCfg(1102205009)
				local var_40_18 = arg_37_1:FormatText(var_40_17.content)

				arg_37_1.text_.text = var_40_18

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_19 = 38
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
				actorName = "1022ui_story",
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
	Play1102205010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 1102205010
		arg_41_1.duration_ = 5

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play1102205011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = 0
			local var_44_1 = 1

			if var_44_0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_0 + arg_44_0 then
				local var_44_2 = "play"
				local var_44_3 = "effect"

				arg_41_1:AudioAction(var_44_2, var_44_3, "se_story_side_1022", "se_story_side_1022_camera", "")
			end

			local var_44_4 = 0
			local var_44_5 = 1

			if var_44_4 < arg_41_1.time_ and arg_41_1.time_ <= var_44_4 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, false)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_6 = arg_41_1:GetWordFromCfg(1102205010)
				local var_44_7 = arg_41_1:FormatText(var_44_6.content)

				arg_41_1.text_.text = var_44_7

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_8 = 40
				local var_44_9 = utf8.len(var_44_7)
				local var_44_10 = var_44_8 <= 0 and var_44_5 or var_44_5 * (var_44_9 / var_44_8)

				if var_44_10 > 0 and var_44_5 < var_44_10 then
					arg_41_1.talkMaxDuration = var_44_10

					if var_44_10 + var_44_4 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_10 + var_44_4
					end
				end

				arg_41_1.text_.text = var_44_7
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)
				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_11 = math.max(var_44_5, arg_41_1.talkMaxDuration)

			if var_44_4 <= arg_41_1.time_ and arg_41_1.time_ < var_44_4 + var_44_11 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_4) / var_44_11

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_4 + var_44_11 and arg_41_1.time_ < var_44_4 + var_44_11 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play1102205011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 1102205011
		arg_45_1.duration_ = 10.07

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play1102205012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = "TI0101"

			if arg_45_1.bgs_[var_48_0] == nil then
				local var_48_1 = Object.Instantiate(arg_45_1.paintGo_)

				var_48_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_48_0)
				var_48_1.name = var_48_0
				var_48_1.transform.parent = arg_45_1.stage_.transform
				var_48_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_45_1.bgs_[var_48_0] = var_48_1
			end

			local var_48_2 = 2

			if var_48_2 < arg_45_1.time_ and arg_45_1.time_ <= var_48_2 + arg_48_0 then
				local var_48_3 = manager.ui.mainCamera.transform.localPosition
				local var_48_4 = Vector3.New(0, 0, 10) + Vector3.New(var_48_3.x, var_48_3.y, 0)
				local var_48_5 = arg_45_1.bgs_.TI0101

				var_48_5.transform.localPosition = var_48_4
				var_48_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_48_6 = var_48_5:GetComponent("SpriteRenderer")

				if var_48_6 and var_48_6.sprite then
					local var_48_7 = (var_48_5.transform.localPosition - var_48_3).z
					local var_48_8 = manager.ui.mainCameraCom_
					local var_48_9 = 2 * var_48_7 * Mathf.Tan(var_48_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_48_10 = var_48_9 * var_48_8.aspect
					local var_48_11 = var_48_6.sprite.bounds.size.x
					local var_48_12 = var_48_6.sprite.bounds.size.y
					local var_48_13 = var_48_10 / var_48_11
					local var_48_14 = var_48_9 / var_48_12
					local var_48_15 = var_48_14 < var_48_13 and var_48_13 or var_48_14

					var_48_5.transform.localScale = Vector3.New(var_48_15, var_48_15, 0)
				end

				for iter_48_0, iter_48_1 in pairs(arg_45_1.bgs_) do
					if iter_48_0 ~= "TI0101" then
						iter_48_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_48_16 = 0

			if var_48_16 < arg_45_1.time_ and arg_45_1.time_ <= var_48_16 + arg_48_0 then
				arg_45_1.allBtn_.enabled = false
			end

			local var_48_17 = 0.3

			if arg_45_1.time_ >= var_48_16 + var_48_17 and arg_45_1.time_ < var_48_16 + var_48_17 + arg_48_0 then
				arg_45_1.allBtn_.enabled = true
			end

			local var_48_18 = 0

			if var_48_18 < arg_45_1.time_ and arg_45_1.time_ <= var_48_18 + arg_48_0 then
				arg_45_1.mask_.enabled = true
				arg_45_1.mask_.raycastTarget = true

				arg_45_1:SetGaussion(false)
			end

			local var_48_19 = 2

			if var_48_18 <= arg_45_1.time_ and arg_45_1.time_ < var_48_18 + var_48_19 then
				local var_48_20 = (arg_45_1.time_ - var_48_18) / var_48_19
				local var_48_21 = Color.New(0, 0, 0)

				var_48_21.a = Mathf.Lerp(0, 1, var_48_20)
				arg_45_1.mask_.color = var_48_21
			end

			if arg_45_1.time_ >= var_48_18 + var_48_19 and arg_45_1.time_ < var_48_18 + var_48_19 + arg_48_0 then
				local var_48_22 = Color.New(0, 0, 0)

				var_48_22.a = 1
				arg_45_1.mask_.color = var_48_22
			end

			local var_48_23 = 2

			if var_48_23 < arg_45_1.time_ and arg_45_1.time_ <= var_48_23 + arg_48_0 then
				arg_45_1.mask_.enabled = true
				arg_45_1.mask_.raycastTarget = true

				arg_45_1:SetGaussion(false)
			end

			local var_48_24 = 2

			if var_48_23 <= arg_45_1.time_ and arg_45_1.time_ < var_48_23 + var_48_24 then
				local var_48_25 = (arg_45_1.time_ - var_48_23) / var_48_24
				local var_48_26 = Color.New(0, 0, 0)

				var_48_26.a = Mathf.Lerp(1, 0, var_48_25)
				arg_45_1.mask_.color = var_48_26
			end

			if arg_45_1.time_ >= var_48_23 + var_48_24 and arg_45_1.time_ < var_48_23 + var_48_24 + arg_48_0 then
				local var_48_27 = Color.New(0, 0, 0)
				local var_48_28 = 0

				arg_45_1.mask_.enabled = false
				var_48_27.a = var_48_28
				arg_45_1.mask_.color = var_48_27
			end

			local var_48_29 = 0.133333333333333
			local var_48_30 = 0.3

			if var_48_29 < arg_45_1.time_ and arg_45_1.time_ <= var_48_29 + arg_48_0 then
				local var_48_31 = "play"
				local var_48_32 = "music"

				arg_45_1:AudioAction(var_48_31, var_48_32, "ui_battle", "ui_battle_stopbgm", "")

				local var_48_33 = ""
				local var_48_34 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_48_34 ~= "" then
					if arg_45_1.bgmTxt_.text ~= var_48_34 and arg_45_1.bgmTxt_.text ~= "" then
						if arg_45_1.bgmTxt2_.text ~= "" then
							arg_45_1.bgmTxt_.text = arg_45_1.bgmTxt2_.text
						end

						arg_45_1.bgmTxt2_.text = var_48_34

						arg_45_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_45_1.bgmTxt_.text = var_48_34
						arg_45_1.bgmTxt2_.text = var_48_34
					end

					if arg_45_1.bgmTimer then
						arg_45_1.bgmTimer:Stop()

						arg_45_1.bgmTimer = nil
					end

					if arg_45_1.settingData.show_music_name == 1 then
						arg_45_1.musicController:SetSelectedState("show")
						arg_45_1.musicAnimator_:Play("open", 0, 0)

						if arg_45_1.settingData.music_time ~= 0 then
							arg_45_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_45_1.settingData.music_time), function()
								if arg_45_1 == nil or isNil(arg_45_1.bgmTxt_) then
									return
								end

								arg_45_1.musicController:SetSelectedState("hide")
								arg_45_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_48_35 = 1.53333333333333
			local var_48_36 = 1

			if var_48_35 < arg_45_1.time_ and arg_45_1.time_ <= var_48_35 + arg_48_0 then
				local var_48_37 = "play"
				local var_48_38 = "effect"

				arg_45_1:AudioAction(var_48_37, var_48_38, "se_story_side_1020", "se_story_side_1020_amb_office", "")
			end

			local var_48_39 = 0.133333333333333
			local var_48_40 = 1

			if var_48_39 < arg_45_1.time_ and arg_45_1.time_ <= var_48_39 + arg_48_0 then
				local var_48_41 = "stop"
				local var_48_42 = "effect"

				arg_45_1:AudioAction(var_48_41, var_48_42, "se_story_16", "se_story_16_street_loop", "")
			end

			if arg_45_1.frameCnt_ <= 1 then
				arg_45_1.dialog_:SetActive(false)
			end

			local var_48_43 = 3.83333333333333
			local var_48_44 = 0.75

			if var_48_43 < arg_45_1.time_ and arg_45_1.time_ <= var_48_43 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0

				arg_45_1.dialog_:SetActive(true)

				arg_45_1.dialogCg_.alpha = 0

				local var_48_45 = LeanTween.value(arg_45_1.dialog_, 0, 1, 0.3)

				var_48_45:setOnUpdate(LuaHelper.FloatAction(function(arg_50_0)
					arg_45_1.dialogCg_.alpha = arg_50_0
				end))
				var_48_45:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_45_1.dialog_)
					var_48_45:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_45_1.duration_ = arg_45_1.duration_ + 0.3

				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_46 = arg_45_1:FormatText(StoryNameCfg[1378].name)

				arg_45_1.leftNameTxt_.text = var_48_46

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_47 = arg_45_1:GetWordFromCfg(1102205011)
				local var_48_48 = arg_45_1:FormatText(var_48_47.content)

				arg_45_1.text_.text = var_48_48

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_49 = 30
				local var_48_50 = utf8.len(var_48_48)
				local var_48_51 = var_48_49 <= 0 and var_48_44 or var_48_44 * (var_48_50 / var_48_49)

				if var_48_51 > 0 and var_48_44 < var_48_51 then
					arg_45_1.talkMaxDuration = var_48_51
					var_48_43 = var_48_43 + 0.3

					if var_48_51 + var_48_43 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_51 + var_48_43
					end
				end

				arg_45_1.text_.text = var_48_48
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205011", "story_v_side_new_1102205.awb") ~= 0 then
					local var_48_52 = manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205011", "story_v_side_new_1102205.awb") / 1000

					if var_48_52 + var_48_43 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_52 + var_48_43
					end

					if var_48_47.prefab_name ~= "" and arg_45_1.actors_[var_48_47.prefab_name] ~= nil then
						local var_48_53 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_47.prefab_name].transform, "story_v_side_new_1102205", "1102205011", "story_v_side_new_1102205.awb")

						arg_45_1:RecordAudio("1102205011", var_48_53)
						arg_45_1:RecordAudio("1102205011", var_48_53)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_side_new_1102205", "1102205011", "story_v_side_new_1102205.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_side_new_1102205", "1102205011", "story_v_side_new_1102205.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_54 = var_48_43 + 0.3
			local var_48_55 = math.max(var_48_44, arg_45_1.talkMaxDuration)

			if var_48_54 <= arg_45_1.time_ and arg_45_1.time_ < var_48_54 + var_48_55 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_54) / var_48_55

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_54 + var_48_55 and arg_45_1.time_ < var_48_54 + var_48_55 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play1102205012 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 1102205012
		arg_52_1.duration_ = 4.43

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play1102205013(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = 0
			local var_55_1 = 0.5

			if var_55_0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_0 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				local var_55_2 = arg_52_1:FormatText(StoryNameCfg[1378].name)

				arg_52_1.leftNameTxt_.text = var_55_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_3 = arg_52_1:GetWordFromCfg(1102205012)
				local var_55_4 = arg_52_1:FormatText(var_55_3.content)

				arg_52_1.text_.text = var_55_4

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_5 = 20
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

				if manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205012", "story_v_side_new_1102205.awb") ~= 0 then
					local var_55_8 = manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205012", "story_v_side_new_1102205.awb") / 1000

					if var_55_8 + var_55_0 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_8 + var_55_0
					end

					if var_55_3.prefab_name ~= "" and arg_52_1.actors_[var_55_3.prefab_name] ~= nil then
						local var_55_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_3.prefab_name].transform, "story_v_side_new_1102205", "1102205012", "story_v_side_new_1102205.awb")

						arg_52_1:RecordAudio("1102205012", var_55_9)
						arg_52_1:RecordAudio("1102205012", var_55_9)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_side_new_1102205", "1102205012", "story_v_side_new_1102205.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_side_new_1102205", "1102205012", "story_v_side_new_1102205.awb")
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
	Play1102205013 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 1102205013
		arg_56_1.duration_ = 8.3

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play1102205014(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = 0
			local var_59_1 = 1

			if var_59_0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_0 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				local var_59_2 = arg_56_1:FormatText(StoryNameCfg[1378].name)

				arg_56_1.leftNameTxt_.text = var_59_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_3 = arg_56_1:GetWordFromCfg(1102205013)
				local var_59_4 = arg_56_1:FormatText(var_59_3.content)

				arg_56_1.text_.text = var_59_4

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_5 = 40
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

				if manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205013", "story_v_side_new_1102205.awb") ~= 0 then
					local var_59_8 = manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205013", "story_v_side_new_1102205.awb") / 1000

					if var_59_8 + var_59_0 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_8 + var_59_0
					end

					if var_59_3.prefab_name ~= "" and arg_56_1.actors_[var_59_3.prefab_name] ~= nil then
						local var_59_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_3.prefab_name].transform, "story_v_side_new_1102205", "1102205013", "story_v_side_new_1102205.awb")

						arg_56_1:RecordAudio("1102205013", var_59_9)
						arg_56_1:RecordAudio("1102205013", var_59_9)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_side_new_1102205", "1102205013", "story_v_side_new_1102205.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_side_new_1102205", "1102205013", "story_v_side_new_1102205.awb")
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
	Play1102205014 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 1102205014
		arg_60_1.duration_ = 7.6

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play1102205015(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = 0
			local var_63_1 = 0.875

			if var_63_0 < arg_60_1.time_ and arg_60_1.time_ <= var_63_0 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				local var_63_2 = arg_60_1:FormatText(StoryNameCfg[1378].name)

				arg_60_1.leftNameTxt_.text = var_63_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_3 = arg_60_1:GetWordFromCfg(1102205014)
				local var_63_4 = arg_60_1:FormatText(var_63_3.content)

				arg_60_1.text_.text = var_63_4

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_5 = 35
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

				if manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205014", "story_v_side_new_1102205.awb") ~= 0 then
					local var_63_8 = manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205014", "story_v_side_new_1102205.awb") / 1000

					if var_63_8 + var_63_0 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_8 + var_63_0
					end

					if var_63_3.prefab_name ~= "" and arg_60_1.actors_[var_63_3.prefab_name] ~= nil then
						local var_63_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_3.prefab_name].transform, "story_v_side_new_1102205", "1102205014", "story_v_side_new_1102205.awb")

						arg_60_1:RecordAudio("1102205014", var_63_9)
						arg_60_1:RecordAudio("1102205014", var_63_9)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_side_new_1102205", "1102205014", "story_v_side_new_1102205.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_side_new_1102205", "1102205014", "story_v_side_new_1102205.awb")
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
	Play1102205015 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 1102205015
		arg_64_1.duration_ = 6.9

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play1102205016(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = "ST77"

			if arg_64_1.bgs_[var_67_0] == nil then
				local var_67_1 = Object.Instantiate(arg_64_1.paintGo_)

				var_67_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_67_0)
				var_67_1.name = var_67_0
				var_67_1.transform.parent = arg_64_1.stage_.transform
				var_67_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_64_1.bgs_[var_67_0] = var_67_1
			end

			local var_67_2 = 2

			if var_67_2 < arg_64_1.time_ and arg_64_1.time_ <= var_67_2 + arg_67_0 then
				local var_67_3 = manager.ui.mainCamera.transform.localPosition
				local var_67_4 = Vector3.New(0, 0, 10) + Vector3.New(var_67_3.x, var_67_3.y, 0)
				local var_67_5 = arg_64_1.bgs_.ST77

				var_67_5.transform.localPosition = var_67_4
				var_67_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_67_6 = var_67_5:GetComponent("SpriteRenderer")

				if var_67_6 and var_67_6.sprite then
					local var_67_7 = (var_67_5.transform.localPosition - var_67_3).z
					local var_67_8 = manager.ui.mainCameraCom_
					local var_67_9 = 2 * var_67_7 * Mathf.Tan(var_67_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_67_10 = var_67_9 * var_67_8.aspect
					local var_67_11 = var_67_6.sprite.bounds.size.x
					local var_67_12 = var_67_6.sprite.bounds.size.y
					local var_67_13 = var_67_10 / var_67_11
					local var_67_14 = var_67_9 / var_67_12
					local var_67_15 = var_67_14 < var_67_13 and var_67_13 or var_67_14

					var_67_5.transform.localScale = Vector3.New(var_67_15, var_67_15, 0)
				end

				for iter_67_0, iter_67_1 in pairs(arg_64_1.bgs_) do
					if iter_67_0 ~= "ST77" then
						iter_67_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_67_16 = 0

			if var_67_16 < arg_64_1.time_ and arg_64_1.time_ <= var_67_16 + arg_67_0 then
				arg_64_1.allBtn_.enabled = false
			end

			local var_67_17 = 0.3

			if arg_64_1.time_ >= var_67_16 + var_67_17 and arg_64_1.time_ < var_67_16 + var_67_17 + arg_67_0 then
				arg_64_1.allBtn_.enabled = true
			end

			local var_67_18 = 0

			if var_67_18 < arg_64_1.time_ and arg_64_1.time_ <= var_67_18 + arg_67_0 then
				arg_64_1.mask_.enabled = true
				arg_64_1.mask_.raycastTarget = true

				arg_64_1:SetGaussion(false)
			end

			local var_67_19 = 2

			if var_67_18 <= arg_64_1.time_ and arg_64_1.time_ < var_67_18 + var_67_19 then
				local var_67_20 = (arg_64_1.time_ - var_67_18) / var_67_19
				local var_67_21 = Color.New(0, 0, 0)

				var_67_21.a = Mathf.Lerp(0, 1, var_67_20)
				arg_64_1.mask_.color = var_67_21
			end

			if arg_64_1.time_ >= var_67_18 + var_67_19 and arg_64_1.time_ < var_67_18 + var_67_19 + arg_67_0 then
				local var_67_22 = Color.New(0, 0, 0)

				var_67_22.a = 1
				arg_64_1.mask_.color = var_67_22
			end

			local var_67_23 = 2

			if var_67_23 < arg_64_1.time_ and arg_64_1.time_ <= var_67_23 + arg_67_0 then
				arg_64_1.mask_.enabled = true
				arg_64_1.mask_.raycastTarget = true

				arg_64_1:SetGaussion(false)
			end

			local var_67_24 = 2

			if var_67_23 <= arg_64_1.time_ and arg_64_1.time_ < var_67_23 + var_67_24 then
				local var_67_25 = (arg_64_1.time_ - var_67_23) / var_67_24
				local var_67_26 = Color.New(0, 0, 0)

				var_67_26.a = Mathf.Lerp(1, 0, var_67_25)
				arg_64_1.mask_.color = var_67_26
			end

			if arg_64_1.time_ >= var_67_23 + var_67_24 and arg_64_1.time_ < var_67_23 + var_67_24 + arg_67_0 then
				local var_67_27 = Color.New(0, 0, 0)
				local var_67_28 = 0

				arg_64_1.mask_.enabled = false
				var_67_27.a = var_67_28
				arg_64_1.mask_.color = var_67_27
			end

			local var_67_29 = arg_64_1.actors_["1022ui_story"].transform
			local var_67_30 = 3.8

			if var_67_30 < arg_64_1.time_ and arg_64_1.time_ <= var_67_30 + arg_67_0 then
				arg_64_1.var_.moveOldPos1022ui_story = var_67_29.localPosition
			end

			local var_67_31 = 0.001

			if var_67_30 <= arg_64_1.time_ and arg_64_1.time_ < var_67_30 + var_67_31 then
				local var_67_32 = (arg_64_1.time_ - var_67_30) / var_67_31
				local var_67_33 = Vector3.New(0, -1.08, -6)

				var_67_29.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos1022ui_story, var_67_33, var_67_32)

				local var_67_34 = manager.ui.mainCamera.transform.position - var_67_29.position

				var_67_29.forward = Vector3.New(var_67_34.x, var_67_34.y, var_67_34.z)

				local var_67_35 = var_67_29.localEulerAngles

				var_67_35.z = 0
				var_67_35.x = 0
				var_67_29.localEulerAngles = var_67_35
			end

			if arg_64_1.time_ >= var_67_30 + var_67_31 and arg_64_1.time_ < var_67_30 + var_67_31 + arg_67_0 then
				var_67_29.localPosition = Vector3.New(0, -1.08, -6)

				local var_67_36 = manager.ui.mainCamera.transform.position - var_67_29.position

				var_67_29.forward = Vector3.New(var_67_36.x, var_67_36.y, var_67_36.z)

				local var_67_37 = var_67_29.localEulerAngles

				var_67_37.z = 0
				var_67_37.x = 0
				var_67_29.localEulerAngles = var_67_37
			end

			local var_67_38 = arg_64_1.actors_["1022ui_story"]
			local var_67_39 = 3.8

			if var_67_39 < arg_64_1.time_ and arg_64_1.time_ <= var_67_39 + arg_67_0 and not isNil(var_67_38) and arg_64_1.var_.characterEffect1022ui_story == nil then
				arg_64_1.var_.characterEffect1022ui_story = var_67_38:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_40 = 0.200000002980232

			if var_67_39 <= arg_64_1.time_ and arg_64_1.time_ < var_67_39 + var_67_40 and not isNil(var_67_38) then
				local var_67_41 = (arg_64_1.time_ - var_67_39) / var_67_40

				if arg_64_1.var_.characterEffect1022ui_story and not isNil(var_67_38) then
					arg_64_1.var_.characterEffect1022ui_story.fillFlat = false
				end
			end

			if arg_64_1.time_ >= var_67_39 + var_67_40 and arg_64_1.time_ < var_67_39 + var_67_40 + arg_67_0 and not isNil(var_67_38) and arg_64_1.var_.characterEffect1022ui_story then
				arg_64_1.var_.characterEffect1022ui_story.fillFlat = false
			end

			local var_67_42 = 3.8

			if var_67_42 < arg_64_1.time_ and arg_64_1.time_ <= var_67_42 + arg_67_0 then
				arg_64_1:PlayTimeline("1022ui_story", "StoryTimeline/CharAction/story1022/story1022action/1022action2_1")
			end

			local var_67_43 = 3.8

			if var_67_43 < arg_64_1.time_ and arg_64_1.time_ <= var_67_43 + arg_67_0 then
				arg_64_1:PlayTimeline("1022ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_67_44 = 0.133333333333333
			local var_67_45 = 1

			if var_67_44 < arg_64_1.time_ and arg_64_1.time_ <= var_67_44 + arg_67_0 then
				local var_67_46 = "stop"
				local var_67_47 = "effect"

				arg_64_1:AudioAction(var_67_46, var_67_47, "se_story_side_1020", "se_story_side_1020_amb_office", "")
			end

			local var_67_48 = 1.6
			local var_67_49 = 1

			if var_67_48 < arg_64_1.time_ and arg_64_1.time_ <= var_67_48 + arg_67_0 then
				local var_67_50 = "play"
				local var_67_51 = "effect"

				arg_64_1:AudioAction(var_67_50, var_67_51, "se_story_side_1049", "se_story_side_1049_amb_room", "")
			end

			local var_67_52 = 0.133333333333333
			local var_67_53 = 0.3

			if var_67_52 < arg_64_1.time_ and arg_64_1.time_ <= var_67_52 + arg_67_0 then
				local var_67_54 = "play"
				local var_67_55 = "music"

				arg_64_1:AudioAction(var_67_54, var_67_55, "ui_battle", "ui_battle_stopbgm", "")

				local var_67_56 = ""
				local var_67_57 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_67_57 ~= "" then
					if arg_64_1.bgmTxt_.text ~= var_67_57 and arg_64_1.bgmTxt_.text ~= "" then
						if arg_64_1.bgmTxt2_.text ~= "" then
							arg_64_1.bgmTxt_.text = arg_64_1.bgmTxt2_.text
						end

						arg_64_1.bgmTxt2_.text = var_67_57

						arg_64_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_64_1.bgmTxt_.text = var_67_57
						arg_64_1.bgmTxt2_.text = var_67_57
					end

					if arg_64_1.bgmTimer then
						arg_64_1.bgmTimer:Stop()

						arg_64_1.bgmTimer = nil
					end

					if arg_64_1.settingData.show_music_name == 1 then
						arg_64_1.musicController:SetSelectedState("show")
						arg_64_1.musicAnimator_:Play("open", 0, 0)

						if arg_64_1.settingData.music_time ~= 0 then
							arg_64_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_64_1.settingData.music_time), function()
								if arg_64_1 == nil or isNil(arg_64_1.bgmTxt_) then
									return
								end

								arg_64_1.musicController:SetSelectedState("hide")
								arg_64_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_67_58 = 1.6
			local var_67_59 = 1

			if var_67_58 < arg_64_1.time_ and arg_64_1.time_ <= var_67_58 + arg_67_0 then
				local var_67_60 = "play"
				local var_67_61 = "music"

				arg_64_1:AudioAction(var_67_60, var_67_61, "bgm_side_daily03", "bgm_side_daily03", "bgm_side_daily03.awb")

				local var_67_62 = ""
				local var_67_63 = manager.audio:GetAudioName("bgm_side_daily03", "bgm_side_daily03")

				if var_67_63 ~= "" then
					if arg_64_1.bgmTxt_.text ~= var_67_63 and arg_64_1.bgmTxt_.text ~= "" then
						if arg_64_1.bgmTxt2_.text ~= "" then
							arg_64_1.bgmTxt_.text = arg_64_1.bgmTxt2_.text
						end

						arg_64_1.bgmTxt2_.text = var_67_63

						arg_64_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_64_1.bgmTxt_.text = var_67_63
						arg_64_1.bgmTxt2_.text = var_67_63
					end

					if arg_64_1.bgmTimer then
						arg_64_1.bgmTimer:Stop()

						arg_64_1.bgmTimer = nil
					end

					if arg_64_1.settingData.show_music_name == 1 then
						arg_64_1.musicController:SetSelectedState("show")
						arg_64_1.musicAnimator_:Play("open", 0, 0)

						if arg_64_1.settingData.music_time ~= 0 then
							arg_64_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_64_1.settingData.music_time), function()
								if arg_64_1 == nil or isNil(arg_64_1.bgmTxt_) then
									return
								end

								arg_64_1.musicController:SetSelectedState("hide")
								arg_64_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_64_1.frameCnt_ <= 1 then
				arg_64_1.dialog_:SetActive(false)
			end

			local var_67_64 = 4
			local var_67_65 = 0.4

			if var_67_64 < arg_64_1.time_ and arg_64_1.time_ <= var_67_64 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0

				arg_64_1.dialog_:SetActive(true)

				arg_64_1.dialogCg_.alpha = 0

				local var_67_66 = LeanTween.value(arg_64_1.dialog_, 0, 1, 0.3)

				var_67_66:setOnUpdate(LuaHelper.FloatAction(function(arg_70_0)
					arg_64_1.dialogCg_.alpha = arg_70_0
				end))
				var_67_66:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_64_1.dialog_)
					var_67_66:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_64_1.duration_ = arg_64_1.duration_ + 0.3

				SetActive(arg_64_1.leftNameGo_, true)

				local var_67_67 = arg_64_1:FormatText(StoryNameCfg[259].name)

				arg_64_1.leftNameTxt_.text = var_67_67

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_68 = arg_64_1:GetWordFromCfg(1102205015)
				local var_67_69 = arg_64_1:FormatText(var_67_68.content)

				arg_64_1.text_.text = var_67_69

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_70 = 16
				local var_67_71 = utf8.len(var_67_69)
				local var_67_72 = var_67_70 <= 0 and var_67_65 or var_67_65 * (var_67_71 / var_67_70)

				if var_67_72 > 0 and var_67_65 < var_67_72 then
					arg_64_1.talkMaxDuration = var_67_72
					var_67_64 = var_67_64 + 0.3

					if var_67_72 + var_67_64 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_72 + var_67_64
					end
				end

				arg_64_1.text_.text = var_67_69
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205015", "story_v_side_new_1102205.awb") ~= 0 then
					local var_67_73 = manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205015", "story_v_side_new_1102205.awb") / 1000

					if var_67_73 + var_67_64 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_73 + var_67_64
					end

					if var_67_68.prefab_name ~= "" and arg_64_1.actors_[var_67_68.prefab_name] ~= nil then
						local var_67_74 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_68.prefab_name].transform, "story_v_side_new_1102205", "1102205015", "story_v_side_new_1102205.awb")

						arg_64_1:RecordAudio("1102205015", var_67_74)
						arg_64_1:RecordAudio("1102205015", var_67_74)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_side_new_1102205", "1102205015", "story_v_side_new_1102205.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_side_new_1102205", "1102205015", "story_v_side_new_1102205.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_75 = var_67_64 + 0.3
			local var_67_76 = math.max(var_67_65, arg_64_1.talkMaxDuration)

			if var_67_75 <= arg_64_1.time_ and arg_64_1.time_ < var_67_75 + var_67_76 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_75) / var_67_76

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_75 + var_67_76 and arg_64_1.time_ < var_67_75 + var_67_76 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1022ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_64_1:InitPlayNodeList()
	end,
	Play1102205016 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 1102205016
		arg_72_1.duration_ = 5

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play1102205017(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = arg_72_1.actors_["1022ui_story"].transform
			local var_75_1 = 0

			if var_75_1 < arg_72_1.time_ and arg_72_1.time_ <= var_75_1 + arg_75_0 then
				arg_72_1.var_.moveOldPos1022ui_story = var_75_0.localPosition
			end

			local var_75_2 = 0.001

			if var_75_1 <= arg_72_1.time_ and arg_72_1.time_ < var_75_1 + var_75_2 then
				local var_75_3 = (arg_72_1.time_ - var_75_1) / var_75_2
				local var_75_4 = Vector3.New(0, 100, 0)

				var_75_0.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPos1022ui_story, var_75_4, var_75_3)

				local var_75_5 = manager.ui.mainCamera.transform.position - var_75_0.position

				var_75_0.forward = Vector3.New(var_75_5.x, var_75_5.y, var_75_5.z)

				local var_75_6 = var_75_0.localEulerAngles

				var_75_6.z = 0
				var_75_6.x = 0
				var_75_0.localEulerAngles = var_75_6
			end

			if arg_72_1.time_ >= var_75_1 + var_75_2 and arg_72_1.time_ < var_75_1 + var_75_2 + arg_75_0 then
				var_75_0.localPosition = Vector3.New(0, 100, 0)

				local var_75_7 = manager.ui.mainCamera.transform.position - var_75_0.position

				var_75_0.forward = Vector3.New(var_75_7.x, var_75_7.y, var_75_7.z)

				local var_75_8 = var_75_0.localEulerAngles

				var_75_8.z = 0
				var_75_8.x = 0
				var_75_0.localEulerAngles = var_75_8
			end

			local var_75_9 = arg_72_1.actors_["1022ui_story"]
			local var_75_10 = 0

			if var_75_10 < arg_72_1.time_ and arg_72_1.time_ <= var_75_10 + arg_75_0 and not isNil(var_75_9) and arg_72_1.var_.characterEffect1022ui_story == nil then
				arg_72_1.var_.characterEffect1022ui_story = var_75_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_11 = 0.200000002980232

			if var_75_10 <= arg_72_1.time_ and arg_72_1.time_ < var_75_10 + var_75_11 and not isNil(var_75_9) then
				local var_75_12 = (arg_72_1.time_ - var_75_10) / var_75_11

				if arg_72_1.var_.characterEffect1022ui_story and not isNil(var_75_9) then
					local var_75_13 = Mathf.Lerp(0, 0.5, var_75_12)

					arg_72_1.var_.characterEffect1022ui_story.fillFlat = true
					arg_72_1.var_.characterEffect1022ui_story.fillRatio = var_75_13
				end
			end

			if arg_72_1.time_ >= var_75_10 + var_75_11 and arg_72_1.time_ < var_75_10 + var_75_11 + arg_75_0 and not isNil(var_75_9) and arg_72_1.var_.characterEffect1022ui_story then
				local var_75_14 = 0.5

				arg_72_1.var_.characterEffect1022ui_story.fillFlat = true
				arg_72_1.var_.characterEffect1022ui_story.fillRatio = var_75_14
			end

			local var_75_15 = 0.200000002980232
			local var_75_16 = 1

			if var_75_15 < arg_72_1.time_ and arg_72_1.time_ <= var_75_15 + arg_75_0 then
				local var_75_17 = "play"
				local var_75_18 = "effect"

				arg_72_1:AudioAction(var_75_17, var_75_18, "se_story_139", "se_story_139_bed", "")
			end

			local var_75_19 = 0
			local var_75_20 = 0.8

			if var_75_19 < arg_72_1.time_ and arg_72_1.time_ <= var_75_19 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, false)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_21 = arg_72_1:GetWordFromCfg(1102205016)
				local var_75_22 = arg_72_1:FormatText(var_75_21.content)

				arg_72_1.text_.text = var_75_22

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_23 = 32
				local var_75_24 = utf8.len(var_75_22)
				local var_75_25 = var_75_23 <= 0 and var_75_20 or var_75_20 * (var_75_24 / var_75_23)

				if var_75_25 > 0 and var_75_20 < var_75_25 then
					arg_72_1.talkMaxDuration = var_75_25

					if var_75_25 + var_75_19 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_25 + var_75_19
					end
				end

				arg_72_1.text_.text = var_75_22
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)
				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_26 = math.max(var_75_20, arg_72_1.talkMaxDuration)

			if var_75_19 <= arg_72_1.time_ and arg_72_1.time_ < var_75_19 + var_75_26 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_19) / var_75_26

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_19 + var_75_26 and arg_72_1.time_ < var_75_19 + var_75_26 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1022ui_story",
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
	Play1102205017 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 1102205017
		arg_76_1.duration_ = 5

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play1102205018(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = 0
			local var_79_1 = 0.75

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

				arg_76_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_76_1.callingController_:SetSelectedState("normal")

				arg_76_1.keyicon_.color = Color.New(1, 1, 1)
				arg_76_1.icon_.color = Color.New(1, 1, 1)

				local var_79_3 = arg_76_1:GetWordFromCfg(1102205017)
				local var_79_4 = arg_76_1:FormatText(var_79_3.content)

				arg_76_1.text_.text = var_79_4

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_5 = 30
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
	Play1102205018 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 1102205018
		arg_80_1.duration_ = 5

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play1102205019(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = 0

			if var_83_0 < arg_80_1.time_ and arg_80_1.time_ <= var_83_0 + arg_83_0 then
				arg_80_1:PlayTimeline("1022ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_83_1 = 0
			local var_83_2 = 0.925

			if var_83_1 < arg_80_1.time_ and arg_80_1.time_ <= var_83_1 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, false)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_3 = arg_80_1:GetWordFromCfg(1102205018)
				local var_83_4 = arg_80_1:FormatText(var_83_3.content)

				arg_80_1.text_.text = var_83_4

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_5 = 37
				local var_83_6 = utf8.len(var_83_4)
				local var_83_7 = var_83_5 <= 0 and var_83_2 or var_83_2 * (var_83_6 / var_83_5)

				if var_83_7 > 0 and var_83_2 < var_83_7 then
					arg_80_1.talkMaxDuration = var_83_7

					if var_83_7 + var_83_1 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_7 + var_83_1
					end
				end

				arg_80_1.text_.text = var_83_4
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)
				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_8 = math.max(var_83_2, arg_80_1.talkMaxDuration)

			if var_83_1 <= arg_80_1.time_ and arg_80_1.time_ < var_83_1 + var_83_8 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_1) / var_83_8

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_1 + var_83_8 and arg_80_1.time_ < var_83_1 + var_83_8 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {}

		arg_80_1:InitPlayNodeList()
	end,
	Play1102205019 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 1102205019
		arg_84_1.duration_ = 11.7

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play1102205020(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = arg_84_1.actors_["1022ui_story"].transform
			local var_87_1 = 0

			if var_87_1 < arg_84_1.time_ and arg_84_1.time_ <= var_87_1 + arg_87_0 then
				arg_84_1.var_.moveOldPos1022ui_story = var_87_0.localPosition
			end

			local var_87_2 = 0.001

			if var_87_1 <= arg_84_1.time_ and arg_84_1.time_ < var_87_1 + var_87_2 then
				local var_87_3 = (arg_84_1.time_ - var_87_1) / var_87_2
				local var_87_4 = Vector3.New(0, -1.08, -6)

				var_87_0.localPosition = Vector3.Lerp(arg_84_1.var_.moveOldPos1022ui_story, var_87_4, var_87_3)

				local var_87_5 = manager.ui.mainCamera.transform.position - var_87_0.position

				var_87_0.forward = Vector3.New(var_87_5.x, var_87_5.y, var_87_5.z)

				local var_87_6 = var_87_0.localEulerAngles

				var_87_6.z = 0
				var_87_6.x = 0
				var_87_0.localEulerAngles = var_87_6
			end

			if arg_84_1.time_ >= var_87_1 + var_87_2 and arg_84_1.time_ < var_87_1 + var_87_2 + arg_87_0 then
				var_87_0.localPosition = Vector3.New(0, -1.08, -6)

				local var_87_7 = manager.ui.mainCamera.transform.position - var_87_0.position

				var_87_0.forward = Vector3.New(var_87_7.x, var_87_7.y, var_87_7.z)

				local var_87_8 = var_87_0.localEulerAngles

				var_87_8.z = 0
				var_87_8.x = 0
				var_87_0.localEulerAngles = var_87_8
			end

			local var_87_9 = arg_84_1.actors_["1022ui_story"]
			local var_87_10 = 0

			if var_87_10 < arg_84_1.time_ and arg_84_1.time_ <= var_87_10 + arg_87_0 and not isNil(var_87_9) and arg_84_1.var_.characterEffect1022ui_story == nil then
				arg_84_1.var_.characterEffect1022ui_story = var_87_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_11 = 0.200000002980232

			if var_87_10 <= arg_84_1.time_ and arg_84_1.time_ < var_87_10 + var_87_11 and not isNil(var_87_9) then
				local var_87_12 = (arg_84_1.time_ - var_87_10) / var_87_11

				if arg_84_1.var_.characterEffect1022ui_story and not isNil(var_87_9) then
					arg_84_1.var_.characterEffect1022ui_story.fillFlat = false
				end
			end

			if arg_84_1.time_ >= var_87_10 + var_87_11 and arg_84_1.time_ < var_87_10 + var_87_11 + arg_87_0 and not isNil(var_87_9) and arg_84_1.var_.characterEffect1022ui_story then
				arg_84_1.var_.characterEffect1022ui_story.fillFlat = false
			end

			local var_87_13 = 0

			if var_87_13 < arg_84_1.time_ and arg_84_1.time_ <= var_87_13 + arg_87_0 then
				arg_84_1:PlayTimeline("1022ui_story", "StoryTimeline/CharAction/story1022/story1022action/1022action2_2")
			end

			local var_87_14 = 0

			if var_87_14 < arg_84_1.time_ and arg_84_1.time_ <= var_87_14 + arg_87_0 then
				arg_84_1:PlayTimeline("1022ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_87_15 = 0
			local var_87_16 = 1.15

			if var_87_15 < arg_84_1.time_ and arg_84_1.time_ <= var_87_15 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				local var_87_17 = arg_84_1:FormatText(StoryNameCfg[259].name)

				arg_84_1.leftNameTxt_.text = var_87_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_18 = arg_84_1:GetWordFromCfg(1102205019)
				local var_87_19 = arg_84_1:FormatText(var_87_18.content)

				arg_84_1.text_.text = var_87_19

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_20 = 46
				local var_87_21 = utf8.len(var_87_19)
				local var_87_22 = var_87_20 <= 0 and var_87_16 or var_87_16 * (var_87_21 / var_87_20)

				if var_87_22 > 0 and var_87_16 < var_87_22 then
					arg_84_1.talkMaxDuration = var_87_22

					if var_87_22 + var_87_15 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_22 + var_87_15
					end
				end

				arg_84_1.text_.text = var_87_19
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205019", "story_v_side_new_1102205.awb") ~= 0 then
					local var_87_23 = manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205019", "story_v_side_new_1102205.awb") / 1000

					if var_87_23 + var_87_15 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_23 + var_87_15
					end

					if var_87_18.prefab_name ~= "" and arg_84_1.actors_[var_87_18.prefab_name] ~= nil then
						local var_87_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_18.prefab_name].transform, "story_v_side_new_1102205", "1102205019", "story_v_side_new_1102205.awb")

						arg_84_1:RecordAudio("1102205019", var_87_24)
						arg_84_1:RecordAudio("1102205019", var_87_24)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_side_new_1102205", "1102205019", "story_v_side_new_1102205.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_side_new_1102205", "1102205019", "story_v_side_new_1102205.awb")
				end

				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_25 = math.max(var_87_16, arg_84_1.talkMaxDuration)

			if var_87_15 <= arg_84_1.time_ and arg_84_1.time_ < var_87_15 + var_87_25 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_15) / var_87_25

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_15 + var_87_25 and arg_84_1.time_ < var_87_15 + var_87_25 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1022ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_84_1:InitPlayNodeList()
	end,
	Play1102205020 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 1102205020
		arg_88_1.duration_ = 5

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play1102205021(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = arg_88_1.actors_["1022ui_story"]
			local var_91_1 = 0

			if var_91_1 < arg_88_1.time_ and arg_88_1.time_ <= var_91_1 + arg_91_0 and not isNil(var_91_0) and arg_88_1.var_.characterEffect1022ui_story == nil then
				arg_88_1.var_.characterEffect1022ui_story = var_91_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_2 = 0.200000002980232

			if var_91_1 <= arg_88_1.time_ and arg_88_1.time_ < var_91_1 + var_91_2 and not isNil(var_91_0) then
				local var_91_3 = (arg_88_1.time_ - var_91_1) / var_91_2

				if arg_88_1.var_.characterEffect1022ui_story and not isNil(var_91_0) then
					local var_91_4 = Mathf.Lerp(0, 0.5, var_91_3)

					arg_88_1.var_.characterEffect1022ui_story.fillFlat = true
					arg_88_1.var_.characterEffect1022ui_story.fillRatio = var_91_4
				end
			end

			if arg_88_1.time_ >= var_91_1 + var_91_2 and arg_88_1.time_ < var_91_1 + var_91_2 + arg_91_0 and not isNil(var_91_0) and arg_88_1.var_.characterEffect1022ui_story then
				local var_91_5 = 0.5

				arg_88_1.var_.characterEffect1022ui_story.fillFlat = true
				arg_88_1.var_.characterEffect1022ui_story.fillRatio = var_91_5
			end

			local var_91_6 = 0
			local var_91_7 = 0.675

			if var_91_6 < arg_88_1.time_ and arg_88_1.time_ <= var_91_6 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				local var_91_8 = arg_88_1:FormatText(StoryNameCfg[7].name)

				arg_88_1.leftNameTxt_.text = var_91_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, true)
				arg_88_1.iconController_:SetSelectedState("hero")

				arg_88_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_88_1.callingController_:SetSelectedState("normal")

				arg_88_1.keyicon_.color = Color.New(1, 1, 1)
				arg_88_1.icon_.color = Color.New(1, 1, 1)

				local var_91_9 = arg_88_1:GetWordFromCfg(1102205020)
				local var_91_10 = arg_88_1:FormatText(var_91_9.content)

				arg_88_1.text_.text = var_91_10

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_11 = 27
				local var_91_12 = utf8.len(var_91_10)
				local var_91_13 = var_91_11 <= 0 and var_91_7 or var_91_7 * (var_91_12 / var_91_11)

				if var_91_13 > 0 and var_91_7 < var_91_13 then
					arg_88_1.talkMaxDuration = var_91_13

					if var_91_13 + var_91_6 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_13 + var_91_6
					end
				end

				arg_88_1.text_.text = var_91_10
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)
				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_14 = math.max(var_91_7, arg_88_1.talkMaxDuration)

			if var_91_6 <= arg_88_1.time_ and arg_88_1.time_ < var_91_6 + var_91_14 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_6) / var_91_14

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_6 + var_91_14 and arg_88_1.time_ < var_91_6 + var_91_14 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {}

		arg_88_1:InitPlayNodeList()
	end,
	Play1102205021 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 1102205021
		arg_92_1.duration_ = 1.33

		SetActive(arg_92_1.tipsGo_, false)

		function arg_92_1.onSingleLineFinish_()
			arg_92_1.onSingleLineUpdate_ = nil
			arg_92_1.onSingleLineFinish_ = nil
			arg_92_1.state_ = "waiting"
		end

		function arg_92_1.playNext_(arg_94_0)
			if arg_94_0 == 1 then
				arg_92_0:Play1102205022(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			local var_95_0 = arg_92_1.actors_["1022ui_story"]
			local var_95_1 = 0

			if var_95_1 < arg_92_1.time_ and arg_92_1.time_ <= var_95_1 + arg_95_0 and not isNil(var_95_0) and arg_92_1.var_.characterEffect1022ui_story == nil then
				arg_92_1.var_.characterEffect1022ui_story = var_95_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_2 = 0.200000002980232

			if var_95_1 <= arg_92_1.time_ and arg_92_1.time_ < var_95_1 + var_95_2 and not isNil(var_95_0) then
				local var_95_3 = (arg_92_1.time_ - var_95_1) / var_95_2

				if arg_92_1.var_.characterEffect1022ui_story and not isNil(var_95_0) then
					arg_92_1.var_.characterEffect1022ui_story.fillFlat = false
				end
			end

			if arg_92_1.time_ >= var_95_1 + var_95_2 and arg_92_1.time_ < var_95_1 + var_95_2 + arg_95_0 and not isNil(var_95_0) and arg_92_1.var_.characterEffect1022ui_story then
				arg_92_1.var_.characterEffect1022ui_story.fillFlat = false
			end

			local var_95_4 = 0
			local var_95_5 = 0.075

			if var_95_4 < arg_92_1.time_ and arg_92_1.time_ <= var_95_4 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				local var_95_6 = arg_92_1:FormatText(StoryNameCfg[259].name)

				arg_92_1.leftNameTxt_.text = var_95_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_7 = arg_92_1:GetWordFromCfg(1102205021)
				local var_95_8 = arg_92_1:FormatText(var_95_7.content)

				arg_92_1.text_.text = var_95_8

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_9 = 3
				local var_95_10 = utf8.len(var_95_8)
				local var_95_11 = var_95_9 <= 0 and var_95_5 or var_95_5 * (var_95_10 / var_95_9)

				if var_95_11 > 0 and var_95_5 < var_95_11 then
					arg_92_1.talkMaxDuration = var_95_11

					if var_95_11 + var_95_4 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_11 + var_95_4
					end
				end

				arg_92_1.text_.text = var_95_8
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205021", "story_v_side_new_1102205.awb") ~= 0 then
					local var_95_12 = manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205021", "story_v_side_new_1102205.awb") / 1000

					if var_95_12 + var_95_4 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_12 + var_95_4
					end

					if var_95_7.prefab_name ~= "" and arg_92_1.actors_[var_95_7.prefab_name] ~= nil then
						local var_95_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_7.prefab_name].transform, "story_v_side_new_1102205", "1102205021", "story_v_side_new_1102205.awb")

						arg_92_1:RecordAudio("1102205021", var_95_13)
						arg_92_1:RecordAudio("1102205021", var_95_13)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_side_new_1102205", "1102205021", "story_v_side_new_1102205.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_side_new_1102205", "1102205021", "story_v_side_new_1102205.awb")
				end

				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_14 = math.max(var_95_5, arg_92_1.talkMaxDuration)

			if var_95_4 <= arg_92_1.time_ and arg_92_1.time_ < var_95_4 + var_95_14 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_4) / var_95_14

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_4 + var_95_14 and arg_92_1.time_ < var_95_4 + var_95_14 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {}

		arg_92_1:InitPlayNodeList()
	end,
	Play1102205022 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 1102205022
		arg_96_1.duration_ = 5

		SetActive(arg_96_1.tipsGo_, false)

		function arg_96_1.onSingleLineFinish_()
			arg_96_1.onSingleLineUpdate_ = nil
			arg_96_1.onSingleLineFinish_ = nil
			arg_96_1.state_ = "waiting"
		end

		function arg_96_1.playNext_(arg_98_0)
			if arg_98_0 == 1 then
				arg_96_0:Play1102205023(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			local var_99_0 = arg_96_1.actors_["1022ui_story"]
			local var_99_1 = 0

			if var_99_1 < arg_96_1.time_ and arg_96_1.time_ <= var_99_1 + arg_99_0 and not isNil(var_99_0) and arg_96_1.var_.characterEffect1022ui_story == nil then
				arg_96_1.var_.characterEffect1022ui_story = var_99_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_2 = 0.200000002980232

			if var_99_1 <= arg_96_1.time_ and arg_96_1.time_ < var_99_1 + var_99_2 and not isNil(var_99_0) then
				local var_99_3 = (arg_96_1.time_ - var_99_1) / var_99_2

				if arg_96_1.var_.characterEffect1022ui_story and not isNil(var_99_0) then
					local var_99_4 = Mathf.Lerp(0, 0.5, var_99_3)

					arg_96_1.var_.characterEffect1022ui_story.fillFlat = true
					arg_96_1.var_.characterEffect1022ui_story.fillRatio = var_99_4
				end
			end

			if arg_96_1.time_ >= var_99_1 + var_99_2 and arg_96_1.time_ < var_99_1 + var_99_2 + arg_99_0 and not isNil(var_99_0) and arg_96_1.var_.characterEffect1022ui_story then
				local var_99_5 = 0.5

				arg_96_1.var_.characterEffect1022ui_story.fillFlat = true
				arg_96_1.var_.characterEffect1022ui_story.fillRatio = var_99_5
			end

			local var_99_6 = 0
			local var_99_7 = 0.775

			if var_99_6 < arg_96_1.time_ and arg_96_1.time_ <= var_99_6 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				local var_99_8 = arg_96_1:FormatText(StoryNameCfg[7].name)

				arg_96_1.leftNameTxt_.text = var_99_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, true)
				arg_96_1.iconController_:SetSelectedState("hero")

				arg_96_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_96_1.callingController_:SetSelectedState("normal")

				arg_96_1.keyicon_.color = Color.New(1, 1, 1)
				arg_96_1.icon_.color = Color.New(1, 1, 1)

				local var_99_9 = arg_96_1:GetWordFromCfg(1102205022)
				local var_99_10 = arg_96_1:FormatText(var_99_9.content)

				arg_96_1.text_.text = var_99_10

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_11 = 31
				local var_99_12 = utf8.len(var_99_10)
				local var_99_13 = var_99_11 <= 0 and var_99_7 or var_99_7 * (var_99_12 / var_99_11)

				if var_99_13 > 0 and var_99_7 < var_99_13 then
					arg_96_1.talkMaxDuration = var_99_13

					if var_99_13 + var_99_6 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_13 + var_99_6
					end
				end

				arg_96_1.text_.text = var_99_10
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)
				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_14 = math.max(var_99_7, arg_96_1.talkMaxDuration)

			if var_99_6 <= arg_96_1.time_ and arg_96_1.time_ < var_99_6 + var_99_14 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_6) / var_99_14

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_6 + var_99_14 and arg_96_1.time_ < var_99_6 + var_99_14 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {}

		arg_96_1:InitPlayNodeList()
	end,
	Play1102205023 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 1102205023
		arg_100_1.duration_ = 1

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"

			SetActive(arg_100_1.choicesGo_, true)

			for iter_101_0, iter_101_1 in ipairs(arg_100_1.choices_) do
				local var_101_0 = iter_101_0 <= 1

				SetActive(iter_101_1.go, var_101_0)
			end

			arg_100_1.choices_[1].txt.text = arg_100_1:FormatText(StoryChoiceCfg[1466].name)
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play1102205024(arg_100_1)
			end

			arg_100_1:RecordChoiceLog(1102205023, 1466)
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			return
		end

		arg_100_1.nodeConfigList_ = {}

		arg_100_1:InitPlayNodeList()
	end,
	Play1102205024 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 1102205024
		arg_104_1.duration_ = 5

		SetActive(arg_104_1.tipsGo_, false)

		function arg_104_1.onSingleLineFinish_()
			arg_104_1.onSingleLineUpdate_ = nil
			arg_104_1.onSingleLineFinish_ = nil
			arg_104_1.state_ = "waiting"
		end

		function arg_104_1.playNext_(arg_106_0)
			if arg_106_0 == 1 then
				arg_104_0:Play1102205025(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			local var_107_0 = 0
			local var_107_1 = 0.725

			if var_107_0 < arg_104_1.time_ and arg_104_1.time_ <= var_107_0 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, false)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_2 = arg_104_1:GetWordFromCfg(1102205024)
				local var_107_3 = arg_104_1:FormatText(var_107_2.content)

				arg_104_1.text_.text = var_107_3

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_4 = 29
				local var_107_5 = utf8.len(var_107_3)
				local var_107_6 = var_107_4 <= 0 and var_107_1 or var_107_1 * (var_107_5 / var_107_4)

				if var_107_6 > 0 and var_107_1 < var_107_6 then
					arg_104_1.talkMaxDuration = var_107_6

					if var_107_6 + var_107_0 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_6 + var_107_0
					end
				end

				arg_104_1.text_.text = var_107_3
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)
				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_7 = math.max(var_107_1, arg_104_1.talkMaxDuration)

			if var_107_0 <= arg_104_1.time_ and arg_104_1.time_ < var_107_0 + var_107_7 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_0) / var_107_7

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_0 + var_107_7 and arg_104_1.time_ < var_107_0 + var_107_7 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {}

		arg_104_1:InitPlayNodeList()
	end,
	Play1102205025 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 1102205025
		arg_108_1.duration_ = 7.7

		SetActive(arg_108_1.tipsGo_, false)

		function arg_108_1.onSingleLineFinish_()
			arg_108_1.onSingleLineUpdate_ = nil
			arg_108_1.onSingleLineFinish_ = nil
			arg_108_1.state_ = "waiting"
		end

		function arg_108_1.playNext_(arg_110_0)
			if arg_110_0 == 1 then
				arg_108_0:Play1102205026(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			local var_111_0 = arg_108_1.actors_["1022ui_story"]
			local var_111_1 = 0

			if var_111_1 < arg_108_1.time_ and arg_108_1.time_ <= var_111_1 + arg_111_0 and not isNil(var_111_0) and arg_108_1.var_.characterEffect1022ui_story == nil then
				arg_108_1.var_.characterEffect1022ui_story = var_111_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_111_2 = 0.200000002980232

			if var_111_1 <= arg_108_1.time_ and arg_108_1.time_ < var_111_1 + var_111_2 and not isNil(var_111_0) then
				local var_111_3 = (arg_108_1.time_ - var_111_1) / var_111_2

				if arg_108_1.var_.characterEffect1022ui_story and not isNil(var_111_0) then
					arg_108_1.var_.characterEffect1022ui_story.fillFlat = false
				end
			end

			if arg_108_1.time_ >= var_111_1 + var_111_2 and arg_108_1.time_ < var_111_1 + var_111_2 + arg_111_0 and not isNil(var_111_0) and arg_108_1.var_.characterEffect1022ui_story then
				arg_108_1.var_.characterEffect1022ui_story.fillFlat = false
			end

			local var_111_4 = 0

			if var_111_4 < arg_108_1.time_ and arg_108_1.time_ <= var_111_4 + arg_111_0 then
				arg_108_1:PlayTimeline("1022ui_story", "StoryTimeline/CharAction/story1022/story1022action/1022action5_1")
			end

			local var_111_5 = 0

			if var_111_5 < arg_108_1.time_ and arg_108_1.time_ <= var_111_5 + arg_111_0 then
				arg_108_1:PlayTimeline("1022ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_111_6 = 0
			local var_111_7 = 0.65

			if var_111_6 < arg_108_1.time_ and arg_108_1.time_ <= var_111_6 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				local var_111_8 = arg_108_1:FormatText(StoryNameCfg[259].name)

				arg_108_1.leftNameTxt_.text = var_111_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_9 = arg_108_1:GetWordFromCfg(1102205025)
				local var_111_10 = arg_108_1:FormatText(var_111_9.content)

				arg_108_1.text_.text = var_111_10

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_11 = 26
				local var_111_12 = utf8.len(var_111_10)
				local var_111_13 = var_111_11 <= 0 and var_111_7 or var_111_7 * (var_111_12 / var_111_11)

				if var_111_13 > 0 and var_111_7 < var_111_13 then
					arg_108_1.talkMaxDuration = var_111_13

					if var_111_13 + var_111_6 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_13 + var_111_6
					end
				end

				arg_108_1.text_.text = var_111_10
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205025", "story_v_side_new_1102205.awb") ~= 0 then
					local var_111_14 = manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205025", "story_v_side_new_1102205.awb") / 1000

					if var_111_14 + var_111_6 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_14 + var_111_6
					end

					if var_111_9.prefab_name ~= "" and arg_108_1.actors_[var_111_9.prefab_name] ~= nil then
						local var_111_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_108_1.actors_[var_111_9.prefab_name].transform, "story_v_side_new_1102205", "1102205025", "story_v_side_new_1102205.awb")

						arg_108_1:RecordAudio("1102205025", var_111_15)
						arg_108_1:RecordAudio("1102205025", var_111_15)
					else
						arg_108_1:AudioAction("play", "voice", "story_v_side_new_1102205", "1102205025", "story_v_side_new_1102205.awb")
					end

					arg_108_1:RecordHistoryTalkVoice("story_v_side_new_1102205", "1102205025", "story_v_side_new_1102205.awb")
				end

				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_16 = math.max(var_111_7, arg_108_1.talkMaxDuration)

			if var_111_6 <= arg_108_1.time_ and arg_108_1.time_ < var_111_6 + var_111_16 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_6) / var_111_16

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_6 + var_111_16 and arg_108_1.time_ < var_111_6 + var_111_16 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {}

		arg_108_1:InitPlayNodeList()
	end,
	Play1102205026 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 1102205026
		arg_112_1.duration_ = 5

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
		end

		function arg_112_1.playNext_(arg_114_0)
			if arg_114_0 == 1 then
				arg_112_0:Play1102205027(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			local var_115_0 = arg_112_1.actors_["1022ui_story"]
			local var_115_1 = 0

			if var_115_1 < arg_112_1.time_ and arg_112_1.time_ <= var_115_1 + arg_115_0 and not isNil(var_115_0) and arg_112_1.var_.characterEffect1022ui_story == nil then
				arg_112_1.var_.characterEffect1022ui_story = var_115_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_115_2 = 0.200000002980232

			if var_115_1 <= arg_112_1.time_ and arg_112_1.time_ < var_115_1 + var_115_2 and not isNil(var_115_0) then
				local var_115_3 = (arg_112_1.time_ - var_115_1) / var_115_2

				if arg_112_1.var_.characterEffect1022ui_story and not isNil(var_115_0) then
					local var_115_4 = Mathf.Lerp(0, 0.5, var_115_3)

					arg_112_1.var_.characterEffect1022ui_story.fillFlat = true
					arg_112_1.var_.characterEffect1022ui_story.fillRatio = var_115_4
				end
			end

			if arg_112_1.time_ >= var_115_1 + var_115_2 and arg_112_1.time_ < var_115_1 + var_115_2 + arg_115_0 and not isNil(var_115_0) and arg_112_1.var_.characterEffect1022ui_story then
				local var_115_5 = 0.5

				arg_112_1.var_.characterEffect1022ui_story.fillFlat = true
				arg_112_1.var_.characterEffect1022ui_story.fillRatio = var_115_5
			end

			local var_115_6 = 0.0500000000000001
			local var_115_7 = 1

			if var_115_6 < arg_112_1.time_ and arg_112_1.time_ <= var_115_6 + arg_115_0 then
				local var_115_8 = "play"
				local var_115_9 = "effect"

				arg_112_1:AudioAction(var_115_8, var_115_9, "se_story_side_1022", "se_story_side_1022_foley_situp", "")
			end

			local var_115_10 = 0
			local var_115_11 = 1.05

			if var_115_10 < arg_112_1.time_ and arg_112_1.time_ <= var_115_10 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, false)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_12 = arg_112_1:GetWordFromCfg(1102205026)
				local var_115_13 = arg_112_1:FormatText(var_115_12.content)

				arg_112_1.text_.text = var_115_13

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_14 = 42
				local var_115_15 = utf8.len(var_115_13)
				local var_115_16 = var_115_14 <= 0 and var_115_11 or var_115_11 * (var_115_15 / var_115_14)

				if var_115_16 > 0 and var_115_11 < var_115_16 then
					arg_112_1.talkMaxDuration = var_115_16

					if var_115_16 + var_115_10 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_16 + var_115_10
					end
				end

				arg_112_1.text_.text = var_115_13
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)
				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_17 = math.max(var_115_11, arg_112_1.talkMaxDuration)

			if var_115_10 <= arg_112_1.time_ and arg_112_1.time_ < var_115_10 + var_115_17 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_10) / var_115_17

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_10 + var_115_17 and arg_112_1.time_ < var_115_10 + var_115_17 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {}

		arg_112_1:InitPlayNodeList()
	end,
	Play1102205027 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 1102205027
		arg_116_1.duration_ = 5

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play1102205028(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			local var_119_0 = 0
			local var_119_1 = 0.525

			if var_119_0 < arg_116_1.time_ and arg_116_1.time_ <= var_119_0 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				local var_119_2 = arg_116_1:FormatText(StoryNameCfg[7].name)

				arg_116_1.leftNameTxt_.text = var_119_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, true)
				arg_116_1.iconController_:SetSelectedState("hero")

				arg_116_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_116_1.callingController_:SetSelectedState("normal")

				arg_116_1.keyicon_.color = Color.New(1, 1, 1)
				arg_116_1.icon_.color = Color.New(1, 1, 1)

				local var_119_3 = arg_116_1:GetWordFromCfg(1102205027)
				local var_119_4 = arg_116_1:FormatText(var_119_3.content)

				arg_116_1.text_.text = var_119_4

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_5 = 21
				local var_119_6 = utf8.len(var_119_4)
				local var_119_7 = var_119_5 <= 0 and var_119_1 or var_119_1 * (var_119_6 / var_119_5)

				if var_119_7 > 0 and var_119_1 < var_119_7 then
					arg_116_1.talkMaxDuration = var_119_7

					if var_119_7 + var_119_0 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_7 + var_119_0
					end
				end

				arg_116_1.text_.text = var_119_4
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)
				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_8 = math.max(var_119_1, arg_116_1.talkMaxDuration)

			if var_119_0 <= arg_116_1.time_ and arg_116_1.time_ < var_119_0 + var_119_8 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_0) / var_119_8

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_0 + var_119_8 and arg_116_1.time_ < var_119_0 + var_119_8 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {}

		arg_116_1:InitPlayNodeList()
	end,
	Play1102205028 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 1102205028
		arg_120_1.duration_ = 6.93

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"
		end

		function arg_120_1.playNext_(arg_122_0)
			if arg_122_0 == 1 then
				arg_120_0:Play1102205029(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			local var_123_0 = arg_120_1.actors_["1022ui_story"]
			local var_123_1 = 0

			if var_123_1 < arg_120_1.time_ and arg_120_1.time_ <= var_123_1 + arg_123_0 and not isNil(var_123_0) and arg_120_1.var_.characterEffect1022ui_story == nil then
				arg_120_1.var_.characterEffect1022ui_story = var_123_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_123_2 = 0.200000002980232

			if var_123_1 <= arg_120_1.time_ and arg_120_1.time_ < var_123_1 + var_123_2 and not isNil(var_123_0) then
				local var_123_3 = (arg_120_1.time_ - var_123_1) / var_123_2

				if arg_120_1.var_.characterEffect1022ui_story and not isNil(var_123_0) then
					arg_120_1.var_.characterEffect1022ui_story.fillFlat = false
				end
			end

			if arg_120_1.time_ >= var_123_1 + var_123_2 and arg_120_1.time_ < var_123_1 + var_123_2 + arg_123_0 and not isNil(var_123_0) and arg_120_1.var_.characterEffect1022ui_story then
				arg_120_1.var_.characterEffect1022ui_story.fillFlat = false
			end

			local var_123_4 = 0

			if var_123_4 < arg_120_1.time_ and arg_120_1.time_ <= var_123_4 + arg_123_0 then
				arg_120_1:PlayTimeline("1022ui_story", "StoryTimeline/CharAction/story1022/story1022actionlink/1022action453")
			end

			local var_123_5 = 0

			if var_123_5 < arg_120_1.time_ and arg_120_1.time_ <= var_123_5 + arg_123_0 then
				arg_120_1:PlayTimeline("1022ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_123_6 = 0
			local var_123_7 = 0.875

			if var_123_6 < arg_120_1.time_ and arg_120_1.time_ <= var_123_6 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				local var_123_8 = arg_120_1:FormatText(StoryNameCfg[259].name)

				arg_120_1.leftNameTxt_.text = var_123_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_9 = arg_120_1:GetWordFromCfg(1102205028)
				local var_123_10 = arg_120_1:FormatText(var_123_9.content)

				arg_120_1.text_.text = var_123_10

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_11 = 35
				local var_123_12 = utf8.len(var_123_10)
				local var_123_13 = var_123_11 <= 0 and var_123_7 or var_123_7 * (var_123_12 / var_123_11)

				if var_123_13 > 0 and var_123_7 < var_123_13 then
					arg_120_1.talkMaxDuration = var_123_13

					if var_123_13 + var_123_6 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_13 + var_123_6
					end
				end

				arg_120_1.text_.text = var_123_10
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205028", "story_v_side_new_1102205.awb") ~= 0 then
					local var_123_14 = manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205028", "story_v_side_new_1102205.awb") / 1000

					if var_123_14 + var_123_6 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_14 + var_123_6
					end

					if var_123_9.prefab_name ~= "" and arg_120_1.actors_[var_123_9.prefab_name] ~= nil then
						local var_123_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_120_1.actors_[var_123_9.prefab_name].transform, "story_v_side_new_1102205", "1102205028", "story_v_side_new_1102205.awb")

						arg_120_1:RecordAudio("1102205028", var_123_15)
						arg_120_1:RecordAudio("1102205028", var_123_15)
					else
						arg_120_1:AudioAction("play", "voice", "story_v_side_new_1102205", "1102205028", "story_v_side_new_1102205.awb")
					end

					arg_120_1:RecordHistoryTalkVoice("story_v_side_new_1102205", "1102205028", "story_v_side_new_1102205.awb")
				end

				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_16 = math.max(var_123_7, arg_120_1.talkMaxDuration)

			if var_123_6 <= arg_120_1.time_ and arg_120_1.time_ < var_123_6 + var_123_16 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_6) / var_123_16

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_6 + var_123_16 and arg_120_1.time_ < var_123_6 + var_123_16 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {}

		arg_120_1:InitPlayNodeList()
	end,
	Play1102205029 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 1102205029
		arg_124_1.duration_ = 5

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play1102205030(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			local var_127_0 = 0
			local var_127_1 = 0.625

			if var_127_0 < arg_124_1.time_ and arg_124_1.time_ <= var_127_0 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				local var_127_2 = arg_124_1:FormatText(StoryNameCfg[259].name)

				arg_124_1.leftNameTxt_.text = var_127_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_3 = arg_124_1:GetWordFromCfg(1102205029)
				local var_127_4 = arg_124_1:FormatText(var_127_3.content)

				arg_124_1.text_.text = var_127_4

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_5 = 25
				local var_127_6 = utf8.len(var_127_4)
				local var_127_7 = var_127_5 <= 0 and var_127_1 or var_127_1 * (var_127_6 / var_127_5)

				if var_127_7 > 0 and var_127_1 < var_127_7 then
					arg_124_1.talkMaxDuration = var_127_7

					if var_127_7 + var_127_0 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_7 + var_127_0
					end
				end

				arg_124_1.text_.text = var_127_4
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205029", "story_v_side_new_1102205.awb") ~= 0 then
					local var_127_8 = manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205029", "story_v_side_new_1102205.awb") / 1000

					if var_127_8 + var_127_0 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_8 + var_127_0
					end

					if var_127_3.prefab_name ~= "" and arg_124_1.actors_[var_127_3.prefab_name] ~= nil then
						local var_127_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_124_1.actors_[var_127_3.prefab_name].transform, "story_v_side_new_1102205", "1102205029", "story_v_side_new_1102205.awb")

						arg_124_1:RecordAudio("1102205029", var_127_9)
						arg_124_1:RecordAudio("1102205029", var_127_9)
					else
						arg_124_1:AudioAction("play", "voice", "story_v_side_new_1102205", "1102205029", "story_v_side_new_1102205.awb")
					end

					arg_124_1:RecordHistoryTalkVoice("story_v_side_new_1102205", "1102205029", "story_v_side_new_1102205.awb")
				end

				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_10 = math.max(var_127_1, arg_124_1.talkMaxDuration)

			if var_127_0 <= arg_124_1.time_ and arg_124_1.time_ < var_127_0 + var_127_10 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_0) / var_127_10

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_0 + var_127_10 and arg_124_1.time_ < var_127_0 + var_127_10 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {}

		arg_124_1:InitPlayNodeList()
	end,
	Play1102205030 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 1102205030
		arg_128_1.duration_ = 5

		SetActive(arg_128_1.tipsGo_, false)

		function arg_128_1.onSingleLineFinish_()
			arg_128_1.onSingleLineUpdate_ = nil
			arg_128_1.onSingleLineFinish_ = nil
			arg_128_1.state_ = "waiting"
		end

		function arg_128_1.playNext_(arg_130_0)
			if arg_130_0 == 1 then
				arg_128_0:Play1102205031(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			local var_131_0 = arg_128_1.actors_["1022ui_story"]
			local var_131_1 = 0

			if var_131_1 < arg_128_1.time_ and arg_128_1.time_ <= var_131_1 + arg_131_0 and not isNil(var_131_0) and arg_128_1.var_.characterEffect1022ui_story == nil then
				arg_128_1.var_.characterEffect1022ui_story = var_131_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_131_2 = 0.200000002980232

			if var_131_1 <= arg_128_1.time_ and arg_128_1.time_ < var_131_1 + var_131_2 and not isNil(var_131_0) then
				local var_131_3 = (arg_128_1.time_ - var_131_1) / var_131_2

				if arg_128_1.var_.characterEffect1022ui_story and not isNil(var_131_0) then
					local var_131_4 = Mathf.Lerp(0, 0.5, var_131_3)

					arg_128_1.var_.characterEffect1022ui_story.fillFlat = true
					arg_128_1.var_.characterEffect1022ui_story.fillRatio = var_131_4
				end
			end

			if arg_128_1.time_ >= var_131_1 + var_131_2 and arg_128_1.time_ < var_131_1 + var_131_2 + arg_131_0 and not isNil(var_131_0) and arg_128_1.var_.characterEffect1022ui_story then
				local var_131_5 = 0.5

				arg_128_1.var_.characterEffect1022ui_story.fillFlat = true
				arg_128_1.var_.characterEffect1022ui_story.fillRatio = var_131_5
			end

			local var_131_6 = 0
			local var_131_7 = 0.9

			if var_131_6 < arg_128_1.time_ and arg_128_1.time_ <= var_131_6 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				local var_131_8 = arg_128_1:FormatText(StoryNameCfg[7].name)

				arg_128_1.leftNameTxt_.text = var_131_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, true)
				arg_128_1.iconController_:SetSelectedState("hero")

				arg_128_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_128_1.callingController_:SetSelectedState("normal")

				arg_128_1.keyicon_.color = Color.New(1, 1, 1)
				arg_128_1.icon_.color = Color.New(1, 1, 1)

				local var_131_9 = arg_128_1:GetWordFromCfg(1102205030)
				local var_131_10 = arg_128_1:FormatText(var_131_9.content)

				arg_128_1.text_.text = var_131_10

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_11 = 36
				local var_131_12 = utf8.len(var_131_10)
				local var_131_13 = var_131_11 <= 0 and var_131_7 or var_131_7 * (var_131_12 / var_131_11)

				if var_131_13 > 0 and var_131_7 < var_131_13 then
					arg_128_1.talkMaxDuration = var_131_13

					if var_131_13 + var_131_6 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_13 + var_131_6
					end
				end

				arg_128_1.text_.text = var_131_10
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)
				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_14 = math.max(var_131_7, arg_128_1.talkMaxDuration)

			if var_131_6 <= arg_128_1.time_ and arg_128_1.time_ < var_131_6 + var_131_14 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_6) / var_131_14

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_6 + var_131_14 and arg_128_1.time_ < var_131_6 + var_131_14 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {}

		arg_128_1:InitPlayNodeList()
	end,
	Play1102205031 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 1102205031
		arg_132_1.duration_ = 7.13

		SetActive(arg_132_1.tipsGo_, false)

		function arg_132_1.onSingleLineFinish_()
			arg_132_1.onSingleLineUpdate_ = nil
			arg_132_1.onSingleLineFinish_ = nil
			arg_132_1.state_ = "waiting"
		end

		function arg_132_1.playNext_(arg_134_0)
			if arg_134_0 == 1 then
				arg_132_0:Play1102205032(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			local var_135_0 = arg_132_1.actors_["1022ui_story"]
			local var_135_1 = 0

			if var_135_1 < arg_132_1.time_ and arg_132_1.time_ <= var_135_1 + arg_135_0 and not isNil(var_135_0) and arg_132_1.var_.characterEffect1022ui_story == nil then
				arg_132_1.var_.characterEffect1022ui_story = var_135_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_135_2 = 0.200000002980232

			if var_135_1 <= arg_132_1.time_ and arg_132_1.time_ < var_135_1 + var_135_2 and not isNil(var_135_0) then
				local var_135_3 = (arg_132_1.time_ - var_135_1) / var_135_2

				if arg_132_1.var_.characterEffect1022ui_story and not isNil(var_135_0) then
					arg_132_1.var_.characterEffect1022ui_story.fillFlat = false
				end
			end

			if arg_132_1.time_ >= var_135_1 + var_135_2 and arg_132_1.time_ < var_135_1 + var_135_2 + arg_135_0 and not isNil(var_135_0) and arg_132_1.var_.characterEffect1022ui_story then
				arg_132_1.var_.characterEffect1022ui_story.fillFlat = false
			end

			local var_135_4 = 0

			if var_135_4 < arg_132_1.time_ and arg_132_1.time_ <= var_135_4 + arg_135_0 then
				arg_132_1:PlayTimeline("1022ui_story", "StoryTimeline/CharAction/story1022/story1022action/1022action3_2")
			end

			local var_135_5 = 0

			if var_135_5 < arg_132_1.time_ and arg_132_1.time_ <= var_135_5 + arg_135_0 then
				arg_132_1:PlayTimeline("1022ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_135_6 = 0
			local var_135_7 = 0.725

			if var_135_6 < arg_132_1.time_ and arg_132_1.time_ <= var_135_6 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				local var_135_8 = arg_132_1:FormatText(StoryNameCfg[259].name)

				arg_132_1.leftNameTxt_.text = var_135_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_9 = arg_132_1:GetWordFromCfg(1102205031)
				local var_135_10 = arg_132_1:FormatText(var_135_9.content)

				arg_132_1.text_.text = var_135_10

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_11 = 29
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

				if manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205031", "story_v_side_new_1102205.awb") ~= 0 then
					local var_135_14 = manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205031", "story_v_side_new_1102205.awb") / 1000

					if var_135_14 + var_135_6 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_14 + var_135_6
					end

					if var_135_9.prefab_name ~= "" and arg_132_1.actors_[var_135_9.prefab_name] ~= nil then
						local var_135_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_9.prefab_name].transform, "story_v_side_new_1102205", "1102205031", "story_v_side_new_1102205.awb")

						arg_132_1:RecordAudio("1102205031", var_135_15)
						arg_132_1:RecordAudio("1102205031", var_135_15)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_side_new_1102205", "1102205031", "story_v_side_new_1102205.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_side_new_1102205", "1102205031", "story_v_side_new_1102205.awb")
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
	Play1102205032 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 1102205032
		arg_136_1.duration_ = 5

		SetActive(arg_136_1.tipsGo_, false)

		function arg_136_1.onSingleLineFinish_()
			arg_136_1.onSingleLineUpdate_ = nil
			arg_136_1.onSingleLineFinish_ = nil
			arg_136_1.state_ = "waiting"
		end

		function arg_136_1.playNext_(arg_138_0)
			if arg_138_0 == 1 then
				arg_136_0:Play1102205033(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			local var_139_0 = arg_136_1.actors_["1022ui_story"]
			local var_139_1 = 0

			if var_139_1 < arg_136_1.time_ and arg_136_1.time_ <= var_139_1 + arg_139_0 and not isNil(var_139_0) and arg_136_1.var_.characterEffect1022ui_story == nil then
				arg_136_1.var_.characterEffect1022ui_story = var_139_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_139_2 = 0.200000002980232

			if var_139_1 <= arg_136_1.time_ and arg_136_1.time_ < var_139_1 + var_139_2 and not isNil(var_139_0) then
				local var_139_3 = (arg_136_1.time_ - var_139_1) / var_139_2

				if arg_136_1.var_.characterEffect1022ui_story and not isNil(var_139_0) then
					local var_139_4 = Mathf.Lerp(0, 0.5, var_139_3)

					arg_136_1.var_.characterEffect1022ui_story.fillFlat = true
					arg_136_1.var_.characterEffect1022ui_story.fillRatio = var_139_4
				end
			end

			if arg_136_1.time_ >= var_139_1 + var_139_2 and arg_136_1.time_ < var_139_1 + var_139_2 + arg_139_0 and not isNil(var_139_0) and arg_136_1.var_.characterEffect1022ui_story then
				local var_139_5 = 0.5

				arg_136_1.var_.characterEffect1022ui_story.fillFlat = true
				arg_136_1.var_.characterEffect1022ui_story.fillRatio = var_139_5
			end

			local var_139_6 = 0
			local var_139_7 = 0.15

			if var_139_6 < arg_136_1.time_ and arg_136_1.time_ <= var_139_6 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				local var_139_8 = arg_136_1:FormatText(StoryNameCfg[7].name)

				arg_136_1.leftNameTxt_.text = var_139_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, true)
				arg_136_1.iconController_:SetSelectedState("hero")

				arg_136_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_136_1.callingController_:SetSelectedState("normal")

				arg_136_1.keyicon_.color = Color.New(1, 1, 1)
				arg_136_1.icon_.color = Color.New(1, 1, 1)

				local var_139_9 = arg_136_1:GetWordFromCfg(1102205032)
				local var_139_10 = arg_136_1:FormatText(var_139_9.content)

				arg_136_1.text_.text = var_139_10

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_11 = 6
				local var_139_12 = utf8.len(var_139_10)
				local var_139_13 = var_139_11 <= 0 and var_139_7 or var_139_7 * (var_139_12 / var_139_11)

				if var_139_13 > 0 and var_139_7 < var_139_13 then
					arg_136_1.talkMaxDuration = var_139_13

					if var_139_13 + var_139_6 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_13 + var_139_6
					end
				end

				arg_136_1.text_.text = var_139_10
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)
				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_14 = math.max(var_139_7, arg_136_1.talkMaxDuration)

			if var_139_6 <= arg_136_1.time_ and arg_136_1.time_ < var_139_6 + var_139_14 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_6) / var_139_14

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_6 + var_139_14 and arg_136_1.time_ < var_139_6 + var_139_14 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {}

		arg_136_1:InitPlayNodeList()
	end,
	Play1102205033 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 1102205033
		arg_140_1.duration_ = 5

		SetActive(arg_140_1.tipsGo_, false)

		function arg_140_1.onSingleLineFinish_()
			arg_140_1.onSingleLineUpdate_ = nil
			arg_140_1.onSingleLineFinish_ = nil
			arg_140_1.state_ = "waiting"
		end

		function arg_140_1.playNext_(arg_142_0)
			if arg_142_0 == 1 then
				arg_140_0:Play1102205034(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			local var_143_0 = arg_140_1.actors_["1022ui_story"].transform
			local var_143_1 = 0

			if var_143_1 < arg_140_1.time_ and arg_140_1.time_ <= var_143_1 + arg_143_0 then
				arg_140_1.var_.moveOldPos1022ui_story = var_143_0.localPosition
			end

			local var_143_2 = 0.001

			if var_143_1 <= arg_140_1.time_ and arg_140_1.time_ < var_143_1 + var_143_2 then
				local var_143_3 = (arg_140_1.time_ - var_143_1) / var_143_2
				local var_143_4 = Vector3.New(0, 100, 0)

				var_143_0.localPosition = Vector3.Lerp(arg_140_1.var_.moveOldPos1022ui_story, var_143_4, var_143_3)

				local var_143_5 = manager.ui.mainCamera.transform.position - var_143_0.position

				var_143_0.forward = Vector3.New(var_143_5.x, var_143_5.y, var_143_5.z)

				local var_143_6 = var_143_0.localEulerAngles

				var_143_6.z = 0
				var_143_6.x = 0
				var_143_0.localEulerAngles = var_143_6
			end

			if arg_140_1.time_ >= var_143_1 + var_143_2 and arg_140_1.time_ < var_143_1 + var_143_2 + arg_143_0 then
				var_143_0.localPosition = Vector3.New(0, 100, 0)

				local var_143_7 = manager.ui.mainCamera.transform.position - var_143_0.position

				var_143_0.forward = Vector3.New(var_143_7.x, var_143_7.y, var_143_7.z)

				local var_143_8 = var_143_0.localEulerAngles

				var_143_8.z = 0
				var_143_8.x = 0
				var_143_0.localEulerAngles = var_143_8
			end

			local var_143_9 = 0
			local var_143_10 = 0.925

			if var_143_9 < arg_140_1.time_ and arg_140_1.time_ <= var_143_9 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, false)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_140_1.iconTrs_.gameObject, false)
				arg_140_1.callingController_:SetSelectedState("normal")

				local var_143_11 = arg_140_1:GetWordFromCfg(1102205033)
				local var_143_12 = arg_140_1:FormatText(var_143_11.content)

				arg_140_1.text_.text = var_143_12

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_13 = 37
				local var_143_14 = utf8.len(var_143_12)
				local var_143_15 = var_143_13 <= 0 and var_143_10 or var_143_10 * (var_143_14 / var_143_13)

				if var_143_15 > 0 and var_143_10 < var_143_15 then
					arg_140_1.talkMaxDuration = var_143_15

					if var_143_15 + var_143_9 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_15 + var_143_9
					end
				end

				arg_140_1.text_.text = var_143_12
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)
				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_16 = math.max(var_143_10, arg_140_1.talkMaxDuration)

			if var_143_9 <= arg_140_1.time_ and arg_140_1.time_ < var_143_9 + var_143_16 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_9) / var_143_16

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_9 + var_143_16 and arg_140_1.time_ < var_143_9 + var_143_16 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1022ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_140_1:InitPlayNodeList()
	end,
	Play1102205034 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 1102205034
		arg_144_1.duration_ = 5

		SetActive(arg_144_1.tipsGo_, false)

		function arg_144_1.onSingleLineFinish_()
			arg_144_1.onSingleLineUpdate_ = nil
			arg_144_1.onSingleLineFinish_ = nil
			arg_144_1.state_ = "waiting"
		end

		function arg_144_1.playNext_(arg_146_0)
			if arg_146_0 == 1 then
				arg_144_0:Play1102205035(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			local var_147_0 = 0
			local var_147_1 = 1.025

			if var_147_0 < arg_144_1.time_ and arg_144_1.time_ <= var_147_0 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				local var_147_2 = arg_144_1:FormatText(StoryNameCfg[7].name)

				arg_144_1.leftNameTxt_.text = var_147_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, true)
				arg_144_1.iconController_:SetSelectedState("hero")

				arg_144_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_144_1.callingController_:SetSelectedState("normal")

				arg_144_1.keyicon_.color = Color.New(1, 1, 1)
				arg_144_1.icon_.color = Color.New(1, 1, 1)

				local var_147_3 = arg_144_1:GetWordFromCfg(1102205034)
				local var_147_4 = arg_144_1:FormatText(var_147_3.content)

				arg_144_1.text_.text = var_147_4

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_5 = 41
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
				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_8 = math.max(var_147_1, arg_144_1.talkMaxDuration)

			if var_147_0 <= arg_144_1.time_ and arg_144_1.time_ < var_147_0 + var_147_8 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_0) / var_147_8

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_0 + var_147_8 and arg_144_1.time_ < var_147_0 + var_147_8 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {}

		arg_144_1:InitPlayNodeList()
	end,
	Play1102205035 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 1102205035
		arg_148_1.duration_ = 5

		SetActive(arg_148_1.tipsGo_, false)

		function arg_148_1.onSingleLineFinish_()
			arg_148_1.onSingleLineUpdate_ = nil
			arg_148_1.onSingleLineFinish_ = nil
			arg_148_1.state_ = "waiting"
		end

		function arg_148_1.playNext_(arg_150_0)
			if arg_150_0 == 1 then
				arg_148_0:Play1102205036(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			local var_151_0 = 0
			local var_151_1 = 0.525

			if var_151_0 < arg_148_1.time_ and arg_148_1.time_ <= var_151_0 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, false)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_148_1.iconTrs_.gameObject, false)
				arg_148_1.callingController_:SetSelectedState("normal")

				local var_151_2 = arg_148_1:GetWordFromCfg(1102205035)
				local var_151_3 = arg_148_1:FormatText(var_151_2.content)

				arg_148_1.text_.text = var_151_3

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_4 = 21
				local var_151_5 = utf8.len(var_151_3)
				local var_151_6 = var_151_4 <= 0 and var_151_1 or var_151_1 * (var_151_5 / var_151_4)

				if var_151_6 > 0 and var_151_1 < var_151_6 then
					arg_148_1.talkMaxDuration = var_151_6

					if var_151_6 + var_151_0 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_6 + var_151_0
					end
				end

				arg_148_1.text_.text = var_151_3
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)
				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_7 = math.max(var_151_1, arg_148_1.talkMaxDuration)

			if var_151_0 <= arg_148_1.time_ and arg_148_1.time_ < var_151_0 + var_151_7 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_0) / var_151_7

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_0 + var_151_7 and arg_148_1.time_ < var_151_0 + var_151_7 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {}

		arg_148_1:InitPlayNodeList()
	end,
	Play1102205036 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 1102205036
		arg_152_1.duration_ = 3.4

		SetActive(arg_152_1.tipsGo_, false)

		function arg_152_1.onSingleLineFinish_()
			arg_152_1.onSingleLineUpdate_ = nil
			arg_152_1.onSingleLineFinish_ = nil
			arg_152_1.state_ = "waiting"
		end

		function arg_152_1.playNext_(arg_154_0)
			if arg_154_0 == 1 then
				arg_152_0:Play1102205037(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			local var_155_0 = arg_152_1.actors_["1022ui_story"].transform
			local var_155_1 = 0

			if var_155_1 < arg_152_1.time_ and arg_152_1.time_ <= var_155_1 + arg_155_0 then
				arg_152_1.var_.moveOldPos1022ui_story = var_155_0.localPosition
			end

			local var_155_2 = 0.001

			if var_155_1 <= arg_152_1.time_ and arg_152_1.time_ < var_155_1 + var_155_2 then
				local var_155_3 = (arg_152_1.time_ - var_155_1) / var_155_2
				local var_155_4 = Vector3.New(0, -1.08, -6)

				var_155_0.localPosition = Vector3.Lerp(arg_152_1.var_.moveOldPos1022ui_story, var_155_4, var_155_3)

				local var_155_5 = manager.ui.mainCamera.transform.position - var_155_0.position

				var_155_0.forward = Vector3.New(var_155_5.x, var_155_5.y, var_155_5.z)

				local var_155_6 = var_155_0.localEulerAngles

				var_155_6.z = 0
				var_155_6.x = 0
				var_155_0.localEulerAngles = var_155_6
			end

			if arg_152_1.time_ >= var_155_1 + var_155_2 and arg_152_1.time_ < var_155_1 + var_155_2 + arg_155_0 then
				var_155_0.localPosition = Vector3.New(0, -1.08, -6)

				local var_155_7 = manager.ui.mainCamera.transform.position - var_155_0.position

				var_155_0.forward = Vector3.New(var_155_7.x, var_155_7.y, var_155_7.z)

				local var_155_8 = var_155_0.localEulerAngles

				var_155_8.z = 0
				var_155_8.x = 0
				var_155_0.localEulerAngles = var_155_8
			end

			local var_155_9 = arg_152_1.actors_["1022ui_story"]
			local var_155_10 = 0

			if var_155_10 < arg_152_1.time_ and arg_152_1.time_ <= var_155_10 + arg_155_0 and not isNil(var_155_9) and arg_152_1.var_.characterEffect1022ui_story == nil then
				arg_152_1.var_.characterEffect1022ui_story = var_155_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_155_11 = 0.200000002980232

			if var_155_10 <= arg_152_1.time_ and arg_152_1.time_ < var_155_10 + var_155_11 and not isNil(var_155_9) then
				local var_155_12 = (arg_152_1.time_ - var_155_10) / var_155_11

				if arg_152_1.var_.characterEffect1022ui_story and not isNil(var_155_9) then
					arg_152_1.var_.characterEffect1022ui_story.fillFlat = false
				end
			end

			if arg_152_1.time_ >= var_155_10 + var_155_11 and arg_152_1.time_ < var_155_10 + var_155_11 + arg_155_0 and not isNil(var_155_9) and arg_152_1.var_.characterEffect1022ui_story then
				arg_152_1.var_.characterEffect1022ui_story.fillFlat = false
			end

			local var_155_13 = 0

			if var_155_13 < arg_152_1.time_ and arg_152_1.time_ <= var_155_13 + arg_155_0 then
				arg_152_1:PlayTimeline("1022ui_story", "StoryTimeline/CharAction/story1022/story1022action/1022action7_1")
			end

			local var_155_14 = 0

			if var_155_14 < arg_152_1.time_ and arg_152_1.time_ <= var_155_14 + arg_155_0 then
				arg_152_1:PlayTimeline("1022ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_155_15 = 0
			local var_155_16 = 0.375

			if var_155_15 < arg_152_1.time_ and arg_152_1.time_ <= var_155_15 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, true)

				local var_155_17 = arg_152_1:FormatText(StoryNameCfg[259].name)

				arg_152_1.leftNameTxt_.text = var_155_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_152_1.leftNameTxt_.transform)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1.leftNameTxt_.text)
				SetActive(arg_152_1.iconTrs_.gameObject, false)
				arg_152_1.callingController_:SetSelectedState("normal")

				local var_155_18 = arg_152_1:GetWordFromCfg(1102205036)
				local var_155_19 = arg_152_1:FormatText(var_155_18.content)

				arg_152_1.text_.text = var_155_19

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_20 = 15
				local var_155_21 = utf8.len(var_155_19)
				local var_155_22 = var_155_20 <= 0 and var_155_16 or var_155_16 * (var_155_21 / var_155_20)

				if var_155_22 > 0 and var_155_16 < var_155_22 then
					arg_152_1.talkMaxDuration = var_155_22

					if var_155_22 + var_155_15 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_22 + var_155_15
					end
				end

				arg_152_1.text_.text = var_155_19
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205036", "story_v_side_new_1102205.awb") ~= 0 then
					local var_155_23 = manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205036", "story_v_side_new_1102205.awb") / 1000

					if var_155_23 + var_155_15 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_23 + var_155_15
					end

					if var_155_18.prefab_name ~= "" and arg_152_1.actors_[var_155_18.prefab_name] ~= nil then
						local var_155_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_152_1.actors_[var_155_18.prefab_name].transform, "story_v_side_new_1102205", "1102205036", "story_v_side_new_1102205.awb")

						arg_152_1:RecordAudio("1102205036", var_155_24)
						arg_152_1:RecordAudio("1102205036", var_155_24)
					else
						arg_152_1:AudioAction("play", "voice", "story_v_side_new_1102205", "1102205036", "story_v_side_new_1102205.awb")
					end

					arg_152_1:RecordHistoryTalkVoice("story_v_side_new_1102205", "1102205036", "story_v_side_new_1102205.awb")
				end

				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_25 = math.max(var_155_16, arg_152_1.talkMaxDuration)

			if var_155_15 <= arg_152_1.time_ and arg_152_1.time_ < var_155_15 + var_155_25 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - var_155_15) / var_155_25

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= var_155_15 + var_155_25 and arg_152_1.time_ < var_155_15 + var_155_25 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1022ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_152_1:InitPlayNodeList()
	end,
	Play1102205037 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 1102205037
		arg_156_1.duration_ = 9.57

		SetActive(arg_156_1.tipsGo_, false)

		function arg_156_1.onSingleLineFinish_()
			arg_156_1.onSingleLineUpdate_ = nil
			arg_156_1.onSingleLineFinish_ = nil
			arg_156_1.state_ = "waiting"
		end

		function arg_156_1.playNext_(arg_158_0)
			if arg_158_0 == 1 then
				arg_156_0:Play1102205038(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			local var_159_0 = 0
			local var_159_1 = 1.1

			if var_159_0 < arg_156_1.time_ and arg_156_1.time_ <= var_159_0 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, true)

				local var_159_2 = arg_156_1:FormatText(StoryNameCfg[259].name)

				arg_156_1.leftNameTxt_.text = var_159_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_156_1.leftNameTxt_.transform)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1.leftNameTxt_.text)
				SetActive(arg_156_1.iconTrs_.gameObject, false)
				arg_156_1.callingController_:SetSelectedState("normal")

				local var_159_3 = arg_156_1:GetWordFromCfg(1102205037)
				local var_159_4 = arg_156_1:FormatText(var_159_3.content)

				arg_156_1.text_.text = var_159_4

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_5 = 44
				local var_159_6 = utf8.len(var_159_4)
				local var_159_7 = var_159_5 <= 0 and var_159_1 or var_159_1 * (var_159_6 / var_159_5)

				if var_159_7 > 0 and var_159_1 < var_159_7 then
					arg_156_1.talkMaxDuration = var_159_7

					if var_159_7 + var_159_0 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_7 + var_159_0
					end
				end

				arg_156_1.text_.text = var_159_4
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205037", "story_v_side_new_1102205.awb") ~= 0 then
					local var_159_8 = manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205037", "story_v_side_new_1102205.awb") / 1000

					if var_159_8 + var_159_0 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_8 + var_159_0
					end

					if var_159_3.prefab_name ~= "" and arg_156_1.actors_[var_159_3.prefab_name] ~= nil then
						local var_159_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_156_1.actors_[var_159_3.prefab_name].transform, "story_v_side_new_1102205", "1102205037", "story_v_side_new_1102205.awb")

						arg_156_1:RecordAudio("1102205037", var_159_9)
						arg_156_1:RecordAudio("1102205037", var_159_9)
					else
						arg_156_1:AudioAction("play", "voice", "story_v_side_new_1102205", "1102205037", "story_v_side_new_1102205.awb")
					end

					arg_156_1:RecordHistoryTalkVoice("story_v_side_new_1102205", "1102205037", "story_v_side_new_1102205.awb")
				end

				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_10 = math.max(var_159_1, arg_156_1.talkMaxDuration)

			if var_159_0 <= arg_156_1.time_ and arg_156_1.time_ < var_159_0 + var_159_10 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_0) / var_159_10

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_0 + var_159_10 and arg_156_1.time_ < var_159_0 + var_159_10 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {}

		arg_156_1:InitPlayNodeList()
	end,
	Play1102205038 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 1102205038
		arg_160_1.duration_ = 5

		SetActive(arg_160_1.tipsGo_, false)

		function arg_160_1.onSingleLineFinish_()
			arg_160_1.onSingleLineUpdate_ = nil
			arg_160_1.onSingleLineFinish_ = nil
			arg_160_1.state_ = "waiting"
		end

		function arg_160_1.playNext_(arg_162_0)
			if arg_162_0 == 1 then
				arg_160_0:Play1102205039(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			local var_163_0 = arg_160_1.actors_["1022ui_story"]
			local var_163_1 = 0

			if var_163_1 < arg_160_1.time_ and arg_160_1.time_ <= var_163_1 + arg_163_0 and not isNil(var_163_0) and arg_160_1.var_.characterEffect1022ui_story == nil then
				arg_160_1.var_.characterEffect1022ui_story = var_163_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_163_2 = 0.200000002980232

			if var_163_1 <= arg_160_1.time_ and arg_160_1.time_ < var_163_1 + var_163_2 and not isNil(var_163_0) then
				local var_163_3 = (arg_160_1.time_ - var_163_1) / var_163_2

				if arg_160_1.var_.characterEffect1022ui_story and not isNil(var_163_0) then
					local var_163_4 = Mathf.Lerp(0, 0.5, var_163_3)

					arg_160_1.var_.characterEffect1022ui_story.fillFlat = true
					arg_160_1.var_.characterEffect1022ui_story.fillRatio = var_163_4
				end
			end

			if arg_160_1.time_ >= var_163_1 + var_163_2 and arg_160_1.time_ < var_163_1 + var_163_2 + arg_163_0 and not isNil(var_163_0) and arg_160_1.var_.characterEffect1022ui_story then
				local var_163_5 = 0.5

				arg_160_1.var_.characterEffect1022ui_story.fillFlat = true
				arg_160_1.var_.characterEffect1022ui_story.fillRatio = var_163_5
			end

			local var_163_6 = 0
			local var_163_7 = 0.975

			if var_163_6 < arg_160_1.time_ and arg_160_1.time_ <= var_163_6 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, true)

				local var_163_8 = arg_160_1:FormatText(StoryNameCfg[7].name)

				arg_160_1.leftNameTxt_.text = var_163_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_160_1.leftNameTxt_.transform)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1.leftNameTxt_.text)
				SetActive(arg_160_1.iconTrs_.gameObject, true)
				arg_160_1.iconController_:SetSelectedState("hero")

				arg_160_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_160_1.callingController_:SetSelectedState("normal")

				arg_160_1.keyicon_.color = Color.New(1, 1, 1)
				arg_160_1.icon_.color = Color.New(1, 1, 1)

				local var_163_9 = arg_160_1:GetWordFromCfg(1102205038)
				local var_163_10 = arg_160_1:FormatText(var_163_9.content)

				arg_160_1.text_.text = var_163_10

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_11 = 39
				local var_163_12 = utf8.len(var_163_10)
				local var_163_13 = var_163_11 <= 0 and var_163_7 or var_163_7 * (var_163_12 / var_163_11)

				if var_163_13 > 0 and var_163_7 < var_163_13 then
					arg_160_1.talkMaxDuration = var_163_13

					if var_163_13 + var_163_6 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_13 + var_163_6
					end
				end

				arg_160_1.text_.text = var_163_10
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)
				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_14 = math.max(var_163_7, arg_160_1.talkMaxDuration)

			if var_163_6 <= arg_160_1.time_ and arg_160_1.time_ < var_163_6 + var_163_14 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - var_163_6) / var_163_14

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= var_163_6 + var_163_14 and arg_160_1.time_ < var_163_6 + var_163_14 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {}

		arg_160_1:InitPlayNodeList()
	end,
	Play1102205039 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 1102205039
		arg_164_1.duration_ = 10.2

		SetActive(arg_164_1.tipsGo_, false)

		function arg_164_1.onSingleLineFinish_()
			arg_164_1.onSingleLineUpdate_ = nil
			arg_164_1.onSingleLineFinish_ = nil
			arg_164_1.state_ = "waiting"
		end

		function arg_164_1.playNext_(arg_166_0)
			if arg_166_0 == 1 then
				arg_164_0:Play1102205040(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			local var_167_0 = arg_164_1.actors_["1022ui_story"]
			local var_167_1 = 0

			if var_167_1 < arg_164_1.time_ and arg_164_1.time_ <= var_167_1 + arg_167_0 and not isNil(var_167_0) and arg_164_1.var_.characterEffect1022ui_story == nil then
				arg_164_1.var_.characterEffect1022ui_story = var_167_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_167_2 = 0.200000002980232

			if var_167_1 <= arg_164_1.time_ and arg_164_1.time_ < var_167_1 + var_167_2 and not isNil(var_167_0) then
				local var_167_3 = (arg_164_1.time_ - var_167_1) / var_167_2

				if arg_164_1.var_.characterEffect1022ui_story and not isNil(var_167_0) then
					arg_164_1.var_.characterEffect1022ui_story.fillFlat = false
				end
			end

			if arg_164_1.time_ >= var_167_1 + var_167_2 and arg_164_1.time_ < var_167_1 + var_167_2 + arg_167_0 and not isNil(var_167_0) and arg_164_1.var_.characterEffect1022ui_story then
				arg_164_1.var_.characterEffect1022ui_story.fillFlat = false
			end

			local var_167_4 = 0

			if var_167_4 < arg_164_1.time_ and arg_164_1.time_ <= var_167_4 + arg_167_0 then
				arg_164_1:PlayTimeline("1022ui_story", "StoryTimeline/CharAction/story1022/story1022actionlink/1022action476")
			end

			local var_167_5 = 0

			if var_167_5 < arg_164_1.time_ and arg_164_1.time_ <= var_167_5 + arg_167_0 then
				arg_164_1:PlayTimeline("1022ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_167_6 = 0
			local var_167_7 = 0.875

			if var_167_6 < arg_164_1.time_ and arg_164_1.time_ <= var_167_6 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0
				arg_164_1.dialogCg_.alpha = 1

				arg_164_1.dialog_:SetActive(true)
				SetActive(arg_164_1.leftNameGo_, true)

				local var_167_8 = arg_164_1:FormatText(StoryNameCfg[259].name)

				arg_164_1.leftNameTxt_.text = var_167_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_164_1.leftNameTxt_.transform)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1.leftNameTxt_.text)
				SetActive(arg_164_1.iconTrs_.gameObject, false)
				arg_164_1.callingController_:SetSelectedState("normal")

				local var_167_9 = arg_164_1:GetWordFromCfg(1102205039)
				local var_167_10 = arg_164_1:FormatText(var_167_9.content)

				arg_164_1.text_.text = var_167_10

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_11 = 35
				local var_167_12 = utf8.len(var_167_10)
				local var_167_13 = var_167_11 <= 0 and var_167_7 or var_167_7 * (var_167_12 / var_167_11)

				if var_167_13 > 0 and var_167_7 < var_167_13 then
					arg_164_1.talkMaxDuration = var_167_13

					if var_167_13 + var_167_6 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_13 + var_167_6
					end
				end

				arg_164_1.text_.text = var_167_10
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205039", "story_v_side_new_1102205.awb") ~= 0 then
					local var_167_14 = manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205039", "story_v_side_new_1102205.awb") / 1000

					if var_167_14 + var_167_6 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_14 + var_167_6
					end

					if var_167_9.prefab_name ~= "" and arg_164_1.actors_[var_167_9.prefab_name] ~= nil then
						local var_167_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_164_1.actors_[var_167_9.prefab_name].transform, "story_v_side_new_1102205", "1102205039", "story_v_side_new_1102205.awb")

						arg_164_1:RecordAudio("1102205039", var_167_15)
						arg_164_1:RecordAudio("1102205039", var_167_15)
					else
						arg_164_1:AudioAction("play", "voice", "story_v_side_new_1102205", "1102205039", "story_v_side_new_1102205.awb")
					end

					arg_164_1:RecordHistoryTalkVoice("story_v_side_new_1102205", "1102205039", "story_v_side_new_1102205.awb")
				end

				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_16 = math.max(var_167_7, arg_164_1.talkMaxDuration)

			if var_167_6 <= arg_164_1.time_ and arg_164_1.time_ < var_167_6 + var_167_16 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - var_167_6) / var_167_16

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= var_167_6 + var_167_16 and arg_164_1.time_ < var_167_6 + var_167_16 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {}

		arg_164_1:InitPlayNodeList()
	end,
	Play1102205040 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 1102205040
		arg_168_1.duration_ = 1

		SetActive(arg_168_1.tipsGo_, false)

		function arg_168_1.onSingleLineFinish_()
			arg_168_1.onSingleLineUpdate_ = nil
			arg_168_1.onSingleLineFinish_ = nil
			arg_168_1.state_ = "waiting"

			SetActive(arg_168_1.choicesGo_, true)

			for iter_169_0, iter_169_1 in ipairs(arg_168_1.choices_) do
				local var_169_0 = iter_169_0 <= 1

				SetActive(iter_169_1.go, var_169_0)
			end

			arg_168_1.choices_[1].txt.text = arg_168_1:FormatText(StoryChoiceCfg[1467].name)
		end

		function arg_168_1.playNext_(arg_170_0)
			if arg_170_0 == 1 then
				arg_168_0:Play1102205041(arg_168_1)
			end

			arg_168_1:RecordChoiceLog(1102205040, 1467)
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			local var_171_0 = arg_168_1.actors_["1022ui_story"]
			local var_171_1 = 0

			if var_171_1 < arg_168_1.time_ and arg_168_1.time_ <= var_171_1 + arg_171_0 and not isNil(var_171_0) and arg_168_1.var_.characterEffect1022ui_story == nil then
				arg_168_1.var_.characterEffect1022ui_story = var_171_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_171_2 = 0.200000002980232

			if var_171_1 <= arg_168_1.time_ and arg_168_1.time_ < var_171_1 + var_171_2 and not isNil(var_171_0) then
				local var_171_3 = (arg_168_1.time_ - var_171_1) / var_171_2

				if arg_168_1.var_.characterEffect1022ui_story and not isNil(var_171_0) then
					local var_171_4 = Mathf.Lerp(0, 0.5, var_171_3)

					arg_168_1.var_.characterEffect1022ui_story.fillFlat = true
					arg_168_1.var_.characterEffect1022ui_story.fillRatio = var_171_4
				end
			end

			if arg_168_1.time_ >= var_171_1 + var_171_2 and arg_168_1.time_ < var_171_1 + var_171_2 + arg_171_0 and not isNil(var_171_0) and arg_168_1.var_.characterEffect1022ui_story then
				local var_171_5 = 0.5

				arg_168_1.var_.characterEffect1022ui_story.fillFlat = true
				arg_168_1.var_.characterEffect1022ui_story.fillRatio = var_171_5
			end
		end

		arg_168_1.nodeConfigList_ = {}

		arg_168_1:InitPlayNodeList()
	end,
	Play1102205041 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 1102205041
		arg_172_1.duration_ = 2

		SetActive(arg_172_1.tipsGo_, false)

		function arg_172_1.onSingleLineFinish_()
			arg_172_1.onSingleLineUpdate_ = nil
			arg_172_1.onSingleLineFinish_ = nil
			arg_172_1.state_ = "waiting"
		end

		function arg_172_1.playNext_(arg_174_0)
			if arg_174_0 == 1 then
				arg_172_0:Play1102205042(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			local var_175_0 = arg_172_1.actors_["1022ui_story"]
			local var_175_1 = 0

			if var_175_1 < arg_172_1.time_ and arg_172_1.time_ <= var_175_1 + arg_175_0 and not isNil(var_175_0) and arg_172_1.var_.characterEffect1022ui_story == nil then
				arg_172_1.var_.characterEffect1022ui_story = var_175_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_175_2 = 0.200000002980232

			if var_175_1 <= arg_172_1.time_ and arg_172_1.time_ < var_175_1 + var_175_2 and not isNil(var_175_0) then
				local var_175_3 = (arg_172_1.time_ - var_175_1) / var_175_2

				if arg_172_1.var_.characterEffect1022ui_story and not isNil(var_175_0) then
					arg_172_1.var_.characterEffect1022ui_story.fillFlat = false
				end
			end

			if arg_172_1.time_ >= var_175_1 + var_175_2 and arg_172_1.time_ < var_175_1 + var_175_2 + arg_175_0 and not isNil(var_175_0) and arg_172_1.var_.characterEffect1022ui_story then
				arg_172_1.var_.characterEffect1022ui_story.fillFlat = false
			end

			local var_175_4 = 0

			if var_175_4 < arg_172_1.time_ and arg_172_1.time_ <= var_175_4 + arg_175_0 then
				arg_172_1:PlayTimeline("1022ui_story", "StoryTimeline/CharAction/public_expression/expr_kunraoA_sikao", "EmotionTimelineAnimator")
			end

			local var_175_5 = 0
			local var_175_6 = 0.175

			if var_175_5 < arg_172_1.time_ and arg_172_1.time_ <= var_175_5 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, true)

				local var_175_7 = arg_172_1:FormatText(StoryNameCfg[259].name)

				arg_172_1.leftNameTxt_.text = var_175_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_172_1.leftNameTxt_.transform)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1.leftNameTxt_.text)
				SetActive(arg_172_1.iconTrs_.gameObject, false)
				arg_172_1.callingController_:SetSelectedState("normal")

				local var_175_8 = arg_172_1:GetWordFromCfg(1102205041)
				local var_175_9 = arg_172_1:FormatText(var_175_8.content)

				arg_172_1.text_.text = var_175_9

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_10 = 7
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

				if manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205041", "story_v_side_new_1102205.awb") ~= 0 then
					local var_175_13 = manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205041", "story_v_side_new_1102205.awb") / 1000

					if var_175_13 + var_175_5 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_13 + var_175_5
					end

					if var_175_8.prefab_name ~= "" and arg_172_1.actors_[var_175_8.prefab_name] ~= nil then
						local var_175_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_172_1.actors_[var_175_8.prefab_name].transform, "story_v_side_new_1102205", "1102205041", "story_v_side_new_1102205.awb")

						arg_172_1:RecordAudio("1102205041", var_175_14)
						arg_172_1:RecordAudio("1102205041", var_175_14)
					else
						arg_172_1:AudioAction("play", "voice", "story_v_side_new_1102205", "1102205041", "story_v_side_new_1102205.awb")
					end

					arg_172_1:RecordHistoryTalkVoice("story_v_side_new_1102205", "1102205041", "story_v_side_new_1102205.awb")
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
	Play1102205042 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 1102205042
		arg_176_1.duration_ = 5

		SetActive(arg_176_1.tipsGo_, false)

		function arg_176_1.onSingleLineFinish_()
			arg_176_1.onSingleLineUpdate_ = nil
			arg_176_1.onSingleLineFinish_ = nil
			arg_176_1.state_ = "waiting"
		end

		function arg_176_1.playNext_(arg_178_0)
			if arg_178_0 == 1 then
				arg_176_0:Play1102205043(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			local var_179_0 = arg_176_1.actors_["1022ui_story"]
			local var_179_1 = 0

			if var_179_1 < arg_176_1.time_ and arg_176_1.time_ <= var_179_1 + arg_179_0 and not isNil(var_179_0) and arg_176_1.var_.characterEffect1022ui_story == nil then
				arg_176_1.var_.characterEffect1022ui_story = var_179_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_179_2 = 0.200000002980232

			if var_179_1 <= arg_176_1.time_ and arg_176_1.time_ < var_179_1 + var_179_2 and not isNil(var_179_0) then
				local var_179_3 = (arg_176_1.time_ - var_179_1) / var_179_2

				if arg_176_1.var_.characterEffect1022ui_story and not isNil(var_179_0) then
					local var_179_4 = Mathf.Lerp(0, 0.5, var_179_3)

					arg_176_1.var_.characterEffect1022ui_story.fillFlat = true
					arg_176_1.var_.characterEffect1022ui_story.fillRatio = var_179_4
				end
			end

			if arg_176_1.time_ >= var_179_1 + var_179_2 and arg_176_1.time_ < var_179_1 + var_179_2 + arg_179_0 and not isNil(var_179_0) and arg_176_1.var_.characterEffect1022ui_story then
				local var_179_5 = 0.5

				arg_176_1.var_.characterEffect1022ui_story.fillFlat = true
				arg_176_1.var_.characterEffect1022ui_story.fillRatio = var_179_5
			end

			local var_179_6 = 0
			local var_179_7 = 0.875

			if var_179_6 < arg_176_1.time_ and arg_176_1.time_ <= var_179_6 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0
				arg_176_1.dialogCg_.alpha = 1

				arg_176_1.dialog_:SetActive(true)
				SetActive(arg_176_1.leftNameGo_, true)

				local var_179_8 = arg_176_1:FormatText(StoryNameCfg[7].name)

				arg_176_1.leftNameTxt_.text = var_179_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_176_1.leftNameTxt_.transform)

				arg_176_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_176_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_176_1:RecordName(arg_176_1.leftNameTxt_.text)
				SetActive(arg_176_1.iconTrs_.gameObject, true)
				arg_176_1.iconController_:SetSelectedState("hero")

				arg_176_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_176_1.callingController_:SetSelectedState("normal")

				arg_176_1.keyicon_.color = Color.New(1, 1, 1)
				arg_176_1.icon_.color = Color.New(1, 1, 1)

				local var_179_9 = arg_176_1:GetWordFromCfg(1102205042)
				local var_179_10 = arg_176_1:FormatText(var_179_9.content)

				arg_176_1.text_.text = var_179_10

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.text_)

				local var_179_11 = 35
				local var_179_12 = utf8.len(var_179_10)
				local var_179_13 = var_179_11 <= 0 and var_179_7 or var_179_7 * (var_179_12 / var_179_11)

				if var_179_13 > 0 and var_179_7 < var_179_13 then
					arg_176_1.talkMaxDuration = var_179_13

					if var_179_13 + var_179_6 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_13 + var_179_6
					end
				end

				arg_176_1.text_.text = var_179_10
				arg_176_1.typewritter.percent = 0

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(false)
				arg_176_1:RecordContent(arg_176_1.text_.text)
			end

			local var_179_14 = math.max(var_179_7, arg_176_1.talkMaxDuration)

			if var_179_6 <= arg_176_1.time_ and arg_176_1.time_ < var_179_6 + var_179_14 then
				arg_176_1.typewritter.percent = (arg_176_1.time_ - var_179_6) / var_179_14

				arg_176_1.typewritter:SetDirty()
			end

			if arg_176_1.time_ >= var_179_6 + var_179_14 and arg_176_1.time_ < var_179_6 + var_179_14 + arg_179_0 then
				arg_176_1.typewritter.percent = 1

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(true)
			end
		end

		arg_176_1.nodeConfigList_ = {}

		arg_176_1:InitPlayNodeList()
	end,
	Play1102205043 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 1102205043
		arg_180_1.duration_ = 5.9

		SetActive(arg_180_1.tipsGo_, false)

		function arg_180_1.onSingleLineFinish_()
			arg_180_1.onSingleLineUpdate_ = nil
			arg_180_1.onSingleLineFinish_ = nil
			arg_180_1.state_ = "waiting"
		end

		function arg_180_1.playNext_(arg_182_0)
			if arg_182_0 == 1 then
				arg_180_0:Play1102205044(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			local var_183_0 = arg_180_1.actors_["1022ui_story"]
			local var_183_1 = 0

			if var_183_1 < arg_180_1.time_ and arg_180_1.time_ <= var_183_1 + arg_183_0 and not isNil(var_183_0) and arg_180_1.var_.characterEffect1022ui_story == nil then
				arg_180_1.var_.characterEffect1022ui_story = var_183_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_183_2 = 0.200000002980232

			if var_183_1 <= arg_180_1.time_ and arg_180_1.time_ < var_183_1 + var_183_2 and not isNil(var_183_0) then
				local var_183_3 = (arg_180_1.time_ - var_183_1) / var_183_2

				if arg_180_1.var_.characterEffect1022ui_story and not isNil(var_183_0) then
					arg_180_1.var_.characterEffect1022ui_story.fillFlat = false
				end
			end

			if arg_180_1.time_ >= var_183_1 + var_183_2 and arg_180_1.time_ < var_183_1 + var_183_2 + arg_183_0 and not isNil(var_183_0) and arg_180_1.var_.characterEffect1022ui_story then
				arg_180_1.var_.characterEffect1022ui_story.fillFlat = false
			end

			local var_183_4 = 0

			if var_183_4 < arg_180_1.time_ and arg_180_1.time_ <= var_183_4 + arg_183_0 then
				arg_180_1:PlayTimeline("1022ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_183_5 = 0

			if var_183_5 < arg_180_1.time_ and arg_180_1.time_ <= var_183_5 + arg_183_0 then
				arg_180_1:PlayTimeline("1022ui_story", "StoryTimeline/CharAction/story1022/story1022action/1022action6_2")
			end

			local var_183_6 = 0
			local var_183_7 = 0.725

			if var_183_6 < arg_180_1.time_ and arg_180_1.time_ <= var_183_6 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0
				arg_180_1.dialogCg_.alpha = 1

				arg_180_1.dialog_:SetActive(true)
				SetActive(arg_180_1.leftNameGo_, true)

				local var_183_8 = arg_180_1:FormatText(StoryNameCfg[259].name)

				arg_180_1.leftNameTxt_.text = var_183_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_180_1.leftNameTxt_.transform)

				arg_180_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_180_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_180_1:RecordName(arg_180_1.leftNameTxt_.text)
				SetActive(arg_180_1.iconTrs_.gameObject, false)
				arg_180_1.callingController_:SetSelectedState("normal")

				local var_183_9 = arg_180_1:GetWordFromCfg(1102205043)
				local var_183_10 = arg_180_1:FormatText(var_183_9.content)

				arg_180_1.text_.text = var_183_10

				LuaForUtil.ClearLinePrefixSymbol(arg_180_1.text_)

				local var_183_11 = 29
				local var_183_12 = utf8.len(var_183_10)
				local var_183_13 = var_183_11 <= 0 and var_183_7 or var_183_7 * (var_183_12 / var_183_11)

				if var_183_13 > 0 and var_183_7 < var_183_13 then
					arg_180_1.talkMaxDuration = var_183_13

					if var_183_13 + var_183_6 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_13 + var_183_6
					end
				end

				arg_180_1.text_.text = var_183_10
				arg_180_1.typewritter.percent = 0

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205043", "story_v_side_new_1102205.awb") ~= 0 then
					local var_183_14 = manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205043", "story_v_side_new_1102205.awb") / 1000

					if var_183_14 + var_183_6 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_14 + var_183_6
					end

					if var_183_9.prefab_name ~= "" and arg_180_1.actors_[var_183_9.prefab_name] ~= nil then
						local var_183_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_180_1.actors_[var_183_9.prefab_name].transform, "story_v_side_new_1102205", "1102205043", "story_v_side_new_1102205.awb")

						arg_180_1:RecordAudio("1102205043", var_183_15)
						arg_180_1:RecordAudio("1102205043", var_183_15)
					else
						arg_180_1:AudioAction("play", "voice", "story_v_side_new_1102205", "1102205043", "story_v_side_new_1102205.awb")
					end

					arg_180_1:RecordHistoryTalkVoice("story_v_side_new_1102205", "1102205043", "story_v_side_new_1102205.awb")
				end

				arg_180_1:RecordContent(arg_180_1.text_.text)
			end

			local var_183_16 = math.max(var_183_7, arg_180_1.talkMaxDuration)

			if var_183_6 <= arg_180_1.time_ and arg_180_1.time_ < var_183_6 + var_183_16 then
				arg_180_1.typewritter.percent = (arg_180_1.time_ - var_183_6) / var_183_16

				arg_180_1.typewritter:SetDirty()
			end

			if arg_180_1.time_ >= var_183_6 + var_183_16 and arg_180_1.time_ < var_183_6 + var_183_16 + arg_183_0 then
				arg_180_1.typewritter.percent = 1

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(true)
			end
		end

		arg_180_1.nodeConfigList_ = {}

		arg_180_1:InitPlayNodeList()
	end,
	Play1102205044 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 1102205044
		arg_184_1.duration_ = 5

		SetActive(arg_184_1.tipsGo_, false)

		function arg_184_1.onSingleLineFinish_()
			arg_184_1.onSingleLineUpdate_ = nil
			arg_184_1.onSingleLineFinish_ = nil
			arg_184_1.state_ = "waiting"
		end

		function arg_184_1.playNext_(arg_186_0)
			if arg_186_0 == 1 then
				arg_184_0:Play1102205045(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			local var_187_0 = arg_184_1.actors_["1022ui_story"]
			local var_187_1 = 0

			if var_187_1 < arg_184_1.time_ and arg_184_1.time_ <= var_187_1 + arg_187_0 and not isNil(var_187_0) and arg_184_1.var_.characterEffect1022ui_story == nil then
				arg_184_1.var_.characterEffect1022ui_story = var_187_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_187_2 = 0.200000002980232

			if var_187_1 <= arg_184_1.time_ and arg_184_1.time_ < var_187_1 + var_187_2 and not isNil(var_187_0) then
				local var_187_3 = (arg_184_1.time_ - var_187_1) / var_187_2

				if arg_184_1.var_.characterEffect1022ui_story and not isNil(var_187_0) then
					local var_187_4 = Mathf.Lerp(0, 0.5, var_187_3)

					arg_184_1.var_.characterEffect1022ui_story.fillFlat = true
					arg_184_1.var_.characterEffect1022ui_story.fillRatio = var_187_4
				end
			end

			if arg_184_1.time_ >= var_187_1 + var_187_2 and arg_184_1.time_ < var_187_1 + var_187_2 + arg_187_0 and not isNil(var_187_0) and arg_184_1.var_.characterEffect1022ui_story then
				local var_187_5 = 0.5

				arg_184_1.var_.characterEffect1022ui_story.fillFlat = true
				arg_184_1.var_.characterEffect1022ui_story.fillRatio = var_187_5
			end

			local var_187_6 = 0
			local var_187_7 = 0.625

			if var_187_6 < arg_184_1.time_ and arg_184_1.time_ <= var_187_6 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0
				arg_184_1.dialogCg_.alpha = 1

				arg_184_1.dialog_:SetActive(true)
				SetActive(arg_184_1.leftNameGo_, true)

				local var_187_8 = arg_184_1:FormatText(StoryNameCfg[7].name)

				arg_184_1.leftNameTxt_.text = var_187_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_184_1.leftNameTxt_.transform)

				arg_184_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_184_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_184_1:RecordName(arg_184_1.leftNameTxt_.text)
				SetActive(arg_184_1.iconTrs_.gameObject, true)
				arg_184_1.iconController_:SetSelectedState("hero")

				arg_184_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_184_1.callingController_:SetSelectedState("normal")

				arg_184_1.keyicon_.color = Color.New(1, 1, 1)
				arg_184_1.icon_.color = Color.New(1, 1, 1)

				local var_187_9 = arg_184_1:GetWordFromCfg(1102205044)
				local var_187_10 = arg_184_1:FormatText(var_187_9.content)

				arg_184_1.text_.text = var_187_10

				LuaForUtil.ClearLinePrefixSymbol(arg_184_1.text_)

				local var_187_11 = 25
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
				arg_184_1:RecordContent(arg_184_1.text_.text)
			end

			local var_187_14 = math.max(var_187_7, arg_184_1.talkMaxDuration)

			if var_187_6 <= arg_184_1.time_ and arg_184_1.time_ < var_187_6 + var_187_14 then
				arg_184_1.typewritter.percent = (arg_184_1.time_ - var_187_6) / var_187_14

				arg_184_1.typewritter:SetDirty()
			end

			if arg_184_1.time_ >= var_187_6 + var_187_14 and arg_184_1.time_ < var_187_6 + var_187_14 + arg_187_0 then
				arg_184_1.typewritter.percent = 1

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(true)
			end
		end

		arg_184_1.nodeConfigList_ = {}

		arg_184_1:InitPlayNodeList()
	end,
	Play1102205045 = function(arg_188_0, arg_188_1)
		arg_188_1.time_ = 0
		arg_188_1.frameCnt_ = 0
		arg_188_1.state_ = "playing"
		arg_188_1.curTalkId_ = 1102205045
		arg_188_1.duration_ = 5

		SetActive(arg_188_1.tipsGo_, false)

		function arg_188_1.onSingleLineFinish_()
			arg_188_1.onSingleLineUpdate_ = nil
			arg_188_1.onSingleLineFinish_ = nil
			arg_188_1.state_ = "waiting"
		end

		function arg_188_1.playNext_(arg_190_0)
			if arg_190_0 == 1 then
				arg_188_0:Play1102205046(arg_188_1)
			end
		end

		function arg_188_1.onSingleLineUpdate_(arg_191_0)
			local var_191_0 = arg_188_1.actors_["1022ui_story"].transform
			local var_191_1 = 0

			if var_191_1 < arg_188_1.time_ and arg_188_1.time_ <= var_191_1 + arg_191_0 then
				arg_188_1.var_.moveOldPos1022ui_story = var_191_0.localPosition
			end

			local var_191_2 = 0.001

			if var_191_1 <= arg_188_1.time_ and arg_188_1.time_ < var_191_1 + var_191_2 then
				local var_191_3 = (arg_188_1.time_ - var_191_1) / var_191_2
				local var_191_4 = Vector3.New(0, 100, 0)

				var_191_0.localPosition = Vector3.Lerp(arg_188_1.var_.moveOldPos1022ui_story, var_191_4, var_191_3)

				local var_191_5 = manager.ui.mainCamera.transform.position - var_191_0.position

				var_191_0.forward = Vector3.New(var_191_5.x, var_191_5.y, var_191_5.z)

				local var_191_6 = var_191_0.localEulerAngles

				var_191_6.z = 0
				var_191_6.x = 0
				var_191_0.localEulerAngles = var_191_6
			end

			if arg_188_1.time_ >= var_191_1 + var_191_2 and arg_188_1.time_ < var_191_1 + var_191_2 + arg_191_0 then
				var_191_0.localPosition = Vector3.New(0, 100, 0)

				local var_191_7 = manager.ui.mainCamera.transform.position - var_191_0.position

				var_191_0.forward = Vector3.New(var_191_7.x, var_191_7.y, var_191_7.z)

				local var_191_8 = var_191_0.localEulerAngles

				var_191_8.z = 0
				var_191_8.x = 0
				var_191_0.localEulerAngles = var_191_8
			end

			local var_191_9 = 0.034000001847744
			local var_191_10 = 1

			if var_191_9 < arg_188_1.time_ and arg_188_1.time_ <= var_191_9 + arg_191_0 then
				local var_191_11 = "play"
				local var_191_12 = "effect"

				arg_188_1:AudioAction(var_191_11, var_191_12, "se_story_140", "se_story_140_foley_chair", "")
			end

			local var_191_13 = 0
			local var_191_14 = 0.7

			if var_191_13 < arg_188_1.time_ and arg_188_1.time_ <= var_191_13 + arg_191_0 then
				arg_188_1.talkMaxDuration = 0
				arg_188_1.dialogCg_.alpha = 1

				arg_188_1.dialog_:SetActive(true)
				SetActive(arg_188_1.leftNameGo_, false)

				arg_188_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_188_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_188_1:RecordName(arg_188_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_188_1.iconTrs_.gameObject, false)
				arg_188_1.callingController_:SetSelectedState("normal")

				local var_191_15 = arg_188_1:GetWordFromCfg(1102205045)
				local var_191_16 = arg_188_1:FormatText(var_191_15.content)

				arg_188_1.text_.text = var_191_16

				LuaForUtil.ClearLinePrefixSymbol(arg_188_1.text_)

				local var_191_17 = 28
				local var_191_18 = utf8.len(var_191_16)
				local var_191_19 = var_191_17 <= 0 and var_191_14 or var_191_14 * (var_191_18 / var_191_17)

				if var_191_19 > 0 and var_191_14 < var_191_19 then
					arg_188_1.talkMaxDuration = var_191_19

					if var_191_19 + var_191_13 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_19 + var_191_13
					end
				end

				arg_188_1.text_.text = var_191_16
				arg_188_1.typewritter.percent = 0

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(false)
				arg_188_1:RecordContent(arg_188_1.text_.text)
			end

			local var_191_20 = math.max(var_191_14, arg_188_1.talkMaxDuration)

			if var_191_13 <= arg_188_1.time_ and arg_188_1.time_ < var_191_13 + var_191_20 then
				arg_188_1.typewritter.percent = (arg_188_1.time_ - var_191_13) / var_191_20

				arg_188_1.typewritter:SetDirty()
			end

			if arg_188_1.time_ >= var_191_13 + var_191_20 and arg_188_1.time_ < var_191_13 + var_191_20 + arg_191_0 then
				arg_188_1.typewritter.percent = 1

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(true)
			end
		end

		arg_188_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1022ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_188_1:InitPlayNodeList()
	end,
	Play1102205046 = function(arg_192_0, arg_192_1)
		arg_192_1.time_ = 0
		arg_192_1.frameCnt_ = 0
		arg_192_1.state_ = "playing"
		arg_192_1.curTalkId_ = 1102205046
		arg_192_1.duration_ = 5

		SetActive(arg_192_1.tipsGo_, false)

		function arg_192_1.onSingleLineFinish_()
			arg_192_1.onSingleLineUpdate_ = nil
			arg_192_1.onSingleLineFinish_ = nil
			arg_192_1.state_ = "waiting"
		end

		function arg_192_1.playNext_(arg_194_0)
			if arg_194_0 == 1 then
				arg_192_0:Play1102205047(arg_192_1)
			end
		end

		function arg_192_1.onSingleLineUpdate_(arg_195_0)
			local var_195_0 = 0
			local var_195_1 = 0.7

			if var_195_0 < arg_192_1.time_ and arg_192_1.time_ <= var_195_0 + arg_195_0 then
				arg_192_1.talkMaxDuration = 0
				arg_192_1.dialogCg_.alpha = 1

				arg_192_1.dialog_:SetActive(true)
				SetActive(arg_192_1.leftNameGo_, true)

				local var_195_2 = arg_192_1:FormatText(StoryNameCfg[7].name)

				arg_192_1.leftNameTxt_.text = var_195_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_192_1.leftNameTxt_.transform)

				arg_192_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_192_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_192_1:RecordName(arg_192_1.leftNameTxt_.text)
				SetActive(arg_192_1.iconTrs_.gameObject, true)
				arg_192_1.iconController_:SetSelectedState("hero")

				arg_192_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_192_1.callingController_:SetSelectedState("normal")

				arg_192_1.keyicon_.color = Color.New(1, 1, 1)
				arg_192_1.icon_.color = Color.New(1, 1, 1)

				local var_195_3 = arg_192_1:GetWordFromCfg(1102205046)
				local var_195_4 = arg_192_1:FormatText(var_195_3.content)

				arg_192_1.text_.text = var_195_4

				LuaForUtil.ClearLinePrefixSymbol(arg_192_1.text_)

				local var_195_5 = 28
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
				arg_192_1:RecordContent(arg_192_1.text_.text)
			end

			local var_195_8 = math.max(var_195_1, arg_192_1.talkMaxDuration)

			if var_195_0 <= arg_192_1.time_ and arg_192_1.time_ < var_195_0 + var_195_8 then
				arg_192_1.typewritter.percent = (arg_192_1.time_ - var_195_0) / var_195_8

				arg_192_1.typewritter:SetDirty()
			end

			if arg_192_1.time_ >= var_195_0 + var_195_8 and arg_192_1.time_ < var_195_0 + var_195_8 + arg_195_0 then
				arg_192_1.typewritter.percent = 1

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(true)
			end
		end

		arg_192_1.nodeConfigList_ = {}

		arg_192_1:InitPlayNodeList()
	end,
	Play1102205047 = function(arg_196_0, arg_196_1)
		arg_196_1.time_ = 0
		arg_196_1.frameCnt_ = 0
		arg_196_1.state_ = "playing"
		arg_196_1.curTalkId_ = 1102205047
		arg_196_1.duration_ = 5.8

		SetActive(arg_196_1.tipsGo_, false)

		function arg_196_1.onSingleLineFinish_()
			arg_196_1.onSingleLineUpdate_ = nil
			arg_196_1.onSingleLineFinish_ = nil
			arg_196_1.state_ = "waiting"
		end

		function arg_196_1.playNext_(arg_198_0)
			if arg_198_0 == 1 then
				arg_196_0:Play1102205048(arg_196_1)
			end
		end

		function arg_196_1.onSingleLineUpdate_(arg_199_0)
			local var_199_0 = arg_196_1.actors_["1022ui_story"].transform
			local var_199_1 = 0

			if var_199_1 < arg_196_1.time_ and arg_196_1.time_ <= var_199_1 + arg_199_0 then
				arg_196_1.var_.moveOldPos1022ui_story = var_199_0.localPosition
			end

			local var_199_2 = 0.001

			if var_199_1 <= arg_196_1.time_ and arg_196_1.time_ < var_199_1 + var_199_2 then
				local var_199_3 = (arg_196_1.time_ - var_199_1) / var_199_2
				local var_199_4 = Vector3.New(0, -1.08, -6)

				var_199_0.localPosition = Vector3.Lerp(arg_196_1.var_.moveOldPos1022ui_story, var_199_4, var_199_3)

				local var_199_5 = manager.ui.mainCamera.transform.position - var_199_0.position

				var_199_0.forward = Vector3.New(var_199_5.x, var_199_5.y, var_199_5.z)

				local var_199_6 = var_199_0.localEulerAngles

				var_199_6.z = 0
				var_199_6.x = 0
				var_199_0.localEulerAngles = var_199_6
			end

			if arg_196_1.time_ >= var_199_1 + var_199_2 and arg_196_1.time_ < var_199_1 + var_199_2 + arg_199_0 then
				var_199_0.localPosition = Vector3.New(0, -1.08, -6)

				local var_199_7 = manager.ui.mainCamera.transform.position - var_199_0.position

				var_199_0.forward = Vector3.New(var_199_7.x, var_199_7.y, var_199_7.z)

				local var_199_8 = var_199_0.localEulerAngles

				var_199_8.z = 0
				var_199_8.x = 0
				var_199_0.localEulerAngles = var_199_8
			end

			local var_199_9 = arg_196_1.actors_["1022ui_story"]
			local var_199_10 = 0

			if var_199_10 < arg_196_1.time_ and arg_196_1.time_ <= var_199_10 + arg_199_0 and not isNil(var_199_9) and arg_196_1.var_.characterEffect1022ui_story == nil then
				arg_196_1.var_.characterEffect1022ui_story = var_199_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_199_11 = 0.200000002980232

			if var_199_10 <= arg_196_1.time_ and arg_196_1.time_ < var_199_10 + var_199_11 and not isNil(var_199_9) then
				local var_199_12 = (arg_196_1.time_ - var_199_10) / var_199_11

				if arg_196_1.var_.characterEffect1022ui_story and not isNil(var_199_9) then
					arg_196_1.var_.characterEffect1022ui_story.fillFlat = false
				end
			end

			if arg_196_1.time_ >= var_199_10 + var_199_11 and arg_196_1.time_ < var_199_10 + var_199_11 + arg_199_0 and not isNil(var_199_9) and arg_196_1.var_.characterEffect1022ui_story then
				arg_196_1.var_.characterEffect1022ui_story.fillFlat = false
			end

			local var_199_13 = 0

			if var_199_13 < arg_196_1.time_ and arg_196_1.time_ <= var_199_13 + arg_199_0 then
				arg_196_1:PlayTimeline("1022ui_story", "StoryTimeline/CharAction/story1022/story1022action/1022action2_1")
			end

			local var_199_14 = 0

			if var_199_14 < arg_196_1.time_ and arg_196_1.time_ <= var_199_14 + arg_199_0 then
				arg_196_1:PlayTimeline("1022ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_199_15 = 0
			local var_199_16 = 0.625

			if var_199_15 < arg_196_1.time_ and arg_196_1.time_ <= var_199_15 + arg_199_0 then
				arg_196_1.talkMaxDuration = 0
				arg_196_1.dialogCg_.alpha = 1

				arg_196_1.dialog_:SetActive(true)
				SetActive(arg_196_1.leftNameGo_, true)

				local var_199_17 = arg_196_1:FormatText(StoryNameCfg[259].name)

				arg_196_1.leftNameTxt_.text = var_199_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_196_1.leftNameTxt_.transform)

				arg_196_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_196_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_196_1:RecordName(arg_196_1.leftNameTxt_.text)
				SetActive(arg_196_1.iconTrs_.gameObject, false)
				arg_196_1.callingController_:SetSelectedState("normal")

				local var_199_18 = arg_196_1:GetWordFromCfg(1102205047)
				local var_199_19 = arg_196_1:FormatText(var_199_18.content)

				arg_196_1.text_.text = var_199_19

				LuaForUtil.ClearLinePrefixSymbol(arg_196_1.text_)

				local var_199_20 = 25
				local var_199_21 = utf8.len(var_199_19)
				local var_199_22 = var_199_20 <= 0 and var_199_16 or var_199_16 * (var_199_21 / var_199_20)

				if var_199_22 > 0 and var_199_16 < var_199_22 then
					arg_196_1.talkMaxDuration = var_199_22

					if var_199_22 + var_199_15 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_22 + var_199_15
					end
				end

				arg_196_1.text_.text = var_199_19
				arg_196_1.typewritter.percent = 0

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205047", "story_v_side_new_1102205.awb") ~= 0 then
					local var_199_23 = manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205047", "story_v_side_new_1102205.awb") / 1000

					if var_199_23 + var_199_15 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_23 + var_199_15
					end

					if var_199_18.prefab_name ~= "" and arg_196_1.actors_[var_199_18.prefab_name] ~= nil then
						local var_199_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_196_1.actors_[var_199_18.prefab_name].transform, "story_v_side_new_1102205", "1102205047", "story_v_side_new_1102205.awb")

						arg_196_1:RecordAudio("1102205047", var_199_24)
						arg_196_1:RecordAudio("1102205047", var_199_24)
					else
						arg_196_1:AudioAction("play", "voice", "story_v_side_new_1102205", "1102205047", "story_v_side_new_1102205.awb")
					end

					arg_196_1:RecordHistoryTalkVoice("story_v_side_new_1102205", "1102205047", "story_v_side_new_1102205.awb")
				end

				arg_196_1:RecordContent(arg_196_1.text_.text)
			end

			local var_199_25 = math.max(var_199_16, arg_196_1.talkMaxDuration)

			if var_199_15 <= arg_196_1.time_ and arg_196_1.time_ < var_199_15 + var_199_25 then
				arg_196_1.typewritter.percent = (arg_196_1.time_ - var_199_15) / var_199_25

				arg_196_1.typewritter:SetDirty()
			end

			if arg_196_1.time_ >= var_199_15 + var_199_25 and arg_196_1.time_ < var_199_15 + var_199_25 + arg_199_0 then
				arg_196_1.typewritter.percent = 1

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(true)
			end
		end

		arg_196_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1022ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_196_1:InitPlayNodeList()
	end,
	Play1102205048 = function(arg_200_0, arg_200_1)
		arg_200_1.time_ = 0
		arg_200_1.frameCnt_ = 0
		arg_200_1.state_ = "playing"
		arg_200_1.curTalkId_ = 1102205048
		arg_200_1.duration_ = 5

		SetActive(arg_200_1.tipsGo_, false)

		function arg_200_1.onSingleLineFinish_()
			arg_200_1.onSingleLineUpdate_ = nil
			arg_200_1.onSingleLineFinish_ = nil
			arg_200_1.state_ = "waiting"
		end

		function arg_200_1.playNext_(arg_202_0)
			if arg_202_0 == 1 then
				arg_200_0:Play1102205049(arg_200_1)
			end
		end

		function arg_200_1.onSingleLineUpdate_(arg_203_0)
			local var_203_0 = arg_200_1.actors_["1022ui_story"]
			local var_203_1 = 0

			if var_203_1 < arg_200_1.time_ and arg_200_1.time_ <= var_203_1 + arg_203_0 and not isNil(var_203_0) and arg_200_1.var_.characterEffect1022ui_story == nil then
				arg_200_1.var_.characterEffect1022ui_story = var_203_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_203_2 = 0.200000002980232

			if var_203_1 <= arg_200_1.time_ and arg_200_1.time_ < var_203_1 + var_203_2 and not isNil(var_203_0) then
				local var_203_3 = (arg_200_1.time_ - var_203_1) / var_203_2

				if arg_200_1.var_.characterEffect1022ui_story and not isNil(var_203_0) then
					local var_203_4 = Mathf.Lerp(0, 0.5, var_203_3)

					arg_200_1.var_.characterEffect1022ui_story.fillFlat = true
					arg_200_1.var_.characterEffect1022ui_story.fillRatio = var_203_4
				end
			end

			if arg_200_1.time_ >= var_203_1 + var_203_2 and arg_200_1.time_ < var_203_1 + var_203_2 + arg_203_0 and not isNil(var_203_0) and arg_200_1.var_.characterEffect1022ui_story then
				local var_203_5 = 0.5

				arg_200_1.var_.characterEffect1022ui_story.fillFlat = true
				arg_200_1.var_.characterEffect1022ui_story.fillRatio = var_203_5
			end

			local var_203_6 = 0
			local var_203_7 = 0.725

			if var_203_6 < arg_200_1.time_ and arg_200_1.time_ <= var_203_6 + arg_203_0 then
				arg_200_1.talkMaxDuration = 0
				arg_200_1.dialogCg_.alpha = 1

				arg_200_1.dialog_:SetActive(true)
				SetActive(arg_200_1.leftNameGo_, true)

				local var_203_8 = arg_200_1:FormatText(StoryNameCfg[7].name)

				arg_200_1.leftNameTxt_.text = var_203_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_200_1.leftNameTxt_.transform)

				arg_200_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_200_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_200_1:RecordName(arg_200_1.leftNameTxt_.text)
				SetActive(arg_200_1.iconTrs_.gameObject, true)
				arg_200_1.iconController_:SetSelectedState("hero")

				arg_200_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_200_1.callingController_:SetSelectedState("normal")

				arg_200_1.keyicon_.color = Color.New(1, 1, 1)
				arg_200_1.icon_.color = Color.New(1, 1, 1)

				local var_203_9 = arg_200_1:GetWordFromCfg(1102205048)
				local var_203_10 = arg_200_1:FormatText(var_203_9.content)

				arg_200_1.text_.text = var_203_10

				LuaForUtil.ClearLinePrefixSymbol(arg_200_1.text_)

				local var_203_11 = 29
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
				arg_200_1:RecordContent(arg_200_1.text_.text)
			end

			local var_203_14 = math.max(var_203_7, arg_200_1.talkMaxDuration)

			if var_203_6 <= arg_200_1.time_ and arg_200_1.time_ < var_203_6 + var_203_14 then
				arg_200_1.typewritter.percent = (arg_200_1.time_ - var_203_6) / var_203_14

				arg_200_1.typewritter:SetDirty()
			end

			if arg_200_1.time_ >= var_203_6 + var_203_14 and arg_200_1.time_ < var_203_6 + var_203_14 + arg_203_0 then
				arg_200_1.typewritter.percent = 1

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(true)
			end
		end

		arg_200_1.nodeConfigList_ = {}

		arg_200_1:InitPlayNodeList()
	end,
	Play1102205049 = function(arg_204_0, arg_204_1)
		arg_204_1.time_ = 0
		arg_204_1.frameCnt_ = 0
		arg_204_1.state_ = "playing"
		arg_204_1.curTalkId_ = 1102205049
		arg_204_1.duration_ = 1.63

		SetActive(arg_204_1.tipsGo_, false)

		function arg_204_1.onSingleLineFinish_()
			arg_204_1.onSingleLineUpdate_ = nil
			arg_204_1.onSingleLineFinish_ = nil
			arg_204_1.state_ = "waiting"
		end

		function arg_204_1.playNext_(arg_206_0)
			if arg_206_0 == 1 then
				arg_204_0:Play1102205050(arg_204_1)
			end
		end

		function arg_204_1.onSingleLineUpdate_(arg_207_0)
			local var_207_0 = arg_204_1.actors_["1022ui_story"]
			local var_207_1 = 0

			if var_207_1 < arg_204_1.time_ and arg_204_1.time_ <= var_207_1 + arg_207_0 and not isNil(var_207_0) and arg_204_1.var_.characterEffect1022ui_story == nil then
				arg_204_1.var_.characterEffect1022ui_story = var_207_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_207_2 = 0.200000002980232

			if var_207_1 <= arg_204_1.time_ and arg_204_1.time_ < var_207_1 + var_207_2 and not isNil(var_207_0) then
				local var_207_3 = (arg_204_1.time_ - var_207_1) / var_207_2

				if arg_204_1.var_.characterEffect1022ui_story and not isNil(var_207_0) then
					arg_204_1.var_.characterEffect1022ui_story.fillFlat = false
				end
			end

			if arg_204_1.time_ >= var_207_1 + var_207_2 and arg_204_1.time_ < var_207_1 + var_207_2 + arg_207_0 and not isNil(var_207_0) and arg_204_1.var_.characterEffect1022ui_story then
				arg_204_1.var_.characterEffect1022ui_story.fillFlat = false
			end

			local var_207_4 = 0
			local var_207_5 = 0.075

			if var_207_4 < arg_204_1.time_ and arg_204_1.time_ <= var_207_4 + arg_207_0 then
				arg_204_1.talkMaxDuration = 0
				arg_204_1.dialogCg_.alpha = 1

				arg_204_1.dialog_:SetActive(true)
				SetActive(arg_204_1.leftNameGo_, true)

				local var_207_6 = arg_204_1:FormatText(StoryNameCfg[259].name)

				arg_204_1.leftNameTxt_.text = var_207_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_204_1.leftNameTxt_.transform)

				arg_204_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_204_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_204_1:RecordName(arg_204_1.leftNameTxt_.text)
				SetActive(arg_204_1.iconTrs_.gameObject, false)
				arg_204_1.callingController_:SetSelectedState("normal")

				local var_207_7 = arg_204_1:GetWordFromCfg(1102205049)
				local var_207_8 = arg_204_1:FormatText(var_207_7.content)

				arg_204_1.text_.text = var_207_8

				LuaForUtil.ClearLinePrefixSymbol(arg_204_1.text_)

				local var_207_9 = 3
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

				if manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205049", "story_v_side_new_1102205.awb") ~= 0 then
					local var_207_12 = manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205049", "story_v_side_new_1102205.awb") / 1000

					if var_207_12 + var_207_4 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_12 + var_207_4
					end

					if var_207_7.prefab_name ~= "" and arg_204_1.actors_[var_207_7.prefab_name] ~= nil then
						local var_207_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_204_1.actors_[var_207_7.prefab_name].transform, "story_v_side_new_1102205", "1102205049", "story_v_side_new_1102205.awb")

						arg_204_1:RecordAudio("1102205049", var_207_13)
						arg_204_1:RecordAudio("1102205049", var_207_13)
					else
						arg_204_1:AudioAction("play", "voice", "story_v_side_new_1102205", "1102205049", "story_v_side_new_1102205.awb")
					end

					arg_204_1:RecordHistoryTalkVoice("story_v_side_new_1102205", "1102205049", "story_v_side_new_1102205.awb")
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
	Play1102205050 = function(arg_208_0, arg_208_1)
		arg_208_1.time_ = 0
		arg_208_1.frameCnt_ = 0
		arg_208_1.state_ = "playing"
		arg_208_1.curTalkId_ = 1102205050
		arg_208_1.duration_ = 5

		SetActive(arg_208_1.tipsGo_, false)

		function arg_208_1.onSingleLineFinish_()
			arg_208_1.onSingleLineUpdate_ = nil
			arg_208_1.onSingleLineFinish_ = nil
			arg_208_1.state_ = "waiting"
		end

		function arg_208_1.playNext_(arg_210_0)
			if arg_210_0 == 1 then
				arg_208_0:Play1102205051(arg_208_1)
			end
		end

		function arg_208_1.onSingleLineUpdate_(arg_211_0)
			local var_211_0 = arg_208_1.actors_["1022ui_story"]
			local var_211_1 = 0

			if var_211_1 < arg_208_1.time_ and arg_208_1.time_ <= var_211_1 + arg_211_0 and not isNil(var_211_0) and arg_208_1.var_.characterEffect1022ui_story == nil then
				arg_208_1.var_.characterEffect1022ui_story = var_211_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_211_2 = 0.200000002980232

			if var_211_1 <= arg_208_1.time_ and arg_208_1.time_ < var_211_1 + var_211_2 and not isNil(var_211_0) then
				local var_211_3 = (arg_208_1.time_ - var_211_1) / var_211_2

				if arg_208_1.var_.characterEffect1022ui_story and not isNil(var_211_0) then
					local var_211_4 = Mathf.Lerp(0, 0.5, var_211_3)

					arg_208_1.var_.characterEffect1022ui_story.fillFlat = true
					arg_208_1.var_.characterEffect1022ui_story.fillRatio = var_211_4
				end
			end

			if arg_208_1.time_ >= var_211_1 + var_211_2 and arg_208_1.time_ < var_211_1 + var_211_2 + arg_211_0 and not isNil(var_211_0) and arg_208_1.var_.characterEffect1022ui_story then
				local var_211_5 = 0.5

				arg_208_1.var_.characterEffect1022ui_story.fillFlat = true
				arg_208_1.var_.characterEffect1022ui_story.fillRatio = var_211_5
			end

			local var_211_6 = arg_208_1.actors_["1022ui_story"].transform
			local var_211_7 = 0

			if var_211_7 < arg_208_1.time_ and arg_208_1.time_ <= var_211_7 + arg_211_0 then
				arg_208_1.var_.moveOldPos1022ui_story = var_211_6.localPosition
			end

			local var_211_8 = 0.001

			if var_211_7 <= arg_208_1.time_ and arg_208_1.time_ < var_211_7 + var_211_8 then
				local var_211_9 = (arg_208_1.time_ - var_211_7) / var_211_8
				local var_211_10 = Vector3.New(0, 100, 0)

				var_211_6.localPosition = Vector3.Lerp(arg_208_1.var_.moveOldPos1022ui_story, var_211_10, var_211_9)

				local var_211_11 = manager.ui.mainCamera.transform.position - var_211_6.position

				var_211_6.forward = Vector3.New(var_211_11.x, var_211_11.y, var_211_11.z)

				local var_211_12 = var_211_6.localEulerAngles

				var_211_12.z = 0
				var_211_12.x = 0
				var_211_6.localEulerAngles = var_211_12
			end

			if arg_208_1.time_ >= var_211_7 + var_211_8 and arg_208_1.time_ < var_211_7 + var_211_8 + arg_211_0 then
				var_211_6.localPosition = Vector3.New(0, 100, 0)

				local var_211_13 = manager.ui.mainCamera.transform.position - var_211_6.position

				var_211_6.forward = Vector3.New(var_211_13.x, var_211_13.y, var_211_13.z)

				local var_211_14 = var_211_6.localEulerAngles

				var_211_14.z = 0
				var_211_14.x = 0
				var_211_6.localEulerAngles = var_211_14
			end

			local var_211_15 = 0
			local var_211_16 = 0.75

			if var_211_15 < arg_208_1.time_ and arg_208_1.time_ <= var_211_15 + arg_211_0 then
				arg_208_1.talkMaxDuration = 0
				arg_208_1.dialogCg_.alpha = 1

				arg_208_1.dialog_:SetActive(true)
				SetActive(arg_208_1.leftNameGo_, false)

				arg_208_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_208_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_208_1:RecordName(arg_208_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_208_1.iconTrs_.gameObject, false)
				arg_208_1.callingController_:SetSelectedState("normal")

				local var_211_17 = arg_208_1:GetWordFromCfg(1102205050)
				local var_211_18 = arg_208_1:FormatText(var_211_17.content)

				arg_208_1.text_.text = var_211_18

				LuaForUtil.ClearLinePrefixSymbol(arg_208_1.text_)

				local var_211_19 = 30
				local var_211_20 = utf8.len(var_211_18)
				local var_211_21 = var_211_19 <= 0 and var_211_16 or var_211_16 * (var_211_20 / var_211_19)

				if var_211_21 > 0 and var_211_16 < var_211_21 then
					arg_208_1.talkMaxDuration = var_211_21

					if var_211_21 + var_211_15 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_21 + var_211_15
					end
				end

				arg_208_1.text_.text = var_211_18
				arg_208_1.typewritter.percent = 0

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(false)
				arg_208_1:RecordContent(arg_208_1.text_.text)
			end

			local var_211_22 = math.max(var_211_16, arg_208_1.talkMaxDuration)

			if var_211_15 <= arg_208_1.time_ and arg_208_1.time_ < var_211_15 + var_211_22 then
				arg_208_1.typewritter.percent = (arg_208_1.time_ - var_211_15) / var_211_22

				arg_208_1.typewritter:SetDirty()
			end

			if arg_208_1.time_ >= var_211_15 + var_211_22 and arg_208_1.time_ < var_211_15 + var_211_22 + arg_211_0 then
				arg_208_1.typewritter.percent = 1

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(true)
			end
		end

		arg_208_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1022ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_208_1:InitPlayNodeList()
	end,
	Play1102205051 = function(arg_212_0, arg_212_1)
		arg_212_1.time_ = 0
		arg_212_1.frameCnt_ = 0
		arg_212_1.state_ = "playing"
		arg_212_1.curTalkId_ = 1102205051
		arg_212_1.duration_ = 3.13

		SetActive(arg_212_1.tipsGo_, false)

		function arg_212_1.onSingleLineFinish_()
			arg_212_1.onSingleLineUpdate_ = nil
			arg_212_1.onSingleLineFinish_ = nil
			arg_212_1.state_ = "waiting"
		end

		function arg_212_1.playNext_(arg_214_0)
			if arg_214_0 == 1 then
				arg_212_0:Play1102205052(arg_212_1)
			end
		end

		function arg_212_1.onSingleLineUpdate_(arg_215_0)
			local var_215_0 = arg_212_1.actors_["1022ui_story"]
			local var_215_1 = 0

			if var_215_1 < arg_212_1.time_ and arg_212_1.time_ <= var_215_1 + arg_215_0 and not isNil(var_215_0) and arg_212_1.var_.characterEffect1022ui_story == nil then
				arg_212_1.var_.characterEffect1022ui_story = var_215_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_215_2 = 0.200000002980232

			if var_215_1 <= arg_212_1.time_ and arg_212_1.time_ < var_215_1 + var_215_2 and not isNil(var_215_0) then
				local var_215_3 = (arg_212_1.time_ - var_215_1) / var_215_2

				if arg_212_1.var_.characterEffect1022ui_story and not isNil(var_215_0) then
					arg_212_1.var_.characterEffect1022ui_story.fillFlat = false
				end
			end

			if arg_212_1.time_ >= var_215_1 + var_215_2 and arg_212_1.time_ < var_215_1 + var_215_2 + arg_215_0 and not isNil(var_215_0) and arg_212_1.var_.characterEffect1022ui_story then
				arg_212_1.var_.characterEffect1022ui_story.fillFlat = false
			end

			local var_215_4 = 0

			if var_215_4 < arg_212_1.time_ and arg_212_1.time_ <= var_215_4 + arg_215_0 then
				arg_212_1:PlayTimeline("1022ui_story", "StoryTimeline/CharAction/story1022/story1022action/1022action2_2")
			end

			local var_215_5 = 0

			if var_215_5 < arg_212_1.time_ and arg_212_1.time_ <= var_215_5 + arg_215_0 then
				arg_212_1:PlayTimeline("1022ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_215_6 = arg_212_1.actors_["1022ui_story"].transform
			local var_215_7 = 0

			if var_215_7 < arg_212_1.time_ and arg_212_1.time_ <= var_215_7 + arg_215_0 then
				arg_212_1.var_.moveOldPos1022ui_story = var_215_6.localPosition
			end

			local var_215_8 = 0.001

			if var_215_7 <= arg_212_1.time_ and arg_212_1.time_ < var_215_7 + var_215_8 then
				local var_215_9 = (arg_212_1.time_ - var_215_7) / var_215_8
				local var_215_10 = Vector3.New(0, -1.08, -6)

				var_215_6.localPosition = Vector3.Lerp(arg_212_1.var_.moveOldPos1022ui_story, var_215_10, var_215_9)

				local var_215_11 = manager.ui.mainCamera.transform.position - var_215_6.position

				var_215_6.forward = Vector3.New(var_215_11.x, var_215_11.y, var_215_11.z)

				local var_215_12 = var_215_6.localEulerAngles

				var_215_12.z = 0
				var_215_12.x = 0
				var_215_6.localEulerAngles = var_215_12
			end

			if arg_212_1.time_ >= var_215_7 + var_215_8 and arg_212_1.time_ < var_215_7 + var_215_8 + arg_215_0 then
				var_215_6.localPosition = Vector3.New(0, -1.08, -6)

				local var_215_13 = manager.ui.mainCamera.transform.position - var_215_6.position

				var_215_6.forward = Vector3.New(var_215_13.x, var_215_13.y, var_215_13.z)

				local var_215_14 = var_215_6.localEulerAngles

				var_215_14.z = 0
				var_215_14.x = 0
				var_215_6.localEulerAngles = var_215_14
			end

			local var_215_15 = 0
			local var_215_16 = 0.275

			if var_215_15 < arg_212_1.time_ and arg_212_1.time_ <= var_215_15 + arg_215_0 then
				arg_212_1.talkMaxDuration = 0
				arg_212_1.dialogCg_.alpha = 1

				arg_212_1.dialog_:SetActive(true)
				SetActive(arg_212_1.leftNameGo_, true)

				local var_215_17 = arg_212_1:FormatText(StoryNameCfg[259].name)

				arg_212_1.leftNameTxt_.text = var_215_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_212_1.leftNameTxt_.transform)

				arg_212_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_212_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_212_1:RecordName(arg_212_1.leftNameTxt_.text)
				SetActive(arg_212_1.iconTrs_.gameObject, false)
				arg_212_1.callingController_:SetSelectedState("normal")

				local var_215_18 = arg_212_1:GetWordFromCfg(1102205051)
				local var_215_19 = arg_212_1:FormatText(var_215_18.content)

				arg_212_1.text_.text = var_215_19

				LuaForUtil.ClearLinePrefixSymbol(arg_212_1.text_)

				local var_215_20 = 11
				local var_215_21 = utf8.len(var_215_19)
				local var_215_22 = var_215_20 <= 0 and var_215_16 or var_215_16 * (var_215_21 / var_215_20)

				if var_215_22 > 0 and var_215_16 < var_215_22 then
					arg_212_1.talkMaxDuration = var_215_22

					if var_215_22 + var_215_15 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_22 + var_215_15
					end
				end

				arg_212_1.text_.text = var_215_19
				arg_212_1.typewritter.percent = 0

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205051", "story_v_side_new_1102205.awb") ~= 0 then
					local var_215_23 = manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205051", "story_v_side_new_1102205.awb") / 1000

					if var_215_23 + var_215_15 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_23 + var_215_15
					end

					if var_215_18.prefab_name ~= "" and arg_212_1.actors_[var_215_18.prefab_name] ~= nil then
						local var_215_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_212_1.actors_[var_215_18.prefab_name].transform, "story_v_side_new_1102205", "1102205051", "story_v_side_new_1102205.awb")

						arg_212_1:RecordAudio("1102205051", var_215_24)
						arg_212_1:RecordAudio("1102205051", var_215_24)
					else
						arg_212_1:AudioAction("play", "voice", "story_v_side_new_1102205", "1102205051", "story_v_side_new_1102205.awb")
					end

					arg_212_1:RecordHistoryTalkVoice("story_v_side_new_1102205", "1102205051", "story_v_side_new_1102205.awb")
				end

				arg_212_1:RecordContent(arg_212_1.text_.text)
			end

			local var_215_25 = math.max(var_215_16, arg_212_1.talkMaxDuration)

			if var_215_15 <= arg_212_1.time_ and arg_212_1.time_ < var_215_15 + var_215_25 then
				arg_212_1.typewritter.percent = (arg_212_1.time_ - var_215_15) / var_215_25

				arg_212_1.typewritter:SetDirty()
			end

			if arg_212_1.time_ >= var_215_15 + var_215_25 and arg_212_1.time_ < var_215_15 + var_215_25 + arg_215_0 then
				arg_212_1.typewritter.percent = 1

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(true)
			end
		end

		arg_212_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1022ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_212_1:InitPlayNodeList()
	end,
	Play1102205052 = function(arg_216_0, arg_216_1)
		arg_216_1.time_ = 0
		arg_216_1.frameCnt_ = 0
		arg_216_1.state_ = "playing"
		arg_216_1.curTalkId_ = 1102205052
		arg_216_1.duration_ = 5

		SetActive(arg_216_1.tipsGo_, false)

		function arg_216_1.onSingleLineFinish_()
			arg_216_1.onSingleLineUpdate_ = nil
			arg_216_1.onSingleLineFinish_ = nil
			arg_216_1.state_ = "waiting"
		end

		function arg_216_1.playNext_(arg_218_0)
			if arg_218_0 == 1 then
				arg_216_0:Play1102205053(arg_216_1)
			end
		end

		function arg_216_1.onSingleLineUpdate_(arg_219_0)
			local var_219_0 = arg_216_1.actors_["1022ui_story"]
			local var_219_1 = 0

			if var_219_1 < arg_216_1.time_ and arg_216_1.time_ <= var_219_1 + arg_219_0 and not isNil(var_219_0) and arg_216_1.var_.characterEffect1022ui_story == nil then
				arg_216_1.var_.characterEffect1022ui_story = var_219_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_219_2 = 0.200000002980232

			if var_219_1 <= arg_216_1.time_ and arg_216_1.time_ < var_219_1 + var_219_2 and not isNil(var_219_0) then
				local var_219_3 = (arg_216_1.time_ - var_219_1) / var_219_2

				if arg_216_1.var_.characterEffect1022ui_story and not isNil(var_219_0) then
					local var_219_4 = Mathf.Lerp(0, 0.5, var_219_3)

					arg_216_1.var_.characterEffect1022ui_story.fillFlat = true
					arg_216_1.var_.characterEffect1022ui_story.fillRatio = var_219_4
				end
			end

			if arg_216_1.time_ >= var_219_1 + var_219_2 and arg_216_1.time_ < var_219_1 + var_219_2 + arg_219_0 and not isNil(var_219_0) and arg_216_1.var_.characterEffect1022ui_story then
				local var_219_5 = 0.5

				arg_216_1.var_.characterEffect1022ui_story.fillFlat = true
				arg_216_1.var_.characterEffect1022ui_story.fillRatio = var_219_5
			end

			local var_219_6 = 0
			local var_219_7 = 0.425

			if var_219_6 < arg_216_1.time_ and arg_216_1.time_ <= var_219_6 + arg_219_0 then
				arg_216_1.talkMaxDuration = 0
				arg_216_1.dialogCg_.alpha = 1

				arg_216_1.dialog_:SetActive(true)
				SetActive(arg_216_1.leftNameGo_, true)

				local var_219_8 = arg_216_1:FormatText(StoryNameCfg[7].name)

				arg_216_1.leftNameTxt_.text = var_219_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_216_1.leftNameTxt_.transform)

				arg_216_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_216_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_216_1:RecordName(arg_216_1.leftNameTxt_.text)
				SetActive(arg_216_1.iconTrs_.gameObject, true)
				arg_216_1.iconController_:SetSelectedState("hero")

				arg_216_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_216_1.callingController_:SetSelectedState("normal")

				arg_216_1.keyicon_.color = Color.New(1, 1, 1)
				arg_216_1.icon_.color = Color.New(1, 1, 1)

				local var_219_9 = arg_216_1:GetWordFromCfg(1102205052)
				local var_219_10 = arg_216_1:FormatText(var_219_9.content)

				arg_216_1.text_.text = var_219_10

				LuaForUtil.ClearLinePrefixSymbol(arg_216_1.text_)

				local var_219_11 = 17
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
				arg_216_1:RecordContent(arg_216_1.text_.text)
			end

			local var_219_14 = math.max(var_219_7, arg_216_1.talkMaxDuration)

			if var_219_6 <= arg_216_1.time_ and arg_216_1.time_ < var_219_6 + var_219_14 then
				arg_216_1.typewritter.percent = (arg_216_1.time_ - var_219_6) / var_219_14

				arg_216_1.typewritter:SetDirty()
			end

			if arg_216_1.time_ >= var_219_6 + var_219_14 and arg_216_1.time_ < var_219_6 + var_219_14 + arg_219_0 then
				arg_216_1.typewritter.percent = 1

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(true)
			end
		end

		arg_216_1.nodeConfigList_ = {}

		arg_216_1:InitPlayNodeList()
	end,
	Play1102205053 = function(arg_220_0, arg_220_1)
		arg_220_1.time_ = 0
		arg_220_1.frameCnt_ = 0
		arg_220_1.state_ = "playing"
		arg_220_1.curTalkId_ = 1102205053
		arg_220_1.duration_ = 5

		SetActive(arg_220_1.tipsGo_, false)

		function arg_220_1.onSingleLineFinish_()
			arg_220_1.onSingleLineUpdate_ = nil
			arg_220_1.onSingleLineFinish_ = nil
			arg_220_1.state_ = "waiting"
		end

		function arg_220_1.playNext_(arg_222_0)
			if arg_222_0 == 1 then
				arg_220_0:Play1102205054(arg_220_1)
			end
		end

		function arg_220_1.onSingleLineUpdate_(arg_223_0)
			local var_223_0 = 0.7
			local var_223_1 = 1

			if var_223_0 < arg_220_1.time_ and arg_220_1.time_ <= var_223_0 + arg_223_0 then
				local var_223_2 = "play"
				local var_223_3 = "effect"

				arg_220_1:AudioAction(var_223_2, var_223_3, "se_story_side_1022", "se_story_side_1022_hittable", "")
			end

			local var_223_4 = 0
			local var_223_5 = 0.7

			if var_223_4 < arg_220_1.time_ and arg_220_1.time_ <= var_223_4 + arg_223_0 then
				arg_220_1.talkMaxDuration = 0
				arg_220_1.dialogCg_.alpha = 1

				arg_220_1.dialog_:SetActive(true)
				SetActive(arg_220_1.leftNameGo_, false)

				arg_220_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_220_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_220_1:RecordName(arg_220_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_220_1.iconTrs_.gameObject, false)
				arg_220_1.callingController_:SetSelectedState("normal")

				local var_223_6 = arg_220_1:GetWordFromCfg(1102205053)
				local var_223_7 = arg_220_1:FormatText(var_223_6.content)

				arg_220_1.text_.text = var_223_7

				LuaForUtil.ClearLinePrefixSymbol(arg_220_1.text_)

				local var_223_8 = 28
				local var_223_9 = utf8.len(var_223_7)
				local var_223_10 = var_223_8 <= 0 and var_223_5 or var_223_5 * (var_223_9 / var_223_8)

				if var_223_10 > 0 and var_223_5 < var_223_10 then
					arg_220_1.talkMaxDuration = var_223_10

					if var_223_10 + var_223_4 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_10 + var_223_4
					end
				end

				arg_220_1.text_.text = var_223_7
				arg_220_1.typewritter.percent = 0

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(false)
				arg_220_1:RecordContent(arg_220_1.text_.text)
			end

			local var_223_11 = math.max(var_223_5, arg_220_1.talkMaxDuration)

			if var_223_4 <= arg_220_1.time_ and arg_220_1.time_ < var_223_4 + var_223_11 then
				arg_220_1.typewritter.percent = (arg_220_1.time_ - var_223_4) / var_223_11

				arg_220_1.typewritter:SetDirty()
			end

			if arg_220_1.time_ >= var_223_4 + var_223_11 and arg_220_1.time_ < var_223_4 + var_223_11 + arg_223_0 then
				arg_220_1.typewritter.percent = 1

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(true)
			end
		end

		arg_220_1.nodeConfigList_ = {}

		arg_220_1:InitPlayNodeList()
	end,
	Play1102205054 = function(arg_224_0, arg_224_1)
		arg_224_1.time_ = 0
		arg_224_1.frameCnt_ = 0
		arg_224_1.state_ = "playing"
		arg_224_1.curTalkId_ = 1102205054
		arg_224_1.duration_ = 11.4

		SetActive(arg_224_1.tipsGo_, false)

		function arg_224_1.onSingleLineFinish_()
			arg_224_1.onSingleLineUpdate_ = nil
			arg_224_1.onSingleLineFinish_ = nil
			arg_224_1.state_ = "waiting"
		end

		function arg_224_1.playNext_(arg_226_0)
			if arg_226_0 == 1 then
				arg_224_0:Play1102205055(arg_224_1)
			end
		end

		function arg_224_1.onSingleLineUpdate_(arg_227_0)
			local var_227_0 = arg_224_1.actors_["1022ui_story"]
			local var_227_1 = 0

			if var_227_1 < arg_224_1.time_ and arg_224_1.time_ <= var_227_1 + arg_227_0 and not isNil(var_227_0) and arg_224_1.var_.characterEffect1022ui_story == nil then
				arg_224_1.var_.characterEffect1022ui_story = var_227_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_227_2 = 0.200000002980232

			if var_227_1 <= arg_224_1.time_ and arg_224_1.time_ < var_227_1 + var_227_2 and not isNil(var_227_0) then
				local var_227_3 = (arg_224_1.time_ - var_227_1) / var_227_2

				if arg_224_1.var_.characterEffect1022ui_story and not isNil(var_227_0) then
					arg_224_1.var_.characterEffect1022ui_story.fillFlat = false
				end
			end

			if arg_224_1.time_ >= var_227_1 + var_227_2 and arg_224_1.time_ < var_227_1 + var_227_2 + arg_227_0 and not isNil(var_227_0) and arg_224_1.var_.characterEffect1022ui_story then
				arg_224_1.var_.characterEffect1022ui_story.fillFlat = false
			end

			local var_227_4 = 0

			if var_227_4 < arg_224_1.time_ and arg_224_1.time_ <= var_227_4 + arg_227_0 then
				arg_224_1:PlayTimeline("1022ui_story", "StoryTimeline/CharAction/story1022/story1022action/1022action4_1")
			end

			local var_227_5 = 0

			if var_227_5 < arg_224_1.time_ and arg_224_1.time_ <= var_227_5 + arg_227_0 then
				arg_224_1:PlayTimeline("1022ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_227_6 = 0
			local var_227_7 = 1.275

			if var_227_6 < arg_224_1.time_ and arg_224_1.time_ <= var_227_6 + arg_227_0 then
				arg_224_1.talkMaxDuration = 0
				arg_224_1.dialogCg_.alpha = 1

				arg_224_1.dialog_:SetActive(true)
				SetActive(arg_224_1.leftNameGo_, true)

				local var_227_8 = arg_224_1:FormatText(StoryNameCfg[259].name)

				arg_224_1.leftNameTxt_.text = var_227_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_224_1.leftNameTxt_.transform)

				arg_224_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_224_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_224_1:RecordName(arg_224_1.leftNameTxt_.text)
				SetActive(arg_224_1.iconTrs_.gameObject, false)
				arg_224_1.callingController_:SetSelectedState("normal")

				local var_227_9 = arg_224_1:GetWordFromCfg(1102205054)
				local var_227_10 = arg_224_1:FormatText(var_227_9.content)

				arg_224_1.text_.text = var_227_10

				LuaForUtil.ClearLinePrefixSymbol(arg_224_1.text_)

				local var_227_11 = 51
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

				if manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205054", "story_v_side_new_1102205.awb") ~= 0 then
					local var_227_14 = manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205054", "story_v_side_new_1102205.awb") / 1000

					if var_227_14 + var_227_6 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_14 + var_227_6
					end

					if var_227_9.prefab_name ~= "" and arg_224_1.actors_[var_227_9.prefab_name] ~= nil then
						local var_227_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_224_1.actors_[var_227_9.prefab_name].transform, "story_v_side_new_1102205", "1102205054", "story_v_side_new_1102205.awb")

						arg_224_1:RecordAudio("1102205054", var_227_15)
						arg_224_1:RecordAudio("1102205054", var_227_15)
					else
						arg_224_1:AudioAction("play", "voice", "story_v_side_new_1102205", "1102205054", "story_v_side_new_1102205.awb")
					end

					arg_224_1:RecordHistoryTalkVoice("story_v_side_new_1102205", "1102205054", "story_v_side_new_1102205.awb")
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
	Play1102205055 = function(arg_228_0, arg_228_1)
		arg_228_1.time_ = 0
		arg_228_1.frameCnt_ = 0
		arg_228_1.state_ = "playing"
		arg_228_1.curTalkId_ = 1102205055
		arg_228_1.duration_ = 5

		SetActive(arg_228_1.tipsGo_, false)

		function arg_228_1.onSingleLineFinish_()
			arg_228_1.onSingleLineUpdate_ = nil
			arg_228_1.onSingleLineFinish_ = nil
			arg_228_1.state_ = "waiting"
		end

		function arg_228_1.playNext_(arg_230_0)
			if arg_230_0 == 1 then
				arg_228_0:Play1102205056(arg_228_1)
			end
		end

		function arg_228_1.onSingleLineUpdate_(arg_231_0)
			local var_231_0 = arg_228_1.actors_["1022ui_story"]
			local var_231_1 = 0

			if var_231_1 < arg_228_1.time_ and arg_228_1.time_ <= var_231_1 + arg_231_0 and not isNil(var_231_0) and arg_228_1.var_.characterEffect1022ui_story == nil then
				arg_228_1.var_.characterEffect1022ui_story = var_231_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_231_2 = 0.200000002980232

			if var_231_1 <= arg_228_1.time_ and arg_228_1.time_ < var_231_1 + var_231_2 and not isNil(var_231_0) then
				local var_231_3 = (arg_228_1.time_ - var_231_1) / var_231_2

				if arg_228_1.var_.characterEffect1022ui_story and not isNil(var_231_0) then
					local var_231_4 = Mathf.Lerp(0, 0.5, var_231_3)

					arg_228_1.var_.characterEffect1022ui_story.fillFlat = true
					arg_228_1.var_.characterEffect1022ui_story.fillRatio = var_231_4
				end
			end

			if arg_228_1.time_ >= var_231_1 + var_231_2 and arg_228_1.time_ < var_231_1 + var_231_2 + arg_231_0 and not isNil(var_231_0) and arg_228_1.var_.characterEffect1022ui_story then
				local var_231_5 = 0.5

				arg_228_1.var_.characterEffect1022ui_story.fillFlat = true
				arg_228_1.var_.characterEffect1022ui_story.fillRatio = var_231_5
			end

			local var_231_6 = 0
			local var_231_7 = 0.975

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

				arg_228_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_228_1.callingController_:SetSelectedState("normal")

				arg_228_1.keyicon_.color = Color.New(1, 1, 1)
				arg_228_1.icon_.color = Color.New(1, 1, 1)

				local var_231_9 = arg_228_1:GetWordFromCfg(1102205055)
				local var_231_10 = arg_228_1:FormatText(var_231_9.content)

				arg_228_1.text_.text = var_231_10

				LuaForUtil.ClearLinePrefixSymbol(arg_228_1.text_)

				local var_231_11 = 39
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
	Play1102205056 = function(arg_232_0, arg_232_1)
		arg_232_1.time_ = 0
		arg_232_1.frameCnt_ = 0
		arg_232_1.state_ = "playing"
		arg_232_1.curTalkId_ = 1102205056
		arg_232_1.duration_ = 5

		SetActive(arg_232_1.tipsGo_, false)

		function arg_232_1.onSingleLineFinish_()
			arg_232_1.onSingleLineUpdate_ = nil
			arg_232_1.onSingleLineFinish_ = nil
			arg_232_1.state_ = "waiting"
		end

		function arg_232_1.playNext_(arg_234_0)
			if arg_234_0 == 1 then
				arg_232_0:Play1102205057(arg_232_1)
			end
		end

		function arg_232_1.onSingleLineUpdate_(arg_235_0)
			local var_235_0 = arg_232_1.actors_["1022ui_story"].transform
			local var_235_1 = 0

			if var_235_1 < arg_232_1.time_ and arg_232_1.time_ <= var_235_1 + arg_235_0 then
				arg_232_1.var_.moveOldPos1022ui_story = var_235_0.localPosition
			end

			local var_235_2 = 0.001

			if var_235_1 <= arg_232_1.time_ and arg_232_1.time_ < var_235_1 + var_235_2 then
				local var_235_3 = (arg_232_1.time_ - var_235_1) / var_235_2
				local var_235_4 = Vector3.New(0, 100, 0)

				var_235_0.localPosition = Vector3.Lerp(arg_232_1.var_.moveOldPos1022ui_story, var_235_4, var_235_3)

				local var_235_5 = manager.ui.mainCamera.transform.position - var_235_0.position

				var_235_0.forward = Vector3.New(var_235_5.x, var_235_5.y, var_235_5.z)

				local var_235_6 = var_235_0.localEulerAngles

				var_235_6.z = 0
				var_235_6.x = 0
				var_235_0.localEulerAngles = var_235_6
			end

			if arg_232_1.time_ >= var_235_1 + var_235_2 and arg_232_1.time_ < var_235_1 + var_235_2 + arg_235_0 then
				var_235_0.localPosition = Vector3.New(0, 100, 0)

				local var_235_7 = manager.ui.mainCamera.transform.position - var_235_0.position

				var_235_0.forward = Vector3.New(var_235_7.x, var_235_7.y, var_235_7.z)

				local var_235_8 = var_235_0.localEulerAngles

				var_235_8.z = 0
				var_235_8.x = 0
				var_235_0.localEulerAngles = var_235_8
			end

			local var_235_9 = 0
			local var_235_10 = 0.75

			if var_235_9 < arg_232_1.time_ and arg_232_1.time_ <= var_235_9 + arg_235_0 then
				arg_232_1.talkMaxDuration = 0
				arg_232_1.dialogCg_.alpha = 1

				arg_232_1.dialog_:SetActive(true)
				SetActive(arg_232_1.leftNameGo_, false)

				arg_232_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_232_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_232_1:RecordName(arg_232_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_232_1.iconTrs_.gameObject, false)
				arg_232_1.callingController_:SetSelectedState("normal")

				local var_235_11 = arg_232_1:GetWordFromCfg(1102205056)
				local var_235_12 = arg_232_1:FormatText(var_235_11.content)

				arg_232_1.text_.text = var_235_12

				LuaForUtil.ClearLinePrefixSymbol(arg_232_1.text_)

				local var_235_13 = 30
				local var_235_14 = utf8.len(var_235_12)
				local var_235_15 = var_235_13 <= 0 and var_235_10 or var_235_10 * (var_235_14 / var_235_13)

				if var_235_15 > 0 and var_235_10 < var_235_15 then
					arg_232_1.talkMaxDuration = var_235_15

					if var_235_15 + var_235_9 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_15 + var_235_9
					end
				end

				arg_232_1.text_.text = var_235_12
				arg_232_1.typewritter.percent = 0

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(false)
				arg_232_1:RecordContent(arg_232_1.text_.text)
			end

			local var_235_16 = math.max(var_235_10, arg_232_1.talkMaxDuration)

			if var_235_9 <= arg_232_1.time_ and arg_232_1.time_ < var_235_9 + var_235_16 then
				arg_232_1.typewritter.percent = (arg_232_1.time_ - var_235_9) / var_235_16

				arg_232_1.typewritter:SetDirty()
			end

			if arg_232_1.time_ >= var_235_9 + var_235_16 and arg_232_1.time_ < var_235_9 + var_235_16 + arg_235_0 then
				arg_232_1.typewritter.percent = 1

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(true)
			end
		end

		arg_232_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1022ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_232_1:InitPlayNodeList()
	end,
	Play1102205057 = function(arg_236_0, arg_236_1)
		arg_236_1.time_ = 0
		arg_236_1.frameCnt_ = 0
		arg_236_1.state_ = "playing"
		arg_236_1.curTalkId_ = 1102205057
		arg_236_1.duration_ = 5

		SetActive(arg_236_1.tipsGo_, false)

		function arg_236_1.onSingleLineFinish_()
			arg_236_1.onSingleLineUpdate_ = nil
			arg_236_1.onSingleLineFinish_ = nil
			arg_236_1.state_ = "waiting"
		end

		function arg_236_1.playNext_(arg_238_0)
			if arg_238_0 == 1 then
				arg_236_0:Play1102205058(arg_236_1)
			end
		end

		function arg_236_1.onSingleLineUpdate_(arg_239_0)
			local var_239_0 = 0.7
			local var_239_1 = 1

			if var_239_0 < arg_236_1.time_ and arg_236_1.time_ <= var_239_0 + arg_239_0 then
				local var_239_2 = "play"
				local var_239_3 = "effect"

				arg_236_1:AudioAction(var_239_2, var_239_3, "se_story_144", "se_story_144_door_open", "")
			end

			local var_239_4 = 0
			local var_239_5 = 1.225

			if var_239_4 < arg_236_1.time_ and arg_236_1.time_ <= var_239_4 + arg_239_0 then
				arg_236_1.talkMaxDuration = 0
				arg_236_1.dialogCg_.alpha = 1

				arg_236_1.dialog_:SetActive(true)
				SetActive(arg_236_1.leftNameGo_, false)

				arg_236_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_236_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_236_1:RecordName(arg_236_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_236_1.iconTrs_.gameObject, false)
				arg_236_1.callingController_:SetSelectedState("normal")

				local var_239_6 = arg_236_1:GetWordFromCfg(1102205057)
				local var_239_7 = arg_236_1:FormatText(var_239_6.content)

				arg_236_1.text_.text = var_239_7

				LuaForUtil.ClearLinePrefixSymbol(arg_236_1.text_)

				local var_239_8 = 49
				local var_239_9 = utf8.len(var_239_7)
				local var_239_10 = var_239_8 <= 0 and var_239_5 or var_239_5 * (var_239_9 / var_239_8)

				if var_239_10 > 0 and var_239_5 < var_239_10 then
					arg_236_1.talkMaxDuration = var_239_10

					if var_239_10 + var_239_4 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_10 + var_239_4
					end
				end

				arg_236_1.text_.text = var_239_7
				arg_236_1.typewritter.percent = 0

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(false)
				arg_236_1:RecordContent(arg_236_1.text_.text)
			end

			local var_239_11 = math.max(var_239_5, arg_236_1.talkMaxDuration)

			if var_239_4 <= arg_236_1.time_ and arg_236_1.time_ < var_239_4 + var_239_11 then
				arg_236_1.typewritter.percent = (arg_236_1.time_ - var_239_4) / var_239_11

				arg_236_1.typewritter:SetDirty()
			end

			if arg_236_1.time_ >= var_239_4 + var_239_11 and arg_236_1.time_ < var_239_4 + var_239_11 + arg_239_0 then
				arg_236_1.typewritter.percent = 1

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(true)
			end
		end

		arg_236_1.nodeConfigList_ = {}

		arg_236_1:InitPlayNodeList()
	end,
	Play1102205058 = function(arg_240_0, arg_240_1)
		arg_240_1.time_ = 0
		arg_240_1.frameCnt_ = 0
		arg_240_1.state_ = "playing"
		arg_240_1.curTalkId_ = 1102205058
		arg_240_1.duration_ = 8.37

		SetActive(arg_240_1.tipsGo_, false)

		function arg_240_1.onSingleLineFinish_()
			arg_240_1.onSingleLineUpdate_ = nil
			arg_240_1.onSingleLineFinish_ = nil
			arg_240_1.state_ = "waiting"
		end

		function arg_240_1.playNext_(arg_242_0)
			if arg_242_0 == 1 then
				arg_240_0:Play1102205059(arg_240_1)
			end
		end

		function arg_240_1.onSingleLineUpdate_(arg_243_0)
			local var_243_0 = 1.76666666666667

			if var_243_0 < arg_240_1.time_ and arg_240_1.time_ <= var_243_0 + arg_243_0 then
				local var_243_1 = manager.ui.mainCamera.transform.localPosition
				local var_243_2 = Vector3.New(0, 0, 10) + Vector3.New(var_243_1.x, var_243_1.y, 0)
				local var_243_3 = arg_240_1.bgs_.ST77

				var_243_3.transform.localPosition = var_243_2
				var_243_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_243_4 = var_243_3:GetComponent("SpriteRenderer")

				if var_243_4 and var_243_4.sprite then
					local var_243_5 = (var_243_3.transform.localPosition - var_243_1).z
					local var_243_6 = manager.ui.mainCameraCom_
					local var_243_7 = 2 * var_243_5 * Mathf.Tan(var_243_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_243_8 = var_243_7 * var_243_6.aspect
					local var_243_9 = var_243_4.sprite.bounds.size.x
					local var_243_10 = var_243_4.sprite.bounds.size.y
					local var_243_11 = var_243_8 / var_243_9
					local var_243_12 = var_243_7 / var_243_10
					local var_243_13 = var_243_12 < var_243_11 and var_243_11 or var_243_12

					var_243_3.transform.localScale = Vector3.New(var_243_13, var_243_13, 0)
				end

				for iter_243_0, iter_243_1 in pairs(arg_240_1.bgs_) do
					if iter_243_0 ~= "ST77" then
						iter_243_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_243_14 = 0

			if var_243_14 < arg_240_1.time_ and arg_240_1.time_ <= var_243_14 + arg_243_0 then
				arg_240_1.allBtn_.enabled = false
			end

			local var_243_15 = 0.3

			if arg_240_1.time_ >= var_243_14 + var_243_15 and arg_240_1.time_ < var_243_14 + var_243_15 + arg_243_0 then
				arg_240_1.allBtn_.enabled = true
			end

			local var_243_16 = 0

			if var_243_16 < arg_240_1.time_ and arg_240_1.time_ <= var_243_16 + arg_243_0 then
				arg_240_1.mask_.enabled = true
				arg_240_1.mask_.raycastTarget = true

				arg_240_1:SetGaussion(false)
			end

			local var_243_17 = 1.76666666666667

			if var_243_16 <= arg_240_1.time_ and arg_240_1.time_ < var_243_16 + var_243_17 then
				local var_243_18 = (arg_240_1.time_ - var_243_16) / var_243_17
				local var_243_19 = Color.New(0, 0, 0)

				var_243_19.a = Mathf.Lerp(0, 1, var_243_18)
				arg_240_1.mask_.color = var_243_19
			end

			if arg_240_1.time_ >= var_243_16 + var_243_17 and arg_240_1.time_ < var_243_16 + var_243_17 + arg_243_0 then
				local var_243_20 = Color.New(0, 0, 0)

				var_243_20.a = 1
				arg_240_1.mask_.color = var_243_20
			end

			local var_243_21 = 1.76666666666667

			if var_243_21 < arg_240_1.time_ and arg_240_1.time_ <= var_243_21 + arg_243_0 then
				arg_240_1.mask_.enabled = true
				arg_240_1.mask_.raycastTarget = true

				arg_240_1:SetGaussion(false)
			end

			local var_243_22 = 2

			if var_243_21 <= arg_240_1.time_ and arg_240_1.time_ < var_243_21 + var_243_22 then
				local var_243_23 = (arg_240_1.time_ - var_243_21) / var_243_22
				local var_243_24 = Color.New(0, 0, 0)

				var_243_24.a = Mathf.Lerp(1, 0, var_243_23)
				arg_240_1.mask_.color = var_243_24
			end

			if arg_240_1.time_ >= var_243_21 + var_243_22 and arg_240_1.time_ < var_243_21 + var_243_22 + arg_243_0 then
				local var_243_25 = Color.New(0, 0, 0)
				local var_243_26 = 0

				arg_240_1.mask_.enabled = false
				var_243_25.a = var_243_26
				arg_240_1.mask_.color = var_243_25
			end

			if arg_240_1.frameCnt_ <= 1 then
				arg_240_1.dialog_:SetActive(false)
			end

			local var_243_27 = 3.36666666666667
			local var_243_28 = 0.85

			if var_243_27 < arg_240_1.time_ and arg_240_1.time_ <= var_243_27 + arg_243_0 then
				arg_240_1.talkMaxDuration = 0

				arg_240_1.dialog_:SetActive(true)

				arg_240_1.dialogCg_.alpha = 0

				local var_243_29 = LeanTween.value(arg_240_1.dialog_, 0, 1, 0.3)

				var_243_29:setOnUpdate(LuaHelper.FloatAction(function(arg_244_0)
					arg_240_1.dialogCg_.alpha = arg_244_0
				end))
				var_243_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_240_1.dialog_)
					var_243_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_240_1.duration_ = arg_240_1.duration_ + 0.3

				SetActive(arg_240_1.leftNameGo_, false)

				arg_240_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_240_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_240_1:RecordName(arg_240_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_240_1.iconTrs_.gameObject, false)
				arg_240_1.callingController_:SetSelectedState("normal")

				local var_243_30 = arg_240_1:GetWordFromCfg(1102205058)
				local var_243_31 = arg_240_1:FormatText(var_243_30.content)

				arg_240_1.text_.text = var_243_31

				LuaForUtil.ClearLinePrefixSymbol(arg_240_1.text_)

				local var_243_32 = 34
				local var_243_33 = utf8.len(var_243_31)
				local var_243_34 = var_243_32 <= 0 and var_243_28 or var_243_28 * (var_243_33 / var_243_32)

				if var_243_34 > 0 and var_243_28 < var_243_34 then
					arg_240_1.talkMaxDuration = var_243_34
					var_243_27 = var_243_27 + 0.3

					if var_243_34 + var_243_27 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_34 + var_243_27
					end
				end

				arg_240_1.text_.text = var_243_31
				arg_240_1.typewritter.percent = 0

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(false)
				arg_240_1:RecordContent(arg_240_1.text_.text)
			end

			local var_243_35 = var_243_27 + 0.3
			local var_243_36 = math.max(var_243_28, arg_240_1.talkMaxDuration)

			if var_243_35 <= arg_240_1.time_ and arg_240_1.time_ < var_243_35 + var_243_36 then
				arg_240_1.typewritter.percent = (arg_240_1.time_ - var_243_35) / var_243_36

				arg_240_1.typewritter:SetDirty()
			end

			if arg_240_1.time_ >= var_243_35 + var_243_36 and arg_240_1.time_ < var_243_35 + var_243_36 + arg_243_0 then
				arg_240_1.typewritter.percent = 1

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(true)
			end
		end

		arg_240_1.nodeConfigList_ = {}

		arg_240_1:InitPlayNodeList()
	end,
	Play1102205059 = function(arg_246_0, arg_246_1)
		arg_246_1.time_ = 0
		arg_246_1.frameCnt_ = 0
		arg_246_1.state_ = "playing"
		arg_246_1.curTalkId_ = 1102205059
		arg_246_1.duration_ = 5

		SetActive(arg_246_1.tipsGo_, false)

		function arg_246_1.onSingleLineFinish_()
			arg_246_1.onSingleLineUpdate_ = nil
			arg_246_1.onSingleLineFinish_ = nil
			arg_246_1.state_ = "waiting"
		end

		function arg_246_1.playNext_(arg_248_0)
			if arg_248_0 == 1 then
				arg_246_0:Play1102205060(arg_246_1)
			end
		end

		function arg_246_1.onSingleLineUpdate_(arg_249_0)
			local var_249_0 = 0
			local var_249_1 = 0.225

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

				local var_249_3 = arg_246_1:GetWordFromCfg(1102205059)
				local var_249_4 = arg_246_1:FormatText(var_249_3.content)

				arg_246_1.text_.text = var_249_4

				LuaForUtil.ClearLinePrefixSymbol(arg_246_1.text_)

				local var_249_5 = 9
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
	Play1102205060 = function(arg_250_0, arg_250_1)
		arg_250_1.time_ = 0
		arg_250_1.frameCnt_ = 0
		arg_250_1.state_ = "playing"
		arg_250_1.curTalkId_ = 1102205060
		arg_250_1.duration_ = 2

		SetActive(arg_250_1.tipsGo_, false)

		function arg_250_1.onSingleLineFinish_()
			arg_250_1.onSingleLineUpdate_ = nil
			arg_250_1.onSingleLineFinish_ = nil
			arg_250_1.state_ = "waiting"
		end

		function arg_250_1.playNext_(arg_252_0)
			if arg_252_0 == 1 then
				arg_250_0:Play1102205061(arg_250_1)
			end
		end

		function arg_250_1.onSingleLineUpdate_(arg_253_0)
			local var_253_0 = arg_250_1.actors_["1022ui_story"].transform
			local var_253_1 = 0

			if var_253_1 < arg_250_1.time_ and arg_250_1.time_ <= var_253_1 + arg_253_0 then
				arg_250_1.var_.moveOldPos1022ui_story = var_253_0.localPosition
			end

			local var_253_2 = 0.001

			if var_253_1 <= arg_250_1.time_ and arg_250_1.time_ < var_253_1 + var_253_2 then
				local var_253_3 = (arg_250_1.time_ - var_253_1) / var_253_2
				local var_253_4 = Vector3.New(0, -1.08, -6)

				var_253_0.localPosition = Vector3.Lerp(arg_250_1.var_.moveOldPos1022ui_story, var_253_4, var_253_3)

				local var_253_5 = manager.ui.mainCamera.transform.position - var_253_0.position

				var_253_0.forward = Vector3.New(var_253_5.x, var_253_5.y, var_253_5.z)

				local var_253_6 = var_253_0.localEulerAngles

				var_253_6.z = 0
				var_253_6.x = 0
				var_253_0.localEulerAngles = var_253_6
			end

			if arg_250_1.time_ >= var_253_1 + var_253_2 and arg_250_1.time_ < var_253_1 + var_253_2 + arg_253_0 then
				var_253_0.localPosition = Vector3.New(0, -1.08, -6)

				local var_253_7 = manager.ui.mainCamera.transform.position - var_253_0.position

				var_253_0.forward = Vector3.New(var_253_7.x, var_253_7.y, var_253_7.z)

				local var_253_8 = var_253_0.localEulerAngles

				var_253_8.z = 0
				var_253_8.x = 0
				var_253_0.localEulerAngles = var_253_8
			end

			local var_253_9 = arg_250_1.actors_["1022ui_story"]
			local var_253_10 = 0

			if var_253_10 < arg_250_1.time_ and arg_250_1.time_ <= var_253_10 + arg_253_0 and not isNil(var_253_9) and arg_250_1.var_.characterEffect1022ui_story == nil then
				arg_250_1.var_.characterEffect1022ui_story = var_253_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_253_11 = 0.200000002980232

			if var_253_10 <= arg_250_1.time_ and arg_250_1.time_ < var_253_10 + var_253_11 and not isNil(var_253_9) then
				local var_253_12 = (arg_250_1.time_ - var_253_10) / var_253_11

				if arg_250_1.var_.characterEffect1022ui_story and not isNil(var_253_9) then
					arg_250_1.var_.characterEffect1022ui_story.fillFlat = false
				end
			end

			if arg_250_1.time_ >= var_253_10 + var_253_11 and arg_250_1.time_ < var_253_10 + var_253_11 + arg_253_0 and not isNil(var_253_9) and arg_250_1.var_.characterEffect1022ui_story then
				arg_250_1.var_.characterEffect1022ui_story.fillFlat = false
			end

			local var_253_13 = 0

			if var_253_13 < arg_250_1.time_ and arg_250_1.time_ <= var_253_13 + arg_253_0 then
				arg_250_1:PlayTimeline("1022ui_story", "StoryTimeline/CharAction/story1022/story1022action/1022action1_1")
			end

			local var_253_14 = 0

			if var_253_14 < arg_250_1.time_ and arg_250_1.time_ <= var_253_14 + arg_253_0 then
				arg_250_1:PlayTimeline("1022ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_253_15 = 0
			local var_253_16 = 0.075

			if var_253_15 < arg_250_1.time_ and arg_250_1.time_ <= var_253_15 + arg_253_0 then
				arg_250_1.talkMaxDuration = 0
				arg_250_1.dialogCg_.alpha = 1

				arg_250_1.dialog_:SetActive(true)
				SetActive(arg_250_1.leftNameGo_, true)

				local var_253_17 = arg_250_1:FormatText(StoryNameCfg[259].name)

				arg_250_1.leftNameTxt_.text = var_253_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_250_1.leftNameTxt_.transform)

				arg_250_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_250_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_250_1:RecordName(arg_250_1.leftNameTxt_.text)
				SetActive(arg_250_1.iconTrs_.gameObject, false)
				arg_250_1.callingController_:SetSelectedState("normal")

				local var_253_18 = arg_250_1:GetWordFromCfg(1102205060)
				local var_253_19 = arg_250_1:FormatText(var_253_18.content)

				arg_250_1.text_.text = var_253_19

				LuaForUtil.ClearLinePrefixSymbol(arg_250_1.text_)

				local var_253_20 = 3
				local var_253_21 = utf8.len(var_253_19)
				local var_253_22 = var_253_20 <= 0 and var_253_16 or var_253_16 * (var_253_21 / var_253_20)

				if var_253_22 > 0 and var_253_16 < var_253_22 then
					arg_250_1.talkMaxDuration = var_253_22

					if var_253_22 + var_253_15 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_22 + var_253_15
					end
				end

				arg_250_1.text_.text = var_253_19
				arg_250_1.typewritter.percent = 0

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205060", "story_v_side_new_1102205.awb") ~= 0 then
					local var_253_23 = manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205060", "story_v_side_new_1102205.awb") / 1000

					if var_253_23 + var_253_15 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_23 + var_253_15
					end

					if var_253_18.prefab_name ~= "" and arg_250_1.actors_[var_253_18.prefab_name] ~= nil then
						local var_253_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_250_1.actors_[var_253_18.prefab_name].transform, "story_v_side_new_1102205", "1102205060", "story_v_side_new_1102205.awb")

						arg_250_1:RecordAudio("1102205060", var_253_24)
						arg_250_1:RecordAudio("1102205060", var_253_24)
					else
						arg_250_1:AudioAction("play", "voice", "story_v_side_new_1102205", "1102205060", "story_v_side_new_1102205.awb")
					end

					arg_250_1:RecordHistoryTalkVoice("story_v_side_new_1102205", "1102205060", "story_v_side_new_1102205.awb")
				end

				arg_250_1:RecordContent(arg_250_1.text_.text)
			end

			local var_253_25 = math.max(var_253_16, arg_250_1.talkMaxDuration)

			if var_253_15 <= arg_250_1.time_ and arg_250_1.time_ < var_253_15 + var_253_25 then
				arg_250_1.typewritter.percent = (arg_250_1.time_ - var_253_15) / var_253_25

				arg_250_1.typewritter:SetDirty()
			end

			if arg_250_1.time_ >= var_253_15 + var_253_25 and arg_250_1.time_ < var_253_15 + var_253_25 + arg_253_0 then
				arg_250_1.typewritter.percent = 1

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(true)
			end
		end

		arg_250_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1022ui_story",
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
	Play1102205061 = function(arg_254_0, arg_254_1)
		arg_254_1.time_ = 0
		arg_254_1.frameCnt_ = 0
		arg_254_1.state_ = "playing"
		arg_254_1.curTalkId_ = 1102205061
		arg_254_1.duration_ = 5

		SetActive(arg_254_1.tipsGo_, false)

		function arg_254_1.onSingleLineFinish_()
			arg_254_1.onSingleLineUpdate_ = nil
			arg_254_1.onSingleLineFinish_ = nil
			arg_254_1.state_ = "waiting"
		end

		function arg_254_1.playNext_(arg_256_0)
			if arg_256_0 == 1 then
				arg_254_0:Play1102205062(arg_254_1)
			end
		end

		function arg_254_1.onSingleLineUpdate_(arg_257_0)
			local var_257_0 = arg_254_1.actors_["1022ui_story"]
			local var_257_1 = 0

			if var_257_1 < arg_254_1.time_ and arg_254_1.time_ <= var_257_1 + arg_257_0 and not isNil(var_257_0) and arg_254_1.var_.characterEffect1022ui_story == nil then
				arg_254_1.var_.characterEffect1022ui_story = var_257_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_257_2 = 0.200000002980232

			if var_257_1 <= arg_254_1.time_ and arg_254_1.time_ < var_257_1 + var_257_2 and not isNil(var_257_0) then
				local var_257_3 = (arg_254_1.time_ - var_257_1) / var_257_2

				if arg_254_1.var_.characterEffect1022ui_story and not isNil(var_257_0) then
					local var_257_4 = Mathf.Lerp(0, 0.5, var_257_3)

					arg_254_1.var_.characterEffect1022ui_story.fillFlat = true
					arg_254_1.var_.characterEffect1022ui_story.fillRatio = var_257_4
				end
			end

			if arg_254_1.time_ >= var_257_1 + var_257_2 and arg_254_1.time_ < var_257_1 + var_257_2 + arg_257_0 and not isNil(var_257_0) and arg_254_1.var_.characterEffect1022ui_story then
				local var_257_5 = 0.5

				arg_254_1.var_.characterEffect1022ui_story.fillFlat = true
				arg_254_1.var_.characterEffect1022ui_story.fillRatio = var_257_5
			end

			local var_257_6 = 0
			local var_257_7 = 0.95

			if var_257_6 < arg_254_1.time_ and arg_254_1.time_ <= var_257_6 + arg_257_0 then
				arg_254_1.talkMaxDuration = 0
				arg_254_1.dialogCg_.alpha = 1

				arg_254_1.dialog_:SetActive(true)
				SetActive(arg_254_1.leftNameGo_, true)

				local var_257_8 = arg_254_1:FormatText(StoryNameCfg[7].name)

				arg_254_1.leftNameTxt_.text = var_257_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_254_1.leftNameTxt_.transform)

				arg_254_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_254_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_254_1:RecordName(arg_254_1.leftNameTxt_.text)
				SetActive(arg_254_1.iconTrs_.gameObject, true)
				arg_254_1.iconController_:SetSelectedState("hero")

				arg_254_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_254_1.callingController_:SetSelectedState("normal")

				arg_254_1.keyicon_.color = Color.New(1, 1, 1)
				arg_254_1.icon_.color = Color.New(1, 1, 1)

				local var_257_9 = arg_254_1:GetWordFromCfg(1102205061)
				local var_257_10 = arg_254_1:FormatText(var_257_9.content)

				arg_254_1.text_.text = var_257_10

				LuaForUtil.ClearLinePrefixSymbol(arg_254_1.text_)

				local var_257_11 = 38
				local var_257_12 = utf8.len(var_257_10)
				local var_257_13 = var_257_11 <= 0 and var_257_7 or var_257_7 * (var_257_12 / var_257_11)

				if var_257_13 > 0 and var_257_7 < var_257_13 then
					arg_254_1.talkMaxDuration = var_257_13

					if var_257_13 + var_257_6 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_13 + var_257_6
					end
				end

				arg_254_1.text_.text = var_257_10
				arg_254_1.typewritter.percent = 0

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(false)
				arg_254_1:RecordContent(arg_254_1.text_.text)
			end

			local var_257_14 = math.max(var_257_7, arg_254_1.talkMaxDuration)

			if var_257_6 <= arg_254_1.time_ and arg_254_1.time_ < var_257_6 + var_257_14 then
				arg_254_1.typewritter.percent = (arg_254_1.time_ - var_257_6) / var_257_14

				arg_254_1.typewritter:SetDirty()
			end

			if arg_254_1.time_ >= var_257_6 + var_257_14 and arg_254_1.time_ < var_257_6 + var_257_14 + arg_257_0 then
				arg_254_1.typewritter.percent = 1

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(true)
			end
		end

		arg_254_1.nodeConfigList_ = {}

		arg_254_1:InitPlayNodeList()
	end,
	Play1102205062 = function(arg_258_0, arg_258_1)
		arg_258_1.time_ = 0
		arg_258_1.frameCnt_ = 0
		arg_258_1.state_ = "playing"
		arg_258_1.curTalkId_ = 1102205062
		arg_258_1.duration_ = 2

		SetActive(arg_258_1.tipsGo_, false)

		function arg_258_1.onSingleLineFinish_()
			arg_258_1.onSingleLineUpdate_ = nil
			arg_258_1.onSingleLineFinish_ = nil
			arg_258_1.state_ = "waiting"
		end

		function arg_258_1.playNext_(arg_260_0)
			if arg_260_0 == 1 then
				arg_258_0:Play1102205063(arg_258_1)
			end
		end

		function arg_258_1.onSingleLineUpdate_(arg_261_0)
			local var_261_0 = arg_258_1.actors_["1022ui_story"]
			local var_261_1 = 0

			if var_261_1 < arg_258_1.time_ and arg_258_1.time_ <= var_261_1 + arg_261_0 and not isNil(var_261_0) and arg_258_1.var_.characterEffect1022ui_story == nil then
				arg_258_1.var_.characterEffect1022ui_story = var_261_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_261_2 = 0.200000002980232

			if var_261_1 <= arg_258_1.time_ and arg_258_1.time_ < var_261_1 + var_261_2 and not isNil(var_261_0) then
				local var_261_3 = (arg_258_1.time_ - var_261_1) / var_261_2

				if arg_258_1.var_.characterEffect1022ui_story and not isNil(var_261_0) then
					arg_258_1.var_.characterEffect1022ui_story.fillFlat = false
				end
			end

			if arg_258_1.time_ >= var_261_1 + var_261_2 and arg_258_1.time_ < var_261_1 + var_261_2 + arg_261_0 and not isNil(var_261_0) and arg_258_1.var_.characterEffect1022ui_story then
				arg_258_1.var_.characterEffect1022ui_story.fillFlat = false
			end

			local var_261_4 = 0

			if var_261_4 < arg_258_1.time_ and arg_258_1.time_ <= var_261_4 + arg_261_0 then
				arg_258_1:PlayTimeline("1022ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_261_5 = 0

			if var_261_5 < arg_258_1.time_ and arg_258_1.time_ <= var_261_5 + arg_261_0 then
				arg_258_1:PlayTimeline("1022ui_story", "StoryTimeline/CharAction/story1022/story1022action/1022action6_1")
			end

			local var_261_6 = 0
			local var_261_7 = 0.125

			if var_261_6 < arg_258_1.time_ and arg_258_1.time_ <= var_261_6 + arg_261_0 then
				arg_258_1.talkMaxDuration = 0
				arg_258_1.dialogCg_.alpha = 1

				arg_258_1.dialog_:SetActive(true)
				SetActive(arg_258_1.leftNameGo_, true)

				local var_261_8 = arg_258_1:FormatText(StoryNameCfg[259].name)

				arg_258_1.leftNameTxt_.text = var_261_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_258_1.leftNameTxt_.transform)

				arg_258_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_258_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_258_1:RecordName(arg_258_1.leftNameTxt_.text)
				SetActive(arg_258_1.iconTrs_.gameObject, false)
				arg_258_1.callingController_:SetSelectedState("normal")

				local var_261_9 = arg_258_1:GetWordFromCfg(1102205062)
				local var_261_10 = arg_258_1:FormatText(var_261_9.content)

				arg_258_1.text_.text = var_261_10

				LuaForUtil.ClearLinePrefixSymbol(arg_258_1.text_)

				local var_261_11 = 5
				local var_261_12 = utf8.len(var_261_10)
				local var_261_13 = var_261_11 <= 0 and var_261_7 or var_261_7 * (var_261_12 / var_261_11)

				if var_261_13 > 0 and var_261_7 < var_261_13 then
					arg_258_1.talkMaxDuration = var_261_13

					if var_261_13 + var_261_6 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_13 + var_261_6
					end
				end

				arg_258_1.text_.text = var_261_10
				arg_258_1.typewritter.percent = 0

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205062", "story_v_side_new_1102205.awb") ~= 0 then
					local var_261_14 = manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205062", "story_v_side_new_1102205.awb") / 1000

					if var_261_14 + var_261_6 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_14 + var_261_6
					end

					if var_261_9.prefab_name ~= "" and arg_258_1.actors_[var_261_9.prefab_name] ~= nil then
						local var_261_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_258_1.actors_[var_261_9.prefab_name].transform, "story_v_side_new_1102205", "1102205062", "story_v_side_new_1102205.awb")

						arg_258_1:RecordAudio("1102205062", var_261_15)
						arg_258_1:RecordAudio("1102205062", var_261_15)
					else
						arg_258_1:AudioAction("play", "voice", "story_v_side_new_1102205", "1102205062", "story_v_side_new_1102205.awb")
					end

					arg_258_1:RecordHistoryTalkVoice("story_v_side_new_1102205", "1102205062", "story_v_side_new_1102205.awb")
				end

				arg_258_1:RecordContent(arg_258_1.text_.text)
			end

			local var_261_16 = math.max(var_261_7, arg_258_1.talkMaxDuration)

			if var_261_6 <= arg_258_1.time_ and arg_258_1.time_ < var_261_6 + var_261_16 then
				arg_258_1.typewritter.percent = (arg_258_1.time_ - var_261_6) / var_261_16

				arg_258_1.typewritter:SetDirty()
			end

			if arg_258_1.time_ >= var_261_6 + var_261_16 and arg_258_1.time_ < var_261_6 + var_261_16 + arg_261_0 then
				arg_258_1.typewritter.percent = 1

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(true)
			end
		end

		arg_258_1.nodeConfigList_ = {}

		arg_258_1:InitPlayNodeList()
	end,
	Play1102205063 = function(arg_262_0, arg_262_1)
		arg_262_1.time_ = 0
		arg_262_1.frameCnt_ = 0
		arg_262_1.state_ = "playing"
		arg_262_1.curTalkId_ = 1102205063
		arg_262_1.duration_ = 5

		SetActive(arg_262_1.tipsGo_, false)

		function arg_262_1.onSingleLineFinish_()
			arg_262_1.onSingleLineUpdate_ = nil
			arg_262_1.onSingleLineFinish_ = nil
			arg_262_1.state_ = "waiting"
		end

		function arg_262_1.playNext_(arg_264_0)
			if arg_264_0 == 1 then
				arg_262_0:Play1102205064(arg_262_1)
			end
		end

		function arg_262_1.onSingleLineUpdate_(arg_265_0)
			local var_265_0 = arg_262_1.actors_["1022ui_story"]
			local var_265_1 = 0

			if var_265_1 < arg_262_1.time_ and arg_262_1.time_ <= var_265_1 + arg_265_0 and not isNil(var_265_0) and arg_262_1.var_.characterEffect1022ui_story == nil then
				arg_262_1.var_.characterEffect1022ui_story = var_265_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_265_2 = 0.200000002980232

			if var_265_1 <= arg_262_1.time_ and arg_262_1.time_ < var_265_1 + var_265_2 and not isNil(var_265_0) then
				local var_265_3 = (arg_262_1.time_ - var_265_1) / var_265_2

				if arg_262_1.var_.characterEffect1022ui_story and not isNil(var_265_0) then
					local var_265_4 = Mathf.Lerp(0, 0.5, var_265_3)

					arg_262_1.var_.characterEffect1022ui_story.fillFlat = true
					arg_262_1.var_.characterEffect1022ui_story.fillRatio = var_265_4
				end
			end

			if arg_262_1.time_ >= var_265_1 + var_265_2 and arg_262_1.time_ < var_265_1 + var_265_2 + arg_265_0 and not isNil(var_265_0) and arg_262_1.var_.characterEffect1022ui_story then
				local var_265_5 = 0.5

				arg_262_1.var_.characterEffect1022ui_story.fillFlat = true
				arg_262_1.var_.characterEffect1022ui_story.fillRatio = var_265_5
			end

			local var_265_6 = 0
			local var_265_7 = 0.75

			if var_265_6 < arg_262_1.time_ and arg_262_1.time_ <= var_265_6 + arg_265_0 then
				arg_262_1.talkMaxDuration = 0
				arg_262_1.dialogCg_.alpha = 1

				arg_262_1.dialog_:SetActive(true)
				SetActive(arg_262_1.leftNameGo_, false)

				arg_262_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_262_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_262_1:RecordName(arg_262_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_262_1.iconTrs_.gameObject, false)
				arg_262_1.callingController_:SetSelectedState("normal")

				local var_265_8 = arg_262_1:GetWordFromCfg(1102205063)
				local var_265_9 = arg_262_1:FormatText(var_265_8.content)

				arg_262_1.text_.text = var_265_9

				LuaForUtil.ClearLinePrefixSymbol(arg_262_1.text_)

				local var_265_10 = 30
				local var_265_11 = utf8.len(var_265_9)
				local var_265_12 = var_265_10 <= 0 and var_265_7 or var_265_7 * (var_265_11 / var_265_10)

				if var_265_12 > 0 and var_265_7 < var_265_12 then
					arg_262_1.talkMaxDuration = var_265_12

					if var_265_12 + var_265_6 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_12 + var_265_6
					end
				end

				arg_262_1.text_.text = var_265_9
				arg_262_1.typewritter.percent = 0

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(false)
				arg_262_1:RecordContent(arg_262_1.text_.text)
			end

			local var_265_13 = math.max(var_265_7, arg_262_1.talkMaxDuration)

			if var_265_6 <= arg_262_1.time_ and arg_262_1.time_ < var_265_6 + var_265_13 then
				arg_262_1.typewritter.percent = (arg_262_1.time_ - var_265_6) / var_265_13

				arg_262_1.typewritter:SetDirty()
			end

			if arg_262_1.time_ >= var_265_6 + var_265_13 and arg_262_1.time_ < var_265_6 + var_265_13 + arg_265_0 then
				arg_262_1.typewritter.percent = 1

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(true)
			end
		end

		arg_262_1.nodeConfigList_ = {}

		arg_262_1:InitPlayNodeList()
	end,
	Play1102205064 = function(arg_266_0, arg_266_1)
		arg_266_1.time_ = 0
		arg_266_1.frameCnt_ = 0
		arg_266_1.state_ = "playing"
		arg_266_1.curTalkId_ = 1102205064
		arg_266_1.duration_ = 10.27

		SetActive(arg_266_1.tipsGo_, false)

		function arg_266_1.onSingleLineFinish_()
			arg_266_1.onSingleLineUpdate_ = nil
			arg_266_1.onSingleLineFinish_ = nil
			arg_266_1.state_ = "waiting"
		end

		function arg_266_1.playNext_(arg_268_0)
			if arg_268_0 == 1 then
				arg_266_0:Play1102205065(arg_266_1)
			end
		end

		function arg_266_1.onSingleLineUpdate_(arg_269_0)
			local var_269_0 = arg_266_1.actors_["1022ui_story"]
			local var_269_1 = 0

			if var_269_1 < arg_266_1.time_ and arg_266_1.time_ <= var_269_1 + arg_269_0 and not isNil(var_269_0) and arg_266_1.var_.characterEffect1022ui_story == nil then
				arg_266_1.var_.characterEffect1022ui_story = var_269_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_269_2 = 0.200000002980232

			if var_269_1 <= arg_266_1.time_ and arg_266_1.time_ < var_269_1 + var_269_2 and not isNil(var_269_0) then
				local var_269_3 = (arg_266_1.time_ - var_269_1) / var_269_2

				if arg_266_1.var_.characterEffect1022ui_story and not isNil(var_269_0) then
					arg_266_1.var_.characterEffect1022ui_story.fillFlat = false
				end
			end

			if arg_266_1.time_ >= var_269_1 + var_269_2 and arg_266_1.time_ < var_269_1 + var_269_2 + arg_269_0 and not isNil(var_269_0) and arg_266_1.var_.characterEffect1022ui_story then
				arg_266_1.var_.characterEffect1022ui_story.fillFlat = false
			end

			local var_269_4 = 0

			if var_269_4 < arg_266_1.time_ and arg_266_1.time_ <= var_269_4 + arg_269_0 then
				arg_266_1:PlayTimeline("1022ui_story", "StoryTimeline/CharAction/story1022/story1022action/1022action6_2")
			end

			local var_269_5 = 0

			if var_269_5 < arg_266_1.time_ and arg_266_1.time_ <= var_269_5 + arg_269_0 then
				arg_266_1:PlayTimeline("1022ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_269_6 = 0
			local var_269_7 = 1.075

			if var_269_6 < arg_266_1.time_ and arg_266_1.time_ <= var_269_6 + arg_269_0 then
				arg_266_1.talkMaxDuration = 0
				arg_266_1.dialogCg_.alpha = 1

				arg_266_1.dialog_:SetActive(true)
				SetActive(arg_266_1.leftNameGo_, true)

				local var_269_8 = arg_266_1:FormatText(StoryNameCfg[259].name)

				arg_266_1.leftNameTxt_.text = var_269_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_266_1.leftNameTxt_.transform)

				arg_266_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_266_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_266_1:RecordName(arg_266_1.leftNameTxt_.text)
				SetActive(arg_266_1.iconTrs_.gameObject, false)
				arg_266_1.callingController_:SetSelectedState("normal")

				local var_269_9 = arg_266_1:GetWordFromCfg(1102205064)
				local var_269_10 = arg_266_1:FormatText(var_269_9.content)

				arg_266_1.text_.text = var_269_10

				LuaForUtil.ClearLinePrefixSymbol(arg_266_1.text_)

				local var_269_11 = 43
				local var_269_12 = utf8.len(var_269_10)
				local var_269_13 = var_269_11 <= 0 and var_269_7 or var_269_7 * (var_269_12 / var_269_11)

				if var_269_13 > 0 and var_269_7 < var_269_13 then
					arg_266_1.talkMaxDuration = var_269_13

					if var_269_13 + var_269_6 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_13 + var_269_6
					end
				end

				arg_266_1.text_.text = var_269_10
				arg_266_1.typewritter.percent = 0

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205064", "story_v_side_new_1102205.awb") ~= 0 then
					local var_269_14 = manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205064", "story_v_side_new_1102205.awb") / 1000

					if var_269_14 + var_269_6 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_14 + var_269_6
					end

					if var_269_9.prefab_name ~= "" and arg_266_1.actors_[var_269_9.prefab_name] ~= nil then
						local var_269_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_266_1.actors_[var_269_9.prefab_name].transform, "story_v_side_new_1102205", "1102205064", "story_v_side_new_1102205.awb")

						arg_266_1:RecordAudio("1102205064", var_269_15)
						arg_266_1:RecordAudio("1102205064", var_269_15)
					else
						arg_266_1:AudioAction("play", "voice", "story_v_side_new_1102205", "1102205064", "story_v_side_new_1102205.awb")
					end

					arg_266_1:RecordHistoryTalkVoice("story_v_side_new_1102205", "1102205064", "story_v_side_new_1102205.awb")
				end

				arg_266_1:RecordContent(arg_266_1.text_.text)
			end

			local var_269_16 = math.max(var_269_7, arg_266_1.talkMaxDuration)

			if var_269_6 <= arg_266_1.time_ and arg_266_1.time_ < var_269_6 + var_269_16 then
				arg_266_1.typewritter.percent = (arg_266_1.time_ - var_269_6) / var_269_16

				arg_266_1.typewritter:SetDirty()
			end

			if arg_266_1.time_ >= var_269_6 + var_269_16 and arg_266_1.time_ < var_269_6 + var_269_16 + arg_269_0 then
				arg_266_1.typewritter.percent = 1

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(true)
			end
		end

		arg_266_1.nodeConfigList_ = {}

		arg_266_1:InitPlayNodeList()
	end,
	Play1102205065 = function(arg_270_0, arg_270_1)
		arg_270_1.time_ = 0
		arg_270_1.frameCnt_ = 0
		arg_270_1.state_ = "playing"
		arg_270_1.curTalkId_ = 1102205065
		arg_270_1.duration_ = 5

		SetActive(arg_270_1.tipsGo_, false)

		function arg_270_1.onSingleLineFinish_()
			arg_270_1.onSingleLineUpdate_ = nil
			arg_270_1.onSingleLineFinish_ = nil
			arg_270_1.state_ = "waiting"
		end

		function arg_270_1.playNext_(arg_272_0)
			if arg_272_0 == 1 then
				arg_270_0:Play1102205066(arg_270_1)
			end
		end

		function arg_270_1.onSingleLineUpdate_(arg_273_0)
			local var_273_0 = arg_270_1.actors_["1022ui_story"]
			local var_273_1 = 0

			if var_273_1 < arg_270_1.time_ and arg_270_1.time_ <= var_273_1 + arg_273_0 and not isNil(var_273_0) and arg_270_1.var_.characterEffect1022ui_story == nil then
				arg_270_1.var_.characterEffect1022ui_story = var_273_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_273_2 = 0.200000002980232

			if var_273_1 <= arg_270_1.time_ and arg_270_1.time_ < var_273_1 + var_273_2 and not isNil(var_273_0) then
				local var_273_3 = (arg_270_1.time_ - var_273_1) / var_273_2

				if arg_270_1.var_.characterEffect1022ui_story and not isNil(var_273_0) then
					local var_273_4 = Mathf.Lerp(0, 0.5, var_273_3)

					arg_270_1.var_.characterEffect1022ui_story.fillFlat = true
					arg_270_1.var_.characterEffect1022ui_story.fillRatio = var_273_4
				end
			end

			if arg_270_1.time_ >= var_273_1 + var_273_2 and arg_270_1.time_ < var_273_1 + var_273_2 + arg_273_0 and not isNil(var_273_0) and arg_270_1.var_.characterEffect1022ui_story then
				local var_273_5 = 0.5

				arg_270_1.var_.characterEffect1022ui_story.fillFlat = true
				arg_270_1.var_.characterEffect1022ui_story.fillRatio = var_273_5
			end

			local var_273_6 = 0
			local var_273_7 = 0.15

			if var_273_6 < arg_270_1.time_ and arg_270_1.time_ <= var_273_6 + arg_273_0 then
				arg_270_1.talkMaxDuration = 0
				arg_270_1.dialogCg_.alpha = 1

				arg_270_1.dialog_:SetActive(true)
				SetActive(arg_270_1.leftNameGo_, true)

				local var_273_8 = arg_270_1:FormatText(StoryNameCfg[7].name)

				arg_270_1.leftNameTxt_.text = var_273_8

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

				local var_273_9 = arg_270_1:GetWordFromCfg(1102205065)
				local var_273_10 = arg_270_1:FormatText(var_273_9.content)

				arg_270_1.text_.text = var_273_10

				LuaForUtil.ClearLinePrefixSymbol(arg_270_1.text_)

				local var_273_11 = 6
				local var_273_12 = utf8.len(var_273_10)
				local var_273_13 = var_273_11 <= 0 and var_273_7 or var_273_7 * (var_273_12 / var_273_11)

				if var_273_13 > 0 and var_273_7 < var_273_13 then
					arg_270_1.talkMaxDuration = var_273_13

					if var_273_13 + var_273_6 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_13 + var_273_6
					end
				end

				arg_270_1.text_.text = var_273_10
				arg_270_1.typewritter.percent = 0

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(false)
				arg_270_1:RecordContent(arg_270_1.text_.text)
			end

			local var_273_14 = math.max(var_273_7, arg_270_1.talkMaxDuration)

			if var_273_6 <= arg_270_1.time_ and arg_270_1.time_ < var_273_6 + var_273_14 then
				arg_270_1.typewritter.percent = (arg_270_1.time_ - var_273_6) / var_273_14

				arg_270_1.typewritter:SetDirty()
			end

			if arg_270_1.time_ >= var_273_6 + var_273_14 and arg_270_1.time_ < var_273_6 + var_273_14 + arg_273_0 then
				arg_270_1.typewritter.percent = 1

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(true)
			end
		end

		arg_270_1.nodeConfigList_ = {}

		arg_270_1:InitPlayNodeList()
	end,
	Play1102205066 = function(arg_274_0, arg_274_1)
		arg_274_1.time_ = 0
		arg_274_1.frameCnt_ = 0
		arg_274_1.state_ = "playing"
		arg_274_1.curTalkId_ = 1102205066
		arg_274_1.duration_ = 5

		SetActive(arg_274_1.tipsGo_, false)

		function arg_274_1.onSingleLineFinish_()
			arg_274_1.onSingleLineUpdate_ = nil
			arg_274_1.onSingleLineFinish_ = nil
			arg_274_1.state_ = "waiting"
		end

		function arg_274_1.playNext_(arg_276_0)
			if arg_276_0 == 1 then
				arg_274_0:Play1102205067(arg_274_1)
			end
		end

		function arg_274_1.onSingleLineUpdate_(arg_277_0)
			local var_277_0 = 0
			local var_277_1 = 0.825

			if var_277_0 < arg_274_1.time_ and arg_274_1.time_ <= var_277_0 + arg_277_0 then
				arg_274_1.talkMaxDuration = 0
				arg_274_1.dialogCg_.alpha = 1

				arg_274_1.dialog_:SetActive(true)
				SetActive(arg_274_1.leftNameGo_, false)

				arg_274_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_274_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_274_1:RecordName(arg_274_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_274_1.iconTrs_.gameObject, false)
				arg_274_1.callingController_:SetSelectedState("normal")

				local var_277_2 = arg_274_1:GetWordFromCfg(1102205066)
				local var_277_3 = arg_274_1:FormatText(var_277_2.content)

				arg_274_1.text_.text = var_277_3

				LuaForUtil.ClearLinePrefixSymbol(arg_274_1.text_)

				local var_277_4 = 33
				local var_277_5 = utf8.len(var_277_3)
				local var_277_6 = var_277_4 <= 0 and var_277_1 or var_277_1 * (var_277_5 / var_277_4)

				if var_277_6 > 0 and var_277_1 < var_277_6 then
					arg_274_1.talkMaxDuration = var_277_6

					if var_277_6 + var_277_0 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_6 + var_277_0
					end
				end

				arg_274_1.text_.text = var_277_3
				arg_274_1.typewritter.percent = 0

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(false)
				arg_274_1:RecordContent(arg_274_1.text_.text)
			end

			local var_277_7 = math.max(var_277_1, arg_274_1.talkMaxDuration)

			if var_277_0 <= arg_274_1.time_ and arg_274_1.time_ < var_277_0 + var_277_7 then
				arg_274_1.typewritter.percent = (arg_274_1.time_ - var_277_0) / var_277_7

				arg_274_1.typewritter:SetDirty()
			end

			if arg_274_1.time_ >= var_277_0 + var_277_7 and arg_274_1.time_ < var_277_0 + var_277_7 + arg_277_0 then
				arg_274_1.typewritter.percent = 1

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(true)
			end
		end

		arg_274_1.nodeConfigList_ = {}

		arg_274_1:InitPlayNodeList()
	end,
	Play1102205067 = function(arg_278_0, arg_278_1)
		arg_278_1.time_ = 0
		arg_278_1.frameCnt_ = 0
		arg_278_1.state_ = "playing"
		arg_278_1.curTalkId_ = 1102205067
		arg_278_1.duration_ = 2

		SetActive(arg_278_1.tipsGo_, false)

		function arg_278_1.onSingleLineFinish_()
			arg_278_1.onSingleLineUpdate_ = nil
			arg_278_1.onSingleLineFinish_ = nil
			arg_278_1.state_ = "waiting"
		end

		function arg_278_1.playNext_(arg_280_0)
			if arg_280_0 == 1 then
				arg_278_0:Play1102205068(arg_278_1)
			end
		end

		function arg_278_1.onSingleLineUpdate_(arg_281_0)
			local var_281_0 = arg_278_1.actors_["1022ui_story"]
			local var_281_1 = 0

			if var_281_1 < arg_278_1.time_ and arg_278_1.time_ <= var_281_1 + arg_281_0 and not isNil(var_281_0) and arg_278_1.var_.characterEffect1022ui_story == nil then
				arg_278_1.var_.characterEffect1022ui_story = var_281_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_281_2 = 0.200000002980232

			if var_281_1 <= arg_278_1.time_ and arg_278_1.time_ < var_281_1 + var_281_2 and not isNil(var_281_0) then
				local var_281_3 = (arg_278_1.time_ - var_281_1) / var_281_2

				if arg_278_1.var_.characterEffect1022ui_story and not isNil(var_281_0) then
					arg_278_1.var_.characterEffect1022ui_story.fillFlat = false
				end
			end

			if arg_278_1.time_ >= var_281_1 + var_281_2 and arg_278_1.time_ < var_281_1 + var_281_2 + arg_281_0 and not isNil(var_281_0) and arg_278_1.var_.characterEffect1022ui_story then
				arg_278_1.var_.characterEffect1022ui_story.fillFlat = false
			end

			local var_281_4 = 0

			if var_281_4 < arg_278_1.time_ and arg_278_1.time_ <= var_281_4 + arg_281_0 then
				arg_278_1:PlayTimeline("1022ui_story", "StoryTimeline/CharAction/story1022/story1022action/1022action1_1")
			end

			local var_281_5 = 0

			if var_281_5 < arg_278_1.time_ and arg_278_1.time_ <= var_281_5 + arg_281_0 then
				arg_278_1:PlayTimeline("1022ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_281_6 = 0
			local var_281_7 = 0.05

			if var_281_6 < arg_278_1.time_ and arg_278_1.time_ <= var_281_6 + arg_281_0 then
				arg_278_1.talkMaxDuration = 0
				arg_278_1.dialogCg_.alpha = 1

				arg_278_1.dialog_:SetActive(true)
				SetActive(arg_278_1.leftNameGo_, true)

				local var_281_8 = arg_278_1:FormatText(StoryNameCfg[259].name)

				arg_278_1.leftNameTxt_.text = var_281_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_278_1.leftNameTxt_.transform)

				arg_278_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_278_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_278_1:RecordName(arg_278_1.leftNameTxt_.text)
				SetActive(arg_278_1.iconTrs_.gameObject, false)
				arg_278_1.callingController_:SetSelectedState("normal")

				local var_281_9 = arg_278_1:GetWordFromCfg(1102205067)
				local var_281_10 = arg_278_1:FormatText(var_281_9.content)

				arg_278_1.text_.text = var_281_10

				LuaForUtil.ClearLinePrefixSymbol(arg_278_1.text_)

				local var_281_11 = 2
				local var_281_12 = utf8.len(var_281_10)
				local var_281_13 = var_281_11 <= 0 and var_281_7 or var_281_7 * (var_281_12 / var_281_11)

				if var_281_13 > 0 and var_281_7 < var_281_13 then
					arg_278_1.talkMaxDuration = var_281_13

					if var_281_13 + var_281_6 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_13 + var_281_6
					end
				end

				arg_278_1.text_.text = var_281_10
				arg_278_1.typewritter.percent = 0

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205067", "story_v_side_new_1102205.awb") ~= 0 then
					local var_281_14 = manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205067", "story_v_side_new_1102205.awb") / 1000

					if var_281_14 + var_281_6 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_14 + var_281_6
					end

					if var_281_9.prefab_name ~= "" and arg_278_1.actors_[var_281_9.prefab_name] ~= nil then
						local var_281_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_278_1.actors_[var_281_9.prefab_name].transform, "story_v_side_new_1102205", "1102205067", "story_v_side_new_1102205.awb")

						arg_278_1:RecordAudio("1102205067", var_281_15)
						arg_278_1:RecordAudio("1102205067", var_281_15)
					else
						arg_278_1:AudioAction("play", "voice", "story_v_side_new_1102205", "1102205067", "story_v_side_new_1102205.awb")
					end

					arg_278_1:RecordHistoryTalkVoice("story_v_side_new_1102205", "1102205067", "story_v_side_new_1102205.awb")
				end

				arg_278_1:RecordContent(arg_278_1.text_.text)
			end

			local var_281_16 = math.max(var_281_7, arg_278_1.talkMaxDuration)

			if var_281_6 <= arg_278_1.time_ and arg_278_1.time_ < var_281_6 + var_281_16 then
				arg_278_1.typewritter.percent = (arg_278_1.time_ - var_281_6) / var_281_16

				arg_278_1.typewritter:SetDirty()
			end

			if arg_278_1.time_ >= var_281_6 + var_281_16 and arg_278_1.time_ < var_281_6 + var_281_16 + arg_281_0 then
				arg_278_1.typewritter.percent = 1

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(true)
			end
		end

		arg_278_1.nodeConfigList_ = {}

		arg_278_1:InitPlayNodeList()
	end,
	Play1102205068 = function(arg_282_0, arg_282_1)
		arg_282_1.time_ = 0
		arg_282_1.frameCnt_ = 0
		arg_282_1.state_ = "playing"
		arg_282_1.curTalkId_ = 1102205068
		arg_282_1.duration_ = 5

		SetActive(arg_282_1.tipsGo_, false)

		function arg_282_1.onSingleLineFinish_()
			arg_282_1.onSingleLineUpdate_ = nil
			arg_282_1.onSingleLineFinish_ = nil
			arg_282_1.state_ = "waiting"
		end

		function arg_282_1.playNext_(arg_284_0)
			if arg_284_0 == 1 then
				arg_282_0:Play1102205069(arg_282_1)
			end
		end

		function arg_282_1.onSingleLineUpdate_(arg_285_0)
			local var_285_0 = arg_282_1.actors_["1022ui_story"]
			local var_285_1 = 0

			if var_285_1 < arg_282_1.time_ and arg_282_1.time_ <= var_285_1 + arg_285_0 and not isNil(var_285_0) and arg_282_1.var_.characterEffect1022ui_story == nil then
				arg_282_1.var_.characterEffect1022ui_story = var_285_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_285_2 = 0.200000002980232

			if var_285_1 <= arg_282_1.time_ and arg_282_1.time_ < var_285_1 + var_285_2 and not isNil(var_285_0) then
				local var_285_3 = (arg_282_1.time_ - var_285_1) / var_285_2

				if arg_282_1.var_.characterEffect1022ui_story and not isNil(var_285_0) then
					local var_285_4 = Mathf.Lerp(0, 0.5, var_285_3)

					arg_282_1.var_.characterEffect1022ui_story.fillFlat = true
					arg_282_1.var_.characterEffect1022ui_story.fillRatio = var_285_4
				end
			end

			if arg_282_1.time_ >= var_285_1 + var_285_2 and arg_282_1.time_ < var_285_1 + var_285_2 + arg_285_0 and not isNil(var_285_0) and arg_282_1.var_.characterEffect1022ui_story then
				local var_285_5 = 0.5

				arg_282_1.var_.characterEffect1022ui_story.fillFlat = true
				arg_282_1.var_.characterEffect1022ui_story.fillRatio = var_285_5
			end

			local var_285_6 = 0
			local var_285_7 = 0.55

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

				local var_285_9 = arg_282_1:GetWordFromCfg(1102205068)
				local var_285_10 = arg_282_1:FormatText(var_285_9.content)

				arg_282_1.text_.text = var_285_10

				LuaForUtil.ClearLinePrefixSymbol(arg_282_1.text_)

				local var_285_11 = 22
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
	Play1102205069 = function(arg_286_0, arg_286_1)
		arg_286_1.time_ = 0
		arg_286_1.frameCnt_ = 0
		arg_286_1.state_ = "playing"
		arg_286_1.curTalkId_ = 1102205069
		arg_286_1.duration_ = 5

		SetActive(arg_286_1.tipsGo_, false)

		function arg_286_1.onSingleLineFinish_()
			arg_286_1.onSingleLineUpdate_ = nil
			arg_286_1.onSingleLineFinish_ = nil
			arg_286_1.state_ = "waiting"
		end

		function arg_286_1.playNext_(arg_288_0)
			if arg_288_0 == 1 then
				arg_286_0:Play1102205070(arg_286_1)
			end
		end

		function arg_286_1.onSingleLineUpdate_(arg_289_0)
			local var_289_0 = 0
			local var_289_1 = 1.025

			if var_289_0 < arg_286_1.time_ and arg_286_1.time_ <= var_289_0 + arg_289_0 then
				arg_286_1.talkMaxDuration = 0
				arg_286_1.dialogCg_.alpha = 1

				arg_286_1.dialog_:SetActive(true)
				SetActive(arg_286_1.leftNameGo_, true)

				local var_289_2 = arg_286_1:FormatText(StoryNameCfg[7].name)

				arg_286_1.leftNameTxt_.text = var_289_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_286_1.leftNameTxt_.transform)

				arg_286_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_286_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_286_1:RecordName(arg_286_1.leftNameTxt_.text)
				SetActive(arg_286_1.iconTrs_.gameObject, true)
				arg_286_1.iconController_:SetSelectedState("hero")

				arg_286_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_286_1.callingController_:SetSelectedState("normal")

				arg_286_1.keyicon_.color = Color.New(1, 1, 1)
				arg_286_1.icon_.color = Color.New(1, 1, 1)

				local var_289_3 = arg_286_1:GetWordFromCfg(1102205069)
				local var_289_4 = arg_286_1:FormatText(var_289_3.content)

				arg_286_1.text_.text = var_289_4

				LuaForUtil.ClearLinePrefixSymbol(arg_286_1.text_)

				local var_289_5 = 41
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
				arg_286_1:RecordContent(arg_286_1.text_.text)
			end

			local var_289_8 = math.max(var_289_1, arg_286_1.talkMaxDuration)

			if var_289_0 <= arg_286_1.time_ and arg_286_1.time_ < var_289_0 + var_289_8 then
				arg_286_1.typewritter.percent = (arg_286_1.time_ - var_289_0) / var_289_8

				arg_286_1.typewritter:SetDirty()
			end

			if arg_286_1.time_ >= var_289_0 + var_289_8 and arg_286_1.time_ < var_289_0 + var_289_8 + arg_289_0 then
				arg_286_1.typewritter.percent = 1

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(true)
			end
		end

		arg_286_1.nodeConfigList_ = {}

		arg_286_1:InitPlayNodeList()
	end,
	Play1102205070 = function(arg_290_0, arg_290_1)
		arg_290_1.time_ = 0
		arg_290_1.frameCnt_ = 0
		arg_290_1.state_ = "playing"
		arg_290_1.curTalkId_ = 1102205070
		arg_290_1.duration_ = 5.13

		SetActive(arg_290_1.tipsGo_, false)

		function arg_290_1.onSingleLineFinish_()
			arg_290_1.onSingleLineUpdate_ = nil
			arg_290_1.onSingleLineFinish_ = nil
			arg_290_1.state_ = "waiting"
		end

		function arg_290_1.playNext_(arg_292_0)
			if arg_292_0 == 1 then
				arg_290_0:Play1102205071(arg_290_1)
			end
		end

		function arg_290_1.onSingleLineUpdate_(arg_293_0)
			local var_293_0 = arg_290_1.actors_["1022ui_story"]
			local var_293_1 = 0

			if var_293_1 < arg_290_1.time_ and arg_290_1.time_ <= var_293_1 + arg_293_0 and not isNil(var_293_0) and arg_290_1.var_.characterEffect1022ui_story == nil then
				arg_290_1.var_.characterEffect1022ui_story = var_293_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_293_2 = 0.200000002980232

			if var_293_1 <= arg_290_1.time_ and arg_290_1.time_ < var_293_1 + var_293_2 and not isNil(var_293_0) then
				local var_293_3 = (arg_290_1.time_ - var_293_1) / var_293_2

				if arg_290_1.var_.characterEffect1022ui_story and not isNil(var_293_0) then
					arg_290_1.var_.characterEffect1022ui_story.fillFlat = false
				end
			end

			if arg_290_1.time_ >= var_293_1 + var_293_2 and arg_290_1.time_ < var_293_1 + var_293_2 + arg_293_0 and not isNil(var_293_0) and arg_290_1.var_.characterEffect1022ui_story then
				arg_290_1.var_.characterEffect1022ui_story.fillFlat = false
			end

			local var_293_4 = 0

			if var_293_4 < arg_290_1.time_ and arg_290_1.time_ <= var_293_4 + arg_293_0 then
				arg_290_1:PlayTimeline("1022ui_story", "StoryTimeline/CharAction/story1022/story1022action/1022action3_1")
			end

			local var_293_5 = 0

			if var_293_5 < arg_290_1.time_ and arg_290_1.time_ <= var_293_5 + arg_293_0 then
				arg_290_1:PlayTimeline("1022ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_293_6 = 0
			local var_293_7 = 0.425

			if var_293_6 < arg_290_1.time_ and arg_290_1.time_ <= var_293_6 + arg_293_0 then
				arg_290_1.talkMaxDuration = 0
				arg_290_1.dialogCg_.alpha = 1

				arg_290_1.dialog_:SetActive(true)
				SetActive(arg_290_1.leftNameGo_, true)

				local var_293_8 = arg_290_1:FormatText(StoryNameCfg[259].name)

				arg_290_1.leftNameTxt_.text = var_293_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_290_1.leftNameTxt_.transform)

				arg_290_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_290_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_290_1:RecordName(arg_290_1.leftNameTxt_.text)
				SetActive(arg_290_1.iconTrs_.gameObject, false)
				arg_290_1.callingController_:SetSelectedState("normal")

				local var_293_9 = arg_290_1:GetWordFromCfg(1102205070)
				local var_293_10 = arg_290_1:FormatText(var_293_9.content)

				arg_290_1.text_.text = var_293_10

				LuaForUtil.ClearLinePrefixSymbol(arg_290_1.text_)

				local var_293_11 = 17
				local var_293_12 = utf8.len(var_293_10)
				local var_293_13 = var_293_11 <= 0 and var_293_7 or var_293_7 * (var_293_12 / var_293_11)

				if var_293_13 > 0 and var_293_7 < var_293_13 then
					arg_290_1.talkMaxDuration = var_293_13

					if var_293_13 + var_293_6 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_13 + var_293_6
					end
				end

				arg_290_1.text_.text = var_293_10
				arg_290_1.typewritter.percent = 0

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205070", "story_v_side_new_1102205.awb") ~= 0 then
					local var_293_14 = manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205070", "story_v_side_new_1102205.awb") / 1000

					if var_293_14 + var_293_6 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_14 + var_293_6
					end

					if var_293_9.prefab_name ~= "" and arg_290_1.actors_[var_293_9.prefab_name] ~= nil then
						local var_293_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_290_1.actors_[var_293_9.prefab_name].transform, "story_v_side_new_1102205", "1102205070", "story_v_side_new_1102205.awb")

						arg_290_1:RecordAudio("1102205070", var_293_15)
						arg_290_1:RecordAudio("1102205070", var_293_15)
					else
						arg_290_1:AudioAction("play", "voice", "story_v_side_new_1102205", "1102205070", "story_v_side_new_1102205.awb")
					end

					arg_290_1:RecordHistoryTalkVoice("story_v_side_new_1102205", "1102205070", "story_v_side_new_1102205.awb")
				end

				arg_290_1:RecordContent(arg_290_1.text_.text)
			end

			local var_293_16 = math.max(var_293_7, arg_290_1.talkMaxDuration)

			if var_293_6 <= arg_290_1.time_ and arg_290_1.time_ < var_293_6 + var_293_16 then
				arg_290_1.typewritter.percent = (arg_290_1.time_ - var_293_6) / var_293_16

				arg_290_1.typewritter:SetDirty()
			end

			if arg_290_1.time_ >= var_293_6 + var_293_16 and arg_290_1.time_ < var_293_6 + var_293_16 + arg_293_0 then
				arg_290_1.typewritter.percent = 1

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(true)
			end
		end

		arg_290_1.nodeConfigList_ = {}

		arg_290_1:InitPlayNodeList()
	end,
	Play1102205071 = function(arg_294_0, arg_294_1)
		arg_294_1.time_ = 0
		arg_294_1.frameCnt_ = 0
		arg_294_1.state_ = "playing"
		arg_294_1.curTalkId_ = 1102205071
		arg_294_1.duration_ = 5

		SetActive(arg_294_1.tipsGo_, false)

		function arg_294_1.onSingleLineFinish_()
			arg_294_1.onSingleLineUpdate_ = nil
			arg_294_1.onSingleLineFinish_ = nil
			arg_294_1.state_ = "waiting"
		end

		function arg_294_1.playNext_(arg_296_0)
			if arg_296_0 == 1 then
				arg_294_0:Play1102205072(arg_294_1)
			end
		end

		function arg_294_1.onSingleLineUpdate_(arg_297_0)
			local var_297_0 = arg_294_1.actors_["1022ui_story"]
			local var_297_1 = 0

			if var_297_1 < arg_294_1.time_ and arg_294_1.time_ <= var_297_1 + arg_297_0 and not isNil(var_297_0) and arg_294_1.var_.characterEffect1022ui_story == nil then
				arg_294_1.var_.characterEffect1022ui_story = var_297_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_297_2 = 0.200000002980232

			if var_297_1 <= arg_294_1.time_ and arg_294_1.time_ < var_297_1 + var_297_2 and not isNil(var_297_0) then
				local var_297_3 = (arg_294_1.time_ - var_297_1) / var_297_2

				if arg_294_1.var_.characterEffect1022ui_story and not isNil(var_297_0) then
					local var_297_4 = Mathf.Lerp(0, 0.5, var_297_3)

					arg_294_1.var_.characterEffect1022ui_story.fillFlat = true
					arg_294_1.var_.characterEffect1022ui_story.fillRatio = var_297_4
				end
			end

			if arg_294_1.time_ >= var_297_1 + var_297_2 and arg_294_1.time_ < var_297_1 + var_297_2 + arg_297_0 and not isNil(var_297_0) and arg_294_1.var_.characterEffect1022ui_story then
				local var_297_5 = 0.5

				arg_294_1.var_.characterEffect1022ui_story.fillFlat = true
				arg_294_1.var_.characterEffect1022ui_story.fillRatio = var_297_5
			end

			local var_297_6 = 0
			local var_297_7 = 0.45

			if var_297_6 < arg_294_1.time_ and arg_294_1.time_ <= var_297_6 + arg_297_0 then
				arg_294_1.talkMaxDuration = 0
				arg_294_1.dialogCg_.alpha = 1

				arg_294_1.dialog_:SetActive(true)
				SetActive(arg_294_1.leftNameGo_, true)

				local var_297_8 = arg_294_1:FormatText(StoryNameCfg[7].name)

				arg_294_1.leftNameTxt_.text = var_297_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_294_1.leftNameTxt_.transform)

				arg_294_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_294_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_294_1:RecordName(arg_294_1.leftNameTxt_.text)
				SetActive(arg_294_1.iconTrs_.gameObject, true)
				arg_294_1.iconController_:SetSelectedState("hero")

				arg_294_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_294_1.callingController_:SetSelectedState("normal")

				arg_294_1.keyicon_.color = Color.New(1, 1, 1)
				arg_294_1.icon_.color = Color.New(1, 1, 1)

				local var_297_9 = arg_294_1:GetWordFromCfg(1102205071)
				local var_297_10 = arg_294_1:FormatText(var_297_9.content)

				arg_294_1.text_.text = var_297_10

				LuaForUtil.ClearLinePrefixSymbol(arg_294_1.text_)

				local var_297_11 = 18
				local var_297_12 = utf8.len(var_297_10)
				local var_297_13 = var_297_11 <= 0 and var_297_7 or var_297_7 * (var_297_12 / var_297_11)

				if var_297_13 > 0 and var_297_7 < var_297_13 then
					arg_294_1.talkMaxDuration = var_297_13

					if var_297_13 + var_297_6 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_13 + var_297_6
					end
				end

				arg_294_1.text_.text = var_297_10
				arg_294_1.typewritter.percent = 0

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(false)
				arg_294_1:RecordContent(arg_294_1.text_.text)
			end

			local var_297_14 = math.max(var_297_7, arg_294_1.talkMaxDuration)

			if var_297_6 <= arg_294_1.time_ and arg_294_1.time_ < var_297_6 + var_297_14 then
				arg_294_1.typewritter.percent = (arg_294_1.time_ - var_297_6) / var_297_14

				arg_294_1.typewritter:SetDirty()
			end

			if arg_294_1.time_ >= var_297_6 + var_297_14 and arg_294_1.time_ < var_297_6 + var_297_14 + arg_297_0 then
				arg_294_1.typewritter.percent = 1

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(true)
			end
		end

		arg_294_1.nodeConfigList_ = {}

		arg_294_1:InitPlayNodeList()
	end,
	Play1102205072 = function(arg_298_0, arg_298_1)
		arg_298_1.time_ = 0
		arg_298_1.frameCnt_ = 0
		arg_298_1.state_ = "playing"
		arg_298_1.curTalkId_ = 1102205072
		arg_298_1.duration_ = 5

		SetActive(arg_298_1.tipsGo_, false)

		function arg_298_1.onSingleLineFinish_()
			arg_298_1.onSingleLineUpdate_ = nil
			arg_298_1.onSingleLineFinish_ = nil
			arg_298_1.state_ = "waiting"
		end

		function arg_298_1.playNext_(arg_300_0)
			if arg_300_0 == 1 then
				arg_298_0:Play1102205073(arg_298_1)
			end
		end

		function arg_298_1.onSingleLineUpdate_(arg_301_0)
			local var_301_0 = arg_298_1.actors_["1022ui_story"].transform
			local var_301_1 = 0

			if var_301_1 < arg_298_1.time_ and arg_298_1.time_ <= var_301_1 + arg_301_0 then
				arg_298_1.var_.moveOldPos1022ui_story = var_301_0.localPosition
			end

			local var_301_2 = 0.001

			if var_301_1 <= arg_298_1.time_ and arg_298_1.time_ < var_301_1 + var_301_2 then
				local var_301_3 = (arg_298_1.time_ - var_301_1) / var_301_2
				local var_301_4 = Vector3.New(0, 100, 0)

				var_301_0.localPosition = Vector3.Lerp(arg_298_1.var_.moveOldPos1022ui_story, var_301_4, var_301_3)

				local var_301_5 = manager.ui.mainCamera.transform.position - var_301_0.position

				var_301_0.forward = Vector3.New(var_301_5.x, var_301_5.y, var_301_5.z)

				local var_301_6 = var_301_0.localEulerAngles

				var_301_6.z = 0
				var_301_6.x = 0
				var_301_0.localEulerAngles = var_301_6
			end

			if arg_298_1.time_ >= var_301_1 + var_301_2 and arg_298_1.time_ < var_301_1 + var_301_2 + arg_301_0 then
				var_301_0.localPosition = Vector3.New(0, 100, 0)

				local var_301_7 = manager.ui.mainCamera.transform.position - var_301_0.position

				var_301_0.forward = Vector3.New(var_301_7.x, var_301_7.y, var_301_7.z)

				local var_301_8 = var_301_0.localEulerAngles

				var_301_8.z = 0
				var_301_8.x = 0
				var_301_0.localEulerAngles = var_301_8
			end

			local var_301_9 = 0
			local var_301_10 = 1.225

			if var_301_9 < arg_298_1.time_ and arg_298_1.time_ <= var_301_9 + arg_301_0 then
				arg_298_1.talkMaxDuration = 0
				arg_298_1.dialogCg_.alpha = 1

				arg_298_1.dialog_:SetActive(true)
				SetActive(arg_298_1.leftNameGo_, false)

				arg_298_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_298_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_298_1:RecordName(arg_298_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_298_1.iconTrs_.gameObject, false)
				arg_298_1.callingController_:SetSelectedState("normal")

				local var_301_11 = arg_298_1:GetWordFromCfg(1102205072)
				local var_301_12 = arg_298_1:FormatText(var_301_11.content)

				arg_298_1.text_.text = var_301_12

				LuaForUtil.ClearLinePrefixSymbol(arg_298_1.text_)

				local var_301_13 = 49
				local var_301_14 = utf8.len(var_301_12)
				local var_301_15 = var_301_13 <= 0 and var_301_10 or var_301_10 * (var_301_14 / var_301_13)

				if var_301_15 > 0 and var_301_10 < var_301_15 then
					arg_298_1.talkMaxDuration = var_301_15

					if var_301_15 + var_301_9 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_15 + var_301_9
					end
				end

				arg_298_1.text_.text = var_301_12
				arg_298_1.typewritter.percent = 0

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(false)
				arg_298_1:RecordContent(arg_298_1.text_.text)
			end

			local var_301_16 = math.max(var_301_10, arg_298_1.talkMaxDuration)

			if var_301_9 <= arg_298_1.time_ and arg_298_1.time_ < var_301_9 + var_301_16 then
				arg_298_1.typewritter.percent = (arg_298_1.time_ - var_301_9) / var_301_16

				arg_298_1.typewritter:SetDirty()
			end

			if arg_298_1.time_ >= var_301_9 + var_301_16 and arg_298_1.time_ < var_301_9 + var_301_16 + arg_301_0 then
				arg_298_1.typewritter.percent = 1

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(true)
			end
		end

		arg_298_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1022ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_298_1:InitPlayNodeList()
	end,
	Play1102205073 = function(arg_302_0, arg_302_1)
		arg_302_1.time_ = 0
		arg_302_1.frameCnt_ = 0
		arg_302_1.state_ = "playing"
		arg_302_1.curTalkId_ = 1102205073
		arg_302_1.duration_ = 5.03

		SetActive(arg_302_1.tipsGo_, false)

		function arg_302_1.onSingleLineFinish_()
			arg_302_1.onSingleLineUpdate_ = nil
			arg_302_1.onSingleLineFinish_ = nil
			arg_302_1.state_ = "waiting"
		end

		function arg_302_1.playNext_(arg_304_0)
			if arg_304_0 == 1 then
				arg_302_0:Play1102205074(arg_302_1)
			end
		end

		function arg_302_1.onSingleLineUpdate_(arg_305_0)
			local var_305_0 = arg_302_1.actors_["1022ui_story"].transform
			local var_305_1 = 0

			if var_305_1 < arg_302_1.time_ and arg_302_1.time_ <= var_305_1 + arg_305_0 then
				arg_302_1.var_.moveOldPos1022ui_story = var_305_0.localPosition
			end

			local var_305_2 = 0.001

			if var_305_1 <= arg_302_1.time_ and arg_302_1.time_ < var_305_1 + var_305_2 then
				local var_305_3 = (arg_302_1.time_ - var_305_1) / var_305_2
				local var_305_4 = Vector3.New(0, -1.08, -6)

				var_305_0.localPosition = Vector3.Lerp(arg_302_1.var_.moveOldPos1022ui_story, var_305_4, var_305_3)

				local var_305_5 = manager.ui.mainCamera.transform.position - var_305_0.position

				var_305_0.forward = Vector3.New(var_305_5.x, var_305_5.y, var_305_5.z)

				local var_305_6 = var_305_0.localEulerAngles

				var_305_6.z = 0
				var_305_6.x = 0
				var_305_0.localEulerAngles = var_305_6
			end

			if arg_302_1.time_ >= var_305_1 + var_305_2 and arg_302_1.time_ < var_305_1 + var_305_2 + arg_305_0 then
				var_305_0.localPosition = Vector3.New(0, -1.08, -6)

				local var_305_7 = manager.ui.mainCamera.transform.position - var_305_0.position

				var_305_0.forward = Vector3.New(var_305_7.x, var_305_7.y, var_305_7.z)

				local var_305_8 = var_305_0.localEulerAngles

				var_305_8.z = 0
				var_305_8.x = 0
				var_305_0.localEulerAngles = var_305_8
			end

			local var_305_9 = arg_302_1.actors_["1022ui_story"]
			local var_305_10 = 0

			if var_305_10 < arg_302_1.time_ and arg_302_1.time_ <= var_305_10 + arg_305_0 and not isNil(var_305_9) and arg_302_1.var_.characterEffect1022ui_story == nil then
				arg_302_1.var_.characterEffect1022ui_story = var_305_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_305_11 = 0.200000002980232

			if var_305_10 <= arg_302_1.time_ and arg_302_1.time_ < var_305_10 + var_305_11 and not isNil(var_305_9) then
				local var_305_12 = (arg_302_1.time_ - var_305_10) / var_305_11

				if arg_302_1.var_.characterEffect1022ui_story and not isNil(var_305_9) then
					arg_302_1.var_.characterEffect1022ui_story.fillFlat = false
				end
			end

			if arg_302_1.time_ >= var_305_10 + var_305_11 and arg_302_1.time_ < var_305_10 + var_305_11 + arg_305_0 and not isNil(var_305_9) and arg_302_1.var_.characterEffect1022ui_story then
				arg_302_1.var_.characterEffect1022ui_story.fillFlat = false
			end

			local var_305_13 = 0

			if var_305_13 < arg_302_1.time_ and arg_302_1.time_ <= var_305_13 + arg_305_0 then
				arg_302_1:PlayTimeline("1022ui_story", "StoryTimeline/CharAction/story1022/story1022action/1022action3_2")
			end

			local var_305_14 = 0

			if var_305_14 < arg_302_1.time_ and arg_302_1.time_ <= var_305_14 + arg_305_0 then
				arg_302_1:PlayTimeline("1022ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_305_15 = 0
			local var_305_16 = 0.55

			if var_305_15 < arg_302_1.time_ and arg_302_1.time_ <= var_305_15 + arg_305_0 then
				arg_302_1.talkMaxDuration = 0
				arg_302_1.dialogCg_.alpha = 1

				arg_302_1.dialog_:SetActive(true)
				SetActive(arg_302_1.leftNameGo_, true)

				local var_305_17 = arg_302_1:FormatText(StoryNameCfg[259].name)

				arg_302_1.leftNameTxt_.text = var_305_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_302_1.leftNameTxt_.transform)

				arg_302_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_302_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_302_1:RecordName(arg_302_1.leftNameTxt_.text)
				SetActive(arg_302_1.iconTrs_.gameObject, false)
				arg_302_1.callingController_:SetSelectedState("normal")

				local var_305_18 = arg_302_1:GetWordFromCfg(1102205073)
				local var_305_19 = arg_302_1:FormatText(var_305_18.content)

				arg_302_1.text_.text = var_305_19

				LuaForUtil.ClearLinePrefixSymbol(arg_302_1.text_)

				local var_305_20 = 22
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

				if manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205073", "story_v_side_new_1102205.awb") ~= 0 then
					local var_305_23 = manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205073", "story_v_side_new_1102205.awb") / 1000

					if var_305_23 + var_305_15 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_23 + var_305_15
					end

					if var_305_18.prefab_name ~= "" and arg_302_1.actors_[var_305_18.prefab_name] ~= nil then
						local var_305_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_302_1.actors_[var_305_18.prefab_name].transform, "story_v_side_new_1102205", "1102205073", "story_v_side_new_1102205.awb")

						arg_302_1:RecordAudio("1102205073", var_305_24)
						arg_302_1:RecordAudio("1102205073", var_305_24)
					else
						arg_302_1:AudioAction("play", "voice", "story_v_side_new_1102205", "1102205073", "story_v_side_new_1102205.awb")
					end

					arg_302_1:RecordHistoryTalkVoice("story_v_side_new_1102205", "1102205073", "story_v_side_new_1102205.awb")
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
				actorName = "1022ui_story",
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
	Play1102205074 = function(arg_306_0, arg_306_1)
		arg_306_1.time_ = 0
		arg_306_1.frameCnt_ = 0
		arg_306_1.state_ = "playing"
		arg_306_1.curTalkId_ = 1102205074
		arg_306_1.duration_ = 5

		SetActive(arg_306_1.tipsGo_, false)

		function arg_306_1.onSingleLineFinish_()
			arg_306_1.onSingleLineUpdate_ = nil
			arg_306_1.onSingleLineFinish_ = nil
			arg_306_1.state_ = "waiting"
		end

		function arg_306_1.playNext_(arg_308_0)
			if arg_308_0 == 1 then
				arg_306_0:Play1102205075(arg_306_1)
			end
		end

		function arg_306_1.onSingleLineUpdate_(arg_309_0)
			local var_309_0 = arg_306_1.actors_["1022ui_story"]
			local var_309_1 = 0

			if var_309_1 < arg_306_1.time_ and arg_306_1.time_ <= var_309_1 + arg_309_0 and not isNil(var_309_0) and arg_306_1.var_.characterEffect1022ui_story == nil then
				arg_306_1.var_.characterEffect1022ui_story = var_309_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_309_2 = 0.200000002980232

			if var_309_1 <= arg_306_1.time_ and arg_306_1.time_ < var_309_1 + var_309_2 and not isNil(var_309_0) then
				local var_309_3 = (arg_306_1.time_ - var_309_1) / var_309_2

				if arg_306_1.var_.characterEffect1022ui_story and not isNil(var_309_0) then
					local var_309_4 = Mathf.Lerp(0, 0.5, var_309_3)

					arg_306_1.var_.characterEffect1022ui_story.fillFlat = true
					arg_306_1.var_.characterEffect1022ui_story.fillRatio = var_309_4
				end
			end

			if arg_306_1.time_ >= var_309_1 + var_309_2 and arg_306_1.time_ < var_309_1 + var_309_2 + arg_309_0 and not isNil(var_309_0) and arg_306_1.var_.characterEffect1022ui_story then
				local var_309_5 = 0.5

				arg_306_1.var_.characterEffect1022ui_story.fillFlat = true
				arg_306_1.var_.characterEffect1022ui_story.fillRatio = var_309_5
			end

			local var_309_6 = 0
			local var_309_7 = 0.6

			if var_309_6 < arg_306_1.time_ and arg_306_1.time_ <= var_309_6 + arg_309_0 then
				arg_306_1.talkMaxDuration = 0
				arg_306_1.dialogCg_.alpha = 1

				arg_306_1.dialog_:SetActive(true)
				SetActive(arg_306_1.leftNameGo_, false)

				arg_306_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_306_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_306_1:RecordName(arg_306_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_306_1.iconTrs_.gameObject, false)
				arg_306_1.callingController_:SetSelectedState("normal")

				local var_309_8 = arg_306_1:GetWordFromCfg(1102205074)
				local var_309_9 = arg_306_1:FormatText(var_309_8.content)

				arg_306_1.text_.text = var_309_9

				LuaForUtil.ClearLinePrefixSymbol(arg_306_1.text_)

				local var_309_10 = 24
				local var_309_11 = utf8.len(var_309_9)
				local var_309_12 = var_309_10 <= 0 and var_309_7 or var_309_7 * (var_309_11 / var_309_10)

				if var_309_12 > 0 and var_309_7 < var_309_12 then
					arg_306_1.talkMaxDuration = var_309_12

					if var_309_12 + var_309_6 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_12 + var_309_6
					end
				end

				arg_306_1.text_.text = var_309_9
				arg_306_1.typewritter.percent = 0

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(false)
				arg_306_1:RecordContent(arg_306_1.text_.text)
			end

			local var_309_13 = math.max(var_309_7, arg_306_1.talkMaxDuration)

			if var_309_6 <= arg_306_1.time_ and arg_306_1.time_ < var_309_6 + var_309_13 then
				arg_306_1.typewritter.percent = (arg_306_1.time_ - var_309_6) / var_309_13

				arg_306_1.typewritter:SetDirty()
			end

			if arg_306_1.time_ >= var_309_6 + var_309_13 and arg_306_1.time_ < var_309_6 + var_309_13 + arg_309_0 then
				arg_306_1.typewritter.percent = 1

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(true)
			end
		end

		arg_306_1.nodeConfigList_ = {}

		arg_306_1:InitPlayNodeList()
	end,
	Play1102205075 = function(arg_310_0, arg_310_1)
		arg_310_1.time_ = 0
		arg_310_1.frameCnt_ = 0
		arg_310_1.state_ = "playing"
		arg_310_1.curTalkId_ = 1102205075
		arg_310_1.duration_ = 5

		SetActive(arg_310_1.tipsGo_, false)

		function arg_310_1.onSingleLineFinish_()
			arg_310_1.onSingleLineUpdate_ = nil
			arg_310_1.onSingleLineFinish_ = nil
			arg_310_1.state_ = "waiting"
		end

		function arg_310_1.playNext_(arg_312_0)
			if arg_312_0 == 1 then
				arg_310_0:Play1102205076(arg_310_1)
			end
		end

		function arg_310_1.onSingleLineUpdate_(arg_313_0)
			local var_313_0 = 0
			local var_313_1 = 0.775

			if var_313_0 < arg_310_1.time_ and arg_310_1.time_ <= var_313_0 + arg_313_0 then
				arg_310_1.talkMaxDuration = 0
				arg_310_1.dialogCg_.alpha = 1

				arg_310_1.dialog_:SetActive(true)
				SetActive(arg_310_1.leftNameGo_, true)

				local var_313_2 = arg_310_1:FormatText(StoryNameCfg[7].name)

				arg_310_1.leftNameTxt_.text = var_313_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_310_1.leftNameTxt_.transform)

				arg_310_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_310_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_310_1:RecordName(arg_310_1.leftNameTxt_.text)
				SetActive(arg_310_1.iconTrs_.gameObject, true)
				arg_310_1.iconController_:SetSelectedState("hero")

				arg_310_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_310_1.callingController_:SetSelectedState("normal")

				arg_310_1.keyicon_.color = Color.New(1, 1, 1)
				arg_310_1.icon_.color = Color.New(1, 1, 1)

				local var_313_3 = arg_310_1:GetWordFromCfg(1102205075)
				local var_313_4 = arg_310_1:FormatText(var_313_3.content)

				arg_310_1.text_.text = var_313_4

				LuaForUtil.ClearLinePrefixSymbol(arg_310_1.text_)

				local var_313_5 = 31
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
				arg_310_1:RecordContent(arg_310_1.text_.text)
			end

			local var_313_8 = math.max(var_313_1, arg_310_1.talkMaxDuration)

			if var_313_0 <= arg_310_1.time_ and arg_310_1.time_ < var_313_0 + var_313_8 then
				arg_310_1.typewritter.percent = (arg_310_1.time_ - var_313_0) / var_313_8

				arg_310_1.typewritter:SetDirty()
			end

			if arg_310_1.time_ >= var_313_0 + var_313_8 and arg_310_1.time_ < var_313_0 + var_313_8 + arg_313_0 then
				arg_310_1.typewritter.percent = 1

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(true)
			end
		end

		arg_310_1.nodeConfigList_ = {}

		arg_310_1:InitPlayNodeList()
	end,
	Play1102205076 = function(arg_314_0, arg_314_1)
		arg_314_1.time_ = 0
		arg_314_1.frameCnt_ = 0
		arg_314_1.state_ = "playing"
		arg_314_1.curTalkId_ = 1102205076
		arg_314_1.duration_ = 5

		SetActive(arg_314_1.tipsGo_, false)

		function arg_314_1.onSingleLineFinish_()
			arg_314_1.onSingleLineUpdate_ = nil
			arg_314_1.onSingleLineFinish_ = nil
			arg_314_1.state_ = "waiting"
		end

		function arg_314_1.playNext_(arg_316_0)
			if arg_316_0 == 1 then
				arg_314_0:Play1102205077(arg_314_1)
			end
		end

		function arg_314_1.onSingleLineUpdate_(arg_317_0)
			local var_317_0 = arg_314_1.actors_["1022ui_story"].transform
			local var_317_1 = 0

			if var_317_1 < arg_314_1.time_ and arg_314_1.time_ <= var_317_1 + arg_317_0 then
				arg_314_1.var_.moveOldPos1022ui_story = var_317_0.localPosition
			end

			local var_317_2 = 0.001

			if var_317_1 <= arg_314_1.time_ and arg_314_1.time_ < var_317_1 + var_317_2 then
				local var_317_3 = (arg_314_1.time_ - var_317_1) / var_317_2
				local var_317_4 = Vector3.New(0, 100, 0)

				var_317_0.localPosition = Vector3.Lerp(arg_314_1.var_.moveOldPos1022ui_story, var_317_4, var_317_3)

				local var_317_5 = manager.ui.mainCamera.transform.position - var_317_0.position

				var_317_0.forward = Vector3.New(var_317_5.x, var_317_5.y, var_317_5.z)

				local var_317_6 = var_317_0.localEulerAngles

				var_317_6.z = 0
				var_317_6.x = 0
				var_317_0.localEulerAngles = var_317_6
			end

			if arg_314_1.time_ >= var_317_1 + var_317_2 and arg_314_1.time_ < var_317_1 + var_317_2 + arg_317_0 then
				var_317_0.localPosition = Vector3.New(0, 100, 0)

				local var_317_7 = manager.ui.mainCamera.transform.position - var_317_0.position

				var_317_0.forward = Vector3.New(var_317_7.x, var_317_7.y, var_317_7.z)

				local var_317_8 = var_317_0.localEulerAngles

				var_317_8.z = 0
				var_317_8.x = 0
				var_317_0.localEulerAngles = var_317_8
			end

			local var_317_9 = 0.034000001847744
			local var_317_10 = 1

			if var_317_9 < arg_314_1.time_ and arg_314_1.time_ <= var_317_9 + arg_317_0 then
				local var_317_11 = "play"
				local var_317_12 = "effect"

				arg_314_1:AudioAction(var_317_11, var_317_12, "se_story_144", "se_story_144_door_open", "")
			end

			local var_317_13 = 0
			local var_317_14 = 0.85

			if var_317_13 < arg_314_1.time_ and arg_314_1.time_ <= var_317_13 + arg_317_0 then
				arg_314_1.talkMaxDuration = 0
				arg_314_1.dialogCg_.alpha = 1

				arg_314_1.dialog_:SetActive(true)
				SetActive(arg_314_1.leftNameGo_, false)

				arg_314_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_314_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_314_1:RecordName(arg_314_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_314_1.iconTrs_.gameObject, false)
				arg_314_1.callingController_:SetSelectedState("normal")

				local var_317_15 = arg_314_1:GetWordFromCfg(1102205076)
				local var_317_16 = arg_314_1:FormatText(var_317_15.content)

				arg_314_1.text_.text = var_317_16

				LuaForUtil.ClearLinePrefixSymbol(arg_314_1.text_)

				local var_317_17 = 34
				local var_317_18 = utf8.len(var_317_16)
				local var_317_19 = var_317_17 <= 0 and var_317_14 or var_317_14 * (var_317_18 / var_317_17)

				if var_317_19 > 0 and var_317_14 < var_317_19 then
					arg_314_1.talkMaxDuration = var_317_19

					if var_317_19 + var_317_13 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_19 + var_317_13
					end
				end

				arg_314_1.text_.text = var_317_16
				arg_314_1.typewritter.percent = 0

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(false)
				arg_314_1:RecordContent(arg_314_1.text_.text)
			end

			local var_317_20 = math.max(var_317_14, arg_314_1.talkMaxDuration)

			if var_317_13 <= arg_314_1.time_ and arg_314_1.time_ < var_317_13 + var_317_20 then
				arg_314_1.typewritter.percent = (arg_314_1.time_ - var_317_13) / var_317_20

				arg_314_1.typewritter:SetDirty()
			end

			if arg_314_1.time_ >= var_317_13 + var_317_20 and arg_314_1.time_ < var_317_13 + var_317_20 + arg_317_0 then
				arg_314_1.typewritter.percent = 1

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(true)
			end
		end

		arg_314_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1022ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_314_1:InitPlayNodeList()
	end,
	Play1102205077 = function(arg_318_0, arg_318_1)
		arg_318_1.time_ = 0
		arg_318_1.frameCnt_ = 0
		arg_318_1.state_ = "playing"
		arg_318_1.curTalkId_ = 1102205077
		arg_318_1.duration_ = 4.6

		SetActive(arg_318_1.tipsGo_, false)

		function arg_318_1.onSingleLineFinish_()
			arg_318_1.onSingleLineUpdate_ = nil
			arg_318_1.onSingleLineFinish_ = nil
			arg_318_1.state_ = "waiting"
		end

		function arg_318_1.playNext_(arg_320_0)
			if arg_320_0 == 1 then
				arg_318_0:Play1102205078(arg_318_1)
			end
		end

		function arg_318_1.onSingleLineUpdate_(arg_321_0)
			local var_321_0 = arg_318_1.actors_["1022ui_story"]
			local var_321_1 = 0

			if var_321_1 < arg_318_1.time_ and arg_318_1.time_ <= var_321_1 + arg_321_0 and not isNil(var_321_0) and arg_318_1.var_.characterEffect1022ui_story == nil then
				arg_318_1.var_.characterEffect1022ui_story = var_321_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_321_2 = 0.200000002980232

			if var_321_1 <= arg_318_1.time_ and arg_318_1.time_ < var_321_1 + var_321_2 and not isNil(var_321_0) then
				local var_321_3 = (arg_318_1.time_ - var_321_1) / var_321_2

				if arg_318_1.var_.characterEffect1022ui_story and not isNil(var_321_0) then
					arg_318_1.var_.characterEffect1022ui_story.fillFlat = false
				end
			end

			if arg_318_1.time_ >= var_321_1 + var_321_2 and arg_318_1.time_ < var_321_1 + var_321_2 + arg_321_0 and not isNil(var_321_0) and arg_318_1.var_.characterEffect1022ui_story then
				arg_318_1.var_.characterEffect1022ui_story.fillFlat = false
			end

			local var_321_4 = 0

			if var_321_4 < arg_318_1.time_ and arg_318_1.time_ <= var_321_4 + arg_321_0 then
				arg_318_1:PlayTimeline("1022ui_story", "StoryTimeline/CharAction/story1022/story1022action/1022action7_1")
			end

			local var_321_5 = arg_318_1.actors_["1022ui_story"].transform
			local var_321_6 = 0

			if var_321_6 < arg_318_1.time_ and arg_318_1.time_ <= var_321_6 + arg_321_0 then
				arg_318_1.var_.moveOldPos1022ui_story = var_321_5.localPosition
			end

			local var_321_7 = 0.001

			if var_321_6 <= arg_318_1.time_ and arg_318_1.time_ < var_321_6 + var_321_7 then
				local var_321_8 = (arg_318_1.time_ - var_321_6) / var_321_7
				local var_321_9 = Vector3.New(0, -1.08, -6)

				var_321_5.localPosition = Vector3.Lerp(arg_318_1.var_.moveOldPos1022ui_story, var_321_9, var_321_8)

				local var_321_10 = manager.ui.mainCamera.transform.position - var_321_5.position

				var_321_5.forward = Vector3.New(var_321_10.x, var_321_10.y, var_321_10.z)

				local var_321_11 = var_321_5.localEulerAngles

				var_321_11.z = 0
				var_321_11.x = 0
				var_321_5.localEulerAngles = var_321_11
			end

			if arg_318_1.time_ >= var_321_6 + var_321_7 and arg_318_1.time_ < var_321_6 + var_321_7 + arg_321_0 then
				var_321_5.localPosition = Vector3.New(0, -1.08, -6)

				local var_321_12 = manager.ui.mainCamera.transform.position - var_321_5.position

				var_321_5.forward = Vector3.New(var_321_12.x, var_321_12.y, var_321_12.z)

				local var_321_13 = var_321_5.localEulerAngles

				var_321_13.z = 0
				var_321_13.x = 0
				var_321_5.localEulerAngles = var_321_13
			end

			local var_321_14 = 0

			if var_321_14 < arg_318_1.time_ and arg_318_1.time_ <= var_321_14 + arg_321_0 then
				arg_318_1:PlayTimeline("1022ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_321_15 = 0

			if var_321_15 < arg_318_1.time_ and arg_318_1.time_ <= var_321_15 + arg_321_0 then
				arg_318_1.allBtn_.enabled = false
			end

			local var_321_16 = 1.26666666666667

			if arg_318_1.time_ >= var_321_15 + var_321_16 and arg_318_1.time_ < var_321_15 + var_321_16 + arg_321_0 then
				arg_318_1.allBtn_.enabled = true
			end

			local var_321_17 = 0
			local var_321_18 = 0.525

			if var_321_17 < arg_318_1.time_ and arg_318_1.time_ <= var_321_17 + arg_321_0 then
				arg_318_1.talkMaxDuration = 0
				arg_318_1.dialogCg_.alpha = 1

				arg_318_1.dialog_:SetActive(true)
				SetActive(arg_318_1.leftNameGo_, true)

				local var_321_19 = arg_318_1:FormatText(StoryNameCfg[259].name)

				arg_318_1.leftNameTxt_.text = var_321_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_318_1.leftNameTxt_.transform)

				arg_318_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_318_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_318_1:RecordName(arg_318_1.leftNameTxt_.text)
				SetActive(arg_318_1.iconTrs_.gameObject, false)
				arg_318_1.callingController_:SetSelectedState("normal")

				local var_321_20 = arg_318_1:GetWordFromCfg(1102205077)
				local var_321_21 = arg_318_1:FormatText(var_321_20.content)

				arg_318_1.text_.text = var_321_21

				LuaForUtil.ClearLinePrefixSymbol(arg_318_1.text_)

				local var_321_22 = 21
				local var_321_23 = utf8.len(var_321_21)
				local var_321_24 = var_321_22 <= 0 and var_321_18 or var_321_18 * (var_321_23 / var_321_22)

				if var_321_24 > 0 and var_321_18 < var_321_24 then
					arg_318_1.talkMaxDuration = var_321_24

					if var_321_24 + var_321_17 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_24 + var_321_17
					end
				end

				arg_318_1.text_.text = var_321_21
				arg_318_1.typewritter.percent = 0

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205077", "story_v_side_new_1102205.awb") ~= 0 then
					local var_321_25 = manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205077", "story_v_side_new_1102205.awb") / 1000

					if var_321_25 + var_321_17 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_25 + var_321_17
					end

					if var_321_20.prefab_name ~= "" and arg_318_1.actors_[var_321_20.prefab_name] ~= nil then
						local var_321_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_318_1.actors_[var_321_20.prefab_name].transform, "story_v_side_new_1102205", "1102205077", "story_v_side_new_1102205.awb")

						arg_318_1:RecordAudio("1102205077", var_321_26)
						arg_318_1:RecordAudio("1102205077", var_321_26)
					else
						arg_318_1:AudioAction("play", "voice", "story_v_side_new_1102205", "1102205077", "story_v_side_new_1102205.awb")
					end

					arg_318_1:RecordHistoryTalkVoice("story_v_side_new_1102205", "1102205077", "story_v_side_new_1102205.awb")
				end

				arg_318_1:RecordContent(arg_318_1.text_.text)
			end

			local var_321_27 = math.max(var_321_18, arg_318_1.talkMaxDuration)

			if var_321_17 <= arg_318_1.time_ and arg_318_1.time_ < var_321_17 + var_321_27 then
				arg_318_1.typewritter.percent = (arg_318_1.time_ - var_321_17) / var_321_27

				arg_318_1.typewritter:SetDirty()
			end

			if arg_318_1.time_ >= var_321_17 + var_321_27 and arg_318_1.time_ < var_321_17 + var_321_27 + arg_321_0 then
				arg_318_1.typewritter.percent = 1

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(true)
			end
		end

		arg_318_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1022ui_story",
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
	Play1102205078 = function(arg_322_0, arg_322_1)
		arg_322_1.time_ = 0
		arg_322_1.frameCnt_ = 0
		arg_322_1.state_ = "playing"
		arg_322_1.curTalkId_ = 1102205078
		arg_322_1.duration_ = 5

		SetActive(arg_322_1.tipsGo_, false)

		function arg_322_1.onSingleLineFinish_()
			arg_322_1.onSingleLineUpdate_ = nil
			arg_322_1.onSingleLineFinish_ = nil
			arg_322_1.state_ = "waiting"
		end

		function arg_322_1.playNext_(arg_324_0)
			if arg_324_0 == 1 then
				arg_322_0:Play1102205079(arg_322_1)
			end
		end

		function arg_322_1.onSingleLineUpdate_(arg_325_0)
			local var_325_0 = arg_322_1.actors_["1022ui_story"]
			local var_325_1 = 0

			if var_325_1 < arg_322_1.time_ and arg_322_1.time_ <= var_325_1 + arg_325_0 and not isNil(var_325_0) and arg_322_1.var_.characterEffect1022ui_story == nil then
				arg_322_1.var_.characterEffect1022ui_story = var_325_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_325_2 = 0.200000002980232

			if var_325_1 <= arg_322_1.time_ and arg_322_1.time_ < var_325_1 + var_325_2 and not isNil(var_325_0) then
				local var_325_3 = (arg_322_1.time_ - var_325_1) / var_325_2

				if arg_322_1.var_.characterEffect1022ui_story and not isNil(var_325_0) then
					local var_325_4 = Mathf.Lerp(0, 0.5, var_325_3)

					arg_322_1.var_.characterEffect1022ui_story.fillFlat = true
					arg_322_1.var_.characterEffect1022ui_story.fillRatio = var_325_4
				end
			end

			if arg_322_1.time_ >= var_325_1 + var_325_2 and arg_322_1.time_ < var_325_1 + var_325_2 + arg_325_0 and not isNil(var_325_0) and arg_322_1.var_.characterEffect1022ui_story then
				local var_325_5 = 0.5

				arg_322_1.var_.characterEffect1022ui_story.fillFlat = true
				arg_322_1.var_.characterEffect1022ui_story.fillRatio = var_325_5
			end

			local var_325_6 = 0
			local var_325_7 = 0.525

			if var_325_6 < arg_322_1.time_ and arg_322_1.time_ <= var_325_6 + arg_325_0 then
				arg_322_1.talkMaxDuration = 0
				arg_322_1.dialogCg_.alpha = 1

				arg_322_1.dialog_:SetActive(true)
				SetActive(arg_322_1.leftNameGo_, true)

				local var_325_8 = arg_322_1:FormatText(StoryNameCfg[7].name)

				arg_322_1.leftNameTxt_.text = var_325_8

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

				local var_325_9 = arg_322_1:GetWordFromCfg(1102205078)
				local var_325_10 = arg_322_1:FormatText(var_325_9.content)

				arg_322_1.text_.text = var_325_10

				LuaForUtil.ClearLinePrefixSymbol(arg_322_1.text_)

				local var_325_11 = 21
				local var_325_12 = utf8.len(var_325_10)
				local var_325_13 = var_325_11 <= 0 and var_325_7 or var_325_7 * (var_325_12 / var_325_11)

				if var_325_13 > 0 and var_325_7 < var_325_13 then
					arg_322_1.talkMaxDuration = var_325_13

					if var_325_13 + var_325_6 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_13 + var_325_6
					end
				end

				arg_322_1.text_.text = var_325_10
				arg_322_1.typewritter.percent = 0

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(false)
				arg_322_1:RecordContent(arg_322_1.text_.text)
			end

			local var_325_14 = math.max(var_325_7, arg_322_1.talkMaxDuration)

			if var_325_6 <= arg_322_1.time_ and arg_322_1.time_ < var_325_6 + var_325_14 then
				arg_322_1.typewritter.percent = (arg_322_1.time_ - var_325_6) / var_325_14

				arg_322_1.typewritter:SetDirty()
			end

			if arg_322_1.time_ >= var_325_6 + var_325_14 and arg_322_1.time_ < var_325_6 + var_325_14 + arg_325_0 then
				arg_322_1.typewritter.percent = 1

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(true)
			end
		end

		arg_322_1.nodeConfigList_ = {}

		arg_322_1:InitPlayNodeList()
	end,
	Play1102205079 = function(arg_326_0, arg_326_1)
		arg_326_1.time_ = 0
		arg_326_1.frameCnt_ = 0
		arg_326_1.state_ = "playing"
		arg_326_1.curTalkId_ = 1102205079
		arg_326_1.duration_ = 8.53

		SetActive(arg_326_1.tipsGo_, false)

		function arg_326_1.onSingleLineFinish_()
			arg_326_1.onSingleLineUpdate_ = nil
			arg_326_1.onSingleLineFinish_ = nil
			arg_326_1.state_ = "waiting"
		end

		function arg_326_1.playNext_(arg_328_0)
			if arg_328_0 == 1 then
				arg_326_0:Play1102205080(arg_326_1)
			end
		end

		function arg_326_1.onSingleLineUpdate_(arg_329_0)
			local var_329_0 = "ST22"

			if arg_326_1.bgs_[var_329_0] == nil then
				local var_329_1 = Object.Instantiate(arg_326_1.paintGo_)

				var_329_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_329_0)
				var_329_1.name = var_329_0
				var_329_1.transform.parent = arg_326_1.stage_.transform
				var_329_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_326_1.bgs_[var_329_0] = var_329_1
			end

			local var_329_2 = 1.999999999999

			if var_329_2 < arg_326_1.time_ and arg_326_1.time_ <= var_329_2 + arg_329_0 then
				local var_329_3 = manager.ui.mainCamera.transform.localPosition
				local var_329_4 = Vector3.New(0, 0, 10) + Vector3.New(var_329_3.x, var_329_3.y, 0)
				local var_329_5 = arg_326_1.bgs_.ST22

				var_329_5.transform.localPosition = var_329_4
				var_329_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_329_6 = var_329_5:GetComponent("SpriteRenderer")

				if var_329_6 and var_329_6.sprite then
					local var_329_7 = (var_329_5.transform.localPosition - var_329_3).z
					local var_329_8 = manager.ui.mainCameraCom_
					local var_329_9 = 2 * var_329_7 * Mathf.Tan(var_329_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_329_10 = var_329_9 * var_329_8.aspect
					local var_329_11 = var_329_6.sprite.bounds.size.x
					local var_329_12 = var_329_6.sprite.bounds.size.y
					local var_329_13 = var_329_10 / var_329_11
					local var_329_14 = var_329_9 / var_329_12
					local var_329_15 = var_329_14 < var_329_13 and var_329_13 or var_329_14

					var_329_5.transform.localScale = Vector3.New(var_329_15, var_329_15, 0)
				end

				for iter_329_0, iter_329_1 in pairs(arg_326_1.bgs_) do
					if iter_329_0 ~= "ST22" then
						iter_329_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_329_16 = 0

			if var_329_16 < arg_326_1.time_ and arg_326_1.time_ <= var_329_16 + arg_329_0 then
				arg_326_1.allBtn_.enabled = false
			end

			local var_329_17 = 0.3

			if arg_326_1.time_ >= var_329_16 + var_329_17 and arg_326_1.time_ < var_329_16 + var_329_17 + arg_329_0 then
				arg_326_1.allBtn_.enabled = true
			end

			local var_329_18 = 0

			if var_329_18 < arg_326_1.time_ and arg_326_1.time_ <= var_329_18 + arg_329_0 then
				arg_326_1.mask_.enabled = true
				arg_326_1.mask_.raycastTarget = true

				arg_326_1:SetGaussion(false)
			end

			local var_329_19 = 2

			if var_329_18 <= arg_326_1.time_ and arg_326_1.time_ < var_329_18 + var_329_19 then
				local var_329_20 = (arg_326_1.time_ - var_329_18) / var_329_19
				local var_329_21 = Color.New(0, 0, 0)

				var_329_21.a = Mathf.Lerp(0, 1, var_329_20)
				arg_326_1.mask_.color = var_329_21
			end

			if arg_326_1.time_ >= var_329_18 + var_329_19 and arg_326_1.time_ < var_329_18 + var_329_19 + arg_329_0 then
				local var_329_22 = Color.New(0, 0, 0)

				var_329_22.a = 1
				arg_326_1.mask_.color = var_329_22
			end

			local var_329_23 = 2

			if var_329_23 < arg_326_1.time_ and arg_326_1.time_ <= var_329_23 + arg_329_0 then
				arg_326_1.mask_.enabled = true
				arg_326_1.mask_.raycastTarget = true

				arg_326_1:SetGaussion(false)
			end

			local var_329_24 = 2

			if var_329_23 <= arg_326_1.time_ and arg_326_1.time_ < var_329_23 + var_329_24 then
				local var_329_25 = (arg_326_1.time_ - var_329_23) / var_329_24
				local var_329_26 = Color.New(0, 0, 0)

				var_329_26.a = Mathf.Lerp(1, 0, var_329_25)
				arg_326_1.mask_.color = var_329_26
			end

			if arg_326_1.time_ >= var_329_23 + var_329_24 and arg_326_1.time_ < var_329_23 + var_329_24 + arg_329_0 then
				local var_329_27 = Color.New(0, 0, 0)
				local var_329_28 = 0

				arg_326_1.mask_.enabled = false
				var_329_27.a = var_329_28
				arg_326_1.mask_.color = var_329_27
			end

			local var_329_29 = arg_326_1.actors_["1022ui_story"].transform
			local var_329_30 = 1.999999999999

			if var_329_30 < arg_326_1.time_ and arg_326_1.time_ <= var_329_30 + arg_329_0 then
				arg_326_1.var_.moveOldPos1022ui_story = var_329_29.localPosition
			end

			local var_329_31 = 0.001

			if var_329_30 <= arg_326_1.time_ and arg_326_1.time_ < var_329_30 + var_329_31 then
				local var_329_32 = (arg_326_1.time_ - var_329_30) / var_329_31
				local var_329_33 = Vector3.New(0, 100, 0)

				var_329_29.localPosition = Vector3.Lerp(arg_326_1.var_.moveOldPos1022ui_story, var_329_33, var_329_32)

				local var_329_34 = manager.ui.mainCamera.transform.position - var_329_29.position

				var_329_29.forward = Vector3.New(var_329_34.x, var_329_34.y, var_329_34.z)

				local var_329_35 = var_329_29.localEulerAngles

				var_329_35.z = 0
				var_329_35.x = 0
				var_329_29.localEulerAngles = var_329_35
			end

			if arg_326_1.time_ >= var_329_30 + var_329_31 and arg_326_1.time_ < var_329_30 + var_329_31 + arg_329_0 then
				var_329_29.localPosition = Vector3.New(0, 100, 0)

				local var_329_36 = manager.ui.mainCamera.transform.position - var_329_29.position

				var_329_29.forward = Vector3.New(var_329_36.x, var_329_36.y, var_329_36.z)

				local var_329_37 = var_329_29.localEulerAngles

				var_329_37.z = 0
				var_329_37.x = 0
				var_329_29.localEulerAngles = var_329_37
			end

			local var_329_38 = 0.166666666666667
			local var_329_39 = 0.3

			if var_329_38 < arg_326_1.time_ and arg_326_1.time_ <= var_329_38 + arg_329_0 then
				local var_329_40 = "play"
				local var_329_41 = "music"

				arg_326_1:AudioAction(var_329_40, var_329_41, "ui_battle", "ui_battle_stopbgm", "")

				local var_329_42 = ""
				local var_329_43 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_329_43 ~= "" then
					if arg_326_1.bgmTxt_.text ~= var_329_43 and arg_326_1.bgmTxt_.text ~= "" then
						if arg_326_1.bgmTxt2_.text ~= "" then
							arg_326_1.bgmTxt_.text = arg_326_1.bgmTxt2_.text
						end

						arg_326_1.bgmTxt2_.text = var_329_43

						arg_326_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_326_1.bgmTxt_.text = var_329_43
						arg_326_1.bgmTxt2_.text = var_329_43
					end

					if arg_326_1.bgmTimer then
						arg_326_1.bgmTimer:Stop()

						arg_326_1.bgmTimer = nil
					end

					if arg_326_1.settingData.show_music_name == 1 then
						arg_326_1.musicController:SetSelectedState("show")
						arg_326_1.musicAnimator_:Play("open", 0, 0)

						if arg_326_1.settingData.music_time ~= 0 then
							arg_326_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_326_1.settingData.music_time), function()
								if arg_326_1 == nil or isNil(arg_326_1.bgmTxt_) then
									return
								end

								arg_326_1.musicController:SetSelectedState("hide")
								arg_326_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_329_44 = 1.56666666666667
			local var_329_45 = 1

			if var_329_44 < arg_326_1.time_ and arg_326_1.time_ <= var_329_44 + arg_329_0 then
				local var_329_46 = "play"
				local var_329_47 = "music"

				arg_326_1:AudioAction(var_329_46, var_329_47, "bgm_activity_1_3_story_indoor", "bgm_activity_1_3_story_indoor", "bgm_activity_1_3_story_indoor.awb")

				local var_329_48 = ""
				local var_329_49 = manager.audio:GetAudioName("bgm_activity_1_3_story_indoor", "bgm_activity_1_3_story_indoor")

				if var_329_49 ~= "" then
					if arg_326_1.bgmTxt_.text ~= var_329_49 and arg_326_1.bgmTxt_.text ~= "" then
						if arg_326_1.bgmTxt2_.text ~= "" then
							arg_326_1.bgmTxt_.text = arg_326_1.bgmTxt2_.text
						end

						arg_326_1.bgmTxt2_.text = var_329_49

						arg_326_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_326_1.bgmTxt_.text = var_329_49
						arg_326_1.bgmTxt2_.text = var_329_49
					end

					if arg_326_1.bgmTimer then
						arg_326_1.bgmTimer:Stop()

						arg_326_1.bgmTimer = nil
					end

					if arg_326_1.settingData.show_music_name == 1 then
						arg_326_1.musicController:SetSelectedState("show")
						arg_326_1.musicAnimator_:Play("open", 0, 0)

						if arg_326_1.settingData.music_time ~= 0 then
							arg_326_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_326_1.settingData.music_time), function()
								if arg_326_1 == nil or isNil(arg_326_1.bgmTxt_) then
									return
								end

								arg_326_1.musicController:SetSelectedState("hide")
								arg_326_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_329_50 = 0.166666666666667
			local var_329_51 = 1

			if var_329_50 < arg_326_1.time_ and arg_326_1.time_ <= var_329_50 + arg_329_0 then
				local var_329_52 = "stop"
				local var_329_53 = "effect"

				arg_326_1:AudioAction(var_329_52, var_329_53, "se_story_side_1049", "se_story_side_1049_amb_room", "")
			end

			local var_329_54 = 1.56666666666667
			local var_329_55 = 1

			if var_329_54 < arg_326_1.time_ and arg_326_1.time_ <= var_329_54 + arg_329_0 then
				local var_329_56 = "play"
				local var_329_57 = "effect"

				arg_326_1:AudioAction(var_329_56, var_329_57, "se_story", "se_story_crowdloop", "")
			end

			if arg_326_1.frameCnt_ <= 1 then
				arg_326_1.dialog_:SetActive(false)
			end

			local var_329_58 = 3.53333333333333
			local var_329_59 = 1.225

			if var_329_58 < arg_326_1.time_ and arg_326_1.time_ <= var_329_58 + arg_329_0 then
				arg_326_1.talkMaxDuration = 0

				arg_326_1.dialog_:SetActive(true)

				arg_326_1.dialogCg_.alpha = 0

				local var_329_60 = LeanTween.value(arg_326_1.dialog_, 0, 1, 0.3)

				var_329_60:setOnUpdate(LuaHelper.FloatAction(function(arg_332_0)
					arg_326_1.dialogCg_.alpha = arg_332_0
				end))
				var_329_60:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_326_1.dialog_)
					var_329_60:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_326_1.duration_ = arg_326_1.duration_ + 0.3

				SetActive(arg_326_1.leftNameGo_, false)

				arg_326_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_326_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_326_1:RecordName(arg_326_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_326_1.iconTrs_.gameObject, false)
				arg_326_1.callingController_:SetSelectedState("normal")

				local var_329_61 = arg_326_1:GetWordFromCfg(1102205079)
				local var_329_62 = arg_326_1:FormatText(var_329_61.content)

				arg_326_1.text_.text = var_329_62

				LuaForUtil.ClearLinePrefixSymbol(arg_326_1.text_)

				local var_329_63 = 49
				local var_329_64 = utf8.len(var_329_62)
				local var_329_65 = var_329_63 <= 0 and var_329_59 or var_329_59 * (var_329_64 / var_329_63)

				if var_329_65 > 0 and var_329_59 < var_329_65 then
					arg_326_1.talkMaxDuration = var_329_65
					var_329_58 = var_329_58 + 0.3

					if var_329_65 + var_329_58 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_65 + var_329_58
					end
				end

				arg_326_1.text_.text = var_329_62
				arg_326_1.typewritter.percent = 0

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(false)
				arg_326_1:RecordContent(arg_326_1.text_.text)
			end

			local var_329_66 = var_329_58 + 0.3
			local var_329_67 = math.max(var_329_59, arg_326_1.talkMaxDuration)

			if var_329_66 <= arg_326_1.time_ and arg_326_1.time_ < var_329_66 + var_329_67 then
				arg_326_1.typewritter.percent = (arg_326_1.time_ - var_329_66) / var_329_67

				arg_326_1.typewritter:SetDirty()
			end

			if arg_326_1.time_ >= var_329_66 + var_329_67 and arg_326_1.time_ < var_329_66 + var_329_67 + arg_329_0 then
				arg_326_1.typewritter.percent = 1

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(true)
			end
		end

		arg_326_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1022ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.999999999999,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_326_1:InitPlayNodeList()
	end,
	Play1102205080 = function(arg_334_0, arg_334_1)
		arg_334_1.time_ = 0
		arg_334_1.frameCnt_ = 0
		arg_334_1.state_ = "playing"
		arg_334_1.curTalkId_ = 1102205080
		arg_334_1.duration_ = 5

		SetActive(arg_334_1.tipsGo_, false)

		function arg_334_1.onSingleLineFinish_()
			arg_334_1.onSingleLineUpdate_ = nil
			arg_334_1.onSingleLineFinish_ = nil
			arg_334_1.state_ = "waiting"
		end

		function arg_334_1.playNext_(arg_336_0)
			if arg_336_0 == 1 then
				arg_334_0:Play1102205081(arg_334_1)
			end
		end

		function arg_334_1.onSingleLineUpdate_(arg_337_0)
			local var_337_0 = 0
			local var_337_1 = 0.475

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

				local var_337_3 = arg_334_1:GetWordFromCfg(1102205080)
				local var_337_4 = arg_334_1:FormatText(var_337_3.content)

				arg_334_1.text_.text = var_337_4

				LuaForUtil.ClearLinePrefixSymbol(arg_334_1.text_)

				local var_337_5 = 19
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
	Play1102205081 = function(arg_338_0, arg_338_1)
		arg_338_1.time_ = 0
		arg_338_1.frameCnt_ = 0
		arg_338_1.state_ = "playing"
		arg_338_1.curTalkId_ = 1102205081
		arg_338_1.duration_ = 8.43

		SetActive(arg_338_1.tipsGo_, false)

		function arg_338_1.onSingleLineFinish_()
			arg_338_1.onSingleLineUpdate_ = nil
			arg_338_1.onSingleLineFinish_ = nil
			arg_338_1.state_ = "waiting"
		end

		function arg_338_1.playNext_(arg_340_0)
			if arg_340_0 == 1 then
				arg_338_0:Play1102205082(arg_338_1)
			end
		end

		function arg_338_1.onSingleLineUpdate_(arg_341_0)
			local var_341_0 = arg_338_1.actors_["1022ui_story"].transform
			local var_341_1 = 0

			if var_341_1 < arg_338_1.time_ and arg_338_1.time_ <= var_341_1 + arg_341_0 then
				arg_338_1.var_.moveOldPos1022ui_story = var_341_0.localPosition
			end

			local var_341_2 = 0.001

			if var_341_1 <= arg_338_1.time_ and arg_338_1.time_ < var_341_1 + var_341_2 then
				local var_341_3 = (arg_338_1.time_ - var_341_1) / var_341_2
				local var_341_4 = Vector3.New(0, -1.08, -6)

				var_341_0.localPosition = Vector3.Lerp(arg_338_1.var_.moveOldPos1022ui_story, var_341_4, var_341_3)

				local var_341_5 = manager.ui.mainCamera.transform.position - var_341_0.position

				var_341_0.forward = Vector3.New(var_341_5.x, var_341_5.y, var_341_5.z)

				local var_341_6 = var_341_0.localEulerAngles

				var_341_6.z = 0
				var_341_6.x = 0
				var_341_0.localEulerAngles = var_341_6
			end

			if arg_338_1.time_ >= var_341_1 + var_341_2 and arg_338_1.time_ < var_341_1 + var_341_2 + arg_341_0 then
				var_341_0.localPosition = Vector3.New(0, -1.08, -6)

				local var_341_7 = manager.ui.mainCamera.transform.position - var_341_0.position

				var_341_0.forward = Vector3.New(var_341_7.x, var_341_7.y, var_341_7.z)

				local var_341_8 = var_341_0.localEulerAngles

				var_341_8.z = 0
				var_341_8.x = 0
				var_341_0.localEulerAngles = var_341_8
			end

			local var_341_9 = arg_338_1.actors_["1022ui_story"]
			local var_341_10 = 0

			if var_341_10 < arg_338_1.time_ and arg_338_1.time_ <= var_341_10 + arg_341_0 and not isNil(var_341_9) and arg_338_1.var_.characterEffect1022ui_story == nil then
				arg_338_1.var_.characterEffect1022ui_story = var_341_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_341_11 = 0.200000002980232

			if var_341_10 <= arg_338_1.time_ and arg_338_1.time_ < var_341_10 + var_341_11 and not isNil(var_341_9) then
				local var_341_12 = (arg_338_1.time_ - var_341_10) / var_341_11

				if arg_338_1.var_.characterEffect1022ui_story and not isNil(var_341_9) then
					arg_338_1.var_.characterEffect1022ui_story.fillFlat = false
				end
			end

			if arg_338_1.time_ >= var_341_10 + var_341_11 and arg_338_1.time_ < var_341_10 + var_341_11 + arg_341_0 and not isNil(var_341_9) and arg_338_1.var_.characterEffect1022ui_story then
				arg_338_1.var_.characterEffect1022ui_story.fillFlat = false
			end

			local var_341_13 = 0

			if var_341_13 < arg_338_1.time_ and arg_338_1.time_ <= var_341_13 + arg_341_0 then
				arg_338_1:PlayTimeline("1022ui_story", "StoryTimeline/CharAction/story1022/story1022action/1022action1_1")
			end

			local var_341_14 = 0

			if var_341_14 < arg_338_1.time_ and arg_338_1.time_ <= var_341_14 + arg_341_0 then
				arg_338_1:PlayTimeline("1022ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_341_15 = 0
			local var_341_16 = 0.95

			if var_341_15 < arg_338_1.time_ and arg_338_1.time_ <= var_341_15 + arg_341_0 then
				arg_338_1.talkMaxDuration = 0
				arg_338_1.dialogCg_.alpha = 1

				arg_338_1.dialog_:SetActive(true)
				SetActive(arg_338_1.leftNameGo_, true)

				local var_341_17 = arg_338_1:FormatText(StoryNameCfg[259].name)

				arg_338_1.leftNameTxt_.text = var_341_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_338_1.leftNameTxt_.transform)

				arg_338_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_338_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_338_1:RecordName(arg_338_1.leftNameTxt_.text)
				SetActive(arg_338_1.iconTrs_.gameObject, false)
				arg_338_1.callingController_:SetSelectedState("normal")

				local var_341_18 = arg_338_1:GetWordFromCfg(1102205081)
				local var_341_19 = arg_338_1:FormatText(var_341_18.content)

				arg_338_1.text_.text = var_341_19

				LuaForUtil.ClearLinePrefixSymbol(arg_338_1.text_)

				local var_341_20 = 38
				local var_341_21 = utf8.len(var_341_19)
				local var_341_22 = var_341_20 <= 0 and var_341_16 or var_341_16 * (var_341_21 / var_341_20)

				if var_341_22 > 0 and var_341_16 < var_341_22 then
					arg_338_1.talkMaxDuration = var_341_22

					if var_341_22 + var_341_15 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_22 + var_341_15
					end
				end

				arg_338_1.text_.text = var_341_19
				arg_338_1.typewritter.percent = 0

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205081", "story_v_side_new_1102205.awb") ~= 0 then
					local var_341_23 = manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205081", "story_v_side_new_1102205.awb") / 1000

					if var_341_23 + var_341_15 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_23 + var_341_15
					end

					if var_341_18.prefab_name ~= "" and arg_338_1.actors_[var_341_18.prefab_name] ~= nil then
						local var_341_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_338_1.actors_[var_341_18.prefab_name].transform, "story_v_side_new_1102205", "1102205081", "story_v_side_new_1102205.awb")

						arg_338_1:RecordAudio("1102205081", var_341_24)
						arg_338_1:RecordAudio("1102205081", var_341_24)
					else
						arg_338_1:AudioAction("play", "voice", "story_v_side_new_1102205", "1102205081", "story_v_side_new_1102205.awb")
					end

					arg_338_1:RecordHistoryTalkVoice("story_v_side_new_1102205", "1102205081", "story_v_side_new_1102205.awb")
				end

				arg_338_1:RecordContent(arg_338_1.text_.text)
			end

			local var_341_25 = math.max(var_341_16, arg_338_1.talkMaxDuration)

			if var_341_15 <= arg_338_1.time_ and arg_338_1.time_ < var_341_15 + var_341_25 then
				arg_338_1.typewritter.percent = (arg_338_1.time_ - var_341_15) / var_341_25

				arg_338_1.typewritter:SetDirty()
			end

			if arg_338_1.time_ >= var_341_15 + var_341_25 and arg_338_1.time_ < var_341_15 + var_341_25 + arg_341_0 then
				arg_338_1.typewritter.percent = 1

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(true)
			end
		end

		arg_338_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1022ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_338_1:InitPlayNodeList()
	end,
	Play1102205082 = function(arg_342_0, arg_342_1)
		arg_342_1.time_ = 0
		arg_342_1.frameCnt_ = 0
		arg_342_1.state_ = "playing"
		arg_342_1.curTalkId_ = 1102205082
		arg_342_1.duration_ = 5

		SetActive(arg_342_1.tipsGo_, false)

		function arg_342_1.onSingleLineFinish_()
			arg_342_1.onSingleLineUpdate_ = nil
			arg_342_1.onSingleLineFinish_ = nil
			arg_342_1.state_ = "waiting"
		end

		function arg_342_1.playNext_(arg_344_0)
			if arg_344_0 == 1 then
				arg_342_0:Play1102205083(arg_342_1)
			end
		end

		function arg_342_1.onSingleLineUpdate_(arg_345_0)
			local var_345_0 = arg_342_1.actors_["1022ui_story"]
			local var_345_1 = 0

			if var_345_1 < arg_342_1.time_ and arg_342_1.time_ <= var_345_1 + arg_345_0 and not isNil(var_345_0) and arg_342_1.var_.characterEffect1022ui_story == nil then
				arg_342_1.var_.characterEffect1022ui_story = var_345_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_345_2 = 0.200000002980232

			if var_345_1 <= arg_342_1.time_ and arg_342_1.time_ < var_345_1 + var_345_2 and not isNil(var_345_0) then
				local var_345_3 = (arg_342_1.time_ - var_345_1) / var_345_2

				if arg_342_1.var_.characterEffect1022ui_story and not isNil(var_345_0) then
					local var_345_4 = Mathf.Lerp(0, 0.5, var_345_3)

					arg_342_1.var_.characterEffect1022ui_story.fillFlat = true
					arg_342_1.var_.characterEffect1022ui_story.fillRatio = var_345_4
				end
			end

			if arg_342_1.time_ >= var_345_1 + var_345_2 and arg_342_1.time_ < var_345_1 + var_345_2 + arg_345_0 and not isNil(var_345_0) and arg_342_1.var_.characterEffect1022ui_story then
				local var_345_5 = 0.5

				arg_342_1.var_.characterEffect1022ui_story.fillFlat = true
				arg_342_1.var_.characterEffect1022ui_story.fillRatio = var_345_5
			end

			local var_345_6 = 0
			local var_345_7 = 0.775

			if var_345_6 < arg_342_1.time_ and arg_342_1.time_ <= var_345_6 + arg_345_0 then
				arg_342_1.talkMaxDuration = 0
				arg_342_1.dialogCg_.alpha = 1

				arg_342_1.dialog_:SetActive(true)
				SetActive(arg_342_1.leftNameGo_, true)

				local var_345_8 = arg_342_1:FormatText(StoryNameCfg[7].name)

				arg_342_1.leftNameTxt_.text = var_345_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_342_1.leftNameTxt_.transform)

				arg_342_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_342_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_342_1:RecordName(arg_342_1.leftNameTxt_.text)
				SetActive(arg_342_1.iconTrs_.gameObject, true)
				arg_342_1.iconController_:SetSelectedState("hero")

				arg_342_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_342_1.callingController_:SetSelectedState("normal")

				arg_342_1.keyicon_.color = Color.New(1, 1, 1)
				arg_342_1.icon_.color = Color.New(1, 1, 1)

				local var_345_9 = arg_342_1:GetWordFromCfg(1102205082)
				local var_345_10 = arg_342_1:FormatText(var_345_9.content)

				arg_342_1.text_.text = var_345_10

				LuaForUtil.ClearLinePrefixSymbol(arg_342_1.text_)

				local var_345_11 = 28
				local var_345_12 = utf8.len(var_345_10)
				local var_345_13 = var_345_11 <= 0 and var_345_7 or var_345_7 * (var_345_12 / var_345_11)

				if var_345_13 > 0 and var_345_7 < var_345_13 then
					arg_342_1.talkMaxDuration = var_345_13

					if var_345_13 + var_345_6 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_13 + var_345_6
					end
				end

				arg_342_1.text_.text = var_345_10
				arg_342_1.typewritter.percent = 0

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(false)
				arg_342_1:RecordContent(arg_342_1.text_.text)
			end

			local var_345_14 = math.max(var_345_7, arg_342_1.talkMaxDuration)

			if var_345_6 <= arg_342_1.time_ and arg_342_1.time_ < var_345_6 + var_345_14 then
				arg_342_1.typewritter.percent = (arg_342_1.time_ - var_345_6) / var_345_14

				arg_342_1.typewritter:SetDirty()
			end

			if arg_342_1.time_ >= var_345_6 + var_345_14 and arg_342_1.time_ < var_345_6 + var_345_14 + arg_345_0 then
				arg_342_1.typewritter.percent = 1

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(true)
			end
		end

		arg_342_1.nodeConfigList_ = {}

		arg_342_1:InitPlayNodeList()
	end,
	Play1102205083 = function(arg_346_0, arg_346_1)
		arg_346_1.time_ = 0
		arg_346_1.frameCnt_ = 0
		arg_346_1.state_ = "playing"
		arg_346_1.curTalkId_ = 1102205083
		arg_346_1.duration_ = 5

		SetActive(arg_346_1.tipsGo_, false)

		function arg_346_1.onSingleLineFinish_()
			arg_346_1.onSingleLineUpdate_ = nil
			arg_346_1.onSingleLineFinish_ = nil
			arg_346_1.state_ = "waiting"
		end

		function arg_346_1.playNext_(arg_348_0)
			if arg_348_0 == 1 then
				arg_346_0:Play1102205084(arg_346_1)
			end
		end

		function arg_346_1.onSingleLineUpdate_(arg_349_0)
			local var_349_0 = arg_346_1.actors_["1022ui_story"].transform
			local var_349_1 = 0

			if var_349_1 < arg_346_1.time_ and arg_346_1.time_ <= var_349_1 + arg_349_0 then
				arg_346_1.var_.moveOldPos1022ui_story = var_349_0.localPosition
			end

			local var_349_2 = 0.001

			if var_349_1 <= arg_346_1.time_ and arg_346_1.time_ < var_349_1 + var_349_2 then
				local var_349_3 = (arg_346_1.time_ - var_349_1) / var_349_2
				local var_349_4 = Vector3.New(0, 100, 0)

				var_349_0.localPosition = Vector3.Lerp(arg_346_1.var_.moveOldPos1022ui_story, var_349_4, var_349_3)

				local var_349_5 = manager.ui.mainCamera.transform.position - var_349_0.position

				var_349_0.forward = Vector3.New(var_349_5.x, var_349_5.y, var_349_5.z)

				local var_349_6 = var_349_0.localEulerAngles

				var_349_6.z = 0
				var_349_6.x = 0
				var_349_0.localEulerAngles = var_349_6
			end

			if arg_346_1.time_ >= var_349_1 + var_349_2 and arg_346_1.time_ < var_349_1 + var_349_2 + arg_349_0 then
				var_349_0.localPosition = Vector3.New(0, 100, 0)

				local var_349_7 = manager.ui.mainCamera.transform.position - var_349_0.position

				var_349_0.forward = Vector3.New(var_349_7.x, var_349_7.y, var_349_7.z)

				local var_349_8 = var_349_0.localEulerAngles

				var_349_8.z = 0
				var_349_8.x = 0
				var_349_0.localEulerAngles = var_349_8
			end

			local var_349_9 = 0
			local var_349_10 = 0.725

			if var_349_9 < arg_346_1.time_ and arg_346_1.time_ <= var_349_9 + arg_349_0 then
				arg_346_1.talkMaxDuration = 0
				arg_346_1.dialogCg_.alpha = 1

				arg_346_1.dialog_:SetActive(true)
				SetActive(arg_346_1.leftNameGo_, false)

				arg_346_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_346_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_346_1:RecordName(arg_346_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_346_1.iconTrs_.gameObject, false)
				arg_346_1.callingController_:SetSelectedState("normal")

				local var_349_11 = arg_346_1:GetWordFromCfg(1102205083)
				local var_349_12 = arg_346_1:FormatText(var_349_11.content)

				arg_346_1.text_.text = var_349_12

				LuaForUtil.ClearLinePrefixSymbol(arg_346_1.text_)

				local var_349_13 = 29
				local var_349_14 = utf8.len(var_349_12)
				local var_349_15 = var_349_13 <= 0 and var_349_10 or var_349_10 * (var_349_14 / var_349_13)

				if var_349_15 > 0 and var_349_10 < var_349_15 then
					arg_346_1.talkMaxDuration = var_349_15

					if var_349_15 + var_349_9 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_15 + var_349_9
					end
				end

				arg_346_1.text_.text = var_349_12
				arg_346_1.typewritter.percent = 0

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(false)
				arg_346_1:RecordContent(arg_346_1.text_.text)
			end

			local var_349_16 = math.max(var_349_10, arg_346_1.talkMaxDuration)

			if var_349_9 <= arg_346_1.time_ and arg_346_1.time_ < var_349_9 + var_349_16 then
				arg_346_1.typewritter.percent = (arg_346_1.time_ - var_349_9) / var_349_16

				arg_346_1.typewritter:SetDirty()
			end

			if arg_346_1.time_ >= var_349_9 + var_349_16 and arg_346_1.time_ < var_349_9 + var_349_16 + arg_349_0 then
				arg_346_1.typewritter.percent = 1

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(true)
			end
		end

		arg_346_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1022ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_346_1:InitPlayNodeList()
	end,
	Play1102205084 = function(arg_350_0, arg_350_1)
		arg_350_1.time_ = 0
		arg_350_1.frameCnt_ = 0
		arg_350_1.state_ = "playing"
		arg_350_1.curTalkId_ = 1102205084
		arg_350_1.duration_ = 3.3

		SetActive(arg_350_1.tipsGo_, false)

		function arg_350_1.onSingleLineFinish_()
			arg_350_1.onSingleLineUpdate_ = nil
			arg_350_1.onSingleLineFinish_ = nil
			arg_350_1.state_ = "waiting"
		end

		function arg_350_1.playNext_(arg_352_0)
			if arg_352_0 == 1 then
				arg_350_0:Play1102205085(arg_350_1)
			end
		end

		function arg_350_1.onSingleLineUpdate_(arg_353_0)
			local var_353_0 = arg_350_1.actors_["1022ui_story"]
			local var_353_1 = 0

			if var_353_1 < arg_350_1.time_ and arg_350_1.time_ <= var_353_1 + arg_353_0 and not isNil(var_353_0) and arg_350_1.var_.characterEffect1022ui_story == nil then
				arg_350_1.var_.characterEffect1022ui_story = var_353_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_353_2 = 0.200000002980232

			if var_353_1 <= arg_350_1.time_ and arg_350_1.time_ < var_353_1 + var_353_2 and not isNil(var_353_0) then
				local var_353_3 = (arg_350_1.time_ - var_353_1) / var_353_2

				if arg_350_1.var_.characterEffect1022ui_story and not isNil(var_353_0) then
					arg_350_1.var_.characterEffect1022ui_story.fillFlat = false
				end
			end

			if arg_350_1.time_ >= var_353_1 + var_353_2 and arg_350_1.time_ < var_353_1 + var_353_2 + arg_353_0 and not isNil(var_353_0) and arg_350_1.var_.characterEffect1022ui_story then
				arg_350_1.var_.characterEffect1022ui_story.fillFlat = false
			end

			local var_353_4 = arg_350_1.actors_["1022ui_story"].transform
			local var_353_5 = 0

			if var_353_5 < arg_350_1.time_ and arg_350_1.time_ <= var_353_5 + arg_353_0 then
				arg_350_1.var_.moveOldPos1022ui_story = var_353_4.localPosition
			end

			local var_353_6 = 0.001

			if var_353_5 <= arg_350_1.time_ and arg_350_1.time_ < var_353_5 + var_353_6 then
				local var_353_7 = (arg_350_1.time_ - var_353_5) / var_353_6
				local var_353_8 = Vector3.New(0, -1.08, -6)

				var_353_4.localPosition = Vector3.Lerp(arg_350_1.var_.moveOldPos1022ui_story, var_353_8, var_353_7)

				local var_353_9 = manager.ui.mainCamera.transform.position - var_353_4.position

				var_353_4.forward = Vector3.New(var_353_9.x, var_353_9.y, var_353_9.z)

				local var_353_10 = var_353_4.localEulerAngles

				var_353_10.z = 0
				var_353_10.x = 0
				var_353_4.localEulerAngles = var_353_10
			end

			if arg_350_1.time_ >= var_353_5 + var_353_6 and arg_350_1.time_ < var_353_5 + var_353_6 + arg_353_0 then
				var_353_4.localPosition = Vector3.New(0, -1.08, -6)

				local var_353_11 = manager.ui.mainCamera.transform.position - var_353_4.position

				var_353_4.forward = Vector3.New(var_353_11.x, var_353_11.y, var_353_11.z)

				local var_353_12 = var_353_4.localEulerAngles

				var_353_12.z = 0
				var_353_12.x = 0
				var_353_4.localEulerAngles = var_353_12
			end

			local var_353_13 = 0

			if var_353_13 < arg_350_1.time_ and arg_350_1.time_ <= var_353_13 + arg_353_0 then
				arg_350_1:PlayTimeline("1022ui_story", "StoryTimeline/CharAction/story1022/story1022action/1022action5_1")
			end

			local var_353_14 = 0

			if var_353_14 < arg_350_1.time_ and arg_350_1.time_ <= var_353_14 + arg_353_0 then
				arg_350_1:PlayTimeline("1022ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_353_15 = 0
			local var_353_16 = 0.375

			if var_353_15 < arg_350_1.time_ and arg_350_1.time_ <= var_353_15 + arg_353_0 then
				arg_350_1.talkMaxDuration = 0
				arg_350_1.dialogCg_.alpha = 1

				arg_350_1.dialog_:SetActive(true)
				SetActive(arg_350_1.leftNameGo_, true)

				local var_353_17 = arg_350_1:FormatText(StoryNameCfg[259].name)

				arg_350_1.leftNameTxt_.text = var_353_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_350_1.leftNameTxt_.transform)

				arg_350_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_350_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_350_1:RecordName(arg_350_1.leftNameTxt_.text)
				SetActive(arg_350_1.iconTrs_.gameObject, false)
				arg_350_1.callingController_:SetSelectedState("normal")

				local var_353_18 = arg_350_1:GetWordFromCfg(1102205084)
				local var_353_19 = arg_350_1:FormatText(var_353_18.content)

				arg_350_1.text_.text = var_353_19

				LuaForUtil.ClearLinePrefixSymbol(arg_350_1.text_)

				local var_353_20 = 15
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

				if manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205084", "story_v_side_new_1102205.awb") ~= 0 then
					local var_353_23 = manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205084", "story_v_side_new_1102205.awb") / 1000

					if var_353_23 + var_353_15 > arg_350_1.duration_ then
						arg_350_1.duration_ = var_353_23 + var_353_15
					end

					if var_353_18.prefab_name ~= "" and arg_350_1.actors_[var_353_18.prefab_name] ~= nil then
						local var_353_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_350_1.actors_[var_353_18.prefab_name].transform, "story_v_side_new_1102205", "1102205084", "story_v_side_new_1102205.awb")

						arg_350_1:RecordAudio("1102205084", var_353_24)
						arg_350_1:RecordAudio("1102205084", var_353_24)
					else
						arg_350_1:AudioAction("play", "voice", "story_v_side_new_1102205", "1102205084", "story_v_side_new_1102205.awb")
					end

					arg_350_1:RecordHistoryTalkVoice("story_v_side_new_1102205", "1102205084", "story_v_side_new_1102205.awb")
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
				actorName = "1022ui_story",
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
	Play1102205085 = function(arg_354_0, arg_354_1)
		arg_354_1.time_ = 0
		arg_354_1.frameCnt_ = 0
		arg_354_1.state_ = "playing"
		arg_354_1.curTalkId_ = 1102205085
		arg_354_1.duration_ = 5

		SetActive(arg_354_1.tipsGo_, false)

		function arg_354_1.onSingleLineFinish_()
			arg_354_1.onSingleLineUpdate_ = nil
			arg_354_1.onSingleLineFinish_ = nil
			arg_354_1.state_ = "waiting"
		end

		function arg_354_1.playNext_(arg_356_0)
			if arg_356_0 == 1 then
				arg_354_0:Play1102205086(arg_354_1)
			end
		end

		function arg_354_1.onSingleLineUpdate_(arg_357_0)
			local var_357_0 = arg_354_1.actors_["1022ui_story"]
			local var_357_1 = 0

			if var_357_1 < arg_354_1.time_ and arg_354_1.time_ <= var_357_1 + arg_357_0 and not isNil(var_357_0) and arg_354_1.var_.characterEffect1022ui_story == nil then
				arg_354_1.var_.characterEffect1022ui_story = var_357_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_357_2 = 0.200000002980232

			if var_357_1 <= arg_354_1.time_ and arg_354_1.time_ < var_357_1 + var_357_2 and not isNil(var_357_0) then
				local var_357_3 = (arg_354_1.time_ - var_357_1) / var_357_2

				if arg_354_1.var_.characterEffect1022ui_story and not isNil(var_357_0) then
					local var_357_4 = Mathf.Lerp(0, 0.5, var_357_3)

					arg_354_1.var_.characterEffect1022ui_story.fillFlat = true
					arg_354_1.var_.characterEffect1022ui_story.fillRatio = var_357_4
				end
			end

			if arg_354_1.time_ >= var_357_1 + var_357_2 and arg_354_1.time_ < var_357_1 + var_357_2 + arg_357_0 and not isNil(var_357_0) and arg_354_1.var_.characterEffect1022ui_story then
				local var_357_5 = 0.5

				arg_354_1.var_.characterEffect1022ui_story.fillFlat = true
				arg_354_1.var_.characterEffect1022ui_story.fillRatio = var_357_5
			end

			local var_357_6 = 0
			local var_357_7 = 0.05

			if var_357_6 < arg_354_1.time_ and arg_354_1.time_ <= var_357_6 + arg_357_0 then
				arg_354_1.talkMaxDuration = 0
				arg_354_1.dialogCg_.alpha = 1

				arg_354_1.dialog_:SetActive(true)
				SetActive(arg_354_1.leftNameGo_, true)

				local var_357_8 = arg_354_1:FormatText(StoryNameCfg[7].name)

				arg_354_1.leftNameTxt_.text = var_357_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_354_1.leftNameTxt_.transform)

				arg_354_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_354_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_354_1:RecordName(arg_354_1.leftNameTxt_.text)
				SetActive(arg_354_1.iconTrs_.gameObject, true)
				arg_354_1.iconController_:SetSelectedState("hero")

				arg_354_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_354_1.callingController_:SetSelectedState("normal")

				arg_354_1.keyicon_.color = Color.New(1, 1, 1)
				arg_354_1.icon_.color = Color.New(1, 1, 1)

				local var_357_9 = arg_354_1:GetWordFromCfg(1102205085)
				local var_357_10 = arg_354_1:FormatText(var_357_9.content)

				arg_354_1.text_.text = var_357_10

				LuaForUtil.ClearLinePrefixSymbol(arg_354_1.text_)

				local var_357_11 = 2
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
				arg_354_1:RecordContent(arg_354_1.text_.text)
			end

			local var_357_14 = math.max(var_357_7, arg_354_1.talkMaxDuration)

			if var_357_6 <= arg_354_1.time_ and arg_354_1.time_ < var_357_6 + var_357_14 then
				arg_354_1.typewritter.percent = (arg_354_1.time_ - var_357_6) / var_357_14

				arg_354_1.typewritter:SetDirty()
			end

			if arg_354_1.time_ >= var_357_6 + var_357_14 and arg_354_1.time_ < var_357_6 + var_357_14 + arg_357_0 then
				arg_354_1.typewritter.percent = 1

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(true)
			end
		end

		arg_354_1.nodeConfigList_ = {}

		arg_354_1:InitPlayNodeList()
	end,
	Play1102205086 = function(arg_358_0, arg_358_1)
		arg_358_1.time_ = 0
		arg_358_1.frameCnt_ = 0
		arg_358_1.state_ = "playing"
		arg_358_1.curTalkId_ = 1102205086
		arg_358_1.duration_ = 3.6

		SetActive(arg_358_1.tipsGo_, false)

		function arg_358_1.onSingleLineFinish_()
			arg_358_1.onSingleLineUpdate_ = nil
			arg_358_1.onSingleLineFinish_ = nil
			arg_358_1.state_ = "waiting"
		end

		function arg_358_1.playNext_(arg_360_0)
			if arg_360_0 == 1 then
				arg_358_0:Play1102205087(arg_358_1)
			end
		end

		function arg_358_1.onSingleLineUpdate_(arg_361_0)
			local var_361_0 = arg_358_1.actors_["1022ui_story"]
			local var_361_1 = 0

			if var_361_1 < arg_358_1.time_ and arg_358_1.time_ <= var_361_1 + arg_361_0 and not isNil(var_361_0) and arg_358_1.var_.characterEffect1022ui_story == nil then
				arg_358_1.var_.characterEffect1022ui_story = var_361_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_361_2 = 0.200000002980232

			if var_361_1 <= arg_358_1.time_ and arg_358_1.time_ < var_361_1 + var_361_2 and not isNil(var_361_0) then
				local var_361_3 = (arg_358_1.time_ - var_361_1) / var_361_2

				if arg_358_1.var_.characterEffect1022ui_story and not isNil(var_361_0) then
					arg_358_1.var_.characterEffect1022ui_story.fillFlat = false
				end
			end

			if arg_358_1.time_ >= var_361_1 + var_361_2 and arg_358_1.time_ < var_361_1 + var_361_2 + arg_361_0 and not isNil(var_361_0) and arg_358_1.var_.characterEffect1022ui_story then
				arg_358_1.var_.characterEffect1022ui_story.fillFlat = false
			end

			local var_361_4 = 0
			local var_361_5 = 0.475

			if var_361_4 < arg_358_1.time_ and arg_358_1.time_ <= var_361_4 + arg_361_0 then
				arg_358_1.talkMaxDuration = 0
				arg_358_1.dialogCg_.alpha = 1

				arg_358_1.dialog_:SetActive(true)
				SetActive(arg_358_1.leftNameGo_, true)

				local var_361_6 = arg_358_1:FormatText(StoryNameCfg[259].name)

				arg_358_1.leftNameTxt_.text = var_361_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_358_1.leftNameTxt_.transform)

				arg_358_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_358_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_358_1:RecordName(arg_358_1.leftNameTxt_.text)
				SetActive(arg_358_1.iconTrs_.gameObject, false)
				arg_358_1.callingController_:SetSelectedState("normal")

				local var_361_7 = arg_358_1:GetWordFromCfg(1102205086)
				local var_361_8 = arg_358_1:FormatText(var_361_7.content)

				arg_358_1.text_.text = var_361_8

				LuaForUtil.ClearLinePrefixSymbol(arg_358_1.text_)

				local var_361_9 = 19
				local var_361_10 = utf8.len(var_361_8)
				local var_361_11 = var_361_9 <= 0 and var_361_5 or var_361_5 * (var_361_10 / var_361_9)

				if var_361_11 > 0 and var_361_5 < var_361_11 then
					arg_358_1.talkMaxDuration = var_361_11

					if var_361_11 + var_361_4 > arg_358_1.duration_ then
						arg_358_1.duration_ = var_361_11 + var_361_4
					end
				end

				arg_358_1.text_.text = var_361_8
				arg_358_1.typewritter.percent = 0

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205086", "story_v_side_new_1102205.awb") ~= 0 then
					local var_361_12 = manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205086", "story_v_side_new_1102205.awb") / 1000

					if var_361_12 + var_361_4 > arg_358_1.duration_ then
						arg_358_1.duration_ = var_361_12 + var_361_4
					end

					if var_361_7.prefab_name ~= "" and arg_358_1.actors_[var_361_7.prefab_name] ~= nil then
						local var_361_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_358_1.actors_[var_361_7.prefab_name].transform, "story_v_side_new_1102205", "1102205086", "story_v_side_new_1102205.awb")

						arg_358_1:RecordAudio("1102205086", var_361_13)
						arg_358_1:RecordAudio("1102205086", var_361_13)
					else
						arg_358_1:AudioAction("play", "voice", "story_v_side_new_1102205", "1102205086", "story_v_side_new_1102205.awb")
					end

					arg_358_1:RecordHistoryTalkVoice("story_v_side_new_1102205", "1102205086", "story_v_side_new_1102205.awb")
				end

				arg_358_1:RecordContent(arg_358_1.text_.text)
			end

			local var_361_14 = math.max(var_361_5, arg_358_1.talkMaxDuration)

			if var_361_4 <= arg_358_1.time_ and arg_358_1.time_ < var_361_4 + var_361_14 then
				arg_358_1.typewritter.percent = (arg_358_1.time_ - var_361_4) / var_361_14

				arg_358_1.typewritter:SetDirty()
			end

			if arg_358_1.time_ >= var_361_4 + var_361_14 and arg_358_1.time_ < var_361_4 + var_361_14 + arg_361_0 then
				arg_358_1.typewritter.percent = 1

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(true)
			end
		end

		arg_358_1.nodeConfigList_ = {}

		arg_358_1:InitPlayNodeList()
	end,
	Play1102205087 = function(arg_362_0, arg_362_1)
		arg_362_1.time_ = 0
		arg_362_1.frameCnt_ = 0
		arg_362_1.state_ = "playing"
		arg_362_1.curTalkId_ = 1102205087
		arg_362_1.duration_ = 5

		SetActive(arg_362_1.tipsGo_, false)

		function arg_362_1.onSingleLineFinish_()
			arg_362_1.onSingleLineUpdate_ = nil
			arg_362_1.onSingleLineFinish_ = nil
			arg_362_1.state_ = "waiting"
		end

		function arg_362_1.playNext_(arg_364_0)
			if arg_364_0 == 1 then
				arg_362_0:Play1102205088(arg_362_1)
			end
		end

		function arg_362_1.onSingleLineUpdate_(arg_365_0)
			local var_365_0 = arg_362_1.actors_["1022ui_story"]
			local var_365_1 = 0

			if var_365_1 < arg_362_1.time_ and arg_362_1.time_ <= var_365_1 + arg_365_0 and not isNil(var_365_0) and arg_362_1.var_.characterEffect1022ui_story == nil then
				arg_362_1.var_.characterEffect1022ui_story = var_365_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_365_2 = 0.200000002980232

			if var_365_1 <= arg_362_1.time_ and arg_362_1.time_ < var_365_1 + var_365_2 and not isNil(var_365_0) then
				local var_365_3 = (arg_362_1.time_ - var_365_1) / var_365_2

				if arg_362_1.var_.characterEffect1022ui_story and not isNil(var_365_0) then
					local var_365_4 = Mathf.Lerp(0, 0.5, var_365_3)

					arg_362_1.var_.characterEffect1022ui_story.fillFlat = true
					arg_362_1.var_.characterEffect1022ui_story.fillRatio = var_365_4
				end
			end

			if arg_362_1.time_ >= var_365_1 + var_365_2 and arg_362_1.time_ < var_365_1 + var_365_2 + arg_365_0 and not isNil(var_365_0) and arg_362_1.var_.characterEffect1022ui_story then
				local var_365_5 = 0.5

				arg_362_1.var_.characterEffect1022ui_story.fillFlat = true
				arg_362_1.var_.characterEffect1022ui_story.fillRatio = var_365_5
			end

			local var_365_6 = 0
			local var_365_7 = 0.85

			if var_365_6 < arg_362_1.time_ and arg_362_1.time_ <= var_365_6 + arg_365_0 then
				arg_362_1.talkMaxDuration = 0
				arg_362_1.dialogCg_.alpha = 1

				arg_362_1.dialog_:SetActive(true)
				SetActive(arg_362_1.leftNameGo_, true)

				local var_365_8 = arg_362_1:FormatText(StoryNameCfg[7].name)

				arg_362_1.leftNameTxt_.text = var_365_8

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

				local var_365_9 = arg_362_1:GetWordFromCfg(1102205087)
				local var_365_10 = arg_362_1:FormatText(var_365_9.content)

				arg_362_1.text_.text = var_365_10

				LuaForUtil.ClearLinePrefixSymbol(arg_362_1.text_)

				local var_365_11 = 34
				local var_365_12 = utf8.len(var_365_10)
				local var_365_13 = var_365_11 <= 0 and var_365_7 or var_365_7 * (var_365_12 / var_365_11)

				if var_365_13 > 0 and var_365_7 < var_365_13 then
					arg_362_1.talkMaxDuration = var_365_13

					if var_365_13 + var_365_6 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_13 + var_365_6
					end
				end

				arg_362_1.text_.text = var_365_10
				arg_362_1.typewritter.percent = 0

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(false)
				arg_362_1:RecordContent(arg_362_1.text_.text)
			end

			local var_365_14 = math.max(var_365_7, arg_362_1.talkMaxDuration)

			if var_365_6 <= arg_362_1.time_ and arg_362_1.time_ < var_365_6 + var_365_14 then
				arg_362_1.typewritter.percent = (arg_362_1.time_ - var_365_6) / var_365_14

				arg_362_1.typewritter:SetDirty()
			end

			if arg_362_1.time_ >= var_365_6 + var_365_14 and arg_362_1.time_ < var_365_6 + var_365_14 + arg_365_0 then
				arg_362_1.typewritter.percent = 1

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(true)
			end
		end

		arg_362_1.nodeConfigList_ = {}

		arg_362_1:InitPlayNodeList()
	end,
	Play1102205088 = function(arg_366_0, arg_366_1)
		arg_366_1.time_ = 0
		arg_366_1.frameCnt_ = 0
		arg_366_1.state_ = "playing"
		arg_366_1.curTalkId_ = 1102205088
		arg_366_1.duration_ = 5

		SetActive(arg_366_1.tipsGo_, false)

		function arg_366_1.onSingleLineFinish_()
			arg_366_1.onSingleLineUpdate_ = nil
			arg_366_1.onSingleLineFinish_ = nil
			arg_366_1.state_ = "waiting"
		end

		function arg_366_1.playNext_(arg_368_0)
			if arg_368_0 == 1 then
				arg_366_0:Play1102205089(arg_366_1)
			end
		end

		function arg_366_1.onSingleLineUpdate_(arg_369_0)
			local var_369_0 = 0

			if var_369_0 < arg_366_1.time_ and arg_366_1.time_ <= var_369_0 + arg_369_0 then
				arg_366_1:PlayTimeline("1022ui_story", "StoryTimeline/CharAction/story1022/story1022actionlink/1022action452")
			end

			local var_369_1 = 0

			if var_369_1 < arg_366_1.time_ and arg_366_1.time_ <= var_369_1 + arg_369_0 then
				arg_366_1:PlayTimeline("1022ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_369_2 = 0
			local var_369_3 = 0.725

			if var_369_2 < arg_366_1.time_ and arg_366_1.time_ <= var_369_2 + arg_369_0 then
				arg_366_1.talkMaxDuration = 0
				arg_366_1.dialogCg_.alpha = 1

				arg_366_1.dialog_:SetActive(true)
				SetActive(arg_366_1.leftNameGo_, false)

				arg_366_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_366_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_366_1:RecordName(arg_366_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_366_1.iconTrs_.gameObject, false)
				arg_366_1.callingController_:SetSelectedState("normal")

				local var_369_4 = arg_366_1:GetWordFromCfg(1102205088)
				local var_369_5 = arg_366_1:FormatText(var_369_4.content)

				arg_366_1.text_.text = var_369_5

				LuaForUtil.ClearLinePrefixSymbol(arg_366_1.text_)

				local var_369_6 = 29
				local var_369_7 = utf8.len(var_369_5)
				local var_369_8 = var_369_6 <= 0 and var_369_3 or var_369_3 * (var_369_7 / var_369_6)

				if var_369_8 > 0 and var_369_3 < var_369_8 then
					arg_366_1.talkMaxDuration = var_369_8

					if var_369_8 + var_369_2 > arg_366_1.duration_ then
						arg_366_1.duration_ = var_369_8 + var_369_2
					end
				end

				arg_366_1.text_.text = var_369_5
				arg_366_1.typewritter.percent = 0

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(false)
				arg_366_1:RecordContent(arg_366_1.text_.text)
			end

			local var_369_9 = math.max(var_369_3, arg_366_1.talkMaxDuration)

			if var_369_2 <= arg_366_1.time_ and arg_366_1.time_ < var_369_2 + var_369_9 then
				arg_366_1.typewritter.percent = (arg_366_1.time_ - var_369_2) / var_369_9

				arg_366_1.typewritter:SetDirty()
			end

			if arg_366_1.time_ >= var_369_2 + var_369_9 and arg_366_1.time_ < var_369_2 + var_369_9 + arg_369_0 then
				arg_366_1.typewritter.percent = 1

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(true)
			end
		end

		arg_366_1.nodeConfigList_ = {}

		arg_366_1:InitPlayNodeList()
	end,
	Play1102205089 = function(arg_370_0, arg_370_1)
		arg_370_1.time_ = 0
		arg_370_1.frameCnt_ = 0
		arg_370_1.state_ = "playing"
		arg_370_1.curTalkId_ = 1102205089
		arg_370_1.duration_ = 5

		SetActive(arg_370_1.tipsGo_, false)

		function arg_370_1.onSingleLineFinish_()
			arg_370_1.onSingleLineUpdate_ = nil
			arg_370_1.onSingleLineFinish_ = nil
			arg_370_1.state_ = "waiting"
		end

		function arg_370_1.playNext_(arg_372_0)
			if arg_372_0 == 1 then
				arg_370_0:Play1102205090(arg_370_1)
			end
		end

		function arg_370_1.onSingleLineUpdate_(arg_373_0)
			local var_373_0 = 0
			local var_373_1 = 0.275

			if var_373_0 < arg_370_1.time_ and arg_370_1.time_ <= var_373_0 + arg_373_0 then
				arg_370_1.talkMaxDuration = 0
				arg_370_1.dialogCg_.alpha = 1

				arg_370_1.dialog_:SetActive(true)
				SetActive(arg_370_1.leftNameGo_, true)

				local var_373_2 = arg_370_1:FormatText(StoryNameCfg[7].name)

				arg_370_1.leftNameTxt_.text = var_373_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_370_1.leftNameTxt_.transform)

				arg_370_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_370_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_370_1:RecordName(arg_370_1.leftNameTxt_.text)
				SetActive(arg_370_1.iconTrs_.gameObject, true)
				arg_370_1.iconController_:SetSelectedState("hero")

				arg_370_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_370_1.callingController_:SetSelectedState("normal")

				arg_370_1.keyicon_.color = Color.New(1, 1, 1)
				arg_370_1.icon_.color = Color.New(1, 1, 1)

				local var_373_3 = arg_370_1:GetWordFromCfg(1102205089)
				local var_373_4 = arg_370_1:FormatText(var_373_3.content)

				arg_370_1.text_.text = var_373_4

				LuaForUtil.ClearLinePrefixSymbol(arg_370_1.text_)

				local var_373_5 = 11
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
				arg_370_1:RecordContent(arg_370_1.text_.text)
			end

			local var_373_8 = math.max(var_373_1, arg_370_1.talkMaxDuration)

			if var_373_0 <= arg_370_1.time_ and arg_370_1.time_ < var_373_0 + var_373_8 then
				arg_370_1.typewritter.percent = (arg_370_1.time_ - var_373_0) / var_373_8

				arg_370_1.typewritter:SetDirty()
			end

			if arg_370_1.time_ >= var_373_0 + var_373_8 and arg_370_1.time_ < var_373_0 + var_373_8 + arg_373_0 then
				arg_370_1.typewritter.percent = 1

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(true)
			end
		end

		arg_370_1.nodeConfigList_ = {}

		arg_370_1:InitPlayNodeList()
	end,
	Play1102205090 = function(arg_374_0, arg_374_1)
		arg_374_1.time_ = 0
		arg_374_1.frameCnt_ = 0
		arg_374_1.state_ = "playing"
		arg_374_1.curTalkId_ = 1102205090
		arg_374_1.duration_ = 4.17

		SetActive(arg_374_1.tipsGo_, false)

		function arg_374_1.onSingleLineFinish_()
			arg_374_1.onSingleLineUpdate_ = nil
			arg_374_1.onSingleLineFinish_ = nil
			arg_374_1.state_ = "waiting"
		end

		function arg_374_1.playNext_(arg_376_0)
			if arg_376_0 == 1 then
				arg_374_0:Play1102205091(arg_374_1)
			end
		end

		function arg_374_1.onSingleLineUpdate_(arg_377_0)
			local var_377_0 = arg_374_1.actors_["1022ui_story"]
			local var_377_1 = 0

			if var_377_1 < arg_374_1.time_ and arg_374_1.time_ <= var_377_1 + arg_377_0 and not isNil(var_377_0) and arg_374_1.var_.characterEffect1022ui_story == nil then
				arg_374_1.var_.characterEffect1022ui_story = var_377_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_377_2 = 0.200000002980232

			if var_377_1 <= arg_374_1.time_ and arg_374_1.time_ < var_377_1 + var_377_2 and not isNil(var_377_0) then
				local var_377_3 = (arg_374_1.time_ - var_377_1) / var_377_2

				if arg_374_1.var_.characterEffect1022ui_story and not isNil(var_377_0) then
					arg_374_1.var_.characterEffect1022ui_story.fillFlat = false
				end
			end

			if arg_374_1.time_ >= var_377_1 + var_377_2 and arg_374_1.time_ < var_377_1 + var_377_2 + arg_377_0 and not isNil(var_377_0) and arg_374_1.var_.characterEffect1022ui_story then
				arg_374_1.var_.characterEffect1022ui_story.fillFlat = false
			end

			local var_377_4 = 0

			if var_377_4 < arg_374_1.time_ and arg_374_1.time_ <= var_377_4 + arg_377_0 then
				arg_374_1:PlayTimeline("1022ui_story", "StoryTimeline/CharAction/story1022/story1022action/1022action2_2")
			end

			local var_377_5 = 0
			local var_377_6 = 0.5

			if var_377_5 < arg_374_1.time_ and arg_374_1.time_ <= var_377_5 + arg_377_0 then
				arg_374_1.talkMaxDuration = 0
				arg_374_1.dialogCg_.alpha = 1

				arg_374_1.dialog_:SetActive(true)
				SetActive(arg_374_1.leftNameGo_, true)

				local var_377_7 = arg_374_1:FormatText(StoryNameCfg[259].name)

				arg_374_1.leftNameTxt_.text = var_377_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_374_1.leftNameTxt_.transform)

				arg_374_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_374_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_374_1:RecordName(arg_374_1.leftNameTxt_.text)
				SetActive(arg_374_1.iconTrs_.gameObject, false)
				arg_374_1.callingController_:SetSelectedState("normal")

				local var_377_8 = arg_374_1:GetWordFromCfg(1102205090)
				local var_377_9 = arg_374_1:FormatText(var_377_8.content)

				arg_374_1.text_.text = var_377_9

				LuaForUtil.ClearLinePrefixSymbol(arg_374_1.text_)

				local var_377_10 = 20
				local var_377_11 = utf8.len(var_377_9)
				local var_377_12 = var_377_10 <= 0 and var_377_6 or var_377_6 * (var_377_11 / var_377_10)

				if var_377_12 > 0 and var_377_6 < var_377_12 then
					arg_374_1.talkMaxDuration = var_377_12

					if var_377_12 + var_377_5 > arg_374_1.duration_ then
						arg_374_1.duration_ = var_377_12 + var_377_5
					end
				end

				arg_374_1.text_.text = var_377_9
				arg_374_1.typewritter.percent = 0

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205090", "story_v_side_new_1102205.awb") ~= 0 then
					local var_377_13 = manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205090", "story_v_side_new_1102205.awb") / 1000

					if var_377_13 + var_377_5 > arg_374_1.duration_ then
						arg_374_1.duration_ = var_377_13 + var_377_5
					end

					if var_377_8.prefab_name ~= "" and arg_374_1.actors_[var_377_8.prefab_name] ~= nil then
						local var_377_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_374_1.actors_[var_377_8.prefab_name].transform, "story_v_side_new_1102205", "1102205090", "story_v_side_new_1102205.awb")

						arg_374_1:RecordAudio("1102205090", var_377_14)
						arg_374_1:RecordAudio("1102205090", var_377_14)
					else
						arg_374_1:AudioAction("play", "voice", "story_v_side_new_1102205", "1102205090", "story_v_side_new_1102205.awb")
					end

					arg_374_1:RecordHistoryTalkVoice("story_v_side_new_1102205", "1102205090", "story_v_side_new_1102205.awb")
				end

				arg_374_1:RecordContent(arg_374_1.text_.text)
			end

			local var_377_15 = math.max(var_377_6, arg_374_1.talkMaxDuration)

			if var_377_5 <= arg_374_1.time_ and arg_374_1.time_ < var_377_5 + var_377_15 then
				arg_374_1.typewritter.percent = (arg_374_1.time_ - var_377_5) / var_377_15

				arg_374_1.typewritter:SetDirty()
			end

			if arg_374_1.time_ >= var_377_5 + var_377_15 and arg_374_1.time_ < var_377_5 + var_377_15 + arg_377_0 then
				arg_374_1.typewritter.percent = 1

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(true)
			end
		end

		arg_374_1.nodeConfigList_ = {}

		arg_374_1:InitPlayNodeList()
	end,
	Play1102205091 = function(arg_378_0, arg_378_1)
		arg_378_1.time_ = 0
		arg_378_1.frameCnt_ = 0
		arg_378_1.state_ = "playing"
		arg_378_1.curTalkId_ = 1102205091
		arg_378_1.duration_ = 5

		SetActive(arg_378_1.tipsGo_, false)

		function arg_378_1.onSingleLineFinish_()
			arg_378_1.onSingleLineUpdate_ = nil
			arg_378_1.onSingleLineFinish_ = nil
			arg_378_1.state_ = "waiting"
		end

		function arg_378_1.playNext_(arg_380_0)
			if arg_380_0 == 1 then
				arg_378_0:Play1102205092(arg_378_1)
			end
		end

		function arg_378_1.onSingleLineUpdate_(arg_381_0)
			local var_381_0 = arg_378_1.actors_["1022ui_story"]
			local var_381_1 = 0

			if var_381_1 < arg_378_1.time_ and arg_378_1.time_ <= var_381_1 + arg_381_0 and not isNil(var_381_0) and arg_378_1.var_.characterEffect1022ui_story == nil then
				arg_378_1.var_.characterEffect1022ui_story = var_381_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_381_2 = 0.200000002980232

			if var_381_1 <= arg_378_1.time_ and arg_378_1.time_ < var_381_1 + var_381_2 and not isNil(var_381_0) then
				local var_381_3 = (arg_378_1.time_ - var_381_1) / var_381_2

				if arg_378_1.var_.characterEffect1022ui_story and not isNil(var_381_0) then
					local var_381_4 = Mathf.Lerp(0, 0.5, var_381_3)

					arg_378_1.var_.characterEffect1022ui_story.fillFlat = true
					arg_378_1.var_.characterEffect1022ui_story.fillRatio = var_381_4
				end
			end

			if arg_378_1.time_ >= var_381_1 + var_381_2 and arg_378_1.time_ < var_381_1 + var_381_2 + arg_381_0 and not isNil(var_381_0) and arg_378_1.var_.characterEffect1022ui_story then
				local var_381_5 = 0.5

				arg_378_1.var_.characterEffect1022ui_story.fillFlat = true
				arg_378_1.var_.characterEffect1022ui_story.fillRatio = var_381_5
			end

			local var_381_6 = 0
			local var_381_7 = 0.225

			if var_381_6 < arg_378_1.time_ and arg_378_1.time_ <= var_381_6 + arg_381_0 then
				arg_378_1.talkMaxDuration = 0
				arg_378_1.dialogCg_.alpha = 1

				arg_378_1.dialog_:SetActive(true)
				SetActive(arg_378_1.leftNameGo_, true)

				local var_381_8 = arg_378_1:FormatText(StoryNameCfg[7].name)

				arg_378_1.leftNameTxt_.text = var_381_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_378_1.leftNameTxt_.transform)

				arg_378_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_378_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_378_1:RecordName(arg_378_1.leftNameTxt_.text)
				SetActive(arg_378_1.iconTrs_.gameObject, true)
				arg_378_1.iconController_:SetSelectedState("hero")

				arg_378_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_378_1.callingController_:SetSelectedState("normal")

				arg_378_1.keyicon_.color = Color.New(1, 1, 1)
				arg_378_1.icon_.color = Color.New(1, 1, 1)

				local var_381_9 = arg_378_1:GetWordFromCfg(1102205091)
				local var_381_10 = arg_378_1:FormatText(var_381_9.content)

				arg_378_1.text_.text = var_381_10

				LuaForUtil.ClearLinePrefixSymbol(arg_378_1.text_)

				local var_381_11 = 9
				local var_381_12 = utf8.len(var_381_10)
				local var_381_13 = var_381_11 <= 0 and var_381_7 or var_381_7 * (var_381_12 / var_381_11)

				if var_381_13 > 0 and var_381_7 < var_381_13 then
					arg_378_1.talkMaxDuration = var_381_13

					if var_381_13 + var_381_6 > arg_378_1.duration_ then
						arg_378_1.duration_ = var_381_13 + var_381_6
					end
				end

				arg_378_1.text_.text = var_381_10
				arg_378_1.typewritter.percent = 0

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(false)
				arg_378_1:RecordContent(arg_378_1.text_.text)
			end

			local var_381_14 = math.max(var_381_7, arg_378_1.talkMaxDuration)

			if var_381_6 <= arg_378_1.time_ and arg_378_1.time_ < var_381_6 + var_381_14 then
				arg_378_1.typewritter.percent = (arg_378_1.time_ - var_381_6) / var_381_14

				arg_378_1.typewritter:SetDirty()
			end

			if arg_378_1.time_ >= var_381_6 + var_381_14 and arg_378_1.time_ < var_381_6 + var_381_14 + arg_381_0 then
				arg_378_1.typewritter.percent = 1

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(true)
			end
		end

		arg_378_1.nodeConfigList_ = {}

		arg_378_1:InitPlayNodeList()
	end,
	Play1102205092 = function(arg_382_0, arg_382_1)
		arg_382_1.time_ = 0
		arg_382_1.frameCnt_ = 0
		arg_382_1.state_ = "playing"
		arg_382_1.curTalkId_ = 1102205092
		arg_382_1.duration_ = 5

		SetActive(arg_382_1.tipsGo_, false)

		function arg_382_1.onSingleLineFinish_()
			arg_382_1.onSingleLineUpdate_ = nil
			arg_382_1.onSingleLineFinish_ = nil
			arg_382_1.state_ = "waiting"
		end

		function arg_382_1.playNext_(arg_384_0)
			if arg_384_0 == 1 then
				arg_382_0:Play1102205093(arg_382_1)
			end
		end

		function arg_382_1.onSingleLineUpdate_(arg_385_0)
			local var_385_0 = 0
			local var_385_1 = 0.275

			if var_385_0 < arg_382_1.time_ and arg_382_1.time_ <= var_385_0 + arg_385_0 then
				arg_382_1.talkMaxDuration = 0
				arg_382_1.dialogCg_.alpha = 1

				arg_382_1.dialog_:SetActive(true)
				SetActive(arg_382_1.leftNameGo_, true)

				local var_385_2 = arg_382_1:FormatText(StoryNameCfg[7].name)

				arg_382_1.leftNameTxt_.text = var_385_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_382_1.leftNameTxt_.transform)

				arg_382_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_382_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_382_1:RecordName(arg_382_1.leftNameTxt_.text)
				SetActive(arg_382_1.iconTrs_.gameObject, true)
				arg_382_1.iconController_:SetSelectedState("hero")

				arg_382_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_382_1.callingController_:SetSelectedState("normal")

				arg_382_1.keyicon_.color = Color.New(1, 1, 1)
				arg_382_1.icon_.color = Color.New(1, 1, 1)

				local var_385_3 = arg_382_1:GetWordFromCfg(1102205092)
				local var_385_4 = arg_382_1:FormatText(var_385_3.content)

				arg_382_1.text_.text = var_385_4

				LuaForUtil.ClearLinePrefixSymbol(arg_382_1.text_)

				local var_385_5 = 11
				local var_385_6 = utf8.len(var_385_4)
				local var_385_7 = var_385_5 <= 0 and var_385_1 or var_385_1 * (var_385_6 / var_385_5)

				if var_385_7 > 0 and var_385_1 < var_385_7 then
					arg_382_1.talkMaxDuration = var_385_7

					if var_385_7 + var_385_0 > arg_382_1.duration_ then
						arg_382_1.duration_ = var_385_7 + var_385_0
					end
				end

				arg_382_1.text_.text = var_385_4
				arg_382_1.typewritter.percent = 0

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(false)
				arg_382_1:RecordContent(arg_382_1.text_.text)
			end

			local var_385_8 = math.max(var_385_1, arg_382_1.talkMaxDuration)

			if var_385_0 <= arg_382_1.time_ and arg_382_1.time_ < var_385_0 + var_385_8 then
				arg_382_1.typewritter.percent = (arg_382_1.time_ - var_385_0) / var_385_8

				arg_382_1.typewritter:SetDirty()
			end

			if arg_382_1.time_ >= var_385_0 + var_385_8 and arg_382_1.time_ < var_385_0 + var_385_8 + arg_385_0 then
				arg_382_1.typewritter.percent = 1

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(true)
			end
		end

		arg_382_1.nodeConfigList_ = {}

		arg_382_1:InitPlayNodeList()
	end,
	Play1102205093 = function(arg_386_0, arg_386_1)
		arg_386_1.time_ = 0
		arg_386_1.frameCnt_ = 0
		arg_386_1.state_ = "playing"
		arg_386_1.curTalkId_ = 1102205093
		arg_386_1.duration_ = 7.1

		SetActive(arg_386_1.tipsGo_, false)

		function arg_386_1.onSingleLineFinish_()
			arg_386_1.onSingleLineUpdate_ = nil
			arg_386_1.onSingleLineFinish_ = nil
			arg_386_1.state_ = "waiting"
		end

		function arg_386_1.playNext_(arg_388_0)
			if arg_388_0 == 1 then
				arg_386_0:Play1102205094(arg_386_1)
			end
		end

		function arg_386_1.onSingleLineUpdate_(arg_389_0)
			local var_389_0 = arg_386_1.actors_["1022ui_story"]
			local var_389_1 = 0

			if var_389_1 < arg_386_1.time_ and arg_386_1.time_ <= var_389_1 + arg_389_0 and not isNil(var_389_0) and arg_386_1.var_.characterEffect1022ui_story == nil then
				arg_386_1.var_.characterEffect1022ui_story = var_389_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_389_2 = 0.200000002980232

			if var_389_1 <= arg_386_1.time_ and arg_386_1.time_ < var_389_1 + var_389_2 and not isNil(var_389_0) then
				local var_389_3 = (arg_386_1.time_ - var_389_1) / var_389_2

				if arg_386_1.var_.characterEffect1022ui_story and not isNil(var_389_0) then
					arg_386_1.var_.characterEffect1022ui_story.fillFlat = false
				end
			end

			if arg_386_1.time_ >= var_389_1 + var_389_2 and arg_386_1.time_ < var_389_1 + var_389_2 + arg_389_0 and not isNil(var_389_0) and arg_386_1.var_.characterEffect1022ui_story then
				arg_386_1.var_.characterEffect1022ui_story.fillFlat = false
			end

			local var_389_4 = 0

			if var_389_4 < arg_386_1.time_ and arg_386_1.time_ <= var_389_4 + arg_389_0 then
				arg_386_1:PlayTimeline("1022ui_story", "StoryTimeline/CharAction/story1022/story1022action/1022action7_1")
			end

			local var_389_5 = 0

			if var_389_5 < arg_386_1.time_ and arg_386_1.time_ <= var_389_5 + arg_389_0 then
				arg_386_1:PlayTimeline("1022ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_389_6 = 0
			local var_389_7 = 0.725

			if var_389_6 < arg_386_1.time_ and arg_386_1.time_ <= var_389_6 + arg_389_0 then
				arg_386_1.talkMaxDuration = 0
				arg_386_1.dialogCg_.alpha = 1

				arg_386_1.dialog_:SetActive(true)
				SetActive(arg_386_1.leftNameGo_, true)

				local var_389_8 = arg_386_1:FormatText(StoryNameCfg[259].name)

				arg_386_1.leftNameTxt_.text = var_389_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_386_1.leftNameTxt_.transform)

				arg_386_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_386_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_386_1:RecordName(arg_386_1.leftNameTxt_.text)
				SetActive(arg_386_1.iconTrs_.gameObject, false)
				arg_386_1.callingController_:SetSelectedState("normal")

				local var_389_9 = arg_386_1:GetWordFromCfg(1102205093)
				local var_389_10 = arg_386_1:FormatText(var_389_9.content)

				arg_386_1.text_.text = var_389_10

				LuaForUtil.ClearLinePrefixSymbol(arg_386_1.text_)

				local var_389_11 = 29
				local var_389_12 = utf8.len(var_389_10)
				local var_389_13 = var_389_11 <= 0 and var_389_7 or var_389_7 * (var_389_12 / var_389_11)

				if var_389_13 > 0 and var_389_7 < var_389_13 then
					arg_386_1.talkMaxDuration = var_389_13

					if var_389_13 + var_389_6 > arg_386_1.duration_ then
						arg_386_1.duration_ = var_389_13 + var_389_6
					end
				end

				arg_386_1.text_.text = var_389_10
				arg_386_1.typewritter.percent = 0

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205093", "story_v_side_new_1102205.awb") ~= 0 then
					local var_389_14 = manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205093", "story_v_side_new_1102205.awb") / 1000

					if var_389_14 + var_389_6 > arg_386_1.duration_ then
						arg_386_1.duration_ = var_389_14 + var_389_6
					end

					if var_389_9.prefab_name ~= "" and arg_386_1.actors_[var_389_9.prefab_name] ~= nil then
						local var_389_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_386_1.actors_[var_389_9.prefab_name].transform, "story_v_side_new_1102205", "1102205093", "story_v_side_new_1102205.awb")

						arg_386_1:RecordAudio("1102205093", var_389_15)
						arg_386_1:RecordAudio("1102205093", var_389_15)
					else
						arg_386_1:AudioAction("play", "voice", "story_v_side_new_1102205", "1102205093", "story_v_side_new_1102205.awb")
					end

					arg_386_1:RecordHistoryTalkVoice("story_v_side_new_1102205", "1102205093", "story_v_side_new_1102205.awb")
				end

				arg_386_1:RecordContent(arg_386_1.text_.text)
			end

			local var_389_16 = math.max(var_389_7, arg_386_1.talkMaxDuration)

			if var_389_6 <= arg_386_1.time_ and arg_386_1.time_ < var_389_6 + var_389_16 then
				arg_386_1.typewritter.percent = (arg_386_1.time_ - var_389_6) / var_389_16

				arg_386_1.typewritter:SetDirty()
			end

			if arg_386_1.time_ >= var_389_6 + var_389_16 and arg_386_1.time_ < var_389_6 + var_389_16 + arg_389_0 then
				arg_386_1.typewritter.percent = 1

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(true)
			end
		end

		arg_386_1.nodeConfigList_ = {}

		arg_386_1:InitPlayNodeList()
	end,
	Play1102205094 = function(arg_390_0, arg_390_1)
		arg_390_1.time_ = 0
		arg_390_1.frameCnt_ = 0
		arg_390_1.state_ = "playing"
		arg_390_1.curTalkId_ = 1102205094
		arg_390_1.duration_ = 6.53

		SetActive(arg_390_1.tipsGo_, false)

		function arg_390_1.onSingleLineFinish_()
			arg_390_1.onSingleLineUpdate_ = nil
			arg_390_1.onSingleLineFinish_ = nil
			arg_390_1.state_ = "waiting"
		end

		function arg_390_1.playNext_(arg_392_0)
			if arg_392_0 == 1 then
				arg_390_0:Play1102205095(arg_390_1)
			end
		end

		function arg_390_1.onSingleLineUpdate_(arg_393_0)
			local var_393_0 = 0
			local var_393_1 = 0.625

			if var_393_0 < arg_390_1.time_ and arg_390_1.time_ <= var_393_0 + arg_393_0 then
				arg_390_1.talkMaxDuration = 0
				arg_390_1.dialogCg_.alpha = 1

				arg_390_1.dialog_:SetActive(true)
				SetActive(arg_390_1.leftNameGo_, true)

				local var_393_2 = arg_390_1:FormatText(StoryNameCfg[259].name)

				arg_390_1.leftNameTxt_.text = var_393_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_390_1.leftNameTxt_.transform)

				arg_390_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_390_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_390_1:RecordName(arg_390_1.leftNameTxt_.text)
				SetActive(arg_390_1.iconTrs_.gameObject, false)
				arg_390_1.callingController_:SetSelectedState("normal")

				local var_393_3 = arg_390_1:GetWordFromCfg(1102205094)
				local var_393_4 = arg_390_1:FormatText(var_393_3.content)

				arg_390_1.text_.text = var_393_4

				LuaForUtil.ClearLinePrefixSymbol(arg_390_1.text_)

				local var_393_5 = 25
				local var_393_6 = utf8.len(var_393_4)
				local var_393_7 = var_393_5 <= 0 and var_393_1 or var_393_1 * (var_393_6 / var_393_5)

				if var_393_7 > 0 and var_393_1 < var_393_7 then
					arg_390_1.talkMaxDuration = var_393_7

					if var_393_7 + var_393_0 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_7 + var_393_0
					end
				end

				arg_390_1.text_.text = var_393_4
				arg_390_1.typewritter.percent = 0

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205094", "story_v_side_new_1102205.awb") ~= 0 then
					local var_393_8 = manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205094", "story_v_side_new_1102205.awb") / 1000

					if var_393_8 + var_393_0 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_8 + var_393_0
					end

					if var_393_3.prefab_name ~= "" and arg_390_1.actors_[var_393_3.prefab_name] ~= nil then
						local var_393_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_390_1.actors_[var_393_3.prefab_name].transform, "story_v_side_new_1102205", "1102205094", "story_v_side_new_1102205.awb")

						arg_390_1:RecordAudio("1102205094", var_393_9)
						arg_390_1:RecordAudio("1102205094", var_393_9)
					else
						arg_390_1:AudioAction("play", "voice", "story_v_side_new_1102205", "1102205094", "story_v_side_new_1102205.awb")
					end

					arg_390_1:RecordHistoryTalkVoice("story_v_side_new_1102205", "1102205094", "story_v_side_new_1102205.awb")
				end

				arg_390_1:RecordContent(arg_390_1.text_.text)
			end

			local var_393_10 = math.max(var_393_1, arg_390_1.talkMaxDuration)

			if var_393_0 <= arg_390_1.time_ and arg_390_1.time_ < var_393_0 + var_393_10 then
				arg_390_1.typewritter.percent = (arg_390_1.time_ - var_393_0) / var_393_10

				arg_390_1.typewritter:SetDirty()
			end

			if arg_390_1.time_ >= var_393_0 + var_393_10 and arg_390_1.time_ < var_393_0 + var_393_10 + arg_393_0 then
				arg_390_1.typewritter.percent = 1

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(true)
			end
		end

		arg_390_1.nodeConfigList_ = {}

		arg_390_1:InitPlayNodeList()
	end,
	Play1102205095 = function(arg_394_0, arg_394_1)
		arg_394_1.time_ = 0
		arg_394_1.frameCnt_ = 0
		arg_394_1.state_ = "playing"
		arg_394_1.curTalkId_ = 1102205095
		arg_394_1.duration_ = 8.5

		SetActive(arg_394_1.tipsGo_, false)

		function arg_394_1.onSingleLineFinish_()
			arg_394_1.onSingleLineUpdate_ = nil
			arg_394_1.onSingleLineFinish_ = nil
			arg_394_1.state_ = "waiting"
		end

		function arg_394_1.playNext_(arg_396_0)
			if arg_396_0 == 1 then
				arg_394_0:Play1102205096(arg_394_1)
			end
		end

		function arg_394_1.onSingleLineUpdate_(arg_397_0)
			local var_397_0 = "F08l"

			if arg_394_1.bgs_[var_397_0] == nil then
				local var_397_1 = Object.Instantiate(arg_394_1.paintGo_)

				var_397_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_397_0)
				var_397_1.name = var_397_0
				var_397_1.transform.parent = arg_394_1.stage_.transform
				var_397_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_394_1.bgs_[var_397_0] = var_397_1
			end

			local var_397_2 = 2

			if var_397_2 < arg_394_1.time_ and arg_394_1.time_ <= var_397_2 + arg_397_0 then
				local var_397_3 = manager.ui.mainCamera.transform.localPosition
				local var_397_4 = Vector3.New(0, 0, 10) + Vector3.New(var_397_3.x, var_397_3.y, 0)
				local var_397_5 = arg_394_1.bgs_.F08l

				var_397_5.transform.localPosition = var_397_4
				var_397_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_397_6 = var_397_5:GetComponent("SpriteRenderer")

				if var_397_6 and var_397_6.sprite then
					local var_397_7 = (var_397_5.transform.localPosition - var_397_3).z
					local var_397_8 = manager.ui.mainCameraCom_
					local var_397_9 = 2 * var_397_7 * Mathf.Tan(var_397_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_397_10 = var_397_9 * var_397_8.aspect
					local var_397_11 = var_397_6.sprite.bounds.size.x
					local var_397_12 = var_397_6.sprite.bounds.size.y
					local var_397_13 = var_397_10 / var_397_11
					local var_397_14 = var_397_9 / var_397_12
					local var_397_15 = var_397_14 < var_397_13 and var_397_13 or var_397_14

					var_397_5.transform.localScale = Vector3.New(var_397_15, var_397_15, 0)
				end

				for iter_397_0, iter_397_1 in pairs(arg_394_1.bgs_) do
					if iter_397_0 ~= "F08l" then
						iter_397_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_397_16 = 0

			if var_397_16 < arg_394_1.time_ and arg_394_1.time_ <= var_397_16 + arg_397_0 then
				arg_394_1.allBtn_.enabled = false
			end

			local var_397_17 = 0.3

			if arg_394_1.time_ >= var_397_16 + var_397_17 and arg_394_1.time_ < var_397_16 + var_397_17 + arg_397_0 then
				arg_394_1.allBtn_.enabled = true
			end

			local var_397_18 = 0

			if var_397_18 < arg_394_1.time_ and arg_394_1.time_ <= var_397_18 + arg_397_0 then
				arg_394_1.mask_.enabled = true
				arg_394_1.mask_.raycastTarget = true

				arg_394_1:SetGaussion(false)
			end

			local var_397_19 = 2

			if var_397_18 <= arg_394_1.time_ and arg_394_1.time_ < var_397_18 + var_397_19 then
				local var_397_20 = (arg_394_1.time_ - var_397_18) / var_397_19
				local var_397_21 = Color.New(0, 0, 0)

				var_397_21.a = Mathf.Lerp(0, 1, var_397_20)
				arg_394_1.mask_.color = var_397_21
			end

			if arg_394_1.time_ >= var_397_18 + var_397_19 and arg_394_1.time_ < var_397_18 + var_397_19 + arg_397_0 then
				local var_397_22 = Color.New(0, 0, 0)

				var_397_22.a = 1
				arg_394_1.mask_.color = var_397_22
			end

			local var_397_23 = 2

			if var_397_23 < arg_394_1.time_ and arg_394_1.time_ <= var_397_23 + arg_397_0 then
				arg_394_1.mask_.enabled = true
				arg_394_1.mask_.raycastTarget = true

				arg_394_1:SetGaussion(false)
			end

			local var_397_24 = 2

			if var_397_23 <= arg_394_1.time_ and arg_394_1.time_ < var_397_23 + var_397_24 then
				local var_397_25 = (arg_394_1.time_ - var_397_23) / var_397_24
				local var_397_26 = Color.New(0, 0, 0)

				var_397_26.a = Mathf.Lerp(1, 0, var_397_25)
				arg_394_1.mask_.color = var_397_26
			end

			if arg_394_1.time_ >= var_397_23 + var_397_24 and arg_394_1.time_ < var_397_23 + var_397_24 + arg_397_0 then
				local var_397_27 = Color.New(0, 0, 0)
				local var_397_28 = 0

				arg_394_1.mask_.enabled = false
				var_397_27.a = var_397_28
				arg_394_1.mask_.color = var_397_27
			end

			local var_397_29 = arg_394_1.actors_["1022ui_story"].transform
			local var_397_30 = 2

			if var_397_30 < arg_394_1.time_ and arg_394_1.time_ <= var_397_30 + arg_397_0 then
				arg_394_1.var_.moveOldPos1022ui_story = var_397_29.localPosition
			end

			local var_397_31 = 0.001

			if var_397_30 <= arg_394_1.time_ and arg_394_1.time_ < var_397_30 + var_397_31 then
				local var_397_32 = (arg_394_1.time_ - var_397_30) / var_397_31
				local var_397_33 = Vector3.New(0, 100, 0)

				var_397_29.localPosition = Vector3.Lerp(arg_394_1.var_.moveOldPos1022ui_story, var_397_33, var_397_32)

				local var_397_34 = manager.ui.mainCamera.transform.position - var_397_29.position

				var_397_29.forward = Vector3.New(var_397_34.x, var_397_34.y, var_397_34.z)

				local var_397_35 = var_397_29.localEulerAngles

				var_397_35.z = 0
				var_397_35.x = 0
				var_397_29.localEulerAngles = var_397_35
			end

			if arg_394_1.time_ >= var_397_30 + var_397_31 and arg_394_1.time_ < var_397_30 + var_397_31 + arg_397_0 then
				var_397_29.localPosition = Vector3.New(0, 100, 0)

				local var_397_36 = manager.ui.mainCamera.transform.position - var_397_29.position

				var_397_29.forward = Vector3.New(var_397_36.x, var_397_36.y, var_397_36.z)

				local var_397_37 = var_397_29.localEulerAngles

				var_397_37.z = 0
				var_397_37.x = 0
				var_397_29.localEulerAngles = var_397_37
			end

			local var_397_38 = arg_394_1.actors_["1022ui_story"]
			local var_397_39 = 2

			if var_397_39 < arg_394_1.time_ and arg_394_1.time_ <= var_397_39 + arg_397_0 and not isNil(var_397_38) and arg_394_1.var_.characterEffect1022ui_story == nil then
				arg_394_1.var_.characterEffect1022ui_story = var_397_38:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_397_40 = 0.200000002980232

			if var_397_39 <= arg_394_1.time_ and arg_394_1.time_ < var_397_39 + var_397_40 and not isNil(var_397_38) then
				local var_397_41 = (arg_394_1.time_ - var_397_39) / var_397_40

				if arg_394_1.var_.characterEffect1022ui_story and not isNil(var_397_38) then
					local var_397_42 = Mathf.Lerp(0, 0.5, var_397_41)

					arg_394_1.var_.characterEffect1022ui_story.fillFlat = true
					arg_394_1.var_.characterEffect1022ui_story.fillRatio = var_397_42
				end
			end

			if arg_394_1.time_ >= var_397_39 + var_397_40 and arg_394_1.time_ < var_397_39 + var_397_40 + arg_397_0 and not isNil(var_397_38) and arg_394_1.var_.characterEffect1022ui_story then
				local var_397_43 = 0.5

				arg_394_1.var_.characterEffect1022ui_story.fillFlat = true
				arg_394_1.var_.characterEffect1022ui_story.fillRatio = var_397_43
			end

			local var_397_44 = 0.133333333333333
			local var_397_45 = 1

			if var_397_44 < arg_394_1.time_ and arg_394_1.time_ <= var_397_44 + arg_397_0 then
				local var_397_46 = "stop"
				local var_397_47 = "effect"

				arg_394_1:AudioAction(var_397_46, var_397_47, "se_story", "se_story_crowdloop", "")
			end

			local var_397_48 = 1.6
			local var_397_49 = 1

			if var_397_48 < arg_394_1.time_ and arg_394_1.time_ <= var_397_48 + arg_397_0 then
				local var_397_50 = "play"
				local var_397_51 = "effect"

				arg_394_1:AudioAction(var_397_50, var_397_51, "se_story_140", "se_story_140_amb_street01", "")
			end

			if arg_394_1.frameCnt_ <= 1 then
				arg_394_1.dialog_:SetActive(false)
			end

			local var_397_52 = 3.5
			local var_397_53 = 0.25

			if var_397_52 < arg_394_1.time_ and arg_394_1.time_ <= var_397_52 + arg_397_0 then
				arg_394_1.talkMaxDuration = 0

				arg_394_1.dialog_:SetActive(true)

				arg_394_1.dialogCg_.alpha = 0

				local var_397_54 = LeanTween.value(arg_394_1.dialog_, 0, 1, 0.3)

				var_397_54:setOnUpdate(LuaHelper.FloatAction(function(arg_398_0)
					arg_394_1.dialogCg_.alpha = arg_398_0
				end))
				var_397_54:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_394_1.dialog_)
					var_397_54:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_394_1.duration_ = arg_394_1.duration_ + 0.3

				SetActive(arg_394_1.leftNameGo_, true)

				local var_397_55 = arg_394_1:FormatText(StoryNameCfg[7].name)

				arg_394_1.leftNameTxt_.text = var_397_55

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_394_1.leftNameTxt_.transform)

				arg_394_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_394_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_394_1:RecordName(arg_394_1.leftNameTxt_.text)
				SetActive(arg_394_1.iconTrs_.gameObject, true)
				arg_394_1.iconController_:SetSelectedState("hero")

				arg_394_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_394_1.callingController_:SetSelectedState("normal")

				arg_394_1.keyicon_.color = Color.New(1, 1, 1)
				arg_394_1.icon_.color = Color.New(1, 1, 1)

				local var_397_56 = arg_394_1:GetWordFromCfg(1102205095)
				local var_397_57 = arg_394_1:FormatText(var_397_56.content)

				arg_394_1.text_.text = var_397_57

				LuaForUtil.ClearLinePrefixSymbol(arg_394_1.text_)

				local var_397_58 = 10
				local var_397_59 = utf8.len(var_397_57)
				local var_397_60 = var_397_58 <= 0 and var_397_53 or var_397_53 * (var_397_59 / var_397_58)

				if var_397_60 > 0 and var_397_53 < var_397_60 then
					arg_394_1.talkMaxDuration = var_397_60
					var_397_52 = var_397_52 + 0.3

					if var_397_60 + var_397_52 > arg_394_1.duration_ then
						arg_394_1.duration_ = var_397_60 + var_397_52
					end
				end

				arg_394_1.text_.text = var_397_57
				arg_394_1.typewritter.percent = 0

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(false)
				arg_394_1:RecordContent(arg_394_1.text_.text)
			end

			local var_397_61 = var_397_52 + 0.3
			local var_397_62 = math.max(var_397_53, arg_394_1.talkMaxDuration)

			if var_397_61 <= arg_394_1.time_ and arg_394_1.time_ < var_397_61 + var_397_62 then
				arg_394_1.typewritter.percent = (arg_394_1.time_ - var_397_61) / var_397_62

				arg_394_1.typewritter:SetDirty()
			end

			if arg_394_1.time_ >= var_397_61 + var_397_62 and arg_394_1.time_ < var_397_61 + var_397_62 + arg_397_0 then
				arg_394_1.typewritter.percent = 1

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(true)
			end
		end

		arg_394_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1022ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_394_1:InitPlayNodeList()
	end,
	Play1102205096 = function(arg_400_0, arg_400_1)
		arg_400_1.time_ = 0
		arg_400_1.frameCnt_ = 0
		arg_400_1.state_ = "playing"
		arg_400_1.curTalkId_ = 1102205096
		arg_400_1.duration_ = 5

		SetActive(arg_400_1.tipsGo_, false)

		function arg_400_1.onSingleLineFinish_()
			arg_400_1.onSingleLineUpdate_ = nil
			arg_400_1.onSingleLineFinish_ = nil
			arg_400_1.state_ = "waiting"
		end

		function arg_400_1.playNext_(arg_402_0)
			if arg_402_0 == 1 then
				arg_400_0:Play1102205097(arg_400_1)
			end
		end

		function arg_400_1.onSingleLineUpdate_(arg_403_0)
			local var_403_0 = 0
			local var_403_1 = 1.225

			if var_403_0 < arg_400_1.time_ and arg_400_1.time_ <= var_403_0 + arg_403_0 then
				arg_400_1.talkMaxDuration = 0
				arg_400_1.dialogCg_.alpha = 1

				arg_400_1.dialog_:SetActive(true)
				SetActive(arg_400_1.leftNameGo_, false)

				arg_400_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_400_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_400_1:RecordName(arg_400_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_400_1.iconTrs_.gameObject, false)
				arg_400_1.callingController_:SetSelectedState("normal")

				local var_403_2 = arg_400_1:GetWordFromCfg(1102205096)
				local var_403_3 = arg_400_1:FormatText(var_403_2.content)

				arg_400_1.text_.text = var_403_3

				LuaForUtil.ClearLinePrefixSymbol(arg_400_1.text_)

				local var_403_4 = 49
				local var_403_5 = utf8.len(var_403_3)
				local var_403_6 = var_403_4 <= 0 and var_403_1 or var_403_1 * (var_403_5 / var_403_4)

				if var_403_6 > 0 and var_403_1 < var_403_6 then
					arg_400_1.talkMaxDuration = var_403_6

					if var_403_6 + var_403_0 > arg_400_1.duration_ then
						arg_400_1.duration_ = var_403_6 + var_403_0
					end
				end

				arg_400_1.text_.text = var_403_3
				arg_400_1.typewritter.percent = 0

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(false)
				arg_400_1:RecordContent(arg_400_1.text_.text)
			end

			local var_403_7 = math.max(var_403_1, arg_400_1.talkMaxDuration)

			if var_403_0 <= arg_400_1.time_ and arg_400_1.time_ < var_403_0 + var_403_7 then
				arg_400_1.typewritter.percent = (arg_400_1.time_ - var_403_0) / var_403_7

				arg_400_1.typewritter:SetDirty()
			end

			if arg_400_1.time_ >= var_403_0 + var_403_7 and arg_400_1.time_ < var_403_0 + var_403_7 + arg_403_0 then
				arg_400_1.typewritter.percent = 1

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(true)
			end
		end

		arg_400_1.nodeConfigList_ = {}

		arg_400_1:InitPlayNodeList()
	end,
	Play1102205097 = function(arg_404_0, arg_404_1)
		arg_404_1.time_ = 0
		arg_404_1.frameCnt_ = 0
		arg_404_1.state_ = "playing"
		arg_404_1.curTalkId_ = 1102205097
		arg_404_1.duration_ = 5

		SetActive(arg_404_1.tipsGo_, false)

		function arg_404_1.onSingleLineFinish_()
			arg_404_1.onSingleLineUpdate_ = nil
			arg_404_1.onSingleLineFinish_ = nil
			arg_404_1.state_ = "waiting"
		end

		function arg_404_1.playNext_(arg_406_0)
			if arg_406_0 == 1 then
				arg_404_0:Play1102205098(arg_404_1)
			end
		end

		function arg_404_1.onSingleLineUpdate_(arg_407_0)
			local var_407_0 = 0
			local var_407_1 = 1.275

			if var_407_0 < arg_404_1.time_ and arg_404_1.time_ <= var_407_0 + arg_407_0 then
				arg_404_1.talkMaxDuration = 0
				arg_404_1.dialogCg_.alpha = 1

				arg_404_1.dialog_:SetActive(true)
				SetActive(arg_404_1.leftNameGo_, false)

				arg_404_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_404_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_404_1:RecordName(arg_404_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_404_1.iconTrs_.gameObject, false)
				arg_404_1.callingController_:SetSelectedState("normal")

				local var_407_2 = arg_404_1:GetWordFromCfg(1102205097)
				local var_407_3 = arg_404_1:FormatText(var_407_2.content)

				arg_404_1.text_.text = var_407_3

				LuaForUtil.ClearLinePrefixSymbol(arg_404_1.text_)

				local var_407_4 = 51
				local var_407_5 = utf8.len(var_407_3)
				local var_407_6 = var_407_4 <= 0 and var_407_1 or var_407_1 * (var_407_5 / var_407_4)

				if var_407_6 > 0 and var_407_1 < var_407_6 then
					arg_404_1.talkMaxDuration = var_407_6

					if var_407_6 + var_407_0 > arg_404_1.duration_ then
						arg_404_1.duration_ = var_407_6 + var_407_0
					end
				end

				arg_404_1.text_.text = var_407_3
				arg_404_1.typewritter.percent = 0

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(false)
				arg_404_1:RecordContent(arg_404_1.text_.text)
			end

			local var_407_7 = math.max(var_407_1, arg_404_1.talkMaxDuration)

			if var_407_0 <= arg_404_1.time_ and arg_404_1.time_ < var_407_0 + var_407_7 then
				arg_404_1.typewritter.percent = (arg_404_1.time_ - var_407_0) / var_407_7

				arg_404_1.typewritter:SetDirty()
			end

			if arg_404_1.time_ >= var_407_0 + var_407_7 and arg_404_1.time_ < var_407_0 + var_407_7 + arg_407_0 then
				arg_404_1.typewritter.percent = 1

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(true)
			end
		end

		arg_404_1.nodeConfigList_ = {}

		arg_404_1:InitPlayNodeList()
	end,
	Play1102205098 = function(arg_408_0, arg_408_1)
		arg_408_1.time_ = 0
		arg_408_1.frameCnt_ = 0
		arg_408_1.state_ = "playing"
		arg_408_1.curTalkId_ = 1102205098
		arg_408_1.duration_ = 5

		SetActive(arg_408_1.tipsGo_, false)

		function arg_408_1.onSingleLineFinish_()
			arg_408_1.onSingleLineUpdate_ = nil
			arg_408_1.onSingleLineFinish_ = nil
			arg_408_1.state_ = "waiting"
		end

		function arg_408_1.playNext_(arg_410_0)
			if arg_410_0 == 1 then
				arg_408_0:Play1102205099(arg_408_1)
			end
		end

		function arg_408_1.onSingleLineUpdate_(arg_411_0)
			local var_411_0 = 0.0500000000000001
			local var_411_1 = 1

			if var_411_0 < arg_408_1.time_ and arg_408_1.time_ <= var_411_0 + arg_411_0 then
				local var_411_2 = "play"
				local var_411_3 = "effect"

				arg_408_1:AudioAction(var_411_2, var_411_3, "se_story_121_04", "se_story_121_04_walk", "")
			end

			local var_411_4 = 0
			local var_411_5 = 1.05

			if var_411_4 < arg_408_1.time_ and arg_408_1.time_ <= var_411_4 + arg_411_0 then
				arg_408_1.talkMaxDuration = 0
				arg_408_1.dialogCg_.alpha = 1

				arg_408_1.dialog_:SetActive(true)
				SetActive(arg_408_1.leftNameGo_, false)

				arg_408_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_408_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_408_1:RecordName(arg_408_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_408_1.iconTrs_.gameObject, false)
				arg_408_1.callingController_:SetSelectedState("normal")

				local var_411_6 = arg_408_1:GetWordFromCfg(1102205098)
				local var_411_7 = arg_408_1:FormatText(var_411_6.content)

				arg_408_1.text_.text = var_411_7

				LuaForUtil.ClearLinePrefixSymbol(arg_408_1.text_)

				local var_411_8 = 42
				local var_411_9 = utf8.len(var_411_7)
				local var_411_10 = var_411_8 <= 0 and var_411_5 or var_411_5 * (var_411_9 / var_411_8)

				if var_411_10 > 0 and var_411_5 < var_411_10 then
					arg_408_1.talkMaxDuration = var_411_10

					if var_411_10 + var_411_4 > arg_408_1.duration_ then
						arg_408_1.duration_ = var_411_10 + var_411_4
					end
				end

				arg_408_1.text_.text = var_411_7
				arg_408_1.typewritter.percent = 0

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(false)
				arg_408_1:RecordContent(arg_408_1.text_.text)
			end

			local var_411_11 = math.max(var_411_5, arg_408_1.talkMaxDuration)

			if var_411_4 <= arg_408_1.time_ and arg_408_1.time_ < var_411_4 + var_411_11 then
				arg_408_1.typewritter.percent = (arg_408_1.time_ - var_411_4) / var_411_11

				arg_408_1.typewritter:SetDirty()
			end

			if arg_408_1.time_ >= var_411_4 + var_411_11 and arg_408_1.time_ < var_411_4 + var_411_11 + arg_411_0 then
				arg_408_1.typewritter.percent = 1

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(true)
			end
		end

		arg_408_1.nodeConfigList_ = {}

		arg_408_1:InitPlayNodeList()
	end,
	Play1102205099 = function(arg_412_0, arg_412_1)
		arg_412_1.time_ = 0
		arg_412_1.frameCnt_ = 0
		arg_412_1.state_ = "playing"
		arg_412_1.curTalkId_ = 1102205099
		arg_412_1.duration_ = 5.37

		SetActive(arg_412_1.tipsGo_, false)

		function arg_412_1.onSingleLineFinish_()
			arg_412_1.onSingleLineUpdate_ = nil
			arg_412_1.onSingleLineFinish_ = nil
			arg_412_1.state_ = "waiting"
		end

		function arg_412_1.playNext_(arg_414_0)
			if arg_414_0 == 1 then
				arg_412_0:Play1102205100(arg_412_1)
			end
		end

		function arg_412_1.onSingleLineUpdate_(arg_415_0)
			local var_415_0 = arg_412_1.actors_["1022ui_story"].transform
			local var_415_1 = 0

			if var_415_1 < arg_412_1.time_ and arg_412_1.time_ <= var_415_1 + arg_415_0 then
				arg_412_1.var_.moveOldPos1022ui_story = var_415_0.localPosition
			end

			local var_415_2 = 0.001

			if var_415_1 <= arg_412_1.time_ and arg_412_1.time_ < var_415_1 + var_415_2 then
				local var_415_3 = (arg_412_1.time_ - var_415_1) / var_415_2
				local var_415_4 = Vector3.New(0, -1.08, -6)

				var_415_0.localPosition = Vector3.Lerp(arg_412_1.var_.moveOldPos1022ui_story, var_415_4, var_415_3)

				local var_415_5 = manager.ui.mainCamera.transform.position - var_415_0.position

				var_415_0.forward = Vector3.New(var_415_5.x, var_415_5.y, var_415_5.z)

				local var_415_6 = var_415_0.localEulerAngles

				var_415_6.z = 0
				var_415_6.x = 0
				var_415_0.localEulerAngles = var_415_6
			end

			if arg_412_1.time_ >= var_415_1 + var_415_2 and arg_412_1.time_ < var_415_1 + var_415_2 + arg_415_0 then
				var_415_0.localPosition = Vector3.New(0, -1.08, -6)

				local var_415_7 = manager.ui.mainCamera.transform.position - var_415_0.position

				var_415_0.forward = Vector3.New(var_415_7.x, var_415_7.y, var_415_7.z)

				local var_415_8 = var_415_0.localEulerAngles

				var_415_8.z = 0
				var_415_8.x = 0
				var_415_0.localEulerAngles = var_415_8
			end

			local var_415_9 = arg_412_1.actors_["1022ui_story"]
			local var_415_10 = 0

			if var_415_10 < arg_412_1.time_ and arg_412_1.time_ <= var_415_10 + arg_415_0 and not isNil(var_415_9) and arg_412_1.var_.characterEffect1022ui_story == nil then
				arg_412_1.var_.characterEffect1022ui_story = var_415_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_415_11 = 0.200000002980232

			if var_415_10 <= arg_412_1.time_ and arg_412_1.time_ < var_415_10 + var_415_11 and not isNil(var_415_9) then
				local var_415_12 = (arg_412_1.time_ - var_415_10) / var_415_11

				if arg_412_1.var_.characterEffect1022ui_story and not isNil(var_415_9) then
					arg_412_1.var_.characterEffect1022ui_story.fillFlat = false
				end
			end

			if arg_412_1.time_ >= var_415_10 + var_415_11 and arg_412_1.time_ < var_415_10 + var_415_11 + arg_415_0 and not isNil(var_415_9) and arg_412_1.var_.characterEffect1022ui_story then
				arg_412_1.var_.characterEffect1022ui_story.fillFlat = false
			end

			local var_415_13 = 0

			if var_415_13 < arg_412_1.time_ and arg_412_1.time_ <= var_415_13 + arg_415_0 then
				arg_412_1:PlayTimeline("1022ui_story", "StoryTimeline/CharAction/story1022/story1022action/1022action3_1")
			end

			local var_415_14 = 0

			if var_415_14 < arg_412_1.time_ and arg_412_1.time_ <= var_415_14 + arg_415_0 then
				arg_412_1:PlayTimeline("1022ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_415_15 = 0
			local var_415_16 = 0.7

			if var_415_15 < arg_412_1.time_ and arg_412_1.time_ <= var_415_15 + arg_415_0 then
				arg_412_1.talkMaxDuration = 0
				arg_412_1.dialogCg_.alpha = 1

				arg_412_1.dialog_:SetActive(true)
				SetActive(arg_412_1.leftNameGo_, true)

				local var_415_17 = arg_412_1:FormatText(StoryNameCfg[259].name)

				arg_412_1.leftNameTxt_.text = var_415_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_412_1.leftNameTxt_.transform)

				arg_412_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_412_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_412_1:RecordName(arg_412_1.leftNameTxt_.text)
				SetActive(arg_412_1.iconTrs_.gameObject, false)
				arg_412_1.callingController_:SetSelectedState("normal")

				local var_415_18 = arg_412_1:GetWordFromCfg(1102205099)
				local var_415_19 = arg_412_1:FormatText(var_415_18.content)

				arg_412_1.text_.text = var_415_19

				LuaForUtil.ClearLinePrefixSymbol(arg_412_1.text_)

				local var_415_20 = 28
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

				if manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205099", "story_v_side_new_1102205.awb") ~= 0 then
					local var_415_23 = manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205099", "story_v_side_new_1102205.awb") / 1000

					if var_415_23 + var_415_15 > arg_412_1.duration_ then
						arg_412_1.duration_ = var_415_23 + var_415_15
					end

					if var_415_18.prefab_name ~= "" and arg_412_1.actors_[var_415_18.prefab_name] ~= nil then
						local var_415_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_412_1.actors_[var_415_18.prefab_name].transform, "story_v_side_new_1102205", "1102205099", "story_v_side_new_1102205.awb")

						arg_412_1:RecordAudio("1102205099", var_415_24)
						arg_412_1:RecordAudio("1102205099", var_415_24)
					else
						arg_412_1:AudioAction("play", "voice", "story_v_side_new_1102205", "1102205099", "story_v_side_new_1102205.awb")
					end

					arg_412_1:RecordHistoryTalkVoice("story_v_side_new_1102205", "1102205099", "story_v_side_new_1102205.awb")
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
				actorName = "1022ui_story",
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
	Play1102205100 = function(arg_416_0, arg_416_1)
		arg_416_1.time_ = 0
		arg_416_1.frameCnt_ = 0
		arg_416_1.state_ = "playing"
		arg_416_1.curTalkId_ = 1102205100
		arg_416_1.duration_ = 5

		SetActive(arg_416_1.tipsGo_, false)

		function arg_416_1.onSingleLineFinish_()
			arg_416_1.onSingleLineUpdate_ = nil
			arg_416_1.onSingleLineFinish_ = nil
			arg_416_1.state_ = "waiting"
		end

		function arg_416_1.playNext_(arg_418_0)
			if arg_418_0 == 1 then
				arg_416_0:Play1102205101(arg_416_1)
			end
		end

		function arg_416_1.onSingleLineUpdate_(arg_419_0)
			local var_419_0 = arg_416_1.actors_["1022ui_story"]
			local var_419_1 = 0

			if var_419_1 < arg_416_1.time_ and arg_416_1.time_ <= var_419_1 + arg_419_0 and not isNil(var_419_0) and arg_416_1.var_.characterEffect1022ui_story == nil then
				arg_416_1.var_.characterEffect1022ui_story = var_419_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_419_2 = 0.200000002980232

			if var_419_1 <= arg_416_1.time_ and arg_416_1.time_ < var_419_1 + var_419_2 and not isNil(var_419_0) then
				local var_419_3 = (arg_416_1.time_ - var_419_1) / var_419_2

				if arg_416_1.var_.characterEffect1022ui_story and not isNil(var_419_0) then
					local var_419_4 = Mathf.Lerp(0, 0.5, var_419_3)

					arg_416_1.var_.characterEffect1022ui_story.fillFlat = true
					arg_416_1.var_.characterEffect1022ui_story.fillRatio = var_419_4
				end
			end

			if arg_416_1.time_ >= var_419_1 + var_419_2 and arg_416_1.time_ < var_419_1 + var_419_2 + arg_419_0 and not isNil(var_419_0) and arg_416_1.var_.characterEffect1022ui_story then
				local var_419_5 = 0.5

				arg_416_1.var_.characterEffect1022ui_story.fillFlat = true
				arg_416_1.var_.characterEffect1022ui_story.fillRatio = var_419_5
			end

			local var_419_6 = 0
			local var_419_7 = 0.475

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

				arg_416_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_416_1.callingController_:SetSelectedState("normal")

				arg_416_1.keyicon_.color = Color.New(1, 1, 1)
				arg_416_1.icon_.color = Color.New(1, 1, 1)

				local var_419_9 = arg_416_1:GetWordFromCfg(1102205100)
				local var_419_10 = arg_416_1:FormatText(var_419_9.content)

				arg_416_1.text_.text = var_419_10

				LuaForUtil.ClearLinePrefixSymbol(arg_416_1.text_)

				local var_419_11 = 19
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
	Play1102205101 = function(arg_420_0, arg_420_1)
		arg_420_1.time_ = 0
		arg_420_1.frameCnt_ = 0
		arg_420_1.state_ = "playing"
		arg_420_1.curTalkId_ = 1102205101
		arg_420_1.duration_ = 5

		SetActive(arg_420_1.tipsGo_, false)

		function arg_420_1.onSingleLineFinish_()
			arg_420_1.onSingleLineUpdate_ = nil
			arg_420_1.onSingleLineFinish_ = nil
			arg_420_1.state_ = "waiting"
		end

		function arg_420_1.playNext_(arg_422_0)
			if arg_422_0 == 1 then
				arg_420_0:Play1102205102(arg_420_1)
			end
		end

		function arg_420_1.onSingleLineUpdate_(arg_423_0)
			local var_423_0 = 0
			local var_423_1 = 0.85

			if var_423_0 < arg_420_1.time_ and arg_420_1.time_ <= var_423_0 + arg_423_0 then
				arg_420_1.talkMaxDuration = 0
				arg_420_1.dialogCg_.alpha = 1

				arg_420_1.dialog_:SetActive(true)
				SetActive(arg_420_1.leftNameGo_, true)

				local var_423_2 = arg_420_1:FormatText(StoryNameCfg[7].name)

				arg_420_1.leftNameTxt_.text = var_423_2

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

				local var_423_3 = arg_420_1:GetWordFromCfg(1102205101)
				local var_423_4 = arg_420_1:FormatText(var_423_3.content)

				arg_420_1.text_.text = var_423_4

				LuaForUtil.ClearLinePrefixSymbol(arg_420_1.text_)

				local var_423_5 = 34
				local var_423_6 = utf8.len(var_423_4)
				local var_423_7 = var_423_5 <= 0 and var_423_1 or var_423_1 * (var_423_6 / var_423_5)

				if var_423_7 > 0 and var_423_1 < var_423_7 then
					arg_420_1.talkMaxDuration = var_423_7

					if var_423_7 + var_423_0 > arg_420_1.duration_ then
						arg_420_1.duration_ = var_423_7 + var_423_0
					end
				end

				arg_420_1.text_.text = var_423_4
				arg_420_1.typewritter.percent = 0

				arg_420_1.typewritter:SetDirty()
				arg_420_1:ShowNextGo(false)
				arg_420_1:RecordContent(arg_420_1.text_.text)
			end

			local var_423_8 = math.max(var_423_1, arg_420_1.talkMaxDuration)

			if var_423_0 <= arg_420_1.time_ and arg_420_1.time_ < var_423_0 + var_423_8 then
				arg_420_1.typewritter.percent = (arg_420_1.time_ - var_423_0) / var_423_8

				arg_420_1.typewritter:SetDirty()
			end

			if arg_420_1.time_ >= var_423_0 + var_423_8 and arg_420_1.time_ < var_423_0 + var_423_8 + arg_423_0 then
				arg_420_1.typewritter.percent = 1

				arg_420_1.typewritter:SetDirty()
				arg_420_1:ShowNextGo(true)
			end
		end

		arg_420_1.nodeConfigList_ = {}

		arg_420_1:InitPlayNodeList()
	end,
	Play1102205102 = function(arg_424_0, arg_424_1)
		arg_424_1.time_ = 0
		arg_424_1.frameCnt_ = 0
		arg_424_1.state_ = "playing"
		arg_424_1.curTalkId_ = 1102205102
		arg_424_1.duration_ = 6.2

		SetActive(arg_424_1.tipsGo_, false)

		function arg_424_1.onSingleLineFinish_()
			arg_424_1.onSingleLineUpdate_ = nil
			arg_424_1.onSingleLineFinish_ = nil
			arg_424_1.state_ = "waiting"
		end

		function arg_424_1.playNext_(arg_426_0)
			if arg_426_0 == 1 then
				arg_424_0:Play1102205103(arg_424_1)
			end
		end

		function arg_424_1.onSingleLineUpdate_(arg_427_0)
			local var_427_0 = arg_424_1.actors_["1022ui_story"]
			local var_427_1 = 0

			if var_427_1 < arg_424_1.time_ and arg_424_1.time_ <= var_427_1 + arg_427_0 and not isNil(var_427_0) and arg_424_1.var_.characterEffect1022ui_story == nil then
				arg_424_1.var_.characterEffect1022ui_story = var_427_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_427_2 = 0.200000002980232

			if var_427_1 <= arg_424_1.time_ and arg_424_1.time_ < var_427_1 + var_427_2 and not isNil(var_427_0) then
				local var_427_3 = (arg_424_1.time_ - var_427_1) / var_427_2

				if arg_424_1.var_.characterEffect1022ui_story and not isNil(var_427_0) then
					arg_424_1.var_.characterEffect1022ui_story.fillFlat = false
				end
			end

			if arg_424_1.time_ >= var_427_1 + var_427_2 and arg_424_1.time_ < var_427_1 + var_427_2 + arg_427_0 and not isNil(var_427_0) and arg_424_1.var_.characterEffect1022ui_story then
				arg_424_1.var_.characterEffect1022ui_story.fillFlat = false
			end

			local var_427_4 = 0
			local var_427_5 = 0.625

			if var_427_4 < arg_424_1.time_ and arg_424_1.time_ <= var_427_4 + arg_427_0 then
				arg_424_1.talkMaxDuration = 0
				arg_424_1.dialogCg_.alpha = 1

				arg_424_1.dialog_:SetActive(true)
				SetActive(arg_424_1.leftNameGo_, true)

				local var_427_6 = arg_424_1:FormatText(StoryNameCfg[259].name)

				arg_424_1.leftNameTxt_.text = var_427_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_424_1.leftNameTxt_.transform)

				arg_424_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_424_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_424_1:RecordName(arg_424_1.leftNameTxt_.text)
				SetActive(arg_424_1.iconTrs_.gameObject, false)
				arg_424_1.callingController_:SetSelectedState("normal")

				local var_427_7 = arg_424_1:GetWordFromCfg(1102205102)
				local var_427_8 = arg_424_1:FormatText(var_427_7.content)

				arg_424_1.text_.text = var_427_8

				LuaForUtil.ClearLinePrefixSymbol(arg_424_1.text_)

				local var_427_9 = 25
				local var_427_10 = utf8.len(var_427_8)
				local var_427_11 = var_427_9 <= 0 and var_427_5 or var_427_5 * (var_427_10 / var_427_9)

				if var_427_11 > 0 and var_427_5 < var_427_11 then
					arg_424_1.talkMaxDuration = var_427_11

					if var_427_11 + var_427_4 > arg_424_1.duration_ then
						arg_424_1.duration_ = var_427_11 + var_427_4
					end
				end

				arg_424_1.text_.text = var_427_8
				arg_424_1.typewritter.percent = 0

				arg_424_1.typewritter:SetDirty()
				arg_424_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205102", "story_v_side_new_1102205.awb") ~= 0 then
					local var_427_12 = manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205102", "story_v_side_new_1102205.awb") / 1000

					if var_427_12 + var_427_4 > arg_424_1.duration_ then
						arg_424_1.duration_ = var_427_12 + var_427_4
					end

					if var_427_7.prefab_name ~= "" and arg_424_1.actors_[var_427_7.prefab_name] ~= nil then
						local var_427_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_424_1.actors_[var_427_7.prefab_name].transform, "story_v_side_new_1102205", "1102205102", "story_v_side_new_1102205.awb")

						arg_424_1:RecordAudio("1102205102", var_427_13)
						arg_424_1:RecordAudio("1102205102", var_427_13)
					else
						arg_424_1:AudioAction("play", "voice", "story_v_side_new_1102205", "1102205102", "story_v_side_new_1102205.awb")
					end

					arg_424_1:RecordHistoryTalkVoice("story_v_side_new_1102205", "1102205102", "story_v_side_new_1102205.awb")
				end

				arg_424_1:RecordContent(arg_424_1.text_.text)
			end

			local var_427_14 = math.max(var_427_5, arg_424_1.talkMaxDuration)

			if var_427_4 <= arg_424_1.time_ and arg_424_1.time_ < var_427_4 + var_427_14 then
				arg_424_1.typewritter.percent = (arg_424_1.time_ - var_427_4) / var_427_14

				arg_424_1.typewritter:SetDirty()
			end

			if arg_424_1.time_ >= var_427_4 + var_427_14 and arg_424_1.time_ < var_427_4 + var_427_14 + arg_427_0 then
				arg_424_1.typewritter.percent = 1

				arg_424_1.typewritter:SetDirty()
				arg_424_1:ShowNextGo(true)
			end
		end

		arg_424_1.nodeConfigList_ = {}

		arg_424_1:InitPlayNodeList()
	end,
	Play1102205103 = function(arg_428_0, arg_428_1)
		arg_428_1.time_ = 0
		arg_428_1.frameCnt_ = 0
		arg_428_1.state_ = "playing"
		arg_428_1.curTalkId_ = 1102205103
		arg_428_1.duration_ = 5

		SetActive(arg_428_1.tipsGo_, false)

		function arg_428_1.onSingleLineFinish_()
			arg_428_1.onSingleLineUpdate_ = nil
			arg_428_1.onSingleLineFinish_ = nil
			arg_428_1.state_ = "waiting"
		end

		function arg_428_1.playNext_(arg_430_0)
			if arg_430_0 == 1 then
				arg_428_0:Play1102205104(arg_428_1)
			end
		end

		function arg_428_1.onSingleLineUpdate_(arg_431_0)
			local var_431_0 = arg_428_1.actors_["1022ui_story"]
			local var_431_1 = 0

			if var_431_1 < arg_428_1.time_ and arg_428_1.time_ <= var_431_1 + arg_431_0 and not isNil(var_431_0) and arg_428_1.var_.characterEffect1022ui_story == nil then
				arg_428_1.var_.characterEffect1022ui_story = var_431_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_431_2 = 0.200000002980232

			if var_431_1 <= arg_428_1.time_ and arg_428_1.time_ < var_431_1 + var_431_2 and not isNil(var_431_0) then
				local var_431_3 = (arg_428_1.time_ - var_431_1) / var_431_2

				if arg_428_1.var_.characterEffect1022ui_story and not isNil(var_431_0) then
					local var_431_4 = Mathf.Lerp(0, 0.5, var_431_3)

					arg_428_1.var_.characterEffect1022ui_story.fillFlat = true
					arg_428_1.var_.characterEffect1022ui_story.fillRatio = var_431_4
				end
			end

			if arg_428_1.time_ >= var_431_1 + var_431_2 and arg_428_1.time_ < var_431_1 + var_431_2 + arg_431_0 and not isNil(var_431_0) and arg_428_1.var_.characterEffect1022ui_story then
				local var_431_5 = 0.5

				arg_428_1.var_.characterEffect1022ui_story.fillFlat = true
				arg_428_1.var_.characterEffect1022ui_story.fillRatio = var_431_5
			end

			local var_431_6 = 0
			local var_431_7 = 0.775

			if var_431_6 < arg_428_1.time_ and arg_428_1.time_ <= var_431_6 + arg_431_0 then
				arg_428_1.talkMaxDuration = 0
				arg_428_1.dialogCg_.alpha = 1

				arg_428_1.dialog_:SetActive(true)
				SetActive(arg_428_1.leftNameGo_, true)

				local var_431_8 = arg_428_1:FormatText(StoryNameCfg[7].name)

				arg_428_1.leftNameTxt_.text = var_431_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_428_1.leftNameTxt_.transform)

				arg_428_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_428_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_428_1:RecordName(arg_428_1.leftNameTxt_.text)
				SetActive(arg_428_1.iconTrs_.gameObject, true)
				arg_428_1.iconController_:SetSelectedState("hero")

				arg_428_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_428_1.callingController_:SetSelectedState("normal")

				arg_428_1.keyicon_.color = Color.New(1, 1, 1)
				arg_428_1.icon_.color = Color.New(1, 1, 1)

				local var_431_9 = arg_428_1:GetWordFromCfg(1102205103)
				local var_431_10 = arg_428_1:FormatText(var_431_9.content)

				arg_428_1.text_.text = var_431_10

				LuaForUtil.ClearLinePrefixSymbol(arg_428_1.text_)

				local var_431_11 = 31
				local var_431_12 = utf8.len(var_431_10)
				local var_431_13 = var_431_11 <= 0 and var_431_7 or var_431_7 * (var_431_12 / var_431_11)

				if var_431_13 > 0 and var_431_7 < var_431_13 then
					arg_428_1.talkMaxDuration = var_431_13

					if var_431_13 + var_431_6 > arg_428_1.duration_ then
						arg_428_1.duration_ = var_431_13 + var_431_6
					end
				end

				arg_428_1.text_.text = var_431_10
				arg_428_1.typewritter.percent = 0

				arg_428_1.typewritter:SetDirty()
				arg_428_1:ShowNextGo(false)
				arg_428_1:RecordContent(arg_428_1.text_.text)
			end

			local var_431_14 = math.max(var_431_7, arg_428_1.talkMaxDuration)

			if var_431_6 <= arg_428_1.time_ and arg_428_1.time_ < var_431_6 + var_431_14 then
				arg_428_1.typewritter.percent = (arg_428_1.time_ - var_431_6) / var_431_14

				arg_428_1.typewritter:SetDirty()
			end

			if arg_428_1.time_ >= var_431_6 + var_431_14 and arg_428_1.time_ < var_431_6 + var_431_14 + arg_431_0 then
				arg_428_1.typewritter.percent = 1

				arg_428_1.typewritter:SetDirty()
				arg_428_1:ShowNextGo(true)
			end
		end

		arg_428_1.nodeConfigList_ = {}

		arg_428_1:InitPlayNodeList()
	end,
	Play1102205104 = function(arg_432_0, arg_432_1)
		arg_432_1.time_ = 0
		arg_432_1.frameCnt_ = 0
		arg_432_1.state_ = "playing"
		arg_432_1.curTalkId_ = 1102205104
		arg_432_1.duration_ = 2.1

		SetActive(arg_432_1.tipsGo_, false)

		function arg_432_1.onSingleLineFinish_()
			arg_432_1.onSingleLineUpdate_ = nil
			arg_432_1.onSingleLineFinish_ = nil
			arg_432_1.state_ = "waiting"
		end

		function arg_432_1.playNext_(arg_434_0)
			if arg_434_0 == 1 then
				arg_432_0:Play1102205105(arg_432_1)
			end
		end

		function arg_432_1.onSingleLineUpdate_(arg_435_0)
			local var_435_0 = arg_432_1.actors_["1022ui_story"]
			local var_435_1 = 0

			if var_435_1 < arg_432_1.time_ and arg_432_1.time_ <= var_435_1 + arg_435_0 and not isNil(var_435_0) and arg_432_1.var_.characterEffect1022ui_story == nil then
				arg_432_1.var_.characterEffect1022ui_story = var_435_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_435_2 = 0.200000002980232

			if var_435_1 <= arg_432_1.time_ and arg_432_1.time_ < var_435_1 + var_435_2 and not isNil(var_435_0) then
				local var_435_3 = (arg_432_1.time_ - var_435_1) / var_435_2

				if arg_432_1.var_.characterEffect1022ui_story and not isNil(var_435_0) then
					arg_432_1.var_.characterEffect1022ui_story.fillFlat = false
				end
			end

			if arg_432_1.time_ >= var_435_1 + var_435_2 and arg_432_1.time_ < var_435_1 + var_435_2 + arg_435_0 and not isNil(var_435_0) and arg_432_1.var_.characterEffect1022ui_story then
				arg_432_1.var_.characterEffect1022ui_story.fillFlat = false
			end

			local var_435_4 = 0

			if var_435_4 < arg_432_1.time_ and arg_432_1.time_ <= var_435_4 + arg_435_0 then
				arg_432_1:PlayTimeline("1022ui_story", "StoryTimeline/CharAction/story1022/story1022actionlink/1022action437")
			end

			local var_435_5 = 0
			local var_435_6 = 0.25

			if var_435_5 < arg_432_1.time_ and arg_432_1.time_ <= var_435_5 + arg_435_0 then
				arg_432_1.talkMaxDuration = 0
				arg_432_1.dialogCg_.alpha = 1

				arg_432_1.dialog_:SetActive(true)
				SetActive(arg_432_1.leftNameGo_, true)

				local var_435_7 = arg_432_1:FormatText(StoryNameCfg[259].name)

				arg_432_1.leftNameTxt_.text = var_435_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_432_1.leftNameTxt_.transform)

				arg_432_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_432_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_432_1:RecordName(arg_432_1.leftNameTxt_.text)
				SetActive(arg_432_1.iconTrs_.gameObject, false)
				arg_432_1.callingController_:SetSelectedState("normal")

				local var_435_8 = arg_432_1:GetWordFromCfg(1102205104)
				local var_435_9 = arg_432_1:FormatText(var_435_8.content)

				arg_432_1.text_.text = var_435_9

				LuaForUtil.ClearLinePrefixSymbol(arg_432_1.text_)

				local var_435_10 = 10
				local var_435_11 = utf8.len(var_435_9)
				local var_435_12 = var_435_10 <= 0 and var_435_6 or var_435_6 * (var_435_11 / var_435_10)

				if var_435_12 > 0 and var_435_6 < var_435_12 then
					arg_432_1.talkMaxDuration = var_435_12

					if var_435_12 + var_435_5 > arg_432_1.duration_ then
						arg_432_1.duration_ = var_435_12 + var_435_5
					end
				end

				arg_432_1.text_.text = var_435_9
				arg_432_1.typewritter.percent = 0

				arg_432_1.typewritter:SetDirty()
				arg_432_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205104", "story_v_side_new_1102205.awb") ~= 0 then
					local var_435_13 = manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205104", "story_v_side_new_1102205.awb") / 1000

					if var_435_13 + var_435_5 > arg_432_1.duration_ then
						arg_432_1.duration_ = var_435_13 + var_435_5
					end

					if var_435_8.prefab_name ~= "" and arg_432_1.actors_[var_435_8.prefab_name] ~= nil then
						local var_435_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_432_1.actors_[var_435_8.prefab_name].transform, "story_v_side_new_1102205", "1102205104", "story_v_side_new_1102205.awb")

						arg_432_1:RecordAudio("1102205104", var_435_14)
						arg_432_1:RecordAudio("1102205104", var_435_14)
					else
						arg_432_1:AudioAction("play", "voice", "story_v_side_new_1102205", "1102205104", "story_v_side_new_1102205.awb")
					end

					arg_432_1:RecordHistoryTalkVoice("story_v_side_new_1102205", "1102205104", "story_v_side_new_1102205.awb")
				end

				arg_432_1:RecordContent(arg_432_1.text_.text)
			end

			local var_435_15 = math.max(var_435_6, arg_432_1.talkMaxDuration)

			if var_435_5 <= arg_432_1.time_ and arg_432_1.time_ < var_435_5 + var_435_15 then
				arg_432_1.typewritter.percent = (arg_432_1.time_ - var_435_5) / var_435_15

				arg_432_1.typewritter:SetDirty()
			end

			if arg_432_1.time_ >= var_435_5 + var_435_15 and arg_432_1.time_ < var_435_5 + var_435_15 + arg_435_0 then
				arg_432_1.typewritter.percent = 1

				arg_432_1.typewritter:SetDirty()
				arg_432_1:ShowNextGo(true)
			end
		end

		arg_432_1.nodeConfigList_ = {}

		arg_432_1:InitPlayNodeList()
	end,
	Play1102205105 = function(arg_436_0, arg_436_1)
		arg_436_1.time_ = 0
		arg_436_1.frameCnt_ = 0
		arg_436_1.state_ = "playing"
		arg_436_1.curTalkId_ = 1102205105
		arg_436_1.duration_ = 5

		SetActive(arg_436_1.tipsGo_, false)

		function arg_436_1.onSingleLineFinish_()
			arg_436_1.onSingleLineUpdate_ = nil
			arg_436_1.onSingleLineFinish_ = nil
			arg_436_1.state_ = "waiting"
		end

		function arg_436_1.playNext_(arg_438_0)
			if arg_438_0 == 1 then
				arg_436_0:Play1102205106(arg_436_1)
			end
		end

		function arg_436_1.onSingleLineUpdate_(arg_439_0)
			local var_439_0 = arg_436_1.actors_["1022ui_story"]
			local var_439_1 = 0

			if var_439_1 < arg_436_1.time_ and arg_436_1.time_ <= var_439_1 + arg_439_0 and not isNil(var_439_0) and arg_436_1.var_.characterEffect1022ui_story == nil then
				arg_436_1.var_.characterEffect1022ui_story = var_439_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_439_2 = 0.200000002980232

			if var_439_1 <= arg_436_1.time_ and arg_436_1.time_ < var_439_1 + var_439_2 and not isNil(var_439_0) then
				local var_439_3 = (arg_436_1.time_ - var_439_1) / var_439_2

				if arg_436_1.var_.characterEffect1022ui_story and not isNil(var_439_0) then
					local var_439_4 = Mathf.Lerp(0, 0.5, var_439_3)

					arg_436_1.var_.characterEffect1022ui_story.fillFlat = true
					arg_436_1.var_.characterEffect1022ui_story.fillRatio = var_439_4
				end
			end

			if arg_436_1.time_ >= var_439_1 + var_439_2 and arg_436_1.time_ < var_439_1 + var_439_2 + arg_439_0 and not isNil(var_439_0) and arg_436_1.var_.characterEffect1022ui_story then
				local var_439_5 = 0.5

				arg_436_1.var_.characterEffect1022ui_story.fillFlat = true
				arg_436_1.var_.characterEffect1022ui_story.fillRatio = var_439_5
			end

			local var_439_6 = 0
			local var_439_7 = 0.175

			if var_439_6 < arg_436_1.time_ and arg_436_1.time_ <= var_439_6 + arg_439_0 then
				arg_436_1.talkMaxDuration = 0
				arg_436_1.dialogCg_.alpha = 1

				arg_436_1.dialog_:SetActive(true)
				SetActive(arg_436_1.leftNameGo_, true)

				local var_439_8 = arg_436_1:FormatText(StoryNameCfg[7].name)

				arg_436_1.leftNameTxt_.text = var_439_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_436_1.leftNameTxt_.transform)

				arg_436_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_436_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_436_1:RecordName(arg_436_1.leftNameTxt_.text)
				SetActive(arg_436_1.iconTrs_.gameObject, true)
				arg_436_1.iconController_:SetSelectedState("hero")

				arg_436_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_436_1.callingController_:SetSelectedState("normal")

				arg_436_1.keyicon_.color = Color.New(1, 1, 1)
				arg_436_1.icon_.color = Color.New(1, 1, 1)

				local var_439_9 = arg_436_1:GetWordFromCfg(1102205105)
				local var_439_10 = arg_436_1:FormatText(var_439_9.content)

				arg_436_1.text_.text = var_439_10

				LuaForUtil.ClearLinePrefixSymbol(arg_436_1.text_)

				local var_439_11 = 7
				local var_439_12 = utf8.len(var_439_10)
				local var_439_13 = var_439_11 <= 0 and var_439_7 or var_439_7 * (var_439_12 / var_439_11)

				if var_439_13 > 0 and var_439_7 < var_439_13 then
					arg_436_1.talkMaxDuration = var_439_13

					if var_439_13 + var_439_6 > arg_436_1.duration_ then
						arg_436_1.duration_ = var_439_13 + var_439_6
					end
				end

				arg_436_1.text_.text = var_439_10
				arg_436_1.typewritter.percent = 0

				arg_436_1.typewritter:SetDirty()
				arg_436_1:ShowNextGo(false)
				arg_436_1:RecordContent(arg_436_1.text_.text)
			end

			local var_439_14 = math.max(var_439_7, arg_436_1.talkMaxDuration)

			if var_439_6 <= arg_436_1.time_ and arg_436_1.time_ < var_439_6 + var_439_14 then
				arg_436_1.typewritter.percent = (arg_436_1.time_ - var_439_6) / var_439_14

				arg_436_1.typewritter:SetDirty()
			end

			if arg_436_1.time_ >= var_439_6 + var_439_14 and arg_436_1.time_ < var_439_6 + var_439_14 + arg_439_0 then
				arg_436_1.typewritter.percent = 1

				arg_436_1.typewritter:SetDirty()
				arg_436_1:ShowNextGo(true)
			end
		end

		arg_436_1.nodeConfigList_ = {}

		arg_436_1:InitPlayNodeList()
	end,
	Play1102205106 = function(arg_440_0, arg_440_1)
		arg_440_1.time_ = 0
		arg_440_1.frameCnt_ = 0
		arg_440_1.state_ = "playing"
		arg_440_1.curTalkId_ = 1102205106
		arg_440_1.duration_ = 4.73

		SetActive(arg_440_1.tipsGo_, false)

		function arg_440_1.onSingleLineFinish_()
			arg_440_1.onSingleLineUpdate_ = nil
			arg_440_1.onSingleLineFinish_ = nil
			arg_440_1.state_ = "waiting"
		end

		function arg_440_1.playNext_(arg_442_0)
			if arg_442_0 == 1 then
				arg_440_0:Play1102205107(arg_440_1)
			end
		end

		function arg_440_1.onSingleLineUpdate_(arg_443_0)
			local var_443_0 = arg_440_1.actors_["1022ui_story"]
			local var_443_1 = 0

			if var_443_1 < arg_440_1.time_ and arg_440_1.time_ <= var_443_1 + arg_443_0 and not isNil(var_443_0) and arg_440_1.var_.characterEffect1022ui_story == nil then
				arg_440_1.var_.characterEffect1022ui_story = var_443_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_443_2 = 0.200000002980232

			if var_443_1 <= arg_440_1.time_ and arg_440_1.time_ < var_443_1 + var_443_2 and not isNil(var_443_0) then
				local var_443_3 = (arg_440_1.time_ - var_443_1) / var_443_2

				if arg_440_1.var_.characterEffect1022ui_story and not isNil(var_443_0) then
					arg_440_1.var_.characterEffect1022ui_story.fillFlat = false
				end
			end

			if arg_440_1.time_ >= var_443_1 + var_443_2 and arg_440_1.time_ < var_443_1 + var_443_2 + arg_443_0 and not isNil(var_443_0) and arg_440_1.var_.characterEffect1022ui_story then
				arg_440_1.var_.characterEffect1022ui_story.fillFlat = false
			end

			local var_443_4 = 0
			local var_443_5 = 0.55

			if var_443_4 < arg_440_1.time_ and arg_440_1.time_ <= var_443_4 + arg_443_0 then
				arg_440_1.talkMaxDuration = 0
				arg_440_1.dialogCg_.alpha = 1

				arg_440_1.dialog_:SetActive(true)
				SetActive(arg_440_1.leftNameGo_, true)

				local var_443_6 = arg_440_1:FormatText(StoryNameCfg[259].name)

				arg_440_1.leftNameTxt_.text = var_443_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_440_1.leftNameTxt_.transform)

				arg_440_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_440_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_440_1:RecordName(arg_440_1.leftNameTxt_.text)
				SetActive(arg_440_1.iconTrs_.gameObject, false)
				arg_440_1.callingController_:SetSelectedState("normal")

				local var_443_7 = arg_440_1:GetWordFromCfg(1102205106)
				local var_443_8 = arg_440_1:FormatText(var_443_7.content)

				arg_440_1.text_.text = var_443_8

				LuaForUtil.ClearLinePrefixSymbol(arg_440_1.text_)

				local var_443_9 = 22
				local var_443_10 = utf8.len(var_443_8)
				local var_443_11 = var_443_9 <= 0 and var_443_5 or var_443_5 * (var_443_10 / var_443_9)

				if var_443_11 > 0 and var_443_5 < var_443_11 then
					arg_440_1.talkMaxDuration = var_443_11

					if var_443_11 + var_443_4 > arg_440_1.duration_ then
						arg_440_1.duration_ = var_443_11 + var_443_4
					end
				end

				arg_440_1.text_.text = var_443_8
				arg_440_1.typewritter.percent = 0

				arg_440_1.typewritter:SetDirty()
				arg_440_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205106", "story_v_side_new_1102205.awb") ~= 0 then
					local var_443_12 = manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205106", "story_v_side_new_1102205.awb") / 1000

					if var_443_12 + var_443_4 > arg_440_1.duration_ then
						arg_440_1.duration_ = var_443_12 + var_443_4
					end

					if var_443_7.prefab_name ~= "" and arg_440_1.actors_[var_443_7.prefab_name] ~= nil then
						local var_443_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_440_1.actors_[var_443_7.prefab_name].transform, "story_v_side_new_1102205", "1102205106", "story_v_side_new_1102205.awb")

						arg_440_1:RecordAudio("1102205106", var_443_13)
						arg_440_1:RecordAudio("1102205106", var_443_13)
					else
						arg_440_1:AudioAction("play", "voice", "story_v_side_new_1102205", "1102205106", "story_v_side_new_1102205.awb")
					end

					arg_440_1:RecordHistoryTalkVoice("story_v_side_new_1102205", "1102205106", "story_v_side_new_1102205.awb")
				end

				arg_440_1:RecordContent(arg_440_1.text_.text)
			end

			local var_443_14 = math.max(var_443_5, arg_440_1.talkMaxDuration)

			if var_443_4 <= arg_440_1.time_ and arg_440_1.time_ < var_443_4 + var_443_14 then
				arg_440_1.typewritter.percent = (arg_440_1.time_ - var_443_4) / var_443_14

				arg_440_1.typewritter:SetDirty()
			end

			if arg_440_1.time_ >= var_443_4 + var_443_14 and arg_440_1.time_ < var_443_4 + var_443_14 + arg_443_0 then
				arg_440_1.typewritter.percent = 1

				arg_440_1.typewritter:SetDirty()
				arg_440_1:ShowNextGo(true)
			end
		end

		arg_440_1.nodeConfigList_ = {}

		arg_440_1:InitPlayNodeList()
	end,
	Play1102205107 = function(arg_444_0, arg_444_1)
		arg_444_1.time_ = 0
		arg_444_1.frameCnt_ = 0
		arg_444_1.state_ = "playing"
		arg_444_1.curTalkId_ = 1102205107
		arg_444_1.duration_ = 5

		SetActive(arg_444_1.tipsGo_, false)

		function arg_444_1.onSingleLineFinish_()
			arg_444_1.onSingleLineUpdate_ = nil
			arg_444_1.onSingleLineFinish_ = nil
			arg_444_1.state_ = "waiting"
		end

		function arg_444_1.playNext_(arg_446_0)
			if arg_446_0 == 1 then
				arg_444_0:Play1102205108(arg_444_1)
			end
		end

		function arg_444_1.onSingleLineUpdate_(arg_447_0)
			local var_447_0 = arg_444_1.actors_["1022ui_story"]
			local var_447_1 = 0

			if var_447_1 < arg_444_1.time_ and arg_444_1.time_ <= var_447_1 + arg_447_0 and not isNil(var_447_0) and arg_444_1.var_.characterEffect1022ui_story == nil then
				arg_444_1.var_.characterEffect1022ui_story = var_447_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_447_2 = 0.200000002980232

			if var_447_1 <= arg_444_1.time_ and arg_444_1.time_ < var_447_1 + var_447_2 and not isNil(var_447_0) then
				local var_447_3 = (arg_444_1.time_ - var_447_1) / var_447_2

				if arg_444_1.var_.characterEffect1022ui_story and not isNil(var_447_0) then
					local var_447_4 = Mathf.Lerp(0, 0.5, var_447_3)

					arg_444_1.var_.characterEffect1022ui_story.fillFlat = true
					arg_444_1.var_.characterEffect1022ui_story.fillRatio = var_447_4
				end
			end

			if arg_444_1.time_ >= var_447_1 + var_447_2 and arg_444_1.time_ < var_447_1 + var_447_2 + arg_447_0 and not isNil(var_447_0) and arg_444_1.var_.characterEffect1022ui_story then
				local var_447_5 = 0.5

				arg_444_1.var_.characterEffect1022ui_story.fillFlat = true
				arg_444_1.var_.characterEffect1022ui_story.fillRatio = var_447_5
			end

			local var_447_6 = 0
			local var_447_7 = 0.175

			if var_447_6 < arg_444_1.time_ and arg_444_1.time_ <= var_447_6 + arg_447_0 then
				arg_444_1.talkMaxDuration = 0
				arg_444_1.dialogCg_.alpha = 1

				arg_444_1.dialog_:SetActive(true)
				SetActive(arg_444_1.leftNameGo_, true)

				local var_447_8 = arg_444_1:FormatText(StoryNameCfg[7].name)

				arg_444_1.leftNameTxt_.text = var_447_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_444_1.leftNameTxt_.transform)

				arg_444_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_444_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_444_1:RecordName(arg_444_1.leftNameTxt_.text)
				SetActive(arg_444_1.iconTrs_.gameObject, true)
				arg_444_1.iconController_:SetSelectedState("hero")

				arg_444_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_444_1.callingController_:SetSelectedState("normal")

				arg_444_1.keyicon_.color = Color.New(1, 1, 1)
				arg_444_1.icon_.color = Color.New(1, 1, 1)

				local var_447_9 = arg_444_1:GetWordFromCfg(1102205107)
				local var_447_10 = arg_444_1:FormatText(var_447_9.content)

				arg_444_1.text_.text = var_447_10

				LuaForUtil.ClearLinePrefixSymbol(arg_444_1.text_)

				local var_447_11 = 7
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
				arg_444_1:RecordContent(arg_444_1.text_.text)
			end

			local var_447_14 = math.max(var_447_7, arg_444_1.talkMaxDuration)

			if var_447_6 <= arg_444_1.time_ and arg_444_1.time_ < var_447_6 + var_447_14 then
				arg_444_1.typewritter.percent = (arg_444_1.time_ - var_447_6) / var_447_14

				arg_444_1.typewritter:SetDirty()
			end

			if arg_444_1.time_ >= var_447_6 + var_447_14 and arg_444_1.time_ < var_447_6 + var_447_14 + arg_447_0 then
				arg_444_1.typewritter.percent = 1

				arg_444_1.typewritter:SetDirty()
				arg_444_1:ShowNextGo(true)
			end
		end

		arg_444_1.nodeConfigList_ = {}

		arg_444_1:InitPlayNodeList()
	end,
	Play1102205108 = function(arg_448_0, arg_448_1)
		arg_448_1.time_ = 0
		arg_448_1.frameCnt_ = 0
		arg_448_1.state_ = "playing"
		arg_448_1.curTalkId_ = 1102205108
		arg_448_1.duration_ = 8.63

		SetActive(arg_448_1.tipsGo_, false)

		function arg_448_1.onSingleLineFinish_()
			arg_448_1.onSingleLineUpdate_ = nil
			arg_448_1.onSingleLineFinish_ = nil
			arg_448_1.state_ = "waiting"
		end

		function arg_448_1.playNext_(arg_450_0)
			if arg_450_0 == 1 then
				arg_448_0:Play1102205109(arg_448_1)
			end
		end

		function arg_448_1.onSingleLineUpdate_(arg_451_0)
			local var_451_0 = arg_448_1.actors_["1022ui_story"]
			local var_451_1 = 0

			if var_451_1 < arg_448_1.time_ and arg_448_1.time_ <= var_451_1 + arg_451_0 and not isNil(var_451_0) and arg_448_1.var_.characterEffect1022ui_story == nil then
				arg_448_1.var_.characterEffect1022ui_story = var_451_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_451_2 = 0.200000002980232

			if var_451_1 <= arg_448_1.time_ and arg_448_1.time_ < var_451_1 + var_451_2 and not isNil(var_451_0) then
				local var_451_3 = (arg_448_1.time_ - var_451_1) / var_451_2

				if arg_448_1.var_.characterEffect1022ui_story and not isNil(var_451_0) then
					arg_448_1.var_.characterEffect1022ui_story.fillFlat = false
				end
			end

			if arg_448_1.time_ >= var_451_1 + var_451_2 and arg_448_1.time_ < var_451_1 + var_451_2 + arg_451_0 and not isNil(var_451_0) and arg_448_1.var_.characterEffect1022ui_story then
				arg_448_1.var_.characterEffect1022ui_story.fillFlat = false
			end

			local var_451_4 = 0

			if var_451_4 < arg_448_1.time_ and arg_448_1.time_ <= var_451_4 + arg_451_0 then
				arg_448_1:PlayTimeline("1022ui_story", "StoryTimeline/CharAction/story1022/story1022action/1022action7_2")
			end

			local var_451_5 = 0

			if var_451_5 < arg_448_1.time_ and arg_448_1.time_ <= var_451_5 + arg_451_0 then
				arg_448_1:PlayTimeline("1022ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_451_6 = 0
			local var_451_7 = 0.95

			if var_451_6 < arg_448_1.time_ and arg_448_1.time_ <= var_451_6 + arg_451_0 then
				arg_448_1.talkMaxDuration = 0
				arg_448_1.dialogCg_.alpha = 1

				arg_448_1.dialog_:SetActive(true)
				SetActive(arg_448_1.leftNameGo_, true)

				local var_451_8 = arg_448_1:FormatText(StoryNameCfg[259].name)

				arg_448_1.leftNameTxt_.text = var_451_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_448_1.leftNameTxt_.transform)

				arg_448_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_448_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_448_1:RecordName(arg_448_1.leftNameTxt_.text)
				SetActive(arg_448_1.iconTrs_.gameObject, false)
				arg_448_1.callingController_:SetSelectedState("normal")

				local var_451_9 = arg_448_1:GetWordFromCfg(1102205108)
				local var_451_10 = arg_448_1:FormatText(var_451_9.content)

				arg_448_1.text_.text = var_451_10

				LuaForUtil.ClearLinePrefixSymbol(arg_448_1.text_)

				local var_451_11 = 38
				local var_451_12 = utf8.len(var_451_10)
				local var_451_13 = var_451_11 <= 0 and var_451_7 or var_451_7 * (var_451_12 / var_451_11)

				if var_451_13 > 0 and var_451_7 < var_451_13 then
					arg_448_1.talkMaxDuration = var_451_13

					if var_451_13 + var_451_6 > arg_448_1.duration_ then
						arg_448_1.duration_ = var_451_13 + var_451_6
					end
				end

				arg_448_1.text_.text = var_451_10
				arg_448_1.typewritter.percent = 0

				arg_448_1.typewritter:SetDirty()
				arg_448_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205108", "story_v_side_new_1102205.awb") ~= 0 then
					local var_451_14 = manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205108", "story_v_side_new_1102205.awb") / 1000

					if var_451_14 + var_451_6 > arg_448_1.duration_ then
						arg_448_1.duration_ = var_451_14 + var_451_6
					end

					if var_451_9.prefab_name ~= "" and arg_448_1.actors_[var_451_9.prefab_name] ~= nil then
						local var_451_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_448_1.actors_[var_451_9.prefab_name].transform, "story_v_side_new_1102205", "1102205108", "story_v_side_new_1102205.awb")

						arg_448_1:RecordAudio("1102205108", var_451_15)
						arg_448_1:RecordAudio("1102205108", var_451_15)
					else
						arg_448_1:AudioAction("play", "voice", "story_v_side_new_1102205", "1102205108", "story_v_side_new_1102205.awb")
					end

					arg_448_1:RecordHistoryTalkVoice("story_v_side_new_1102205", "1102205108", "story_v_side_new_1102205.awb")
				end

				arg_448_1:RecordContent(arg_448_1.text_.text)
			end

			local var_451_16 = math.max(var_451_7, arg_448_1.talkMaxDuration)

			if var_451_6 <= arg_448_1.time_ and arg_448_1.time_ < var_451_6 + var_451_16 then
				arg_448_1.typewritter.percent = (arg_448_1.time_ - var_451_6) / var_451_16

				arg_448_1.typewritter:SetDirty()
			end

			if arg_448_1.time_ >= var_451_6 + var_451_16 and arg_448_1.time_ < var_451_6 + var_451_16 + arg_451_0 then
				arg_448_1.typewritter.percent = 1

				arg_448_1.typewritter:SetDirty()
				arg_448_1:ShowNextGo(true)
			end
		end

		arg_448_1.nodeConfigList_ = {}

		arg_448_1:InitPlayNodeList()
	end,
	Play1102205109 = function(arg_452_0, arg_452_1)
		arg_452_1.time_ = 0
		arg_452_1.frameCnt_ = 0
		arg_452_1.state_ = "playing"
		arg_452_1.curTalkId_ = 1102205109
		arg_452_1.duration_ = 11.77

		SetActive(arg_452_1.tipsGo_, false)

		function arg_452_1.onSingleLineFinish_()
			arg_452_1.onSingleLineUpdate_ = nil
			arg_452_1.onSingleLineFinish_ = nil
			arg_452_1.state_ = "waiting"
		end

		function arg_452_1.playNext_(arg_454_0)
			if arg_454_0 == 1 then
				arg_452_0:Play1102205110(arg_452_1)
			end
		end

		function arg_452_1.onSingleLineUpdate_(arg_455_0)
			local var_455_0 = 0
			local var_455_1 = 1.225

			if var_455_0 < arg_452_1.time_ and arg_452_1.time_ <= var_455_0 + arg_455_0 then
				arg_452_1.talkMaxDuration = 0
				arg_452_1.dialogCg_.alpha = 1

				arg_452_1.dialog_:SetActive(true)
				SetActive(arg_452_1.leftNameGo_, true)

				local var_455_2 = arg_452_1:FormatText(StoryNameCfg[259].name)

				arg_452_1.leftNameTxt_.text = var_455_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_452_1.leftNameTxt_.transform)

				arg_452_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_452_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_452_1:RecordName(arg_452_1.leftNameTxt_.text)
				SetActive(arg_452_1.iconTrs_.gameObject, false)
				arg_452_1.callingController_:SetSelectedState("normal")

				local var_455_3 = arg_452_1:GetWordFromCfg(1102205109)
				local var_455_4 = arg_452_1:FormatText(var_455_3.content)

				arg_452_1.text_.text = var_455_4

				LuaForUtil.ClearLinePrefixSymbol(arg_452_1.text_)

				local var_455_5 = 49
				local var_455_6 = utf8.len(var_455_4)
				local var_455_7 = var_455_5 <= 0 and var_455_1 or var_455_1 * (var_455_6 / var_455_5)

				if var_455_7 > 0 and var_455_1 < var_455_7 then
					arg_452_1.talkMaxDuration = var_455_7

					if var_455_7 + var_455_0 > arg_452_1.duration_ then
						arg_452_1.duration_ = var_455_7 + var_455_0
					end
				end

				arg_452_1.text_.text = var_455_4
				arg_452_1.typewritter.percent = 0

				arg_452_1.typewritter:SetDirty()
				arg_452_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205109", "story_v_side_new_1102205.awb") ~= 0 then
					local var_455_8 = manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205109", "story_v_side_new_1102205.awb") / 1000

					if var_455_8 + var_455_0 > arg_452_1.duration_ then
						arg_452_1.duration_ = var_455_8 + var_455_0
					end

					if var_455_3.prefab_name ~= "" and arg_452_1.actors_[var_455_3.prefab_name] ~= nil then
						local var_455_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_452_1.actors_[var_455_3.prefab_name].transform, "story_v_side_new_1102205", "1102205109", "story_v_side_new_1102205.awb")

						arg_452_1:RecordAudio("1102205109", var_455_9)
						arg_452_1:RecordAudio("1102205109", var_455_9)
					else
						arg_452_1:AudioAction("play", "voice", "story_v_side_new_1102205", "1102205109", "story_v_side_new_1102205.awb")
					end

					arg_452_1:RecordHistoryTalkVoice("story_v_side_new_1102205", "1102205109", "story_v_side_new_1102205.awb")
				end

				arg_452_1:RecordContent(arg_452_1.text_.text)
			end

			local var_455_10 = math.max(var_455_1, arg_452_1.talkMaxDuration)

			if var_455_0 <= arg_452_1.time_ and arg_452_1.time_ < var_455_0 + var_455_10 then
				arg_452_1.typewritter.percent = (arg_452_1.time_ - var_455_0) / var_455_10

				arg_452_1.typewritter:SetDirty()
			end

			if arg_452_1.time_ >= var_455_0 + var_455_10 and arg_452_1.time_ < var_455_0 + var_455_10 + arg_455_0 then
				arg_452_1.typewritter.percent = 1

				arg_452_1.typewritter:SetDirty()
				arg_452_1:ShowNextGo(true)
			end
		end

		arg_452_1.nodeConfigList_ = {}

		arg_452_1:InitPlayNodeList()
	end,
	Play1102205110 = function(arg_456_0, arg_456_1)
		arg_456_1.time_ = 0
		arg_456_1.frameCnt_ = 0
		arg_456_1.state_ = "playing"
		arg_456_1.curTalkId_ = 1102205110
		arg_456_1.duration_ = 5

		SetActive(arg_456_1.tipsGo_, false)

		function arg_456_1.onSingleLineFinish_()
			arg_456_1.onSingleLineUpdate_ = nil
			arg_456_1.onSingleLineFinish_ = nil
			arg_456_1.state_ = "waiting"
		end

		function arg_456_1.playNext_(arg_458_0)
			if arg_458_0 == 1 then
				arg_456_0:Play1102205111(arg_456_1)
			end
		end

		function arg_456_1.onSingleLineUpdate_(arg_459_0)
			local var_459_0 = arg_456_1.actors_["1022ui_story"]
			local var_459_1 = 0

			if var_459_1 < arg_456_1.time_ and arg_456_1.time_ <= var_459_1 + arg_459_0 and not isNil(var_459_0) and arg_456_1.var_.characterEffect1022ui_story == nil then
				arg_456_1.var_.characterEffect1022ui_story = var_459_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_459_2 = 0.200000002980232

			if var_459_1 <= arg_456_1.time_ and arg_456_1.time_ < var_459_1 + var_459_2 and not isNil(var_459_0) then
				local var_459_3 = (arg_456_1.time_ - var_459_1) / var_459_2

				if arg_456_1.var_.characterEffect1022ui_story and not isNil(var_459_0) then
					local var_459_4 = Mathf.Lerp(0, 0.5, var_459_3)

					arg_456_1.var_.characterEffect1022ui_story.fillFlat = true
					arg_456_1.var_.characterEffect1022ui_story.fillRatio = var_459_4
				end
			end

			if arg_456_1.time_ >= var_459_1 + var_459_2 and arg_456_1.time_ < var_459_1 + var_459_2 + arg_459_0 and not isNil(var_459_0) and arg_456_1.var_.characterEffect1022ui_story then
				local var_459_5 = 0.5

				arg_456_1.var_.characterEffect1022ui_story.fillFlat = true
				arg_456_1.var_.characterEffect1022ui_story.fillRatio = var_459_5
			end

			local var_459_6 = 0
			local var_459_7 = 0.85

			if var_459_6 < arg_456_1.time_ and arg_456_1.time_ <= var_459_6 + arg_459_0 then
				arg_456_1.talkMaxDuration = 0
				arg_456_1.dialogCg_.alpha = 1

				arg_456_1.dialog_:SetActive(true)
				SetActive(arg_456_1.leftNameGo_, true)

				local var_459_8 = arg_456_1:FormatText(StoryNameCfg[7].name)

				arg_456_1.leftNameTxt_.text = var_459_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_456_1.leftNameTxt_.transform)

				arg_456_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_456_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_456_1:RecordName(arg_456_1.leftNameTxt_.text)
				SetActive(arg_456_1.iconTrs_.gameObject, true)
				arg_456_1.iconController_:SetSelectedState("hero")

				arg_456_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_456_1.callingController_:SetSelectedState("normal")

				arg_456_1.keyicon_.color = Color.New(1, 1, 1)
				arg_456_1.icon_.color = Color.New(1, 1, 1)

				local var_459_9 = arg_456_1:GetWordFromCfg(1102205110)
				local var_459_10 = arg_456_1:FormatText(var_459_9.content)

				arg_456_1.text_.text = var_459_10

				LuaForUtil.ClearLinePrefixSymbol(arg_456_1.text_)

				local var_459_11 = 34
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
				arg_456_1:RecordContent(arg_456_1.text_.text)
			end

			local var_459_14 = math.max(var_459_7, arg_456_1.talkMaxDuration)

			if var_459_6 <= arg_456_1.time_ and arg_456_1.time_ < var_459_6 + var_459_14 then
				arg_456_1.typewritter.percent = (arg_456_1.time_ - var_459_6) / var_459_14

				arg_456_1.typewritter:SetDirty()
			end

			if arg_456_1.time_ >= var_459_6 + var_459_14 and arg_456_1.time_ < var_459_6 + var_459_14 + arg_459_0 then
				arg_456_1.typewritter.percent = 1

				arg_456_1.typewritter:SetDirty()
				arg_456_1:ShowNextGo(true)
			end
		end

		arg_456_1.nodeConfigList_ = {}

		arg_456_1:InitPlayNodeList()
	end,
	Play1102205111 = function(arg_460_0, arg_460_1)
		arg_460_1.time_ = 0
		arg_460_1.frameCnt_ = 0
		arg_460_1.state_ = "playing"
		arg_460_1.curTalkId_ = 1102205111
		arg_460_1.duration_ = 5

		SetActive(arg_460_1.tipsGo_, false)

		function arg_460_1.onSingleLineFinish_()
			arg_460_1.onSingleLineUpdate_ = nil
			arg_460_1.onSingleLineFinish_ = nil
			arg_460_1.state_ = "waiting"
		end

		function arg_460_1.playNext_(arg_462_0)
			if arg_462_0 == 1 then
				arg_460_0:Play1102205112(arg_460_1)
			end
		end

		function arg_460_1.onSingleLineUpdate_(arg_463_0)
			local var_463_0 = 0
			local var_463_1 = 0.625

			if var_463_0 < arg_460_1.time_ and arg_460_1.time_ <= var_463_0 + arg_463_0 then
				arg_460_1.talkMaxDuration = 0
				arg_460_1.dialogCg_.alpha = 1

				arg_460_1.dialog_:SetActive(true)
				SetActive(arg_460_1.leftNameGo_, true)

				local var_463_2 = arg_460_1:FormatText(StoryNameCfg[7].name)

				arg_460_1.leftNameTxt_.text = var_463_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_460_1.leftNameTxt_.transform)

				arg_460_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_460_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_460_1:RecordName(arg_460_1.leftNameTxt_.text)
				SetActive(arg_460_1.iconTrs_.gameObject, true)
				arg_460_1.iconController_:SetSelectedState("hero")

				arg_460_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_460_1.callingController_:SetSelectedState("normal")

				arg_460_1.keyicon_.color = Color.New(1, 1, 1)
				arg_460_1.icon_.color = Color.New(1, 1, 1)

				local var_463_3 = arg_460_1:GetWordFromCfg(1102205111)
				local var_463_4 = arg_460_1:FormatText(var_463_3.content)

				arg_460_1.text_.text = var_463_4

				LuaForUtil.ClearLinePrefixSymbol(arg_460_1.text_)

				local var_463_5 = 25
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
				arg_460_1:RecordContent(arg_460_1.text_.text)
			end

			local var_463_8 = math.max(var_463_1, arg_460_1.talkMaxDuration)

			if var_463_0 <= arg_460_1.time_ and arg_460_1.time_ < var_463_0 + var_463_8 then
				arg_460_1.typewritter.percent = (arg_460_1.time_ - var_463_0) / var_463_8

				arg_460_1.typewritter:SetDirty()
			end

			if arg_460_1.time_ >= var_463_0 + var_463_8 and arg_460_1.time_ < var_463_0 + var_463_8 + arg_463_0 then
				arg_460_1.typewritter.percent = 1

				arg_460_1.typewritter:SetDirty()
				arg_460_1:ShowNextGo(true)
			end
		end

		arg_460_1.nodeConfigList_ = {}

		arg_460_1:InitPlayNodeList()
	end,
	Play1102205112 = function(arg_464_0, arg_464_1)
		arg_464_1.time_ = 0
		arg_464_1.frameCnt_ = 0
		arg_464_1.state_ = "playing"
		arg_464_1.curTalkId_ = 1102205112
		arg_464_1.duration_ = 5.53

		SetActive(arg_464_1.tipsGo_, false)

		function arg_464_1.onSingleLineFinish_()
			arg_464_1.onSingleLineUpdate_ = nil
			arg_464_1.onSingleLineFinish_ = nil
			arg_464_1.state_ = "waiting"
		end

		function arg_464_1.playNext_(arg_466_0)
			if arg_466_0 == 1 then
				arg_464_0:Play1102205113(arg_464_1)
			end
		end

		function arg_464_1.onSingleLineUpdate_(arg_467_0)
			local var_467_0 = arg_464_1.actors_["1022ui_story"]
			local var_467_1 = 0

			if var_467_1 < arg_464_1.time_ and arg_464_1.time_ <= var_467_1 + arg_467_0 and not isNil(var_467_0) and arg_464_1.var_.characterEffect1022ui_story == nil then
				arg_464_1.var_.characterEffect1022ui_story = var_467_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_467_2 = 0.200000002980232

			if var_467_1 <= arg_464_1.time_ and arg_464_1.time_ < var_467_1 + var_467_2 and not isNil(var_467_0) then
				local var_467_3 = (arg_464_1.time_ - var_467_1) / var_467_2

				if arg_464_1.var_.characterEffect1022ui_story and not isNil(var_467_0) then
					arg_464_1.var_.characterEffect1022ui_story.fillFlat = false
				end
			end

			if arg_464_1.time_ >= var_467_1 + var_467_2 and arg_464_1.time_ < var_467_1 + var_467_2 + arg_467_0 and not isNil(var_467_0) and arg_464_1.var_.characterEffect1022ui_story then
				arg_464_1.var_.characterEffect1022ui_story.fillFlat = false
			end

			local var_467_4 = 0

			if var_467_4 < arg_464_1.time_ and arg_464_1.time_ <= var_467_4 + arg_467_0 then
				arg_464_1:PlayTimeline("1022ui_story", "StoryTimeline/CharAction/story1022/story1022action/1022action2_1")
			end

			local var_467_5 = 0

			if var_467_5 < arg_464_1.time_ and arg_464_1.time_ <= var_467_5 + arg_467_0 then
				arg_464_1:PlayTimeline("1022ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_467_6 = 0
			local var_467_7 = 0.375

			if var_467_6 < arg_464_1.time_ and arg_464_1.time_ <= var_467_6 + arg_467_0 then
				arg_464_1.talkMaxDuration = 0
				arg_464_1.dialogCg_.alpha = 1

				arg_464_1.dialog_:SetActive(true)
				SetActive(arg_464_1.leftNameGo_, true)

				local var_467_8 = arg_464_1:FormatText(StoryNameCfg[259].name)

				arg_464_1.leftNameTxt_.text = var_467_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_464_1.leftNameTxt_.transform)

				arg_464_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_464_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_464_1:RecordName(arg_464_1.leftNameTxt_.text)
				SetActive(arg_464_1.iconTrs_.gameObject, false)
				arg_464_1.callingController_:SetSelectedState("normal")

				local var_467_9 = arg_464_1:GetWordFromCfg(1102205112)
				local var_467_10 = arg_464_1:FormatText(var_467_9.content)

				arg_464_1.text_.text = var_467_10

				LuaForUtil.ClearLinePrefixSymbol(arg_464_1.text_)

				local var_467_11 = 15
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

				if manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205112", "story_v_side_new_1102205.awb") ~= 0 then
					local var_467_14 = manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205112", "story_v_side_new_1102205.awb") / 1000

					if var_467_14 + var_467_6 > arg_464_1.duration_ then
						arg_464_1.duration_ = var_467_14 + var_467_6
					end

					if var_467_9.prefab_name ~= "" and arg_464_1.actors_[var_467_9.prefab_name] ~= nil then
						local var_467_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_464_1.actors_[var_467_9.prefab_name].transform, "story_v_side_new_1102205", "1102205112", "story_v_side_new_1102205.awb")

						arg_464_1:RecordAudio("1102205112", var_467_15)
						arg_464_1:RecordAudio("1102205112", var_467_15)
					else
						arg_464_1:AudioAction("play", "voice", "story_v_side_new_1102205", "1102205112", "story_v_side_new_1102205.awb")
					end

					arg_464_1:RecordHistoryTalkVoice("story_v_side_new_1102205", "1102205112", "story_v_side_new_1102205.awb")
				end

				arg_464_1:RecordContent(arg_464_1.text_.text)
			end

			local var_467_16 = math.max(var_467_7, arg_464_1.talkMaxDuration)

			if var_467_6 <= arg_464_1.time_ and arg_464_1.time_ < var_467_6 + var_467_16 then
				arg_464_1.typewritter.percent = (arg_464_1.time_ - var_467_6) / var_467_16

				arg_464_1.typewritter:SetDirty()
			end

			if arg_464_1.time_ >= var_467_6 + var_467_16 and arg_464_1.time_ < var_467_6 + var_467_16 + arg_467_0 then
				arg_464_1.typewritter.percent = 1

				arg_464_1.typewritter:SetDirty()
				arg_464_1:ShowNextGo(true)
			end
		end

		arg_464_1.nodeConfigList_ = {}

		arg_464_1:InitPlayNodeList()
	end,
	Play1102205113 = function(arg_468_0, arg_468_1)
		arg_468_1.time_ = 0
		arg_468_1.frameCnt_ = 0
		arg_468_1.state_ = "playing"
		arg_468_1.curTalkId_ = 1102205113
		arg_468_1.duration_ = 5

		SetActive(arg_468_1.tipsGo_, false)

		function arg_468_1.onSingleLineFinish_()
			arg_468_1.onSingleLineUpdate_ = nil
			arg_468_1.onSingleLineFinish_ = nil
			arg_468_1.state_ = "waiting"
		end

		function arg_468_1.playNext_(arg_470_0)
			if arg_470_0 == 1 then
				arg_468_0:Play1102205114(arg_468_1)
			end
		end

		function arg_468_1.onSingleLineUpdate_(arg_471_0)
			local var_471_0 = arg_468_1.actors_["1022ui_story"]
			local var_471_1 = 0

			if var_471_1 < arg_468_1.time_ and arg_468_1.time_ <= var_471_1 + arg_471_0 and not isNil(var_471_0) and arg_468_1.var_.characterEffect1022ui_story == nil then
				arg_468_1.var_.characterEffect1022ui_story = var_471_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_471_2 = 0.200000002980232

			if var_471_1 <= arg_468_1.time_ and arg_468_1.time_ < var_471_1 + var_471_2 and not isNil(var_471_0) then
				local var_471_3 = (arg_468_1.time_ - var_471_1) / var_471_2

				if arg_468_1.var_.characterEffect1022ui_story and not isNil(var_471_0) then
					local var_471_4 = Mathf.Lerp(0, 0.5, var_471_3)

					arg_468_1.var_.characterEffect1022ui_story.fillFlat = true
					arg_468_1.var_.characterEffect1022ui_story.fillRatio = var_471_4
				end
			end

			if arg_468_1.time_ >= var_471_1 + var_471_2 and arg_468_1.time_ < var_471_1 + var_471_2 + arg_471_0 and not isNil(var_471_0) and arg_468_1.var_.characterEffect1022ui_story then
				local var_471_5 = 0.5

				arg_468_1.var_.characterEffect1022ui_story.fillFlat = true
				arg_468_1.var_.characterEffect1022ui_story.fillRatio = var_471_5
			end

			local var_471_6 = 0
			local var_471_7 = 0.975

			if var_471_6 < arg_468_1.time_ and arg_468_1.time_ <= var_471_6 + arg_471_0 then
				arg_468_1.talkMaxDuration = 0
				arg_468_1.dialogCg_.alpha = 1

				arg_468_1.dialog_:SetActive(true)
				SetActive(arg_468_1.leftNameGo_, true)

				local var_471_8 = arg_468_1:FormatText(StoryNameCfg[7].name)

				arg_468_1.leftNameTxt_.text = var_471_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_468_1.leftNameTxt_.transform)

				arg_468_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_468_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_468_1:RecordName(arg_468_1.leftNameTxt_.text)
				SetActive(arg_468_1.iconTrs_.gameObject, true)
				arg_468_1.iconController_:SetSelectedState("hero")

				arg_468_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_468_1.callingController_:SetSelectedState("normal")

				arg_468_1.keyicon_.color = Color.New(1, 1, 1)
				arg_468_1.icon_.color = Color.New(1, 1, 1)

				local var_471_9 = arg_468_1:GetWordFromCfg(1102205113)
				local var_471_10 = arg_468_1:FormatText(var_471_9.content)

				arg_468_1.text_.text = var_471_10

				LuaForUtil.ClearLinePrefixSymbol(arg_468_1.text_)

				local var_471_11 = 39
				local var_471_12 = utf8.len(var_471_10)
				local var_471_13 = var_471_11 <= 0 and var_471_7 or var_471_7 * (var_471_12 / var_471_11)

				if var_471_13 > 0 and var_471_7 < var_471_13 then
					arg_468_1.talkMaxDuration = var_471_13

					if var_471_13 + var_471_6 > arg_468_1.duration_ then
						arg_468_1.duration_ = var_471_13 + var_471_6
					end
				end

				arg_468_1.text_.text = var_471_10
				arg_468_1.typewritter.percent = 0

				arg_468_1.typewritter:SetDirty()
				arg_468_1:ShowNextGo(false)
				arg_468_1:RecordContent(arg_468_1.text_.text)
			end

			local var_471_14 = math.max(var_471_7, arg_468_1.talkMaxDuration)

			if var_471_6 <= arg_468_1.time_ and arg_468_1.time_ < var_471_6 + var_471_14 then
				arg_468_1.typewritter.percent = (arg_468_1.time_ - var_471_6) / var_471_14

				arg_468_1.typewritter:SetDirty()
			end

			if arg_468_1.time_ >= var_471_6 + var_471_14 and arg_468_1.time_ < var_471_6 + var_471_14 + arg_471_0 then
				arg_468_1.typewritter.percent = 1

				arg_468_1.typewritter:SetDirty()
				arg_468_1:ShowNextGo(true)
			end
		end

		arg_468_1.nodeConfigList_ = {}

		arg_468_1:InitPlayNodeList()
	end,
	Play1102205114 = function(arg_472_0, arg_472_1)
		arg_472_1.time_ = 0
		arg_472_1.frameCnt_ = 0
		arg_472_1.state_ = "playing"
		arg_472_1.curTalkId_ = 1102205114
		arg_472_1.duration_ = 5.23

		SetActive(arg_472_1.tipsGo_, false)

		function arg_472_1.onSingleLineFinish_()
			arg_472_1.onSingleLineUpdate_ = nil
			arg_472_1.onSingleLineFinish_ = nil
			arg_472_1.state_ = "waiting"
		end

		function arg_472_1.playNext_(arg_474_0)
			if arg_474_0 == 1 then
				arg_472_0:Play1102205115(arg_472_1)
			end
		end

		function arg_472_1.onSingleLineUpdate_(arg_475_0)
			local var_475_0 = arg_472_1.actors_["1022ui_story"]
			local var_475_1 = 0

			if var_475_1 < arg_472_1.time_ and arg_472_1.time_ <= var_475_1 + arg_475_0 and not isNil(var_475_0) and arg_472_1.var_.characterEffect1022ui_story == nil then
				arg_472_1.var_.characterEffect1022ui_story = var_475_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_475_2 = 0.200000002980232

			if var_475_1 <= arg_472_1.time_ and arg_472_1.time_ < var_475_1 + var_475_2 and not isNil(var_475_0) then
				local var_475_3 = (arg_472_1.time_ - var_475_1) / var_475_2

				if arg_472_1.var_.characterEffect1022ui_story and not isNil(var_475_0) then
					arg_472_1.var_.characterEffect1022ui_story.fillFlat = false
				end
			end

			if arg_472_1.time_ >= var_475_1 + var_475_2 and arg_472_1.time_ < var_475_1 + var_475_2 + arg_475_0 and not isNil(var_475_0) and arg_472_1.var_.characterEffect1022ui_story then
				arg_472_1.var_.characterEffect1022ui_story.fillFlat = false
			end

			local var_475_4 = 0

			if var_475_4 < arg_472_1.time_ and arg_472_1.time_ <= var_475_4 + arg_475_0 then
				arg_472_1:PlayTimeline("1022ui_story", "StoryTimeline/CharAction/story1022/story1022action/1022action2_2")
			end

			local var_475_5 = 0

			if var_475_5 < arg_472_1.time_ and arg_472_1.time_ <= var_475_5 + arg_475_0 then
				arg_472_1:PlayTimeline("1022ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_475_6 = 0
			local var_475_7 = 0.45

			if var_475_6 < arg_472_1.time_ and arg_472_1.time_ <= var_475_6 + arg_475_0 then
				arg_472_1.talkMaxDuration = 0
				arg_472_1.dialogCg_.alpha = 1

				arg_472_1.dialog_:SetActive(true)
				SetActive(arg_472_1.leftNameGo_, true)

				local var_475_8 = arg_472_1:FormatText(StoryNameCfg[259].name)

				arg_472_1.leftNameTxt_.text = var_475_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_472_1.leftNameTxt_.transform)

				arg_472_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_472_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_472_1:RecordName(arg_472_1.leftNameTxt_.text)
				SetActive(arg_472_1.iconTrs_.gameObject, false)
				arg_472_1.callingController_:SetSelectedState("normal")

				local var_475_9 = arg_472_1:GetWordFromCfg(1102205114)
				local var_475_10 = arg_472_1:FormatText(var_475_9.content)

				arg_472_1.text_.text = var_475_10

				LuaForUtil.ClearLinePrefixSymbol(arg_472_1.text_)

				local var_475_11 = 18
				local var_475_12 = utf8.len(var_475_10)
				local var_475_13 = var_475_11 <= 0 and var_475_7 or var_475_7 * (var_475_12 / var_475_11)

				if var_475_13 > 0 and var_475_7 < var_475_13 then
					arg_472_1.talkMaxDuration = var_475_13

					if var_475_13 + var_475_6 > arg_472_1.duration_ then
						arg_472_1.duration_ = var_475_13 + var_475_6
					end
				end

				arg_472_1.text_.text = var_475_10
				arg_472_1.typewritter.percent = 0

				arg_472_1.typewritter:SetDirty()
				arg_472_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205114", "story_v_side_new_1102205.awb") ~= 0 then
					local var_475_14 = manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205114", "story_v_side_new_1102205.awb") / 1000

					if var_475_14 + var_475_6 > arg_472_1.duration_ then
						arg_472_1.duration_ = var_475_14 + var_475_6
					end

					if var_475_9.prefab_name ~= "" and arg_472_1.actors_[var_475_9.prefab_name] ~= nil then
						local var_475_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_472_1.actors_[var_475_9.prefab_name].transform, "story_v_side_new_1102205", "1102205114", "story_v_side_new_1102205.awb")

						arg_472_1:RecordAudio("1102205114", var_475_15)
						arg_472_1:RecordAudio("1102205114", var_475_15)
					else
						arg_472_1:AudioAction("play", "voice", "story_v_side_new_1102205", "1102205114", "story_v_side_new_1102205.awb")
					end

					arg_472_1:RecordHistoryTalkVoice("story_v_side_new_1102205", "1102205114", "story_v_side_new_1102205.awb")
				end

				arg_472_1:RecordContent(arg_472_1.text_.text)
			end

			local var_475_16 = math.max(var_475_7, arg_472_1.talkMaxDuration)

			if var_475_6 <= arg_472_1.time_ and arg_472_1.time_ < var_475_6 + var_475_16 then
				arg_472_1.typewritter.percent = (arg_472_1.time_ - var_475_6) / var_475_16

				arg_472_1.typewritter:SetDirty()
			end

			if arg_472_1.time_ >= var_475_6 + var_475_16 and arg_472_1.time_ < var_475_6 + var_475_16 + arg_475_0 then
				arg_472_1.typewritter.percent = 1

				arg_472_1.typewritter:SetDirty()
				arg_472_1:ShowNextGo(true)
			end
		end

		arg_472_1.nodeConfigList_ = {}

		arg_472_1:InitPlayNodeList()
	end,
	Play1102205115 = function(arg_476_0, arg_476_1)
		arg_476_1.time_ = 0
		arg_476_1.frameCnt_ = 0
		arg_476_1.state_ = "playing"
		arg_476_1.curTalkId_ = 1102205115
		arg_476_1.duration_ = 5

		SetActive(arg_476_1.tipsGo_, false)

		function arg_476_1.onSingleLineFinish_()
			arg_476_1.onSingleLineUpdate_ = nil
			arg_476_1.onSingleLineFinish_ = nil
			arg_476_1.state_ = "waiting"
		end

		function arg_476_1.playNext_(arg_478_0)
			if arg_478_0 == 1 then
				arg_476_0:Play1102205116(arg_476_1)
			end
		end

		function arg_476_1.onSingleLineUpdate_(arg_479_0)
			local var_479_0 = arg_476_1.actors_["1022ui_story"]
			local var_479_1 = 0

			if var_479_1 < arg_476_1.time_ and arg_476_1.time_ <= var_479_1 + arg_479_0 and not isNil(var_479_0) and arg_476_1.var_.characterEffect1022ui_story == nil then
				arg_476_1.var_.characterEffect1022ui_story = var_479_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_479_2 = 0.200000002980232

			if var_479_1 <= arg_476_1.time_ and arg_476_1.time_ < var_479_1 + var_479_2 and not isNil(var_479_0) then
				local var_479_3 = (arg_476_1.time_ - var_479_1) / var_479_2

				if arg_476_1.var_.characterEffect1022ui_story and not isNil(var_479_0) then
					local var_479_4 = Mathf.Lerp(0, 0.5, var_479_3)

					arg_476_1.var_.characterEffect1022ui_story.fillFlat = true
					arg_476_1.var_.characterEffect1022ui_story.fillRatio = var_479_4
				end
			end

			if arg_476_1.time_ >= var_479_1 + var_479_2 and arg_476_1.time_ < var_479_1 + var_479_2 + arg_479_0 and not isNil(var_479_0) and arg_476_1.var_.characterEffect1022ui_story then
				local var_479_5 = 0.5

				arg_476_1.var_.characterEffect1022ui_story.fillFlat = true
				arg_476_1.var_.characterEffect1022ui_story.fillRatio = var_479_5
			end

			local var_479_6 = 0
			local var_479_7 = 0.575

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

				arg_476_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_476_1.callingController_:SetSelectedState("normal")

				arg_476_1.keyicon_.color = Color.New(1, 1, 1)
				arg_476_1.icon_.color = Color.New(1, 1, 1)

				local var_479_9 = arg_476_1:GetWordFromCfg(1102205115)
				local var_479_10 = arg_476_1:FormatText(var_479_9.content)

				arg_476_1.text_.text = var_479_10

				LuaForUtil.ClearLinePrefixSymbol(arg_476_1.text_)

				local var_479_11 = 23
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
	Play1102205116 = function(arg_480_0, arg_480_1)
		arg_480_1.time_ = 0
		arg_480_1.frameCnt_ = 0
		arg_480_1.state_ = "playing"
		arg_480_1.curTalkId_ = 1102205116
		arg_480_1.duration_ = 5

		SetActive(arg_480_1.tipsGo_, false)

		function arg_480_1.onSingleLineFinish_()
			arg_480_1.onSingleLineUpdate_ = nil
			arg_480_1.onSingleLineFinish_ = nil
			arg_480_1.state_ = "waiting"
		end

		function arg_480_1.playNext_(arg_482_0)
			if arg_482_0 == 1 then
				arg_480_0:Play1102205117(arg_480_1)
			end
		end

		function arg_480_1.onSingleLineUpdate_(arg_483_0)
			local var_483_0 = arg_480_1.actors_["1022ui_story"].transform
			local var_483_1 = 0

			if var_483_1 < arg_480_1.time_ and arg_480_1.time_ <= var_483_1 + arg_483_0 then
				arg_480_1.var_.moveOldPos1022ui_story = var_483_0.localPosition
			end

			local var_483_2 = 0.001

			if var_483_1 <= arg_480_1.time_ and arg_480_1.time_ < var_483_1 + var_483_2 then
				local var_483_3 = (arg_480_1.time_ - var_483_1) / var_483_2
				local var_483_4 = Vector3.New(0, 100, 0)

				var_483_0.localPosition = Vector3.Lerp(arg_480_1.var_.moveOldPos1022ui_story, var_483_4, var_483_3)

				local var_483_5 = manager.ui.mainCamera.transform.position - var_483_0.position

				var_483_0.forward = Vector3.New(var_483_5.x, var_483_5.y, var_483_5.z)

				local var_483_6 = var_483_0.localEulerAngles

				var_483_6.z = 0
				var_483_6.x = 0
				var_483_0.localEulerAngles = var_483_6
			end

			if arg_480_1.time_ >= var_483_1 + var_483_2 and arg_480_1.time_ < var_483_1 + var_483_2 + arg_483_0 then
				var_483_0.localPosition = Vector3.New(0, 100, 0)

				local var_483_7 = manager.ui.mainCamera.transform.position - var_483_0.position

				var_483_0.forward = Vector3.New(var_483_7.x, var_483_7.y, var_483_7.z)

				local var_483_8 = var_483_0.localEulerAngles

				var_483_8.z = 0
				var_483_8.x = 0
				var_483_0.localEulerAngles = var_483_8
			end

			local var_483_9 = 0
			local var_483_10 = 0.525

			if var_483_9 < arg_480_1.time_ and arg_480_1.time_ <= var_483_9 + arg_483_0 then
				arg_480_1.talkMaxDuration = 0
				arg_480_1.dialogCg_.alpha = 1

				arg_480_1.dialog_:SetActive(true)
				SetActive(arg_480_1.leftNameGo_, false)

				arg_480_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_480_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_480_1:RecordName(arg_480_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_480_1.iconTrs_.gameObject, false)
				arg_480_1.callingController_:SetSelectedState("normal")

				local var_483_11 = arg_480_1:GetWordFromCfg(1102205116)
				local var_483_12 = arg_480_1:FormatText(var_483_11.content)

				arg_480_1.text_.text = var_483_12

				LuaForUtil.ClearLinePrefixSymbol(arg_480_1.text_)

				local var_483_13 = 21
				local var_483_14 = utf8.len(var_483_12)
				local var_483_15 = var_483_13 <= 0 and var_483_10 or var_483_10 * (var_483_14 / var_483_13)

				if var_483_15 > 0 and var_483_10 < var_483_15 then
					arg_480_1.talkMaxDuration = var_483_15

					if var_483_15 + var_483_9 > arg_480_1.duration_ then
						arg_480_1.duration_ = var_483_15 + var_483_9
					end
				end

				arg_480_1.text_.text = var_483_12
				arg_480_1.typewritter.percent = 0

				arg_480_1.typewritter:SetDirty()
				arg_480_1:ShowNextGo(false)
				arg_480_1:RecordContent(arg_480_1.text_.text)
			end

			local var_483_16 = math.max(var_483_10, arg_480_1.talkMaxDuration)

			if var_483_9 <= arg_480_1.time_ and arg_480_1.time_ < var_483_9 + var_483_16 then
				arg_480_1.typewritter.percent = (arg_480_1.time_ - var_483_9) / var_483_16

				arg_480_1.typewritter:SetDirty()
			end

			if arg_480_1.time_ >= var_483_9 + var_483_16 and arg_480_1.time_ < var_483_9 + var_483_16 + arg_483_0 then
				arg_480_1.typewritter.percent = 1

				arg_480_1.typewritter:SetDirty()
				arg_480_1:ShowNextGo(true)
			end
		end

		arg_480_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1022ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_480_1:InitPlayNodeList()
	end,
	Play1102205117 = function(arg_484_0, arg_484_1)
		arg_484_1.time_ = 0
		arg_484_1.frameCnt_ = 0
		arg_484_1.state_ = "playing"
		arg_484_1.curTalkId_ = 1102205117
		arg_484_1.duration_ = 3.3

		SetActive(arg_484_1.tipsGo_, false)

		function arg_484_1.onSingleLineFinish_()
			arg_484_1.onSingleLineUpdate_ = nil
			arg_484_1.onSingleLineFinish_ = nil
			arg_484_1.state_ = "waiting"
		end

		function arg_484_1.playNext_(arg_486_0)
			if arg_486_0 == 1 then
				arg_484_0:Play1102205118(arg_484_1)
			end
		end

		function arg_484_1.onSingleLineUpdate_(arg_487_0)
			local var_487_0 = arg_484_1.actors_["1022ui_story"]
			local var_487_1 = 0

			if var_487_1 < arg_484_1.time_ and arg_484_1.time_ <= var_487_1 + arg_487_0 and not isNil(var_487_0) and arg_484_1.var_.characterEffect1022ui_story == nil then
				arg_484_1.var_.characterEffect1022ui_story = var_487_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_487_2 = 0.200000002980232

			if var_487_1 <= arg_484_1.time_ and arg_484_1.time_ < var_487_1 + var_487_2 and not isNil(var_487_0) then
				local var_487_3 = (arg_484_1.time_ - var_487_1) / var_487_2

				if arg_484_1.var_.characterEffect1022ui_story and not isNil(var_487_0) then
					arg_484_1.var_.characterEffect1022ui_story.fillFlat = false
				end
			end

			if arg_484_1.time_ >= var_487_1 + var_487_2 and arg_484_1.time_ < var_487_1 + var_487_2 + arg_487_0 and not isNil(var_487_0) and arg_484_1.var_.characterEffect1022ui_story then
				arg_484_1.var_.characterEffect1022ui_story.fillFlat = false
			end

			local var_487_4 = 0

			if var_487_4 < arg_484_1.time_ and arg_484_1.time_ <= var_487_4 + arg_487_0 then
				arg_484_1:PlayTimeline("1022ui_story", "StoryTimeline/CharAction/story1022/story1022action/1022action5_1")
			end

			local var_487_5 = 0

			if var_487_5 < arg_484_1.time_ and arg_484_1.time_ <= var_487_5 + arg_487_0 then
				arg_484_1:PlayTimeline("1022ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_487_6 = arg_484_1.actors_["1022ui_story"].transform
			local var_487_7 = 0

			if var_487_7 < arg_484_1.time_ and arg_484_1.time_ <= var_487_7 + arg_487_0 then
				arg_484_1.var_.moveOldPos1022ui_story = var_487_6.localPosition
			end

			local var_487_8 = 0.001

			if var_487_7 <= arg_484_1.time_ and arg_484_1.time_ < var_487_7 + var_487_8 then
				local var_487_9 = (arg_484_1.time_ - var_487_7) / var_487_8
				local var_487_10 = Vector3.New(0, -1.08, -6)

				var_487_6.localPosition = Vector3.Lerp(arg_484_1.var_.moveOldPos1022ui_story, var_487_10, var_487_9)

				local var_487_11 = manager.ui.mainCamera.transform.position - var_487_6.position

				var_487_6.forward = Vector3.New(var_487_11.x, var_487_11.y, var_487_11.z)

				local var_487_12 = var_487_6.localEulerAngles

				var_487_12.z = 0
				var_487_12.x = 0
				var_487_6.localEulerAngles = var_487_12
			end

			if arg_484_1.time_ >= var_487_7 + var_487_8 and arg_484_1.time_ < var_487_7 + var_487_8 + arg_487_0 then
				var_487_6.localPosition = Vector3.New(0, -1.08, -6)

				local var_487_13 = manager.ui.mainCamera.transform.position - var_487_6.position

				var_487_6.forward = Vector3.New(var_487_13.x, var_487_13.y, var_487_13.z)

				local var_487_14 = var_487_6.localEulerAngles

				var_487_14.z = 0
				var_487_14.x = 0
				var_487_6.localEulerAngles = var_487_14
			end

			local var_487_15 = 0
			local var_487_16 = 0.325

			if var_487_15 < arg_484_1.time_ and arg_484_1.time_ <= var_487_15 + arg_487_0 then
				arg_484_1.talkMaxDuration = 0
				arg_484_1.dialogCg_.alpha = 1

				arg_484_1.dialog_:SetActive(true)
				SetActive(arg_484_1.leftNameGo_, true)

				local var_487_17 = arg_484_1:FormatText(StoryNameCfg[259].name)

				arg_484_1.leftNameTxt_.text = var_487_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_484_1.leftNameTxt_.transform)

				arg_484_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_484_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_484_1:RecordName(arg_484_1.leftNameTxt_.text)
				SetActive(arg_484_1.iconTrs_.gameObject, false)
				arg_484_1.callingController_:SetSelectedState("normal")

				local var_487_18 = arg_484_1:GetWordFromCfg(1102205117)
				local var_487_19 = arg_484_1:FormatText(var_487_18.content)

				arg_484_1.text_.text = var_487_19

				LuaForUtil.ClearLinePrefixSymbol(arg_484_1.text_)

				local var_487_20 = 13
				local var_487_21 = utf8.len(var_487_19)
				local var_487_22 = var_487_20 <= 0 and var_487_16 or var_487_16 * (var_487_21 / var_487_20)

				if var_487_22 > 0 and var_487_16 < var_487_22 then
					arg_484_1.talkMaxDuration = var_487_22

					if var_487_22 + var_487_15 > arg_484_1.duration_ then
						arg_484_1.duration_ = var_487_22 + var_487_15
					end
				end

				arg_484_1.text_.text = var_487_19
				arg_484_1.typewritter.percent = 0

				arg_484_1.typewritter:SetDirty()
				arg_484_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205117", "story_v_side_new_1102205.awb") ~= 0 then
					local var_487_23 = manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205117", "story_v_side_new_1102205.awb") / 1000

					if var_487_23 + var_487_15 > arg_484_1.duration_ then
						arg_484_1.duration_ = var_487_23 + var_487_15
					end

					if var_487_18.prefab_name ~= "" and arg_484_1.actors_[var_487_18.prefab_name] ~= nil then
						local var_487_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_484_1.actors_[var_487_18.prefab_name].transform, "story_v_side_new_1102205", "1102205117", "story_v_side_new_1102205.awb")

						arg_484_1:RecordAudio("1102205117", var_487_24)
						arg_484_1:RecordAudio("1102205117", var_487_24)
					else
						arg_484_1:AudioAction("play", "voice", "story_v_side_new_1102205", "1102205117", "story_v_side_new_1102205.awb")
					end

					arg_484_1:RecordHistoryTalkVoice("story_v_side_new_1102205", "1102205117", "story_v_side_new_1102205.awb")
				end

				arg_484_1:RecordContent(arg_484_1.text_.text)
			end

			local var_487_25 = math.max(var_487_16, arg_484_1.talkMaxDuration)

			if var_487_15 <= arg_484_1.time_ and arg_484_1.time_ < var_487_15 + var_487_25 then
				arg_484_1.typewritter.percent = (arg_484_1.time_ - var_487_15) / var_487_25

				arg_484_1.typewritter:SetDirty()
			end

			if arg_484_1.time_ >= var_487_15 + var_487_25 and arg_484_1.time_ < var_487_15 + var_487_25 + arg_487_0 then
				arg_484_1.typewritter.percent = 1

				arg_484_1.typewritter:SetDirty()
				arg_484_1:ShowNextGo(true)
			end
		end

		arg_484_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1022ui_story",
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
	Play1102205118 = function(arg_488_0, arg_488_1)
		arg_488_1.time_ = 0
		arg_488_1.frameCnt_ = 0
		arg_488_1.state_ = "playing"
		arg_488_1.curTalkId_ = 1102205118
		arg_488_1.duration_ = 5

		SetActive(arg_488_1.tipsGo_, false)

		function arg_488_1.onSingleLineFinish_()
			arg_488_1.onSingleLineUpdate_ = nil
			arg_488_1.onSingleLineFinish_ = nil
			arg_488_1.state_ = "waiting"
		end

		function arg_488_1.playNext_(arg_490_0)
			if arg_490_0 == 1 then
				arg_488_0:Play1102205119(arg_488_1)
			end
		end

		function arg_488_1.onSingleLineUpdate_(arg_491_0)
			local var_491_0 = arg_488_1.actors_["1022ui_story"].transform
			local var_491_1 = 0

			if var_491_1 < arg_488_1.time_ and arg_488_1.time_ <= var_491_1 + arg_491_0 then
				arg_488_1.var_.moveOldPos1022ui_story = var_491_0.localPosition
			end

			local var_491_2 = 0.001

			if var_491_1 <= arg_488_1.time_ and arg_488_1.time_ < var_491_1 + var_491_2 then
				local var_491_3 = (arg_488_1.time_ - var_491_1) / var_491_2
				local var_491_4 = Vector3.New(0, 100, 0)

				var_491_0.localPosition = Vector3.Lerp(arg_488_1.var_.moveOldPos1022ui_story, var_491_4, var_491_3)

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

			local var_491_9 = arg_488_1.actors_["1022ui_story"]
			local var_491_10 = 0

			if var_491_10 < arg_488_1.time_ and arg_488_1.time_ <= var_491_10 + arg_491_0 and not isNil(var_491_9) and arg_488_1.var_.characterEffect1022ui_story == nil then
				arg_488_1.var_.characterEffect1022ui_story = var_491_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_491_11 = 0.200000002980232

			if var_491_10 <= arg_488_1.time_ and arg_488_1.time_ < var_491_10 + var_491_11 and not isNil(var_491_9) then
				local var_491_12 = (arg_488_1.time_ - var_491_10) / var_491_11

				if arg_488_1.var_.characterEffect1022ui_story and not isNil(var_491_9) then
					local var_491_13 = Mathf.Lerp(0, 0.5, var_491_12)

					arg_488_1.var_.characterEffect1022ui_story.fillFlat = true
					arg_488_1.var_.characterEffect1022ui_story.fillRatio = var_491_13
				end
			end

			if arg_488_1.time_ >= var_491_10 + var_491_11 and arg_488_1.time_ < var_491_10 + var_491_11 + arg_491_0 and not isNil(var_491_9) and arg_488_1.var_.characterEffect1022ui_story then
				local var_491_14 = 0.5

				arg_488_1.var_.characterEffect1022ui_story.fillFlat = true
				arg_488_1.var_.characterEffect1022ui_story.fillRatio = var_491_14
			end

			local var_491_15 = 0
			local var_491_16 = 0.85

			if var_491_15 < arg_488_1.time_ and arg_488_1.time_ <= var_491_15 + arg_491_0 then
				arg_488_1.talkMaxDuration = 0
				arg_488_1.dialogCg_.alpha = 1

				arg_488_1.dialog_:SetActive(true)
				SetActive(arg_488_1.leftNameGo_, false)

				arg_488_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_488_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_488_1:RecordName(arg_488_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_488_1.iconTrs_.gameObject, false)
				arg_488_1.callingController_:SetSelectedState("normal")

				local var_491_17 = arg_488_1:GetWordFromCfg(1102205118)
				local var_491_18 = arg_488_1:FormatText(var_491_17.content)

				arg_488_1.text_.text = var_491_18

				LuaForUtil.ClearLinePrefixSymbol(arg_488_1.text_)

				local var_491_19 = 34
				local var_491_20 = utf8.len(var_491_18)
				local var_491_21 = var_491_19 <= 0 and var_491_16 or var_491_16 * (var_491_20 / var_491_19)

				if var_491_21 > 0 and var_491_16 < var_491_21 then
					arg_488_1.talkMaxDuration = var_491_21

					if var_491_21 + var_491_15 > arg_488_1.duration_ then
						arg_488_1.duration_ = var_491_21 + var_491_15
					end
				end

				arg_488_1.text_.text = var_491_18
				arg_488_1.typewritter.percent = 0

				arg_488_1.typewritter:SetDirty()
				arg_488_1:ShowNextGo(false)
				arg_488_1:RecordContent(arg_488_1.text_.text)
			end

			local var_491_22 = math.max(var_491_16, arg_488_1.talkMaxDuration)

			if var_491_15 <= arg_488_1.time_ and arg_488_1.time_ < var_491_15 + var_491_22 then
				arg_488_1.typewritter.percent = (arg_488_1.time_ - var_491_15) / var_491_22

				arg_488_1.typewritter:SetDirty()
			end

			if arg_488_1.time_ >= var_491_15 + var_491_22 and arg_488_1.time_ < var_491_15 + var_491_22 + arg_491_0 then
				arg_488_1.typewritter.percent = 1

				arg_488_1.typewritter:SetDirty()
				arg_488_1:ShowNextGo(true)
			end
		end

		arg_488_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1022ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_488_1:InitPlayNodeList()
	end,
	Play1102205119 = function(arg_492_0, arg_492_1)
		arg_492_1.time_ = 0
		arg_492_1.frameCnt_ = 0
		arg_492_1.state_ = "playing"
		arg_492_1.curTalkId_ = 1102205119
		arg_492_1.duration_ = 5

		SetActive(arg_492_1.tipsGo_, false)

		function arg_492_1.onSingleLineFinish_()
			arg_492_1.onSingleLineUpdate_ = nil
			arg_492_1.onSingleLineFinish_ = nil
			arg_492_1.state_ = "waiting"
		end

		function arg_492_1.playNext_(arg_494_0)
			if arg_494_0 == 1 then
				arg_492_0:Play1102205120(arg_492_1)
			end
		end

		function arg_492_1.onSingleLineUpdate_(arg_495_0)
			local var_495_0 = 0
			local var_495_1 = 0.325

			if var_495_0 < arg_492_1.time_ and arg_492_1.time_ <= var_495_0 + arg_495_0 then
				arg_492_1.talkMaxDuration = 0
				arg_492_1.dialogCg_.alpha = 1

				arg_492_1.dialog_:SetActive(true)
				SetActive(arg_492_1.leftNameGo_, true)

				local var_495_2 = arg_492_1:FormatText(StoryNameCfg[7].name)

				arg_492_1.leftNameTxt_.text = var_495_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_492_1.leftNameTxt_.transform)

				arg_492_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_492_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_492_1:RecordName(arg_492_1.leftNameTxt_.text)
				SetActive(arg_492_1.iconTrs_.gameObject, true)
				arg_492_1.iconController_:SetSelectedState("hero")

				arg_492_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_492_1.callingController_:SetSelectedState("normal")

				arg_492_1.keyicon_.color = Color.New(1, 1, 1)
				arg_492_1.icon_.color = Color.New(1, 1, 1)

				local var_495_3 = arg_492_1:GetWordFromCfg(1102205119)
				local var_495_4 = arg_492_1:FormatText(var_495_3.content)

				arg_492_1.text_.text = var_495_4

				LuaForUtil.ClearLinePrefixSymbol(arg_492_1.text_)

				local var_495_5 = 13
				local var_495_6 = utf8.len(var_495_4)
				local var_495_7 = var_495_5 <= 0 and var_495_1 or var_495_1 * (var_495_6 / var_495_5)

				if var_495_7 > 0 and var_495_1 < var_495_7 then
					arg_492_1.talkMaxDuration = var_495_7

					if var_495_7 + var_495_0 > arg_492_1.duration_ then
						arg_492_1.duration_ = var_495_7 + var_495_0
					end
				end

				arg_492_1.text_.text = var_495_4
				arg_492_1.typewritter.percent = 0

				arg_492_1.typewritter:SetDirty()
				arg_492_1:ShowNextGo(false)
				arg_492_1:RecordContent(arg_492_1.text_.text)
			end

			local var_495_8 = math.max(var_495_1, arg_492_1.talkMaxDuration)

			if var_495_0 <= arg_492_1.time_ and arg_492_1.time_ < var_495_0 + var_495_8 then
				arg_492_1.typewritter.percent = (arg_492_1.time_ - var_495_0) / var_495_8

				arg_492_1.typewritter:SetDirty()
			end

			if arg_492_1.time_ >= var_495_0 + var_495_8 and arg_492_1.time_ < var_495_0 + var_495_8 + arg_495_0 then
				arg_492_1.typewritter.percent = 1

				arg_492_1.typewritter:SetDirty()
				arg_492_1:ShowNextGo(true)
			end
		end

		arg_492_1.nodeConfigList_ = {}

		arg_492_1:InitPlayNodeList()
	end,
	Play1102205120 = function(arg_496_0, arg_496_1)
		arg_496_1.time_ = 0
		arg_496_1.frameCnt_ = 0
		arg_496_1.state_ = "playing"
		arg_496_1.curTalkId_ = 1102205120
		arg_496_1.duration_ = 9.73

		SetActive(arg_496_1.tipsGo_, false)

		function arg_496_1.onSingleLineFinish_()
			arg_496_1.onSingleLineUpdate_ = nil
			arg_496_1.onSingleLineFinish_ = nil
			arg_496_1.state_ = "waiting"
		end

		function arg_496_1.playNext_(arg_498_0)
			if arg_498_0 == 1 then
				arg_496_0:Play1102205121(arg_496_1)
			end
		end

		function arg_496_1.onSingleLineUpdate_(arg_499_0)
			local var_499_0 = arg_496_1.actors_["1022ui_story"].transform
			local var_499_1 = 0

			if var_499_1 < arg_496_1.time_ and arg_496_1.time_ <= var_499_1 + arg_499_0 then
				arg_496_1.var_.moveOldPos1022ui_story = var_499_0.localPosition
			end

			local var_499_2 = 0.001

			if var_499_1 <= arg_496_1.time_ and arg_496_1.time_ < var_499_1 + var_499_2 then
				local var_499_3 = (arg_496_1.time_ - var_499_1) / var_499_2
				local var_499_4 = Vector3.New(0, -1.08, -6)

				var_499_0.localPosition = Vector3.Lerp(arg_496_1.var_.moveOldPos1022ui_story, var_499_4, var_499_3)

				local var_499_5 = manager.ui.mainCamera.transform.position - var_499_0.position

				var_499_0.forward = Vector3.New(var_499_5.x, var_499_5.y, var_499_5.z)

				local var_499_6 = var_499_0.localEulerAngles

				var_499_6.z = 0
				var_499_6.x = 0
				var_499_0.localEulerAngles = var_499_6
			end

			if arg_496_1.time_ >= var_499_1 + var_499_2 and arg_496_1.time_ < var_499_1 + var_499_2 + arg_499_0 then
				var_499_0.localPosition = Vector3.New(0, -1.08, -6)

				local var_499_7 = manager.ui.mainCamera.transform.position - var_499_0.position

				var_499_0.forward = Vector3.New(var_499_7.x, var_499_7.y, var_499_7.z)

				local var_499_8 = var_499_0.localEulerAngles

				var_499_8.z = 0
				var_499_8.x = 0
				var_499_0.localEulerAngles = var_499_8
			end

			local var_499_9 = arg_496_1.actors_["1022ui_story"]
			local var_499_10 = 0

			if var_499_10 < arg_496_1.time_ and arg_496_1.time_ <= var_499_10 + arg_499_0 and not isNil(var_499_9) and arg_496_1.var_.characterEffect1022ui_story == nil then
				arg_496_1.var_.characterEffect1022ui_story = var_499_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_499_11 = 0.200000002980232

			if var_499_10 <= arg_496_1.time_ and arg_496_1.time_ < var_499_10 + var_499_11 and not isNil(var_499_9) then
				local var_499_12 = (arg_496_1.time_ - var_499_10) / var_499_11

				if arg_496_1.var_.characterEffect1022ui_story and not isNil(var_499_9) then
					arg_496_1.var_.characterEffect1022ui_story.fillFlat = false
				end
			end

			if arg_496_1.time_ >= var_499_10 + var_499_11 and arg_496_1.time_ < var_499_10 + var_499_11 + arg_499_0 and not isNil(var_499_9) and arg_496_1.var_.characterEffect1022ui_story then
				arg_496_1.var_.characterEffect1022ui_story.fillFlat = false
			end

			local var_499_13 = 0

			if var_499_13 < arg_496_1.time_ and arg_496_1.time_ <= var_499_13 + arg_499_0 then
				arg_496_1:PlayTimeline("1022ui_story", "StoryTimeline/CharAction/story1022/story1022action/1022action5_2")
			end

			local var_499_14 = 0

			if var_499_14 < arg_496_1.time_ and arg_496_1.time_ <= var_499_14 + arg_499_0 then
				arg_496_1:PlayTimeline("1022ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_499_15 = 0
			local var_499_16 = 1.075

			if var_499_15 < arg_496_1.time_ and arg_496_1.time_ <= var_499_15 + arg_499_0 then
				arg_496_1.talkMaxDuration = 0
				arg_496_1.dialogCg_.alpha = 1

				arg_496_1.dialog_:SetActive(true)
				SetActive(arg_496_1.leftNameGo_, true)

				local var_499_17 = arg_496_1:FormatText(StoryNameCfg[259].name)

				arg_496_1.leftNameTxt_.text = var_499_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_496_1.leftNameTxt_.transform)

				arg_496_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_496_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_496_1:RecordName(arg_496_1.leftNameTxt_.text)
				SetActive(arg_496_1.iconTrs_.gameObject, false)
				arg_496_1.callingController_:SetSelectedState("normal")

				local var_499_18 = arg_496_1:GetWordFromCfg(1102205120)
				local var_499_19 = arg_496_1:FormatText(var_499_18.content)

				arg_496_1.text_.text = var_499_19

				LuaForUtil.ClearLinePrefixSymbol(arg_496_1.text_)

				local var_499_20 = 43
				local var_499_21 = utf8.len(var_499_19)
				local var_499_22 = var_499_20 <= 0 and var_499_16 or var_499_16 * (var_499_21 / var_499_20)

				if var_499_22 > 0 and var_499_16 < var_499_22 then
					arg_496_1.talkMaxDuration = var_499_22

					if var_499_22 + var_499_15 > arg_496_1.duration_ then
						arg_496_1.duration_ = var_499_22 + var_499_15
					end
				end

				arg_496_1.text_.text = var_499_19
				arg_496_1.typewritter.percent = 0

				arg_496_1.typewritter:SetDirty()
				arg_496_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205120", "story_v_side_new_1102205.awb") ~= 0 then
					local var_499_23 = manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205120", "story_v_side_new_1102205.awb") / 1000

					if var_499_23 + var_499_15 > arg_496_1.duration_ then
						arg_496_1.duration_ = var_499_23 + var_499_15
					end

					if var_499_18.prefab_name ~= "" and arg_496_1.actors_[var_499_18.prefab_name] ~= nil then
						local var_499_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_496_1.actors_[var_499_18.prefab_name].transform, "story_v_side_new_1102205", "1102205120", "story_v_side_new_1102205.awb")

						arg_496_1:RecordAudio("1102205120", var_499_24)
						arg_496_1:RecordAudio("1102205120", var_499_24)
					else
						arg_496_1:AudioAction("play", "voice", "story_v_side_new_1102205", "1102205120", "story_v_side_new_1102205.awb")
					end

					arg_496_1:RecordHistoryTalkVoice("story_v_side_new_1102205", "1102205120", "story_v_side_new_1102205.awb")
				end

				arg_496_1:RecordContent(arg_496_1.text_.text)
			end

			local var_499_25 = math.max(var_499_16, arg_496_1.talkMaxDuration)

			if var_499_15 <= arg_496_1.time_ and arg_496_1.time_ < var_499_15 + var_499_25 then
				arg_496_1.typewritter.percent = (arg_496_1.time_ - var_499_15) / var_499_25

				arg_496_1.typewritter:SetDirty()
			end

			if arg_496_1.time_ >= var_499_15 + var_499_25 and arg_496_1.time_ < var_499_15 + var_499_25 + arg_499_0 then
				arg_496_1.typewritter.percent = 1

				arg_496_1.typewritter:SetDirty()
				arg_496_1:ShowNextGo(true)
			end
		end

		arg_496_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1022ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_496_1:InitPlayNodeList()
	end,
	Play1102205121 = function(arg_500_0, arg_500_1)
		arg_500_1.time_ = 0
		arg_500_1.frameCnt_ = 0
		arg_500_1.state_ = "playing"
		arg_500_1.curTalkId_ = 1102205121
		arg_500_1.duration_ = 1.57

		SetActive(arg_500_1.tipsGo_, false)

		function arg_500_1.onSingleLineFinish_()
			arg_500_1.onSingleLineUpdate_ = nil
			arg_500_1.onSingleLineFinish_ = nil
			arg_500_1.state_ = "waiting"
		end

		function arg_500_1.playNext_(arg_502_0)
			if arg_502_0 == 1 then
				arg_500_0:Play1102205122(arg_500_1)
			end
		end

		function arg_500_1.onSingleLineUpdate_(arg_503_0)
			local var_503_0 = 0
			local var_503_1 = 0.225

			if var_503_0 < arg_500_1.time_ and arg_500_1.time_ <= var_503_0 + arg_503_0 then
				arg_500_1.talkMaxDuration = 0
				arg_500_1.dialogCg_.alpha = 1

				arg_500_1.dialog_:SetActive(true)
				SetActive(arg_500_1.leftNameGo_, true)

				local var_503_2 = arg_500_1:FormatText(StoryNameCfg[259].name)

				arg_500_1.leftNameTxt_.text = var_503_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_500_1.leftNameTxt_.transform)

				arg_500_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_500_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_500_1:RecordName(arg_500_1.leftNameTxt_.text)
				SetActive(arg_500_1.iconTrs_.gameObject, false)
				arg_500_1.callingController_:SetSelectedState("normal")

				local var_503_3 = arg_500_1:GetWordFromCfg(1102205121)
				local var_503_4 = arg_500_1:FormatText(var_503_3.content)

				arg_500_1.text_.text = var_503_4

				LuaForUtil.ClearLinePrefixSymbol(arg_500_1.text_)

				local var_503_5 = 8
				local var_503_6 = utf8.len(var_503_4)
				local var_503_7 = var_503_5 <= 0 and var_503_1 or var_503_1 * (var_503_6 / var_503_5)

				if var_503_7 > 0 and var_503_1 < var_503_7 then
					arg_500_1.talkMaxDuration = var_503_7

					if var_503_7 + var_503_0 > arg_500_1.duration_ then
						arg_500_1.duration_ = var_503_7 + var_503_0
					end
				end

				arg_500_1.text_.text = var_503_4
				arg_500_1.typewritter.percent = 0

				arg_500_1.typewritter:SetDirty()
				arg_500_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205121", "story_v_side_new_1102205.awb") ~= 0 then
					local var_503_8 = manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205121", "story_v_side_new_1102205.awb") / 1000

					if var_503_8 + var_503_0 > arg_500_1.duration_ then
						arg_500_1.duration_ = var_503_8 + var_503_0
					end

					if var_503_3.prefab_name ~= "" and arg_500_1.actors_[var_503_3.prefab_name] ~= nil then
						local var_503_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_500_1.actors_[var_503_3.prefab_name].transform, "story_v_side_new_1102205", "1102205121", "story_v_side_new_1102205.awb")

						arg_500_1:RecordAudio("1102205121", var_503_9)
						arg_500_1:RecordAudio("1102205121", var_503_9)
					else
						arg_500_1:AudioAction("play", "voice", "story_v_side_new_1102205", "1102205121", "story_v_side_new_1102205.awb")
					end

					arg_500_1:RecordHistoryTalkVoice("story_v_side_new_1102205", "1102205121", "story_v_side_new_1102205.awb")
				end

				arg_500_1:RecordContent(arg_500_1.text_.text)
			end

			local var_503_10 = math.max(var_503_1, arg_500_1.talkMaxDuration)

			if var_503_0 <= arg_500_1.time_ and arg_500_1.time_ < var_503_0 + var_503_10 then
				arg_500_1.typewritter.percent = (arg_500_1.time_ - var_503_0) / var_503_10

				arg_500_1.typewritter:SetDirty()
			end

			if arg_500_1.time_ >= var_503_0 + var_503_10 and arg_500_1.time_ < var_503_0 + var_503_10 + arg_503_0 then
				arg_500_1.typewritter.percent = 1

				arg_500_1.typewritter:SetDirty()
				arg_500_1:ShowNextGo(true)
			end
		end

		arg_500_1.nodeConfigList_ = {}

		arg_500_1:InitPlayNodeList()
	end,
	Play1102205122 = function(arg_504_0, arg_504_1)
		arg_504_1.time_ = 0
		arg_504_1.frameCnt_ = 0
		arg_504_1.state_ = "playing"
		arg_504_1.curTalkId_ = 1102205122
		arg_504_1.duration_ = 5

		SetActive(arg_504_1.tipsGo_, false)

		function arg_504_1.onSingleLineFinish_()
			arg_504_1.onSingleLineUpdate_ = nil
			arg_504_1.onSingleLineFinish_ = nil
			arg_504_1.state_ = "waiting"
		end

		function arg_504_1.playNext_(arg_506_0)
			if arg_506_0 == 1 then
				arg_504_0:Play1102205123(arg_504_1)
			end
		end

		function arg_504_1.onSingleLineUpdate_(arg_507_0)
			local var_507_0 = arg_504_1.actors_["1022ui_story"]
			local var_507_1 = 0

			if var_507_1 < arg_504_1.time_ and arg_504_1.time_ <= var_507_1 + arg_507_0 and not isNil(var_507_0) and arg_504_1.var_.characterEffect1022ui_story == nil then
				arg_504_1.var_.characterEffect1022ui_story = var_507_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_507_2 = 0.200000002980232

			if var_507_1 <= arg_504_1.time_ and arg_504_1.time_ < var_507_1 + var_507_2 and not isNil(var_507_0) then
				local var_507_3 = (arg_504_1.time_ - var_507_1) / var_507_2

				if arg_504_1.var_.characterEffect1022ui_story and not isNil(var_507_0) then
					local var_507_4 = Mathf.Lerp(0, 0.5, var_507_3)

					arg_504_1.var_.characterEffect1022ui_story.fillFlat = true
					arg_504_1.var_.characterEffect1022ui_story.fillRatio = var_507_4
				end
			end

			if arg_504_1.time_ >= var_507_1 + var_507_2 and arg_504_1.time_ < var_507_1 + var_507_2 + arg_507_0 and not isNil(var_507_0) and arg_504_1.var_.characterEffect1022ui_story then
				local var_507_5 = 0.5

				arg_504_1.var_.characterEffect1022ui_story.fillFlat = true
				arg_504_1.var_.characterEffect1022ui_story.fillRatio = var_507_5
			end

			local var_507_6 = 0
			local var_507_7 = 1.275

			if var_507_6 < arg_504_1.time_ and arg_504_1.time_ <= var_507_6 + arg_507_0 then
				arg_504_1.talkMaxDuration = 0
				arg_504_1.dialogCg_.alpha = 1

				arg_504_1.dialog_:SetActive(true)
				SetActive(arg_504_1.leftNameGo_, false)

				arg_504_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_504_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_504_1:RecordName(arg_504_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_504_1.iconTrs_.gameObject, false)
				arg_504_1.callingController_:SetSelectedState("normal")

				local var_507_8 = arg_504_1:GetWordFromCfg(1102205122)
				local var_507_9 = arg_504_1:FormatText(var_507_8.content)

				arg_504_1.text_.text = var_507_9

				LuaForUtil.ClearLinePrefixSymbol(arg_504_1.text_)

				local var_507_10 = 51
				local var_507_11 = utf8.len(var_507_9)
				local var_507_12 = var_507_10 <= 0 and var_507_7 or var_507_7 * (var_507_11 / var_507_10)

				if var_507_12 > 0 and var_507_7 < var_507_12 then
					arg_504_1.talkMaxDuration = var_507_12

					if var_507_12 + var_507_6 > arg_504_1.duration_ then
						arg_504_1.duration_ = var_507_12 + var_507_6
					end
				end

				arg_504_1.text_.text = var_507_9
				arg_504_1.typewritter.percent = 0

				arg_504_1.typewritter:SetDirty()
				arg_504_1:ShowNextGo(false)
				arg_504_1:RecordContent(arg_504_1.text_.text)
			end

			local var_507_13 = math.max(var_507_7, arg_504_1.talkMaxDuration)

			if var_507_6 <= arg_504_1.time_ and arg_504_1.time_ < var_507_6 + var_507_13 then
				arg_504_1.typewritter.percent = (arg_504_1.time_ - var_507_6) / var_507_13

				arg_504_1.typewritter:SetDirty()
			end

			if arg_504_1.time_ >= var_507_6 + var_507_13 and arg_504_1.time_ < var_507_6 + var_507_13 + arg_507_0 then
				arg_504_1.typewritter.percent = 1

				arg_504_1.typewritter:SetDirty()
				arg_504_1:ShowNextGo(true)
			end
		end

		arg_504_1.nodeConfigList_ = {}

		arg_504_1:InitPlayNodeList()
	end,
	Play1102205123 = function(arg_508_0, arg_508_1)
		arg_508_1.time_ = 0
		arg_508_1.frameCnt_ = 0
		arg_508_1.state_ = "playing"
		arg_508_1.curTalkId_ = 1102205123
		arg_508_1.duration_ = 5

		SetActive(arg_508_1.tipsGo_, false)

		function arg_508_1.onSingleLineFinish_()
			arg_508_1.onSingleLineUpdate_ = nil
			arg_508_1.onSingleLineFinish_ = nil
			arg_508_1.state_ = "waiting"
		end

		function arg_508_1.playNext_(arg_510_0)
			if arg_510_0 == 1 then
				arg_508_0:Play1102205124(arg_508_1)
			end
		end

		function arg_508_1.onSingleLineUpdate_(arg_511_0)
			local var_511_0 = 0
			local var_511_1 = 0.575

			if var_511_0 < arg_508_1.time_ and arg_508_1.time_ <= var_511_0 + arg_511_0 then
				arg_508_1.talkMaxDuration = 0
				arg_508_1.dialogCg_.alpha = 1

				arg_508_1.dialog_:SetActive(true)
				SetActive(arg_508_1.leftNameGo_, true)

				local var_511_2 = arg_508_1:FormatText(StoryNameCfg[7].name)

				arg_508_1.leftNameTxt_.text = var_511_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_508_1.leftNameTxt_.transform)

				arg_508_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_508_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_508_1:RecordName(arg_508_1.leftNameTxt_.text)
				SetActive(arg_508_1.iconTrs_.gameObject, true)
				arg_508_1.iconController_:SetSelectedState("hero")

				arg_508_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_508_1.callingController_:SetSelectedState("normal")

				arg_508_1.keyicon_.color = Color.New(1, 1, 1)
				arg_508_1.icon_.color = Color.New(1, 1, 1)

				local var_511_3 = arg_508_1:GetWordFromCfg(1102205123)
				local var_511_4 = arg_508_1:FormatText(var_511_3.content)

				arg_508_1.text_.text = var_511_4

				LuaForUtil.ClearLinePrefixSymbol(arg_508_1.text_)

				local var_511_5 = 23
				local var_511_6 = utf8.len(var_511_4)
				local var_511_7 = var_511_5 <= 0 and var_511_1 or var_511_1 * (var_511_6 / var_511_5)

				if var_511_7 > 0 and var_511_1 < var_511_7 then
					arg_508_1.talkMaxDuration = var_511_7

					if var_511_7 + var_511_0 > arg_508_1.duration_ then
						arg_508_1.duration_ = var_511_7 + var_511_0
					end
				end

				arg_508_1.text_.text = var_511_4
				arg_508_1.typewritter.percent = 0

				arg_508_1.typewritter:SetDirty()
				arg_508_1:ShowNextGo(false)
				arg_508_1:RecordContent(arg_508_1.text_.text)
			end

			local var_511_8 = math.max(var_511_1, arg_508_1.talkMaxDuration)

			if var_511_0 <= arg_508_1.time_ and arg_508_1.time_ < var_511_0 + var_511_8 then
				arg_508_1.typewritter.percent = (arg_508_1.time_ - var_511_0) / var_511_8

				arg_508_1.typewritter:SetDirty()
			end

			if arg_508_1.time_ >= var_511_0 + var_511_8 and arg_508_1.time_ < var_511_0 + var_511_8 + arg_511_0 then
				arg_508_1.typewritter.percent = 1

				arg_508_1.typewritter:SetDirty()
				arg_508_1:ShowNextGo(true)
			end
		end

		arg_508_1.nodeConfigList_ = {}

		arg_508_1:InitPlayNodeList()
	end,
	Play1102205124 = function(arg_512_0, arg_512_1)
		arg_512_1.time_ = 0
		arg_512_1.frameCnt_ = 0
		arg_512_1.state_ = "playing"
		arg_512_1.curTalkId_ = 1102205124
		arg_512_1.duration_ = 4.73

		SetActive(arg_512_1.tipsGo_, false)

		function arg_512_1.onSingleLineFinish_()
			arg_512_1.onSingleLineUpdate_ = nil
			arg_512_1.onSingleLineFinish_ = nil
			arg_512_1.state_ = "waiting"
		end

		function arg_512_1.playNext_(arg_514_0)
			if arg_514_0 == 1 then
				arg_512_0:Play1102205125(arg_512_1)
			end
		end

		function arg_512_1.onSingleLineUpdate_(arg_515_0)
			local var_515_0 = arg_512_1.actors_["1022ui_story"]
			local var_515_1 = 0

			if var_515_1 < arg_512_1.time_ and arg_512_1.time_ <= var_515_1 + arg_515_0 and not isNil(var_515_0) and arg_512_1.var_.characterEffect1022ui_story == nil then
				arg_512_1.var_.characterEffect1022ui_story = var_515_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_515_2 = 0.200000002980232

			if var_515_1 <= arg_512_1.time_ and arg_512_1.time_ < var_515_1 + var_515_2 and not isNil(var_515_0) then
				local var_515_3 = (arg_512_1.time_ - var_515_1) / var_515_2

				if arg_512_1.var_.characterEffect1022ui_story and not isNil(var_515_0) then
					arg_512_1.var_.characterEffect1022ui_story.fillFlat = false
				end
			end

			if arg_512_1.time_ >= var_515_1 + var_515_2 and arg_512_1.time_ < var_515_1 + var_515_2 + arg_515_0 and not isNil(var_515_0) and arg_512_1.var_.characterEffect1022ui_story then
				arg_512_1.var_.characterEffect1022ui_story.fillFlat = false
			end

			local var_515_4 = 0

			if var_515_4 < arg_512_1.time_ and arg_512_1.time_ <= var_515_4 + arg_515_0 then
				arg_512_1:PlayTimeline("1022ui_story", "StoryTimeline/CharAction/story1022/story1022action/1022action6_1")
			end

			local var_515_5 = 0

			if var_515_5 < arg_512_1.time_ and arg_512_1.time_ <= var_515_5 + arg_515_0 then
				arg_512_1:PlayTimeline("1022ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_515_6 = 0
			local var_515_7 = 0.45

			if var_515_6 < arg_512_1.time_ and arg_512_1.time_ <= var_515_6 + arg_515_0 then
				arg_512_1.talkMaxDuration = 0
				arg_512_1.dialogCg_.alpha = 1

				arg_512_1.dialog_:SetActive(true)
				SetActive(arg_512_1.leftNameGo_, true)

				local var_515_8 = arg_512_1:FormatText(StoryNameCfg[259].name)

				arg_512_1.leftNameTxt_.text = var_515_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_512_1.leftNameTxt_.transform)

				arg_512_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_512_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_512_1:RecordName(arg_512_1.leftNameTxt_.text)
				SetActive(arg_512_1.iconTrs_.gameObject, false)
				arg_512_1.callingController_:SetSelectedState("normal")

				local var_515_9 = arg_512_1:GetWordFromCfg(1102205124)
				local var_515_10 = arg_512_1:FormatText(var_515_9.content)

				arg_512_1.text_.text = var_515_10

				LuaForUtil.ClearLinePrefixSymbol(arg_512_1.text_)

				local var_515_11 = 18
				local var_515_12 = utf8.len(var_515_10)
				local var_515_13 = var_515_11 <= 0 and var_515_7 or var_515_7 * (var_515_12 / var_515_11)

				if var_515_13 > 0 and var_515_7 < var_515_13 then
					arg_512_1.talkMaxDuration = var_515_13

					if var_515_13 + var_515_6 > arg_512_1.duration_ then
						arg_512_1.duration_ = var_515_13 + var_515_6
					end
				end

				arg_512_1.text_.text = var_515_10
				arg_512_1.typewritter.percent = 0

				arg_512_1.typewritter:SetDirty()
				arg_512_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205124", "story_v_side_new_1102205.awb") ~= 0 then
					local var_515_14 = manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205124", "story_v_side_new_1102205.awb") / 1000

					if var_515_14 + var_515_6 > arg_512_1.duration_ then
						arg_512_1.duration_ = var_515_14 + var_515_6
					end

					if var_515_9.prefab_name ~= "" and arg_512_1.actors_[var_515_9.prefab_name] ~= nil then
						local var_515_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_512_1.actors_[var_515_9.prefab_name].transform, "story_v_side_new_1102205", "1102205124", "story_v_side_new_1102205.awb")

						arg_512_1:RecordAudio("1102205124", var_515_15)
						arg_512_1:RecordAudio("1102205124", var_515_15)
					else
						arg_512_1:AudioAction("play", "voice", "story_v_side_new_1102205", "1102205124", "story_v_side_new_1102205.awb")
					end

					arg_512_1:RecordHistoryTalkVoice("story_v_side_new_1102205", "1102205124", "story_v_side_new_1102205.awb")
				end

				arg_512_1:RecordContent(arg_512_1.text_.text)
			end

			local var_515_16 = math.max(var_515_7, arg_512_1.talkMaxDuration)

			if var_515_6 <= arg_512_1.time_ and arg_512_1.time_ < var_515_6 + var_515_16 then
				arg_512_1.typewritter.percent = (arg_512_1.time_ - var_515_6) / var_515_16

				arg_512_1.typewritter:SetDirty()
			end

			if arg_512_1.time_ >= var_515_6 + var_515_16 and arg_512_1.time_ < var_515_6 + var_515_16 + arg_515_0 then
				arg_512_1.typewritter.percent = 1

				arg_512_1.typewritter:SetDirty()
				arg_512_1:ShowNextGo(true)
			end
		end

		arg_512_1.nodeConfigList_ = {}

		arg_512_1:InitPlayNodeList()
	end,
	Play1102205125 = function(arg_516_0, arg_516_1)
		arg_516_1.time_ = 0
		arg_516_1.frameCnt_ = 0
		arg_516_1.state_ = "playing"
		arg_516_1.curTalkId_ = 1102205125
		arg_516_1.duration_ = 5

		SetActive(arg_516_1.tipsGo_, false)

		function arg_516_1.onSingleLineFinish_()
			arg_516_1.onSingleLineUpdate_ = nil
			arg_516_1.onSingleLineFinish_ = nil
			arg_516_1.state_ = "waiting"
		end

		function arg_516_1.playNext_(arg_518_0)
			if arg_518_0 == 1 then
				arg_516_0:Play1102205126(arg_516_1)
			end
		end

		function arg_516_1.onSingleLineUpdate_(arg_519_0)
			local var_519_0 = arg_516_1.actors_["1022ui_story"]
			local var_519_1 = 0

			if var_519_1 < arg_516_1.time_ and arg_516_1.time_ <= var_519_1 + arg_519_0 and not isNil(var_519_0) and arg_516_1.var_.characterEffect1022ui_story == nil then
				arg_516_1.var_.characterEffect1022ui_story = var_519_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_519_2 = 0.200000002980232

			if var_519_1 <= arg_516_1.time_ and arg_516_1.time_ < var_519_1 + var_519_2 and not isNil(var_519_0) then
				local var_519_3 = (arg_516_1.time_ - var_519_1) / var_519_2

				if arg_516_1.var_.characterEffect1022ui_story and not isNil(var_519_0) then
					local var_519_4 = Mathf.Lerp(0, 0.5, var_519_3)

					arg_516_1.var_.characterEffect1022ui_story.fillFlat = true
					arg_516_1.var_.characterEffect1022ui_story.fillRatio = var_519_4
				end
			end

			if arg_516_1.time_ >= var_519_1 + var_519_2 and arg_516_1.time_ < var_519_1 + var_519_2 + arg_519_0 and not isNil(var_519_0) and arg_516_1.var_.characterEffect1022ui_story then
				local var_519_5 = 0.5

				arg_516_1.var_.characterEffect1022ui_story.fillFlat = true
				arg_516_1.var_.characterEffect1022ui_story.fillRatio = var_519_5
			end

			local var_519_6 = 0
			local var_519_7 = 0.475

			if var_519_6 < arg_516_1.time_ and arg_516_1.time_ <= var_519_6 + arg_519_0 then
				arg_516_1.talkMaxDuration = 0
				arg_516_1.dialogCg_.alpha = 1

				arg_516_1.dialog_:SetActive(true)
				SetActive(arg_516_1.leftNameGo_, true)

				local var_519_8 = arg_516_1:FormatText(StoryNameCfg[7].name)

				arg_516_1.leftNameTxt_.text = var_519_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_516_1.leftNameTxt_.transform)

				arg_516_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_516_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_516_1:RecordName(arg_516_1.leftNameTxt_.text)
				SetActive(arg_516_1.iconTrs_.gameObject, true)
				arg_516_1.iconController_:SetSelectedState("hero")

				arg_516_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_516_1.callingController_:SetSelectedState("normal")

				arg_516_1.keyicon_.color = Color.New(1, 1, 1)
				arg_516_1.icon_.color = Color.New(1, 1, 1)

				local var_519_9 = arg_516_1:GetWordFromCfg(1102205125)
				local var_519_10 = arg_516_1:FormatText(var_519_9.content)

				arg_516_1.text_.text = var_519_10

				LuaForUtil.ClearLinePrefixSymbol(arg_516_1.text_)

				local var_519_11 = 19
				local var_519_12 = utf8.len(var_519_10)
				local var_519_13 = var_519_11 <= 0 and var_519_7 or var_519_7 * (var_519_12 / var_519_11)

				if var_519_13 > 0 and var_519_7 < var_519_13 then
					arg_516_1.talkMaxDuration = var_519_13

					if var_519_13 + var_519_6 > arg_516_1.duration_ then
						arg_516_1.duration_ = var_519_13 + var_519_6
					end
				end

				arg_516_1.text_.text = var_519_10
				arg_516_1.typewritter.percent = 0

				arg_516_1.typewritter:SetDirty()
				arg_516_1:ShowNextGo(false)
				arg_516_1:RecordContent(arg_516_1.text_.text)
			end

			local var_519_14 = math.max(var_519_7, arg_516_1.talkMaxDuration)

			if var_519_6 <= arg_516_1.time_ and arg_516_1.time_ < var_519_6 + var_519_14 then
				arg_516_1.typewritter.percent = (arg_516_1.time_ - var_519_6) / var_519_14

				arg_516_1.typewritter:SetDirty()
			end

			if arg_516_1.time_ >= var_519_6 + var_519_14 and arg_516_1.time_ < var_519_6 + var_519_14 + arg_519_0 then
				arg_516_1.typewritter.percent = 1

				arg_516_1.typewritter:SetDirty()
				arg_516_1:ShowNextGo(true)
			end
		end

		arg_516_1.nodeConfigList_ = {}

		arg_516_1:InitPlayNodeList()
	end,
	Play1102205126 = function(arg_520_0, arg_520_1)
		arg_520_1.time_ = 0
		arg_520_1.frameCnt_ = 0
		arg_520_1.state_ = "playing"
		arg_520_1.curTalkId_ = 1102205126
		arg_520_1.duration_ = 8.7

		SetActive(arg_520_1.tipsGo_, false)

		function arg_520_1.onSingleLineFinish_()
			arg_520_1.onSingleLineUpdate_ = nil
			arg_520_1.onSingleLineFinish_ = nil
			arg_520_1.state_ = "waiting"
		end

		function arg_520_1.playNext_(arg_522_0)
			if arg_522_0 == 1 then
				arg_520_0:Play1102205127(arg_520_1)
			end
		end

		function arg_520_1.onSingleLineUpdate_(arg_523_0)
			local var_523_0 = 2

			if var_523_0 < arg_520_1.time_ and arg_520_1.time_ <= var_523_0 + arg_523_0 then
				local var_523_1 = manager.ui.mainCamera.transform.localPosition
				local var_523_2 = Vector3.New(0, 0, 10) + Vector3.New(var_523_1.x, var_523_1.y, 0)
				local var_523_3 = arg_520_1.bgs_.F08l

				var_523_3.transform.localPosition = var_523_2
				var_523_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_523_4 = var_523_3:GetComponent("SpriteRenderer")

				if var_523_4 and var_523_4.sprite then
					local var_523_5 = (var_523_3.transform.localPosition - var_523_1).z
					local var_523_6 = manager.ui.mainCameraCom_
					local var_523_7 = 2 * var_523_5 * Mathf.Tan(var_523_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_523_8 = var_523_7 * var_523_6.aspect
					local var_523_9 = var_523_4.sprite.bounds.size.x
					local var_523_10 = var_523_4.sprite.bounds.size.y
					local var_523_11 = var_523_8 / var_523_9
					local var_523_12 = var_523_7 / var_523_10
					local var_523_13 = var_523_12 < var_523_11 and var_523_11 or var_523_12

					var_523_3.transform.localScale = Vector3.New(var_523_13, var_523_13, 0)
				end

				for iter_523_0, iter_523_1 in pairs(arg_520_1.bgs_) do
					if iter_523_0 ~= "F08l" then
						iter_523_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_523_14 = 0

			if var_523_14 < arg_520_1.time_ and arg_520_1.time_ <= var_523_14 + arg_523_0 then
				arg_520_1.allBtn_.enabled = false
			end

			local var_523_15 = 0.3

			if arg_520_1.time_ >= var_523_14 + var_523_15 and arg_520_1.time_ < var_523_14 + var_523_15 + arg_523_0 then
				arg_520_1.allBtn_.enabled = true
			end

			local var_523_16 = 0

			if var_523_16 < arg_520_1.time_ and arg_520_1.time_ <= var_523_16 + arg_523_0 then
				arg_520_1.mask_.enabled = true
				arg_520_1.mask_.raycastTarget = true

				arg_520_1:SetGaussion(false)
			end

			local var_523_17 = 2

			if var_523_16 <= arg_520_1.time_ and arg_520_1.time_ < var_523_16 + var_523_17 then
				local var_523_18 = (arg_520_1.time_ - var_523_16) / var_523_17
				local var_523_19 = Color.New(0, 0, 0)

				var_523_19.a = Mathf.Lerp(0, 1, var_523_18)
				arg_520_1.mask_.color = var_523_19
			end

			if arg_520_1.time_ >= var_523_16 + var_523_17 and arg_520_1.time_ < var_523_16 + var_523_17 + arg_523_0 then
				local var_523_20 = Color.New(0, 0, 0)

				var_523_20.a = 1
				arg_520_1.mask_.color = var_523_20
			end

			local var_523_21 = 2

			if var_523_21 < arg_520_1.time_ and arg_520_1.time_ <= var_523_21 + arg_523_0 then
				arg_520_1.mask_.enabled = true
				arg_520_1.mask_.raycastTarget = true

				arg_520_1:SetGaussion(false)
			end

			local var_523_22 = 2

			if var_523_21 <= arg_520_1.time_ and arg_520_1.time_ < var_523_21 + var_523_22 then
				local var_523_23 = (arg_520_1.time_ - var_523_21) / var_523_22
				local var_523_24 = Color.New(0, 0, 0)

				var_523_24.a = Mathf.Lerp(1, 0, var_523_23)
				arg_520_1.mask_.color = var_523_24
			end

			if arg_520_1.time_ >= var_523_21 + var_523_22 and arg_520_1.time_ < var_523_21 + var_523_22 + arg_523_0 then
				local var_523_25 = Color.New(0, 0, 0)
				local var_523_26 = 0

				arg_520_1.mask_.enabled = false
				var_523_25.a = var_523_26
				arg_520_1.mask_.color = var_523_25
			end

			local var_523_27 = arg_520_1.actors_["1022ui_story"].transform
			local var_523_28 = 2

			if var_523_28 < arg_520_1.time_ and arg_520_1.time_ <= var_523_28 + arg_523_0 then
				arg_520_1.var_.moveOldPos1022ui_story = var_523_27.localPosition
			end

			local var_523_29 = 0.001

			if var_523_28 <= arg_520_1.time_ and arg_520_1.time_ < var_523_28 + var_523_29 then
				local var_523_30 = (arg_520_1.time_ - var_523_28) / var_523_29
				local var_523_31 = Vector3.New(0, 100, 0)

				var_523_27.localPosition = Vector3.Lerp(arg_520_1.var_.moveOldPos1022ui_story, var_523_31, var_523_30)

				local var_523_32 = manager.ui.mainCamera.transform.position - var_523_27.position

				var_523_27.forward = Vector3.New(var_523_32.x, var_523_32.y, var_523_32.z)

				local var_523_33 = var_523_27.localEulerAngles

				var_523_33.z = 0
				var_523_33.x = 0
				var_523_27.localEulerAngles = var_523_33
			end

			if arg_520_1.time_ >= var_523_28 + var_523_29 and arg_520_1.time_ < var_523_28 + var_523_29 + arg_523_0 then
				var_523_27.localPosition = Vector3.New(0, 100, 0)

				local var_523_34 = manager.ui.mainCamera.transform.position - var_523_27.position

				var_523_27.forward = Vector3.New(var_523_34.x, var_523_34.y, var_523_34.z)

				local var_523_35 = var_523_27.localEulerAngles

				var_523_35.z = 0
				var_523_35.x = 0
				var_523_27.localEulerAngles = var_523_35
			end

			local var_523_36 = 3.7
			local var_523_37 = 1

			if var_523_36 < arg_520_1.time_ and arg_520_1.time_ <= var_523_36 + arg_523_0 then
				local var_523_38 = "play"
				local var_523_39 = "effect"

				arg_520_1:AudioAction(var_523_38, var_523_39, "se_story_side_1022", "se_story_side_1022_walk", "")
			end

			if arg_520_1.frameCnt_ <= 1 then
				arg_520_1.dialog_:SetActive(false)
			end

			local var_523_40 = 3.7
			local var_523_41 = 1.075

			if var_523_40 < arg_520_1.time_ and arg_520_1.time_ <= var_523_40 + arg_523_0 then
				arg_520_1.talkMaxDuration = 0

				arg_520_1.dialog_:SetActive(true)

				arg_520_1.dialogCg_.alpha = 0

				local var_523_42 = LeanTween.value(arg_520_1.dialog_, 0, 1, 0.3)

				var_523_42:setOnUpdate(LuaHelper.FloatAction(function(arg_524_0)
					arg_520_1.dialogCg_.alpha = arg_524_0
				end))
				var_523_42:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_520_1.dialog_)
					var_523_42:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_520_1.duration_ = arg_520_1.duration_ + 0.3

				SetActive(arg_520_1.leftNameGo_, false)

				arg_520_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_520_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_520_1:RecordName(arg_520_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_520_1.iconTrs_.gameObject, false)
				arg_520_1.callingController_:SetSelectedState("normal")

				local var_523_43 = arg_520_1:GetWordFromCfg(1102205126)
				local var_523_44 = arg_520_1:FormatText(var_523_43.content)

				arg_520_1.text_.text = var_523_44

				LuaForUtil.ClearLinePrefixSymbol(arg_520_1.text_)

				local var_523_45 = 43
				local var_523_46 = utf8.len(var_523_44)
				local var_523_47 = var_523_45 <= 0 and var_523_41 or var_523_41 * (var_523_46 / var_523_45)

				if var_523_47 > 0 and var_523_41 < var_523_47 then
					arg_520_1.talkMaxDuration = var_523_47
					var_523_40 = var_523_40 + 0.3

					if var_523_47 + var_523_40 > arg_520_1.duration_ then
						arg_520_1.duration_ = var_523_47 + var_523_40
					end
				end

				arg_520_1.text_.text = var_523_44
				arg_520_1.typewritter.percent = 0

				arg_520_1.typewritter:SetDirty()
				arg_520_1:ShowNextGo(false)
				arg_520_1:RecordContent(arg_520_1.text_.text)
			end

			local var_523_48 = var_523_40 + 0.3
			local var_523_49 = math.max(var_523_41, arg_520_1.talkMaxDuration)

			if var_523_48 <= arg_520_1.time_ and arg_520_1.time_ < var_523_48 + var_523_49 then
				arg_520_1.typewritter.percent = (arg_520_1.time_ - var_523_48) / var_523_49

				arg_520_1.typewritter:SetDirty()
			end

			if arg_520_1.time_ >= var_523_48 + var_523_49 and arg_520_1.time_ < var_523_48 + var_523_49 + arg_523_0 then
				arg_520_1.typewritter.percent = 1

				arg_520_1.typewritter:SetDirty()
				arg_520_1:ShowNextGo(true)
			end
		end

		arg_520_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1022ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_520_1:InitPlayNodeList()
	end,
	Play1102205127 = function(arg_526_0, arg_526_1)
		arg_526_1.time_ = 0
		arg_526_1.frameCnt_ = 0
		arg_526_1.state_ = "playing"
		arg_526_1.curTalkId_ = 1102205127
		arg_526_1.duration_ = 5

		SetActive(arg_526_1.tipsGo_, false)

		function arg_526_1.onSingleLineFinish_()
			arg_526_1.onSingleLineUpdate_ = nil
			arg_526_1.onSingleLineFinish_ = nil
			arg_526_1.state_ = "waiting"
		end

		function arg_526_1.playNext_(arg_528_0)
			if arg_528_0 == 1 then
				arg_526_0:Play1102205128(arg_526_1)
			end
		end

		function arg_526_1.onSingleLineUpdate_(arg_529_0)
			local var_529_0 = 0
			local var_529_1 = 0.475

			if var_529_0 < arg_526_1.time_ and arg_526_1.time_ <= var_529_0 + arg_529_0 then
				arg_526_1.talkMaxDuration = 0
				arg_526_1.dialogCg_.alpha = 1

				arg_526_1.dialog_:SetActive(true)
				SetActive(arg_526_1.leftNameGo_, true)

				local var_529_2 = arg_526_1:FormatText(StoryNameCfg[7].name)

				arg_526_1.leftNameTxt_.text = var_529_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_526_1.leftNameTxt_.transform)

				arg_526_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_526_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_526_1:RecordName(arg_526_1.leftNameTxt_.text)
				SetActive(arg_526_1.iconTrs_.gameObject, true)
				arg_526_1.iconController_:SetSelectedState("hero")

				arg_526_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_526_1.callingController_:SetSelectedState("normal")

				arg_526_1.keyicon_.color = Color.New(1, 1, 1)
				arg_526_1.icon_.color = Color.New(1, 1, 1)

				local var_529_3 = arg_526_1:GetWordFromCfg(1102205127)
				local var_529_4 = arg_526_1:FormatText(var_529_3.content)

				arg_526_1.text_.text = var_529_4

				LuaForUtil.ClearLinePrefixSymbol(arg_526_1.text_)

				local var_529_5 = 19
				local var_529_6 = utf8.len(var_529_4)
				local var_529_7 = var_529_5 <= 0 and var_529_1 or var_529_1 * (var_529_6 / var_529_5)

				if var_529_7 > 0 and var_529_1 < var_529_7 then
					arg_526_1.talkMaxDuration = var_529_7

					if var_529_7 + var_529_0 > arg_526_1.duration_ then
						arg_526_1.duration_ = var_529_7 + var_529_0
					end
				end

				arg_526_1.text_.text = var_529_4
				arg_526_1.typewritter.percent = 0

				arg_526_1.typewritter:SetDirty()
				arg_526_1:ShowNextGo(false)
				arg_526_1:RecordContent(arg_526_1.text_.text)
			end

			local var_529_8 = math.max(var_529_1, arg_526_1.talkMaxDuration)

			if var_529_0 <= arg_526_1.time_ and arg_526_1.time_ < var_529_0 + var_529_8 then
				arg_526_1.typewritter.percent = (arg_526_1.time_ - var_529_0) / var_529_8

				arg_526_1.typewritter:SetDirty()
			end

			if arg_526_1.time_ >= var_529_0 + var_529_8 and arg_526_1.time_ < var_529_0 + var_529_8 + arg_529_0 then
				arg_526_1.typewritter.percent = 1

				arg_526_1.typewritter:SetDirty()
				arg_526_1:ShowNextGo(true)
			end
		end

		arg_526_1.nodeConfigList_ = {}

		arg_526_1:InitPlayNodeList()
	end,
	Play1102205128 = function(arg_530_0, arg_530_1)
		arg_530_1.time_ = 0
		arg_530_1.frameCnt_ = 0
		arg_530_1.state_ = "playing"
		arg_530_1.curTalkId_ = 1102205128
		arg_530_1.duration_ = 6.77

		SetActive(arg_530_1.tipsGo_, false)

		function arg_530_1.onSingleLineFinish_()
			arg_530_1.onSingleLineUpdate_ = nil
			arg_530_1.onSingleLineFinish_ = nil
			arg_530_1.state_ = "waiting"
		end

		function arg_530_1.playNext_(arg_532_0)
			if arg_532_0 == 1 then
				arg_530_0:Play1102205129(arg_530_1)
			end
		end

		function arg_530_1.onSingleLineUpdate_(arg_533_0)
			local var_533_0 = arg_530_1.actors_["1022ui_story"].transform
			local var_533_1 = 0

			if var_533_1 < arg_530_1.time_ and arg_530_1.time_ <= var_533_1 + arg_533_0 then
				arg_530_1.var_.moveOldPos1022ui_story = var_533_0.localPosition
			end

			local var_533_2 = 0.001

			if var_533_1 <= arg_530_1.time_ and arg_530_1.time_ < var_533_1 + var_533_2 then
				local var_533_3 = (arg_530_1.time_ - var_533_1) / var_533_2
				local var_533_4 = Vector3.New(0, -1.08, -6)

				var_533_0.localPosition = Vector3.Lerp(arg_530_1.var_.moveOldPos1022ui_story, var_533_4, var_533_3)

				local var_533_5 = manager.ui.mainCamera.transform.position - var_533_0.position

				var_533_0.forward = Vector3.New(var_533_5.x, var_533_5.y, var_533_5.z)

				local var_533_6 = var_533_0.localEulerAngles

				var_533_6.z = 0
				var_533_6.x = 0
				var_533_0.localEulerAngles = var_533_6
			end

			if arg_530_1.time_ >= var_533_1 + var_533_2 and arg_530_1.time_ < var_533_1 + var_533_2 + arg_533_0 then
				var_533_0.localPosition = Vector3.New(0, -1.08, -6)

				local var_533_7 = manager.ui.mainCamera.transform.position - var_533_0.position

				var_533_0.forward = Vector3.New(var_533_7.x, var_533_7.y, var_533_7.z)

				local var_533_8 = var_533_0.localEulerAngles

				var_533_8.z = 0
				var_533_8.x = 0
				var_533_0.localEulerAngles = var_533_8
			end

			local var_533_9 = arg_530_1.actors_["1022ui_story"]
			local var_533_10 = 0

			if var_533_10 < arg_530_1.time_ and arg_530_1.time_ <= var_533_10 + arg_533_0 and not isNil(var_533_9) and arg_530_1.var_.characterEffect1022ui_story == nil then
				arg_530_1.var_.characterEffect1022ui_story = var_533_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_533_11 = 0.200000002980232

			if var_533_10 <= arg_530_1.time_ and arg_530_1.time_ < var_533_10 + var_533_11 and not isNil(var_533_9) then
				local var_533_12 = (arg_530_1.time_ - var_533_10) / var_533_11

				if arg_530_1.var_.characterEffect1022ui_story and not isNil(var_533_9) then
					arg_530_1.var_.characterEffect1022ui_story.fillFlat = false
				end
			end

			if arg_530_1.time_ >= var_533_10 + var_533_11 and arg_530_1.time_ < var_533_10 + var_533_11 + arg_533_0 and not isNil(var_533_9) and arg_530_1.var_.characterEffect1022ui_story then
				arg_530_1.var_.characterEffect1022ui_story.fillFlat = false
			end

			local var_533_13 = 0

			if var_533_13 < arg_530_1.time_ and arg_530_1.time_ <= var_533_13 + arg_533_0 then
				arg_530_1:PlayTimeline("1022ui_story", "StoryTimeline/CharAction/story1022/story1022action/1022action6_2")
			end

			local var_533_14 = 0

			if var_533_14 < arg_530_1.time_ and arg_530_1.time_ <= var_533_14 + arg_533_0 then
				arg_530_1:PlayTimeline("1022ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_533_15 = 0
			local var_533_16 = 0.675

			if var_533_15 < arg_530_1.time_ and arg_530_1.time_ <= var_533_15 + arg_533_0 then
				arg_530_1.talkMaxDuration = 0
				arg_530_1.dialogCg_.alpha = 1

				arg_530_1.dialog_:SetActive(true)
				SetActive(arg_530_1.leftNameGo_, true)

				local var_533_17 = arg_530_1:FormatText(StoryNameCfg[259].name)

				arg_530_1.leftNameTxt_.text = var_533_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_530_1.leftNameTxt_.transform)

				arg_530_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_530_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_530_1:RecordName(arg_530_1.leftNameTxt_.text)
				SetActive(arg_530_1.iconTrs_.gameObject, false)
				arg_530_1.callingController_:SetSelectedState("normal")

				local var_533_18 = arg_530_1:GetWordFromCfg(1102205128)
				local var_533_19 = arg_530_1:FormatText(var_533_18.content)

				arg_530_1.text_.text = var_533_19

				LuaForUtil.ClearLinePrefixSymbol(arg_530_1.text_)

				local var_533_20 = 27
				local var_533_21 = utf8.len(var_533_19)
				local var_533_22 = var_533_20 <= 0 and var_533_16 or var_533_16 * (var_533_21 / var_533_20)

				if var_533_22 > 0 and var_533_16 < var_533_22 then
					arg_530_1.talkMaxDuration = var_533_22

					if var_533_22 + var_533_15 > arg_530_1.duration_ then
						arg_530_1.duration_ = var_533_22 + var_533_15
					end
				end

				arg_530_1.text_.text = var_533_19
				arg_530_1.typewritter.percent = 0

				arg_530_1.typewritter:SetDirty()
				arg_530_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205128", "story_v_side_new_1102205.awb") ~= 0 then
					local var_533_23 = manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205128", "story_v_side_new_1102205.awb") / 1000

					if var_533_23 + var_533_15 > arg_530_1.duration_ then
						arg_530_1.duration_ = var_533_23 + var_533_15
					end

					if var_533_18.prefab_name ~= "" and arg_530_1.actors_[var_533_18.prefab_name] ~= nil then
						local var_533_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_530_1.actors_[var_533_18.prefab_name].transform, "story_v_side_new_1102205", "1102205128", "story_v_side_new_1102205.awb")

						arg_530_1:RecordAudio("1102205128", var_533_24)
						arg_530_1:RecordAudio("1102205128", var_533_24)
					else
						arg_530_1:AudioAction("play", "voice", "story_v_side_new_1102205", "1102205128", "story_v_side_new_1102205.awb")
					end

					arg_530_1:RecordHistoryTalkVoice("story_v_side_new_1102205", "1102205128", "story_v_side_new_1102205.awb")
				end

				arg_530_1:RecordContent(arg_530_1.text_.text)
			end

			local var_533_25 = math.max(var_533_16, arg_530_1.talkMaxDuration)

			if var_533_15 <= arg_530_1.time_ and arg_530_1.time_ < var_533_15 + var_533_25 then
				arg_530_1.typewritter.percent = (arg_530_1.time_ - var_533_15) / var_533_25

				arg_530_1.typewritter:SetDirty()
			end

			if arg_530_1.time_ >= var_533_15 + var_533_25 and arg_530_1.time_ < var_533_15 + var_533_25 + arg_533_0 then
				arg_530_1.typewritter.percent = 1

				arg_530_1.typewritter:SetDirty()
				arg_530_1:ShowNextGo(true)
			end
		end

		arg_530_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1022ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_530_1:InitPlayNodeList()
	end,
	Play1102205129 = function(arg_534_0, arg_534_1)
		arg_534_1.time_ = 0
		arg_534_1.frameCnt_ = 0
		arg_534_1.state_ = "playing"
		arg_534_1.curTalkId_ = 1102205129
		arg_534_1.duration_ = 5

		SetActive(arg_534_1.tipsGo_, false)

		function arg_534_1.onSingleLineFinish_()
			arg_534_1.onSingleLineUpdate_ = nil
			arg_534_1.onSingleLineFinish_ = nil
			arg_534_1.state_ = "waiting"
		end

		function arg_534_1.playNext_(arg_536_0)
			if arg_536_0 == 1 then
				arg_534_0:Play1102205130(arg_534_1)
			end
		end

		function arg_534_1.onSingleLineUpdate_(arg_537_0)
			local var_537_0 = arg_534_1.actors_["1022ui_story"]
			local var_537_1 = 0

			if var_537_1 < arg_534_1.time_ and arg_534_1.time_ <= var_537_1 + arg_537_0 and not isNil(var_537_0) and arg_534_1.var_.characterEffect1022ui_story == nil then
				arg_534_1.var_.characterEffect1022ui_story = var_537_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_537_2 = 0.200000002980232

			if var_537_1 <= arg_534_1.time_ and arg_534_1.time_ < var_537_1 + var_537_2 and not isNil(var_537_0) then
				local var_537_3 = (arg_534_1.time_ - var_537_1) / var_537_2

				if arg_534_1.var_.characterEffect1022ui_story and not isNil(var_537_0) then
					local var_537_4 = Mathf.Lerp(0, 0.5, var_537_3)

					arg_534_1.var_.characterEffect1022ui_story.fillFlat = true
					arg_534_1.var_.characterEffect1022ui_story.fillRatio = var_537_4
				end
			end

			if arg_534_1.time_ >= var_537_1 + var_537_2 and arg_534_1.time_ < var_537_1 + var_537_2 + arg_537_0 and not isNil(var_537_0) and arg_534_1.var_.characterEffect1022ui_story then
				local var_537_5 = 0.5

				arg_534_1.var_.characterEffect1022ui_story.fillFlat = true
				arg_534_1.var_.characterEffect1022ui_story.fillRatio = var_537_5
			end

			local var_537_6 = 0
			local var_537_7 = 0.55

			if var_537_6 < arg_534_1.time_ and arg_534_1.time_ <= var_537_6 + arg_537_0 then
				arg_534_1.talkMaxDuration = 0
				arg_534_1.dialogCg_.alpha = 1

				arg_534_1.dialog_:SetActive(true)
				SetActive(arg_534_1.leftNameGo_, true)

				local var_537_8 = arg_534_1:FormatText(StoryNameCfg[7].name)

				arg_534_1.leftNameTxt_.text = var_537_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_534_1.leftNameTxt_.transform)

				arg_534_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_534_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_534_1:RecordName(arg_534_1.leftNameTxt_.text)
				SetActive(arg_534_1.iconTrs_.gameObject, true)
				arg_534_1.iconController_:SetSelectedState("hero")

				arg_534_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_534_1.callingController_:SetSelectedState("normal")

				arg_534_1.keyicon_.color = Color.New(1, 1, 1)
				arg_534_1.icon_.color = Color.New(1, 1, 1)

				local var_537_9 = arg_534_1:GetWordFromCfg(1102205129)
				local var_537_10 = arg_534_1:FormatText(var_537_9.content)

				arg_534_1.text_.text = var_537_10

				LuaForUtil.ClearLinePrefixSymbol(arg_534_1.text_)

				local var_537_11 = 22
				local var_537_12 = utf8.len(var_537_10)
				local var_537_13 = var_537_11 <= 0 and var_537_7 or var_537_7 * (var_537_12 / var_537_11)

				if var_537_13 > 0 and var_537_7 < var_537_13 then
					arg_534_1.talkMaxDuration = var_537_13

					if var_537_13 + var_537_6 > arg_534_1.duration_ then
						arg_534_1.duration_ = var_537_13 + var_537_6
					end
				end

				arg_534_1.text_.text = var_537_10
				arg_534_1.typewritter.percent = 0

				arg_534_1.typewritter:SetDirty()
				arg_534_1:ShowNextGo(false)
				arg_534_1:RecordContent(arg_534_1.text_.text)
			end

			local var_537_14 = math.max(var_537_7, arg_534_1.talkMaxDuration)

			if var_537_6 <= arg_534_1.time_ and arg_534_1.time_ < var_537_6 + var_537_14 then
				arg_534_1.typewritter.percent = (arg_534_1.time_ - var_537_6) / var_537_14

				arg_534_1.typewritter:SetDirty()
			end

			if arg_534_1.time_ >= var_537_6 + var_537_14 and arg_534_1.time_ < var_537_6 + var_537_14 + arg_537_0 then
				arg_534_1.typewritter.percent = 1

				arg_534_1.typewritter:SetDirty()
				arg_534_1:ShowNextGo(true)
			end
		end

		arg_534_1.nodeConfigList_ = {}

		arg_534_1:InitPlayNodeList()
	end,
	Play1102205130 = function(arg_538_0, arg_538_1)
		arg_538_1.time_ = 0
		arg_538_1.frameCnt_ = 0
		arg_538_1.state_ = "playing"
		arg_538_1.curTalkId_ = 1102205130
		arg_538_1.duration_ = 4.1

		SetActive(arg_538_1.tipsGo_, false)

		function arg_538_1.onSingleLineFinish_()
			arg_538_1.onSingleLineUpdate_ = nil
			arg_538_1.onSingleLineFinish_ = nil
			arg_538_1.state_ = "waiting"
		end

		function arg_538_1.playNext_(arg_540_0)
			if arg_540_0 == 1 then
				arg_538_0:Play1102205131(arg_538_1)
			end
		end

		function arg_538_1.onSingleLineUpdate_(arg_541_0)
			local var_541_0 = arg_538_1.actors_["1022ui_story"]
			local var_541_1 = 0

			if var_541_1 < arg_538_1.time_ and arg_538_1.time_ <= var_541_1 + arg_541_0 and not isNil(var_541_0) and arg_538_1.var_.characterEffect1022ui_story == nil then
				arg_538_1.var_.characterEffect1022ui_story = var_541_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_541_2 = 0.200000002980232

			if var_541_1 <= arg_538_1.time_ and arg_538_1.time_ < var_541_1 + var_541_2 and not isNil(var_541_0) then
				local var_541_3 = (arg_538_1.time_ - var_541_1) / var_541_2

				if arg_538_1.var_.characterEffect1022ui_story and not isNil(var_541_0) then
					arg_538_1.var_.characterEffect1022ui_story.fillFlat = false
				end
			end

			if arg_538_1.time_ >= var_541_1 + var_541_2 and arg_538_1.time_ < var_541_1 + var_541_2 + arg_541_0 and not isNil(var_541_0) and arg_538_1.var_.characterEffect1022ui_story then
				arg_538_1.var_.characterEffect1022ui_story.fillFlat = false
			end

			local var_541_4 = 0

			if var_541_4 < arg_538_1.time_ and arg_538_1.time_ <= var_541_4 + arg_541_0 then
				arg_538_1:PlayTimeline("1022ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_541_5 = 0
			local var_541_6 = 0.525

			if var_541_5 < arg_538_1.time_ and arg_538_1.time_ <= var_541_5 + arg_541_0 then
				arg_538_1.talkMaxDuration = 0
				arg_538_1.dialogCg_.alpha = 1

				arg_538_1.dialog_:SetActive(true)
				SetActive(arg_538_1.leftNameGo_, true)

				local var_541_7 = arg_538_1:FormatText(StoryNameCfg[259].name)

				arg_538_1.leftNameTxt_.text = var_541_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_538_1.leftNameTxt_.transform)

				arg_538_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_538_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_538_1:RecordName(arg_538_1.leftNameTxt_.text)
				SetActive(arg_538_1.iconTrs_.gameObject, false)
				arg_538_1.callingController_:SetSelectedState("normal")

				local var_541_8 = arg_538_1:GetWordFromCfg(1102205130)
				local var_541_9 = arg_538_1:FormatText(var_541_8.content)

				arg_538_1.text_.text = var_541_9

				LuaForUtil.ClearLinePrefixSymbol(arg_538_1.text_)

				local var_541_10 = 21
				local var_541_11 = utf8.len(var_541_9)
				local var_541_12 = var_541_10 <= 0 and var_541_6 or var_541_6 * (var_541_11 / var_541_10)

				if var_541_12 > 0 and var_541_6 < var_541_12 then
					arg_538_1.talkMaxDuration = var_541_12

					if var_541_12 + var_541_5 > arg_538_1.duration_ then
						arg_538_1.duration_ = var_541_12 + var_541_5
					end
				end

				arg_538_1.text_.text = var_541_9
				arg_538_1.typewritter.percent = 0

				arg_538_1.typewritter:SetDirty()
				arg_538_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205130", "story_v_side_new_1102205.awb") ~= 0 then
					local var_541_13 = manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205130", "story_v_side_new_1102205.awb") / 1000

					if var_541_13 + var_541_5 > arg_538_1.duration_ then
						arg_538_1.duration_ = var_541_13 + var_541_5
					end

					if var_541_8.prefab_name ~= "" and arg_538_1.actors_[var_541_8.prefab_name] ~= nil then
						local var_541_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_538_1.actors_[var_541_8.prefab_name].transform, "story_v_side_new_1102205", "1102205130", "story_v_side_new_1102205.awb")

						arg_538_1:RecordAudio("1102205130", var_541_14)
						arg_538_1:RecordAudio("1102205130", var_541_14)
					else
						arg_538_1:AudioAction("play", "voice", "story_v_side_new_1102205", "1102205130", "story_v_side_new_1102205.awb")
					end

					arg_538_1:RecordHistoryTalkVoice("story_v_side_new_1102205", "1102205130", "story_v_side_new_1102205.awb")
				end

				arg_538_1:RecordContent(arg_538_1.text_.text)
			end

			local var_541_15 = math.max(var_541_6, arg_538_1.talkMaxDuration)

			if var_541_5 <= arg_538_1.time_ and arg_538_1.time_ < var_541_5 + var_541_15 then
				arg_538_1.typewritter.percent = (arg_538_1.time_ - var_541_5) / var_541_15

				arg_538_1.typewritter:SetDirty()
			end

			if arg_538_1.time_ >= var_541_5 + var_541_15 and arg_538_1.time_ < var_541_5 + var_541_15 + arg_541_0 then
				arg_538_1.typewritter.percent = 1

				arg_538_1.typewritter:SetDirty()
				arg_538_1:ShowNextGo(true)
			end
		end

		arg_538_1.nodeConfigList_ = {}

		arg_538_1:InitPlayNodeList()
	end,
	Play1102205131 = function(arg_542_0, arg_542_1)
		arg_542_1.time_ = 0
		arg_542_1.frameCnt_ = 0
		arg_542_1.state_ = "playing"
		arg_542_1.curTalkId_ = 1102205131
		arg_542_1.duration_ = 7.83

		SetActive(arg_542_1.tipsGo_, false)

		function arg_542_1.onSingleLineFinish_()
			arg_542_1.onSingleLineUpdate_ = nil
			arg_542_1.onSingleLineFinish_ = nil
			arg_542_1.state_ = "waiting"
		end

		function arg_542_1.playNext_(arg_544_0)
			if arg_544_0 == 1 then
				arg_542_0:Play1102205132(arg_542_1)
			end
		end

		function arg_542_1.onSingleLineUpdate_(arg_545_0)
			local var_545_0 = 1.2

			if var_545_0 < arg_542_1.time_ and arg_542_1.time_ <= var_545_0 + arg_545_0 then
				local var_545_1 = manager.ui.mainCamera.transform.localPosition
				local var_545_2 = Vector3.New(0, 0, 10) + Vector3.New(var_545_1.x, var_545_1.y, 0)
				local var_545_3 = arg_542_1.bgs_.F08l

				var_545_3.transform.localPosition = var_545_2
				var_545_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_545_4 = var_545_3:GetComponent("SpriteRenderer")

				if var_545_4 and var_545_4.sprite then
					local var_545_5 = (var_545_3.transform.localPosition - var_545_1).z
					local var_545_6 = manager.ui.mainCameraCom_
					local var_545_7 = 2 * var_545_5 * Mathf.Tan(var_545_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_545_8 = var_545_7 * var_545_6.aspect
					local var_545_9 = var_545_4.sprite.bounds.size.x
					local var_545_10 = var_545_4.sprite.bounds.size.y
					local var_545_11 = var_545_8 / var_545_9
					local var_545_12 = var_545_7 / var_545_10
					local var_545_13 = var_545_12 < var_545_11 and var_545_11 or var_545_12

					var_545_3.transform.localScale = Vector3.New(var_545_13, var_545_13, 0)
				end

				for iter_545_0, iter_545_1 in pairs(arg_542_1.bgs_) do
					if iter_545_0 ~= "F08l" then
						iter_545_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_545_14 = 1.2

			if var_545_14 < arg_542_1.time_ and arg_542_1.time_ <= var_545_14 + arg_545_0 then
				arg_542_1.allBtn_.enabled = false
			end

			local var_545_15 = 0.3

			if arg_542_1.time_ >= var_545_14 + var_545_15 and arg_542_1.time_ < var_545_14 + var_545_15 + arg_545_0 then
				arg_542_1.allBtn_.enabled = true
			end

			local var_545_16 = 0

			if var_545_16 < arg_542_1.time_ and arg_542_1.time_ <= var_545_16 + arg_545_0 then
				arg_542_1.mask_.enabled = true
				arg_542_1.mask_.raycastTarget = true

				arg_542_1:SetGaussion(false)
			end

			local var_545_17 = 1.2

			if var_545_16 <= arg_542_1.time_ and arg_542_1.time_ < var_545_16 + var_545_17 then
				local var_545_18 = (arg_542_1.time_ - var_545_16) / var_545_17
				local var_545_19 = Color.New(0, 0, 0)

				var_545_19.a = Mathf.Lerp(0, 1, var_545_18)
				arg_542_1.mask_.color = var_545_19
			end

			if arg_542_1.time_ >= var_545_16 + var_545_17 and arg_542_1.time_ < var_545_16 + var_545_17 + arg_545_0 then
				local var_545_20 = Color.New(0, 0, 0)

				var_545_20.a = 1
				arg_542_1.mask_.color = var_545_20
			end

			local var_545_21 = 1.2

			if var_545_21 < arg_542_1.time_ and arg_542_1.time_ <= var_545_21 + arg_545_0 then
				arg_542_1.mask_.enabled = true
				arg_542_1.mask_.raycastTarget = true

				arg_542_1:SetGaussion(false)
			end

			local var_545_22 = 1.70833333333333

			if var_545_21 <= arg_542_1.time_ and arg_542_1.time_ < var_545_21 + var_545_22 then
				local var_545_23 = (arg_542_1.time_ - var_545_21) / var_545_22
				local var_545_24 = Color.New(0, 0, 0)

				var_545_24.a = Mathf.Lerp(1, 0, var_545_23)
				arg_542_1.mask_.color = var_545_24
			end

			if arg_542_1.time_ >= var_545_21 + var_545_22 and arg_542_1.time_ < var_545_21 + var_545_22 + arg_545_0 then
				local var_545_25 = Color.New(0, 0, 0)
				local var_545_26 = 0

				arg_542_1.mask_.enabled = false
				var_545_25.a = var_545_26
				arg_542_1.mask_.color = var_545_25
			end

			local var_545_27 = arg_542_1.actors_["1022ui_story"].transform
			local var_545_28 = 1.2

			if var_545_28 < arg_542_1.time_ and arg_542_1.time_ <= var_545_28 + arg_545_0 then
				arg_542_1.var_.moveOldPos1022ui_story = var_545_27.localPosition
			end

			local var_545_29 = 0.001

			if var_545_28 <= arg_542_1.time_ and arg_542_1.time_ < var_545_28 + var_545_29 then
				local var_545_30 = (arg_542_1.time_ - var_545_28) / var_545_29
				local var_545_31 = Vector3.New(0, 100, 0)

				var_545_27.localPosition = Vector3.Lerp(arg_542_1.var_.moveOldPos1022ui_story, var_545_31, var_545_30)

				local var_545_32 = manager.ui.mainCamera.transform.position - var_545_27.position

				var_545_27.forward = Vector3.New(var_545_32.x, var_545_32.y, var_545_32.z)

				local var_545_33 = var_545_27.localEulerAngles

				var_545_33.z = 0
				var_545_33.x = 0
				var_545_27.localEulerAngles = var_545_33
			end

			if arg_542_1.time_ >= var_545_28 + var_545_29 and arg_542_1.time_ < var_545_28 + var_545_29 + arg_545_0 then
				var_545_27.localPosition = Vector3.New(0, 100, 0)

				local var_545_34 = manager.ui.mainCamera.transform.position - var_545_27.position

				var_545_27.forward = Vector3.New(var_545_34.x, var_545_34.y, var_545_34.z)

				local var_545_35 = var_545_27.localEulerAngles

				var_545_35.z = 0
				var_545_35.x = 0
				var_545_27.localEulerAngles = var_545_35
			end

			local var_545_36 = arg_542_1.actors_["1022ui_story"]
			local var_545_37 = 1.2

			if var_545_37 < arg_542_1.time_ and arg_542_1.time_ <= var_545_37 + arg_545_0 and not isNil(var_545_36) and arg_542_1.var_.characterEffect1022ui_story == nil then
				arg_542_1.var_.characterEffect1022ui_story = var_545_36:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_545_38 = 0.200000002980232

			if var_545_37 <= arg_542_1.time_ and arg_542_1.time_ < var_545_37 + var_545_38 and not isNil(var_545_36) then
				local var_545_39 = (arg_542_1.time_ - var_545_37) / var_545_38

				if arg_542_1.var_.characterEffect1022ui_story and not isNil(var_545_36) then
					local var_545_40 = Mathf.Lerp(0, 0.5, var_545_39)

					arg_542_1.var_.characterEffect1022ui_story.fillFlat = true
					arg_542_1.var_.characterEffect1022ui_story.fillRatio = var_545_40
				end
			end

			if arg_542_1.time_ >= var_545_37 + var_545_38 and arg_542_1.time_ < var_545_37 + var_545_38 + arg_545_0 and not isNil(var_545_36) and arg_542_1.var_.characterEffect1022ui_story then
				local var_545_41 = 0.5

				arg_542_1.var_.characterEffect1022ui_story.fillFlat = true
				arg_542_1.var_.characterEffect1022ui_story.fillRatio = var_545_41
			end

			local var_545_42 = 0
			local var_545_43 = 1

			if var_545_42 < arg_542_1.time_ and arg_542_1.time_ <= var_545_42 + arg_545_0 then
				local var_545_44 = "stop"
				local var_545_45 = "effect"

				arg_542_1:AudioAction(var_545_44, var_545_45, "se_story_140", "se_story_140_amb_street01", "")
			end

			local var_545_46 = 0.8
			local var_545_47 = 1

			if var_545_46 < arg_542_1.time_ and arg_542_1.time_ <= var_545_46 + arg_545_0 then
				local var_545_48 = "play"
				local var_545_49 = "effect"

				arg_542_1:AudioAction(var_545_48, var_545_49, "se_story_140", "se_story_140_amb_street02", "")
			end

			local var_545_50 = 0
			local var_545_51 = 0.3

			if var_545_50 < arg_542_1.time_ and arg_542_1.time_ <= var_545_50 + arg_545_0 then
				local var_545_52 = "play"
				local var_545_53 = "music"

				arg_542_1:AudioAction(var_545_52, var_545_53, "ui_battle", "ui_battle_stopbgm", "")

				local var_545_54 = ""
				local var_545_55 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_545_55 ~= "" then
					if arg_542_1.bgmTxt_.text ~= var_545_55 and arg_542_1.bgmTxt_.text ~= "" then
						if arg_542_1.bgmTxt2_.text ~= "" then
							arg_542_1.bgmTxt_.text = arg_542_1.bgmTxt2_.text
						end

						arg_542_1.bgmTxt2_.text = var_545_55

						arg_542_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_542_1.bgmTxt_.text = var_545_55
						arg_542_1.bgmTxt2_.text = var_545_55
					end

					if arg_542_1.bgmTimer then
						arg_542_1.bgmTimer:Stop()

						arg_542_1.bgmTimer = nil
					end

					if arg_542_1.settingData.show_music_name == 1 then
						arg_542_1.musicController:SetSelectedState("show")
						arg_542_1.musicAnimator_:Play("open", 0, 0)

						if arg_542_1.settingData.music_time ~= 0 then
							arg_542_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_542_1.settingData.music_time), function()
								if arg_542_1 == nil or isNil(arg_542_1.bgmTxt_) then
									return
								end

								arg_542_1.musicController:SetSelectedState("hide")
								arg_542_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_542_1.frameCnt_ <= 1 then
				arg_542_1.dialog_:SetActive(false)
			end

			local var_545_56 = 2.83333333333333
			local var_545_57 = 0.075

			if var_545_56 < arg_542_1.time_ and arg_542_1.time_ <= var_545_56 + arg_545_0 then
				arg_542_1.talkMaxDuration = 0

				arg_542_1.dialog_:SetActive(true)

				arg_542_1.dialogCg_.alpha = 0

				local var_545_58 = LeanTween.value(arg_542_1.dialog_, 0, 1, 0.3)

				var_545_58:setOnUpdate(LuaHelper.FloatAction(function(arg_547_0)
					arg_542_1.dialogCg_.alpha = arg_547_0
				end))
				var_545_58:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_542_1.dialog_)
					var_545_58:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_542_1.duration_ = arg_542_1.duration_ + 0.3

				SetActive(arg_542_1.leftNameGo_, true)

				local var_545_59 = arg_542_1:FormatText(StoryNameCfg[7].name)

				arg_542_1.leftNameTxt_.text = var_545_59

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_542_1.leftNameTxt_.transform)

				arg_542_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_542_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_542_1:RecordName(arg_542_1.leftNameTxt_.text)
				SetActive(arg_542_1.iconTrs_.gameObject, true)
				arg_542_1.iconController_:SetSelectedState("hero")

				arg_542_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_542_1.callingController_:SetSelectedState("normal")

				arg_542_1.keyicon_.color = Color.New(1, 1, 1)
				arg_542_1.icon_.color = Color.New(1, 1, 1)

				local var_545_60 = arg_542_1:GetWordFromCfg(1102205131)
				local var_545_61 = arg_542_1:FormatText(var_545_60.content)

				arg_542_1.text_.text = var_545_61

				LuaForUtil.ClearLinePrefixSymbol(arg_542_1.text_)

				local var_545_62 = 3
				local var_545_63 = utf8.len(var_545_61)
				local var_545_64 = var_545_62 <= 0 and var_545_57 or var_545_57 * (var_545_63 / var_545_62)

				if var_545_64 > 0 and var_545_57 < var_545_64 then
					arg_542_1.talkMaxDuration = var_545_64
					var_545_56 = var_545_56 + 0.3

					if var_545_64 + var_545_56 > arg_542_1.duration_ then
						arg_542_1.duration_ = var_545_64 + var_545_56
					end
				end

				arg_542_1.text_.text = var_545_61
				arg_542_1.typewritter.percent = 0

				arg_542_1.typewritter:SetDirty()
				arg_542_1:ShowNextGo(false)
				arg_542_1:RecordContent(arg_542_1.text_.text)
			end

			local var_545_65 = var_545_56 + 0.3
			local var_545_66 = math.max(var_545_57, arg_542_1.talkMaxDuration)

			if var_545_65 <= arg_542_1.time_ and arg_542_1.time_ < var_545_65 + var_545_66 then
				arg_542_1.typewritter.percent = (arg_542_1.time_ - var_545_65) / var_545_66

				arg_542_1.typewritter:SetDirty()
			end

			if arg_542_1.time_ >= var_545_65 + var_545_66 and arg_542_1.time_ < var_545_65 + var_545_66 + arg_545_0 then
				arg_542_1.typewritter.percent = 1

				arg_542_1.typewritter:SetDirty()
				arg_542_1:ShowNextGo(true)
			end
		end

		arg_542_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1022ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_542_1:InitPlayNodeList()
	end,
	Play1102205132 = function(arg_549_0, arg_549_1)
		arg_549_1.time_ = 0
		arg_549_1.frameCnt_ = 0
		arg_549_1.state_ = "playing"
		arg_549_1.curTalkId_ = 1102205132
		arg_549_1.duration_ = 5

		SetActive(arg_549_1.tipsGo_, false)

		function arg_549_1.onSingleLineFinish_()
			arg_549_1.onSingleLineUpdate_ = nil
			arg_549_1.onSingleLineFinish_ = nil
			arg_549_1.state_ = "waiting"
		end

		function arg_549_1.playNext_(arg_551_0)
			if arg_551_0 == 1 then
				arg_549_0:Play1102205133(arg_549_1)
			end
		end

		function arg_549_1.onSingleLineUpdate_(arg_552_0)
			local var_552_0 = 0
			local var_552_1 = 1.325

			if var_552_0 < arg_549_1.time_ and arg_549_1.time_ <= var_552_0 + arg_552_0 then
				arg_549_1.talkMaxDuration = 0
				arg_549_1.dialogCg_.alpha = 1

				arg_549_1.dialog_:SetActive(true)
				SetActive(arg_549_1.leftNameGo_, false)

				arg_549_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_549_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_549_1:RecordName(arg_549_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_549_1.iconTrs_.gameObject, false)
				arg_549_1.callingController_:SetSelectedState("normal")

				local var_552_2 = arg_549_1:GetWordFromCfg(1102205132)
				local var_552_3 = arg_549_1:FormatText(var_552_2.content)

				arg_549_1.text_.text = var_552_3

				LuaForUtil.ClearLinePrefixSymbol(arg_549_1.text_)

				local var_552_4 = 53
				local var_552_5 = utf8.len(var_552_3)
				local var_552_6 = var_552_4 <= 0 and var_552_1 or var_552_1 * (var_552_5 / var_552_4)

				if var_552_6 > 0 and var_552_1 < var_552_6 then
					arg_549_1.talkMaxDuration = var_552_6

					if var_552_6 + var_552_0 > arg_549_1.duration_ then
						arg_549_1.duration_ = var_552_6 + var_552_0
					end
				end

				arg_549_1.text_.text = var_552_3
				arg_549_1.typewritter.percent = 0

				arg_549_1.typewritter:SetDirty()
				arg_549_1:ShowNextGo(false)
				arg_549_1:RecordContent(arg_549_1.text_.text)
			end

			local var_552_7 = math.max(var_552_1, arg_549_1.talkMaxDuration)

			if var_552_0 <= arg_549_1.time_ and arg_549_1.time_ < var_552_0 + var_552_7 then
				arg_549_1.typewritter.percent = (arg_549_1.time_ - var_552_0) / var_552_7

				arg_549_1.typewritter:SetDirty()
			end

			if arg_549_1.time_ >= var_552_0 + var_552_7 and arg_549_1.time_ < var_552_0 + var_552_7 + arg_552_0 then
				arg_549_1.typewritter.percent = 1

				arg_549_1.typewritter:SetDirty()
				arg_549_1:ShowNextGo(true)
			end
		end

		arg_549_1.nodeConfigList_ = {}

		arg_549_1:InitPlayNodeList()
	end,
	Play1102205133 = function(arg_553_0, arg_553_1)
		arg_553_1.time_ = 0
		arg_553_1.frameCnt_ = 0
		arg_553_1.state_ = "playing"
		arg_553_1.curTalkId_ = 1102205133
		arg_553_1.duration_ = 5

		SetActive(arg_553_1.tipsGo_, false)

		function arg_553_1.onSingleLineFinish_()
			arg_553_1.onSingleLineUpdate_ = nil
			arg_553_1.onSingleLineFinish_ = nil
			arg_553_1.state_ = "waiting"
		end

		function arg_553_1.playNext_(arg_555_0)
			if arg_555_0 == 1 then
				arg_553_0:Play1102205134(arg_553_1)
			end
		end

		function arg_553_1.onSingleLineUpdate_(arg_556_0)
			local var_556_0 = 0
			local var_556_1 = 0.725

			if var_556_0 < arg_553_1.time_ and arg_553_1.time_ <= var_556_0 + arg_556_0 then
				arg_553_1.talkMaxDuration = 0
				arg_553_1.dialogCg_.alpha = 1

				arg_553_1.dialog_:SetActive(true)
				SetActive(arg_553_1.leftNameGo_, false)

				arg_553_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_553_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_553_1:RecordName(arg_553_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_553_1.iconTrs_.gameObject, false)
				arg_553_1.callingController_:SetSelectedState("normal")

				local var_556_2 = arg_553_1:GetWordFromCfg(1102205133)
				local var_556_3 = arg_553_1:FormatText(var_556_2.content)

				arg_553_1.text_.text = var_556_3

				LuaForUtil.ClearLinePrefixSymbol(arg_553_1.text_)

				local var_556_4 = 29
				local var_556_5 = utf8.len(var_556_3)
				local var_556_6 = var_556_4 <= 0 and var_556_1 or var_556_1 * (var_556_5 / var_556_4)

				if var_556_6 > 0 and var_556_1 < var_556_6 then
					arg_553_1.talkMaxDuration = var_556_6

					if var_556_6 + var_556_0 > arg_553_1.duration_ then
						arg_553_1.duration_ = var_556_6 + var_556_0
					end
				end

				arg_553_1.text_.text = var_556_3
				arg_553_1.typewritter.percent = 0

				arg_553_1.typewritter:SetDirty()
				arg_553_1:ShowNextGo(false)
				arg_553_1:RecordContent(arg_553_1.text_.text)
			end

			local var_556_7 = math.max(var_556_1, arg_553_1.talkMaxDuration)

			if var_556_0 <= arg_553_1.time_ and arg_553_1.time_ < var_556_0 + var_556_7 then
				arg_553_1.typewritter.percent = (arg_553_1.time_ - var_556_0) / var_556_7

				arg_553_1.typewritter:SetDirty()
			end

			if arg_553_1.time_ >= var_556_0 + var_556_7 and arg_553_1.time_ < var_556_0 + var_556_7 + arg_556_0 then
				arg_553_1.typewritter.percent = 1

				arg_553_1.typewritter:SetDirty()
				arg_553_1:ShowNextGo(true)
			end
		end

		arg_553_1.nodeConfigList_ = {}

		arg_553_1:InitPlayNodeList()
	end,
	Play1102205134 = function(arg_557_0, arg_557_1)
		arg_557_1.time_ = 0
		arg_557_1.frameCnt_ = 0
		arg_557_1.state_ = "playing"
		arg_557_1.curTalkId_ = 1102205134
		arg_557_1.duration_ = 3.27

		SetActive(arg_557_1.tipsGo_, false)

		function arg_557_1.onSingleLineFinish_()
			arg_557_1.onSingleLineUpdate_ = nil
			arg_557_1.onSingleLineFinish_ = nil
			arg_557_1.state_ = "waiting"
		end

		function arg_557_1.playNext_(arg_559_0)
			if arg_559_0 == 1 then
				arg_557_0:Play1102205135(arg_557_1)
			end
		end

		function arg_557_1.onSingleLineUpdate_(arg_560_0)
			local var_560_0 = arg_557_1.actors_["1022ui_story"].transform
			local var_560_1 = 0

			if var_560_1 < arg_557_1.time_ and arg_557_1.time_ <= var_560_1 + arg_560_0 then
				arg_557_1.var_.moveOldPos1022ui_story = var_560_0.localPosition
			end

			local var_560_2 = 0.001

			if var_560_1 <= arg_557_1.time_ and arg_557_1.time_ < var_560_1 + var_560_2 then
				local var_560_3 = (arg_557_1.time_ - var_560_1) / var_560_2
				local var_560_4 = Vector3.New(0, -1.08, -6)

				var_560_0.localPosition = Vector3.Lerp(arg_557_1.var_.moveOldPos1022ui_story, var_560_4, var_560_3)

				local var_560_5 = manager.ui.mainCamera.transform.position - var_560_0.position

				var_560_0.forward = Vector3.New(var_560_5.x, var_560_5.y, var_560_5.z)

				local var_560_6 = var_560_0.localEulerAngles

				var_560_6.z = 0
				var_560_6.x = 0
				var_560_0.localEulerAngles = var_560_6
			end

			if arg_557_1.time_ >= var_560_1 + var_560_2 and arg_557_1.time_ < var_560_1 + var_560_2 + arg_560_0 then
				var_560_0.localPosition = Vector3.New(0, -1.08, -6)

				local var_560_7 = manager.ui.mainCamera.transform.position - var_560_0.position

				var_560_0.forward = Vector3.New(var_560_7.x, var_560_7.y, var_560_7.z)

				local var_560_8 = var_560_0.localEulerAngles

				var_560_8.z = 0
				var_560_8.x = 0
				var_560_0.localEulerAngles = var_560_8
			end

			local var_560_9 = arg_557_1.actors_["1022ui_story"]
			local var_560_10 = 0

			if var_560_10 < arg_557_1.time_ and arg_557_1.time_ <= var_560_10 + arg_560_0 and not isNil(var_560_9) and arg_557_1.var_.characterEffect1022ui_story == nil then
				arg_557_1.var_.characterEffect1022ui_story = var_560_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_560_11 = 0.200000002980232

			if var_560_10 <= arg_557_1.time_ and arg_557_1.time_ < var_560_10 + var_560_11 and not isNil(var_560_9) then
				local var_560_12 = (arg_557_1.time_ - var_560_10) / var_560_11

				if arg_557_1.var_.characterEffect1022ui_story and not isNil(var_560_9) then
					arg_557_1.var_.characterEffect1022ui_story.fillFlat = false
				end
			end

			if arg_557_1.time_ >= var_560_10 + var_560_11 and arg_557_1.time_ < var_560_10 + var_560_11 + arg_560_0 and not isNil(var_560_9) and arg_557_1.var_.characterEffect1022ui_story then
				arg_557_1.var_.characterEffect1022ui_story.fillFlat = false
			end

			local var_560_13 = 0

			if var_560_13 < arg_557_1.time_ and arg_557_1.time_ <= var_560_13 + arg_560_0 then
				arg_557_1:PlayTimeline("1022ui_story", "StoryTimeline/CharAction/story1022/story1022action/1022action1_1")
			end

			local var_560_14 = 0

			if var_560_14 < arg_557_1.time_ and arg_557_1.time_ <= var_560_14 + arg_560_0 then
				arg_557_1:PlayTimeline("1022ui_story", "StoryTimeline/CharAction/public_expression/expr_zhushiA", "EmotionTimelineAnimator")
			end

			local var_560_15 = 0
			local var_560_16 = 0.3

			if var_560_15 < arg_557_1.time_ and arg_557_1.time_ <= var_560_15 + arg_560_0 then
				local var_560_17 = "play"
				local var_560_18 = "music"

				arg_557_1:AudioAction(var_560_17, var_560_18, "ui_battle", "ui_battle_stopbgm", "")

				local var_560_19 = ""
				local var_560_20 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_560_20 ~= "" then
					if arg_557_1.bgmTxt_.text ~= var_560_20 and arg_557_1.bgmTxt_.text ~= "" then
						if arg_557_1.bgmTxt2_.text ~= "" then
							arg_557_1.bgmTxt_.text = arg_557_1.bgmTxt2_.text
						end

						arg_557_1.bgmTxt2_.text = var_560_20

						arg_557_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_557_1.bgmTxt_.text = var_560_20
						arg_557_1.bgmTxt2_.text = var_560_20
					end

					if arg_557_1.bgmTimer then
						arg_557_1.bgmTimer:Stop()

						arg_557_1.bgmTimer = nil
					end

					if arg_557_1.settingData.show_music_name == 1 then
						arg_557_1.musicController:SetSelectedState("show")
						arg_557_1.musicAnimator_:Play("open", 0, 0)

						if arg_557_1.settingData.music_time ~= 0 then
							arg_557_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_557_1.settingData.music_time), function()
								if arg_557_1 == nil or isNil(arg_557_1.bgmTxt_) then
									return
								end

								arg_557_1.musicController:SetSelectedState("hide")
								arg_557_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_560_21 = 0.433333333333333
			local var_560_22 = 1

			if var_560_21 < arg_557_1.time_ and arg_557_1.time_ <= var_560_21 + arg_560_0 then
				local var_560_23 = "play"
				local var_560_24 = "music"

				arg_557_1:AudioAction(var_560_23, var_560_24, "bgm_activity_3_0_story_quiet", "bgm_activity_3_0_story_quiet", "bgm_activity_3_0_story_quiet.awb")

				local var_560_25 = ""
				local var_560_26 = manager.audio:GetAudioName("bgm_activity_3_0_story_quiet", "bgm_activity_3_0_story_quiet")

				if var_560_26 ~= "" then
					if arg_557_1.bgmTxt_.text ~= var_560_26 and arg_557_1.bgmTxt_.text ~= "" then
						if arg_557_1.bgmTxt2_.text ~= "" then
							arg_557_1.bgmTxt_.text = arg_557_1.bgmTxt2_.text
						end

						arg_557_1.bgmTxt2_.text = var_560_26

						arg_557_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_557_1.bgmTxt_.text = var_560_26
						arg_557_1.bgmTxt2_.text = var_560_26
					end

					if arg_557_1.bgmTimer then
						arg_557_1.bgmTimer:Stop()

						arg_557_1.bgmTimer = nil
					end

					if arg_557_1.settingData.show_music_name == 1 then
						arg_557_1.musicController:SetSelectedState("show")
						arg_557_1.musicAnimator_:Play("open", 0, 0)

						if arg_557_1.settingData.music_time ~= 0 then
							arg_557_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_557_1.settingData.music_time), function()
								if arg_557_1 == nil or isNil(arg_557_1.bgmTxt_) then
									return
								end

								arg_557_1.musicController:SetSelectedState("hide")
								arg_557_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_560_27 = 0
			local var_560_28 = 0.3

			if var_560_27 < arg_557_1.time_ and arg_557_1.time_ <= var_560_27 + arg_560_0 then
				arg_557_1.talkMaxDuration = 0
				arg_557_1.dialogCg_.alpha = 1

				arg_557_1.dialog_:SetActive(true)
				SetActive(arg_557_1.leftNameGo_, true)

				local var_560_29 = arg_557_1:FormatText(StoryNameCfg[259].name)

				arg_557_1.leftNameTxt_.text = var_560_29

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_557_1.leftNameTxt_.transform)

				arg_557_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_557_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_557_1:RecordName(arg_557_1.leftNameTxt_.text)
				SetActive(arg_557_1.iconTrs_.gameObject, false)
				arg_557_1.callingController_:SetSelectedState("normal")

				local var_560_30 = arg_557_1:GetWordFromCfg(1102205134)
				local var_560_31 = arg_557_1:FormatText(var_560_30.content)

				arg_557_1.text_.text = var_560_31

				LuaForUtil.ClearLinePrefixSymbol(arg_557_1.text_)

				local var_560_32 = 12
				local var_560_33 = utf8.len(var_560_31)
				local var_560_34 = var_560_32 <= 0 and var_560_28 or var_560_28 * (var_560_33 / var_560_32)

				if var_560_34 > 0 and var_560_28 < var_560_34 then
					arg_557_1.talkMaxDuration = var_560_34

					if var_560_34 + var_560_27 > arg_557_1.duration_ then
						arg_557_1.duration_ = var_560_34 + var_560_27
					end
				end

				arg_557_1.text_.text = var_560_31
				arg_557_1.typewritter.percent = 0

				arg_557_1.typewritter:SetDirty()
				arg_557_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205134", "story_v_side_new_1102205.awb") ~= 0 then
					local var_560_35 = manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205134", "story_v_side_new_1102205.awb") / 1000

					if var_560_35 + var_560_27 > arg_557_1.duration_ then
						arg_557_1.duration_ = var_560_35 + var_560_27
					end

					if var_560_30.prefab_name ~= "" and arg_557_1.actors_[var_560_30.prefab_name] ~= nil then
						local var_560_36 = LuaForUtil.PlayVoiceWithCriLipsync(arg_557_1.actors_[var_560_30.prefab_name].transform, "story_v_side_new_1102205", "1102205134", "story_v_side_new_1102205.awb")

						arg_557_1:RecordAudio("1102205134", var_560_36)
						arg_557_1:RecordAudio("1102205134", var_560_36)
					else
						arg_557_1:AudioAction("play", "voice", "story_v_side_new_1102205", "1102205134", "story_v_side_new_1102205.awb")
					end

					arg_557_1:RecordHistoryTalkVoice("story_v_side_new_1102205", "1102205134", "story_v_side_new_1102205.awb")
				end

				arg_557_1:RecordContent(arg_557_1.text_.text)
			end

			local var_560_37 = math.max(var_560_28, arg_557_1.talkMaxDuration)

			if var_560_27 <= arg_557_1.time_ and arg_557_1.time_ < var_560_27 + var_560_37 then
				arg_557_1.typewritter.percent = (arg_557_1.time_ - var_560_27) / var_560_37

				arg_557_1.typewritter:SetDirty()
			end

			if arg_557_1.time_ >= var_560_27 + var_560_37 and arg_557_1.time_ < var_560_27 + var_560_37 + arg_560_0 then
				arg_557_1.typewritter.percent = 1

				arg_557_1.typewritter:SetDirty()
				arg_557_1:ShowNextGo(true)
			end
		end

		arg_557_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1022ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_557_1:InitPlayNodeList()
	end,
	Play1102205135 = function(arg_563_0, arg_563_1)
		arg_563_1.time_ = 0
		arg_563_1.frameCnt_ = 0
		arg_563_1.state_ = "playing"
		arg_563_1.curTalkId_ = 1102205135
		arg_563_1.duration_ = 6.63

		SetActive(arg_563_1.tipsGo_, false)

		function arg_563_1.onSingleLineFinish_()
			arg_563_1.onSingleLineUpdate_ = nil
			arg_563_1.onSingleLineFinish_ = nil
			arg_563_1.state_ = "waiting"
		end

		function arg_563_1.playNext_(arg_565_0)
			if arg_565_0 == 1 then
				arg_563_0:Play1102205136(arg_563_1)
			end
		end

		function arg_563_1.onSingleLineUpdate_(arg_566_0)
			local var_566_0 = arg_563_1.actors_["1022ui_story"]
			local var_566_1 = 0

			if var_566_1 < arg_563_1.time_ and arg_563_1.time_ <= var_566_1 + arg_566_0 and not isNil(var_566_0) and arg_563_1.var_.characterEffect1022ui_story == nil then
				arg_563_1.var_.characterEffect1022ui_story = var_566_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_566_2 = 0.200000002980232

			if var_566_1 <= arg_563_1.time_ and arg_563_1.time_ < var_566_1 + var_566_2 and not isNil(var_566_0) then
				local var_566_3 = (arg_563_1.time_ - var_566_1) / var_566_2

				if arg_563_1.var_.characterEffect1022ui_story and not isNil(var_566_0) then
					local var_566_4 = Mathf.Lerp(0, 0.5, var_566_3)

					arg_563_1.var_.characterEffect1022ui_story.fillFlat = true
					arg_563_1.var_.characterEffect1022ui_story.fillRatio = var_566_4
				end
			end

			if arg_563_1.time_ >= var_566_1 + var_566_2 and arg_563_1.time_ < var_566_1 + var_566_2 + arg_566_0 and not isNil(var_566_0) and arg_563_1.var_.characterEffect1022ui_story then
				local var_566_5 = 0.5

				arg_563_1.var_.characterEffect1022ui_story.fillFlat = true
				arg_563_1.var_.characterEffect1022ui_story.fillRatio = var_566_5
			end

			local var_566_6 = 0
			local var_566_7 = 0.8

			if var_566_6 < arg_563_1.time_ and arg_563_1.time_ <= var_566_6 + arg_566_0 then
				arg_563_1.talkMaxDuration = 0
				arg_563_1.dialogCg_.alpha = 1

				arg_563_1.dialog_:SetActive(true)
				SetActive(arg_563_1.leftNameGo_, true)

				local var_566_8 = arg_563_1:FormatText(StoryNameCfg[1379].name)

				arg_563_1.leftNameTxt_.text = var_566_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_563_1.leftNameTxt_.transform)

				arg_563_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_563_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_563_1:RecordName(arg_563_1.leftNameTxt_.text)
				SetActive(arg_563_1.iconTrs_.gameObject, true)
				arg_563_1.iconController_:SetSelectedState("hero")

				arg_563_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_clerkb")

				arg_563_1.callingController_:SetSelectedState("normal")

				arg_563_1.keyicon_.color = Color.New(1, 1, 1)
				arg_563_1.icon_.color = Color.New(1, 1, 1)

				local var_566_9 = arg_563_1:GetWordFromCfg(1102205135)
				local var_566_10 = arg_563_1:FormatText(var_566_9.content)

				arg_563_1.text_.text = var_566_10

				LuaForUtil.ClearLinePrefixSymbol(arg_563_1.text_)

				local var_566_11 = 32
				local var_566_12 = utf8.len(var_566_10)
				local var_566_13 = var_566_11 <= 0 and var_566_7 or var_566_7 * (var_566_12 / var_566_11)

				if var_566_13 > 0 and var_566_7 < var_566_13 then
					arg_563_1.talkMaxDuration = var_566_13

					if var_566_13 + var_566_6 > arg_563_1.duration_ then
						arg_563_1.duration_ = var_566_13 + var_566_6
					end
				end

				arg_563_1.text_.text = var_566_10
				arg_563_1.typewritter.percent = 0

				arg_563_1.typewritter:SetDirty()
				arg_563_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205135", "story_v_side_new_1102205.awb") ~= 0 then
					local var_566_14 = manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205135", "story_v_side_new_1102205.awb") / 1000

					if var_566_14 + var_566_6 > arg_563_1.duration_ then
						arg_563_1.duration_ = var_566_14 + var_566_6
					end

					if var_566_9.prefab_name ~= "" and arg_563_1.actors_[var_566_9.prefab_name] ~= nil then
						local var_566_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_563_1.actors_[var_566_9.prefab_name].transform, "story_v_side_new_1102205", "1102205135", "story_v_side_new_1102205.awb")

						arg_563_1:RecordAudio("1102205135", var_566_15)
						arg_563_1:RecordAudio("1102205135", var_566_15)
					else
						arg_563_1:AudioAction("play", "voice", "story_v_side_new_1102205", "1102205135", "story_v_side_new_1102205.awb")
					end

					arg_563_1:RecordHistoryTalkVoice("story_v_side_new_1102205", "1102205135", "story_v_side_new_1102205.awb")
				end

				arg_563_1:RecordContent(arg_563_1.text_.text)
			end

			local var_566_16 = math.max(var_566_7, arg_563_1.talkMaxDuration)

			if var_566_6 <= arg_563_1.time_ and arg_563_1.time_ < var_566_6 + var_566_16 then
				arg_563_1.typewritter.percent = (arg_563_1.time_ - var_566_6) / var_566_16

				arg_563_1.typewritter:SetDirty()
			end

			if arg_563_1.time_ >= var_566_6 + var_566_16 and arg_563_1.time_ < var_566_6 + var_566_16 + arg_566_0 then
				arg_563_1.typewritter.percent = 1

				arg_563_1.typewritter:SetDirty()
				arg_563_1:ShowNextGo(true)
			end
		end

		arg_563_1.nodeConfigList_ = {}

		arg_563_1:InitPlayNodeList()
	end,
	Play1102205136 = function(arg_567_0, arg_567_1)
		arg_567_1.time_ = 0
		arg_567_1.frameCnt_ = 0
		arg_567_1.state_ = "playing"
		arg_567_1.curTalkId_ = 1102205136
		arg_567_1.duration_ = 5

		SetActive(arg_567_1.tipsGo_, false)

		function arg_567_1.onSingleLineFinish_()
			arg_567_1.onSingleLineUpdate_ = nil
			arg_567_1.onSingleLineFinish_ = nil
			arg_567_1.state_ = "waiting"
		end

		function arg_567_1.playNext_(arg_569_0)
			if arg_569_0 == 1 then
				arg_567_0:Play1102205137(arg_567_1)
			end
		end

		function arg_567_1.onSingleLineUpdate_(arg_570_0)
			local var_570_0 = 0
			local var_570_1 = 0.7

			if var_570_0 < arg_567_1.time_ and arg_567_1.time_ <= var_570_0 + arg_570_0 then
				arg_567_1.talkMaxDuration = 0
				arg_567_1.dialogCg_.alpha = 1

				arg_567_1.dialog_:SetActive(true)
				SetActive(arg_567_1.leftNameGo_, false)

				arg_567_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_567_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_567_1:RecordName(arg_567_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_567_1.iconTrs_.gameObject, false)
				arg_567_1.callingController_:SetSelectedState("normal")

				local var_570_2 = arg_567_1:GetWordFromCfg(1102205136)
				local var_570_3 = arg_567_1:FormatText(var_570_2.content)

				arg_567_1.text_.text = var_570_3

				LuaForUtil.ClearLinePrefixSymbol(arg_567_1.text_)

				local var_570_4 = 28
				local var_570_5 = utf8.len(var_570_3)
				local var_570_6 = var_570_4 <= 0 and var_570_1 or var_570_1 * (var_570_5 / var_570_4)

				if var_570_6 > 0 and var_570_1 < var_570_6 then
					arg_567_1.talkMaxDuration = var_570_6

					if var_570_6 + var_570_0 > arg_567_1.duration_ then
						arg_567_1.duration_ = var_570_6 + var_570_0
					end
				end

				arg_567_1.text_.text = var_570_3
				arg_567_1.typewritter.percent = 0

				arg_567_1.typewritter:SetDirty()
				arg_567_1:ShowNextGo(false)
				arg_567_1:RecordContent(arg_567_1.text_.text)
			end

			local var_570_7 = math.max(var_570_1, arg_567_1.talkMaxDuration)

			if var_570_0 <= arg_567_1.time_ and arg_567_1.time_ < var_570_0 + var_570_7 then
				arg_567_1.typewritter.percent = (arg_567_1.time_ - var_570_0) / var_570_7

				arg_567_1.typewritter:SetDirty()
			end

			if arg_567_1.time_ >= var_570_0 + var_570_7 and arg_567_1.time_ < var_570_0 + var_570_7 + arg_570_0 then
				arg_567_1.typewritter.percent = 1

				arg_567_1.typewritter:SetDirty()
				arg_567_1:ShowNextGo(true)
			end
		end

		arg_567_1.nodeConfigList_ = {}

		arg_567_1:InitPlayNodeList()
	end,
	Play1102205137 = function(arg_571_0, arg_571_1)
		arg_571_1.time_ = 0
		arg_571_1.frameCnt_ = 0
		arg_571_1.state_ = "playing"
		arg_571_1.curTalkId_ = 1102205137
		arg_571_1.duration_ = 2.13

		SetActive(arg_571_1.tipsGo_, false)

		function arg_571_1.onSingleLineFinish_()
			arg_571_1.onSingleLineUpdate_ = nil
			arg_571_1.onSingleLineFinish_ = nil
			arg_571_1.state_ = "waiting"
		end

		function arg_571_1.playNext_(arg_573_0)
			if arg_573_0 == 1 then
				arg_571_0:Play1102205138(arg_571_1)
			end
		end

		function arg_571_1.onSingleLineUpdate_(arg_574_0)
			local var_574_0 = arg_571_1.actors_["1022ui_story"]
			local var_574_1 = 0

			if var_574_1 < arg_571_1.time_ and arg_571_1.time_ <= var_574_1 + arg_574_0 and not isNil(var_574_0) and arg_571_1.var_.characterEffect1022ui_story == nil then
				arg_571_1.var_.characterEffect1022ui_story = var_574_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_574_2 = 0.200000002980232

			if var_574_1 <= arg_571_1.time_ and arg_571_1.time_ < var_574_1 + var_574_2 and not isNil(var_574_0) then
				local var_574_3 = (arg_571_1.time_ - var_574_1) / var_574_2

				if arg_571_1.var_.characterEffect1022ui_story and not isNil(var_574_0) then
					arg_571_1.var_.characterEffect1022ui_story.fillFlat = false
				end
			end

			if arg_571_1.time_ >= var_574_1 + var_574_2 and arg_571_1.time_ < var_574_1 + var_574_2 + arg_574_0 and not isNil(var_574_0) and arg_571_1.var_.characterEffect1022ui_story then
				arg_571_1.var_.characterEffect1022ui_story.fillFlat = false
			end

			local var_574_4 = 0

			if var_574_4 < arg_571_1.time_ and arg_571_1.time_ <= var_574_4 + arg_574_0 then
				arg_571_1:PlayTimeline("1022ui_story", "StoryTimeline/CharAction/story1022/story1022action/1022action4_1")
			end

			local var_574_5 = 0

			if var_574_5 < arg_571_1.time_ and arg_571_1.time_ <= var_574_5 + arg_574_0 then
				arg_571_1:PlayTimeline("1022ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_574_6 = 0
			local var_574_7 = 0.225

			if var_574_6 < arg_571_1.time_ and arg_571_1.time_ <= var_574_6 + arg_574_0 then
				arg_571_1.talkMaxDuration = 0
				arg_571_1.dialogCg_.alpha = 1

				arg_571_1.dialog_:SetActive(true)
				SetActive(arg_571_1.leftNameGo_, true)

				local var_574_8 = arg_571_1:FormatText(StoryNameCfg[259].name)

				arg_571_1.leftNameTxt_.text = var_574_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_571_1.leftNameTxt_.transform)

				arg_571_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_571_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_571_1:RecordName(arg_571_1.leftNameTxt_.text)
				SetActive(arg_571_1.iconTrs_.gameObject, false)
				arg_571_1.callingController_:SetSelectedState("normal")

				local var_574_9 = arg_571_1:GetWordFromCfg(1102205137)
				local var_574_10 = arg_571_1:FormatText(var_574_9.content)

				arg_571_1.text_.text = var_574_10

				LuaForUtil.ClearLinePrefixSymbol(arg_571_1.text_)

				local var_574_11 = 9
				local var_574_12 = utf8.len(var_574_10)
				local var_574_13 = var_574_11 <= 0 and var_574_7 or var_574_7 * (var_574_12 / var_574_11)

				if var_574_13 > 0 and var_574_7 < var_574_13 then
					arg_571_1.talkMaxDuration = var_574_13

					if var_574_13 + var_574_6 > arg_571_1.duration_ then
						arg_571_1.duration_ = var_574_13 + var_574_6
					end
				end

				arg_571_1.text_.text = var_574_10
				arg_571_1.typewritter.percent = 0

				arg_571_1.typewritter:SetDirty()
				arg_571_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205137", "story_v_side_new_1102205.awb") ~= 0 then
					local var_574_14 = manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205137", "story_v_side_new_1102205.awb") / 1000

					if var_574_14 + var_574_6 > arg_571_1.duration_ then
						arg_571_1.duration_ = var_574_14 + var_574_6
					end

					if var_574_9.prefab_name ~= "" and arg_571_1.actors_[var_574_9.prefab_name] ~= nil then
						local var_574_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_571_1.actors_[var_574_9.prefab_name].transform, "story_v_side_new_1102205", "1102205137", "story_v_side_new_1102205.awb")

						arg_571_1:RecordAudio("1102205137", var_574_15)
						arg_571_1:RecordAudio("1102205137", var_574_15)
					else
						arg_571_1:AudioAction("play", "voice", "story_v_side_new_1102205", "1102205137", "story_v_side_new_1102205.awb")
					end

					arg_571_1:RecordHistoryTalkVoice("story_v_side_new_1102205", "1102205137", "story_v_side_new_1102205.awb")
				end

				arg_571_1:RecordContent(arg_571_1.text_.text)
			end

			local var_574_16 = math.max(var_574_7, arg_571_1.talkMaxDuration)

			if var_574_6 <= arg_571_1.time_ and arg_571_1.time_ < var_574_6 + var_574_16 then
				arg_571_1.typewritter.percent = (arg_571_1.time_ - var_574_6) / var_574_16

				arg_571_1.typewritter:SetDirty()
			end

			if arg_571_1.time_ >= var_574_6 + var_574_16 and arg_571_1.time_ < var_574_6 + var_574_16 + arg_574_0 then
				arg_571_1.typewritter.percent = 1

				arg_571_1.typewritter:SetDirty()
				arg_571_1:ShowNextGo(true)
			end
		end

		arg_571_1.nodeConfigList_ = {}

		arg_571_1:InitPlayNodeList()
	end,
	Play1102205138 = function(arg_575_0, arg_575_1)
		arg_575_1.time_ = 0
		arg_575_1.frameCnt_ = 0
		arg_575_1.state_ = "playing"
		arg_575_1.curTalkId_ = 1102205138
		arg_575_1.duration_ = 5.67

		SetActive(arg_575_1.tipsGo_, false)

		function arg_575_1.onSingleLineFinish_()
			arg_575_1.onSingleLineUpdate_ = nil
			arg_575_1.onSingleLineFinish_ = nil
			arg_575_1.state_ = "waiting"
		end

		function arg_575_1.playNext_(arg_577_0)
			if arg_577_0 == 1 then
				arg_575_0:Play1102205139(arg_575_1)
			end
		end

		function arg_575_1.onSingleLineUpdate_(arg_578_0)
			local var_578_0 = arg_575_1.actors_["1022ui_story"]
			local var_578_1 = 0

			if var_578_1 < arg_575_1.time_ and arg_575_1.time_ <= var_578_1 + arg_578_0 and not isNil(var_578_0) and arg_575_1.var_.characterEffect1022ui_story == nil then
				arg_575_1.var_.characterEffect1022ui_story = var_578_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_578_2 = 0.200000002980232

			if var_578_1 <= arg_575_1.time_ and arg_575_1.time_ < var_578_1 + var_578_2 and not isNil(var_578_0) then
				local var_578_3 = (arg_575_1.time_ - var_578_1) / var_578_2

				if arg_575_1.var_.characterEffect1022ui_story and not isNil(var_578_0) then
					local var_578_4 = Mathf.Lerp(0, 0.5, var_578_3)

					arg_575_1.var_.characterEffect1022ui_story.fillFlat = true
					arg_575_1.var_.characterEffect1022ui_story.fillRatio = var_578_4
				end
			end

			if arg_575_1.time_ >= var_578_1 + var_578_2 and arg_575_1.time_ < var_578_1 + var_578_2 + arg_578_0 and not isNil(var_578_0) and arg_575_1.var_.characterEffect1022ui_story then
				local var_578_5 = 0.5

				arg_575_1.var_.characterEffect1022ui_story.fillFlat = true
				arg_575_1.var_.characterEffect1022ui_story.fillRatio = var_578_5
			end

			local var_578_6 = 0
			local var_578_7 = 0.625

			if var_578_6 < arg_575_1.time_ and arg_575_1.time_ <= var_578_6 + arg_578_0 then
				arg_575_1.talkMaxDuration = 0
				arg_575_1.dialogCg_.alpha = 1

				arg_575_1.dialog_:SetActive(true)
				SetActive(arg_575_1.leftNameGo_, true)

				local var_578_8 = arg_575_1:FormatText(StoryNameCfg[1379].name)

				arg_575_1.leftNameTxt_.text = var_578_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_575_1.leftNameTxt_.transform)

				arg_575_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_575_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_575_1:RecordName(arg_575_1.leftNameTxt_.text)
				SetActive(arg_575_1.iconTrs_.gameObject, true)
				arg_575_1.iconController_:SetSelectedState("hero")

				arg_575_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_clerkb")

				arg_575_1.callingController_:SetSelectedState("normal")

				arg_575_1.keyicon_.color = Color.New(1, 1, 1)
				arg_575_1.icon_.color = Color.New(1, 1, 1)

				local var_578_9 = arg_575_1:GetWordFromCfg(1102205138)
				local var_578_10 = arg_575_1:FormatText(var_578_9.content)

				arg_575_1.text_.text = var_578_10

				LuaForUtil.ClearLinePrefixSymbol(arg_575_1.text_)

				local var_578_11 = 25
				local var_578_12 = utf8.len(var_578_10)
				local var_578_13 = var_578_11 <= 0 and var_578_7 or var_578_7 * (var_578_12 / var_578_11)

				if var_578_13 > 0 and var_578_7 < var_578_13 then
					arg_575_1.talkMaxDuration = var_578_13

					if var_578_13 + var_578_6 > arg_575_1.duration_ then
						arg_575_1.duration_ = var_578_13 + var_578_6
					end
				end

				arg_575_1.text_.text = var_578_10
				arg_575_1.typewritter.percent = 0

				arg_575_1.typewritter:SetDirty()
				arg_575_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205138", "story_v_side_new_1102205.awb") ~= 0 then
					local var_578_14 = manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205138", "story_v_side_new_1102205.awb") / 1000

					if var_578_14 + var_578_6 > arg_575_1.duration_ then
						arg_575_1.duration_ = var_578_14 + var_578_6
					end

					if var_578_9.prefab_name ~= "" and arg_575_1.actors_[var_578_9.prefab_name] ~= nil then
						local var_578_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_575_1.actors_[var_578_9.prefab_name].transform, "story_v_side_new_1102205", "1102205138", "story_v_side_new_1102205.awb")

						arg_575_1:RecordAudio("1102205138", var_578_15)
						arg_575_1:RecordAudio("1102205138", var_578_15)
					else
						arg_575_1:AudioAction("play", "voice", "story_v_side_new_1102205", "1102205138", "story_v_side_new_1102205.awb")
					end

					arg_575_1:RecordHistoryTalkVoice("story_v_side_new_1102205", "1102205138", "story_v_side_new_1102205.awb")
				end

				arg_575_1:RecordContent(arg_575_1.text_.text)
			end

			local var_578_16 = math.max(var_578_7, arg_575_1.talkMaxDuration)

			if var_578_6 <= arg_575_1.time_ and arg_575_1.time_ < var_578_6 + var_578_16 then
				arg_575_1.typewritter.percent = (arg_575_1.time_ - var_578_6) / var_578_16

				arg_575_1.typewritter:SetDirty()
			end

			if arg_575_1.time_ >= var_578_6 + var_578_16 and arg_575_1.time_ < var_578_6 + var_578_16 + arg_578_0 then
				arg_575_1.typewritter.percent = 1

				arg_575_1.typewritter:SetDirty()
				arg_575_1:ShowNextGo(true)
			end
		end

		arg_575_1.nodeConfigList_ = {}

		arg_575_1:InitPlayNodeList()
	end,
	Play1102205139 = function(arg_579_0, arg_579_1)
		arg_579_1.time_ = 0
		arg_579_1.frameCnt_ = 0
		arg_579_1.state_ = "playing"
		arg_579_1.curTalkId_ = 1102205139
		arg_579_1.duration_ = 5

		SetActive(arg_579_1.tipsGo_, false)

		function arg_579_1.onSingleLineFinish_()
			arg_579_1.onSingleLineUpdate_ = nil
			arg_579_1.onSingleLineFinish_ = nil
			arg_579_1.state_ = "waiting"
		end

		function arg_579_1.playNext_(arg_581_0)
			if arg_581_0 == 1 then
				arg_579_0:Play1102205140(arg_579_1)
			end
		end

		function arg_579_1.onSingleLineUpdate_(arg_582_0)
			local var_582_0 = 0
			local var_582_1 = 0.8

			if var_582_0 < arg_579_1.time_ and arg_579_1.time_ <= var_582_0 + arg_582_0 then
				arg_579_1.talkMaxDuration = 0
				arg_579_1.dialogCg_.alpha = 1

				arg_579_1.dialog_:SetActive(true)
				SetActive(arg_579_1.leftNameGo_, true)

				local var_582_2 = arg_579_1:FormatText(StoryNameCfg[7].name)

				arg_579_1.leftNameTxt_.text = var_582_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_579_1.leftNameTxt_.transform)

				arg_579_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_579_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_579_1:RecordName(arg_579_1.leftNameTxt_.text)
				SetActive(arg_579_1.iconTrs_.gameObject, true)
				arg_579_1.iconController_:SetSelectedState("hero")

				arg_579_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_579_1.callingController_:SetSelectedState("normal")

				arg_579_1.keyicon_.color = Color.New(1, 1, 1)
				arg_579_1.icon_.color = Color.New(1, 1, 1)

				local var_582_3 = arg_579_1:GetWordFromCfg(1102205139)
				local var_582_4 = arg_579_1:FormatText(var_582_3.content)

				arg_579_1.text_.text = var_582_4

				LuaForUtil.ClearLinePrefixSymbol(arg_579_1.text_)

				local var_582_5 = 32
				local var_582_6 = utf8.len(var_582_4)
				local var_582_7 = var_582_5 <= 0 and var_582_1 or var_582_1 * (var_582_6 / var_582_5)

				if var_582_7 > 0 and var_582_1 < var_582_7 then
					arg_579_1.talkMaxDuration = var_582_7

					if var_582_7 + var_582_0 > arg_579_1.duration_ then
						arg_579_1.duration_ = var_582_7 + var_582_0
					end
				end

				arg_579_1.text_.text = var_582_4
				arg_579_1.typewritter.percent = 0

				arg_579_1.typewritter:SetDirty()
				arg_579_1:ShowNextGo(false)
				arg_579_1:RecordContent(arg_579_1.text_.text)
			end

			local var_582_8 = math.max(var_582_1, arg_579_1.talkMaxDuration)

			if var_582_0 <= arg_579_1.time_ and arg_579_1.time_ < var_582_0 + var_582_8 then
				arg_579_1.typewritter.percent = (arg_579_1.time_ - var_582_0) / var_582_8

				arg_579_1.typewritter:SetDirty()
			end

			if arg_579_1.time_ >= var_582_0 + var_582_8 and arg_579_1.time_ < var_582_0 + var_582_8 + arg_582_0 then
				arg_579_1.typewritter.percent = 1

				arg_579_1.typewritter:SetDirty()
				arg_579_1:ShowNextGo(true)
			end
		end

		arg_579_1.nodeConfigList_ = {}

		arg_579_1:InitPlayNodeList()
	end,
	Play1102205140 = function(arg_583_0, arg_583_1)
		arg_583_1.time_ = 0
		arg_583_1.frameCnt_ = 0
		arg_583_1.state_ = "playing"
		arg_583_1.curTalkId_ = 1102205140
		arg_583_1.duration_ = 5

		SetActive(arg_583_1.tipsGo_, false)

		function arg_583_1.onSingleLineFinish_()
			arg_583_1.onSingleLineUpdate_ = nil
			arg_583_1.onSingleLineFinish_ = nil
			arg_583_1.state_ = "waiting"
		end

		function arg_583_1.playNext_(arg_585_0)
			if arg_585_0 == 1 then
				arg_583_0:Play1102205141(arg_583_1)
			end
		end

		function arg_583_1.onSingleLineUpdate_(arg_586_0)
			local var_586_0 = arg_583_1.actors_["1022ui_story"].transform
			local var_586_1 = 0

			if var_586_1 < arg_583_1.time_ and arg_583_1.time_ <= var_586_1 + arg_586_0 then
				arg_583_1.var_.moveOldPos1022ui_story = var_586_0.localPosition
			end

			local var_586_2 = 0.001

			if var_586_1 <= arg_583_1.time_ and arg_583_1.time_ < var_586_1 + var_586_2 then
				local var_586_3 = (arg_583_1.time_ - var_586_1) / var_586_2
				local var_586_4 = Vector3.New(0, 100, 0)

				var_586_0.localPosition = Vector3.Lerp(arg_583_1.var_.moveOldPos1022ui_story, var_586_4, var_586_3)

				local var_586_5 = manager.ui.mainCamera.transform.position - var_586_0.position

				var_586_0.forward = Vector3.New(var_586_5.x, var_586_5.y, var_586_5.z)

				local var_586_6 = var_586_0.localEulerAngles

				var_586_6.z = 0
				var_586_6.x = 0
				var_586_0.localEulerAngles = var_586_6
			end

			if arg_583_1.time_ >= var_586_1 + var_586_2 and arg_583_1.time_ < var_586_1 + var_586_2 + arg_586_0 then
				var_586_0.localPosition = Vector3.New(0, 100, 0)

				local var_586_7 = manager.ui.mainCamera.transform.position - var_586_0.position

				var_586_0.forward = Vector3.New(var_586_7.x, var_586_7.y, var_586_7.z)

				local var_586_8 = var_586_0.localEulerAngles

				var_586_8.z = 0
				var_586_8.x = 0
				var_586_0.localEulerAngles = var_586_8
			end

			local var_586_9 = 0.034000001847744
			local var_586_10 = 1

			if var_586_9 < arg_583_1.time_ and arg_583_1.time_ <= var_586_9 + arg_586_0 then
				local var_586_11 = "play"
				local var_586_12 = "effect"

				arg_583_1:AudioAction(var_586_11, var_586_12, "se_story_1310", "se_story_1310_footstep01", "")
			end

			local var_586_13 = 0
			local var_586_14 = 0.475

			if var_586_13 < arg_583_1.time_ and arg_583_1.time_ <= var_586_13 + arg_586_0 then
				arg_583_1.talkMaxDuration = 0
				arg_583_1.dialogCg_.alpha = 1

				arg_583_1.dialog_:SetActive(true)
				SetActive(arg_583_1.leftNameGo_, false)

				arg_583_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_583_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_583_1:RecordName(arg_583_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_583_1.iconTrs_.gameObject, false)
				arg_583_1.callingController_:SetSelectedState("normal")

				local var_586_15 = arg_583_1:GetWordFromCfg(1102205140)
				local var_586_16 = arg_583_1:FormatText(var_586_15.content)

				arg_583_1.text_.text = var_586_16

				LuaForUtil.ClearLinePrefixSymbol(arg_583_1.text_)

				local var_586_17 = 19
				local var_586_18 = utf8.len(var_586_16)
				local var_586_19 = var_586_17 <= 0 and var_586_14 or var_586_14 * (var_586_18 / var_586_17)

				if var_586_19 > 0 and var_586_14 < var_586_19 then
					arg_583_1.talkMaxDuration = var_586_19

					if var_586_19 + var_586_13 > arg_583_1.duration_ then
						arg_583_1.duration_ = var_586_19 + var_586_13
					end
				end

				arg_583_1.text_.text = var_586_16
				arg_583_1.typewritter.percent = 0

				arg_583_1.typewritter:SetDirty()
				arg_583_1:ShowNextGo(false)
				arg_583_1:RecordContent(arg_583_1.text_.text)
			end

			local var_586_20 = math.max(var_586_14, arg_583_1.talkMaxDuration)

			if var_586_13 <= arg_583_1.time_ and arg_583_1.time_ < var_586_13 + var_586_20 then
				arg_583_1.typewritter.percent = (arg_583_1.time_ - var_586_13) / var_586_20

				arg_583_1.typewritter:SetDirty()
			end

			if arg_583_1.time_ >= var_586_13 + var_586_20 and arg_583_1.time_ < var_586_13 + var_586_20 + arg_586_0 then
				arg_583_1.typewritter.percent = 1

				arg_583_1.typewritter:SetDirty()
				arg_583_1:ShowNextGo(true)
			end
		end

		arg_583_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1022ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_583_1:InitPlayNodeList()
	end,
	Play1102205141 = function(arg_587_0, arg_587_1)
		arg_587_1.time_ = 0
		arg_587_1.frameCnt_ = 0
		arg_587_1.state_ = "playing"
		arg_587_1.curTalkId_ = 1102205141
		arg_587_1.duration_ = 4.97

		SetActive(arg_587_1.tipsGo_, false)

		function arg_587_1.onSingleLineFinish_()
			arg_587_1.onSingleLineUpdate_ = nil
			arg_587_1.onSingleLineFinish_ = nil
			arg_587_1.state_ = "waiting"
		end

		function arg_587_1.playNext_(arg_589_0)
			if arg_589_0 == 1 then
				arg_587_0:Play1102205142(arg_587_1)
			end
		end

		function arg_587_1.onSingleLineUpdate_(arg_590_0)
			local var_590_0 = 0
			local var_590_1 = 0.55

			if var_590_0 < arg_587_1.time_ and arg_587_1.time_ <= var_590_0 + arg_590_0 then
				arg_587_1.talkMaxDuration = 0
				arg_587_1.dialogCg_.alpha = 1

				arg_587_1.dialog_:SetActive(true)
				SetActive(arg_587_1.leftNameGo_, true)

				local var_590_2 = arg_587_1:FormatText(StoryNameCfg[1379].name)

				arg_587_1.leftNameTxt_.text = var_590_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_587_1.leftNameTxt_.transform)

				arg_587_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_587_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_587_1:RecordName(arg_587_1.leftNameTxt_.text)
				SetActive(arg_587_1.iconTrs_.gameObject, true)
				arg_587_1.iconController_:SetSelectedState("hero")

				arg_587_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_clerkb")

				arg_587_1.callingController_:SetSelectedState("normal")

				arg_587_1.keyicon_.color = Color.New(1, 1, 1)
				arg_587_1.icon_.color = Color.New(1, 1, 1)

				local var_590_3 = arg_587_1:GetWordFromCfg(1102205141)
				local var_590_4 = arg_587_1:FormatText(var_590_3.content)

				arg_587_1.text_.text = var_590_4

				LuaForUtil.ClearLinePrefixSymbol(arg_587_1.text_)

				local var_590_5 = 22
				local var_590_6 = utf8.len(var_590_4)
				local var_590_7 = var_590_5 <= 0 and var_590_1 or var_590_1 * (var_590_6 / var_590_5)

				if var_590_7 > 0 and var_590_1 < var_590_7 then
					arg_587_1.talkMaxDuration = var_590_7

					if var_590_7 + var_590_0 > arg_587_1.duration_ then
						arg_587_1.duration_ = var_590_7 + var_590_0
					end
				end

				arg_587_1.text_.text = var_590_4
				arg_587_1.typewritter.percent = 0

				arg_587_1.typewritter:SetDirty()
				arg_587_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205141", "story_v_side_new_1102205.awb") ~= 0 then
					local var_590_8 = manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205141", "story_v_side_new_1102205.awb") / 1000

					if var_590_8 + var_590_0 > arg_587_1.duration_ then
						arg_587_1.duration_ = var_590_8 + var_590_0
					end

					if var_590_3.prefab_name ~= "" and arg_587_1.actors_[var_590_3.prefab_name] ~= nil then
						local var_590_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_587_1.actors_[var_590_3.prefab_name].transform, "story_v_side_new_1102205", "1102205141", "story_v_side_new_1102205.awb")

						arg_587_1:RecordAudio("1102205141", var_590_9)
						arg_587_1:RecordAudio("1102205141", var_590_9)
					else
						arg_587_1:AudioAction("play", "voice", "story_v_side_new_1102205", "1102205141", "story_v_side_new_1102205.awb")
					end

					arg_587_1:RecordHistoryTalkVoice("story_v_side_new_1102205", "1102205141", "story_v_side_new_1102205.awb")
				end

				arg_587_1:RecordContent(arg_587_1.text_.text)
			end

			local var_590_10 = math.max(var_590_1, arg_587_1.talkMaxDuration)

			if var_590_0 <= arg_587_1.time_ and arg_587_1.time_ < var_590_0 + var_590_10 then
				arg_587_1.typewritter.percent = (arg_587_1.time_ - var_590_0) / var_590_10

				arg_587_1.typewritter:SetDirty()
			end

			if arg_587_1.time_ >= var_590_0 + var_590_10 and arg_587_1.time_ < var_590_0 + var_590_10 + arg_590_0 then
				arg_587_1.typewritter.percent = 1

				arg_587_1.typewritter:SetDirty()
				arg_587_1:ShowNextGo(true)
			end
		end

		arg_587_1.nodeConfigList_ = {}

		arg_587_1:InitPlayNodeList()
	end,
	Play1102205142 = function(arg_591_0, arg_591_1)
		arg_591_1.time_ = 0
		arg_591_1.frameCnt_ = 0
		arg_591_1.state_ = "playing"
		arg_591_1.curTalkId_ = 1102205142
		arg_591_1.duration_ = 2.03

		SetActive(arg_591_1.tipsGo_, false)

		function arg_591_1.onSingleLineFinish_()
			arg_591_1.onSingleLineUpdate_ = nil
			arg_591_1.onSingleLineFinish_ = nil
			arg_591_1.state_ = "waiting"
		end

		function arg_591_1.playNext_(arg_593_0)
			if arg_593_0 == 1 then
				arg_591_0:Play1102205143(arg_591_1)
			end
		end

		function arg_591_1.onSingleLineUpdate_(arg_594_0)
			local var_594_0 = 0
			local var_594_1 = 0.25

			if var_594_0 < arg_591_1.time_ and arg_591_1.time_ <= var_594_0 + arg_594_0 then
				arg_591_1.talkMaxDuration = 0
				arg_591_1.dialogCg_.alpha = 1

				arg_591_1.dialog_:SetActive(true)
				SetActive(arg_591_1.leftNameGo_, true)

				local var_594_2 = arg_591_1:FormatText(StoryNameCfg[1379].name)

				arg_591_1.leftNameTxt_.text = var_594_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_591_1.leftNameTxt_.transform)

				arg_591_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_591_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_591_1:RecordName(arg_591_1.leftNameTxt_.text)
				SetActive(arg_591_1.iconTrs_.gameObject, true)
				arg_591_1.iconController_:SetSelectedState("hero")

				arg_591_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_clerkb")

				arg_591_1.callingController_:SetSelectedState("normal")

				arg_591_1.keyicon_.color = Color.New(1, 1, 1)
				arg_591_1.icon_.color = Color.New(1, 1, 1)

				local var_594_3 = arg_591_1:GetWordFromCfg(1102205142)
				local var_594_4 = arg_591_1:FormatText(var_594_3.content)

				arg_591_1.text_.text = var_594_4

				LuaForUtil.ClearLinePrefixSymbol(arg_591_1.text_)

				local var_594_5 = 10
				local var_594_6 = utf8.len(var_594_4)
				local var_594_7 = var_594_5 <= 0 and var_594_1 or var_594_1 * (var_594_6 / var_594_5)

				if var_594_7 > 0 and var_594_1 < var_594_7 then
					arg_591_1.talkMaxDuration = var_594_7

					if var_594_7 + var_594_0 > arg_591_1.duration_ then
						arg_591_1.duration_ = var_594_7 + var_594_0
					end
				end

				arg_591_1.text_.text = var_594_4
				arg_591_1.typewritter.percent = 0

				arg_591_1.typewritter:SetDirty()
				arg_591_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205142", "story_v_side_new_1102205.awb") ~= 0 then
					local var_594_8 = manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205142", "story_v_side_new_1102205.awb") / 1000

					if var_594_8 + var_594_0 > arg_591_1.duration_ then
						arg_591_1.duration_ = var_594_8 + var_594_0
					end

					if var_594_3.prefab_name ~= "" and arg_591_1.actors_[var_594_3.prefab_name] ~= nil then
						local var_594_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_591_1.actors_[var_594_3.prefab_name].transform, "story_v_side_new_1102205", "1102205142", "story_v_side_new_1102205.awb")

						arg_591_1:RecordAudio("1102205142", var_594_9)
						arg_591_1:RecordAudio("1102205142", var_594_9)
					else
						arg_591_1:AudioAction("play", "voice", "story_v_side_new_1102205", "1102205142", "story_v_side_new_1102205.awb")
					end

					arg_591_1:RecordHistoryTalkVoice("story_v_side_new_1102205", "1102205142", "story_v_side_new_1102205.awb")
				end

				arg_591_1:RecordContent(arg_591_1.text_.text)
			end

			local var_594_10 = math.max(var_594_1, arg_591_1.talkMaxDuration)

			if var_594_0 <= arg_591_1.time_ and arg_591_1.time_ < var_594_0 + var_594_10 then
				arg_591_1.typewritter.percent = (arg_591_1.time_ - var_594_0) / var_594_10

				arg_591_1.typewritter:SetDirty()
			end

			if arg_591_1.time_ >= var_594_0 + var_594_10 and arg_591_1.time_ < var_594_0 + var_594_10 + arg_594_0 then
				arg_591_1.typewritter.percent = 1

				arg_591_1.typewritter:SetDirty()
				arg_591_1:ShowNextGo(true)
			end
		end

		arg_591_1.nodeConfigList_ = {}

		arg_591_1:InitPlayNodeList()
	end,
	Play1102205143 = function(arg_595_0, arg_595_1)
		arg_595_1.time_ = 0
		arg_595_1.frameCnt_ = 0
		arg_595_1.state_ = "playing"
		arg_595_1.curTalkId_ = 1102205143
		arg_595_1.duration_ = 5

		SetActive(arg_595_1.tipsGo_, false)

		function arg_595_1.onSingleLineFinish_()
			arg_595_1.onSingleLineUpdate_ = nil
			arg_595_1.onSingleLineFinish_ = nil
			arg_595_1.state_ = "waiting"
		end

		function arg_595_1.playNext_(arg_597_0)
			if arg_597_0 == 1 then
				arg_595_0:Play1102205144(arg_595_1)
			end
		end

		function arg_595_1.onSingleLineUpdate_(arg_598_0)
			local var_598_0 = 0
			local var_598_1 = 1.25

			if var_598_0 < arg_595_1.time_ and arg_595_1.time_ <= var_598_0 + arg_598_0 then
				arg_595_1.talkMaxDuration = 0
				arg_595_1.dialogCg_.alpha = 1

				arg_595_1.dialog_:SetActive(true)
				SetActive(arg_595_1.leftNameGo_, false)

				arg_595_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_595_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_595_1:RecordName(arg_595_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_595_1.iconTrs_.gameObject, false)
				arg_595_1.callingController_:SetSelectedState("normal")

				local var_598_2 = arg_595_1:GetWordFromCfg(1102205143)
				local var_598_3 = arg_595_1:FormatText(var_598_2.content)

				arg_595_1.text_.text = var_598_3

				LuaForUtil.ClearLinePrefixSymbol(arg_595_1.text_)

				local var_598_4 = 50
				local var_598_5 = utf8.len(var_598_3)
				local var_598_6 = var_598_4 <= 0 and var_598_1 or var_598_1 * (var_598_5 / var_598_4)

				if var_598_6 > 0 and var_598_1 < var_598_6 then
					arg_595_1.talkMaxDuration = var_598_6

					if var_598_6 + var_598_0 > arg_595_1.duration_ then
						arg_595_1.duration_ = var_598_6 + var_598_0
					end
				end

				arg_595_1.text_.text = var_598_3
				arg_595_1.typewritter.percent = 0

				arg_595_1.typewritter:SetDirty()
				arg_595_1:ShowNextGo(false)
				arg_595_1:RecordContent(arg_595_1.text_.text)
			end

			local var_598_7 = math.max(var_598_1, arg_595_1.talkMaxDuration)

			if var_598_0 <= arg_595_1.time_ and arg_595_1.time_ < var_598_0 + var_598_7 then
				arg_595_1.typewritter.percent = (arg_595_1.time_ - var_598_0) / var_598_7

				arg_595_1.typewritter:SetDirty()
			end

			if arg_595_1.time_ >= var_598_0 + var_598_7 and arg_595_1.time_ < var_598_0 + var_598_7 + arg_598_0 then
				arg_595_1.typewritter.percent = 1

				arg_595_1.typewritter:SetDirty()
				arg_595_1:ShowNextGo(true)
			end
		end

		arg_595_1.nodeConfigList_ = {}

		arg_595_1:InitPlayNodeList()
	end,
	Play1102205144 = function(arg_599_0, arg_599_1)
		arg_599_1.time_ = 0
		arg_599_1.frameCnt_ = 0
		arg_599_1.state_ = "playing"
		arg_599_1.curTalkId_ = 1102205144
		arg_599_1.duration_ = 8.03

		SetActive(arg_599_1.tipsGo_, false)

		function arg_599_1.onSingleLineFinish_()
			arg_599_1.onSingleLineUpdate_ = nil
			arg_599_1.onSingleLineFinish_ = nil
			arg_599_1.state_ = "waiting"
		end

		function arg_599_1.playNext_(arg_601_0)
			if arg_601_0 == 1 then
				arg_599_0:Play1102205145(arg_599_1)
			end
		end

		function arg_599_1.onSingleLineUpdate_(arg_602_0)
			local var_602_0 = 0
			local var_602_1 = 0.975

			if var_602_0 < arg_599_1.time_ and arg_599_1.time_ <= var_602_0 + arg_602_0 then
				arg_599_1.talkMaxDuration = 0
				arg_599_1.dialogCg_.alpha = 1

				arg_599_1.dialog_:SetActive(true)
				SetActive(arg_599_1.leftNameGo_, true)

				local var_602_2 = arg_599_1:FormatText(StoryNameCfg[1379].name)

				arg_599_1.leftNameTxt_.text = var_602_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_599_1.leftNameTxt_.transform)

				arg_599_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_599_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_599_1:RecordName(arg_599_1.leftNameTxt_.text)
				SetActive(arg_599_1.iconTrs_.gameObject, true)
				arg_599_1.iconController_:SetSelectedState("hero")

				arg_599_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_clerkb")

				arg_599_1.callingController_:SetSelectedState("normal")

				arg_599_1.keyicon_.color = Color.New(1, 1, 1)
				arg_599_1.icon_.color = Color.New(1, 1, 1)

				local var_602_3 = arg_599_1:GetWordFromCfg(1102205144)
				local var_602_4 = arg_599_1:FormatText(var_602_3.content)

				arg_599_1.text_.text = var_602_4

				LuaForUtil.ClearLinePrefixSymbol(arg_599_1.text_)

				local var_602_5 = 39
				local var_602_6 = utf8.len(var_602_4)
				local var_602_7 = var_602_5 <= 0 and var_602_1 or var_602_1 * (var_602_6 / var_602_5)

				if var_602_7 > 0 and var_602_1 < var_602_7 then
					arg_599_1.talkMaxDuration = var_602_7

					if var_602_7 + var_602_0 > arg_599_1.duration_ then
						arg_599_1.duration_ = var_602_7 + var_602_0
					end
				end

				arg_599_1.text_.text = var_602_4
				arg_599_1.typewritter.percent = 0

				arg_599_1.typewritter:SetDirty()
				arg_599_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205144", "story_v_side_new_1102205.awb") ~= 0 then
					local var_602_8 = manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205144", "story_v_side_new_1102205.awb") / 1000

					if var_602_8 + var_602_0 > arg_599_1.duration_ then
						arg_599_1.duration_ = var_602_8 + var_602_0
					end

					if var_602_3.prefab_name ~= "" and arg_599_1.actors_[var_602_3.prefab_name] ~= nil then
						local var_602_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_599_1.actors_[var_602_3.prefab_name].transform, "story_v_side_new_1102205", "1102205144", "story_v_side_new_1102205.awb")

						arg_599_1:RecordAudio("1102205144", var_602_9)
						arg_599_1:RecordAudio("1102205144", var_602_9)
					else
						arg_599_1:AudioAction("play", "voice", "story_v_side_new_1102205", "1102205144", "story_v_side_new_1102205.awb")
					end

					arg_599_1:RecordHistoryTalkVoice("story_v_side_new_1102205", "1102205144", "story_v_side_new_1102205.awb")
				end

				arg_599_1:RecordContent(arg_599_1.text_.text)
			end

			local var_602_10 = math.max(var_602_1, arg_599_1.talkMaxDuration)

			if var_602_0 <= arg_599_1.time_ and arg_599_1.time_ < var_602_0 + var_602_10 then
				arg_599_1.typewritter.percent = (arg_599_1.time_ - var_602_0) / var_602_10

				arg_599_1.typewritter:SetDirty()
			end

			if arg_599_1.time_ >= var_602_0 + var_602_10 and arg_599_1.time_ < var_602_0 + var_602_10 + arg_602_0 then
				arg_599_1.typewritter.percent = 1

				arg_599_1.typewritter:SetDirty()
				arg_599_1:ShowNextGo(true)
			end
		end

		arg_599_1.nodeConfigList_ = {}

		arg_599_1:InitPlayNodeList()
	end,
	Play1102205145 = function(arg_603_0, arg_603_1)
		arg_603_1.time_ = 0
		arg_603_1.frameCnt_ = 0
		arg_603_1.state_ = "playing"
		arg_603_1.curTalkId_ = 1102205145
		arg_603_1.duration_ = 9.83

		SetActive(arg_603_1.tipsGo_, false)

		function arg_603_1.onSingleLineFinish_()
			arg_603_1.onSingleLineUpdate_ = nil
			arg_603_1.onSingleLineFinish_ = nil
			arg_603_1.state_ = "waiting"
		end

		function arg_603_1.playNext_(arg_605_0)
			if arg_605_0 == 1 then
				arg_603_0:Play1102205146(arg_603_1)
			end
		end

		function arg_603_1.onSingleLineUpdate_(arg_606_0)
			local var_606_0 = 0
			local var_606_1 = 1.025

			if var_606_0 < arg_603_1.time_ and arg_603_1.time_ <= var_606_0 + arg_606_0 then
				arg_603_1.talkMaxDuration = 0
				arg_603_1.dialogCg_.alpha = 1

				arg_603_1.dialog_:SetActive(true)
				SetActive(arg_603_1.leftNameGo_, true)

				local var_606_2 = arg_603_1:FormatText(StoryNameCfg[1379].name)

				arg_603_1.leftNameTxt_.text = var_606_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_603_1.leftNameTxt_.transform)

				arg_603_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_603_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_603_1:RecordName(arg_603_1.leftNameTxt_.text)
				SetActive(arg_603_1.iconTrs_.gameObject, true)
				arg_603_1.iconController_:SetSelectedState("hero")

				arg_603_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_clerkb")

				arg_603_1.callingController_:SetSelectedState("normal")

				arg_603_1.keyicon_.color = Color.New(1, 1, 1)
				arg_603_1.icon_.color = Color.New(1, 1, 1)

				local var_606_3 = arg_603_1:GetWordFromCfg(1102205145)
				local var_606_4 = arg_603_1:FormatText(var_606_3.content)

				arg_603_1.text_.text = var_606_4

				LuaForUtil.ClearLinePrefixSymbol(arg_603_1.text_)

				local var_606_5 = 41
				local var_606_6 = utf8.len(var_606_4)
				local var_606_7 = var_606_5 <= 0 and var_606_1 or var_606_1 * (var_606_6 / var_606_5)

				if var_606_7 > 0 and var_606_1 < var_606_7 then
					arg_603_1.talkMaxDuration = var_606_7

					if var_606_7 + var_606_0 > arg_603_1.duration_ then
						arg_603_1.duration_ = var_606_7 + var_606_0
					end
				end

				arg_603_1.text_.text = var_606_4
				arg_603_1.typewritter.percent = 0

				arg_603_1.typewritter:SetDirty()
				arg_603_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205145", "story_v_side_new_1102205.awb") ~= 0 then
					local var_606_8 = manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205145", "story_v_side_new_1102205.awb") / 1000

					if var_606_8 + var_606_0 > arg_603_1.duration_ then
						arg_603_1.duration_ = var_606_8 + var_606_0
					end

					if var_606_3.prefab_name ~= "" and arg_603_1.actors_[var_606_3.prefab_name] ~= nil then
						local var_606_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_603_1.actors_[var_606_3.prefab_name].transform, "story_v_side_new_1102205", "1102205145", "story_v_side_new_1102205.awb")

						arg_603_1:RecordAudio("1102205145", var_606_9)
						arg_603_1:RecordAudio("1102205145", var_606_9)
					else
						arg_603_1:AudioAction("play", "voice", "story_v_side_new_1102205", "1102205145", "story_v_side_new_1102205.awb")
					end

					arg_603_1:RecordHistoryTalkVoice("story_v_side_new_1102205", "1102205145", "story_v_side_new_1102205.awb")
				end

				arg_603_1:RecordContent(arg_603_1.text_.text)
			end

			local var_606_10 = math.max(var_606_1, arg_603_1.talkMaxDuration)

			if var_606_0 <= arg_603_1.time_ and arg_603_1.time_ < var_606_0 + var_606_10 then
				arg_603_1.typewritter.percent = (arg_603_1.time_ - var_606_0) / var_606_10

				arg_603_1.typewritter:SetDirty()
			end

			if arg_603_1.time_ >= var_606_0 + var_606_10 and arg_603_1.time_ < var_606_0 + var_606_10 + arg_606_0 then
				arg_603_1.typewritter.percent = 1

				arg_603_1.typewritter:SetDirty()
				arg_603_1:ShowNextGo(true)
			end
		end

		arg_603_1.nodeConfigList_ = {}

		arg_603_1:InitPlayNodeList()
	end,
	Play1102205146 = function(arg_607_0, arg_607_1)
		arg_607_1.time_ = 0
		arg_607_1.frameCnt_ = 0
		arg_607_1.state_ = "playing"
		arg_607_1.curTalkId_ = 1102205146
		arg_607_1.duration_ = 3.47

		SetActive(arg_607_1.tipsGo_, false)

		function arg_607_1.onSingleLineFinish_()
			arg_607_1.onSingleLineUpdate_ = nil
			arg_607_1.onSingleLineFinish_ = nil
			arg_607_1.state_ = "waiting"
		end

		function arg_607_1.playNext_(arg_609_0)
			if arg_609_0 == 1 then
				arg_607_0:Play1102205147(arg_607_1)
			end
		end

		function arg_607_1.onSingleLineUpdate_(arg_610_0)
			local var_610_0 = arg_607_1.actors_["1022ui_story"].transform
			local var_610_1 = 0

			if var_610_1 < arg_607_1.time_ and arg_607_1.time_ <= var_610_1 + arg_610_0 then
				arg_607_1.var_.moveOldPos1022ui_story = var_610_0.localPosition
			end

			local var_610_2 = 0.001

			if var_610_1 <= arg_607_1.time_ and arg_607_1.time_ < var_610_1 + var_610_2 then
				local var_610_3 = (arg_607_1.time_ - var_610_1) / var_610_2
				local var_610_4 = Vector3.New(0, -1.08, -6)

				var_610_0.localPosition = Vector3.Lerp(arg_607_1.var_.moveOldPos1022ui_story, var_610_4, var_610_3)

				local var_610_5 = manager.ui.mainCamera.transform.position - var_610_0.position

				var_610_0.forward = Vector3.New(var_610_5.x, var_610_5.y, var_610_5.z)

				local var_610_6 = var_610_0.localEulerAngles

				var_610_6.z = 0
				var_610_6.x = 0
				var_610_0.localEulerAngles = var_610_6
			end

			if arg_607_1.time_ >= var_610_1 + var_610_2 and arg_607_1.time_ < var_610_1 + var_610_2 + arg_610_0 then
				var_610_0.localPosition = Vector3.New(0, -1.08, -6)

				local var_610_7 = manager.ui.mainCamera.transform.position - var_610_0.position

				var_610_0.forward = Vector3.New(var_610_7.x, var_610_7.y, var_610_7.z)

				local var_610_8 = var_610_0.localEulerAngles

				var_610_8.z = 0
				var_610_8.x = 0
				var_610_0.localEulerAngles = var_610_8
			end

			local var_610_9 = arg_607_1.actors_["1022ui_story"]
			local var_610_10 = 0

			if var_610_10 < arg_607_1.time_ and arg_607_1.time_ <= var_610_10 + arg_610_0 and not isNil(var_610_9) and arg_607_1.var_.characterEffect1022ui_story == nil then
				arg_607_1.var_.characterEffect1022ui_story = var_610_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_610_11 = 0.200000002980232

			if var_610_10 <= arg_607_1.time_ and arg_607_1.time_ < var_610_10 + var_610_11 and not isNil(var_610_9) then
				local var_610_12 = (arg_607_1.time_ - var_610_10) / var_610_11

				if arg_607_1.var_.characterEffect1022ui_story and not isNil(var_610_9) then
					arg_607_1.var_.characterEffect1022ui_story.fillFlat = false
				end
			end

			if arg_607_1.time_ >= var_610_10 + var_610_11 and arg_607_1.time_ < var_610_10 + var_610_11 + arg_610_0 and not isNil(var_610_9) and arg_607_1.var_.characterEffect1022ui_story then
				arg_607_1.var_.characterEffect1022ui_story.fillFlat = false
			end

			local var_610_13 = 0

			if var_610_13 < arg_607_1.time_ and arg_607_1.time_ <= var_610_13 + arg_610_0 then
				arg_607_1:PlayTimeline("1022ui_story", "StoryTimeline/CharAction/story1022/story1022actionlink/1022action442")
			end

			local var_610_14 = 0

			if var_610_14 < arg_607_1.time_ and arg_607_1.time_ <= var_610_14 + arg_610_0 then
				arg_607_1:PlayTimeline("1022ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_610_15 = 0
			local var_610_16 = 0.275

			if var_610_15 < arg_607_1.time_ and arg_607_1.time_ <= var_610_15 + arg_610_0 then
				arg_607_1.talkMaxDuration = 0
				arg_607_1.dialogCg_.alpha = 1

				arg_607_1.dialog_:SetActive(true)
				SetActive(arg_607_1.leftNameGo_, true)

				local var_610_17 = arg_607_1:FormatText(StoryNameCfg[259].name)

				arg_607_1.leftNameTxt_.text = var_610_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_607_1.leftNameTxt_.transform)

				arg_607_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_607_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_607_1:RecordName(arg_607_1.leftNameTxt_.text)
				SetActive(arg_607_1.iconTrs_.gameObject, false)
				arg_607_1.callingController_:SetSelectedState("normal")

				local var_610_18 = arg_607_1:GetWordFromCfg(1102205146)
				local var_610_19 = arg_607_1:FormatText(var_610_18.content)

				arg_607_1.text_.text = var_610_19

				LuaForUtil.ClearLinePrefixSymbol(arg_607_1.text_)

				local var_610_20 = 11
				local var_610_21 = utf8.len(var_610_19)
				local var_610_22 = var_610_20 <= 0 and var_610_16 or var_610_16 * (var_610_21 / var_610_20)

				if var_610_22 > 0 and var_610_16 < var_610_22 then
					arg_607_1.talkMaxDuration = var_610_22

					if var_610_22 + var_610_15 > arg_607_1.duration_ then
						arg_607_1.duration_ = var_610_22 + var_610_15
					end
				end

				arg_607_1.text_.text = var_610_19
				arg_607_1.typewritter.percent = 0

				arg_607_1.typewritter:SetDirty()
				arg_607_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205146", "story_v_side_new_1102205.awb") ~= 0 then
					local var_610_23 = manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205146", "story_v_side_new_1102205.awb") / 1000

					if var_610_23 + var_610_15 > arg_607_1.duration_ then
						arg_607_1.duration_ = var_610_23 + var_610_15
					end

					if var_610_18.prefab_name ~= "" and arg_607_1.actors_[var_610_18.prefab_name] ~= nil then
						local var_610_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_607_1.actors_[var_610_18.prefab_name].transform, "story_v_side_new_1102205", "1102205146", "story_v_side_new_1102205.awb")

						arg_607_1:RecordAudio("1102205146", var_610_24)
						arg_607_1:RecordAudio("1102205146", var_610_24)
					else
						arg_607_1:AudioAction("play", "voice", "story_v_side_new_1102205", "1102205146", "story_v_side_new_1102205.awb")
					end

					arg_607_1:RecordHistoryTalkVoice("story_v_side_new_1102205", "1102205146", "story_v_side_new_1102205.awb")
				end

				arg_607_1:RecordContent(arg_607_1.text_.text)
			end

			local var_610_25 = math.max(var_610_16, arg_607_1.talkMaxDuration)

			if var_610_15 <= arg_607_1.time_ and arg_607_1.time_ < var_610_15 + var_610_25 then
				arg_607_1.typewritter.percent = (arg_607_1.time_ - var_610_15) / var_610_25

				arg_607_1.typewritter:SetDirty()
			end

			if arg_607_1.time_ >= var_610_15 + var_610_25 and arg_607_1.time_ < var_610_15 + var_610_25 + arg_610_0 then
				arg_607_1.typewritter.percent = 1

				arg_607_1.typewritter:SetDirty()
				arg_607_1:ShowNextGo(true)
			end
		end

		arg_607_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1022ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_607_1:InitPlayNodeList()
	end,
	Play1102205147 = function(arg_611_0, arg_611_1)
		arg_611_1.time_ = 0
		arg_611_1.frameCnt_ = 0
		arg_611_1.state_ = "playing"
		arg_611_1.curTalkId_ = 1102205147
		arg_611_1.duration_ = 5

		SetActive(arg_611_1.tipsGo_, false)

		function arg_611_1.onSingleLineFinish_()
			arg_611_1.onSingleLineUpdate_ = nil
			arg_611_1.onSingleLineFinish_ = nil
			arg_611_1.state_ = "waiting"
		end

		function arg_611_1.playNext_(arg_613_0)
			if arg_613_0 == 1 then
				arg_611_0:Play1102205148(arg_611_1)
			end
		end

		function arg_611_1.onSingleLineUpdate_(arg_614_0)
			local var_614_0 = arg_611_1.actors_["1022ui_story"]
			local var_614_1 = 0

			if var_614_1 < arg_611_1.time_ and arg_611_1.time_ <= var_614_1 + arg_614_0 and not isNil(var_614_0) and arg_611_1.var_.characterEffect1022ui_story == nil then
				arg_611_1.var_.characterEffect1022ui_story = var_614_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_614_2 = 0.200000002980232

			if var_614_1 <= arg_611_1.time_ and arg_611_1.time_ < var_614_1 + var_614_2 and not isNil(var_614_0) then
				local var_614_3 = (arg_611_1.time_ - var_614_1) / var_614_2

				if arg_611_1.var_.characterEffect1022ui_story and not isNil(var_614_0) then
					local var_614_4 = Mathf.Lerp(0, 0.5, var_614_3)

					arg_611_1.var_.characterEffect1022ui_story.fillFlat = true
					arg_611_1.var_.characterEffect1022ui_story.fillRatio = var_614_4
				end
			end

			if arg_611_1.time_ >= var_614_1 + var_614_2 and arg_611_1.time_ < var_614_1 + var_614_2 + arg_614_0 and not isNil(var_614_0) and arg_611_1.var_.characterEffect1022ui_story then
				local var_614_5 = 0.5

				arg_611_1.var_.characterEffect1022ui_story.fillFlat = true
				arg_611_1.var_.characterEffect1022ui_story.fillRatio = var_614_5
			end

			local var_614_6 = arg_611_1.actors_["1022ui_story"].transform
			local var_614_7 = 0

			if var_614_7 < arg_611_1.time_ and arg_611_1.time_ <= var_614_7 + arg_614_0 then
				arg_611_1.var_.moveOldPos1022ui_story = var_614_6.localPosition
			end

			local var_614_8 = 0.001

			if var_614_7 <= arg_611_1.time_ and arg_611_1.time_ < var_614_7 + var_614_8 then
				local var_614_9 = (arg_611_1.time_ - var_614_7) / var_614_8
				local var_614_10 = Vector3.New(0, 100, 0)

				var_614_6.localPosition = Vector3.Lerp(arg_611_1.var_.moveOldPos1022ui_story, var_614_10, var_614_9)

				local var_614_11 = manager.ui.mainCamera.transform.position - var_614_6.position

				var_614_6.forward = Vector3.New(var_614_11.x, var_614_11.y, var_614_11.z)

				local var_614_12 = var_614_6.localEulerAngles

				var_614_12.z = 0
				var_614_12.x = 0
				var_614_6.localEulerAngles = var_614_12
			end

			if arg_611_1.time_ >= var_614_7 + var_614_8 and arg_611_1.time_ < var_614_7 + var_614_8 + arg_614_0 then
				var_614_6.localPosition = Vector3.New(0, 100, 0)

				local var_614_13 = manager.ui.mainCamera.transform.position - var_614_6.position

				var_614_6.forward = Vector3.New(var_614_13.x, var_614_13.y, var_614_13.z)

				local var_614_14 = var_614_6.localEulerAngles

				var_614_14.z = 0
				var_614_14.x = 0
				var_614_6.localEulerAngles = var_614_14
			end

			local var_614_15 = 0
			local var_614_16 = 0.6

			if var_614_15 < arg_611_1.time_ and arg_611_1.time_ <= var_614_15 + arg_614_0 then
				arg_611_1.talkMaxDuration = 0
				arg_611_1.dialogCg_.alpha = 1

				arg_611_1.dialog_:SetActive(true)
				SetActive(arg_611_1.leftNameGo_, false)

				arg_611_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_611_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_611_1:RecordName(arg_611_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_611_1.iconTrs_.gameObject, false)
				arg_611_1.callingController_:SetSelectedState("normal")

				local var_614_17 = arg_611_1:GetWordFromCfg(1102205147)
				local var_614_18 = arg_611_1:FormatText(var_614_17.content)

				arg_611_1.text_.text = var_614_18

				LuaForUtil.ClearLinePrefixSymbol(arg_611_1.text_)

				local var_614_19 = 24
				local var_614_20 = utf8.len(var_614_18)
				local var_614_21 = var_614_19 <= 0 and var_614_16 or var_614_16 * (var_614_20 / var_614_19)

				if var_614_21 > 0 and var_614_16 < var_614_21 then
					arg_611_1.talkMaxDuration = var_614_21

					if var_614_21 + var_614_15 > arg_611_1.duration_ then
						arg_611_1.duration_ = var_614_21 + var_614_15
					end
				end

				arg_611_1.text_.text = var_614_18
				arg_611_1.typewritter.percent = 0

				arg_611_1.typewritter:SetDirty()
				arg_611_1:ShowNextGo(false)
				arg_611_1:RecordContent(arg_611_1.text_.text)
			end

			local var_614_22 = math.max(var_614_16, arg_611_1.talkMaxDuration)

			if var_614_15 <= arg_611_1.time_ and arg_611_1.time_ < var_614_15 + var_614_22 then
				arg_611_1.typewritter.percent = (arg_611_1.time_ - var_614_15) / var_614_22

				arg_611_1.typewritter:SetDirty()
			end

			if arg_611_1.time_ >= var_614_15 + var_614_22 and arg_611_1.time_ < var_614_15 + var_614_22 + arg_614_0 then
				arg_611_1.typewritter.percent = 1

				arg_611_1.typewritter:SetDirty()
				arg_611_1:ShowNextGo(true)
			end
		end

		arg_611_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1022ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_611_1:InitPlayNodeList()
	end,
	Play1102205148 = function(arg_615_0, arg_615_1)
		arg_615_1.time_ = 0
		arg_615_1.frameCnt_ = 0
		arg_615_1.state_ = "playing"
		arg_615_1.curTalkId_ = 1102205148
		arg_615_1.duration_ = 4.23

		SetActive(arg_615_1.tipsGo_, false)

		function arg_615_1.onSingleLineFinish_()
			arg_615_1.onSingleLineUpdate_ = nil
			arg_615_1.onSingleLineFinish_ = nil
			arg_615_1.state_ = "waiting"
		end

		function arg_615_1.playNext_(arg_617_0)
			if arg_617_0 == 1 then
				arg_615_0:Play1102205149(arg_615_1)
			end
		end

		function arg_615_1.onSingleLineUpdate_(arg_618_0)
			local var_618_0 = arg_615_1.actors_["1022ui_story"]
			local var_618_1 = 0

			if var_618_1 < arg_615_1.time_ and arg_615_1.time_ <= var_618_1 + arg_618_0 and not isNil(var_618_0) and arg_615_1.var_.characterEffect1022ui_story == nil then
				arg_615_1.var_.characterEffect1022ui_story = var_618_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_618_2 = 0.200000002980232

			if var_618_1 <= arg_615_1.time_ and arg_615_1.time_ < var_618_1 + var_618_2 and not isNil(var_618_0) then
				local var_618_3 = (arg_615_1.time_ - var_618_1) / var_618_2

				if arg_615_1.var_.characterEffect1022ui_story and not isNil(var_618_0) then
					arg_615_1.var_.characterEffect1022ui_story.fillFlat = false
				end
			end

			if arg_615_1.time_ >= var_618_1 + var_618_2 and arg_615_1.time_ < var_618_1 + var_618_2 + arg_618_0 and not isNil(var_618_0) and arg_615_1.var_.characterEffect1022ui_story then
				arg_615_1.var_.characterEffect1022ui_story.fillFlat = false
			end

			local var_618_4 = arg_615_1.actors_["1022ui_story"].transform
			local var_618_5 = 0

			if var_618_5 < arg_615_1.time_ and arg_615_1.time_ <= var_618_5 + arg_618_0 then
				arg_615_1.var_.moveOldPos1022ui_story = var_618_4.localPosition
			end

			local var_618_6 = 0.001

			if var_618_5 <= arg_615_1.time_ and arg_615_1.time_ < var_618_5 + var_618_6 then
				local var_618_7 = (arg_615_1.time_ - var_618_5) / var_618_6
				local var_618_8 = Vector3.New(0, -1.08, -6)

				var_618_4.localPosition = Vector3.Lerp(arg_615_1.var_.moveOldPos1022ui_story, var_618_8, var_618_7)

				local var_618_9 = manager.ui.mainCamera.transform.position - var_618_4.position

				var_618_4.forward = Vector3.New(var_618_9.x, var_618_9.y, var_618_9.z)

				local var_618_10 = var_618_4.localEulerAngles

				var_618_10.z = 0
				var_618_10.x = 0
				var_618_4.localEulerAngles = var_618_10
			end

			if arg_615_1.time_ >= var_618_5 + var_618_6 and arg_615_1.time_ < var_618_5 + var_618_6 + arg_618_0 then
				var_618_4.localPosition = Vector3.New(0, -1.08, -6)

				local var_618_11 = manager.ui.mainCamera.transform.position - var_618_4.position

				var_618_4.forward = Vector3.New(var_618_11.x, var_618_11.y, var_618_11.z)

				local var_618_12 = var_618_4.localEulerAngles

				var_618_12.z = 0
				var_618_12.x = 0
				var_618_4.localEulerAngles = var_618_12
			end

			local var_618_13 = 0

			if var_618_13 < arg_615_1.time_ and arg_615_1.time_ <= var_618_13 + arg_618_0 then
				arg_615_1:PlayTimeline("1022ui_story", "StoryTimeline/CharAction/story1022/story1022action/1022action2_2")
			end

			local var_618_14 = 0
			local var_618_15 = 0.475

			if var_618_14 < arg_615_1.time_ and arg_615_1.time_ <= var_618_14 + arg_618_0 then
				arg_615_1.talkMaxDuration = 0
				arg_615_1.dialogCg_.alpha = 1

				arg_615_1.dialog_:SetActive(true)
				SetActive(arg_615_1.leftNameGo_, true)

				local var_618_16 = arg_615_1:FormatText(StoryNameCfg[259].name)

				arg_615_1.leftNameTxt_.text = var_618_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_615_1.leftNameTxt_.transform)

				arg_615_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_615_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_615_1:RecordName(arg_615_1.leftNameTxt_.text)
				SetActive(arg_615_1.iconTrs_.gameObject, false)
				arg_615_1.callingController_:SetSelectedState("normal")

				local var_618_17 = arg_615_1:GetWordFromCfg(1102205148)
				local var_618_18 = arg_615_1:FormatText(var_618_17.content)

				arg_615_1.text_.text = var_618_18

				LuaForUtil.ClearLinePrefixSymbol(arg_615_1.text_)

				local var_618_19 = 19
				local var_618_20 = utf8.len(var_618_18)
				local var_618_21 = var_618_19 <= 0 and var_618_15 or var_618_15 * (var_618_20 / var_618_19)

				if var_618_21 > 0 and var_618_15 < var_618_21 then
					arg_615_1.talkMaxDuration = var_618_21

					if var_618_21 + var_618_14 > arg_615_1.duration_ then
						arg_615_1.duration_ = var_618_21 + var_618_14
					end
				end

				arg_615_1.text_.text = var_618_18
				arg_615_1.typewritter.percent = 0

				arg_615_1.typewritter:SetDirty()
				arg_615_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205148", "story_v_side_new_1102205.awb") ~= 0 then
					local var_618_22 = manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205148", "story_v_side_new_1102205.awb") / 1000

					if var_618_22 + var_618_14 > arg_615_1.duration_ then
						arg_615_1.duration_ = var_618_22 + var_618_14
					end

					if var_618_17.prefab_name ~= "" and arg_615_1.actors_[var_618_17.prefab_name] ~= nil then
						local var_618_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_615_1.actors_[var_618_17.prefab_name].transform, "story_v_side_new_1102205", "1102205148", "story_v_side_new_1102205.awb")

						arg_615_1:RecordAudio("1102205148", var_618_23)
						arg_615_1:RecordAudio("1102205148", var_618_23)
					else
						arg_615_1:AudioAction("play", "voice", "story_v_side_new_1102205", "1102205148", "story_v_side_new_1102205.awb")
					end

					arg_615_1:RecordHistoryTalkVoice("story_v_side_new_1102205", "1102205148", "story_v_side_new_1102205.awb")
				end

				arg_615_1:RecordContent(arg_615_1.text_.text)
			end

			local var_618_24 = math.max(var_618_15, arg_615_1.talkMaxDuration)

			if var_618_14 <= arg_615_1.time_ and arg_615_1.time_ < var_618_14 + var_618_24 then
				arg_615_1.typewritter.percent = (arg_615_1.time_ - var_618_14) / var_618_24

				arg_615_1.typewritter:SetDirty()
			end

			if arg_615_1.time_ >= var_618_14 + var_618_24 and arg_615_1.time_ < var_618_14 + var_618_24 + arg_618_0 then
				arg_615_1.typewritter.percent = 1

				arg_615_1.typewritter:SetDirty()
				arg_615_1:ShowNextGo(true)
			end
		end

		arg_615_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1022ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_615_1:InitPlayNodeList()
	end,
	Play1102205149 = function(arg_619_0, arg_619_1)
		arg_619_1.time_ = 0
		arg_619_1.frameCnt_ = 0
		arg_619_1.state_ = "playing"
		arg_619_1.curTalkId_ = 1102205149
		arg_619_1.duration_ = 5

		SetActive(arg_619_1.tipsGo_, false)

		function arg_619_1.onSingleLineFinish_()
			arg_619_1.onSingleLineUpdate_ = nil
			arg_619_1.onSingleLineFinish_ = nil
			arg_619_1.state_ = "waiting"
		end

		function arg_619_1.playNext_(arg_621_0)
			if arg_621_0 == 1 then
				arg_619_0:Play1102205150(arg_619_1)
			end
		end

		function arg_619_1.onSingleLineUpdate_(arg_622_0)
			local var_622_0 = arg_619_1.actors_["1022ui_story"]
			local var_622_1 = 0

			if var_622_1 < arg_619_1.time_ and arg_619_1.time_ <= var_622_1 + arg_622_0 and not isNil(var_622_0) and arg_619_1.var_.characterEffect1022ui_story == nil then
				arg_619_1.var_.characterEffect1022ui_story = var_622_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_622_2 = 0.200000002980232

			if var_622_1 <= arg_619_1.time_ and arg_619_1.time_ < var_622_1 + var_622_2 and not isNil(var_622_0) then
				local var_622_3 = (arg_619_1.time_ - var_622_1) / var_622_2

				if arg_619_1.var_.characterEffect1022ui_story and not isNil(var_622_0) then
					local var_622_4 = Mathf.Lerp(0, 0.5, var_622_3)

					arg_619_1.var_.characterEffect1022ui_story.fillFlat = true
					arg_619_1.var_.characterEffect1022ui_story.fillRatio = var_622_4
				end
			end

			if arg_619_1.time_ >= var_622_1 + var_622_2 and arg_619_1.time_ < var_622_1 + var_622_2 + arg_622_0 and not isNil(var_622_0) and arg_619_1.var_.characterEffect1022ui_story then
				local var_622_5 = 0.5

				arg_619_1.var_.characterEffect1022ui_story.fillFlat = true
				arg_619_1.var_.characterEffect1022ui_story.fillRatio = var_622_5
			end

			local var_622_6 = 0
			local var_622_7 = 0.875

			if var_622_6 < arg_619_1.time_ and arg_619_1.time_ <= var_622_6 + arg_622_0 then
				arg_619_1.talkMaxDuration = 0
				arg_619_1.dialogCg_.alpha = 1

				arg_619_1.dialog_:SetActive(true)
				SetActive(arg_619_1.leftNameGo_, true)

				local var_622_8 = arg_619_1:FormatText(StoryNameCfg[7].name)

				arg_619_1.leftNameTxt_.text = var_622_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_619_1.leftNameTxt_.transform)

				arg_619_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_619_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_619_1:RecordName(arg_619_1.leftNameTxt_.text)
				SetActive(arg_619_1.iconTrs_.gameObject, true)
				arg_619_1.iconController_:SetSelectedState("hero")

				arg_619_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_619_1.callingController_:SetSelectedState("normal")

				arg_619_1.keyicon_.color = Color.New(1, 1, 1)
				arg_619_1.icon_.color = Color.New(1, 1, 1)

				local var_622_9 = arg_619_1:GetWordFromCfg(1102205149)
				local var_622_10 = arg_619_1:FormatText(var_622_9.content)

				arg_619_1.text_.text = var_622_10

				LuaForUtil.ClearLinePrefixSymbol(arg_619_1.text_)

				local var_622_11 = 35
				local var_622_12 = utf8.len(var_622_10)
				local var_622_13 = var_622_11 <= 0 and var_622_7 or var_622_7 * (var_622_12 / var_622_11)

				if var_622_13 > 0 and var_622_7 < var_622_13 then
					arg_619_1.talkMaxDuration = var_622_13

					if var_622_13 + var_622_6 > arg_619_1.duration_ then
						arg_619_1.duration_ = var_622_13 + var_622_6
					end
				end

				arg_619_1.text_.text = var_622_10
				arg_619_1.typewritter.percent = 0

				arg_619_1.typewritter:SetDirty()
				arg_619_1:ShowNextGo(false)
				arg_619_1:RecordContent(arg_619_1.text_.text)
			end

			local var_622_14 = math.max(var_622_7, arg_619_1.talkMaxDuration)

			if var_622_6 <= arg_619_1.time_ and arg_619_1.time_ < var_622_6 + var_622_14 then
				arg_619_1.typewritter.percent = (arg_619_1.time_ - var_622_6) / var_622_14

				arg_619_1.typewritter:SetDirty()
			end

			if arg_619_1.time_ >= var_622_6 + var_622_14 and arg_619_1.time_ < var_622_6 + var_622_14 + arg_622_0 then
				arg_619_1.typewritter.percent = 1

				arg_619_1.typewritter:SetDirty()
				arg_619_1:ShowNextGo(true)
			end
		end

		arg_619_1.nodeConfigList_ = {}

		arg_619_1:InitPlayNodeList()
	end,
	Play1102205150 = function(arg_623_0, arg_623_1)
		arg_623_1.time_ = 0
		arg_623_1.frameCnt_ = 0
		arg_623_1.state_ = "playing"
		arg_623_1.curTalkId_ = 1102205150
		arg_623_1.duration_ = 5.8

		SetActive(arg_623_1.tipsGo_, false)

		function arg_623_1.onSingleLineFinish_()
			arg_623_1.onSingleLineUpdate_ = nil
			arg_623_1.onSingleLineFinish_ = nil
			arg_623_1.state_ = "waiting"
		end

		function arg_623_1.playNext_(arg_625_0)
			if arg_625_0 == 1 then
				arg_623_0:Play1102205151(arg_623_1)
			end
		end

		function arg_623_1.onSingleLineUpdate_(arg_626_0)
			local var_626_0 = arg_623_1.actors_["1022ui_story"]
			local var_626_1 = 0

			if var_626_1 < arg_623_1.time_ and arg_623_1.time_ <= var_626_1 + arg_626_0 and not isNil(var_626_0) and arg_623_1.var_.characterEffect1022ui_story == nil then
				arg_623_1.var_.characterEffect1022ui_story = var_626_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_626_2 = 0.200000002980232

			if var_626_1 <= arg_623_1.time_ and arg_623_1.time_ < var_626_1 + var_626_2 and not isNil(var_626_0) then
				local var_626_3 = (arg_623_1.time_ - var_626_1) / var_626_2

				if arg_623_1.var_.characterEffect1022ui_story and not isNil(var_626_0) then
					arg_623_1.var_.characterEffect1022ui_story.fillFlat = false
				end
			end

			if arg_623_1.time_ >= var_626_1 + var_626_2 and arg_623_1.time_ < var_626_1 + var_626_2 + arg_626_0 and not isNil(var_626_0) and arg_623_1.var_.characterEffect1022ui_story then
				arg_623_1.var_.characterEffect1022ui_story.fillFlat = false
			end

			local var_626_4 = 0

			if var_626_4 < arg_623_1.time_ and arg_623_1.time_ <= var_626_4 + arg_626_0 then
				arg_623_1:PlayTimeline("1022ui_story", "StoryTimeline/CharAction/story1022/story1022action/1022action6_1")
			end

			local var_626_5 = 0

			if var_626_5 < arg_623_1.time_ and arg_623_1.time_ <= var_626_5 + arg_626_0 then
				arg_623_1:PlayTimeline("1022ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_626_6 = 0
			local var_626_7 = 0.6

			if var_626_6 < arg_623_1.time_ and arg_623_1.time_ <= var_626_6 + arg_626_0 then
				arg_623_1.talkMaxDuration = 0
				arg_623_1.dialogCg_.alpha = 1

				arg_623_1.dialog_:SetActive(true)
				SetActive(arg_623_1.leftNameGo_, true)

				local var_626_8 = arg_623_1:FormatText(StoryNameCfg[259].name)

				arg_623_1.leftNameTxt_.text = var_626_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_623_1.leftNameTxt_.transform)

				arg_623_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_623_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_623_1:RecordName(arg_623_1.leftNameTxt_.text)
				SetActive(arg_623_1.iconTrs_.gameObject, false)
				arg_623_1.callingController_:SetSelectedState("normal")

				local var_626_9 = arg_623_1:GetWordFromCfg(1102205150)
				local var_626_10 = arg_623_1:FormatText(var_626_9.content)

				arg_623_1.text_.text = var_626_10

				LuaForUtil.ClearLinePrefixSymbol(arg_623_1.text_)

				local var_626_11 = 24
				local var_626_12 = utf8.len(var_626_10)
				local var_626_13 = var_626_11 <= 0 and var_626_7 or var_626_7 * (var_626_12 / var_626_11)

				if var_626_13 > 0 and var_626_7 < var_626_13 then
					arg_623_1.talkMaxDuration = var_626_13

					if var_626_13 + var_626_6 > arg_623_1.duration_ then
						arg_623_1.duration_ = var_626_13 + var_626_6
					end
				end

				arg_623_1.text_.text = var_626_10
				arg_623_1.typewritter.percent = 0

				arg_623_1.typewritter:SetDirty()
				arg_623_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205150", "story_v_side_new_1102205.awb") ~= 0 then
					local var_626_14 = manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205150", "story_v_side_new_1102205.awb") / 1000

					if var_626_14 + var_626_6 > arg_623_1.duration_ then
						arg_623_1.duration_ = var_626_14 + var_626_6
					end

					if var_626_9.prefab_name ~= "" and arg_623_1.actors_[var_626_9.prefab_name] ~= nil then
						local var_626_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_623_1.actors_[var_626_9.prefab_name].transform, "story_v_side_new_1102205", "1102205150", "story_v_side_new_1102205.awb")

						arg_623_1:RecordAudio("1102205150", var_626_15)
						arg_623_1:RecordAudio("1102205150", var_626_15)
					else
						arg_623_1:AudioAction("play", "voice", "story_v_side_new_1102205", "1102205150", "story_v_side_new_1102205.awb")
					end

					arg_623_1:RecordHistoryTalkVoice("story_v_side_new_1102205", "1102205150", "story_v_side_new_1102205.awb")
				end

				arg_623_1:RecordContent(arg_623_1.text_.text)
			end

			local var_626_16 = math.max(var_626_7, arg_623_1.talkMaxDuration)

			if var_626_6 <= arg_623_1.time_ and arg_623_1.time_ < var_626_6 + var_626_16 then
				arg_623_1.typewritter.percent = (arg_623_1.time_ - var_626_6) / var_626_16

				arg_623_1.typewritter:SetDirty()
			end

			if arg_623_1.time_ >= var_626_6 + var_626_16 and arg_623_1.time_ < var_626_6 + var_626_16 + arg_626_0 then
				arg_623_1.typewritter.percent = 1

				arg_623_1.typewritter:SetDirty()
				arg_623_1:ShowNextGo(true)
			end
		end

		arg_623_1.nodeConfigList_ = {}

		arg_623_1:InitPlayNodeList()
	end,
	Play1102205151 = function(arg_627_0, arg_627_1)
		arg_627_1.time_ = 0
		arg_627_1.frameCnt_ = 0
		arg_627_1.state_ = "playing"
		arg_627_1.curTalkId_ = 1102205151
		arg_627_1.duration_ = 5

		SetActive(arg_627_1.tipsGo_, false)

		function arg_627_1.onSingleLineFinish_()
			arg_627_1.onSingleLineUpdate_ = nil
			arg_627_1.onSingleLineFinish_ = nil
			arg_627_1.state_ = "waiting"
		end

		function arg_627_1.playNext_(arg_629_0)
			if arg_629_0 == 1 then
				arg_627_0:Play1102205152(arg_627_1)
			end
		end

		function arg_627_1.onSingleLineUpdate_(arg_630_0)
			local var_630_0 = arg_627_1.actors_["1022ui_story"].transform
			local var_630_1 = 0

			if var_630_1 < arg_627_1.time_ and arg_627_1.time_ <= var_630_1 + arg_630_0 then
				arg_627_1.var_.moveOldPos1022ui_story = var_630_0.localPosition
			end

			local var_630_2 = 0.001

			if var_630_1 <= arg_627_1.time_ and arg_627_1.time_ < var_630_1 + var_630_2 then
				local var_630_3 = (arg_627_1.time_ - var_630_1) / var_630_2
				local var_630_4 = Vector3.New(0, 100, 0)

				var_630_0.localPosition = Vector3.Lerp(arg_627_1.var_.moveOldPos1022ui_story, var_630_4, var_630_3)

				local var_630_5 = manager.ui.mainCamera.transform.position - var_630_0.position

				var_630_0.forward = Vector3.New(var_630_5.x, var_630_5.y, var_630_5.z)

				local var_630_6 = var_630_0.localEulerAngles

				var_630_6.z = 0
				var_630_6.x = 0
				var_630_0.localEulerAngles = var_630_6
			end

			if arg_627_1.time_ >= var_630_1 + var_630_2 and arg_627_1.time_ < var_630_1 + var_630_2 + arg_630_0 then
				var_630_0.localPosition = Vector3.New(0, 100, 0)

				local var_630_7 = manager.ui.mainCamera.transform.position - var_630_0.position

				var_630_0.forward = Vector3.New(var_630_7.x, var_630_7.y, var_630_7.z)

				local var_630_8 = var_630_0.localEulerAngles

				var_630_8.z = 0
				var_630_8.x = 0
				var_630_0.localEulerAngles = var_630_8
			end

			local var_630_9 = arg_627_1.actors_["1022ui_story"]
			local var_630_10 = 0

			if var_630_10 < arg_627_1.time_ and arg_627_1.time_ <= var_630_10 + arg_630_0 and not isNil(var_630_9) and arg_627_1.var_.characterEffect1022ui_story == nil then
				arg_627_1.var_.characterEffect1022ui_story = var_630_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_630_11 = 0.200000002980232

			if var_630_10 <= arg_627_1.time_ and arg_627_1.time_ < var_630_10 + var_630_11 and not isNil(var_630_9) then
				local var_630_12 = (arg_627_1.time_ - var_630_10) / var_630_11

				if arg_627_1.var_.characterEffect1022ui_story and not isNil(var_630_9) then
					local var_630_13 = Mathf.Lerp(0, 0.5, var_630_12)

					arg_627_1.var_.characterEffect1022ui_story.fillFlat = true
					arg_627_1.var_.characterEffect1022ui_story.fillRatio = var_630_13
				end
			end

			if arg_627_1.time_ >= var_630_10 + var_630_11 and arg_627_1.time_ < var_630_10 + var_630_11 + arg_630_0 and not isNil(var_630_9) and arg_627_1.var_.characterEffect1022ui_story then
				local var_630_14 = 0.5

				arg_627_1.var_.characterEffect1022ui_story.fillFlat = true
				arg_627_1.var_.characterEffect1022ui_story.fillRatio = var_630_14
			end

			local var_630_15 = 0
			local var_630_16 = 1.025

			if var_630_15 < arg_627_1.time_ and arg_627_1.time_ <= var_630_15 + arg_630_0 then
				arg_627_1.talkMaxDuration = 0
				arg_627_1.dialogCg_.alpha = 1

				arg_627_1.dialog_:SetActive(true)
				SetActive(arg_627_1.leftNameGo_, false)

				arg_627_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_627_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_627_1:RecordName(arg_627_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_627_1.iconTrs_.gameObject, false)
				arg_627_1.callingController_:SetSelectedState("normal")

				local var_630_17 = arg_627_1:GetWordFromCfg(1102205151)
				local var_630_18 = arg_627_1:FormatText(var_630_17.content)

				arg_627_1.text_.text = var_630_18

				LuaForUtil.ClearLinePrefixSymbol(arg_627_1.text_)

				local var_630_19 = 41
				local var_630_20 = utf8.len(var_630_18)
				local var_630_21 = var_630_19 <= 0 and var_630_16 or var_630_16 * (var_630_20 / var_630_19)

				if var_630_21 > 0 and var_630_16 < var_630_21 then
					arg_627_1.talkMaxDuration = var_630_21

					if var_630_21 + var_630_15 > arg_627_1.duration_ then
						arg_627_1.duration_ = var_630_21 + var_630_15
					end
				end

				arg_627_1.text_.text = var_630_18
				arg_627_1.typewritter.percent = 0

				arg_627_1.typewritter:SetDirty()
				arg_627_1:ShowNextGo(false)
				arg_627_1:RecordContent(arg_627_1.text_.text)
			end

			local var_630_22 = math.max(var_630_16, arg_627_1.talkMaxDuration)

			if var_630_15 <= arg_627_1.time_ and arg_627_1.time_ < var_630_15 + var_630_22 then
				arg_627_1.typewritter.percent = (arg_627_1.time_ - var_630_15) / var_630_22

				arg_627_1.typewritter:SetDirty()
			end

			if arg_627_1.time_ >= var_630_15 + var_630_22 and arg_627_1.time_ < var_630_15 + var_630_22 + arg_630_0 then
				arg_627_1.typewritter.percent = 1

				arg_627_1.typewritter:SetDirty()
				arg_627_1:ShowNextGo(true)
			end
		end

		arg_627_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1022ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_627_1:InitPlayNodeList()
	end,
	Play1102205152 = function(arg_631_0, arg_631_1)
		arg_631_1.time_ = 0
		arg_631_1.frameCnt_ = 0
		arg_631_1.state_ = "playing"
		arg_631_1.curTalkId_ = 1102205152
		arg_631_1.duration_ = 5

		SetActive(arg_631_1.tipsGo_, false)

		function arg_631_1.onSingleLineFinish_()
			arg_631_1.onSingleLineUpdate_ = nil
			arg_631_1.onSingleLineFinish_ = nil
			arg_631_1.state_ = "waiting"
		end

		function arg_631_1.playNext_(arg_633_0)
			if arg_633_0 == 1 then
				arg_631_0:Play1102205153(arg_631_1)
			end
		end

		function arg_631_1.onSingleLineUpdate_(arg_634_0)
			local var_634_0 = 0
			local var_634_1 = 0.75

			if var_634_0 < arg_631_1.time_ and arg_631_1.time_ <= var_634_0 + arg_634_0 then
				arg_631_1.talkMaxDuration = 0
				arg_631_1.dialogCg_.alpha = 1

				arg_631_1.dialog_:SetActive(true)
				SetActive(arg_631_1.leftNameGo_, false)

				arg_631_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_631_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_631_1:RecordName(arg_631_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_631_1.iconTrs_.gameObject, false)
				arg_631_1.callingController_:SetSelectedState("normal")

				local var_634_2 = arg_631_1:GetWordFromCfg(1102205152)
				local var_634_3 = arg_631_1:FormatText(var_634_2.content)

				arg_631_1.text_.text = var_634_3

				LuaForUtil.ClearLinePrefixSymbol(arg_631_1.text_)

				local var_634_4 = 30
				local var_634_5 = utf8.len(var_634_3)
				local var_634_6 = var_634_4 <= 0 and var_634_1 or var_634_1 * (var_634_5 / var_634_4)

				if var_634_6 > 0 and var_634_1 < var_634_6 then
					arg_631_1.talkMaxDuration = var_634_6

					if var_634_6 + var_634_0 > arg_631_1.duration_ then
						arg_631_1.duration_ = var_634_6 + var_634_0
					end
				end

				arg_631_1.text_.text = var_634_3
				arg_631_1.typewritter.percent = 0

				arg_631_1.typewritter:SetDirty()
				arg_631_1:ShowNextGo(false)
				arg_631_1:RecordContent(arg_631_1.text_.text)
			end

			local var_634_7 = math.max(var_634_1, arg_631_1.talkMaxDuration)

			if var_634_0 <= arg_631_1.time_ and arg_631_1.time_ < var_634_0 + var_634_7 then
				arg_631_1.typewritter.percent = (arg_631_1.time_ - var_634_0) / var_634_7

				arg_631_1.typewritter:SetDirty()
			end

			if arg_631_1.time_ >= var_634_0 + var_634_7 and arg_631_1.time_ < var_634_0 + var_634_7 + arg_634_0 then
				arg_631_1.typewritter.percent = 1

				arg_631_1.typewritter:SetDirty()
				arg_631_1:ShowNextGo(true)
			end
		end

		arg_631_1.nodeConfigList_ = {}

		arg_631_1:InitPlayNodeList()
	end,
	Play1102205153 = function(arg_635_0, arg_635_1)
		arg_635_1.time_ = 0
		arg_635_1.frameCnt_ = 0
		arg_635_1.state_ = "playing"
		arg_635_1.curTalkId_ = 1102205153
		arg_635_1.duration_ = 6

		SetActive(arg_635_1.tipsGo_, false)

		function arg_635_1.onSingleLineFinish_()
			arg_635_1.onSingleLineUpdate_ = nil
			arg_635_1.onSingleLineFinish_ = nil
			arg_635_1.state_ = "waiting"
		end

		function arg_635_1.playNext_(arg_637_0)
			if arg_637_0 == 1 then
				arg_635_0:Play1102205154(arg_635_1)
			end
		end

		function arg_635_1.onSingleLineUpdate_(arg_638_0)
			local var_638_0 = arg_635_1.actors_["1022ui_story"].transform
			local var_638_1 = 0

			if var_638_1 < arg_635_1.time_ and arg_635_1.time_ <= var_638_1 + arg_638_0 then
				arg_635_1.var_.moveOldPos1022ui_story = var_638_0.localPosition
			end

			local var_638_2 = 0.001

			if var_638_1 <= arg_635_1.time_ and arg_635_1.time_ < var_638_1 + var_638_2 then
				local var_638_3 = (arg_635_1.time_ - var_638_1) / var_638_2
				local var_638_4 = Vector3.New(0, -1.08, -6)

				var_638_0.localPosition = Vector3.Lerp(arg_635_1.var_.moveOldPos1022ui_story, var_638_4, var_638_3)

				local var_638_5 = manager.ui.mainCamera.transform.position - var_638_0.position

				var_638_0.forward = Vector3.New(var_638_5.x, var_638_5.y, var_638_5.z)

				local var_638_6 = var_638_0.localEulerAngles

				var_638_6.z = 0
				var_638_6.x = 0
				var_638_0.localEulerAngles = var_638_6
			end

			if arg_635_1.time_ >= var_638_1 + var_638_2 and arg_635_1.time_ < var_638_1 + var_638_2 + arg_638_0 then
				var_638_0.localPosition = Vector3.New(0, -1.08, -6)

				local var_638_7 = manager.ui.mainCamera.transform.position - var_638_0.position

				var_638_0.forward = Vector3.New(var_638_7.x, var_638_7.y, var_638_7.z)

				local var_638_8 = var_638_0.localEulerAngles

				var_638_8.z = 0
				var_638_8.x = 0
				var_638_0.localEulerAngles = var_638_8
			end

			local var_638_9 = arg_635_1.actors_["1022ui_story"]
			local var_638_10 = 0

			if var_638_10 < arg_635_1.time_ and arg_635_1.time_ <= var_638_10 + arg_638_0 and not isNil(var_638_9) and arg_635_1.var_.characterEffect1022ui_story == nil then
				arg_635_1.var_.characterEffect1022ui_story = var_638_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_638_11 = 0.200000002980232

			if var_638_10 <= arg_635_1.time_ and arg_635_1.time_ < var_638_10 + var_638_11 and not isNil(var_638_9) then
				local var_638_12 = (arg_635_1.time_ - var_638_10) / var_638_11

				if arg_635_1.var_.characterEffect1022ui_story and not isNil(var_638_9) then
					arg_635_1.var_.characterEffect1022ui_story.fillFlat = false
				end
			end

			if arg_635_1.time_ >= var_638_10 + var_638_11 and arg_635_1.time_ < var_638_10 + var_638_11 + arg_638_0 and not isNil(var_638_9) and arg_635_1.var_.characterEffect1022ui_story then
				arg_635_1.var_.characterEffect1022ui_story.fillFlat = false
			end

			local var_638_13 = 0

			if var_638_13 < arg_635_1.time_ and arg_635_1.time_ <= var_638_13 + arg_638_0 then
				arg_635_1:PlayTimeline("1022ui_story", "StoryTimeline/CharAction/story1022/story1022action/1022action6_2")
			end

			local var_638_14 = 0

			if var_638_14 < arg_635_1.time_ and arg_635_1.time_ <= var_638_14 + arg_638_0 then
				arg_635_1:PlayTimeline("1022ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_638_15 = 0
			local var_638_16 = 0.55

			if var_638_15 < arg_635_1.time_ and arg_635_1.time_ <= var_638_15 + arg_638_0 then
				arg_635_1.talkMaxDuration = 0
				arg_635_1.dialogCg_.alpha = 1

				arg_635_1.dialog_:SetActive(true)
				SetActive(arg_635_1.leftNameGo_, true)

				local var_638_17 = arg_635_1:FormatText(StoryNameCfg[259].name)

				arg_635_1.leftNameTxt_.text = var_638_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_635_1.leftNameTxt_.transform)

				arg_635_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_635_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_635_1:RecordName(arg_635_1.leftNameTxt_.text)
				SetActive(arg_635_1.iconTrs_.gameObject, false)
				arg_635_1.callingController_:SetSelectedState("normal")

				local var_638_18 = arg_635_1:GetWordFromCfg(1102205153)
				local var_638_19 = arg_635_1:FormatText(var_638_18.content)

				arg_635_1.text_.text = var_638_19

				LuaForUtil.ClearLinePrefixSymbol(arg_635_1.text_)

				local var_638_20 = 22
				local var_638_21 = utf8.len(var_638_19)
				local var_638_22 = var_638_20 <= 0 and var_638_16 or var_638_16 * (var_638_21 / var_638_20)

				if var_638_22 > 0 and var_638_16 < var_638_22 then
					arg_635_1.talkMaxDuration = var_638_22

					if var_638_22 + var_638_15 > arg_635_1.duration_ then
						arg_635_1.duration_ = var_638_22 + var_638_15
					end
				end

				arg_635_1.text_.text = var_638_19
				arg_635_1.typewritter.percent = 0

				arg_635_1.typewritter:SetDirty()
				arg_635_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205153", "story_v_side_new_1102205.awb") ~= 0 then
					local var_638_23 = manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205153", "story_v_side_new_1102205.awb") / 1000

					if var_638_23 + var_638_15 > arg_635_1.duration_ then
						arg_635_1.duration_ = var_638_23 + var_638_15
					end

					if var_638_18.prefab_name ~= "" and arg_635_1.actors_[var_638_18.prefab_name] ~= nil then
						local var_638_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_635_1.actors_[var_638_18.prefab_name].transform, "story_v_side_new_1102205", "1102205153", "story_v_side_new_1102205.awb")

						arg_635_1:RecordAudio("1102205153", var_638_24)
						arg_635_1:RecordAudio("1102205153", var_638_24)
					else
						arg_635_1:AudioAction("play", "voice", "story_v_side_new_1102205", "1102205153", "story_v_side_new_1102205.awb")
					end

					arg_635_1:RecordHistoryTalkVoice("story_v_side_new_1102205", "1102205153", "story_v_side_new_1102205.awb")
				end

				arg_635_1:RecordContent(arg_635_1.text_.text)
			end

			local var_638_25 = math.max(var_638_16, arg_635_1.talkMaxDuration)

			if var_638_15 <= arg_635_1.time_ and arg_635_1.time_ < var_638_15 + var_638_25 then
				arg_635_1.typewritter.percent = (arg_635_1.time_ - var_638_15) / var_638_25

				arg_635_1.typewritter:SetDirty()
			end

			if arg_635_1.time_ >= var_638_15 + var_638_25 and arg_635_1.time_ < var_638_15 + var_638_25 + arg_638_0 then
				arg_635_1.typewritter.percent = 1

				arg_635_1.typewritter:SetDirty()
				arg_635_1:ShowNextGo(true)
			end
		end

		arg_635_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1022ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_635_1:InitPlayNodeList()
	end,
	Play1102205154 = function(arg_639_0, arg_639_1)
		arg_639_1.time_ = 0
		arg_639_1.frameCnt_ = 0
		arg_639_1.state_ = "playing"
		arg_639_1.curTalkId_ = 1102205154
		arg_639_1.duration_ = 8.73

		SetActive(arg_639_1.tipsGo_, false)

		function arg_639_1.onSingleLineFinish_()
			arg_639_1.onSingleLineUpdate_ = nil
			arg_639_1.onSingleLineFinish_ = nil
			arg_639_1.state_ = "waiting"
		end

		function arg_639_1.playNext_(arg_641_0)
			if arg_641_0 == 1 then
				arg_639_0:Play1102205155(arg_639_1)
			end
		end

		function arg_639_1.onSingleLineUpdate_(arg_642_0)
			local var_642_0 = "ST22a"

			if arg_639_1.bgs_[var_642_0] == nil then
				local var_642_1 = Object.Instantiate(arg_639_1.paintGo_)

				var_642_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_642_0)
				var_642_1.name = var_642_0
				var_642_1.transform.parent = arg_639_1.stage_.transform
				var_642_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_639_1.bgs_[var_642_0] = var_642_1
			end

			local var_642_2 = 2

			if var_642_2 < arg_639_1.time_ and arg_639_1.time_ <= var_642_2 + arg_642_0 then
				local var_642_3 = manager.ui.mainCamera.transform.localPosition
				local var_642_4 = Vector3.New(0, 0, 10) + Vector3.New(var_642_3.x, var_642_3.y, 0)
				local var_642_5 = arg_639_1.bgs_.ST22a

				var_642_5.transform.localPosition = var_642_4
				var_642_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_642_6 = var_642_5:GetComponent("SpriteRenderer")

				if var_642_6 and var_642_6.sprite then
					local var_642_7 = (var_642_5.transform.localPosition - var_642_3).z
					local var_642_8 = manager.ui.mainCameraCom_
					local var_642_9 = 2 * var_642_7 * Mathf.Tan(var_642_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_642_10 = var_642_9 * var_642_8.aspect
					local var_642_11 = var_642_6.sprite.bounds.size.x
					local var_642_12 = var_642_6.sprite.bounds.size.y
					local var_642_13 = var_642_10 / var_642_11
					local var_642_14 = var_642_9 / var_642_12
					local var_642_15 = var_642_14 < var_642_13 and var_642_13 or var_642_14

					var_642_5.transform.localScale = Vector3.New(var_642_15, var_642_15, 0)
				end

				for iter_642_0, iter_642_1 in pairs(arg_639_1.bgs_) do
					if iter_642_0 ~= "ST22a" then
						iter_642_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_642_16 = 0

			if var_642_16 < arg_639_1.time_ and arg_639_1.time_ <= var_642_16 + arg_642_0 then
				arg_639_1.allBtn_.enabled = false
			end

			local var_642_17 = 0.3

			if arg_639_1.time_ >= var_642_16 + var_642_17 and arg_639_1.time_ < var_642_16 + var_642_17 + arg_642_0 then
				arg_639_1.allBtn_.enabled = true
			end

			local var_642_18 = 0

			if var_642_18 < arg_639_1.time_ and arg_639_1.time_ <= var_642_18 + arg_642_0 then
				arg_639_1.mask_.enabled = true
				arg_639_1.mask_.raycastTarget = true

				arg_639_1:SetGaussion(false)
			end

			local var_642_19 = 2

			if var_642_18 <= arg_639_1.time_ and arg_639_1.time_ < var_642_18 + var_642_19 then
				local var_642_20 = (arg_639_1.time_ - var_642_18) / var_642_19
				local var_642_21 = Color.New(0, 0, 0)

				var_642_21.a = Mathf.Lerp(0, 1, var_642_20)
				arg_639_1.mask_.color = var_642_21
			end

			if arg_639_1.time_ >= var_642_18 + var_642_19 and arg_639_1.time_ < var_642_18 + var_642_19 + arg_642_0 then
				local var_642_22 = Color.New(0, 0, 0)

				var_642_22.a = 1
				arg_639_1.mask_.color = var_642_22
			end

			local var_642_23 = 2

			if var_642_23 < arg_639_1.time_ and arg_639_1.time_ <= var_642_23 + arg_642_0 then
				arg_639_1.mask_.enabled = true
				arg_639_1.mask_.raycastTarget = true

				arg_639_1:SetGaussion(false)
			end

			local var_642_24 = 2

			if var_642_23 <= arg_639_1.time_ and arg_639_1.time_ < var_642_23 + var_642_24 then
				local var_642_25 = (arg_639_1.time_ - var_642_23) / var_642_24
				local var_642_26 = Color.New(0, 0, 0)

				var_642_26.a = Mathf.Lerp(1, 0, var_642_25)
				arg_639_1.mask_.color = var_642_26
			end

			if arg_639_1.time_ >= var_642_23 + var_642_24 and arg_639_1.time_ < var_642_23 + var_642_24 + arg_642_0 then
				local var_642_27 = Color.New(0, 0, 0)
				local var_642_28 = 0

				arg_639_1.mask_.enabled = false
				var_642_27.a = var_642_28
				arg_639_1.mask_.color = var_642_27
			end

			local var_642_29 = arg_639_1.actors_["1022ui_story"].transform
			local var_642_30 = 2

			if var_642_30 < arg_639_1.time_ and arg_639_1.time_ <= var_642_30 + arg_642_0 then
				arg_639_1.var_.moveOldPos1022ui_story = var_642_29.localPosition
			end

			local var_642_31 = 0.001

			if var_642_30 <= arg_639_1.time_ and arg_639_1.time_ < var_642_30 + var_642_31 then
				local var_642_32 = (arg_639_1.time_ - var_642_30) / var_642_31
				local var_642_33 = Vector3.New(0, 100, 0)

				var_642_29.localPosition = Vector3.Lerp(arg_639_1.var_.moveOldPos1022ui_story, var_642_33, var_642_32)

				local var_642_34 = manager.ui.mainCamera.transform.position - var_642_29.position

				var_642_29.forward = Vector3.New(var_642_34.x, var_642_34.y, var_642_34.z)

				local var_642_35 = var_642_29.localEulerAngles

				var_642_35.z = 0
				var_642_35.x = 0
				var_642_29.localEulerAngles = var_642_35
			end

			if arg_639_1.time_ >= var_642_30 + var_642_31 and arg_639_1.time_ < var_642_30 + var_642_31 + arg_642_0 then
				var_642_29.localPosition = Vector3.New(0, 100, 0)

				local var_642_36 = manager.ui.mainCamera.transform.position - var_642_29.position

				var_642_29.forward = Vector3.New(var_642_36.x, var_642_36.y, var_642_36.z)

				local var_642_37 = var_642_29.localEulerAngles

				var_642_37.z = 0
				var_642_37.x = 0
				var_642_29.localEulerAngles = var_642_37
			end

			local var_642_38 = arg_639_1.actors_["1022ui_story"]
			local var_642_39 = 2

			if var_642_39 < arg_639_1.time_ and arg_639_1.time_ <= var_642_39 + arg_642_0 and not isNil(var_642_38) and arg_639_1.var_.characterEffect1022ui_story == nil then
				arg_639_1.var_.characterEffect1022ui_story = var_642_38:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_642_40 = 0.200000002980232

			if var_642_39 <= arg_639_1.time_ and arg_639_1.time_ < var_642_39 + var_642_40 and not isNil(var_642_38) then
				local var_642_41 = (arg_639_1.time_ - var_642_39) / var_642_40

				if arg_639_1.var_.characterEffect1022ui_story and not isNil(var_642_38) then
					local var_642_42 = Mathf.Lerp(0, 0.5, var_642_41)

					arg_639_1.var_.characterEffect1022ui_story.fillFlat = true
					arg_639_1.var_.characterEffect1022ui_story.fillRatio = var_642_42
				end
			end

			if arg_639_1.time_ >= var_642_39 + var_642_40 and arg_639_1.time_ < var_642_39 + var_642_40 + arg_642_0 and not isNil(var_642_38) and arg_639_1.var_.characterEffect1022ui_story then
				local var_642_43 = 0.5

				arg_639_1.var_.characterEffect1022ui_story.fillFlat = true
				arg_639_1.var_.characterEffect1022ui_story.fillRatio = var_642_43
			end

			local var_642_44 = 0.2
			local var_642_45 = 1

			if var_642_44 < arg_639_1.time_ and arg_639_1.time_ <= var_642_44 + arg_642_0 then
				local var_642_46 = "stop"
				local var_642_47 = "effect"

				arg_639_1:AudioAction(var_642_46, var_642_47, "se_story_140", "se_story_140_amb_street02", "")
			end

			local var_642_48 = 1.63333333333333
			local var_642_49 = 1

			if var_642_48 < arg_639_1.time_ and arg_639_1.time_ <= var_642_48 + arg_642_0 then
				local var_642_50 = "play"
				local var_642_51 = "effect"

				arg_639_1:AudioAction(var_642_50, var_642_51, "se_story", "se_story_crowdloop", "")
			end

			if arg_639_1.frameCnt_ <= 1 then
				arg_639_1.dialog_:SetActive(false)
			end

			local var_642_52 = 3.73333333333333
			local var_642_53 = 0.65

			if var_642_52 < arg_639_1.time_ and arg_639_1.time_ <= var_642_52 + arg_642_0 then
				arg_639_1.talkMaxDuration = 0

				arg_639_1.dialog_:SetActive(true)

				arg_639_1.dialogCg_.alpha = 0

				local var_642_54 = LeanTween.value(arg_639_1.dialog_, 0, 1, 0.3)

				var_642_54:setOnUpdate(LuaHelper.FloatAction(function(arg_643_0)
					arg_639_1.dialogCg_.alpha = arg_643_0
				end))
				var_642_54:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_639_1.dialog_)
					var_642_54:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_639_1.duration_ = arg_639_1.duration_ + 0.3

				SetActive(arg_639_1.leftNameGo_, true)

				local var_642_55 = arg_639_1:FormatText(StoryNameCfg[7].name)

				arg_639_1.leftNameTxt_.text = var_642_55

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_639_1.leftNameTxt_.transform)

				arg_639_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_639_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_639_1:RecordName(arg_639_1.leftNameTxt_.text)
				SetActive(arg_639_1.iconTrs_.gameObject, true)
				arg_639_1.iconController_:SetSelectedState("hero")

				arg_639_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_639_1.callingController_:SetSelectedState("normal")

				arg_639_1.keyicon_.color = Color.New(1, 1, 1)
				arg_639_1.icon_.color = Color.New(1, 1, 1)

				local var_642_56 = arg_639_1:GetWordFromCfg(1102205154)
				local var_642_57 = arg_639_1:FormatText(var_642_56.content)

				arg_639_1.text_.text = var_642_57

				LuaForUtil.ClearLinePrefixSymbol(arg_639_1.text_)

				local var_642_58 = 26
				local var_642_59 = utf8.len(var_642_57)
				local var_642_60 = var_642_58 <= 0 and var_642_53 or var_642_53 * (var_642_59 / var_642_58)

				if var_642_60 > 0 and var_642_53 < var_642_60 then
					arg_639_1.talkMaxDuration = var_642_60
					var_642_52 = var_642_52 + 0.3

					if var_642_60 + var_642_52 > arg_639_1.duration_ then
						arg_639_1.duration_ = var_642_60 + var_642_52
					end
				end

				arg_639_1.text_.text = var_642_57
				arg_639_1.typewritter.percent = 0

				arg_639_1.typewritter:SetDirty()
				arg_639_1:ShowNextGo(false)
				arg_639_1:RecordContent(arg_639_1.text_.text)
			end

			local var_642_61 = var_642_52 + 0.3
			local var_642_62 = math.max(var_642_53, arg_639_1.talkMaxDuration)

			if var_642_61 <= arg_639_1.time_ and arg_639_1.time_ < var_642_61 + var_642_62 then
				arg_639_1.typewritter.percent = (arg_639_1.time_ - var_642_61) / var_642_62

				arg_639_1.typewritter:SetDirty()
			end

			if arg_639_1.time_ >= var_642_61 + var_642_62 and arg_639_1.time_ < var_642_61 + var_642_62 + arg_642_0 then
				arg_639_1.typewritter.percent = 1

				arg_639_1.typewritter:SetDirty()
				arg_639_1:ShowNextGo(true)
			end
		end

		arg_639_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1022ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_639_1:InitPlayNodeList()
	end,
	Play1102205155 = function(arg_645_0, arg_645_1)
		arg_645_1.time_ = 0
		arg_645_1.frameCnt_ = 0
		arg_645_1.state_ = "playing"
		arg_645_1.curTalkId_ = 1102205155
		arg_645_1.duration_ = 5

		SetActive(arg_645_1.tipsGo_, false)

		function arg_645_1.onSingleLineFinish_()
			arg_645_1.onSingleLineUpdate_ = nil
			arg_645_1.onSingleLineFinish_ = nil
			arg_645_1.state_ = "waiting"
		end

		function arg_645_1.playNext_(arg_647_0)
			if arg_647_0 == 1 then
				arg_645_0:Play1102205156(arg_645_1)
			end
		end

		function arg_645_1.onSingleLineUpdate_(arg_648_0)
			local var_648_0 = 0
			local var_648_1 = 1.2

			if var_648_0 < arg_645_1.time_ and arg_645_1.time_ <= var_648_0 + arg_648_0 then
				arg_645_1.talkMaxDuration = 0
				arg_645_1.dialogCg_.alpha = 1

				arg_645_1.dialog_:SetActive(true)
				SetActive(arg_645_1.leftNameGo_, false)

				arg_645_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_645_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_645_1:RecordName(arg_645_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_645_1.iconTrs_.gameObject, false)
				arg_645_1.callingController_:SetSelectedState("normal")

				local var_648_2 = arg_645_1:GetWordFromCfg(1102205155)
				local var_648_3 = arg_645_1:FormatText(var_648_2.content)

				arg_645_1.text_.text = var_648_3

				LuaForUtil.ClearLinePrefixSymbol(arg_645_1.text_)

				local var_648_4 = 48
				local var_648_5 = utf8.len(var_648_3)
				local var_648_6 = var_648_4 <= 0 and var_648_1 or var_648_1 * (var_648_5 / var_648_4)

				if var_648_6 > 0 and var_648_1 < var_648_6 then
					arg_645_1.talkMaxDuration = var_648_6

					if var_648_6 + var_648_0 > arg_645_1.duration_ then
						arg_645_1.duration_ = var_648_6 + var_648_0
					end
				end

				arg_645_1.text_.text = var_648_3
				arg_645_1.typewritter.percent = 0

				arg_645_1.typewritter:SetDirty()
				arg_645_1:ShowNextGo(false)
				arg_645_1:RecordContent(arg_645_1.text_.text)
			end

			local var_648_7 = math.max(var_648_1, arg_645_1.talkMaxDuration)

			if var_648_0 <= arg_645_1.time_ and arg_645_1.time_ < var_648_0 + var_648_7 then
				arg_645_1.typewritter.percent = (arg_645_1.time_ - var_648_0) / var_648_7

				arg_645_1.typewritter:SetDirty()
			end

			if arg_645_1.time_ >= var_648_0 + var_648_7 and arg_645_1.time_ < var_648_0 + var_648_7 + arg_648_0 then
				arg_645_1.typewritter.percent = 1

				arg_645_1.typewritter:SetDirty()
				arg_645_1:ShowNextGo(true)
			end
		end

		arg_645_1.nodeConfigList_ = {}

		arg_645_1:InitPlayNodeList()
	end,
	Play1102205156 = function(arg_649_0, arg_649_1)
		arg_649_1.time_ = 0
		arg_649_1.frameCnt_ = 0
		arg_649_1.state_ = "playing"
		arg_649_1.curTalkId_ = 1102205156
		arg_649_1.duration_ = 2.3

		SetActive(arg_649_1.tipsGo_, false)

		function arg_649_1.onSingleLineFinish_()
			arg_649_1.onSingleLineUpdate_ = nil
			arg_649_1.onSingleLineFinish_ = nil
			arg_649_1.state_ = "waiting"
		end

		function arg_649_1.playNext_(arg_651_0)
			if arg_651_0 == 1 then
				arg_649_0:Play1102205157(arg_649_1)
			end
		end

		function arg_649_1.onSingleLineUpdate_(arg_652_0)
			local var_652_0 = arg_649_1.actors_["1022ui_story"].transform
			local var_652_1 = 0

			if var_652_1 < arg_649_1.time_ and arg_649_1.time_ <= var_652_1 + arg_652_0 then
				arg_649_1.var_.moveOldPos1022ui_story = var_652_0.localPosition
			end

			local var_652_2 = 0.001

			if var_652_1 <= arg_649_1.time_ and arg_649_1.time_ < var_652_1 + var_652_2 then
				local var_652_3 = (arg_649_1.time_ - var_652_1) / var_652_2
				local var_652_4 = Vector3.New(0, -1.08, -6)

				var_652_0.localPosition = Vector3.Lerp(arg_649_1.var_.moveOldPos1022ui_story, var_652_4, var_652_3)

				local var_652_5 = manager.ui.mainCamera.transform.position - var_652_0.position

				var_652_0.forward = Vector3.New(var_652_5.x, var_652_5.y, var_652_5.z)

				local var_652_6 = var_652_0.localEulerAngles

				var_652_6.z = 0
				var_652_6.x = 0
				var_652_0.localEulerAngles = var_652_6
			end

			if arg_649_1.time_ >= var_652_1 + var_652_2 and arg_649_1.time_ < var_652_1 + var_652_2 + arg_652_0 then
				var_652_0.localPosition = Vector3.New(0, -1.08, -6)

				local var_652_7 = manager.ui.mainCamera.transform.position - var_652_0.position

				var_652_0.forward = Vector3.New(var_652_7.x, var_652_7.y, var_652_7.z)

				local var_652_8 = var_652_0.localEulerAngles

				var_652_8.z = 0
				var_652_8.x = 0
				var_652_0.localEulerAngles = var_652_8
			end

			local var_652_9 = arg_649_1.actors_["1022ui_story"]
			local var_652_10 = 0

			if var_652_10 < arg_649_1.time_ and arg_649_1.time_ <= var_652_10 + arg_652_0 and not isNil(var_652_9) and arg_649_1.var_.characterEffect1022ui_story == nil then
				arg_649_1.var_.characterEffect1022ui_story = var_652_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_652_11 = 0.200000002980232

			if var_652_10 <= arg_649_1.time_ and arg_649_1.time_ < var_652_10 + var_652_11 and not isNil(var_652_9) then
				local var_652_12 = (arg_649_1.time_ - var_652_10) / var_652_11

				if arg_649_1.var_.characterEffect1022ui_story and not isNil(var_652_9) then
					arg_649_1.var_.characterEffect1022ui_story.fillFlat = false
				end
			end

			if arg_649_1.time_ >= var_652_10 + var_652_11 and arg_649_1.time_ < var_652_10 + var_652_11 + arg_652_0 and not isNil(var_652_9) and arg_649_1.var_.characterEffect1022ui_story then
				arg_649_1.var_.characterEffect1022ui_story.fillFlat = false
			end

			local var_652_13 = 0

			if var_652_13 < arg_649_1.time_ and arg_649_1.time_ <= var_652_13 + arg_652_0 then
				arg_649_1:PlayTimeline("1022ui_story", "StoryTimeline/CharAction/story1022/story1022action/1022action7_1")
			end

			local var_652_14 = 0

			if var_652_14 < arg_649_1.time_ and arg_649_1.time_ <= var_652_14 + arg_652_0 then
				arg_649_1:PlayTimeline("1022ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_652_15 = 0
			local var_652_16 = 0.175

			if var_652_15 < arg_649_1.time_ and arg_649_1.time_ <= var_652_15 + arg_652_0 then
				arg_649_1.talkMaxDuration = 0
				arg_649_1.dialogCg_.alpha = 1

				arg_649_1.dialog_:SetActive(true)
				SetActive(arg_649_1.leftNameGo_, true)

				local var_652_17 = arg_649_1:FormatText(StoryNameCfg[259].name)

				arg_649_1.leftNameTxt_.text = var_652_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_649_1.leftNameTxt_.transform)

				arg_649_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_649_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_649_1:RecordName(arg_649_1.leftNameTxt_.text)
				SetActive(arg_649_1.iconTrs_.gameObject, false)
				arg_649_1.callingController_:SetSelectedState("normal")

				local var_652_18 = arg_649_1:GetWordFromCfg(1102205156)
				local var_652_19 = arg_649_1:FormatText(var_652_18.content)

				arg_649_1.text_.text = var_652_19

				LuaForUtil.ClearLinePrefixSymbol(arg_649_1.text_)

				local var_652_20 = 7
				local var_652_21 = utf8.len(var_652_19)
				local var_652_22 = var_652_20 <= 0 and var_652_16 or var_652_16 * (var_652_21 / var_652_20)

				if var_652_22 > 0 and var_652_16 < var_652_22 then
					arg_649_1.talkMaxDuration = var_652_22

					if var_652_22 + var_652_15 > arg_649_1.duration_ then
						arg_649_1.duration_ = var_652_22 + var_652_15
					end
				end

				arg_649_1.text_.text = var_652_19
				arg_649_1.typewritter.percent = 0

				arg_649_1.typewritter:SetDirty()
				arg_649_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205156", "story_v_side_new_1102205.awb") ~= 0 then
					local var_652_23 = manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205156", "story_v_side_new_1102205.awb") / 1000

					if var_652_23 + var_652_15 > arg_649_1.duration_ then
						arg_649_1.duration_ = var_652_23 + var_652_15
					end

					if var_652_18.prefab_name ~= "" and arg_649_1.actors_[var_652_18.prefab_name] ~= nil then
						local var_652_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_649_1.actors_[var_652_18.prefab_name].transform, "story_v_side_new_1102205", "1102205156", "story_v_side_new_1102205.awb")

						arg_649_1:RecordAudio("1102205156", var_652_24)
						arg_649_1:RecordAudio("1102205156", var_652_24)
					else
						arg_649_1:AudioAction("play", "voice", "story_v_side_new_1102205", "1102205156", "story_v_side_new_1102205.awb")
					end

					arg_649_1:RecordHistoryTalkVoice("story_v_side_new_1102205", "1102205156", "story_v_side_new_1102205.awb")
				end

				arg_649_1:RecordContent(arg_649_1.text_.text)
			end

			local var_652_25 = math.max(var_652_16, arg_649_1.talkMaxDuration)

			if var_652_15 <= arg_649_1.time_ and arg_649_1.time_ < var_652_15 + var_652_25 then
				arg_649_1.typewritter.percent = (arg_649_1.time_ - var_652_15) / var_652_25

				arg_649_1.typewritter:SetDirty()
			end

			if arg_649_1.time_ >= var_652_15 + var_652_25 and arg_649_1.time_ < var_652_15 + var_652_25 + arg_652_0 then
				arg_649_1.typewritter.percent = 1

				arg_649_1.typewritter:SetDirty()
				arg_649_1:ShowNextGo(true)
			end
		end

		arg_649_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1022ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_649_1:InitPlayNodeList()
	end,
	Play1102205157 = function(arg_653_0, arg_653_1)
		arg_653_1.time_ = 0
		arg_653_1.frameCnt_ = 0
		arg_653_1.state_ = "playing"
		arg_653_1.curTalkId_ = 1102205157
		arg_653_1.duration_ = 5

		SetActive(arg_653_1.tipsGo_, false)

		function arg_653_1.onSingleLineFinish_()
			arg_653_1.onSingleLineUpdate_ = nil
			arg_653_1.onSingleLineFinish_ = nil
			arg_653_1.state_ = "waiting"
		end

		function arg_653_1.playNext_(arg_655_0)
			if arg_655_0 == 1 then
				arg_653_0:Play1102205158(arg_653_1)
			end
		end

		function arg_653_1.onSingleLineUpdate_(arg_656_0)
			local var_656_0 = arg_653_1.actors_["1022ui_story"]
			local var_656_1 = 0

			if var_656_1 < arg_653_1.time_ and arg_653_1.time_ <= var_656_1 + arg_656_0 and not isNil(var_656_0) and arg_653_1.var_.characterEffect1022ui_story == nil then
				arg_653_1.var_.characterEffect1022ui_story = var_656_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_656_2 = 0.200000002980232

			if var_656_1 <= arg_653_1.time_ and arg_653_1.time_ < var_656_1 + var_656_2 and not isNil(var_656_0) then
				local var_656_3 = (arg_653_1.time_ - var_656_1) / var_656_2

				if arg_653_1.var_.characterEffect1022ui_story and not isNil(var_656_0) then
					local var_656_4 = Mathf.Lerp(0, 0.5, var_656_3)

					arg_653_1.var_.characterEffect1022ui_story.fillFlat = true
					arg_653_1.var_.characterEffect1022ui_story.fillRatio = var_656_4
				end
			end

			if arg_653_1.time_ >= var_656_1 + var_656_2 and arg_653_1.time_ < var_656_1 + var_656_2 + arg_656_0 and not isNil(var_656_0) and arg_653_1.var_.characterEffect1022ui_story then
				local var_656_5 = 0.5

				arg_653_1.var_.characterEffect1022ui_story.fillFlat = true
				arg_653_1.var_.characterEffect1022ui_story.fillRatio = var_656_5
			end

			local var_656_6 = 0
			local var_656_7 = 0.725

			if var_656_6 < arg_653_1.time_ and arg_653_1.time_ <= var_656_6 + arg_656_0 then
				arg_653_1.talkMaxDuration = 0
				arg_653_1.dialogCg_.alpha = 1

				arg_653_1.dialog_:SetActive(true)
				SetActive(arg_653_1.leftNameGo_, true)

				local var_656_8 = arg_653_1:FormatText(StoryNameCfg[7].name)

				arg_653_1.leftNameTxt_.text = var_656_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_653_1.leftNameTxt_.transform)

				arg_653_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_653_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_653_1:RecordName(arg_653_1.leftNameTxt_.text)
				SetActive(arg_653_1.iconTrs_.gameObject, true)
				arg_653_1.iconController_:SetSelectedState("hero")

				arg_653_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_653_1.callingController_:SetSelectedState("normal")

				arg_653_1.keyicon_.color = Color.New(1, 1, 1)
				arg_653_1.icon_.color = Color.New(1, 1, 1)

				local var_656_9 = arg_653_1:GetWordFromCfg(1102205157)
				local var_656_10 = arg_653_1:FormatText(var_656_9.content)

				arg_653_1.text_.text = var_656_10

				LuaForUtil.ClearLinePrefixSymbol(arg_653_1.text_)

				local var_656_11 = 29
				local var_656_12 = utf8.len(var_656_10)
				local var_656_13 = var_656_11 <= 0 and var_656_7 or var_656_7 * (var_656_12 / var_656_11)

				if var_656_13 > 0 and var_656_7 < var_656_13 then
					arg_653_1.talkMaxDuration = var_656_13

					if var_656_13 + var_656_6 > arg_653_1.duration_ then
						arg_653_1.duration_ = var_656_13 + var_656_6
					end
				end

				arg_653_1.text_.text = var_656_10
				arg_653_1.typewritter.percent = 0

				arg_653_1.typewritter:SetDirty()
				arg_653_1:ShowNextGo(false)
				arg_653_1:RecordContent(arg_653_1.text_.text)
			end

			local var_656_14 = math.max(var_656_7, arg_653_1.talkMaxDuration)

			if var_656_6 <= arg_653_1.time_ and arg_653_1.time_ < var_656_6 + var_656_14 then
				arg_653_1.typewritter.percent = (arg_653_1.time_ - var_656_6) / var_656_14

				arg_653_1.typewritter:SetDirty()
			end

			if arg_653_1.time_ >= var_656_6 + var_656_14 and arg_653_1.time_ < var_656_6 + var_656_14 + arg_656_0 then
				arg_653_1.typewritter.percent = 1

				arg_653_1.typewritter:SetDirty()
				arg_653_1:ShowNextGo(true)
			end
		end

		arg_653_1.nodeConfigList_ = {}

		arg_653_1:InitPlayNodeList()
	end,
	Play1102205158 = function(arg_657_0, arg_657_1)
		arg_657_1.time_ = 0
		arg_657_1.frameCnt_ = 0
		arg_657_1.state_ = "playing"
		arg_657_1.curTalkId_ = 1102205158
		arg_657_1.duration_ = 6.7

		SetActive(arg_657_1.tipsGo_, false)

		function arg_657_1.onSingleLineFinish_()
			arg_657_1.onSingleLineUpdate_ = nil
			arg_657_1.onSingleLineFinish_ = nil
			arg_657_1.state_ = "waiting"
		end

		function arg_657_1.playNext_(arg_659_0)
			if arg_659_0 == 1 then
				arg_657_0:Play1102205159(arg_657_1)
			end
		end

		function arg_657_1.onSingleLineUpdate_(arg_660_0)
			local var_660_0 = arg_657_1.actors_["1022ui_story"]
			local var_660_1 = 0

			if var_660_1 < arg_657_1.time_ and arg_657_1.time_ <= var_660_1 + arg_660_0 and not isNil(var_660_0) and arg_657_1.var_.characterEffect1022ui_story == nil then
				arg_657_1.var_.characterEffect1022ui_story = var_660_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_660_2 = 0.200000002980232

			if var_660_1 <= arg_657_1.time_ and arg_657_1.time_ < var_660_1 + var_660_2 and not isNil(var_660_0) then
				local var_660_3 = (arg_657_1.time_ - var_660_1) / var_660_2

				if arg_657_1.var_.characterEffect1022ui_story and not isNil(var_660_0) then
					arg_657_1.var_.characterEffect1022ui_story.fillFlat = false
				end
			end

			if arg_657_1.time_ >= var_660_1 + var_660_2 and arg_657_1.time_ < var_660_1 + var_660_2 + arg_660_0 and not isNil(var_660_0) and arg_657_1.var_.characterEffect1022ui_story then
				arg_657_1.var_.characterEffect1022ui_story.fillFlat = false
			end

			local var_660_4 = 0
			local var_660_5 = 0.75

			if var_660_4 < arg_657_1.time_ and arg_657_1.time_ <= var_660_4 + arg_660_0 then
				arg_657_1.talkMaxDuration = 0
				arg_657_1.dialogCg_.alpha = 1

				arg_657_1.dialog_:SetActive(true)
				SetActive(arg_657_1.leftNameGo_, true)

				local var_660_6 = arg_657_1:FormatText(StoryNameCfg[259].name)

				arg_657_1.leftNameTxt_.text = var_660_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_657_1.leftNameTxt_.transform)

				arg_657_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_657_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_657_1:RecordName(arg_657_1.leftNameTxt_.text)
				SetActive(arg_657_1.iconTrs_.gameObject, false)
				arg_657_1.callingController_:SetSelectedState("normal")

				local var_660_7 = arg_657_1:GetWordFromCfg(1102205158)
				local var_660_8 = arg_657_1:FormatText(var_660_7.content)

				arg_657_1.text_.text = var_660_8

				LuaForUtil.ClearLinePrefixSymbol(arg_657_1.text_)

				local var_660_9 = 30
				local var_660_10 = utf8.len(var_660_8)
				local var_660_11 = var_660_9 <= 0 and var_660_5 or var_660_5 * (var_660_10 / var_660_9)

				if var_660_11 > 0 and var_660_5 < var_660_11 then
					arg_657_1.talkMaxDuration = var_660_11

					if var_660_11 + var_660_4 > arg_657_1.duration_ then
						arg_657_1.duration_ = var_660_11 + var_660_4
					end
				end

				arg_657_1.text_.text = var_660_8
				arg_657_1.typewritter.percent = 0

				arg_657_1.typewritter:SetDirty()
				arg_657_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205158", "story_v_side_new_1102205.awb") ~= 0 then
					local var_660_12 = manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205158", "story_v_side_new_1102205.awb") / 1000

					if var_660_12 + var_660_4 > arg_657_1.duration_ then
						arg_657_1.duration_ = var_660_12 + var_660_4
					end

					if var_660_7.prefab_name ~= "" and arg_657_1.actors_[var_660_7.prefab_name] ~= nil then
						local var_660_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_657_1.actors_[var_660_7.prefab_name].transform, "story_v_side_new_1102205", "1102205158", "story_v_side_new_1102205.awb")

						arg_657_1:RecordAudio("1102205158", var_660_13)
						arg_657_1:RecordAudio("1102205158", var_660_13)
					else
						arg_657_1:AudioAction("play", "voice", "story_v_side_new_1102205", "1102205158", "story_v_side_new_1102205.awb")
					end

					arg_657_1:RecordHistoryTalkVoice("story_v_side_new_1102205", "1102205158", "story_v_side_new_1102205.awb")
				end

				arg_657_1:RecordContent(arg_657_1.text_.text)
			end

			local var_660_14 = math.max(var_660_5, arg_657_1.talkMaxDuration)

			if var_660_4 <= arg_657_1.time_ and arg_657_1.time_ < var_660_4 + var_660_14 then
				arg_657_1.typewritter.percent = (arg_657_1.time_ - var_660_4) / var_660_14

				arg_657_1.typewritter:SetDirty()
			end

			if arg_657_1.time_ >= var_660_4 + var_660_14 and arg_657_1.time_ < var_660_4 + var_660_14 + arg_660_0 then
				arg_657_1.typewritter.percent = 1

				arg_657_1.typewritter:SetDirty()
				arg_657_1:ShowNextGo(true)
			end
		end

		arg_657_1.nodeConfigList_ = {}

		arg_657_1:InitPlayNodeList()
	end,
	Play1102205159 = function(arg_661_0, arg_661_1)
		arg_661_1.time_ = 0
		arg_661_1.frameCnt_ = 0
		arg_661_1.state_ = "playing"
		arg_661_1.curTalkId_ = 1102205159
		arg_661_1.duration_ = 9.5

		SetActive(arg_661_1.tipsGo_, false)

		function arg_661_1.onSingleLineFinish_()
			arg_661_1.onSingleLineUpdate_ = nil
			arg_661_1.onSingleLineFinish_ = nil
			arg_661_1.state_ = "waiting"
		end

		function arg_661_1.playNext_(arg_663_0)
			if arg_663_0 == 1 then
				arg_661_0:Play1102205160(arg_661_1)
			end
		end

		function arg_661_1.onSingleLineUpdate_(arg_664_0)
			local var_664_0 = 0

			if var_664_0 < arg_661_1.time_ and arg_661_1.time_ <= var_664_0 + arg_664_0 then
				arg_661_1:PlayTimeline("1022ui_story", "StoryTimeline/CharAction/story1022/story1022action/1022action7_2")
			end

			local var_664_1 = 0

			if var_664_1 < arg_661_1.time_ and arg_661_1.time_ <= var_664_1 + arg_664_0 then
				arg_661_1:PlayTimeline("1022ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_664_2 = 0
			local var_664_3 = 0.95

			if var_664_2 < arg_661_1.time_ and arg_661_1.time_ <= var_664_2 + arg_664_0 then
				arg_661_1.talkMaxDuration = 0
				arg_661_1.dialogCg_.alpha = 1

				arg_661_1.dialog_:SetActive(true)
				SetActive(arg_661_1.leftNameGo_, true)

				local var_664_4 = arg_661_1:FormatText(StoryNameCfg[259].name)

				arg_661_1.leftNameTxt_.text = var_664_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_661_1.leftNameTxt_.transform)

				arg_661_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_661_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_661_1:RecordName(arg_661_1.leftNameTxt_.text)
				SetActive(arg_661_1.iconTrs_.gameObject, false)
				arg_661_1.callingController_:SetSelectedState("normal")

				local var_664_5 = arg_661_1:GetWordFromCfg(1102205159)
				local var_664_6 = arg_661_1:FormatText(var_664_5.content)

				arg_661_1.text_.text = var_664_6

				LuaForUtil.ClearLinePrefixSymbol(arg_661_1.text_)

				local var_664_7 = 38
				local var_664_8 = utf8.len(var_664_6)
				local var_664_9 = var_664_7 <= 0 and var_664_3 or var_664_3 * (var_664_8 / var_664_7)

				if var_664_9 > 0 and var_664_3 < var_664_9 then
					arg_661_1.talkMaxDuration = var_664_9

					if var_664_9 + var_664_2 > arg_661_1.duration_ then
						arg_661_1.duration_ = var_664_9 + var_664_2
					end
				end

				arg_661_1.text_.text = var_664_6
				arg_661_1.typewritter.percent = 0

				arg_661_1.typewritter:SetDirty()
				arg_661_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205159", "story_v_side_new_1102205.awb") ~= 0 then
					local var_664_10 = manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205159", "story_v_side_new_1102205.awb") / 1000

					if var_664_10 + var_664_2 > arg_661_1.duration_ then
						arg_661_1.duration_ = var_664_10 + var_664_2
					end

					if var_664_5.prefab_name ~= "" and arg_661_1.actors_[var_664_5.prefab_name] ~= nil then
						local var_664_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_661_1.actors_[var_664_5.prefab_name].transform, "story_v_side_new_1102205", "1102205159", "story_v_side_new_1102205.awb")

						arg_661_1:RecordAudio("1102205159", var_664_11)
						arg_661_1:RecordAudio("1102205159", var_664_11)
					else
						arg_661_1:AudioAction("play", "voice", "story_v_side_new_1102205", "1102205159", "story_v_side_new_1102205.awb")
					end

					arg_661_1:RecordHistoryTalkVoice("story_v_side_new_1102205", "1102205159", "story_v_side_new_1102205.awb")
				end

				arg_661_1:RecordContent(arg_661_1.text_.text)
			end

			local var_664_12 = math.max(var_664_3, arg_661_1.talkMaxDuration)

			if var_664_2 <= arg_661_1.time_ and arg_661_1.time_ < var_664_2 + var_664_12 then
				arg_661_1.typewritter.percent = (arg_661_1.time_ - var_664_2) / var_664_12

				arg_661_1.typewritter:SetDirty()
			end

			if arg_661_1.time_ >= var_664_2 + var_664_12 and arg_661_1.time_ < var_664_2 + var_664_12 + arg_664_0 then
				arg_661_1.typewritter.percent = 1

				arg_661_1.typewritter:SetDirty()
				arg_661_1:ShowNextGo(true)
			end
		end

		arg_661_1.nodeConfigList_ = {}

		arg_661_1:InitPlayNodeList()
	end,
	Play1102205160 = function(arg_665_0, arg_665_1)
		arg_665_1.time_ = 0
		arg_665_1.frameCnt_ = 0
		arg_665_1.state_ = "playing"
		arg_665_1.curTalkId_ = 1102205160
		arg_665_1.duration_ = 5

		SetActive(arg_665_1.tipsGo_, false)

		function arg_665_1.onSingleLineFinish_()
			arg_665_1.onSingleLineUpdate_ = nil
			arg_665_1.onSingleLineFinish_ = nil
			arg_665_1.state_ = "waiting"
		end

		function arg_665_1.playNext_(arg_667_0)
			if arg_667_0 == 1 then
				arg_665_0:Play1102205161(arg_665_1)
			end
		end

		function arg_665_1.onSingleLineUpdate_(arg_668_0)
			local var_668_0 = arg_665_1.actors_["1022ui_story"].transform
			local var_668_1 = 0

			if var_668_1 < arg_665_1.time_ and arg_665_1.time_ <= var_668_1 + arg_668_0 then
				arg_665_1.var_.moveOldPos1022ui_story = var_668_0.localPosition
			end

			local var_668_2 = 0.001

			if var_668_1 <= arg_665_1.time_ and arg_665_1.time_ < var_668_1 + var_668_2 then
				local var_668_3 = (arg_665_1.time_ - var_668_1) / var_668_2
				local var_668_4 = Vector3.New(0, 100, 0)

				var_668_0.localPosition = Vector3.Lerp(arg_665_1.var_.moveOldPos1022ui_story, var_668_4, var_668_3)

				local var_668_5 = manager.ui.mainCamera.transform.position - var_668_0.position

				var_668_0.forward = Vector3.New(var_668_5.x, var_668_5.y, var_668_5.z)

				local var_668_6 = var_668_0.localEulerAngles

				var_668_6.z = 0
				var_668_6.x = 0
				var_668_0.localEulerAngles = var_668_6
			end

			if arg_665_1.time_ >= var_668_1 + var_668_2 and arg_665_1.time_ < var_668_1 + var_668_2 + arg_668_0 then
				var_668_0.localPosition = Vector3.New(0, 100, 0)

				local var_668_7 = manager.ui.mainCamera.transform.position - var_668_0.position

				var_668_0.forward = Vector3.New(var_668_7.x, var_668_7.y, var_668_7.z)

				local var_668_8 = var_668_0.localEulerAngles

				var_668_8.z = 0
				var_668_8.x = 0
				var_668_0.localEulerAngles = var_668_8
			end

			local var_668_9 = arg_665_1.actors_["1022ui_story"]
			local var_668_10 = 0

			if var_668_10 < arg_665_1.time_ and arg_665_1.time_ <= var_668_10 + arg_668_0 and not isNil(var_668_9) and arg_665_1.var_.characterEffect1022ui_story == nil then
				arg_665_1.var_.characterEffect1022ui_story = var_668_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_668_11 = 0.200000002980232

			if var_668_10 <= arg_665_1.time_ and arg_665_1.time_ < var_668_10 + var_668_11 and not isNil(var_668_9) then
				local var_668_12 = (arg_665_1.time_ - var_668_10) / var_668_11

				if arg_665_1.var_.characterEffect1022ui_story and not isNil(var_668_9) then
					local var_668_13 = Mathf.Lerp(0, 0.5, var_668_12)

					arg_665_1.var_.characterEffect1022ui_story.fillFlat = true
					arg_665_1.var_.characterEffect1022ui_story.fillRatio = var_668_13
				end
			end

			if arg_665_1.time_ >= var_668_10 + var_668_11 and arg_665_1.time_ < var_668_10 + var_668_11 + arg_668_0 and not isNil(var_668_9) and arg_665_1.var_.characterEffect1022ui_story then
				local var_668_14 = 0.5

				arg_665_1.var_.characterEffect1022ui_story.fillFlat = true
				arg_665_1.var_.characterEffect1022ui_story.fillRatio = var_668_14
			end

			local var_668_15 = 0
			local var_668_16 = 1.15

			if var_668_15 < arg_665_1.time_ and arg_665_1.time_ <= var_668_15 + arg_668_0 then
				arg_665_1.talkMaxDuration = 0
				arg_665_1.dialogCg_.alpha = 1

				arg_665_1.dialog_:SetActive(true)
				SetActive(arg_665_1.leftNameGo_, false)

				arg_665_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_665_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_665_1:RecordName(arg_665_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_665_1.iconTrs_.gameObject, false)
				arg_665_1.callingController_:SetSelectedState("normal")

				local var_668_17 = arg_665_1:GetWordFromCfg(1102205160)
				local var_668_18 = arg_665_1:FormatText(var_668_17.content)

				arg_665_1.text_.text = var_668_18

				LuaForUtil.ClearLinePrefixSymbol(arg_665_1.text_)

				local var_668_19 = 46
				local var_668_20 = utf8.len(var_668_18)
				local var_668_21 = var_668_19 <= 0 and var_668_16 or var_668_16 * (var_668_20 / var_668_19)

				if var_668_21 > 0 and var_668_16 < var_668_21 then
					arg_665_1.talkMaxDuration = var_668_21

					if var_668_21 + var_668_15 > arg_665_1.duration_ then
						arg_665_1.duration_ = var_668_21 + var_668_15
					end
				end

				arg_665_1.text_.text = var_668_18
				arg_665_1.typewritter.percent = 0

				arg_665_1.typewritter:SetDirty()
				arg_665_1:ShowNextGo(false)
				arg_665_1:RecordContent(arg_665_1.text_.text)
			end

			local var_668_22 = math.max(var_668_16, arg_665_1.talkMaxDuration)

			if var_668_15 <= arg_665_1.time_ and arg_665_1.time_ < var_668_15 + var_668_22 then
				arg_665_1.typewritter.percent = (arg_665_1.time_ - var_668_15) / var_668_22

				arg_665_1.typewritter:SetDirty()
			end

			if arg_665_1.time_ >= var_668_15 + var_668_22 and arg_665_1.time_ < var_668_15 + var_668_22 + arg_668_0 then
				arg_665_1.typewritter.percent = 1

				arg_665_1.typewritter:SetDirty()
				arg_665_1:ShowNextGo(true)
			end
		end

		arg_665_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1022ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_665_1:InitPlayNodeList()
	end,
	Play1102205161 = function(arg_669_0, arg_669_1)
		arg_669_1.time_ = 0
		arg_669_1.frameCnt_ = 0
		arg_669_1.state_ = "playing"
		arg_669_1.curTalkId_ = 1102205161
		arg_669_1.duration_ = 5

		SetActive(arg_669_1.tipsGo_, false)

		function arg_669_1.onSingleLineFinish_()
			arg_669_1.onSingleLineUpdate_ = nil
			arg_669_1.onSingleLineFinish_ = nil
			arg_669_1.state_ = "waiting"
		end

		function arg_669_1.playNext_(arg_671_0)
			if arg_671_0 == 1 then
				arg_669_0:Play1102205162(arg_669_1)
			end
		end

		function arg_669_1.onSingleLineUpdate_(arg_672_0)
			local var_672_0 = 0
			local var_672_1 = 1

			if var_672_0 < arg_669_1.time_ and arg_669_1.time_ <= var_672_0 + arg_672_0 then
				arg_669_1.talkMaxDuration = 0
				arg_669_1.dialogCg_.alpha = 1

				arg_669_1.dialog_:SetActive(true)
				SetActive(arg_669_1.leftNameGo_, true)

				local var_672_2 = arg_669_1:FormatText(StoryNameCfg[7].name)

				arg_669_1.leftNameTxt_.text = var_672_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_669_1.leftNameTxt_.transform)

				arg_669_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_669_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_669_1:RecordName(arg_669_1.leftNameTxt_.text)
				SetActive(arg_669_1.iconTrs_.gameObject, true)
				arg_669_1.iconController_:SetSelectedState("hero")

				arg_669_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_669_1.callingController_:SetSelectedState("normal")

				arg_669_1.keyicon_.color = Color.New(1, 1, 1)
				arg_669_1.icon_.color = Color.New(1, 1, 1)

				local var_672_3 = arg_669_1:GetWordFromCfg(1102205161)
				local var_672_4 = arg_669_1:FormatText(var_672_3.content)

				arg_669_1.text_.text = var_672_4

				LuaForUtil.ClearLinePrefixSymbol(arg_669_1.text_)

				local var_672_5 = 40
				local var_672_6 = utf8.len(var_672_4)
				local var_672_7 = var_672_5 <= 0 and var_672_1 or var_672_1 * (var_672_6 / var_672_5)

				if var_672_7 > 0 and var_672_1 < var_672_7 then
					arg_669_1.talkMaxDuration = var_672_7

					if var_672_7 + var_672_0 > arg_669_1.duration_ then
						arg_669_1.duration_ = var_672_7 + var_672_0
					end
				end

				arg_669_1.text_.text = var_672_4
				arg_669_1.typewritter.percent = 0

				arg_669_1.typewritter:SetDirty()
				arg_669_1:ShowNextGo(false)
				arg_669_1:RecordContent(arg_669_1.text_.text)
			end

			local var_672_8 = math.max(var_672_1, arg_669_1.talkMaxDuration)

			if var_672_0 <= arg_669_1.time_ and arg_669_1.time_ < var_672_0 + var_672_8 then
				arg_669_1.typewritter.percent = (arg_669_1.time_ - var_672_0) / var_672_8

				arg_669_1.typewritter:SetDirty()
			end

			if arg_669_1.time_ >= var_672_0 + var_672_8 and arg_669_1.time_ < var_672_0 + var_672_8 + arg_672_0 then
				arg_669_1.typewritter.percent = 1

				arg_669_1.typewritter:SetDirty()
				arg_669_1:ShowNextGo(true)
			end
		end

		arg_669_1.nodeConfigList_ = {}

		arg_669_1:InitPlayNodeList()
	end,
	Play1102205162 = function(arg_673_0, arg_673_1)
		arg_673_1.time_ = 0
		arg_673_1.frameCnt_ = 0
		arg_673_1.state_ = "playing"
		arg_673_1.curTalkId_ = 1102205162
		arg_673_1.duration_ = 7.53

		SetActive(arg_673_1.tipsGo_, false)

		function arg_673_1.onSingleLineFinish_()
			arg_673_1.onSingleLineUpdate_ = nil
			arg_673_1.onSingleLineFinish_ = nil
			arg_673_1.state_ = "waiting"
		end

		function arg_673_1.playNext_(arg_675_0)
			if arg_675_0 == 1 then
				arg_673_0:Play1102205163(arg_673_1)
			end
		end

		function arg_673_1.onSingleLineUpdate_(arg_676_0)
			local var_676_0 = arg_673_1.actors_["1022ui_story"]
			local var_676_1 = 0

			if var_676_1 < arg_673_1.time_ and arg_673_1.time_ <= var_676_1 + arg_676_0 and not isNil(var_676_0) and arg_673_1.var_.characterEffect1022ui_story == nil then
				arg_673_1.var_.characterEffect1022ui_story = var_676_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_676_2 = 0.200000002980232

			if var_676_1 <= arg_673_1.time_ and arg_673_1.time_ < var_676_1 + var_676_2 and not isNil(var_676_0) then
				local var_676_3 = (arg_673_1.time_ - var_676_1) / var_676_2

				if arg_673_1.var_.characterEffect1022ui_story and not isNil(var_676_0) then
					arg_673_1.var_.characterEffect1022ui_story.fillFlat = false
				end
			end

			if arg_673_1.time_ >= var_676_1 + var_676_2 and arg_673_1.time_ < var_676_1 + var_676_2 + arg_676_0 and not isNil(var_676_0) and arg_673_1.var_.characterEffect1022ui_story then
				arg_673_1.var_.characterEffect1022ui_story.fillFlat = false
			end

			local var_676_4 = 0

			if var_676_4 < arg_673_1.time_ and arg_673_1.time_ <= var_676_4 + arg_676_0 then
				arg_673_1:PlayTimeline("1022ui_story", "StoryTimeline/CharAction/story1022/story1022action/1022action3_1")
			end

			local var_676_5 = arg_673_1.actors_["1022ui_story"].transform
			local var_676_6 = 0

			if var_676_6 < arg_673_1.time_ and arg_673_1.time_ <= var_676_6 + arg_676_0 then
				arg_673_1.var_.moveOldPos1022ui_story = var_676_5.localPosition
			end

			local var_676_7 = 0.001

			if var_676_6 <= arg_673_1.time_ and arg_673_1.time_ < var_676_6 + var_676_7 then
				local var_676_8 = (arg_673_1.time_ - var_676_6) / var_676_7
				local var_676_9 = Vector3.New(0, -1.08, -6)

				var_676_5.localPosition = Vector3.Lerp(arg_673_1.var_.moveOldPos1022ui_story, var_676_9, var_676_8)

				local var_676_10 = manager.ui.mainCamera.transform.position - var_676_5.position

				var_676_5.forward = Vector3.New(var_676_10.x, var_676_10.y, var_676_10.z)

				local var_676_11 = var_676_5.localEulerAngles

				var_676_11.z = 0
				var_676_11.x = 0
				var_676_5.localEulerAngles = var_676_11
			end

			if arg_673_1.time_ >= var_676_6 + var_676_7 and arg_673_1.time_ < var_676_6 + var_676_7 + arg_676_0 then
				var_676_5.localPosition = Vector3.New(0, -1.08, -6)

				local var_676_12 = manager.ui.mainCamera.transform.position - var_676_5.position

				var_676_5.forward = Vector3.New(var_676_12.x, var_676_12.y, var_676_12.z)

				local var_676_13 = var_676_5.localEulerAngles

				var_676_13.z = 0
				var_676_13.x = 0
				var_676_5.localEulerAngles = var_676_13
			end

			local var_676_14 = 0
			local var_676_15 = 0.6

			if var_676_14 < arg_673_1.time_ and arg_673_1.time_ <= var_676_14 + arg_676_0 then
				arg_673_1.talkMaxDuration = 0
				arg_673_1.dialogCg_.alpha = 1

				arg_673_1.dialog_:SetActive(true)
				SetActive(arg_673_1.leftNameGo_, true)

				local var_676_16 = arg_673_1:FormatText(StoryNameCfg[259].name)

				arg_673_1.leftNameTxt_.text = var_676_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_673_1.leftNameTxt_.transform)

				arg_673_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_673_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_673_1:RecordName(arg_673_1.leftNameTxt_.text)
				SetActive(arg_673_1.iconTrs_.gameObject, false)
				arg_673_1.callingController_:SetSelectedState("normal")

				local var_676_17 = arg_673_1:GetWordFromCfg(1102205162)
				local var_676_18 = arg_673_1:FormatText(var_676_17.content)

				arg_673_1.text_.text = var_676_18

				LuaForUtil.ClearLinePrefixSymbol(arg_673_1.text_)

				local var_676_19 = 24
				local var_676_20 = utf8.len(var_676_18)
				local var_676_21 = var_676_19 <= 0 and var_676_15 or var_676_15 * (var_676_20 / var_676_19)

				if var_676_21 > 0 and var_676_15 < var_676_21 then
					arg_673_1.talkMaxDuration = var_676_21

					if var_676_21 + var_676_14 > arg_673_1.duration_ then
						arg_673_1.duration_ = var_676_21 + var_676_14
					end
				end

				arg_673_1.text_.text = var_676_18
				arg_673_1.typewritter.percent = 0

				arg_673_1.typewritter:SetDirty()
				arg_673_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205162", "story_v_side_new_1102205.awb") ~= 0 then
					local var_676_22 = manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205162", "story_v_side_new_1102205.awb") / 1000

					if var_676_22 + var_676_14 > arg_673_1.duration_ then
						arg_673_1.duration_ = var_676_22 + var_676_14
					end

					if var_676_17.prefab_name ~= "" and arg_673_1.actors_[var_676_17.prefab_name] ~= nil then
						local var_676_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_673_1.actors_[var_676_17.prefab_name].transform, "story_v_side_new_1102205", "1102205162", "story_v_side_new_1102205.awb")

						arg_673_1:RecordAudio("1102205162", var_676_23)
						arg_673_1:RecordAudio("1102205162", var_676_23)
					else
						arg_673_1:AudioAction("play", "voice", "story_v_side_new_1102205", "1102205162", "story_v_side_new_1102205.awb")
					end

					arg_673_1:RecordHistoryTalkVoice("story_v_side_new_1102205", "1102205162", "story_v_side_new_1102205.awb")
				end

				arg_673_1:RecordContent(arg_673_1.text_.text)
			end

			local var_676_24 = math.max(var_676_15, arg_673_1.talkMaxDuration)

			if var_676_14 <= arg_673_1.time_ and arg_673_1.time_ < var_676_14 + var_676_24 then
				arg_673_1.typewritter.percent = (arg_673_1.time_ - var_676_14) / var_676_24

				arg_673_1.typewritter:SetDirty()
			end

			if arg_673_1.time_ >= var_676_14 + var_676_24 and arg_673_1.time_ < var_676_14 + var_676_24 + arg_676_0 then
				arg_673_1.typewritter.percent = 1

				arg_673_1.typewritter:SetDirty()
				arg_673_1:ShowNextGo(true)
			end
		end

		arg_673_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1022ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_673_1:InitPlayNodeList()
	end,
	Play1102205163 = function(arg_677_0, arg_677_1)
		arg_677_1.time_ = 0
		arg_677_1.frameCnt_ = 0
		arg_677_1.state_ = "playing"
		arg_677_1.curTalkId_ = 1102205163
		arg_677_1.duration_ = 5

		SetActive(arg_677_1.tipsGo_, false)

		function arg_677_1.onSingleLineFinish_()
			arg_677_1.onSingleLineUpdate_ = nil
			arg_677_1.onSingleLineFinish_ = nil
			arg_677_1.state_ = "waiting"
		end

		function arg_677_1.playNext_(arg_679_0)
			if arg_679_0 == 1 then
				arg_677_0:Play1102205164(arg_677_1)
			end
		end

		function arg_677_1.onSingleLineUpdate_(arg_680_0)
			local var_680_0 = arg_677_1.actors_["1022ui_story"]
			local var_680_1 = 0

			if var_680_1 < arg_677_1.time_ and arg_677_1.time_ <= var_680_1 + arg_680_0 and not isNil(var_680_0) and arg_677_1.var_.characterEffect1022ui_story == nil then
				arg_677_1.var_.characterEffect1022ui_story = var_680_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_680_2 = 0.200000002980232

			if var_680_1 <= arg_677_1.time_ and arg_677_1.time_ < var_680_1 + var_680_2 and not isNil(var_680_0) then
				local var_680_3 = (arg_677_1.time_ - var_680_1) / var_680_2

				if arg_677_1.var_.characterEffect1022ui_story and not isNil(var_680_0) then
					local var_680_4 = Mathf.Lerp(0, 0.5, var_680_3)

					arg_677_1.var_.characterEffect1022ui_story.fillFlat = true
					arg_677_1.var_.characterEffect1022ui_story.fillRatio = var_680_4
				end
			end

			if arg_677_1.time_ >= var_680_1 + var_680_2 and arg_677_1.time_ < var_680_1 + var_680_2 + arg_680_0 and not isNil(var_680_0) and arg_677_1.var_.characterEffect1022ui_story then
				local var_680_5 = 0.5

				arg_677_1.var_.characterEffect1022ui_story.fillFlat = true
				arg_677_1.var_.characterEffect1022ui_story.fillRatio = var_680_5
			end

			local var_680_6 = 0
			local var_680_7 = 0.425

			if var_680_6 < arg_677_1.time_ and arg_677_1.time_ <= var_680_6 + arg_680_0 then
				arg_677_1.talkMaxDuration = 0
				arg_677_1.dialogCg_.alpha = 1

				arg_677_1.dialog_:SetActive(true)
				SetActive(arg_677_1.leftNameGo_, true)

				local var_680_8 = arg_677_1:FormatText(StoryNameCfg[7].name)

				arg_677_1.leftNameTxt_.text = var_680_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_677_1.leftNameTxt_.transform)

				arg_677_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_677_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_677_1:RecordName(arg_677_1.leftNameTxt_.text)
				SetActive(arg_677_1.iconTrs_.gameObject, true)
				arg_677_1.iconController_:SetSelectedState("hero")

				arg_677_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_677_1.callingController_:SetSelectedState("normal")

				arg_677_1.keyicon_.color = Color.New(1, 1, 1)
				arg_677_1.icon_.color = Color.New(1, 1, 1)

				local var_680_9 = arg_677_1:GetWordFromCfg(1102205163)
				local var_680_10 = arg_677_1:FormatText(var_680_9.content)

				arg_677_1.text_.text = var_680_10

				LuaForUtil.ClearLinePrefixSymbol(arg_677_1.text_)

				local var_680_11 = 17
				local var_680_12 = utf8.len(var_680_10)
				local var_680_13 = var_680_11 <= 0 and var_680_7 or var_680_7 * (var_680_12 / var_680_11)

				if var_680_13 > 0 and var_680_7 < var_680_13 then
					arg_677_1.talkMaxDuration = var_680_13

					if var_680_13 + var_680_6 > arg_677_1.duration_ then
						arg_677_1.duration_ = var_680_13 + var_680_6
					end
				end

				arg_677_1.text_.text = var_680_10
				arg_677_1.typewritter.percent = 0

				arg_677_1.typewritter:SetDirty()
				arg_677_1:ShowNextGo(false)
				arg_677_1:RecordContent(arg_677_1.text_.text)
			end

			local var_680_14 = math.max(var_680_7, arg_677_1.talkMaxDuration)

			if var_680_6 <= arg_677_1.time_ and arg_677_1.time_ < var_680_6 + var_680_14 then
				arg_677_1.typewritter.percent = (arg_677_1.time_ - var_680_6) / var_680_14

				arg_677_1.typewritter:SetDirty()
			end

			if arg_677_1.time_ >= var_680_6 + var_680_14 and arg_677_1.time_ < var_680_6 + var_680_14 + arg_680_0 then
				arg_677_1.typewritter.percent = 1

				arg_677_1.typewritter:SetDirty()
				arg_677_1:ShowNextGo(true)
			end
		end

		arg_677_1.nodeConfigList_ = {}

		arg_677_1:InitPlayNodeList()
	end,
	Play1102205164 = function(arg_681_0, arg_681_1)
		arg_681_1.time_ = 0
		arg_681_1.frameCnt_ = 0
		arg_681_1.state_ = "playing"
		arg_681_1.curTalkId_ = 1102205164
		arg_681_1.duration_ = 5

		SetActive(arg_681_1.tipsGo_, false)

		function arg_681_1.onSingleLineFinish_()
			arg_681_1.onSingleLineUpdate_ = nil
			arg_681_1.onSingleLineFinish_ = nil
			arg_681_1.state_ = "waiting"
		end

		function arg_681_1.playNext_(arg_683_0)
			if arg_683_0 == 1 then
				arg_681_0:Play1102205165(arg_681_1)
			end
		end

		function arg_681_1.onSingleLineUpdate_(arg_684_0)
			local var_684_0 = arg_681_1.actors_["1022ui_story"].transform
			local var_684_1 = 0

			if var_684_1 < arg_681_1.time_ and arg_681_1.time_ <= var_684_1 + arg_684_0 then
				arg_681_1.var_.moveOldPos1022ui_story = var_684_0.localPosition
			end

			local var_684_2 = 0.001

			if var_684_1 <= arg_681_1.time_ and arg_681_1.time_ < var_684_1 + var_684_2 then
				local var_684_3 = (arg_681_1.time_ - var_684_1) / var_684_2
				local var_684_4 = Vector3.New(0, 100, 0)

				var_684_0.localPosition = Vector3.Lerp(arg_681_1.var_.moveOldPos1022ui_story, var_684_4, var_684_3)

				local var_684_5 = manager.ui.mainCamera.transform.position - var_684_0.position

				var_684_0.forward = Vector3.New(var_684_5.x, var_684_5.y, var_684_5.z)

				local var_684_6 = var_684_0.localEulerAngles

				var_684_6.z = 0
				var_684_6.x = 0
				var_684_0.localEulerAngles = var_684_6
			end

			if arg_681_1.time_ >= var_684_1 + var_684_2 and arg_681_1.time_ < var_684_1 + var_684_2 + arg_684_0 then
				var_684_0.localPosition = Vector3.New(0, 100, 0)

				local var_684_7 = manager.ui.mainCamera.transform.position - var_684_0.position

				var_684_0.forward = Vector3.New(var_684_7.x, var_684_7.y, var_684_7.z)

				local var_684_8 = var_684_0.localEulerAngles

				var_684_8.z = 0
				var_684_8.x = 0
				var_684_0.localEulerAngles = var_684_8
			end

			local var_684_9 = 0
			local var_684_10 = 0.925

			if var_684_9 < arg_681_1.time_ and arg_681_1.time_ <= var_684_9 + arg_684_0 then
				arg_681_1.talkMaxDuration = 0
				arg_681_1.dialogCg_.alpha = 1

				arg_681_1.dialog_:SetActive(true)
				SetActive(arg_681_1.leftNameGo_, false)

				arg_681_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_681_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_681_1:RecordName(arg_681_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_681_1.iconTrs_.gameObject, false)
				arg_681_1.callingController_:SetSelectedState("normal")

				local var_684_11 = arg_681_1:GetWordFromCfg(1102205164)
				local var_684_12 = arg_681_1:FormatText(var_684_11.content)

				arg_681_1.text_.text = var_684_12

				LuaForUtil.ClearLinePrefixSymbol(arg_681_1.text_)

				local var_684_13 = 37
				local var_684_14 = utf8.len(var_684_12)
				local var_684_15 = var_684_13 <= 0 and var_684_10 or var_684_10 * (var_684_14 / var_684_13)

				if var_684_15 > 0 and var_684_10 < var_684_15 then
					arg_681_1.talkMaxDuration = var_684_15

					if var_684_15 + var_684_9 > arg_681_1.duration_ then
						arg_681_1.duration_ = var_684_15 + var_684_9
					end
				end

				arg_681_1.text_.text = var_684_12
				arg_681_1.typewritter.percent = 0

				arg_681_1.typewritter:SetDirty()
				arg_681_1:ShowNextGo(false)
				arg_681_1:RecordContent(arg_681_1.text_.text)
			end

			local var_684_16 = math.max(var_684_10, arg_681_1.talkMaxDuration)

			if var_684_9 <= arg_681_1.time_ and arg_681_1.time_ < var_684_9 + var_684_16 then
				arg_681_1.typewritter.percent = (arg_681_1.time_ - var_684_9) / var_684_16

				arg_681_1.typewritter:SetDirty()
			end

			if arg_681_1.time_ >= var_684_9 + var_684_16 and arg_681_1.time_ < var_684_9 + var_684_16 + arg_684_0 then
				arg_681_1.typewritter.percent = 1

				arg_681_1.typewritter:SetDirty()
				arg_681_1:ShowNextGo(true)
			end
		end

		arg_681_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1022ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_681_1:InitPlayNodeList()
	end,
	Play1102205165 = function(arg_685_0, arg_685_1)
		arg_685_1.time_ = 0
		arg_685_1.frameCnt_ = 0
		arg_685_1.state_ = "playing"
		arg_685_1.curTalkId_ = 1102205165
		arg_685_1.duration_ = 5

		SetActive(arg_685_1.tipsGo_, false)

		function arg_685_1.onSingleLineFinish_()
			arg_685_1.onSingleLineUpdate_ = nil
			arg_685_1.onSingleLineFinish_ = nil
			arg_685_1.state_ = "waiting"
		end

		function arg_685_1.playNext_(arg_687_0)
			if arg_687_0 == 1 then
				arg_685_0:Play1102205166(arg_685_1)
			end
		end

		function arg_685_1.onSingleLineUpdate_(arg_688_0)
			local var_688_0 = 0
			local var_688_1 = 0.95

			if var_688_0 < arg_685_1.time_ and arg_685_1.time_ <= var_688_0 + arg_688_0 then
				arg_685_1.talkMaxDuration = 0
				arg_685_1.dialogCg_.alpha = 1

				arg_685_1.dialog_:SetActive(true)
				SetActive(arg_685_1.leftNameGo_, false)

				arg_685_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_685_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_685_1:RecordName(arg_685_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_685_1.iconTrs_.gameObject, false)
				arg_685_1.callingController_:SetSelectedState("normal")

				local var_688_2 = arg_685_1:GetWordFromCfg(1102205165)
				local var_688_3 = arg_685_1:FormatText(var_688_2.content)

				arg_685_1.text_.text = var_688_3

				LuaForUtil.ClearLinePrefixSymbol(arg_685_1.text_)

				local var_688_4 = 38
				local var_688_5 = utf8.len(var_688_3)
				local var_688_6 = var_688_4 <= 0 and var_688_1 or var_688_1 * (var_688_5 / var_688_4)

				if var_688_6 > 0 and var_688_1 < var_688_6 then
					arg_685_1.talkMaxDuration = var_688_6

					if var_688_6 + var_688_0 > arg_685_1.duration_ then
						arg_685_1.duration_ = var_688_6 + var_688_0
					end
				end

				arg_685_1.text_.text = var_688_3
				arg_685_1.typewritter.percent = 0

				arg_685_1.typewritter:SetDirty()
				arg_685_1:ShowNextGo(false)
				arg_685_1:RecordContent(arg_685_1.text_.text)
			end

			local var_688_7 = math.max(var_688_1, arg_685_1.talkMaxDuration)

			if var_688_0 <= arg_685_1.time_ and arg_685_1.time_ < var_688_0 + var_688_7 then
				arg_685_1.typewritter.percent = (arg_685_1.time_ - var_688_0) / var_688_7

				arg_685_1.typewritter:SetDirty()
			end

			if arg_685_1.time_ >= var_688_0 + var_688_7 and arg_685_1.time_ < var_688_0 + var_688_7 + arg_688_0 then
				arg_685_1.typewritter.percent = 1

				arg_685_1.typewritter:SetDirty()
				arg_685_1:ShowNextGo(true)
			end
		end

		arg_685_1.nodeConfigList_ = {}

		arg_685_1:InitPlayNodeList()
	end,
	Play1102205166 = function(arg_689_0, arg_689_1)
		arg_689_1.time_ = 0
		arg_689_1.frameCnt_ = 0
		arg_689_1.state_ = "playing"
		arg_689_1.curTalkId_ = 1102205166
		arg_689_1.duration_ = 5.57

		SetActive(arg_689_1.tipsGo_, false)

		function arg_689_1.onSingleLineFinish_()
			arg_689_1.onSingleLineUpdate_ = nil
			arg_689_1.onSingleLineFinish_ = nil
			arg_689_1.state_ = "waiting"
		end

		function arg_689_1.playNext_(arg_691_0)
			if arg_691_0 == 1 then
				arg_689_0:Play1102205167(arg_689_1)
			end
		end

		function arg_689_1.onSingleLineUpdate_(arg_692_0)
			local var_692_0 = arg_689_1.actors_["1022ui_story"]
			local var_692_1 = 0

			if var_692_1 < arg_689_1.time_ and arg_689_1.time_ <= var_692_1 + arg_692_0 and not isNil(var_692_0) and arg_689_1.var_.characterEffect1022ui_story == nil then
				arg_689_1.var_.characterEffect1022ui_story = var_692_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_692_2 = 0.200000002980232

			if var_692_1 <= arg_689_1.time_ and arg_689_1.time_ < var_692_1 + var_692_2 and not isNil(var_692_0) then
				local var_692_3 = (arg_689_1.time_ - var_692_1) / var_692_2

				if arg_689_1.var_.characterEffect1022ui_story and not isNil(var_692_0) then
					arg_689_1.var_.characterEffect1022ui_story.fillFlat = false
				end
			end

			if arg_689_1.time_ >= var_692_1 + var_692_2 and arg_689_1.time_ < var_692_1 + var_692_2 + arg_692_0 and not isNil(var_692_0) and arg_689_1.var_.characterEffect1022ui_story then
				arg_689_1.var_.characterEffect1022ui_story.fillFlat = false
			end

			local var_692_4 = 0

			if var_692_4 < arg_689_1.time_ and arg_689_1.time_ <= var_692_4 + arg_692_0 then
				arg_689_1:PlayTimeline("1022ui_story", "StoryTimeline/CharAction/story1022/story1022action/1022action3_2")
			end

			local var_692_5 = 0

			if var_692_5 < arg_689_1.time_ and arg_689_1.time_ <= var_692_5 + arg_692_0 then
				arg_689_1:PlayTimeline("1022ui_story", "StoryTimeline/CharAction/public_expression/expr_zhushiA", "EmotionTimelineAnimator")
			end

			local var_692_6 = arg_689_1.actors_["1022ui_story"].transform
			local var_692_7 = 0

			if var_692_7 < arg_689_1.time_ and arg_689_1.time_ <= var_692_7 + arg_692_0 then
				arg_689_1.var_.moveOldPos1022ui_story = var_692_6.localPosition
			end

			local var_692_8 = 0.001

			if var_692_7 <= arg_689_1.time_ and arg_689_1.time_ < var_692_7 + var_692_8 then
				local var_692_9 = (arg_689_1.time_ - var_692_7) / var_692_8
				local var_692_10 = Vector3.New(0, -1.08, -6)

				var_692_6.localPosition = Vector3.Lerp(arg_689_1.var_.moveOldPos1022ui_story, var_692_10, var_692_9)

				local var_692_11 = manager.ui.mainCamera.transform.position - var_692_6.position

				var_692_6.forward = Vector3.New(var_692_11.x, var_692_11.y, var_692_11.z)

				local var_692_12 = var_692_6.localEulerAngles

				var_692_12.z = 0
				var_692_12.x = 0
				var_692_6.localEulerAngles = var_692_12
			end

			if arg_689_1.time_ >= var_692_7 + var_692_8 and arg_689_1.time_ < var_692_7 + var_692_8 + arg_692_0 then
				var_692_6.localPosition = Vector3.New(0, -1.08, -6)

				local var_692_13 = manager.ui.mainCamera.transform.position - var_692_6.position

				var_692_6.forward = Vector3.New(var_692_13.x, var_692_13.y, var_692_13.z)

				local var_692_14 = var_692_6.localEulerAngles

				var_692_14.z = 0
				var_692_14.x = 0
				var_692_6.localEulerAngles = var_692_14
			end

			local var_692_15 = 0
			local var_692_16 = 0.5

			if var_692_15 < arg_689_1.time_ and arg_689_1.time_ <= var_692_15 + arg_692_0 then
				arg_689_1.talkMaxDuration = 0
				arg_689_1.dialogCg_.alpha = 1

				arg_689_1.dialog_:SetActive(true)
				SetActive(arg_689_1.leftNameGo_, true)

				local var_692_17 = arg_689_1:FormatText(StoryNameCfg[259].name)

				arg_689_1.leftNameTxt_.text = var_692_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_689_1.leftNameTxt_.transform)

				arg_689_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_689_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_689_1:RecordName(arg_689_1.leftNameTxt_.text)
				SetActive(arg_689_1.iconTrs_.gameObject, false)
				arg_689_1.callingController_:SetSelectedState("normal")

				local var_692_18 = arg_689_1:GetWordFromCfg(1102205166)
				local var_692_19 = arg_689_1:FormatText(var_692_18.content)

				arg_689_1.text_.text = var_692_19

				LuaForUtil.ClearLinePrefixSymbol(arg_689_1.text_)

				local var_692_20 = 20
				local var_692_21 = utf8.len(var_692_19)
				local var_692_22 = var_692_20 <= 0 and var_692_16 or var_692_16 * (var_692_21 / var_692_20)

				if var_692_22 > 0 and var_692_16 < var_692_22 then
					arg_689_1.talkMaxDuration = var_692_22

					if var_692_22 + var_692_15 > arg_689_1.duration_ then
						arg_689_1.duration_ = var_692_22 + var_692_15
					end
				end

				arg_689_1.text_.text = var_692_19
				arg_689_1.typewritter.percent = 0

				arg_689_1.typewritter:SetDirty()
				arg_689_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205166", "story_v_side_new_1102205.awb") ~= 0 then
					local var_692_23 = manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205166", "story_v_side_new_1102205.awb") / 1000

					if var_692_23 + var_692_15 > arg_689_1.duration_ then
						arg_689_1.duration_ = var_692_23 + var_692_15
					end

					if var_692_18.prefab_name ~= "" and arg_689_1.actors_[var_692_18.prefab_name] ~= nil then
						local var_692_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_689_1.actors_[var_692_18.prefab_name].transform, "story_v_side_new_1102205", "1102205166", "story_v_side_new_1102205.awb")

						arg_689_1:RecordAudio("1102205166", var_692_24)
						arg_689_1:RecordAudio("1102205166", var_692_24)
					else
						arg_689_1:AudioAction("play", "voice", "story_v_side_new_1102205", "1102205166", "story_v_side_new_1102205.awb")
					end

					arg_689_1:RecordHistoryTalkVoice("story_v_side_new_1102205", "1102205166", "story_v_side_new_1102205.awb")
				end

				arg_689_1:RecordContent(arg_689_1.text_.text)
			end

			local var_692_25 = math.max(var_692_16, arg_689_1.talkMaxDuration)

			if var_692_15 <= arg_689_1.time_ and arg_689_1.time_ < var_692_15 + var_692_25 then
				arg_689_1.typewritter.percent = (arg_689_1.time_ - var_692_15) / var_692_25

				arg_689_1.typewritter:SetDirty()
			end

			if arg_689_1.time_ >= var_692_15 + var_692_25 and arg_689_1.time_ < var_692_15 + var_692_25 + arg_692_0 then
				arg_689_1.typewritter.percent = 1

				arg_689_1.typewritter:SetDirty()
				arg_689_1:ShowNextGo(true)
			end
		end

		arg_689_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1022ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_689_1:InitPlayNodeList()
	end,
	Play1102205167 = function(arg_693_0, arg_693_1)
		arg_693_1.time_ = 0
		arg_693_1.frameCnt_ = 0
		arg_693_1.state_ = "playing"
		arg_693_1.curTalkId_ = 1102205167
		arg_693_1.duration_ = 1

		SetActive(arg_693_1.tipsGo_, true)

		arg_693_1.tipsText_.text = StoryTipsCfg[102201].name

		function arg_693_1.onSingleLineFinish_()
			arg_693_1.onSingleLineUpdate_ = nil
			arg_693_1.onSingleLineFinish_ = nil
			arg_693_1.state_ = "waiting"

			SetActive(arg_693_1.choicesGo_, true)

			for iter_694_0, iter_694_1 in ipairs(arg_693_1.choices_) do
				local var_694_0 = iter_694_0 <= 2

				SetActive(iter_694_1.go, var_694_0)
			end

			arg_693_1.choices_[1].txt.text = arg_693_1:FormatText(StoryChoiceCfg[1468].name)
			arg_693_1.choices_[2].txt.text = arg_693_1:FormatText(StoryChoiceCfg[1469].name)
		end

		function arg_693_1.playNext_(arg_695_0)
			if arg_695_0 == 1 then
				arg_693_0:Play1102205168(arg_693_1)
			end

			if arg_695_0 == 2 then
				PlayerAction.UseStoryTrigger(1022011, 210220105, 1102205167, 2)
				arg_693_0:Play1102205170(arg_693_1)
			end

			arg_693_1:RecordChoiceLog(1102205167, 1468, 1469)
		end

		function arg_693_1.onSingleLineUpdate_(arg_696_0)
			local var_696_0 = arg_693_1.actors_["1022ui_story"]
			local var_696_1 = 0

			if var_696_1 < arg_693_1.time_ and arg_693_1.time_ <= var_696_1 + arg_696_0 and not isNil(var_696_0) and arg_693_1.var_.characterEffect1022ui_story == nil then
				arg_693_1.var_.characterEffect1022ui_story = var_696_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_696_2 = 0.200000002980232

			if var_696_1 <= arg_693_1.time_ and arg_693_1.time_ < var_696_1 + var_696_2 and not isNil(var_696_0) then
				local var_696_3 = (arg_693_1.time_ - var_696_1) / var_696_2

				if arg_693_1.var_.characterEffect1022ui_story and not isNil(var_696_0) then
					local var_696_4 = Mathf.Lerp(0, 0.5, var_696_3)

					arg_693_1.var_.characterEffect1022ui_story.fillFlat = true
					arg_693_1.var_.characterEffect1022ui_story.fillRatio = var_696_4
				end
			end

			if arg_693_1.time_ >= var_696_1 + var_696_2 and arg_693_1.time_ < var_696_1 + var_696_2 + arg_696_0 and not isNil(var_696_0) and arg_693_1.var_.characterEffect1022ui_story then
				local var_696_5 = 0.5

				arg_693_1.var_.characterEffect1022ui_story.fillFlat = true
				arg_693_1.var_.characterEffect1022ui_story.fillRatio = var_696_5
			end
		end

		arg_693_1.nodeConfigList_ = {}

		arg_693_1:InitPlayNodeList()
	end,
	Play1102205168 = function(arg_697_0, arg_697_1)
		arg_697_1.time_ = 0
		arg_697_1.frameCnt_ = 0
		arg_697_1.state_ = "playing"
		arg_697_1.curTalkId_ = 1102205168
		arg_697_1.duration_ = 6.47

		SetActive(arg_697_1.tipsGo_, false)

		function arg_697_1.onSingleLineFinish_()
			arg_697_1.onSingleLineUpdate_ = nil
			arg_697_1.onSingleLineFinish_ = nil
			arg_697_1.state_ = "waiting"
		end

		function arg_697_1.playNext_(arg_699_0)
			if arg_699_0 == 1 then
				arg_697_0:Play1102205169(arg_697_1)
			end
		end

		function arg_697_1.onSingleLineUpdate_(arg_700_0)
			local var_700_0 = arg_697_1.actors_["1022ui_story"]
			local var_700_1 = 0

			if var_700_1 < arg_697_1.time_ and arg_697_1.time_ <= var_700_1 + arg_700_0 and not isNil(var_700_0) and arg_697_1.var_.characterEffect1022ui_story == nil then
				arg_697_1.var_.characterEffect1022ui_story = var_700_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_700_2 = 0.200000002980232

			if var_700_1 <= arg_697_1.time_ and arg_697_1.time_ < var_700_1 + var_700_2 and not isNil(var_700_0) then
				local var_700_3 = (arg_697_1.time_ - var_700_1) / var_700_2

				if arg_697_1.var_.characterEffect1022ui_story and not isNil(var_700_0) then
					arg_697_1.var_.characterEffect1022ui_story.fillFlat = false
				end
			end

			if arg_697_1.time_ >= var_700_1 + var_700_2 and arg_697_1.time_ < var_700_1 + var_700_2 + arg_700_0 and not isNil(var_700_0) and arg_697_1.var_.characterEffect1022ui_story then
				arg_697_1.var_.characterEffect1022ui_story.fillFlat = false
			end

			local var_700_4 = 0
			local var_700_5 = 0.675

			if var_700_4 < arg_697_1.time_ and arg_697_1.time_ <= var_700_4 + arg_700_0 then
				arg_697_1.talkMaxDuration = 0
				arg_697_1.dialogCg_.alpha = 1

				arg_697_1.dialog_:SetActive(true)
				SetActive(arg_697_1.leftNameGo_, true)

				local var_700_6 = arg_697_1:FormatText(StoryNameCfg[259].name)

				arg_697_1.leftNameTxt_.text = var_700_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_697_1.leftNameTxt_.transform)

				arg_697_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_697_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_697_1:RecordName(arg_697_1.leftNameTxt_.text)
				SetActive(arg_697_1.iconTrs_.gameObject, false)
				arg_697_1.callingController_:SetSelectedState("normal")

				local var_700_7 = arg_697_1:GetWordFromCfg(1102205168)
				local var_700_8 = arg_697_1:FormatText(var_700_7.content)

				arg_697_1.text_.text = var_700_8

				LuaForUtil.ClearLinePrefixSymbol(arg_697_1.text_)

				local var_700_9 = 27
				local var_700_10 = utf8.len(var_700_8)
				local var_700_11 = var_700_9 <= 0 and var_700_5 or var_700_5 * (var_700_10 / var_700_9)

				if var_700_11 > 0 and var_700_5 < var_700_11 then
					arg_697_1.talkMaxDuration = var_700_11

					if var_700_11 + var_700_4 > arg_697_1.duration_ then
						arg_697_1.duration_ = var_700_11 + var_700_4
					end
				end

				arg_697_1.text_.text = var_700_8
				arg_697_1.typewritter.percent = 0

				arg_697_1.typewritter:SetDirty()
				arg_697_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205168", "story_v_side_new_1102205.awb") ~= 0 then
					local var_700_12 = manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205168", "story_v_side_new_1102205.awb") / 1000

					if var_700_12 + var_700_4 > arg_697_1.duration_ then
						arg_697_1.duration_ = var_700_12 + var_700_4
					end

					if var_700_7.prefab_name ~= "" and arg_697_1.actors_[var_700_7.prefab_name] ~= nil then
						local var_700_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_697_1.actors_[var_700_7.prefab_name].transform, "story_v_side_new_1102205", "1102205168", "story_v_side_new_1102205.awb")

						arg_697_1:RecordAudio("1102205168", var_700_13)
						arg_697_1:RecordAudio("1102205168", var_700_13)
					else
						arg_697_1:AudioAction("play", "voice", "story_v_side_new_1102205", "1102205168", "story_v_side_new_1102205.awb")
					end

					arg_697_1:RecordHistoryTalkVoice("story_v_side_new_1102205", "1102205168", "story_v_side_new_1102205.awb")
				end

				arg_697_1:RecordContent(arg_697_1.text_.text)
			end

			local var_700_14 = math.max(var_700_5, arg_697_1.talkMaxDuration)

			if var_700_4 <= arg_697_1.time_ and arg_697_1.time_ < var_700_4 + var_700_14 then
				arg_697_1.typewritter.percent = (arg_697_1.time_ - var_700_4) / var_700_14

				arg_697_1.typewritter:SetDirty()
			end

			if arg_697_1.time_ >= var_700_4 + var_700_14 and arg_697_1.time_ < var_700_4 + var_700_14 + arg_700_0 then
				arg_697_1.typewritter.percent = 1

				arg_697_1.typewritter:SetDirty()
				arg_697_1:ShowNextGo(true)
			end
		end

		arg_697_1.nodeConfigList_ = {}

		arg_697_1:InitPlayNodeList()
	end,
	Play1102205169 = function(arg_701_0, arg_701_1)
		arg_701_1.time_ = 0
		arg_701_1.frameCnt_ = 0
		arg_701_1.state_ = "playing"
		arg_701_1.curTalkId_ = 1102205169
		arg_701_1.duration_ = 7.6

		SetActive(arg_701_1.tipsGo_, false)

		function arg_701_1.onSingleLineFinish_()
			arg_701_1.onSingleLineUpdate_ = nil
			arg_701_1.onSingleLineFinish_ = nil
			arg_701_1.state_ = "waiting"
		end

		function arg_701_1.playNext_(arg_703_0)
			if arg_703_0 == 1 then
				arg_701_0:Play1102205174(arg_701_1)
			end
		end

		function arg_701_1.onSingleLineUpdate_(arg_704_0)
			local var_704_0 = 0

			if var_704_0 < arg_701_1.time_ and arg_701_1.time_ <= var_704_0 + arg_704_0 then
				arg_701_1:PlayTimeline("1022ui_story", "StoryTimeline/CharAction/story1022/story1022action/1022action5_1")
			end

			local var_704_1 = 0

			if var_704_1 < arg_701_1.time_ and arg_701_1.time_ <= var_704_1 + arg_704_0 then
				arg_701_1:PlayTimeline("1022ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_704_2 = 0
			local var_704_3 = 0.7

			if var_704_2 < arg_701_1.time_ and arg_701_1.time_ <= var_704_2 + arg_704_0 then
				arg_701_1.talkMaxDuration = 0
				arg_701_1.dialogCg_.alpha = 1

				arg_701_1.dialog_:SetActive(true)
				SetActive(arg_701_1.leftNameGo_, true)

				local var_704_4 = arg_701_1:FormatText(StoryNameCfg[259].name)

				arg_701_1.leftNameTxt_.text = var_704_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_701_1.leftNameTxt_.transform)

				arg_701_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_701_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_701_1:RecordName(arg_701_1.leftNameTxt_.text)
				SetActive(arg_701_1.iconTrs_.gameObject, false)
				arg_701_1.callingController_:SetSelectedState("normal")

				local var_704_5 = arg_701_1:GetWordFromCfg(1102205169)
				local var_704_6 = arg_701_1:FormatText(var_704_5.content)

				arg_701_1.text_.text = var_704_6

				LuaForUtil.ClearLinePrefixSymbol(arg_701_1.text_)

				local var_704_7 = 28
				local var_704_8 = utf8.len(var_704_6)
				local var_704_9 = var_704_7 <= 0 and var_704_3 or var_704_3 * (var_704_8 / var_704_7)

				if var_704_9 > 0 and var_704_3 < var_704_9 then
					arg_701_1.talkMaxDuration = var_704_9

					if var_704_9 + var_704_2 > arg_701_1.duration_ then
						arg_701_1.duration_ = var_704_9 + var_704_2
					end
				end

				arg_701_1.text_.text = var_704_6
				arg_701_1.typewritter.percent = 0

				arg_701_1.typewritter:SetDirty()
				arg_701_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205169", "story_v_side_new_1102205.awb") ~= 0 then
					local var_704_10 = manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205169", "story_v_side_new_1102205.awb") / 1000

					if var_704_10 + var_704_2 > arg_701_1.duration_ then
						arg_701_1.duration_ = var_704_10 + var_704_2
					end

					if var_704_5.prefab_name ~= "" and arg_701_1.actors_[var_704_5.prefab_name] ~= nil then
						local var_704_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_701_1.actors_[var_704_5.prefab_name].transform, "story_v_side_new_1102205", "1102205169", "story_v_side_new_1102205.awb")

						arg_701_1:RecordAudio("1102205169", var_704_11)
						arg_701_1:RecordAudio("1102205169", var_704_11)
					else
						arg_701_1:AudioAction("play", "voice", "story_v_side_new_1102205", "1102205169", "story_v_side_new_1102205.awb")
					end

					arg_701_1:RecordHistoryTalkVoice("story_v_side_new_1102205", "1102205169", "story_v_side_new_1102205.awb")
				end

				arg_701_1:RecordContent(arg_701_1.text_.text)
			end

			local var_704_12 = math.max(var_704_3, arg_701_1.talkMaxDuration)

			if var_704_2 <= arg_701_1.time_ and arg_701_1.time_ < var_704_2 + var_704_12 then
				arg_701_1.typewritter.percent = (arg_701_1.time_ - var_704_2) / var_704_12

				arg_701_1.typewritter:SetDirty()
			end

			if arg_701_1.time_ >= var_704_2 + var_704_12 and arg_701_1.time_ < var_704_2 + var_704_12 + arg_704_0 then
				arg_701_1.typewritter.percent = 1

				arg_701_1.typewritter:SetDirty()
				arg_701_1:ShowNextGo(true)
			end
		end

		arg_701_1.nodeConfigList_ = {}

		arg_701_1:InitPlayNodeList()
	end,
	Play1102205174 = function(arg_705_0, arg_705_1)
		arg_705_1.time_ = 0
		arg_705_1.frameCnt_ = 0
		arg_705_1.state_ = "playing"
		arg_705_1.curTalkId_ = 1102205174
		arg_705_1.duration_ = 5

		SetActive(arg_705_1.tipsGo_, false)

		function arg_705_1.onSingleLineFinish_()
			arg_705_1.onSingleLineUpdate_ = nil
			arg_705_1.onSingleLineFinish_ = nil
			arg_705_1.state_ = "waiting"
		end

		function arg_705_1.playNext_(arg_707_0)
			if arg_707_0 == 1 then
				arg_705_0:Play1102205175(arg_705_1)
			end
		end

		function arg_705_1.onSingleLineUpdate_(arg_708_0)
			local var_708_0 = arg_705_1.actors_["1022ui_story"]
			local var_708_1 = 0

			if var_708_1 < arg_705_1.time_ and arg_705_1.time_ <= var_708_1 + arg_708_0 and not isNil(var_708_0) and arg_705_1.var_.characterEffect1022ui_story == nil then
				arg_705_1.var_.characterEffect1022ui_story = var_708_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_708_2 = 0.200000002980232

			if var_708_1 <= arg_705_1.time_ and arg_705_1.time_ < var_708_1 + var_708_2 and not isNil(var_708_0) then
				local var_708_3 = (arg_705_1.time_ - var_708_1) / var_708_2

				if arg_705_1.var_.characterEffect1022ui_story and not isNil(var_708_0) then
					local var_708_4 = Mathf.Lerp(0, 0.5, var_708_3)

					arg_705_1.var_.characterEffect1022ui_story.fillFlat = true
					arg_705_1.var_.characterEffect1022ui_story.fillRatio = var_708_4
				end
			end

			if arg_705_1.time_ >= var_708_1 + var_708_2 and arg_705_1.time_ < var_708_1 + var_708_2 + arg_708_0 and not isNil(var_708_0) and arg_705_1.var_.characterEffect1022ui_story then
				local var_708_5 = 0.5

				arg_705_1.var_.characterEffect1022ui_story.fillFlat = true
				arg_705_1.var_.characterEffect1022ui_story.fillRatio = var_708_5
			end

			local var_708_6 = 0
			local var_708_7 = 0.175

			if var_708_6 < arg_705_1.time_ and arg_705_1.time_ <= var_708_6 + arg_708_0 then
				arg_705_1.talkMaxDuration = 0
				arg_705_1.dialogCg_.alpha = 1

				arg_705_1.dialog_:SetActive(true)
				SetActive(arg_705_1.leftNameGo_, true)

				local var_708_8 = arg_705_1:FormatText(StoryNameCfg[7].name)

				arg_705_1.leftNameTxt_.text = var_708_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_705_1.leftNameTxt_.transform)

				arg_705_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_705_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_705_1:RecordName(arg_705_1.leftNameTxt_.text)
				SetActive(arg_705_1.iconTrs_.gameObject, true)
				arg_705_1.iconController_:SetSelectedState("hero")

				arg_705_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_705_1.callingController_:SetSelectedState("normal")

				arg_705_1.keyicon_.color = Color.New(1, 1, 1)
				arg_705_1.icon_.color = Color.New(1, 1, 1)

				local var_708_9 = arg_705_1:GetWordFromCfg(1102205174)
				local var_708_10 = arg_705_1:FormatText(var_708_9.content)

				arg_705_1.text_.text = var_708_10

				LuaForUtil.ClearLinePrefixSymbol(arg_705_1.text_)

				local var_708_11 = 7
				local var_708_12 = utf8.len(var_708_10)
				local var_708_13 = var_708_11 <= 0 and var_708_7 or var_708_7 * (var_708_12 / var_708_11)

				if var_708_13 > 0 and var_708_7 < var_708_13 then
					arg_705_1.talkMaxDuration = var_708_13

					if var_708_13 + var_708_6 > arg_705_1.duration_ then
						arg_705_1.duration_ = var_708_13 + var_708_6
					end
				end

				arg_705_1.text_.text = var_708_10
				arg_705_1.typewritter.percent = 0

				arg_705_1.typewritter:SetDirty()
				arg_705_1:ShowNextGo(false)
				arg_705_1:RecordContent(arg_705_1.text_.text)
			end

			local var_708_14 = math.max(var_708_7, arg_705_1.talkMaxDuration)

			if var_708_6 <= arg_705_1.time_ and arg_705_1.time_ < var_708_6 + var_708_14 then
				arg_705_1.typewritter.percent = (arg_705_1.time_ - var_708_6) / var_708_14

				arg_705_1.typewritter:SetDirty()
			end

			if arg_705_1.time_ >= var_708_6 + var_708_14 and arg_705_1.time_ < var_708_6 + var_708_14 + arg_708_0 then
				arg_705_1.typewritter.percent = 1

				arg_705_1.typewritter:SetDirty()
				arg_705_1:ShowNextGo(true)
			end
		end

		arg_705_1.nodeConfigList_ = {}

		arg_705_1:InitPlayNodeList()
	end,
	Play1102205175 = function(arg_709_0, arg_709_1)
		arg_709_1.time_ = 0
		arg_709_1.frameCnt_ = 0
		arg_709_1.state_ = "playing"
		arg_709_1.curTalkId_ = 1102205175
		arg_709_1.duration_ = 6.6

		SetActive(arg_709_1.tipsGo_, false)

		function arg_709_1.onSingleLineFinish_()
			arg_709_1.onSingleLineUpdate_ = nil
			arg_709_1.onSingleLineFinish_ = nil
			arg_709_1.state_ = "waiting"
		end

		function arg_709_1.playNext_(arg_711_0)
			if arg_711_0 == 1 then
				arg_709_0:Play1102205176(arg_709_1)
			end
		end

		function arg_709_1.onSingleLineUpdate_(arg_712_0)
			local var_712_0 = arg_709_1.actors_["1022ui_story"]
			local var_712_1 = 0

			if var_712_1 < arg_709_1.time_ and arg_709_1.time_ <= var_712_1 + arg_712_0 and not isNil(var_712_0) and arg_709_1.var_.characterEffect1022ui_story == nil then
				arg_709_1.var_.characterEffect1022ui_story = var_712_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_712_2 = 0.200000002980232

			if var_712_1 <= arg_709_1.time_ and arg_709_1.time_ < var_712_1 + var_712_2 and not isNil(var_712_0) then
				local var_712_3 = (arg_709_1.time_ - var_712_1) / var_712_2

				if arg_709_1.var_.characterEffect1022ui_story and not isNil(var_712_0) then
					arg_709_1.var_.characterEffect1022ui_story.fillFlat = false
				end
			end

			if arg_709_1.time_ >= var_712_1 + var_712_2 and arg_709_1.time_ < var_712_1 + var_712_2 + arg_712_0 and not isNil(var_712_0) and arg_709_1.var_.characterEffect1022ui_story then
				arg_709_1.var_.characterEffect1022ui_story.fillFlat = false
			end

			local var_712_4 = 0

			if var_712_4 < arg_709_1.time_ and arg_709_1.time_ <= var_712_4 + arg_712_0 then
				arg_709_1:PlayTimeline("1022ui_story", "StoryTimeline/CharAction/story1022/story1022actionlink/1022action456")
			end

			local var_712_5 = 0

			if var_712_5 < arg_709_1.time_ and arg_709_1.time_ <= var_712_5 + arg_712_0 then
				arg_709_1:PlayTimeline("1022ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_712_6 = 0
			local var_712_7 = 0.65

			if var_712_6 < arg_709_1.time_ and arg_709_1.time_ <= var_712_6 + arg_712_0 then
				arg_709_1.talkMaxDuration = 0
				arg_709_1.dialogCg_.alpha = 1

				arg_709_1.dialog_:SetActive(true)
				SetActive(arg_709_1.leftNameGo_, true)

				local var_712_8 = arg_709_1:FormatText(StoryNameCfg[259].name)

				arg_709_1.leftNameTxt_.text = var_712_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_709_1.leftNameTxt_.transform)

				arg_709_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_709_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_709_1:RecordName(arg_709_1.leftNameTxt_.text)
				SetActive(arg_709_1.iconTrs_.gameObject, false)
				arg_709_1.callingController_:SetSelectedState("normal")

				local var_712_9 = arg_709_1:GetWordFromCfg(1102205175)
				local var_712_10 = arg_709_1:FormatText(var_712_9.content)

				arg_709_1.text_.text = var_712_10

				LuaForUtil.ClearLinePrefixSymbol(arg_709_1.text_)

				local var_712_11 = 26
				local var_712_12 = utf8.len(var_712_10)
				local var_712_13 = var_712_11 <= 0 and var_712_7 or var_712_7 * (var_712_12 / var_712_11)

				if var_712_13 > 0 and var_712_7 < var_712_13 then
					arg_709_1.talkMaxDuration = var_712_13

					if var_712_13 + var_712_6 > arg_709_1.duration_ then
						arg_709_1.duration_ = var_712_13 + var_712_6
					end
				end

				arg_709_1.text_.text = var_712_10
				arg_709_1.typewritter.percent = 0

				arg_709_1.typewritter:SetDirty()
				arg_709_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205175", "story_v_side_new_1102205.awb") ~= 0 then
					local var_712_14 = manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205175", "story_v_side_new_1102205.awb") / 1000

					if var_712_14 + var_712_6 > arg_709_1.duration_ then
						arg_709_1.duration_ = var_712_14 + var_712_6
					end

					if var_712_9.prefab_name ~= "" and arg_709_1.actors_[var_712_9.prefab_name] ~= nil then
						local var_712_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_709_1.actors_[var_712_9.prefab_name].transform, "story_v_side_new_1102205", "1102205175", "story_v_side_new_1102205.awb")

						arg_709_1:RecordAudio("1102205175", var_712_15)
						arg_709_1:RecordAudio("1102205175", var_712_15)
					else
						arg_709_1:AudioAction("play", "voice", "story_v_side_new_1102205", "1102205175", "story_v_side_new_1102205.awb")
					end

					arg_709_1:RecordHistoryTalkVoice("story_v_side_new_1102205", "1102205175", "story_v_side_new_1102205.awb")
				end

				arg_709_1:RecordContent(arg_709_1.text_.text)
			end

			local var_712_16 = math.max(var_712_7, arg_709_1.talkMaxDuration)

			if var_712_6 <= arg_709_1.time_ and arg_709_1.time_ < var_712_6 + var_712_16 then
				arg_709_1.typewritter.percent = (arg_709_1.time_ - var_712_6) / var_712_16

				arg_709_1.typewritter:SetDirty()
			end

			if arg_709_1.time_ >= var_712_6 + var_712_16 and arg_709_1.time_ < var_712_6 + var_712_16 + arg_712_0 then
				arg_709_1.typewritter.percent = 1

				arg_709_1.typewritter:SetDirty()
				arg_709_1:ShowNextGo(true)
			end
		end

		arg_709_1.nodeConfigList_ = {}

		arg_709_1:InitPlayNodeList()
	end,
	Play1102205176 = function(arg_713_0, arg_713_1)
		arg_713_1.time_ = 0
		arg_713_1.frameCnt_ = 0
		arg_713_1.state_ = "playing"
		arg_713_1.curTalkId_ = 1102205176
		arg_713_1.duration_ = 10.4

		SetActive(arg_713_1.tipsGo_, false)

		function arg_713_1.onSingleLineFinish_()
			arg_713_1.onSingleLineUpdate_ = nil
			arg_713_1.onSingleLineFinish_ = nil
			arg_713_1.state_ = "waiting"
		end

		function arg_713_1.playNext_(arg_715_0)
			if arg_715_0 == 1 then
				arg_713_0:Play1102205177(arg_713_1)
			end
		end

		function arg_713_1.onSingleLineUpdate_(arg_716_0)
			local var_716_0 = 0
			local var_716_1 = 0.975

			if var_716_0 < arg_713_1.time_ and arg_713_1.time_ <= var_716_0 + arg_716_0 then
				arg_713_1.talkMaxDuration = 0
				arg_713_1.dialogCg_.alpha = 1

				arg_713_1.dialog_:SetActive(true)
				SetActive(arg_713_1.leftNameGo_, true)

				local var_716_2 = arg_713_1:FormatText(StoryNameCfg[259].name)

				arg_713_1.leftNameTxt_.text = var_716_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_713_1.leftNameTxt_.transform)

				arg_713_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_713_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_713_1:RecordName(arg_713_1.leftNameTxt_.text)
				SetActive(arg_713_1.iconTrs_.gameObject, false)
				arg_713_1.callingController_:SetSelectedState("normal")

				local var_716_3 = arg_713_1:GetWordFromCfg(1102205176)
				local var_716_4 = arg_713_1:FormatText(var_716_3.content)

				arg_713_1.text_.text = var_716_4

				LuaForUtil.ClearLinePrefixSymbol(arg_713_1.text_)

				local var_716_5 = 39
				local var_716_6 = utf8.len(var_716_4)
				local var_716_7 = var_716_5 <= 0 and var_716_1 or var_716_1 * (var_716_6 / var_716_5)

				if var_716_7 > 0 and var_716_1 < var_716_7 then
					arg_713_1.talkMaxDuration = var_716_7

					if var_716_7 + var_716_0 > arg_713_1.duration_ then
						arg_713_1.duration_ = var_716_7 + var_716_0
					end
				end

				arg_713_1.text_.text = var_716_4
				arg_713_1.typewritter.percent = 0

				arg_713_1.typewritter:SetDirty()
				arg_713_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205176", "story_v_side_new_1102205.awb") ~= 0 then
					local var_716_8 = manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205176", "story_v_side_new_1102205.awb") / 1000

					if var_716_8 + var_716_0 > arg_713_1.duration_ then
						arg_713_1.duration_ = var_716_8 + var_716_0
					end

					if var_716_3.prefab_name ~= "" and arg_713_1.actors_[var_716_3.prefab_name] ~= nil then
						local var_716_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_713_1.actors_[var_716_3.prefab_name].transform, "story_v_side_new_1102205", "1102205176", "story_v_side_new_1102205.awb")

						arg_713_1:RecordAudio("1102205176", var_716_9)
						arg_713_1:RecordAudio("1102205176", var_716_9)
					else
						arg_713_1:AudioAction("play", "voice", "story_v_side_new_1102205", "1102205176", "story_v_side_new_1102205.awb")
					end

					arg_713_1:RecordHistoryTalkVoice("story_v_side_new_1102205", "1102205176", "story_v_side_new_1102205.awb")
				end

				arg_713_1:RecordContent(arg_713_1.text_.text)
			end

			local var_716_10 = math.max(var_716_1, arg_713_1.talkMaxDuration)

			if var_716_0 <= arg_713_1.time_ and arg_713_1.time_ < var_716_0 + var_716_10 then
				arg_713_1.typewritter.percent = (arg_713_1.time_ - var_716_0) / var_716_10

				arg_713_1.typewritter:SetDirty()
			end

			if arg_713_1.time_ >= var_716_0 + var_716_10 and arg_713_1.time_ < var_716_0 + var_716_10 + arg_716_0 then
				arg_713_1.typewritter.percent = 1

				arg_713_1.typewritter:SetDirty()
				arg_713_1:ShowNextGo(true)
			end
		end

		arg_713_1.nodeConfigList_ = {}

		arg_713_1:InitPlayNodeList()
	end,
	Play1102205177 = function(arg_717_0, arg_717_1)
		arg_717_1.time_ = 0
		arg_717_1.frameCnt_ = 0
		arg_717_1.state_ = "playing"
		arg_717_1.curTalkId_ = 1102205177
		arg_717_1.duration_ = 5

		SetActive(arg_717_1.tipsGo_, false)

		function arg_717_1.onSingleLineFinish_()
			arg_717_1.onSingleLineUpdate_ = nil
			arg_717_1.onSingleLineFinish_ = nil
			arg_717_1.state_ = "waiting"
		end

		function arg_717_1.playNext_(arg_719_0)
			if arg_719_0 == 1 then
				arg_717_0:Play1102205178(arg_717_1)
			end
		end

		function arg_717_1.onSingleLineUpdate_(arg_720_0)
			local var_720_0 = arg_717_1.actors_["1022ui_story"]
			local var_720_1 = 0

			if var_720_1 < arg_717_1.time_ and arg_717_1.time_ <= var_720_1 + arg_720_0 and not isNil(var_720_0) and arg_717_1.var_.characterEffect1022ui_story == nil then
				arg_717_1.var_.characterEffect1022ui_story = var_720_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_720_2 = 0.200000002980232

			if var_720_1 <= arg_717_1.time_ and arg_717_1.time_ < var_720_1 + var_720_2 and not isNil(var_720_0) then
				local var_720_3 = (arg_717_1.time_ - var_720_1) / var_720_2

				if arg_717_1.var_.characterEffect1022ui_story and not isNil(var_720_0) then
					local var_720_4 = Mathf.Lerp(0, 0.5, var_720_3)

					arg_717_1.var_.characterEffect1022ui_story.fillFlat = true
					arg_717_1.var_.characterEffect1022ui_story.fillRatio = var_720_4
				end
			end

			if arg_717_1.time_ >= var_720_1 + var_720_2 and arg_717_1.time_ < var_720_1 + var_720_2 + arg_720_0 and not isNil(var_720_0) and arg_717_1.var_.characterEffect1022ui_story then
				local var_720_5 = 0.5

				arg_717_1.var_.characterEffect1022ui_story.fillFlat = true
				arg_717_1.var_.characterEffect1022ui_story.fillRatio = var_720_5
			end

			local var_720_6 = 0
			local var_720_7 = 0.425

			if var_720_6 < arg_717_1.time_ and arg_717_1.time_ <= var_720_6 + arg_720_0 then
				arg_717_1.talkMaxDuration = 0
				arg_717_1.dialogCg_.alpha = 1

				arg_717_1.dialog_:SetActive(true)
				SetActive(arg_717_1.leftNameGo_, true)

				local var_720_8 = arg_717_1:FormatText(StoryNameCfg[7].name)

				arg_717_1.leftNameTxt_.text = var_720_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_717_1.leftNameTxt_.transform)

				arg_717_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_717_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_717_1:RecordName(arg_717_1.leftNameTxt_.text)
				SetActive(arg_717_1.iconTrs_.gameObject, true)
				arg_717_1.iconController_:SetSelectedState("hero")

				arg_717_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_717_1.callingController_:SetSelectedState("normal")

				arg_717_1.keyicon_.color = Color.New(1, 1, 1)
				arg_717_1.icon_.color = Color.New(1, 1, 1)

				local var_720_9 = arg_717_1:GetWordFromCfg(1102205177)
				local var_720_10 = arg_717_1:FormatText(var_720_9.content)

				arg_717_1.text_.text = var_720_10

				LuaForUtil.ClearLinePrefixSymbol(arg_717_1.text_)

				local var_720_11 = 17
				local var_720_12 = utf8.len(var_720_10)
				local var_720_13 = var_720_11 <= 0 and var_720_7 or var_720_7 * (var_720_12 / var_720_11)

				if var_720_13 > 0 and var_720_7 < var_720_13 then
					arg_717_1.talkMaxDuration = var_720_13

					if var_720_13 + var_720_6 > arg_717_1.duration_ then
						arg_717_1.duration_ = var_720_13 + var_720_6
					end
				end

				arg_717_1.text_.text = var_720_10
				arg_717_1.typewritter.percent = 0

				arg_717_1.typewritter:SetDirty()
				arg_717_1:ShowNextGo(false)
				arg_717_1:RecordContent(arg_717_1.text_.text)
			end

			local var_720_14 = math.max(var_720_7, arg_717_1.talkMaxDuration)

			if var_720_6 <= arg_717_1.time_ and arg_717_1.time_ < var_720_6 + var_720_14 then
				arg_717_1.typewritter.percent = (arg_717_1.time_ - var_720_6) / var_720_14

				arg_717_1.typewritter:SetDirty()
			end

			if arg_717_1.time_ >= var_720_6 + var_720_14 and arg_717_1.time_ < var_720_6 + var_720_14 + arg_720_0 then
				arg_717_1.typewritter.percent = 1

				arg_717_1.typewritter:SetDirty()
				arg_717_1:ShowNextGo(true)
			end
		end

		arg_717_1.nodeConfigList_ = {}

		arg_717_1:InitPlayNodeList()
	end,
	Play1102205178 = function(arg_721_0, arg_721_1)
		arg_721_1.time_ = 0
		arg_721_1.frameCnt_ = 0
		arg_721_1.state_ = "playing"
		arg_721_1.curTalkId_ = 1102205178
		arg_721_1.duration_ = 7.33

		SetActive(arg_721_1.tipsGo_, false)

		function arg_721_1.onSingleLineFinish_()
			arg_721_1.onSingleLineUpdate_ = nil
			arg_721_1.onSingleLineFinish_ = nil
			arg_721_1.state_ = "waiting"
		end

		function arg_721_1.playNext_(arg_723_0)
			if arg_723_0 == 1 then
				arg_721_0:Play1102205179(arg_721_1)
			end
		end

		function arg_721_1.onSingleLineUpdate_(arg_724_0)
			local var_724_0 = arg_721_1.actors_["1022ui_story"]
			local var_724_1 = 0

			if var_724_1 < arg_721_1.time_ and arg_721_1.time_ <= var_724_1 + arg_724_0 and not isNil(var_724_0) and arg_721_1.var_.characterEffect1022ui_story == nil then
				arg_721_1.var_.characterEffect1022ui_story = var_724_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_724_2 = 0.200000002980232

			if var_724_1 <= arg_721_1.time_ and arg_721_1.time_ < var_724_1 + var_724_2 and not isNil(var_724_0) then
				local var_724_3 = (arg_721_1.time_ - var_724_1) / var_724_2

				if arg_721_1.var_.characterEffect1022ui_story and not isNil(var_724_0) then
					arg_721_1.var_.characterEffect1022ui_story.fillFlat = false
				end
			end

			if arg_721_1.time_ >= var_724_1 + var_724_2 and arg_721_1.time_ < var_724_1 + var_724_2 + arg_724_0 and not isNil(var_724_0) and arg_721_1.var_.characterEffect1022ui_story then
				arg_721_1.var_.characterEffect1022ui_story.fillFlat = false
			end

			local var_724_4 = 0

			if var_724_4 < arg_721_1.time_ and arg_721_1.time_ <= var_724_4 + arg_724_0 then
				arg_721_1:PlayTimeline("1022ui_story", "StoryTimeline/CharAction/story1022/story1022action/1022action6_2")
			end

			local var_724_5 = 0

			if var_724_5 < arg_721_1.time_ and arg_721_1.time_ <= var_724_5 + arg_724_0 then
				arg_721_1:PlayTimeline("1022ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_724_6 = 0
			local var_724_7 = 0.75

			if var_724_6 < arg_721_1.time_ and arg_721_1.time_ <= var_724_6 + arg_724_0 then
				arg_721_1.talkMaxDuration = 0
				arg_721_1.dialogCg_.alpha = 1

				arg_721_1.dialog_:SetActive(true)
				SetActive(arg_721_1.leftNameGo_, true)

				local var_724_8 = arg_721_1:FormatText(StoryNameCfg[259].name)

				arg_721_1.leftNameTxt_.text = var_724_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_721_1.leftNameTxt_.transform)

				arg_721_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_721_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_721_1:RecordName(arg_721_1.leftNameTxt_.text)
				SetActive(arg_721_1.iconTrs_.gameObject, false)
				arg_721_1.callingController_:SetSelectedState("normal")

				local var_724_9 = arg_721_1:GetWordFromCfg(1102205178)
				local var_724_10 = arg_721_1:FormatText(var_724_9.content)

				arg_721_1.text_.text = var_724_10

				LuaForUtil.ClearLinePrefixSymbol(arg_721_1.text_)

				local var_724_11 = 30
				local var_724_12 = utf8.len(var_724_10)
				local var_724_13 = var_724_11 <= 0 and var_724_7 or var_724_7 * (var_724_12 / var_724_11)

				if var_724_13 > 0 and var_724_7 < var_724_13 then
					arg_721_1.talkMaxDuration = var_724_13

					if var_724_13 + var_724_6 > arg_721_1.duration_ then
						arg_721_1.duration_ = var_724_13 + var_724_6
					end
				end

				arg_721_1.text_.text = var_724_10
				arg_721_1.typewritter.percent = 0

				arg_721_1.typewritter:SetDirty()
				arg_721_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205178", "story_v_side_new_1102205.awb") ~= 0 then
					local var_724_14 = manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205178", "story_v_side_new_1102205.awb") / 1000

					if var_724_14 + var_724_6 > arg_721_1.duration_ then
						arg_721_1.duration_ = var_724_14 + var_724_6
					end

					if var_724_9.prefab_name ~= "" and arg_721_1.actors_[var_724_9.prefab_name] ~= nil then
						local var_724_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_721_1.actors_[var_724_9.prefab_name].transform, "story_v_side_new_1102205", "1102205178", "story_v_side_new_1102205.awb")

						arg_721_1:RecordAudio("1102205178", var_724_15)
						arg_721_1:RecordAudio("1102205178", var_724_15)
					else
						arg_721_1:AudioAction("play", "voice", "story_v_side_new_1102205", "1102205178", "story_v_side_new_1102205.awb")
					end

					arg_721_1:RecordHistoryTalkVoice("story_v_side_new_1102205", "1102205178", "story_v_side_new_1102205.awb")
				end

				arg_721_1:RecordContent(arg_721_1.text_.text)
			end

			local var_724_16 = math.max(var_724_7, arg_721_1.talkMaxDuration)

			if var_724_6 <= arg_721_1.time_ and arg_721_1.time_ < var_724_6 + var_724_16 then
				arg_721_1.typewritter.percent = (arg_721_1.time_ - var_724_6) / var_724_16

				arg_721_1.typewritter:SetDirty()
			end

			if arg_721_1.time_ >= var_724_6 + var_724_16 and arg_721_1.time_ < var_724_6 + var_724_16 + arg_724_0 then
				arg_721_1.typewritter.percent = 1

				arg_721_1.typewritter:SetDirty()
				arg_721_1:ShowNextGo(true)
			end
		end

		arg_721_1.nodeConfigList_ = {}

		arg_721_1:InitPlayNodeList()
	end,
	Play1102205179 = function(arg_725_0, arg_725_1)
		arg_725_1.time_ = 0
		arg_725_1.frameCnt_ = 0
		arg_725_1.state_ = "playing"
		arg_725_1.curTalkId_ = 1102205179
		arg_725_1.duration_ = 12.87

		SetActive(arg_725_1.tipsGo_, false)

		function arg_725_1.onSingleLineFinish_()
			arg_725_1.onSingleLineUpdate_ = nil
			arg_725_1.onSingleLineFinish_ = nil
			arg_725_1.state_ = "waiting"
		end

		function arg_725_1.playNext_(arg_727_0)
			if arg_727_0 == 1 then
				arg_725_0:Play1102205180(arg_725_1)
			end
		end

		function arg_725_1.onSingleLineUpdate_(arg_728_0)
			local var_728_0 = 0
			local var_728_1 = 1.225

			if var_728_0 < arg_725_1.time_ and arg_725_1.time_ <= var_728_0 + arg_728_0 then
				arg_725_1.talkMaxDuration = 0
				arg_725_1.dialogCg_.alpha = 1

				arg_725_1.dialog_:SetActive(true)
				SetActive(arg_725_1.leftNameGo_, true)

				local var_728_2 = arg_725_1:FormatText(StoryNameCfg[259].name)

				arg_725_1.leftNameTxt_.text = var_728_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_725_1.leftNameTxt_.transform)

				arg_725_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_725_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_725_1:RecordName(arg_725_1.leftNameTxt_.text)
				SetActive(arg_725_1.iconTrs_.gameObject, false)
				arg_725_1.callingController_:SetSelectedState("normal")

				local var_728_3 = arg_725_1:GetWordFromCfg(1102205179)
				local var_728_4 = arg_725_1:FormatText(var_728_3.content)

				arg_725_1.text_.text = var_728_4

				LuaForUtil.ClearLinePrefixSymbol(arg_725_1.text_)

				local var_728_5 = 49
				local var_728_6 = utf8.len(var_728_4)
				local var_728_7 = var_728_5 <= 0 and var_728_1 or var_728_1 * (var_728_6 / var_728_5)

				if var_728_7 > 0 and var_728_1 < var_728_7 then
					arg_725_1.talkMaxDuration = var_728_7

					if var_728_7 + var_728_0 > arg_725_1.duration_ then
						arg_725_1.duration_ = var_728_7 + var_728_0
					end
				end

				arg_725_1.text_.text = var_728_4
				arg_725_1.typewritter.percent = 0

				arg_725_1.typewritter:SetDirty()
				arg_725_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205179", "story_v_side_new_1102205.awb") ~= 0 then
					local var_728_8 = manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205179", "story_v_side_new_1102205.awb") / 1000

					if var_728_8 + var_728_0 > arg_725_1.duration_ then
						arg_725_1.duration_ = var_728_8 + var_728_0
					end

					if var_728_3.prefab_name ~= "" and arg_725_1.actors_[var_728_3.prefab_name] ~= nil then
						local var_728_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_725_1.actors_[var_728_3.prefab_name].transform, "story_v_side_new_1102205", "1102205179", "story_v_side_new_1102205.awb")

						arg_725_1:RecordAudio("1102205179", var_728_9)
						arg_725_1:RecordAudio("1102205179", var_728_9)
					else
						arg_725_1:AudioAction("play", "voice", "story_v_side_new_1102205", "1102205179", "story_v_side_new_1102205.awb")
					end

					arg_725_1:RecordHistoryTalkVoice("story_v_side_new_1102205", "1102205179", "story_v_side_new_1102205.awb")
				end

				arg_725_1:RecordContent(arg_725_1.text_.text)
			end

			local var_728_10 = math.max(var_728_1, arg_725_1.talkMaxDuration)

			if var_728_0 <= arg_725_1.time_ and arg_725_1.time_ < var_728_0 + var_728_10 then
				arg_725_1.typewritter.percent = (arg_725_1.time_ - var_728_0) / var_728_10

				arg_725_1.typewritter:SetDirty()
			end

			if arg_725_1.time_ >= var_728_0 + var_728_10 and arg_725_1.time_ < var_728_0 + var_728_10 + arg_728_0 then
				arg_725_1.typewritter.percent = 1

				arg_725_1.typewritter:SetDirty()
				arg_725_1:ShowNextGo(true)
			end
		end

		arg_725_1.nodeConfigList_ = {}

		arg_725_1:InitPlayNodeList()
	end,
	Play1102205180 = function(arg_729_0, arg_729_1)
		arg_729_1.time_ = 0
		arg_729_1.frameCnt_ = 0
		arg_729_1.state_ = "playing"
		arg_729_1.curTalkId_ = 1102205180
		arg_729_1.duration_ = 7.63

		SetActive(arg_729_1.tipsGo_, false)

		function arg_729_1.onSingleLineFinish_()
			arg_729_1.onSingleLineUpdate_ = nil
			arg_729_1.onSingleLineFinish_ = nil
			arg_729_1.state_ = "waiting"
		end

		function arg_729_1.playNext_(arg_731_0)
			if arg_731_0 == 1 then
				arg_729_0:Play1102205181(arg_729_1)
			end
		end

		function arg_729_1.onSingleLineUpdate_(arg_732_0)
			local var_732_0 = 0

			if var_732_0 < arg_729_1.time_ and arg_729_1.time_ <= var_732_0 + arg_732_0 then
				arg_729_1:PlayTimeline("1022ui_story", "StoryTimeline/CharAction/story1022/story1022action/1022action1_1")
			end

			local var_732_1 = 0

			if var_732_1 < arg_729_1.time_ and arg_729_1.time_ <= var_732_1 + arg_732_0 then
				arg_729_1:PlayTimeline("1022ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_732_2 = 0
			local var_732_3 = 0.725

			if var_732_2 < arg_729_1.time_ and arg_729_1.time_ <= var_732_2 + arg_732_0 then
				arg_729_1.talkMaxDuration = 0
				arg_729_1.dialogCg_.alpha = 1

				arg_729_1.dialog_:SetActive(true)
				SetActive(arg_729_1.leftNameGo_, true)

				local var_732_4 = arg_729_1:FormatText(StoryNameCfg[259].name)

				arg_729_1.leftNameTxt_.text = var_732_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_729_1.leftNameTxt_.transform)

				arg_729_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_729_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_729_1:RecordName(arg_729_1.leftNameTxt_.text)
				SetActive(arg_729_1.iconTrs_.gameObject, false)
				arg_729_1.callingController_:SetSelectedState("normal")

				local var_732_5 = arg_729_1:GetWordFromCfg(1102205180)
				local var_732_6 = arg_729_1:FormatText(var_732_5.content)

				arg_729_1.text_.text = var_732_6

				LuaForUtil.ClearLinePrefixSymbol(arg_729_1.text_)

				local var_732_7 = 29
				local var_732_8 = utf8.len(var_732_6)
				local var_732_9 = var_732_7 <= 0 and var_732_3 or var_732_3 * (var_732_8 / var_732_7)

				if var_732_9 > 0 and var_732_3 < var_732_9 then
					arg_729_1.talkMaxDuration = var_732_9

					if var_732_9 + var_732_2 > arg_729_1.duration_ then
						arg_729_1.duration_ = var_732_9 + var_732_2
					end
				end

				arg_729_1.text_.text = var_732_6
				arg_729_1.typewritter.percent = 0

				arg_729_1.typewritter:SetDirty()
				arg_729_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205180", "story_v_side_new_1102205.awb") ~= 0 then
					local var_732_10 = manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205180", "story_v_side_new_1102205.awb") / 1000

					if var_732_10 + var_732_2 > arg_729_1.duration_ then
						arg_729_1.duration_ = var_732_10 + var_732_2
					end

					if var_732_5.prefab_name ~= "" and arg_729_1.actors_[var_732_5.prefab_name] ~= nil then
						local var_732_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_729_1.actors_[var_732_5.prefab_name].transform, "story_v_side_new_1102205", "1102205180", "story_v_side_new_1102205.awb")

						arg_729_1:RecordAudio("1102205180", var_732_11)
						arg_729_1:RecordAudio("1102205180", var_732_11)
					else
						arg_729_1:AudioAction("play", "voice", "story_v_side_new_1102205", "1102205180", "story_v_side_new_1102205.awb")
					end

					arg_729_1:RecordHistoryTalkVoice("story_v_side_new_1102205", "1102205180", "story_v_side_new_1102205.awb")
				end

				arg_729_1:RecordContent(arg_729_1.text_.text)
			end

			local var_732_12 = math.max(var_732_3, arg_729_1.talkMaxDuration)

			if var_732_2 <= arg_729_1.time_ and arg_729_1.time_ < var_732_2 + var_732_12 then
				arg_729_1.typewritter.percent = (arg_729_1.time_ - var_732_2) / var_732_12

				arg_729_1.typewritter:SetDirty()
			end

			if arg_729_1.time_ >= var_732_2 + var_732_12 and arg_729_1.time_ < var_732_2 + var_732_12 + arg_732_0 then
				arg_729_1.typewritter.percent = 1

				arg_729_1.typewritter:SetDirty()
				arg_729_1:ShowNextGo(true)
			end
		end

		arg_729_1.nodeConfigList_ = {}

		arg_729_1:InitPlayNodeList()
	end,
	Play1102205181 = function(arg_733_0, arg_733_1)
		arg_733_1.time_ = 0
		arg_733_1.frameCnt_ = 0
		arg_733_1.state_ = "playing"
		arg_733_1.curTalkId_ = 1102205181
		arg_733_1.duration_ = 5

		SetActive(arg_733_1.tipsGo_, false)

		function arg_733_1.onSingleLineFinish_()
			arg_733_1.onSingleLineUpdate_ = nil
			arg_733_1.onSingleLineFinish_ = nil
			arg_733_1.state_ = "waiting"
		end

		function arg_733_1.playNext_(arg_735_0)
			if arg_735_0 == 1 then
				arg_733_0:Play1102205182(arg_733_1)
			end
		end

		function arg_733_1.onSingleLineUpdate_(arg_736_0)
			local var_736_0 = arg_733_1.actors_["1022ui_story"]
			local var_736_1 = 0

			if var_736_1 < arg_733_1.time_ and arg_733_1.time_ <= var_736_1 + arg_736_0 and not isNil(var_736_0) and arg_733_1.var_.characterEffect1022ui_story == nil then
				arg_733_1.var_.characterEffect1022ui_story = var_736_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_736_2 = 0.200000002980232

			if var_736_1 <= arg_733_1.time_ and arg_733_1.time_ < var_736_1 + var_736_2 and not isNil(var_736_0) then
				local var_736_3 = (arg_733_1.time_ - var_736_1) / var_736_2

				if arg_733_1.var_.characterEffect1022ui_story and not isNil(var_736_0) then
					local var_736_4 = Mathf.Lerp(0, 0.5, var_736_3)

					arg_733_1.var_.characterEffect1022ui_story.fillFlat = true
					arg_733_1.var_.characterEffect1022ui_story.fillRatio = var_736_4
				end
			end

			if arg_733_1.time_ >= var_736_1 + var_736_2 and arg_733_1.time_ < var_736_1 + var_736_2 + arg_736_0 and not isNil(var_736_0) and arg_733_1.var_.characterEffect1022ui_story then
				local var_736_5 = 0.5

				arg_733_1.var_.characterEffect1022ui_story.fillFlat = true
				arg_733_1.var_.characterEffect1022ui_story.fillRatio = var_736_5
			end

			local var_736_6 = 0
			local var_736_7 = 0.55

			if var_736_6 < arg_733_1.time_ and arg_733_1.time_ <= var_736_6 + arg_736_0 then
				arg_733_1.talkMaxDuration = 0
				arg_733_1.dialogCg_.alpha = 1

				arg_733_1.dialog_:SetActive(true)
				SetActive(arg_733_1.leftNameGo_, true)

				local var_736_8 = arg_733_1:FormatText(StoryNameCfg[7].name)

				arg_733_1.leftNameTxt_.text = var_736_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_733_1.leftNameTxt_.transform)

				arg_733_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_733_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_733_1:RecordName(arg_733_1.leftNameTxt_.text)
				SetActive(arg_733_1.iconTrs_.gameObject, true)
				arg_733_1.iconController_:SetSelectedState("hero")

				arg_733_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_733_1.callingController_:SetSelectedState("normal")

				arg_733_1.keyicon_.color = Color.New(1, 1, 1)
				arg_733_1.icon_.color = Color.New(1, 1, 1)

				local var_736_9 = arg_733_1:GetWordFromCfg(1102205181)
				local var_736_10 = arg_733_1:FormatText(var_736_9.content)

				arg_733_1.text_.text = var_736_10

				LuaForUtil.ClearLinePrefixSymbol(arg_733_1.text_)

				local var_736_11 = 22
				local var_736_12 = utf8.len(var_736_10)
				local var_736_13 = var_736_11 <= 0 and var_736_7 or var_736_7 * (var_736_12 / var_736_11)

				if var_736_13 > 0 and var_736_7 < var_736_13 then
					arg_733_1.talkMaxDuration = var_736_13

					if var_736_13 + var_736_6 > arg_733_1.duration_ then
						arg_733_1.duration_ = var_736_13 + var_736_6
					end
				end

				arg_733_1.text_.text = var_736_10
				arg_733_1.typewritter.percent = 0

				arg_733_1.typewritter:SetDirty()
				arg_733_1:ShowNextGo(false)
				arg_733_1:RecordContent(arg_733_1.text_.text)
			end

			local var_736_14 = math.max(var_736_7, arg_733_1.talkMaxDuration)

			if var_736_6 <= arg_733_1.time_ and arg_733_1.time_ < var_736_6 + var_736_14 then
				arg_733_1.typewritter.percent = (arg_733_1.time_ - var_736_6) / var_736_14

				arg_733_1.typewritter:SetDirty()
			end

			if arg_733_1.time_ >= var_736_6 + var_736_14 and arg_733_1.time_ < var_736_6 + var_736_14 + arg_736_0 then
				arg_733_1.typewritter.percent = 1

				arg_733_1.typewritter:SetDirty()
				arg_733_1:ShowNextGo(true)
			end
		end

		arg_733_1.nodeConfigList_ = {}

		arg_733_1:InitPlayNodeList()
	end,
	Play1102205182 = function(arg_737_0, arg_737_1)
		arg_737_1.time_ = 0
		arg_737_1.frameCnt_ = 0
		arg_737_1.state_ = "playing"
		arg_737_1.curTalkId_ = 1102205182
		arg_737_1.duration_ = 12.43

		SetActive(arg_737_1.tipsGo_, false)

		function arg_737_1.onSingleLineFinish_()
			arg_737_1.onSingleLineUpdate_ = nil
			arg_737_1.onSingleLineFinish_ = nil
			arg_737_1.state_ = "waiting"
		end

		function arg_737_1.playNext_(arg_739_0)
			if arg_739_0 == 1 then
				arg_737_0:Play1102205183(arg_737_1)
			end
		end

		function arg_737_1.onSingleLineUpdate_(arg_740_0)
			local var_740_0 = arg_737_1.actors_["1022ui_story"]
			local var_740_1 = 0

			if var_740_1 < arg_737_1.time_ and arg_737_1.time_ <= var_740_1 + arg_740_0 and not isNil(var_740_0) and arg_737_1.var_.characterEffect1022ui_story == nil then
				arg_737_1.var_.characterEffect1022ui_story = var_740_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_740_2 = 0.200000002980232

			if var_740_1 <= arg_737_1.time_ and arg_737_1.time_ < var_740_1 + var_740_2 and not isNil(var_740_0) then
				local var_740_3 = (arg_737_1.time_ - var_740_1) / var_740_2

				if arg_737_1.var_.characterEffect1022ui_story and not isNil(var_740_0) then
					arg_737_1.var_.characterEffect1022ui_story.fillFlat = false
				end
			end

			if arg_737_1.time_ >= var_740_1 + var_740_2 and arg_737_1.time_ < var_740_1 + var_740_2 + arg_740_0 and not isNil(var_740_0) and arg_737_1.var_.characterEffect1022ui_story then
				arg_737_1.var_.characterEffect1022ui_story.fillFlat = false
			end

			local var_740_4 = 0
			local var_740_5 = 1.1

			if var_740_4 < arg_737_1.time_ and arg_737_1.time_ <= var_740_4 + arg_740_0 then
				arg_737_1.talkMaxDuration = 0
				arg_737_1.dialogCg_.alpha = 1

				arg_737_1.dialog_:SetActive(true)
				SetActive(arg_737_1.leftNameGo_, true)

				local var_740_6 = arg_737_1:FormatText(StoryNameCfg[259].name)

				arg_737_1.leftNameTxt_.text = var_740_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_737_1.leftNameTxt_.transform)

				arg_737_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_737_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_737_1:RecordName(arg_737_1.leftNameTxt_.text)
				SetActive(arg_737_1.iconTrs_.gameObject, false)
				arg_737_1.callingController_:SetSelectedState("normal")

				local var_740_7 = arg_737_1:GetWordFromCfg(1102205182)
				local var_740_8 = arg_737_1:FormatText(var_740_7.content)

				arg_737_1.text_.text = var_740_8

				LuaForUtil.ClearLinePrefixSymbol(arg_737_1.text_)

				local var_740_9 = 44
				local var_740_10 = utf8.len(var_740_8)
				local var_740_11 = var_740_9 <= 0 and var_740_5 or var_740_5 * (var_740_10 / var_740_9)

				if var_740_11 > 0 and var_740_5 < var_740_11 then
					arg_737_1.talkMaxDuration = var_740_11

					if var_740_11 + var_740_4 > arg_737_1.duration_ then
						arg_737_1.duration_ = var_740_11 + var_740_4
					end
				end

				arg_737_1.text_.text = var_740_8
				arg_737_1.typewritter.percent = 0

				arg_737_1.typewritter:SetDirty()
				arg_737_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205182", "story_v_side_new_1102205.awb") ~= 0 then
					local var_740_12 = manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205182", "story_v_side_new_1102205.awb") / 1000

					if var_740_12 + var_740_4 > arg_737_1.duration_ then
						arg_737_1.duration_ = var_740_12 + var_740_4
					end

					if var_740_7.prefab_name ~= "" and arg_737_1.actors_[var_740_7.prefab_name] ~= nil then
						local var_740_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_737_1.actors_[var_740_7.prefab_name].transform, "story_v_side_new_1102205", "1102205182", "story_v_side_new_1102205.awb")

						arg_737_1:RecordAudio("1102205182", var_740_13)
						arg_737_1:RecordAudio("1102205182", var_740_13)
					else
						arg_737_1:AudioAction("play", "voice", "story_v_side_new_1102205", "1102205182", "story_v_side_new_1102205.awb")
					end

					arg_737_1:RecordHistoryTalkVoice("story_v_side_new_1102205", "1102205182", "story_v_side_new_1102205.awb")
				end

				arg_737_1:RecordContent(arg_737_1.text_.text)
			end

			local var_740_14 = math.max(var_740_5, arg_737_1.talkMaxDuration)

			if var_740_4 <= arg_737_1.time_ and arg_737_1.time_ < var_740_4 + var_740_14 then
				arg_737_1.typewritter.percent = (arg_737_1.time_ - var_740_4) / var_740_14

				arg_737_1.typewritter:SetDirty()
			end

			if arg_737_1.time_ >= var_740_4 + var_740_14 and arg_737_1.time_ < var_740_4 + var_740_14 + arg_740_0 then
				arg_737_1.typewritter.percent = 1

				arg_737_1.typewritter:SetDirty()
				arg_737_1:ShowNextGo(true)
			end
		end

		arg_737_1.nodeConfigList_ = {}

		arg_737_1:InitPlayNodeList()
	end,
	Play1102205183 = function(arg_741_0, arg_741_1)
		arg_741_1.time_ = 0
		arg_741_1.frameCnt_ = 0
		arg_741_1.state_ = "playing"
		arg_741_1.curTalkId_ = 1102205183
		arg_741_1.duration_ = 8.1

		SetActive(arg_741_1.tipsGo_, false)

		function arg_741_1.onSingleLineFinish_()
			arg_741_1.onSingleLineUpdate_ = nil
			arg_741_1.onSingleLineFinish_ = nil
			arg_741_1.state_ = "waiting"
		end

		function arg_741_1.playNext_(arg_743_0)
			if arg_743_0 == 1 then
				arg_741_0:Play1102205184(arg_741_1)
			end
		end

		function arg_741_1.onSingleLineUpdate_(arg_744_0)
			local var_744_0 = 0

			if var_744_0 < arg_741_1.time_ and arg_741_1.time_ <= var_744_0 + arg_744_0 then
				arg_741_1:PlayTimeline("1022ui_story", "StoryTimeline/CharAction/story1022/story1022action/1022action2_1")
			end

			local var_744_1 = 0

			if var_744_1 < arg_741_1.time_ and arg_741_1.time_ <= var_744_1 + arg_744_0 then
				arg_741_1:PlayTimeline("1022ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_744_2 = 0
			local var_744_3 = 0.825

			if var_744_2 < arg_741_1.time_ and arg_741_1.time_ <= var_744_2 + arg_744_0 then
				arg_741_1.talkMaxDuration = 0
				arg_741_1.dialogCg_.alpha = 1

				arg_741_1.dialog_:SetActive(true)
				SetActive(arg_741_1.leftNameGo_, true)

				local var_744_4 = arg_741_1:FormatText(StoryNameCfg[259].name)

				arg_741_1.leftNameTxt_.text = var_744_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_741_1.leftNameTxt_.transform)

				arg_741_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_741_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_741_1:RecordName(arg_741_1.leftNameTxt_.text)
				SetActive(arg_741_1.iconTrs_.gameObject, false)
				arg_741_1.callingController_:SetSelectedState("normal")

				local var_744_5 = arg_741_1:GetWordFromCfg(1102205183)
				local var_744_6 = arg_741_1:FormatText(var_744_5.content)

				arg_741_1.text_.text = var_744_6

				LuaForUtil.ClearLinePrefixSymbol(arg_741_1.text_)

				local var_744_7 = 30
				local var_744_8 = utf8.len(var_744_6)
				local var_744_9 = var_744_7 <= 0 and var_744_3 or var_744_3 * (var_744_8 / var_744_7)

				if var_744_9 > 0 and var_744_3 < var_744_9 then
					arg_741_1.talkMaxDuration = var_744_9

					if var_744_9 + var_744_2 > arg_741_1.duration_ then
						arg_741_1.duration_ = var_744_9 + var_744_2
					end
				end

				arg_741_1.text_.text = var_744_6
				arg_741_1.typewritter.percent = 0

				arg_741_1.typewritter:SetDirty()
				arg_741_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205183", "story_v_side_new_1102205.awb") ~= 0 then
					local var_744_10 = manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205183", "story_v_side_new_1102205.awb") / 1000

					if var_744_10 + var_744_2 > arg_741_1.duration_ then
						arg_741_1.duration_ = var_744_10 + var_744_2
					end

					if var_744_5.prefab_name ~= "" and arg_741_1.actors_[var_744_5.prefab_name] ~= nil then
						local var_744_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_741_1.actors_[var_744_5.prefab_name].transform, "story_v_side_new_1102205", "1102205183", "story_v_side_new_1102205.awb")

						arg_741_1:RecordAudio("1102205183", var_744_11)
						arg_741_1:RecordAudio("1102205183", var_744_11)
					else
						arg_741_1:AudioAction("play", "voice", "story_v_side_new_1102205", "1102205183", "story_v_side_new_1102205.awb")
					end

					arg_741_1:RecordHistoryTalkVoice("story_v_side_new_1102205", "1102205183", "story_v_side_new_1102205.awb")
				end

				arg_741_1:RecordContent(arg_741_1.text_.text)
			end

			local var_744_12 = math.max(var_744_3, arg_741_1.talkMaxDuration)

			if var_744_2 <= arg_741_1.time_ and arg_741_1.time_ < var_744_2 + var_744_12 then
				arg_741_1.typewritter.percent = (arg_741_1.time_ - var_744_2) / var_744_12

				arg_741_1.typewritter:SetDirty()
			end

			if arg_741_1.time_ >= var_744_2 + var_744_12 and arg_741_1.time_ < var_744_2 + var_744_12 + arg_744_0 then
				arg_741_1.typewritter.percent = 1

				arg_741_1.typewritter:SetDirty()
				arg_741_1:ShowNextGo(true)
			end
		end

		arg_741_1.nodeConfigList_ = {}

		arg_741_1:InitPlayNodeList()
	end,
	Play1102205184 = function(arg_745_0, arg_745_1)
		arg_745_1.time_ = 0
		arg_745_1.frameCnt_ = 0
		arg_745_1.state_ = "playing"
		arg_745_1.curTalkId_ = 1102205184
		arg_745_1.duration_ = 5

		SetActive(arg_745_1.tipsGo_, false)

		function arg_745_1.onSingleLineFinish_()
			arg_745_1.onSingleLineUpdate_ = nil
			arg_745_1.onSingleLineFinish_ = nil
			arg_745_1.state_ = "waiting"
		end

		function arg_745_1.playNext_(arg_747_0)
			if arg_747_0 == 1 then
				arg_745_0:Play1102205185(arg_745_1)
			end
		end

		function arg_745_1.onSingleLineUpdate_(arg_748_0)
			local var_748_0 = arg_745_1.actors_["1022ui_story"].transform
			local var_748_1 = 0

			if var_748_1 < arg_745_1.time_ and arg_745_1.time_ <= var_748_1 + arg_748_0 then
				arg_745_1.var_.moveOldPos1022ui_story = var_748_0.localPosition
			end

			local var_748_2 = 0.001

			if var_748_1 <= arg_745_1.time_ and arg_745_1.time_ < var_748_1 + var_748_2 then
				local var_748_3 = (arg_745_1.time_ - var_748_1) / var_748_2
				local var_748_4 = Vector3.New(0, 100, 0)

				var_748_0.localPosition = Vector3.Lerp(arg_745_1.var_.moveOldPos1022ui_story, var_748_4, var_748_3)

				local var_748_5 = manager.ui.mainCamera.transform.position - var_748_0.position

				var_748_0.forward = Vector3.New(var_748_5.x, var_748_5.y, var_748_5.z)

				local var_748_6 = var_748_0.localEulerAngles

				var_748_6.z = 0
				var_748_6.x = 0
				var_748_0.localEulerAngles = var_748_6
			end

			if arg_745_1.time_ >= var_748_1 + var_748_2 and arg_745_1.time_ < var_748_1 + var_748_2 + arg_748_0 then
				var_748_0.localPosition = Vector3.New(0, 100, 0)

				local var_748_7 = manager.ui.mainCamera.transform.position - var_748_0.position

				var_748_0.forward = Vector3.New(var_748_7.x, var_748_7.y, var_748_7.z)

				local var_748_8 = var_748_0.localEulerAngles

				var_748_8.z = 0
				var_748_8.x = 0
				var_748_0.localEulerAngles = var_748_8
			end

			local var_748_9 = arg_745_1.actors_["1022ui_story"]
			local var_748_10 = 0

			if var_748_10 < arg_745_1.time_ and arg_745_1.time_ <= var_748_10 + arg_748_0 and not isNil(var_748_9) and arg_745_1.var_.characterEffect1022ui_story == nil then
				arg_745_1.var_.characterEffect1022ui_story = var_748_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_748_11 = 0.200000002980232

			if var_748_10 <= arg_745_1.time_ and arg_745_1.time_ < var_748_10 + var_748_11 and not isNil(var_748_9) then
				local var_748_12 = (arg_745_1.time_ - var_748_10) / var_748_11

				if arg_745_1.var_.characterEffect1022ui_story and not isNil(var_748_9) then
					local var_748_13 = Mathf.Lerp(0, 0.5, var_748_12)

					arg_745_1.var_.characterEffect1022ui_story.fillFlat = true
					arg_745_1.var_.characterEffect1022ui_story.fillRatio = var_748_13
				end
			end

			if arg_745_1.time_ >= var_748_10 + var_748_11 and arg_745_1.time_ < var_748_10 + var_748_11 + arg_748_0 and not isNil(var_748_9) and arg_745_1.var_.characterEffect1022ui_story then
				local var_748_14 = 0.5

				arg_745_1.var_.characterEffect1022ui_story.fillFlat = true
				arg_745_1.var_.characterEffect1022ui_story.fillRatio = var_748_14
			end

			local var_748_15 = 0
			local var_748_16 = 0.6

			if var_748_15 < arg_745_1.time_ and arg_745_1.time_ <= var_748_15 + arg_748_0 then
				arg_745_1.talkMaxDuration = 0
				arg_745_1.dialogCg_.alpha = 1

				arg_745_1.dialog_:SetActive(true)
				SetActive(arg_745_1.leftNameGo_, false)

				arg_745_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_745_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_745_1:RecordName(arg_745_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_745_1.iconTrs_.gameObject, false)
				arg_745_1.callingController_:SetSelectedState("normal")

				local var_748_17 = arg_745_1:GetWordFromCfg(1102205184)
				local var_748_18 = arg_745_1:FormatText(var_748_17.content)

				arg_745_1.text_.text = var_748_18

				LuaForUtil.ClearLinePrefixSymbol(arg_745_1.text_)

				local var_748_19 = 24
				local var_748_20 = utf8.len(var_748_18)
				local var_748_21 = var_748_19 <= 0 and var_748_16 or var_748_16 * (var_748_20 / var_748_19)

				if var_748_21 > 0 and var_748_16 < var_748_21 then
					arg_745_1.talkMaxDuration = var_748_21

					if var_748_21 + var_748_15 > arg_745_1.duration_ then
						arg_745_1.duration_ = var_748_21 + var_748_15
					end
				end

				arg_745_1.text_.text = var_748_18
				arg_745_1.typewritter.percent = 0

				arg_745_1.typewritter:SetDirty()
				arg_745_1:ShowNextGo(false)
				arg_745_1:RecordContent(arg_745_1.text_.text)
			end

			local var_748_22 = math.max(var_748_16, arg_745_1.talkMaxDuration)

			if var_748_15 <= arg_745_1.time_ and arg_745_1.time_ < var_748_15 + var_748_22 then
				arg_745_1.typewritter.percent = (arg_745_1.time_ - var_748_15) / var_748_22

				arg_745_1.typewritter:SetDirty()
			end

			if arg_745_1.time_ >= var_748_15 + var_748_22 and arg_745_1.time_ < var_748_15 + var_748_22 + arg_748_0 then
				arg_745_1.typewritter.percent = 1

				arg_745_1.typewritter:SetDirty()
				arg_745_1:ShowNextGo(true)
			end
		end

		arg_745_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1022ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_745_1:InitPlayNodeList()
	end,
	Play1102205185 = function(arg_749_0, arg_749_1)
		arg_749_1.time_ = 0
		arg_749_1.frameCnt_ = 0
		arg_749_1.state_ = "playing"
		arg_749_1.curTalkId_ = 1102205185
		arg_749_1.duration_ = 5

		SetActive(arg_749_1.tipsGo_, false)

		function arg_749_1.onSingleLineFinish_()
			arg_749_1.onSingleLineUpdate_ = nil
			arg_749_1.onSingleLineFinish_ = nil
			arg_749_1.state_ = "waiting"
		end

		function arg_749_1.playNext_(arg_751_0)
			if arg_751_0 == 1 then
				arg_749_0:Play1102205186(arg_749_1)
			end
		end

		function arg_749_1.onSingleLineUpdate_(arg_752_0)
			local var_752_0 = 0
			local var_752_1 = 1.15

			if var_752_0 < arg_749_1.time_ and arg_749_1.time_ <= var_752_0 + arg_752_0 then
				arg_749_1.talkMaxDuration = 0
				arg_749_1.dialogCg_.alpha = 1

				arg_749_1.dialog_:SetActive(true)
				SetActive(arg_749_1.leftNameGo_, false)

				arg_749_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_749_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_749_1:RecordName(arg_749_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_749_1.iconTrs_.gameObject, false)
				arg_749_1.callingController_:SetSelectedState("normal")

				local var_752_2 = arg_749_1:GetWordFromCfg(1102205185)
				local var_752_3 = arg_749_1:FormatText(var_752_2.content)

				arg_749_1.text_.text = var_752_3

				LuaForUtil.ClearLinePrefixSymbol(arg_749_1.text_)

				local var_752_4 = 46
				local var_752_5 = utf8.len(var_752_3)
				local var_752_6 = var_752_4 <= 0 and var_752_1 or var_752_1 * (var_752_5 / var_752_4)

				if var_752_6 > 0 and var_752_1 < var_752_6 then
					arg_749_1.talkMaxDuration = var_752_6

					if var_752_6 + var_752_0 > arg_749_1.duration_ then
						arg_749_1.duration_ = var_752_6 + var_752_0
					end
				end

				arg_749_1.text_.text = var_752_3
				arg_749_1.typewritter.percent = 0

				arg_749_1.typewritter:SetDirty()
				arg_749_1:ShowNextGo(false)
				arg_749_1:RecordContent(arg_749_1.text_.text)
			end

			local var_752_7 = math.max(var_752_1, arg_749_1.talkMaxDuration)

			if var_752_0 <= arg_749_1.time_ and arg_749_1.time_ < var_752_0 + var_752_7 then
				arg_749_1.typewritter.percent = (arg_749_1.time_ - var_752_0) / var_752_7

				arg_749_1.typewritter:SetDirty()
			end

			if arg_749_1.time_ >= var_752_0 + var_752_7 and arg_749_1.time_ < var_752_0 + var_752_7 + arg_752_0 then
				arg_749_1.typewritter.percent = 1

				arg_749_1.typewritter:SetDirty()
				arg_749_1:ShowNextGo(true)
			end
		end

		arg_749_1.nodeConfigList_ = {}

		arg_749_1:InitPlayNodeList()
	end,
	Play1102205186 = function(arg_753_0, arg_753_1)
		arg_753_1.time_ = 0
		arg_753_1.frameCnt_ = 0
		arg_753_1.state_ = "playing"
		arg_753_1.curTalkId_ = 1102205186
		arg_753_1.duration_ = 5

		SetActive(arg_753_1.tipsGo_, false)

		function arg_753_1.onSingleLineFinish_()
			arg_753_1.onSingleLineUpdate_ = nil
			arg_753_1.onSingleLineFinish_ = nil
			arg_753_1.state_ = "waiting"
		end

		function arg_753_1.playNext_(arg_755_0)
			if arg_755_0 == 1 then
				arg_753_0:Play1102205187(arg_753_1)
			end
		end

		function arg_753_1.onSingleLineUpdate_(arg_756_0)
			local var_756_0 = 0
			local var_756_1 = 0.875

			if var_756_0 < arg_753_1.time_ and arg_753_1.time_ <= var_756_0 + arg_756_0 then
				arg_753_1.talkMaxDuration = 0
				arg_753_1.dialogCg_.alpha = 1

				arg_753_1.dialog_:SetActive(true)
				SetActive(arg_753_1.leftNameGo_, false)

				arg_753_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_753_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_753_1:RecordName(arg_753_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_753_1.iconTrs_.gameObject, false)
				arg_753_1.callingController_:SetSelectedState("normal")

				local var_756_2 = arg_753_1:GetWordFromCfg(1102205186)
				local var_756_3 = arg_753_1:FormatText(var_756_2.content)

				arg_753_1.text_.text = var_756_3

				LuaForUtil.ClearLinePrefixSymbol(arg_753_1.text_)

				local var_756_4 = 35
				local var_756_5 = utf8.len(var_756_3)
				local var_756_6 = var_756_4 <= 0 and var_756_1 or var_756_1 * (var_756_5 / var_756_4)

				if var_756_6 > 0 and var_756_1 < var_756_6 then
					arg_753_1.talkMaxDuration = var_756_6

					if var_756_6 + var_756_0 > arg_753_1.duration_ then
						arg_753_1.duration_ = var_756_6 + var_756_0
					end
				end

				arg_753_1.text_.text = var_756_3
				arg_753_1.typewritter.percent = 0

				arg_753_1.typewritter:SetDirty()
				arg_753_1:ShowNextGo(false)
				arg_753_1:RecordContent(arg_753_1.text_.text)
			end

			local var_756_7 = math.max(var_756_1, arg_753_1.talkMaxDuration)

			if var_756_0 <= arg_753_1.time_ and arg_753_1.time_ < var_756_0 + var_756_7 then
				arg_753_1.typewritter.percent = (arg_753_1.time_ - var_756_0) / var_756_7

				arg_753_1.typewritter:SetDirty()
			end

			if arg_753_1.time_ >= var_756_0 + var_756_7 and arg_753_1.time_ < var_756_0 + var_756_7 + arg_756_0 then
				arg_753_1.typewritter.percent = 1

				arg_753_1.typewritter:SetDirty()
				arg_753_1:ShowNextGo(true)
			end
		end

		arg_753_1.nodeConfigList_ = {}

		arg_753_1:InitPlayNodeList()
	end,
	Play1102205187 = function(arg_757_0, arg_757_1)
		arg_757_1.time_ = 0
		arg_757_1.frameCnt_ = 0
		arg_757_1.state_ = "playing"
		arg_757_1.curTalkId_ = 1102205187
		arg_757_1.duration_ = 11.4

		SetActive(arg_757_1.tipsGo_, false)

		function arg_757_1.onSingleLineFinish_()
			arg_757_1.onSingleLineUpdate_ = nil
			arg_757_1.onSingleLineFinish_ = nil
			arg_757_1.state_ = "waiting"
			arg_757_1.auto_ = false
		end

		function arg_757_1.playNext_(arg_759_0)
			arg_757_1.onStoryFinished_()
		end

		function arg_757_1.onSingleLineUpdate_(arg_760_0)
			local var_760_0 = arg_757_1.actors_["1022ui_story"].transform
			local var_760_1 = 0

			if var_760_1 < arg_757_1.time_ and arg_757_1.time_ <= var_760_1 + arg_760_0 then
				arg_757_1.var_.moveOldPos1022ui_story = var_760_0.localPosition
			end

			local var_760_2 = 0.001

			if var_760_1 <= arg_757_1.time_ and arg_757_1.time_ < var_760_1 + var_760_2 then
				local var_760_3 = (arg_757_1.time_ - var_760_1) / var_760_2
				local var_760_4 = Vector3.New(0, -1.08, -6)

				var_760_0.localPosition = Vector3.Lerp(arg_757_1.var_.moveOldPos1022ui_story, var_760_4, var_760_3)

				local var_760_5 = manager.ui.mainCamera.transform.position - var_760_0.position

				var_760_0.forward = Vector3.New(var_760_5.x, var_760_5.y, var_760_5.z)

				local var_760_6 = var_760_0.localEulerAngles

				var_760_6.z = 0
				var_760_6.x = 0
				var_760_0.localEulerAngles = var_760_6
			end

			if arg_757_1.time_ >= var_760_1 + var_760_2 and arg_757_1.time_ < var_760_1 + var_760_2 + arg_760_0 then
				var_760_0.localPosition = Vector3.New(0, -1.08, -6)

				local var_760_7 = manager.ui.mainCamera.transform.position - var_760_0.position

				var_760_0.forward = Vector3.New(var_760_7.x, var_760_7.y, var_760_7.z)

				local var_760_8 = var_760_0.localEulerAngles

				var_760_8.z = 0
				var_760_8.x = 0
				var_760_0.localEulerAngles = var_760_8
			end

			local var_760_9 = arg_757_1.actors_["1022ui_story"]
			local var_760_10 = 0

			if var_760_10 < arg_757_1.time_ and arg_757_1.time_ <= var_760_10 + arg_760_0 and not isNil(var_760_9) and arg_757_1.var_.characterEffect1022ui_story == nil then
				arg_757_1.var_.characterEffect1022ui_story = var_760_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_760_11 = 0.200000002980232

			if var_760_10 <= arg_757_1.time_ and arg_757_1.time_ < var_760_10 + var_760_11 and not isNil(var_760_9) then
				local var_760_12 = (arg_757_1.time_ - var_760_10) / var_760_11

				if arg_757_1.var_.characterEffect1022ui_story and not isNil(var_760_9) then
					arg_757_1.var_.characterEffect1022ui_story.fillFlat = false
				end
			end

			if arg_757_1.time_ >= var_760_10 + var_760_11 and arg_757_1.time_ < var_760_10 + var_760_11 + arg_760_0 and not isNil(var_760_9) and arg_757_1.var_.characterEffect1022ui_story then
				arg_757_1.var_.characterEffect1022ui_story.fillFlat = false
			end

			local var_760_13 = 0

			if var_760_13 < arg_757_1.time_ and arg_757_1.time_ <= var_760_13 + arg_760_0 then
				arg_757_1:PlayTimeline("1022ui_story", "StoryTimeline/CharAction/story1022/story1022action/1022action2_2")
			end

			local var_760_14 = 0

			if var_760_14 < arg_757_1.time_ and arg_757_1.time_ <= var_760_14 + arg_760_0 then
				arg_757_1:PlayTimeline("1022ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_760_15 = 0
			local var_760_16 = 1.075

			if var_760_15 < arg_757_1.time_ and arg_757_1.time_ <= var_760_15 + arg_760_0 then
				arg_757_1.talkMaxDuration = 0
				arg_757_1.dialogCg_.alpha = 1

				arg_757_1.dialog_:SetActive(true)
				SetActive(arg_757_1.leftNameGo_, true)

				local var_760_17 = arg_757_1:FormatText(StoryNameCfg[259].name)

				arg_757_1.leftNameTxt_.text = var_760_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_757_1.leftNameTxt_.transform)

				arg_757_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_757_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_757_1:RecordName(arg_757_1.leftNameTxt_.text)
				SetActive(arg_757_1.iconTrs_.gameObject, false)
				arg_757_1.callingController_:SetSelectedState("normal")

				local var_760_18 = arg_757_1:GetWordFromCfg(1102205187)
				local var_760_19 = arg_757_1:FormatText(var_760_18.content)

				arg_757_1.text_.text = var_760_19

				LuaForUtil.ClearLinePrefixSymbol(arg_757_1.text_)

				local var_760_20 = 43
				local var_760_21 = utf8.len(var_760_19)
				local var_760_22 = var_760_20 <= 0 and var_760_16 or var_760_16 * (var_760_21 / var_760_20)

				if var_760_22 > 0 and var_760_16 < var_760_22 then
					arg_757_1.talkMaxDuration = var_760_22

					if var_760_22 + var_760_15 > arg_757_1.duration_ then
						arg_757_1.duration_ = var_760_22 + var_760_15
					end
				end

				arg_757_1.text_.text = var_760_19
				arg_757_1.typewritter.percent = 0

				arg_757_1.typewritter:SetDirty()
				arg_757_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205187", "story_v_side_new_1102205.awb") ~= 0 then
					local var_760_23 = manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205187", "story_v_side_new_1102205.awb") / 1000

					if var_760_23 + var_760_15 > arg_757_1.duration_ then
						arg_757_1.duration_ = var_760_23 + var_760_15
					end

					if var_760_18.prefab_name ~= "" and arg_757_1.actors_[var_760_18.prefab_name] ~= nil then
						local var_760_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_757_1.actors_[var_760_18.prefab_name].transform, "story_v_side_new_1102205", "1102205187", "story_v_side_new_1102205.awb")

						arg_757_1:RecordAudio("1102205187", var_760_24)
						arg_757_1:RecordAudio("1102205187", var_760_24)
					else
						arg_757_1:AudioAction("play", "voice", "story_v_side_new_1102205", "1102205187", "story_v_side_new_1102205.awb")
					end

					arg_757_1:RecordHistoryTalkVoice("story_v_side_new_1102205", "1102205187", "story_v_side_new_1102205.awb")
				end

				arg_757_1:RecordContent(arg_757_1.text_.text)
			end

			local var_760_25 = math.max(var_760_16, arg_757_1.talkMaxDuration)

			if var_760_15 <= arg_757_1.time_ and arg_757_1.time_ < var_760_15 + var_760_25 then
				arg_757_1.typewritter.percent = (arg_757_1.time_ - var_760_15) / var_760_25

				arg_757_1.typewritter:SetDirty()
			end

			if arg_757_1.time_ >= var_760_15 + var_760_25 and arg_757_1.time_ < var_760_15 + var_760_25 + arg_760_0 then
				arg_757_1.typewritter.percent = 1

				arg_757_1.typewritter:SetDirty()
				arg_757_1:ShowNextGo(true)
			end
		end

		arg_757_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1022ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_757_1:InitPlayNodeList()
	end,
	Play1102205170 = function(arg_761_0, arg_761_1)
		arg_761_1.time_ = 0
		arg_761_1.frameCnt_ = 0
		arg_761_1.state_ = "playing"
		arg_761_1.curTalkId_ = 1102205170
		arg_761_1.duration_ = 3.83

		SetActive(arg_761_1.tipsGo_, false)

		function arg_761_1.onSingleLineFinish_()
			arg_761_1.onSingleLineUpdate_ = nil
			arg_761_1.onSingleLineFinish_ = nil
			arg_761_1.state_ = "waiting"
		end

		function arg_761_1.playNext_(arg_763_0)
			if arg_763_0 == 1 then
				arg_761_0:Play1102205171(arg_761_1)
			end
		end

		function arg_761_1.onSingleLineUpdate_(arg_764_0)
			local var_764_0 = "1022ui_story"

			if arg_761_1.actors_[var_764_0] == nil then
				local var_764_1 = Asset.Load("Char/" .. "1022ui_story")

				if not isNil(var_764_1) then
					local var_764_2 = Object.Instantiate(Asset.Load("Char/" .. "1022ui_story"), arg_761_1.stage_.transform)

					var_764_2.name = var_764_0
					var_764_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_761_1.actors_[var_764_0] = var_764_2

					local var_764_3 = var_764_2:GetComponentInChildren(typeof(CharacterEffect))

					var_764_3.enabled = true

					local var_764_4 = GameObjectTools.GetOrAddComponent(var_764_2, typeof(DynamicBoneHelper))

					if var_764_4 then
						var_764_4:EnableDynamicBone(false)
					end

					arg_761_1:ShowWeapon(var_764_3.transform, false)

					arg_761_1.var_[var_764_0 .. "Animator"] = var_764_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_761_1.var_[var_764_0 .. "Animator"].applyRootMotion = true
					arg_761_1.var_[var_764_0 .. "LipSync"] = var_764_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_764_5 = 0

			if var_764_5 < arg_761_1.time_ and arg_761_1.time_ <= var_764_5 + arg_764_0 then
				arg_761_1:PlayTimeline("1022ui_story", "StoryTimeline/CharAction/story1022/story1022action/1022action5_1")
			end

			local var_764_6 = "1022ui_story"

			if arg_761_1.actors_[var_764_6] == nil then
				local var_764_7 = Asset.Load("Char/" .. "1022ui_story")

				if not isNil(var_764_7) then
					local var_764_8 = Object.Instantiate(Asset.Load("Char/" .. "1022ui_story"), arg_761_1.stage_.transform)

					var_764_8.name = var_764_6
					var_764_8.transform.localPosition = Vector3.New(0, 100, 0)
					arg_761_1.actors_[var_764_6] = var_764_8

					local var_764_9 = var_764_8:GetComponentInChildren(typeof(CharacterEffect))

					var_764_9.enabled = true

					local var_764_10 = GameObjectTools.GetOrAddComponent(var_764_8, typeof(DynamicBoneHelper))

					if var_764_10 then
						var_764_10:EnableDynamicBone(false)
					end

					arg_761_1:ShowWeapon(var_764_9.transform, false)

					arg_761_1.var_[var_764_6 .. "Animator"] = var_764_9.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_761_1.var_[var_764_6 .. "Animator"].applyRootMotion = true
					arg_761_1.var_[var_764_6 .. "LipSync"] = var_764_9.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_764_11 = 0

			if var_764_11 < arg_761_1.time_ and arg_761_1.time_ <= var_764_11 + arg_764_0 then
				arg_761_1:PlayTimeline("1022ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_764_12 = arg_761_1.actors_["1022ui_story"]
			local var_764_13 = 0

			if var_764_13 < arg_761_1.time_ and arg_761_1.time_ <= var_764_13 + arg_764_0 and not isNil(var_764_12) and arg_761_1.var_.characterEffect1022ui_story == nil then
				arg_761_1.var_.characterEffect1022ui_story = var_764_12:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_764_14 = 0.200000002980232

			if var_764_13 <= arg_761_1.time_ and arg_761_1.time_ < var_764_13 + var_764_14 and not isNil(var_764_12) then
				local var_764_15 = (arg_761_1.time_ - var_764_13) / var_764_14

				if arg_761_1.var_.characterEffect1022ui_story and not isNil(var_764_12) then
					arg_761_1.var_.characterEffect1022ui_story.fillFlat = false
				end
			end

			if arg_761_1.time_ >= var_764_13 + var_764_14 and arg_761_1.time_ < var_764_13 + var_764_14 + arg_764_0 and not isNil(var_764_12) and arg_761_1.var_.characterEffect1022ui_story then
				arg_761_1.var_.characterEffect1022ui_story.fillFlat = false
			end

			local var_764_16 = 0
			local var_764_17 = 0.375

			if var_764_16 < arg_761_1.time_ and arg_761_1.time_ <= var_764_16 + arg_764_0 then
				arg_761_1.talkMaxDuration = 0
				arg_761_1.dialogCg_.alpha = 1

				arg_761_1.dialog_:SetActive(true)
				SetActive(arg_761_1.leftNameGo_, true)

				local var_764_18 = arg_761_1:FormatText(StoryNameCfg[259].name)

				arg_761_1.leftNameTxt_.text = var_764_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_761_1.leftNameTxt_.transform)

				arg_761_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_761_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_761_1:RecordName(arg_761_1.leftNameTxt_.text)
				SetActive(arg_761_1.iconTrs_.gameObject, false)
				arg_761_1.callingController_:SetSelectedState("normal")

				local var_764_19 = arg_761_1:GetWordFromCfg(1102205170)
				local var_764_20 = arg_761_1:FormatText(var_764_19.content)

				arg_761_1.text_.text = var_764_20

				LuaForUtil.ClearLinePrefixSymbol(arg_761_1.text_)

				local var_764_21 = 15
				local var_764_22 = utf8.len(var_764_20)
				local var_764_23 = var_764_21 <= 0 and var_764_17 or var_764_17 * (var_764_22 / var_764_21)

				if var_764_23 > 0 and var_764_17 < var_764_23 then
					arg_761_1.talkMaxDuration = var_764_23

					if var_764_23 + var_764_16 > arg_761_1.duration_ then
						arg_761_1.duration_ = var_764_23 + var_764_16
					end
				end

				arg_761_1.text_.text = var_764_20
				arg_761_1.typewritter.percent = 0

				arg_761_1.typewritter:SetDirty()
				arg_761_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205170", "story_v_side_new_1102205.awb") ~= 0 then
					local var_764_24 = manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205170", "story_v_side_new_1102205.awb") / 1000

					if var_764_24 + var_764_16 > arg_761_1.duration_ then
						arg_761_1.duration_ = var_764_24 + var_764_16
					end

					if var_764_19.prefab_name ~= "" and arg_761_1.actors_[var_764_19.prefab_name] ~= nil then
						local var_764_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_761_1.actors_[var_764_19.prefab_name].transform, "story_v_side_new_1102205", "1102205170", "story_v_side_new_1102205.awb")

						arg_761_1:RecordAudio("1102205170", var_764_25)
						arg_761_1:RecordAudio("1102205170", var_764_25)
					else
						arg_761_1:AudioAction("play", "voice", "story_v_side_new_1102205", "1102205170", "story_v_side_new_1102205.awb")
					end

					arg_761_1:RecordHistoryTalkVoice("story_v_side_new_1102205", "1102205170", "story_v_side_new_1102205.awb")
				end

				arg_761_1:RecordContent(arg_761_1.text_.text)
			end

			local var_764_26 = math.max(var_764_17, arg_761_1.talkMaxDuration)

			if var_764_16 <= arg_761_1.time_ and arg_761_1.time_ < var_764_16 + var_764_26 then
				arg_761_1.typewritter.percent = (arg_761_1.time_ - var_764_16) / var_764_26

				arg_761_1.typewritter:SetDirty()
			end

			if arg_761_1.time_ >= var_764_16 + var_764_26 and arg_761_1.time_ < var_764_16 + var_764_26 + arg_764_0 then
				arg_761_1.typewritter.percent = 1

				arg_761_1.typewritter:SetDirty()
				arg_761_1:ShowNextGo(true)
			end
		end

		arg_761_1.nodeConfigList_ = {}

		arg_761_1:InitPlayNodeList()
	end,
	Play1102205171 = function(arg_765_0, arg_765_1)
		arg_765_1.time_ = 0
		arg_765_1.frameCnt_ = 0
		arg_765_1.state_ = "playing"
		arg_765_1.curTalkId_ = 1102205171
		arg_765_1.duration_ = 5

		SetActive(arg_765_1.tipsGo_, false)

		function arg_765_1.onSingleLineFinish_()
			arg_765_1.onSingleLineUpdate_ = nil
			arg_765_1.onSingleLineFinish_ = nil
			arg_765_1.state_ = "waiting"
		end

		function arg_765_1.playNext_(arg_767_0)
			if arg_767_0 == 1 then
				arg_765_0:Play1102205172(arg_765_1)
			end
		end

		function arg_765_1.onSingleLineUpdate_(arg_768_0)
			local var_768_0 = arg_765_1.actors_["1022ui_story"]
			local var_768_1 = 0

			if var_768_1 < arg_765_1.time_ and arg_765_1.time_ <= var_768_1 + arg_768_0 and not isNil(var_768_0) and arg_765_1.var_.characterEffect1022ui_story == nil then
				arg_765_1.var_.characterEffect1022ui_story = var_768_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_768_2 = 0.200000002980232

			if var_768_1 <= arg_765_1.time_ and arg_765_1.time_ < var_768_1 + var_768_2 and not isNil(var_768_0) then
				local var_768_3 = (arg_765_1.time_ - var_768_1) / var_768_2

				if arg_765_1.var_.characterEffect1022ui_story and not isNil(var_768_0) then
					local var_768_4 = Mathf.Lerp(0, 0.5, var_768_3)

					arg_765_1.var_.characterEffect1022ui_story.fillFlat = true
					arg_765_1.var_.characterEffect1022ui_story.fillRatio = var_768_4
				end
			end

			if arg_765_1.time_ >= var_768_1 + var_768_2 and arg_765_1.time_ < var_768_1 + var_768_2 + arg_768_0 and not isNil(var_768_0) and arg_765_1.var_.characterEffect1022ui_story then
				local var_768_5 = 0.5

				arg_765_1.var_.characterEffect1022ui_story.fillFlat = true
				arg_765_1.var_.characterEffect1022ui_story.fillRatio = var_768_5
			end

			local var_768_6 = 0
			local var_768_7 = 0.275

			if var_768_6 < arg_765_1.time_ and arg_765_1.time_ <= var_768_6 + arg_768_0 then
				arg_765_1.talkMaxDuration = 0
				arg_765_1.dialogCg_.alpha = 1

				arg_765_1.dialog_:SetActive(true)
				SetActive(arg_765_1.leftNameGo_, true)

				local var_768_8 = arg_765_1:FormatText(StoryNameCfg[7].name)

				arg_765_1.leftNameTxt_.text = var_768_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_765_1.leftNameTxt_.transform)

				arg_765_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_765_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_765_1:RecordName(arg_765_1.leftNameTxt_.text)
				SetActive(arg_765_1.iconTrs_.gameObject, true)
				arg_765_1.iconController_:SetSelectedState("hero")

				arg_765_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_765_1.callingController_:SetSelectedState("normal")

				arg_765_1.keyicon_.color = Color.New(1, 1, 1)
				arg_765_1.icon_.color = Color.New(1, 1, 1)

				local var_768_9 = arg_765_1:GetWordFromCfg(1102205171)
				local var_768_10 = arg_765_1:FormatText(var_768_9.content)

				arg_765_1.text_.text = var_768_10

				LuaForUtil.ClearLinePrefixSymbol(arg_765_1.text_)

				local var_768_11 = 11
				local var_768_12 = utf8.len(var_768_10)
				local var_768_13 = var_768_11 <= 0 and var_768_7 or var_768_7 * (var_768_12 / var_768_11)

				if var_768_13 > 0 and var_768_7 < var_768_13 then
					arg_765_1.talkMaxDuration = var_768_13

					if var_768_13 + var_768_6 > arg_765_1.duration_ then
						arg_765_1.duration_ = var_768_13 + var_768_6
					end
				end

				arg_765_1.text_.text = var_768_10
				arg_765_1.typewritter.percent = 0

				arg_765_1.typewritter:SetDirty()
				arg_765_1:ShowNextGo(false)
				arg_765_1:RecordContent(arg_765_1.text_.text)
			end

			local var_768_14 = math.max(var_768_7, arg_765_1.talkMaxDuration)

			if var_768_6 <= arg_765_1.time_ and arg_765_1.time_ < var_768_6 + var_768_14 then
				arg_765_1.typewritter.percent = (arg_765_1.time_ - var_768_6) / var_768_14

				arg_765_1.typewritter:SetDirty()
			end

			if arg_765_1.time_ >= var_768_6 + var_768_14 and arg_765_1.time_ < var_768_6 + var_768_14 + arg_768_0 then
				arg_765_1.typewritter.percent = 1

				arg_765_1.typewritter:SetDirty()
				arg_765_1:ShowNextGo(true)
			end
		end

		arg_765_1.nodeConfigList_ = {}

		arg_765_1:InitPlayNodeList()
	end,
	Play1102205172 = function(arg_769_0, arg_769_1)
		arg_769_1.time_ = 0
		arg_769_1.frameCnt_ = 0
		arg_769_1.state_ = "playing"
		arg_769_1.curTalkId_ = 1102205172
		arg_769_1.duration_ = 5

		SetActive(arg_769_1.tipsGo_, false)

		function arg_769_1.onSingleLineFinish_()
			arg_769_1.onSingleLineUpdate_ = nil
			arg_769_1.onSingleLineFinish_ = nil
			arg_769_1.state_ = "waiting"
		end

		function arg_769_1.playNext_(arg_771_0)
			if arg_771_0 == 1 then
				arg_769_0:Play1102205173(arg_769_1)
			end
		end

		function arg_769_1.onSingleLineUpdate_(arg_772_0)
			local var_772_0 = arg_769_1.actors_["1022ui_story"]
			local var_772_1 = 0

			if var_772_1 < arg_769_1.time_ and arg_769_1.time_ <= var_772_1 + arg_772_0 and not isNil(var_772_0) and arg_769_1.var_.characterEffect1022ui_story == nil then
				arg_769_1.var_.characterEffect1022ui_story = var_772_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_772_2 = 0.200000002980232

			if var_772_1 <= arg_769_1.time_ and arg_769_1.time_ < var_772_1 + var_772_2 and not isNil(var_772_0) then
				local var_772_3 = (arg_769_1.time_ - var_772_1) / var_772_2

				if arg_769_1.var_.characterEffect1022ui_story and not isNil(var_772_0) then
					arg_769_1.var_.characterEffect1022ui_story.fillFlat = false
				end
			end

			if arg_769_1.time_ >= var_772_1 + var_772_2 and arg_769_1.time_ < var_772_1 + var_772_2 + arg_772_0 and not isNil(var_772_0) and arg_769_1.var_.characterEffect1022ui_story then
				arg_769_1.var_.characterEffect1022ui_story.fillFlat = false
			end

			local var_772_4 = 0
			local var_772_5 = 0.55

			if var_772_4 < arg_769_1.time_ and arg_769_1.time_ <= var_772_4 + arg_772_0 then
				arg_769_1.talkMaxDuration = 0
				arg_769_1.dialogCg_.alpha = 1

				arg_769_1.dialog_:SetActive(true)
				SetActive(arg_769_1.leftNameGo_, true)

				local var_772_6 = arg_769_1:FormatText(StoryNameCfg[259].name)

				arg_769_1.leftNameTxt_.text = var_772_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_769_1.leftNameTxt_.transform)

				arg_769_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_769_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_769_1:RecordName(arg_769_1.leftNameTxt_.text)
				SetActive(arg_769_1.iconTrs_.gameObject, false)
				arg_769_1.callingController_:SetSelectedState("normal")

				local var_772_7 = arg_769_1:GetWordFromCfg(1102205172)
				local var_772_8 = arg_769_1:FormatText(var_772_7.content)

				arg_769_1.text_.text = var_772_8

				LuaForUtil.ClearLinePrefixSymbol(arg_769_1.text_)

				local var_772_9 = 22
				local var_772_10 = utf8.len(var_772_8)
				local var_772_11 = var_772_9 <= 0 and var_772_5 or var_772_5 * (var_772_10 / var_772_9)

				if var_772_11 > 0 and var_772_5 < var_772_11 then
					arg_769_1.talkMaxDuration = var_772_11

					if var_772_11 + var_772_4 > arg_769_1.duration_ then
						arg_769_1.duration_ = var_772_11 + var_772_4
					end
				end

				arg_769_1.text_.text = var_772_8
				arg_769_1.typewritter.percent = 0

				arg_769_1.typewritter:SetDirty()
				arg_769_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205172", "story_v_side_new_1102205.awb") ~= 0 then
					local var_772_12 = manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205172", "story_v_side_new_1102205.awb") / 1000

					if var_772_12 + var_772_4 > arg_769_1.duration_ then
						arg_769_1.duration_ = var_772_12 + var_772_4
					end

					if var_772_7.prefab_name ~= "" and arg_769_1.actors_[var_772_7.prefab_name] ~= nil then
						local var_772_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_769_1.actors_[var_772_7.prefab_name].transform, "story_v_side_new_1102205", "1102205172", "story_v_side_new_1102205.awb")

						arg_769_1:RecordAudio("1102205172", var_772_13)
						arg_769_1:RecordAudio("1102205172", var_772_13)
					else
						arg_769_1:AudioAction("play", "voice", "story_v_side_new_1102205", "1102205172", "story_v_side_new_1102205.awb")
					end

					arg_769_1:RecordHistoryTalkVoice("story_v_side_new_1102205", "1102205172", "story_v_side_new_1102205.awb")
				end

				arg_769_1:RecordContent(arg_769_1.text_.text)
			end

			local var_772_14 = math.max(var_772_5, arg_769_1.talkMaxDuration)

			if var_772_4 <= arg_769_1.time_ and arg_769_1.time_ < var_772_4 + var_772_14 then
				arg_769_1.typewritter.percent = (arg_769_1.time_ - var_772_4) / var_772_14

				arg_769_1.typewritter:SetDirty()
			end

			if arg_769_1.time_ >= var_772_4 + var_772_14 and arg_769_1.time_ < var_772_4 + var_772_14 + arg_772_0 then
				arg_769_1.typewritter.percent = 1

				arg_769_1.typewritter:SetDirty()
				arg_769_1:ShowNextGo(true)
			end
		end

		arg_769_1.nodeConfigList_ = {}

		arg_769_1:InitPlayNodeList()
	end,
	Play1102205173 = function(arg_773_0, arg_773_1)
		arg_773_1.time_ = 0
		arg_773_1.frameCnt_ = 0
		arg_773_1.state_ = "playing"
		arg_773_1.curTalkId_ = 1102205173
		arg_773_1.duration_ = 7.3

		SetActive(arg_773_1.tipsGo_, false)

		function arg_773_1.onSingleLineFinish_()
			arg_773_1.onSingleLineUpdate_ = nil
			arg_773_1.onSingleLineFinish_ = nil
			arg_773_1.state_ = "waiting"
		end

		function arg_773_1.playNext_(arg_775_0)
			if arg_775_0 == 1 then
				arg_773_0:Play1102205174(arg_773_1)
			end
		end

		function arg_773_1.onSingleLineUpdate_(arg_776_0)
			local var_776_0 = 0
			local var_776_1 = 0.775

			if var_776_0 < arg_773_1.time_ and arg_773_1.time_ <= var_776_0 + arg_776_0 then
				arg_773_1.talkMaxDuration = 0
				arg_773_1.dialogCg_.alpha = 1

				arg_773_1.dialog_:SetActive(true)
				SetActive(arg_773_1.leftNameGo_, true)

				local var_776_2 = arg_773_1:FormatText(StoryNameCfg[259].name)

				arg_773_1.leftNameTxt_.text = var_776_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_773_1.leftNameTxt_.transform)

				arg_773_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_773_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_773_1:RecordName(arg_773_1.leftNameTxt_.text)
				SetActive(arg_773_1.iconTrs_.gameObject, false)
				arg_773_1.callingController_:SetSelectedState("normal")

				local var_776_3 = arg_773_1:GetWordFromCfg(1102205173)
				local var_776_4 = arg_773_1:FormatText(var_776_3.content)

				arg_773_1.text_.text = var_776_4

				LuaForUtil.ClearLinePrefixSymbol(arg_773_1.text_)

				local var_776_5 = 31
				local var_776_6 = utf8.len(var_776_4)
				local var_776_7 = var_776_5 <= 0 and var_776_1 or var_776_1 * (var_776_6 / var_776_5)

				if var_776_7 > 0 and var_776_1 < var_776_7 then
					arg_773_1.talkMaxDuration = var_776_7

					if var_776_7 + var_776_0 > arg_773_1.duration_ then
						arg_773_1.duration_ = var_776_7 + var_776_0
					end
				end

				arg_773_1.text_.text = var_776_4
				arg_773_1.typewritter.percent = 0

				arg_773_1.typewritter:SetDirty()
				arg_773_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205173", "story_v_side_new_1102205.awb") ~= 0 then
					local var_776_8 = manager.audio:GetVoiceLength("story_v_side_new_1102205", "1102205173", "story_v_side_new_1102205.awb") / 1000

					if var_776_8 + var_776_0 > arg_773_1.duration_ then
						arg_773_1.duration_ = var_776_8 + var_776_0
					end

					if var_776_3.prefab_name ~= "" and arg_773_1.actors_[var_776_3.prefab_name] ~= nil then
						local var_776_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_773_1.actors_[var_776_3.prefab_name].transform, "story_v_side_new_1102205", "1102205173", "story_v_side_new_1102205.awb")

						arg_773_1:RecordAudio("1102205173", var_776_9)
						arg_773_1:RecordAudio("1102205173", var_776_9)
					else
						arg_773_1:AudioAction("play", "voice", "story_v_side_new_1102205", "1102205173", "story_v_side_new_1102205.awb")
					end

					arg_773_1:RecordHistoryTalkVoice("story_v_side_new_1102205", "1102205173", "story_v_side_new_1102205.awb")
				end

				arg_773_1:RecordContent(arg_773_1.text_.text)
			end

			local var_776_10 = math.max(var_776_1, arg_773_1.talkMaxDuration)

			if var_776_0 <= arg_773_1.time_ and arg_773_1.time_ < var_776_0 + var_776_10 then
				arg_773_1.typewritter.percent = (arg_773_1.time_ - var_776_0) / var_776_10

				arg_773_1.typewritter:SetDirty()
			end

			if arg_773_1.time_ >= var_776_0 + var_776_10 and arg_773_1.time_ < var_776_0 + var_776_10 + arg_776_0 then
				arg_773_1.typewritter.percent = 1

				arg_773_1.typewritter:SetDirty()
				arg_773_1:ShowNextGo(true)
			end
		end

		arg_773_1.nodeConfigList_ = {}

		arg_773_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/F03_2",
		"TextureConfig/Background/TI0101",
		"TextureConfig/Background/ST77",
		"TextureConfig/Background/ST22",
		"TextureConfig/Background/F08l",
		"TextureConfig/Background/ST22a"
	},
	voices = {
		"story_v_side_new_1102205.awb"
	}
}
