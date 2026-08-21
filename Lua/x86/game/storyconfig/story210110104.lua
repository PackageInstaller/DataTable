return {
	Play1101104001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 1101104001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play1101104002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "B13"

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
				local var_4_5 = arg_1_1.bgs_.B13

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
					if iter_4_0 ~= "B13" then
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
			local var_4_23 = 0.3

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

			local var_4_28 = 0.533333333333333
			local var_4_29 = 1

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				local var_4_30 = "play"
				local var_4_31 = "music"

				arg_1_1:AudioAction(var_4_30, var_4_31, "bgm_side_daily02", "bgm_side_daily02", "bgm_side_daily02.awb")

				local var_4_32 = ""
				local var_4_33 = manager.audio:GetAudioName("bgm_side_daily02", "bgm_side_daily02")

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
			local var_4_35 = 0.6

			if var_4_34 < arg_1_1.time_ and arg_1_1.time_ <= var_4_34 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_36 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_36:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_36:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_36:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_37 = arg_1_1:GetWordFromCfg(1101104001)
				local var_4_38 = arg_1_1:FormatText(var_4_37.content)

				arg_1_1.text_.text = var_4_38

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_39 = 24
				local var_4_40 = utf8.len(var_4_38)
				local var_4_41 = var_4_39 <= 0 and var_4_35 or var_4_35 * (var_4_40 / var_4_39)

				if var_4_41 > 0 and var_4_35 < var_4_41 then
					arg_1_1.talkMaxDuration = var_4_41
					var_4_34 = var_4_34 + 0.3

					if var_4_41 + var_4_34 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_41 + var_4_34
					end
				end

				arg_1_1.text_.text = var_4_38
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_42 = var_4_34 + 0.3
			local var_4_43 = math.max(var_4_35, arg_1_1.talkMaxDuration)

			if var_4_42 <= arg_1_1.time_ and arg_1_1.time_ < var_4_42 + var_4_43 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_42) / var_4_43

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_42 + var_4_43 and arg_1_1.time_ < var_4_42 + var_4_43 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play1101104002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 1101104002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play1101104003(arg_9_1)
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

				local var_12_2 = arg_9_1:GetWordFromCfg(1101104002)
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
	Play1101104003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 1101104003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play1101104004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0
			local var_16_1 = 0.5

			if var_16_0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, false)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_2 = arg_13_1:GetWordFromCfg(1101104003)
				local var_16_3 = arg_13_1:FormatText(var_16_2.content)

				arg_13_1.text_.text = var_16_3

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_4 = 20
				local var_16_5 = utf8.len(var_16_3)
				local var_16_6 = var_16_4 <= 0 and var_16_1 or var_16_1 * (var_16_5 / var_16_4)

				if var_16_6 > 0 and var_16_1 < var_16_6 then
					arg_13_1.talkMaxDuration = var_16_6

					if var_16_6 + var_16_0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_6 + var_16_0
					end
				end

				arg_13_1.text_.text = var_16_3
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_7 = math.max(var_16_1, arg_13_1.talkMaxDuration)

			if var_16_0 <= arg_13_1.time_ and arg_13_1.time_ < var_16_0 + var_16_7 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_0) / var_16_7

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_0 + var_16_7 and arg_13_1.time_ < var_16_0 + var_16_7 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play1101104004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 1101104004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play1101104005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0
			local var_20_1 = 0.175

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

				local var_20_3 = arg_17_1:GetWordFromCfg(1101104004)
				local var_20_4 = arg_17_1:FormatText(var_20_3.content)

				arg_17_1.text_.text = var_20_4

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_5 = 7
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
	Play1101104005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 1101104005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play1101104006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0
			local var_24_1 = 1

			if var_24_0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_0 + arg_24_0 then
				local var_24_2 = "play"
				local var_24_3 = "effect"

				arg_21_1:AudioAction(var_24_2, var_24_3, "se_story_side_1080", "se_story_1080_knock", "")
			end

			local var_24_4 = 0
			local var_24_5 = 1.05

			if var_24_4 < arg_21_1.time_ and arg_21_1.time_ <= var_24_4 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, false)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_6 = arg_21_1:GetWordFromCfg(1101104005)
				local var_24_7 = arg_21_1:FormatText(var_24_6.content)

				arg_21_1.text_.text = var_24_7

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_8 = 44
				local var_24_9 = utf8.len(var_24_7)
				local var_24_10 = var_24_8 <= 0 and var_24_5 or var_24_5 * (var_24_9 / var_24_8)

				if var_24_10 > 0 and var_24_5 < var_24_10 then
					arg_21_1.talkMaxDuration = var_24_10

					if var_24_10 + var_24_4 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_10 + var_24_4
					end
				end

				arg_21_1.text_.text = var_24_7
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_11 = math.max(var_24_5, arg_21_1.talkMaxDuration)

			if var_24_4 <= arg_21_1.time_ and arg_21_1.time_ < var_24_4 + var_24_11 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_4) / var_24_11

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_4 + var_24_11 and arg_21_1.time_ < var_24_4 + var_24_11 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play1101104006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 1101104006
		arg_25_1.duration_ = 8.4

		local var_25_0 = {
			zh = 7.533,
			ja = 8.4
		}
		local var_25_1 = manager.audio:GetLocalizationFlag()

		if var_25_0[var_25_1] ~= nil then
			arg_25_1.duration_ = var_25_0[var_25_1]
		end

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play1101104007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0
			local var_28_1 = 0.95

			if var_28_0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_0 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_2 = arg_25_1:FormatText(StoryNameCfg[67].name)

				arg_25_1.leftNameTxt_.text = var_28_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, true)
				arg_25_1.iconController_:SetSelectedState("hero")

				arg_25_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1111")

				arg_25_1.callingController_:SetSelectedState("normal")

				arg_25_1.keyicon_.color = Color.New(1, 1, 1)
				arg_25_1.icon_.color = Color.New(1, 1, 1)

				local var_28_3 = arg_25_1:GetWordFromCfg(1101104006)
				local var_28_4 = arg_25_1:FormatText(var_28_3.content)

				arg_25_1.text_.text = var_28_4

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_5 = 38
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

				if manager.audio:GetVoiceLength("story_v_side_new_1101104", "1101104006", "story_v_side_new_1101104.awb") ~= 0 then
					local var_28_8 = manager.audio:GetVoiceLength("story_v_side_new_1101104", "1101104006", "story_v_side_new_1101104.awb") / 1000

					if var_28_8 + var_28_0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_8 + var_28_0
					end

					if var_28_3.prefab_name ~= "" and arg_25_1.actors_[var_28_3.prefab_name] ~= nil then
						local var_28_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_3.prefab_name].transform, "story_v_side_new_1101104", "1101104006", "story_v_side_new_1101104.awb")

						arg_25_1:RecordAudio("1101104006", var_28_9)
						arg_25_1:RecordAudio("1101104006", var_28_9)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_side_new_1101104", "1101104006", "story_v_side_new_1101104.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_side_new_1101104", "1101104006", "story_v_side_new_1101104.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_10 = math.max(var_28_1, arg_25_1.talkMaxDuration)

			if var_28_0 <= arg_25_1.time_ and arg_25_1.time_ < var_28_0 + var_28_10 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_0) / var_28_10

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_0 + var_28_10 and arg_25_1.time_ < var_28_0 + var_28_10 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play1101104007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 1101104007
		arg_29_1.duration_ = 9

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play1101104008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = "ST01"

			if arg_29_1.bgs_[var_32_0] == nil then
				local var_32_1 = Object.Instantiate(arg_29_1.paintGo_)

				var_32_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_32_0)
				var_32_1.name = var_32_0
				var_32_1.transform.parent = arg_29_1.stage_.transform
				var_32_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_29_1.bgs_[var_32_0] = var_32_1
			end

			local var_32_2 = 2

			if var_32_2 < arg_29_1.time_ and arg_29_1.time_ <= var_32_2 + arg_32_0 then
				local var_32_3 = manager.ui.mainCamera.transform.localPosition
				local var_32_4 = Vector3.New(0, 0, 10) + Vector3.New(var_32_3.x, var_32_3.y, 0)
				local var_32_5 = arg_29_1.bgs_.ST01

				var_32_5.transform.localPosition = var_32_4
				var_32_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_32_6 = var_32_5:GetComponent("SpriteRenderer")

				if var_32_6 and var_32_6.sprite then
					local var_32_7 = (var_32_5.transform.localPosition - var_32_3).z
					local var_32_8 = manager.ui.mainCameraCom_
					local var_32_9 = 2 * var_32_7 * Mathf.Tan(var_32_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_32_10 = var_32_9 * var_32_8.aspect
					local var_32_11 = var_32_6.sprite.bounds.size.x
					local var_32_12 = var_32_6.sprite.bounds.size.y
					local var_32_13 = var_32_10 / var_32_11
					local var_32_14 = var_32_9 / var_32_12
					local var_32_15 = var_32_14 < var_32_13 and var_32_13 or var_32_14

					var_32_5.transform.localScale = Vector3.New(var_32_15, var_32_15, 0)
				end

				for iter_32_0, iter_32_1 in pairs(arg_29_1.bgs_) do
					if iter_32_0 ~= "ST01" then
						iter_32_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_32_16 = 0

			if var_32_16 < arg_29_1.time_ and arg_29_1.time_ <= var_32_16 + arg_32_0 then
				arg_29_1.mask_.enabled = true
				arg_29_1.mask_.raycastTarget = true

				arg_29_1:SetGaussion(false)
			end

			local var_32_17 = 2

			if var_32_16 <= arg_29_1.time_ and arg_29_1.time_ < var_32_16 + var_32_17 then
				local var_32_18 = (arg_29_1.time_ - var_32_16) / var_32_17
				local var_32_19 = Color.New(0, 0, 0)

				var_32_19.a = Mathf.Lerp(0, 1, var_32_18)
				arg_29_1.mask_.color = var_32_19
			end

			if arg_29_1.time_ >= var_32_16 + var_32_17 and arg_29_1.time_ < var_32_16 + var_32_17 + arg_32_0 then
				local var_32_20 = Color.New(0, 0, 0)

				var_32_20.a = 1
				arg_29_1.mask_.color = var_32_20
			end

			local var_32_21 = 2

			if var_32_21 < arg_29_1.time_ and arg_29_1.time_ <= var_32_21 + arg_32_0 then
				arg_29_1.mask_.enabled = true
				arg_29_1.mask_.raycastTarget = true

				arg_29_1:SetGaussion(false)
			end

			local var_32_22 = 2

			if var_32_21 <= arg_29_1.time_ and arg_29_1.time_ < var_32_21 + var_32_22 then
				local var_32_23 = (arg_29_1.time_ - var_32_21) / var_32_22
				local var_32_24 = Color.New(0, 0, 0)

				var_32_24.a = Mathf.Lerp(1, 0, var_32_23)
				arg_29_1.mask_.color = var_32_24
			end

			if arg_29_1.time_ >= var_32_21 + var_32_22 and arg_29_1.time_ < var_32_21 + var_32_22 + arg_32_0 then
				local var_32_25 = Color.New(0, 0, 0)
				local var_32_26 = 0

				arg_29_1.mask_.enabled = false
				var_32_25.a = var_32_26
				arg_29_1.mask_.color = var_32_25
			end

			local var_32_27 = "1111ui_story"

			if arg_29_1.actors_[var_32_27] == nil then
				local var_32_28 = Asset.Load("Char/" .. "1111ui_story")

				if not isNil(var_32_28) then
					local var_32_29 = Object.Instantiate(Asset.Load("Char/" .. "1111ui_story"), arg_29_1.stage_.transform)

					var_32_29.name = var_32_27
					var_32_29.transform.localPosition = Vector3.New(0, 100, 0)
					arg_29_1.actors_[var_32_27] = var_32_29

					local var_32_30 = var_32_29:GetComponentInChildren(typeof(CharacterEffect))

					var_32_30.enabled = true

					local var_32_31 = GameObjectTools.GetOrAddComponent(var_32_29, typeof(DynamicBoneHelper))

					if var_32_31 then
						var_32_31:EnableDynamicBone(false)
					end

					arg_29_1:ShowWeapon(var_32_30.transform, false)

					arg_29_1.var_[var_32_27 .. "Animator"] = var_32_30.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_29_1.var_[var_32_27 .. "Animator"].applyRootMotion = true
					arg_29_1.var_[var_32_27 .. "LipSync"] = var_32_30.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_32_32 = arg_29_1.actors_["1111ui_story"].transform
			local var_32_33 = 2

			if var_32_33 < arg_29_1.time_ and arg_29_1.time_ <= var_32_33 + arg_32_0 then
				arg_29_1.var_.moveOldPos1111ui_story = var_32_32.localPosition
			end

			local var_32_34 = 0.001

			if var_32_33 <= arg_29_1.time_ and arg_29_1.time_ < var_32_33 + var_32_34 then
				local var_32_35 = (arg_29_1.time_ - var_32_33) / var_32_34
				local var_32_36 = Vector3.New(0, -0.87, -5.7)

				var_32_32.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos1111ui_story, var_32_36, var_32_35)

				local var_32_37 = manager.ui.mainCamera.transform.position - var_32_32.position

				var_32_32.forward = Vector3.New(var_32_37.x, var_32_37.y, var_32_37.z)

				local var_32_38 = var_32_32.localEulerAngles

				var_32_38.z = 0
				var_32_38.x = 0
				var_32_32.localEulerAngles = var_32_38
			end

			if arg_29_1.time_ >= var_32_33 + var_32_34 and arg_29_1.time_ < var_32_33 + var_32_34 + arg_32_0 then
				var_32_32.localPosition = Vector3.New(0, -0.87, -5.7)

				local var_32_39 = manager.ui.mainCamera.transform.position - var_32_32.position

				var_32_32.forward = Vector3.New(var_32_39.x, var_32_39.y, var_32_39.z)

				local var_32_40 = var_32_32.localEulerAngles

				var_32_40.z = 0
				var_32_40.x = 0
				var_32_32.localEulerAngles = var_32_40
			end

			local var_32_41 = arg_29_1.actors_["1111ui_story"]
			local var_32_42 = 2

			if var_32_42 < arg_29_1.time_ and arg_29_1.time_ <= var_32_42 + arg_32_0 and not isNil(var_32_41) and arg_29_1.var_.characterEffect1111ui_story == nil then
				arg_29_1.var_.characterEffect1111ui_story = var_32_41:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_43 = 0.200000002980232

			if var_32_42 <= arg_29_1.time_ and arg_29_1.time_ < var_32_42 + var_32_43 and not isNil(var_32_41) then
				local var_32_44 = (arg_29_1.time_ - var_32_42) / var_32_43

				if arg_29_1.var_.characterEffect1111ui_story and not isNil(var_32_41) then
					local var_32_45 = Mathf.Lerp(0, 0.5, var_32_44)

					arg_29_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_29_1.var_.characterEffect1111ui_story.fillRatio = var_32_45
				end
			end

			if arg_29_1.time_ >= var_32_42 + var_32_43 and arg_29_1.time_ < var_32_42 + var_32_43 + arg_32_0 and not isNil(var_32_41) and arg_29_1.var_.characterEffect1111ui_story then
				local var_32_46 = 0.5

				arg_29_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_29_1.var_.characterEffect1111ui_story.fillRatio = var_32_46
			end

			local var_32_47 = 2

			if var_32_47 < arg_29_1.time_ and arg_29_1.time_ <= var_32_47 + arg_32_0 then
				arg_29_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action1_1")
			end

			if arg_29_1.frameCnt_ <= 1 then
				arg_29_1.dialog_:SetActive(false)
			end

			local var_32_48 = 4
			local var_32_49 = 0.9

			if var_32_48 < arg_29_1.time_ and arg_29_1.time_ <= var_32_48 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0

				arg_29_1.dialog_:SetActive(true)

				arg_29_1.dialogCg_.alpha = 0

				local var_32_50 = LeanTween.value(arg_29_1.dialog_, 0, 1, 0.3)

				var_32_50:setOnUpdate(LuaHelper.FloatAction(function(arg_33_0)
					arg_29_1.dialogCg_.alpha = arg_33_0
				end))
				var_32_50:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_29_1.dialog_)
					var_32_50:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_29_1.duration_ = arg_29_1.duration_ + 0.3

				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_51 = arg_29_1:FormatText(StoryNameCfg[7].name)

				arg_29_1.leftNameTxt_.text = var_32_51

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

				local var_32_52 = arg_29_1:GetWordFromCfg(1101104007)
				local var_32_53 = arg_29_1:FormatText(var_32_52.content)

				arg_29_1.text_.text = var_32_53

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_54 = 45
				local var_32_55 = utf8.len(var_32_53)
				local var_32_56 = var_32_54 <= 0 and var_32_49 or var_32_49 * (var_32_55 / var_32_54)

				if var_32_56 > 0 and var_32_49 < var_32_56 then
					arg_29_1.talkMaxDuration = var_32_56
					var_32_48 = var_32_48 + 0.3

					if var_32_56 + var_32_48 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_56 + var_32_48
					end
				end

				arg_29_1.text_.text = var_32_53
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_57 = var_32_48 + 0.3
			local var_32_58 = math.max(var_32_49, arg_29_1.talkMaxDuration)

			if var_32_57 <= arg_29_1.time_ and arg_29_1.time_ < var_32_57 + var_32_58 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_57) / var_32_58

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_57 + var_32_58 and arg_29_1.time_ < var_32_57 + var_32_58 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_29_1:InitPlayNodeList()
	end,
	Play1101104008 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 1101104008
		arg_35_1.duration_ = 9.37

		local var_35_0 = {
			zh = 5.7,
			ja = 9.366
		}
		local var_35_1 = manager.audio:GetLocalizationFlag()

		if var_35_0[var_35_1] ~= nil then
			arg_35_1.duration_ = var_35_0[var_35_1]
		end

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play1101104009(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			local var_38_0 = arg_35_1.actors_["1111ui_story"].transform
			local var_38_1 = 0

			if var_38_1 < arg_35_1.time_ and arg_35_1.time_ <= var_38_1 + arg_38_0 then
				arg_35_1.var_.moveOldPos1111ui_story = var_38_0.localPosition
			end

			local var_38_2 = 0.001

			if var_38_1 <= arg_35_1.time_ and arg_35_1.time_ < var_38_1 + var_38_2 then
				local var_38_3 = (arg_35_1.time_ - var_38_1) / var_38_2
				local var_38_4 = Vector3.New(0, -0.87, -5.7)

				var_38_0.localPosition = Vector3.Lerp(arg_35_1.var_.moveOldPos1111ui_story, var_38_4, var_38_3)

				local var_38_5 = manager.ui.mainCamera.transform.position - var_38_0.position

				var_38_0.forward = Vector3.New(var_38_5.x, var_38_5.y, var_38_5.z)

				local var_38_6 = var_38_0.localEulerAngles

				var_38_6.z = 0
				var_38_6.x = 0
				var_38_0.localEulerAngles = var_38_6
			end

			if arg_35_1.time_ >= var_38_1 + var_38_2 and arg_35_1.time_ < var_38_1 + var_38_2 + arg_38_0 then
				var_38_0.localPosition = Vector3.New(0, -0.87, -5.7)

				local var_38_7 = manager.ui.mainCamera.transform.position - var_38_0.position

				var_38_0.forward = Vector3.New(var_38_7.x, var_38_7.y, var_38_7.z)

				local var_38_8 = var_38_0.localEulerAngles

				var_38_8.z = 0
				var_38_8.x = 0
				var_38_0.localEulerAngles = var_38_8
			end

			local var_38_9 = arg_35_1.actors_["1111ui_story"]
			local var_38_10 = 0

			if var_38_10 < arg_35_1.time_ and arg_35_1.time_ <= var_38_10 + arg_38_0 and not isNil(var_38_9) and arg_35_1.var_.characterEffect1111ui_story == nil then
				arg_35_1.var_.characterEffect1111ui_story = var_38_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_38_11 = 0.200000002980232

			if var_38_10 <= arg_35_1.time_ and arg_35_1.time_ < var_38_10 + var_38_11 and not isNil(var_38_9) then
				local var_38_12 = (arg_35_1.time_ - var_38_10) / var_38_11

				if arg_35_1.var_.characterEffect1111ui_story and not isNil(var_38_9) then
					arg_35_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_35_1.time_ >= var_38_10 + var_38_11 and arg_35_1.time_ < var_38_10 + var_38_11 + arg_38_0 and not isNil(var_38_9) and arg_35_1.var_.characterEffect1111ui_story then
				arg_35_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_38_13 = 0

			if var_38_13 < arg_35_1.time_ and arg_35_1.time_ <= var_38_13 + arg_38_0 then
				arg_35_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action2_1")
			end

			local var_38_14 = 0

			if var_38_14 < arg_35_1.time_ and arg_35_1.time_ <= var_38_14 + arg_38_0 then
				arg_35_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_38_15 = 0
			local var_38_16 = 0.55

			if var_38_15 < arg_35_1.time_ and arg_35_1.time_ <= var_38_15 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, true)

				local var_38_17 = arg_35_1:FormatText(StoryNameCfg[67].name)

				arg_35_1.leftNameTxt_.text = var_38_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_35_1.leftNameTxt_.transform)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1.leftNameTxt_.text)
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_18 = arg_35_1:GetWordFromCfg(1101104008)
				local var_38_19 = arg_35_1:FormatText(var_38_18.content)

				arg_35_1.text_.text = var_38_19

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_20 = 22
				local var_38_21 = utf8.len(var_38_19)
				local var_38_22 = var_38_20 <= 0 and var_38_16 or var_38_16 * (var_38_21 / var_38_20)

				if var_38_22 > 0 and var_38_16 < var_38_22 then
					arg_35_1.talkMaxDuration = var_38_22

					if var_38_22 + var_38_15 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_22 + var_38_15
					end
				end

				arg_35_1.text_.text = var_38_19
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101104", "1101104008", "story_v_side_new_1101104.awb") ~= 0 then
					local var_38_23 = manager.audio:GetVoiceLength("story_v_side_new_1101104", "1101104008", "story_v_side_new_1101104.awb") / 1000

					if var_38_23 + var_38_15 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_23 + var_38_15
					end

					if var_38_18.prefab_name ~= "" and arg_35_1.actors_[var_38_18.prefab_name] ~= nil then
						local var_38_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_35_1.actors_[var_38_18.prefab_name].transform, "story_v_side_new_1101104", "1101104008", "story_v_side_new_1101104.awb")

						arg_35_1:RecordAudio("1101104008", var_38_24)
						arg_35_1:RecordAudio("1101104008", var_38_24)
					else
						arg_35_1:AudioAction("play", "voice", "story_v_side_new_1101104", "1101104008", "story_v_side_new_1101104.awb")
					end

					arg_35_1:RecordHistoryTalkVoice("story_v_side_new_1101104", "1101104008", "story_v_side_new_1101104.awb")
				end

				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_25 = math.max(var_38_16, arg_35_1.talkMaxDuration)

			if var_38_15 <= arg_35_1.time_ and arg_35_1.time_ < var_38_15 + var_38_25 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_15) / var_38_25

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_15 + var_38_25 and arg_35_1.time_ < var_38_15 + var_38_25 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_35_1:InitPlayNodeList()
	end,
	Play1101104009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 1101104009
		arg_39_1.duration_ = 5

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play1101104010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			local var_42_0 = arg_39_1.actors_["1111ui_story"]
			local var_42_1 = 0

			if var_42_1 < arg_39_1.time_ and arg_39_1.time_ <= var_42_1 + arg_42_0 and not isNil(var_42_0) and arg_39_1.var_.characterEffect1111ui_story == nil then
				arg_39_1.var_.characterEffect1111ui_story = var_42_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_42_2 = 0.200000002980232

			if var_42_1 <= arg_39_1.time_ and arg_39_1.time_ < var_42_1 + var_42_2 and not isNil(var_42_0) then
				local var_42_3 = (arg_39_1.time_ - var_42_1) / var_42_2

				if arg_39_1.var_.characterEffect1111ui_story and not isNil(var_42_0) then
					local var_42_4 = Mathf.Lerp(0, 0.5, var_42_3)

					arg_39_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_39_1.var_.characterEffect1111ui_story.fillRatio = var_42_4
				end
			end

			if arg_39_1.time_ >= var_42_1 + var_42_2 and arg_39_1.time_ < var_42_1 + var_42_2 + arg_42_0 and not isNil(var_42_0) and arg_39_1.var_.characterEffect1111ui_story then
				local var_42_5 = 0.5

				arg_39_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_39_1.var_.characterEffect1111ui_story.fillRatio = var_42_5
			end

			local var_42_6 = 0
			local var_42_7 = 0.45

			if var_42_6 < arg_39_1.time_ and arg_39_1.time_ <= var_42_6 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, true)

				local var_42_8 = arg_39_1:FormatText(StoryNameCfg[7].name)

				arg_39_1.leftNameTxt_.text = var_42_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, true)
				arg_39_1.iconController_:SetSelectedState("hero")

				arg_39_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_39_1.callingController_:SetSelectedState("normal")

				arg_39_1.keyicon_.color = Color.New(1, 1, 1)
				arg_39_1.icon_.color = Color.New(1, 1, 1)

				local var_42_9 = arg_39_1:GetWordFromCfg(1101104009)
				local var_42_10 = arg_39_1:FormatText(var_42_9.content)

				arg_39_1.text_.text = var_42_10

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_11 = 18
				local var_42_12 = utf8.len(var_42_10)
				local var_42_13 = var_42_11 <= 0 and var_42_7 or var_42_7 * (var_42_12 / var_42_11)

				if var_42_13 > 0 and var_42_7 < var_42_13 then
					arg_39_1.talkMaxDuration = var_42_13

					if var_42_13 + var_42_6 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_13 + var_42_6
					end
				end

				arg_39_1.text_.text = var_42_10
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)
				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_14 = math.max(var_42_7, arg_39_1.talkMaxDuration)

			if var_42_6 <= arg_39_1.time_ and arg_39_1.time_ < var_42_6 + var_42_14 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_6) / var_42_14

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_6 + var_42_14 and arg_39_1.time_ < var_42_6 + var_42_14 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {}

		arg_39_1:InitPlayNodeList()
	end,
	Play1101104010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 1101104010
		arg_43_1.duration_ = 2

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play1101104011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			local var_46_0 = arg_43_1.actors_["1111ui_story"].transform
			local var_46_1 = 0

			if var_46_1 < arg_43_1.time_ and arg_43_1.time_ <= var_46_1 + arg_46_0 then
				arg_43_1.var_.moveOldPos1111ui_story = var_46_0.localPosition
			end

			local var_46_2 = 0.001

			if var_46_1 <= arg_43_1.time_ and arg_43_1.time_ < var_46_1 + var_46_2 then
				local var_46_3 = (arg_43_1.time_ - var_46_1) / var_46_2
				local var_46_4 = Vector3.New(0, -0.87, -5.7)

				var_46_0.localPosition = Vector3.Lerp(arg_43_1.var_.moveOldPos1111ui_story, var_46_4, var_46_3)

				local var_46_5 = manager.ui.mainCamera.transform.position - var_46_0.position

				var_46_0.forward = Vector3.New(var_46_5.x, var_46_5.y, var_46_5.z)

				local var_46_6 = var_46_0.localEulerAngles

				var_46_6.z = 0
				var_46_6.x = 0
				var_46_0.localEulerAngles = var_46_6
			end

			if arg_43_1.time_ >= var_46_1 + var_46_2 and arg_43_1.time_ < var_46_1 + var_46_2 + arg_46_0 then
				var_46_0.localPosition = Vector3.New(0, -0.87, -5.7)

				local var_46_7 = manager.ui.mainCamera.transform.position - var_46_0.position

				var_46_0.forward = Vector3.New(var_46_7.x, var_46_7.y, var_46_7.z)

				local var_46_8 = var_46_0.localEulerAngles

				var_46_8.z = 0
				var_46_8.x = 0
				var_46_0.localEulerAngles = var_46_8
			end

			local var_46_9 = arg_43_1.actors_["1111ui_story"]
			local var_46_10 = 0

			if var_46_10 < arg_43_1.time_ and arg_43_1.time_ <= var_46_10 + arg_46_0 and not isNil(var_46_9) and arg_43_1.var_.characterEffect1111ui_story == nil then
				arg_43_1.var_.characterEffect1111ui_story = var_46_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_46_11 = 0.200000002980232

			if var_46_10 <= arg_43_1.time_ and arg_43_1.time_ < var_46_10 + var_46_11 and not isNil(var_46_9) then
				local var_46_12 = (arg_43_1.time_ - var_46_10) / var_46_11

				if arg_43_1.var_.characterEffect1111ui_story and not isNil(var_46_9) then
					arg_43_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_43_1.time_ >= var_46_10 + var_46_11 and arg_43_1.time_ < var_46_10 + var_46_11 + arg_46_0 and not isNil(var_46_9) and arg_43_1.var_.characterEffect1111ui_story then
				arg_43_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_46_13 = 0

			if var_46_13 < arg_43_1.time_ and arg_43_1.time_ <= var_46_13 + arg_46_0 then
				arg_43_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111actionlink/1111action425")
			end

			local var_46_14 = 0

			if var_46_14 < arg_43_1.time_ and arg_43_1.time_ <= var_46_14 + arg_46_0 then
				arg_43_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_46_15 = 0
			local var_46_16 = 0.1

			if var_46_15 < arg_43_1.time_ and arg_43_1.time_ <= var_46_15 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				local var_46_17 = arg_43_1:FormatText(StoryNameCfg[67].name)

				arg_43_1.leftNameTxt_.text = var_46_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_18 = arg_43_1:GetWordFromCfg(1101104010)
				local var_46_19 = arg_43_1:FormatText(var_46_18.content)

				arg_43_1.text_.text = var_46_19

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_20 = 4
				local var_46_21 = utf8.len(var_46_19)
				local var_46_22 = var_46_20 <= 0 and var_46_16 or var_46_16 * (var_46_21 / var_46_20)

				if var_46_22 > 0 and var_46_16 < var_46_22 then
					arg_43_1.talkMaxDuration = var_46_22

					if var_46_22 + var_46_15 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_22 + var_46_15
					end
				end

				arg_43_1.text_.text = var_46_19
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101104", "1101104010", "story_v_side_new_1101104.awb") ~= 0 then
					local var_46_23 = manager.audio:GetVoiceLength("story_v_side_new_1101104", "1101104010", "story_v_side_new_1101104.awb") / 1000

					if var_46_23 + var_46_15 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_23 + var_46_15
					end

					if var_46_18.prefab_name ~= "" and arg_43_1.actors_[var_46_18.prefab_name] ~= nil then
						local var_46_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_43_1.actors_[var_46_18.prefab_name].transform, "story_v_side_new_1101104", "1101104010", "story_v_side_new_1101104.awb")

						arg_43_1:RecordAudio("1101104010", var_46_24)
						arg_43_1:RecordAudio("1101104010", var_46_24)
					else
						arg_43_1:AudioAction("play", "voice", "story_v_side_new_1101104", "1101104010", "story_v_side_new_1101104.awb")
					end

					arg_43_1:RecordHistoryTalkVoice("story_v_side_new_1101104", "1101104010", "story_v_side_new_1101104.awb")
				end

				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_25 = math.max(var_46_16, arg_43_1.talkMaxDuration)

			if var_46_15 <= arg_43_1.time_ and arg_43_1.time_ < var_46_15 + var_46_25 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_15) / var_46_25

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_15 + var_46_25 and arg_43_1.time_ < var_46_15 + var_46_25 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_43_1:InitPlayNodeList()
	end,
	Play1101104011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 1101104011
		arg_47_1.duration_ = 1

		SetActive(arg_47_1.tipsGo_, true)

		arg_47_1.tipsText_.text = StoryTipsCfg[101102].name

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"

			SetActive(arg_47_1.choicesGo_, true)

			for iter_48_0, iter_48_1 in ipairs(arg_47_1.choices_) do
				local var_48_0 = iter_48_0 <= 2

				SetActive(iter_48_1.go, var_48_0)
			end

			arg_47_1.choices_[1].txt.text = arg_47_1:FormatText(StoryChoiceCfg[612].name)
			arg_47_1.choices_[2].txt.text = arg_47_1:FormatText(StoryChoiceCfg[613].name)
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play1101104012(arg_47_1)
			end

			if arg_49_0 == 2 then
				PlayerAction.UseStoryTrigger(1011014, 210110104, 1101104011, 2)
				arg_47_0:Play1101104014(arg_47_1)
			end

			arg_47_1:RecordChoiceLog(1101104011, 612, 613)
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			local var_50_0 = arg_47_1.actors_["1111ui_story"]
			local var_50_1 = 0

			if var_50_1 < arg_47_1.time_ and arg_47_1.time_ <= var_50_1 + arg_50_0 and not isNil(var_50_0) and arg_47_1.var_.characterEffect1111ui_story == nil then
				arg_47_1.var_.characterEffect1111ui_story = var_50_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_50_2 = 0.200000002980232

			if var_50_1 <= arg_47_1.time_ and arg_47_1.time_ < var_50_1 + var_50_2 and not isNil(var_50_0) then
				local var_50_3 = (arg_47_1.time_ - var_50_1) / var_50_2

				if arg_47_1.var_.characterEffect1111ui_story and not isNil(var_50_0) then
					local var_50_4 = Mathf.Lerp(0, 0.5, var_50_3)

					arg_47_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_47_1.var_.characterEffect1111ui_story.fillRatio = var_50_4
				end
			end

			if arg_47_1.time_ >= var_50_1 + var_50_2 and arg_47_1.time_ < var_50_1 + var_50_2 + arg_50_0 and not isNil(var_50_0) and arg_47_1.var_.characterEffect1111ui_story then
				local var_50_5 = 0.5

				arg_47_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_47_1.var_.characterEffect1111ui_story.fillRatio = var_50_5
			end

			local var_50_6 = 0

			if var_50_6 < arg_47_1.time_ and arg_47_1.time_ <= var_50_6 + arg_50_0 then
				arg_47_1.allBtn_.enabled = false
			end

			local var_50_7 = 0.5

			if arg_47_1.time_ >= var_50_6 + var_50_7 and arg_47_1.time_ < var_50_6 + var_50_7 + arg_50_0 then
				arg_47_1.allBtn_.enabled = true
			end
		end

		arg_47_1.nodeConfigList_ = {}

		arg_47_1:InitPlayNodeList()
	end,
	Play1101104012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 1101104012
		arg_51_1.duration_ = 5

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play1101104013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			local var_54_0 = 0
			local var_54_1 = 0.575

			if var_54_0 < arg_51_1.time_ and arg_51_1.time_ <= var_54_0 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				local var_54_2 = arg_51_1:FormatText(StoryNameCfg[7].name)

				arg_51_1.leftNameTxt_.text = var_54_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, true)
				arg_51_1.iconController_:SetSelectedState("hero")

				arg_51_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_51_1.callingController_:SetSelectedState("normal")

				arg_51_1.keyicon_.color = Color.New(1, 1, 1)
				arg_51_1.icon_.color = Color.New(1, 1, 1)

				local var_54_3 = arg_51_1:GetWordFromCfg(1101104012)
				local var_54_4 = arg_51_1:FormatText(var_54_3.content)

				arg_51_1.text_.text = var_54_4

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_5 = 23
				local var_54_6 = utf8.len(var_54_4)
				local var_54_7 = var_54_5 <= 0 and var_54_1 or var_54_1 * (var_54_6 / var_54_5)

				if var_54_7 > 0 and var_54_1 < var_54_7 then
					arg_51_1.talkMaxDuration = var_54_7

					if var_54_7 + var_54_0 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_7 + var_54_0
					end
				end

				arg_51_1.text_.text = var_54_4
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)
				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_8 = math.max(var_54_1, arg_51_1.talkMaxDuration)

			if var_54_0 <= arg_51_1.time_ and arg_51_1.time_ < var_54_0 + var_54_8 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_0) / var_54_8

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_0 + var_54_8 and arg_51_1.time_ < var_54_0 + var_54_8 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {}

		arg_51_1:InitPlayNodeList()
	end,
	Play1101104013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 1101104013
		arg_55_1.duration_ = 4.4

		local var_55_0 = {
			zh = 4.4,
			ja = 3.666
		}
		local var_55_1 = manager.audio:GetLocalizationFlag()

		if var_55_0[var_55_1] ~= nil then
			arg_55_1.duration_ = var_55_0[var_55_1]
		end

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play1101104018(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			local var_58_0 = arg_55_1.actors_["1111ui_story"].transform
			local var_58_1 = 0

			if var_58_1 < arg_55_1.time_ and arg_55_1.time_ <= var_58_1 + arg_58_0 then
				arg_55_1.var_.moveOldPos1111ui_story = var_58_0.localPosition
			end

			local var_58_2 = 0.001

			if var_58_1 <= arg_55_1.time_ and arg_55_1.time_ < var_58_1 + var_58_2 then
				local var_58_3 = (arg_55_1.time_ - var_58_1) / var_58_2
				local var_58_4 = Vector3.New(0, -0.87, -5.7)

				var_58_0.localPosition = Vector3.Lerp(arg_55_1.var_.moveOldPos1111ui_story, var_58_4, var_58_3)

				local var_58_5 = manager.ui.mainCamera.transform.position - var_58_0.position

				var_58_0.forward = Vector3.New(var_58_5.x, var_58_5.y, var_58_5.z)

				local var_58_6 = var_58_0.localEulerAngles

				var_58_6.z = 0
				var_58_6.x = 0
				var_58_0.localEulerAngles = var_58_6
			end

			if arg_55_1.time_ >= var_58_1 + var_58_2 and arg_55_1.time_ < var_58_1 + var_58_2 + arg_58_0 then
				var_58_0.localPosition = Vector3.New(0, -0.87, -5.7)

				local var_58_7 = manager.ui.mainCamera.transform.position - var_58_0.position

				var_58_0.forward = Vector3.New(var_58_7.x, var_58_7.y, var_58_7.z)

				local var_58_8 = var_58_0.localEulerAngles

				var_58_8.z = 0
				var_58_8.x = 0
				var_58_0.localEulerAngles = var_58_8
			end

			local var_58_9 = arg_55_1.actors_["1111ui_story"]
			local var_58_10 = 0

			if var_58_10 < arg_55_1.time_ and arg_55_1.time_ <= var_58_10 + arg_58_0 and not isNil(var_58_9) and arg_55_1.var_.characterEffect1111ui_story == nil then
				arg_55_1.var_.characterEffect1111ui_story = var_58_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_58_11 = 0.200000002980232

			if var_58_10 <= arg_55_1.time_ and arg_55_1.time_ < var_58_10 + var_58_11 and not isNil(var_58_9) then
				local var_58_12 = (arg_55_1.time_ - var_58_10) / var_58_11

				if arg_55_1.var_.characterEffect1111ui_story and not isNil(var_58_9) then
					arg_55_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_55_1.time_ >= var_58_10 + var_58_11 and arg_55_1.time_ < var_58_10 + var_58_11 + arg_58_0 and not isNil(var_58_9) and arg_55_1.var_.characterEffect1111ui_story then
				arg_55_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_58_13 = 0

			if var_58_13 < arg_55_1.time_ and arg_55_1.time_ <= var_58_13 + arg_58_0 then
				arg_55_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_58_14 = 0

			if var_58_14 < arg_55_1.time_ and arg_55_1.time_ <= var_58_14 + arg_58_0 then
				arg_55_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111actionlink/1111action456")
			end

			local var_58_15 = 0
			local var_58_16 = 0.375

			if var_58_15 < arg_55_1.time_ and arg_55_1.time_ <= var_58_15 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				local var_58_17 = arg_55_1:FormatText(StoryNameCfg[67].name)

				arg_55_1.leftNameTxt_.text = var_58_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_18 = arg_55_1:GetWordFromCfg(1101104013)
				local var_58_19 = arg_55_1:FormatText(var_58_18.content)

				arg_55_1.text_.text = var_58_19

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_20 = 15
				local var_58_21 = utf8.len(var_58_19)
				local var_58_22 = var_58_20 <= 0 and var_58_16 or var_58_16 * (var_58_21 / var_58_20)

				if var_58_22 > 0 and var_58_16 < var_58_22 then
					arg_55_1.talkMaxDuration = var_58_22

					if var_58_22 + var_58_15 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_22 + var_58_15
					end
				end

				arg_55_1.text_.text = var_58_19
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101104", "1101104013", "story_v_side_new_1101104.awb") ~= 0 then
					local var_58_23 = manager.audio:GetVoiceLength("story_v_side_new_1101104", "1101104013", "story_v_side_new_1101104.awb") / 1000

					if var_58_23 + var_58_15 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_23 + var_58_15
					end

					if var_58_18.prefab_name ~= "" and arg_55_1.actors_[var_58_18.prefab_name] ~= nil then
						local var_58_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_55_1.actors_[var_58_18.prefab_name].transform, "story_v_side_new_1101104", "1101104013", "story_v_side_new_1101104.awb")

						arg_55_1:RecordAudio("1101104013", var_58_24)
						arg_55_1:RecordAudio("1101104013", var_58_24)
					else
						arg_55_1:AudioAction("play", "voice", "story_v_side_new_1101104", "1101104013", "story_v_side_new_1101104.awb")
					end

					arg_55_1:RecordHistoryTalkVoice("story_v_side_new_1101104", "1101104013", "story_v_side_new_1101104.awb")
				end

				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_25 = math.max(var_58_16, arg_55_1.talkMaxDuration)

			if var_58_15 <= arg_55_1.time_ and arg_55_1.time_ < var_58_15 + var_58_25 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_15) / var_58_25

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_15 + var_58_25 and arg_55_1.time_ < var_58_15 + var_58_25 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_55_1:InitPlayNodeList()
	end,
	Play1101104018 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 1101104018
		arg_59_1.duration_ = 4.97

		local var_59_0 = {
			zh = 4.966,
			ja = 4.7
		}
		local var_59_1 = manager.audio:GetLocalizationFlag()

		if var_59_0[var_59_1] ~= nil then
			arg_59_1.duration_ = var_59_0[var_59_1]
		end

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"
		end

		function arg_59_1.playNext_(arg_61_0)
			if arg_61_0 == 1 then
				arg_59_0:Play1101104019(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = arg_59_1.actors_["1111ui_story"].transform
			local var_62_1 = 0

			if var_62_1 < arg_59_1.time_ and arg_59_1.time_ <= var_62_1 + arg_62_0 then
				arg_59_1.var_.moveOldPos1111ui_story = var_62_0.localPosition
			end

			local var_62_2 = 0.001

			if var_62_1 <= arg_59_1.time_ and arg_59_1.time_ < var_62_1 + var_62_2 then
				local var_62_3 = (arg_59_1.time_ - var_62_1) / var_62_2
				local var_62_4 = Vector3.New(0, -0.87, -5.7)

				var_62_0.localPosition = Vector3.Lerp(arg_59_1.var_.moveOldPos1111ui_story, var_62_4, var_62_3)

				local var_62_5 = manager.ui.mainCamera.transform.position - var_62_0.position

				var_62_0.forward = Vector3.New(var_62_5.x, var_62_5.y, var_62_5.z)

				local var_62_6 = var_62_0.localEulerAngles

				var_62_6.z = 0
				var_62_6.x = 0
				var_62_0.localEulerAngles = var_62_6
			end

			if arg_59_1.time_ >= var_62_1 + var_62_2 and arg_59_1.time_ < var_62_1 + var_62_2 + arg_62_0 then
				var_62_0.localPosition = Vector3.New(0, -0.87, -5.7)

				local var_62_7 = manager.ui.mainCamera.transform.position - var_62_0.position

				var_62_0.forward = Vector3.New(var_62_7.x, var_62_7.y, var_62_7.z)

				local var_62_8 = var_62_0.localEulerAngles

				var_62_8.z = 0
				var_62_8.x = 0
				var_62_0.localEulerAngles = var_62_8
			end

			local var_62_9 = 0

			if var_62_9 < arg_59_1.time_ and arg_59_1.time_ <= var_62_9 + arg_62_0 then
				arg_59_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action6_2")
			end

			local var_62_10 = 0

			if var_62_10 < arg_59_1.time_ and arg_59_1.time_ <= var_62_10 + arg_62_0 then
				arg_59_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_62_11 = 0
			local var_62_12 = 0.625

			if var_62_11 < arg_59_1.time_ and arg_59_1.time_ <= var_62_11 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				local var_62_13 = arg_59_1:FormatText(StoryNameCfg[67].name)

				arg_59_1.leftNameTxt_.text = var_62_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_14 = arg_59_1:GetWordFromCfg(1101104018)
				local var_62_15 = arg_59_1:FormatText(var_62_14.content)

				arg_59_1.text_.text = var_62_15

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_16 = 25
				local var_62_17 = utf8.len(var_62_15)
				local var_62_18 = var_62_16 <= 0 and var_62_12 or var_62_12 * (var_62_17 / var_62_16)

				if var_62_18 > 0 and var_62_12 < var_62_18 then
					arg_59_1.talkMaxDuration = var_62_18

					if var_62_18 + var_62_11 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_18 + var_62_11
					end
				end

				arg_59_1.text_.text = var_62_15
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101104", "1101104018", "story_v_side_new_1101104.awb") ~= 0 then
					local var_62_19 = manager.audio:GetVoiceLength("story_v_side_new_1101104", "1101104018", "story_v_side_new_1101104.awb") / 1000

					if var_62_19 + var_62_11 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_19 + var_62_11
					end

					if var_62_14.prefab_name ~= "" and arg_59_1.actors_[var_62_14.prefab_name] ~= nil then
						local var_62_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_14.prefab_name].transform, "story_v_side_new_1101104", "1101104018", "story_v_side_new_1101104.awb")

						arg_59_1:RecordAudio("1101104018", var_62_20)
						arg_59_1:RecordAudio("1101104018", var_62_20)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_side_new_1101104", "1101104018", "story_v_side_new_1101104.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_side_new_1101104", "1101104018", "story_v_side_new_1101104.awb")
				end

				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_21 = math.max(var_62_12, arg_59_1.talkMaxDuration)

			if var_62_11 <= arg_59_1.time_ and arg_59_1.time_ < var_62_11 + var_62_21 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_11) / var_62_21

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_11 + var_62_21 and arg_59_1.time_ < var_62_11 + var_62_21 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_59_1:InitPlayNodeList()
	end,
	Play1101104019 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 1101104019
		arg_63_1.duration_ = 5

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play1101104020(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = arg_63_1.actors_["1111ui_story"]
			local var_66_1 = 0

			if var_66_1 < arg_63_1.time_ and arg_63_1.time_ <= var_66_1 + arg_66_0 and not isNil(var_66_0) and arg_63_1.var_.characterEffect1111ui_story == nil then
				arg_63_1.var_.characterEffect1111ui_story = var_66_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_66_2 = 0.200000002980232

			if var_66_1 <= arg_63_1.time_ and arg_63_1.time_ < var_66_1 + var_66_2 and not isNil(var_66_0) then
				local var_66_3 = (arg_63_1.time_ - var_66_1) / var_66_2

				if arg_63_1.var_.characterEffect1111ui_story and not isNil(var_66_0) then
					local var_66_4 = Mathf.Lerp(0, 0.5, var_66_3)

					arg_63_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_63_1.var_.characterEffect1111ui_story.fillRatio = var_66_4
				end
			end

			if arg_63_1.time_ >= var_66_1 + var_66_2 and arg_63_1.time_ < var_66_1 + var_66_2 + arg_66_0 and not isNil(var_66_0) and arg_63_1.var_.characterEffect1111ui_story then
				local var_66_5 = 0.5

				arg_63_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_63_1.var_.characterEffect1111ui_story.fillRatio = var_66_5
			end

			local var_66_6 = 0
			local var_66_7 = 0.15

			if var_66_6 < arg_63_1.time_ and arg_63_1.time_ <= var_66_6 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, false)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_8 = arg_63_1:GetWordFromCfg(1101104019)
				local var_66_9 = arg_63_1:FormatText(var_66_8.content)

				arg_63_1.text_.text = var_66_9

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_10 = 6
				local var_66_11 = utf8.len(var_66_9)
				local var_66_12 = var_66_10 <= 0 and var_66_7 or var_66_7 * (var_66_11 / var_66_10)

				if var_66_12 > 0 and var_66_7 < var_66_12 then
					arg_63_1.talkMaxDuration = var_66_12

					if var_66_12 + var_66_6 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_12 + var_66_6
					end
				end

				arg_63_1.text_.text = var_66_9
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)
				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_13 = math.max(var_66_7, arg_63_1.talkMaxDuration)

			if var_66_6 <= arg_63_1.time_ and arg_63_1.time_ < var_66_6 + var_66_13 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_6) / var_66_13

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_6 + var_66_13 and arg_63_1.time_ < var_66_6 + var_66_13 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {}

		arg_63_1:InitPlayNodeList()
	end,
	Play1101104020 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 1101104020
		arg_67_1.duration_ = 5

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play1101104021(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = 0
			local var_70_1 = 0.95

			if var_70_0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_0 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				local var_70_2 = arg_67_1:FormatText(StoryNameCfg[7].name)

				arg_67_1.leftNameTxt_.text = var_70_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, true)
				arg_67_1.iconController_:SetSelectedState("hero")

				arg_67_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_67_1.callingController_:SetSelectedState("normal")

				arg_67_1.keyicon_.color = Color.New(1, 1, 1)
				arg_67_1.icon_.color = Color.New(1, 1, 1)

				local var_70_3 = arg_67_1:GetWordFromCfg(1101104020)
				local var_70_4 = arg_67_1:FormatText(var_70_3.content)

				arg_67_1.text_.text = var_70_4

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_5 = 38
				local var_70_6 = utf8.len(var_70_4)
				local var_70_7 = var_70_5 <= 0 and var_70_1 or var_70_1 * (var_70_6 / var_70_5)

				if var_70_7 > 0 and var_70_1 < var_70_7 then
					arg_67_1.talkMaxDuration = var_70_7

					if var_70_7 + var_70_0 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_7 + var_70_0
					end
				end

				arg_67_1.text_.text = var_70_4
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)
				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_8 = math.max(var_70_1, arg_67_1.talkMaxDuration)

			if var_70_0 <= arg_67_1.time_ and arg_67_1.time_ < var_70_0 + var_70_8 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_0) / var_70_8

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_0 + var_70_8 and arg_67_1.time_ < var_70_0 + var_70_8 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {}

		arg_67_1:InitPlayNodeList()
	end,
	Play1101104021 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 1101104021
		arg_71_1.duration_ = 5

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play1101104022(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = arg_71_1.actors_["1111ui_story"].transform
			local var_74_1 = 0

			if var_74_1 < arg_71_1.time_ and arg_71_1.time_ <= var_74_1 + arg_74_0 then
				arg_71_1.var_.moveOldPos1111ui_story = var_74_0.localPosition
			end

			local var_74_2 = 0.001

			if var_74_1 <= arg_71_1.time_ and arg_71_1.time_ < var_74_1 + var_74_2 then
				local var_74_3 = (arg_71_1.time_ - var_74_1) / var_74_2
				local var_74_4 = Vector3.New(0, 100, 0)

				var_74_0.localPosition = Vector3.Lerp(arg_71_1.var_.moveOldPos1111ui_story, var_74_4, var_74_3)

				local var_74_5 = manager.ui.mainCamera.transform.position - var_74_0.position

				var_74_0.forward = Vector3.New(var_74_5.x, var_74_5.y, var_74_5.z)

				local var_74_6 = var_74_0.localEulerAngles

				var_74_6.z = 0
				var_74_6.x = 0
				var_74_0.localEulerAngles = var_74_6
			end

			if arg_71_1.time_ >= var_74_1 + var_74_2 and arg_71_1.time_ < var_74_1 + var_74_2 + arg_74_0 then
				var_74_0.localPosition = Vector3.New(0, 100, 0)

				local var_74_7 = manager.ui.mainCamera.transform.position - var_74_0.position

				var_74_0.forward = Vector3.New(var_74_7.x, var_74_7.y, var_74_7.z)

				local var_74_8 = var_74_0.localEulerAngles

				var_74_8.z = 0
				var_74_8.x = 0
				var_74_0.localEulerAngles = var_74_8
			end

			local var_74_9 = 0
			local var_74_10 = 0.775

			if var_74_9 < arg_71_1.time_ and arg_71_1.time_ <= var_74_9 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, false)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_11 = arg_71_1:GetWordFromCfg(1101104021)
				local var_74_12 = arg_71_1:FormatText(var_74_11.content)

				arg_71_1.text_.text = var_74_12

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_13 = 36
				local var_74_14 = utf8.len(var_74_12)
				local var_74_15 = var_74_13 <= 0 and var_74_10 or var_74_10 * (var_74_14 / var_74_13)

				if var_74_15 > 0 and var_74_10 < var_74_15 then
					arg_71_1.talkMaxDuration = var_74_15

					if var_74_15 + var_74_9 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_15 + var_74_9
					end
				end

				arg_71_1.text_.text = var_74_12
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)
				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_16 = math.max(var_74_10, arg_71_1.talkMaxDuration)

			if var_74_9 <= arg_71_1.time_ and arg_71_1.time_ < var_74_9 + var_74_16 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_9) / var_74_16

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_9 + var_74_16 and arg_71_1.time_ < var_74_9 + var_74_16 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_71_1:InitPlayNodeList()
	end,
	Play1101104022 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 1101104022
		arg_75_1.duration_ = 9

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play1101104023(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = 2

			if var_78_0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_0 + arg_78_0 then
				local var_78_1 = manager.ui.mainCamera.transform.localPosition
				local var_78_2 = Vector3.New(0, 0, 10) + Vector3.New(var_78_1.x, var_78_1.y, 0)
				local var_78_3 = arg_75_1.bgs_.ST01

				var_78_3.transform.localPosition = var_78_2
				var_78_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_78_4 = var_78_3:GetComponent("SpriteRenderer")

				if var_78_4 and var_78_4.sprite then
					local var_78_5 = (var_78_3.transform.localPosition - var_78_1).z
					local var_78_6 = manager.ui.mainCameraCom_
					local var_78_7 = 2 * var_78_5 * Mathf.Tan(var_78_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_78_8 = var_78_7 * var_78_6.aspect
					local var_78_9 = var_78_4.sprite.bounds.size.x
					local var_78_10 = var_78_4.sprite.bounds.size.y
					local var_78_11 = var_78_8 / var_78_9
					local var_78_12 = var_78_7 / var_78_10
					local var_78_13 = var_78_12 < var_78_11 and var_78_11 or var_78_12

					var_78_3.transform.localScale = Vector3.New(var_78_13, var_78_13, 0)
				end

				for iter_78_0, iter_78_1 in pairs(arg_75_1.bgs_) do
					if iter_78_0 ~= "ST01" then
						iter_78_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_78_14 = 0

			if var_78_14 < arg_75_1.time_ and arg_75_1.time_ <= var_78_14 + arg_78_0 then
				arg_75_1.mask_.enabled = true
				arg_75_1.mask_.raycastTarget = true

				arg_75_1:SetGaussion(false)
			end

			local var_78_15 = 2

			if var_78_14 <= arg_75_1.time_ and arg_75_1.time_ < var_78_14 + var_78_15 then
				local var_78_16 = (arg_75_1.time_ - var_78_14) / var_78_15
				local var_78_17 = Color.New(0, 0, 0)

				var_78_17.a = Mathf.Lerp(0, 1, var_78_16)
				arg_75_1.mask_.color = var_78_17
			end

			if arg_75_1.time_ >= var_78_14 + var_78_15 and arg_75_1.time_ < var_78_14 + var_78_15 + arg_78_0 then
				local var_78_18 = Color.New(0, 0, 0)

				var_78_18.a = 1
				arg_75_1.mask_.color = var_78_18
			end

			local var_78_19 = 2

			if var_78_19 < arg_75_1.time_ and arg_75_1.time_ <= var_78_19 + arg_78_0 then
				arg_75_1.mask_.enabled = true
				arg_75_1.mask_.raycastTarget = true

				arg_75_1:SetGaussion(false)
			end

			local var_78_20 = 2

			if var_78_19 <= arg_75_1.time_ and arg_75_1.time_ < var_78_19 + var_78_20 then
				local var_78_21 = (arg_75_1.time_ - var_78_19) / var_78_20
				local var_78_22 = Color.New(0, 0, 0)

				var_78_22.a = Mathf.Lerp(1, 0, var_78_21)
				arg_75_1.mask_.color = var_78_22
			end

			if arg_75_1.time_ >= var_78_19 + var_78_20 and arg_75_1.time_ < var_78_19 + var_78_20 + arg_78_0 then
				local var_78_23 = Color.New(0, 0, 0)
				local var_78_24 = 0

				arg_75_1.mask_.enabled = false
				var_78_23.a = var_78_24
				arg_75_1.mask_.color = var_78_23
			end

			if arg_75_1.frameCnt_ <= 1 then
				arg_75_1.dialog_:SetActive(false)
			end

			local var_78_25 = 4
			local var_78_26 = 0.775

			if var_78_25 < arg_75_1.time_ and arg_75_1.time_ <= var_78_25 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0

				arg_75_1.dialog_:SetActive(true)

				arg_75_1.dialogCg_.alpha = 0

				local var_78_27 = LeanTween.value(arg_75_1.dialog_, 0, 1, 0.3)

				var_78_27:setOnUpdate(LuaHelper.FloatAction(function(arg_79_0)
					arg_75_1.dialogCg_.alpha = arg_79_0
				end))
				var_78_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_75_1.dialog_)
					var_78_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_75_1.duration_ = arg_75_1.duration_ + 0.3

				SetActive(arg_75_1.leftNameGo_, false)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_28 = arg_75_1:GetWordFromCfg(1101104022)
				local var_78_29 = arg_75_1:FormatText(var_78_28.content)

				arg_75_1.text_.text = var_78_29

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_30 = 35
				local var_78_31 = utf8.len(var_78_29)
				local var_78_32 = var_78_30 <= 0 and var_78_26 or var_78_26 * (var_78_31 / var_78_30)

				if var_78_32 > 0 and var_78_26 < var_78_32 then
					arg_75_1.talkMaxDuration = var_78_32
					var_78_25 = var_78_25 + 0.3

					if var_78_32 + var_78_25 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_32 + var_78_25
					end
				end

				arg_75_1.text_.text = var_78_29
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)
				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_33 = var_78_25 + 0.3
			local var_78_34 = math.max(var_78_26, arg_75_1.talkMaxDuration)

			if var_78_33 <= arg_75_1.time_ and arg_75_1.time_ < var_78_33 + var_78_34 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_33) / var_78_34

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_33 + var_78_34 and arg_75_1.time_ < var_78_33 + var_78_34 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play1101104023 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 1101104023
		arg_81_1.duration_ = 4.63

		local var_81_0 = {
			zh = 4.633,
			ja = 4.233
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
				arg_81_0:Play1101104024(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = "111101ui_story"

			if arg_81_1.actors_[var_84_0] == nil then
				local var_84_1 = Asset.Load("Char/" .. "111101ui_story")

				if not isNil(var_84_1) then
					local var_84_2 = Object.Instantiate(Asset.Load("Char/" .. "111101ui_story"), arg_81_1.stage_.transform)

					var_84_2.name = var_84_0
					var_84_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_81_1.actors_[var_84_0] = var_84_2

					local var_84_3 = var_84_2:GetComponentInChildren(typeof(CharacterEffect))

					var_84_3.enabled = true

					local var_84_4 = GameObjectTools.GetOrAddComponent(var_84_2, typeof(DynamicBoneHelper))

					if var_84_4 then
						var_84_4:EnableDynamicBone(false)
					end

					arg_81_1:ShowWeapon(var_84_3.transform, false)

					arg_81_1.var_[var_84_0 .. "Animator"] = var_84_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_81_1.var_[var_84_0 .. "Animator"].applyRootMotion = true
					arg_81_1.var_[var_84_0 .. "LipSync"] = var_84_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_84_5 = arg_81_1.actors_["111101ui_story"].transform
			local var_84_6 = 0

			if var_84_6 < arg_81_1.time_ and arg_81_1.time_ <= var_84_6 + arg_84_0 then
				arg_81_1.var_.moveOldPos111101ui_story = var_84_5.localPosition
			end

			local var_84_7 = 0.001

			if var_84_6 <= arg_81_1.time_ and arg_81_1.time_ < var_84_6 + var_84_7 then
				local var_84_8 = (arg_81_1.time_ - var_84_6) / var_84_7
				local var_84_9 = Vector3.New(0, -0.83, -6)

				var_84_5.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos111101ui_story, var_84_9, var_84_8)

				local var_84_10 = manager.ui.mainCamera.transform.position - var_84_5.position

				var_84_5.forward = Vector3.New(var_84_10.x, var_84_10.y, var_84_10.z)

				local var_84_11 = var_84_5.localEulerAngles

				var_84_11.z = 0
				var_84_11.x = 0
				var_84_5.localEulerAngles = var_84_11
			end

			if arg_81_1.time_ >= var_84_6 + var_84_7 and arg_81_1.time_ < var_84_6 + var_84_7 + arg_84_0 then
				var_84_5.localPosition = Vector3.New(0, -0.83, -6)

				local var_84_12 = manager.ui.mainCamera.transform.position - var_84_5.position

				var_84_5.forward = Vector3.New(var_84_12.x, var_84_12.y, var_84_12.z)

				local var_84_13 = var_84_5.localEulerAngles

				var_84_13.z = 0
				var_84_13.x = 0
				var_84_5.localEulerAngles = var_84_13
			end

			local var_84_14 = arg_81_1.actors_["1111ui_story"]
			local var_84_15 = 0

			if var_84_15 < arg_81_1.time_ and arg_81_1.time_ <= var_84_15 + arg_84_0 and not isNil(var_84_14) and arg_81_1.var_.characterEffect1111ui_story == nil then
				arg_81_1.var_.characterEffect1111ui_story = var_84_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_16 = 0.200000002980232

			if var_84_15 <= arg_81_1.time_ and arg_81_1.time_ < var_84_15 + var_84_16 and not isNil(var_84_14) then
				local var_84_17 = (arg_81_1.time_ - var_84_15) / var_84_16

				if arg_81_1.var_.characterEffect1111ui_story and not isNil(var_84_14) then
					arg_81_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_81_1.time_ >= var_84_15 + var_84_16 and arg_81_1.time_ < var_84_15 + var_84_16 + arg_84_0 and not isNil(var_84_14) and arg_81_1.var_.characterEffect1111ui_story then
				arg_81_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_84_18 = 0

			if var_84_18 < arg_81_1.time_ and arg_81_1.time_ <= var_84_18 + arg_84_0 then
				arg_81_1:PlayTimeline("111101ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action8_1")
			end

			local var_84_19 = 0

			if var_84_19 < arg_81_1.time_ and arg_81_1.time_ <= var_84_19 + arg_84_0 then
				arg_81_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_84_20 = 0
			local var_84_21 = 0.375

			if var_84_20 < arg_81_1.time_ and arg_81_1.time_ <= var_84_20 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				local var_84_22 = arg_81_1:FormatText(StoryNameCfg[67].name)

				arg_81_1.leftNameTxt_.text = var_84_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_23 = arg_81_1:GetWordFromCfg(1101104023)
				local var_84_24 = arg_81_1:FormatText(var_84_23.content)

				arg_81_1.text_.text = var_84_24

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_25 = 15
				local var_84_26 = utf8.len(var_84_24)
				local var_84_27 = var_84_25 <= 0 and var_84_21 or var_84_21 * (var_84_26 / var_84_25)

				if var_84_27 > 0 and var_84_21 < var_84_27 then
					arg_81_1.talkMaxDuration = var_84_27

					if var_84_27 + var_84_20 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_27 + var_84_20
					end
				end

				arg_81_1.text_.text = var_84_24
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101104", "1101104023", "story_v_side_new_1101104.awb") ~= 0 then
					local var_84_28 = manager.audio:GetVoiceLength("story_v_side_new_1101104", "1101104023", "story_v_side_new_1101104.awb") / 1000

					if var_84_28 + var_84_20 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_28 + var_84_20
					end

					if var_84_23.prefab_name ~= "" and arg_81_1.actors_[var_84_23.prefab_name] ~= nil then
						local var_84_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_23.prefab_name].transform, "story_v_side_new_1101104", "1101104023", "story_v_side_new_1101104.awb")

						arg_81_1:RecordAudio("1101104023", var_84_29)
						arg_81_1:RecordAudio("1101104023", var_84_29)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_side_new_1101104", "1101104023", "story_v_side_new_1101104.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_side_new_1101104", "1101104023", "story_v_side_new_1101104.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_30 = math.max(var_84_21, arg_81_1.talkMaxDuration)

			if var_84_20 <= arg_81_1.time_ and arg_81_1.time_ < var_84_20 + var_84_30 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_20) / var_84_30

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_20 + var_84_30 and arg_81_1.time_ < var_84_20 + var_84_30 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "111101ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_81_1:InitPlayNodeList()
	end,
	Play1101104024 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 1101104024
		arg_85_1.duration_ = 5

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play1101104025(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = arg_85_1.actors_["1111ui_story"]
			local var_88_1 = 0

			if var_88_1 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 and not isNil(var_88_0) and arg_85_1.var_.characterEffect1111ui_story == nil then
				arg_85_1.var_.characterEffect1111ui_story = var_88_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_2 = 0.200000002980232

			if var_88_1 <= arg_85_1.time_ and arg_85_1.time_ < var_88_1 + var_88_2 and not isNil(var_88_0) then
				local var_88_3 = (arg_85_1.time_ - var_88_1) / var_88_2

				if arg_85_1.var_.characterEffect1111ui_story and not isNil(var_88_0) then
					local var_88_4 = Mathf.Lerp(0, 0.5, var_88_3)

					arg_85_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_85_1.var_.characterEffect1111ui_story.fillRatio = var_88_4
				end
			end

			if arg_85_1.time_ >= var_88_1 + var_88_2 and arg_85_1.time_ < var_88_1 + var_88_2 + arg_88_0 and not isNil(var_88_0) and arg_85_1.var_.characterEffect1111ui_story then
				local var_88_5 = 0.5

				arg_85_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_85_1.var_.characterEffect1111ui_story.fillRatio = var_88_5
			end

			local var_88_6 = 0
			local var_88_7 = 0.775

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

				local var_88_9 = arg_85_1:GetWordFromCfg(1101104024)
				local var_88_10 = arg_85_1:FormatText(var_88_9.content)

				arg_85_1.text_.text = var_88_10

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_11 = 31
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
	Play1101104025 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 1101104025
		arg_89_1.duration_ = 3.83

		local var_89_0 = {
			zh = 1.999999999999,
			ja = 3.833
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
				arg_89_0:Play1101104026(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = arg_89_1.actors_["111101ui_story"].transform
			local var_92_1 = 0

			if var_92_1 < arg_89_1.time_ and arg_89_1.time_ <= var_92_1 + arg_92_0 then
				arg_89_1.var_.moveOldPos111101ui_story = var_92_0.localPosition
			end

			local var_92_2 = 0.001

			if var_92_1 <= arg_89_1.time_ and arg_89_1.time_ < var_92_1 + var_92_2 then
				local var_92_3 = (arg_89_1.time_ - var_92_1) / var_92_2
				local var_92_4 = Vector3.New(0, -0.83, -6)

				var_92_0.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos111101ui_story, var_92_4, var_92_3)

				local var_92_5 = manager.ui.mainCamera.transform.position - var_92_0.position

				var_92_0.forward = Vector3.New(var_92_5.x, var_92_5.y, var_92_5.z)

				local var_92_6 = var_92_0.localEulerAngles

				var_92_6.z = 0
				var_92_6.x = 0
				var_92_0.localEulerAngles = var_92_6
			end

			if arg_89_1.time_ >= var_92_1 + var_92_2 and arg_89_1.time_ < var_92_1 + var_92_2 + arg_92_0 then
				var_92_0.localPosition = Vector3.New(0, -0.83, -6)

				local var_92_7 = manager.ui.mainCamera.transform.position - var_92_0.position

				var_92_0.forward = Vector3.New(var_92_7.x, var_92_7.y, var_92_7.z)

				local var_92_8 = var_92_0.localEulerAngles

				var_92_8.z = 0
				var_92_8.x = 0
				var_92_0.localEulerAngles = var_92_8
			end

			local var_92_9 = arg_89_1.actors_["111101ui_story"]
			local var_92_10 = 0

			if var_92_10 < arg_89_1.time_ and arg_89_1.time_ <= var_92_10 + arg_92_0 and not isNil(var_92_9) and arg_89_1.var_.characterEffect111101ui_story == nil then
				arg_89_1.var_.characterEffect111101ui_story = var_92_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_11 = 0.200000002980232

			if var_92_10 <= arg_89_1.time_ and arg_89_1.time_ < var_92_10 + var_92_11 and not isNil(var_92_9) then
				local var_92_12 = (arg_89_1.time_ - var_92_10) / var_92_11

				if arg_89_1.var_.characterEffect111101ui_story and not isNil(var_92_9) then
					arg_89_1.var_.characterEffect111101ui_story.fillFlat = false
				end
			end

			if arg_89_1.time_ >= var_92_10 + var_92_11 and arg_89_1.time_ < var_92_10 + var_92_11 + arg_92_0 and not isNil(var_92_9) and arg_89_1.var_.characterEffect111101ui_story then
				arg_89_1.var_.characterEffect111101ui_story.fillFlat = false
			end

			local var_92_13 = 0

			if var_92_13 < arg_89_1.time_ and arg_89_1.time_ <= var_92_13 + arg_92_0 then
				arg_89_1:PlayTimeline("111101ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action8_2")
			end

			local var_92_14 = 0

			if var_92_14 < arg_89_1.time_ and arg_89_1.time_ <= var_92_14 + arg_92_0 then
				arg_89_1:PlayTimeline("111101ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_92_15 = 0
			local var_92_16 = 0.125

			if var_92_15 < arg_89_1.time_ and arg_89_1.time_ <= var_92_15 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				local var_92_17 = arg_89_1:FormatText(StoryNameCfg[67].name)

				arg_89_1.leftNameTxt_.text = var_92_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_18 = arg_89_1:GetWordFromCfg(1101104025)
				local var_92_19 = arg_89_1:FormatText(var_92_18.content)

				arg_89_1.text_.text = var_92_19

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_20 = 5
				local var_92_21 = utf8.len(var_92_19)
				local var_92_22 = var_92_20 <= 0 and var_92_16 or var_92_16 * (var_92_21 / var_92_20)

				if var_92_22 > 0 and var_92_16 < var_92_22 then
					arg_89_1.talkMaxDuration = var_92_22

					if var_92_22 + var_92_15 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_22 + var_92_15
					end
				end

				arg_89_1.text_.text = var_92_19
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101104", "1101104025", "story_v_side_new_1101104.awb") ~= 0 then
					local var_92_23 = manager.audio:GetVoiceLength("story_v_side_new_1101104", "1101104025", "story_v_side_new_1101104.awb") / 1000

					if var_92_23 + var_92_15 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_23 + var_92_15
					end

					if var_92_18.prefab_name ~= "" and arg_89_1.actors_[var_92_18.prefab_name] ~= nil then
						local var_92_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_18.prefab_name].transform, "story_v_side_new_1101104", "1101104025", "story_v_side_new_1101104.awb")

						arg_89_1:RecordAudio("1101104025", var_92_24)
						arg_89_1:RecordAudio("1101104025", var_92_24)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_side_new_1101104", "1101104025", "story_v_side_new_1101104.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_side_new_1101104", "1101104025", "story_v_side_new_1101104.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_25 = math.max(var_92_16, arg_89_1.talkMaxDuration)

			if var_92_15 <= arg_89_1.time_ and arg_89_1.time_ < var_92_15 + var_92_25 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_15) / var_92_25

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_15 + var_92_25 and arg_89_1.time_ < var_92_15 + var_92_25 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "111101ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_89_1:InitPlayNodeList()
	end,
	Play1101104026 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 1101104026
		arg_93_1.duration_ = 5

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play1101104027(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = arg_93_1.actors_["111101ui_story"].transform
			local var_96_1 = 0

			if var_96_1 < arg_93_1.time_ and arg_93_1.time_ <= var_96_1 + arg_96_0 then
				arg_93_1.var_.moveOldPos111101ui_story = var_96_0.localPosition
			end

			local var_96_2 = 0.001

			if var_96_1 <= arg_93_1.time_ and arg_93_1.time_ < var_96_1 + var_96_2 then
				local var_96_3 = (arg_93_1.time_ - var_96_1) / var_96_2
				local var_96_4 = Vector3.New(0, 100, 0)

				var_96_0.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos111101ui_story, var_96_4, var_96_3)

				local var_96_5 = manager.ui.mainCamera.transform.position - var_96_0.position

				var_96_0.forward = Vector3.New(var_96_5.x, var_96_5.y, var_96_5.z)

				local var_96_6 = var_96_0.localEulerAngles

				var_96_6.z = 0
				var_96_6.x = 0
				var_96_0.localEulerAngles = var_96_6
			end

			if arg_93_1.time_ >= var_96_1 + var_96_2 and arg_93_1.time_ < var_96_1 + var_96_2 + arg_96_0 then
				var_96_0.localPosition = Vector3.New(0, 100, 0)

				local var_96_7 = manager.ui.mainCamera.transform.position - var_96_0.position

				var_96_0.forward = Vector3.New(var_96_7.x, var_96_7.y, var_96_7.z)

				local var_96_8 = var_96_0.localEulerAngles

				var_96_8.z = 0
				var_96_8.x = 0
				var_96_0.localEulerAngles = var_96_8
			end

			local var_96_9 = 0
			local var_96_10 = 0.475

			if var_96_9 < arg_93_1.time_ and arg_93_1.time_ <= var_96_9 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, false)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_11 = arg_93_1:GetWordFromCfg(1101104026)
				local var_96_12 = arg_93_1:FormatText(var_96_11.content)

				arg_93_1.text_.text = var_96_12

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_13 = 19
				local var_96_14 = utf8.len(var_96_12)
				local var_96_15 = var_96_13 <= 0 and var_96_10 or var_96_10 * (var_96_14 / var_96_13)

				if var_96_15 > 0 and var_96_10 < var_96_15 then
					arg_93_1.talkMaxDuration = var_96_15

					if var_96_15 + var_96_9 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_15 + var_96_9
					end
				end

				arg_93_1.text_.text = var_96_12
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)
				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_16 = math.max(var_96_10, arg_93_1.talkMaxDuration)

			if var_96_9 <= arg_93_1.time_ and arg_93_1.time_ < var_96_9 + var_96_16 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_9) / var_96_16

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_9 + var_96_16 and arg_93_1.time_ < var_96_9 + var_96_16 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "111101ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_93_1:InitPlayNodeList()
	end,
	Play1101104027 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 1101104027
		arg_97_1.duration_ = 5

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play1101104028(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = 0
			local var_100_1 = 0.7

			if var_100_0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_0 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, false)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_2 = arg_97_1:GetWordFromCfg(1101104027)
				local var_100_3 = arg_97_1:FormatText(var_100_2.content)

				arg_97_1.text_.text = var_100_3

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_4 = 28
				local var_100_5 = utf8.len(var_100_3)
				local var_100_6 = var_100_4 <= 0 and var_100_1 or var_100_1 * (var_100_5 / var_100_4)

				if var_100_6 > 0 and var_100_1 < var_100_6 then
					arg_97_1.talkMaxDuration = var_100_6

					if var_100_6 + var_100_0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_6 + var_100_0
					end
				end

				arg_97_1.text_.text = var_100_3
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)
				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_7 = math.max(var_100_1, arg_97_1.talkMaxDuration)

			if var_100_0 <= arg_97_1.time_ and arg_97_1.time_ < var_100_0 + var_100_7 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_0) / var_100_7

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_0 + var_100_7 and arg_97_1.time_ < var_100_0 + var_100_7 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play1101104028 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 1101104028
		arg_101_1.duration_ = 9

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play1101104029(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = "ST12"

			if arg_101_1.bgs_[var_104_0] == nil then
				local var_104_1 = Object.Instantiate(arg_101_1.paintGo_)

				var_104_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_104_0)
				var_104_1.name = var_104_0
				var_104_1.transform.parent = arg_101_1.stage_.transform
				var_104_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_101_1.bgs_[var_104_0] = var_104_1
			end

			local var_104_2 = 2

			if var_104_2 < arg_101_1.time_ and arg_101_1.time_ <= var_104_2 + arg_104_0 then
				local var_104_3 = manager.ui.mainCamera.transform.localPosition
				local var_104_4 = Vector3.New(0, 0, 10) + Vector3.New(var_104_3.x, var_104_3.y, 0)
				local var_104_5 = arg_101_1.bgs_.ST12

				var_104_5.transform.localPosition = var_104_4
				var_104_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_104_6 = var_104_5:GetComponent("SpriteRenderer")

				if var_104_6 and var_104_6.sprite then
					local var_104_7 = (var_104_5.transform.localPosition - var_104_3).z
					local var_104_8 = manager.ui.mainCameraCom_
					local var_104_9 = 2 * var_104_7 * Mathf.Tan(var_104_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_104_10 = var_104_9 * var_104_8.aspect
					local var_104_11 = var_104_6.sprite.bounds.size.x
					local var_104_12 = var_104_6.sprite.bounds.size.y
					local var_104_13 = var_104_10 / var_104_11
					local var_104_14 = var_104_9 / var_104_12
					local var_104_15 = var_104_14 < var_104_13 and var_104_13 or var_104_14

					var_104_5.transform.localScale = Vector3.New(var_104_15, var_104_15, 0)
				end

				for iter_104_0, iter_104_1 in pairs(arg_101_1.bgs_) do
					if iter_104_0 ~= "ST12" then
						iter_104_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_104_16 = 0

			if var_104_16 < arg_101_1.time_ and arg_101_1.time_ <= var_104_16 + arg_104_0 then
				arg_101_1.mask_.enabled = true
				arg_101_1.mask_.raycastTarget = true

				arg_101_1:SetGaussion(false)
			end

			local var_104_17 = 2

			if var_104_16 <= arg_101_1.time_ and arg_101_1.time_ < var_104_16 + var_104_17 then
				local var_104_18 = (arg_101_1.time_ - var_104_16) / var_104_17
				local var_104_19 = Color.New(0, 0, 0)

				var_104_19.a = Mathf.Lerp(0, 1, var_104_18)
				arg_101_1.mask_.color = var_104_19
			end

			if arg_101_1.time_ >= var_104_16 + var_104_17 and arg_101_1.time_ < var_104_16 + var_104_17 + arg_104_0 then
				local var_104_20 = Color.New(0, 0, 0)

				var_104_20.a = 1
				arg_101_1.mask_.color = var_104_20
			end

			local var_104_21 = 2

			if var_104_21 < arg_101_1.time_ and arg_101_1.time_ <= var_104_21 + arg_104_0 then
				arg_101_1.mask_.enabled = true
				arg_101_1.mask_.raycastTarget = true

				arg_101_1:SetGaussion(false)
			end

			local var_104_22 = 2

			if var_104_21 <= arg_101_1.time_ and arg_101_1.time_ < var_104_21 + var_104_22 then
				local var_104_23 = (arg_101_1.time_ - var_104_21) / var_104_22
				local var_104_24 = Color.New(0, 0, 0)

				var_104_24.a = Mathf.Lerp(1, 0, var_104_23)
				arg_101_1.mask_.color = var_104_24
			end

			if arg_101_1.time_ >= var_104_21 + var_104_22 and arg_101_1.time_ < var_104_21 + var_104_22 + arg_104_0 then
				local var_104_25 = Color.New(0, 0, 0)
				local var_104_26 = 0

				arg_101_1.mask_.enabled = false
				var_104_25.a = var_104_26
				arg_101_1.mask_.color = var_104_25
			end

			local var_104_27 = 0
			local var_104_28 = 1

			if var_104_27 < arg_101_1.time_ and arg_101_1.time_ <= var_104_27 + arg_104_0 then
				local var_104_29 = "play"
				local var_104_30 = "effect"

				arg_101_1:AudioAction(var_104_29, var_104_30, "se_story_side_1011", "se_story_side_1011_metalhit", "")
			end

			if arg_101_1.frameCnt_ <= 1 then
				arg_101_1.dialog_:SetActive(false)
			end

			local var_104_31 = 4
			local var_104_32 = 0.1

			if var_104_31 < arg_101_1.time_ and arg_101_1.time_ <= var_104_31 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0

				arg_101_1.dialog_:SetActive(true)

				arg_101_1.dialogCg_.alpha = 0

				local var_104_33 = LeanTween.value(arg_101_1.dialog_, 0, 1, 0.3)

				var_104_33:setOnUpdate(LuaHelper.FloatAction(function(arg_105_0)
					arg_101_1.dialogCg_.alpha = arg_105_0
				end))
				var_104_33:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_101_1.dialog_)
					var_104_33:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_101_1.duration_ = arg_101_1.duration_ + 0.3

				SetActive(arg_101_1.leftNameGo_, false)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_34 = arg_101_1:GetWordFromCfg(1101104028)
				local var_104_35 = arg_101_1:FormatText(var_104_34.content)

				arg_101_1.text_.text = var_104_35

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_36 = 4
				local var_104_37 = utf8.len(var_104_35)
				local var_104_38 = var_104_36 <= 0 and var_104_32 or var_104_32 * (var_104_37 / var_104_36)

				if var_104_38 > 0 and var_104_32 < var_104_38 then
					arg_101_1.talkMaxDuration = var_104_38
					var_104_31 = var_104_31 + 0.3

					if var_104_38 + var_104_31 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_38 + var_104_31
					end
				end

				arg_101_1.text_.text = var_104_35
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)
				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_39 = var_104_31 + 0.3
			local var_104_40 = math.max(var_104_32, arg_101_1.talkMaxDuration)

			if var_104_39 <= arg_101_1.time_ and arg_101_1.time_ < var_104_39 + var_104_40 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_39) / var_104_40

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_39 + var_104_40 and arg_101_1.time_ < var_104_39 + var_104_40 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play1101104029 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 1101104029
		arg_107_1.duration_ = 5

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play1101104030(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			local var_110_0 = arg_107_1.actors_["111101ui_story"].transform
			local var_110_1 = 0

			if var_110_1 < arg_107_1.time_ and arg_107_1.time_ <= var_110_1 + arg_110_0 then
				arg_107_1.var_.moveOldPos111101ui_story = var_110_0.localPosition
			end

			local var_110_2 = 0.001

			if var_110_1 <= arg_107_1.time_ and arg_107_1.time_ < var_110_1 + var_110_2 then
				local var_110_3 = (arg_107_1.time_ - var_110_1) / var_110_2
				local var_110_4 = Vector3.New(0, -0.83, -6)

				var_110_0.localPosition = Vector3.Lerp(arg_107_1.var_.moveOldPos111101ui_story, var_110_4, var_110_3)

				local var_110_5 = manager.ui.mainCamera.transform.position - var_110_0.position

				var_110_0.forward = Vector3.New(var_110_5.x, var_110_5.y, var_110_5.z)

				local var_110_6 = var_110_0.localEulerAngles

				var_110_6.z = 0
				var_110_6.x = 0
				var_110_0.localEulerAngles = var_110_6
			end

			if arg_107_1.time_ >= var_110_1 + var_110_2 and arg_107_1.time_ < var_110_1 + var_110_2 + arg_110_0 then
				var_110_0.localPosition = Vector3.New(0, -0.83, -6)

				local var_110_7 = manager.ui.mainCamera.transform.position - var_110_0.position

				var_110_0.forward = Vector3.New(var_110_7.x, var_110_7.y, var_110_7.z)

				local var_110_8 = var_110_0.localEulerAngles

				var_110_8.z = 0
				var_110_8.x = 0
				var_110_0.localEulerAngles = var_110_8
			end

			local var_110_9 = 0

			if var_110_9 < arg_107_1.time_ and arg_107_1.time_ <= var_110_9 + arg_110_0 then
				arg_107_1:PlayTimeline("111101ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0201cva")
			end

			local var_110_10 = 0
			local var_110_11 = 0.35

			if var_110_10 < arg_107_1.time_ and arg_107_1.time_ <= var_110_10 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				local var_110_12 = arg_107_1:FormatText(StoryNameCfg[7].name)

				arg_107_1.leftNameTxt_.text = var_110_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, true)
				arg_107_1.iconController_:SetSelectedState("hero")

				arg_107_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_107_1.callingController_:SetSelectedState("normal")

				arg_107_1.keyicon_.color = Color.New(1, 1, 1)
				arg_107_1.icon_.color = Color.New(1, 1, 1)

				local var_110_13 = arg_107_1:GetWordFromCfg(1101104029)
				local var_110_14 = arg_107_1:FormatText(var_110_13.content)

				arg_107_1.text_.text = var_110_14

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_15 = 14
				local var_110_16 = utf8.len(var_110_14)
				local var_110_17 = var_110_15 <= 0 and var_110_11 or var_110_11 * (var_110_16 / var_110_15)

				if var_110_17 > 0 and var_110_11 < var_110_17 then
					arg_107_1.talkMaxDuration = var_110_17

					if var_110_17 + var_110_10 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_17 + var_110_10
					end
				end

				arg_107_1.text_.text = var_110_14
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)
				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_18 = math.max(var_110_11, arg_107_1.talkMaxDuration)

			if var_110_10 <= arg_107_1.time_ and arg_107_1.time_ < var_110_10 + var_110_18 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_10) / var_110_18

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_10 + var_110_18 and arg_107_1.time_ < var_110_10 + var_110_18 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "111101ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_107_1:InitPlayNodeList()
	end,
	Play1101104030 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 1101104030
		arg_111_1.duration_ = 5

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play1101104031(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = 0
			local var_114_1 = 1.325

			if var_114_0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_0 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, false)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_2 = arg_111_1:GetWordFromCfg(1101104030)
				local var_114_3 = arg_111_1:FormatText(var_114_2.content)

				arg_111_1.text_.text = var_114_3

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_4 = 53
				local var_114_5 = utf8.len(var_114_3)
				local var_114_6 = var_114_4 <= 0 and var_114_1 or var_114_1 * (var_114_5 / var_114_4)

				if var_114_6 > 0 and var_114_1 < var_114_6 then
					arg_111_1.talkMaxDuration = var_114_6

					if var_114_6 + var_114_0 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_6 + var_114_0
					end
				end

				arg_111_1.text_.text = var_114_3
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)
				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_7 = math.max(var_114_1, arg_111_1.talkMaxDuration)

			if var_114_0 <= arg_111_1.time_ and arg_111_1.time_ < var_114_0 + var_114_7 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_0) / var_114_7

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_0 + var_114_7 and arg_111_1.time_ < var_114_0 + var_114_7 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play1101104031 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 1101104031
		arg_115_1.duration_ = 7.8

		local var_115_0 = {
			zh = 6,
			ja = 7.8
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
				arg_115_0:Play1101104032(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = arg_115_1.actors_["111101ui_story"].transform
			local var_118_1 = 0

			if var_118_1 < arg_115_1.time_ and arg_115_1.time_ <= var_118_1 + arg_118_0 then
				arg_115_1.var_.moveOldPos111101ui_story = var_118_0.localPosition
			end

			local var_118_2 = 0.001

			if var_118_1 <= arg_115_1.time_ and arg_115_1.time_ < var_118_1 + var_118_2 then
				local var_118_3 = (arg_115_1.time_ - var_118_1) / var_118_2
				local var_118_4 = Vector3.New(0, -0.83, -6)

				var_118_0.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos111101ui_story, var_118_4, var_118_3)

				local var_118_5 = manager.ui.mainCamera.transform.position - var_118_0.position

				var_118_0.forward = Vector3.New(var_118_5.x, var_118_5.y, var_118_5.z)

				local var_118_6 = var_118_0.localEulerAngles

				var_118_6.z = 0
				var_118_6.x = 0
				var_118_0.localEulerAngles = var_118_6
			end

			if arg_115_1.time_ >= var_118_1 + var_118_2 and arg_115_1.time_ < var_118_1 + var_118_2 + arg_118_0 then
				var_118_0.localPosition = Vector3.New(0, -0.83, -6)

				local var_118_7 = manager.ui.mainCamera.transform.position - var_118_0.position

				var_118_0.forward = Vector3.New(var_118_7.x, var_118_7.y, var_118_7.z)

				local var_118_8 = var_118_0.localEulerAngles

				var_118_8.z = 0
				var_118_8.x = 0
				var_118_0.localEulerAngles = var_118_8
			end

			local var_118_9 = arg_115_1.actors_["111101ui_story"]
			local var_118_10 = 0

			if var_118_10 < arg_115_1.time_ and arg_115_1.time_ <= var_118_10 + arg_118_0 and not isNil(var_118_9) and arg_115_1.var_.characterEffect111101ui_story == nil then
				arg_115_1.var_.characterEffect111101ui_story = var_118_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_11 = 0.200000002980232

			if var_118_10 <= arg_115_1.time_ and arg_115_1.time_ < var_118_10 + var_118_11 and not isNil(var_118_9) then
				local var_118_12 = (arg_115_1.time_ - var_118_10) / var_118_11

				if arg_115_1.var_.characterEffect111101ui_story and not isNil(var_118_9) then
					arg_115_1.var_.characterEffect111101ui_story.fillFlat = false
				end
			end

			if arg_115_1.time_ >= var_118_10 + var_118_11 and arg_115_1.time_ < var_118_10 + var_118_11 + arg_118_0 and not isNil(var_118_9) and arg_115_1.var_.characterEffect111101ui_story then
				arg_115_1.var_.characterEffect111101ui_story.fillFlat = false
			end

			local var_118_13 = 0

			if var_118_13 < arg_115_1.time_ and arg_115_1.time_ <= var_118_13 + arg_118_0 then
				arg_115_1:PlayTimeline("111101ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_118_14 = 0
			local var_118_15 = 0.75

			if var_118_14 < arg_115_1.time_ and arg_115_1.time_ <= var_118_14 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				local var_118_16 = arg_115_1:FormatText(StoryNameCfg[67].name)

				arg_115_1.leftNameTxt_.text = var_118_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_17 = arg_115_1:GetWordFromCfg(1101104031)
				local var_118_18 = arg_115_1:FormatText(var_118_17.content)

				arg_115_1.text_.text = var_118_18

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_19 = 30
				local var_118_20 = utf8.len(var_118_18)
				local var_118_21 = var_118_19 <= 0 and var_118_15 or var_118_15 * (var_118_20 / var_118_19)

				if var_118_21 > 0 and var_118_15 < var_118_21 then
					arg_115_1.talkMaxDuration = var_118_21

					if var_118_21 + var_118_14 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_21 + var_118_14
					end
				end

				arg_115_1.text_.text = var_118_18
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101104", "1101104031", "story_v_side_new_1101104.awb") ~= 0 then
					local var_118_22 = manager.audio:GetVoiceLength("story_v_side_new_1101104", "1101104031", "story_v_side_new_1101104.awb") / 1000

					if var_118_22 + var_118_14 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_22 + var_118_14
					end

					if var_118_17.prefab_name ~= "" and arg_115_1.actors_[var_118_17.prefab_name] ~= nil then
						local var_118_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_17.prefab_name].transform, "story_v_side_new_1101104", "1101104031", "story_v_side_new_1101104.awb")

						arg_115_1:RecordAudio("1101104031", var_118_23)
						arg_115_1:RecordAudio("1101104031", var_118_23)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_side_new_1101104", "1101104031", "story_v_side_new_1101104.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_side_new_1101104", "1101104031", "story_v_side_new_1101104.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_24 = math.max(var_118_15, arg_115_1.talkMaxDuration)

			if var_118_14 <= arg_115_1.time_ and arg_115_1.time_ < var_118_14 + var_118_24 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_14) / var_118_24

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_14 + var_118_24 and arg_115_1.time_ < var_118_14 + var_118_24 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "111101ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_115_1:InitPlayNodeList()
	end,
	Play1101104032 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 1101104032
		arg_119_1.duration_ = 5

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play1101104033(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = arg_119_1.actors_["111101ui_story"]
			local var_122_1 = 0

			if var_122_1 < arg_119_1.time_ and arg_119_1.time_ <= var_122_1 + arg_122_0 and not isNil(var_122_0) and arg_119_1.var_.characterEffect111101ui_story == nil then
				arg_119_1.var_.characterEffect111101ui_story = var_122_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_2 = 0.200000002980232

			if var_122_1 <= arg_119_1.time_ and arg_119_1.time_ < var_122_1 + var_122_2 and not isNil(var_122_0) then
				local var_122_3 = (arg_119_1.time_ - var_122_1) / var_122_2

				if arg_119_1.var_.characterEffect111101ui_story and not isNil(var_122_0) then
					local var_122_4 = Mathf.Lerp(0, 0.5, var_122_3)

					arg_119_1.var_.characterEffect111101ui_story.fillFlat = true
					arg_119_1.var_.characterEffect111101ui_story.fillRatio = var_122_4
				end
			end

			if arg_119_1.time_ >= var_122_1 + var_122_2 and arg_119_1.time_ < var_122_1 + var_122_2 + arg_122_0 and not isNil(var_122_0) and arg_119_1.var_.characterEffect111101ui_story then
				local var_122_5 = 0.5

				arg_119_1.var_.characterEffect111101ui_story.fillFlat = true
				arg_119_1.var_.characterEffect111101ui_story.fillRatio = var_122_5
			end

			local var_122_6 = 0
			local var_122_7 = 0.625

			if var_122_6 < arg_119_1.time_ and arg_119_1.time_ <= var_122_6 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, false)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_8 = arg_119_1:GetWordFromCfg(1101104032)
				local var_122_9 = arg_119_1:FormatText(var_122_8.content)

				arg_119_1.text_.text = var_122_9

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_10 = 25
				local var_122_11 = utf8.len(var_122_9)
				local var_122_12 = var_122_10 <= 0 and var_122_7 or var_122_7 * (var_122_11 / var_122_10)

				if var_122_12 > 0 and var_122_7 < var_122_12 then
					arg_119_1.talkMaxDuration = var_122_12

					if var_122_12 + var_122_6 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_12 + var_122_6
					end
				end

				arg_119_1.text_.text = var_122_9
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)
				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_13 = math.max(var_122_7, arg_119_1.talkMaxDuration)

			if var_122_6 <= arg_119_1.time_ and arg_119_1.time_ < var_122_6 + var_122_13 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_6) / var_122_13

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_6 + var_122_13 and arg_119_1.time_ < var_122_6 + var_122_13 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {}

		arg_119_1:InitPlayNodeList()
	end,
	Play1101104033 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 1101104033
		arg_123_1.duration_ = 5

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play1101104034(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = 0
			local var_126_1 = 0.7

			if var_126_0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_0 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, false)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_2 = arg_123_1:GetWordFromCfg(1101104033)
				local var_126_3 = arg_123_1:FormatText(var_126_2.content)

				arg_123_1.text_.text = var_126_3

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_4 = 28
				local var_126_5 = utf8.len(var_126_3)
				local var_126_6 = var_126_4 <= 0 and var_126_1 or var_126_1 * (var_126_5 / var_126_4)

				if var_126_6 > 0 and var_126_1 < var_126_6 then
					arg_123_1.talkMaxDuration = var_126_6

					if var_126_6 + var_126_0 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_6 + var_126_0
					end
				end

				arg_123_1.text_.text = var_126_3
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)
				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_7 = math.max(var_126_1, arg_123_1.talkMaxDuration)

			if var_126_0 <= arg_123_1.time_ and arg_123_1.time_ < var_126_0 + var_126_7 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_0) / var_126_7

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_0 + var_126_7 and arg_123_1.time_ < var_126_0 + var_126_7 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play1101104034 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 1101104034
		arg_127_1.duration_ = 8.33

		local var_127_0 = {
			zh = 8.133,
			ja = 8.333
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
				arg_127_0:Play1101104035(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = arg_127_1.actors_["111101ui_story"].transform
			local var_130_1 = 4

			if var_130_1 < arg_127_1.time_ and arg_127_1.time_ <= var_130_1 + arg_130_0 then
				arg_127_1.var_.moveOldPos111101ui_story = var_130_0.localPosition
			end

			local var_130_2 = 0.001

			if var_130_1 <= arg_127_1.time_ and arg_127_1.time_ < var_130_1 + var_130_2 then
				local var_130_3 = (arg_127_1.time_ - var_130_1) / var_130_2
				local var_130_4 = Vector3.New(0, -0.83, -6)

				var_130_0.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPos111101ui_story, var_130_4, var_130_3)

				local var_130_5 = manager.ui.mainCamera.transform.position - var_130_0.position

				var_130_0.forward = Vector3.New(var_130_5.x, var_130_5.y, var_130_5.z)

				local var_130_6 = var_130_0.localEulerAngles

				var_130_6.z = 0
				var_130_6.x = 0
				var_130_0.localEulerAngles = var_130_6
			end

			if arg_127_1.time_ >= var_130_1 + var_130_2 and arg_127_1.time_ < var_130_1 + var_130_2 + arg_130_0 then
				var_130_0.localPosition = Vector3.New(0, -0.83, -6)

				local var_130_7 = manager.ui.mainCamera.transform.position - var_130_0.position

				var_130_0.forward = Vector3.New(var_130_7.x, var_130_7.y, var_130_7.z)

				local var_130_8 = var_130_0.localEulerAngles

				var_130_8.z = 0
				var_130_8.x = 0
				var_130_0.localEulerAngles = var_130_8
			end

			local var_130_9 = arg_127_1.actors_["111101ui_story"]
			local var_130_10 = 4

			if var_130_10 < arg_127_1.time_ and arg_127_1.time_ <= var_130_10 + arg_130_0 and not isNil(var_130_9) and arg_127_1.var_.characterEffect111101ui_story == nil then
				arg_127_1.var_.characterEffect111101ui_story = var_130_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_11 = 0.200000002980232

			if var_130_10 <= arg_127_1.time_ and arg_127_1.time_ < var_130_10 + var_130_11 and not isNil(var_130_9) then
				local var_130_12 = (arg_127_1.time_ - var_130_10) / var_130_11

				if arg_127_1.var_.characterEffect111101ui_story and not isNil(var_130_9) then
					arg_127_1.var_.characterEffect111101ui_story.fillFlat = false
				end
			end

			if arg_127_1.time_ >= var_130_10 + var_130_11 and arg_127_1.time_ < var_130_10 + var_130_11 + arg_130_0 and not isNil(var_130_9) and arg_127_1.var_.characterEffect111101ui_story then
				arg_127_1.var_.characterEffect111101ui_story.fillFlat = false
			end

			local var_130_13 = 4

			if var_130_13 < arg_127_1.time_ and arg_127_1.time_ <= var_130_13 + arg_130_0 then
				arg_127_1:PlayTimeline("111101ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action7_1")
			end

			local var_130_14 = 4

			if var_130_14 < arg_127_1.time_ and arg_127_1.time_ <= var_130_14 + arg_130_0 then
				arg_127_1:PlayTimeline("111101ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_130_15 = 2

			if var_130_15 < arg_127_1.time_ and arg_127_1.time_ <= var_130_15 + arg_130_0 then
				local var_130_16 = manager.ui.mainCamera.transform.localPosition
				local var_130_17 = Vector3.New(0, 0, 10) + Vector3.New(var_130_16.x, var_130_16.y, 0)
				local var_130_18 = arg_127_1.bgs_.ST12

				var_130_18.transform.localPosition = var_130_17
				var_130_18.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_130_19 = var_130_18:GetComponent("SpriteRenderer")

				if var_130_19 and var_130_19.sprite then
					local var_130_20 = (var_130_18.transform.localPosition - var_130_16).z
					local var_130_21 = manager.ui.mainCameraCom_
					local var_130_22 = 2 * var_130_20 * Mathf.Tan(var_130_21.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_130_23 = var_130_22 * var_130_21.aspect
					local var_130_24 = var_130_19.sprite.bounds.size.x
					local var_130_25 = var_130_19.sprite.bounds.size.y
					local var_130_26 = var_130_23 / var_130_24
					local var_130_27 = var_130_22 / var_130_25
					local var_130_28 = var_130_27 < var_130_26 and var_130_26 or var_130_27

					var_130_18.transform.localScale = Vector3.New(var_130_28, var_130_28, 0)
				end

				for iter_130_0, iter_130_1 in pairs(arg_127_1.bgs_) do
					if iter_130_0 ~= "ST12" then
						iter_130_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_130_29 = 0

			if var_130_29 < arg_127_1.time_ and arg_127_1.time_ <= var_130_29 + arg_130_0 then
				arg_127_1.mask_.enabled = true
				arg_127_1.mask_.raycastTarget = true

				arg_127_1:SetGaussion(false)
			end

			local var_130_30 = 2

			if var_130_29 <= arg_127_1.time_ and arg_127_1.time_ < var_130_29 + var_130_30 then
				local var_130_31 = (arg_127_1.time_ - var_130_29) / var_130_30
				local var_130_32 = Color.New(0, 0, 0)

				var_130_32.a = Mathf.Lerp(0, 1, var_130_31)
				arg_127_1.mask_.color = var_130_32
			end

			if arg_127_1.time_ >= var_130_29 + var_130_30 and arg_127_1.time_ < var_130_29 + var_130_30 + arg_130_0 then
				local var_130_33 = Color.New(0, 0, 0)

				var_130_33.a = 1
				arg_127_1.mask_.color = var_130_33
			end

			local var_130_34 = 2

			if var_130_34 < arg_127_1.time_ and arg_127_1.time_ <= var_130_34 + arg_130_0 then
				arg_127_1.mask_.enabled = true
				arg_127_1.mask_.raycastTarget = true

				arg_127_1:SetGaussion(false)
			end

			local var_130_35 = 2

			if var_130_34 <= arg_127_1.time_ and arg_127_1.time_ < var_130_34 + var_130_35 then
				local var_130_36 = (arg_127_1.time_ - var_130_34) / var_130_35
				local var_130_37 = Color.New(0, 0, 0)

				var_130_37.a = Mathf.Lerp(1, 0, var_130_36)
				arg_127_1.mask_.color = var_130_37
			end

			if arg_127_1.time_ >= var_130_34 + var_130_35 and arg_127_1.time_ < var_130_34 + var_130_35 + arg_130_0 then
				local var_130_38 = Color.New(0, 0, 0)
				local var_130_39 = 0

				arg_127_1.mask_.enabled = false
				var_130_38.a = var_130_39
				arg_127_1.mask_.color = var_130_38
			end

			local var_130_40 = arg_127_1.actors_["111101ui_story"].transform
			local var_130_41 = 2

			if var_130_41 < arg_127_1.time_ and arg_127_1.time_ <= var_130_41 + arg_130_0 then
				arg_127_1.var_.moveOldPos111101ui_story = var_130_40.localPosition
			end

			local var_130_42 = 0.001

			if var_130_41 <= arg_127_1.time_ and arg_127_1.time_ < var_130_41 + var_130_42 then
				local var_130_43 = (arg_127_1.time_ - var_130_41) / var_130_42
				local var_130_44 = Vector3.New(0, 100, 0)

				var_130_40.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPos111101ui_story, var_130_44, var_130_43)

				local var_130_45 = manager.ui.mainCamera.transform.position - var_130_40.position

				var_130_40.forward = Vector3.New(var_130_45.x, var_130_45.y, var_130_45.z)

				local var_130_46 = var_130_40.localEulerAngles

				var_130_46.z = 0
				var_130_46.x = 0
				var_130_40.localEulerAngles = var_130_46
			end

			if arg_127_1.time_ >= var_130_41 + var_130_42 and arg_127_1.time_ < var_130_41 + var_130_42 + arg_130_0 then
				var_130_40.localPosition = Vector3.New(0, 100, 0)

				local var_130_47 = manager.ui.mainCamera.transform.position - var_130_40.position

				var_130_40.forward = Vector3.New(var_130_47.x, var_130_47.y, var_130_47.z)

				local var_130_48 = var_130_40.localEulerAngles

				var_130_48.z = 0
				var_130_48.x = 0
				var_130_40.localEulerAngles = var_130_48
			end

			local var_130_49 = 2

			arg_127_1.isInRecall_ = false

			if var_130_49 < arg_127_1.time_ and arg_127_1.time_ <= var_130_49 + arg_130_0 then
				arg_127_1.screenFilterGo_:SetActive(true)

				arg_127_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile")

				for iter_130_2, iter_130_3 in pairs(arg_127_1.actors_) do
					local var_130_50 = iter_130_3:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_130_4, iter_130_5 in ipairs(var_130_50) do
						if iter_130_5.color.r > 0.51 then
							iter_130_5.color = Color.New(1, 1, 1)
						else
							iter_130_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_130_51 = 0.034000001847744

			if var_130_49 <= arg_127_1.time_ and arg_127_1.time_ < var_130_49 + var_130_51 then
				local var_130_52 = (arg_127_1.time_ - var_130_49) / var_130_51

				arg_127_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, var_130_52)
			end

			if arg_127_1.time_ >= var_130_49 + var_130_51 and arg_127_1.time_ < var_130_49 + var_130_51 + arg_130_0 then
				arg_127_1.screenFilterEffect_.weight = 1
			end

			if arg_127_1.frameCnt_ <= 1 then
				arg_127_1.dialog_:SetActive(false)
			end

			local var_130_53 = 4
			local var_130_54 = 0.425

			if var_130_53 < arg_127_1.time_ and arg_127_1.time_ <= var_130_53 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0

				arg_127_1.dialog_:SetActive(true)

				arg_127_1.dialogCg_.alpha = 0

				local var_130_55 = LeanTween.value(arg_127_1.dialog_, 0, 1, 0.3)

				var_130_55:setOnUpdate(LuaHelper.FloatAction(function(arg_131_0)
					arg_127_1.dialogCg_.alpha = arg_131_0
				end))
				var_130_55:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_127_1.dialog_)
					var_130_55:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_127_1.duration_ = arg_127_1.duration_ + 0.3

				SetActive(arg_127_1.leftNameGo_, true)

				local var_130_56 = arg_127_1:FormatText(StoryNameCfg[67].name)

				arg_127_1.leftNameTxt_.text = var_130_56

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_57 = arg_127_1:GetWordFromCfg(1101104034)
				local var_130_58 = arg_127_1:FormatText(var_130_57.content)

				arg_127_1.text_.text = var_130_58

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_59 = 17
				local var_130_60 = utf8.len(var_130_58)
				local var_130_61 = var_130_59 <= 0 and var_130_54 or var_130_54 * (var_130_60 / var_130_59)

				if var_130_61 > 0 and var_130_54 < var_130_61 then
					arg_127_1.talkMaxDuration = var_130_61
					var_130_53 = var_130_53 + 0.3

					if var_130_61 + var_130_53 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_61 + var_130_53
					end
				end

				arg_127_1.text_.text = var_130_58
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101104", "1101104034", "story_v_side_new_1101104.awb") ~= 0 then
					local var_130_62 = manager.audio:GetVoiceLength("story_v_side_new_1101104", "1101104034", "story_v_side_new_1101104.awb") / 1000

					if var_130_62 + var_130_53 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_62 + var_130_53
					end

					if var_130_57.prefab_name ~= "" and arg_127_1.actors_[var_130_57.prefab_name] ~= nil then
						local var_130_63 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_57.prefab_name].transform, "story_v_side_new_1101104", "1101104034", "story_v_side_new_1101104.awb")

						arg_127_1:RecordAudio("1101104034", var_130_63)
						arg_127_1:RecordAudio("1101104034", var_130_63)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_side_new_1101104", "1101104034", "story_v_side_new_1101104.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_side_new_1101104", "1101104034", "story_v_side_new_1101104.awb")
				end

				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_64 = var_130_53 + 0.3
			local var_130_65 = math.max(var_130_54, arg_127_1.talkMaxDuration)

			if var_130_64 <= arg_127_1.time_ and arg_127_1.time_ < var_130_64 + var_130_65 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_64) / var_130_65

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_64 + var_130_65 and arg_127_1.time_ < var_130_64 + var_130_65 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "111101ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "111101ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_127_1:InitPlayNodeList()
	end,
	Play1101104035 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 1101104035
		arg_133_1.duration_ = 9

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play1101104036(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = 2

			if var_136_0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_0 + arg_136_0 then
				local var_136_1 = manager.ui.mainCamera.transform.localPosition
				local var_136_2 = Vector3.New(0, 0, 10) + Vector3.New(var_136_1.x, var_136_1.y, 0)
				local var_136_3 = arg_133_1.bgs_.ST12

				var_136_3.transform.localPosition = var_136_2
				var_136_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_136_4 = var_136_3:GetComponent("SpriteRenderer")

				if var_136_4 and var_136_4.sprite then
					local var_136_5 = (var_136_3.transform.localPosition - var_136_1).z
					local var_136_6 = manager.ui.mainCameraCom_
					local var_136_7 = 2 * var_136_5 * Mathf.Tan(var_136_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_136_8 = var_136_7 * var_136_6.aspect
					local var_136_9 = var_136_4.sprite.bounds.size.x
					local var_136_10 = var_136_4.sprite.bounds.size.y
					local var_136_11 = var_136_8 / var_136_9
					local var_136_12 = var_136_7 / var_136_10
					local var_136_13 = var_136_12 < var_136_11 and var_136_11 or var_136_12

					var_136_3.transform.localScale = Vector3.New(var_136_13, var_136_13, 0)
				end

				for iter_136_0, iter_136_1 in pairs(arg_133_1.bgs_) do
					if iter_136_0 ~= "ST12" then
						iter_136_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_136_14 = 0

			if var_136_14 < arg_133_1.time_ and arg_133_1.time_ <= var_136_14 + arg_136_0 then
				arg_133_1.mask_.enabled = true
				arg_133_1.mask_.raycastTarget = true

				arg_133_1:SetGaussion(false)
			end

			local var_136_15 = 2

			if var_136_14 <= arg_133_1.time_ and arg_133_1.time_ < var_136_14 + var_136_15 then
				local var_136_16 = (arg_133_1.time_ - var_136_14) / var_136_15
				local var_136_17 = Color.New(0, 0, 0)

				var_136_17.a = Mathf.Lerp(0, 1, var_136_16)
				arg_133_1.mask_.color = var_136_17
			end

			if arg_133_1.time_ >= var_136_14 + var_136_15 and arg_133_1.time_ < var_136_14 + var_136_15 + arg_136_0 then
				local var_136_18 = Color.New(0, 0, 0)

				var_136_18.a = 1
				arg_133_1.mask_.color = var_136_18
			end

			local var_136_19 = 2

			if var_136_19 < arg_133_1.time_ and arg_133_1.time_ <= var_136_19 + arg_136_0 then
				arg_133_1.mask_.enabled = true
				arg_133_1.mask_.raycastTarget = true

				arg_133_1:SetGaussion(false)
			end

			local var_136_20 = 2

			if var_136_19 <= arg_133_1.time_ and arg_133_1.time_ < var_136_19 + var_136_20 then
				local var_136_21 = (arg_133_1.time_ - var_136_19) / var_136_20
				local var_136_22 = Color.New(0, 0, 0)

				var_136_22.a = Mathf.Lerp(1, 0, var_136_21)
				arg_133_1.mask_.color = var_136_22
			end

			if arg_133_1.time_ >= var_136_19 + var_136_20 and arg_133_1.time_ < var_136_19 + var_136_20 + arg_136_0 then
				local var_136_23 = Color.New(0, 0, 0)
				local var_136_24 = 0

				arg_133_1.mask_.enabled = false
				var_136_23.a = var_136_24
				arg_133_1.mask_.color = var_136_23
			end

			local var_136_25 = 2

			arg_133_1.isInRecall_ = false

			if var_136_25 < arg_133_1.time_ and arg_133_1.time_ <= var_136_25 + arg_136_0 then
				arg_133_1.screenFilterGo_:SetActive(false)

				for iter_136_2, iter_136_3 in pairs(arg_133_1.actors_) do
					local var_136_26 = iter_136_3:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_136_4, iter_136_5 in ipairs(var_136_26) do
						if iter_136_5.color.r > 0.51 then
							iter_136_5.color = Color.New(1, 1, 1)
						else
							iter_136_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_136_27 = 0.034000001847744

			if var_136_25 <= arg_133_1.time_ and arg_133_1.time_ < var_136_25 + var_136_27 then
				local var_136_28 = (arg_133_1.time_ - var_136_25) / var_136_27

				arg_133_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, var_136_28)
			end

			if arg_133_1.time_ >= var_136_25 + var_136_27 and arg_133_1.time_ < var_136_25 + var_136_27 + arg_136_0 then
				arg_133_1.screenFilterEffect_.weight = 0
			end

			local var_136_29 = arg_133_1.actors_["111101ui_story"].transform
			local var_136_30 = 4

			if var_136_30 < arg_133_1.time_ and arg_133_1.time_ <= var_136_30 + arg_136_0 then
				arg_133_1.var_.moveOldPos111101ui_story = var_136_29.localPosition
			end

			local var_136_31 = 0.001

			if var_136_30 <= arg_133_1.time_ and arg_133_1.time_ < var_136_30 + var_136_31 then
				local var_136_32 = (arg_133_1.time_ - var_136_30) / var_136_31
				local var_136_33 = Vector3.New(0, -0.83, -6)

				var_136_29.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos111101ui_story, var_136_33, var_136_32)

				local var_136_34 = manager.ui.mainCamera.transform.position - var_136_29.position

				var_136_29.forward = Vector3.New(var_136_34.x, var_136_34.y, var_136_34.z)

				local var_136_35 = var_136_29.localEulerAngles

				var_136_35.z = 0
				var_136_35.x = 0
				var_136_29.localEulerAngles = var_136_35
			end

			if arg_133_1.time_ >= var_136_30 + var_136_31 and arg_133_1.time_ < var_136_30 + var_136_31 + arg_136_0 then
				var_136_29.localPosition = Vector3.New(0, -0.83, -6)

				local var_136_36 = manager.ui.mainCamera.transform.position - var_136_29.position

				var_136_29.forward = Vector3.New(var_136_36.x, var_136_36.y, var_136_36.z)

				local var_136_37 = var_136_29.localEulerAngles

				var_136_37.z = 0
				var_136_37.x = 0
				var_136_29.localEulerAngles = var_136_37
			end

			local var_136_38 = arg_133_1.actors_["111101ui_story"]
			local var_136_39 = 4

			if var_136_39 < arg_133_1.time_ and arg_133_1.time_ <= var_136_39 + arg_136_0 and not isNil(var_136_38) and arg_133_1.var_.characterEffect111101ui_story == nil then
				arg_133_1.var_.characterEffect111101ui_story = var_136_38:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_40 = 0.200000002980232

			if var_136_39 <= arg_133_1.time_ and arg_133_1.time_ < var_136_39 + var_136_40 and not isNil(var_136_38) then
				local var_136_41 = (arg_133_1.time_ - var_136_39) / var_136_40

				if arg_133_1.var_.characterEffect111101ui_story and not isNil(var_136_38) then
					arg_133_1.var_.characterEffect111101ui_story.fillFlat = false
				end
			end

			if arg_133_1.time_ >= var_136_39 + var_136_40 and arg_133_1.time_ < var_136_39 + var_136_40 + arg_136_0 and not isNil(var_136_38) and arg_133_1.var_.characterEffect111101ui_story then
				arg_133_1.var_.characterEffect111101ui_story.fillFlat = false
			end

			local var_136_42 = 4

			if var_136_42 < arg_133_1.time_ and arg_133_1.time_ <= var_136_42 + arg_136_0 then
				arg_133_1:PlayTimeline("111101ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action1_1")
			end

			local var_136_43 = 4

			if var_136_43 < arg_133_1.time_ and arg_133_1.time_ <= var_136_43 + arg_136_0 then
				arg_133_1:PlayTimeline("111101ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_136_44 = arg_133_1.actors_["111101ui_story"].transform
			local var_136_45 = 2

			if var_136_45 < arg_133_1.time_ and arg_133_1.time_ <= var_136_45 + arg_136_0 then
				arg_133_1.var_.moveOldPos111101ui_story = var_136_44.localPosition
			end

			local var_136_46 = 0.001

			if var_136_45 <= arg_133_1.time_ and arg_133_1.time_ < var_136_45 + var_136_46 then
				local var_136_47 = (arg_133_1.time_ - var_136_45) / var_136_46
				local var_136_48 = Vector3.New(0, 100, 0)

				var_136_44.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos111101ui_story, var_136_48, var_136_47)

				local var_136_49 = manager.ui.mainCamera.transform.position - var_136_44.position

				var_136_44.forward = Vector3.New(var_136_49.x, var_136_49.y, var_136_49.z)

				local var_136_50 = var_136_44.localEulerAngles

				var_136_50.z = 0
				var_136_50.x = 0
				var_136_44.localEulerAngles = var_136_50
			end

			if arg_133_1.time_ >= var_136_45 + var_136_46 and arg_133_1.time_ < var_136_45 + var_136_46 + arg_136_0 then
				var_136_44.localPosition = Vector3.New(0, 100, 0)

				local var_136_51 = manager.ui.mainCamera.transform.position - var_136_44.position

				var_136_44.forward = Vector3.New(var_136_51.x, var_136_51.y, var_136_51.z)

				local var_136_52 = var_136_44.localEulerAngles

				var_136_52.z = 0
				var_136_52.x = 0
				var_136_44.localEulerAngles = var_136_52
			end

			if arg_133_1.frameCnt_ <= 1 then
				arg_133_1.dialog_:SetActive(false)
			end

			local var_136_53 = 4
			local var_136_54 = 0.6

			if var_136_53 < arg_133_1.time_ and arg_133_1.time_ <= var_136_53 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0

				arg_133_1.dialog_:SetActive(true)

				arg_133_1.dialogCg_.alpha = 0

				local var_136_55 = LeanTween.value(arg_133_1.dialog_, 0, 1, 0.3)

				var_136_55:setOnUpdate(LuaHelper.FloatAction(function(arg_137_0)
					arg_133_1.dialogCg_.alpha = arg_137_0
				end))
				var_136_55:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_133_1.dialog_)
					var_136_55:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_133_1.duration_ = arg_133_1.duration_ + 0.3

				SetActive(arg_133_1.leftNameGo_, true)

				local var_136_56 = arg_133_1:FormatText(StoryNameCfg[7].name)

				arg_133_1.leftNameTxt_.text = var_136_56

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, true)
				arg_133_1.iconController_:SetSelectedState("hero")

				arg_133_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_133_1.callingController_:SetSelectedState("normal")

				arg_133_1.keyicon_.color = Color.New(1, 1, 1)
				arg_133_1.icon_.color = Color.New(1, 1, 1)

				local var_136_57 = arg_133_1:GetWordFromCfg(1101104035)
				local var_136_58 = arg_133_1:FormatText(var_136_57.content)

				arg_133_1.text_.text = var_136_58

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_59 = 24
				local var_136_60 = utf8.len(var_136_58)
				local var_136_61 = var_136_59 <= 0 and var_136_54 or var_136_54 * (var_136_60 / var_136_59)

				if var_136_61 > 0 and var_136_54 < var_136_61 then
					arg_133_1.talkMaxDuration = var_136_61
					var_136_53 = var_136_53 + 0.3

					if var_136_61 + var_136_53 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_61 + var_136_53
					end
				end

				arg_133_1.text_.text = var_136_58
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)
				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_62 = var_136_53 + 0.3
			local var_136_63 = math.max(var_136_54, arg_133_1.talkMaxDuration)

			if var_136_62 <= arg_133_1.time_ and arg_133_1.time_ < var_136_62 + var_136_63 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_62) / var_136_63

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_62 + var_136_63 and arg_133_1.time_ < var_136_62 + var_136_63 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "111101ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "111101ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_133_1:InitPlayNodeList()
	end,
	Play1101104036 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 1101104036
		arg_139_1.duration_ = 4.27

		local var_139_0 = {
			zh = 2.266,
			ja = 4.266
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
				arg_139_0:Play1101104037(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = arg_139_1.actors_["111101ui_story"].transform
			local var_142_1 = 0

			if var_142_1 < arg_139_1.time_ and arg_139_1.time_ <= var_142_1 + arg_142_0 then
				arg_139_1.var_.moveOldPos111101ui_story = var_142_0.localPosition
			end

			local var_142_2 = 0.001

			if var_142_1 <= arg_139_1.time_ and arg_139_1.time_ < var_142_1 + var_142_2 then
				local var_142_3 = (arg_139_1.time_ - var_142_1) / var_142_2
				local var_142_4 = Vector3.New(0, -0.83, -6)

				var_142_0.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos111101ui_story, var_142_4, var_142_3)

				local var_142_5 = manager.ui.mainCamera.transform.position - var_142_0.position

				var_142_0.forward = Vector3.New(var_142_5.x, var_142_5.y, var_142_5.z)

				local var_142_6 = var_142_0.localEulerAngles

				var_142_6.z = 0
				var_142_6.x = 0
				var_142_0.localEulerAngles = var_142_6
			end

			if arg_139_1.time_ >= var_142_1 + var_142_2 and arg_139_1.time_ < var_142_1 + var_142_2 + arg_142_0 then
				var_142_0.localPosition = Vector3.New(0, -0.83, -6)

				local var_142_7 = manager.ui.mainCamera.transform.position - var_142_0.position

				var_142_0.forward = Vector3.New(var_142_7.x, var_142_7.y, var_142_7.z)

				local var_142_8 = var_142_0.localEulerAngles

				var_142_8.z = 0
				var_142_8.x = 0
				var_142_0.localEulerAngles = var_142_8
			end

			local var_142_9 = arg_139_1.actors_["111101ui_story"]
			local var_142_10 = 0

			if var_142_10 < arg_139_1.time_ and arg_139_1.time_ <= var_142_10 + arg_142_0 and not isNil(var_142_9) and arg_139_1.var_.characterEffect111101ui_story == nil then
				arg_139_1.var_.characterEffect111101ui_story = var_142_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_11 = 0.200000002980232

			if var_142_10 <= arg_139_1.time_ and arg_139_1.time_ < var_142_10 + var_142_11 and not isNil(var_142_9) then
				local var_142_12 = (arg_139_1.time_ - var_142_10) / var_142_11

				if arg_139_1.var_.characterEffect111101ui_story and not isNil(var_142_9) then
					arg_139_1.var_.characterEffect111101ui_story.fillFlat = false
				end
			end

			if arg_139_1.time_ >= var_142_10 + var_142_11 and arg_139_1.time_ < var_142_10 + var_142_11 + arg_142_0 and not isNil(var_142_9) and arg_139_1.var_.characterEffect111101ui_story then
				arg_139_1.var_.characterEffect111101ui_story.fillFlat = false
			end

			local var_142_13 = 0

			if var_142_13 < arg_139_1.time_ and arg_139_1.time_ <= var_142_13 + arg_142_0 then
				arg_139_1:PlayTimeline("111101ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action2_1")
			end

			local var_142_14 = 0

			if var_142_14 < arg_139_1.time_ and arg_139_1.time_ <= var_142_14 + arg_142_0 then
				arg_139_1:PlayTimeline("111101ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_142_15 = 0
			local var_142_16 = 0.175

			if var_142_15 < arg_139_1.time_ and arg_139_1.time_ <= var_142_15 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				local var_142_17 = arg_139_1:FormatText(StoryNameCfg[67].name)

				arg_139_1.leftNameTxt_.text = var_142_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_18 = arg_139_1:GetWordFromCfg(1101104036)
				local var_142_19 = arg_139_1:FormatText(var_142_18.content)

				arg_139_1.text_.text = var_142_19

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_20 = 7
				local var_142_21 = utf8.len(var_142_19)
				local var_142_22 = var_142_20 <= 0 and var_142_16 or var_142_16 * (var_142_21 / var_142_20)

				if var_142_22 > 0 and var_142_16 < var_142_22 then
					arg_139_1.talkMaxDuration = var_142_22

					if var_142_22 + var_142_15 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_22 + var_142_15
					end
				end

				arg_139_1.text_.text = var_142_19
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101104", "1101104036", "story_v_side_new_1101104.awb") ~= 0 then
					local var_142_23 = manager.audio:GetVoiceLength("story_v_side_new_1101104", "1101104036", "story_v_side_new_1101104.awb") / 1000

					if var_142_23 + var_142_15 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_23 + var_142_15
					end

					if var_142_18.prefab_name ~= "" and arg_139_1.actors_[var_142_18.prefab_name] ~= nil then
						local var_142_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_18.prefab_name].transform, "story_v_side_new_1101104", "1101104036", "story_v_side_new_1101104.awb")

						arg_139_1:RecordAudio("1101104036", var_142_24)
						arg_139_1:RecordAudio("1101104036", var_142_24)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_side_new_1101104", "1101104036", "story_v_side_new_1101104.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_side_new_1101104", "1101104036", "story_v_side_new_1101104.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_25 = math.max(var_142_16, arg_139_1.talkMaxDuration)

			if var_142_15 <= arg_139_1.time_ and arg_139_1.time_ < var_142_15 + var_142_25 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_15) / var_142_25

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_15 + var_142_25 and arg_139_1.time_ < var_142_15 + var_142_25 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "111101ui_story",
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
	Play1101104037 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 1101104037
		arg_143_1.duration_ = 5

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play1101104038(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = arg_143_1.actors_["111101ui_story"]
			local var_146_1 = 0

			if var_146_1 < arg_143_1.time_ and arg_143_1.time_ <= var_146_1 + arg_146_0 and not isNil(var_146_0) and arg_143_1.var_.characterEffect111101ui_story == nil then
				arg_143_1.var_.characterEffect111101ui_story = var_146_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_2 = 0.200000002980232

			if var_146_1 <= arg_143_1.time_ and arg_143_1.time_ < var_146_1 + var_146_2 and not isNil(var_146_0) then
				local var_146_3 = (arg_143_1.time_ - var_146_1) / var_146_2

				if arg_143_1.var_.characterEffect111101ui_story and not isNil(var_146_0) then
					local var_146_4 = Mathf.Lerp(0, 0.5, var_146_3)

					arg_143_1.var_.characterEffect111101ui_story.fillFlat = true
					arg_143_1.var_.characterEffect111101ui_story.fillRatio = var_146_4
				end
			end

			if arg_143_1.time_ >= var_146_1 + var_146_2 and arg_143_1.time_ < var_146_1 + var_146_2 + arg_146_0 and not isNil(var_146_0) and arg_143_1.var_.characterEffect111101ui_story then
				local var_146_5 = 0.5

				arg_143_1.var_.characterEffect111101ui_story.fillFlat = true
				arg_143_1.var_.characterEffect111101ui_story.fillRatio = var_146_5
			end

			local var_146_6 = 0
			local var_146_7 = 0.225

			if var_146_6 < arg_143_1.time_ and arg_143_1.time_ <= var_146_6 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, false)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_8 = arg_143_1:GetWordFromCfg(1101104037)
				local var_146_9 = arg_143_1:FormatText(var_146_8.content)

				arg_143_1.text_.text = var_146_9

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_10 = 9
				local var_146_11 = utf8.len(var_146_9)
				local var_146_12 = var_146_10 <= 0 and var_146_7 or var_146_7 * (var_146_11 / var_146_10)

				if var_146_12 > 0 and var_146_7 < var_146_12 then
					arg_143_1.talkMaxDuration = var_146_12

					if var_146_12 + var_146_6 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_12 + var_146_6
					end
				end

				arg_143_1.text_.text = var_146_9
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)
				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_13 = math.max(var_146_7, arg_143_1.talkMaxDuration)

			if var_146_6 <= arg_143_1.time_ and arg_143_1.time_ < var_146_6 + var_146_13 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_6) / var_146_13

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_6 + var_146_13 and arg_143_1.time_ < var_146_6 + var_146_13 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play1101104038 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 1101104038
		arg_147_1.duration_ = 5.37

		local var_147_0 = {
			zh = 3.1,
			ja = 5.366
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
				arg_147_0:Play1101104039(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = arg_147_1.actors_["111101ui_story"].transform
			local var_150_1 = 0

			if var_150_1 < arg_147_1.time_ and arg_147_1.time_ <= var_150_1 + arg_150_0 then
				arg_147_1.var_.moveOldPos111101ui_story = var_150_0.localPosition
			end

			local var_150_2 = 0.001

			if var_150_1 <= arg_147_1.time_ and arg_147_1.time_ < var_150_1 + var_150_2 then
				local var_150_3 = (arg_147_1.time_ - var_150_1) / var_150_2
				local var_150_4 = Vector3.New(0, -0.83, -6)

				var_150_0.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos111101ui_story, var_150_4, var_150_3)

				local var_150_5 = manager.ui.mainCamera.transform.position - var_150_0.position

				var_150_0.forward = Vector3.New(var_150_5.x, var_150_5.y, var_150_5.z)

				local var_150_6 = var_150_0.localEulerAngles

				var_150_6.z = 0
				var_150_6.x = 0
				var_150_0.localEulerAngles = var_150_6
			end

			if arg_147_1.time_ >= var_150_1 + var_150_2 and arg_147_1.time_ < var_150_1 + var_150_2 + arg_150_0 then
				var_150_0.localPosition = Vector3.New(0, -0.83, -6)

				local var_150_7 = manager.ui.mainCamera.transform.position - var_150_0.position

				var_150_0.forward = Vector3.New(var_150_7.x, var_150_7.y, var_150_7.z)

				local var_150_8 = var_150_0.localEulerAngles

				var_150_8.z = 0
				var_150_8.x = 0
				var_150_0.localEulerAngles = var_150_8
			end

			local var_150_9 = arg_147_1.actors_["111101ui_story"]
			local var_150_10 = 0

			if var_150_10 < arg_147_1.time_ and arg_147_1.time_ <= var_150_10 + arg_150_0 and not isNil(var_150_9) and arg_147_1.var_.characterEffect111101ui_story == nil then
				arg_147_1.var_.characterEffect111101ui_story = var_150_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_11 = 0.200000002980232

			if var_150_10 <= arg_147_1.time_ and arg_147_1.time_ < var_150_10 + var_150_11 and not isNil(var_150_9) then
				local var_150_12 = (arg_147_1.time_ - var_150_10) / var_150_11

				if arg_147_1.var_.characterEffect111101ui_story and not isNil(var_150_9) then
					arg_147_1.var_.characterEffect111101ui_story.fillFlat = false
				end
			end

			if arg_147_1.time_ >= var_150_10 + var_150_11 and arg_147_1.time_ < var_150_10 + var_150_11 + arg_150_0 and not isNil(var_150_9) and arg_147_1.var_.characterEffect111101ui_story then
				arg_147_1.var_.characterEffect111101ui_story.fillFlat = false
			end

			local var_150_13 = 0

			if var_150_13 < arg_147_1.time_ and arg_147_1.time_ <= var_150_13 + arg_150_0 then
				arg_147_1:PlayTimeline("111101ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action2_2")
			end

			local var_150_14 = 0

			if var_150_14 < arg_147_1.time_ and arg_147_1.time_ <= var_150_14 + arg_150_0 then
				arg_147_1:PlayTimeline("111101ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1302cva")
			end

			local var_150_15 = 0
			local var_150_16 = 0.325

			if var_150_15 < arg_147_1.time_ and arg_147_1.time_ <= var_150_15 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				local var_150_17 = arg_147_1:FormatText(StoryNameCfg[67].name)

				arg_147_1.leftNameTxt_.text = var_150_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_18 = arg_147_1:GetWordFromCfg(1101104038)
				local var_150_19 = arg_147_1:FormatText(var_150_18.content)

				arg_147_1.text_.text = var_150_19

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_20 = 13
				local var_150_21 = utf8.len(var_150_19)
				local var_150_22 = var_150_20 <= 0 and var_150_16 or var_150_16 * (var_150_21 / var_150_20)

				if var_150_22 > 0 and var_150_16 < var_150_22 then
					arg_147_1.talkMaxDuration = var_150_22

					if var_150_22 + var_150_15 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_22 + var_150_15
					end
				end

				arg_147_1.text_.text = var_150_19
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101104", "1101104038", "story_v_side_new_1101104.awb") ~= 0 then
					local var_150_23 = manager.audio:GetVoiceLength("story_v_side_new_1101104", "1101104038", "story_v_side_new_1101104.awb") / 1000

					if var_150_23 + var_150_15 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_23 + var_150_15
					end

					if var_150_18.prefab_name ~= "" and arg_147_1.actors_[var_150_18.prefab_name] ~= nil then
						local var_150_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_18.prefab_name].transform, "story_v_side_new_1101104", "1101104038", "story_v_side_new_1101104.awb")

						arg_147_1:RecordAudio("1101104038", var_150_24)
						arg_147_1:RecordAudio("1101104038", var_150_24)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_side_new_1101104", "1101104038", "story_v_side_new_1101104.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_side_new_1101104", "1101104038", "story_v_side_new_1101104.awb")
				end

				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_25 = math.max(var_150_16, arg_147_1.talkMaxDuration)

			if var_150_15 <= arg_147_1.time_ and arg_147_1.time_ < var_150_15 + var_150_25 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_15) / var_150_25

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_15 + var_150_25 and arg_147_1.time_ < var_150_15 + var_150_25 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "111101ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_147_1:InitPlayNodeList()
	end,
	Play1101104039 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 1101104039
		arg_151_1.duration_ = 5

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play1101104040(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = arg_151_1.actors_["111101ui_story"]
			local var_154_1 = 0

			if var_154_1 < arg_151_1.time_ and arg_151_1.time_ <= var_154_1 + arg_154_0 and not isNil(var_154_0) and arg_151_1.var_.characterEffect111101ui_story == nil then
				arg_151_1.var_.characterEffect111101ui_story = var_154_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_2 = 0.200000002980232

			if var_154_1 <= arg_151_1.time_ and arg_151_1.time_ < var_154_1 + var_154_2 and not isNil(var_154_0) then
				local var_154_3 = (arg_151_1.time_ - var_154_1) / var_154_2

				if arg_151_1.var_.characterEffect111101ui_story and not isNil(var_154_0) then
					local var_154_4 = Mathf.Lerp(0, 0.5, var_154_3)

					arg_151_1.var_.characterEffect111101ui_story.fillFlat = true
					arg_151_1.var_.characterEffect111101ui_story.fillRatio = var_154_4
				end
			end

			if arg_151_1.time_ >= var_154_1 + var_154_2 and arg_151_1.time_ < var_154_1 + var_154_2 + arg_154_0 and not isNil(var_154_0) and arg_151_1.var_.characterEffect111101ui_story then
				local var_154_5 = 0.5

				arg_151_1.var_.characterEffect111101ui_story.fillFlat = true
				arg_151_1.var_.characterEffect111101ui_story.fillRatio = var_154_5
			end

			local var_154_6 = 0
			local var_154_7 = 0.525

			if var_154_6 < arg_151_1.time_ and arg_151_1.time_ <= var_154_6 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				local var_154_8 = arg_151_1:FormatText(StoryNameCfg[7].name)

				arg_151_1.leftNameTxt_.text = var_154_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, true)
				arg_151_1.iconController_:SetSelectedState("hero")

				arg_151_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_151_1.callingController_:SetSelectedState("normal")

				arg_151_1.keyicon_.color = Color.New(1, 1, 1)
				arg_151_1.icon_.color = Color.New(1, 1, 1)

				local var_154_9 = arg_151_1:GetWordFromCfg(1101104039)
				local var_154_10 = arg_151_1:FormatText(var_154_9.content)

				arg_151_1.text_.text = var_154_10

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_11 = 38
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
				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_14 = math.max(var_154_7, arg_151_1.talkMaxDuration)

			if var_154_6 <= arg_151_1.time_ and arg_151_1.time_ < var_154_6 + var_154_14 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_6) / var_154_14

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_6 + var_154_14 and arg_151_1.time_ < var_154_6 + var_154_14 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play1101104040 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 1101104040
		arg_155_1.duration_ = 6.1

		local var_155_0 = {
			zh = 4.333,
			ja = 6.1
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
				arg_155_0:Play1101104041(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = arg_155_1.actors_["111101ui_story"].transform
			local var_158_1 = 0

			if var_158_1 < arg_155_1.time_ and arg_155_1.time_ <= var_158_1 + arg_158_0 then
				arg_155_1.var_.moveOldPos111101ui_story = var_158_0.localPosition
			end

			local var_158_2 = 0.001

			if var_158_1 <= arg_155_1.time_ and arg_155_1.time_ < var_158_1 + var_158_2 then
				local var_158_3 = (arg_155_1.time_ - var_158_1) / var_158_2
				local var_158_4 = Vector3.New(0, -0.83, -6)

				var_158_0.localPosition = Vector3.Lerp(arg_155_1.var_.moveOldPos111101ui_story, var_158_4, var_158_3)

				local var_158_5 = manager.ui.mainCamera.transform.position - var_158_0.position

				var_158_0.forward = Vector3.New(var_158_5.x, var_158_5.y, var_158_5.z)

				local var_158_6 = var_158_0.localEulerAngles

				var_158_6.z = 0
				var_158_6.x = 0
				var_158_0.localEulerAngles = var_158_6
			end

			if arg_155_1.time_ >= var_158_1 + var_158_2 and arg_155_1.time_ < var_158_1 + var_158_2 + arg_158_0 then
				var_158_0.localPosition = Vector3.New(0, -0.83, -6)

				local var_158_7 = manager.ui.mainCamera.transform.position - var_158_0.position

				var_158_0.forward = Vector3.New(var_158_7.x, var_158_7.y, var_158_7.z)

				local var_158_8 = var_158_0.localEulerAngles

				var_158_8.z = 0
				var_158_8.x = 0
				var_158_0.localEulerAngles = var_158_8
			end

			local var_158_9 = arg_155_1.actors_["111101ui_story"]
			local var_158_10 = 0

			if var_158_10 < arg_155_1.time_ and arg_155_1.time_ <= var_158_10 + arg_158_0 and not isNil(var_158_9) and arg_155_1.var_.characterEffect111101ui_story == nil then
				arg_155_1.var_.characterEffect111101ui_story = var_158_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_158_11 = 0.200000002980232

			if var_158_10 <= arg_155_1.time_ and arg_155_1.time_ < var_158_10 + var_158_11 and not isNil(var_158_9) then
				local var_158_12 = (arg_155_1.time_ - var_158_10) / var_158_11

				if arg_155_1.var_.characterEffect111101ui_story and not isNil(var_158_9) then
					arg_155_1.var_.characterEffect111101ui_story.fillFlat = false
				end
			end

			if arg_155_1.time_ >= var_158_10 + var_158_11 and arg_155_1.time_ < var_158_10 + var_158_11 + arg_158_0 and not isNil(var_158_9) and arg_155_1.var_.characterEffect111101ui_story then
				arg_155_1.var_.characterEffect111101ui_story.fillFlat = false
			end

			local var_158_13 = 0

			if var_158_13 < arg_155_1.time_ and arg_155_1.time_ <= var_158_13 + arg_158_0 then
				arg_155_1:PlayTimeline("111101ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action8_1")
			end

			local var_158_14 = 0

			if var_158_14 < arg_155_1.time_ and arg_155_1.time_ <= var_158_14 + arg_158_0 then
				arg_155_1:PlayTimeline("111101ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_158_15 = 0
			local var_158_16 = 0.525

			if var_158_15 < arg_155_1.time_ and arg_155_1.time_ <= var_158_15 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				local var_158_17 = arg_155_1:FormatText(StoryNameCfg[67].name)

				arg_155_1.leftNameTxt_.text = var_158_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_18 = arg_155_1:GetWordFromCfg(1101104040)
				local var_158_19 = arg_155_1:FormatText(var_158_18.content)

				arg_155_1.text_.text = var_158_19

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_20 = 21
				local var_158_21 = utf8.len(var_158_19)
				local var_158_22 = var_158_20 <= 0 and var_158_16 or var_158_16 * (var_158_21 / var_158_20)

				if var_158_22 > 0 and var_158_16 < var_158_22 then
					arg_155_1.talkMaxDuration = var_158_22

					if var_158_22 + var_158_15 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_22 + var_158_15
					end
				end

				arg_155_1.text_.text = var_158_19
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101104", "1101104040", "story_v_side_new_1101104.awb") ~= 0 then
					local var_158_23 = manager.audio:GetVoiceLength("story_v_side_new_1101104", "1101104040", "story_v_side_new_1101104.awb") / 1000

					if var_158_23 + var_158_15 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_23 + var_158_15
					end

					if var_158_18.prefab_name ~= "" and arg_155_1.actors_[var_158_18.prefab_name] ~= nil then
						local var_158_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_18.prefab_name].transform, "story_v_side_new_1101104", "1101104040", "story_v_side_new_1101104.awb")

						arg_155_1:RecordAudio("1101104040", var_158_24)
						arg_155_1:RecordAudio("1101104040", var_158_24)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_side_new_1101104", "1101104040", "story_v_side_new_1101104.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_side_new_1101104", "1101104040", "story_v_side_new_1101104.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_25 = math.max(var_158_16, arg_155_1.talkMaxDuration)

			if var_158_15 <= arg_155_1.time_ and arg_155_1.time_ < var_158_15 + var_158_25 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_15) / var_158_25

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_15 + var_158_25 and arg_155_1.time_ < var_158_15 + var_158_25 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "111101ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_155_1:InitPlayNodeList()
	end,
	Play1101104041 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 1101104041
		arg_159_1.duration_ = 1

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"

			SetActive(arg_159_1.choicesGo_, true)

			for iter_160_0, iter_160_1 in ipairs(arg_159_1.choices_) do
				local var_160_0 = iter_160_0 <= 1

				SetActive(iter_160_1.go, var_160_0)
			end

			arg_159_1.choices_[1].txt.text = arg_159_1:FormatText(StoryChoiceCfg[614].name)
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play1101104042(arg_159_1)
			end

			arg_159_1:RecordChoiceLog(1101104041, 614)
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = arg_159_1.actors_["111101ui_story"]
			local var_162_1 = 0

			if var_162_1 < arg_159_1.time_ and arg_159_1.time_ <= var_162_1 + arg_162_0 and not isNil(var_162_0) and arg_159_1.var_.characterEffect111101ui_story == nil then
				arg_159_1.var_.characterEffect111101ui_story = var_162_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_162_2 = 0.200000002980232

			if var_162_1 <= arg_159_1.time_ and arg_159_1.time_ < var_162_1 + var_162_2 and not isNil(var_162_0) then
				local var_162_3 = (arg_159_1.time_ - var_162_1) / var_162_2

				if arg_159_1.var_.characterEffect111101ui_story and not isNil(var_162_0) then
					local var_162_4 = Mathf.Lerp(0, 0.5, var_162_3)

					arg_159_1.var_.characterEffect111101ui_story.fillFlat = true
					arg_159_1.var_.characterEffect111101ui_story.fillRatio = var_162_4
				end
			end

			if arg_159_1.time_ >= var_162_1 + var_162_2 and arg_159_1.time_ < var_162_1 + var_162_2 + arg_162_0 and not isNil(var_162_0) and arg_159_1.var_.characterEffect111101ui_story then
				local var_162_5 = 0.5

				arg_159_1.var_.characterEffect111101ui_story.fillFlat = true
				arg_159_1.var_.characterEffect111101ui_story.fillRatio = var_162_5
			end

			local var_162_6 = 0

			if var_162_6 < arg_159_1.time_ and arg_159_1.time_ <= var_162_6 + arg_162_0 then
				arg_159_1.allBtn_.enabled = false
			end

			local var_162_7 = 0.5

			if arg_159_1.time_ >= var_162_6 + var_162_7 and arg_159_1.time_ < var_162_6 + var_162_7 + arg_162_0 then
				arg_159_1.allBtn_.enabled = true
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play1101104042 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 1101104042
		arg_163_1.duration_ = 5

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play1101104043(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = 0
			local var_166_1 = 0.35

			if var_166_0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_0 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				local var_166_2 = arg_163_1:FormatText(StoryNameCfg[7].name)

				arg_163_1.leftNameTxt_.text = var_166_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, true)
				arg_163_1.iconController_:SetSelectedState("hero")

				arg_163_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_163_1.callingController_:SetSelectedState("normal")

				arg_163_1.keyicon_.color = Color.New(1, 1, 1)
				arg_163_1.icon_.color = Color.New(1, 1, 1)

				local var_166_3 = arg_163_1:GetWordFromCfg(1101104042)
				local var_166_4 = arg_163_1:FormatText(var_166_3.content)

				arg_163_1.text_.text = var_166_4

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_5 = 14
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
				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_8 = math.max(var_166_1, arg_163_1.talkMaxDuration)

			if var_166_0 <= arg_163_1.time_ and arg_163_1.time_ < var_166_0 + var_166_8 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_0) / var_166_8

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_0 + var_166_8 and arg_163_1.time_ < var_166_0 + var_166_8 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {}

		arg_163_1:InitPlayNodeList()
	end,
	Play1101104043 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 1101104043
		arg_167_1.duration_ = 5

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play1101104044(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = 0

			if var_170_0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_0 + arg_170_0 then
				arg_167_1:PlayTimeline("111101ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action8_2")
			end

			local var_170_1 = 0
			local var_170_2 = 0.425

			if var_170_1 < arg_167_1.time_ and arg_167_1.time_ <= var_170_1 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, false)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_3 = arg_167_1:GetWordFromCfg(1101104043)
				local var_170_4 = arg_167_1:FormatText(var_170_3.content)

				arg_167_1.text_.text = var_170_4

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_5 = 17
				local var_170_6 = utf8.len(var_170_4)
				local var_170_7 = var_170_5 <= 0 and var_170_2 or var_170_2 * (var_170_6 / var_170_5)

				if var_170_7 > 0 and var_170_2 < var_170_7 then
					arg_167_1.talkMaxDuration = var_170_7

					if var_170_7 + var_170_1 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_7 + var_170_1
					end
				end

				arg_167_1.text_.text = var_170_4
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)
				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_8 = math.max(var_170_2, arg_167_1.talkMaxDuration)

			if var_170_1 <= arg_167_1.time_ and arg_167_1.time_ < var_170_1 + var_170_8 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_1) / var_170_8

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_1 + var_170_8 and arg_167_1.time_ < var_170_1 + var_170_8 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {}

		arg_167_1:InitPlayNodeList()
	end,
	Play1101104044 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 1101104044
		arg_171_1.duration_ = 5

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play1101104045(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = 0
			local var_174_1 = 0.375

			if var_174_0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_0 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				local var_174_2 = arg_171_1:FormatText(StoryNameCfg[7].name)

				arg_171_1.leftNameTxt_.text = var_174_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, true)
				arg_171_1.iconController_:SetSelectedState("hero")

				arg_171_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_171_1.callingController_:SetSelectedState("normal")

				arg_171_1.keyicon_.color = Color.New(1, 1, 1)
				arg_171_1.icon_.color = Color.New(1, 1, 1)

				local var_174_3 = arg_171_1:GetWordFromCfg(1101104044)
				local var_174_4 = arg_171_1:FormatText(var_174_3.content)

				arg_171_1.text_.text = var_174_4

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_5 = 15
				local var_174_6 = utf8.len(var_174_4)
				local var_174_7 = var_174_5 <= 0 and var_174_1 or var_174_1 * (var_174_6 / var_174_5)

				if var_174_7 > 0 and var_174_1 < var_174_7 then
					arg_171_1.talkMaxDuration = var_174_7

					if var_174_7 + var_174_0 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_7 + var_174_0
					end
				end

				arg_171_1.text_.text = var_174_4
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)
				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_8 = math.max(var_174_1, arg_171_1.talkMaxDuration)

			if var_174_0 <= arg_171_1.time_ and arg_171_1.time_ < var_174_0 + var_174_8 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_0) / var_174_8

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_0 + var_174_8 and arg_171_1.time_ < var_174_0 + var_174_8 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {}

		arg_171_1:InitPlayNodeList()
	end,
	Play1101104045 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 1101104045
		arg_175_1.duration_ = 2.63

		local var_175_0 = {
			zh = 2.633,
			ja = 2
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
				arg_175_0:Play1101104046(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = arg_175_1.actors_["111101ui_story"].transform
			local var_178_1 = 0

			if var_178_1 < arg_175_1.time_ and arg_175_1.time_ <= var_178_1 + arg_178_0 then
				arg_175_1.var_.moveOldPos111101ui_story = var_178_0.localPosition
			end

			local var_178_2 = 0.001

			if var_178_1 <= arg_175_1.time_ and arg_175_1.time_ < var_178_1 + var_178_2 then
				local var_178_3 = (arg_175_1.time_ - var_178_1) / var_178_2
				local var_178_4 = Vector3.New(0, -0.83, -6)

				var_178_0.localPosition = Vector3.Lerp(arg_175_1.var_.moveOldPos111101ui_story, var_178_4, var_178_3)

				local var_178_5 = manager.ui.mainCamera.transform.position - var_178_0.position

				var_178_0.forward = Vector3.New(var_178_5.x, var_178_5.y, var_178_5.z)

				local var_178_6 = var_178_0.localEulerAngles

				var_178_6.z = 0
				var_178_6.x = 0
				var_178_0.localEulerAngles = var_178_6
			end

			if arg_175_1.time_ >= var_178_1 + var_178_2 and arg_175_1.time_ < var_178_1 + var_178_2 + arg_178_0 then
				var_178_0.localPosition = Vector3.New(0, -0.83, -6)

				local var_178_7 = manager.ui.mainCamera.transform.position - var_178_0.position

				var_178_0.forward = Vector3.New(var_178_7.x, var_178_7.y, var_178_7.z)

				local var_178_8 = var_178_0.localEulerAngles

				var_178_8.z = 0
				var_178_8.x = 0
				var_178_0.localEulerAngles = var_178_8
			end

			local var_178_9 = arg_175_1.actors_["111101ui_story"]
			local var_178_10 = 0

			if var_178_10 < arg_175_1.time_ and arg_175_1.time_ <= var_178_10 + arg_178_0 and not isNil(var_178_9) and arg_175_1.var_.characterEffect111101ui_story == nil then
				arg_175_1.var_.characterEffect111101ui_story = var_178_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_178_11 = 0.200000002980232

			if var_178_10 <= arg_175_1.time_ and arg_175_1.time_ < var_178_10 + var_178_11 and not isNil(var_178_9) then
				local var_178_12 = (arg_175_1.time_ - var_178_10) / var_178_11

				if arg_175_1.var_.characterEffect111101ui_story and not isNil(var_178_9) then
					arg_175_1.var_.characterEffect111101ui_story.fillFlat = false
				end
			end

			if arg_175_1.time_ >= var_178_10 + var_178_11 and arg_175_1.time_ < var_178_10 + var_178_11 + arg_178_0 and not isNil(var_178_9) and arg_175_1.var_.characterEffect111101ui_story then
				arg_175_1.var_.characterEffect111101ui_story.fillFlat = false
			end

			local var_178_13 = 0

			if var_178_13 < arg_175_1.time_ and arg_175_1.time_ <= var_178_13 + arg_178_0 then
				arg_175_1:PlayTimeline("111101ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action5_1")
			end

			local var_178_14 = 0

			if var_178_14 < arg_175_1.time_ and arg_175_1.time_ <= var_178_14 + arg_178_0 then
				arg_175_1:PlayTimeline("111101ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_178_15 = 0
			local var_178_16 = 0.2

			if var_178_15 < arg_175_1.time_ and arg_175_1.time_ <= var_178_15 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				local var_178_17 = arg_175_1:FormatText(StoryNameCfg[67].name)

				arg_175_1.leftNameTxt_.text = var_178_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_18 = arg_175_1:GetWordFromCfg(1101104045)
				local var_178_19 = arg_175_1:FormatText(var_178_18.content)

				arg_175_1.text_.text = var_178_19

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_20 = 8
				local var_178_21 = utf8.len(var_178_19)
				local var_178_22 = var_178_20 <= 0 and var_178_16 or var_178_16 * (var_178_21 / var_178_20)

				if var_178_22 > 0 and var_178_16 < var_178_22 then
					arg_175_1.talkMaxDuration = var_178_22

					if var_178_22 + var_178_15 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_22 + var_178_15
					end
				end

				arg_175_1.text_.text = var_178_19
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101104", "1101104045", "story_v_side_new_1101104.awb") ~= 0 then
					local var_178_23 = manager.audio:GetVoiceLength("story_v_side_new_1101104", "1101104045", "story_v_side_new_1101104.awb") / 1000

					if var_178_23 + var_178_15 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_23 + var_178_15
					end

					if var_178_18.prefab_name ~= "" and arg_175_1.actors_[var_178_18.prefab_name] ~= nil then
						local var_178_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_18.prefab_name].transform, "story_v_side_new_1101104", "1101104045", "story_v_side_new_1101104.awb")

						arg_175_1:RecordAudio("1101104045", var_178_24)
						arg_175_1:RecordAudio("1101104045", var_178_24)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_side_new_1101104", "1101104045", "story_v_side_new_1101104.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_side_new_1101104", "1101104045", "story_v_side_new_1101104.awb")
				end

				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_25 = math.max(var_178_16, arg_175_1.talkMaxDuration)

			if var_178_15 <= arg_175_1.time_ and arg_175_1.time_ < var_178_15 + var_178_25 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_15) / var_178_25

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_15 + var_178_25 and arg_175_1.time_ < var_178_15 + var_178_25 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "111101ui_story",
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
	Play1101104046 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 1101104046
		arg_179_1.duration_ = 5

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play1101104047(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = arg_179_1.actors_["111101ui_story"]
			local var_182_1 = 0

			if var_182_1 < arg_179_1.time_ and arg_179_1.time_ <= var_182_1 + arg_182_0 and not isNil(var_182_0) and arg_179_1.var_.characterEffect111101ui_story == nil then
				arg_179_1.var_.characterEffect111101ui_story = var_182_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_182_2 = 0.200000002980232

			if var_182_1 <= arg_179_1.time_ and arg_179_1.time_ < var_182_1 + var_182_2 and not isNil(var_182_0) then
				local var_182_3 = (arg_179_1.time_ - var_182_1) / var_182_2

				if arg_179_1.var_.characterEffect111101ui_story and not isNil(var_182_0) then
					local var_182_4 = Mathf.Lerp(0, 0.5, var_182_3)

					arg_179_1.var_.characterEffect111101ui_story.fillFlat = true
					arg_179_1.var_.characterEffect111101ui_story.fillRatio = var_182_4
				end
			end

			if arg_179_1.time_ >= var_182_1 + var_182_2 and arg_179_1.time_ < var_182_1 + var_182_2 + arg_182_0 and not isNil(var_182_0) and arg_179_1.var_.characterEffect111101ui_story then
				local var_182_5 = 0.5

				arg_179_1.var_.characterEffect111101ui_story.fillFlat = true
				arg_179_1.var_.characterEffect111101ui_story.fillRatio = var_182_5
			end

			local var_182_6 = 0
			local var_182_7 = 0.275

			if var_182_6 < arg_179_1.time_ and arg_179_1.time_ <= var_182_6 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				local var_182_8 = arg_179_1:FormatText(StoryNameCfg[7].name)

				arg_179_1.leftNameTxt_.text = var_182_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, true)
				arg_179_1.iconController_:SetSelectedState("hero")

				arg_179_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_179_1.callingController_:SetSelectedState("normal")

				arg_179_1.keyicon_.color = Color.New(1, 1, 1)
				arg_179_1.icon_.color = Color.New(1, 1, 1)

				local var_182_9 = arg_179_1:GetWordFromCfg(1101104046)
				local var_182_10 = arg_179_1:FormatText(var_182_9.content)

				arg_179_1.text_.text = var_182_10

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_11 = 11
				local var_182_12 = utf8.len(var_182_10)
				local var_182_13 = var_182_11 <= 0 and var_182_7 or var_182_7 * (var_182_12 / var_182_11)

				if var_182_13 > 0 and var_182_7 < var_182_13 then
					arg_179_1.talkMaxDuration = var_182_13

					if var_182_13 + var_182_6 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_13 + var_182_6
					end
				end

				arg_179_1.text_.text = var_182_10
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)
				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_14 = math.max(var_182_7, arg_179_1.talkMaxDuration)

			if var_182_6 <= arg_179_1.time_ and arg_179_1.time_ < var_182_6 + var_182_14 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_6) / var_182_14

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_6 + var_182_14 and arg_179_1.time_ < var_182_6 + var_182_14 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play1101104047 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 1101104047
		arg_183_1.duration_ = 3.93

		local var_183_0 = {
			zh = 3.933,
			ja = 1.999999999999
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
				arg_183_0:Play1101104048(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = arg_183_1.actors_["111101ui_story"].transform
			local var_186_1 = 0

			if var_186_1 < arg_183_1.time_ and arg_183_1.time_ <= var_186_1 + arg_186_0 then
				arg_183_1.var_.moveOldPos111101ui_story = var_186_0.localPosition
			end

			local var_186_2 = 0.001

			if var_186_1 <= arg_183_1.time_ and arg_183_1.time_ < var_186_1 + var_186_2 then
				local var_186_3 = (arg_183_1.time_ - var_186_1) / var_186_2
				local var_186_4 = Vector3.New(0, -0.83, -6)

				var_186_0.localPosition = Vector3.Lerp(arg_183_1.var_.moveOldPos111101ui_story, var_186_4, var_186_3)

				local var_186_5 = manager.ui.mainCamera.transform.position - var_186_0.position

				var_186_0.forward = Vector3.New(var_186_5.x, var_186_5.y, var_186_5.z)

				local var_186_6 = var_186_0.localEulerAngles

				var_186_6.z = 0
				var_186_6.x = 0
				var_186_0.localEulerAngles = var_186_6
			end

			if arg_183_1.time_ >= var_186_1 + var_186_2 and arg_183_1.time_ < var_186_1 + var_186_2 + arg_186_0 then
				var_186_0.localPosition = Vector3.New(0, -0.83, -6)

				local var_186_7 = manager.ui.mainCamera.transform.position - var_186_0.position

				var_186_0.forward = Vector3.New(var_186_7.x, var_186_7.y, var_186_7.z)

				local var_186_8 = var_186_0.localEulerAngles

				var_186_8.z = 0
				var_186_8.x = 0
				var_186_0.localEulerAngles = var_186_8
			end

			local var_186_9 = arg_183_1.actors_["111101ui_story"]
			local var_186_10 = 0

			if var_186_10 < arg_183_1.time_ and arg_183_1.time_ <= var_186_10 + arg_186_0 and not isNil(var_186_9) and arg_183_1.var_.characterEffect111101ui_story == nil then
				arg_183_1.var_.characterEffect111101ui_story = var_186_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_186_11 = 0.200000002980232

			if var_186_10 <= arg_183_1.time_ and arg_183_1.time_ < var_186_10 + var_186_11 and not isNil(var_186_9) then
				local var_186_12 = (arg_183_1.time_ - var_186_10) / var_186_11

				if arg_183_1.var_.characterEffect111101ui_story and not isNil(var_186_9) then
					arg_183_1.var_.characterEffect111101ui_story.fillFlat = false
				end
			end

			if arg_183_1.time_ >= var_186_10 + var_186_11 and arg_183_1.time_ < var_186_10 + var_186_11 + arg_186_0 and not isNil(var_186_9) and arg_183_1.var_.characterEffect111101ui_story then
				arg_183_1.var_.characterEffect111101ui_story.fillFlat = false
			end

			local var_186_13 = 0

			if var_186_13 < arg_183_1.time_ and arg_183_1.time_ <= var_186_13 + arg_186_0 then
				arg_183_1:PlayTimeline("111101ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_186_14 = 0
			local var_186_15 = 0.2

			if var_186_14 < arg_183_1.time_ and arg_183_1.time_ <= var_186_14 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				local var_186_16 = arg_183_1:FormatText(StoryNameCfg[67].name)

				arg_183_1.leftNameTxt_.text = var_186_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_17 = arg_183_1:GetWordFromCfg(1101104047)
				local var_186_18 = arg_183_1:FormatText(var_186_17.content)

				arg_183_1.text_.text = var_186_18

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_19 = 8
				local var_186_20 = utf8.len(var_186_18)
				local var_186_21 = var_186_19 <= 0 and var_186_15 or var_186_15 * (var_186_20 / var_186_19)

				if var_186_21 > 0 and var_186_15 < var_186_21 then
					arg_183_1.talkMaxDuration = var_186_21

					if var_186_21 + var_186_14 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_21 + var_186_14
					end
				end

				arg_183_1.text_.text = var_186_18
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101104", "1101104047", "story_v_side_new_1101104.awb") ~= 0 then
					local var_186_22 = manager.audio:GetVoiceLength("story_v_side_new_1101104", "1101104047", "story_v_side_new_1101104.awb") / 1000

					if var_186_22 + var_186_14 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_22 + var_186_14
					end

					if var_186_17.prefab_name ~= "" and arg_183_1.actors_[var_186_17.prefab_name] ~= nil then
						local var_186_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_17.prefab_name].transform, "story_v_side_new_1101104", "1101104047", "story_v_side_new_1101104.awb")

						arg_183_1:RecordAudio("1101104047", var_186_23)
						arg_183_1:RecordAudio("1101104047", var_186_23)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_side_new_1101104", "1101104047", "story_v_side_new_1101104.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_side_new_1101104", "1101104047", "story_v_side_new_1101104.awb")
				end

				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_24 = math.max(var_186_15, arg_183_1.talkMaxDuration)

			if var_186_14 <= arg_183_1.time_ and arg_183_1.time_ < var_186_14 + var_186_24 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_14) / var_186_24

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_14 + var_186_24 and arg_183_1.time_ < var_186_14 + var_186_24 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "111101ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_183_1:InitPlayNodeList()
	end,
	Play1101104048 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 1101104048
		arg_187_1.duration_ = 5

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play1101104049(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = arg_187_1.actors_["111101ui_story"]
			local var_190_1 = 0

			if var_190_1 < arg_187_1.time_ and arg_187_1.time_ <= var_190_1 + arg_190_0 and not isNil(var_190_0) and arg_187_1.var_.characterEffect111101ui_story == nil then
				arg_187_1.var_.characterEffect111101ui_story = var_190_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_2 = 0.200000002980232

			if var_190_1 <= arg_187_1.time_ and arg_187_1.time_ < var_190_1 + var_190_2 and not isNil(var_190_0) then
				local var_190_3 = (arg_187_1.time_ - var_190_1) / var_190_2

				if arg_187_1.var_.characterEffect111101ui_story and not isNil(var_190_0) then
					local var_190_4 = Mathf.Lerp(0, 0.5, var_190_3)

					arg_187_1.var_.characterEffect111101ui_story.fillFlat = true
					arg_187_1.var_.characterEffect111101ui_story.fillRatio = var_190_4
				end
			end

			if arg_187_1.time_ >= var_190_1 + var_190_2 and arg_187_1.time_ < var_190_1 + var_190_2 + arg_190_0 and not isNil(var_190_0) and arg_187_1.var_.characterEffect111101ui_story then
				local var_190_5 = 0.5

				arg_187_1.var_.characterEffect111101ui_story.fillFlat = true
				arg_187_1.var_.characterEffect111101ui_story.fillRatio = var_190_5
			end

			local var_190_6 = 0
			local var_190_7 = 0.125

			if var_190_6 < arg_187_1.time_ and arg_187_1.time_ <= var_190_6 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				local var_190_8 = arg_187_1:FormatText(StoryNameCfg[7].name)

				arg_187_1.leftNameTxt_.text = var_190_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, true)
				arg_187_1.iconController_:SetSelectedState("hero")

				arg_187_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_187_1.callingController_:SetSelectedState("normal")

				arg_187_1.keyicon_.color = Color.New(1, 1, 1)
				arg_187_1.icon_.color = Color.New(1, 1, 1)

				local var_190_9 = arg_187_1:GetWordFromCfg(1101104048)
				local var_190_10 = arg_187_1:FormatText(var_190_9.content)

				arg_187_1.text_.text = var_190_10

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_11 = 5
				local var_190_12 = utf8.len(var_190_10)
				local var_190_13 = var_190_11 <= 0 and var_190_7 or var_190_7 * (var_190_12 / var_190_11)

				if var_190_13 > 0 and var_190_7 < var_190_13 then
					arg_187_1.talkMaxDuration = var_190_13

					if var_190_13 + var_190_6 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_13 + var_190_6
					end
				end

				arg_187_1.text_.text = var_190_10
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)
				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_14 = math.max(var_190_7, arg_187_1.talkMaxDuration)

			if var_190_6 <= arg_187_1.time_ and arg_187_1.time_ < var_190_6 + var_190_14 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_6) / var_190_14

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_6 + var_190_14 and arg_187_1.time_ < var_190_6 + var_190_14 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play1101104049 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 1101104049
		arg_191_1.duration_ = 5.47

		local var_191_0 = {
			zh = 5.466,
			ja = 4.333
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
				arg_191_0:Play1101104050(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = arg_191_1.actors_["111101ui_story"].transform
			local var_194_1 = 0

			if var_194_1 < arg_191_1.time_ and arg_191_1.time_ <= var_194_1 + arg_194_0 then
				arg_191_1.var_.moveOldPos111101ui_story = var_194_0.localPosition
			end

			local var_194_2 = 0.001

			if var_194_1 <= arg_191_1.time_ and arg_191_1.time_ < var_194_1 + var_194_2 then
				local var_194_3 = (arg_191_1.time_ - var_194_1) / var_194_2
				local var_194_4 = Vector3.New(0, -0.83, -6)

				var_194_0.localPosition = Vector3.Lerp(arg_191_1.var_.moveOldPos111101ui_story, var_194_4, var_194_3)

				local var_194_5 = manager.ui.mainCamera.transform.position - var_194_0.position

				var_194_0.forward = Vector3.New(var_194_5.x, var_194_5.y, var_194_5.z)

				local var_194_6 = var_194_0.localEulerAngles

				var_194_6.z = 0
				var_194_6.x = 0
				var_194_0.localEulerAngles = var_194_6
			end

			if arg_191_1.time_ >= var_194_1 + var_194_2 and arg_191_1.time_ < var_194_1 + var_194_2 + arg_194_0 then
				var_194_0.localPosition = Vector3.New(0, -0.83, -6)

				local var_194_7 = manager.ui.mainCamera.transform.position - var_194_0.position

				var_194_0.forward = Vector3.New(var_194_7.x, var_194_7.y, var_194_7.z)

				local var_194_8 = var_194_0.localEulerAngles

				var_194_8.z = 0
				var_194_8.x = 0
				var_194_0.localEulerAngles = var_194_8
			end

			local var_194_9 = arg_191_1.actors_["111101ui_story"]
			local var_194_10 = 0

			if var_194_10 < arg_191_1.time_ and arg_191_1.time_ <= var_194_10 + arg_194_0 and not isNil(var_194_9) and arg_191_1.var_.characterEffect111101ui_story == nil then
				arg_191_1.var_.characterEffect111101ui_story = var_194_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_194_11 = 0.200000002980232

			if var_194_10 <= arg_191_1.time_ and arg_191_1.time_ < var_194_10 + var_194_11 and not isNil(var_194_9) then
				local var_194_12 = (arg_191_1.time_ - var_194_10) / var_194_11

				if arg_191_1.var_.characterEffect111101ui_story and not isNil(var_194_9) then
					arg_191_1.var_.characterEffect111101ui_story.fillFlat = false
				end
			end

			if arg_191_1.time_ >= var_194_10 + var_194_11 and arg_191_1.time_ < var_194_10 + var_194_11 + arg_194_0 and not isNil(var_194_9) and arg_191_1.var_.characterEffect111101ui_story then
				arg_191_1.var_.characterEffect111101ui_story.fillFlat = false
			end

			local var_194_13 = 0

			if var_194_13 < arg_191_1.time_ and arg_191_1.time_ <= var_194_13 + arg_194_0 then
				arg_191_1:PlayTimeline("111101ui_story", "StoryTimeline/CharAction/story1111/story1111actionlink/1111action459")
			end

			local var_194_14 = 0

			if var_194_14 < arg_191_1.time_ and arg_191_1.time_ <= var_194_14 + arg_194_0 then
				arg_191_1:PlayTimeline("111101ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_194_15 = 0
			local var_194_16 = 0.4

			if var_194_15 < arg_191_1.time_ and arg_191_1.time_ <= var_194_15 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				local var_194_17 = arg_191_1:FormatText(StoryNameCfg[67].name)

				arg_191_1.leftNameTxt_.text = var_194_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_18 = arg_191_1:GetWordFromCfg(1101104049)
				local var_194_19 = arg_191_1:FormatText(var_194_18.content)

				arg_191_1.text_.text = var_194_19

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_20 = 16
				local var_194_21 = utf8.len(var_194_19)
				local var_194_22 = var_194_20 <= 0 and var_194_16 or var_194_16 * (var_194_21 / var_194_20)

				if var_194_22 > 0 and var_194_16 < var_194_22 then
					arg_191_1.talkMaxDuration = var_194_22

					if var_194_22 + var_194_15 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_22 + var_194_15
					end
				end

				arg_191_1.text_.text = var_194_19
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101104", "1101104049", "story_v_side_new_1101104.awb") ~= 0 then
					local var_194_23 = manager.audio:GetVoiceLength("story_v_side_new_1101104", "1101104049", "story_v_side_new_1101104.awb") / 1000

					if var_194_23 + var_194_15 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_23 + var_194_15
					end

					if var_194_18.prefab_name ~= "" and arg_191_1.actors_[var_194_18.prefab_name] ~= nil then
						local var_194_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_18.prefab_name].transform, "story_v_side_new_1101104", "1101104049", "story_v_side_new_1101104.awb")

						arg_191_1:RecordAudio("1101104049", var_194_24)
						arg_191_1:RecordAudio("1101104049", var_194_24)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_side_new_1101104", "1101104049", "story_v_side_new_1101104.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_side_new_1101104", "1101104049", "story_v_side_new_1101104.awb")
				end

				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_25 = math.max(var_194_16, arg_191_1.talkMaxDuration)

			if var_194_15 <= arg_191_1.time_ and arg_191_1.time_ < var_194_15 + var_194_25 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_15) / var_194_25

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_15 + var_194_25 and arg_191_1.time_ < var_194_15 + var_194_25 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "111101ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_191_1:InitPlayNodeList()
	end,
	Play1101104050 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 1101104050
		arg_195_1.duration_ = 5

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play1101104051(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = arg_195_1.actors_["111101ui_story"]
			local var_198_1 = 0

			if var_198_1 < arg_195_1.time_ and arg_195_1.time_ <= var_198_1 + arg_198_0 and not isNil(var_198_0) and arg_195_1.var_.characterEffect111101ui_story == nil then
				arg_195_1.var_.characterEffect111101ui_story = var_198_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_198_2 = 0.200000002980232

			if var_198_1 <= arg_195_1.time_ and arg_195_1.time_ < var_198_1 + var_198_2 and not isNil(var_198_0) then
				local var_198_3 = (arg_195_1.time_ - var_198_1) / var_198_2

				if arg_195_1.var_.characterEffect111101ui_story and not isNil(var_198_0) then
					local var_198_4 = Mathf.Lerp(0, 0.5, var_198_3)

					arg_195_1.var_.characterEffect111101ui_story.fillFlat = true
					arg_195_1.var_.characterEffect111101ui_story.fillRatio = var_198_4
				end
			end

			if arg_195_1.time_ >= var_198_1 + var_198_2 and arg_195_1.time_ < var_198_1 + var_198_2 + arg_198_0 and not isNil(var_198_0) and arg_195_1.var_.characterEffect111101ui_story then
				local var_198_5 = 0.5

				arg_195_1.var_.characterEffect111101ui_story.fillFlat = true
				arg_195_1.var_.characterEffect111101ui_story.fillRatio = var_198_5
			end

			local var_198_6 = 0
			local var_198_7 = 1.15

			if var_198_6 < arg_195_1.time_ and arg_195_1.time_ <= var_198_6 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, false)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_8 = arg_195_1:GetWordFromCfg(1101104050)
				local var_198_9 = arg_195_1:FormatText(var_198_8.content)

				arg_195_1.text_.text = var_198_9

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_10 = 46
				local var_198_11 = utf8.len(var_198_9)
				local var_198_12 = var_198_10 <= 0 and var_198_7 or var_198_7 * (var_198_11 / var_198_10)

				if var_198_12 > 0 and var_198_7 < var_198_12 then
					arg_195_1.talkMaxDuration = var_198_12

					if var_198_12 + var_198_6 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_12 + var_198_6
					end
				end

				arg_195_1.text_.text = var_198_9
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)
				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_13 = math.max(var_198_7, arg_195_1.talkMaxDuration)

			if var_198_6 <= arg_195_1.time_ and arg_195_1.time_ < var_198_6 + var_198_13 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_6) / var_198_13

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_6 + var_198_13 and arg_195_1.time_ < var_198_6 + var_198_13 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {}

		arg_195_1:InitPlayNodeList()
	end,
	Play1101104051 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 1101104051
		arg_199_1.duration_ = 5

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play1101104052(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = 0
			local var_202_1 = 0.275

			if var_202_0 < arg_199_1.time_ and arg_199_1.time_ <= var_202_0 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				local var_202_2 = arg_199_1:FormatText(StoryNameCfg[7].name)

				arg_199_1.leftNameTxt_.text = var_202_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, true)
				arg_199_1.iconController_:SetSelectedState("hero")

				arg_199_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_199_1.callingController_:SetSelectedState("normal")

				arg_199_1.keyicon_.color = Color.New(1, 1, 1)
				arg_199_1.icon_.color = Color.New(1, 1, 1)

				local var_202_3 = arg_199_1:GetWordFromCfg(1101104051)
				local var_202_4 = arg_199_1:FormatText(var_202_3.content)

				arg_199_1.text_.text = var_202_4

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_5 = 11
				local var_202_6 = utf8.len(var_202_4)
				local var_202_7 = var_202_5 <= 0 and var_202_1 or var_202_1 * (var_202_6 / var_202_5)

				if var_202_7 > 0 and var_202_1 < var_202_7 then
					arg_199_1.talkMaxDuration = var_202_7

					if var_202_7 + var_202_0 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_7 + var_202_0
					end
				end

				arg_199_1.text_.text = var_202_4
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)
				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_8 = math.max(var_202_1, arg_199_1.talkMaxDuration)

			if var_202_0 <= arg_199_1.time_ and arg_199_1.time_ < var_202_0 + var_202_8 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_0) / var_202_8

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_0 + var_202_8 and arg_199_1.time_ < var_202_0 + var_202_8 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {}

		arg_199_1:InitPlayNodeList()
	end,
	Play1101104052 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 1101104052
		arg_203_1.duration_ = 5

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play1101104053(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			local var_206_0 = 0
			local var_206_1 = 1

			if var_206_0 < arg_203_1.time_ and arg_203_1.time_ <= var_206_0 + arg_206_0 then
				local var_206_2 = "play"
				local var_206_3 = "effect"

				arg_203_1:AudioAction(var_206_2, var_206_3, "se_story_side_1094", "se_story_1094_information", "")
			end

			local var_206_4 = 0
			local var_206_5 = 0.55

			if var_206_4 < arg_203_1.time_ and arg_203_1.time_ <= var_206_4 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, false)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_6 = arg_203_1:GetWordFromCfg(1101104052)
				local var_206_7 = arg_203_1:FormatText(var_206_6.content)

				arg_203_1.text_.text = var_206_7

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_8 = 22
				local var_206_9 = utf8.len(var_206_7)
				local var_206_10 = var_206_8 <= 0 and var_206_5 or var_206_5 * (var_206_9 / var_206_8)

				if var_206_10 > 0 and var_206_5 < var_206_10 then
					arg_203_1.talkMaxDuration = var_206_10

					if var_206_10 + var_206_4 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_10 + var_206_4
					end
				end

				arg_203_1.text_.text = var_206_7
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)
				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_11 = math.max(var_206_5, arg_203_1.talkMaxDuration)

			if var_206_4 <= arg_203_1.time_ and arg_203_1.time_ < var_206_4 + var_206_11 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_4) / var_206_11

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_4 + var_206_11 and arg_203_1.time_ < var_206_4 + var_206_11 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {}

		arg_203_1:InitPlayNodeList()
	end,
	Play1101104053 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 1101104053
		arg_207_1.duration_ = 2

		local var_207_0 = {
			zh = 1.999999999999,
			ja = 2
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
				arg_207_0:Play1101104054(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			local var_210_0 = arg_207_1.actors_["111101ui_story"].transform
			local var_210_1 = 0

			if var_210_1 < arg_207_1.time_ and arg_207_1.time_ <= var_210_1 + arg_210_0 then
				arg_207_1.var_.moveOldPos111101ui_story = var_210_0.localPosition
			end

			local var_210_2 = 0.001

			if var_210_1 <= arg_207_1.time_ and arg_207_1.time_ < var_210_1 + var_210_2 then
				local var_210_3 = (arg_207_1.time_ - var_210_1) / var_210_2
				local var_210_4 = Vector3.New(0, -0.83, -6)

				var_210_0.localPosition = Vector3.Lerp(arg_207_1.var_.moveOldPos111101ui_story, var_210_4, var_210_3)

				local var_210_5 = manager.ui.mainCamera.transform.position - var_210_0.position

				var_210_0.forward = Vector3.New(var_210_5.x, var_210_5.y, var_210_5.z)

				local var_210_6 = var_210_0.localEulerAngles

				var_210_6.z = 0
				var_210_6.x = 0
				var_210_0.localEulerAngles = var_210_6
			end

			if arg_207_1.time_ >= var_210_1 + var_210_2 and arg_207_1.time_ < var_210_1 + var_210_2 + arg_210_0 then
				var_210_0.localPosition = Vector3.New(0, -0.83, -6)

				local var_210_7 = manager.ui.mainCamera.transform.position - var_210_0.position

				var_210_0.forward = Vector3.New(var_210_7.x, var_210_7.y, var_210_7.z)

				local var_210_8 = var_210_0.localEulerAngles

				var_210_8.z = 0
				var_210_8.x = 0
				var_210_0.localEulerAngles = var_210_8
			end

			local var_210_9 = arg_207_1.actors_["111101ui_story"]
			local var_210_10 = 0

			if var_210_10 < arg_207_1.time_ and arg_207_1.time_ <= var_210_10 + arg_210_0 and not isNil(var_210_9) and arg_207_1.var_.characterEffect111101ui_story == nil then
				arg_207_1.var_.characterEffect111101ui_story = var_210_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_11 = 0.200000002980232

			if var_210_10 <= arg_207_1.time_ and arg_207_1.time_ < var_210_10 + var_210_11 and not isNil(var_210_9) then
				local var_210_12 = (arg_207_1.time_ - var_210_10) / var_210_11

				if arg_207_1.var_.characterEffect111101ui_story and not isNil(var_210_9) then
					arg_207_1.var_.characterEffect111101ui_story.fillFlat = false
				end
			end

			if arg_207_1.time_ >= var_210_10 + var_210_11 and arg_207_1.time_ < var_210_10 + var_210_11 + arg_210_0 and not isNil(var_210_9) and arg_207_1.var_.characterEffect111101ui_story then
				arg_207_1.var_.characterEffect111101ui_story.fillFlat = false
			end

			local var_210_13 = 0

			if var_210_13 < arg_207_1.time_ and arg_207_1.time_ <= var_210_13 + arg_210_0 then
				arg_207_1:PlayTimeline("111101ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action9_2")
			end

			local var_210_14 = 0

			if var_210_14 < arg_207_1.time_ and arg_207_1.time_ <= var_210_14 + arg_210_0 then
				arg_207_1:PlayTimeline("111101ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_210_15 = 0
			local var_210_16 = 0.075

			if var_210_15 < arg_207_1.time_ and arg_207_1.time_ <= var_210_15 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				local var_210_17 = arg_207_1:FormatText(StoryNameCfg[67].name)

				arg_207_1.leftNameTxt_.text = var_210_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_18 = arg_207_1:GetWordFromCfg(1101104053)
				local var_210_19 = arg_207_1:FormatText(var_210_18.content)

				arg_207_1.text_.text = var_210_19

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_20 = 3
				local var_210_21 = utf8.len(var_210_19)
				local var_210_22 = var_210_20 <= 0 and var_210_16 or var_210_16 * (var_210_21 / var_210_20)

				if var_210_22 > 0 and var_210_16 < var_210_22 then
					arg_207_1.talkMaxDuration = var_210_22

					if var_210_22 + var_210_15 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_22 + var_210_15
					end
				end

				arg_207_1.text_.text = var_210_19
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101104", "1101104053", "story_v_side_new_1101104.awb") ~= 0 then
					local var_210_23 = manager.audio:GetVoiceLength("story_v_side_new_1101104", "1101104053", "story_v_side_new_1101104.awb") / 1000

					if var_210_23 + var_210_15 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_23 + var_210_15
					end

					if var_210_18.prefab_name ~= "" and arg_207_1.actors_[var_210_18.prefab_name] ~= nil then
						local var_210_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_207_1.actors_[var_210_18.prefab_name].transform, "story_v_side_new_1101104", "1101104053", "story_v_side_new_1101104.awb")

						arg_207_1:RecordAudio("1101104053", var_210_24)
						arg_207_1:RecordAudio("1101104053", var_210_24)
					else
						arg_207_1:AudioAction("play", "voice", "story_v_side_new_1101104", "1101104053", "story_v_side_new_1101104.awb")
					end

					arg_207_1:RecordHistoryTalkVoice("story_v_side_new_1101104", "1101104053", "story_v_side_new_1101104.awb")
				end

				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_25 = math.max(var_210_16, arg_207_1.talkMaxDuration)

			if var_210_15 <= arg_207_1.time_ and arg_207_1.time_ < var_210_15 + var_210_25 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_15) / var_210_25

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_15 + var_210_25 and arg_207_1.time_ < var_210_15 + var_210_25 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "111101ui_story",
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
	Play1101104054 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 1101104054
		arg_211_1.duration_ = 5

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play1101104055(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			local var_214_0 = arg_211_1.actors_["111101ui_story"]
			local var_214_1 = 0

			if var_214_1 < arg_211_1.time_ and arg_211_1.time_ <= var_214_1 + arg_214_0 and not isNil(var_214_0) and arg_211_1.var_.characterEffect111101ui_story == nil then
				arg_211_1.var_.characterEffect111101ui_story = var_214_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_214_2 = 0.200000002980232

			if var_214_1 <= arg_211_1.time_ and arg_211_1.time_ < var_214_1 + var_214_2 and not isNil(var_214_0) then
				local var_214_3 = (arg_211_1.time_ - var_214_1) / var_214_2

				if arg_211_1.var_.characterEffect111101ui_story and not isNil(var_214_0) then
					local var_214_4 = Mathf.Lerp(0, 0.5, var_214_3)

					arg_211_1.var_.characterEffect111101ui_story.fillFlat = true
					arg_211_1.var_.characterEffect111101ui_story.fillRatio = var_214_4
				end
			end

			if arg_211_1.time_ >= var_214_1 + var_214_2 and arg_211_1.time_ < var_214_1 + var_214_2 + arg_214_0 and not isNil(var_214_0) and arg_211_1.var_.characterEffect111101ui_story then
				local var_214_5 = 0.5

				arg_211_1.var_.characterEffect111101ui_story.fillFlat = true
				arg_211_1.var_.characterEffect111101ui_story.fillRatio = var_214_5
			end

			local var_214_6 = 0
			local var_214_7 = 0.7

			if var_214_6 < arg_211_1.time_ and arg_211_1.time_ <= var_214_6 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, true)

				local var_214_8 = arg_211_1:FormatText(StoryNameCfg[7].name)

				arg_211_1.leftNameTxt_.text = var_214_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_211_1.leftNameTxt_.transform)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1.leftNameTxt_.text)
				SetActive(arg_211_1.iconTrs_.gameObject, true)
				arg_211_1.iconController_:SetSelectedState("hero")

				arg_211_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_211_1.callingController_:SetSelectedState("normal")

				arg_211_1.keyicon_.color = Color.New(1, 1, 1)
				arg_211_1.icon_.color = Color.New(1, 1, 1)

				local var_214_9 = arg_211_1:GetWordFromCfg(1101104054)
				local var_214_10 = arg_211_1:FormatText(var_214_9.content)

				arg_211_1.text_.text = var_214_10

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_11 = 28
				local var_214_12 = utf8.len(var_214_10)
				local var_214_13 = var_214_11 <= 0 and var_214_7 or var_214_7 * (var_214_12 / var_214_11)

				if var_214_13 > 0 and var_214_7 < var_214_13 then
					arg_211_1.talkMaxDuration = var_214_13

					if var_214_13 + var_214_6 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_13 + var_214_6
					end
				end

				arg_211_1.text_.text = var_214_10
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)
				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_14 = math.max(var_214_7, arg_211_1.talkMaxDuration)

			if var_214_6 <= arg_211_1.time_ and arg_211_1.time_ < var_214_6 + var_214_14 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_6) / var_214_14

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_6 + var_214_14 and arg_211_1.time_ < var_214_6 + var_214_14 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {}

		arg_211_1:InitPlayNodeList()
	end,
	Play1101104055 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 1101104055
		arg_215_1.duration_ = 9.33

		local var_215_0 = {
			zh = 6.3,
			ja = 9.333
		}
		local var_215_1 = manager.audio:GetLocalizationFlag()

		if var_215_0[var_215_1] ~= nil then
			arg_215_1.duration_ = var_215_0[var_215_1]
		end

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play1101104056(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			local var_218_0 = arg_215_1.actors_["111101ui_story"].transform
			local var_218_1 = 0

			if var_218_1 < arg_215_1.time_ and arg_215_1.time_ <= var_218_1 + arg_218_0 then
				arg_215_1.var_.moveOldPos111101ui_story = var_218_0.localPosition
			end

			local var_218_2 = 0.001

			if var_218_1 <= arg_215_1.time_ and arg_215_1.time_ < var_218_1 + var_218_2 then
				local var_218_3 = (arg_215_1.time_ - var_218_1) / var_218_2
				local var_218_4 = Vector3.New(0, -0.83, -6)

				var_218_0.localPosition = Vector3.Lerp(arg_215_1.var_.moveOldPos111101ui_story, var_218_4, var_218_3)

				local var_218_5 = manager.ui.mainCamera.transform.position - var_218_0.position

				var_218_0.forward = Vector3.New(var_218_5.x, var_218_5.y, var_218_5.z)

				local var_218_6 = var_218_0.localEulerAngles

				var_218_6.z = 0
				var_218_6.x = 0
				var_218_0.localEulerAngles = var_218_6
			end

			if arg_215_1.time_ >= var_218_1 + var_218_2 and arg_215_1.time_ < var_218_1 + var_218_2 + arg_218_0 then
				var_218_0.localPosition = Vector3.New(0, -0.83, -6)

				local var_218_7 = manager.ui.mainCamera.transform.position - var_218_0.position

				var_218_0.forward = Vector3.New(var_218_7.x, var_218_7.y, var_218_7.z)

				local var_218_8 = var_218_0.localEulerAngles

				var_218_8.z = 0
				var_218_8.x = 0
				var_218_0.localEulerAngles = var_218_8
			end

			local var_218_9 = arg_215_1.actors_["111101ui_story"]
			local var_218_10 = 0

			if var_218_10 < arg_215_1.time_ and arg_215_1.time_ <= var_218_10 + arg_218_0 and not isNil(var_218_9) and arg_215_1.var_.characterEffect111101ui_story == nil then
				arg_215_1.var_.characterEffect111101ui_story = var_218_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_218_11 = 0.200000002980232

			if var_218_10 <= arg_215_1.time_ and arg_215_1.time_ < var_218_10 + var_218_11 and not isNil(var_218_9) then
				local var_218_12 = (arg_215_1.time_ - var_218_10) / var_218_11

				if arg_215_1.var_.characterEffect111101ui_story and not isNil(var_218_9) then
					arg_215_1.var_.characterEffect111101ui_story.fillFlat = false
				end
			end

			if arg_215_1.time_ >= var_218_10 + var_218_11 and arg_215_1.time_ < var_218_10 + var_218_11 + arg_218_0 and not isNil(var_218_9) and arg_215_1.var_.characterEffect111101ui_story then
				arg_215_1.var_.characterEffect111101ui_story.fillFlat = false
			end

			local var_218_13 = 0

			if var_218_13 < arg_215_1.time_ and arg_215_1.time_ <= var_218_13 + arg_218_0 then
				arg_215_1:PlayTimeline("111101ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action6_1")
			end

			local var_218_14 = 0

			if var_218_14 < arg_215_1.time_ and arg_215_1.time_ <= var_218_14 + arg_218_0 then
				arg_215_1:PlayTimeline("111101ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_218_15 = 0
			local var_218_16 = 0.675

			if var_218_15 < arg_215_1.time_ and arg_215_1.time_ <= var_218_15 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				local var_218_17 = arg_215_1:FormatText(StoryNameCfg[67].name)

				arg_215_1.leftNameTxt_.text = var_218_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_18 = arg_215_1:GetWordFromCfg(1101104055)
				local var_218_19 = arg_215_1:FormatText(var_218_18.content)

				arg_215_1.text_.text = var_218_19

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_20 = 27
				local var_218_21 = utf8.len(var_218_19)
				local var_218_22 = var_218_20 <= 0 and var_218_16 or var_218_16 * (var_218_21 / var_218_20)

				if var_218_22 > 0 and var_218_16 < var_218_22 then
					arg_215_1.talkMaxDuration = var_218_22

					if var_218_22 + var_218_15 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_22 + var_218_15
					end
				end

				arg_215_1.text_.text = var_218_19
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101104", "1101104055", "story_v_side_new_1101104.awb") ~= 0 then
					local var_218_23 = manager.audio:GetVoiceLength("story_v_side_new_1101104", "1101104055", "story_v_side_new_1101104.awb") / 1000

					if var_218_23 + var_218_15 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_23 + var_218_15
					end

					if var_218_18.prefab_name ~= "" and arg_215_1.actors_[var_218_18.prefab_name] ~= nil then
						local var_218_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_215_1.actors_[var_218_18.prefab_name].transform, "story_v_side_new_1101104", "1101104055", "story_v_side_new_1101104.awb")

						arg_215_1:RecordAudio("1101104055", var_218_24)
						arg_215_1:RecordAudio("1101104055", var_218_24)
					else
						arg_215_1:AudioAction("play", "voice", "story_v_side_new_1101104", "1101104055", "story_v_side_new_1101104.awb")
					end

					arg_215_1:RecordHistoryTalkVoice("story_v_side_new_1101104", "1101104055", "story_v_side_new_1101104.awb")
				end

				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_25 = math.max(var_218_16, arg_215_1.talkMaxDuration)

			if var_218_15 <= arg_215_1.time_ and arg_215_1.time_ < var_218_15 + var_218_25 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_15) / var_218_25

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_15 + var_218_25 and arg_215_1.time_ < var_218_15 + var_218_25 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "111101ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_215_1:InitPlayNodeList()
	end,
	Play1101104056 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 1101104056
		arg_219_1.duration_ = 5

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play1101104057(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			local var_222_0 = arg_219_1.actors_["111101ui_story"]
			local var_222_1 = 0

			if var_222_1 < arg_219_1.time_ and arg_219_1.time_ <= var_222_1 + arg_222_0 and not isNil(var_222_0) and arg_219_1.var_.characterEffect111101ui_story == nil then
				arg_219_1.var_.characterEffect111101ui_story = var_222_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_222_2 = 0.200000002980232

			if var_222_1 <= arg_219_1.time_ and arg_219_1.time_ < var_222_1 + var_222_2 and not isNil(var_222_0) then
				local var_222_3 = (arg_219_1.time_ - var_222_1) / var_222_2

				if arg_219_1.var_.characterEffect111101ui_story and not isNil(var_222_0) then
					local var_222_4 = Mathf.Lerp(0, 0.5, var_222_3)

					arg_219_1.var_.characterEffect111101ui_story.fillFlat = true
					arg_219_1.var_.characterEffect111101ui_story.fillRatio = var_222_4
				end
			end

			if arg_219_1.time_ >= var_222_1 + var_222_2 and arg_219_1.time_ < var_222_1 + var_222_2 + arg_222_0 and not isNil(var_222_0) and arg_219_1.var_.characterEffect111101ui_story then
				local var_222_5 = 0.5

				arg_219_1.var_.characterEffect111101ui_story.fillFlat = true
				arg_219_1.var_.characterEffect111101ui_story.fillRatio = var_222_5
			end

			local var_222_6 = arg_219_1.actors_["111101ui_story"].transform
			local var_222_7 = 0

			if var_222_7 < arg_219_1.time_ and arg_219_1.time_ <= var_222_7 + arg_222_0 then
				arg_219_1.var_.moveOldPos111101ui_story = var_222_6.localPosition
			end

			local var_222_8 = 0.001

			if var_222_7 <= arg_219_1.time_ and arg_219_1.time_ < var_222_7 + var_222_8 then
				local var_222_9 = (arg_219_1.time_ - var_222_7) / var_222_8
				local var_222_10 = Vector3.New(0, 100, 0)

				var_222_6.localPosition = Vector3.Lerp(arg_219_1.var_.moveOldPos111101ui_story, var_222_10, var_222_9)

				local var_222_11 = manager.ui.mainCamera.transform.position - var_222_6.position

				var_222_6.forward = Vector3.New(var_222_11.x, var_222_11.y, var_222_11.z)

				local var_222_12 = var_222_6.localEulerAngles

				var_222_12.z = 0
				var_222_12.x = 0
				var_222_6.localEulerAngles = var_222_12
			end

			if arg_219_1.time_ >= var_222_7 + var_222_8 and arg_219_1.time_ < var_222_7 + var_222_8 + arg_222_0 then
				var_222_6.localPosition = Vector3.New(0, 100, 0)

				local var_222_13 = manager.ui.mainCamera.transform.position - var_222_6.position

				var_222_6.forward = Vector3.New(var_222_13.x, var_222_13.y, var_222_13.z)

				local var_222_14 = var_222_6.localEulerAngles

				var_222_14.z = 0
				var_222_14.x = 0
				var_222_6.localEulerAngles = var_222_14
			end

			local var_222_15 = 0
			local var_222_16 = 0.75

			if var_222_15 < arg_219_1.time_ and arg_219_1.time_ <= var_222_15 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, false)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_17 = arg_219_1:GetWordFromCfg(1101104056)
				local var_222_18 = arg_219_1:FormatText(var_222_17.content)

				arg_219_1.text_.text = var_222_18

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_19 = 30
				local var_222_20 = utf8.len(var_222_18)
				local var_222_21 = var_222_19 <= 0 and var_222_16 or var_222_16 * (var_222_20 / var_222_19)

				if var_222_21 > 0 and var_222_16 < var_222_21 then
					arg_219_1.talkMaxDuration = var_222_21

					if var_222_21 + var_222_15 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_21 + var_222_15
					end
				end

				arg_219_1.text_.text = var_222_18
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)
				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_22 = math.max(var_222_16, arg_219_1.talkMaxDuration)

			if var_222_15 <= arg_219_1.time_ and arg_219_1.time_ < var_222_15 + var_222_22 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_15) / var_222_22

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_15 + var_222_22 and arg_219_1.time_ < var_222_15 + var_222_22 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "111101ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_219_1:InitPlayNodeList()
	end,
	Play1101104057 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 1101104057
		arg_223_1.duration_ = 5

		SetActive(arg_223_1.tipsGo_, false)

		function arg_223_1.onSingleLineFinish_()
			arg_223_1.onSingleLineUpdate_ = nil
			arg_223_1.onSingleLineFinish_ = nil
			arg_223_1.state_ = "waiting"
		end

		function arg_223_1.playNext_(arg_225_0)
			if arg_225_0 == 1 then
				arg_223_0:Play1101104058(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			local var_226_0 = arg_223_1.actors_["111101ui_story"].transform
			local var_226_1 = 0

			if var_226_1 < arg_223_1.time_ and arg_223_1.time_ <= var_226_1 + arg_226_0 then
				arg_223_1.var_.moveOldPos111101ui_story = var_226_0.localPosition
			end

			local var_226_2 = 0.001

			if var_226_1 <= arg_223_1.time_ and arg_223_1.time_ < var_226_1 + var_226_2 then
				local var_226_3 = (arg_223_1.time_ - var_226_1) / var_226_2
				local var_226_4 = Vector3.New(0, -0.83, -6)

				var_226_0.localPosition = Vector3.Lerp(arg_223_1.var_.moveOldPos111101ui_story, var_226_4, var_226_3)

				local var_226_5 = manager.ui.mainCamera.transform.position - var_226_0.position

				var_226_0.forward = Vector3.New(var_226_5.x, var_226_5.y, var_226_5.z)

				local var_226_6 = var_226_0.localEulerAngles

				var_226_6.z = 0
				var_226_6.x = 0
				var_226_0.localEulerAngles = var_226_6
			end

			if arg_223_1.time_ >= var_226_1 + var_226_2 and arg_223_1.time_ < var_226_1 + var_226_2 + arg_226_0 then
				var_226_0.localPosition = Vector3.New(0, -0.83, -6)

				local var_226_7 = manager.ui.mainCamera.transform.position - var_226_0.position

				var_226_0.forward = Vector3.New(var_226_7.x, var_226_7.y, var_226_7.z)

				local var_226_8 = var_226_0.localEulerAngles

				var_226_8.z = 0
				var_226_8.x = 0
				var_226_0.localEulerAngles = var_226_8
			end

			local var_226_9 = arg_223_1.actors_["111101ui_story"]
			local var_226_10 = 0

			if var_226_10 < arg_223_1.time_ and arg_223_1.time_ <= var_226_10 + arg_226_0 and not isNil(var_226_9) and arg_223_1.var_.characterEffect111101ui_story == nil then
				arg_223_1.var_.characterEffect111101ui_story = var_226_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_226_11 = 0.200000002980232

			if var_226_10 <= arg_223_1.time_ and arg_223_1.time_ < var_226_10 + var_226_11 and not isNil(var_226_9) then
				local var_226_12 = (arg_223_1.time_ - var_226_10) / var_226_11

				if arg_223_1.var_.characterEffect111101ui_story and not isNil(var_226_9) then
					local var_226_13 = Mathf.Lerp(0, 0.5, var_226_12)

					arg_223_1.var_.characterEffect111101ui_story.fillFlat = true
					arg_223_1.var_.characterEffect111101ui_story.fillRatio = var_226_13
				end
			end

			if arg_223_1.time_ >= var_226_10 + var_226_11 and arg_223_1.time_ < var_226_10 + var_226_11 + arg_226_0 and not isNil(var_226_9) and arg_223_1.var_.characterEffect111101ui_story then
				local var_226_14 = 0.5

				arg_223_1.var_.characterEffect111101ui_story.fillFlat = true
				arg_223_1.var_.characterEffect111101ui_story.fillRatio = var_226_14
			end

			local var_226_15 = 0

			if var_226_15 < arg_223_1.time_ and arg_223_1.time_ <= var_226_15 + arg_226_0 then
				arg_223_1:PlayTimeline("111101ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action1_1")
			end

			local var_226_16 = 0

			if var_226_16 < arg_223_1.time_ and arg_223_1.time_ <= var_226_16 + arg_226_0 then
				arg_223_1:PlayTimeline("111101ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_226_17 = 0
			local var_226_18 = 0.3

			if var_226_17 < arg_223_1.time_ and arg_223_1.time_ <= var_226_17 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				local var_226_19 = arg_223_1:FormatText(StoryNameCfg[7].name)

				arg_223_1.leftNameTxt_.text = var_226_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, true)
				arg_223_1.iconController_:SetSelectedState("hero")

				arg_223_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_223_1.callingController_:SetSelectedState("normal")

				arg_223_1.keyicon_.color = Color.New(1, 1, 1)
				arg_223_1.icon_.color = Color.New(1, 1, 1)

				local var_226_20 = arg_223_1:GetWordFromCfg(1101104057)
				local var_226_21 = arg_223_1:FormatText(var_226_20.content)

				arg_223_1.text_.text = var_226_21

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_22 = 12
				local var_226_23 = utf8.len(var_226_21)
				local var_226_24 = var_226_22 <= 0 and var_226_18 or var_226_18 * (var_226_23 / var_226_22)

				if var_226_24 > 0 and var_226_18 < var_226_24 then
					arg_223_1.talkMaxDuration = var_226_24

					if var_226_24 + var_226_17 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_24 + var_226_17
					end
				end

				arg_223_1.text_.text = var_226_21
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)
				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_25 = math.max(var_226_18, arg_223_1.talkMaxDuration)

			if var_226_17 <= arg_223_1.time_ and arg_223_1.time_ < var_226_17 + var_226_25 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_17) / var_226_25

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_17 + var_226_25 and arg_223_1.time_ < var_226_17 + var_226_25 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "111101ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_223_1:InitPlayNodeList()
	end,
	Play1101104058 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 1101104058
		arg_227_1.duration_ = 1

		SetActive(arg_227_1.tipsGo_, false)

		function arg_227_1.onSingleLineFinish_()
			arg_227_1.onSingleLineUpdate_ = nil
			arg_227_1.onSingleLineFinish_ = nil
			arg_227_1.state_ = "waiting"

			SetActive(arg_227_1.choicesGo_, true)

			for iter_228_0, iter_228_1 in ipairs(arg_227_1.choices_) do
				local var_228_0 = iter_228_0 <= 2

				SetActive(iter_228_1.go, var_228_0)
			end

			arg_227_1.choices_[1].txt.text = arg_227_1:FormatText(StoryChoiceCfg[615].name)
			arg_227_1.choices_[2].txt.text = arg_227_1:FormatText(StoryChoiceCfg[616].name)
		end

		function arg_227_1.playNext_(arg_229_0)
			if arg_229_0 == 1 then
				arg_227_0:Play1101104059(arg_227_1)
			end

			if arg_229_0 == 2 then
				arg_227_0:Play1101104059(arg_227_1)
			end

			arg_227_1:RecordChoiceLog(1101104058, 615, 616)
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			local var_230_0 = 0

			if var_230_0 < arg_227_1.time_ and arg_227_1.time_ <= var_230_0 + arg_230_0 then
				arg_227_1.allBtn_.enabled = false
			end

			local var_230_1 = 0.5

			if arg_227_1.time_ >= var_230_0 + var_230_1 and arg_227_1.time_ < var_230_0 + var_230_1 + arg_230_0 then
				arg_227_1.allBtn_.enabled = true
			end
		end

		arg_227_1.nodeConfigList_ = {}

		arg_227_1:InitPlayNodeList()
	end,
	Play1101104059 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 1101104059
		arg_231_1.duration_ = 3.13

		local var_231_0 = {
			zh = 2.466,
			ja = 3.133
		}
		local var_231_1 = manager.audio:GetLocalizationFlag()

		if var_231_0[var_231_1] ~= nil then
			arg_231_1.duration_ = var_231_0[var_231_1]
		end

		SetActive(arg_231_1.tipsGo_, false)

		function arg_231_1.onSingleLineFinish_()
			arg_231_1.onSingleLineUpdate_ = nil
			arg_231_1.onSingleLineFinish_ = nil
			arg_231_1.state_ = "waiting"
		end

		function arg_231_1.playNext_(arg_233_0)
			if arg_233_0 == 1 then
				arg_231_0:Play1101104060(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			local var_234_0 = arg_231_1.actors_["111101ui_story"].transform
			local var_234_1 = 0

			if var_234_1 < arg_231_1.time_ and arg_231_1.time_ <= var_234_1 + arg_234_0 then
				arg_231_1.var_.moveOldPos111101ui_story = var_234_0.localPosition
			end

			local var_234_2 = 0.001

			if var_234_1 <= arg_231_1.time_ and arg_231_1.time_ < var_234_1 + var_234_2 then
				local var_234_3 = (arg_231_1.time_ - var_234_1) / var_234_2
				local var_234_4 = Vector3.New(0, -0.83, -6)

				var_234_0.localPosition = Vector3.Lerp(arg_231_1.var_.moveOldPos111101ui_story, var_234_4, var_234_3)

				local var_234_5 = manager.ui.mainCamera.transform.position - var_234_0.position

				var_234_0.forward = Vector3.New(var_234_5.x, var_234_5.y, var_234_5.z)

				local var_234_6 = var_234_0.localEulerAngles

				var_234_6.z = 0
				var_234_6.x = 0
				var_234_0.localEulerAngles = var_234_6
			end

			if arg_231_1.time_ >= var_234_1 + var_234_2 and arg_231_1.time_ < var_234_1 + var_234_2 + arg_234_0 then
				var_234_0.localPosition = Vector3.New(0, -0.83, -6)

				local var_234_7 = manager.ui.mainCamera.transform.position - var_234_0.position

				var_234_0.forward = Vector3.New(var_234_7.x, var_234_7.y, var_234_7.z)

				local var_234_8 = var_234_0.localEulerAngles

				var_234_8.z = 0
				var_234_8.x = 0
				var_234_0.localEulerAngles = var_234_8
			end

			local var_234_9 = arg_231_1.actors_["111101ui_story"]
			local var_234_10 = 0

			if var_234_10 < arg_231_1.time_ and arg_231_1.time_ <= var_234_10 + arg_234_0 and not isNil(var_234_9) and arg_231_1.var_.characterEffect111101ui_story == nil then
				arg_231_1.var_.characterEffect111101ui_story = var_234_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_234_11 = 0.200000002980232

			if var_234_10 <= arg_231_1.time_ and arg_231_1.time_ < var_234_10 + var_234_11 and not isNil(var_234_9) then
				local var_234_12 = (arg_231_1.time_ - var_234_10) / var_234_11

				if arg_231_1.var_.characterEffect111101ui_story and not isNil(var_234_9) then
					arg_231_1.var_.characterEffect111101ui_story.fillFlat = false
				end
			end

			if arg_231_1.time_ >= var_234_10 + var_234_11 and arg_231_1.time_ < var_234_10 + var_234_11 + arg_234_0 and not isNil(var_234_9) and arg_231_1.var_.characterEffect111101ui_story then
				arg_231_1.var_.characterEffect111101ui_story.fillFlat = false
			end

			local var_234_13 = "111101ui_story"

			if arg_231_1.actors_[var_234_13] == nil then
				local var_234_14 = Asset.Load("Char/" .. "111101ui_story")

				if not isNil(var_234_14) then
					local var_234_15 = Object.Instantiate(Asset.Load("Char/" .. "111101ui_story"), arg_231_1.stage_.transform)

					var_234_15.name = var_234_13
					var_234_15.transform.localPosition = Vector3.New(0, 100, 0)
					arg_231_1.actors_[var_234_13] = var_234_15

					local var_234_16 = var_234_15:GetComponentInChildren(typeof(CharacterEffect))

					var_234_16.enabled = true

					local var_234_17 = GameObjectTools.GetOrAddComponent(var_234_15, typeof(DynamicBoneHelper))

					if var_234_17 then
						var_234_17:EnableDynamicBone(false)
					end

					arg_231_1:ShowWeapon(var_234_16.transform, false)

					arg_231_1.var_[var_234_13 .. "Animator"] = var_234_16.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_231_1.var_[var_234_13 .. "Animator"].applyRootMotion = true
					arg_231_1.var_[var_234_13 .. "LipSync"] = var_234_16.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_234_18 = 0

			if var_234_18 < arg_231_1.time_ and arg_231_1.time_ <= var_234_18 + arg_234_0 then
				arg_231_1:PlayTimeline("111101ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action4_1")
			end

			local var_234_19 = "111101ui_story"

			if arg_231_1.actors_[var_234_19] == nil then
				local var_234_20 = Asset.Load("Char/" .. "111101ui_story")

				if not isNil(var_234_20) then
					local var_234_21 = Object.Instantiate(Asset.Load("Char/" .. "111101ui_story"), arg_231_1.stage_.transform)

					var_234_21.name = var_234_19
					var_234_21.transform.localPosition = Vector3.New(0, 100, 0)
					arg_231_1.actors_[var_234_19] = var_234_21

					local var_234_22 = var_234_21:GetComponentInChildren(typeof(CharacterEffect))

					var_234_22.enabled = true

					local var_234_23 = GameObjectTools.GetOrAddComponent(var_234_21, typeof(DynamicBoneHelper))

					if var_234_23 then
						var_234_23:EnableDynamicBone(false)
					end

					arg_231_1:ShowWeapon(var_234_22.transform, false)

					arg_231_1.var_[var_234_19 .. "Animator"] = var_234_22.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_231_1.var_[var_234_19 .. "Animator"].applyRootMotion = true
					arg_231_1.var_[var_234_19 .. "LipSync"] = var_234_22.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_234_24 = 0

			if var_234_24 < arg_231_1.time_ and arg_231_1.time_ <= var_234_24 + arg_234_0 then
				arg_231_1:PlayTimeline("111101ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_234_25 = 0
			local var_234_26 = 0.225

			if var_234_25 < arg_231_1.time_ and arg_231_1.time_ <= var_234_25 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				local var_234_27 = arg_231_1:FormatText(StoryNameCfg[67].name)

				arg_231_1.leftNameTxt_.text = var_234_27

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_28 = arg_231_1:GetWordFromCfg(1101104059)
				local var_234_29 = arg_231_1:FormatText(var_234_28.content)

				arg_231_1.text_.text = var_234_29

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_30 = 9
				local var_234_31 = utf8.len(var_234_29)
				local var_234_32 = var_234_30 <= 0 and var_234_26 or var_234_26 * (var_234_31 / var_234_30)

				if var_234_32 > 0 and var_234_26 < var_234_32 then
					arg_231_1.talkMaxDuration = var_234_32

					if var_234_32 + var_234_25 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_32 + var_234_25
					end
				end

				arg_231_1.text_.text = var_234_29
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101104", "1101104059", "story_v_side_new_1101104.awb") ~= 0 then
					local var_234_33 = manager.audio:GetVoiceLength("story_v_side_new_1101104", "1101104059", "story_v_side_new_1101104.awb") / 1000

					if var_234_33 + var_234_25 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_33 + var_234_25
					end

					if var_234_28.prefab_name ~= "" and arg_231_1.actors_[var_234_28.prefab_name] ~= nil then
						local var_234_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_231_1.actors_[var_234_28.prefab_name].transform, "story_v_side_new_1101104", "1101104059", "story_v_side_new_1101104.awb")

						arg_231_1:RecordAudio("1101104059", var_234_34)
						arg_231_1:RecordAudio("1101104059", var_234_34)
					else
						arg_231_1:AudioAction("play", "voice", "story_v_side_new_1101104", "1101104059", "story_v_side_new_1101104.awb")
					end

					arg_231_1:RecordHistoryTalkVoice("story_v_side_new_1101104", "1101104059", "story_v_side_new_1101104.awb")
				end

				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_35 = math.max(var_234_26, arg_231_1.talkMaxDuration)

			if var_234_25 <= arg_231_1.time_ and arg_231_1.time_ < var_234_25 + var_234_35 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_25) / var_234_35

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_25 + var_234_35 and arg_231_1.time_ < var_234_25 + var_234_35 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "111101ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_231_1:InitPlayNodeList()
	end,
	Play1101104060 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 1101104060
		arg_235_1.duration_ = 4.33

		SetActive(arg_235_1.tipsGo_, false)

		function arg_235_1.onSingleLineFinish_()
			arg_235_1.onSingleLineUpdate_ = nil
			arg_235_1.onSingleLineFinish_ = nil
			arg_235_1.state_ = "waiting"
		end

		function arg_235_1.playNext_(arg_237_0)
			if arg_237_0 == 1 then
				arg_235_0:Play1101104061(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			local var_238_0 = 2

			if var_238_0 < arg_235_1.time_ and arg_235_1.time_ <= var_238_0 + arg_238_0 then
				local var_238_1 = manager.ui.mainCamera.transform.localPosition
				local var_238_2 = Vector3.New(0, 0, 10) + Vector3.New(var_238_1.x, var_238_1.y, 0)
				local var_238_3 = arg_235_1.bgs_.ST12

				var_238_3.transform.localPosition = var_238_2
				var_238_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_238_4 = var_238_3:GetComponent("SpriteRenderer")

				if var_238_4 and var_238_4.sprite then
					local var_238_5 = (var_238_3.transform.localPosition - var_238_1).z
					local var_238_6 = manager.ui.mainCameraCom_
					local var_238_7 = 2 * var_238_5 * Mathf.Tan(var_238_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_238_8 = var_238_7 * var_238_6.aspect
					local var_238_9 = var_238_4.sprite.bounds.size.x
					local var_238_10 = var_238_4.sprite.bounds.size.y
					local var_238_11 = var_238_8 / var_238_9
					local var_238_12 = var_238_7 / var_238_10
					local var_238_13 = var_238_12 < var_238_11 and var_238_11 or var_238_12

					var_238_3.transform.localScale = Vector3.New(var_238_13, var_238_13, 0)
				end

				for iter_238_0, iter_238_1 in pairs(arg_235_1.bgs_) do
					if iter_238_0 ~= "ST12" then
						iter_238_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_238_14 = 0

			if var_238_14 < arg_235_1.time_ and arg_235_1.time_ <= var_238_14 + arg_238_0 then
				arg_235_1.mask_.enabled = true
				arg_235_1.mask_.raycastTarget = true

				arg_235_1:SetGaussion(false)
			end

			local var_238_15 = 2

			if var_238_14 <= arg_235_1.time_ and arg_235_1.time_ < var_238_14 + var_238_15 then
				local var_238_16 = (arg_235_1.time_ - var_238_14) / var_238_15
				local var_238_17 = Color.New(0, 0, 0)

				var_238_17.a = Mathf.Lerp(0, 1, var_238_16)
				arg_235_1.mask_.color = var_238_17
			end

			if arg_235_1.time_ >= var_238_14 + var_238_15 and arg_235_1.time_ < var_238_14 + var_238_15 + arg_238_0 then
				local var_238_18 = Color.New(0, 0, 0)

				var_238_18.a = 1
				arg_235_1.mask_.color = var_238_18
			end

			local var_238_19 = 2

			if var_238_19 < arg_235_1.time_ and arg_235_1.time_ <= var_238_19 + arg_238_0 then
				arg_235_1.mask_.enabled = true
				arg_235_1.mask_.raycastTarget = true

				arg_235_1:SetGaussion(false)
			end

			local var_238_20 = 2

			if var_238_19 <= arg_235_1.time_ and arg_235_1.time_ < var_238_19 + var_238_20 then
				local var_238_21 = (arg_235_1.time_ - var_238_19) / var_238_20
				local var_238_22 = Color.New(0, 0, 0)

				var_238_22.a = Mathf.Lerp(1, 0, var_238_21)
				arg_235_1.mask_.color = var_238_22
			end

			if arg_235_1.time_ >= var_238_19 + var_238_20 and arg_235_1.time_ < var_238_19 + var_238_20 + arg_238_0 then
				local var_238_23 = Color.New(0, 0, 0)
				local var_238_24 = 0

				arg_235_1.mask_.enabled = false
				var_238_23.a = var_238_24
				arg_235_1.mask_.color = var_238_23
			end

			local var_238_25 = arg_235_1.actors_["111101ui_story"].transform
			local var_238_26 = 2

			if var_238_26 < arg_235_1.time_ and arg_235_1.time_ <= var_238_26 + arg_238_0 then
				arg_235_1.var_.moveOldPos111101ui_story = var_238_25.localPosition
			end

			local var_238_27 = 0.001

			if var_238_26 <= arg_235_1.time_ and arg_235_1.time_ < var_238_26 + var_238_27 then
				local var_238_28 = (arg_235_1.time_ - var_238_26) / var_238_27
				local var_238_29 = Vector3.New(0, 100, 0)

				var_238_25.localPosition = Vector3.Lerp(arg_235_1.var_.moveOldPos111101ui_story, var_238_29, var_238_28)

				local var_238_30 = manager.ui.mainCamera.transform.position - var_238_25.position

				var_238_25.forward = Vector3.New(var_238_30.x, var_238_30.y, var_238_30.z)

				local var_238_31 = var_238_25.localEulerAngles

				var_238_31.z = 0
				var_238_31.x = 0
				var_238_25.localEulerAngles = var_238_31
			end

			if arg_235_1.time_ >= var_238_26 + var_238_27 and arg_235_1.time_ < var_238_26 + var_238_27 + arg_238_0 then
				var_238_25.localPosition = Vector3.New(0, 100, 0)

				local var_238_32 = manager.ui.mainCamera.transform.position - var_238_25.position

				var_238_25.forward = Vector3.New(var_238_32.x, var_238_32.y, var_238_32.z)

				local var_238_33 = var_238_25.localEulerAngles

				var_238_33.z = 0
				var_238_33.x = 0
				var_238_25.localEulerAngles = var_238_33
			end

			local var_238_34 = 4

			if var_238_34 < arg_235_1.time_ and arg_235_1.time_ <= var_238_34 + arg_238_0 then
				local var_238_35 = arg_235_1.fswbg_.transform:Find("textbox/adapt/content") or arg_235_1.fswbg_.transform:Find("textbox/content")
				local var_238_36 = arg_235_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_238_37 = var_238_35:GetComponent("Text")
				local var_238_38 = var_238_35:GetComponent("RectTransform")

				var_238_37.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_238_38.offsetMin = Vector2.New(0, 0)
				var_238_38.offsetMax = Vector2.New(0, 0)
			end

			local var_238_39 = 2

			if var_238_39 < arg_235_1.time_ and arg_235_1.time_ <= var_238_39 + arg_238_0 then
				arg_235_1.fswbg_:SetActive(true)
				arg_235_1.dialog_:SetActive(false)

				arg_235_1.fswtw_.percent = 0

				local var_238_40 = arg_235_1:GetWordFromCfg(1101104060)
				local var_238_41 = arg_235_1:FormatText(var_238_40.content)

				arg_235_1.fswt_.text = var_238_41

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.fswt_)

				arg_235_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_235_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_235_1.fswtw_:SetDirty()

				arg_235_1.typewritterCharCountI18N = 0

				SetActive(arg_235_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_235_1:ShowNextGo(false)
			end

			local var_238_42 = 4

			if var_238_42 < arg_235_1.time_ and arg_235_1.time_ <= var_238_42 + arg_238_0 then
				arg_235_1.var_.oldValueTypewriter = arg_235_1.fswtw_.percent

				SetActive(arg_235_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_235_1:ShowNextGo(false)
			end

			local var_238_43 = 5
			local var_238_44 = 0.333333333333333
			local var_238_45 = arg_235_1:GetWordFromCfg(1101104060)
			local var_238_46 = arg_235_1:FormatText(var_238_45.content)
			local var_238_47, var_238_48 = arg_235_1:GetPercentByPara(var_238_46, 1)

			if var_238_42 < arg_235_1.time_ and arg_235_1.time_ <= var_238_42 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0

				local var_238_49 = var_238_43 <= 0 and var_238_44 or var_238_44 * ((var_238_48 - arg_235_1.typewritterCharCountI18N) / var_238_43)

				if var_238_49 > 0 and var_238_44 < var_238_49 then
					arg_235_1.talkMaxDuration = var_238_49

					if var_238_49 + var_238_42 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_49 + var_238_42
					end
				end
			end

			local var_238_50 = 0.333333333333333
			local var_238_51 = math.max(var_238_50, arg_235_1.talkMaxDuration)

			if var_238_42 <= arg_235_1.time_ and arg_235_1.time_ < var_238_42 + var_238_51 then
				local var_238_52 = (arg_235_1.time_ - var_238_42) / var_238_51

				arg_235_1.fswtw_.percent = Mathf.Lerp(arg_235_1.var_.oldValueTypewriter, var_238_47, var_238_52)
				arg_235_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_235_1.fswtw_:SetDirty()
			end

			if arg_235_1.time_ >= var_238_42 + var_238_51 and arg_235_1.time_ < var_238_42 + var_238_51 + arg_238_0 then
				arg_235_1.fswtw_.percent = var_238_47

				arg_235_1.fswtw_:SetDirty()
				arg_235_1:ShowNextGo(true)

				arg_235_1.typewritterCharCountI18N = var_238_48
			end
		end

		arg_235_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "111101ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_235_1:InitPlayNodeList()
	end,
	Play1101104061 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 1101104061
		arg_239_1.duration_ = 9.37

		local var_239_0 = {
			zh = 4.566,
			ja = 9.366
		}
		local var_239_1 = manager.audio:GetLocalizationFlag()

		if var_239_0[var_239_1] ~= nil then
			arg_239_1.duration_ = var_239_0[var_239_1]
		end

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"
		end

		function arg_239_1.playNext_(arg_241_0)
			if arg_241_0 == 1 then
				arg_239_0:Play1101104062(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			local var_242_0 = arg_239_1.actors_["111101ui_story"].transform
			local var_242_1 = 0

			if var_242_1 < arg_239_1.time_ and arg_239_1.time_ <= var_242_1 + arg_242_0 then
				arg_239_1.var_.moveOldPos111101ui_story = var_242_0.localPosition
			end

			local var_242_2 = 0.001

			if var_242_1 <= arg_239_1.time_ and arg_239_1.time_ < var_242_1 + var_242_2 then
				local var_242_3 = (arg_239_1.time_ - var_242_1) / var_242_2
				local var_242_4 = Vector3.New(0, -0.83, -6)

				var_242_0.localPosition = Vector3.Lerp(arg_239_1.var_.moveOldPos111101ui_story, var_242_4, var_242_3)

				local var_242_5 = manager.ui.mainCamera.transform.position - var_242_0.position

				var_242_0.forward = Vector3.New(var_242_5.x, var_242_5.y, var_242_5.z)

				local var_242_6 = var_242_0.localEulerAngles

				var_242_6.z = 0
				var_242_6.x = 0
				var_242_0.localEulerAngles = var_242_6
			end

			if arg_239_1.time_ >= var_242_1 + var_242_2 and arg_239_1.time_ < var_242_1 + var_242_2 + arg_242_0 then
				var_242_0.localPosition = Vector3.New(0, -0.83, -6)

				local var_242_7 = manager.ui.mainCamera.transform.position - var_242_0.position

				var_242_0.forward = Vector3.New(var_242_7.x, var_242_7.y, var_242_7.z)

				local var_242_8 = var_242_0.localEulerAngles

				var_242_8.z = 0
				var_242_8.x = 0
				var_242_0.localEulerAngles = var_242_8
			end

			local var_242_9 = arg_239_1.actors_["111101ui_story"]
			local var_242_10 = 0

			if var_242_10 < arg_239_1.time_ and arg_239_1.time_ <= var_242_10 + arg_242_0 and not isNil(var_242_9) and arg_239_1.var_.characterEffect111101ui_story == nil then
				arg_239_1.var_.characterEffect111101ui_story = var_242_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_242_11 = 0.200000002980232

			if var_242_10 <= arg_239_1.time_ and arg_239_1.time_ < var_242_10 + var_242_11 and not isNil(var_242_9) then
				local var_242_12 = (arg_239_1.time_ - var_242_10) / var_242_11

				if arg_239_1.var_.characterEffect111101ui_story and not isNil(var_242_9) then
					arg_239_1.var_.characterEffect111101ui_story.fillFlat = false
				end
			end

			if arg_239_1.time_ >= var_242_10 + var_242_11 and arg_239_1.time_ < var_242_10 + var_242_11 + arg_242_0 and not isNil(var_242_9) and arg_239_1.var_.characterEffect111101ui_story then
				arg_239_1.var_.characterEffect111101ui_story.fillFlat = false
			end

			local var_242_13 = 0

			if var_242_13 < arg_239_1.time_ and arg_239_1.time_ <= var_242_13 + arg_242_0 then
				arg_239_1:PlayTimeline("111101ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action4_1")
			end

			local var_242_14 = 0

			if var_242_14 < arg_239_1.time_ and arg_239_1.time_ <= var_242_14 + arg_242_0 then
				arg_239_1:PlayTimeline("111101ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_242_15 = 0

			if var_242_15 < arg_239_1.time_ and arg_239_1.time_ <= var_242_15 + arg_242_0 then
				arg_239_1.fswbg_:SetActive(false)
				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_239_1:ShowNextGo(false)
			end

			local var_242_16 = 0
			local var_242_17 = 0.525

			if var_242_16 < arg_239_1.time_ and arg_239_1.time_ <= var_242_16 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				local var_242_18 = arg_239_1:FormatText(StoryNameCfg[67].name)

				arg_239_1.leftNameTxt_.text = var_242_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_19 = arg_239_1:GetWordFromCfg(1101104061)
				local var_242_20 = arg_239_1:FormatText(var_242_19.content)

				arg_239_1.text_.text = var_242_20

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_21 = 21
				local var_242_22 = utf8.len(var_242_20)
				local var_242_23 = var_242_21 <= 0 and var_242_17 or var_242_17 * (var_242_22 / var_242_21)

				if var_242_23 > 0 and var_242_17 < var_242_23 then
					arg_239_1.talkMaxDuration = var_242_23

					if var_242_23 + var_242_16 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_23 + var_242_16
					end
				end

				arg_239_1.text_.text = var_242_20
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101104", "1101104061", "story_v_side_new_1101104.awb") ~= 0 then
					local var_242_24 = manager.audio:GetVoiceLength("story_v_side_new_1101104", "1101104061", "story_v_side_new_1101104.awb") / 1000

					if var_242_24 + var_242_16 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_24 + var_242_16
					end

					if var_242_19.prefab_name ~= "" and arg_239_1.actors_[var_242_19.prefab_name] ~= nil then
						local var_242_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_239_1.actors_[var_242_19.prefab_name].transform, "story_v_side_new_1101104", "1101104061", "story_v_side_new_1101104.awb")

						arg_239_1:RecordAudio("1101104061", var_242_25)
						arg_239_1:RecordAudio("1101104061", var_242_25)
					else
						arg_239_1:AudioAction("play", "voice", "story_v_side_new_1101104", "1101104061", "story_v_side_new_1101104.awb")
					end

					arg_239_1:RecordHistoryTalkVoice("story_v_side_new_1101104", "1101104061", "story_v_side_new_1101104.awb")
				end

				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_26 = math.max(var_242_17, arg_239_1.talkMaxDuration)

			if var_242_16 <= arg_239_1.time_ and arg_239_1.time_ < var_242_16 + var_242_26 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_16) / var_242_26

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_16 + var_242_26 and arg_239_1.time_ < var_242_16 + var_242_26 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "111101ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_239_1:InitPlayNodeList()
	end,
	Play1101104062 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 1101104062
		arg_243_1.duration_ = 5

		SetActive(arg_243_1.tipsGo_, false)

		function arg_243_1.onSingleLineFinish_()
			arg_243_1.onSingleLineUpdate_ = nil
			arg_243_1.onSingleLineFinish_ = nil
			arg_243_1.state_ = "waiting"
		end

		function arg_243_1.playNext_(arg_245_0)
			if arg_245_0 == 1 then
				arg_243_0:Play1101104063(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			local var_246_0 = arg_243_1.actors_["111101ui_story"]
			local var_246_1 = 0

			if var_246_1 < arg_243_1.time_ and arg_243_1.time_ <= var_246_1 + arg_246_0 and not isNil(var_246_0) and arg_243_1.var_.characterEffect111101ui_story == nil then
				arg_243_1.var_.characterEffect111101ui_story = var_246_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_246_2 = 0.200000002980232

			if var_246_1 <= arg_243_1.time_ and arg_243_1.time_ < var_246_1 + var_246_2 and not isNil(var_246_0) then
				local var_246_3 = (arg_243_1.time_ - var_246_1) / var_246_2

				if arg_243_1.var_.characterEffect111101ui_story and not isNil(var_246_0) then
					local var_246_4 = Mathf.Lerp(0, 0.5, var_246_3)

					arg_243_1.var_.characterEffect111101ui_story.fillFlat = true
					arg_243_1.var_.characterEffect111101ui_story.fillRatio = var_246_4
				end
			end

			if arg_243_1.time_ >= var_246_1 + var_246_2 and arg_243_1.time_ < var_246_1 + var_246_2 + arg_246_0 and not isNil(var_246_0) and arg_243_1.var_.characterEffect111101ui_story then
				local var_246_5 = 0.5

				arg_243_1.var_.characterEffect111101ui_story.fillFlat = true
				arg_243_1.var_.characterEffect111101ui_story.fillRatio = var_246_5
			end

			local var_246_6 = 0
			local var_246_7 = 0.55

			if var_246_6 < arg_243_1.time_ and arg_243_1.time_ <= var_246_6 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				local var_246_8 = arg_243_1:FormatText(StoryNameCfg[7].name)

				arg_243_1.leftNameTxt_.text = var_246_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, true)
				arg_243_1.iconController_:SetSelectedState("hero")

				arg_243_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_243_1.callingController_:SetSelectedState("normal")

				arg_243_1.keyicon_.color = Color.New(1, 1, 1)
				arg_243_1.icon_.color = Color.New(1, 1, 1)

				local var_246_9 = arg_243_1:GetWordFromCfg(1101104062)
				local var_246_10 = arg_243_1:FormatText(var_246_9.content)

				arg_243_1.text_.text = var_246_10

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_11 = 22
				local var_246_12 = utf8.len(var_246_10)
				local var_246_13 = var_246_11 <= 0 and var_246_7 or var_246_7 * (var_246_12 / var_246_11)

				if var_246_13 > 0 and var_246_7 < var_246_13 then
					arg_243_1.talkMaxDuration = var_246_13

					if var_246_13 + var_246_6 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_13 + var_246_6
					end
				end

				arg_243_1.text_.text = var_246_10
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)
				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_14 = math.max(var_246_7, arg_243_1.talkMaxDuration)

			if var_246_6 <= arg_243_1.time_ and arg_243_1.time_ < var_246_6 + var_246_14 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_6) / var_246_14

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_6 + var_246_14 and arg_243_1.time_ < var_246_6 + var_246_14 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {}

		arg_243_1:InitPlayNodeList()
	end,
	Play1101104063 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 1101104063
		arg_247_1.duration_ = 5.57

		local var_247_0 = {
			zh = 5.066,
			ja = 5.566
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
				arg_247_0:Play1101104064(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			local var_250_0 = arg_247_1.actors_["111101ui_story"].transform
			local var_250_1 = 0

			if var_250_1 < arg_247_1.time_ and arg_247_1.time_ <= var_250_1 + arg_250_0 then
				arg_247_1.var_.moveOldPos111101ui_story = var_250_0.localPosition
			end

			local var_250_2 = 0.001

			if var_250_1 <= arg_247_1.time_ and arg_247_1.time_ < var_250_1 + var_250_2 then
				local var_250_3 = (arg_247_1.time_ - var_250_1) / var_250_2
				local var_250_4 = Vector3.New(0, -0.83, -6)

				var_250_0.localPosition = Vector3.Lerp(arg_247_1.var_.moveOldPos111101ui_story, var_250_4, var_250_3)

				local var_250_5 = manager.ui.mainCamera.transform.position - var_250_0.position

				var_250_0.forward = Vector3.New(var_250_5.x, var_250_5.y, var_250_5.z)

				local var_250_6 = var_250_0.localEulerAngles

				var_250_6.z = 0
				var_250_6.x = 0
				var_250_0.localEulerAngles = var_250_6
			end

			if arg_247_1.time_ >= var_250_1 + var_250_2 and arg_247_1.time_ < var_250_1 + var_250_2 + arg_250_0 then
				var_250_0.localPosition = Vector3.New(0, -0.83, -6)

				local var_250_7 = manager.ui.mainCamera.transform.position - var_250_0.position

				var_250_0.forward = Vector3.New(var_250_7.x, var_250_7.y, var_250_7.z)

				local var_250_8 = var_250_0.localEulerAngles

				var_250_8.z = 0
				var_250_8.x = 0
				var_250_0.localEulerAngles = var_250_8
			end

			local var_250_9 = arg_247_1.actors_["111101ui_story"]
			local var_250_10 = 0

			if var_250_10 < arg_247_1.time_ and arg_247_1.time_ <= var_250_10 + arg_250_0 and not isNil(var_250_9) and arg_247_1.var_.characterEffect111101ui_story == nil then
				arg_247_1.var_.characterEffect111101ui_story = var_250_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_250_11 = 0.200000002980232

			if var_250_10 <= arg_247_1.time_ and arg_247_1.time_ < var_250_10 + var_250_11 and not isNil(var_250_9) then
				local var_250_12 = (arg_247_1.time_ - var_250_10) / var_250_11

				if arg_247_1.var_.characterEffect111101ui_story and not isNil(var_250_9) then
					arg_247_1.var_.characterEffect111101ui_story.fillFlat = false
				end
			end

			if arg_247_1.time_ >= var_250_10 + var_250_11 and arg_247_1.time_ < var_250_10 + var_250_11 + arg_250_0 and not isNil(var_250_9) and arg_247_1.var_.characterEffect111101ui_story then
				arg_247_1.var_.characterEffect111101ui_story.fillFlat = false
			end

			local var_250_13 = 0

			if var_250_13 < arg_247_1.time_ and arg_247_1.time_ <= var_250_13 + arg_250_0 then
				arg_247_1:PlayTimeline("111101ui_story", "StoryTimeline/CharAction/story1111/story1111actionlink/1111action448")
			end

			local var_250_14 = 0

			if var_250_14 < arg_247_1.time_ and arg_247_1.time_ <= var_250_14 + arg_250_0 then
				arg_247_1:PlayTimeline("111101ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_250_15 = 0
			local var_250_16 = 0.65

			if var_250_15 < arg_247_1.time_ and arg_247_1.time_ <= var_250_15 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				local var_250_17 = arg_247_1:FormatText(StoryNameCfg[67].name)

				arg_247_1.leftNameTxt_.text = var_250_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_18 = arg_247_1:GetWordFromCfg(1101104063)
				local var_250_19 = arg_247_1:FormatText(var_250_18.content)

				arg_247_1.text_.text = var_250_19

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_20 = 26
				local var_250_21 = utf8.len(var_250_19)
				local var_250_22 = var_250_20 <= 0 and var_250_16 or var_250_16 * (var_250_21 / var_250_20)

				if var_250_22 > 0 and var_250_16 < var_250_22 then
					arg_247_1.talkMaxDuration = var_250_22

					if var_250_22 + var_250_15 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_22 + var_250_15
					end
				end

				arg_247_1.text_.text = var_250_19
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101104", "1101104063", "story_v_side_new_1101104.awb") ~= 0 then
					local var_250_23 = manager.audio:GetVoiceLength("story_v_side_new_1101104", "1101104063", "story_v_side_new_1101104.awb") / 1000

					if var_250_23 + var_250_15 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_23 + var_250_15
					end

					if var_250_18.prefab_name ~= "" and arg_247_1.actors_[var_250_18.prefab_name] ~= nil then
						local var_250_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_247_1.actors_[var_250_18.prefab_name].transform, "story_v_side_new_1101104", "1101104063", "story_v_side_new_1101104.awb")

						arg_247_1:RecordAudio("1101104063", var_250_24)
						arg_247_1:RecordAudio("1101104063", var_250_24)
					else
						arg_247_1:AudioAction("play", "voice", "story_v_side_new_1101104", "1101104063", "story_v_side_new_1101104.awb")
					end

					arg_247_1:RecordHistoryTalkVoice("story_v_side_new_1101104", "1101104063", "story_v_side_new_1101104.awb")
				end

				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_25 = math.max(var_250_16, arg_247_1.talkMaxDuration)

			if var_250_15 <= arg_247_1.time_ and arg_247_1.time_ < var_250_15 + var_250_25 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_15) / var_250_25

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_15 + var_250_25 and arg_247_1.time_ < var_250_15 + var_250_25 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "111101ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_247_1:InitPlayNodeList()
	end,
	Play1101104064 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 1101104064
		arg_251_1.duration_ = 5

		SetActive(arg_251_1.tipsGo_, false)

		function arg_251_1.onSingleLineFinish_()
			arg_251_1.onSingleLineUpdate_ = nil
			arg_251_1.onSingleLineFinish_ = nil
			arg_251_1.state_ = "waiting"
		end

		function arg_251_1.playNext_(arg_253_0)
			if arg_253_0 == 1 then
				arg_251_0:Play1101104065(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			local var_254_0 = arg_251_1.actors_["111101ui_story"]
			local var_254_1 = 0

			if var_254_1 < arg_251_1.time_ and arg_251_1.time_ <= var_254_1 + arg_254_0 and not isNil(var_254_0) and arg_251_1.var_.characterEffect111101ui_story == nil then
				arg_251_1.var_.characterEffect111101ui_story = var_254_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_254_2 = 0.200000002980232

			if var_254_1 <= arg_251_1.time_ and arg_251_1.time_ < var_254_1 + var_254_2 and not isNil(var_254_0) then
				local var_254_3 = (arg_251_1.time_ - var_254_1) / var_254_2

				if arg_251_1.var_.characterEffect111101ui_story and not isNil(var_254_0) then
					local var_254_4 = Mathf.Lerp(0, 0.5, var_254_3)

					arg_251_1.var_.characterEffect111101ui_story.fillFlat = true
					arg_251_1.var_.characterEffect111101ui_story.fillRatio = var_254_4
				end
			end

			if arg_251_1.time_ >= var_254_1 + var_254_2 and arg_251_1.time_ < var_254_1 + var_254_2 + arg_254_0 and not isNil(var_254_0) and arg_251_1.var_.characterEffect111101ui_story then
				local var_254_5 = 0.5

				arg_251_1.var_.characterEffect111101ui_story.fillFlat = true
				arg_251_1.var_.characterEffect111101ui_story.fillRatio = var_254_5
			end

			local var_254_6 = 0
			local var_254_7 = 0.525

			if var_254_6 < arg_251_1.time_ and arg_251_1.time_ <= var_254_6 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				local var_254_8 = arg_251_1:FormatText(StoryNameCfg[7].name)

				arg_251_1.leftNameTxt_.text = var_254_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, true)
				arg_251_1.iconController_:SetSelectedState("hero")

				arg_251_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_251_1.callingController_:SetSelectedState("normal")

				arg_251_1.keyicon_.color = Color.New(1, 1, 1)
				arg_251_1.icon_.color = Color.New(1, 1, 1)

				local var_254_9 = arg_251_1:GetWordFromCfg(1101104064)
				local var_254_10 = arg_251_1:FormatText(var_254_9.content)

				arg_251_1.text_.text = var_254_10

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_11 = 21
				local var_254_12 = utf8.len(var_254_10)
				local var_254_13 = var_254_11 <= 0 and var_254_7 or var_254_7 * (var_254_12 / var_254_11)

				if var_254_13 > 0 and var_254_7 < var_254_13 then
					arg_251_1.talkMaxDuration = var_254_13

					if var_254_13 + var_254_6 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_13 + var_254_6
					end
				end

				arg_251_1.text_.text = var_254_10
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)
				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_14 = math.max(var_254_7, arg_251_1.talkMaxDuration)

			if var_254_6 <= arg_251_1.time_ and arg_251_1.time_ < var_254_6 + var_254_14 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_6) / var_254_14

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_6 + var_254_14 and arg_251_1.time_ < var_254_6 + var_254_14 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {}

		arg_251_1:InitPlayNodeList()
	end,
	Play1101104065 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 1101104065
		arg_255_1.duration_ = 4.33

		local var_255_0 = {
			zh = 3.933,
			ja = 4.333
		}
		local var_255_1 = manager.audio:GetLocalizationFlag()

		if var_255_0[var_255_1] ~= nil then
			arg_255_1.duration_ = var_255_0[var_255_1]
		end

		SetActive(arg_255_1.tipsGo_, false)

		function arg_255_1.onSingleLineFinish_()
			arg_255_1.onSingleLineUpdate_ = nil
			arg_255_1.onSingleLineFinish_ = nil
			arg_255_1.state_ = "waiting"
		end

		function arg_255_1.playNext_(arg_257_0)
			if arg_257_0 == 1 then
				arg_255_0:Play1101104066(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			local var_258_0 = arg_255_1.actors_["111101ui_story"].transform
			local var_258_1 = 0

			if var_258_1 < arg_255_1.time_ and arg_255_1.time_ <= var_258_1 + arg_258_0 then
				arg_255_1.var_.moveOldPos111101ui_story = var_258_0.localPosition
			end

			local var_258_2 = 0.001

			if var_258_1 <= arg_255_1.time_ and arg_255_1.time_ < var_258_1 + var_258_2 then
				local var_258_3 = (arg_255_1.time_ - var_258_1) / var_258_2
				local var_258_4 = Vector3.New(0, -0.83, -6)

				var_258_0.localPosition = Vector3.Lerp(arg_255_1.var_.moveOldPos111101ui_story, var_258_4, var_258_3)

				local var_258_5 = manager.ui.mainCamera.transform.position - var_258_0.position

				var_258_0.forward = Vector3.New(var_258_5.x, var_258_5.y, var_258_5.z)

				local var_258_6 = var_258_0.localEulerAngles

				var_258_6.z = 0
				var_258_6.x = 0
				var_258_0.localEulerAngles = var_258_6
			end

			if arg_255_1.time_ >= var_258_1 + var_258_2 and arg_255_1.time_ < var_258_1 + var_258_2 + arg_258_0 then
				var_258_0.localPosition = Vector3.New(0, -0.83, -6)

				local var_258_7 = manager.ui.mainCamera.transform.position - var_258_0.position

				var_258_0.forward = Vector3.New(var_258_7.x, var_258_7.y, var_258_7.z)

				local var_258_8 = var_258_0.localEulerAngles

				var_258_8.z = 0
				var_258_8.x = 0
				var_258_0.localEulerAngles = var_258_8
			end

			local var_258_9 = arg_255_1.actors_["111101ui_story"]
			local var_258_10 = 0

			if var_258_10 < arg_255_1.time_ and arg_255_1.time_ <= var_258_10 + arg_258_0 and not isNil(var_258_9) and arg_255_1.var_.characterEffect111101ui_story == nil then
				arg_255_1.var_.characterEffect111101ui_story = var_258_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_258_11 = 0.200000002980232

			if var_258_10 <= arg_255_1.time_ and arg_255_1.time_ < var_258_10 + var_258_11 and not isNil(var_258_9) then
				local var_258_12 = (arg_255_1.time_ - var_258_10) / var_258_11

				if arg_255_1.var_.characterEffect111101ui_story and not isNil(var_258_9) then
					arg_255_1.var_.characterEffect111101ui_story.fillFlat = false
				end
			end

			if arg_255_1.time_ >= var_258_10 + var_258_11 and arg_255_1.time_ < var_258_10 + var_258_11 + arg_258_0 and not isNil(var_258_9) and arg_255_1.var_.characterEffect111101ui_story then
				arg_255_1.var_.characterEffect111101ui_story.fillFlat = false
			end

			local var_258_13 = 0

			if var_258_13 < arg_255_1.time_ and arg_255_1.time_ <= var_258_13 + arg_258_0 then
				arg_255_1:PlayTimeline("111101ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action8_2")
			end

			local var_258_14 = 0
			local var_258_15 = 0.45

			if var_258_14 < arg_255_1.time_ and arg_255_1.time_ <= var_258_14 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, true)

				local var_258_16 = arg_255_1:FormatText(StoryNameCfg[67].name)

				arg_255_1.leftNameTxt_.text = var_258_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_255_1.leftNameTxt_.transform)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1.leftNameTxt_.text)
				SetActive(arg_255_1.iconTrs_.gameObject, false)
				arg_255_1.callingController_:SetSelectedState("normal")

				local var_258_17 = arg_255_1:GetWordFromCfg(1101104065)
				local var_258_18 = arg_255_1:FormatText(var_258_17.content)

				arg_255_1.text_.text = var_258_18

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_19 = 18
				local var_258_20 = utf8.len(var_258_18)
				local var_258_21 = var_258_19 <= 0 and var_258_15 or var_258_15 * (var_258_20 / var_258_19)

				if var_258_21 > 0 and var_258_15 < var_258_21 then
					arg_255_1.talkMaxDuration = var_258_21

					if var_258_21 + var_258_14 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_21 + var_258_14
					end
				end

				arg_255_1.text_.text = var_258_18
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101104", "1101104065", "story_v_side_new_1101104.awb") ~= 0 then
					local var_258_22 = manager.audio:GetVoiceLength("story_v_side_new_1101104", "1101104065", "story_v_side_new_1101104.awb") / 1000

					if var_258_22 + var_258_14 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_22 + var_258_14
					end

					if var_258_17.prefab_name ~= "" and arg_255_1.actors_[var_258_17.prefab_name] ~= nil then
						local var_258_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_255_1.actors_[var_258_17.prefab_name].transform, "story_v_side_new_1101104", "1101104065", "story_v_side_new_1101104.awb")

						arg_255_1:RecordAudio("1101104065", var_258_23)
						arg_255_1:RecordAudio("1101104065", var_258_23)
					else
						arg_255_1:AudioAction("play", "voice", "story_v_side_new_1101104", "1101104065", "story_v_side_new_1101104.awb")
					end

					arg_255_1:RecordHistoryTalkVoice("story_v_side_new_1101104", "1101104065", "story_v_side_new_1101104.awb")
				end

				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_24 = math.max(var_258_15, arg_255_1.talkMaxDuration)

			if var_258_14 <= arg_255_1.time_ and arg_255_1.time_ < var_258_14 + var_258_24 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - var_258_14) / var_258_24

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= var_258_14 + var_258_24 and arg_255_1.time_ < var_258_14 + var_258_24 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "111101ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_255_1:InitPlayNodeList()
	end,
	Play1101104066 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 1101104066
		arg_259_1.duration_ = 5

		SetActive(arg_259_1.tipsGo_, false)

		function arg_259_1.onSingleLineFinish_()
			arg_259_1.onSingleLineUpdate_ = nil
			arg_259_1.onSingleLineFinish_ = nil
			arg_259_1.state_ = "waiting"
		end

		function arg_259_1.playNext_(arg_261_0)
			if arg_261_0 == 1 then
				arg_259_0:Play1101104067(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			local var_262_0 = arg_259_1.actors_["111101ui_story"]
			local var_262_1 = 0

			if var_262_1 < arg_259_1.time_ and arg_259_1.time_ <= var_262_1 + arg_262_0 and not isNil(var_262_0) and arg_259_1.var_.characterEffect111101ui_story == nil then
				arg_259_1.var_.characterEffect111101ui_story = var_262_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_262_2 = 0.200000002980232

			if var_262_1 <= arg_259_1.time_ and arg_259_1.time_ < var_262_1 + var_262_2 and not isNil(var_262_0) then
				local var_262_3 = (arg_259_1.time_ - var_262_1) / var_262_2

				if arg_259_1.var_.characterEffect111101ui_story and not isNil(var_262_0) then
					local var_262_4 = Mathf.Lerp(0, 0.5, var_262_3)

					arg_259_1.var_.characterEffect111101ui_story.fillFlat = true
					arg_259_1.var_.characterEffect111101ui_story.fillRatio = var_262_4
				end
			end

			if arg_259_1.time_ >= var_262_1 + var_262_2 and arg_259_1.time_ < var_262_1 + var_262_2 + arg_262_0 and not isNil(var_262_0) and arg_259_1.var_.characterEffect111101ui_story then
				local var_262_5 = 0.5

				arg_259_1.var_.characterEffect111101ui_story.fillFlat = true
				arg_259_1.var_.characterEffect111101ui_story.fillRatio = var_262_5
			end

			local var_262_6 = 0
			local var_262_7 = 0.725

			if var_262_6 < arg_259_1.time_ and arg_259_1.time_ <= var_262_6 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, false)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_259_1.iconTrs_.gameObject, false)
				arg_259_1.callingController_:SetSelectedState("normal")

				local var_262_8 = arg_259_1:GetWordFromCfg(1101104066)
				local var_262_9 = arg_259_1:FormatText(var_262_8.content)

				arg_259_1.text_.text = var_262_9

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_10 = 29
				local var_262_11 = utf8.len(var_262_9)
				local var_262_12 = var_262_10 <= 0 and var_262_7 or var_262_7 * (var_262_11 / var_262_10)

				if var_262_12 > 0 and var_262_7 < var_262_12 then
					arg_259_1.talkMaxDuration = var_262_12

					if var_262_12 + var_262_6 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_12 + var_262_6
					end
				end

				arg_259_1.text_.text = var_262_9
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)
				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_13 = math.max(var_262_7, arg_259_1.talkMaxDuration)

			if var_262_6 <= arg_259_1.time_ and arg_259_1.time_ < var_262_6 + var_262_13 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - var_262_6) / var_262_13

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= var_262_6 + var_262_13 and arg_259_1.time_ < var_262_6 + var_262_13 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {}

		arg_259_1:InitPlayNodeList()
	end,
	Play1101104067 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 1101104067
		arg_263_1.duration_ = 5

		SetActive(arg_263_1.tipsGo_, false)

		function arg_263_1.onSingleLineFinish_()
			arg_263_1.onSingleLineUpdate_ = nil
			arg_263_1.onSingleLineFinish_ = nil
			arg_263_1.state_ = "waiting"
		end

		function arg_263_1.playNext_(arg_265_0)
			if arg_265_0 == 1 then
				arg_263_0:Play1101104068(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			local var_266_0 = 0
			local var_266_1 = 0.35

			if var_266_0 < arg_263_1.time_ and arg_263_1.time_ <= var_266_0 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, false)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_263_1.iconTrs_.gameObject, false)
				arg_263_1.callingController_:SetSelectedState("normal")

				local var_266_2 = arg_263_1:GetWordFromCfg(1101104067)
				local var_266_3 = arg_263_1:FormatText(var_266_2.content)

				arg_263_1.text_.text = var_266_3

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_4 = 14
				local var_266_5 = utf8.len(var_266_3)
				local var_266_6 = var_266_4 <= 0 and var_266_1 or var_266_1 * (var_266_5 / var_266_4)

				if var_266_6 > 0 and var_266_1 < var_266_6 then
					arg_263_1.talkMaxDuration = var_266_6

					if var_266_6 + var_266_0 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_6 + var_266_0
					end
				end

				arg_263_1.text_.text = var_266_3
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)
				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_7 = math.max(var_266_1, arg_263_1.talkMaxDuration)

			if var_266_0 <= arg_263_1.time_ and arg_263_1.time_ < var_266_0 + var_266_7 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - var_266_0) / var_266_7

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= var_266_0 + var_266_7 and arg_263_1.time_ < var_266_0 + var_266_7 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {}

		arg_263_1:InitPlayNodeList()
	end,
	Play1101104068 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 1101104068
		arg_267_1.duration_ = 4.4

		SetActive(arg_267_1.tipsGo_, false)

		function arg_267_1.onSingleLineFinish_()
			arg_267_1.onSingleLineUpdate_ = nil
			arg_267_1.onSingleLineFinish_ = nil
			arg_267_1.state_ = "waiting"
		end

		function arg_267_1.playNext_(arg_269_0)
			if arg_269_0 == 1 then
				arg_267_0:Play1101104069(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			local var_270_0 = 2

			if var_270_0 < arg_267_1.time_ and arg_267_1.time_ <= var_270_0 + arg_270_0 then
				arg_267_1.fswbg_:SetActive(true)
				arg_267_1.dialog_:SetActive(false)

				arg_267_1.fswtw_.percent = 0

				local var_270_1 = arg_267_1:GetWordFromCfg(1101104068)
				local var_270_2 = arg_267_1:FormatText(var_270_1.content)

				arg_267_1.fswt_.text = var_270_2

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.fswt_)

				arg_267_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_267_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_267_1.fswtw_:SetDirty()

				arg_267_1.typewritterCharCountI18N = 0

				SetActive(arg_267_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_267_1:ShowNextGo(false)
			end

			local var_270_3 = 4

			if var_270_3 < arg_267_1.time_ and arg_267_1.time_ <= var_270_3 + arg_270_0 then
				arg_267_1.var_.oldValueTypewriter = arg_267_1.fswtw_.percent

				SetActive(arg_267_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_267_1:ShowNextGo(false)
			end

			local var_270_4 = 6
			local var_270_5 = 0.4
			local var_270_6 = arg_267_1:GetWordFromCfg(1101104068)
			local var_270_7 = arg_267_1:FormatText(var_270_6.content)
			local var_270_8, var_270_9 = arg_267_1:GetPercentByPara(var_270_7, 1)

			if var_270_3 < arg_267_1.time_ and arg_267_1.time_ <= var_270_3 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0

				local var_270_10 = var_270_4 <= 0 and var_270_5 or var_270_5 * ((var_270_9 - arg_267_1.typewritterCharCountI18N) / var_270_4)

				if var_270_10 > 0 and var_270_5 < var_270_10 then
					arg_267_1.talkMaxDuration = var_270_10

					if var_270_10 + var_270_3 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_10 + var_270_3
					end
				end
			end

			local var_270_11 = 0.4
			local var_270_12 = math.max(var_270_11, arg_267_1.talkMaxDuration)

			if var_270_3 <= arg_267_1.time_ and arg_267_1.time_ < var_270_3 + var_270_12 then
				local var_270_13 = (arg_267_1.time_ - var_270_3) / var_270_12

				arg_267_1.fswtw_.percent = Mathf.Lerp(arg_267_1.var_.oldValueTypewriter, var_270_8, var_270_13)
				arg_267_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_267_1.fswtw_:SetDirty()
			end

			if arg_267_1.time_ >= var_270_3 + var_270_12 and arg_267_1.time_ < var_270_3 + var_270_12 + arg_270_0 then
				arg_267_1.fswtw_.percent = var_270_8

				arg_267_1.fswtw_:SetDirty()
				arg_267_1:ShowNextGo(true)

				arg_267_1.typewritterCharCountI18N = var_270_9
			end

			local var_270_14 = arg_267_1.actors_["111101ui_story"].transform
			local var_270_15 = 2

			if var_270_15 < arg_267_1.time_ and arg_267_1.time_ <= var_270_15 + arg_270_0 then
				arg_267_1.var_.moveOldPos111101ui_story = var_270_14.localPosition
			end

			local var_270_16 = 0.001

			if var_270_15 <= arg_267_1.time_ and arg_267_1.time_ < var_270_15 + var_270_16 then
				local var_270_17 = (arg_267_1.time_ - var_270_15) / var_270_16
				local var_270_18 = Vector3.New(0, 100, 0)

				var_270_14.localPosition = Vector3.Lerp(arg_267_1.var_.moveOldPos111101ui_story, var_270_18, var_270_17)

				local var_270_19 = manager.ui.mainCamera.transform.position - var_270_14.position

				var_270_14.forward = Vector3.New(var_270_19.x, var_270_19.y, var_270_19.z)

				local var_270_20 = var_270_14.localEulerAngles

				var_270_20.z = 0
				var_270_20.x = 0
				var_270_14.localEulerAngles = var_270_20
			end

			if arg_267_1.time_ >= var_270_15 + var_270_16 and arg_267_1.time_ < var_270_15 + var_270_16 + arg_270_0 then
				var_270_14.localPosition = Vector3.New(0, 100, 0)

				local var_270_21 = manager.ui.mainCamera.transform.position - var_270_14.position

				var_270_14.forward = Vector3.New(var_270_21.x, var_270_21.y, var_270_21.z)

				local var_270_22 = var_270_14.localEulerAngles

				var_270_22.z = 0
				var_270_22.x = 0
				var_270_14.localEulerAngles = var_270_22
			end

			local var_270_23 = 2

			if var_270_23 < arg_267_1.time_ and arg_267_1.time_ <= var_270_23 + arg_270_0 then
				local var_270_24 = arg_267_1.fswbg_.transform:Find("textbox/adapt/content") or arg_267_1.fswbg_.transform:Find("textbox/content")
				local var_270_25 = arg_267_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_270_26 = var_270_24:GetComponent("Text")
				local var_270_27 = var_270_24:GetComponent("RectTransform")

				var_270_26.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_270_27.offsetMin = Vector2.New(0, 0)
				var_270_27.offsetMax = Vector2.New(0, 0)
			end

			local var_270_28 = 0

			if var_270_28 < arg_267_1.time_ and arg_267_1.time_ <= var_270_28 + arg_270_0 then
				arg_267_1.mask_.enabled = true
				arg_267_1.mask_.raycastTarget = true

				arg_267_1:SetGaussion(false)
			end

			local var_270_29 = 2

			if var_270_28 <= arg_267_1.time_ and arg_267_1.time_ < var_270_28 + var_270_29 then
				local var_270_30 = (arg_267_1.time_ - var_270_28) / var_270_29
				local var_270_31 = Color.New(0, 0, 0)

				var_270_31.a = Mathf.Lerp(0, 1, var_270_30)
				arg_267_1.mask_.color = var_270_31
			end

			if arg_267_1.time_ >= var_270_28 + var_270_29 and arg_267_1.time_ < var_270_28 + var_270_29 + arg_270_0 then
				local var_270_32 = Color.New(0, 0, 0)

				var_270_32.a = 1
				arg_267_1.mask_.color = var_270_32
			end

			local var_270_33 = 2

			if var_270_33 < arg_267_1.time_ and arg_267_1.time_ <= var_270_33 + arg_270_0 then
				arg_267_1.mask_.enabled = true
				arg_267_1.mask_.raycastTarget = true

				arg_267_1:SetGaussion(false)
			end

			local var_270_34 = 2

			if var_270_33 <= arg_267_1.time_ and arg_267_1.time_ < var_270_33 + var_270_34 then
				local var_270_35 = (arg_267_1.time_ - var_270_33) / var_270_34
				local var_270_36 = Color.New(0, 0, 0)

				var_270_36.a = Mathf.Lerp(1, 0, var_270_35)
				arg_267_1.mask_.color = var_270_36
			end

			if arg_267_1.time_ >= var_270_33 + var_270_34 and arg_267_1.time_ < var_270_33 + var_270_34 + arg_270_0 then
				local var_270_37 = Color.New(0, 0, 0)
				local var_270_38 = 0

				arg_267_1.mask_.enabled = false
				var_270_37.a = var_270_38
				arg_267_1.mask_.color = var_270_37
			end
		end

		arg_267_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "111101ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_267_1:InitPlayNodeList()
	end,
	Play1101104069 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 1101104069
		arg_271_1.duration_ = 9

		SetActive(arg_271_1.tipsGo_, false)

		function arg_271_1.onSingleLineFinish_()
			arg_271_1.onSingleLineUpdate_ = nil
			arg_271_1.onSingleLineFinish_ = nil
			arg_271_1.state_ = "waiting"
		end

		function arg_271_1.playNext_(arg_273_0)
			if arg_273_0 == 1 then
				arg_271_0:Play1101104070(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			local var_274_0 = "ST13"

			if arg_271_1.bgs_[var_274_0] == nil then
				local var_274_1 = Object.Instantiate(arg_271_1.paintGo_)

				var_274_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_274_0)
				var_274_1.name = var_274_0
				var_274_1.transform.parent = arg_271_1.stage_.transform
				var_274_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_271_1.bgs_[var_274_0] = var_274_1
			end

			local var_274_2 = 2

			if var_274_2 < arg_271_1.time_ and arg_271_1.time_ <= var_274_2 + arg_274_0 then
				local var_274_3 = manager.ui.mainCamera.transform.localPosition
				local var_274_4 = Vector3.New(0, 0, 10) + Vector3.New(var_274_3.x, var_274_3.y, 0)
				local var_274_5 = arg_271_1.bgs_.ST13

				var_274_5.transform.localPosition = var_274_4
				var_274_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_274_6 = var_274_5:GetComponent("SpriteRenderer")

				if var_274_6 and var_274_6.sprite then
					local var_274_7 = (var_274_5.transform.localPosition - var_274_3).z
					local var_274_8 = manager.ui.mainCameraCom_
					local var_274_9 = 2 * var_274_7 * Mathf.Tan(var_274_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_274_10 = var_274_9 * var_274_8.aspect
					local var_274_11 = var_274_6.sprite.bounds.size.x
					local var_274_12 = var_274_6.sprite.bounds.size.y
					local var_274_13 = var_274_10 / var_274_11
					local var_274_14 = var_274_9 / var_274_12
					local var_274_15 = var_274_14 < var_274_13 and var_274_13 or var_274_14

					var_274_5.transform.localScale = Vector3.New(var_274_15, var_274_15, 0)
				end

				for iter_274_0, iter_274_1 in pairs(arg_271_1.bgs_) do
					if iter_274_0 ~= "ST13" then
						iter_274_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_274_16 = 0

			if var_274_16 < arg_271_1.time_ and arg_271_1.time_ <= var_274_16 + arg_274_0 then
				arg_271_1.mask_.enabled = true
				arg_271_1.mask_.raycastTarget = true

				arg_271_1:SetGaussion(false)
			end

			local var_274_17 = 2

			if var_274_16 <= arg_271_1.time_ and arg_271_1.time_ < var_274_16 + var_274_17 then
				local var_274_18 = (arg_271_1.time_ - var_274_16) / var_274_17
				local var_274_19 = Color.New(0, 0, 0)

				var_274_19.a = Mathf.Lerp(0, 1, var_274_18)
				arg_271_1.mask_.color = var_274_19
			end

			if arg_271_1.time_ >= var_274_16 + var_274_17 and arg_271_1.time_ < var_274_16 + var_274_17 + arg_274_0 then
				local var_274_20 = Color.New(0, 0, 0)

				var_274_20.a = 1
				arg_271_1.mask_.color = var_274_20
			end

			local var_274_21 = 2

			if var_274_21 < arg_271_1.time_ and arg_271_1.time_ <= var_274_21 + arg_274_0 then
				arg_271_1.mask_.enabled = true
				arg_271_1.mask_.raycastTarget = true

				arg_271_1:SetGaussion(false)
			end

			local var_274_22 = 2

			if var_274_21 <= arg_271_1.time_ and arg_271_1.time_ < var_274_21 + var_274_22 then
				local var_274_23 = (arg_271_1.time_ - var_274_21) / var_274_22
				local var_274_24 = Color.New(0, 0, 0)

				var_274_24.a = Mathf.Lerp(1, 0, var_274_23)
				arg_271_1.mask_.color = var_274_24
			end

			if arg_271_1.time_ >= var_274_21 + var_274_22 and arg_271_1.time_ < var_274_21 + var_274_22 + arg_274_0 then
				local var_274_25 = Color.New(0, 0, 0)
				local var_274_26 = 0

				arg_271_1.mask_.enabled = false
				var_274_25.a = var_274_26
				arg_271_1.mask_.color = var_274_25
			end

			local var_274_27 = 2

			if var_274_27 < arg_271_1.time_ and arg_271_1.time_ <= var_274_27 + arg_274_0 then
				arg_271_1.fswbg_:SetActive(false)
				arg_271_1.dialog_:SetActive(false)
				SetActive(arg_271_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_271_1:ShowNextGo(false)
			end

			if arg_271_1.frameCnt_ <= 1 then
				arg_271_1.dialog_:SetActive(false)
			end

			local var_274_28 = 4
			local var_274_29 = 0.875

			if var_274_28 < arg_271_1.time_ and arg_271_1.time_ <= var_274_28 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0

				arg_271_1.dialog_:SetActive(true)

				arg_271_1.dialogCg_.alpha = 0

				local var_274_30 = LeanTween.value(arg_271_1.dialog_, 0, 1, 0.3)

				var_274_30:setOnUpdate(LuaHelper.FloatAction(function(arg_275_0)
					arg_271_1.dialogCg_.alpha = arg_275_0
				end))
				var_274_30:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_271_1.dialog_)
					var_274_30:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_271_1.duration_ = arg_271_1.duration_ + 0.3

				SetActive(arg_271_1.leftNameGo_, true)

				local var_274_31 = arg_271_1:FormatText(StoryNameCfg[7].name)

				arg_271_1.leftNameTxt_.text = var_274_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_271_1.leftNameTxt_.transform)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1.leftNameTxt_.text)
				SetActive(arg_271_1.iconTrs_.gameObject, true)
				arg_271_1.iconController_:SetSelectedState("hero")

				arg_271_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_271_1.callingController_:SetSelectedState("normal")

				arg_271_1.keyicon_.color = Color.New(1, 1, 1)
				arg_271_1.icon_.color = Color.New(1, 1, 1)

				local var_274_32 = arg_271_1:GetWordFromCfg(1101104069)
				local var_274_33 = arg_271_1:FormatText(var_274_32.content)

				arg_271_1.text_.text = var_274_33

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_34 = 35
				local var_274_35 = utf8.len(var_274_33)
				local var_274_36 = var_274_34 <= 0 and var_274_29 or var_274_29 * (var_274_35 / var_274_34)

				if var_274_36 > 0 and var_274_29 < var_274_36 then
					arg_271_1.talkMaxDuration = var_274_36
					var_274_28 = var_274_28 + 0.3

					if var_274_36 + var_274_28 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_36 + var_274_28
					end
				end

				arg_271_1.text_.text = var_274_33
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)
				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_37 = var_274_28 + 0.3
			local var_274_38 = math.max(var_274_29, arg_271_1.talkMaxDuration)

			if var_274_37 <= arg_271_1.time_ and arg_271_1.time_ < var_274_37 + var_274_38 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - var_274_37) / var_274_38

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= var_274_37 + var_274_38 and arg_271_1.time_ < var_274_37 + var_274_38 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {}

		arg_271_1:InitPlayNodeList()
	end,
	Play1101104070 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 1101104070
		arg_277_1.duration_ = 6.47

		local var_277_0 = {
			zh = 4.7,
			ja = 6.466
		}
		local var_277_1 = manager.audio:GetLocalizationFlag()

		if var_277_0[var_277_1] ~= nil then
			arg_277_1.duration_ = var_277_0[var_277_1]
		end

		SetActive(arg_277_1.tipsGo_, false)

		function arg_277_1.onSingleLineFinish_()
			arg_277_1.onSingleLineUpdate_ = nil
			arg_277_1.onSingleLineFinish_ = nil
			arg_277_1.state_ = "waiting"
		end

		function arg_277_1.playNext_(arg_279_0)
			if arg_279_0 == 1 then
				arg_277_0:Play1101104071(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			local var_280_0 = arg_277_1.actors_["111101ui_story"].transform
			local var_280_1 = 0

			if var_280_1 < arg_277_1.time_ and arg_277_1.time_ <= var_280_1 + arg_280_0 then
				arg_277_1.var_.moveOldPos111101ui_story = var_280_0.localPosition
			end

			local var_280_2 = 0.001

			if var_280_1 <= arg_277_1.time_ and arg_277_1.time_ < var_280_1 + var_280_2 then
				local var_280_3 = (arg_277_1.time_ - var_280_1) / var_280_2
				local var_280_4 = Vector3.New(0, -0.83, -6)

				var_280_0.localPosition = Vector3.Lerp(arg_277_1.var_.moveOldPos111101ui_story, var_280_4, var_280_3)

				local var_280_5 = manager.ui.mainCamera.transform.position - var_280_0.position

				var_280_0.forward = Vector3.New(var_280_5.x, var_280_5.y, var_280_5.z)

				local var_280_6 = var_280_0.localEulerAngles

				var_280_6.z = 0
				var_280_6.x = 0
				var_280_0.localEulerAngles = var_280_6
			end

			if arg_277_1.time_ >= var_280_1 + var_280_2 and arg_277_1.time_ < var_280_1 + var_280_2 + arg_280_0 then
				var_280_0.localPosition = Vector3.New(0, -0.83, -6)

				local var_280_7 = manager.ui.mainCamera.transform.position - var_280_0.position

				var_280_0.forward = Vector3.New(var_280_7.x, var_280_7.y, var_280_7.z)

				local var_280_8 = var_280_0.localEulerAngles

				var_280_8.z = 0
				var_280_8.x = 0
				var_280_0.localEulerAngles = var_280_8
			end

			local var_280_9 = arg_277_1.actors_["111101ui_story"]
			local var_280_10 = 0

			if var_280_10 < arg_277_1.time_ and arg_277_1.time_ <= var_280_10 + arg_280_0 and not isNil(var_280_9) and arg_277_1.var_.characterEffect111101ui_story == nil then
				arg_277_1.var_.characterEffect111101ui_story = var_280_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_280_11 = 0.200000002980232

			if var_280_10 <= arg_277_1.time_ and arg_277_1.time_ < var_280_10 + var_280_11 and not isNil(var_280_9) then
				local var_280_12 = (arg_277_1.time_ - var_280_10) / var_280_11

				if arg_277_1.var_.characterEffect111101ui_story and not isNil(var_280_9) then
					arg_277_1.var_.characterEffect111101ui_story.fillFlat = false
				end
			end

			if arg_277_1.time_ >= var_280_10 + var_280_11 and arg_277_1.time_ < var_280_10 + var_280_11 + arg_280_0 and not isNil(var_280_9) and arg_277_1.var_.characterEffect111101ui_story then
				arg_277_1.var_.characterEffect111101ui_story.fillFlat = false
			end

			local var_280_13 = 0

			if var_280_13 < arg_277_1.time_ and arg_277_1.time_ <= var_280_13 + arg_280_0 then
				arg_277_1:PlayTimeline("111101ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action3_1")
			end

			local var_280_14 = 0

			if var_280_14 < arg_277_1.time_ and arg_277_1.time_ <= var_280_14 + arg_280_0 then
				arg_277_1:PlayTimeline("111101ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_280_15 = 0
			local var_280_16 = 0.475

			if var_280_15 < arg_277_1.time_ and arg_277_1.time_ <= var_280_15 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				local var_280_17 = arg_277_1:FormatText(StoryNameCfg[67].name)

				arg_277_1.leftNameTxt_.text = var_280_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_18 = arg_277_1:GetWordFromCfg(1101104070)
				local var_280_19 = arg_277_1:FormatText(var_280_18.content)

				arg_277_1.text_.text = var_280_19

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_20 = 19
				local var_280_21 = utf8.len(var_280_19)
				local var_280_22 = var_280_20 <= 0 and var_280_16 or var_280_16 * (var_280_21 / var_280_20)

				if var_280_22 > 0 and var_280_16 < var_280_22 then
					arg_277_1.talkMaxDuration = var_280_22

					if var_280_22 + var_280_15 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_22 + var_280_15
					end
				end

				arg_277_1.text_.text = var_280_19
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101104", "1101104070", "story_v_side_new_1101104.awb") ~= 0 then
					local var_280_23 = manager.audio:GetVoiceLength("story_v_side_new_1101104", "1101104070", "story_v_side_new_1101104.awb") / 1000

					if var_280_23 + var_280_15 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_23 + var_280_15
					end

					if var_280_18.prefab_name ~= "" and arg_277_1.actors_[var_280_18.prefab_name] ~= nil then
						local var_280_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_277_1.actors_[var_280_18.prefab_name].transform, "story_v_side_new_1101104", "1101104070", "story_v_side_new_1101104.awb")

						arg_277_1:RecordAudio("1101104070", var_280_24)
						arg_277_1:RecordAudio("1101104070", var_280_24)
					else
						arg_277_1:AudioAction("play", "voice", "story_v_side_new_1101104", "1101104070", "story_v_side_new_1101104.awb")
					end

					arg_277_1:RecordHistoryTalkVoice("story_v_side_new_1101104", "1101104070", "story_v_side_new_1101104.awb")
				end

				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_25 = math.max(var_280_16, arg_277_1.talkMaxDuration)

			if var_280_15 <= arg_277_1.time_ and arg_277_1.time_ < var_280_15 + var_280_25 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_15) / var_280_25

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_15 + var_280_25 and arg_277_1.time_ < var_280_15 + var_280_25 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "111101ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_277_1:InitPlayNodeList()
	end,
	Play1101104071 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 1101104071
		arg_281_1.duration_ = 5

		SetActive(arg_281_1.tipsGo_, false)

		function arg_281_1.onSingleLineFinish_()
			arg_281_1.onSingleLineUpdate_ = nil
			arg_281_1.onSingleLineFinish_ = nil
			arg_281_1.state_ = "waiting"
		end

		function arg_281_1.playNext_(arg_283_0)
			if arg_283_0 == 1 then
				arg_281_0:Play1101104072(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			local var_284_0 = arg_281_1.actors_["111101ui_story"].transform
			local var_284_1 = 0

			if var_284_1 < arg_281_1.time_ and arg_281_1.time_ <= var_284_1 + arg_284_0 then
				arg_281_1.var_.moveOldPos111101ui_story = var_284_0.localPosition
			end

			local var_284_2 = 0.001

			if var_284_1 <= arg_281_1.time_ and arg_281_1.time_ < var_284_1 + var_284_2 then
				local var_284_3 = (arg_281_1.time_ - var_284_1) / var_284_2
				local var_284_4 = Vector3.New(0, 100, 0)

				var_284_0.localPosition = Vector3.Lerp(arg_281_1.var_.moveOldPos111101ui_story, var_284_4, var_284_3)

				local var_284_5 = manager.ui.mainCamera.transform.position - var_284_0.position

				var_284_0.forward = Vector3.New(var_284_5.x, var_284_5.y, var_284_5.z)

				local var_284_6 = var_284_0.localEulerAngles

				var_284_6.z = 0
				var_284_6.x = 0
				var_284_0.localEulerAngles = var_284_6
			end

			if arg_281_1.time_ >= var_284_1 + var_284_2 and arg_281_1.time_ < var_284_1 + var_284_2 + arg_284_0 then
				var_284_0.localPosition = Vector3.New(0, 100, 0)

				local var_284_7 = manager.ui.mainCamera.transform.position - var_284_0.position

				var_284_0.forward = Vector3.New(var_284_7.x, var_284_7.y, var_284_7.z)

				local var_284_8 = var_284_0.localEulerAngles

				var_284_8.z = 0
				var_284_8.x = 0
				var_284_0.localEulerAngles = var_284_8
			end

			local var_284_9 = 0
			local var_284_10 = 0.175

			if var_284_9 < arg_281_1.time_ and arg_281_1.time_ <= var_284_9 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, false)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_11 = arg_281_1:GetWordFromCfg(1101104071)
				local var_284_12 = arg_281_1:FormatText(var_284_11.content)

				arg_281_1.text_.text = var_284_12

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_13 = 7
				local var_284_14 = utf8.len(var_284_12)
				local var_284_15 = var_284_13 <= 0 and var_284_10 or var_284_10 * (var_284_14 / var_284_13)

				if var_284_15 > 0 and var_284_10 < var_284_15 then
					arg_281_1.talkMaxDuration = var_284_15

					if var_284_15 + var_284_9 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_15 + var_284_9
					end
				end

				arg_281_1.text_.text = var_284_12
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)
				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_16 = math.max(var_284_10, arg_281_1.talkMaxDuration)

			if var_284_9 <= arg_281_1.time_ and arg_281_1.time_ < var_284_9 + var_284_16 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_9) / var_284_16

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_9 + var_284_16 and arg_281_1.time_ < var_284_9 + var_284_16 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "111101ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_281_1:InitPlayNodeList()
	end,
	Play1101104072 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 1101104072
		arg_285_1.duration_ = 5

		SetActive(arg_285_1.tipsGo_, false)

		function arg_285_1.onSingleLineFinish_()
			arg_285_1.onSingleLineUpdate_ = nil
			arg_285_1.onSingleLineFinish_ = nil
			arg_285_1.state_ = "waiting"
		end

		function arg_285_1.playNext_(arg_287_0)
			if arg_287_0 == 1 then
				arg_285_0:Play1101104073(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			local var_288_0 = 0
			local var_288_1 = 0.525

			if var_288_0 < arg_285_1.time_ and arg_285_1.time_ <= var_288_0 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, false)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_285_1.iconTrs_.gameObject, false)
				arg_285_1.callingController_:SetSelectedState("normal")

				local var_288_2 = arg_285_1:GetWordFromCfg(1101104072)
				local var_288_3 = arg_285_1:FormatText(var_288_2.content)

				arg_285_1.text_.text = var_288_3

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_4 = 21
				local var_288_5 = utf8.len(var_288_3)
				local var_288_6 = var_288_4 <= 0 and var_288_1 or var_288_1 * (var_288_5 / var_288_4)

				if var_288_6 > 0 and var_288_1 < var_288_6 then
					arg_285_1.talkMaxDuration = var_288_6

					if var_288_6 + var_288_0 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_6 + var_288_0
					end
				end

				arg_285_1.text_.text = var_288_3
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)
				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_7 = math.max(var_288_1, arg_285_1.talkMaxDuration)

			if var_288_0 <= arg_285_1.time_ and arg_285_1.time_ < var_288_0 + var_288_7 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_0) / var_288_7

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_0 + var_288_7 and arg_285_1.time_ < var_288_0 + var_288_7 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {}

		arg_285_1:InitPlayNodeList()
	end,
	Play1101104073 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 1101104073
		arg_289_1.duration_ = 5

		SetActive(arg_289_1.tipsGo_, false)

		function arg_289_1.onSingleLineFinish_()
			arg_289_1.onSingleLineUpdate_ = nil
			arg_289_1.onSingleLineFinish_ = nil
			arg_289_1.state_ = "waiting"
		end

		function arg_289_1.playNext_(arg_291_0)
			if arg_291_0 == 1 then
				arg_289_0:Play1101104074(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			local var_292_0 = 0
			local var_292_1 = 0.225

			if var_292_0 < arg_289_1.time_ and arg_289_1.time_ <= var_292_0 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, true)

				local var_292_2 = arg_289_1:FormatText(StoryNameCfg[7].name)

				arg_289_1.leftNameTxt_.text = var_292_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, true)
				arg_289_1.iconController_:SetSelectedState("hero")

				arg_289_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_289_1.callingController_:SetSelectedState("normal")

				arg_289_1.keyicon_.color = Color.New(1, 1, 1)
				arg_289_1.icon_.color = Color.New(1, 1, 1)

				local var_292_3 = arg_289_1:GetWordFromCfg(1101104073)
				local var_292_4 = arg_289_1:FormatText(var_292_3.content)

				arg_289_1.text_.text = var_292_4

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_5 = 9
				local var_292_6 = utf8.len(var_292_4)
				local var_292_7 = var_292_5 <= 0 and var_292_1 or var_292_1 * (var_292_6 / var_292_5)

				if var_292_7 > 0 and var_292_1 < var_292_7 then
					arg_289_1.talkMaxDuration = var_292_7

					if var_292_7 + var_292_0 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_7 + var_292_0
					end
				end

				arg_289_1.text_.text = var_292_4
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)
				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_8 = math.max(var_292_1, arg_289_1.talkMaxDuration)

			if var_292_0 <= arg_289_1.time_ and arg_289_1.time_ < var_292_0 + var_292_8 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - var_292_0) / var_292_8

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= var_292_0 + var_292_8 and arg_289_1.time_ < var_292_0 + var_292_8 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {}

		arg_289_1:InitPlayNodeList()
	end,
	Play1101104074 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 1101104074
		arg_293_1.duration_ = 2.37

		local var_293_0 = {
			zh = 1.999999999999,
			ja = 2.366
		}
		local var_293_1 = manager.audio:GetLocalizationFlag()

		if var_293_0[var_293_1] ~= nil then
			arg_293_1.duration_ = var_293_0[var_293_1]
		end

		SetActive(arg_293_1.tipsGo_, false)

		function arg_293_1.onSingleLineFinish_()
			arg_293_1.onSingleLineUpdate_ = nil
			arg_293_1.onSingleLineFinish_ = nil
			arg_293_1.state_ = "waiting"
		end

		function arg_293_1.playNext_(arg_295_0)
			if arg_295_0 == 1 then
				arg_293_0:Play1101104075(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			local var_296_0 = arg_293_1.actors_["111101ui_story"].transform
			local var_296_1 = 0

			if var_296_1 < arg_293_1.time_ and arg_293_1.time_ <= var_296_1 + arg_296_0 then
				arg_293_1.var_.moveOldPos111101ui_story = var_296_0.localPosition
			end

			local var_296_2 = 0.001

			if var_296_1 <= arg_293_1.time_ and arg_293_1.time_ < var_296_1 + var_296_2 then
				local var_296_3 = (arg_293_1.time_ - var_296_1) / var_296_2
				local var_296_4 = Vector3.New(0, -0.83, -6)

				var_296_0.localPosition = Vector3.Lerp(arg_293_1.var_.moveOldPos111101ui_story, var_296_4, var_296_3)

				local var_296_5 = manager.ui.mainCamera.transform.position - var_296_0.position

				var_296_0.forward = Vector3.New(var_296_5.x, var_296_5.y, var_296_5.z)

				local var_296_6 = var_296_0.localEulerAngles

				var_296_6.z = 0
				var_296_6.x = 0
				var_296_0.localEulerAngles = var_296_6
			end

			if arg_293_1.time_ >= var_296_1 + var_296_2 and arg_293_1.time_ < var_296_1 + var_296_2 + arg_296_0 then
				var_296_0.localPosition = Vector3.New(0, -0.83, -6)

				local var_296_7 = manager.ui.mainCamera.transform.position - var_296_0.position

				var_296_0.forward = Vector3.New(var_296_7.x, var_296_7.y, var_296_7.z)

				local var_296_8 = var_296_0.localEulerAngles

				var_296_8.z = 0
				var_296_8.x = 0
				var_296_0.localEulerAngles = var_296_8
			end

			local var_296_9 = arg_293_1.actors_["111101ui_story"]
			local var_296_10 = 0

			if var_296_10 < arg_293_1.time_ and arg_293_1.time_ <= var_296_10 + arg_296_0 and not isNil(var_296_9) and arg_293_1.var_.characterEffect111101ui_story == nil then
				arg_293_1.var_.characterEffect111101ui_story = var_296_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_296_11 = 0.200000002980232

			if var_296_10 <= arg_293_1.time_ and arg_293_1.time_ < var_296_10 + var_296_11 and not isNil(var_296_9) then
				local var_296_12 = (arg_293_1.time_ - var_296_10) / var_296_11

				if arg_293_1.var_.characterEffect111101ui_story and not isNil(var_296_9) then
					arg_293_1.var_.characterEffect111101ui_story.fillFlat = false
				end
			end

			if arg_293_1.time_ >= var_296_10 + var_296_11 and arg_293_1.time_ < var_296_10 + var_296_11 + arg_296_0 and not isNil(var_296_9) and arg_293_1.var_.characterEffect111101ui_story then
				arg_293_1.var_.characterEffect111101ui_story.fillFlat = false
			end

			local var_296_13 = 0

			if var_296_13 < arg_293_1.time_ and arg_293_1.time_ <= var_296_13 + arg_296_0 then
				arg_293_1:PlayTimeline("111101ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action8_1")
			end

			local var_296_14 = 0

			if var_296_14 < arg_293_1.time_ and arg_293_1.time_ <= var_296_14 + arg_296_0 then
				arg_293_1:PlayTimeline("111101ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1302cva")
			end

			local var_296_15 = 0
			local var_296_16 = 0.3

			if var_296_15 < arg_293_1.time_ and arg_293_1.time_ <= var_296_15 + arg_296_0 then
				local var_296_17 = "play"
				local var_296_18 = "music"

				arg_293_1:AudioAction(var_296_17, var_296_18, "ui_battle", "ui_battle_stopbgm", "")

				local var_296_19 = ""
				local var_296_20 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_296_20 ~= "" then
					if arg_293_1.bgmTxt_.text ~= var_296_20 and arg_293_1.bgmTxt_.text ~= "" then
						if arg_293_1.bgmTxt2_.text ~= "" then
							arg_293_1.bgmTxt_.text = arg_293_1.bgmTxt2_.text
						end

						arg_293_1.bgmTxt2_.text = var_296_20

						arg_293_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_293_1.bgmTxt_.text = var_296_20
						arg_293_1.bgmTxt2_.text = var_296_20
					end

					if arg_293_1.bgmTimer then
						arg_293_1.bgmTimer:Stop()

						arg_293_1.bgmTimer = nil
					end

					if arg_293_1.settingData.show_music_name == 1 then
						arg_293_1.musicController:SetSelectedState("show")
						arg_293_1.musicAnimator_:Play("open", 0, 0)

						if arg_293_1.settingData.music_time ~= 0 then
							arg_293_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_293_1.settingData.music_time), function()
								if arg_293_1 == nil or isNil(arg_293_1.bgmTxt_) then
									return
								end

								arg_293_1.musicController:SetSelectedState("hide")
								arg_293_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_296_21 = 0
			local var_296_22 = 0.125

			if var_296_21 < arg_293_1.time_ and arg_293_1.time_ <= var_296_21 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, true)

				local var_296_23 = arg_293_1:FormatText(StoryNameCfg[67].name)

				arg_293_1.leftNameTxt_.text = var_296_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_293_1.leftNameTxt_.transform)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1.leftNameTxt_.text)
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_24 = arg_293_1:GetWordFromCfg(1101104074)
				local var_296_25 = arg_293_1:FormatText(var_296_24.content)

				arg_293_1.text_.text = var_296_25

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_26 = 5
				local var_296_27 = utf8.len(var_296_25)
				local var_296_28 = var_296_26 <= 0 and var_296_22 or var_296_22 * (var_296_27 / var_296_26)

				if var_296_28 > 0 and var_296_22 < var_296_28 then
					arg_293_1.talkMaxDuration = var_296_28

					if var_296_28 + var_296_21 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_28 + var_296_21
					end
				end

				arg_293_1.text_.text = var_296_25
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101104", "1101104074", "story_v_side_new_1101104.awb") ~= 0 then
					local var_296_29 = manager.audio:GetVoiceLength("story_v_side_new_1101104", "1101104074", "story_v_side_new_1101104.awb") / 1000

					if var_296_29 + var_296_21 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_29 + var_296_21
					end

					if var_296_24.prefab_name ~= "" and arg_293_1.actors_[var_296_24.prefab_name] ~= nil then
						local var_296_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_293_1.actors_[var_296_24.prefab_name].transform, "story_v_side_new_1101104", "1101104074", "story_v_side_new_1101104.awb")

						arg_293_1:RecordAudio("1101104074", var_296_30)
						arg_293_1:RecordAudio("1101104074", var_296_30)
					else
						arg_293_1:AudioAction("play", "voice", "story_v_side_new_1101104", "1101104074", "story_v_side_new_1101104.awb")
					end

					arg_293_1:RecordHistoryTalkVoice("story_v_side_new_1101104", "1101104074", "story_v_side_new_1101104.awb")
				end

				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_31 = math.max(var_296_22, arg_293_1.talkMaxDuration)

			if var_296_21 <= arg_293_1.time_ and arg_293_1.time_ < var_296_21 + var_296_31 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_21) / var_296_31

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_21 + var_296_31 and arg_293_1.time_ < var_296_21 + var_296_31 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "111101ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_293_1:InitPlayNodeList()
	end,
	Play1101104075 = function(arg_298_0, arg_298_1)
		arg_298_1.time_ = 0
		arg_298_1.frameCnt_ = 0
		arg_298_1.state_ = "playing"
		arg_298_1.curTalkId_ = 1101104075
		arg_298_1.duration_ = 5

		SetActive(arg_298_1.tipsGo_, false)

		function arg_298_1.onSingleLineFinish_()
			arg_298_1.onSingleLineUpdate_ = nil
			arg_298_1.onSingleLineFinish_ = nil
			arg_298_1.state_ = "waiting"
		end

		function arg_298_1.playNext_(arg_300_0)
			if arg_300_0 == 1 then
				arg_298_0:Play1101104076(arg_298_1)
			end
		end

		function arg_298_1.onSingleLineUpdate_(arg_301_0)
			local var_301_0 = arg_298_1.actors_["111101ui_story"]
			local var_301_1 = 0

			if var_301_1 < arg_298_1.time_ and arg_298_1.time_ <= var_301_1 + arg_301_0 and not isNil(var_301_0) and arg_298_1.var_.characterEffect111101ui_story == nil then
				arg_298_1.var_.characterEffect111101ui_story = var_301_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_301_2 = 0.200000002980232

			if var_301_1 <= arg_298_1.time_ and arg_298_1.time_ < var_301_1 + var_301_2 and not isNil(var_301_0) then
				local var_301_3 = (arg_298_1.time_ - var_301_1) / var_301_2

				if arg_298_1.var_.characterEffect111101ui_story and not isNil(var_301_0) then
					local var_301_4 = Mathf.Lerp(0, 0.5, var_301_3)

					arg_298_1.var_.characterEffect111101ui_story.fillFlat = true
					arg_298_1.var_.characterEffect111101ui_story.fillRatio = var_301_4
				end
			end

			if arg_298_1.time_ >= var_301_1 + var_301_2 and arg_298_1.time_ < var_301_1 + var_301_2 + arg_301_0 and not isNil(var_301_0) and arg_298_1.var_.characterEffect111101ui_story then
				local var_301_5 = 0.5

				arg_298_1.var_.characterEffect111101ui_story.fillFlat = true
				arg_298_1.var_.characterEffect111101ui_story.fillRatio = var_301_5
			end

			local var_301_6 = 0
			local var_301_7 = 0.725

			if var_301_6 < arg_298_1.time_ and arg_298_1.time_ <= var_301_6 + arg_301_0 then
				arg_298_1.talkMaxDuration = 0
				arg_298_1.dialogCg_.alpha = 1

				arg_298_1.dialog_:SetActive(true)
				SetActive(arg_298_1.leftNameGo_, false)

				arg_298_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_298_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_298_1:RecordName(arg_298_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_298_1.iconTrs_.gameObject, false)
				arg_298_1.callingController_:SetSelectedState("normal")

				local var_301_8 = arg_298_1:GetWordFromCfg(1101104075)
				local var_301_9 = arg_298_1:FormatText(var_301_8.content)

				arg_298_1.text_.text = var_301_9

				LuaForUtil.ClearLinePrefixSymbol(arg_298_1.text_)

				local var_301_10 = 29
				local var_301_11 = utf8.len(var_301_9)
				local var_301_12 = var_301_10 <= 0 and var_301_7 or var_301_7 * (var_301_11 / var_301_10)

				if var_301_12 > 0 and var_301_7 < var_301_12 then
					arg_298_1.talkMaxDuration = var_301_12

					if var_301_12 + var_301_6 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_12 + var_301_6
					end
				end

				arg_298_1.text_.text = var_301_9
				arg_298_1.typewritter.percent = 0

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(false)
				arg_298_1:RecordContent(arg_298_1.text_.text)
			end

			local var_301_13 = math.max(var_301_7, arg_298_1.talkMaxDuration)

			if var_301_6 <= arg_298_1.time_ and arg_298_1.time_ < var_301_6 + var_301_13 then
				arg_298_1.typewritter.percent = (arg_298_1.time_ - var_301_6) / var_301_13

				arg_298_1.typewritter:SetDirty()
			end

			if arg_298_1.time_ >= var_301_6 + var_301_13 and arg_298_1.time_ < var_301_6 + var_301_13 + arg_301_0 then
				arg_298_1.typewritter.percent = 1

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(true)
			end
		end

		arg_298_1.nodeConfigList_ = {}

		arg_298_1:InitPlayNodeList()
	end,
	Play1101104076 = function(arg_302_0, arg_302_1)
		arg_302_1.time_ = 0
		arg_302_1.frameCnt_ = 0
		arg_302_1.state_ = "playing"
		arg_302_1.curTalkId_ = 1101104076
		arg_302_1.duration_ = 5

		SetActive(arg_302_1.tipsGo_, false)

		function arg_302_1.onSingleLineFinish_()
			arg_302_1.onSingleLineUpdate_ = nil
			arg_302_1.onSingleLineFinish_ = nil
			arg_302_1.state_ = "waiting"
		end

		function arg_302_1.playNext_(arg_304_0)
			if arg_304_0 == 1 then
				arg_302_0:Play1101104077(arg_302_1)
			end
		end

		function arg_302_1.onSingleLineUpdate_(arg_305_0)
			local var_305_0 = 0
			local var_305_1 = 0.375

			if var_305_0 < arg_302_1.time_ and arg_302_1.time_ <= var_305_0 + arg_305_0 then
				arg_302_1.talkMaxDuration = 0
				arg_302_1.dialogCg_.alpha = 1

				arg_302_1.dialog_:SetActive(true)
				SetActive(arg_302_1.leftNameGo_, true)

				local var_305_2 = arg_302_1:FormatText(StoryNameCfg[7].name)

				arg_302_1.leftNameTxt_.text = var_305_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_302_1.leftNameTxt_.transform)

				arg_302_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_302_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_302_1:RecordName(arg_302_1.leftNameTxt_.text)
				SetActive(arg_302_1.iconTrs_.gameObject, true)
				arg_302_1.iconController_:SetSelectedState("hero")

				arg_302_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_302_1.callingController_:SetSelectedState("normal")

				arg_302_1.keyicon_.color = Color.New(1, 1, 1)
				arg_302_1.icon_.color = Color.New(1, 1, 1)

				local var_305_3 = arg_302_1:GetWordFromCfg(1101104076)
				local var_305_4 = arg_302_1:FormatText(var_305_3.content)

				arg_302_1.text_.text = var_305_4

				LuaForUtil.ClearLinePrefixSymbol(arg_302_1.text_)

				local var_305_5 = 15
				local var_305_6 = utf8.len(var_305_4)
				local var_305_7 = var_305_5 <= 0 and var_305_1 or var_305_1 * (var_305_6 / var_305_5)

				if var_305_7 > 0 and var_305_1 < var_305_7 then
					arg_302_1.talkMaxDuration = var_305_7

					if var_305_7 + var_305_0 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_7 + var_305_0
					end
				end

				arg_302_1.text_.text = var_305_4
				arg_302_1.typewritter.percent = 0

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(false)
				arg_302_1:RecordContent(arg_302_1.text_.text)
			end

			local var_305_8 = math.max(var_305_1, arg_302_1.talkMaxDuration)

			if var_305_0 <= arg_302_1.time_ and arg_302_1.time_ < var_305_0 + var_305_8 then
				arg_302_1.typewritter.percent = (arg_302_1.time_ - var_305_0) / var_305_8

				arg_302_1.typewritter:SetDirty()
			end

			if arg_302_1.time_ >= var_305_0 + var_305_8 and arg_302_1.time_ < var_305_0 + var_305_8 + arg_305_0 then
				arg_302_1.typewritter.percent = 1

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(true)
			end
		end

		arg_302_1.nodeConfigList_ = {}

		arg_302_1:InitPlayNodeList()
	end,
	Play1101104077 = function(arg_306_0, arg_306_1)
		arg_306_1.time_ = 0
		arg_306_1.frameCnt_ = 0
		arg_306_1.state_ = "playing"
		arg_306_1.curTalkId_ = 1101104077
		arg_306_1.duration_ = 5

		SetActive(arg_306_1.tipsGo_, false)

		function arg_306_1.onSingleLineFinish_()
			arg_306_1.onSingleLineUpdate_ = nil
			arg_306_1.onSingleLineFinish_ = nil
			arg_306_1.state_ = "waiting"
		end

		function arg_306_1.playNext_(arg_308_0)
			if arg_308_0 == 1 then
				arg_306_0:Play1101104078(arg_306_1)
			end
		end

		function arg_306_1.onSingleLineUpdate_(arg_309_0)
			local var_309_0 = 0
			local var_309_1 = 0.825

			if var_309_0 < arg_306_1.time_ and arg_306_1.time_ <= var_309_0 + arg_309_0 then
				arg_306_1.talkMaxDuration = 0
				arg_306_1.dialogCg_.alpha = 1

				arg_306_1.dialog_:SetActive(true)
				SetActive(arg_306_1.leftNameGo_, false)

				arg_306_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_306_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_306_1:RecordName(arg_306_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_306_1.iconTrs_.gameObject, false)
				arg_306_1.callingController_:SetSelectedState("normal")

				local var_309_2 = arg_306_1:GetWordFromCfg(1101104077)
				local var_309_3 = arg_306_1:FormatText(var_309_2.content)

				arg_306_1.text_.text = var_309_3

				LuaForUtil.ClearLinePrefixSymbol(arg_306_1.text_)

				local var_309_4 = 33
				local var_309_5 = utf8.len(var_309_3)
				local var_309_6 = var_309_4 <= 0 and var_309_1 or var_309_1 * (var_309_5 / var_309_4)

				if var_309_6 > 0 and var_309_1 < var_309_6 then
					arg_306_1.talkMaxDuration = var_309_6

					if var_309_6 + var_309_0 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_6 + var_309_0
					end
				end

				arg_306_1.text_.text = var_309_3
				arg_306_1.typewritter.percent = 0

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(false)
				arg_306_1:RecordContent(arg_306_1.text_.text)
			end

			local var_309_7 = math.max(var_309_1, arg_306_1.talkMaxDuration)

			if var_309_0 <= arg_306_1.time_ and arg_306_1.time_ < var_309_0 + var_309_7 then
				arg_306_1.typewritter.percent = (arg_306_1.time_ - var_309_0) / var_309_7

				arg_306_1.typewritter:SetDirty()
			end

			if arg_306_1.time_ >= var_309_0 + var_309_7 and arg_306_1.time_ < var_309_0 + var_309_7 + arg_309_0 then
				arg_306_1.typewritter.percent = 1

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(true)
			end
		end

		arg_306_1.nodeConfigList_ = {}

		arg_306_1:InitPlayNodeList()
	end,
	Play1101104078 = function(arg_310_0, arg_310_1)
		arg_310_1.time_ = 0
		arg_310_1.frameCnt_ = 0
		arg_310_1.state_ = "playing"
		arg_310_1.curTalkId_ = 1101104078
		arg_310_1.duration_ = 12.4

		local var_310_0 = {
			zh = 10,
			ja = 12.4
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
				arg_310_0:Play1101104079(arg_310_1)
			end
		end

		function arg_310_1.onSingleLineUpdate_(arg_313_0)
			local var_313_0 = arg_310_1.actors_["111101ui_story"].transform
			local var_313_1 = 0

			if var_313_1 < arg_310_1.time_ and arg_310_1.time_ <= var_313_1 + arg_313_0 then
				arg_310_1.var_.moveOldPos111101ui_story = var_313_0.localPosition
			end

			local var_313_2 = 0.001

			if var_313_1 <= arg_310_1.time_ and arg_310_1.time_ < var_313_1 + var_313_2 then
				local var_313_3 = (arg_310_1.time_ - var_313_1) / var_313_2
				local var_313_4 = Vector3.New(0, -0.83, -6)

				var_313_0.localPosition = Vector3.Lerp(arg_310_1.var_.moveOldPos111101ui_story, var_313_4, var_313_3)

				local var_313_5 = manager.ui.mainCamera.transform.position - var_313_0.position

				var_313_0.forward = Vector3.New(var_313_5.x, var_313_5.y, var_313_5.z)

				local var_313_6 = var_313_0.localEulerAngles

				var_313_6.z = 0
				var_313_6.x = 0
				var_313_0.localEulerAngles = var_313_6
			end

			if arg_310_1.time_ >= var_313_1 + var_313_2 and arg_310_1.time_ < var_313_1 + var_313_2 + arg_313_0 then
				var_313_0.localPosition = Vector3.New(0, -0.83, -6)

				local var_313_7 = manager.ui.mainCamera.transform.position - var_313_0.position

				var_313_0.forward = Vector3.New(var_313_7.x, var_313_7.y, var_313_7.z)

				local var_313_8 = var_313_0.localEulerAngles

				var_313_8.z = 0
				var_313_8.x = 0
				var_313_0.localEulerAngles = var_313_8
			end

			local var_313_9 = arg_310_1.actors_["111101ui_story"]
			local var_313_10 = 0

			if var_313_10 < arg_310_1.time_ and arg_310_1.time_ <= var_313_10 + arg_313_0 and not isNil(var_313_9) and arg_310_1.var_.characterEffect111101ui_story == nil then
				arg_310_1.var_.characterEffect111101ui_story = var_313_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_313_11 = 0.200000002980232

			if var_313_10 <= arg_310_1.time_ and arg_310_1.time_ < var_313_10 + var_313_11 and not isNil(var_313_9) then
				local var_313_12 = (arg_310_1.time_ - var_313_10) / var_313_11

				if arg_310_1.var_.characterEffect111101ui_story and not isNil(var_313_9) then
					arg_310_1.var_.characterEffect111101ui_story.fillFlat = false
				end
			end

			if arg_310_1.time_ >= var_313_10 + var_313_11 and arg_310_1.time_ < var_313_10 + var_313_11 + arg_313_0 and not isNil(var_313_9) and arg_310_1.var_.characterEffect111101ui_story then
				arg_310_1.var_.characterEffect111101ui_story.fillFlat = false
			end

			local var_313_13 = 0

			if var_313_13 < arg_310_1.time_ and arg_310_1.time_ <= var_313_13 + arg_313_0 then
				arg_310_1:PlayTimeline("111101ui_story", "StoryTimeline/CharAction/story1111/story1111actionlink/1111action487")
			end

			local var_313_14 = 0

			if var_313_14 < arg_310_1.time_ and arg_310_1.time_ <= var_313_14 + arg_313_0 then
				arg_310_1:PlayTimeline("111101ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1302cva")
			end

			local var_313_15 = 0
			local var_313_16 = 0.95

			if var_313_15 < arg_310_1.time_ and arg_310_1.time_ <= var_313_15 + arg_313_0 then
				arg_310_1.talkMaxDuration = 0
				arg_310_1.dialogCg_.alpha = 1

				arg_310_1.dialog_:SetActive(true)
				SetActive(arg_310_1.leftNameGo_, true)

				local var_313_17 = arg_310_1:FormatText(StoryNameCfg[67].name)

				arg_310_1.leftNameTxt_.text = var_313_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_310_1.leftNameTxt_.transform)

				arg_310_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_310_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_310_1:RecordName(arg_310_1.leftNameTxt_.text)
				SetActive(arg_310_1.iconTrs_.gameObject, false)
				arg_310_1.callingController_:SetSelectedState("normal")

				local var_313_18 = arg_310_1:GetWordFromCfg(1101104078)
				local var_313_19 = arg_310_1:FormatText(var_313_18.content)

				arg_310_1.text_.text = var_313_19

				LuaForUtil.ClearLinePrefixSymbol(arg_310_1.text_)

				local var_313_20 = 38
				local var_313_21 = utf8.len(var_313_19)
				local var_313_22 = var_313_20 <= 0 and var_313_16 or var_313_16 * (var_313_21 / var_313_20)

				if var_313_22 > 0 and var_313_16 < var_313_22 then
					arg_310_1.talkMaxDuration = var_313_22

					if var_313_22 + var_313_15 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_22 + var_313_15
					end
				end

				arg_310_1.text_.text = var_313_19
				arg_310_1.typewritter.percent = 0

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101104", "1101104078", "story_v_side_new_1101104.awb") ~= 0 then
					local var_313_23 = manager.audio:GetVoiceLength("story_v_side_new_1101104", "1101104078", "story_v_side_new_1101104.awb") / 1000

					if var_313_23 + var_313_15 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_23 + var_313_15
					end

					if var_313_18.prefab_name ~= "" and arg_310_1.actors_[var_313_18.prefab_name] ~= nil then
						local var_313_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_310_1.actors_[var_313_18.prefab_name].transform, "story_v_side_new_1101104", "1101104078", "story_v_side_new_1101104.awb")

						arg_310_1:RecordAudio("1101104078", var_313_24)
						arg_310_1:RecordAudio("1101104078", var_313_24)
					else
						arg_310_1:AudioAction("play", "voice", "story_v_side_new_1101104", "1101104078", "story_v_side_new_1101104.awb")
					end

					arg_310_1:RecordHistoryTalkVoice("story_v_side_new_1101104", "1101104078", "story_v_side_new_1101104.awb")
				end

				arg_310_1:RecordContent(arg_310_1.text_.text)
			end

			local var_313_25 = math.max(var_313_16, arg_310_1.talkMaxDuration)

			if var_313_15 <= arg_310_1.time_ and arg_310_1.time_ < var_313_15 + var_313_25 then
				arg_310_1.typewritter.percent = (arg_310_1.time_ - var_313_15) / var_313_25

				arg_310_1.typewritter:SetDirty()
			end

			if arg_310_1.time_ >= var_313_15 + var_313_25 and arg_310_1.time_ < var_313_15 + var_313_25 + arg_313_0 then
				arg_310_1.typewritter.percent = 1

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(true)
			end
		end

		arg_310_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "111101ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_310_1:InitPlayNodeList()
	end,
	Play1101104079 = function(arg_314_0, arg_314_1)
		arg_314_1.time_ = 0
		arg_314_1.frameCnt_ = 0
		arg_314_1.state_ = "playing"
		arg_314_1.curTalkId_ = 1101104079
		arg_314_1.duration_ = 5

		SetActive(arg_314_1.tipsGo_, false)

		function arg_314_1.onSingleLineFinish_()
			arg_314_1.onSingleLineUpdate_ = nil
			arg_314_1.onSingleLineFinish_ = nil
			arg_314_1.state_ = "waiting"
		end

		function arg_314_1.playNext_(arg_316_0)
			if arg_316_0 == 1 then
				arg_314_0:Play1101104080(arg_314_1)
			end
		end

		function arg_314_1.onSingleLineUpdate_(arg_317_0)
			local var_317_0 = arg_314_1.actors_["111101ui_story"]
			local var_317_1 = 0

			if var_317_1 < arg_314_1.time_ and arg_314_1.time_ <= var_317_1 + arg_317_0 and not isNil(var_317_0) and arg_314_1.var_.characterEffect111101ui_story == nil then
				arg_314_1.var_.characterEffect111101ui_story = var_317_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_317_2 = 0.200000002980232

			if var_317_1 <= arg_314_1.time_ and arg_314_1.time_ < var_317_1 + var_317_2 and not isNil(var_317_0) then
				local var_317_3 = (arg_314_1.time_ - var_317_1) / var_317_2

				if arg_314_1.var_.characterEffect111101ui_story and not isNil(var_317_0) then
					local var_317_4 = Mathf.Lerp(0, 0.5, var_317_3)

					arg_314_1.var_.characterEffect111101ui_story.fillFlat = true
					arg_314_1.var_.characterEffect111101ui_story.fillRatio = var_317_4
				end
			end

			if arg_314_1.time_ >= var_317_1 + var_317_2 and arg_314_1.time_ < var_317_1 + var_317_2 + arg_317_0 and not isNil(var_317_0) and arg_314_1.var_.characterEffect111101ui_story then
				local var_317_5 = 0.5

				arg_314_1.var_.characterEffect111101ui_story.fillFlat = true
				arg_314_1.var_.characterEffect111101ui_story.fillRatio = var_317_5
			end

			local var_317_6 = 0
			local var_317_7 = 0.325

			if var_317_6 < arg_314_1.time_ and arg_314_1.time_ <= var_317_6 + arg_317_0 then
				arg_314_1.talkMaxDuration = 0
				arg_314_1.dialogCg_.alpha = 1

				arg_314_1.dialog_:SetActive(true)
				SetActive(arg_314_1.leftNameGo_, false)

				arg_314_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_314_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_314_1:RecordName(arg_314_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_314_1.iconTrs_.gameObject, false)
				arg_314_1.callingController_:SetSelectedState("normal")

				local var_317_8 = arg_314_1:GetWordFromCfg(1101104079)
				local var_317_9 = arg_314_1:FormatText(var_317_8.content)

				arg_314_1.text_.text = var_317_9

				LuaForUtil.ClearLinePrefixSymbol(arg_314_1.text_)

				local var_317_10 = 13
				local var_317_11 = utf8.len(var_317_9)
				local var_317_12 = var_317_10 <= 0 and var_317_7 or var_317_7 * (var_317_11 / var_317_10)

				if var_317_12 > 0 and var_317_7 < var_317_12 then
					arg_314_1.talkMaxDuration = var_317_12

					if var_317_12 + var_317_6 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_12 + var_317_6
					end
				end

				arg_314_1.text_.text = var_317_9
				arg_314_1.typewritter.percent = 0

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(false)
				arg_314_1:RecordContent(arg_314_1.text_.text)
			end

			local var_317_13 = math.max(var_317_7, arg_314_1.talkMaxDuration)

			if var_317_6 <= arg_314_1.time_ and arg_314_1.time_ < var_317_6 + var_317_13 then
				arg_314_1.typewritter.percent = (arg_314_1.time_ - var_317_6) / var_317_13

				arg_314_1.typewritter:SetDirty()
			end

			if arg_314_1.time_ >= var_317_6 + var_317_13 and arg_314_1.time_ < var_317_6 + var_317_13 + arg_317_0 then
				arg_314_1.typewritter.percent = 1

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(true)
			end
		end

		arg_314_1.nodeConfigList_ = {}

		arg_314_1:InitPlayNodeList()
	end,
	Play1101104080 = function(arg_318_0, arg_318_1)
		arg_318_1.time_ = 0
		arg_318_1.frameCnt_ = 0
		arg_318_1.state_ = "playing"
		arg_318_1.curTalkId_ = 1101104080
		arg_318_1.duration_ = 5

		SetActive(arg_318_1.tipsGo_, false)

		function arg_318_1.onSingleLineFinish_()
			arg_318_1.onSingleLineUpdate_ = nil
			arg_318_1.onSingleLineFinish_ = nil
			arg_318_1.state_ = "waiting"
		end

		function arg_318_1.playNext_(arg_320_0)
			if arg_320_0 == 1 then
				arg_318_0:Play1101104081(arg_318_1)
			end
		end

		function arg_318_1.onSingleLineUpdate_(arg_321_0)
			local var_321_0 = 0
			local var_321_1 = 0.05

			if var_321_0 < arg_318_1.time_ and arg_318_1.time_ <= var_321_0 + arg_321_0 then
				arg_318_1.talkMaxDuration = 0
				arg_318_1.dialogCg_.alpha = 1

				arg_318_1.dialog_:SetActive(true)
				SetActive(arg_318_1.leftNameGo_, true)

				local var_321_2 = arg_318_1:FormatText(StoryNameCfg[7].name)

				arg_318_1.leftNameTxt_.text = var_321_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_318_1.leftNameTxt_.transform)

				arg_318_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_318_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_318_1:RecordName(arg_318_1.leftNameTxt_.text)
				SetActive(arg_318_1.iconTrs_.gameObject, true)
				arg_318_1.iconController_:SetSelectedState("hero")

				arg_318_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_318_1.callingController_:SetSelectedState("normal")

				arg_318_1.keyicon_.color = Color.New(1, 1, 1)
				arg_318_1.icon_.color = Color.New(1, 1, 1)

				local var_321_3 = arg_318_1:GetWordFromCfg(1101104080)
				local var_321_4 = arg_318_1:FormatText(var_321_3.content)

				arg_318_1.text_.text = var_321_4

				LuaForUtil.ClearLinePrefixSymbol(arg_318_1.text_)

				local var_321_5 = 2
				local var_321_6 = utf8.len(var_321_4)
				local var_321_7 = var_321_5 <= 0 and var_321_1 or var_321_1 * (var_321_6 / var_321_5)

				if var_321_7 > 0 and var_321_1 < var_321_7 then
					arg_318_1.talkMaxDuration = var_321_7

					if var_321_7 + var_321_0 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_7 + var_321_0
					end
				end

				arg_318_1.text_.text = var_321_4
				arg_318_1.typewritter.percent = 0

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(false)
				arg_318_1:RecordContent(arg_318_1.text_.text)
			end

			local var_321_8 = math.max(var_321_1, arg_318_1.talkMaxDuration)

			if var_321_0 <= arg_318_1.time_ and arg_318_1.time_ < var_321_0 + var_321_8 then
				arg_318_1.typewritter.percent = (arg_318_1.time_ - var_321_0) / var_321_8

				arg_318_1.typewritter:SetDirty()
			end

			if arg_318_1.time_ >= var_321_0 + var_321_8 and arg_318_1.time_ < var_321_0 + var_321_8 + arg_321_0 then
				arg_318_1.typewritter.percent = 1

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(true)
			end
		end

		arg_318_1.nodeConfigList_ = {}

		arg_318_1:InitPlayNodeList()
	end,
	Play1101104081 = function(arg_322_0, arg_322_1)
		arg_322_1.time_ = 0
		arg_322_1.frameCnt_ = 0
		arg_322_1.state_ = "playing"
		arg_322_1.curTalkId_ = 1101104081
		arg_322_1.duration_ = 5

		SetActive(arg_322_1.tipsGo_, false)

		function arg_322_1.onSingleLineFinish_()
			arg_322_1.onSingleLineUpdate_ = nil
			arg_322_1.onSingleLineFinish_ = nil
			arg_322_1.state_ = "waiting"
		end

		function arg_322_1.playNext_(arg_324_0)
			if arg_324_0 == 1 then
				arg_322_0:Play1101104082(arg_322_1)
			end
		end

		function arg_322_1.onSingleLineUpdate_(arg_325_0)
			local var_325_0 = 0
			local var_325_1 = 0.475

			if var_325_0 < arg_322_1.time_ and arg_322_1.time_ <= var_325_0 + arg_325_0 then
				arg_322_1.talkMaxDuration = 0
				arg_322_1.dialogCg_.alpha = 1

				arg_322_1.dialog_:SetActive(true)
				SetActive(arg_322_1.leftNameGo_, false)

				arg_322_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_322_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_322_1:RecordName(arg_322_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_322_1.iconTrs_.gameObject, false)
				arg_322_1.callingController_:SetSelectedState("normal")

				local var_325_2 = arg_322_1:GetWordFromCfg(1101104081)
				local var_325_3 = arg_322_1:FormatText(var_325_2.content)

				arg_322_1.text_.text = var_325_3

				LuaForUtil.ClearLinePrefixSymbol(arg_322_1.text_)

				local var_325_4 = 19
				local var_325_5 = utf8.len(var_325_3)
				local var_325_6 = var_325_4 <= 0 and var_325_1 or var_325_1 * (var_325_5 / var_325_4)

				if var_325_6 > 0 and var_325_1 < var_325_6 then
					arg_322_1.talkMaxDuration = var_325_6

					if var_325_6 + var_325_0 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_6 + var_325_0
					end
				end

				arg_322_1.text_.text = var_325_3
				arg_322_1.typewritter.percent = 0

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(false)
				arg_322_1:RecordContent(arg_322_1.text_.text)
			end

			local var_325_7 = math.max(var_325_1, arg_322_1.talkMaxDuration)

			if var_325_0 <= arg_322_1.time_ and arg_322_1.time_ < var_325_0 + var_325_7 then
				arg_322_1.typewritter.percent = (arg_322_1.time_ - var_325_0) / var_325_7

				arg_322_1.typewritter:SetDirty()
			end

			if arg_322_1.time_ >= var_325_0 + var_325_7 and arg_322_1.time_ < var_325_0 + var_325_7 + arg_325_0 then
				arg_322_1.typewritter.percent = 1

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(true)
			end
		end

		arg_322_1.nodeConfigList_ = {}

		arg_322_1:InitPlayNodeList()
	end,
	Play1101104082 = function(arg_326_0, arg_326_1)
		arg_326_1.time_ = 0
		arg_326_1.frameCnt_ = 0
		arg_326_1.state_ = "playing"
		arg_326_1.curTalkId_ = 1101104082
		arg_326_1.duration_ = 5

		SetActive(arg_326_1.tipsGo_, false)

		function arg_326_1.onSingleLineFinish_()
			arg_326_1.onSingleLineUpdate_ = nil
			arg_326_1.onSingleLineFinish_ = nil
			arg_326_1.state_ = "waiting"
		end

		function arg_326_1.playNext_(arg_328_0)
			if arg_328_0 == 1 then
				arg_326_0:Play1101104083(arg_326_1)
			end
		end

		function arg_326_1.onSingleLineUpdate_(arg_329_0)
			local var_329_0 = arg_326_1.actors_["111101ui_story"].transform
			local var_329_1 = 0

			if var_329_1 < arg_326_1.time_ and arg_326_1.time_ <= var_329_1 + arg_329_0 then
				arg_326_1.var_.moveOldPos111101ui_story = var_329_0.localPosition
			end

			local var_329_2 = 0.001

			if var_329_1 <= arg_326_1.time_ and arg_326_1.time_ < var_329_1 + var_329_2 then
				local var_329_3 = (arg_326_1.time_ - var_329_1) / var_329_2
				local var_329_4 = Vector3.New(0, 100, 0)

				var_329_0.localPosition = Vector3.Lerp(arg_326_1.var_.moveOldPos111101ui_story, var_329_4, var_329_3)

				local var_329_5 = manager.ui.mainCamera.transform.position - var_329_0.position

				var_329_0.forward = Vector3.New(var_329_5.x, var_329_5.y, var_329_5.z)

				local var_329_6 = var_329_0.localEulerAngles

				var_329_6.z = 0
				var_329_6.x = 0
				var_329_0.localEulerAngles = var_329_6
			end

			if arg_326_1.time_ >= var_329_1 + var_329_2 and arg_326_1.time_ < var_329_1 + var_329_2 + arg_329_0 then
				var_329_0.localPosition = Vector3.New(0, 100, 0)

				local var_329_7 = manager.ui.mainCamera.transform.position - var_329_0.position

				var_329_0.forward = Vector3.New(var_329_7.x, var_329_7.y, var_329_7.z)

				local var_329_8 = var_329_0.localEulerAngles

				var_329_8.z = 0
				var_329_8.x = 0
				var_329_0.localEulerAngles = var_329_8
			end

			local var_329_9 = manager.ui.mainCamera.transform
			local var_329_10 = 0

			if var_329_10 < arg_326_1.time_ and arg_326_1.time_ <= var_329_10 + arg_329_0 then
				arg_326_1.var_.shakeOldPos = var_329_9.localPosition
			end

			local var_329_11 = 1

			if var_329_10 <= arg_326_1.time_ and arg_326_1.time_ < var_329_10 + var_329_11 then
				local var_329_12 = (arg_326_1.time_ - var_329_10) / 0.495
				local var_329_13, var_329_14 = math.modf(var_329_12)

				var_329_9.localPosition = Vector3.New(var_329_14 * 0.13, var_329_14 * 0.13, var_329_14 * 0.13) + arg_326_1.var_.shakeOldPos
			end

			if arg_326_1.time_ >= var_329_10 + var_329_11 and arg_326_1.time_ < var_329_10 + var_329_11 + arg_329_0 then
				var_329_9.localPosition = arg_326_1.var_.shakeOldPos
			end

			local var_329_15 = 0
			local var_329_16 = 0.475

			if var_329_15 < arg_326_1.time_ and arg_326_1.time_ <= var_329_15 + arg_329_0 then
				arg_326_1.talkMaxDuration = 0
				arg_326_1.dialogCg_.alpha = 1

				arg_326_1.dialog_:SetActive(true)
				SetActive(arg_326_1.leftNameGo_, false)

				arg_326_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_326_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_326_1:RecordName(arg_326_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_326_1.iconTrs_.gameObject, false)
				arg_326_1.callingController_:SetSelectedState("normal")

				local var_329_17 = arg_326_1:GetWordFromCfg(1101104082)
				local var_329_18 = arg_326_1:FormatText(var_329_17.content)

				arg_326_1.text_.text = var_329_18

				LuaForUtil.ClearLinePrefixSymbol(arg_326_1.text_)

				local var_329_19 = 19
				local var_329_20 = utf8.len(var_329_18)
				local var_329_21 = var_329_19 <= 0 and var_329_16 or var_329_16 * (var_329_20 / var_329_19)

				if var_329_21 > 0 and var_329_16 < var_329_21 then
					arg_326_1.talkMaxDuration = var_329_21

					if var_329_21 + var_329_15 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_21 + var_329_15
					end
				end

				arg_326_1.text_.text = var_329_18
				arg_326_1.typewritter.percent = 0

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(false)
				arg_326_1:RecordContent(arg_326_1.text_.text)
			end

			local var_329_22 = math.max(var_329_16, arg_326_1.talkMaxDuration)

			if var_329_15 <= arg_326_1.time_ and arg_326_1.time_ < var_329_15 + var_329_22 then
				arg_326_1.typewritter.percent = (arg_326_1.time_ - var_329_15) / var_329_22

				arg_326_1.typewritter:SetDirty()
			end

			if arg_326_1.time_ >= var_329_15 + var_329_22 and arg_326_1.time_ < var_329_15 + var_329_22 + arg_329_0 then
				arg_326_1.typewritter.percent = 1

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(true)
			end
		end

		arg_326_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "111101ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_326_1:InitPlayNodeList()
	end,
	Play1101104083 = function(arg_330_0, arg_330_1)
		arg_330_1.time_ = 0
		arg_330_1.frameCnt_ = 0
		arg_330_1.state_ = "playing"
		arg_330_1.curTalkId_ = 1101104083
		arg_330_1.duration_ = 4.2

		local var_330_0 = {
			zh = 2.533,
			ja = 4.2
		}
		local var_330_1 = manager.audio:GetLocalizationFlag()

		if var_330_0[var_330_1] ~= nil then
			arg_330_1.duration_ = var_330_0[var_330_1]
		end

		SetActive(arg_330_1.tipsGo_, false)

		function arg_330_1.onSingleLineFinish_()
			arg_330_1.onSingleLineUpdate_ = nil
			arg_330_1.onSingleLineFinish_ = nil
			arg_330_1.state_ = "waiting"
		end

		function arg_330_1.playNext_(arg_332_0)
			if arg_332_0 == 1 then
				arg_330_0:Play1101104084(arg_330_1)
			end
		end

		function arg_330_1.onSingleLineUpdate_(arg_333_0)
			local var_333_0 = arg_330_1.actors_["111101ui_story"].transform
			local var_333_1 = 0

			if var_333_1 < arg_330_1.time_ and arg_330_1.time_ <= var_333_1 + arg_333_0 then
				arg_330_1.var_.moveOldPos111101ui_story = var_333_0.localPosition
			end

			local var_333_2 = 0.001

			if var_333_1 <= arg_330_1.time_ and arg_330_1.time_ < var_333_1 + var_333_2 then
				local var_333_3 = (arg_330_1.time_ - var_333_1) / var_333_2
				local var_333_4 = Vector3.New(0, -0.83, -6)

				var_333_0.localPosition = Vector3.Lerp(arg_330_1.var_.moveOldPos111101ui_story, var_333_4, var_333_3)

				local var_333_5 = manager.ui.mainCamera.transform.position - var_333_0.position

				var_333_0.forward = Vector3.New(var_333_5.x, var_333_5.y, var_333_5.z)

				local var_333_6 = var_333_0.localEulerAngles

				var_333_6.z = 0
				var_333_6.x = 0
				var_333_0.localEulerAngles = var_333_6
			end

			if arg_330_1.time_ >= var_333_1 + var_333_2 and arg_330_1.time_ < var_333_1 + var_333_2 + arg_333_0 then
				var_333_0.localPosition = Vector3.New(0, -0.83, -6)

				local var_333_7 = manager.ui.mainCamera.transform.position - var_333_0.position

				var_333_0.forward = Vector3.New(var_333_7.x, var_333_7.y, var_333_7.z)

				local var_333_8 = var_333_0.localEulerAngles

				var_333_8.z = 0
				var_333_8.x = 0
				var_333_0.localEulerAngles = var_333_8
			end

			local var_333_9 = arg_330_1.actors_["111101ui_story"]
			local var_333_10 = 0

			if var_333_10 < arg_330_1.time_ and arg_330_1.time_ <= var_333_10 + arg_333_0 and not isNil(var_333_9) and arg_330_1.var_.characterEffect111101ui_story == nil then
				arg_330_1.var_.characterEffect111101ui_story = var_333_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_333_11 = 0.200000002980232

			if var_333_10 <= arg_330_1.time_ and arg_330_1.time_ < var_333_10 + var_333_11 and not isNil(var_333_9) then
				local var_333_12 = (arg_330_1.time_ - var_333_10) / var_333_11

				if arg_330_1.var_.characterEffect111101ui_story and not isNil(var_333_9) then
					arg_330_1.var_.characterEffect111101ui_story.fillFlat = false
				end
			end

			if arg_330_1.time_ >= var_333_10 + var_333_11 and arg_330_1.time_ < var_333_10 + var_333_11 + arg_333_0 and not isNil(var_333_9) and arg_330_1.var_.characterEffect111101ui_story then
				arg_330_1.var_.characterEffect111101ui_story.fillFlat = false
			end

			local var_333_13 = 0

			if var_333_13 < arg_330_1.time_ and arg_330_1.time_ <= var_333_13 + arg_333_0 then
				arg_330_1:PlayTimeline("111101ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action4_1")
			end

			local var_333_14 = 0

			if var_333_14 < arg_330_1.time_ and arg_330_1.time_ <= var_333_14 + arg_333_0 then
				arg_330_1:PlayTimeline("111101ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_333_15 = 0
			local var_333_16 = 0.275

			if var_333_15 < arg_330_1.time_ and arg_330_1.time_ <= var_333_15 + arg_333_0 then
				arg_330_1.talkMaxDuration = 0
				arg_330_1.dialogCg_.alpha = 1

				arg_330_1.dialog_:SetActive(true)
				SetActive(arg_330_1.leftNameGo_, true)

				local var_333_17 = arg_330_1:FormatText(StoryNameCfg[67].name)

				arg_330_1.leftNameTxt_.text = var_333_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_330_1.leftNameTxt_.transform)

				arg_330_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_330_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_330_1:RecordName(arg_330_1.leftNameTxt_.text)
				SetActive(arg_330_1.iconTrs_.gameObject, false)
				arg_330_1.callingController_:SetSelectedState("normal")

				local var_333_18 = arg_330_1:GetWordFromCfg(1101104083)
				local var_333_19 = arg_330_1:FormatText(var_333_18.content)

				arg_330_1.text_.text = var_333_19

				LuaForUtil.ClearLinePrefixSymbol(arg_330_1.text_)

				local var_333_20 = 11
				local var_333_21 = utf8.len(var_333_19)
				local var_333_22 = var_333_20 <= 0 and var_333_16 or var_333_16 * (var_333_21 / var_333_20)

				if var_333_22 > 0 and var_333_16 < var_333_22 then
					arg_330_1.talkMaxDuration = var_333_22

					if var_333_22 + var_333_15 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_22 + var_333_15
					end
				end

				arg_330_1.text_.text = var_333_19
				arg_330_1.typewritter.percent = 0

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101104", "1101104083", "story_v_side_new_1101104.awb") ~= 0 then
					local var_333_23 = manager.audio:GetVoiceLength("story_v_side_new_1101104", "1101104083", "story_v_side_new_1101104.awb") / 1000

					if var_333_23 + var_333_15 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_23 + var_333_15
					end

					if var_333_18.prefab_name ~= "" and arg_330_1.actors_[var_333_18.prefab_name] ~= nil then
						local var_333_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_330_1.actors_[var_333_18.prefab_name].transform, "story_v_side_new_1101104", "1101104083", "story_v_side_new_1101104.awb")

						arg_330_1:RecordAudio("1101104083", var_333_24)
						arg_330_1:RecordAudio("1101104083", var_333_24)
					else
						arg_330_1:AudioAction("play", "voice", "story_v_side_new_1101104", "1101104083", "story_v_side_new_1101104.awb")
					end

					arg_330_1:RecordHistoryTalkVoice("story_v_side_new_1101104", "1101104083", "story_v_side_new_1101104.awb")
				end

				arg_330_1:RecordContent(arg_330_1.text_.text)
			end

			local var_333_25 = math.max(var_333_16, arg_330_1.talkMaxDuration)

			if var_333_15 <= arg_330_1.time_ and arg_330_1.time_ < var_333_15 + var_333_25 then
				arg_330_1.typewritter.percent = (arg_330_1.time_ - var_333_15) / var_333_25

				arg_330_1.typewritter:SetDirty()
			end

			if arg_330_1.time_ >= var_333_15 + var_333_25 and arg_330_1.time_ < var_333_15 + var_333_25 + arg_333_0 then
				arg_330_1.typewritter.percent = 1

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(true)
			end
		end

		arg_330_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "111101ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_330_1:InitPlayNodeList()
	end,
	Play1101104084 = function(arg_334_0, arg_334_1)
		arg_334_1.time_ = 0
		arg_334_1.frameCnt_ = 0
		arg_334_1.state_ = "playing"
		arg_334_1.curTalkId_ = 1101104084
		arg_334_1.duration_ = 5

		SetActive(arg_334_1.tipsGo_, false)

		function arg_334_1.onSingleLineFinish_()
			arg_334_1.onSingleLineUpdate_ = nil
			arg_334_1.onSingleLineFinish_ = nil
			arg_334_1.state_ = "waiting"
		end

		function arg_334_1.playNext_(arg_336_0)
			if arg_336_0 == 1 then
				arg_334_0:Play1101104085(arg_334_1)
			end
		end

		function arg_334_1.onSingleLineUpdate_(arg_337_0)
			local var_337_0 = 0
			local var_337_1 = 0.3

			if var_337_0 < arg_334_1.time_ and arg_334_1.time_ <= var_337_0 + arg_337_0 then
				local var_337_2 = "play"
				local var_337_3 = "music"

				arg_334_1:AudioAction(var_337_2, var_337_3, "ui_battle", "ui_battle_stopbgm", "")

				local var_337_4 = ""
				local var_337_5 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_337_5 ~= "" then
					if arg_334_1.bgmTxt_.text ~= var_337_5 and arg_334_1.bgmTxt_.text ~= "" then
						if arg_334_1.bgmTxt2_.text ~= "" then
							arg_334_1.bgmTxt_.text = arg_334_1.bgmTxt2_.text
						end

						arg_334_1.bgmTxt2_.text = var_337_5

						arg_334_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_334_1.bgmTxt_.text = var_337_5
						arg_334_1.bgmTxt2_.text = var_337_5
					end

					if arg_334_1.bgmTimer then
						arg_334_1.bgmTimer:Stop()

						arg_334_1.bgmTimer = nil
					end

					if arg_334_1.settingData.show_music_name == 1 then
						arg_334_1.musicController:SetSelectedState("show")
						arg_334_1.musicAnimator_:Play("open", 0, 0)

						if arg_334_1.settingData.music_time ~= 0 then
							arg_334_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_334_1.settingData.music_time), function()
								if arg_334_1 == nil or isNil(arg_334_1.bgmTxt_) then
									return
								end

								arg_334_1.musicController:SetSelectedState("hide")
								arg_334_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_337_6 = 0.533333333333333
			local var_337_7 = 1

			if var_337_6 < arg_334_1.time_ and arg_334_1.time_ <= var_337_6 + arg_337_0 then
				local var_337_8 = "play"
				local var_337_9 = "music"

				arg_334_1:AudioAction(var_337_8, var_337_9, "bgm_side_daily03", "bgm_side_daily03", "bgm_side_daily03.awb")

				local var_337_10 = ""
				local var_337_11 = manager.audio:GetAudioName("bgm_side_daily03", "bgm_side_daily03")

				if var_337_11 ~= "" then
					if arg_334_1.bgmTxt_.text ~= var_337_11 and arg_334_1.bgmTxt_.text ~= "" then
						if arg_334_1.bgmTxt2_.text ~= "" then
							arg_334_1.bgmTxt_.text = arg_334_1.bgmTxt2_.text
						end

						arg_334_1.bgmTxt2_.text = var_337_11

						arg_334_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_334_1.bgmTxt_.text = var_337_11
						arg_334_1.bgmTxt2_.text = var_337_11
					end

					if arg_334_1.bgmTimer then
						arg_334_1.bgmTimer:Stop()

						arg_334_1.bgmTimer = nil
					end

					if arg_334_1.settingData.show_music_name == 1 then
						arg_334_1.musicController:SetSelectedState("show")
						arg_334_1.musicAnimator_:Play("open", 0, 0)

						if arg_334_1.settingData.music_time ~= 0 then
							arg_334_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_334_1.settingData.music_time), function()
								if arg_334_1 == nil or isNil(arg_334_1.bgmTxt_) then
									return
								end

								arg_334_1.musicController:SetSelectedState("hide")
								arg_334_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_337_12 = arg_334_1.actors_["111101ui_story"].transform
			local var_337_13 = 0

			if var_337_13 < arg_334_1.time_ and arg_334_1.time_ <= var_337_13 + arg_337_0 then
				arg_334_1.var_.moveOldPos111101ui_story = var_337_12.localPosition
			end

			local var_337_14 = 0.001

			if var_337_13 <= arg_334_1.time_ and arg_334_1.time_ < var_337_13 + var_337_14 then
				local var_337_15 = (arg_334_1.time_ - var_337_13) / var_337_14
				local var_337_16 = Vector3.New(0, 100, 0)

				var_337_12.localPosition = Vector3.Lerp(arg_334_1.var_.moveOldPos111101ui_story, var_337_16, var_337_15)

				local var_337_17 = manager.ui.mainCamera.transform.position - var_337_12.position

				var_337_12.forward = Vector3.New(var_337_17.x, var_337_17.y, var_337_17.z)

				local var_337_18 = var_337_12.localEulerAngles

				var_337_18.z = 0
				var_337_18.x = 0
				var_337_12.localEulerAngles = var_337_18
			end

			if arg_334_1.time_ >= var_337_13 + var_337_14 and arg_334_1.time_ < var_337_13 + var_337_14 + arg_337_0 then
				var_337_12.localPosition = Vector3.New(0, 100, 0)

				local var_337_19 = manager.ui.mainCamera.transform.position - var_337_12.position

				var_337_12.forward = Vector3.New(var_337_19.x, var_337_19.y, var_337_19.z)

				local var_337_20 = var_337_12.localEulerAngles

				var_337_20.z = 0
				var_337_20.x = 0
				var_337_12.localEulerAngles = var_337_20
			end

			local var_337_21 = 0
			local var_337_22 = 0.775

			if var_337_21 < arg_334_1.time_ and arg_334_1.time_ <= var_337_21 + arg_337_0 then
				arg_334_1.talkMaxDuration = 0
				arg_334_1.dialogCg_.alpha = 1

				arg_334_1.dialog_:SetActive(true)
				SetActive(arg_334_1.leftNameGo_, false)

				arg_334_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_334_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_334_1:RecordName(arg_334_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_334_1.iconTrs_.gameObject, false)
				arg_334_1.callingController_:SetSelectedState("normal")

				local var_337_23 = arg_334_1:GetWordFromCfg(1101104084)
				local var_337_24 = arg_334_1:FormatText(var_337_23.content)

				arg_334_1.text_.text = var_337_24

				LuaForUtil.ClearLinePrefixSymbol(arg_334_1.text_)

				local var_337_25 = 31
				local var_337_26 = utf8.len(var_337_24)
				local var_337_27 = var_337_25 <= 0 and var_337_22 or var_337_22 * (var_337_26 / var_337_25)

				if var_337_27 > 0 and var_337_22 < var_337_27 then
					arg_334_1.talkMaxDuration = var_337_27

					if var_337_27 + var_337_21 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_27 + var_337_21
					end
				end

				arg_334_1.text_.text = var_337_24
				arg_334_1.typewritter.percent = 0

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(false)
				arg_334_1:RecordContent(arg_334_1.text_.text)
			end

			local var_337_28 = math.max(var_337_22, arg_334_1.talkMaxDuration)

			if var_337_21 <= arg_334_1.time_ and arg_334_1.time_ < var_337_21 + var_337_28 then
				arg_334_1.typewritter.percent = (arg_334_1.time_ - var_337_21) / var_337_28

				arg_334_1.typewritter:SetDirty()
			end

			if arg_334_1.time_ >= var_337_21 + var_337_28 and arg_334_1.time_ < var_337_21 + var_337_28 + arg_337_0 then
				arg_334_1.typewritter.percent = 1

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(true)
			end
		end

		arg_334_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "111101ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_334_1:InitPlayNodeList()
	end,
	Play1101104085 = function(arg_340_0, arg_340_1)
		arg_340_1.time_ = 0
		arg_340_1.frameCnt_ = 0
		arg_340_1.state_ = "playing"
		arg_340_1.curTalkId_ = 1101104085
		arg_340_1.duration_ = 5

		SetActive(arg_340_1.tipsGo_, false)

		function arg_340_1.onSingleLineFinish_()
			arg_340_1.onSingleLineUpdate_ = nil
			arg_340_1.onSingleLineFinish_ = nil
			arg_340_1.state_ = "waiting"
		end

		function arg_340_1.playNext_(arg_342_0)
			if arg_342_0 == 1 then
				arg_340_0:Play1101104086(arg_340_1)
			end
		end

		function arg_340_1.onSingleLineUpdate_(arg_343_0)
			local var_343_0 = 0
			local var_343_1 = 1.375

			if var_343_0 < arg_340_1.time_ and arg_340_1.time_ <= var_343_0 + arg_343_0 then
				arg_340_1.talkMaxDuration = 0
				arg_340_1.dialogCg_.alpha = 1

				arg_340_1.dialog_:SetActive(true)
				SetActive(arg_340_1.leftNameGo_, false)

				arg_340_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_340_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_340_1:RecordName(arg_340_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_340_1.iconTrs_.gameObject, false)
				arg_340_1.callingController_:SetSelectedState("normal")

				local var_343_2 = arg_340_1:GetWordFromCfg(1101104085)
				local var_343_3 = arg_340_1:FormatText(var_343_2.content)

				arg_340_1.text_.text = var_343_3

				LuaForUtil.ClearLinePrefixSymbol(arg_340_1.text_)

				local var_343_4 = 55
				local var_343_5 = utf8.len(var_343_3)
				local var_343_6 = var_343_4 <= 0 and var_343_1 or var_343_1 * (var_343_5 / var_343_4)

				if var_343_6 > 0 and var_343_1 < var_343_6 then
					arg_340_1.talkMaxDuration = var_343_6

					if var_343_6 + var_343_0 > arg_340_1.duration_ then
						arg_340_1.duration_ = var_343_6 + var_343_0
					end
				end

				arg_340_1.text_.text = var_343_3
				arg_340_1.typewritter.percent = 0

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(false)
				arg_340_1:RecordContent(arg_340_1.text_.text)
			end

			local var_343_7 = math.max(var_343_1, arg_340_1.talkMaxDuration)

			if var_343_0 <= arg_340_1.time_ and arg_340_1.time_ < var_343_0 + var_343_7 then
				arg_340_1.typewritter.percent = (arg_340_1.time_ - var_343_0) / var_343_7

				arg_340_1.typewritter:SetDirty()
			end

			if arg_340_1.time_ >= var_343_0 + var_343_7 and arg_340_1.time_ < var_343_0 + var_343_7 + arg_343_0 then
				arg_340_1.typewritter.percent = 1

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(true)
			end
		end

		arg_340_1.nodeConfigList_ = {}

		arg_340_1:InitPlayNodeList()
	end,
	Play1101104086 = function(arg_344_0, arg_344_1)
		arg_344_1.time_ = 0
		arg_344_1.frameCnt_ = 0
		arg_344_1.state_ = "playing"
		arg_344_1.curTalkId_ = 1101104086
		arg_344_1.duration_ = 5

		SetActive(arg_344_1.tipsGo_, false)

		function arg_344_1.onSingleLineFinish_()
			arg_344_1.onSingleLineUpdate_ = nil
			arg_344_1.onSingleLineFinish_ = nil
			arg_344_1.state_ = "waiting"
		end

		function arg_344_1.playNext_(arg_346_0)
			if arg_346_0 == 1 then
				arg_344_0:Play1101104087(arg_344_1)
			end
		end

		function arg_344_1.onSingleLineUpdate_(arg_347_0)
			local var_347_0 = 0
			local var_347_1 = 0.925

			if var_347_0 < arg_344_1.time_ and arg_344_1.time_ <= var_347_0 + arg_347_0 then
				arg_344_1.talkMaxDuration = 0
				arg_344_1.dialogCg_.alpha = 1

				arg_344_1.dialog_:SetActive(true)
				SetActive(arg_344_1.leftNameGo_, false)

				arg_344_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_344_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_344_1:RecordName(arg_344_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_344_1.iconTrs_.gameObject, false)
				arg_344_1.callingController_:SetSelectedState("normal")

				local var_347_2 = arg_344_1:GetWordFromCfg(1101104086)
				local var_347_3 = arg_344_1:FormatText(var_347_2.content)

				arg_344_1.text_.text = var_347_3

				LuaForUtil.ClearLinePrefixSymbol(arg_344_1.text_)

				local var_347_4 = 37
				local var_347_5 = utf8.len(var_347_3)
				local var_347_6 = var_347_4 <= 0 and var_347_1 or var_347_1 * (var_347_5 / var_347_4)

				if var_347_6 > 0 and var_347_1 < var_347_6 then
					arg_344_1.talkMaxDuration = var_347_6

					if var_347_6 + var_347_0 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_6 + var_347_0
					end
				end

				arg_344_1.text_.text = var_347_3
				arg_344_1.typewritter.percent = 0

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(false)
				arg_344_1:RecordContent(arg_344_1.text_.text)
			end

			local var_347_7 = math.max(var_347_1, arg_344_1.talkMaxDuration)

			if var_347_0 <= arg_344_1.time_ and arg_344_1.time_ < var_347_0 + var_347_7 then
				arg_344_1.typewritter.percent = (arg_344_1.time_ - var_347_0) / var_347_7

				arg_344_1.typewritter:SetDirty()
			end

			if arg_344_1.time_ >= var_347_0 + var_347_7 and arg_344_1.time_ < var_347_0 + var_347_7 + arg_347_0 then
				arg_344_1.typewritter.percent = 1

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(true)
			end
		end

		arg_344_1.nodeConfigList_ = {}

		arg_344_1:InitPlayNodeList()
	end,
	Play1101104087 = function(arg_348_0, arg_348_1)
		arg_348_1.time_ = 0
		arg_348_1.frameCnt_ = 0
		arg_348_1.state_ = "playing"
		arg_348_1.curTalkId_ = 1101104087
		arg_348_1.duration_ = 6.2

		local var_348_0 = {
			zh = 5.933,
			ja = 6.2
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
				arg_348_0:Play1101104088(arg_348_1)
			end
		end

		function arg_348_1.onSingleLineUpdate_(arg_351_0)
			local var_351_0 = 0
			local var_351_1 = 0.4

			if var_351_0 < arg_348_1.time_ and arg_348_1.time_ <= var_351_0 + arg_351_0 then
				arg_348_1.talkMaxDuration = 0
				arg_348_1.dialogCg_.alpha = 1

				arg_348_1.dialog_:SetActive(true)
				SetActive(arg_348_1.leftNameGo_, true)

				local var_351_2 = arg_348_1:FormatText(StoryNameCfg[67].name)

				arg_348_1.leftNameTxt_.text = var_351_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_348_1.leftNameTxt_.transform)

				arg_348_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_348_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_348_1:RecordName(arg_348_1.leftNameTxt_.text)
				SetActive(arg_348_1.iconTrs_.gameObject, true)
				arg_348_1.iconController_:SetSelectedState("hero")

				arg_348_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1111")

				arg_348_1.callingController_:SetSelectedState("normal")

				arg_348_1.keyicon_.color = Color.New(1, 1, 1)
				arg_348_1.icon_.color = Color.New(1, 1, 1)

				local var_351_3 = arg_348_1:GetWordFromCfg(1101104087)
				local var_351_4 = arg_348_1:FormatText(var_351_3.content)

				arg_348_1.text_.text = var_351_4

				LuaForUtil.ClearLinePrefixSymbol(arg_348_1.text_)

				local var_351_5 = 16
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

				if manager.audio:GetVoiceLength("story_v_side_new_1101104", "1101104087", "story_v_side_new_1101104.awb") ~= 0 then
					local var_351_8 = manager.audio:GetVoiceLength("story_v_side_new_1101104", "1101104087", "story_v_side_new_1101104.awb") / 1000

					if var_351_8 + var_351_0 > arg_348_1.duration_ then
						arg_348_1.duration_ = var_351_8 + var_351_0
					end

					if var_351_3.prefab_name ~= "" and arg_348_1.actors_[var_351_3.prefab_name] ~= nil then
						local var_351_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_348_1.actors_[var_351_3.prefab_name].transform, "story_v_side_new_1101104", "1101104087", "story_v_side_new_1101104.awb")

						arg_348_1:RecordAudio("1101104087", var_351_9)
						arg_348_1:RecordAudio("1101104087", var_351_9)
					else
						arg_348_1:AudioAction("play", "voice", "story_v_side_new_1101104", "1101104087", "story_v_side_new_1101104.awb")
					end

					arg_348_1:RecordHistoryTalkVoice("story_v_side_new_1101104", "1101104087", "story_v_side_new_1101104.awb")
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
	Play1101104088 = function(arg_352_0, arg_352_1)
		arg_352_1.time_ = 0
		arg_352_1.frameCnt_ = 0
		arg_352_1.state_ = "playing"
		arg_352_1.curTalkId_ = 1101104088
		arg_352_1.duration_ = 5

		SetActive(arg_352_1.tipsGo_, false)

		function arg_352_1.onSingleLineFinish_()
			arg_352_1.onSingleLineUpdate_ = nil
			arg_352_1.onSingleLineFinish_ = nil
			arg_352_1.state_ = "waiting"
		end

		function arg_352_1.playNext_(arg_354_0)
			if arg_354_0 == 1 then
				arg_352_0:Play1101104089(arg_352_1)
			end
		end

		function arg_352_1.onSingleLineUpdate_(arg_355_0)
			local var_355_0 = 0
			local var_355_1 = 0.5

			if var_355_0 < arg_352_1.time_ and arg_352_1.time_ <= var_355_0 + arg_355_0 then
				arg_352_1.talkMaxDuration = 0
				arg_352_1.dialogCg_.alpha = 1

				arg_352_1.dialog_:SetActive(true)
				SetActive(arg_352_1.leftNameGo_, true)

				local var_355_2 = arg_352_1:FormatText(StoryNameCfg[7].name)

				arg_352_1.leftNameTxt_.text = var_355_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_352_1.leftNameTxt_.transform)

				arg_352_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_352_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_352_1:RecordName(arg_352_1.leftNameTxt_.text)
				SetActive(arg_352_1.iconTrs_.gameObject, true)
				arg_352_1.iconController_:SetSelectedState("hero")

				arg_352_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_352_1.callingController_:SetSelectedState("normal")

				arg_352_1.keyicon_.color = Color.New(1, 1, 1)
				arg_352_1.icon_.color = Color.New(1, 1, 1)

				local var_355_3 = arg_352_1:GetWordFromCfg(1101104088)
				local var_355_4 = arg_352_1:FormatText(var_355_3.content)

				arg_352_1.text_.text = var_355_4

				LuaForUtil.ClearLinePrefixSymbol(arg_352_1.text_)

				local var_355_5 = 20
				local var_355_6 = utf8.len(var_355_4)
				local var_355_7 = var_355_5 <= 0 and var_355_1 or var_355_1 * (var_355_6 / var_355_5)

				if var_355_7 > 0 and var_355_1 < var_355_7 then
					arg_352_1.talkMaxDuration = var_355_7

					if var_355_7 + var_355_0 > arg_352_1.duration_ then
						arg_352_1.duration_ = var_355_7 + var_355_0
					end
				end

				arg_352_1.text_.text = var_355_4
				arg_352_1.typewritter.percent = 0

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(false)
				arg_352_1:RecordContent(arg_352_1.text_.text)
			end

			local var_355_8 = math.max(var_355_1, arg_352_1.talkMaxDuration)

			if var_355_0 <= arg_352_1.time_ and arg_352_1.time_ < var_355_0 + var_355_8 then
				arg_352_1.typewritter.percent = (arg_352_1.time_ - var_355_0) / var_355_8

				arg_352_1.typewritter:SetDirty()
			end

			if arg_352_1.time_ >= var_355_0 + var_355_8 and arg_352_1.time_ < var_355_0 + var_355_8 + arg_355_0 then
				arg_352_1.typewritter.percent = 1

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(true)
			end
		end

		arg_352_1.nodeConfigList_ = {}

		arg_352_1:InitPlayNodeList()
	end,
	Play1101104089 = function(arg_356_0, arg_356_1)
		arg_356_1.time_ = 0
		arg_356_1.frameCnt_ = 0
		arg_356_1.state_ = "playing"
		arg_356_1.curTalkId_ = 1101104089
		arg_356_1.duration_ = 5

		SetActive(arg_356_1.tipsGo_, false)

		function arg_356_1.onSingleLineFinish_()
			arg_356_1.onSingleLineUpdate_ = nil
			arg_356_1.onSingleLineFinish_ = nil
			arg_356_1.state_ = "waiting"
		end

		function arg_356_1.playNext_(arg_358_0)
			if arg_358_0 == 1 then
				arg_356_0:Play1101104090(arg_356_1)
			end
		end

		function arg_356_1.onSingleLineUpdate_(arg_359_0)
			local var_359_0 = 0
			local var_359_1 = 0.75

			if var_359_0 < arg_356_1.time_ and arg_356_1.time_ <= var_359_0 + arg_359_0 then
				arg_356_1.talkMaxDuration = 0
				arg_356_1.dialogCg_.alpha = 1

				arg_356_1.dialog_:SetActive(true)
				SetActive(arg_356_1.leftNameGo_, false)

				arg_356_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_356_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_356_1:RecordName(arg_356_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_356_1.iconTrs_.gameObject, false)
				arg_356_1.callingController_:SetSelectedState("normal")

				local var_359_2 = arg_356_1:GetWordFromCfg(1101104089)
				local var_359_3 = arg_356_1:FormatText(var_359_2.content)

				arg_356_1.text_.text = var_359_3

				LuaForUtil.ClearLinePrefixSymbol(arg_356_1.text_)

				local var_359_4 = 30
				local var_359_5 = utf8.len(var_359_3)
				local var_359_6 = var_359_4 <= 0 and var_359_1 or var_359_1 * (var_359_5 / var_359_4)

				if var_359_6 > 0 and var_359_1 < var_359_6 then
					arg_356_1.talkMaxDuration = var_359_6

					if var_359_6 + var_359_0 > arg_356_1.duration_ then
						arg_356_1.duration_ = var_359_6 + var_359_0
					end
				end

				arg_356_1.text_.text = var_359_3
				arg_356_1.typewritter.percent = 0

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(false)
				arg_356_1:RecordContent(arg_356_1.text_.text)
			end

			local var_359_7 = math.max(var_359_1, arg_356_1.talkMaxDuration)

			if var_359_0 <= arg_356_1.time_ and arg_356_1.time_ < var_359_0 + var_359_7 then
				arg_356_1.typewritter.percent = (arg_356_1.time_ - var_359_0) / var_359_7

				arg_356_1.typewritter:SetDirty()
			end

			if arg_356_1.time_ >= var_359_0 + var_359_7 and arg_356_1.time_ < var_359_0 + var_359_7 + arg_359_0 then
				arg_356_1.typewritter.percent = 1

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(true)
			end
		end

		arg_356_1.nodeConfigList_ = {}

		arg_356_1:InitPlayNodeList()
	end,
	Play1101104090 = function(arg_360_0, arg_360_1)
		arg_360_1.time_ = 0
		arg_360_1.frameCnt_ = 0
		arg_360_1.state_ = "playing"
		arg_360_1.curTalkId_ = 1101104090
		arg_360_1.duration_ = 9.23

		local var_360_0 = {
			zh = 5.966,
			ja = 9.233
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
				arg_360_0:Play1101104091(arg_360_1)
			end
		end

		function arg_360_1.onSingleLineUpdate_(arg_363_0)
			local var_363_0 = arg_360_1.actors_["111101ui_story"].transform
			local var_363_1 = 0

			if var_363_1 < arg_360_1.time_ and arg_360_1.time_ <= var_363_1 + arg_363_0 then
				arg_360_1.var_.moveOldPos111101ui_story = var_363_0.localPosition
			end

			local var_363_2 = 0.001

			if var_363_1 <= arg_360_1.time_ and arg_360_1.time_ < var_363_1 + var_363_2 then
				local var_363_3 = (arg_360_1.time_ - var_363_1) / var_363_2
				local var_363_4 = Vector3.New(0, -0.83, -6)

				var_363_0.localPosition = Vector3.Lerp(arg_360_1.var_.moveOldPos111101ui_story, var_363_4, var_363_3)

				local var_363_5 = manager.ui.mainCamera.transform.position - var_363_0.position

				var_363_0.forward = Vector3.New(var_363_5.x, var_363_5.y, var_363_5.z)

				local var_363_6 = var_363_0.localEulerAngles

				var_363_6.z = 0
				var_363_6.x = 0
				var_363_0.localEulerAngles = var_363_6
			end

			if arg_360_1.time_ >= var_363_1 + var_363_2 and arg_360_1.time_ < var_363_1 + var_363_2 + arg_363_0 then
				var_363_0.localPosition = Vector3.New(0, -0.83, -6)

				local var_363_7 = manager.ui.mainCamera.transform.position - var_363_0.position

				var_363_0.forward = Vector3.New(var_363_7.x, var_363_7.y, var_363_7.z)

				local var_363_8 = var_363_0.localEulerAngles

				var_363_8.z = 0
				var_363_8.x = 0
				var_363_0.localEulerAngles = var_363_8
			end

			local var_363_9 = arg_360_1.actors_["111101ui_story"]
			local var_363_10 = 0

			if var_363_10 < arg_360_1.time_ and arg_360_1.time_ <= var_363_10 + arg_363_0 and not isNil(var_363_9) and arg_360_1.var_.characterEffect111101ui_story == nil then
				arg_360_1.var_.characterEffect111101ui_story = var_363_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_363_11 = 0.200000002980232

			if var_363_10 <= arg_360_1.time_ and arg_360_1.time_ < var_363_10 + var_363_11 and not isNil(var_363_9) then
				local var_363_12 = (arg_360_1.time_ - var_363_10) / var_363_11

				if arg_360_1.var_.characterEffect111101ui_story and not isNil(var_363_9) then
					arg_360_1.var_.characterEffect111101ui_story.fillFlat = false
				end
			end

			if arg_360_1.time_ >= var_363_10 + var_363_11 and arg_360_1.time_ < var_363_10 + var_363_11 + arg_363_0 and not isNil(var_363_9) and arg_360_1.var_.characterEffect111101ui_story then
				arg_360_1.var_.characterEffect111101ui_story.fillFlat = false
			end

			local var_363_13 = 0

			if var_363_13 < arg_360_1.time_ and arg_360_1.time_ <= var_363_13 + arg_363_0 then
				arg_360_1:PlayTimeline("111101ui_story", "StoryTimeline/CharAction/story1111/story1111actionlink/1111action449")
			end

			local var_363_14 = 0

			if var_363_14 < arg_360_1.time_ and arg_360_1.time_ <= var_363_14 + arg_363_0 then
				arg_360_1:PlayTimeline("111101ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_363_15 = 0
			local var_363_16 = 0.675

			if var_363_15 < arg_360_1.time_ and arg_360_1.time_ <= var_363_15 + arg_363_0 then
				arg_360_1.talkMaxDuration = 0
				arg_360_1.dialogCg_.alpha = 1

				arg_360_1.dialog_:SetActive(true)
				SetActive(arg_360_1.leftNameGo_, true)

				local var_363_17 = arg_360_1:FormatText(StoryNameCfg[67].name)

				arg_360_1.leftNameTxt_.text = var_363_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_360_1.leftNameTxt_.transform)

				arg_360_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_360_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_360_1:RecordName(arg_360_1.leftNameTxt_.text)
				SetActive(arg_360_1.iconTrs_.gameObject, false)
				arg_360_1.callingController_:SetSelectedState("normal")

				local var_363_18 = arg_360_1:GetWordFromCfg(1101104090)
				local var_363_19 = arg_360_1:FormatText(var_363_18.content)

				arg_360_1.text_.text = var_363_19

				LuaForUtil.ClearLinePrefixSymbol(arg_360_1.text_)

				local var_363_20 = 27
				local var_363_21 = utf8.len(var_363_19)
				local var_363_22 = var_363_20 <= 0 and var_363_16 or var_363_16 * (var_363_21 / var_363_20)

				if var_363_22 > 0 and var_363_16 < var_363_22 then
					arg_360_1.talkMaxDuration = var_363_22

					if var_363_22 + var_363_15 > arg_360_1.duration_ then
						arg_360_1.duration_ = var_363_22 + var_363_15
					end
				end

				arg_360_1.text_.text = var_363_19
				arg_360_1.typewritter.percent = 0

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101104", "1101104090", "story_v_side_new_1101104.awb") ~= 0 then
					local var_363_23 = manager.audio:GetVoiceLength("story_v_side_new_1101104", "1101104090", "story_v_side_new_1101104.awb") / 1000

					if var_363_23 + var_363_15 > arg_360_1.duration_ then
						arg_360_1.duration_ = var_363_23 + var_363_15
					end

					if var_363_18.prefab_name ~= "" and arg_360_1.actors_[var_363_18.prefab_name] ~= nil then
						local var_363_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_360_1.actors_[var_363_18.prefab_name].transform, "story_v_side_new_1101104", "1101104090", "story_v_side_new_1101104.awb")

						arg_360_1:RecordAudio("1101104090", var_363_24)
						arg_360_1:RecordAudio("1101104090", var_363_24)
					else
						arg_360_1:AudioAction("play", "voice", "story_v_side_new_1101104", "1101104090", "story_v_side_new_1101104.awb")
					end

					arg_360_1:RecordHistoryTalkVoice("story_v_side_new_1101104", "1101104090", "story_v_side_new_1101104.awb")
				end

				arg_360_1:RecordContent(arg_360_1.text_.text)
			end

			local var_363_25 = math.max(var_363_16, arg_360_1.talkMaxDuration)

			if var_363_15 <= arg_360_1.time_ and arg_360_1.time_ < var_363_15 + var_363_25 then
				arg_360_1.typewritter.percent = (arg_360_1.time_ - var_363_15) / var_363_25

				arg_360_1.typewritter:SetDirty()
			end

			if arg_360_1.time_ >= var_363_15 + var_363_25 and arg_360_1.time_ < var_363_15 + var_363_25 + arg_363_0 then
				arg_360_1.typewritter.percent = 1

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(true)
			end
		end

		arg_360_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "111101ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_360_1:InitPlayNodeList()
	end,
	Play1101104091 = function(arg_364_0, arg_364_1)
		arg_364_1.time_ = 0
		arg_364_1.frameCnt_ = 0
		arg_364_1.state_ = "playing"
		arg_364_1.curTalkId_ = 1101104091
		arg_364_1.duration_ = 5

		SetActive(arg_364_1.tipsGo_, false)

		function arg_364_1.onSingleLineFinish_()
			arg_364_1.onSingleLineUpdate_ = nil
			arg_364_1.onSingleLineFinish_ = nil
			arg_364_1.state_ = "waiting"
		end

		function arg_364_1.playNext_(arg_366_0)
			if arg_366_0 == 1 then
				arg_364_0:Play1101104092(arg_364_1)
			end
		end

		function arg_364_1.onSingleLineUpdate_(arg_367_0)
			local var_367_0 = arg_364_1.actors_["111101ui_story"]
			local var_367_1 = 0

			if var_367_1 < arg_364_1.time_ and arg_364_1.time_ <= var_367_1 + arg_367_0 and not isNil(var_367_0) and arg_364_1.var_.characterEffect111101ui_story == nil then
				arg_364_1.var_.characterEffect111101ui_story = var_367_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_367_2 = 0.200000002980232

			if var_367_1 <= arg_364_1.time_ and arg_364_1.time_ < var_367_1 + var_367_2 and not isNil(var_367_0) then
				local var_367_3 = (arg_364_1.time_ - var_367_1) / var_367_2

				if arg_364_1.var_.characterEffect111101ui_story and not isNil(var_367_0) then
					local var_367_4 = Mathf.Lerp(0, 0.5, var_367_3)

					arg_364_1.var_.characterEffect111101ui_story.fillFlat = true
					arg_364_1.var_.characterEffect111101ui_story.fillRatio = var_367_4
				end
			end

			if arg_364_1.time_ >= var_367_1 + var_367_2 and arg_364_1.time_ < var_367_1 + var_367_2 + arg_367_0 and not isNil(var_367_0) and arg_364_1.var_.characterEffect111101ui_story then
				local var_367_5 = 0.5

				arg_364_1.var_.characterEffect111101ui_story.fillFlat = true
				arg_364_1.var_.characterEffect111101ui_story.fillRatio = var_367_5
			end

			local var_367_6 = 0
			local var_367_7 = 0.375

			if var_367_6 < arg_364_1.time_ and arg_364_1.time_ <= var_367_6 + arg_367_0 then
				arg_364_1.talkMaxDuration = 0
				arg_364_1.dialogCg_.alpha = 1

				arg_364_1.dialog_:SetActive(true)
				SetActive(arg_364_1.leftNameGo_, true)

				local var_367_8 = arg_364_1:FormatText(StoryNameCfg[7].name)

				arg_364_1.leftNameTxt_.text = var_367_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_364_1.leftNameTxt_.transform)

				arg_364_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_364_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_364_1:RecordName(arg_364_1.leftNameTxt_.text)
				SetActive(arg_364_1.iconTrs_.gameObject, true)
				arg_364_1.iconController_:SetSelectedState("hero")

				arg_364_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_364_1.callingController_:SetSelectedState("normal")

				arg_364_1.keyicon_.color = Color.New(1, 1, 1)
				arg_364_1.icon_.color = Color.New(1, 1, 1)

				local var_367_9 = arg_364_1:GetWordFromCfg(1101104091)
				local var_367_10 = arg_364_1:FormatText(var_367_9.content)

				arg_364_1.text_.text = var_367_10

				LuaForUtil.ClearLinePrefixSymbol(arg_364_1.text_)

				local var_367_11 = 15
				local var_367_12 = utf8.len(var_367_10)
				local var_367_13 = var_367_11 <= 0 and var_367_7 or var_367_7 * (var_367_12 / var_367_11)

				if var_367_13 > 0 and var_367_7 < var_367_13 then
					arg_364_1.talkMaxDuration = var_367_13

					if var_367_13 + var_367_6 > arg_364_1.duration_ then
						arg_364_1.duration_ = var_367_13 + var_367_6
					end
				end

				arg_364_1.text_.text = var_367_10
				arg_364_1.typewritter.percent = 0

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(false)
				arg_364_1:RecordContent(arg_364_1.text_.text)
			end

			local var_367_14 = math.max(var_367_7, arg_364_1.talkMaxDuration)

			if var_367_6 <= arg_364_1.time_ and arg_364_1.time_ < var_367_6 + var_367_14 then
				arg_364_1.typewritter.percent = (arg_364_1.time_ - var_367_6) / var_367_14

				arg_364_1.typewritter:SetDirty()
			end

			if arg_364_1.time_ >= var_367_6 + var_367_14 and arg_364_1.time_ < var_367_6 + var_367_14 + arg_367_0 then
				arg_364_1.typewritter.percent = 1

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(true)
			end
		end

		arg_364_1.nodeConfigList_ = {}

		arg_364_1:InitPlayNodeList()
	end,
	Play1101104092 = function(arg_368_0, arg_368_1)
		arg_368_1.time_ = 0
		arg_368_1.frameCnt_ = 0
		arg_368_1.state_ = "playing"
		arg_368_1.curTalkId_ = 1101104092
		arg_368_1.duration_ = 13

		SetActive(arg_368_1.tipsGo_, false)

		function arg_368_1.onSingleLineFinish_()
			arg_368_1.onSingleLineUpdate_ = nil
			arg_368_1.onSingleLineFinish_ = nil
			arg_368_1.state_ = "waiting"
		end

		function arg_368_1.playNext_(arg_370_0)
			if arg_370_0 == 1 then
				arg_368_0:Play1101104093(arg_368_1)
			end
		end

		function arg_368_1.onSingleLineUpdate_(arg_371_0)
			local var_371_0 = 4

			if var_371_0 < arg_368_1.time_ and arg_368_1.time_ <= var_371_0 + arg_371_0 then
				local var_371_1 = manager.ui.mainCamera.transform.localPosition
				local var_371_2 = Vector3.New(0, 0, 10) + Vector3.New(var_371_1.x, var_371_1.y, 0)
				local var_371_3 = arg_368_1.bgs_.ST12

				var_371_3.transform.localPosition = var_371_2
				var_371_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_371_4 = var_371_3:GetComponent("SpriteRenderer")

				if var_371_4 and var_371_4.sprite then
					local var_371_5 = (var_371_3.transform.localPosition - var_371_1).z
					local var_371_6 = manager.ui.mainCameraCom_
					local var_371_7 = 2 * var_371_5 * Mathf.Tan(var_371_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_371_8 = var_371_7 * var_371_6.aspect
					local var_371_9 = var_371_4.sprite.bounds.size.x
					local var_371_10 = var_371_4.sprite.bounds.size.y
					local var_371_11 = var_371_8 / var_371_9
					local var_371_12 = var_371_7 / var_371_10
					local var_371_13 = var_371_12 < var_371_11 and var_371_11 or var_371_12

					var_371_3.transform.localScale = Vector3.New(var_371_13, var_371_13, 0)
				end

				for iter_371_0, iter_371_1 in pairs(arg_368_1.bgs_) do
					if iter_371_0 ~= "ST12" then
						iter_371_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_371_14 = 0

			if var_371_14 < arg_368_1.time_ and arg_368_1.time_ <= var_371_14 + arg_371_0 then
				arg_368_1.mask_.enabled = true
				arg_368_1.mask_.raycastTarget = true

				arg_368_1:SetGaussion(false)
			end

			local var_371_15 = 4

			if var_371_14 <= arg_368_1.time_ and arg_368_1.time_ < var_371_14 + var_371_15 then
				local var_371_16 = (arg_368_1.time_ - var_371_14) / var_371_15
				local var_371_17 = Color.New(0, 0, 0)

				var_371_17.a = Mathf.Lerp(0, 1, var_371_16)
				arg_368_1.mask_.color = var_371_17
			end

			if arg_368_1.time_ >= var_371_14 + var_371_15 and arg_368_1.time_ < var_371_14 + var_371_15 + arg_371_0 then
				local var_371_18 = Color.New(0, 0, 0)

				var_371_18.a = 1
				arg_368_1.mask_.color = var_371_18
			end

			local var_371_19 = 4

			if var_371_19 < arg_368_1.time_ and arg_368_1.time_ <= var_371_19 + arg_371_0 then
				arg_368_1.mask_.enabled = true
				arg_368_1.mask_.raycastTarget = true

				arg_368_1:SetGaussion(false)
			end

			local var_371_20 = 4

			if var_371_19 <= arg_368_1.time_ and arg_368_1.time_ < var_371_19 + var_371_20 then
				local var_371_21 = (arg_368_1.time_ - var_371_19) / var_371_20
				local var_371_22 = Color.New(0, 0, 0)

				var_371_22.a = Mathf.Lerp(1, 0, var_371_21)
				arg_368_1.mask_.color = var_371_22
			end

			if arg_368_1.time_ >= var_371_19 + var_371_20 and arg_368_1.time_ < var_371_19 + var_371_20 + arg_371_0 then
				local var_371_23 = Color.New(0, 0, 0)
				local var_371_24 = 0

				arg_368_1.mask_.enabled = false
				var_371_23.a = var_371_24
				arg_368_1.mask_.color = var_371_23
			end

			local var_371_25 = arg_368_1.actors_["111101ui_story"].transform
			local var_371_26 = 4

			if var_371_26 < arg_368_1.time_ and arg_368_1.time_ <= var_371_26 + arg_371_0 then
				arg_368_1.var_.moveOldPos111101ui_story = var_371_25.localPosition
			end

			local var_371_27 = 0.001

			if var_371_26 <= arg_368_1.time_ and arg_368_1.time_ < var_371_26 + var_371_27 then
				local var_371_28 = (arg_368_1.time_ - var_371_26) / var_371_27
				local var_371_29 = Vector3.New(0, 100, 0)

				var_371_25.localPosition = Vector3.Lerp(arg_368_1.var_.moveOldPos111101ui_story, var_371_29, var_371_28)

				local var_371_30 = manager.ui.mainCamera.transform.position - var_371_25.position

				var_371_25.forward = Vector3.New(var_371_30.x, var_371_30.y, var_371_30.z)

				local var_371_31 = var_371_25.localEulerAngles

				var_371_31.z = 0
				var_371_31.x = 0
				var_371_25.localEulerAngles = var_371_31
			end

			if arg_368_1.time_ >= var_371_26 + var_371_27 and arg_368_1.time_ < var_371_26 + var_371_27 + arg_371_0 then
				var_371_25.localPosition = Vector3.New(0, 100, 0)

				local var_371_32 = manager.ui.mainCamera.transform.position - var_371_25.position

				var_371_25.forward = Vector3.New(var_371_32.x, var_371_32.y, var_371_32.z)

				local var_371_33 = var_371_25.localEulerAngles

				var_371_33.z = 0
				var_371_33.x = 0
				var_371_25.localEulerAngles = var_371_33
			end

			if arg_368_1.frameCnt_ <= 1 then
				arg_368_1.dialog_:SetActive(false)
			end

			local var_371_34 = 8
			local var_371_35 = 0.95

			if var_371_34 < arg_368_1.time_ and arg_368_1.time_ <= var_371_34 + arg_371_0 then
				arg_368_1.talkMaxDuration = 0

				arg_368_1.dialog_:SetActive(true)

				arg_368_1.dialogCg_.alpha = 0

				local var_371_36 = LeanTween.value(arg_368_1.dialog_, 0, 1, 0.3)

				var_371_36:setOnUpdate(LuaHelper.FloatAction(function(arg_372_0)
					arg_368_1.dialogCg_.alpha = arg_372_0
				end))
				var_371_36:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_368_1.dialog_)
					var_371_36:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_368_1.duration_ = arg_368_1.duration_ + 0.3

				SetActive(arg_368_1.leftNameGo_, false)

				arg_368_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_368_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_368_1:RecordName(arg_368_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_368_1.iconTrs_.gameObject, false)
				arg_368_1.callingController_:SetSelectedState("normal")

				local var_371_37 = arg_368_1:GetWordFromCfg(1101104092)
				local var_371_38 = arg_368_1:FormatText(var_371_37.content)

				arg_368_1.text_.text = var_371_38

				LuaForUtil.ClearLinePrefixSymbol(arg_368_1.text_)

				local var_371_39 = 38
				local var_371_40 = utf8.len(var_371_38)
				local var_371_41 = var_371_39 <= 0 and var_371_35 or var_371_35 * (var_371_40 / var_371_39)

				if var_371_41 > 0 and var_371_35 < var_371_41 then
					arg_368_1.talkMaxDuration = var_371_41
					var_371_34 = var_371_34 + 0.3

					if var_371_41 + var_371_34 > arg_368_1.duration_ then
						arg_368_1.duration_ = var_371_41 + var_371_34
					end
				end

				arg_368_1.text_.text = var_371_38
				arg_368_1.typewritter.percent = 0

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(false)
				arg_368_1:RecordContent(arg_368_1.text_.text)
			end

			local var_371_42 = var_371_34 + 0.3
			local var_371_43 = math.max(var_371_35, arg_368_1.talkMaxDuration)

			if var_371_42 <= arg_368_1.time_ and arg_368_1.time_ < var_371_42 + var_371_43 then
				arg_368_1.typewritter.percent = (arg_368_1.time_ - var_371_42) / var_371_43

				arg_368_1.typewritter:SetDirty()
			end

			if arg_368_1.time_ >= var_371_42 + var_371_43 and arg_368_1.time_ < var_371_42 + var_371_43 + arg_371_0 then
				arg_368_1.typewritter.percent = 1

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(true)
			end
		end

		arg_368_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "111101ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_368_1:InitPlayNodeList()
	end,
	Play1101104093 = function(arg_374_0, arg_374_1)
		arg_374_1.time_ = 0
		arg_374_1.frameCnt_ = 0
		arg_374_1.state_ = "playing"
		arg_374_1.curTalkId_ = 1101104093
		arg_374_1.duration_ = 7.57

		local var_374_0 = {
			zh = 7.566,
			ja = 7.466
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
				arg_374_0:Play1101104094(arg_374_1)
			end
		end

		function arg_374_1.onSingleLineUpdate_(arg_377_0)
			local var_377_0 = arg_374_1.actors_["111101ui_story"].transform
			local var_377_1 = 0

			if var_377_1 < arg_374_1.time_ and arg_374_1.time_ <= var_377_1 + arg_377_0 then
				arg_374_1.var_.moveOldPos111101ui_story = var_377_0.localPosition
			end

			local var_377_2 = 0.001

			if var_377_1 <= arg_374_1.time_ and arg_374_1.time_ < var_377_1 + var_377_2 then
				local var_377_3 = (arg_374_1.time_ - var_377_1) / var_377_2
				local var_377_4 = Vector3.New(0, -0.83, -6)

				var_377_0.localPosition = Vector3.Lerp(arg_374_1.var_.moveOldPos111101ui_story, var_377_4, var_377_3)

				local var_377_5 = manager.ui.mainCamera.transform.position - var_377_0.position

				var_377_0.forward = Vector3.New(var_377_5.x, var_377_5.y, var_377_5.z)

				local var_377_6 = var_377_0.localEulerAngles

				var_377_6.z = 0
				var_377_6.x = 0
				var_377_0.localEulerAngles = var_377_6
			end

			if arg_374_1.time_ >= var_377_1 + var_377_2 and arg_374_1.time_ < var_377_1 + var_377_2 + arg_377_0 then
				var_377_0.localPosition = Vector3.New(0, -0.83, -6)

				local var_377_7 = manager.ui.mainCamera.transform.position - var_377_0.position

				var_377_0.forward = Vector3.New(var_377_7.x, var_377_7.y, var_377_7.z)

				local var_377_8 = var_377_0.localEulerAngles

				var_377_8.z = 0
				var_377_8.x = 0
				var_377_0.localEulerAngles = var_377_8
			end

			local var_377_9 = arg_374_1.actors_["111101ui_story"]
			local var_377_10 = 0

			if var_377_10 < arg_374_1.time_ and arg_374_1.time_ <= var_377_10 + arg_377_0 and not isNil(var_377_9) and arg_374_1.var_.characterEffect111101ui_story == nil then
				arg_374_1.var_.characterEffect111101ui_story = var_377_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_377_11 = 0.200000002980232

			if var_377_10 <= arg_374_1.time_ and arg_374_1.time_ < var_377_10 + var_377_11 and not isNil(var_377_9) then
				local var_377_12 = (arg_374_1.time_ - var_377_10) / var_377_11

				if arg_374_1.var_.characterEffect111101ui_story and not isNil(var_377_9) then
					arg_374_1.var_.characterEffect111101ui_story.fillFlat = false
				end
			end

			if arg_374_1.time_ >= var_377_10 + var_377_11 and arg_374_1.time_ < var_377_10 + var_377_11 + arg_377_0 and not isNil(var_377_9) and arg_374_1.var_.characterEffect111101ui_story then
				arg_374_1.var_.characterEffect111101ui_story.fillFlat = false
			end

			local var_377_13 = 0

			if var_377_13 < arg_374_1.time_ and arg_374_1.time_ <= var_377_13 + arg_377_0 then
				arg_374_1:PlayTimeline("111101ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action1_1")
			end

			local var_377_14 = 0

			if var_377_14 < arg_374_1.time_ and arg_374_1.time_ <= var_377_14 + arg_377_0 then
				arg_374_1:PlayTimeline("111101ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_377_15 = 0
			local var_377_16 = 0.8

			if var_377_15 < arg_374_1.time_ and arg_374_1.time_ <= var_377_15 + arg_377_0 then
				arg_374_1.talkMaxDuration = 0
				arg_374_1.dialogCg_.alpha = 1

				arg_374_1.dialog_:SetActive(true)
				SetActive(arg_374_1.leftNameGo_, true)

				local var_377_17 = arg_374_1:FormatText(StoryNameCfg[67].name)

				arg_374_1.leftNameTxt_.text = var_377_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_374_1.leftNameTxt_.transform)

				arg_374_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_374_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_374_1:RecordName(arg_374_1.leftNameTxt_.text)
				SetActive(arg_374_1.iconTrs_.gameObject, false)
				arg_374_1.callingController_:SetSelectedState("normal")

				local var_377_18 = arg_374_1:GetWordFromCfg(1101104093)
				local var_377_19 = arg_374_1:FormatText(var_377_18.content)

				arg_374_1.text_.text = var_377_19

				LuaForUtil.ClearLinePrefixSymbol(arg_374_1.text_)

				local var_377_20 = 32
				local var_377_21 = utf8.len(var_377_19)
				local var_377_22 = var_377_20 <= 0 and var_377_16 or var_377_16 * (var_377_21 / var_377_20)

				if var_377_22 > 0 and var_377_16 < var_377_22 then
					arg_374_1.talkMaxDuration = var_377_22

					if var_377_22 + var_377_15 > arg_374_1.duration_ then
						arg_374_1.duration_ = var_377_22 + var_377_15
					end
				end

				arg_374_1.text_.text = var_377_19
				arg_374_1.typewritter.percent = 0

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101104", "1101104093", "story_v_side_new_1101104.awb") ~= 0 then
					local var_377_23 = manager.audio:GetVoiceLength("story_v_side_new_1101104", "1101104093", "story_v_side_new_1101104.awb") / 1000

					if var_377_23 + var_377_15 > arg_374_1.duration_ then
						arg_374_1.duration_ = var_377_23 + var_377_15
					end

					if var_377_18.prefab_name ~= "" and arg_374_1.actors_[var_377_18.prefab_name] ~= nil then
						local var_377_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_374_1.actors_[var_377_18.prefab_name].transform, "story_v_side_new_1101104", "1101104093", "story_v_side_new_1101104.awb")

						arg_374_1:RecordAudio("1101104093", var_377_24)
						arg_374_1:RecordAudio("1101104093", var_377_24)
					else
						arg_374_1:AudioAction("play", "voice", "story_v_side_new_1101104", "1101104093", "story_v_side_new_1101104.awb")
					end

					arg_374_1:RecordHistoryTalkVoice("story_v_side_new_1101104", "1101104093", "story_v_side_new_1101104.awb")
				end

				arg_374_1:RecordContent(arg_374_1.text_.text)
			end

			local var_377_25 = math.max(var_377_16, arg_374_1.talkMaxDuration)

			if var_377_15 <= arg_374_1.time_ and arg_374_1.time_ < var_377_15 + var_377_25 then
				arg_374_1.typewritter.percent = (arg_374_1.time_ - var_377_15) / var_377_25

				arg_374_1.typewritter:SetDirty()
			end

			if arg_374_1.time_ >= var_377_15 + var_377_25 and arg_374_1.time_ < var_377_15 + var_377_25 + arg_377_0 then
				arg_374_1.typewritter.percent = 1

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(true)
			end
		end

		arg_374_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "111101ui_story",
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
	Play1101104094 = function(arg_378_0, arg_378_1)
		arg_378_1.time_ = 0
		arg_378_1.frameCnt_ = 0
		arg_378_1.state_ = "playing"
		arg_378_1.curTalkId_ = 1101104094
		arg_378_1.duration_ = 5

		SetActive(arg_378_1.tipsGo_, false)

		function arg_378_1.onSingleLineFinish_()
			arg_378_1.onSingleLineUpdate_ = nil
			arg_378_1.onSingleLineFinish_ = nil
			arg_378_1.state_ = "waiting"
		end

		function arg_378_1.playNext_(arg_380_0)
			if arg_380_0 == 1 then
				arg_378_0:Play1101104095(arg_378_1)
			end
		end

		function arg_378_1.onSingleLineUpdate_(arg_381_0)
			local var_381_0 = arg_378_1.actors_["111101ui_story"]
			local var_381_1 = 0

			if var_381_1 < arg_378_1.time_ and arg_378_1.time_ <= var_381_1 + arg_381_0 and not isNil(var_381_0) and arg_378_1.var_.characterEffect111101ui_story == nil then
				arg_378_1.var_.characterEffect111101ui_story = var_381_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_381_2 = 0.200000002980232

			if var_381_1 <= arg_378_1.time_ and arg_378_1.time_ < var_381_1 + var_381_2 and not isNil(var_381_0) then
				local var_381_3 = (arg_378_1.time_ - var_381_1) / var_381_2

				if arg_378_1.var_.characterEffect111101ui_story and not isNil(var_381_0) then
					local var_381_4 = Mathf.Lerp(0, 0.5, var_381_3)

					arg_378_1.var_.characterEffect111101ui_story.fillFlat = true
					arg_378_1.var_.characterEffect111101ui_story.fillRatio = var_381_4
				end
			end

			if arg_378_1.time_ >= var_381_1 + var_381_2 and arg_378_1.time_ < var_381_1 + var_381_2 + arg_381_0 and not isNil(var_381_0) and arg_378_1.var_.characterEffect111101ui_story then
				local var_381_5 = 0.5

				arg_378_1.var_.characterEffect111101ui_story.fillFlat = true
				arg_378_1.var_.characterEffect111101ui_story.fillRatio = var_381_5
			end

			local var_381_6 = 0
			local var_381_7 = 0.725

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

				arg_378_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_378_1.callingController_:SetSelectedState("normal")

				arg_378_1.keyicon_.color = Color.New(1, 1, 1)
				arg_378_1.icon_.color = Color.New(1, 1, 1)

				local var_381_9 = arg_378_1:GetWordFromCfg(1101104094)
				local var_381_10 = arg_378_1:FormatText(var_381_9.content)

				arg_378_1.text_.text = var_381_10

				LuaForUtil.ClearLinePrefixSymbol(arg_378_1.text_)

				local var_381_11 = 29
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
	Play1101104095 = function(arg_382_0, arg_382_1)
		arg_382_1.time_ = 0
		arg_382_1.frameCnt_ = 0
		arg_382_1.state_ = "playing"
		arg_382_1.curTalkId_ = 1101104095
		arg_382_1.duration_ = 8.73

		local var_382_0 = {
			zh = 4.8,
			ja = 8.733
		}
		local var_382_1 = manager.audio:GetLocalizationFlag()

		if var_382_0[var_382_1] ~= nil then
			arg_382_1.duration_ = var_382_0[var_382_1]
		end

		SetActive(arg_382_1.tipsGo_, false)

		function arg_382_1.onSingleLineFinish_()
			arg_382_1.onSingleLineUpdate_ = nil
			arg_382_1.onSingleLineFinish_ = nil
			arg_382_1.state_ = "waiting"
		end

		function arg_382_1.playNext_(arg_384_0)
			if arg_384_0 == 1 then
				arg_382_0:Play1101104096(arg_382_1)
			end
		end

		function arg_382_1.onSingleLineUpdate_(arg_385_0)
			local var_385_0 = arg_382_1.actors_["111101ui_story"].transform
			local var_385_1 = 0

			if var_385_1 < arg_382_1.time_ and arg_382_1.time_ <= var_385_1 + arg_385_0 then
				arg_382_1.var_.moveOldPos111101ui_story = var_385_0.localPosition
			end

			local var_385_2 = 0.001

			if var_385_1 <= arg_382_1.time_ and arg_382_1.time_ < var_385_1 + var_385_2 then
				local var_385_3 = (arg_382_1.time_ - var_385_1) / var_385_2
				local var_385_4 = Vector3.New(0, -0.83, -6)

				var_385_0.localPosition = Vector3.Lerp(arg_382_1.var_.moveOldPos111101ui_story, var_385_4, var_385_3)

				local var_385_5 = manager.ui.mainCamera.transform.position - var_385_0.position

				var_385_0.forward = Vector3.New(var_385_5.x, var_385_5.y, var_385_5.z)

				local var_385_6 = var_385_0.localEulerAngles

				var_385_6.z = 0
				var_385_6.x = 0
				var_385_0.localEulerAngles = var_385_6
			end

			if arg_382_1.time_ >= var_385_1 + var_385_2 and arg_382_1.time_ < var_385_1 + var_385_2 + arg_385_0 then
				var_385_0.localPosition = Vector3.New(0, -0.83, -6)

				local var_385_7 = manager.ui.mainCamera.transform.position - var_385_0.position

				var_385_0.forward = Vector3.New(var_385_7.x, var_385_7.y, var_385_7.z)

				local var_385_8 = var_385_0.localEulerAngles

				var_385_8.z = 0
				var_385_8.x = 0
				var_385_0.localEulerAngles = var_385_8
			end

			local var_385_9 = arg_382_1.actors_["111101ui_story"]
			local var_385_10 = 0

			if var_385_10 < arg_382_1.time_ and arg_382_1.time_ <= var_385_10 + arg_385_0 and not isNil(var_385_9) and arg_382_1.var_.characterEffect111101ui_story == nil then
				arg_382_1.var_.characterEffect111101ui_story = var_385_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_385_11 = 0.200000002980232

			if var_385_10 <= arg_382_1.time_ and arg_382_1.time_ < var_385_10 + var_385_11 and not isNil(var_385_9) then
				local var_385_12 = (arg_382_1.time_ - var_385_10) / var_385_11

				if arg_382_1.var_.characterEffect111101ui_story and not isNil(var_385_9) then
					arg_382_1.var_.characterEffect111101ui_story.fillFlat = false
				end
			end

			if arg_382_1.time_ >= var_385_10 + var_385_11 and arg_382_1.time_ < var_385_10 + var_385_11 + arg_385_0 and not isNil(var_385_9) and arg_382_1.var_.characterEffect111101ui_story then
				arg_382_1.var_.characterEffect111101ui_story.fillFlat = false
			end

			local var_385_13 = 0

			if var_385_13 < arg_382_1.time_ and arg_382_1.time_ <= var_385_13 + arg_385_0 then
				arg_382_1:PlayTimeline("111101ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action2_1")
			end

			local var_385_14 = 0
			local var_385_15 = 0.525

			if var_385_14 < arg_382_1.time_ and arg_382_1.time_ <= var_385_14 + arg_385_0 then
				arg_382_1.talkMaxDuration = 0
				arg_382_1.dialogCg_.alpha = 1

				arg_382_1.dialog_:SetActive(true)
				SetActive(arg_382_1.leftNameGo_, true)

				local var_385_16 = arg_382_1:FormatText(StoryNameCfg[67].name)

				arg_382_1.leftNameTxt_.text = var_385_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_382_1.leftNameTxt_.transform)

				arg_382_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_382_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_382_1:RecordName(arg_382_1.leftNameTxt_.text)
				SetActive(arg_382_1.iconTrs_.gameObject, false)
				arg_382_1.callingController_:SetSelectedState("normal")

				local var_385_17 = arg_382_1:GetWordFromCfg(1101104095)
				local var_385_18 = arg_382_1:FormatText(var_385_17.content)

				arg_382_1.text_.text = var_385_18

				LuaForUtil.ClearLinePrefixSymbol(arg_382_1.text_)

				local var_385_19 = 21
				local var_385_20 = utf8.len(var_385_18)
				local var_385_21 = var_385_19 <= 0 and var_385_15 or var_385_15 * (var_385_20 / var_385_19)

				if var_385_21 > 0 and var_385_15 < var_385_21 then
					arg_382_1.talkMaxDuration = var_385_21

					if var_385_21 + var_385_14 > arg_382_1.duration_ then
						arg_382_1.duration_ = var_385_21 + var_385_14
					end
				end

				arg_382_1.text_.text = var_385_18
				arg_382_1.typewritter.percent = 0

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101104", "1101104095", "story_v_side_new_1101104.awb") ~= 0 then
					local var_385_22 = manager.audio:GetVoiceLength("story_v_side_new_1101104", "1101104095", "story_v_side_new_1101104.awb") / 1000

					if var_385_22 + var_385_14 > arg_382_1.duration_ then
						arg_382_1.duration_ = var_385_22 + var_385_14
					end

					if var_385_17.prefab_name ~= "" and arg_382_1.actors_[var_385_17.prefab_name] ~= nil then
						local var_385_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_382_1.actors_[var_385_17.prefab_name].transform, "story_v_side_new_1101104", "1101104095", "story_v_side_new_1101104.awb")

						arg_382_1:RecordAudio("1101104095", var_385_23)
						arg_382_1:RecordAudio("1101104095", var_385_23)
					else
						arg_382_1:AudioAction("play", "voice", "story_v_side_new_1101104", "1101104095", "story_v_side_new_1101104.awb")
					end

					arg_382_1:RecordHistoryTalkVoice("story_v_side_new_1101104", "1101104095", "story_v_side_new_1101104.awb")
				end

				arg_382_1:RecordContent(arg_382_1.text_.text)
			end

			local var_385_24 = math.max(var_385_15, arg_382_1.talkMaxDuration)

			if var_385_14 <= arg_382_1.time_ and arg_382_1.time_ < var_385_14 + var_385_24 then
				arg_382_1.typewritter.percent = (arg_382_1.time_ - var_385_14) / var_385_24

				arg_382_1.typewritter:SetDirty()
			end

			if arg_382_1.time_ >= var_385_14 + var_385_24 and arg_382_1.time_ < var_385_14 + var_385_24 + arg_385_0 then
				arg_382_1.typewritter.percent = 1

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(true)
			end
		end

		arg_382_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "111101ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_382_1:InitPlayNodeList()
	end,
	Play1101104096 = function(arg_386_0, arg_386_1)
		arg_386_1.time_ = 0
		arg_386_1.frameCnt_ = 0
		arg_386_1.state_ = "playing"
		arg_386_1.curTalkId_ = 1101104096
		arg_386_1.duration_ = 7.7

		local var_386_0 = {
			zh = 5.366,
			ja = 7.7
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
				arg_386_0:Play1101104097(arg_386_1)
			end
		end

		function arg_386_1.onSingleLineUpdate_(arg_389_0)
			local var_389_0 = arg_386_1.actors_["111101ui_story"].transform
			local var_389_1 = 0

			if var_389_1 < arg_386_1.time_ and arg_386_1.time_ <= var_389_1 + arg_389_0 then
				arg_386_1.var_.moveOldPos111101ui_story = var_389_0.localPosition
			end

			local var_389_2 = 0.001

			if var_389_1 <= arg_386_1.time_ and arg_386_1.time_ < var_389_1 + var_389_2 then
				local var_389_3 = (arg_386_1.time_ - var_389_1) / var_389_2
				local var_389_4 = Vector3.New(0, -0.83, -6)

				var_389_0.localPosition = Vector3.Lerp(arg_386_1.var_.moveOldPos111101ui_story, var_389_4, var_389_3)

				local var_389_5 = manager.ui.mainCamera.transform.position - var_389_0.position

				var_389_0.forward = Vector3.New(var_389_5.x, var_389_5.y, var_389_5.z)

				local var_389_6 = var_389_0.localEulerAngles

				var_389_6.z = 0
				var_389_6.x = 0
				var_389_0.localEulerAngles = var_389_6
			end

			if arg_386_1.time_ >= var_389_1 + var_389_2 and arg_386_1.time_ < var_389_1 + var_389_2 + arg_389_0 then
				var_389_0.localPosition = Vector3.New(0, -0.83, -6)

				local var_389_7 = manager.ui.mainCamera.transform.position - var_389_0.position

				var_389_0.forward = Vector3.New(var_389_7.x, var_389_7.y, var_389_7.z)

				local var_389_8 = var_389_0.localEulerAngles

				var_389_8.z = 0
				var_389_8.x = 0
				var_389_0.localEulerAngles = var_389_8
			end

			local var_389_9 = arg_386_1.actors_["111101ui_story"]
			local var_389_10 = 0

			if var_389_10 < arg_386_1.time_ and arg_386_1.time_ <= var_389_10 + arg_389_0 and not isNil(var_389_9) and arg_386_1.var_.characterEffect111101ui_story == nil then
				arg_386_1.var_.characterEffect111101ui_story = var_389_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_389_11 = 0.200000002980232

			if var_389_10 <= arg_386_1.time_ and arg_386_1.time_ < var_389_10 + var_389_11 and not isNil(var_389_9) then
				local var_389_12 = (arg_386_1.time_ - var_389_10) / var_389_11

				if arg_386_1.var_.characterEffect111101ui_story and not isNil(var_389_9) then
					arg_386_1.var_.characterEffect111101ui_story.fillFlat = false
				end
			end

			if arg_386_1.time_ >= var_389_10 + var_389_11 and arg_386_1.time_ < var_389_10 + var_389_11 + arg_389_0 and not isNil(var_389_9) and arg_386_1.var_.characterEffect111101ui_story then
				arg_386_1.var_.characterEffect111101ui_story.fillFlat = false
			end

			local var_389_13 = 0

			if var_389_13 < arg_386_1.time_ and arg_386_1.time_ <= var_389_13 + arg_389_0 then
				arg_386_1:PlayTimeline("111101ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_389_14 = 0
			local var_389_15 = 0.65

			if var_389_14 < arg_386_1.time_ and arg_386_1.time_ <= var_389_14 + arg_389_0 then
				arg_386_1.talkMaxDuration = 0
				arg_386_1.dialogCg_.alpha = 1

				arg_386_1.dialog_:SetActive(true)
				SetActive(arg_386_1.leftNameGo_, true)

				local var_389_16 = arg_386_1:FormatText(StoryNameCfg[67].name)

				arg_386_1.leftNameTxt_.text = var_389_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_386_1.leftNameTxt_.transform)

				arg_386_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_386_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_386_1:RecordName(arg_386_1.leftNameTxt_.text)
				SetActive(arg_386_1.iconTrs_.gameObject, false)
				arg_386_1.callingController_:SetSelectedState("normal")

				local var_389_17 = arg_386_1:GetWordFromCfg(1101104096)
				local var_389_18 = arg_386_1:FormatText(var_389_17.content)

				arg_386_1.text_.text = var_389_18

				LuaForUtil.ClearLinePrefixSymbol(arg_386_1.text_)

				local var_389_19 = 26
				local var_389_20 = utf8.len(var_389_18)
				local var_389_21 = var_389_19 <= 0 and var_389_15 or var_389_15 * (var_389_20 / var_389_19)

				if var_389_21 > 0 and var_389_15 < var_389_21 then
					arg_386_1.talkMaxDuration = var_389_21

					if var_389_21 + var_389_14 > arg_386_1.duration_ then
						arg_386_1.duration_ = var_389_21 + var_389_14
					end
				end

				arg_386_1.text_.text = var_389_18
				arg_386_1.typewritter.percent = 0

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101104", "1101104096", "story_v_side_new_1101104.awb") ~= 0 then
					local var_389_22 = manager.audio:GetVoiceLength("story_v_side_new_1101104", "1101104096", "story_v_side_new_1101104.awb") / 1000

					if var_389_22 + var_389_14 > arg_386_1.duration_ then
						arg_386_1.duration_ = var_389_22 + var_389_14
					end

					if var_389_17.prefab_name ~= "" and arg_386_1.actors_[var_389_17.prefab_name] ~= nil then
						local var_389_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_386_1.actors_[var_389_17.prefab_name].transform, "story_v_side_new_1101104", "1101104096", "story_v_side_new_1101104.awb")

						arg_386_1:RecordAudio("1101104096", var_389_23)
						arg_386_1:RecordAudio("1101104096", var_389_23)
					else
						arg_386_1:AudioAction("play", "voice", "story_v_side_new_1101104", "1101104096", "story_v_side_new_1101104.awb")
					end

					arg_386_1:RecordHistoryTalkVoice("story_v_side_new_1101104", "1101104096", "story_v_side_new_1101104.awb")
				end

				arg_386_1:RecordContent(arg_386_1.text_.text)
			end

			local var_389_24 = math.max(var_389_15, arg_386_1.talkMaxDuration)

			if var_389_14 <= arg_386_1.time_ and arg_386_1.time_ < var_389_14 + var_389_24 then
				arg_386_1.typewritter.percent = (arg_386_1.time_ - var_389_14) / var_389_24

				arg_386_1.typewritter:SetDirty()
			end

			if arg_386_1.time_ >= var_389_14 + var_389_24 and arg_386_1.time_ < var_389_14 + var_389_24 + arg_389_0 then
				arg_386_1.typewritter.percent = 1

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(true)
			end
		end

		arg_386_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "111101ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_386_1:InitPlayNodeList()
	end,
	Play1101104097 = function(arg_390_0, arg_390_1)
		arg_390_1.time_ = 0
		arg_390_1.frameCnt_ = 0
		arg_390_1.state_ = "playing"
		arg_390_1.curTalkId_ = 1101104097
		arg_390_1.duration_ = 5

		SetActive(arg_390_1.tipsGo_, false)

		function arg_390_1.onSingleLineFinish_()
			arg_390_1.onSingleLineUpdate_ = nil
			arg_390_1.onSingleLineFinish_ = nil
			arg_390_1.state_ = "waiting"
		end

		function arg_390_1.playNext_(arg_392_0)
			if arg_392_0 == 1 then
				arg_390_0:Play1101104098(arg_390_1)
			end
		end

		function arg_390_1.onSingleLineUpdate_(arg_393_0)
			local var_393_0 = arg_390_1.actors_["111101ui_story"]
			local var_393_1 = 0

			if var_393_1 < arg_390_1.time_ and arg_390_1.time_ <= var_393_1 + arg_393_0 and not isNil(var_393_0) and arg_390_1.var_.characterEffect111101ui_story == nil then
				arg_390_1.var_.characterEffect111101ui_story = var_393_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_393_2 = 0.200000002980232

			if var_393_1 <= arg_390_1.time_ and arg_390_1.time_ < var_393_1 + var_393_2 and not isNil(var_393_0) then
				local var_393_3 = (arg_390_1.time_ - var_393_1) / var_393_2

				if arg_390_1.var_.characterEffect111101ui_story and not isNil(var_393_0) then
					local var_393_4 = Mathf.Lerp(0, 0.5, var_393_3)

					arg_390_1.var_.characterEffect111101ui_story.fillFlat = true
					arg_390_1.var_.characterEffect111101ui_story.fillRatio = var_393_4
				end
			end

			if arg_390_1.time_ >= var_393_1 + var_393_2 and arg_390_1.time_ < var_393_1 + var_393_2 + arg_393_0 and not isNil(var_393_0) and arg_390_1.var_.characterEffect111101ui_story then
				local var_393_5 = 0.5

				arg_390_1.var_.characterEffect111101ui_story.fillFlat = true
				arg_390_1.var_.characterEffect111101ui_story.fillRatio = var_393_5
			end

			local var_393_6 = 0
			local var_393_7 = 0.3

			if var_393_6 < arg_390_1.time_ and arg_390_1.time_ <= var_393_6 + arg_393_0 then
				arg_390_1.talkMaxDuration = 0
				arg_390_1.dialogCg_.alpha = 1

				arg_390_1.dialog_:SetActive(true)
				SetActive(arg_390_1.leftNameGo_, true)

				local var_393_8 = arg_390_1:FormatText(StoryNameCfg[7].name)

				arg_390_1.leftNameTxt_.text = var_393_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_390_1.leftNameTxt_.transform)

				arg_390_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_390_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_390_1:RecordName(arg_390_1.leftNameTxt_.text)
				SetActive(arg_390_1.iconTrs_.gameObject, true)
				arg_390_1.iconController_:SetSelectedState("hero")

				arg_390_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_390_1.callingController_:SetSelectedState("normal")

				arg_390_1.keyicon_.color = Color.New(1, 1, 1)
				arg_390_1.icon_.color = Color.New(1, 1, 1)

				local var_393_9 = arg_390_1:GetWordFromCfg(1101104097)
				local var_393_10 = arg_390_1:FormatText(var_393_9.content)

				arg_390_1.text_.text = var_393_10

				LuaForUtil.ClearLinePrefixSymbol(arg_390_1.text_)

				local var_393_11 = 12
				local var_393_12 = utf8.len(var_393_10)
				local var_393_13 = var_393_11 <= 0 and var_393_7 or var_393_7 * (var_393_12 / var_393_11)

				if var_393_13 > 0 and var_393_7 < var_393_13 then
					arg_390_1.talkMaxDuration = var_393_13

					if var_393_13 + var_393_6 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_13 + var_393_6
					end
				end

				arg_390_1.text_.text = var_393_10
				arg_390_1.typewritter.percent = 0

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(false)
				arg_390_1:RecordContent(arg_390_1.text_.text)
			end

			local var_393_14 = math.max(var_393_7, arg_390_1.talkMaxDuration)

			if var_393_6 <= arg_390_1.time_ and arg_390_1.time_ < var_393_6 + var_393_14 then
				arg_390_1.typewritter.percent = (arg_390_1.time_ - var_393_6) / var_393_14

				arg_390_1.typewritter:SetDirty()
			end

			if arg_390_1.time_ >= var_393_6 + var_393_14 and arg_390_1.time_ < var_393_6 + var_393_14 + arg_393_0 then
				arg_390_1.typewritter.percent = 1

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(true)
			end
		end

		arg_390_1.nodeConfigList_ = {}

		arg_390_1:InitPlayNodeList()
	end,
	Play1101104098 = function(arg_394_0, arg_394_1)
		arg_394_1.time_ = 0
		arg_394_1.frameCnt_ = 0
		arg_394_1.state_ = "playing"
		arg_394_1.curTalkId_ = 1101104098
		arg_394_1.duration_ = 5

		SetActive(arg_394_1.tipsGo_, false)

		function arg_394_1.onSingleLineFinish_()
			arg_394_1.onSingleLineUpdate_ = nil
			arg_394_1.onSingleLineFinish_ = nil
			arg_394_1.state_ = "waiting"
		end

		function arg_394_1.playNext_(arg_396_0)
			if arg_396_0 == 1 then
				arg_394_0:Play1101104099(arg_394_1)
			end
		end

		function arg_394_1.onSingleLineUpdate_(arg_397_0)
			local var_397_0 = 0
			local var_397_1 = 0.9

			if var_397_0 < arg_394_1.time_ and arg_394_1.time_ <= var_397_0 + arg_397_0 then
				arg_394_1.talkMaxDuration = 0
				arg_394_1.dialogCg_.alpha = 1

				arg_394_1.dialog_:SetActive(true)
				SetActive(arg_394_1.leftNameGo_, false)

				arg_394_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_394_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_394_1:RecordName(arg_394_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_394_1.iconTrs_.gameObject, false)
				arg_394_1.callingController_:SetSelectedState("normal")

				local var_397_2 = arg_394_1:GetWordFromCfg(1101104098)
				local var_397_3 = arg_394_1:FormatText(var_397_2.content)

				arg_394_1.text_.text = var_397_3

				LuaForUtil.ClearLinePrefixSymbol(arg_394_1.text_)

				local var_397_4 = 36
				local var_397_5 = utf8.len(var_397_3)
				local var_397_6 = var_397_4 <= 0 and var_397_1 or var_397_1 * (var_397_5 / var_397_4)

				if var_397_6 > 0 and var_397_1 < var_397_6 then
					arg_394_1.talkMaxDuration = var_397_6

					if var_397_6 + var_397_0 > arg_394_1.duration_ then
						arg_394_1.duration_ = var_397_6 + var_397_0
					end
				end

				arg_394_1.text_.text = var_397_3
				arg_394_1.typewritter.percent = 0

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(false)
				arg_394_1:RecordContent(arg_394_1.text_.text)
			end

			local var_397_7 = math.max(var_397_1, arg_394_1.talkMaxDuration)

			if var_397_0 <= arg_394_1.time_ and arg_394_1.time_ < var_397_0 + var_397_7 then
				arg_394_1.typewritter.percent = (arg_394_1.time_ - var_397_0) / var_397_7

				arg_394_1.typewritter:SetDirty()
			end

			if arg_394_1.time_ >= var_397_0 + var_397_7 and arg_394_1.time_ < var_397_0 + var_397_7 + arg_397_0 then
				arg_394_1.typewritter.percent = 1

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(true)
			end
		end

		arg_394_1.nodeConfigList_ = {}

		arg_394_1:InitPlayNodeList()
	end,
	Play1101104099 = function(arg_398_0, arg_398_1)
		arg_398_1.time_ = 0
		arg_398_1.frameCnt_ = 0
		arg_398_1.state_ = "playing"
		arg_398_1.curTalkId_ = 1101104099
		arg_398_1.duration_ = 5

		SetActive(arg_398_1.tipsGo_, false)

		function arg_398_1.onSingleLineFinish_()
			arg_398_1.onSingleLineUpdate_ = nil
			arg_398_1.onSingleLineFinish_ = nil
			arg_398_1.state_ = "waiting"
		end

		function arg_398_1.playNext_(arg_400_0)
			if arg_400_0 == 1 then
				arg_398_0:Play1101104100(arg_398_1)
			end
		end

		function arg_398_1.onSingleLineUpdate_(arg_401_0)
			local var_401_0 = 0
			local var_401_1 = 1.175

			if var_401_0 < arg_398_1.time_ and arg_398_1.time_ <= var_401_0 + arg_401_0 then
				arg_398_1.talkMaxDuration = 0
				arg_398_1.dialogCg_.alpha = 1

				arg_398_1.dialog_:SetActive(true)
				SetActive(arg_398_1.leftNameGo_, true)

				local var_401_2 = arg_398_1:FormatText(StoryNameCfg[7].name)

				arg_398_1.leftNameTxt_.text = var_401_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_398_1.leftNameTxt_.transform)

				arg_398_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_398_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_398_1:RecordName(arg_398_1.leftNameTxt_.text)
				SetActive(arg_398_1.iconTrs_.gameObject, true)
				arg_398_1.iconController_:SetSelectedState("hero")

				arg_398_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_398_1.callingController_:SetSelectedState("normal")

				arg_398_1.keyicon_.color = Color.New(1, 1, 1)
				arg_398_1.icon_.color = Color.New(1, 1, 1)

				local var_401_3 = arg_398_1:GetWordFromCfg(1101104099)
				local var_401_4 = arg_398_1:FormatText(var_401_3.content)

				arg_398_1.text_.text = var_401_4

				LuaForUtil.ClearLinePrefixSymbol(arg_398_1.text_)

				local var_401_5 = 47
				local var_401_6 = utf8.len(var_401_4)
				local var_401_7 = var_401_5 <= 0 and var_401_1 or var_401_1 * (var_401_6 / var_401_5)

				if var_401_7 > 0 and var_401_1 < var_401_7 then
					arg_398_1.talkMaxDuration = var_401_7

					if var_401_7 + var_401_0 > arg_398_1.duration_ then
						arg_398_1.duration_ = var_401_7 + var_401_0
					end
				end

				arg_398_1.text_.text = var_401_4
				arg_398_1.typewritter.percent = 0

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(false)
				arg_398_1:RecordContent(arg_398_1.text_.text)
			end

			local var_401_8 = math.max(var_401_1, arg_398_1.talkMaxDuration)

			if var_401_0 <= arg_398_1.time_ and arg_398_1.time_ < var_401_0 + var_401_8 then
				arg_398_1.typewritter.percent = (arg_398_1.time_ - var_401_0) / var_401_8

				arg_398_1.typewritter:SetDirty()
			end

			if arg_398_1.time_ >= var_401_0 + var_401_8 and arg_398_1.time_ < var_401_0 + var_401_8 + arg_401_0 then
				arg_398_1.typewritter.percent = 1

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(true)
			end
		end

		arg_398_1.nodeConfigList_ = {}

		arg_398_1:InitPlayNodeList()
	end,
	Play1101104100 = function(arg_402_0, arg_402_1)
		arg_402_1.time_ = 0
		arg_402_1.frameCnt_ = 0
		arg_402_1.state_ = "playing"
		arg_402_1.curTalkId_ = 1101104100
		arg_402_1.duration_ = 7.37

		local var_402_0 = {
			zh = 7.366,
			ja = 6.866
		}
		local var_402_1 = manager.audio:GetLocalizationFlag()

		if var_402_0[var_402_1] ~= nil then
			arg_402_1.duration_ = var_402_0[var_402_1]
		end

		SetActive(arg_402_1.tipsGo_, false)

		function arg_402_1.onSingleLineFinish_()
			arg_402_1.onSingleLineUpdate_ = nil
			arg_402_1.onSingleLineFinish_ = nil
			arg_402_1.state_ = "waiting"
		end

		function arg_402_1.playNext_(arg_404_0)
			if arg_404_0 == 1 then
				arg_402_0:Play1101104101(arg_402_1)
			end
		end

		function arg_402_1.onSingleLineUpdate_(arg_405_0)
			local var_405_0 = arg_402_1.actors_["111101ui_story"].transform
			local var_405_1 = 0

			if var_405_1 < arg_402_1.time_ and arg_402_1.time_ <= var_405_1 + arg_405_0 then
				arg_402_1.var_.moveOldPos111101ui_story = var_405_0.localPosition
			end

			local var_405_2 = 0.001

			if var_405_1 <= arg_402_1.time_ and arg_402_1.time_ < var_405_1 + var_405_2 then
				local var_405_3 = (arg_402_1.time_ - var_405_1) / var_405_2
				local var_405_4 = Vector3.New(0, -0.83, -6)

				var_405_0.localPosition = Vector3.Lerp(arg_402_1.var_.moveOldPos111101ui_story, var_405_4, var_405_3)

				local var_405_5 = manager.ui.mainCamera.transform.position - var_405_0.position

				var_405_0.forward = Vector3.New(var_405_5.x, var_405_5.y, var_405_5.z)

				local var_405_6 = var_405_0.localEulerAngles

				var_405_6.z = 0
				var_405_6.x = 0
				var_405_0.localEulerAngles = var_405_6
			end

			if arg_402_1.time_ >= var_405_1 + var_405_2 and arg_402_1.time_ < var_405_1 + var_405_2 + arg_405_0 then
				var_405_0.localPosition = Vector3.New(0, -0.83, -6)

				local var_405_7 = manager.ui.mainCamera.transform.position - var_405_0.position

				var_405_0.forward = Vector3.New(var_405_7.x, var_405_7.y, var_405_7.z)

				local var_405_8 = var_405_0.localEulerAngles

				var_405_8.z = 0
				var_405_8.x = 0
				var_405_0.localEulerAngles = var_405_8
			end

			local var_405_9 = arg_402_1.actors_["111101ui_story"]
			local var_405_10 = 0

			if var_405_10 < arg_402_1.time_ and arg_402_1.time_ <= var_405_10 + arg_405_0 and not isNil(var_405_9) and arg_402_1.var_.characterEffect111101ui_story == nil then
				arg_402_1.var_.characterEffect111101ui_story = var_405_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_405_11 = 0.200000002980232

			if var_405_10 <= arg_402_1.time_ and arg_402_1.time_ < var_405_10 + var_405_11 and not isNil(var_405_9) then
				local var_405_12 = (arg_402_1.time_ - var_405_10) / var_405_11

				if arg_402_1.var_.characterEffect111101ui_story and not isNil(var_405_9) then
					arg_402_1.var_.characterEffect111101ui_story.fillFlat = false
				end
			end

			if arg_402_1.time_ >= var_405_10 + var_405_11 and arg_402_1.time_ < var_405_10 + var_405_11 + arg_405_0 and not isNil(var_405_9) and arg_402_1.var_.characterEffect111101ui_story then
				arg_402_1.var_.characterEffect111101ui_story.fillFlat = false
			end

			local var_405_13 = 0

			if var_405_13 < arg_402_1.time_ and arg_402_1.time_ <= var_405_13 + arg_405_0 then
				arg_402_1:PlayTimeline("111101ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action2_2")
			end

			local var_405_14 = 0

			if var_405_14 < arg_402_1.time_ and arg_402_1.time_ <= var_405_14 + arg_405_0 then
				arg_402_1:PlayTimeline("111101ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_405_15 = 0
			local var_405_16 = 0.625

			if var_405_15 < arg_402_1.time_ and arg_402_1.time_ <= var_405_15 + arg_405_0 then
				arg_402_1.talkMaxDuration = 0
				arg_402_1.dialogCg_.alpha = 1

				arg_402_1.dialog_:SetActive(true)
				SetActive(arg_402_1.leftNameGo_, true)

				local var_405_17 = arg_402_1:FormatText(StoryNameCfg[67].name)

				arg_402_1.leftNameTxt_.text = var_405_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_402_1.leftNameTxt_.transform)

				arg_402_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_402_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_402_1:RecordName(arg_402_1.leftNameTxt_.text)
				SetActive(arg_402_1.iconTrs_.gameObject, false)
				arg_402_1.callingController_:SetSelectedState("normal")

				local var_405_18 = arg_402_1:GetWordFromCfg(1101104100)
				local var_405_19 = arg_402_1:FormatText(var_405_18.content)

				arg_402_1.text_.text = var_405_19

				LuaForUtil.ClearLinePrefixSymbol(arg_402_1.text_)

				local var_405_20 = 25
				local var_405_21 = utf8.len(var_405_19)
				local var_405_22 = var_405_20 <= 0 and var_405_16 or var_405_16 * (var_405_21 / var_405_20)

				if var_405_22 > 0 and var_405_16 < var_405_22 then
					arg_402_1.talkMaxDuration = var_405_22

					if var_405_22 + var_405_15 > arg_402_1.duration_ then
						arg_402_1.duration_ = var_405_22 + var_405_15
					end
				end

				arg_402_1.text_.text = var_405_19
				arg_402_1.typewritter.percent = 0

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101104", "1101104100", "story_v_side_new_1101104.awb") ~= 0 then
					local var_405_23 = manager.audio:GetVoiceLength("story_v_side_new_1101104", "1101104100", "story_v_side_new_1101104.awb") / 1000

					if var_405_23 + var_405_15 > arg_402_1.duration_ then
						arg_402_1.duration_ = var_405_23 + var_405_15
					end

					if var_405_18.prefab_name ~= "" and arg_402_1.actors_[var_405_18.prefab_name] ~= nil then
						local var_405_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_402_1.actors_[var_405_18.prefab_name].transform, "story_v_side_new_1101104", "1101104100", "story_v_side_new_1101104.awb")

						arg_402_1:RecordAudio("1101104100", var_405_24)
						arg_402_1:RecordAudio("1101104100", var_405_24)
					else
						arg_402_1:AudioAction("play", "voice", "story_v_side_new_1101104", "1101104100", "story_v_side_new_1101104.awb")
					end

					arg_402_1:RecordHistoryTalkVoice("story_v_side_new_1101104", "1101104100", "story_v_side_new_1101104.awb")
				end

				arg_402_1:RecordContent(arg_402_1.text_.text)
			end

			local var_405_25 = math.max(var_405_16, arg_402_1.talkMaxDuration)

			if var_405_15 <= arg_402_1.time_ and arg_402_1.time_ < var_405_15 + var_405_25 then
				arg_402_1.typewritter.percent = (arg_402_1.time_ - var_405_15) / var_405_25

				arg_402_1.typewritter:SetDirty()
			end

			if arg_402_1.time_ >= var_405_15 + var_405_25 and arg_402_1.time_ < var_405_15 + var_405_25 + arg_405_0 then
				arg_402_1.typewritter.percent = 1

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(true)
			end
		end

		arg_402_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "111101ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_402_1:InitPlayNodeList()
	end,
	Play1101104101 = function(arg_406_0, arg_406_1)
		arg_406_1.time_ = 0
		arg_406_1.frameCnt_ = 0
		arg_406_1.state_ = "playing"
		arg_406_1.curTalkId_ = 1101104101
		arg_406_1.duration_ = 5

		SetActive(arg_406_1.tipsGo_, false)

		function arg_406_1.onSingleLineFinish_()
			arg_406_1.onSingleLineUpdate_ = nil
			arg_406_1.onSingleLineFinish_ = nil
			arg_406_1.state_ = "waiting"
		end

		function arg_406_1.playNext_(arg_408_0)
			if arg_408_0 == 1 then
				arg_406_0:Play1101104102(arg_406_1)
			end
		end

		function arg_406_1.onSingleLineUpdate_(arg_409_0)
			local var_409_0 = arg_406_1.actors_["111101ui_story"]
			local var_409_1 = 0

			if var_409_1 < arg_406_1.time_ and arg_406_1.time_ <= var_409_1 + arg_409_0 and not isNil(var_409_0) and arg_406_1.var_.characterEffect111101ui_story == nil then
				arg_406_1.var_.characterEffect111101ui_story = var_409_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_409_2 = 0.200000002980232

			if var_409_1 <= arg_406_1.time_ and arg_406_1.time_ < var_409_1 + var_409_2 and not isNil(var_409_0) then
				local var_409_3 = (arg_406_1.time_ - var_409_1) / var_409_2

				if arg_406_1.var_.characterEffect111101ui_story and not isNil(var_409_0) then
					local var_409_4 = Mathf.Lerp(0, 0.5, var_409_3)

					arg_406_1.var_.characterEffect111101ui_story.fillFlat = true
					arg_406_1.var_.characterEffect111101ui_story.fillRatio = var_409_4
				end
			end

			if arg_406_1.time_ >= var_409_1 + var_409_2 and arg_406_1.time_ < var_409_1 + var_409_2 + arg_409_0 and not isNil(var_409_0) and arg_406_1.var_.characterEffect111101ui_story then
				local var_409_5 = 0.5

				arg_406_1.var_.characterEffect111101ui_story.fillFlat = true
				arg_406_1.var_.characterEffect111101ui_story.fillRatio = var_409_5
			end

			local var_409_6 = 0
			local var_409_7 = 0.175

			if var_409_6 < arg_406_1.time_ and arg_406_1.time_ <= var_409_6 + arg_409_0 then
				arg_406_1.talkMaxDuration = 0
				arg_406_1.dialogCg_.alpha = 1

				arg_406_1.dialog_:SetActive(true)
				SetActive(arg_406_1.leftNameGo_, true)

				local var_409_8 = arg_406_1:FormatText(StoryNameCfg[7].name)

				arg_406_1.leftNameTxt_.text = var_409_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_406_1.leftNameTxt_.transform)

				arg_406_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_406_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_406_1:RecordName(arg_406_1.leftNameTxt_.text)
				SetActive(arg_406_1.iconTrs_.gameObject, true)
				arg_406_1.iconController_:SetSelectedState("hero")

				arg_406_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_406_1.callingController_:SetSelectedState("normal")

				arg_406_1.keyicon_.color = Color.New(1, 1, 1)
				arg_406_1.icon_.color = Color.New(1, 1, 1)

				local var_409_9 = arg_406_1:GetWordFromCfg(1101104101)
				local var_409_10 = arg_406_1:FormatText(var_409_9.content)

				arg_406_1.text_.text = var_409_10

				LuaForUtil.ClearLinePrefixSymbol(arg_406_1.text_)

				local var_409_11 = 7
				local var_409_12 = utf8.len(var_409_10)
				local var_409_13 = var_409_11 <= 0 and var_409_7 or var_409_7 * (var_409_12 / var_409_11)

				if var_409_13 > 0 and var_409_7 < var_409_13 then
					arg_406_1.talkMaxDuration = var_409_13

					if var_409_13 + var_409_6 > arg_406_1.duration_ then
						arg_406_1.duration_ = var_409_13 + var_409_6
					end
				end

				arg_406_1.text_.text = var_409_10
				arg_406_1.typewritter.percent = 0

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(false)
				arg_406_1:RecordContent(arg_406_1.text_.text)
			end

			local var_409_14 = math.max(var_409_7, arg_406_1.talkMaxDuration)

			if var_409_6 <= arg_406_1.time_ and arg_406_1.time_ < var_409_6 + var_409_14 then
				arg_406_1.typewritter.percent = (arg_406_1.time_ - var_409_6) / var_409_14

				arg_406_1.typewritter:SetDirty()
			end

			if arg_406_1.time_ >= var_409_6 + var_409_14 and arg_406_1.time_ < var_409_6 + var_409_14 + arg_409_0 then
				arg_406_1.typewritter.percent = 1

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(true)
			end
		end

		arg_406_1.nodeConfigList_ = {}

		arg_406_1:InitPlayNodeList()
	end,
	Play1101104102 = function(arg_410_0, arg_410_1)
		arg_410_1.time_ = 0
		arg_410_1.frameCnt_ = 0
		arg_410_1.state_ = "playing"
		arg_410_1.curTalkId_ = 1101104102
		arg_410_1.duration_ = 6.53

		local var_410_0 = {
			zh = 6.533,
			ja = 5.733
		}
		local var_410_1 = manager.audio:GetLocalizationFlag()

		if var_410_0[var_410_1] ~= nil then
			arg_410_1.duration_ = var_410_0[var_410_1]
		end

		SetActive(arg_410_1.tipsGo_, false)

		function arg_410_1.onSingleLineFinish_()
			arg_410_1.onSingleLineUpdate_ = nil
			arg_410_1.onSingleLineFinish_ = nil
			arg_410_1.state_ = "waiting"
		end

		function arg_410_1.playNext_(arg_412_0)
			if arg_412_0 == 1 then
				arg_410_0:Play1101104103(arg_410_1)
			end
		end

		function arg_410_1.onSingleLineUpdate_(arg_413_0)
			local var_413_0 = arg_410_1.actors_["111101ui_story"].transform
			local var_413_1 = 0

			if var_413_1 < arg_410_1.time_ and arg_410_1.time_ <= var_413_1 + arg_413_0 then
				arg_410_1.var_.moveOldPos111101ui_story = var_413_0.localPosition
			end

			local var_413_2 = 0.001

			if var_413_1 <= arg_410_1.time_ and arg_410_1.time_ < var_413_1 + var_413_2 then
				local var_413_3 = (arg_410_1.time_ - var_413_1) / var_413_2
				local var_413_4 = Vector3.New(0, -0.83, -6)

				var_413_0.localPosition = Vector3.Lerp(arg_410_1.var_.moveOldPos111101ui_story, var_413_4, var_413_3)

				local var_413_5 = manager.ui.mainCamera.transform.position - var_413_0.position

				var_413_0.forward = Vector3.New(var_413_5.x, var_413_5.y, var_413_5.z)

				local var_413_6 = var_413_0.localEulerAngles

				var_413_6.z = 0
				var_413_6.x = 0
				var_413_0.localEulerAngles = var_413_6
			end

			if arg_410_1.time_ >= var_413_1 + var_413_2 and arg_410_1.time_ < var_413_1 + var_413_2 + arg_413_0 then
				var_413_0.localPosition = Vector3.New(0, -0.83, -6)

				local var_413_7 = manager.ui.mainCamera.transform.position - var_413_0.position

				var_413_0.forward = Vector3.New(var_413_7.x, var_413_7.y, var_413_7.z)

				local var_413_8 = var_413_0.localEulerAngles

				var_413_8.z = 0
				var_413_8.x = 0
				var_413_0.localEulerAngles = var_413_8
			end

			local var_413_9 = arg_410_1.actors_["111101ui_story"]
			local var_413_10 = 0

			if var_413_10 < arg_410_1.time_ and arg_410_1.time_ <= var_413_10 + arg_413_0 and not isNil(var_413_9) and arg_410_1.var_.characterEffect111101ui_story == nil then
				arg_410_1.var_.characterEffect111101ui_story = var_413_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_413_11 = 0.200000002980232

			if var_413_10 <= arg_410_1.time_ and arg_410_1.time_ < var_413_10 + var_413_11 and not isNil(var_413_9) then
				local var_413_12 = (arg_410_1.time_ - var_413_10) / var_413_11

				if arg_410_1.var_.characterEffect111101ui_story and not isNil(var_413_9) then
					arg_410_1.var_.characterEffect111101ui_story.fillFlat = false
				end
			end

			if arg_410_1.time_ >= var_413_10 + var_413_11 and arg_410_1.time_ < var_413_10 + var_413_11 + arg_413_0 and not isNil(var_413_9) and arg_410_1.var_.characterEffect111101ui_story then
				arg_410_1.var_.characterEffect111101ui_story.fillFlat = false
			end

			local var_413_13 = 0

			if var_413_13 < arg_410_1.time_ and arg_410_1.time_ <= var_413_13 + arg_413_0 then
				arg_410_1:PlayTimeline("111101ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action4_1")
			end

			local var_413_14 = 0

			if var_413_14 < arg_410_1.time_ and arg_410_1.time_ <= var_413_14 + arg_413_0 then
				arg_410_1:PlayTimeline("111101ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_413_15 = 2

			if var_413_15 < arg_410_1.time_ and arg_410_1.time_ <= var_413_15 + arg_413_0 then
				arg_410_1:PlayTimeline("111101ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_413_16 = 0
			local var_413_17 = 0.65

			if var_413_16 < arg_410_1.time_ and arg_410_1.time_ <= var_413_16 + arg_413_0 then
				arg_410_1.talkMaxDuration = 0
				arg_410_1.dialogCg_.alpha = 1

				arg_410_1.dialog_:SetActive(true)
				SetActive(arg_410_1.leftNameGo_, true)

				local var_413_18 = arg_410_1:FormatText(StoryNameCfg[67].name)

				arg_410_1.leftNameTxt_.text = var_413_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_410_1.leftNameTxt_.transform)

				arg_410_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_410_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_410_1:RecordName(arg_410_1.leftNameTxt_.text)
				SetActive(arg_410_1.iconTrs_.gameObject, false)
				arg_410_1.callingController_:SetSelectedState("normal")

				local var_413_19 = arg_410_1:GetWordFromCfg(1101104102)
				local var_413_20 = arg_410_1:FormatText(var_413_19.content)

				arg_410_1.text_.text = var_413_20

				LuaForUtil.ClearLinePrefixSymbol(arg_410_1.text_)

				local var_413_21 = 26
				local var_413_22 = utf8.len(var_413_20)
				local var_413_23 = var_413_21 <= 0 and var_413_17 or var_413_17 * (var_413_22 / var_413_21)

				if var_413_23 > 0 and var_413_17 < var_413_23 then
					arg_410_1.talkMaxDuration = var_413_23

					if var_413_23 + var_413_16 > arg_410_1.duration_ then
						arg_410_1.duration_ = var_413_23 + var_413_16
					end
				end

				arg_410_1.text_.text = var_413_20
				arg_410_1.typewritter.percent = 0

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101104", "1101104102", "story_v_side_new_1101104.awb") ~= 0 then
					local var_413_24 = manager.audio:GetVoiceLength("story_v_side_new_1101104", "1101104102", "story_v_side_new_1101104.awb") / 1000

					if var_413_24 + var_413_16 > arg_410_1.duration_ then
						arg_410_1.duration_ = var_413_24 + var_413_16
					end

					if var_413_19.prefab_name ~= "" and arg_410_1.actors_[var_413_19.prefab_name] ~= nil then
						local var_413_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_410_1.actors_[var_413_19.prefab_name].transform, "story_v_side_new_1101104", "1101104102", "story_v_side_new_1101104.awb")

						arg_410_1:RecordAudio("1101104102", var_413_25)
						arg_410_1:RecordAudio("1101104102", var_413_25)
					else
						arg_410_1:AudioAction("play", "voice", "story_v_side_new_1101104", "1101104102", "story_v_side_new_1101104.awb")
					end

					arg_410_1:RecordHistoryTalkVoice("story_v_side_new_1101104", "1101104102", "story_v_side_new_1101104.awb")
				end

				arg_410_1:RecordContent(arg_410_1.text_.text)
			end

			local var_413_26 = math.max(var_413_17, arg_410_1.talkMaxDuration)

			if var_413_16 <= arg_410_1.time_ and arg_410_1.time_ < var_413_16 + var_413_26 then
				arg_410_1.typewritter.percent = (arg_410_1.time_ - var_413_16) / var_413_26

				arg_410_1.typewritter:SetDirty()
			end

			if arg_410_1.time_ >= var_413_16 + var_413_26 and arg_410_1.time_ < var_413_16 + var_413_26 + arg_413_0 then
				arg_410_1.typewritter.percent = 1

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(true)
			end
		end

		arg_410_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "111101ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_410_1:InitPlayNodeList()
	end,
	Play1101104103 = function(arg_414_0, arg_414_1)
		arg_414_1.time_ = 0
		arg_414_1.frameCnt_ = 0
		arg_414_1.state_ = "playing"
		arg_414_1.curTalkId_ = 1101104103
		arg_414_1.duration_ = 5

		SetActive(arg_414_1.tipsGo_, false)

		function arg_414_1.onSingleLineFinish_()
			arg_414_1.onSingleLineUpdate_ = nil
			arg_414_1.onSingleLineFinish_ = nil
			arg_414_1.state_ = "waiting"
		end

		function arg_414_1.playNext_(arg_416_0)
			if arg_416_0 == 1 then
				arg_414_0:Play1101104104(arg_414_1)
			end
		end

		function arg_414_1.onSingleLineUpdate_(arg_417_0)
			local var_417_0 = arg_414_1.actors_["111101ui_story"]
			local var_417_1 = 0

			if var_417_1 < arg_414_1.time_ and arg_414_1.time_ <= var_417_1 + arg_417_0 and not isNil(var_417_0) and arg_414_1.var_.characterEffect111101ui_story == nil then
				arg_414_1.var_.characterEffect111101ui_story = var_417_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_417_2 = 0.200000002980232

			if var_417_1 <= arg_414_1.time_ and arg_414_1.time_ < var_417_1 + var_417_2 and not isNil(var_417_0) then
				local var_417_3 = (arg_414_1.time_ - var_417_1) / var_417_2

				if arg_414_1.var_.characterEffect111101ui_story and not isNil(var_417_0) then
					local var_417_4 = Mathf.Lerp(0, 0.5, var_417_3)

					arg_414_1.var_.characterEffect111101ui_story.fillFlat = true
					arg_414_1.var_.characterEffect111101ui_story.fillRatio = var_417_4
				end
			end

			if arg_414_1.time_ >= var_417_1 + var_417_2 and arg_414_1.time_ < var_417_1 + var_417_2 + arg_417_0 and not isNil(var_417_0) and arg_414_1.var_.characterEffect111101ui_story then
				local var_417_5 = 0.5

				arg_414_1.var_.characterEffect111101ui_story.fillFlat = true
				arg_414_1.var_.characterEffect111101ui_story.fillRatio = var_417_5
			end

			local var_417_6 = 0
			local var_417_7 = 0.9

			if var_417_6 < arg_414_1.time_ and arg_414_1.time_ <= var_417_6 + arg_417_0 then
				arg_414_1.talkMaxDuration = 0
				arg_414_1.dialogCg_.alpha = 1

				arg_414_1.dialog_:SetActive(true)
				SetActive(arg_414_1.leftNameGo_, true)

				local var_417_8 = arg_414_1:FormatText(StoryNameCfg[7].name)

				arg_414_1.leftNameTxt_.text = var_417_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_414_1.leftNameTxt_.transform)

				arg_414_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_414_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_414_1:RecordName(arg_414_1.leftNameTxt_.text)
				SetActive(arg_414_1.iconTrs_.gameObject, true)
				arg_414_1.iconController_:SetSelectedState("hero")

				arg_414_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_414_1.callingController_:SetSelectedState("normal")

				arg_414_1.keyicon_.color = Color.New(1, 1, 1)
				arg_414_1.icon_.color = Color.New(1, 1, 1)

				local var_417_9 = arg_414_1:GetWordFromCfg(1101104103)
				local var_417_10 = arg_414_1:FormatText(var_417_9.content)

				arg_414_1.text_.text = var_417_10

				LuaForUtil.ClearLinePrefixSymbol(arg_414_1.text_)

				local var_417_11 = 36
				local var_417_12 = utf8.len(var_417_10)
				local var_417_13 = var_417_11 <= 0 and var_417_7 or var_417_7 * (var_417_12 / var_417_11)

				if var_417_13 > 0 and var_417_7 < var_417_13 then
					arg_414_1.talkMaxDuration = var_417_13

					if var_417_13 + var_417_6 > arg_414_1.duration_ then
						arg_414_1.duration_ = var_417_13 + var_417_6
					end
				end

				arg_414_1.text_.text = var_417_10
				arg_414_1.typewritter.percent = 0

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(false)
				arg_414_1:RecordContent(arg_414_1.text_.text)
			end

			local var_417_14 = math.max(var_417_7, arg_414_1.talkMaxDuration)

			if var_417_6 <= arg_414_1.time_ and arg_414_1.time_ < var_417_6 + var_417_14 then
				arg_414_1.typewritter.percent = (arg_414_1.time_ - var_417_6) / var_417_14

				arg_414_1.typewritter:SetDirty()
			end

			if arg_414_1.time_ >= var_417_6 + var_417_14 and arg_414_1.time_ < var_417_6 + var_417_14 + arg_417_0 then
				arg_414_1.typewritter.percent = 1

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(true)
			end
		end

		arg_414_1.nodeConfigList_ = {}

		arg_414_1:InitPlayNodeList()
	end,
	Play1101104104 = function(arg_418_0, arg_418_1)
		arg_418_1.time_ = 0
		arg_418_1.frameCnt_ = 0
		arg_418_1.state_ = "playing"
		arg_418_1.curTalkId_ = 1101104104
		arg_418_1.duration_ = 2.33

		local var_418_0 = {
			zh = 2.333,
			ja = 1.999999999999
		}
		local var_418_1 = manager.audio:GetLocalizationFlag()

		if var_418_0[var_418_1] ~= nil then
			arg_418_1.duration_ = var_418_0[var_418_1]
		end

		SetActive(arg_418_1.tipsGo_, false)

		function arg_418_1.onSingleLineFinish_()
			arg_418_1.onSingleLineUpdate_ = nil
			arg_418_1.onSingleLineFinish_ = nil
			arg_418_1.state_ = "waiting"
		end

		function arg_418_1.playNext_(arg_420_0)
			if arg_420_0 == 1 then
				arg_418_0:Play1101104105(arg_418_1)
			end
		end

		function arg_418_1.onSingleLineUpdate_(arg_421_0)
			local var_421_0 = arg_418_1.actors_["111101ui_story"].transform
			local var_421_1 = 0

			if var_421_1 < arg_418_1.time_ and arg_418_1.time_ <= var_421_1 + arg_421_0 then
				arg_418_1.var_.moveOldPos111101ui_story = var_421_0.localPosition
			end

			local var_421_2 = 0.001

			if var_421_1 <= arg_418_1.time_ and arg_418_1.time_ < var_421_1 + var_421_2 then
				local var_421_3 = (arg_418_1.time_ - var_421_1) / var_421_2
				local var_421_4 = Vector3.New(0, -0.83, -6)

				var_421_0.localPosition = Vector3.Lerp(arg_418_1.var_.moveOldPos111101ui_story, var_421_4, var_421_3)

				local var_421_5 = manager.ui.mainCamera.transform.position - var_421_0.position

				var_421_0.forward = Vector3.New(var_421_5.x, var_421_5.y, var_421_5.z)

				local var_421_6 = var_421_0.localEulerAngles

				var_421_6.z = 0
				var_421_6.x = 0
				var_421_0.localEulerAngles = var_421_6
			end

			if arg_418_1.time_ >= var_421_1 + var_421_2 and arg_418_1.time_ < var_421_1 + var_421_2 + arg_421_0 then
				var_421_0.localPosition = Vector3.New(0, -0.83, -6)

				local var_421_7 = manager.ui.mainCamera.transform.position - var_421_0.position

				var_421_0.forward = Vector3.New(var_421_7.x, var_421_7.y, var_421_7.z)

				local var_421_8 = var_421_0.localEulerAngles

				var_421_8.z = 0
				var_421_8.x = 0
				var_421_0.localEulerAngles = var_421_8
			end

			local var_421_9 = arg_418_1.actors_["111101ui_story"]
			local var_421_10 = 0

			if var_421_10 < arg_418_1.time_ and arg_418_1.time_ <= var_421_10 + arg_421_0 and not isNil(var_421_9) and arg_418_1.var_.characterEffect111101ui_story == nil then
				arg_418_1.var_.characterEffect111101ui_story = var_421_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_421_11 = 0.200000002980232

			if var_421_10 <= arg_418_1.time_ and arg_418_1.time_ < var_421_10 + var_421_11 and not isNil(var_421_9) then
				local var_421_12 = (arg_418_1.time_ - var_421_10) / var_421_11

				if arg_418_1.var_.characterEffect111101ui_story and not isNil(var_421_9) then
					arg_418_1.var_.characterEffect111101ui_story.fillFlat = false
				end
			end

			if arg_418_1.time_ >= var_421_10 + var_421_11 and arg_418_1.time_ < var_421_10 + var_421_11 + arg_421_0 and not isNil(var_421_9) and arg_418_1.var_.characterEffect111101ui_story then
				arg_418_1.var_.characterEffect111101ui_story.fillFlat = false
			end

			local var_421_13 = 0

			if var_421_13 < arg_418_1.time_ and arg_418_1.time_ <= var_421_13 + arg_421_0 then
				arg_418_1:PlayTimeline("111101ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1302cva")
			end

			local var_421_14 = 0

			if var_421_14 < arg_418_1.time_ and arg_418_1.time_ <= var_421_14 + arg_421_0 then
				arg_418_1:PlayTimeline("111101ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action4_2")
			end

			local var_421_15 = 0
			local var_421_16 = 0.2

			if var_421_15 < arg_418_1.time_ and arg_418_1.time_ <= var_421_15 + arg_421_0 then
				arg_418_1.talkMaxDuration = 0
				arg_418_1.dialogCg_.alpha = 1

				arg_418_1.dialog_:SetActive(true)
				SetActive(arg_418_1.leftNameGo_, true)

				local var_421_17 = arg_418_1:FormatText(StoryNameCfg[67].name)

				arg_418_1.leftNameTxt_.text = var_421_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_418_1.leftNameTxt_.transform)

				arg_418_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_418_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_418_1:RecordName(arg_418_1.leftNameTxt_.text)
				SetActive(arg_418_1.iconTrs_.gameObject, false)
				arg_418_1.callingController_:SetSelectedState("normal")

				local var_421_18 = arg_418_1:GetWordFromCfg(1101104104)
				local var_421_19 = arg_418_1:FormatText(var_421_18.content)

				arg_418_1.text_.text = var_421_19

				LuaForUtil.ClearLinePrefixSymbol(arg_418_1.text_)

				local var_421_20 = 8
				local var_421_21 = utf8.len(var_421_19)
				local var_421_22 = var_421_20 <= 0 and var_421_16 or var_421_16 * (var_421_21 / var_421_20)

				if var_421_22 > 0 and var_421_16 < var_421_22 then
					arg_418_1.talkMaxDuration = var_421_22

					if var_421_22 + var_421_15 > arg_418_1.duration_ then
						arg_418_1.duration_ = var_421_22 + var_421_15
					end
				end

				arg_418_1.text_.text = var_421_19
				arg_418_1.typewritter.percent = 0

				arg_418_1.typewritter:SetDirty()
				arg_418_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101104", "1101104104", "story_v_side_new_1101104.awb") ~= 0 then
					local var_421_23 = manager.audio:GetVoiceLength("story_v_side_new_1101104", "1101104104", "story_v_side_new_1101104.awb") / 1000

					if var_421_23 + var_421_15 > arg_418_1.duration_ then
						arg_418_1.duration_ = var_421_23 + var_421_15
					end

					if var_421_18.prefab_name ~= "" and arg_418_1.actors_[var_421_18.prefab_name] ~= nil then
						local var_421_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_418_1.actors_[var_421_18.prefab_name].transform, "story_v_side_new_1101104", "1101104104", "story_v_side_new_1101104.awb")

						arg_418_1:RecordAudio("1101104104", var_421_24)
						arg_418_1:RecordAudio("1101104104", var_421_24)
					else
						arg_418_1:AudioAction("play", "voice", "story_v_side_new_1101104", "1101104104", "story_v_side_new_1101104.awb")
					end

					arg_418_1:RecordHistoryTalkVoice("story_v_side_new_1101104", "1101104104", "story_v_side_new_1101104.awb")
				end

				arg_418_1:RecordContent(arg_418_1.text_.text)
			end

			local var_421_25 = math.max(var_421_16, arg_418_1.talkMaxDuration)

			if var_421_15 <= arg_418_1.time_ and arg_418_1.time_ < var_421_15 + var_421_25 then
				arg_418_1.typewritter.percent = (arg_418_1.time_ - var_421_15) / var_421_25

				arg_418_1.typewritter:SetDirty()
			end

			if arg_418_1.time_ >= var_421_15 + var_421_25 and arg_418_1.time_ < var_421_15 + var_421_25 + arg_421_0 then
				arg_418_1.typewritter.percent = 1

				arg_418_1.typewritter:SetDirty()
				arg_418_1:ShowNextGo(true)
			end
		end

		arg_418_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "111101ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_418_1:InitPlayNodeList()
	end,
	Play1101104105 = function(arg_422_0, arg_422_1)
		arg_422_1.time_ = 0
		arg_422_1.frameCnt_ = 0
		arg_422_1.state_ = "playing"
		arg_422_1.curTalkId_ = 1101104105
		arg_422_1.duration_ = 5

		SetActive(arg_422_1.tipsGo_, false)

		function arg_422_1.onSingleLineFinish_()
			arg_422_1.onSingleLineUpdate_ = nil
			arg_422_1.onSingleLineFinish_ = nil
			arg_422_1.state_ = "waiting"
		end

		function arg_422_1.playNext_(arg_424_0)
			if arg_424_0 == 1 then
				arg_422_0:Play1101104106(arg_422_1)
			end
		end

		function arg_422_1.onSingleLineUpdate_(arg_425_0)
			local var_425_0 = arg_422_1.actors_["111101ui_story"]
			local var_425_1 = 0

			if var_425_1 < arg_422_1.time_ and arg_422_1.time_ <= var_425_1 + arg_425_0 and not isNil(var_425_0) and arg_422_1.var_.characterEffect111101ui_story == nil then
				arg_422_1.var_.characterEffect111101ui_story = var_425_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_425_2 = 0.200000002980232

			if var_425_1 <= arg_422_1.time_ and arg_422_1.time_ < var_425_1 + var_425_2 and not isNil(var_425_0) then
				local var_425_3 = (arg_422_1.time_ - var_425_1) / var_425_2

				if arg_422_1.var_.characterEffect111101ui_story and not isNil(var_425_0) then
					local var_425_4 = Mathf.Lerp(0, 0.5, var_425_3)

					arg_422_1.var_.characterEffect111101ui_story.fillFlat = true
					arg_422_1.var_.characterEffect111101ui_story.fillRatio = var_425_4
				end
			end

			if arg_422_1.time_ >= var_425_1 + var_425_2 and arg_422_1.time_ < var_425_1 + var_425_2 + arg_425_0 and not isNil(var_425_0) and arg_422_1.var_.characterEffect111101ui_story then
				local var_425_5 = 0.5

				arg_422_1.var_.characterEffect111101ui_story.fillFlat = true
				arg_422_1.var_.characterEffect111101ui_story.fillRatio = var_425_5
			end

			local var_425_6 = 0
			local var_425_7 = 0.775

			if var_425_6 < arg_422_1.time_ and arg_422_1.time_ <= var_425_6 + arg_425_0 then
				arg_422_1.talkMaxDuration = 0
				arg_422_1.dialogCg_.alpha = 1

				arg_422_1.dialog_:SetActive(true)
				SetActive(arg_422_1.leftNameGo_, false)

				arg_422_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_422_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_422_1:RecordName(arg_422_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_422_1.iconTrs_.gameObject, false)
				arg_422_1.callingController_:SetSelectedState("normal")

				local var_425_8 = arg_422_1:GetWordFromCfg(1101104105)
				local var_425_9 = arg_422_1:FormatText(var_425_8.content)

				arg_422_1.text_.text = var_425_9

				LuaForUtil.ClearLinePrefixSymbol(arg_422_1.text_)

				local var_425_10 = 31
				local var_425_11 = utf8.len(var_425_9)
				local var_425_12 = var_425_10 <= 0 and var_425_7 or var_425_7 * (var_425_11 / var_425_10)

				if var_425_12 > 0 and var_425_7 < var_425_12 then
					arg_422_1.talkMaxDuration = var_425_12

					if var_425_12 + var_425_6 > arg_422_1.duration_ then
						arg_422_1.duration_ = var_425_12 + var_425_6
					end
				end

				arg_422_1.text_.text = var_425_9
				arg_422_1.typewritter.percent = 0

				arg_422_1.typewritter:SetDirty()
				arg_422_1:ShowNextGo(false)
				arg_422_1:RecordContent(arg_422_1.text_.text)
			end

			local var_425_13 = math.max(var_425_7, arg_422_1.talkMaxDuration)

			if var_425_6 <= arg_422_1.time_ and arg_422_1.time_ < var_425_6 + var_425_13 then
				arg_422_1.typewritter.percent = (arg_422_1.time_ - var_425_6) / var_425_13

				arg_422_1.typewritter:SetDirty()
			end

			if arg_422_1.time_ >= var_425_6 + var_425_13 and arg_422_1.time_ < var_425_6 + var_425_13 + arg_425_0 then
				arg_422_1.typewritter.percent = 1

				arg_422_1.typewritter:SetDirty()
				arg_422_1:ShowNextGo(true)
			end
		end

		arg_422_1.nodeConfigList_ = {}

		arg_422_1:InitPlayNodeList()
	end,
	Play1101104106 = function(arg_426_0, arg_426_1)
		arg_426_1.time_ = 0
		arg_426_1.frameCnt_ = 0
		arg_426_1.state_ = "playing"
		arg_426_1.curTalkId_ = 1101104106
		arg_426_1.duration_ = 5

		SetActive(arg_426_1.tipsGo_, false)

		function arg_426_1.onSingleLineFinish_()
			arg_426_1.onSingleLineUpdate_ = nil
			arg_426_1.onSingleLineFinish_ = nil
			arg_426_1.state_ = "waiting"
		end

		function arg_426_1.playNext_(arg_428_0)
			if arg_428_0 == 1 then
				arg_426_0:Play1101104107(arg_426_1)
			end
		end

		function arg_426_1.onSingleLineUpdate_(arg_429_0)
			local var_429_0 = 0
			local var_429_1 = 0.1

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

				arg_426_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_426_1.callingController_:SetSelectedState("normal")

				arg_426_1.keyicon_.color = Color.New(1, 1, 1)
				arg_426_1.icon_.color = Color.New(1, 1, 1)

				local var_429_3 = arg_426_1:GetWordFromCfg(1101104106)
				local var_429_4 = arg_426_1:FormatText(var_429_3.content)

				arg_426_1.text_.text = var_429_4

				LuaForUtil.ClearLinePrefixSymbol(arg_426_1.text_)

				local var_429_5 = 4
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
	Play1101104107 = function(arg_430_0, arg_430_1)
		arg_430_1.time_ = 0
		arg_430_1.frameCnt_ = 0
		arg_430_1.state_ = "playing"
		arg_430_1.curTalkId_ = 1101104107
		arg_430_1.duration_ = 2

		SetActive(arg_430_1.tipsGo_, false)

		function arg_430_1.onSingleLineFinish_()
			arg_430_1.onSingleLineUpdate_ = nil
			arg_430_1.onSingleLineFinish_ = nil
			arg_430_1.state_ = "waiting"
		end

		function arg_430_1.playNext_(arg_432_0)
			if arg_432_0 == 1 then
				arg_430_0:Play1101104108(arg_430_1)
			end
		end

		function arg_430_1.onSingleLineUpdate_(arg_433_0)
			local var_433_0 = arg_430_1.actors_["111101ui_story"].transform
			local var_433_1 = 0

			if var_433_1 < arg_430_1.time_ and arg_430_1.time_ <= var_433_1 + arg_433_0 then
				arg_430_1.var_.moveOldPos111101ui_story = var_433_0.localPosition
			end

			local var_433_2 = 0.001

			if var_433_1 <= arg_430_1.time_ and arg_430_1.time_ < var_433_1 + var_433_2 then
				local var_433_3 = (arg_430_1.time_ - var_433_1) / var_433_2
				local var_433_4 = Vector3.New(0, -0.83, -6)

				var_433_0.localPosition = Vector3.Lerp(arg_430_1.var_.moveOldPos111101ui_story, var_433_4, var_433_3)

				local var_433_5 = manager.ui.mainCamera.transform.position - var_433_0.position

				var_433_0.forward = Vector3.New(var_433_5.x, var_433_5.y, var_433_5.z)

				local var_433_6 = var_433_0.localEulerAngles

				var_433_6.z = 0
				var_433_6.x = 0
				var_433_0.localEulerAngles = var_433_6
			end

			if arg_430_1.time_ >= var_433_1 + var_433_2 and arg_430_1.time_ < var_433_1 + var_433_2 + arg_433_0 then
				var_433_0.localPosition = Vector3.New(0, -0.83, -6)

				local var_433_7 = manager.ui.mainCamera.transform.position - var_433_0.position

				var_433_0.forward = Vector3.New(var_433_7.x, var_433_7.y, var_433_7.z)

				local var_433_8 = var_433_0.localEulerAngles

				var_433_8.z = 0
				var_433_8.x = 0
				var_433_0.localEulerAngles = var_433_8
			end

			local var_433_9 = arg_430_1.actors_["111101ui_story"]
			local var_433_10 = 0

			if var_433_10 < arg_430_1.time_ and arg_430_1.time_ <= var_433_10 + arg_433_0 and not isNil(var_433_9) and arg_430_1.var_.characterEffect111101ui_story == nil then
				arg_430_1.var_.characterEffect111101ui_story = var_433_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_433_11 = 0.200000002980232

			if var_433_10 <= arg_430_1.time_ and arg_430_1.time_ < var_433_10 + var_433_11 and not isNil(var_433_9) then
				local var_433_12 = (arg_430_1.time_ - var_433_10) / var_433_11

				if arg_430_1.var_.characterEffect111101ui_story and not isNil(var_433_9) then
					arg_430_1.var_.characterEffect111101ui_story.fillFlat = false
				end
			end

			if arg_430_1.time_ >= var_433_10 + var_433_11 and arg_430_1.time_ < var_433_10 + var_433_11 + arg_433_0 and not isNil(var_433_9) and arg_430_1.var_.characterEffect111101ui_story then
				arg_430_1.var_.characterEffect111101ui_story.fillFlat = false
			end

			local var_433_13 = 0

			if var_433_13 < arg_430_1.time_ and arg_430_1.time_ <= var_433_13 + arg_433_0 then
				arg_430_1:PlayTimeline("111101ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action8_1")
			end

			local var_433_14 = 0

			if var_433_14 < arg_430_1.time_ and arg_430_1.time_ <= var_433_14 + arg_433_0 then
				arg_430_1:PlayTimeline("111101ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_433_15 = 0
			local var_433_16 = 0.075

			if var_433_15 < arg_430_1.time_ and arg_430_1.time_ <= var_433_15 + arg_433_0 then
				arg_430_1.talkMaxDuration = 0
				arg_430_1.dialogCg_.alpha = 1

				arg_430_1.dialog_:SetActive(true)
				SetActive(arg_430_1.leftNameGo_, true)

				local var_433_17 = arg_430_1:FormatText(StoryNameCfg[67].name)

				arg_430_1.leftNameTxt_.text = var_433_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_430_1.leftNameTxt_.transform)

				arg_430_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_430_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_430_1:RecordName(arg_430_1.leftNameTxt_.text)
				SetActive(arg_430_1.iconTrs_.gameObject, false)
				arg_430_1.callingController_:SetSelectedState("normal")

				local var_433_18 = arg_430_1:GetWordFromCfg(1101104107)
				local var_433_19 = arg_430_1:FormatText(var_433_18.content)

				arg_430_1.text_.text = var_433_19

				LuaForUtil.ClearLinePrefixSymbol(arg_430_1.text_)

				local var_433_20 = 3
				local var_433_21 = utf8.len(var_433_19)
				local var_433_22 = var_433_20 <= 0 and var_433_16 or var_433_16 * (var_433_21 / var_433_20)

				if var_433_22 > 0 and var_433_16 < var_433_22 then
					arg_430_1.talkMaxDuration = var_433_22

					if var_433_22 + var_433_15 > arg_430_1.duration_ then
						arg_430_1.duration_ = var_433_22 + var_433_15
					end
				end

				arg_430_1.text_.text = var_433_19
				arg_430_1.typewritter.percent = 0

				arg_430_1.typewritter:SetDirty()
				arg_430_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101104", "1101104107", "story_v_side_new_1101104.awb") ~= 0 then
					local var_433_23 = manager.audio:GetVoiceLength("story_v_side_new_1101104", "1101104107", "story_v_side_new_1101104.awb") / 1000

					if var_433_23 + var_433_15 > arg_430_1.duration_ then
						arg_430_1.duration_ = var_433_23 + var_433_15
					end

					if var_433_18.prefab_name ~= "" and arg_430_1.actors_[var_433_18.prefab_name] ~= nil then
						local var_433_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_430_1.actors_[var_433_18.prefab_name].transform, "story_v_side_new_1101104", "1101104107", "story_v_side_new_1101104.awb")

						arg_430_1:RecordAudio("1101104107", var_433_24)
						arg_430_1:RecordAudio("1101104107", var_433_24)
					else
						arg_430_1:AudioAction("play", "voice", "story_v_side_new_1101104", "1101104107", "story_v_side_new_1101104.awb")
					end

					arg_430_1:RecordHistoryTalkVoice("story_v_side_new_1101104", "1101104107", "story_v_side_new_1101104.awb")
				end

				arg_430_1:RecordContent(arg_430_1.text_.text)
			end

			local var_433_25 = math.max(var_433_16, arg_430_1.talkMaxDuration)

			if var_433_15 <= arg_430_1.time_ and arg_430_1.time_ < var_433_15 + var_433_25 then
				arg_430_1.typewritter.percent = (arg_430_1.time_ - var_433_15) / var_433_25

				arg_430_1.typewritter:SetDirty()
			end

			if arg_430_1.time_ >= var_433_15 + var_433_25 and arg_430_1.time_ < var_433_15 + var_433_25 + arg_433_0 then
				arg_430_1.typewritter.percent = 1

				arg_430_1.typewritter:SetDirty()
				arg_430_1:ShowNextGo(true)
			end
		end

		arg_430_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "111101ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_430_1:InitPlayNodeList()
	end,
	Play1101104108 = function(arg_434_0, arg_434_1)
		arg_434_1.time_ = 0
		arg_434_1.frameCnt_ = 0
		arg_434_1.state_ = "playing"
		arg_434_1.curTalkId_ = 1101104108
		arg_434_1.duration_ = 5

		SetActive(arg_434_1.tipsGo_, false)

		function arg_434_1.onSingleLineFinish_()
			arg_434_1.onSingleLineUpdate_ = nil
			arg_434_1.onSingleLineFinish_ = nil
			arg_434_1.state_ = "waiting"
		end

		function arg_434_1.playNext_(arg_436_0)
			if arg_436_0 == 1 then
				arg_434_0:Play1101104109(arg_434_1)
			end
		end

		function arg_434_1.onSingleLineUpdate_(arg_437_0)
			local var_437_0 = arg_434_1.actors_["111101ui_story"]
			local var_437_1 = 0

			if var_437_1 < arg_434_1.time_ and arg_434_1.time_ <= var_437_1 + arg_437_0 and not isNil(var_437_0) and arg_434_1.var_.characterEffect111101ui_story == nil then
				arg_434_1.var_.characterEffect111101ui_story = var_437_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_437_2 = 0.200000002980232

			if var_437_1 <= arg_434_1.time_ and arg_434_1.time_ < var_437_1 + var_437_2 and not isNil(var_437_0) then
				local var_437_3 = (arg_434_1.time_ - var_437_1) / var_437_2

				if arg_434_1.var_.characterEffect111101ui_story and not isNil(var_437_0) then
					local var_437_4 = Mathf.Lerp(0, 0.5, var_437_3)

					arg_434_1.var_.characterEffect111101ui_story.fillFlat = true
					arg_434_1.var_.characterEffect111101ui_story.fillRatio = var_437_4
				end
			end

			if arg_434_1.time_ >= var_437_1 + var_437_2 and arg_434_1.time_ < var_437_1 + var_437_2 + arg_437_0 and not isNil(var_437_0) and arg_434_1.var_.characterEffect111101ui_story then
				local var_437_5 = 0.5

				arg_434_1.var_.characterEffect111101ui_story.fillFlat = true
				arg_434_1.var_.characterEffect111101ui_story.fillRatio = var_437_5
			end

			local var_437_6 = 0
			local var_437_7 = 0.35

			if var_437_6 < arg_434_1.time_ and arg_434_1.time_ <= var_437_6 + arg_437_0 then
				arg_434_1.talkMaxDuration = 0
				arg_434_1.dialogCg_.alpha = 1

				arg_434_1.dialog_:SetActive(true)
				SetActive(arg_434_1.leftNameGo_, true)

				local var_437_8 = arg_434_1:FormatText(StoryNameCfg[7].name)

				arg_434_1.leftNameTxt_.text = var_437_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_434_1.leftNameTxt_.transform)

				arg_434_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_434_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_434_1:RecordName(arg_434_1.leftNameTxt_.text)
				SetActive(arg_434_1.iconTrs_.gameObject, true)
				arg_434_1.iconController_:SetSelectedState("hero")

				arg_434_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_434_1.callingController_:SetSelectedState("normal")

				arg_434_1.keyicon_.color = Color.New(1, 1, 1)
				arg_434_1.icon_.color = Color.New(1, 1, 1)

				local var_437_9 = arg_434_1:GetWordFromCfg(1101104108)
				local var_437_10 = arg_434_1:FormatText(var_437_9.content)

				arg_434_1.text_.text = var_437_10

				LuaForUtil.ClearLinePrefixSymbol(arg_434_1.text_)

				local var_437_11 = 14
				local var_437_12 = utf8.len(var_437_10)
				local var_437_13 = var_437_11 <= 0 and var_437_7 or var_437_7 * (var_437_12 / var_437_11)

				if var_437_13 > 0 and var_437_7 < var_437_13 then
					arg_434_1.talkMaxDuration = var_437_13

					if var_437_13 + var_437_6 > arg_434_1.duration_ then
						arg_434_1.duration_ = var_437_13 + var_437_6
					end
				end

				arg_434_1.text_.text = var_437_10
				arg_434_1.typewritter.percent = 0

				arg_434_1.typewritter:SetDirty()
				arg_434_1:ShowNextGo(false)
				arg_434_1:RecordContent(arg_434_1.text_.text)
			end

			local var_437_14 = math.max(var_437_7, arg_434_1.talkMaxDuration)

			if var_437_6 <= arg_434_1.time_ and arg_434_1.time_ < var_437_6 + var_437_14 then
				arg_434_1.typewritter.percent = (arg_434_1.time_ - var_437_6) / var_437_14

				arg_434_1.typewritter:SetDirty()
			end

			if arg_434_1.time_ >= var_437_6 + var_437_14 and arg_434_1.time_ < var_437_6 + var_437_14 + arg_437_0 then
				arg_434_1.typewritter.percent = 1

				arg_434_1.typewritter:SetDirty()
				arg_434_1:ShowNextGo(true)
			end
		end

		arg_434_1.nodeConfigList_ = {}

		arg_434_1:InitPlayNodeList()
	end,
	Play1101104109 = function(arg_438_0, arg_438_1)
		arg_438_1.time_ = 0
		arg_438_1.frameCnt_ = 0
		arg_438_1.state_ = "playing"
		arg_438_1.curTalkId_ = 1101104109
		arg_438_1.duration_ = 5

		SetActive(arg_438_1.tipsGo_, false)

		function arg_438_1.onSingleLineFinish_()
			arg_438_1.onSingleLineUpdate_ = nil
			arg_438_1.onSingleLineFinish_ = nil
			arg_438_1.state_ = "waiting"
		end

		function arg_438_1.playNext_(arg_440_0)
			if arg_440_0 == 1 then
				arg_438_0:Play1101104110(arg_438_1)
			end
		end

		function arg_438_1.onSingleLineUpdate_(arg_441_0)
			local var_441_0 = 0
			local var_441_1 = 0.775

			if var_441_0 < arg_438_1.time_ and arg_438_1.time_ <= var_441_0 + arg_441_0 then
				arg_438_1.talkMaxDuration = 0
				arg_438_1.dialogCg_.alpha = 1

				arg_438_1.dialog_:SetActive(true)
				SetActive(arg_438_1.leftNameGo_, true)

				local var_441_2 = arg_438_1:FormatText(StoryNameCfg[7].name)

				arg_438_1.leftNameTxt_.text = var_441_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_438_1.leftNameTxt_.transform)

				arg_438_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_438_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_438_1:RecordName(arg_438_1.leftNameTxt_.text)
				SetActive(arg_438_1.iconTrs_.gameObject, true)
				arg_438_1.iconController_:SetSelectedState("hero")

				arg_438_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_438_1.callingController_:SetSelectedState("normal")

				arg_438_1.keyicon_.color = Color.New(1, 1, 1)
				arg_438_1.icon_.color = Color.New(1, 1, 1)

				local var_441_3 = arg_438_1:GetWordFromCfg(1101104109)
				local var_441_4 = arg_438_1:FormatText(var_441_3.content)

				arg_438_1.text_.text = var_441_4

				LuaForUtil.ClearLinePrefixSymbol(arg_438_1.text_)

				local var_441_5 = 31
				local var_441_6 = utf8.len(var_441_4)
				local var_441_7 = var_441_5 <= 0 and var_441_1 or var_441_1 * (var_441_6 / var_441_5)

				if var_441_7 > 0 and var_441_1 < var_441_7 then
					arg_438_1.talkMaxDuration = var_441_7

					if var_441_7 + var_441_0 > arg_438_1.duration_ then
						arg_438_1.duration_ = var_441_7 + var_441_0
					end
				end

				arg_438_1.text_.text = var_441_4
				arg_438_1.typewritter.percent = 0

				arg_438_1.typewritter:SetDirty()
				arg_438_1:ShowNextGo(false)
				arg_438_1:RecordContent(arg_438_1.text_.text)
			end

			local var_441_8 = math.max(var_441_1, arg_438_1.talkMaxDuration)

			if var_441_0 <= arg_438_1.time_ and arg_438_1.time_ < var_441_0 + var_441_8 then
				arg_438_1.typewritter.percent = (arg_438_1.time_ - var_441_0) / var_441_8

				arg_438_1.typewritter:SetDirty()
			end

			if arg_438_1.time_ >= var_441_0 + var_441_8 and arg_438_1.time_ < var_441_0 + var_441_8 + arg_441_0 then
				arg_438_1.typewritter.percent = 1

				arg_438_1.typewritter:SetDirty()
				arg_438_1:ShowNextGo(true)
			end
		end

		arg_438_1.nodeConfigList_ = {}

		arg_438_1:InitPlayNodeList()
	end,
	Play1101104110 = function(arg_442_0, arg_442_1)
		arg_442_1.time_ = 0
		arg_442_1.frameCnt_ = 0
		arg_442_1.state_ = "playing"
		arg_442_1.curTalkId_ = 1101104110
		arg_442_1.duration_ = 11.1

		local var_442_0 = {
			zh = 5.6,
			ja = 11.1
		}
		local var_442_1 = manager.audio:GetLocalizationFlag()

		if var_442_0[var_442_1] ~= nil then
			arg_442_1.duration_ = var_442_0[var_442_1]
		end

		SetActive(arg_442_1.tipsGo_, false)

		function arg_442_1.onSingleLineFinish_()
			arg_442_1.onSingleLineUpdate_ = nil
			arg_442_1.onSingleLineFinish_ = nil
			arg_442_1.state_ = "waiting"
		end

		function arg_442_1.playNext_(arg_444_0)
			if arg_444_0 == 1 then
				arg_442_0:Play1101104111(arg_442_1)
			end
		end

		function arg_442_1.onSingleLineUpdate_(arg_445_0)
			local var_445_0 = arg_442_1.actors_["111101ui_story"].transform
			local var_445_1 = 0

			if var_445_1 < arg_442_1.time_ and arg_442_1.time_ <= var_445_1 + arg_445_0 then
				arg_442_1.var_.moveOldPos111101ui_story = var_445_0.localPosition
			end

			local var_445_2 = 0.001

			if var_445_1 <= arg_442_1.time_ and arg_442_1.time_ < var_445_1 + var_445_2 then
				local var_445_3 = (arg_442_1.time_ - var_445_1) / var_445_2
				local var_445_4 = Vector3.New(0, -0.83, -6)

				var_445_0.localPosition = Vector3.Lerp(arg_442_1.var_.moveOldPos111101ui_story, var_445_4, var_445_3)

				local var_445_5 = manager.ui.mainCamera.transform.position - var_445_0.position

				var_445_0.forward = Vector3.New(var_445_5.x, var_445_5.y, var_445_5.z)

				local var_445_6 = var_445_0.localEulerAngles

				var_445_6.z = 0
				var_445_6.x = 0
				var_445_0.localEulerAngles = var_445_6
			end

			if arg_442_1.time_ >= var_445_1 + var_445_2 and arg_442_1.time_ < var_445_1 + var_445_2 + arg_445_0 then
				var_445_0.localPosition = Vector3.New(0, -0.83, -6)

				local var_445_7 = manager.ui.mainCamera.transform.position - var_445_0.position

				var_445_0.forward = Vector3.New(var_445_7.x, var_445_7.y, var_445_7.z)

				local var_445_8 = var_445_0.localEulerAngles

				var_445_8.z = 0
				var_445_8.x = 0
				var_445_0.localEulerAngles = var_445_8
			end

			local var_445_9 = arg_442_1.actors_["111101ui_story"]
			local var_445_10 = 0

			if var_445_10 < arg_442_1.time_ and arg_442_1.time_ <= var_445_10 + arg_445_0 and not isNil(var_445_9) and arg_442_1.var_.characterEffect111101ui_story == nil then
				arg_442_1.var_.characterEffect111101ui_story = var_445_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_445_11 = 0.200000002980232

			if var_445_10 <= arg_442_1.time_ and arg_442_1.time_ < var_445_10 + var_445_11 and not isNil(var_445_9) then
				local var_445_12 = (arg_442_1.time_ - var_445_10) / var_445_11

				if arg_442_1.var_.characterEffect111101ui_story and not isNil(var_445_9) then
					arg_442_1.var_.characterEffect111101ui_story.fillFlat = false
				end
			end

			if arg_442_1.time_ >= var_445_10 + var_445_11 and arg_442_1.time_ < var_445_10 + var_445_11 + arg_445_0 and not isNil(var_445_9) and arg_442_1.var_.characterEffect111101ui_story then
				arg_442_1.var_.characterEffect111101ui_story.fillFlat = false
			end

			local var_445_13 = 0

			if var_445_13 < arg_442_1.time_ and arg_442_1.time_ <= var_445_13 + arg_445_0 then
				arg_442_1:PlayTimeline("111101ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_445_14 = 0
			local var_445_15 = 0.55

			if var_445_14 < arg_442_1.time_ and arg_442_1.time_ <= var_445_14 + arg_445_0 then
				arg_442_1.talkMaxDuration = 0
				arg_442_1.dialogCg_.alpha = 1

				arg_442_1.dialog_:SetActive(true)
				SetActive(arg_442_1.leftNameGo_, true)

				local var_445_16 = arg_442_1:FormatText(StoryNameCfg[67].name)

				arg_442_1.leftNameTxt_.text = var_445_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_442_1.leftNameTxt_.transform)

				arg_442_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_442_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_442_1:RecordName(arg_442_1.leftNameTxt_.text)
				SetActive(arg_442_1.iconTrs_.gameObject, false)
				arg_442_1.callingController_:SetSelectedState("normal")

				local var_445_17 = arg_442_1:GetWordFromCfg(1101104110)
				local var_445_18 = arg_442_1:FormatText(var_445_17.content)

				arg_442_1.text_.text = var_445_18

				LuaForUtil.ClearLinePrefixSymbol(arg_442_1.text_)

				local var_445_19 = 22
				local var_445_20 = utf8.len(var_445_18)
				local var_445_21 = var_445_19 <= 0 and var_445_15 or var_445_15 * (var_445_20 / var_445_19)

				if var_445_21 > 0 and var_445_15 < var_445_21 then
					arg_442_1.talkMaxDuration = var_445_21

					if var_445_21 + var_445_14 > arg_442_1.duration_ then
						arg_442_1.duration_ = var_445_21 + var_445_14
					end
				end

				arg_442_1.text_.text = var_445_18
				arg_442_1.typewritter.percent = 0

				arg_442_1.typewritter:SetDirty()
				arg_442_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101104", "1101104110", "story_v_side_new_1101104.awb") ~= 0 then
					local var_445_22 = manager.audio:GetVoiceLength("story_v_side_new_1101104", "1101104110", "story_v_side_new_1101104.awb") / 1000

					if var_445_22 + var_445_14 > arg_442_1.duration_ then
						arg_442_1.duration_ = var_445_22 + var_445_14
					end

					if var_445_17.prefab_name ~= "" and arg_442_1.actors_[var_445_17.prefab_name] ~= nil then
						local var_445_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_442_1.actors_[var_445_17.prefab_name].transform, "story_v_side_new_1101104", "1101104110", "story_v_side_new_1101104.awb")

						arg_442_1:RecordAudio("1101104110", var_445_23)
						arg_442_1:RecordAudio("1101104110", var_445_23)
					else
						arg_442_1:AudioAction("play", "voice", "story_v_side_new_1101104", "1101104110", "story_v_side_new_1101104.awb")
					end

					arg_442_1:RecordHistoryTalkVoice("story_v_side_new_1101104", "1101104110", "story_v_side_new_1101104.awb")
				end

				arg_442_1:RecordContent(arg_442_1.text_.text)
			end

			local var_445_24 = math.max(var_445_15, arg_442_1.talkMaxDuration)

			if var_445_14 <= arg_442_1.time_ and arg_442_1.time_ < var_445_14 + var_445_24 then
				arg_442_1.typewritter.percent = (arg_442_1.time_ - var_445_14) / var_445_24

				arg_442_1.typewritter:SetDirty()
			end

			if arg_442_1.time_ >= var_445_14 + var_445_24 and arg_442_1.time_ < var_445_14 + var_445_24 + arg_445_0 then
				arg_442_1.typewritter.percent = 1

				arg_442_1.typewritter:SetDirty()
				arg_442_1:ShowNextGo(true)
			end
		end

		arg_442_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "111101ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_442_1:InitPlayNodeList()
	end,
	Play1101104111 = function(arg_446_0, arg_446_1)
		arg_446_1.time_ = 0
		arg_446_1.frameCnt_ = 0
		arg_446_1.state_ = "playing"
		arg_446_1.curTalkId_ = 1101104111
		arg_446_1.duration_ = 9

		SetActive(arg_446_1.tipsGo_, false)

		function arg_446_1.onSingleLineFinish_()
			arg_446_1.onSingleLineUpdate_ = nil
			arg_446_1.onSingleLineFinish_ = nil
			arg_446_1.state_ = "waiting"
		end

		function arg_446_1.playNext_(arg_448_0)
			if arg_448_0 == 1 then
				arg_446_0:Play1101104112(arg_446_1)
			end
		end

		function arg_446_1.onSingleLineUpdate_(arg_449_0)
			local var_449_0 = "ST19"

			if arg_446_1.bgs_[var_449_0] == nil then
				local var_449_1 = Object.Instantiate(arg_446_1.paintGo_)

				var_449_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_449_0)
				var_449_1.name = var_449_0
				var_449_1.transform.parent = arg_446_1.stage_.transform
				var_449_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_446_1.bgs_[var_449_0] = var_449_1
			end

			local var_449_2 = 2

			if var_449_2 < arg_446_1.time_ and arg_446_1.time_ <= var_449_2 + arg_449_0 then
				local var_449_3 = manager.ui.mainCamera.transform.localPosition
				local var_449_4 = Vector3.New(0, 0, 10) + Vector3.New(var_449_3.x, var_449_3.y, 0)
				local var_449_5 = arg_446_1.bgs_.ST19

				var_449_5.transform.localPosition = var_449_4
				var_449_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_449_6 = var_449_5:GetComponent("SpriteRenderer")

				if var_449_6 and var_449_6.sprite then
					local var_449_7 = (var_449_5.transform.localPosition - var_449_3).z
					local var_449_8 = manager.ui.mainCameraCom_
					local var_449_9 = 2 * var_449_7 * Mathf.Tan(var_449_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_449_10 = var_449_9 * var_449_8.aspect
					local var_449_11 = var_449_6.sprite.bounds.size.x
					local var_449_12 = var_449_6.sprite.bounds.size.y
					local var_449_13 = var_449_10 / var_449_11
					local var_449_14 = var_449_9 / var_449_12
					local var_449_15 = var_449_14 < var_449_13 and var_449_13 or var_449_14

					var_449_5.transform.localScale = Vector3.New(var_449_15, var_449_15, 0)
				end

				for iter_449_0, iter_449_1 in pairs(arg_446_1.bgs_) do
					if iter_449_0 ~= "ST19" then
						iter_449_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_449_16 = 0

			if var_449_16 < arg_446_1.time_ and arg_446_1.time_ <= var_449_16 + arg_449_0 then
				arg_446_1.mask_.enabled = true
				arg_446_1.mask_.raycastTarget = true

				arg_446_1:SetGaussion(false)
			end

			local var_449_17 = 2

			if var_449_16 <= arg_446_1.time_ and arg_446_1.time_ < var_449_16 + var_449_17 then
				local var_449_18 = (arg_446_1.time_ - var_449_16) / var_449_17
				local var_449_19 = Color.New(0, 0, 0)

				var_449_19.a = Mathf.Lerp(0, 1, var_449_18)
				arg_446_1.mask_.color = var_449_19
			end

			if arg_446_1.time_ >= var_449_16 + var_449_17 and arg_446_1.time_ < var_449_16 + var_449_17 + arg_449_0 then
				local var_449_20 = Color.New(0, 0, 0)

				var_449_20.a = 1
				arg_446_1.mask_.color = var_449_20
			end

			local var_449_21 = 2

			if var_449_21 < arg_446_1.time_ and arg_446_1.time_ <= var_449_21 + arg_449_0 then
				arg_446_1.mask_.enabled = true
				arg_446_1.mask_.raycastTarget = true

				arg_446_1:SetGaussion(false)
			end

			local var_449_22 = 2

			if var_449_21 <= arg_446_1.time_ and arg_446_1.time_ < var_449_21 + var_449_22 then
				local var_449_23 = (arg_446_1.time_ - var_449_21) / var_449_22
				local var_449_24 = Color.New(0, 0, 0)

				var_449_24.a = Mathf.Lerp(1, 0, var_449_23)
				arg_446_1.mask_.color = var_449_24
			end

			if arg_446_1.time_ >= var_449_21 + var_449_22 and arg_446_1.time_ < var_449_21 + var_449_22 + arg_449_0 then
				local var_449_25 = Color.New(0, 0, 0)
				local var_449_26 = 0

				arg_446_1.mask_.enabled = false
				var_449_25.a = var_449_26
				arg_446_1.mask_.color = var_449_25
			end

			local var_449_27 = arg_446_1.actors_["111101ui_story"].transform
			local var_449_28 = 2

			if var_449_28 < arg_446_1.time_ and arg_446_1.time_ <= var_449_28 + arg_449_0 then
				arg_446_1.var_.moveOldPos111101ui_story = var_449_27.localPosition
			end

			local var_449_29 = 0.001

			if var_449_28 <= arg_446_1.time_ and arg_446_1.time_ < var_449_28 + var_449_29 then
				local var_449_30 = (arg_446_1.time_ - var_449_28) / var_449_29
				local var_449_31 = Vector3.New(0, 100, 0)

				var_449_27.localPosition = Vector3.Lerp(arg_446_1.var_.moveOldPos111101ui_story, var_449_31, var_449_30)

				local var_449_32 = manager.ui.mainCamera.transform.position - var_449_27.position

				var_449_27.forward = Vector3.New(var_449_32.x, var_449_32.y, var_449_32.z)

				local var_449_33 = var_449_27.localEulerAngles

				var_449_33.z = 0
				var_449_33.x = 0
				var_449_27.localEulerAngles = var_449_33
			end

			if arg_446_1.time_ >= var_449_28 + var_449_29 and arg_446_1.time_ < var_449_28 + var_449_29 + arg_449_0 then
				var_449_27.localPosition = Vector3.New(0, 100, 0)

				local var_449_34 = manager.ui.mainCamera.transform.position - var_449_27.position

				var_449_27.forward = Vector3.New(var_449_34.x, var_449_34.y, var_449_34.z)

				local var_449_35 = var_449_27.localEulerAngles

				var_449_35.z = 0
				var_449_35.x = 0
				var_449_27.localEulerAngles = var_449_35
			end

			local var_449_36 = "1011ui_story"

			if arg_446_1.actors_[var_449_36] == nil then
				local var_449_37 = Asset.Load("Char/" .. "1011ui_story")

				if not isNil(var_449_37) then
					local var_449_38 = Object.Instantiate(Asset.Load("Char/" .. "1011ui_story"), arg_446_1.stage_.transform)

					var_449_38.name = var_449_36
					var_449_38.transform.localPosition = Vector3.New(0, 100, 0)
					arg_446_1.actors_[var_449_36] = var_449_38

					local var_449_39 = var_449_38:GetComponentInChildren(typeof(CharacterEffect))

					var_449_39.enabled = true

					local var_449_40 = GameObjectTools.GetOrAddComponent(var_449_38, typeof(DynamicBoneHelper))

					if var_449_40 then
						var_449_40:EnableDynamicBone(false)
					end

					arg_446_1:ShowWeapon(var_449_39.transform, false)

					arg_446_1.var_[var_449_36 .. "Animator"] = var_449_39.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_446_1.var_[var_449_36 .. "Animator"].applyRootMotion = true
					arg_446_1.var_[var_449_36 .. "LipSync"] = var_449_39.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_449_41 = arg_446_1.actors_["1011ui_story"].transform
			local var_449_42 = 4

			if var_449_42 < arg_446_1.time_ and arg_446_1.time_ <= var_449_42 + arg_449_0 then
				arg_446_1.var_.moveOldPos1011ui_story = var_449_41.localPosition
			end

			local var_449_43 = 0.001

			if var_449_42 <= arg_446_1.time_ and arg_446_1.time_ < var_449_42 + var_449_43 then
				local var_449_44 = (arg_446_1.time_ - var_449_42) / var_449_43
				local var_449_45 = Vector3.New(0, -0.71, -6)

				var_449_41.localPosition = Vector3.Lerp(arg_446_1.var_.moveOldPos1011ui_story, var_449_45, var_449_44)

				local var_449_46 = manager.ui.mainCamera.transform.position - var_449_41.position

				var_449_41.forward = Vector3.New(var_449_46.x, var_449_46.y, var_449_46.z)

				local var_449_47 = var_449_41.localEulerAngles

				var_449_47.z = 0
				var_449_47.x = 0
				var_449_41.localEulerAngles = var_449_47
			end

			if arg_446_1.time_ >= var_449_42 + var_449_43 and arg_446_1.time_ < var_449_42 + var_449_43 + arg_449_0 then
				var_449_41.localPosition = Vector3.New(0, -0.71, -6)

				local var_449_48 = manager.ui.mainCamera.transform.position - var_449_41.position

				var_449_41.forward = Vector3.New(var_449_48.x, var_449_48.y, var_449_48.z)

				local var_449_49 = var_449_41.localEulerAngles

				var_449_49.z = 0
				var_449_49.x = 0
				var_449_41.localEulerAngles = var_449_49
			end

			local var_449_50 = arg_446_1.actors_["1011ui_story"]
			local var_449_51 = 4

			if var_449_51 < arg_446_1.time_ and arg_446_1.time_ <= var_449_51 + arg_449_0 and not isNil(var_449_50) and arg_446_1.var_.characterEffect1011ui_story == nil then
				arg_446_1.var_.characterEffect1011ui_story = var_449_50:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_449_52 = 0.200000002980232

			if var_449_51 <= arg_446_1.time_ and arg_446_1.time_ < var_449_51 + var_449_52 and not isNil(var_449_50) then
				local var_449_53 = (arg_446_1.time_ - var_449_51) / var_449_52

				if arg_446_1.var_.characterEffect1011ui_story and not isNil(var_449_50) then
					local var_449_54 = Mathf.Lerp(0, 0.5, var_449_53)

					arg_446_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_446_1.var_.characterEffect1011ui_story.fillRatio = var_449_54
				end
			end

			if arg_446_1.time_ >= var_449_51 + var_449_52 and arg_446_1.time_ < var_449_51 + var_449_52 + arg_449_0 and not isNil(var_449_50) and arg_446_1.var_.characterEffect1011ui_story then
				local var_449_55 = 0.5

				arg_446_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_446_1.var_.characterEffect1011ui_story.fillRatio = var_449_55
			end

			local var_449_56 = 4

			if var_449_56 < arg_446_1.time_ and arg_446_1.time_ <= var_449_56 + arg_449_0 then
				arg_446_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action1_1")
			end

			local var_449_57 = 4

			if var_449_57 < arg_446_1.time_ and arg_446_1.time_ <= var_449_57 + arg_449_0 then
				arg_446_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			if arg_446_1.frameCnt_ <= 1 then
				arg_446_1.dialog_:SetActive(false)
			end

			local var_449_58 = 4
			local var_449_59 = 0.6

			if var_449_58 < arg_446_1.time_ and arg_446_1.time_ <= var_449_58 + arg_449_0 then
				arg_446_1.talkMaxDuration = 0

				arg_446_1.dialog_:SetActive(true)

				arg_446_1.dialogCg_.alpha = 0

				local var_449_60 = LeanTween.value(arg_446_1.dialog_, 0, 1, 0.3)

				var_449_60:setOnUpdate(LuaHelper.FloatAction(function(arg_450_0)
					arg_446_1.dialogCg_.alpha = arg_450_0
				end))
				var_449_60:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_446_1.dialog_)
					var_449_60:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_446_1.duration_ = arg_446_1.duration_ + 0.3

				SetActive(arg_446_1.leftNameGo_, false)

				arg_446_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_446_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_446_1:RecordName(arg_446_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_446_1.iconTrs_.gameObject, false)
				arg_446_1.callingController_:SetSelectedState("normal")

				local var_449_61 = arg_446_1:GetWordFromCfg(1101104111)
				local var_449_62 = arg_446_1:FormatText(var_449_61.content)

				arg_446_1.text_.text = var_449_62

				LuaForUtil.ClearLinePrefixSymbol(arg_446_1.text_)

				local var_449_63 = 24
				local var_449_64 = utf8.len(var_449_62)
				local var_449_65 = var_449_63 <= 0 and var_449_59 or var_449_59 * (var_449_64 / var_449_63)

				if var_449_65 > 0 and var_449_59 < var_449_65 then
					arg_446_1.talkMaxDuration = var_449_65
					var_449_58 = var_449_58 + 0.3

					if var_449_65 + var_449_58 > arg_446_1.duration_ then
						arg_446_1.duration_ = var_449_65 + var_449_58
					end
				end

				arg_446_1.text_.text = var_449_62
				arg_446_1.typewritter.percent = 0

				arg_446_1.typewritter:SetDirty()
				arg_446_1:ShowNextGo(false)
				arg_446_1:RecordContent(arg_446_1.text_.text)
			end

			local var_449_66 = var_449_58 + 0.3
			local var_449_67 = math.max(var_449_59, arg_446_1.talkMaxDuration)

			if var_449_66 <= arg_446_1.time_ and arg_446_1.time_ < var_449_66 + var_449_67 then
				arg_446_1.typewritter.percent = (arg_446_1.time_ - var_449_66) / var_449_67

				arg_446_1.typewritter:SetDirty()
			end

			if arg_446_1.time_ >= var_449_66 + var_449_67 and arg_446_1.time_ < var_449_66 + var_449_67 + arg_449_0 then
				arg_446_1.typewritter.percent = 1

				arg_446_1.typewritter:SetDirty()
				arg_446_1:ShowNextGo(true)
			end
		end

		arg_446_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "111101ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_446_1:InitPlayNodeList()
	end,
	Play1101104112 = function(arg_452_0, arg_452_1)
		arg_452_1.time_ = 0
		arg_452_1.frameCnt_ = 0
		arg_452_1.state_ = "playing"
		arg_452_1.curTalkId_ = 1101104112
		arg_452_1.duration_ = 4.5

		local var_452_0 = {
			zh = 4.233,
			ja = 4.5
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
				arg_452_0:Play1101104113(arg_452_1)
			end
		end

		function arg_452_1.onSingleLineUpdate_(arg_455_0)
			local var_455_0 = 0
			local var_455_1 = 0.425

			if var_455_0 < arg_452_1.time_ and arg_452_1.time_ <= var_455_0 + arg_455_0 then
				arg_452_1.talkMaxDuration = 0
				arg_452_1.dialogCg_.alpha = 1

				arg_452_1.dialog_:SetActive(true)
				SetActive(arg_452_1.leftNameGo_, true)

				local var_455_2 = arg_452_1:FormatText(StoryNameCfg[67].name)

				arg_452_1.leftNameTxt_.text = var_455_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_452_1.leftNameTxt_.transform)

				arg_452_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_452_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_452_1:RecordName(arg_452_1.leftNameTxt_.text)
				SetActive(arg_452_1.iconTrs_.gameObject, true)
				arg_452_1.iconController_:SetSelectedState("hero")

				arg_452_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1111")

				arg_452_1.callingController_:SetSelectedState("normal")

				arg_452_1.keyicon_.color = Color.New(1, 1, 1)
				arg_452_1.icon_.color = Color.New(1, 1, 1)

				local var_455_3 = arg_452_1:GetWordFromCfg(1101104112)
				local var_455_4 = arg_452_1:FormatText(var_455_3.content)

				arg_452_1.text_.text = var_455_4

				LuaForUtil.ClearLinePrefixSymbol(arg_452_1.text_)

				local var_455_5 = 17
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

				if manager.audio:GetVoiceLength("story_v_side_new_1101104", "1101104112", "story_v_side_new_1101104.awb") ~= 0 then
					local var_455_8 = manager.audio:GetVoiceLength("story_v_side_new_1101104", "1101104112", "story_v_side_new_1101104.awb") / 1000

					if var_455_8 + var_455_0 > arg_452_1.duration_ then
						arg_452_1.duration_ = var_455_8 + var_455_0
					end

					if var_455_3.prefab_name ~= "" and arg_452_1.actors_[var_455_3.prefab_name] ~= nil then
						local var_455_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_452_1.actors_[var_455_3.prefab_name].transform, "story_v_side_new_1101104", "1101104112", "story_v_side_new_1101104.awb")

						arg_452_1:RecordAudio("1101104112", var_455_9)
						arg_452_1:RecordAudio("1101104112", var_455_9)
					else
						arg_452_1:AudioAction("play", "voice", "story_v_side_new_1101104", "1101104112", "story_v_side_new_1101104.awb")
					end

					arg_452_1:RecordHistoryTalkVoice("story_v_side_new_1101104", "1101104112", "story_v_side_new_1101104.awb")
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
	Play1101104113 = function(arg_456_0, arg_456_1)
		arg_456_1.time_ = 0
		arg_456_1.frameCnt_ = 0
		arg_456_1.state_ = "playing"
		arg_456_1.curTalkId_ = 1101104113
		arg_456_1.duration_ = 4.8

		local var_456_0 = {
			zh = 4.3,
			ja = 4.8
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
				arg_456_0:Play1101104114(arg_456_1)
			end
		end

		function arg_456_1.onSingleLineUpdate_(arg_459_0)
			local var_459_0 = arg_456_1.actors_["1011ui_story"].transform
			local var_459_1 = 0

			if var_459_1 < arg_456_1.time_ and arg_456_1.time_ <= var_459_1 + arg_459_0 then
				arg_456_1.var_.moveOldPos1011ui_story = var_459_0.localPosition
			end

			local var_459_2 = 0.001

			if var_459_1 <= arg_456_1.time_ and arg_456_1.time_ < var_459_1 + var_459_2 then
				local var_459_3 = (arg_456_1.time_ - var_459_1) / var_459_2
				local var_459_4 = Vector3.New(0, -0.71, -6)

				var_459_0.localPosition = Vector3.Lerp(arg_456_1.var_.moveOldPos1011ui_story, var_459_4, var_459_3)

				local var_459_5 = manager.ui.mainCamera.transform.position - var_459_0.position

				var_459_0.forward = Vector3.New(var_459_5.x, var_459_5.y, var_459_5.z)

				local var_459_6 = var_459_0.localEulerAngles

				var_459_6.z = 0
				var_459_6.x = 0
				var_459_0.localEulerAngles = var_459_6
			end

			if arg_456_1.time_ >= var_459_1 + var_459_2 and arg_456_1.time_ < var_459_1 + var_459_2 + arg_459_0 then
				var_459_0.localPosition = Vector3.New(0, -0.71, -6)

				local var_459_7 = manager.ui.mainCamera.transform.position - var_459_0.position

				var_459_0.forward = Vector3.New(var_459_7.x, var_459_7.y, var_459_7.z)

				local var_459_8 = var_459_0.localEulerAngles

				var_459_8.z = 0
				var_459_8.x = 0
				var_459_0.localEulerAngles = var_459_8
			end

			local var_459_9 = arg_456_1.actors_["1011ui_story"]
			local var_459_10 = 0

			if var_459_10 < arg_456_1.time_ and arg_456_1.time_ <= var_459_10 + arg_459_0 and not isNil(var_459_9) and arg_456_1.var_.characterEffect1011ui_story == nil then
				arg_456_1.var_.characterEffect1011ui_story = var_459_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_459_11 = 0.200000002980232

			if var_459_10 <= arg_456_1.time_ and arg_456_1.time_ < var_459_10 + var_459_11 and not isNil(var_459_9) then
				local var_459_12 = (arg_456_1.time_ - var_459_10) / var_459_11

				if arg_456_1.var_.characterEffect1011ui_story and not isNil(var_459_9) then
					arg_456_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_456_1.time_ >= var_459_10 + var_459_11 and arg_456_1.time_ < var_459_10 + var_459_11 + arg_459_0 and not isNil(var_459_9) and arg_456_1.var_.characterEffect1011ui_story then
				arg_456_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_459_13 = 0

			if var_459_13 < arg_456_1.time_ and arg_456_1.time_ <= var_459_13 + arg_459_0 then
				arg_456_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action3_1")
			end

			local var_459_14 = 0

			if var_459_14 < arg_456_1.time_ and arg_456_1.time_ <= var_459_14 + arg_459_0 then
				arg_456_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_459_15 = 0
			local var_459_16 = 0.475

			if var_459_15 < arg_456_1.time_ and arg_456_1.time_ <= var_459_15 + arg_459_0 then
				arg_456_1.talkMaxDuration = 0
				arg_456_1.dialogCg_.alpha = 1

				arg_456_1.dialog_:SetActive(true)
				SetActive(arg_456_1.leftNameGo_, true)

				local var_459_17 = arg_456_1:FormatText(StoryNameCfg[37].name)

				arg_456_1.leftNameTxt_.text = var_459_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_456_1.leftNameTxt_.transform)

				arg_456_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_456_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_456_1:RecordName(arg_456_1.leftNameTxt_.text)
				SetActive(arg_456_1.iconTrs_.gameObject, false)
				arg_456_1.callingController_:SetSelectedState("normal")

				local var_459_18 = arg_456_1:GetWordFromCfg(1101104113)
				local var_459_19 = arg_456_1:FormatText(var_459_18.content)

				arg_456_1.text_.text = var_459_19

				LuaForUtil.ClearLinePrefixSymbol(arg_456_1.text_)

				local var_459_20 = 19
				local var_459_21 = utf8.len(var_459_19)
				local var_459_22 = var_459_20 <= 0 and var_459_16 or var_459_16 * (var_459_21 / var_459_20)

				if var_459_22 > 0 and var_459_16 < var_459_22 then
					arg_456_1.talkMaxDuration = var_459_22

					if var_459_22 + var_459_15 > arg_456_1.duration_ then
						arg_456_1.duration_ = var_459_22 + var_459_15
					end
				end

				arg_456_1.text_.text = var_459_19
				arg_456_1.typewritter.percent = 0

				arg_456_1.typewritter:SetDirty()
				arg_456_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101104", "1101104113", "story_v_side_new_1101104.awb") ~= 0 then
					local var_459_23 = manager.audio:GetVoiceLength("story_v_side_new_1101104", "1101104113", "story_v_side_new_1101104.awb") / 1000

					if var_459_23 + var_459_15 > arg_456_1.duration_ then
						arg_456_1.duration_ = var_459_23 + var_459_15
					end

					if var_459_18.prefab_name ~= "" and arg_456_1.actors_[var_459_18.prefab_name] ~= nil then
						local var_459_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_456_1.actors_[var_459_18.prefab_name].transform, "story_v_side_new_1101104", "1101104113", "story_v_side_new_1101104.awb")

						arg_456_1:RecordAudio("1101104113", var_459_24)
						arg_456_1:RecordAudio("1101104113", var_459_24)
					else
						arg_456_1:AudioAction("play", "voice", "story_v_side_new_1101104", "1101104113", "story_v_side_new_1101104.awb")
					end

					arg_456_1:RecordHistoryTalkVoice("story_v_side_new_1101104", "1101104113", "story_v_side_new_1101104.awb")
				end

				arg_456_1:RecordContent(arg_456_1.text_.text)
			end

			local var_459_25 = math.max(var_459_16, arg_456_1.talkMaxDuration)

			if var_459_15 <= arg_456_1.time_ and arg_456_1.time_ < var_459_15 + var_459_25 then
				arg_456_1.typewritter.percent = (arg_456_1.time_ - var_459_15) / var_459_25

				arg_456_1.typewritter:SetDirty()
			end

			if arg_456_1.time_ >= var_459_15 + var_459_25 and arg_456_1.time_ < var_459_15 + var_459_25 + arg_459_0 then
				arg_456_1.typewritter.percent = 1

				arg_456_1.typewritter:SetDirty()
				arg_456_1:ShowNextGo(true)
			end
		end

		arg_456_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_456_1:InitPlayNodeList()
	end,
	Play1101104114 = function(arg_460_0, arg_460_1)
		arg_460_1.time_ = 0
		arg_460_1.frameCnt_ = 0
		arg_460_1.state_ = "playing"
		arg_460_1.curTalkId_ = 1101104114
		arg_460_1.duration_ = 9

		SetActive(arg_460_1.tipsGo_, false)

		function arg_460_1.onSingleLineFinish_()
			arg_460_1.onSingleLineUpdate_ = nil
			arg_460_1.onSingleLineFinish_ = nil
			arg_460_1.state_ = "waiting"
		end

		function arg_460_1.playNext_(arg_462_0)
			if arg_462_0 == 1 then
				arg_460_0:Play1101104115(arg_460_1)
			end
		end

		function arg_460_1.onSingleLineUpdate_(arg_463_0)
			local var_463_0 = 2

			if var_463_0 < arg_460_1.time_ and arg_460_1.time_ <= var_463_0 + arg_463_0 then
				local var_463_1 = manager.ui.mainCamera.transform.localPosition
				local var_463_2 = Vector3.New(0, 0, 10) + Vector3.New(var_463_1.x, var_463_1.y, 0)
				local var_463_3 = arg_460_1.bgs_.ST19

				var_463_3.transform.localPosition = var_463_2
				var_463_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_463_4 = var_463_3:GetComponent("SpriteRenderer")

				if var_463_4 and var_463_4.sprite then
					local var_463_5 = (var_463_3.transform.localPosition - var_463_1).z
					local var_463_6 = manager.ui.mainCameraCom_
					local var_463_7 = 2 * var_463_5 * Mathf.Tan(var_463_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_463_8 = var_463_7 * var_463_6.aspect
					local var_463_9 = var_463_4.sprite.bounds.size.x
					local var_463_10 = var_463_4.sprite.bounds.size.y
					local var_463_11 = var_463_8 / var_463_9
					local var_463_12 = var_463_7 / var_463_10
					local var_463_13 = var_463_12 < var_463_11 and var_463_11 or var_463_12

					var_463_3.transform.localScale = Vector3.New(var_463_13, var_463_13, 0)
				end

				for iter_463_0, iter_463_1 in pairs(arg_460_1.bgs_) do
					if iter_463_0 ~= "ST19" then
						iter_463_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_463_14 = 0

			if var_463_14 < arg_460_1.time_ and arg_460_1.time_ <= var_463_14 + arg_463_0 then
				arg_460_1.mask_.enabled = true
				arg_460_1.mask_.raycastTarget = true

				arg_460_1:SetGaussion(false)
			end

			local var_463_15 = 2

			if var_463_14 <= arg_460_1.time_ and arg_460_1.time_ < var_463_14 + var_463_15 then
				local var_463_16 = (arg_460_1.time_ - var_463_14) / var_463_15
				local var_463_17 = Color.New(0, 0, 0)

				var_463_17.a = Mathf.Lerp(0, 1, var_463_16)
				arg_460_1.mask_.color = var_463_17
			end

			if arg_460_1.time_ >= var_463_14 + var_463_15 and arg_460_1.time_ < var_463_14 + var_463_15 + arg_463_0 then
				local var_463_18 = Color.New(0, 0, 0)

				var_463_18.a = 1
				arg_460_1.mask_.color = var_463_18
			end

			local var_463_19 = 2

			if var_463_19 < arg_460_1.time_ and arg_460_1.time_ <= var_463_19 + arg_463_0 then
				arg_460_1.mask_.enabled = true
				arg_460_1.mask_.raycastTarget = true

				arg_460_1:SetGaussion(false)
			end

			local var_463_20 = 2

			if var_463_19 <= arg_460_1.time_ and arg_460_1.time_ < var_463_19 + var_463_20 then
				local var_463_21 = (arg_460_1.time_ - var_463_19) / var_463_20
				local var_463_22 = Color.New(0, 0, 0)

				var_463_22.a = Mathf.Lerp(1, 0, var_463_21)
				arg_460_1.mask_.color = var_463_22
			end

			if arg_460_1.time_ >= var_463_19 + var_463_20 and arg_460_1.time_ < var_463_19 + var_463_20 + arg_463_0 then
				local var_463_23 = Color.New(0, 0, 0)
				local var_463_24 = 0

				arg_460_1.mask_.enabled = false
				var_463_23.a = var_463_24
				arg_460_1.mask_.color = var_463_23
			end

			local var_463_25 = arg_460_1.actors_["1011ui_story"].transform
			local var_463_26 = 2

			if var_463_26 < arg_460_1.time_ and arg_460_1.time_ <= var_463_26 + arg_463_0 then
				arg_460_1.var_.moveOldPos1011ui_story = var_463_25.localPosition
			end

			local var_463_27 = 0.001

			if var_463_26 <= arg_460_1.time_ and arg_460_1.time_ < var_463_26 + var_463_27 then
				local var_463_28 = (arg_460_1.time_ - var_463_26) / var_463_27
				local var_463_29 = Vector3.New(0, 100, 0)

				var_463_25.localPosition = Vector3.Lerp(arg_460_1.var_.moveOldPos1011ui_story, var_463_29, var_463_28)

				local var_463_30 = manager.ui.mainCamera.transform.position - var_463_25.position

				var_463_25.forward = Vector3.New(var_463_30.x, var_463_30.y, var_463_30.z)

				local var_463_31 = var_463_25.localEulerAngles

				var_463_31.z = 0
				var_463_31.x = 0
				var_463_25.localEulerAngles = var_463_31
			end

			if arg_460_1.time_ >= var_463_26 + var_463_27 and arg_460_1.time_ < var_463_26 + var_463_27 + arg_463_0 then
				var_463_25.localPosition = Vector3.New(0, 100, 0)

				local var_463_32 = manager.ui.mainCamera.transform.position - var_463_25.position

				var_463_25.forward = Vector3.New(var_463_32.x, var_463_32.y, var_463_32.z)

				local var_463_33 = var_463_25.localEulerAngles

				var_463_33.z = 0
				var_463_33.x = 0
				var_463_25.localEulerAngles = var_463_33
			end

			local var_463_34 = arg_460_1.actors_["1011ui_story"].transform
			local var_463_35 = 4

			if var_463_35 < arg_460_1.time_ and arg_460_1.time_ <= var_463_35 + arg_463_0 then
				arg_460_1.var_.moveOldPos1011ui_story = var_463_34.localPosition
			end

			local var_463_36 = 0.001

			if var_463_35 <= arg_460_1.time_ and arg_460_1.time_ < var_463_35 + var_463_36 then
				local var_463_37 = (arg_460_1.time_ - var_463_35) / var_463_36
				local var_463_38 = Vector3.New(0, -0.71, -6)

				var_463_34.localPosition = Vector3.Lerp(arg_460_1.var_.moveOldPos1011ui_story, var_463_38, var_463_37)

				local var_463_39 = manager.ui.mainCamera.transform.position - var_463_34.position

				var_463_34.forward = Vector3.New(var_463_39.x, var_463_39.y, var_463_39.z)

				local var_463_40 = var_463_34.localEulerAngles

				var_463_40.z = 0
				var_463_40.x = 0
				var_463_34.localEulerAngles = var_463_40
			end

			if arg_460_1.time_ >= var_463_35 + var_463_36 and arg_460_1.time_ < var_463_35 + var_463_36 + arg_463_0 then
				var_463_34.localPosition = Vector3.New(0, -0.71, -6)

				local var_463_41 = manager.ui.mainCamera.transform.position - var_463_34.position

				var_463_34.forward = Vector3.New(var_463_41.x, var_463_41.y, var_463_41.z)

				local var_463_42 = var_463_34.localEulerAngles

				var_463_42.z = 0
				var_463_42.x = 0
				var_463_34.localEulerAngles = var_463_42
			end

			local var_463_43 = arg_460_1.actors_["1011ui_story"]
			local var_463_44 = 4

			if var_463_44 < arg_460_1.time_ and arg_460_1.time_ <= var_463_44 + arg_463_0 and not isNil(var_463_43) and arg_460_1.var_.characterEffect1011ui_story == nil then
				arg_460_1.var_.characterEffect1011ui_story = var_463_43:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_463_45 = 0.200000002980232

			if var_463_44 <= arg_460_1.time_ and arg_460_1.time_ < var_463_44 + var_463_45 and not isNil(var_463_43) then
				local var_463_46 = (arg_460_1.time_ - var_463_44) / var_463_45

				if arg_460_1.var_.characterEffect1011ui_story and not isNil(var_463_43) then
					local var_463_47 = Mathf.Lerp(0, 0.5, var_463_46)

					arg_460_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_460_1.var_.characterEffect1011ui_story.fillRatio = var_463_47
				end
			end

			if arg_460_1.time_ >= var_463_44 + var_463_45 and arg_460_1.time_ < var_463_44 + var_463_45 + arg_463_0 and not isNil(var_463_43) and arg_460_1.var_.characterEffect1011ui_story then
				local var_463_48 = 0.5

				arg_460_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_460_1.var_.characterEffect1011ui_story.fillRatio = var_463_48
			end

			local var_463_49 = 4

			if var_463_49 < arg_460_1.time_ and arg_460_1.time_ <= var_463_49 + arg_463_0 then
				arg_460_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action2_1")
			end

			local var_463_50 = 4

			if var_463_50 < arg_460_1.time_ and arg_460_1.time_ <= var_463_50 + arg_463_0 then
				arg_460_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			if arg_460_1.frameCnt_ <= 1 then
				arg_460_1.dialog_:SetActive(false)
			end

			local var_463_51 = 4
			local var_463_52 = 0.3

			if var_463_51 < arg_460_1.time_ and arg_460_1.time_ <= var_463_51 + arg_463_0 then
				arg_460_1.talkMaxDuration = 0

				arg_460_1.dialog_:SetActive(true)

				arg_460_1.dialogCg_.alpha = 0

				local var_463_53 = LeanTween.value(arg_460_1.dialog_, 0, 1, 0.3)

				var_463_53:setOnUpdate(LuaHelper.FloatAction(function(arg_464_0)
					arg_460_1.dialogCg_.alpha = arg_464_0
				end))
				var_463_53:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_460_1.dialog_)
					var_463_53:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_460_1.duration_ = arg_460_1.duration_ + 0.3

				SetActive(arg_460_1.leftNameGo_, false)

				arg_460_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_460_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_460_1:RecordName(arg_460_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_460_1.iconTrs_.gameObject, false)
				arg_460_1.callingController_:SetSelectedState("normal")

				local var_463_54 = arg_460_1:GetWordFromCfg(1101104114)
				local var_463_55 = arg_460_1:FormatText(var_463_54.content)

				arg_460_1.text_.text = var_463_55

				LuaForUtil.ClearLinePrefixSymbol(arg_460_1.text_)

				local var_463_56 = 12
				local var_463_57 = utf8.len(var_463_55)
				local var_463_58 = var_463_56 <= 0 and var_463_52 or var_463_52 * (var_463_57 / var_463_56)

				if var_463_58 > 0 and var_463_52 < var_463_58 then
					arg_460_1.talkMaxDuration = var_463_58
					var_463_51 = var_463_51 + 0.3

					if var_463_58 + var_463_51 > arg_460_1.duration_ then
						arg_460_1.duration_ = var_463_58 + var_463_51
					end
				end

				arg_460_1.text_.text = var_463_55
				arg_460_1.typewritter.percent = 0

				arg_460_1.typewritter:SetDirty()
				arg_460_1:ShowNextGo(false)
				arg_460_1:RecordContent(arg_460_1.text_.text)
			end

			local var_463_59 = var_463_51 + 0.3
			local var_463_60 = math.max(var_463_52, arg_460_1.talkMaxDuration)

			if var_463_59 <= arg_460_1.time_ and arg_460_1.time_ < var_463_59 + var_463_60 then
				arg_460_1.typewritter.percent = (arg_460_1.time_ - var_463_59) / var_463_60

				arg_460_1.typewritter:SetDirty()
			end

			if arg_460_1.time_ >= var_463_59 + var_463_60 and arg_460_1.time_ < var_463_59 + var_463_60 + arg_463_0 then
				arg_460_1.typewritter.percent = 1

				arg_460_1.typewritter:SetDirty()
				arg_460_1:ShowNextGo(true)
			end
		end

		arg_460_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_460_1:InitPlayNodeList()
	end,
	Play1101104115 = function(arg_466_0, arg_466_1)
		arg_466_1.time_ = 0
		arg_466_1.frameCnt_ = 0
		arg_466_1.state_ = "playing"
		arg_466_1.curTalkId_ = 1101104115
		arg_466_1.duration_ = 6.1

		local var_466_0 = {
			zh = 4.6,
			ja = 6.1
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
				arg_466_0:Play1101104116(arg_466_1)
			end
		end

		function arg_466_1.onSingleLineUpdate_(arg_469_0)
			local var_469_0 = 0
			local var_469_1 = 0.525

			if var_469_0 < arg_466_1.time_ and arg_466_1.time_ <= var_469_0 + arg_469_0 then
				arg_466_1.talkMaxDuration = 0
				arg_466_1.dialogCg_.alpha = 1

				arg_466_1.dialog_:SetActive(true)
				SetActive(arg_466_1.leftNameGo_, true)

				local var_469_2 = arg_466_1:FormatText(StoryNameCfg[67].name)

				arg_466_1.leftNameTxt_.text = var_469_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_466_1.leftNameTxt_.transform)

				arg_466_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_466_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_466_1:RecordName(arg_466_1.leftNameTxt_.text)
				SetActive(arg_466_1.iconTrs_.gameObject, true)
				arg_466_1.iconController_:SetSelectedState("hero")

				arg_466_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1111")

				arg_466_1.callingController_:SetSelectedState("normal")

				arg_466_1.keyicon_.color = Color.New(1, 1, 1)
				arg_466_1.icon_.color = Color.New(1, 1, 1)

				local var_469_3 = arg_466_1:GetWordFromCfg(1101104115)
				local var_469_4 = arg_466_1:FormatText(var_469_3.content)

				arg_466_1.text_.text = var_469_4

				LuaForUtil.ClearLinePrefixSymbol(arg_466_1.text_)

				local var_469_5 = 21
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

				if manager.audio:GetVoiceLength("story_v_side_new_1101104", "1101104115", "story_v_side_new_1101104.awb") ~= 0 then
					local var_469_8 = manager.audio:GetVoiceLength("story_v_side_new_1101104", "1101104115", "story_v_side_new_1101104.awb") / 1000

					if var_469_8 + var_469_0 > arg_466_1.duration_ then
						arg_466_1.duration_ = var_469_8 + var_469_0
					end

					if var_469_3.prefab_name ~= "" and arg_466_1.actors_[var_469_3.prefab_name] ~= nil then
						local var_469_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_466_1.actors_[var_469_3.prefab_name].transform, "story_v_side_new_1101104", "1101104115", "story_v_side_new_1101104.awb")

						arg_466_1:RecordAudio("1101104115", var_469_9)
						arg_466_1:RecordAudio("1101104115", var_469_9)
					else
						arg_466_1:AudioAction("play", "voice", "story_v_side_new_1101104", "1101104115", "story_v_side_new_1101104.awb")
					end

					arg_466_1:RecordHistoryTalkVoice("story_v_side_new_1101104", "1101104115", "story_v_side_new_1101104.awb")
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
	Play1101104116 = function(arg_470_0, arg_470_1)
		arg_470_1.time_ = 0
		arg_470_1.frameCnt_ = 0
		arg_470_1.state_ = "playing"
		arg_470_1.curTalkId_ = 1101104116
		arg_470_1.duration_ = 5

		SetActive(arg_470_1.tipsGo_, false)

		function arg_470_1.onSingleLineFinish_()
			arg_470_1.onSingleLineUpdate_ = nil
			arg_470_1.onSingleLineFinish_ = nil
			arg_470_1.state_ = "waiting"
		end

		function arg_470_1.playNext_(arg_472_0)
			if arg_472_0 == 1 then
				arg_470_0:Play1101104117(arg_470_1)
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

				local var_473_2 = arg_470_1:FormatText(StoryNameCfg[344].name)

				arg_470_1.leftNameTxt_.text = var_473_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_470_1.leftNameTxt_.transform)

				arg_470_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_470_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_470_1:RecordName(arg_470_1.leftNameTxt_.text)
				SetActive(arg_470_1.iconTrs_.gameObject, false)
				arg_470_1.callingController_:SetSelectedState("normal")

				local var_473_3 = arg_470_1:GetWordFromCfg(1101104116)
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
	Play1101104117 = function(arg_474_0, arg_474_1)
		arg_474_1.time_ = 0
		arg_474_1.frameCnt_ = 0
		arg_474_1.state_ = "playing"
		arg_474_1.curTalkId_ = 1101104117
		arg_474_1.duration_ = 2

		SetActive(arg_474_1.tipsGo_, false)

		function arg_474_1.onSingleLineFinish_()
			arg_474_1.onSingleLineUpdate_ = nil
			arg_474_1.onSingleLineFinish_ = nil
			arg_474_1.state_ = "waiting"
		end

		function arg_474_1.playNext_(arg_476_0)
			if arg_476_0 == 1 then
				arg_474_0:Play1101104118(arg_474_1)
			end
		end

		function arg_474_1.onSingleLineUpdate_(arg_477_0)
			local var_477_0 = arg_474_1.actors_["1011ui_story"].transform
			local var_477_1 = 0

			if var_477_1 < arg_474_1.time_ and arg_474_1.time_ <= var_477_1 + arg_477_0 then
				arg_474_1.var_.moveOldPos1011ui_story = var_477_0.localPosition
			end

			local var_477_2 = 0.001

			if var_477_1 <= arg_474_1.time_ and arg_474_1.time_ < var_477_1 + var_477_2 then
				local var_477_3 = (arg_474_1.time_ - var_477_1) / var_477_2
				local var_477_4 = Vector3.New(0, -0.71, -6)

				var_477_0.localPosition = Vector3.Lerp(arg_474_1.var_.moveOldPos1011ui_story, var_477_4, var_477_3)

				local var_477_5 = manager.ui.mainCamera.transform.position - var_477_0.position

				var_477_0.forward = Vector3.New(var_477_5.x, var_477_5.y, var_477_5.z)

				local var_477_6 = var_477_0.localEulerAngles

				var_477_6.z = 0
				var_477_6.x = 0
				var_477_0.localEulerAngles = var_477_6
			end

			if arg_474_1.time_ >= var_477_1 + var_477_2 and arg_474_1.time_ < var_477_1 + var_477_2 + arg_477_0 then
				var_477_0.localPosition = Vector3.New(0, -0.71, -6)

				local var_477_7 = manager.ui.mainCamera.transform.position - var_477_0.position

				var_477_0.forward = Vector3.New(var_477_7.x, var_477_7.y, var_477_7.z)

				local var_477_8 = var_477_0.localEulerAngles

				var_477_8.z = 0
				var_477_8.x = 0
				var_477_0.localEulerAngles = var_477_8
			end

			local var_477_9 = arg_474_1.actors_["1011ui_story"]
			local var_477_10 = 0

			if var_477_10 < arg_474_1.time_ and arg_474_1.time_ <= var_477_10 + arg_477_0 and not isNil(var_477_9) and arg_474_1.var_.characterEffect1011ui_story == nil then
				arg_474_1.var_.characterEffect1011ui_story = var_477_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_477_11 = 0.200000002980232

			if var_477_10 <= arg_474_1.time_ and arg_474_1.time_ < var_477_10 + var_477_11 and not isNil(var_477_9) then
				local var_477_12 = (arg_474_1.time_ - var_477_10) / var_477_11

				if arg_474_1.var_.characterEffect1011ui_story and not isNil(var_477_9) then
					arg_474_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_474_1.time_ >= var_477_10 + var_477_11 and arg_474_1.time_ < var_477_10 + var_477_11 + arg_477_0 and not isNil(var_477_9) and arg_474_1.var_.characterEffect1011ui_story then
				arg_474_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_477_13 = 0

			if var_477_13 < arg_474_1.time_ and arg_474_1.time_ <= var_477_13 + arg_477_0 then
				arg_474_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_477_14 = 0
			local var_477_15 = 0.125

			if var_477_14 < arg_474_1.time_ and arg_474_1.time_ <= var_477_14 + arg_477_0 then
				arg_474_1.talkMaxDuration = 0
				arg_474_1.dialogCg_.alpha = 1

				arg_474_1.dialog_:SetActive(true)
				SetActive(arg_474_1.leftNameGo_, true)

				local var_477_16 = arg_474_1:FormatText(StoryNameCfg[37].name)

				arg_474_1.leftNameTxt_.text = var_477_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_474_1.leftNameTxt_.transform)

				arg_474_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_474_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_474_1:RecordName(arg_474_1.leftNameTxt_.text)
				SetActive(arg_474_1.iconTrs_.gameObject, false)
				arg_474_1.callingController_:SetSelectedState("normal")

				local var_477_17 = arg_474_1:GetWordFromCfg(1101104117)
				local var_477_18 = arg_474_1:FormatText(var_477_17.content)

				arg_474_1.text_.text = var_477_18

				LuaForUtil.ClearLinePrefixSymbol(arg_474_1.text_)

				local var_477_19 = 5
				local var_477_20 = utf8.len(var_477_18)
				local var_477_21 = var_477_19 <= 0 and var_477_15 or var_477_15 * (var_477_20 / var_477_19)

				if var_477_21 > 0 and var_477_15 < var_477_21 then
					arg_474_1.talkMaxDuration = var_477_21

					if var_477_21 + var_477_14 > arg_474_1.duration_ then
						arg_474_1.duration_ = var_477_21 + var_477_14
					end
				end

				arg_474_1.text_.text = var_477_18
				arg_474_1.typewritter.percent = 0

				arg_474_1.typewritter:SetDirty()
				arg_474_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101104", "1101104117", "story_v_side_new_1101104.awb") ~= 0 then
					local var_477_22 = manager.audio:GetVoiceLength("story_v_side_new_1101104", "1101104117", "story_v_side_new_1101104.awb") / 1000

					if var_477_22 + var_477_14 > arg_474_1.duration_ then
						arg_474_1.duration_ = var_477_22 + var_477_14
					end

					if var_477_17.prefab_name ~= "" and arg_474_1.actors_[var_477_17.prefab_name] ~= nil then
						local var_477_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_474_1.actors_[var_477_17.prefab_name].transform, "story_v_side_new_1101104", "1101104117", "story_v_side_new_1101104.awb")

						arg_474_1:RecordAudio("1101104117", var_477_23)
						arg_474_1:RecordAudio("1101104117", var_477_23)
					else
						arg_474_1:AudioAction("play", "voice", "story_v_side_new_1101104", "1101104117", "story_v_side_new_1101104.awb")
					end

					arg_474_1:RecordHistoryTalkVoice("story_v_side_new_1101104", "1101104117", "story_v_side_new_1101104.awb")
				end

				arg_474_1:RecordContent(arg_474_1.text_.text)
			end

			local var_477_24 = math.max(var_477_15, arg_474_1.talkMaxDuration)

			if var_477_14 <= arg_474_1.time_ and arg_474_1.time_ < var_477_14 + var_477_24 then
				arg_474_1.typewritter.percent = (arg_474_1.time_ - var_477_14) / var_477_24

				arg_474_1.typewritter:SetDirty()
			end

			if arg_474_1.time_ >= var_477_14 + var_477_24 and arg_474_1.time_ < var_477_14 + var_477_24 + arg_477_0 then
				arg_474_1.typewritter.percent = 1

				arg_474_1.typewritter:SetDirty()
				arg_474_1:ShowNextGo(true)
			end
		end

		arg_474_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_474_1:InitPlayNodeList()
	end,
	Play1101104118 = function(arg_478_0, arg_478_1)
		arg_478_1.time_ = 0
		arg_478_1.frameCnt_ = 0
		arg_478_1.state_ = "playing"
		arg_478_1.curTalkId_ = 1101104118
		arg_478_1.duration_ = 9

		SetActive(arg_478_1.tipsGo_, false)

		function arg_478_1.onSingleLineFinish_()
			arg_478_1.onSingleLineUpdate_ = nil
			arg_478_1.onSingleLineFinish_ = nil
			arg_478_1.state_ = "waiting"
		end

		function arg_478_1.playNext_(arg_480_0)
			if arg_480_0 == 1 then
				arg_478_0:Play1101104119(arg_478_1)
			end
		end

		function arg_478_1.onSingleLineUpdate_(arg_481_0)
			local var_481_0 = 2

			if var_481_0 < arg_478_1.time_ and arg_478_1.time_ <= var_481_0 + arg_481_0 then
				local var_481_1 = manager.ui.mainCamera.transform.localPosition
				local var_481_2 = Vector3.New(0, 0, 10) + Vector3.New(var_481_1.x, var_481_1.y, 0)
				local var_481_3 = arg_478_1.bgs_.ST19

				var_481_3.transform.localPosition = var_481_2
				var_481_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_481_4 = var_481_3:GetComponent("SpriteRenderer")

				if var_481_4 and var_481_4.sprite then
					local var_481_5 = (var_481_3.transform.localPosition - var_481_1).z
					local var_481_6 = manager.ui.mainCameraCom_
					local var_481_7 = 2 * var_481_5 * Mathf.Tan(var_481_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_481_8 = var_481_7 * var_481_6.aspect
					local var_481_9 = var_481_4.sprite.bounds.size.x
					local var_481_10 = var_481_4.sprite.bounds.size.y
					local var_481_11 = var_481_8 / var_481_9
					local var_481_12 = var_481_7 / var_481_10
					local var_481_13 = var_481_12 < var_481_11 and var_481_11 or var_481_12

					var_481_3.transform.localScale = Vector3.New(var_481_13, var_481_13, 0)
				end

				for iter_481_0, iter_481_1 in pairs(arg_478_1.bgs_) do
					if iter_481_0 ~= "ST19" then
						iter_481_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_481_14 = 0

			if var_481_14 < arg_478_1.time_ and arg_478_1.time_ <= var_481_14 + arg_481_0 then
				arg_478_1.mask_.enabled = true
				arg_478_1.mask_.raycastTarget = true

				arg_478_1:SetGaussion(false)
			end

			local var_481_15 = 2

			if var_481_14 <= arg_478_1.time_ and arg_478_1.time_ < var_481_14 + var_481_15 then
				local var_481_16 = (arg_478_1.time_ - var_481_14) / var_481_15
				local var_481_17 = Color.New(0, 0, 0)

				var_481_17.a = Mathf.Lerp(0, 1, var_481_16)
				arg_478_1.mask_.color = var_481_17
			end

			if arg_478_1.time_ >= var_481_14 + var_481_15 and arg_478_1.time_ < var_481_14 + var_481_15 + arg_481_0 then
				local var_481_18 = Color.New(0, 0, 0)

				var_481_18.a = 1
				arg_478_1.mask_.color = var_481_18
			end

			local var_481_19 = 2

			if var_481_19 < arg_478_1.time_ and arg_478_1.time_ <= var_481_19 + arg_481_0 then
				arg_478_1.mask_.enabled = true
				arg_478_1.mask_.raycastTarget = true

				arg_478_1:SetGaussion(false)
			end

			local var_481_20 = 2

			if var_481_19 <= arg_478_1.time_ and arg_478_1.time_ < var_481_19 + var_481_20 then
				local var_481_21 = (arg_478_1.time_ - var_481_19) / var_481_20
				local var_481_22 = Color.New(0, 0, 0)

				var_481_22.a = Mathf.Lerp(1, 0, var_481_21)
				arg_478_1.mask_.color = var_481_22
			end

			if arg_478_1.time_ >= var_481_19 + var_481_20 and arg_478_1.time_ < var_481_19 + var_481_20 + arg_481_0 then
				local var_481_23 = Color.New(0, 0, 0)
				local var_481_24 = 0

				arg_478_1.mask_.enabled = false
				var_481_23.a = var_481_24
				arg_478_1.mask_.color = var_481_23
			end

			local var_481_25 = arg_478_1.actors_["1011ui_story"].transform
			local var_481_26 = 2

			if var_481_26 < arg_478_1.time_ and arg_478_1.time_ <= var_481_26 + arg_481_0 then
				arg_478_1.var_.moveOldPos1011ui_story = var_481_25.localPosition
			end

			local var_481_27 = 0.001

			if var_481_26 <= arg_478_1.time_ and arg_478_1.time_ < var_481_26 + var_481_27 then
				local var_481_28 = (arg_478_1.time_ - var_481_26) / var_481_27
				local var_481_29 = Vector3.New(0, 100, 0)

				var_481_25.localPosition = Vector3.Lerp(arg_478_1.var_.moveOldPos1011ui_story, var_481_29, var_481_28)

				local var_481_30 = manager.ui.mainCamera.transform.position - var_481_25.position

				var_481_25.forward = Vector3.New(var_481_30.x, var_481_30.y, var_481_30.z)

				local var_481_31 = var_481_25.localEulerAngles

				var_481_31.z = 0
				var_481_31.x = 0
				var_481_25.localEulerAngles = var_481_31
			end

			if arg_478_1.time_ >= var_481_26 + var_481_27 and arg_478_1.time_ < var_481_26 + var_481_27 + arg_481_0 then
				var_481_25.localPosition = Vector3.New(0, 100, 0)

				local var_481_32 = manager.ui.mainCamera.transform.position - var_481_25.position

				var_481_25.forward = Vector3.New(var_481_32.x, var_481_32.y, var_481_32.z)

				local var_481_33 = var_481_25.localEulerAngles

				var_481_33.z = 0
				var_481_33.x = 0
				var_481_25.localEulerAngles = var_481_33
			end

			local var_481_34 = arg_478_1.actors_["1011ui_story"].transform
			local var_481_35 = 4

			if var_481_35 < arg_478_1.time_ and arg_478_1.time_ <= var_481_35 + arg_481_0 then
				arg_478_1.var_.moveOldPos1011ui_story = var_481_34.localPosition
			end

			local var_481_36 = 0.001

			if var_481_35 <= arg_478_1.time_ and arg_478_1.time_ < var_481_35 + var_481_36 then
				local var_481_37 = (arg_478_1.time_ - var_481_35) / var_481_36
				local var_481_38 = Vector3.New(0, -0.71, -6)

				var_481_34.localPosition = Vector3.Lerp(arg_478_1.var_.moveOldPos1011ui_story, var_481_38, var_481_37)

				local var_481_39 = manager.ui.mainCamera.transform.position - var_481_34.position

				var_481_34.forward = Vector3.New(var_481_39.x, var_481_39.y, var_481_39.z)

				local var_481_40 = var_481_34.localEulerAngles

				var_481_40.z = 0
				var_481_40.x = 0
				var_481_34.localEulerAngles = var_481_40
			end

			if arg_478_1.time_ >= var_481_35 + var_481_36 and arg_478_1.time_ < var_481_35 + var_481_36 + arg_481_0 then
				var_481_34.localPosition = Vector3.New(0, -0.71, -6)

				local var_481_41 = manager.ui.mainCamera.transform.position - var_481_34.position

				var_481_34.forward = Vector3.New(var_481_41.x, var_481_41.y, var_481_41.z)

				local var_481_42 = var_481_34.localEulerAngles

				var_481_42.z = 0
				var_481_42.x = 0
				var_481_34.localEulerAngles = var_481_42
			end

			local var_481_43 = arg_478_1.actors_["1011ui_story"]
			local var_481_44 = 4

			if var_481_44 < arg_478_1.time_ and arg_478_1.time_ <= var_481_44 + arg_481_0 and not isNil(var_481_43) and arg_478_1.var_.characterEffect1011ui_story == nil then
				arg_478_1.var_.characterEffect1011ui_story = var_481_43:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_481_45 = 0.200000002980232

			if var_481_44 <= arg_478_1.time_ and arg_478_1.time_ < var_481_44 + var_481_45 and not isNil(var_481_43) then
				local var_481_46 = (arg_478_1.time_ - var_481_44) / var_481_45

				if arg_478_1.var_.characterEffect1011ui_story and not isNil(var_481_43) then
					arg_478_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_478_1.time_ >= var_481_44 + var_481_45 and arg_478_1.time_ < var_481_44 + var_481_45 + arg_481_0 and not isNil(var_481_43) and arg_478_1.var_.characterEffect1011ui_story then
				arg_478_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_481_47 = 4

			if var_481_47 < arg_478_1.time_ and arg_478_1.time_ <= var_481_47 + arg_481_0 then
				arg_478_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action6_1")
			end

			local var_481_48 = 4

			if var_481_48 < arg_478_1.time_ and arg_478_1.time_ <= var_481_48 + arg_481_0 then
				arg_478_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			if arg_478_1.frameCnt_ <= 1 then
				arg_478_1.dialog_:SetActive(false)
			end

			local var_481_49 = 4
			local var_481_50 = 0.35

			if var_481_49 < arg_478_1.time_ and arg_478_1.time_ <= var_481_49 + arg_481_0 then
				arg_478_1.talkMaxDuration = 0

				arg_478_1.dialog_:SetActive(true)

				arg_478_1.dialogCg_.alpha = 0

				local var_481_51 = LeanTween.value(arg_478_1.dialog_, 0, 1, 0.3)

				var_481_51:setOnUpdate(LuaHelper.FloatAction(function(arg_482_0)
					arg_478_1.dialogCg_.alpha = arg_482_0
				end))
				var_481_51:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_478_1.dialog_)
					var_481_51:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_478_1.duration_ = arg_478_1.duration_ + 0.3

				SetActive(arg_478_1.leftNameGo_, false)

				arg_478_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_478_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_478_1:RecordName(arg_478_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_478_1.iconTrs_.gameObject, false)
				arg_478_1.callingController_:SetSelectedState("normal")

				local var_481_52 = arg_478_1:GetWordFromCfg(1101104118)
				local var_481_53 = arg_478_1:FormatText(var_481_52.content)

				arg_478_1.text_.text = var_481_53

				LuaForUtil.ClearLinePrefixSymbol(arg_478_1.text_)

				local var_481_54 = 14
				local var_481_55 = utf8.len(var_481_53)
				local var_481_56 = var_481_54 <= 0 and var_481_50 or var_481_50 * (var_481_55 / var_481_54)

				if var_481_56 > 0 and var_481_50 < var_481_56 then
					arg_478_1.talkMaxDuration = var_481_56
					var_481_49 = var_481_49 + 0.3

					if var_481_56 + var_481_49 > arg_478_1.duration_ then
						arg_478_1.duration_ = var_481_56 + var_481_49
					end
				end

				arg_478_1.text_.text = var_481_53
				arg_478_1.typewritter.percent = 0

				arg_478_1.typewritter:SetDirty()
				arg_478_1:ShowNextGo(false)
				arg_478_1:RecordContent(arg_478_1.text_.text)
			end

			local var_481_57 = var_481_49 + 0.3
			local var_481_58 = math.max(var_481_50, arg_478_1.talkMaxDuration)

			if var_481_57 <= arg_478_1.time_ and arg_478_1.time_ < var_481_57 + var_481_58 then
				arg_478_1.typewritter.percent = (arg_478_1.time_ - var_481_57) / var_481_58

				arg_478_1.typewritter:SetDirty()
			end

			if arg_478_1.time_ >= var_481_57 + var_481_58 and arg_478_1.time_ < var_481_57 + var_481_58 + arg_481_0 then
				arg_478_1.typewritter.percent = 1

				arg_478_1.typewritter:SetDirty()
				arg_478_1:ShowNextGo(true)
			end
		end

		arg_478_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_478_1:InitPlayNodeList()
	end,
	Play1101104119 = function(arg_484_0, arg_484_1)
		arg_484_1.time_ = 0
		arg_484_1.frameCnt_ = 0
		arg_484_1.state_ = "playing"
		arg_484_1.curTalkId_ = 1101104119
		arg_484_1.duration_ = 7.93

		local var_484_0 = {
			zh = 7.933,
			ja = 5.866
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
				arg_484_0:Play1101104120(arg_484_1)
			end
		end

		function arg_484_1.onSingleLineUpdate_(arg_487_0)
			local var_487_0 = arg_484_1.actors_["1011ui_story"]
			local var_487_1 = 0

			if var_487_1 < arg_484_1.time_ and arg_484_1.time_ <= var_487_1 + arg_487_0 and not isNil(var_487_0) and arg_484_1.var_.characterEffect1011ui_story == nil then
				arg_484_1.var_.characterEffect1011ui_story = var_487_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_487_2 = 0.200000002980232

			if var_487_1 <= arg_484_1.time_ and arg_484_1.time_ < var_487_1 + var_487_2 and not isNil(var_487_0) then
				local var_487_3 = (arg_484_1.time_ - var_487_1) / var_487_2

				if arg_484_1.var_.characterEffect1011ui_story and not isNil(var_487_0) then
					arg_484_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_484_1.time_ >= var_487_1 + var_487_2 and arg_484_1.time_ < var_487_1 + var_487_2 + arg_487_0 and not isNil(var_487_0) and arg_484_1.var_.characterEffect1011ui_story then
				arg_484_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_487_4 = 0
			local var_487_5 = 0.475

			if var_487_4 < arg_484_1.time_ and arg_484_1.time_ <= var_487_4 + arg_487_0 then
				arg_484_1.talkMaxDuration = 0
				arg_484_1.dialogCg_.alpha = 1

				arg_484_1.dialog_:SetActive(true)
				SetActive(arg_484_1.leftNameGo_, true)

				local var_487_6 = arg_484_1:FormatText(StoryNameCfg[37].name)

				arg_484_1.leftNameTxt_.text = var_487_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_484_1.leftNameTxt_.transform)

				arg_484_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_484_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_484_1:RecordName(arg_484_1.leftNameTxt_.text)
				SetActive(arg_484_1.iconTrs_.gameObject, false)
				arg_484_1.callingController_:SetSelectedState("normal")

				local var_487_7 = arg_484_1:GetWordFromCfg(1101104119)
				local var_487_8 = arg_484_1:FormatText(var_487_7.content)

				arg_484_1.text_.text = var_487_8

				LuaForUtil.ClearLinePrefixSymbol(arg_484_1.text_)

				local var_487_9 = 19
				local var_487_10 = utf8.len(var_487_8)
				local var_487_11 = var_487_9 <= 0 and var_487_5 or var_487_5 * (var_487_10 / var_487_9)

				if var_487_11 > 0 and var_487_5 < var_487_11 then
					arg_484_1.talkMaxDuration = var_487_11

					if var_487_11 + var_487_4 > arg_484_1.duration_ then
						arg_484_1.duration_ = var_487_11 + var_487_4
					end
				end

				arg_484_1.text_.text = var_487_8
				arg_484_1.typewritter.percent = 0

				arg_484_1.typewritter:SetDirty()
				arg_484_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101104", "1101104119", "story_v_side_new_1101104.awb") ~= 0 then
					local var_487_12 = manager.audio:GetVoiceLength("story_v_side_new_1101104", "1101104119", "story_v_side_new_1101104.awb") / 1000

					if var_487_12 + var_487_4 > arg_484_1.duration_ then
						arg_484_1.duration_ = var_487_12 + var_487_4
					end

					if var_487_7.prefab_name ~= "" and arg_484_1.actors_[var_487_7.prefab_name] ~= nil then
						local var_487_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_484_1.actors_[var_487_7.prefab_name].transform, "story_v_side_new_1101104", "1101104119", "story_v_side_new_1101104.awb")

						arg_484_1:RecordAudio("1101104119", var_487_13)
						arg_484_1:RecordAudio("1101104119", var_487_13)
					else
						arg_484_1:AudioAction("play", "voice", "story_v_side_new_1101104", "1101104119", "story_v_side_new_1101104.awb")
					end

					arg_484_1:RecordHistoryTalkVoice("story_v_side_new_1101104", "1101104119", "story_v_side_new_1101104.awb")
				end

				arg_484_1:RecordContent(arg_484_1.text_.text)
			end

			local var_487_14 = math.max(var_487_5, arg_484_1.talkMaxDuration)

			if var_487_4 <= arg_484_1.time_ and arg_484_1.time_ < var_487_4 + var_487_14 then
				arg_484_1.typewritter.percent = (arg_484_1.time_ - var_487_4) / var_487_14

				arg_484_1.typewritter:SetDirty()
			end

			if arg_484_1.time_ >= var_487_4 + var_487_14 and arg_484_1.time_ < var_487_4 + var_487_14 + arg_487_0 then
				arg_484_1.typewritter.percent = 1

				arg_484_1.typewritter:SetDirty()
				arg_484_1:ShowNextGo(true)
			end
		end

		arg_484_1.nodeConfigList_ = {}

		arg_484_1:InitPlayNodeList()
	end,
	Play1101104120 = function(arg_488_0, arg_488_1)
		arg_488_1.time_ = 0
		arg_488_1.frameCnt_ = 0
		arg_488_1.state_ = "playing"
		arg_488_1.curTalkId_ = 1101104120
		arg_488_1.duration_ = 5

		SetActive(arg_488_1.tipsGo_, false)

		function arg_488_1.onSingleLineFinish_()
			arg_488_1.onSingleLineUpdate_ = nil
			arg_488_1.onSingleLineFinish_ = nil
			arg_488_1.state_ = "waiting"
		end

		function arg_488_1.playNext_(arg_490_0)
			if arg_490_0 == 1 then
				arg_488_0:Play1101104121(arg_488_1)
			end
		end

		function arg_488_1.onSingleLineUpdate_(arg_491_0)
			local var_491_0 = arg_488_1.actors_["1011ui_story"]
			local var_491_1 = 0

			if var_491_1 < arg_488_1.time_ and arg_488_1.time_ <= var_491_1 + arg_491_0 and not isNil(var_491_0) and arg_488_1.var_.characterEffect1011ui_story == nil then
				arg_488_1.var_.characterEffect1011ui_story = var_491_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_491_2 = 0.200000002980232

			if var_491_1 <= arg_488_1.time_ and arg_488_1.time_ < var_491_1 + var_491_2 and not isNil(var_491_0) then
				local var_491_3 = (arg_488_1.time_ - var_491_1) / var_491_2

				if arg_488_1.var_.characterEffect1011ui_story and not isNil(var_491_0) then
					local var_491_4 = Mathf.Lerp(0, 0.5, var_491_3)

					arg_488_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_488_1.var_.characterEffect1011ui_story.fillRatio = var_491_4
				end
			end

			if arg_488_1.time_ >= var_491_1 + var_491_2 and arg_488_1.time_ < var_491_1 + var_491_2 + arg_491_0 and not isNil(var_491_0) and arg_488_1.var_.characterEffect1011ui_story then
				local var_491_5 = 0.5

				arg_488_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_488_1.var_.characterEffect1011ui_story.fillRatio = var_491_5
			end

			local var_491_6 = 0
			local var_491_7 = 0.275

			if var_491_6 < arg_488_1.time_ and arg_488_1.time_ <= var_491_6 + arg_491_0 then
				arg_488_1.talkMaxDuration = 0
				arg_488_1.dialogCg_.alpha = 1

				arg_488_1.dialog_:SetActive(true)
				SetActive(arg_488_1.leftNameGo_, true)

				local var_491_8 = arg_488_1:FormatText(StoryNameCfg[344].name)

				arg_488_1.leftNameTxt_.text = var_491_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_488_1.leftNameTxt_.transform)

				arg_488_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_488_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_488_1:RecordName(arg_488_1.leftNameTxt_.text)
				SetActive(arg_488_1.iconTrs_.gameObject, false)
				arg_488_1.callingController_:SetSelectedState("normal")

				local var_491_9 = arg_488_1:GetWordFromCfg(1101104120)
				local var_491_10 = arg_488_1:FormatText(var_491_9.content)

				arg_488_1.text_.text = var_491_10

				LuaForUtil.ClearLinePrefixSymbol(arg_488_1.text_)

				local var_491_11 = 11
				local var_491_12 = utf8.len(var_491_10)
				local var_491_13 = var_491_11 <= 0 and var_491_7 or var_491_7 * (var_491_12 / var_491_11)

				if var_491_13 > 0 and var_491_7 < var_491_13 then
					arg_488_1.talkMaxDuration = var_491_13

					if var_491_13 + var_491_6 > arg_488_1.duration_ then
						arg_488_1.duration_ = var_491_13 + var_491_6
					end
				end

				arg_488_1.text_.text = var_491_10
				arg_488_1.typewritter.percent = 0

				arg_488_1.typewritter:SetDirty()
				arg_488_1:ShowNextGo(false)
				arg_488_1:RecordContent(arg_488_1.text_.text)
			end

			local var_491_14 = math.max(var_491_7, arg_488_1.talkMaxDuration)

			if var_491_6 <= arg_488_1.time_ and arg_488_1.time_ < var_491_6 + var_491_14 then
				arg_488_1.typewritter.percent = (arg_488_1.time_ - var_491_6) / var_491_14

				arg_488_1.typewritter:SetDirty()
			end

			if arg_488_1.time_ >= var_491_6 + var_491_14 and arg_488_1.time_ < var_491_6 + var_491_14 + arg_491_0 then
				arg_488_1.typewritter.percent = 1

				arg_488_1.typewritter:SetDirty()
				arg_488_1:ShowNextGo(true)
			end
		end

		arg_488_1.nodeConfigList_ = {}

		arg_488_1:InitPlayNodeList()
	end,
	Play1101104121 = function(arg_492_0, arg_492_1)
		arg_492_1.time_ = 0
		arg_492_1.frameCnt_ = 0
		arg_492_1.state_ = "playing"
		arg_492_1.curTalkId_ = 1101104121
		arg_492_1.duration_ = 2.1

		local var_492_0 = {
			zh = 1.666,
			ja = 2.1
		}
		local var_492_1 = manager.audio:GetLocalizationFlag()

		if var_492_0[var_492_1] ~= nil then
			arg_492_1.duration_ = var_492_0[var_492_1]
		end

		SetActive(arg_492_1.tipsGo_, false)

		function arg_492_1.onSingleLineFinish_()
			arg_492_1.onSingleLineUpdate_ = nil
			arg_492_1.onSingleLineFinish_ = nil
			arg_492_1.state_ = "waiting"
		end

		function arg_492_1.playNext_(arg_494_0)
			if arg_494_0 == 1 then
				arg_492_0:Play1101104122(arg_492_1)
			end
		end

		function arg_492_1.onSingleLineUpdate_(arg_495_0)
			local var_495_0 = 0
			local var_495_1 = 0.075

			if var_495_0 < arg_492_1.time_ and arg_492_1.time_ <= var_495_0 + arg_495_0 then
				arg_492_1.talkMaxDuration = 0
				arg_492_1.dialogCg_.alpha = 1

				arg_492_1.dialog_:SetActive(true)
				SetActive(arg_492_1.leftNameGo_, true)

				local var_495_2 = arg_492_1:FormatText(StoryNameCfg[67].name)

				arg_492_1.leftNameTxt_.text = var_495_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_492_1.leftNameTxt_.transform)

				arg_492_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_492_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_492_1:RecordName(arg_492_1.leftNameTxt_.text)
				SetActive(arg_492_1.iconTrs_.gameObject, true)
				arg_492_1.iconController_:SetSelectedState("hero")

				arg_492_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1111")

				arg_492_1.callingController_:SetSelectedState("normal")

				arg_492_1.keyicon_.color = Color.New(1, 1, 1)
				arg_492_1.icon_.color = Color.New(1, 1, 1)

				local var_495_3 = arg_492_1:GetWordFromCfg(1101104121)
				local var_495_4 = arg_492_1:FormatText(var_495_3.content)

				arg_492_1.text_.text = var_495_4

				LuaForUtil.ClearLinePrefixSymbol(arg_492_1.text_)

				local var_495_5 = 3
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

				if manager.audio:GetVoiceLength("story_v_side_new_1101104", "1101104121", "story_v_side_new_1101104.awb") ~= 0 then
					local var_495_8 = manager.audio:GetVoiceLength("story_v_side_new_1101104", "1101104121", "story_v_side_new_1101104.awb") / 1000

					if var_495_8 + var_495_0 > arg_492_1.duration_ then
						arg_492_1.duration_ = var_495_8 + var_495_0
					end

					if var_495_3.prefab_name ~= "" and arg_492_1.actors_[var_495_3.prefab_name] ~= nil then
						local var_495_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_492_1.actors_[var_495_3.prefab_name].transform, "story_v_side_new_1101104", "1101104121", "story_v_side_new_1101104.awb")

						arg_492_1:RecordAudio("1101104121", var_495_9)
						arg_492_1:RecordAudio("1101104121", var_495_9)
					else
						arg_492_1:AudioAction("play", "voice", "story_v_side_new_1101104", "1101104121", "story_v_side_new_1101104.awb")
					end

					arg_492_1:RecordHistoryTalkVoice("story_v_side_new_1101104", "1101104121", "story_v_side_new_1101104.awb")
				end

				arg_492_1:RecordContent(arg_492_1.text_.text)
			end

			local var_495_10 = math.max(var_495_1, arg_492_1.talkMaxDuration)

			if var_495_0 <= arg_492_1.time_ and arg_492_1.time_ < var_495_0 + var_495_10 then
				arg_492_1.typewritter.percent = (arg_492_1.time_ - var_495_0) / var_495_10

				arg_492_1.typewritter:SetDirty()
			end

			if arg_492_1.time_ >= var_495_0 + var_495_10 and arg_492_1.time_ < var_495_0 + var_495_10 + arg_495_0 then
				arg_492_1.typewritter.percent = 1

				arg_492_1.typewritter:SetDirty()
				arg_492_1:ShowNextGo(true)
			end
		end

		arg_492_1.nodeConfigList_ = {}

		arg_492_1:InitPlayNodeList()
	end,
	Play1101104122 = function(arg_496_0, arg_496_1)
		arg_496_1.time_ = 0
		arg_496_1.frameCnt_ = 0
		arg_496_1.state_ = "playing"
		arg_496_1.curTalkId_ = 1101104122
		arg_496_1.duration_ = 5

		SetActive(arg_496_1.tipsGo_, false)

		function arg_496_1.onSingleLineFinish_()
			arg_496_1.onSingleLineUpdate_ = nil
			arg_496_1.onSingleLineFinish_ = nil
			arg_496_1.state_ = "waiting"
		end

		function arg_496_1.playNext_(arg_498_0)
			if arg_498_0 == 1 then
				arg_496_0:Play1101104123(arg_496_1)
			end
		end

		function arg_496_1.onSingleLineUpdate_(arg_499_0)
			local var_499_0 = arg_496_1.actors_["1011ui_story"].transform
			local var_499_1 = 0

			if var_499_1 < arg_496_1.time_ and arg_496_1.time_ <= var_499_1 + arg_499_0 then
				arg_496_1.var_.moveOldPos1011ui_story = var_499_0.localPosition
			end

			local var_499_2 = 0.001

			if var_499_1 <= arg_496_1.time_ and arg_496_1.time_ < var_499_1 + var_499_2 then
				local var_499_3 = (arg_496_1.time_ - var_499_1) / var_499_2
				local var_499_4 = Vector3.New(0, -0.71, -6)

				var_499_0.localPosition = Vector3.Lerp(arg_496_1.var_.moveOldPos1011ui_story, var_499_4, var_499_3)

				local var_499_5 = manager.ui.mainCamera.transform.position - var_499_0.position

				var_499_0.forward = Vector3.New(var_499_5.x, var_499_5.y, var_499_5.z)

				local var_499_6 = var_499_0.localEulerAngles

				var_499_6.z = 0
				var_499_6.x = 0
				var_499_0.localEulerAngles = var_499_6
			end

			if arg_496_1.time_ >= var_499_1 + var_499_2 and arg_496_1.time_ < var_499_1 + var_499_2 + arg_499_0 then
				var_499_0.localPosition = Vector3.New(0, -0.71, -6)

				local var_499_7 = manager.ui.mainCamera.transform.position - var_499_0.position

				var_499_0.forward = Vector3.New(var_499_7.x, var_499_7.y, var_499_7.z)

				local var_499_8 = var_499_0.localEulerAngles

				var_499_8.z = 0
				var_499_8.x = 0
				var_499_0.localEulerAngles = var_499_8
			end

			local var_499_9 = arg_496_1.actors_["1011ui_story"]
			local var_499_10 = 0

			if var_499_10 < arg_496_1.time_ and arg_496_1.time_ <= var_499_10 + arg_499_0 and not isNil(var_499_9) and arg_496_1.var_.characterEffect1011ui_story == nil then
				arg_496_1.var_.characterEffect1011ui_story = var_499_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_499_11 = 0.200000002980232

			if var_499_10 <= arg_496_1.time_ and arg_496_1.time_ < var_499_10 + var_499_11 and not isNil(var_499_9) then
				local var_499_12 = (arg_496_1.time_ - var_499_10) / var_499_11

				if arg_496_1.var_.characterEffect1011ui_story and not isNil(var_499_9) then
					arg_496_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_496_1.time_ >= var_499_10 + var_499_11 and arg_496_1.time_ < var_499_10 + var_499_11 + arg_499_0 and not isNil(var_499_9) and arg_496_1.var_.characterEffect1011ui_story then
				arg_496_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_499_13 = 0

			if var_499_13 < arg_496_1.time_ and arg_496_1.time_ <= var_499_13 + arg_499_0 then
				arg_496_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action6_2")
			end

			local var_499_14 = 0

			if var_499_14 < arg_496_1.time_ and arg_496_1.time_ <= var_499_14 + arg_499_0 then
				arg_496_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_499_15 = 0
			local var_499_16 = 0.325

			if var_499_15 < arg_496_1.time_ and arg_496_1.time_ <= var_499_15 + arg_499_0 then
				arg_496_1.talkMaxDuration = 0
				arg_496_1.dialogCg_.alpha = 1

				arg_496_1.dialog_:SetActive(true)
				SetActive(arg_496_1.leftNameGo_, true)

				local var_499_17 = arg_496_1:FormatText(StoryNameCfg[37].name)

				arg_496_1.leftNameTxt_.text = var_499_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_496_1.leftNameTxt_.transform)

				arg_496_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_496_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_496_1:RecordName(arg_496_1.leftNameTxt_.text)
				SetActive(arg_496_1.iconTrs_.gameObject, false)
				arg_496_1.callingController_:SetSelectedState("normal")

				local var_499_18 = arg_496_1:GetWordFromCfg(1101104122)
				local var_499_19 = arg_496_1:FormatText(var_499_18.content)

				arg_496_1.text_.text = var_499_19

				LuaForUtil.ClearLinePrefixSymbol(arg_496_1.text_)

				local var_499_20 = 13
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

				if manager.audio:GetVoiceLength("story_v_side_new_1101104", "1101104122", "story_v_side_new_1101104.awb") ~= 0 then
					local var_499_23 = manager.audio:GetVoiceLength("story_v_side_new_1101104", "1101104122", "story_v_side_new_1101104.awb") / 1000

					if var_499_23 + var_499_15 > arg_496_1.duration_ then
						arg_496_1.duration_ = var_499_23 + var_499_15
					end

					if var_499_18.prefab_name ~= "" and arg_496_1.actors_[var_499_18.prefab_name] ~= nil then
						local var_499_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_496_1.actors_[var_499_18.prefab_name].transform, "story_v_side_new_1101104", "1101104122", "story_v_side_new_1101104.awb")

						arg_496_1:RecordAudio("1101104122", var_499_24)
						arg_496_1:RecordAudio("1101104122", var_499_24)
					else
						arg_496_1:AudioAction("play", "voice", "story_v_side_new_1101104", "1101104122", "story_v_side_new_1101104.awb")
					end

					arg_496_1:RecordHistoryTalkVoice("story_v_side_new_1101104", "1101104122", "story_v_side_new_1101104.awb")
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
				actorName = "1011ui_story",
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
	Play1101104123 = function(arg_500_0, arg_500_1)
		arg_500_1.time_ = 0
		arg_500_1.frameCnt_ = 0
		arg_500_1.state_ = "playing"
		arg_500_1.curTalkId_ = 1101104123
		arg_500_1.duration_ = 5

		SetActive(arg_500_1.tipsGo_, false)

		function arg_500_1.onSingleLineFinish_()
			arg_500_1.onSingleLineUpdate_ = nil
			arg_500_1.onSingleLineFinish_ = nil
			arg_500_1.state_ = "waiting"
		end

		function arg_500_1.playNext_(arg_502_0)
			if arg_502_0 == 1 then
				arg_500_0:Play1101104124(arg_500_1)
			end
		end

		function arg_500_1.onSingleLineUpdate_(arg_503_0)
			local var_503_0 = arg_500_1.actors_["1011ui_story"].transform
			local var_503_1 = 0

			if var_503_1 < arg_500_1.time_ and arg_500_1.time_ <= var_503_1 + arg_503_0 then
				arg_500_1.var_.moveOldPos1011ui_story = var_503_0.localPosition
			end

			local var_503_2 = 0.001

			if var_503_1 <= arg_500_1.time_ and arg_500_1.time_ < var_503_1 + var_503_2 then
				local var_503_3 = (arg_500_1.time_ - var_503_1) / var_503_2
				local var_503_4 = Vector3.New(0, 100, 0)

				var_503_0.localPosition = Vector3.Lerp(arg_500_1.var_.moveOldPos1011ui_story, var_503_4, var_503_3)

				local var_503_5 = manager.ui.mainCamera.transform.position - var_503_0.position

				var_503_0.forward = Vector3.New(var_503_5.x, var_503_5.y, var_503_5.z)

				local var_503_6 = var_503_0.localEulerAngles

				var_503_6.z = 0
				var_503_6.x = 0
				var_503_0.localEulerAngles = var_503_6
			end

			if arg_500_1.time_ >= var_503_1 + var_503_2 and arg_500_1.time_ < var_503_1 + var_503_2 + arg_503_0 then
				var_503_0.localPosition = Vector3.New(0, 100, 0)

				local var_503_7 = manager.ui.mainCamera.transform.position - var_503_0.position

				var_503_0.forward = Vector3.New(var_503_7.x, var_503_7.y, var_503_7.z)

				local var_503_8 = var_503_0.localEulerAngles

				var_503_8.z = 0
				var_503_8.x = 0
				var_503_0.localEulerAngles = var_503_8
			end

			local var_503_9 = 0
			local var_503_10 = 1.1

			if var_503_9 < arg_500_1.time_ and arg_500_1.time_ <= var_503_9 + arg_503_0 then
				arg_500_1.talkMaxDuration = 0
				arg_500_1.dialogCg_.alpha = 1

				arg_500_1.dialog_:SetActive(true)
				SetActive(arg_500_1.leftNameGo_, false)

				arg_500_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_500_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_500_1:RecordName(arg_500_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_500_1.iconTrs_.gameObject, false)
				arg_500_1.callingController_:SetSelectedState("normal")

				local var_503_11 = arg_500_1:GetWordFromCfg(1101104123)
				local var_503_12 = arg_500_1:FormatText(var_503_11.content)

				arg_500_1.text_.text = var_503_12

				LuaForUtil.ClearLinePrefixSymbol(arg_500_1.text_)

				local var_503_13 = 44
				local var_503_14 = utf8.len(var_503_12)
				local var_503_15 = var_503_13 <= 0 and var_503_10 or var_503_10 * (var_503_14 / var_503_13)

				if var_503_15 > 0 and var_503_10 < var_503_15 then
					arg_500_1.talkMaxDuration = var_503_15

					if var_503_15 + var_503_9 > arg_500_1.duration_ then
						arg_500_1.duration_ = var_503_15 + var_503_9
					end
				end

				arg_500_1.text_.text = var_503_12
				arg_500_1.typewritter.percent = 0

				arg_500_1.typewritter:SetDirty()
				arg_500_1:ShowNextGo(false)
				arg_500_1:RecordContent(arg_500_1.text_.text)
			end

			local var_503_16 = math.max(var_503_10, arg_500_1.talkMaxDuration)

			if var_503_9 <= arg_500_1.time_ and arg_500_1.time_ < var_503_9 + var_503_16 then
				arg_500_1.typewritter.percent = (arg_500_1.time_ - var_503_9) / var_503_16

				arg_500_1.typewritter:SetDirty()
			end

			if arg_500_1.time_ >= var_503_9 + var_503_16 and arg_500_1.time_ < var_503_9 + var_503_16 + arg_503_0 then
				arg_500_1.typewritter.percent = 1

				arg_500_1.typewritter:SetDirty()
				arg_500_1:ShowNextGo(true)
			end
		end

		arg_500_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_500_1:InitPlayNodeList()
	end,
	Play1101104124 = function(arg_504_0, arg_504_1)
		arg_504_1.time_ = 0
		arg_504_1.frameCnt_ = 0
		arg_504_1.state_ = "playing"
		arg_504_1.curTalkId_ = 1101104124
		arg_504_1.duration_ = 7.83

		local var_504_0 = {
			zh = 5.433,
			ja = 7.833
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
				arg_504_0:Play1101104125(arg_504_1)
			end
		end

		function arg_504_1.onSingleLineUpdate_(arg_507_0)
			local var_507_0 = 0
			local var_507_1 = 0.65

			if var_507_0 < arg_504_1.time_ and arg_504_1.time_ <= var_507_0 + arg_507_0 then
				arg_504_1.talkMaxDuration = 0
				arg_504_1.dialogCg_.alpha = 1

				arg_504_1.dialog_:SetActive(true)
				SetActive(arg_504_1.leftNameGo_, true)

				local var_507_2 = arg_504_1:FormatText(StoryNameCfg[67].name)

				arg_504_1.leftNameTxt_.text = var_507_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_504_1.leftNameTxt_.transform)

				arg_504_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_504_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_504_1:RecordName(arg_504_1.leftNameTxt_.text)
				SetActive(arg_504_1.iconTrs_.gameObject, true)
				arg_504_1.iconController_:SetSelectedState("hero")

				arg_504_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1111")

				arg_504_1.callingController_:SetSelectedState("normal")

				arg_504_1.keyicon_.color = Color.New(1, 1, 1)
				arg_504_1.icon_.color = Color.New(1, 1, 1)

				local var_507_3 = arg_504_1:GetWordFromCfg(1101104124)
				local var_507_4 = arg_504_1:FormatText(var_507_3.content)

				arg_504_1.text_.text = var_507_4

				LuaForUtil.ClearLinePrefixSymbol(arg_504_1.text_)

				local var_507_5 = 26
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

				if manager.audio:GetVoiceLength("story_v_side_new_1101104", "1101104124", "story_v_side_new_1101104.awb") ~= 0 then
					local var_507_8 = manager.audio:GetVoiceLength("story_v_side_new_1101104", "1101104124", "story_v_side_new_1101104.awb") / 1000

					if var_507_8 + var_507_0 > arg_504_1.duration_ then
						arg_504_1.duration_ = var_507_8 + var_507_0
					end

					if var_507_3.prefab_name ~= "" and arg_504_1.actors_[var_507_3.prefab_name] ~= nil then
						local var_507_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_504_1.actors_[var_507_3.prefab_name].transform, "story_v_side_new_1101104", "1101104124", "story_v_side_new_1101104.awb")

						arg_504_1:RecordAudio("1101104124", var_507_9)
						arg_504_1:RecordAudio("1101104124", var_507_9)
					else
						arg_504_1:AudioAction("play", "voice", "story_v_side_new_1101104", "1101104124", "story_v_side_new_1101104.awb")
					end

					arg_504_1:RecordHistoryTalkVoice("story_v_side_new_1101104", "1101104124", "story_v_side_new_1101104.awb")
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
	Play1101104125 = function(arg_508_0, arg_508_1)
		arg_508_1.time_ = 0
		arg_508_1.frameCnt_ = 0
		arg_508_1.state_ = "playing"
		arg_508_1.curTalkId_ = 1101104125
		arg_508_1.duration_ = 4.7

		local var_508_0 = {
			zh = 3.633,
			ja = 4.7
		}
		local var_508_1 = manager.audio:GetLocalizationFlag()

		if var_508_0[var_508_1] ~= nil then
			arg_508_1.duration_ = var_508_0[var_508_1]
		end

		SetActive(arg_508_1.tipsGo_, false)

		function arg_508_1.onSingleLineFinish_()
			arg_508_1.onSingleLineUpdate_ = nil
			arg_508_1.onSingleLineFinish_ = nil
			arg_508_1.state_ = "waiting"
		end

		function arg_508_1.playNext_(arg_510_0)
			if arg_510_0 == 1 then
				arg_508_0:Play1101104126(arg_508_1)
			end
		end

		function arg_508_1.onSingleLineUpdate_(arg_511_0)
			local var_511_0 = arg_508_1.actors_["1011ui_story"].transform
			local var_511_1 = 0

			if var_511_1 < arg_508_1.time_ and arg_508_1.time_ <= var_511_1 + arg_511_0 then
				arg_508_1.var_.moveOldPos1011ui_story = var_511_0.localPosition
			end

			local var_511_2 = 0.001

			if var_511_1 <= arg_508_1.time_ and arg_508_1.time_ < var_511_1 + var_511_2 then
				local var_511_3 = (arg_508_1.time_ - var_511_1) / var_511_2
				local var_511_4 = Vector3.New(0, -0.71, -6)

				var_511_0.localPosition = Vector3.Lerp(arg_508_1.var_.moveOldPos1011ui_story, var_511_4, var_511_3)

				local var_511_5 = manager.ui.mainCamera.transform.position - var_511_0.position

				var_511_0.forward = Vector3.New(var_511_5.x, var_511_5.y, var_511_5.z)

				local var_511_6 = var_511_0.localEulerAngles

				var_511_6.z = 0
				var_511_6.x = 0
				var_511_0.localEulerAngles = var_511_6
			end

			if arg_508_1.time_ >= var_511_1 + var_511_2 and arg_508_1.time_ < var_511_1 + var_511_2 + arg_511_0 then
				var_511_0.localPosition = Vector3.New(0, -0.71, -6)

				local var_511_7 = manager.ui.mainCamera.transform.position - var_511_0.position

				var_511_0.forward = Vector3.New(var_511_7.x, var_511_7.y, var_511_7.z)

				local var_511_8 = var_511_0.localEulerAngles

				var_511_8.z = 0
				var_511_8.x = 0
				var_511_0.localEulerAngles = var_511_8
			end

			local var_511_9 = arg_508_1.actors_["1011ui_story"]
			local var_511_10 = 0

			if var_511_10 < arg_508_1.time_ and arg_508_1.time_ <= var_511_10 + arg_511_0 and not isNil(var_511_9) and arg_508_1.var_.characterEffect1011ui_story == nil then
				arg_508_1.var_.characterEffect1011ui_story = var_511_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_511_11 = 0.200000002980232

			if var_511_10 <= arg_508_1.time_ and arg_508_1.time_ < var_511_10 + var_511_11 and not isNil(var_511_9) then
				local var_511_12 = (arg_508_1.time_ - var_511_10) / var_511_11

				if arg_508_1.var_.characterEffect1011ui_story and not isNil(var_511_9) then
					arg_508_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_508_1.time_ >= var_511_10 + var_511_11 and arg_508_1.time_ < var_511_10 + var_511_11 + arg_511_0 and not isNil(var_511_9) and arg_508_1.var_.characterEffect1011ui_story then
				arg_508_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_511_13 = 0

			if var_511_13 < arg_508_1.time_ and arg_508_1.time_ <= var_511_13 + arg_511_0 then
				arg_508_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action4_1")
			end

			local var_511_14 = 0

			if var_511_14 < arg_508_1.time_ and arg_508_1.time_ <= var_511_14 + arg_511_0 then
				arg_508_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_511_15 = 0
			local var_511_16 = 0.3

			if var_511_15 < arg_508_1.time_ and arg_508_1.time_ <= var_511_15 + arg_511_0 then
				arg_508_1.talkMaxDuration = 0
				arg_508_1.dialogCg_.alpha = 1

				arg_508_1.dialog_:SetActive(true)
				SetActive(arg_508_1.leftNameGo_, true)

				local var_511_17 = arg_508_1:FormatText(StoryNameCfg[37].name)

				arg_508_1.leftNameTxt_.text = var_511_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_508_1.leftNameTxt_.transform)

				arg_508_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_508_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_508_1:RecordName(arg_508_1.leftNameTxt_.text)
				SetActive(arg_508_1.iconTrs_.gameObject, false)
				arg_508_1.callingController_:SetSelectedState("normal")

				local var_511_18 = arg_508_1:GetWordFromCfg(1101104125)
				local var_511_19 = arg_508_1:FormatText(var_511_18.content)

				arg_508_1.text_.text = var_511_19

				LuaForUtil.ClearLinePrefixSymbol(arg_508_1.text_)

				local var_511_20 = 12
				local var_511_21 = utf8.len(var_511_19)
				local var_511_22 = var_511_20 <= 0 and var_511_16 or var_511_16 * (var_511_21 / var_511_20)

				if var_511_22 > 0 and var_511_16 < var_511_22 then
					arg_508_1.talkMaxDuration = var_511_22

					if var_511_22 + var_511_15 > arg_508_1.duration_ then
						arg_508_1.duration_ = var_511_22 + var_511_15
					end
				end

				arg_508_1.text_.text = var_511_19
				arg_508_1.typewritter.percent = 0

				arg_508_1.typewritter:SetDirty()
				arg_508_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101104", "1101104125", "story_v_side_new_1101104.awb") ~= 0 then
					local var_511_23 = manager.audio:GetVoiceLength("story_v_side_new_1101104", "1101104125", "story_v_side_new_1101104.awb") / 1000

					if var_511_23 + var_511_15 > arg_508_1.duration_ then
						arg_508_1.duration_ = var_511_23 + var_511_15
					end

					if var_511_18.prefab_name ~= "" and arg_508_1.actors_[var_511_18.prefab_name] ~= nil then
						local var_511_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_508_1.actors_[var_511_18.prefab_name].transform, "story_v_side_new_1101104", "1101104125", "story_v_side_new_1101104.awb")

						arg_508_1:RecordAudio("1101104125", var_511_24)
						arg_508_1:RecordAudio("1101104125", var_511_24)
					else
						arg_508_1:AudioAction("play", "voice", "story_v_side_new_1101104", "1101104125", "story_v_side_new_1101104.awb")
					end

					arg_508_1:RecordHistoryTalkVoice("story_v_side_new_1101104", "1101104125", "story_v_side_new_1101104.awb")
				end

				arg_508_1:RecordContent(arg_508_1.text_.text)
			end

			local var_511_25 = math.max(var_511_16, arg_508_1.talkMaxDuration)

			if var_511_15 <= arg_508_1.time_ and arg_508_1.time_ < var_511_15 + var_511_25 then
				arg_508_1.typewritter.percent = (arg_508_1.time_ - var_511_15) / var_511_25

				arg_508_1.typewritter:SetDirty()
			end

			if arg_508_1.time_ >= var_511_15 + var_511_25 and arg_508_1.time_ < var_511_15 + var_511_25 + arg_511_0 then
				arg_508_1.typewritter.percent = 1

				arg_508_1.typewritter:SetDirty()
				arg_508_1:ShowNextGo(true)
			end
		end

		arg_508_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_508_1:InitPlayNodeList()
	end,
	Play1101104126 = function(arg_512_0, arg_512_1)
		arg_512_1.time_ = 0
		arg_512_1.frameCnt_ = 0
		arg_512_1.state_ = "playing"
		arg_512_1.curTalkId_ = 1101104126
		arg_512_1.duration_ = 5

		SetActive(arg_512_1.tipsGo_, false)

		function arg_512_1.onSingleLineFinish_()
			arg_512_1.onSingleLineUpdate_ = nil
			arg_512_1.onSingleLineFinish_ = nil
			arg_512_1.state_ = "waiting"
		end

		function arg_512_1.playNext_(arg_514_0)
			if arg_514_0 == 1 then
				arg_512_0:Play1101104127(arg_512_1)
			end
		end

		function arg_512_1.onSingleLineUpdate_(arg_515_0)
			local var_515_0 = arg_512_1.actors_["1011ui_story"].transform
			local var_515_1 = 0

			if var_515_1 < arg_512_1.time_ and arg_512_1.time_ <= var_515_1 + arg_515_0 then
				arg_512_1.var_.moveOldPos1011ui_story = var_515_0.localPosition
			end

			local var_515_2 = 0.001

			if var_515_1 <= arg_512_1.time_ and arg_512_1.time_ < var_515_1 + var_515_2 then
				local var_515_3 = (arg_512_1.time_ - var_515_1) / var_515_2
				local var_515_4 = Vector3.New(0, 100, 0)

				var_515_0.localPosition = Vector3.Lerp(arg_512_1.var_.moveOldPos1011ui_story, var_515_4, var_515_3)

				local var_515_5 = manager.ui.mainCamera.transform.position - var_515_0.position

				var_515_0.forward = Vector3.New(var_515_5.x, var_515_5.y, var_515_5.z)

				local var_515_6 = var_515_0.localEulerAngles

				var_515_6.z = 0
				var_515_6.x = 0
				var_515_0.localEulerAngles = var_515_6
			end

			if arg_512_1.time_ >= var_515_1 + var_515_2 and arg_512_1.time_ < var_515_1 + var_515_2 + arg_515_0 then
				var_515_0.localPosition = Vector3.New(0, 100, 0)

				local var_515_7 = manager.ui.mainCamera.transform.position - var_515_0.position

				var_515_0.forward = Vector3.New(var_515_7.x, var_515_7.y, var_515_7.z)

				local var_515_8 = var_515_0.localEulerAngles

				var_515_8.z = 0
				var_515_8.x = 0
				var_515_0.localEulerAngles = var_515_8
			end

			local var_515_9 = 0
			local var_515_10 = 0.975

			if var_515_9 < arg_512_1.time_ and arg_512_1.time_ <= var_515_9 + arg_515_0 then
				arg_512_1.talkMaxDuration = 0
				arg_512_1.dialogCg_.alpha = 1

				arg_512_1.dialog_:SetActive(true)
				SetActive(arg_512_1.leftNameGo_, false)

				arg_512_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_512_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_512_1:RecordName(arg_512_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_512_1.iconTrs_.gameObject, false)
				arg_512_1.callingController_:SetSelectedState("normal")

				local var_515_11 = arg_512_1:GetWordFromCfg(1101104126)
				local var_515_12 = arg_512_1:FormatText(var_515_11.content)

				arg_512_1.text_.text = var_515_12

				LuaForUtil.ClearLinePrefixSymbol(arg_512_1.text_)

				local var_515_13 = 39
				local var_515_14 = utf8.len(var_515_12)
				local var_515_15 = var_515_13 <= 0 and var_515_10 or var_515_10 * (var_515_14 / var_515_13)

				if var_515_15 > 0 and var_515_10 < var_515_15 then
					arg_512_1.talkMaxDuration = var_515_15

					if var_515_15 + var_515_9 > arg_512_1.duration_ then
						arg_512_1.duration_ = var_515_15 + var_515_9
					end
				end

				arg_512_1.text_.text = var_515_12
				arg_512_1.typewritter.percent = 0

				arg_512_1.typewritter:SetDirty()
				arg_512_1:ShowNextGo(false)
				arg_512_1:RecordContent(arg_512_1.text_.text)
			end

			local var_515_16 = math.max(var_515_10, arg_512_1.talkMaxDuration)

			if var_515_9 <= arg_512_1.time_ and arg_512_1.time_ < var_515_9 + var_515_16 then
				arg_512_1.typewritter.percent = (arg_512_1.time_ - var_515_9) / var_515_16

				arg_512_1.typewritter:SetDirty()
			end

			if arg_512_1.time_ >= var_515_9 + var_515_16 and arg_512_1.time_ < var_515_9 + var_515_16 + arg_515_0 then
				arg_512_1.typewritter.percent = 1

				arg_512_1.typewritter:SetDirty()
				arg_512_1:ShowNextGo(true)
			end
		end

		arg_512_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_512_1:InitPlayNodeList()
	end,
	Play1101104127 = function(arg_516_0, arg_516_1)
		arg_516_1.time_ = 0
		arg_516_1.frameCnt_ = 0
		arg_516_1.state_ = "playing"
		arg_516_1.curTalkId_ = 1101104127
		arg_516_1.duration_ = 5

		SetActive(arg_516_1.tipsGo_, false)

		function arg_516_1.onSingleLineFinish_()
			arg_516_1.onSingleLineUpdate_ = nil
			arg_516_1.onSingleLineFinish_ = nil
			arg_516_1.state_ = "waiting"
		end

		function arg_516_1.playNext_(arg_518_0)
			if arg_518_0 == 1 then
				arg_516_0:Play1101104128(arg_516_1)
			end
		end

		function arg_516_1.onSingleLineUpdate_(arg_519_0)
			local var_519_0 = 0
			local var_519_1 = 0.725

			if var_519_0 < arg_516_1.time_ and arg_516_1.time_ <= var_519_0 + arg_519_0 then
				arg_516_1.talkMaxDuration = 0
				arg_516_1.dialogCg_.alpha = 1

				arg_516_1.dialog_:SetActive(true)
				SetActive(arg_516_1.leftNameGo_, false)

				arg_516_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_516_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_516_1:RecordName(arg_516_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_516_1.iconTrs_.gameObject, false)
				arg_516_1.callingController_:SetSelectedState("normal")

				local var_519_2 = arg_516_1:GetWordFromCfg(1101104127)
				local var_519_3 = arg_516_1:FormatText(var_519_2.content)

				arg_516_1.text_.text = var_519_3

				LuaForUtil.ClearLinePrefixSymbol(arg_516_1.text_)

				local var_519_4 = 29
				local var_519_5 = utf8.len(var_519_3)
				local var_519_6 = var_519_4 <= 0 and var_519_1 or var_519_1 * (var_519_5 / var_519_4)

				if var_519_6 > 0 and var_519_1 < var_519_6 then
					arg_516_1.talkMaxDuration = var_519_6

					if var_519_6 + var_519_0 > arg_516_1.duration_ then
						arg_516_1.duration_ = var_519_6 + var_519_0
					end
				end

				arg_516_1.text_.text = var_519_3
				arg_516_1.typewritter.percent = 0

				arg_516_1.typewritter:SetDirty()
				arg_516_1:ShowNextGo(false)
				arg_516_1:RecordContent(arg_516_1.text_.text)
			end

			local var_519_7 = math.max(var_519_1, arg_516_1.talkMaxDuration)

			if var_519_0 <= arg_516_1.time_ and arg_516_1.time_ < var_519_0 + var_519_7 then
				arg_516_1.typewritter.percent = (arg_516_1.time_ - var_519_0) / var_519_7

				arg_516_1.typewritter:SetDirty()
			end

			if arg_516_1.time_ >= var_519_0 + var_519_7 and arg_516_1.time_ < var_519_0 + var_519_7 + arg_519_0 then
				arg_516_1.typewritter.percent = 1

				arg_516_1.typewritter:SetDirty()
				arg_516_1:ShowNextGo(true)
			end
		end

		arg_516_1.nodeConfigList_ = {}

		arg_516_1:InitPlayNodeList()
	end,
	Play1101104128 = function(arg_520_0, arg_520_1)
		arg_520_1.time_ = 0
		arg_520_1.frameCnt_ = 0
		arg_520_1.state_ = "playing"
		arg_520_1.curTalkId_ = 1101104128
		arg_520_1.duration_ = 5

		SetActive(arg_520_1.tipsGo_, false)

		function arg_520_1.onSingleLineFinish_()
			arg_520_1.onSingleLineUpdate_ = nil
			arg_520_1.onSingleLineFinish_ = nil
			arg_520_1.state_ = "waiting"
		end

		function arg_520_1.playNext_(arg_522_0)
			if arg_522_0 == 1 then
				arg_520_0:Play1101104129(arg_520_1)
			end
		end

		function arg_520_1.onSingleLineUpdate_(arg_523_0)
			local var_523_0 = 0
			local var_523_1 = 0.375

			if var_523_0 < arg_520_1.time_ and arg_520_1.time_ <= var_523_0 + arg_523_0 then
				arg_520_1.talkMaxDuration = 0
				arg_520_1.dialogCg_.alpha = 1

				arg_520_1.dialog_:SetActive(true)
				SetActive(arg_520_1.leftNameGo_, true)

				local var_523_2 = arg_520_1:FormatText(StoryNameCfg[344].name)

				arg_520_1.leftNameTxt_.text = var_523_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_520_1.leftNameTxt_.transform)

				arg_520_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_520_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_520_1:RecordName(arg_520_1.leftNameTxt_.text)
				SetActive(arg_520_1.iconTrs_.gameObject, false)
				arg_520_1.callingController_:SetSelectedState("normal")

				local var_523_3 = arg_520_1:GetWordFromCfg(1101104128)
				local var_523_4 = arg_520_1:FormatText(var_523_3.content)

				arg_520_1.text_.text = var_523_4

				LuaForUtil.ClearLinePrefixSymbol(arg_520_1.text_)

				local var_523_5 = 15
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
				arg_520_1:RecordContent(arg_520_1.text_.text)
			end

			local var_523_8 = math.max(var_523_1, arg_520_1.talkMaxDuration)

			if var_523_0 <= arg_520_1.time_ and arg_520_1.time_ < var_523_0 + var_523_8 then
				arg_520_1.typewritter.percent = (arg_520_1.time_ - var_523_0) / var_523_8

				arg_520_1.typewritter:SetDirty()
			end

			if arg_520_1.time_ >= var_523_0 + var_523_8 and arg_520_1.time_ < var_523_0 + var_523_8 + arg_523_0 then
				arg_520_1.typewritter.percent = 1

				arg_520_1.typewritter:SetDirty()
				arg_520_1:ShowNextGo(true)
			end
		end

		arg_520_1.nodeConfigList_ = {}

		arg_520_1:InitPlayNodeList()
	end,
	Play1101104129 = function(arg_524_0, arg_524_1)
		arg_524_1.time_ = 0
		arg_524_1.frameCnt_ = 0
		arg_524_1.state_ = "playing"
		arg_524_1.curTalkId_ = 1101104129
		arg_524_1.duration_ = 5

		SetActive(arg_524_1.tipsGo_, false)

		function arg_524_1.onSingleLineFinish_()
			arg_524_1.onSingleLineUpdate_ = nil
			arg_524_1.onSingleLineFinish_ = nil
			arg_524_1.state_ = "waiting"
		end

		function arg_524_1.playNext_(arg_526_0)
			if arg_526_0 == 1 then
				arg_524_0:Play1101104130(arg_524_1)
			end
		end

		function arg_524_1.onSingleLineUpdate_(arg_527_0)
			local var_527_0 = 0
			local var_527_1 = 0.625

			if var_527_0 < arg_524_1.time_ and arg_524_1.time_ <= var_527_0 + arg_527_0 then
				arg_524_1.talkMaxDuration = 0
				arg_524_1.dialogCg_.alpha = 1

				arg_524_1.dialog_:SetActive(true)
				SetActive(arg_524_1.leftNameGo_, false)

				arg_524_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_524_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_524_1:RecordName(arg_524_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_524_1.iconTrs_.gameObject, false)
				arg_524_1.callingController_:SetSelectedState("normal")

				local var_527_2 = arg_524_1:GetWordFromCfg(1101104129)
				local var_527_3 = arg_524_1:FormatText(var_527_2.content)

				arg_524_1.text_.text = var_527_3

				LuaForUtil.ClearLinePrefixSymbol(arg_524_1.text_)

				local var_527_4 = 25
				local var_527_5 = utf8.len(var_527_3)
				local var_527_6 = var_527_4 <= 0 and var_527_1 or var_527_1 * (var_527_5 / var_527_4)

				if var_527_6 > 0 and var_527_1 < var_527_6 then
					arg_524_1.talkMaxDuration = var_527_6

					if var_527_6 + var_527_0 > arg_524_1.duration_ then
						arg_524_1.duration_ = var_527_6 + var_527_0
					end
				end

				arg_524_1.text_.text = var_527_3
				arg_524_1.typewritter.percent = 0

				arg_524_1.typewritter:SetDirty()
				arg_524_1:ShowNextGo(false)
				arg_524_1:RecordContent(arg_524_1.text_.text)
			end

			local var_527_7 = math.max(var_527_1, arg_524_1.talkMaxDuration)

			if var_527_0 <= arg_524_1.time_ and arg_524_1.time_ < var_527_0 + var_527_7 then
				arg_524_1.typewritter.percent = (arg_524_1.time_ - var_527_0) / var_527_7

				arg_524_1.typewritter:SetDirty()
			end

			if arg_524_1.time_ >= var_527_0 + var_527_7 and arg_524_1.time_ < var_527_0 + var_527_7 + arg_527_0 then
				arg_524_1.typewritter.percent = 1

				arg_524_1.typewritter:SetDirty()
				arg_524_1:ShowNextGo(true)
			end
		end

		arg_524_1.nodeConfigList_ = {}

		arg_524_1:InitPlayNodeList()
	end,
	Play1101104130 = function(arg_528_0, arg_528_1)
		arg_528_1.time_ = 0
		arg_528_1.frameCnt_ = 0
		arg_528_1.state_ = "playing"
		arg_528_1.curTalkId_ = 1101104130
		arg_528_1.duration_ = 5

		SetActive(arg_528_1.tipsGo_, false)

		function arg_528_1.onSingleLineFinish_()
			arg_528_1.onSingleLineUpdate_ = nil
			arg_528_1.onSingleLineFinish_ = nil
			arg_528_1.state_ = "waiting"
		end

		function arg_528_1.playNext_(arg_530_0)
			if arg_530_0 == 1 then
				arg_528_0:Play1101104131(arg_528_1)
			end
		end

		function arg_528_1.onSingleLineUpdate_(arg_531_0)
			local var_531_0 = arg_528_1.actors_["1011ui_story"].transform
			local var_531_1 = 0

			if var_531_1 < arg_528_1.time_ and arg_528_1.time_ <= var_531_1 + arg_531_0 then
				arg_528_1.var_.moveOldPos1011ui_story = var_531_0.localPosition
			end

			local var_531_2 = 0.001

			if var_531_1 <= arg_528_1.time_ and arg_528_1.time_ < var_531_1 + var_531_2 then
				local var_531_3 = (arg_528_1.time_ - var_531_1) / var_531_2
				local var_531_4 = Vector3.New(0, -0.71, -6)

				var_531_0.localPosition = Vector3.Lerp(arg_528_1.var_.moveOldPos1011ui_story, var_531_4, var_531_3)

				local var_531_5 = manager.ui.mainCamera.transform.position - var_531_0.position

				var_531_0.forward = Vector3.New(var_531_5.x, var_531_5.y, var_531_5.z)

				local var_531_6 = var_531_0.localEulerAngles

				var_531_6.z = 0
				var_531_6.x = 0
				var_531_0.localEulerAngles = var_531_6
			end

			if arg_528_1.time_ >= var_531_1 + var_531_2 and arg_528_1.time_ < var_531_1 + var_531_2 + arg_531_0 then
				var_531_0.localPosition = Vector3.New(0, -0.71, -6)

				local var_531_7 = manager.ui.mainCamera.transform.position - var_531_0.position

				var_531_0.forward = Vector3.New(var_531_7.x, var_531_7.y, var_531_7.z)

				local var_531_8 = var_531_0.localEulerAngles

				var_531_8.z = 0
				var_531_8.x = 0
				var_531_0.localEulerAngles = var_531_8
			end

			local var_531_9 = arg_528_1.actors_["1011ui_story"]
			local var_531_10 = 0

			if var_531_10 < arg_528_1.time_ and arg_528_1.time_ <= var_531_10 + arg_531_0 and not isNil(var_531_9) and arg_528_1.var_.characterEffect1011ui_story == nil then
				arg_528_1.var_.characterEffect1011ui_story = var_531_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_531_11 = 0.200000002980232

			if var_531_10 <= arg_528_1.time_ and arg_528_1.time_ < var_531_10 + var_531_11 and not isNil(var_531_9) then
				local var_531_12 = (arg_528_1.time_ - var_531_10) / var_531_11

				if arg_528_1.var_.characterEffect1011ui_story and not isNil(var_531_9) then
					local var_531_13 = Mathf.Lerp(0, 0.5, var_531_12)

					arg_528_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_528_1.var_.characterEffect1011ui_story.fillRatio = var_531_13
				end
			end

			if arg_528_1.time_ >= var_531_10 + var_531_11 and arg_528_1.time_ < var_531_10 + var_531_11 + arg_531_0 and not isNil(var_531_9) and arg_528_1.var_.characterEffect1011ui_story then
				local var_531_14 = 0.5

				arg_528_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_528_1.var_.characterEffect1011ui_story.fillRatio = var_531_14
			end

			local var_531_15 = 0

			if var_531_15 < arg_528_1.time_ and arg_528_1.time_ <= var_531_15 + arg_531_0 then
				arg_528_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_531_16 = 0
			local var_531_17 = 0.975

			if var_531_16 < arg_528_1.time_ and arg_528_1.time_ <= var_531_16 + arg_531_0 then
				arg_528_1.talkMaxDuration = 0
				arg_528_1.dialogCg_.alpha = 1

				arg_528_1.dialog_:SetActive(true)
				SetActive(arg_528_1.leftNameGo_, false)

				arg_528_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_528_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_528_1:RecordName(arg_528_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_528_1.iconTrs_.gameObject, false)
				arg_528_1.callingController_:SetSelectedState("normal")

				local var_531_18 = arg_528_1:GetWordFromCfg(1101104130)
				local var_531_19 = arg_528_1:FormatText(var_531_18.content)

				arg_528_1.text_.text = var_531_19

				LuaForUtil.ClearLinePrefixSymbol(arg_528_1.text_)

				local var_531_20 = 39
				local var_531_21 = utf8.len(var_531_19)
				local var_531_22 = var_531_20 <= 0 and var_531_17 or var_531_17 * (var_531_21 / var_531_20)

				if var_531_22 > 0 and var_531_17 < var_531_22 then
					arg_528_1.talkMaxDuration = var_531_22

					if var_531_22 + var_531_16 > arg_528_1.duration_ then
						arg_528_1.duration_ = var_531_22 + var_531_16
					end
				end

				arg_528_1.text_.text = var_531_19
				arg_528_1.typewritter.percent = 0

				arg_528_1.typewritter:SetDirty()
				arg_528_1:ShowNextGo(false)
				arg_528_1:RecordContent(arg_528_1.text_.text)
			end

			local var_531_23 = math.max(var_531_17, arg_528_1.talkMaxDuration)

			if var_531_16 <= arg_528_1.time_ and arg_528_1.time_ < var_531_16 + var_531_23 then
				arg_528_1.typewritter.percent = (arg_528_1.time_ - var_531_16) / var_531_23

				arg_528_1.typewritter:SetDirty()
			end

			if arg_528_1.time_ >= var_531_16 + var_531_23 and arg_528_1.time_ < var_531_16 + var_531_23 + arg_531_0 then
				arg_528_1.typewritter.percent = 1

				arg_528_1.typewritter:SetDirty()
				arg_528_1:ShowNextGo(true)
			end
		end

		arg_528_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_528_1:InitPlayNodeList()
	end,
	Play1101104131 = function(arg_532_0, arg_532_1)
		arg_532_1.time_ = 0
		arg_532_1.frameCnt_ = 0
		arg_532_1.state_ = "playing"
		arg_532_1.curTalkId_ = 1101104131
		arg_532_1.duration_ = 5

		SetActive(arg_532_1.tipsGo_, false)

		function arg_532_1.onSingleLineFinish_()
			arg_532_1.onSingleLineUpdate_ = nil
			arg_532_1.onSingleLineFinish_ = nil
			arg_532_1.state_ = "waiting"
		end

		function arg_532_1.playNext_(arg_534_0)
			if arg_534_0 == 1 then
				arg_532_0:Play1101104132(arg_532_1)
			end
		end

		function arg_532_1.onSingleLineUpdate_(arg_535_0)
			local var_535_0 = 0
			local var_535_1 = 0.75

			if var_535_0 < arg_532_1.time_ and arg_532_1.time_ <= var_535_0 + arg_535_0 then
				arg_532_1.talkMaxDuration = 0
				arg_532_1.dialogCg_.alpha = 1

				arg_532_1.dialog_:SetActive(true)
				SetActive(arg_532_1.leftNameGo_, false)

				arg_532_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_532_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_532_1:RecordName(arg_532_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_532_1.iconTrs_.gameObject, false)
				arg_532_1.callingController_:SetSelectedState("normal")

				local var_535_2 = arg_532_1:GetWordFromCfg(1101104131)
				local var_535_3 = arg_532_1:FormatText(var_535_2.content)

				arg_532_1.text_.text = var_535_3

				LuaForUtil.ClearLinePrefixSymbol(arg_532_1.text_)

				local var_535_4 = 30
				local var_535_5 = utf8.len(var_535_3)
				local var_535_6 = var_535_4 <= 0 and var_535_1 or var_535_1 * (var_535_5 / var_535_4)

				if var_535_6 > 0 and var_535_1 < var_535_6 then
					arg_532_1.talkMaxDuration = var_535_6

					if var_535_6 + var_535_0 > arg_532_1.duration_ then
						arg_532_1.duration_ = var_535_6 + var_535_0
					end
				end

				arg_532_1.text_.text = var_535_3
				arg_532_1.typewritter.percent = 0

				arg_532_1.typewritter:SetDirty()
				arg_532_1:ShowNextGo(false)
				arg_532_1:RecordContent(arg_532_1.text_.text)
			end

			local var_535_7 = math.max(var_535_1, arg_532_1.talkMaxDuration)

			if var_535_0 <= arg_532_1.time_ and arg_532_1.time_ < var_535_0 + var_535_7 then
				arg_532_1.typewritter.percent = (arg_532_1.time_ - var_535_0) / var_535_7

				arg_532_1.typewritter:SetDirty()
			end

			if arg_532_1.time_ >= var_535_0 + var_535_7 and arg_532_1.time_ < var_535_0 + var_535_7 + arg_535_0 then
				arg_532_1.typewritter.percent = 1

				arg_532_1.typewritter:SetDirty()
				arg_532_1:ShowNextGo(true)
			end
		end

		arg_532_1.nodeConfigList_ = {}

		arg_532_1:InitPlayNodeList()
	end,
	Play1101104132 = function(arg_536_0, arg_536_1)
		arg_536_1.time_ = 0
		arg_536_1.frameCnt_ = 0
		arg_536_1.state_ = "playing"
		arg_536_1.curTalkId_ = 1101104132
		arg_536_1.duration_ = 9.37

		local var_536_0 = {
			zh = 6.366,
			ja = 9.366
		}
		local var_536_1 = manager.audio:GetLocalizationFlag()

		if var_536_0[var_536_1] ~= nil then
			arg_536_1.duration_ = var_536_0[var_536_1]
		end

		SetActive(arg_536_1.tipsGo_, false)

		function arg_536_1.onSingleLineFinish_()
			arg_536_1.onSingleLineUpdate_ = nil
			arg_536_1.onSingleLineFinish_ = nil
			arg_536_1.state_ = "waiting"
		end

		function arg_536_1.playNext_(arg_538_0)
			if arg_538_0 == 1 then
				arg_536_0:Play1101104133(arg_536_1)
			end
		end

		function arg_536_1.onSingleLineUpdate_(arg_539_0)
			local var_539_0 = arg_536_1.actors_["1011ui_story"].transform
			local var_539_1 = 0

			if var_539_1 < arg_536_1.time_ and arg_536_1.time_ <= var_539_1 + arg_539_0 then
				arg_536_1.var_.moveOldPos1011ui_story = var_539_0.localPosition
			end

			local var_539_2 = 0.001

			if var_539_1 <= arg_536_1.time_ and arg_536_1.time_ < var_539_1 + var_539_2 then
				local var_539_3 = (arg_536_1.time_ - var_539_1) / var_539_2
				local var_539_4 = Vector3.New(0, -0.71, -6)

				var_539_0.localPosition = Vector3.Lerp(arg_536_1.var_.moveOldPos1011ui_story, var_539_4, var_539_3)

				local var_539_5 = manager.ui.mainCamera.transform.position - var_539_0.position

				var_539_0.forward = Vector3.New(var_539_5.x, var_539_5.y, var_539_5.z)

				local var_539_6 = var_539_0.localEulerAngles

				var_539_6.z = 0
				var_539_6.x = 0
				var_539_0.localEulerAngles = var_539_6
			end

			if arg_536_1.time_ >= var_539_1 + var_539_2 and arg_536_1.time_ < var_539_1 + var_539_2 + arg_539_0 then
				var_539_0.localPosition = Vector3.New(0, -0.71, -6)

				local var_539_7 = manager.ui.mainCamera.transform.position - var_539_0.position

				var_539_0.forward = Vector3.New(var_539_7.x, var_539_7.y, var_539_7.z)

				local var_539_8 = var_539_0.localEulerAngles

				var_539_8.z = 0
				var_539_8.x = 0
				var_539_0.localEulerAngles = var_539_8
			end

			local var_539_9 = arg_536_1.actors_["1011ui_story"]
			local var_539_10 = 0

			if var_539_10 < arg_536_1.time_ and arg_536_1.time_ <= var_539_10 + arg_539_0 and not isNil(var_539_9) and arg_536_1.var_.characterEffect1011ui_story == nil then
				arg_536_1.var_.characterEffect1011ui_story = var_539_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_539_11 = 0.200000002980232

			if var_539_10 <= arg_536_1.time_ and arg_536_1.time_ < var_539_10 + var_539_11 and not isNil(var_539_9) then
				local var_539_12 = (arg_536_1.time_ - var_539_10) / var_539_11

				if arg_536_1.var_.characterEffect1011ui_story and not isNil(var_539_9) then
					arg_536_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_536_1.time_ >= var_539_10 + var_539_11 and arg_536_1.time_ < var_539_10 + var_539_11 + arg_539_0 and not isNil(var_539_9) and arg_536_1.var_.characterEffect1011ui_story then
				arg_536_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_539_13 = 0

			if var_539_13 < arg_536_1.time_ and arg_536_1.time_ <= var_539_13 + arg_539_0 then
				arg_536_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011actionlink/1011action445")
			end

			local var_539_14 = 0

			if var_539_14 < arg_536_1.time_ and arg_536_1.time_ <= var_539_14 + arg_539_0 then
				arg_536_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_539_15 = 0
			local var_539_16 = 0.425

			if var_539_15 < arg_536_1.time_ and arg_536_1.time_ <= var_539_15 + arg_539_0 then
				arg_536_1.talkMaxDuration = 0
				arg_536_1.dialogCg_.alpha = 1

				arg_536_1.dialog_:SetActive(true)
				SetActive(arg_536_1.leftNameGo_, true)

				local var_539_17 = arg_536_1:FormatText(StoryNameCfg[37].name)

				arg_536_1.leftNameTxt_.text = var_539_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_536_1.leftNameTxt_.transform)

				arg_536_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_536_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_536_1:RecordName(arg_536_1.leftNameTxt_.text)
				SetActive(arg_536_1.iconTrs_.gameObject, false)
				arg_536_1.callingController_:SetSelectedState("normal")

				local var_539_18 = arg_536_1:GetWordFromCfg(1101104132)
				local var_539_19 = arg_536_1:FormatText(var_539_18.content)

				arg_536_1.text_.text = var_539_19

				LuaForUtil.ClearLinePrefixSymbol(arg_536_1.text_)

				local var_539_20 = 17
				local var_539_21 = utf8.len(var_539_19)
				local var_539_22 = var_539_20 <= 0 and var_539_16 or var_539_16 * (var_539_21 / var_539_20)

				if var_539_22 > 0 and var_539_16 < var_539_22 then
					arg_536_1.talkMaxDuration = var_539_22

					if var_539_22 + var_539_15 > arg_536_1.duration_ then
						arg_536_1.duration_ = var_539_22 + var_539_15
					end
				end

				arg_536_1.text_.text = var_539_19
				arg_536_1.typewritter.percent = 0

				arg_536_1.typewritter:SetDirty()
				arg_536_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101104", "1101104132", "story_v_side_new_1101104.awb") ~= 0 then
					local var_539_23 = manager.audio:GetVoiceLength("story_v_side_new_1101104", "1101104132", "story_v_side_new_1101104.awb") / 1000

					if var_539_23 + var_539_15 > arg_536_1.duration_ then
						arg_536_1.duration_ = var_539_23 + var_539_15
					end

					if var_539_18.prefab_name ~= "" and arg_536_1.actors_[var_539_18.prefab_name] ~= nil then
						local var_539_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_536_1.actors_[var_539_18.prefab_name].transform, "story_v_side_new_1101104", "1101104132", "story_v_side_new_1101104.awb")

						arg_536_1:RecordAudio("1101104132", var_539_24)
						arg_536_1:RecordAudio("1101104132", var_539_24)
					else
						arg_536_1:AudioAction("play", "voice", "story_v_side_new_1101104", "1101104132", "story_v_side_new_1101104.awb")
					end

					arg_536_1:RecordHistoryTalkVoice("story_v_side_new_1101104", "1101104132", "story_v_side_new_1101104.awb")
				end

				arg_536_1:RecordContent(arg_536_1.text_.text)
			end

			local var_539_25 = math.max(var_539_16, arg_536_1.talkMaxDuration)

			if var_539_15 <= arg_536_1.time_ and arg_536_1.time_ < var_539_15 + var_539_25 then
				arg_536_1.typewritter.percent = (arg_536_1.time_ - var_539_15) / var_539_25

				arg_536_1.typewritter:SetDirty()
			end

			if arg_536_1.time_ >= var_539_15 + var_539_25 and arg_536_1.time_ < var_539_15 + var_539_25 + arg_539_0 then
				arg_536_1.typewritter.percent = 1

				arg_536_1.typewritter:SetDirty()
				arg_536_1:ShowNextGo(true)
			end
		end

		arg_536_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_536_1:InitPlayNodeList()
	end,
	Play1101104133 = function(arg_540_0, arg_540_1)
		arg_540_1.time_ = 0
		arg_540_1.frameCnt_ = 0
		arg_540_1.state_ = "playing"
		arg_540_1.curTalkId_ = 1101104133
		arg_540_1.duration_ = 5

		SetActive(arg_540_1.tipsGo_, false)

		function arg_540_1.onSingleLineFinish_()
			arg_540_1.onSingleLineUpdate_ = nil
			arg_540_1.onSingleLineFinish_ = nil
			arg_540_1.state_ = "waiting"
		end

		function arg_540_1.playNext_(arg_542_0)
			if arg_542_0 == 1 then
				arg_540_0:Play1101104134(arg_540_1)
			end
		end

		function arg_540_1.onSingleLineUpdate_(arg_543_0)
			local var_543_0 = arg_540_1.actors_["1011ui_story"].transform
			local var_543_1 = 0

			if var_543_1 < arg_540_1.time_ and arg_540_1.time_ <= var_543_1 + arg_543_0 then
				arg_540_1.var_.moveOldPos1011ui_story = var_543_0.localPosition
			end

			local var_543_2 = 0.001

			if var_543_1 <= arg_540_1.time_ and arg_540_1.time_ < var_543_1 + var_543_2 then
				local var_543_3 = (arg_540_1.time_ - var_543_1) / var_543_2
				local var_543_4 = Vector3.New(0, 100, 0)

				var_543_0.localPosition = Vector3.Lerp(arg_540_1.var_.moveOldPos1011ui_story, var_543_4, var_543_3)

				local var_543_5 = manager.ui.mainCamera.transform.position - var_543_0.position

				var_543_0.forward = Vector3.New(var_543_5.x, var_543_5.y, var_543_5.z)

				local var_543_6 = var_543_0.localEulerAngles

				var_543_6.z = 0
				var_543_6.x = 0
				var_543_0.localEulerAngles = var_543_6
			end

			if arg_540_1.time_ >= var_543_1 + var_543_2 and arg_540_1.time_ < var_543_1 + var_543_2 + arg_543_0 then
				var_543_0.localPosition = Vector3.New(0, 100, 0)

				local var_543_7 = manager.ui.mainCamera.transform.position - var_543_0.position

				var_543_0.forward = Vector3.New(var_543_7.x, var_543_7.y, var_543_7.z)

				local var_543_8 = var_543_0.localEulerAngles

				var_543_8.z = 0
				var_543_8.x = 0
				var_543_0.localEulerAngles = var_543_8
			end

			local var_543_9 = 0
			local var_543_10 = 0.6

			if var_543_9 < arg_540_1.time_ and arg_540_1.time_ <= var_543_9 + arg_543_0 then
				arg_540_1.talkMaxDuration = 0
				arg_540_1.dialogCg_.alpha = 1

				arg_540_1.dialog_:SetActive(true)
				SetActive(arg_540_1.leftNameGo_, false)

				arg_540_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_540_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_540_1:RecordName(arg_540_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_540_1.iconTrs_.gameObject, false)
				arg_540_1.callingController_:SetSelectedState("normal")

				local var_543_11 = arg_540_1:GetWordFromCfg(1101104133)
				local var_543_12 = arg_540_1:FormatText(var_543_11.content)

				arg_540_1.text_.text = var_543_12

				LuaForUtil.ClearLinePrefixSymbol(arg_540_1.text_)

				local var_543_13 = 24
				local var_543_14 = utf8.len(var_543_12)
				local var_543_15 = var_543_13 <= 0 and var_543_10 or var_543_10 * (var_543_14 / var_543_13)

				if var_543_15 > 0 and var_543_10 < var_543_15 then
					arg_540_1.talkMaxDuration = var_543_15

					if var_543_15 + var_543_9 > arg_540_1.duration_ then
						arg_540_1.duration_ = var_543_15 + var_543_9
					end
				end

				arg_540_1.text_.text = var_543_12
				arg_540_1.typewritter.percent = 0

				arg_540_1.typewritter:SetDirty()
				arg_540_1:ShowNextGo(false)
				arg_540_1:RecordContent(arg_540_1.text_.text)
			end

			local var_543_16 = math.max(var_543_10, arg_540_1.talkMaxDuration)

			if var_543_9 <= arg_540_1.time_ and arg_540_1.time_ < var_543_9 + var_543_16 then
				arg_540_1.typewritter.percent = (arg_540_1.time_ - var_543_9) / var_543_16

				arg_540_1.typewritter:SetDirty()
			end

			if arg_540_1.time_ >= var_543_9 + var_543_16 and arg_540_1.time_ < var_543_9 + var_543_16 + arg_543_0 then
				arg_540_1.typewritter.percent = 1

				arg_540_1.typewritter:SetDirty()
				arg_540_1:ShowNextGo(true)
			end
		end

		arg_540_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_540_1:InitPlayNodeList()
	end,
	Play1101104134 = function(arg_544_0, arg_544_1)
		arg_544_1.time_ = 0
		arg_544_1.frameCnt_ = 0
		arg_544_1.state_ = "playing"
		arg_544_1.curTalkId_ = 1101104134
		arg_544_1.duration_ = 5

		SetActive(arg_544_1.tipsGo_, false)

		function arg_544_1.onSingleLineFinish_()
			arg_544_1.onSingleLineUpdate_ = nil
			arg_544_1.onSingleLineFinish_ = nil
			arg_544_1.state_ = "waiting"
		end

		function arg_544_1.playNext_(arg_546_0)
			if arg_546_0 == 1 then
				arg_544_0:Play1101104135(arg_544_1)
			end
		end

		function arg_544_1.onSingleLineUpdate_(arg_547_0)
			local var_547_0 = 0
			local var_547_1 = 0.65

			if var_547_0 < arg_544_1.time_ and arg_544_1.time_ <= var_547_0 + arg_547_0 then
				arg_544_1.talkMaxDuration = 0
				arg_544_1.dialogCg_.alpha = 1

				arg_544_1.dialog_:SetActive(true)
				SetActive(arg_544_1.leftNameGo_, false)

				arg_544_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_544_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_544_1:RecordName(arg_544_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_544_1.iconTrs_.gameObject, false)
				arg_544_1.callingController_:SetSelectedState("normal")

				local var_547_2 = arg_544_1:GetWordFromCfg(1101104134)
				local var_547_3 = arg_544_1:FormatText(var_547_2.content)

				arg_544_1.text_.text = var_547_3

				LuaForUtil.ClearLinePrefixSymbol(arg_544_1.text_)

				local var_547_4 = 26
				local var_547_5 = utf8.len(var_547_3)
				local var_547_6 = var_547_4 <= 0 and var_547_1 or var_547_1 * (var_547_5 / var_547_4)

				if var_547_6 > 0 and var_547_1 < var_547_6 then
					arg_544_1.talkMaxDuration = var_547_6

					if var_547_6 + var_547_0 > arg_544_1.duration_ then
						arg_544_1.duration_ = var_547_6 + var_547_0
					end
				end

				arg_544_1.text_.text = var_547_3
				arg_544_1.typewritter.percent = 0

				arg_544_1.typewritter:SetDirty()
				arg_544_1:ShowNextGo(false)
				arg_544_1:RecordContent(arg_544_1.text_.text)
			end

			local var_547_7 = math.max(var_547_1, arg_544_1.talkMaxDuration)

			if var_547_0 <= arg_544_1.time_ and arg_544_1.time_ < var_547_0 + var_547_7 then
				arg_544_1.typewritter.percent = (arg_544_1.time_ - var_547_0) / var_547_7

				arg_544_1.typewritter:SetDirty()
			end

			if arg_544_1.time_ >= var_547_0 + var_547_7 and arg_544_1.time_ < var_547_0 + var_547_7 + arg_547_0 then
				arg_544_1.typewritter.percent = 1

				arg_544_1.typewritter:SetDirty()
				arg_544_1:ShowNextGo(true)
			end
		end

		arg_544_1.nodeConfigList_ = {}

		arg_544_1:InitPlayNodeList()
	end,
	Play1101104135 = function(arg_548_0, arg_548_1)
		arg_548_1.time_ = 0
		arg_548_1.frameCnt_ = 0
		arg_548_1.state_ = "playing"
		arg_548_1.curTalkId_ = 1101104135
		arg_548_1.duration_ = 5

		SetActive(arg_548_1.tipsGo_, false)

		function arg_548_1.onSingleLineFinish_()
			arg_548_1.onSingleLineUpdate_ = nil
			arg_548_1.onSingleLineFinish_ = nil
			arg_548_1.state_ = "waiting"
		end

		function arg_548_1.playNext_(arg_550_0)
			if arg_550_0 == 1 then
				arg_548_0:Play1101104136(arg_548_1)
			end
		end

		function arg_548_1.onSingleLineUpdate_(arg_551_0)
			local var_551_0 = 0
			local var_551_1 = 0.05

			if var_551_0 < arg_548_1.time_ and arg_548_1.time_ <= var_551_0 + arg_551_0 then
				arg_548_1.talkMaxDuration = 0
				arg_548_1.dialogCg_.alpha = 1

				arg_548_1.dialog_:SetActive(true)
				SetActive(arg_548_1.leftNameGo_, false)

				arg_548_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_548_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_548_1:RecordName(arg_548_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_548_1.iconTrs_.gameObject, false)
				arg_548_1.callingController_:SetSelectedState("normal")

				local var_551_2 = arg_548_1:GetWordFromCfg(1101104135)
				local var_551_3 = arg_548_1:FormatText(var_551_2.content)

				arg_548_1.text_.text = var_551_3

				LuaForUtil.ClearLinePrefixSymbol(arg_548_1.text_)

				local var_551_4 = 2
				local var_551_5 = utf8.len(var_551_3)
				local var_551_6 = var_551_4 <= 0 and var_551_1 or var_551_1 * (var_551_5 / var_551_4)

				if var_551_6 > 0 and var_551_1 < var_551_6 then
					arg_548_1.talkMaxDuration = var_551_6

					if var_551_6 + var_551_0 > arg_548_1.duration_ then
						arg_548_1.duration_ = var_551_6 + var_551_0
					end
				end

				arg_548_1.text_.text = var_551_3
				arg_548_1.typewritter.percent = 0

				arg_548_1.typewritter:SetDirty()
				arg_548_1:ShowNextGo(false)
				arg_548_1:RecordContent(arg_548_1.text_.text)
			end

			local var_551_7 = math.max(var_551_1, arg_548_1.talkMaxDuration)

			if var_551_0 <= arg_548_1.time_ and arg_548_1.time_ < var_551_0 + var_551_7 then
				arg_548_1.typewritter.percent = (arg_548_1.time_ - var_551_0) / var_551_7

				arg_548_1.typewritter:SetDirty()
			end

			if arg_548_1.time_ >= var_551_0 + var_551_7 and arg_548_1.time_ < var_551_0 + var_551_7 + arg_551_0 then
				arg_548_1.typewritter.percent = 1

				arg_548_1.typewritter:SetDirty()
				arg_548_1:ShowNextGo(true)
			end
		end

		arg_548_1.nodeConfigList_ = {}

		arg_548_1:InitPlayNodeList()
	end,
	Play1101104136 = function(arg_552_0, arg_552_1)
		arg_552_1.time_ = 0
		arg_552_1.frameCnt_ = 0
		arg_552_1.state_ = "playing"
		arg_552_1.curTalkId_ = 1101104136
		arg_552_1.duration_ = 11

		SetActive(arg_552_1.tipsGo_, false)

		function arg_552_1.onSingleLineFinish_()
			arg_552_1.onSingleLineUpdate_ = nil
			arg_552_1.onSingleLineFinish_ = nil
			arg_552_1.state_ = "waiting"
		end

		function arg_552_1.playNext_(arg_554_0)
			if arg_554_0 == 1 then
				arg_552_0:Play1101104137(arg_552_1)
			end
		end

		function arg_552_1.onSingleLineUpdate_(arg_555_0)
			local var_555_0 = 6
			local var_555_1 = 1

			if var_555_0 < arg_552_1.time_ and arg_552_1.time_ <= var_555_0 + arg_555_0 then
				local var_555_2 = "play"
				local var_555_3 = "effect"

				arg_552_1:AudioAction(var_555_2, var_555_3, "se_story_side_1011", "se_story_side_1011_doorhandle", "")
			end

			local var_555_4 = 0

			if var_555_4 < arg_552_1.time_ and arg_552_1.time_ <= var_555_4 + arg_555_0 then
				arg_552_1.mask_.enabled = true
				arg_552_1.mask_.raycastTarget = true

				arg_552_1:SetGaussion(false)
			end

			local var_555_5 = 3

			if var_555_4 <= arg_552_1.time_ and arg_552_1.time_ < var_555_4 + var_555_5 then
				local var_555_6 = (arg_552_1.time_ - var_555_4) / var_555_5
				local var_555_7 = Color.New(0, 0, 0)

				var_555_7.a = Mathf.Lerp(0, 1, var_555_6)
				arg_552_1.mask_.color = var_555_7
			end

			if arg_552_1.time_ >= var_555_4 + var_555_5 and arg_552_1.time_ < var_555_4 + var_555_5 + arg_555_0 then
				local var_555_8 = Color.New(0, 0, 0)

				var_555_8.a = 1
				arg_552_1.mask_.color = var_555_8
			end

			local var_555_9 = 3

			if var_555_9 < arg_552_1.time_ and arg_552_1.time_ <= var_555_9 + arg_555_0 then
				arg_552_1.mask_.enabled = true
				arg_552_1.mask_.raycastTarget = true

				arg_552_1:SetGaussion(false)
			end

			local var_555_10 = 3

			if var_555_9 <= arg_552_1.time_ and arg_552_1.time_ < var_555_9 + var_555_10 then
				local var_555_11 = (arg_552_1.time_ - var_555_9) / var_555_10
				local var_555_12 = Color.New(0, 0, 0)

				var_555_12.a = Mathf.Lerp(1, 0, var_555_11)
				arg_552_1.mask_.color = var_555_12
			end

			if arg_552_1.time_ >= var_555_9 + var_555_10 and arg_552_1.time_ < var_555_9 + var_555_10 + arg_555_0 then
				local var_555_13 = Color.New(0, 0, 0)
				local var_555_14 = 0

				arg_552_1.mask_.enabled = false
				var_555_13.a = var_555_14
				arg_552_1.mask_.color = var_555_13
			end

			if arg_552_1.frameCnt_ <= 1 then
				arg_552_1.dialog_:SetActive(false)
			end

			local var_555_15 = 6
			local var_555_16 = 0.45

			if var_555_15 < arg_552_1.time_ and arg_552_1.time_ <= var_555_15 + arg_555_0 then
				arg_552_1.talkMaxDuration = 0

				arg_552_1.dialog_:SetActive(true)

				arg_552_1.dialogCg_.alpha = 0

				local var_555_17 = LeanTween.value(arg_552_1.dialog_, 0, 1, 0.3)

				var_555_17:setOnUpdate(LuaHelper.FloatAction(function(arg_556_0)
					arg_552_1.dialogCg_.alpha = arg_556_0
				end))
				var_555_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_552_1.dialog_)
					var_555_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_552_1.duration_ = arg_552_1.duration_ + 0.3

				SetActive(arg_552_1.leftNameGo_, false)

				arg_552_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_552_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_552_1:RecordName(arg_552_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_552_1.iconTrs_.gameObject, false)
				arg_552_1.callingController_:SetSelectedState("normal")

				local var_555_18 = arg_552_1:GetWordFromCfg(1101104136)
				local var_555_19 = arg_552_1:FormatText(var_555_18.content)

				arg_552_1.text_.text = var_555_19

				LuaForUtil.ClearLinePrefixSymbol(arg_552_1.text_)

				local var_555_20 = 18
				local var_555_21 = utf8.len(var_555_19)
				local var_555_22 = var_555_20 <= 0 and var_555_16 or var_555_16 * (var_555_21 / var_555_20)

				if var_555_22 > 0 and var_555_16 < var_555_22 then
					arg_552_1.talkMaxDuration = var_555_22
					var_555_15 = var_555_15 + 0.3

					if var_555_22 + var_555_15 > arg_552_1.duration_ then
						arg_552_1.duration_ = var_555_22 + var_555_15
					end
				end

				arg_552_1.text_.text = var_555_19
				arg_552_1.typewritter.percent = 0

				arg_552_1.typewritter:SetDirty()
				arg_552_1:ShowNextGo(false)
				arg_552_1:RecordContent(arg_552_1.text_.text)
			end

			local var_555_23 = var_555_15 + 0.3
			local var_555_24 = math.max(var_555_16, arg_552_1.talkMaxDuration)

			if var_555_23 <= arg_552_1.time_ and arg_552_1.time_ < var_555_23 + var_555_24 then
				arg_552_1.typewritter.percent = (arg_552_1.time_ - var_555_23) / var_555_24

				arg_552_1.typewritter:SetDirty()
			end

			if arg_552_1.time_ >= var_555_23 + var_555_24 and arg_552_1.time_ < var_555_23 + var_555_24 + arg_555_0 then
				arg_552_1.typewritter.percent = 1

				arg_552_1.typewritter:SetDirty()
				arg_552_1:ShowNextGo(true)
			end
		end

		arg_552_1.nodeConfigList_ = {}

		arg_552_1:InitPlayNodeList()
	end,
	Play1101104137 = function(arg_558_0, arg_558_1)
		arg_558_1.time_ = 0
		arg_558_1.frameCnt_ = 0
		arg_558_1.state_ = "playing"
		arg_558_1.curTalkId_ = 1101104137
		arg_558_1.duration_ = 5

		SetActive(arg_558_1.tipsGo_, false)

		function arg_558_1.onSingleLineFinish_()
			arg_558_1.onSingleLineUpdate_ = nil
			arg_558_1.onSingleLineFinish_ = nil
			arg_558_1.state_ = "waiting"
		end

		function arg_558_1.playNext_(arg_560_0)
			if arg_560_0 == 1 then
				arg_558_0:Play1101104138(arg_558_1)
			end
		end

		function arg_558_1.onSingleLineUpdate_(arg_561_0)
			local var_561_0 = 0
			local var_561_1 = 0.35

			if var_561_0 < arg_558_1.time_ and arg_558_1.time_ <= var_561_0 + arg_561_0 then
				arg_558_1.talkMaxDuration = 0
				arg_558_1.dialogCg_.alpha = 1

				arg_558_1.dialog_:SetActive(true)
				SetActive(arg_558_1.leftNameGo_, false)

				arg_558_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_558_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_558_1:RecordName(arg_558_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_558_1.iconTrs_.gameObject, false)
				arg_558_1.callingController_:SetSelectedState("normal")

				local var_561_2 = arg_558_1:GetWordFromCfg(1101104137)
				local var_561_3 = arg_558_1:FormatText(var_561_2.content)

				arg_558_1.text_.text = var_561_3

				LuaForUtil.ClearLinePrefixSymbol(arg_558_1.text_)

				local var_561_4 = 14
				local var_561_5 = utf8.len(var_561_3)
				local var_561_6 = var_561_4 <= 0 and var_561_1 or var_561_1 * (var_561_5 / var_561_4)

				if var_561_6 > 0 and var_561_1 < var_561_6 then
					arg_558_1.talkMaxDuration = var_561_6

					if var_561_6 + var_561_0 > arg_558_1.duration_ then
						arg_558_1.duration_ = var_561_6 + var_561_0
					end
				end

				arg_558_1.text_.text = var_561_3
				arg_558_1.typewritter.percent = 0

				arg_558_1.typewritter:SetDirty()
				arg_558_1:ShowNextGo(false)
				arg_558_1:RecordContent(arg_558_1.text_.text)
			end

			local var_561_7 = math.max(var_561_1, arg_558_1.talkMaxDuration)

			if var_561_0 <= arg_558_1.time_ and arg_558_1.time_ < var_561_0 + var_561_7 then
				arg_558_1.typewritter.percent = (arg_558_1.time_ - var_561_0) / var_561_7

				arg_558_1.typewritter:SetDirty()
			end

			if arg_558_1.time_ >= var_561_0 + var_561_7 and arg_558_1.time_ < var_561_0 + var_561_7 + arg_561_0 then
				arg_558_1.typewritter.percent = 1

				arg_558_1.typewritter:SetDirty()
				arg_558_1:ShowNextGo(true)
			end
		end

		arg_558_1.nodeConfigList_ = {}

		arg_558_1:InitPlayNodeList()
	end,
	Play1101104138 = function(arg_562_0, arg_562_1)
		arg_562_1.time_ = 0
		arg_562_1.frameCnt_ = 0
		arg_562_1.state_ = "playing"
		arg_562_1.curTalkId_ = 1101104138
		arg_562_1.duration_ = 5

		SetActive(arg_562_1.tipsGo_, false)

		function arg_562_1.onSingleLineFinish_()
			arg_562_1.onSingleLineUpdate_ = nil
			arg_562_1.onSingleLineFinish_ = nil
			arg_562_1.state_ = "waiting"
		end

		function arg_562_1.playNext_(arg_564_0)
			if arg_564_0 == 1 then
				arg_562_0:Play1101104139(arg_562_1)
			end
		end

		function arg_562_1.onSingleLineUpdate_(arg_565_0)
			local var_565_0 = 0
			local var_565_1 = 0.85

			if var_565_0 < arg_562_1.time_ and arg_562_1.time_ <= var_565_0 + arg_565_0 then
				arg_562_1.talkMaxDuration = 0
				arg_562_1.dialogCg_.alpha = 1

				arg_562_1.dialog_:SetActive(true)
				SetActive(arg_562_1.leftNameGo_, true)

				local var_565_2 = arg_562_1:FormatText(StoryNameCfg[7].name)

				arg_562_1.leftNameTxt_.text = var_565_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_562_1.leftNameTxt_.transform)

				arg_562_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_562_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_562_1:RecordName(arg_562_1.leftNameTxt_.text)
				SetActive(arg_562_1.iconTrs_.gameObject, true)
				arg_562_1.iconController_:SetSelectedState("hero")

				arg_562_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_562_1.callingController_:SetSelectedState("normal")

				arg_562_1.keyicon_.color = Color.New(1, 1, 1)
				arg_562_1.icon_.color = Color.New(1, 1, 1)

				local var_565_3 = arg_562_1:GetWordFromCfg(1101104138)
				local var_565_4 = arg_562_1:FormatText(var_565_3.content)

				arg_562_1.text_.text = var_565_4

				LuaForUtil.ClearLinePrefixSymbol(arg_562_1.text_)

				local var_565_5 = 34
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
				arg_562_1:RecordContent(arg_562_1.text_.text)
			end

			local var_565_8 = math.max(var_565_1, arg_562_1.talkMaxDuration)

			if var_565_0 <= arg_562_1.time_ and arg_562_1.time_ < var_565_0 + var_565_8 then
				arg_562_1.typewritter.percent = (arg_562_1.time_ - var_565_0) / var_565_8

				arg_562_1.typewritter:SetDirty()
			end

			if arg_562_1.time_ >= var_565_0 + var_565_8 and arg_562_1.time_ < var_565_0 + var_565_8 + arg_565_0 then
				arg_562_1.typewritter.percent = 1

				arg_562_1.typewritter:SetDirty()
				arg_562_1:ShowNextGo(true)
			end
		end

		arg_562_1.nodeConfigList_ = {}

		arg_562_1:InitPlayNodeList()
	end,
	Play1101104139 = function(arg_566_0, arg_566_1)
		arg_566_1.time_ = 0
		arg_566_1.frameCnt_ = 0
		arg_566_1.state_ = "playing"
		arg_566_1.curTalkId_ = 1101104139
		arg_566_1.duration_ = 6.43

		local var_566_0 = {
			zh = 4.566,
			ja = 6.433
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
				arg_566_0:Play1101104140(arg_566_1)
			end
		end

		function arg_566_1.onSingleLineUpdate_(arg_569_0)
			local var_569_0 = arg_566_1.actors_["1011ui_story"].transform
			local var_569_1 = 0

			if var_569_1 < arg_566_1.time_ and arg_566_1.time_ <= var_569_1 + arg_569_0 then
				arg_566_1.var_.moveOldPos1011ui_story = var_569_0.localPosition
			end

			local var_569_2 = 0.001

			if var_569_1 <= arg_566_1.time_ and arg_566_1.time_ < var_569_1 + var_569_2 then
				local var_569_3 = (arg_566_1.time_ - var_569_1) / var_569_2
				local var_569_4 = Vector3.New(0, -0.71, -6)

				var_569_0.localPosition = Vector3.Lerp(arg_566_1.var_.moveOldPos1011ui_story, var_569_4, var_569_3)

				local var_569_5 = manager.ui.mainCamera.transform.position - var_569_0.position

				var_569_0.forward = Vector3.New(var_569_5.x, var_569_5.y, var_569_5.z)

				local var_569_6 = var_569_0.localEulerAngles

				var_569_6.z = 0
				var_569_6.x = 0
				var_569_0.localEulerAngles = var_569_6
			end

			if arg_566_1.time_ >= var_569_1 + var_569_2 and arg_566_1.time_ < var_569_1 + var_569_2 + arg_569_0 then
				var_569_0.localPosition = Vector3.New(0, -0.71, -6)

				local var_569_7 = manager.ui.mainCamera.transform.position - var_569_0.position

				var_569_0.forward = Vector3.New(var_569_7.x, var_569_7.y, var_569_7.z)

				local var_569_8 = var_569_0.localEulerAngles

				var_569_8.z = 0
				var_569_8.x = 0
				var_569_0.localEulerAngles = var_569_8
			end

			local var_569_9 = arg_566_1.actors_["1011ui_story"]
			local var_569_10 = 0

			if var_569_10 < arg_566_1.time_ and arg_566_1.time_ <= var_569_10 + arg_569_0 and not isNil(var_569_9) and arg_566_1.var_.characterEffect1011ui_story == nil then
				arg_566_1.var_.characterEffect1011ui_story = var_569_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_569_11 = 0.200000002980232

			if var_569_10 <= arg_566_1.time_ and arg_566_1.time_ < var_569_10 + var_569_11 and not isNil(var_569_9) then
				local var_569_12 = (arg_566_1.time_ - var_569_10) / var_569_11

				if arg_566_1.var_.characterEffect1011ui_story and not isNil(var_569_9) then
					arg_566_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_566_1.time_ >= var_569_10 + var_569_11 and arg_566_1.time_ < var_569_10 + var_569_11 + arg_569_0 and not isNil(var_569_9) and arg_566_1.var_.characterEffect1011ui_story then
				arg_566_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_569_13 = 0

			if var_569_13 < arg_566_1.time_ and arg_566_1.time_ <= var_569_13 + arg_569_0 then
				arg_566_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action3_1")
			end

			local var_569_14 = 0

			if var_569_14 < arg_566_1.time_ and arg_566_1.time_ <= var_569_14 + arg_569_0 then
				arg_566_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_569_15 = 0
			local var_569_16 = 0.6

			if var_569_15 < arg_566_1.time_ and arg_566_1.time_ <= var_569_15 + arg_569_0 then
				arg_566_1.talkMaxDuration = 0
				arg_566_1.dialogCg_.alpha = 1

				arg_566_1.dialog_:SetActive(true)
				SetActive(arg_566_1.leftNameGo_, true)

				local var_569_17 = arg_566_1:FormatText(StoryNameCfg[37].name)

				arg_566_1.leftNameTxt_.text = var_569_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_566_1.leftNameTxt_.transform)

				arg_566_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_566_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_566_1:RecordName(arg_566_1.leftNameTxt_.text)
				SetActive(arg_566_1.iconTrs_.gameObject, false)
				arg_566_1.callingController_:SetSelectedState("normal")

				local var_569_18 = arg_566_1:GetWordFromCfg(1101104139)
				local var_569_19 = arg_566_1:FormatText(var_569_18.content)

				arg_566_1.text_.text = var_569_19

				LuaForUtil.ClearLinePrefixSymbol(arg_566_1.text_)

				local var_569_20 = 24
				local var_569_21 = utf8.len(var_569_19)
				local var_569_22 = var_569_20 <= 0 and var_569_16 or var_569_16 * (var_569_21 / var_569_20)

				if var_569_22 > 0 and var_569_16 < var_569_22 then
					arg_566_1.talkMaxDuration = var_569_22

					if var_569_22 + var_569_15 > arg_566_1.duration_ then
						arg_566_1.duration_ = var_569_22 + var_569_15
					end
				end

				arg_566_1.text_.text = var_569_19
				arg_566_1.typewritter.percent = 0

				arg_566_1.typewritter:SetDirty()
				arg_566_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101104", "1101104139", "story_v_side_new_1101104.awb") ~= 0 then
					local var_569_23 = manager.audio:GetVoiceLength("story_v_side_new_1101104", "1101104139", "story_v_side_new_1101104.awb") / 1000

					if var_569_23 + var_569_15 > arg_566_1.duration_ then
						arg_566_1.duration_ = var_569_23 + var_569_15
					end

					if var_569_18.prefab_name ~= "" and arg_566_1.actors_[var_569_18.prefab_name] ~= nil then
						local var_569_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_566_1.actors_[var_569_18.prefab_name].transform, "story_v_side_new_1101104", "1101104139", "story_v_side_new_1101104.awb")

						arg_566_1:RecordAudio("1101104139", var_569_24)
						arg_566_1:RecordAudio("1101104139", var_569_24)
					else
						arg_566_1:AudioAction("play", "voice", "story_v_side_new_1101104", "1101104139", "story_v_side_new_1101104.awb")
					end

					arg_566_1:RecordHistoryTalkVoice("story_v_side_new_1101104", "1101104139", "story_v_side_new_1101104.awb")
				end

				arg_566_1:RecordContent(arg_566_1.text_.text)
			end

			local var_569_25 = math.max(var_569_16, arg_566_1.talkMaxDuration)

			if var_569_15 <= arg_566_1.time_ and arg_566_1.time_ < var_569_15 + var_569_25 then
				arg_566_1.typewritter.percent = (arg_566_1.time_ - var_569_15) / var_569_25

				arg_566_1.typewritter:SetDirty()
			end

			if arg_566_1.time_ >= var_569_15 + var_569_25 and arg_566_1.time_ < var_569_15 + var_569_25 + arg_569_0 then
				arg_566_1.typewritter.percent = 1

				arg_566_1.typewritter:SetDirty()
				arg_566_1:ShowNextGo(true)
			end
		end

		arg_566_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_566_1:InitPlayNodeList()
	end,
	Play1101104140 = function(arg_570_0, arg_570_1)
		arg_570_1.time_ = 0
		arg_570_1.frameCnt_ = 0
		arg_570_1.state_ = "playing"
		arg_570_1.curTalkId_ = 1101104140
		arg_570_1.duration_ = 5

		SetActive(arg_570_1.tipsGo_, false)

		function arg_570_1.onSingleLineFinish_()
			arg_570_1.onSingleLineUpdate_ = nil
			arg_570_1.onSingleLineFinish_ = nil
			arg_570_1.state_ = "waiting"
		end

		function arg_570_1.playNext_(arg_572_0)
			if arg_572_0 == 1 then
				arg_570_0:Play1101104141(arg_570_1)
			end
		end

		function arg_570_1.onSingleLineUpdate_(arg_573_0)
			local var_573_0 = arg_570_1.actors_["1011ui_story"]
			local var_573_1 = 0

			if var_573_1 < arg_570_1.time_ and arg_570_1.time_ <= var_573_1 + arg_573_0 and not isNil(var_573_0) and arg_570_1.var_.characterEffect1011ui_story == nil then
				arg_570_1.var_.characterEffect1011ui_story = var_573_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_573_2 = 0.200000002980232

			if var_573_1 <= arg_570_1.time_ and arg_570_1.time_ < var_573_1 + var_573_2 and not isNil(var_573_0) then
				local var_573_3 = (arg_570_1.time_ - var_573_1) / var_573_2

				if arg_570_1.var_.characterEffect1011ui_story and not isNil(var_573_0) then
					local var_573_4 = Mathf.Lerp(0, 0.5, var_573_3)

					arg_570_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_570_1.var_.characterEffect1011ui_story.fillRatio = var_573_4
				end
			end

			if arg_570_1.time_ >= var_573_1 + var_573_2 and arg_570_1.time_ < var_573_1 + var_573_2 + arg_573_0 and not isNil(var_573_0) and arg_570_1.var_.characterEffect1011ui_story then
				local var_573_5 = 0.5

				arg_570_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_570_1.var_.characterEffect1011ui_story.fillRatio = var_573_5
			end

			local var_573_6 = 0
			local var_573_7 = 0.25

			if var_573_6 < arg_570_1.time_ and arg_570_1.time_ <= var_573_6 + arg_573_0 then
				arg_570_1.talkMaxDuration = 0
				arg_570_1.dialogCg_.alpha = 1

				arg_570_1.dialog_:SetActive(true)
				SetActive(arg_570_1.leftNameGo_, true)

				local var_573_8 = arg_570_1:FormatText(StoryNameCfg[7].name)

				arg_570_1.leftNameTxt_.text = var_573_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_570_1.leftNameTxt_.transform)

				arg_570_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_570_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_570_1:RecordName(arg_570_1.leftNameTxt_.text)
				SetActive(arg_570_1.iconTrs_.gameObject, true)
				arg_570_1.iconController_:SetSelectedState("hero")

				arg_570_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_570_1.callingController_:SetSelectedState("normal")

				arg_570_1.keyicon_.color = Color.New(1, 1, 1)
				arg_570_1.icon_.color = Color.New(1, 1, 1)

				local var_573_9 = arg_570_1:GetWordFromCfg(1101104140)
				local var_573_10 = arg_570_1:FormatText(var_573_9.content)

				arg_570_1.text_.text = var_573_10

				LuaForUtil.ClearLinePrefixSymbol(arg_570_1.text_)

				local var_573_11 = 10
				local var_573_12 = utf8.len(var_573_10)
				local var_573_13 = var_573_11 <= 0 and var_573_7 or var_573_7 * (var_573_12 / var_573_11)

				if var_573_13 > 0 and var_573_7 < var_573_13 then
					arg_570_1.talkMaxDuration = var_573_13

					if var_573_13 + var_573_6 > arg_570_1.duration_ then
						arg_570_1.duration_ = var_573_13 + var_573_6
					end
				end

				arg_570_1.text_.text = var_573_10
				arg_570_1.typewritter.percent = 0

				arg_570_1.typewritter:SetDirty()
				arg_570_1:ShowNextGo(false)
				arg_570_1:RecordContent(arg_570_1.text_.text)
			end

			local var_573_14 = math.max(var_573_7, arg_570_1.talkMaxDuration)

			if var_573_6 <= arg_570_1.time_ and arg_570_1.time_ < var_573_6 + var_573_14 then
				arg_570_1.typewritter.percent = (arg_570_1.time_ - var_573_6) / var_573_14

				arg_570_1.typewritter:SetDirty()
			end

			if arg_570_1.time_ >= var_573_6 + var_573_14 and arg_570_1.time_ < var_573_6 + var_573_14 + arg_573_0 then
				arg_570_1.typewritter.percent = 1

				arg_570_1.typewritter:SetDirty()
				arg_570_1:ShowNextGo(true)
			end
		end

		arg_570_1.nodeConfigList_ = {}

		arg_570_1:InitPlayNodeList()
	end,
	Play1101104141 = function(arg_574_0, arg_574_1)
		arg_574_1.time_ = 0
		arg_574_1.frameCnt_ = 0
		arg_574_1.state_ = "playing"
		arg_574_1.curTalkId_ = 1101104141
		arg_574_1.duration_ = 8.37

		local var_574_0 = {
			zh = 5.233,
			ja = 8.366
		}
		local var_574_1 = manager.audio:GetLocalizationFlag()

		if var_574_0[var_574_1] ~= nil then
			arg_574_1.duration_ = var_574_0[var_574_1]
		end

		SetActive(arg_574_1.tipsGo_, false)

		function arg_574_1.onSingleLineFinish_()
			arg_574_1.onSingleLineUpdate_ = nil
			arg_574_1.onSingleLineFinish_ = nil
			arg_574_1.state_ = "waiting"
		end

		function arg_574_1.playNext_(arg_576_0)
			if arg_576_0 == 1 then
				arg_574_0:Play1101104142(arg_574_1)
			end
		end

		function arg_574_1.onSingleLineUpdate_(arg_577_0)
			local var_577_0 = arg_574_1.actors_["1111ui_story"].transform
			local var_577_1 = 0

			if var_577_1 < arg_574_1.time_ and arg_574_1.time_ <= var_577_1 + arg_577_0 then
				arg_574_1.var_.moveOldPos1111ui_story = var_577_0.localPosition
			end

			local var_577_2 = 0.001

			if var_577_1 <= arg_574_1.time_ and arg_574_1.time_ < var_577_1 + var_577_2 then
				local var_577_3 = (arg_574_1.time_ - var_577_1) / var_577_2
				local var_577_4 = Vector3.New(0, -0.87, -5.7)

				var_577_0.localPosition = Vector3.Lerp(arg_574_1.var_.moveOldPos1111ui_story, var_577_4, var_577_3)

				local var_577_5 = manager.ui.mainCamera.transform.position - var_577_0.position

				var_577_0.forward = Vector3.New(var_577_5.x, var_577_5.y, var_577_5.z)

				local var_577_6 = var_577_0.localEulerAngles

				var_577_6.z = 0
				var_577_6.x = 0
				var_577_0.localEulerAngles = var_577_6
			end

			if arg_574_1.time_ >= var_577_1 + var_577_2 and arg_574_1.time_ < var_577_1 + var_577_2 + arg_577_0 then
				var_577_0.localPosition = Vector3.New(0, -0.87, -5.7)

				local var_577_7 = manager.ui.mainCamera.transform.position - var_577_0.position

				var_577_0.forward = Vector3.New(var_577_7.x, var_577_7.y, var_577_7.z)

				local var_577_8 = var_577_0.localEulerAngles

				var_577_8.z = 0
				var_577_8.x = 0
				var_577_0.localEulerAngles = var_577_8
			end

			local var_577_9 = arg_574_1.actors_["1111ui_story"]
			local var_577_10 = 0

			if var_577_10 < arg_574_1.time_ and arg_574_1.time_ <= var_577_10 + arg_577_0 and not isNil(var_577_9) and arg_574_1.var_.characterEffect1111ui_story == nil then
				arg_574_1.var_.characterEffect1111ui_story = var_577_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_577_11 = 0.200000002980232

			if var_577_10 <= arg_574_1.time_ and arg_574_1.time_ < var_577_10 + var_577_11 and not isNil(var_577_9) then
				local var_577_12 = (arg_574_1.time_ - var_577_10) / var_577_11

				if arg_574_1.var_.characterEffect1111ui_story and not isNil(var_577_9) then
					arg_574_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_574_1.time_ >= var_577_10 + var_577_11 and arg_574_1.time_ < var_577_10 + var_577_11 + arg_577_0 and not isNil(var_577_9) and arg_574_1.var_.characterEffect1111ui_story then
				arg_574_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_577_13 = 0

			if var_577_13 < arg_574_1.time_ and arg_574_1.time_ <= var_577_13 + arg_577_0 then
				arg_574_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action4_1")
			end

			local var_577_14 = 0

			if var_577_14 < arg_574_1.time_ and arg_574_1.time_ <= var_577_14 + arg_577_0 then
				arg_574_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_577_15 = arg_574_1.actors_["1011ui_story"].transform
			local var_577_16 = 0

			if var_577_16 < arg_574_1.time_ and arg_574_1.time_ <= var_577_16 + arg_577_0 then
				arg_574_1.var_.moveOldPos1011ui_story = var_577_15.localPosition
			end

			local var_577_17 = 0.001

			if var_577_16 <= arg_574_1.time_ and arg_574_1.time_ < var_577_16 + var_577_17 then
				local var_577_18 = (arg_574_1.time_ - var_577_16) / var_577_17
				local var_577_19 = Vector3.New(0, 100, 0)

				var_577_15.localPosition = Vector3.Lerp(arg_574_1.var_.moveOldPos1011ui_story, var_577_19, var_577_18)

				local var_577_20 = manager.ui.mainCamera.transform.position - var_577_15.position

				var_577_15.forward = Vector3.New(var_577_20.x, var_577_20.y, var_577_20.z)

				local var_577_21 = var_577_15.localEulerAngles

				var_577_21.z = 0
				var_577_21.x = 0
				var_577_15.localEulerAngles = var_577_21
			end

			if arg_574_1.time_ >= var_577_16 + var_577_17 and arg_574_1.time_ < var_577_16 + var_577_17 + arg_577_0 then
				var_577_15.localPosition = Vector3.New(0, 100, 0)

				local var_577_22 = manager.ui.mainCamera.transform.position - var_577_15.position

				var_577_15.forward = Vector3.New(var_577_22.x, var_577_22.y, var_577_22.z)

				local var_577_23 = var_577_15.localEulerAngles

				var_577_23.z = 0
				var_577_23.x = 0
				var_577_15.localEulerAngles = var_577_23
			end

			local var_577_24 = 0
			local var_577_25 = 0.6

			if var_577_24 < arg_574_1.time_ and arg_574_1.time_ <= var_577_24 + arg_577_0 then
				arg_574_1.talkMaxDuration = 0
				arg_574_1.dialogCg_.alpha = 1

				arg_574_1.dialog_:SetActive(true)
				SetActive(arg_574_1.leftNameGo_, true)

				local var_577_26 = arg_574_1:FormatText(StoryNameCfg[67].name)

				arg_574_1.leftNameTxt_.text = var_577_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_574_1.leftNameTxt_.transform)

				arg_574_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_574_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_574_1:RecordName(arg_574_1.leftNameTxt_.text)
				SetActive(arg_574_1.iconTrs_.gameObject, false)
				arg_574_1.callingController_:SetSelectedState("normal")

				local var_577_27 = arg_574_1:GetWordFromCfg(1101104141)
				local var_577_28 = arg_574_1:FormatText(var_577_27.content)

				arg_574_1.text_.text = var_577_28

				LuaForUtil.ClearLinePrefixSymbol(arg_574_1.text_)

				local var_577_29 = 24
				local var_577_30 = utf8.len(var_577_28)
				local var_577_31 = var_577_29 <= 0 and var_577_25 or var_577_25 * (var_577_30 / var_577_29)

				if var_577_31 > 0 and var_577_25 < var_577_31 then
					arg_574_1.talkMaxDuration = var_577_31

					if var_577_31 + var_577_24 > arg_574_1.duration_ then
						arg_574_1.duration_ = var_577_31 + var_577_24
					end
				end

				arg_574_1.text_.text = var_577_28
				arg_574_1.typewritter.percent = 0

				arg_574_1.typewritter:SetDirty()
				arg_574_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101104", "1101104141", "story_v_side_new_1101104.awb") ~= 0 then
					local var_577_32 = manager.audio:GetVoiceLength("story_v_side_new_1101104", "1101104141", "story_v_side_new_1101104.awb") / 1000

					if var_577_32 + var_577_24 > arg_574_1.duration_ then
						arg_574_1.duration_ = var_577_32 + var_577_24
					end

					if var_577_27.prefab_name ~= "" and arg_574_1.actors_[var_577_27.prefab_name] ~= nil then
						local var_577_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_574_1.actors_[var_577_27.prefab_name].transform, "story_v_side_new_1101104", "1101104141", "story_v_side_new_1101104.awb")

						arg_574_1:RecordAudio("1101104141", var_577_33)
						arg_574_1:RecordAudio("1101104141", var_577_33)
					else
						arg_574_1:AudioAction("play", "voice", "story_v_side_new_1101104", "1101104141", "story_v_side_new_1101104.awb")
					end

					arg_574_1:RecordHistoryTalkVoice("story_v_side_new_1101104", "1101104141", "story_v_side_new_1101104.awb")
				end

				arg_574_1:RecordContent(arg_574_1.text_.text)
			end

			local var_577_34 = math.max(var_577_25, arg_574_1.talkMaxDuration)

			if var_577_24 <= arg_574_1.time_ and arg_574_1.time_ < var_577_24 + var_577_34 then
				arg_574_1.typewritter.percent = (arg_574_1.time_ - var_577_24) / var_577_34

				arg_574_1.typewritter:SetDirty()
			end

			if arg_574_1.time_ >= var_577_24 + var_577_34 and arg_574_1.time_ < var_577_24 + var_577_34 + arg_577_0 then
				arg_574_1.typewritter.percent = 1

				arg_574_1.typewritter:SetDirty()
				arg_574_1:ShowNextGo(true)
			end
		end

		arg_574_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_574_1:InitPlayNodeList()
	end,
	Play1101104142 = function(arg_578_0, arg_578_1)
		arg_578_1.time_ = 0
		arg_578_1.frameCnt_ = 0
		arg_578_1.state_ = "playing"
		arg_578_1.curTalkId_ = 1101104142
		arg_578_1.duration_ = 5

		SetActive(arg_578_1.tipsGo_, false)

		function arg_578_1.onSingleLineFinish_()
			arg_578_1.onSingleLineUpdate_ = nil
			arg_578_1.onSingleLineFinish_ = nil
			arg_578_1.state_ = "waiting"
		end

		function arg_578_1.playNext_(arg_580_0)
			if arg_580_0 == 1 then
				arg_578_0:Play1101104143(arg_578_1)
			end
		end

		function arg_578_1.onSingleLineUpdate_(arg_581_0)
			local var_581_0 = arg_578_1.actors_["1111ui_story"]
			local var_581_1 = 0

			if var_581_1 < arg_578_1.time_ and arg_578_1.time_ <= var_581_1 + arg_581_0 and not isNil(var_581_0) and arg_578_1.var_.characterEffect1111ui_story == nil then
				arg_578_1.var_.characterEffect1111ui_story = var_581_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_581_2 = 0.200000002980232

			if var_581_1 <= arg_578_1.time_ and arg_578_1.time_ < var_581_1 + var_581_2 and not isNil(var_581_0) then
				local var_581_3 = (arg_578_1.time_ - var_581_1) / var_581_2

				if arg_578_1.var_.characterEffect1111ui_story and not isNil(var_581_0) then
					local var_581_4 = Mathf.Lerp(0, 0.5, var_581_3)

					arg_578_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_578_1.var_.characterEffect1111ui_story.fillRatio = var_581_4
				end
			end

			if arg_578_1.time_ >= var_581_1 + var_581_2 and arg_578_1.time_ < var_581_1 + var_581_2 + arg_581_0 and not isNil(var_581_0) and arg_578_1.var_.characterEffect1111ui_story then
				local var_581_5 = 0.5

				arg_578_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_578_1.var_.characterEffect1111ui_story.fillRatio = var_581_5
			end

			local var_581_6 = 0

			if var_581_6 < arg_578_1.time_ and arg_578_1.time_ <= var_581_6 + arg_581_0 then
				arg_578_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_581_7 = 0
			local var_581_8 = 0.925

			if var_581_7 < arg_578_1.time_ and arg_578_1.time_ <= var_581_7 + arg_581_0 then
				arg_578_1.talkMaxDuration = 0
				arg_578_1.dialogCg_.alpha = 1

				arg_578_1.dialog_:SetActive(true)
				SetActive(arg_578_1.leftNameGo_, false)

				arg_578_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_578_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_578_1:RecordName(arg_578_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_578_1.iconTrs_.gameObject, false)
				arg_578_1.callingController_:SetSelectedState("normal")

				local var_581_9 = arg_578_1:GetWordFromCfg(1101104142)
				local var_581_10 = arg_578_1:FormatText(var_581_9.content)

				arg_578_1.text_.text = var_581_10

				LuaForUtil.ClearLinePrefixSymbol(arg_578_1.text_)

				local var_581_11 = 28
				local var_581_12 = utf8.len(var_581_10)
				local var_581_13 = var_581_11 <= 0 and var_581_8 or var_581_8 * (var_581_12 / var_581_11)

				if var_581_13 > 0 and var_581_8 < var_581_13 then
					arg_578_1.talkMaxDuration = var_581_13

					if var_581_13 + var_581_7 > arg_578_1.duration_ then
						arg_578_1.duration_ = var_581_13 + var_581_7
					end
				end

				arg_578_1.text_.text = var_581_10
				arg_578_1.typewritter.percent = 0

				arg_578_1.typewritter:SetDirty()
				arg_578_1:ShowNextGo(false)
				arg_578_1:RecordContent(arg_578_1.text_.text)
			end

			local var_581_14 = math.max(var_581_8, arg_578_1.talkMaxDuration)

			if var_581_7 <= arg_578_1.time_ and arg_578_1.time_ < var_581_7 + var_581_14 then
				arg_578_1.typewritter.percent = (arg_578_1.time_ - var_581_7) / var_581_14

				arg_578_1.typewritter:SetDirty()
			end

			if arg_578_1.time_ >= var_581_7 + var_581_14 and arg_578_1.time_ < var_581_7 + var_581_14 + arg_581_0 then
				arg_578_1.typewritter.percent = 1

				arg_578_1.typewritter:SetDirty()
				arg_578_1:ShowNextGo(true)
			end
		end

		arg_578_1.nodeConfigList_ = {}

		arg_578_1:InitPlayNodeList()
	end,
	Play1101104143 = function(arg_582_0, arg_582_1)
		arg_582_1.time_ = 0
		arg_582_1.frameCnt_ = 0
		arg_582_1.state_ = "playing"
		arg_582_1.curTalkId_ = 1101104143
		arg_582_1.duration_ = 5

		SetActive(arg_582_1.tipsGo_, false)

		function arg_582_1.onSingleLineFinish_()
			arg_582_1.onSingleLineUpdate_ = nil
			arg_582_1.onSingleLineFinish_ = nil
			arg_582_1.state_ = "waiting"
		end

		function arg_582_1.playNext_(arg_584_0)
			if arg_584_0 == 1 then
				arg_582_0:Play1101104144(arg_582_1)
			end
		end

		function arg_582_1.onSingleLineUpdate_(arg_585_0)
			local var_585_0 = 0
			local var_585_1 = 0.825

			if var_585_0 < arg_582_1.time_ and arg_582_1.time_ <= var_585_0 + arg_585_0 then
				arg_582_1.talkMaxDuration = 0
				arg_582_1.dialogCg_.alpha = 1

				arg_582_1.dialog_:SetActive(true)
				SetActive(arg_582_1.leftNameGo_, true)

				local var_585_2 = arg_582_1:FormatText(StoryNameCfg[7].name)

				arg_582_1.leftNameTxt_.text = var_585_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_582_1.leftNameTxt_.transform)

				arg_582_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_582_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_582_1:RecordName(arg_582_1.leftNameTxt_.text)
				SetActive(arg_582_1.iconTrs_.gameObject, true)
				arg_582_1.iconController_:SetSelectedState("hero")

				arg_582_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_582_1.callingController_:SetSelectedState("normal")

				arg_582_1.keyicon_.color = Color.New(1, 1, 1)
				arg_582_1.icon_.color = Color.New(1, 1, 1)

				local var_585_3 = arg_582_1:GetWordFromCfg(1101104143)
				local var_585_4 = arg_582_1:FormatText(var_585_3.content)

				arg_582_1.text_.text = var_585_4

				LuaForUtil.ClearLinePrefixSymbol(arg_582_1.text_)

				local var_585_5 = 33
				local var_585_6 = utf8.len(var_585_4)
				local var_585_7 = var_585_5 <= 0 and var_585_1 or var_585_1 * (var_585_6 / var_585_5)

				if var_585_7 > 0 and var_585_1 < var_585_7 then
					arg_582_1.talkMaxDuration = var_585_7

					if var_585_7 + var_585_0 > arg_582_1.duration_ then
						arg_582_1.duration_ = var_585_7 + var_585_0
					end
				end

				arg_582_1.text_.text = var_585_4
				arg_582_1.typewritter.percent = 0

				arg_582_1.typewritter:SetDirty()
				arg_582_1:ShowNextGo(false)
				arg_582_1:RecordContent(arg_582_1.text_.text)
			end

			local var_585_8 = math.max(var_585_1, arg_582_1.talkMaxDuration)

			if var_585_0 <= arg_582_1.time_ and arg_582_1.time_ < var_585_0 + var_585_8 then
				arg_582_1.typewritter.percent = (arg_582_1.time_ - var_585_0) / var_585_8

				arg_582_1.typewritter:SetDirty()
			end

			if arg_582_1.time_ >= var_585_0 + var_585_8 and arg_582_1.time_ < var_585_0 + var_585_8 + arg_585_0 then
				arg_582_1.typewritter.percent = 1

				arg_582_1.typewritter:SetDirty()
				arg_582_1:ShowNextGo(true)
			end
		end

		arg_582_1.nodeConfigList_ = {}

		arg_582_1:InitPlayNodeList()
	end,
	Play1101104144 = function(arg_586_0, arg_586_1)
		arg_586_1.time_ = 0
		arg_586_1.frameCnt_ = 0
		arg_586_1.state_ = "playing"
		arg_586_1.curTalkId_ = 1101104144
		arg_586_1.duration_ = 5

		SetActive(arg_586_1.tipsGo_, false)

		function arg_586_1.onSingleLineFinish_()
			arg_586_1.onSingleLineUpdate_ = nil
			arg_586_1.onSingleLineFinish_ = nil
			arg_586_1.state_ = "waiting"
		end

		function arg_586_1.playNext_(arg_588_0)
			if arg_588_0 == 1 then
				arg_586_0:Play1101104145(arg_586_1)
			end
		end

		function arg_586_1.onSingleLineUpdate_(arg_589_0)
			local var_589_0 = arg_586_1.actors_["1111ui_story"].transform
			local var_589_1 = 0

			if var_589_1 < arg_586_1.time_ and arg_586_1.time_ <= var_589_1 + arg_589_0 then
				arg_586_1.var_.moveOldPos1111ui_story = var_589_0.localPosition
			end

			local var_589_2 = 0.001

			if var_589_1 <= arg_586_1.time_ and arg_586_1.time_ < var_589_1 + var_589_2 then
				local var_589_3 = (arg_586_1.time_ - var_589_1) / var_589_2
				local var_589_4 = Vector3.New(0, 100, 0)

				var_589_0.localPosition = Vector3.Lerp(arg_586_1.var_.moveOldPos1111ui_story, var_589_4, var_589_3)

				local var_589_5 = manager.ui.mainCamera.transform.position - var_589_0.position

				var_589_0.forward = Vector3.New(var_589_5.x, var_589_5.y, var_589_5.z)

				local var_589_6 = var_589_0.localEulerAngles

				var_589_6.z = 0
				var_589_6.x = 0
				var_589_0.localEulerAngles = var_589_6
			end

			if arg_586_1.time_ >= var_589_1 + var_589_2 and arg_586_1.time_ < var_589_1 + var_589_2 + arg_589_0 then
				var_589_0.localPosition = Vector3.New(0, 100, 0)

				local var_589_7 = manager.ui.mainCamera.transform.position - var_589_0.position

				var_589_0.forward = Vector3.New(var_589_7.x, var_589_7.y, var_589_7.z)

				local var_589_8 = var_589_0.localEulerAngles

				var_589_8.z = 0
				var_589_8.x = 0
				var_589_0.localEulerAngles = var_589_8
			end

			local var_589_9 = 0
			local var_589_10 = 0.5

			if var_589_9 < arg_586_1.time_ and arg_586_1.time_ <= var_589_9 + arg_589_0 then
				arg_586_1.talkMaxDuration = 0
				arg_586_1.dialogCg_.alpha = 1

				arg_586_1.dialog_:SetActive(true)
				SetActive(arg_586_1.leftNameGo_, false)

				arg_586_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_586_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_586_1:RecordName(arg_586_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_586_1.iconTrs_.gameObject, false)
				arg_586_1.callingController_:SetSelectedState("normal")

				local var_589_11 = arg_586_1:GetWordFromCfg(1101104144)
				local var_589_12 = arg_586_1:FormatText(var_589_11.content)

				arg_586_1.text_.text = var_589_12

				LuaForUtil.ClearLinePrefixSymbol(arg_586_1.text_)

				local var_589_13 = 20
				local var_589_14 = utf8.len(var_589_12)
				local var_589_15 = var_589_13 <= 0 and var_589_10 or var_589_10 * (var_589_14 / var_589_13)

				if var_589_15 > 0 and var_589_10 < var_589_15 then
					arg_586_1.talkMaxDuration = var_589_15

					if var_589_15 + var_589_9 > arg_586_1.duration_ then
						arg_586_1.duration_ = var_589_15 + var_589_9
					end
				end

				arg_586_1.text_.text = var_589_12
				arg_586_1.typewritter.percent = 0

				arg_586_1.typewritter:SetDirty()
				arg_586_1:ShowNextGo(false)
				arg_586_1:RecordContent(arg_586_1.text_.text)
			end

			local var_589_16 = math.max(var_589_10, arg_586_1.talkMaxDuration)

			if var_589_9 <= arg_586_1.time_ and arg_586_1.time_ < var_589_9 + var_589_16 then
				arg_586_1.typewritter.percent = (arg_586_1.time_ - var_589_9) / var_589_16

				arg_586_1.typewritter:SetDirty()
			end

			if arg_586_1.time_ >= var_589_9 + var_589_16 and arg_586_1.time_ < var_589_9 + var_589_16 + arg_589_0 then
				arg_586_1.typewritter.percent = 1

				arg_586_1.typewritter:SetDirty()
				arg_586_1:ShowNextGo(true)
			end
		end

		arg_586_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_586_1:InitPlayNodeList()
	end,
	Play1101104145 = function(arg_590_0, arg_590_1)
		arg_590_1.time_ = 0
		arg_590_1.frameCnt_ = 0
		arg_590_1.state_ = "playing"
		arg_590_1.curTalkId_ = 1101104145
		arg_590_1.duration_ = 5

		SetActive(arg_590_1.tipsGo_, false)

		function arg_590_1.onSingleLineFinish_()
			arg_590_1.onSingleLineUpdate_ = nil
			arg_590_1.onSingleLineFinish_ = nil
			arg_590_1.state_ = "waiting"
		end

		function arg_590_1.playNext_(arg_592_0)
			if arg_592_0 == 1 then
				arg_590_0:Play1101104146(arg_590_1)
			end
		end

		function arg_590_1.onSingleLineUpdate_(arg_593_0)
			local var_593_0 = arg_590_1.actors_["1011ui_story"].transform
			local var_593_1 = 0

			if var_593_1 < arg_590_1.time_ and arg_590_1.time_ <= var_593_1 + arg_593_0 then
				arg_590_1.var_.moveOldPos1011ui_story = var_593_0.localPosition
			end

			local var_593_2 = 0.001

			if var_593_1 <= arg_590_1.time_ and arg_590_1.time_ < var_593_1 + var_593_2 then
				local var_593_3 = (arg_590_1.time_ - var_593_1) / var_593_2
				local var_593_4 = Vector3.New(0, -0.71, -6)

				var_593_0.localPosition = Vector3.Lerp(arg_590_1.var_.moveOldPos1011ui_story, var_593_4, var_593_3)

				local var_593_5 = manager.ui.mainCamera.transform.position - var_593_0.position

				var_593_0.forward = Vector3.New(var_593_5.x, var_593_5.y, var_593_5.z)

				local var_593_6 = var_593_0.localEulerAngles

				var_593_6.z = 0
				var_593_6.x = 0
				var_593_0.localEulerAngles = var_593_6
			end

			if arg_590_1.time_ >= var_593_1 + var_593_2 and arg_590_1.time_ < var_593_1 + var_593_2 + arg_593_0 then
				var_593_0.localPosition = Vector3.New(0, -0.71, -6)

				local var_593_7 = manager.ui.mainCamera.transform.position - var_593_0.position

				var_593_0.forward = Vector3.New(var_593_7.x, var_593_7.y, var_593_7.z)

				local var_593_8 = var_593_0.localEulerAngles

				var_593_8.z = 0
				var_593_8.x = 0
				var_593_0.localEulerAngles = var_593_8
			end

			local var_593_9 = arg_590_1.actors_["1011ui_story"]
			local var_593_10 = 0

			if var_593_10 < arg_590_1.time_ and arg_590_1.time_ <= var_593_10 + arg_593_0 and not isNil(var_593_9) and arg_590_1.var_.characterEffect1011ui_story == nil then
				arg_590_1.var_.characterEffect1011ui_story = var_593_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_593_11 = 0.2

			if var_593_10 <= arg_590_1.time_ and arg_590_1.time_ < var_593_10 + var_593_11 and not isNil(var_593_9) then
				local var_593_12 = (arg_590_1.time_ - var_593_10) / var_593_11

				if arg_590_1.var_.characterEffect1011ui_story and not isNil(var_593_9) then
					local var_593_13 = Mathf.Lerp(0, 0.5, var_593_12)

					arg_590_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_590_1.var_.characterEffect1011ui_story.fillRatio = var_593_13
				end
			end

			if arg_590_1.time_ >= var_593_10 + var_593_11 and arg_590_1.time_ < var_593_10 + var_593_11 + arg_593_0 and not isNil(var_593_9) and arg_590_1.var_.characterEffect1011ui_story then
				local var_593_14 = 0.5

				arg_590_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_590_1.var_.characterEffect1011ui_story.fillRatio = var_593_14
			end

			local var_593_15 = 0

			if var_593_15 < arg_590_1.time_ and arg_590_1.time_ <= var_593_15 + arg_593_0 then
				arg_590_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action1_1")
			end

			local var_593_16 = 0

			if var_593_16 < arg_590_1.time_ and arg_590_1.time_ <= var_593_16 + arg_593_0 then
				arg_590_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_593_17 = 0
			local var_593_18 = 0.75

			if var_593_17 < arg_590_1.time_ and arg_590_1.time_ <= var_593_17 + arg_593_0 then
				arg_590_1.talkMaxDuration = 0
				arg_590_1.dialogCg_.alpha = 1

				arg_590_1.dialog_:SetActive(true)
				SetActive(arg_590_1.leftNameGo_, true)

				local var_593_19 = arg_590_1:FormatText(StoryNameCfg[7].name)

				arg_590_1.leftNameTxt_.text = var_593_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_590_1.leftNameTxt_.transform)

				arg_590_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_590_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_590_1:RecordName(arg_590_1.leftNameTxt_.text)
				SetActive(arg_590_1.iconTrs_.gameObject, true)
				arg_590_1.iconController_:SetSelectedState("hero")

				arg_590_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_590_1.callingController_:SetSelectedState("normal")

				arg_590_1.keyicon_.color = Color.New(1, 1, 1)
				arg_590_1.icon_.color = Color.New(1, 1, 1)

				local var_593_20 = arg_590_1:GetWordFromCfg(1101104145)
				local var_593_21 = arg_590_1:FormatText(var_593_20.content)

				arg_590_1.text_.text = var_593_21

				LuaForUtil.ClearLinePrefixSymbol(arg_590_1.text_)

				local var_593_22 = 30
				local var_593_23 = utf8.len(var_593_21)
				local var_593_24 = var_593_22 <= 0 and var_593_18 or var_593_18 * (var_593_23 / var_593_22)

				if var_593_24 > 0 and var_593_18 < var_593_24 then
					arg_590_1.talkMaxDuration = var_593_24

					if var_593_24 + var_593_17 > arg_590_1.duration_ then
						arg_590_1.duration_ = var_593_24 + var_593_17
					end
				end

				arg_590_1.text_.text = var_593_21
				arg_590_1.typewritter.percent = 0

				arg_590_1.typewritter:SetDirty()
				arg_590_1:ShowNextGo(false)
				arg_590_1:RecordContent(arg_590_1.text_.text)
			end

			local var_593_25 = math.max(var_593_18, arg_590_1.talkMaxDuration)

			if var_593_17 <= arg_590_1.time_ and arg_590_1.time_ < var_593_17 + var_593_25 then
				arg_590_1.typewritter.percent = (arg_590_1.time_ - var_593_17) / var_593_25

				arg_590_1.typewritter:SetDirty()
			end

			if arg_590_1.time_ >= var_593_17 + var_593_25 and arg_590_1.time_ < var_593_17 + var_593_25 + arg_593_0 then
				arg_590_1.typewritter.percent = 1

				arg_590_1.typewritter:SetDirty()
				arg_590_1:ShowNextGo(true)
			end
		end

		arg_590_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_590_1:InitPlayNodeList()
	end,
	Play1101104146 = function(arg_594_0, arg_594_1)
		arg_594_1.time_ = 0
		arg_594_1.frameCnt_ = 0
		arg_594_1.state_ = "playing"
		arg_594_1.curTalkId_ = 1101104146
		arg_594_1.duration_ = 4.9

		local var_594_0 = {
			zh = 3.4,
			ja = 4.9
		}
		local var_594_1 = manager.audio:GetLocalizationFlag()

		if var_594_0[var_594_1] ~= nil then
			arg_594_1.duration_ = var_594_0[var_594_1]
		end

		SetActive(arg_594_1.tipsGo_, false)

		function arg_594_1.onSingleLineFinish_()
			arg_594_1.onSingleLineUpdate_ = nil
			arg_594_1.onSingleLineFinish_ = nil
			arg_594_1.state_ = "waiting"
		end

		function arg_594_1.playNext_(arg_596_0)
			if arg_596_0 == 1 then
				arg_594_0:Play1101104147(arg_594_1)
			end
		end

		function arg_594_1.onSingleLineUpdate_(arg_597_0)
			local var_597_0 = arg_594_1.actors_["1011ui_story"].transform
			local var_597_1 = 0

			if var_597_1 < arg_594_1.time_ and arg_594_1.time_ <= var_597_1 + arg_597_0 then
				arg_594_1.var_.moveOldPos1011ui_story = var_597_0.localPosition
			end

			local var_597_2 = 0.001

			if var_597_1 <= arg_594_1.time_ and arg_594_1.time_ < var_597_1 + var_597_2 then
				local var_597_3 = (arg_594_1.time_ - var_597_1) / var_597_2
				local var_597_4 = Vector3.New(0, -0.71, -6)

				var_597_0.localPosition = Vector3.Lerp(arg_594_1.var_.moveOldPos1011ui_story, var_597_4, var_597_3)

				local var_597_5 = manager.ui.mainCamera.transform.position - var_597_0.position

				var_597_0.forward = Vector3.New(var_597_5.x, var_597_5.y, var_597_5.z)

				local var_597_6 = var_597_0.localEulerAngles

				var_597_6.z = 0
				var_597_6.x = 0
				var_597_0.localEulerAngles = var_597_6
			end

			if arg_594_1.time_ >= var_597_1 + var_597_2 and arg_594_1.time_ < var_597_1 + var_597_2 + arg_597_0 then
				var_597_0.localPosition = Vector3.New(0, -0.71, -6)

				local var_597_7 = manager.ui.mainCamera.transform.position - var_597_0.position

				var_597_0.forward = Vector3.New(var_597_7.x, var_597_7.y, var_597_7.z)

				local var_597_8 = var_597_0.localEulerAngles

				var_597_8.z = 0
				var_597_8.x = 0
				var_597_0.localEulerAngles = var_597_8
			end

			local var_597_9 = arg_594_1.actors_["1011ui_story"]
			local var_597_10 = 0

			if var_597_10 < arg_594_1.time_ and arg_594_1.time_ <= var_597_10 + arg_597_0 and not isNil(var_597_9) and arg_594_1.var_.characterEffect1011ui_story == nil then
				arg_594_1.var_.characterEffect1011ui_story = var_597_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_597_11 = 0.200000002980232

			if var_597_10 <= arg_594_1.time_ and arg_594_1.time_ < var_597_10 + var_597_11 and not isNil(var_597_9) then
				local var_597_12 = (arg_594_1.time_ - var_597_10) / var_597_11

				if arg_594_1.var_.characterEffect1011ui_story and not isNil(var_597_9) then
					arg_594_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_594_1.time_ >= var_597_10 + var_597_11 and arg_594_1.time_ < var_597_10 + var_597_11 + arg_597_0 and not isNil(var_597_9) and arg_594_1.var_.characterEffect1011ui_story then
				arg_594_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_597_13 = 0

			if var_597_13 < arg_594_1.time_ and arg_594_1.time_ <= var_597_13 + arg_597_0 then
				arg_594_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action2_1")
			end

			local var_597_14 = 0

			if var_597_14 < arg_594_1.time_ and arg_594_1.time_ <= var_597_14 + arg_597_0 then
				arg_594_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_597_15 = 0
			local var_597_16 = 0.225

			if var_597_15 < arg_594_1.time_ and arg_594_1.time_ <= var_597_15 + arg_597_0 then
				arg_594_1.talkMaxDuration = 0
				arg_594_1.dialogCg_.alpha = 1

				arg_594_1.dialog_:SetActive(true)
				SetActive(arg_594_1.leftNameGo_, true)

				local var_597_17 = arg_594_1:FormatText(StoryNameCfg[37].name)

				arg_594_1.leftNameTxt_.text = var_597_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_594_1.leftNameTxt_.transform)

				arg_594_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_594_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_594_1:RecordName(arg_594_1.leftNameTxt_.text)
				SetActive(arg_594_1.iconTrs_.gameObject, false)
				arg_594_1.callingController_:SetSelectedState("normal")

				local var_597_18 = arg_594_1:GetWordFromCfg(1101104146)
				local var_597_19 = arg_594_1:FormatText(var_597_18.content)

				arg_594_1.text_.text = var_597_19

				LuaForUtil.ClearLinePrefixSymbol(arg_594_1.text_)

				local var_597_20 = 9
				local var_597_21 = utf8.len(var_597_19)
				local var_597_22 = var_597_20 <= 0 and var_597_16 or var_597_16 * (var_597_21 / var_597_20)

				if var_597_22 > 0 and var_597_16 < var_597_22 then
					arg_594_1.talkMaxDuration = var_597_22

					if var_597_22 + var_597_15 > arg_594_1.duration_ then
						arg_594_1.duration_ = var_597_22 + var_597_15
					end
				end

				arg_594_1.text_.text = var_597_19
				arg_594_1.typewritter.percent = 0

				arg_594_1.typewritter:SetDirty()
				arg_594_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101104", "1101104146", "story_v_side_new_1101104.awb") ~= 0 then
					local var_597_23 = manager.audio:GetVoiceLength("story_v_side_new_1101104", "1101104146", "story_v_side_new_1101104.awb") / 1000

					if var_597_23 + var_597_15 > arg_594_1.duration_ then
						arg_594_1.duration_ = var_597_23 + var_597_15
					end

					if var_597_18.prefab_name ~= "" and arg_594_1.actors_[var_597_18.prefab_name] ~= nil then
						local var_597_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_594_1.actors_[var_597_18.prefab_name].transform, "story_v_side_new_1101104", "1101104146", "story_v_side_new_1101104.awb")

						arg_594_1:RecordAudio("1101104146", var_597_24)
						arg_594_1:RecordAudio("1101104146", var_597_24)
					else
						arg_594_1:AudioAction("play", "voice", "story_v_side_new_1101104", "1101104146", "story_v_side_new_1101104.awb")
					end

					arg_594_1:RecordHistoryTalkVoice("story_v_side_new_1101104", "1101104146", "story_v_side_new_1101104.awb")
				end

				arg_594_1:RecordContent(arg_594_1.text_.text)
			end

			local var_597_25 = math.max(var_597_16, arg_594_1.talkMaxDuration)

			if var_597_15 <= arg_594_1.time_ and arg_594_1.time_ < var_597_15 + var_597_25 then
				arg_594_1.typewritter.percent = (arg_594_1.time_ - var_597_15) / var_597_25

				arg_594_1.typewritter:SetDirty()
			end

			if arg_594_1.time_ >= var_597_15 + var_597_25 and arg_594_1.time_ < var_597_15 + var_597_25 + arg_597_0 then
				arg_594_1.typewritter.percent = 1

				arg_594_1.typewritter:SetDirty()
				arg_594_1:ShowNextGo(true)
			end
		end

		arg_594_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_594_1:InitPlayNodeList()
	end,
	Play1101104147 = function(arg_598_0, arg_598_1)
		arg_598_1.time_ = 0
		arg_598_1.frameCnt_ = 0
		arg_598_1.state_ = "playing"
		arg_598_1.curTalkId_ = 1101104147
		arg_598_1.duration_ = 2.83

		local var_598_0 = {
			zh = 2.2,
			ja = 2.833
		}
		local var_598_1 = manager.audio:GetLocalizationFlag()

		if var_598_0[var_598_1] ~= nil then
			arg_598_1.duration_ = var_598_0[var_598_1]
		end

		SetActive(arg_598_1.tipsGo_, false)

		function arg_598_1.onSingleLineFinish_()
			arg_598_1.onSingleLineUpdate_ = nil
			arg_598_1.onSingleLineFinish_ = nil
			arg_598_1.state_ = "waiting"
		end

		function arg_598_1.playNext_(arg_600_0)
			if arg_600_0 == 1 then
				arg_598_0:Play1101104148(arg_598_1)
			end
		end

		function arg_598_1.onSingleLineUpdate_(arg_601_0)
			local var_601_0 = arg_598_1.actors_["1111ui_story"].transform
			local var_601_1 = 0

			if var_601_1 < arg_598_1.time_ and arg_598_1.time_ <= var_601_1 + arg_601_0 then
				arg_598_1.var_.moveOldPos1111ui_story = var_601_0.localPosition
			end

			local var_601_2 = 0.001

			if var_601_1 <= arg_598_1.time_ and arg_598_1.time_ < var_601_1 + var_601_2 then
				local var_601_3 = (arg_598_1.time_ - var_601_1) / var_601_2
				local var_601_4 = Vector3.New(0.7, -0.87, -5.7)

				var_601_0.localPosition = Vector3.Lerp(arg_598_1.var_.moveOldPos1111ui_story, var_601_4, var_601_3)

				local var_601_5 = manager.ui.mainCamera.transform.position - var_601_0.position

				var_601_0.forward = Vector3.New(var_601_5.x, var_601_5.y, var_601_5.z)

				local var_601_6 = var_601_0.localEulerAngles

				var_601_6.z = 0
				var_601_6.x = 0
				var_601_0.localEulerAngles = var_601_6
			end

			if arg_598_1.time_ >= var_601_1 + var_601_2 and arg_598_1.time_ < var_601_1 + var_601_2 + arg_601_0 then
				var_601_0.localPosition = Vector3.New(0.7, -0.87, -5.7)

				local var_601_7 = manager.ui.mainCamera.transform.position - var_601_0.position

				var_601_0.forward = Vector3.New(var_601_7.x, var_601_7.y, var_601_7.z)

				local var_601_8 = var_601_0.localEulerAngles

				var_601_8.z = 0
				var_601_8.x = 0
				var_601_0.localEulerAngles = var_601_8
			end

			local var_601_9 = arg_598_1.actors_["1111ui_story"]
			local var_601_10 = 0

			if var_601_10 < arg_598_1.time_ and arg_598_1.time_ <= var_601_10 + arg_601_0 and not isNil(var_601_9) and arg_598_1.var_.characterEffect1111ui_story == nil then
				arg_598_1.var_.characterEffect1111ui_story = var_601_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_601_11 = 0.200000002980232

			if var_601_10 <= arg_598_1.time_ and arg_598_1.time_ < var_601_10 + var_601_11 and not isNil(var_601_9) then
				local var_601_12 = (arg_598_1.time_ - var_601_10) / var_601_11

				if arg_598_1.var_.characterEffect1111ui_story and not isNil(var_601_9) then
					arg_598_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_598_1.time_ >= var_601_10 + var_601_11 and arg_598_1.time_ < var_601_10 + var_601_11 + arg_601_0 and not isNil(var_601_9) and arg_598_1.var_.characterEffect1111ui_story then
				arg_598_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_601_13 = 0

			if var_601_13 < arg_598_1.time_ and arg_598_1.time_ <= var_601_13 + arg_601_0 then
				arg_598_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action8_1")
			end

			local var_601_14 = 0

			if var_601_14 < arg_598_1.time_ and arg_598_1.time_ <= var_601_14 + arg_601_0 then
				arg_598_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1302cva")
			end

			local var_601_15 = arg_598_1.actors_["1011ui_story"]
			local var_601_16 = 0

			if var_601_16 < arg_598_1.time_ and arg_598_1.time_ <= var_601_16 + arg_601_0 and not isNil(var_601_15) and arg_598_1.var_.characterEffect1011ui_story == nil then
				arg_598_1.var_.characterEffect1011ui_story = var_601_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_601_17 = 0.200000002980232

			if var_601_16 <= arg_598_1.time_ and arg_598_1.time_ < var_601_16 + var_601_17 and not isNil(var_601_15) then
				local var_601_18 = (arg_598_1.time_ - var_601_16) / var_601_17

				if arg_598_1.var_.characterEffect1011ui_story and not isNil(var_601_15) then
					local var_601_19 = Mathf.Lerp(0, 0.5, var_601_18)

					arg_598_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_598_1.var_.characterEffect1011ui_story.fillRatio = var_601_19
				end
			end

			if arg_598_1.time_ >= var_601_16 + var_601_17 and arg_598_1.time_ < var_601_16 + var_601_17 + arg_601_0 and not isNil(var_601_15) and arg_598_1.var_.characterEffect1011ui_story then
				local var_601_20 = 0.5

				arg_598_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_598_1.var_.characterEffect1011ui_story.fillRatio = var_601_20
			end

			local var_601_21 = arg_598_1.actors_["1011ui_story"].transform
			local var_601_22 = 0

			if var_601_22 < arg_598_1.time_ and arg_598_1.time_ <= var_601_22 + arg_601_0 then
				arg_598_1.var_.moveOldPos1011ui_story = var_601_21.localPosition
			end

			local var_601_23 = 0.001

			if var_601_22 <= arg_598_1.time_ and arg_598_1.time_ < var_601_22 + var_601_23 then
				local var_601_24 = (arg_598_1.time_ - var_601_22) / var_601_23
				local var_601_25 = Vector3.New(-0.7, -0.71, -6)

				var_601_21.localPosition = Vector3.Lerp(arg_598_1.var_.moveOldPos1011ui_story, var_601_25, var_601_24)

				local var_601_26 = manager.ui.mainCamera.transform.position - var_601_21.position

				var_601_21.forward = Vector3.New(var_601_26.x, var_601_26.y, var_601_26.z)

				local var_601_27 = var_601_21.localEulerAngles

				var_601_27.z = 0
				var_601_27.x = 0
				var_601_21.localEulerAngles = var_601_27
			end

			if arg_598_1.time_ >= var_601_22 + var_601_23 and arg_598_1.time_ < var_601_22 + var_601_23 + arg_601_0 then
				var_601_21.localPosition = Vector3.New(-0.7, -0.71, -6)

				local var_601_28 = manager.ui.mainCamera.transform.position - var_601_21.position

				var_601_21.forward = Vector3.New(var_601_28.x, var_601_28.y, var_601_28.z)

				local var_601_29 = var_601_21.localEulerAngles

				var_601_29.z = 0
				var_601_29.x = 0
				var_601_21.localEulerAngles = var_601_29
			end

			local var_601_30 = 0
			local var_601_31 = 0.2

			if var_601_30 < arg_598_1.time_ and arg_598_1.time_ <= var_601_30 + arg_601_0 then
				arg_598_1.talkMaxDuration = 0
				arg_598_1.dialogCg_.alpha = 1

				arg_598_1.dialog_:SetActive(true)
				SetActive(arg_598_1.leftNameGo_, true)

				local var_601_32 = arg_598_1:FormatText(StoryNameCfg[67].name)

				arg_598_1.leftNameTxt_.text = var_601_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_598_1.leftNameTxt_.transform)

				arg_598_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_598_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_598_1:RecordName(arg_598_1.leftNameTxt_.text)
				SetActive(arg_598_1.iconTrs_.gameObject, false)
				arg_598_1.callingController_:SetSelectedState("normal")

				local var_601_33 = arg_598_1:GetWordFromCfg(1101104147)
				local var_601_34 = arg_598_1:FormatText(var_601_33.content)

				arg_598_1.text_.text = var_601_34

				LuaForUtil.ClearLinePrefixSymbol(arg_598_1.text_)

				local var_601_35 = 8
				local var_601_36 = utf8.len(var_601_34)
				local var_601_37 = var_601_35 <= 0 and var_601_31 or var_601_31 * (var_601_36 / var_601_35)

				if var_601_37 > 0 and var_601_31 < var_601_37 then
					arg_598_1.talkMaxDuration = var_601_37

					if var_601_37 + var_601_30 > arg_598_1.duration_ then
						arg_598_1.duration_ = var_601_37 + var_601_30
					end
				end

				arg_598_1.text_.text = var_601_34
				arg_598_1.typewritter.percent = 0

				arg_598_1.typewritter:SetDirty()
				arg_598_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101104", "1101104147", "story_v_side_new_1101104.awb") ~= 0 then
					local var_601_38 = manager.audio:GetVoiceLength("story_v_side_new_1101104", "1101104147", "story_v_side_new_1101104.awb") / 1000

					if var_601_38 + var_601_30 > arg_598_1.duration_ then
						arg_598_1.duration_ = var_601_38 + var_601_30
					end

					if var_601_33.prefab_name ~= "" and arg_598_1.actors_[var_601_33.prefab_name] ~= nil then
						local var_601_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_598_1.actors_[var_601_33.prefab_name].transform, "story_v_side_new_1101104", "1101104147", "story_v_side_new_1101104.awb")

						arg_598_1:RecordAudio("1101104147", var_601_39)
						arg_598_1:RecordAudio("1101104147", var_601_39)
					else
						arg_598_1:AudioAction("play", "voice", "story_v_side_new_1101104", "1101104147", "story_v_side_new_1101104.awb")
					end

					arg_598_1:RecordHistoryTalkVoice("story_v_side_new_1101104", "1101104147", "story_v_side_new_1101104.awb")
				end

				arg_598_1:RecordContent(arg_598_1.text_.text)
			end

			local var_601_40 = math.max(var_601_31, arg_598_1.talkMaxDuration)

			if var_601_30 <= arg_598_1.time_ and arg_598_1.time_ < var_601_30 + var_601_40 then
				arg_598_1.typewritter.percent = (arg_598_1.time_ - var_601_30) / var_601_40

				arg_598_1.typewritter:SetDirty()
			end

			if arg_598_1.time_ >= var_601_30 + var_601_40 and arg_598_1.time_ < var_601_30 + var_601_40 + arg_601_0 then
				arg_598_1.typewritter.percent = 1

				arg_598_1.typewritter:SetDirty()
				arg_598_1:ShowNextGo(true)
			end
		end

		arg_598_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_598_1:InitPlayNodeList()
	end,
	Play1101104148 = function(arg_602_0, arg_602_1)
		arg_602_1.time_ = 0
		arg_602_1.frameCnt_ = 0
		arg_602_1.state_ = "playing"
		arg_602_1.curTalkId_ = 1101104148
		arg_602_1.duration_ = 8.2

		local var_602_0 = {
			zh = 3.6,
			ja = 8.2
		}
		local var_602_1 = manager.audio:GetLocalizationFlag()

		if var_602_0[var_602_1] ~= nil then
			arg_602_1.duration_ = var_602_0[var_602_1]
		end

		SetActive(arg_602_1.tipsGo_, false)

		function arg_602_1.onSingleLineFinish_()
			arg_602_1.onSingleLineUpdate_ = nil
			arg_602_1.onSingleLineFinish_ = nil
			arg_602_1.state_ = "waiting"
		end

		function arg_602_1.playNext_(arg_604_0)
			if arg_604_0 == 1 then
				arg_602_0:Play1101104149(arg_602_1)
			end
		end

		function arg_602_1.onSingleLineUpdate_(arg_605_0)
			local var_605_0 = arg_602_1.actors_["1011ui_story"].transform
			local var_605_1 = 0

			if var_605_1 < arg_602_1.time_ and arg_602_1.time_ <= var_605_1 + arg_605_0 then
				arg_602_1.var_.moveOldPos1011ui_story = var_605_0.localPosition
			end

			local var_605_2 = 0.001

			if var_605_1 <= arg_602_1.time_ and arg_602_1.time_ < var_605_1 + var_605_2 then
				local var_605_3 = (arg_602_1.time_ - var_605_1) / var_605_2
				local var_605_4 = Vector3.New(-0.7, -0.71, -6)

				var_605_0.localPosition = Vector3.Lerp(arg_602_1.var_.moveOldPos1011ui_story, var_605_4, var_605_3)

				local var_605_5 = manager.ui.mainCamera.transform.position - var_605_0.position

				var_605_0.forward = Vector3.New(var_605_5.x, var_605_5.y, var_605_5.z)

				local var_605_6 = var_605_0.localEulerAngles

				var_605_6.z = 0
				var_605_6.x = 0
				var_605_0.localEulerAngles = var_605_6
			end

			if arg_602_1.time_ >= var_605_1 + var_605_2 and arg_602_1.time_ < var_605_1 + var_605_2 + arg_605_0 then
				var_605_0.localPosition = Vector3.New(-0.7, -0.71, -6)

				local var_605_7 = manager.ui.mainCamera.transform.position - var_605_0.position

				var_605_0.forward = Vector3.New(var_605_7.x, var_605_7.y, var_605_7.z)

				local var_605_8 = var_605_0.localEulerAngles

				var_605_8.z = 0
				var_605_8.x = 0
				var_605_0.localEulerAngles = var_605_8
			end

			local var_605_9 = arg_602_1.actors_["1011ui_story"]
			local var_605_10 = 0

			if var_605_10 < arg_602_1.time_ and arg_602_1.time_ <= var_605_10 + arg_605_0 and not isNil(var_605_9) and arg_602_1.var_.characterEffect1011ui_story == nil then
				arg_602_1.var_.characterEffect1011ui_story = var_605_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_605_11 = 0.200000002980232

			if var_605_10 <= arg_602_1.time_ and arg_602_1.time_ < var_605_10 + var_605_11 and not isNil(var_605_9) then
				local var_605_12 = (arg_602_1.time_ - var_605_10) / var_605_11

				if arg_602_1.var_.characterEffect1011ui_story and not isNil(var_605_9) then
					arg_602_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_602_1.time_ >= var_605_10 + var_605_11 and arg_602_1.time_ < var_605_10 + var_605_11 + arg_605_0 and not isNil(var_605_9) and arg_602_1.var_.characterEffect1011ui_story then
				arg_602_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_605_13 = 0

			if var_605_13 < arg_602_1.time_ and arg_602_1.time_ <= var_605_13 + arg_605_0 then
				arg_602_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011actionlink/1011action426")
			end

			local var_605_14 = 0

			if var_605_14 < arg_602_1.time_ and arg_602_1.time_ <= var_605_14 + arg_605_0 then
				arg_602_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_605_15 = arg_602_1.actors_["1111ui_story"]
			local var_605_16 = 0

			if var_605_16 < arg_602_1.time_ and arg_602_1.time_ <= var_605_16 + arg_605_0 and not isNil(var_605_15) and arg_602_1.var_.characterEffect1111ui_story == nil then
				arg_602_1.var_.characterEffect1111ui_story = var_605_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_605_17 = 0.200000002980232

			if var_605_16 <= arg_602_1.time_ and arg_602_1.time_ < var_605_16 + var_605_17 and not isNil(var_605_15) then
				local var_605_18 = (arg_602_1.time_ - var_605_16) / var_605_17

				if arg_602_1.var_.characterEffect1111ui_story and not isNil(var_605_15) then
					local var_605_19 = Mathf.Lerp(0, 0.5, var_605_18)

					arg_602_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_602_1.var_.characterEffect1111ui_story.fillRatio = var_605_19
				end
			end

			if arg_602_1.time_ >= var_605_16 + var_605_17 and arg_602_1.time_ < var_605_16 + var_605_17 + arg_605_0 and not isNil(var_605_15) and arg_602_1.var_.characterEffect1111ui_story then
				local var_605_20 = 0.5

				arg_602_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_602_1.var_.characterEffect1111ui_story.fillRatio = var_605_20
			end

			local var_605_21 = 0
			local var_605_22 = 0.275

			if var_605_21 < arg_602_1.time_ and arg_602_1.time_ <= var_605_21 + arg_605_0 then
				arg_602_1.talkMaxDuration = 0
				arg_602_1.dialogCg_.alpha = 1

				arg_602_1.dialog_:SetActive(true)
				SetActive(arg_602_1.leftNameGo_, true)

				local var_605_23 = arg_602_1:FormatText(StoryNameCfg[37].name)

				arg_602_1.leftNameTxt_.text = var_605_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_602_1.leftNameTxt_.transform)

				arg_602_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_602_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_602_1:RecordName(arg_602_1.leftNameTxt_.text)
				SetActive(arg_602_1.iconTrs_.gameObject, false)
				arg_602_1.callingController_:SetSelectedState("normal")

				local var_605_24 = arg_602_1:GetWordFromCfg(1101104148)
				local var_605_25 = arg_602_1:FormatText(var_605_24.content)

				arg_602_1.text_.text = var_605_25

				LuaForUtil.ClearLinePrefixSymbol(arg_602_1.text_)

				local var_605_26 = 11
				local var_605_27 = utf8.len(var_605_25)
				local var_605_28 = var_605_26 <= 0 and var_605_22 or var_605_22 * (var_605_27 / var_605_26)

				if var_605_28 > 0 and var_605_22 < var_605_28 then
					arg_602_1.talkMaxDuration = var_605_28

					if var_605_28 + var_605_21 > arg_602_1.duration_ then
						arg_602_1.duration_ = var_605_28 + var_605_21
					end
				end

				arg_602_1.text_.text = var_605_25
				arg_602_1.typewritter.percent = 0

				arg_602_1.typewritter:SetDirty()
				arg_602_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101104", "1101104148", "story_v_side_new_1101104.awb") ~= 0 then
					local var_605_29 = manager.audio:GetVoiceLength("story_v_side_new_1101104", "1101104148", "story_v_side_new_1101104.awb") / 1000

					if var_605_29 + var_605_21 > arg_602_1.duration_ then
						arg_602_1.duration_ = var_605_29 + var_605_21
					end

					if var_605_24.prefab_name ~= "" and arg_602_1.actors_[var_605_24.prefab_name] ~= nil then
						local var_605_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_602_1.actors_[var_605_24.prefab_name].transform, "story_v_side_new_1101104", "1101104148", "story_v_side_new_1101104.awb")

						arg_602_1:RecordAudio("1101104148", var_605_30)
						arg_602_1:RecordAudio("1101104148", var_605_30)
					else
						arg_602_1:AudioAction("play", "voice", "story_v_side_new_1101104", "1101104148", "story_v_side_new_1101104.awb")
					end

					arg_602_1:RecordHistoryTalkVoice("story_v_side_new_1101104", "1101104148", "story_v_side_new_1101104.awb")
				end

				arg_602_1:RecordContent(arg_602_1.text_.text)
			end

			local var_605_31 = math.max(var_605_22, arg_602_1.talkMaxDuration)

			if var_605_21 <= arg_602_1.time_ and arg_602_1.time_ < var_605_21 + var_605_31 then
				arg_602_1.typewritter.percent = (arg_602_1.time_ - var_605_21) / var_605_31

				arg_602_1.typewritter:SetDirty()
			end

			if arg_602_1.time_ >= var_605_21 + var_605_31 and arg_602_1.time_ < var_605_21 + var_605_31 + arg_605_0 then
				arg_602_1.typewritter.percent = 1

				arg_602_1.typewritter:SetDirty()
				arg_602_1:ShowNextGo(true)
			end
		end

		arg_602_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_602_1:InitPlayNodeList()
	end,
	Play1101104149 = function(arg_606_0, arg_606_1)
		arg_606_1.time_ = 0
		arg_606_1.frameCnt_ = 0
		arg_606_1.state_ = "playing"
		arg_606_1.curTalkId_ = 1101104149
		arg_606_1.duration_ = 7.13

		local var_606_0 = {
			zh = 5.033,
			ja = 7.133
		}
		local var_606_1 = manager.audio:GetLocalizationFlag()

		if var_606_0[var_606_1] ~= nil then
			arg_606_1.duration_ = var_606_0[var_606_1]
		end

		SetActive(arg_606_1.tipsGo_, false)

		function arg_606_1.onSingleLineFinish_()
			arg_606_1.onSingleLineUpdate_ = nil
			arg_606_1.onSingleLineFinish_ = nil
			arg_606_1.state_ = "waiting"
		end

		function arg_606_1.playNext_(arg_608_0)
			if arg_608_0 == 1 then
				arg_606_0:Play1101104150(arg_606_1)
			end
		end

		function arg_606_1.onSingleLineUpdate_(arg_609_0)
			local var_609_0 = arg_606_1.actors_["1111ui_story"].transform
			local var_609_1 = 0

			if var_609_1 < arg_606_1.time_ and arg_606_1.time_ <= var_609_1 + arg_609_0 then
				arg_606_1.var_.moveOldPos1111ui_story = var_609_0.localPosition
			end

			local var_609_2 = 0.001

			if var_609_1 <= arg_606_1.time_ and arg_606_1.time_ < var_609_1 + var_609_2 then
				local var_609_3 = (arg_606_1.time_ - var_609_1) / var_609_2
				local var_609_4 = Vector3.New(0.7, -0.87, -5.7)

				var_609_0.localPosition = Vector3.Lerp(arg_606_1.var_.moveOldPos1111ui_story, var_609_4, var_609_3)

				local var_609_5 = manager.ui.mainCamera.transform.position - var_609_0.position

				var_609_0.forward = Vector3.New(var_609_5.x, var_609_5.y, var_609_5.z)

				local var_609_6 = var_609_0.localEulerAngles

				var_609_6.z = 0
				var_609_6.x = 0
				var_609_0.localEulerAngles = var_609_6
			end

			if arg_606_1.time_ >= var_609_1 + var_609_2 and arg_606_1.time_ < var_609_1 + var_609_2 + arg_609_0 then
				var_609_0.localPosition = Vector3.New(0.7, -0.87, -5.7)

				local var_609_7 = manager.ui.mainCamera.transform.position - var_609_0.position

				var_609_0.forward = Vector3.New(var_609_7.x, var_609_7.y, var_609_7.z)

				local var_609_8 = var_609_0.localEulerAngles

				var_609_8.z = 0
				var_609_8.x = 0
				var_609_0.localEulerAngles = var_609_8
			end

			local var_609_9 = arg_606_1.actors_["1111ui_story"]
			local var_609_10 = 0

			if var_609_10 < arg_606_1.time_ and arg_606_1.time_ <= var_609_10 + arg_609_0 and not isNil(var_609_9) and arg_606_1.var_.characterEffect1111ui_story == nil then
				arg_606_1.var_.characterEffect1111ui_story = var_609_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_609_11 = 0.200000002980232

			if var_609_10 <= arg_606_1.time_ and arg_606_1.time_ < var_609_10 + var_609_11 and not isNil(var_609_9) then
				local var_609_12 = (arg_606_1.time_ - var_609_10) / var_609_11

				if arg_606_1.var_.characterEffect1111ui_story and not isNil(var_609_9) then
					arg_606_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_606_1.time_ >= var_609_10 + var_609_11 and arg_606_1.time_ < var_609_10 + var_609_11 + arg_609_0 and not isNil(var_609_9) and arg_606_1.var_.characterEffect1111ui_story then
				arg_606_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_609_13 = 0

			if var_609_13 < arg_606_1.time_ and arg_606_1.time_ <= var_609_13 + arg_609_0 then
				arg_606_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111actionlink/1111action484")
			end

			local var_609_14 = 0

			if var_609_14 < arg_606_1.time_ and arg_606_1.time_ <= var_609_14 + arg_609_0 then
				arg_606_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_609_15 = 2

			if var_609_15 < arg_606_1.time_ and arg_606_1.time_ <= var_609_15 + arg_609_0 then
				arg_606_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_609_16 = arg_606_1.actors_["1011ui_story"]
			local var_609_17 = 0

			if var_609_17 < arg_606_1.time_ and arg_606_1.time_ <= var_609_17 + arg_609_0 and not isNil(var_609_16) and arg_606_1.var_.characterEffect1011ui_story == nil then
				arg_606_1.var_.characterEffect1011ui_story = var_609_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_609_18 = 0.200000002980232

			if var_609_17 <= arg_606_1.time_ and arg_606_1.time_ < var_609_17 + var_609_18 and not isNil(var_609_16) then
				local var_609_19 = (arg_606_1.time_ - var_609_17) / var_609_18

				if arg_606_1.var_.characterEffect1011ui_story and not isNil(var_609_16) then
					local var_609_20 = Mathf.Lerp(0, 0.5, var_609_19)

					arg_606_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_606_1.var_.characterEffect1011ui_story.fillRatio = var_609_20
				end
			end

			if arg_606_1.time_ >= var_609_17 + var_609_18 and arg_606_1.time_ < var_609_17 + var_609_18 + arg_609_0 and not isNil(var_609_16) and arg_606_1.var_.characterEffect1011ui_story then
				local var_609_21 = 0.5

				arg_606_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_606_1.var_.characterEffect1011ui_story.fillRatio = var_609_21
			end

			local var_609_22 = 0
			local var_609_23 = 0.575

			if var_609_22 < arg_606_1.time_ and arg_606_1.time_ <= var_609_22 + arg_609_0 then
				arg_606_1.talkMaxDuration = 0
				arg_606_1.dialogCg_.alpha = 1

				arg_606_1.dialog_:SetActive(true)
				SetActive(arg_606_1.leftNameGo_, true)

				local var_609_24 = arg_606_1:FormatText(StoryNameCfg[67].name)

				arg_606_1.leftNameTxt_.text = var_609_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_606_1.leftNameTxt_.transform)

				arg_606_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_606_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_606_1:RecordName(arg_606_1.leftNameTxt_.text)
				SetActive(arg_606_1.iconTrs_.gameObject, false)
				arg_606_1.callingController_:SetSelectedState("normal")

				local var_609_25 = arg_606_1:GetWordFromCfg(1101104149)
				local var_609_26 = arg_606_1:FormatText(var_609_25.content)

				arg_606_1.text_.text = var_609_26

				LuaForUtil.ClearLinePrefixSymbol(arg_606_1.text_)

				local var_609_27 = 23
				local var_609_28 = utf8.len(var_609_26)
				local var_609_29 = var_609_27 <= 0 and var_609_23 or var_609_23 * (var_609_28 / var_609_27)

				if var_609_29 > 0 and var_609_23 < var_609_29 then
					arg_606_1.talkMaxDuration = var_609_29

					if var_609_29 + var_609_22 > arg_606_1.duration_ then
						arg_606_1.duration_ = var_609_29 + var_609_22
					end
				end

				arg_606_1.text_.text = var_609_26
				arg_606_1.typewritter.percent = 0

				arg_606_1.typewritter:SetDirty()
				arg_606_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101104", "1101104149", "story_v_side_new_1101104.awb") ~= 0 then
					local var_609_30 = manager.audio:GetVoiceLength("story_v_side_new_1101104", "1101104149", "story_v_side_new_1101104.awb") / 1000

					if var_609_30 + var_609_22 > arg_606_1.duration_ then
						arg_606_1.duration_ = var_609_30 + var_609_22
					end

					if var_609_25.prefab_name ~= "" and arg_606_1.actors_[var_609_25.prefab_name] ~= nil then
						local var_609_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_606_1.actors_[var_609_25.prefab_name].transform, "story_v_side_new_1101104", "1101104149", "story_v_side_new_1101104.awb")

						arg_606_1:RecordAudio("1101104149", var_609_31)
						arg_606_1:RecordAudio("1101104149", var_609_31)
					else
						arg_606_1:AudioAction("play", "voice", "story_v_side_new_1101104", "1101104149", "story_v_side_new_1101104.awb")
					end

					arg_606_1:RecordHistoryTalkVoice("story_v_side_new_1101104", "1101104149", "story_v_side_new_1101104.awb")
				end

				arg_606_1:RecordContent(arg_606_1.text_.text)
			end

			local var_609_32 = math.max(var_609_23, arg_606_1.talkMaxDuration)

			if var_609_22 <= arg_606_1.time_ and arg_606_1.time_ < var_609_22 + var_609_32 then
				arg_606_1.typewritter.percent = (arg_606_1.time_ - var_609_22) / var_609_32

				arg_606_1.typewritter:SetDirty()
			end

			if arg_606_1.time_ >= var_609_22 + var_609_32 and arg_606_1.time_ < var_609_22 + var_609_32 + arg_609_0 then
				arg_606_1.typewritter.percent = 1

				arg_606_1.typewritter:SetDirty()
				arg_606_1:ShowNextGo(true)
			end
		end

		arg_606_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_606_1:InitPlayNodeList()
	end,
	Play1101104150 = function(arg_610_0, arg_610_1)
		arg_610_1.time_ = 0
		arg_610_1.frameCnt_ = 0
		arg_610_1.state_ = "playing"
		arg_610_1.curTalkId_ = 1101104150
		arg_610_1.duration_ = 2

		SetActive(arg_610_1.tipsGo_, false)

		function arg_610_1.onSingleLineFinish_()
			arg_610_1.onSingleLineUpdate_ = nil
			arg_610_1.onSingleLineFinish_ = nil
			arg_610_1.state_ = "waiting"
		end

		function arg_610_1.playNext_(arg_612_0)
			if arg_612_0 == 1 then
				arg_610_0:Play1101104151(arg_610_1)
			end
		end

		function arg_610_1.onSingleLineUpdate_(arg_613_0)
			local var_613_0 = arg_610_1.actors_["1011ui_story"].transform
			local var_613_1 = 0

			if var_613_1 < arg_610_1.time_ and arg_610_1.time_ <= var_613_1 + arg_613_0 then
				arg_610_1.var_.moveOldPos1011ui_story = var_613_0.localPosition
			end

			local var_613_2 = 0.001

			if var_613_1 <= arg_610_1.time_ and arg_610_1.time_ < var_613_1 + var_613_2 then
				local var_613_3 = (arg_610_1.time_ - var_613_1) / var_613_2
				local var_613_4 = Vector3.New(-0.7, -0.71, -6)

				var_613_0.localPosition = Vector3.Lerp(arg_610_1.var_.moveOldPos1011ui_story, var_613_4, var_613_3)

				local var_613_5 = manager.ui.mainCamera.transform.position - var_613_0.position

				var_613_0.forward = Vector3.New(var_613_5.x, var_613_5.y, var_613_5.z)

				local var_613_6 = var_613_0.localEulerAngles

				var_613_6.z = 0
				var_613_6.x = 0
				var_613_0.localEulerAngles = var_613_6
			end

			if arg_610_1.time_ >= var_613_1 + var_613_2 and arg_610_1.time_ < var_613_1 + var_613_2 + arg_613_0 then
				var_613_0.localPosition = Vector3.New(-0.7, -0.71, -6)

				local var_613_7 = manager.ui.mainCamera.transform.position - var_613_0.position

				var_613_0.forward = Vector3.New(var_613_7.x, var_613_7.y, var_613_7.z)

				local var_613_8 = var_613_0.localEulerAngles

				var_613_8.z = 0
				var_613_8.x = 0
				var_613_0.localEulerAngles = var_613_8
			end

			local var_613_9 = arg_610_1.actors_["1011ui_story"]
			local var_613_10 = 0

			if var_613_10 < arg_610_1.time_ and arg_610_1.time_ <= var_613_10 + arg_613_0 and not isNil(var_613_9) and arg_610_1.var_.characterEffect1011ui_story == nil then
				arg_610_1.var_.characterEffect1011ui_story = var_613_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_613_11 = 0.200000002980232

			if var_613_10 <= arg_610_1.time_ and arg_610_1.time_ < var_613_10 + var_613_11 and not isNil(var_613_9) then
				local var_613_12 = (arg_610_1.time_ - var_613_10) / var_613_11

				if arg_610_1.var_.characterEffect1011ui_story and not isNil(var_613_9) then
					arg_610_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_610_1.time_ >= var_613_10 + var_613_11 and arg_610_1.time_ < var_613_10 + var_613_11 + arg_613_0 and not isNil(var_613_9) and arg_610_1.var_.characterEffect1011ui_story then
				arg_610_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_613_13 = arg_610_1.actors_["1111ui_story"]
			local var_613_14 = 0

			if var_613_14 < arg_610_1.time_ and arg_610_1.time_ <= var_613_14 + arg_613_0 and not isNil(var_613_13) and arg_610_1.var_.characterEffect1111ui_story == nil then
				arg_610_1.var_.characterEffect1111ui_story = var_613_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_613_15 = 0.200000002980232

			if var_613_14 <= arg_610_1.time_ and arg_610_1.time_ < var_613_14 + var_613_15 and not isNil(var_613_13) then
				local var_613_16 = (arg_610_1.time_ - var_613_14) / var_613_15

				if arg_610_1.var_.characterEffect1111ui_story and not isNil(var_613_13) then
					local var_613_17 = Mathf.Lerp(0, 0.5, var_613_16)

					arg_610_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_610_1.var_.characterEffect1111ui_story.fillRatio = var_613_17
				end
			end

			if arg_610_1.time_ >= var_613_14 + var_613_15 and arg_610_1.time_ < var_613_14 + var_613_15 + arg_613_0 and not isNil(var_613_13) and arg_610_1.var_.characterEffect1111ui_story then
				local var_613_18 = 0.5

				arg_610_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_610_1.var_.characterEffect1111ui_story.fillRatio = var_613_18
			end

			local var_613_19 = 0

			if var_613_19 < arg_610_1.time_ and arg_610_1.time_ <= var_613_19 + arg_613_0 then
				arg_610_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_613_20 = 0
			local var_613_21 = 0.1

			if var_613_20 < arg_610_1.time_ and arg_610_1.time_ <= var_613_20 + arg_613_0 then
				arg_610_1.talkMaxDuration = 0
				arg_610_1.dialogCg_.alpha = 1

				arg_610_1.dialog_:SetActive(true)
				SetActive(arg_610_1.leftNameGo_, true)

				local var_613_22 = arg_610_1:FormatText(StoryNameCfg[580].name)

				arg_610_1.leftNameTxt_.text = var_613_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_610_1.leftNameTxt_.transform)

				arg_610_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_610_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_610_1:RecordName(arg_610_1.leftNameTxt_.text)
				SetActive(arg_610_1.iconTrs_.gameObject, false)
				arg_610_1.callingController_:SetSelectedState("normal")

				local var_613_23 = arg_610_1:GetWordFromCfg(1101104150)
				local var_613_24 = arg_610_1:FormatText(var_613_23.content)

				arg_610_1.text_.text = var_613_24

				LuaForUtil.ClearLinePrefixSymbol(arg_610_1.text_)

				local var_613_25 = 4
				local var_613_26 = utf8.len(var_613_24)
				local var_613_27 = var_613_25 <= 0 and var_613_21 or var_613_21 * (var_613_26 / var_613_25)

				if var_613_27 > 0 and var_613_21 < var_613_27 then
					arg_610_1.talkMaxDuration = var_613_27

					if var_613_27 + var_613_20 > arg_610_1.duration_ then
						arg_610_1.duration_ = var_613_27 + var_613_20
					end
				end

				arg_610_1.text_.text = var_613_24
				arg_610_1.typewritter.percent = 0

				arg_610_1.typewritter:SetDirty()
				arg_610_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101104", "1101104150", "story_v_side_new_1101104.awb") ~= 0 then
					local var_613_28 = manager.audio:GetVoiceLength("story_v_side_new_1101104", "1101104150", "story_v_side_new_1101104.awb") / 1000

					if var_613_28 + var_613_20 > arg_610_1.duration_ then
						arg_610_1.duration_ = var_613_28 + var_613_20
					end

					if var_613_23.prefab_name ~= "" and arg_610_1.actors_[var_613_23.prefab_name] ~= nil then
						local var_613_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_610_1.actors_[var_613_23.prefab_name].transform, "story_v_side_new_1101104", "1101104150", "story_v_side_new_1101104.awb")

						arg_610_1:RecordAudio("1101104150", var_613_29)
						arg_610_1:RecordAudio("1101104150", var_613_29)
					else
						arg_610_1:AudioAction("play", "voice", "story_v_side_new_1101104", "1101104150", "story_v_side_new_1101104.awb")
					end

					arg_610_1:RecordHistoryTalkVoice("story_v_side_new_1101104", "1101104150", "story_v_side_new_1101104.awb")
				end

				arg_610_1:RecordContent(arg_610_1.text_.text)
			end

			local var_613_30 = math.max(var_613_21, arg_610_1.talkMaxDuration)

			if var_613_20 <= arg_610_1.time_ and arg_610_1.time_ < var_613_20 + var_613_30 then
				arg_610_1.typewritter.percent = (arg_610_1.time_ - var_613_20) / var_613_30

				arg_610_1.typewritter:SetDirty()
			end

			if arg_610_1.time_ >= var_613_20 + var_613_30 and arg_610_1.time_ < var_613_20 + var_613_30 + arg_613_0 then
				arg_610_1.typewritter.percent = 1

				arg_610_1.typewritter:SetDirty()
				arg_610_1:ShowNextGo(true)
			end
		end

		arg_610_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_610_1:InitPlayNodeList()
	end,
	Play1101104151 = function(arg_614_0, arg_614_1)
		arg_614_1.time_ = 0
		arg_614_1.frameCnt_ = 0
		arg_614_1.state_ = "playing"
		arg_614_1.curTalkId_ = 1101104151
		arg_614_1.duration_ = 5

		SetActive(arg_614_1.tipsGo_, false)

		function arg_614_1.onSingleLineFinish_()
			arg_614_1.onSingleLineUpdate_ = nil
			arg_614_1.onSingleLineFinish_ = nil
			arg_614_1.state_ = "waiting"
		end

		function arg_614_1.playNext_(arg_616_0)
			if arg_616_0 == 1 then
				arg_614_0:Play1101104152(arg_614_1)
			end
		end

		function arg_614_1.onSingleLineUpdate_(arg_617_0)
			local var_617_0 = arg_614_1.actors_["1011ui_story"].transform
			local var_617_1 = 0

			if var_617_1 < arg_614_1.time_ and arg_614_1.time_ <= var_617_1 + arg_617_0 then
				arg_614_1.var_.moveOldPos1011ui_story = var_617_0.localPosition
			end

			local var_617_2 = 0.001

			if var_617_1 <= arg_614_1.time_ and arg_614_1.time_ < var_617_1 + var_617_2 then
				local var_617_3 = (arg_614_1.time_ - var_617_1) / var_617_2
				local var_617_4 = Vector3.New(0, 100, 0)

				var_617_0.localPosition = Vector3.Lerp(arg_614_1.var_.moveOldPos1011ui_story, var_617_4, var_617_3)

				local var_617_5 = manager.ui.mainCamera.transform.position - var_617_0.position

				var_617_0.forward = Vector3.New(var_617_5.x, var_617_5.y, var_617_5.z)

				local var_617_6 = var_617_0.localEulerAngles

				var_617_6.z = 0
				var_617_6.x = 0
				var_617_0.localEulerAngles = var_617_6
			end

			if arg_614_1.time_ >= var_617_1 + var_617_2 and arg_614_1.time_ < var_617_1 + var_617_2 + arg_617_0 then
				var_617_0.localPosition = Vector3.New(0, 100, 0)

				local var_617_7 = manager.ui.mainCamera.transform.position - var_617_0.position

				var_617_0.forward = Vector3.New(var_617_7.x, var_617_7.y, var_617_7.z)

				local var_617_8 = var_617_0.localEulerAngles

				var_617_8.z = 0
				var_617_8.x = 0
				var_617_0.localEulerAngles = var_617_8
			end

			local var_617_9 = arg_614_1.actors_["1111ui_story"].transform
			local var_617_10 = 0

			if var_617_10 < arg_614_1.time_ and arg_614_1.time_ <= var_617_10 + arg_617_0 then
				arg_614_1.var_.moveOldPos1111ui_story = var_617_9.localPosition
			end

			local var_617_11 = 0.001

			if var_617_10 <= arg_614_1.time_ and arg_614_1.time_ < var_617_10 + var_617_11 then
				local var_617_12 = (arg_614_1.time_ - var_617_10) / var_617_11
				local var_617_13 = Vector3.New(0, 100, 0)

				var_617_9.localPosition = Vector3.Lerp(arg_614_1.var_.moveOldPos1111ui_story, var_617_13, var_617_12)

				local var_617_14 = manager.ui.mainCamera.transform.position - var_617_9.position

				var_617_9.forward = Vector3.New(var_617_14.x, var_617_14.y, var_617_14.z)

				local var_617_15 = var_617_9.localEulerAngles

				var_617_15.z = 0
				var_617_15.x = 0
				var_617_9.localEulerAngles = var_617_15
			end

			if arg_614_1.time_ >= var_617_10 + var_617_11 and arg_614_1.time_ < var_617_10 + var_617_11 + arg_617_0 then
				var_617_9.localPosition = Vector3.New(0, 100, 0)

				local var_617_16 = manager.ui.mainCamera.transform.position - var_617_9.position

				var_617_9.forward = Vector3.New(var_617_16.x, var_617_16.y, var_617_16.z)

				local var_617_17 = var_617_9.localEulerAngles

				var_617_17.z = 0
				var_617_17.x = 0
				var_617_9.localEulerAngles = var_617_17
			end

			local var_617_18 = 0
			local var_617_19 = 1.075

			if var_617_18 < arg_614_1.time_ and arg_614_1.time_ <= var_617_18 + arg_617_0 then
				arg_614_1.talkMaxDuration = 0
				arg_614_1.dialogCg_.alpha = 1

				arg_614_1.dialog_:SetActive(true)
				SetActive(arg_614_1.leftNameGo_, false)

				arg_614_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_614_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_614_1:RecordName(arg_614_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_614_1.iconTrs_.gameObject, false)
				arg_614_1.callingController_:SetSelectedState("normal")

				local var_617_20 = arg_614_1:GetWordFromCfg(1101104151)
				local var_617_21 = arg_614_1:FormatText(var_617_20.content)

				arg_614_1.text_.text = var_617_21

				LuaForUtil.ClearLinePrefixSymbol(arg_614_1.text_)

				local var_617_22 = 43
				local var_617_23 = utf8.len(var_617_21)
				local var_617_24 = var_617_22 <= 0 and var_617_19 or var_617_19 * (var_617_23 / var_617_22)

				if var_617_24 > 0 and var_617_19 < var_617_24 then
					arg_614_1.talkMaxDuration = var_617_24

					if var_617_24 + var_617_18 > arg_614_1.duration_ then
						arg_614_1.duration_ = var_617_24 + var_617_18
					end
				end

				arg_614_1.text_.text = var_617_21
				arg_614_1.typewritter.percent = 0

				arg_614_1.typewritter:SetDirty()
				arg_614_1:ShowNextGo(false)
				arg_614_1:RecordContent(arg_614_1.text_.text)
			end

			local var_617_25 = math.max(var_617_19, arg_614_1.talkMaxDuration)

			if var_617_18 <= arg_614_1.time_ and arg_614_1.time_ < var_617_18 + var_617_25 then
				arg_614_1.typewritter.percent = (arg_614_1.time_ - var_617_18) / var_617_25

				arg_614_1.typewritter:SetDirty()
			end

			if arg_614_1.time_ >= var_617_18 + var_617_25 and arg_614_1.time_ < var_617_18 + var_617_25 + arg_617_0 then
				arg_614_1.typewritter.percent = 1

				arg_614_1.typewritter:SetDirty()
				arg_614_1:ShowNextGo(true)
			end
		end

		arg_614_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_614_1:InitPlayNodeList()
	end,
	Play1101104152 = function(arg_618_0, arg_618_1)
		arg_618_1.time_ = 0
		arg_618_1.frameCnt_ = 0
		arg_618_1.state_ = "playing"
		arg_618_1.curTalkId_ = 1101104152
		arg_618_1.duration_ = 9

		SetActive(arg_618_1.tipsGo_, false)

		function arg_618_1.onSingleLineFinish_()
			arg_618_1.onSingleLineUpdate_ = nil
			arg_618_1.onSingleLineFinish_ = nil
			arg_618_1.state_ = "waiting"
		end

		function arg_618_1.playNext_(arg_620_0)
			if arg_620_0 == 1 then
				arg_618_0:Play1101104153(arg_618_1)
			end
		end

		function arg_618_1.onSingleLineUpdate_(arg_621_0)
			local var_621_0 = "R1101"

			if arg_618_1.bgs_[var_621_0] == nil then
				local var_621_1 = Object.Instantiate(arg_618_1.paintGo_)

				var_621_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_621_0)
				var_621_1.name = var_621_0
				var_621_1.transform.parent = arg_618_1.stage_.transform
				var_621_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_618_1.bgs_[var_621_0] = var_621_1
			end

			local var_621_2 = 2

			if var_621_2 < arg_618_1.time_ and arg_618_1.time_ <= var_621_2 + arg_621_0 then
				local var_621_3 = manager.ui.mainCamera.transform.localPosition
				local var_621_4 = Vector3.New(0, 0, 10) + Vector3.New(var_621_3.x, var_621_3.y, 0)
				local var_621_5 = arg_618_1.bgs_.R1101

				var_621_5.transform.localPosition = var_621_4
				var_621_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_621_6 = var_621_5:GetComponent("SpriteRenderer")

				if var_621_6 and var_621_6.sprite then
					local var_621_7 = (var_621_5.transform.localPosition - var_621_3).z
					local var_621_8 = manager.ui.mainCameraCom_
					local var_621_9 = 2 * var_621_7 * Mathf.Tan(var_621_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_621_10 = var_621_9 * var_621_8.aspect
					local var_621_11 = var_621_6.sprite.bounds.size.x
					local var_621_12 = var_621_6.sprite.bounds.size.y
					local var_621_13 = var_621_10 / var_621_11
					local var_621_14 = var_621_9 / var_621_12
					local var_621_15 = var_621_14 < var_621_13 and var_621_13 or var_621_14

					var_621_5.transform.localScale = Vector3.New(var_621_15, var_621_15, 0)
				end

				for iter_621_0, iter_621_1 in pairs(arg_618_1.bgs_) do
					if iter_621_0 ~= "R1101" then
						iter_621_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_621_16 = 0

			if var_621_16 < arg_618_1.time_ and arg_618_1.time_ <= var_621_16 + arg_621_0 then
				arg_618_1.mask_.enabled = true
				arg_618_1.mask_.raycastTarget = true

				arg_618_1:SetGaussion(false)
			end

			local var_621_17 = 2

			if var_621_16 <= arg_618_1.time_ and arg_618_1.time_ < var_621_16 + var_621_17 then
				local var_621_18 = (arg_618_1.time_ - var_621_16) / var_621_17
				local var_621_19 = Color.New(0, 0, 0)

				var_621_19.a = Mathf.Lerp(0, 1, var_621_18)
				arg_618_1.mask_.color = var_621_19
			end

			if arg_618_1.time_ >= var_621_16 + var_621_17 and arg_618_1.time_ < var_621_16 + var_621_17 + arg_621_0 then
				local var_621_20 = Color.New(0, 0, 0)

				var_621_20.a = 1
				arg_618_1.mask_.color = var_621_20
			end

			local var_621_21 = 2

			if var_621_21 < arg_618_1.time_ and arg_618_1.time_ <= var_621_21 + arg_621_0 then
				arg_618_1.mask_.enabled = true
				arg_618_1.mask_.raycastTarget = true

				arg_618_1:SetGaussion(false)
			end

			local var_621_22 = 2

			if var_621_21 <= arg_618_1.time_ and arg_618_1.time_ < var_621_21 + var_621_22 then
				local var_621_23 = (arg_618_1.time_ - var_621_21) / var_621_22
				local var_621_24 = Color.New(0, 0, 0)

				var_621_24.a = Mathf.Lerp(1, 0, var_621_23)
				arg_618_1.mask_.color = var_621_24
			end

			if arg_618_1.time_ >= var_621_21 + var_621_22 and arg_618_1.time_ < var_621_21 + var_621_22 + arg_621_0 then
				local var_621_25 = Color.New(0, 0, 0)
				local var_621_26 = 0

				arg_618_1.mask_.enabled = false
				var_621_25.a = var_621_26
				arg_618_1.mask_.color = var_621_25
			end

			local var_621_27 = arg_618_1.bgs_.R1101.transform
			local var_621_28 = 2

			if var_621_28 < arg_618_1.time_ and arg_618_1.time_ <= var_621_28 + arg_621_0 then
				arg_618_1.var_.moveOldPosR1101 = var_621_27.localPosition
			end

			local var_621_29 = 0.001

			if var_621_28 <= arg_618_1.time_ and arg_618_1.time_ < var_621_28 + var_621_29 then
				local var_621_30 = (arg_618_1.time_ - var_621_28) / var_621_29
				local var_621_31 = Vector3.New(-4.28, -0.35, 0)

				var_621_27.localPosition = Vector3.Lerp(arg_618_1.var_.moveOldPosR1101, var_621_31, var_621_30)
			end

			if arg_618_1.time_ >= var_621_28 + var_621_29 and arg_618_1.time_ < var_621_28 + var_621_29 + arg_621_0 then
				var_621_27.localPosition = Vector3.New(-4.28, -0.35, 0)
			end

			local var_621_32 = arg_618_1.bgs_.R1101.transform
			local var_621_33 = 2.034

			if var_621_33 < arg_618_1.time_ and arg_618_1.time_ <= var_621_33 + arg_621_0 then
				arg_618_1.var_.moveOldPosR1101 = var_621_32.localPosition
			end

			local var_621_34 = 3

			if var_621_33 <= arg_618_1.time_ and arg_618_1.time_ < var_621_33 + var_621_34 then
				local var_621_35 = (arg_618_1.time_ - var_621_33) / var_621_34
				local var_621_36 = Vector3.New(-4.6, -0.35, 0)

				var_621_32.localPosition = Vector3.Lerp(arg_618_1.var_.moveOldPosR1101, var_621_36, var_621_35)
			end

			if arg_618_1.time_ >= var_621_33 + var_621_34 and arg_618_1.time_ < var_621_33 + var_621_34 + arg_621_0 then
				var_621_32.localPosition = Vector3.New(-4.6, -0.35, 0)
			end

			if arg_618_1.frameCnt_ <= 1 then
				arg_618_1.dialog_:SetActive(false)
			end

			local var_621_37 = 4
			local var_621_38 = 0.75

			if var_621_37 < arg_618_1.time_ and arg_618_1.time_ <= var_621_37 + arg_621_0 then
				arg_618_1.talkMaxDuration = 0

				arg_618_1.dialog_:SetActive(true)

				arg_618_1.dialogCg_.alpha = 0

				local var_621_39 = LeanTween.value(arg_618_1.dialog_, 0, 1, 0.3)

				var_621_39:setOnUpdate(LuaHelper.FloatAction(function(arg_622_0)
					arg_618_1.dialogCg_.alpha = arg_622_0
				end))
				var_621_39:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_618_1.dialog_)
					var_621_39:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_618_1.duration_ = arg_618_1.duration_ + 0.3

				SetActive(arg_618_1.leftNameGo_, true)

				local var_621_40 = arg_618_1:FormatText(StoryNameCfg[7].name)

				arg_618_1.leftNameTxt_.text = var_621_40

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_618_1.leftNameTxt_.transform)

				arg_618_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_618_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_618_1:RecordName(arg_618_1.leftNameTxt_.text)
				SetActive(arg_618_1.iconTrs_.gameObject, true)
				arg_618_1.iconController_:SetSelectedState("hero")

				arg_618_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_618_1.callingController_:SetSelectedState("normal")

				arg_618_1.keyicon_.color = Color.New(1, 1, 1)
				arg_618_1.icon_.color = Color.New(1, 1, 1)

				local var_621_41 = arg_618_1:GetWordFromCfg(1101104152)
				local var_621_42 = arg_618_1:FormatText(var_621_41.content)

				arg_618_1.text_.text = var_621_42

				LuaForUtil.ClearLinePrefixSymbol(arg_618_1.text_)

				local var_621_43 = 30
				local var_621_44 = utf8.len(var_621_42)
				local var_621_45 = var_621_43 <= 0 and var_621_38 or var_621_38 * (var_621_44 / var_621_43)

				if var_621_45 > 0 and var_621_38 < var_621_45 then
					arg_618_1.talkMaxDuration = var_621_45
					var_621_37 = var_621_37 + 0.3

					if var_621_45 + var_621_37 > arg_618_1.duration_ then
						arg_618_1.duration_ = var_621_45 + var_621_37
					end
				end

				arg_618_1.text_.text = var_621_42
				arg_618_1.typewritter.percent = 0

				arg_618_1.typewritter:SetDirty()
				arg_618_1:ShowNextGo(false)
				arg_618_1:RecordContent(arg_618_1.text_.text)
			end

			local var_621_46 = var_621_37 + 0.3
			local var_621_47 = math.max(var_621_38, arg_618_1.talkMaxDuration)

			if var_621_46 <= arg_618_1.time_ and arg_618_1.time_ < var_621_46 + var_621_47 then
				arg_618_1.typewritter.percent = (arg_618_1.time_ - var_621_46) / var_621_47

				arg_618_1.typewritter:SetDirty()
			end

			if arg_618_1.time_ >= var_621_46 + var_621_47 and arg_618_1.time_ < var_621_46 + var_621_47 + arg_621_0 then
				arg_618_1.typewritter.percent = 1

				arg_618_1.typewritter:SetDirty()
				arg_618_1:ShowNextGo(true)
			end
		end

		arg_618_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "R1101",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "R1101",
				changeDisplayLayer = false,
				needEase = false,
				duration = 3,
				className = "StoryMoveNode",
				startTime = 2.034,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_618_1:InitPlayNodeList()
	end,
	Play1101104153 = function(arg_624_0, arg_624_1)
		arg_624_1.time_ = 0
		arg_624_1.frameCnt_ = 0
		arg_624_1.state_ = "playing"
		arg_624_1.curTalkId_ = 1101104153
		arg_624_1.duration_ = 5.17

		local var_624_0 = {
			zh = 5.166,
			ja = 3.533
		}
		local var_624_1 = manager.audio:GetLocalizationFlag()

		if var_624_0[var_624_1] ~= nil then
			arg_624_1.duration_ = var_624_0[var_624_1]
		end

		SetActive(arg_624_1.tipsGo_, false)

		function arg_624_1.onSingleLineFinish_()
			arg_624_1.onSingleLineUpdate_ = nil
			arg_624_1.onSingleLineFinish_ = nil
			arg_624_1.state_ = "waiting"
		end

		function arg_624_1.playNext_(arg_626_0)
			if arg_626_0 == 1 then
				arg_624_0:Play1101104154(arg_624_1)
			end
		end

		function arg_624_1.onSingleLineUpdate_(arg_627_0)
			local var_627_0 = 0
			local var_627_1 = 0.525

			if var_627_0 < arg_624_1.time_ and arg_624_1.time_ <= var_627_0 + arg_627_0 then
				arg_624_1.talkMaxDuration = 0
				arg_624_1.dialogCg_.alpha = 1

				arg_624_1.dialog_:SetActive(true)
				SetActive(arg_624_1.leftNameGo_, true)

				local var_627_2 = arg_624_1:FormatText(StoryNameCfg[67].name)

				arg_624_1.leftNameTxt_.text = var_627_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_624_1.leftNameTxt_.transform)

				arg_624_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_624_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_624_1:RecordName(arg_624_1.leftNameTxt_.text)
				SetActive(arg_624_1.iconTrs_.gameObject, false)
				arg_624_1.callingController_:SetSelectedState("normal")

				local var_627_3 = arg_624_1:GetWordFromCfg(1101104153)
				local var_627_4 = arg_624_1:FormatText(var_627_3.content)

				arg_624_1.text_.text = var_627_4

				LuaForUtil.ClearLinePrefixSymbol(arg_624_1.text_)

				local var_627_5 = 21
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

				if manager.audio:GetVoiceLength("story_v_side_new_1101104", "1101104153", "story_v_side_new_1101104.awb") ~= 0 then
					local var_627_8 = manager.audio:GetVoiceLength("story_v_side_new_1101104", "1101104153", "story_v_side_new_1101104.awb") / 1000

					if var_627_8 + var_627_0 > arg_624_1.duration_ then
						arg_624_1.duration_ = var_627_8 + var_627_0
					end

					if var_627_3.prefab_name ~= "" and arg_624_1.actors_[var_627_3.prefab_name] ~= nil then
						local var_627_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_624_1.actors_[var_627_3.prefab_name].transform, "story_v_side_new_1101104", "1101104153", "story_v_side_new_1101104.awb")

						arg_624_1:RecordAudio("1101104153", var_627_9)
						arg_624_1:RecordAudio("1101104153", var_627_9)
					else
						arg_624_1:AudioAction("play", "voice", "story_v_side_new_1101104", "1101104153", "story_v_side_new_1101104.awb")
					end

					arg_624_1:RecordHistoryTalkVoice("story_v_side_new_1101104", "1101104153", "story_v_side_new_1101104.awb")
				end

				arg_624_1:RecordContent(arg_624_1.text_.text)
			end

			local var_627_10 = math.max(var_627_1, arg_624_1.talkMaxDuration)

			if var_627_0 <= arg_624_1.time_ and arg_624_1.time_ < var_627_0 + var_627_10 then
				arg_624_1.typewritter.percent = (arg_624_1.time_ - var_627_0) / var_627_10

				arg_624_1.typewritter:SetDirty()
			end

			if arg_624_1.time_ >= var_627_0 + var_627_10 and arg_624_1.time_ < var_627_0 + var_627_10 + arg_627_0 then
				arg_624_1.typewritter.percent = 1

				arg_624_1.typewritter:SetDirty()
				arg_624_1:ShowNextGo(true)
			end
		end

		arg_624_1.nodeConfigList_ = {}

		arg_624_1:InitPlayNodeList()
	end,
	Play1101104154 = function(arg_628_0, arg_628_1)
		arg_628_1.time_ = 0
		arg_628_1.frameCnt_ = 0
		arg_628_1.state_ = "playing"
		arg_628_1.curTalkId_ = 1101104154
		arg_628_1.duration_ = 5

		SetActive(arg_628_1.tipsGo_, false)

		function arg_628_1.onSingleLineFinish_()
			arg_628_1.onSingleLineUpdate_ = nil
			arg_628_1.onSingleLineFinish_ = nil
			arg_628_1.state_ = "waiting"
		end

		function arg_628_1.playNext_(arg_630_0)
			if arg_630_0 == 1 then
				arg_628_0:Play1101104155(arg_628_1)
			end
		end

		function arg_628_1.onSingleLineUpdate_(arg_631_0)
			local var_631_0 = 0
			local var_631_1 = 1.525

			if var_631_0 < arg_628_1.time_ and arg_628_1.time_ <= var_631_0 + arg_631_0 then
				arg_628_1.talkMaxDuration = 0
				arg_628_1.dialogCg_.alpha = 1

				arg_628_1.dialog_:SetActive(true)
				SetActive(arg_628_1.leftNameGo_, false)

				arg_628_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_628_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_628_1:RecordName(arg_628_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_628_1.iconTrs_.gameObject, false)
				arg_628_1.callingController_:SetSelectedState("normal")

				local var_631_2 = arg_628_1:GetWordFromCfg(1101104154)
				local var_631_3 = arg_628_1:FormatText(var_631_2.content)

				arg_628_1.text_.text = var_631_3

				LuaForUtil.ClearLinePrefixSymbol(arg_628_1.text_)

				local var_631_4 = 61
				local var_631_5 = utf8.len(var_631_3)
				local var_631_6 = var_631_4 <= 0 and var_631_1 or var_631_1 * (var_631_5 / var_631_4)

				if var_631_6 > 0 and var_631_1 < var_631_6 then
					arg_628_1.talkMaxDuration = var_631_6

					if var_631_6 + var_631_0 > arg_628_1.duration_ then
						arg_628_1.duration_ = var_631_6 + var_631_0
					end
				end

				arg_628_1.text_.text = var_631_3
				arg_628_1.typewritter.percent = 0

				arg_628_1.typewritter:SetDirty()
				arg_628_1:ShowNextGo(false)
				arg_628_1:RecordContent(arg_628_1.text_.text)
			end

			local var_631_7 = math.max(var_631_1, arg_628_1.talkMaxDuration)

			if var_631_0 <= arg_628_1.time_ and arg_628_1.time_ < var_631_0 + var_631_7 then
				arg_628_1.typewritter.percent = (arg_628_1.time_ - var_631_0) / var_631_7

				arg_628_1.typewritter:SetDirty()
			end

			if arg_628_1.time_ >= var_631_0 + var_631_7 and arg_628_1.time_ < var_631_0 + var_631_7 + arg_631_0 then
				arg_628_1.typewritter.percent = 1

				arg_628_1.typewritter:SetDirty()
				arg_628_1:ShowNextGo(true)
			end
		end

		arg_628_1.nodeConfigList_ = {}

		arg_628_1:InitPlayNodeList()
	end,
	Play1101104155 = function(arg_632_0, arg_632_1)
		arg_632_1.time_ = 0
		arg_632_1.frameCnt_ = 0
		arg_632_1.state_ = "playing"
		arg_632_1.curTalkId_ = 1101104155
		arg_632_1.duration_ = 5

		SetActive(arg_632_1.tipsGo_, false)

		function arg_632_1.onSingleLineFinish_()
			arg_632_1.onSingleLineUpdate_ = nil
			arg_632_1.onSingleLineFinish_ = nil
			arg_632_1.state_ = "waiting"
		end

		function arg_632_1.playNext_(arg_634_0)
			if arg_634_0 == 1 then
				arg_632_0:Play1101104156(arg_632_1)
			end
		end

		function arg_632_1.onSingleLineUpdate_(arg_635_0)
			local var_635_0 = 0
			local var_635_1 = 0.3

			if var_635_0 < arg_632_1.time_ and arg_632_1.time_ <= var_635_0 + arg_635_0 then
				arg_632_1.talkMaxDuration = 0
				arg_632_1.dialogCg_.alpha = 1

				arg_632_1.dialog_:SetActive(true)
				SetActive(arg_632_1.leftNameGo_, true)

				local var_635_2 = arg_632_1:FormatText(StoryNameCfg[7].name)

				arg_632_1.leftNameTxt_.text = var_635_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_632_1.leftNameTxt_.transform)

				arg_632_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_632_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_632_1:RecordName(arg_632_1.leftNameTxt_.text)
				SetActive(arg_632_1.iconTrs_.gameObject, true)
				arg_632_1.iconController_:SetSelectedState("hero")

				arg_632_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_632_1.callingController_:SetSelectedState("normal")

				arg_632_1.keyicon_.color = Color.New(1, 1, 1)
				arg_632_1.icon_.color = Color.New(1, 1, 1)

				local var_635_3 = arg_632_1:GetWordFromCfg(1101104155)
				local var_635_4 = arg_632_1:FormatText(var_635_3.content)

				arg_632_1.text_.text = var_635_4

				LuaForUtil.ClearLinePrefixSymbol(arg_632_1.text_)

				local var_635_5 = 12
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
				arg_632_1:RecordContent(arg_632_1.text_.text)
			end

			local var_635_8 = math.max(var_635_1, arg_632_1.talkMaxDuration)

			if var_635_0 <= arg_632_1.time_ and arg_632_1.time_ < var_635_0 + var_635_8 then
				arg_632_1.typewritter.percent = (arg_632_1.time_ - var_635_0) / var_635_8

				arg_632_1.typewritter:SetDirty()
			end

			if arg_632_1.time_ >= var_635_0 + var_635_8 and arg_632_1.time_ < var_635_0 + var_635_8 + arg_635_0 then
				arg_632_1.typewritter.percent = 1

				arg_632_1.typewritter:SetDirty()
				arg_632_1:ShowNextGo(true)
			end
		end

		arg_632_1.nodeConfigList_ = {}

		arg_632_1:InitPlayNodeList()
	end,
	Play1101104156 = function(arg_636_0, arg_636_1)
		arg_636_1.time_ = 0
		arg_636_1.frameCnt_ = 0
		arg_636_1.state_ = "playing"
		arg_636_1.curTalkId_ = 1101104156
		arg_636_1.duration_ = 5.17

		local var_636_0 = {
			zh = 5.166,
			ja = 4.166
		}
		local var_636_1 = manager.audio:GetLocalizationFlag()

		if var_636_0[var_636_1] ~= nil then
			arg_636_1.duration_ = var_636_0[var_636_1]
		end

		SetActive(arg_636_1.tipsGo_, false)

		function arg_636_1.onSingleLineFinish_()
			arg_636_1.onSingleLineUpdate_ = nil
			arg_636_1.onSingleLineFinish_ = nil
			arg_636_1.state_ = "waiting"
		end

		function arg_636_1.playNext_(arg_638_0)
			if arg_638_0 == 1 then
				arg_636_0:Play1101104157(arg_636_1)
			end
		end

		function arg_636_1.onSingleLineUpdate_(arg_639_0)
			local var_639_0 = 0
			local var_639_1 = 0.7

			if var_639_0 < arg_636_1.time_ and arg_636_1.time_ <= var_639_0 + arg_639_0 then
				arg_636_1.talkMaxDuration = 0
				arg_636_1.dialogCg_.alpha = 1

				arg_636_1.dialog_:SetActive(true)
				SetActive(arg_636_1.leftNameGo_, true)

				local var_639_2 = arg_636_1:FormatText(StoryNameCfg[67].name)

				arg_636_1.leftNameTxt_.text = var_639_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_636_1.leftNameTxt_.transform)

				arg_636_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_636_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_636_1:RecordName(arg_636_1.leftNameTxt_.text)
				SetActive(arg_636_1.iconTrs_.gameObject, false)
				arg_636_1.callingController_:SetSelectedState("normal")

				local var_639_3 = arg_636_1:GetWordFromCfg(1101104156)
				local var_639_4 = arg_636_1:FormatText(var_639_3.content)

				arg_636_1.text_.text = var_639_4

				LuaForUtil.ClearLinePrefixSymbol(arg_636_1.text_)

				local var_639_5 = 28
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

				if manager.audio:GetVoiceLength("story_v_side_new_1101104", "1101104156", "story_v_side_new_1101104.awb") ~= 0 then
					local var_639_8 = manager.audio:GetVoiceLength("story_v_side_new_1101104", "1101104156", "story_v_side_new_1101104.awb") / 1000

					if var_639_8 + var_639_0 > arg_636_1.duration_ then
						arg_636_1.duration_ = var_639_8 + var_639_0
					end

					if var_639_3.prefab_name ~= "" and arg_636_1.actors_[var_639_3.prefab_name] ~= nil then
						local var_639_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_636_1.actors_[var_639_3.prefab_name].transform, "story_v_side_new_1101104", "1101104156", "story_v_side_new_1101104.awb")

						arg_636_1:RecordAudio("1101104156", var_639_9)
						arg_636_1:RecordAudio("1101104156", var_639_9)
					else
						arg_636_1:AudioAction("play", "voice", "story_v_side_new_1101104", "1101104156", "story_v_side_new_1101104.awb")
					end

					arg_636_1:RecordHistoryTalkVoice("story_v_side_new_1101104", "1101104156", "story_v_side_new_1101104.awb")
				end

				arg_636_1:RecordContent(arg_636_1.text_.text)
			end

			local var_639_10 = math.max(var_639_1, arg_636_1.talkMaxDuration)

			if var_639_0 <= arg_636_1.time_ and arg_636_1.time_ < var_639_0 + var_639_10 then
				arg_636_1.typewritter.percent = (arg_636_1.time_ - var_639_0) / var_639_10

				arg_636_1.typewritter:SetDirty()
			end

			if arg_636_1.time_ >= var_639_0 + var_639_10 and arg_636_1.time_ < var_639_0 + var_639_10 + arg_639_0 then
				arg_636_1.typewritter.percent = 1

				arg_636_1.typewritter:SetDirty()
				arg_636_1:ShowNextGo(true)
			end
		end

		arg_636_1.nodeConfigList_ = {}

		arg_636_1:InitPlayNodeList()
	end,
	Play1101104157 = function(arg_640_0, arg_640_1)
		arg_640_1.time_ = 0
		arg_640_1.frameCnt_ = 0
		arg_640_1.state_ = "playing"
		arg_640_1.curTalkId_ = 1101104157
		arg_640_1.duration_ = 5

		SetActive(arg_640_1.tipsGo_, false)

		function arg_640_1.onSingleLineFinish_()
			arg_640_1.onSingleLineUpdate_ = nil
			arg_640_1.onSingleLineFinish_ = nil
			arg_640_1.state_ = "waiting"
		end

		function arg_640_1.playNext_(arg_642_0)
			if arg_642_0 == 1 then
				arg_640_0:Play1101104158(arg_640_1)
			end
		end

		function arg_640_1.onSingleLineUpdate_(arg_643_0)
			local var_643_0 = 0
			local var_643_1 = 0.1

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

				arg_640_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_640_1.callingController_:SetSelectedState("normal")

				arg_640_1.keyicon_.color = Color.New(1, 1, 1)
				arg_640_1.icon_.color = Color.New(1, 1, 1)

				local var_643_3 = arg_640_1:GetWordFromCfg(1101104157)
				local var_643_4 = arg_640_1:FormatText(var_643_3.content)

				arg_640_1.text_.text = var_643_4

				LuaForUtil.ClearLinePrefixSymbol(arg_640_1.text_)

				local var_643_5 = 4
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
	Play1101104158 = function(arg_644_0, arg_644_1)
		arg_644_1.time_ = 0
		arg_644_1.frameCnt_ = 0
		arg_644_1.state_ = "playing"
		arg_644_1.curTalkId_ = 1101104158
		arg_644_1.duration_ = 6.17

		local var_644_0 = {
			zh = 4,
			ja = 6.166
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
				arg_644_0:Play1101104159(arg_644_1)
			end
		end

		function arg_644_1.onSingleLineUpdate_(arg_647_0)
			local var_647_0 = 0
			local var_647_1 = 0.4

			if var_647_0 < arg_644_1.time_ and arg_644_1.time_ <= var_647_0 + arg_647_0 then
				arg_644_1.talkMaxDuration = 0
				arg_644_1.dialogCg_.alpha = 1

				arg_644_1.dialog_:SetActive(true)
				SetActive(arg_644_1.leftNameGo_, true)

				local var_647_2 = arg_644_1:FormatText(StoryNameCfg[67].name)

				arg_644_1.leftNameTxt_.text = var_647_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_644_1.leftNameTxt_.transform)

				arg_644_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_644_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_644_1:RecordName(arg_644_1.leftNameTxt_.text)
				SetActive(arg_644_1.iconTrs_.gameObject, false)
				arg_644_1.callingController_:SetSelectedState("normal")

				local var_647_3 = arg_644_1:GetWordFromCfg(1101104158)
				local var_647_4 = arg_644_1:FormatText(var_647_3.content)

				arg_644_1.text_.text = var_647_4

				LuaForUtil.ClearLinePrefixSymbol(arg_644_1.text_)

				local var_647_5 = 16
				local var_647_6 = utf8.len(var_647_4)
				local var_647_7 = var_647_5 <= 0 and var_647_1 or var_647_1 * (var_647_6 / var_647_5)

				if var_647_7 > 0 and var_647_1 < var_647_7 then
					arg_644_1.talkMaxDuration = var_647_7

					if var_647_7 + var_647_0 > arg_644_1.duration_ then
						arg_644_1.duration_ = var_647_7 + var_647_0
					end
				end

				arg_644_1.text_.text = var_647_4
				arg_644_1.typewritter.percent = 0

				arg_644_1.typewritter:SetDirty()
				arg_644_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101104", "1101104158", "story_v_side_new_1101104.awb") ~= 0 then
					local var_647_8 = manager.audio:GetVoiceLength("story_v_side_new_1101104", "1101104158", "story_v_side_new_1101104.awb") / 1000

					if var_647_8 + var_647_0 > arg_644_1.duration_ then
						arg_644_1.duration_ = var_647_8 + var_647_0
					end

					if var_647_3.prefab_name ~= "" and arg_644_1.actors_[var_647_3.prefab_name] ~= nil then
						local var_647_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_644_1.actors_[var_647_3.prefab_name].transform, "story_v_side_new_1101104", "1101104158", "story_v_side_new_1101104.awb")

						arg_644_1:RecordAudio("1101104158", var_647_9)
						arg_644_1:RecordAudio("1101104158", var_647_9)
					else
						arg_644_1:AudioAction("play", "voice", "story_v_side_new_1101104", "1101104158", "story_v_side_new_1101104.awb")
					end

					arg_644_1:RecordHistoryTalkVoice("story_v_side_new_1101104", "1101104158", "story_v_side_new_1101104.awb")
				end

				arg_644_1:RecordContent(arg_644_1.text_.text)
			end

			local var_647_10 = math.max(var_647_1, arg_644_1.talkMaxDuration)

			if var_647_0 <= arg_644_1.time_ and arg_644_1.time_ < var_647_0 + var_647_10 then
				arg_644_1.typewritter.percent = (arg_644_1.time_ - var_647_0) / var_647_10

				arg_644_1.typewritter:SetDirty()
			end

			if arg_644_1.time_ >= var_647_0 + var_647_10 and arg_644_1.time_ < var_647_0 + var_647_10 + arg_647_0 then
				arg_644_1.typewritter.percent = 1

				arg_644_1.typewritter:SetDirty()
				arg_644_1:ShowNextGo(true)
			end
		end

		arg_644_1.nodeConfigList_ = {}

		arg_644_1:InitPlayNodeList()
	end,
	Play1101104159 = function(arg_648_0, arg_648_1)
		arg_648_1.time_ = 0
		arg_648_1.frameCnt_ = 0
		arg_648_1.state_ = "playing"
		arg_648_1.curTalkId_ = 1101104159
		arg_648_1.duration_ = 8.07

		local var_648_0 = {
			zh = 7.541,
			ja = 8.075
		}
		local var_648_1 = manager.audio:GetLocalizationFlag()

		if var_648_0[var_648_1] ~= nil then
			arg_648_1.duration_ = var_648_0[var_648_1]
		end

		SetActive(arg_648_1.tipsGo_, false)

		function arg_648_1.onSingleLineFinish_()
			arg_648_1.onSingleLineUpdate_ = nil
			arg_648_1.onSingleLineFinish_ = nil
			arg_648_1.state_ = "waiting"
		end

		function arg_648_1.playNext_(arg_650_0)
			if arg_650_0 == 1 then
				arg_648_0:Play1101104160(arg_648_1)
			end
		end

		function arg_648_1.onSingleLineUpdate_(arg_651_0)
			local var_651_0 = "R1101b"

			if arg_648_1.bgs_[var_651_0] == nil then
				local var_651_1 = Object.Instantiate(arg_648_1.paintGo_)

				var_651_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_651_0)
				var_651_1.name = var_651_0
				var_651_1.transform.parent = arg_648_1.stage_.transform
				var_651_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_648_1.bgs_[var_651_0] = var_651_1
			end

			local var_651_2 = 2

			if var_651_2 < arg_648_1.time_ and arg_648_1.time_ <= var_651_2 + arg_651_0 then
				local var_651_3 = manager.ui.mainCamera.transform.localPosition
				local var_651_4 = Vector3.New(0, 0, 10) + Vector3.New(var_651_3.x, var_651_3.y, 0)
				local var_651_5 = arg_648_1.bgs_.R1101b

				var_651_5.transform.localPosition = var_651_4
				var_651_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_651_6 = var_651_5:GetComponent("SpriteRenderer")

				if var_651_6 and var_651_6.sprite then
					local var_651_7 = (var_651_5.transform.localPosition - var_651_3).z
					local var_651_8 = manager.ui.mainCameraCom_
					local var_651_9 = 2 * var_651_7 * Mathf.Tan(var_651_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_651_10 = var_651_9 * var_651_8.aspect
					local var_651_11 = var_651_6.sprite.bounds.size.x
					local var_651_12 = var_651_6.sprite.bounds.size.y
					local var_651_13 = var_651_10 / var_651_11
					local var_651_14 = var_651_9 / var_651_12
					local var_651_15 = var_651_14 < var_651_13 and var_651_13 or var_651_14

					var_651_5.transform.localScale = Vector3.New(var_651_15, var_651_15, 0)
				end

				for iter_651_0, iter_651_1 in pairs(arg_648_1.bgs_) do
					if iter_651_0 ~= "R1101b" then
						iter_651_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_651_16 = 0

			if var_651_16 < arg_648_1.time_ and arg_648_1.time_ <= var_651_16 + arg_651_0 then
				arg_648_1.mask_.enabled = true
				arg_648_1.mask_.raycastTarget = true

				arg_648_1:SetGaussion(false)
			end

			local var_651_17 = 2

			if var_651_16 <= arg_648_1.time_ and arg_648_1.time_ < var_651_16 + var_651_17 then
				local var_651_18 = (arg_648_1.time_ - var_651_16) / var_651_17
				local var_651_19 = Color.New(0, 0, 0)

				var_651_19.a = Mathf.Lerp(0, 1, var_651_18)
				arg_648_1.mask_.color = var_651_19
			end

			if arg_648_1.time_ >= var_651_16 + var_651_17 and arg_648_1.time_ < var_651_16 + var_651_17 + arg_651_0 then
				local var_651_20 = Color.New(0, 0, 0)

				var_651_20.a = 1
				arg_648_1.mask_.color = var_651_20
			end

			local var_651_21 = 2

			if var_651_21 < arg_648_1.time_ and arg_648_1.time_ <= var_651_21 + arg_651_0 then
				arg_648_1.mask_.enabled = true
				arg_648_1.mask_.raycastTarget = true

				arg_648_1:SetGaussion(false)
			end

			local var_651_22 = 2

			if var_651_21 <= arg_648_1.time_ and arg_648_1.time_ < var_651_21 + var_651_22 then
				local var_651_23 = (arg_648_1.time_ - var_651_21) / var_651_22
				local var_651_24 = Color.New(0, 0, 0)

				var_651_24.a = Mathf.Lerp(1, 0, var_651_23)
				arg_648_1.mask_.color = var_651_24
			end

			if arg_648_1.time_ >= var_651_21 + var_651_22 and arg_648_1.time_ < var_651_21 + var_651_22 + arg_651_0 then
				local var_651_25 = Color.New(0, 0, 0)
				local var_651_26 = 0

				arg_648_1.mask_.enabled = false
				var_651_25.a = var_651_26
				arg_648_1.mask_.color = var_651_25
			end

			local var_651_27 = arg_648_1.bgs_.R1101b.transform
			local var_651_28 = 2

			if var_651_28 < arg_648_1.time_ and arg_648_1.time_ <= var_651_28 + arg_651_0 then
				arg_648_1.var_.moveOldPosR1101b = var_651_27.localPosition
			end

			local var_651_29 = 0.001

			if var_651_28 <= arg_648_1.time_ and arg_648_1.time_ < var_651_28 + var_651_29 then
				local var_651_30 = (arg_648_1.time_ - var_651_28) / var_651_29
				local var_651_31 = Vector3.New(5.05, 1.53, -0.5)

				var_651_27.localPosition = Vector3.Lerp(arg_648_1.var_.moveOldPosR1101b, var_651_31, var_651_30)
			end

			if arg_648_1.time_ >= var_651_28 + var_651_29 and arg_648_1.time_ < var_651_28 + var_651_29 + arg_651_0 then
				var_651_27.localPosition = Vector3.New(5.05, 1.53, -0.5)
			end

			local var_651_32 = arg_648_1.bgs_.R1101b.transform
			local var_651_33 = 2.034

			if var_651_33 < arg_648_1.time_ and arg_648_1.time_ <= var_651_33 + arg_651_0 then
				arg_648_1.var_.moveOldPosR1101b = var_651_32.localPosition
			end

			local var_651_34 = 3

			if var_651_33 <= arg_648_1.time_ and arg_648_1.time_ < var_651_33 + var_651_34 then
				local var_651_35 = (arg_648_1.time_ - var_651_33) / var_651_34
				local var_651_36 = Vector3.New(4.78, 1.53, -0.5)

				var_651_32.localPosition = Vector3.Lerp(arg_648_1.var_.moveOldPosR1101b, var_651_36, var_651_35)
			end

			if arg_648_1.time_ >= var_651_33 + var_651_34 and arg_648_1.time_ < var_651_33 + var_651_34 + arg_651_0 then
				var_651_32.localPosition = Vector3.New(4.78, 1.53, -0.5)
			end

			if arg_648_1.frameCnt_ <= 1 then
				arg_648_1.dialog_:SetActive(false)
			end

			local var_651_37 = 3.975
			local var_651_38 = 0.225

			if var_651_37 < arg_648_1.time_ and arg_648_1.time_ <= var_651_37 + arg_651_0 then
				arg_648_1.talkMaxDuration = 0

				arg_648_1.dialog_:SetActive(true)

				arg_648_1.dialogCg_.alpha = 0

				local var_651_39 = LeanTween.value(arg_648_1.dialog_, 0, 1, 0.3)

				var_651_39:setOnUpdate(LuaHelper.FloatAction(function(arg_652_0)
					arg_648_1.dialogCg_.alpha = arg_652_0
				end))
				var_651_39:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_648_1.dialog_)
					var_651_39:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_648_1.duration_ = arg_648_1.duration_ + 0.3

				SetActive(arg_648_1.leftNameGo_, true)

				local var_651_40 = arg_648_1:FormatText(StoryNameCfg[37].name)

				arg_648_1.leftNameTxt_.text = var_651_40

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_648_1.leftNameTxt_.transform)

				arg_648_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_648_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_648_1:RecordName(arg_648_1.leftNameTxt_.text)
				SetActive(arg_648_1.iconTrs_.gameObject, false)
				arg_648_1.callingController_:SetSelectedState("normal")

				local var_651_41 = arg_648_1:GetWordFromCfg(1101104159)
				local var_651_42 = arg_648_1:FormatText(var_651_41.content)

				arg_648_1.text_.text = var_651_42

				LuaForUtil.ClearLinePrefixSymbol(arg_648_1.text_)

				local var_651_43 = 9
				local var_651_44 = utf8.len(var_651_42)
				local var_651_45 = var_651_43 <= 0 and var_651_38 or var_651_38 * (var_651_44 / var_651_43)

				if var_651_45 > 0 and var_651_38 < var_651_45 then
					arg_648_1.talkMaxDuration = var_651_45
					var_651_37 = var_651_37 + 0.3

					if var_651_45 + var_651_37 > arg_648_1.duration_ then
						arg_648_1.duration_ = var_651_45 + var_651_37
					end
				end

				arg_648_1.text_.text = var_651_42
				arg_648_1.typewritter.percent = 0

				arg_648_1.typewritter:SetDirty()
				arg_648_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101104", "1101104159", "story_v_side_new_1101104.awb") ~= 0 then
					local var_651_46 = manager.audio:GetVoiceLength("story_v_side_new_1101104", "1101104159", "story_v_side_new_1101104.awb") / 1000

					if var_651_46 + var_651_37 > arg_648_1.duration_ then
						arg_648_1.duration_ = var_651_46 + var_651_37
					end

					if var_651_41.prefab_name ~= "" and arg_648_1.actors_[var_651_41.prefab_name] ~= nil then
						local var_651_47 = LuaForUtil.PlayVoiceWithCriLipsync(arg_648_1.actors_[var_651_41.prefab_name].transform, "story_v_side_new_1101104", "1101104159", "story_v_side_new_1101104.awb")

						arg_648_1:RecordAudio("1101104159", var_651_47)
						arg_648_1:RecordAudio("1101104159", var_651_47)
					else
						arg_648_1:AudioAction("play", "voice", "story_v_side_new_1101104", "1101104159", "story_v_side_new_1101104.awb")
					end

					arg_648_1:RecordHistoryTalkVoice("story_v_side_new_1101104", "1101104159", "story_v_side_new_1101104.awb")
				end

				arg_648_1:RecordContent(arg_648_1.text_.text)
			end

			local var_651_48 = var_651_37 + 0.3
			local var_651_49 = math.max(var_651_38, arg_648_1.talkMaxDuration)

			if var_651_48 <= arg_648_1.time_ and arg_648_1.time_ < var_651_48 + var_651_49 then
				arg_648_1.typewritter.percent = (arg_648_1.time_ - var_651_48) / var_651_49

				arg_648_1.typewritter:SetDirty()
			end

			if arg_648_1.time_ >= var_651_48 + var_651_49 and arg_648_1.time_ < var_651_48 + var_651_49 + arg_651_0 then
				arg_648_1.typewritter.percent = 1

				arg_648_1.typewritter:SetDirty()
				arg_648_1:ShowNextGo(true)
			end
		end

		arg_648_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "R1101b",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "R1101b",
				changeDisplayLayer = false,
				needEase = false,
				duration = 3,
				className = "StoryMoveNode",
				startTime = 2.034,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_648_1:InitPlayNodeList()
	end,
	Play1101104160 = function(arg_654_0, arg_654_1)
		arg_654_1.time_ = 0
		arg_654_1.frameCnt_ = 0
		arg_654_1.state_ = "playing"
		arg_654_1.curTalkId_ = 1101104160
		arg_654_1.duration_ = 8.83

		local var_654_0 = {
			zh = 8.3,
			ja = 8.833
		}
		local var_654_1 = manager.audio:GetLocalizationFlag()

		if var_654_0[var_654_1] ~= nil then
			arg_654_1.duration_ = var_654_0[var_654_1]
		end

		SetActive(arg_654_1.tipsGo_, false)

		function arg_654_1.onSingleLineFinish_()
			arg_654_1.onSingleLineUpdate_ = nil
			arg_654_1.onSingleLineFinish_ = nil
			arg_654_1.state_ = "waiting"
		end

		function arg_654_1.playNext_(arg_656_0)
			if arg_656_0 == 1 then
				arg_654_0:Play1101104161(arg_654_1)
			end
		end

		function arg_654_1.onSingleLineUpdate_(arg_657_0)
			local var_657_0 = 2

			if var_657_0 < arg_654_1.time_ and arg_654_1.time_ <= var_657_0 + arg_657_0 then
				local var_657_1 = manager.ui.mainCamera.transform.localPosition
				local var_657_2 = Vector3.New(0, 0, 10) + Vector3.New(var_657_1.x, var_657_1.y, 0)
				local var_657_3 = arg_654_1.bgs_.R1101b

				var_657_3.transform.localPosition = var_657_2
				var_657_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_657_4 = var_657_3:GetComponent("SpriteRenderer")

				if var_657_4 and var_657_4.sprite then
					local var_657_5 = (var_657_3.transform.localPosition - var_657_1).z
					local var_657_6 = manager.ui.mainCameraCom_
					local var_657_7 = 2 * var_657_5 * Mathf.Tan(var_657_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_657_8 = var_657_7 * var_657_6.aspect
					local var_657_9 = var_657_4.sprite.bounds.size.x
					local var_657_10 = var_657_4.sprite.bounds.size.y
					local var_657_11 = var_657_8 / var_657_9
					local var_657_12 = var_657_7 / var_657_10
					local var_657_13 = var_657_12 < var_657_11 and var_657_11 or var_657_12

					var_657_3.transform.localScale = Vector3.New(var_657_13, var_657_13, 0)
				end

				for iter_657_0, iter_657_1 in pairs(arg_654_1.bgs_) do
					if iter_657_0 ~= "R1101b" then
						iter_657_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_657_14 = 0

			if var_657_14 < arg_654_1.time_ and arg_654_1.time_ <= var_657_14 + arg_657_0 then
				arg_654_1.mask_.enabled = true
				arg_654_1.mask_.raycastTarget = true

				arg_654_1:SetGaussion(false)
			end

			local var_657_15 = 2

			if var_657_14 <= arg_654_1.time_ and arg_654_1.time_ < var_657_14 + var_657_15 then
				local var_657_16 = (arg_654_1.time_ - var_657_14) / var_657_15
				local var_657_17 = Color.New(0, 0, 0)

				var_657_17.a = Mathf.Lerp(0, 1, var_657_16)
				arg_654_1.mask_.color = var_657_17
			end

			if arg_654_1.time_ >= var_657_14 + var_657_15 and arg_654_1.time_ < var_657_14 + var_657_15 + arg_657_0 then
				local var_657_18 = Color.New(0, 0, 0)

				var_657_18.a = 1
				arg_654_1.mask_.color = var_657_18
			end

			local var_657_19 = 2

			if var_657_19 < arg_654_1.time_ and arg_654_1.time_ <= var_657_19 + arg_657_0 then
				arg_654_1.mask_.enabled = true
				arg_654_1.mask_.raycastTarget = true

				arg_654_1:SetGaussion(false)
			end

			local var_657_20 = 2

			if var_657_19 <= arg_654_1.time_ and arg_654_1.time_ < var_657_19 + var_657_20 then
				local var_657_21 = (arg_654_1.time_ - var_657_19) / var_657_20
				local var_657_22 = Color.New(0, 0, 0)

				var_657_22.a = Mathf.Lerp(1, 0, var_657_21)
				arg_654_1.mask_.color = var_657_22
			end

			if arg_654_1.time_ >= var_657_19 + var_657_20 and arg_654_1.time_ < var_657_19 + var_657_20 + arg_657_0 then
				local var_657_23 = Color.New(0, 0, 0)
				local var_657_24 = 0

				arg_654_1.mask_.enabled = false
				var_657_23.a = var_657_24
				arg_654_1.mask_.color = var_657_23
			end

			if arg_654_1.frameCnt_ <= 1 then
				arg_654_1.dialog_:SetActive(false)
			end

			local var_657_25 = 4
			local var_657_26 = 0.425

			if var_657_25 < arg_654_1.time_ and arg_654_1.time_ <= var_657_25 + arg_657_0 then
				arg_654_1.talkMaxDuration = 0

				arg_654_1.dialog_:SetActive(true)

				arg_654_1.dialogCg_.alpha = 0

				local var_657_27 = LeanTween.value(arg_654_1.dialog_, 0, 1, 0.3)

				var_657_27:setOnUpdate(LuaHelper.FloatAction(function(arg_658_0)
					arg_654_1.dialogCg_.alpha = arg_658_0
				end))
				var_657_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_654_1.dialog_)
					var_657_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_654_1.duration_ = arg_654_1.duration_ + 0.3

				SetActive(arg_654_1.leftNameGo_, true)

				local var_657_28 = arg_654_1:FormatText(StoryNameCfg[67].name)

				arg_654_1.leftNameTxt_.text = var_657_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_654_1.leftNameTxt_.transform)

				arg_654_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_654_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_654_1:RecordName(arg_654_1.leftNameTxt_.text)
				SetActive(arg_654_1.iconTrs_.gameObject, false)
				arg_654_1.callingController_:SetSelectedState("normal")

				local var_657_29 = arg_654_1:GetWordFromCfg(1101104160)
				local var_657_30 = arg_654_1:FormatText(var_657_29.content)

				arg_654_1.text_.text = var_657_30

				LuaForUtil.ClearLinePrefixSymbol(arg_654_1.text_)

				local var_657_31 = 17
				local var_657_32 = utf8.len(var_657_30)
				local var_657_33 = var_657_31 <= 0 and var_657_26 or var_657_26 * (var_657_32 / var_657_31)

				if var_657_33 > 0 and var_657_26 < var_657_33 then
					arg_654_1.talkMaxDuration = var_657_33
					var_657_25 = var_657_25 + 0.3

					if var_657_33 + var_657_25 > arg_654_1.duration_ then
						arg_654_1.duration_ = var_657_33 + var_657_25
					end
				end

				arg_654_1.text_.text = var_657_30
				arg_654_1.typewritter.percent = 0

				arg_654_1.typewritter:SetDirty()
				arg_654_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101104", "1101104160", "story_v_side_new_1101104.awb") ~= 0 then
					local var_657_34 = manager.audio:GetVoiceLength("story_v_side_new_1101104", "1101104160", "story_v_side_new_1101104.awb") / 1000

					if var_657_34 + var_657_25 > arg_654_1.duration_ then
						arg_654_1.duration_ = var_657_34 + var_657_25
					end

					if var_657_29.prefab_name ~= "" and arg_654_1.actors_[var_657_29.prefab_name] ~= nil then
						local var_657_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_654_1.actors_[var_657_29.prefab_name].transform, "story_v_side_new_1101104", "1101104160", "story_v_side_new_1101104.awb")

						arg_654_1:RecordAudio("1101104160", var_657_35)
						arg_654_1:RecordAudio("1101104160", var_657_35)
					else
						arg_654_1:AudioAction("play", "voice", "story_v_side_new_1101104", "1101104160", "story_v_side_new_1101104.awb")
					end

					arg_654_1:RecordHistoryTalkVoice("story_v_side_new_1101104", "1101104160", "story_v_side_new_1101104.awb")
				end

				arg_654_1:RecordContent(arg_654_1.text_.text)
			end

			local var_657_36 = var_657_25 + 0.3
			local var_657_37 = math.max(var_657_26, arg_654_1.talkMaxDuration)

			if var_657_36 <= arg_654_1.time_ and arg_654_1.time_ < var_657_36 + var_657_37 then
				arg_654_1.typewritter.percent = (arg_654_1.time_ - var_657_36) / var_657_37

				arg_654_1.typewritter:SetDirty()
			end

			if arg_654_1.time_ >= var_657_36 + var_657_37 and arg_654_1.time_ < var_657_36 + var_657_37 + arg_657_0 then
				arg_654_1.typewritter.percent = 1

				arg_654_1.typewritter:SetDirty()
				arg_654_1:ShowNextGo(true)
			end
		end

		arg_654_1.nodeConfigList_ = {}

		arg_654_1:InitPlayNodeList()
	end,
	Play1101104161 = function(arg_660_0, arg_660_1)
		arg_660_1.time_ = 0
		arg_660_1.frameCnt_ = 0
		arg_660_1.state_ = "playing"
		arg_660_1.curTalkId_ = 1101104161
		arg_660_1.duration_ = 5

		SetActive(arg_660_1.tipsGo_, false)

		function arg_660_1.onSingleLineFinish_()
			arg_660_1.onSingleLineUpdate_ = nil
			arg_660_1.onSingleLineFinish_ = nil
			arg_660_1.state_ = "waiting"
		end

		function arg_660_1.playNext_(arg_662_0)
			if arg_662_0 == 1 then
				arg_660_0:Play1101104162(arg_660_1)
			end
		end

		function arg_660_1.onSingleLineUpdate_(arg_663_0)
			local var_663_0 = 0
			local var_663_1 = 0.55

			if var_663_0 < arg_660_1.time_ and arg_660_1.time_ <= var_663_0 + arg_663_0 then
				arg_660_1.talkMaxDuration = 0
				arg_660_1.dialogCg_.alpha = 1

				arg_660_1.dialog_:SetActive(true)
				SetActive(arg_660_1.leftNameGo_, false)

				arg_660_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_660_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_660_1:RecordName(arg_660_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_660_1.iconTrs_.gameObject, false)
				arg_660_1.callingController_:SetSelectedState("normal")

				local var_663_2 = arg_660_1:GetWordFromCfg(1101104161)
				local var_663_3 = arg_660_1:FormatText(var_663_2.content)

				arg_660_1.text_.text = var_663_3

				LuaForUtil.ClearLinePrefixSymbol(arg_660_1.text_)

				local var_663_4 = 22
				local var_663_5 = utf8.len(var_663_3)
				local var_663_6 = var_663_4 <= 0 and var_663_1 or var_663_1 * (var_663_5 / var_663_4)

				if var_663_6 > 0 and var_663_1 < var_663_6 then
					arg_660_1.talkMaxDuration = var_663_6

					if var_663_6 + var_663_0 > arg_660_1.duration_ then
						arg_660_1.duration_ = var_663_6 + var_663_0
					end
				end

				arg_660_1.text_.text = var_663_3
				arg_660_1.typewritter.percent = 0

				arg_660_1.typewritter:SetDirty()
				arg_660_1:ShowNextGo(false)
				arg_660_1:RecordContent(arg_660_1.text_.text)
			end

			local var_663_7 = math.max(var_663_1, arg_660_1.talkMaxDuration)

			if var_663_0 <= arg_660_1.time_ and arg_660_1.time_ < var_663_0 + var_663_7 then
				arg_660_1.typewritter.percent = (arg_660_1.time_ - var_663_0) / var_663_7

				arg_660_1.typewritter:SetDirty()
			end

			if arg_660_1.time_ >= var_663_0 + var_663_7 and arg_660_1.time_ < var_663_0 + var_663_7 + arg_663_0 then
				arg_660_1.typewritter.percent = 1

				arg_660_1.typewritter:SetDirty()
				arg_660_1:ShowNextGo(true)
			end
		end

		arg_660_1.nodeConfigList_ = {}

		arg_660_1:InitPlayNodeList()
	end,
	Play1101104162 = function(arg_664_0, arg_664_1)
		arg_664_1.time_ = 0
		arg_664_1.frameCnt_ = 0
		arg_664_1.state_ = "playing"
		arg_664_1.curTalkId_ = 1101104162
		arg_664_1.duration_ = 1

		SetActive(arg_664_1.tipsGo_, true)

		arg_664_1.tipsText_.text = StoryTipsCfg[101103].name

		function arg_664_1.onSingleLineFinish_()
			arg_664_1.onSingleLineUpdate_ = nil
			arg_664_1.onSingleLineFinish_ = nil
			arg_664_1.state_ = "waiting"

			SetActive(arg_664_1.choicesGo_, true)

			for iter_665_0, iter_665_1 in ipairs(arg_664_1.choices_) do
				local var_665_0 = iter_665_0 <= 2

				SetActive(iter_665_1.go, var_665_0)
			end

			arg_664_1.choices_[1].txt.text = arg_664_1:FormatText(StoryChoiceCfg[617].name)
			arg_664_1.choices_[2].txt.text = arg_664_1:FormatText(StoryChoiceCfg[618].name)
		end

		function arg_664_1.playNext_(arg_666_0)
			if arg_666_0 == 1 then
				PlayerAction.UseStoryTrigger(1011015, 210110104, 1101104162, 1)
				arg_664_0:Play1101104163(arg_664_1)
			end

			if arg_666_0 == 2 then
				PlayerAction.UseStoryTrigger(1011015, 210110104, 1101104162, 2)
				arg_664_0:Play1101104167(arg_664_1)
			end

			arg_664_1:RecordChoiceLog(1101104162, 617, 618)
		end

		function arg_664_1.onSingleLineUpdate_(arg_667_0)
			local var_667_0 = 0

			if var_667_0 < arg_664_1.time_ and arg_664_1.time_ <= var_667_0 + arg_667_0 then
				arg_664_1.allBtn_.enabled = false
			end

			local var_667_1 = 0.5

			if arg_664_1.time_ >= var_667_0 + var_667_1 and arg_664_1.time_ < var_667_0 + var_667_1 + arg_667_0 then
				arg_664_1.allBtn_.enabled = true
			end
		end

		arg_664_1.nodeConfigList_ = {}

		arg_664_1:InitPlayNodeList()
	end,
	Play1101104163 = function(arg_668_0, arg_668_1)
		arg_668_1.time_ = 0
		arg_668_1.frameCnt_ = 0
		arg_668_1.state_ = "playing"
		arg_668_1.curTalkId_ = 1101104163
		arg_668_1.duration_ = 5

		SetActive(arg_668_1.tipsGo_, false)

		function arg_668_1.onSingleLineFinish_()
			arg_668_1.onSingleLineUpdate_ = nil
			arg_668_1.onSingleLineFinish_ = nil
			arg_668_1.state_ = "waiting"
		end

		function arg_668_1.playNext_(arg_670_0)
			if arg_670_0 == 1 then
				arg_668_0:Play1101104164(arg_668_1)
			end
		end

		function arg_668_1.onSingleLineUpdate_(arg_671_0)
			local var_671_0 = 0

			if var_671_0 < arg_668_1.time_ and arg_668_1.time_ <= var_671_0 + arg_671_0 then
				local var_671_1 = manager.ui.mainCamera.transform.localPosition
				local var_671_2 = Vector3.New(0, 0, 10) + Vector3.New(var_671_1.x, var_671_1.y, 0)
				local var_671_3 = arg_668_1.bgs_.R1101b

				var_671_3.transform.localPosition = var_671_2
				var_671_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_671_4 = var_671_3:GetComponent("SpriteRenderer")

				if var_671_4 and var_671_4.sprite then
					local var_671_5 = (var_671_3.transform.localPosition - var_671_1).z
					local var_671_6 = manager.ui.mainCameraCom_
					local var_671_7 = 2 * var_671_5 * Mathf.Tan(var_671_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_671_8 = var_671_7 * var_671_6.aspect
					local var_671_9 = var_671_4.sprite.bounds.size.x
					local var_671_10 = var_671_4.sprite.bounds.size.y
					local var_671_11 = var_671_8 / var_671_9
					local var_671_12 = var_671_7 / var_671_10
					local var_671_13 = var_671_12 < var_671_11 and var_671_11 or var_671_12

					var_671_3.transform.localScale = Vector3.New(var_671_13, var_671_13, 0)
				end

				for iter_671_0, iter_671_1 in pairs(arg_668_1.bgs_) do
					if iter_671_0 ~= "R1101b" then
						iter_671_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_671_14 = 0
			local var_671_15 = 0.35

			if var_671_14 < arg_668_1.time_ and arg_668_1.time_ <= var_671_14 + arg_671_0 then
				arg_668_1.talkMaxDuration = 0

				arg_668_1.dialog_:SetActive(true)

				arg_668_1.dialogCg_.alpha = 0

				local var_671_16 = LeanTween.value(arg_668_1.dialog_, 0, 1, 0.3)

				var_671_16:setOnUpdate(LuaHelper.FloatAction(function(arg_672_0)
					arg_668_1.dialogCg_.alpha = arg_672_0
				end))
				var_671_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_668_1.dialog_)
					var_671_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_668_1.duration_ = arg_668_1.duration_ + 0.3

				SetActive(arg_668_1.leftNameGo_, true)

				local var_671_17 = arg_668_1:FormatText(StoryNameCfg[7].name)

				arg_668_1.leftNameTxt_.text = var_671_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_668_1.leftNameTxt_.transform)

				arg_668_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_668_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_668_1:RecordName(arg_668_1.leftNameTxt_.text)
				SetActive(arg_668_1.iconTrs_.gameObject, true)
				arg_668_1.iconController_:SetSelectedState("hero")

				arg_668_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_668_1.callingController_:SetSelectedState("normal")

				arg_668_1.keyicon_.color = Color.New(1, 1, 1)
				arg_668_1.icon_.color = Color.New(1, 1, 1)

				local var_671_18 = arg_668_1:GetWordFromCfg(1101104163)
				local var_671_19 = arg_668_1:FormatText(var_671_18.content)

				arg_668_1.text_.text = var_671_19

				LuaForUtil.ClearLinePrefixSymbol(arg_668_1.text_)

				local var_671_20 = 14
				local var_671_21 = utf8.len(var_671_19)
				local var_671_22 = var_671_20 <= 0 and var_671_15 or var_671_15 * (var_671_21 / var_671_20)

				if var_671_22 > 0 and var_671_15 < var_671_22 then
					arg_668_1.talkMaxDuration = var_671_22
					var_671_14 = var_671_14 + 0.3

					if var_671_22 + var_671_14 > arg_668_1.duration_ then
						arg_668_1.duration_ = var_671_22 + var_671_14
					end
				end

				arg_668_1.text_.text = var_671_19
				arg_668_1.typewritter.percent = 0

				arg_668_1.typewritter:SetDirty()
				arg_668_1:ShowNextGo(false)
				arg_668_1:RecordContent(arg_668_1.text_.text)
			end

			local var_671_23 = var_671_14 + 0.3
			local var_671_24 = math.max(var_671_15, arg_668_1.talkMaxDuration)

			if var_671_23 <= arg_668_1.time_ and arg_668_1.time_ < var_671_23 + var_671_24 then
				arg_668_1.typewritter.percent = (arg_668_1.time_ - var_671_23) / var_671_24

				arg_668_1.typewritter:SetDirty()
			end

			if arg_668_1.time_ >= var_671_23 + var_671_24 and arg_668_1.time_ < var_671_23 + var_671_24 + arg_671_0 then
				arg_668_1.typewritter.percent = 1

				arg_668_1.typewritter:SetDirty()
				arg_668_1:ShowNextGo(true)
			end
		end

		arg_668_1.nodeConfigList_ = {}

		arg_668_1:InitPlayNodeList()
	end,
	Play1101104164 = function(arg_674_0, arg_674_1)
		arg_674_1.time_ = 0
		arg_674_1.frameCnt_ = 0
		arg_674_1.state_ = "playing"
		arg_674_1.curTalkId_ = 1101104164
		arg_674_1.duration_ = 8.1

		local var_674_0 = {
			zh = 7.933,
			ja = 8.1
		}
		local var_674_1 = manager.audio:GetLocalizationFlag()

		if var_674_0[var_674_1] ~= nil then
			arg_674_1.duration_ = var_674_0[var_674_1]
		end

		SetActive(arg_674_1.tipsGo_, false)

		function arg_674_1.onSingleLineFinish_()
			arg_674_1.onSingleLineUpdate_ = nil
			arg_674_1.onSingleLineFinish_ = nil
			arg_674_1.state_ = "waiting"
		end

		function arg_674_1.playNext_(arg_676_0)
			if arg_676_0 == 1 then
				arg_674_0:Play1101104165(arg_674_1)
			end
		end

		function arg_674_1.onSingleLineUpdate_(arg_677_0)
			local var_677_0 = 0
			local var_677_1 = 0.8

			if var_677_0 < arg_674_1.time_ and arg_674_1.time_ <= var_677_0 + arg_677_0 then
				arg_674_1.talkMaxDuration = 0
				arg_674_1.dialogCg_.alpha = 1

				arg_674_1.dialog_:SetActive(true)
				SetActive(arg_674_1.leftNameGo_, true)

				local var_677_2 = arg_674_1:FormatText(StoryNameCfg[67].name)

				arg_674_1.leftNameTxt_.text = var_677_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_674_1.leftNameTxt_.transform)

				arg_674_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_674_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_674_1:RecordName(arg_674_1.leftNameTxt_.text)
				SetActive(arg_674_1.iconTrs_.gameObject, false)
				arg_674_1.callingController_:SetSelectedState("normal")

				local var_677_3 = arg_674_1:GetWordFromCfg(1101104164)
				local var_677_4 = arg_674_1:FormatText(var_677_3.content)

				arg_674_1.text_.text = var_677_4

				LuaForUtil.ClearLinePrefixSymbol(arg_674_1.text_)

				local var_677_5 = 32
				local var_677_6 = utf8.len(var_677_4)
				local var_677_7 = var_677_5 <= 0 and var_677_1 or var_677_1 * (var_677_6 / var_677_5)

				if var_677_7 > 0 and var_677_1 < var_677_7 then
					arg_674_1.talkMaxDuration = var_677_7

					if var_677_7 + var_677_0 > arg_674_1.duration_ then
						arg_674_1.duration_ = var_677_7 + var_677_0
					end
				end

				arg_674_1.text_.text = var_677_4
				arg_674_1.typewritter.percent = 0

				arg_674_1.typewritter:SetDirty()
				arg_674_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101104", "1101104164", "story_v_side_new_1101104.awb") ~= 0 then
					local var_677_8 = manager.audio:GetVoiceLength("story_v_side_new_1101104", "1101104164", "story_v_side_new_1101104.awb") / 1000

					if var_677_8 + var_677_0 > arg_674_1.duration_ then
						arg_674_1.duration_ = var_677_8 + var_677_0
					end

					if var_677_3.prefab_name ~= "" and arg_674_1.actors_[var_677_3.prefab_name] ~= nil then
						local var_677_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_674_1.actors_[var_677_3.prefab_name].transform, "story_v_side_new_1101104", "1101104164", "story_v_side_new_1101104.awb")

						arg_674_1:RecordAudio("1101104164", var_677_9)
						arg_674_1:RecordAudio("1101104164", var_677_9)
					else
						arg_674_1:AudioAction("play", "voice", "story_v_side_new_1101104", "1101104164", "story_v_side_new_1101104.awb")
					end

					arg_674_1:RecordHistoryTalkVoice("story_v_side_new_1101104", "1101104164", "story_v_side_new_1101104.awb")
				end

				arg_674_1:RecordContent(arg_674_1.text_.text)
			end

			local var_677_10 = math.max(var_677_1, arg_674_1.talkMaxDuration)

			if var_677_0 <= arg_674_1.time_ and arg_674_1.time_ < var_677_0 + var_677_10 then
				arg_674_1.typewritter.percent = (arg_674_1.time_ - var_677_0) / var_677_10

				arg_674_1.typewritter:SetDirty()
			end

			if arg_674_1.time_ >= var_677_0 + var_677_10 and arg_674_1.time_ < var_677_0 + var_677_10 + arg_677_0 then
				arg_674_1.typewritter.percent = 1

				arg_674_1.typewritter:SetDirty()
				arg_674_1:ShowNextGo(true)
			end
		end

		arg_674_1.nodeConfigList_ = {}

		arg_674_1:InitPlayNodeList()
	end,
	Play1101104165 = function(arg_678_0, arg_678_1)
		arg_678_1.time_ = 0
		arg_678_1.frameCnt_ = 0
		arg_678_1.state_ = "playing"
		arg_678_1.curTalkId_ = 1101104165
		arg_678_1.duration_ = 5

		SetActive(arg_678_1.tipsGo_, false)

		function arg_678_1.onSingleLineFinish_()
			arg_678_1.onSingleLineUpdate_ = nil
			arg_678_1.onSingleLineFinish_ = nil
			arg_678_1.state_ = "waiting"
		end

		function arg_678_1.playNext_(arg_680_0)
			if arg_680_0 == 1 then
				arg_678_0:Play1101104166(arg_678_1)
			end
		end

		function arg_678_1.onSingleLineUpdate_(arg_681_0)
			local var_681_0 = 0
			local var_681_1 = 0.75

			if var_681_0 < arg_678_1.time_ and arg_678_1.time_ <= var_681_0 + arg_681_0 then
				arg_678_1.talkMaxDuration = 0
				arg_678_1.dialogCg_.alpha = 1

				arg_678_1.dialog_:SetActive(true)
				SetActive(arg_678_1.leftNameGo_, true)

				local var_681_2 = arg_678_1:FormatText(StoryNameCfg[7].name)

				arg_678_1.leftNameTxt_.text = var_681_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_678_1.leftNameTxt_.transform)

				arg_678_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_678_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_678_1:RecordName(arg_678_1.leftNameTxt_.text)
				SetActive(arg_678_1.iconTrs_.gameObject, true)
				arg_678_1.iconController_:SetSelectedState("hero")

				arg_678_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_678_1.callingController_:SetSelectedState("normal")

				arg_678_1.keyicon_.color = Color.New(1, 1, 1)
				arg_678_1.icon_.color = Color.New(1, 1, 1)

				local var_681_3 = arg_678_1:GetWordFromCfg(1101104165)
				local var_681_4 = arg_678_1:FormatText(var_681_3.content)

				arg_678_1.text_.text = var_681_4

				LuaForUtil.ClearLinePrefixSymbol(arg_678_1.text_)

				local var_681_5 = 30
				local var_681_6 = utf8.len(var_681_4)
				local var_681_7 = var_681_5 <= 0 and var_681_1 or var_681_1 * (var_681_6 / var_681_5)

				if var_681_7 > 0 and var_681_1 < var_681_7 then
					arg_678_1.talkMaxDuration = var_681_7

					if var_681_7 + var_681_0 > arg_678_1.duration_ then
						arg_678_1.duration_ = var_681_7 + var_681_0
					end
				end

				arg_678_1.text_.text = var_681_4
				arg_678_1.typewritter.percent = 0

				arg_678_1.typewritter:SetDirty()
				arg_678_1:ShowNextGo(false)
				arg_678_1:RecordContent(arg_678_1.text_.text)
			end

			local var_681_8 = math.max(var_681_1, arg_678_1.talkMaxDuration)

			if var_681_0 <= arg_678_1.time_ and arg_678_1.time_ < var_681_0 + var_681_8 then
				arg_678_1.typewritter.percent = (arg_678_1.time_ - var_681_0) / var_681_8

				arg_678_1.typewritter:SetDirty()
			end

			if arg_678_1.time_ >= var_681_0 + var_681_8 and arg_678_1.time_ < var_681_0 + var_681_8 + arg_681_0 then
				arg_678_1.typewritter.percent = 1

				arg_678_1.typewritter:SetDirty()
				arg_678_1:ShowNextGo(true)
			end
		end

		arg_678_1.nodeConfigList_ = {}

		arg_678_1:InitPlayNodeList()
	end,
	Play1101104166 = function(arg_682_0, arg_682_1)
		arg_682_1.time_ = 0
		arg_682_1.frameCnt_ = 0
		arg_682_1.state_ = "playing"
		arg_682_1.curTalkId_ = 1101104166
		arg_682_1.duration_ = 1.63

		local var_682_0 = {
			zh = 1.233,
			ja = 1.633
		}
		local var_682_1 = manager.audio:GetLocalizationFlag()

		if var_682_0[var_682_1] ~= nil then
			arg_682_1.duration_ = var_682_0[var_682_1]
		end

		SetActive(arg_682_1.tipsGo_, false)

		function arg_682_1.onSingleLineFinish_()
			arg_682_1.onSingleLineUpdate_ = nil
			arg_682_1.onSingleLineFinish_ = nil
			arg_682_1.state_ = "waiting"
		end

		function arg_682_1.playNext_(arg_684_0)
			if arg_684_0 == 1 then
				arg_682_0:Play1101104171(arg_682_1)
			end
		end

		function arg_682_1.onSingleLineUpdate_(arg_685_0)
			local var_685_0 = 0
			local var_685_1 = 0.075

			if var_685_0 < arg_682_1.time_ and arg_682_1.time_ <= var_685_0 + arg_685_0 then
				arg_682_1.talkMaxDuration = 0
				arg_682_1.dialogCg_.alpha = 1

				arg_682_1.dialog_:SetActive(true)
				SetActive(arg_682_1.leftNameGo_, true)

				local var_685_2 = arg_682_1:FormatText(StoryNameCfg[37].name)

				arg_682_1.leftNameTxt_.text = var_685_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_682_1.leftNameTxt_.transform)

				arg_682_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_682_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_682_1:RecordName(arg_682_1.leftNameTxt_.text)
				SetActive(arg_682_1.iconTrs_.gameObject, false)
				arg_682_1.callingController_:SetSelectedState("normal")

				local var_685_3 = arg_682_1:GetWordFromCfg(1101104166)
				local var_685_4 = arg_682_1:FormatText(var_685_3.content)

				arg_682_1.text_.text = var_685_4

				LuaForUtil.ClearLinePrefixSymbol(arg_682_1.text_)

				local var_685_5 = 3
				local var_685_6 = utf8.len(var_685_4)
				local var_685_7 = var_685_5 <= 0 and var_685_1 or var_685_1 * (var_685_6 / var_685_5)

				if var_685_7 > 0 and var_685_1 < var_685_7 then
					arg_682_1.talkMaxDuration = var_685_7

					if var_685_7 + var_685_0 > arg_682_1.duration_ then
						arg_682_1.duration_ = var_685_7 + var_685_0
					end
				end

				arg_682_1.text_.text = var_685_4
				arg_682_1.typewritter.percent = 0

				arg_682_1.typewritter:SetDirty()
				arg_682_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101104", "1101104166", "story_v_side_new_1101104.awb") ~= 0 then
					local var_685_8 = manager.audio:GetVoiceLength("story_v_side_new_1101104", "1101104166", "story_v_side_new_1101104.awb") / 1000

					if var_685_8 + var_685_0 > arg_682_1.duration_ then
						arg_682_1.duration_ = var_685_8 + var_685_0
					end

					if var_685_3.prefab_name ~= "" and arg_682_1.actors_[var_685_3.prefab_name] ~= nil then
						local var_685_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_682_1.actors_[var_685_3.prefab_name].transform, "story_v_side_new_1101104", "1101104166", "story_v_side_new_1101104.awb")

						arg_682_1:RecordAudio("1101104166", var_685_9)
						arg_682_1:RecordAudio("1101104166", var_685_9)
					else
						arg_682_1:AudioAction("play", "voice", "story_v_side_new_1101104", "1101104166", "story_v_side_new_1101104.awb")
					end

					arg_682_1:RecordHistoryTalkVoice("story_v_side_new_1101104", "1101104166", "story_v_side_new_1101104.awb")
				end

				arg_682_1:RecordContent(arg_682_1.text_.text)
			end

			local var_685_10 = math.max(var_685_1, arg_682_1.talkMaxDuration)

			if var_685_0 <= arg_682_1.time_ and arg_682_1.time_ < var_685_0 + var_685_10 then
				arg_682_1.typewritter.percent = (arg_682_1.time_ - var_685_0) / var_685_10

				arg_682_1.typewritter:SetDirty()
			end

			if arg_682_1.time_ >= var_685_0 + var_685_10 and arg_682_1.time_ < var_685_0 + var_685_10 + arg_685_0 then
				arg_682_1.typewritter.percent = 1

				arg_682_1.typewritter:SetDirty()
				arg_682_1:ShowNextGo(true)
			end
		end

		arg_682_1.nodeConfigList_ = {}

		arg_682_1:InitPlayNodeList()
	end,
	Play1101104171 = function(arg_686_0, arg_686_1)
		arg_686_1.time_ = 0
		arg_686_1.frameCnt_ = 0
		arg_686_1.state_ = "playing"
		arg_686_1.curTalkId_ = 1101104171
		arg_686_1.duration_ = 8.57

		local var_686_0 = {
			zh = 7.766,
			ja = 8.566
		}
		local var_686_1 = manager.audio:GetLocalizationFlag()

		if var_686_0[var_686_1] ~= nil then
			arg_686_1.duration_ = var_686_0[var_686_1]
		end

		SetActive(arg_686_1.tipsGo_, false)

		function arg_686_1.onSingleLineFinish_()
			arg_686_1.onSingleLineUpdate_ = nil
			arg_686_1.onSingleLineFinish_ = nil
			arg_686_1.state_ = "waiting"
		end

		function arg_686_1.playNext_(arg_688_0)
			if arg_688_0 == 1 then
				arg_686_0:Play1101104172(arg_686_1)
			end
		end

		function arg_686_1.onSingleLineUpdate_(arg_689_0)
			local var_689_0 = 2

			if var_689_0 < arg_686_1.time_ and arg_686_1.time_ <= var_689_0 + arg_689_0 then
				local var_689_1 = manager.ui.mainCamera.transform.localPosition
				local var_689_2 = Vector3.New(0, 0, 10) + Vector3.New(var_689_1.x, var_689_1.y, 0)
				local var_689_3 = arg_686_1.bgs_.R1101

				var_689_3.transform.localPosition = var_689_2
				var_689_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_689_4 = var_689_3:GetComponent("SpriteRenderer")

				if var_689_4 and var_689_4.sprite then
					local var_689_5 = (var_689_3.transform.localPosition - var_689_1).z
					local var_689_6 = manager.ui.mainCameraCom_
					local var_689_7 = 2 * var_689_5 * Mathf.Tan(var_689_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_689_8 = var_689_7 * var_689_6.aspect
					local var_689_9 = var_689_4.sprite.bounds.size.x
					local var_689_10 = var_689_4.sprite.bounds.size.y
					local var_689_11 = var_689_8 / var_689_9
					local var_689_12 = var_689_7 / var_689_10
					local var_689_13 = var_689_12 < var_689_11 and var_689_11 or var_689_12

					var_689_3.transform.localScale = Vector3.New(var_689_13, var_689_13, 0)
				end

				for iter_689_0, iter_689_1 in pairs(arg_686_1.bgs_) do
					if iter_689_0 ~= "R1101" then
						iter_689_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_689_14 = 0

			if var_689_14 < arg_686_1.time_ and arg_686_1.time_ <= var_689_14 + arg_689_0 then
				arg_686_1.mask_.enabled = true
				arg_686_1.mask_.raycastTarget = true

				arg_686_1:SetGaussion(false)
			end

			local var_689_15 = 2

			if var_689_14 <= arg_686_1.time_ and arg_686_1.time_ < var_689_14 + var_689_15 then
				local var_689_16 = (arg_686_1.time_ - var_689_14) / var_689_15
				local var_689_17 = Color.New(0, 0, 0)

				var_689_17.a = Mathf.Lerp(0, 1, var_689_16)
				arg_686_1.mask_.color = var_689_17
			end

			if arg_686_1.time_ >= var_689_14 + var_689_15 and arg_686_1.time_ < var_689_14 + var_689_15 + arg_689_0 then
				local var_689_18 = Color.New(0, 0, 0)

				var_689_18.a = 1
				arg_686_1.mask_.color = var_689_18
			end

			local var_689_19 = 2

			if var_689_19 < arg_686_1.time_ and arg_686_1.time_ <= var_689_19 + arg_689_0 then
				arg_686_1.mask_.enabled = true
				arg_686_1.mask_.raycastTarget = true

				arg_686_1:SetGaussion(false)
			end

			local var_689_20 = 2

			if var_689_19 <= arg_686_1.time_ and arg_686_1.time_ < var_689_19 + var_689_20 then
				local var_689_21 = (arg_686_1.time_ - var_689_19) / var_689_20
				local var_689_22 = Color.New(0, 0, 0)

				var_689_22.a = Mathf.Lerp(1, 0, var_689_21)
				arg_686_1.mask_.color = var_689_22
			end

			if arg_686_1.time_ >= var_689_19 + var_689_20 and arg_686_1.time_ < var_689_19 + var_689_20 + arg_689_0 then
				local var_689_23 = Color.New(0, 0, 0)
				local var_689_24 = 0

				arg_686_1.mask_.enabled = false
				var_689_23.a = var_689_24
				arg_686_1.mask_.color = var_689_23
			end

			if arg_686_1.frameCnt_ <= 1 then
				arg_686_1.dialog_:SetActive(false)
			end

			local var_689_25 = 4
			local var_689_26 = 0.35

			if var_689_25 < arg_686_1.time_ and arg_686_1.time_ <= var_689_25 + arg_689_0 then
				arg_686_1.talkMaxDuration = 0

				arg_686_1.dialog_:SetActive(true)

				arg_686_1.dialogCg_.alpha = 0

				local var_689_27 = LeanTween.value(arg_686_1.dialog_, 0, 1, 0.3)

				var_689_27:setOnUpdate(LuaHelper.FloatAction(function(arg_690_0)
					arg_686_1.dialogCg_.alpha = arg_690_0
				end))
				var_689_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_686_1.dialog_)
					var_689_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_686_1.duration_ = arg_686_1.duration_ + 0.3

				SetActive(arg_686_1.leftNameGo_, true)

				local var_689_28 = arg_686_1:FormatText(StoryNameCfg[67].name)

				arg_686_1.leftNameTxt_.text = var_689_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_686_1.leftNameTxt_.transform)

				arg_686_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_686_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_686_1:RecordName(arg_686_1.leftNameTxt_.text)
				SetActive(arg_686_1.iconTrs_.gameObject, false)
				arg_686_1.callingController_:SetSelectedState("normal")

				local var_689_29 = arg_686_1:GetWordFromCfg(1101104171)
				local var_689_30 = arg_686_1:FormatText(var_689_29.content)

				arg_686_1.text_.text = var_689_30

				LuaForUtil.ClearLinePrefixSymbol(arg_686_1.text_)

				local var_689_31 = 13
				local var_689_32 = utf8.len(var_689_30)
				local var_689_33 = var_689_31 <= 0 and var_689_26 or var_689_26 * (var_689_32 / var_689_31)

				if var_689_33 > 0 and var_689_26 < var_689_33 then
					arg_686_1.talkMaxDuration = var_689_33
					var_689_25 = var_689_25 + 0.3

					if var_689_33 + var_689_25 > arg_686_1.duration_ then
						arg_686_1.duration_ = var_689_33 + var_689_25
					end
				end

				arg_686_1.text_.text = var_689_30
				arg_686_1.typewritter.percent = 0

				arg_686_1.typewritter:SetDirty()
				arg_686_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101104", "1101104171", "story_v_side_new_1101104.awb") ~= 0 then
					local var_689_34 = manager.audio:GetVoiceLength("story_v_side_new_1101104", "1101104171", "story_v_side_new_1101104.awb") / 1000

					if var_689_34 + var_689_25 > arg_686_1.duration_ then
						arg_686_1.duration_ = var_689_34 + var_689_25
					end

					if var_689_29.prefab_name ~= "" and arg_686_1.actors_[var_689_29.prefab_name] ~= nil then
						local var_689_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_686_1.actors_[var_689_29.prefab_name].transform, "story_v_side_new_1101104", "1101104171", "story_v_side_new_1101104.awb")

						arg_686_1:RecordAudio("1101104171", var_689_35)
						arg_686_1:RecordAudio("1101104171", var_689_35)
					else
						arg_686_1:AudioAction("play", "voice", "story_v_side_new_1101104", "1101104171", "story_v_side_new_1101104.awb")
					end

					arg_686_1:RecordHistoryTalkVoice("story_v_side_new_1101104", "1101104171", "story_v_side_new_1101104.awb")
				end

				arg_686_1:RecordContent(arg_686_1.text_.text)
			end

			local var_689_36 = var_689_25 + 0.3
			local var_689_37 = math.max(var_689_26, arg_686_1.talkMaxDuration)

			if var_689_36 <= arg_686_1.time_ and arg_686_1.time_ < var_689_36 + var_689_37 then
				arg_686_1.typewritter.percent = (arg_686_1.time_ - var_689_36) / var_689_37

				arg_686_1.typewritter:SetDirty()
			end

			if arg_686_1.time_ >= var_689_36 + var_689_37 and arg_686_1.time_ < var_689_36 + var_689_37 + arg_689_0 then
				arg_686_1.typewritter.percent = 1

				arg_686_1.typewritter:SetDirty()
				arg_686_1:ShowNextGo(true)
			end
		end

		arg_686_1.nodeConfigList_ = {}

		arg_686_1:InitPlayNodeList()
	end,
	Play1101104172 = function(arg_692_0, arg_692_1)
		arg_692_1.time_ = 0
		arg_692_1.frameCnt_ = 0
		arg_692_1.state_ = "playing"
		arg_692_1.curTalkId_ = 1101104172
		arg_692_1.duration_ = 3.87

		local var_692_0 = {
			zh = 1.9,
			ja = 3.866
		}
		local var_692_1 = manager.audio:GetLocalizationFlag()

		if var_692_0[var_692_1] ~= nil then
			arg_692_1.duration_ = var_692_0[var_692_1]
		end

		SetActive(arg_692_1.tipsGo_, false)

		function arg_692_1.onSingleLineFinish_()
			arg_692_1.onSingleLineUpdate_ = nil
			arg_692_1.onSingleLineFinish_ = nil
			arg_692_1.state_ = "waiting"
		end

		function arg_692_1.playNext_(arg_694_0)
			if arg_694_0 == 1 then
				arg_692_0:Play1101104173(arg_692_1)
			end
		end

		function arg_692_1.onSingleLineUpdate_(arg_695_0)
			local var_695_0 = 0
			local var_695_1 = 0.15

			if var_695_0 < arg_692_1.time_ and arg_692_1.time_ <= var_695_0 + arg_695_0 then
				arg_692_1.talkMaxDuration = 0
				arg_692_1.dialogCg_.alpha = 1

				arg_692_1.dialog_:SetActive(true)
				SetActive(arg_692_1.leftNameGo_, true)

				local var_695_2 = arg_692_1:FormatText(StoryNameCfg[37].name)

				arg_692_1.leftNameTxt_.text = var_695_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_692_1.leftNameTxt_.transform)

				arg_692_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_692_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_692_1:RecordName(arg_692_1.leftNameTxt_.text)
				SetActive(arg_692_1.iconTrs_.gameObject, false)
				arg_692_1.callingController_:SetSelectedState("normal")

				local var_695_3 = arg_692_1:GetWordFromCfg(1101104172)
				local var_695_4 = arg_692_1:FormatText(var_695_3.content)

				arg_692_1.text_.text = var_695_4

				LuaForUtil.ClearLinePrefixSymbol(arg_692_1.text_)

				local var_695_5 = 6
				local var_695_6 = utf8.len(var_695_4)
				local var_695_7 = var_695_5 <= 0 and var_695_1 or var_695_1 * (var_695_6 / var_695_5)

				if var_695_7 > 0 and var_695_1 < var_695_7 then
					arg_692_1.talkMaxDuration = var_695_7

					if var_695_7 + var_695_0 > arg_692_1.duration_ then
						arg_692_1.duration_ = var_695_7 + var_695_0
					end
				end

				arg_692_1.text_.text = var_695_4
				arg_692_1.typewritter.percent = 0

				arg_692_1.typewritter:SetDirty()
				arg_692_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101104", "1101104172", "story_v_side_new_1101104.awb") ~= 0 then
					local var_695_8 = manager.audio:GetVoiceLength("story_v_side_new_1101104", "1101104172", "story_v_side_new_1101104.awb") / 1000

					if var_695_8 + var_695_0 > arg_692_1.duration_ then
						arg_692_1.duration_ = var_695_8 + var_695_0
					end

					if var_695_3.prefab_name ~= "" and arg_692_1.actors_[var_695_3.prefab_name] ~= nil then
						local var_695_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_692_1.actors_[var_695_3.prefab_name].transform, "story_v_side_new_1101104", "1101104172", "story_v_side_new_1101104.awb")

						arg_692_1:RecordAudio("1101104172", var_695_9)
						arg_692_1:RecordAudio("1101104172", var_695_9)
					else
						arg_692_1:AudioAction("play", "voice", "story_v_side_new_1101104", "1101104172", "story_v_side_new_1101104.awb")
					end

					arg_692_1:RecordHistoryTalkVoice("story_v_side_new_1101104", "1101104172", "story_v_side_new_1101104.awb")
				end

				arg_692_1:RecordContent(arg_692_1.text_.text)
			end

			local var_695_10 = math.max(var_695_1, arg_692_1.talkMaxDuration)

			if var_695_0 <= arg_692_1.time_ and arg_692_1.time_ < var_695_0 + var_695_10 then
				arg_692_1.typewritter.percent = (arg_692_1.time_ - var_695_0) / var_695_10

				arg_692_1.typewritter:SetDirty()
			end

			if arg_692_1.time_ >= var_695_0 + var_695_10 and arg_692_1.time_ < var_695_0 + var_695_10 + arg_695_0 then
				arg_692_1.typewritter.percent = 1

				arg_692_1.typewritter:SetDirty()
				arg_692_1:ShowNextGo(true)
			end
		end

		arg_692_1.nodeConfigList_ = {}

		arg_692_1:InitPlayNodeList()
	end,
	Play1101104173 = function(arg_696_0, arg_696_1)
		arg_696_1.time_ = 0
		arg_696_1.frameCnt_ = 0
		arg_696_1.state_ = "playing"
		arg_696_1.curTalkId_ = 1101104173
		arg_696_1.duration_ = 5

		SetActive(arg_696_1.tipsGo_, false)

		function arg_696_1.onSingleLineFinish_()
			arg_696_1.onSingleLineUpdate_ = nil
			arg_696_1.onSingleLineFinish_ = nil
			arg_696_1.state_ = "waiting"
		end

		function arg_696_1.playNext_(arg_698_0)
			if arg_698_0 == 1 then
				arg_696_0:Play1101104174(arg_696_1)
			end
		end

		function arg_696_1.onSingleLineUpdate_(arg_699_0)
			local var_699_0 = 0
			local var_699_1 = 0.975

			if var_699_0 < arg_696_1.time_ and arg_696_1.time_ <= var_699_0 + arg_699_0 then
				arg_696_1.talkMaxDuration = 0
				arg_696_1.dialogCg_.alpha = 1

				arg_696_1.dialog_:SetActive(true)
				SetActive(arg_696_1.leftNameGo_, true)

				local var_699_2 = arg_696_1:FormatText(StoryNameCfg[7].name)

				arg_696_1.leftNameTxt_.text = var_699_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_696_1.leftNameTxt_.transform)

				arg_696_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_696_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_696_1:RecordName(arg_696_1.leftNameTxt_.text)
				SetActive(arg_696_1.iconTrs_.gameObject, true)
				arg_696_1.iconController_:SetSelectedState("hero")

				arg_696_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_696_1.callingController_:SetSelectedState("normal")

				arg_696_1.keyicon_.color = Color.New(1, 1, 1)
				arg_696_1.icon_.color = Color.New(1, 1, 1)

				local var_699_3 = arg_696_1:GetWordFromCfg(1101104173)
				local var_699_4 = arg_696_1:FormatText(var_699_3.content)

				arg_696_1.text_.text = var_699_4

				LuaForUtil.ClearLinePrefixSymbol(arg_696_1.text_)

				local var_699_5 = 39
				local var_699_6 = utf8.len(var_699_4)
				local var_699_7 = var_699_5 <= 0 and var_699_1 or var_699_1 * (var_699_6 / var_699_5)

				if var_699_7 > 0 and var_699_1 < var_699_7 then
					arg_696_1.talkMaxDuration = var_699_7

					if var_699_7 + var_699_0 > arg_696_1.duration_ then
						arg_696_1.duration_ = var_699_7 + var_699_0
					end
				end

				arg_696_1.text_.text = var_699_4
				arg_696_1.typewritter.percent = 0

				arg_696_1.typewritter:SetDirty()
				arg_696_1:ShowNextGo(false)
				arg_696_1:RecordContent(arg_696_1.text_.text)
			end

			local var_699_8 = math.max(var_699_1, arg_696_1.talkMaxDuration)

			if var_699_0 <= arg_696_1.time_ and arg_696_1.time_ < var_699_0 + var_699_8 then
				arg_696_1.typewritter.percent = (arg_696_1.time_ - var_699_0) / var_699_8

				arg_696_1.typewritter:SetDirty()
			end

			if arg_696_1.time_ >= var_699_0 + var_699_8 and arg_696_1.time_ < var_699_0 + var_699_8 + arg_699_0 then
				arg_696_1.typewritter.percent = 1

				arg_696_1.typewritter:SetDirty()
				arg_696_1:ShowNextGo(true)
			end
		end

		arg_696_1.nodeConfigList_ = {}

		arg_696_1:InitPlayNodeList()
	end,
	Play1101104174 = function(arg_700_0, arg_700_1)
		arg_700_1.time_ = 0
		arg_700_1.frameCnt_ = 0
		arg_700_1.state_ = "playing"
		arg_700_1.curTalkId_ = 1101104174
		arg_700_1.duration_ = 5

		SetActive(arg_700_1.tipsGo_, false)

		function arg_700_1.onSingleLineFinish_()
			arg_700_1.onSingleLineUpdate_ = nil
			arg_700_1.onSingleLineFinish_ = nil
			arg_700_1.state_ = "waiting"
		end

		function arg_700_1.playNext_(arg_702_0)
			if arg_702_0 == 1 then
				arg_700_0:Play1101104175(arg_700_1)
			end
		end

		function arg_700_1.onSingleLineUpdate_(arg_703_0)
			local var_703_0 = 0
			local var_703_1 = 0.05

			if var_703_0 < arg_700_1.time_ and arg_700_1.time_ <= var_703_0 + arg_703_0 then
				arg_700_1.talkMaxDuration = 0
				arg_700_1.dialogCg_.alpha = 1

				arg_700_1.dialog_:SetActive(true)
				SetActive(arg_700_1.leftNameGo_, false)

				arg_700_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_700_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_700_1:RecordName(arg_700_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_700_1.iconTrs_.gameObject, false)
				arg_700_1.callingController_:SetSelectedState("normal")

				local var_703_2 = arg_700_1:GetWordFromCfg(1101104174)
				local var_703_3 = arg_700_1:FormatText(var_703_2.content)

				arg_700_1.text_.text = var_703_3

				LuaForUtil.ClearLinePrefixSymbol(arg_700_1.text_)

				local var_703_4 = 2
				local var_703_5 = utf8.len(var_703_3)
				local var_703_6 = var_703_4 <= 0 and var_703_1 or var_703_1 * (var_703_5 / var_703_4)

				if var_703_6 > 0 and var_703_1 < var_703_6 then
					arg_700_1.talkMaxDuration = var_703_6

					if var_703_6 + var_703_0 > arg_700_1.duration_ then
						arg_700_1.duration_ = var_703_6 + var_703_0
					end
				end

				arg_700_1.text_.text = var_703_3
				arg_700_1.typewritter.percent = 0

				arg_700_1.typewritter:SetDirty()
				arg_700_1:ShowNextGo(false)
				arg_700_1:RecordContent(arg_700_1.text_.text)
			end

			local var_703_7 = math.max(var_703_1, arg_700_1.talkMaxDuration)

			if var_703_0 <= arg_700_1.time_ and arg_700_1.time_ < var_703_0 + var_703_7 then
				arg_700_1.typewritter.percent = (arg_700_1.time_ - var_703_0) / var_703_7

				arg_700_1.typewritter:SetDirty()
			end

			if arg_700_1.time_ >= var_703_0 + var_703_7 and arg_700_1.time_ < var_703_0 + var_703_7 + arg_703_0 then
				arg_700_1.typewritter.percent = 1

				arg_700_1.typewritter:SetDirty()
				arg_700_1:ShowNextGo(true)
			end
		end

		arg_700_1.nodeConfigList_ = {}

		arg_700_1:InitPlayNodeList()
	end,
	Play1101104175 = function(arg_704_0, arg_704_1)
		arg_704_1.time_ = 0
		arg_704_1.frameCnt_ = 0
		arg_704_1.state_ = "playing"
		arg_704_1.curTalkId_ = 1101104175
		arg_704_1.duration_ = 5

		SetActive(arg_704_1.tipsGo_, false)

		function arg_704_1.onSingleLineFinish_()
			arg_704_1.onSingleLineUpdate_ = nil
			arg_704_1.onSingleLineFinish_ = nil
			arg_704_1.state_ = "waiting"
			arg_704_1.auto_ = false
		end

		function arg_704_1.playNext_(arg_706_0)
			arg_704_1.onStoryFinished_()
		end

		function arg_704_1.onSingleLineUpdate_(arg_707_0)
			local var_707_0 = 0
			local var_707_1 = 0.7

			if var_707_0 < arg_704_1.time_ and arg_704_1.time_ <= var_707_0 + arg_707_0 then
				arg_704_1.talkMaxDuration = 0
				arg_704_1.dialogCg_.alpha = 1

				arg_704_1.dialog_:SetActive(true)
				SetActive(arg_704_1.leftNameGo_, false)

				arg_704_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_704_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_704_1:RecordName(arg_704_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_704_1.iconTrs_.gameObject, false)
				arg_704_1.callingController_:SetSelectedState("normal")

				local var_707_2 = arg_704_1:GetWordFromCfg(1101104175)
				local var_707_3 = arg_704_1:FormatText(var_707_2.content)

				arg_704_1.text_.text = var_707_3

				LuaForUtil.ClearLinePrefixSymbol(arg_704_1.text_)

				local var_707_4 = 28
				local var_707_5 = utf8.len(var_707_3)
				local var_707_6 = var_707_4 <= 0 and var_707_1 or var_707_1 * (var_707_5 / var_707_4)

				if var_707_6 > 0 and var_707_1 < var_707_6 then
					arg_704_1.talkMaxDuration = var_707_6

					if var_707_6 + var_707_0 > arg_704_1.duration_ then
						arg_704_1.duration_ = var_707_6 + var_707_0
					end
				end

				arg_704_1.text_.text = var_707_3
				arg_704_1.typewritter.percent = 0

				arg_704_1.typewritter:SetDirty()
				arg_704_1:ShowNextGo(false)
				arg_704_1:RecordContent(arg_704_1.text_.text)
			end

			local var_707_7 = math.max(var_707_1, arg_704_1.talkMaxDuration)

			if var_707_0 <= arg_704_1.time_ and arg_704_1.time_ < var_707_0 + var_707_7 then
				arg_704_1.typewritter.percent = (arg_704_1.time_ - var_707_0) / var_707_7

				arg_704_1.typewritter:SetDirty()
			end

			if arg_704_1.time_ >= var_707_0 + var_707_7 and arg_704_1.time_ < var_707_0 + var_707_7 + arg_707_0 then
				arg_704_1.typewritter.percent = 1

				arg_704_1.typewritter:SetDirty()
				arg_704_1:ShowNextGo(true)
			end
		end

		arg_704_1.nodeConfigList_ = {}

		arg_704_1:InitPlayNodeList()
	end,
	Play1101104167 = function(arg_708_0, arg_708_1)
		arg_708_1.time_ = 0
		arg_708_1.frameCnt_ = 0
		arg_708_1.state_ = "playing"
		arg_708_1.curTalkId_ = 1101104167
		arg_708_1.duration_ = 5

		SetActive(arg_708_1.tipsGo_, false)

		function arg_708_1.onSingleLineFinish_()
			arg_708_1.onSingleLineUpdate_ = nil
			arg_708_1.onSingleLineFinish_ = nil
			arg_708_1.state_ = "waiting"
		end

		function arg_708_1.playNext_(arg_710_0)
			if arg_710_0 == 1 then
				arg_708_0:Play1101104168(arg_708_1)
			end
		end

		function arg_708_1.onSingleLineUpdate_(arg_711_0)
			local var_711_0 = "R1101a"

			if arg_708_1.bgs_[var_711_0] == nil then
				local var_711_1 = Object.Instantiate(arg_708_1.paintGo_)

				var_711_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_711_0)
				var_711_1.name = var_711_0
				var_711_1.transform.parent = arg_708_1.stage_.transform
				var_711_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_708_1.bgs_[var_711_0] = var_711_1
			end

			local var_711_2 = 0

			if var_711_2 < arg_708_1.time_ and arg_708_1.time_ <= var_711_2 + arg_711_0 then
				local var_711_3 = manager.ui.mainCamera.transform.localPosition
				local var_711_4 = Vector3.New(0, 0, 10) + Vector3.New(var_711_3.x, var_711_3.y, 0)
				local var_711_5 = arg_708_1.bgs_.R1101a

				var_711_5.transform.localPosition = var_711_4
				var_711_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_711_6 = var_711_5:GetComponent("SpriteRenderer")

				if var_711_6 and var_711_6.sprite then
					local var_711_7 = (var_711_5.transform.localPosition - var_711_3).z
					local var_711_8 = manager.ui.mainCameraCom_
					local var_711_9 = 2 * var_711_7 * Mathf.Tan(var_711_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_711_10 = var_711_9 * var_711_8.aspect
					local var_711_11 = var_711_6.sprite.bounds.size.x
					local var_711_12 = var_711_6.sprite.bounds.size.y
					local var_711_13 = var_711_10 / var_711_11
					local var_711_14 = var_711_9 / var_711_12
					local var_711_15 = var_711_14 < var_711_13 and var_711_13 or var_711_14

					var_711_5.transform.localScale = Vector3.New(var_711_15, var_711_15, 0)
				end

				for iter_711_0, iter_711_1 in pairs(arg_708_1.bgs_) do
					if iter_711_0 ~= "R1101a" then
						iter_711_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_711_16 = 0
			local var_711_17 = 0.65

			if var_711_16 < arg_708_1.time_ and arg_708_1.time_ <= var_711_16 + arg_711_0 then
				arg_708_1.talkMaxDuration = 0

				arg_708_1.dialog_:SetActive(true)

				arg_708_1.dialogCg_.alpha = 0

				local var_711_18 = LeanTween.value(arg_708_1.dialog_, 0, 1, 0.3)

				var_711_18:setOnUpdate(LuaHelper.FloatAction(function(arg_712_0)
					arg_708_1.dialogCg_.alpha = arg_712_0
				end))
				var_711_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_708_1.dialog_)
					var_711_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_708_1.duration_ = arg_708_1.duration_ + 0.3

				SetActive(arg_708_1.leftNameGo_, true)

				local var_711_19 = arg_708_1:FormatText(StoryNameCfg[7].name)

				arg_708_1.leftNameTxt_.text = var_711_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_708_1.leftNameTxt_.transform)

				arg_708_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_708_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_708_1:RecordName(arg_708_1.leftNameTxt_.text)
				SetActive(arg_708_1.iconTrs_.gameObject, true)
				arg_708_1.iconController_:SetSelectedState("hero")

				arg_708_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_708_1.callingController_:SetSelectedState("normal")

				arg_708_1.keyicon_.color = Color.New(1, 1, 1)
				arg_708_1.icon_.color = Color.New(1, 1, 1)

				local var_711_20 = arg_708_1:GetWordFromCfg(1101104167)
				local var_711_21 = arg_708_1:FormatText(var_711_20.content)

				arg_708_1.text_.text = var_711_21

				LuaForUtil.ClearLinePrefixSymbol(arg_708_1.text_)

				local var_711_22 = 26
				local var_711_23 = utf8.len(var_711_21)
				local var_711_24 = var_711_22 <= 0 and var_711_17 or var_711_17 * (var_711_23 / var_711_22)

				if var_711_24 > 0 and var_711_17 < var_711_24 then
					arg_708_1.talkMaxDuration = var_711_24
					var_711_16 = var_711_16 + 0.3

					if var_711_24 + var_711_16 > arg_708_1.duration_ then
						arg_708_1.duration_ = var_711_24 + var_711_16
					end
				end

				arg_708_1.text_.text = var_711_21
				arg_708_1.typewritter.percent = 0

				arg_708_1.typewritter:SetDirty()
				arg_708_1:ShowNextGo(false)
				arg_708_1:RecordContent(arg_708_1.text_.text)
			end

			local var_711_25 = var_711_16 + 0.3
			local var_711_26 = math.max(var_711_17, arg_708_1.talkMaxDuration)

			if var_711_25 <= arg_708_1.time_ and arg_708_1.time_ < var_711_25 + var_711_26 then
				arg_708_1.typewritter.percent = (arg_708_1.time_ - var_711_25) / var_711_26

				arg_708_1.typewritter:SetDirty()
			end

			if arg_708_1.time_ >= var_711_25 + var_711_26 and arg_708_1.time_ < var_711_25 + var_711_26 + arg_711_0 then
				arg_708_1.typewritter.percent = 1

				arg_708_1.typewritter:SetDirty()
				arg_708_1:ShowNextGo(true)
			end
		end

		arg_708_1.nodeConfigList_ = {}

		arg_708_1:InitPlayNodeList()
	end,
	Play1101104168 = function(arg_714_0, arg_714_1)
		arg_714_1.time_ = 0
		arg_714_1.frameCnt_ = 0
		arg_714_1.state_ = "playing"
		arg_714_1.curTalkId_ = 1101104168
		arg_714_1.duration_ = 4.23

		local var_714_0 = {
			zh = 4.233,
			ja = 3.766
		}
		local var_714_1 = manager.audio:GetLocalizationFlag()

		if var_714_0[var_714_1] ~= nil then
			arg_714_1.duration_ = var_714_0[var_714_1]
		end

		SetActive(arg_714_1.tipsGo_, false)

		function arg_714_1.onSingleLineFinish_()
			arg_714_1.onSingleLineUpdate_ = nil
			arg_714_1.onSingleLineFinish_ = nil
			arg_714_1.state_ = "waiting"
		end

		function arg_714_1.playNext_(arg_716_0)
			if arg_716_0 == 1 then
				arg_714_0:Play1101104169(arg_714_1)
			end
		end

		function arg_714_1.onSingleLineUpdate_(arg_717_0)
			local var_717_0 = 0
			local var_717_1 = 0.45

			if var_717_0 < arg_714_1.time_ and arg_714_1.time_ <= var_717_0 + arg_717_0 then
				arg_714_1.talkMaxDuration = 0
				arg_714_1.dialogCg_.alpha = 1

				arg_714_1.dialog_:SetActive(true)
				SetActive(arg_714_1.leftNameGo_, true)

				local var_717_2 = arg_714_1:FormatText(StoryNameCfg[67].name)

				arg_714_1.leftNameTxt_.text = var_717_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_714_1.leftNameTxt_.transform)

				arg_714_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_714_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_714_1:RecordName(arg_714_1.leftNameTxt_.text)
				SetActive(arg_714_1.iconTrs_.gameObject, false)
				arg_714_1.callingController_:SetSelectedState("normal")

				local var_717_3 = arg_714_1:GetWordFromCfg(1101104168)
				local var_717_4 = arg_714_1:FormatText(var_717_3.content)

				arg_714_1.text_.text = var_717_4

				LuaForUtil.ClearLinePrefixSymbol(arg_714_1.text_)

				local var_717_5 = 18
				local var_717_6 = utf8.len(var_717_4)
				local var_717_7 = var_717_5 <= 0 and var_717_1 or var_717_1 * (var_717_6 / var_717_5)

				if var_717_7 > 0 and var_717_1 < var_717_7 then
					arg_714_1.talkMaxDuration = var_717_7

					if var_717_7 + var_717_0 > arg_714_1.duration_ then
						arg_714_1.duration_ = var_717_7 + var_717_0
					end
				end

				arg_714_1.text_.text = var_717_4
				arg_714_1.typewritter.percent = 0

				arg_714_1.typewritter:SetDirty()
				arg_714_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101104", "1101104168", "story_v_side_new_1101104.awb") ~= 0 then
					local var_717_8 = manager.audio:GetVoiceLength("story_v_side_new_1101104", "1101104168", "story_v_side_new_1101104.awb") / 1000

					if var_717_8 + var_717_0 > arg_714_1.duration_ then
						arg_714_1.duration_ = var_717_8 + var_717_0
					end

					if var_717_3.prefab_name ~= "" and arg_714_1.actors_[var_717_3.prefab_name] ~= nil then
						local var_717_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_714_1.actors_[var_717_3.prefab_name].transform, "story_v_side_new_1101104", "1101104168", "story_v_side_new_1101104.awb")

						arg_714_1:RecordAudio("1101104168", var_717_9)
						arg_714_1:RecordAudio("1101104168", var_717_9)
					else
						arg_714_1:AudioAction("play", "voice", "story_v_side_new_1101104", "1101104168", "story_v_side_new_1101104.awb")
					end

					arg_714_1:RecordHistoryTalkVoice("story_v_side_new_1101104", "1101104168", "story_v_side_new_1101104.awb")
				end

				arg_714_1:RecordContent(arg_714_1.text_.text)
			end

			local var_717_10 = math.max(var_717_1, arg_714_1.talkMaxDuration)

			if var_717_0 <= arg_714_1.time_ and arg_714_1.time_ < var_717_0 + var_717_10 then
				arg_714_1.typewritter.percent = (arg_714_1.time_ - var_717_0) / var_717_10

				arg_714_1.typewritter:SetDirty()
			end

			if arg_714_1.time_ >= var_717_0 + var_717_10 and arg_714_1.time_ < var_717_0 + var_717_10 + arg_717_0 then
				arg_714_1.typewritter.percent = 1

				arg_714_1.typewritter:SetDirty()
				arg_714_1:ShowNextGo(true)
			end
		end

		arg_714_1.nodeConfigList_ = {}

		arg_714_1:InitPlayNodeList()
	end,
	Play1101104169 = function(arg_718_0, arg_718_1)
		arg_718_1.time_ = 0
		arg_718_1.frameCnt_ = 0
		arg_718_1.state_ = "playing"
		arg_718_1.curTalkId_ = 1101104169
		arg_718_1.duration_ = 6.13

		local var_718_0 = {
			zh = 3.333,
			ja = 6.133
		}
		local var_718_1 = manager.audio:GetLocalizationFlag()

		if var_718_0[var_718_1] ~= nil then
			arg_718_1.duration_ = var_718_0[var_718_1]
		end

		SetActive(arg_718_1.tipsGo_, false)

		function arg_718_1.onSingleLineFinish_()
			arg_718_1.onSingleLineUpdate_ = nil
			arg_718_1.onSingleLineFinish_ = nil
			arg_718_1.state_ = "waiting"
		end

		function arg_718_1.playNext_(arg_720_0)
			if arg_720_0 == 1 then
				arg_718_0:Play1101104170(arg_718_1)
			end
		end

		function arg_718_1.onSingleLineUpdate_(arg_721_0)
			local var_721_0 = 0
			local var_721_1 = 0.35

			if var_721_0 < arg_718_1.time_ and arg_718_1.time_ <= var_721_0 + arg_721_0 then
				arg_718_1.talkMaxDuration = 0
				arg_718_1.dialogCg_.alpha = 1

				arg_718_1.dialog_:SetActive(true)
				SetActive(arg_718_1.leftNameGo_, true)

				local var_721_2 = arg_718_1:FormatText(StoryNameCfg[37].name)

				arg_718_1.leftNameTxt_.text = var_721_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_718_1.leftNameTxt_.transform)

				arg_718_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_718_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_718_1:RecordName(arg_718_1.leftNameTxt_.text)
				SetActive(arg_718_1.iconTrs_.gameObject, false)
				arg_718_1.callingController_:SetSelectedState("normal")

				local var_721_3 = arg_718_1:GetWordFromCfg(1101104169)
				local var_721_4 = arg_718_1:FormatText(var_721_3.content)

				arg_718_1.text_.text = var_721_4

				LuaForUtil.ClearLinePrefixSymbol(arg_718_1.text_)

				local var_721_5 = 14
				local var_721_6 = utf8.len(var_721_4)
				local var_721_7 = var_721_5 <= 0 and var_721_1 or var_721_1 * (var_721_6 / var_721_5)

				if var_721_7 > 0 and var_721_1 < var_721_7 then
					arg_718_1.talkMaxDuration = var_721_7

					if var_721_7 + var_721_0 > arg_718_1.duration_ then
						arg_718_1.duration_ = var_721_7 + var_721_0
					end
				end

				arg_718_1.text_.text = var_721_4
				arg_718_1.typewritter.percent = 0

				arg_718_1.typewritter:SetDirty()
				arg_718_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101104", "1101104169", "story_v_side_new_1101104.awb") ~= 0 then
					local var_721_8 = manager.audio:GetVoiceLength("story_v_side_new_1101104", "1101104169", "story_v_side_new_1101104.awb") / 1000

					if var_721_8 + var_721_0 > arg_718_1.duration_ then
						arg_718_1.duration_ = var_721_8 + var_721_0
					end

					if var_721_3.prefab_name ~= "" and arg_718_1.actors_[var_721_3.prefab_name] ~= nil then
						local var_721_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_718_1.actors_[var_721_3.prefab_name].transform, "story_v_side_new_1101104", "1101104169", "story_v_side_new_1101104.awb")

						arg_718_1:RecordAudio("1101104169", var_721_9)
						arg_718_1:RecordAudio("1101104169", var_721_9)
					else
						arg_718_1:AudioAction("play", "voice", "story_v_side_new_1101104", "1101104169", "story_v_side_new_1101104.awb")
					end

					arg_718_1:RecordHistoryTalkVoice("story_v_side_new_1101104", "1101104169", "story_v_side_new_1101104.awb")
				end

				arg_718_1:RecordContent(arg_718_1.text_.text)
			end

			local var_721_10 = math.max(var_721_1, arg_718_1.talkMaxDuration)

			if var_721_0 <= arg_718_1.time_ and arg_718_1.time_ < var_721_0 + var_721_10 then
				arg_718_1.typewritter.percent = (arg_718_1.time_ - var_721_0) / var_721_10

				arg_718_1.typewritter:SetDirty()
			end

			if arg_718_1.time_ >= var_721_0 + var_721_10 and arg_718_1.time_ < var_721_0 + var_721_10 + arg_721_0 then
				arg_718_1.typewritter.percent = 1

				arg_718_1.typewritter:SetDirty()
				arg_718_1:ShowNextGo(true)
			end
		end

		arg_718_1.nodeConfigList_ = {}

		arg_718_1:InitPlayNodeList()
	end,
	Play1101104170 = function(arg_722_0, arg_722_1)
		arg_722_1.time_ = 0
		arg_722_1.frameCnt_ = 0
		arg_722_1.state_ = "playing"
		arg_722_1.curTalkId_ = 1101104170
		arg_722_1.duration_ = 5

		SetActive(arg_722_1.tipsGo_, false)

		function arg_722_1.onSingleLineFinish_()
			arg_722_1.onSingleLineUpdate_ = nil
			arg_722_1.onSingleLineFinish_ = nil
			arg_722_1.state_ = "waiting"
		end

		function arg_722_1.playNext_(arg_724_0)
			if arg_724_0 == 1 then
				arg_722_0:Play1101104171(arg_722_1)
			end
		end

		function arg_722_1.onSingleLineUpdate_(arg_725_0)
			local var_725_0 = 0
			local var_725_1 = 0.2

			if var_725_0 < arg_722_1.time_ and arg_722_1.time_ <= var_725_0 + arg_725_0 then
				arg_722_1.talkMaxDuration = 0
				arg_722_1.dialogCg_.alpha = 1

				arg_722_1.dialog_:SetActive(true)
				SetActive(arg_722_1.leftNameGo_, true)

				local var_725_2 = arg_722_1:FormatText(StoryNameCfg[7].name)

				arg_722_1.leftNameTxt_.text = var_725_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_722_1.leftNameTxt_.transform)

				arg_722_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_722_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_722_1:RecordName(arg_722_1.leftNameTxt_.text)
				SetActive(arg_722_1.iconTrs_.gameObject, true)
				arg_722_1.iconController_:SetSelectedState("hero")

				arg_722_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_722_1.callingController_:SetSelectedState("normal")

				arg_722_1.keyicon_.color = Color.New(1, 1, 1)
				arg_722_1.icon_.color = Color.New(1, 1, 1)

				local var_725_3 = arg_722_1:GetWordFromCfg(1101104170)
				local var_725_4 = arg_722_1:FormatText(var_725_3.content)

				arg_722_1.text_.text = var_725_4

				LuaForUtil.ClearLinePrefixSymbol(arg_722_1.text_)

				local var_725_5 = 8
				local var_725_6 = utf8.len(var_725_4)
				local var_725_7 = var_725_5 <= 0 and var_725_1 or var_725_1 * (var_725_6 / var_725_5)

				if var_725_7 > 0 and var_725_1 < var_725_7 then
					arg_722_1.talkMaxDuration = var_725_7

					if var_725_7 + var_725_0 > arg_722_1.duration_ then
						arg_722_1.duration_ = var_725_7 + var_725_0
					end
				end

				arg_722_1.text_.text = var_725_4
				arg_722_1.typewritter.percent = 0

				arg_722_1.typewritter:SetDirty()
				arg_722_1:ShowNextGo(false)
				arg_722_1:RecordContent(arg_722_1.text_.text)
			end

			local var_725_8 = math.max(var_725_1, arg_722_1.talkMaxDuration)

			if var_725_0 <= arg_722_1.time_ and arg_722_1.time_ < var_725_0 + var_725_8 then
				arg_722_1.typewritter.percent = (arg_722_1.time_ - var_725_0) / var_725_8

				arg_722_1.typewritter:SetDirty()
			end

			if arg_722_1.time_ >= var_725_0 + var_725_8 and arg_722_1.time_ < var_725_0 + var_725_8 + arg_725_0 then
				arg_722_1.typewritter.percent = 1

				arg_722_1.typewritter:SetDirty()
				arg_722_1:ShowNextGo(true)
			end
		end

		arg_722_1.nodeConfigList_ = {}

		arg_722_1:InitPlayNodeList()
	end,
	Play1101104014 = function(arg_726_0, arg_726_1)
		arg_726_1.time_ = 0
		arg_726_1.frameCnt_ = 0
		arg_726_1.state_ = "playing"
		arg_726_1.curTalkId_ = 1101104014
		arg_726_1.duration_ = 5

		SetActive(arg_726_1.tipsGo_, false)

		function arg_726_1.onSingleLineFinish_()
			arg_726_1.onSingleLineUpdate_ = nil
			arg_726_1.onSingleLineFinish_ = nil
			arg_726_1.state_ = "waiting"
		end

		function arg_726_1.playNext_(arg_728_0)
			if arg_728_0 == 1 then
				arg_726_0:Play1101104015(arg_726_1)
			end
		end

		function arg_726_1.onSingleLineUpdate_(arg_729_0)
			local var_729_0 = arg_726_1.actors_["1111ui_story"]
			local var_729_1 = 0

			if var_729_1 < arg_726_1.time_ and arg_726_1.time_ <= var_729_1 + arg_729_0 and not isNil(var_729_0) and arg_726_1.var_.characterEffect1111ui_story == nil then
				arg_726_1.var_.characterEffect1111ui_story = var_729_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_729_2 = 0.200000002980232

			if var_729_1 <= arg_726_1.time_ and arg_726_1.time_ < var_729_1 + var_729_2 and not isNil(var_729_0) then
				local var_729_3 = (arg_726_1.time_ - var_729_1) / var_729_2

				if arg_726_1.var_.characterEffect1111ui_story and not isNil(var_729_0) then
					local var_729_4 = Mathf.Lerp(0, 0.5, var_729_3)

					arg_726_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_726_1.var_.characterEffect1111ui_story.fillRatio = var_729_4
				end
			end

			if arg_726_1.time_ >= var_729_1 + var_729_2 and arg_726_1.time_ < var_729_1 + var_729_2 + arg_729_0 and not isNil(var_729_0) and arg_726_1.var_.characterEffect1111ui_story then
				local var_729_5 = 0.5

				arg_726_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_726_1.var_.characterEffect1111ui_story.fillRatio = var_729_5
			end

			local var_729_6 = 0
			local var_729_7 = 0.5

			if var_729_6 < arg_726_1.time_ and arg_726_1.time_ <= var_729_6 + arg_729_0 then
				arg_726_1.talkMaxDuration = 0
				arg_726_1.dialogCg_.alpha = 1

				arg_726_1.dialog_:SetActive(true)
				SetActive(arg_726_1.leftNameGo_, true)

				local var_729_8 = arg_726_1:FormatText(StoryNameCfg[7].name)

				arg_726_1.leftNameTxt_.text = var_729_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_726_1.leftNameTxt_.transform)

				arg_726_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_726_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_726_1:RecordName(arg_726_1.leftNameTxt_.text)
				SetActive(arg_726_1.iconTrs_.gameObject, true)
				arg_726_1.iconController_:SetSelectedState("hero")

				arg_726_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_726_1.callingController_:SetSelectedState("normal")

				arg_726_1.keyicon_.color = Color.New(1, 1, 1)
				arg_726_1.icon_.color = Color.New(1, 1, 1)

				local var_729_9 = arg_726_1:GetWordFromCfg(1101104014)
				local var_729_10 = arg_726_1:FormatText(var_729_9.content)

				arg_726_1.text_.text = var_729_10

				LuaForUtil.ClearLinePrefixSymbol(arg_726_1.text_)

				local var_729_11 = 20
				local var_729_12 = utf8.len(var_729_10)
				local var_729_13 = var_729_11 <= 0 and var_729_7 or var_729_7 * (var_729_12 / var_729_11)

				if var_729_13 > 0 and var_729_7 < var_729_13 then
					arg_726_1.talkMaxDuration = var_729_13

					if var_729_13 + var_729_6 > arg_726_1.duration_ then
						arg_726_1.duration_ = var_729_13 + var_729_6
					end
				end

				arg_726_1.text_.text = var_729_10
				arg_726_1.typewritter.percent = 0

				arg_726_1.typewritter:SetDirty()
				arg_726_1:ShowNextGo(false)
				arg_726_1:RecordContent(arg_726_1.text_.text)
			end

			local var_729_14 = math.max(var_729_7, arg_726_1.talkMaxDuration)

			if var_729_6 <= arg_726_1.time_ and arg_726_1.time_ < var_729_6 + var_729_14 then
				arg_726_1.typewritter.percent = (arg_726_1.time_ - var_729_6) / var_729_14

				arg_726_1.typewritter:SetDirty()
			end

			if arg_726_1.time_ >= var_729_6 + var_729_14 and arg_726_1.time_ < var_729_6 + var_729_14 + arg_729_0 then
				arg_726_1.typewritter.percent = 1

				arg_726_1.typewritter:SetDirty()
				arg_726_1:ShowNextGo(true)
			end
		end

		arg_726_1.nodeConfigList_ = {}

		arg_726_1:InitPlayNodeList()
	end,
	Play1101104015 = function(arg_730_0, arg_730_1)
		arg_730_1.time_ = 0
		arg_730_1.frameCnt_ = 0
		arg_730_1.state_ = "playing"
		arg_730_1.curTalkId_ = 1101104015
		arg_730_1.duration_ = 3.83

		local var_730_0 = {
			zh = 3.833,
			ja = 3.1
		}
		local var_730_1 = manager.audio:GetLocalizationFlag()

		if var_730_0[var_730_1] ~= nil then
			arg_730_1.duration_ = var_730_0[var_730_1]
		end

		SetActive(arg_730_1.tipsGo_, false)

		function arg_730_1.onSingleLineFinish_()
			arg_730_1.onSingleLineUpdate_ = nil
			arg_730_1.onSingleLineFinish_ = nil
			arg_730_1.state_ = "waiting"
		end

		function arg_730_1.playNext_(arg_732_0)
			if arg_732_0 == 1 then
				arg_730_0:Play1101104016(arg_730_1)
			end
		end

		function arg_730_1.onSingleLineUpdate_(arg_733_0)
			local var_733_0 = arg_730_1.actors_["1111ui_story"].transform
			local var_733_1 = 0

			if var_733_1 < arg_730_1.time_ and arg_730_1.time_ <= var_733_1 + arg_733_0 then
				arg_730_1.var_.moveOldPos1111ui_story = var_733_0.localPosition
			end

			local var_733_2 = 0.001

			if var_733_1 <= arg_730_1.time_ and arg_730_1.time_ < var_733_1 + var_733_2 then
				local var_733_3 = (arg_730_1.time_ - var_733_1) / var_733_2
				local var_733_4 = Vector3.New(0, -0.87, -5.7)

				var_733_0.localPosition = Vector3.Lerp(arg_730_1.var_.moveOldPos1111ui_story, var_733_4, var_733_3)

				local var_733_5 = manager.ui.mainCamera.transform.position - var_733_0.position

				var_733_0.forward = Vector3.New(var_733_5.x, var_733_5.y, var_733_5.z)

				local var_733_6 = var_733_0.localEulerAngles

				var_733_6.z = 0
				var_733_6.x = 0
				var_733_0.localEulerAngles = var_733_6
			end

			if arg_730_1.time_ >= var_733_1 + var_733_2 and arg_730_1.time_ < var_733_1 + var_733_2 + arg_733_0 then
				var_733_0.localPosition = Vector3.New(0, -0.87, -5.7)

				local var_733_7 = manager.ui.mainCamera.transform.position - var_733_0.position

				var_733_0.forward = Vector3.New(var_733_7.x, var_733_7.y, var_733_7.z)

				local var_733_8 = var_733_0.localEulerAngles

				var_733_8.z = 0
				var_733_8.x = 0
				var_733_0.localEulerAngles = var_733_8
			end

			local var_733_9 = arg_730_1.actors_["1111ui_story"]
			local var_733_10 = 0

			if var_733_10 < arg_730_1.time_ and arg_730_1.time_ <= var_733_10 + arg_733_0 and not isNil(var_733_9) and arg_730_1.var_.characterEffect1111ui_story == nil then
				arg_730_1.var_.characterEffect1111ui_story = var_733_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_733_11 = 0.200000002980232

			if var_733_10 <= arg_730_1.time_ and arg_730_1.time_ < var_733_10 + var_733_11 and not isNil(var_733_9) then
				local var_733_12 = (arg_730_1.time_ - var_733_10) / var_733_11

				if arg_730_1.var_.characterEffect1111ui_story and not isNil(var_733_9) then
					arg_730_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_730_1.time_ >= var_733_10 + var_733_11 and arg_730_1.time_ < var_733_10 + var_733_11 + arg_733_0 and not isNil(var_733_9) and arg_730_1.var_.characterEffect1111ui_story then
				arg_730_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_733_13 = 0

			if var_733_13 < arg_730_1.time_ and arg_730_1.time_ <= var_733_13 + arg_733_0 then
				arg_730_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_733_14 = 0
			local var_733_15 = 0.375

			if var_733_14 < arg_730_1.time_ and arg_730_1.time_ <= var_733_14 + arg_733_0 then
				arg_730_1.talkMaxDuration = 0
				arg_730_1.dialogCg_.alpha = 1

				arg_730_1.dialog_:SetActive(true)
				SetActive(arg_730_1.leftNameGo_, true)

				local var_733_16 = arg_730_1:FormatText(StoryNameCfg[67].name)

				arg_730_1.leftNameTxt_.text = var_733_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_730_1.leftNameTxt_.transform)

				arg_730_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_730_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_730_1:RecordName(arg_730_1.leftNameTxt_.text)
				SetActive(arg_730_1.iconTrs_.gameObject, false)
				arg_730_1.callingController_:SetSelectedState("normal")

				local var_733_17 = arg_730_1:GetWordFromCfg(1101104015)
				local var_733_18 = arg_730_1:FormatText(var_733_17.content)

				arg_730_1.text_.text = var_733_18

				LuaForUtil.ClearLinePrefixSymbol(arg_730_1.text_)

				local var_733_19 = 15
				local var_733_20 = utf8.len(var_733_18)
				local var_733_21 = var_733_19 <= 0 and var_733_15 or var_733_15 * (var_733_20 / var_733_19)

				if var_733_21 > 0 and var_733_15 < var_733_21 then
					arg_730_1.talkMaxDuration = var_733_21

					if var_733_21 + var_733_14 > arg_730_1.duration_ then
						arg_730_1.duration_ = var_733_21 + var_733_14
					end
				end

				arg_730_1.text_.text = var_733_18
				arg_730_1.typewritter.percent = 0

				arg_730_1.typewritter:SetDirty()
				arg_730_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101104", "1101104015", "story_v_side_new_1101104.awb") ~= 0 then
					local var_733_22 = manager.audio:GetVoiceLength("story_v_side_new_1101104", "1101104015", "story_v_side_new_1101104.awb") / 1000

					if var_733_22 + var_733_14 > arg_730_1.duration_ then
						arg_730_1.duration_ = var_733_22 + var_733_14
					end

					if var_733_17.prefab_name ~= "" and arg_730_1.actors_[var_733_17.prefab_name] ~= nil then
						local var_733_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_730_1.actors_[var_733_17.prefab_name].transform, "story_v_side_new_1101104", "1101104015", "story_v_side_new_1101104.awb")

						arg_730_1:RecordAudio("1101104015", var_733_23)
						arg_730_1:RecordAudio("1101104015", var_733_23)
					else
						arg_730_1:AudioAction("play", "voice", "story_v_side_new_1101104", "1101104015", "story_v_side_new_1101104.awb")
					end

					arg_730_1:RecordHistoryTalkVoice("story_v_side_new_1101104", "1101104015", "story_v_side_new_1101104.awb")
				end

				arg_730_1:RecordContent(arg_730_1.text_.text)
			end

			local var_733_24 = math.max(var_733_15, arg_730_1.talkMaxDuration)

			if var_733_14 <= arg_730_1.time_ and arg_730_1.time_ < var_733_14 + var_733_24 then
				arg_730_1.typewritter.percent = (arg_730_1.time_ - var_733_14) / var_733_24

				arg_730_1.typewritter:SetDirty()
			end

			if arg_730_1.time_ >= var_733_14 + var_733_24 and arg_730_1.time_ < var_733_14 + var_733_24 + arg_733_0 then
				arg_730_1.typewritter.percent = 1

				arg_730_1.typewritter:SetDirty()
				arg_730_1:ShowNextGo(true)
			end
		end

		arg_730_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_730_1:InitPlayNodeList()
	end,
	Play1101104016 = function(arg_734_0, arg_734_1)
		arg_734_1.time_ = 0
		arg_734_1.frameCnt_ = 0
		arg_734_1.state_ = "playing"
		arg_734_1.curTalkId_ = 1101104016
		arg_734_1.duration_ = 5

		SetActive(arg_734_1.tipsGo_, false)

		function arg_734_1.onSingleLineFinish_()
			arg_734_1.onSingleLineUpdate_ = nil
			arg_734_1.onSingleLineFinish_ = nil
			arg_734_1.state_ = "waiting"
		end

		function arg_734_1.playNext_(arg_736_0)
			if arg_736_0 == 1 then
				arg_734_0:Play1101104017(arg_734_1)
			end
		end

		function arg_734_1.onSingleLineUpdate_(arg_737_0)
			local var_737_0 = arg_734_1.actors_["1111ui_story"]
			local var_737_1 = 0

			if var_737_1 < arg_734_1.time_ and arg_734_1.time_ <= var_737_1 + arg_737_0 and not isNil(var_737_0) and arg_734_1.var_.characterEffect1111ui_story == nil then
				arg_734_1.var_.characterEffect1111ui_story = var_737_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_737_2 = 0.200000002980232

			if var_737_1 <= arg_734_1.time_ and arg_734_1.time_ < var_737_1 + var_737_2 and not isNil(var_737_0) then
				local var_737_3 = (arg_734_1.time_ - var_737_1) / var_737_2

				if arg_734_1.var_.characterEffect1111ui_story and not isNil(var_737_0) then
					local var_737_4 = Mathf.Lerp(0, 0.5, var_737_3)

					arg_734_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_734_1.var_.characterEffect1111ui_story.fillRatio = var_737_4
				end
			end

			if arg_734_1.time_ >= var_737_1 + var_737_2 and arg_734_1.time_ < var_737_1 + var_737_2 + arg_737_0 and not isNil(var_737_0) and arg_734_1.var_.characterEffect1111ui_story then
				local var_737_5 = 0.5

				arg_734_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_734_1.var_.characterEffect1111ui_story.fillRatio = var_737_5
			end

			local var_737_6 = 0
			local var_737_7 = 0.675

			if var_737_6 < arg_734_1.time_ and arg_734_1.time_ <= var_737_6 + arg_737_0 then
				arg_734_1.talkMaxDuration = 0
				arg_734_1.dialogCg_.alpha = 1

				arg_734_1.dialog_:SetActive(true)
				SetActive(arg_734_1.leftNameGo_, true)

				local var_737_8 = arg_734_1:FormatText(StoryNameCfg[7].name)

				arg_734_1.leftNameTxt_.text = var_737_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_734_1.leftNameTxt_.transform)

				arg_734_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_734_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_734_1:RecordName(arg_734_1.leftNameTxt_.text)
				SetActive(arg_734_1.iconTrs_.gameObject, true)
				arg_734_1.iconController_:SetSelectedState("hero")

				arg_734_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_734_1.callingController_:SetSelectedState("normal")

				arg_734_1.keyicon_.color = Color.New(1, 1, 1)
				arg_734_1.icon_.color = Color.New(1, 1, 1)

				local var_737_9 = arg_734_1:GetWordFromCfg(1101104016)
				local var_737_10 = arg_734_1:FormatText(var_737_9.content)

				arg_734_1.text_.text = var_737_10

				LuaForUtil.ClearLinePrefixSymbol(arg_734_1.text_)

				local var_737_11 = 27
				local var_737_12 = utf8.len(var_737_10)
				local var_737_13 = var_737_11 <= 0 and var_737_7 or var_737_7 * (var_737_12 / var_737_11)

				if var_737_13 > 0 and var_737_7 < var_737_13 then
					arg_734_1.talkMaxDuration = var_737_13

					if var_737_13 + var_737_6 > arg_734_1.duration_ then
						arg_734_1.duration_ = var_737_13 + var_737_6
					end
				end

				arg_734_1.text_.text = var_737_10
				arg_734_1.typewritter.percent = 0

				arg_734_1.typewritter:SetDirty()
				arg_734_1:ShowNextGo(false)
				arg_734_1:RecordContent(arg_734_1.text_.text)
			end

			local var_737_14 = math.max(var_737_7, arg_734_1.talkMaxDuration)

			if var_737_6 <= arg_734_1.time_ and arg_734_1.time_ < var_737_6 + var_737_14 then
				arg_734_1.typewritter.percent = (arg_734_1.time_ - var_737_6) / var_737_14

				arg_734_1.typewritter:SetDirty()
			end

			if arg_734_1.time_ >= var_737_6 + var_737_14 and arg_734_1.time_ < var_737_6 + var_737_14 + arg_737_0 then
				arg_734_1.typewritter.percent = 1

				arg_734_1.typewritter:SetDirty()
				arg_734_1:ShowNextGo(true)
			end
		end

		arg_734_1.nodeConfigList_ = {}

		arg_734_1:InitPlayNodeList()
	end,
	Play1101104017 = function(arg_738_0, arg_738_1)
		arg_738_1.time_ = 0
		arg_738_1.frameCnt_ = 0
		arg_738_1.state_ = "playing"
		arg_738_1.curTalkId_ = 1101104017
		arg_738_1.duration_ = 2

		SetActive(arg_738_1.tipsGo_, false)

		function arg_738_1.onSingleLineFinish_()
			arg_738_1.onSingleLineUpdate_ = nil
			arg_738_1.onSingleLineFinish_ = nil
			arg_738_1.state_ = "waiting"
		end

		function arg_738_1.playNext_(arg_740_0)
			if arg_740_0 == 1 then
				arg_738_0:Play1101104018(arg_738_1)
			end
		end

		function arg_738_1.onSingleLineUpdate_(arg_741_0)
			local var_741_0 = arg_738_1.actors_["1111ui_story"].transform
			local var_741_1 = 0

			if var_741_1 < arg_738_1.time_ and arg_738_1.time_ <= var_741_1 + arg_741_0 then
				arg_738_1.var_.moveOldPos1111ui_story = var_741_0.localPosition
			end

			local var_741_2 = 0.001

			if var_741_1 <= arg_738_1.time_ and arg_738_1.time_ < var_741_1 + var_741_2 then
				local var_741_3 = (arg_738_1.time_ - var_741_1) / var_741_2
				local var_741_4 = Vector3.New(0, -0.87, -5.7)

				var_741_0.localPosition = Vector3.Lerp(arg_738_1.var_.moveOldPos1111ui_story, var_741_4, var_741_3)

				local var_741_5 = manager.ui.mainCamera.transform.position - var_741_0.position

				var_741_0.forward = Vector3.New(var_741_5.x, var_741_5.y, var_741_5.z)

				local var_741_6 = var_741_0.localEulerAngles

				var_741_6.z = 0
				var_741_6.x = 0
				var_741_0.localEulerAngles = var_741_6
			end

			if arg_738_1.time_ >= var_741_1 + var_741_2 and arg_738_1.time_ < var_741_1 + var_741_2 + arg_741_0 then
				var_741_0.localPosition = Vector3.New(0, -0.87, -5.7)

				local var_741_7 = manager.ui.mainCamera.transform.position - var_741_0.position

				var_741_0.forward = Vector3.New(var_741_7.x, var_741_7.y, var_741_7.z)

				local var_741_8 = var_741_0.localEulerAngles

				var_741_8.z = 0
				var_741_8.x = 0
				var_741_0.localEulerAngles = var_741_8
			end

			local var_741_9 = arg_738_1.actors_["1111ui_story"]
			local var_741_10 = 0

			if var_741_10 < arg_738_1.time_ and arg_738_1.time_ <= var_741_10 + arg_741_0 and not isNil(var_741_9) and arg_738_1.var_.characterEffect1111ui_story == nil then
				arg_738_1.var_.characterEffect1111ui_story = var_741_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_741_11 = 0.200000002980232

			if var_741_10 <= arg_738_1.time_ and arg_738_1.time_ < var_741_10 + var_741_11 and not isNil(var_741_9) then
				local var_741_12 = (arg_738_1.time_ - var_741_10) / var_741_11

				if arg_738_1.var_.characterEffect1111ui_story and not isNil(var_741_9) then
					arg_738_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_738_1.time_ >= var_741_10 + var_741_11 and arg_738_1.time_ < var_741_10 + var_741_11 + arg_741_0 and not isNil(var_741_9) and arg_738_1.var_.characterEffect1111ui_story then
				arg_738_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_741_13 = 0

			if var_741_13 < arg_738_1.time_ and arg_738_1.time_ <= var_741_13 + arg_741_0 then
				arg_738_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111actionlink/1111action456")
			end

			local var_741_14 = 0

			if var_741_14 < arg_738_1.time_ and arg_738_1.time_ <= var_741_14 + arg_741_0 then
				arg_738_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_741_15 = 0
			local var_741_16 = 0.125

			if var_741_15 < arg_738_1.time_ and arg_738_1.time_ <= var_741_15 + arg_741_0 then
				arg_738_1.talkMaxDuration = 0
				arg_738_1.dialogCg_.alpha = 1

				arg_738_1.dialog_:SetActive(true)
				SetActive(arg_738_1.leftNameGo_, true)

				local var_741_17 = arg_738_1:FormatText(StoryNameCfg[67].name)

				arg_738_1.leftNameTxt_.text = var_741_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_738_1.leftNameTxt_.transform)

				arg_738_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_738_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_738_1:RecordName(arg_738_1.leftNameTxt_.text)
				SetActive(arg_738_1.iconTrs_.gameObject, false)
				arg_738_1.callingController_:SetSelectedState("normal")

				local var_741_18 = arg_738_1:GetWordFromCfg(1101104017)
				local var_741_19 = arg_738_1:FormatText(var_741_18.content)

				arg_738_1.text_.text = var_741_19

				LuaForUtil.ClearLinePrefixSymbol(arg_738_1.text_)

				local var_741_20 = 5
				local var_741_21 = utf8.len(var_741_19)
				local var_741_22 = var_741_20 <= 0 and var_741_16 or var_741_16 * (var_741_21 / var_741_20)

				if var_741_22 > 0 and var_741_16 < var_741_22 then
					arg_738_1.talkMaxDuration = var_741_22

					if var_741_22 + var_741_15 > arg_738_1.duration_ then
						arg_738_1.duration_ = var_741_22 + var_741_15
					end
				end

				arg_738_1.text_.text = var_741_19
				arg_738_1.typewritter.percent = 0

				arg_738_1.typewritter:SetDirty()
				arg_738_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101104", "1101104017", "story_v_side_new_1101104.awb") ~= 0 then
					local var_741_23 = manager.audio:GetVoiceLength("story_v_side_new_1101104", "1101104017", "story_v_side_new_1101104.awb") / 1000

					if var_741_23 + var_741_15 > arg_738_1.duration_ then
						arg_738_1.duration_ = var_741_23 + var_741_15
					end

					if var_741_18.prefab_name ~= "" and arg_738_1.actors_[var_741_18.prefab_name] ~= nil then
						local var_741_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_738_1.actors_[var_741_18.prefab_name].transform, "story_v_side_new_1101104", "1101104017", "story_v_side_new_1101104.awb")

						arg_738_1:RecordAudio("1101104017", var_741_24)
						arg_738_1:RecordAudio("1101104017", var_741_24)
					else
						arg_738_1:AudioAction("play", "voice", "story_v_side_new_1101104", "1101104017", "story_v_side_new_1101104.awb")
					end

					arg_738_1:RecordHistoryTalkVoice("story_v_side_new_1101104", "1101104017", "story_v_side_new_1101104.awb")
				end

				arg_738_1:RecordContent(arg_738_1.text_.text)
			end

			local var_741_25 = math.max(var_741_16, arg_738_1.talkMaxDuration)

			if var_741_15 <= arg_738_1.time_ and arg_738_1.time_ < var_741_15 + var_741_25 then
				arg_738_1.typewritter.percent = (arg_738_1.time_ - var_741_15) / var_741_25

				arg_738_1.typewritter:SetDirty()
			end

			if arg_738_1.time_ >= var_741_15 + var_741_25 and arg_738_1.time_ < var_741_15 + var_741_25 + arg_741_0 then
				arg_738_1.typewritter.percent = 1

				arg_738_1.typewritter:SetDirty()
				arg_738_1:ShowNextGo(true)
			end
		end

		arg_738_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_738_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/B13",
		"TextureConfig/Background/ST01",
		"TextureConfig/Background/ST12",
		"TextureConfig/Background/ST13",
		"TextureConfig/Background/ST19",
		"TextureConfig/Background/R1101",
		"TextureConfig/Background/R1101b",
		"TextureConfig/Background/R1101a"
	},
	voices = {
		"story_v_side_new_1101104.awb"
	}
}
