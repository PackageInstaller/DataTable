return {
	Play426101001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 426101001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play426101002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "J27g"

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
				local var_4_5 = arg_1_1.bgs_.J27g

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
					if iter_4_0 ~= "J27g" then
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

			local var_4_24 = 0
			local var_4_25 = 0.3

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

			local var_4_30 = 0.433333333333333
			local var_4_31 = 1

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				local var_4_32 = "play"
				local var_4_33 = "music"

				arg_1_1:AudioAction(var_4_32, var_4_33, "bgm_activity_5_0_story_huatian", "bgm_activity_5_0_story_huatian", "bgm_activity_5_0_story_huatian.awb")

				local var_4_34 = ""
				local var_4_35 = manager.audio:GetAudioName("bgm_activity_5_0_story_huatian", "bgm_activity_5_0_story_huatian")

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

			local var_4_36 = 0.133333333333333
			local var_4_37 = 1

			if var_4_36 < arg_1_1.time_ and arg_1_1.time_ <= var_4_36 + arg_4_0 then
				local var_4_38 = "play"
				local var_4_39 = "effect"

				arg_1_1:AudioAction(var_4_38, var_4_39, "se_story_150", "se_story_150_flower_field", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_40 = 2
			local var_4_41 = 1.325

			if var_4_40 < arg_1_1.time_ and arg_1_1.time_ <= var_4_40 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_42 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_42:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_42:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_42:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_43 = arg_1_1:GetWordFromCfg(426101001)
				local var_4_44 = arg_1_1:FormatText(var_4_43.content)

				arg_1_1.text_.text = var_4_44

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_45 = 53
				local var_4_46 = utf8.len(var_4_44)
				local var_4_47 = var_4_45 <= 0 and var_4_41 or var_4_41 * (var_4_46 / var_4_45)

				if var_4_47 > 0 and var_4_41 < var_4_47 then
					arg_1_1.talkMaxDuration = var_4_47
					var_4_40 = var_4_40 + 0.3

					if var_4_47 + var_4_40 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_47 + var_4_40
					end
				end

				arg_1_1.text_.text = var_4_44
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_48 = var_4_40 + 0.3
			local var_4_49 = math.max(var_4_41, arg_1_1.talkMaxDuration)

			if var_4_48 <= arg_1_1.time_ and arg_1_1.time_ < var_4_48 + var_4_49 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_48) / var_4_49

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_48 + var_4_49 and arg_1_1.time_ < var_4_48 + var_4_49 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play426101002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 426101002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play426101003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0
			local var_12_1 = 1.25

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

				local var_12_2 = arg_9_1:GetWordFromCfg(426101002)
				local var_12_3 = arg_9_1:FormatText(var_12_2.content)

				arg_9_1.text_.text = var_12_3

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_4 = 50
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
	Play426101003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 426101003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play426101004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0
			local var_16_1 = 0.325

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

				local var_16_3 = arg_13_1:GetWordFromCfg(426101003)
				local var_16_4 = arg_13_1:FormatText(var_16_3.content)

				arg_13_1.text_.text = var_16_4

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_5 = 13
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
	Play426101004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 426101004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play426101005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0
			local var_20_1 = 0.95

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

				local var_20_2 = arg_17_1:GetWordFromCfg(426101004)
				local var_20_3 = arg_17_1:FormatText(var_20_2.content)

				arg_17_1.text_.text = var_20_3

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_4 = 38
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
	Play426101005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 426101005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play426101006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0
			local var_24_1 = 0.525

			if var_24_0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_0 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_2 = arg_21_1:FormatText(StoryNameCfg[7].name)

				arg_21_1.leftNameTxt_.text = var_24_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, true)
				arg_21_1.iconController_:SetSelectedState("hero")

				arg_21_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_21_1.callingController_:SetSelectedState("normal")

				arg_21_1.keyicon_.color = Color.New(1, 1, 1)
				arg_21_1.icon_.color = Color.New(1, 1, 1)

				local var_24_3 = arg_21_1:GetWordFromCfg(426101005)
				local var_24_4 = arg_21_1:FormatText(var_24_3.content)

				arg_21_1.text_.text = var_24_4

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_5 = 21
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
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_8 = math.max(var_24_1, arg_21_1.talkMaxDuration)

			if var_24_0 <= arg_21_1.time_ and arg_21_1.time_ < var_24_0 + var_24_8 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_0) / var_24_8

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_0 + var_24_8 and arg_21_1.time_ < var_24_0 + var_24_8 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play426101006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 426101006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play426101007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0
			local var_28_1 = 0.725

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

				arg_25_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_25_1.callingController_:SetSelectedState("normal")

				arg_25_1.keyicon_.color = Color.New(1, 1, 1)
				arg_25_1.icon_.color = Color.New(1, 1, 1)

				local var_28_3 = arg_25_1:GetWordFromCfg(426101006)
				local var_28_4 = arg_25_1:FormatText(var_28_3.content)

				arg_25_1.text_.text = var_28_4

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_5 = 29
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
	Play426101007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 426101007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play426101008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 0
			local var_32_1 = 0.825

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

				local var_32_3 = arg_29_1:GetWordFromCfg(426101007)
				local var_32_4 = arg_29_1:FormatText(var_32_3.content)

				arg_29_1.text_.text = var_32_4

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_5 = 33
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
	Play426101008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 426101008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play426101009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 0
			local var_36_1 = 0.925

			if var_36_0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_0 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_2 = arg_33_1:FormatText(StoryNameCfg[7].name)

				arg_33_1.leftNameTxt_.text = var_36_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, true)
				arg_33_1.iconController_:SetSelectedState("hero")

				arg_33_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_33_1.callingController_:SetSelectedState("normal")

				arg_33_1.keyicon_.color = Color.New(1, 1, 1)
				arg_33_1.icon_.color = Color.New(1, 1, 1)

				local var_36_3 = arg_33_1:GetWordFromCfg(426101008)
				local var_36_4 = arg_33_1:FormatText(var_36_3.content)

				arg_33_1.text_.text = var_36_4

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_5 = 37
				local var_36_6 = utf8.len(var_36_4)
				local var_36_7 = var_36_5 <= 0 and var_36_1 or var_36_1 * (var_36_6 / var_36_5)

				if var_36_7 > 0 and var_36_1 < var_36_7 then
					arg_33_1.talkMaxDuration = var_36_7

					if var_36_7 + var_36_0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_7 + var_36_0
					end
				end

				arg_33_1.text_.text = var_36_4
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_8 = math.max(var_36_1, arg_33_1.talkMaxDuration)

			if var_36_0 <= arg_33_1.time_ and arg_33_1.time_ < var_36_0 + var_36_8 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_0) / var_36_8

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_0 + var_36_8 and arg_33_1.time_ < var_36_0 + var_36_8 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play426101009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 426101009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play426101010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = manager.ui.mainCamera.transform
			local var_40_1 = 0

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 then
				local var_40_2 = arg_37_1.var_.effecttingluyinji1
				local var_40_3
				local var_40_4 = var_40_0

				if not var_40_2 then
					var_40_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_soundonly_keep"), var_40_4)
					var_40_2.name = "tingluyinji1"
					arg_37_1.var_.effecttingluyinji1 = var_40_2
				else
					var_40_2.transform:SetParent(var_40_4)
				end

				var_40_2.transform.localPosition = Vector3.New(0, 0, 0)
				var_40_2.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_40_5 = 0
			local var_40_6 = 1.2

			if var_40_5 < arg_37_1.time_ and arg_37_1.time_ <= var_40_5 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0

				arg_37_1.dialog_:SetActive(true)

				arg_37_1.dialogCg_.alpha = 0

				local var_40_7 = LeanTween.value(arg_37_1.dialog_, 0, 1, 0.3)

				var_40_7:setOnUpdate(LuaHelper.FloatAction(function(arg_41_0)
					arg_37_1.dialogCg_.alpha = arg_41_0
				end))
				var_40_7:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_37_1.dialog_)
					var_40_7:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_37_1.duration_ = arg_37_1.duration_ + 0.3

				SetActive(arg_37_1.leftNameGo_, false)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_8 = arg_37_1:GetWordFromCfg(426101009)
				local var_40_9 = arg_37_1:FormatText(var_40_8.content)

				arg_37_1.text_.text = var_40_9

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_10 = 48
				local var_40_11 = utf8.len(var_40_9)
				local var_40_12 = var_40_10 <= 0 and var_40_6 or var_40_6 * (var_40_11 / var_40_10)

				if var_40_12 > 0 and var_40_6 < var_40_12 then
					arg_37_1.talkMaxDuration = var_40_12
					var_40_5 = var_40_5 + 0.3

					if var_40_12 + var_40_5 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_12 + var_40_5
					end
				end

				arg_37_1.text_.text = var_40_9
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_13 = var_40_5 + 0.3
			local var_40_14 = math.max(var_40_6, arg_37_1.talkMaxDuration)

			if var_40_13 <= arg_37_1.time_ and arg_37_1.time_ < var_40_13 + var_40_14 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_13) / var_40_14

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_13 + var_40_14 and arg_37_1.time_ < var_40_13 + var_40_14 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play426101010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 426101010
		arg_43_1.duration_ = 5

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play426101011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			local var_46_0 = 0
			local var_46_1 = 0.5

			if var_46_0 < arg_43_1.time_ and arg_43_1.time_ <= var_46_0 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				local var_46_2 = arg_43_1:FormatText(StoryNameCfg[7].name)

				arg_43_1.leftNameTxt_.text = var_46_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, true)
				arg_43_1.iconController_:SetSelectedState("hero")

				arg_43_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_43_1.callingController_:SetSelectedState("normal")

				arg_43_1.keyicon_.color = Color.New(1, 1, 1)
				arg_43_1.icon_.color = Color.New(1, 1, 1)

				local var_46_3 = arg_43_1:GetWordFromCfg(426101010)
				local var_46_4 = arg_43_1:FormatText(var_46_3.content)

				arg_43_1.text_.text = var_46_4

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_5 = 20
				local var_46_6 = utf8.len(var_46_4)
				local var_46_7 = var_46_5 <= 0 and var_46_1 or var_46_1 * (var_46_6 / var_46_5)

				if var_46_7 > 0 and var_46_1 < var_46_7 then
					arg_43_1.talkMaxDuration = var_46_7

					if var_46_7 + var_46_0 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_7 + var_46_0
					end
				end

				arg_43_1.text_.text = var_46_4
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)
				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_8 = math.max(var_46_1, arg_43_1.talkMaxDuration)

			if var_46_0 <= arg_43_1.time_ and arg_43_1.time_ < var_46_0 + var_46_8 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_0) / var_46_8

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_0 + var_46_8 and arg_43_1.time_ < var_46_0 + var_46_8 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {}

		arg_43_1:InitPlayNodeList()
	end,
	Play426101011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 426101011
		arg_47_1.duration_ = 12.57

		local var_47_0 = {
			zh = 8.166,
			ja = 12.566
		}
		local var_47_1 = manager.audio:GetLocalizationFlag()

		if var_47_0[var_47_1] ~= nil then
			arg_47_1.duration_ = var_47_0[var_47_1]
		end

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play426101012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			local var_50_0 = "STblack"

			if arg_47_1.bgs_[var_50_0] == nil then
				local var_50_1 = Object.Instantiate(arg_47_1.paintGo_)

				var_50_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_50_0)
				var_50_1.name = var_50_0
				var_50_1.transform.parent = arg_47_1.stage_.transform
				var_50_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_47_1.bgs_[var_50_0] = var_50_1
			end

			local var_50_2 = 1.9

			if var_50_2 < arg_47_1.time_ and arg_47_1.time_ <= var_50_2 + arg_50_0 then
				local var_50_3 = manager.ui.mainCamera.transform.localPosition
				local var_50_4 = Vector3.New(0, 0, 10) + Vector3.New(var_50_3.x, var_50_3.y, 0)
				local var_50_5 = arg_47_1.bgs_.STblack

				var_50_5.transform.localPosition = var_50_4
				var_50_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_50_6 = var_50_5:GetComponent("SpriteRenderer")

				if var_50_6 and var_50_6.sprite then
					local var_50_7 = (var_50_5.transform.localPosition - var_50_3).z
					local var_50_8 = manager.ui.mainCameraCom_
					local var_50_9 = 2 * var_50_7 * Mathf.Tan(var_50_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_50_10 = var_50_9 * var_50_8.aspect
					local var_50_11 = var_50_6.sprite.bounds.size.x
					local var_50_12 = var_50_6.sprite.bounds.size.y
					local var_50_13 = var_50_10 / var_50_11
					local var_50_14 = var_50_9 / var_50_12
					local var_50_15 = var_50_14 < var_50_13 and var_50_13 or var_50_14

					var_50_5.transform.localScale = Vector3.New(var_50_15, var_50_15, 0)
				end

				for iter_50_0, iter_50_1 in pairs(arg_47_1.bgs_) do
					if iter_50_0 ~= "STblack" then
						iter_50_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_50_16 = "SS2601"

			if arg_47_1.bgs_[var_50_16] == nil then
				local var_50_17 = Object.Instantiate(arg_47_1.paintGo_)

				var_50_17:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_50_16)
				var_50_17.name = var_50_16
				var_50_17.transform.parent = arg_47_1.stage_.transform
				var_50_17.transform.localPosition = Vector3.New(0, 100, 0)
				arg_47_1.bgs_[var_50_16] = var_50_17
			end

			local var_50_18 = 2

			if var_50_18 < arg_47_1.time_ and arg_47_1.time_ <= var_50_18 + arg_50_0 then
				local var_50_19 = manager.ui.mainCamera.transform.localPosition
				local var_50_20 = Vector3.New(0, 0, 10) + Vector3.New(var_50_19.x, var_50_19.y, 0)
				local var_50_21 = arg_47_1.bgs_.SS2601

				var_50_21.transform.localPosition = var_50_20
				var_50_21.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_50_22 = var_50_21:GetComponent("SpriteRenderer")

				if var_50_22 and var_50_22.sprite then
					local var_50_23 = (var_50_21.transform.localPosition - var_50_19).z
					local var_50_24 = manager.ui.mainCameraCom_
					local var_50_25 = 2 * var_50_23 * Mathf.Tan(var_50_24.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_50_26 = var_50_25 * var_50_24.aspect
					local var_50_27 = var_50_22.sprite.bounds.size.x
					local var_50_28 = var_50_22.sprite.bounds.size.y
					local var_50_29 = var_50_26 / var_50_27
					local var_50_30 = var_50_25 / var_50_28
					local var_50_31 = var_50_30 < var_50_29 and var_50_29 or var_50_30

					var_50_21.transform.localScale = Vector3.New(var_50_31, var_50_31, 0)
				end

				for iter_50_2, iter_50_3 in pairs(arg_47_1.bgs_) do
					if iter_50_2 ~= "SS2601" then
						iter_50_3.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_50_32 = 2

			if var_50_32 < arg_47_1.time_ and arg_47_1.time_ <= var_50_32 + arg_50_0 then
				arg_47_1.mask_.enabled = true
				arg_47_1.mask_.raycastTarget = true

				arg_47_1:SetGaussion(false)
			end

			local var_50_33 = 2

			if var_50_32 <= arg_47_1.time_ and arg_47_1.time_ < var_50_32 + var_50_33 then
				local var_50_34 = (arg_47_1.time_ - var_50_32) / var_50_33
				local var_50_35 = Color.New(0, 0, 0)

				var_50_35.a = Mathf.Lerp(1, 0, var_50_34)
				arg_47_1.mask_.color = var_50_35
			end

			if arg_47_1.time_ >= var_50_32 + var_50_33 and arg_47_1.time_ < var_50_32 + var_50_33 + arg_50_0 then
				local var_50_36 = Color.New(0, 0, 0)
				local var_50_37 = 0

				arg_47_1.mask_.enabled = false
				var_50_36.a = var_50_37
				arg_47_1.mask_.color = var_50_36
			end

			local var_50_38 = 4

			if var_50_38 < arg_47_1.time_ and arg_47_1.time_ <= var_50_38 + arg_50_0 then
				arg_47_1.allBtn_.enabled = false
			end

			local var_50_39 = 0.3

			if arg_47_1.time_ >= var_50_38 + var_50_39 and arg_47_1.time_ < var_50_38 + var_50_39 + arg_50_0 then
				arg_47_1.allBtn_.enabled = true
			end

			local var_50_40 = manager.ui.mainCamera.transform
			local var_50_41 = 1.9

			if var_50_41 < arg_47_1.time_ and arg_47_1.time_ <= var_50_41 + arg_50_0 then
				local var_50_42 = arg_47_1.var_.effecttingluyinji1

				if var_50_42 then
					Object.Destroy(var_50_42)

					arg_47_1.var_.effecttingluyinji1 = nil
				end
			end

			local var_50_43 = manager.ui.mainCamera.transform
			local var_50_44 = 2

			if var_50_44 < arg_47_1.time_ and arg_47_1.time_ <= var_50_44 + arg_50_0 then
				local var_50_45 = arg_47_1.var_.effectfangshipin2
				local var_50_46
				local var_50_47 = var_50_43

				if not var_50_45 then
					var_50_45 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_monitor"), var_50_47)
					var_50_45.name = "fangshipin2"
					arg_47_1.var_.effectfangshipin2 = var_50_45
				else
					var_50_45.transform:SetParent(var_50_47)
				end

				var_50_45.transform.localPosition = Vector3.New(0, 0, 0)
				var_50_45.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_50_48 = 1.7777777777777777
				local var_50_49 = Screen.width / Screen.height
				local var_50_50 = var_50_49 / var_50_48
				local var_50_51 = Mathf.Max(var_50_48 / var_50_49, 1)

				var_50_45.transform.localScale = Vector3.New(var_50_45.transform.localScale.x * var_50_50, var_50_45.transform.localScale.y * var_50_51, var_50_45.transform.localScale.z)
			end

			local var_50_52 = manager.ui.mainCamera.transform
			local var_50_53 = 2

			if var_50_53 < arg_47_1.time_ and arg_47_1.time_ <= var_50_53 + arg_50_0 then
				local var_50_54 = arg_47_1.var_.effectfangshipin3
				local var_50_55
				local var_50_56 = var_50_52

				if not var_50_54 then
					var_50_54 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_vignetting"), var_50_56)
					var_50_54.name = "fangshipin3"
					arg_47_1.var_.effectfangshipin3 = var_50_54
				else
					var_50_54.transform:SetParent(var_50_56)
				end

				var_50_54.transform.localPosition = Vector3.New(0, 0, 0)
				var_50_54.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_50_57 = 1.7777777777777777
				local var_50_58 = Screen.width / Screen.height
				local var_50_59 = var_50_58 / var_50_57
				local var_50_60 = Mathf.Max(var_50_57 / var_50_58, 1)

				var_50_54.transform.localScale = Vector3.New(var_50_54.transform.localScale.x * var_50_59, var_50_54.transform.localScale.y * var_50_60, var_50_54.transform.localScale.z)
			end

			local var_50_61 = manager.ui.mainCamera.transform
			local var_50_62 = 0

			if var_50_62 < arg_47_1.time_ and arg_47_1.time_ <= var_50_62 + arg_50_0 then
				local var_50_63 = arg_47_1.var_.effectzhayanzhuanchang23
				local var_50_64
				local var_50_65 = var_50_61

				if not var_50_63 then
					var_50_63 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_snapshut"), var_50_65)
					var_50_63.name = "zhayanzhuanchang23"
					arg_47_1.var_.effectzhayanzhuanchang23 = var_50_63
				else
					var_50_63.transform:SetParent(var_50_65)
				end

				var_50_63.transform.localPosition = Vector3.New(0, 0, 0)
				var_50_63.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_50_66 = 1.7777777777777777
				local var_50_67 = Screen.width / Screen.height
				local var_50_68 = var_50_67 / var_50_66
				local var_50_69 = Mathf.Max(var_50_66 / var_50_67, 1)

				var_50_63.transform.localScale = Vector3.New(var_50_63.transform.localScale.x * var_50_68, var_50_63.transform.localScale.y * var_50_69, var_50_63.transform.localScale.z)
			end

			local var_50_70 = manager.ui.mainCamera.transform
			local var_50_71 = 2

			if var_50_71 < arg_47_1.time_ and arg_47_1.time_ <= var_50_71 + arg_50_0 then
				local var_50_72 = arg_47_1.var_.effectzhayanzhuanchang23

				if var_50_72 then
					Object.Destroy(var_50_72)

					arg_47_1.var_.effectzhayanzhuanchang23 = nil
				end
			end

			local var_50_73 = manager.ui.mainCamera.transform
			local var_50_74 = 4

			if var_50_74 < arg_47_1.time_ and arg_47_1.time_ <= var_50_74 + arg_50_0 then
				local var_50_75 = arg_47_1.var_.effectzhayanzhuanchang24

				if var_50_75 then
					Object.Destroy(var_50_75)

					arg_47_1.var_.effectzhayanzhuanchang24 = nil
				end
			end

			if arg_47_1.frameCnt_ <= 1 then
				arg_47_1.dialog_:SetActive(false)
			end

			local var_50_76 = 4
			local var_50_77 = 0.55

			if var_50_76 < arg_47_1.time_ and arg_47_1.time_ <= var_50_76 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0

				arg_47_1.dialog_:SetActive(true)

				arg_47_1.dialogCg_.alpha = 0

				local var_50_78 = LeanTween.value(arg_47_1.dialog_, 0, 1, 0.3)

				var_50_78:setOnUpdate(LuaHelper.FloatAction(function(arg_51_0)
					arg_47_1.dialogCg_.alpha = arg_51_0
				end))
				var_50_78:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_47_1.dialog_)
					var_50_78:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_47_1.duration_ = arg_47_1.duration_ + 0.3

				SetActive(arg_47_1.leftNameGo_, true)

				local var_50_79 = arg_47_1:FormatText(StoryNameCfg[1488].name)

				arg_47_1.leftNameTxt_.text = var_50_79

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_80 = arg_47_1:GetWordFromCfg(426101011)
				local var_50_81 = arg_47_1:FormatText(var_50_80.content)

				arg_47_1.text_.text = var_50_81

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_82 = 22
				local var_50_83 = utf8.len(var_50_81)
				local var_50_84 = var_50_82 <= 0 and var_50_77 or var_50_77 * (var_50_83 / var_50_82)

				if var_50_84 > 0 and var_50_77 < var_50_84 then
					arg_47_1.talkMaxDuration = var_50_84
					var_50_76 = var_50_76 + 0.3

					if var_50_84 + var_50_76 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_84 + var_50_76
					end
				end

				arg_47_1.text_.text = var_50_81
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426101", "426101011", "story_v_out_426101.awb") ~= 0 then
					local var_50_85 = manager.audio:GetVoiceLength("story_v_out_426101", "426101011", "story_v_out_426101.awb") / 1000

					if var_50_85 + var_50_76 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_85 + var_50_76
					end

					if var_50_80.prefab_name ~= "" and arg_47_1.actors_[var_50_80.prefab_name] ~= nil then
						local var_50_86 = LuaForUtil.PlayVoiceWithCriLipsync(arg_47_1.actors_[var_50_80.prefab_name].transform, "story_v_out_426101", "426101011", "story_v_out_426101.awb")

						arg_47_1:RecordAudio("426101011", var_50_86)
						arg_47_1:RecordAudio("426101011", var_50_86)
					else
						arg_47_1:AudioAction("play", "voice", "story_v_out_426101", "426101011", "story_v_out_426101.awb")
					end

					arg_47_1:RecordHistoryTalkVoice("story_v_out_426101", "426101011", "story_v_out_426101.awb")
				end

				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_87 = var_50_76 + 0.3
			local var_50_88 = math.max(var_50_77, arg_47_1.talkMaxDuration)

			if var_50_87 <= arg_47_1.time_ and arg_47_1.time_ < var_50_87 + var_50_88 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_87) / var_50_88

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_87 + var_50_88 and arg_47_1.time_ < var_50_87 + var_50_88 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {}

		arg_47_1:InitPlayNodeList()
	end,
	Play426101012 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 426101012
		arg_53_1.duration_ = 3.5

		local var_53_0 = {
			zh = 3.166,
			ja = 3.5
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
				arg_53_0:Play426101013(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 0
			local var_56_1 = 0.225

			if var_56_0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_2 = arg_53_1:FormatText(StoryNameCfg[1487].name)

				arg_53_1.leftNameTxt_.text = var_56_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_3 = arg_53_1:GetWordFromCfg(426101012)
				local var_56_4 = arg_53_1:FormatText(var_56_3.content)

				arg_53_1.text_.text = var_56_4

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_5 = 9
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

				if manager.audio:GetVoiceLength("story_v_out_426101", "426101012", "story_v_out_426101.awb") ~= 0 then
					local var_56_8 = manager.audio:GetVoiceLength("story_v_out_426101", "426101012", "story_v_out_426101.awb") / 1000

					if var_56_8 + var_56_0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_8 + var_56_0
					end

					if var_56_3.prefab_name ~= "" and arg_53_1.actors_[var_56_3.prefab_name] ~= nil then
						local var_56_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_3.prefab_name].transform, "story_v_out_426101", "426101012", "story_v_out_426101.awb")

						arg_53_1:RecordAudio("426101012", var_56_9)
						arg_53_1:RecordAudio("426101012", var_56_9)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_426101", "426101012", "story_v_out_426101.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_426101", "426101012", "story_v_out_426101.awb")
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
	Play426101013 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 426101013
		arg_57_1.duration_ = 4.3

		local var_57_0 = {
			zh = 3.366,
			ja = 4.3
		}
		local var_57_1 = manager.audio:GetLocalizationFlag()

		if var_57_0[var_57_1] ~= nil then
			arg_57_1.duration_ = var_57_0[var_57_1]
		end

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play426101014(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = 0
			local var_60_1 = 0.375

			if var_60_0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_0 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_2 = arg_57_1:FormatText(StoryNameCfg[1488].name)

				arg_57_1.leftNameTxt_.text = var_60_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_3 = arg_57_1:GetWordFromCfg(426101013)
				local var_60_4 = arg_57_1:FormatText(var_60_3.content)

				arg_57_1.text_.text = var_60_4

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_5 = 15
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

				if manager.audio:GetVoiceLength("story_v_out_426101", "426101013", "story_v_out_426101.awb") ~= 0 then
					local var_60_8 = manager.audio:GetVoiceLength("story_v_out_426101", "426101013", "story_v_out_426101.awb") / 1000

					if var_60_8 + var_60_0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_8 + var_60_0
					end

					if var_60_3.prefab_name ~= "" and arg_57_1.actors_[var_60_3.prefab_name] ~= nil then
						local var_60_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_3.prefab_name].transform, "story_v_out_426101", "426101013", "story_v_out_426101.awb")

						arg_57_1:RecordAudio("426101013", var_60_9)
						arg_57_1:RecordAudio("426101013", var_60_9)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_426101", "426101013", "story_v_out_426101.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_426101", "426101013", "story_v_out_426101.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_10 = math.max(var_60_1, arg_57_1.talkMaxDuration)

			if var_60_0 <= arg_57_1.time_ and arg_57_1.time_ < var_60_0 + var_60_10 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_0) / var_60_10

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_0 + var_60_10 and arg_57_1.time_ < var_60_0 + var_60_10 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play426101014 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 426101014
		arg_61_1.duration_ = 5.43

		local var_61_0 = {
			zh = 5.433,
			ja = 4.8
		}
		local var_61_1 = manager.audio:GetLocalizationFlag()

		if var_61_0[var_61_1] ~= nil then
			arg_61_1.duration_ = var_61_0[var_61_1]
		end

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play426101015(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = 0
			local var_64_1 = 0.575

			if var_64_0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_0 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_2 = arg_61_1:FormatText(StoryNameCfg[1487].name)

				arg_61_1.leftNameTxt_.text = var_64_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_3 = arg_61_1:GetWordFromCfg(426101014)
				local var_64_4 = arg_61_1:FormatText(var_64_3.content)

				arg_61_1.text_.text = var_64_4

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_5 = 23
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

				if manager.audio:GetVoiceLength("story_v_out_426101", "426101014", "story_v_out_426101.awb") ~= 0 then
					local var_64_8 = manager.audio:GetVoiceLength("story_v_out_426101", "426101014", "story_v_out_426101.awb") / 1000

					if var_64_8 + var_64_0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_8 + var_64_0
					end

					if var_64_3.prefab_name ~= "" and arg_61_1.actors_[var_64_3.prefab_name] ~= nil then
						local var_64_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_3.prefab_name].transform, "story_v_out_426101", "426101014", "story_v_out_426101.awb")

						arg_61_1:RecordAudio("426101014", var_64_9)
						arg_61_1:RecordAudio("426101014", var_64_9)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_426101", "426101014", "story_v_out_426101.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_426101", "426101014", "story_v_out_426101.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_10 = math.max(var_64_1, arg_61_1.talkMaxDuration)

			if var_64_0 <= arg_61_1.time_ and arg_61_1.time_ < var_64_0 + var_64_10 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_0) / var_64_10

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_0 + var_64_10 and arg_61_1.time_ < var_64_0 + var_64_10 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play426101015 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 426101015
		arg_65_1.duration_ = 11.27

		local var_65_0 = {
			zh = 7.033,
			ja = 11.266
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
				arg_65_0:Play426101016(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = 0
			local var_68_1 = 0.8

			if var_68_0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_0 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_2 = arg_65_1:FormatText(StoryNameCfg[1488].name)

				arg_65_1.leftNameTxt_.text = var_68_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_3 = arg_65_1:GetWordFromCfg(426101015)
				local var_68_4 = arg_65_1:FormatText(var_68_3.content)

				arg_65_1.text_.text = var_68_4

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_5 = 32
				local var_68_6 = utf8.len(var_68_4)
				local var_68_7 = var_68_5 <= 0 and var_68_1 or var_68_1 * (var_68_6 / var_68_5)

				if var_68_7 > 0 and var_68_1 < var_68_7 then
					arg_65_1.talkMaxDuration = var_68_7

					if var_68_7 + var_68_0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_7 + var_68_0
					end
				end

				arg_65_1.text_.text = var_68_4
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426101", "426101015", "story_v_out_426101.awb") ~= 0 then
					local var_68_8 = manager.audio:GetVoiceLength("story_v_out_426101", "426101015", "story_v_out_426101.awb") / 1000

					if var_68_8 + var_68_0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_8 + var_68_0
					end

					if var_68_3.prefab_name ~= "" and arg_65_1.actors_[var_68_3.prefab_name] ~= nil then
						local var_68_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_3.prefab_name].transform, "story_v_out_426101", "426101015", "story_v_out_426101.awb")

						arg_65_1:RecordAudio("426101015", var_68_9)
						arg_65_1:RecordAudio("426101015", var_68_9)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_426101", "426101015", "story_v_out_426101.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_426101", "426101015", "story_v_out_426101.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_10 = math.max(var_68_1, arg_65_1.talkMaxDuration)

			if var_68_0 <= arg_65_1.time_ and arg_65_1.time_ < var_68_0 + var_68_10 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_0) / var_68_10

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_0 + var_68_10 and arg_65_1.time_ < var_68_0 + var_68_10 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play426101016 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 426101016
		arg_69_1.duration_ = 5

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play426101017(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = 0
			local var_72_1 = 0.925

			if var_72_0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_0 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, false)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_2 = arg_69_1:GetWordFromCfg(426101016)
				local var_72_3 = arg_69_1:FormatText(var_72_2.content)

				arg_69_1.text_.text = var_72_3

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_4 = 37
				local var_72_5 = utf8.len(var_72_3)
				local var_72_6 = var_72_4 <= 0 and var_72_1 or var_72_1 * (var_72_5 / var_72_4)

				if var_72_6 > 0 and var_72_1 < var_72_6 then
					arg_69_1.talkMaxDuration = var_72_6

					if var_72_6 + var_72_0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_6 + var_72_0
					end
				end

				arg_69_1.text_.text = var_72_3
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)
				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_7 = math.max(var_72_1, arg_69_1.talkMaxDuration)

			if var_72_0 <= arg_69_1.time_ and arg_69_1.time_ < var_72_0 + var_72_7 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_0) / var_72_7

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_0 + var_72_7 and arg_69_1.time_ < var_72_0 + var_72_7 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play426101017 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 426101017
		arg_73_1.duration_ = 9.97

		local var_73_0 = {
			zh = 4.466,
			ja = 9.966
		}
		local var_73_1 = manager.audio:GetLocalizationFlag()

		if var_73_0[var_73_1] ~= nil then
			arg_73_1.duration_ = var_73_0[var_73_1]
		end

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play426101018(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = 0
			local var_76_1 = 0.5

			if var_76_0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_0 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				local var_76_2 = arg_73_1:FormatText(StoryNameCfg[1488].name)

				arg_73_1.leftNameTxt_.text = var_76_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_3 = arg_73_1:GetWordFromCfg(426101017)
				local var_76_4 = arg_73_1:FormatText(var_76_3.content)

				arg_73_1.text_.text = var_76_4

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_5 = 20
				local var_76_6 = utf8.len(var_76_4)
				local var_76_7 = var_76_5 <= 0 and var_76_1 or var_76_1 * (var_76_6 / var_76_5)

				if var_76_7 > 0 and var_76_1 < var_76_7 then
					arg_73_1.talkMaxDuration = var_76_7

					if var_76_7 + var_76_0 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_7 + var_76_0
					end
				end

				arg_73_1.text_.text = var_76_4
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426101", "426101017", "story_v_out_426101.awb") ~= 0 then
					local var_76_8 = manager.audio:GetVoiceLength("story_v_out_426101", "426101017", "story_v_out_426101.awb") / 1000

					if var_76_8 + var_76_0 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_8 + var_76_0
					end

					if var_76_3.prefab_name ~= "" and arg_73_1.actors_[var_76_3.prefab_name] ~= nil then
						local var_76_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_3.prefab_name].transform, "story_v_out_426101", "426101017", "story_v_out_426101.awb")

						arg_73_1:RecordAudio("426101017", var_76_9)
						arg_73_1:RecordAudio("426101017", var_76_9)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_426101", "426101017", "story_v_out_426101.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_426101", "426101017", "story_v_out_426101.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_10 = math.max(var_76_1, arg_73_1.talkMaxDuration)

			if var_76_0 <= arg_73_1.time_ and arg_73_1.time_ < var_76_0 + var_76_10 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_0) / var_76_10

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_0 + var_76_10 and arg_73_1.time_ < var_76_0 + var_76_10 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play426101018 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 426101018
		arg_77_1.duration_ = 4.6

		local var_77_0 = {
			zh = 4.6,
			ja = 3.733
		}
		local var_77_1 = manager.audio:GetLocalizationFlag()

		if var_77_0[var_77_1] ~= nil then
			arg_77_1.duration_ = var_77_0[var_77_1]
		end

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play426101019(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = 0
			local var_80_1 = 0.4

			if var_80_0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_0 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				local var_80_2 = arg_77_1:FormatText(StoryNameCfg[1487].name)

				arg_77_1.leftNameTxt_.text = var_80_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_3 = arg_77_1:GetWordFromCfg(426101018)
				local var_80_4 = arg_77_1:FormatText(var_80_3.content)

				arg_77_1.text_.text = var_80_4

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_5 = 16
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

				if manager.audio:GetVoiceLength("story_v_out_426101", "426101018", "story_v_out_426101.awb") ~= 0 then
					local var_80_8 = manager.audio:GetVoiceLength("story_v_out_426101", "426101018", "story_v_out_426101.awb") / 1000

					if var_80_8 + var_80_0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_8 + var_80_0
					end

					if var_80_3.prefab_name ~= "" and arg_77_1.actors_[var_80_3.prefab_name] ~= nil then
						local var_80_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_3.prefab_name].transform, "story_v_out_426101", "426101018", "story_v_out_426101.awb")

						arg_77_1:RecordAudio("426101018", var_80_9)
						arg_77_1:RecordAudio("426101018", var_80_9)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_426101", "426101018", "story_v_out_426101.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_426101", "426101018", "story_v_out_426101.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_10 = math.max(var_80_1, arg_77_1.talkMaxDuration)

			if var_80_0 <= arg_77_1.time_ and arg_77_1.time_ < var_80_0 + var_80_10 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_0) / var_80_10

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_0 + var_80_10 and arg_77_1.time_ < var_80_0 + var_80_10 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play426101019 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 426101019
		arg_81_1.duration_ = 5.93

		local var_81_0 = {
			zh = 4.6,
			ja = 5.933
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
				arg_81_0:Play426101020(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = 0
			local var_84_1 = 0.5

			if var_84_0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_0 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				local var_84_2 = arg_81_1:FormatText(StoryNameCfg[1488].name)

				arg_81_1.leftNameTxt_.text = var_84_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_3 = arg_81_1:GetWordFromCfg(426101019)
				local var_84_4 = arg_81_1:FormatText(var_84_3.content)

				arg_81_1.text_.text = var_84_4

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_5 = 20
				local var_84_6 = utf8.len(var_84_4)
				local var_84_7 = var_84_5 <= 0 and var_84_1 or var_84_1 * (var_84_6 / var_84_5)

				if var_84_7 > 0 and var_84_1 < var_84_7 then
					arg_81_1.talkMaxDuration = var_84_7

					if var_84_7 + var_84_0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_7 + var_84_0
					end
				end

				arg_81_1.text_.text = var_84_4
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426101", "426101019", "story_v_out_426101.awb") ~= 0 then
					local var_84_8 = manager.audio:GetVoiceLength("story_v_out_426101", "426101019", "story_v_out_426101.awb") / 1000

					if var_84_8 + var_84_0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_8 + var_84_0
					end

					if var_84_3.prefab_name ~= "" and arg_81_1.actors_[var_84_3.prefab_name] ~= nil then
						local var_84_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_3.prefab_name].transform, "story_v_out_426101", "426101019", "story_v_out_426101.awb")

						arg_81_1:RecordAudio("426101019", var_84_9)
						arg_81_1:RecordAudio("426101019", var_84_9)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_426101", "426101019", "story_v_out_426101.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_426101", "426101019", "story_v_out_426101.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_10 = math.max(var_84_1, arg_81_1.talkMaxDuration)

			if var_84_0 <= arg_81_1.time_ and arg_81_1.time_ < var_84_0 + var_84_10 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_0) / var_84_10

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_0 + var_84_10 and arg_81_1.time_ < var_84_0 + var_84_10 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play426101020 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 426101020
		arg_85_1.duration_ = 4.7

		local var_85_0 = {
			zh = 4.5,
			ja = 4.7
		}
		local var_85_1 = manager.audio:GetLocalizationFlag()

		if var_85_0[var_85_1] ~= nil then
			arg_85_1.duration_ = var_85_0[var_85_1]
		end

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play426101021(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = 0
			local var_88_1 = 0.475

			if var_88_0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_0 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				local var_88_2 = arg_85_1:FormatText(StoryNameCfg[1487].name)

				arg_85_1.leftNameTxt_.text = var_88_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_3 = arg_85_1:GetWordFromCfg(426101020)
				local var_88_4 = arg_85_1:FormatText(var_88_3.content)

				arg_85_1.text_.text = var_88_4

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_5 = 19
				local var_88_6 = utf8.len(var_88_4)
				local var_88_7 = var_88_5 <= 0 and var_88_1 or var_88_1 * (var_88_6 / var_88_5)

				if var_88_7 > 0 and var_88_1 < var_88_7 then
					arg_85_1.talkMaxDuration = var_88_7

					if var_88_7 + var_88_0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_7 + var_88_0
					end
				end

				arg_85_1.text_.text = var_88_4
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426101", "426101020", "story_v_out_426101.awb") ~= 0 then
					local var_88_8 = manager.audio:GetVoiceLength("story_v_out_426101", "426101020", "story_v_out_426101.awb") / 1000

					if var_88_8 + var_88_0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_8 + var_88_0
					end

					if var_88_3.prefab_name ~= "" and arg_85_1.actors_[var_88_3.prefab_name] ~= nil then
						local var_88_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_3.prefab_name].transform, "story_v_out_426101", "426101020", "story_v_out_426101.awb")

						arg_85_1:RecordAudio("426101020", var_88_9)
						arg_85_1:RecordAudio("426101020", var_88_9)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_426101", "426101020", "story_v_out_426101.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_426101", "426101020", "story_v_out_426101.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_10 = math.max(var_88_1, arg_85_1.talkMaxDuration)

			if var_88_0 <= arg_85_1.time_ and arg_85_1.time_ < var_88_0 + var_88_10 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_0) / var_88_10

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_0 + var_88_10 and arg_85_1.time_ < var_88_0 + var_88_10 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play426101021 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 426101021
		arg_89_1.duration_ = 3.8

		local var_89_0 = {
			zh = 3.8,
			ja = 2.466
		}
		local var_89_1 = manager.audio:GetLocalizationFlag()

		if var_89_0[var_89_1] ~= nil then
			arg_89_1.duration_ = var_89_0[var_89_1]
		end

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play426101022(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = 0
			local var_92_1 = 0.35

			if var_92_0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_0 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				local var_92_2 = arg_89_1:FormatText(StoryNameCfg[1487].name)

				arg_89_1.leftNameTxt_.text = var_92_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_3 = arg_89_1:GetWordFromCfg(426101021)
				local var_92_4 = arg_89_1:FormatText(var_92_3.content)

				arg_89_1.text_.text = var_92_4

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_5 = 14
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

				if manager.audio:GetVoiceLength("story_v_out_426101", "426101021", "story_v_out_426101.awb") ~= 0 then
					local var_92_8 = manager.audio:GetVoiceLength("story_v_out_426101", "426101021", "story_v_out_426101.awb") / 1000

					if var_92_8 + var_92_0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_8 + var_92_0
					end

					if var_92_3.prefab_name ~= "" and arg_89_1.actors_[var_92_3.prefab_name] ~= nil then
						local var_92_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_3.prefab_name].transform, "story_v_out_426101", "426101021", "story_v_out_426101.awb")

						arg_89_1:RecordAudio("426101021", var_92_9)
						arg_89_1:RecordAudio("426101021", var_92_9)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_426101", "426101021", "story_v_out_426101.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_426101", "426101021", "story_v_out_426101.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_10 = math.max(var_92_1, arg_89_1.talkMaxDuration)

			if var_92_0 <= arg_89_1.time_ and arg_89_1.time_ < var_92_0 + var_92_10 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_0) / var_92_10

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_0 + var_92_10 and arg_89_1.time_ < var_92_0 + var_92_10 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play426101022 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 426101022
		arg_93_1.duration_ = 10.4

		local var_93_0 = {
			zh = 10.4,
			ja = 8.733
		}
		local var_93_1 = manager.audio:GetLocalizationFlag()

		if var_93_0[var_93_1] ~= nil then
			arg_93_1.duration_ = var_93_0[var_93_1]
		end

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play426101023(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = 0
			local var_96_1 = 1.2

			if var_96_0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_0 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				local var_96_2 = arg_93_1:FormatText(StoryNameCfg[1488].name)

				arg_93_1.leftNameTxt_.text = var_96_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_3 = arg_93_1:GetWordFromCfg(426101022)
				local var_96_4 = arg_93_1:FormatText(var_96_3.content)

				arg_93_1.text_.text = var_96_4

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_5 = 48
				local var_96_6 = utf8.len(var_96_4)
				local var_96_7 = var_96_5 <= 0 and var_96_1 or var_96_1 * (var_96_6 / var_96_5)

				if var_96_7 > 0 and var_96_1 < var_96_7 then
					arg_93_1.talkMaxDuration = var_96_7

					if var_96_7 + var_96_0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_7 + var_96_0
					end
				end

				arg_93_1.text_.text = var_96_4
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426101", "426101022", "story_v_out_426101.awb") ~= 0 then
					local var_96_8 = manager.audio:GetVoiceLength("story_v_out_426101", "426101022", "story_v_out_426101.awb") / 1000

					if var_96_8 + var_96_0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_8 + var_96_0
					end

					if var_96_3.prefab_name ~= "" and arg_93_1.actors_[var_96_3.prefab_name] ~= nil then
						local var_96_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_3.prefab_name].transform, "story_v_out_426101", "426101022", "story_v_out_426101.awb")

						arg_93_1:RecordAudio("426101022", var_96_9)
						arg_93_1:RecordAudio("426101022", var_96_9)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_426101", "426101022", "story_v_out_426101.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_426101", "426101022", "story_v_out_426101.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_10 = math.max(var_96_1, arg_93_1.talkMaxDuration)

			if var_96_0 <= arg_93_1.time_ and arg_93_1.time_ < var_96_0 + var_96_10 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_0) / var_96_10

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_0 + var_96_10 and arg_93_1.time_ < var_96_0 + var_96_10 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play426101023 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 426101023
		arg_97_1.duration_ = 3.83

		local var_97_0 = {
			zh = 2.5,
			ja = 3.833
		}
		local var_97_1 = manager.audio:GetLocalizationFlag()

		if var_97_0[var_97_1] ~= nil then
			arg_97_1.duration_ = var_97_0[var_97_1]
		end

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play426101024(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = 0
			local var_100_1 = 0.15

			if var_100_0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_0 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				local var_100_2 = arg_97_1:FormatText(StoryNameCfg[1487].name)

				arg_97_1.leftNameTxt_.text = var_100_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_3 = arg_97_1:GetWordFromCfg(426101023)
				local var_100_4 = arg_97_1:FormatText(var_100_3.content)

				arg_97_1.text_.text = var_100_4

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_5 = 6
				local var_100_6 = utf8.len(var_100_4)
				local var_100_7 = var_100_5 <= 0 and var_100_1 or var_100_1 * (var_100_6 / var_100_5)

				if var_100_7 > 0 and var_100_1 < var_100_7 then
					arg_97_1.talkMaxDuration = var_100_7

					if var_100_7 + var_100_0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_7 + var_100_0
					end
				end

				arg_97_1.text_.text = var_100_4
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426101", "426101023", "story_v_out_426101.awb") ~= 0 then
					local var_100_8 = manager.audio:GetVoiceLength("story_v_out_426101", "426101023", "story_v_out_426101.awb") / 1000

					if var_100_8 + var_100_0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_8 + var_100_0
					end

					if var_100_3.prefab_name ~= "" and arg_97_1.actors_[var_100_3.prefab_name] ~= nil then
						local var_100_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_3.prefab_name].transform, "story_v_out_426101", "426101023", "story_v_out_426101.awb")

						arg_97_1:RecordAudio("426101023", var_100_9)
						arg_97_1:RecordAudio("426101023", var_100_9)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_426101", "426101023", "story_v_out_426101.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_426101", "426101023", "story_v_out_426101.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_10 = math.max(var_100_1, arg_97_1.talkMaxDuration)

			if var_100_0 <= arg_97_1.time_ and arg_97_1.time_ < var_100_0 + var_100_10 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_0) / var_100_10

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_0 + var_100_10 and arg_97_1.time_ < var_100_0 + var_100_10 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play426101024 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 426101024
		arg_101_1.duration_ = 1

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play426101025(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = 0

			if var_104_0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_0 + arg_104_0 then
				arg_101_1.allBtn_.enabled = false
			end

			local var_104_1 = 1

			if arg_101_1.time_ >= var_104_0 + var_104_1 and arg_101_1.time_ < var_104_0 + var_104_1 + arg_104_0 then
				arg_101_1.allBtn_.enabled = true
			end
		end

		arg_101_1.nodeConfigList_ = {
			{
				displayDialog = false,
				enableBgChange = false,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				enableEffect = true,
				contentID = 426101024,
				charCount = 23,
				enableLayoutChange = true,
				duration = 1,
				groupID = "sheyingji6",
				startTime = 0,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.CREATE_TEXT_GROUP,
				layoutData = {
					topPadding = 0,
					bottomPadding = 0,
					rightPadding = 0,
					leftPadding = 0,
					paragraphSpacing = 0,
					offsetMin = Vector2.New(100, 100),
					offsetMax = Vector2.New(-100, -140),
					paragraphAlignment = UnityEngine.TextAnchor.LowerLeft
				},
				textComProperty = {
					fontSize = 36,
					fontAssetPath = "Fonts/SourceHanSans",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.UpperCenter
				},
				effectData = {
					startAlpha = 0,
					endAlpha = 1,
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.ALPHA
				}
			}
		}

		arg_101_1:InitPlayNodeList()
	end,
	Play426101025 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 426101025
		arg_105_1.duration_ = 5

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play426101026(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = 0

			if var_108_0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_0 + arg_108_0 then
				arg_105_1.allBtn_.enabled = false
			end

			local var_108_1 = 0.1

			if arg_105_1.time_ >= var_108_0 + var_108_1 and arg_105_1.time_ < var_108_0 + var_108_1 + arg_108_0 then
				arg_105_1.allBtn_.enabled = true
			end

			local var_108_2 = 0
			local var_108_3 = 0.575

			if var_108_2 < arg_105_1.time_ and arg_105_1.time_ <= var_108_2 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0

				arg_105_1.dialog_:SetActive(true)

				arg_105_1.dialogCg_.alpha = 0

				local var_108_4 = LeanTween.value(arg_105_1.dialog_, 0, 1, 0.3)

				var_108_4:setOnUpdate(LuaHelper.FloatAction(function(arg_109_0)
					arg_105_1.dialogCg_.alpha = arg_109_0
				end))
				var_108_4:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_105_1.dialog_)
					var_108_4:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_105_1.duration_ = arg_105_1.duration_ + 0.3

				SetActive(arg_105_1.leftNameGo_, false)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_5 = arg_105_1:GetWordFromCfg(426101025)
				local var_108_6 = arg_105_1:FormatText(var_108_5.content)

				arg_105_1.text_.text = var_108_6

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_7 = 23
				local var_108_8 = utf8.len(var_108_6)
				local var_108_9 = var_108_7 <= 0 and var_108_3 or var_108_3 * (var_108_8 / var_108_7)

				if var_108_9 > 0 and var_108_3 < var_108_9 then
					arg_105_1.talkMaxDuration = var_108_9
					var_108_2 = var_108_2 + 0.3

					if var_108_9 + var_108_2 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_9 + var_108_2
					end
				end

				arg_105_1.text_.text = var_108_6
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)
				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_10 = var_108_2 + 0.3
			local var_108_11 = math.max(var_108_3, arg_105_1.talkMaxDuration)

			if var_108_10 <= arg_105_1.time_ and arg_105_1.time_ < var_108_10 + var_108_11 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_10) / var_108_11

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_10 + var_108_11 and arg_105_1.time_ < var_108_10 + var_108_11 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {
			{
				groupID = "sheyingji6",
				duration = 0.1,
				className = "StoryTextGroupNode",
				startTime = 0,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.DESTROY_TEXT_GROUP
			}
		}

		arg_105_1:InitPlayNodeList()
	end,
	Play426101026 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 426101026
		arg_111_1.duration_ = 3.87

		local var_111_0 = {
			zh = 3.3,
			ja = 3.866
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
				arg_111_0:Play426101027(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = 0
			local var_114_1 = 0.3

			if var_114_0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_0 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0

				arg_111_1.dialog_:SetActive(true)

				arg_111_1.dialogCg_.alpha = 0

				local var_114_2 = LeanTween.value(arg_111_1.dialog_, 0, 1, 0.3)

				var_114_2:setOnUpdate(LuaHelper.FloatAction(function(arg_115_0)
					arg_111_1.dialogCg_.alpha = arg_115_0
				end))
				var_114_2:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_111_1.dialog_)
					var_114_2:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_111_1.duration_ = arg_111_1.duration_ + 0.3

				SetActive(arg_111_1.leftNameGo_, true)

				local var_114_3 = arg_111_1:FormatText(StoryNameCfg[1487].name)

				arg_111_1.leftNameTxt_.text = var_114_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_4 = arg_111_1:GetWordFromCfg(426101026)
				local var_114_5 = arg_111_1:FormatText(var_114_4.content)

				arg_111_1.text_.text = var_114_5

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_6 = 12
				local var_114_7 = utf8.len(var_114_5)
				local var_114_8 = var_114_6 <= 0 and var_114_1 or var_114_1 * (var_114_7 / var_114_6)

				if var_114_8 > 0 and var_114_1 < var_114_8 then
					arg_111_1.talkMaxDuration = var_114_8
					var_114_0 = var_114_0 + 0.3

					if var_114_8 + var_114_0 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_8 + var_114_0
					end
				end

				arg_111_1.text_.text = var_114_5
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426101", "426101026", "story_v_out_426101.awb") ~= 0 then
					local var_114_9 = manager.audio:GetVoiceLength("story_v_out_426101", "426101026", "story_v_out_426101.awb") / 1000

					if var_114_9 + var_114_0 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_9 + var_114_0
					end

					if var_114_4.prefab_name ~= "" and arg_111_1.actors_[var_114_4.prefab_name] ~= nil then
						local var_114_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_4.prefab_name].transform, "story_v_out_426101", "426101026", "story_v_out_426101.awb")

						arg_111_1:RecordAudio("426101026", var_114_10)
						arg_111_1:RecordAudio("426101026", var_114_10)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_426101", "426101026", "story_v_out_426101.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_426101", "426101026", "story_v_out_426101.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_11 = var_114_0 + 0.3
			local var_114_12 = math.max(var_114_1, arg_111_1.talkMaxDuration)

			if var_114_11 <= arg_111_1.time_ and arg_111_1.time_ < var_114_11 + var_114_12 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_11) / var_114_12

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_11 + var_114_12 and arg_111_1.time_ < var_114_11 + var_114_12 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play426101027 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 426101027
		arg_117_1.duration_ = 1

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play426101028(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = 0

			if var_120_0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_0 + arg_120_0 then
				arg_117_1.allBtn_.enabled = false
			end

			local var_120_1 = 1

			if arg_117_1.time_ >= var_120_0 + var_120_1 and arg_117_1.time_ < var_120_0 + var_120_1 + arg_120_0 then
				arg_117_1.allBtn_.enabled = true
			end
		end

		arg_117_1.nodeConfigList_ = {
			{
				displayDialog = false,
				enableBgChange = false,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				enableEffect = true,
				contentID = 426101027,
				charCount = 31,
				enableLayoutChange = true,
				duration = 1,
				groupID = "sheyingji1",
				startTime = 0,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.CREATE_TEXT_GROUP,
				layoutData = {
					topPadding = 0,
					bottomPadding = 0,
					rightPadding = 0,
					leftPadding = 0,
					paragraphSpacing = 0,
					offsetMin = Vector2.New(100, 100),
					offsetMax = Vector2.New(-100, -140),
					paragraphAlignment = UnityEngine.TextAnchor.LowerLeft
				},
				textComProperty = {
					fontSize = 36,
					fontAssetPath = "Fonts/SourceHanSans",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.UpperCenter
				},
				effectData = {
					startAlpha = 0,
					endAlpha = 1,
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.ALPHA
				}
			}
		}

		arg_117_1:InitPlayNodeList()
	end,
	Play426101028 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 426101028
		arg_121_1.duration_ = 2.97

		local var_121_0 = {
			zh = 2.966,
			ja = 1.966
		}
		local var_121_1 = manager.audio:GetLocalizationFlag()

		if var_121_0[var_121_1] ~= nil then
			arg_121_1.duration_ = var_121_0[var_121_1]
		end

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play426101029(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = 0

			if var_124_0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_0 + arg_124_0 then
				arg_121_1.allBtn_.enabled = false
			end

			local var_124_1 = 0.0553461015224457

			if arg_121_1.time_ >= var_124_0 + var_124_1 and arg_121_1.time_ < var_124_0 + var_124_1 + arg_124_0 then
				arg_121_1.allBtn_.enabled = true
			end

			local var_124_2 = 0
			local var_124_3 = 0.35

			if var_124_2 < arg_121_1.time_ and arg_121_1.time_ <= var_124_2 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0

				arg_121_1.dialog_:SetActive(true)

				arg_121_1.dialogCg_.alpha = 0

				local var_124_4 = LeanTween.value(arg_121_1.dialog_, 0, 1, 0.3)

				var_124_4:setOnUpdate(LuaHelper.FloatAction(function(arg_125_0)
					arg_121_1.dialogCg_.alpha = arg_125_0
				end))
				var_124_4:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_121_1.dialog_)
					var_124_4:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_121_1.duration_ = arg_121_1.duration_ + 0.3

				SetActive(arg_121_1.leftNameGo_, true)

				local var_124_5 = arg_121_1:FormatText(StoryNameCfg[1488].name)

				arg_121_1.leftNameTxt_.text = var_124_5

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_6 = arg_121_1:GetWordFromCfg(426101028)
				local var_124_7 = arg_121_1:FormatText(var_124_6.content)

				arg_121_1.text_.text = var_124_7

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_8 = 14
				local var_124_9 = utf8.len(var_124_7)
				local var_124_10 = var_124_8 <= 0 and var_124_3 or var_124_3 * (var_124_9 / var_124_8)

				if var_124_10 > 0 and var_124_3 < var_124_10 then
					arg_121_1.talkMaxDuration = var_124_10
					var_124_2 = var_124_2 + 0.3

					if var_124_10 + var_124_2 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_10 + var_124_2
					end
				end

				arg_121_1.text_.text = var_124_7
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426101", "426101028", "story_v_out_426101.awb") ~= 0 then
					local var_124_11 = manager.audio:GetVoiceLength("story_v_out_426101", "426101028", "story_v_out_426101.awb") / 1000

					if var_124_11 + var_124_2 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_11 + var_124_2
					end

					if var_124_6.prefab_name ~= "" and arg_121_1.actors_[var_124_6.prefab_name] ~= nil then
						local var_124_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_6.prefab_name].transform, "story_v_out_426101", "426101028", "story_v_out_426101.awb")

						arg_121_1:RecordAudio("426101028", var_124_12)
						arg_121_1:RecordAudio("426101028", var_124_12)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_426101", "426101028", "story_v_out_426101.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_426101", "426101028", "story_v_out_426101.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_13 = var_124_2 + 0.3
			local var_124_14 = math.max(var_124_3, arg_121_1.talkMaxDuration)

			if var_124_13 <= arg_121_1.time_ and arg_121_1.time_ < var_124_13 + var_124_14 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_13) / var_124_14

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_13 + var_124_14 and arg_121_1.time_ < var_124_13 + var_124_14 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {
			{
				groupID = "sheyingji1",
				duration = 0.0553461015224457,
				className = "StoryTextGroupNode",
				startTime = 0,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.DESTROY_TEXT_GROUP
			}
		}

		arg_121_1:InitPlayNodeList()
	end,
	Play426101029 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 426101029
		arg_127_1.duration_ = 1

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play426101030(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = 0

			if var_130_0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_0 + arg_130_0 then
				arg_127_1.allBtn_.enabled = false
			end

			local var_130_1 = 1

			if arg_127_1.time_ >= var_130_0 + var_130_1 and arg_127_1.time_ < var_130_0 + var_130_1 + arg_130_0 then
				arg_127_1.allBtn_.enabled = true
			end
		end

		arg_127_1.nodeConfigList_ = {
			{
				displayDialog = false,
				enableBgChange = false,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				enableEffect = true,
				contentID = 426101029,
				charCount = 14,
				enableLayoutChange = true,
				duration = 1,
				groupID = "sheyingji2",
				startTime = 0,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.CREATE_TEXT_GROUP,
				layoutData = {
					topPadding = 0,
					bottomPadding = 0,
					rightPadding = 0,
					leftPadding = 0,
					paragraphSpacing = 0,
					offsetMin = Vector2.New(100, 100),
					offsetMax = Vector2.New(-100, -140),
					paragraphAlignment = UnityEngine.TextAnchor.LowerLeft
				},
				textComProperty = {
					fontSize = 36,
					fontAssetPath = "Fonts/SourceHanSans",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.UpperCenter
				},
				effectData = {
					startAlpha = 0,
					endAlpha = 1,
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.ALPHA
				}
			}
		}

		arg_127_1:InitPlayNodeList()
	end,
	Play426101030 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 426101030
		arg_131_1.duration_ = 2.1

		local var_131_0 = {
			zh = 1.533,
			ja = 2.1
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
				arg_131_0:Play426101031(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = 0

			if var_134_0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_0 + arg_134_0 then
				arg_131_1.allBtn_.enabled = false
			end

			local var_134_1 = 0.1

			if arg_131_1.time_ >= var_134_0 + var_134_1 and arg_131_1.time_ < var_134_0 + var_134_1 + arg_134_0 then
				arg_131_1.allBtn_.enabled = true
			end

			if arg_131_1.frameCnt_ <= 1 then
				arg_131_1.dialog_:SetActive(false)
			end

			local var_134_2 = 0.1
			local var_134_3 = 0.333333333333333

			if var_134_2 < arg_131_1.time_ and arg_131_1.time_ <= var_134_2 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0

				arg_131_1.dialog_:SetActive(true)

				arg_131_1.dialogCg_.alpha = 0

				local var_134_4 = LeanTween.value(arg_131_1.dialog_, 0, 1, 0.3)

				var_134_4:setOnUpdate(LuaHelper.FloatAction(function(arg_135_0)
					arg_131_1.dialogCg_.alpha = arg_135_0
				end))
				var_134_4:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_131_1.dialog_)
					var_134_4:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_131_1.duration_ = arg_131_1.duration_ + 0.3

				SetActive(arg_131_1.leftNameGo_, true)

				local var_134_5 = arg_131_1:FormatText(StoryNameCfg[1488].name)

				arg_131_1.leftNameTxt_.text = var_134_5

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_6 = arg_131_1:GetWordFromCfg(426101030)
				local var_134_7 = arg_131_1:FormatText(var_134_6.content)

				arg_131_1.text_.text = var_134_7

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_8 = 4
				local var_134_9 = utf8.len(var_134_7)
				local var_134_10 = var_134_8 <= 0 and var_134_3 or var_134_3 * (var_134_9 / var_134_8)

				if var_134_10 > 0 and var_134_3 < var_134_10 then
					arg_131_1.talkMaxDuration = var_134_10
					var_134_2 = var_134_2 + 0.3

					if var_134_10 + var_134_2 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_10 + var_134_2
					end
				end

				arg_131_1.text_.text = var_134_7
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426101", "426101030", "story_v_out_426101.awb") ~= 0 then
					local var_134_11 = manager.audio:GetVoiceLength("story_v_out_426101", "426101030", "story_v_out_426101.awb") / 1000

					if var_134_11 + var_134_2 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_11 + var_134_2
					end

					if var_134_6.prefab_name ~= "" and arg_131_1.actors_[var_134_6.prefab_name] ~= nil then
						local var_134_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_6.prefab_name].transform, "story_v_out_426101", "426101030", "story_v_out_426101.awb")

						arg_131_1:RecordAudio("426101030", var_134_12)
						arg_131_1:RecordAudio("426101030", var_134_12)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_426101", "426101030", "story_v_out_426101.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_426101", "426101030", "story_v_out_426101.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_13 = var_134_2 + 0.3
			local var_134_14 = math.max(var_134_3, arg_131_1.talkMaxDuration)

			if var_134_13 <= arg_131_1.time_ and arg_131_1.time_ < var_134_13 + var_134_14 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_13) / var_134_14

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_13 + var_134_14 and arg_131_1.time_ < var_134_13 + var_134_14 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {
			{
				groupID = "sheyingji2",
				duration = 0.1,
				className = "StoryTextGroupNode",
				startTime = 0,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.DESTROY_TEXT_GROUP
			}
		}

		arg_131_1:InitPlayNodeList()
	end,
	Play426101031 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 426101031
		arg_137_1.duration_ = 1

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play426101032(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = 0

			if var_140_0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_0 + arg_140_0 then
				arg_137_1.allBtn_.enabled = false
			end

			local var_140_1 = 1

			if arg_137_1.time_ >= var_140_0 + var_140_1 and arg_137_1.time_ < var_140_0 + var_140_1 + arg_140_0 then
				arg_137_1.allBtn_.enabled = true
			end
		end

		arg_137_1.nodeConfigList_ = {
			{
				displayDialog = false,
				enableBgChange = false,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				enableEffect = true,
				contentID = 426101031,
				charCount = 3,
				enableLayoutChange = true,
				duration = 1,
				groupID = "sheyingji3",
				startTime = 0,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.CREATE_TEXT_GROUP,
				layoutData = {
					topPadding = 0,
					bottomPadding = 0,
					rightPadding = 0,
					leftPadding = 0,
					paragraphSpacing = 0,
					offsetMin = Vector2.New(100, 100),
					offsetMax = Vector2.New(-100, -140),
					paragraphAlignment = UnityEngine.TextAnchor.LowerLeft
				},
				textComProperty = {
					fontSize = 36,
					fontAssetPath = "Fonts/SourceHanSans",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.UpperCenter
				},
				effectData = {
					startAlpha = 0,
					endAlpha = 1,
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.ALPHA
				}
			}
		}

		arg_137_1:InitPlayNodeList()
	end,
	Play426101032 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 426101032
		arg_141_1.duration_ = 1.5

		local var_141_0 = {
			zh = 1.5,
			ja = 1.466
		}
		local var_141_1 = manager.audio:GetLocalizationFlag()

		if var_141_0[var_141_1] ~= nil then
			arg_141_1.duration_ = var_141_0[var_141_1]
		end

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play426101033(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = 0

			if var_144_0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_0 + arg_144_0 then
				arg_141_1.allBtn_.enabled = false
			end

			local var_144_1 = 0.0610351003706455

			if arg_141_1.time_ >= var_144_0 + var_144_1 and arg_141_1.time_ < var_144_0 + var_144_1 + arg_144_0 then
				arg_141_1.allBtn_.enabled = true
			end

			local var_144_2 = 0
			local var_144_3 = 0.125

			if var_144_2 < arg_141_1.time_ and arg_141_1.time_ <= var_144_2 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0

				arg_141_1.dialog_:SetActive(true)

				arg_141_1.dialogCg_.alpha = 0

				local var_144_4 = LeanTween.value(arg_141_1.dialog_, 0, 1, 0.3)

				var_144_4:setOnUpdate(LuaHelper.FloatAction(function(arg_145_0)
					arg_141_1.dialogCg_.alpha = arg_145_0
				end))
				var_144_4:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_141_1.dialog_)
					var_144_4:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_141_1.duration_ = arg_141_1.duration_ + 0.3

				SetActive(arg_141_1.leftNameGo_, true)

				local var_144_5 = arg_141_1:FormatText(StoryNameCfg[1487].name)

				arg_141_1.leftNameTxt_.text = var_144_5

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_6 = arg_141_1:GetWordFromCfg(426101032)
				local var_144_7 = arg_141_1:FormatText(var_144_6.content)

				arg_141_1.text_.text = var_144_7

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_8 = 5
				local var_144_9 = utf8.len(var_144_7)
				local var_144_10 = var_144_8 <= 0 and var_144_3 or var_144_3 * (var_144_9 / var_144_8)

				if var_144_10 > 0 and var_144_3 < var_144_10 then
					arg_141_1.talkMaxDuration = var_144_10
					var_144_2 = var_144_2 + 0.3

					if var_144_10 + var_144_2 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_10 + var_144_2
					end
				end

				arg_141_1.text_.text = var_144_7
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426101", "426101032", "story_v_out_426101.awb") ~= 0 then
					local var_144_11 = manager.audio:GetVoiceLength("story_v_out_426101", "426101032", "story_v_out_426101.awb") / 1000

					if var_144_11 + var_144_2 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_11 + var_144_2
					end

					if var_144_6.prefab_name ~= "" and arg_141_1.actors_[var_144_6.prefab_name] ~= nil then
						local var_144_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_6.prefab_name].transform, "story_v_out_426101", "426101032", "story_v_out_426101.awb")

						arg_141_1:RecordAudio("426101032", var_144_12)
						arg_141_1:RecordAudio("426101032", var_144_12)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_426101", "426101032", "story_v_out_426101.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_426101", "426101032", "story_v_out_426101.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_13 = var_144_2 + 0.3
			local var_144_14 = math.max(var_144_3, arg_141_1.talkMaxDuration)

			if var_144_13 <= arg_141_1.time_ and arg_141_1.time_ < var_144_13 + var_144_14 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_13) / var_144_14

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_13 + var_144_14 and arg_141_1.time_ < var_144_13 + var_144_14 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {
			{
				groupID = "sheyingji3",
				duration = 0.0610351003706455,
				className = "StoryTextGroupNode",
				startTime = 0,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.DESTROY_TEXT_GROUP
			}
		}

		arg_141_1:InitPlayNodeList()
	end,
	Play426101033 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 426101033
		arg_147_1.duration_ = 2.3

		local var_147_0 = {
			zh = 2,
			ja = 2.3
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
				arg_147_0:Play426101034(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = 0
			local var_150_1 = 0.075

			if var_150_0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_0 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				local var_150_2 = arg_147_1:FormatText(StoryNameCfg[1488].name)

				arg_147_1.leftNameTxt_.text = var_150_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_3 = arg_147_1:GetWordFromCfg(426101033)
				local var_150_4 = arg_147_1:FormatText(var_150_3.content)

				arg_147_1.text_.text = var_150_4

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_5 = 3
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

				if manager.audio:GetVoiceLength("story_v_out_426101", "426101033", "story_v_out_426101.awb") ~= 0 then
					local var_150_8 = manager.audio:GetVoiceLength("story_v_out_426101", "426101033", "story_v_out_426101.awb") / 1000

					if var_150_8 + var_150_0 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_8 + var_150_0
					end

					if var_150_3.prefab_name ~= "" and arg_147_1.actors_[var_150_3.prefab_name] ~= nil then
						local var_150_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_3.prefab_name].transform, "story_v_out_426101", "426101033", "story_v_out_426101.awb")

						arg_147_1:RecordAudio("426101033", var_150_9)
						arg_147_1:RecordAudio("426101033", var_150_9)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_426101", "426101033", "story_v_out_426101.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_426101", "426101033", "story_v_out_426101.awb")
				end

				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_10 = math.max(var_150_1, arg_147_1.talkMaxDuration)

			if var_150_0 <= arg_147_1.time_ and arg_147_1.time_ < var_150_0 + var_150_10 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_0) / var_150_10

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_0 + var_150_10 and arg_147_1.time_ < var_150_0 + var_150_10 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play426101034 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 426101034
		arg_151_1.duration_ = 3.07

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play426101035(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = 0.55

			if var_154_0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_0 + arg_154_0 then
				local var_154_1 = manager.ui.mainCamera.transform.localPosition
				local var_154_2 = Vector3.New(0, 0, 10) + Vector3.New(var_154_1.x, var_154_1.y, 0)
				local var_154_3 = arg_151_1.bgs_.STblack

				var_154_3.transform.localPosition = var_154_2
				var_154_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_154_4 = var_154_3:GetComponent("SpriteRenderer")

				if var_154_4 and var_154_4.sprite then
					local var_154_5 = (var_154_3.transform.localPosition - var_154_1).z
					local var_154_6 = manager.ui.mainCameraCom_
					local var_154_7 = 2 * var_154_5 * Mathf.Tan(var_154_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_154_8 = var_154_7 * var_154_6.aspect
					local var_154_9 = var_154_4.sprite.bounds.size.x
					local var_154_10 = var_154_4.sprite.bounds.size.y
					local var_154_11 = var_154_8 / var_154_9
					local var_154_12 = var_154_7 / var_154_10
					local var_154_13 = var_154_12 < var_154_11 and var_154_11 or var_154_12

					var_154_3.transform.localScale = Vector3.New(var_154_13, var_154_13, 0)
				end

				for iter_154_0, iter_154_1 in pairs(arg_151_1.bgs_) do
					if iter_154_0 ~= "STblack" then
						iter_154_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_154_14 = 0

			if var_154_14 < arg_151_1.time_ and arg_151_1.time_ <= var_154_14 + arg_154_0 then
				arg_151_1.allBtn_.enabled = false
			end

			local var_154_15 = 0.3

			if arg_151_1.time_ >= var_154_14 + var_154_15 and arg_151_1.time_ < var_154_14 + var_154_15 + arg_154_0 then
				arg_151_1.allBtn_.enabled = true
			end

			local var_154_16 = 0.3

			if var_154_16 < arg_151_1.time_ and arg_151_1.time_ <= var_154_16 + arg_154_0 then
				arg_151_1.mask_.enabled = true
				arg_151_1.mask_.raycastTarget = true

				arg_151_1:SetGaussion(false)
			end

			local var_154_17 = 0.125

			if var_154_16 <= arg_151_1.time_ and arg_151_1.time_ < var_154_16 + var_154_17 then
				local var_154_18 = (arg_151_1.time_ - var_154_16) / var_154_17
				local var_154_19 = Color.New(1, 1, 1)

				var_154_19.a = Mathf.Lerp(0, 1, var_154_18)
				arg_151_1.mask_.color = var_154_19
			end

			if arg_151_1.time_ >= var_154_16 + var_154_17 and arg_151_1.time_ < var_154_16 + var_154_17 + arg_154_0 then
				local var_154_20 = Color.New(1, 1, 1)

				var_154_20.a = 1
				arg_151_1.mask_.color = var_154_20
			end

			local var_154_21 = 0.425

			if var_154_21 < arg_151_1.time_ and arg_151_1.time_ <= var_154_21 + arg_154_0 then
				arg_151_1.mask_.enabled = true
				arg_151_1.mask_.raycastTarget = true

				arg_151_1:SetGaussion(false)
			end

			local var_154_22 = 0.125

			if var_154_21 <= arg_151_1.time_ and arg_151_1.time_ < var_154_21 + var_154_22 then
				local var_154_23 = (arg_151_1.time_ - var_154_21) / var_154_22
				local var_154_24 = Color.New(1, 1, 1)

				var_154_24.a = Mathf.Lerp(1, 0, var_154_23)
				arg_151_1.mask_.color = var_154_24
			end

			if arg_151_1.time_ >= var_154_21 + var_154_22 and arg_151_1.time_ < var_154_21 + var_154_22 + arg_154_0 then
				local var_154_25 = Color.New(1, 1, 1)
				local var_154_26 = 0

				arg_151_1.mask_.enabled = false
				var_154_25.a = var_154_26
				arg_151_1.mask_.color = var_154_25
			end

			local var_154_27 = 0.55

			if var_154_27 < arg_151_1.time_ and arg_151_1.time_ <= var_154_27 + arg_154_0 then
				arg_151_1.mask_.enabled = true
				arg_151_1.mask_.raycastTarget = true

				arg_151_1:SetGaussion(false)
			end

			local var_154_28 = 0.125

			if var_154_27 <= arg_151_1.time_ and arg_151_1.time_ < var_154_27 + var_154_28 then
				local var_154_29 = (arg_151_1.time_ - var_154_27) / var_154_28
				local var_154_30 = Color.New(1, 1, 1)

				var_154_30.a = Mathf.Lerp(1, 0, var_154_29)
				arg_151_1.mask_.color = var_154_30
			end

			if arg_151_1.time_ >= var_154_27 + var_154_28 and arg_151_1.time_ < var_154_27 + var_154_28 + arg_154_0 then
				local var_154_31 = Color.New(1, 1, 1)
				local var_154_32 = 0

				arg_151_1.mask_.enabled = false
				var_154_31.a = var_154_32
				arg_151_1.mask_.color = var_154_31
			end

			local var_154_33 = manager.ui.mainCamera.transform
			local var_154_34 = 0.675

			if var_154_34 < arg_151_1.time_ and arg_151_1.time_ <= var_154_34 + arg_154_0 then
				local var_154_35 = arg_151_1.var_.effectfangshipin3

				if var_154_35 then
					Object.Destroy(var_154_35)

					arg_151_1.var_.effectfangshipin3 = nil
				end
			end

			local var_154_36 = manager.ui.mainCamera.transform
			local var_154_37 = 0.675

			if var_154_37 < arg_151_1.time_ and arg_151_1.time_ <= var_154_37 + arg_154_0 then
				local var_154_38 = arg_151_1.var_.effectfangshipin2

				if var_154_38 then
					Object.Destroy(var_154_38)

					arg_151_1.var_.effectfangshipin2 = nil
				end
			end

			local var_154_39 = 0.675
			local var_154_40 = 2.4
			local var_154_41 = manager.audio:GetVoiceLength("story_v_out_426101", "426101034", "story_v_out_426101.awb") / 1000

			if var_154_41 > 0 and var_154_40 < var_154_41 and var_154_41 + var_154_39 > arg_151_1.duration_ then
				local var_154_42 = var_154_41

				arg_151_1.duration_ = var_154_41 + var_154_39
			end

			if var_154_39 < arg_151_1.time_ and arg_151_1.time_ <= var_154_39 + arg_154_0 then
				local var_154_43 = "play"
				local var_154_44 = "voice"

				arg_151_1:AudioAction(var_154_43, var_154_44, "story_v_out_426101", "426101034", "story_v_out_426101.awb")
			end
		end

		arg_151_1.nodeConfigList_ = {
			{
				displayDialog = false,
				enableBgChange = false,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				enableEffect = true,
				contentID = 426101034,
				charCount = 5,
				enableLayoutChange = true,
				duration = 1.48333333333333,
				groupID = "guanliyuanluxinag19",
				startTime = 0.675,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.CREATE_TEXT_GROUP,
				layoutData = {
					topPadding = 0,
					bottomPadding = 0,
					rightPadding = 0,
					leftPadding = 0,
					paragraphSpacing = 0,
					offsetMin = Vector2.New(100, 256),
					offsetMax = Vector2.New(-100, -140),
					paragraphAlignment = UnityEngine.TextAnchor.MiddleLeft
				},
				textComProperty = {
					fontSize = 36,
					fontAssetPath = "Fonts/SourceHanSans",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.UpperCenter
				},
				effectData = {
					startAlpha = 0,
					endAlpha = 1,
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.ALPHA
				}
			}
		}

		arg_151_1:InitPlayNodeList()
	end,
	Play426101035 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 426101035
		arg_155_1.duration_ = 9

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play426101036(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = 2

			if var_158_0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_0 + arg_158_0 then
				local var_158_1 = manager.ui.mainCamera.transform.localPosition
				local var_158_2 = Vector3.New(0, 0, 10) + Vector3.New(var_158_1.x, var_158_1.y, 0)
				local var_158_3 = arg_155_1.bgs_.J27g

				var_158_3.transform.localPosition = var_158_2
				var_158_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_158_4 = var_158_3:GetComponent("SpriteRenderer")

				if var_158_4 and var_158_4.sprite then
					local var_158_5 = (var_158_3.transform.localPosition - var_158_1).z
					local var_158_6 = manager.ui.mainCameraCom_
					local var_158_7 = 2 * var_158_5 * Mathf.Tan(var_158_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_158_8 = var_158_7 * var_158_6.aspect
					local var_158_9 = var_158_4.sprite.bounds.size.x
					local var_158_10 = var_158_4.sprite.bounds.size.y
					local var_158_11 = var_158_8 / var_158_9
					local var_158_12 = var_158_7 / var_158_10
					local var_158_13 = var_158_12 < var_158_11 and var_158_11 or var_158_12

					var_158_3.transform.localScale = Vector3.New(var_158_13, var_158_13, 0)
				end

				for iter_158_0, iter_158_1 in pairs(arg_155_1.bgs_) do
					if iter_158_0 ~= "J27g" then
						iter_158_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_158_14 = 4

			if var_158_14 < arg_155_1.time_ and arg_155_1.time_ <= var_158_14 + arg_158_0 then
				arg_155_1.allBtn_.enabled = false
			end

			local var_158_15 = 0.3

			if arg_155_1.time_ >= var_158_14 + var_158_15 and arg_155_1.time_ < var_158_14 + var_158_15 + arg_158_0 then
				arg_155_1.allBtn_.enabled = true
			end

			local var_158_16 = 0

			if var_158_16 < arg_155_1.time_ and arg_155_1.time_ <= var_158_16 + arg_158_0 then
				arg_155_1.mask_.enabled = true
				arg_155_1.mask_.raycastTarget = true

				arg_155_1:SetGaussion(false)
			end

			local var_158_17 = 2

			if var_158_16 <= arg_155_1.time_ and arg_155_1.time_ < var_158_16 + var_158_17 then
				local var_158_18 = (arg_155_1.time_ - var_158_16) / var_158_17
				local var_158_19 = Color.New(0, 0, 0)

				var_158_19.a = Mathf.Lerp(0, 1, var_158_18)
				arg_155_1.mask_.color = var_158_19
			end

			if arg_155_1.time_ >= var_158_16 + var_158_17 and arg_155_1.time_ < var_158_16 + var_158_17 + arg_158_0 then
				local var_158_20 = Color.New(0, 0, 0)

				var_158_20.a = 1
				arg_155_1.mask_.color = var_158_20
			end

			local var_158_21 = 2

			if var_158_21 < arg_155_1.time_ and arg_155_1.time_ <= var_158_21 + arg_158_0 then
				arg_155_1.mask_.enabled = true
				arg_155_1.mask_.raycastTarget = true

				arg_155_1:SetGaussion(false)
			end

			local var_158_22 = 2

			if var_158_21 <= arg_155_1.time_ and arg_155_1.time_ < var_158_21 + var_158_22 then
				local var_158_23 = (arg_155_1.time_ - var_158_21) / var_158_22
				local var_158_24 = Color.New(0, 0, 0)

				var_158_24.a = Mathf.Lerp(1, 0, var_158_23)
				arg_155_1.mask_.color = var_158_24
			end

			if arg_155_1.time_ >= var_158_21 + var_158_22 and arg_155_1.time_ < var_158_21 + var_158_22 + arg_158_0 then
				local var_158_25 = Color.New(0, 0, 0)
				local var_158_26 = 0

				arg_155_1.mask_.enabled = false
				var_158_25.a = var_158_26
				arg_155_1.mask_.color = var_158_25
			end

			if arg_155_1.frameCnt_ <= 1 then
				arg_155_1.dialog_:SetActive(false)
			end

			local var_158_27 = 4
			local var_158_28 = 0.5

			if var_158_27 < arg_155_1.time_ and arg_155_1.time_ <= var_158_27 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0

				arg_155_1.dialog_:SetActive(true)

				arg_155_1.dialogCg_.alpha = 0

				local var_158_29 = LeanTween.value(arg_155_1.dialog_, 0, 1, 0.3)

				var_158_29:setOnUpdate(LuaHelper.FloatAction(function(arg_159_0)
					arg_155_1.dialogCg_.alpha = arg_159_0
				end))
				var_158_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_155_1.dialog_)
					var_158_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_155_1.duration_ = arg_155_1.duration_ + 0.3

				SetActive(arg_155_1.leftNameGo_, false)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_30 = arg_155_1:GetWordFromCfg(426101035)
				local var_158_31 = arg_155_1:FormatText(var_158_30.content)

				arg_155_1.text_.text = var_158_31

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_32 = 20
				local var_158_33 = utf8.len(var_158_31)
				local var_158_34 = var_158_32 <= 0 and var_158_28 or var_158_28 * (var_158_33 / var_158_32)

				if var_158_34 > 0 and var_158_28 < var_158_34 then
					arg_155_1.talkMaxDuration = var_158_34
					var_158_27 = var_158_27 + 0.3

					if var_158_34 + var_158_27 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_34 + var_158_27
					end
				end

				arg_155_1.text_.text = var_158_31
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)
				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_35 = var_158_27 + 0.3
			local var_158_36 = math.max(var_158_28, arg_155_1.talkMaxDuration)

			if var_158_35 <= arg_155_1.time_ and arg_155_1.time_ < var_158_35 + var_158_36 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_35) / var_158_36

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_35 + var_158_36 and arg_155_1.time_ < var_158_35 + var_158_36 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {
			{
				groupID = "guanliyuanluxinag19",
				duration = 1.48333333333333,
				className = "StoryTextGroupNode",
				startTime = 2,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.DESTROY_ALL_TEXT_GROUP
			}
		}

		arg_155_1:InitPlayNodeList()
	end,
	Play426101036 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 426101036
		arg_161_1.duration_ = 5

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play426101037(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = 0
			local var_164_1 = 0.65

			if var_164_0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_0 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				local var_164_2 = arg_161_1:FormatText(StoryNameCfg[7].name)

				arg_161_1.leftNameTxt_.text = var_164_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, true)
				arg_161_1.iconController_:SetSelectedState("hero")

				arg_161_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_161_1.callingController_:SetSelectedState("normal")

				arg_161_1.keyicon_.color = Color.New(1, 1, 1)
				arg_161_1.icon_.color = Color.New(1, 1, 1)

				local var_164_3 = arg_161_1:GetWordFromCfg(426101036)
				local var_164_4 = arg_161_1:FormatText(var_164_3.content)

				arg_161_1.text_.text = var_164_4

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_5 = 26
				local var_164_6 = utf8.len(var_164_4)
				local var_164_7 = var_164_5 <= 0 and var_164_1 or var_164_1 * (var_164_6 / var_164_5)

				if var_164_7 > 0 and var_164_1 < var_164_7 then
					arg_161_1.talkMaxDuration = var_164_7

					if var_164_7 + var_164_0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_7 + var_164_0
					end
				end

				arg_161_1.text_.text = var_164_4
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)
				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_8 = math.max(var_164_1, arg_161_1.talkMaxDuration)

			if var_164_0 <= arg_161_1.time_ and arg_161_1.time_ < var_164_0 + var_164_8 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_0) / var_164_8

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_0 + var_164_8 and arg_161_1.time_ < var_164_0 + var_164_8 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play426101037 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 426101037
		arg_165_1.duration_ = 5

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play426101038(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = 0
			local var_168_1 = 1.025

			if var_168_0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_0 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				local var_168_2 = arg_165_1:FormatText(StoryNameCfg[7].name)

				arg_165_1.leftNameTxt_.text = var_168_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, true)
				arg_165_1.iconController_:SetSelectedState("hero")

				arg_165_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_165_1.callingController_:SetSelectedState("normal")

				arg_165_1.keyicon_.color = Color.New(1, 1, 1)
				arg_165_1.icon_.color = Color.New(1, 1, 1)

				local var_168_3 = arg_165_1:GetWordFromCfg(426101037)
				local var_168_4 = arg_165_1:FormatText(var_168_3.content)

				arg_165_1.text_.text = var_168_4

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_5 = 41
				local var_168_6 = utf8.len(var_168_4)
				local var_168_7 = var_168_5 <= 0 and var_168_1 or var_168_1 * (var_168_6 / var_168_5)

				if var_168_7 > 0 and var_168_1 < var_168_7 then
					arg_165_1.talkMaxDuration = var_168_7

					if var_168_7 + var_168_0 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_7 + var_168_0
					end
				end

				arg_165_1.text_.text = var_168_4
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)
				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_8 = math.max(var_168_1, arg_165_1.talkMaxDuration)

			if var_168_0 <= arg_165_1.time_ and arg_165_1.time_ < var_168_0 + var_168_8 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_0) / var_168_8

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_0 + var_168_8 and arg_165_1.time_ < var_168_0 + var_168_8 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play426101038 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 426101038
		arg_169_1.duration_ = 5

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play426101039(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = 0
			local var_172_1 = 1.05

			if var_172_0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_0 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				local var_172_2 = arg_169_1:FormatText(StoryNameCfg[7].name)

				arg_169_1.leftNameTxt_.text = var_172_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, true)
				arg_169_1.iconController_:SetSelectedState("hero")

				arg_169_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_169_1.callingController_:SetSelectedState("normal")

				arg_169_1.keyicon_.color = Color.New(1, 1, 1)
				arg_169_1.icon_.color = Color.New(1, 1, 1)

				local var_172_3 = arg_169_1:GetWordFromCfg(426101038)
				local var_172_4 = arg_169_1:FormatText(var_172_3.content)

				arg_169_1.text_.text = var_172_4

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_5 = 42
				local var_172_6 = utf8.len(var_172_4)
				local var_172_7 = var_172_5 <= 0 and var_172_1 or var_172_1 * (var_172_6 / var_172_5)

				if var_172_7 > 0 and var_172_1 < var_172_7 then
					arg_169_1.talkMaxDuration = var_172_7

					if var_172_7 + var_172_0 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_7 + var_172_0
					end
				end

				arg_169_1.text_.text = var_172_4
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)
				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_8 = math.max(var_172_1, arg_169_1.talkMaxDuration)

			if var_172_0 <= arg_169_1.time_ and arg_169_1.time_ < var_172_0 + var_172_8 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_0) / var_172_8

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_0 + var_172_8 and arg_169_1.time_ < var_172_0 + var_172_8 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play426101039 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 426101039
		arg_173_1.duration_ = 5

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play426101040(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = 0
			local var_176_1 = 1.1

			if var_176_0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_0 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				local var_176_2 = arg_173_1:FormatText(StoryNameCfg[7].name)

				arg_173_1.leftNameTxt_.text = var_176_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, true)
				arg_173_1.iconController_:SetSelectedState("hero")

				arg_173_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_173_1.callingController_:SetSelectedState("normal")

				arg_173_1.keyicon_.color = Color.New(1, 1, 1)
				arg_173_1.icon_.color = Color.New(1, 1, 1)

				local var_176_3 = arg_173_1:GetWordFromCfg(426101039)
				local var_176_4 = arg_173_1:FormatText(var_176_3.content)

				arg_173_1.text_.text = var_176_4

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_5 = 44
				local var_176_6 = utf8.len(var_176_4)
				local var_176_7 = var_176_5 <= 0 and var_176_1 or var_176_1 * (var_176_6 / var_176_5)

				if var_176_7 > 0 and var_176_1 < var_176_7 then
					arg_173_1.talkMaxDuration = var_176_7

					if var_176_7 + var_176_0 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_7 + var_176_0
					end
				end

				arg_173_1.text_.text = var_176_4
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)
				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_8 = math.max(var_176_1, arg_173_1.talkMaxDuration)

			if var_176_0 <= arg_173_1.time_ and arg_173_1.time_ < var_176_0 + var_176_8 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_0) / var_176_8

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_0 + var_176_8 and arg_173_1.time_ < var_176_0 + var_176_8 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play426101040 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 426101040
		arg_177_1.duration_ = 5

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play426101041(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = 0
			local var_180_1 = 1.1

			if var_180_0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_0 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, false)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_2 = arg_177_1:GetWordFromCfg(426101040)
				local var_180_3 = arg_177_1:FormatText(var_180_2.content)

				arg_177_1.text_.text = var_180_3

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_4 = 44
				local var_180_5 = utf8.len(var_180_3)
				local var_180_6 = var_180_4 <= 0 and var_180_1 or var_180_1 * (var_180_5 / var_180_4)

				if var_180_6 > 0 and var_180_1 < var_180_6 then
					arg_177_1.talkMaxDuration = var_180_6

					if var_180_6 + var_180_0 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_6 + var_180_0
					end
				end

				arg_177_1.text_.text = var_180_3
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)
				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_7 = math.max(var_180_1, arg_177_1.talkMaxDuration)

			if var_180_0 <= arg_177_1.time_ and arg_177_1.time_ < var_180_0 + var_180_7 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_0) / var_180_7

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_0 + var_180_7 and arg_177_1.time_ < var_180_0 + var_180_7 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {}

		arg_177_1:InitPlayNodeList()
	end,
	Play426101041 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 426101041
		arg_181_1.duration_ = 5

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play426101042(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = 0
			local var_184_1 = 0.075

			if var_184_0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_0 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				local var_184_2 = arg_181_1:FormatText(StoryNameCfg[7].name)

				arg_181_1.leftNameTxt_.text = var_184_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, true)
				arg_181_1.iconController_:SetSelectedState("hero")

				arg_181_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_181_1.callingController_:SetSelectedState("normal")

				arg_181_1.keyicon_.color = Color.New(1, 1, 1)
				arg_181_1.icon_.color = Color.New(1, 1, 1)

				local var_184_3 = arg_181_1:GetWordFromCfg(426101041)
				local var_184_4 = arg_181_1:FormatText(var_184_3.content)

				arg_181_1.text_.text = var_184_4

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_5 = 3
				local var_184_6 = utf8.len(var_184_4)
				local var_184_7 = var_184_5 <= 0 and var_184_1 or var_184_1 * (var_184_6 / var_184_5)

				if var_184_7 > 0 and var_184_1 < var_184_7 then
					arg_181_1.talkMaxDuration = var_184_7

					if var_184_7 + var_184_0 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_7 + var_184_0
					end
				end

				arg_181_1.text_.text = var_184_4
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)
				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_8 = math.max(var_184_1, arg_181_1.talkMaxDuration)

			if var_184_0 <= arg_181_1.time_ and arg_181_1.time_ < var_184_0 + var_184_8 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_0) / var_184_8

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_0 + var_184_8 and arg_181_1.time_ < var_184_0 + var_184_8 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play426101042 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 426101042
		arg_185_1.duration_ = 7.3

		local var_185_0 = {
			zh = 4.066,
			ja = 7.3
		}
		local var_185_1 = manager.audio:GetLocalizationFlag()

		if var_185_0[var_185_1] ~= nil then
			arg_185_1.duration_ = var_185_0[var_185_1]
		end

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play426101043(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = 0
			local var_188_1 = 0.4

			if var_188_0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_0 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				local var_188_2 = arg_185_1:FormatText(StoryNameCfg[1487].name)

				arg_185_1.leftNameTxt_.text = var_188_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, true)
				arg_185_1.iconController_:SetSelectedState("hero")

				arg_185_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_185_1.callingController_:SetSelectedState("normal")

				arg_185_1.keyicon_.color = Color.New(1, 1, 1)
				arg_185_1.icon_.color = Color.New(1, 1, 1)

				local var_188_3 = arg_185_1:GetWordFromCfg(426101042)
				local var_188_4 = arg_185_1:FormatText(var_188_3.content)

				arg_185_1.text_.text = var_188_4

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_5 = 16
				local var_188_6 = utf8.len(var_188_4)
				local var_188_7 = var_188_5 <= 0 and var_188_1 or var_188_1 * (var_188_6 / var_188_5)

				if var_188_7 > 0 and var_188_1 < var_188_7 then
					arg_185_1.talkMaxDuration = var_188_7

					if var_188_7 + var_188_0 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_7 + var_188_0
					end
				end

				arg_185_1.text_.text = var_188_4
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426101", "426101042", "story_v_out_426101.awb") ~= 0 then
					local var_188_8 = manager.audio:GetVoiceLength("story_v_out_426101", "426101042", "story_v_out_426101.awb") / 1000

					if var_188_8 + var_188_0 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_8 + var_188_0
					end

					if var_188_3.prefab_name ~= "" and arg_185_1.actors_[var_188_3.prefab_name] ~= nil then
						local var_188_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_3.prefab_name].transform, "story_v_out_426101", "426101042", "story_v_out_426101.awb")

						arg_185_1:RecordAudio("426101042", var_188_9)
						arg_185_1:RecordAudio("426101042", var_188_9)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_426101", "426101042", "story_v_out_426101.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_426101", "426101042", "story_v_out_426101.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_10 = math.max(var_188_1, arg_185_1.talkMaxDuration)

			if var_188_0 <= arg_185_1.time_ and arg_185_1.time_ < var_188_0 + var_188_10 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_0) / var_188_10

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_0 + var_188_10 and arg_185_1.time_ < var_188_0 + var_188_10 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play426101043 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 426101043
		arg_189_1.duration_ = 7.97

		local var_189_0 = {
			zh = 6.466,
			ja = 7.966
		}
		local var_189_1 = manager.audio:GetLocalizationFlag()

		if var_189_0[var_189_1] ~= nil then
			arg_189_1.duration_ = var_189_0[var_189_1]
		end

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play426101044(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = 0
			local var_192_1 = 0.575

			if var_192_0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_0 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				local var_192_2 = arg_189_1:FormatText(StoryNameCfg[1487].name)

				arg_189_1.leftNameTxt_.text = var_192_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, true)
				arg_189_1.iconController_:SetSelectedState("hero")

				arg_189_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_189_1.callingController_:SetSelectedState("normal")

				arg_189_1.keyicon_.color = Color.New(1, 1, 1)
				arg_189_1.icon_.color = Color.New(1, 1, 1)

				local var_192_3 = arg_189_1:GetWordFromCfg(426101043)
				local var_192_4 = arg_189_1:FormatText(var_192_3.content)

				arg_189_1.text_.text = var_192_4

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_5 = 23
				local var_192_6 = utf8.len(var_192_4)
				local var_192_7 = var_192_5 <= 0 and var_192_1 or var_192_1 * (var_192_6 / var_192_5)

				if var_192_7 > 0 and var_192_1 < var_192_7 then
					arg_189_1.talkMaxDuration = var_192_7

					if var_192_7 + var_192_0 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_7 + var_192_0
					end
				end

				arg_189_1.text_.text = var_192_4
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426101", "426101043", "story_v_out_426101.awb") ~= 0 then
					local var_192_8 = manager.audio:GetVoiceLength("story_v_out_426101", "426101043", "story_v_out_426101.awb") / 1000

					if var_192_8 + var_192_0 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_8 + var_192_0
					end

					if var_192_3.prefab_name ~= "" and arg_189_1.actors_[var_192_3.prefab_name] ~= nil then
						local var_192_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_3.prefab_name].transform, "story_v_out_426101", "426101043", "story_v_out_426101.awb")

						arg_189_1:RecordAudio("426101043", var_192_9)
						arg_189_1:RecordAudio("426101043", var_192_9)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_426101", "426101043", "story_v_out_426101.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_426101", "426101043", "story_v_out_426101.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_10 = math.max(var_192_1, arg_189_1.talkMaxDuration)

			if var_192_0 <= arg_189_1.time_ and arg_189_1.time_ < var_192_0 + var_192_10 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_0) / var_192_10

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_0 + var_192_10 and arg_189_1.time_ < var_192_0 + var_192_10 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {}

		arg_189_1:InitPlayNodeList()
	end,
	Play426101044 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 426101044
		arg_193_1.duration_ = 5

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play426101045(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = "1054ui_story"

			if arg_193_1.actors_[var_196_0] == nil then
				local var_196_1 = Asset.Load("Char/" .. "1054ui_story")

				if not isNil(var_196_1) then
					local var_196_2 = Object.Instantiate(Asset.Load("Char/" .. "1054ui_story"), arg_193_1.stage_.transform)

					var_196_2.name = var_196_0
					var_196_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_193_1.actors_[var_196_0] = var_196_2

					local var_196_3 = var_196_2:GetComponentInChildren(typeof(CharacterEffect))

					var_196_3.enabled = true

					local var_196_4 = GameObjectTools.GetOrAddComponent(var_196_2, typeof(DynamicBoneHelper))

					if var_196_4 then
						var_196_4:EnableDynamicBone(false)
					end

					arg_193_1:ShowWeapon(var_196_3.transform, false)

					arg_193_1.var_[var_196_0 .. "Animator"] = var_196_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_193_1.var_[var_196_0 .. "Animator"].applyRootMotion = true
					arg_193_1.var_[var_196_0 .. "LipSync"] = var_196_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_196_5 = arg_193_1.actors_["1054ui_story"]
			local var_196_6 = 0

			if var_196_6 < arg_193_1.time_ and arg_193_1.time_ <= var_196_6 + arg_196_0 and not isNil(var_196_5) and arg_193_1.var_.characterEffect1054ui_story == nil then
				arg_193_1.var_.characterEffect1054ui_story = var_196_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_196_7 = 0.200000002980232

			if var_196_6 <= arg_193_1.time_ and arg_193_1.time_ < var_196_6 + var_196_7 and not isNil(var_196_5) then
				local var_196_8 = (arg_193_1.time_ - var_196_6) / var_196_7

				if arg_193_1.var_.characterEffect1054ui_story and not isNil(var_196_5) then
					local var_196_9 = Mathf.Lerp(0, 0.5, var_196_8)

					arg_193_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_193_1.var_.characterEffect1054ui_story.fillRatio = var_196_9
				end
			end

			if arg_193_1.time_ >= var_196_6 + var_196_7 and arg_193_1.time_ < var_196_6 + var_196_7 + arg_196_0 and not isNil(var_196_5) and arg_193_1.var_.characterEffect1054ui_story then
				local var_196_10 = 0.5

				arg_193_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_193_1.var_.characterEffect1054ui_story.fillRatio = var_196_10
			end

			local var_196_11 = 0
			local var_196_12 = 0.575

			if var_196_11 < arg_193_1.time_ and arg_193_1.time_ <= var_196_11 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				local var_196_13 = arg_193_1:FormatText(StoryNameCfg[7].name)

				arg_193_1.leftNameTxt_.text = var_196_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, true)
				arg_193_1.iconController_:SetSelectedState("hero")

				arg_193_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_193_1.callingController_:SetSelectedState("normal")

				arg_193_1.keyicon_.color = Color.New(1, 1, 1)
				arg_193_1.icon_.color = Color.New(1, 1, 1)

				local var_196_14 = arg_193_1:GetWordFromCfg(426101044)
				local var_196_15 = arg_193_1:FormatText(var_196_14.content)

				arg_193_1.text_.text = var_196_15

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_16 = 23
				local var_196_17 = utf8.len(var_196_15)
				local var_196_18 = var_196_16 <= 0 and var_196_12 or var_196_12 * (var_196_17 / var_196_16)

				if var_196_18 > 0 and var_196_12 < var_196_18 then
					arg_193_1.talkMaxDuration = var_196_18

					if var_196_18 + var_196_11 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_18 + var_196_11
					end
				end

				arg_193_1.text_.text = var_196_15
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)
				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_19 = math.max(var_196_12, arg_193_1.talkMaxDuration)

			if var_196_11 <= arg_193_1.time_ and arg_193_1.time_ < var_196_11 + var_196_19 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_11) / var_196_19

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_11 + var_196_19 and arg_193_1.time_ < var_196_11 + var_196_19 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {}

		arg_193_1:InitPlayNodeList()
	end,
	Play426101045 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 426101045
		arg_197_1.duration_ = 5.87

		local var_197_0 = {
			zh = 4.966,
			ja = 5.866
		}
		local var_197_1 = manager.audio:GetLocalizationFlag()

		if var_197_0[var_197_1] ~= nil then
			arg_197_1.duration_ = var_197_0[var_197_1]
		end

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play426101046(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = 0
			local var_200_1 = 0.425

			if var_200_0 < arg_197_1.time_ and arg_197_1.time_ <= var_200_0 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				local var_200_2 = arg_197_1:FormatText(StoryNameCfg[1487].name)

				arg_197_1.leftNameTxt_.text = var_200_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, true)
				arg_197_1.iconController_:SetSelectedState("hero")

				arg_197_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_197_1.callingController_:SetSelectedState("normal")

				arg_197_1.keyicon_.color = Color.New(1, 1, 1)
				arg_197_1.icon_.color = Color.New(1, 1, 1)

				local var_200_3 = arg_197_1:GetWordFromCfg(426101045)
				local var_200_4 = arg_197_1:FormatText(var_200_3.content)

				arg_197_1.text_.text = var_200_4

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_5 = 17
				local var_200_6 = utf8.len(var_200_4)
				local var_200_7 = var_200_5 <= 0 and var_200_1 or var_200_1 * (var_200_6 / var_200_5)

				if var_200_7 > 0 and var_200_1 < var_200_7 then
					arg_197_1.talkMaxDuration = var_200_7

					if var_200_7 + var_200_0 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_7 + var_200_0
					end
				end

				arg_197_1.text_.text = var_200_4
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426101", "426101045", "story_v_out_426101.awb") ~= 0 then
					local var_200_8 = manager.audio:GetVoiceLength("story_v_out_426101", "426101045", "story_v_out_426101.awb") / 1000

					if var_200_8 + var_200_0 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_8 + var_200_0
					end

					if var_200_3.prefab_name ~= "" and arg_197_1.actors_[var_200_3.prefab_name] ~= nil then
						local var_200_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_3.prefab_name].transform, "story_v_out_426101", "426101045", "story_v_out_426101.awb")

						arg_197_1:RecordAudio("426101045", var_200_9)
						arg_197_1:RecordAudio("426101045", var_200_9)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_out_426101", "426101045", "story_v_out_426101.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_out_426101", "426101045", "story_v_out_426101.awb")
				end

				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_10 = math.max(var_200_1, arg_197_1.talkMaxDuration)

			if var_200_0 <= arg_197_1.time_ and arg_197_1.time_ < var_200_0 + var_200_10 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_0) / var_200_10

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_0 + var_200_10 and arg_197_1.time_ < var_200_0 + var_200_10 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {}

		arg_197_1:InitPlayNodeList()
	end,
	Play426101046 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 426101046
		arg_201_1.duration_ = 5

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play426101047(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = arg_201_1.actors_["1054ui_story"]
			local var_204_1 = 0

			if var_204_1 < arg_201_1.time_ and arg_201_1.time_ <= var_204_1 + arg_204_0 and not isNil(var_204_0) and arg_201_1.var_.characterEffect1054ui_story == nil then
				arg_201_1.var_.characterEffect1054ui_story = var_204_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_204_2 = 0.200000002980232

			if var_204_1 <= arg_201_1.time_ and arg_201_1.time_ < var_204_1 + var_204_2 and not isNil(var_204_0) then
				local var_204_3 = (arg_201_1.time_ - var_204_1) / var_204_2

				if arg_201_1.var_.characterEffect1054ui_story and not isNil(var_204_0) then
					local var_204_4 = Mathf.Lerp(0, 0.5, var_204_3)

					arg_201_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_201_1.var_.characterEffect1054ui_story.fillRatio = var_204_4
				end
			end

			if arg_201_1.time_ >= var_204_1 + var_204_2 and arg_201_1.time_ < var_204_1 + var_204_2 + arg_204_0 and not isNil(var_204_0) and arg_201_1.var_.characterEffect1054ui_story then
				local var_204_5 = 0.5

				arg_201_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_201_1.var_.characterEffect1054ui_story.fillRatio = var_204_5
			end

			local var_204_6 = 0
			local var_204_7 = 0.6

			if var_204_6 < arg_201_1.time_ and arg_201_1.time_ <= var_204_6 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				local var_204_8 = arg_201_1:FormatText(StoryNameCfg[7].name)

				arg_201_1.leftNameTxt_.text = var_204_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, true)
				arg_201_1.iconController_:SetSelectedState("hero")

				arg_201_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_201_1.callingController_:SetSelectedState("normal")

				arg_201_1.keyicon_.color = Color.New(1, 1, 1)
				arg_201_1.icon_.color = Color.New(1, 1, 1)

				local var_204_9 = arg_201_1:GetWordFromCfg(426101046)
				local var_204_10 = arg_201_1:FormatText(var_204_9.content)

				arg_201_1.text_.text = var_204_10

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_11 = 24
				local var_204_12 = utf8.len(var_204_10)
				local var_204_13 = var_204_11 <= 0 and var_204_7 or var_204_7 * (var_204_12 / var_204_11)

				if var_204_13 > 0 and var_204_7 < var_204_13 then
					arg_201_1.talkMaxDuration = var_204_13

					if var_204_13 + var_204_6 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_13 + var_204_6
					end
				end

				arg_201_1.text_.text = var_204_10
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)
				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_14 = math.max(var_204_7, arg_201_1.talkMaxDuration)

			if var_204_6 <= arg_201_1.time_ and arg_201_1.time_ < var_204_6 + var_204_14 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_6) / var_204_14

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_6 + var_204_14 and arg_201_1.time_ < var_204_6 + var_204_14 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {}

		arg_201_1:InitPlayNodeList()
	end,
	Play426101047 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 426101047
		arg_205_1.duration_ = 5

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play426101048(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = 0
			local var_208_1 = 0.9

			if var_208_0 < arg_205_1.time_ and arg_205_1.time_ <= var_208_0 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				local var_208_2 = arg_205_1:FormatText(StoryNameCfg[7].name)

				arg_205_1.leftNameTxt_.text = var_208_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, true)
				arg_205_1.iconController_:SetSelectedState("hero")

				arg_205_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_205_1.callingController_:SetSelectedState("normal")

				arg_205_1.keyicon_.color = Color.New(1, 1, 1)
				arg_205_1.icon_.color = Color.New(1, 1, 1)

				local var_208_3 = arg_205_1:GetWordFromCfg(426101047)
				local var_208_4 = arg_205_1:FormatText(var_208_3.content)

				arg_205_1.text_.text = var_208_4

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_5 = 36
				local var_208_6 = utf8.len(var_208_4)
				local var_208_7 = var_208_5 <= 0 and var_208_1 or var_208_1 * (var_208_6 / var_208_5)

				if var_208_7 > 0 and var_208_1 < var_208_7 then
					arg_205_1.talkMaxDuration = var_208_7

					if var_208_7 + var_208_0 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_7 + var_208_0
					end
				end

				arg_205_1.text_.text = var_208_4
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)
				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_8 = math.max(var_208_1, arg_205_1.talkMaxDuration)

			if var_208_0 <= arg_205_1.time_ and arg_205_1.time_ < var_208_0 + var_208_8 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_0) / var_208_8

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_0 + var_208_8 and arg_205_1.time_ < var_208_0 + var_208_8 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {}

		arg_205_1:InitPlayNodeList()
	end,
	Play426101048 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 426101048
		arg_209_1.duration_ = 5

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play426101049(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = 0
			local var_212_1 = 0.775

			if var_212_0 < arg_209_1.time_ and arg_209_1.time_ <= var_212_0 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				local var_212_2 = arg_209_1:FormatText(StoryNameCfg[7].name)

				arg_209_1.leftNameTxt_.text = var_212_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, true)
				arg_209_1.iconController_:SetSelectedState("hero")

				arg_209_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_209_1.callingController_:SetSelectedState("normal")

				arg_209_1.keyicon_.color = Color.New(1, 1, 1)
				arg_209_1.icon_.color = Color.New(1, 1, 1)

				local var_212_3 = arg_209_1:GetWordFromCfg(426101048)
				local var_212_4 = arg_209_1:FormatText(var_212_3.content)

				arg_209_1.text_.text = var_212_4

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_5 = 31
				local var_212_6 = utf8.len(var_212_4)
				local var_212_7 = var_212_5 <= 0 and var_212_1 or var_212_1 * (var_212_6 / var_212_5)

				if var_212_7 > 0 and var_212_1 < var_212_7 then
					arg_209_1.talkMaxDuration = var_212_7

					if var_212_7 + var_212_0 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_7 + var_212_0
					end
				end

				arg_209_1.text_.text = var_212_4
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)
				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_8 = math.max(var_212_1, arg_209_1.talkMaxDuration)

			if var_212_0 <= arg_209_1.time_ and arg_209_1.time_ < var_212_0 + var_212_8 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_0) / var_212_8

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_0 + var_212_8 and arg_209_1.time_ < var_212_0 + var_212_8 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {}

		arg_209_1:InitPlayNodeList()
	end,
	Play426101049 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 426101049
		arg_213_1.duration_ = 5.17

		local var_213_0 = {
			zh = 4.1,
			ja = 5.166
		}
		local var_213_1 = manager.audio:GetLocalizationFlag()

		if var_213_0[var_213_1] ~= nil then
			arg_213_1.duration_ = var_213_0[var_213_1]
		end

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play426101050(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = 0
			local var_216_1 = 0.375

			if var_216_0 < arg_213_1.time_ and arg_213_1.time_ <= var_216_0 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				local var_216_2 = arg_213_1:FormatText(StoryNameCfg[1487].name)

				arg_213_1.leftNameTxt_.text = var_216_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, true)
				arg_213_1.iconController_:SetSelectedState("hero")

				arg_213_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_213_1.callingController_:SetSelectedState("normal")

				arg_213_1.keyicon_.color = Color.New(1, 1, 1)
				arg_213_1.icon_.color = Color.New(1, 1, 1)

				local var_216_3 = arg_213_1:GetWordFromCfg(426101049)
				local var_216_4 = arg_213_1:FormatText(var_216_3.content)

				arg_213_1.text_.text = var_216_4

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_5 = 15
				local var_216_6 = utf8.len(var_216_4)
				local var_216_7 = var_216_5 <= 0 and var_216_1 or var_216_1 * (var_216_6 / var_216_5)

				if var_216_7 > 0 and var_216_1 < var_216_7 then
					arg_213_1.talkMaxDuration = var_216_7

					if var_216_7 + var_216_0 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_7 + var_216_0
					end
				end

				arg_213_1.text_.text = var_216_4
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426101", "426101049", "story_v_out_426101.awb") ~= 0 then
					local var_216_8 = manager.audio:GetVoiceLength("story_v_out_426101", "426101049", "story_v_out_426101.awb") / 1000

					if var_216_8 + var_216_0 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_8 + var_216_0
					end

					if var_216_3.prefab_name ~= "" and arg_213_1.actors_[var_216_3.prefab_name] ~= nil then
						local var_216_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_3.prefab_name].transform, "story_v_out_426101", "426101049", "story_v_out_426101.awb")

						arg_213_1:RecordAudio("426101049", var_216_9)
						arg_213_1:RecordAudio("426101049", var_216_9)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_out_426101", "426101049", "story_v_out_426101.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_out_426101", "426101049", "story_v_out_426101.awb")
				end

				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_10 = math.max(var_216_1, arg_213_1.talkMaxDuration)

			if var_216_0 <= arg_213_1.time_ and arg_213_1.time_ < var_216_0 + var_216_10 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_0) / var_216_10

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_0 + var_216_10 and arg_213_1.time_ < var_216_0 + var_216_10 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {}

		arg_213_1:InitPlayNodeList()
	end,
	Play426101050 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 426101050
		arg_217_1.duration_ = 5

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play426101051(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = arg_217_1.actors_["1054ui_story"]
			local var_220_1 = 0

			if var_220_1 < arg_217_1.time_ and arg_217_1.time_ <= var_220_1 + arg_220_0 and not isNil(var_220_0) and arg_217_1.var_.characterEffect1054ui_story == nil then
				arg_217_1.var_.characterEffect1054ui_story = var_220_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_220_2 = 0.200000002980232

			if var_220_1 <= arg_217_1.time_ and arg_217_1.time_ < var_220_1 + var_220_2 and not isNil(var_220_0) then
				local var_220_3 = (arg_217_1.time_ - var_220_1) / var_220_2

				if arg_217_1.var_.characterEffect1054ui_story and not isNil(var_220_0) then
					local var_220_4 = Mathf.Lerp(0, 0.5, var_220_3)

					arg_217_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_217_1.var_.characterEffect1054ui_story.fillRatio = var_220_4
				end
			end

			if arg_217_1.time_ >= var_220_1 + var_220_2 and arg_217_1.time_ < var_220_1 + var_220_2 + arg_220_0 and not isNil(var_220_0) and arg_217_1.var_.characterEffect1054ui_story then
				local var_220_5 = 0.5

				arg_217_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_217_1.var_.characterEffect1054ui_story.fillRatio = var_220_5
			end

			local var_220_6 = 0
			local var_220_7 = 0.75

			if var_220_6 < arg_217_1.time_ and arg_217_1.time_ <= var_220_6 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				local var_220_8 = arg_217_1:FormatText(StoryNameCfg[7].name)

				arg_217_1.leftNameTxt_.text = var_220_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, true)
				arg_217_1.iconController_:SetSelectedState("hero")

				arg_217_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_217_1.callingController_:SetSelectedState("normal")

				arg_217_1.keyicon_.color = Color.New(1, 1, 1)
				arg_217_1.icon_.color = Color.New(1, 1, 1)

				local var_220_9 = arg_217_1:GetWordFromCfg(426101050)
				local var_220_10 = arg_217_1:FormatText(var_220_9.content)

				arg_217_1.text_.text = var_220_10

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_11 = 30
				local var_220_12 = utf8.len(var_220_10)
				local var_220_13 = var_220_11 <= 0 and var_220_7 or var_220_7 * (var_220_12 / var_220_11)

				if var_220_13 > 0 and var_220_7 < var_220_13 then
					arg_217_1.talkMaxDuration = var_220_13

					if var_220_13 + var_220_6 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_13 + var_220_6
					end
				end

				arg_217_1.text_.text = var_220_10
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)
				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_14 = math.max(var_220_7, arg_217_1.talkMaxDuration)

			if var_220_6 <= arg_217_1.time_ and arg_217_1.time_ < var_220_6 + var_220_14 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_6) / var_220_14

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_6 + var_220_14 and arg_217_1.time_ < var_220_6 + var_220_14 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {}

		arg_217_1:InitPlayNodeList()
	end,
	Play426101051 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 426101051
		arg_221_1.duration_ = 5

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play426101052(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			local var_224_0 = 0
			local var_224_1 = 0.875

			if var_224_0 < arg_221_1.time_ and arg_221_1.time_ <= var_224_0 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				local var_224_2 = arg_221_1:FormatText(StoryNameCfg[7].name)

				arg_221_1.leftNameTxt_.text = var_224_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, true)
				arg_221_1.iconController_:SetSelectedState("hero")

				arg_221_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_221_1.callingController_:SetSelectedState("normal")

				arg_221_1.keyicon_.color = Color.New(1, 1, 1)
				arg_221_1.icon_.color = Color.New(1, 1, 1)

				local var_224_3 = arg_221_1:GetWordFromCfg(426101051)
				local var_224_4 = arg_221_1:FormatText(var_224_3.content)

				arg_221_1.text_.text = var_224_4

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_5 = 35
				local var_224_6 = utf8.len(var_224_4)
				local var_224_7 = var_224_5 <= 0 and var_224_1 or var_224_1 * (var_224_6 / var_224_5)

				if var_224_7 > 0 and var_224_1 < var_224_7 then
					arg_221_1.talkMaxDuration = var_224_7

					if var_224_7 + var_224_0 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_7 + var_224_0
					end
				end

				arg_221_1.text_.text = var_224_4
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)
				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_8 = math.max(var_224_1, arg_221_1.talkMaxDuration)

			if var_224_0 <= arg_221_1.time_ and arg_221_1.time_ < var_224_0 + var_224_8 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_0) / var_224_8

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_0 + var_224_8 and arg_221_1.time_ < var_224_0 + var_224_8 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {}

		arg_221_1:InitPlayNodeList()
	end,
	Play426101052 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 426101052
		arg_225_1.duration_ = 10.93

		local var_225_0 = {
			zh = 7.733,
			ja = 10.933
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
				arg_225_0:Play426101053(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = 0
			local var_228_1 = 0.675

			if var_228_0 < arg_225_1.time_ and arg_225_1.time_ <= var_228_0 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				local var_228_2 = arg_225_1:FormatText(StoryNameCfg[1487].name)

				arg_225_1.leftNameTxt_.text = var_228_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, true)
				arg_225_1.iconController_:SetSelectedState("hero")

				arg_225_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_225_1.callingController_:SetSelectedState("normal")

				arg_225_1.keyicon_.color = Color.New(1, 1, 1)
				arg_225_1.icon_.color = Color.New(1, 1, 1)

				local var_228_3 = arg_225_1:GetWordFromCfg(426101052)
				local var_228_4 = arg_225_1:FormatText(var_228_3.content)

				arg_225_1.text_.text = var_228_4

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_5 = 27
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

				if manager.audio:GetVoiceLength("story_v_out_426101", "426101052", "story_v_out_426101.awb") ~= 0 then
					local var_228_8 = manager.audio:GetVoiceLength("story_v_out_426101", "426101052", "story_v_out_426101.awb") / 1000

					if var_228_8 + var_228_0 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_8 + var_228_0
					end

					if var_228_3.prefab_name ~= "" and arg_225_1.actors_[var_228_3.prefab_name] ~= nil then
						local var_228_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_225_1.actors_[var_228_3.prefab_name].transform, "story_v_out_426101", "426101052", "story_v_out_426101.awb")

						arg_225_1:RecordAudio("426101052", var_228_9)
						arg_225_1:RecordAudio("426101052", var_228_9)
					else
						arg_225_1:AudioAction("play", "voice", "story_v_out_426101", "426101052", "story_v_out_426101.awb")
					end

					arg_225_1:RecordHistoryTalkVoice("story_v_out_426101", "426101052", "story_v_out_426101.awb")
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
	Play426101053 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 426101053
		arg_229_1.duration_ = 5

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play426101054(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = arg_229_1.actors_["1054ui_story"]
			local var_232_1 = 0

			if var_232_1 < arg_229_1.time_ and arg_229_1.time_ <= var_232_1 + arg_232_0 and not isNil(var_232_0) and arg_229_1.var_.characterEffect1054ui_story == nil then
				arg_229_1.var_.characterEffect1054ui_story = var_232_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_232_2 = 0.200000002980232

			if var_232_1 <= arg_229_1.time_ and arg_229_1.time_ < var_232_1 + var_232_2 and not isNil(var_232_0) then
				local var_232_3 = (arg_229_1.time_ - var_232_1) / var_232_2

				if arg_229_1.var_.characterEffect1054ui_story and not isNil(var_232_0) then
					local var_232_4 = Mathf.Lerp(0, 0.5, var_232_3)

					arg_229_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_229_1.var_.characterEffect1054ui_story.fillRatio = var_232_4
				end
			end

			if arg_229_1.time_ >= var_232_1 + var_232_2 and arg_229_1.time_ < var_232_1 + var_232_2 + arg_232_0 and not isNil(var_232_0) and arg_229_1.var_.characterEffect1054ui_story then
				local var_232_5 = 0.5

				arg_229_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_229_1.var_.characterEffect1054ui_story.fillRatio = var_232_5
			end

			local var_232_6 = 0
			local var_232_7 = 0.5

			if var_232_6 < arg_229_1.time_ and arg_229_1.time_ <= var_232_6 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				local var_232_8 = arg_229_1:FormatText(StoryNameCfg[7].name)

				arg_229_1.leftNameTxt_.text = var_232_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, true)
				arg_229_1.iconController_:SetSelectedState("hero")

				arg_229_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_229_1.callingController_:SetSelectedState("normal")

				arg_229_1.keyicon_.color = Color.New(1, 1, 1)
				arg_229_1.icon_.color = Color.New(1, 1, 1)

				local var_232_9 = arg_229_1:GetWordFromCfg(426101053)
				local var_232_10 = arg_229_1:FormatText(var_232_9.content)

				arg_229_1.text_.text = var_232_10

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_11 = 20
				local var_232_12 = utf8.len(var_232_10)
				local var_232_13 = var_232_11 <= 0 and var_232_7 or var_232_7 * (var_232_12 / var_232_11)

				if var_232_13 > 0 and var_232_7 < var_232_13 then
					arg_229_1.talkMaxDuration = var_232_13

					if var_232_13 + var_232_6 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_13 + var_232_6
					end
				end

				arg_229_1.text_.text = var_232_10
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)
				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_14 = math.max(var_232_7, arg_229_1.talkMaxDuration)

			if var_232_6 <= arg_229_1.time_ and arg_229_1.time_ < var_232_6 + var_232_14 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_6) / var_232_14

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_6 + var_232_14 and arg_229_1.time_ < var_232_6 + var_232_14 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {}

		arg_229_1:InitPlayNodeList()
	end,
	Play426101054 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 426101054
		arg_233_1.duration_ = 3.27

		local var_233_0 = {
			zh = 3.266,
			ja = 2.1
		}
		local var_233_1 = manager.audio:GetLocalizationFlag()

		if var_233_0[var_233_1] ~= nil then
			arg_233_1.duration_ = var_233_0[var_233_1]
		end

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play426101055(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			local var_236_0 = 0
			local var_236_1 = 0.075

			if var_236_0 < arg_233_1.time_ and arg_233_1.time_ <= var_236_0 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, true)

				local var_236_2 = arg_233_1:FormatText(StoryNameCfg[1487].name)

				arg_233_1.leftNameTxt_.text = var_236_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, true)
				arg_233_1.iconController_:SetSelectedState("hero")

				arg_233_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_233_1.callingController_:SetSelectedState("normal")

				arg_233_1.keyicon_.color = Color.New(1, 1, 1)
				arg_233_1.icon_.color = Color.New(1, 1, 1)

				local var_236_3 = arg_233_1:GetWordFromCfg(426101054)
				local var_236_4 = arg_233_1:FormatText(var_236_3.content)

				arg_233_1.text_.text = var_236_4

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_5 = 3
				local var_236_6 = utf8.len(var_236_4)
				local var_236_7 = var_236_5 <= 0 and var_236_1 or var_236_1 * (var_236_6 / var_236_5)

				if var_236_7 > 0 and var_236_1 < var_236_7 then
					arg_233_1.talkMaxDuration = var_236_7

					if var_236_7 + var_236_0 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_7 + var_236_0
					end
				end

				arg_233_1.text_.text = var_236_4
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426101", "426101054", "story_v_out_426101.awb") ~= 0 then
					local var_236_8 = manager.audio:GetVoiceLength("story_v_out_426101", "426101054", "story_v_out_426101.awb") / 1000

					if var_236_8 + var_236_0 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_8 + var_236_0
					end

					if var_236_3.prefab_name ~= "" and arg_233_1.actors_[var_236_3.prefab_name] ~= nil then
						local var_236_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_233_1.actors_[var_236_3.prefab_name].transform, "story_v_out_426101", "426101054", "story_v_out_426101.awb")

						arg_233_1:RecordAudio("426101054", var_236_9)
						arg_233_1:RecordAudio("426101054", var_236_9)
					else
						arg_233_1:AudioAction("play", "voice", "story_v_out_426101", "426101054", "story_v_out_426101.awb")
					end

					arg_233_1:RecordHistoryTalkVoice("story_v_out_426101", "426101054", "story_v_out_426101.awb")
				end

				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_10 = math.max(var_236_1, arg_233_1.talkMaxDuration)

			if var_236_0 <= arg_233_1.time_ and arg_233_1.time_ < var_236_0 + var_236_10 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_0) / var_236_10

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_0 + var_236_10 and arg_233_1.time_ < var_236_0 + var_236_10 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {}

		arg_233_1:InitPlayNodeList()
	end,
	Play426101055 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 426101055
		arg_237_1.duration_ = 5

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play426101056(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			local var_240_0 = arg_237_1.actors_["1054ui_story"]
			local var_240_1 = 0

			if var_240_1 < arg_237_1.time_ and arg_237_1.time_ <= var_240_1 + arg_240_0 and not isNil(var_240_0) and arg_237_1.var_.characterEffect1054ui_story == nil then
				arg_237_1.var_.characterEffect1054ui_story = var_240_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_240_2 = 0.200000002980232

			if var_240_1 <= arg_237_1.time_ and arg_237_1.time_ < var_240_1 + var_240_2 and not isNil(var_240_0) then
				local var_240_3 = (arg_237_1.time_ - var_240_1) / var_240_2

				if arg_237_1.var_.characterEffect1054ui_story and not isNil(var_240_0) then
					local var_240_4 = Mathf.Lerp(0, 0.5, var_240_3)

					arg_237_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_237_1.var_.characterEffect1054ui_story.fillRatio = var_240_4
				end
			end

			if arg_237_1.time_ >= var_240_1 + var_240_2 and arg_237_1.time_ < var_240_1 + var_240_2 + arg_240_0 and not isNil(var_240_0) and arg_237_1.var_.characterEffect1054ui_story then
				local var_240_5 = 0.5

				arg_237_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_237_1.var_.characterEffect1054ui_story.fillRatio = var_240_5
			end

			local var_240_6 = 0
			local var_240_7 = 0.625

			if var_240_6 < arg_237_1.time_ and arg_237_1.time_ <= var_240_6 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				local var_240_8 = arg_237_1:FormatText(StoryNameCfg[7].name)

				arg_237_1.leftNameTxt_.text = var_240_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, true)
				arg_237_1.iconController_:SetSelectedState("hero")

				arg_237_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_237_1.callingController_:SetSelectedState("normal")

				arg_237_1.keyicon_.color = Color.New(1, 1, 1)
				arg_237_1.icon_.color = Color.New(1, 1, 1)

				local var_240_9 = arg_237_1:GetWordFromCfg(426101055)
				local var_240_10 = arg_237_1:FormatText(var_240_9.content)

				arg_237_1.text_.text = var_240_10

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_11 = 25
				local var_240_12 = utf8.len(var_240_10)
				local var_240_13 = var_240_11 <= 0 and var_240_7 or var_240_7 * (var_240_12 / var_240_11)

				if var_240_13 > 0 and var_240_7 < var_240_13 then
					arg_237_1.talkMaxDuration = var_240_13

					if var_240_13 + var_240_6 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_13 + var_240_6
					end
				end

				arg_237_1.text_.text = var_240_10
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)
				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_14 = math.max(var_240_7, arg_237_1.talkMaxDuration)

			if var_240_6 <= arg_237_1.time_ and arg_237_1.time_ < var_240_6 + var_240_14 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_6) / var_240_14

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_6 + var_240_14 and arg_237_1.time_ < var_240_6 + var_240_14 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {}

		arg_237_1:InitPlayNodeList()
	end,
	Play426101056 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 426101056
		arg_241_1.duration_ = 5

		SetActive(arg_241_1.tipsGo_, false)

		function arg_241_1.onSingleLineFinish_()
			arg_241_1.onSingleLineUpdate_ = nil
			arg_241_1.onSingleLineFinish_ = nil
			arg_241_1.state_ = "waiting"
		end

		function arg_241_1.playNext_(arg_243_0)
			if arg_243_0 == 1 then
				arg_241_0:Play426101057(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			local var_244_0 = arg_241_1.actors_["1054ui_story"].transform
			local var_244_1 = 0

			if var_244_1 < arg_241_1.time_ and arg_241_1.time_ <= var_244_1 + arg_244_0 then
				arg_241_1.var_.moveOldPos1054ui_story = var_244_0.localPosition

				local var_244_2 = GameObjectTools.GetOrAddComponent(var_244_0.gameObject, typeof(DynamicBoneHelper))

				if var_244_2 then
					var_244_2:EnableDynamicBone(false)
				end
			end

			local var_244_3 = 0.001

			if var_244_1 <= arg_241_1.time_ and arg_241_1.time_ < var_244_1 + var_244_3 then
				local var_244_4 = (arg_241_1.time_ - var_244_1) / var_244_3
				local var_244_5 = Vector3.New(0, 100, 0)

				var_244_0.localPosition = Vector3.Lerp(arg_241_1.var_.moveOldPos1054ui_story, var_244_5, var_244_4)

				local var_244_6 = manager.ui.mainCamera.transform.position - var_244_0.position

				var_244_0.forward = Vector3.New(var_244_6.x, var_244_6.y, var_244_6.z)

				local var_244_7 = var_244_0.localEulerAngles

				var_244_7.z = 0
				var_244_7.x = 0
				var_244_0.localEulerAngles = var_244_7
			end

			if arg_241_1.time_ >= var_244_1 + var_244_3 and arg_241_1.time_ < var_244_1 + var_244_3 + arg_244_0 then
				var_244_0.localPosition = Vector3.New(0, 100, 0)

				local var_244_8 = manager.ui.mainCamera.transform.position - var_244_0.position

				var_244_0.forward = Vector3.New(var_244_8.x, var_244_8.y, var_244_8.z)

				local var_244_9 = var_244_0.localEulerAngles

				var_244_9.z = 0
				var_244_9.x = 0
				var_244_0.localEulerAngles = var_244_9

				local var_244_10 = GameObjectTools.GetOrAddComponent(var_244_0.gameObject, typeof(DynamicBoneHelper))

				if var_244_10 then
					var_244_10:EnableDynamicBone(true)
				end
			end

			local var_244_11 = arg_241_1.bgs_.J27g.transform
			local var_244_12 = 0

			if var_244_12 < arg_241_1.time_ and arg_241_1.time_ <= var_244_12 + arg_244_0 then
				arg_241_1.var_.moveOldPosJ27g = var_244_11.localPosition
			end

			local var_244_13 = 0.725

			if var_244_12 <= arg_241_1.time_ and arg_241_1.time_ < var_244_12 + var_244_13 then
				local var_244_14 = (arg_241_1.time_ - var_244_12) / var_244_13
				local var_244_15 = Vector3.New(0, 1, 9.5)

				var_244_11.localPosition = Vector3.Lerp(arg_241_1.var_.moveOldPosJ27g, var_244_15, var_244_14)
			end

			if arg_241_1.time_ >= var_244_12 + var_244_13 and arg_241_1.time_ < var_244_12 + var_244_13 + arg_244_0 then
				var_244_11.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_244_16 = 0

			if var_244_16 < arg_241_1.time_ and arg_241_1.time_ <= var_244_16 + arg_244_0 then
				arg_241_1.allBtn_.enabled = false
			end

			local var_244_17 = 0.725

			if arg_241_1.time_ >= var_244_16 + var_244_17 and arg_241_1.time_ < var_244_16 + var_244_17 + arg_244_0 then
				arg_241_1.allBtn_.enabled = true
			end

			local var_244_18 = 0
			local var_244_19 = 0.725

			if var_244_18 < arg_241_1.time_ and arg_241_1.time_ <= var_244_18 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0

				arg_241_1.dialog_:SetActive(true)

				arg_241_1.dialogCg_.alpha = 0

				local var_244_20 = LeanTween.value(arg_241_1.dialog_, 0, 1, 0.3)

				var_244_20:setOnUpdate(LuaHelper.FloatAction(function(arg_245_0)
					arg_241_1.dialogCg_.alpha = arg_245_0
				end))
				var_244_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_241_1.dialog_)
					var_244_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_241_1.duration_ = arg_241_1.duration_ + 0.3

				SetActive(arg_241_1.leftNameGo_, false)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_21 = arg_241_1:GetWordFromCfg(426101056)
				local var_244_22 = arg_241_1:FormatText(var_244_21.content)

				arg_241_1.text_.text = var_244_22

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_23 = 29
				local var_244_24 = utf8.len(var_244_22)
				local var_244_25 = var_244_23 <= 0 and var_244_19 or var_244_19 * (var_244_24 / var_244_23)

				if var_244_25 > 0 and var_244_19 < var_244_25 then
					arg_241_1.talkMaxDuration = var_244_25
					var_244_18 = var_244_18 + 0.3

					if var_244_25 + var_244_18 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_25 + var_244_18
					end
				end

				arg_241_1.text_.text = var_244_22
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)
				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_26 = var_244_18 + 0.3
			local var_244_27 = math.max(var_244_19, arg_241_1.talkMaxDuration)

			if var_244_26 <= arg_241_1.time_ and arg_241_1.time_ < var_244_26 + var_244_27 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_26) / var_244_27

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_26 + var_244_27 and arg_241_1.time_ < var_244_26 + var_244_27 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				needEase = true,
				actorName = "J27g",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 0.725,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 10),
					endPos = Vector3.New(0, 1, 9.5),
					easeType = LeanTweenType.easeInOutExpo
				}
			}
		}

		arg_241_1:InitPlayNodeList()
	end,
	Play426101057 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 426101057
		arg_247_1.duration_ = 5

		SetActive(arg_247_1.tipsGo_, false)

		function arg_247_1.onSingleLineFinish_()
			arg_247_1.onSingleLineUpdate_ = nil
			arg_247_1.onSingleLineFinish_ = nil
			arg_247_1.state_ = "waiting"
		end

		function arg_247_1.playNext_(arg_249_0)
			if arg_249_0 == 1 then
				arg_247_0:Play426101058(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			local var_250_0 = 0
			local var_250_1 = 0.9

			if var_250_0 < arg_247_1.time_ and arg_247_1.time_ <= var_250_0 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, false)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_2 = arg_247_1:GetWordFromCfg(426101057)
				local var_250_3 = arg_247_1:FormatText(var_250_2.content)

				arg_247_1.text_.text = var_250_3

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_4 = 36
				local var_250_5 = utf8.len(var_250_3)
				local var_250_6 = var_250_4 <= 0 and var_250_1 or var_250_1 * (var_250_5 / var_250_4)

				if var_250_6 > 0 and var_250_1 < var_250_6 then
					arg_247_1.talkMaxDuration = var_250_6

					if var_250_6 + var_250_0 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_6 + var_250_0
					end
				end

				arg_247_1.text_.text = var_250_3
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)
				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_7 = math.max(var_250_1, arg_247_1.talkMaxDuration)

			if var_250_0 <= arg_247_1.time_ and arg_247_1.time_ < var_250_0 + var_250_7 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_0) / var_250_7

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_0 + var_250_7 and arg_247_1.time_ < var_250_0 + var_250_7 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {}

		arg_247_1:InitPlayNodeList()
	end,
	Play426101058 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 426101058
		arg_251_1.duration_ = 3.93

		local var_251_0 = {
			zh = 3.133,
			ja = 3.933
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
				arg_251_0:Play426101059(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			local var_254_0 = arg_251_1.actors_["1054ui_story"].transform
			local var_254_1 = 0

			if var_254_1 < arg_251_1.time_ and arg_251_1.time_ <= var_254_1 + arg_254_0 then
				arg_251_1.var_.moveOldPos1054ui_story = var_254_0.localPosition

				local var_254_2 = GameObjectTools.GetOrAddComponent(var_254_0.gameObject, typeof(DynamicBoneHelper))

				if var_254_2 then
					var_254_2:EnableDynamicBone(false)
				end
			end

			local var_254_3 = 0.001

			if var_254_1 <= arg_251_1.time_ and arg_251_1.time_ < var_254_1 + var_254_3 then
				local var_254_4 = (arg_251_1.time_ - var_254_1) / var_254_3
				local var_254_5 = Vector3.New(0, -0.985, -6)

				var_254_0.localPosition = Vector3.Lerp(arg_251_1.var_.moveOldPos1054ui_story, var_254_5, var_254_4)

				local var_254_6 = manager.ui.mainCamera.transform.position - var_254_0.position

				var_254_0.forward = Vector3.New(var_254_6.x, var_254_6.y, var_254_6.z)

				local var_254_7 = var_254_0.localEulerAngles

				var_254_7.z = 0
				var_254_7.x = 0
				var_254_0.localEulerAngles = var_254_7
			end

			if arg_251_1.time_ >= var_254_1 + var_254_3 and arg_251_1.time_ < var_254_1 + var_254_3 + arg_254_0 then
				var_254_0.localPosition = Vector3.New(0, -0.985, -6)

				local var_254_8 = manager.ui.mainCamera.transform.position - var_254_0.position

				var_254_0.forward = Vector3.New(var_254_8.x, var_254_8.y, var_254_8.z)

				local var_254_9 = var_254_0.localEulerAngles

				var_254_9.z = 0
				var_254_9.x = 0
				var_254_0.localEulerAngles = var_254_9

				local var_254_10 = GameObjectTools.GetOrAddComponent(var_254_0.gameObject, typeof(DynamicBoneHelper))

				if var_254_10 then
					var_254_10:EnableDynamicBone(true)
				end
			end

			local var_254_11 = arg_251_1.actors_["1054ui_story"]
			local var_254_12 = 0

			if var_254_12 < arg_251_1.time_ and arg_251_1.time_ <= var_254_12 + arg_254_0 and not isNil(var_254_11) and arg_251_1.var_.characterEffect1054ui_story == nil then
				arg_251_1.var_.characterEffect1054ui_story = var_254_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_254_13 = 0.200000002980232

			if var_254_12 <= arg_251_1.time_ and arg_251_1.time_ < var_254_12 + var_254_13 and not isNil(var_254_11) then
				local var_254_14 = (arg_251_1.time_ - var_254_12) / var_254_13

				if arg_251_1.var_.characterEffect1054ui_story and not isNil(var_254_11) then
					arg_251_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_251_1.time_ >= var_254_12 + var_254_13 and arg_251_1.time_ < var_254_12 + var_254_13 + arg_254_0 and not isNil(var_254_11) and arg_251_1.var_.characterEffect1054ui_story then
				arg_251_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_254_15 = 0

			if var_254_15 < arg_251_1.time_ and arg_251_1.time_ <= var_254_15 + arg_254_0 then
				arg_251_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action1_1")
			end

			local var_254_16 = 0

			if var_254_16 < arg_251_1.time_ and arg_251_1.time_ <= var_254_16 + arg_254_0 then
				arg_251_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_254_17 = 0
			local var_254_18 = 0.25

			if var_254_17 < arg_251_1.time_ and arg_251_1.time_ <= var_254_17 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				local var_254_19 = arg_251_1:FormatText(StoryNameCfg[1487].name)

				arg_251_1.leftNameTxt_.text = var_254_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, false)
				arg_251_1.callingController_:SetSelectedState("normal")

				local var_254_20 = arg_251_1:GetWordFromCfg(426101058)
				local var_254_21 = arg_251_1:FormatText(var_254_20.content)

				arg_251_1.text_.text = var_254_21

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_22 = 10
				local var_254_23 = utf8.len(var_254_21)
				local var_254_24 = var_254_22 <= 0 and var_254_18 or var_254_18 * (var_254_23 / var_254_22)

				if var_254_24 > 0 and var_254_18 < var_254_24 then
					arg_251_1.talkMaxDuration = var_254_24

					if var_254_24 + var_254_17 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_24 + var_254_17
					end
				end

				arg_251_1.text_.text = var_254_21
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426101", "426101058", "story_v_out_426101.awb") ~= 0 then
					local var_254_25 = manager.audio:GetVoiceLength("story_v_out_426101", "426101058", "story_v_out_426101.awb") / 1000

					if var_254_25 + var_254_17 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_25 + var_254_17
					end

					if var_254_20.prefab_name ~= "" and arg_251_1.actors_[var_254_20.prefab_name] ~= nil then
						local var_254_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_251_1.actors_[var_254_20.prefab_name].transform, "story_v_out_426101", "426101058", "story_v_out_426101.awb")

						arg_251_1:RecordAudio("426101058", var_254_26)
						arg_251_1:RecordAudio("426101058", var_254_26)
					else
						arg_251_1:AudioAction("play", "voice", "story_v_out_426101", "426101058", "story_v_out_426101.awb")
					end

					arg_251_1:RecordHistoryTalkVoice("story_v_out_426101", "426101058", "story_v_out_426101.awb")
				end

				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_27 = math.max(var_254_18, arg_251_1.talkMaxDuration)

			if var_254_17 <= arg_251_1.time_ and arg_251_1.time_ < var_254_17 + var_254_27 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_17) / var_254_27

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_17 + var_254_27 and arg_251_1.time_ < var_254_17 + var_254_27 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_251_1:InitPlayNodeList()
	end,
	Play426101059 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 426101059
		arg_255_1.duration_ = 5

		SetActive(arg_255_1.tipsGo_, false)

		function arg_255_1.onSingleLineFinish_()
			arg_255_1.onSingleLineUpdate_ = nil
			arg_255_1.onSingleLineFinish_ = nil
			arg_255_1.state_ = "waiting"
		end

		function arg_255_1.playNext_(arg_257_0)
			if arg_257_0 == 1 then
				arg_255_0:Play426101060(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			local var_258_0 = arg_255_1.actors_["1054ui_story"]
			local var_258_1 = 0

			if var_258_1 < arg_255_1.time_ and arg_255_1.time_ <= var_258_1 + arg_258_0 and not isNil(var_258_0) and arg_255_1.var_.characterEffect1054ui_story == nil then
				arg_255_1.var_.characterEffect1054ui_story = var_258_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_258_2 = 0.200000002980232

			if var_258_1 <= arg_255_1.time_ and arg_255_1.time_ < var_258_1 + var_258_2 and not isNil(var_258_0) then
				local var_258_3 = (arg_255_1.time_ - var_258_1) / var_258_2

				if arg_255_1.var_.characterEffect1054ui_story and not isNil(var_258_0) then
					local var_258_4 = Mathf.Lerp(0, 0.5, var_258_3)

					arg_255_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_255_1.var_.characterEffect1054ui_story.fillRatio = var_258_4
				end
			end

			if arg_255_1.time_ >= var_258_1 + var_258_2 and arg_255_1.time_ < var_258_1 + var_258_2 + arg_258_0 and not isNil(var_258_0) and arg_255_1.var_.characterEffect1054ui_story then
				local var_258_5 = 0.5

				arg_255_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_255_1.var_.characterEffect1054ui_story.fillRatio = var_258_5
			end

			local var_258_6 = 0
			local var_258_7 = 0.55

			if var_258_6 < arg_255_1.time_ and arg_255_1.time_ <= var_258_6 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, true)

				local var_258_8 = arg_255_1:FormatText(StoryNameCfg[7].name)

				arg_255_1.leftNameTxt_.text = var_258_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_255_1.leftNameTxt_.transform)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1.leftNameTxt_.text)
				SetActive(arg_255_1.iconTrs_.gameObject, true)
				arg_255_1.iconController_:SetSelectedState("hero")

				arg_255_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_255_1.callingController_:SetSelectedState("normal")

				arg_255_1.keyicon_.color = Color.New(1, 1, 1)
				arg_255_1.icon_.color = Color.New(1, 1, 1)

				local var_258_9 = arg_255_1:GetWordFromCfg(426101059)
				local var_258_10 = arg_255_1:FormatText(var_258_9.content)

				arg_255_1.text_.text = var_258_10

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_11 = 22
				local var_258_12 = utf8.len(var_258_10)
				local var_258_13 = var_258_11 <= 0 and var_258_7 or var_258_7 * (var_258_12 / var_258_11)

				if var_258_13 > 0 and var_258_7 < var_258_13 then
					arg_255_1.talkMaxDuration = var_258_13

					if var_258_13 + var_258_6 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_13 + var_258_6
					end
				end

				arg_255_1.text_.text = var_258_10
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)
				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_14 = math.max(var_258_7, arg_255_1.talkMaxDuration)

			if var_258_6 <= arg_255_1.time_ and arg_255_1.time_ < var_258_6 + var_258_14 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - var_258_6) / var_258_14

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= var_258_6 + var_258_14 and arg_255_1.time_ < var_258_6 + var_258_14 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {}

		arg_255_1:InitPlayNodeList()
	end,
	Play426101060 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 426101060
		arg_259_1.duration_ = 5.63

		local var_259_0 = {
			zh = 3.266,
			ja = 5.633
		}
		local var_259_1 = manager.audio:GetLocalizationFlag()

		if var_259_0[var_259_1] ~= nil then
			arg_259_1.duration_ = var_259_0[var_259_1]
		end

		SetActive(arg_259_1.tipsGo_, false)

		function arg_259_1.onSingleLineFinish_()
			arg_259_1.onSingleLineUpdate_ = nil
			arg_259_1.onSingleLineFinish_ = nil
			arg_259_1.state_ = "waiting"
		end

		function arg_259_1.playNext_(arg_261_0)
			if arg_261_0 == 1 then
				arg_259_0:Play426101061(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			local var_262_0 = arg_259_1.actors_["1054ui_story"].transform
			local var_262_1 = 0

			if var_262_1 < arg_259_1.time_ and arg_259_1.time_ <= var_262_1 + arg_262_0 then
				arg_259_1.var_.moveOldPos1054ui_story = var_262_0.localPosition

				local var_262_2 = GameObjectTools.GetOrAddComponent(var_262_0.gameObject, typeof(DynamicBoneHelper))

				if var_262_2 then
					var_262_2:EnableDynamicBone(false)
				end
			end

			local var_262_3 = 0.001

			if var_262_1 <= arg_259_1.time_ and arg_259_1.time_ < var_262_1 + var_262_3 then
				local var_262_4 = (arg_259_1.time_ - var_262_1) / var_262_3
				local var_262_5 = Vector3.New(0, -0.985, -6)

				var_262_0.localPosition = Vector3.Lerp(arg_259_1.var_.moveOldPos1054ui_story, var_262_5, var_262_4)

				local var_262_6 = manager.ui.mainCamera.transform.position - var_262_0.position

				var_262_0.forward = Vector3.New(var_262_6.x, var_262_6.y, var_262_6.z)

				local var_262_7 = var_262_0.localEulerAngles

				var_262_7.z = 0
				var_262_7.x = 0
				var_262_0.localEulerAngles = var_262_7
			end

			if arg_259_1.time_ >= var_262_1 + var_262_3 and arg_259_1.time_ < var_262_1 + var_262_3 + arg_262_0 then
				var_262_0.localPosition = Vector3.New(0, -0.985, -6)

				local var_262_8 = manager.ui.mainCamera.transform.position - var_262_0.position

				var_262_0.forward = Vector3.New(var_262_8.x, var_262_8.y, var_262_8.z)

				local var_262_9 = var_262_0.localEulerAngles

				var_262_9.z = 0
				var_262_9.x = 0
				var_262_0.localEulerAngles = var_262_9

				local var_262_10 = GameObjectTools.GetOrAddComponent(var_262_0.gameObject, typeof(DynamicBoneHelper))

				if var_262_10 then
					var_262_10:EnableDynamicBone(true)
				end
			end

			local var_262_11 = arg_259_1.actors_["1054ui_story"]
			local var_262_12 = 0

			if var_262_12 < arg_259_1.time_ and arg_259_1.time_ <= var_262_12 + arg_262_0 and not isNil(var_262_11) and arg_259_1.var_.characterEffect1054ui_story == nil then
				arg_259_1.var_.characterEffect1054ui_story = var_262_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_262_13 = 0.200000002980232

			if var_262_12 <= arg_259_1.time_ and arg_259_1.time_ < var_262_12 + var_262_13 and not isNil(var_262_11) then
				local var_262_14 = (arg_259_1.time_ - var_262_12) / var_262_13

				if arg_259_1.var_.characterEffect1054ui_story and not isNil(var_262_11) then
					arg_259_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_259_1.time_ >= var_262_12 + var_262_13 and arg_259_1.time_ < var_262_12 + var_262_13 + arg_262_0 and not isNil(var_262_11) and arg_259_1.var_.characterEffect1054ui_story then
				arg_259_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_262_15 = 0

			if var_262_15 < arg_259_1.time_ and arg_259_1.time_ <= var_262_15 + arg_262_0 then
				arg_259_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action4_1")
			end

			local var_262_16 = 0

			if var_262_16 < arg_259_1.time_ and arg_259_1.time_ <= var_262_16 + arg_262_0 then
				arg_259_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_262_17 = 0
			local var_262_18 = 0.325

			if var_262_17 < arg_259_1.time_ and arg_259_1.time_ <= var_262_17 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, true)

				local var_262_19 = arg_259_1:FormatText(StoryNameCfg[1487].name)

				arg_259_1.leftNameTxt_.text = var_262_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_259_1.leftNameTxt_.transform)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1.leftNameTxt_.text)
				SetActive(arg_259_1.iconTrs_.gameObject, false)
				arg_259_1.callingController_:SetSelectedState("normal")

				local var_262_20 = arg_259_1:GetWordFromCfg(426101060)
				local var_262_21 = arg_259_1:FormatText(var_262_20.content)

				arg_259_1.text_.text = var_262_21

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_22 = 13
				local var_262_23 = utf8.len(var_262_21)
				local var_262_24 = var_262_22 <= 0 and var_262_18 or var_262_18 * (var_262_23 / var_262_22)

				if var_262_24 > 0 and var_262_18 < var_262_24 then
					arg_259_1.talkMaxDuration = var_262_24

					if var_262_24 + var_262_17 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_24 + var_262_17
					end
				end

				arg_259_1.text_.text = var_262_21
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426101", "426101060", "story_v_out_426101.awb") ~= 0 then
					local var_262_25 = manager.audio:GetVoiceLength("story_v_out_426101", "426101060", "story_v_out_426101.awb") / 1000

					if var_262_25 + var_262_17 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_25 + var_262_17
					end

					if var_262_20.prefab_name ~= "" and arg_259_1.actors_[var_262_20.prefab_name] ~= nil then
						local var_262_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_259_1.actors_[var_262_20.prefab_name].transform, "story_v_out_426101", "426101060", "story_v_out_426101.awb")

						arg_259_1:RecordAudio("426101060", var_262_26)
						arg_259_1:RecordAudio("426101060", var_262_26)
					else
						arg_259_1:AudioAction("play", "voice", "story_v_out_426101", "426101060", "story_v_out_426101.awb")
					end

					arg_259_1:RecordHistoryTalkVoice("story_v_out_426101", "426101060", "story_v_out_426101.awb")
				end

				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_27 = math.max(var_262_18, arg_259_1.talkMaxDuration)

			if var_262_17 <= arg_259_1.time_ and arg_259_1.time_ < var_262_17 + var_262_27 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - var_262_17) / var_262_27

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= var_262_17 + var_262_27 and arg_259_1.time_ < var_262_17 + var_262_27 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_259_1:InitPlayNodeList()
	end,
	Play426101061 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 426101061
		arg_263_1.duration_ = 7.4

		local var_263_0 = {
			zh = 7.4,
			ja = 4.8
		}
		local var_263_1 = manager.audio:GetLocalizationFlag()

		if var_263_0[var_263_1] ~= nil then
			arg_263_1.duration_ = var_263_0[var_263_1]
		end

		SetActive(arg_263_1.tipsGo_, false)

		function arg_263_1.onSingleLineFinish_()
			arg_263_1.onSingleLineUpdate_ = nil
			arg_263_1.onSingleLineFinish_ = nil
			arg_263_1.state_ = "waiting"
		end

		function arg_263_1.playNext_(arg_265_0)
			if arg_265_0 == 1 then
				arg_263_0:Play426101062(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			local var_266_0 = 0
			local var_266_1 = 0.7

			if var_266_0 < arg_263_1.time_ and arg_263_1.time_ <= var_266_0 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, true)

				local var_266_2 = arg_263_1:FormatText(StoryNameCfg[1487].name)

				arg_263_1.leftNameTxt_.text = var_266_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_263_1.leftNameTxt_.transform)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1.leftNameTxt_.text)
				SetActive(arg_263_1.iconTrs_.gameObject, false)
				arg_263_1.callingController_:SetSelectedState("normal")

				local var_266_3 = arg_263_1:GetWordFromCfg(426101061)
				local var_266_4 = arg_263_1:FormatText(var_266_3.content)

				arg_263_1.text_.text = var_266_4

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_5 = 28
				local var_266_6 = utf8.len(var_266_4)
				local var_266_7 = var_266_5 <= 0 and var_266_1 or var_266_1 * (var_266_6 / var_266_5)

				if var_266_7 > 0 and var_266_1 < var_266_7 then
					arg_263_1.talkMaxDuration = var_266_7

					if var_266_7 + var_266_0 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_7 + var_266_0
					end
				end

				arg_263_1.text_.text = var_266_4
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426101", "426101061", "story_v_out_426101.awb") ~= 0 then
					local var_266_8 = manager.audio:GetVoiceLength("story_v_out_426101", "426101061", "story_v_out_426101.awb") / 1000

					if var_266_8 + var_266_0 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_8 + var_266_0
					end

					if var_266_3.prefab_name ~= "" and arg_263_1.actors_[var_266_3.prefab_name] ~= nil then
						local var_266_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_263_1.actors_[var_266_3.prefab_name].transform, "story_v_out_426101", "426101061", "story_v_out_426101.awb")

						arg_263_1:RecordAudio("426101061", var_266_9)
						arg_263_1:RecordAudio("426101061", var_266_9)
					else
						arg_263_1:AudioAction("play", "voice", "story_v_out_426101", "426101061", "story_v_out_426101.awb")
					end

					arg_263_1:RecordHistoryTalkVoice("story_v_out_426101", "426101061", "story_v_out_426101.awb")
				end

				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_10 = math.max(var_266_1, arg_263_1.talkMaxDuration)

			if var_266_0 <= arg_263_1.time_ and arg_263_1.time_ < var_266_0 + var_266_10 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - var_266_0) / var_266_10

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= var_266_0 + var_266_10 and arg_263_1.time_ < var_266_0 + var_266_10 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {}

		arg_263_1:InitPlayNodeList()
	end,
	Play426101062 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 426101062
		arg_267_1.duration_ = 6.47

		local var_267_0 = {
			zh = 4.833,
			ja = 6.466
		}
		local var_267_1 = manager.audio:GetLocalizationFlag()

		if var_267_0[var_267_1] ~= nil then
			arg_267_1.duration_ = var_267_0[var_267_1]
		end

		SetActive(arg_267_1.tipsGo_, false)

		function arg_267_1.onSingleLineFinish_()
			arg_267_1.onSingleLineUpdate_ = nil
			arg_267_1.onSingleLineFinish_ = nil
			arg_267_1.state_ = "waiting"
		end

		function arg_267_1.playNext_(arg_269_0)
			if arg_269_0 == 1 then
				arg_267_0:Play426101063(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			local var_270_0 = arg_267_1.actors_["1054ui_story"].transform
			local var_270_1 = 0

			if var_270_1 < arg_267_1.time_ and arg_267_1.time_ <= var_270_1 + arg_270_0 then
				arg_267_1.var_.moveOldPos1054ui_story = var_270_0.localPosition

				local var_270_2 = GameObjectTools.GetOrAddComponent(var_270_0.gameObject, typeof(DynamicBoneHelper))

				if var_270_2 then
					var_270_2:EnableDynamicBone(false)
				end
			end

			local var_270_3 = 0.001

			if var_270_1 <= arg_267_1.time_ and arg_267_1.time_ < var_270_1 + var_270_3 then
				local var_270_4 = (arg_267_1.time_ - var_270_1) / var_270_3
				local var_270_5 = Vector3.New(0, -0.985, -6)

				var_270_0.localPosition = Vector3.Lerp(arg_267_1.var_.moveOldPos1054ui_story, var_270_5, var_270_4)

				local var_270_6 = manager.ui.mainCamera.transform.position - var_270_0.position

				var_270_0.forward = Vector3.New(var_270_6.x, var_270_6.y, var_270_6.z)

				local var_270_7 = var_270_0.localEulerAngles

				var_270_7.z = 0
				var_270_7.x = 0
				var_270_0.localEulerAngles = var_270_7
			end

			if arg_267_1.time_ >= var_270_1 + var_270_3 and arg_267_1.time_ < var_270_1 + var_270_3 + arg_270_0 then
				var_270_0.localPosition = Vector3.New(0, -0.985, -6)

				local var_270_8 = manager.ui.mainCamera.transform.position - var_270_0.position

				var_270_0.forward = Vector3.New(var_270_8.x, var_270_8.y, var_270_8.z)

				local var_270_9 = var_270_0.localEulerAngles

				var_270_9.z = 0
				var_270_9.x = 0
				var_270_0.localEulerAngles = var_270_9

				local var_270_10 = GameObjectTools.GetOrAddComponent(var_270_0.gameObject, typeof(DynamicBoneHelper))

				if var_270_10 then
					var_270_10:EnableDynamicBone(true)
				end
			end

			local var_270_11 = 0

			if var_270_11 < arg_267_1.time_ and arg_267_1.time_ <= var_270_11 + arg_270_0 then
				arg_267_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054actionlink/1054action443")
			end

			local var_270_12 = 0

			if var_270_12 < arg_267_1.time_ and arg_267_1.time_ <= var_270_12 + arg_270_0 then
				arg_267_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoC", "EmotionTimelineAnimator")
			end

			local var_270_13 = 0
			local var_270_14 = 0.375

			if var_270_13 < arg_267_1.time_ and arg_267_1.time_ <= var_270_13 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, true)

				local var_270_15 = arg_267_1:FormatText(StoryNameCfg[1487].name)

				arg_267_1.leftNameTxt_.text = var_270_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_267_1.leftNameTxt_.transform)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1.leftNameTxt_.text)
				SetActive(arg_267_1.iconTrs_.gameObject, false)
				arg_267_1.callingController_:SetSelectedState("normal")

				local var_270_16 = arg_267_1:GetWordFromCfg(426101062)
				local var_270_17 = arg_267_1:FormatText(var_270_16.content)

				arg_267_1.text_.text = var_270_17

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_18 = 15
				local var_270_19 = utf8.len(var_270_17)
				local var_270_20 = var_270_18 <= 0 and var_270_14 or var_270_14 * (var_270_19 / var_270_18)

				if var_270_20 > 0 and var_270_14 < var_270_20 then
					arg_267_1.talkMaxDuration = var_270_20

					if var_270_20 + var_270_13 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_20 + var_270_13
					end
				end

				arg_267_1.text_.text = var_270_17
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426101", "426101062", "story_v_out_426101.awb") ~= 0 then
					local var_270_21 = manager.audio:GetVoiceLength("story_v_out_426101", "426101062", "story_v_out_426101.awb") / 1000

					if var_270_21 + var_270_13 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_21 + var_270_13
					end

					if var_270_16.prefab_name ~= "" and arg_267_1.actors_[var_270_16.prefab_name] ~= nil then
						local var_270_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_267_1.actors_[var_270_16.prefab_name].transform, "story_v_out_426101", "426101062", "story_v_out_426101.awb")

						arg_267_1:RecordAudio("426101062", var_270_22)
						arg_267_1:RecordAudio("426101062", var_270_22)
					else
						arg_267_1:AudioAction("play", "voice", "story_v_out_426101", "426101062", "story_v_out_426101.awb")
					end

					arg_267_1:RecordHistoryTalkVoice("story_v_out_426101", "426101062", "story_v_out_426101.awb")
				end

				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_23 = math.max(var_270_14, arg_267_1.talkMaxDuration)

			if var_270_13 <= arg_267_1.time_ and arg_267_1.time_ < var_270_13 + var_270_23 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - var_270_13) / var_270_23

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= var_270_13 + var_270_23 and arg_267_1.time_ < var_270_13 + var_270_23 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_267_1:InitPlayNodeList()
	end,
	Play426101063 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 426101063
		arg_271_1.duration_ = 5

		SetActive(arg_271_1.tipsGo_, false)

		function arg_271_1.onSingleLineFinish_()
			arg_271_1.onSingleLineUpdate_ = nil
			arg_271_1.onSingleLineFinish_ = nil
			arg_271_1.state_ = "waiting"
		end

		function arg_271_1.playNext_(arg_273_0)
			if arg_273_0 == 1 then
				arg_271_0:Play426101064(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			local var_274_0 = arg_271_1.actors_["1054ui_story"].transform
			local var_274_1 = 0

			if var_274_1 < arg_271_1.time_ and arg_271_1.time_ <= var_274_1 + arg_274_0 then
				arg_271_1.var_.moveOldPos1054ui_story = var_274_0.localPosition

				local var_274_2 = GameObjectTools.GetOrAddComponent(var_274_0.gameObject, typeof(DynamicBoneHelper))

				if var_274_2 then
					var_274_2:EnableDynamicBone(false)
				end
			end

			local var_274_3 = 0.001

			if var_274_1 <= arg_271_1.time_ and arg_271_1.time_ < var_274_1 + var_274_3 then
				local var_274_4 = (arg_271_1.time_ - var_274_1) / var_274_3
				local var_274_5 = Vector3.New(0, 100, 0)

				var_274_0.localPosition = Vector3.Lerp(arg_271_1.var_.moveOldPos1054ui_story, var_274_5, var_274_4)

				local var_274_6 = manager.ui.mainCamera.transform.position - var_274_0.position

				var_274_0.forward = Vector3.New(var_274_6.x, var_274_6.y, var_274_6.z)

				local var_274_7 = var_274_0.localEulerAngles

				var_274_7.z = 0
				var_274_7.x = 0
				var_274_0.localEulerAngles = var_274_7
			end

			if arg_271_1.time_ >= var_274_1 + var_274_3 and arg_271_1.time_ < var_274_1 + var_274_3 + arg_274_0 then
				var_274_0.localPosition = Vector3.New(0, 100, 0)

				local var_274_8 = manager.ui.mainCamera.transform.position - var_274_0.position

				var_274_0.forward = Vector3.New(var_274_8.x, var_274_8.y, var_274_8.z)

				local var_274_9 = var_274_0.localEulerAngles

				var_274_9.z = 0
				var_274_9.x = 0
				var_274_0.localEulerAngles = var_274_9

				local var_274_10 = GameObjectTools.GetOrAddComponent(var_274_0.gameObject, typeof(DynamicBoneHelper))

				if var_274_10 then
					var_274_10:EnableDynamicBone(true)
				end
			end

			local var_274_11 = arg_271_1.actors_["1054ui_story"]
			local var_274_12 = 0

			if var_274_12 < arg_271_1.time_ and arg_271_1.time_ <= var_274_12 + arg_274_0 and not isNil(var_274_11) and arg_271_1.var_.characterEffect1054ui_story == nil then
				arg_271_1.var_.characterEffect1054ui_story = var_274_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_274_13 = 0.200000002980232

			if var_274_12 <= arg_271_1.time_ and arg_271_1.time_ < var_274_12 + var_274_13 and not isNil(var_274_11) then
				local var_274_14 = (arg_271_1.time_ - var_274_12) / var_274_13

				if arg_271_1.var_.characterEffect1054ui_story and not isNil(var_274_11) then
					local var_274_15 = Mathf.Lerp(0, 0.5, var_274_14)

					arg_271_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_271_1.var_.characterEffect1054ui_story.fillRatio = var_274_15
				end
			end

			if arg_271_1.time_ >= var_274_12 + var_274_13 and arg_271_1.time_ < var_274_12 + var_274_13 + arg_274_0 and not isNil(var_274_11) and arg_271_1.var_.characterEffect1054ui_story then
				local var_274_16 = 0.5

				arg_271_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_271_1.var_.characterEffect1054ui_story.fillRatio = var_274_16
			end

			local var_274_17 = 0
			local var_274_18 = 0.675

			if var_274_17 < arg_271_1.time_ and arg_271_1.time_ <= var_274_17 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, false)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_271_1.iconTrs_.gameObject, false)
				arg_271_1.callingController_:SetSelectedState("normal")

				local var_274_19 = arg_271_1:GetWordFromCfg(426101063)
				local var_274_20 = arg_271_1:FormatText(var_274_19.content)

				arg_271_1.text_.text = var_274_20

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_21 = 27
				local var_274_22 = utf8.len(var_274_20)
				local var_274_23 = var_274_21 <= 0 and var_274_18 or var_274_18 * (var_274_22 / var_274_21)

				if var_274_23 > 0 and var_274_18 < var_274_23 then
					arg_271_1.talkMaxDuration = var_274_23

					if var_274_23 + var_274_17 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_23 + var_274_17
					end
				end

				arg_271_1.text_.text = var_274_20
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)
				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_24 = math.max(var_274_18, arg_271_1.talkMaxDuration)

			if var_274_17 <= arg_271_1.time_ and arg_271_1.time_ < var_274_17 + var_274_24 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - var_274_17) / var_274_24

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= var_274_17 + var_274_24 and arg_271_1.time_ < var_274_17 + var_274_24 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_271_1:InitPlayNodeList()
	end,
	Play426101064 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 426101064
		arg_275_1.duration_ = 5

		SetActive(arg_275_1.tipsGo_, false)

		function arg_275_1.onSingleLineFinish_()
			arg_275_1.onSingleLineUpdate_ = nil
			arg_275_1.onSingleLineFinish_ = nil
			arg_275_1.state_ = "waiting"
		end

		function arg_275_1.playNext_(arg_277_0)
			if arg_277_0 == 1 then
				arg_275_0:Play426101065(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			local var_278_0 = 0
			local var_278_1 = 0.775

			if var_278_0 < arg_275_1.time_ and arg_275_1.time_ <= var_278_0 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, true)

				local var_278_2 = arg_275_1:FormatText(StoryNameCfg[7].name)

				arg_275_1.leftNameTxt_.text = var_278_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_275_1.leftNameTxt_.transform)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1.leftNameTxt_.text)
				SetActive(arg_275_1.iconTrs_.gameObject, true)
				arg_275_1.iconController_:SetSelectedState("hero")

				arg_275_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_275_1.callingController_:SetSelectedState("normal")

				arg_275_1.keyicon_.color = Color.New(1, 1, 1)
				arg_275_1.icon_.color = Color.New(1, 1, 1)

				local var_278_3 = arg_275_1:GetWordFromCfg(426101064)
				local var_278_4 = arg_275_1:FormatText(var_278_3.content)

				arg_275_1.text_.text = var_278_4

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_5 = 31
				local var_278_6 = utf8.len(var_278_4)
				local var_278_7 = var_278_5 <= 0 and var_278_1 or var_278_1 * (var_278_6 / var_278_5)

				if var_278_7 > 0 and var_278_1 < var_278_7 then
					arg_275_1.talkMaxDuration = var_278_7

					if var_278_7 + var_278_0 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_7 + var_278_0
					end
				end

				arg_275_1.text_.text = var_278_4
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)
				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_8 = math.max(var_278_1, arg_275_1.talkMaxDuration)

			if var_278_0 <= arg_275_1.time_ and arg_275_1.time_ < var_278_0 + var_278_8 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - var_278_0) / var_278_8

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= var_278_0 + var_278_8 and arg_275_1.time_ < var_278_0 + var_278_8 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {}

		arg_275_1:InitPlayNodeList()
	end,
	Play426101065 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 426101065
		arg_279_1.duration_ = 5

		SetActive(arg_279_1.tipsGo_, false)

		function arg_279_1.onSingleLineFinish_()
			arg_279_1.onSingleLineUpdate_ = nil
			arg_279_1.onSingleLineFinish_ = nil
			arg_279_1.state_ = "waiting"
		end

		function arg_279_1.playNext_(arg_281_0)
			if arg_281_0 == 1 then
				arg_279_0:Play426101066(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			local var_282_0 = 0
			local var_282_1 = 0.5

			if var_282_0 < arg_279_1.time_ and arg_279_1.time_ <= var_282_0 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, false)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_279_1.iconTrs_.gameObject, false)
				arg_279_1.callingController_:SetSelectedState("normal")

				local var_282_2 = arg_279_1:GetWordFromCfg(426101065)
				local var_282_3 = arg_279_1:FormatText(var_282_2.content)

				arg_279_1.text_.text = var_282_3

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_4 = 20
				local var_282_5 = utf8.len(var_282_3)
				local var_282_6 = var_282_4 <= 0 and var_282_1 or var_282_1 * (var_282_5 / var_282_4)

				if var_282_6 > 0 and var_282_1 < var_282_6 then
					arg_279_1.talkMaxDuration = var_282_6

					if var_282_6 + var_282_0 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_6 + var_282_0
					end
				end

				arg_279_1.text_.text = var_282_3
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)
				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_7 = math.max(var_282_1, arg_279_1.talkMaxDuration)

			if var_282_0 <= arg_279_1.time_ and arg_279_1.time_ < var_282_0 + var_282_7 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - var_282_0) / var_282_7

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= var_282_0 + var_282_7 and arg_279_1.time_ < var_282_0 + var_282_7 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {}

		arg_279_1:InitPlayNodeList()
	end,
	Play426101066 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 426101066
		arg_283_1.duration_ = 5

		SetActive(arg_283_1.tipsGo_, false)

		function arg_283_1.onSingleLineFinish_()
			arg_283_1.onSingleLineUpdate_ = nil
			arg_283_1.onSingleLineFinish_ = nil
			arg_283_1.state_ = "waiting"
		end

		function arg_283_1.playNext_(arg_285_0)
			if arg_285_0 == 1 then
				arg_283_0:Play426101067(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			local var_286_0 = 0
			local var_286_1 = 0.225

			if var_286_0 < arg_283_1.time_ and arg_283_1.time_ <= var_286_0 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, true)

				local var_286_2 = arg_283_1:FormatText(StoryNameCfg[7].name)

				arg_283_1.leftNameTxt_.text = var_286_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_283_1.leftNameTxt_.transform)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1.leftNameTxt_.text)
				SetActive(arg_283_1.iconTrs_.gameObject, true)
				arg_283_1.iconController_:SetSelectedState("hero")

				arg_283_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_283_1.callingController_:SetSelectedState("normal")

				arg_283_1.keyicon_.color = Color.New(1, 1, 1)
				arg_283_1.icon_.color = Color.New(1, 1, 1)

				local var_286_3 = arg_283_1:GetWordFromCfg(426101066)
				local var_286_4 = arg_283_1:FormatText(var_286_3.content)

				arg_283_1.text_.text = var_286_4

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_5 = 9
				local var_286_6 = utf8.len(var_286_4)
				local var_286_7 = var_286_5 <= 0 and var_286_1 or var_286_1 * (var_286_6 / var_286_5)

				if var_286_7 > 0 and var_286_1 < var_286_7 then
					arg_283_1.talkMaxDuration = var_286_7

					if var_286_7 + var_286_0 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_7 + var_286_0
					end
				end

				arg_283_1.text_.text = var_286_4
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)
				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_8 = math.max(var_286_1, arg_283_1.talkMaxDuration)

			if var_286_0 <= arg_283_1.time_ and arg_283_1.time_ < var_286_0 + var_286_8 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - var_286_0) / var_286_8

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= var_286_0 + var_286_8 and arg_283_1.time_ < var_286_0 + var_286_8 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {}

		arg_283_1:InitPlayNodeList()
	end,
	Play426101067 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 426101067
		arg_287_1.duration_ = 7.47

		local var_287_0 = {
			zh = 5.8,
			ja = 7.466
		}
		local var_287_1 = manager.audio:GetLocalizationFlag()

		if var_287_0[var_287_1] ~= nil then
			arg_287_1.duration_ = var_287_0[var_287_1]
		end

		SetActive(arg_287_1.tipsGo_, false)

		function arg_287_1.onSingleLineFinish_()
			arg_287_1.onSingleLineUpdate_ = nil
			arg_287_1.onSingleLineFinish_ = nil
			arg_287_1.state_ = "waiting"
		end

		function arg_287_1.playNext_(arg_289_0)
			if arg_289_0 == 1 then
				arg_287_0:Play426101068(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			local var_290_0 = arg_287_1.actors_["1054ui_story"].transform
			local var_290_1 = 0

			if var_290_1 < arg_287_1.time_ and arg_287_1.time_ <= var_290_1 + arg_290_0 then
				arg_287_1.var_.moveOldPos1054ui_story = var_290_0.localPosition

				local var_290_2 = GameObjectTools.GetOrAddComponent(var_290_0.gameObject, typeof(DynamicBoneHelper))

				if var_290_2 then
					var_290_2:EnableDynamicBone(false)
				end
			end

			local var_290_3 = 0.001

			if var_290_1 <= arg_287_1.time_ and arg_287_1.time_ < var_290_1 + var_290_3 then
				local var_290_4 = (arg_287_1.time_ - var_290_1) / var_290_3
				local var_290_5 = Vector3.New(0, -0.985, -6)

				var_290_0.localPosition = Vector3.Lerp(arg_287_1.var_.moveOldPos1054ui_story, var_290_5, var_290_4)

				local var_290_6 = manager.ui.mainCamera.transform.position - var_290_0.position

				var_290_0.forward = Vector3.New(var_290_6.x, var_290_6.y, var_290_6.z)

				local var_290_7 = var_290_0.localEulerAngles

				var_290_7.z = 0
				var_290_7.x = 0
				var_290_0.localEulerAngles = var_290_7
			end

			if arg_287_1.time_ >= var_290_1 + var_290_3 and arg_287_1.time_ < var_290_1 + var_290_3 + arg_290_0 then
				var_290_0.localPosition = Vector3.New(0, -0.985, -6)

				local var_290_8 = manager.ui.mainCamera.transform.position - var_290_0.position

				var_290_0.forward = Vector3.New(var_290_8.x, var_290_8.y, var_290_8.z)

				local var_290_9 = var_290_0.localEulerAngles

				var_290_9.z = 0
				var_290_9.x = 0
				var_290_0.localEulerAngles = var_290_9

				local var_290_10 = GameObjectTools.GetOrAddComponent(var_290_0.gameObject, typeof(DynamicBoneHelper))

				if var_290_10 then
					var_290_10:EnableDynamicBone(true)
				end
			end

			local var_290_11 = arg_287_1.actors_["1054ui_story"]
			local var_290_12 = 0

			if var_290_12 < arg_287_1.time_ and arg_287_1.time_ <= var_290_12 + arg_290_0 and not isNil(var_290_11) and arg_287_1.var_.characterEffect1054ui_story == nil then
				arg_287_1.var_.characterEffect1054ui_story = var_290_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_290_13 = 0.200000002980232

			if var_290_12 <= arg_287_1.time_ and arg_287_1.time_ < var_290_12 + var_290_13 and not isNil(var_290_11) then
				local var_290_14 = (arg_287_1.time_ - var_290_12) / var_290_13

				if arg_287_1.var_.characterEffect1054ui_story and not isNil(var_290_11) then
					arg_287_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_287_1.time_ >= var_290_12 + var_290_13 and arg_287_1.time_ < var_290_12 + var_290_13 + arg_290_0 and not isNil(var_290_11) and arg_287_1.var_.characterEffect1054ui_story then
				arg_287_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_290_15 = 0

			if var_290_15 < arg_287_1.time_ and arg_287_1.time_ <= var_290_15 + arg_290_0 then
				arg_287_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action4_1")
			end

			local var_290_16 = 0

			if var_290_16 < arg_287_1.time_ and arg_287_1.time_ <= var_290_16 + arg_290_0 then
				arg_287_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_290_17 = 0
			local var_290_18 = 0.475

			if var_290_17 < arg_287_1.time_ and arg_287_1.time_ <= var_290_17 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, true)

				local var_290_19 = arg_287_1:FormatText(StoryNameCfg[1487].name)

				arg_287_1.leftNameTxt_.text = var_290_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_287_1.leftNameTxt_.transform)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1.leftNameTxt_.text)
				SetActive(arg_287_1.iconTrs_.gameObject, false)
				arg_287_1.callingController_:SetSelectedState("normal")

				local var_290_20 = arg_287_1:GetWordFromCfg(426101067)
				local var_290_21 = arg_287_1:FormatText(var_290_20.content)

				arg_287_1.text_.text = var_290_21

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_22 = 19
				local var_290_23 = utf8.len(var_290_21)
				local var_290_24 = var_290_22 <= 0 and var_290_18 or var_290_18 * (var_290_23 / var_290_22)

				if var_290_24 > 0 and var_290_18 < var_290_24 then
					arg_287_1.talkMaxDuration = var_290_24

					if var_290_24 + var_290_17 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_24 + var_290_17
					end
				end

				arg_287_1.text_.text = var_290_21
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426101", "426101067", "story_v_out_426101.awb") ~= 0 then
					local var_290_25 = manager.audio:GetVoiceLength("story_v_out_426101", "426101067", "story_v_out_426101.awb") / 1000

					if var_290_25 + var_290_17 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_25 + var_290_17
					end

					if var_290_20.prefab_name ~= "" and arg_287_1.actors_[var_290_20.prefab_name] ~= nil then
						local var_290_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_287_1.actors_[var_290_20.prefab_name].transform, "story_v_out_426101", "426101067", "story_v_out_426101.awb")

						arg_287_1:RecordAudio("426101067", var_290_26)
						arg_287_1:RecordAudio("426101067", var_290_26)
					else
						arg_287_1:AudioAction("play", "voice", "story_v_out_426101", "426101067", "story_v_out_426101.awb")
					end

					arg_287_1:RecordHistoryTalkVoice("story_v_out_426101", "426101067", "story_v_out_426101.awb")
				end

				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_27 = math.max(var_290_18, arg_287_1.talkMaxDuration)

			if var_290_17 <= arg_287_1.time_ and arg_287_1.time_ < var_290_17 + var_290_27 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - var_290_17) / var_290_27

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= var_290_17 + var_290_27 and arg_287_1.time_ < var_290_17 + var_290_27 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_287_1:InitPlayNodeList()
	end,
	Play426101068 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 426101068
		arg_291_1.duration_ = 8.97

		local var_291_0 = {
			zh = 6.633,
			ja = 8.966
		}
		local var_291_1 = manager.audio:GetLocalizationFlag()

		if var_291_0[var_291_1] ~= nil then
			arg_291_1.duration_ = var_291_0[var_291_1]
		end

		SetActive(arg_291_1.tipsGo_, false)

		function arg_291_1.onSingleLineFinish_()
			arg_291_1.onSingleLineUpdate_ = nil
			arg_291_1.onSingleLineFinish_ = nil
			arg_291_1.state_ = "waiting"
		end

		function arg_291_1.playNext_(arg_293_0)
			if arg_293_0 == 1 then
				arg_291_0:Play426101069(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			local var_294_0 = "6148ui_story"

			if arg_291_1.actors_[var_294_0] == nil then
				local var_294_1 = Asset.Load("Char/" .. "6148ui_story")

				if not isNil(var_294_1) then
					local var_294_2 = Object.Instantiate(Asset.Load("Char/" .. "6148ui_story"), arg_291_1.stage_.transform)

					var_294_2.name = var_294_0
					var_294_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_291_1.actors_[var_294_0] = var_294_2

					local var_294_3 = var_294_2:GetComponentInChildren(typeof(CharacterEffect))

					var_294_3.enabled = true

					local var_294_4 = GameObjectTools.GetOrAddComponent(var_294_2, typeof(DynamicBoneHelper))

					if var_294_4 then
						var_294_4:EnableDynamicBone(false)
					end

					arg_291_1:ShowWeapon(var_294_3.transform, false)

					arg_291_1.var_[var_294_0 .. "Animator"] = var_294_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_291_1.var_[var_294_0 .. "Animator"].applyRootMotion = true
					arg_291_1.var_[var_294_0 .. "LipSync"] = var_294_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_294_5 = arg_291_1.actors_["6148ui_story"].transform
			local var_294_6 = 0

			if var_294_6 < arg_291_1.time_ and arg_291_1.time_ <= var_294_6 + arg_294_0 then
				arg_291_1.var_.moveOldPos6148ui_story = var_294_5.localPosition

				local var_294_7 = GameObjectTools.GetOrAddComponent(var_294_5.gameObject, typeof(DynamicBoneHelper))

				if var_294_7 then
					var_294_7:EnableDynamicBone(false)
				end
			end

			local var_294_8 = 0.001

			if var_294_6 <= arg_291_1.time_ and arg_291_1.time_ < var_294_6 + var_294_8 then
				local var_294_9 = (arg_291_1.time_ - var_294_6) / var_294_8
				local var_294_10 = Vector3.New(0, -0.985, -6)

				var_294_5.localPosition = Vector3.Lerp(arg_291_1.var_.moveOldPos6148ui_story, var_294_10, var_294_9)

				local var_294_11 = manager.ui.mainCamera.transform.position - var_294_5.position

				var_294_5.forward = Vector3.New(var_294_11.x, var_294_11.y, var_294_11.z)

				local var_294_12 = var_294_5.localEulerAngles

				var_294_12.z = 0
				var_294_12.x = 0
				var_294_5.localEulerAngles = var_294_12
			end

			if arg_291_1.time_ >= var_294_6 + var_294_8 and arg_291_1.time_ < var_294_6 + var_294_8 + arg_294_0 then
				var_294_5.localPosition = Vector3.New(0, -0.985, -6)

				local var_294_13 = manager.ui.mainCamera.transform.position - var_294_5.position

				var_294_5.forward = Vector3.New(var_294_13.x, var_294_13.y, var_294_13.z)

				local var_294_14 = var_294_5.localEulerAngles

				var_294_14.z = 0
				var_294_14.x = 0
				var_294_5.localEulerAngles = var_294_14

				local var_294_15 = GameObjectTools.GetOrAddComponent(var_294_5.gameObject, typeof(DynamicBoneHelper))

				if var_294_15 then
					var_294_15:EnableDynamicBone(true)
				end
			end

			local var_294_16 = arg_291_1.actors_["1054ui_story"].transform
			local var_294_17 = 0

			if var_294_17 < arg_291_1.time_ and arg_291_1.time_ <= var_294_17 + arg_294_0 then
				arg_291_1.var_.moveOldPos1054ui_story = var_294_16.localPosition

				local var_294_18 = GameObjectTools.GetOrAddComponent(var_294_16.gameObject, typeof(DynamicBoneHelper))

				if var_294_18 then
					var_294_18:EnableDynamicBone(false)
				end
			end

			local var_294_19 = 0.001

			if var_294_17 <= arg_291_1.time_ and arg_291_1.time_ < var_294_17 + var_294_19 then
				local var_294_20 = (arg_291_1.time_ - var_294_17) / var_294_19
				local var_294_21 = Vector3.New(0, 100, 0)

				var_294_16.localPosition = Vector3.Lerp(arg_291_1.var_.moveOldPos1054ui_story, var_294_21, var_294_20)

				local var_294_22 = manager.ui.mainCamera.transform.position - var_294_16.position

				var_294_16.forward = Vector3.New(var_294_22.x, var_294_22.y, var_294_22.z)

				local var_294_23 = var_294_16.localEulerAngles

				var_294_23.z = 0
				var_294_23.x = 0
				var_294_16.localEulerAngles = var_294_23
			end

			if arg_291_1.time_ >= var_294_17 + var_294_19 and arg_291_1.time_ < var_294_17 + var_294_19 + arg_294_0 then
				var_294_16.localPosition = Vector3.New(0, 100, 0)

				local var_294_24 = manager.ui.mainCamera.transform.position - var_294_16.position

				var_294_16.forward = Vector3.New(var_294_24.x, var_294_24.y, var_294_24.z)

				local var_294_25 = var_294_16.localEulerAngles

				var_294_25.z = 0
				var_294_25.x = 0
				var_294_16.localEulerAngles = var_294_25

				local var_294_26 = GameObjectTools.GetOrAddComponent(var_294_16.gameObject, typeof(DynamicBoneHelper))

				if var_294_26 then
					var_294_26:EnableDynamicBone(true)
				end
			end

			local var_294_27 = arg_291_1.actors_["6148ui_story"]
			local var_294_28 = 0

			if var_294_28 < arg_291_1.time_ and arg_291_1.time_ <= var_294_28 + arg_294_0 and not isNil(var_294_27) and arg_291_1.var_.characterEffect6148ui_story == nil then
				arg_291_1.var_.characterEffect6148ui_story = var_294_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_294_29 = 0.200000002980232

			if var_294_28 <= arg_291_1.time_ and arg_291_1.time_ < var_294_28 + var_294_29 and not isNil(var_294_27) then
				local var_294_30 = (arg_291_1.time_ - var_294_28) / var_294_29

				if arg_291_1.var_.characterEffect6148ui_story and not isNil(var_294_27) then
					arg_291_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_291_1.time_ >= var_294_28 + var_294_29 and arg_291_1.time_ < var_294_28 + var_294_29 + arg_294_0 and not isNil(var_294_27) and arg_291_1.var_.characterEffect6148ui_story then
				arg_291_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_294_31 = arg_291_1.actors_["1054ui_story"]
			local var_294_32 = 0

			if var_294_32 < arg_291_1.time_ and arg_291_1.time_ <= var_294_32 + arg_294_0 and not isNil(var_294_31) and arg_291_1.var_.characterEffect1054ui_story == nil then
				arg_291_1.var_.characterEffect1054ui_story = var_294_31:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_294_33 = 0.200000002980232

			if var_294_32 <= arg_291_1.time_ and arg_291_1.time_ < var_294_32 + var_294_33 and not isNil(var_294_31) then
				local var_294_34 = (arg_291_1.time_ - var_294_32) / var_294_33

				if arg_291_1.var_.characterEffect1054ui_story and not isNil(var_294_31) then
					local var_294_35 = Mathf.Lerp(0, 0.5, var_294_34)

					arg_291_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_291_1.var_.characterEffect1054ui_story.fillRatio = var_294_35
				end
			end

			if arg_291_1.time_ >= var_294_32 + var_294_33 and arg_291_1.time_ < var_294_32 + var_294_33 + arg_294_0 and not isNil(var_294_31) and arg_291_1.var_.characterEffect1054ui_story then
				local var_294_36 = 0.5

				arg_291_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_291_1.var_.characterEffect1054ui_story.fillRatio = var_294_36
			end

			local var_294_37 = 0

			if var_294_37 < arg_291_1.time_ and arg_291_1.time_ <= var_294_37 + arg_294_0 then
				arg_291_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action6_1")
			end

			local var_294_38 = 0

			if var_294_38 < arg_291_1.time_ and arg_291_1.time_ <= var_294_38 + arg_294_0 then
				arg_291_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoC", "EmotionTimelineAnimator")
			end

			local var_294_39 = 0
			local var_294_40 = 0.525

			if var_294_39 < arg_291_1.time_ and arg_291_1.time_ <= var_294_39 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0
				arg_291_1.dialogCg_.alpha = 1

				arg_291_1.dialog_:SetActive(true)
				SetActive(arg_291_1.leftNameGo_, true)

				local var_294_41 = arg_291_1:FormatText(StoryNameCfg[1488].name)

				arg_291_1.leftNameTxt_.text = var_294_41

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_291_1.leftNameTxt_.transform)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1.leftNameTxt_.text)
				SetActive(arg_291_1.iconTrs_.gameObject, false)
				arg_291_1.callingController_:SetSelectedState("normal")

				local var_294_42 = arg_291_1:GetWordFromCfg(426101068)
				local var_294_43 = arg_291_1:FormatText(var_294_42.content)

				arg_291_1.text_.text = var_294_43

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_44 = 21
				local var_294_45 = utf8.len(var_294_43)
				local var_294_46 = var_294_44 <= 0 and var_294_40 or var_294_40 * (var_294_45 / var_294_44)

				if var_294_46 > 0 and var_294_40 < var_294_46 then
					arg_291_1.talkMaxDuration = var_294_46

					if var_294_46 + var_294_39 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_46 + var_294_39
					end
				end

				arg_291_1.text_.text = var_294_43
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426101", "426101068", "story_v_out_426101.awb") ~= 0 then
					local var_294_47 = manager.audio:GetVoiceLength("story_v_out_426101", "426101068", "story_v_out_426101.awb") / 1000

					if var_294_47 + var_294_39 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_47 + var_294_39
					end

					if var_294_42.prefab_name ~= "" and arg_291_1.actors_[var_294_42.prefab_name] ~= nil then
						local var_294_48 = LuaForUtil.PlayVoiceWithCriLipsync(arg_291_1.actors_[var_294_42.prefab_name].transform, "story_v_out_426101", "426101068", "story_v_out_426101.awb")

						arg_291_1:RecordAudio("426101068", var_294_48)
						arg_291_1:RecordAudio("426101068", var_294_48)
					else
						arg_291_1:AudioAction("play", "voice", "story_v_out_426101", "426101068", "story_v_out_426101.awb")
					end

					arg_291_1:RecordHistoryTalkVoice("story_v_out_426101", "426101068", "story_v_out_426101.awb")
				end

				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_49 = math.max(var_294_40, arg_291_1.talkMaxDuration)

			if var_294_39 <= arg_291_1.time_ and arg_291_1.time_ < var_294_39 + var_294_49 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - var_294_39) / var_294_49

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= var_294_39 + var_294_49 and arg_291_1.time_ < var_294_39 + var_294_49 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end

		arg_291_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_291_1:InitPlayNodeList()
	end,
	Play426101069 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 426101069
		arg_295_1.duration_ = 5

		SetActive(arg_295_1.tipsGo_, false)

		function arg_295_1.onSingleLineFinish_()
			arg_295_1.onSingleLineUpdate_ = nil
			arg_295_1.onSingleLineFinish_ = nil
			arg_295_1.state_ = "waiting"
		end

		function arg_295_1.playNext_(arg_297_0)
			if arg_297_0 == 1 then
				arg_295_0:Play426101070(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			local var_298_0 = arg_295_1.actors_["6148ui_story"]
			local var_298_1 = 0

			if var_298_1 < arg_295_1.time_ and arg_295_1.time_ <= var_298_1 + arg_298_0 and not isNil(var_298_0) and arg_295_1.var_.characterEffect6148ui_story == nil then
				arg_295_1.var_.characterEffect6148ui_story = var_298_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_298_2 = 0.200000002980232

			if var_298_1 <= arg_295_1.time_ and arg_295_1.time_ < var_298_1 + var_298_2 and not isNil(var_298_0) then
				local var_298_3 = (arg_295_1.time_ - var_298_1) / var_298_2

				if arg_295_1.var_.characterEffect6148ui_story and not isNil(var_298_0) then
					local var_298_4 = Mathf.Lerp(0, 0.5, var_298_3)

					arg_295_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_295_1.var_.characterEffect6148ui_story.fillRatio = var_298_4
				end
			end

			if arg_295_1.time_ >= var_298_1 + var_298_2 and arg_295_1.time_ < var_298_1 + var_298_2 + arg_298_0 and not isNil(var_298_0) and arg_295_1.var_.characterEffect6148ui_story then
				local var_298_5 = 0.5

				arg_295_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_295_1.var_.characterEffect6148ui_story.fillRatio = var_298_5
			end

			local var_298_6 = arg_295_1.actors_["6148ui_story"].transform
			local var_298_7 = 0

			if var_298_7 < arg_295_1.time_ and arg_295_1.time_ <= var_298_7 + arg_298_0 then
				arg_295_1.var_.moveOldPos6148ui_story = var_298_6.localPosition

				local var_298_8 = GameObjectTools.GetOrAddComponent(var_298_6.gameObject, typeof(DynamicBoneHelper))

				if var_298_8 then
					var_298_8:EnableDynamicBone(false)
				end
			end

			local var_298_9 = 0.001

			if var_298_7 <= arg_295_1.time_ and arg_295_1.time_ < var_298_7 + var_298_9 then
				local var_298_10 = (arg_295_1.time_ - var_298_7) / var_298_9
				local var_298_11 = Vector3.New(0, 100, 0)

				var_298_6.localPosition = Vector3.Lerp(arg_295_1.var_.moveOldPos6148ui_story, var_298_11, var_298_10)

				local var_298_12 = manager.ui.mainCamera.transform.position - var_298_6.position

				var_298_6.forward = Vector3.New(var_298_12.x, var_298_12.y, var_298_12.z)

				local var_298_13 = var_298_6.localEulerAngles

				var_298_13.z = 0
				var_298_13.x = 0
				var_298_6.localEulerAngles = var_298_13
			end

			if arg_295_1.time_ >= var_298_7 + var_298_9 and arg_295_1.time_ < var_298_7 + var_298_9 + arg_298_0 then
				var_298_6.localPosition = Vector3.New(0, 100, 0)

				local var_298_14 = manager.ui.mainCamera.transform.position - var_298_6.position

				var_298_6.forward = Vector3.New(var_298_14.x, var_298_14.y, var_298_14.z)

				local var_298_15 = var_298_6.localEulerAngles

				var_298_15.z = 0
				var_298_15.x = 0
				var_298_6.localEulerAngles = var_298_15

				local var_298_16 = GameObjectTools.GetOrAddComponent(var_298_6.gameObject, typeof(DynamicBoneHelper))

				if var_298_16 then
					var_298_16:EnableDynamicBone(true)
				end
			end

			local var_298_17 = 0
			local var_298_18 = 0.85

			if var_298_17 < arg_295_1.time_ and arg_295_1.time_ <= var_298_17 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, false)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_295_1.iconTrs_.gameObject, false)
				arg_295_1.callingController_:SetSelectedState("normal")

				local var_298_19 = arg_295_1:GetWordFromCfg(426101069)
				local var_298_20 = arg_295_1:FormatText(var_298_19.content)

				arg_295_1.text_.text = var_298_20

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_21 = 34
				local var_298_22 = utf8.len(var_298_20)
				local var_298_23 = var_298_21 <= 0 and var_298_18 or var_298_18 * (var_298_22 / var_298_21)

				if var_298_23 > 0 and var_298_18 < var_298_23 then
					arg_295_1.talkMaxDuration = var_298_23

					if var_298_23 + var_298_17 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_23 + var_298_17
					end
				end

				arg_295_1.text_.text = var_298_20
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)
				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_24 = math.max(var_298_18, arg_295_1.talkMaxDuration)

			if var_298_17 <= arg_295_1.time_ and arg_295_1.time_ < var_298_17 + var_298_24 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - var_298_17) / var_298_24

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= var_298_17 + var_298_24 and arg_295_1.time_ < var_298_17 + var_298_24 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_295_1:InitPlayNodeList()
	end,
	Play426101070 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 426101070
		arg_299_1.duration_ = 5

		SetActive(arg_299_1.tipsGo_, false)

		function arg_299_1.onSingleLineFinish_()
			arg_299_1.onSingleLineUpdate_ = nil
			arg_299_1.onSingleLineFinish_ = nil
			arg_299_1.state_ = "waiting"
		end

		function arg_299_1.playNext_(arg_301_0)
			if arg_301_0 == 1 then
				arg_299_0:Play426101071(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			local var_302_0 = 0
			local var_302_1 = 0.95

			if var_302_0 < arg_299_1.time_ and arg_299_1.time_ <= var_302_0 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0
				arg_299_1.dialogCg_.alpha = 1

				arg_299_1.dialog_:SetActive(true)
				SetActive(arg_299_1.leftNameGo_, false)

				arg_299_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_299_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_299_1:RecordName(arg_299_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_299_1.iconTrs_.gameObject, false)
				arg_299_1.callingController_:SetSelectedState("normal")

				local var_302_2 = arg_299_1:GetWordFromCfg(426101070)
				local var_302_3 = arg_299_1:FormatText(var_302_2.content)

				arg_299_1.text_.text = var_302_3

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_4 = 38
				local var_302_5 = utf8.len(var_302_3)
				local var_302_6 = var_302_4 <= 0 and var_302_1 or var_302_1 * (var_302_5 / var_302_4)

				if var_302_6 > 0 and var_302_1 < var_302_6 then
					arg_299_1.talkMaxDuration = var_302_6

					if var_302_6 + var_302_0 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_6 + var_302_0
					end
				end

				arg_299_1.text_.text = var_302_3
				arg_299_1.typewritter.percent = 0

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(false)
				arg_299_1:RecordContent(arg_299_1.text_.text)
			end

			local var_302_7 = math.max(var_302_1, arg_299_1.talkMaxDuration)

			if var_302_0 <= arg_299_1.time_ and arg_299_1.time_ < var_302_0 + var_302_7 then
				arg_299_1.typewritter.percent = (arg_299_1.time_ - var_302_0) / var_302_7

				arg_299_1.typewritter:SetDirty()
			end

			if arg_299_1.time_ >= var_302_0 + var_302_7 and arg_299_1.time_ < var_302_0 + var_302_7 + arg_302_0 then
				arg_299_1.typewritter.percent = 1

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(true)
			end
		end

		arg_299_1.nodeConfigList_ = {}

		arg_299_1:InitPlayNodeList()
	end,
	Play426101071 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 426101071
		arg_303_1.duration_ = 8.17

		local var_303_0 = {
			zh = 8.166,
			ja = 7.9
		}
		local var_303_1 = manager.audio:GetLocalizationFlag()

		if var_303_0[var_303_1] ~= nil then
			arg_303_1.duration_ = var_303_0[var_303_1]
		end

		SetActive(arg_303_1.tipsGo_, false)

		function arg_303_1.onSingleLineFinish_()
			arg_303_1.onSingleLineUpdate_ = nil
			arg_303_1.onSingleLineFinish_ = nil
			arg_303_1.state_ = "waiting"
		end

		function arg_303_1.playNext_(arg_305_0)
			if arg_305_0 == 1 then
				arg_303_0:Play426101072(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			local var_306_0 = arg_303_1.actors_["6148ui_story"].transform
			local var_306_1 = 0

			if var_306_1 < arg_303_1.time_ and arg_303_1.time_ <= var_306_1 + arg_306_0 then
				arg_303_1.var_.moveOldPos6148ui_story = var_306_0.localPosition

				local var_306_2 = GameObjectTools.GetOrAddComponent(var_306_0.gameObject, typeof(DynamicBoneHelper))

				if var_306_2 then
					var_306_2:EnableDynamicBone(false)
				end
			end

			local var_306_3 = 0.001

			if var_306_1 <= arg_303_1.time_ and arg_303_1.time_ < var_306_1 + var_306_3 then
				local var_306_4 = (arg_303_1.time_ - var_306_1) / var_306_3
				local var_306_5 = Vector3.New(0, -0.985, -6)

				var_306_0.localPosition = Vector3.Lerp(arg_303_1.var_.moveOldPos6148ui_story, var_306_5, var_306_4)

				local var_306_6 = manager.ui.mainCamera.transform.position - var_306_0.position

				var_306_0.forward = Vector3.New(var_306_6.x, var_306_6.y, var_306_6.z)

				local var_306_7 = var_306_0.localEulerAngles

				var_306_7.z = 0
				var_306_7.x = 0
				var_306_0.localEulerAngles = var_306_7
			end

			if arg_303_1.time_ >= var_306_1 + var_306_3 and arg_303_1.time_ < var_306_1 + var_306_3 + arg_306_0 then
				var_306_0.localPosition = Vector3.New(0, -0.985, -6)

				local var_306_8 = manager.ui.mainCamera.transform.position - var_306_0.position

				var_306_0.forward = Vector3.New(var_306_8.x, var_306_8.y, var_306_8.z)

				local var_306_9 = var_306_0.localEulerAngles

				var_306_9.z = 0
				var_306_9.x = 0
				var_306_0.localEulerAngles = var_306_9

				local var_306_10 = GameObjectTools.GetOrAddComponent(var_306_0.gameObject, typeof(DynamicBoneHelper))

				if var_306_10 then
					var_306_10:EnableDynamicBone(true)
				end
			end

			local var_306_11 = arg_303_1.actors_["6148ui_story"]
			local var_306_12 = 0

			if var_306_12 < arg_303_1.time_ and arg_303_1.time_ <= var_306_12 + arg_306_0 and not isNil(var_306_11) and arg_303_1.var_.characterEffect6148ui_story == nil then
				arg_303_1.var_.characterEffect6148ui_story = var_306_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_306_13 = 0.200000002980232

			if var_306_12 <= arg_303_1.time_ and arg_303_1.time_ < var_306_12 + var_306_13 and not isNil(var_306_11) then
				local var_306_14 = (arg_303_1.time_ - var_306_12) / var_306_13

				if arg_303_1.var_.characterEffect6148ui_story and not isNil(var_306_11) then
					arg_303_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_303_1.time_ >= var_306_12 + var_306_13 and arg_303_1.time_ < var_306_12 + var_306_13 + arg_306_0 and not isNil(var_306_11) and arg_303_1.var_.characterEffect6148ui_story then
				arg_303_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_306_15 = 0

			if var_306_15 < arg_303_1.time_ and arg_303_1.time_ <= var_306_15 + arg_306_0 then
				arg_303_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action6_2")
			end

			local var_306_16 = 0
			local var_306_17 = 0.7

			if var_306_16 < arg_303_1.time_ and arg_303_1.time_ <= var_306_16 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0
				arg_303_1.dialogCg_.alpha = 1

				arg_303_1.dialog_:SetActive(true)
				SetActive(arg_303_1.leftNameGo_, true)

				local var_306_18 = arg_303_1:FormatText(StoryNameCfg[1488].name)

				arg_303_1.leftNameTxt_.text = var_306_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_303_1.leftNameTxt_.transform)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1.leftNameTxt_.text)
				SetActive(arg_303_1.iconTrs_.gameObject, false)
				arg_303_1.callingController_:SetSelectedState("normal")

				local var_306_19 = arg_303_1:GetWordFromCfg(426101071)
				local var_306_20 = arg_303_1:FormatText(var_306_19.content)

				arg_303_1.text_.text = var_306_20

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_21 = 28
				local var_306_22 = utf8.len(var_306_20)
				local var_306_23 = var_306_21 <= 0 and var_306_17 or var_306_17 * (var_306_22 / var_306_21)

				if var_306_23 > 0 and var_306_17 < var_306_23 then
					arg_303_1.talkMaxDuration = var_306_23

					if var_306_23 + var_306_16 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_23 + var_306_16
					end
				end

				arg_303_1.text_.text = var_306_20
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426101", "426101071", "story_v_out_426101.awb") ~= 0 then
					local var_306_24 = manager.audio:GetVoiceLength("story_v_out_426101", "426101071", "story_v_out_426101.awb") / 1000

					if var_306_24 + var_306_16 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_24 + var_306_16
					end

					if var_306_19.prefab_name ~= "" and arg_303_1.actors_[var_306_19.prefab_name] ~= nil then
						local var_306_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_303_1.actors_[var_306_19.prefab_name].transform, "story_v_out_426101", "426101071", "story_v_out_426101.awb")

						arg_303_1:RecordAudio("426101071", var_306_25)
						arg_303_1:RecordAudio("426101071", var_306_25)
					else
						arg_303_1:AudioAction("play", "voice", "story_v_out_426101", "426101071", "story_v_out_426101.awb")
					end

					arg_303_1:RecordHistoryTalkVoice("story_v_out_426101", "426101071", "story_v_out_426101.awb")
				end

				arg_303_1:RecordContent(arg_303_1.text_.text)
			end

			local var_306_26 = math.max(var_306_17, arg_303_1.talkMaxDuration)

			if var_306_16 <= arg_303_1.time_ and arg_303_1.time_ < var_306_16 + var_306_26 then
				arg_303_1.typewritter.percent = (arg_303_1.time_ - var_306_16) / var_306_26

				arg_303_1.typewritter:SetDirty()
			end

			if arg_303_1.time_ >= var_306_16 + var_306_26 and arg_303_1.time_ < var_306_16 + var_306_26 + arg_306_0 then
				arg_303_1.typewritter.percent = 1

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(true)
			end
		end

		arg_303_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_303_1:InitPlayNodeList()
	end,
	Play426101072 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 426101072
		arg_307_1.duration_ = 5

		SetActive(arg_307_1.tipsGo_, false)

		function arg_307_1.onSingleLineFinish_()
			arg_307_1.onSingleLineUpdate_ = nil
			arg_307_1.onSingleLineFinish_ = nil
			arg_307_1.state_ = "waiting"
		end

		function arg_307_1.playNext_(arg_309_0)
			if arg_309_0 == 1 then
				arg_307_0:Play426101073(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			local var_310_0 = arg_307_1.actors_["6148ui_story"]
			local var_310_1 = 0

			if var_310_1 < arg_307_1.time_ and arg_307_1.time_ <= var_310_1 + arg_310_0 and not isNil(var_310_0) and arg_307_1.var_.characterEffect6148ui_story == nil then
				arg_307_1.var_.characterEffect6148ui_story = var_310_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_310_2 = 0.200000002980232

			if var_310_1 <= arg_307_1.time_ and arg_307_1.time_ < var_310_1 + var_310_2 and not isNil(var_310_0) then
				local var_310_3 = (arg_307_1.time_ - var_310_1) / var_310_2

				if arg_307_1.var_.characterEffect6148ui_story and not isNil(var_310_0) then
					local var_310_4 = Mathf.Lerp(0, 0.5, var_310_3)

					arg_307_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_307_1.var_.characterEffect6148ui_story.fillRatio = var_310_4
				end
			end

			if arg_307_1.time_ >= var_310_1 + var_310_2 and arg_307_1.time_ < var_310_1 + var_310_2 + arg_310_0 and not isNil(var_310_0) and arg_307_1.var_.characterEffect6148ui_story then
				local var_310_5 = 0.5

				arg_307_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_307_1.var_.characterEffect6148ui_story.fillRatio = var_310_5
			end

			local var_310_6 = 0
			local var_310_7 = 0.35

			if var_310_6 < arg_307_1.time_ and arg_307_1.time_ <= var_310_6 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0
				arg_307_1.dialogCg_.alpha = 1

				arg_307_1.dialog_:SetActive(true)
				SetActive(arg_307_1.leftNameGo_, true)

				local var_310_8 = arg_307_1:FormatText(StoryNameCfg[7].name)

				arg_307_1.leftNameTxt_.text = var_310_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_307_1.leftNameTxt_.transform)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1.leftNameTxt_.text)
				SetActive(arg_307_1.iconTrs_.gameObject, true)
				arg_307_1.iconController_:SetSelectedState("hero")

				arg_307_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_307_1.callingController_:SetSelectedState("normal")

				arg_307_1.keyicon_.color = Color.New(1, 1, 1)
				arg_307_1.icon_.color = Color.New(1, 1, 1)

				local var_310_9 = arg_307_1:GetWordFromCfg(426101072)
				local var_310_10 = arg_307_1:FormatText(var_310_9.content)

				arg_307_1.text_.text = var_310_10

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_11 = 14
				local var_310_12 = utf8.len(var_310_10)
				local var_310_13 = var_310_11 <= 0 and var_310_7 or var_310_7 * (var_310_12 / var_310_11)

				if var_310_13 > 0 and var_310_7 < var_310_13 then
					arg_307_1.talkMaxDuration = var_310_13

					if var_310_13 + var_310_6 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_13 + var_310_6
					end
				end

				arg_307_1.text_.text = var_310_10
				arg_307_1.typewritter.percent = 0

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(false)
				arg_307_1:RecordContent(arg_307_1.text_.text)
			end

			local var_310_14 = math.max(var_310_7, arg_307_1.talkMaxDuration)

			if var_310_6 <= arg_307_1.time_ and arg_307_1.time_ < var_310_6 + var_310_14 then
				arg_307_1.typewritter.percent = (arg_307_1.time_ - var_310_6) / var_310_14

				arg_307_1.typewritter:SetDirty()
			end

			if arg_307_1.time_ >= var_310_6 + var_310_14 and arg_307_1.time_ < var_310_6 + var_310_14 + arg_310_0 then
				arg_307_1.typewritter.percent = 1

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(true)
			end
		end

		arg_307_1.nodeConfigList_ = {}

		arg_307_1:InitPlayNodeList()
	end,
	Play426101073 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 426101073
		arg_311_1.duration_ = 8.93

		local var_311_0 = {
			zh = 8.133,
			ja = 8.933
		}
		local var_311_1 = manager.audio:GetLocalizationFlag()

		if var_311_0[var_311_1] ~= nil then
			arg_311_1.duration_ = var_311_0[var_311_1]
		end

		SetActive(arg_311_1.tipsGo_, false)

		function arg_311_1.onSingleLineFinish_()
			arg_311_1.onSingleLineUpdate_ = nil
			arg_311_1.onSingleLineFinish_ = nil
			arg_311_1.state_ = "waiting"
		end

		function arg_311_1.playNext_(arg_313_0)
			if arg_313_0 == 1 then
				arg_311_0:Play426101074(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			local var_314_0 = arg_311_1.actors_["6148ui_story"].transform
			local var_314_1 = 0

			if var_314_1 < arg_311_1.time_ and arg_311_1.time_ <= var_314_1 + arg_314_0 then
				arg_311_1.var_.moveOldPos6148ui_story = var_314_0.localPosition

				local var_314_2 = GameObjectTools.GetOrAddComponent(var_314_0.gameObject, typeof(DynamicBoneHelper))

				if var_314_2 then
					var_314_2:EnableDynamicBone(false)
				end
			end

			local var_314_3 = 0.001

			if var_314_1 <= arg_311_1.time_ and arg_311_1.time_ < var_314_1 + var_314_3 then
				local var_314_4 = (arg_311_1.time_ - var_314_1) / var_314_3
				local var_314_5 = Vector3.New(0, -0.985, -6)

				var_314_0.localPosition = Vector3.Lerp(arg_311_1.var_.moveOldPos6148ui_story, var_314_5, var_314_4)

				local var_314_6 = manager.ui.mainCamera.transform.position - var_314_0.position

				var_314_0.forward = Vector3.New(var_314_6.x, var_314_6.y, var_314_6.z)

				local var_314_7 = var_314_0.localEulerAngles

				var_314_7.z = 0
				var_314_7.x = 0
				var_314_0.localEulerAngles = var_314_7
			end

			if arg_311_1.time_ >= var_314_1 + var_314_3 and arg_311_1.time_ < var_314_1 + var_314_3 + arg_314_0 then
				var_314_0.localPosition = Vector3.New(0, -0.985, -6)

				local var_314_8 = manager.ui.mainCamera.transform.position - var_314_0.position

				var_314_0.forward = Vector3.New(var_314_8.x, var_314_8.y, var_314_8.z)

				local var_314_9 = var_314_0.localEulerAngles

				var_314_9.z = 0
				var_314_9.x = 0
				var_314_0.localEulerAngles = var_314_9

				local var_314_10 = GameObjectTools.GetOrAddComponent(var_314_0.gameObject, typeof(DynamicBoneHelper))

				if var_314_10 then
					var_314_10:EnableDynamicBone(true)
				end
			end

			local var_314_11 = arg_311_1.actors_["6148ui_story"]
			local var_314_12 = 0

			if var_314_12 < arg_311_1.time_ and arg_311_1.time_ <= var_314_12 + arg_314_0 and not isNil(var_314_11) and arg_311_1.var_.characterEffect6148ui_story == nil then
				arg_311_1.var_.characterEffect6148ui_story = var_314_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_314_13 = 0.200000002980232

			if var_314_12 <= arg_311_1.time_ and arg_311_1.time_ < var_314_12 + var_314_13 and not isNil(var_314_11) then
				local var_314_14 = (arg_311_1.time_ - var_314_12) / var_314_13

				if arg_311_1.var_.characterEffect6148ui_story and not isNil(var_314_11) then
					arg_311_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_311_1.time_ >= var_314_12 + var_314_13 and arg_311_1.time_ < var_314_12 + var_314_13 + arg_314_0 and not isNil(var_314_11) and arg_311_1.var_.characterEffect6148ui_story then
				arg_311_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_314_15 = 0

			if var_314_15 < arg_311_1.time_ and arg_311_1.time_ <= var_314_15 + arg_314_0 then
				arg_311_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action4_1")
			end

			local var_314_16 = 0
			local var_314_17 = 0.75

			if var_314_16 < arg_311_1.time_ and arg_311_1.time_ <= var_314_16 + arg_314_0 then
				arg_311_1.talkMaxDuration = 0
				arg_311_1.dialogCg_.alpha = 1

				arg_311_1.dialog_:SetActive(true)
				SetActive(arg_311_1.leftNameGo_, true)

				local var_314_18 = arg_311_1:FormatText(StoryNameCfg[1488].name)

				arg_311_1.leftNameTxt_.text = var_314_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_311_1.leftNameTxt_.transform)

				arg_311_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_311_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_311_1:RecordName(arg_311_1.leftNameTxt_.text)
				SetActive(arg_311_1.iconTrs_.gameObject, false)
				arg_311_1.callingController_:SetSelectedState("normal")

				local var_314_19 = arg_311_1:GetWordFromCfg(426101073)
				local var_314_20 = arg_311_1:FormatText(var_314_19.content)

				arg_311_1.text_.text = var_314_20

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_21 = 30
				local var_314_22 = utf8.len(var_314_20)
				local var_314_23 = var_314_21 <= 0 and var_314_17 or var_314_17 * (var_314_22 / var_314_21)

				if var_314_23 > 0 and var_314_17 < var_314_23 then
					arg_311_1.talkMaxDuration = var_314_23

					if var_314_23 + var_314_16 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_23 + var_314_16
					end
				end

				arg_311_1.text_.text = var_314_20
				arg_311_1.typewritter.percent = 0

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426101", "426101073", "story_v_out_426101.awb") ~= 0 then
					local var_314_24 = manager.audio:GetVoiceLength("story_v_out_426101", "426101073", "story_v_out_426101.awb") / 1000

					if var_314_24 + var_314_16 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_24 + var_314_16
					end

					if var_314_19.prefab_name ~= "" and arg_311_1.actors_[var_314_19.prefab_name] ~= nil then
						local var_314_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_311_1.actors_[var_314_19.prefab_name].transform, "story_v_out_426101", "426101073", "story_v_out_426101.awb")

						arg_311_1:RecordAudio("426101073", var_314_25)
						arg_311_1:RecordAudio("426101073", var_314_25)
					else
						arg_311_1:AudioAction("play", "voice", "story_v_out_426101", "426101073", "story_v_out_426101.awb")
					end

					arg_311_1:RecordHistoryTalkVoice("story_v_out_426101", "426101073", "story_v_out_426101.awb")
				end

				arg_311_1:RecordContent(arg_311_1.text_.text)
			end

			local var_314_26 = math.max(var_314_17, arg_311_1.talkMaxDuration)

			if var_314_16 <= arg_311_1.time_ and arg_311_1.time_ < var_314_16 + var_314_26 then
				arg_311_1.typewritter.percent = (arg_311_1.time_ - var_314_16) / var_314_26

				arg_311_1.typewritter:SetDirty()
			end

			if arg_311_1.time_ >= var_314_16 + var_314_26 and arg_311_1.time_ < var_314_16 + var_314_26 + arg_314_0 then
				arg_311_1.typewritter.percent = 1

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(true)
			end
		end

		arg_311_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_311_1:InitPlayNodeList()
	end,
	Play426101074 = function(arg_315_0, arg_315_1)
		arg_315_1.time_ = 0
		arg_315_1.frameCnt_ = 0
		arg_315_1.state_ = "playing"
		arg_315_1.curTalkId_ = 426101074
		arg_315_1.duration_ = 3.53

		local var_315_0 = {
			zh = 3.133,
			ja = 3.533
		}
		local var_315_1 = manager.audio:GetLocalizationFlag()

		if var_315_0[var_315_1] ~= nil then
			arg_315_1.duration_ = var_315_0[var_315_1]
		end

		SetActive(arg_315_1.tipsGo_, false)

		function arg_315_1.onSingleLineFinish_()
			arg_315_1.onSingleLineUpdate_ = nil
			arg_315_1.onSingleLineFinish_ = nil
			arg_315_1.state_ = "waiting"
		end

		function arg_315_1.playNext_(arg_317_0)
			if arg_317_0 == 1 then
				arg_315_0:Play426101075(arg_315_1)
			end
		end

		function arg_315_1.onSingleLineUpdate_(arg_318_0)
			local var_318_0 = arg_315_1.actors_["1054ui_story"].transform
			local var_318_1 = 0

			if var_318_1 < arg_315_1.time_ and arg_315_1.time_ <= var_318_1 + arg_318_0 then
				arg_315_1.var_.moveOldPos1054ui_story = var_318_0.localPosition

				local var_318_2 = GameObjectTools.GetOrAddComponent(var_318_0.gameObject, typeof(DynamicBoneHelper))

				if var_318_2 then
					var_318_2:EnableDynamicBone(false)
				end
			end

			local var_318_3 = 0.001

			if var_318_1 <= arg_315_1.time_ and arg_315_1.time_ < var_318_1 + var_318_3 then
				local var_318_4 = (arg_315_1.time_ - var_318_1) / var_318_3
				local var_318_5 = Vector3.New(0.7, -0.985, -6)

				var_318_0.localPosition = Vector3.Lerp(arg_315_1.var_.moveOldPos1054ui_story, var_318_5, var_318_4)

				local var_318_6 = manager.ui.mainCamera.transform.position - var_318_0.position

				var_318_0.forward = Vector3.New(var_318_6.x, var_318_6.y, var_318_6.z)

				local var_318_7 = var_318_0.localEulerAngles

				var_318_7.z = 0
				var_318_7.x = 0
				var_318_0.localEulerAngles = var_318_7
			end

			if arg_315_1.time_ >= var_318_1 + var_318_3 and arg_315_1.time_ < var_318_1 + var_318_3 + arg_318_0 then
				var_318_0.localPosition = Vector3.New(0.7, -0.985, -6)

				local var_318_8 = manager.ui.mainCamera.transform.position - var_318_0.position

				var_318_0.forward = Vector3.New(var_318_8.x, var_318_8.y, var_318_8.z)

				local var_318_9 = var_318_0.localEulerAngles

				var_318_9.z = 0
				var_318_9.x = 0
				var_318_0.localEulerAngles = var_318_9

				local var_318_10 = GameObjectTools.GetOrAddComponent(var_318_0.gameObject, typeof(DynamicBoneHelper))

				if var_318_10 then
					var_318_10:EnableDynamicBone(true)
				end
			end

			local var_318_11 = arg_315_1.actors_["6148ui_story"].transform
			local var_318_12 = 0

			if var_318_12 < arg_315_1.time_ and arg_315_1.time_ <= var_318_12 + arg_318_0 then
				arg_315_1.var_.moveOldPos6148ui_story = var_318_11.localPosition

				local var_318_13 = GameObjectTools.GetOrAddComponent(var_318_11.gameObject, typeof(DynamicBoneHelper))

				if var_318_13 then
					var_318_13:EnableDynamicBone(false)
				end
			end

			local var_318_14 = 0.001

			if var_318_12 <= arg_315_1.time_ and arg_315_1.time_ < var_318_12 + var_318_14 then
				local var_318_15 = (arg_315_1.time_ - var_318_12) / var_318_14
				local var_318_16 = Vector3.New(-0.7, -0.985, -6)

				var_318_11.localPosition = Vector3.Lerp(arg_315_1.var_.moveOldPos6148ui_story, var_318_16, var_318_15)

				local var_318_17 = manager.ui.mainCamera.transform.position - var_318_11.position

				var_318_11.forward = Vector3.New(var_318_17.x, var_318_17.y, var_318_17.z)

				local var_318_18 = var_318_11.localEulerAngles

				var_318_18.z = 0
				var_318_18.x = 0
				var_318_11.localEulerAngles = var_318_18
			end

			if arg_315_1.time_ >= var_318_12 + var_318_14 and arg_315_1.time_ < var_318_12 + var_318_14 + arg_318_0 then
				var_318_11.localPosition = Vector3.New(-0.7, -0.985, -6)

				local var_318_19 = manager.ui.mainCamera.transform.position - var_318_11.position

				var_318_11.forward = Vector3.New(var_318_19.x, var_318_19.y, var_318_19.z)

				local var_318_20 = var_318_11.localEulerAngles

				var_318_20.z = 0
				var_318_20.x = 0
				var_318_11.localEulerAngles = var_318_20

				local var_318_21 = GameObjectTools.GetOrAddComponent(var_318_11.gameObject, typeof(DynamicBoneHelper))

				if var_318_21 then
					var_318_21:EnableDynamicBone(true)
				end
			end

			local var_318_22 = arg_315_1.actors_["1054ui_story"]
			local var_318_23 = 0

			if var_318_23 < arg_315_1.time_ and arg_315_1.time_ <= var_318_23 + arg_318_0 and not isNil(var_318_22) and arg_315_1.var_.characterEffect1054ui_story == nil then
				arg_315_1.var_.characterEffect1054ui_story = var_318_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_318_24 = 0.200000002980232

			if var_318_23 <= arg_315_1.time_ and arg_315_1.time_ < var_318_23 + var_318_24 and not isNil(var_318_22) then
				local var_318_25 = (arg_315_1.time_ - var_318_23) / var_318_24

				if arg_315_1.var_.characterEffect1054ui_story and not isNil(var_318_22) then
					arg_315_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_315_1.time_ >= var_318_23 + var_318_24 and arg_315_1.time_ < var_318_23 + var_318_24 + arg_318_0 and not isNil(var_318_22) and arg_315_1.var_.characterEffect1054ui_story then
				arg_315_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_318_26 = arg_315_1.actors_["6148ui_story"]
			local var_318_27 = 0

			if var_318_27 < arg_315_1.time_ and arg_315_1.time_ <= var_318_27 + arg_318_0 and not isNil(var_318_26) and arg_315_1.var_.characterEffect6148ui_story == nil then
				arg_315_1.var_.characterEffect6148ui_story = var_318_26:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_318_28 = 0.200000002980232

			if var_318_27 <= arg_315_1.time_ and arg_315_1.time_ < var_318_27 + var_318_28 and not isNil(var_318_26) then
				local var_318_29 = (arg_315_1.time_ - var_318_27) / var_318_28

				if arg_315_1.var_.characterEffect6148ui_story and not isNil(var_318_26) then
					local var_318_30 = Mathf.Lerp(0, 0.5, var_318_29)

					arg_315_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_315_1.var_.characterEffect6148ui_story.fillRatio = var_318_30
				end
			end

			if arg_315_1.time_ >= var_318_27 + var_318_28 and arg_315_1.time_ < var_318_27 + var_318_28 + arg_318_0 and not isNil(var_318_26) and arg_315_1.var_.characterEffect6148ui_story then
				local var_318_31 = 0.5

				arg_315_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_315_1.var_.characterEffect6148ui_story.fillRatio = var_318_31
			end

			local var_318_32 = 0

			if var_318_32 < arg_315_1.time_ and arg_315_1.time_ <= var_318_32 + arg_318_0 then
				arg_315_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action5_1")
			end

			local var_318_33 = 0

			if var_318_33 < arg_315_1.time_ and arg_315_1.time_ <= var_318_33 + arg_318_0 then
				arg_315_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_318_34 = 0
			local var_318_35 = 0.225

			if var_318_34 < arg_315_1.time_ and arg_315_1.time_ <= var_318_34 + arg_318_0 then
				arg_315_1.talkMaxDuration = 0
				arg_315_1.dialogCg_.alpha = 1

				arg_315_1.dialog_:SetActive(true)
				SetActive(arg_315_1.leftNameGo_, true)

				local var_318_36 = arg_315_1:FormatText(StoryNameCfg[1487].name)

				arg_315_1.leftNameTxt_.text = var_318_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_315_1.leftNameTxt_.transform)

				arg_315_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_315_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_315_1:RecordName(arg_315_1.leftNameTxt_.text)
				SetActive(arg_315_1.iconTrs_.gameObject, false)
				arg_315_1.callingController_:SetSelectedState("normal")

				local var_318_37 = arg_315_1:GetWordFromCfg(426101074)
				local var_318_38 = arg_315_1:FormatText(var_318_37.content)

				arg_315_1.text_.text = var_318_38

				LuaForUtil.ClearLinePrefixSymbol(arg_315_1.text_)

				local var_318_39 = 9
				local var_318_40 = utf8.len(var_318_38)
				local var_318_41 = var_318_39 <= 0 and var_318_35 or var_318_35 * (var_318_40 / var_318_39)

				if var_318_41 > 0 and var_318_35 < var_318_41 then
					arg_315_1.talkMaxDuration = var_318_41

					if var_318_41 + var_318_34 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_41 + var_318_34
					end
				end

				arg_315_1.text_.text = var_318_38
				arg_315_1.typewritter.percent = 0

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426101", "426101074", "story_v_out_426101.awb") ~= 0 then
					local var_318_42 = manager.audio:GetVoiceLength("story_v_out_426101", "426101074", "story_v_out_426101.awb") / 1000

					if var_318_42 + var_318_34 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_42 + var_318_34
					end

					if var_318_37.prefab_name ~= "" and arg_315_1.actors_[var_318_37.prefab_name] ~= nil then
						local var_318_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_315_1.actors_[var_318_37.prefab_name].transform, "story_v_out_426101", "426101074", "story_v_out_426101.awb")

						arg_315_1:RecordAudio("426101074", var_318_43)
						arg_315_1:RecordAudio("426101074", var_318_43)
					else
						arg_315_1:AudioAction("play", "voice", "story_v_out_426101", "426101074", "story_v_out_426101.awb")
					end

					arg_315_1:RecordHistoryTalkVoice("story_v_out_426101", "426101074", "story_v_out_426101.awb")
				end

				arg_315_1:RecordContent(arg_315_1.text_.text)
			end

			local var_318_44 = math.max(var_318_35, arg_315_1.talkMaxDuration)

			if var_318_34 <= arg_315_1.time_ and arg_315_1.time_ < var_318_34 + var_318_44 then
				arg_315_1.typewritter.percent = (arg_315_1.time_ - var_318_34) / var_318_44

				arg_315_1.typewritter:SetDirty()
			end

			if arg_315_1.time_ >= var_318_34 + var_318_44 and arg_315_1.time_ < var_318_34 + var_318_44 + arg_318_0 then
				arg_315_1.typewritter.percent = 1

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(true)
			end
		end

		arg_315_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_315_1:InitPlayNodeList()
	end,
	Play426101075 = function(arg_319_0, arg_319_1)
		arg_319_1.time_ = 0
		arg_319_1.frameCnt_ = 0
		arg_319_1.state_ = "playing"
		arg_319_1.curTalkId_ = 426101075
		arg_319_1.duration_ = 8.17

		local var_319_0 = {
			zh = 5.366,
			ja = 8.166
		}
		local var_319_1 = manager.audio:GetLocalizationFlag()

		if var_319_0[var_319_1] ~= nil then
			arg_319_1.duration_ = var_319_0[var_319_1]
		end

		SetActive(arg_319_1.tipsGo_, false)

		function arg_319_1.onSingleLineFinish_()
			arg_319_1.onSingleLineUpdate_ = nil
			arg_319_1.onSingleLineFinish_ = nil
			arg_319_1.state_ = "waiting"
		end

		function arg_319_1.playNext_(arg_321_0)
			if arg_321_0 == 1 then
				arg_319_0:Play426101076(arg_319_1)
			end
		end

		function arg_319_1.onSingleLineUpdate_(arg_322_0)
			local var_322_0 = arg_319_1.actors_["6148ui_story"].transform
			local var_322_1 = 0

			if var_322_1 < arg_319_1.time_ and arg_319_1.time_ <= var_322_1 + arg_322_0 then
				arg_319_1.var_.moveOldPos6148ui_story = var_322_0.localPosition

				local var_322_2 = GameObjectTools.GetOrAddComponent(var_322_0.gameObject, typeof(DynamicBoneHelper))

				if var_322_2 then
					var_322_2:EnableDynamicBone(false)
				end
			end

			local var_322_3 = 0.001

			if var_322_1 <= arg_319_1.time_ and arg_319_1.time_ < var_322_1 + var_322_3 then
				local var_322_4 = (arg_319_1.time_ - var_322_1) / var_322_3
				local var_322_5 = Vector3.New(-0.7, -0.985, -6)

				var_322_0.localPosition = Vector3.Lerp(arg_319_1.var_.moveOldPos6148ui_story, var_322_5, var_322_4)

				local var_322_6 = manager.ui.mainCamera.transform.position - var_322_0.position

				var_322_0.forward = Vector3.New(var_322_6.x, var_322_6.y, var_322_6.z)

				local var_322_7 = var_322_0.localEulerAngles

				var_322_7.z = 0
				var_322_7.x = 0
				var_322_0.localEulerAngles = var_322_7
			end

			if arg_319_1.time_ >= var_322_1 + var_322_3 and arg_319_1.time_ < var_322_1 + var_322_3 + arg_322_0 then
				var_322_0.localPosition = Vector3.New(-0.7, -0.985, -6)

				local var_322_8 = manager.ui.mainCamera.transform.position - var_322_0.position

				var_322_0.forward = Vector3.New(var_322_8.x, var_322_8.y, var_322_8.z)

				local var_322_9 = var_322_0.localEulerAngles

				var_322_9.z = 0
				var_322_9.x = 0
				var_322_0.localEulerAngles = var_322_9

				local var_322_10 = GameObjectTools.GetOrAddComponent(var_322_0.gameObject, typeof(DynamicBoneHelper))

				if var_322_10 then
					var_322_10:EnableDynamicBone(true)
				end
			end

			local var_322_11 = arg_319_1.actors_["6148ui_story"]
			local var_322_12 = 0

			if var_322_12 < arg_319_1.time_ and arg_319_1.time_ <= var_322_12 + arg_322_0 and not isNil(var_322_11) and arg_319_1.var_.characterEffect6148ui_story == nil then
				arg_319_1.var_.characterEffect6148ui_story = var_322_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_322_13 = 0.200000002980232

			if var_322_12 <= arg_319_1.time_ and arg_319_1.time_ < var_322_12 + var_322_13 and not isNil(var_322_11) then
				local var_322_14 = (arg_319_1.time_ - var_322_12) / var_322_13

				if arg_319_1.var_.characterEffect6148ui_story and not isNil(var_322_11) then
					arg_319_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_319_1.time_ >= var_322_12 + var_322_13 and arg_319_1.time_ < var_322_12 + var_322_13 + arg_322_0 and not isNil(var_322_11) and arg_319_1.var_.characterEffect6148ui_story then
				arg_319_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_322_15 = arg_319_1.actors_["1054ui_story"]
			local var_322_16 = 0

			if var_322_16 < arg_319_1.time_ and arg_319_1.time_ <= var_322_16 + arg_322_0 and not isNil(var_322_15) and arg_319_1.var_.characterEffect1054ui_story == nil then
				arg_319_1.var_.characterEffect1054ui_story = var_322_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_322_17 = 0.200000002980232

			if var_322_16 <= arg_319_1.time_ and arg_319_1.time_ < var_322_16 + var_322_17 and not isNil(var_322_15) then
				local var_322_18 = (arg_319_1.time_ - var_322_16) / var_322_17

				if arg_319_1.var_.characterEffect1054ui_story and not isNil(var_322_15) then
					local var_322_19 = Mathf.Lerp(0, 0.5, var_322_18)

					arg_319_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_319_1.var_.characterEffect1054ui_story.fillRatio = var_322_19
				end
			end

			if arg_319_1.time_ >= var_322_16 + var_322_17 and arg_319_1.time_ < var_322_16 + var_322_17 + arg_322_0 and not isNil(var_322_15) and arg_319_1.var_.characterEffect1054ui_story then
				local var_322_20 = 0.5

				arg_319_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_319_1.var_.characterEffect1054ui_story.fillRatio = var_322_20
			end

			local var_322_21 = 0

			if var_322_21 < arg_319_1.time_ and arg_319_1.time_ <= var_322_21 + arg_322_0 then
				arg_319_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action4_2")
			end

			local var_322_22 = 0

			if var_322_22 < arg_319_1.time_ and arg_319_1.time_ <= var_322_22 + arg_322_0 then
				arg_319_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_322_23 = 0
			local var_322_24 = 0.675

			if var_322_23 < arg_319_1.time_ and arg_319_1.time_ <= var_322_23 + arg_322_0 then
				arg_319_1.talkMaxDuration = 0
				arg_319_1.dialogCg_.alpha = 1

				arg_319_1.dialog_:SetActive(true)
				SetActive(arg_319_1.leftNameGo_, true)

				local var_322_25 = arg_319_1:FormatText(StoryNameCfg[1488].name)

				arg_319_1.leftNameTxt_.text = var_322_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_319_1.leftNameTxt_.transform)

				arg_319_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_319_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_319_1:RecordName(arg_319_1.leftNameTxt_.text)
				SetActive(arg_319_1.iconTrs_.gameObject, false)
				arg_319_1.callingController_:SetSelectedState("normal")

				local var_322_26 = arg_319_1:GetWordFromCfg(426101075)
				local var_322_27 = arg_319_1:FormatText(var_322_26.content)

				arg_319_1.text_.text = var_322_27

				LuaForUtil.ClearLinePrefixSymbol(arg_319_1.text_)

				local var_322_28 = 27
				local var_322_29 = utf8.len(var_322_27)
				local var_322_30 = var_322_28 <= 0 and var_322_24 or var_322_24 * (var_322_29 / var_322_28)

				if var_322_30 > 0 and var_322_24 < var_322_30 then
					arg_319_1.talkMaxDuration = var_322_30

					if var_322_30 + var_322_23 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_30 + var_322_23
					end
				end

				arg_319_1.text_.text = var_322_27
				arg_319_1.typewritter.percent = 0

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426101", "426101075", "story_v_out_426101.awb") ~= 0 then
					local var_322_31 = manager.audio:GetVoiceLength("story_v_out_426101", "426101075", "story_v_out_426101.awb") / 1000

					if var_322_31 + var_322_23 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_31 + var_322_23
					end

					if var_322_26.prefab_name ~= "" and arg_319_1.actors_[var_322_26.prefab_name] ~= nil then
						local var_322_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_319_1.actors_[var_322_26.prefab_name].transform, "story_v_out_426101", "426101075", "story_v_out_426101.awb")

						arg_319_1:RecordAudio("426101075", var_322_32)
						arg_319_1:RecordAudio("426101075", var_322_32)
					else
						arg_319_1:AudioAction("play", "voice", "story_v_out_426101", "426101075", "story_v_out_426101.awb")
					end

					arg_319_1:RecordHistoryTalkVoice("story_v_out_426101", "426101075", "story_v_out_426101.awb")
				end

				arg_319_1:RecordContent(arg_319_1.text_.text)
			end

			local var_322_33 = math.max(var_322_24, arg_319_1.talkMaxDuration)

			if var_322_23 <= arg_319_1.time_ and arg_319_1.time_ < var_322_23 + var_322_33 then
				arg_319_1.typewritter.percent = (arg_319_1.time_ - var_322_23) / var_322_33

				arg_319_1.typewritter:SetDirty()
			end

			if arg_319_1.time_ >= var_322_23 + var_322_33 and arg_319_1.time_ < var_322_23 + var_322_33 + arg_322_0 then
				arg_319_1.typewritter.percent = 1

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(true)
			end
		end

		arg_319_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_319_1:InitPlayNodeList()
	end,
	Play426101076 = function(arg_323_0, arg_323_1)
		arg_323_1.time_ = 0
		arg_323_1.frameCnt_ = 0
		arg_323_1.state_ = "playing"
		arg_323_1.curTalkId_ = 426101076
		arg_323_1.duration_ = 2

		SetActive(arg_323_1.tipsGo_, false)

		function arg_323_1.onSingleLineFinish_()
			arg_323_1.onSingleLineUpdate_ = nil
			arg_323_1.onSingleLineFinish_ = nil
			arg_323_1.state_ = "waiting"
		end

		function arg_323_1.playNext_(arg_325_0)
			if arg_325_0 == 1 then
				arg_323_0:Play426101077(arg_323_1)
			end
		end

		function arg_323_1.onSingleLineUpdate_(arg_326_0)
			local var_326_0 = arg_323_1.actors_["1054ui_story"].transform
			local var_326_1 = 0

			if var_326_1 < arg_323_1.time_ and arg_323_1.time_ <= var_326_1 + arg_326_0 then
				arg_323_1.var_.moveOldPos1054ui_story = var_326_0.localPosition

				local var_326_2 = GameObjectTools.GetOrAddComponent(var_326_0.gameObject, typeof(DynamicBoneHelper))

				if var_326_2 then
					var_326_2:EnableDynamicBone(false)
				end
			end

			local var_326_3 = 0.001

			if var_326_1 <= arg_323_1.time_ and arg_323_1.time_ < var_326_1 + var_326_3 then
				local var_326_4 = (arg_323_1.time_ - var_326_1) / var_326_3
				local var_326_5 = Vector3.New(0.7, -0.985, -6)

				var_326_0.localPosition = Vector3.Lerp(arg_323_1.var_.moveOldPos1054ui_story, var_326_5, var_326_4)

				local var_326_6 = manager.ui.mainCamera.transform.position - var_326_0.position

				var_326_0.forward = Vector3.New(var_326_6.x, var_326_6.y, var_326_6.z)

				local var_326_7 = var_326_0.localEulerAngles

				var_326_7.z = 0
				var_326_7.x = 0
				var_326_0.localEulerAngles = var_326_7
			end

			if arg_323_1.time_ >= var_326_1 + var_326_3 and arg_323_1.time_ < var_326_1 + var_326_3 + arg_326_0 then
				var_326_0.localPosition = Vector3.New(0.7, -0.985, -6)

				local var_326_8 = manager.ui.mainCamera.transform.position - var_326_0.position

				var_326_0.forward = Vector3.New(var_326_8.x, var_326_8.y, var_326_8.z)

				local var_326_9 = var_326_0.localEulerAngles

				var_326_9.z = 0
				var_326_9.x = 0
				var_326_0.localEulerAngles = var_326_9

				local var_326_10 = GameObjectTools.GetOrAddComponent(var_326_0.gameObject, typeof(DynamicBoneHelper))

				if var_326_10 then
					var_326_10:EnableDynamicBone(true)
				end
			end

			local var_326_11 = arg_323_1.actors_["1054ui_story"]
			local var_326_12 = 0

			if var_326_12 < arg_323_1.time_ and arg_323_1.time_ <= var_326_12 + arg_326_0 and not isNil(var_326_11) and arg_323_1.var_.characterEffect1054ui_story == nil then
				arg_323_1.var_.characterEffect1054ui_story = var_326_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_326_13 = 0.200000002980232

			if var_326_12 <= arg_323_1.time_ and arg_323_1.time_ < var_326_12 + var_326_13 and not isNil(var_326_11) then
				local var_326_14 = (arg_323_1.time_ - var_326_12) / var_326_13

				if arg_323_1.var_.characterEffect1054ui_story and not isNil(var_326_11) then
					arg_323_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_323_1.time_ >= var_326_12 + var_326_13 and arg_323_1.time_ < var_326_12 + var_326_13 + arg_326_0 and not isNil(var_326_11) and arg_323_1.var_.characterEffect1054ui_story then
				arg_323_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_326_15 = arg_323_1.actors_["6148ui_story"]
			local var_326_16 = 0

			if var_326_16 < arg_323_1.time_ and arg_323_1.time_ <= var_326_16 + arg_326_0 and not isNil(var_326_15) and arg_323_1.var_.characterEffect6148ui_story == nil then
				arg_323_1.var_.characterEffect6148ui_story = var_326_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_326_17 = 0.200000002980232

			if var_326_16 <= arg_323_1.time_ and arg_323_1.time_ < var_326_16 + var_326_17 and not isNil(var_326_15) then
				local var_326_18 = (arg_323_1.time_ - var_326_16) / var_326_17

				if arg_323_1.var_.characterEffect6148ui_story and not isNil(var_326_15) then
					local var_326_19 = Mathf.Lerp(0, 0.5, var_326_18)

					arg_323_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_323_1.var_.characterEffect6148ui_story.fillRatio = var_326_19
				end
			end

			if arg_323_1.time_ >= var_326_16 + var_326_17 and arg_323_1.time_ < var_326_16 + var_326_17 + arg_326_0 and not isNil(var_326_15) and arg_323_1.var_.characterEffect6148ui_story then
				local var_326_20 = 0.5

				arg_323_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_323_1.var_.characterEffect6148ui_story.fillRatio = var_326_20
			end

			local var_326_21 = 0

			if var_326_21 < arg_323_1.time_ and arg_323_1.time_ <= var_326_21 + arg_326_0 then
				arg_323_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action5_2")
			end

			local var_326_22 = 0

			if var_326_22 < arg_323_1.time_ and arg_323_1.time_ <= var_326_22 + arg_326_0 then
				arg_323_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_326_23 = 0
			local var_326_24 = 0.175

			if var_326_23 < arg_323_1.time_ and arg_323_1.time_ <= var_326_23 + arg_326_0 then
				arg_323_1.talkMaxDuration = 0
				arg_323_1.dialogCg_.alpha = 1

				arg_323_1.dialog_:SetActive(true)
				SetActive(arg_323_1.leftNameGo_, true)

				local var_326_25 = arg_323_1:FormatText(StoryNameCfg[1487].name)

				arg_323_1.leftNameTxt_.text = var_326_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_323_1.leftNameTxt_.transform)

				arg_323_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_323_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_323_1:RecordName(arg_323_1.leftNameTxt_.text)
				SetActive(arg_323_1.iconTrs_.gameObject, false)
				arg_323_1.callingController_:SetSelectedState("normal")

				local var_326_26 = arg_323_1:GetWordFromCfg(426101076)
				local var_326_27 = arg_323_1:FormatText(var_326_26.content)

				arg_323_1.text_.text = var_326_27

				LuaForUtil.ClearLinePrefixSymbol(arg_323_1.text_)

				local var_326_28 = 7
				local var_326_29 = utf8.len(var_326_27)
				local var_326_30 = var_326_28 <= 0 and var_326_24 or var_326_24 * (var_326_29 / var_326_28)

				if var_326_30 > 0 and var_326_24 < var_326_30 then
					arg_323_1.talkMaxDuration = var_326_30

					if var_326_30 + var_326_23 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_30 + var_326_23
					end
				end

				arg_323_1.text_.text = var_326_27
				arg_323_1.typewritter.percent = 0

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426101", "426101076", "story_v_out_426101.awb") ~= 0 then
					local var_326_31 = manager.audio:GetVoiceLength("story_v_out_426101", "426101076", "story_v_out_426101.awb") / 1000

					if var_326_31 + var_326_23 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_31 + var_326_23
					end

					if var_326_26.prefab_name ~= "" and arg_323_1.actors_[var_326_26.prefab_name] ~= nil then
						local var_326_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_323_1.actors_[var_326_26.prefab_name].transform, "story_v_out_426101", "426101076", "story_v_out_426101.awb")

						arg_323_1:RecordAudio("426101076", var_326_32)
						arg_323_1:RecordAudio("426101076", var_326_32)
					else
						arg_323_1:AudioAction("play", "voice", "story_v_out_426101", "426101076", "story_v_out_426101.awb")
					end

					arg_323_1:RecordHistoryTalkVoice("story_v_out_426101", "426101076", "story_v_out_426101.awb")
				end

				arg_323_1:RecordContent(arg_323_1.text_.text)
			end

			local var_326_33 = math.max(var_326_24, arg_323_1.talkMaxDuration)

			if var_326_23 <= arg_323_1.time_ and arg_323_1.time_ < var_326_23 + var_326_33 then
				arg_323_1.typewritter.percent = (arg_323_1.time_ - var_326_23) / var_326_33

				arg_323_1.typewritter:SetDirty()
			end

			if arg_323_1.time_ >= var_326_23 + var_326_33 and arg_323_1.time_ < var_326_23 + var_326_33 + arg_326_0 then
				arg_323_1.typewritter.percent = 1

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(true)
			end
		end

		arg_323_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_323_1:InitPlayNodeList()
	end,
	Play426101077 = function(arg_327_0, arg_327_1)
		arg_327_1.time_ = 0
		arg_327_1.frameCnt_ = 0
		arg_327_1.state_ = "playing"
		arg_327_1.curTalkId_ = 426101077
		arg_327_1.duration_ = 7.33

		local var_327_0 = {
			zh = 5.733,
			ja = 7.333
		}
		local var_327_1 = manager.audio:GetLocalizationFlag()

		if var_327_0[var_327_1] ~= nil then
			arg_327_1.duration_ = var_327_0[var_327_1]
		end

		SetActive(arg_327_1.tipsGo_, false)

		function arg_327_1.onSingleLineFinish_()
			arg_327_1.onSingleLineUpdate_ = nil
			arg_327_1.onSingleLineFinish_ = nil
			arg_327_1.state_ = "waiting"
		end

		function arg_327_1.playNext_(arg_329_0)
			if arg_329_0 == 1 then
				arg_327_0:Play426101078(arg_327_1)
			end
		end

		function arg_327_1.onSingleLineUpdate_(arg_330_0)
			local var_330_0 = arg_327_1.actors_["6148ui_story"].transform
			local var_330_1 = 0

			if var_330_1 < arg_327_1.time_ and arg_327_1.time_ <= var_330_1 + arg_330_0 then
				arg_327_1.var_.moveOldPos6148ui_story = var_330_0.localPosition

				local var_330_2 = GameObjectTools.GetOrAddComponent(var_330_0.gameObject, typeof(DynamicBoneHelper))

				if var_330_2 then
					var_330_2:EnableDynamicBone(false)
				end
			end

			local var_330_3 = 0.001

			if var_330_1 <= arg_327_1.time_ and arg_327_1.time_ < var_330_1 + var_330_3 then
				local var_330_4 = (arg_327_1.time_ - var_330_1) / var_330_3
				local var_330_5 = Vector3.New(-0.7, -0.985, -6)

				var_330_0.localPosition = Vector3.Lerp(arg_327_1.var_.moveOldPos6148ui_story, var_330_5, var_330_4)

				local var_330_6 = manager.ui.mainCamera.transform.position - var_330_0.position

				var_330_0.forward = Vector3.New(var_330_6.x, var_330_6.y, var_330_6.z)

				local var_330_7 = var_330_0.localEulerAngles

				var_330_7.z = 0
				var_330_7.x = 0
				var_330_0.localEulerAngles = var_330_7
			end

			if arg_327_1.time_ >= var_330_1 + var_330_3 and arg_327_1.time_ < var_330_1 + var_330_3 + arg_330_0 then
				var_330_0.localPosition = Vector3.New(-0.7, -0.985, -6)

				local var_330_8 = manager.ui.mainCamera.transform.position - var_330_0.position

				var_330_0.forward = Vector3.New(var_330_8.x, var_330_8.y, var_330_8.z)

				local var_330_9 = var_330_0.localEulerAngles

				var_330_9.z = 0
				var_330_9.x = 0
				var_330_0.localEulerAngles = var_330_9

				local var_330_10 = GameObjectTools.GetOrAddComponent(var_330_0.gameObject, typeof(DynamicBoneHelper))

				if var_330_10 then
					var_330_10:EnableDynamicBone(true)
				end
			end

			local var_330_11 = arg_327_1.actors_["6148ui_story"]
			local var_330_12 = 0

			if var_330_12 < arg_327_1.time_ and arg_327_1.time_ <= var_330_12 + arg_330_0 and not isNil(var_330_11) and arg_327_1.var_.characterEffect6148ui_story == nil then
				arg_327_1.var_.characterEffect6148ui_story = var_330_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_330_13 = 0.200000002980232

			if var_330_12 <= arg_327_1.time_ and arg_327_1.time_ < var_330_12 + var_330_13 and not isNil(var_330_11) then
				local var_330_14 = (arg_327_1.time_ - var_330_12) / var_330_13

				if arg_327_1.var_.characterEffect6148ui_story and not isNil(var_330_11) then
					arg_327_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_327_1.time_ >= var_330_12 + var_330_13 and arg_327_1.time_ < var_330_12 + var_330_13 + arg_330_0 and not isNil(var_330_11) and arg_327_1.var_.characterEffect6148ui_story then
				arg_327_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_330_15 = arg_327_1.actors_["1054ui_story"]
			local var_330_16 = 0

			if var_330_16 < arg_327_1.time_ and arg_327_1.time_ <= var_330_16 + arg_330_0 and not isNil(var_330_15) and arg_327_1.var_.characterEffect1054ui_story == nil then
				arg_327_1.var_.characterEffect1054ui_story = var_330_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_330_17 = 0.200000002980232

			if var_330_16 <= arg_327_1.time_ and arg_327_1.time_ < var_330_16 + var_330_17 and not isNil(var_330_15) then
				local var_330_18 = (arg_327_1.time_ - var_330_16) / var_330_17

				if arg_327_1.var_.characterEffect1054ui_story and not isNil(var_330_15) then
					local var_330_19 = Mathf.Lerp(0, 0.5, var_330_18)

					arg_327_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_327_1.var_.characterEffect1054ui_story.fillRatio = var_330_19
				end
			end

			if arg_327_1.time_ >= var_330_16 + var_330_17 and arg_327_1.time_ < var_330_16 + var_330_17 + arg_330_0 and not isNil(var_330_15) and arg_327_1.var_.characterEffect1054ui_story then
				local var_330_20 = 0.5

				arg_327_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_327_1.var_.characterEffect1054ui_story.fillRatio = var_330_20
			end

			local var_330_21 = 0

			if var_330_21 < arg_327_1.time_ and arg_327_1.time_ <= var_330_21 + arg_330_0 then
				arg_327_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action4_1")
			end

			local var_330_22 = 0

			if var_330_22 < arg_327_1.time_ and arg_327_1.time_ <= var_330_22 + arg_330_0 then
				arg_327_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_330_23 = 0
			local var_330_24 = 0.575

			if var_330_23 < arg_327_1.time_ and arg_327_1.time_ <= var_330_23 + arg_330_0 then
				arg_327_1.talkMaxDuration = 0
				arg_327_1.dialogCg_.alpha = 1

				arg_327_1.dialog_:SetActive(true)
				SetActive(arg_327_1.leftNameGo_, true)

				local var_330_25 = arg_327_1:FormatText(StoryNameCfg[1488].name)

				arg_327_1.leftNameTxt_.text = var_330_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_327_1.leftNameTxt_.transform)

				arg_327_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_327_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_327_1:RecordName(arg_327_1.leftNameTxt_.text)
				SetActive(arg_327_1.iconTrs_.gameObject, false)
				arg_327_1.callingController_:SetSelectedState("normal")

				local var_330_26 = arg_327_1:GetWordFromCfg(426101077)
				local var_330_27 = arg_327_1:FormatText(var_330_26.content)

				arg_327_1.text_.text = var_330_27

				LuaForUtil.ClearLinePrefixSymbol(arg_327_1.text_)

				local var_330_28 = 23
				local var_330_29 = utf8.len(var_330_27)
				local var_330_30 = var_330_28 <= 0 and var_330_24 or var_330_24 * (var_330_29 / var_330_28)

				if var_330_30 > 0 and var_330_24 < var_330_30 then
					arg_327_1.talkMaxDuration = var_330_30

					if var_330_30 + var_330_23 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_30 + var_330_23
					end
				end

				arg_327_1.text_.text = var_330_27
				arg_327_1.typewritter.percent = 0

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426101", "426101077", "story_v_out_426101.awb") ~= 0 then
					local var_330_31 = manager.audio:GetVoiceLength("story_v_out_426101", "426101077", "story_v_out_426101.awb") / 1000

					if var_330_31 + var_330_23 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_31 + var_330_23
					end

					if var_330_26.prefab_name ~= "" and arg_327_1.actors_[var_330_26.prefab_name] ~= nil then
						local var_330_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_327_1.actors_[var_330_26.prefab_name].transform, "story_v_out_426101", "426101077", "story_v_out_426101.awb")

						arg_327_1:RecordAudio("426101077", var_330_32)
						arg_327_1:RecordAudio("426101077", var_330_32)
					else
						arg_327_1:AudioAction("play", "voice", "story_v_out_426101", "426101077", "story_v_out_426101.awb")
					end

					arg_327_1:RecordHistoryTalkVoice("story_v_out_426101", "426101077", "story_v_out_426101.awb")
				end

				arg_327_1:RecordContent(arg_327_1.text_.text)
			end

			local var_330_33 = math.max(var_330_24, arg_327_1.talkMaxDuration)

			if var_330_23 <= arg_327_1.time_ and arg_327_1.time_ < var_330_23 + var_330_33 then
				arg_327_1.typewritter.percent = (arg_327_1.time_ - var_330_23) / var_330_33

				arg_327_1.typewritter:SetDirty()
			end

			if arg_327_1.time_ >= var_330_23 + var_330_33 and arg_327_1.time_ < var_330_23 + var_330_33 + arg_330_0 then
				arg_327_1.typewritter.percent = 1

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(true)
			end
		end

		arg_327_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_327_1:InitPlayNodeList()
	end,
	Play426101078 = function(arg_331_0, arg_331_1)
		arg_331_1.time_ = 0
		arg_331_1.frameCnt_ = 0
		arg_331_1.state_ = "playing"
		arg_331_1.curTalkId_ = 426101078
		arg_331_1.duration_ = 2.73

		local var_331_0 = {
			zh = 2.6,
			ja = 2.733
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
				arg_331_0:Play426101079(arg_331_1)
			end
		end

		function arg_331_1.onSingleLineUpdate_(arg_334_0)
			local var_334_0 = arg_331_1.actors_["1054ui_story"].transform
			local var_334_1 = 0

			if var_334_1 < arg_331_1.time_ and arg_331_1.time_ <= var_334_1 + arg_334_0 then
				arg_331_1.var_.moveOldPos1054ui_story = var_334_0.localPosition

				local var_334_2 = GameObjectTools.GetOrAddComponent(var_334_0.gameObject, typeof(DynamicBoneHelper))

				if var_334_2 then
					var_334_2:EnableDynamicBone(false)
				end
			end

			local var_334_3 = 0.001

			if var_334_1 <= arg_331_1.time_ and arg_331_1.time_ < var_334_1 + var_334_3 then
				local var_334_4 = (arg_331_1.time_ - var_334_1) / var_334_3
				local var_334_5 = Vector3.New(0.7, -0.985, -6)

				var_334_0.localPosition = Vector3.Lerp(arg_331_1.var_.moveOldPos1054ui_story, var_334_5, var_334_4)

				local var_334_6 = manager.ui.mainCamera.transform.position - var_334_0.position

				var_334_0.forward = Vector3.New(var_334_6.x, var_334_6.y, var_334_6.z)

				local var_334_7 = var_334_0.localEulerAngles

				var_334_7.z = 0
				var_334_7.x = 0
				var_334_0.localEulerAngles = var_334_7
			end

			if arg_331_1.time_ >= var_334_1 + var_334_3 and arg_331_1.time_ < var_334_1 + var_334_3 + arg_334_0 then
				var_334_0.localPosition = Vector3.New(0.7, -0.985, -6)

				local var_334_8 = manager.ui.mainCamera.transform.position - var_334_0.position

				var_334_0.forward = Vector3.New(var_334_8.x, var_334_8.y, var_334_8.z)

				local var_334_9 = var_334_0.localEulerAngles

				var_334_9.z = 0
				var_334_9.x = 0
				var_334_0.localEulerAngles = var_334_9

				local var_334_10 = GameObjectTools.GetOrAddComponent(var_334_0.gameObject, typeof(DynamicBoneHelper))

				if var_334_10 then
					var_334_10:EnableDynamicBone(true)
				end
			end

			local var_334_11 = arg_331_1.actors_["1054ui_story"]
			local var_334_12 = 0

			if var_334_12 < arg_331_1.time_ and arg_331_1.time_ <= var_334_12 + arg_334_0 and not isNil(var_334_11) and arg_331_1.var_.characterEffect1054ui_story == nil then
				arg_331_1.var_.characterEffect1054ui_story = var_334_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_334_13 = 0.200000002980232

			if var_334_12 <= arg_331_1.time_ and arg_331_1.time_ < var_334_12 + var_334_13 and not isNil(var_334_11) then
				local var_334_14 = (arg_331_1.time_ - var_334_12) / var_334_13

				if arg_331_1.var_.characterEffect1054ui_story and not isNil(var_334_11) then
					arg_331_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_331_1.time_ >= var_334_12 + var_334_13 and arg_331_1.time_ < var_334_12 + var_334_13 + arg_334_0 and not isNil(var_334_11) and arg_331_1.var_.characterEffect1054ui_story then
				arg_331_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_334_15 = arg_331_1.actors_["6148ui_story"]
			local var_334_16 = 0

			if var_334_16 < arg_331_1.time_ and arg_331_1.time_ <= var_334_16 + arg_334_0 and not isNil(var_334_15) and arg_331_1.var_.characterEffect6148ui_story == nil then
				arg_331_1.var_.characterEffect6148ui_story = var_334_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_334_17 = 0.200000002980232

			if var_334_16 <= arg_331_1.time_ and arg_331_1.time_ < var_334_16 + var_334_17 and not isNil(var_334_15) then
				local var_334_18 = (arg_331_1.time_ - var_334_16) / var_334_17

				if arg_331_1.var_.characterEffect6148ui_story and not isNil(var_334_15) then
					local var_334_19 = Mathf.Lerp(0, 0.5, var_334_18)

					arg_331_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_331_1.var_.characterEffect6148ui_story.fillRatio = var_334_19
				end
			end

			if arg_331_1.time_ >= var_334_16 + var_334_17 and arg_331_1.time_ < var_334_16 + var_334_17 + arg_334_0 and not isNil(var_334_15) and arg_331_1.var_.characterEffect6148ui_story then
				local var_334_20 = 0.5

				arg_331_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_331_1.var_.characterEffect6148ui_story.fillRatio = var_334_20
			end

			local var_334_21 = 0

			if var_334_21 < arg_331_1.time_ and arg_331_1.time_ <= var_334_21 + arg_334_0 then
				arg_331_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action1_1")
			end

			local var_334_22 = 0

			if var_334_22 < arg_331_1.time_ and arg_331_1.time_ <= var_334_22 + arg_334_0 then
				arg_331_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_334_23 = 0
			local var_334_24 = 0.15

			if var_334_23 < arg_331_1.time_ and arg_331_1.time_ <= var_334_23 + arg_334_0 then
				arg_331_1.talkMaxDuration = 0
				arg_331_1.dialogCg_.alpha = 1

				arg_331_1.dialog_:SetActive(true)
				SetActive(arg_331_1.leftNameGo_, true)

				local var_334_25 = arg_331_1:FormatText(StoryNameCfg[1487].name)

				arg_331_1.leftNameTxt_.text = var_334_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_331_1.leftNameTxt_.transform)

				arg_331_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_331_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_331_1:RecordName(arg_331_1.leftNameTxt_.text)
				SetActive(arg_331_1.iconTrs_.gameObject, false)
				arg_331_1.callingController_:SetSelectedState("normal")

				local var_334_26 = arg_331_1:GetWordFromCfg(426101078)
				local var_334_27 = arg_331_1:FormatText(var_334_26.content)

				arg_331_1.text_.text = var_334_27

				LuaForUtil.ClearLinePrefixSymbol(arg_331_1.text_)

				local var_334_28 = 6
				local var_334_29 = utf8.len(var_334_27)
				local var_334_30 = var_334_28 <= 0 and var_334_24 or var_334_24 * (var_334_29 / var_334_28)

				if var_334_30 > 0 and var_334_24 < var_334_30 then
					arg_331_1.talkMaxDuration = var_334_30

					if var_334_30 + var_334_23 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_30 + var_334_23
					end
				end

				arg_331_1.text_.text = var_334_27
				arg_331_1.typewritter.percent = 0

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426101", "426101078", "story_v_out_426101.awb") ~= 0 then
					local var_334_31 = manager.audio:GetVoiceLength("story_v_out_426101", "426101078", "story_v_out_426101.awb") / 1000

					if var_334_31 + var_334_23 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_31 + var_334_23
					end

					if var_334_26.prefab_name ~= "" and arg_331_1.actors_[var_334_26.prefab_name] ~= nil then
						local var_334_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_331_1.actors_[var_334_26.prefab_name].transform, "story_v_out_426101", "426101078", "story_v_out_426101.awb")

						arg_331_1:RecordAudio("426101078", var_334_32)
						arg_331_1:RecordAudio("426101078", var_334_32)
					else
						arg_331_1:AudioAction("play", "voice", "story_v_out_426101", "426101078", "story_v_out_426101.awb")
					end

					arg_331_1:RecordHistoryTalkVoice("story_v_out_426101", "426101078", "story_v_out_426101.awb")
				end

				arg_331_1:RecordContent(arg_331_1.text_.text)
			end

			local var_334_33 = math.max(var_334_24, arg_331_1.talkMaxDuration)

			if var_334_23 <= arg_331_1.time_ and arg_331_1.time_ < var_334_23 + var_334_33 then
				arg_331_1.typewritter.percent = (arg_331_1.time_ - var_334_23) / var_334_33

				arg_331_1.typewritter:SetDirty()
			end

			if arg_331_1.time_ >= var_334_23 + var_334_33 and arg_331_1.time_ < var_334_23 + var_334_33 + arg_334_0 then
				arg_331_1.typewritter.percent = 1

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(true)
			end
		end

		arg_331_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_331_1:InitPlayNodeList()
	end,
	Play426101079 = function(arg_335_0, arg_335_1)
		arg_335_1.time_ = 0
		arg_335_1.frameCnt_ = 0
		arg_335_1.state_ = "playing"
		arg_335_1.curTalkId_ = 426101079
		arg_335_1.duration_ = 5

		SetActive(arg_335_1.tipsGo_, false)

		function arg_335_1.onSingleLineFinish_()
			arg_335_1.onSingleLineUpdate_ = nil
			arg_335_1.onSingleLineFinish_ = nil
			arg_335_1.state_ = "waiting"
		end

		function arg_335_1.playNext_(arg_337_0)
			if arg_337_0 == 1 then
				arg_335_0:Play426101080(arg_335_1)
			end
		end

		function arg_335_1.onSingleLineUpdate_(arg_338_0)
			local var_338_0 = arg_335_1.actors_["1054ui_story"]
			local var_338_1 = 0

			if var_338_1 < arg_335_1.time_ and arg_335_1.time_ <= var_338_1 + arg_338_0 and not isNil(var_338_0) and arg_335_1.var_.characterEffect1054ui_story == nil then
				arg_335_1.var_.characterEffect1054ui_story = var_338_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_338_2 = 0.200000002980232

			if var_338_1 <= arg_335_1.time_ and arg_335_1.time_ < var_338_1 + var_338_2 and not isNil(var_338_0) then
				local var_338_3 = (arg_335_1.time_ - var_338_1) / var_338_2

				if arg_335_1.var_.characterEffect1054ui_story and not isNil(var_338_0) then
					local var_338_4 = Mathf.Lerp(0, 0.5, var_338_3)

					arg_335_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_335_1.var_.characterEffect1054ui_story.fillRatio = var_338_4
				end
			end

			if arg_335_1.time_ >= var_338_1 + var_338_2 and arg_335_1.time_ < var_338_1 + var_338_2 + arg_338_0 and not isNil(var_338_0) and arg_335_1.var_.characterEffect1054ui_story then
				local var_338_5 = 0.5

				arg_335_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_335_1.var_.characterEffect1054ui_story.fillRatio = var_338_5
			end

			local var_338_6 = 0
			local var_338_7 = 0.6

			if var_338_6 < arg_335_1.time_ and arg_335_1.time_ <= var_338_6 + arg_338_0 then
				arg_335_1.talkMaxDuration = 0
				arg_335_1.dialogCg_.alpha = 1

				arg_335_1.dialog_:SetActive(true)
				SetActive(arg_335_1.leftNameGo_, true)

				local var_338_8 = arg_335_1:FormatText(StoryNameCfg[7].name)

				arg_335_1.leftNameTxt_.text = var_338_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_335_1.leftNameTxt_.transform)

				arg_335_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_335_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_335_1:RecordName(arg_335_1.leftNameTxt_.text)
				SetActive(arg_335_1.iconTrs_.gameObject, true)
				arg_335_1.iconController_:SetSelectedState("hero")

				arg_335_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_335_1.callingController_:SetSelectedState("normal")

				arg_335_1.keyicon_.color = Color.New(1, 1, 1)
				arg_335_1.icon_.color = Color.New(1, 1, 1)

				local var_338_9 = arg_335_1:GetWordFromCfg(426101079)
				local var_338_10 = arg_335_1:FormatText(var_338_9.content)

				arg_335_1.text_.text = var_338_10

				LuaForUtil.ClearLinePrefixSymbol(arg_335_1.text_)

				local var_338_11 = 24
				local var_338_12 = utf8.len(var_338_10)
				local var_338_13 = var_338_11 <= 0 and var_338_7 or var_338_7 * (var_338_12 / var_338_11)

				if var_338_13 > 0 and var_338_7 < var_338_13 then
					arg_335_1.talkMaxDuration = var_338_13

					if var_338_13 + var_338_6 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_13 + var_338_6
					end
				end

				arg_335_1.text_.text = var_338_10
				arg_335_1.typewritter.percent = 0

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(false)
				arg_335_1:RecordContent(arg_335_1.text_.text)
			end

			local var_338_14 = math.max(var_338_7, arg_335_1.talkMaxDuration)

			if var_338_6 <= arg_335_1.time_ and arg_335_1.time_ < var_338_6 + var_338_14 then
				arg_335_1.typewritter.percent = (arg_335_1.time_ - var_338_6) / var_338_14

				arg_335_1.typewritter:SetDirty()
			end

			if arg_335_1.time_ >= var_338_6 + var_338_14 and arg_335_1.time_ < var_338_6 + var_338_14 + arg_338_0 then
				arg_335_1.typewritter.percent = 1

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(true)
			end
		end

		arg_335_1.nodeConfigList_ = {}

		arg_335_1:InitPlayNodeList()
	end,
	Play426101080 = function(arg_339_0, arg_339_1)
		arg_339_1.time_ = 0
		arg_339_1.frameCnt_ = 0
		arg_339_1.state_ = "playing"
		arg_339_1.curTalkId_ = 426101080
		arg_339_1.duration_ = 2.63

		SetActive(arg_339_1.tipsGo_, false)

		function arg_339_1.onSingleLineFinish_()
			arg_339_1.onSingleLineUpdate_ = nil
			arg_339_1.onSingleLineFinish_ = nil
			arg_339_1.state_ = "waiting"
		end

		function arg_339_1.playNext_(arg_341_0)
			if arg_341_0 == 1 then
				arg_339_0:Play426101081(arg_339_1)
			end
		end

		function arg_339_1.onSingleLineUpdate_(arg_342_0)
			local var_342_0 = arg_339_1.actors_["6148ui_story"].transform
			local var_342_1 = 0

			if var_342_1 < arg_339_1.time_ and arg_339_1.time_ <= var_342_1 + arg_342_0 then
				arg_339_1.var_.moveOldPos6148ui_story = var_342_0.localPosition

				local var_342_2 = GameObjectTools.GetOrAddComponent(var_342_0.gameObject, typeof(DynamicBoneHelper))

				if var_342_2 then
					var_342_2:EnableDynamicBone(false)
				end
			end

			local var_342_3 = 0.001

			if var_342_1 <= arg_339_1.time_ and arg_339_1.time_ < var_342_1 + var_342_3 then
				local var_342_4 = (arg_339_1.time_ - var_342_1) / var_342_3
				local var_342_5 = Vector3.New(-0.7, -0.985, -6)

				var_342_0.localPosition = Vector3.Lerp(arg_339_1.var_.moveOldPos6148ui_story, var_342_5, var_342_4)

				local var_342_6 = manager.ui.mainCamera.transform.position - var_342_0.position

				var_342_0.forward = Vector3.New(var_342_6.x, var_342_6.y, var_342_6.z)

				local var_342_7 = var_342_0.localEulerAngles

				var_342_7.z = 0
				var_342_7.x = 0
				var_342_0.localEulerAngles = var_342_7
			end

			if arg_339_1.time_ >= var_342_1 + var_342_3 and arg_339_1.time_ < var_342_1 + var_342_3 + arg_342_0 then
				var_342_0.localPosition = Vector3.New(-0.7, -0.985, -6)

				local var_342_8 = manager.ui.mainCamera.transform.position - var_342_0.position

				var_342_0.forward = Vector3.New(var_342_8.x, var_342_8.y, var_342_8.z)

				local var_342_9 = var_342_0.localEulerAngles

				var_342_9.z = 0
				var_342_9.x = 0
				var_342_0.localEulerAngles = var_342_9

				local var_342_10 = GameObjectTools.GetOrAddComponent(var_342_0.gameObject, typeof(DynamicBoneHelper))

				if var_342_10 then
					var_342_10:EnableDynamicBone(true)
				end
			end

			local var_342_11 = arg_339_1.actors_["6148ui_story"]
			local var_342_12 = 0

			if var_342_12 < arg_339_1.time_ and arg_339_1.time_ <= var_342_12 + arg_342_0 and not isNil(var_342_11) and arg_339_1.var_.characterEffect6148ui_story == nil then
				arg_339_1.var_.characterEffect6148ui_story = var_342_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_342_13 = 0.200000002980232

			if var_342_12 <= arg_339_1.time_ and arg_339_1.time_ < var_342_12 + var_342_13 and not isNil(var_342_11) then
				local var_342_14 = (arg_339_1.time_ - var_342_12) / var_342_13

				if arg_339_1.var_.characterEffect6148ui_story and not isNil(var_342_11) then
					arg_339_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_339_1.time_ >= var_342_12 + var_342_13 and arg_339_1.time_ < var_342_12 + var_342_13 + arg_342_0 and not isNil(var_342_11) and arg_339_1.var_.characterEffect6148ui_story then
				arg_339_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_342_15 = 0

			if var_342_15 < arg_339_1.time_ and arg_339_1.time_ <= var_342_15 + arg_342_0 then
				arg_339_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action4_2")
			end

			local var_342_16 = 0
			local var_342_17 = 0.2

			if var_342_16 < arg_339_1.time_ and arg_339_1.time_ <= var_342_16 + arg_342_0 then
				arg_339_1.talkMaxDuration = 0
				arg_339_1.dialogCg_.alpha = 1

				arg_339_1.dialog_:SetActive(true)
				SetActive(arg_339_1.leftNameGo_, true)

				local var_342_18 = arg_339_1:FormatText(StoryNameCfg[1488].name)

				arg_339_1.leftNameTxt_.text = var_342_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_339_1.leftNameTxt_.transform)

				arg_339_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_339_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_339_1:RecordName(arg_339_1.leftNameTxt_.text)
				SetActive(arg_339_1.iconTrs_.gameObject, false)
				arg_339_1.callingController_:SetSelectedState("normal")

				local var_342_19 = arg_339_1:GetWordFromCfg(426101080)
				local var_342_20 = arg_339_1:FormatText(var_342_19.content)

				arg_339_1.text_.text = var_342_20

				LuaForUtil.ClearLinePrefixSymbol(arg_339_1.text_)

				local var_342_21 = 8
				local var_342_22 = utf8.len(var_342_20)
				local var_342_23 = var_342_21 <= 0 and var_342_17 or var_342_17 * (var_342_22 / var_342_21)

				if var_342_23 > 0 and var_342_17 < var_342_23 then
					arg_339_1.talkMaxDuration = var_342_23

					if var_342_23 + var_342_16 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_23 + var_342_16
					end
				end

				arg_339_1.text_.text = var_342_20
				arg_339_1.typewritter.percent = 0

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426101", "426101080", "story_v_out_426101.awb") ~= 0 then
					local var_342_24 = manager.audio:GetVoiceLength("story_v_out_426101", "426101080", "story_v_out_426101.awb") / 1000

					if var_342_24 + var_342_16 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_24 + var_342_16
					end

					if var_342_19.prefab_name ~= "" and arg_339_1.actors_[var_342_19.prefab_name] ~= nil then
						local var_342_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_339_1.actors_[var_342_19.prefab_name].transform, "story_v_out_426101", "426101080", "story_v_out_426101.awb")

						arg_339_1:RecordAudio("426101080", var_342_25)
						arg_339_1:RecordAudio("426101080", var_342_25)
					else
						arg_339_1:AudioAction("play", "voice", "story_v_out_426101", "426101080", "story_v_out_426101.awb")
					end

					arg_339_1:RecordHistoryTalkVoice("story_v_out_426101", "426101080", "story_v_out_426101.awb")
				end

				arg_339_1:RecordContent(arg_339_1.text_.text)
			end

			local var_342_26 = math.max(var_342_17, arg_339_1.talkMaxDuration)

			if var_342_16 <= arg_339_1.time_ and arg_339_1.time_ < var_342_16 + var_342_26 then
				arg_339_1.typewritter.percent = (arg_339_1.time_ - var_342_16) / var_342_26

				arg_339_1.typewritter:SetDirty()
			end

			if arg_339_1.time_ >= var_342_16 + var_342_26 and arg_339_1.time_ < var_342_16 + var_342_26 + arg_342_0 then
				arg_339_1.typewritter.percent = 1

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(true)
			end
		end

		arg_339_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
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
	Play426101081 = function(arg_343_0, arg_343_1)
		arg_343_1.time_ = 0
		arg_343_1.frameCnt_ = 0
		arg_343_1.state_ = "playing"
		arg_343_1.curTalkId_ = 426101081
		arg_343_1.duration_ = 3.73

		local var_343_0 = {
			zh = 3.733,
			ja = 3.3
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
		end

		function arg_343_1.playNext_(arg_345_0)
			if arg_345_0 == 1 then
				arg_343_0:Play426101082(arg_343_1)
			end
		end

		function arg_343_1.onSingleLineUpdate_(arg_346_0)
			local var_346_0 = arg_343_1.actors_["1054ui_story"].transform
			local var_346_1 = 0

			if var_346_1 < arg_343_1.time_ and arg_343_1.time_ <= var_346_1 + arg_346_0 then
				arg_343_1.var_.moveOldPos1054ui_story = var_346_0.localPosition

				local var_346_2 = GameObjectTools.GetOrAddComponent(var_346_0.gameObject, typeof(DynamicBoneHelper))

				if var_346_2 then
					var_346_2:EnableDynamicBone(false)
				end
			end

			local var_346_3 = 0.001

			if var_346_1 <= arg_343_1.time_ and arg_343_1.time_ < var_346_1 + var_346_3 then
				local var_346_4 = (arg_343_1.time_ - var_346_1) / var_346_3
				local var_346_5 = Vector3.New(0.7, -0.985, -6)

				var_346_0.localPosition = Vector3.Lerp(arg_343_1.var_.moveOldPos1054ui_story, var_346_5, var_346_4)

				local var_346_6 = manager.ui.mainCamera.transform.position - var_346_0.position

				var_346_0.forward = Vector3.New(var_346_6.x, var_346_6.y, var_346_6.z)

				local var_346_7 = var_346_0.localEulerAngles

				var_346_7.z = 0
				var_346_7.x = 0
				var_346_0.localEulerAngles = var_346_7
			end

			if arg_343_1.time_ >= var_346_1 + var_346_3 and arg_343_1.time_ < var_346_1 + var_346_3 + arg_346_0 then
				var_346_0.localPosition = Vector3.New(0.7, -0.985, -6)

				local var_346_8 = manager.ui.mainCamera.transform.position - var_346_0.position

				var_346_0.forward = Vector3.New(var_346_8.x, var_346_8.y, var_346_8.z)

				local var_346_9 = var_346_0.localEulerAngles

				var_346_9.z = 0
				var_346_9.x = 0
				var_346_0.localEulerAngles = var_346_9

				local var_346_10 = GameObjectTools.GetOrAddComponent(var_346_0.gameObject, typeof(DynamicBoneHelper))

				if var_346_10 then
					var_346_10:EnableDynamicBone(true)
				end
			end

			local var_346_11 = arg_343_1.actors_["1054ui_story"]
			local var_346_12 = 0

			if var_346_12 < arg_343_1.time_ and arg_343_1.time_ <= var_346_12 + arg_346_0 and not isNil(var_346_11) and arg_343_1.var_.characterEffect1054ui_story == nil then
				arg_343_1.var_.characterEffect1054ui_story = var_346_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_346_13 = 0.200000002980232

			if var_346_12 <= arg_343_1.time_ and arg_343_1.time_ < var_346_12 + var_346_13 and not isNil(var_346_11) then
				local var_346_14 = (arg_343_1.time_ - var_346_12) / var_346_13

				if arg_343_1.var_.characterEffect1054ui_story and not isNil(var_346_11) then
					arg_343_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_343_1.time_ >= var_346_12 + var_346_13 and arg_343_1.time_ < var_346_12 + var_346_13 + arg_346_0 and not isNil(var_346_11) and arg_343_1.var_.characterEffect1054ui_story then
				arg_343_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_346_15 = arg_343_1.actors_["6148ui_story"]
			local var_346_16 = 0

			if var_346_16 < arg_343_1.time_ and arg_343_1.time_ <= var_346_16 + arg_346_0 and not isNil(var_346_15) and arg_343_1.var_.characterEffect6148ui_story == nil then
				arg_343_1.var_.characterEffect6148ui_story = var_346_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_346_17 = 0.200000002980232

			if var_346_16 <= arg_343_1.time_ and arg_343_1.time_ < var_346_16 + var_346_17 and not isNil(var_346_15) then
				local var_346_18 = (arg_343_1.time_ - var_346_16) / var_346_17

				if arg_343_1.var_.characterEffect6148ui_story and not isNil(var_346_15) then
					local var_346_19 = Mathf.Lerp(0, 0.5, var_346_18)

					arg_343_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_343_1.var_.characterEffect6148ui_story.fillRatio = var_346_19
				end
			end

			if arg_343_1.time_ >= var_346_16 + var_346_17 and arg_343_1.time_ < var_346_16 + var_346_17 + arg_346_0 and not isNil(var_346_15) and arg_343_1.var_.characterEffect6148ui_story then
				local var_346_20 = 0.5

				arg_343_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_343_1.var_.characterEffect6148ui_story.fillRatio = var_346_20
			end

			local var_346_21 = 0

			if var_346_21 < arg_343_1.time_ and arg_343_1.time_ <= var_346_21 + arg_346_0 then
				arg_343_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action1_1")
			end

			local var_346_22 = 0
			local var_346_23 = 0.3

			if var_346_22 < arg_343_1.time_ and arg_343_1.time_ <= var_346_22 + arg_346_0 then
				local var_346_24 = "play"
				local var_346_25 = "music"

				arg_343_1:AudioAction(var_346_24, var_346_25, "ui_battle", "ui_battle_stopbgm", "")

				local var_346_26 = ""
				local var_346_27 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_346_27 ~= "" then
					if arg_343_1.bgmTxt_.text ~= var_346_27 and arg_343_1.bgmTxt_.text ~= "" then
						if arg_343_1.bgmTxt2_.text ~= "" then
							arg_343_1.bgmTxt_.text = arg_343_1.bgmTxt2_.text
						end

						arg_343_1.bgmTxt2_.text = var_346_27

						arg_343_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_343_1.bgmTxt_.text = var_346_27
						arg_343_1.bgmTxt2_.text = var_346_27
					end

					if arg_343_1.bgmTimer then
						arg_343_1.bgmTimer:Stop()

						arg_343_1.bgmTimer = nil
					end

					if arg_343_1.settingData.show_music_name == 1 then
						arg_343_1.musicController:SetSelectedState("show")
						arg_343_1.musicAnimator_:Play("open", 0, 0)

						if arg_343_1.settingData.music_time ~= 0 then
							arg_343_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_343_1.settingData.music_time), function()
								if arg_343_1 == nil or isNil(arg_343_1.bgmTxt_) then
									return
								end

								arg_343_1.musicController:SetSelectedState("hide")
								arg_343_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_346_28 = 0
			local var_346_29 = 0.275

			if var_346_28 < arg_343_1.time_ and arg_343_1.time_ <= var_346_28 + arg_346_0 then
				arg_343_1.talkMaxDuration = 0
				arg_343_1.dialogCg_.alpha = 1

				arg_343_1.dialog_:SetActive(true)
				SetActive(arg_343_1.leftNameGo_, true)

				local var_346_30 = arg_343_1:FormatText(StoryNameCfg[1487].name)

				arg_343_1.leftNameTxt_.text = var_346_30

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_343_1.leftNameTxt_.transform)

				arg_343_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_343_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_343_1:RecordName(arg_343_1.leftNameTxt_.text)
				SetActive(arg_343_1.iconTrs_.gameObject, false)
				arg_343_1.callingController_:SetSelectedState("normal")

				local var_346_31 = arg_343_1:GetWordFromCfg(426101081)
				local var_346_32 = arg_343_1:FormatText(var_346_31.content)

				arg_343_1.text_.text = var_346_32

				LuaForUtil.ClearLinePrefixSymbol(arg_343_1.text_)

				local var_346_33 = 11
				local var_346_34 = utf8.len(var_346_32)
				local var_346_35 = var_346_33 <= 0 and var_346_29 or var_346_29 * (var_346_34 / var_346_33)

				if var_346_35 > 0 and var_346_29 < var_346_35 then
					arg_343_1.talkMaxDuration = var_346_35

					if var_346_35 + var_346_28 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_35 + var_346_28
					end
				end

				arg_343_1.text_.text = var_346_32
				arg_343_1.typewritter.percent = 0

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426101", "426101081", "story_v_out_426101.awb") ~= 0 then
					local var_346_36 = manager.audio:GetVoiceLength("story_v_out_426101", "426101081", "story_v_out_426101.awb") / 1000

					if var_346_36 + var_346_28 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_36 + var_346_28
					end

					if var_346_31.prefab_name ~= "" and arg_343_1.actors_[var_346_31.prefab_name] ~= nil then
						local var_346_37 = LuaForUtil.PlayVoiceWithCriLipsync(arg_343_1.actors_[var_346_31.prefab_name].transform, "story_v_out_426101", "426101081", "story_v_out_426101.awb")

						arg_343_1:RecordAudio("426101081", var_346_37)
						arg_343_1:RecordAudio("426101081", var_346_37)
					else
						arg_343_1:AudioAction("play", "voice", "story_v_out_426101", "426101081", "story_v_out_426101.awb")
					end

					arg_343_1:RecordHistoryTalkVoice("story_v_out_426101", "426101081", "story_v_out_426101.awb")
				end

				arg_343_1:RecordContent(arg_343_1.text_.text)
			end

			local var_346_38 = math.max(var_346_29, arg_343_1.talkMaxDuration)

			if var_346_28 <= arg_343_1.time_ and arg_343_1.time_ < var_346_28 + var_346_38 then
				arg_343_1.typewritter.percent = (arg_343_1.time_ - var_346_28) / var_346_38

				arg_343_1.typewritter:SetDirty()
			end

			if arg_343_1.time_ >= var_346_28 + var_346_38 and arg_343_1.time_ < var_346_28 + var_346_38 + arg_346_0 then
				arg_343_1.typewritter.percent = 1

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(true)
			end
		end

		arg_343_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_343_1:InitPlayNodeList()
	end,
	Play426101082 = function(arg_348_0, arg_348_1)
		arg_348_1.time_ = 0
		arg_348_1.frameCnt_ = 0
		arg_348_1.state_ = "playing"
		arg_348_1.curTalkId_ = 426101082
		arg_348_1.duration_ = 9

		SetActive(arg_348_1.tipsGo_, false)

		function arg_348_1.onSingleLineFinish_()
			arg_348_1.onSingleLineUpdate_ = nil
			arg_348_1.onSingleLineFinish_ = nil
			arg_348_1.state_ = "waiting"
		end

		function arg_348_1.playNext_(arg_350_0)
			if arg_350_0 == 1 then
				arg_348_0:Play426101083(arg_348_1)
			end
		end

		function arg_348_1.onSingleLineUpdate_(arg_351_0)
			local var_351_0 = "ST2007a"

			if arg_348_1.bgs_[var_351_0] == nil then
				local var_351_1 = Object.Instantiate(arg_348_1.paintGo_)

				var_351_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_351_0)
				var_351_1.name = var_351_0
				var_351_1.transform.parent = arg_348_1.stage_.transform
				var_351_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_348_1.bgs_[var_351_0] = var_351_1
			end

			local var_351_2 = 2

			if var_351_2 < arg_348_1.time_ and arg_348_1.time_ <= var_351_2 + arg_351_0 then
				local var_351_3 = manager.ui.mainCamera.transform.localPosition
				local var_351_4 = Vector3.New(0, 0, 10) + Vector3.New(var_351_3.x, var_351_3.y, 0)
				local var_351_5 = arg_348_1.bgs_.ST2007a

				var_351_5.transform.localPosition = var_351_4
				var_351_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_351_6 = var_351_5:GetComponent("SpriteRenderer")

				if var_351_6 and var_351_6.sprite then
					local var_351_7 = (var_351_5.transform.localPosition - var_351_3).z
					local var_351_8 = manager.ui.mainCameraCom_
					local var_351_9 = 2 * var_351_7 * Mathf.Tan(var_351_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_351_10 = var_351_9 * var_351_8.aspect
					local var_351_11 = var_351_6.sprite.bounds.size.x
					local var_351_12 = var_351_6.sprite.bounds.size.y
					local var_351_13 = var_351_10 / var_351_11
					local var_351_14 = var_351_9 / var_351_12
					local var_351_15 = var_351_14 < var_351_13 and var_351_13 or var_351_14

					var_351_5.transform.localScale = Vector3.New(var_351_15, var_351_15, 0)
				end

				for iter_351_0, iter_351_1 in pairs(arg_348_1.bgs_) do
					if iter_351_0 ~= "ST2007a" then
						iter_351_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_351_16 = 4

			if var_351_16 < arg_348_1.time_ and arg_348_1.time_ <= var_351_16 + arg_351_0 then
				arg_348_1.allBtn_.enabled = false
			end

			local var_351_17 = 0.3

			if arg_348_1.time_ >= var_351_16 + var_351_17 and arg_348_1.time_ < var_351_16 + var_351_17 + arg_351_0 then
				arg_348_1.allBtn_.enabled = true
			end

			local var_351_18 = 0

			if var_351_18 < arg_348_1.time_ and arg_348_1.time_ <= var_351_18 + arg_351_0 then
				arg_348_1.mask_.enabled = true
				arg_348_1.mask_.raycastTarget = true

				arg_348_1:SetGaussion(false)
			end

			local var_351_19 = 2

			if var_351_18 <= arg_348_1.time_ and arg_348_1.time_ < var_351_18 + var_351_19 then
				local var_351_20 = (arg_348_1.time_ - var_351_18) / var_351_19
				local var_351_21 = Color.New(0, 0, 0)

				var_351_21.a = Mathf.Lerp(0, 1, var_351_20)
				arg_348_1.mask_.color = var_351_21
			end

			if arg_348_1.time_ >= var_351_18 + var_351_19 and arg_348_1.time_ < var_351_18 + var_351_19 + arg_351_0 then
				local var_351_22 = Color.New(0, 0, 0)

				var_351_22.a = 1
				arg_348_1.mask_.color = var_351_22
			end

			local var_351_23 = 2

			if var_351_23 < arg_348_1.time_ and arg_348_1.time_ <= var_351_23 + arg_351_0 then
				arg_348_1.mask_.enabled = true
				arg_348_1.mask_.raycastTarget = true

				arg_348_1:SetGaussion(false)
			end

			local var_351_24 = 2

			if var_351_23 <= arg_348_1.time_ and arg_348_1.time_ < var_351_23 + var_351_24 then
				local var_351_25 = (arg_348_1.time_ - var_351_23) / var_351_24
				local var_351_26 = Color.New(0, 0, 0)

				var_351_26.a = Mathf.Lerp(1, 0, var_351_25)
				arg_348_1.mask_.color = var_351_26
			end

			if arg_348_1.time_ >= var_351_23 + var_351_24 and arg_348_1.time_ < var_351_23 + var_351_24 + arg_351_0 then
				local var_351_27 = Color.New(0, 0, 0)
				local var_351_28 = 0

				arg_348_1.mask_.enabled = false
				var_351_27.a = var_351_28
				arg_348_1.mask_.color = var_351_27
			end

			local var_351_29 = arg_348_1.actors_["6148ui_story"].transform
			local var_351_30 = 2

			if var_351_30 < arg_348_1.time_ and arg_348_1.time_ <= var_351_30 + arg_351_0 then
				arg_348_1.var_.moveOldPos6148ui_story = var_351_29.localPosition

				local var_351_31 = GameObjectTools.GetOrAddComponent(var_351_29.gameObject, typeof(DynamicBoneHelper))

				if var_351_31 then
					var_351_31:EnableDynamicBone(false)
				end
			end

			local var_351_32 = 0.001

			if var_351_30 <= arg_348_1.time_ and arg_348_1.time_ < var_351_30 + var_351_32 then
				local var_351_33 = (arg_348_1.time_ - var_351_30) / var_351_32
				local var_351_34 = Vector3.New(0, 100, 0)

				var_351_29.localPosition = Vector3.Lerp(arg_348_1.var_.moveOldPos6148ui_story, var_351_34, var_351_33)

				local var_351_35 = manager.ui.mainCamera.transform.position - var_351_29.position

				var_351_29.forward = Vector3.New(var_351_35.x, var_351_35.y, var_351_35.z)

				local var_351_36 = var_351_29.localEulerAngles

				var_351_36.z = 0
				var_351_36.x = 0
				var_351_29.localEulerAngles = var_351_36
			end

			if arg_348_1.time_ >= var_351_30 + var_351_32 and arg_348_1.time_ < var_351_30 + var_351_32 + arg_351_0 then
				var_351_29.localPosition = Vector3.New(0, 100, 0)

				local var_351_37 = manager.ui.mainCamera.transform.position - var_351_29.position

				var_351_29.forward = Vector3.New(var_351_37.x, var_351_37.y, var_351_37.z)

				local var_351_38 = var_351_29.localEulerAngles

				var_351_38.z = 0
				var_351_38.x = 0
				var_351_29.localEulerAngles = var_351_38

				local var_351_39 = GameObjectTools.GetOrAddComponent(var_351_29.gameObject, typeof(DynamicBoneHelper))

				if var_351_39 then
					var_351_39:EnableDynamicBone(true)
				end
			end

			local var_351_40 = arg_348_1.actors_["1054ui_story"].transform
			local var_351_41 = 2

			if var_351_41 < arg_348_1.time_ and arg_348_1.time_ <= var_351_41 + arg_351_0 then
				arg_348_1.var_.moveOldPos1054ui_story = var_351_40.localPosition

				local var_351_42 = GameObjectTools.GetOrAddComponent(var_351_40.gameObject, typeof(DynamicBoneHelper))

				if var_351_42 then
					var_351_42:EnableDynamicBone(false)
				end
			end

			local var_351_43 = 0.001

			if var_351_41 <= arg_348_1.time_ and arg_348_1.time_ < var_351_41 + var_351_43 then
				local var_351_44 = (arg_348_1.time_ - var_351_41) / var_351_43
				local var_351_45 = Vector3.New(0, 100, 0)

				var_351_40.localPosition = Vector3.Lerp(arg_348_1.var_.moveOldPos1054ui_story, var_351_45, var_351_44)

				local var_351_46 = manager.ui.mainCamera.transform.position - var_351_40.position

				var_351_40.forward = Vector3.New(var_351_46.x, var_351_46.y, var_351_46.z)

				local var_351_47 = var_351_40.localEulerAngles

				var_351_47.z = 0
				var_351_47.x = 0
				var_351_40.localEulerAngles = var_351_47
			end

			if arg_348_1.time_ >= var_351_41 + var_351_43 and arg_348_1.time_ < var_351_41 + var_351_43 + arg_351_0 then
				var_351_40.localPosition = Vector3.New(0, 100, 0)

				local var_351_48 = manager.ui.mainCamera.transform.position - var_351_40.position

				var_351_40.forward = Vector3.New(var_351_48.x, var_351_48.y, var_351_48.z)

				local var_351_49 = var_351_40.localEulerAngles

				var_351_49.z = 0
				var_351_49.x = 0
				var_351_40.localEulerAngles = var_351_49

				local var_351_50 = GameObjectTools.GetOrAddComponent(var_351_40.gameObject, typeof(DynamicBoneHelper))

				if var_351_50 then
					var_351_50:EnableDynamicBone(true)
				end
			end

			local var_351_51 = arg_348_1.actors_["1054ui_story"]
			local var_351_52 = 2

			if var_351_52 < arg_348_1.time_ and arg_348_1.time_ <= var_351_52 + arg_351_0 and not isNil(var_351_51) and arg_348_1.var_.characterEffect1054ui_story == nil then
				arg_348_1.var_.characterEffect1054ui_story = var_351_51:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_351_53 = 0.200000002980232

			if var_351_52 <= arg_348_1.time_ and arg_348_1.time_ < var_351_52 + var_351_53 and not isNil(var_351_51) then
				local var_351_54 = (arg_348_1.time_ - var_351_52) / var_351_53

				if arg_348_1.var_.characterEffect1054ui_story and not isNil(var_351_51) then
					local var_351_55 = Mathf.Lerp(0, 0.5, var_351_54)

					arg_348_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_348_1.var_.characterEffect1054ui_story.fillRatio = var_351_55
				end
			end

			if arg_348_1.time_ >= var_351_52 + var_351_53 and arg_348_1.time_ < var_351_52 + var_351_53 + arg_351_0 and not isNil(var_351_51) and arg_348_1.var_.characterEffect1054ui_story then
				local var_351_56 = 0.5

				arg_348_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_348_1.var_.characterEffect1054ui_story.fillRatio = var_351_56
			end

			local var_351_57 = 2
			local var_351_58 = 0.3

			if var_351_57 < arg_348_1.time_ and arg_348_1.time_ <= var_351_57 + arg_351_0 then
				local var_351_59 = "play"
				local var_351_60 = "music"

				arg_348_1:AudioAction(var_351_59, var_351_60, "ui_battle", "ui_battle_stopbgm", "")

				local var_351_61 = ""
				local var_351_62 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_351_62 ~= "" then
					if arg_348_1.bgmTxt_.text ~= var_351_62 and arg_348_1.bgmTxt_.text ~= "" then
						if arg_348_1.bgmTxt2_.text ~= "" then
							arg_348_1.bgmTxt_.text = arg_348_1.bgmTxt2_.text
						end

						arg_348_1.bgmTxt2_.text = var_351_62

						arg_348_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_348_1.bgmTxt_.text = var_351_62
						arg_348_1.bgmTxt2_.text = var_351_62
					end

					if arg_348_1.bgmTimer then
						arg_348_1.bgmTimer:Stop()

						arg_348_1.bgmTimer = nil
					end

					if arg_348_1.settingData.show_music_name == 1 then
						arg_348_1.musicController:SetSelectedState("show")
						arg_348_1.musicAnimator_:Play("open", 0, 0)

						if arg_348_1.settingData.music_time ~= 0 then
							arg_348_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_348_1.settingData.music_time), function()
								if arg_348_1 == nil or isNil(arg_348_1.bgmTxt_) then
									return
								end

								arg_348_1.musicController:SetSelectedState("hide")
								arg_348_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_351_63 = 2.3
			local var_351_64 = 1

			if var_351_63 < arg_348_1.time_ and arg_348_1.time_ <= var_351_63 + arg_351_0 then
				local var_351_65 = "play"
				local var_351_66 = "music"

				arg_348_1:AudioAction(var_351_65, var_351_66, "bgm_story_quiet_1", "bgm_story_quiet_1", "bgm_story_quiet_1.awb")

				local var_351_67 = ""
				local var_351_68 = manager.audio:GetAudioName("bgm_story_quiet_1", "bgm_story_quiet_1")

				if var_351_68 ~= "" then
					if arg_348_1.bgmTxt_.text ~= var_351_68 and arg_348_1.bgmTxt_.text ~= "" then
						if arg_348_1.bgmTxt2_.text ~= "" then
							arg_348_1.bgmTxt_.text = arg_348_1.bgmTxt2_.text
						end

						arg_348_1.bgmTxt2_.text = var_351_68

						arg_348_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_348_1.bgmTxt_.text = var_351_68
						arg_348_1.bgmTxt2_.text = var_351_68
					end

					if arg_348_1.bgmTimer then
						arg_348_1.bgmTimer:Stop()

						arg_348_1.bgmTimer = nil
					end

					if arg_348_1.settingData.show_music_name == 1 then
						arg_348_1.musicController:SetSelectedState("show")
						arg_348_1.musicAnimator_:Play("open", 0, 0)

						if arg_348_1.settingData.music_time ~= 0 then
							arg_348_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_348_1.settingData.music_time), function()
								if arg_348_1 == nil or isNil(arg_348_1.bgmTxt_) then
									return
								end

								arg_348_1.musicController:SetSelectedState("hide")
								arg_348_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_351_69 = 2.475
			local var_351_70 = 1

			if var_351_69 < arg_348_1.time_ and arg_348_1.time_ <= var_351_69 + arg_351_0 then
				local var_351_71 = "play"
				local var_351_72 = "effect"

				arg_348_1:AudioAction(var_351_71, var_351_72, "se_story_birthday4", "se_story_birthday4_amb_room_tone_2", "")
			end

			local var_351_73 = 2.13333333333333
			local var_351_74 = 1

			if var_351_73 < arg_348_1.time_ and arg_348_1.time_ <= var_351_73 + arg_351_0 then
				local var_351_75 = "stop"
				local var_351_76 = "effect"

				arg_348_1:AudioAction(var_351_75, var_351_76, "se_story_150", "se_story_150_flower_field", "")
			end

			if arg_348_1.frameCnt_ <= 1 then
				arg_348_1.dialog_:SetActive(false)
			end

			local var_351_77 = 4
			local var_351_78 = 0.475

			if var_351_77 < arg_348_1.time_ and arg_348_1.time_ <= var_351_77 + arg_351_0 then
				arg_348_1.talkMaxDuration = 0

				arg_348_1.dialog_:SetActive(true)

				arg_348_1.dialogCg_.alpha = 0

				local var_351_79 = LeanTween.value(arg_348_1.dialog_, 0, 1, 0.3)

				var_351_79:setOnUpdate(LuaHelper.FloatAction(function(arg_354_0)
					arg_348_1.dialogCg_.alpha = arg_354_0
				end))
				var_351_79:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_348_1.dialog_)
					var_351_79:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_348_1.duration_ = arg_348_1.duration_ + 0.3

				SetActive(arg_348_1.leftNameGo_, true)

				local var_351_80 = arg_348_1:FormatText(StoryNameCfg[7].name)

				arg_348_1.leftNameTxt_.text = var_351_80

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_348_1.leftNameTxt_.transform)

				arg_348_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_348_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_348_1:RecordName(arg_348_1.leftNameTxt_.text)
				SetActive(arg_348_1.iconTrs_.gameObject, true)
				arg_348_1.iconController_:SetSelectedState("hero")

				arg_348_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_348_1.callingController_:SetSelectedState("normal")

				arg_348_1.keyicon_.color = Color.New(1, 1, 1)
				arg_348_1.icon_.color = Color.New(1, 1, 1)

				local var_351_81 = arg_348_1:GetWordFromCfg(426101082)
				local var_351_82 = arg_348_1:FormatText(var_351_81.content)

				arg_348_1.text_.text = var_351_82

				LuaForUtil.ClearLinePrefixSymbol(arg_348_1.text_)

				local var_351_83 = 19
				local var_351_84 = utf8.len(var_351_82)
				local var_351_85 = var_351_83 <= 0 and var_351_78 or var_351_78 * (var_351_84 / var_351_83)

				if var_351_85 > 0 and var_351_78 < var_351_85 then
					arg_348_1.talkMaxDuration = var_351_85
					var_351_77 = var_351_77 + 0.3

					if var_351_85 + var_351_77 > arg_348_1.duration_ then
						arg_348_1.duration_ = var_351_85 + var_351_77
					end
				end

				arg_348_1.text_.text = var_351_82
				arg_348_1.typewritter.percent = 0

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(false)
				arg_348_1:RecordContent(arg_348_1.text_.text)
			end

			local var_351_86 = var_351_77 + 0.3
			local var_351_87 = math.max(var_351_78, arg_348_1.talkMaxDuration)

			if var_351_86 <= arg_348_1.time_ and arg_348_1.time_ < var_351_86 + var_351_87 then
				arg_348_1.typewritter.percent = (arg_348_1.time_ - var_351_86) / var_351_87

				arg_348_1.typewritter:SetDirty()
			end

			if arg_348_1.time_ >= var_351_86 + var_351_87 and arg_348_1.time_ < var_351_86 + var_351_87 + arg_351_0 then
				arg_348_1.typewritter.percent = 1

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(true)
			end
		end

		arg_348_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_348_1:InitPlayNodeList()
	end,
	Play426101083 = function(arg_356_0, arg_356_1)
		arg_356_1.time_ = 0
		arg_356_1.frameCnt_ = 0
		arg_356_1.state_ = "playing"
		arg_356_1.curTalkId_ = 426101083
		arg_356_1.duration_ = 9.07

		local var_356_0 = {
			zh = 6.833,
			ja = 9.066
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
				arg_356_0:Play426101084(arg_356_1)
			end
		end

		function arg_356_1.onSingleLineUpdate_(arg_359_0)
			local var_359_0 = arg_356_1.actors_["6148ui_story"].transform
			local var_359_1 = 0

			if var_359_1 < arg_356_1.time_ and arg_356_1.time_ <= var_359_1 + arg_359_0 then
				arg_356_1.var_.moveOldPos6148ui_story = var_359_0.localPosition

				local var_359_2 = GameObjectTools.GetOrAddComponent(var_359_0.gameObject, typeof(DynamicBoneHelper))

				if var_359_2 then
					var_359_2:EnableDynamicBone(false)
				end
			end

			local var_359_3 = 0.001

			if var_359_1 <= arg_356_1.time_ and arg_356_1.time_ < var_359_1 + var_359_3 then
				local var_359_4 = (arg_356_1.time_ - var_359_1) / var_359_3
				local var_359_5 = Vector3.New(0, -0.985, -6)

				var_359_0.localPosition = Vector3.Lerp(arg_356_1.var_.moveOldPos6148ui_story, var_359_5, var_359_4)

				local var_359_6 = manager.ui.mainCamera.transform.position - var_359_0.position

				var_359_0.forward = Vector3.New(var_359_6.x, var_359_6.y, var_359_6.z)

				local var_359_7 = var_359_0.localEulerAngles

				var_359_7.z = 0
				var_359_7.x = 0
				var_359_0.localEulerAngles = var_359_7
			end

			if arg_356_1.time_ >= var_359_1 + var_359_3 and arg_356_1.time_ < var_359_1 + var_359_3 + arg_359_0 then
				var_359_0.localPosition = Vector3.New(0, -0.985, -6)

				local var_359_8 = manager.ui.mainCamera.transform.position - var_359_0.position

				var_359_0.forward = Vector3.New(var_359_8.x, var_359_8.y, var_359_8.z)

				local var_359_9 = var_359_0.localEulerAngles

				var_359_9.z = 0
				var_359_9.x = 0
				var_359_0.localEulerAngles = var_359_9

				local var_359_10 = GameObjectTools.GetOrAddComponent(var_359_0.gameObject, typeof(DynamicBoneHelper))

				if var_359_10 then
					var_359_10:EnableDynamicBone(true)
				end
			end

			local var_359_11 = arg_356_1.actors_["6148ui_story"]
			local var_359_12 = 0

			if var_359_12 < arg_356_1.time_ and arg_356_1.time_ <= var_359_12 + arg_359_0 and not isNil(var_359_11) and arg_356_1.var_.characterEffect6148ui_story == nil then
				arg_356_1.var_.characterEffect6148ui_story = var_359_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_359_13 = 0.200000002980232

			if var_359_12 <= arg_356_1.time_ and arg_356_1.time_ < var_359_12 + var_359_13 and not isNil(var_359_11) then
				local var_359_14 = (arg_356_1.time_ - var_359_12) / var_359_13

				if arg_356_1.var_.characterEffect6148ui_story and not isNil(var_359_11) then
					arg_356_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_356_1.time_ >= var_359_12 + var_359_13 and arg_356_1.time_ < var_359_12 + var_359_13 + arg_359_0 and not isNil(var_359_11) and arg_356_1.var_.characterEffect6148ui_story then
				arg_356_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_359_15 = 0

			if var_359_15 < arg_356_1.time_ and arg_356_1.time_ <= var_359_15 + arg_359_0 then
				arg_356_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action1_1")
			end

			local var_359_16 = 0

			if var_359_16 < arg_356_1.time_ and arg_356_1.time_ <= var_359_16 + arg_359_0 then
				arg_356_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_359_17 = 0
			local var_359_18 = 0.825

			if var_359_17 < arg_356_1.time_ and arg_356_1.time_ <= var_359_17 + arg_359_0 then
				arg_356_1.talkMaxDuration = 0
				arg_356_1.dialogCg_.alpha = 1

				arg_356_1.dialog_:SetActive(true)
				SetActive(arg_356_1.leftNameGo_, true)

				local var_359_19 = arg_356_1:FormatText(StoryNameCfg[1488].name)

				arg_356_1.leftNameTxt_.text = var_359_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_356_1.leftNameTxt_.transform)

				arg_356_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_356_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_356_1:RecordName(arg_356_1.leftNameTxt_.text)
				SetActive(arg_356_1.iconTrs_.gameObject, false)
				arg_356_1.callingController_:SetSelectedState("normal")

				local var_359_20 = arg_356_1:GetWordFromCfg(426101083)
				local var_359_21 = arg_356_1:FormatText(var_359_20.content)

				arg_356_1.text_.text = var_359_21

				LuaForUtil.ClearLinePrefixSymbol(arg_356_1.text_)

				local var_359_22 = 33
				local var_359_23 = utf8.len(var_359_21)
				local var_359_24 = var_359_22 <= 0 and var_359_18 or var_359_18 * (var_359_23 / var_359_22)

				if var_359_24 > 0 and var_359_18 < var_359_24 then
					arg_356_1.talkMaxDuration = var_359_24

					if var_359_24 + var_359_17 > arg_356_1.duration_ then
						arg_356_1.duration_ = var_359_24 + var_359_17
					end
				end

				arg_356_1.text_.text = var_359_21
				arg_356_1.typewritter.percent = 0

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426101", "426101083", "story_v_out_426101.awb") ~= 0 then
					local var_359_25 = manager.audio:GetVoiceLength("story_v_out_426101", "426101083", "story_v_out_426101.awb") / 1000

					if var_359_25 + var_359_17 > arg_356_1.duration_ then
						arg_356_1.duration_ = var_359_25 + var_359_17
					end

					if var_359_20.prefab_name ~= "" and arg_356_1.actors_[var_359_20.prefab_name] ~= nil then
						local var_359_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_356_1.actors_[var_359_20.prefab_name].transform, "story_v_out_426101", "426101083", "story_v_out_426101.awb")

						arg_356_1:RecordAudio("426101083", var_359_26)
						arg_356_1:RecordAudio("426101083", var_359_26)
					else
						arg_356_1:AudioAction("play", "voice", "story_v_out_426101", "426101083", "story_v_out_426101.awb")
					end

					arg_356_1:RecordHistoryTalkVoice("story_v_out_426101", "426101083", "story_v_out_426101.awb")
				end

				arg_356_1:RecordContent(arg_356_1.text_.text)
			end

			local var_359_27 = math.max(var_359_18, arg_356_1.talkMaxDuration)

			if var_359_17 <= arg_356_1.time_ and arg_356_1.time_ < var_359_17 + var_359_27 then
				arg_356_1.typewritter.percent = (arg_356_1.time_ - var_359_17) / var_359_27

				arg_356_1.typewritter:SetDirty()
			end

			if arg_356_1.time_ >= var_359_17 + var_359_27 and arg_356_1.time_ < var_359_17 + var_359_27 + arg_359_0 then
				arg_356_1.typewritter.percent = 1

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(true)
			end
		end

		arg_356_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_356_1:InitPlayNodeList()
	end,
	Play426101084 = function(arg_360_0, arg_360_1)
		arg_360_1.time_ = 0
		arg_360_1.frameCnt_ = 0
		arg_360_1.state_ = "playing"
		arg_360_1.curTalkId_ = 426101084
		arg_360_1.duration_ = 5

		SetActive(arg_360_1.tipsGo_, false)

		function arg_360_1.onSingleLineFinish_()
			arg_360_1.onSingleLineUpdate_ = nil
			arg_360_1.onSingleLineFinish_ = nil
			arg_360_1.state_ = "waiting"
		end

		function arg_360_1.playNext_(arg_362_0)
			if arg_362_0 == 1 then
				arg_360_0:Play426101085(arg_360_1)
			end
		end

		function arg_360_1.onSingleLineUpdate_(arg_363_0)
			local var_363_0 = arg_360_1.actors_["6148ui_story"]
			local var_363_1 = 0

			if var_363_1 < arg_360_1.time_ and arg_360_1.time_ <= var_363_1 + arg_363_0 and not isNil(var_363_0) and arg_360_1.var_.characterEffect6148ui_story == nil then
				arg_360_1.var_.characterEffect6148ui_story = var_363_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_363_2 = 0.200000002980232

			if var_363_1 <= arg_360_1.time_ and arg_360_1.time_ < var_363_1 + var_363_2 and not isNil(var_363_0) then
				local var_363_3 = (arg_360_1.time_ - var_363_1) / var_363_2

				if arg_360_1.var_.characterEffect6148ui_story and not isNil(var_363_0) then
					local var_363_4 = Mathf.Lerp(0, 0.5, var_363_3)

					arg_360_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_360_1.var_.characterEffect6148ui_story.fillRatio = var_363_4
				end
			end

			if arg_360_1.time_ >= var_363_1 + var_363_2 and arg_360_1.time_ < var_363_1 + var_363_2 + arg_363_0 and not isNil(var_363_0) and arg_360_1.var_.characterEffect6148ui_story then
				local var_363_5 = 0.5

				arg_360_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_360_1.var_.characterEffect6148ui_story.fillRatio = var_363_5
			end

			local var_363_6 = 0
			local var_363_7 = 0.6

			if var_363_6 < arg_360_1.time_ and arg_360_1.time_ <= var_363_6 + arg_363_0 then
				arg_360_1.talkMaxDuration = 0
				arg_360_1.dialogCg_.alpha = 1

				arg_360_1.dialog_:SetActive(true)
				SetActive(arg_360_1.leftNameGo_, true)

				local var_363_8 = arg_360_1:FormatText(StoryNameCfg[7].name)

				arg_360_1.leftNameTxt_.text = var_363_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_360_1.leftNameTxt_.transform)

				arg_360_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_360_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_360_1:RecordName(arg_360_1.leftNameTxt_.text)
				SetActive(arg_360_1.iconTrs_.gameObject, true)
				arg_360_1.iconController_:SetSelectedState("hero")

				arg_360_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_360_1.callingController_:SetSelectedState("normal")

				arg_360_1.keyicon_.color = Color.New(1, 1, 1)
				arg_360_1.icon_.color = Color.New(1, 1, 1)

				local var_363_9 = arg_360_1:GetWordFromCfg(426101084)
				local var_363_10 = arg_360_1:FormatText(var_363_9.content)

				arg_360_1.text_.text = var_363_10

				LuaForUtil.ClearLinePrefixSymbol(arg_360_1.text_)

				local var_363_11 = 24
				local var_363_12 = utf8.len(var_363_10)
				local var_363_13 = var_363_11 <= 0 and var_363_7 or var_363_7 * (var_363_12 / var_363_11)

				if var_363_13 > 0 and var_363_7 < var_363_13 then
					arg_360_1.talkMaxDuration = var_363_13

					if var_363_13 + var_363_6 > arg_360_1.duration_ then
						arg_360_1.duration_ = var_363_13 + var_363_6
					end
				end

				arg_360_1.text_.text = var_363_10
				arg_360_1.typewritter.percent = 0

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(false)
				arg_360_1:RecordContent(arg_360_1.text_.text)
			end

			local var_363_14 = math.max(var_363_7, arg_360_1.talkMaxDuration)

			if var_363_6 <= arg_360_1.time_ and arg_360_1.time_ < var_363_6 + var_363_14 then
				arg_360_1.typewritter.percent = (arg_360_1.time_ - var_363_6) / var_363_14

				arg_360_1.typewritter:SetDirty()
			end

			if arg_360_1.time_ >= var_363_6 + var_363_14 and arg_360_1.time_ < var_363_6 + var_363_14 + arg_363_0 then
				arg_360_1.typewritter.percent = 1

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(true)
			end
		end

		arg_360_1.nodeConfigList_ = {}

		arg_360_1:InitPlayNodeList()
	end,
	Play426101085 = function(arg_364_0, arg_364_1)
		arg_364_1.time_ = 0
		arg_364_1.frameCnt_ = 0
		arg_364_1.state_ = "playing"
		arg_364_1.curTalkId_ = 426101085
		arg_364_1.duration_ = 7.1

		local var_364_0 = {
			zh = 7.1,
			ja = 6.6
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
				arg_364_0:Play426101086(arg_364_1)
			end
		end

		function arg_364_1.onSingleLineUpdate_(arg_367_0)
			local var_367_0 = arg_364_1.actors_["1054ui_story"].transform
			local var_367_1 = 0

			if var_367_1 < arg_364_1.time_ and arg_364_1.time_ <= var_367_1 + arg_367_0 then
				arg_364_1.var_.moveOldPos1054ui_story = var_367_0.localPosition

				local var_367_2 = GameObjectTools.GetOrAddComponent(var_367_0.gameObject, typeof(DynamicBoneHelper))

				if var_367_2 then
					var_367_2:EnableDynamicBone(false)
				end
			end

			local var_367_3 = 0.001

			if var_367_1 <= arg_364_1.time_ and arg_364_1.time_ < var_367_1 + var_367_3 then
				local var_367_4 = (arg_364_1.time_ - var_367_1) / var_367_3
				local var_367_5 = Vector3.New(0.7, -0.985, -6)

				var_367_0.localPosition = Vector3.Lerp(arg_364_1.var_.moveOldPos1054ui_story, var_367_5, var_367_4)

				local var_367_6 = manager.ui.mainCamera.transform.position - var_367_0.position

				var_367_0.forward = Vector3.New(var_367_6.x, var_367_6.y, var_367_6.z)

				local var_367_7 = var_367_0.localEulerAngles

				var_367_7.z = 0
				var_367_7.x = 0
				var_367_0.localEulerAngles = var_367_7
			end

			if arg_364_1.time_ >= var_367_1 + var_367_3 and arg_364_1.time_ < var_367_1 + var_367_3 + arg_367_0 then
				var_367_0.localPosition = Vector3.New(0.7, -0.985, -6)

				local var_367_8 = manager.ui.mainCamera.transform.position - var_367_0.position

				var_367_0.forward = Vector3.New(var_367_8.x, var_367_8.y, var_367_8.z)

				local var_367_9 = var_367_0.localEulerAngles

				var_367_9.z = 0
				var_367_9.x = 0
				var_367_0.localEulerAngles = var_367_9

				local var_367_10 = GameObjectTools.GetOrAddComponent(var_367_0.gameObject, typeof(DynamicBoneHelper))

				if var_367_10 then
					var_367_10:EnableDynamicBone(true)
				end
			end

			local var_367_11 = arg_364_1.actors_["6148ui_story"].transform
			local var_367_12 = 0

			if var_367_12 < arg_364_1.time_ and arg_364_1.time_ <= var_367_12 + arg_367_0 then
				arg_364_1.var_.moveOldPos6148ui_story = var_367_11.localPosition

				local var_367_13 = GameObjectTools.GetOrAddComponent(var_367_11.gameObject, typeof(DynamicBoneHelper))

				if var_367_13 then
					var_367_13:EnableDynamicBone(false)
				end
			end

			local var_367_14 = 0.001

			if var_367_12 <= arg_364_1.time_ and arg_364_1.time_ < var_367_12 + var_367_14 then
				local var_367_15 = (arg_364_1.time_ - var_367_12) / var_367_14
				local var_367_16 = Vector3.New(-0.7, -0.985, -6)

				var_367_11.localPosition = Vector3.Lerp(arg_364_1.var_.moveOldPos6148ui_story, var_367_16, var_367_15)

				local var_367_17 = manager.ui.mainCamera.transform.position - var_367_11.position

				var_367_11.forward = Vector3.New(var_367_17.x, var_367_17.y, var_367_17.z)

				local var_367_18 = var_367_11.localEulerAngles

				var_367_18.z = 0
				var_367_18.x = 0
				var_367_11.localEulerAngles = var_367_18
			end

			if arg_364_1.time_ >= var_367_12 + var_367_14 and arg_364_1.time_ < var_367_12 + var_367_14 + arg_367_0 then
				var_367_11.localPosition = Vector3.New(-0.7, -0.985, -6)

				local var_367_19 = manager.ui.mainCamera.transform.position - var_367_11.position

				var_367_11.forward = Vector3.New(var_367_19.x, var_367_19.y, var_367_19.z)

				local var_367_20 = var_367_11.localEulerAngles

				var_367_20.z = 0
				var_367_20.x = 0
				var_367_11.localEulerAngles = var_367_20

				local var_367_21 = GameObjectTools.GetOrAddComponent(var_367_11.gameObject, typeof(DynamicBoneHelper))

				if var_367_21 then
					var_367_21:EnableDynamicBone(true)
				end
			end

			local var_367_22 = arg_364_1.actors_["1054ui_story"]
			local var_367_23 = 0

			if var_367_23 < arg_364_1.time_ and arg_364_1.time_ <= var_367_23 + arg_367_0 and not isNil(var_367_22) and arg_364_1.var_.characterEffect1054ui_story == nil then
				arg_364_1.var_.characterEffect1054ui_story = var_367_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_367_24 = 0.200000002980232

			if var_367_23 <= arg_364_1.time_ and arg_364_1.time_ < var_367_23 + var_367_24 and not isNil(var_367_22) then
				local var_367_25 = (arg_364_1.time_ - var_367_23) / var_367_24

				if arg_364_1.var_.characterEffect1054ui_story and not isNil(var_367_22) then
					arg_364_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_364_1.time_ >= var_367_23 + var_367_24 and arg_364_1.time_ < var_367_23 + var_367_24 + arg_367_0 and not isNil(var_367_22) and arg_364_1.var_.characterEffect1054ui_story then
				arg_364_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_367_26 = 0

			if var_367_26 < arg_364_1.time_ and arg_364_1.time_ <= var_367_26 + arg_367_0 then
				arg_364_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action4_1")
			end

			local var_367_27 = 0

			if var_367_27 < arg_364_1.time_ and arg_364_1.time_ <= var_367_27 + arg_367_0 then
				arg_364_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoC", "EmotionTimelineAnimator")
			end

			local var_367_28 = 0
			local var_367_29 = 0.725

			if var_367_28 < arg_364_1.time_ and arg_364_1.time_ <= var_367_28 + arg_367_0 then
				arg_364_1.talkMaxDuration = 0
				arg_364_1.dialogCg_.alpha = 1

				arg_364_1.dialog_:SetActive(true)
				SetActive(arg_364_1.leftNameGo_, true)

				local var_367_30 = arg_364_1:FormatText(StoryNameCfg[1487].name)

				arg_364_1.leftNameTxt_.text = var_367_30

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_364_1.leftNameTxt_.transform)

				arg_364_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_364_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_364_1:RecordName(arg_364_1.leftNameTxt_.text)
				SetActive(arg_364_1.iconTrs_.gameObject, false)
				arg_364_1.callingController_:SetSelectedState("normal")

				local var_367_31 = arg_364_1:GetWordFromCfg(426101085)
				local var_367_32 = arg_364_1:FormatText(var_367_31.content)

				arg_364_1.text_.text = var_367_32

				LuaForUtil.ClearLinePrefixSymbol(arg_364_1.text_)

				local var_367_33 = 29
				local var_367_34 = utf8.len(var_367_32)
				local var_367_35 = var_367_33 <= 0 and var_367_29 or var_367_29 * (var_367_34 / var_367_33)

				if var_367_35 > 0 and var_367_29 < var_367_35 then
					arg_364_1.talkMaxDuration = var_367_35

					if var_367_35 + var_367_28 > arg_364_1.duration_ then
						arg_364_1.duration_ = var_367_35 + var_367_28
					end
				end

				arg_364_1.text_.text = var_367_32
				arg_364_1.typewritter.percent = 0

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426101", "426101085", "story_v_out_426101.awb") ~= 0 then
					local var_367_36 = manager.audio:GetVoiceLength("story_v_out_426101", "426101085", "story_v_out_426101.awb") / 1000

					if var_367_36 + var_367_28 > arg_364_1.duration_ then
						arg_364_1.duration_ = var_367_36 + var_367_28
					end

					if var_367_31.prefab_name ~= "" and arg_364_1.actors_[var_367_31.prefab_name] ~= nil then
						local var_367_37 = LuaForUtil.PlayVoiceWithCriLipsync(arg_364_1.actors_[var_367_31.prefab_name].transform, "story_v_out_426101", "426101085", "story_v_out_426101.awb")

						arg_364_1:RecordAudio("426101085", var_367_37)
						arg_364_1:RecordAudio("426101085", var_367_37)
					else
						arg_364_1:AudioAction("play", "voice", "story_v_out_426101", "426101085", "story_v_out_426101.awb")
					end

					arg_364_1:RecordHistoryTalkVoice("story_v_out_426101", "426101085", "story_v_out_426101.awb")
				end

				arg_364_1:RecordContent(arg_364_1.text_.text)
			end

			local var_367_38 = math.max(var_367_29, arg_364_1.talkMaxDuration)

			if var_367_28 <= arg_364_1.time_ and arg_364_1.time_ < var_367_28 + var_367_38 then
				arg_364_1.typewritter.percent = (arg_364_1.time_ - var_367_28) / var_367_38

				arg_364_1.typewritter:SetDirty()
			end

			if arg_364_1.time_ >= var_367_28 + var_367_38 and arg_364_1.time_ < var_367_28 + var_367_38 + arg_367_0 then
				arg_364_1.typewritter.percent = 1

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(true)
			end
		end

		arg_364_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_364_1:InitPlayNodeList()
	end,
	Play426101086 = function(arg_368_0, arg_368_1)
		arg_368_1.time_ = 0
		arg_368_1.frameCnt_ = 0
		arg_368_1.state_ = "playing"
		arg_368_1.curTalkId_ = 426101086
		arg_368_1.duration_ = 5

		SetActive(arg_368_1.tipsGo_, false)

		function arg_368_1.onSingleLineFinish_()
			arg_368_1.onSingleLineUpdate_ = nil
			arg_368_1.onSingleLineFinish_ = nil
			arg_368_1.state_ = "waiting"
		end

		function arg_368_1.playNext_(arg_370_0)
			if arg_370_0 == 1 then
				arg_368_0:Play426101087(arg_368_1)
			end
		end

		function arg_368_1.onSingleLineUpdate_(arg_371_0)
			local var_371_0 = arg_368_1.actors_["1054ui_story"]
			local var_371_1 = 0

			if var_371_1 < arg_368_1.time_ and arg_368_1.time_ <= var_371_1 + arg_371_0 and not isNil(var_371_0) and arg_368_1.var_.characterEffect1054ui_story == nil then
				arg_368_1.var_.characterEffect1054ui_story = var_371_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_371_2 = 0.200000002980232

			if var_371_1 <= arg_368_1.time_ and arg_368_1.time_ < var_371_1 + var_371_2 and not isNil(var_371_0) then
				local var_371_3 = (arg_368_1.time_ - var_371_1) / var_371_2

				if arg_368_1.var_.characterEffect1054ui_story and not isNil(var_371_0) then
					local var_371_4 = Mathf.Lerp(0, 0.5, var_371_3)

					arg_368_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_368_1.var_.characterEffect1054ui_story.fillRatio = var_371_4
				end
			end

			if arg_368_1.time_ >= var_371_1 + var_371_2 and arg_368_1.time_ < var_371_1 + var_371_2 + arg_371_0 and not isNil(var_371_0) and arg_368_1.var_.characterEffect1054ui_story then
				local var_371_5 = 0.5

				arg_368_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_368_1.var_.characterEffect1054ui_story.fillRatio = var_371_5
			end

			local var_371_6 = 0
			local var_371_7 = 0.425

			if var_371_6 < arg_368_1.time_ and arg_368_1.time_ <= var_371_6 + arg_371_0 then
				arg_368_1.talkMaxDuration = 0
				arg_368_1.dialogCg_.alpha = 1

				arg_368_1.dialog_:SetActive(true)
				SetActive(arg_368_1.leftNameGo_, true)

				local var_371_8 = arg_368_1:FormatText(StoryNameCfg[7].name)

				arg_368_1.leftNameTxt_.text = var_371_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_368_1.leftNameTxt_.transform)

				arg_368_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_368_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_368_1:RecordName(arg_368_1.leftNameTxt_.text)
				SetActive(arg_368_1.iconTrs_.gameObject, true)
				arg_368_1.iconController_:SetSelectedState("hero")

				arg_368_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_368_1.callingController_:SetSelectedState("normal")

				arg_368_1.keyicon_.color = Color.New(1, 1, 1)
				arg_368_1.icon_.color = Color.New(1, 1, 1)

				local var_371_9 = arg_368_1:GetWordFromCfg(426101086)
				local var_371_10 = arg_368_1:FormatText(var_371_9.content)

				arg_368_1.text_.text = var_371_10

				LuaForUtil.ClearLinePrefixSymbol(arg_368_1.text_)

				local var_371_11 = 17
				local var_371_12 = utf8.len(var_371_10)
				local var_371_13 = var_371_11 <= 0 and var_371_7 or var_371_7 * (var_371_12 / var_371_11)

				if var_371_13 > 0 and var_371_7 < var_371_13 then
					arg_368_1.talkMaxDuration = var_371_13

					if var_371_13 + var_371_6 > arg_368_1.duration_ then
						arg_368_1.duration_ = var_371_13 + var_371_6
					end
				end

				arg_368_1.text_.text = var_371_10
				arg_368_1.typewritter.percent = 0

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(false)
				arg_368_1:RecordContent(arg_368_1.text_.text)
			end

			local var_371_14 = math.max(var_371_7, arg_368_1.talkMaxDuration)

			if var_371_6 <= arg_368_1.time_ and arg_368_1.time_ < var_371_6 + var_371_14 then
				arg_368_1.typewritter.percent = (arg_368_1.time_ - var_371_6) / var_371_14

				arg_368_1.typewritter:SetDirty()
			end

			if arg_368_1.time_ >= var_371_6 + var_371_14 and arg_368_1.time_ < var_371_6 + var_371_14 + arg_371_0 then
				arg_368_1.typewritter.percent = 1

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(true)
			end
		end

		arg_368_1.nodeConfigList_ = {}

		arg_368_1:InitPlayNodeList()
	end,
	Play426101087 = function(arg_372_0, arg_372_1)
		arg_372_1.time_ = 0
		arg_372_1.frameCnt_ = 0
		arg_372_1.state_ = "playing"
		arg_372_1.curTalkId_ = 426101087
		arg_372_1.duration_ = 8.2

		local var_372_0 = {
			zh = 8.2,
			ja = 6.266
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
				arg_372_0:Play426101088(arg_372_1)
			end
		end

		function arg_372_1.onSingleLineUpdate_(arg_375_0)
			local var_375_0 = arg_372_1.actors_["6148ui_story"].transform
			local var_375_1 = 0

			if var_375_1 < arg_372_1.time_ and arg_372_1.time_ <= var_375_1 + arg_375_0 then
				arg_372_1.var_.moveOldPos6148ui_story = var_375_0.localPosition

				local var_375_2 = GameObjectTools.GetOrAddComponent(var_375_0.gameObject, typeof(DynamicBoneHelper))

				if var_375_2 then
					var_375_2:EnableDynamicBone(false)
				end
			end

			local var_375_3 = 0.001

			if var_375_1 <= arg_372_1.time_ and arg_372_1.time_ < var_375_1 + var_375_3 then
				local var_375_4 = (arg_372_1.time_ - var_375_1) / var_375_3
				local var_375_5 = Vector3.New(-0.7, -0.985, -6)

				var_375_0.localPosition = Vector3.Lerp(arg_372_1.var_.moveOldPos6148ui_story, var_375_5, var_375_4)

				local var_375_6 = manager.ui.mainCamera.transform.position - var_375_0.position

				var_375_0.forward = Vector3.New(var_375_6.x, var_375_6.y, var_375_6.z)

				local var_375_7 = var_375_0.localEulerAngles

				var_375_7.z = 0
				var_375_7.x = 0
				var_375_0.localEulerAngles = var_375_7
			end

			if arg_372_1.time_ >= var_375_1 + var_375_3 and arg_372_1.time_ < var_375_1 + var_375_3 + arg_375_0 then
				var_375_0.localPosition = Vector3.New(-0.7, -0.985, -6)

				local var_375_8 = manager.ui.mainCamera.transform.position - var_375_0.position

				var_375_0.forward = Vector3.New(var_375_8.x, var_375_8.y, var_375_8.z)

				local var_375_9 = var_375_0.localEulerAngles

				var_375_9.z = 0
				var_375_9.x = 0
				var_375_0.localEulerAngles = var_375_9

				local var_375_10 = GameObjectTools.GetOrAddComponent(var_375_0.gameObject, typeof(DynamicBoneHelper))

				if var_375_10 then
					var_375_10:EnableDynamicBone(true)
				end
			end

			local var_375_11 = arg_372_1.actors_["6148ui_story"]
			local var_375_12 = 0

			if var_375_12 < arg_372_1.time_ and arg_372_1.time_ <= var_375_12 + arg_375_0 and not isNil(var_375_11) and arg_372_1.var_.characterEffect6148ui_story == nil then
				arg_372_1.var_.characterEffect6148ui_story = var_375_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_375_13 = 0.200000002980232

			if var_375_12 <= arg_372_1.time_ and arg_372_1.time_ < var_375_12 + var_375_13 and not isNil(var_375_11) then
				local var_375_14 = (arg_372_1.time_ - var_375_12) / var_375_13

				if arg_372_1.var_.characterEffect6148ui_story and not isNil(var_375_11) then
					arg_372_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_372_1.time_ >= var_375_12 + var_375_13 and arg_372_1.time_ < var_375_12 + var_375_13 + arg_375_0 and not isNil(var_375_11) and arg_372_1.var_.characterEffect6148ui_story then
				arg_372_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_375_15 = 0

			if var_375_15 < arg_372_1.time_ and arg_372_1.time_ <= var_375_15 + arg_375_0 then
				arg_372_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action6_1")
			end

			local var_375_16 = 0

			if var_375_16 < arg_372_1.time_ and arg_372_1.time_ <= var_375_16 + arg_375_0 then
				arg_372_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_375_17 = 0
			local var_375_18 = 0.725

			if var_375_17 < arg_372_1.time_ and arg_372_1.time_ <= var_375_17 + arg_375_0 then
				arg_372_1.talkMaxDuration = 0
				arg_372_1.dialogCg_.alpha = 1

				arg_372_1.dialog_:SetActive(true)
				SetActive(arg_372_1.leftNameGo_, true)

				local var_375_19 = arg_372_1:FormatText(StoryNameCfg[1488].name)

				arg_372_1.leftNameTxt_.text = var_375_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_372_1.leftNameTxt_.transform)

				arg_372_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_372_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_372_1:RecordName(arg_372_1.leftNameTxt_.text)
				SetActive(arg_372_1.iconTrs_.gameObject, false)
				arg_372_1.callingController_:SetSelectedState("normal")

				local var_375_20 = arg_372_1:GetWordFromCfg(426101087)
				local var_375_21 = arg_372_1:FormatText(var_375_20.content)

				arg_372_1.text_.text = var_375_21

				LuaForUtil.ClearLinePrefixSymbol(arg_372_1.text_)

				local var_375_22 = 29
				local var_375_23 = utf8.len(var_375_21)
				local var_375_24 = var_375_22 <= 0 and var_375_18 or var_375_18 * (var_375_23 / var_375_22)

				if var_375_24 > 0 and var_375_18 < var_375_24 then
					arg_372_1.talkMaxDuration = var_375_24

					if var_375_24 + var_375_17 > arg_372_1.duration_ then
						arg_372_1.duration_ = var_375_24 + var_375_17
					end
				end

				arg_372_1.text_.text = var_375_21
				arg_372_1.typewritter.percent = 0

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426101", "426101087", "story_v_out_426101.awb") ~= 0 then
					local var_375_25 = manager.audio:GetVoiceLength("story_v_out_426101", "426101087", "story_v_out_426101.awb") / 1000

					if var_375_25 + var_375_17 > arg_372_1.duration_ then
						arg_372_1.duration_ = var_375_25 + var_375_17
					end

					if var_375_20.prefab_name ~= "" and arg_372_1.actors_[var_375_20.prefab_name] ~= nil then
						local var_375_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_372_1.actors_[var_375_20.prefab_name].transform, "story_v_out_426101", "426101087", "story_v_out_426101.awb")

						arg_372_1:RecordAudio("426101087", var_375_26)
						arg_372_1:RecordAudio("426101087", var_375_26)
					else
						arg_372_1:AudioAction("play", "voice", "story_v_out_426101", "426101087", "story_v_out_426101.awb")
					end

					arg_372_1:RecordHistoryTalkVoice("story_v_out_426101", "426101087", "story_v_out_426101.awb")
				end

				arg_372_1:RecordContent(arg_372_1.text_.text)
			end

			local var_375_27 = math.max(var_375_18, arg_372_1.talkMaxDuration)

			if var_375_17 <= arg_372_1.time_ and arg_372_1.time_ < var_375_17 + var_375_27 then
				arg_372_1.typewritter.percent = (arg_372_1.time_ - var_375_17) / var_375_27

				arg_372_1.typewritter:SetDirty()
			end

			if arg_372_1.time_ >= var_375_17 + var_375_27 and arg_372_1.time_ < var_375_17 + var_375_27 + arg_375_0 then
				arg_372_1.typewritter.percent = 1

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(true)
			end
		end

		arg_372_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_372_1:InitPlayNodeList()
	end,
	Play426101088 = function(arg_376_0, arg_376_1)
		arg_376_1.time_ = 0
		arg_376_1.frameCnt_ = 0
		arg_376_1.state_ = "playing"
		arg_376_1.curTalkId_ = 426101088
		arg_376_1.duration_ = 5

		SetActive(arg_376_1.tipsGo_, false)

		function arg_376_1.onSingleLineFinish_()
			arg_376_1.onSingleLineUpdate_ = nil
			arg_376_1.onSingleLineFinish_ = nil
			arg_376_1.state_ = "waiting"
		end

		function arg_376_1.playNext_(arg_378_0)
			if arg_378_0 == 1 then
				arg_376_0:Play426101089(arg_376_1)
			end
		end

		function arg_376_1.onSingleLineUpdate_(arg_379_0)
			local var_379_0 = arg_376_1.actors_["6148ui_story"].transform
			local var_379_1 = 0

			if var_379_1 < arg_376_1.time_ and arg_376_1.time_ <= var_379_1 + arg_379_0 then
				arg_376_1.var_.moveOldPos6148ui_story = var_379_0.localPosition

				local var_379_2 = GameObjectTools.GetOrAddComponent(var_379_0.gameObject, typeof(DynamicBoneHelper))

				if var_379_2 then
					var_379_2:EnableDynamicBone(false)
				end
			end

			local var_379_3 = 0.001

			if var_379_1 <= arg_376_1.time_ and arg_376_1.time_ < var_379_1 + var_379_3 then
				local var_379_4 = (arg_376_1.time_ - var_379_1) / var_379_3
				local var_379_5 = Vector3.New(0, 100, 0)

				var_379_0.localPosition = Vector3.Lerp(arg_376_1.var_.moveOldPos6148ui_story, var_379_5, var_379_4)

				local var_379_6 = manager.ui.mainCamera.transform.position - var_379_0.position

				var_379_0.forward = Vector3.New(var_379_6.x, var_379_6.y, var_379_6.z)

				local var_379_7 = var_379_0.localEulerAngles

				var_379_7.z = 0
				var_379_7.x = 0
				var_379_0.localEulerAngles = var_379_7
			end

			if arg_376_1.time_ >= var_379_1 + var_379_3 and arg_376_1.time_ < var_379_1 + var_379_3 + arg_379_0 then
				var_379_0.localPosition = Vector3.New(0, 100, 0)

				local var_379_8 = manager.ui.mainCamera.transform.position - var_379_0.position

				var_379_0.forward = Vector3.New(var_379_8.x, var_379_8.y, var_379_8.z)

				local var_379_9 = var_379_0.localEulerAngles

				var_379_9.z = 0
				var_379_9.x = 0
				var_379_0.localEulerAngles = var_379_9

				local var_379_10 = GameObjectTools.GetOrAddComponent(var_379_0.gameObject, typeof(DynamicBoneHelper))

				if var_379_10 then
					var_379_10:EnableDynamicBone(true)
				end
			end

			local var_379_11 = arg_376_1.actors_["1054ui_story"].transform
			local var_379_12 = 0

			if var_379_12 < arg_376_1.time_ and arg_376_1.time_ <= var_379_12 + arg_379_0 then
				arg_376_1.var_.moveOldPos1054ui_story = var_379_11.localPosition

				local var_379_13 = GameObjectTools.GetOrAddComponent(var_379_11.gameObject, typeof(DynamicBoneHelper))

				if var_379_13 then
					var_379_13:EnableDynamicBone(false)
				end
			end

			local var_379_14 = 0.001

			if var_379_12 <= arg_376_1.time_ and arg_376_1.time_ < var_379_12 + var_379_14 then
				local var_379_15 = (arg_376_1.time_ - var_379_12) / var_379_14
				local var_379_16 = Vector3.New(0, 100, 0)

				var_379_11.localPosition = Vector3.Lerp(arg_376_1.var_.moveOldPos1054ui_story, var_379_16, var_379_15)

				local var_379_17 = manager.ui.mainCamera.transform.position - var_379_11.position

				var_379_11.forward = Vector3.New(var_379_17.x, var_379_17.y, var_379_17.z)

				local var_379_18 = var_379_11.localEulerAngles

				var_379_18.z = 0
				var_379_18.x = 0
				var_379_11.localEulerAngles = var_379_18
			end

			if arg_376_1.time_ >= var_379_12 + var_379_14 and arg_376_1.time_ < var_379_12 + var_379_14 + arg_379_0 then
				var_379_11.localPosition = Vector3.New(0, 100, 0)

				local var_379_19 = manager.ui.mainCamera.transform.position - var_379_11.position

				var_379_11.forward = Vector3.New(var_379_19.x, var_379_19.y, var_379_19.z)

				local var_379_20 = var_379_11.localEulerAngles

				var_379_20.z = 0
				var_379_20.x = 0
				var_379_11.localEulerAngles = var_379_20

				local var_379_21 = GameObjectTools.GetOrAddComponent(var_379_11.gameObject, typeof(DynamicBoneHelper))

				if var_379_21 then
					var_379_21:EnableDynamicBone(true)
				end
			end

			local var_379_22 = arg_376_1.actors_["6148ui_story"]
			local var_379_23 = 0

			if var_379_23 < arg_376_1.time_ and arg_376_1.time_ <= var_379_23 + arg_379_0 and not isNil(var_379_22) and arg_376_1.var_.characterEffect6148ui_story == nil then
				arg_376_1.var_.characterEffect6148ui_story = var_379_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_379_24 = 0.200000002980232

			if var_379_23 <= arg_376_1.time_ and arg_376_1.time_ < var_379_23 + var_379_24 and not isNil(var_379_22) then
				local var_379_25 = (arg_376_1.time_ - var_379_23) / var_379_24

				if arg_376_1.var_.characterEffect6148ui_story and not isNil(var_379_22) then
					local var_379_26 = Mathf.Lerp(0, 0.5, var_379_25)

					arg_376_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_376_1.var_.characterEffect6148ui_story.fillRatio = var_379_26
				end
			end

			if arg_376_1.time_ >= var_379_23 + var_379_24 and arg_376_1.time_ < var_379_23 + var_379_24 + arg_379_0 and not isNil(var_379_22) and arg_376_1.var_.characterEffect6148ui_story then
				local var_379_27 = 0.5

				arg_376_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_376_1.var_.characterEffect6148ui_story.fillRatio = var_379_27
			end

			local var_379_28 = 0
			local var_379_29 = 1.15

			if var_379_28 < arg_376_1.time_ and arg_376_1.time_ <= var_379_28 + arg_379_0 then
				arg_376_1.talkMaxDuration = 0
				arg_376_1.dialogCg_.alpha = 1

				arg_376_1.dialog_:SetActive(true)
				SetActive(arg_376_1.leftNameGo_, false)

				arg_376_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_376_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_376_1:RecordName(arg_376_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_376_1.iconTrs_.gameObject, false)
				arg_376_1.callingController_:SetSelectedState("normal")

				local var_379_30 = arg_376_1:GetWordFromCfg(426101088)
				local var_379_31 = arg_376_1:FormatText(var_379_30.content)

				arg_376_1.text_.text = var_379_31

				LuaForUtil.ClearLinePrefixSymbol(arg_376_1.text_)

				local var_379_32 = 46
				local var_379_33 = utf8.len(var_379_31)
				local var_379_34 = var_379_32 <= 0 and var_379_29 or var_379_29 * (var_379_33 / var_379_32)

				if var_379_34 > 0 and var_379_29 < var_379_34 then
					arg_376_1.talkMaxDuration = var_379_34

					if var_379_34 + var_379_28 > arg_376_1.duration_ then
						arg_376_1.duration_ = var_379_34 + var_379_28
					end
				end

				arg_376_1.text_.text = var_379_31
				arg_376_1.typewritter.percent = 0

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(false)
				arg_376_1:RecordContent(arg_376_1.text_.text)
			end

			local var_379_35 = math.max(var_379_29, arg_376_1.talkMaxDuration)

			if var_379_28 <= arg_376_1.time_ and arg_376_1.time_ < var_379_28 + var_379_35 then
				arg_376_1.typewritter.percent = (arg_376_1.time_ - var_379_28) / var_379_35

				arg_376_1.typewritter:SetDirty()
			end

			if arg_376_1.time_ >= var_379_28 + var_379_35 and arg_376_1.time_ < var_379_28 + var_379_35 + arg_379_0 then
				arg_376_1.typewritter.percent = 1

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(true)
			end
		end

		arg_376_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_376_1:InitPlayNodeList()
	end,
	Play426101089 = function(arg_380_0, arg_380_1)
		arg_380_1.time_ = 0
		arg_380_1.frameCnt_ = 0
		arg_380_1.state_ = "playing"
		arg_380_1.curTalkId_ = 426101089
		arg_380_1.duration_ = 7.13

		local var_380_0 = {
			zh = 5.966,
			ja = 7.133
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
				arg_380_0:Play426101090(arg_380_1)
			end
		end

		function arg_380_1.onSingleLineUpdate_(arg_383_0)
			local var_383_0 = 0
			local var_383_1 = 0.525

			if var_383_0 < arg_380_1.time_ and arg_380_1.time_ <= var_383_0 + arg_383_0 then
				arg_380_1.talkMaxDuration = 0
				arg_380_1.dialogCg_.alpha = 1

				arg_380_1.dialog_:SetActive(true)
				SetActive(arg_380_1.leftNameGo_, true)

				local var_383_2 = arg_380_1:FormatText(StoryNameCfg[1487].name)

				arg_380_1.leftNameTxt_.text = var_383_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_380_1.leftNameTxt_.transform)

				arg_380_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_380_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_380_1:RecordName(arg_380_1.leftNameTxt_.text)
				SetActive(arg_380_1.iconTrs_.gameObject, true)
				arg_380_1.iconController_:SetSelectedState("hero")

				arg_380_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1054")

				arg_380_1.callingController_:SetSelectedState("normal")

				arg_380_1.keyicon_.color = Color.New(1, 1, 1)
				arg_380_1.icon_.color = Color.New(1, 1, 1)

				local var_383_3 = arg_380_1:GetWordFromCfg(426101089)
				local var_383_4 = arg_380_1:FormatText(var_383_3.content)

				arg_380_1.text_.text = var_383_4

				LuaForUtil.ClearLinePrefixSymbol(arg_380_1.text_)

				local var_383_5 = 21
				local var_383_6 = utf8.len(var_383_4)
				local var_383_7 = var_383_5 <= 0 and var_383_1 or var_383_1 * (var_383_6 / var_383_5)

				if var_383_7 > 0 and var_383_1 < var_383_7 then
					arg_380_1.talkMaxDuration = var_383_7

					if var_383_7 + var_383_0 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_7 + var_383_0
					end
				end

				arg_380_1.text_.text = var_383_4
				arg_380_1.typewritter.percent = 0

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426101", "426101089", "story_v_out_426101.awb") ~= 0 then
					local var_383_8 = manager.audio:GetVoiceLength("story_v_out_426101", "426101089", "story_v_out_426101.awb") / 1000

					if var_383_8 + var_383_0 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_8 + var_383_0
					end

					if var_383_3.prefab_name ~= "" and arg_380_1.actors_[var_383_3.prefab_name] ~= nil then
						local var_383_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_380_1.actors_[var_383_3.prefab_name].transform, "story_v_out_426101", "426101089", "story_v_out_426101.awb")

						arg_380_1:RecordAudio("426101089", var_383_9)
						arg_380_1:RecordAudio("426101089", var_383_9)
					else
						arg_380_1:AudioAction("play", "voice", "story_v_out_426101", "426101089", "story_v_out_426101.awb")
					end

					arg_380_1:RecordHistoryTalkVoice("story_v_out_426101", "426101089", "story_v_out_426101.awb")
				end

				arg_380_1:RecordContent(arg_380_1.text_.text)
			end

			local var_383_10 = math.max(var_383_1, arg_380_1.talkMaxDuration)

			if var_383_0 <= arg_380_1.time_ and arg_380_1.time_ < var_383_0 + var_383_10 then
				arg_380_1.typewritter.percent = (arg_380_1.time_ - var_383_0) / var_383_10

				arg_380_1.typewritter:SetDirty()
			end

			if arg_380_1.time_ >= var_383_0 + var_383_10 and arg_380_1.time_ < var_383_0 + var_383_10 + arg_383_0 then
				arg_380_1.typewritter.percent = 1

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(true)
			end
		end

		arg_380_1.nodeConfigList_ = {}

		arg_380_1:InitPlayNodeList()
	end,
	Play426101090 = function(arg_384_0, arg_384_1)
		arg_384_1.time_ = 0
		arg_384_1.frameCnt_ = 0
		arg_384_1.state_ = "playing"
		arg_384_1.curTalkId_ = 426101090
		arg_384_1.duration_ = 5

		SetActive(arg_384_1.tipsGo_, false)

		function arg_384_1.onSingleLineFinish_()
			arg_384_1.onSingleLineUpdate_ = nil
			arg_384_1.onSingleLineFinish_ = nil
			arg_384_1.state_ = "waiting"
		end

		function arg_384_1.playNext_(arg_386_0)
			if arg_386_0 == 1 then
				arg_384_0:Play426101091(arg_384_1)
			end
		end

		function arg_384_1.onSingleLineUpdate_(arg_387_0)
			local var_387_0 = 0
			local var_387_1 = 0.55

			if var_387_0 < arg_384_1.time_ and arg_384_1.time_ <= var_387_0 + arg_387_0 then
				arg_384_1.talkMaxDuration = 0
				arg_384_1.dialogCg_.alpha = 1

				arg_384_1.dialog_:SetActive(true)
				SetActive(arg_384_1.leftNameGo_, true)

				local var_387_2 = arg_384_1:FormatText(StoryNameCfg[7].name)

				arg_384_1.leftNameTxt_.text = var_387_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_384_1.leftNameTxt_.transform)

				arg_384_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_384_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_384_1:RecordName(arg_384_1.leftNameTxt_.text)
				SetActive(arg_384_1.iconTrs_.gameObject, true)
				arg_384_1.iconController_:SetSelectedState("hero")

				arg_384_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_384_1.callingController_:SetSelectedState("normal")

				arg_384_1.keyicon_.color = Color.New(1, 1, 1)
				arg_384_1.icon_.color = Color.New(1, 1, 1)

				local var_387_3 = arg_384_1:GetWordFromCfg(426101090)
				local var_387_4 = arg_384_1:FormatText(var_387_3.content)

				arg_384_1.text_.text = var_387_4

				LuaForUtil.ClearLinePrefixSymbol(arg_384_1.text_)

				local var_387_5 = 22
				local var_387_6 = utf8.len(var_387_4)
				local var_387_7 = var_387_5 <= 0 and var_387_1 or var_387_1 * (var_387_6 / var_387_5)

				if var_387_7 > 0 and var_387_1 < var_387_7 then
					arg_384_1.talkMaxDuration = var_387_7

					if var_387_7 + var_387_0 > arg_384_1.duration_ then
						arg_384_1.duration_ = var_387_7 + var_387_0
					end
				end

				arg_384_1.text_.text = var_387_4
				arg_384_1.typewritter.percent = 0

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(false)
				arg_384_1:RecordContent(arg_384_1.text_.text)
			end

			local var_387_8 = math.max(var_387_1, arg_384_1.talkMaxDuration)

			if var_387_0 <= arg_384_1.time_ and arg_384_1.time_ < var_387_0 + var_387_8 then
				arg_384_1.typewritter.percent = (arg_384_1.time_ - var_387_0) / var_387_8

				arg_384_1.typewritter:SetDirty()
			end

			if arg_384_1.time_ >= var_387_0 + var_387_8 and arg_384_1.time_ < var_387_0 + var_387_8 + arg_387_0 then
				arg_384_1.typewritter.percent = 1

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(true)
			end
		end

		arg_384_1.nodeConfigList_ = {}

		arg_384_1:InitPlayNodeList()
	end,
	Play426101091 = function(arg_388_0, arg_388_1)
		arg_388_1.time_ = 0
		arg_388_1.frameCnt_ = 0
		arg_388_1.state_ = "playing"
		arg_388_1.curTalkId_ = 426101091
		arg_388_1.duration_ = 5

		SetActive(arg_388_1.tipsGo_, false)

		function arg_388_1.onSingleLineFinish_()
			arg_388_1.onSingleLineUpdate_ = nil
			arg_388_1.onSingleLineFinish_ = nil
			arg_388_1.state_ = "waiting"
		end

		function arg_388_1.playNext_(arg_390_0)
			if arg_390_0 == 1 then
				arg_388_0:Play426101092(arg_388_1)
			end
		end

		function arg_388_1.onSingleLineUpdate_(arg_391_0)
			local var_391_0 = 0
			local var_391_1 = 0.55

			if var_391_0 < arg_388_1.time_ and arg_388_1.time_ <= var_391_0 + arg_391_0 then
				arg_388_1.talkMaxDuration = 0
				arg_388_1.dialogCg_.alpha = 1

				arg_388_1.dialog_:SetActive(true)
				SetActive(arg_388_1.leftNameGo_, false)

				arg_388_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_388_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_388_1:RecordName(arg_388_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_388_1.iconTrs_.gameObject, false)
				arg_388_1.callingController_:SetSelectedState("normal")

				local var_391_2 = arg_388_1:GetWordFromCfg(426101091)
				local var_391_3 = arg_388_1:FormatText(var_391_2.content)

				arg_388_1.text_.text = var_391_3

				LuaForUtil.ClearLinePrefixSymbol(arg_388_1.text_)

				local var_391_4 = 22
				local var_391_5 = utf8.len(var_391_3)
				local var_391_6 = var_391_4 <= 0 and var_391_1 or var_391_1 * (var_391_5 / var_391_4)

				if var_391_6 > 0 and var_391_1 < var_391_6 then
					arg_388_1.talkMaxDuration = var_391_6

					if var_391_6 + var_391_0 > arg_388_1.duration_ then
						arg_388_1.duration_ = var_391_6 + var_391_0
					end
				end

				arg_388_1.text_.text = var_391_3
				arg_388_1.typewritter.percent = 0

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(false)
				arg_388_1:RecordContent(arg_388_1.text_.text)
			end

			local var_391_7 = math.max(var_391_1, arg_388_1.talkMaxDuration)

			if var_391_0 <= arg_388_1.time_ and arg_388_1.time_ < var_391_0 + var_391_7 then
				arg_388_1.typewritter.percent = (arg_388_1.time_ - var_391_0) / var_391_7

				arg_388_1.typewritter:SetDirty()
			end

			if arg_388_1.time_ >= var_391_0 + var_391_7 and arg_388_1.time_ < var_391_0 + var_391_7 + arg_391_0 then
				arg_388_1.typewritter.percent = 1

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(true)
			end
		end

		arg_388_1.nodeConfigList_ = {}

		arg_388_1:InitPlayNodeList()
	end,
	Play426101092 = function(arg_392_0, arg_392_1)
		arg_392_1.time_ = 0
		arg_392_1.frameCnt_ = 0
		arg_392_1.state_ = "playing"
		arg_392_1.curTalkId_ = 426101092
		arg_392_1.duration_ = 7.4

		local var_392_0 = {
			zh = 6,
			ja = 7.4
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
				arg_392_0:Play426101093(arg_392_1)
			end
		end

		function arg_392_1.onSingleLineUpdate_(arg_395_0)
			local var_395_0 = arg_392_1.actors_["6148ui_story"].transform
			local var_395_1 = 0

			if var_395_1 < arg_392_1.time_ and arg_392_1.time_ <= var_395_1 + arg_395_0 then
				arg_392_1.var_.moveOldPos6148ui_story = var_395_0.localPosition

				local var_395_2 = GameObjectTools.GetOrAddComponent(var_395_0.gameObject, typeof(DynamicBoneHelper))

				if var_395_2 then
					var_395_2:EnableDynamicBone(false)
				end
			end

			local var_395_3 = 0.001

			if var_395_1 <= arg_392_1.time_ and arg_392_1.time_ < var_395_1 + var_395_3 then
				local var_395_4 = (arg_392_1.time_ - var_395_1) / var_395_3
				local var_395_5 = Vector3.New(-0.7, -0.985, -6)

				var_395_0.localPosition = Vector3.Lerp(arg_392_1.var_.moveOldPos6148ui_story, var_395_5, var_395_4)

				local var_395_6 = manager.ui.mainCamera.transform.position - var_395_0.position

				var_395_0.forward = Vector3.New(var_395_6.x, var_395_6.y, var_395_6.z)

				local var_395_7 = var_395_0.localEulerAngles

				var_395_7.z = 0
				var_395_7.x = 0
				var_395_0.localEulerAngles = var_395_7
			end

			if arg_392_1.time_ >= var_395_1 + var_395_3 and arg_392_1.time_ < var_395_1 + var_395_3 + arg_395_0 then
				var_395_0.localPosition = Vector3.New(-0.7, -0.985, -6)

				local var_395_8 = manager.ui.mainCamera.transform.position - var_395_0.position

				var_395_0.forward = Vector3.New(var_395_8.x, var_395_8.y, var_395_8.z)

				local var_395_9 = var_395_0.localEulerAngles

				var_395_9.z = 0
				var_395_9.x = 0
				var_395_0.localEulerAngles = var_395_9

				local var_395_10 = GameObjectTools.GetOrAddComponent(var_395_0.gameObject, typeof(DynamicBoneHelper))

				if var_395_10 then
					var_395_10:EnableDynamicBone(true)
				end
			end

			local var_395_11 = arg_392_1.actors_["6148ui_story"]
			local var_395_12 = 0

			if var_395_12 < arg_392_1.time_ and arg_392_1.time_ <= var_395_12 + arg_395_0 and not isNil(var_395_11) and arg_392_1.var_.characterEffect6148ui_story == nil then
				arg_392_1.var_.characterEffect6148ui_story = var_395_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_395_13 = 0.200000002980232

			if var_395_12 <= arg_392_1.time_ and arg_392_1.time_ < var_395_12 + var_395_13 and not isNil(var_395_11) then
				local var_395_14 = (arg_392_1.time_ - var_395_12) / var_395_13

				if arg_392_1.var_.characterEffect6148ui_story and not isNil(var_395_11) then
					arg_392_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_392_1.time_ >= var_395_12 + var_395_13 and arg_392_1.time_ < var_395_12 + var_395_13 + arg_395_0 and not isNil(var_395_11) and arg_392_1.var_.characterEffect6148ui_story then
				arg_392_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_395_15 = 0

			if var_395_15 < arg_392_1.time_ and arg_392_1.time_ <= var_395_15 + arg_395_0 then
				arg_392_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action1_1")
			end

			local var_395_16 = 0

			if var_395_16 < arg_392_1.time_ and arg_392_1.time_ <= var_395_16 + arg_395_0 then
				arg_392_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_395_17 = 0
			local var_395_18 = 0.825

			if var_395_17 < arg_392_1.time_ and arg_392_1.time_ <= var_395_17 + arg_395_0 then
				arg_392_1.talkMaxDuration = 0
				arg_392_1.dialogCg_.alpha = 1

				arg_392_1.dialog_:SetActive(true)
				SetActive(arg_392_1.leftNameGo_, true)

				local var_395_19 = arg_392_1:FormatText(StoryNameCfg[1488].name)

				arg_392_1.leftNameTxt_.text = var_395_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_392_1.leftNameTxt_.transform)

				arg_392_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_392_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_392_1:RecordName(arg_392_1.leftNameTxt_.text)
				SetActive(arg_392_1.iconTrs_.gameObject, false)
				arg_392_1.callingController_:SetSelectedState("normal")

				local var_395_20 = arg_392_1:GetWordFromCfg(426101092)
				local var_395_21 = arg_392_1:FormatText(var_395_20.content)

				arg_392_1.text_.text = var_395_21

				LuaForUtil.ClearLinePrefixSymbol(arg_392_1.text_)

				local var_395_22 = 33
				local var_395_23 = utf8.len(var_395_21)
				local var_395_24 = var_395_22 <= 0 and var_395_18 or var_395_18 * (var_395_23 / var_395_22)

				if var_395_24 > 0 and var_395_18 < var_395_24 then
					arg_392_1.talkMaxDuration = var_395_24

					if var_395_24 + var_395_17 > arg_392_1.duration_ then
						arg_392_1.duration_ = var_395_24 + var_395_17
					end
				end

				arg_392_1.text_.text = var_395_21
				arg_392_1.typewritter.percent = 0

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426101", "426101092", "story_v_out_426101.awb") ~= 0 then
					local var_395_25 = manager.audio:GetVoiceLength("story_v_out_426101", "426101092", "story_v_out_426101.awb") / 1000

					if var_395_25 + var_395_17 > arg_392_1.duration_ then
						arg_392_1.duration_ = var_395_25 + var_395_17
					end

					if var_395_20.prefab_name ~= "" and arg_392_1.actors_[var_395_20.prefab_name] ~= nil then
						local var_395_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_392_1.actors_[var_395_20.prefab_name].transform, "story_v_out_426101", "426101092", "story_v_out_426101.awb")

						arg_392_1:RecordAudio("426101092", var_395_26)
						arg_392_1:RecordAudio("426101092", var_395_26)
					else
						arg_392_1:AudioAction("play", "voice", "story_v_out_426101", "426101092", "story_v_out_426101.awb")
					end

					arg_392_1:RecordHistoryTalkVoice("story_v_out_426101", "426101092", "story_v_out_426101.awb")
				end

				arg_392_1:RecordContent(arg_392_1.text_.text)
			end

			local var_395_27 = math.max(var_395_18, arg_392_1.talkMaxDuration)

			if var_395_17 <= arg_392_1.time_ and arg_392_1.time_ < var_395_17 + var_395_27 then
				arg_392_1.typewritter.percent = (arg_392_1.time_ - var_395_17) / var_395_27

				arg_392_1.typewritter:SetDirty()
			end

			if arg_392_1.time_ >= var_395_17 + var_395_27 and arg_392_1.time_ < var_395_17 + var_395_27 + arg_395_0 then
				arg_392_1.typewritter.percent = 1

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(true)
			end
		end

		arg_392_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_392_1:InitPlayNodeList()
	end,
	Play426101093 = function(arg_396_0, arg_396_1)
		arg_396_1.time_ = 0
		arg_396_1.frameCnt_ = 0
		arg_396_1.state_ = "playing"
		arg_396_1.curTalkId_ = 426101093
		arg_396_1.duration_ = 5

		SetActive(arg_396_1.tipsGo_, false)

		function arg_396_1.onSingleLineFinish_()
			arg_396_1.onSingleLineUpdate_ = nil
			arg_396_1.onSingleLineFinish_ = nil
			arg_396_1.state_ = "waiting"
		end

		function arg_396_1.playNext_(arg_398_0)
			if arg_398_0 == 1 then
				arg_396_0:Play426101094(arg_396_1)
			end
		end

		function arg_396_1.onSingleLineUpdate_(arg_399_0)
			local var_399_0 = arg_396_1.actors_["6148ui_story"]
			local var_399_1 = 0

			if var_399_1 < arg_396_1.time_ and arg_396_1.time_ <= var_399_1 + arg_399_0 and not isNil(var_399_0) and arg_396_1.var_.characterEffect6148ui_story == nil then
				arg_396_1.var_.characterEffect6148ui_story = var_399_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_399_2 = 0.200000002980232

			if var_399_1 <= arg_396_1.time_ and arg_396_1.time_ < var_399_1 + var_399_2 and not isNil(var_399_0) then
				local var_399_3 = (arg_396_1.time_ - var_399_1) / var_399_2

				if arg_396_1.var_.characterEffect6148ui_story and not isNil(var_399_0) then
					local var_399_4 = Mathf.Lerp(0, 0.5, var_399_3)

					arg_396_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_396_1.var_.characterEffect6148ui_story.fillRatio = var_399_4
				end
			end

			if arg_396_1.time_ >= var_399_1 + var_399_2 and arg_396_1.time_ < var_399_1 + var_399_2 + arg_399_0 and not isNil(var_399_0) and arg_396_1.var_.characterEffect6148ui_story then
				local var_399_5 = 0.5

				arg_396_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_396_1.var_.characterEffect6148ui_story.fillRatio = var_399_5
			end

			local var_399_6 = 0
			local var_399_7 = 0.4

			if var_399_6 < arg_396_1.time_ and arg_396_1.time_ <= var_399_6 + arg_399_0 then
				arg_396_1.talkMaxDuration = 0
				arg_396_1.dialogCg_.alpha = 1

				arg_396_1.dialog_:SetActive(true)
				SetActive(arg_396_1.leftNameGo_, true)

				local var_399_8 = arg_396_1:FormatText(StoryNameCfg[7].name)

				arg_396_1.leftNameTxt_.text = var_399_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_396_1.leftNameTxt_.transform)

				arg_396_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_396_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_396_1:RecordName(arg_396_1.leftNameTxt_.text)
				SetActive(arg_396_1.iconTrs_.gameObject, true)
				arg_396_1.iconController_:SetSelectedState("hero")

				arg_396_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_396_1.callingController_:SetSelectedState("normal")

				arg_396_1.keyicon_.color = Color.New(1, 1, 1)
				arg_396_1.icon_.color = Color.New(1, 1, 1)

				local var_399_9 = arg_396_1:GetWordFromCfg(426101093)
				local var_399_10 = arg_396_1:FormatText(var_399_9.content)

				arg_396_1.text_.text = var_399_10

				LuaForUtil.ClearLinePrefixSymbol(arg_396_1.text_)

				local var_399_11 = 16
				local var_399_12 = utf8.len(var_399_10)
				local var_399_13 = var_399_11 <= 0 and var_399_7 or var_399_7 * (var_399_12 / var_399_11)

				if var_399_13 > 0 and var_399_7 < var_399_13 then
					arg_396_1.talkMaxDuration = var_399_13

					if var_399_13 + var_399_6 > arg_396_1.duration_ then
						arg_396_1.duration_ = var_399_13 + var_399_6
					end
				end

				arg_396_1.text_.text = var_399_10
				arg_396_1.typewritter.percent = 0

				arg_396_1.typewritter:SetDirty()
				arg_396_1:ShowNextGo(false)
				arg_396_1:RecordContent(arg_396_1.text_.text)
			end

			local var_399_14 = math.max(var_399_7, arg_396_1.talkMaxDuration)

			if var_399_6 <= arg_396_1.time_ and arg_396_1.time_ < var_399_6 + var_399_14 then
				arg_396_1.typewritter.percent = (arg_396_1.time_ - var_399_6) / var_399_14

				arg_396_1.typewritter:SetDirty()
			end

			if arg_396_1.time_ >= var_399_6 + var_399_14 and arg_396_1.time_ < var_399_6 + var_399_14 + arg_399_0 then
				arg_396_1.typewritter.percent = 1

				arg_396_1.typewritter:SetDirty()
				arg_396_1:ShowNextGo(true)
			end
		end

		arg_396_1.nodeConfigList_ = {}

		arg_396_1:InitPlayNodeList()
	end,
	Play426101094 = function(arg_400_0, arg_400_1)
		arg_400_1.time_ = 0
		arg_400_1.frameCnt_ = 0
		arg_400_1.state_ = "playing"
		arg_400_1.curTalkId_ = 426101094
		arg_400_1.duration_ = 3.7

		local var_400_0 = {
			zh = 2.5,
			ja = 3.7
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
				arg_400_0:Play426101095(arg_400_1)
			end
		end

		function arg_400_1.onSingleLineUpdate_(arg_403_0)
			local var_403_0 = arg_400_1.actors_["1054ui_story"].transform
			local var_403_1 = 0

			if var_403_1 < arg_400_1.time_ and arg_400_1.time_ <= var_403_1 + arg_403_0 then
				arg_400_1.var_.moveOldPos1054ui_story = var_403_0.localPosition

				local var_403_2 = GameObjectTools.GetOrAddComponent(var_403_0.gameObject, typeof(DynamicBoneHelper))

				if var_403_2 then
					var_403_2:EnableDynamicBone(false)
				end
			end

			local var_403_3 = 0.001

			if var_403_1 <= arg_400_1.time_ and arg_400_1.time_ < var_403_1 + var_403_3 then
				local var_403_4 = (arg_400_1.time_ - var_403_1) / var_403_3
				local var_403_5 = Vector3.New(0.7, -0.985, -6)

				var_403_0.localPosition = Vector3.Lerp(arg_400_1.var_.moveOldPos1054ui_story, var_403_5, var_403_4)

				local var_403_6 = manager.ui.mainCamera.transform.position - var_403_0.position

				var_403_0.forward = Vector3.New(var_403_6.x, var_403_6.y, var_403_6.z)

				local var_403_7 = var_403_0.localEulerAngles

				var_403_7.z = 0
				var_403_7.x = 0
				var_403_0.localEulerAngles = var_403_7
			end

			if arg_400_1.time_ >= var_403_1 + var_403_3 and arg_400_1.time_ < var_403_1 + var_403_3 + arg_403_0 then
				var_403_0.localPosition = Vector3.New(0.7, -0.985, -6)

				local var_403_8 = manager.ui.mainCamera.transform.position - var_403_0.position

				var_403_0.forward = Vector3.New(var_403_8.x, var_403_8.y, var_403_8.z)

				local var_403_9 = var_403_0.localEulerAngles

				var_403_9.z = 0
				var_403_9.x = 0
				var_403_0.localEulerAngles = var_403_9

				local var_403_10 = GameObjectTools.GetOrAddComponent(var_403_0.gameObject, typeof(DynamicBoneHelper))

				if var_403_10 then
					var_403_10:EnableDynamicBone(true)
				end
			end

			local var_403_11 = arg_400_1.actors_["1054ui_story"]
			local var_403_12 = 0

			if var_403_12 < arg_400_1.time_ and arg_400_1.time_ <= var_403_12 + arg_403_0 and not isNil(var_403_11) and arg_400_1.var_.characterEffect1054ui_story == nil then
				arg_400_1.var_.characterEffect1054ui_story = var_403_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_403_13 = 0.200000002980232

			if var_403_12 <= arg_400_1.time_ and arg_400_1.time_ < var_403_12 + var_403_13 and not isNil(var_403_11) then
				local var_403_14 = (arg_400_1.time_ - var_403_12) / var_403_13

				if arg_400_1.var_.characterEffect1054ui_story and not isNil(var_403_11) then
					arg_400_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_400_1.time_ >= var_403_12 + var_403_13 and arg_400_1.time_ < var_403_12 + var_403_13 + arg_403_0 and not isNil(var_403_11) and arg_400_1.var_.characterEffect1054ui_story then
				arg_400_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_403_15 = 0

			if var_403_15 < arg_400_1.time_ and arg_400_1.time_ <= var_403_15 + arg_403_0 then
				arg_400_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action1_1")
			end

			local var_403_16 = 0

			if var_403_16 < arg_400_1.time_ and arg_400_1.time_ <= var_403_16 + arg_403_0 then
				arg_400_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_403_17 = 0
			local var_403_18 = 0.225

			if var_403_17 < arg_400_1.time_ and arg_400_1.time_ <= var_403_17 + arg_403_0 then
				arg_400_1.talkMaxDuration = 0
				arg_400_1.dialogCg_.alpha = 1

				arg_400_1.dialog_:SetActive(true)
				SetActive(arg_400_1.leftNameGo_, true)

				local var_403_19 = arg_400_1:FormatText(StoryNameCfg[1487].name)

				arg_400_1.leftNameTxt_.text = var_403_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_400_1.leftNameTxt_.transform)

				arg_400_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_400_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_400_1:RecordName(arg_400_1.leftNameTxt_.text)
				SetActive(arg_400_1.iconTrs_.gameObject, false)
				arg_400_1.callingController_:SetSelectedState("normal")

				local var_403_20 = arg_400_1:GetWordFromCfg(426101094)
				local var_403_21 = arg_400_1:FormatText(var_403_20.content)

				arg_400_1.text_.text = var_403_21

				LuaForUtil.ClearLinePrefixSymbol(arg_400_1.text_)

				local var_403_22 = 9
				local var_403_23 = utf8.len(var_403_21)
				local var_403_24 = var_403_22 <= 0 and var_403_18 or var_403_18 * (var_403_23 / var_403_22)

				if var_403_24 > 0 and var_403_18 < var_403_24 then
					arg_400_1.talkMaxDuration = var_403_24

					if var_403_24 + var_403_17 > arg_400_1.duration_ then
						arg_400_1.duration_ = var_403_24 + var_403_17
					end
				end

				arg_400_1.text_.text = var_403_21
				arg_400_1.typewritter.percent = 0

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426101", "426101094", "story_v_out_426101.awb") ~= 0 then
					local var_403_25 = manager.audio:GetVoiceLength("story_v_out_426101", "426101094", "story_v_out_426101.awb") / 1000

					if var_403_25 + var_403_17 > arg_400_1.duration_ then
						arg_400_1.duration_ = var_403_25 + var_403_17
					end

					if var_403_20.prefab_name ~= "" and arg_400_1.actors_[var_403_20.prefab_name] ~= nil then
						local var_403_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_400_1.actors_[var_403_20.prefab_name].transform, "story_v_out_426101", "426101094", "story_v_out_426101.awb")

						arg_400_1:RecordAudio("426101094", var_403_26)
						arg_400_1:RecordAudio("426101094", var_403_26)
					else
						arg_400_1:AudioAction("play", "voice", "story_v_out_426101", "426101094", "story_v_out_426101.awb")
					end

					arg_400_1:RecordHistoryTalkVoice("story_v_out_426101", "426101094", "story_v_out_426101.awb")
				end

				arg_400_1:RecordContent(arg_400_1.text_.text)
			end

			local var_403_27 = math.max(var_403_18, arg_400_1.talkMaxDuration)

			if var_403_17 <= arg_400_1.time_ and arg_400_1.time_ < var_403_17 + var_403_27 then
				arg_400_1.typewritter.percent = (arg_400_1.time_ - var_403_17) / var_403_27

				arg_400_1.typewritter:SetDirty()
			end

			if arg_400_1.time_ >= var_403_17 + var_403_27 and arg_400_1.time_ < var_403_17 + var_403_27 + arg_403_0 then
				arg_400_1.typewritter.percent = 1

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(true)
			end
		end

		arg_400_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_400_1:InitPlayNodeList()
	end,
	Play426101095 = function(arg_404_0, arg_404_1)
		arg_404_1.time_ = 0
		arg_404_1.frameCnt_ = 0
		arg_404_1.state_ = "playing"
		arg_404_1.curTalkId_ = 426101095
		arg_404_1.duration_ = 2

		SetActive(arg_404_1.tipsGo_, false)

		function arg_404_1.onSingleLineFinish_()
			arg_404_1.onSingleLineUpdate_ = nil
			arg_404_1.onSingleLineFinish_ = nil
			arg_404_1.state_ = "waiting"
		end

		function arg_404_1.playNext_(arg_406_0)
			if arg_406_0 == 1 then
				arg_404_0:Play426101096(arg_404_1)
			end
		end

		function arg_404_1.onSingleLineUpdate_(arg_407_0)
			local var_407_0 = arg_404_1.actors_["6148ui_story"].transform
			local var_407_1 = 0

			if var_407_1 < arg_404_1.time_ and arg_404_1.time_ <= var_407_1 + arg_407_0 then
				arg_404_1.var_.moveOldPos6148ui_story = var_407_0.localPosition

				local var_407_2 = GameObjectTools.GetOrAddComponent(var_407_0.gameObject, typeof(DynamicBoneHelper))

				if var_407_2 then
					var_407_2:EnableDynamicBone(false)
				end
			end

			local var_407_3 = 0.001

			if var_407_1 <= arg_404_1.time_ and arg_404_1.time_ < var_407_1 + var_407_3 then
				local var_407_4 = (arg_404_1.time_ - var_407_1) / var_407_3
				local var_407_5 = Vector3.New(-0.7, -0.985, -6)

				var_407_0.localPosition = Vector3.Lerp(arg_404_1.var_.moveOldPos6148ui_story, var_407_5, var_407_4)

				local var_407_6 = manager.ui.mainCamera.transform.position - var_407_0.position

				var_407_0.forward = Vector3.New(var_407_6.x, var_407_6.y, var_407_6.z)

				local var_407_7 = var_407_0.localEulerAngles

				var_407_7.z = 0
				var_407_7.x = 0
				var_407_0.localEulerAngles = var_407_7
			end

			if arg_404_1.time_ >= var_407_1 + var_407_3 and arg_404_1.time_ < var_407_1 + var_407_3 + arg_407_0 then
				var_407_0.localPosition = Vector3.New(-0.7, -0.985, -6)

				local var_407_8 = manager.ui.mainCamera.transform.position - var_407_0.position

				var_407_0.forward = Vector3.New(var_407_8.x, var_407_8.y, var_407_8.z)

				local var_407_9 = var_407_0.localEulerAngles

				var_407_9.z = 0
				var_407_9.x = 0
				var_407_0.localEulerAngles = var_407_9

				local var_407_10 = GameObjectTools.GetOrAddComponent(var_407_0.gameObject, typeof(DynamicBoneHelper))

				if var_407_10 then
					var_407_10:EnableDynamicBone(true)
				end
			end

			local var_407_11 = arg_404_1.actors_["6148ui_story"]
			local var_407_12 = 0

			if var_407_12 < arg_404_1.time_ and arg_404_1.time_ <= var_407_12 + arg_407_0 and not isNil(var_407_11) and arg_404_1.var_.characterEffect6148ui_story == nil then
				arg_404_1.var_.characterEffect6148ui_story = var_407_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_407_13 = 0.200000002980232

			if var_407_12 <= arg_404_1.time_ and arg_404_1.time_ < var_407_12 + var_407_13 and not isNil(var_407_11) then
				local var_407_14 = (arg_404_1.time_ - var_407_12) / var_407_13

				if arg_404_1.var_.characterEffect6148ui_story and not isNil(var_407_11) then
					arg_404_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_404_1.time_ >= var_407_12 + var_407_13 and arg_404_1.time_ < var_407_12 + var_407_13 + arg_407_0 and not isNil(var_407_11) and arg_404_1.var_.characterEffect6148ui_story then
				arg_404_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_407_15 = arg_404_1.actors_["1054ui_story"]
			local var_407_16 = 0

			if var_407_16 < arg_404_1.time_ and arg_404_1.time_ <= var_407_16 + arg_407_0 and not isNil(var_407_15) and arg_404_1.var_.characterEffect1054ui_story == nil then
				arg_404_1.var_.characterEffect1054ui_story = var_407_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_407_17 = 0.200000002980232

			if var_407_16 <= arg_404_1.time_ and arg_404_1.time_ < var_407_16 + var_407_17 and not isNil(var_407_15) then
				local var_407_18 = (arg_404_1.time_ - var_407_16) / var_407_17

				if arg_404_1.var_.characterEffect1054ui_story and not isNil(var_407_15) then
					local var_407_19 = Mathf.Lerp(0, 0.5, var_407_18)

					arg_404_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_404_1.var_.characterEffect1054ui_story.fillRatio = var_407_19
				end
			end

			if arg_404_1.time_ >= var_407_16 + var_407_17 and arg_404_1.time_ < var_407_16 + var_407_17 + arg_407_0 and not isNil(var_407_15) and arg_404_1.var_.characterEffect1054ui_story then
				local var_407_20 = 0.5

				arg_404_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_404_1.var_.characterEffect1054ui_story.fillRatio = var_407_20
			end

			local var_407_21 = 0

			if var_407_21 < arg_404_1.time_ and arg_404_1.time_ <= var_407_21 + arg_407_0 then
				arg_404_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action2_1")
			end

			local var_407_22 = 0

			if var_407_22 < arg_404_1.time_ and arg_404_1.time_ <= var_407_22 + arg_407_0 then
				arg_404_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_407_23 = 0
			local var_407_24 = 0.1

			if var_407_23 < arg_404_1.time_ and arg_404_1.time_ <= var_407_23 + arg_407_0 then
				arg_404_1.talkMaxDuration = 0
				arg_404_1.dialogCg_.alpha = 1

				arg_404_1.dialog_:SetActive(true)
				SetActive(arg_404_1.leftNameGo_, true)

				local var_407_25 = arg_404_1:FormatText(StoryNameCfg[1488].name)

				arg_404_1.leftNameTxt_.text = var_407_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_404_1.leftNameTxt_.transform)

				arg_404_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_404_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_404_1:RecordName(arg_404_1.leftNameTxt_.text)
				SetActive(arg_404_1.iconTrs_.gameObject, false)
				arg_404_1.callingController_:SetSelectedState("normal")

				local var_407_26 = arg_404_1:GetWordFromCfg(426101095)
				local var_407_27 = arg_404_1:FormatText(var_407_26.content)

				arg_404_1.text_.text = var_407_27

				LuaForUtil.ClearLinePrefixSymbol(arg_404_1.text_)

				local var_407_28 = 4
				local var_407_29 = utf8.len(var_407_27)
				local var_407_30 = var_407_28 <= 0 and var_407_24 or var_407_24 * (var_407_29 / var_407_28)

				if var_407_30 > 0 and var_407_24 < var_407_30 then
					arg_404_1.talkMaxDuration = var_407_30

					if var_407_30 + var_407_23 > arg_404_1.duration_ then
						arg_404_1.duration_ = var_407_30 + var_407_23
					end
				end

				arg_404_1.text_.text = var_407_27
				arg_404_1.typewritter.percent = 0

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426101", "426101095", "story_v_out_426101.awb") ~= 0 then
					local var_407_31 = manager.audio:GetVoiceLength("story_v_out_426101", "426101095", "story_v_out_426101.awb") / 1000

					if var_407_31 + var_407_23 > arg_404_1.duration_ then
						arg_404_1.duration_ = var_407_31 + var_407_23
					end

					if var_407_26.prefab_name ~= "" and arg_404_1.actors_[var_407_26.prefab_name] ~= nil then
						local var_407_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_404_1.actors_[var_407_26.prefab_name].transform, "story_v_out_426101", "426101095", "story_v_out_426101.awb")

						arg_404_1:RecordAudio("426101095", var_407_32)
						arg_404_1:RecordAudio("426101095", var_407_32)
					else
						arg_404_1:AudioAction("play", "voice", "story_v_out_426101", "426101095", "story_v_out_426101.awb")
					end

					arg_404_1:RecordHistoryTalkVoice("story_v_out_426101", "426101095", "story_v_out_426101.awb")
				end

				arg_404_1:RecordContent(arg_404_1.text_.text)
			end

			local var_407_33 = math.max(var_407_24, arg_404_1.talkMaxDuration)

			if var_407_23 <= arg_404_1.time_ and arg_404_1.time_ < var_407_23 + var_407_33 then
				arg_404_1.typewritter.percent = (arg_404_1.time_ - var_407_23) / var_407_33

				arg_404_1.typewritter:SetDirty()
			end

			if arg_404_1.time_ >= var_407_23 + var_407_33 and arg_404_1.time_ < var_407_23 + var_407_33 + arg_407_0 then
				arg_404_1.typewritter.percent = 1

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(true)
			end
		end

		arg_404_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_404_1:InitPlayNodeList()
	end,
	Play426101096 = function(arg_408_0, arg_408_1)
		arg_408_1.time_ = 0
		arg_408_1.frameCnt_ = 0
		arg_408_1.state_ = "playing"
		arg_408_1.curTalkId_ = 426101096
		arg_408_1.duration_ = 9

		SetActive(arg_408_1.tipsGo_, false)

		function arg_408_1.onSingleLineFinish_()
			arg_408_1.onSingleLineUpdate_ = nil
			arg_408_1.onSingleLineFinish_ = nil
			arg_408_1.state_ = "waiting"
		end

		function arg_408_1.playNext_(arg_410_0)
			if arg_410_0 == 1 then
				arg_408_0:Play426101097(arg_408_1)
			end
		end

		function arg_408_1.onSingleLineUpdate_(arg_411_0)
			local var_411_0 = "ST2012"

			if arg_408_1.bgs_[var_411_0] == nil then
				local var_411_1 = Object.Instantiate(arg_408_1.paintGo_)

				var_411_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_411_0)
				var_411_1.name = var_411_0
				var_411_1.transform.parent = arg_408_1.stage_.transform
				var_411_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_408_1.bgs_[var_411_0] = var_411_1
			end

			local var_411_2 = 1.999999999999

			if var_411_2 < arg_408_1.time_ and arg_408_1.time_ <= var_411_2 + arg_411_0 then
				local var_411_3 = manager.ui.mainCamera.transform.localPosition
				local var_411_4 = Vector3.New(0, 0, 10) + Vector3.New(var_411_3.x, var_411_3.y, 0)
				local var_411_5 = arg_408_1.bgs_.ST2012

				var_411_5.transform.localPosition = var_411_4
				var_411_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_411_6 = var_411_5:GetComponent("SpriteRenderer")

				if var_411_6 and var_411_6.sprite then
					local var_411_7 = (var_411_5.transform.localPosition - var_411_3).z
					local var_411_8 = manager.ui.mainCameraCom_
					local var_411_9 = 2 * var_411_7 * Mathf.Tan(var_411_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_411_10 = var_411_9 * var_411_8.aspect
					local var_411_11 = var_411_6.sprite.bounds.size.x
					local var_411_12 = var_411_6.sprite.bounds.size.y
					local var_411_13 = var_411_10 / var_411_11
					local var_411_14 = var_411_9 / var_411_12
					local var_411_15 = var_411_14 < var_411_13 and var_411_13 or var_411_14

					var_411_5.transform.localScale = Vector3.New(var_411_15, var_411_15, 0)
				end

				for iter_411_0, iter_411_1 in pairs(arg_408_1.bgs_) do
					if iter_411_0 ~= "ST2012" then
						iter_411_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_411_16 = 3.999999999999

			if var_411_16 < arg_408_1.time_ and arg_408_1.time_ <= var_411_16 + arg_411_0 then
				arg_408_1.allBtn_.enabled = false
			end

			local var_411_17 = 0.3

			if arg_408_1.time_ >= var_411_16 + var_411_17 and arg_408_1.time_ < var_411_16 + var_411_17 + arg_411_0 then
				arg_408_1.allBtn_.enabled = true
			end

			local var_411_18 = 0

			if var_411_18 < arg_408_1.time_ and arg_408_1.time_ <= var_411_18 + arg_411_0 then
				arg_408_1.mask_.enabled = true
				arg_408_1.mask_.raycastTarget = true

				arg_408_1:SetGaussion(false)
			end

			local var_411_19 = 2

			if var_411_18 <= arg_408_1.time_ and arg_408_1.time_ < var_411_18 + var_411_19 then
				local var_411_20 = (arg_408_1.time_ - var_411_18) / var_411_19
				local var_411_21 = Color.New(0, 0, 0)

				var_411_21.a = Mathf.Lerp(0, 1, var_411_20)
				arg_408_1.mask_.color = var_411_21
			end

			if arg_408_1.time_ >= var_411_18 + var_411_19 and arg_408_1.time_ < var_411_18 + var_411_19 + arg_411_0 then
				local var_411_22 = Color.New(0, 0, 0)

				var_411_22.a = 1
				arg_408_1.mask_.color = var_411_22
			end

			local var_411_23 = 2

			if var_411_23 < arg_408_1.time_ and arg_408_1.time_ <= var_411_23 + arg_411_0 then
				arg_408_1.mask_.enabled = true
				arg_408_1.mask_.raycastTarget = true

				arg_408_1:SetGaussion(false)
			end

			local var_411_24 = 2

			if var_411_23 <= arg_408_1.time_ and arg_408_1.time_ < var_411_23 + var_411_24 then
				local var_411_25 = (arg_408_1.time_ - var_411_23) / var_411_24
				local var_411_26 = Color.New(0, 0, 0)

				var_411_26.a = Mathf.Lerp(1, 0, var_411_25)
				arg_408_1.mask_.color = var_411_26
			end

			if arg_408_1.time_ >= var_411_23 + var_411_24 and arg_408_1.time_ < var_411_23 + var_411_24 + arg_411_0 then
				local var_411_27 = Color.New(0, 0, 0)
				local var_411_28 = 0

				arg_408_1.mask_.enabled = false
				var_411_27.a = var_411_28
				arg_408_1.mask_.color = var_411_27
			end

			local var_411_29 = arg_408_1.actors_["6148ui_story"].transform
			local var_411_30 = 2

			if var_411_30 < arg_408_1.time_ and arg_408_1.time_ <= var_411_30 + arg_411_0 then
				arg_408_1.var_.moveOldPos6148ui_story = var_411_29.localPosition

				local var_411_31 = GameObjectTools.GetOrAddComponent(var_411_29.gameObject, typeof(DynamicBoneHelper))

				if var_411_31 then
					var_411_31:EnableDynamicBone(false)
				end
			end

			local var_411_32 = 0.001

			if var_411_30 <= arg_408_1.time_ and arg_408_1.time_ < var_411_30 + var_411_32 then
				local var_411_33 = (arg_408_1.time_ - var_411_30) / var_411_32
				local var_411_34 = Vector3.New(0, 100, 0)

				var_411_29.localPosition = Vector3.Lerp(arg_408_1.var_.moveOldPos6148ui_story, var_411_34, var_411_33)

				local var_411_35 = manager.ui.mainCamera.transform.position - var_411_29.position

				var_411_29.forward = Vector3.New(var_411_35.x, var_411_35.y, var_411_35.z)

				local var_411_36 = var_411_29.localEulerAngles

				var_411_36.z = 0
				var_411_36.x = 0
				var_411_29.localEulerAngles = var_411_36
			end

			if arg_408_1.time_ >= var_411_30 + var_411_32 and arg_408_1.time_ < var_411_30 + var_411_32 + arg_411_0 then
				var_411_29.localPosition = Vector3.New(0, 100, 0)

				local var_411_37 = manager.ui.mainCamera.transform.position - var_411_29.position

				var_411_29.forward = Vector3.New(var_411_37.x, var_411_37.y, var_411_37.z)

				local var_411_38 = var_411_29.localEulerAngles

				var_411_38.z = 0
				var_411_38.x = 0
				var_411_29.localEulerAngles = var_411_38

				local var_411_39 = GameObjectTools.GetOrAddComponent(var_411_29.gameObject, typeof(DynamicBoneHelper))

				if var_411_39 then
					var_411_39:EnableDynamicBone(true)
				end
			end

			local var_411_40 = arg_408_1.actors_["1054ui_story"].transform
			local var_411_41 = 2

			if var_411_41 < arg_408_1.time_ and arg_408_1.time_ <= var_411_41 + arg_411_0 then
				arg_408_1.var_.moveOldPos1054ui_story = var_411_40.localPosition

				local var_411_42 = GameObjectTools.GetOrAddComponent(var_411_40.gameObject, typeof(DynamicBoneHelper))

				if var_411_42 then
					var_411_42:EnableDynamicBone(false)
				end
			end

			local var_411_43 = 0.001

			if var_411_41 <= arg_408_1.time_ and arg_408_1.time_ < var_411_41 + var_411_43 then
				local var_411_44 = (arg_408_1.time_ - var_411_41) / var_411_43
				local var_411_45 = Vector3.New(0, 100, 0)

				var_411_40.localPosition = Vector3.Lerp(arg_408_1.var_.moveOldPos1054ui_story, var_411_45, var_411_44)

				local var_411_46 = manager.ui.mainCamera.transform.position - var_411_40.position

				var_411_40.forward = Vector3.New(var_411_46.x, var_411_46.y, var_411_46.z)

				local var_411_47 = var_411_40.localEulerAngles

				var_411_47.z = 0
				var_411_47.x = 0
				var_411_40.localEulerAngles = var_411_47
			end

			if arg_408_1.time_ >= var_411_41 + var_411_43 and arg_408_1.time_ < var_411_41 + var_411_43 + arg_411_0 then
				var_411_40.localPosition = Vector3.New(0, 100, 0)

				local var_411_48 = manager.ui.mainCamera.transform.position - var_411_40.position

				var_411_40.forward = Vector3.New(var_411_48.x, var_411_48.y, var_411_48.z)

				local var_411_49 = var_411_40.localEulerAngles

				var_411_49.z = 0
				var_411_49.x = 0
				var_411_40.localEulerAngles = var_411_49

				local var_411_50 = GameObjectTools.GetOrAddComponent(var_411_40.gameObject, typeof(DynamicBoneHelper))

				if var_411_50 then
					var_411_50:EnableDynamicBone(true)
				end
			end

			local var_411_51 = arg_408_1.actors_["6148ui_story"]
			local var_411_52 = 2

			if var_411_52 < arg_408_1.time_ and arg_408_1.time_ <= var_411_52 + arg_411_0 and not isNil(var_411_51) and arg_408_1.var_.characterEffect6148ui_story == nil then
				arg_408_1.var_.characterEffect6148ui_story = var_411_51:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_411_53 = 0.2

			if var_411_52 <= arg_408_1.time_ and arg_408_1.time_ < var_411_52 + var_411_53 and not isNil(var_411_51) then
				local var_411_54 = (arg_408_1.time_ - var_411_52) / var_411_53

				if arg_408_1.var_.characterEffect6148ui_story and not isNil(var_411_51) then
					local var_411_55 = Mathf.Lerp(0, 0.5, var_411_54)

					arg_408_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_408_1.var_.characterEffect6148ui_story.fillRatio = var_411_55
				end
			end

			if arg_408_1.time_ >= var_411_52 + var_411_53 and arg_408_1.time_ < var_411_52 + var_411_53 + arg_411_0 and not isNil(var_411_51) and arg_408_1.var_.characterEffect6148ui_story then
				local var_411_56 = 0.5

				arg_408_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_408_1.var_.characterEffect6148ui_story.fillRatio = var_411_56
			end

			if arg_408_1.frameCnt_ <= 1 then
				arg_408_1.dialog_:SetActive(false)
			end

			local var_411_57 = 4
			local var_411_58 = 0.9

			if var_411_57 < arg_408_1.time_ and arg_408_1.time_ <= var_411_57 + arg_411_0 then
				arg_408_1.talkMaxDuration = 0

				arg_408_1.dialog_:SetActive(true)

				arg_408_1.dialogCg_.alpha = 0

				local var_411_59 = LeanTween.value(arg_408_1.dialog_, 0, 1, 0.3)

				var_411_59:setOnUpdate(LuaHelper.FloatAction(function(arg_412_0)
					arg_408_1.dialogCg_.alpha = arg_412_0
				end))
				var_411_59:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_408_1.dialog_)
					var_411_59:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_408_1.duration_ = arg_408_1.duration_ + 0.3

				SetActive(arg_408_1.leftNameGo_, false)

				arg_408_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_408_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_408_1:RecordName(arg_408_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_408_1.iconTrs_.gameObject, false)
				arg_408_1.callingController_:SetSelectedState("normal")

				local var_411_60 = arg_408_1:GetWordFromCfg(426101096)
				local var_411_61 = arg_408_1:FormatText(var_411_60.content)

				arg_408_1.text_.text = var_411_61

				LuaForUtil.ClearLinePrefixSymbol(arg_408_1.text_)

				local var_411_62 = 36
				local var_411_63 = utf8.len(var_411_61)
				local var_411_64 = var_411_62 <= 0 and var_411_58 or var_411_58 * (var_411_63 / var_411_62)

				if var_411_64 > 0 and var_411_58 < var_411_64 then
					arg_408_1.talkMaxDuration = var_411_64
					var_411_57 = var_411_57 + 0.3

					if var_411_64 + var_411_57 > arg_408_1.duration_ then
						arg_408_1.duration_ = var_411_64 + var_411_57
					end
				end

				arg_408_1.text_.text = var_411_61
				arg_408_1.typewritter.percent = 0

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(false)
				arg_408_1:RecordContent(arg_408_1.text_.text)
			end

			local var_411_65 = var_411_57 + 0.3
			local var_411_66 = math.max(var_411_58, arg_408_1.talkMaxDuration)

			if var_411_65 <= arg_408_1.time_ and arg_408_1.time_ < var_411_65 + var_411_66 then
				arg_408_1.typewritter.percent = (arg_408_1.time_ - var_411_65) / var_411_66

				arg_408_1.typewritter:SetDirty()
			end

			if arg_408_1.time_ >= var_411_65 + var_411_66 and arg_408_1.time_ < var_411_65 + var_411_66 + arg_411_0 then
				arg_408_1.typewritter.percent = 1

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(true)
			end
		end

		arg_408_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_408_1:InitPlayNodeList()
	end,
	Play426101097 = function(arg_414_0, arg_414_1)
		arg_414_1.time_ = 0
		arg_414_1.frameCnt_ = 0
		arg_414_1.state_ = "playing"
		arg_414_1.curTalkId_ = 426101097
		arg_414_1.duration_ = 5

		SetActive(arg_414_1.tipsGo_, false)

		function arg_414_1.onSingleLineFinish_()
			arg_414_1.onSingleLineUpdate_ = nil
			arg_414_1.onSingleLineFinish_ = nil
			arg_414_1.state_ = "waiting"
		end

		function arg_414_1.playNext_(arg_416_0)
			if arg_416_0 == 1 then
				arg_414_0:Play426101098(arg_414_1)
			end
		end

		function arg_414_1.onSingleLineUpdate_(arg_417_0)
			local var_417_0 = 0
			local var_417_1 = 0.575

			if var_417_0 < arg_414_1.time_ and arg_414_1.time_ <= var_417_0 + arg_417_0 then
				arg_414_1.talkMaxDuration = 0
				arg_414_1.dialogCg_.alpha = 1

				arg_414_1.dialog_:SetActive(true)
				SetActive(arg_414_1.leftNameGo_, true)

				local var_417_2 = arg_414_1:FormatText(StoryNameCfg[7].name)

				arg_414_1.leftNameTxt_.text = var_417_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_414_1.leftNameTxt_.transform)

				arg_414_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_414_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_414_1:RecordName(arg_414_1.leftNameTxt_.text)
				SetActive(arg_414_1.iconTrs_.gameObject, true)
				arg_414_1.iconController_:SetSelectedState("hero")

				arg_414_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_414_1.callingController_:SetSelectedState("normal")

				arg_414_1.keyicon_.color = Color.New(1, 1, 1)
				arg_414_1.icon_.color = Color.New(1, 1, 1)

				local var_417_3 = arg_414_1:GetWordFromCfg(426101097)
				local var_417_4 = arg_414_1:FormatText(var_417_3.content)

				arg_414_1.text_.text = var_417_4

				LuaForUtil.ClearLinePrefixSymbol(arg_414_1.text_)

				local var_417_5 = 23
				local var_417_6 = utf8.len(var_417_4)
				local var_417_7 = var_417_5 <= 0 and var_417_1 or var_417_1 * (var_417_6 / var_417_5)

				if var_417_7 > 0 and var_417_1 < var_417_7 then
					arg_414_1.talkMaxDuration = var_417_7

					if var_417_7 + var_417_0 > arg_414_1.duration_ then
						arg_414_1.duration_ = var_417_7 + var_417_0
					end
				end

				arg_414_1.text_.text = var_417_4
				arg_414_1.typewritter.percent = 0

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(false)
				arg_414_1:RecordContent(arg_414_1.text_.text)
			end

			local var_417_8 = math.max(var_417_1, arg_414_1.talkMaxDuration)

			if var_417_0 <= arg_414_1.time_ and arg_414_1.time_ < var_417_0 + var_417_8 then
				arg_414_1.typewritter.percent = (arg_414_1.time_ - var_417_0) / var_417_8

				arg_414_1.typewritter:SetDirty()
			end

			if arg_414_1.time_ >= var_417_0 + var_417_8 and arg_414_1.time_ < var_417_0 + var_417_8 + arg_417_0 then
				arg_414_1.typewritter.percent = 1

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(true)
			end
		end

		arg_414_1.nodeConfigList_ = {}

		arg_414_1:InitPlayNodeList()
	end,
	Play426101098 = function(arg_418_0, arg_418_1)
		arg_418_1.time_ = 0
		arg_418_1.frameCnt_ = 0
		arg_418_1.state_ = "playing"
		arg_418_1.curTalkId_ = 426101098
		arg_418_1.duration_ = 5

		SetActive(arg_418_1.tipsGo_, false)

		function arg_418_1.onSingleLineFinish_()
			arg_418_1.onSingleLineUpdate_ = nil
			arg_418_1.onSingleLineFinish_ = nil
			arg_418_1.state_ = "waiting"
		end

		function arg_418_1.playNext_(arg_420_0)
			if arg_420_0 == 1 then
				arg_418_0:Play426101099(arg_418_1)
			end
		end

		function arg_418_1.onSingleLineUpdate_(arg_421_0)
			local var_421_0 = 0
			local var_421_1 = 0.675

			if var_421_0 < arg_418_1.time_ and arg_418_1.time_ <= var_421_0 + arg_421_0 then
				arg_418_1.talkMaxDuration = 0
				arg_418_1.dialogCg_.alpha = 1

				arg_418_1.dialog_:SetActive(true)
				SetActive(arg_418_1.leftNameGo_, false)

				arg_418_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_418_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_418_1:RecordName(arg_418_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_418_1.iconTrs_.gameObject, false)
				arg_418_1.callingController_:SetSelectedState("normal")

				local var_421_2 = arg_418_1:GetWordFromCfg(426101098)
				local var_421_3 = arg_418_1:FormatText(var_421_2.content)

				arg_418_1.text_.text = var_421_3

				LuaForUtil.ClearLinePrefixSymbol(arg_418_1.text_)

				local var_421_4 = 27
				local var_421_5 = utf8.len(var_421_3)
				local var_421_6 = var_421_4 <= 0 and var_421_1 or var_421_1 * (var_421_5 / var_421_4)

				if var_421_6 > 0 and var_421_1 < var_421_6 then
					arg_418_1.talkMaxDuration = var_421_6

					if var_421_6 + var_421_0 > arg_418_1.duration_ then
						arg_418_1.duration_ = var_421_6 + var_421_0
					end
				end

				arg_418_1.text_.text = var_421_3
				arg_418_1.typewritter.percent = 0

				arg_418_1.typewritter:SetDirty()
				arg_418_1:ShowNextGo(false)
				arg_418_1:RecordContent(arg_418_1.text_.text)
			end

			local var_421_7 = math.max(var_421_1, arg_418_1.talkMaxDuration)

			if var_421_0 <= arg_418_1.time_ and arg_418_1.time_ < var_421_0 + var_421_7 then
				arg_418_1.typewritter.percent = (arg_418_1.time_ - var_421_0) / var_421_7

				arg_418_1.typewritter:SetDirty()
			end

			if arg_418_1.time_ >= var_421_0 + var_421_7 and arg_418_1.time_ < var_421_0 + var_421_7 + arg_421_0 then
				arg_418_1.typewritter.percent = 1

				arg_418_1.typewritter:SetDirty()
				arg_418_1:ShowNextGo(true)
			end
		end

		arg_418_1.nodeConfigList_ = {}

		arg_418_1:InitPlayNodeList()
	end,
	Play426101099 = function(arg_422_0, arg_422_1)
		arg_422_1.time_ = 0
		arg_422_1.frameCnt_ = 0
		arg_422_1.state_ = "playing"
		arg_422_1.curTalkId_ = 426101099
		arg_422_1.duration_ = 5

		SetActive(arg_422_1.tipsGo_, false)

		function arg_422_1.onSingleLineFinish_()
			arg_422_1.onSingleLineUpdate_ = nil
			arg_422_1.onSingleLineFinish_ = nil
			arg_422_1.state_ = "waiting"
		end

		function arg_422_1.playNext_(arg_424_0)
			if arg_424_0 == 1 then
				arg_422_0:Play426101100(arg_422_1)
			end
		end

		function arg_422_1.onSingleLineUpdate_(arg_425_0)
			local var_425_0 = 0
			local var_425_1 = 1.275

			if var_425_0 < arg_422_1.time_ and arg_422_1.time_ <= var_425_0 + arg_425_0 then
				arg_422_1.talkMaxDuration = 0
				arg_422_1.dialogCg_.alpha = 1

				arg_422_1.dialog_:SetActive(true)
				SetActive(arg_422_1.leftNameGo_, false)

				arg_422_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_422_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_422_1:RecordName(arg_422_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_422_1.iconTrs_.gameObject, false)
				arg_422_1.callingController_:SetSelectedState("normal")

				local var_425_2 = arg_422_1:GetWordFromCfg(426101099)
				local var_425_3 = arg_422_1:FormatText(var_425_2.content)

				arg_422_1.text_.text = var_425_3

				LuaForUtil.ClearLinePrefixSymbol(arg_422_1.text_)

				local var_425_4 = 51
				local var_425_5 = utf8.len(var_425_3)
				local var_425_6 = var_425_4 <= 0 and var_425_1 or var_425_1 * (var_425_5 / var_425_4)

				if var_425_6 > 0 and var_425_1 < var_425_6 then
					arg_422_1.talkMaxDuration = var_425_6

					if var_425_6 + var_425_0 > arg_422_1.duration_ then
						arg_422_1.duration_ = var_425_6 + var_425_0
					end
				end

				arg_422_1.text_.text = var_425_3
				arg_422_1.typewritter.percent = 0

				arg_422_1.typewritter:SetDirty()
				arg_422_1:ShowNextGo(false)
				arg_422_1:RecordContent(arg_422_1.text_.text)
			end

			local var_425_7 = math.max(var_425_1, arg_422_1.talkMaxDuration)

			if var_425_0 <= arg_422_1.time_ and arg_422_1.time_ < var_425_0 + var_425_7 then
				arg_422_1.typewritter.percent = (arg_422_1.time_ - var_425_0) / var_425_7

				arg_422_1.typewritter:SetDirty()
			end

			if arg_422_1.time_ >= var_425_0 + var_425_7 and arg_422_1.time_ < var_425_0 + var_425_7 + arg_425_0 then
				arg_422_1.typewritter.percent = 1

				arg_422_1.typewritter:SetDirty()
				arg_422_1:ShowNextGo(true)
			end
		end

		arg_422_1.nodeConfigList_ = {}

		arg_422_1:InitPlayNodeList()
	end,
	Play426101100 = function(arg_426_0, arg_426_1)
		arg_426_1.time_ = 0
		arg_426_1.frameCnt_ = 0
		arg_426_1.state_ = "playing"
		arg_426_1.curTalkId_ = 426101100
		arg_426_1.duration_ = 5

		SetActive(arg_426_1.tipsGo_, false)

		function arg_426_1.onSingleLineFinish_()
			arg_426_1.onSingleLineUpdate_ = nil
			arg_426_1.onSingleLineFinish_ = nil
			arg_426_1.state_ = "waiting"
		end

		function arg_426_1.playNext_(arg_428_0)
			if arg_428_0 == 1 then
				arg_426_0:Play426101101(arg_426_1)
			end
		end

		function arg_426_1.onSingleLineUpdate_(arg_429_0)
			local var_429_0 = 0
			local var_429_1 = 0.25

			if var_429_0 < arg_426_1.time_ and arg_426_1.time_ <= var_429_0 + arg_429_0 then
				arg_426_1.talkMaxDuration = 0
				arg_426_1.dialogCg_.alpha = 1

				arg_426_1.dialog_:SetActive(true)
				SetActive(arg_426_1.leftNameGo_, true)

				local var_429_2 = arg_426_1:FormatText(StoryNameCfg[7].name)

				arg_426_1.leftNameTxt_.text = var_429_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_426_1.leftNameTxt_.transform)

				arg_426_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_426_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_426_1:RecordName(arg_426_1.leftNameTxt_.text)
				SetActive(arg_426_1.iconTrs_.gameObject, true)
				arg_426_1.iconController_:SetSelectedState("hero")

				arg_426_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_426_1.callingController_:SetSelectedState("normal")

				arg_426_1.keyicon_.color = Color.New(1, 1, 1)
				arg_426_1.icon_.color = Color.New(1, 1, 1)

				local var_429_3 = arg_426_1:GetWordFromCfg(426101100)
				local var_429_4 = arg_426_1:FormatText(var_429_3.content)

				arg_426_1.text_.text = var_429_4

				LuaForUtil.ClearLinePrefixSymbol(arg_426_1.text_)

				local var_429_5 = 10
				local var_429_6 = utf8.len(var_429_4)
				local var_429_7 = var_429_5 <= 0 and var_429_1 or var_429_1 * (var_429_6 / var_429_5)

				if var_429_7 > 0 and var_429_1 < var_429_7 then
					arg_426_1.talkMaxDuration = var_429_7

					if var_429_7 + var_429_0 > arg_426_1.duration_ then
						arg_426_1.duration_ = var_429_7 + var_429_0
					end
				end

				arg_426_1.text_.text = var_429_4
				arg_426_1.typewritter.percent = 0

				arg_426_1.typewritter:SetDirty()
				arg_426_1:ShowNextGo(false)
				arg_426_1:RecordContent(arg_426_1.text_.text)
			end

			local var_429_8 = math.max(var_429_1, arg_426_1.talkMaxDuration)

			if var_429_0 <= arg_426_1.time_ and arg_426_1.time_ < var_429_0 + var_429_8 then
				arg_426_1.typewritter.percent = (arg_426_1.time_ - var_429_0) / var_429_8

				arg_426_1.typewritter:SetDirty()
			end

			if arg_426_1.time_ >= var_429_0 + var_429_8 and arg_426_1.time_ < var_429_0 + var_429_8 + arg_429_0 then
				arg_426_1.typewritter.percent = 1

				arg_426_1.typewritter:SetDirty()
				arg_426_1:ShowNextGo(true)
			end
		end

		arg_426_1.nodeConfigList_ = {}

		arg_426_1:InitPlayNodeList()
	end,
	Play426101101 = function(arg_430_0, arg_430_1)
		arg_430_1.time_ = 0
		arg_430_1.frameCnt_ = 0
		arg_430_1.state_ = "playing"
		arg_430_1.curTalkId_ = 426101101
		arg_430_1.duration_ = 5

		SetActive(arg_430_1.tipsGo_, false)

		function arg_430_1.onSingleLineFinish_()
			arg_430_1.onSingleLineUpdate_ = nil
			arg_430_1.onSingleLineFinish_ = nil
			arg_430_1.state_ = "waiting"
		end

		function arg_430_1.playNext_(arg_432_0)
			if arg_432_0 == 1 then
				arg_430_0:Play426101102(arg_430_1)
			end
		end

		function arg_430_1.onSingleLineUpdate_(arg_433_0)
			local var_433_0 = 0
			local var_433_1 = 1.15

			if var_433_0 < arg_430_1.time_ and arg_430_1.time_ <= var_433_0 + arg_433_0 then
				arg_430_1.talkMaxDuration = 0
				arg_430_1.dialogCg_.alpha = 1

				arg_430_1.dialog_:SetActive(true)
				SetActive(arg_430_1.leftNameGo_, false)

				arg_430_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_430_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_430_1:RecordName(arg_430_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_430_1.iconTrs_.gameObject, false)
				arg_430_1.callingController_:SetSelectedState("normal")

				local var_433_2 = arg_430_1:GetWordFromCfg(426101101)
				local var_433_3 = arg_430_1:FormatText(var_433_2.content)

				arg_430_1.text_.text = var_433_3

				LuaForUtil.ClearLinePrefixSymbol(arg_430_1.text_)

				local var_433_4 = 46
				local var_433_5 = utf8.len(var_433_3)
				local var_433_6 = var_433_4 <= 0 and var_433_1 or var_433_1 * (var_433_5 / var_433_4)

				if var_433_6 > 0 and var_433_1 < var_433_6 then
					arg_430_1.talkMaxDuration = var_433_6

					if var_433_6 + var_433_0 > arg_430_1.duration_ then
						arg_430_1.duration_ = var_433_6 + var_433_0
					end
				end

				arg_430_1.text_.text = var_433_3
				arg_430_1.typewritter.percent = 0

				arg_430_1.typewritter:SetDirty()
				arg_430_1:ShowNextGo(false)
				arg_430_1:RecordContent(arg_430_1.text_.text)
			end

			local var_433_7 = math.max(var_433_1, arg_430_1.talkMaxDuration)

			if var_433_0 <= arg_430_1.time_ and arg_430_1.time_ < var_433_0 + var_433_7 then
				arg_430_1.typewritter.percent = (arg_430_1.time_ - var_433_0) / var_433_7

				arg_430_1.typewritter:SetDirty()
			end

			if arg_430_1.time_ >= var_433_0 + var_433_7 and arg_430_1.time_ < var_433_0 + var_433_7 + arg_433_0 then
				arg_430_1.typewritter.percent = 1

				arg_430_1.typewritter:SetDirty()
				arg_430_1:ShowNextGo(true)
			end
		end

		arg_430_1.nodeConfigList_ = {}

		arg_430_1:InitPlayNodeList()
	end,
	Play426101102 = function(arg_434_0, arg_434_1)
		arg_434_1.time_ = 0
		arg_434_1.frameCnt_ = 0
		arg_434_1.state_ = "playing"
		arg_434_1.curTalkId_ = 426101102
		arg_434_1.duration_ = 9

		SetActive(arg_434_1.tipsGo_, false)

		function arg_434_1.onSingleLineFinish_()
			arg_434_1.onSingleLineUpdate_ = nil
			arg_434_1.onSingleLineFinish_ = nil
			arg_434_1.state_ = "waiting"
		end

		function arg_434_1.playNext_(arg_436_0)
			if arg_436_0 == 1 then
				arg_434_0:Play426101103(arg_434_1)
			end
		end

		function arg_434_1.onSingleLineUpdate_(arg_437_0)
			local var_437_0 = 1.999999999999

			if var_437_0 < arg_434_1.time_ and arg_434_1.time_ <= var_437_0 + arg_437_0 then
				local var_437_1 = manager.ui.mainCamera.transform.localPosition
				local var_437_2 = Vector3.New(0, 0, 10) + Vector3.New(var_437_1.x, var_437_1.y, 0)
				local var_437_3 = arg_434_1.bgs_.STblack

				var_437_3.transform.localPosition = var_437_2
				var_437_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_437_4 = var_437_3:GetComponent("SpriteRenderer")

				if var_437_4 and var_437_4.sprite then
					local var_437_5 = (var_437_3.transform.localPosition - var_437_1).z
					local var_437_6 = manager.ui.mainCameraCom_
					local var_437_7 = 2 * var_437_5 * Mathf.Tan(var_437_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_437_8 = var_437_7 * var_437_6.aspect
					local var_437_9 = var_437_4.sprite.bounds.size.x
					local var_437_10 = var_437_4.sprite.bounds.size.y
					local var_437_11 = var_437_8 / var_437_9
					local var_437_12 = var_437_7 / var_437_10
					local var_437_13 = var_437_12 < var_437_11 and var_437_11 or var_437_12

					var_437_3.transform.localScale = Vector3.New(var_437_13, var_437_13, 0)
				end

				for iter_437_0, iter_437_1 in pairs(arg_434_1.bgs_) do
					if iter_437_0 ~= "STblack" then
						iter_437_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_437_14 = 3.999999999999

			if var_437_14 < arg_434_1.time_ and arg_434_1.time_ <= var_437_14 + arg_437_0 then
				arg_434_1.allBtn_.enabled = false
			end

			local var_437_15 = 0.3

			if arg_434_1.time_ >= var_437_14 + var_437_15 and arg_434_1.time_ < var_437_14 + var_437_15 + arg_437_0 then
				arg_434_1.allBtn_.enabled = true
			end

			local var_437_16 = 0

			if var_437_16 < arg_434_1.time_ and arg_434_1.time_ <= var_437_16 + arg_437_0 then
				arg_434_1.mask_.enabled = true
				arg_434_1.mask_.raycastTarget = true

				arg_434_1:SetGaussion(false)
			end

			local var_437_17 = 2

			if var_437_16 <= arg_434_1.time_ and arg_434_1.time_ < var_437_16 + var_437_17 then
				local var_437_18 = (arg_434_1.time_ - var_437_16) / var_437_17
				local var_437_19 = Color.New(0, 0, 0)

				var_437_19.a = Mathf.Lerp(0, 1, var_437_18)
				arg_434_1.mask_.color = var_437_19
			end

			if arg_434_1.time_ >= var_437_16 + var_437_17 and arg_434_1.time_ < var_437_16 + var_437_17 + arg_437_0 then
				local var_437_20 = Color.New(0, 0, 0)

				var_437_20.a = 1
				arg_434_1.mask_.color = var_437_20
			end

			local var_437_21 = 2

			if var_437_21 < arg_434_1.time_ and arg_434_1.time_ <= var_437_21 + arg_437_0 then
				arg_434_1.mask_.enabled = true
				arg_434_1.mask_.raycastTarget = true

				arg_434_1:SetGaussion(false)
			end

			local var_437_22 = 2

			if var_437_21 <= arg_434_1.time_ and arg_434_1.time_ < var_437_21 + var_437_22 then
				local var_437_23 = (arg_434_1.time_ - var_437_21) / var_437_22
				local var_437_24 = Color.New(0, 0, 0)

				var_437_24.a = Mathf.Lerp(1, 0, var_437_23)
				arg_434_1.mask_.color = var_437_24
			end

			if arg_434_1.time_ >= var_437_21 + var_437_22 and arg_434_1.time_ < var_437_21 + var_437_22 + arg_437_0 then
				local var_437_25 = Color.New(0, 0, 0)
				local var_437_26 = 0

				arg_434_1.mask_.enabled = false
				var_437_25.a = var_437_26
				arg_434_1.mask_.color = var_437_25
			end

			if arg_434_1.frameCnt_ <= 1 then
				arg_434_1.dialog_:SetActive(false)
			end

			local var_437_27 = 4
			local var_437_28 = 0.375

			if var_437_27 < arg_434_1.time_ and arg_434_1.time_ <= var_437_27 + arg_437_0 then
				arg_434_1.talkMaxDuration = 0

				arg_434_1.dialog_:SetActive(true)

				arg_434_1.dialogCg_.alpha = 0

				local var_437_29 = LeanTween.value(arg_434_1.dialog_, 0, 1, 0.3)

				var_437_29:setOnUpdate(LuaHelper.FloatAction(function(arg_438_0)
					arg_434_1.dialogCg_.alpha = arg_438_0
				end))
				var_437_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_434_1.dialog_)
					var_437_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_434_1.duration_ = arg_434_1.duration_ + 0.3

				SetActive(arg_434_1.leftNameGo_, true)

				local var_437_30 = arg_434_1:FormatText(StoryNameCfg[7].name)

				arg_434_1.leftNameTxt_.text = var_437_30

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_434_1.leftNameTxt_.transform)

				arg_434_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_434_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_434_1:RecordName(arg_434_1.leftNameTxt_.text)
				SetActive(arg_434_1.iconTrs_.gameObject, true)
				arg_434_1.iconController_:SetSelectedState("hero")

				arg_434_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_434_1.callingController_:SetSelectedState("normal")

				arg_434_1.keyicon_.color = Color.New(1, 1, 1)
				arg_434_1.icon_.color = Color.New(1, 1, 1)

				local var_437_31 = arg_434_1:GetWordFromCfg(426101102)
				local var_437_32 = arg_434_1:FormatText(var_437_31.content)

				arg_434_1.text_.text = var_437_32

				LuaForUtil.ClearLinePrefixSymbol(arg_434_1.text_)

				local var_437_33 = 15
				local var_437_34 = utf8.len(var_437_32)
				local var_437_35 = var_437_33 <= 0 and var_437_28 or var_437_28 * (var_437_34 / var_437_33)

				if var_437_35 > 0 and var_437_28 < var_437_35 then
					arg_434_1.talkMaxDuration = var_437_35
					var_437_27 = var_437_27 + 0.3

					if var_437_35 + var_437_27 > arg_434_1.duration_ then
						arg_434_1.duration_ = var_437_35 + var_437_27
					end
				end

				arg_434_1.text_.text = var_437_32
				arg_434_1.typewritter.percent = 0

				arg_434_1.typewritter:SetDirty()
				arg_434_1:ShowNextGo(false)
				arg_434_1:RecordContent(arg_434_1.text_.text)
			end

			local var_437_36 = var_437_27 + 0.3
			local var_437_37 = math.max(var_437_28, arg_434_1.talkMaxDuration)

			if var_437_36 <= arg_434_1.time_ and arg_434_1.time_ < var_437_36 + var_437_37 then
				arg_434_1.typewritter.percent = (arg_434_1.time_ - var_437_36) / var_437_37

				arg_434_1.typewritter:SetDirty()
			end

			if arg_434_1.time_ >= var_437_36 + var_437_37 and arg_434_1.time_ < var_437_36 + var_437_37 + arg_437_0 then
				arg_434_1.typewritter.percent = 1

				arg_434_1.typewritter:SetDirty()
				arg_434_1:ShowNextGo(true)
			end
		end

		arg_434_1.nodeConfigList_ = {}

		arg_434_1:InitPlayNodeList()
	end,
	Play426101103 = function(arg_440_0, arg_440_1)
		arg_440_1.time_ = 0
		arg_440_1.frameCnt_ = 0
		arg_440_1.state_ = "playing"
		arg_440_1.curTalkId_ = 426101103
		arg_440_1.duration_ = 5

		SetActive(arg_440_1.tipsGo_, false)

		function arg_440_1.onSingleLineFinish_()
			arg_440_1.onSingleLineUpdate_ = nil
			arg_440_1.onSingleLineFinish_ = nil
			arg_440_1.state_ = "waiting"
		end

		function arg_440_1.playNext_(arg_442_0)
			if arg_442_0 == 1 then
				arg_440_0:Play426101104(arg_440_1)
			end
		end

		function arg_440_1.onSingleLineUpdate_(arg_443_0)
			local var_443_0 = 0
			local var_443_1 = 0.35

			if var_443_0 < arg_440_1.time_ and arg_440_1.time_ <= var_443_0 + arg_443_0 then
				arg_440_1.talkMaxDuration = 0
				arg_440_1.dialogCg_.alpha = 1

				arg_440_1.dialog_:SetActive(true)
				SetActive(arg_440_1.leftNameGo_, true)

				local var_443_2 = arg_440_1:FormatText(StoryNameCfg[7].name)

				arg_440_1.leftNameTxt_.text = var_443_2

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

				local var_443_3 = arg_440_1:GetWordFromCfg(426101103)
				local var_443_4 = arg_440_1:FormatText(var_443_3.content)

				arg_440_1.text_.text = var_443_4

				LuaForUtil.ClearLinePrefixSymbol(arg_440_1.text_)

				local var_443_5 = 14
				local var_443_6 = utf8.len(var_443_4)
				local var_443_7 = var_443_5 <= 0 and var_443_1 or var_443_1 * (var_443_6 / var_443_5)

				if var_443_7 > 0 and var_443_1 < var_443_7 then
					arg_440_1.talkMaxDuration = var_443_7

					if var_443_7 + var_443_0 > arg_440_1.duration_ then
						arg_440_1.duration_ = var_443_7 + var_443_0
					end
				end

				arg_440_1.text_.text = var_443_4
				arg_440_1.typewritter.percent = 0

				arg_440_1.typewritter:SetDirty()
				arg_440_1:ShowNextGo(false)
				arg_440_1:RecordContent(arg_440_1.text_.text)
			end

			local var_443_8 = math.max(var_443_1, arg_440_1.talkMaxDuration)

			if var_443_0 <= arg_440_1.time_ and arg_440_1.time_ < var_443_0 + var_443_8 then
				arg_440_1.typewritter.percent = (arg_440_1.time_ - var_443_0) / var_443_8

				arg_440_1.typewritter:SetDirty()
			end

			if arg_440_1.time_ >= var_443_0 + var_443_8 and arg_440_1.time_ < var_443_0 + var_443_8 + arg_443_0 then
				arg_440_1.typewritter.percent = 1

				arg_440_1.typewritter:SetDirty()
				arg_440_1:ShowNextGo(true)
			end
		end

		arg_440_1.nodeConfigList_ = {}

		arg_440_1:InitPlayNodeList()
	end,
	Play426101104 = function(arg_444_0, arg_444_1)
		arg_444_1.time_ = 0
		arg_444_1.frameCnt_ = 0
		arg_444_1.state_ = "playing"
		arg_444_1.curTalkId_ = 426101104
		arg_444_1.duration_ = 5

		SetActive(arg_444_1.tipsGo_, false)

		function arg_444_1.onSingleLineFinish_()
			arg_444_1.onSingleLineUpdate_ = nil
			arg_444_1.onSingleLineFinish_ = nil
			arg_444_1.state_ = "waiting"
		end

		function arg_444_1.playNext_(arg_446_0)
			if arg_446_0 == 1 then
				arg_444_0:Play426101105(arg_444_1)
			end
		end

		function arg_444_1.onSingleLineUpdate_(arg_447_0)
			local var_447_0 = 0
			local var_447_1 = 0.45

			if var_447_0 < arg_444_1.time_ and arg_444_1.time_ <= var_447_0 + arg_447_0 then
				arg_444_1.talkMaxDuration = 0
				arg_444_1.dialogCg_.alpha = 1

				arg_444_1.dialog_:SetActive(true)
				SetActive(arg_444_1.leftNameGo_, true)

				local var_447_2 = arg_444_1:FormatText(StoryNameCfg[7].name)

				arg_444_1.leftNameTxt_.text = var_447_2

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

				local var_447_3 = arg_444_1:GetWordFromCfg(426101104)
				local var_447_4 = arg_444_1:FormatText(var_447_3.content)

				arg_444_1.text_.text = var_447_4

				LuaForUtil.ClearLinePrefixSymbol(arg_444_1.text_)

				local var_447_5 = 18
				local var_447_6 = utf8.len(var_447_4)
				local var_447_7 = var_447_5 <= 0 and var_447_1 or var_447_1 * (var_447_6 / var_447_5)

				if var_447_7 > 0 and var_447_1 < var_447_7 then
					arg_444_1.talkMaxDuration = var_447_7

					if var_447_7 + var_447_0 > arg_444_1.duration_ then
						arg_444_1.duration_ = var_447_7 + var_447_0
					end
				end

				arg_444_1.text_.text = var_447_4
				arg_444_1.typewritter.percent = 0

				arg_444_1.typewritter:SetDirty()
				arg_444_1:ShowNextGo(false)
				arg_444_1:RecordContent(arg_444_1.text_.text)
			end

			local var_447_8 = math.max(var_447_1, arg_444_1.talkMaxDuration)

			if var_447_0 <= arg_444_1.time_ and arg_444_1.time_ < var_447_0 + var_447_8 then
				arg_444_1.typewritter.percent = (arg_444_1.time_ - var_447_0) / var_447_8

				arg_444_1.typewritter:SetDirty()
			end

			if arg_444_1.time_ >= var_447_0 + var_447_8 and arg_444_1.time_ < var_447_0 + var_447_8 + arg_447_0 then
				arg_444_1.typewritter.percent = 1

				arg_444_1.typewritter:SetDirty()
				arg_444_1:ShowNextGo(true)
			end
		end

		arg_444_1.nodeConfigList_ = {}

		arg_444_1:InitPlayNodeList()
	end,
	Play426101105 = function(arg_448_0, arg_448_1)
		arg_448_1.time_ = 0
		arg_448_1.frameCnt_ = 0
		arg_448_1.state_ = "playing"
		arg_448_1.curTalkId_ = 426101105
		arg_448_1.duration_ = 5

		SetActive(arg_448_1.tipsGo_, false)

		function arg_448_1.onSingleLineFinish_()
			arg_448_1.onSingleLineUpdate_ = nil
			arg_448_1.onSingleLineFinish_ = nil
			arg_448_1.state_ = "waiting"
		end

		function arg_448_1.playNext_(arg_450_0)
			if arg_450_0 == 1 then
				arg_448_0:Play426101106(arg_448_1)
			end
		end

		function arg_448_1.onSingleLineUpdate_(arg_451_0)
			local var_451_0 = 0
			local var_451_1 = 1.225

			if var_451_0 < arg_448_1.time_ and arg_448_1.time_ <= var_451_0 + arg_451_0 then
				arg_448_1.talkMaxDuration = 0
				arg_448_1.dialogCg_.alpha = 1

				arg_448_1.dialog_:SetActive(true)
				SetActive(arg_448_1.leftNameGo_, false)

				arg_448_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_448_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_448_1:RecordName(arg_448_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_448_1.iconTrs_.gameObject, false)
				arg_448_1.callingController_:SetSelectedState("normal")

				local var_451_2 = arg_448_1:GetWordFromCfg(426101105)
				local var_451_3 = arg_448_1:FormatText(var_451_2.content)

				arg_448_1.text_.text = var_451_3

				LuaForUtil.ClearLinePrefixSymbol(arg_448_1.text_)

				local var_451_4 = 49
				local var_451_5 = utf8.len(var_451_3)
				local var_451_6 = var_451_4 <= 0 and var_451_1 or var_451_1 * (var_451_5 / var_451_4)

				if var_451_6 > 0 and var_451_1 < var_451_6 then
					arg_448_1.talkMaxDuration = var_451_6

					if var_451_6 + var_451_0 > arg_448_1.duration_ then
						arg_448_1.duration_ = var_451_6 + var_451_0
					end
				end

				arg_448_1.text_.text = var_451_3
				arg_448_1.typewritter.percent = 0

				arg_448_1.typewritter:SetDirty()
				arg_448_1:ShowNextGo(false)
				arg_448_1:RecordContent(arg_448_1.text_.text)
			end

			local var_451_7 = math.max(var_451_1, arg_448_1.talkMaxDuration)

			if var_451_0 <= arg_448_1.time_ and arg_448_1.time_ < var_451_0 + var_451_7 then
				arg_448_1.typewritter.percent = (arg_448_1.time_ - var_451_0) / var_451_7

				arg_448_1.typewritter:SetDirty()
			end

			if arg_448_1.time_ >= var_451_0 + var_451_7 and arg_448_1.time_ < var_451_0 + var_451_7 + arg_451_0 then
				arg_448_1.typewritter.percent = 1

				arg_448_1.typewritter:SetDirty()
				arg_448_1:ShowNextGo(true)
			end
		end

		arg_448_1.nodeConfigList_ = {}

		arg_448_1:InitPlayNodeList()
	end,
	Play426101106 = function(arg_452_0, arg_452_1)
		arg_452_1.time_ = 0
		arg_452_1.frameCnt_ = 0
		arg_452_1.state_ = "playing"
		arg_452_1.curTalkId_ = 426101106
		arg_452_1.duration_ = 6.47

		local var_452_0 = {
			zh = 6.46666666666667,
			ja = 5.49966666666667
		}
		local var_452_1 = manager.audio:GetLocalizationFlag()

		if var_452_0[var_452_1] ~= nil then
			arg_452_1.duration_ = var_452_0[var_452_1]
		end

		SetActive(arg_452_1.tipsGo_, false)

		function arg_452_1.onSingleLineFinish_()
			arg_452_1.onSingleLineUpdate_ = nil
			arg_452_1.onSingleLineFinish_ = nil
			arg_452_1.state_ = "waiting"
		end

		function arg_452_1.playNext_(arg_454_0)
			if arg_454_0 == 1 then
				arg_452_0:Play426101107(arg_452_1)
			end
		end

		function arg_452_1.onSingleLineUpdate_(arg_455_0)
			local var_455_0 = "SS2603"

			if arg_452_1.bgs_[var_455_0] == nil then
				local var_455_1 = Object.Instantiate(arg_452_1.paintGo_)

				var_455_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_455_0)
				var_455_1.name = var_455_0
				var_455_1.transform.parent = arg_452_1.stage_.transform
				var_455_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_452_1.bgs_[var_455_0] = var_455_1
			end

			local var_455_2 = 0

			if var_455_2 < arg_452_1.time_ and arg_452_1.time_ <= var_455_2 + arg_455_0 then
				local var_455_3 = manager.ui.mainCamera.transform.localPosition
				local var_455_4 = Vector3.New(0, 0, 10) + Vector3.New(var_455_3.x, var_455_3.y, 0)
				local var_455_5 = arg_452_1.bgs_.SS2603

				var_455_5.transform.localPosition = var_455_4
				var_455_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_455_6 = var_455_5:GetComponent("SpriteRenderer")

				if var_455_6 and var_455_6.sprite then
					local var_455_7 = (var_455_5.transform.localPosition - var_455_3).z
					local var_455_8 = manager.ui.mainCameraCom_
					local var_455_9 = 2 * var_455_7 * Mathf.Tan(var_455_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_455_10 = var_455_9 * var_455_8.aspect
					local var_455_11 = var_455_6.sprite.bounds.size.x
					local var_455_12 = var_455_6.sprite.bounds.size.y
					local var_455_13 = var_455_10 / var_455_11
					local var_455_14 = var_455_9 / var_455_12
					local var_455_15 = var_455_14 < var_455_13 and var_455_13 or var_455_14

					var_455_5.transform.localScale = Vector3.New(var_455_15, var_455_15, 0)
				end

				for iter_455_0, iter_455_1 in pairs(arg_452_1.bgs_) do
					if iter_455_0 ~= "SS2603" then
						iter_455_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_455_16 = 2

			if var_455_16 < arg_452_1.time_ and arg_452_1.time_ <= var_455_16 + arg_455_0 then
				arg_452_1.allBtn_.enabled = false
			end

			local var_455_17 = 0.3

			if arg_452_1.time_ >= var_455_16 + var_455_17 and arg_452_1.time_ < var_455_16 + var_455_17 + arg_455_0 then
				arg_452_1.allBtn_.enabled = true
			end

			local var_455_18 = 0

			if var_455_18 < arg_452_1.time_ and arg_452_1.time_ <= var_455_18 + arg_455_0 then
				arg_452_1.mask_.enabled = true
				arg_452_1.mask_.raycastTarget = true

				arg_452_1:SetGaussion(false)
			end

			local var_455_19 = 2

			if var_455_18 <= arg_452_1.time_ and arg_452_1.time_ < var_455_18 + var_455_19 then
				local var_455_20 = (arg_452_1.time_ - var_455_18) / var_455_19
				local var_455_21 = Color.New(0, 0, 0)

				var_455_21.a = Mathf.Lerp(1, 0, var_455_20)
				arg_452_1.mask_.color = var_455_21
			end

			if arg_452_1.time_ >= var_455_18 + var_455_19 and arg_452_1.time_ < var_455_18 + var_455_19 + arg_455_0 then
				local var_455_22 = Color.New(0, 0, 0)
				local var_455_23 = 0

				arg_452_1.mask_.enabled = false
				var_455_22.a = var_455_23
				arg_452_1.mask_.color = var_455_22
			end

			local var_455_24 = manager.ui.mainCamera.transform
			local var_455_25 = 0

			if var_455_25 < arg_452_1.time_ and arg_452_1.time_ <= var_455_25 + arg_455_0 then
				local var_455_26 = arg_452_1.var_.effectzhengyanbeiwo1
				local var_455_27
				local var_455_28 = var_455_24

				if not var_455_26 then
					var_455_26 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_snapopen"), var_455_28)
					var_455_26.name = "zhengyanbeiwo1"
					arg_452_1.var_.effectzhengyanbeiwo1 = var_455_26
				else
					var_455_26.transform:SetParent(var_455_28)
				end

				var_455_26.transform.localPosition = Vector3.New(0, 0, 0)
				var_455_26.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_455_29 = arg_452_1.bgs_.SS2603.transform
			local var_455_30 = 0

			if var_455_30 < arg_452_1.time_ and arg_452_1.time_ <= var_455_30 + arg_455_0 then
				arg_452_1.var_.moveOldPosSS2603 = var_455_29.localPosition
			end

			local var_455_31 = 2

			if var_455_30 <= arg_452_1.time_ and arg_452_1.time_ < var_455_30 + var_455_31 then
				local var_455_32 = (arg_452_1.time_ - var_455_30) / var_455_31
				local var_455_33 = Vector3.New(-1.08, 1, 5.43)

				var_455_29.localPosition = Vector3.Lerp(arg_452_1.var_.moveOldPosSS2603, var_455_33, var_455_32)
			end

			if arg_452_1.time_ >= var_455_30 + var_455_31 and arg_452_1.time_ < var_455_30 + var_455_31 + arg_455_0 then
				var_455_29.localPosition = Vector3.New(-1.08, 1, 5.43)
			end

			local var_455_34 = arg_452_1.bgs_.SS2603.transform
			local var_455_35 = 2

			if var_455_35 < arg_452_1.time_ and arg_452_1.time_ <= var_455_35 + arg_455_0 then
				arg_452_1.var_.moveOldPosSS2603 = var_455_34.localPosition
			end

			local var_455_36 = 2

			if var_455_35 <= arg_452_1.time_ and arg_452_1.time_ < var_455_35 + var_455_36 then
				local var_455_37 = (arg_452_1.time_ - var_455_35) / var_455_36
				local var_455_38 = Vector3.New(-0.5, 1, 6.5)

				var_455_34.localPosition = Vector3.Lerp(arg_452_1.var_.moveOldPosSS2603, var_455_38, var_455_37)
			end

			if arg_452_1.time_ >= var_455_35 + var_455_36 and arg_452_1.time_ < var_455_35 + var_455_36 + arg_455_0 then
				var_455_34.localPosition = Vector3.New(-0.5, 1, 6.5)
			end

			if arg_452_1.frameCnt_ <= 1 then
				arg_452_1.dialog_:SetActive(false)
			end

			local var_455_39 = 3.56666666666667
			local var_455_40 = 0.433333333333333

			if var_455_39 < arg_452_1.time_ and arg_452_1.time_ <= var_455_39 + arg_455_0 then
				arg_452_1.talkMaxDuration = 0

				arg_452_1.dialog_:SetActive(true)

				arg_452_1.dialogCg_.alpha = 0

				local var_455_41 = LeanTween.value(arg_452_1.dialog_, 0, 1, 0.3)

				var_455_41:setOnUpdate(LuaHelper.FloatAction(function(arg_456_0)
					arg_452_1.dialogCg_.alpha = arg_456_0
				end))
				var_455_41:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_452_1.dialog_)
					var_455_41:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_452_1.duration_ = arg_452_1.duration_ + 0.3

				SetActive(arg_452_1.leftNameGo_, true)

				local var_455_42 = arg_452_1:FormatText(StoryNameCfg[1487].name)

				arg_452_1.leftNameTxt_.text = var_455_42

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_452_1.leftNameTxt_.transform)

				arg_452_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_452_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_452_1:RecordName(arg_452_1.leftNameTxt_.text)
				SetActive(arg_452_1.iconTrs_.gameObject, false)
				arg_452_1.callingController_:SetSelectedState("normal")

				local var_455_43 = arg_452_1:GetWordFromCfg(426101106)
				local var_455_44 = arg_452_1:FormatText(var_455_43.content)

				arg_452_1.text_.text = var_455_44

				LuaForUtil.ClearLinePrefixSymbol(arg_452_1.text_)

				local var_455_45 = 4
				local var_455_46 = utf8.len(var_455_44)
				local var_455_47 = var_455_45 <= 0 and var_455_40 or var_455_40 * (var_455_46 / var_455_45)

				if var_455_47 > 0 and var_455_40 < var_455_47 then
					arg_452_1.talkMaxDuration = var_455_47
					var_455_39 = var_455_39 + 0.3

					if var_455_47 + var_455_39 > arg_452_1.duration_ then
						arg_452_1.duration_ = var_455_47 + var_455_39
					end
				end

				arg_452_1.text_.text = var_455_44
				arg_452_1.typewritter.percent = 0

				arg_452_1.typewritter:SetDirty()
				arg_452_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426101", "426101106", "story_v_out_426101.awb") ~= 0 then
					local var_455_48 = manager.audio:GetVoiceLength("story_v_out_426101", "426101106", "story_v_out_426101.awb") / 1000

					if var_455_48 + var_455_39 > arg_452_1.duration_ then
						arg_452_1.duration_ = var_455_48 + var_455_39
					end

					if var_455_43.prefab_name ~= "" and arg_452_1.actors_[var_455_43.prefab_name] ~= nil then
						local var_455_49 = LuaForUtil.PlayVoiceWithCriLipsync(arg_452_1.actors_[var_455_43.prefab_name].transform, "story_v_out_426101", "426101106", "story_v_out_426101.awb")

						arg_452_1:RecordAudio("426101106", var_455_49)
						arg_452_1:RecordAudio("426101106", var_455_49)
					else
						arg_452_1:AudioAction("play", "voice", "story_v_out_426101", "426101106", "story_v_out_426101.awb")
					end

					arg_452_1:RecordHistoryTalkVoice("story_v_out_426101", "426101106", "story_v_out_426101.awb")
				end

				arg_452_1:RecordContent(arg_452_1.text_.text)
			end

			local var_455_50 = var_455_39 + 0.3
			local var_455_51 = math.max(var_455_40, arg_452_1.talkMaxDuration)

			if var_455_50 <= arg_452_1.time_ and arg_452_1.time_ < var_455_50 + var_455_51 then
				arg_452_1.typewritter.percent = (arg_452_1.time_ - var_455_50) / var_455_51

				arg_452_1.typewritter:SetDirty()
			end

			if arg_452_1.time_ >= var_455_50 + var_455_51 and arg_452_1.time_ < var_455_50 + var_455_51 + arg_455_0 then
				arg_452_1.typewritter.percent = 1

				arg_452_1.typewritter:SetDirty()
				arg_452_1:ShowNextGo(true)
			end
		end

		arg_452_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "SS2603",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 2,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(-1.08, 1.1, 5.2),
					endPos = Vector3.New(-1.08, 1, 5.43),
					easeType = LeanTweenType.easeInOutExpo
				}
			},
			{
				assetPath = "",
				needEase = true,
				actorName = "SS2603",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 2,
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(-1.08, 1, 5.43),
					endPos = Vector3.New(-0.5, 1, 6.5),
					easeType = LeanTweenType.easeInOutExpo
				}
			}
		}

		arg_452_1:InitPlayNodeList()
	end,
	Play426101107 = function(arg_458_0, arg_458_1)
		arg_458_1.time_ = 0
		arg_458_1.frameCnt_ = 0
		arg_458_1.state_ = "playing"
		arg_458_1.curTalkId_ = 426101107
		arg_458_1.duration_ = 5.5

		local var_458_0 = {
			zh = 5.466,
			ja = 5.5
		}
		local var_458_1 = manager.audio:GetLocalizationFlag()

		if var_458_0[var_458_1] ~= nil then
			arg_458_1.duration_ = var_458_0[var_458_1]
		end

		SetActive(arg_458_1.tipsGo_, false)

		function arg_458_1.onSingleLineFinish_()
			arg_458_1.onSingleLineUpdate_ = nil
			arg_458_1.onSingleLineFinish_ = nil
			arg_458_1.state_ = "waiting"
		end

		function arg_458_1.playNext_(arg_460_0)
			if arg_460_0 == 1 then
				arg_458_0:Play426101108(arg_458_1)
			end
		end

		function arg_458_1.onSingleLineUpdate_(arg_461_0)
			local var_461_0 = 0
			local var_461_1 = 0.45

			if var_461_0 < arg_458_1.time_ and arg_458_1.time_ <= var_461_0 + arg_461_0 then
				arg_458_1.talkMaxDuration = 0
				arg_458_1.dialogCg_.alpha = 1

				arg_458_1.dialog_:SetActive(true)
				SetActive(arg_458_1.leftNameGo_, true)

				local var_461_2 = arg_458_1:FormatText(StoryNameCfg[1488].name)

				arg_458_1.leftNameTxt_.text = var_461_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_458_1.leftNameTxt_.transform)

				arg_458_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_458_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_458_1:RecordName(arg_458_1.leftNameTxt_.text)
				SetActive(arg_458_1.iconTrs_.gameObject, false)
				arg_458_1.callingController_:SetSelectedState("normal")

				local var_461_3 = arg_458_1:GetWordFromCfg(426101107)
				local var_461_4 = arg_458_1:FormatText(var_461_3.content)

				arg_458_1.text_.text = var_461_4

				LuaForUtil.ClearLinePrefixSymbol(arg_458_1.text_)

				local var_461_5 = 18
				local var_461_6 = utf8.len(var_461_4)
				local var_461_7 = var_461_5 <= 0 and var_461_1 or var_461_1 * (var_461_6 / var_461_5)

				if var_461_7 > 0 and var_461_1 < var_461_7 then
					arg_458_1.talkMaxDuration = var_461_7

					if var_461_7 + var_461_0 > arg_458_1.duration_ then
						arg_458_1.duration_ = var_461_7 + var_461_0
					end
				end

				arg_458_1.text_.text = var_461_4
				arg_458_1.typewritter.percent = 0

				arg_458_1.typewritter:SetDirty()
				arg_458_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426101", "426101107", "story_v_out_426101.awb") ~= 0 then
					local var_461_8 = manager.audio:GetVoiceLength("story_v_out_426101", "426101107", "story_v_out_426101.awb") / 1000

					if var_461_8 + var_461_0 > arg_458_1.duration_ then
						arg_458_1.duration_ = var_461_8 + var_461_0
					end

					if var_461_3.prefab_name ~= "" and arg_458_1.actors_[var_461_3.prefab_name] ~= nil then
						local var_461_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_458_1.actors_[var_461_3.prefab_name].transform, "story_v_out_426101", "426101107", "story_v_out_426101.awb")

						arg_458_1:RecordAudio("426101107", var_461_9)
						arg_458_1:RecordAudio("426101107", var_461_9)
					else
						arg_458_1:AudioAction("play", "voice", "story_v_out_426101", "426101107", "story_v_out_426101.awb")
					end

					arg_458_1:RecordHistoryTalkVoice("story_v_out_426101", "426101107", "story_v_out_426101.awb")
				end

				arg_458_1:RecordContent(arg_458_1.text_.text)
			end

			local var_461_10 = math.max(var_461_1, arg_458_1.talkMaxDuration)

			if var_461_0 <= arg_458_1.time_ and arg_458_1.time_ < var_461_0 + var_461_10 then
				arg_458_1.typewritter.percent = (arg_458_1.time_ - var_461_0) / var_461_10

				arg_458_1.typewritter:SetDirty()
			end

			if arg_458_1.time_ >= var_461_0 + var_461_10 and arg_458_1.time_ < var_461_0 + var_461_10 + arg_461_0 then
				arg_458_1.typewritter.percent = 1

				arg_458_1.typewritter:SetDirty()
				arg_458_1:ShowNextGo(true)
			end
		end

		arg_458_1.nodeConfigList_ = {}

		arg_458_1:InitPlayNodeList()
	end,
	Play426101108 = function(arg_462_0, arg_462_1)
		arg_462_1.time_ = 0
		arg_462_1.frameCnt_ = 0
		arg_462_1.state_ = "playing"
		arg_462_1.curTalkId_ = 426101108
		arg_462_1.duration_ = 5

		SetActive(arg_462_1.tipsGo_, false)

		function arg_462_1.onSingleLineFinish_()
			arg_462_1.onSingleLineUpdate_ = nil
			arg_462_1.onSingleLineFinish_ = nil
			arg_462_1.state_ = "waiting"
		end

		function arg_462_1.playNext_(arg_464_0)
			if arg_464_0 == 1 then
				arg_462_0:Play426101109(arg_462_1)
			end
		end

		function arg_462_1.onSingleLineUpdate_(arg_465_0)
			local var_465_0 = 0
			local var_465_1 = 0.3

			if var_465_0 < arg_462_1.time_ and arg_462_1.time_ <= var_465_0 + arg_465_0 then
				arg_462_1.talkMaxDuration = 0
				arg_462_1.dialogCg_.alpha = 1

				arg_462_1.dialog_:SetActive(true)
				SetActive(arg_462_1.leftNameGo_, true)

				local var_465_2 = arg_462_1:FormatText(StoryNameCfg[7].name)

				arg_462_1.leftNameTxt_.text = var_465_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_462_1.leftNameTxt_.transform)

				arg_462_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_462_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_462_1:RecordName(arg_462_1.leftNameTxt_.text)
				SetActive(arg_462_1.iconTrs_.gameObject, true)
				arg_462_1.iconController_:SetSelectedState("hero")

				arg_462_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_462_1.callingController_:SetSelectedState("normal")

				arg_462_1.keyicon_.color = Color.New(1, 1, 1)
				arg_462_1.icon_.color = Color.New(1, 1, 1)

				local var_465_3 = arg_462_1:GetWordFromCfg(426101108)
				local var_465_4 = arg_462_1:FormatText(var_465_3.content)

				arg_462_1.text_.text = var_465_4

				LuaForUtil.ClearLinePrefixSymbol(arg_462_1.text_)

				local var_465_5 = 12
				local var_465_6 = utf8.len(var_465_4)
				local var_465_7 = var_465_5 <= 0 and var_465_1 or var_465_1 * (var_465_6 / var_465_5)

				if var_465_7 > 0 and var_465_1 < var_465_7 then
					arg_462_1.talkMaxDuration = var_465_7

					if var_465_7 + var_465_0 > arg_462_1.duration_ then
						arg_462_1.duration_ = var_465_7 + var_465_0
					end
				end

				arg_462_1.text_.text = var_465_4
				arg_462_1.typewritter.percent = 0

				arg_462_1.typewritter:SetDirty()
				arg_462_1:ShowNextGo(false)
				arg_462_1:RecordContent(arg_462_1.text_.text)
			end

			local var_465_8 = math.max(var_465_1, arg_462_1.talkMaxDuration)

			if var_465_0 <= arg_462_1.time_ and arg_462_1.time_ < var_465_0 + var_465_8 then
				arg_462_1.typewritter.percent = (arg_462_1.time_ - var_465_0) / var_465_8

				arg_462_1.typewritter:SetDirty()
			end

			if arg_462_1.time_ >= var_465_0 + var_465_8 and arg_462_1.time_ < var_465_0 + var_465_8 + arg_465_0 then
				arg_462_1.typewritter.percent = 1

				arg_462_1.typewritter:SetDirty()
				arg_462_1:ShowNextGo(true)
			end
		end

		arg_462_1.nodeConfigList_ = {}

		arg_462_1:InitPlayNodeList()
	end,
	Play426101109 = function(arg_466_0, arg_466_1)
		arg_466_1.time_ = 0
		arg_466_1.frameCnt_ = 0
		arg_466_1.state_ = "playing"
		arg_466_1.curTalkId_ = 426101109
		arg_466_1.duration_ = 6.73

		local var_466_0 = {
			zh = 6.733,
			ja = 4.866
		}
		local var_466_1 = manager.audio:GetLocalizationFlag()

		if var_466_0[var_466_1] ~= nil then
			arg_466_1.duration_ = var_466_0[var_466_1]
		end

		SetActive(arg_466_1.tipsGo_, false)

		function arg_466_1.onSingleLineFinish_()
			arg_466_1.onSingleLineUpdate_ = nil
			arg_466_1.onSingleLineFinish_ = nil
			arg_466_1.state_ = "waiting"
		end

		function arg_466_1.playNext_(arg_468_0)
			if arg_468_0 == 1 then
				arg_466_0:Play426101110(arg_466_1)
			end
		end

		function arg_466_1.onSingleLineUpdate_(arg_469_0)
			local var_469_0 = 0
			local var_469_1 = 0.55

			if var_469_0 < arg_466_1.time_ and arg_466_1.time_ <= var_469_0 + arg_469_0 then
				arg_466_1.talkMaxDuration = 0
				arg_466_1.dialogCg_.alpha = 1

				arg_466_1.dialog_:SetActive(true)
				SetActive(arg_466_1.leftNameGo_, true)

				local var_469_2 = arg_466_1:FormatText(StoryNameCfg[1487].name)

				arg_466_1.leftNameTxt_.text = var_469_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_466_1.leftNameTxt_.transform)

				arg_466_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_466_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_466_1:RecordName(arg_466_1.leftNameTxt_.text)
				SetActive(arg_466_1.iconTrs_.gameObject, false)
				arg_466_1.callingController_:SetSelectedState("normal")

				local var_469_3 = arg_466_1:GetWordFromCfg(426101109)
				local var_469_4 = arg_466_1:FormatText(var_469_3.content)

				arg_466_1.text_.text = var_469_4

				LuaForUtil.ClearLinePrefixSymbol(arg_466_1.text_)

				local var_469_5 = 22
				local var_469_6 = utf8.len(var_469_4)
				local var_469_7 = var_469_5 <= 0 and var_469_1 or var_469_1 * (var_469_6 / var_469_5)

				if var_469_7 > 0 and var_469_1 < var_469_7 then
					arg_466_1.talkMaxDuration = var_469_7

					if var_469_7 + var_469_0 > arg_466_1.duration_ then
						arg_466_1.duration_ = var_469_7 + var_469_0
					end
				end

				arg_466_1.text_.text = var_469_4
				arg_466_1.typewritter.percent = 0

				arg_466_1.typewritter:SetDirty()
				arg_466_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426101", "426101109", "story_v_out_426101.awb") ~= 0 then
					local var_469_8 = manager.audio:GetVoiceLength("story_v_out_426101", "426101109", "story_v_out_426101.awb") / 1000

					if var_469_8 + var_469_0 > arg_466_1.duration_ then
						arg_466_1.duration_ = var_469_8 + var_469_0
					end

					if var_469_3.prefab_name ~= "" and arg_466_1.actors_[var_469_3.prefab_name] ~= nil then
						local var_469_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_466_1.actors_[var_469_3.prefab_name].transform, "story_v_out_426101", "426101109", "story_v_out_426101.awb")

						arg_466_1:RecordAudio("426101109", var_469_9)
						arg_466_1:RecordAudio("426101109", var_469_9)
					else
						arg_466_1:AudioAction("play", "voice", "story_v_out_426101", "426101109", "story_v_out_426101.awb")
					end

					arg_466_1:RecordHistoryTalkVoice("story_v_out_426101", "426101109", "story_v_out_426101.awb")
				end

				arg_466_1:RecordContent(arg_466_1.text_.text)
			end

			local var_469_10 = math.max(var_469_1, arg_466_1.talkMaxDuration)

			if var_469_0 <= arg_466_1.time_ and arg_466_1.time_ < var_469_0 + var_469_10 then
				arg_466_1.typewritter.percent = (arg_466_1.time_ - var_469_0) / var_469_10

				arg_466_1.typewritter:SetDirty()
			end

			if arg_466_1.time_ >= var_469_0 + var_469_10 and arg_466_1.time_ < var_469_0 + var_469_10 + arg_469_0 then
				arg_466_1.typewritter.percent = 1

				arg_466_1.typewritter:SetDirty()
				arg_466_1:ShowNextGo(true)
			end
		end

		arg_466_1.nodeConfigList_ = {}

		arg_466_1:InitPlayNodeList()
	end,
	Play426101110 = function(arg_470_0, arg_470_1)
		arg_470_1.time_ = 0
		arg_470_1.frameCnt_ = 0
		arg_470_1.state_ = "playing"
		arg_470_1.curTalkId_ = 426101110
		arg_470_1.duration_ = 5

		SetActive(arg_470_1.tipsGo_, false)

		function arg_470_1.onSingleLineFinish_()
			arg_470_1.onSingleLineUpdate_ = nil
			arg_470_1.onSingleLineFinish_ = nil
			arg_470_1.state_ = "waiting"
		end

		function arg_470_1.playNext_(arg_472_0)
			if arg_472_0 == 1 then
				arg_470_0:Play426101111(arg_470_1)
			end
		end

		function arg_470_1.onSingleLineUpdate_(arg_473_0)
			local var_473_0 = 0
			local var_473_1 = 0.125

			if var_473_0 < arg_470_1.time_ and arg_470_1.time_ <= var_473_0 + arg_473_0 then
				arg_470_1.talkMaxDuration = 0
				arg_470_1.dialogCg_.alpha = 1

				arg_470_1.dialog_:SetActive(true)
				SetActive(arg_470_1.leftNameGo_, true)

				local var_473_2 = arg_470_1:FormatText(StoryNameCfg[7].name)

				arg_470_1.leftNameTxt_.text = var_473_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_470_1.leftNameTxt_.transform)

				arg_470_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_470_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_470_1:RecordName(arg_470_1.leftNameTxt_.text)
				SetActive(arg_470_1.iconTrs_.gameObject, true)
				arg_470_1.iconController_:SetSelectedState("hero")

				arg_470_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_470_1.callingController_:SetSelectedState("normal")

				arg_470_1.keyicon_.color = Color.New(1, 1, 1)
				arg_470_1.icon_.color = Color.New(1, 1, 1)

				local var_473_3 = arg_470_1:GetWordFromCfg(426101110)
				local var_473_4 = arg_470_1:FormatText(var_473_3.content)

				arg_470_1.text_.text = var_473_4

				LuaForUtil.ClearLinePrefixSymbol(arg_470_1.text_)

				local var_473_5 = 5
				local var_473_6 = utf8.len(var_473_4)
				local var_473_7 = var_473_5 <= 0 and var_473_1 or var_473_1 * (var_473_6 / var_473_5)

				if var_473_7 > 0 and var_473_1 < var_473_7 then
					arg_470_1.talkMaxDuration = var_473_7

					if var_473_7 + var_473_0 > arg_470_1.duration_ then
						arg_470_1.duration_ = var_473_7 + var_473_0
					end
				end

				arg_470_1.text_.text = var_473_4
				arg_470_1.typewritter.percent = 0

				arg_470_1.typewritter:SetDirty()
				arg_470_1:ShowNextGo(false)
				arg_470_1:RecordContent(arg_470_1.text_.text)
			end

			local var_473_8 = math.max(var_473_1, arg_470_1.talkMaxDuration)

			if var_473_0 <= arg_470_1.time_ and arg_470_1.time_ < var_473_0 + var_473_8 then
				arg_470_1.typewritter.percent = (arg_470_1.time_ - var_473_0) / var_473_8

				arg_470_1.typewritter:SetDirty()
			end

			if arg_470_1.time_ >= var_473_0 + var_473_8 and arg_470_1.time_ < var_473_0 + var_473_8 + arg_473_0 then
				arg_470_1.typewritter.percent = 1

				arg_470_1.typewritter:SetDirty()
				arg_470_1:ShowNextGo(true)
			end
		end

		arg_470_1.nodeConfigList_ = {}

		arg_470_1:InitPlayNodeList()
	end,
	Play426101111 = function(arg_474_0, arg_474_1)
		arg_474_1.time_ = 0
		arg_474_1.frameCnt_ = 0
		arg_474_1.state_ = "playing"
		arg_474_1.curTalkId_ = 426101111
		arg_474_1.duration_ = 9

		local var_474_0 = {
			zh = 4.633,
			ja = 9
		}
		local var_474_1 = manager.audio:GetLocalizationFlag()

		if var_474_0[var_474_1] ~= nil then
			arg_474_1.duration_ = var_474_0[var_474_1]
		end

		SetActive(arg_474_1.tipsGo_, false)

		function arg_474_1.onSingleLineFinish_()
			arg_474_1.onSingleLineUpdate_ = nil
			arg_474_1.onSingleLineFinish_ = nil
			arg_474_1.state_ = "waiting"
		end

		function arg_474_1.playNext_(arg_476_0)
			if arg_476_0 == 1 then
				arg_474_0:Play426101112(arg_474_1)
			end
		end

		function arg_474_1.onSingleLineUpdate_(arg_477_0)
			local var_477_0 = 0
			local var_477_1 = 0.475

			if var_477_0 < arg_474_1.time_ and arg_474_1.time_ <= var_477_0 + arg_477_0 then
				arg_474_1.talkMaxDuration = 0
				arg_474_1.dialogCg_.alpha = 1

				arg_474_1.dialog_:SetActive(true)
				SetActive(arg_474_1.leftNameGo_, true)

				local var_477_2 = arg_474_1:FormatText(StoryNameCfg[1487].name)

				arg_474_1.leftNameTxt_.text = var_477_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_474_1.leftNameTxt_.transform)

				arg_474_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_474_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_474_1:RecordName(arg_474_1.leftNameTxt_.text)
				SetActive(arg_474_1.iconTrs_.gameObject, false)
				arg_474_1.callingController_:SetSelectedState("normal")

				local var_477_3 = arg_474_1:GetWordFromCfg(426101111)
				local var_477_4 = arg_474_1:FormatText(var_477_3.content)

				arg_474_1.text_.text = var_477_4

				LuaForUtil.ClearLinePrefixSymbol(arg_474_1.text_)

				local var_477_5 = 19
				local var_477_6 = utf8.len(var_477_4)
				local var_477_7 = var_477_5 <= 0 and var_477_1 or var_477_1 * (var_477_6 / var_477_5)

				if var_477_7 > 0 and var_477_1 < var_477_7 then
					arg_474_1.talkMaxDuration = var_477_7

					if var_477_7 + var_477_0 > arg_474_1.duration_ then
						arg_474_1.duration_ = var_477_7 + var_477_0
					end
				end

				arg_474_1.text_.text = var_477_4
				arg_474_1.typewritter.percent = 0

				arg_474_1.typewritter:SetDirty()
				arg_474_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426101", "426101111", "story_v_out_426101.awb") ~= 0 then
					local var_477_8 = manager.audio:GetVoiceLength("story_v_out_426101", "426101111", "story_v_out_426101.awb") / 1000

					if var_477_8 + var_477_0 > arg_474_1.duration_ then
						arg_474_1.duration_ = var_477_8 + var_477_0
					end

					if var_477_3.prefab_name ~= "" and arg_474_1.actors_[var_477_3.prefab_name] ~= nil then
						local var_477_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_474_1.actors_[var_477_3.prefab_name].transform, "story_v_out_426101", "426101111", "story_v_out_426101.awb")

						arg_474_1:RecordAudio("426101111", var_477_9)
						arg_474_1:RecordAudio("426101111", var_477_9)
					else
						arg_474_1:AudioAction("play", "voice", "story_v_out_426101", "426101111", "story_v_out_426101.awb")
					end

					arg_474_1:RecordHistoryTalkVoice("story_v_out_426101", "426101111", "story_v_out_426101.awb")
				end

				arg_474_1:RecordContent(arg_474_1.text_.text)
			end

			local var_477_10 = math.max(var_477_1, arg_474_1.talkMaxDuration)

			if var_477_0 <= arg_474_1.time_ and arg_474_1.time_ < var_477_0 + var_477_10 then
				arg_474_1.typewritter.percent = (arg_474_1.time_ - var_477_0) / var_477_10

				arg_474_1.typewritter:SetDirty()
			end

			if arg_474_1.time_ >= var_477_0 + var_477_10 and arg_474_1.time_ < var_477_0 + var_477_10 + arg_477_0 then
				arg_474_1.typewritter.percent = 1

				arg_474_1.typewritter:SetDirty()
				arg_474_1:ShowNextGo(true)
			end
		end

		arg_474_1.nodeConfigList_ = {}

		arg_474_1:InitPlayNodeList()
	end,
	Play426101112 = function(arg_478_0, arg_478_1)
		arg_478_1.time_ = 0
		arg_478_1.frameCnt_ = 0
		arg_478_1.state_ = "playing"
		arg_478_1.curTalkId_ = 426101112
		arg_478_1.duration_ = 5

		SetActive(arg_478_1.tipsGo_, false)

		function arg_478_1.onSingleLineFinish_()
			arg_478_1.onSingleLineUpdate_ = nil
			arg_478_1.onSingleLineFinish_ = nil
			arg_478_1.state_ = "waiting"
		end

		function arg_478_1.playNext_(arg_480_0)
			if arg_480_0 == 1 then
				arg_478_0:Play426101113(arg_478_1)
			end
		end

		function arg_478_1.onSingleLineUpdate_(arg_481_0)
			local var_481_0 = 0
			local var_481_1 = 0.075

			if var_481_0 < arg_478_1.time_ and arg_478_1.time_ <= var_481_0 + arg_481_0 then
				arg_478_1.talkMaxDuration = 0
				arg_478_1.dialogCg_.alpha = 1

				arg_478_1.dialog_:SetActive(true)
				SetActive(arg_478_1.leftNameGo_, true)

				local var_481_2 = arg_478_1:FormatText(StoryNameCfg[7].name)

				arg_478_1.leftNameTxt_.text = var_481_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_478_1.leftNameTxt_.transform)

				arg_478_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_478_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_478_1:RecordName(arg_478_1.leftNameTxt_.text)
				SetActive(arg_478_1.iconTrs_.gameObject, true)
				arg_478_1.iconController_:SetSelectedState("hero")

				arg_478_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_478_1.callingController_:SetSelectedState("normal")

				arg_478_1.keyicon_.color = Color.New(1, 1, 1)
				arg_478_1.icon_.color = Color.New(1, 1, 1)

				local var_481_3 = arg_478_1:GetWordFromCfg(426101112)
				local var_481_4 = arg_478_1:FormatText(var_481_3.content)

				arg_478_1.text_.text = var_481_4

				LuaForUtil.ClearLinePrefixSymbol(arg_478_1.text_)

				local var_481_5 = 3
				local var_481_6 = utf8.len(var_481_4)
				local var_481_7 = var_481_5 <= 0 and var_481_1 or var_481_1 * (var_481_6 / var_481_5)

				if var_481_7 > 0 and var_481_1 < var_481_7 then
					arg_478_1.talkMaxDuration = var_481_7

					if var_481_7 + var_481_0 > arg_478_1.duration_ then
						arg_478_1.duration_ = var_481_7 + var_481_0
					end
				end

				arg_478_1.text_.text = var_481_4
				arg_478_1.typewritter.percent = 0

				arg_478_1.typewritter:SetDirty()
				arg_478_1:ShowNextGo(false)
				arg_478_1:RecordContent(arg_478_1.text_.text)
			end

			local var_481_8 = math.max(var_481_1, arg_478_1.talkMaxDuration)

			if var_481_0 <= arg_478_1.time_ and arg_478_1.time_ < var_481_0 + var_481_8 then
				arg_478_1.typewritter.percent = (arg_478_1.time_ - var_481_0) / var_481_8

				arg_478_1.typewritter:SetDirty()
			end

			if arg_478_1.time_ >= var_481_0 + var_481_8 and arg_478_1.time_ < var_481_0 + var_481_8 + arg_481_0 then
				arg_478_1.typewritter.percent = 1

				arg_478_1.typewritter:SetDirty()
				arg_478_1:ShowNextGo(true)
			end
		end

		arg_478_1.nodeConfigList_ = {}

		arg_478_1:InitPlayNodeList()
	end,
	Play426101113 = function(arg_482_0, arg_482_1)
		arg_482_1.time_ = 0
		arg_482_1.frameCnt_ = 0
		arg_482_1.state_ = "playing"
		arg_482_1.curTalkId_ = 426101113
		arg_482_1.duration_ = 5.07

		local var_482_0 = {
			zh = 3.9,
			ja = 5.066
		}
		local var_482_1 = manager.audio:GetLocalizationFlag()

		if var_482_0[var_482_1] ~= nil then
			arg_482_1.duration_ = var_482_0[var_482_1]
		end

		SetActive(arg_482_1.tipsGo_, false)

		function arg_482_1.onSingleLineFinish_()
			arg_482_1.onSingleLineUpdate_ = nil
			arg_482_1.onSingleLineFinish_ = nil
			arg_482_1.state_ = "waiting"
		end

		function arg_482_1.playNext_(arg_484_0)
			if arg_484_0 == 1 then
				arg_482_0:Play426101114(arg_482_1)
			end
		end

		function arg_482_1.onSingleLineUpdate_(arg_485_0)
			local var_485_0 = 0
			local var_485_1 = 0.325

			if var_485_0 < arg_482_1.time_ and arg_482_1.time_ <= var_485_0 + arg_485_0 then
				arg_482_1.talkMaxDuration = 0
				arg_482_1.dialogCg_.alpha = 1

				arg_482_1.dialog_:SetActive(true)
				SetActive(arg_482_1.leftNameGo_, true)

				local var_485_2 = arg_482_1:FormatText(StoryNameCfg[1487].name)

				arg_482_1.leftNameTxt_.text = var_485_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_482_1.leftNameTxt_.transform)

				arg_482_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_482_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_482_1:RecordName(arg_482_1.leftNameTxt_.text)
				SetActive(arg_482_1.iconTrs_.gameObject, false)
				arg_482_1.callingController_:SetSelectedState("normal")

				local var_485_3 = arg_482_1:GetWordFromCfg(426101113)
				local var_485_4 = arg_482_1:FormatText(var_485_3.content)

				arg_482_1.text_.text = var_485_4

				LuaForUtil.ClearLinePrefixSymbol(arg_482_1.text_)

				local var_485_5 = 13
				local var_485_6 = utf8.len(var_485_4)
				local var_485_7 = var_485_5 <= 0 and var_485_1 or var_485_1 * (var_485_6 / var_485_5)

				if var_485_7 > 0 and var_485_1 < var_485_7 then
					arg_482_1.talkMaxDuration = var_485_7

					if var_485_7 + var_485_0 > arg_482_1.duration_ then
						arg_482_1.duration_ = var_485_7 + var_485_0
					end
				end

				arg_482_1.text_.text = var_485_4
				arg_482_1.typewritter.percent = 0

				arg_482_1.typewritter:SetDirty()
				arg_482_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426101", "426101113", "story_v_out_426101.awb") ~= 0 then
					local var_485_8 = manager.audio:GetVoiceLength("story_v_out_426101", "426101113", "story_v_out_426101.awb") / 1000

					if var_485_8 + var_485_0 > arg_482_1.duration_ then
						arg_482_1.duration_ = var_485_8 + var_485_0
					end

					if var_485_3.prefab_name ~= "" and arg_482_1.actors_[var_485_3.prefab_name] ~= nil then
						local var_485_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_482_1.actors_[var_485_3.prefab_name].transform, "story_v_out_426101", "426101113", "story_v_out_426101.awb")

						arg_482_1:RecordAudio("426101113", var_485_9)
						arg_482_1:RecordAudio("426101113", var_485_9)
					else
						arg_482_1:AudioAction("play", "voice", "story_v_out_426101", "426101113", "story_v_out_426101.awb")
					end

					arg_482_1:RecordHistoryTalkVoice("story_v_out_426101", "426101113", "story_v_out_426101.awb")
				end

				arg_482_1:RecordContent(arg_482_1.text_.text)
			end

			local var_485_10 = math.max(var_485_1, arg_482_1.talkMaxDuration)

			if var_485_0 <= arg_482_1.time_ and arg_482_1.time_ < var_485_0 + var_485_10 then
				arg_482_1.typewritter.percent = (arg_482_1.time_ - var_485_0) / var_485_10

				arg_482_1.typewritter:SetDirty()
			end

			if arg_482_1.time_ >= var_485_0 + var_485_10 and arg_482_1.time_ < var_485_0 + var_485_10 + arg_485_0 then
				arg_482_1.typewritter.percent = 1

				arg_482_1.typewritter:SetDirty()
				arg_482_1:ShowNextGo(true)
			end
		end

		arg_482_1.nodeConfigList_ = {}

		arg_482_1:InitPlayNodeList()
	end,
	Play426101114 = function(arg_486_0, arg_486_1)
		arg_486_1.time_ = 0
		arg_486_1.frameCnt_ = 0
		arg_486_1.state_ = "playing"
		arg_486_1.curTalkId_ = 426101114
		arg_486_1.duration_ = 5

		SetActive(arg_486_1.tipsGo_, false)

		function arg_486_1.onSingleLineFinish_()
			arg_486_1.onSingleLineUpdate_ = nil
			arg_486_1.onSingleLineFinish_ = nil
			arg_486_1.state_ = "waiting"
		end

		function arg_486_1.playNext_(arg_488_0)
			if arg_488_0 == 1 then
				arg_486_0:Play426101115(arg_486_1)
			end
		end

		function arg_486_1.onSingleLineUpdate_(arg_489_0)
			local var_489_0 = 0
			local var_489_1 = 0.675

			if var_489_0 < arg_486_1.time_ and arg_486_1.time_ <= var_489_0 + arg_489_0 then
				arg_486_1.talkMaxDuration = 0
				arg_486_1.dialogCg_.alpha = 1

				arg_486_1.dialog_:SetActive(true)
				SetActive(arg_486_1.leftNameGo_, true)

				local var_489_2 = arg_486_1:FormatText(StoryNameCfg[7].name)

				arg_486_1.leftNameTxt_.text = var_489_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_486_1.leftNameTxt_.transform)

				arg_486_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_486_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_486_1:RecordName(arg_486_1.leftNameTxt_.text)
				SetActive(arg_486_1.iconTrs_.gameObject, true)
				arg_486_1.iconController_:SetSelectedState("hero")

				arg_486_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_486_1.callingController_:SetSelectedState("normal")

				arg_486_1.keyicon_.color = Color.New(1, 1, 1)
				arg_486_1.icon_.color = Color.New(1, 1, 1)

				local var_489_3 = arg_486_1:GetWordFromCfg(426101114)
				local var_489_4 = arg_486_1:FormatText(var_489_3.content)

				arg_486_1.text_.text = var_489_4

				LuaForUtil.ClearLinePrefixSymbol(arg_486_1.text_)

				local var_489_5 = 27
				local var_489_6 = utf8.len(var_489_4)
				local var_489_7 = var_489_5 <= 0 and var_489_1 or var_489_1 * (var_489_6 / var_489_5)

				if var_489_7 > 0 and var_489_1 < var_489_7 then
					arg_486_1.talkMaxDuration = var_489_7

					if var_489_7 + var_489_0 > arg_486_1.duration_ then
						arg_486_1.duration_ = var_489_7 + var_489_0
					end
				end

				arg_486_1.text_.text = var_489_4
				arg_486_1.typewritter.percent = 0

				arg_486_1.typewritter:SetDirty()
				arg_486_1:ShowNextGo(false)
				arg_486_1:RecordContent(arg_486_1.text_.text)
			end

			local var_489_8 = math.max(var_489_1, arg_486_1.talkMaxDuration)

			if var_489_0 <= arg_486_1.time_ and arg_486_1.time_ < var_489_0 + var_489_8 then
				arg_486_1.typewritter.percent = (arg_486_1.time_ - var_489_0) / var_489_8

				arg_486_1.typewritter:SetDirty()
			end

			if arg_486_1.time_ >= var_489_0 + var_489_8 and arg_486_1.time_ < var_489_0 + var_489_8 + arg_489_0 then
				arg_486_1.typewritter.percent = 1

				arg_486_1.typewritter:SetDirty()
				arg_486_1:ShowNextGo(true)
			end
		end

		arg_486_1.nodeConfigList_ = {}

		arg_486_1:InitPlayNodeList()
	end,
	Play426101115 = function(arg_490_0, arg_490_1)
		arg_490_1.time_ = 0
		arg_490_1.frameCnt_ = 0
		arg_490_1.state_ = "playing"
		arg_490_1.curTalkId_ = 426101115
		arg_490_1.duration_ = 5

		local var_490_0 = {
			zh = 5,
			ja = 4.066
		}
		local var_490_1 = manager.audio:GetLocalizationFlag()

		if var_490_0[var_490_1] ~= nil then
			arg_490_1.duration_ = var_490_0[var_490_1]
		end

		SetActive(arg_490_1.tipsGo_, false)

		function arg_490_1.onSingleLineFinish_()
			arg_490_1.onSingleLineUpdate_ = nil
			arg_490_1.onSingleLineFinish_ = nil
			arg_490_1.state_ = "waiting"
		end

		function arg_490_1.playNext_(arg_492_0)
			if arg_492_0 == 1 then
				arg_490_0:Play426101116(arg_490_1)
			end
		end

		function arg_490_1.onSingleLineUpdate_(arg_493_0)
			local var_493_0 = 0
			local var_493_1 = 0.4

			if var_493_0 < arg_490_1.time_ and arg_490_1.time_ <= var_493_0 + arg_493_0 then
				arg_490_1.talkMaxDuration = 0
				arg_490_1.dialogCg_.alpha = 1

				arg_490_1.dialog_:SetActive(true)
				SetActive(arg_490_1.leftNameGo_, true)

				local var_493_2 = arg_490_1:FormatText(StoryNameCfg[1488].name)

				arg_490_1.leftNameTxt_.text = var_493_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_490_1.leftNameTxt_.transform)

				arg_490_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_490_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_490_1:RecordName(arg_490_1.leftNameTxt_.text)
				SetActive(arg_490_1.iconTrs_.gameObject, false)
				arg_490_1.callingController_:SetSelectedState("normal")

				local var_493_3 = arg_490_1:GetWordFromCfg(426101115)
				local var_493_4 = arg_490_1:FormatText(var_493_3.content)

				arg_490_1.text_.text = var_493_4

				LuaForUtil.ClearLinePrefixSymbol(arg_490_1.text_)

				local var_493_5 = 16
				local var_493_6 = utf8.len(var_493_4)
				local var_493_7 = var_493_5 <= 0 and var_493_1 or var_493_1 * (var_493_6 / var_493_5)

				if var_493_7 > 0 and var_493_1 < var_493_7 then
					arg_490_1.talkMaxDuration = var_493_7

					if var_493_7 + var_493_0 > arg_490_1.duration_ then
						arg_490_1.duration_ = var_493_7 + var_493_0
					end
				end

				arg_490_1.text_.text = var_493_4
				arg_490_1.typewritter.percent = 0

				arg_490_1.typewritter:SetDirty()
				arg_490_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426101", "426101115", "story_v_out_426101.awb") ~= 0 then
					local var_493_8 = manager.audio:GetVoiceLength("story_v_out_426101", "426101115", "story_v_out_426101.awb") / 1000

					if var_493_8 + var_493_0 > arg_490_1.duration_ then
						arg_490_1.duration_ = var_493_8 + var_493_0
					end

					if var_493_3.prefab_name ~= "" and arg_490_1.actors_[var_493_3.prefab_name] ~= nil then
						local var_493_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_490_1.actors_[var_493_3.prefab_name].transform, "story_v_out_426101", "426101115", "story_v_out_426101.awb")

						arg_490_1:RecordAudio("426101115", var_493_9)
						arg_490_1:RecordAudio("426101115", var_493_9)
					else
						arg_490_1:AudioAction("play", "voice", "story_v_out_426101", "426101115", "story_v_out_426101.awb")
					end

					arg_490_1:RecordHistoryTalkVoice("story_v_out_426101", "426101115", "story_v_out_426101.awb")
				end

				arg_490_1:RecordContent(arg_490_1.text_.text)
			end

			local var_493_10 = math.max(var_493_1, arg_490_1.talkMaxDuration)

			if var_493_0 <= arg_490_1.time_ and arg_490_1.time_ < var_493_0 + var_493_10 then
				arg_490_1.typewritter.percent = (arg_490_1.time_ - var_493_0) / var_493_10

				arg_490_1.typewritter:SetDirty()
			end

			if arg_490_1.time_ >= var_493_0 + var_493_10 and arg_490_1.time_ < var_493_0 + var_493_10 + arg_493_0 then
				arg_490_1.typewritter.percent = 1

				arg_490_1.typewritter:SetDirty()
				arg_490_1:ShowNextGo(true)
			end
		end

		arg_490_1.nodeConfigList_ = {}

		arg_490_1:InitPlayNodeList()
	end,
	Play426101116 = function(arg_494_0, arg_494_1)
		arg_494_1.time_ = 0
		arg_494_1.frameCnt_ = 0
		arg_494_1.state_ = "playing"
		arg_494_1.curTalkId_ = 426101116
		arg_494_1.duration_ = 8.2

		local var_494_0 = {
			zh = 7.5,
			ja = 8.2
		}
		local var_494_1 = manager.audio:GetLocalizationFlag()

		if var_494_0[var_494_1] ~= nil then
			arg_494_1.duration_ = var_494_0[var_494_1]
		end

		SetActive(arg_494_1.tipsGo_, false)

		function arg_494_1.onSingleLineFinish_()
			arg_494_1.onSingleLineUpdate_ = nil
			arg_494_1.onSingleLineFinish_ = nil
			arg_494_1.state_ = "waiting"
		end

		function arg_494_1.playNext_(arg_496_0)
			if arg_496_0 == 1 then
				arg_494_0:Play426101117(arg_494_1)
			end
		end

		function arg_494_1.onSingleLineUpdate_(arg_497_0)
			local var_497_0 = 0
			local var_497_1 = 0.75

			if var_497_0 < arg_494_1.time_ and arg_494_1.time_ <= var_497_0 + arg_497_0 then
				arg_494_1.talkMaxDuration = 0
				arg_494_1.dialogCg_.alpha = 1

				arg_494_1.dialog_:SetActive(true)
				SetActive(arg_494_1.leftNameGo_, true)

				local var_497_2 = arg_494_1:FormatText(StoryNameCfg[1487].name)

				arg_494_1.leftNameTxt_.text = var_497_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_494_1.leftNameTxt_.transform)

				arg_494_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_494_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_494_1:RecordName(arg_494_1.leftNameTxt_.text)
				SetActive(arg_494_1.iconTrs_.gameObject, false)
				arg_494_1.callingController_:SetSelectedState("normal")

				local var_497_3 = arg_494_1:GetWordFromCfg(426101116)
				local var_497_4 = arg_494_1:FormatText(var_497_3.content)

				arg_494_1.text_.text = var_497_4

				LuaForUtil.ClearLinePrefixSymbol(arg_494_1.text_)

				local var_497_5 = 30
				local var_497_6 = utf8.len(var_497_4)
				local var_497_7 = var_497_5 <= 0 and var_497_1 or var_497_1 * (var_497_6 / var_497_5)

				if var_497_7 > 0 and var_497_1 < var_497_7 then
					arg_494_1.talkMaxDuration = var_497_7

					if var_497_7 + var_497_0 > arg_494_1.duration_ then
						arg_494_1.duration_ = var_497_7 + var_497_0
					end
				end

				arg_494_1.text_.text = var_497_4
				arg_494_1.typewritter.percent = 0

				arg_494_1.typewritter:SetDirty()
				arg_494_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426101", "426101116", "story_v_out_426101.awb") ~= 0 then
					local var_497_8 = manager.audio:GetVoiceLength("story_v_out_426101", "426101116", "story_v_out_426101.awb") / 1000

					if var_497_8 + var_497_0 > arg_494_1.duration_ then
						arg_494_1.duration_ = var_497_8 + var_497_0
					end

					if var_497_3.prefab_name ~= "" and arg_494_1.actors_[var_497_3.prefab_name] ~= nil then
						local var_497_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_494_1.actors_[var_497_3.prefab_name].transform, "story_v_out_426101", "426101116", "story_v_out_426101.awb")

						arg_494_1:RecordAudio("426101116", var_497_9)
						arg_494_1:RecordAudio("426101116", var_497_9)
					else
						arg_494_1:AudioAction("play", "voice", "story_v_out_426101", "426101116", "story_v_out_426101.awb")
					end

					arg_494_1:RecordHistoryTalkVoice("story_v_out_426101", "426101116", "story_v_out_426101.awb")
				end

				arg_494_1:RecordContent(arg_494_1.text_.text)
			end

			local var_497_10 = math.max(var_497_1, arg_494_1.talkMaxDuration)

			if var_497_0 <= arg_494_1.time_ and arg_494_1.time_ < var_497_0 + var_497_10 then
				arg_494_1.typewritter.percent = (arg_494_1.time_ - var_497_0) / var_497_10

				arg_494_1.typewritter:SetDirty()
			end

			if arg_494_1.time_ >= var_497_0 + var_497_10 and arg_494_1.time_ < var_497_0 + var_497_10 + arg_497_0 then
				arg_494_1.typewritter.percent = 1

				arg_494_1.typewritter:SetDirty()
				arg_494_1:ShowNextGo(true)
			end
		end

		arg_494_1.nodeConfigList_ = {}

		arg_494_1:InitPlayNodeList()
	end,
	Play426101117 = function(arg_498_0, arg_498_1)
		arg_498_1.time_ = 0
		arg_498_1.frameCnt_ = 0
		arg_498_1.state_ = "playing"
		arg_498_1.curTalkId_ = 426101117
		arg_498_1.duration_ = 5.3

		SetActive(arg_498_1.tipsGo_, false)

		function arg_498_1.onSingleLineFinish_()
			arg_498_1.onSingleLineUpdate_ = nil
			arg_498_1.onSingleLineFinish_ = nil
			arg_498_1.state_ = "waiting"
		end

		function arg_498_1.playNext_(arg_500_0)
			if arg_500_0 == 1 then
				arg_498_0:Play426101118(arg_498_1)
			end
		end

		function arg_498_1.onSingleLineUpdate_(arg_501_0)
			local var_501_0 = manager.ui.mainCamera.transform
			local var_501_1 = 0.275

			if var_501_1 < arg_498_1.time_ and arg_498_1.time_ <= var_501_1 + arg_501_0 then
				arg_498_1.var_.shakeOldPos = var_501_0.localPosition
			end

			local var_501_2 = 0.3

			if var_501_1 <= arg_498_1.time_ and arg_498_1.time_ < var_501_1 + var_501_2 then
				local var_501_3 = (arg_498_1.time_ - var_501_1) / 0.066
				local var_501_4, var_501_5 = math.modf(var_501_3)

				var_501_0.localPosition = Vector3.New(var_501_5 * 0.13, var_501_5 * 0.13, var_501_5 * 0.13) + arg_498_1.var_.shakeOldPos
			end

			if arg_498_1.time_ >= var_501_1 + var_501_2 and arg_498_1.time_ < var_501_1 + var_501_2 + arg_501_0 then
				var_501_0.localPosition = arg_498_1.var_.shakeOldPos
			end

			local var_501_6 = 0

			if var_501_6 < arg_498_1.time_ and arg_498_1.time_ <= var_501_6 + arg_501_0 then
				arg_498_1.allBtn_.enabled = false
			end

			local var_501_7 = 0.575

			if arg_498_1.time_ >= var_501_6 + var_501_7 and arg_498_1.time_ < var_501_6 + var_501_7 + arg_501_0 then
				arg_498_1.allBtn_.enabled = true
			end

			if arg_498_1.frameCnt_ <= 1 then
				arg_498_1.dialog_:SetActive(false)
			end

			local var_501_8 = 0.3
			local var_501_9 = 0.275

			if var_501_8 < arg_498_1.time_ and arg_498_1.time_ <= var_501_8 + arg_501_0 then
				arg_498_1.talkMaxDuration = 0

				arg_498_1.dialog_:SetActive(true)

				arg_498_1.dialogCg_.alpha = 0

				local var_501_10 = LeanTween.value(arg_498_1.dialog_, 0, 1, 0.3)

				var_501_10:setOnUpdate(LuaHelper.FloatAction(function(arg_502_0)
					arg_498_1.dialogCg_.alpha = arg_502_0
				end))
				var_501_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_498_1.dialog_)
					var_501_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_498_1.duration_ = arg_498_1.duration_ + 0.3

				SetActive(arg_498_1.leftNameGo_, true)

				local var_501_11 = arg_498_1:FormatText(StoryNameCfg[7].name)

				arg_498_1.leftNameTxt_.text = var_501_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_498_1.leftNameTxt_.transform)

				arg_498_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_498_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_498_1:RecordName(arg_498_1.leftNameTxt_.text)
				SetActive(arg_498_1.iconTrs_.gameObject, true)
				arg_498_1.iconController_:SetSelectedState("hero")

				arg_498_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_498_1.callingController_:SetSelectedState("normal")

				arg_498_1.keyicon_.color = Color.New(1, 1, 1)
				arg_498_1.icon_.color = Color.New(1, 1, 1)

				local var_501_12 = arg_498_1:GetWordFromCfg(426101117)
				local var_501_13 = arg_498_1:FormatText(var_501_12.content)

				arg_498_1.text_.text = var_501_13

				LuaForUtil.ClearLinePrefixSymbol(arg_498_1.text_)

				local var_501_14 = 11
				local var_501_15 = utf8.len(var_501_13)
				local var_501_16 = var_501_14 <= 0 and var_501_9 or var_501_9 * (var_501_15 / var_501_14)

				if var_501_16 > 0 and var_501_9 < var_501_16 then
					arg_498_1.talkMaxDuration = var_501_16
					var_501_8 = var_501_8 + 0.3

					if var_501_16 + var_501_8 > arg_498_1.duration_ then
						arg_498_1.duration_ = var_501_16 + var_501_8
					end
				end

				arg_498_1.text_.text = var_501_13
				arg_498_1.typewritter.percent = 0

				arg_498_1.typewritter:SetDirty()
				arg_498_1:ShowNextGo(false)
				arg_498_1:RecordContent(arg_498_1.text_.text)
			end

			local var_501_17 = var_501_8 + 0.3
			local var_501_18 = math.max(var_501_9, arg_498_1.talkMaxDuration)

			if var_501_17 <= arg_498_1.time_ and arg_498_1.time_ < var_501_17 + var_501_18 then
				arg_498_1.typewritter.percent = (arg_498_1.time_ - var_501_17) / var_501_18

				arg_498_1.typewritter:SetDirty()
			end

			if arg_498_1.time_ >= var_501_17 + var_501_18 and arg_498_1.time_ < var_501_17 + var_501_18 + arg_501_0 then
				arg_498_1.typewritter.percent = 1

				arg_498_1.typewritter:SetDirty()
				arg_498_1:ShowNextGo(true)
			end
		end

		arg_498_1.nodeConfigList_ = {}

		arg_498_1:InitPlayNodeList()
	end,
	Play426101118 = function(arg_504_0, arg_504_1)
		arg_504_1.time_ = 0
		arg_504_1.frameCnt_ = 0
		arg_504_1.state_ = "playing"
		arg_504_1.curTalkId_ = 426101118
		arg_504_1.duration_ = 5.83

		local var_504_0 = {
			zh = 4.333,
			ja = 5.833
		}
		local var_504_1 = manager.audio:GetLocalizationFlag()

		if var_504_0[var_504_1] ~= nil then
			arg_504_1.duration_ = var_504_0[var_504_1]
		end

		SetActive(arg_504_1.tipsGo_, false)

		function arg_504_1.onSingleLineFinish_()
			arg_504_1.onSingleLineUpdate_ = nil
			arg_504_1.onSingleLineFinish_ = nil
			arg_504_1.state_ = "waiting"
		end

		function arg_504_1.playNext_(arg_506_0)
			if arg_506_0 == 1 then
				arg_504_0:Play426101119(arg_504_1)
			end
		end

		function arg_504_1.onSingleLineUpdate_(arg_507_0)
			local var_507_0 = 0
			local var_507_1 = 0.425

			if var_507_0 < arg_504_1.time_ and arg_504_1.time_ <= var_507_0 + arg_507_0 then
				arg_504_1.talkMaxDuration = 0
				arg_504_1.dialogCg_.alpha = 1

				arg_504_1.dialog_:SetActive(true)
				SetActive(arg_504_1.leftNameGo_, true)

				local var_507_2 = arg_504_1:FormatText(StoryNameCfg[1487].name)

				arg_504_1.leftNameTxt_.text = var_507_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_504_1.leftNameTxt_.transform)

				arg_504_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_504_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_504_1:RecordName(arg_504_1.leftNameTxt_.text)
				SetActive(arg_504_1.iconTrs_.gameObject, false)
				arg_504_1.callingController_:SetSelectedState("normal")

				local var_507_3 = arg_504_1:GetWordFromCfg(426101118)
				local var_507_4 = arg_504_1:FormatText(var_507_3.content)

				arg_504_1.text_.text = var_507_4

				LuaForUtil.ClearLinePrefixSymbol(arg_504_1.text_)

				local var_507_5 = 17
				local var_507_6 = utf8.len(var_507_4)
				local var_507_7 = var_507_5 <= 0 and var_507_1 or var_507_1 * (var_507_6 / var_507_5)

				if var_507_7 > 0 and var_507_1 < var_507_7 then
					arg_504_1.talkMaxDuration = var_507_7

					if var_507_7 + var_507_0 > arg_504_1.duration_ then
						arg_504_1.duration_ = var_507_7 + var_507_0
					end
				end

				arg_504_1.text_.text = var_507_4
				arg_504_1.typewritter.percent = 0

				arg_504_1.typewritter:SetDirty()
				arg_504_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426101", "426101118", "story_v_out_426101.awb") ~= 0 then
					local var_507_8 = manager.audio:GetVoiceLength("story_v_out_426101", "426101118", "story_v_out_426101.awb") / 1000

					if var_507_8 + var_507_0 > arg_504_1.duration_ then
						arg_504_1.duration_ = var_507_8 + var_507_0
					end

					if var_507_3.prefab_name ~= "" and arg_504_1.actors_[var_507_3.prefab_name] ~= nil then
						local var_507_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_504_1.actors_[var_507_3.prefab_name].transform, "story_v_out_426101", "426101118", "story_v_out_426101.awb")

						arg_504_1:RecordAudio("426101118", var_507_9)
						arg_504_1:RecordAudio("426101118", var_507_9)
					else
						arg_504_1:AudioAction("play", "voice", "story_v_out_426101", "426101118", "story_v_out_426101.awb")
					end

					arg_504_1:RecordHistoryTalkVoice("story_v_out_426101", "426101118", "story_v_out_426101.awb")
				end

				arg_504_1:RecordContent(arg_504_1.text_.text)
			end

			local var_507_10 = math.max(var_507_1, arg_504_1.talkMaxDuration)

			if var_507_0 <= arg_504_1.time_ and arg_504_1.time_ < var_507_0 + var_507_10 then
				arg_504_1.typewritter.percent = (arg_504_1.time_ - var_507_0) / var_507_10

				arg_504_1.typewritter:SetDirty()
			end

			if arg_504_1.time_ >= var_507_0 + var_507_10 and arg_504_1.time_ < var_507_0 + var_507_10 + arg_507_0 then
				arg_504_1.typewritter.percent = 1

				arg_504_1.typewritter:SetDirty()
				arg_504_1:ShowNextGo(true)
			end
		end

		arg_504_1.nodeConfigList_ = {}

		arg_504_1:InitPlayNodeList()
	end,
	Play426101119 = function(arg_508_0, arg_508_1)
		arg_508_1.time_ = 0
		arg_508_1.frameCnt_ = 0
		arg_508_1.state_ = "playing"
		arg_508_1.curTalkId_ = 426101119
		arg_508_1.duration_ = 5

		SetActive(arg_508_1.tipsGo_, false)

		function arg_508_1.onSingleLineFinish_()
			arg_508_1.onSingleLineUpdate_ = nil
			arg_508_1.onSingleLineFinish_ = nil
			arg_508_1.state_ = "waiting"
		end

		function arg_508_1.playNext_(arg_510_0)
			if arg_510_0 == 1 then
				arg_508_0:Play426101120(arg_508_1)
			end
		end

		function arg_508_1.onSingleLineUpdate_(arg_511_0)
			local var_511_0 = 0
			local var_511_1 = 0.275

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

				local var_511_3 = arg_508_1:GetWordFromCfg(426101119)
				local var_511_4 = arg_508_1:FormatText(var_511_3.content)

				arg_508_1.text_.text = var_511_4

				LuaForUtil.ClearLinePrefixSymbol(arg_508_1.text_)

				local var_511_5 = 11
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
	Play426101120 = function(arg_512_0, arg_512_1)
		arg_512_1.time_ = 0
		arg_512_1.frameCnt_ = 0
		arg_512_1.state_ = "playing"
		arg_512_1.curTalkId_ = 426101120
		arg_512_1.duration_ = 9.47

		local var_512_0 = {
			zh = 6.566,
			ja = 9.466
		}
		local var_512_1 = manager.audio:GetLocalizationFlag()

		if var_512_0[var_512_1] ~= nil then
			arg_512_1.duration_ = var_512_0[var_512_1]
		end

		SetActive(arg_512_1.tipsGo_, false)

		function arg_512_1.onSingleLineFinish_()
			arg_512_1.onSingleLineUpdate_ = nil
			arg_512_1.onSingleLineFinish_ = nil
			arg_512_1.state_ = "waiting"
		end

		function arg_512_1.playNext_(arg_514_0)
			if arg_514_0 == 1 then
				arg_512_0:Play426101121(arg_512_1)
			end
		end

		function arg_512_1.onSingleLineUpdate_(arg_515_0)
			local var_515_0 = 0
			local var_515_1 = 0.675

			if var_515_0 < arg_512_1.time_ and arg_512_1.time_ <= var_515_0 + arg_515_0 then
				arg_512_1.talkMaxDuration = 0
				arg_512_1.dialogCg_.alpha = 1

				arg_512_1.dialog_:SetActive(true)
				SetActive(arg_512_1.leftNameGo_, true)

				local var_515_2 = arg_512_1:FormatText(StoryNameCfg[1488].name)

				arg_512_1.leftNameTxt_.text = var_515_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_512_1.leftNameTxt_.transform)

				arg_512_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_512_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_512_1:RecordName(arg_512_1.leftNameTxt_.text)
				SetActive(arg_512_1.iconTrs_.gameObject, false)
				arg_512_1.callingController_:SetSelectedState("normal")

				local var_515_3 = arg_512_1:GetWordFromCfg(426101120)
				local var_515_4 = arg_512_1:FormatText(var_515_3.content)

				arg_512_1.text_.text = var_515_4

				LuaForUtil.ClearLinePrefixSymbol(arg_512_1.text_)

				local var_515_5 = 27
				local var_515_6 = utf8.len(var_515_4)
				local var_515_7 = var_515_5 <= 0 and var_515_1 or var_515_1 * (var_515_6 / var_515_5)

				if var_515_7 > 0 and var_515_1 < var_515_7 then
					arg_512_1.talkMaxDuration = var_515_7

					if var_515_7 + var_515_0 > arg_512_1.duration_ then
						arg_512_1.duration_ = var_515_7 + var_515_0
					end
				end

				arg_512_1.text_.text = var_515_4
				arg_512_1.typewritter.percent = 0

				arg_512_1.typewritter:SetDirty()
				arg_512_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426101", "426101120", "story_v_out_426101.awb") ~= 0 then
					local var_515_8 = manager.audio:GetVoiceLength("story_v_out_426101", "426101120", "story_v_out_426101.awb") / 1000

					if var_515_8 + var_515_0 > arg_512_1.duration_ then
						arg_512_1.duration_ = var_515_8 + var_515_0
					end

					if var_515_3.prefab_name ~= "" and arg_512_1.actors_[var_515_3.prefab_name] ~= nil then
						local var_515_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_512_1.actors_[var_515_3.prefab_name].transform, "story_v_out_426101", "426101120", "story_v_out_426101.awb")

						arg_512_1:RecordAudio("426101120", var_515_9)
						arg_512_1:RecordAudio("426101120", var_515_9)
					else
						arg_512_1:AudioAction("play", "voice", "story_v_out_426101", "426101120", "story_v_out_426101.awb")
					end

					arg_512_1:RecordHistoryTalkVoice("story_v_out_426101", "426101120", "story_v_out_426101.awb")
				end

				arg_512_1:RecordContent(arg_512_1.text_.text)
			end

			local var_515_10 = math.max(var_515_1, arg_512_1.talkMaxDuration)

			if var_515_0 <= arg_512_1.time_ and arg_512_1.time_ < var_515_0 + var_515_10 then
				arg_512_1.typewritter.percent = (arg_512_1.time_ - var_515_0) / var_515_10

				arg_512_1.typewritter:SetDirty()
			end

			if arg_512_1.time_ >= var_515_0 + var_515_10 and arg_512_1.time_ < var_515_0 + var_515_10 + arg_515_0 then
				arg_512_1.typewritter.percent = 1

				arg_512_1.typewritter:SetDirty()
				arg_512_1:ShowNextGo(true)
			end
		end

		arg_512_1.nodeConfigList_ = {}

		arg_512_1:InitPlayNodeList()
	end,
	Play426101121 = function(arg_516_0, arg_516_1)
		arg_516_1.time_ = 0
		arg_516_1.frameCnt_ = 0
		arg_516_1.state_ = "playing"
		arg_516_1.curTalkId_ = 426101121
		arg_516_1.duration_ = 5

		SetActive(arg_516_1.tipsGo_, false)

		function arg_516_1.onSingleLineFinish_()
			arg_516_1.onSingleLineUpdate_ = nil
			arg_516_1.onSingleLineFinish_ = nil
			arg_516_1.state_ = "waiting"
		end

		function arg_516_1.playNext_(arg_518_0)
			if arg_518_0 == 1 then
				arg_516_0:Play426101122(arg_516_1)
			end
		end

		function arg_516_1.onSingleLineUpdate_(arg_519_0)
			local var_519_0 = 0
			local var_519_1 = 0.125

			if var_519_0 < arg_516_1.time_ and arg_516_1.time_ <= var_519_0 + arg_519_0 then
				arg_516_1.talkMaxDuration = 0
				arg_516_1.dialogCg_.alpha = 1

				arg_516_1.dialog_:SetActive(true)
				SetActive(arg_516_1.leftNameGo_, true)

				local var_519_2 = arg_516_1:FormatText(StoryNameCfg[7].name)

				arg_516_1.leftNameTxt_.text = var_519_2

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

				local var_519_3 = arg_516_1:GetWordFromCfg(426101121)
				local var_519_4 = arg_516_1:FormatText(var_519_3.content)

				arg_516_1.text_.text = var_519_4

				LuaForUtil.ClearLinePrefixSymbol(arg_516_1.text_)

				local var_519_5 = 5
				local var_519_6 = utf8.len(var_519_4)
				local var_519_7 = var_519_5 <= 0 and var_519_1 or var_519_1 * (var_519_6 / var_519_5)

				if var_519_7 > 0 and var_519_1 < var_519_7 then
					arg_516_1.talkMaxDuration = var_519_7

					if var_519_7 + var_519_0 > arg_516_1.duration_ then
						arg_516_1.duration_ = var_519_7 + var_519_0
					end
				end

				arg_516_1.text_.text = var_519_4
				arg_516_1.typewritter.percent = 0

				arg_516_1.typewritter:SetDirty()
				arg_516_1:ShowNextGo(false)
				arg_516_1:RecordContent(arg_516_1.text_.text)
			end

			local var_519_8 = math.max(var_519_1, arg_516_1.talkMaxDuration)

			if var_519_0 <= arg_516_1.time_ and arg_516_1.time_ < var_519_0 + var_519_8 then
				arg_516_1.typewritter.percent = (arg_516_1.time_ - var_519_0) / var_519_8

				arg_516_1.typewritter:SetDirty()
			end

			if arg_516_1.time_ >= var_519_0 + var_519_8 and arg_516_1.time_ < var_519_0 + var_519_8 + arg_519_0 then
				arg_516_1.typewritter.percent = 1

				arg_516_1.typewritter:SetDirty()
				arg_516_1:ShowNextGo(true)
			end
		end

		arg_516_1.nodeConfigList_ = {}

		arg_516_1:InitPlayNodeList()
	end,
	Play426101122 = function(arg_520_0, arg_520_1)
		arg_520_1.time_ = 0
		arg_520_1.frameCnt_ = 0
		arg_520_1.state_ = "playing"
		arg_520_1.curTalkId_ = 426101122
		arg_520_1.duration_ = 8.17

		local var_520_0 = {
			zh = 6.033,
			ja = 8.166
		}
		local var_520_1 = manager.audio:GetLocalizationFlag()

		if var_520_0[var_520_1] ~= nil then
			arg_520_1.duration_ = var_520_0[var_520_1]
		end

		SetActive(arg_520_1.tipsGo_, false)

		function arg_520_1.onSingleLineFinish_()
			arg_520_1.onSingleLineUpdate_ = nil
			arg_520_1.onSingleLineFinish_ = nil
			arg_520_1.state_ = "waiting"
		end

		function arg_520_1.playNext_(arg_522_0)
			if arg_522_0 == 1 then
				arg_520_0:Play426101123(arg_520_1)
			end
		end

		function arg_520_1.onSingleLineUpdate_(arg_523_0)
			local var_523_0 = 0
			local var_523_1 = 0.7

			if var_523_0 < arg_520_1.time_ and arg_520_1.time_ <= var_523_0 + arg_523_0 then
				arg_520_1.talkMaxDuration = 0
				arg_520_1.dialogCg_.alpha = 1

				arg_520_1.dialog_:SetActive(true)
				SetActive(arg_520_1.leftNameGo_, true)

				local var_523_2 = arg_520_1:FormatText(StoryNameCfg[1488].name)

				arg_520_1.leftNameTxt_.text = var_523_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_520_1.leftNameTxt_.transform)

				arg_520_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_520_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_520_1:RecordName(arg_520_1.leftNameTxt_.text)
				SetActive(arg_520_1.iconTrs_.gameObject, false)
				arg_520_1.callingController_:SetSelectedState("normal")

				local var_523_3 = arg_520_1:GetWordFromCfg(426101122)
				local var_523_4 = arg_520_1:FormatText(var_523_3.content)

				arg_520_1.text_.text = var_523_4

				LuaForUtil.ClearLinePrefixSymbol(arg_520_1.text_)

				local var_523_5 = 28
				local var_523_6 = utf8.len(var_523_4)
				local var_523_7 = var_523_5 <= 0 and var_523_1 or var_523_1 * (var_523_6 / var_523_5)

				if var_523_7 > 0 and var_523_1 < var_523_7 then
					arg_520_1.talkMaxDuration = var_523_7

					if var_523_7 + var_523_0 > arg_520_1.duration_ then
						arg_520_1.duration_ = var_523_7 + var_523_0
					end
				end

				arg_520_1.text_.text = var_523_4
				arg_520_1.typewritter.percent = 0

				arg_520_1.typewritter:SetDirty()
				arg_520_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426101", "426101122", "story_v_out_426101.awb") ~= 0 then
					local var_523_8 = manager.audio:GetVoiceLength("story_v_out_426101", "426101122", "story_v_out_426101.awb") / 1000

					if var_523_8 + var_523_0 > arg_520_1.duration_ then
						arg_520_1.duration_ = var_523_8 + var_523_0
					end

					if var_523_3.prefab_name ~= "" and arg_520_1.actors_[var_523_3.prefab_name] ~= nil then
						local var_523_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_520_1.actors_[var_523_3.prefab_name].transform, "story_v_out_426101", "426101122", "story_v_out_426101.awb")

						arg_520_1:RecordAudio("426101122", var_523_9)
						arg_520_1:RecordAudio("426101122", var_523_9)
					else
						arg_520_1:AudioAction("play", "voice", "story_v_out_426101", "426101122", "story_v_out_426101.awb")
					end

					arg_520_1:RecordHistoryTalkVoice("story_v_out_426101", "426101122", "story_v_out_426101.awb")
				end

				arg_520_1:RecordContent(arg_520_1.text_.text)
			end

			local var_523_10 = math.max(var_523_1, arg_520_1.talkMaxDuration)

			if var_523_0 <= arg_520_1.time_ and arg_520_1.time_ < var_523_0 + var_523_10 then
				arg_520_1.typewritter.percent = (arg_520_1.time_ - var_523_0) / var_523_10

				arg_520_1.typewritter:SetDirty()
			end

			if arg_520_1.time_ >= var_523_0 + var_523_10 and arg_520_1.time_ < var_523_0 + var_523_10 + arg_523_0 then
				arg_520_1.typewritter.percent = 1

				arg_520_1.typewritter:SetDirty()
				arg_520_1:ShowNextGo(true)
			end
		end

		arg_520_1.nodeConfigList_ = {}

		arg_520_1:InitPlayNodeList()
	end,
	Play426101123 = function(arg_524_0, arg_524_1)
		arg_524_1.time_ = 0
		arg_524_1.frameCnt_ = 0
		arg_524_1.state_ = "playing"
		arg_524_1.curTalkId_ = 426101123
		arg_524_1.duration_ = 5

		SetActive(arg_524_1.tipsGo_, false)

		function arg_524_1.onSingleLineFinish_()
			arg_524_1.onSingleLineUpdate_ = nil
			arg_524_1.onSingleLineFinish_ = nil
			arg_524_1.state_ = "waiting"
		end

		function arg_524_1.playNext_(arg_526_0)
			if arg_526_0 == 1 then
				arg_524_0:Play426101124(arg_524_1)
			end
		end

		function arg_524_1.onSingleLineUpdate_(arg_527_0)
			local var_527_0 = 0
			local var_527_1 = 0.325

			if var_527_0 < arg_524_1.time_ and arg_524_1.time_ <= var_527_0 + arg_527_0 then
				arg_524_1.talkMaxDuration = 0
				arg_524_1.dialogCg_.alpha = 1

				arg_524_1.dialog_:SetActive(true)
				SetActive(arg_524_1.leftNameGo_, true)

				local var_527_2 = arg_524_1:FormatText(StoryNameCfg[7].name)

				arg_524_1.leftNameTxt_.text = var_527_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_524_1.leftNameTxt_.transform)

				arg_524_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_524_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_524_1:RecordName(arg_524_1.leftNameTxt_.text)
				SetActive(arg_524_1.iconTrs_.gameObject, true)
				arg_524_1.iconController_:SetSelectedState("hero")

				arg_524_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_524_1.callingController_:SetSelectedState("normal")

				arg_524_1.keyicon_.color = Color.New(1, 1, 1)
				arg_524_1.icon_.color = Color.New(1, 1, 1)

				local var_527_3 = arg_524_1:GetWordFromCfg(426101123)
				local var_527_4 = arg_524_1:FormatText(var_527_3.content)

				arg_524_1.text_.text = var_527_4

				LuaForUtil.ClearLinePrefixSymbol(arg_524_1.text_)

				local var_527_5 = 13
				local var_527_6 = utf8.len(var_527_4)
				local var_527_7 = var_527_5 <= 0 and var_527_1 or var_527_1 * (var_527_6 / var_527_5)

				if var_527_7 > 0 and var_527_1 < var_527_7 then
					arg_524_1.talkMaxDuration = var_527_7

					if var_527_7 + var_527_0 > arg_524_1.duration_ then
						arg_524_1.duration_ = var_527_7 + var_527_0
					end
				end

				arg_524_1.text_.text = var_527_4
				arg_524_1.typewritter.percent = 0

				arg_524_1.typewritter:SetDirty()
				arg_524_1:ShowNextGo(false)
				arg_524_1:RecordContent(arg_524_1.text_.text)
			end

			local var_527_8 = math.max(var_527_1, arg_524_1.talkMaxDuration)

			if var_527_0 <= arg_524_1.time_ and arg_524_1.time_ < var_527_0 + var_527_8 then
				arg_524_1.typewritter.percent = (arg_524_1.time_ - var_527_0) / var_527_8

				arg_524_1.typewritter:SetDirty()
			end

			if arg_524_1.time_ >= var_527_0 + var_527_8 and arg_524_1.time_ < var_527_0 + var_527_8 + arg_527_0 then
				arg_524_1.typewritter.percent = 1

				arg_524_1.typewritter:SetDirty()
				arg_524_1:ShowNextGo(true)
			end
		end

		arg_524_1.nodeConfigList_ = {}

		arg_524_1:InitPlayNodeList()
	end,
	Play426101124 = function(arg_528_0, arg_528_1)
		arg_528_1.time_ = 0
		arg_528_1.frameCnt_ = 0
		arg_528_1.state_ = "playing"
		arg_528_1.curTalkId_ = 426101124
		arg_528_1.duration_ = 5

		SetActive(arg_528_1.tipsGo_, false)

		function arg_528_1.onSingleLineFinish_()
			arg_528_1.onSingleLineUpdate_ = nil
			arg_528_1.onSingleLineFinish_ = nil
			arg_528_1.state_ = "waiting"
		end

		function arg_528_1.playNext_(arg_530_0)
			if arg_530_0 == 1 then
				arg_528_0:Play426101125(arg_528_1)
			end
		end

		function arg_528_1.onSingleLineUpdate_(arg_531_0)
			local var_531_0 = 0
			local var_531_1 = 0.65

			if var_531_0 < arg_528_1.time_ and arg_528_1.time_ <= var_531_0 + arg_531_0 then
				arg_528_1.talkMaxDuration = 0
				arg_528_1.dialogCg_.alpha = 1

				arg_528_1.dialog_:SetActive(true)
				SetActive(arg_528_1.leftNameGo_, true)

				local var_531_2 = arg_528_1:FormatText(StoryNameCfg[7].name)

				arg_528_1.leftNameTxt_.text = var_531_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_528_1.leftNameTxt_.transform)

				arg_528_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_528_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_528_1:RecordName(arg_528_1.leftNameTxt_.text)
				SetActive(arg_528_1.iconTrs_.gameObject, true)
				arg_528_1.iconController_:SetSelectedState("hero")

				arg_528_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_528_1.callingController_:SetSelectedState("normal")

				arg_528_1.keyicon_.color = Color.New(1, 1, 1)
				arg_528_1.icon_.color = Color.New(1, 1, 1)

				local var_531_3 = arg_528_1:GetWordFromCfg(426101124)
				local var_531_4 = arg_528_1:FormatText(var_531_3.content)

				arg_528_1.text_.text = var_531_4

				LuaForUtil.ClearLinePrefixSymbol(arg_528_1.text_)

				local var_531_5 = 26
				local var_531_6 = utf8.len(var_531_4)
				local var_531_7 = var_531_5 <= 0 and var_531_1 or var_531_1 * (var_531_6 / var_531_5)

				if var_531_7 > 0 and var_531_1 < var_531_7 then
					arg_528_1.talkMaxDuration = var_531_7

					if var_531_7 + var_531_0 > arg_528_1.duration_ then
						arg_528_1.duration_ = var_531_7 + var_531_0
					end
				end

				arg_528_1.text_.text = var_531_4
				arg_528_1.typewritter.percent = 0

				arg_528_1.typewritter:SetDirty()
				arg_528_1:ShowNextGo(false)
				arg_528_1:RecordContent(arg_528_1.text_.text)
			end

			local var_531_8 = math.max(var_531_1, arg_528_1.talkMaxDuration)

			if var_531_0 <= arg_528_1.time_ and arg_528_1.time_ < var_531_0 + var_531_8 then
				arg_528_1.typewritter.percent = (arg_528_1.time_ - var_531_0) / var_531_8

				arg_528_1.typewritter:SetDirty()
			end

			if arg_528_1.time_ >= var_531_0 + var_531_8 and arg_528_1.time_ < var_531_0 + var_531_8 + arg_531_0 then
				arg_528_1.typewritter.percent = 1

				arg_528_1.typewritter:SetDirty()
				arg_528_1:ShowNextGo(true)
			end
		end

		arg_528_1.nodeConfigList_ = {}

		arg_528_1:InitPlayNodeList()
	end,
	Play426101125 = function(arg_532_0, arg_532_1)
		arg_532_1.time_ = 0
		arg_532_1.frameCnt_ = 0
		arg_532_1.state_ = "playing"
		arg_532_1.curTalkId_ = 426101125
		arg_532_1.duration_ = 5.48

		SetActive(arg_532_1.tipsGo_, false)

		function arg_532_1.onSingleLineFinish_()
			arg_532_1.onSingleLineUpdate_ = nil
			arg_532_1.onSingleLineFinish_ = nil
			arg_532_1.state_ = "waiting"
		end

		function arg_532_1.playNext_(arg_534_0)
			if arg_534_0 == 1 then
				arg_532_0:Play426101126(arg_532_1)
			end
		end

		function arg_532_1.onSingleLineUpdate_(arg_535_0)
			local var_535_0 = 0.4
			local var_535_1 = 1

			if var_535_0 < arg_532_1.time_ and arg_532_1.time_ <= var_535_0 + arg_535_0 then
				local var_535_2 = "play"
				local var_535_3 = "effect"

				arg_532_1:AudioAction(var_535_2, var_535_3, "se_story_140", "se_story_140_hug02", "")
			end

			local var_535_4 = arg_532_1.bgs_.SS2603.transform
			local var_535_5 = 0

			if var_535_5 < arg_532_1.time_ and arg_532_1.time_ <= var_535_5 + arg_535_0 then
				arg_532_1.var_.moveOldPosSS2603 = var_535_4.localPosition
			end

			local var_535_6 = 2

			if var_535_5 <= arg_532_1.time_ and arg_532_1.time_ < var_535_5 + var_535_6 then
				local var_535_7 = (arg_532_1.time_ - var_535_5) / var_535_6
				local var_535_8 = Vector3.New(-0.5, 1.5, 8)

				var_535_4.localPosition = Vector3.Lerp(arg_532_1.var_.moveOldPosSS2603, var_535_8, var_535_7)
			end

			if arg_532_1.time_ >= var_535_5 + var_535_6 and arg_532_1.time_ < var_535_5 + var_535_6 + arg_535_0 then
				var_535_4.localPosition = Vector3.New(-0.5, 1.5, 8)
			end

			local var_535_9 = 0

			if var_535_9 < arg_532_1.time_ and arg_532_1.time_ <= var_535_9 + arg_535_0 then
				arg_532_1.allBtn_.enabled = false
			end

			local var_535_10 = 2

			if arg_532_1.time_ >= var_535_9 + var_535_10 and arg_532_1.time_ < var_535_9 + var_535_10 + arg_535_0 then
				arg_532_1.allBtn_.enabled = true
			end

			if arg_532_1.frameCnt_ <= 1 then
				arg_532_1.dialog_:SetActive(false)
			end

			local var_535_11 = 0.475
			local var_535_12 = 0.525

			if var_535_11 < arg_532_1.time_ and arg_532_1.time_ <= var_535_11 + arg_535_0 then
				arg_532_1.talkMaxDuration = 0

				arg_532_1.dialog_:SetActive(true)

				arg_532_1.dialogCg_.alpha = 0

				local var_535_13 = LeanTween.value(arg_532_1.dialog_, 0, 1, 0.3)

				var_535_13:setOnUpdate(LuaHelper.FloatAction(function(arg_536_0)
					arg_532_1.dialogCg_.alpha = arg_536_0
				end))
				var_535_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_532_1.dialog_)
					var_535_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_532_1.duration_ = arg_532_1.duration_ + 0.3

				SetActive(arg_532_1.leftNameGo_, false)

				arg_532_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_532_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_532_1:RecordName(arg_532_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_532_1.iconTrs_.gameObject, false)
				arg_532_1.callingController_:SetSelectedState("normal")

				local var_535_14 = arg_532_1:GetWordFromCfg(426101125)
				local var_535_15 = arg_532_1:FormatText(var_535_14.content)

				arg_532_1.text_.text = var_535_15

				LuaForUtil.ClearLinePrefixSymbol(arg_532_1.text_)

				local var_535_16 = 21
				local var_535_17 = utf8.len(var_535_15)
				local var_535_18 = var_535_16 <= 0 and var_535_12 or var_535_12 * (var_535_17 / var_535_16)

				if var_535_18 > 0 and var_535_12 < var_535_18 then
					arg_532_1.talkMaxDuration = var_535_18
					var_535_11 = var_535_11 + 0.3

					if var_535_18 + var_535_11 > arg_532_1.duration_ then
						arg_532_1.duration_ = var_535_18 + var_535_11
					end
				end

				arg_532_1.text_.text = var_535_15
				arg_532_1.typewritter.percent = 0

				arg_532_1.typewritter:SetDirty()
				arg_532_1:ShowNextGo(false)
				arg_532_1:RecordContent(arg_532_1.text_.text)
			end

			local var_535_19 = var_535_11 + 0.3
			local var_535_20 = math.max(var_535_12, arg_532_1.talkMaxDuration)

			if var_535_19 <= arg_532_1.time_ and arg_532_1.time_ < var_535_19 + var_535_20 then
				arg_532_1.typewritter.percent = (arg_532_1.time_ - var_535_19) / var_535_20

				arg_532_1.typewritter:SetDirty()
			end

			if arg_532_1.time_ >= var_535_19 + var_535_20 and arg_532_1.time_ < var_535_19 + var_535_20 + arg_535_0 then
				arg_532_1.typewritter.percent = 1

				arg_532_1.typewritter:SetDirty()
				arg_532_1:ShowNextGo(true)
			end
		end

		arg_532_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "SS2603",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 2,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(-0.5, 1, 6.5),
					endPos = Vector3.New(-0.5, 1.5, 8),
					easeType = LeanTweenType.easeInOutExpo
				}
			}
		}

		arg_532_1:InitPlayNodeList()
	end,
	Play426101126 = function(arg_538_0, arg_538_1)
		arg_538_1.time_ = 0
		arg_538_1.frameCnt_ = 0
		arg_538_1.state_ = "playing"
		arg_538_1.curTalkId_ = 426101126
		arg_538_1.duration_ = 5

		SetActive(arg_538_1.tipsGo_, false)

		function arg_538_1.onSingleLineFinish_()
			arg_538_1.onSingleLineUpdate_ = nil
			arg_538_1.onSingleLineFinish_ = nil
			arg_538_1.state_ = "waiting"
		end

		function arg_538_1.playNext_(arg_540_0)
			if arg_540_0 == 1 then
				arg_538_0:Play426101127(arg_538_1)
			end
		end

		function arg_538_1.onSingleLineUpdate_(arg_541_0)
			local var_541_0 = 0
			local var_541_1 = 0.2

			if var_541_0 < arg_538_1.time_ and arg_538_1.time_ <= var_541_0 + arg_541_0 then
				arg_538_1.talkMaxDuration = 0
				arg_538_1.dialogCg_.alpha = 1

				arg_538_1.dialog_:SetActive(true)
				SetActive(arg_538_1.leftNameGo_, true)

				local var_541_2 = arg_538_1:FormatText(StoryNameCfg[7].name)

				arg_538_1.leftNameTxt_.text = var_541_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_538_1.leftNameTxt_.transform)

				arg_538_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_538_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_538_1:RecordName(arg_538_1.leftNameTxt_.text)
				SetActive(arg_538_1.iconTrs_.gameObject, true)
				arg_538_1.iconController_:SetSelectedState("hero")

				arg_538_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_538_1.callingController_:SetSelectedState("normal")

				arg_538_1.keyicon_.color = Color.New(1, 1, 1)
				arg_538_1.icon_.color = Color.New(1, 1, 1)

				local var_541_3 = arg_538_1:GetWordFromCfg(426101126)
				local var_541_4 = arg_538_1:FormatText(var_541_3.content)

				arg_538_1.text_.text = var_541_4

				LuaForUtil.ClearLinePrefixSymbol(arg_538_1.text_)

				local var_541_5 = 8
				local var_541_6 = utf8.len(var_541_4)
				local var_541_7 = var_541_5 <= 0 and var_541_1 or var_541_1 * (var_541_6 / var_541_5)

				if var_541_7 > 0 and var_541_1 < var_541_7 then
					arg_538_1.talkMaxDuration = var_541_7

					if var_541_7 + var_541_0 > arg_538_1.duration_ then
						arg_538_1.duration_ = var_541_7 + var_541_0
					end
				end

				arg_538_1.text_.text = var_541_4
				arg_538_1.typewritter.percent = 0

				arg_538_1.typewritter:SetDirty()
				arg_538_1:ShowNextGo(false)
				arg_538_1:RecordContent(arg_538_1.text_.text)
			end

			local var_541_8 = math.max(var_541_1, arg_538_1.talkMaxDuration)

			if var_541_0 <= arg_538_1.time_ and arg_538_1.time_ < var_541_0 + var_541_8 then
				arg_538_1.typewritter.percent = (arg_538_1.time_ - var_541_0) / var_541_8

				arg_538_1.typewritter:SetDirty()
			end

			if arg_538_1.time_ >= var_541_0 + var_541_8 and arg_538_1.time_ < var_541_0 + var_541_8 + arg_541_0 then
				arg_538_1.typewritter.percent = 1

				arg_538_1.typewritter:SetDirty()
				arg_538_1:ShowNextGo(true)
			end
		end

		arg_538_1.nodeConfigList_ = {}

		arg_538_1:InitPlayNodeList()
	end,
	Play426101127 = function(arg_542_0, arg_542_1)
		arg_542_1.time_ = 0
		arg_542_1.frameCnt_ = 0
		arg_542_1.state_ = "playing"
		arg_542_1.curTalkId_ = 426101127
		arg_542_1.duration_ = 12.1

		local var_542_0 = {
			zh = 11.033,
			ja = 12.1
		}
		local var_542_1 = manager.audio:GetLocalizationFlag()

		if var_542_0[var_542_1] ~= nil then
			arg_542_1.duration_ = var_542_0[var_542_1]
		end

		SetActive(arg_542_1.tipsGo_, false)

		function arg_542_1.onSingleLineFinish_()
			arg_542_1.onSingleLineUpdate_ = nil
			arg_542_1.onSingleLineFinish_ = nil
			arg_542_1.state_ = "waiting"
		end

		function arg_542_1.playNext_(arg_544_0)
			if arg_544_0 == 1 then
				arg_542_0:Play426101128(arg_542_1)
			end
		end

		function arg_542_1.onSingleLineUpdate_(arg_545_0)
			local var_545_0 = 0
			local var_545_1 = 0.925

			if var_545_0 < arg_542_1.time_ and arg_542_1.time_ <= var_545_0 + arg_545_0 then
				arg_542_1.talkMaxDuration = 0
				arg_542_1.dialogCg_.alpha = 1

				arg_542_1.dialog_:SetActive(true)
				SetActive(arg_542_1.leftNameGo_, true)

				local var_545_2 = arg_542_1:FormatText(StoryNameCfg[1487].name)

				arg_542_1.leftNameTxt_.text = var_545_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_542_1.leftNameTxt_.transform)

				arg_542_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_542_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_542_1:RecordName(arg_542_1.leftNameTxt_.text)
				SetActive(arg_542_1.iconTrs_.gameObject, false)
				arg_542_1.callingController_:SetSelectedState("normal")

				local var_545_3 = arg_542_1:GetWordFromCfg(426101127)
				local var_545_4 = arg_542_1:FormatText(var_545_3.content)

				arg_542_1.text_.text = var_545_4

				LuaForUtil.ClearLinePrefixSymbol(arg_542_1.text_)

				local var_545_5 = 37
				local var_545_6 = utf8.len(var_545_4)
				local var_545_7 = var_545_5 <= 0 and var_545_1 or var_545_1 * (var_545_6 / var_545_5)

				if var_545_7 > 0 and var_545_1 < var_545_7 then
					arg_542_1.talkMaxDuration = var_545_7

					if var_545_7 + var_545_0 > arg_542_1.duration_ then
						arg_542_1.duration_ = var_545_7 + var_545_0
					end
				end

				arg_542_1.text_.text = var_545_4
				arg_542_1.typewritter.percent = 0

				arg_542_1.typewritter:SetDirty()
				arg_542_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426101", "426101127", "story_v_out_426101.awb") ~= 0 then
					local var_545_8 = manager.audio:GetVoiceLength("story_v_out_426101", "426101127", "story_v_out_426101.awb") / 1000

					if var_545_8 + var_545_0 > arg_542_1.duration_ then
						arg_542_1.duration_ = var_545_8 + var_545_0
					end

					if var_545_3.prefab_name ~= "" and arg_542_1.actors_[var_545_3.prefab_name] ~= nil then
						local var_545_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_542_1.actors_[var_545_3.prefab_name].transform, "story_v_out_426101", "426101127", "story_v_out_426101.awb")

						arg_542_1:RecordAudio("426101127", var_545_9)
						arg_542_1:RecordAudio("426101127", var_545_9)
					else
						arg_542_1:AudioAction("play", "voice", "story_v_out_426101", "426101127", "story_v_out_426101.awb")
					end

					arg_542_1:RecordHistoryTalkVoice("story_v_out_426101", "426101127", "story_v_out_426101.awb")
				end

				arg_542_1:RecordContent(arg_542_1.text_.text)
			end

			local var_545_10 = math.max(var_545_1, arg_542_1.talkMaxDuration)

			if var_545_0 <= arg_542_1.time_ and arg_542_1.time_ < var_545_0 + var_545_10 then
				arg_542_1.typewritter.percent = (arg_542_1.time_ - var_545_0) / var_545_10

				arg_542_1.typewritter:SetDirty()
			end

			if arg_542_1.time_ >= var_545_0 + var_545_10 and arg_542_1.time_ < var_545_0 + var_545_10 + arg_545_0 then
				arg_542_1.typewritter.percent = 1

				arg_542_1.typewritter:SetDirty()
				arg_542_1:ShowNextGo(true)
			end
		end

		arg_542_1.nodeConfigList_ = {}

		arg_542_1:InitPlayNodeList()
	end,
	Play426101128 = function(arg_546_0, arg_546_1)
		arg_546_1.time_ = 0
		arg_546_1.frameCnt_ = 0
		arg_546_1.state_ = "playing"
		arg_546_1.curTalkId_ = 426101128
		arg_546_1.duration_ = 7.07

		local var_546_0 = {
			zh = 7.066,
			ja = 5.133
		}
		local var_546_1 = manager.audio:GetLocalizationFlag()

		if var_546_0[var_546_1] ~= nil then
			arg_546_1.duration_ = var_546_0[var_546_1]
		end

		SetActive(arg_546_1.tipsGo_, false)

		function arg_546_1.onSingleLineFinish_()
			arg_546_1.onSingleLineUpdate_ = nil
			arg_546_1.onSingleLineFinish_ = nil
			arg_546_1.state_ = "waiting"
		end

		function arg_546_1.playNext_(arg_548_0)
			if arg_548_0 == 1 then
				arg_546_0:Play426101129(arg_546_1)
			end
		end

		function arg_546_1.onSingleLineUpdate_(arg_549_0)
			local var_549_0 = 0
			local var_549_1 = 0.775

			if var_549_0 < arg_546_1.time_ and arg_546_1.time_ <= var_549_0 + arg_549_0 then
				arg_546_1.talkMaxDuration = 0
				arg_546_1.dialogCg_.alpha = 1

				arg_546_1.dialog_:SetActive(true)
				SetActive(arg_546_1.leftNameGo_, true)

				local var_549_2 = arg_546_1:FormatText(StoryNameCfg[1488].name)

				arg_546_1.leftNameTxt_.text = var_549_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_546_1.leftNameTxt_.transform)

				arg_546_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_546_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_546_1:RecordName(arg_546_1.leftNameTxt_.text)
				SetActive(arg_546_1.iconTrs_.gameObject, false)
				arg_546_1.callingController_:SetSelectedState("normal")

				local var_549_3 = arg_546_1:GetWordFromCfg(426101128)
				local var_549_4 = arg_546_1:FormatText(var_549_3.content)

				arg_546_1.text_.text = var_549_4

				LuaForUtil.ClearLinePrefixSymbol(arg_546_1.text_)

				local var_549_5 = 31
				local var_549_6 = utf8.len(var_549_4)
				local var_549_7 = var_549_5 <= 0 and var_549_1 or var_549_1 * (var_549_6 / var_549_5)

				if var_549_7 > 0 and var_549_1 < var_549_7 then
					arg_546_1.talkMaxDuration = var_549_7

					if var_549_7 + var_549_0 > arg_546_1.duration_ then
						arg_546_1.duration_ = var_549_7 + var_549_0
					end
				end

				arg_546_1.text_.text = var_549_4
				arg_546_1.typewritter.percent = 0

				arg_546_1.typewritter:SetDirty()
				arg_546_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426101", "426101128", "story_v_out_426101.awb") ~= 0 then
					local var_549_8 = manager.audio:GetVoiceLength("story_v_out_426101", "426101128", "story_v_out_426101.awb") / 1000

					if var_549_8 + var_549_0 > arg_546_1.duration_ then
						arg_546_1.duration_ = var_549_8 + var_549_0
					end

					if var_549_3.prefab_name ~= "" and arg_546_1.actors_[var_549_3.prefab_name] ~= nil then
						local var_549_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_546_1.actors_[var_549_3.prefab_name].transform, "story_v_out_426101", "426101128", "story_v_out_426101.awb")

						arg_546_1:RecordAudio("426101128", var_549_9)
						arg_546_1:RecordAudio("426101128", var_549_9)
					else
						arg_546_1:AudioAction("play", "voice", "story_v_out_426101", "426101128", "story_v_out_426101.awb")
					end

					arg_546_1:RecordHistoryTalkVoice("story_v_out_426101", "426101128", "story_v_out_426101.awb")
				end

				arg_546_1:RecordContent(arg_546_1.text_.text)
			end

			local var_549_10 = math.max(var_549_1, arg_546_1.talkMaxDuration)

			if var_549_0 <= arg_546_1.time_ and arg_546_1.time_ < var_549_0 + var_549_10 then
				arg_546_1.typewritter.percent = (arg_546_1.time_ - var_549_0) / var_549_10

				arg_546_1.typewritter:SetDirty()
			end

			if arg_546_1.time_ >= var_549_0 + var_549_10 and arg_546_1.time_ < var_549_0 + var_549_10 + arg_549_0 then
				arg_546_1.typewritter.percent = 1

				arg_546_1.typewritter:SetDirty()
				arg_546_1:ShowNextGo(true)
			end
		end

		arg_546_1.nodeConfigList_ = {}

		arg_546_1:InitPlayNodeList()
	end,
	Play426101129 = function(arg_550_0, arg_550_1)
		arg_550_1.time_ = 0
		arg_550_1.frameCnt_ = 0
		arg_550_1.state_ = "playing"
		arg_550_1.curTalkId_ = 426101129
		arg_550_1.duration_ = 5

		SetActive(arg_550_1.tipsGo_, false)

		function arg_550_1.onSingleLineFinish_()
			arg_550_1.onSingleLineUpdate_ = nil
			arg_550_1.onSingleLineFinish_ = nil
			arg_550_1.state_ = "waiting"
		end

		function arg_550_1.playNext_(arg_552_0)
			if arg_552_0 == 1 then
				arg_550_0:Play426101130(arg_550_1)
			end
		end

		function arg_550_1.onSingleLineUpdate_(arg_553_0)
			local var_553_0 = 0
			local var_553_1 = 1

			if var_553_0 < arg_550_1.time_ and arg_550_1.time_ <= var_553_0 + arg_553_0 then
				arg_550_1.talkMaxDuration = 0
				arg_550_1.dialogCg_.alpha = 1

				arg_550_1.dialog_:SetActive(true)
				SetActive(arg_550_1.leftNameGo_, false)

				arg_550_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_550_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_550_1:RecordName(arg_550_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_550_1.iconTrs_.gameObject, false)
				arg_550_1.callingController_:SetSelectedState("normal")

				local var_553_2 = arg_550_1:GetWordFromCfg(426101129)
				local var_553_3 = arg_550_1:FormatText(var_553_2.content)

				arg_550_1.text_.text = var_553_3

				LuaForUtil.ClearLinePrefixSymbol(arg_550_1.text_)

				local var_553_4 = 40
				local var_553_5 = utf8.len(var_553_3)
				local var_553_6 = var_553_4 <= 0 and var_553_1 or var_553_1 * (var_553_5 / var_553_4)

				if var_553_6 > 0 and var_553_1 < var_553_6 then
					arg_550_1.talkMaxDuration = var_553_6

					if var_553_6 + var_553_0 > arg_550_1.duration_ then
						arg_550_1.duration_ = var_553_6 + var_553_0
					end
				end

				arg_550_1.text_.text = var_553_3
				arg_550_1.typewritter.percent = 0

				arg_550_1.typewritter:SetDirty()
				arg_550_1:ShowNextGo(false)
				arg_550_1:RecordContent(arg_550_1.text_.text)
			end

			local var_553_7 = math.max(var_553_1, arg_550_1.talkMaxDuration)

			if var_553_0 <= arg_550_1.time_ and arg_550_1.time_ < var_553_0 + var_553_7 then
				arg_550_1.typewritter.percent = (arg_550_1.time_ - var_553_0) / var_553_7

				arg_550_1.typewritter:SetDirty()
			end

			if arg_550_1.time_ >= var_553_0 + var_553_7 and arg_550_1.time_ < var_553_0 + var_553_7 + arg_553_0 then
				arg_550_1.typewritter.percent = 1

				arg_550_1.typewritter:SetDirty()
				arg_550_1:ShowNextGo(true)
			end
		end

		arg_550_1.nodeConfigList_ = {}

		arg_550_1:InitPlayNodeList()
	end,
	Play426101130 = function(arg_554_0, arg_554_1)
		arg_554_1.time_ = 0
		arg_554_1.frameCnt_ = 0
		arg_554_1.state_ = "playing"
		arg_554_1.curTalkId_ = 426101130
		arg_554_1.duration_ = 4.03

		local var_554_0 = {
			zh = 3.7,
			ja = 4.033
		}
		local var_554_1 = manager.audio:GetLocalizationFlag()

		if var_554_0[var_554_1] ~= nil then
			arg_554_1.duration_ = var_554_0[var_554_1]
		end

		SetActive(arg_554_1.tipsGo_, false)

		function arg_554_1.onSingleLineFinish_()
			arg_554_1.onSingleLineUpdate_ = nil
			arg_554_1.onSingleLineFinish_ = nil
			arg_554_1.state_ = "waiting"
		end

		function arg_554_1.playNext_(arg_556_0)
			if arg_556_0 == 1 then
				arg_554_0:Play426101131(arg_554_1)
			end
		end

		function arg_554_1.onSingleLineUpdate_(arg_557_0)
			local var_557_0 = 0
			local var_557_1 = 0.325

			if var_557_0 < arg_554_1.time_ and arg_554_1.time_ <= var_557_0 + arg_557_0 then
				arg_554_1.talkMaxDuration = 0
				arg_554_1.dialogCg_.alpha = 1

				arg_554_1.dialog_:SetActive(true)
				SetActive(arg_554_1.leftNameGo_, true)

				local var_557_2 = arg_554_1:FormatText(StoryNameCfg[1488].name)

				arg_554_1.leftNameTxt_.text = var_557_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_554_1.leftNameTxt_.transform)

				arg_554_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_554_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_554_1:RecordName(arg_554_1.leftNameTxt_.text)
				SetActive(arg_554_1.iconTrs_.gameObject, false)
				arg_554_1.callingController_:SetSelectedState("normal")

				local var_557_3 = arg_554_1:GetWordFromCfg(426101130)
				local var_557_4 = arg_554_1:FormatText(var_557_3.content)

				arg_554_1.text_.text = var_557_4

				LuaForUtil.ClearLinePrefixSymbol(arg_554_1.text_)

				local var_557_5 = 13
				local var_557_6 = utf8.len(var_557_4)
				local var_557_7 = var_557_5 <= 0 and var_557_1 or var_557_1 * (var_557_6 / var_557_5)

				if var_557_7 > 0 and var_557_1 < var_557_7 then
					arg_554_1.talkMaxDuration = var_557_7

					if var_557_7 + var_557_0 > arg_554_1.duration_ then
						arg_554_1.duration_ = var_557_7 + var_557_0
					end
				end

				arg_554_1.text_.text = var_557_4
				arg_554_1.typewritter.percent = 0

				arg_554_1.typewritter:SetDirty()
				arg_554_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426101", "426101130", "story_v_out_426101.awb") ~= 0 then
					local var_557_8 = manager.audio:GetVoiceLength("story_v_out_426101", "426101130", "story_v_out_426101.awb") / 1000

					if var_557_8 + var_557_0 > arg_554_1.duration_ then
						arg_554_1.duration_ = var_557_8 + var_557_0
					end

					if var_557_3.prefab_name ~= "" and arg_554_1.actors_[var_557_3.prefab_name] ~= nil then
						local var_557_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_554_1.actors_[var_557_3.prefab_name].transform, "story_v_out_426101", "426101130", "story_v_out_426101.awb")

						arg_554_1:RecordAudio("426101130", var_557_9)
						arg_554_1:RecordAudio("426101130", var_557_9)
					else
						arg_554_1:AudioAction("play", "voice", "story_v_out_426101", "426101130", "story_v_out_426101.awb")
					end

					arg_554_1:RecordHistoryTalkVoice("story_v_out_426101", "426101130", "story_v_out_426101.awb")
				end

				arg_554_1:RecordContent(arg_554_1.text_.text)
			end

			local var_557_10 = math.max(var_557_1, arg_554_1.talkMaxDuration)

			if var_557_0 <= arg_554_1.time_ and arg_554_1.time_ < var_557_0 + var_557_10 then
				arg_554_1.typewritter.percent = (arg_554_1.time_ - var_557_0) / var_557_10

				arg_554_1.typewritter:SetDirty()
			end

			if arg_554_1.time_ >= var_557_0 + var_557_10 and arg_554_1.time_ < var_557_0 + var_557_10 + arg_557_0 then
				arg_554_1.typewritter.percent = 1

				arg_554_1.typewritter:SetDirty()
				arg_554_1:ShowNextGo(true)
			end
		end

		arg_554_1.nodeConfigList_ = {}

		arg_554_1:InitPlayNodeList()
	end,
	Play426101131 = function(arg_558_0, arg_558_1)
		arg_558_1.time_ = 0
		arg_558_1.frameCnt_ = 0
		arg_558_1.state_ = "playing"
		arg_558_1.curTalkId_ = 426101131
		arg_558_1.duration_ = 5

		SetActive(arg_558_1.tipsGo_, false)

		function arg_558_1.onSingleLineFinish_()
			arg_558_1.onSingleLineUpdate_ = nil
			arg_558_1.onSingleLineFinish_ = nil
			arg_558_1.state_ = "waiting"
		end

		function arg_558_1.playNext_(arg_560_0)
			if arg_560_0 == 1 then
				arg_558_0:Play426101132(arg_558_1)
			end
		end

		function arg_558_1.onSingleLineUpdate_(arg_561_0)
			local var_561_0 = 0
			local var_561_1 = 0.425

			if var_561_0 < arg_558_1.time_ and arg_558_1.time_ <= var_561_0 + arg_561_0 then
				arg_558_1.talkMaxDuration = 0
				arg_558_1.dialogCg_.alpha = 1

				arg_558_1.dialog_:SetActive(true)
				SetActive(arg_558_1.leftNameGo_, true)

				local var_561_2 = arg_558_1:FormatText(StoryNameCfg[7].name)

				arg_558_1.leftNameTxt_.text = var_561_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_558_1.leftNameTxt_.transform)

				arg_558_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_558_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_558_1:RecordName(arg_558_1.leftNameTxt_.text)
				SetActive(arg_558_1.iconTrs_.gameObject, true)
				arg_558_1.iconController_:SetSelectedState("hero")

				arg_558_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_558_1.callingController_:SetSelectedState("normal")

				arg_558_1.keyicon_.color = Color.New(1, 1, 1)
				arg_558_1.icon_.color = Color.New(1, 1, 1)

				local var_561_3 = arg_558_1:GetWordFromCfg(426101131)
				local var_561_4 = arg_558_1:FormatText(var_561_3.content)

				arg_558_1.text_.text = var_561_4

				LuaForUtil.ClearLinePrefixSymbol(arg_558_1.text_)

				local var_561_5 = 17
				local var_561_6 = utf8.len(var_561_4)
				local var_561_7 = var_561_5 <= 0 and var_561_1 or var_561_1 * (var_561_6 / var_561_5)

				if var_561_7 > 0 and var_561_1 < var_561_7 then
					arg_558_1.talkMaxDuration = var_561_7

					if var_561_7 + var_561_0 > arg_558_1.duration_ then
						arg_558_1.duration_ = var_561_7 + var_561_0
					end
				end

				arg_558_1.text_.text = var_561_4
				arg_558_1.typewritter.percent = 0

				arg_558_1.typewritter:SetDirty()
				arg_558_1:ShowNextGo(false)
				arg_558_1:RecordContent(arg_558_1.text_.text)
			end

			local var_561_8 = math.max(var_561_1, arg_558_1.talkMaxDuration)

			if var_561_0 <= arg_558_1.time_ and arg_558_1.time_ < var_561_0 + var_561_8 then
				arg_558_1.typewritter.percent = (arg_558_1.time_ - var_561_0) / var_561_8

				arg_558_1.typewritter:SetDirty()
			end

			if arg_558_1.time_ >= var_561_0 + var_561_8 and arg_558_1.time_ < var_561_0 + var_561_8 + arg_561_0 then
				arg_558_1.typewritter.percent = 1

				arg_558_1.typewritter:SetDirty()
				arg_558_1:ShowNextGo(true)
			end
		end

		arg_558_1.nodeConfigList_ = {}

		arg_558_1:InitPlayNodeList()
	end,
	Play426101132 = function(arg_562_0, arg_562_1)
		arg_562_1.time_ = 0
		arg_562_1.frameCnt_ = 0
		arg_562_1.state_ = "playing"
		arg_562_1.curTalkId_ = 426101132
		arg_562_1.duration_ = 11.03

		local var_562_0 = {
			zh = 8.3,
			ja = 11.033
		}
		local var_562_1 = manager.audio:GetLocalizationFlag()

		if var_562_0[var_562_1] ~= nil then
			arg_562_1.duration_ = var_562_0[var_562_1]
		end

		SetActive(arg_562_1.tipsGo_, false)

		function arg_562_1.onSingleLineFinish_()
			arg_562_1.onSingleLineUpdate_ = nil
			arg_562_1.onSingleLineFinish_ = nil
			arg_562_1.state_ = "waiting"
		end

		function arg_562_1.playNext_(arg_564_0)
			if arg_564_0 == 1 then
				arg_562_0:Play426101133(arg_562_1)
			end
		end

		function arg_562_1.onSingleLineUpdate_(arg_565_0)
			local var_565_0 = 0
			local var_565_1 = 0.95

			if var_565_0 < arg_562_1.time_ and arg_562_1.time_ <= var_565_0 + arg_565_0 then
				arg_562_1.talkMaxDuration = 0
				arg_562_1.dialogCg_.alpha = 1

				arg_562_1.dialog_:SetActive(true)
				SetActive(arg_562_1.leftNameGo_, true)

				local var_565_2 = arg_562_1:FormatText(StoryNameCfg[1488].name)

				arg_562_1.leftNameTxt_.text = var_565_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_562_1.leftNameTxt_.transform)

				arg_562_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_562_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_562_1:RecordName(arg_562_1.leftNameTxt_.text)
				SetActive(arg_562_1.iconTrs_.gameObject, false)
				arg_562_1.callingController_:SetSelectedState("normal")

				local var_565_3 = arg_562_1:GetWordFromCfg(426101132)
				local var_565_4 = arg_562_1:FormatText(var_565_3.content)

				arg_562_1.text_.text = var_565_4

				LuaForUtil.ClearLinePrefixSymbol(arg_562_1.text_)

				local var_565_5 = 38
				local var_565_6 = utf8.len(var_565_4)
				local var_565_7 = var_565_5 <= 0 and var_565_1 or var_565_1 * (var_565_6 / var_565_5)

				if var_565_7 > 0 and var_565_1 < var_565_7 then
					arg_562_1.talkMaxDuration = var_565_7

					if var_565_7 + var_565_0 > arg_562_1.duration_ then
						arg_562_1.duration_ = var_565_7 + var_565_0
					end
				end

				arg_562_1.text_.text = var_565_4
				arg_562_1.typewritter.percent = 0

				arg_562_1.typewritter:SetDirty()
				arg_562_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426101", "426101132", "story_v_out_426101.awb") ~= 0 then
					local var_565_8 = manager.audio:GetVoiceLength("story_v_out_426101", "426101132", "story_v_out_426101.awb") / 1000

					if var_565_8 + var_565_0 > arg_562_1.duration_ then
						arg_562_1.duration_ = var_565_8 + var_565_0
					end

					if var_565_3.prefab_name ~= "" and arg_562_1.actors_[var_565_3.prefab_name] ~= nil then
						local var_565_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_562_1.actors_[var_565_3.prefab_name].transform, "story_v_out_426101", "426101132", "story_v_out_426101.awb")

						arg_562_1:RecordAudio("426101132", var_565_9)
						arg_562_1:RecordAudio("426101132", var_565_9)
					else
						arg_562_1:AudioAction("play", "voice", "story_v_out_426101", "426101132", "story_v_out_426101.awb")
					end

					arg_562_1:RecordHistoryTalkVoice("story_v_out_426101", "426101132", "story_v_out_426101.awb")
				end

				arg_562_1:RecordContent(arg_562_1.text_.text)
			end

			local var_565_10 = math.max(var_565_1, arg_562_1.talkMaxDuration)

			if var_565_0 <= arg_562_1.time_ and arg_562_1.time_ < var_565_0 + var_565_10 then
				arg_562_1.typewritter.percent = (arg_562_1.time_ - var_565_0) / var_565_10

				arg_562_1.typewritter:SetDirty()
			end

			if arg_562_1.time_ >= var_565_0 + var_565_10 and arg_562_1.time_ < var_565_0 + var_565_10 + arg_565_0 then
				arg_562_1.typewritter.percent = 1

				arg_562_1.typewritter:SetDirty()
				arg_562_1:ShowNextGo(true)
			end
		end

		arg_562_1.nodeConfigList_ = {}

		arg_562_1:InitPlayNodeList()
	end,
	Play426101133 = function(arg_566_0, arg_566_1)
		arg_566_1.time_ = 0
		arg_566_1.frameCnt_ = 0
		arg_566_1.state_ = "playing"
		arg_566_1.curTalkId_ = 426101133
		arg_566_1.duration_ = 5.7

		local var_566_0 = {
			zh = 4.1,
			ja = 5.7
		}
		local var_566_1 = manager.audio:GetLocalizationFlag()

		if var_566_0[var_566_1] ~= nil then
			arg_566_1.duration_ = var_566_0[var_566_1]
		end

		SetActive(arg_566_1.tipsGo_, false)

		function arg_566_1.onSingleLineFinish_()
			arg_566_1.onSingleLineUpdate_ = nil
			arg_566_1.onSingleLineFinish_ = nil
			arg_566_1.state_ = "waiting"
		end

		function arg_566_1.playNext_(arg_568_0)
			if arg_568_0 == 1 then
				arg_566_0:Play426101134(arg_566_1)
			end
		end

		function arg_566_1.onSingleLineUpdate_(arg_569_0)
			local var_569_0 = 0
			local var_569_1 = 0.525

			if var_569_0 < arg_566_1.time_ and arg_566_1.time_ <= var_569_0 + arg_569_0 then
				arg_566_1.talkMaxDuration = 0
				arg_566_1.dialogCg_.alpha = 1

				arg_566_1.dialog_:SetActive(true)
				SetActive(arg_566_1.leftNameGo_, true)

				local var_569_2 = arg_566_1:FormatText(StoryNameCfg[1488].name)

				arg_566_1.leftNameTxt_.text = var_569_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_566_1.leftNameTxt_.transform)

				arg_566_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_566_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_566_1:RecordName(arg_566_1.leftNameTxt_.text)
				SetActive(arg_566_1.iconTrs_.gameObject, false)
				arg_566_1.callingController_:SetSelectedState("normal")

				local var_569_3 = arg_566_1:GetWordFromCfg(426101133)
				local var_569_4 = arg_566_1:FormatText(var_569_3.content)

				arg_566_1.text_.text = var_569_4

				LuaForUtil.ClearLinePrefixSymbol(arg_566_1.text_)

				local var_569_5 = 21
				local var_569_6 = utf8.len(var_569_4)
				local var_569_7 = var_569_5 <= 0 and var_569_1 or var_569_1 * (var_569_6 / var_569_5)

				if var_569_7 > 0 and var_569_1 < var_569_7 then
					arg_566_1.talkMaxDuration = var_569_7

					if var_569_7 + var_569_0 > arg_566_1.duration_ then
						arg_566_1.duration_ = var_569_7 + var_569_0
					end
				end

				arg_566_1.text_.text = var_569_4
				arg_566_1.typewritter.percent = 0

				arg_566_1.typewritter:SetDirty()
				arg_566_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426101", "426101133", "story_v_out_426101.awb") ~= 0 then
					local var_569_8 = manager.audio:GetVoiceLength("story_v_out_426101", "426101133", "story_v_out_426101.awb") / 1000

					if var_569_8 + var_569_0 > arg_566_1.duration_ then
						arg_566_1.duration_ = var_569_8 + var_569_0
					end

					if var_569_3.prefab_name ~= "" and arg_566_1.actors_[var_569_3.prefab_name] ~= nil then
						local var_569_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_566_1.actors_[var_569_3.prefab_name].transform, "story_v_out_426101", "426101133", "story_v_out_426101.awb")

						arg_566_1:RecordAudio("426101133", var_569_9)
						arg_566_1:RecordAudio("426101133", var_569_9)
					else
						arg_566_1:AudioAction("play", "voice", "story_v_out_426101", "426101133", "story_v_out_426101.awb")
					end

					arg_566_1:RecordHistoryTalkVoice("story_v_out_426101", "426101133", "story_v_out_426101.awb")
				end

				arg_566_1:RecordContent(arg_566_1.text_.text)
			end

			local var_569_10 = math.max(var_569_1, arg_566_1.talkMaxDuration)

			if var_569_0 <= arg_566_1.time_ and arg_566_1.time_ < var_569_0 + var_569_10 then
				arg_566_1.typewritter.percent = (arg_566_1.time_ - var_569_0) / var_569_10

				arg_566_1.typewritter:SetDirty()
			end

			if arg_566_1.time_ >= var_569_0 + var_569_10 and arg_566_1.time_ < var_569_0 + var_569_10 + arg_569_0 then
				arg_566_1.typewritter.percent = 1

				arg_566_1.typewritter:SetDirty()
				arg_566_1:ShowNextGo(true)
			end
		end

		arg_566_1.nodeConfigList_ = {}

		arg_566_1:InitPlayNodeList()
	end,
	Play426101134 = function(arg_570_0, arg_570_1)
		arg_570_1.time_ = 0
		arg_570_1.frameCnt_ = 0
		arg_570_1.state_ = "playing"
		arg_570_1.curTalkId_ = 426101134
		arg_570_1.duration_ = 5.03

		local var_570_0 = {
			zh = 4.833,
			ja = 5.033
		}
		local var_570_1 = manager.audio:GetLocalizationFlag()

		if var_570_0[var_570_1] ~= nil then
			arg_570_1.duration_ = var_570_0[var_570_1]
		end

		SetActive(arg_570_1.tipsGo_, false)

		function arg_570_1.onSingleLineFinish_()
			arg_570_1.onSingleLineUpdate_ = nil
			arg_570_1.onSingleLineFinish_ = nil
			arg_570_1.state_ = "waiting"
		end

		function arg_570_1.playNext_(arg_572_0)
			if arg_572_0 == 1 then
				arg_570_0:Play426101135(arg_570_1)
			end
		end

		function arg_570_1.onSingleLineUpdate_(arg_573_0)
			local var_573_0 = 0
			local var_573_1 = 0.325

			if var_573_0 < arg_570_1.time_ and arg_570_1.time_ <= var_573_0 + arg_573_0 then
				arg_570_1.talkMaxDuration = 0
				arg_570_1.dialogCg_.alpha = 1

				arg_570_1.dialog_:SetActive(true)
				SetActive(arg_570_1.leftNameGo_, true)

				local var_573_2 = arg_570_1:FormatText(StoryNameCfg[1487].name)

				arg_570_1.leftNameTxt_.text = var_573_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_570_1.leftNameTxt_.transform)

				arg_570_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_570_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_570_1:RecordName(arg_570_1.leftNameTxt_.text)
				SetActive(arg_570_1.iconTrs_.gameObject, false)
				arg_570_1.callingController_:SetSelectedState("normal")

				local var_573_3 = arg_570_1:GetWordFromCfg(426101134)
				local var_573_4 = arg_570_1:FormatText(var_573_3.content)

				arg_570_1.text_.text = var_573_4

				LuaForUtil.ClearLinePrefixSymbol(arg_570_1.text_)

				local var_573_5 = 13
				local var_573_6 = utf8.len(var_573_4)
				local var_573_7 = var_573_5 <= 0 and var_573_1 or var_573_1 * (var_573_6 / var_573_5)

				if var_573_7 > 0 and var_573_1 < var_573_7 then
					arg_570_1.talkMaxDuration = var_573_7

					if var_573_7 + var_573_0 > arg_570_1.duration_ then
						arg_570_1.duration_ = var_573_7 + var_573_0
					end
				end

				arg_570_1.text_.text = var_573_4
				arg_570_1.typewritter.percent = 0

				arg_570_1.typewritter:SetDirty()
				arg_570_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426101", "426101134", "story_v_out_426101.awb") ~= 0 then
					local var_573_8 = manager.audio:GetVoiceLength("story_v_out_426101", "426101134", "story_v_out_426101.awb") / 1000

					if var_573_8 + var_573_0 > arg_570_1.duration_ then
						arg_570_1.duration_ = var_573_8 + var_573_0
					end

					if var_573_3.prefab_name ~= "" and arg_570_1.actors_[var_573_3.prefab_name] ~= nil then
						local var_573_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_570_1.actors_[var_573_3.prefab_name].transform, "story_v_out_426101", "426101134", "story_v_out_426101.awb")

						arg_570_1:RecordAudio("426101134", var_573_9)
						arg_570_1:RecordAudio("426101134", var_573_9)
					else
						arg_570_1:AudioAction("play", "voice", "story_v_out_426101", "426101134", "story_v_out_426101.awb")
					end

					arg_570_1:RecordHistoryTalkVoice("story_v_out_426101", "426101134", "story_v_out_426101.awb")
				end

				arg_570_1:RecordContent(arg_570_1.text_.text)
			end

			local var_573_10 = math.max(var_573_1, arg_570_1.talkMaxDuration)

			if var_573_0 <= arg_570_1.time_ and arg_570_1.time_ < var_573_0 + var_573_10 then
				arg_570_1.typewritter.percent = (arg_570_1.time_ - var_573_0) / var_573_10

				arg_570_1.typewritter:SetDirty()
			end

			if arg_570_1.time_ >= var_573_0 + var_573_10 and arg_570_1.time_ < var_573_0 + var_573_10 + arg_573_0 then
				arg_570_1.typewritter.percent = 1

				arg_570_1.typewritter:SetDirty()
				arg_570_1:ShowNextGo(true)
			end
		end

		arg_570_1.nodeConfigList_ = {}

		arg_570_1:InitPlayNodeList()
	end,
	Play426101135 = function(arg_574_0, arg_574_1)
		arg_574_1.time_ = 0
		arg_574_1.frameCnt_ = 0
		arg_574_1.state_ = "playing"
		arg_574_1.curTalkId_ = 426101135
		arg_574_1.duration_ = 5

		SetActive(arg_574_1.tipsGo_, false)

		function arg_574_1.onSingleLineFinish_()
			arg_574_1.onSingleLineUpdate_ = nil
			arg_574_1.onSingleLineFinish_ = nil
			arg_574_1.state_ = "waiting"
		end

		function arg_574_1.playNext_(arg_576_0)
			if arg_576_0 == 1 then
				arg_574_0:Play426101136(arg_574_1)
			end
		end

		function arg_574_1.onSingleLineUpdate_(arg_577_0)
			local var_577_0 = 0
			local var_577_1 = 1.175

			if var_577_0 < arg_574_1.time_ and arg_574_1.time_ <= var_577_0 + arg_577_0 then
				arg_574_1.talkMaxDuration = 0
				arg_574_1.dialogCg_.alpha = 1

				arg_574_1.dialog_:SetActive(true)
				SetActive(arg_574_1.leftNameGo_, false)

				arg_574_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_574_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_574_1:RecordName(arg_574_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_574_1.iconTrs_.gameObject, false)
				arg_574_1.callingController_:SetSelectedState("normal")

				local var_577_2 = arg_574_1:GetWordFromCfg(426101135)
				local var_577_3 = arg_574_1:FormatText(var_577_2.content)

				arg_574_1.text_.text = var_577_3

				LuaForUtil.ClearLinePrefixSymbol(arg_574_1.text_)

				local var_577_4 = 47
				local var_577_5 = utf8.len(var_577_3)
				local var_577_6 = var_577_4 <= 0 and var_577_1 or var_577_1 * (var_577_5 / var_577_4)

				if var_577_6 > 0 and var_577_1 < var_577_6 then
					arg_574_1.talkMaxDuration = var_577_6

					if var_577_6 + var_577_0 > arg_574_1.duration_ then
						arg_574_1.duration_ = var_577_6 + var_577_0
					end
				end

				arg_574_1.text_.text = var_577_3
				arg_574_1.typewritter.percent = 0

				arg_574_1.typewritter:SetDirty()
				arg_574_1:ShowNextGo(false)
				arg_574_1:RecordContent(arg_574_1.text_.text)
			end

			local var_577_7 = math.max(var_577_1, arg_574_1.talkMaxDuration)

			if var_577_0 <= arg_574_1.time_ and arg_574_1.time_ < var_577_0 + var_577_7 then
				arg_574_1.typewritter.percent = (arg_574_1.time_ - var_577_0) / var_577_7

				arg_574_1.typewritter:SetDirty()
			end

			if arg_574_1.time_ >= var_577_0 + var_577_7 and arg_574_1.time_ < var_577_0 + var_577_7 + arg_577_0 then
				arg_574_1.typewritter.percent = 1

				arg_574_1.typewritter:SetDirty()
				arg_574_1:ShowNextGo(true)
			end
		end

		arg_574_1.nodeConfigList_ = {}

		arg_574_1:InitPlayNodeList()
	end,
	Play426101136 = function(arg_578_0, arg_578_1)
		arg_578_1.time_ = 0
		arg_578_1.frameCnt_ = 0
		arg_578_1.state_ = "playing"
		arg_578_1.curTalkId_ = 426101136
		arg_578_1.duration_ = 2

		local var_578_0 = {
			zh = 2,
			ja = 1.999999999999
		}
		local var_578_1 = manager.audio:GetLocalizationFlag()

		if var_578_0[var_578_1] ~= nil then
			arg_578_1.duration_ = var_578_0[var_578_1]
		end

		SetActive(arg_578_1.tipsGo_, false)

		function arg_578_1.onSingleLineFinish_()
			arg_578_1.onSingleLineUpdate_ = nil
			arg_578_1.onSingleLineFinish_ = nil
			arg_578_1.state_ = "waiting"
		end

		function arg_578_1.playNext_(arg_580_0)
			if arg_580_0 == 1 then
				arg_578_0:Play426101137(arg_578_1)
			end
		end

		function arg_578_1.onSingleLineUpdate_(arg_581_0)
			local var_581_0 = arg_578_1.bgs_.SS2603.transform
			local var_581_1 = 0

			if var_581_1 < arg_578_1.time_ and arg_578_1.time_ <= var_581_1 + arg_581_0 then
				arg_578_1.var_.moveOldPosSS2603 = var_581_0.localPosition
			end

			local var_581_2 = 2

			if var_581_1 <= arg_578_1.time_ and arg_578_1.time_ < var_581_1 + var_581_2 then
				local var_581_3 = (arg_578_1.time_ - var_581_1) / var_581_2
				local var_581_4 = Vector3.New(-0.5, 1.5, 7.5)

				var_581_0.localPosition = Vector3.Lerp(arg_578_1.var_.moveOldPosSS2603, var_581_4, var_581_3)
			end

			if arg_578_1.time_ >= var_581_1 + var_581_2 and arg_578_1.time_ < var_581_1 + var_581_2 + arg_581_0 then
				var_581_0.localPosition = Vector3.New(-0.5, 1.5, 7.5)
			end

			local var_581_5 = 0

			if var_581_5 < arg_578_1.time_ and arg_578_1.time_ <= var_581_5 + arg_581_0 then
				arg_578_1.allBtn_.enabled = false
			end

			local var_581_6 = 2

			if arg_578_1.time_ >= var_581_5 + var_581_6 and arg_578_1.time_ < var_581_5 + var_581_6 + arg_581_0 then
				arg_578_1.allBtn_.enabled = true
			end

			local var_581_7 = 0
			local var_581_8 = 0.1

			if var_581_7 < arg_578_1.time_ and arg_578_1.time_ <= var_581_7 + arg_581_0 then
				arg_578_1.talkMaxDuration = 0

				arg_578_1.dialog_:SetActive(true)

				arg_578_1.dialogCg_.alpha = 0

				local var_581_9 = LeanTween.value(arg_578_1.dialog_, 0, 1, 0.3)

				var_581_9:setOnUpdate(LuaHelper.FloatAction(function(arg_582_0)
					arg_578_1.dialogCg_.alpha = arg_582_0
				end))
				var_581_9:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_578_1.dialog_)
					var_581_9:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_578_1.duration_ = arg_578_1.duration_ + 0.3

				SetActive(arg_578_1.leftNameGo_, true)

				local var_581_10 = arg_578_1:FormatText(StoryNameCfg[1489].name)

				arg_578_1.leftNameTxt_.text = var_581_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_578_1.leftNameTxt_.transform)

				arg_578_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_578_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_578_1:RecordName(arg_578_1.leftNameTxt_.text)
				SetActive(arg_578_1.iconTrs_.gameObject, false)
				arg_578_1.callingController_:SetSelectedState("normal")

				local var_581_11 = arg_578_1:GetWordFromCfg(426101136)
				local var_581_12 = arg_578_1:FormatText(var_581_11.content)

				arg_578_1.text_.text = var_581_12

				LuaForUtil.ClearLinePrefixSymbol(arg_578_1.text_)

				local var_581_13 = 4
				local var_581_14 = utf8.len(var_581_12)
				local var_581_15 = var_581_13 <= 0 and var_581_8 or var_581_8 * (var_581_14 / var_581_13)

				if var_581_15 > 0 and var_581_8 < var_581_15 then
					arg_578_1.talkMaxDuration = var_581_15
					var_581_7 = var_581_7 + 0.3

					if var_581_15 + var_581_7 > arg_578_1.duration_ then
						arg_578_1.duration_ = var_581_15 + var_581_7
					end
				end

				arg_578_1.text_.text = var_581_12
				arg_578_1.typewritter.percent = 0

				arg_578_1.typewritter:SetDirty()
				arg_578_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426101", "426101136", "story_v_out_426101.awb") ~= 0 then
					local var_581_16 = manager.audio:GetVoiceLength("story_v_out_426101", "426101136", "story_v_out_426101.awb") / 1000

					if var_581_16 + var_581_7 > arg_578_1.duration_ then
						arg_578_1.duration_ = var_581_16 + var_581_7
					end

					if var_581_11.prefab_name ~= "" and arg_578_1.actors_[var_581_11.prefab_name] ~= nil then
						local var_581_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_578_1.actors_[var_581_11.prefab_name].transform, "story_v_out_426101", "426101136", "story_v_out_426101.awb")

						arg_578_1:RecordAudio("426101136", var_581_17)
						arg_578_1:RecordAudio("426101136", var_581_17)
					else
						arg_578_1:AudioAction("play", "voice", "story_v_out_426101", "426101136", "story_v_out_426101.awb")
					end

					arg_578_1:RecordHistoryTalkVoice("story_v_out_426101", "426101136", "story_v_out_426101.awb")
				end

				arg_578_1:RecordContent(arg_578_1.text_.text)
			end

			local var_581_18 = var_581_7 + 0.3
			local var_581_19 = math.max(var_581_8, arg_578_1.talkMaxDuration)

			if var_581_18 <= arg_578_1.time_ and arg_578_1.time_ < var_581_18 + var_581_19 then
				arg_578_1.typewritter.percent = (arg_578_1.time_ - var_581_18) / var_581_19

				arg_578_1.typewritter:SetDirty()
			end

			if arg_578_1.time_ >= var_581_18 + var_581_19 and arg_578_1.time_ < var_581_18 + var_581_19 + arg_581_0 then
				arg_578_1.typewritter.percent = 1

				arg_578_1.typewritter:SetDirty()
				arg_578_1:ShowNextGo(true)
			end
		end

		arg_578_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "SS2603",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 2,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(-0.5, 1.5, 8),
					endPos = Vector3.New(-0.5, 1.5, 7.5),
					easeType = LeanTweenType.easeInOutExpo
				}
			}
		}

		arg_578_1:InitPlayNodeList()
	end,
	Play426101137 = function(arg_584_0, arg_584_1)
		arg_584_1.time_ = 0
		arg_584_1.frameCnt_ = 0
		arg_584_1.state_ = "playing"
		arg_584_1.curTalkId_ = 426101137
		arg_584_1.duration_ = 1

		SetActive(arg_584_1.tipsGo_, false)

		function arg_584_1.onSingleLineFinish_()
			arg_584_1.onSingleLineUpdate_ = nil
			arg_584_1.onSingleLineFinish_ = nil
			arg_584_1.state_ = "waiting"

			SetActive(arg_584_1.choicesGo_, true)

			for iter_585_0, iter_585_1 in ipairs(arg_584_1.choices_) do
				local var_585_0 = iter_585_0 <= 2

				SetActive(iter_585_1.go, var_585_0)
			end

			arg_584_1.choices_[1].txt.text = arg_584_1:FormatText(StoryChoiceCfg[1610].name)
			arg_584_1.choices_[2].txt.text = arg_584_1:FormatText(StoryChoiceCfg[1611].name)
		end

		function arg_584_1.playNext_(arg_586_0)
			if arg_586_0 == 1 then
				arg_584_0:Play426101138(arg_584_1)
			end

			if arg_586_0 == 2 then
				arg_584_0:Play426101139(arg_584_1)
			end

			arg_584_1:RecordChoiceLog(426101137, 1610, 1611)
		end

		function arg_584_1.onSingleLineUpdate_(arg_587_0)
			local var_587_0 = 0

			if var_587_0 < arg_584_1.time_ and arg_584_1.time_ <= var_587_0 + arg_587_0 then
				arg_584_1.allBtn_.enabled = false
			end

			local var_587_1 = 1

			if arg_584_1.time_ >= var_587_0 + var_587_1 and arg_584_1.time_ < var_587_0 + var_587_1 + arg_587_0 then
				arg_584_1.allBtn_.enabled = true
			end
		end

		arg_584_1.nodeConfigList_ = {}

		arg_584_1:InitPlayNodeList()
	end,
	Play426101138 = function(arg_588_0, arg_588_1)
		arg_588_1.time_ = 0
		arg_588_1.frameCnt_ = 0
		arg_588_1.state_ = "playing"
		arg_588_1.curTalkId_ = 426101138
		arg_588_1.duration_ = 5.63

		local var_588_0 = {
			zh = 5.633,
			ja = 5.533
		}
		local var_588_1 = manager.audio:GetLocalizationFlag()

		if var_588_0[var_588_1] ~= nil then
			arg_588_1.duration_ = var_588_0[var_588_1]
		end

		SetActive(arg_588_1.tipsGo_, false)

		function arg_588_1.onSingleLineFinish_()
			arg_588_1.onSingleLineUpdate_ = nil
			arg_588_1.onSingleLineFinish_ = nil
			arg_588_1.state_ = "waiting"
		end

		function arg_588_1.playNext_(arg_590_0)
			if arg_590_0 == 1 then
				arg_588_0:Play426101140(arg_588_1)
			end
		end

		function arg_588_1.onSingleLineUpdate_(arg_591_0)
			local var_591_0 = 0
			local var_591_1 = 0.6

			if var_591_0 < arg_588_1.time_ and arg_588_1.time_ <= var_591_0 + arg_591_0 then
				arg_588_1.talkMaxDuration = 0
				arg_588_1.dialogCg_.alpha = 1

				arg_588_1.dialog_:SetActive(true)
				SetActive(arg_588_1.leftNameGo_, true)

				local var_591_2 = arg_588_1:FormatText(StoryNameCfg[1487].name)

				arg_588_1.leftNameTxt_.text = var_591_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_588_1.leftNameTxt_.transform)

				arg_588_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_588_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_588_1:RecordName(arg_588_1.leftNameTxt_.text)
				SetActive(arg_588_1.iconTrs_.gameObject, false)
				arg_588_1.callingController_:SetSelectedState("normal")

				local var_591_3 = arg_588_1:GetWordFromCfg(426101138)
				local var_591_4 = arg_588_1:FormatText(var_591_3.content)

				arg_588_1.text_.text = var_591_4

				LuaForUtil.ClearLinePrefixSymbol(arg_588_1.text_)

				local var_591_5 = 24
				local var_591_6 = utf8.len(var_591_4)
				local var_591_7 = var_591_5 <= 0 and var_591_1 or var_591_1 * (var_591_6 / var_591_5)

				if var_591_7 > 0 and var_591_1 < var_591_7 then
					arg_588_1.talkMaxDuration = var_591_7

					if var_591_7 + var_591_0 > arg_588_1.duration_ then
						arg_588_1.duration_ = var_591_7 + var_591_0
					end
				end

				arg_588_1.text_.text = var_591_4
				arg_588_1.typewritter.percent = 0

				arg_588_1.typewritter:SetDirty()
				arg_588_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426101", "426101138", "story_v_out_426101.awb") ~= 0 then
					local var_591_8 = manager.audio:GetVoiceLength("story_v_out_426101", "426101138", "story_v_out_426101.awb") / 1000

					if var_591_8 + var_591_0 > arg_588_1.duration_ then
						arg_588_1.duration_ = var_591_8 + var_591_0
					end

					if var_591_3.prefab_name ~= "" and arg_588_1.actors_[var_591_3.prefab_name] ~= nil then
						local var_591_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_588_1.actors_[var_591_3.prefab_name].transform, "story_v_out_426101", "426101138", "story_v_out_426101.awb")

						arg_588_1:RecordAudio("426101138", var_591_9)
						arg_588_1:RecordAudio("426101138", var_591_9)
					else
						arg_588_1:AudioAction("play", "voice", "story_v_out_426101", "426101138", "story_v_out_426101.awb")
					end

					arg_588_1:RecordHistoryTalkVoice("story_v_out_426101", "426101138", "story_v_out_426101.awb")
				end

				arg_588_1:RecordContent(arg_588_1.text_.text)
			end

			local var_591_10 = math.max(var_591_1, arg_588_1.talkMaxDuration)

			if var_591_0 <= arg_588_1.time_ and arg_588_1.time_ < var_591_0 + var_591_10 then
				arg_588_1.typewritter.percent = (arg_588_1.time_ - var_591_0) / var_591_10

				arg_588_1.typewritter:SetDirty()
			end

			if arg_588_1.time_ >= var_591_0 + var_591_10 and arg_588_1.time_ < var_591_0 + var_591_10 + arg_591_0 then
				arg_588_1.typewritter.percent = 1

				arg_588_1.typewritter:SetDirty()
				arg_588_1:ShowNextGo(true)
			end
		end

		arg_588_1.nodeConfigList_ = {}

		arg_588_1:InitPlayNodeList()
	end,
	Play426101140 = function(arg_592_0, arg_592_1)
		arg_592_1.time_ = 0
		arg_592_1.frameCnt_ = 0
		arg_592_1.state_ = "playing"
		arg_592_1.curTalkId_ = 426101140
		arg_592_1.duration_ = 5

		SetActive(arg_592_1.tipsGo_, false)

		function arg_592_1.onSingleLineFinish_()
			arg_592_1.onSingleLineUpdate_ = nil
			arg_592_1.onSingleLineFinish_ = nil
			arg_592_1.state_ = "waiting"
		end

		function arg_592_1.playNext_(arg_594_0)
			if arg_594_0 == 1 then
				arg_592_0:Play426101141(arg_592_1)
			end
		end

		function arg_592_1.onSingleLineUpdate_(arg_595_0)
			local var_595_0 = 0
			local var_595_1 = 0.725

			if var_595_0 < arg_592_1.time_ and arg_592_1.time_ <= var_595_0 + arg_595_0 then
				arg_592_1.talkMaxDuration = 0
				arg_592_1.dialogCg_.alpha = 1

				arg_592_1.dialog_:SetActive(true)
				SetActive(arg_592_1.leftNameGo_, true)

				local var_595_2 = arg_592_1:FormatText(StoryNameCfg[7].name)

				arg_592_1.leftNameTxt_.text = var_595_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_592_1.leftNameTxt_.transform)

				arg_592_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_592_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_592_1:RecordName(arg_592_1.leftNameTxt_.text)
				SetActive(arg_592_1.iconTrs_.gameObject, true)
				arg_592_1.iconController_:SetSelectedState("hero")

				arg_592_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_592_1.callingController_:SetSelectedState("normal")

				arg_592_1.keyicon_.color = Color.New(1, 1, 1)
				arg_592_1.icon_.color = Color.New(1, 1, 1)

				local var_595_3 = arg_592_1:GetWordFromCfg(426101140)
				local var_595_4 = arg_592_1:FormatText(var_595_3.content)

				arg_592_1.text_.text = var_595_4

				LuaForUtil.ClearLinePrefixSymbol(arg_592_1.text_)

				local var_595_5 = 29
				local var_595_6 = utf8.len(var_595_4)
				local var_595_7 = var_595_5 <= 0 and var_595_1 or var_595_1 * (var_595_6 / var_595_5)

				if var_595_7 > 0 and var_595_1 < var_595_7 then
					arg_592_1.talkMaxDuration = var_595_7

					if var_595_7 + var_595_0 > arg_592_1.duration_ then
						arg_592_1.duration_ = var_595_7 + var_595_0
					end
				end

				arg_592_1.text_.text = var_595_4
				arg_592_1.typewritter.percent = 0

				arg_592_1.typewritter:SetDirty()
				arg_592_1:ShowNextGo(false)
				arg_592_1:RecordContent(arg_592_1.text_.text)
			end

			local var_595_8 = math.max(var_595_1, arg_592_1.talkMaxDuration)

			if var_595_0 <= arg_592_1.time_ and arg_592_1.time_ < var_595_0 + var_595_8 then
				arg_592_1.typewritter.percent = (arg_592_1.time_ - var_595_0) / var_595_8

				arg_592_1.typewritter:SetDirty()
			end

			if arg_592_1.time_ >= var_595_0 + var_595_8 and arg_592_1.time_ < var_595_0 + var_595_8 + arg_595_0 then
				arg_592_1.typewritter.percent = 1

				arg_592_1.typewritter:SetDirty()
				arg_592_1:ShowNextGo(true)
			end
		end

		arg_592_1.nodeConfigList_ = {}

		arg_592_1:InitPlayNodeList()
	end,
	Play426101141 = function(arg_596_0, arg_596_1)
		arg_596_1.time_ = 0
		arg_596_1.frameCnt_ = 0
		arg_596_1.state_ = "playing"
		arg_596_1.curTalkId_ = 426101141
		arg_596_1.duration_ = 5

		SetActive(arg_596_1.tipsGo_, false)

		function arg_596_1.onSingleLineFinish_()
			arg_596_1.onSingleLineUpdate_ = nil
			arg_596_1.onSingleLineFinish_ = nil
			arg_596_1.state_ = "waiting"
		end

		function arg_596_1.playNext_(arg_598_0)
			if arg_598_0 == 1 then
				arg_596_0:Play426101142(arg_596_1)
			end
		end

		function arg_596_1.onSingleLineUpdate_(arg_599_0)
			local var_599_0 = 0
			local var_599_1 = 0.2

			if var_599_0 < arg_596_1.time_ and arg_596_1.time_ <= var_599_0 + arg_599_0 then
				arg_596_1.talkMaxDuration = 0
				arg_596_1.dialogCg_.alpha = 1

				arg_596_1.dialog_:SetActive(true)
				SetActive(arg_596_1.leftNameGo_, true)

				local var_599_2 = arg_596_1:FormatText(StoryNameCfg[7].name)

				arg_596_1.leftNameTxt_.text = var_599_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_596_1.leftNameTxt_.transform)

				arg_596_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_596_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_596_1:RecordName(arg_596_1.leftNameTxt_.text)
				SetActive(arg_596_1.iconTrs_.gameObject, true)
				arg_596_1.iconController_:SetSelectedState("hero")

				arg_596_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_596_1.callingController_:SetSelectedState("normal")

				arg_596_1.keyicon_.color = Color.New(1, 1, 1)
				arg_596_1.icon_.color = Color.New(1, 1, 1)

				local var_599_3 = arg_596_1:GetWordFromCfg(426101141)
				local var_599_4 = arg_596_1:FormatText(var_599_3.content)

				arg_596_1.text_.text = var_599_4

				LuaForUtil.ClearLinePrefixSymbol(arg_596_1.text_)

				local var_599_5 = 8
				local var_599_6 = utf8.len(var_599_4)
				local var_599_7 = var_599_5 <= 0 and var_599_1 or var_599_1 * (var_599_6 / var_599_5)

				if var_599_7 > 0 and var_599_1 < var_599_7 then
					arg_596_1.talkMaxDuration = var_599_7

					if var_599_7 + var_599_0 > arg_596_1.duration_ then
						arg_596_1.duration_ = var_599_7 + var_599_0
					end
				end

				arg_596_1.text_.text = var_599_4
				arg_596_1.typewritter.percent = 0

				arg_596_1.typewritter:SetDirty()
				arg_596_1:ShowNextGo(false)
				arg_596_1:RecordContent(arg_596_1.text_.text)
			end

			local var_599_8 = math.max(var_599_1, arg_596_1.talkMaxDuration)

			if var_599_0 <= arg_596_1.time_ and arg_596_1.time_ < var_599_0 + var_599_8 then
				arg_596_1.typewritter.percent = (arg_596_1.time_ - var_599_0) / var_599_8

				arg_596_1.typewritter:SetDirty()
			end

			if arg_596_1.time_ >= var_599_0 + var_599_8 and arg_596_1.time_ < var_599_0 + var_599_8 + arg_599_0 then
				arg_596_1.typewritter.percent = 1

				arg_596_1.typewritter:SetDirty()
				arg_596_1:ShowNextGo(true)
			end
		end

		arg_596_1.nodeConfigList_ = {}

		arg_596_1:InitPlayNodeList()
	end,
	Play426101142 = function(arg_600_0, arg_600_1)
		arg_600_1.time_ = 0
		arg_600_1.frameCnt_ = 0
		arg_600_1.state_ = "playing"
		arg_600_1.curTalkId_ = 426101142
		arg_600_1.duration_ = 3.23

		local var_600_0 = {
			zh = 2.533,
			ja = 3.233
		}
		local var_600_1 = manager.audio:GetLocalizationFlag()

		if var_600_0[var_600_1] ~= nil then
			arg_600_1.duration_ = var_600_0[var_600_1]
		end

		SetActive(arg_600_1.tipsGo_, false)

		function arg_600_1.onSingleLineFinish_()
			arg_600_1.onSingleLineUpdate_ = nil
			arg_600_1.onSingleLineFinish_ = nil
			arg_600_1.state_ = "waiting"
		end

		function arg_600_1.playNext_(arg_602_0)
			if arg_602_0 == 1 then
				arg_600_0:Play426101143(arg_600_1)
			end
		end

		function arg_600_1.onSingleLineUpdate_(arg_603_0)
			local var_603_0 = 0
			local var_603_1 = 0.275

			if var_603_0 < arg_600_1.time_ and arg_600_1.time_ <= var_603_0 + arg_603_0 then
				arg_600_1.talkMaxDuration = 0
				arg_600_1.dialogCg_.alpha = 1

				arg_600_1.dialog_:SetActive(true)
				SetActive(arg_600_1.leftNameGo_, true)

				local var_603_2 = arg_600_1:FormatText(StoryNameCfg[1488].name)

				arg_600_1.leftNameTxt_.text = var_603_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_600_1.leftNameTxt_.transform)

				arg_600_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_600_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_600_1:RecordName(arg_600_1.leftNameTxt_.text)
				SetActive(arg_600_1.iconTrs_.gameObject, false)
				arg_600_1.callingController_:SetSelectedState("normal")

				local var_603_3 = arg_600_1:GetWordFromCfg(426101142)
				local var_603_4 = arg_600_1:FormatText(var_603_3.content)

				arg_600_1.text_.text = var_603_4

				LuaForUtil.ClearLinePrefixSymbol(arg_600_1.text_)

				local var_603_5 = 11
				local var_603_6 = utf8.len(var_603_4)
				local var_603_7 = var_603_5 <= 0 and var_603_1 or var_603_1 * (var_603_6 / var_603_5)

				if var_603_7 > 0 and var_603_1 < var_603_7 then
					arg_600_1.talkMaxDuration = var_603_7

					if var_603_7 + var_603_0 > arg_600_1.duration_ then
						arg_600_1.duration_ = var_603_7 + var_603_0
					end
				end

				arg_600_1.text_.text = var_603_4
				arg_600_1.typewritter.percent = 0

				arg_600_1.typewritter:SetDirty()
				arg_600_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426101", "426101142", "story_v_out_426101.awb") ~= 0 then
					local var_603_8 = manager.audio:GetVoiceLength("story_v_out_426101", "426101142", "story_v_out_426101.awb") / 1000

					if var_603_8 + var_603_0 > arg_600_1.duration_ then
						arg_600_1.duration_ = var_603_8 + var_603_0
					end

					if var_603_3.prefab_name ~= "" and arg_600_1.actors_[var_603_3.prefab_name] ~= nil then
						local var_603_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_600_1.actors_[var_603_3.prefab_name].transform, "story_v_out_426101", "426101142", "story_v_out_426101.awb")

						arg_600_1:RecordAudio("426101142", var_603_9)
						arg_600_1:RecordAudio("426101142", var_603_9)
					else
						arg_600_1:AudioAction("play", "voice", "story_v_out_426101", "426101142", "story_v_out_426101.awb")
					end

					arg_600_1:RecordHistoryTalkVoice("story_v_out_426101", "426101142", "story_v_out_426101.awb")
				end

				arg_600_1:RecordContent(arg_600_1.text_.text)
			end

			local var_603_10 = math.max(var_603_1, arg_600_1.talkMaxDuration)

			if var_603_0 <= arg_600_1.time_ and arg_600_1.time_ < var_603_0 + var_603_10 then
				arg_600_1.typewritter.percent = (arg_600_1.time_ - var_603_0) / var_603_10

				arg_600_1.typewritter:SetDirty()
			end

			if arg_600_1.time_ >= var_603_0 + var_603_10 and arg_600_1.time_ < var_603_0 + var_603_10 + arg_603_0 then
				arg_600_1.typewritter.percent = 1

				arg_600_1.typewritter:SetDirty()
				arg_600_1:ShowNextGo(true)
			end
		end

		arg_600_1.nodeConfigList_ = {}

		arg_600_1:InitPlayNodeList()
	end,
	Play426101143 = function(arg_604_0, arg_604_1)
		arg_604_1.time_ = 0
		arg_604_1.frameCnt_ = 0
		arg_604_1.state_ = "playing"
		arg_604_1.curTalkId_ = 426101143
		arg_604_1.duration_ = 5

		SetActive(arg_604_1.tipsGo_, false)

		function arg_604_1.onSingleLineFinish_()
			arg_604_1.onSingleLineUpdate_ = nil
			arg_604_1.onSingleLineFinish_ = nil
			arg_604_1.state_ = "waiting"
		end

		function arg_604_1.playNext_(arg_606_0)
			if arg_606_0 == 1 then
				arg_604_0:Play426101144(arg_604_1)
			end
		end

		function arg_604_1.onSingleLineUpdate_(arg_607_0)
			local var_607_0 = 0
			local var_607_1 = 0.275

			if var_607_0 < arg_604_1.time_ and arg_604_1.time_ <= var_607_0 + arg_607_0 then
				arg_604_1.talkMaxDuration = 0
				arg_604_1.dialogCg_.alpha = 1

				arg_604_1.dialog_:SetActive(true)
				SetActive(arg_604_1.leftNameGo_, true)

				local var_607_2 = arg_604_1:FormatText(StoryNameCfg[7].name)

				arg_604_1.leftNameTxt_.text = var_607_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_604_1.leftNameTxt_.transform)

				arg_604_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_604_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_604_1:RecordName(arg_604_1.leftNameTxt_.text)
				SetActive(arg_604_1.iconTrs_.gameObject, true)
				arg_604_1.iconController_:SetSelectedState("hero")

				arg_604_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_604_1.callingController_:SetSelectedState("normal")

				arg_604_1.keyicon_.color = Color.New(1, 1, 1)
				arg_604_1.icon_.color = Color.New(1, 1, 1)

				local var_607_3 = arg_604_1:GetWordFromCfg(426101143)
				local var_607_4 = arg_604_1:FormatText(var_607_3.content)

				arg_604_1.text_.text = var_607_4

				LuaForUtil.ClearLinePrefixSymbol(arg_604_1.text_)

				local var_607_5 = 11
				local var_607_6 = utf8.len(var_607_4)
				local var_607_7 = var_607_5 <= 0 and var_607_1 or var_607_1 * (var_607_6 / var_607_5)

				if var_607_7 > 0 and var_607_1 < var_607_7 then
					arg_604_1.talkMaxDuration = var_607_7

					if var_607_7 + var_607_0 > arg_604_1.duration_ then
						arg_604_1.duration_ = var_607_7 + var_607_0
					end
				end

				arg_604_1.text_.text = var_607_4
				arg_604_1.typewritter.percent = 0

				arg_604_1.typewritter:SetDirty()
				arg_604_1:ShowNextGo(false)
				arg_604_1:RecordContent(arg_604_1.text_.text)
			end

			local var_607_8 = math.max(var_607_1, arg_604_1.talkMaxDuration)

			if var_607_0 <= arg_604_1.time_ and arg_604_1.time_ < var_607_0 + var_607_8 then
				arg_604_1.typewritter.percent = (arg_604_1.time_ - var_607_0) / var_607_8

				arg_604_1.typewritter:SetDirty()
			end

			if arg_604_1.time_ >= var_607_0 + var_607_8 and arg_604_1.time_ < var_607_0 + var_607_8 + arg_607_0 then
				arg_604_1.typewritter.percent = 1

				arg_604_1.typewritter:SetDirty()
				arg_604_1:ShowNextGo(true)
			end
		end

		arg_604_1.nodeConfigList_ = {}

		arg_604_1:InitPlayNodeList()
	end,
	Play426101144 = function(arg_608_0, arg_608_1)
		arg_608_1.time_ = 0
		arg_608_1.frameCnt_ = 0
		arg_608_1.state_ = "playing"
		arg_608_1.curTalkId_ = 426101144
		arg_608_1.duration_ = 5.2

		local var_608_0 = {
			zh = 4.7,
			ja = 5.2
		}
		local var_608_1 = manager.audio:GetLocalizationFlag()

		if var_608_0[var_608_1] ~= nil then
			arg_608_1.duration_ = var_608_0[var_608_1]
		end

		SetActive(arg_608_1.tipsGo_, false)

		function arg_608_1.onSingleLineFinish_()
			arg_608_1.onSingleLineUpdate_ = nil
			arg_608_1.onSingleLineFinish_ = nil
			arg_608_1.state_ = "waiting"
		end

		function arg_608_1.playNext_(arg_610_0)
			if arg_610_0 == 1 then
				arg_608_0:Play426101145(arg_608_1)
			end
		end

		function arg_608_1.onSingleLineUpdate_(arg_611_0)
			local var_611_0 = 0
			local var_611_1 = 0.425

			if var_611_0 < arg_608_1.time_ and arg_608_1.time_ <= var_611_0 + arg_611_0 then
				arg_608_1.talkMaxDuration = 0
				arg_608_1.dialogCg_.alpha = 1

				arg_608_1.dialog_:SetActive(true)
				SetActive(arg_608_1.leftNameGo_, true)

				local var_611_2 = arg_608_1:FormatText(StoryNameCfg[1487].name)

				arg_608_1.leftNameTxt_.text = var_611_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_608_1.leftNameTxt_.transform)

				arg_608_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_608_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_608_1:RecordName(arg_608_1.leftNameTxt_.text)
				SetActive(arg_608_1.iconTrs_.gameObject, false)
				arg_608_1.callingController_:SetSelectedState("normal")

				local var_611_3 = arg_608_1:GetWordFromCfg(426101144)
				local var_611_4 = arg_608_1:FormatText(var_611_3.content)

				arg_608_1.text_.text = var_611_4

				LuaForUtil.ClearLinePrefixSymbol(arg_608_1.text_)

				local var_611_5 = 17
				local var_611_6 = utf8.len(var_611_4)
				local var_611_7 = var_611_5 <= 0 and var_611_1 or var_611_1 * (var_611_6 / var_611_5)

				if var_611_7 > 0 and var_611_1 < var_611_7 then
					arg_608_1.talkMaxDuration = var_611_7

					if var_611_7 + var_611_0 > arg_608_1.duration_ then
						arg_608_1.duration_ = var_611_7 + var_611_0
					end
				end

				arg_608_1.text_.text = var_611_4
				arg_608_1.typewritter.percent = 0

				arg_608_1.typewritter:SetDirty()
				arg_608_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426101", "426101144", "story_v_out_426101.awb") ~= 0 then
					local var_611_8 = manager.audio:GetVoiceLength("story_v_out_426101", "426101144", "story_v_out_426101.awb") / 1000

					if var_611_8 + var_611_0 > arg_608_1.duration_ then
						arg_608_1.duration_ = var_611_8 + var_611_0
					end

					if var_611_3.prefab_name ~= "" and arg_608_1.actors_[var_611_3.prefab_name] ~= nil then
						local var_611_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_608_1.actors_[var_611_3.prefab_name].transform, "story_v_out_426101", "426101144", "story_v_out_426101.awb")

						arg_608_1:RecordAudio("426101144", var_611_9)
						arg_608_1:RecordAudio("426101144", var_611_9)
					else
						arg_608_1:AudioAction("play", "voice", "story_v_out_426101", "426101144", "story_v_out_426101.awb")
					end

					arg_608_1:RecordHistoryTalkVoice("story_v_out_426101", "426101144", "story_v_out_426101.awb")
				end

				arg_608_1:RecordContent(arg_608_1.text_.text)
			end

			local var_611_10 = math.max(var_611_1, arg_608_1.talkMaxDuration)

			if var_611_0 <= arg_608_1.time_ and arg_608_1.time_ < var_611_0 + var_611_10 then
				arg_608_1.typewritter.percent = (arg_608_1.time_ - var_611_0) / var_611_10

				arg_608_1.typewritter:SetDirty()
			end

			if arg_608_1.time_ >= var_611_0 + var_611_10 and arg_608_1.time_ < var_611_0 + var_611_10 + arg_611_0 then
				arg_608_1.typewritter.percent = 1

				arg_608_1.typewritter:SetDirty()
				arg_608_1:ShowNextGo(true)
			end
		end

		arg_608_1.nodeConfigList_ = {}

		arg_608_1:InitPlayNodeList()
	end,
	Play426101145 = function(arg_612_0, arg_612_1)
		arg_612_1.time_ = 0
		arg_612_1.frameCnt_ = 0
		arg_612_1.state_ = "playing"
		arg_612_1.curTalkId_ = 426101145
		arg_612_1.duration_ = 5.63

		local var_612_0 = {
			zh = 3.933,
			ja = 5.633
		}
		local var_612_1 = manager.audio:GetLocalizationFlag()

		if var_612_0[var_612_1] ~= nil then
			arg_612_1.duration_ = var_612_0[var_612_1]
		end

		SetActive(arg_612_1.tipsGo_, false)

		function arg_612_1.onSingleLineFinish_()
			arg_612_1.onSingleLineUpdate_ = nil
			arg_612_1.onSingleLineFinish_ = nil
			arg_612_1.state_ = "waiting"
		end

		function arg_612_1.playNext_(arg_614_0)
			if arg_614_0 == 1 then
				arg_612_0:Play426101146(arg_612_1)
			end
		end

		function arg_612_1.onSingleLineUpdate_(arg_615_0)
			local var_615_0 = 0
			local var_615_1 = 0.45

			if var_615_0 < arg_612_1.time_ and arg_612_1.time_ <= var_615_0 + arg_615_0 then
				arg_612_1.talkMaxDuration = 0
				arg_612_1.dialogCg_.alpha = 1

				arg_612_1.dialog_:SetActive(true)
				SetActive(arg_612_1.leftNameGo_, true)

				local var_615_2 = arg_612_1:FormatText(StoryNameCfg[1488].name)

				arg_612_1.leftNameTxt_.text = var_615_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_612_1.leftNameTxt_.transform)

				arg_612_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_612_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_612_1:RecordName(arg_612_1.leftNameTxt_.text)
				SetActive(arg_612_1.iconTrs_.gameObject, false)
				arg_612_1.callingController_:SetSelectedState("normal")

				local var_615_3 = arg_612_1:GetWordFromCfg(426101145)
				local var_615_4 = arg_612_1:FormatText(var_615_3.content)

				arg_612_1.text_.text = var_615_4

				LuaForUtil.ClearLinePrefixSymbol(arg_612_1.text_)

				local var_615_5 = 18
				local var_615_6 = utf8.len(var_615_4)
				local var_615_7 = var_615_5 <= 0 and var_615_1 or var_615_1 * (var_615_6 / var_615_5)

				if var_615_7 > 0 and var_615_1 < var_615_7 then
					arg_612_1.talkMaxDuration = var_615_7

					if var_615_7 + var_615_0 > arg_612_1.duration_ then
						arg_612_1.duration_ = var_615_7 + var_615_0
					end
				end

				arg_612_1.text_.text = var_615_4
				arg_612_1.typewritter.percent = 0

				arg_612_1.typewritter:SetDirty()
				arg_612_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426101", "426101145", "story_v_out_426101.awb") ~= 0 then
					local var_615_8 = manager.audio:GetVoiceLength("story_v_out_426101", "426101145", "story_v_out_426101.awb") / 1000

					if var_615_8 + var_615_0 > arg_612_1.duration_ then
						arg_612_1.duration_ = var_615_8 + var_615_0
					end

					if var_615_3.prefab_name ~= "" and arg_612_1.actors_[var_615_3.prefab_name] ~= nil then
						local var_615_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_612_1.actors_[var_615_3.prefab_name].transform, "story_v_out_426101", "426101145", "story_v_out_426101.awb")

						arg_612_1:RecordAudio("426101145", var_615_9)
						arg_612_1:RecordAudio("426101145", var_615_9)
					else
						arg_612_1:AudioAction("play", "voice", "story_v_out_426101", "426101145", "story_v_out_426101.awb")
					end

					arg_612_1:RecordHistoryTalkVoice("story_v_out_426101", "426101145", "story_v_out_426101.awb")
				end

				arg_612_1:RecordContent(arg_612_1.text_.text)
			end

			local var_615_10 = math.max(var_615_1, arg_612_1.talkMaxDuration)

			if var_615_0 <= arg_612_1.time_ and arg_612_1.time_ < var_615_0 + var_615_10 then
				arg_612_1.typewritter.percent = (arg_612_1.time_ - var_615_0) / var_615_10

				arg_612_1.typewritter:SetDirty()
			end

			if arg_612_1.time_ >= var_615_0 + var_615_10 and arg_612_1.time_ < var_615_0 + var_615_10 + arg_615_0 then
				arg_612_1.typewritter.percent = 1

				arg_612_1.typewritter:SetDirty()
				arg_612_1:ShowNextGo(true)
			end
		end

		arg_612_1.nodeConfigList_ = {}

		arg_612_1:InitPlayNodeList()
	end,
	Play426101146 = function(arg_616_0, arg_616_1)
		arg_616_1.time_ = 0
		arg_616_1.frameCnt_ = 0
		arg_616_1.state_ = "playing"
		arg_616_1.curTalkId_ = 426101146
		arg_616_1.duration_ = 5

		SetActive(arg_616_1.tipsGo_, false)

		function arg_616_1.onSingleLineFinish_()
			arg_616_1.onSingleLineUpdate_ = nil
			arg_616_1.onSingleLineFinish_ = nil
			arg_616_1.state_ = "waiting"
		end

		function arg_616_1.playNext_(arg_618_0)
			if arg_618_0 == 1 then
				arg_616_0:Play426101147(arg_616_1)
			end
		end

		function arg_616_1.onSingleLineUpdate_(arg_619_0)
			local var_619_0 = 0
			local var_619_1 = 0.9

			if var_619_0 < arg_616_1.time_ and arg_616_1.time_ <= var_619_0 + arg_619_0 then
				arg_616_1.talkMaxDuration = 0
				arg_616_1.dialogCg_.alpha = 1

				arg_616_1.dialog_:SetActive(true)
				SetActive(arg_616_1.leftNameGo_, true)

				local var_619_2 = arg_616_1:FormatText(StoryNameCfg[7].name)

				arg_616_1.leftNameTxt_.text = var_619_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_616_1.leftNameTxt_.transform)

				arg_616_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_616_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_616_1:RecordName(arg_616_1.leftNameTxt_.text)
				SetActive(arg_616_1.iconTrs_.gameObject, true)
				arg_616_1.iconController_:SetSelectedState("hero")

				arg_616_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_616_1.callingController_:SetSelectedState("normal")

				arg_616_1.keyicon_.color = Color.New(1, 1, 1)
				arg_616_1.icon_.color = Color.New(1, 1, 1)

				local var_619_3 = arg_616_1:GetWordFromCfg(426101146)
				local var_619_4 = arg_616_1:FormatText(var_619_3.content)

				arg_616_1.text_.text = var_619_4

				LuaForUtil.ClearLinePrefixSymbol(arg_616_1.text_)

				local var_619_5 = 36
				local var_619_6 = utf8.len(var_619_4)
				local var_619_7 = var_619_5 <= 0 and var_619_1 or var_619_1 * (var_619_6 / var_619_5)

				if var_619_7 > 0 and var_619_1 < var_619_7 then
					arg_616_1.talkMaxDuration = var_619_7

					if var_619_7 + var_619_0 > arg_616_1.duration_ then
						arg_616_1.duration_ = var_619_7 + var_619_0
					end
				end

				arg_616_1.text_.text = var_619_4
				arg_616_1.typewritter.percent = 0

				arg_616_1.typewritter:SetDirty()
				arg_616_1:ShowNextGo(false)
				arg_616_1:RecordContent(arg_616_1.text_.text)
			end

			local var_619_8 = math.max(var_619_1, arg_616_1.talkMaxDuration)

			if var_619_0 <= arg_616_1.time_ and arg_616_1.time_ < var_619_0 + var_619_8 then
				arg_616_1.typewritter.percent = (arg_616_1.time_ - var_619_0) / var_619_8

				arg_616_1.typewritter:SetDirty()
			end

			if arg_616_1.time_ >= var_619_0 + var_619_8 and arg_616_1.time_ < var_619_0 + var_619_8 + arg_619_0 then
				arg_616_1.typewritter.percent = 1

				arg_616_1.typewritter:SetDirty()
				arg_616_1:ShowNextGo(true)
			end
		end

		arg_616_1.nodeConfigList_ = {}

		arg_616_1:InitPlayNodeList()
	end,
	Play426101147 = function(arg_620_0, arg_620_1)
		arg_620_1.time_ = 0
		arg_620_1.frameCnt_ = 0
		arg_620_1.state_ = "playing"
		arg_620_1.curTalkId_ = 426101147
		arg_620_1.duration_ = 3.07

		local var_620_0 = {
			zh = 2.433,
			ja = 3.066
		}
		local var_620_1 = manager.audio:GetLocalizationFlag()

		if var_620_0[var_620_1] ~= nil then
			arg_620_1.duration_ = var_620_0[var_620_1]
		end

		SetActive(arg_620_1.tipsGo_, false)

		function arg_620_1.onSingleLineFinish_()
			arg_620_1.onSingleLineUpdate_ = nil
			arg_620_1.onSingleLineFinish_ = nil
			arg_620_1.state_ = "waiting"
		end

		function arg_620_1.playNext_(arg_622_0)
			if arg_622_0 == 1 then
				arg_620_0:Play426101148(arg_620_1)
			end
		end

		function arg_620_1.onSingleLineUpdate_(arg_623_0)
			local var_623_0 = 0
			local var_623_1 = 0.275

			if var_623_0 < arg_620_1.time_ and arg_620_1.time_ <= var_623_0 + arg_623_0 then
				arg_620_1.talkMaxDuration = 0
				arg_620_1.dialogCg_.alpha = 1

				arg_620_1.dialog_:SetActive(true)
				SetActive(arg_620_1.leftNameGo_, true)

				local var_623_2 = arg_620_1:FormatText(StoryNameCfg[1487].name)

				arg_620_1.leftNameTxt_.text = var_623_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_620_1.leftNameTxt_.transform)

				arg_620_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_620_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_620_1:RecordName(arg_620_1.leftNameTxt_.text)
				SetActive(arg_620_1.iconTrs_.gameObject, false)
				arg_620_1.callingController_:SetSelectedState("normal")

				local var_623_3 = arg_620_1:GetWordFromCfg(426101147)
				local var_623_4 = arg_620_1:FormatText(var_623_3.content)

				arg_620_1.text_.text = var_623_4

				LuaForUtil.ClearLinePrefixSymbol(arg_620_1.text_)

				local var_623_5 = 11
				local var_623_6 = utf8.len(var_623_4)
				local var_623_7 = var_623_5 <= 0 and var_623_1 or var_623_1 * (var_623_6 / var_623_5)

				if var_623_7 > 0 and var_623_1 < var_623_7 then
					arg_620_1.talkMaxDuration = var_623_7

					if var_623_7 + var_623_0 > arg_620_1.duration_ then
						arg_620_1.duration_ = var_623_7 + var_623_0
					end
				end

				arg_620_1.text_.text = var_623_4
				arg_620_1.typewritter.percent = 0

				arg_620_1.typewritter:SetDirty()
				arg_620_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426101", "426101147", "story_v_out_426101.awb") ~= 0 then
					local var_623_8 = manager.audio:GetVoiceLength("story_v_out_426101", "426101147", "story_v_out_426101.awb") / 1000

					if var_623_8 + var_623_0 > arg_620_1.duration_ then
						arg_620_1.duration_ = var_623_8 + var_623_0
					end

					if var_623_3.prefab_name ~= "" and arg_620_1.actors_[var_623_3.prefab_name] ~= nil then
						local var_623_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_620_1.actors_[var_623_3.prefab_name].transform, "story_v_out_426101", "426101147", "story_v_out_426101.awb")

						arg_620_1:RecordAudio("426101147", var_623_9)
						arg_620_1:RecordAudio("426101147", var_623_9)
					else
						arg_620_1:AudioAction("play", "voice", "story_v_out_426101", "426101147", "story_v_out_426101.awb")
					end

					arg_620_1:RecordHistoryTalkVoice("story_v_out_426101", "426101147", "story_v_out_426101.awb")
				end

				arg_620_1:RecordContent(arg_620_1.text_.text)
			end

			local var_623_10 = math.max(var_623_1, arg_620_1.talkMaxDuration)

			if var_623_0 <= arg_620_1.time_ and arg_620_1.time_ < var_623_0 + var_623_10 then
				arg_620_1.typewritter.percent = (arg_620_1.time_ - var_623_0) / var_623_10

				arg_620_1.typewritter:SetDirty()
			end

			if arg_620_1.time_ >= var_623_0 + var_623_10 and arg_620_1.time_ < var_623_0 + var_623_10 + arg_623_0 then
				arg_620_1.typewritter.percent = 1

				arg_620_1.typewritter:SetDirty()
				arg_620_1:ShowNextGo(true)
			end
		end

		arg_620_1.nodeConfigList_ = {}

		arg_620_1:InitPlayNodeList()
	end,
	Play426101148 = function(arg_624_0, arg_624_1)
		arg_624_1.time_ = 0
		arg_624_1.frameCnt_ = 0
		arg_624_1.state_ = "playing"
		arg_624_1.curTalkId_ = 426101148
		arg_624_1.duration_ = 5

		SetActive(arg_624_1.tipsGo_, false)

		function arg_624_1.onSingleLineFinish_()
			arg_624_1.onSingleLineUpdate_ = nil
			arg_624_1.onSingleLineFinish_ = nil
			arg_624_1.state_ = "waiting"
		end

		function arg_624_1.playNext_(arg_626_0)
			if arg_626_0 == 1 then
				arg_624_0:Play426101149(arg_624_1)
			end
		end

		function arg_624_1.onSingleLineUpdate_(arg_627_0)
			local var_627_0 = 0
			local var_627_1 = 0.825

			if var_627_0 < arg_624_1.time_ and arg_624_1.time_ <= var_627_0 + arg_627_0 then
				arg_624_1.talkMaxDuration = 0
				arg_624_1.dialogCg_.alpha = 1

				arg_624_1.dialog_:SetActive(true)
				SetActive(arg_624_1.leftNameGo_, true)

				local var_627_2 = arg_624_1:FormatText(StoryNameCfg[7].name)

				arg_624_1.leftNameTxt_.text = var_627_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_624_1.leftNameTxt_.transform)

				arg_624_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_624_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_624_1:RecordName(arg_624_1.leftNameTxt_.text)
				SetActive(arg_624_1.iconTrs_.gameObject, true)
				arg_624_1.iconController_:SetSelectedState("hero")

				arg_624_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_624_1.callingController_:SetSelectedState("normal")

				arg_624_1.keyicon_.color = Color.New(1, 1, 1)
				arg_624_1.icon_.color = Color.New(1, 1, 1)

				local var_627_3 = arg_624_1:GetWordFromCfg(426101148)
				local var_627_4 = arg_624_1:FormatText(var_627_3.content)

				arg_624_1.text_.text = var_627_4

				LuaForUtil.ClearLinePrefixSymbol(arg_624_1.text_)

				local var_627_5 = 33
				local var_627_6 = utf8.len(var_627_4)
				local var_627_7 = var_627_5 <= 0 and var_627_1 or var_627_1 * (var_627_6 / var_627_5)

				if var_627_7 > 0 and var_627_1 < var_627_7 then
					arg_624_1.talkMaxDuration = var_627_7

					if var_627_7 + var_627_0 > arg_624_1.duration_ then
						arg_624_1.duration_ = var_627_7 + var_627_0
					end
				end

				arg_624_1.text_.text = var_627_4
				arg_624_1.typewritter.percent = 0

				arg_624_1.typewritter:SetDirty()
				arg_624_1:ShowNextGo(false)
				arg_624_1:RecordContent(arg_624_1.text_.text)
			end

			local var_627_8 = math.max(var_627_1, arg_624_1.talkMaxDuration)

			if var_627_0 <= arg_624_1.time_ and arg_624_1.time_ < var_627_0 + var_627_8 then
				arg_624_1.typewritter.percent = (arg_624_1.time_ - var_627_0) / var_627_8

				arg_624_1.typewritter:SetDirty()
			end

			if arg_624_1.time_ >= var_627_0 + var_627_8 and arg_624_1.time_ < var_627_0 + var_627_8 + arg_627_0 then
				arg_624_1.typewritter.percent = 1

				arg_624_1.typewritter:SetDirty()
				arg_624_1:ShowNextGo(true)
			end
		end

		arg_624_1.nodeConfigList_ = {}

		arg_624_1:InitPlayNodeList()
	end,
	Play426101149 = function(arg_628_0, arg_628_1)
		arg_628_1.time_ = 0
		arg_628_1.frameCnt_ = 0
		arg_628_1.state_ = "playing"
		arg_628_1.curTalkId_ = 426101149
		arg_628_1.duration_ = 5

		SetActive(arg_628_1.tipsGo_, false)

		function arg_628_1.onSingleLineFinish_()
			arg_628_1.onSingleLineUpdate_ = nil
			arg_628_1.onSingleLineFinish_ = nil
			arg_628_1.state_ = "waiting"
		end

		function arg_628_1.playNext_(arg_630_0)
			if arg_630_0 == 1 then
				arg_628_0:Play426101150(arg_628_1)
			end
		end

		function arg_628_1.onSingleLineUpdate_(arg_631_0)
			local var_631_0 = 0
			local var_631_1 = 0.575

			if var_631_0 < arg_628_1.time_ and arg_628_1.time_ <= var_631_0 + arg_631_0 then
				arg_628_1.talkMaxDuration = 0
				arg_628_1.dialogCg_.alpha = 1

				arg_628_1.dialog_:SetActive(true)
				SetActive(arg_628_1.leftNameGo_, true)

				local var_631_2 = arg_628_1:FormatText(StoryNameCfg[7].name)

				arg_628_1.leftNameTxt_.text = var_631_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_628_1.leftNameTxt_.transform)

				arg_628_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_628_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_628_1:RecordName(arg_628_1.leftNameTxt_.text)
				SetActive(arg_628_1.iconTrs_.gameObject, true)
				arg_628_1.iconController_:SetSelectedState("hero")

				arg_628_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_628_1.callingController_:SetSelectedState("normal")

				arg_628_1.keyicon_.color = Color.New(1, 1, 1)
				arg_628_1.icon_.color = Color.New(1, 1, 1)

				local var_631_3 = arg_628_1:GetWordFromCfg(426101149)
				local var_631_4 = arg_628_1:FormatText(var_631_3.content)

				arg_628_1.text_.text = var_631_4

				LuaForUtil.ClearLinePrefixSymbol(arg_628_1.text_)

				local var_631_5 = 23
				local var_631_6 = utf8.len(var_631_4)
				local var_631_7 = var_631_5 <= 0 and var_631_1 or var_631_1 * (var_631_6 / var_631_5)

				if var_631_7 > 0 and var_631_1 < var_631_7 then
					arg_628_1.talkMaxDuration = var_631_7

					if var_631_7 + var_631_0 > arg_628_1.duration_ then
						arg_628_1.duration_ = var_631_7 + var_631_0
					end
				end

				arg_628_1.text_.text = var_631_4
				arg_628_1.typewritter.percent = 0

				arg_628_1.typewritter:SetDirty()
				arg_628_1:ShowNextGo(false)
				arg_628_1:RecordContent(arg_628_1.text_.text)
			end

			local var_631_8 = math.max(var_631_1, arg_628_1.talkMaxDuration)

			if var_631_0 <= arg_628_1.time_ and arg_628_1.time_ < var_631_0 + var_631_8 then
				arg_628_1.typewritter.percent = (arg_628_1.time_ - var_631_0) / var_631_8

				arg_628_1.typewritter:SetDirty()
			end

			if arg_628_1.time_ >= var_631_0 + var_631_8 and arg_628_1.time_ < var_631_0 + var_631_8 + arg_631_0 then
				arg_628_1.typewritter.percent = 1

				arg_628_1.typewritter:SetDirty()
				arg_628_1:ShowNextGo(true)
			end
		end

		arg_628_1.nodeConfigList_ = {}

		arg_628_1:InitPlayNodeList()
	end,
	Play426101150 = function(arg_632_0, arg_632_1)
		arg_632_1.time_ = 0
		arg_632_1.frameCnt_ = 0
		arg_632_1.state_ = "playing"
		arg_632_1.curTalkId_ = 426101150
		arg_632_1.duration_ = 2.87

		local var_632_0 = {
			zh = 2.2,
			ja = 2.866
		}
		local var_632_1 = manager.audio:GetLocalizationFlag()

		if var_632_0[var_632_1] ~= nil then
			arg_632_1.duration_ = var_632_0[var_632_1]
		end

		SetActive(arg_632_1.tipsGo_, false)

		function arg_632_1.onSingleLineFinish_()
			arg_632_1.onSingleLineUpdate_ = nil
			arg_632_1.onSingleLineFinish_ = nil
			arg_632_1.state_ = "waiting"
		end

		function arg_632_1.playNext_(arg_634_0)
			if arg_634_0 == 1 then
				arg_632_0:Play426101151(arg_632_1)
			end
		end

		function arg_632_1.onSingleLineUpdate_(arg_635_0)
			local var_635_0 = 0
			local var_635_1 = 0.2

			if var_635_0 < arg_632_1.time_ and arg_632_1.time_ <= var_635_0 + arg_635_0 then
				arg_632_1.talkMaxDuration = 0
				arg_632_1.dialogCg_.alpha = 1

				arg_632_1.dialog_:SetActive(true)
				SetActive(arg_632_1.leftNameGo_, true)

				local var_635_2 = arg_632_1:FormatText(StoryNameCfg[1488].name)

				arg_632_1.leftNameTxt_.text = var_635_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_632_1.leftNameTxt_.transform)

				arg_632_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_632_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_632_1:RecordName(arg_632_1.leftNameTxt_.text)
				SetActive(arg_632_1.iconTrs_.gameObject, false)
				arg_632_1.callingController_:SetSelectedState("normal")

				local var_635_3 = arg_632_1:GetWordFromCfg(426101150)
				local var_635_4 = arg_632_1:FormatText(var_635_3.content)

				arg_632_1.text_.text = var_635_4

				LuaForUtil.ClearLinePrefixSymbol(arg_632_1.text_)

				local var_635_5 = 8
				local var_635_6 = utf8.len(var_635_4)
				local var_635_7 = var_635_5 <= 0 and var_635_1 or var_635_1 * (var_635_6 / var_635_5)

				if var_635_7 > 0 and var_635_1 < var_635_7 then
					arg_632_1.talkMaxDuration = var_635_7

					if var_635_7 + var_635_0 > arg_632_1.duration_ then
						arg_632_1.duration_ = var_635_7 + var_635_0
					end
				end

				arg_632_1.text_.text = var_635_4
				arg_632_1.typewritter.percent = 0

				arg_632_1.typewritter:SetDirty()
				arg_632_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426101", "426101150", "story_v_out_426101.awb") ~= 0 then
					local var_635_8 = manager.audio:GetVoiceLength("story_v_out_426101", "426101150", "story_v_out_426101.awb") / 1000

					if var_635_8 + var_635_0 > arg_632_1.duration_ then
						arg_632_1.duration_ = var_635_8 + var_635_0
					end

					if var_635_3.prefab_name ~= "" and arg_632_1.actors_[var_635_3.prefab_name] ~= nil then
						local var_635_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_632_1.actors_[var_635_3.prefab_name].transform, "story_v_out_426101", "426101150", "story_v_out_426101.awb")

						arg_632_1:RecordAudio("426101150", var_635_9)
						arg_632_1:RecordAudio("426101150", var_635_9)
					else
						arg_632_1:AudioAction("play", "voice", "story_v_out_426101", "426101150", "story_v_out_426101.awb")
					end

					arg_632_1:RecordHistoryTalkVoice("story_v_out_426101", "426101150", "story_v_out_426101.awb")
				end

				arg_632_1:RecordContent(arg_632_1.text_.text)
			end

			local var_635_10 = math.max(var_635_1, arg_632_1.talkMaxDuration)

			if var_635_0 <= arg_632_1.time_ and arg_632_1.time_ < var_635_0 + var_635_10 then
				arg_632_1.typewritter.percent = (arg_632_1.time_ - var_635_0) / var_635_10

				arg_632_1.typewritter:SetDirty()
			end

			if arg_632_1.time_ >= var_635_0 + var_635_10 and arg_632_1.time_ < var_635_0 + var_635_10 + arg_635_0 then
				arg_632_1.typewritter.percent = 1

				arg_632_1.typewritter:SetDirty()
				arg_632_1:ShowNextGo(true)
			end
		end

		arg_632_1.nodeConfigList_ = {}

		arg_632_1:InitPlayNodeList()
	end,
	Play426101151 = function(arg_636_0, arg_636_1)
		arg_636_1.time_ = 0
		arg_636_1.frameCnt_ = 0
		arg_636_1.state_ = "playing"
		arg_636_1.curTalkId_ = 426101151
		arg_636_1.duration_ = 5

		SetActive(arg_636_1.tipsGo_, false)

		function arg_636_1.onSingleLineFinish_()
			arg_636_1.onSingleLineUpdate_ = nil
			arg_636_1.onSingleLineFinish_ = nil
			arg_636_1.state_ = "waiting"
		end

		function arg_636_1.playNext_(arg_638_0)
			if arg_638_0 == 1 then
				arg_636_0:Play426101152(arg_636_1)
			end
		end

		function arg_636_1.onSingleLineUpdate_(arg_639_0)
			local var_639_0 = 0
			local var_639_1 = 1.3

			if var_639_0 < arg_636_1.time_ and arg_636_1.time_ <= var_639_0 + arg_639_0 then
				arg_636_1.talkMaxDuration = 0
				arg_636_1.dialogCg_.alpha = 1

				arg_636_1.dialog_:SetActive(true)
				SetActive(arg_636_1.leftNameGo_, true)

				local var_639_2 = arg_636_1:FormatText(StoryNameCfg[7].name)

				arg_636_1.leftNameTxt_.text = var_639_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_636_1.leftNameTxt_.transform)

				arg_636_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_636_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_636_1:RecordName(arg_636_1.leftNameTxt_.text)
				SetActive(arg_636_1.iconTrs_.gameObject, true)
				arg_636_1.iconController_:SetSelectedState("hero")

				arg_636_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_636_1.callingController_:SetSelectedState("normal")

				arg_636_1.keyicon_.color = Color.New(1, 1, 1)
				arg_636_1.icon_.color = Color.New(1, 1, 1)

				local var_639_3 = arg_636_1:GetWordFromCfg(426101151)
				local var_639_4 = arg_636_1:FormatText(var_639_3.content)

				arg_636_1.text_.text = var_639_4

				LuaForUtil.ClearLinePrefixSymbol(arg_636_1.text_)

				local var_639_5 = 52
				local var_639_6 = utf8.len(var_639_4)
				local var_639_7 = var_639_5 <= 0 and var_639_1 or var_639_1 * (var_639_6 / var_639_5)

				if var_639_7 > 0 and var_639_1 < var_639_7 then
					arg_636_1.talkMaxDuration = var_639_7

					if var_639_7 + var_639_0 > arg_636_1.duration_ then
						arg_636_1.duration_ = var_639_7 + var_639_0
					end
				end

				arg_636_1.text_.text = var_639_4
				arg_636_1.typewritter.percent = 0

				arg_636_1.typewritter:SetDirty()
				arg_636_1:ShowNextGo(false)
				arg_636_1:RecordContent(arg_636_1.text_.text)
			end

			local var_639_8 = math.max(var_639_1, arg_636_1.talkMaxDuration)

			if var_639_0 <= arg_636_1.time_ and arg_636_1.time_ < var_639_0 + var_639_8 then
				arg_636_1.typewritter.percent = (arg_636_1.time_ - var_639_0) / var_639_8

				arg_636_1.typewritter:SetDirty()
			end

			if arg_636_1.time_ >= var_639_0 + var_639_8 and arg_636_1.time_ < var_639_0 + var_639_8 + arg_639_0 then
				arg_636_1.typewritter.percent = 1

				arg_636_1.typewritter:SetDirty()
				arg_636_1:ShowNextGo(true)
			end
		end

		arg_636_1.nodeConfigList_ = {}

		arg_636_1:InitPlayNodeList()
	end,
	Play426101152 = function(arg_640_0, arg_640_1)
		arg_640_1.time_ = 0
		arg_640_1.frameCnt_ = 0
		arg_640_1.state_ = "playing"
		arg_640_1.curTalkId_ = 426101152
		arg_640_1.duration_ = 5

		SetActive(arg_640_1.tipsGo_, false)

		function arg_640_1.onSingleLineFinish_()
			arg_640_1.onSingleLineUpdate_ = nil
			arg_640_1.onSingleLineFinish_ = nil
			arg_640_1.state_ = "waiting"
		end

		function arg_640_1.playNext_(arg_642_0)
			if arg_642_0 == 1 then
				arg_640_0:Play426101153(arg_640_1)
			end
		end

		function arg_640_1.onSingleLineUpdate_(arg_643_0)
			local var_643_0 = 0
			local var_643_1 = 0.5

			if var_643_0 < arg_640_1.time_ and arg_640_1.time_ <= var_643_0 + arg_643_0 then
				arg_640_1.talkMaxDuration = 0
				arg_640_1.dialogCg_.alpha = 1

				arg_640_1.dialog_:SetActive(true)
				SetActive(arg_640_1.leftNameGo_, true)

				local var_643_2 = arg_640_1:FormatText(StoryNameCfg[7].name)

				arg_640_1.leftNameTxt_.text = var_643_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_640_1.leftNameTxt_.transform)

				arg_640_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_640_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_640_1:RecordName(arg_640_1.leftNameTxt_.text)
				SetActive(arg_640_1.iconTrs_.gameObject, true)
				arg_640_1.iconController_:SetSelectedState("hero")

				arg_640_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_640_1.callingController_:SetSelectedState("normal")

				arg_640_1.keyicon_.color = Color.New(1, 1, 1)
				arg_640_1.icon_.color = Color.New(1, 1, 1)

				local var_643_3 = arg_640_1:GetWordFromCfg(426101152)
				local var_643_4 = arg_640_1:FormatText(var_643_3.content)

				arg_640_1.text_.text = var_643_4

				LuaForUtil.ClearLinePrefixSymbol(arg_640_1.text_)

				local var_643_5 = 20
				local var_643_6 = utf8.len(var_643_4)
				local var_643_7 = var_643_5 <= 0 and var_643_1 or var_643_1 * (var_643_6 / var_643_5)

				if var_643_7 > 0 and var_643_1 < var_643_7 then
					arg_640_1.talkMaxDuration = var_643_7

					if var_643_7 + var_643_0 > arg_640_1.duration_ then
						arg_640_1.duration_ = var_643_7 + var_643_0
					end
				end

				arg_640_1.text_.text = var_643_4
				arg_640_1.typewritter.percent = 0

				arg_640_1.typewritter:SetDirty()
				arg_640_1:ShowNextGo(false)
				arg_640_1:RecordContent(arg_640_1.text_.text)
			end

			local var_643_8 = math.max(var_643_1, arg_640_1.talkMaxDuration)

			if var_643_0 <= arg_640_1.time_ and arg_640_1.time_ < var_643_0 + var_643_8 then
				arg_640_1.typewritter.percent = (arg_640_1.time_ - var_643_0) / var_643_8

				arg_640_1.typewritter:SetDirty()
			end

			if arg_640_1.time_ >= var_643_0 + var_643_8 and arg_640_1.time_ < var_643_0 + var_643_8 + arg_643_0 then
				arg_640_1.typewritter.percent = 1

				arg_640_1.typewritter:SetDirty()
				arg_640_1:ShowNextGo(true)
			end
		end

		arg_640_1.nodeConfigList_ = {}

		arg_640_1:InitPlayNodeList()
	end,
	Play426101153 = function(arg_644_0, arg_644_1)
		arg_644_1.time_ = 0
		arg_644_1.frameCnt_ = 0
		arg_644_1.state_ = "playing"
		arg_644_1.curTalkId_ = 426101153
		arg_644_1.duration_ = 3.4

		local var_644_0 = {
			zh = 1.999999999999,
			ja = 3.4
		}
		local var_644_1 = manager.audio:GetLocalizationFlag()

		if var_644_0[var_644_1] ~= nil then
			arg_644_1.duration_ = var_644_0[var_644_1]
		end

		SetActive(arg_644_1.tipsGo_, false)

		function arg_644_1.onSingleLineFinish_()
			arg_644_1.onSingleLineUpdate_ = nil
			arg_644_1.onSingleLineFinish_ = nil
			arg_644_1.state_ = "waiting"
		end

		function arg_644_1.playNext_(arg_646_0)
			if arg_646_0 == 1 then
				arg_644_0:Play426101154(arg_644_1)
			end
		end

		function arg_644_1.onSingleLineUpdate_(arg_647_0)
			local var_647_0 = arg_644_1.bgs_.SS2603.transform
			local var_647_1 = 0

			if var_647_1 < arg_644_1.time_ and arg_644_1.time_ <= var_647_1 + arg_647_0 then
				arg_644_1.var_.moveOldPosSS2603 = var_647_0.localPosition
			end

			local var_647_2 = 2

			if var_647_1 <= arg_644_1.time_ and arg_644_1.time_ < var_647_1 + var_647_2 then
				local var_647_3 = (arg_644_1.time_ - var_647_1) / var_647_2
				local var_647_4 = Vector3.New(-1.2, 1.6, 7.5)

				var_647_0.localPosition = Vector3.Lerp(arg_644_1.var_.moveOldPosSS2603, var_647_4, var_647_3)
			end

			if arg_644_1.time_ >= var_647_1 + var_647_2 and arg_644_1.time_ < var_647_1 + var_647_2 + arg_647_0 then
				var_647_0.localPosition = Vector3.New(-1.2, 1.6, 7.5)
			end

			local var_647_5 = 0
			local var_647_6 = 0.125

			if var_647_5 < arg_644_1.time_ and arg_644_1.time_ <= var_647_5 + arg_647_0 then
				arg_644_1.talkMaxDuration = 0
				arg_644_1.dialogCg_.alpha = 1

				arg_644_1.dialog_:SetActive(true)
				SetActive(arg_644_1.leftNameGo_, true)

				local var_647_7 = arg_644_1:FormatText(StoryNameCfg[1487].name)

				arg_644_1.leftNameTxt_.text = var_647_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_644_1.leftNameTxt_.transform)

				arg_644_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_644_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_644_1:RecordName(arg_644_1.leftNameTxt_.text)
				SetActive(arg_644_1.iconTrs_.gameObject, false)
				arg_644_1.callingController_:SetSelectedState("normal")

				local var_647_8 = arg_644_1:GetWordFromCfg(426101153)
				local var_647_9 = arg_644_1:FormatText(var_647_8.content)

				arg_644_1.text_.text = var_647_9

				LuaForUtil.ClearLinePrefixSymbol(arg_644_1.text_)

				local var_647_10 = 5
				local var_647_11 = utf8.len(var_647_9)
				local var_647_12 = var_647_10 <= 0 and var_647_6 or var_647_6 * (var_647_11 / var_647_10)

				if var_647_12 > 0 and var_647_6 < var_647_12 then
					arg_644_1.talkMaxDuration = var_647_12

					if var_647_12 + var_647_5 > arg_644_1.duration_ then
						arg_644_1.duration_ = var_647_12 + var_647_5
					end
				end

				arg_644_1.text_.text = var_647_9
				arg_644_1.typewritter.percent = 0

				arg_644_1.typewritter:SetDirty()
				arg_644_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426101", "426101153", "story_v_out_426101.awb") ~= 0 then
					local var_647_13 = manager.audio:GetVoiceLength("story_v_out_426101", "426101153", "story_v_out_426101.awb") / 1000

					if var_647_13 + var_647_5 > arg_644_1.duration_ then
						arg_644_1.duration_ = var_647_13 + var_647_5
					end

					if var_647_8.prefab_name ~= "" and arg_644_1.actors_[var_647_8.prefab_name] ~= nil then
						local var_647_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_644_1.actors_[var_647_8.prefab_name].transform, "story_v_out_426101", "426101153", "story_v_out_426101.awb")

						arg_644_1:RecordAudio("426101153", var_647_14)
						arg_644_1:RecordAudio("426101153", var_647_14)
					else
						arg_644_1:AudioAction("play", "voice", "story_v_out_426101", "426101153", "story_v_out_426101.awb")
					end

					arg_644_1:RecordHistoryTalkVoice("story_v_out_426101", "426101153", "story_v_out_426101.awb")
				end

				arg_644_1:RecordContent(arg_644_1.text_.text)
			end

			local var_647_15 = math.max(var_647_6, arg_644_1.talkMaxDuration)

			if var_647_5 <= arg_644_1.time_ and arg_644_1.time_ < var_647_5 + var_647_15 then
				arg_644_1.typewritter.percent = (arg_644_1.time_ - var_647_5) / var_647_15

				arg_644_1.typewritter:SetDirty()
			end

			if arg_644_1.time_ >= var_647_5 + var_647_15 and arg_644_1.time_ < var_647_5 + var_647_15 + arg_647_0 then
				arg_644_1.typewritter.percent = 1

				arg_644_1.typewritter:SetDirty()
				arg_644_1:ShowNextGo(true)
			end
		end

		arg_644_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "SS2603",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 2,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(-0.5, 1.5, 7.5),
					endPos = Vector3.New(-1.2, 1.6, 7.5),
					easeType = LeanTweenType.easeInOutQuint
				}
			}
		}

		arg_644_1:InitPlayNodeList()
	end,
	Play426101154 = function(arg_648_0, arg_648_1)
		arg_648_1.time_ = 0
		arg_648_1.frameCnt_ = 0
		arg_648_1.state_ = "playing"
		arg_648_1.curTalkId_ = 426101154
		arg_648_1.duration_ = 5

		SetActive(arg_648_1.tipsGo_, false)

		function arg_648_1.onSingleLineFinish_()
			arg_648_1.onSingleLineUpdate_ = nil
			arg_648_1.onSingleLineFinish_ = nil
			arg_648_1.state_ = "waiting"
		end

		function arg_648_1.playNext_(arg_650_0)
			if arg_650_0 == 1 then
				arg_648_0:Play426101155(arg_648_1)
			end
		end

		function arg_648_1.onSingleLineUpdate_(arg_651_0)
			local var_651_0 = 0
			local var_651_1 = 0.9

			if var_651_0 < arg_648_1.time_ and arg_648_1.time_ <= var_651_0 + arg_651_0 then
				arg_648_1.talkMaxDuration = 0
				arg_648_1.dialogCg_.alpha = 1

				arg_648_1.dialog_:SetActive(true)
				SetActive(arg_648_1.leftNameGo_, true)

				local var_651_2 = arg_648_1:FormatText(StoryNameCfg[7].name)

				arg_648_1.leftNameTxt_.text = var_651_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_648_1.leftNameTxt_.transform)

				arg_648_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_648_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_648_1:RecordName(arg_648_1.leftNameTxt_.text)
				SetActive(arg_648_1.iconTrs_.gameObject, true)
				arg_648_1.iconController_:SetSelectedState("hero")

				arg_648_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_648_1.callingController_:SetSelectedState("normal")

				arg_648_1.keyicon_.color = Color.New(1, 1, 1)
				arg_648_1.icon_.color = Color.New(1, 1, 1)

				local var_651_3 = arg_648_1:GetWordFromCfg(426101154)
				local var_651_4 = arg_648_1:FormatText(var_651_3.content)

				arg_648_1.text_.text = var_651_4

				LuaForUtil.ClearLinePrefixSymbol(arg_648_1.text_)

				local var_651_5 = 36
				local var_651_6 = utf8.len(var_651_4)
				local var_651_7 = var_651_5 <= 0 and var_651_1 or var_651_1 * (var_651_6 / var_651_5)

				if var_651_7 > 0 and var_651_1 < var_651_7 then
					arg_648_1.talkMaxDuration = var_651_7

					if var_651_7 + var_651_0 > arg_648_1.duration_ then
						arg_648_1.duration_ = var_651_7 + var_651_0
					end
				end

				arg_648_1.text_.text = var_651_4
				arg_648_1.typewritter.percent = 0

				arg_648_1.typewritter:SetDirty()
				arg_648_1:ShowNextGo(false)
				arg_648_1:RecordContent(arg_648_1.text_.text)
			end

			local var_651_8 = math.max(var_651_1, arg_648_1.talkMaxDuration)

			if var_651_0 <= arg_648_1.time_ and arg_648_1.time_ < var_651_0 + var_651_8 then
				arg_648_1.typewritter.percent = (arg_648_1.time_ - var_651_0) / var_651_8

				arg_648_1.typewritter:SetDirty()
			end

			if arg_648_1.time_ >= var_651_0 + var_651_8 and arg_648_1.time_ < var_651_0 + var_651_8 + arg_651_0 then
				arg_648_1.typewritter.percent = 1

				arg_648_1.typewritter:SetDirty()
				arg_648_1:ShowNextGo(true)
			end
		end

		arg_648_1.nodeConfigList_ = {}

		arg_648_1:InitPlayNodeList()
	end,
	Play426101155 = function(arg_652_0, arg_652_1)
		arg_652_1.time_ = 0
		arg_652_1.frameCnt_ = 0
		arg_652_1.state_ = "playing"
		arg_652_1.curTalkId_ = 426101155
		arg_652_1.duration_ = 5.3

		local var_652_0 = {
			zh = 1.999999999999,
			ja = 5.3
		}
		local var_652_1 = manager.audio:GetLocalizationFlag()

		if var_652_0[var_652_1] ~= nil then
			arg_652_1.duration_ = var_652_0[var_652_1]
		end

		SetActive(arg_652_1.tipsGo_, false)

		function arg_652_1.onSingleLineFinish_()
			arg_652_1.onSingleLineUpdate_ = nil
			arg_652_1.onSingleLineFinish_ = nil
			arg_652_1.state_ = "waiting"
		end

		function arg_652_1.playNext_(arg_654_0)
			if arg_654_0 == 1 then
				arg_652_0:Play426101156(arg_652_1)
			end
		end

		function arg_652_1.onSingleLineUpdate_(arg_655_0)
			local var_655_0 = arg_652_1.bgs_.SS2603.transform
			local var_655_1 = 0

			if var_655_1 < arg_652_1.time_ and arg_652_1.time_ <= var_655_1 + arg_655_0 then
				arg_652_1.var_.moveOldPosSS2603 = var_655_0.localPosition
			end

			local var_655_2 = 2

			if var_655_1 <= arg_652_1.time_ and arg_652_1.time_ < var_655_1 + var_655_2 then
				local var_655_3 = (arg_652_1.time_ - var_655_1) / var_655_2
				local var_655_4 = Vector3.New(0.15, 0.78, 7.5)

				var_655_0.localPosition = Vector3.Lerp(arg_652_1.var_.moveOldPosSS2603, var_655_4, var_655_3)
			end

			if arg_652_1.time_ >= var_655_1 + var_655_2 and arg_652_1.time_ < var_655_1 + var_655_2 + arg_655_0 then
				var_655_0.localPosition = Vector3.New(0.15, 0.78, 7.5)
			end

			local var_655_5 = 0
			local var_655_6 = 0.125

			if var_655_5 < arg_652_1.time_ and arg_652_1.time_ <= var_655_5 + arg_655_0 then
				arg_652_1.talkMaxDuration = 0
				arg_652_1.dialogCg_.alpha = 1

				arg_652_1.dialog_:SetActive(true)
				SetActive(arg_652_1.leftNameGo_, true)

				local var_655_7 = arg_652_1:FormatText(StoryNameCfg[1488].name)

				arg_652_1.leftNameTxt_.text = var_655_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_652_1.leftNameTxt_.transform)

				arg_652_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_652_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_652_1:RecordName(arg_652_1.leftNameTxt_.text)
				SetActive(arg_652_1.iconTrs_.gameObject, false)
				arg_652_1.callingController_:SetSelectedState("normal")

				local var_655_8 = arg_652_1:GetWordFromCfg(426101155)
				local var_655_9 = arg_652_1:FormatText(var_655_8.content)

				arg_652_1.text_.text = var_655_9

				LuaForUtil.ClearLinePrefixSymbol(arg_652_1.text_)

				local var_655_10 = 5
				local var_655_11 = utf8.len(var_655_9)
				local var_655_12 = var_655_10 <= 0 and var_655_6 or var_655_6 * (var_655_11 / var_655_10)

				if var_655_12 > 0 and var_655_6 < var_655_12 then
					arg_652_1.talkMaxDuration = var_655_12

					if var_655_12 + var_655_5 > arg_652_1.duration_ then
						arg_652_1.duration_ = var_655_12 + var_655_5
					end
				end

				arg_652_1.text_.text = var_655_9
				arg_652_1.typewritter.percent = 0

				arg_652_1.typewritter:SetDirty()
				arg_652_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426101", "426101155", "story_v_out_426101.awb") ~= 0 then
					local var_655_13 = manager.audio:GetVoiceLength("story_v_out_426101", "426101155", "story_v_out_426101.awb") / 1000

					if var_655_13 + var_655_5 > arg_652_1.duration_ then
						arg_652_1.duration_ = var_655_13 + var_655_5
					end

					if var_655_8.prefab_name ~= "" and arg_652_1.actors_[var_655_8.prefab_name] ~= nil then
						local var_655_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_652_1.actors_[var_655_8.prefab_name].transform, "story_v_out_426101", "426101155", "story_v_out_426101.awb")

						arg_652_1:RecordAudio("426101155", var_655_14)
						arg_652_1:RecordAudio("426101155", var_655_14)
					else
						arg_652_1:AudioAction("play", "voice", "story_v_out_426101", "426101155", "story_v_out_426101.awb")
					end

					arg_652_1:RecordHistoryTalkVoice("story_v_out_426101", "426101155", "story_v_out_426101.awb")
				end

				arg_652_1:RecordContent(arg_652_1.text_.text)
			end

			local var_655_15 = math.max(var_655_6, arg_652_1.talkMaxDuration)

			if var_655_5 <= arg_652_1.time_ and arg_652_1.time_ < var_655_5 + var_655_15 then
				arg_652_1.typewritter.percent = (arg_652_1.time_ - var_655_5) / var_655_15

				arg_652_1.typewritter:SetDirty()
			end

			if arg_652_1.time_ >= var_655_5 + var_655_15 and arg_652_1.time_ < var_655_5 + var_655_15 + arg_655_0 then
				arg_652_1.typewritter.percent = 1

				arg_652_1.typewritter:SetDirty()
				arg_652_1:ShowNextGo(true)
			end
		end

		arg_652_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "SS2603",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 2,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(-1.2, 1.6, 7.5),
					endPos = Vector3.New(0.15, 0.78, 7.5),
					easeType = LeanTweenType.easeInOutQuint
				}
			}
		}

		arg_652_1:InitPlayNodeList()
	end,
	Play426101156 = function(arg_656_0, arg_656_1)
		arg_656_1.time_ = 0
		arg_656_1.frameCnt_ = 0
		arg_656_1.state_ = "playing"
		arg_656_1.curTalkId_ = 426101156
		arg_656_1.duration_ = 4.3

		SetActive(arg_656_1.tipsGo_, false)

		function arg_656_1.onSingleLineFinish_()
			arg_656_1.onSingleLineUpdate_ = nil
			arg_656_1.onSingleLineFinish_ = nil
			arg_656_1.state_ = "waiting"
		end

		function arg_656_1.playNext_(arg_658_0)
			if arg_658_0 == 1 then
				arg_656_0:Play426101157(arg_656_1)
			end
		end

		function arg_656_1.onSingleLineUpdate_(arg_659_0)
			local var_659_0 = 2

			if var_659_0 < arg_656_1.time_ and arg_656_1.time_ <= var_659_0 + arg_659_0 then
				local var_659_1 = manager.ui.mainCamera.transform.localPosition
				local var_659_2 = Vector3.New(0, 0, 10) + Vector3.New(var_659_1.x, var_659_1.y, 0)
				local var_659_3 = arg_656_1.bgs_.STblack

				var_659_3.transform.localPosition = var_659_2
				var_659_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_659_4 = var_659_3:GetComponent("SpriteRenderer")

				if var_659_4 and var_659_4.sprite then
					local var_659_5 = (var_659_3.transform.localPosition - var_659_1).z
					local var_659_6 = manager.ui.mainCameraCom_
					local var_659_7 = 2 * var_659_5 * Mathf.Tan(var_659_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_659_8 = var_659_7 * var_659_6.aspect
					local var_659_9 = var_659_4.sprite.bounds.size.x
					local var_659_10 = var_659_4.sprite.bounds.size.y
					local var_659_11 = var_659_8 / var_659_9
					local var_659_12 = var_659_7 / var_659_10
					local var_659_13 = var_659_12 < var_659_11 and var_659_11 or var_659_12

					var_659_3.transform.localScale = Vector3.New(var_659_13, var_659_13, 0)
				end

				for iter_659_0, iter_659_1 in pairs(arg_656_1.bgs_) do
					if iter_659_0 ~= "STblack" then
						iter_659_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_659_14 = 4

			if var_659_14 < arg_656_1.time_ and arg_656_1.time_ <= var_659_14 + arg_659_0 then
				arg_656_1.allBtn_.enabled = false
			end

			local var_659_15 = 0.3

			if arg_656_1.time_ >= var_659_14 + var_659_15 and arg_656_1.time_ < var_659_14 + var_659_15 + arg_659_0 then
				arg_656_1.allBtn_.enabled = true
			end

			local var_659_16 = 0

			if var_659_16 < arg_656_1.time_ and arg_656_1.time_ <= var_659_16 + arg_659_0 then
				arg_656_1.mask_.enabled = true
				arg_656_1.mask_.raycastTarget = true

				arg_656_1:SetGaussion(false)
			end

			local var_659_17 = 2

			if var_659_16 <= arg_656_1.time_ and arg_656_1.time_ < var_659_16 + var_659_17 then
				local var_659_18 = (arg_656_1.time_ - var_659_16) / var_659_17
				local var_659_19 = Color.New(0, 0, 0)

				var_659_19.a = Mathf.Lerp(0, 1, var_659_18)
				arg_656_1.mask_.color = var_659_19
			end

			if arg_656_1.time_ >= var_659_16 + var_659_17 and arg_656_1.time_ < var_659_16 + var_659_17 + arg_659_0 then
				local var_659_20 = Color.New(0, 0, 0)

				var_659_20.a = 1
				arg_656_1.mask_.color = var_659_20
			end

			local var_659_21 = 2

			if var_659_21 < arg_656_1.time_ and arg_656_1.time_ <= var_659_21 + arg_659_0 then
				arg_656_1.mask_.enabled = true
				arg_656_1.mask_.raycastTarget = true

				arg_656_1:SetGaussion(false)
			end

			local var_659_22 = 2

			if var_659_21 <= arg_656_1.time_ and arg_656_1.time_ < var_659_21 + var_659_22 then
				local var_659_23 = (arg_656_1.time_ - var_659_21) / var_659_22
				local var_659_24 = Color.New(0, 0, 0)

				var_659_24.a = Mathf.Lerp(1, 0, var_659_23)
				arg_656_1.mask_.color = var_659_24
			end

			if arg_656_1.time_ >= var_659_21 + var_659_22 and arg_656_1.time_ < var_659_21 + var_659_22 + arg_659_0 then
				local var_659_25 = Color.New(0, 0, 0)
				local var_659_26 = 0

				arg_656_1.mask_.enabled = false
				var_659_25.a = var_659_26
				arg_656_1.mask_.color = var_659_25
			end

			local var_659_27 = manager.ui.mainCamera.transform
			local var_659_28 = 0

			if var_659_28 < arg_656_1.time_ and arg_656_1.time_ <= var_659_28 + arg_659_0 then
				local var_659_29 = arg_656_1.var_.effectbiyanshuizhao1
				local var_659_30
				local var_659_31 = var_659_27

				if not var_659_29 then
					var_659_29 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_snapshut"), var_659_31)
					var_659_29.name = "biyanshuizhao1"
					arg_656_1.var_.effectbiyanshuizhao1 = var_659_29
				else
					var_659_29.transform:SetParent(var_659_31)
				end

				var_659_29.transform.localPosition = Vector3.New(0, 0, 0)
				var_659_29.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_659_32 = manager.ui.mainCamera.transform
			local var_659_33 = 2

			if var_659_33 < arg_656_1.time_ and arg_656_1.time_ <= var_659_33 + arg_659_0 then
				local var_659_34 = arg_656_1.var_.effectbiyanshuizhao1

				if var_659_34 then
					Object.Destroy(var_659_34)

					arg_656_1.var_.effectbiyanshuizhao1 = nil
				end
			end

			local var_659_35 = 0

			if var_659_35 < arg_656_1.time_ and arg_656_1.time_ <= var_659_35 + arg_659_0 then
				arg_656_1.fswbg_:SetActive(false)
				arg_656_1.dialog_:SetActive(false)
				SetActive(arg_656_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_656_1:ShowNextGo(false)
			end
		end

		arg_656_1.nodeConfigList_ = {
			{
				displayDialog = true,
				enableBgChange = false,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				enableEffect = true,
				contentID = 426101156,
				charCount = 8,
				enableLayoutChange = true,
				duration = 0.533333333333333,
				groupID = "biyanshuijiao12",
				startTime = 2.9,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.CREATE_TEXT_GROUP,
				layoutData = {
					topPadding = 0,
					bottomPadding = 0,
					rightPadding = 0,
					leftPadding = 0,
					paragraphSpacing = 0,
					offsetMin = Vector2.New(100, 256),
					offsetMax = Vector2.New(-100, -140),
					paragraphAlignment = UnityEngine.TextAnchor.MiddleLeft
				},
				textComProperty = {
					fontSize = 36,
					fontAssetPath = "Fonts/SourceHanSans",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.UpperCenter
				},
				effectData = {
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.TYPE_WRITER
				}
			}
		}

		arg_656_1:InitPlayNodeList()
	end,
	Play426101157 = function(arg_660_0, arg_660_1)
		arg_660_1.time_ = 0
		arg_660_1.frameCnt_ = 0
		arg_660_1.state_ = "playing"
		arg_660_1.curTalkId_ = 426101157
		arg_660_1.duration_ = 1

		SetActive(arg_660_1.tipsGo_, false)

		function arg_660_1.onSingleLineFinish_()
			arg_660_1.onSingleLineUpdate_ = nil
			arg_660_1.onSingleLineFinish_ = nil
			arg_660_1.state_ = "waiting"
			arg_660_1.auto_ = false
		end

		function arg_660_1.playNext_(arg_662_0)
			arg_660_1.onStoryFinished_()
		end

		function arg_660_1.onSingleLineUpdate_(arg_663_0)
			return
		end

		arg_660_1.nodeConfigList_ = {
			{
				displayDialog = true,
				enableBgChange = false,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				enableEffect = true,
				contentID = 426101157,
				charCount = 2,
				enableLayoutChange = true,
				duration = 0.133333333333333,
				groupID = "biyanshuijiao13",
				startTime = 0,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.CREATE_TEXT_GROUP,
				layoutData = {
					topPadding = 0,
					bottomPadding = 0,
					rightPadding = 0,
					leftPadding = 0,
					paragraphSpacing = 0,
					offsetMin = Vector2.New(100, 256),
					offsetMax = Vector2.New(-100, -140),
					paragraphAlignment = UnityEngine.TextAnchor.MiddleLeft
				},
				textComProperty = {
					fontSize = 36,
					fontAssetPath = "Fonts/SourceHanSans",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.UpperCenter
				},
				effectData = {
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.TYPE_WRITER
				}
			}
		}

		arg_660_1:InitPlayNodeList()
	end,
	Play426101139 = function(arg_664_0, arg_664_1)
		arg_664_1.time_ = 0
		arg_664_1.frameCnt_ = 0
		arg_664_1.state_ = "playing"
		arg_664_1.curTalkId_ = 426101139
		arg_664_1.duration_ = 6.47

		local var_664_0 = {
			zh = 5.733,
			ja = 6.466
		}
		local var_664_1 = manager.audio:GetLocalizationFlag()

		if var_664_0[var_664_1] ~= nil then
			arg_664_1.duration_ = var_664_0[var_664_1]
		end

		SetActive(arg_664_1.tipsGo_, false)

		function arg_664_1.onSingleLineFinish_()
			arg_664_1.onSingleLineUpdate_ = nil
			arg_664_1.onSingleLineFinish_ = nil
			arg_664_1.state_ = "waiting"
		end

		function arg_664_1.playNext_(arg_666_0)
			if arg_666_0 == 1 then
				arg_664_0:Play426101140(arg_664_1)
			end
		end

		function arg_664_1.onSingleLineUpdate_(arg_667_0)
			local var_667_0 = 0
			local var_667_1 = 0.6

			if var_667_0 < arg_664_1.time_ and arg_664_1.time_ <= var_667_0 + arg_667_0 then
				arg_664_1.talkMaxDuration = 0
				arg_664_1.dialogCg_.alpha = 1

				arg_664_1.dialog_:SetActive(true)
				SetActive(arg_664_1.leftNameGo_, true)

				local var_667_2 = arg_664_1:FormatText(StoryNameCfg[1488].name)

				arg_664_1.leftNameTxt_.text = var_667_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_664_1.leftNameTxt_.transform)

				arg_664_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_664_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_664_1:RecordName(arg_664_1.leftNameTxt_.text)
				SetActive(arg_664_1.iconTrs_.gameObject, false)
				arg_664_1.callingController_:SetSelectedState("normal")

				local var_667_3 = arg_664_1:GetWordFromCfg(426101139)
				local var_667_4 = arg_664_1:FormatText(var_667_3.content)

				arg_664_1.text_.text = var_667_4

				LuaForUtil.ClearLinePrefixSymbol(arg_664_1.text_)

				local var_667_5 = 24
				local var_667_6 = utf8.len(var_667_4)
				local var_667_7 = var_667_5 <= 0 and var_667_1 or var_667_1 * (var_667_6 / var_667_5)

				if var_667_7 > 0 and var_667_1 < var_667_7 then
					arg_664_1.talkMaxDuration = var_667_7

					if var_667_7 + var_667_0 > arg_664_1.duration_ then
						arg_664_1.duration_ = var_667_7 + var_667_0
					end
				end

				arg_664_1.text_.text = var_667_4
				arg_664_1.typewritter.percent = 0

				arg_664_1.typewritter:SetDirty()
				arg_664_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426101", "426101139", "story_v_out_426101.awb") ~= 0 then
					local var_667_8 = manager.audio:GetVoiceLength("story_v_out_426101", "426101139", "story_v_out_426101.awb") / 1000

					if var_667_8 + var_667_0 > arg_664_1.duration_ then
						arg_664_1.duration_ = var_667_8 + var_667_0
					end

					if var_667_3.prefab_name ~= "" and arg_664_1.actors_[var_667_3.prefab_name] ~= nil then
						local var_667_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_664_1.actors_[var_667_3.prefab_name].transform, "story_v_out_426101", "426101139", "story_v_out_426101.awb")

						arg_664_1:RecordAudio("426101139", var_667_9)
						arg_664_1:RecordAudio("426101139", var_667_9)
					else
						arg_664_1:AudioAction("play", "voice", "story_v_out_426101", "426101139", "story_v_out_426101.awb")
					end

					arg_664_1:RecordHistoryTalkVoice("story_v_out_426101", "426101139", "story_v_out_426101.awb")
				end

				arg_664_1:RecordContent(arg_664_1.text_.text)
			end

			local var_667_10 = math.max(var_667_1, arg_664_1.talkMaxDuration)

			if var_667_0 <= arg_664_1.time_ and arg_664_1.time_ < var_667_0 + var_667_10 then
				arg_664_1.typewritter.percent = (arg_664_1.time_ - var_667_0) / var_667_10

				arg_664_1.typewritter:SetDirty()
			end

			if arg_664_1.time_ >= var_667_0 + var_667_10 and arg_664_1.time_ < var_667_0 + var_667_10 + arg_667_0 then
				arg_664_1.typewritter.percent = 1

				arg_664_1.typewritter:SetDirty()
				arg_664_1:ShowNextGo(true)
			end
		end

		arg_664_1.nodeConfigList_ = {}

		arg_664_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/J27g",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/SS2601",
		"TextureConfig/Background/ST2007a",
		"TextureConfig/Background/ST2012",
		"TextureConfig/Background/SS2603"
	},
	voices = {
		"story_v_out_426101.awb"
	}
}
