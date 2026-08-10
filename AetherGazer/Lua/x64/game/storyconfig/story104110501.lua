return {
	Play411051001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 411051001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play411051002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "ST74"

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
				local var_4_5 = arg_1_1.bgs_.ST74

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
					if iter_4_0 ~= "ST74" then
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
			local var_4_23 = 0.366666666666667

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

			local var_4_28 = 1.23333333333333
			local var_4_29 = 0.766666666666667

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				local var_4_30 = "play"
				local var_4_31 = "effect"

				arg_1_1:AudioAction(var_4_30, var_4_31, "se_story_131", "se_story_131__opendoor", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_32 = 2
			local var_4_33 = 0.5

			if var_4_32 < arg_1_1.time_ and arg_1_1.time_ <= var_4_32 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_34 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_34:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_34:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_34:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_35 = arg_1_1:GetWordFromCfg(411051001)
				local var_4_36 = arg_1_1:FormatText(var_4_35.content)

				arg_1_1.text_.text = var_4_36

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_37 = 20
				local var_4_38 = utf8.len(var_4_36)
				local var_4_39 = var_4_37 <= 0 and var_4_33 or var_4_33 * (var_4_38 / var_4_37)

				if var_4_39 > 0 and var_4_33 < var_4_39 then
					arg_1_1.talkMaxDuration = var_4_39
					var_4_32 = var_4_32 + 0.3

					if var_4_39 + var_4_32 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_39 + var_4_32
					end
				end

				arg_1_1.text_.text = var_4_36
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_40 = var_4_32 + 0.3
			local var_4_41 = math.max(var_4_33, arg_1_1.talkMaxDuration)

			if var_4_40 <= arg_1_1.time_ and arg_1_1.time_ < var_4_40 + var_4_41 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_40) / var_4_41

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_40 + var_4_41 and arg_1_1.time_ < var_4_40 + var_4_41 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play411051002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 411051002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play411051003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 0
			local var_11_1 = 1.075

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

				local var_11_2 = arg_8_1:GetWordFromCfg(411051002)
				local var_11_3 = arg_8_1:FormatText(var_11_2.content)

				arg_8_1.text_.text = var_11_3

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_4 = 43
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
	Play411051003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 411051003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play411051004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 0
			local var_15_1 = 1.15

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

				local var_15_2 = arg_12_1:GetWordFromCfg(411051003)
				local var_15_3 = arg_12_1:FormatText(var_15_2.content)

				arg_12_1.text_.text = var_15_3

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_4 = 46
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
	Play411051004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 411051004
		arg_16_1.duration_ = 5

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play411051005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = 0
			local var_19_1 = 0.325

			if var_19_0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_0 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, false)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_2 = arg_16_1:GetWordFromCfg(411051004)
				local var_19_3 = arg_16_1:FormatText(var_19_2.content)

				arg_16_1.text_.text = var_19_3

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_4 = 13
				local var_19_5 = utf8.len(var_19_3)
				local var_19_6 = var_19_4 <= 0 and var_19_1 or var_19_1 * (var_19_5 / var_19_4)

				if var_19_6 > 0 and var_19_1 < var_19_6 then
					arg_16_1.talkMaxDuration = var_19_6

					if var_19_6 + var_19_0 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_6 + var_19_0
					end
				end

				arg_16_1.text_.text = var_19_3
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)
				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_7 = math.max(var_19_1, arg_16_1.talkMaxDuration)

			if var_19_0 <= arg_16_1.time_ and arg_16_1.time_ < var_19_0 + var_19_7 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_0) / var_19_7

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_0 + var_19_7 and arg_16_1.time_ < var_19_0 + var_19_7 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play411051005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 411051005
		arg_20_1.duration_ = 5

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play411051006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = 0

			if var_23_0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_0 + arg_23_0 then
				arg_20_1.fswbg_:SetActive(true)
				arg_20_1.dialog_:SetActive(false)

				arg_20_1.fswtw_.percent = 0

				local var_23_1 = arg_20_1:GetWordFromCfg(411051005)
				local var_23_2 = arg_20_1:FormatText(var_23_1.content)

				arg_20_1.fswt_.text = var_23_2

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.fswt_)

				arg_20_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_20_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_20_1.fswtw_:SetDirty()

				arg_20_1.typewritterCharCountI18N = 0

				SetActive(arg_20_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_20_1:ShowNextGo(false)
			end

			local var_23_3 = 0.333

			if var_23_3 < arg_20_1.time_ and arg_20_1.time_ <= var_23_3 + arg_23_0 then
				arg_20_1.var_.oldValueTypewriter = arg_20_1.fswtw_.percent

				SetActive(arg_20_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_20_1:ShowNextGo(false)
			end

			local var_23_4 = 16
			local var_23_5 = 1.06666666666667
			local var_23_6 = arg_20_1:GetWordFromCfg(411051005)
			local var_23_7 = arg_20_1:FormatText(var_23_6.content)
			local var_23_8, var_23_9 = arg_20_1:GetPercentByPara(var_23_7, 1)

			if var_23_3 < arg_20_1.time_ and arg_20_1.time_ <= var_23_3 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0

				local var_23_10 = var_23_4 <= 0 and var_23_5 or var_23_5 * ((var_23_9 - arg_20_1.typewritterCharCountI18N) / var_23_4)

				if var_23_10 > 0 and var_23_5 < var_23_10 then
					arg_20_1.talkMaxDuration = var_23_10

					if var_23_10 + var_23_3 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_10 + var_23_3
					end
				end
			end

			local var_23_11 = 1.06666666666667
			local var_23_12 = math.max(var_23_11, arg_20_1.talkMaxDuration)

			if var_23_3 <= arg_20_1.time_ and arg_20_1.time_ < var_23_3 + var_23_12 then
				local var_23_13 = (arg_20_1.time_ - var_23_3) / var_23_12

				arg_20_1.fswtw_.percent = Mathf.Lerp(arg_20_1.var_.oldValueTypewriter, var_23_8, var_23_13)
				arg_20_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_20_1.fswtw_:SetDirty()
			end

			if arg_20_1.time_ >= var_23_3 + var_23_12 and arg_20_1.time_ < var_23_3 + var_23_12 + arg_23_0 then
				arg_20_1.fswtw_.percent = var_23_8

				arg_20_1.fswtw_:SetDirty()
				arg_20_1:ShowNextGo(true)

				arg_20_1.typewritterCharCountI18N = var_23_9
			end

			local var_23_14 = 0.333
			local var_23_15 = 1
			local var_23_16 = manager.audio:GetVoiceLength("story_v_out_411051", "411051005", "story_v_out_411051.awb") / 1000

			if var_23_16 > 0 and var_23_15 < var_23_16 and var_23_16 + var_23_14 > arg_20_1.duration_ then
				local var_23_17 = var_23_16

				arg_20_1.duration_ = var_23_16 + var_23_14
			end

			if var_23_14 < arg_20_1.time_ and arg_20_1.time_ <= var_23_14 + arg_23_0 then
				local var_23_18 = "play"
				local var_23_19 = "voice"

				arg_20_1:AudioAction(var_23_18, var_23_19, "story_v_out_411051", "411051005", "story_v_out_411051.awb")
			end

			local var_23_20 = 0.333
			local var_23_21 = 0.366666666666667

			if var_23_20 < arg_20_1.time_ and arg_20_1.time_ <= var_23_20 + arg_23_0 then
				local var_23_22 = "play"
				local var_23_23 = "music"

				arg_20_1:AudioAction(var_23_22, var_23_23, "ui_battle", "ui_battle_stopbgm", "")

				local var_23_24 = ""
				local var_23_25 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_23_25 ~= "" then
					if arg_20_1.bgmTxt_.text ~= var_23_25 and arg_20_1.bgmTxt_.text ~= "" then
						if arg_20_1.bgmTxt2_.text ~= "" then
							arg_20_1.bgmTxt_.text = arg_20_1.bgmTxt2_.text
						end

						arg_20_1.bgmTxt2_.text = var_23_25

						arg_20_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_20_1.bgmTxt_.text = var_23_25
						arg_20_1.bgmTxt2_.text = var_23_25
					end

					if arg_20_1.bgmTimer then
						arg_20_1.bgmTimer:Stop()

						arg_20_1.bgmTimer = nil
					end

					if arg_20_1.settingData.show_music_name == 1 then
						arg_20_1.musicController:SetSelectedState("show")
						arg_20_1.musicAnimator_:Play("open", 0, 0)

						if arg_20_1.settingData.music_time ~= 0 then
							arg_20_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_20_1.settingData.music_time), function()
								if arg_20_1 == nil or isNil(arg_20_1.bgmTxt_) then
									return
								end

								arg_20_1.musicController:SetSelectedState("hide")
								arg_20_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_23_26 = 0.833
			local var_23_27 = 1

			if var_23_26 < arg_20_1.time_ and arg_20_1.time_ <= var_23_26 + arg_23_0 then
				local var_23_28 = "play"
				local var_23_29 = "music"

				arg_20_1:AudioAction(var_23_28, var_23_29, "bgm_activity_3_0_story_sad", "bgm_activity_3_0_story_sad", "bgm_activity_3_0_story_sad.awb")

				local var_23_30 = ""
				local var_23_31 = manager.audio:GetAudioName("bgm_activity_3_0_story_sad", "bgm_activity_3_0_story_sad")

				if var_23_31 ~= "" then
					if arg_20_1.bgmTxt_.text ~= var_23_31 and arg_20_1.bgmTxt_.text ~= "" then
						if arg_20_1.bgmTxt2_.text ~= "" then
							arg_20_1.bgmTxt_.text = arg_20_1.bgmTxt2_.text
						end

						arg_20_1.bgmTxt2_.text = var_23_31

						arg_20_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_20_1.bgmTxt_.text = var_23_31
						arg_20_1.bgmTxt2_.text = var_23_31
					end

					if arg_20_1.bgmTimer then
						arg_20_1.bgmTimer:Stop()

						arg_20_1.bgmTimer = nil
					end

					if arg_20_1.settingData.show_music_name == 1 then
						arg_20_1.musicController:SetSelectedState("show")
						arg_20_1.musicAnimator_:Play("open", 0, 0)

						if arg_20_1.settingData.music_time ~= 0 then
							arg_20_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_20_1.settingData.music_time), function()
								if arg_20_1 == nil or isNil(arg_20_1.bgmTxt_) then
									return
								end

								arg_20_1.musicController:SetSelectedState("hide")
								arg_20_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_23_32 = "STblack"

			if arg_20_1.bgs_[var_23_32] == nil then
				local var_23_33 = Object.Instantiate(arg_20_1.paintGo_)

				var_23_33:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_23_32)
				var_23_33.name = var_23_32
				var_23_33.transform.parent = arg_20_1.stage_.transform
				var_23_33.transform.localPosition = Vector3.New(0, 100, 0)
				arg_20_1.bgs_[var_23_32] = var_23_33
			end

			local var_23_34 = 0

			if var_23_34 < arg_20_1.time_ and arg_20_1.time_ <= var_23_34 + arg_23_0 then
				local var_23_35 = manager.ui.mainCamera.transform.localPosition
				local var_23_36 = Vector3.New(0, 0, 10) + Vector3.New(var_23_35.x, var_23_35.y, 0)
				local var_23_37 = arg_20_1.bgs_.STblack

				var_23_37.transform.localPosition = var_23_36
				var_23_37.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_23_38 = var_23_37:GetComponent("SpriteRenderer")

				if var_23_38 and var_23_38.sprite then
					local var_23_39 = (var_23_37.transform.localPosition - var_23_35).z
					local var_23_40 = manager.ui.mainCameraCom_
					local var_23_41 = 2 * var_23_39 * Mathf.Tan(var_23_40.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_23_42 = var_23_41 * var_23_40.aspect
					local var_23_43 = var_23_38.sprite.bounds.size.x
					local var_23_44 = var_23_38.sprite.bounds.size.y
					local var_23_45 = var_23_42 / var_23_43
					local var_23_46 = var_23_41 / var_23_44
					local var_23_47 = var_23_46 < var_23_45 and var_23_45 or var_23_46

					var_23_37.transform.localScale = Vector3.New(var_23_47, var_23_47, 0)
				end

				for iter_23_0, iter_23_1 in pairs(arg_20_1.bgs_) do
					if iter_23_0 ~= "STblack" then
						iter_23_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_23_48 = 0

			if var_23_48 < arg_20_1.time_ and arg_20_1.time_ <= var_23_48 + arg_23_0 then
				local var_23_49 = arg_20_1.fswbg_.transform:Find("textbox/adapt/content") or arg_20_1.fswbg_.transform:Find("textbox/content")
				local var_23_50 = arg_20_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_23_51 = var_23_49:GetComponent("Text")
				local var_23_52 = var_23_49:GetComponent("RectTransform")

				var_23_51.alignment = UnityEngine.TextAnchor.MiddleLeft
				var_23_52.offsetMin = Vector2.New(5.15, -270.1)
				var_23_52.offsetMax = Vector2.New(16.28, 6.8)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play411051006 = function(arg_26_0, arg_26_1)
		arg_26_1.time_ = 0
		arg_26_1.frameCnt_ = 0
		arg_26_1.state_ = "playing"
		arg_26_1.curTalkId_ = 411051006
		arg_26_1.duration_ = 3.2

		SetActive(arg_26_1.tipsGo_, false)

		function arg_26_1.onSingleLineFinish_()
			arg_26_1.onSingleLineUpdate_ = nil
			arg_26_1.onSingleLineFinish_ = nil
			arg_26_1.state_ = "waiting"
		end

		function arg_26_1.playNext_(arg_28_0)
			if arg_28_0 == 1 then
				arg_26_0:Play411051007(arg_26_1)
			end
		end

		function arg_26_1.onSingleLineUpdate_(arg_29_0)
			local var_29_0 = 0

			if var_29_0 < arg_26_1.time_ and arg_26_1.time_ <= var_29_0 + arg_29_0 then
				arg_26_1.var_.oldValueTypewriter = arg_26_1.fswtw_.percent

				SetActive(arg_26_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_26_1:ShowNextGo(false)
			end

			local var_29_1 = 64
			local var_29_2 = 3.2
			local var_29_3 = arg_26_1:GetWordFromCfg(411051005)
			local var_29_4 = arg_26_1:FormatText(var_29_3.content)
			local var_29_5, var_29_6 = arg_26_1:GetPercentByPara(var_29_4, 2)

			if var_29_0 < arg_26_1.time_ and arg_26_1.time_ <= var_29_0 + arg_29_0 then
				arg_26_1.talkMaxDuration = 0

				local var_29_7 = var_29_1 <= 0 and var_29_2 or var_29_2 * ((var_29_6 - arg_26_1.typewritterCharCountI18N) / var_29_1)

				if var_29_7 > 0 and var_29_2 < var_29_7 then
					arg_26_1.talkMaxDuration = var_29_7

					if var_29_7 + var_29_0 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_7 + var_29_0
					end
				end
			end

			local var_29_8 = 3.2
			local var_29_9 = math.max(var_29_8, arg_26_1.talkMaxDuration)

			if var_29_0 <= arg_26_1.time_ and arg_26_1.time_ < var_29_0 + var_29_9 then
				local var_29_10 = (arg_26_1.time_ - var_29_0) / var_29_9

				arg_26_1.fswtw_.percent = Mathf.Lerp(arg_26_1.var_.oldValueTypewriter, var_29_5, var_29_10)
				arg_26_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_26_1.fswtw_:SetDirty()
			end

			if arg_26_1.time_ >= var_29_0 + var_29_9 and arg_26_1.time_ < var_29_0 + var_29_9 + arg_29_0 then
				arg_26_1.fswtw_.percent = var_29_5

				arg_26_1.fswtw_:SetDirty()
				arg_26_1:ShowNextGo(true)

				arg_26_1.typewritterCharCountI18N = var_29_6
			end

			local var_29_11 = 0
			local var_29_12 = 1
			local var_29_13 = manager.audio:GetVoiceLength("story_v_out_411051", "411051006", "story_v_out_411051.awb") / 1000

			if var_29_13 > 0 and var_29_12 < var_29_13 and var_29_13 + var_29_11 > arg_26_1.duration_ then
				local var_29_14 = var_29_13

				arg_26_1.duration_ = var_29_13 + var_29_11
			end

			if var_29_11 < arg_26_1.time_ and arg_26_1.time_ <= var_29_11 + arg_29_0 then
				local var_29_15 = "play"
				local var_29_16 = "voice"

				arg_26_1:AudioAction(var_29_15, var_29_16, "story_v_out_411051", "411051006", "story_v_out_411051.awb")
			end
		end

		arg_26_1.nodeConfigList_ = {}

		arg_26_1:InitPlayNodeList()
	end,
	Play411051007 = function(arg_30_0, arg_30_1)
		arg_30_1.time_ = 0
		arg_30_1.frameCnt_ = 0
		arg_30_1.state_ = "playing"
		arg_30_1.curTalkId_ = 411051007
		arg_30_1.duration_ = 2.47

		SetActive(arg_30_1.tipsGo_, false)

		function arg_30_1.onSingleLineFinish_()
			arg_30_1.onSingleLineUpdate_ = nil
			arg_30_1.onSingleLineFinish_ = nil
			arg_30_1.state_ = "waiting"
		end

		function arg_30_1.playNext_(arg_32_0)
			if arg_32_0 == 1 then
				arg_30_0:Play411051008(arg_30_1)
			end
		end

		function arg_30_1.onSingleLineUpdate_(arg_33_0)
			local var_33_0 = 0

			if var_33_0 < arg_30_1.time_ and arg_30_1.time_ <= var_33_0 + arg_33_0 then
				arg_30_1.var_.oldValueTypewriter = arg_30_1.fswtw_.percent

				SetActive(arg_30_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_30_1:ShowNextGo(false)
			end

			local var_33_1 = 37
			local var_33_2 = 2.46666666666667
			local var_33_3 = arg_30_1:GetWordFromCfg(411051005)
			local var_33_4 = arg_30_1:FormatText(var_33_3.content)
			local var_33_5, var_33_6 = arg_30_1:GetPercentByPara(var_33_4, 3)

			if var_33_0 < arg_30_1.time_ and arg_30_1.time_ <= var_33_0 + arg_33_0 then
				arg_30_1.talkMaxDuration = 0

				local var_33_7 = var_33_1 <= 0 and var_33_2 or var_33_2 * ((var_33_6 - arg_30_1.typewritterCharCountI18N) / var_33_1)

				if var_33_7 > 0 and var_33_2 < var_33_7 then
					arg_30_1.talkMaxDuration = var_33_7

					if var_33_7 + var_33_0 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_7 + var_33_0
					end
				end
			end

			local var_33_8 = 2.46666666666667
			local var_33_9 = math.max(var_33_8, arg_30_1.talkMaxDuration)

			if var_33_0 <= arg_30_1.time_ and arg_30_1.time_ < var_33_0 + var_33_9 then
				local var_33_10 = (arg_30_1.time_ - var_33_0) / var_33_9

				arg_30_1.fswtw_.percent = Mathf.Lerp(arg_30_1.var_.oldValueTypewriter, var_33_5, var_33_10)
				arg_30_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_30_1.fswtw_:SetDirty()
			end

			if arg_30_1.time_ >= var_33_0 + var_33_9 and arg_30_1.time_ < var_33_0 + var_33_9 + arg_33_0 then
				arg_30_1.fswtw_.percent = var_33_5

				arg_30_1.fswtw_:SetDirty()
				arg_30_1:ShowNextGo(true)

				arg_30_1.typewritterCharCountI18N = var_33_6
			end

			local var_33_11 = 0
			local var_33_12 = 1
			local var_33_13 = manager.audio:GetVoiceLength("story_v_out_411051", "411051007", "story_v_out_411051.awb") / 1000

			if var_33_13 > 0 and var_33_12 < var_33_13 and var_33_13 + var_33_11 > arg_30_1.duration_ then
				local var_33_14 = var_33_13

				arg_30_1.duration_ = var_33_13 + var_33_11
			end

			if var_33_11 < arg_30_1.time_ and arg_30_1.time_ <= var_33_11 + arg_33_0 then
				local var_33_15 = "play"
				local var_33_16 = "voice"

				arg_30_1:AudioAction(var_33_15, var_33_16, "story_v_out_411051", "411051007", "story_v_out_411051.awb")
			end
		end

		arg_30_1.nodeConfigList_ = {}

		arg_30_1:InitPlayNodeList()
	end,
	Play411051008 = function(arg_34_0, arg_34_1)
		arg_34_1.time_ = 0
		arg_34_1.frameCnt_ = 0
		arg_34_1.state_ = "playing"
		arg_34_1.curTalkId_ = 411051008
		arg_34_1.duration_ = 2.67

		SetActive(arg_34_1.tipsGo_, false)

		function arg_34_1.onSingleLineFinish_()
			arg_34_1.onSingleLineUpdate_ = nil
			arg_34_1.onSingleLineFinish_ = nil
			arg_34_1.state_ = "waiting"
		end

		function arg_34_1.playNext_(arg_36_0)
			if arg_36_0 == 1 then
				arg_34_0:Play411051009(arg_34_1)
			end
		end

		function arg_34_1.onSingleLineUpdate_(arg_37_0)
			local var_37_0 = 0

			if var_37_0 < arg_34_1.time_ and arg_34_1.time_ <= var_37_0 + arg_37_0 then
				arg_34_1.var_.oldValueTypewriter = arg_34_1.fswtw_.percent

				SetActive(arg_34_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_34_1:ShowNextGo(false)
			end

			local var_37_1 = 40
			local var_37_2 = 2.66666666666667
			local var_37_3 = arg_34_1:GetWordFromCfg(411051005)
			local var_37_4 = arg_34_1:FormatText(var_37_3.content)
			local var_37_5, var_37_6 = arg_34_1:GetPercentByPara(var_37_4, 4)

			if var_37_0 < arg_34_1.time_ and arg_34_1.time_ <= var_37_0 + arg_37_0 then
				arg_34_1.talkMaxDuration = 0

				local var_37_7 = var_37_1 <= 0 and var_37_2 or var_37_2 * ((var_37_6 - arg_34_1.typewritterCharCountI18N) / var_37_1)

				if var_37_7 > 0 and var_37_2 < var_37_7 then
					arg_34_1.talkMaxDuration = var_37_7

					if var_37_7 + var_37_0 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_7 + var_37_0
					end
				end
			end

			local var_37_8 = 2.66666666666667
			local var_37_9 = math.max(var_37_8, arg_34_1.talkMaxDuration)

			if var_37_0 <= arg_34_1.time_ and arg_34_1.time_ < var_37_0 + var_37_9 then
				local var_37_10 = (arg_34_1.time_ - var_37_0) / var_37_9

				arg_34_1.fswtw_.percent = Mathf.Lerp(arg_34_1.var_.oldValueTypewriter, var_37_5, var_37_10)
				arg_34_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_34_1.fswtw_:SetDirty()
			end

			if arg_34_1.time_ >= var_37_0 + var_37_9 and arg_34_1.time_ < var_37_0 + var_37_9 + arg_37_0 then
				arg_34_1.fswtw_.percent = var_37_5

				arg_34_1.fswtw_:SetDirty()
				arg_34_1:ShowNextGo(true)

				arg_34_1.typewritterCharCountI18N = var_37_6
			end

			local var_37_11 = 0
			local var_37_12 = 1
			local var_37_13 = manager.audio:GetVoiceLength("story_v_out_411051", "411051008", "story_v_out_411051.awb") / 1000

			if var_37_13 > 0 and var_37_12 < var_37_13 and var_37_13 + var_37_11 > arg_34_1.duration_ then
				local var_37_14 = var_37_13

				arg_34_1.duration_ = var_37_13 + var_37_11
			end

			if var_37_11 < arg_34_1.time_ and arg_34_1.time_ <= var_37_11 + arg_37_0 then
				local var_37_15 = "play"
				local var_37_16 = "voice"

				arg_34_1:AudioAction(var_37_15, var_37_16, "story_v_out_411051", "411051008", "story_v_out_411051.awb")
			end
		end

		arg_34_1.nodeConfigList_ = {}

		arg_34_1:InitPlayNodeList()
	end,
	Play411051009 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 411051009
		arg_38_1.duration_ = 5

		SetActive(arg_38_1.tipsGo_, false)

		function arg_38_1.onSingleLineFinish_()
			arg_38_1.onSingleLineUpdate_ = nil
			arg_38_1.onSingleLineFinish_ = nil
			arg_38_1.state_ = "waiting"
		end

		function arg_38_1.playNext_(arg_40_0)
			if arg_40_0 == 1 then
				arg_38_0:Play411051010(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			local var_41_0 = 0

			if var_41_0 < arg_38_1.time_ and arg_38_1.time_ <= var_41_0 + arg_41_0 then
				arg_38_1.fswbg_:SetActive(true)
				arg_38_1.dialog_:SetActive(false)

				arg_38_1.fswtw_.percent = 0

				local var_41_1 = arg_38_1:GetWordFromCfg(411051009)
				local var_41_2 = arg_38_1:FormatText(var_41_1.content)

				arg_38_1.fswt_.text = var_41_2

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.fswt_)

				arg_38_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_38_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_38_1.fswtw_:SetDirty()

				arg_38_1.typewritterCharCountI18N = 0

				SetActive(arg_38_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_38_1:ShowNextGo(false)
			end

			local var_41_3 = 0.666666666666667

			if var_41_3 < arg_38_1.time_ and arg_38_1.time_ <= var_41_3 + arg_41_0 then
				arg_38_1.var_.oldValueTypewriter = arg_38_1.fswtw_.percent

				SetActive(arg_38_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_38_1:ShowNextGo(false)
			end

			local var_41_4 = 9
			local var_41_5 = 0.6
			local var_41_6 = arg_38_1:GetWordFromCfg(411051009)
			local var_41_7 = arg_38_1:FormatText(var_41_6.content)
			local var_41_8, var_41_9 = arg_38_1:GetPercentByPara(var_41_7, 1)

			if var_41_3 < arg_38_1.time_ and arg_38_1.time_ <= var_41_3 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0

				local var_41_10 = var_41_4 <= 0 and var_41_5 or var_41_5 * ((var_41_9 - arg_38_1.typewritterCharCountI18N) / var_41_4)

				if var_41_10 > 0 and var_41_5 < var_41_10 then
					arg_38_1.talkMaxDuration = var_41_10

					if var_41_10 + var_41_3 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_10 + var_41_3
					end
				end
			end

			local var_41_11 = 0.6
			local var_41_12 = math.max(var_41_11, arg_38_1.talkMaxDuration)

			if var_41_3 <= arg_38_1.time_ and arg_38_1.time_ < var_41_3 + var_41_12 then
				local var_41_13 = (arg_38_1.time_ - var_41_3) / var_41_12

				arg_38_1.fswtw_.percent = Mathf.Lerp(arg_38_1.var_.oldValueTypewriter, var_41_8, var_41_13)
				arg_38_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_38_1.fswtw_:SetDirty()
			end

			if arg_38_1.time_ >= var_41_3 + var_41_12 and arg_38_1.time_ < var_41_3 + var_41_12 + arg_41_0 then
				arg_38_1.fswtw_.percent = var_41_8

				arg_38_1.fswtw_:SetDirty()
				arg_38_1:ShowNextGo(true)

				arg_38_1.typewritterCharCountI18N = var_41_9
			end

			local var_41_14 = 0.5
			local var_41_15 = 1
			local var_41_16 = manager.audio:GetVoiceLength("story_v_out_411051", "411051009", "story_v_out_411051.awb") / 1000

			if var_41_16 > 0 and var_41_15 < var_41_16 and var_41_16 + var_41_14 > arg_38_1.duration_ then
				local var_41_17 = var_41_16

				arg_38_1.duration_ = var_41_16 + var_41_14
			end

			if var_41_14 < arg_38_1.time_ and arg_38_1.time_ <= var_41_14 + arg_41_0 then
				local var_41_18 = "play"
				local var_41_19 = "voice"

				arg_38_1:AudioAction(var_41_18, var_41_19, "story_v_out_411051", "411051009", "story_v_out_411051.awb")
			end

			local var_41_20 = 0

			if var_41_20 < arg_38_1.time_ and arg_38_1.time_ <= var_41_20 + arg_41_0 then
				local var_41_21 = arg_38_1.fswbg_.transform:Find("textbox/adapt/content") or arg_38_1.fswbg_.transform:Find("textbox/content")
				local var_41_22 = arg_38_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_41_23 = var_41_21:GetComponent("Text")
				local var_41_24 = var_41_21:GetComponent("RectTransform")

				var_41_23.alignment = UnityEngine.TextAnchor.MiddleLeft
				var_41_24.offsetMin = Vector2.New(5.15, -270.1)
				var_41_24.offsetMax = Vector2.New(49.67, 6.8)
			end
		end

		arg_38_1.nodeConfigList_ = {}

		arg_38_1:InitPlayNodeList()
	end,
	Play411051010 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 411051010
		arg_42_1.duration_ = 1.4

		SetActive(arg_42_1.tipsGo_, false)

		function arg_42_1.onSingleLineFinish_()
			arg_42_1.onSingleLineUpdate_ = nil
			arg_42_1.onSingleLineFinish_ = nil
			arg_42_1.state_ = "waiting"
		end

		function arg_42_1.playNext_(arg_44_0)
			if arg_44_0 == 1 then
				arg_42_0:Play411051011(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			local var_45_0 = 0

			if var_45_0 < arg_42_1.time_ and arg_42_1.time_ <= var_45_0 + arg_45_0 then
				arg_42_1.var_.oldValueTypewriter = arg_42_1.fswtw_.percent

				SetActive(arg_42_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_42_1:ShowNextGo(false)
			end

			local var_45_1 = 21
			local var_45_2 = 1.4
			local var_45_3 = arg_42_1:GetWordFromCfg(411051009)
			local var_45_4 = arg_42_1:FormatText(var_45_3.content)
			local var_45_5, var_45_6 = arg_42_1:GetPercentByPara(var_45_4, 2)

			if var_45_0 < arg_42_1.time_ and arg_42_1.time_ <= var_45_0 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0

				local var_45_7 = var_45_1 <= 0 and var_45_2 or var_45_2 * ((var_45_6 - arg_42_1.typewritterCharCountI18N) / var_45_1)

				if var_45_7 > 0 and var_45_2 < var_45_7 then
					arg_42_1.talkMaxDuration = var_45_7

					if var_45_7 + var_45_0 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_7 + var_45_0
					end
				end
			end

			local var_45_8 = 1.4
			local var_45_9 = math.max(var_45_8, arg_42_1.talkMaxDuration)

			if var_45_0 <= arg_42_1.time_ and arg_42_1.time_ < var_45_0 + var_45_9 then
				local var_45_10 = (arg_42_1.time_ - var_45_0) / var_45_9

				arg_42_1.fswtw_.percent = Mathf.Lerp(arg_42_1.var_.oldValueTypewriter, var_45_5, var_45_10)
				arg_42_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_42_1.fswtw_:SetDirty()
			end

			if arg_42_1.time_ >= var_45_0 + var_45_9 and arg_42_1.time_ < var_45_0 + var_45_9 + arg_45_0 then
				arg_42_1.fswtw_.percent = var_45_5

				arg_42_1.fswtw_:SetDirty()
				arg_42_1:ShowNextGo(true)

				arg_42_1.typewritterCharCountI18N = var_45_6
			end

			local var_45_11 = 0
			local var_45_12 = 1
			local var_45_13 = manager.audio:GetVoiceLength("story_v_out_411051", "411051010", "story_v_out_411051.awb") / 1000

			if var_45_13 > 0 and var_45_12 < var_45_13 and var_45_13 + var_45_11 > arg_42_1.duration_ then
				local var_45_14 = var_45_13

				arg_42_1.duration_ = var_45_13 + var_45_11
			end

			if var_45_11 < arg_42_1.time_ and arg_42_1.time_ <= var_45_11 + arg_45_0 then
				local var_45_15 = "play"
				local var_45_16 = "voice"

				arg_42_1:AudioAction(var_45_15, var_45_16, "story_v_out_411051", "411051010", "story_v_out_411051.awb")
			end
		end

		arg_42_1.nodeConfigList_ = {}

		arg_42_1:InitPlayNodeList()
	end,
	Play411051011 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 411051011
		arg_46_1.duration_ = 3.27

		SetActive(arg_46_1.tipsGo_, false)

		function arg_46_1.onSingleLineFinish_()
			arg_46_1.onSingleLineUpdate_ = nil
			arg_46_1.onSingleLineFinish_ = nil
			arg_46_1.state_ = "waiting"
		end

		function arg_46_1.playNext_(arg_48_0)
			if arg_48_0 == 1 then
				arg_46_0:Play411051012(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			local var_49_0 = 0

			if var_49_0 < arg_46_1.time_ and arg_46_1.time_ <= var_49_0 + arg_49_0 then
				arg_46_1.var_.oldValueTypewriter = arg_46_1.fswtw_.percent

				SetActive(arg_46_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_46_1:ShowNextGo(false)
			end

			local var_49_1 = 49
			local var_49_2 = 3.26666666666667
			local var_49_3 = arg_46_1:GetWordFromCfg(411051009)
			local var_49_4 = arg_46_1:FormatText(var_49_3.content)
			local var_49_5, var_49_6 = arg_46_1:GetPercentByPara(var_49_4, 3)

			if var_49_0 < arg_46_1.time_ and arg_46_1.time_ <= var_49_0 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0

				local var_49_7 = var_49_1 <= 0 and var_49_2 or var_49_2 * ((var_49_6 - arg_46_1.typewritterCharCountI18N) / var_49_1)

				if var_49_7 > 0 and var_49_2 < var_49_7 then
					arg_46_1.talkMaxDuration = var_49_7

					if var_49_7 + var_49_0 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_7 + var_49_0
					end
				end
			end

			local var_49_8 = 3.26666666666667
			local var_49_9 = math.max(var_49_8, arg_46_1.talkMaxDuration)

			if var_49_0 <= arg_46_1.time_ and arg_46_1.time_ < var_49_0 + var_49_9 then
				local var_49_10 = (arg_46_1.time_ - var_49_0) / var_49_9

				arg_46_1.fswtw_.percent = Mathf.Lerp(arg_46_1.var_.oldValueTypewriter, var_49_5, var_49_10)
				arg_46_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_46_1.fswtw_:SetDirty()
			end

			if arg_46_1.time_ >= var_49_0 + var_49_9 and arg_46_1.time_ < var_49_0 + var_49_9 + arg_49_0 then
				arg_46_1.fswtw_.percent = var_49_5

				arg_46_1.fswtw_:SetDirty()
				arg_46_1:ShowNextGo(true)

				arg_46_1.typewritterCharCountI18N = var_49_6
			end

			local var_49_11 = 0
			local var_49_12 = 1
			local var_49_13 = manager.audio:GetVoiceLength("story_v_out_411051", "411051011", "story_v_out_411051.awb") / 1000

			if var_49_13 > 0 and var_49_12 < var_49_13 and var_49_13 + var_49_11 > arg_46_1.duration_ then
				local var_49_14 = var_49_13

				arg_46_1.duration_ = var_49_13 + var_49_11
			end

			if var_49_11 < arg_46_1.time_ and arg_46_1.time_ <= var_49_11 + arg_49_0 then
				local var_49_15 = "play"
				local var_49_16 = "voice"

				arg_46_1:AudioAction(var_49_15, var_49_16, "story_v_out_411051", "411051011", "story_v_out_411051.awb")
			end
		end

		arg_46_1.nodeConfigList_ = {}

		arg_46_1:InitPlayNodeList()
	end,
	Play411051012 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 411051012
		arg_50_1.duration_ = 1.2

		SetActive(arg_50_1.tipsGo_, false)

		function arg_50_1.onSingleLineFinish_()
			arg_50_1.onSingleLineUpdate_ = nil
			arg_50_1.onSingleLineFinish_ = nil
			arg_50_1.state_ = "waiting"
		end

		function arg_50_1.playNext_(arg_52_0)
			if arg_52_0 == 1 then
				arg_50_0:Play411051013(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			local var_53_0 = 0

			if var_53_0 < arg_50_1.time_ and arg_50_1.time_ <= var_53_0 + arg_53_0 then
				arg_50_1.var_.oldValueTypewriter = arg_50_1.fswtw_.percent

				SetActive(arg_50_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_50_1:ShowNextGo(false)
			end

			local var_53_1 = 18
			local var_53_2 = 1.2
			local var_53_3 = arg_50_1:GetWordFromCfg(411051009)
			local var_53_4 = arg_50_1:FormatText(var_53_3.content)
			local var_53_5, var_53_6 = arg_50_1:GetPercentByPara(var_53_4, 4)

			if var_53_0 < arg_50_1.time_ and arg_50_1.time_ <= var_53_0 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0

				local var_53_7 = var_53_1 <= 0 and var_53_2 or var_53_2 * ((var_53_6 - arg_50_1.typewritterCharCountI18N) / var_53_1)

				if var_53_7 > 0 and var_53_2 < var_53_7 then
					arg_50_1.talkMaxDuration = var_53_7

					if var_53_7 + var_53_0 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_7 + var_53_0
					end
				end
			end

			local var_53_8 = 1.2
			local var_53_9 = math.max(var_53_8, arg_50_1.talkMaxDuration)

			if var_53_0 <= arg_50_1.time_ and arg_50_1.time_ < var_53_0 + var_53_9 then
				local var_53_10 = (arg_50_1.time_ - var_53_0) / var_53_9

				arg_50_1.fswtw_.percent = Mathf.Lerp(arg_50_1.var_.oldValueTypewriter, var_53_5, var_53_10)
				arg_50_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_50_1.fswtw_:SetDirty()
			end

			if arg_50_1.time_ >= var_53_0 + var_53_9 and arg_50_1.time_ < var_53_0 + var_53_9 + arg_53_0 then
				arg_50_1.fswtw_.percent = var_53_5

				arg_50_1.fswtw_:SetDirty()
				arg_50_1:ShowNextGo(true)

				arg_50_1.typewritterCharCountI18N = var_53_6
			end

			local var_53_11 = 0
			local var_53_12 = 1
			local var_53_13 = manager.audio:GetVoiceLength("story_v_out_411051", "411051012", "story_v_out_411051.awb") / 1000

			if var_53_13 > 0 and var_53_12 < var_53_13 and var_53_13 + var_53_11 > arg_50_1.duration_ then
				local var_53_14 = var_53_13

				arg_50_1.duration_ = var_53_13 + var_53_11
			end

			if var_53_11 < arg_50_1.time_ and arg_50_1.time_ <= var_53_11 + arg_53_0 then
				local var_53_15 = "play"
				local var_53_16 = "voice"

				arg_50_1:AudioAction(var_53_15, var_53_16, "story_v_out_411051", "411051012", "story_v_out_411051.awb")
			end
		end

		arg_50_1.nodeConfigList_ = {}

		arg_50_1:InitPlayNodeList()
	end,
	Play411051013 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 411051013
		arg_54_1.duration_ = 8.63

		local var_54_0 = {
			zh = 8.63400000184774,
			ja = 4.53400000184774
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
				arg_54_0:Play411051014(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			local var_57_0 = "10058ui_story"

			if arg_54_1.actors_[var_57_0] == nil then
				local var_57_1 = Asset.Load("Char/" .. "10058ui_story")

				if not isNil(var_57_1) then
					local var_57_2 = Object.Instantiate(Asset.Load("Char/" .. "10058ui_story"), arg_54_1.stage_.transform)

					var_57_2.name = var_57_0
					var_57_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_54_1.actors_[var_57_0] = var_57_2

					local var_57_3 = var_57_2:GetComponentInChildren(typeof(CharacterEffect))

					var_57_3.enabled = true

					local var_57_4 = GameObjectTools.GetOrAddComponent(var_57_2, typeof(DynamicBoneHelper))

					if var_57_4 then
						var_57_4:EnableDynamicBone(false)
					end

					arg_54_1:ShowWeapon(var_57_3.transform, false)

					arg_54_1.var_[var_57_0 .. "Animator"] = var_57_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_54_1.var_[var_57_0 .. "Animator"].applyRootMotion = true
					arg_54_1.var_[var_57_0 .. "LipSync"] = var_57_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_57_5 = arg_54_1.actors_["10058ui_story"].transform
			local var_57_6 = 2

			if var_57_6 < arg_54_1.time_ and arg_54_1.time_ <= var_57_6 + arg_57_0 then
				arg_54_1.var_.moveOldPos10058ui_story = var_57_5.localPosition
			end

			local var_57_7 = 0.001

			if var_57_6 <= arg_54_1.time_ and arg_54_1.time_ < var_57_6 + var_57_7 then
				local var_57_8 = (arg_54_1.time_ - var_57_6) / var_57_7
				local var_57_9 = Vector3.New(0, -0.98, -6.1)

				var_57_5.localPosition = Vector3.Lerp(arg_54_1.var_.moveOldPos10058ui_story, var_57_9, var_57_8)

				local var_57_10 = manager.ui.mainCamera.transform.position - var_57_5.position

				var_57_5.forward = Vector3.New(var_57_10.x, var_57_10.y, var_57_10.z)

				local var_57_11 = var_57_5.localEulerAngles

				var_57_11.z = 0
				var_57_11.x = 0
				var_57_5.localEulerAngles = var_57_11
			end

			if arg_54_1.time_ >= var_57_6 + var_57_7 and arg_54_1.time_ < var_57_6 + var_57_7 + arg_57_0 then
				var_57_5.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_57_12 = manager.ui.mainCamera.transform.position - var_57_5.position

				var_57_5.forward = Vector3.New(var_57_12.x, var_57_12.y, var_57_12.z)

				local var_57_13 = var_57_5.localEulerAngles

				var_57_13.z = 0
				var_57_13.x = 0
				var_57_5.localEulerAngles = var_57_13
			end

			local var_57_14 = arg_54_1.actors_["10058ui_story"]
			local var_57_15 = 2

			if var_57_15 < arg_54_1.time_ and arg_54_1.time_ <= var_57_15 + arg_57_0 and not isNil(var_57_14) and arg_54_1.var_.characterEffect10058ui_story == nil then
				arg_54_1.var_.characterEffect10058ui_story = var_57_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_57_16 = 0.200000002980232

			if var_57_15 <= arg_54_1.time_ and arg_54_1.time_ < var_57_15 + var_57_16 and not isNil(var_57_14) then
				local var_57_17 = (arg_54_1.time_ - var_57_15) / var_57_16

				if arg_54_1.var_.characterEffect10058ui_story and not isNil(var_57_14) then
					arg_54_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_54_1.time_ >= var_57_15 + var_57_16 and arg_54_1.time_ < var_57_15 + var_57_16 + arg_57_0 and not isNil(var_57_14) and arg_54_1.var_.characterEffect10058ui_story then
				arg_54_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_57_18 = 2

			if var_57_18 < arg_54_1.time_ and arg_54_1.time_ <= var_57_18 + arg_57_0 then
				arg_54_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_57_19 = 2

			if var_57_19 < arg_54_1.time_ and arg_54_1.time_ <= var_57_19 + arg_57_0 then
				arg_54_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_57_20 = 0.766666669646899

			if var_57_20 < arg_54_1.time_ and arg_54_1.time_ <= var_57_20 + arg_57_0 then
				arg_54_1.fswbg_:SetActive(false)
				arg_54_1.dialog_:SetActive(false)
				SetActive(arg_54_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_54_1:ShowNextGo(false)
			end

			local var_57_21 = 0.766666669646899

			if var_57_21 < arg_54_1.time_ and arg_54_1.time_ <= var_57_21 + arg_57_0 then
				local var_57_22 = manager.ui.mainCamera.transform.localPosition
				local var_57_23 = Vector3.New(0, 0, 10) + Vector3.New(var_57_22.x, var_57_22.y, 0)
				local var_57_24 = arg_54_1.bgs_.ST74

				var_57_24.transform.localPosition = var_57_23
				var_57_24.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_57_25 = var_57_24:GetComponent("SpriteRenderer")

				if var_57_25 and var_57_25.sprite then
					local var_57_26 = (var_57_24.transform.localPosition - var_57_22).z
					local var_57_27 = manager.ui.mainCameraCom_
					local var_57_28 = 2 * var_57_26 * Mathf.Tan(var_57_27.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_57_29 = var_57_28 * var_57_27.aspect
					local var_57_30 = var_57_25.sprite.bounds.size.x
					local var_57_31 = var_57_25.sprite.bounds.size.y
					local var_57_32 = var_57_29 / var_57_30
					local var_57_33 = var_57_28 / var_57_31
					local var_57_34 = var_57_33 < var_57_32 and var_57_32 or var_57_33

					var_57_24.transform.localScale = Vector3.New(var_57_34, var_57_34, 0)
				end

				for iter_57_0, iter_57_1 in pairs(arg_54_1.bgs_) do
					if iter_57_0 ~= "ST74" then
						iter_57_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_57_35 = 0

			if var_57_35 < arg_54_1.time_ and arg_54_1.time_ <= var_57_35 + arg_57_0 then
				arg_54_1.mask_.enabled = true
				arg_54_1.mask_.raycastTarget = true

				arg_54_1:SetGaussion(false)
			end

			local var_57_36 = 0.766666669646899

			if var_57_35 <= arg_54_1.time_ and arg_54_1.time_ < var_57_35 + var_57_36 then
				local var_57_37 = (arg_54_1.time_ - var_57_35) / var_57_36
				local var_57_38 = Color.New(0, 0, 0)

				var_57_38.a = Mathf.Lerp(0, 1, var_57_37)
				arg_54_1.mask_.color = var_57_38
			end

			if arg_54_1.time_ >= var_57_35 + var_57_36 and arg_54_1.time_ < var_57_35 + var_57_36 + arg_57_0 then
				local var_57_39 = Color.New(0, 0, 0)

				var_57_39.a = 1
				arg_54_1.mask_.color = var_57_39
			end

			local var_57_40 = 0.766666669646899

			if var_57_40 < arg_54_1.time_ and arg_54_1.time_ <= var_57_40 + arg_57_0 then
				arg_54_1.mask_.enabled = true
				arg_54_1.mask_.raycastTarget = true

				arg_54_1:SetGaussion(false)
			end

			local var_57_41 = 1.33333333333333

			if var_57_40 <= arg_54_1.time_ and arg_54_1.time_ < var_57_40 + var_57_41 then
				local var_57_42 = (arg_54_1.time_ - var_57_40) / var_57_41
				local var_57_43 = Color.New(0, 0, 0)

				var_57_43.a = Mathf.Lerp(1, 0, var_57_42)
				arg_54_1.mask_.color = var_57_43
			end

			if arg_54_1.time_ >= var_57_40 + var_57_41 and arg_54_1.time_ < var_57_40 + var_57_41 + arg_57_0 then
				local var_57_44 = Color.New(0, 0, 0)
				local var_57_45 = 0

				arg_54_1.mask_.enabled = false
				var_57_44.a = var_57_45
				arg_54_1.mask_.color = var_57_44
			end

			if arg_54_1.frameCnt_ <= 1 then
				arg_54_1.dialog_:SetActive(false)
			end

			local var_57_46 = 2.03400000184774
			local var_57_47 = 0.525

			if var_57_46 < arg_54_1.time_ and arg_54_1.time_ <= var_57_46 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0

				arg_54_1.dialog_:SetActive(true)

				arg_54_1.dialogCg_.alpha = 0

				local var_57_48 = LeanTween.value(arg_54_1.dialog_, 0, 1, 0.3)

				var_57_48:setOnUpdate(LuaHelper.FloatAction(function(arg_58_0)
					arg_54_1.dialogCg_.alpha = arg_58_0
				end))
				var_57_48:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_54_1.dialog_)
					var_57_48:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_54_1.duration_ = arg_54_1.duration_ + 0.3

				SetActive(arg_54_1.leftNameGo_, true)

				local var_57_49 = arg_54_1:FormatText(StoryNameCfg[695].name)

				arg_54_1.leftNameTxt_.text = var_57_49

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_54_1.leftNameTxt_.transform)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1.leftNameTxt_.text)
				SetActive(arg_54_1.iconTrs_.gameObject, false)
				arg_54_1.callingController_:SetSelectedState("normal")

				local var_57_50 = arg_54_1:GetWordFromCfg(411051013)
				local var_57_51 = arg_54_1:FormatText(var_57_50.content)

				arg_54_1.text_.text = var_57_51

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_52 = 21
				local var_57_53 = utf8.len(var_57_51)
				local var_57_54 = var_57_52 <= 0 and var_57_47 or var_57_47 * (var_57_53 / var_57_52)

				if var_57_54 > 0 and var_57_47 < var_57_54 then
					arg_54_1.talkMaxDuration = var_57_54
					var_57_46 = var_57_46 + 0.3

					if var_57_54 + var_57_46 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_54 + var_57_46
					end
				end

				arg_54_1.text_.text = var_57_51
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051013", "story_v_out_411051.awb") ~= 0 then
					local var_57_55 = manager.audio:GetVoiceLength("story_v_out_411051", "411051013", "story_v_out_411051.awb") / 1000

					if var_57_55 + var_57_46 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_55 + var_57_46
					end

					if var_57_50.prefab_name ~= "" and arg_54_1.actors_[var_57_50.prefab_name] ~= nil then
						local var_57_56 = LuaForUtil.PlayVoiceWithCriLipsync(arg_54_1.actors_[var_57_50.prefab_name].transform, "story_v_out_411051", "411051013", "story_v_out_411051.awb")

						arg_54_1:RecordAudio("411051013", var_57_56)
						arg_54_1:RecordAudio("411051013", var_57_56)
					else
						arg_54_1:AudioAction("play", "voice", "story_v_out_411051", "411051013", "story_v_out_411051.awb")
					end

					arg_54_1:RecordHistoryTalkVoice("story_v_out_411051", "411051013", "story_v_out_411051.awb")
				end

				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_57 = var_57_46 + 0.3
			local var_57_58 = math.max(var_57_47, arg_54_1.talkMaxDuration)

			if var_57_57 <= arg_54_1.time_ and arg_54_1.time_ < var_57_57 + var_57_58 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - var_57_57) / var_57_58

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= var_57_57 + var_57_58 and arg_54_1.time_ < var_57_57 + var_57_58 + arg_57_0 then
				arg_54_1.typewritter.percent = 1

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(true)
			end
		end

		arg_54_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_54_1:InitPlayNodeList()
	end,
	Play411051014 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 411051014
		arg_60_1.duration_ = 5

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play411051015(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = arg_60_1.actors_["10058ui_story"]
			local var_63_1 = 0

			if var_63_1 < arg_60_1.time_ and arg_60_1.time_ <= var_63_1 + arg_63_0 and not isNil(var_63_0) and arg_60_1.var_.characterEffect10058ui_story == nil then
				arg_60_1.var_.characterEffect10058ui_story = var_63_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_2 = 0.200000002980232

			if var_63_1 <= arg_60_1.time_ and arg_60_1.time_ < var_63_1 + var_63_2 and not isNil(var_63_0) then
				local var_63_3 = (arg_60_1.time_ - var_63_1) / var_63_2

				if arg_60_1.var_.characterEffect10058ui_story and not isNil(var_63_0) then
					local var_63_4 = Mathf.Lerp(0, 0.5, var_63_3)

					arg_60_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_60_1.var_.characterEffect10058ui_story.fillRatio = var_63_4
				end
			end

			if arg_60_1.time_ >= var_63_1 + var_63_2 and arg_60_1.time_ < var_63_1 + var_63_2 + arg_63_0 and not isNil(var_63_0) and arg_60_1.var_.characterEffect10058ui_story then
				local var_63_5 = 0.5

				arg_60_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_60_1.var_.characterEffect10058ui_story.fillRatio = var_63_5
			end

			local var_63_6 = 0
			local var_63_7 = 1.475

			if var_63_6 < arg_60_1.time_ and arg_60_1.time_ <= var_63_6 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, false)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_8 = arg_60_1:GetWordFromCfg(411051014)
				local var_63_9 = arg_60_1:FormatText(var_63_8.content)

				arg_60_1.text_.text = var_63_9

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_10 = 59
				local var_63_11 = utf8.len(var_63_9)
				local var_63_12 = var_63_10 <= 0 and var_63_7 or var_63_7 * (var_63_11 / var_63_10)

				if var_63_12 > 0 and var_63_7 < var_63_12 then
					arg_60_1.talkMaxDuration = var_63_12

					if var_63_12 + var_63_6 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_12 + var_63_6
					end
				end

				arg_60_1.text_.text = var_63_9
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)
				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_13 = math.max(var_63_7, arg_60_1.talkMaxDuration)

			if var_63_6 <= arg_60_1.time_ and arg_60_1.time_ < var_63_6 + var_63_13 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_6) / var_63_13

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_6 + var_63_13 and arg_60_1.time_ < var_63_6 + var_63_13 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play411051015 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 411051015
		arg_64_1.duration_ = 5

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play411051016(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = 0
			local var_67_1 = 0.7

			if var_67_0 < arg_64_1.time_ and arg_64_1.time_ <= var_67_0 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, false)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_2 = arg_64_1:GetWordFromCfg(411051015)
				local var_67_3 = arg_64_1:FormatText(var_67_2.content)

				arg_64_1.text_.text = var_67_3

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_4 = 28
				local var_67_5 = utf8.len(var_67_3)
				local var_67_6 = var_67_4 <= 0 and var_67_1 or var_67_1 * (var_67_5 / var_67_4)

				if var_67_6 > 0 and var_67_1 < var_67_6 then
					arg_64_1.talkMaxDuration = var_67_6

					if var_67_6 + var_67_0 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_6 + var_67_0
					end
				end

				arg_64_1.text_.text = var_67_3
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)
				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_7 = math.max(var_67_1, arg_64_1.talkMaxDuration)

			if var_67_0 <= arg_64_1.time_ and arg_64_1.time_ < var_67_0 + var_67_7 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_0) / var_67_7

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_0 + var_67_7 and arg_64_1.time_ < var_67_0 + var_67_7 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {}

		arg_64_1:InitPlayNodeList()
	end,
	Play411051016 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 411051016
		arg_68_1.duration_ = 9.1

		local var_68_0 = {
			zh = 8.633,
			ja = 9.1
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
				arg_68_0:Play411051017(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = 0
			local var_71_1 = 1.025

			if var_71_0 < arg_68_1.time_ and arg_68_1.time_ <= var_71_0 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				local var_71_2 = arg_68_1:FormatText(StoryNameCfg[670].name)

				arg_68_1.leftNameTxt_.text = var_71_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, true)
				arg_68_1.iconController_:SetSelectedState("hero")

				arg_68_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10071")

				arg_68_1.callingController_:SetSelectedState("normal")

				arg_68_1.keyicon_.color = Color.New(1, 1, 1)
				arg_68_1.icon_.color = Color.New(1, 1, 1)

				local var_71_3 = arg_68_1:GetWordFromCfg(411051016)
				local var_71_4 = arg_68_1:FormatText(var_71_3.content)

				arg_68_1.text_.text = var_71_4

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_5 = 41
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

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051016", "story_v_out_411051.awb") ~= 0 then
					local var_71_8 = manager.audio:GetVoiceLength("story_v_out_411051", "411051016", "story_v_out_411051.awb") / 1000

					if var_71_8 + var_71_0 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_8 + var_71_0
					end

					if var_71_3.prefab_name ~= "" and arg_68_1.actors_[var_71_3.prefab_name] ~= nil then
						local var_71_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_3.prefab_name].transform, "story_v_out_411051", "411051016", "story_v_out_411051.awb")

						arg_68_1:RecordAudio("411051016", var_71_9)
						arg_68_1:RecordAudio("411051016", var_71_9)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_411051", "411051016", "story_v_out_411051.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_411051", "411051016", "story_v_out_411051.awb")
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
	Play411051017 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 411051017
		arg_72_1.duration_ = 7.9

		local var_72_0 = {
			zh = 6.8,
			ja = 7.9
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
				arg_72_0:Play411051018(arg_72_1)
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

				local var_75_2 = arg_72_1:FormatText(StoryNameCfg[670].name)

				arg_72_1.leftNameTxt_.text = var_75_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, true)
				arg_72_1.iconController_:SetSelectedState("hero")

				arg_72_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10071")

				arg_72_1.callingController_:SetSelectedState("normal")

				arg_72_1.keyicon_.color = Color.New(1, 1, 1)
				arg_72_1.icon_.color = Color.New(1, 1, 1)

				local var_75_3 = arg_72_1:GetWordFromCfg(411051017)
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

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051017", "story_v_out_411051.awb") ~= 0 then
					local var_75_8 = manager.audio:GetVoiceLength("story_v_out_411051", "411051017", "story_v_out_411051.awb") / 1000

					if var_75_8 + var_75_0 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_8 + var_75_0
					end

					if var_75_3.prefab_name ~= "" and arg_72_1.actors_[var_75_3.prefab_name] ~= nil then
						local var_75_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_3.prefab_name].transform, "story_v_out_411051", "411051017", "story_v_out_411051.awb")

						arg_72_1:RecordAudio("411051017", var_75_9)
						arg_72_1:RecordAudio("411051017", var_75_9)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_411051", "411051017", "story_v_out_411051.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_411051", "411051017", "story_v_out_411051.awb")
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
	Play411051018 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 411051018
		arg_76_1.duration_ = 7.57

		local var_76_0 = {
			zh = 7.566,
			ja = 6.766
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
				arg_76_0:Play411051019(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = arg_76_1.actors_["10058ui_story"].transform
			local var_79_1 = 0

			if var_79_1 < arg_76_1.time_ and arg_76_1.time_ <= var_79_1 + arg_79_0 then
				arg_76_1.var_.moveOldPos10058ui_story = var_79_0.localPosition
			end

			local var_79_2 = 0.001

			if var_79_1 <= arg_76_1.time_ and arg_76_1.time_ < var_79_1 + var_79_2 then
				local var_79_3 = (arg_76_1.time_ - var_79_1) / var_79_2
				local var_79_4 = Vector3.New(0, -0.98, -6.1)

				var_79_0.localPosition = Vector3.Lerp(arg_76_1.var_.moveOldPos10058ui_story, var_79_4, var_79_3)

				local var_79_5 = manager.ui.mainCamera.transform.position - var_79_0.position

				var_79_0.forward = Vector3.New(var_79_5.x, var_79_5.y, var_79_5.z)

				local var_79_6 = var_79_0.localEulerAngles

				var_79_6.z = 0
				var_79_6.x = 0
				var_79_0.localEulerAngles = var_79_6
			end

			if arg_76_1.time_ >= var_79_1 + var_79_2 and arg_76_1.time_ < var_79_1 + var_79_2 + arg_79_0 then
				var_79_0.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_79_7 = manager.ui.mainCamera.transform.position - var_79_0.position

				var_79_0.forward = Vector3.New(var_79_7.x, var_79_7.y, var_79_7.z)

				local var_79_8 = var_79_0.localEulerAngles

				var_79_8.z = 0
				var_79_8.x = 0
				var_79_0.localEulerAngles = var_79_8
			end

			local var_79_9 = arg_76_1.actors_["10058ui_story"]
			local var_79_10 = 0

			if var_79_10 < arg_76_1.time_ and arg_76_1.time_ <= var_79_10 + arg_79_0 and not isNil(var_79_9) and arg_76_1.var_.characterEffect10058ui_story == nil then
				arg_76_1.var_.characterEffect10058ui_story = var_79_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_11 = 0.200000002980232

			if var_79_10 <= arg_76_1.time_ and arg_76_1.time_ < var_79_10 + var_79_11 and not isNil(var_79_9) then
				local var_79_12 = (arg_76_1.time_ - var_79_10) / var_79_11

				if arg_76_1.var_.characterEffect10058ui_story and not isNil(var_79_9) then
					arg_76_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_76_1.time_ >= var_79_10 + var_79_11 and arg_76_1.time_ < var_79_10 + var_79_11 + arg_79_0 and not isNil(var_79_9) and arg_76_1.var_.characterEffect10058ui_story then
				arg_76_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_79_13 = 0

			if var_79_13 < arg_76_1.time_ and arg_76_1.time_ <= var_79_13 + arg_79_0 then
				arg_76_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_1")
			end

			local var_79_14 = 0

			if var_79_14 < arg_76_1.time_ and arg_76_1.time_ <= var_79_14 + arg_79_0 then
				arg_76_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_79_15 = 0
			local var_79_16 = 0.525

			if var_79_15 < arg_76_1.time_ and arg_76_1.time_ <= var_79_15 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				local var_79_17 = arg_76_1:FormatText(StoryNameCfg[471].name)

				arg_76_1.leftNameTxt_.text = var_79_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_18 = arg_76_1:GetWordFromCfg(411051018)
				local var_79_19 = arg_76_1:FormatText(var_79_18.content)

				arg_76_1.text_.text = var_79_19

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_20 = 21
				local var_79_21 = utf8.len(var_79_19)
				local var_79_22 = var_79_20 <= 0 and var_79_16 or var_79_16 * (var_79_21 / var_79_20)

				if var_79_22 > 0 and var_79_16 < var_79_22 then
					arg_76_1.talkMaxDuration = var_79_22

					if var_79_22 + var_79_15 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_22 + var_79_15
					end
				end

				arg_76_1.text_.text = var_79_19
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051018", "story_v_out_411051.awb") ~= 0 then
					local var_79_23 = manager.audio:GetVoiceLength("story_v_out_411051", "411051018", "story_v_out_411051.awb") / 1000

					if var_79_23 + var_79_15 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_23 + var_79_15
					end

					if var_79_18.prefab_name ~= "" and arg_76_1.actors_[var_79_18.prefab_name] ~= nil then
						local var_79_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_18.prefab_name].transform, "story_v_out_411051", "411051018", "story_v_out_411051.awb")

						arg_76_1:RecordAudio("411051018", var_79_24)
						arg_76_1:RecordAudio("411051018", var_79_24)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_411051", "411051018", "story_v_out_411051.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_411051", "411051018", "story_v_out_411051.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_25 = math.max(var_79_16, arg_76_1.talkMaxDuration)

			if var_79_15 <= arg_76_1.time_ and arg_76_1.time_ < var_79_15 + var_79_25 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_15) / var_79_25

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_15 + var_79_25 and arg_76_1.time_ < var_79_15 + var_79_25 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_76_1:InitPlayNodeList()
	end,
	Play411051019 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 411051019
		arg_80_1.duration_ = 10

		local var_80_0 = {
			zh = 6.833,
			ja = 10
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
				arg_80_0:Play411051020(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = 0
			local var_83_1 = 0.6

			if var_83_0 < arg_80_1.time_ and arg_80_1.time_ <= var_83_0 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				local var_83_2 = arg_80_1:FormatText(StoryNameCfg[471].name)

				arg_80_1.leftNameTxt_.text = var_83_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_3 = arg_80_1:GetWordFromCfg(411051019)
				local var_83_4 = arg_80_1:FormatText(var_83_3.content)

				arg_80_1.text_.text = var_83_4

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_5 = 24
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

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051019", "story_v_out_411051.awb") ~= 0 then
					local var_83_8 = manager.audio:GetVoiceLength("story_v_out_411051", "411051019", "story_v_out_411051.awb") / 1000

					if var_83_8 + var_83_0 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_8 + var_83_0
					end

					if var_83_3.prefab_name ~= "" and arg_80_1.actors_[var_83_3.prefab_name] ~= nil then
						local var_83_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_3.prefab_name].transform, "story_v_out_411051", "411051019", "story_v_out_411051.awb")

						arg_80_1:RecordAudio("411051019", var_83_9)
						arg_80_1:RecordAudio("411051019", var_83_9)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_out_411051", "411051019", "story_v_out_411051.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_out_411051", "411051019", "story_v_out_411051.awb")
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
	Play411051020 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 411051020
		arg_84_1.duration_ = 5

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play411051021(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = arg_84_1.actors_["10058ui_story"]
			local var_87_1 = 0

			if var_87_1 < arg_84_1.time_ and arg_84_1.time_ <= var_87_1 + arg_87_0 and not isNil(var_87_0) and arg_84_1.var_.characterEffect10058ui_story == nil then
				arg_84_1.var_.characterEffect10058ui_story = var_87_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_2 = 0.200000002980232

			if var_87_1 <= arg_84_1.time_ and arg_84_1.time_ < var_87_1 + var_87_2 and not isNil(var_87_0) then
				local var_87_3 = (arg_84_1.time_ - var_87_1) / var_87_2

				if arg_84_1.var_.characterEffect10058ui_story and not isNil(var_87_0) then
					local var_87_4 = Mathf.Lerp(0, 0.5, var_87_3)

					arg_84_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_84_1.var_.characterEffect10058ui_story.fillRatio = var_87_4
				end
			end

			if arg_84_1.time_ >= var_87_1 + var_87_2 and arg_84_1.time_ < var_87_1 + var_87_2 + arg_87_0 and not isNil(var_87_0) and arg_84_1.var_.characterEffect10058ui_story then
				local var_87_5 = 0.5

				arg_84_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_84_1.var_.characterEffect10058ui_story.fillRatio = var_87_5
			end

			local var_87_6 = 0
			local var_87_7 = 1.275

			if var_87_6 < arg_84_1.time_ and arg_84_1.time_ <= var_87_6 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, false)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_8 = arg_84_1:GetWordFromCfg(411051020)
				local var_87_9 = arg_84_1:FormatText(var_87_8.content)

				arg_84_1.text_.text = var_87_9

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_10 = 51
				local var_87_11 = utf8.len(var_87_9)
				local var_87_12 = var_87_10 <= 0 and var_87_7 or var_87_7 * (var_87_11 / var_87_10)

				if var_87_12 > 0 and var_87_7 < var_87_12 then
					arg_84_1.talkMaxDuration = var_87_12

					if var_87_12 + var_87_6 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_12 + var_87_6
					end
				end

				arg_84_1.text_.text = var_87_9
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)
				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_13 = math.max(var_87_7, arg_84_1.talkMaxDuration)

			if var_87_6 <= arg_84_1.time_ and arg_84_1.time_ < var_87_6 + var_87_13 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_6) / var_87_13

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_6 + var_87_13 and arg_84_1.time_ < var_87_6 + var_87_13 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {}

		arg_84_1:InitPlayNodeList()
	end,
	Play411051021 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 411051021
		arg_88_1.duration_ = 5

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play411051022(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = 0
			local var_91_1 = 0.7

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

				local var_91_2 = arg_88_1:GetWordFromCfg(411051021)
				local var_91_3 = arg_88_1:FormatText(var_91_2.content)

				arg_88_1.text_.text = var_91_3

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_4 = 28
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
	Play411051022 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 411051022
		arg_92_1.duration_ = 8.1

		local var_92_0 = {
			zh = 8.1,
			ja = 7.8
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
				arg_92_0:Play411051023(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			local var_95_0 = "ST03"

			if arg_92_1.bgs_[var_95_0] == nil then
				local var_95_1 = Object.Instantiate(arg_92_1.paintGo_)

				var_95_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_95_0)
				var_95_1.name = var_95_0
				var_95_1.transform.parent = arg_92_1.stage_.transform
				var_95_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_92_1.bgs_[var_95_0] = var_95_1
			end

			local var_95_2 = 2

			if var_95_2 < arg_92_1.time_ and arg_92_1.time_ <= var_95_2 + arg_95_0 then
				local var_95_3 = manager.ui.mainCamera.transform.localPosition
				local var_95_4 = Vector3.New(0, 0, 10) + Vector3.New(var_95_3.x, var_95_3.y, 0)
				local var_95_5 = arg_92_1.bgs_.ST03

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
					if iter_95_0 ~= "ST03" then
						iter_95_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_95_16 = 0

			if var_95_16 < arg_92_1.time_ and arg_92_1.time_ <= var_95_16 + arg_95_0 then
				arg_92_1.mask_.enabled = true
				arg_92_1.mask_.raycastTarget = true

				arg_92_1:SetGaussion(false)
			end

			local var_95_17 = 2

			if var_95_16 <= arg_92_1.time_ and arg_92_1.time_ < var_95_16 + var_95_17 then
				local var_95_18 = (arg_92_1.time_ - var_95_16) / var_95_17
				local var_95_19 = Color.New(0, 0, 0)

				var_95_19.a = Mathf.Lerp(0, 1, var_95_18)
				arg_92_1.mask_.color = var_95_19
			end

			if arg_92_1.time_ >= var_95_16 + var_95_17 and arg_92_1.time_ < var_95_16 + var_95_17 + arg_95_0 then
				local var_95_20 = Color.New(0, 0, 0)

				var_95_20.a = 1
				arg_92_1.mask_.color = var_95_20
			end

			local var_95_21 = 2

			if var_95_21 < arg_92_1.time_ and arg_92_1.time_ <= var_95_21 + arg_95_0 then
				arg_92_1.mask_.enabled = true
				arg_92_1.mask_.raycastTarget = true

				arg_92_1:SetGaussion(false)
			end

			local var_95_22 = 1.8

			if var_95_21 <= arg_92_1.time_ and arg_92_1.time_ < var_95_21 + var_95_22 then
				local var_95_23 = (arg_92_1.time_ - var_95_21) / var_95_22
				local var_95_24 = Color.New(0, 0, 0)

				var_95_24.a = Mathf.Lerp(1, 0, var_95_23)
				arg_92_1.mask_.color = var_95_24
			end

			if arg_92_1.time_ >= var_95_21 + var_95_22 and arg_92_1.time_ < var_95_21 + var_95_22 + arg_95_0 then
				local var_95_25 = Color.New(0, 0, 0)
				local var_95_26 = 0

				arg_92_1.mask_.enabled = false
				var_95_25.a = var_95_26
				arg_92_1.mask_.color = var_95_25
			end

			local var_95_27 = arg_92_1.actors_["10058ui_story"].transform
			local var_95_28 = 1.96599999815226

			if var_95_28 < arg_92_1.time_ and arg_92_1.time_ <= var_95_28 + arg_95_0 then
				arg_92_1.var_.moveOldPos10058ui_story = var_95_27.localPosition
			end

			local var_95_29 = 0.001

			if var_95_28 <= arg_92_1.time_ and arg_92_1.time_ < var_95_28 + var_95_29 then
				local var_95_30 = (arg_92_1.time_ - var_95_28) / var_95_29
				local var_95_31 = Vector3.New(0, 100, 0)

				var_95_27.localPosition = Vector3.Lerp(arg_92_1.var_.moveOldPos10058ui_story, var_95_31, var_95_30)

				local var_95_32 = manager.ui.mainCamera.transform.position - var_95_27.position

				var_95_27.forward = Vector3.New(var_95_32.x, var_95_32.y, var_95_32.z)

				local var_95_33 = var_95_27.localEulerAngles

				var_95_33.z = 0
				var_95_33.x = 0
				var_95_27.localEulerAngles = var_95_33
			end

			if arg_92_1.time_ >= var_95_28 + var_95_29 and arg_92_1.time_ < var_95_28 + var_95_29 + arg_95_0 then
				var_95_27.localPosition = Vector3.New(0, 100, 0)

				local var_95_34 = manager.ui.mainCamera.transform.position - var_95_27.position

				var_95_27.forward = Vector3.New(var_95_34.x, var_95_34.y, var_95_34.z)

				local var_95_35 = var_95_27.localEulerAngles

				var_95_35.z = 0
				var_95_35.x = 0
				var_95_27.localEulerAngles = var_95_35
			end

			local var_95_36 = arg_92_1.actors_["10058ui_story"].transform
			local var_95_37 = 3.8

			if var_95_37 < arg_92_1.time_ and arg_92_1.time_ <= var_95_37 + arg_95_0 then
				arg_92_1.var_.moveOldPos10058ui_story = var_95_36.localPosition
			end

			local var_95_38 = 0.001

			if var_95_37 <= arg_92_1.time_ and arg_92_1.time_ < var_95_37 + var_95_38 then
				local var_95_39 = (arg_92_1.time_ - var_95_37) / var_95_38
				local var_95_40 = Vector3.New(0, -0.98, -6.1)

				var_95_36.localPosition = Vector3.Lerp(arg_92_1.var_.moveOldPos10058ui_story, var_95_40, var_95_39)

				local var_95_41 = manager.ui.mainCamera.transform.position - var_95_36.position

				var_95_36.forward = Vector3.New(var_95_41.x, var_95_41.y, var_95_41.z)

				local var_95_42 = var_95_36.localEulerAngles

				var_95_42.z = 0
				var_95_42.x = 0
				var_95_36.localEulerAngles = var_95_42
			end

			if arg_92_1.time_ >= var_95_37 + var_95_38 and arg_92_1.time_ < var_95_37 + var_95_38 + arg_95_0 then
				var_95_36.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_95_43 = manager.ui.mainCamera.transform.position - var_95_36.position

				var_95_36.forward = Vector3.New(var_95_43.x, var_95_43.y, var_95_43.z)

				local var_95_44 = var_95_36.localEulerAngles

				var_95_44.z = 0
				var_95_44.x = 0
				var_95_36.localEulerAngles = var_95_44
			end

			local var_95_45 = arg_92_1.actors_["10058ui_story"]
			local var_95_46 = 3.8

			if var_95_46 < arg_92_1.time_ and arg_92_1.time_ <= var_95_46 + arg_95_0 and not isNil(var_95_45) and arg_92_1.var_.characterEffect10058ui_story == nil then
				arg_92_1.var_.characterEffect10058ui_story = var_95_45:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_47 = 0.200000002980232

			if var_95_46 <= arg_92_1.time_ and arg_92_1.time_ < var_95_46 + var_95_47 and not isNil(var_95_45) then
				local var_95_48 = (arg_92_1.time_ - var_95_46) / var_95_47

				if arg_92_1.var_.characterEffect10058ui_story and not isNil(var_95_45) then
					arg_92_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_92_1.time_ >= var_95_46 + var_95_47 and arg_92_1.time_ < var_95_46 + var_95_47 + arg_95_0 and not isNil(var_95_45) and arg_92_1.var_.characterEffect10058ui_story then
				arg_92_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_95_49 = 3.8

			if var_95_49 < arg_92_1.time_ and arg_92_1.time_ <= var_95_49 + arg_95_0 then
				arg_92_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_95_50 = 3.8

			if var_95_50 < arg_92_1.time_ and arg_92_1.time_ <= var_95_50 + arg_95_0 then
				arg_92_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if arg_92_1.frameCnt_ <= 1 then
				arg_92_1.dialog_:SetActive(false)
			end

			local var_95_51 = 3.8
			local var_95_52 = 0.375

			if var_95_51 < arg_92_1.time_ and arg_92_1.time_ <= var_95_51 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0

				arg_92_1.dialog_:SetActive(true)

				arg_92_1.dialogCg_.alpha = 0

				local var_95_53 = LeanTween.value(arg_92_1.dialog_, 0, 1, 0.3)

				var_95_53:setOnUpdate(LuaHelper.FloatAction(function(arg_96_0)
					arg_92_1.dialogCg_.alpha = arg_96_0
				end))
				var_95_53:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_92_1.dialog_)
					var_95_53:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_92_1.duration_ = arg_92_1.duration_ + 0.3

				SetActive(arg_92_1.leftNameGo_, true)

				local var_95_54 = arg_92_1:FormatText(StoryNameCfg[471].name)

				arg_92_1.leftNameTxt_.text = var_95_54

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_55 = arg_92_1:GetWordFromCfg(411051022)
				local var_95_56 = arg_92_1:FormatText(var_95_55.content)

				arg_92_1.text_.text = var_95_56

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_57 = 15
				local var_95_58 = utf8.len(var_95_56)
				local var_95_59 = var_95_57 <= 0 and var_95_52 or var_95_52 * (var_95_58 / var_95_57)

				if var_95_59 > 0 and var_95_52 < var_95_59 then
					arg_92_1.talkMaxDuration = var_95_59
					var_95_51 = var_95_51 + 0.3

					if var_95_59 + var_95_51 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_59 + var_95_51
					end
				end

				arg_92_1.text_.text = var_95_56
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051022", "story_v_out_411051.awb") ~= 0 then
					local var_95_60 = manager.audio:GetVoiceLength("story_v_out_411051", "411051022", "story_v_out_411051.awb") / 1000

					if var_95_60 + var_95_51 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_60 + var_95_51
					end

					if var_95_55.prefab_name ~= "" and arg_92_1.actors_[var_95_55.prefab_name] ~= nil then
						local var_95_61 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_55.prefab_name].transform, "story_v_out_411051", "411051022", "story_v_out_411051.awb")

						arg_92_1:RecordAudio("411051022", var_95_61)
						arg_92_1:RecordAudio("411051022", var_95_61)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_out_411051", "411051022", "story_v_out_411051.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_out_411051", "411051022", "story_v_out_411051.awb")
				end

				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_62 = var_95_51 + 0.3
			local var_95_63 = math.max(var_95_52, arg_92_1.talkMaxDuration)

			if var_95_62 <= arg_92_1.time_ and arg_92_1.time_ < var_95_62 + var_95_63 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_62) / var_95_63

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_62 + var_95_63 and arg_92_1.time_ < var_95_62 + var_95_63 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_92_1:InitPlayNodeList()
	end,
	Play411051023 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 411051023
		arg_98_1.duration_ = 4.1

		local var_98_0 = {
			zh = 3.266,
			ja = 4.1
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
				arg_98_0:Play411051024(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			local var_101_0 = arg_98_1.actors_["10058ui_story"]
			local var_101_1 = 0

			if var_101_1 < arg_98_1.time_ and arg_98_1.time_ <= var_101_1 + arg_101_0 and not isNil(var_101_0) and arg_98_1.var_.characterEffect10058ui_story == nil then
				arg_98_1.var_.characterEffect10058ui_story = var_101_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_101_2 = 0.200000002980232

			if var_101_1 <= arg_98_1.time_ and arg_98_1.time_ < var_101_1 + var_101_2 and not isNil(var_101_0) then
				local var_101_3 = (arg_98_1.time_ - var_101_1) / var_101_2

				if arg_98_1.var_.characterEffect10058ui_story and not isNil(var_101_0) then
					local var_101_4 = Mathf.Lerp(0, 0.5, var_101_3)

					arg_98_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_98_1.var_.characterEffect10058ui_story.fillRatio = var_101_4
				end
			end

			if arg_98_1.time_ >= var_101_1 + var_101_2 and arg_98_1.time_ < var_101_1 + var_101_2 + arg_101_0 and not isNil(var_101_0) and arg_98_1.var_.characterEffect10058ui_story then
				local var_101_5 = 0.5

				arg_98_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_98_1.var_.characterEffect10058ui_story.fillRatio = var_101_5
			end

			local var_101_6 = 0
			local var_101_7 = 0.366666666666667

			if var_101_6 < arg_98_1.time_ and arg_98_1.time_ <= var_101_6 + arg_101_0 then
				local var_101_8 = "play"
				local var_101_9 = "music"

				arg_98_1:AudioAction(var_101_8, var_101_9, "ui_battle", "ui_battle_stopbgm", "")

				local var_101_10 = ""
				local var_101_11 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_101_11 ~= "" then
					if arg_98_1.bgmTxt_.text ~= var_101_11 and arg_98_1.bgmTxt_.text ~= "" then
						if arg_98_1.bgmTxt2_.text ~= "" then
							arg_98_1.bgmTxt_.text = arg_98_1.bgmTxt2_.text
						end

						arg_98_1.bgmTxt2_.text = var_101_11

						arg_98_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_98_1.bgmTxt_.text = var_101_11
						arg_98_1.bgmTxt2_.text = var_101_11
					end

					if arg_98_1.bgmTimer then
						arg_98_1.bgmTimer:Stop()

						arg_98_1.bgmTimer = nil
					end

					if arg_98_1.settingData.show_music_name == 1 then
						arg_98_1.musicController:SetSelectedState("show")
						arg_98_1.musicAnimator_:Play("open", 0, 0)

						if arg_98_1.settingData.music_time ~= 0 then
							arg_98_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_98_1.settingData.music_time), function()
								if arg_98_1 == nil or isNil(arg_98_1.bgmTxt_) then
									return
								end

								arg_98_1.musicController:SetSelectedState("hide")
								arg_98_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_101_12 = 0
			local var_101_13 = 0.35

			if var_101_12 < arg_98_1.time_ and arg_98_1.time_ <= var_101_12 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				local var_101_14 = arg_98_1:FormatText(StoryNameCfg[264].name)

				arg_98_1.leftNameTxt_.text = var_101_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, true)
				arg_98_1.iconController_:SetSelectedState("hero")

				arg_98_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10014")

				arg_98_1.callingController_:SetSelectedState("calling")

				arg_98_1.keyicon_.color = Color.New(1, 1, 1)
				arg_98_1.icon_.color = Color.New(1, 1, 1)

				local var_101_15 = arg_98_1:GetWordFromCfg(411051023)
				local var_101_16 = arg_98_1:FormatText(var_101_15.content)

				arg_98_1.text_.text = var_101_16

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_17 = 14
				local var_101_18 = utf8.len(var_101_16)
				local var_101_19 = var_101_17 <= 0 and var_101_13 or var_101_13 * (var_101_18 / var_101_17)

				if var_101_19 > 0 and var_101_13 < var_101_19 then
					arg_98_1.talkMaxDuration = var_101_19

					if var_101_19 + var_101_12 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_19 + var_101_12
					end
				end

				arg_98_1.text_.text = var_101_16
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051023", "story_v_out_411051.awb") ~= 0 then
					local var_101_20 = manager.audio:GetVoiceLength("story_v_out_411051", "411051023", "story_v_out_411051.awb") / 1000

					if var_101_20 + var_101_12 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_20 + var_101_12
					end

					if var_101_15.prefab_name ~= "" and arg_98_1.actors_[var_101_15.prefab_name] ~= nil then
						local var_101_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_98_1.actors_[var_101_15.prefab_name].transform, "story_v_out_411051", "411051023", "story_v_out_411051.awb")

						arg_98_1:RecordAudio("411051023", var_101_21)
						arg_98_1:RecordAudio("411051023", var_101_21)
					else
						arg_98_1:AudioAction("play", "voice", "story_v_out_411051", "411051023", "story_v_out_411051.awb")
					end

					arg_98_1:RecordHistoryTalkVoice("story_v_out_411051", "411051023", "story_v_out_411051.awb")
				end

				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_22 = math.max(var_101_13, arg_98_1.talkMaxDuration)

			if var_101_12 <= arg_98_1.time_ and arg_98_1.time_ < var_101_12 + var_101_22 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_12) / var_101_22

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_12 + var_101_22 and arg_98_1.time_ < var_101_12 + var_101_22 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {}

		arg_98_1:InitPlayNodeList()
	end,
	Play411051024 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 411051024
		arg_103_1.duration_ = 2

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play411051025(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			local var_106_0 = 0

			if var_106_0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_0 + arg_106_0 then
				arg_103_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_106_1 = arg_103_1.actors_["10058ui_story"]
			local var_106_2 = 0

			if var_106_2 < arg_103_1.time_ and arg_103_1.time_ <= var_106_2 + arg_106_0 and not isNil(var_106_1) and arg_103_1.var_.characterEffect10058ui_story == nil then
				arg_103_1.var_.characterEffect10058ui_story = var_106_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_106_3 = 0.200000002980232

			if var_106_2 <= arg_103_1.time_ and arg_103_1.time_ < var_106_2 + var_106_3 and not isNil(var_106_1) then
				local var_106_4 = (arg_103_1.time_ - var_106_2) / var_106_3

				if arg_103_1.var_.characterEffect10058ui_story and not isNil(var_106_1) then
					arg_103_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_103_1.time_ >= var_106_2 + var_106_3 and arg_103_1.time_ < var_106_2 + var_106_3 + arg_106_0 and not isNil(var_106_1) and arg_103_1.var_.characterEffect10058ui_story then
				arg_103_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_106_5 = 0
			local var_106_6 = 0.05

			if var_106_5 < arg_103_1.time_ and arg_103_1.time_ <= var_106_5 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				local var_106_7 = arg_103_1:FormatText(StoryNameCfg[471].name)

				arg_103_1.leftNameTxt_.text = var_106_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_8 = arg_103_1:GetWordFromCfg(411051024)
				local var_106_9 = arg_103_1:FormatText(var_106_8.content)

				arg_103_1.text_.text = var_106_9

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_10 = 2
				local var_106_11 = utf8.len(var_106_9)
				local var_106_12 = var_106_10 <= 0 and var_106_6 or var_106_6 * (var_106_11 / var_106_10)

				if var_106_12 > 0 and var_106_6 < var_106_12 then
					arg_103_1.talkMaxDuration = var_106_12

					if var_106_12 + var_106_5 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_12 + var_106_5
					end
				end

				arg_103_1.text_.text = var_106_9
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051024", "story_v_out_411051.awb") ~= 0 then
					local var_106_13 = manager.audio:GetVoiceLength("story_v_out_411051", "411051024", "story_v_out_411051.awb") / 1000

					if var_106_13 + var_106_5 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_13 + var_106_5
					end

					if var_106_8.prefab_name ~= "" and arg_103_1.actors_[var_106_8.prefab_name] ~= nil then
						local var_106_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_8.prefab_name].transform, "story_v_out_411051", "411051024", "story_v_out_411051.awb")

						arg_103_1:RecordAudio("411051024", var_106_14)
						arg_103_1:RecordAudio("411051024", var_106_14)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_out_411051", "411051024", "story_v_out_411051.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_out_411051", "411051024", "story_v_out_411051.awb")
				end

				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_15 = math.max(var_106_6, arg_103_1.talkMaxDuration)

			if var_106_5 <= arg_103_1.time_ and arg_103_1.time_ < var_106_5 + var_106_15 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_5) / var_106_15

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_5 + var_106_15 and arg_103_1.time_ < var_106_5 + var_106_15 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {}

		arg_103_1:InitPlayNodeList()
	end,
	Play411051025 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 411051025
		arg_107_1.duration_ = 5

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play411051026(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			local var_110_0 = arg_107_1.actors_["10058ui_story"]
			local var_110_1 = 0

			if var_110_1 < arg_107_1.time_ and arg_107_1.time_ <= var_110_1 + arg_110_0 and not isNil(var_110_0) and arg_107_1.var_.characterEffect10058ui_story == nil then
				arg_107_1.var_.characterEffect10058ui_story = var_110_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_110_2 = 0.200000002980232

			if var_110_1 <= arg_107_1.time_ and arg_107_1.time_ < var_110_1 + var_110_2 and not isNil(var_110_0) then
				local var_110_3 = (arg_107_1.time_ - var_110_1) / var_110_2

				if arg_107_1.var_.characterEffect10058ui_story and not isNil(var_110_0) then
					local var_110_4 = Mathf.Lerp(0, 0.5, var_110_3)

					arg_107_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_107_1.var_.characterEffect10058ui_story.fillRatio = var_110_4
				end
			end

			if arg_107_1.time_ >= var_110_1 + var_110_2 and arg_107_1.time_ < var_110_1 + var_110_2 + arg_110_0 and not isNil(var_110_0) and arg_107_1.var_.characterEffect10058ui_story then
				local var_110_5 = 0.5

				arg_107_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_107_1.var_.characterEffect10058ui_story.fillRatio = var_110_5
			end

			local var_110_6 = arg_107_1.actors_["10058ui_story"].transform
			local var_110_7 = 0

			if var_110_7 < arg_107_1.time_ and arg_107_1.time_ <= var_110_7 + arg_110_0 then
				arg_107_1.var_.moveOldPos10058ui_story = var_110_6.localPosition
			end

			local var_110_8 = 0.001

			if var_110_7 <= arg_107_1.time_ and arg_107_1.time_ < var_110_7 + var_110_8 then
				local var_110_9 = (arg_107_1.time_ - var_110_7) / var_110_8
				local var_110_10 = Vector3.New(0, 100, 0)

				var_110_6.localPosition = Vector3.Lerp(arg_107_1.var_.moveOldPos10058ui_story, var_110_10, var_110_9)

				local var_110_11 = manager.ui.mainCamera.transform.position - var_110_6.position

				var_110_6.forward = Vector3.New(var_110_11.x, var_110_11.y, var_110_11.z)

				local var_110_12 = var_110_6.localEulerAngles

				var_110_12.z = 0
				var_110_12.x = 0
				var_110_6.localEulerAngles = var_110_12
			end

			if arg_107_1.time_ >= var_110_7 + var_110_8 and arg_107_1.time_ < var_110_7 + var_110_8 + arg_110_0 then
				var_110_6.localPosition = Vector3.New(0, 100, 0)

				local var_110_13 = manager.ui.mainCamera.transform.position - var_110_6.position

				var_110_6.forward = Vector3.New(var_110_13.x, var_110_13.y, var_110_13.z)

				local var_110_14 = var_110_6.localEulerAngles

				var_110_14.z = 0
				var_110_14.x = 0
				var_110_6.localEulerAngles = var_110_14
			end

			local var_110_15 = 0
			local var_110_16 = 0.95

			if var_110_15 < arg_107_1.time_ and arg_107_1.time_ <= var_110_15 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, false)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_17 = arg_107_1:GetWordFromCfg(411051025)
				local var_110_18 = arg_107_1:FormatText(var_110_17.content)

				arg_107_1.text_.text = var_110_18

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_19 = 38
				local var_110_20 = utf8.len(var_110_18)
				local var_110_21 = var_110_19 <= 0 and var_110_16 or var_110_16 * (var_110_20 / var_110_19)

				if var_110_21 > 0 and var_110_16 < var_110_21 then
					arg_107_1.talkMaxDuration = var_110_21

					if var_110_21 + var_110_15 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_21 + var_110_15
					end
				end

				arg_107_1.text_.text = var_110_18
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)
				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_22 = math.max(var_110_16, arg_107_1.talkMaxDuration)

			if var_110_15 <= arg_107_1.time_ and arg_107_1.time_ < var_110_15 + var_110_22 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_15) / var_110_22

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_15 + var_110_22 and arg_107_1.time_ < var_110_15 + var_110_22 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
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
	Play411051026 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 411051026
		arg_111_1.duration_ = 5.57

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play411051027(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = "I07"

			if arg_111_1.bgs_[var_114_0] == nil then
				local var_114_1 = Object.Instantiate(arg_111_1.paintGo_)

				var_114_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_114_0)
				var_114_1.name = var_114_0
				var_114_1.transform.parent = arg_111_1.stage_.transform
				var_114_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_111_1.bgs_[var_114_0] = var_114_1
			end

			local var_114_2 = 0.566666666666667

			if var_114_2 < arg_111_1.time_ and arg_111_1.time_ <= var_114_2 + arg_114_0 then
				local var_114_3 = manager.ui.mainCamera.transform.localPosition
				local var_114_4 = Vector3.New(0, 0, 10) + Vector3.New(var_114_3.x, var_114_3.y, 0)
				local var_114_5 = arg_111_1.bgs_.I07

				var_114_5.transform.localPosition = var_114_4
				var_114_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_114_6 = var_114_5:GetComponent("SpriteRenderer")

				if var_114_6 and var_114_6.sprite then
					local var_114_7 = (var_114_5.transform.localPosition - var_114_3).z
					local var_114_8 = manager.ui.mainCameraCom_
					local var_114_9 = 2 * var_114_7 * Mathf.Tan(var_114_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_114_10 = var_114_9 * var_114_8.aspect
					local var_114_11 = var_114_6.sprite.bounds.size.x
					local var_114_12 = var_114_6.sprite.bounds.size.y
					local var_114_13 = var_114_10 / var_114_11
					local var_114_14 = var_114_9 / var_114_12
					local var_114_15 = var_114_14 < var_114_13 and var_114_13 or var_114_14

					var_114_5.transform.localScale = Vector3.New(var_114_15, var_114_15, 0)
				end

				for iter_114_0, iter_114_1 in pairs(arg_111_1.bgs_) do
					if iter_114_0 ~= "I07" then
						iter_114_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_114_16 = manager.ui.mainCamera.transform
			local var_114_17 = 0

			if var_114_17 < arg_111_1.time_ and arg_111_1.time_ <= var_114_17 + arg_114_0 then
				local var_114_18 = arg_111_1.var_.effect112345
				local var_114_19
				local var_114_20 = var_114_16

				if not var_114_18 then
					var_114_18 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_error"), var_114_20)
					var_114_18.name = "112345"
					arg_111_1.var_.effect112345 = var_114_18
				else
					var_114_18.transform:SetParent(var_114_20)
				end

				var_114_18.transform.localPosition = Vector3.New(0, 0, 0)
				var_114_18.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_114_21 = 0
			local var_114_22 = 0.366666666666667

			if var_114_21 < arg_111_1.time_ and arg_111_1.time_ <= var_114_21 + arg_114_0 then
				local var_114_23 = "play"
				local var_114_24 = "music"

				arg_111_1:AudioAction(var_114_23, var_114_24, "ui_battle", "ui_battle_stopbgm", "")

				local var_114_25 = ""
				local var_114_26 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_114_26 ~= "" then
					if arg_111_1.bgmTxt_.text ~= var_114_26 and arg_111_1.bgmTxt_.text ~= "" then
						if arg_111_1.bgmTxt2_.text ~= "" then
							arg_111_1.bgmTxt_.text = arg_111_1.bgmTxt2_.text
						end

						arg_111_1.bgmTxt2_.text = var_114_26

						arg_111_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_111_1.bgmTxt_.text = var_114_26
						arg_111_1.bgmTxt2_.text = var_114_26
					end

					if arg_111_1.bgmTimer then
						arg_111_1.bgmTimer:Stop()

						arg_111_1.bgmTimer = nil
					end

					if arg_111_1.settingData.show_music_name == 1 then
						arg_111_1.musicController:SetSelectedState("show")
						arg_111_1.musicAnimator_:Play("open", 0, 0)

						if arg_111_1.settingData.music_time ~= 0 then
							arg_111_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_111_1.settingData.music_time), function()
								if arg_111_1 == nil or isNil(arg_111_1.bgmTxt_) then
									return
								end

								arg_111_1.musicController:SetSelectedState("hide")
								arg_111_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_114_27 = 0.6
			local var_114_28 = 1

			if var_114_27 < arg_111_1.time_ and arg_111_1.time_ <= var_114_27 + arg_114_0 then
				local var_114_29 = "play"
				local var_114_30 = "music"

				arg_111_1:AudioAction(var_114_29, var_114_30, "bgm_activity_3_0_story_northblock", "bgm_activity_3_0_story_northblock", "bgm_activity_3_0_story_northblock.awb")

				local var_114_31 = ""
				local var_114_32 = manager.audio:GetAudioName("bgm_activity_3_0_story_northblock", "bgm_activity_3_0_story_northblock")

				if var_114_32 ~= "" then
					if arg_111_1.bgmTxt_.text ~= var_114_32 and arg_111_1.bgmTxt_.text ~= "" then
						if arg_111_1.bgmTxt2_.text ~= "" then
							arg_111_1.bgmTxt_.text = arg_111_1.bgmTxt2_.text
						end

						arg_111_1.bgmTxt2_.text = var_114_32

						arg_111_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_111_1.bgmTxt_.text = var_114_32
						arg_111_1.bgmTxt2_.text = var_114_32
					end

					if arg_111_1.bgmTimer then
						arg_111_1.bgmTimer:Stop()

						arg_111_1.bgmTimer = nil
					end

					if arg_111_1.settingData.show_music_name == 1 then
						arg_111_1.musicController:SetSelectedState("show")
						arg_111_1.musicAnimator_:Play("open", 0, 0)

						if arg_111_1.settingData.music_time ~= 0 then
							arg_111_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_111_1.settingData.music_time), function()
								if arg_111_1 == nil or isNil(arg_111_1.bgmTxt_) then
									return
								end

								arg_111_1.musicController:SetSelectedState("hide")
								arg_111_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_114_33 = 0
			local var_114_34 = 1

			if var_114_33 < arg_111_1.time_ and arg_111_1.time_ <= var_114_33 + arg_114_0 then
				local var_114_35 = "play"
				local var_114_36 = "effect"

				arg_111_1:AudioAction(var_114_35, var_114_36, "se_story_130", "se_story_130_noise", "")
			end

			if arg_111_1.frameCnt_ <= 1 then
				arg_111_1.dialog_:SetActive(false)
			end

			local var_114_37 = 0.566666666666667
			local var_114_38 = 1.15

			if var_114_37 < arg_111_1.time_ and arg_111_1.time_ <= var_114_37 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0

				arg_111_1.dialog_:SetActive(true)

				arg_111_1.dialogCg_.alpha = 0

				local var_114_39 = LeanTween.value(arg_111_1.dialog_, 0, 1, 0.3)

				var_114_39:setOnUpdate(LuaHelper.FloatAction(function(arg_117_0)
					arg_111_1.dialogCg_.alpha = arg_117_0
				end))
				var_114_39:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_111_1.dialog_)
					var_114_39:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_111_1.duration_ = arg_111_1.duration_ + 0.3

				SetActive(arg_111_1.leftNameGo_, false)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_40 = arg_111_1:GetWordFromCfg(411051026)
				local var_114_41 = arg_111_1:FormatText(var_114_40.content)

				arg_111_1.text_.text = var_114_41

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_42 = 46
				local var_114_43 = utf8.len(var_114_41)
				local var_114_44 = var_114_42 <= 0 and var_114_38 or var_114_38 * (var_114_43 / var_114_42)

				if var_114_44 > 0 and var_114_38 < var_114_44 then
					arg_111_1.talkMaxDuration = var_114_44
					var_114_37 = var_114_37 + 0.3

					if var_114_44 + var_114_37 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_44 + var_114_37
					end
				end

				arg_111_1.text_.text = var_114_41
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)
				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_45 = var_114_37 + 0.3
			local var_114_46 = math.max(var_114_38, arg_111_1.talkMaxDuration)

			if var_114_45 <= arg_111_1.time_ and arg_111_1.time_ < var_114_45 + var_114_46 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_45) / var_114_46

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_45 + var_114_46 and arg_111_1.time_ < var_114_45 + var_114_46 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play411051027 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 411051027
		arg_119_1.duration_ = 4.63

		local var_119_0 = {
			zh = 2.4,
			ja = 4.633
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
				arg_119_0:Play411051028(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = arg_119_1.actors_["10058ui_story"].transform
			local var_122_1 = 0

			if var_122_1 < arg_119_1.time_ and arg_119_1.time_ <= var_122_1 + arg_122_0 then
				arg_119_1.var_.moveOldPos10058ui_story = var_122_0.localPosition
			end

			local var_122_2 = 0.001

			if var_122_1 <= arg_119_1.time_ and arg_119_1.time_ < var_122_1 + var_122_2 then
				local var_122_3 = (arg_119_1.time_ - var_122_1) / var_122_2
				local var_122_4 = Vector3.New(-0.7, -0.98, -6.1)

				var_122_0.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos10058ui_story, var_122_4, var_122_3)

				local var_122_5 = manager.ui.mainCamera.transform.position - var_122_0.position

				var_122_0.forward = Vector3.New(var_122_5.x, var_122_5.y, var_122_5.z)

				local var_122_6 = var_122_0.localEulerAngles

				var_122_6.z = 0
				var_122_6.x = 0
				var_122_0.localEulerAngles = var_122_6
			end

			if arg_119_1.time_ >= var_122_1 + var_122_2 and arg_119_1.time_ < var_122_1 + var_122_2 + arg_122_0 then
				var_122_0.localPosition = Vector3.New(-0.7, -0.98, -6.1)

				local var_122_7 = manager.ui.mainCamera.transform.position - var_122_0.position

				var_122_0.forward = Vector3.New(var_122_7.x, var_122_7.y, var_122_7.z)

				local var_122_8 = var_122_0.localEulerAngles

				var_122_8.z = 0
				var_122_8.x = 0
				var_122_0.localEulerAngles = var_122_8
			end

			local var_122_9 = arg_119_1.actors_["10058ui_story"]
			local var_122_10 = 0

			if var_122_10 < arg_119_1.time_ and arg_119_1.time_ <= var_122_10 + arg_122_0 and not isNil(var_122_9) and arg_119_1.var_.characterEffect10058ui_story == nil then
				arg_119_1.var_.characterEffect10058ui_story = var_122_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_11 = 0.200000002980232

			if var_122_10 <= arg_119_1.time_ and arg_119_1.time_ < var_122_10 + var_122_11 and not isNil(var_122_9) then
				local var_122_12 = (arg_119_1.time_ - var_122_10) / var_122_11

				if arg_119_1.var_.characterEffect10058ui_story and not isNil(var_122_9) then
					arg_119_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_119_1.time_ >= var_122_10 + var_122_11 and arg_119_1.time_ < var_122_10 + var_122_11 + arg_122_0 and not isNil(var_122_9) and arg_119_1.var_.characterEffect10058ui_story then
				arg_119_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_122_13 = 0

			if var_122_13 < arg_119_1.time_ and arg_119_1.time_ <= var_122_13 + arg_122_0 then
				arg_119_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_122_14 = 0

			if var_122_14 < arg_119_1.time_ and arg_119_1.time_ <= var_122_14 + arg_122_0 then
				arg_119_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_122_15 = "10014ui_story"

			if arg_119_1.actors_[var_122_15] == nil then
				local var_122_16 = Asset.Load("Char/" .. "10014ui_story")

				if not isNil(var_122_16) then
					local var_122_17 = Object.Instantiate(Asset.Load("Char/" .. "10014ui_story"), arg_119_1.stage_.transform)

					var_122_17.name = var_122_15
					var_122_17.transform.localPosition = Vector3.New(0, 100, 0)
					arg_119_1.actors_[var_122_15] = var_122_17

					local var_122_18 = var_122_17:GetComponentInChildren(typeof(CharacterEffect))

					var_122_18.enabled = true

					local var_122_19 = GameObjectTools.GetOrAddComponent(var_122_17, typeof(DynamicBoneHelper))

					if var_122_19 then
						var_122_19:EnableDynamicBone(false)
					end

					arg_119_1:ShowWeapon(var_122_18.transform, false)

					arg_119_1.var_[var_122_15 .. "Animator"] = var_122_18.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_119_1.var_[var_122_15 .. "Animator"].applyRootMotion = true
					arg_119_1.var_[var_122_15 .. "LipSync"] = var_122_18.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_122_20 = arg_119_1.actors_["10014ui_story"].transform
			local var_122_21 = 0

			if var_122_21 < arg_119_1.time_ and arg_119_1.time_ <= var_122_21 + arg_122_0 then
				arg_119_1.var_.moveOldPos10014ui_story = var_122_20.localPosition
			end

			local var_122_22 = 0.001

			if var_122_21 <= arg_119_1.time_ and arg_119_1.time_ < var_122_21 + var_122_22 then
				local var_122_23 = (arg_119_1.time_ - var_122_21) / var_122_22
				local var_122_24 = Vector3.New(0.7, -1.06, -6.2)

				var_122_20.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos10014ui_story, var_122_24, var_122_23)

				local var_122_25 = manager.ui.mainCamera.transform.position - var_122_20.position

				var_122_20.forward = Vector3.New(var_122_25.x, var_122_25.y, var_122_25.z)

				local var_122_26 = var_122_20.localEulerAngles

				var_122_26.z = 0
				var_122_26.x = 0
				var_122_20.localEulerAngles = var_122_26
			end

			if arg_119_1.time_ >= var_122_21 + var_122_22 and arg_119_1.time_ < var_122_21 + var_122_22 + arg_122_0 then
				var_122_20.localPosition = Vector3.New(0.7, -1.06, -6.2)

				local var_122_27 = manager.ui.mainCamera.transform.position - var_122_20.position

				var_122_20.forward = Vector3.New(var_122_27.x, var_122_27.y, var_122_27.z)

				local var_122_28 = var_122_20.localEulerAngles

				var_122_28.z = 0
				var_122_28.x = 0
				var_122_20.localEulerAngles = var_122_28
			end

			local var_122_29 = arg_119_1.actors_["10014ui_story"]
			local var_122_30 = 0

			if var_122_30 < arg_119_1.time_ and arg_119_1.time_ <= var_122_30 + arg_122_0 and not isNil(var_122_29) and arg_119_1.var_.characterEffect10014ui_story == nil then
				arg_119_1.var_.characterEffect10014ui_story = var_122_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_31 = 0.183333336313566

			if var_122_30 <= arg_119_1.time_ and arg_119_1.time_ < var_122_30 + var_122_31 and not isNil(var_122_29) then
				local var_122_32 = (arg_119_1.time_ - var_122_30) / var_122_31

				if arg_119_1.var_.characterEffect10014ui_story and not isNil(var_122_29) then
					local var_122_33 = Mathf.Lerp(0, 0.5, var_122_32)

					arg_119_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_119_1.var_.characterEffect10014ui_story.fillRatio = var_122_33
				end
			end

			if arg_119_1.time_ >= var_122_30 + var_122_31 and arg_119_1.time_ < var_122_30 + var_122_31 + arg_122_0 and not isNil(var_122_29) and arg_119_1.var_.characterEffect10014ui_story then
				local var_122_34 = 0.5

				arg_119_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_119_1.var_.characterEffect10014ui_story.fillRatio = var_122_34
			end

			local var_122_35 = manager.ui.mainCamera.transform
			local var_122_36 = 0

			if var_122_36 < arg_119_1.time_ and arg_119_1.time_ <= var_122_36 + arg_122_0 then
				local var_122_37 = arg_119_1.var_.effect112345

				if var_122_37 then
					Object.Destroy(var_122_37)

					arg_119_1.var_.effect112345 = nil
				end
			end

			local var_122_38 = 0
			local var_122_39 = 0.325

			if var_122_38 < arg_119_1.time_ and arg_119_1.time_ <= var_122_38 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				local var_122_40 = arg_119_1:FormatText(StoryNameCfg[471].name)

				arg_119_1.leftNameTxt_.text = var_122_40

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_41 = arg_119_1:GetWordFromCfg(411051027)
				local var_122_42 = arg_119_1:FormatText(var_122_41.content)

				arg_119_1.text_.text = var_122_42

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_43 = 13
				local var_122_44 = utf8.len(var_122_42)
				local var_122_45 = var_122_43 <= 0 and var_122_39 or var_122_39 * (var_122_44 / var_122_43)

				if var_122_45 > 0 and var_122_39 < var_122_45 then
					arg_119_1.talkMaxDuration = var_122_45

					if var_122_45 + var_122_38 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_45 + var_122_38
					end
				end

				arg_119_1.text_.text = var_122_42
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051027", "story_v_out_411051.awb") ~= 0 then
					local var_122_46 = manager.audio:GetVoiceLength("story_v_out_411051", "411051027", "story_v_out_411051.awb") / 1000

					if var_122_46 + var_122_38 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_46 + var_122_38
					end

					if var_122_41.prefab_name ~= "" and arg_119_1.actors_[var_122_41.prefab_name] ~= nil then
						local var_122_47 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_41.prefab_name].transform, "story_v_out_411051", "411051027", "story_v_out_411051.awb")

						arg_119_1:RecordAudio("411051027", var_122_47)
						arg_119_1:RecordAudio("411051027", var_122_47)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_411051", "411051027", "story_v_out_411051.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_411051", "411051027", "story_v_out_411051.awb")
				end

				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_48 = math.max(var_122_39, arg_119_1.talkMaxDuration)

			if var_122_38 <= arg_119_1.time_ and arg_119_1.time_ < var_122_38 + var_122_48 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_38) / var_122_48

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_38 + var_122_48 and arg_119_1.time_ < var_122_38 + var_122_48 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10014ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_119_1:InitPlayNodeList()
	end,
	Play411051028 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 411051028
		arg_123_1.duration_ = 5

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play411051029(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = arg_123_1.actors_["10058ui_story"]
			local var_126_1 = 0

			if var_126_1 < arg_123_1.time_ and arg_123_1.time_ <= var_126_1 + arg_126_0 and not isNil(var_126_0) and arg_123_1.var_.characterEffect10058ui_story == nil then
				arg_123_1.var_.characterEffect10058ui_story = var_126_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_2 = 0.200000002980232

			if var_126_1 <= arg_123_1.time_ and arg_123_1.time_ < var_126_1 + var_126_2 and not isNil(var_126_0) then
				local var_126_3 = (arg_123_1.time_ - var_126_1) / var_126_2

				if arg_123_1.var_.characterEffect10058ui_story and not isNil(var_126_0) then
					local var_126_4 = Mathf.Lerp(0, 0.5, var_126_3)

					arg_123_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_123_1.var_.characterEffect10058ui_story.fillRatio = var_126_4
				end
			end

			if arg_123_1.time_ >= var_126_1 + var_126_2 and arg_123_1.time_ < var_126_1 + var_126_2 + arg_126_0 and not isNil(var_126_0) and arg_123_1.var_.characterEffect10058ui_story then
				local var_126_5 = 0.5

				arg_123_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_123_1.var_.characterEffect10058ui_story.fillRatio = var_126_5
			end

			local var_126_6 = 0
			local var_126_7 = 1.025

			if var_126_6 < arg_123_1.time_ and arg_123_1.time_ <= var_126_6 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, false)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_8 = arg_123_1:GetWordFromCfg(411051028)
				local var_126_9 = arg_123_1:FormatText(var_126_8.content)

				arg_123_1.text_.text = var_126_9

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_10 = 41
				local var_126_11 = utf8.len(var_126_9)
				local var_126_12 = var_126_10 <= 0 and var_126_7 or var_126_7 * (var_126_11 / var_126_10)

				if var_126_12 > 0 and var_126_7 < var_126_12 then
					arg_123_1.talkMaxDuration = var_126_12

					if var_126_12 + var_126_6 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_12 + var_126_6
					end
				end

				arg_123_1.text_.text = var_126_9
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)
				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_13 = math.max(var_126_7, arg_123_1.talkMaxDuration)

			if var_126_6 <= arg_123_1.time_ and arg_123_1.time_ < var_126_6 + var_126_13 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_6) / var_126_13

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_6 + var_126_13 and arg_123_1.time_ < var_126_6 + var_126_13 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play411051029 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 411051029
		arg_127_1.duration_ = 5

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play411051030(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = 0
			local var_130_1 = 0.9

			if var_130_0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_0 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, false)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_2 = arg_127_1:GetWordFromCfg(411051029)
				local var_130_3 = arg_127_1:FormatText(var_130_2.content)

				arg_127_1.text_.text = var_130_3

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_4 = 36
				local var_130_5 = utf8.len(var_130_3)
				local var_130_6 = var_130_4 <= 0 and var_130_1 or var_130_1 * (var_130_5 / var_130_4)

				if var_130_6 > 0 and var_130_1 < var_130_6 then
					arg_127_1.talkMaxDuration = var_130_6

					if var_130_6 + var_130_0 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_6 + var_130_0
					end
				end

				arg_127_1.text_.text = var_130_3
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)
				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_7 = math.max(var_130_1, arg_127_1.talkMaxDuration)

			if var_130_0 <= arg_127_1.time_ and arg_127_1.time_ < var_130_0 + var_130_7 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_0) / var_130_7

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_0 + var_130_7 and arg_127_1.time_ < var_130_0 + var_130_7 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play411051030 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 411051030
		arg_131_1.duration_ = 5

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play411051031(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = 0
			local var_134_1 = 1.125

			if var_134_0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_0 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, false)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_2 = arg_131_1:GetWordFromCfg(411051030)
				local var_134_3 = arg_131_1:FormatText(var_134_2.content)

				arg_131_1.text_.text = var_134_3

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_4 = 46
				local var_134_5 = utf8.len(var_134_3)
				local var_134_6 = var_134_4 <= 0 and var_134_1 or var_134_1 * (var_134_5 / var_134_4)

				if var_134_6 > 0 and var_134_1 < var_134_6 then
					arg_131_1.talkMaxDuration = var_134_6

					if var_134_6 + var_134_0 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_6 + var_134_0
					end
				end

				arg_131_1.text_.text = var_134_3
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)
				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_7 = math.max(var_134_1, arg_131_1.talkMaxDuration)

			if var_134_0 <= arg_131_1.time_ and arg_131_1.time_ < var_134_0 + var_134_7 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_0) / var_134_7

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_0 + var_134_7 and arg_131_1.time_ < var_134_0 + var_134_7 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play411051031 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 411051031
		arg_135_1.duration_ = 5.43

		local var_135_0 = {
			zh = 4.033,
			ja = 5.433
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
				arg_135_0:Play411051032(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = arg_135_1.actors_["10014ui_story"].transform
			local var_138_1 = 0

			if var_138_1 < arg_135_1.time_ and arg_135_1.time_ <= var_138_1 + arg_138_0 then
				arg_135_1.var_.moveOldPos10014ui_story = var_138_0.localPosition
			end

			local var_138_2 = 0.001

			if var_138_1 <= arg_135_1.time_ and arg_135_1.time_ < var_138_1 + var_138_2 then
				local var_138_3 = (arg_135_1.time_ - var_138_1) / var_138_2
				local var_138_4 = Vector3.New(0.7, -1.06, -6.2)

				var_138_0.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPos10014ui_story, var_138_4, var_138_3)

				local var_138_5 = manager.ui.mainCamera.transform.position - var_138_0.position

				var_138_0.forward = Vector3.New(var_138_5.x, var_138_5.y, var_138_5.z)

				local var_138_6 = var_138_0.localEulerAngles

				var_138_6.z = 0
				var_138_6.x = 0
				var_138_0.localEulerAngles = var_138_6
			end

			if arg_135_1.time_ >= var_138_1 + var_138_2 and arg_135_1.time_ < var_138_1 + var_138_2 + arg_138_0 then
				var_138_0.localPosition = Vector3.New(0.7, -1.06, -6.2)

				local var_138_7 = manager.ui.mainCamera.transform.position - var_138_0.position

				var_138_0.forward = Vector3.New(var_138_7.x, var_138_7.y, var_138_7.z)

				local var_138_8 = var_138_0.localEulerAngles

				var_138_8.z = 0
				var_138_8.x = 0
				var_138_0.localEulerAngles = var_138_8
			end

			local var_138_9 = arg_135_1.actors_["10014ui_story"]
			local var_138_10 = 0

			if var_138_10 < arg_135_1.time_ and arg_135_1.time_ <= var_138_10 + arg_138_0 and not isNil(var_138_9) and arg_135_1.var_.characterEffect10014ui_story == nil then
				arg_135_1.var_.characterEffect10014ui_story = var_138_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_11 = 0.200000002980232

			if var_138_10 <= arg_135_1.time_ and arg_135_1.time_ < var_138_10 + var_138_11 and not isNil(var_138_9) then
				local var_138_12 = (arg_135_1.time_ - var_138_10) / var_138_11

				if arg_135_1.var_.characterEffect10014ui_story and not isNil(var_138_9) then
					arg_135_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_135_1.time_ >= var_138_10 + var_138_11 and arg_135_1.time_ < var_138_10 + var_138_11 + arg_138_0 and not isNil(var_138_9) and arg_135_1.var_.characterEffect10014ui_story then
				arg_135_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			local var_138_13 = 0

			if var_138_13 < arg_135_1.time_ and arg_135_1.time_ <= var_138_13 + arg_138_0 then
				arg_135_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/story10014/story10014action/10014action1_1")
			end

			local var_138_14 = 0

			if var_138_14 < arg_135_1.time_ and arg_135_1.time_ <= var_138_14 + arg_138_0 then
				arg_135_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_138_15 = 0
			local var_138_16 = 0.475

			if var_138_15 < arg_135_1.time_ and arg_135_1.time_ <= var_138_15 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				local var_138_17 = arg_135_1:FormatText(StoryNameCfg[264].name)

				arg_135_1.leftNameTxt_.text = var_138_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_18 = arg_135_1:GetWordFromCfg(411051031)
				local var_138_19 = arg_135_1:FormatText(var_138_18.content)

				arg_135_1.text_.text = var_138_19

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_20 = 19
				local var_138_21 = utf8.len(var_138_19)
				local var_138_22 = var_138_20 <= 0 and var_138_16 or var_138_16 * (var_138_21 / var_138_20)

				if var_138_22 > 0 and var_138_16 < var_138_22 then
					arg_135_1.talkMaxDuration = var_138_22

					if var_138_22 + var_138_15 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_22 + var_138_15
					end
				end

				arg_135_1.text_.text = var_138_19
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051031", "story_v_out_411051.awb") ~= 0 then
					local var_138_23 = manager.audio:GetVoiceLength("story_v_out_411051", "411051031", "story_v_out_411051.awb") / 1000

					if var_138_23 + var_138_15 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_23 + var_138_15
					end

					if var_138_18.prefab_name ~= "" and arg_135_1.actors_[var_138_18.prefab_name] ~= nil then
						local var_138_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_18.prefab_name].transform, "story_v_out_411051", "411051031", "story_v_out_411051.awb")

						arg_135_1:RecordAudio("411051031", var_138_24)
						arg_135_1:RecordAudio("411051031", var_138_24)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_411051", "411051031", "story_v_out_411051.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_411051", "411051031", "story_v_out_411051.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_25 = math.max(var_138_16, arg_135_1.talkMaxDuration)

			if var_138_15 <= arg_135_1.time_ and arg_135_1.time_ < var_138_15 + var_138_25 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_15) / var_138_25

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_15 + var_138_25 and arg_135_1.time_ < var_138_15 + var_138_25 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10014ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_135_1:InitPlayNodeList()
	end,
	Play411051032 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 411051032
		arg_139_1.duration_ = 4.1

		local var_139_0 = {
			zh = 2.6,
			ja = 4.1
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
				arg_139_0:Play411051033(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = arg_139_1.actors_["10058ui_story"].transform
			local var_142_1 = 0

			if var_142_1 < arg_139_1.time_ and arg_139_1.time_ <= var_142_1 + arg_142_0 then
				arg_139_1.var_.moveOldPos10058ui_story = var_142_0.localPosition
			end

			local var_142_2 = 0.001

			if var_142_1 <= arg_139_1.time_ and arg_139_1.time_ < var_142_1 + var_142_2 then
				local var_142_3 = (arg_139_1.time_ - var_142_1) / var_142_2
				local var_142_4 = Vector3.New(-0.7, -0.98, -6.1)

				var_142_0.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos10058ui_story, var_142_4, var_142_3)

				local var_142_5 = manager.ui.mainCamera.transform.position - var_142_0.position

				var_142_0.forward = Vector3.New(var_142_5.x, var_142_5.y, var_142_5.z)

				local var_142_6 = var_142_0.localEulerAngles

				var_142_6.z = 0
				var_142_6.x = 0
				var_142_0.localEulerAngles = var_142_6
			end

			if arg_139_1.time_ >= var_142_1 + var_142_2 and arg_139_1.time_ < var_142_1 + var_142_2 + arg_142_0 then
				var_142_0.localPosition = Vector3.New(-0.7, -0.98, -6.1)

				local var_142_7 = manager.ui.mainCamera.transform.position - var_142_0.position

				var_142_0.forward = Vector3.New(var_142_7.x, var_142_7.y, var_142_7.z)

				local var_142_8 = var_142_0.localEulerAngles

				var_142_8.z = 0
				var_142_8.x = 0
				var_142_0.localEulerAngles = var_142_8
			end

			local var_142_9 = arg_139_1.actors_["10058ui_story"]
			local var_142_10 = 0

			if var_142_10 < arg_139_1.time_ and arg_139_1.time_ <= var_142_10 + arg_142_0 and not isNil(var_142_9) and arg_139_1.var_.characterEffect10058ui_story == nil then
				arg_139_1.var_.characterEffect10058ui_story = var_142_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_11 = 0.200000002980232

			if var_142_10 <= arg_139_1.time_ and arg_139_1.time_ < var_142_10 + var_142_11 and not isNil(var_142_9) then
				local var_142_12 = (arg_139_1.time_ - var_142_10) / var_142_11

				if arg_139_1.var_.characterEffect10058ui_story and not isNil(var_142_9) then
					arg_139_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_139_1.time_ >= var_142_10 + var_142_11 and arg_139_1.time_ < var_142_10 + var_142_11 + arg_142_0 and not isNil(var_142_9) and arg_139_1.var_.characterEffect10058ui_story then
				arg_139_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_142_13 = 0

			if var_142_13 < arg_139_1.time_ and arg_139_1.time_ <= var_142_13 + arg_142_0 then
				arg_139_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0201cva")
			end

			local var_142_14 = arg_139_1.actors_["10014ui_story"]
			local var_142_15 = 0

			if var_142_15 < arg_139_1.time_ and arg_139_1.time_ <= var_142_15 + arg_142_0 and not isNil(var_142_14) and arg_139_1.var_.characterEffect10014ui_story == nil then
				arg_139_1.var_.characterEffect10014ui_story = var_142_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_16 = 0.200000002980232

			if var_142_15 <= arg_139_1.time_ and arg_139_1.time_ < var_142_15 + var_142_16 and not isNil(var_142_14) then
				local var_142_17 = (arg_139_1.time_ - var_142_15) / var_142_16

				if arg_139_1.var_.characterEffect10014ui_story and not isNil(var_142_14) then
					local var_142_18 = Mathf.Lerp(0, 0.5, var_142_17)

					arg_139_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_139_1.var_.characterEffect10014ui_story.fillRatio = var_142_18
				end
			end

			if arg_139_1.time_ >= var_142_15 + var_142_16 and arg_139_1.time_ < var_142_15 + var_142_16 + arg_142_0 and not isNil(var_142_14) and arg_139_1.var_.characterEffect10014ui_story then
				local var_142_19 = 0.5

				arg_139_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_139_1.var_.characterEffect10014ui_story.fillRatio = var_142_19
			end

			local var_142_20 = 0
			local var_142_21 = 0.35

			if var_142_20 < arg_139_1.time_ and arg_139_1.time_ <= var_142_20 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				local var_142_22 = arg_139_1:FormatText(StoryNameCfg[471].name)

				arg_139_1.leftNameTxt_.text = var_142_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_23 = arg_139_1:GetWordFromCfg(411051032)
				local var_142_24 = arg_139_1:FormatText(var_142_23.content)

				arg_139_1.text_.text = var_142_24

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_25 = 14
				local var_142_26 = utf8.len(var_142_24)
				local var_142_27 = var_142_25 <= 0 and var_142_21 or var_142_21 * (var_142_26 / var_142_25)

				if var_142_27 > 0 and var_142_21 < var_142_27 then
					arg_139_1.talkMaxDuration = var_142_27

					if var_142_27 + var_142_20 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_27 + var_142_20
					end
				end

				arg_139_1.text_.text = var_142_24
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051032", "story_v_out_411051.awb") ~= 0 then
					local var_142_28 = manager.audio:GetVoiceLength("story_v_out_411051", "411051032", "story_v_out_411051.awb") / 1000

					if var_142_28 + var_142_20 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_28 + var_142_20
					end

					if var_142_23.prefab_name ~= "" and arg_139_1.actors_[var_142_23.prefab_name] ~= nil then
						local var_142_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_23.prefab_name].transform, "story_v_out_411051", "411051032", "story_v_out_411051.awb")

						arg_139_1:RecordAudio("411051032", var_142_29)
						arg_139_1:RecordAudio("411051032", var_142_29)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_411051", "411051032", "story_v_out_411051.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_411051", "411051032", "story_v_out_411051.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_30 = math.max(var_142_21, arg_139_1.talkMaxDuration)

			if var_142_20 <= arg_139_1.time_ and arg_139_1.time_ < var_142_20 + var_142_30 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_20) / var_142_30

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_20 + var_142_30 and arg_139_1.time_ < var_142_20 + var_142_30 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
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
	Play411051033 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 411051033
		arg_143_1.duration_ = 9.17

		local var_143_0 = {
			zh = 8.966,
			ja = 9.166
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
				arg_143_0:Play411051034(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = arg_143_1.actors_["10058ui_story"]
			local var_146_1 = 0

			if var_146_1 < arg_143_1.time_ and arg_143_1.time_ <= var_146_1 + arg_146_0 and not isNil(var_146_0) and arg_143_1.var_.characterEffect10058ui_story == nil then
				arg_143_1.var_.characterEffect10058ui_story = var_146_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_2 = 0.200000002980232

			if var_146_1 <= arg_143_1.time_ and arg_143_1.time_ < var_146_1 + var_146_2 and not isNil(var_146_0) then
				local var_146_3 = (arg_143_1.time_ - var_146_1) / var_146_2

				if arg_143_1.var_.characterEffect10058ui_story and not isNil(var_146_0) then
					local var_146_4 = Mathf.Lerp(0, 0.5, var_146_3)

					arg_143_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_143_1.var_.characterEffect10058ui_story.fillRatio = var_146_4
				end
			end

			if arg_143_1.time_ >= var_146_1 + var_146_2 and arg_143_1.time_ < var_146_1 + var_146_2 + arg_146_0 and not isNil(var_146_0) and arg_143_1.var_.characterEffect10058ui_story then
				local var_146_5 = 0.5

				arg_143_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_143_1.var_.characterEffect10058ui_story.fillRatio = var_146_5
			end

			local var_146_6 = arg_143_1.actors_["10014ui_story"]
			local var_146_7 = 0

			if var_146_7 < arg_143_1.time_ and arg_143_1.time_ <= var_146_7 + arg_146_0 and not isNil(var_146_6) and arg_143_1.var_.characterEffect10014ui_story == nil then
				arg_143_1.var_.characterEffect10014ui_story = var_146_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_8 = 0.200000002980232

			if var_146_7 <= arg_143_1.time_ and arg_143_1.time_ < var_146_7 + var_146_8 and not isNil(var_146_6) then
				local var_146_9 = (arg_143_1.time_ - var_146_7) / var_146_8

				if arg_143_1.var_.characterEffect10014ui_story and not isNil(var_146_6) then
					arg_143_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_143_1.time_ >= var_146_7 + var_146_8 and arg_143_1.time_ < var_146_7 + var_146_8 + arg_146_0 and not isNil(var_146_6) and arg_143_1.var_.characterEffect10014ui_story then
				arg_143_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			local var_146_10 = 0
			local var_146_11 = 1.125

			if var_146_10 < arg_143_1.time_ and arg_143_1.time_ <= var_146_10 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				local var_146_12 = arg_143_1:FormatText(StoryNameCfg[264].name)

				arg_143_1.leftNameTxt_.text = var_146_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_13 = arg_143_1:GetWordFromCfg(411051033)
				local var_146_14 = arg_143_1:FormatText(var_146_13.content)

				arg_143_1.text_.text = var_146_14

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_15 = 45
				local var_146_16 = utf8.len(var_146_14)
				local var_146_17 = var_146_15 <= 0 and var_146_11 or var_146_11 * (var_146_16 / var_146_15)

				if var_146_17 > 0 and var_146_11 < var_146_17 then
					arg_143_1.talkMaxDuration = var_146_17

					if var_146_17 + var_146_10 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_17 + var_146_10
					end
				end

				arg_143_1.text_.text = var_146_14
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051033", "story_v_out_411051.awb") ~= 0 then
					local var_146_18 = manager.audio:GetVoiceLength("story_v_out_411051", "411051033", "story_v_out_411051.awb") / 1000

					if var_146_18 + var_146_10 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_18 + var_146_10
					end

					if var_146_13.prefab_name ~= "" and arg_143_1.actors_[var_146_13.prefab_name] ~= nil then
						local var_146_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_13.prefab_name].transform, "story_v_out_411051", "411051033", "story_v_out_411051.awb")

						arg_143_1:RecordAudio("411051033", var_146_19)
						arg_143_1:RecordAudio("411051033", var_146_19)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_411051", "411051033", "story_v_out_411051.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_411051", "411051033", "story_v_out_411051.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_20 = math.max(var_146_11, arg_143_1.talkMaxDuration)

			if var_146_10 <= arg_143_1.time_ and arg_143_1.time_ < var_146_10 + var_146_20 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_10) / var_146_20

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_10 + var_146_20 and arg_143_1.time_ < var_146_10 + var_146_20 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play411051034 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 411051034
		arg_147_1.duration_ = 4

		local var_147_0 = {
			zh = 1.033,
			ja = 4
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
				arg_147_0:Play411051035(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = arg_147_1.actors_["10058ui_story"]
			local var_150_1 = 0

			if var_150_1 < arg_147_1.time_ and arg_147_1.time_ <= var_150_1 + arg_150_0 and not isNil(var_150_0) and arg_147_1.var_.characterEffect10058ui_story == nil then
				arg_147_1.var_.characterEffect10058ui_story = var_150_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_2 = 0.200000002980232

			if var_150_1 <= arg_147_1.time_ and arg_147_1.time_ < var_150_1 + var_150_2 and not isNil(var_150_0) then
				local var_150_3 = (arg_147_1.time_ - var_150_1) / var_150_2

				if arg_147_1.var_.characterEffect10058ui_story and not isNil(var_150_0) then
					arg_147_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_147_1.time_ >= var_150_1 + var_150_2 and arg_147_1.time_ < var_150_1 + var_150_2 + arg_150_0 and not isNil(var_150_0) and arg_147_1.var_.characterEffect10058ui_story then
				arg_147_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_150_4 = arg_147_1.actors_["10014ui_story"]
			local var_150_5 = 0

			if var_150_5 < arg_147_1.time_ and arg_147_1.time_ <= var_150_5 + arg_150_0 and not isNil(var_150_4) and arg_147_1.var_.characterEffect10014ui_story == nil then
				arg_147_1.var_.characterEffect10014ui_story = var_150_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_6 = 0.200000002980232

			if var_150_5 <= arg_147_1.time_ and arg_147_1.time_ < var_150_5 + var_150_6 and not isNil(var_150_4) then
				local var_150_7 = (arg_147_1.time_ - var_150_5) / var_150_6

				if arg_147_1.var_.characterEffect10014ui_story and not isNil(var_150_4) then
					local var_150_8 = Mathf.Lerp(0, 0.5, var_150_7)

					arg_147_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_147_1.var_.characterEffect10014ui_story.fillRatio = var_150_8
				end
			end

			if arg_147_1.time_ >= var_150_5 + var_150_6 and arg_147_1.time_ < var_150_5 + var_150_6 + arg_150_0 and not isNil(var_150_4) and arg_147_1.var_.characterEffect10014ui_story then
				local var_150_9 = 0.5

				arg_147_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_147_1.var_.characterEffect10014ui_story.fillRatio = var_150_9
			end

			local var_150_10 = 0
			local var_150_11 = 0.125

			if var_150_10 < arg_147_1.time_ and arg_147_1.time_ <= var_150_10 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				local var_150_12 = arg_147_1:FormatText(StoryNameCfg[471].name)

				arg_147_1.leftNameTxt_.text = var_150_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_13 = arg_147_1:GetWordFromCfg(411051034)
				local var_150_14 = arg_147_1:FormatText(var_150_13.content)

				arg_147_1.text_.text = var_150_14

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_15 = 5
				local var_150_16 = utf8.len(var_150_14)
				local var_150_17 = var_150_15 <= 0 and var_150_11 or var_150_11 * (var_150_16 / var_150_15)

				if var_150_17 > 0 and var_150_11 < var_150_17 then
					arg_147_1.talkMaxDuration = var_150_17

					if var_150_17 + var_150_10 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_17 + var_150_10
					end
				end

				arg_147_1.text_.text = var_150_14
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051034", "story_v_out_411051.awb") ~= 0 then
					local var_150_18 = manager.audio:GetVoiceLength("story_v_out_411051", "411051034", "story_v_out_411051.awb") / 1000

					if var_150_18 + var_150_10 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_18 + var_150_10
					end

					if var_150_13.prefab_name ~= "" and arg_147_1.actors_[var_150_13.prefab_name] ~= nil then
						local var_150_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_13.prefab_name].transform, "story_v_out_411051", "411051034", "story_v_out_411051.awb")

						arg_147_1:RecordAudio("411051034", var_150_19)
						arg_147_1:RecordAudio("411051034", var_150_19)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_411051", "411051034", "story_v_out_411051.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_411051", "411051034", "story_v_out_411051.awb")
				end

				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_20 = math.max(var_150_11, arg_147_1.talkMaxDuration)

			if var_150_10 <= arg_147_1.time_ and arg_147_1.time_ < var_150_10 + var_150_20 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_10) / var_150_20

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_10 + var_150_20 and arg_147_1.time_ < var_150_10 + var_150_20 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play411051035 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 411051035
		arg_151_1.duration_ = 6.3

		local var_151_0 = {
			zh = 4.3,
			ja = 6.3
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
				arg_151_0:Play411051036(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = 0

			if var_154_0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_0 + arg_154_0 then
				arg_151_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_154_1 = 0
			local var_154_2 = 0.575

			if var_154_1 < arg_151_1.time_ and arg_151_1.time_ <= var_154_1 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				local var_154_3 = arg_151_1:FormatText(StoryNameCfg[471].name)

				arg_151_1.leftNameTxt_.text = var_154_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_4 = arg_151_1:GetWordFromCfg(411051035)
				local var_154_5 = arg_151_1:FormatText(var_154_4.content)

				arg_151_1.text_.text = var_154_5

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_6 = 23
				local var_154_7 = utf8.len(var_154_5)
				local var_154_8 = var_154_6 <= 0 and var_154_2 or var_154_2 * (var_154_7 / var_154_6)

				if var_154_8 > 0 and var_154_2 < var_154_8 then
					arg_151_1.talkMaxDuration = var_154_8

					if var_154_8 + var_154_1 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_8 + var_154_1
					end
				end

				arg_151_1.text_.text = var_154_5
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051035", "story_v_out_411051.awb") ~= 0 then
					local var_154_9 = manager.audio:GetVoiceLength("story_v_out_411051", "411051035", "story_v_out_411051.awb") / 1000

					if var_154_9 + var_154_1 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_9 + var_154_1
					end

					if var_154_4.prefab_name ~= "" and arg_151_1.actors_[var_154_4.prefab_name] ~= nil then
						local var_154_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_4.prefab_name].transform, "story_v_out_411051", "411051035", "story_v_out_411051.awb")

						arg_151_1:RecordAudio("411051035", var_154_10)
						arg_151_1:RecordAudio("411051035", var_154_10)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_411051", "411051035", "story_v_out_411051.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_411051", "411051035", "story_v_out_411051.awb")
				end

				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_11 = math.max(var_154_2, arg_151_1.talkMaxDuration)

			if var_154_1 <= arg_151_1.time_ and arg_151_1.time_ < var_154_1 + var_154_11 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_1) / var_154_11

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_1 + var_154_11 and arg_151_1.time_ < var_154_1 + var_154_11 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play411051036 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 411051036
		arg_155_1.duration_ = 3.93

		local var_155_0 = {
			zh = 2.033,
			ja = 3.933
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
				arg_155_0:Play411051037(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = arg_155_1.actors_["10014ui_story"].transform
			local var_158_1 = 0

			if var_158_1 < arg_155_1.time_ and arg_155_1.time_ <= var_158_1 + arg_158_0 then
				arg_155_1.var_.moveOldPos10014ui_story = var_158_0.localPosition
			end

			local var_158_2 = 0.001

			if var_158_1 <= arg_155_1.time_ and arg_155_1.time_ < var_158_1 + var_158_2 then
				local var_158_3 = (arg_155_1.time_ - var_158_1) / var_158_2
				local var_158_4 = Vector3.New(0.7, -1.06, -6.2)

				var_158_0.localPosition = Vector3.Lerp(arg_155_1.var_.moveOldPos10014ui_story, var_158_4, var_158_3)

				local var_158_5 = manager.ui.mainCamera.transform.position - var_158_0.position

				var_158_0.forward = Vector3.New(var_158_5.x, var_158_5.y, var_158_5.z)

				local var_158_6 = var_158_0.localEulerAngles

				var_158_6.z = 0
				var_158_6.x = 0
				var_158_0.localEulerAngles = var_158_6
			end

			if arg_155_1.time_ >= var_158_1 + var_158_2 and arg_155_1.time_ < var_158_1 + var_158_2 + arg_158_0 then
				var_158_0.localPosition = Vector3.New(0.7, -1.06, -6.2)

				local var_158_7 = manager.ui.mainCamera.transform.position - var_158_0.position

				var_158_0.forward = Vector3.New(var_158_7.x, var_158_7.y, var_158_7.z)

				local var_158_8 = var_158_0.localEulerAngles

				var_158_8.z = 0
				var_158_8.x = 0
				var_158_0.localEulerAngles = var_158_8
			end

			local var_158_9 = arg_155_1.actors_["10014ui_story"]
			local var_158_10 = 0

			if var_158_10 < arg_155_1.time_ and arg_155_1.time_ <= var_158_10 + arg_158_0 and not isNil(var_158_9) and arg_155_1.var_.characterEffect10014ui_story == nil then
				arg_155_1.var_.characterEffect10014ui_story = var_158_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_158_11 = 0.200000002980232

			if var_158_10 <= arg_155_1.time_ and arg_155_1.time_ < var_158_10 + var_158_11 and not isNil(var_158_9) then
				local var_158_12 = (arg_155_1.time_ - var_158_10) / var_158_11

				if arg_155_1.var_.characterEffect10014ui_story and not isNil(var_158_9) then
					arg_155_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_155_1.time_ >= var_158_10 + var_158_11 and arg_155_1.time_ < var_158_10 + var_158_11 + arg_158_0 and not isNil(var_158_9) and arg_155_1.var_.characterEffect10014ui_story then
				arg_155_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			local var_158_13 = 0

			if var_158_13 < arg_155_1.time_ and arg_155_1.time_ <= var_158_13 + arg_158_0 then
				arg_155_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/story10014/story10014action/10014action3_1")
			end

			local var_158_14 = 0

			if var_158_14 < arg_155_1.time_ and arg_155_1.time_ <= var_158_14 + arg_158_0 then
				arg_155_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_158_15 = arg_155_1.actors_["10058ui_story"]
			local var_158_16 = 0

			if var_158_16 < arg_155_1.time_ and arg_155_1.time_ <= var_158_16 + arg_158_0 and not isNil(var_158_15) and arg_155_1.var_.characterEffect10058ui_story == nil then
				arg_155_1.var_.characterEffect10058ui_story = var_158_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_158_17 = 0.200000002980232

			if var_158_16 <= arg_155_1.time_ and arg_155_1.time_ < var_158_16 + var_158_17 and not isNil(var_158_15) then
				local var_158_18 = (arg_155_1.time_ - var_158_16) / var_158_17

				if arg_155_1.var_.characterEffect10058ui_story and not isNil(var_158_15) then
					local var_158_19 = Mathf.Lerp(0, 0.5, var_158_18)

					arg_155_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_155_1.var_.characterEffect10058ui_story.fillRatio = var_158_19
				end
			end

			if arg_155_1.time_ >= var_158_16 + var_158_17 and arg_155_1.time_ < var_158_16 + var_158_17 + arg_158_0 and not isNil(var_158_15) and arg_155_1.var_.characterEffect10058ui_story then
				local var_158_20 = 0.5

				arg_155_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_155_1.var_.characterEffect10058ui_story.fillRatio = var_158_20
			end

			local var_158_21 = 0
			local var_158_22 = 0.25

			if var_158_21 < arg_155_1.time_ and arg_155_1.time_ <= var_158_21 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				local var_158_23 = arg_155_1:FormatText(StoryNameCfg[264].name)

				arg_155_1.leftNameTxt_.text = var_158_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_24 = arg_155_1:GetWordFromCfg(411051036)
				local var_158_25 = arg_155_1:FormatText(var_158_24.content)

				arg_155_1.text_.text = var_158_25

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_26 = 10
				local var_158_27 = utf8.len(var_158_25)
				local var_158_28 = var_158_26 <= 0 and var_158_22 or var_158_22 * (var_158_27 / var_158_26)

				if var_158_28 > 0 and var_158_22 < var_158_28 then
					arg_155_1.talkMaxDuration = var_158_28

					if var_158_28 + var_158_21 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_28 + var_158_21
					end
				end

				arg_155_1.text_.text = var_158_25
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051036", "story_v_out_411051.awb") ~= 0 then
					local var_158_29 = manager.audio:GetVoiceLength("story_v_out_411051", "411051036", "story_v_out_411051.awb") / 1000

					if var_158_29 + var_158_21 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_29 + var_158_21
					end

					if var_158_24.prefab_name ~= "" and arg_155_1.actors_[var_158_24.prefab_name] ~= nil then
						local var_158_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_24.prefab_name].transform, "story_v_out_411051", "411051036", "story_v_out_411051.awb")

						arg_155_1:RecordAudio("411051036", var_158_30)
						arg_155_1:RecordAudio("411051036", var_158_30)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_411051", "411051036", "story_v_out_411051.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_411051", "411051036", "story_v_out_411051.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_31 = math.max(var_158_22, arg_155_1.talkMaxDuration)

			if var_158_21 <= arg_155_1.time_ and arg_155_1.time_ < var_158_21 + var_158_31 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_21) / var_158_31

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_21 + var_158_31 and arg_155_1.time_ < var_158_21 + var_158_31 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10014ui_story",
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
	Play411051037 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 411051037
		arg_159_1.duration_ = 3.03

		local var_159_0 = {
			zh = 3.033,
			ja = 1.8
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
				arg_159_0:Play411051038(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = arg_159_1.actors_["10014ui_story"]
			local var_162_1 = 0

			if var_162_1 < arg_159_1.time_ and arg_159_1.time_ <= var_162_1 + arg_162_0 and not isNil(var_162_0) and arg_159_1.var_.characterEffect10014ui_story == nil then
				arg_159_1.var_.characterEffect10014ui_story = var_162_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_162_2 = 0.200000002980232

			if var_162_1 <= arg_159_1.time_ and arg_159_1.time_ < var_162_1 + var_162_2 and not isNil(var_162_0) then
				local var_162_3 = (arg_159_1.time_ - var_162_1) / var_162_2

				if arg_159_1.var_.characterEffect10014ui_story and not isNil(var_162_0) then
					local var_162_4 = Mathf.Lerp(0, 0.5, var_162_3)

					arg_159_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_159_1.var_.characterEffect10014ui_story.fillRatio = var_162_4
				end
			end

			if arg_159_1.time_ >= var_162_1 + var_162_2 and arg_159_1.time_ < var_162_1 + var_162_2 + arg_162_0 and not isNil(var_162_0) and arg_159_1.var_.characterEffect10014ui_story then
				local var_162_5 = 0.5

				arg_159_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_159_1.var_.characterEffect10014ui_story.fillRatio = var_162_5
			end

			local var_162_6 = arg_159_1.actors_["10058ui_story"]
			local var_162_7 = 0

			if var_162_7 < arg_159_1.time_ and arg_159_1.time_ <= var_162_7 + arg_162_0 and not isNil(var_162_6) and arg_159_1.var_.characterEffect10058ui_story == nil then
				arg_159_1.var_.characterEffect10058ui_story = var_162_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_162_8 = 0.200000002980232

			if var_162_7 <= arg_159_1.time_ and arg_159_1.time_ < var_162_7 + var_162_8 and not isNil(var_162_6) then
				local var_162_9 = (arg_159_1.time_ - var_162_7) / var_162_8

				if arg_159_1.var_.characterEffect10058ui_story and not isNil(var_162_6) then
					arg_159_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_159_1.time_ >= var_162_7 + var_162_8 and arg_159_1.time_ < var_162_7 + var_162_8 + arg_162_0 and not isNil(var_162_6) and arg_159_1.var_.characterEffect10058ui_story then
				arg_159_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_162_10 = 0
			local var_162_11 = 0.35

			if var_162_10 < arg_159_1.time_ and arg_159_1.time_ <= var_162_10 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				local var_162_12 = arg_159_1:FormatText(StoryNameCfg[471].name)

				arg_159_1.leftNameTxt_.text = var_162_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_13 = arg_159_1:GetWordFromCfg(411051037)
				local var_162_14 = arg_159_1:FormatText(var_162_13.content)

				arg_159_1.text_.text = var_162_14

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_15 = 14
				local var_162_16 = utf8.len(var_162_14)
				local var_162_17 = var_162_15 <= 0 and var_162_11 or var_162_11 * (var_162_16 / var_162_15)

				if var_162_17 > 0 and var_162_11 < var_162_17 then
					arg_159_1.talkMaxDuration = var_162_17

					if var_162_17 + var_162_10 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_17 + var_162_10
					end
				end

				arg_159_1.text_.text = var_162_14
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051037", "story_v_out_411051.awb") ~= 0 then
					local var_162_18 = manager.audio:GetVoiceLength("story_v_out_411051", "411051037", "story_v_out_411051.awb") / 1000

					if var_162_18 + var_162_10 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_18 + var_162_10
					end

					if var_162_13.prefab_name ~= "" and arg_159_1.actors_[var_162_13.prefab_name] ~= nil then
						local var_162_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_13.prefab_name].transform, "story_v_out_411051", "411051037", "story_v_out_411051.awb")

						arg_159_1:RecordAudio("411051037", var_162_19)
						arg_159_1:RecordAudio("411051037", var_162_19)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_411051", "411051037", "story_v_out_411051.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_411051", "411051037", "story_v_out_411051.awb")
				end

				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_20 = math.max(var_162_11, arg_159_1.talkMaxDuration)

			if var_162_10 <= arg_159_1.time_ and arg_159_1.time_ < var_162_10 + var_162_20 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_10) / var_162_20

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_10 + var_162_20 and arg_159_1.time_ < var_162_10 + var_162_20 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play411051038 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 411051038
		arg_163_1.duration_ = 11.5

		local var_163_0 = {
			zh = 11.5,
			ja = 8
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
				arg_163_0:Play411051039(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = arg_163_1.actors_["10014ui_story"]
			local var_166_1 = 0

			if var_166_1 < arg_163_1.time_ and arg_163_1.time_ <= var_166_1 + arg_166_0 and not isNil(var_166_0) and arg_163_1.var_.characterEffect10014ui_story == nil then
				arg_163_1.var_.characterEffect10014ui_story = var_166_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_166_2 = 0.200000002980232

			if var_166_1 <= arg_163_1.time_ and arg_163_1.time_ < var_166_1 + var_166_2 and not isNil(var_166_0) then
				local var_166_3 = (arg_163_1.time_ - var_166_1) / var_166_2

				if arg_163_1.var_.characterEffect10014ui_story and not isNil(var_166_0) then
					arg_163_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_163_1.time_ >= var_166_1 + var_166_2 and arg_163_1.time_ < var_166_1 + var_166_2 + arg_166_0 and not isNil(var_166_0) and arg_163_1.var_.characterEffect10014ui_story then
				arg_163_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			local var_166_4 = arg_163_1.actors_["10058ui_story"]
			local var_166_5 = 0

			if var_166_5 < arg_163_1.time_ and arg_163_1.time_ <= var_166_5 + arg_166_0 and not isNil(var_166_4) and arg_163_1.var_.characterEffect10058ui_story == nil then
				arg_163_1.var_.characterEffect10058ui_story = var_166_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_166_6 = 0.200000002980232

			if var_166_5 <= arg_163_1.time_ and arg_163_1.time_ < var_166_5 + var_166_6 and not isNil(var_166_4) then
				local var_166_7 = (arg_163_1.time_ - var_166_5) / var_166_6

				if arg_163_1.var_.characterEffect10058ui_story and not isNil(var_166_4) then
					local var_166_8 = Mathf.Lerp(0, 0.5, var_166_7)

					arg_163_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_163_1.var_.characterEffect10058ui_story.fillRatio = var_166_8
				end
			end

			if arg_163_1.time_ >= var_166_5 + var_166_6 and arg_163_1.time_ < var_166_5 + var_166_6 + arg_166_0 and not isNil(var_166_4) and arg_163_1.var_.characterEffect10058ui_story then
				local var_166_9 = 0.5

				arg_163_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_163_1.var_.characterEffect10058ui_story.fillRatio = var_166_9
			end

			local var_166_10 = 0
			local var_166_11 = 1.3

			if var_166_10 < arg_163_1.time_ and arg_163_1.time_ <= var_166_10 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				local var_166_12 = arg_163_1:FormatText(StoryNameCfg[264].name)

				arg_163_1.leftNameTxt_.text = var_166_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_13 = arg_163_1:GetWordFromCfg(411051038)
				local var_166_14 = arg_163_1:FormatText(var_166_13.content)

				arg_163_1.text_.text = var_166_14

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_15 = 52
				local var_166_16 = utf8.len(var_166_14)
				local var_166_17 = var_166_15 <= 0 and var_166_11 or var_166_11 * (var_166_16 / var_166_15)

				if var_166_17 > 0 and var_166_11 < var_166_17 then
					arg_163_1.talkMaxDuration = var_166_17

					if var_166_17 + var_166_10 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_17 + var_166_10
					end
				end

				arg_163_1.text_.text = var_166_14
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051038", "story_v_out_411051.awb") ~= 0 then
					local var_166_18 = manager.audio:GetVoiceLength("story_v_out_411051", "411051038", "story_v_out_411051.awb") / 1000

					if var_166_18 + var_166_10 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_18 + var_166_10
					end

					if var_166_13.prefab_name ~= "" and arg_163_1.actors_[var_166_13.prefab_name] ~= nil then
						local var_166_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_13.prefab_name].transform, "story_v_out_411051", "411051038", "story_v_out_411051.awb")

						arg_163_1:RecordAudio("411051038", var_166_19)
						arg_163_1:RecordAudio("411051038", var_166_19)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_411051", "411051038", "story_v_out_411051.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_411051", "411051038", "story_v_out_411051.awb")
				end

				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_20 = math.max(var_166_11, arg_163_1.talkMaxDuration)

			if var_166_10 <= arg_163_1.time_ and arg_163_1.time_ < var_166_10 + var_166_20 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_10) / var_166_20

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_10 + var_166_20 and arg_163_1.time_ < var_166_10 + var_166_20 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {}

		arg_163_1:InitPlayNodeList()
	end,
	Play411051039 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 411051039
		arg_167_1.duration_ = 8.23

		local var_167_0 = {
			zh = 5.8,
			ja = 8.233
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
				arg_167_0:Play411051040(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = 0
			local var_170_1 = 0.75

			if var_170_0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_0 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				local var_170_2 = arg_167_1:FormatText(StoryNameCfg[264].name)

				arg_167_1.leftNameTxt_.text = var_170_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_3 = arg_167_1:GetWordFromCfg(411051039)
				local var_170_4 = arg_167_1:FormatText(var_170_3.content)

				arg_167_1.text_.text = var_170_4

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_5 = 30
				local var_170_6 = utf8.len(var_170_4)
				local var_170_7 = var_170_5 <= 0 and var_170_1 or var_170_1 * (var_170_6 / var_170_5)

				if var_170_7 > 0 and var_170_1 < var_170_7 then
					arg_167_1.talkMaxDuration = var_170_7

					if var_170_7 + var_170_0 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_7 + var_170_0
					end
				end

				arg_167_1.text_.text = var_170_4
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051039", "story_v_out_411051.awb") ~= 0 then
					local var_170_8 = manager.audio:GetVoiceLength("story_v_out_411051", "411051039", "story_v_out_411051.awb") / 1000

					if var_170_8 + var_170_0 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_8 + var_170_0
					end

					if var_170_3.prefab_name ~= "" and arg_167_1.actors_[var_170_3.prefab_name] ~= nil then
						local var_170_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_3.prefab_name].transform, "story_v_out_411051", "411051039", "story_v_out_411051.awb")

						arg_167_1:RecordAudio("411051039", var_170_9)
						arg_167_1:RecordAudio("411051039", var_170_9)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_411051", "411051039", "story_v_out_411051.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_411051", "411051039", "story_v_out_411051.awb")
				end

				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_10 = math.max(var_170_1, arg_167_1.talkMaxDuration)

			if var_170_0 <= arg_167_1.time_ and arg_167_1.time_ < var_170_0 + var_170_10 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_0) / var_170_10

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_0 + var_170_10 and arg_167_1.time_ < var_170_0 + var_170_10 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {}

		arg_167_1:InitPlayNodeList()
	end,
	Play411051040 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 411051040
		arg_171_1.duration_ = 4.6

		local var_171_0 = {
			zh = 2.666,
			ja = 4.6
		}
		local var_171_1 = manager.audio:GetLocalizationFlag()

		if var_171_0[var_171_1] ~= nil then
			arg_171_1.duration_ = var_171_0[var_171_1]
		end

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play411051041(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = arg_171_1.actors_["10058ui_story"].transform
			local var_174_1 = 0

			if var_174_1 < arg_171_1.time_ and arg_171_1.time_ <= var_174_1 + arg_174_0 then
				arg_171_1.var_.moveOldPos10058ui_story = var_174_0.localPosition
			end

			local var_174_2 = 0.001

			if var_174_1 <= arg_171_1.time_ and arg_171_1.time_ < var_174_1 + var_174_2 then
				local var_174_3 = (arg_171_1.time_ - var_174_1) / var_174_2
				local var_174_4 = Vector3.New(-0.7, -0.98, -6.1)

				var_174_0.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos10058ui_story, var_174_4, var_174_3)

				local var_174_5 = manager.ui.mainCamera.transform.position - var_174_0.position

				var_174_0.forward = Vector3.New(var_174_5.x, var_174_5.y, var_174_5.z)

				local var_174_6 = var_174_0.localEulerAngles

				var_174_6.z = 0
				var_174_6.x = 0
				var_174_0.localEulerAngles = var_174_6
			end

			if arg_171_1.time_ >= var_174_1 + var_174_2 and arg_171_1.time_ < var_174_1 + var_174_2 + arg_174_0 then
				var_174_0.localPosition = Vector3.New(-0.7, -0.98, -6.1)

				local var_174_7 = manager.ui.mainCamera.transform.position - var_174_0.position

				var_174_0.forward = Vector3.New(var_174_7.x, var_174_7.y, var_174_7.z)

				local var_174_8 = var_174_0.localEulerAngles

				var_174_8.z = 0
				var_174_8.x = 0
				var_174_0.localEulerAngles = var_174_8
			end

			local var_174_9 = arg_171_1.actors_["10058ui_story"]
			local var_174_10 = 0

			if var_174_10 < arg_171_1.time_ and arg_171_1.time_ <= var_174_10 + arg_174_0 and not isNil(var_174_9) and arg_171_1.var_.characterEffect10058ui_story == nil then
				arg_171_1.var_.characterEffect10058ui_story = var_174_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_11 = 0.200000002980232

			if var_174_10 <= arg_171_1.time_ and arg_171_1.time_ < var_174_10 + var_174_11 and not isNil(var_174_9) then
				local var_174_12 = (arg_171_1.time_ - var_174_10) / var_174_11

				if arg_171_1.var_.characterEffect10058ui_story and not isNil(var_174_9) then
					arg_171_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_171_1.time_ >= var_174_10 + var_174_11 and arg_171_1.time_ < var_174_10 + var_174_11 + arg_174_0 and not isNil(var_174_9) and arg_171_1.var_.characterEffect10058ui_story then
				arg_171_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_174_13 = 0

			if var_174_13 < arg_171_1.time_ and arg_171_1.time_ <= var_174_13 + arg_174_0 then
				arg_171_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_1")
			end

			local var_174_14 = 0

			if var_174_14 < arg_171_1.time_ and arg_171_1.time_ <= var_174_14 + arg_174_0 then
				arg_171_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_174_15 = arg_171_1.actors_["10014ui_story"]
			local var_174_16 = 0

			if var_174_16 < arg_171_1.time_ and arg_171_1.time_ <= var_174_16 + arg_174_0 and not isNil(var_174_15) and arg_171_1.var_.characterEffect10014ui_story == nil then
				arg_171_1.var_.characterEffect10014ui_story = var_174_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_17 = 0.200000002980232

			if var_174_16 <= arg_171_1.time_ and arg_171_1.time_ < var_174_16 + var_174_17 and not isNil(var_174_15) then
				local var_174_18 = (arg_171_1.time_ - var_174_16) / var_174_17

				if arg_171_1.var_.characterEffect10014ui_story and not isNil(var_174_15) then
					local var_174_19 = Mathf.Lerp(0, 0.5, var_174_18)

					arg_171_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_171_1.var_.characterEffect10014ui_story.fillRatio = var_174_19
				end
			end

			if arg_171_1.time_ >= var_174_16 + var_174_17 and arg_171_1.time_ < var_174_16 + var_174_17 + arg_174_0 and not isNil(var_174_15) and arg_171_1.var_.characterEffect10014ui_story then
				local var_174_20 = 0.5

				arg_171_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_171_1.var_.characterEffect10014ui_story.fillRatio = var_174_20
			end

			local var_174_21 = 0
			local var_174_22 = 0.225

			if var_174_21 < arg_171_1.time_ and arg_171_1.time_ <= var_174_21 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				local var_174_23 = arg_171_1:FormatText(StoryNameCfg[471].name)

				arg_171_1.leftNameTxt_.text = var_174_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_24 = arg_171_1:GetWordFromCfg(411051040)
				local var_174_25 = arg_171_1:FormatText(var_174_24.content)

				arg_171_1.text_.text = var_174_25

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_26 = 9
				local var_174_27 = utf8.len(var_174_25)
				local var_174_28 = var_174_26 <= 0 and var_174_22 or var_174_22 * (var_174_27 / var_174_26)

				if var_174_28 > 0 and var_174_22 < var_174_28 then
					arg_171_1.talkMaxDuration = var_174_28

					if var_174_28 + var_174_21 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_28 + var_174_21
					end
				end

				arg_171_1.text_.text = var_174_25
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051040", "story_v_out_411051.awb") ~= 0 then
					local var_174_29 = manager.audio:GetVoiceLength("story_v_out_411051", "411051040", "story_v_out_411051.awb") / 1000

					if var_174_29 + var_174_21 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_29 + var_174_21
					end

					if var_174_24.prefab_name ~= "" and arg_171_1.actors_[var_174_24.prefab_name] ~= nil then
						local var_174_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_24.prefab_name].transform, "story_v_out_411051", "411051040", "story_v_out_411051.awb")

						arg_171_1:RecordAudio("411051040", var_174_30)
						arg_171_1:RecordAudio("411051040", var_174_30)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_out_411051", "411051040", "story_v_out_411051.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_out_411051", "411051040", "story_v_out_411051.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_31 = math.max(var_174_22, arg_171_1.talkMaxDuration)

			if var_174_21 <= arg_171_1.time_ and arg_171_1.time_ < var_174_21 + var_174_31 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_21) / var_174_31

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_21 + var_174_31 and arg_171_1.time_ < var_174_21 + var_174_31 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
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
	Play411051041 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 411051041
		arg_175_1.duration_ = 6.9

		local var_175_0 = {
			zh = 6.9,
			ja = 6.666
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
				arg_175_0:Play411051042(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = arg_175_1.actors_["10058ui_story"]
			local var_178_1 = 0

			if var_178_1 < arg_175_1.time_ and arg_175_1.time_ <= var_178_1 + arg_178_0 and not isNil(var_178_0) and arg_175_1.var_.characterEffect10058ui_story == nil then
				arg_175_1.var_.characterEffect10058ui_story = var_178_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_178_2 = 0.200000002980232

			if var_178_1 <= arg_175_1.time_ and arg_175_1.time_ < var_178_1 + var_178_2 and not isNil(var_178_0) then
				local var_178_3 = (arg_175_1.time_ - var_178_1) / var_178_2

				if arg_175_1.var_.characterEffect10058ui_story and not isNil(var_178_0) then
					local var_178_4 = Mathf.Lerp(0, 0.5, var_178_3)

					arg_175_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_175_1.var_.characterEffect10058ui_story.fillRatio = var_178_4
				end
			end

			if arg_175_1.time_ >= var_178_1 + var_178_2 and arg_175_1.time_ < var_178_1 + var_178_2 + arg_178_0 and not isNil(var_178_0) and arg_175_1.var_.characterEffect10058ui_story then
				local var_178_5 = 0.5

				arg_175_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_175_1.var_.characterEffect10058ui_story.fillRatio = var_178_5
			end

			local var_178_6 = arg_175_1.actors_["10014ui_story"]
			local var_178_7 = 0

			if var_178_7 < arg_175_1.time_ and arg_175_1.time_ <= var_178_7 + arg_178_0 and not isNil(var_178_6) and arg_175_1.var_.characterEffect10014ui_story == nil then
				arg_175_1.var_.characterEffect10014ui_story = var_178_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_178_8 = 0.200000002980232

			if var_178_7 <= arg_175_1.time_ and arg_175_1.time_ < var_178_7 + var_178_8 and not isNil(var_178_6) then
				local var_178_9 = (arg_175_1.time_ - var_178_7) / var_178_8

				if arg_175_1.var_.characterEffect10014ui_story and not isNil(var_178_6) then
					arg_175_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_175_1.time_ >= var_178_7 + var_178_8 and arg_175_1.time_ < var_178_7 + var_178_8 + arg_178_0 and not isNil(var_178_6) and arg_175_1.var_.characterEffect10014ui_story then
				arg_175_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			local var_178_10 = 0
			local var_178_11 = 0.875

			if var_178_10 < arg_175_1.time_ and arg_175_1.time_ <= var_178_10 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				local var_178_12 = arg_175_1:FormatText(StoryNameCfg[264].name)

				arg_175_1.leftNameTxt_.text = var_178_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_13 = arg_175_1:GetWordFromCfg(411051041)
				local var_178_14 = arg_175_1:FormatText(var_178_13.content)

				arg_175_1.text_.text = var_178_14

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_15 = 35
				local var_178_16 = utf8.len(var_178_14)
				local var_178_17 = var_178_15 <= 0 and var_178_11 or var_178_11 * (var_178_16 / var_178_15)

				if var_178_17 > 0 and var_178_11 < var_178_17 then
					arg_175_1.talkMaxDuration = var_178_17

					if var_178_17 + var_178_10 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_17 + var_178_10
					end
				end

				arg_175_1.text_.text = var_178_14
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051041", "story_v_out_411051.awb") ~= 0 then
					local var_178_18 = manager.audio:GetVoiceLength("story_v_out_411051", "411051041", "story_v_out_411051.awb") / 1000

					if var_178_18 + var_178_10 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_18 + var_178_10
					end

					if var_178_13.prefab_name ~= "" and arg_175_1.actors_[var_178_13.prefab_name] ~= nil then
						local var_178_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_13.prefab_name].transform, "story_v_out_411051", "411051041", "story_v_out_411051.awb")

						arg_175_1:RecordAudio("411051041", var_178_19)
						arg_175_1:RecordAudio("411051041", var_178_19)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_out_411051", "411051041", "story_v_out_411051.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_out_411051", "411051041", "story_v_out_411051.awb")
				end

				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_20 = math.max(var_178_11, arg_175_1.talkMaxDuration)

			if var_178_10 <= arg_175_1.time_ and arg_175_1.time_ < var_178_10 + var_178_20 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_10) / var_178_20

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_10 + var_178_20 and arg_175_1.time_ < var_178_10 + var_178_20 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {}

		arg_175_1:InitPlayNodeList()
	end,
	Play411051042 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 411051042
		arg_179_1.duration_ = 13.53

		local var_179_0 = {
			zh = 8.466,
			ja = 13.533
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
				arg_179_0:Play411051043(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = 0
			local var_182_1 = 1

			if var_182_0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_0 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				local var_182_2 = arg_179_1:FormatText(StoryNameCfg[264].name)

				arg_179_1.leftNameTxt_.text = var_182_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_3 = arg_179_1:GetWordFromCfg(411051042)
				local var_182_4 = arg_179_1:FormatText(var_182_3.content)

				arg_179_1.text_.text = var_182_4

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_5 = 40
				local var_182_6 = utf8.len(var_182_4)
				local var_182_7 = var_182_5 <= 0 and var_182_1 or var_182_1 * (var_182_6 / var_182_5)

				if var_182_7 > 0 and var_182_1 < var_182_7 then
					arg_179_1.talkMaxDuration = var_182_7

					if var_182_7 + var_182_0 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_7 + var_182_0
					end
				end

				arg_179_1.text_.text = var_182_4
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051042", "story_v_out_411051.awb") ~= 0 then
					local var_182_8 = manager.audio:GetVoiceLength("story_v_out_411051", "411051042", "story_v_out_411051.awb") / 1000

					if var_182_8 + var_182_0 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_8 + var_182_0
					end

					if var_182_3.prefab_name ~= "" and arg_179_1.actors_[var_182_3.prefab_name] ~= nil then
						local var_182_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_3.prefab_name].transform, "story_v_out_411051", "411051042", "story_v_out_411051.awb")

						arg_179_1:RecordAudio("411051042", var_182_9)
						arg_179_1:RecordAudio("411051042", var_182_9)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_out_411051", "411051042", "story_v_out_411051.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_out_411051", "411051042", "story_v_out_411051.awb")
				end

				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_10 = math.max(var_182_1, arg_179_1.talkMaxDuration)

			if var_182_0 <= arg_179_1.time_ and arg_179_1.time_ < var_182_0 + var_182_10 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_0) / var_182_10

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_0 + var_182_10 and arg_179_1.time_ < var_182_0 + var_182_10 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play411051043 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 411051043
		arg_183_1.duration_ = 3.73

		local var_183_0 = {
			zh = 3.666,
			ja = 3.733
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
				arg_183_0:Play411051044(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = 0
			local var_186_1 = 0.425

			if var_186_0 < arg_183_1.time_ and arg_183_1.time_ <= var_186_0 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				local var_186_2 = arg_183_1:FormatText(StoryNameCfg[264].name)

				arg_183_1.leftNameTxt_.text = var_186_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_3 = arg_183_1:GetWordFromCfg(411051043)
				local var_186_4 = arg_183_1:FormatText(var_186_3.content)

				arg_183_1.text_.text = var_186_4

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_5 = 17
				local var_186_6 = utf8.len(var_186_4)
				local var_186_7 = var_186_5 <= 0 and var_186_1 or var_186_1 * (var_186_6 / var_186_5)

				if var_186_7 > 0 and var_186_1 < var_186_7 then
					arg_183_1.talkMaxDuration = var_186_7

					if var_186_7 + var_186_0 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_7 + var_186_0
					end
				end

				arg_183_1.text_.text = var_186_4
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051043", "story_v_out_411051.awb") ~= 0 then
					local var_186_8 = manager.audio:GetVoiceLength("story_v_out_411051", "411051043", "story_v_out_411051.awb") / 1000

					if var_186_8 + var_186_0 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_8 + var_186_0
					end

					if var_186_3.prefab_name ~= "" and arg_183_1.actors_[var_186_3.prefab_name] ~= nil then
						local var_186_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_3.prefab_name].transform, "story_v_out_411051", "411051043", "story_v_out_411051.awb")

						arg_183_1:RecordAudio("411051043", var_186_9)
						arg_183_1:RecordAudio("411051043", var_186_9)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_out_411051", "411051043", "story_v_out_411051.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_out_411051", "411051043", "story_v_out_411051.awb")
				end

				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_10 = math.max(var_186_1, arg_183_1.talkMaxDuration)

			if var_186_0 <= arg_183_1.time_ and arg_183_1.time_ < var_186_0 + var_186_10 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_0) / var_186_10

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_0 + var_186_10 and arg_183_1.time_ < var_186_0 + var_186_10 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {}

		arg_183_1:InitPlayNodeList()
	end,
	Play411051044 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 411051044
		arg_187_1.duration_ = 1.33

		local var_187_0 = {
			zh = 1.333,
			ja = 1.2
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
				arg_187_0:Play411051045(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = arg_187_1.actors_["10014ui_story"]
			local var_190_1 = 0

			if var_190_1 < arg_187_1.time_ and arg_187_1.time_ <= var_190_1 + arg_190_0 and not isNil(var_190_0) and arg_187_1.var_.characterEffect10014ui_story == nil then
				arg_187_1.var_.characterEffect10014ui_story = var_190_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_2 = 0.200000002980232

			if var_190_1 <= arg_187_1.time_ and arg_187_1.time_ < var_190_1 + var_190_2 and not isNil(var_190_0) then
				local var_190_3 = (arg_187_1.time_ - var_190_1) / var_190_2

				if arg_187_1.var_.characterEffect10014ui_story and not isNil(var_190_0) then
					local var_190_4 = Mathf.Lerp(0, 0.5, var_190_3)

					arg_187_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_187_1.var_.characterEffect10014ui_story.fillRatio = var_190_4
				end
			end

			if arg_187_1.time_ >= var_190_1 + var_190_2 and arg_187_1.time_ < var_190_1 + var_190_2 + arg_190_0 and not isNil(var_190_0) and arg_187_1.var_.characterEffect10014ui_story then
				local var_190_5 = 0.5

				arg_187_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_187_1.var_.characterEffect10014ui_story.fillRatio = var_190_5
			end

			local var_190_6 = arg_187_1.actors_["10058ui_story"]
			local var_190_7 = 0

			if var_190_7 < arg_187_1.time_ and arg_187_1.time_ <= var_190_7 + arg_190_0 and not isNil(var_190_6) and arg_187_1.var_.characterEffect10058ui_story == nil then
				arg_187_1.var_.characterEffect10058ui_story = var_190_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_8 = 0.200000002980232

			if var_190_7 <= arg_187_1.time_ and arg_187_1.time_ < var_190_7 + var_190_8 and not isNil(var_190_6) then
				local var_190_9 = (arg_187_1.time_ - var_190_7) / var_190_8

				if arg_187_1.var_.characterEffect10058ui_story and not isNil(var_190_6) then
					arg_187_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_187_1.time_ >= var_190_7 + var_190_8 and arg_187_1.time_ < var_190_7 + var_190_8 + arg_190_0 and not isNil(var_190_6) and arg_187_1.var_.characterEffect10058ui_story then
				arg_187_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_190_10 = 0
			local var_190_11 = 0.125

			if var_190_10 < arg_187_1.time_ and arg_187_1.time_ <= var_190_10 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				local var_190_12 = arg_187_1:FormatText(StoryNameCfg[471].name)

				arg_187_1.leftNameTxt_.text = var_190_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_13 = arg_187_1:GetWordFromCfg(411051044)
				local var_190_14 = arg_187_1:FormatText(var_190_13.content)

				arg_187_1.text_.text = var_190_14

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_15 = 5
				local var_190_16 = utf8.len(var_190_14)
				local var_190_17 = var_190_15 <= 0 and var_190_11 or var_190_11 * (var_190_16 / var_190_15)

				if var_190_17 > 0 and var_190_11 < var_190_17 then
					arg_187_1.talkMaxDuration = var_190_17

					if var_190_17 + var_190_10 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_17 + var_190_10
					end
				end

				arg_187_1.text_.text = var_190_14
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051044", "story_v_out_411051.awb") ~= 0 then
					local var_190_18 = manager.audio:GetVoiceLength("story_v_out_411051", "411051044", "story_v_out_411051.awb") / 1000

					if var_190_18 + var_190_10 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_18 + var_190_10
					end

					if var_190_13.prefab_name ~= "" and arg_187_1.actors_[var_190_13.prefab_name] ~= nil then
						local var_190_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_187_1.actors_[var_190_13.prefab_name].transform, "story_v_out_411051", "411051044", "story_v_out_411051.awb")

						arg_187_1:RecordAudio("411051044", var_190_19)
						arg_187_1:RecordAudio("411051044", var_190_19)
					else
						arg_187_1:AudioAction("play", "voice", "story_v_out_411051", "411051044", "story_v_out_411051.awb")
					end

					arg_187_1:RecordHistoryTalkVoice("story_v_out_411051", "411051044", "story_v_out_411051.awb")
				end

				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_20 = math.max(var_190_11, arg_187_1.talkMaxDuration)

			if var_190_10 <= arg_187_1.time_ and arg_187_1.time_ < var_190_10 + var_190_20 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_10) / var_190_20

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_10 + var_190_20 and arg_187_1.time_ < var_190_10 + var_190_20 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play411051045 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 411051045
		arg_191_1.duration_ = 9.7

		local var_191_0 = {
			zh = 7,
			ja = 9.7
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
				arg_191_0:Play411051046(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = arg_191_1.actors_["10014ui_story"].transform
			local var_194_1 = 0

			if var_194_1 < arg_191_1.time_ and arg_191_1.time_ <= var_194_1 + arg_194_0 then
				arg_191_1.var_.moveOldPos10014ui_story = var_194_0.localPosition
			end

			local var_194_2 = 0.001

			if var_194_1 <= arg_191_1.time_ and arg_191_1.time_ < var_194_1 + var_194_2 then
				local var_194_3 = (arg_191_1.time_ - var_194_1) / var_194_2
				local var_194_4 = Vector3.New(0.7, -1.06, -6.2)

				var_194_0.localPosition = Vector3.Lerp(arg_191_1.var_.moveOldPos10014ui_story, var_194_4, var_194_3)

				local var_194_5 = manager.ui.mainCamera.transform.position - var_194_0.position

				var_194_0.forward = Vector3.New(var_194_5.x, var_194_5.y, var_194_5.z)

				local var_194_6 = var_194_0.localEulerAngles

				var_194_6.z = 0
				var_194_6.x = 0
				var_194_0.localEulerAngles = var_194_6
			end

			if arg_191_1.time_ >= var_194_1 + var_194_2 and arg_191_1.time_ < var_194_1 + var_194_2 + arg_194_0 then
				var_194_0.localPosition = Vector3.New(0.7, -1.06, -6.2)

				local var_194_7 = manager.ui.mainCamera.transform.position - var_194_0.position

				var_194_0.forward = Vector3.New(var_194_7.x, var_194_7.y, var_194_7.z)

				local var_194_8 = var_194_0.localEulerAngles

				var_194_8.z = 0
				var_194_8.x = 0
				var_194_0.localEulerAngles = var_194_8
			end

			local var_194_9 = arg_191_1.actors_["10014ui_story"]
			local var_194_10 = 0

			if var_194_10 < arg_191_1.time_ and arg_191_1.time_ <= var_194_10 + arg_194_0 and not isNil(var_194_9) and arg_191_1.var_.characterEffect10014ui_story == nil then
				arg_191_1.var_.characterEffect10014ui_story = var_194_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_194_11 = 0.200000002980232

			if var_194_10 <= arg_191_1.time_ and arg_191_1.time_ < var_194_10 + var_194_11 and not isNil(var_194_9) then
				local var_194_12 = (arg_191_1.time_ - var_194_10) / var_194_11

				if arg_191_1.var_.characterEffect10014ui_story and not isNil(var_194_9) then
					arg_191_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_191_1.time_ >= var_194_10 + var_194_11 and arg_191_1.time_ < var_194_10 + var_194_11 + arg_194_0 and not isNil(var_194_9) and arg_191_1.var_.characterEffect10014ui_story then
				arg_191_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			local var_194_13 = 0

			if var_194_13 < arg_191_1.time_ and arg_191_1.time_ <= var_194_13 + arg_194_0 then
				arg_191_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/story10014/story10014action/10014action3_2")
			end

			local var_194_14 = 0

			if var_194_14 < arg_191_1.time_ and arg_191_1.time_ <= var_194_14 + arg_194_0 then
				arg_191_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_194_15 = arg_191_1.actors_["10058ui_story"]
			local var_194_16 = 0

			if var_194_16 < arg_191_1.time_ and arg_191_1.time_ <= var_194_16 + arg_194_0 and not isNil(var_194_15) and arg_191_1.var_.characterEffect10058ui_story == nil then
				arg_191_1.var_.characterEffect10058ui_story = var_194_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_194_17 = 0.200000002980232

			if var_194_16 <= arg_191_1.time_ and arg_191_1.time_ < var_194_16 + var_194_17 and not isNil(var_194_15) then
				local var_194_18 = (arg_191_1.time_ - var_194_16) / var_194_17

				if arg_191_1.var_.characterEffect10058ui_story and not isNil(var_194_15) then
					local var_194_19 = Mathf.Lerp(0, 0.5, var_194_18)

					arg_191_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_191_1.var_.characterEffect10058ui_story.fillRatio = var_194_19
				end
			end

			if arg_191_1.time_ >= var_194_16 + var_194_17 and arg_191_1.time_ < var_194_16 + var_194_17 + arg_194_0 and not isNil(var_194_15) and arg_191_1.var_.characterEffect10058ui_story then
				local var_194_20 = 0.5

				arg_191_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_191_1.var_.characterEffect10058ui_story.fillRatio = var_194_20
			end

			local var_194_21 = 0
			local var_194_22 = 0.925

			if var_194_21 < arg_191_1.time_ and arg_191_1.time_ <= var_194_21 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				local var_194_23 = arg_191_1:FormatText(StoryNameCfg[264].name)

				arg_191_1.leftNameTxt_.text = var_194_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_24 = arg_191_1:GetWordFromCfg(411051045)
				local var_194_25 = arg_191_1:FormatText(var_194_24.content)

				arg_191_1.text_.text = var_194_25

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_26 = 37
				local var_194_27 = utf8.len(var_194_25)
				local var_194_28 = var_194_26 <= 0 and var_194_22 or var_194_22 * (var_194_27 / var_194_26)

				if var_194_28 > 0 and var_194_22 < var_194_28 then
					arg_191_1.talkMaxDuration = var_194_28

					if var_194_28 + var_194_21 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_28 + var_194_21
					end
				end

				arg_191_1.text_.text = var_194_25
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051045", "story_v_out_411051.awb") ~= 0 then
					local var_194_29 = manager.audio:GetVoiceLength("story_v_out_411051", "411051045", "story_v_out_411051.awb") / 1000

					if var_194_29 + var_194_21 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_29 + var_194_21
					end

					if var_194_24.prefab_name ~= "" and arg_191_1.actors_[var_194_24.prefab_name] ~= nil then
						local var_194_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_24.prefab_name].transform, "story_v_out_411051", "411051045", "story_v_out_411051.awb")

						arg_191_1:RecordAudio("411051045", var_194_30)
						arg_191_1:RecordAudio("411051045", var_194_30)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_out_411051", "411051045", "story_v_out_411051.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_out_411051", "411051045", "story_v_out_411051.awb")
				end

				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_31 = math.max(var_194_22, arg_191_1.talkMaxDuration)

			if var_194_21 <= arg_191_1.time_ and arg_191_1.time_ < var_194_21 + var_194_31 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_21) / var_194_31

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_21 + var_194_31 and arg_191_1.time_ < var_194_21 + var_194_31 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10014ui_story",
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
	Play411051046 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 411051046
		arg_195_1.duration_ = 3.5

		local var_195_0 = {
			zh = 2.5,
			ja = 3.5
		}
		local var_195_1 = manager.audio:GetLocalizationFlag()

		if var_195_0[var_195_1] ~= nil then
			arg_195_1.duration_ = var_195_0[var_195_1]
		end

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play411051047(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = arg_195_1.actors_["10058ui_story"].transform
			local var_198_1 = 0

			if var_198_1 < arg_195_1.time_ and arg_195_1.time_ <= var_198_1 + arg_198_0 then
				arg_195_1.var_.moveOldPos10058ui_story = var_198_0.localPosition
			end

			local var_198_2 = 0.001

			if var_198_1 <= arg_195_1.time_ and arg_195_1.time_ < var_198_1 + var_198_2 then
				local var_198_3 = (arg_195_1.time_ - var_198_1) / var_198_2
				local var_198_4 = Vector3.New(-0.7, -0.98, -6.1)

				var_198_0.localPosition = Vector3.Lerp(arg_195_1.var_.moveOldPos10058ui_story, var_198_4, var_198_3)

				local var_198_5 = manager.ui.mainCamera.transform.position - var_198_0.position

				var_198_0.forward = Vector3.New(var_198_5.x, var_198_5.y, var_198_5.z)

				local var_198_6 = var_198_0.localEulerAngles

				var_198_6.z = 0
				var_198_6.x = 0
				var_198_0.localEulerAngles = var_198_6
			end

			if arg_195_1.time_ >= var_198_1 + var_198_2 and arg_195_1.time_ < var_198_1 + var_198_2 + arg_198_0 then
				var_198_0.localPosition = Vector3.New(-0.7, -0.98, -6.1)

				local var_198_7 = manager.ui.mainCamera.transform.position - var_198_0.position

				var_198_0.forward = Vector3.New(var_198_7.x, var_198_7.y, var_198_7.z)

				local var_198_8 = var_198_0.localEulerAngles

				var_198_8.z = 0
				var_198_8.x = 0
				var_198_0.localEulerAngles = var_198_8
			end

			local var_198_9 = arg_195_1.actors_["10058ui_story"]
			local var_198_10 = 0

			if var_198_10 < arg_195_1.time_ and arg_195_1.time_ <= var_198_10 + arg_198_0 and not isNil(var_198_9) and arg_195_1.var_.characterEffect10058ui_story == nil then
				arg_195_1.var_.characterEffect10058ui_story = var_198_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_198_11 = 0.200000002980232

			if var_198_10 <= arg_195_1.time_ and arg_195_1.time_ < var_198_10 + var_198_11 and not isNil(var_198_9) then
				local var_198_12 = (arg_195_1.time_ - var_198_10) / var_198_11

				if arg_195_1.var_.characterEffect10058ui_story and not isNil(var_198_9) then
					arg_195_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_195_1.time_ >= var_198_10 + var_198_11 and arg_195_1.time_ < var_198_10 + var_198_11 + arg_198_0 and not isNil(var_198_9) and arg_195_1.var_.characterEffect10058ui_story then
				arg_195_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_198_13 = 0

			if var_198_13 < arg_195_1.time_ and arg_195_1.time_ <= var_198_13 + arg_198_0 then
				arg_195_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095actionlink/1095action423")
			end

			local var_198_14 = 0

			if var_198_14 < arg_195_1.time_ and arg_195_1.time_ <= var_198_14 + arg_198_0 then
				arg_195_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_198_15 = arg_195_1.actors_["10014ui_story"]
			local var_198_16 = 0

			if var_198_16 < arg_195_1.time_ and arg_195_1.time_ <= var_198_16 + arg_198_0 and not isNil(var_198_15) and arg_195_1.var_.characterEffect10014ui_story == nil then
				arg_195_1.var_.characterEffect10014ui_story = var_198_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_198_17 = 0.200000002980232

			if var_198_16 <= arg_195_1.time_ and arg_195_1.time_ < var_198_16 + var_198_17 and not isNil(var_198_15) then
				local var_198_18 = (arg_195_1.time_ - var_198_16) / var_198_17

				if arg_195_1.var_.characterEffect10014ui_story and not isNil(var_198_15) then
					local var_198_19 = Mathf.Lerp(0, 0.5, var_198_18)

					arg_195_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_195_1.var_.characterEffect10014ui_story.fillRatio = var_198_19
				end
			end

			if arg_195_1.time_ >= var_198_16 + var_198_17 and arg_195_1.time_ < var_198_16 + var_198_17 + arg_198_0 and not isNil(var_198_15) and arg_195_1.var_.characterEffect10014ui_story then
				local var_198_20 = 0.5

				arg_195_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_195_1.var_.characterEffect10014ui_story.fillRatio = var_198_20
			end

			local var_198_21 = 0
			local var_198_22 = 0.325

			if var_198_21 < arg_195_1.time_ and arg_195_1.time_ <= var_198_21 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				local var_198_23 = arg_195_1:FormatText(StoryNameCfg[471].name)

				arg_195_1.leftNameTxt_.text = var_198_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_24 = arg_195_1:GetWordFromCfg(411051046)
				local var_198_25 = arg_195_1:FormatText(var_198_24.content)

				arg_195_1.text_.text = var_198_25

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_26 = 13
				local var_198_27 = utf8.len(var_198_25)
				local var_198_28 = var_198_26 <= 0 and var_198_22 or var_198_22 * (var_198_27 / var_198_26)

				if var_198_28 > 0 and var_198_22 < var_198_28 then
					arg_195_1.talkMaxDuration = var_198_28

					if var_198_28 + var_198_21 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_28 + var_198_21
					end
				end

				arg_195_1.text_.text = var_198_25
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051046", "story_v_out_411051.awb") ~= 0 then
					local var_198_29 = manager.audio:GetVoiceLength("story_v_out_411051", "411051046", "story_v_out_411051.awb") / 1000

					if var_198_29 + var_198_21 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_29 + var_198_21
					end

					if var_198_24.prefab_name ~= "" and arg_195_1.actors_[var_198_24.prefab_name] ~= nil then
						local var_198_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_24.prefab_name].transform, "story_v_out_411051", "411051046", "story_v_out_411051.awb")

						arg_195_1:RecordAudio("411051046", var_198_30)
						arg_195_1:RecordAudio("411051046", var_198_30)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_out_411051", "411051046", "story_v_out_411051.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_out_411051", "411051046", "story_v_out_411051.awb")
				end

				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_31 = math.max(var_198_22, arg_195_1.talkMaxDuration)

			if var_198_21 <= arg_195_1.time_ and arg_195_1.time_ < var_198_21 + var_198_31 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_21) / var_198_31

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_21 + var_198_31 and arg_195_1.time_ < var_198_21 + var_198_31 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
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
	Play411051047 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 411051047
		arg_199_1.duration_ = 4

		local var_199_0 = {
			zh = 3.9,
			ja = 4
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
				arg_199_0:Play411051048(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = arg_199_1.actors_["10058ui_story"]
			local var_202_1 = 0

			if var_202_1 < arg_199_1.time_ and arg_199_1.time_ <= var_202_1 + arg_202_0 and not isNil(var_202_0) and arg_199_1.var_.characterEffect10058ui_story == nil then
				arg_199_1.var_.characterEffect10058ui_story = var_202_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_202_2 = 0.200000002980232

			if var_202_1 <= arg_199_1.time_ and arg_199_1.time_ < var_202_1 + var_202_2 and not isNil(var_202_0) then
				local var_202_3 = (arg_199_1.time_ - var_202_1) / var_202_2

				if arg_199_1.var_.characterEffect10058ui_story and not isNil(var_202_0) then
					local var_202_4 = Mathf.Lerp(0, 0.5, var_202_3)

					arg_199_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_199_1.var_.characterEffect10058ui_story.fillRatio = var_202_4
				end
			end

			if arg_199_1.time_ >= var_202_1 + var_202_2 and arg_199_1.time_ < var_202_1 + var_202_2 + arg_202_0 and not isNil(var_202_0) and arg_199_1.var_.characterEffect10058ui_story then
				local var_202_5 = 0.5

				arg_199_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_199_1.var_.characterEffect10058ui_story.fillRatio = var_202_5
			end

			local var_202_6 = arg_199_1.actors_["10014ui_story"]
			local var_202_7 = 0

			if var_202_7 < arg_199_1.time_ and arg_199_1.time_ <= var_202_7 + arg_202_0 and not isNil(var_202_6) and arg_199_1.var_.characterEffect10014ui_story == nil then
				arg_199_1.var_.characterEffect10014ui_story = var_202_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_202_8 = 0.200000002980232

			if var_202_7 <= arg_199_1.time_ and arg_199_1.time_ < var_202_7 + var_202_8 and not isNil(var_202_6) then
				local var_202_9 = (arg_199_1.time_ - var_202_7) / var_202_8

				if arg_199_1.var_.characterEffect10014ui_story and not isNil(var_202_6) then
					arg_199_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_199_1.time_ >= var_202_7 + var_202_8 and arg_199_1.time_ < var_202_7 + var_202_8 + arg_202_0 and not isNil(var_202_6) and arg_199_1.var_.characterEffect10014ui_story then
				arg_199_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			local var_202_10 = 0
			local var_202_11 = 0.35

			if var_202_10 < arg_199_1.time_ and arg_199_1.time_ <= var_202_10 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				local var_202_12 = arg_199_1:FormatText(StoryNameCfg[264].name)

				arg_199_1.leftNameTxt_.text = var_202_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_13 = arg_199_1:GetWordFromCfg(411051047)
				local var_202_14 = arg_199_1:FormatText(var_202_13.content)

				arg_199_1.text_.text = var_202_14

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_15 = 14
				local var_202_16 = utf8.len(var_202_14)
				local var_202_17 = var_202_15 <= 0 and var_202_11 or var_202_11 * (var_202_16 / var_202_15)

				if var_202_17 > 0 and var_202_11 < var_202_17 then
					arg_199_1.talkMaxDuration = var_202_17

					if var_202_17 + var_202_10 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_17 + var_202_10
					end
				end

				arg_199_1.text_.text = var_202_14
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051047", "story_v_out_411051.awb") ~= 0 then
					local var_202_18 = manager.audio:GetVoiceLength("story_v_out_411051", "411051047", "story_v_out_411051.awb") / 1000

					if var_202_18 + var_202_10 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_18 + var_202_10
					end

					if var_202_13.prefab_name ~= "" and arg_199_1.actors_[var_202_13.prefab_name] ~= nil then
						local var_202_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_199_1.actors_[var_202_13.prefab_name].transform, "story_v_out_411051", "411051047", "story_v_out_411051.awb")

						arg_199_1:RecordAudio("411051047", var_202_19)
						arg_199_1:RecordAudio("411051047", var_202_19)
					else
						arg_199_1:AudioAction("play", "voice", "story_v_out_411051", "411051047", "story_v_out_411051.awb")
					end

					arg_199_1:RecordHistoryTalkVoice("story_v_out_411051", "411051047", "story_v_out_411051.awb")
				end

				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_20 = math.max(var_202_11, arg_199_1.talkMaxDuration)

			if var_202_10 <= arg_199_1.time_ and arg_199_1.time_ < var_202_10 + var_202_20 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_10) / var_202_20

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_10 + var_202_20 and arg_199_1.time_ < var_202_10 + var_202_20 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {}

		arg_199_1:InitPlayNodeList()
	end,
	Play411051048 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 411051048
		arg_203_1.duration_ = 8.8

		local var_203_0 = {
			zh = 6.9,
			ja = 8.8
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
				arg_203_0:Play411051049(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			local var_206_0 = arg_203_1.actors_["10058ui_story"]
			local var_206_1 = 0

			if var_206_1 < arg_203_1.time_ and arg_203_1.time_ <= var_206_1 + arg_206_0 and not isNil(var_206_0) and arg_203_1.var_.characterEffect10058ui_story == nil then
				arg_203_1.var_.characterEffect10058ui_story = var_206_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_206_2 = 0.200000002980232

			if var_206_1 <= arg_203_1.time_ and arg_203_1.time_ < var_206_1 + var_206_2 and not isNil(var_206_0) then
				local var_206_3 = (arg_203_1.time_ - var_206_1) / var_206_2

				if arg_203_1.var_.characterEffect10058ui_story and not isNil(var_206_0) then
					arg_203_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_203_1.time_ >= var_206_1 + var_206_2 and arg_203_1.time_ < var_206_1 + var_206_2 + arg_206_0 and not isNil(var_206_0) and arg_203_1.var_.characterEffect10058ui_story then
				arg_203_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_206_4 = arg_203_1.actors_["10014ui_story"]
			local var_206_5 = 0

			if var_206_5 < arg_203_1.time_ and arg_203_1.time_ <= var_206_5 + arg_206_0 and not isNil(var_206_4) and arg_203_1.var_.characterEffect10014ui_story == nil then
				arg_203_1.var_.characterEffect10014ui_story = var_206_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_206_6 = 0.200000002980232

			if var_206_5 <= arg_203_1.time_ and arg_203_1.time_ < var_206_5 + var_206_6 and not isNil(var_206_4) then
				local var_206_7 = (arg_203_1.time_ - var_206_5) / var_206_6

				if arg_203_1.var_.characterEffect10014ui_story and not isNil(var_206_4) then
					local var_206_8 = Mathf.Lerp(0, 0.5, var_206_7)

					arg_203_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_203_1.var_.characterEffect10014ui_story.fillRatio = var_206_8
				end
			end

			if arg_203_1.time_ >= var_206_5 + var_206_6 and arg_203_1.time_ < var_206_5 + var_206_6 + arg_206_0 and not isNil(var_206_4) and arg_203_1.var_.characterEffect10014ui_story then
				local var_206_9 = 0.5

				arg_203_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_203_1.var_.characterEffect10014ui_story.fillRatio = var_206_9
			end

			local var_206_10 = 0
			local var_206_11 = 0.8

			if var_206_10 < arg_203_1.time_ and arg_203_1.time_ <= var_206_10 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				local var_206_12 = arg_203_1:FormatText(StoryNameCfg[471].name)

				arg_203_1.leftNameTxt_.text = var_206_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_13 = arg_203_1:GetWordFromCfg(411051048)
				local var_206_14 = arg_203_1:FormatText(var_206_13.content)

				arg_203_1.text_.text = var_206_14

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_15 = 32
				local var_206_16 = utf8.len(var_206_14)
				local var_206_17 = var_206_15 <= 0 and var_206_11 or var_206_11 * (var_206_16 / var_206_15)

				if var_206_17 > 0 and var_206_11 < var_206_17 then
					arg_203_1.talkMaxDuration = var_206_17

					if var_206_17 + var_206_10 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_17 + var_206_10
					end
				end

				arg_203_1.text_.text = var_206_14
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051048", "story_v_out_411051.awb") ~= 0 then
					local var_206_18 = manager.audio:GetVoiceLength("story_v_out_411051", "411051048", "story_v_out_411051.awb") / 1000

					if var_206_18 + var_206_10 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_18 + var_206_10
					end

					if var_206_13.prefab_name ~= "" and arg_203_1.actors_[var_206_13.prefab_name] ~= nil then
						local var_206_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_13.prefab_name].transform, "story_v_out_411051", "411051048", "story_v_out_411051.awb")

						arg_203_1:RecordAudio("411051048", var_206_19)
						arg_203_1:RecordAudio("411051048", var_206_19)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_out_411051", "411051048", "story_v_out_411051.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_out_411051", "411051048", "story_v_out_411051.awb")
				end

				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_20 = math.max(var_206_11, arg_203_1.talkMaxDuration)

			if var_206_10 <= arg_203_1.time_ and arg_203_1.time_ < var_206_10 + var_206_20 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_10) / var_206_20

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_10 + var_206_20 and arg_203_1.time_ < var_206_10 + var_206_20 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {}

		arg_203_1:InitPlayNodeList()
	end,
	Play411051049 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 411051049
		arg_207_1.duration_ = 14.57

		local var_207_0 = {
			zh = 8.2,
			ja = 14.566
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
				arg_207_0:Play411051050(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			local var_210_0 = arg_207_1.actors_["10058ui_story"]
			local var_210_1 = 0

			if var_210_1 < arg_207_1.time_ and arg_207_1.time_ <= var_210_1 + arg_210_0 and not isNil(var_210_0) and arg_207_1.var_.characterEffect10058ui_story == nil then
				arg_207_1.var_.characterEffect10058ui_story = var_210_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_2 = 0.200000002980232

			if var_210_1 <= arg_207_1.time_ and arg_207_1.time_ < var_210_1 + var_210_2 and not isNil(var_210_0) then
				local var_210_3 = (arg_207_1.time_ - var_210_1) / var_210_2

				if arg_207_1.var_.characterEffect10058ui_story and not isNil(var_210_0) then
					local var_210_4 = Mathf.Lerp(0, 0.5, var_210_3)

					arg_207_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_207_1.var_.characterEffect10058ui_story.fillRatio = var_210_4
				end
			end

			if arg_207_1.time_ >= var_210_1 + var_210_2 and arg_207_1.time_ < var_210_1 + var_210_2 + arg_210_0 and not isNil(var_210_0) and arg_207_1.var_.characterEffect10058ui_story then
				local var_210_5 = 0.5

				arg_207_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_207_1.var_.characterEffect10058ui_story.fillRatio = var_210_5
			end

			local var_210_6 = arg_207_1.actors_["10014ui_story"]
			local var_210_7 = 0

			if var_210_7 < arg_207_1.time_ and arg_207_1.time_ <= var_210_7 + arg_210_0 and not isNil(var_210_6) and arg_207_1.var_.characterEffect10014ui_story == nil then
				arg_207_1.var_.characterEffect10014ui_story = var_210_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_8 = 0.200000002980232

			if var_210_7 <= arg_207_1.time_ and arg_207_1.time_ < var_210_7 + var_210_8 and not isNil(var_210_6) then
				local var_210_9 = (arg_207_1.time_ - var_210_7) / var_210_8

				if arg_207_1.var_.characterEffect10014ui_story and not isNil(var_210_6) then
					arg_207_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_207_1.time_ >= var_210_7 + var_210_8 and arg_207_1.time_ < var_210_7 + var_210_8 + arg_210_0 and not isNil(var_210_6) and arg_207_1.var_.characterEffect10014ui_story then
				arg_207_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			local var_210_10 = 0
			local var_210_11 = 1.05

			if var_210_10 < arg_207_1.time_ and arg_207_1.time_ <= var_210_10 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				local var_210_12 = arg_207_1:FormatText(StoryNameCfg[264].name)

				arg_207_1.leftNameTxt_.text = var_210_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_13 = arg_207_1:GetWordFromCfg(411051049)
				local var_210_14 = arg_207_1:FormatText(var_210_13.content)

				arg_207_1.text_.text = var_210_14

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_15 = 42
				local var_210_16 = utf8.len(var_210_14)
				local var_210_17 = var_210_15 <= 0 and var_210_11 or var_210_11 * (var_210_16 / var_210_15)

				if var_210_17 > 0 and var_210_11 < var_210_17 then
					arg_207_1.talkMaxDuration = var_210_17

					if var_210_17 + var_210_10 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_17 + var_210_10
					end
				end

				arg_207_1.text_.text = var_210_14
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051049", "story_v_out_411051.awb") ~= 0 then
					local var_210_18 = manager.audio:GetVoiceLength("story_v_out_411051", "411051049", "story_v_out_411051.awb") / 1000

					if var_210_18 + var_210_10 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_18 + var_210_10
					end

					if var_210_13.prefab_name ~= "" and arg_207_1.actors_[var_210_13.prefab_name] ~= nil then
						local var_210_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_207_1.actors_[var_210_13.prefab_name].transform, "story_v_out_411051", "411051049", "story_v_out_411051.awb")

						arg_207_1:RecordAudio("411051049", var_210_19)
						arg_207_1:RecordAudio("411051049", var_210_19)
					else
						arg_207_1:AudioAction("play", "voice", "story_v_out_411051", "411051049", "story_v_out_411051.awb")
					end

					arg_207_1:RecordHistoryTalkVoice("story_v_out_411051", "411051049", "story_v_out_411051.awb")
				end

				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_20 = math.max(var_210_11, arg_207_1.talkMaxDuration)

			if var_210_10 <= arg_207_1.time_ and arg_207_1.time_ < var_210_10 + var_210_20 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_10) / var_210_20

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_10 + var_210_20 and arg_207_1.time_ < var_210_10 + var_210_20 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {}

		arg_207_1:InitPlayNodeList()
	end,
	Play411051050 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 411051050
		arg_211_1.duration_ = 11.13

		local var_211_0 = {
			zh = 9.933,
			ja = 11.133
		}
		local var_211_1 = manager.audio:GetLocalizationFlag()

		if var_211_0[var_211_1] ~= nil then
			arg_211_1.duration_ = var_211_0[var_211_1]
		end

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play411051051(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			local var_214_0 = 0
			local var_214_1 = 1.175

			if var_214_0 < arg_211_1.time_ and arg_211_1.time_ <= var_214_0 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, true)

				local var_214_2 = arg_211_1:FormatText(StoryNameCfg[264].name)

				arg_211_1.leftNameTxt_.text = var_214_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_211_1.leftNameTxt_.transform)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1.leftNameTxt_.text)
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_3 = arg_211_1:GetWordFromCfg(411051050)
				local var_214_4 = arg_211_1:FormatText(var_214_3.content)

				arg_211_1.text_.text = var_214_4

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_5 = 47
				local var_214_6 = utf8.len(var_214_4)
				local var_214_7 = var_214_5 <= 0 and var_214_1 or var_214_1 * (var_214_6 / var_214_5)

				if var_214_7 > 0 and var_214_1 < var_214_7 then
					arg_211_1.talkMaxDuration = var_214_7

					if var_214_7 + var_214_0 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_7 + var_214_0
					end
				end

				arg_211_1.text_.text = var_214_4
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051050", "story_v_out_411051.awb") ~= 0 then
					local var_214_8 = manager.audio:GetVoiceLength("story_v_out_411051", "411051050", "story_v_out_411051.awb") / 1000

					if var_214_8 + var_214_0 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_8 + var_214_0
					end

					if var_214_3.prefab_name ~= "" and arg_211_1.actors_[var_214_3.prefab_name] ~= nil then
						local var_214_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_211_1.actors_[var_214_3.prefab_name].transform, "story_v_out_411051", "411051050", "story_v_out_411051.awb")

						arg_211_1:RecordAudio("411051050", var_214_9)
						arg_211_1:RecordAudio("411051050", var_214_9)
					else
						arg_211_1:AudioAction("play", "voice", "story_v_out_411051", "411051050", "story_v_out_411051.awb")
					end

					arg_211_1:RecordHistoryTalkVoice("story_v_out_411051", "411051050", "story_v_out_411051.awb")
				end

				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_10 = math.max(var_214_1, arg_211_1.talkMaxDuration)

			if var_214_0 <= arg_211_1.time_ and arg_211_1.time_ < var_214_0 + var_214_10 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_0) / var_214_10

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_0 + var_214_10 and arg_211_1.time_ < var_214_0 + var_214_10 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {}

		arg_211_1:InitPlayNodeList()
	end,
	Play411051051 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 411051051
		arg_215_1.duration_ = 1.53

		local var_215_0 = {
			zh = 0.999999999999,
			ja = 1.533
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
				arg_215_0:Play411051052(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			local var_218_0 = arg_215_1.actors_["10058ui_story"].transform
			local var_218_1 = 0

			if var_218_1 < arg_215_1.time_ and arg_215_1.time_ <= var_218_1 + arg_218_0 then
				arg_215_1.var_.moveOldPos10058ui_story = var_218_0.localPosition
			end

			local var_218_2 = 0.001

			if var_218_1 <= arg_215_1.time_ and arg_215_1.time_ < var_218_1 + var_218_2 then
				local var_218_3 = (arg_215_1.time_ - var_218_1) / var_218_2
				local var_218_4 = Vector3.New(-0.7, -0.98, -6.1)

				var_218_0.localPosition = Vector3.Lerp(arg_215_1.var_.moveOldPos10058ui_story, var_218_4, var_218_3)

				local var_218_5 = manager.ui.mainCamera.transform.position - var_218_0.position

				var_218_0.forward = Vector3.New(var_218_5.x, var_218_5.y, var_218_5.z)

				local var_218_6 = var_218_0.localEulerAngles

				var_218_6.z = 0
				var_218_6.x = 0
				var_218_0.localEulerAngles = var_218_6
			end

			if arg_215_1.time_ >= var_218_1 + var_218_2 and arg_215_1.time_ < var_218_1 + var_218_2 + arg_218_0 then
				var_218_0.localPosition = Vector3.New(-0.7, -0.98, -6.1)

				local var_218_7 = manager.ui.mainCamera.transform.position - var_218_0.position

				var_218_0.forward = Vector3.New(var_218_7.x, var_218_7.y, var_218_7.z)

				local var_218_8 = var_218_0.localEulerAngles

				var_218_8.z = 0
				var_218_8.x = 0
				var_218_0.localEulerAngles = var_218_8
			end

			local var_218_9 = arg_215_1.actors_["10058ui_story"]
			local var_218_10 = 0

			if var_218_10 < arg_215_1.time_ and arg_215_1.time_ <= var_218_10 + arg_218_0 and not isNil(var_218_9) and arg_215_1.var_.characterEffect10058ui_story == nil then
				arg_215_1.var_.characterEffect10058ui_story = var_218_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_218_11 = 0.200000002980232

			if var_218_10 <= arg_215_1.time_ and arg_215_1.time_ < var_218_10 + var_218_11 and not isNil(var_218_9) then
				local var_218_12 = (arg_215_1.time_ - var_218_10) / var_218_11

				if arg_215_1.var_.characterEffect10058ui_story and not isNil(var_218_9) then
					arg_215_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_215_1.time_ >= var_218_10 + var_218_11 and arg_215_1.time_ < var_218_10 + var_218_11 + arg_218_0 and not isNil(var_218_9) and arg_215_1.var_.characterEffect10058ui_story then
				arg_215_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_218_13 = arg_215_1.actors_["10014ui_story"]
			local var_218_14 = 0

			if var_218_14 < arg_215_1.time_ and arg_215_1.time_ <= var_218_14 + arg_218_0 and not isNil(var_218_13) and arg_215_1.var_.characterEffect10014ui_story == nil then
				arg_215_1.var_.characterEffect10014ui_story = var_218_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_218_15 = 0.200000002980232

			if var_218_14 <= arg_215_1.time_ and arg_215_1.time_ < var_218_14 + var_218_15 and not isNil(var_218_13) then
				local var_218_16 = (arg_215_1.time_ - var_218_14) / var_218_15

				if arg_215_1.var_.characterEffect10014ui_story and not isNil(var_218_13) then
					local var_218_17 = Mathf.Lerp(0, 0.5, var_218_16)

					arg_215_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_215_1.var_.characterEffect10014ui_story.fillRatio = var_218_17
				end
			end

			if arg_215_1.time_ >= var_218_14 + var_218_15 and arg_215_1.time_ < var_218_14 + var_218_15 + arg_218_0 and not isNil(var_218_13) and arg_215_1.var_.characterEffect10014ui_story then
				local var_218_18 = 0.5

				arg_215_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_215_1.var_.characterEffect10014ui_story.fillRatio = var_218_18
			end

			local var_218_19 = 0
			local var_218_20 = 0.1

			if var_218_19 < arg_215_1.time_ and arg_215_1.time_ <= var_218_19 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				local var_218_21 = arg_215_1:FormatText(StoryNameCfg[471].name)

				arg_215_1.leftNameTxt_.text = var_218_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_22 = arg_215_1:GetWordFromCfg(411051051)
				local var_218_23 = arg_215_1:FormatText(var_218_22.content)

				arg_215_1.text_.text = var_218_23

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_24 = 4
				local var_218_25 = utf8.len(var_218_23)
				local var_218_26 = var_218_24 <= 0 and var_218_20 or var_218_20 * (var_218_25 / var_218_24)

				if var_218_26 > 0 and var_218_20 < var_218_26 then
					arg_215_1.talkMaxDuration = var_218_26

					if var_218_26 + var_218_19 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_26 + var_218_19
					end
				end

				arg_215_1.text_.text = var_218_23
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051051", "story_v_out_411051.awb") ~= 0 then
					local var_218_27 = manager.audio:GetVoiceLength("story_v_out_411051", "411051051", "story_v_out_411051.awb") / 1000

					if var_218_27 + var_218_19 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_27 + var_218_19
					end

					if var_218_22.prefab_name ~= "" and arg_215_1.actors_[var_218_22.prefab_name] ~= nil then
						local var_218_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_215_1.actors_[var_218_22.prefab_name].transform, "story_v_out_411051", "411051051", "story_v_out_411051.awb")

						arg_215_1:RecordAudio("411051051", var_218_28)
						arg_215_1:RecordAudio("411051051", var_218_28)
					else
						arg_215_1:AudioAction("play", "voice", "story_v_out_411051", "411051051", "story_v_out_411051.awb")
					end

					arg_215_1:RecordHistoryTalkVoice("story_v_out_411051", "411051051", "story_v_out_411051.awb")
				end

				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_29 = math.max(var_218_20, arg_215_1.talkMaxDuration)

			if var_218_19 <= arg_215_1.time_ and arg_215_1.time_ < var_218_19 + var_218_29 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_19) / var_218_29

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_19 + var_218_29 and arg_215_1.time_ < var_218_19 + var_218_29 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
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
	Play411051052 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 411051052
		arg_219_1.duration_ = 12.13

		local var_219_0 = {
			zh = 9.9,
			ja = 12.133
		}
		local var_219_1 = manager.audio:GetLocalizationFlag()

		if var_219_0[var_219_1] ~= nil then
			arg_219_1.duration_ = var_219_0[var_219_1]
		end

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play411051053(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			local var_222_0 = arg_219_1.actors_["10014ui_story"].transform
			local var_222_1 = 0

			if var_222_1 < arg_219_1.time_ and arg_219_1.time_ <= var_222_1 + arg_222_0 then
				arg_219_1.var_.moveOldPos10014ui_story = var_222_0.localPosition
			end

			local var_222_2 = 0.001

			if var_222_1 <= arg_219_1.time_ and arg_219_1.time_ < var_222_1 + var_222_2 then
				local var_222_3 = (arg_219_1.time_ - var_222_1) / var_222_2
				local var_222_4 = Vector3.New(0.7, -1.06, -6.2)

				var_222_0.localPosition = Vector3.Lerp(arg_219_1.var_.moveOldPos10014ui_story, var_222_4, var_222_3)

				local var_222_5 = manager.ui.mainCamera.transform.position - var_222_0.position

				var_222_0.forward = Vector3.New(var_222_5.x, var_222_5.y, var_222_5.z)

				local var_222_6 = var_222_0.localEulerAngles

				var_222_6.z = 0
				var_222_6.x = 0
				var_222_0.localEulerAngles = var_222_6
			end

			if arg_219_1.time_ >= var_222_1 + var_222_2 and arg_219_1.time_ < var_222_1 + var_222_2 + arg_222_0 then
				var_222_0.localPosition = Vector3.New(0.7, -1.06, -6.2)

				local var_222_7 = manager.ui.mainCamera.transform.position - var_222_0.position

				var_222_0.forward = Vector3.New(var_222_7.x, var_222_7.y, var_222_7.z)

				local var_222_8 = var_222_0.localEulerAngles

				var_222_8.z = 0
				var_222_8.x = 0
				var_222_0.localEulerAngles = var_222_8
			end

			local var_222_9 = arg_219_1.actors_["10014ui_story"]
			local var_222_10 = 0

			if var_222_10 < arg_219_1.time_ and arg_219_1.time_ <= var_222_10 + arg_222_0 and not isNil(var_222_9) and arg_219_1.var_.characterEffect10014ui_story == nil then
				arg_219_1.var_.characterEffect10014ui_story = var_222_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_222_11 = 0.200000002980232

			if var_222_10 <= arg_219_1.time_ and arg_219_1.time_ < var_222_10 + var_222_11 and not isNil(var_222_9) then
				local var_222_12 = (arg_219_1.time_ - var_222_10) / var_222_11

				if arg_219_1.var_.characterEffect10014ui_story and not isNil(var_222_9) then
					arg_219_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_219_1.time_ >= var_222_10 + var_222_11 and arg_219_1.time_ < var_222_10 + var_222_11 + arg_222_0 and not isNil(var_222_9) and arg_219_1.var_.characterEffect10014ui_story then
				arg_219_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			local var_222_13 = 0

			if var_222_13 < arg_219_1.time_ and arg_219_1.time_ <= var_222_13 + arg_222_0 then
				arg_219_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/story10014/story10014action/10014action1_1")
			end

			local var_222_14 = 0

			if var_222_14 < arg_219_1.time_ and arg_219_1.time_ <= var_222_14 + arg_222_0 then
				arg_219_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_222_15 = arg_219_1.actors_["10058ui_story"]
			local var_222_16 = 0

			if var_222_16 < arg_219_1.time_ and arg_219_1.time_ <= var_222_16 + arg_222_0 and not isNil(var_222_15) and arg_219_1.var_.characterEffect10058ui_story == nil then
				arg_219_1.var_.characterEffect10058ui_story = var_222_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_222_17 = 0.200000002980232

			if var_222_16 <= arg_219_1.time_ and arg_219_1.time_ < var_222_16 + var_222_17 and not isNil(var_222_15) then
				local var_222_18 = (arg_219_1.time_ - var_222_16) / var_222_17

				if arg_219_1.var_.characterEffect10058ui_story and not isNil(var_222_15) then
					local var_222_19 = Mathf.Lerp(0, 0.5, var_222_18)

					arg_219_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_219_1.var_.characterEffect10058ui_story.fillRatio = var_222_19
				end
			end

			if arg_219_1.time_ >= var_222_16 + var_222_17 and arg_219_1.time_ < var_222_16 + var_222_17 + arg_222_0 and not isNil(var_222_15) and arg_219_1.var_.characterEffect10058ui_story then
				local var_222_20 = 0.5

				arg_219_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_219_1.var_.characterEffect10058ui_story.fillRatio = var_222_20
			end

			local var_222_21 = 0
			local var_222_22 = 1.075

			if var_222_21 < arg_219_1.time_ and arg_219_1.time_ <= var_222_21 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				local var_222_23 = arg_219_1:FormatText(StoryNameCfg[264].name)

				arg_219_1.leftNameTxt_.text = var_222_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_24 = arg_219_1:GetWordFromCfg(411051052)
				local var_222_25 = arg_219_1:FormatText(var_222_24.content)

				arg_219_1.text_.text = var_222_25

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_26 = 43
				local var_222_27 = utf8.len(var_222_25)
				local var_222_28 = var_222_26 <= 0 and var_222_22 or var_222_22 * (var_222_27 / var_222_26)

				if var_222_28 > 0 and var_222_22 < var_222_28 then
					arg_219_1.talkMaxDuration = var_222_28

					if var_222_28 + var_222_21 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_28 + var_222_21
					end
				end

				arg_219_1.text_.text = var_222_25
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051052", "story_v_out_411051.awb") ~= 0 then
					local var_222_29 = manager.audio:GetVoiceLength("story_v_out_411051", "411051052", "story_v_out_411051.awb") / 1000

					if var_222_29 + var_222_21 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_29 + var_222_21
					end

					if var_222_24.prefab_name ~= "" and arg_219_1.actors_[var_222_24.prefab_name] ~= nil then
						local var_222_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_219_1.actors_[var_222_24.prefab_name].transform, "story_v_out_411051", "411051052", "story_v_out_411051.awb")

						arg_219_1:RecordAudio("411051052", var_222_30)
						arg_219_1:RecordAudio("411051052", var_222_30)
					else
						arg_219_1:AudioAction("play", "voice", "story_v_out_411051", "411051052", "story_v_out_411051.awb")
					end

					arg_219_1:RecordHistoryTalkVoice("story_v_out_411051", "411051052", "story_v_out_411051.awb")
				end

				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_31 = math.max(var_222_22, arg_219_1.talkMaxDuration)

			if var_222_21 <= arg_219_1.time_ and arg_219_1.time_ < var_222_21 + var_222_31 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_21) / var_222_31

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_21 + var_222_31 and arg_219_1.time_ < var_222_21 + var_222_31 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10014ui_story",
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
	Play411051053 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 411051053
		arg_223_1.duration_ = 5

		SetActive(arg_223_1.tipsGo_, false)

		function arg_223_1.onSingleLineFinish_()
			arg_223_1.onSingleLineUpdate_ = nil
			arg_223_1.onSingleLineFinish_ = nil
			arg_223_1.state_ = "waiting"
		end

		function arg_223_1.playNext_(arg_225_0)
			if arg_225_0 == 1 then
				arg_223_0:Play411051054(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			local var_226_0 = arg_223_1.actors_["10014ui_story"]
			local var_226_1 = 0

			if var_226_1 < arg_223_1.time_ and arg_223_1.time_ <= var_226_1 + arg_226_0 and not isNil(var_226_0) and arg_223_1.var_.characterEffect10014ui_story == nil then
				arg_223_1.var_.characterEffect10014ui_story = var_226_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_226_2 = 0.200000002980232

			if var_226_1 <= arg_223_1.time_ and arg_223_1.time_ < var_226_1 + var_226_2 and not isNil(var_226_0) then
				local var_226_3 = (arg_223_1.time_ - var_226_1) / var_226_2

				if arg_223_1.var_.characterEffect10014ui_story and not isNil(var_226_0) then
					local var_226_4 = Mathf.Lerp(0, 0.5, var_226_3)

					arg_223_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_223_1.var_.characterEffect10014ui_story.fillRatio = var_226_4
				end
			end

			if arg_223_1.time_ >= var_226_1 + var_226_2 and arg_223_1.time_ < var_226_1 + var_226_2 + arg_226_0 and not isNil(var_226_0) and arg_223_1.var_.characterEffect10014ui_story then
				local var_226_5 = 0.5

				arg_223_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_223_1.var_.characterEffect10014ui_story.fillRatio = var_226_5
			end

			local var_226_6 = 0
			local var_226_7 = 0.9

			if var_226_6 < arg_223_1.time_ and arg_223_1.time_ <= var_226_6 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, false)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_8 = arg_223_1:GetWordFromCfg(411051053)
				local var_226_9 = arg_223_1:FormatText(var_226_8.content)

				arg_223_1.text_.text = var_226_9

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_10 = 36
				local var_226_11 = utf8.len(var_226_9)
				local var_226_12 = var_226_10 <= 0 and var_226_7 or var_226_7 * (var_226_11 / var_226_10)

				if var_226_12 > 0 and var_226_7 < var_226_12 then
					arg_223_1.talkMaxDuration = var_226_12

					if var_226_12 + var_226_6 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_12 + var_226_6
					end
				end

				arg_223_1.text_.text = var_226_9
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)
				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_13 = math.max(var_226_7, arg_223_1.talkMaxDuration)

			if var_226_6 <= arg_223_1.time_ and arg_223_1.time_ < var_226_6 + var_226_13 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_6) / var_226_13

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_6 + var_226_13 and arg_223_1.time_ < var_226_6 + var_226_13 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {}

		arg_223_1:InitPlayNodeList()
	end,
	Play411051054 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 411051054
		arg_227_1.duration_ = 2

		SetActive(arg_227_1.tipsGo_, false)

		function arg_227_1.onSingleLineFinish_()
			arg_227_1.onSingleLineUpdate_ = nil
			arg_227_1.onSingleLineFinish_ = nil
			arg_227_1.state_ = "waiting"
		end

		function arg_227_1.playNext_(arg_229_0)
			if arg_229_0 == 1 then
				arg_227_0:Play411051055(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			local var_230_0 = arg_227_1.actors_["10058ui_story"].transform
			local var_230_1 = 0

			if var_230_1 < arg_227_1.time_ and arg_227_1.time_ <= var_230_1 + arg_230_0 then
				arg_227_1.var_.moveOldPos10058ui_story = var_230_0.localPosition
			end

			local var_230_2 = 0.001

			if var_230_1 <= arg_227_1.time_ and arg_227_1.time_ < var_230_1 + var_230_2 then
				local var_230_3 = (arg_227_1.time_ - var_230_1) / var_230_2
				local var_230_4 = Vector3.New(-0.7, -0.98, -6.1)

				var_230_0.localPosition = Vector3.Lerp(arg_227_1.var_.moveOldPos10058ui_story, var_230_4, var_230_3)

				local var_230_5 = manager.ui.mainCamera.transform.position - var_230_0.position

				var_230_0.forward = Vector3.New(var_230_5.x, var_230_5.y, var_230_5.z)

				local var_230_6 = var_230_0.localEulerAngles

				var_230_6.z = 0
				var_230_6.x = 0
				var_230_0.localEulerAngles = var_230_6
			end

			if arg_227_1.time_ >= var_230_1 + var_230_2 and arg_227_1.time_ < var_230_1 + var_230_2 + arg_230_0 then
				var_230_0.localPosition = Vector3.New(-0.7, -0.98, -6.1)

				local var_230_7 = manager.ui.mainCamera.transform.position - var_230_0.position

				var_230_0.forward = Vector3.New(var_230_7.x, var_230_7.y, var_230_7.z)

				local var_230_8 = var_230_0.localEulerAngles

				var_230_8.z = 0
				var_230_8.x = 0
				var_230_0.localEulerAngles = var_230_8
			end

			local var_230_9 = arg_227_1.actors_["10058ui_story"]
			local var_230_10 = 0

			if var_230_10 < arg_227_1.time_ and arg_227_1.time_ <= var_230_10 + arg_230_0 and not isNil(var_230_9) and arg_227_1.var_.characterEffect10058ui_story == nil then
				arg_227_1.var_.characterEffect10058ui_story = var_230_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_230_11 = 0.200000002980232

			if var_230_10 <= arg_227_1.time_ and arg_227_1.time_ < var_230_10 + var_230_11 and not isNil(var_230_9) then
				local var_230_12 = (arg_227_1.time_ - var_230_10) / var_230_11

				if arg_227_1.var_.characterEffect10058ui_story and not isNil(var_230_9) then
					arg_227_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_227_1.time_ >= var_230_10 + var_230_11 and arg_227_1.time_ < var_230_10 + var_230_11 + arg_230_0 and not isNil(var_230_9) and arg_227_1.var_.characterEffect10058ui_story then
				arg_227_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_230_13 = 0

			if var_230_13 < arg_227_1.time_ and arg_227_1.time_ <= var_230_13 + arg_230_0 then
				arg_227_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action3_2")
			end

			local var_230_14 = 0

			if var_230_14 < arg_227_1.time_ and arg_227_1.time_ <= var_230_14 + arg_230_0 then
				arg_227_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_230_15 = 0
			local var_230_16 = 0.2

			if var_230_15 < arg_227_1.time_ and arg_227_1.time_ <= var_230_15 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				local var_230_17 = arg_227_1:FormatText(StoryNameCfg[471].name)

				arg_227_1.leftNameTxt_.text = var_230_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_18 = arg_227_1:GetWordFromCfg(411051054)
				local var_230_19 = arg_227_1:FormatText(var_230_18.content)

				arg_227_1.text_.text = var_230_19

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_20 = 8
				local var_230_21 = utf8.len(var_230_19)
				local var_230_22 = var_230_20 <= 0 and var_230_16 or var_230_16 * (var_230_21 / var_230_20)

				if var_230_22 > 0 and var_230_16 < var_230_22 then
					arg_227_1.talkMaxDuration = var_230_22

					if var_230_22 + var_230_15 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_22 + var_230_15
					end
				end

				arg_227_1.text_.text = var_230_19
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051054", "story_v_out_411051.awb") ~= 0 then
					local var_230_23 = manager.audio:GetVoiceLength("story_v_out_411051", "411051054", "story_v_out_411051.awb") / 1000

					if var_230_23 + var_230_15 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_23 + var_230_15
					end

					if var_230_18.prefab_name ~= "" and arg_227_1.actors_[var_230_18.prefab_name] ~= nil then
						local var_230_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_227_1.actors_[var_230_18.prefab_name].transform, "story_v_out_411051", "411051054", "story_v_out_411051.awb")

						arg_227_1:RecordAudio("411051054", var_230_24)
						arg_227_1:RecordAudio("411051054", var_230_24)
					else
						arg_227_1:AudioAction("play", "voice", "story_v_out_411051", "411051054", "story_v_out_411051.awb")
					end

					arg_227_1:RecordHistoryTalkVoice("story_v_out_411051", "411051054", "story_v_out_411051.awb")
				end

				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_25 = math.max(var_230_16, arg_227_1.talkMaxDuration)

			if var_230_15 <= arg_227_1.time_ and arg_227_1.time_ < var_230_15 + var_230_25 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_15) / var_230_25

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_15 + var_230_25 and arg_227_1.time_ < var_230_15 + var_230_25 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_227_1:InitPlayNodeList()
	end,
	Play411051055 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 411051055
		arg_231_1.duration_ = 6.33

		local var_231_0 = {
			zh = 2.7,
			ja = 6.333
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
				arg_231_0:Play411051056(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			local var_234_0 = arg_231_1.actors_["10058ui_story"]
			local var_234_1 = 0

			if var_234_1 < arg_231_1.time_ and arg_231_1.time_ <= var_234_1 + arg_234_0 and not isNil(var_234_0) and arg_231_1.var_.characterEffect10058ui_story == nil then
				arg_231_1.var_.characterEffect10058ui_story = var_234_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_234_2 = 0.200000002980232

			if var_234_1 <= arg_231_1.time_ and arg_231_1.time_ < var_234_1 + var_234_2 and not isNil(var_234_0) then
				local var_234_3 = (arg_231_1.time_ - var_234_1) / var_234_2

				if arg_231_1.var_.characterEffect10058ui_story and not isNil(var_234_0) then
					local var_234_4 = Mathf.Lerp(0, 0.5, var_234_3)

					arg_231_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_231_1.var_.characterEffect10058ui_story.fillRatio = var_234_4
				end
			end

			if arg_231_1.time_ >= var_234_1 + var_234_2 and arg_231_1.time_ < var_234_1 + var_234_2 + arg_234_0 and not isNil(var_234_0) and arg_231_1.var_.characterEffect10058ui_story then
				local var_234_5 = 0.5

				arg_231_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_231_1.var_.characterEffect10058ui_story.fillRatio = var_234_5
			end

			local var_234_6 = arg_231_1.actors_["10014ui_story"]
			local var_234_7 = 0

			if var_234_7 < arg_231_1.time_ and arg_231_1.time_ <= var_234_7 + arg_234_0 and not isNil(var_234_6) and arg_231_1.var_.characterEffect10014ui_story == nil then
				arg_231_1.var_.characterEffect10014ui_story = var_234_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_234_8 = 0.200000002980232

			if var_234_7 <= arg_231_1.time_ and arg_231_1.time_ < var_234_7 + var_234_8 and not isNil(var_234_6) then
				local var_234_9 = (arg_231_1.time_ - var_234_7) / var_234_8

				if arg_231_1.var_.characterEffect10014ui_story and not isNil(var_234_6) then
					arg_231_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_231_1.time_ >= var_234_7 + var_234_8 and arg_231_1.time_ < var_234_7 + var_234_8 + arg_234_0 and not isNil(var_234_6) and arg_231_1.var_.characterEffect10014ui_story then
				arg_231_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			local var_234_10 = 0
			local var_234_11 = 0.4

			if var_234_10 < arg_231_1.time_ and arg_231_1.time_ <= var_234_10 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				local var_234_12 = arg_231_1:FormatText(StoryNameCfg[264].name)

				arg_231_1.leftNameTxt_.text = var_234_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_13 = arg_231_1:GetWordFromCfg(411051055)
				local var_234_14 = arg_231_1:FormatText(var_234_13.content)

				arg_231_1.text_.text = var_234_14

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_15 = 16
				local var_234_16 = utf8.len(var_234_14)
				local var_234_17 = var_234_15 <= 0 and var_234_11 or var_234_11 * (var_234_16 / var_234_15)

				if var_234_17 > 0 and var_234_11 < var_234_17 then
					arg_231_1.talkMaxDuration = var_234_17

					if var_234_17 + var_234_10 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_17 + var_234_10
					end
				end

				arg_231_1.text_.text = var_234_14
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051055", "story_v_out_411051.awb") ~= 0 then
					local var_234_18 = manager.audio:GetVoiceLength("story_v_out_411051", "411051055", "story_v_out_411051.awb") / 1000

					if var_234_18 + var_234_10 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_18 + var_234_10
					end

					if var_234_13.prefab_name ~= "" and arg_231_1.actors_[var_234_13.prefab_name] ~= nil then
						local var_234_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_231_1.actors_[var_234_13.prefab_name].transform, "story_v_out_411051", "411051055", "story_v_out_411051.awb")

						arg_231_1:RecordAudio("411051055", var_234_19)
						arg_231_1:RecordAudio("411051055", var_234_19)
					else
						arg_231_1:AudioAction("play", "voice", "story_v_out_411051", "411051055", "story_v_out_411051.awb")
					end

					arg_231_1:RecordHistoryTalkVoice("story_v_out_411051", "411051055", "story_v_out_411051.awb")
				end

				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_20 = math.max(var_234_11, arg_231_1.talkMaxDuration)

			if var_234_10 <= arg_231_1.time_ and arg_231_1.time_ < var_234_10 + var_234_20 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_10) / var_234_20

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_10 + var_234_20 and arg_231_1.time_ < var_234_10 + var_234_20 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {}

		arg_231_1:InitPlayNodeList()
	end,
	Play411051056 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 411051056
		arg_235_1.duration_ = 6.97

		local var_235_0 = {
			zh = 6.966,
			ja = 5.666
		}
		local var_235_1 = manager.audio:GetLocalizationFlag()

		if var_235_0[var_235_1] ~= nil then
			arg_235_1.duration_ = var_235_0[var_235_1]
		end

		SetActive(arg_235_1.tipsGo_, false)

		function arg_235_1.onSingleLineFinish_()
			arg_235_1.onSingleLineUpdate_ = nil
			arg_235_1.onSingleLineFinish_ = nil
			arg_235_1.state_ = "waiting"
		end

		function arg_235_1.playNext_(arg_237_0)
			if arg_237_0 == 1 then
				arg_235_0:Play411051057(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			local var_238_0 = 0
			local var_238_1 = 0.875

			if var_238_0 < arg_235_1.time_ and arg_235_1.time_ <= var_238_0 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				local var_238_2 = arg_235_1:FormatText(StoryNameCfg[264].name)

				arg_235_1.leftNameTxt_.text = var_238_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_3 = arg_235_1:GetWordFromCfg(411051056)
				local var_238_4 = arg_235_1:FormatText(var_238_3.content)

				arg_235_1.text_.text = var_238_4

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_5 = 35
				local var_238_6 = utf8.len(var_238_4)
				local var_238_7 = var_238_5 <= 0 and var_238_1 or var_238_1 * (var_238_6 / var_238_5)

				if var_238_7 > 0 and var_238_1 < var_238_7 then
					arg_235_1.talkMaxDuration = var_238_7

					if var_238_7 + var_238_0 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_7 + var_238_0
					end
				end

				arg_235_1.text_.text = var_238_4
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051056", "story_v_out_411051.awb") ~= 0 then
					local var_238_8 = manager.audio:GetVoiceLength("story_v_out_411051", "411051056", "story_v_out_411051.awb") / 1000

					if var_238_8 + var_238_0 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_8 + var_238_0
					end

					if var_238_3.prefab_name ~= "" and arg_235_1.actors_[var_238_3.prefab_name] ~= nil then
						local var_238_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_235_1.actors_[var_238_3.prefab_name].transform, "story_v_out_411051", "411051056", "story_v_out_411051.awb")

						arg_235_1:RecordAudio("411051056", var_238_9)
						arg_235_1:RecordAudio("411051056", var_238_9)
					else
						arg_235_1:AudioAction("play", "voice", "story_v_out_411051", "411051056", "story_v_out_411051.awb")
					end

					arg_235_1:RecordHistoryTalkVoice("story_v_out_411051", "411051056", "story_v_out_411051.awb")
				end

				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_10 = math.max(var_238_1, arg_235_1.talkMaxDuration)

			if var_238_0 <= arg_235_1.time_ and arg_235_1.time_ < var_238_0 + var_238_10 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_0) / var_238_10

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_0 + var_238_10 and arg_235_1.time_ < var_238_0 + var_238_10 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {}

		arg_235_1:InitPlayNodeList()
	end,
	Play411051057 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 411051057
		arg_239_1.duration_ = 4.13

		local var_239_0 = {
			zh = 3.4,
			ja = 4.133
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
				arg_239_0:Play411051058(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			local var_242_0 = arg_239_1.actors_["10058ui_story"]
			local var_242_1 = 0

			if var_242_1 < arg_239_1.time_ and arg_239_1.time_ <= var_242_1 + arg_242_0 and not isNil(var_242_0) and arg_239_1.var_.characterEffect10058ui_story == nil then
				arg_239_1.var_.characterEffect10058ui_story = var_242_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_242_2 = 0.200000002980232

			if var_242_1 <= arg_239_1.time_ and arg_239_1.time_ < var_242_1 + var_242_2 and not isNil(var_242_0) then
				local var_242_3 = (arg_239_1.time_ - var_242_1) / var_242_2

				if arg_239_1.var_.characterEffect10058ui_story and not isNil(var_242_0) then
					arg_239_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_239_1.time_ >= var_242_1 + var_242_2 and arg_239_1.time_ < var_242_1 + var_242_2 + arg_242_0 and not isNil(var_242_0) and arg_239_1.var_.characterEffect10058ui_story then
				arg_239_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_242_4 = 0

			if var_242_4 < arg_239_1.time_ and arg_239_1.time_ <= var_242_4 + arg_242_0 then
				arg_239_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_242_5 = arg_239_1.actors_["10014ui_story"]
			local var_242_6 = 0

			if var_242_6 < arg_239_1.time_ and arg_239_1.time_ <= var_242_6 + arg_242_0 and not isNil(var_242_5) and arg_239_1.var_.characterEffect10014ui_story == nil then
				arg_239_1.var_.characterEffect10014ui_story = var_242_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_242_7 = 0.200000002980232

			if var_242_6 <= arg_239_1.time_ and arg_239_1.time_ < var_242_6 + var_242_7 and not isNil(var_242_5) then
				local var_242_8 = (arg_239_1.time_ - var_242_6) / var_242_7

				if arg_239_1.var_.characterEffect10014ui_story and not isNil(var_242_5) then
					local var_242_9 = Mathf.Lerp(0, 0.5, var_242_8)

					arg_239_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_239_1.var_.characterEffect10014ui_story.fillRatio = var_242_9
				end
			end

			if arg_239_1.time_ >= var_242_6 + var_242_7 and arg_239_1.time_ < var_242_6 + var_242_7 + arg_242_0 and not isNil(var_242_5) and arg_239_1.var_.characterEffect10014ui_story then
				local var_242_10 = 0.5

				arg_239_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_239_1.var_.characterEffect10014ui_story.fillRatio = var_242_10
			end

			local var_242_11 = 0
			local var_242_12 = 0.45

			if var_242_11 < arg_239_1.time_ and arg_239_1.time_ <= var_242_11 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				local var_242_13 = arg_239_1:FormatText(StoryNameCfg[471].name)

				arg_239_1.leftNameTxt_.text = var_242_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_14 = arg_239_1:GetWordFromCfg(411051057)
				local var_242_15 = arg_239_1:FormatText(var_242_14.content)

				arg_239_1.text_.text = var_242_15

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_16 = 18
				local var_242_17 = utf8.len(var_242_15)
				local var_242_18 = var_242_16 <= 0 and var_242_12 or var_242_12 * (var_242_17 / var_242_16)

				if var_242_18 > 0 and var_242_12 < var_242_18 then
					arg_239_1.talkMaxDuration = var_242_18

					if var_242_18 + var_242_11 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_18 + var_242_11
					end
				end

				arg_239_1.text_.text = var_242_15
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051057", "story_v_out_411051.awb") ~= 0 then
					local var_242_19 = manager.audio:GetVoiceLength("story_v_out_411051", "411051057", "story_v_out_411051.awb") / 1000

					if var_242_19 + var_242_11 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_19 + var_242_11
					end

					if var_242_14.prefab_name ~= "" and arg_239_1.actors_[var_242_14.prefab_name] ~= nil then
						local var_242_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_239_1.actors_[var_242_14.prefab_name].transform, "story_v_out_411051", "411051057", "story_v_out_411051.awb")

						arg_239_1:RecordAudio("411051057", var_242_20)
						arg_239_1:RecordAudio("411051057", var_242_20)
					else
						arg_239_1:AudioAction("play", "voice", "story_v_out_411051", "411051057", "story_v_out_411051.awb")
					end

					arg_239_1:RecordHistoryTalkVoice("story_v_out_411051", "411051057", "story_v_out_411051.awb")
				end

				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_21 = math.max(var_242_12, arg_239_1.talkMaxDuration)

			if var_242_11 <= arg_239_1.time_ and arg_239_1.time_ < var_242_11 + var_242_21 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_11) / var_242_21

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_11 + var_242_21 and arg_239_1.time_ < var_242_11 + var_242_21 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {}

		arg_239_1:InitPlayNodeList()
	end,
	Play411051058 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 411051058
		arg_243_1.duration_ = 7.17

		local var_243_0 = {
			zh = 7.166,
			ja = 6.5
		}
		local var_243_1 = manager.audio:GetLocalizationFlag()

		if var_243_0[var_243_1] ~= nil then
			arg_243_1.duration_ = var_243_0[var_243_1]
		end

		SetActive(arg_243_1.tipsGo_, false)

		function arg_243_1.onSingleLineFinish_()
			arg_243_1.onSingleLineUpdate_ = nil
			arg_243_1.onSingleLineFinish_ = nil
			arg_243_1.state_ = "waiting"
		end

		function arg_243_1.playNext_(arg_245_0)
			if arg_245_0 == 1 then
				arg_243_0:Play411051059(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			local var_246_0 = arg_243_1.actors_["10014ui_story"].transform
			local var_246_1 = 0

			if var_246_1 < arg_243_1.time_ and arg_243_1.time_ <= var_246_1 + arg_246_0 then
				arg_243_1.var_.moveOldPos10014ui_story = var_246_0.localPosition
			end

			local var_246_2 = 0.001

			if var_246_1 <= arg_243_1.time_ and arg_243_1.time_ < var_246_1 + var_246_2 then
				local var_246_3 = (arg_243_1.time_ - var_246_1) / var_246_2
				local var_246_4 = Vector3.New(0.7, -1.06, -6.2)

				var_246_0.localPosition = Vector3.Lerp(arg_243_1.var_.moveOldPos10014ui_story, var_246_4, var_246_3)

				local var_246_5 = manager.ui.mainCamera.transform.position - var_246_0.position

				var_246_0.forward = Vector3.New(var_246_5.x, var_246_5.y, var_246_5.z)

				local var_246_6 = var_246_0.localEulerAngles

				var_246_6.z = 0
				var_246_6.x = 0
				var_246_0.localEulerAngles = var_246_6
			end

			if arg_243_1.time_ >= var_246_1 + var_246_2 and arg_243_1.time_ < var_246_1 + var_246_2 + arg_246_0 then
				var_246_0.localPosition = Vector3.New(0.7, -1.06, -6.2)

				local var_246_7 = manager.ui.mainCamera.transform.position - var_246_0.position

				var_246_0.forward = Vector3.New(var_246_7.x, var_246_7.y, var_246_7.z)

				local var_246_8 = var_246_0.localEulerAngles

				var_246_8.z = 0
				var_246_8.x = 0
				var_246_0.localEulerAngles = var_246_8
			end

			local var_246_9 = arg_243_1.actors_["10014ui_story"]
			local var_246_10 = 0

			if var_246_10 < arg_243_1.time_ and arg_243_1.time_ <= var_246_10 + arg_246_0 and not isNil(var_246_9) and arg_243_1.var_.characterEffect10014ui_story == nil then
				arg_243_1.var_.characterEffect10014ui_story = var_246_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_246_11 = 0.200000002980232

			if var_246_10 <= arg_243_1.time_ and arg_243_1.time_ < var_246_10 + var_246_11 and not isNil(var_246_9) then
				local var_246_12 = (arg_243_1.time_ - var_246_10) / var_246_11

				if arg_243_1.var_.characterEffect10014ui_story and not isNil(var_246_9) then
					arg_243_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_243_1.time_ >= var_246_10 + var_246_11 and arg_243_1.time_ < var_246_10 + var_246_11 + arg_246_0 and not isNil(var_246_9) and arg_243_1.var_.characterEffect10014ui_story then
				arg_243_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			local var_246_13 = 0

			if var_246_13 < arg_243_1.time_ and arg_243_1.time_ <= var_246_13 + arg_246_0 then
				arg_243_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/story10014/story10014action/10014action1_1")
			end

			local var_246_14 = 0

			if var_246_14 < arg_243_1.time_ and arg_243_1.time_ <= var_246_14 + arg_246_0 then
				arg_243_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_246_15 = arg_243_1.actors_["10058ui_story"]
			local var_246_16 = 0

			if var_246_16 < arg_243_1.time_ and arg_243_1.time_ <= var_246_16 + arg_246_0 and not isNil(var_246_15) and arg_243_1.var_.characterEffect10058ui_story == nil then
				arg_243_1.var_.characterEffect10058ui_story = var_246_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_246_17 = 0.0166666666666667

			if var_246_16 <= arg_243_1.time_ and arg_243_1.time_ < var_246_16 + var_246_17 and not isNil(var_246_15) then
				local var_246_18 = (arg_243_1.time_ - var_246_16) / var_246_17

				if arg_243_1.var_.characterEffect10058ui_story and not isNil(var_246_15) then
					local var_246_19 = Mathf.Lerp(0, 0.5, var_246_18)

					arg_243_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_243_1.var_.characterEffect10058ui_story.fillRatio = var_246_19
				end
			end

			if arg_243_1.time_ >= var_246_16 + var_246_17 and arg_243_1.time_ < var_246_16 + var_246_17 + arg_246_0 and not isNil(var_246_15) and arg_243_1.var_.characterEffect10058ui_story then
				local var_246_20 = 0.5

				arg_243_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_243_1.var_.characterEffect10058ui_story.fillRatio = var_246_20
			end

			local var_246_21 = 0
			local var_246_22 = 0.9

			if var_246_21 < arg_243_1.time_ and arg_243_1.time_ <= var_246_21 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				local var_246_23 = arg_243_1:FormatText(StoryNameCfg[264].name)

				arg_243_1.leftNameTxt_.text = var_246_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_24 = arg_243_1:GetWordFromCfg(411051058)
				local var_246_25 = arg_243_1:FormatText(var_246_24.content)

				arg_243_1.text_.text = var_246_25

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_26 = 36
				local var_246_27 = utf8.len(var_246_25)
				local var_246_28 = var_246_26 <= 0 and var_246_22 or var_246_22 * (var_246_27 / var_246_26)

				if var_246_28 > 0 and var_246_22 < var_246_28 then
					arg_243_1.talkMaxDuration = var_246_28

					if var_246_28 + var_246_21 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_28 + var_246_21
					end
				end

				arg_243_1.text_.text = var_246_25
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051058", "story_v_out_411051.awb") ~= 0 then
					local var_246_29 = manager.audio:GetVoiceLength("story_v_out_411051", "411051058", "story_v_out_411051.awb") / 1000

					if var_246_29 + var_246_21 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_29 + var_246_21
					end

					if var_246_24.prefab_name ~= "" and arg_243_1.actors_[var_246_24.prefab_name] ~= nil then
						local var_246_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_243_1.actors_[var_246_24.prefab_name].transform, "story_v_out_411051", "411051058", "story_v_out_411051.awb")

						arg_243_1:RecordAudio("411051058", var_246_30)
						arg_243_1:RecordAudio("411051058", var_246_30)
					else
						arg_243_1:AudioAction("play", "voice", "story_v_out_411051", "411051058", "story_v_out_411051.awb")
					end

					arg_243_1:RecordHistoryTalkVoice("story_v_out_411051", "411051058", "story_v_out_411051.awb")
				end

				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_31 = math.max(var_246_22, arg_243_1.talkMaxDuration)

			if var_246_21 <= arg_243_1.time_ and arg_243_1.time_ < var_246_21 + var_246_31 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_21) / var_246_31

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_21 + var_246_31 and arg_243_1.time_ < var_246_21 + var_246_31 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10014ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_243_1:InitPlayNodeList()
	end,
	Play411051059 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 411051059
		arg_247_1.duration_ = 11.1

		local var_247_0 = {
			zh = 11.1,
			ja = 7.566
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
				arg_247_0:Play411051060(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			local var_250_0 = 0
			local var_250_1 = 1.325

			if var_250_0 < arg_247_1.time_ and arg_247_1.time_ <= var_250_0 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				local var_250_2 = arg_247_1:FormatText(StoryNameCfg[264].name)

				arg_247_1.leftNameTxt_.text = var_250_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_3 = arg_247_1:GetWordFromCfg(411051059)
				local var_250_4 = arg_247_1:FormatText(var_250_3.content)

				arg_247_1.text_.text = var_250_4

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_5 = 53
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

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051059", "story_v_out_411051.awb") ~= 0 then
					local var_250_8 = manager.audio:GetVoiceLength("story_v_out_411051", "411051059", "story_v_out_411051.awb") / 1000

					if var_250_8 + var_250_0 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_8 + var_250_0
					end

					if var_250_3.prefab_name ~= "" and arg_247_1.actors_[var_250_3.prefab_name] ~= nil then
						local var_250_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_247_1.actors_[var_250_3.prefab_name].transform, "story_v_out_411051", "411051059", "story_v_out_411051.awb")

						arg_247_1:RecordAudio("411051059", var_250_9)
						arg_247_1:RecordAudio("411051059", var_250_9)
					else
						arg_247_1:AudioAction("play", "voice", "story_v_out_411051", "411051059", "story_v_out_411051.awb")
					end

					arg_247_1:RecordHistoryTalkVoice("story_v_out_411051", "411051059", "story_v_out_411051.awb")
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
	Play411051060 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 411051060
		arg_251_1.duration_ = 1.57

		local var_251_0 = {
			zh = 1.3,
			ja = 1.566
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
				arg_251_0:Play411051061(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			local var_254_0 = 0
			local var_254_1 = 0.15

			if var_254_0 < arg_251_1.time_ and arg_251_1.time_ <= var_254_0 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				local var_254_2 = arg_251_1:FormatText(StoryNameCfg[264].name)

				arg_251_1.leftNameTxt_.text = var_254_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, false)
				arg_251_1.callingController_:SetSelectedState("normal")

				local var_254_3 = arg_251_1:GetWordFromCfg(411051060)
				local var_254_4 = arg_251_1:FormatText(var_254_3.content)

				arg_251_1.text_.text = var_254_4

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_5 = 6
				local var_254_6 = utf8.len(var_254_4)
				local var_254_7 = var_254_5 <= 0 and var_254_1 or var_254_1 * (var_254_6 / var_254_5)

				if var_254_7 > 0 and var_254_1 < var_254_7 then
					arg_251_1.talkMaxDuration = var_254_7

					if var_254_7 + var_254_0 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_7 + var_254_0
					end
				end

				arg_251_1.text_.text = var_254_4
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051060", "story_v_out_411051.awb") ~= 0 then
					local var_254_8 = manager.audio:GetVoiceLength("story_v_out_411051", "411051060", "story_v_out_411051.awb") / 1000

					if var_254_8 + var_254_0 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_8 + var_254_0
					end

					if var_254_3.prefab_name ~= "" and arg_251_1.actors_[var_254_3.prefab_name] ~= nil then
						local var_254_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_251_1.actors_[var_254_3.prefab_name].transform, "story_v_out_411051", "411051060", "story_v_out_411051.awb")

						arg_251_1:RecordAudio("411051060", var_254_9)
						arg_251_1:RecordAudio("411051060", var_254_9)
					else
						arg_251_1:AudioAction("play", "voice", "story_v_out_411051", "411051060", "story_v_out_411051.awb")
					end

					arg_251_1:RecordHistoryTalkVoice("story_v_out_411051", "411051060", "story_v_out_411051.awb")
				end

				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_10 = math.max(var_254_1, arg_251_1.talkMaxDuration)

			if var_254_0 <= arg_251_1.time_ and arg_251_1.time_ < var_254_0 + var_254_10 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_0) / var_254_10

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_0 + var_254_10 and arg_251_1.time_ < var_254_0 + var_254_10 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {}

		arg_251_1:InitPlayNodeList()
	end,
	Play411051061 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 411051061
		arg_255_1.duration_ = 3.97

		local var_255_0 = {
			zh = 3.7,
			ja = 3.966
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
				arg_255_0:Play411051062(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			local var_258_0 = arg_255_1.actors_["10014ui_story"]
			local var_258_1 = 0

			if var_258_1 < arg_255_1.time_ and arg_255_1.time_ <= var_258_1 + arg_258_0 and not isNil(var_258_0) and arg_255_1.var_.characterEffect10014ui_story == nil then
				arg_255_1.var_.characterEffect10014ui_story = var_258_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_258_2 = 0.200000002980232

			if var_258_1 <= arg_255_1.time_ and arg_255_1.time_ < var_258_1 + var_258_2 and not isNil(var_258_0) then
				local var_258_3 = (arg_255_1.time_ - var_258_1) / var_258_2

				if arg_255_1.var_.characterEffect10014ui_story and not isNil(var_258_0) then
					local var_258_4 = Mathf.Lerp(0, 0.5, var_258_3)

					arg_255_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_255_1.var_.characterEffect10014ui_story.fillRatio = var_258_4
				end
			end

			if arg_255_1.time_ >= var_258_1 + var_258_2 and arg_255_1.time_ < var_258_1 + var_258_2 + arg_258_0 and not isNil(var_258_0) and arg_255_1.var_.characterEffect10014ui_story then
				local var_258_5 = 0.5

				arg_255_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_255_1.var_.characterEffect10014ui_story.fillRatio = var_258_5
			end

			local var_258_6 = arg_255_1.actors_["10058ui_story"]
			local var_258_7 = 0

			if var_258_7 < arg_255_1.time_ and arg_255_1.time_ <= var_258_7 + arg_258_0 and not isNil(var_258_6) and arg_255_1.var_.characterEffect10058ui_story == nil then
				arg_255_1.var_.characterEffect10058ui_story = var_258_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_258_8 = 0.200000002980232

			if var_258_7 <= arg_255_1.time_ and arg_255_1.time_ < var_258_7 + var_258_8 and not isNil(var_258_6) then
				local var_258_9 = (arg_255_1.time_ - var_258_7) / var_258_8

				if arg_255_1.var_.characterEffect10058ui_story and not isNil(var_258_6) then
					arg_255_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_255_1.time_ >= var_258_7 + var_258_8 and arg_255_1.time_ < var_258_7 + var_258_8 + arg_258_0 and not isNil(var_258_6) and arg_255_1.var_.characterEffect10058ui_story then
				arg_255_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_258_10 = 0
			local var_258_11 = 0.45

			if var_258_10 < arg_255_1.time_ and arg_255_1.time_ <= var_258_10 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, true)

				local var_258_12 = arg_255_1:FormatText(StoryNameCfg[471].name)

				arg_255_1.leftNameTxt_.text = var_258_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_255_1.leftNameTxt_.transform)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1.leftNameTxt_.text)
				SetActive(arg_255_1.iconTrs_.gameObject, false)
				arg_255_1.callingController_:SetSelectedState("normal")

				local var_258_13 = arg_255_1:GetWordFromCfg(411051061)
				local var_258_14 = arg_255_1:FormatText(var_258_13.content)

				arg_255_1.text_.text = var_258_14

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_15 = 18
				local var_258_16 = utf8.len(var_258_14)
				local var_258_17 = var_258_15 <= 0 and var_258_11 or var_258_11 * (var_258_16 / var_258_15)

				if var_258_17 > 0 and var_258_11 < var_258_17 then
					arg_255_1.talkMaxDuration = var_258_17

					if var_258_17 + var_258_10 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_17 + var_258_10
					end
				end

				arg_255_1.text_.text = var_258_14
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051061", "story_v_out_411051.awb") ~= 0 then
					local var_258_18 = manager.audio:GetVoiceLength("story_v_out_411051", "411051061", "story_v_out_411051.awb") / 1000

					if var_258_18 + var_258_10 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_18 + var_258_10
					end

					if var_258_13.prefab_name ~= "" and arg_255_1.actors_[var_258_13.prefab_name] ~= nil then
						local var_258_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_255_1.actors_[var_258_13.prefab_name].transform, "story_v_out_411051", "411051061", "story_v_out_411051.awb")

						arg_255_1:RecordAudio("411051061", var_258_19)
						arg_255_1:RecordAudio("411051061", var_258_19)
					else
						arg_255_1:AudioAction("play", "voice", "story_v_out_411051", "411051061", "story_v_out_411051.awb")
					end

					arg_255_1:RecordHistoryTalkVoice("story_v_out_411051", "411051061", "story_v_out_411051.awb")
				end

				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_20 = math.max(var_258_11, arg_255_1.talkMaxDuration)

			if var_258_10 <= arg_255_1.time_ and arg_255_1.time_ < var_258_10 + var_258_20 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - var_258_10) / var_258_20

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= var_258_10 + var_258_20 and arg_255_1.time_ < var_258_10 + var_258_20 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {}

		arg_255_1:InitPlayNodeList()
	end,
	Play411051062 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 411051062
		arg_259_1.duration_ = 3.73

		local var_259_0 = {
			zh = 2.1,
			ja = 3.733
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
				arg_259_0:Play411051063(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			local var_262_0 = arg_259_1.actors_["10058ui_story"].transform
			local var_262_1 = 0

			if var_262_1 < arg_259_1.time_ and arg_259_1.time_ <= var_262_1 + arg_262_0 then
				arg_259_1.var_.moveOldPos10058ui_story = var_262_0.localPosition
			end

			local var_262_2 = 0.001

			if var_262_1 <= arg_259_1.time_ and arg_259_1.time_ < var_262_1 + var_262_2 then
				local var_262_3 = (arg_259_1.time_ - var_262_1) / var_262_2
				local var_262_4 = Vector3.New(-0.7, -0.98, -6.1)

				var_262_0.localPosition = Vector3.Lerp(arg_259_1.var_.moveOldPos10058ui_story, var_262_4, var_262_3)

				local var_262_5 = manager.ui.mainCamera.transform.position - var_262_0.position

				var_262_0.forward = Vector3.New(var_262_5.x, var_262_5.y, var_262_5.z)

				local var_262_6 = var_262_0.localEulerAngles

				var_262_6.z = 0
				var_262_6.x = 0
				var_262_0.localEulerAngles = var_262_6
			end

			if arg_259_1.time_ >= var_262_1 + var_262_2 and arg_259_1.time_ < var_262_1 + var_262_2 + arg_262_0 then
				var_262_0.localPosition = Vector3.New(-0.7, -0.98, -6.1)

				local var_262_7 = manager.ui.mainCamera.transform.position - var_262_0.position

				var_262_0.forward = Vector3.New(var_262_7.x, var_262_7.y, var_262_7.z)

				local var_262_8 = var_262_0.localEulerAngles

				var_262_8.z = 0
				var_262_8.x = 0
				var_262_0.localEulerAngles = var_262_8
			end

			local var_262_9 = 0

			if var_262_9 < arg_259_1.time_ and arg_259_1.time_ <= var_262_9 + arg_262_0 then
				arg_259_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_262_10 = 0
			local var_262_11 = 0.325

			if var_262_10 < arg_259_1.time_ and arg_259_1.time_ <= var_262_10 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, true)

				local var_262_12 = arg_259_1:FormatText(StoryNameCfg[471].name)

				arg_259_1.leftNameTxt_.text = var_262_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_259_1.leftNameTxt_.transform)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1.leftNameTxt_.text)
				SetActive(arg_259_1.iconTrs_.gameObject, false)
				arg_259_1.callingController_:SetSelectedState("normal")

				local var_262_13 = arg_259_1:GetWordFromCfg(411051062)
				local var_262_14 = arg_259_1:FormatText(var_262_13.content)

				arg_259_1.text_.text = var_262_14

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_15 = 13
				local var_262_16 = utf8.len(var_262_14)
				local var_262_17 = var_262_15 <= 0 and var_262_11 or var_262_11 * (var_262_16 / var_262_15)

				if var_262_17 > 0 and var_262_11 < var_262_17 then
					arg_259_1.talkMaxDuration = var_262_17

					if var_262_17 + var_262_10 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_17 + var_262_10
					end
				end

				arg_259_1.text_.text = var_262_14
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051062", "story_v_out_411051.awb") ~= 0 then
					local var_262_18 = manager.audio:GetVoiceLength("story_v_out_411051", "411051062", "story_v_out_411051.awb") / 1000

					if var_262_18 + var_262_10 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_18 + var_262_10
					end

					if var_262_13.prefab_name ~= "" and arg_259_1.actors_[var_262_13.prefab_name] ~= nil then
						local var_262_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_259_1.actors_[var_262_13.prefab_name].transform, "story_v_out_411051", "411051062", "story_v_out_411051.awb")

						arg_259_1:RecordAudio("411051062", var_262_19)
						arg_259_1:RecordAudio("411051062", var_262_19)
					else
						arg_259_1:AudioAction("play", "voice", "story_v_out_411051", "411051062", "story_v_out_411051.awb")
					end

					arg_259_1:RecordHistoryTalkVoice("story_v_out_411051", "411051062", "story_v_out_411051.awb")
				end

				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_20 = math.max(var_262_11, arg_259_1.talkMaxDuration)

			if var_262_10 <= arg_259_1.time_ and arg_259_1.time_ < var_262_10 + var_262_20 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - var_262_10) / var_262_20

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= var_262_10 + var_262_20 and arg_259_1.time_ < var_262_10 + var_262_20 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
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
	Play411051063 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 411051063
		arg_263_1.duration_ = 14.47

		local var_263_0 = {
			zh = 7,
			ja = 14.466
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
				arg_263_0:Play411051064(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			local var_266_0 = arg_263_1.actors_["10058ui_story"]
			local var_266_1 = 0

			if var_266_1 < arg_263_1.time_ and arg_263_1.time_ <= var_266_1 + arg_266_0 and not isNil(var_266_0) and arg_263_1.var_.characterEffect10058ui_story == nil then
				arg_263_1.var_.characterEffect10058ui_story = var_266_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_266_2 = 0.200000002980232

			if var_266_1 <= arg_263_1.time_ and arg_263_1.time_ < var_266_1 + var_266_2 and not isNil(var_266_0) then
				local var_266_3 = (arg_263_1.time_ - var_266_1) / var_266_2

				if arg_263_1.var_.characterEffect10058ui_story and not isNil(var_266_0) then
					local var_266_4 = Mathf.Lerp(0, 0.5, var_266_3)

					arg_263_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_263_1.var_.characterEffect10058ui_story.fillRatio = var_266_4
				end
			end

			if arg_263_1.time_ >= var_266_1 + var_266_2 and arg_263_1.time_ < var_266_1 + var_266_2 + arg_266_0 and not isNil(var_266_0) and arg_263_1.var_.characterEffect10058ui_story then
				local var_266_5 = 0.5

				arg_263_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_263_1.var_.characterEffect10058ui_story.fillRatio = var_266_5
			end

			local var_266_6 = arg_263_1.actors_["10014ui_story"]
			local var_266_7 = 0

			if var_266_7 < arg_263_1.time_ and arg_263_1.time_ <= var_266_7 + arg_266_0 and not isNil(var_266_6) and arg_263_1.var_.characterEffect10014ui_story == nil then
				arg_263_1.var_.characterEffect10014ui_story = var_266_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_266_8 = 0.200000002980232

			if var_266_7 <= arg_263_1.time_ and arg_263_1.time_ < var_266_7 + var_266_8 and not isNil(var_266_6) then
				local var_266_9 = (arg_263_1.time_ - var_266_7) / var_266_8

				if arg_263_1.var_.characterEffect10014ui_story and not isNil(var_266_6) then
					arg_263_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_263_1.time_ >= var_266_7 + var_266_8 and arg_263_1.time_ < var_266_7 + var_266_8 + arg_266_0 and not isNil(var_266_6) and arg_263_1.var_.characterEffect10014ui_story then
				arg_263_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			local var_266_10 = 0
			local var_266_11 = 0.825

			if var_266_10 < arg_263_1.time_ and arg_263_1.time_ <= var_266_10 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, true)

				local var_266_12 = arg_263_1:FormatText(StoryNameCfg[264].name)

				arg_263_1.leftNameTxt_.text = var_266_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_263_1.leftNameTxt_.transform)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1.leftNameTxt_.text)
				SetActive(arg_263_1.iconTrs_.gameObject, false)
				arg_263_1.callingController_:SetSelectedState("normal")

				local var_266_13 = arg_263_1:GetWordFromCfg(411051063)
				local var_266_14 = arg_263_1:FormatText(var_266_13.content)

				arg_263_1.text_.text = var_266_14

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_15 = 33
				local var_266_16 = utf8.len(var_266_14)
				local var_266_17 = var_266_15 <= 0 and var_266_11 or var_266_11 * (var_266_16 / var_266_15)

				if var_266_17 > 0 and var_266_11 < var_266_17 then
					arg_263_1.talkMaxDuration = var_266_17

					if var_266_17 + var_266_10 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_17 + var_266_10
					end
				end

				arg_263_1.text_.text = var_266_14
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051063", "story_v_out_411051.awb") ~= 0 then
					local var_266_18 = manager.audio:GetVoiceLength("story_v_out_411051", "411051063", "story_v_out_411051.awb") / 1000

					if var_266_18 + var_266_10 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_18 + var_266_10
					end

					if var_266_13.prefab_name ~= "" and arg_263_1.actors_[var_266_13.prefab_name] ~= nil then
						local var_266_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_263_1.actors_[var_266_13.prefab_name].transform, "story_v_out_411051", "411051063", "story_v_out_411051.awb")

						arg_263_1:RecordAudio("411051063", var_266_19)
						arg_263_1:RecordAudio("411051063", var_266_19)
					else
						arg_263_1:AudioAction("play", "voice", "story_v_out_411051", "411051063", "story_v_out_411051.awb")
					end

					arg_263_1:RecordHistoryTalkVoice("story_v_out_411051", "411051063", "story_v_out_411051.awb")
				end

				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_20 = math.max(var_266_11, arg_263_1.talkMaxDuration)

			if var_266_10 <= arg_263_1.time_ and arg_263_1.time_ < var_266_10 + var_266_20 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - var_266_10) / var_266_20

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= var_266_10 + var_266_20 and arg_263_1.time_ < var_266_10 + var_266_20 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {}

		arg_263_1:InitPlayNodeList()
	end,
	Play411051064 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 411051064
		arg_267_1.duration_ = 5.5

		local var_267_0 = {
			zh = 4.8,
			ja = 5.5
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
				arg_267_0:Play411051065(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			local var_270_0 = arg_267_1.actors_["10058ui_story"]
			local var_270_1 = 0

			if var_270_1 < arg_267_1.time_ and arg_267_1.time_ <= var_270_1 + arg_270_0 and not isNil(var_270_0) and arg_267_1.var_.characterEffect10058ui_story == nil then
				arg_267_1.var_.characterEffect10058ui_story = var_270_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_270_2 = 0.200000002980232

			if var_270_1 <= arg_267_1.time_ and arg_267_1.time_ < var_270_1 + var_270_2 and not isNil(var_270_0) then
				local var_270_3 = (arg_267_1.time_ - var_270_1) / var_270_2

				if arg_267_1.var_.characterEffect10058ui_story and not isNil(var_270_0) then
					arg_267_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_267_1.time_ >= var_270_1 + var_270_2 and arg_267_1.time_ < var_270_1 + var_270_2 + arg_270_0 and not isNil(var_270_0) and arg_267_1.var_.characterEffect10058ui_story then
				arg_267_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_270_4 = 0

			if var_270_4 < arg_267_1.time_ and arg_267_1.time_ <= var_270_4 + arg_270_0 then
				arg_267_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_270_5 = arg_267_1.actors_["10014ui_story"]
			local var_270_6 = 0

			if var_270_6 < arg_267_1.time_ and arg_267_1.time_ <= var_270_6 + arg_270_0 and not isNil(var_270_5) and arg_267_1.var_.characterEffect10014ui_story == nil then
				arg_267_1.var_.characterEffect10014ui_story = var_270_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_270_7 = 0.200000002980232

			if var_270_6 <= arg_267_1.time_ and arg_267_1.time_ < var_270_6 + var_270_7 and not isNil(var_270_5) then
				local var_270_8 = (arg_267_1.time_ - var_270_6) / var_270_7

				if arg_267_1.var_.characterEffect10014ui_story and not isNil(var_270_5) then
					local var_270_9 = Mathf.Lerp(0, 0.5, var_270_8)

					arg_267_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_267_1.var_.characterEffect10014ui_story.fillRatio = var_270_9
				end
			end

			if arg_267_1.time_ >= var_270_6 + var_270_7 and arg_267_1.time_ < var_270_6 + var_270_7 + arg_270_0 and not isNil(var_270_5) and arg_267_1.var_.characterEffect10014ui_story then
				local var_270_10 = 0.5

				arg_267_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_267_1.var_.characterEffect10014ui_story.fillRatio = var_270_10
			end

			local var_270_11 = 0
			local var_270_12 = 0.525

			if var_270_11 < arg_267_1.time_ and arg_267_1.time_ <= var_270_11 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, true)

				local var_270_13 = arg_267_1:FormatText(StoryNameCfg[471].name)

				arg_267_1.leftNameTxt_.text = var_270_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_267_1.leftNameTxt_.transform)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1.leftNameTxt_.text)
				SetActive(arg_267_1.iconTrs_.gameObject, false)
				arg_267_1.callingController_:SetSelectedState("normal")

				local var_270_14 = arg_267_1:GetWordFromCfg(411051064)
				local var_270_15 = arg_267_1:FormatText(var_270_14.content)

				arg_267_1.text_.text = var_270_15

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_16 = 21
				local var_270_17 = utf8.len(var_270_15)
				local var_270_18 = var_270_16 <= 0 and var_270_12 or var_270_12 * (var_270_17 / var_270_16)

				if var_270_18 > 0 and var_270_12 < var_270_18 then
					arg_267_1.talkMaxDuration = var_270_18

					if var_270_18 + var_270_11 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_18 + var_270_11
					end
				end

				arg_267_1.text_.text = var_270_15
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051064", "story_v_out_411051.awb") ~= 0 then
					local var_270_19 = manager.audio:GetVoiceLength("story_v_out_411051", "411051064", "story_v_out_411051.awb") / 1000

					if var_270_19 + var_270_11 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_19 + var_270_11
					end

					if var_270_14.prefab_name ~= "" and arg_267_1.actors_[var_270_14.prefab_name] ~= nil then
						local var_270_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_267_1.actors_[var_270_14.prefab_name].transform, "story_v_out_411051", "411051064", "story_v_out_411051.awb")

						arg_267_1:RecordAudio("411051064", var_270_20)
						arg_267_1:RecordAudio("411051064", var_270_20)
					else
						arg_267_1:AudioAction("play", "voice", "story_v_out_411051", "411051064", "story_v_out_411051.awb")
					end

					arg_267_1:RecordHistoryTalkVoice("story_v_out_411051", "411051064", "story_v_out_411051.awb")
				end

				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_21 = math.max(var_270_12, arg_267_1.talkMaxDuration)

			if var_270_11 <= arg_267_1.time_ and arg_267_1.time_ < var_270_11 + var_270_21 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - var_270_11) / var_270_21

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= var_270_11 + var_270_21 and arg_267_1.time_ < var_270_11 + var_270_21 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {}

		arg_267_1:InitPlayNodeList()
	end,
	Play411051065 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 411051065
		arg_271_1.duration_ = 9.3

		local var_271_0 = {
			zh = 4.1,
			ja = 9.3
		}
		local var_271_1 = manager.audio:GetLocalizationFlag()

		if var_271_0[var_271_1] ~= nil then
			arg_271_1.duration_ = var_271_0[var_271_1]
		end

		SetActive(arg_271_1.tipsGo_, false)

		function arg_271_1.onSingleLineFinish_()
			arg_271_1.onSingleLineUpdate_ = nil
			arg_271_1.onSingleLineFinish_ = nil
			arg_271_1.state_ = "waiting"
		end

		function arg_271_1.playNext_(arg_273_0)
			if arg_273_0 == 1 then
				arg_271_0:Play411051066(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			local var_274_0 = arg_271_1.actors_["10014ui_story"]
			local var_274_1 = 0

			if var_274_1 < arg_271_1.time_ and arg_271_1.time_ <= var_274_1 + arg_274_0 and not isNil(var_274_0) and arg_271_1.var_.characterEffect10014ui_story == nil then
				arg_271_1.var_.characterEffect10014ui_story = var_274_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_274_2 = 0.200000002980232

			if var_274_1 <= arg_271_1.time_ and arg_271_1.time_ < var_274_1 + var_274_2 and not isNil(var_274_0) then
				local var_274_3 = (arg_271_1.time_ - var_274_1) / var_274_2

				if arg_271_1.var_.characterEffect10014ui_story and not isNil(var_274_0) then
					arg_271_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_271_1.time_ >= var_274_1 + var_274_2 and arg_271_1.time_ < var_274_1 + var_274_2 + arg_274_0 and not isNil(var_274_0) and arg_271_1.var_.characterEffect10014ui_story then
				arg_271_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			local var_274_4 = 0

			if var_274_4 < arg_271_1.time_ and arg_271_1.time_ <= var_274_4 + arg_274_0 then
				arg_271_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/story10014/story10014action/10014action5_1")
			end

			local var_274_5 = 0

			if var_274_5 < arg_271_1.time_ and arg_271_1.time_ <= var_274_5 + arg_274_0 then
				arg_271_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_274_6 = arg_271_1.actors_["10058ui_story"]
			local var_274_7 = 0

			if var_274_7 < arg_271_1.time_ and arg_271_1.time_ <= var_274_7 + arg_274_0 and not isNil(var_274_6) and arg_271_1.var_.characterEffect10058ui_story == nil then
				arg_271_1.var_.characterEffect10058ui_story = var_274_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_274_8 = 0.200000002980232

			if var_274_7 <= arg_271_1.time_ and arg_271_1.time_ < var_274_7 + var_274_8 and not isNil(var_274_6) then
				local var_274_9 = (arg_271_1.time_ - var_274_7) / var_274_8

				if arg_271_1.var_.characterEffect10058ui_story and not isNil(var_274_6) then
					local var_274_10 = Mathf.Lerp(0, 0.5, var_274_9)

					arg_271_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_271_1.var_.characterEffect10058ui_story.fillRatio = var_274_10
				end
			end

			if arg_271_1.time_ >= var_274_7 + var_274_8 and arg_271_1.time_ < var_274_7 + var_274_8 + arg_274_0 and not isNil(var_274_6) and arg_271_1.var_.characterEffect10058ui_story then
				local var_274_11 = 0.5

				arg_271_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_271_1.var_.characterEffect10058ui_story.fillRatio = var_274_11
			end

			local var_274_12 = 0
			local var_274_13 = 0.475

			if var_274_12 < arg_271_1.time_ and arg_271_1.time_ <= var_274_12 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, true)

				local var_274_14 = arg_271_1:FormatText(StoryNameCfg[264].name)

				arg_271_1.leftNameTxt_.text = var_274_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_271_1.leftNameTxt_.transform)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1.leftNameTxt_.text)
				SetActive(arg_271_1.iconTrs_.gameObject, false)
				arg_271_1.callingController_:SetSelectedState("normal")

				local var_274_15 = arg_271_1:GetWordFromCfg(411051065)
				local var_274_16 = arg_271_1:FormatText(var_274_15.content)

				arg_271_1.text_.text = var_274_16

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_17 = 19
				local var_274_18 = utf8.len(var_274_16)
				local var_274_19 = var_274_17 <= 0 and var_274_13 or var_274_13 * (var_274_18 / var_274_17)

				if var_274_19 > 0 and var_274_13 < var_274_19 then
					arg_271_1.talkMaxDuration = var_274_19

					if var_274_19 + var_274_12 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_19 + var_274_12
					end
				end

				arg_271_1.text_.text = var_274_16
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051065", "story_v_out_411051.awb") ~= 0 then
					local var_274_20 = manager.audio:GetVoiceLength("story_v_out_411051", "411051065", "story_v_out_411051.awb") / 1000

					if var_274_20 + var_274_12 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_20 + var_274_12
					end

					if var_274_15.prefab_name ~= "" and arg_271_1.actors_[var_274_15.prefab_name] ~= nil then
						local var_274_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_271_1.actors_[var_274_15.prefab_name].transform, "story_v_out_411051", "411051065", "story_v_out_411051.awb")

						arg_271_1:RecordAudio("411051065", var_274_21)
						arg_271_1:RecordAudio("411051065", var_274_21)
					else
						arg_271_1:AudioAction("play", "voice", "story_v_out_411051", "411051065", "story_v_out_411051.awb")
					end

					arg_271_1:RecordHistoryTalkVoice("story_v_out_411051", "411051065", "story_v_out_411051.awb")
				end

				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_22 = math.max(var_274_13, arg_271_1.talkMaxDuration)

			if var_274_12 <= arg_271_1.time_ and arg_271_1.time_ < var_274_12 + var_274_22 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - var_274_12) / var_274_22

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= var_274_12 + var_274_22 and arg_271_1.time_ < var_274_12 + var_274_22 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {}

		arg_271_1:InitPlayNodeList()
	end,
	Play411051066 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 411051066
		arg_275_1.duration_ = 3.43

		local var_275_0 = {
			zh = 2.833,
			ja = 3.433
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
				arg_275_0:Play411051067(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			local var_278_0 = arg_275_1.actors_["10014ui_story"]
			local var_278_1 = 0

			if var_278_1 < arg_275_1.time_ and arg_275_1.time_ <= var_278_1 + arg_278_0 and not isNil(var_278_0) and arg_275_1.var_.characterEffect10014ui_story == nil then
				arg_275_1.var_.characterEffect10014ui_story = var_278_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_278_2 = 0.200000002980232

			if var_278_1 <= arg_275_1.time_ and arg_275_1.time_ < var_278_1 + var_278_2 and not isNil(var_278_0) then
				local var_278_3 = (arg_275_1.time_ - var_278_1) / var_278_2

				if arg_275_1.var_.characterEffect10014ui_story and not isNil(var_278_0) then
					local var_278_4 = Mathf.Lerp(0, 0.5, var_278_3)

					arg_275_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_275_1.var_.characterEffect10014ui_story.fillRatio = var_278_4
				end
			end

			if arg_275_1.time_ >= var_278_1 + var_278_2 and arg_275_1.time_ < var_278_1 + var_278_2 + arg_278_0 and not isNil(var_278_0) and arg_275_1.var_.characterEffect10014ui_story then
				local var_278_5 = 0.5

				arg_275_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_275_1.var_.characterEffect10014ui_story.fillRatio = var_278_5
			end

			local var_278_6 = arg_275_1.actors_["10058ui_story"]
			local var_278_7 = 0

			if var_278_7 < arg_275_1.time_ and arg_275_1.time_ <= var_278_7 + arg_278_0 and not isNil(var_278_6) and arg_275_1.var_.characterEffect10058ui_story == nil then
				arg_275_1.var_.characterEffect10058ui_story = var_278_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_278_8 = 0.200000002980232

			if var_278_7 <= arg_275_1.time_ and arg_275_1.time_ < var_278_7 + var_278_8 and not isNil(var_278_6) then
				local var_278_9 = (arg_275_1.time_ - var_278_7) / var_278_8

				if arg_275_1.var_.characterEffect10058ui_story and not isNil(var_278_6) then
					arg_275_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_275_1.time_ >= var_278_7 + var_278_8 and arg_275_1.time_ < var_278_7 + var_278_8 + arg_278_0 and not isNil(var_278_6) and arg_275_1.var_.characterEffect10058ui_story then
				arg_275_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_278_10 = 0

			if var_278_10 < arg_275_1.time_ and arg_275_1.time_ <= var_278_10 + arg_278_0 then
				arg_275_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_278_11 = 0
			local var_278_12 = 0.275

			if var_278_11 < arg_275_1.time_ and arg_275_1.time_ <= var_278_11 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, true)

				local var_278_13 = arg_275_1:FormatText(StoryNameCfg[471].name)

				arg_275_1.leftNameTxt_.text = var_278_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_275_1.leftNameTxt_.transform)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1.leftNameTxt_.text)
				SetActive(arg_275_1.iconTrs_.gameObject, false)
				arg_275_1.callingController_:SetSelectedState("normal")

				local var_278_14 = arg_275_1:GetWordFromCfg(411051066)
				local var_278_15 = arg_275_1:FormatText(var_278_14.content)

				arg_275_1.text_.text = var_278_15

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_16 = 11
				local var_278_17 = utf8.len(var_278_15)
				local var_278_18 = var_278_16 <= 0 and var_278_12 or var_278_12 * (var_278_17 / var_278_16)

				if var_278_18 > 0 and var_278_12 < var_278_18 then
					arg_275_1.talkMaxDuration = var_278_18

					if var_278_18 + var_278_11 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_18 + var_278_11
					end
				end

				arg_275_1.text_.text = var_278_15
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051066", "story_v_out_411051.awb") ~= 0 then
					local var_278_19 = manager.audio:GetVoiceLength("story_v_out_411051", "411051066", "story_v_out_411051.awb") / 1000

					if var_278_19 + var_278_11 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_19 + var_278_11
					end

					if var_278_14.prefab_name ~= "" and arg_275_1.actors_[var_278_14.prefab_name] ~= nil then
						local var_278_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_275_1.actors_[var_278_14.prefab_name].transform, "story_v_out_411051", "411051066", "story_v_out_411051.awb")

						arg_275_1:RecordAudio("411051066", var_278_20)
						arg_275_1:RecordAudio("411051066", var_278_20)
					else
						arg_275_1:AudioAction("play", "voice", "story_v_out_411051", "411051066", "story_v_out_411051.awb")
					end

					arg_275_1:RecordHistoryTalkVoice("story_v_out_411051", "411051066", "story_v_out_411051.awb")
				end

				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_21 = math.max(var_278_12, arg_275_1.talkMaxDuration)

			if var_278_11 <= arg_275_1.time_ and arg_275_1.time_ < var_278_11 + var_278_21 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - var_278_11) / var_278_21

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= var_278_11 + var_278_21 and arg_275_1.time_ < var_278_11 + var_278_21 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {}

		arg_275_1:InitPlayNodeList()
	end,
	Play411051067 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 411051067
		arg_279_1.duration_ = 9

		SetActive(arg_279_1.tipsGo_, false)

		function arg_279_1.onSingleLineFinish_()
			arg_279_1.onSingleLineUpdate_ = nil
			arg_279_1.onSingleLineFinish_ = nil
			arg_279_1.state_ = "waiting"
		end

		function arg_279_1.playNext_(arg_281_0)
			if arg_281_0 == 1 then
				arg_279_0:Play411051068(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			local var_282_0 = 0

			if var_282_0 < arg_279_1.time_ and arg_279_1.time_ <= var_282_0 + arg_282_0 then
				local var_282_1 = manager.ui.mainCamera.transform.localPosition
				local var_282_2 = Vector3.New(0, 0, 10) + Vector3.New(var_282_1.x, var_282_1.y, 0)
				local var_282_3 = arg_279_1.bgs_.I07

				var_282_3.transform.localPosition = var_282_2
				var_282_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_282_4 = var_282_3:GetComponent("SpriteRenderer")

				if var_282_4 and var_282_4.sprite then
					local var_282_5 = (var_282_3.transform.localPosition - var_282_1).z
					local var_282_6 = manager.ui.mainCameraCom_
					local var_282_7 = 2 * var_282_5 * Mathf.Tan(var_282_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_282_8 = var_282_7 * var_282_6.aspect
					local var_282_9 = var_282_4.sprite.bounds.size.x
					local var_282_10 = var_282_4.sprite.bounds.size.y
					local var_282_11 = var_282_8 / var_282_9
					local var_282_12 = var_282_7 / var_282_10
					local var_282_13 = var_282_12 < var_282_11 and var_282_11 or var_282_12

					var_282_3.transform.localScale = Vector3.New(var_282_13, var_282_13, 0)
				end

				for iter_282_0, iter_282_1 in pairs(arg_279_1.bgs_) do
					if iter_282_0 ~= "I07" then
						iter_282_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_282_14 = 2

			if var_282_14 < arg_279_1.time_ and arg_279_1.time_ <= var_282_14 + arg_282_0 then
				local var_282_15 = manager.ui.mainCamera.transform.localPosition
				local var_282_16 = Vector3.New(0, 0, 10) + Vector3.New(var_282_15.x, var_282_15.y, 0)
				local var_282_17 = arg_279_1.bgs_.ST03

				var_282_17.transform.localPosition = var_282_16
				var_282_17.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_282_18 = var_282_17:GetComponent("SpriteRenderer")

				if var_282_18 and var_282_18.sprite then
					local var_282_19 = (var_282_17.transform.localPosition - var_282_15).z
					local var_282_20 = manager.ui.mainCameraCom_
					local var_282_21 = 2 * var_282_19 * Mathf.Tan(var_282_20.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_282_22 = var_282_21 * var_282_20.aspect
					local var_282_23 = var_282_18.sprite.bounds.size.x
					local var_282_24 = var_282_18.sprite.bounds.size.y
					local var_282_25 = var_282_22 / var_282_23
					local var_282_26 = var_282_21 / var_282_24
					local var_282_27 = var_282_26 < var_282_25 and var_282_25 or var_282_26

					var_282_17.transform.localScale = Vector3.New(var_282_27, var_282_27, 0)
				end

				for iter_282_2, iter_282_3 in pairs(arg_279_1.bgs_) do
					if iter_282_2 ~= "ST03" then
						iter_282_3.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_282_28 = 0

			if var_282_28 < arg_279_1.time_ and arg_279_1.time_ <= var_282_28 + arg_282_0 then
				arg_279_1.mask_.enabled = true
				arg_279_1.mask_.raycastTarget = true

				arg_279_1:SetGaussion(false)
			end

			local var_282_29 = 2

			if var_282_28 <= arg_279_1.time_ and arg_279_1.time_ < var_282_28 + var_282_29 then
				local var_282_30 = (arg_279_1.time_ - var_282_28) / var_282_29
				local var_282_31 = Color.New(0, 0, 0)

				var_282_31.a = Mathf.Lerp(0, 1, var_282_30)
				arg_279_1.mask_.color = var_282_31
			end

			if arg_279_1.time_ >= var_282_28 + var_282_29 and arg_279_1.time_ < var_282_28 + var_282_29 + arg_282_0 then
				local var_282_32 = Color.New(0, 0, 0)

				var_282_32.a = 1
				arg_279_1.mask_.color = var_282_32
			end

			local var_282_33 = 2

			if var_282_33 < arg_279_1.time_ and arg_279_1.time_ <= var_282_33 + arg_282_0 then
				arg_279_1.mask_.enabled = true
				arg_279_1.mask_.raycastTarget = true

				arg_279_1:SetGaussion(false)
			end

			local var_282_34 = 2

			if var_282_33 <= arg_279_1.time_ and arg_279_1.time_ < var_282_33 + var_282_34 then
				local var_282_35 = (arg_279_1.time_ - var_282_33) / var_282_34
				local var_282_36 = Color.New(0, 0, 0)

				var_282_36.a = Mathf.Lerp(1, 0, var_282_35)
				arg_279_1.mask_.color = var_282_36
			end

			if arg_279_1.time_ >= var_282_33 + var_282_34 and arg_279_1.time_ < var_282_33 + var_282_34 + arg_282_0 then
				local var_282_37 = Color.New(0, 0, 0)
				local var_282_38 = 0

				arg_279_1.mask_.enabled = false
				var_282_37.a = var_282_38
				arg_279_1.mask_.color = var_282_37
			end

			local var_282_39 = arg_279_1.actors_["10058ui_story"]
			local var_282_40 = 2

			if var_282_40 < arg_279_1.time_ and arg_279_1.time_ <= var_282_40 + arg_282_0 and not isNil(var_282_39) and arg_279_1.var_.characterEffect10058ui_story == nil then
				arg_279_1.var_.characterEffect10058ui_story = var_282_39:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_282_41 = 0.200000002980232

			if var_282_40 <= arg_279_1.time_ and arg_279_1.time_ < var_282_40 + var_282_41 and not isNil(var_282_39) then
				local var_282_42 = (arg_279_1.time_ - var_282_40) / var_282_41

				if arg_279_1.var_.characterEffect10058ui_story and not isNil(var_282_39) then
					local var_282_43 = Mathf.Lerp(0, 0.5, var_282_42)

					arg_279_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_279_1.var_.characterEffect10058ui_story.fillRatio = var_282_43
				end
			end

			if arg_279_1.time_ >= var_282_40 + var_282_41 and arg_279_1.time_ < var_282_40 + var_282_41 + arg_282_0 and not isNil(var_282_39) and arg_279_1.var_.characterEffect10058ui_story then
				local var_282_44 = 0.5

				arg_279_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_279_1.var_.characterEffect10058ui_story.fillRatio = var_282_44
			end

			local var_282_45 = arg_279_1.actors_["10058ui_story"].transform
			local var_282_46 = 2

			if var_282_46 < arg_279_1.time_ and arg_279_1.time_ <= var_282_46 + arg_282_0 then
				arg_279_1.var_.moveOldPos10058ui_story = var_282_45.localPosition
			end

			local var_282_47 = 0.001

			if var_282_46 <= arg_279_1.time_ and arg_279_1.time_ < var_282_46 + var_282_47 then
				local var_282_48 = (arg_279_1.time_ - var_282_46) / var_282_47
				local var_282_49 = Vector3.New(0, 100, 0)

				var_282_45.localPosition = Vector3.Lerp(arg_279_1.var_.moveOldPos10058ui_story, var_282_49, var_282_48)

				local var_282_50 = manager.ui.mainCamera.transform.position - var_282_45.position

				var_282_45.forward = Vector3.New(var_282_50.x, var_282_50.y, var_282_50.z)

				local var_282_51 = var_282_45.localEulerAngles

				var_282_51.z = 0
				var_282_51.x = 0
				var_282_45.localEulerAngles = var_282_51
			end

			if arg_279_1.time_ >= var_282_46 + var_282_47 and arg_279_1.time_ < var_282_46 + var_282_47 + arg_282_0 then
				var_282_45.localPosition = Vector3.New(0, 100, 0)

				local var_282_52 = manager.ui.mainCamera.transform.position - var_282_45.position

				var_282_45.forward = Vector3.New(var_282_52.x, var_282_52.y, var_282_52.z)

				local var_282_53 = var_282_45.localEulerAngles

				var_282_53.z = 0
				var_282_53.x = 0
				var_282_45.localEulerAngles = var_282_53
			end

			local var_282_54 = arg_279_1.actors_["10014ui_story"].transform
			local var_282_55 = 2

			if var_282_55 < arg_279_1.time_ and arg_279_1.time_ <= var_282_55 + arg_282_0 then
				arg_279_1.var_.moveOldPos10014ui_story = var_282_54.localPosition
			end

			local var_282_56 = 0.001

			if var_282_55 <= arg_279_1.time_ and arg_279_1.time_ < var_282_55 + var_282_56 then
				local var_282_57 = (arg_279_1.time_ - var_282_55) / var_282_56
				local var_282_58 = Vector3.New(0, 100, 0)

				var_282_54.localPosition = Vector3.Lerp(arg_279_1.var_.moveOldPos10014ui_story, var_282_58, var_282_57)

				local var_282_59 = manager.ui.mainCamera.transform.position - var_282_54.position

				var_282_54.forward = Vector3.New(var_282_59.x, var_282_59.y, var_282_59.z)

				local var_282_60 = var_282_54.localEulerAngles

				var_282_60.z = 0
				var_282_60.x = 0
				var_282_54.localEulerAngles = var_282_60
			end

			if arg_279_1.time_ >= var_282_55 + var_282_56 and arg_279_1.time_ < var_282_55 + var_282_56 + arg_282_0 then
				var_282_54.localPosition = Vector3.New(0, 100, 0)

				local var_282_61 = manager.ui.mainCamera.transform.position - var_282_54.position

				var_282_54.forward = Vector3.New(var_282_61.x, var_282_61.y, var_282_61.z)

				local var_282_62 = var_282_54.localEulerAngles

				var_282_62.z = 0
				var_282_62.x = 0
				var_282_54.localEulerAngles = var_282_62
			end

			local var_282_63 = arg_279_1.actors_["10014ui_story"]
			local var_282_64 = 2

			if var_282_64 < arg_279_1.time_ and arg_279_1.time_ <= var_282_64 + arg_282_0 and not isNil(var_282_63) and arg_279_1.var_.characterEffect10014ui_story == nil then
				arg_279_1.var_.characterEffect10014ui_story = var_282_63:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_282_65 = 0.200000002980232

			if var_282_64 <= arg_279_1.time_ and arg_279_1.time_ < var_282_64 + var_282_65 and not isNil(var_282_63) then
				local var_282_66 = (arg_279_1.time_ - var_282_64) / var_282_65

				if arg_279_1.var_.characterEffect10014ui_story and not isNil(var_282_63) then
					local var_282_67 = Mathf.Lerp(0, 0.5, var_282_66)

					arg_279_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_279_1.var_.characterEffect10014ui_story.fillRatio = var_282_67
				end
			end

			if arg_279_1.time_ >= var_282_64 + var_282_65 and arg_279_1.time_ < var_282_64 + var_282_65 + arg_282_0 and not isNil(var_282_63) and arg_279_1.var_.characterEffect10014ui_story then
				local var_282_68 = 0.5

				arg_279_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_279_1.var_.characterEffect10014ui_story.fillRatio = var_282_68
			end

			if arg_279_1.frameCnt_ <= 1 then
				arg_279_1.dialog_:SetActive(false)
			end

			local var_282_69 = 4
			local var_282_70 = 0.825

			if var_282_69 < arg_279_1.time_ and arg_279_1.time_ <= var_282_69 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0

				arg_279_1.dialog_:SetActive(true)

				arg_279_1.dialogCg_.alpha = 0

				local var_282_71 = LeanTween.value(arg_279_1.dialog_, 0, 1, 0.3)

				var_282_71:setOnUpdate(LuaHelper.FloatAction(function(arg_283_0)
					arg_279_1.dialogCg_.alpha = arg_283_0
				end))
				var_282_71:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_279_1.dialog_)
					var_282_71:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_279_1.duration_ = arg_279_1.duration_ + 0.3

				SetActive(arg_279_1.leftNameGo_, false)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_279_1.iconTrs_.gameObject, false)
				arg_279_1.callingController_:SetSelectedState("normal")

				local var_282_72 = arg_279_1:GetWordFromCfg(411051067)
				local var_282_73 = arg_279_1:FormatText(var_282_72.content)

				arg_279_1.text_.text = var_282_73

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_74 = 33
				local var_282_75 = utf8.len(var_282_73)
				local var_282_76 = var_282_74 <= 0 and var_282_70 or var_282_70 * (var_282_75 / var_282_74)

				if var_282_76 > 0 and var_282_70 < var_282_76 then
					arg_279_1.talkMaxDuration = var_282_76
					var_282_69 = var_282_69 + 0.3

					if var_282_76 + var_282_69 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_76 + var_282_69
					end
				end

				arg_279_1.text_.text = var_282_73
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)
				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_77 = var_282_69 + 0.3
			local var_282_78 = math.max(var_282_70, arg_279_1.talkMaxDuration)

			if var_282_77 <= arg_279_1.time_ and arg_279_1.time_ < var_282_77 + var_282_78 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - var_282_77) / var_282_78

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= var_282_77 + var_282_78 and arg_279_1.time_ < var_282_77 + var_282_78 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10014ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_279_1:InitPlayNodeList()
	end,
	Play411051068 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 411051068
		arg_285_1.duration_ = 5

		SetActive(arg_285_1.tipsGo_, false)

		function arg_285_1.onSingleLineFinish_()
			arg_285_1.onSingleLineUpdate_ = nil
			arg_285_1.onSingleLineFinish_ = nil
			arg_285_1.state_ = "waiting"
		end

		function arg_285_1.playNext_(arg_287_0)
			if arg_287_0 == 1 then
				arg_285_0:Play411051069(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			local var_288_0 = 0
			local var_288_1 = 0.366666666666667

			if var_288_0 < arg_285_1.time_ and arg_285_1.time_ <= var_288_0 + arg_288_0 then
				local var_288_2 = "play"
				local var_288_3 = "music"

				arg_285_1:AudioAction(var_288_2, var_288_3, "ui_battle", "ui_battle_stopbgm", "")

				local var_288_4 = ""
				local var_288_5 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_288_5 ~= "" then
					if arg_285_1.bgmTxt_.text ~= var_288_5 and arg_285_1.bgmTxt_.text ~= "" then
						if arg_285_1.bgmTxt2_.text ~= "" then
							arg_285_1.bgmTxt_.text = arg_285_1.bgmTxt2_.text
						end

						arg_285_1.bgmTxt2_.text = var_288_5

						arg_285_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_285_1.bgmTxt_.text = var_288_5
						arg_285_1.bgmTxt2_.text = var_288_5
					end

					if arg_285_1.bgmTimer then
						arg_285_1.bgmTimer:Stop()

						arg_285_1.bgmTimer = nil
					end

					if arg_285_1.settingData.show_music_name == 1 then
						arg_285_1.musicController:SetSelectedState("show")
						arg_285_1.musicAnimator_:Play("open", 0, 0)

						if arg_285_1.settingData.music_time ~= 0 then
							arg_285_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_285_1.settingData.music_time), function()
								if arg_285_1 == nil or isNil(arg_285_1.bgmTxt_) then
									return
								end

								arg_285_1.musicController:SetSelectedState("hide")
								arg_285_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_288_6 = 0
			local var_288_7 = 1.3

			if var_288_6 < arg_285_1.time_ and arg_285_1.time_ <= var_288_6 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, false)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_285_1.iconTrs_.gameObject, false)
				arg_285_1.callingController_:SetSelectedState("normal")

				local var_288_8 = arg_285_1:GetWordFromCfg(411051068)
				local var_288_9 = arg_285_1:FormatText(var_288_8.content)

				arg_285_1.text_.text = var_288_9

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_10 = 52
				local var_288_11 = utf8.len(var_288_9)
				local var_288_12 = var_288_10 <= 0 and var_288_7 or var_288_7 * (var_288_11 / var_288_10)

				if var_288_12 > 0 and var_288_7 < var_288_12 then
					arg_285_1.talkMaxDuration = var_288_12

					if var_288_12 + var_288_6 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_12 + var_288_6
					end
				end

				arg_285_1.text_.text = var_288_9
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)
				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_13 = math.max(var_288_7, arg_285_1.talkMaxDuration)

			if var_288_6 <= arg_285_1.time_ and arg_285_1.time_ < var_288_6 + var_288_13 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_6) / var_288_13

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_6 + var_288_13 and arg_285_1.time_ < var_288_6 + var_288_13 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {}

		arg_285_1:InitPlayNodeList()
	end,
	Play411051069 = function(arg_290_0, arg_290_1)
		arg_290_1.time_ = 0
		arg_290_1.frameCnt_ = 0
		arg_290_1.state_ = "playing"
		arg_290_1.curTalkId_ = 411051069
		arg_290_1.duration_ = 2.03

		local var_290_0 = {
			zh = 1.999999999999,
			ja = 2.033
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
				arg_290_0:Play411051070(arg_290_1)
			end
		end

		function arg_290_1.onSingleLineUpdate_(arg_293_0)
			local var_293_0 = arg_290_1.actors_["10058ui_story"].transform
			local var_293_1 = 0

			if var_293_1 < arg_290_1.time_ and arg_290_1.time_ <= var_293_1 + arg_293_0 then
				arg_290_1.var_.moveOldPos10058ui_story = var_293_0.localPosition
			end

			local var_293_2 = 0.001

			if var_293_1 <= arg_290_1.time_ and arg_290_1.time_ < var_293_1 + var_293_2 then
				local var_293_3 = (arg_290_1.time_ - var_293_1) / var_293_2
				local var_293_4 = Vector3.New(0, -0.98, -6.1)

				var_293_0.localPosition = Vector3.Lerp(arg_290_1.var_.moveOldPos10058ui_story, var_293_4, var_293_3)

				local var_293_5 = manager.ui.mainCamera.transform.position - var_293_0.position

				var_293_0.forward = Vector3.New(var_293_5.x, var_293_5.y, var_293_5.z)

				local var_293_6 = var_293_0.localEulerAngles

				var_293_6.z = 0
				var_293_6.x = 0
				var_293_0.localEulerAngles = var_293_6
			end

			if arg_290_1.time_ >= var_293_1 + var_293_2 and arg_290_1.time_ < var_293_1 + var_293_2 + arg_293_0 then
				var_293_0.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_293_7 = manager.ui.mainCamera.transform.position - var_293_0.position

				var_293_0.forward = Vector3.New(var_293_7.x, var_293_7.y, var_293_7.z)

				local var_293_8 = var_293_0.localEulerAngles

				var_293_8.z = 0
				var_293_8.x = 0
				var_293_0.localEulerAngles = var_293_8
			end

			local var_293_9 = arg_290_1.actors_["10058ui_story"]
			local var_293_10 = 0

			if var_293_10 < arg_290_1.time_ and arg_290_1.time_ <= var_293_10 + arg_293_0 and not isNil(var_293_9) and arg_290_1.var_.characterEffect10058ui_story == nil then
				arg_290_1.var_.characterEffect10058ui_story = var_293_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_293_11 = 0.200000002980232

			if var_293_10 <= arg_290_1.time_ and arg_290_1.time_ < var_293_10 + var_293_11 and not isNil(var_293_9) then
				local var_293_12 = (arg_290_1.time_ - var_293_10) / var_293_11

				if arg_290_1.var_.characterEffect10058ui_story and not isNil(var_293_9) then
					arg_290_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_290_1.time_ >= var_293_10 + var_293_11 and arg_290_1.time_ < var_293_10 + var_293_11 + arg_293_0 and not isNil(var_293_9) and arg_290_1.var_.characterEffect10058ui_story then
				arg_290_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_293_13 = 0

			if var_293_13 < arg_290_1.time_ and arg_290_1.time_ <= var_293_13 + arg_293_0 then
				arg_290_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_293_14 = 0

			if var_293_14 < arg_290_1.time_ and arg_290_1.time_ <= var_293_14 + arg_293_0 then
				arg_290_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_293_15 = 0
			local var_293_16 = 0.15

			if var_293_15 < arg_290_1.time_ and arg_290_1.time_ <= var_293_15 + arg_293_0 then
				arg_290_1.talkMaxDuration = 0
				arg_290_1.dialogCg_.alpha = 1

				arg_290_1.dialog_:SetActive(true)
				SetActive(arg_290_1.leftNameGo_, true)

				local var_293_17 = arg_290_1:FormatText(StoryNameCfg[471].name)

				arg_290_1.leftNameTxt_.text = var_293_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_290_1.leftNameTxt_.transform)

				arg_290_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_290_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_290_1:RecordName(arg_290_1.leftNameTxt_.text)
				SetActive(arg_290_1.iconTrs_.gameObject, false)
				arg_290_1.callingController_:SetSelectedState("normal")

				local var_293_18 = arg_290_1:GetWordFromCfg(411051069)
				local var_293_19 = arg_290_1:FormatText(var_293_18.content)

				arg_290_1.text_.text = var_293_19

				LuaForUtil.ClearLinePrefixSymbol(arg_290_1.text_)

				local var_293_20 = 6
				local var_293_21 = utf8.len(var_293_19)
				local var_293_22 = var_293_20 <= 0 and var_293_16 or var_293_16 * (var_293_21 / var_293_20)

				if var_293_22 > 0 and var_293_16 < var_293_22 then
					arg_290_1.talkMaxDuration = var_293_22

					if var_293_22 + var_293_15 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_22 + var_293_15
					end
				end

				arg_290_1.text_.text = var_293_19
				arg_290_1.typewritter.percent = 0

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051069", "story_v_out_411051.awb") ~= 0 then
					local var_293_23 = manager.audio:GetVoiceLength("story_v_out_411051", "411051069", "story_v_out_411051.awb") / 1000

					if var_293_23 + var_293_15 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_23 + var_293_15
					end

					if var_293_18.prefab_name ~= "" and arg_290_1.actors_[var_293_18.prefab_name] ~= nil then
						local var_293_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_290_1.actors_[var_293_18.prefab_name].transform, "story_v_out_411051", "411051069", "story_v_out_411051.awb")

						arg_290_1:RecordAudio("411051069", var_293_24)
						arg_290_1:RecordAudio("411051069", var_293_24)
					else
						arg_290_1:AudioAction("play", "voice", "story_v_out_411051", "411051069", "story_v_out_411051.awb")
					end

					arg_290_1:RecordHistoryTalkVoice("story_v_out_411051", "411051069", "story_v_out_411051.awb")
				end

				arg_290_1:RecordContent(arg_290_1.text_.text)
			end

			local var_293_25 = math.max(var_293_16, arg_290_1.talkMaxDuration)

			if var_293_15 <= arg_290_1.time_ and arg_290_1.time_ < var_293_15 + var_293_25 then
				arg_290_1.typewritter.percent = (arg_290_1.time_ - var_293_15) / var_293_25

				arg_290_1.typewritter:SetDirty()
			end

			if arg_290_1.time_ >= var_293_15 + var_293_25 and arg_290_1.time_ < var_293_15 + var_293_25 + arg_293_0 then
				arg_290_1.typewritter.percent = 1

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(true)
			end
		end

		arg_290_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_290_1:InitPlayNodeList()
	end,
	Play411051070 = function(arg_294_0, arg_294_1)
		arg_294_1.time_ = 0
		arg_294_1.frameCnt_ = 0
		arg_294_1.state_ = "playing"
		arg_294_1.curTalkId_ = 411051070
		arg_294_1.duration_ = 5

		SetActive(arg_294_1.tipsGo_, false)

		function arg_294_1.onSingleLineFinish_()
			arg_294_1.onSingleLineUpdate_ = nil
			arg_294_1.onSingleLineFinish_ = nil
			arg_294_1.state_ = "waiting"
		end

		function arg_294_1.playNext_(arg_296_0)
			if arg_296_0 == 1 then
				arg_294_0:Play411051071(arg_294_1)
			end
		end

		function arg_294_1.onSingleLineUpdate_(arg_297_0)
			local var_297_0 = arg_294_1.actors_["10058ui_story"]
			local var_297_1 = 0

			if var_297_1 < arg_294_1.time_ and arg_294_1.time_ <= var_297_1 + arg_297_0 and not isNil(var_297_0) and arg_294_1.var_.characterEffect10058ui_story == nil then
				arg_294_1.var_.characterEffect10058ui_story = var_297_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_297_2 = 0.200000002980232

			if var_297_1 <= arg_294_1.time_ and arg_294_1.time_ < var_297_1 + var_297_2 and not isNil(var_297_0) then
				local var_297_3 = (arg_294_1.time_ - var_297_1) / var_297_2

				if arg_294_1.var_.characterEffect10058ui_story and not isNil(var_297_0) then
					local var_297_4 = Mathf.Lerp(0, 0.5, var_297_3)

					arg_294_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_294_1.var_.characterEffect10058ui_story.fillRatio = var_297_4
				end
			end

			if arg_294_1.time_ >= var_297_1 + var_297_2 and arg_294_1.time_ < var_297_1 + var_297_2 + arg_297_0 and not isNil(var_297_0) and arg_294_1.var_.characterEffect10058ui_story then
				local var_297_5 = 0.5

				arg_294_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_294_1.var_.characterEffect10058ui_story.fillRatio = var_297_5
			end

			local var_297_6 = 0
			local var_297_7 = 0.7

			if var_297_6 < arg_294_1.time_ and arg_294_1.time_ <= var_297_6 + arg_297_0 then
				arg_294_1.talkMaxDuration = 0
				arg_294_1.dialogCg_.alpha = 1

				arg_294_1.dialog_:SetActive(true)
				SetActive(arg_294_1.leftNameGo_, false)

				arg_294_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_294_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_294_1:RecordName(arg_294_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_294_1.iconTrs_.gameObject, false)
				arg_294_1.callingController_:SetSelectedState("normal")

				local var_297_8 = arg_294_1:GetWordFromCfg(411051070)
				local var_297_9 = arg_294_1:FormatText(var_297_8.content)

				arg_294_1.text_.text = var_297_9

				LuaForUtil.ClearLinePrefixSymbol(arg_294_1.text_)

				local var_297_10 = 28
				local var_297_11 = utf8.len(var_297_9)
				local var_297_12 = var_297_10 <= 0 and var_297_7 or var_297_7 * (var_297_11 / var_297_10)

				if var_297_12 > 0 and var_297_7 < var_297_12 then
					arg_294_1.talkMaxDuration = var_297_12

					if var_297_12 + var_297_6 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_12 + var_297_6
					end
				end

				arg_294_1.text_.text = var_297_9
				arg_294_1.typewritter.percent = 0

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(false)
				arg_294_1:RecordContent(arg_294_1.text_.text)
			end

			local var_297_13 = math.max(var_297_7, arg_294_1.talkMaxDuration)

			if var_297_6 <= arg_294_1.time_ and arg_294_1.time_ < var_297_6 + var_297_13 then
				arg_294_1.typewritter.percent = (arg_294_1.time_ - var_297_6) / var_297_13

				arg_294_1.typewritter:SetDirty()
			end

			if arg_294_1.time_ >= var_297_6 + var_297_13 and arg_294_1.time_ < var_297_6 + var_297_13 + arg_297_0 then
				arg_294_1.typewritter.percent = 1

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(true)
			end
		end

		arg_294_1.nodeConfigList_ = {}

		arg_294_1:InitPlayNodeList()
	end,
	Play411051071 = function(arg_298_0, arg_298_1)
		arg_298_1.time_ = 0
		arg_298_1.frameCnt_ = 0
		arg_298_1.state_ = "playing"
		arg_298_1.curTalkId_ = 411051071
		arg_298_1.duration_ = 6.7

		SetActive(arg_298_1.tipsGo_, false)

		function arg_298_1.onSingleLineFinish_()
			arg_298_1.onSingleLineUpdate_ = nil
			arg_298_1.onSingleLineFinish_ = nil
			arg_298_1.state_ = "waiting"
		end

		function arg_298_1.playNext_(arg_300_0)
			if arg_300_0 == 1 then
				arg_298_0:Play411051072(arg_298_1)
			end
		end

		function arg_298_1.onSingleLineUpdate_(arg_301_0)
			local var_301_0 = "B10a"

			if arg_298_1.bgs_[var_301_0] == nil then
				local var_301_1 = Object.Instantiate(arg_298_1.paintGo_)

				var_301_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_301_0)
				var_301_1.name = var_301_0
				var_301_1.transform.parent = arg_298_1.stage_.transform
				var_301_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_298_1.bgs_[var_301_0] = var_301_1
			end

			local var_301_2 = 2

			if var_301_2 < arg_298_1.time_ and arg_298_1.time_ <= var_301_2 + arg_301_0 then
				local var_301_3 = manager.ui.mainCamera.transform.localPosition
				local var_301_4 = Vector3.New(0, 0, 10) + Vector3.New(var_301_3.x, var_301_3.y, 0)
				local var_301_5 = arg_298_1.bgs_.B10a

				var_301_5.transform.localPosition = var_301_4
				var_301_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_301_6 = var_301_5:GetComponent("SpriteRenderer")

				if var_301_6 and var_301_6.sprite then
					local var_301_7 = (var_301_5.transform.localPosition - var_301_3).z
					local var_301_8 = manager.ui.mainCameraCom_
					local var_301_9 = 2 * var_301_7 * Mathf.Tan(var_301_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_301_10 = var_301_9 * var_301_8.aspect
					local var_301_11 = var_301_6.sprite.bounds.size.x
					local var_301_12 = var_301_6.sprite.bounds.size.y
					local var_301_13 = var_301_10 / var_301_11
					local var_301_14 = var_301_9 / var_301_12
					local var_301_15 = var_301_14 < var_301_13 and var_301_13 or var_301_14

					var_301_5.transform.localScale = Vector3.New(var_301_15, var_301_15, 0)
				end

				for iter_301_0, iter_301_1 in pairs(arg_298_1.bgs_) do
					if iter_301_0 ~= "B10a" then
						iter_301_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_301_16 = 0

			if var_301_16 < arg_298_1.time_ and arg_298_1.time_ <= var_301_16 + arg_301_0 then
				arg_298_1.mask_.enabled = true
				arg_298_1.mask_.raycastTarget = true

				arg_298_1:SetGaussion(false)
			end

			local var_301_17 = 2

			if var_301_16 <= arg_298_1.time_ and arg_298_1.time_ < var_301_16 + var_301_17 then
				local var_301_18 = (arg_298_1.time_ - var_301_16) / var_301_17
				local var_301_19 = Color.New(0, 0, 0)

				var_301_19.a = Mathf.Lerp(0, 1, var_301_18)
				arg_298_1.mask_.color = var_301_19
			end

			if arg_298_1.time_ >= var_301_16 + var_301_17 and arg_298_1.time_ < var_301_16 + var_301_17 + arg_301_0 then
				local var_301_20 = Color.New(0, 0, 0)

				var_301_20.a = 1
				arg_298_1.mask_.color = var_301_20
			end

			local var_301_21 = 2

			if var_301_21 < arg_298_1.time_ and arg_298_1.time_ <= var_301_21 + arg_301_0 then
				arg_298_1.mask_.enabled = true
				arg_298_1.mask_.raycastTarget = true

				arg_298_1:SetGaussion(false)
			end

			local var_301_22 = 2

			if var_301_21 <= arg_298_1.time_ and arg_298_1.time_ < var_301_21 + var_301_22 then
				local var_301_23 = (arg_298_1.time_ - var_301_21) / var_301_22
				local var_301_24 = Color.New(0, 0, 0)

				var_301_24.a = Mathf.Lerp(1, 0, var_301_23)
				arg_298_1.mask_.color = var_301_24
			end

			if arg_298_1.time_ >= var_301_21 + var_301_22 and arg_298_1.time_ < var_301_21 + var_301_22 + arg_301_0 then
				local var_301_25 = Color.New(0, 0, 0)
				local var_301_26 = 0

				arg_298_1.mask_.enabled = false
				var_301_25.a = var_301_26
				arg_298_1.mask_.color = var_301_25
			end

			local var_301_27 = arg_298_1.actors_["10058ui_story"].transform
			local var_301_28 = 2

			if var_301_28 < arg_298_1.time_ and arg_298_1.time_ <= var_301_28 + arg_301_0 then
				arg_298_1.var_.moveOldPos10058ui_story = var_301_27.localPosition
			end

			local var_301_29 = 0.001

			if var_301_28 <= arg_298_1.time_ and arg_298_1.time_ < var_301_28 + var_301_29 then
				local var_301_30 = (arg_298_1.time_ - var_301_28) / var_301_29
				local var_301_31 = Vector3.New(0, 100, 0)

				var_301_27.localPosition = Vector3.Lerp(arg_298_1.var_.moveOldPos10058ui_story, var_301_31, var_301_30)

				local var_301_32 = manager.ui.mainCamera.transform.position - var_301_27.position

				var_301_27.forward = Vector3.New(var_301_32.x, var_301_32.y, var_301_32.z)

				local var_301_33 = var_301_27.localEulerAngles

				var_301_33.z = 0
				var_301_33.x = 0
				var_301_27.localEulerAngles = var_301_33
			end

			if arg_298_1.time_ >= var_301_28 + var_301_29 and arg_298_1.time_ < var_301_28 + var_301_29 + arg_301_0 then
				var_301_27.localPosition = Vector3.New(0, 100, 0)

				local var_301_34 = manager.ui.mainCamera.transform.position - var_301_27.position

				var_301_27.forward = Vector3.New(var_301_34.x, var_301_34.y, var_301_34.z)

				local var_301_35 = var_301_27.localEulerAngles

				var_301_35.z = 0
				var_301_35.x = 0
				var_301_27.localEulerAngles = var_301_35
			end

			local var_301_36 = arg_298_1.actors_["10058ui_story"]
			local var_301_37 = 2

			if var_301_37 < arg_298_1.time_ and arg_298_1.time_ <= var_301_37 + arg_301_0 and not isNil(var_301_36) and arg_298_1.var_.characterEffect10058ui_story == nil then
				arg_298_1.var_.characterEffect10058ui_story = var_301_36:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_301_38 = 0.200000002980232

			if var_301_37 <= arg_298_1.time_ and arg_298_1.time_ < var_301_37 + var_301_38 and not isNil(var_301_36) then
				local var_301_39 = (arg_298_1.time_ - var_301_37) / var_301_38

				if arg_298_1.var_.characterEffect10058ui_story and not isNil(var_301_36) then
					local var_301_40 = Mathf.Lerp(0, 0.5, var_301_39)

					arg_298_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_298_1.var_.characterEffect10058ui_story.fillRatio = var_301_40
				end
			end

			if arg_298_1.time_ >= var_301_37 + var_301_38 and arg_298_1.time_ < var_301_37 + var_301_38 + arg_301_0 and not isNil(var_301_36) and arg_298_1.var_.characterEffect10058ui_story then
				local var_301_41 = 0.5

				arg_298_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_298_1.var_.characterEffect10058ui_story.fillRatio = var_301_41
			end

			local var_301_42 = 0
			local var_301_43 = 0.366666666666667

			if var_301_42 < arg_298_1.time_ and arg_298_1.time_ <= var_301_42 + arg_301_0 then
				local var_301_44 = "play"
				local var_301_45 = "music"

				arg_298_1:AudioAction(var_301_44, var_301_45, "ui_battle", "ui_battle_stopbgm", "")

				local var_301_46 = ""
				local var_301_47 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_301_47 ~= "" then
					if arg_298_1.bgmTxt_.text ~= var_301_47 and arg_298_1.bgmTxt_.text ~= "" then
						if arg_298_1.bgmTxt2_.text ~= "" then
							arg_298_1.bgmTxt_.text = arg_298_1.bgmTxt2_.text
						end

						arg_298_1.bgmTxt2_.text = var_301_47

						arg_298_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_298_1.bgmTxt_.text = var_301_47
						arg_298_1.bgmTxt2_.text = var_301_47
					end

					if arg_298_1.bgmTimer then
						arg_298_1.bgmTimer:Stop()

						arg_298_1.bgmTimer = nil
					end

					if arg_298_1.settingData.show_music_name == 1 then
						arg_298_1.musicController:SetSelectedState("show")
						arg_298_1.musicAnimator_:Play("open", 0, 0)

						if arg_298_1.settingData.music_time ~= 0 then
							arg_298_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_298_1.settingData.music_time), function()
								if arg_298_1 == nil or isNil(arg_298_1.bgmTxt_) then
									return
								end

								arg_298_1.musicController:SetSelectedState("hide")
								arg_298_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_301_48 = 0.466666666666667
			local var_301_49 = 1

			if var_301_48 < arg_298_1.time_ and arg_298_1.time_ <= var_301_48 + arg_301_0 then
				local var_301_50 = "play"
				local var_301_51 = "music"

				arg_298_1:AudioAction(var_301_50, var_301_51, "bgm_story_v1_qiaolin", "bgm_story_v1_qiaolin", "bgm_story_v1_qiaolin.awb")

				local var_301_52 = ""
				local var_301_53 = manager.audio:GetAudioName("bgm_story_v1_qiaolin", "bgm_story_v1_qiaolin")

				if var_301_53 ~= "" then
					if arg_298_1.bgmTxt_.text ~= var_301_53 and arg_298_1.bgmTxt_.text ~= "" then
						if arg_298_1.bgmTxt2_.text ~= "" then
							arg_298_1.bgmTxt_.text = arg_298_1.bgmTxt2_.text
						end

						arg_298_1.bgmTxt2_.text = var_301_53

						arg_298_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_298_1.bgmTxt_.text = var_301_53
						arg_298_1.bgmTxt2_.text = var_301_53
					end

					if arg_298_1.bgmTimer then
						arg_298_1.bgmTimer:Stop()

						arg_298_1.bgmTimer = nil
					end

					if arg_298_1.settingData.show_music_name == 1 then
						arg_298_1.musicController:SetSelectedState("show")
						arg_298_1.musicAnimator_:Play("open", 0, 0)

						if arg_298_1.settingData.music_time ~= 0 then
							arg_298_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_298_1.settingData.music_time), function()
								if arg_298_1 == nil or isNil(arg_298_1.bgmTxt_) then
									return
								end

								arg_298_1.musicController:SetSelectedState("hide")
								arg_298_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_301_54 = 4
			local var_301_55 = 0.15

			if var_301_54 < arg_298_1.time_ and arg_298_1.time_ <= var_301_54 + arg_301_0 then
				local var_301_56 = "play"
				local var_301_57 = "effect"

				arg_298_1:AudioAction(var_301_56, var_301_57, "se_story_130", "se_story_130_robot", "")
			end

			if arg_298_1.frameCnt_ <= 1 then
				arg_298_1.dialog_:SetActive(false)
			end

			local var_301_58 = 4
			local var_301_59 = 0.15

			if var_301_58 < arg_298_1.time_ and arg_298_1.time_ <= var_301_58 + arg_301_0 then
				arg_298_1.talkMaxDuration = 0

				arg_298_1.dialog_:SetActive(true)

				arg_298_1.dialogCg_.alpha = 0

				local var_301_60 = LeanTween.value(arg_298_1.dialog_, 0, 1, 0.3)

				var_301_60:setOnUpdate(LuaHelper.FloatAction(function(arg_304_0)
					arg_298_1.dialogCg_.alpha = arg_304_0
				end))
				var_301_60:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_298_1.dialog_)
					var_301_60:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_298_1.duration_ = arg_298_1.duration_ + 0.3

				SetActive(arg_298_1.leftNameGo_, true)

				local var_301_61 = arg_298_1:FormatText(StoryNameCfg[674].name)

				arg_298_1.leftNameTxt_.text = var_301_61

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_298_1.leftNameTxt_.transform)

				arg_298_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_298_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_298_1:RecordName(arg_298_1.leftNameTxt_.text)
				SetActive(arg_298_1.iconTrs_.gameObject, true)
				arg_298_1.iconController_:SetSelectedState("hero")

				arg_298_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2022")

				arg_298_1.callingController_:SetSelectedState("normal")

				arg_298_1.keyicon_.color = Color.New(1, 1, 1)
				arg_298_1.icon_.color = Color.New(1, 1, 1)

				local var_301_62 = arg_298_1:GetWordFromCfg(411051071)
				local var_301_63 = arg_298_1:FormatText(var_301_62.content)

				arg_298_1.text_.text = var_301_63

				LuaForUtil.ClearLinePrefixSymbol(arg_298_1.text_)

				local var_301_64 = 6
				local var_301_65 = utf8.len(var_301_63)
				local var_301_66 = var_301_64 <= 0 and var_301_59 or var_301_59 * (var_301_65 / var_301_64)

				if var_301_66 > 0 and var_301_59 < var_301_66 then
					arg_298_1.talkMaxDuration = var_301_66
					var_301_58 = var_301_58 + 0.3

					if var_301_66 + var_301_58 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_66 + var_301_58
					end
				end

				arg_298_1.text_.text = var_301_63
				arg_298_1.typewritter.percent = 0

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051071", "story_v_out_411051.awb") ~= 0 then
					local var_301_67 = manager.audio:GetVoiceLength("story_v_out_411051", "411051071", "story_v_out_411051.awb") / 1000

					if var_301_67 + var_301_58 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_67 + var_301_58
					end

					if var_301_62.prefab_name ~= "" and arg_298_1.actors_[var_301_62.prefab_name] ~= nil then
						local var_301_68 = LuaForUtil.PlayVoiceWithCriLipsync(arg_298_1.actors_[var_301_62.prefab_name].transform, "story_v_out_411051", "411051071", "story_v_out_411051.awb")

						arg_298_1:RecordAudio("411051071", var_301_68)
						arg_298_1:RecordAudio("411051071", var_301_68)
					else
						arg_298_1:AudioAction("play", "voice", "story_v_out_411051", "411051071", "story_v_out_411051.awb")
					end

					arg_298_1:RecordHistoryTalkVoice("story_v_out_411051", "411051071", "story_v_out_411051.awb")
				end

				arg_298_1:RecordContent(arg_298_1.text_.text)
			end

			local var_301_69 = var_301_58 + 0.3
			local var_301_70 = math.max(var_301_59, arg_298_1.talkMaxDuration)

			if var_301_69 <= arg_298_1.time_ and arg_298_1.time_ < var_301_69 + var_301_70 then
				arg_298_1.typewritter.percent = (arg_298_1.time_ - var_301_69) / var_301_70

				arg_298_1.typewritter:SetDirty()
			end

			if arg_298_1.time_ >= var_301_69 + var_301_70 and arg_298_1.time_ < var_301_69 + var_301_70 + arg_301_0 then
				arg_298_1.typewritter.percent = 1

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(true)
			end
		end

		arg_298_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_298_1:InitPlayNodeList()
	end,
	Play411051072 = function(arg_306_0, arg_306_1)
		arg_306_1.time_ = 0
		arg_306_1.frameCnt_ = 0
		arg_306_1.state_ = "playing"
		arg_306_1.curTalkId_ = 411051072
		arg_306_1.duration_ = 5

		SetActive(arg_306_1.tipsGo_, false)

		function arg_306_1.onSingleLineFinish_()
			arg_306_1.onSingleLineUpdate_ = nil
			arg_306_1.onSingleLineFinish_ = nil
			arg_306_1.state_ = "waiting"
		end

		function arg_306_1.playNext_(arg_308_0)
			if arg_308_0 == 1 then
				arg_306_0:Play411051073(arg_306_1)
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

				local var_309_2 = arg_306_1:GetWordFromCfg(411051072)
				local var_309_3 = arg_306_1:FormatText(var_309_2.content)

				arg_306_1.text_.text = var_309_3

				LuaForUtil.ClearLinePrefixSymbol(arg_306_1.text_)

				local var_309_4 = 32
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
	Play411051073 = function(arg_310_0, arg_310_1)
		arg_310_1.time_ = 0
		arg_310_1.frameCnt_ = 0
		arg_310_1.state_ = "playing"
		arg_310_1.curTalkId_ = 411051073
		arg_310_1.duration_ = 6.9

		local var_310_0 = {
			zh = 3.866,
			ja = 6.9
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
				arg_310_0:Play411051074(arg_310_1)
			end
		end

		function arg_310_1.onSingleLineUpdate_(arg_313_0)
			local var_313_0 = 0
			local var_313_1 = 0.35

			if var_313_0 < arg_310_1.time_ and arg_310_1.time_ <= var_313_0 + arg_313_0 then
				arg_310_1.talkMaxDuration = 0
				arg_310_1.dialogCg_.alpha = 1

				arg_310_1.dialog_:SetActive(true)
				SetActive(arg_310_1.leftNameGo_, true)

				local var_313_2 = arg_310_1:FormatText(StoryNameCfg[674].name)

				arg_310_1.leftNameTxt_.text = var_313_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_310_1.leftNameTxt_.transform)

				arg_310_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_310_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_310_1:RecordName(arg_310_1.leftNameTxt_.text)
				SetActive(arg_310_1.iconTrs_.gameObject, true)
				arg_310_1.iconController_:SetSelectedState("hero")

				arg_310_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2022")

				arg_310_1.callingController_:SetSelectedState("normal")

				arg_310_1.keyicon_.color = Color.New(1, 1, 1)
				arg_310_1.icon_.color = Color.New(1, 1, 1)

				local var_313_3 = arg_310_1:GetWordFromCfg(411051073)
				local var_313_4 = arg_310_1:FormatText(var_313_3.content)

				arg_310_1.text_.text = var_313_4

				LuaForUtil.ClearLinePrefixSymbol(arg_310_1.text_)

				local var_313_5 = 14
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

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051073", "story_v_out_411051.awb") ~= 0 then
					local var_313_8 = manager.audio:GetVoiceLength("story_v_out_411051", "411051073", "story_v_out_411051.awb") / 1000

					if var_313_8 + var_313_0 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_8 + var_313_0
					end

					if var_313_3.prefab_name ~= "" and arg_310_1.actors_[var_313_3.prefab_name] ~= nil then
						local var_313_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_310_1.actors_[var_313_3.prefab_name].transform, "story_v_out_411051", "411051073", "story_v_out_411051.awb")

						arg_310_1:RecordAudio("411051073", var_313_9)
						arg_310_1:RecordAudio("411051073", var_313_9)
					else
						arg_310_1:AudioAction("play", "voice", "story_v_out_411051", "411051073", "story_v_out_411051.awb")
					end

					arg_310_1:RecordHistoryTalkVoice("story_v_out_411051", "411051073", "story_v_out_411051.awb")
				end

				arg_310_1:RecordContent(arg_310_1.text_.text)
			end

			local var_313_10 = math.max(var_313_1, arg_310_1.talkMaxDuration)

			if var_313_0 <= arg_310_1.time_ and arg_310_1.time_ < var_313_0 + var_313_10 then
				arg_310_1.typewritter.percent = (arg_310_1.time_ - var_313_0) / var_313_10

				arg_310_1.typewritter:SetDirty()
			end

			if arg_310_1.time_ >= var_313_0 + var_313_10 and arg_310_1.time_ < var_313_0 + var_313_10 + arg_313_0 then
				arg_310_1.typewritter.percent = 1

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(true)
			end
		end

		arg_310_1.nodeConfigList_ = {}

		arg_310_1:InitPlayNodeList()
	end,
	Play411051074 = function(arg_314_0, arg_314_1)
		arg_314_1.time_ = 0
		arg_314_1.frameCnt_ = 0
		arg_314_1.state_ = "playing"
		arg_314_1.curTalkId_ = 411051074
		arg_314_1.duration_ = 2.5

		local var_314_0 = {
			zh = 2.5,
			ja = 1.833
		}
		local var_314_1 = manager.audio:GetLocalizationFlag()

		if var_314_0[var_314_1] ~= nil then
			arg_314_1.duration_ = var_314_0[var_314_1]
		end

		SetActive(arg_314_1.tipsGo_, false)

		function arg_314_1.onSingleLineFinish_()
			arg_314_1.onSingleLineUpdate_ = nil
			arg_314_1.onSingleLineFinish_ = nil
			arg_314_1.state_ = "waiting"
		end

		function arg_314_1.playNext_(arg_316_0)
			if arg_316_0 == 1 then
				arg_314_0:Play411051075(arg_314_1)
			end
		end

		function arg_314_1.onSingleLineUpdate_(arg_317_0)
			local var_317_0 = 0
			local var_317_1 = 0.075

			if var_317_0 < arg_314_1.time_ and arg_314_1.time_ <= var_317_0 + arg_317_0 then
				arg_314_1.talkMaxDuration = 0
				arg_314_1.dialogCg_.alpha = 1

				arg_314_1.dialog_:SetActive(true)
				SetActive(arg_314_1.leftNameGo_, true)

				local var_317_2 = arg_314_1:FormatText(StoryNameCfg[675].name)

				arg_314_1.leftNameTxt_.text = var_317_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_314_1.leftNameTxt_.transform)

				arg_314_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_314_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_314_1:RecordName(arg_314_1.leftNameTxt_.text)
				SetActive(arg_314_1.iconTrs_.gameObject, true)
				arg_314_1.iconController_:SetSelectedState("hero")

				arg_314_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10002a")

				arg_314_1.callingController_:SetSelectedState("normal")

				arg_314_1.keyicon_.color = Color.New(1, 1, 1)
				arg_314_1.icon_.color = Color.New(1, 1, 1)

				local var_317_3 = arg_314_1:GetWordFromCfg(411051074)
				local var_317_4 = arg_314_1:FormatText(var_317_3.content)

				arg_314_1.text_.text = var_317_4

				LuaForUtil.ClearLinePrefixSymbol(arg_314_1.text_)

				local var_317_5 = 3
				local var_317_6 = utf8.len(var_317_4)
				local var_317_7 = var_317_5 <= 0 and var_317_1 or var_317_1 * (var_317_6 / var_317_5)

				if var_317_7 > 0 and var_317_1 < var_317_7 then
					arg_314_1.talkMaxDuration = var_317_7

					if var_317_7 + var_317_0 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_7 + var_317_0
					end
				end

				arg_314_1.text_.text = var_317_4
				arg_314_1.typewritter.percent = 0

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051074", "story_v_out_411051.awb") ~= 0 then
					local var_317_8 = manager.audio:GetVoiceLength("story_v_out_411051", "411051074", "story_v_out_411051.awb") / 1000

					if var_317_8 + var_317_0 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_8 + var_317_0
					end

					if var_317_3.prefab_name ~= "" and arg_314_1.actors_[var_317_3.prefab_name] ~= nil then
						local var_317_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_314_1.actors_[var_317_3.prefab_name].transform, "story_v_out_411051", "411051074", "story_v_out_411051.awb")

						arg_314_1:RecordAudio("411051074", var_317_9)
						arg_314_1:RecordAudio("411051074", var_317_9)
					else
						arg_314_1:AudioAction("play", "voice", "story_v_out_411051", "411051074", "story_v_out_411051.awb")
					end

					arg_314_1:RecordHistoryTalkVoice("story_v_out_411051", "411051074", "story_v_out_411051.awb")
				end

				arg_314_1:RecordContent(arg_314_1.text_.text)
			end

			local var_317_10 = math.max(var_317_1, arg_314_1.talkMaxDuration)

			if var_317_0 <= arg_314_1.time_ and arg_314_1.time_ < var_317_0 + var_317_10 then
				arg_314_1.typewritter.percent = (arg_314_1.time_ - var_317_0) / var_317_10

				arg_314_1.typewritter:SetDirty()
			end

			if arg_314_1.time_ >= var_317_0 + var_317_10 and arg_314_1.time_ < var_317_0 + var_317_10 + arg_317_0 then
				arg_314_1.typewritter.percent = 1

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(true)
			end
		end

		arg_314_1.nodeConfigList_ = {}

		arg_314_1:InitPlayNodeList()
	end,
	Play411051075 = function(arg_318_0, arg_318_1)
		arg_318_1.time_ = 0
		arg_318_1.frameCnt_ = 0
		arg_318_1.state_ = "playing"
		arg_318_1.curTalkId_ = 411051075
		arg_318_1.duration_ = 5

		SetActive(arg_318_1.tipsGo_, false)

		function arg_318_1.onSingleLineFinish_()
			arg_318_1.onSingleLineUpdate_ = nil
			arg_318_1.onSingleLineFinish_ = nil
			arg_318_1.state_ = "waiting"
		end

		function arg_318_1.playNext_(arg_320_0)
			if arg_320_0 == 1 then
				arg_318_0:Play411051076(arg_318_1)
			end
		end

		function arg_318_1.onSingleLineUpdate_(arg_321_0)
			local var_321_0 = 0
			local var_321_1 = 1.65

			if var_321_0 < arg_318_1.time_ and arg_318_1.time_ <= var_321_0 + arg_321_0 then
				arg_318_1.talkMaxDuration = 0
				arg_318_1.dialogCg_.alpha = 1

				arg_318_1.dialog_:SetActive(true)
				SetActive(arg_318_1.leftNameGo_, false)

				arg_318_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_318_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_318_1:RecordName(arg_318_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_318_1.iconTrs_.gameObject, false)
				arg_318_1.callingController_:SetSelectedState("normal")

				local var_321_2 = arg_318_1:GetWordFromCfg(411051075)
				local var_321_3 = arg_318_1:FormatText(var_321_2.content)

				arg_318_1.text_.text = var_321_3

				LuaForUtil.ClearLinePrefixSymbol(arg_318_1.text_)

				local var_321_4 = 66
				local var_321_5 = utf8.len(var_321_3)
				local var_321_6 = var_321_4 <= 0 and var_321_1 or var_321_1 * (var_321_5 / var_321_4)

				if var_321_6 > 0 and var_321_1 < var_321_6 then
					arg_318_1.talkMaxDuration = var_321_6

					if var_321_6 + var_321_0 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_6 + var_321_0
					end
				end

				arg_318_1.text_.text = var_321_3
				arg_318_1.typewritter.percent = 0

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(false)
				arg_318_1:RecordContent(arg_318_1.text_.text)
			end

			local var_321_7 = math.max(var_321_1, arg_318_1.talkMaxDuration)

			if var_321_0 <= arg_318_1.time_ and arg_318_1.time_ < var_321_0 + var_321_7 then
				arg_318_1.typewritter.percent = (arg_318_1.time_ - var_321_0) / var_321_7

				arg_318_1.typewritter:SetDirty()
			end

			if arg_318_1.time_ >= var_321_0 + var_321_7 and arg_318_1.time_ < var_321_0 + var_321_7 + arg_321_0 then
				arg_318_1.typewritter.percent = 1

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(true)
			end
		end

		arg_318_1.nodeConfigList_ = {}

		arg_318_1:InitPlayNodeList()
	end,
	Play411051076 = function(arg_322_0, arg_322_1)
		arg_322_1.time_ = 0
		arg_322_1.frameCnt_ = 0
		arg_322_1.state_ = "playing"
		arg_322_1.curTalkId_ = 411051076
		arg_322_1.duration_ = 5

		SetActive(arg_322_1.tipsGo_, false)

		function arg_322_1.onSingleLineFinish_()
			arg_322_1.onSingleLineUpdate_ = nil
			arg_322_1.onSingleLineFinish_ = nil
			arg_322_1.state_ = "waiting"
		end

		function arg_322_1.playNext_(arg_324_0)
			if arg_324_0 == 1 then
				arg_322_0:Play411051077(arg_322_1)
			end
		end

		function arg_322_1.onSingleLineUpdate_(arg_325_0)
			local var_325_0 = 0
			local var_325_1 = 1.175

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

				local var_325_2 = arg_322_1:GetWordFromCfg(411051076)
				local var_325_3 = arg_322_1:FormatText(var_325_2.content)

				arg_322_1.text_.text = var_325_3

				LuaForUtil.ClearLinePrefixSymbol(arg_322_1.text_)

				local var_325_4 = 47
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
	Play411051077 = function(arg_326_0, arg_326_1)
		arg_326_1.time_ = 0
		arg_326_1.frameCnt_ = 0
		arg_326_1.state_ = "playing"
		arg_326_1.curTalkId_ = 411051077
		arg_326_1.duration_ = 11

		local var_326_0 = {
			zh = 10.733,
			ja = 11
		}
		local var_326_1 = manager.audio:GetLocalizationFlag()

		if var_326_0[var_326_1] ~= nil then
			arg_326_1.duration_ = var_326_0[var_326_1]
		end

		SetActive(arg_326_1.tipsGo_, false)

		function arg_326_1.onSingleLineFinish_()
			arg_326_1.onSingleLineUpdate_ = nil
			arg_326_1.onSingleLineFinish_ = nil
			arg_326_1.state_ = "waiting"
		end

		function arg_326_1.playNext_(arg_328_0)
			if arg_328_0 == 1 then
				arg_326_0:Play411051078(arg_326_1)
			end
		end

		function arg_326_1.onSingleLineUpdate_(arg_329_0)
			local var_329_0 = 0
			local var_329_1 = 0.925

			if var_329_0 < arg_326_1.time_ and arg_326_1.time_ <= var_329_0 + arg_329_0 then
				arg_326_1.talkMaxDuration = 0
				arg_326_1.dialogCg_.alpha = 1

				arg_326_1.dialog_:SetActive(true)
				SetActive(arg_326_1.leftNameGo_, true)

				local var_329_2 = arg_326_1:FormatText(StoryNameCfg[675].name)

				arg_326_1.leftNameTxt_.text = var_329_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_326_1.leftNameTxt_.transform)

				arg_326_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_326_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_326_1:RecordName(arg_326_1.leftNameTxt_.text)
				SetActive(arg_326_1.iconTrs_.gameObject, true)
				arg_326_1.iconController_:SetSelectedState("hero")

				arg_326_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10002a")

				arg_326_1.callingController_:SetSelectedState("normal")

				arg_326_1.keyicon_.color = Color.New(1, 1, 1)
				arg_326_1.icon_.color = Color.New(1, 1, 1)

				local var_329_3 = arg_326_1:GetWordFromCfg(411051077)
				local var_329_4 = arg_326_1:FormatText(var_329_3.content)

				arg_326_1.text_.text = var_329_4

				LuaForUtil.ClearLinePrefixSymbol(arg_326_1.text_)

				local var_329_5 = 37
				local var_329_6 = utf8.len(var_329_4)
				local var_329_7 = var_329_5 <= 0 and var_329_1 or var_329_1 * (var_329_6 / var_329_5)

				if var_329_7 > 0 and var_329_1 < var_329_7 then
					arg_326_1.talkMaxDuration = var_329_7

					if var_329_7 + var_329_0 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_7 + var_329_0
					end
				end

				arg_326_1.text_.text = var_329_4
				arg_326_1.typewritter.percent = 0

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051077", "story_v_out_411051.awb") ~= 0 then
					local var_329_8 = manager.audio:GetVoiceLength("story_v_out_411051", "411051077", "story_v_out_411051.awb") / 1000

					if var_329_8 + var_329_0 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_8 + var_329_0
					end

					if var_329_3.prefab_name ~= "" and arg_326_1.actors_[var_329_3.prefab_name] ~= nil then
						local var_329_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_326_1.actors_[var_329_3.prefab_name].transform, "story_v_out_411051", "411051077", "story_v_out_411051.awb")

						arg_326_1:RecordAudio("411051077", var_329_9)
						arg_326_1:RecordAudio("411051077", var_329_9)
					else
						arg_326_1:AudioAction("play", "voice", "story_v_out_411051", "411051077", "story_v_out_411051.awb")
					end

					arg_326_1:RecordHistoryTalkVoice("story_v_out_411051", "411051077", "story_v_out_411051.awb")
				end

				arg_326_1:RecordContent(arg_326_1.text_.text)
			end

			local var_329_10 = math.max(var_329_1, arg_326_1.talkMaxDuration)

			if var_329_0 <= arg_326_1.time_ and arg_326_1.time_ < var_329_0 + var_329_10 then
				arg_326_1.typewritter.percent = (arg_326_1.time_ - var_329_0) / var_329_10

				arg_326_1.typewritter:SetDirty()
			end

			if arg_326_1.time_ >= var_329_0 + var_329_10 and arg_326_1.time_ < var_329_0 + var_329_10 + arg_329_0 then
				arg_326_1.typewritter.percent = 1

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(true)
			end
		end

		arg_326_1.nodeConfigList_ = {}

		arg_326_1:InitPlayNodeList()
	end,
	Play411051078 = function(arg_330_0, arg_330_1)
		arg_330_1.time_ = 0
		arg_330_1.frameCnt_ = 0
		arg_330_1.state_ = "playing"
		arg_330_1.curTalkId_ = 411051078
		arg_330_1.duration_ = 5

		SetActive(arg_330_1.tipsGo_, false)

		function arg_330_1.onSingleLineFinish_()
			arg_330_1.onSingleLineUpdate_ = nil
			arg_330_1.onSingleLineFinish_ = nil
			arg_330_1.state_ = "waiting"
		end

		function arg_330_1.playNext_(arg_332_0)
			if arg_332_0 == 1 then
				arg_330_0:Play411051079(arg_330_1)
			end
		end

		function arg_330_1.onSingleLineUpdate_(arg_333_0)
			local var_333_0 = 0
			local var_333_1 = 0.975

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

				local var_333_2 = arg_330_1:GetWordFromCfg(411051078)
				local var_333_3 = arg_330_1:FormatText(var_333_2.content)

				arg_330_1.text_.text = var_333_3

				LuaForUtil.ClearLinePrefixSymbol(arg_330_1.text_)

				local var_333_4 = 39
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
	Play411051079 = function(arg_334_0, arg_334_1)
		arg_334_1.time_ = 0
		arg_334_1.frameCnt_ = 0
		arg_334_1.state_ = "playing"
		arg_334_1.curTalkId_ = 411051079
		arg_334_1.duration_ = 5.27

		local var_334_0 = {
			zh = 3.666,
			ja = 5.266
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
				arg_334_0:Play411051080(arg_334_1)
			end
		end

		function arg_334_1.onSingleLineUpdate_(arg_337_0)
			local var_337_0 = "1095ui_story"

			if arg_334_1.actors_[var_337_0] == nil then
				local var_337_1 = Asset.Load("Char/" .. "1095ui_story")

				if not isNil(var_337_1) then
					local var_337_2 = Object.Instantiate(Asset.Load("Char/" .. "1095ui_story"), arg_334_1.stage_.transform)

					var_337_2.name = var_337_0
					var_337_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_334_1.actors_[var_337_0] = var_337_2

					local var_337_3 = var_337_2:GetComponentInChildren(typeof(CharacterEffect))

					var_337_3.enabled = true

					local var_337_4 = GameObjectTools.GetOrAddComponent(var_337_2, typeof(DynamicBoneHelper))

					if var_337_4 then
						var_337_4:EnableDynamicBone(false)
					end

					arg_334_1:ShowWeapon(var_337_3.transform, false)

					arg_334_1.var_[var_337_0 .. "Animator"] = var_337_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_334_1.var_[var_337_0 .. "Animator"].applyRootMotion = true
					arg_334_1.var_[var_337_0 .. "LipSync"] = var_337_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_337_5 = arg_334_1.actors_["1095ui_story"].transform
			local var_337_6 = 0

			if var_337_6 < arg_334_1.time_ and arg_334_1.time_ <= var_337_6 + arg_337_0 then
				arg_334_1.var_.moveOldPos1095ui_story = var_337_5.localPosition
			end

			local var_337_7 = 0.001

			if var_337_6 <= arg_334_1.time_ and arg_334_1.time_ < var_337_6 + var_337_7 then
				local var_337_8 = (arg_334_1.time_ - var_337_6) / var_337_7
				local var_337_9 = Vector3.New(0, -0.98, -6.1)

				var_337_5.localPosition = Vector3.Lerp(arg_334_1.var_.moveOldPos1095ui_story, var_337_9, var_337_8)

				local var_337_10 = manager.ui.mainCamera.transform.position - var_337_5.position

				var_337_5.forward = Vector3.New(var_337_10.x, var_337_10.y, var_337_10.z)

				local var_337_11 = var_337_5.localEulerAngles

				var_337_11.z = 0
				var_337_11.x = 0
				var_337_5.localEulerAngles = var_337_11
			end

			if arg_334_1.time_ >= var_337_6 + var_337_7 and arg_334_1.time_ < var_337_6 + var_337_7 + arg_337_0 then
				var_337_5.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_337_12 = manager.ui.mainCamera.transform.position - var_337_5.position

				var_337_5.forward = Vector3.New(var_337_12.x, var_337_12.y, var_337_12.z)

				local var_337_13 = var_337_5.localEulerAngles

				var_337_13.z = 0
				var_337_13.x = 0
				var_337_5.localEulerAngles = var_337_13
			end

			local var_337_14 = arg_334_1.actors_["1095ui_story"]
			local var_337_15 = 0

			if var_337_15 < arg_334_1.time_ and arg_334_1.time_ <= var_337_15 + arg_337_0 and not isNil(var_337_14) and arg_334_1.var_.characterEffect1095ui_story == nil then
				arg_334_1.var_.characterEffect1095ui_story = var_337_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_337_16 = 0.200000002980232

			if var_337_15 <= arg_334_1.time_ and arg_334_1.time_ < var_337_15 + var_337_16 and not isNil(var_337_14) then
				local var_337_17 = (arg_334_1.time_ - var_337_15) / var_337_16

				if arg_334_1.var_.characterEffect1095ui_story and not isNil(var_337_14) then
					arg_334_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_334_1.time_ >= var_337_15 + var_337_16 and arg_334_1.time_ < var_337_15 + var_337_16 + arg_337_0 and not isNil(var_337_14) and arg_334_1.var_.characterEffect1095ui_story then
				arg_334_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_337_18 = 0

			if var_337_18 < arg_334_1.time_ and arg_334_1.time_ <= var_337_18 + arg_337_0 then
				arg_334_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_337_19 = 0

			if var_337_19 < arg_334_1.time_ and arg_334_1.time_ <= var_337_19 + arg_337_0 then
				arg_334_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_337_20 = 0
			local var_337_21 = 0.375

			if var_337_20 < arg_334_1.time_ and arg_334_1.time_ <= var_337_20 + arg_337_0 then
				arg_334_1.talkMaxDuration = 0
				arg_334_1.dialogCg_.alpha = 1

				arg_334_1.dialog_:SetActive(true)
				SetActive(arg_334_1.leftNameGo_, true)

				local var_337_22 = arg_334_1:FormatText(StoryNameCfg[471].name)

				arg_334_1.leftNameTxt_.text = var_337_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_334_1.leftNameTxt_.transform)

				arg_334_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_334_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_334_1:RecordName(arg_334_1.leftNameTxt_.text)
				SetActive(arg_334_1.iconTrs_.gameObject, false)
				arg_334_1.callingController_:SetSelectedState("normal")

				local var_337_23 = arg_334_1:GetWordFromCfg(411051079)
				local var_337_24 = arg_334_1:FormatText(var_337_23.content)

				arg_334_1.text_.text = var_337_24

				LuaForUtil.ClearLinePrefixSymbol(arg_334_1.text_)

				local var_337_25 = 15
				local var_337_26 = utf8.len(var_337_24)
				local var_337_27 = var_337_25 <= 0 and var_337_21 or var_337_21 * (var_337_26 / var_337_25)

				if var_337_27 > 0 and var_337_21 < var_337_27 then
					arg_334_1.talkMaxDuration = var_337_27

					if var_337_27 + var_337_20 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_27 + var_337_20
					end
				end

				arg_334_1.text_.text = var_337_24
				arg_334_1.typewritter.percent = 0

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051079", "story_v_out_411051.awb") ~= 0 then
					local var_337_28 = manager.audio:GetVoiceLength("story_v_out_411051", "411051079", "story_v_out_411051.awb") / 1000

					if var_337_28 + var_337_20 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_28 + var_337_20
					end

					if var_337_23.prefab_name ~= "" and arg_334_1.actors_[var_337_23.prefab_name] ~= nil then
						local var_337_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_334_1.actors_[var_337_23.prefab_name].transform, "story_v_out_411051", "411051079", "story_v_out_411051.awb")

						arg_334_1:RecordAudio("411051079", var_337_29)
						arg_334_1:RecordAudio("411051079", var_337_29)
					else
						arg_334_1:AudioAction("play", "voice", "story_v_out_411051", "411051079", "story_v_out_411051.awb")
					end

					arg_334_1:RecordHistoryTalkVoice("story_v_out_411051", "411051079", "story_v_out_411051.awb")
				end

				arg_334_1:RecordContent(arg_334_1.text_.text)
			end

			local var_337_30 = math.max(var_337_21, arg_334_1.talkMaxDuration)

			if var_337_20 <= arg_334_1.time_ and arg_334_1.time_ < var_337_20 + var_337_30 then
				arg_334_1.typewritter.percent = (arg_334_1.time_ - var_337_20) / var_337_30

				arg_334_1.typewritter:SetDirty()
			end

			if arg_334_1.time_ >= var_337_20 + var_337_30 and arg_334_1.time_ < var_337_20 + var_337_30 + arg_337_0 then
				arg_334_1.typewritter.percent = 1

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(true)
			end
		end

		arg_334_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
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
	Play411051080 = function(arg_338_0, arg_338_1)
		arg_338_1.time_ = 0
		arg_338_1.frameCnt_ = 0
		arg_338_1.state_ = "playing"
		arg_338_1.curTalkId_ = 411051080
		arg_338_1.duration_ = 3.33

		local var_338_0 = {
			zh = 3.333,
			ja = 1.6
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
				arg_338_0:Play411051081(arg_338_1)
			end
		end

		function arg_338_1.onSingleLineUpdate_(arg_341_0)
			local var_341_0 = arg_338_1.actors_["1095ui_story"]
			local var_341_1 = 0

			if var_341_1 < arg_338_1.time_ and arg_338_1.time_ <= var_341_1 + arg_341_0 and not isNil(var_341_0) and arg_338_1.var_.characterEffect1095ui_story == nil then
				arg_338_1.var_.characterEffect1095ui_story = var_341_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_341_2 = 0.200000002980232

			if var_341_1 <= arg_338_1.time_ and arg_338_1.time_ < var_341_1 + var_341_2 and not isNil(var_341_0) then
				local var_341_3 = (arg_338_1.time_ - var_341_1) / var_341_2

				if arg_338_1.var_.characterEffect1095ui_story and not isNil(var_341_0) then
					local var_341_4 = Mathf.Lerp(0, 0.5, var_341_3)

					arg_338_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_338_1.var_.characterEffect1095ui_story.fillRatio = var_341_4
				end
			end

			if arg_338_1.time_ >= var_341_1 + var_341_2 and arg_338_1.time_ < var_341_1 + var_341_2 + arg_341_0 and not isNil(var_341_0) and arg_338_1.var_.characterEffect1095ui_story then
				local var_341_5 = 0.5

				arg_338_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_338_1.var_.characterEffect1095ui_story.fillRatio = var_341_5
			end

			local var_341_6 = 0
			local var_341_7 = 0.225

			if var_341_6 < arg_338_1.time_ and arg_338_1.time_ <= var_341_6 + arg_341_0 then
				arg_338_1.talkMaxDuration = 0
				arg_338_1.dialogCg_.alpha = 1

				arg_338_1.dialog_:SetActive(true)
				SetActive(arg_338_1.leftNameGo_, true)

				local var_341_8 = arg_338_1:FormatText(StoryNameCfg[39].name)

				arg_338_1.leftNameTxt_.text = var_341_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_338_1.leftNameTxt_.transform)

				arg_338_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_338_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_338_1:RecordName(arg_338_1.leftNameTxt_.text)
				SetActive(arg_338_1.iconTrs_.gameObject, true)
				arg_338_1.iconController_:SetSelectedState("hero")

				arg_338_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10002a")

				arg_338_1.callingController_:SetSelectedState("normal")

				arg_338_1.keyicon_.color = Color.New(1, 1, 1)
				arg_338_1.icon_.color = Color.New(1, 1, 1)

				local var_341_9 = arg_338_1:GetWordFromCfg(411051080)
				local var_341_10 = arg_338_1:FormatText(var_341_9.content)

				arg_338_1.text_.text = var_341_10

				LuaForUtil.ClearLinePrefixSymbol(arg_338_1.text_)

				local var_341_11 = 9
				local var_341_12 = utf8.len(var_341_10)
				local var_341_13 = var_341_11 <= 0 and var_341_7 or var_341_7 * (var_341_12 / var_341_11)

				if var_341_13 > 0 and var_341_7 < var_341_13 then
					arg_338_1.talkMaxDuration = var_341_13

					if var_341_13 + var_341_6 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_13 + var_341_6
					end
				end

				arg_338_1.text_.text = var_341_10
				arg_338_1.typewritter.percent = 0

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051080", "story_v_out_411051.awb") ~= 0 then
					local var_341_14 = manager.audio:GetVoiceLength("story_v_out_411051", "411051080", "story_v_out_411051.awb") / 1000

					if var_341_14 + var_341_6 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_14 + var_341_6
					end

					if var_341_9.prefab_name ~= "" and arg_338_1.actors_[var_341_9.prefab_name] ~= nil then
						local var_341_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_338_1.actors_[var_341_9.prefab_name].transform, "story_v_out_411051", "411051080", "story_v_out_411051.awb")

						arg_338_1:RecordAudio("411051080", var_341_15)
						arg_338_1:RecordAudio("411051080", var_341_15)
					else
						arg_338_1:AudioAction("play", "voice", "story_v_out_411051", "411051080", "story_v_out_411051.awb")
					end

					arg_338_1:RecordHistoryTalkVoice("story_v_out_411051", "411051080", "story_v_out_411051.awb")
				end

				arg_338_1:RecordContent(arg_338_1.text_.text)
			end

			local var_341_16 = math.max(var_341_7, arg_338_1.talkMaxDuration)

			if var_341_6 <= arg_338_1.time_ and arg_338_1.time_ < var_341_6 + var_341_16 then
				arg_338_1.typewritter.percent = (arg_338_1.time_ - var_341_6) / var_341_16

				arg_338_1.typewritter:SetDirty()
			end

			if arg_338_1.time_ >= var_341_6 + var_341_16 and arg_338_1.time_ < var_341_6 + var_341_16 + arg_341_0 then
				arg_338_1.typewritter.percent = 1

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(true)
			end
		end

		arg_338_1.nodeConfigList_ = {}

		arg_338_1:InitPlayNodeList()
	end,
	Play411051081 = function(arg_342_0, arg_342_1)
		arg_342_1.time_ = 0
		arg_342_1.frameCnt_ = 0
		arg_342_1.state_ = "playing"
		arg_342_1.curTalkId_ = 411051081
		arg_342_1.duration_ = 4

		local var_342_0 = {
			zh = 3.366,
			ja = 4
		}
		local var_342_1 = manager.audio:GetLocalizationFlag()

		if var_342_0[var_342_1] ~= nil then
			arg_342_1.duration_ = var_342_0[var_342_1]
		end

		SetActive(arg_342_1.tipsGo_, false)

		function arg_342_1.onSingleLineFinish_()
			arg_342_1.onSingleLineUpdate_ = nil
			arg_342_1.onSingleLineFinish_ = nil
			arg_342_1.state_ = "waiting"
		end

		function arg_342_1.playNext_(arg_344_0)
			if arg_344_0 == 1 then
				arg_342_0:Play411051082(arg_342_1)
			end
		end

		function arg_342_1.onSingleLineUpdate_(arg_345_0)
			local var_345_0 = arg_342_1.actors_["1095ui_story"]
			local var_345_1 = 0

			if var_345_1 < arg_342_1.time_ and arg_342_1.time_ <= var_345_1 + arg_345_0 and not isNil(var_345_0) and arg_342_1.var_.characterEffect1095ui_story == nil then
				arg_342_1.var_.characterEffect1095ui_story = var_345_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_345_2 = 0.200000002980232

			if var_345_1 <= arg_342_1.time_ and arg_342_1.time_ < var_345_1 + var_345_2 and not isNil(var_345_0) then
				local var_345_3 = (arg_342_1.time_ - var_345_1) / var_345_2

				if arg_342_1.var_.characterEffect1095ui_story and not isNil(var_345_0) then
					arg_342_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_342_1.time_ >= var_345_1 + var_345_2 and arg_342_1.time_ < var_345_1 + var_345_2 + arg_345_0 and not isNil(var_345_0) and arg_342_1.var_.characterEffect1095ui_story then
				arg_342_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_345_4 = 0
			local var_345_5 = 0.4

			if var_345_4 < arg_342_1.time_ and arg_342_1.time_ <= var_345_4 + arg_345_0 then
				arg_342_1.talkMaxDuration = 0
				arg_342_1.dialogCg_.alpha = 1

				arg_342_1.dialog_:SetActive(true)
				SetActive(arg_342_1.leftNameGo_, true)

				local var_345_6 = arg_342_1:FormatText(StoryNameCfg[471].name)

				arg_342_1.leftNameTxt_.text = var_345_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_342_1.leftNameTxt_.transform)

				arg_342_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_342_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_342_1:RecordName(arg_342_1.leftNameTxt_.text)
				SetActive(arg_342_1.iconTrs_.gameObject, false)
				arg_342_1.callingController_:SetSelectedState("normal")

				local var_345_7 = arg_342_1:GetWordFromCfg(411051081)
				local var_345_8 = arg_342_1:FormatText(var_345_7.content)

				arg_342_1.text_.text = var_345_8

				LuaForUtil.ClearLinePrefixSymbol(arg_342_1.text_)

				local var_345_9 = 16
				local var_345_10 = utf8.len(var_345_8)
				local var_345_11 = var_345_9 <= 0 and var_345_5 or var_345_5 * (var_345_10 / var_345_9)

				if var_345_11 > 0 and var_345_5 < var_345_11 then
					arg_342_1.talkMaxDuration = var_345_11

					if var_345_11 + var_345_4 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_11 + var_345_4
					end
				end

				arg_342_1.text_.text = var_345_8
				arg_342_1.typewritter.percent = 0

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051081", "story_v_out_411051.awb") ~= 0 then
					local var_345_12 = manager.audio:GetVoiceLength("story_v_out_411051", "411051081", "story_v_out_411051.awb") / 1000

					if var_345_12 + var_345_4 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_12 + var_345_4
					end

					if var_345_7.prefab_name ~= "" and arg_342_1.actors_[var_345_7.prefab_name] ~= nil then
						local var_345_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_342_1.actors_[var_345_7.prefab_name].transform, "story_v_out_411051", "411051081", "story_v_out_411051.awb")

						arg_342_1:RecordAudio("411051081", var_345_13)
						arg_342_1:RecordAudio("411051081", var_345_13)
					else
						arg_342_1:AudioAction("play", "voice", "story_v_out_411051", "411051081", "story_v_out_411051.awb")
					end

					arg_342_1:RecordHistoryTalkVoice("story_v_out_411051", "411051081", "story_v_out_411051.awb")
				end

				arg_342_1:RecordContent(arg_342_1.text_.text)
			end

			local var_345_14 = math.max(var_345_5, arg_342_1.talkMaxDuration)

			if var_345_4 <= arg_342_1.time_ and arg_342_1.time_ < var_345_4 + var_345_14 then
				arg_342_1.typewritter.percent = (arg_342_1.time_ - var_345_4) / var_345_14

				arg_342_1.typewritter:SetDirty()
			end

			if arg_342_1.time_ >= var_345_4 + var_345_14 and arg_342_1.time_ < var_345_4 + var_345_14 + arg_345_0 then
				arg_342_1.typewritter.percent = 1

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(true)
			end
		end

		arg_342_1.nodeConfigList_ = {}

		arg_342_1:InitPlayNodeList()
	end,
	Play411051082 = function(arg_346_0, arg_346_1)
		arg_346_1.time_ = 0
		arg_346_1.frameCnt_ = 0
		arg_346_1.state_ = "playing"
		arg_346_1.curTalkId_ = 411051082
		arg_346_1.duration_ = 5

		SetActive(arg_346_1.tipsGo_, false)

		function arg_346_1.onSingleLineFinish_()
			arg_346_1.onSingleLineUpdate_ = nil
			arg_346_1.onSingleLineFinish_ = nil
			arg_346_1.state_ = "waiting"
		end

		function arg_346_1.playNext_(arg_348_0)
			if arg_348_0 == 1 then
				arg_346_0:Play411051083(arg_346_1)
			end
		end

		function arg_346_1.onSingleLineUpdate_(arg_349_0)
			local var_349_0 = arg_346_1.actors_["1095ui_story"]
			local var_349_1 = 0

			if var_349_1 < arg_346_1.time_ and arg_346_1.time_ <= var_349_1 + arg_349_0 and not isNil(var_349_0) and arg_346_1.var_.characterEffect1095ui_story == nil then
				arg_346_1.var_.characterEffect1095ui_story = var_349_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_349_2 = 0.200000002980232

			if var_349_1 <= arg_346_1.time_ and arg_346_1.time_ < var_349_1 + var_349_2 and not isNil(var_349_0) then
				local var_349_3 = (arg_346_1.time_ - var_349_1) / var_349_2

				if arg_346_1.var_.characterEffect1095ui_story and not isNil(var_349_0) then
					local var_349_4 = Mathf.Lerp(0, 0.5, var_349_3)

					arg_346_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_346_1.var_.characterEffect1095ui_story.fillRatio = var_349_4
				end
			end

			if arg_346_1.time_ >= var_349_1 + var_349_2 and arg_346_1.time_ < var_349_1 + var_349_2 + arg_349_0 and not isNil(var_349_0) and arg_346_1.var_.characterEffect1095ui_story then
				local var_349_5 = 0.5

				arg_346_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_346_1.var_.characterEffect1095ui_story.fillRatio = var_349_5
			end

			local var_349_6 = 0
			local var_349_7 = 1.175

			if var_349_6 < arg_346_1.time_ and arg_346_1.time_ <= var_349_6 + arg_349_0 then
				arg_346_1.talkMaxDuration = 0
				arg_346_1.dialogCg_.alpha = 1

				arg_346_1.dialog_:SetActive(true)
				SetActive(arg_346_1.leftNameGo_, false)

				arg_346_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_346_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_346_1:RecordName(arg_346_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_346_1.iconTrs_.gameObject, false)
				arg_346_1.callingController_:SetSelectedState("normal")

				local var_349_8 = arg_346_1:GetWordFromCfg(411051082)
				local var_349_9 = arg_346_1:FormatText(var_349_8.content)

				arg_346_1.text_.text = var_349_9

				LuaForUtil.ClearLinePrefixSymbol(arg_346_1.text_)

				local var_349_10 = 47
				local var_349_11 = utf8.len(var_349_9)
				local var_349_12 = var_349_10 <= 0 and var_349_7 or var_349_7 * (var_349_11 / var_349_10)

				if var_349_12 > 0 and var_349_7 < var_349_12 then
					arg_346_1.talkMaxDuration = var_349_12

					if var_349_12 + var_349_6 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_12 + var_349_6
					end
				end

				arg_346_1.text_.text = var_349_9
				arg_346_1.typewritter.percent = 0

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(false)
				arg_346_1:RecordContent(arg_346_1.text_.text)
			end

			local var_349_13 = math.max(var_349_7, arg_346_1.talkMaxDuration)

			if var_349_6 <= arg_346_1.time_ and arg_346_1.time_ < var_349_6 + var_349_13 then
				arg_346_1.typewritter.percent = (arg_346_1.time_ - var_349_6) / var_349_13

				arg_346_1.typewritter:SetDirty()
			end

			if arg_346_1.time_ >= var_349_6 + var_349_13 and arg_346_1.time_ < var_349_6 + var_349_13 + arg_349_0 then
				arg_346_1.typewritter.percent = 1

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(true)
			end
		end

		arg_346_1.nodeConfigList_ = {}

		arg_346_1:InitPlayNodeList()
	end,
	Play411051083 = function(arg_350_0, arg_350_1)
		arg_350_1.time_ = 0
		arg_350_1.frameCnt_ = 0
		arg_350_1.state_ = "playing"
		arg_350_1.curTalkId_ = 411051083
		arg_350_1.duration_ = 2.17

		local var_350_0 = {
			zh = 1.3,
			ja = 2.166
		}
		local var_350_1 = manager.audio:GetLocalizationFlag()

		if var_350_0[var_350_1] ~= nil then
			arg_350_1.duration_ = var_350_0[var_350_1]
		end

		SetActive(arg_350_1.tipsGo_, false)

		function arg_350_1.onSingleLineFinish_()
			arg_350_1.onSingleLineUpdate_ = nil
			arg_350_1.onSingleLineFinish_ = nil
			arg_350_1.state_ = "waiting"
		end

		function arg_350_1.playNext_(arg_352_0)
			if arg_352_0 == 1 then
				arg_350_0:Play411051084(arg_350_1)
			end
		end

		function arg_350_1.onSingleLineUpdate_(arg_353_0)
			local var_353_0 = arg_350_1.actors_["1095ui_story"]
			local var_353_1 = 0

			if var_353_1 < arg_350_1.time_ and arg_350_1.time_ <= var_353_1 + arg_353_0 and not isNil(var_353_0) and arg_350_1.var_.characterEffect1095ui_story == nil then
				arg_350_1.var_.characterEffect1095ui_story = var_353_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_353_2 = 0.200000002980232

			if var_353_1 <= arg_350_1.time_ and arg_350_1.time_ < var_353_1 + var_353_2 and not isNil(var_353_0) then
				local var_353_3 = (arg_350_1.time_ - var_353_1) / var_353_2

				if arg_350_1.var_.characterEffect1095ui_story and not isNil(var_353_0) then
					arg_350_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_350_1.time_ >= var_353_1 + var_353_2 and arg_350_1.time_ < var_353_1 + var_353_2 + arg_353_0 and not isNil(var_353_0) and arg_350_1.var_.characterEffect1095ui_story then
				arg_350_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_353_4 = 0
			local var_353_5 = 0.125

			if var_353_4 < arg_350_1.time_ and arg_350_1.time_ <= var_353_4 + arg_353_0 then
				arg_350_1.talkMaxDuration = 0
				arg_350_1.dialogCg_.alpha = 1

				arg_350_1.dialog_:SetActive(true)
				SetActive(arg_350_1.leftNameGo_, true)

				local var_353_6 = arg_350_1:FormatText(StoryNameCfg[471].name)

				arg_350_1.leftNameTxt_.text = var_353_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_350_1.leftNameTxt_.transform)

				arg_350_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_350_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_350_1:RecordName(arg_350_1.leftNameTxt_.text)
				SetActive(arg_350_1.iconTrs_.gameObject, false)
				arg_350_1.callingController_:SetSelectedState("normal")

				local var_353_7 = arg_350_1:GetWordFromCfg(411051083)
				local var_353_8 = arg_350_1:FormatText(var_353_7.content)

				arg_350_1.text_.text = var_353_8

				LuaForUtil.ClearLinePrefixSymbol(arg_350_1.text_)

				local var_353_9 = 5
				local var_353_10 = utf8.len(var_353_8)
				local var_353_11 = var_353_9 <= 0 and var_353_5 or var_353_5 * (var_353_10 / var_353_9)

				if var_353_11 > 0 and var_353_5 < var_353_11 then
					arg_350_1.talkMaxDuration = var_353_11

					if var_353_11 + var_353_4 > arg_350_1.duration_ then
						arg_350_1.duration_ = var_353_11 + var_353_4
					end
				end

				arg_350_1.text_.text = var_353_8
				arg_350_1.typewritter.percent = 0

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051083", "story_v_out_411051.awb") ~= 0 then
					local var_353_12 = manager.audio:GetVoiceLength("story_v_out_411051", "411051083", "story_v_out_411051.awb") / 1000

					if var_353_12 + var_353_4 > arg_350_1.duration_ then
						arg_350_1.duration_ = var_353_12 + var_353_4
					end

					if var_353_7.prefab_name ~= "" and arg_350_1.actors_[var_353_7.prefab_name] ~= nil then
						local var_353_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_350_1.actors_[var_353_7.prefab_name].transform, "story_v_out_411051", "411051083", "story_v_out_411051.awb")

						arg_350_1:RecordAudio("411051083", var_353_13)
						arg_350_1:RecordAudio("411051083", var_353_13)
					else
						arg_350_1:AudioAction("play", "voice", "story_v_out_411051", "411051083", "story_v_out_411051.awb")
					end

					arg_350_1:RecordHistoryTalkVoice("story_v_out_411051", "411051083", "story_v_out_411051.awb")
				end

				arg_350_1:RecordContent(arg_350_1.text_.text)
			end

			local var_353_14 = math.max(var_353_5, arg_350_1.talkMaxDuration)

			if var_353_4 <= arg_350_1.time_ and arg_350_1.time_ < var_353_4 + var_353_14 then
				arg_350_1.typewritter.percent = (arg_350_1.time_ - var_353_4) / var_353_14

				arg_350_1.typewritter:SetDirty()
			end

			if arg_350_1.time_ >= var_353_4 + var_353_14 and arg_350_1.time_ < var_353_4 + var_353_14 + arg_353_0 then
				arg_350_1.typewritter.percent = 1

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(true)
			end
		end

		arg_350_1.nodeConfigList_ = {}

		arg_350_1:InitPlayNodeList()
	end,
	Play411051084 = function(arg_354_0, arg_354_1)
		arg_354_1.time_ = 0
		arg_354_1.frameCnt_ = 0
		arg_354_1.state_ = "playing"
		arg_354_1.curTalkId_ = 411051084
		arg_354_1.duration_ = 6.57

		local var_354_0 = {
			zh = 5.166,
			ja = 6.566
		}
		local var_354_1 = manager.audio:GetLocalizationFlag()

		if var_354_0[var_354_1] ~= nil then
			arg_354_1.duration_ = var_354_0[var_354_1]
		end

		SetActive(arg_354_1.tipsGo_, false)

		function arg_354_1.onSingleLineFinish_()
			arg_354_1.onSingleLineUpdate_ = nil
			arg_354_1.onSingleLineFinish_ = nil
			arg_354_1.state_ = "waiting"
		end

		function arg_354_1.playNext_(arg_356_0)
			if arg_356_0 == 1 then
				arg_354_0:Play411051085(arg_354_1)
			end
		end

		function arg_354_1.onSingleLineUpdate_(arg_357_0)
			local var_357_0 = 0
			local var_357_1 = 0.625

			if var_357_0 < arg_354_1.time_ and arg_354_1.time_ <= var_357_0 + arg_357_0 then
				arg_354_1.talkMaxDuration = 0
				arg_354_1.dialogCg_.alpha = 1

				arg_354_1.dialog_:SetActive(true)
				SetActive(arg_354_1.leftNameGo_, true)

				local var_357_2 = arg_354_1:FormatText(StoryNameCfg[39].name)

				arg_354_1.leftNameTxt_.text = var_357_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_354_1.leftNameTxt_.transform)

				arg_354_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_354_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_354_1:RecordName(arg_354_1.leftNameTxt_.text)
				SetActive(arg_354_1.iconTrs_.gameObject, true)
				arg_354_1.iconController_:SetSelectedState("hero")

				arg_354_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10002a")

				arg_354_1.callingController_:SetSelectedState("normal")

				arg_354_1.keyicon_.color = Color.New(1, 1, 1)
				arg_354_1.icon_.color = Color.New(1, 1, 1)

				local var_357_3 = arg_354_1:GetWordFromCfg(411051084)
				local var_357_4 = arg_354_1:FormatText(var_357_3.content)

				arg_354_1.text_.text = var_357_4

				LuaForUtil.ClearLinePrefixSymbol(arg_354_1.text_)

				local var_357_5 = 25
				local var_357_6 = utf8.len(var_357_4)
				local var_357_7 = var_357_5 <= 0 and var_357_1 or var_357_1 * (var_357_6 / var_357_5)

				if var_357_7 > 0 and var_357_1 < var_357_7 then
					arg_354_1.talkMaxDuration = var_357_7

					if var_357_7 + var_357_0 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_7 + var_357_0
					end
				end

				arg_354_1.text_.text = var_357_4
				arg_354_1.typewritter.percent = 0

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051084", "story_v_out_411051.awb") ~= 0 then
					local var_357_8 = manager.audio:GetVoiceLength("story_v_out_411051", "411051084", "story_v_out_411051.awb") / 1000

					if var_357_8 + var_357_0 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_8 + var_357_0
					end

					if var_357_3.prefab_name ~= "" and arg_354_1.actors_[var_357_3.prefab_name] ~= nil then
						local var_357_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_354_1.actors_[var_357_3.prefab_name].transform, "story_v_out_411051", "411051084", "story_v_out_411051.awb")

						arg_354_1:RecordAudio("411051084", var_357_9)
						arg_354_1:RecordAudio("411051084", var_357_9)
					else
						arg_354_1:AudioAction("play", "voice", "story_v_out_411051", "411051084", "story_v_out_411051.awb")
					end

					arg_354_1:RecordHistoryTalkVoice("story_v_out_411051", "411051084", "story_v_out_411051.awb")
				end

				arg_354_1:RecordContent(arg_354_1.text_.text)
			end

			local var_357_10 = math.max(var_357_1, arg_354_1.talkMaxDuration)

			if var_357_0 <= arg_354_1.time_ and arg_354_1.time_ < var_357_0 + var_357_10 then
				arg_354_1.typewritter.percent = (arg_354_1.time_ - var_357_0) / var_357_10

				arg_354_1.typewritter:SetDirty()
			end

			if arg_354_1.time_ >= var_357_0 + var_357_10 and arg_354_1.time_ < var_357_0 + var_357_10 + arg_357_0 then
				arg_354_1.typewritter.percent = 1

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(true)
			end
		end

		arg_354_1.nodeConfigList_ = {}

		arg_354_1:InitPlayNodeList()
	end,
	Play411051085 = function(arg_358_0, arg_358_1)
		arg_358_1.time_ = 0
		arg_358_1.frameCnt_ = 0
		arg_358_1.state_ = "playing"
		arg_358_1.curTalkId_ = 411051085
		arg_358_1.duration_ = 6.53

		local var_358_0 = {
			zh = 5.933,
			ja = 6.533
		}
		local var_358_1 = manager.audio:GetLocalizationFlag()

		if var_358_0[var_358_1] ~= nil then
			arg_358_1.duration_ = var_358_0[var_358_1]
		end

		SetActive(arg_358_1.tipsGo_, false)

		function arg_358_1.onSingleLineFinish_()
			arg_358_1.onSingleLineUpdate_ = nil
			arg_358_1.onSingleLineFinish_ = nil
			arg_358_1.state_ = "waiting"
		end

		function arg_358_1.playNext_(arg_360_0)
			if arg_360_0 == 1 then
				arg_358_0:Play411051086(arg_358_1)
			end
		end

		function arg_358_1.onSingleLineUpdate_(arg_361_0)
			local var_361_0 = arg_358_1.actors_["1095ui_story"]
			local var_361_1 = 0

			if var_361_1 < arg_358_1.time_ and arg_358_1.time_ <= var_361_1 + arg_361_0 and not isNil(var_361_0) and arg_358_1.var_.characterEffect1095ui_story == nil then
				arg_358_1.var_.characterEffect1095ui_story = var_361_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_361_2 = 0.200000002980232

			if var_361_1 <= arg_358_1.time_ and arg_358_1.time_ < var_361_1 + var_361_2 and not isNil(var_361_0) then
				local var_361_3 = (arg_358_1.time_ - var_361_1) / var_361_2

				if arg_358_1.var_.characterEffect1095ui_story and not isNil(var_361_0) then
					arg_358_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_358_1.time_ >= var_361_1 + var_361_2 and arg_358_1.time_ < var_361_1 + var_361_2 + arg_361_0 and not isNil(var_361_0) and arg_358_1.var_.characterEffect1095ui_story then
				arg_358_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_361_4 = 0
			local var_361_5 = 0.7

			if var_361_4 < arg_358_1.time_ and arg_358_1.time_ <= var_361_4 + arg_361_0 then
				arg_358_1.talkMaxDuration = 0
				arg_358_1.dialogCg_.alpha = 1

				arg_358_1.dialog_:SetActive(true)
				SetActive(arg_358_1.leftNameGo_, true)

				local var_361_6 = arg_358_1:FormatText(StoryNameCfg[471].name)

				arg_358_1.leftNameTxt_.text = var_361_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_358_1.leftNameTxt_.transform)

				arg_358_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_358_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_358_1:RecordName(arg_358_1.leftNameTxt_.text)
				SetActive(arg_358_1.iconTrs_.gameObject, false)
				arg_358_1.callingController_:SetSelectedState("normal")

				local var_361_7 = arg_358_1:GetWordFromCfg(411051085)
				local var_361_8 = arg_358_1:FormatText(var_361_7.content)

				arg_358_1.text_.text = var_361_8

				LuaForUtil.ClearLinePrefixSymbol(arg_358_1.text_)

				local var_361_9 = 28
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

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051085", "story_v_out_411051.awb") ~= 0 then
					local var_361_12 = manager.audio:GetVoiceLength("story_v_out_411051", "411051085", "story_v_out_411051.awb") / 1000

					if var_361_12 + var_361_4 > arg_358_1.duration_ then
						arg_358_1.duration_ = var_361_12 + var_361_4
					end

					if var_361_7.prefab_name ~= "" and arg_358_1.actors_[var_361_7.prefab_name] ~= nil then
						local var_361_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_358_1.actors_[var_361_7.prefab_name].transform, "story_v_out_411051", "411051085", "story_v_out_411051.awb")

						arg_358_1:RecordAudio("411051085", var_361_13)
						arg_358_1:RecordAudio("411051085", var_361_13)
					else
						arg_358_1:AudioAction("play", "voice", "story_v_out_411051", "411051085", "story_v_out_411051.awb")
					end

					arg_358_1:RecordHistoryTalkVoice("story_v_out_411051", "411051085", "story_v_out_411051.awb")
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
	Play411051086 = function(arg_362_0, arg_362_1)
		arg_362_1.time_ = 0
		arg_362_1.frameCnt_ = 0
		arg_362_1.state_ = "playing"
		arg_362_1.curTalkId_ = 411051086
		arg_362_1.duration_ = 5.3

		local var_362_0 = {
			zh = 5.3,
			ja = 5.1
		}
		local var_362_1 = manager.audio:GetLocalizationFlag()

		if var_362_0[var_362_1] ~= nil then
			arg_362_1.duration_ = var_362_0[var_362_1]
		end

		SetActive(arg_362_1.tipsGo_, false)

		function arg_362_1.onSingleLineFinish_()
			arg_362_1.onSingleLineUpdate_ = nil
			arg_362_1.onSingleLineFinish_ = nil
			arg_362_1.state_ = "waiting"
		end

		function arg_362_1.playNext_(arg_364_0)
			if arg_364_0 == 1 then
				arg_362_0:Play411051087(arg_362_1)
			end
		end

		function arg_362_1.onSingleLineUpdate_(arg_365_0)
			local var_365_0 = 0
			local var_365_1 = 0.7

			if var_365_0 < arg_362_1.time_ and arg_362_1.time_ <= var_365_0 + arg_365_0 then
				arg_362_1.talkMaxDuration = 0
				arg_362_1.dialogCg_.alpha = 1

				arg_362_1.dialog_:SetActive(true)
				SetActive(arg_362_1.leftNameGo_, true)

				local var_365_2 = arg_362_1:FormatText(StoryNameCfg[471].name)

				arg_362_1.leftNameTxt_.text = var_365_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_362_1.leftNameTxt_.transform)

				arg_362_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_362_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_362_1:RecordName(arg_362_1.leftNameTxt_.text)
				SetActive(arg_362_1.iconTrs_.gameObject, false)
				arg_362_1.callingController_:SetSelectedState("normal")

				local var_365_3 = arg_362_1:GetWordFromCfg(411051086)
				local var_365_4 = arg_362_1:FormatText(var_365_3.content)

				arg_362_1.text_.text = var_365_4

				LuaForUtil.ClearLinePrefixSymbol(arg_362_1.text_)

				local var_365_5 = 28
				local var_365_6 = utf8.len(var_365_4)
				local var_365_7 = var_365_5 <= 0 and var_365_1 or var_365_1 * (var_365_6 / var_365_5)

				if var_365_7 > 0 and var_365_1 < var_365_7 then
					arg_362_1.talkMaxDuration = var_365_7

					if var_365_7 + var_365_0 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_7 + var_365_0
					end
				end

				arg_362_1.text_.text = var_365_4
				arg_362_1.typewritter.percent = 0

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051086", "story_v_out_411051.awb") ~= 0 then
					local var_365_8 = manager.audio:GetVoiceLength("story_v_out_411051", "411051086", "story_v_out_411051.awb") / 1000

					if var_365_8 + var_365_0 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_8 + var_365_0
					end

					if var_365_3.prefab_name ~= "" and arg_362_1.actors_[var_365_3.prefab_name] ~= nil then
						local var_365_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_362_1.actors_[var_365_3.prefab_name].transform, "story_v_out_411051", "411051086", "story_v_out_411051.awb")

						arg_362_1:RecordAudio("411051086", var_365_9)
						arg_362_1:RecordAudio("411051086", var_365_9)
					else
						arg_362_1:AudioAction("play", "voice", "story_v_out_411051", "411051086", "story_v_out_411051.awb")
					end

					arg_362_1:RecordHistoryTalkVoice("story_v_out_411051", "411051086", "story_v_out_411051.awb")
				end

				arg_362_1:RecordContent(arg_362_1.text_.text)
			end

			local var_365_10 = math.max(var_365_1, arg_362_1.talkMaxDuration)

			if var_365_0 <= arg_362_1.time_ and arg_362_1.time_ < var_365_0 + var_365_10 then
				arg_362_1.typewritter.percent = (arg_362_1.time_ - var_365_0) / var_365_10

				arg_362_1.typewritter:SetDirty()
			end

			if arg_362_1.time_ >= var_365_0 + var_365_10 and arg_362_1.time_ < var_365_0 + var_365_10 + arg_365_0 then
				arg_362_1.typewritter.percent = 1

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(true)
			end
		end

		arg_362_1.nodeConfigList_ = {}

		arg_362_1:InitPlayNodeList()
	end,
	Play411051087 = function(arg_366_0, arg_366_1)
		arg_366_1.time_ = 0
		arg_366_1.frameCnt_ = 0
		arg_366_1.state_ = "playing"
		arg_366_1.curTalkId_ = 411051087
		arg_366_1.duration_ = 2.33

		local var_366_0 = {
			zh = 2.2,
			ja = 2.333
		}
		local var_366_1 = manager.audio:GetLocalizationFlag()

		if var_366_0[var_366_1] ~= nil then
			arg_366_1.duration_ = var_366_0[var_366_1]
		end

		SetActive(arg_366_1.tipsGo_, false)

		function arg_366_1.onSingleLineFinish_()
			arg_366_1.onSingleLineUpdate_ = nil
			arg_366_1.onSingleLineFinish_ = nil
			arg_366_1.state_ = "waiting"
		end

		function arg_366_1.playNext_(arg_368_0)
			if arg_368_0 == 1 then
				arg_366_0:Play411051088(arg_366_1)
			end
		end

		function arg_366_1.onSingleLineUpdate_(arg_369_0)
			local var_369_0 = arg_366_1.actors_["1095ui_story"]
			local var_369_1 = 0

			if var_369_1 < arg_366_1.time_ and arg_366_1.time_ <= var_369_1 + arg_369_0 and not isNil(var_369_0) and arg_366_1.var_.characterEffect1095ui_story == nil then
				arg_366_1.var_.characterEffect1095ui_story = var_369_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_369_2 = 0.200000002980232

			if var_369_1 <= arg_366_1.time_ and arg_366_1.time_ < var_369_1 + var_369_2 and not isNil(var_369_0) then
				local var_369_3 = (arg_366_1.time_ - var_369_1) / var_369_2

				if arg_366_1.var_.characterEffect1095ui_story and not isNil(var_369_0) then
					local var_369_4 = Mathf.Lerp(0, 0.5, var_369_3)

					arg_366_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_366_1.var_.characterEffect1095ui_story.fillRatio = var_369_4
				end
			end

			if arg_366_1.time_ >= var_369_1 + var_369_2 and arg_366_1.time_ < var_369_1 + var_369_2 + arg_369_0 and not isNil(var_369_0) and arg_366_1.var_.characterEffect1095ui_story then
				local var_369_5 = 0.5

				arg_366_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_366_1.var_.characterEffect1095ui_story.fillRatio = var_369_5
			end

			local var_369_6 = 0
			local var_369_7 = 0.15

			if var_369_6 < arg_366_1.time_ and arg_366_1.time_ <= var_369_6 + arg_369_0 then
				arg_366_1.talkMaxDuration = 0
				arg_366_1.dialogCg_.alpha = 1

				arg_366_1.dialog_:SetActive(true)
				SetActive(arg_366_1.leftNameGo_, true)

				local var_369_8 = arg_366_1:FormatText(StoryNameCfg[39].name)

				arg_366_1.leftNameTxt_.text = var_369_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_366_1.leftNameTxt_.transform)

				arg_366_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_366_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_366_1:RecordName(arg_366_1.leftNameTxt_.text)
				SetActive(arg_366_1.iconTrs_.gameObject, true)
				arg_366_1.iconController_:SetSelectedState("hero")

				arg_366_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10002a")

				arg_366_1.callingController_:SetSelectedState("normal")

				arg_366_1.keyicon_.color = Color.New(1, 1, 1)
				arg_366_1.icon_.color = Color.New(1, 1, 1)

				local var_369_9 = arg_366_1:GetWordFromCfg(411051087)
				local var_369_10 = arg_366_1:FormatText(var_369_9.content)

				arg_366_1.text_.text = var_369_10

				LuaForUtil.ClearLinePrefixSymbol(arg_366_1.text_)

				local var_369_11 = 6
				local var_369_12 = utf8.len(var_369_10)
				local var_369_13 = var_369_11 <= 0 and var_369_7 or var_369_7 * (var_369_12 / var_369_11)

				if var_369_13 > 0 and var_369_7 < var_369_13 then
					arg_366_1.talkMaxDuration = var_369_13

					if var_369_13 + var_369_6 > arg_366_1.duration_ then
						arg_366_1.duration_ = var_369_13 + var_369_6
					end
				end

				arg_366_1.text_.text = var_369_10
				arg_366_1.typewritter.percent = 0

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051087", "story_v_out_411051.awb") ~= 0 then
					local var_369_14 = manager.audio:GetVoiceLength("story_v_out_411051", "411051087", "story_v_out_411051.awb") / 1000

					if var_369_14 + var_369_6 > arg_366_1.duration_ then
						arg_366_1.duration_ = var_369_14 + var_369_6
					end

					if var_369_9.prefab_name ~= "" and arg_366_1.actors_[var_369_9.prefab_name] ~= nil then
						local var_369_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_366_1.actors_[var_369_9.prefab_name].transform, "story_v_out_411051", "411051087", "story_v_out_411051.awb")

						arg_366_1:RecordAudio("411051087", var_369_15)
						arg_366_1:RecordAudio("411051087", var_369_15)
					else
						arg_366_1:AudioAction("play", "voice", "story_v_out_411051", "411051087", "story_v_out_411051.awb")
					end

					arg_366_1:RecordHistoryTalkVoice("story_v_out_411051", "411051087", "story_v_out_411051.awb")
				end

				arg_366_1:RecordContent(arg_366_1.text_.text)
			end

			local var_369_16 = math.max(var_369_7, arg_366_1.talkMaxDuration)

			if var_369_6 <= arg_366_1.time_ and arg_366_1.time_ < var_369_6 + var_369_16 then
				arg_366_1.typewritter.percent = (arg_366_1.time_ - var_369_6) / var_369_16

				arg_366_1.typewritter:SetDirty()
			end

			if arg_366_1.time_ >= var_369_6 + var_369_16 and arg_366_1.time_ < var_369_6 + var_369_16 + arg_369_0 then
				arg_366_1.typewritter.percent = 1

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(true)
			end
		end

		arg_366_1.nodeConfigList_ = {}

		arg_366_1:InitPlayNodeList()
	end,
	Play411051088 = function(arg_370_0, arg_370_1)
		arg_370_1.time_ = 0
		arg_370_1.frameCnt_ = 0
		arg_370_1.state_ = "playing"
		arg_370_1.curTalkId_ = 411051088
		arg_370_1.duration_ = 5

		SetActive(arg_370_1.tipsGo_, false)

		function arg_370_1.onSingleLineFinish_()
			arg_370_1.onSingleLineUpdate_ = nil
			arg_370_1.onSingleLineFinish_ = nil
			arg_370_1.state_ = "waiting"
		end

		function arg_370_1.playNext_(arg_372_0)
			if arg_372_0 == 1 then
				arg_370_0:Play411051089(arg_370_1)
			end
		end

		function arg_370_1.onSingleLineUpdate_(arg_373_0)
			local var_373_0 = arg_370_1.actors_["1095ui_story"]
			local var_373_1 = 0

			if var_373_1 < arg_370_1.time_ and arg_370_1.time_ <= var_373_1 + arg_373_0 and not isNil(var_373_0) and arg_370_1.var_.characterEffect1095ui_story == nil then
				arg_370_1.var_.characterEffect1095ui_story = var_373_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_373_2 = 0.200000002980232

			if var_373_1 <= arg_370_1.time_ and arg_370_1.time_ < var_373_1 + var_373_2 and not isNil(var_373_0) then
				local var_373_3 = (arg_370_1.time_ - var_373_1) / var_373_2

				if arg_370_1.var_.characterEffect1095ui_story and not isNil(var_373_0) then
					local var_373_4 = Mathf.Lerp(0, 0.5, var_373_3)

					arg_370_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_370_1.var_.characterEffect1095ui_story.fillRatio = var_373_4
				end
			end

			if arg_370_1.time_ >= var_373_1 + var_373_2 and arg_370_1.time_ < var_373_1 + var_373_2 + arg_373_0 and not isNil(var_373_0) and arg_370_1.var_.characterEffect1095ui_story then
				local var_373_5 = 0.5

				arg_370_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_370_1.var_.characterEffect1095ui_story.fillRatio = var_373_5
			end

			local var_373_6 = 0
			local var_373_7 = 0.825

			if var_373_6 < arg_370_1.time_ and arg_370_1.time_ <= var_373_6 + arg_373_0 then
				arg_370_1.talkMaxDuration = 0
				arg_370_1.dialogCg_.alpha = 1

				arg_370_1.dialog_:SetActive(true)
				SetActive(arg_370_1.leftNameGo_, false)

				arg_370_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_370_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_370_1:RecordName(arg_370_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_370_1.iconTrs_.gameObject, false)
				arg_370_1.callingController_:SetSelectedState("normal")

				local var_373_8 = arg_370_1:GetWordFromCfg(411051088)
				local var_373_9 = arg_370_1:FormatText(var_373_8.content)

				arg_370_1.text_.text = var_373_9

				LuaForUtil.ClearLinePrefixSymbol(arg_370_1.text_)

				local var_373_10 = 33
				local var_373_11 = utf8.len(var_373_9)
				local var_373_12 = var_373_10 <= 0 and var_373_7 or var_373_7 * (var_373_11 / var_373_10)

				if var_373_12 > 0 and var_373_7 < var_373_12 then
					arg_370_1.talkMaxDuration = var_373_12

					if var_373_12 + var_373_6 > arg_370_1.duration_ then
						arg_370_1.duration_ = var_373_12 + var_373_6
					end
				end

				arg_370_1.text_.text = var_373_9
				arg_370_1.typewritter.percent = 0

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(false)
				arg_370_1:RecordContent(arg_370_1.text_.text)
			end

			local var_373_13 = math.max(var_373_7, arg_370_1.talkMaxDuration)

			if var_373_6 <= arg_370_1.time_ and arg_370_1.time_ < var_373_6 + var_373_13 then
				arg_370_1.typewritter.percent = (arg_370_1.time_ - var_373_6) / var_373_13

				arg_370_1.typewritter:SetDirty()
			end

			if arg_370_1.time_ >= var_373_6 + var_373_13 and arg_370_1.time_ < var_373_6 + var_373_13 + arg_373_0 then
				arg_370_1.typewritter.percent = 1

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(true)
			end
		end

		arg_370_1.nodeConfigList_ = {}

		arg_370_1:InitPlayNodeList()
	end,
	Play411051089 = function(arg_374_0, arg_374_1)
		arg_374_1.time_ = 0
		arg_374_1.frameCnt_ = 0
		arg_374_1.state_ = "playing"
		arg_374_1.curTalkId_ = 411051089
		arg_374_1.duration_ = 5.47

		local var_374_0 = {
			zh = 4.833,
			ja = 5.466
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
				arg_374_0:Play411051090(arg_374_1)
			end
		end

		function arg_374_1.onSingleLineUpdate_(arg_377_0)
			local var_377_0 = 0
			local var_377_1 = 0.575

			if var_377_0 < arg_374_1.time_ and arg_374_1.time_ <= var_377_0 + arg_377_0 then
				arg_374_1.talkMaxDuration = 0
				arg_374_1.dialogCg_.alpha = 1

				arg_374_1.dialog_:SetActive(true)
				SetActive(arg_374_1.leftNameGo_, true)

				local var_377_2 = arg_374_1:FormatText(StoryNameCfg[39].name)

				arg_374_1.leftNameTxt_.text = var_377_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_374_1.leftNameTxt_.transform)

				arg_374_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_374_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_374_1:RecordName(arg_374_1.leftNameTxt_.text)
				SetActive(arg_374_1.iconTrs_.gameObject, true)
				arg_374_1.iconController_:SetSelectedState("hero")

				arg_374_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10002a")

				arg_374_1.callingController_:SetSelectedState("normal")

				arg_374_1.keyicon_.color = Color.New(1, 1, 1)
				arg_374_1.icon_.color = Color.New(1, 1, 1)

				local var_377_3 = arg_374_1:GetWordFromCfg(411051089)
				local var_377_4 = arg_374_1:FormatText(var_377_3.content)

				arg_374_1.text_.text = var_377_4

				LuaForUtil.ClearLinePrefixSymbol(arg_374_1.text_)

				local var_377_5 = 23
				local var_377_6 = utf8.len(var_377_4)
				local var_377_7 = var_377_5 <= 0 and var_377_1 or var_377_1 * (var_377_6 / var_377_5)

				if var_377_7 > 0 and var_377_1 < var_377_7 then
					arg_374_1.talkMaxDuration = var_377_7

					if var_377_7 + var_377_0 > arg_374_1.duration_ then
						arg_374_1.duration_ = var_377_7 + var_377_0
					end
				end

				arg_374_1.text_.text = var_377_4
				arg_374_1.typewritter.percent = 0

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051089", "story_v_out_411051.awb") ~= 0 then
					local var_377_8 = manager.audio:GetVoiceLength("story_v_out_411051", "411051089", "story_v_out_411051.awb") / 1000

					if var_377_8 + var_377_0 > arg_374_1.duration_ then
						arg_374_1.duration_ = var_377_8 + var_377_0
					end

					if var_377_3.prefab_name ~= "" and arg_374_1.actors_[var_377_3.prefab_name] ~= nil then
						local var_377_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_374_1.actors_[var_377_3.prefab_name].transform, "story_v_out_411051", "411051089", "story_v_out_411051.awb")

						arg_374_1:RecordAudio("411051089", var_377_9)
						arg_374_1:RecordAudio("411051089", var_377_9)
					else
						arg_374_1:AudioAction("play", "voice", "story_v_out_411051", "411051089", "story_v_out_411051.awb")
					end

					arg_374_1:RecordHistoryTalkVoice("story_v_out_411051", "411051089", "story_v_out_411051.awb")
				end

				arg_374_1:RecordContent(arg_374_1.text_.text)
			end

			local var_377_10 = math.max(var_377_1, arg_374_1.talkMaxDuration)

			if var_377_0 <= arg_374_1.time_ and arg_374_1.time_ < var_377_0 + var_377_10 then
				arg_374_1.typewritter.percent = (arg_374_1.time_ - var_377_0) / var_377_10

				arg_374_1.typewritter:SetDirty()
			end

			if arg_374_1.time_ >= var_377_0 + var_377_10 and arg_374_1.time_ < var_377_0 + var_377_10 + arg_377_0 then
				arg_374_1.typewritter.percent = 1

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(true)
			end
		end

		arg_374_1.nodeConfigList_ = {}

		arg_374_1:InitPlayNodeList()
	end,
	Play411051090 = function(arg_378_0, arg_378_1)
		arg_378_1.time_ = 0
		arg_378_1.frameCnt_ = 0
		arg_378_1.state_ = "playing"
		arg_378_1.curTalkId_ = 411051090
		arg_378_1.duration_ = 1.3

		local var_378_0 = {
			zh = 1.1,
			ja = 1.3
		}
		local var_378_1 = manager.audio:GetLocalizationFlag()

		if var_378_0[var_378_1] ~= nil then
			arg_378_1.duration_ = var_378_0[var_378_1]
		end

		SetActive(arg_378_1.tipsGo_, false)

		function arg_378_1.onSingleLineFinish_()
			arg_378_1.onSingleLineUpdate_ = nil
			arg_378_1.onSingleLineFinish_ = nil
			arg_378_1.state_ = "waiting"
		end

		function arg_378_1.playNext_(arg_380_0)
			if arg_380_0 == 1 then
				arg_378_0:Play411051091(arg_378_1)
			end
		end

		function arg_378_1.onSingleLineUpdate_(arg_381_0)
			local var_381_0 = arg_378_1.actors_["1095ui_story"]
			local var_381_1 = 0

			if var_381_1 < arg_378_1.time_ and arg_378_1.time_ <= var_381_1 + arg_381_0 and not isNil(var_381_0) and arg_378_1.var_.characterEffect1095ui_story == nil then
				arg_378_1.var_.characterEffect1095ui_story = var_381_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_381_2 = 0.200000002980232

			if var_381_1 <= arg_378_1.time_ and arg_378_1.time_ < var_381_1 + var_381_2 and not isNil(var_381_0) then
				local var_381_3 = (arg_378_1.time_ - var_381_1) / var_381_2

				if arg_378_1.var_.characterEffect1095ui_story and not isNil(var_381_0) then
					arg_378_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_378_1.time_ >= var_381_1 + var_381_2 and arg_378_1.time_ < var_381_1 + var_381_2 + arg_381_0 and not isNil(var_381_0) and arg_378_1.var_.characterEffect1095ui_story then
				arg_378_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_381_4 = 0
			local var_381_5 = 0.1

			if var_381_4 < arg_378_1.time_ and arg_378_1.time_ <= var_381_4 + arg_381_0 then
				arg_378_1.talkMaxDuration = 0
				arg_378_1.dialogCg_.alpha = 1

				arg_378_1.dialog_:SetActive(true)
				SetActive(arg_378_1.leftNameGo_, true)

				local var_381_6 = arg_378_1:FormatText(StoryNameCfg[471].name)

				arg_378_1.leftNameTxt_.text = var_381_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_378_1.leftNameTxt_.transform)

				arg_378_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_378_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_378_1:RecordName(arg_378_1.leftNameTxt_.text)
				SetActive(arg_378_1.iconTrs_.gameObject, false)
				arg_378_1.callingController_:SetSelectedState("normal")

				local var_381_7 = arg_378_1:GetWordFromCfg(411051090)
				local var_381_8 = arg_378_1:FormatText(var_381_7.content)

				arg_378_1.text_.text = var_381_8

				LuaForUtil.ClearLinePrefixSymbol(arg_378_1.text_)

				local var_381_9 = 4
				local var_381_10 = utf8.len(var_381_8)
				local var_381_11 = var_381_9 <= 0 and var_381_5 or var_381_5 * (var_381_10 / var_381_9)

				if var_381_11 > 0 and var_381_5 < var_381_11 then
					arg_378_1.talkMaxDuration = var_381_11

					if var_381_11 + var_381_4 > arg_378_1.duration_ then
						arg_378_1.duration_ = var_381_11 + var_381_4
					end
				end

				arg_378_1.text_.text = var_381_8
				arg_378_1.typewritter.percent = 0

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051090", "story_v_out_411051.awb") ~= 0 then
					local var_381_12 = manager.audio:GetVoiceLength("story_v_out_411051", "411051090", "story_v_out_411051.awb") / 1000

					if var_381_12 + var_381_4 > arg_378_1.duration_ then
						arg_378_1.duration_ = var_381_12 + var_381_4
					end

					if var_381_7.prefab_name ~= "" and arg_378_1.actors_[var_381_7.prefab_name] ~= nil then
						local var_381_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_378_1.actors_[var_381_7.prefab_name].transform, "story_v_out_411051", "411051090", "story_v_out_411051.awb")

						arg_378_1:RecordAudio("411051090", var_381_13)
						arg_378_1:RecordAudio("411051090", var_381_13)
					else
						arg_378_1:AudioAction("play", "voice", "story_v_out_411051", "411051090", "story_v_out_411051.awb")
					end

					arg_378_1:RecordHistoryTalkVoice("story_v_out_411051", "411051090", "story_v_out_411051.awb")
				end

				arg_378_1:RecordContent(arg_378_1.text_.text)
			end

			local var_381_14 = math.max(var_381_5, arg_378_1.talkMaxDuration)

			if var_381_4 <= arg_378_1.time_ and arg_378_1.time_ < var_381_4 + var_381_14 then
				arg_378_1.typewritter.percent = (arg_378_1.time_ - var_381_4) / var_381_14

				arg_378_1.typewritter:SetDirty()
			end

			if arg_378_1.time_ >= var_381_4 + var_381_14 and arg_378_1.time_ < var_381_4 + var_381_14 + arg_381_0 then
				arg_378_1.typewritter.percent = 1

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(true)
			end
		end

		arg_378_1.nodeConfigList_ = {}

		arg_378_1:InitPlayNodeList()
	end,
	Play411051091 = function(arg_382_0, arg_382_1)
		arg_382_1.time_ = 0
		arg_382_1.frameCnt_ = 0
		arg_382_1.state_ = "playing"
		arg_382_1.curTalkId_ = 411051091
		arg_382_1.duration_ = 8.3

		local var_382_0 = {
			zh = 4.833,
			ja = 8.3
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
				arg_382_0:Play411051092(arg_382_1)
			end
		end

		function arg_382_1.onSingleLineUpdate_(arg_385_0)
			local var_385_0 = arg_382_1.actors_["1095ui_story"]
			local var_385_1 = 0

			if var_385_1 < arg_382_1.time_ and arg_382_1.time_ <= var_385_1 + arg_385_0 and not isNil(var_385_0) and arg_382_1.var_.characterEffect1095ui_story == nil then
				arg_382_1.var_.characterEffect1095ui_story = var_385_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_385_2 = 0.200000002980232

			if var_385_1 <= arg_382_1.time_ and arg_382_1.time_ < var_385_1 + var_385_2 and not isNil(var_385_0) then
				local var_385_3 = (arg_382_1.time_ - var_385_1) / var_385_2

				if arg_382_1.var_.characterEffect1095ui_story and not isNil(var_385_0) then
					local var_385_4 = Mathf.Lerp(0, 0.5, var_385_3)

					arg_382_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_382_1.var_.characterEffect1095ui_story.fillRatio = var_385_4
				end
			end

			if arg_382_1.time_ >= var_385_1 + var_385_2 and arg_382_1.time_ < var_385_1 + var_385_2 + arg_385_0 and not isNil(var_385_0) and arg_382_1.var_.characterEffect1095ui_story then
				local var_385_5 = 0.5

				arg_382_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_382_1.var_.characterEffect1095ui_story.fillRatio = var_385_5
			end

			local var_385_6 = 0
			local var_385_7 = 0.575

			if var_385_6 < arg_382_1.time_ and arg_382_1.time_ <= var_385_6 + arg_385_0 then
				arg_382_1.talkMaxDuration = 0
				arg_382_1.dialogCg_.alpha = 1

				arg_382_1.dialog_:SetActive(true)
				SetActive(arg_382_1.leftNameGo_, true)

				local var_385_8 = arg_382_1:FormatText(StoryNameCfg[39].name)

				arg_382_1.leftNameTxt_.text = var_385_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_382_1.leftNameTxt_.transform)

				arg_382_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_382_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_382_1:RecordName(arg_382_1.leftNameTxt_.text)
				SetActive(arg_382_1.iconTrs_.gameObject, true)
				arg_382_1.iconController_:SetSelectedState("hero")

				arg_382_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10002a")

				arg_382_1.callingController_:SetSelectedState("normal")

				arg_382_1.keyicon_.color = Color.New(1, 1, 1)
				arg_382_1.icon_.color = Color.New(1, 1, 1)

				local var_385_9 = arg_382_1:GetWordFromCfg(411051091)
				local var_385_10 = arg_382_1:FormatText(var_385_9.content)

				arg_382_1.text_.text = var_385_10

				LuaForUtil.ClearLinePrefixSymbol(arg_382_1.text_)

				local var_385_11 = 23
				local var_385_12 = utf8.len(var_385_10)
				local var_385_13 = var_385_11 <= 0 and var_385_7 or var_385_7 * (var_385_12 / var_385_11)

				if var_385_13 > 0 and var_385_7 < var_385_13 then
					arg_382_1.talkMaxDuration = var_385_13

					if var_385_13 + var_385_6 > arg_382_1.duration_ then
						arg_382_1.duration_ = var_385_13 + var_385_6
					end
				end

				arg_382_1.text_.text = var_385_10
				arg_382_1.typewritter.percent = 0

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051091", "story_v_out_411051.awb") ~= 0 then
					local var_385_14 = manager.audio:GetVoiceLength("story_v_out_411051", "411051091", "story_v_out_411051.awb") / 1000

					if var_385_14 + var_385_6 > arg_382_1.duration_ then
						arg_382_1.duration_ = var_385_14 + var_385_6
					end

					if var_385_9.prefab_name ~= "" and arg_382_1.actors_[var_385_9.prefab_name] ~= nil then
						local var_385_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_382_1.actors_[var_385_9.prefab_name].transform, "story_v_out_411051", "411051091", "story_v_out_411051.awb")

						arg_382_1:RecordAudio("411051091", var_385_15)
						arg_382_1:RecordAudio("411051091", var_385_15)
					else
						arg_382_1:AudioAction("play", "voice", "story_v_out_411051", "411051091", "story_v_out_411051.awb")
					end

					arg_382_1:RecordHistoryTalkVoice("story_v_out_411051", "411051091", "story_v_out_411051.awb")
				end

				arg_382_1:RecordContent(arg_382_1.text_.text)
			end

			local var_385_16 = math.max(var_385_7, arg_382_1.talkMaxDuration)

			if var_385_6 <= arg_382_1.time_ and arg_382_1.time_ < var_385_6 + var_385_16 then
				arg_382_1.typewritter.percent = (arg_382_1.time_ - var_385_6) / var_385_16

				arg_382_1.typewritter:SetDirty()
			end

			if arg_382_1.time_ >= var_385_6 + var_385_16 and arg_382_1.time_ < var_385_6 + var_385_16 + arg_385_0 then
				arg_382_1.typewritter.percent = 1

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(true)
			end
		end

		arg_382_1.nodeConfigList_ = {}

		arg_382_1:InitPlayNodeList()
	end,
	Play411051092 = function(arg_386_0, arg_386_1)
		arg_386_1.time_ = 0
		arg_386_1.frameCnt_ = 0
		arg_386_1.state_ = "playing"
		arg_386_1.curTalkId_ = 411051092
		arg_386_1.duration_ = 13.33

		local var_386_0 = {
			zh = 7.8,
			ja = 13.333
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
				arg_386_0:Play411051093(arg_386_1)
			end
		end

		function arg_386_1.onSingleLineUpdate_(arg_389_0)
			local var_389_0 = arg_386_1.actors_["1095ui_story"]
			local var_389_1 = 0

			if var_389_1 < arg_386_1.time_ and arg_386_1.time_ <= var_389_1 + arg_389_0 and not isNil(var_389_0) and arg_386_1.var_.characterEffect1095ui_story == nil then
				arg_386_1.var_.characterEffect1095ui_story = var_389_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_389_2 = 0.200000002980232

			if var_389_1 <= arg_386_1.time_ and arg_386_1.time_ < var_389_1 + var_389_2 and not isNil(var_389_0) then
				local var_389_3 = (arg_386_1.time_ - var_389_1) / var_389_2

				if arg_386_1.var_.characterEffect1095ui_story and not isNil(var_389_0) then
					arg_386_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_386_1.time_ >= var_389_1 + var_389_2 and arg_386_1.time_ < var_389_1 + var_389_2 + arg_389_0 and not isNil(var_389_0) and arg_386_1.var_.characterEffect1095ui_story then
				arg_386_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_389_4 = 0

			if var_389_4 < arg_386_1.time_ and arg_386_1.time_ <= var_389_4 + arg_389_0 then
				arg_386_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action3_1")
			end

			local var_389_5 = 0

			if var_389_5 < arg_386_1.time_ and arg_386_1.time_ <= var_389_5 + arg_389_0 then
				arg_386_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_389_6 = 0
			local var_389_7 = 0.95

			if var_389_6 < arg_386_1.time_ and arg_386_1.time_ <= var_389_6 + arg_389_0 then
				arg_386_1.talkMaxDuration = 0
				arg_386_1.dialogCg_.alpha = 1

				arg_386_1.dialog_:SetActive(true)
				SetActive(arg_386_1.leftNameGo_, true)

				local var_389_8 = arg_386_1:FormatText(StoryNameCfg[471].name)

				arg_386_1.leftNameTxt_.text = var_389_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_386_1.leftNameTxt_.transform)

				arg_386_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_386_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_386_1:RecordName(arg_386_1.leftNameTxt_.text)
				SetActive(arg_386_1.iconTrs_.gameObject, false)
				arg_386_1.callingController_:SetSelectedState("normal")

				local var_389_9 = arg_386_1:GetWordFromCfg(411051092)
				local var_389_10 = arg_386_1:FormatText(var_389_9.content)

				arg_386_1.text_.text = var_389_10

				LuaForUtil.ClearLinePrefixSymbol(arg_386_1.text_)

				local var_389_11 = 38
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

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051092", "story_v_out_411051.awb") ~= 0 then
					local var_389_14 = manager.audio:GetVoiceLength("story_v_out_411051", "411051092", "story_v_out_411051.awb") / 1000

					if var_389_14 + var_389_6 > arg_386_1.duration_ then
						arg_386_1.duration_ = var_389_14 + var_389_6
					end

					if var_389_9.prefab_name ~= "" and arg_386_1.actors_[var_389_9.prefab_name] ~= nil then
						local var_389_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_386_1.actors_[var_389_9.prefab_name].transform, "story_v_out_411051", "411051092", "story_v_out_411051.awb")

						arg_386_1:RecordAudio("411051092", var_389_15)
						arg_386_1:RecordAudio("411051092", var_389_15)
					else
						arg_386_1:AudioAction("play", "voice", "story_v_out_411051", "411051092", "story_v_out_411051.awb")
					end

					arg_386_1:RecordHistoryTalkVoice("story_v_out_411051", "411051092", "story_v_out_411051.awb")
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
	Play411051093 = function(arg_390_0, arg_390_1)
		arg_390_1.time_ = 0
		arg_390_1.frameCnt_ = 0
		arg_390_1.state_ = "playing"
		arg_390_1.curTalkId_ = 411051093
		arg_390_1.duration_ = 13.47

		local var_390_0 = {
			zh = 8.2,
			ja = 13.466
		}
		local var_390_1 = manager.audio:GetLocalizationFlag()

		if var_390_0[var_390_1] ~= nil then
			arg_390_1.duration_ = var_390_0[var_390_1]
		end

		SetActive(arg_390_1.tipsGo_, false)

		function arg_390_1.onSingleLineFinish_()
			arg_390_1.onSingleLineUpdate_ = nil
			arg_390_1.onSingleLineFinish_ = nil
			arg_390_1.state_ = "waiting"
		end

		function arg_390_1.playNext_(arg_392_0)
			if arg_392_0 == 1 then
				arg_390_0:Play411051094(arg_390_1)
			end
		end

		function arg_390_1.onSingleLineUpdate_(arg_393_0)
			local var_393_0 = 0
			local var_393_1 = 0.875

			if var_393_0 < arg_390_1.time_ and arg_390_1.time_ <= var_393_0 + arg_393_0 then
				arg_390_1.talkMaxDuration = 0
				arg_390_1.dialogCg_.alpha = 1

				arg_390_1.dialog_:SetActive(true)
				SetActive(arg_390_1.leftNameGo_, true)

				local var_393_2 = arg_390_1:FormatText(StoryNameCfg[471].name)

				arg_390_1.leftNameTxt_.text = var_393_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_390_1.leftNameTxt_.transform)

				arg_390_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_390_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_390_1:RecordName(arg_390_1.leftNameTxt_.text)
				SetActive(arg_390_1.iconTrs_.gameObject, false)
				arg_390_1.callingController_:SetSelectedState("normal")

				local var_393_3 = arg_390_1:GetWordFromCfg(411051093)
				local var_393_4 = arg_390_1:FormatText(var_393_3.content)

				arg_390_1.text_.text = var_393_4

				LuaForUtil.ClearLinePrefixSymbol(arg_390_1.text_)

				local var_393_5 = 35
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

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051093", "story_v_out_411051.awb") ~= 0 then
					local var_393_8 = manager.audio:GetVoiceLength("story_v_out_411051", "411051093", "story_v_out_411051.awb") / 1000

					if var_393_8 + var_393_0 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_8 + var_393_0
					end

					if var_393_3.prefab_name ~= "" and arg_390_1.actors_[var_393_3.prefab_name] ~= nil then
						local var_393_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_390_1.actors_[var_393_3.prefab_name].transform, "story_v_out_411051", "411051093", "story_v_out_411051.awb")

						arg_390_1:RecordAudio("411051093", var_393_9)
						arg_390_1:RecordAudio("411051093", var_393_9)
					else
						arg_390_1:AudioAction("play", "voice", "story_v_out_411051", "411051093", "story_v_out_411051.awb")
					end

					arg_390_1:RecordHistoryTalkVoice("story_v_out_411051", "411051093", "story_v_out_411051.awb")
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
	Play411051094 = function(arg_394_0, arg_394_1)
		arg_394_1.time_ = 0
		arg_394_1.frameCnt_ = 0
		arg_394_1.state_ = "playing"
		arg_394_1.curTalkId_ = 411051094
		arg_394_1.duration_ = 9.7

		local var_394_0 = {
			zh = 9.7,
			ja = 6.366
		}
		local var_394_1 = manager.audio:GetLocalizationFlag()

		if var_394_0[var_394_1] ~= nil then
			arg_394_1.duration_ = var_394_0[var_394_1]
		end

		SetActive(arg_394_1.tipsGo_, false)

		function arg_394_1.onSingleLineFinish_()
			arg_394_1.onSingleLineUpdate_ = nil
			arg_394_1.onSingleLineFinish_ = nil
			arg_394_1.state_ = "waiting"
		end

		function arg_394_1.playNext_(arg_396_0)
			if arg_396_0 == 1 then
				arg_394_0:Play411051095(arg_394_1)
			end
		end

		function arg_394_1.onSingleLineUpdate_(arg_397_0)
			local var_397_0 = arg_394_1.actors_["1095ui_story"]
			local var_397_1 = 0

			if var_397_1 < arg_394_1.time_ and arg_394_1.time_ <= var_397_1 + arg_397_0 and not isNil(var_397_0) and arg_394_1.var_.characterEffect1095ui_story == nil then
				arg_394_1.var_.characterEffect1095ui_story = var_397_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_397_2 = 0.200000002980232

			if var_397_1 <= arg_394_1.time_ and arg_394_1.time_ < var_397_1 + var_397_2 and not isNil(var_397_0) then
				local var_397_3 = (arg_394_1.time_ - var_397_1) / var_397_2

				if arg_394_1.var_.characterEffect1095ui_story and not isNil(var_397_0) then
					local var_397_4 = Mathf.Lerp(0, 0.5, var_397_3)

					arg_394_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_394_1.var_.characterEffect1095ui_story.fillRatio = var_397_4
				end
			end

			if arg_394_1.time_ >= var_397_1 + var_397_2 and arg_394_1.time_ < var_397_1 + var_397_2 + arg_397_0 and not isNil(var_397_0) and arg_394_1.var_.characterEffect1095ui_story then
				local var_397_5 = 0.5

				arg_394_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_394_1.var_.characterEffect1095ui_story.fillRatio = var_397_5
			end

			local var_397_6 = 0
			local var_397_7 = 0.95

			if var_397_6 < arg_394_1.time_ and arg_394_1.time_ <= var_397_6 + arg_397_0 then
				arg_394_1.talkMaxDuration = 0
				arg_394_1.dialogCg_.alpha = 1

				arg_394_1.dialog_:SetActive(true)
				SetActive(arg_394_1.leftNameGo_, true)

				local var_397_8 = arg_394_1:FormatText(StoryNameCfg[39].name)

				arg_394_1.leftNameTxt_.text = var_397_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_394_1.leftNameTxt_.transform)

				arg_394_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_394_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_394_1:RecordName(arg_394_1.leftNameTxt_.text)
				SetActive(arg_394_1.iconTrs_.gameObject, true)
				arg_394_1.iconController_:SetSelectedState("hero")

				arg_394_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10002a")

				arg_394_1.callingController_:SetSelectedState("normal")

				arg_394_1.keyicon_.color = Color.New(1, 1, 1)
				arg_394_1.icon_.color = Color.New(1, 1, 1)

				local var_397_9 = arg_394_1:GetWordFromCfg(411051094)
				local var_397_10 = arg_394_1:FormatText(var_397_9.content)

				arg_394_1.text_.text = var_397_10

				LuaForUtil.ClearLinePrefixSymbol(arg_394_1.text_)

				local var_397_11 = 37
				local var_397_12 = utf8.len(var_397_10)
				local var_397_13 = var_397_11 <= 0 and var_397_7 or var_397_7 * (var_397_12 / var_397_11)

				if var_397_13 > 0 and var_397_7 < var_397_13 then
					arg_394_1.talkMaxDuration = var_397_13

					if var_397_13 + var_397_6 > arg_394_1.duration_ then
						arg_394_1.duration_ = var_397_13 + var_397_6
					end
				end

				arg_394_1.text_.text = var_397_10
				arg_394_1.typewritter.percent = 0

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051094", "story_v_out_411051.awb") ~= 0 then
					local var_397_14 = manager.audio:GetVoiceLength("story_v_out_411051", "411051094", "story_v_out_411051.awb") / 1000

					if var_397_14 + var_397_6 > arg_394_1.duration_ then
						arg_394_1.duration_ = var_397_14 + var_397_6
					end

					if var_397_9.prefab_name ~= "" and arg_394_1.actors_[var_397_9.prefab_name] ~= nil then
						local var_397_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_394_1.actors_[var_397_9.prefab_name].transform, "story_v_out_411051", "411051094", "story_v_out_411051.awb")

						arg_394_1:RecordAudio("411051094", var_397_15)
						arg_394_1:RecordAudio("411051094", var_397_15)
					else
						arg_394_1:AudioAction("play", "voice", "story_v_out_411051", "411051094", "story_v_out_411051.awb")
					end

					arg_394_1:RecordHistoryTalkVoice("story_v_out_411051", "411051094", "story_v_out_411051.awb")
				end

				arg_394_1:RecordContent(arg_394_1.text_.text)
			end

			local var_397_16 = math.max(var_397_7, arg_394_1.talkMaxDuration)

			if var_397_6 <= arg_394_1.time_ and arg_394_1.time_ < var_397_6 + var_397_16 then
				arg_394_1.typewritter.percent = (arg_394_1.time_ - var_397_6) / var_397_16

				arg_394_1.typewritter:SetDirty()
			end

			if arg_394_1.time_ >= var_397_6 + var_397_16 and arg_394_1.time_ < var_397_6 + var_397_16 + arg_397_0 then
				arg_394_1.typewritter.percent = 1

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(true)
			end
		end

		arg_394_1.nodeConfigList_ = {}

		arg_394_1:InitPlayNodeList()
	end,
	Play411051095 = function(arg_398_0, arg_398_1)
		arg_398_1.time_ = 0
		arg_398_1.frameCnt_ = 0
		arg_398_1.state_ = "playing"
		arg_398_1.curTalkId_ = 411051095
		arg_398_1.duration_ = 7.43

		local var_398_0 = {
			zh = 5.533,
			ja = 7.433
		}
		local var_398_1 = manager.audio:GetLocalizationFlag()

		if var_398_0[var_398_1] ~= nil then
			arg_398_1.duration_ = var_398_0[var_398_1]
		end

		SetActive(arg_398_1.tipsGo_, false)

		function arg_398_1.onSingleLineFinish_()
			arg_398_1.onSingleLineUpdate_ = nil
			arg_398_1.onSingleLineFinish_ = nil
			arg_398_1.state_ = "waiting"
		end

		function arg_398_1.playNext_(arg_400_0)
			if arg_400_0 == 1 then
				arg_398_0:Play411051096(arg_398_1)
			end
		end

		function arg_398_1.onSingleLineUpdate_(arg_401_0)
			local var_401_0 = arg_398_1.actors_["1095ui_story"]
			local var_401_1 = 0

			if var_401_1 < arg_398_1.time_ and arg_398_1.time_ <= var_401_1 + arg_401_0 and not isNil(var_401_0) and arg_398_1.var_.characterEffect1095ui_story == nil then
				arg_398_1.var_.characterEffect1095ui_story = var_401_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_401_2 = 0.200000002980232

			if var_401_1 <= arg_398_1.time_ and arg_398_1.time_ < var_401_1 + var_401_2 and not isNil(var_401_0) then
				local var_401_3 = (arg_398_1.time_ - var_401_1) / var_401_2

				if arg_398_1.var_.characterEffect1095ui_story and not isNil(var_401_0) then
					arg_398_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_398_1.time_ >= var_401_1 + var_401_2 and arg_398_1.time_ < var_401_1 + var_401_2 + arg_401_0 and not isNil(var_401_0) and arg_398_1.var_.characterEffect1095ui_story then
				arg_398_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_401_4 = 0
			local var_401_5 = 0.55

			if var_401_4 < arg_398_1.time_ and arg_398_1.time_ <= var_401_4 + arg_401_0 then
				arg_398_1.talkMaxDuration = 0
				arg_398_1.dialogCg_.alpha = 1

				arg_398_1.dialog_:SetActive(true)
				SetActive(arg_398_1.leftNameGo_, true)

				local var_401_6 = arg_398_1:FormatText(StoryNameCfg[471].name)

				arg_398_1.leftNameTxt_.text = var_401_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_398_1.leftNameTxt_.transform)

				arg_398_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_398_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_398_1:RecordName(arg_398_1.leftNameTxt_.text)
				SetActive(arg_398_1.iconTrs_.gameObject, false)
				arg_398_1.callingController_:SetSelectedState("normal")

				local var_401_7 = arg_398_1:GetWordFromCfg(411051095)
				local var_401_8 = arg_398_1:FormatText(var_401_7.content)

				arg_398_1.text_.text = var_401_8

				LuaForUtil.ClearLinePrefixSymbol(arg_398_1.text_)

				local var_401_9 = 22
				local var_401_10 = utf8.len(var_401_8)
				local var_401_11 = var_401_9 <= 0 and var_401_5 or var_401_5 * (var_401_10 / var_401_9)

				if var_401_11 > 0 and var_401_5 < var_401_11 then
					arg_398_1.talkMaxDuration = var_401_11

					if var_401_11 + var_401_4 > arg_398_1.duration_ then
						arg_398_1.duration_ = var_401_11 + var_401_4
					end
				end

				arg_398_1.text_.text = var_401_8
				arg_398_1.typewritter.percent = 0

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051095", "story_v_out_411051.awb") ~= 0 then
					local var_401_12 = manager.audio:GetVoiceLength("story_v_out_411051", "411051095", "story_v_out_411051.awb") / 1000

					if var_401_12 + var_401_4 > arg_398_1.duration_ then
						arg_398_1.duration_ = var_401_12 + var_401_4
					end

					if var_401_7.prefab_name ~= "" and arg_398_1.actors_[var_401_7.prefab_name] ~= nil then
						local var_401_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_398_1.actors_[var_401_7.prefab_name].transform, "story_v_out_411051", "411051095", "story_v_out_411051.awb")

						arg_398_1:RecordAudio("411051095", var_401_13)
						arg_398_1:RecordAudio("411051095", var_401_13)
					else
						arg_398_1:AudioAction("play", "voice", "story_v_out_411051", "411051095", "story_v_out_411051.awb")
					end

					arg_398_1:RecordHistoryTalkVoice("story_v_out_411051", "411051095", "story_v_out_411051.awb")
				end

				arg_398_1:RecordContent(arg_398_1.text_.text)
			end

			local var_401_14 = math.max(var_401_5, arg_398_1.talkMaxDuration)

			if var_401_4 <= arg_398_1.time_ and arg_398_1.time_ < var_401_4 + var_401_14 then
				arg_398_1.typewritter.percent = (arg_398_1.time_ - var_401_4) / var_401_14

				arg_398_1.typewritter:SetDirty()
			end

			if arg_398_1.time_ >= var_401_4 + var_401_14 and arg_398_1.time_ < var_401_4 + var_401_14 + arg_401_0 then
				arg_398_1.typewritter.percent = 1

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(true)
			end
		end

		arg_398_1.nodeConfigList_ = {}

		arg_398_1:InitPlayNodeList()
	end,
	Play411051096 = function(arg_402_0, arg_402_1)
		arg_402_1.time_ = 0
		arg_402_1.frameCnt_ = 0
		arg_402_1.state_ = "playing"
		arg_402_1.curTalkId_ = 411051096
		arg_402_1.duration_ = 3

		local var_402_0 = {
			zh = 1.4,
			ja = 3
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
				arg_402_0:Play411051097(arg_402_1)
			end
		end

		function arg_402_1.onSingleLineUpdate_(arg_405_0)
			local var_405_0 = arg_402_1.actors_["1095ui_story"]
			local var_405_1 = 0

			if var_405_1 < arg_402_1.time_ and arg_402_1.time_ <= var_405_1 + arg_405_0 and not isNil(var_405_0) and arg_402_1.var_.characterEffect1095ui_story == nil then
				arg_402_1.var_.characterEffect1095ui_story = var_405_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_405_2 = 0.200000002980232

			if var_405_1 <= arg_402_1.time_ and arg_402_1.time_ < var_405_1 + var_405_2 and not isNil(var_405_0) then
				local var_405_3 = (arg_402_1.time_ - var_405_1) / var_405_2

				if arg_402_1.var_.characterEffect1095ui_story and not isNil(var_405_0) then
					local var_405_4 = Mathf.Lerp(0, 0.5, var_405_3)

					arg_402_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_402_1.var_.characterEffect1095ui_story.fillRatio = var_405_4
				end
			end

			if arg_402_1.time_ >= var_405_1 + var_405_2 and arg_402_1.time_ < var_405_1 + var_405_2 + arg_405_0 and not isNil(var_405_0) and arg_402_1.var_.characterEffect1095ui_story then
				local var_405_5 = 0.5

				arg_402_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_402_1.var_.characterEffect1095ui_story.fillRatio = var_405_5
			end

			local var_405_6 = 0
			local var_405_7 = 0.175

			if var_405_6 < arg_402_1.time_ and arg_402_1.time_ <= var_405_6 + arg_405_0 then
				arg_402_1.talkMaxDuration = 0
				arg_402_1.dialogCg_.alpha = 1

				arg_402_1.dialog_:SetActive(true)
				SetActive(arg_402_1.leftNameGo_, true)

				local var_405_8 = arg_402_1:FormatText(StoryNameCfg[39].name)

				arg_402_1.leftNameTxt_.text = var_405_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_402_1.leftNameTxt_.transform)

				arg_402_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_402_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_402_1:RecordName(arg_402_1.leftNameTxt_.text)
				SetActive(arg_402_1.iconTrs_.gameObject, true)
				arg_402_1.iconController_:SetSelectedState("hero")

				arg_402_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10002a")

				arg_402_1.callingController_:SetSelectedState("normal")

				arg_402_1.keyicon_.color = Color.New(1, 1, 1)
				arg_402_1.icon_.color = Color.New(1, 1, 1)

				local var_405_9 = arg_402_1:GetWordFromCfg(411051096)
				local var_405_10 = arg_402_1:FormatText(var_405_9.content)

				arg_402_1.text_.text = var_405_10

				LuaForUtil.ClearLinePrefixSymbol(arg_402_1.text_)

				local var_405_11 = 7
				local var_405_12 = utf8.len(var_405_10)
				local var_405_13 = var_405_11 <= 0 and var_405_7 or var_405_7 * (var_405_12 / var_405_11)

				if var_405_13 > 0 and var_405_7 < var_405_13 then
					arg_402_1.talkMaxDuration = var_405_13

					if var_405_13 + var_405_6 > arg_402_1.duration_ then
						arg_402_1.duration_ = var_405_13 + var_405_6
					end
				end

				arg_402_1.text_.text = var_405_10
				arg_402_1.typewritter.percent = 0

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051096", "story_v_out_411051.awb") ~= 0 then
					local var_405_14 = manager.audio:GetVoiceLength("story_v_out_411051", "411051096", "story_v_out_411051.awb") / 1000

					if var_405_14 + var_405_6 > arg_402_1.duration_ then
						arg_402_1.duration_ = var_405_14 + var_405_6
					end

					if var_405_9.prefab_name ~= "" and arg_402_1.actors_[var_405_9.prefab_name] ~= nil then
						local var_405_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_402_1.actors_[var_405_9.prefab_name].transform, "story_v_out_411051", "411051096", "story_v_out_411051.awb")

						arg_402_1:RecordAudio("411051096", var_405_15)
						arg_402_1:RecordAudio("411051096", var_405_15)
					else
						arg_402_1:AudioAction("play", "voice", "story_v_out_411051", "411051096", "story_v_out_411051.awb")
					end

					arg_402_1:RecordHistoryTalkVoice("story_v_out_411051", "411051096", "story_v_out_411051.awb")
				end

				arg_402_1:RecordContent(arg_402_1.text_.text)
			end

			local var_405_16 = math.max(var_405_7, arg_402_1.talkMaxDuration)

			if var_405_6 <= arg_402_1.time_ and arg_402_1.time_ < var_405_6 + var_405_16 then
				arg_402_1.typewritter.percent = (arg_402_1.time_ - var_405_6) / var_405_16

				arg_402_1.typewritter:SetDirty()
			end

			if arg_402_1.time_ >= var_405_6 + var_405_16 and arg_402_1.time_ < var_405_6 + var_405_16 + arg_405_0 then
				arg_402_1.typewritter.percent = 1

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(true)
			end
		end

		arg_402_1.nodeConfigList_ = {}

		arg_402_1:InitPlayNodeList()
	end,
	Play411051097 = function(arg_406_0, arg_406_1)
		arg_406_1.time_ = 0
		arg_406_1.frameCnt_ = 0
		arg_406_1.state_ = "playing"
		arg_406_1.curTalkId_ = 411051097
		arg_406_1.duration_ = 6.03

		local var_406_0 = {
			zh = 5.033,
			ja = 6.033
		}
		local var_406_1 = manager.audio:GetLocalizationFlag()

		if var_406_0[var_406_1] ~= nil then
			arg_406_1.duration_ = var_406_0[var_406_1]
		end

		SetActive(arg_406_1.tipsGo_, false)

		function arg_406_1.onSingleLineFinish_()
			arg_406_1.onSingleLineUpdate_ = nil
			arg_406_1.onSingleLineFinish_ = nil
			arg_406_1.state_ = "waiting"
		end

		function arg_406_1.playNext_(arg_408_0)
			if arg_408_0 == 1 then
				arg_406_0:Play411051098(arg_406_1)
			end
		end

		function arg_406_1.onSingleLineUpdate_(arg_409_0)
			local var_409_0 = arg_406_1.actors_["1095ui_story"]
			local var_409_1 = 0

			if var_409_1 < arg_406_1.time_ and arg_406_1.time_ <= var_409_1 + arg_409_0 and not isNil(var_409_0) and arg_406_1.var_.characterEffect1095ui_story == nil then
				arg_406_1.var_.characterEffect1095ui_story = var_409_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_409_2 = 0.200000002980232

			if var_409_1 <= arg_406_1.time_ and arg_406_1.time_ < var_409_1 + var_409_2 and not isNil(var_409_0) then
				local var_409_3 = (arg_406_1.time_ - var_409_1) / var_409_2

				if arg_406_1.var_.characterEffect1095ui_story and not isNil(var_409_0) then
					arg_406_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_406_1.time_ >= var_409_1 + var_409_2 and arg_406_1.time_ < var_409_1 + var_409_2 + arg_409_0 and not isNil(var_409_0) and arg_406_1.var_.characterEffect1095ui_story then
				arg_406_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_409_4 = 0
			local var_409_5 = 0.65

			if var_409_4 < arg_406_1.time_ and arg_406_1.time_ <= var_409_4 + arg_409_0 then
				arg_406_1.talkMaxDuration = 0
				arg_406_1.dialogCg_.alpha = 1

				arg_406_1.dialog_:SetActive(true)
				SetActive(arg_406_1.leftNameGo_, true)

				local var_409_6 = arg_406_1:FormatText(StoryNameCfg[471].name)

				arg_406_1.leftNameTxt_.text = var_409_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_406_1.leftNameTxt_.transform)

				arg_406_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_406_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_406_1:RecordName(arg_406_1.leftNameTxt_.text)
				SetActive(arg_406_1.iconTrs_.gameObject, false)
				arg_406_1.callingController_:SetSelectedState("normal")

				local var_409_7 = arg_406_1:GetWordFromCfg(411051097)
				local var_409_8 = arg_406_1:FormatText(var_409_7.content)

				arg_406_1.text_.text = var_409_8

				LuaForUtil.ClearLinePrefixSymbol(arg_406_1.text_)

				local var_409_9 = 26
				local var_409_10 = utf8.len(var_409_8)
				local var_409_11 = var_409_9 <= 0 and var_409_5 or var_409_5 * (var_409_10 / var_409_9)

				if var_409_11 > 0 and var_409_5 < var_409_11 then
					arg_406_1.talkMaxDuration = var_409_11

					if var_409_11 + var_409_4 > arg_406_1.duration_ then
						arg_406_1.duration_ = var_409_11 + var_409_4
					end
				end

				arg_406_1.text_.text = var_409_8
				arg_406_1.typewritter.percent = 0

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051097", "story_v_out_411051.awb") ~= 0 then
					local var_409_12 = manager.audio:GetVoiceLength("story_v_out_411051", "411051097", "story_v_out_411051.awb") / 1000

					if var_409_12 + var_409_4 > arg_406_1.duration_ then
						arg_406_1.duration_ = var_409_12 + var_409_4
					end

					if var_409_7.prefab_name ~= "" and arg_406_1.actors_[var_409_7.prefab_name] ~= nil then
						local var_409_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_406_1.actors_[var_409_7.prefab_name].transform, "story_v_out_411051", "411051097", "story_v_out_411051.awb")

						arg_406_1:RecordAudio("411051097", var_409_13)
						arg_406_1:RecordAudio("411051097", var_409_13)
					else
						arg_406_1:AudioAction("play", "voice", "story_v_out_411051", "411051097", "story_v_out_411051.awb")
					end

					arg_406_1:RecordHistoryTalkVoice("story_v_out_411051", "411051097", "story_v_out_411051.awb")
				end

				arg_406_1:RecordContent(arg_406_1.text_.text)
			end

			local var_409_14 = math.max(var_409_5, arg_406_1.talkMaxDuration)

			if var_409_4 <= arg_406_1.time_ and arg_406_1.time_ < var_409_4 + var_409_14 then
				arg_406_1.typewritter.percent = (arg_406_1.time_ - var_409_4) / var_409_14

				arg_406_1.typewritter:SetDirty()
			end

			if arg_406_1.time_ >= var_409_4 + var_409_14 and arg_406_1.time_ < var_409_4 + var_409_14 + arg_409_0 then
				arg_406_1.typewritter.percent = 1

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(true)
			end
		end

		arg_406_1.nodeConfigList_ = {}

		arg_406_1:InitPlayNodeList()
	end,
	Play411051098 = function(arg_410_0, arg_410_1)
		arg_410_1.time_ = 0
		arg_410_1.frameCnt_ = 0
		arg_410_1.state_ = "playing"
		arg_410_1.curTalkId_ = 411051098
		arg_410_1.duration_ = 11.17

		local var_410_0 = {
			zh = 10.2,
			ja = 11.166
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
				arg_410_0:Play411051099(arg_410_1)
			end
		end

		function arg_410_1.onSingleLineUpdate_(arg_413_0)
			local var_413_0 = 0
			local var_413_1 = 1.3

			if var_413_0 < arg_410_1.time_ and arg_410_1.time_ <= var_413_0 + arg_413_0 then
				arg_410_1.talkMaxDuration = 0
				arg_410_1.dialogCg_.alpha = 1

				arg_410_1.dialog_:SetActive(true)
				SetActive(arg_410_1.leftNameGo_, true)

				local var_413_2 = arg_410_1:FormatText(StoryNameCfg[471].name)

				arg_410_1.leftNameTxt_.text = var_413_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_410_1.leftNameTxt_.transform)

				arg_410_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_410_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_410_1:RecordName(arg_410_1.leftNameTxt_.text)
				SetActive(arg_410_1.iconTrs_.gameObject, false)
				arg_410_1.callingController_:SetSelectedState("normal")

				local var_413_3 = arg_410_1:GetWordFromCfg(411051098)
				local var_413_4 = arg_410_1:FormatText(var_413_3.content)

				arg_410_1.text_.text = var_413_4

				LuaForUtil.ClearLinePrefixSymbol(arg_410_1.text_)

				local var_413_5 = 52
				local var_413_6 = utf8.len(var_413_4)
				local var_413_7 = var_413_5 <= 0 and var_413_1 or var_413_1 * (var_413_6 / var_413_5)

				if var_413_7 > 0 and var_413_1 < var_413_7 then
					arg_410_1.talkMaxDuration = var_413_7

					if var_413_7 + var_413_0 > arg_410_1.duration_ then
						arg_410_1.duration_ = var_413_7 + var_413_0
					end
				end

				arg_410_1.text_.text = var_413_4
				arg_410_1.typewritter.percent = 0

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051098", "story_v_out_411051.awb") ~= 0 then
					local var_413_8 = manager.audio:GetVoiceLength("story_v_out_411051", "411051098", "story_v_out_411051.awb") / 1000

					if var_413_8 + var_413_0 > arg_410_1.duration_ then
						arg_410_1.duration_ = var_413_8 + var_413_0
					end

					if var_413_3.prefab_name ~= "" and arg_410_1.actors_[var_413_3.prefab_name] ~= nil then
						local var_413_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_410_1.actors_[var_413_3.prefab_name].transform, "story_v_out_411051", "411051098", "story_v_out_411051.awb")

						arg_410_1:RecordAudio("411051098", var_413_9)
						arg_410_1:RecordAudio("411051098", var_413_9)
					else
						arg_410_1:AudioAction("play", "voice", "story_v_out_411051", "411051098", "story_v_out_411051.awb")
					end

					arg_410_1:RecordHistoryTalkVoice("story_v_out_411051", "411051098", "story_v_out_411051.awb")
				end

				arg_410_1:RecordContent(arg_410_1.text_.text)
			end

			local var_413_10 = math.max(var_413_1, arg_410_1.talkMaxDuration)

			if var_413_0 <= arg_410_1.time_ and arg_410_1.time_ < var_413_0 + var_413_10 then
				arg_410_1.typewritter.percent = (arg_410_1.time_ - var_413_0) / var_413_10

				arg_410_1.typewritter:SetDirty()
			end

			if arg_410_1.time_ >= var_413_0 + var_413_10 and arg_410_1.time_ < var_413_0 + var_413_10 + arg_413_0 then
				arg_410_1.typewritter.percent = 1

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(true)
			end
		end

		arg_410_1.nodeConfigList_ = {}

		arg_410_1:InitPlayNodeList()
	end,
	Play411051099 = function(arg_414_0, arg_414_1)
		arg_414_1.time_ = 0
		arg_414_1.frameCnt_ = 0
		arg_414_1.state_ = "playing"
		arg_414_1.curTalkId_ = 411051099
		arg_414_1.duration_ = 10.53

		local var_414_0 = {
			zh = 10.533,
			ja = 7
		}
		local var_414_1 = manager.audio:GetLocalizationFlag()

		if var_414_0[var_414_1] ~= nil then
			arg_414_1.duration_ = var_414_0[var_414_1]
		end

		SetActive(arg_414_1.tipsGo_, false)

		function arg_414_1.onSingleLineFinish_()
			arg_414_1.onSingleLineUpdate_ = nil
			arg_414_1.onSingleLineFinish_ = nil
			arg_414_1.state_ = "waiting"
		end

		function arg_414_1.playNext_(arg_416_0)
			if arg_416_0 == 1 then
				arg_414_0:Play411051100(arg_414_1)
			end
		end

		function arg_414_1.onSingleLineUpdate_(arg_417_0)
			local var_417_0 = 0
			local var_417_1 = 1.275

			if var_417_0 < arg_414_1.time_ and arg_414_1.time_ <= var_417_0 + arg_417_0 then
				arg_414_1.talkMaxDuration = 0
				arg_414_1.dialogCg_.alpha = 1

				arg_414_1.dialog_:SetActive(true)
				SetActive(arg_414_1.leftNameGo_, true)

				local var_417_2 = arg_414_1:FormatText(StoryNameCfg[471].name)

				arg_414_1.leftNameTxt_.text = var_417_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_414_1.leftNameTxt_.transform)

				arg_414_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_414_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_414_1:RecordName(arg_414_1.leftNameTxt_.text)
				SetActive(arg_414_1.iconTrs_.gameObject, false)
				arg_414_1.callingController_:SetSelectedState("normal")

				local var_417_3 = arg_414_1:GetWordFromCfg(411051099)
				local var_417_4 = arg_414_1:FormatText(var_417_3.content)

				arg_414_1.text_.text = var_417_4

				LuaForUtil.ClearLinePrefixSymbol(arg_414_1.text_)

				local var_417_5 = 51
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

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051099", "story_v_out_411051.awb") ~= 0 then
					local var_417_8 = manager.audio:GetVoiceLength("story_v_out_411051", "411051099", "story_v_out_411051.awb") / 1000

					if var_417_8 + var_417_0 > arg_414_1.duration_ then
						arg_414_1.duration_ = var_417_8 + var_417_0
					end

					if var_417_3.prefab_name ~= "" and arg_414_1.actors_[var_417_3.prefab_name] ~= nil then
						local var_417_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_414_1.actors_[var_417_3.prefab_name].transform, "story_v_out_411051", "411051099", "story_v_out_411051.awb")

						arg_414_1:RecordAudio("411051099", var_417_9)
						arg_414_1:RecordAudio("411051099", var_417_9)
					else
						arg_414_1:AudioAction("play", "voice", "story_v_out_411051", "411051099", "story_v_out_411051.awb")
					end

					arg_414_1:RecordHistoryTalkVoice("story_v_out_411051", "411051099", "story_v_out_411051.awb")
				end

				arg_414_1:RecordContent(arg_414_1.text_.text)
			end

			local var_417_10 = math.max(var_417_1, arg_414_1.talkMaxDuration)

			if var_417_0 <= arg_414_1.time_ and arg_414_1.time_ < var_417_0 + var_417_10 then
				arg_414_1.typewritter.percent = (arg_414_1.time_ - var_417_0) / var_417_10

				arg_414_1.typewritter:SetDirty()
			end

			if arg_414_1.time_ >= var_417_0 + var_417_10 and arg_414_1.time_ < var_417_0 + var_417_10 + arg_417_0 then
				arg_414_1.typewritter.percent = 1

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(true)
			end
		end

		arg_414_1.nodeConfigList_ = {}

		arg_414_1:InitPlayNodeList()
	end,
	Play411051100 = function(arg_418_0, arg_418_1)
		arg_418_1.time_ = 0
		arg_418_1.frameCnt_ = 0
		arg_418_1.state_ = "playing"
		arg_418_1.curTalkId_ = 411051100
		arg_418_1.duration_ = 5.9

		local var_418_0 = {
			zh = 5.9,
			ja = 5.433
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
				arg_418_0:Play411051101(arg_418_1)
			end
		end

		function arg_418_1.onSingleLineUpdate_(arg_421_0)
			local var_421_0 = arg_418_1.actors_["1095ui_story"].transform
			local var_421_1 = 0

			if var_421_1 < arg_418_1.time_ and arg_418_1.time_ <= var_421_1 + arg_421_0 then
				arg_418_1.var_.moveOldPos1095ui_story = var_421_0.localPosition
			end

			local var_421_2 = 0.001

			if var_421_1 <= arg_418_1.time_ and arg_418_1.time_ < var_421_1 + var_421_2 then
				local var_421_3 = (arg_418_1.time_ - var_421_1) / var_421_2
				local var_421_4 = Vector3.New(0, -0.98, -6.1)

				var_421_0.localPosition = Vector3.Lerp(arg_418_1.var_.moveOldPos1095ui_story, var_421_4, var_421_3)

				local var_421_5 = manager.ui.mainCamera.transform.position - var_421_0.position

				var_421_0.forward = Vector3.New(var_421_5.x, var_421_5.y, var_421_5.z)

				local var_421_6 = var_421_0.localEulerAngles

				var_421_6.z = 0
				var_421_6.x = 0
				var_421_0.localEulerAngles = var_421_6
			end

			if arg_418_1.time_ >= var_421_1 + var_421_2 and arg_418_1.time_ < var_421_1 + var_421_2 + arg_421_0 then
				var_421_0.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_421_7 = manager.ui.mainCamera.transform.position - var_421_0.position

				var_421_0.forward = Vector3.New(var_421_7.x, var_421_7.y, var_421_7.z)

				local var_421_8 = var_421_0.localEulerAngles

				var_421_8.z = 0
				var_421_8.x = 0
				var_421_0.localEulerAngles = var_421_8
			end

			local var_421_9 = arg_418_1.actors_["1095ui_story"]
			local var_421_10 = 0

			if var_421_10 < arg_418_1.time_ and arg_418_1.time_ <= var_421_10 + arg_421_0 and not isNil(var_421_9) and arg_418_1.var_.characterEffect1095ui_story == nil then
				arg_418_1.var_.characterEffect1095ui_story = var_421_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_421_11 = 0.200000002980232

			if var_421_10 <= arg_418_1.time_ and arg_418_1.time_ < var_421_10 + var_421_11 and not isNil(var_421_9) then
				local var_421_12 = (arg_418_1.time_ - var_421_10) / var_421_11

				if arg_418_1.var_.characterEffect1095ui_story and not isNil(var_421_9) then
					arg_418_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_418_1.time_ >= var_421_10 + var_421_11 and arg_418_1.time_ < var_421_10 + var_421_11 + arg_421_0 and not isNil(var_421_9) and arg_418_1.var_.characterEffect1095ui_story then
				arg_418_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_421_13 = 0

			if var_421_13 < arg_418_1.time_ and arg_418_1.time_ <= var_421_13 + arg_421_0 then
				arg_418_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095actionlink/1095action436")
			end

			local var_421_14 = 0

			if var_421_14 < arg_418_1.time_ and arg_418_1.time_ <= var_421_14 + arg_421_0 then
				arg_418_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_421_15 = 0
			local var_421_16 = 0.7

			if var_421_15 < arg_418_1.time_ and arg_418_1.time_ <= var_421_15 + arg_421_0 then
				arg_418_1.talkMaxDuration = 0
				arg_418_1.dialogCg_.alpha = 1

				arg_418_1.dialog_:SetActive(true)
				SetActive(arg_418_1.leftNameGo_, true)

				local var_421_17 = arg_418_1:FormatText(StoryNameCfg[471].name)

				arg_418_1.leftNameTxt_.text = var_421_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_418_1.leftNameTxt_.transform)

				arg_418_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_418_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_418_1:RecordName(arg_418_1.leftNameTxt_.text)
				SetActive(arg_418_1.iconTrs_.gameObject, false)
				arg_418_1.callingController_:SetSelectedState("normal")

				local var_421_18 = arg_418_1:GetWordFromCfg(411051100)
				local var_421_19 = arg_418_1:FormatText(var_421_18.content)

				arg_418_1.text_.text = var_421_19

				LuaForUtil.ClearLinePrefixSymbol(arg_418_1.text_)

				local var_421_20 = 28
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

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051100", "story_v_out_411051.awb") ~= 0 then
					local var_421_23 = manager.audio:GetVoiceLength("story_v_out_411051", "411051100", "story_v_out_411051.awb") / 1000

					if var_421_23 + var_421_15 > arg_418_1.duration_ then
						arg_418_1.duration_ = var_421_23 + var_421_15
					end

					if var_421_18.prefab_name ~= "" and arg_418_1.actors_[var_421_18.prefab_name] ~= nil then
						local var_421_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_418_1.actors_[var_421_18.prefab_name].transform, "story_v_out_411051", "411051100", "story_v_out_411051.awb")

						arg_418_1:RecordAudio("411051100", var_421_24)
						arg_418_1:RecordAudio("411051100", var_421_24)
					else
						arg_418_1:AudioAction("play", "voice", "story_v_out_411051", "411051100", "story_v_out_411051.awb")
					end

					arg_418_1:RecordHistoryTalkVoice("story_v_out_411051", "411051100", "story_v_out_411051.awb")
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
				actorName = "1095ui_story",
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
	Play411051101 = function(arg_422_0, arg_422_1)
		arg_422_1.time_ = 0
		arg_422_1.frameCnt_ = 0
		arg_422_1.state_ = "playing"
		arg_422_1.curTalkId_ = 411051101
		arg_422_1.duration_ = 1.7

		local var_422_0 = {
			zh = 0.999999999999,
			ja = 1.7
		}
		local var_422_1 = manager.audio:GetLocalizationFlag()

		if var_422_0[var_422_1] ~= nil then
			arg_422_1.duration_ = var_422_0[var_422_1]
		end

		SetActive(arg_422_1.tipsGo_, false)

		function arg_422_1.onSingleLineFinish_()
			arg_422_1.onSingleLineUpdate_ = nil
			arg_422_1.onSingleLineFinish_ = nil
			arg_422_1.state_ = "waiting"
		end

		function arg_422_1.playNext_(arg_424_0)
			if arg_424_0 == 1 then
				arg_422_0:Play411051102(arg_422_1)
			end
		end

		function arg_422_1.onSingleLineUpdate_(arg_425_0)
			local var_425_0 = arg_422_1.actors_["1095ui_story"]
			local var_425_1 = 0

			if var_425_1 < arg_422_1.time_ and arg_422_1.time_ <= var_425_1 + arg_425_0 and not isNil(var_425_0) and arg_422_1.var_.characterEffect1095ui_story == nil then
				arg_422_1.var_.characterEffect1095ui_story = var_425_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_425_2 = 0.200000002980232

			if var_425_1 <= arg_422_1.time_ and arg_422_1.time_ < var_425_1 + var_425_2 and not isNil(var_425_0) then
				local var_425_3 = (arg_422_1.time_ - var_425_1) / var_425_2

				if arg_422_1.var_.characterEffect1095ui_story and not isNil(var_425_0) then
					local var_425_4 = Mathf.Lerp(0, 0.5, var_425_3)

					arg_422_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_422_1.var_.characterEffect1095ui_story.fillRatio = var_425_4
				end
			end

			if arg_422_1.time_ >= var_425_1 + var_425_2 and arg_422_1.time_ < var_425_1 + var_425_2 + arg_425_0 and not isNil(var_425_0) and arg_422_1.var_.characterEffect1095ui_story then
				local var_425_5 = 0.5

				arg_422_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_422_1.var_.characterEffect1095ui_story.fillRatio = var_425_5
			end

			local var_425_6 = 0
			local var_425_7 = 0.075

			if var_425_6 < arg_422_1.time_ and arg_422_1.time_ <= var_425_6 + arg_425_0 then
				arg_422_1.talkMaxDuration = 0
				arg_422_1.dialogCg_.alpha = 1

				arg_422_1.dialog_:SetActive(true)
				SetActive(arg_422_1.leftNameGo_, true)

				local var_425_8 = arg_422_1:FormatText(StoryNameCfg[39].name)

				arg_422_1.leftNameTxt_.text = var_425_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_422_1.leftNameTxt_.transform)

				arg_422_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_422_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_422_1:RecordName(arg_422_1.leftNameTxt_.text)
				SetActive(arg_422_1.iconTrs_.gameObject, true)
				arg_422_1.iconController_:SetSelectedState("hero")

				arg_422_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10002a")

				arg_422_1.callingController_:SetSelectedState("normal")

				arg_422_1.keyicon_.color = Color.New(1, 1, 1)
				arg_422_1.icon_.color = Color.New(1, 1, 1)

				local var_425_9 = arg_422_1:GetWordFromCfg(411051101)
				local var_425_10 = arg_422_1:FormatText(var_425_9.content)

				arg_422_1.text_.text = var_425_10

				LuaForUtil.ClearLinePrefixSymbol(arg_422_1.text_)

				local var_425_11 = 3
				local var_425_12 = utf8.len(var_425_10)
				local var_425_13 = var_425_11 <= 0 and var_425_7 or var_425_7 * (var_425_12 / var_425_11)

				if var_425_13 > 0 and var_425_7 < var_425_13 then
					arg_422_1.talkMaxDuration = var_425_13

					if var_425_13 + var_425_6 > arg_422_1.duration_ then
						arg_422_1.duration_ = var_425_13 + var_425_6
					end
				end

				arg_422_1.text_.text = var_425_10
				arg_422_1.typewritter.percent = 0

				arg_422_1.typewritter:SetDirty()
				arg_422_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051101", "story_v_out_411051.awb") ~= 0 then
					local var_425_14 = manager.audio:GetVoiceLength("story_v_out_411051", "411051101", "story_v_out_411051.awb") / 1000

					if var_425_14 + var_425_6 > arg_422_1.duration_ then
						arg_422_1.duration_ = var_425_14 + var_425_6
					end

					if var_425_9.prefab_name ~= "" and arg_422_1.actors_[var_425_9.prefab_name] ~= nil then
						local var_425_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_422_1.actors_[var_425_9.prefab_name].transform, "story_v_out_411051", "411051101", "story_v_out_411051.awb")

						arg_422_1:RecordAudio("411051101", var_425_15)
						arg_422_1:RecordAudio("411051101", var_425_15)
					else
						arg_422_1:AudioAction("play", "voice", "story_v_out_411051", "411051101", "story_v_out_411051.awb")
					end

					arg_422_1:RecordHistoryTalkVoice("story_v_out_411051", "411051101", "story_v_out_411051.awb")
				end

				arg_422_1:RecordContent(arg_422_1.text_.text)
			end

			local var_425_16 = math.max(var_425_7, arg_422_1.talkMaxDuration)

			if var_425_6 <= arg_422_1.time_ and arg_422_1.time_ < var_425_6 + var_425_16 then
				arg_422_1.typewritter.percent = (arg_422_1.time_ - var_425_6) / var_425_16

				arg_422_1.typewritter:SetDirty()
			end

			if arg_422_1.time_ >= var_425_6 + var_425_16 and arg_422_1.time_ < var_425_6 + var_425_16 + arg_425_0 then
				arg_422_1.typewritter.percent = 1

				arg_422_1.typewritter:SetDirty()
				arg_422_1:ShowNextGo(true)
			end
		end

		arg_422_1.nodeConfigList_ = {}

		arg_422_1:InitPlayNodeList()
	end,
	Play411051102 = function(arg_426_0, arg_426_1)
		arg_426_1.time_ = 0
		arg_426_1.frameCnt_ = 0
		arg_426_1.state_ = "playing"
		arg_426_1.curTalkId_ = 411051102
		arg_426_1.duration_ = 11.47

		local var_426_0 = {
			zh = 7.866,
			ja = 11.466
		}
		local var_426_1 = manager.audio:GetLocalizationFlag()

		if var_426_0[var_426_1] ~= nil then
			arg_426_1.duration_ = var_426_0[var_426_1]
		end

		SetActive(arg_426_1.tipsGo_, false)

		function arg_426_1.onSingleLineFinish_()
			arg_426_1.onSingleLineUpdate_ = nil
			arg_426_1.onSingleLineFinish_ = nil
			arg_426_1.state_ = "waiting"
		end

		function arg_426_1.playNext_(arg_428_0)
			if arg_428_0 == 1 then
				arg_426_0:Play411051103(arg_426_1)
			end
		end

		function arg_426_1.onSingleLineUpdate_(arg_429_0)
			local var_429_0 = arg_426_1.actors_["1095ui_story"]
			local var_429_1 = 0

			if var_429_1 < arg_426_1.time_ and arg_426_1.time_ <= var_429_1 + arg_429_0 and not isNil(var_429_0) and arg_426_1.var_.characterEffect1095ui_story == nil then
				arg_426_1.var_.characterEffect1095ui_story = var_429_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_429_2 = 0.200000002980232

			if var_429_1 <= arg_426_1.time_ and arg_426_1.time_ < var_429_1 + var_429_2 and not isNil(var_429_0) then
				local var_429_3 = (arg_426_1.time_ - var_429_1) / var_429_2

				if arg_426_1.var_.characterEffect1095ui_story and not isNil(var_429_0) then
					arg_426_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_426_1.time_ >= var_429_1 + var_429_2 and arg_426_1.time_ < var_429_1 + var_429_2 + arg_429_0 and not isNil(var_429_0) and arg_426_1.var_.characterEffect1095ui_story then
				arg_426_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_429_4 = 0
			local var_429_5 = 0.9

			if var_429_4 < arg_426_1.time_ and arg_426_1.time_ <= var_429_4 + arg_429_0 then
				arg_426_1.talkMaxDuration = 0
				arg_426_1.dialogCg_.alpha = 1

				arg_426_1.dialog_:SetActive(true)
				SetActive(arg_426_1.leftNameGo_, true)

				local var_429_6 = arg_426_1:FormatText(StoryNameCfg[471].name)

				arg_426_1.leftNameTxt_.text = var_429_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_426_1.leftNameTxt_.transform)

				arg_426_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_426_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_426_1:RecordName(arg_426_1.leftNameTxt_.text)
				SetActive(arg_426_1.iconTrs_.gameObject, false)
				arg_426_1.callingController_:SetSelectedState("normal")

				local var_429_7 = arg_426_1:GetWordFromCfg(411051102)
				local var_429_8 = arg_426_1:FormatText(var_429_7.content)

				arg_426_1.text_.text = var_429_8

				LuaForUtil.ClearLinePrefixSymbol(arg_426_1.text_)

				local var_429_9 = 36
				local var_429_10 = utf8.len(var_429_8)
				local var_429_11 = var_429_9 <= 0 and var_429_5 or var_429_5 * (var_429_10 / var_429_9)

				if var_429_11 > 0 and var_429_5 < var_429_11 then
					arg_426_1.talkMaxDuration = var_429_11

					if var_429_11 + var_429_4 > arg_426_1.duration_ then
						arg_426_1.duration_ = var_429_11 + var_429_4
					end
				end

				arg_426_1.text_.text = var_429_8
				arg_426_1.typewritter.percent = 0

				arg_426_1.typewritter:SetDirty()
				arg_426_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051102", "story_v_out_411051.awb") ~= 0 then
					local var_429_12 = manager.audio:GetVoiceLength("story_v_out_411051", "411051102", "story_v_out_411051.awb") / 1000

					if var_429_12 + var_429_4 > arg_426_1.duration_ then
						arg_426_1.duration_ = var_429_12 + var_429_4
					end

					if var_429_7.prefab_name ~= "" and arg_426_1.actors_[var_429_7.prefab_name] ~= nil then
						local var_429_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_426_1.actors_[var_429_7.prefab_name].transform, "story_v_out_411051", "411051102", "story_v_out_411051.awb")

						arg_426_1:RecordAudio("411051102", var_429_13)
						arg_426_1:RecordAudio("411051102", var_429_13)
					else
						arg_426_1:AudioAction("play", "voice", "story_v_out_411051", "411051102", "story_v_out_411051.awb")
					end

					arg_426_1:RecordHistoryTalkVoice("story_v_out_411051", "411051102", "story_v_out_411051.awb")
				end

				arg_426_1:RecordContent(arg_426_1.text_.text)
			end

			local var_429_14 = math.max(var_429_5, arg_426_1.talkMaxDuration)

			if var_429_4 <= arg_426_1.time_ and arg_426_1.time_ < var_429_4 + var_429_14 then
				arg_426_1.typewritter.percent = (arg_426_1.time_ - var_429_4) / var_429_14

				arg_426_1.typewritter:SetDirty()
			end

			if arg_426_1.time_ >= var_429_4 + var_429_14 and arg_426_1.time_ < var_429_4 + var_429_14 + arg_429_0 then
				arg_426_1.typewritter.percent = 1

				arg_426_1.typewritter:SetDirty()
				arg_426_1:ShowNextGo(true)
			end
		end

		arg_426_1.nodeConfigList_ = {}

		arg_426_1:InitPlayNodeList()
	end,
	Play411051103 = function(arg_430_0, arg_430_1)
		arg_430_1.time_ = 0
		arg_430_1.frameCnt_ = 0
		arg_430_1.state_ = "playing"
		arg_430_1.curTalkId_ = 411051103
		arg_430_1.duration_ = 8.8

		local var_430_0 = {
			zh = 8.8,
			ja = 4.566
		}
		local var_430_1 = manager.audio:GetLocalizationFlag()

		if var_430_0[var_430_1] ~= nil then
			arg_430_1.duration_ = var_430_0[var_430_1]
		end

		SetActive(arg_430_1.tipsGo_, false)

		function arg_430_1.onSingleLineFinish_()
			arg_430_1.onSingleLineUpdate_ = nil
			arg_430_1.onSingleLineFinish_ = nil
			arg_430_1.state_ = "waiting"
		end

		function arg_430_1.playNext_(arg_432_0)
			if arg_432_0 == 1 then
				arg_430_0:Play411051104(arg_430_1)
			end
		end

		function arg_430_1.onSingleLineUpdate_(arg_433_0)
			local var_433_0 = 0
			local var_433_1 = 0.85

			if var_433_0 < arg_430_1.time_ and arg_430_1.time_ <= var_433_0 + arg_433_0 then
				arg_430_1.talkMaxDuration = 0
				arg_430_1.dialogCg_.alpha = 1

				arg_430_1.dialog_:SetActive(true)
				SetActive(arg_430_1.leftNameGo_, true)

				local var_433_2 = arg_430_1:FormatText(StoryNameCfg[471].name)

				arg_430_1.leftNameTxt_.text = var_433_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_430_1.leftNameTxt_.transform)

				arg_430_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_430_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_430_1:RecordName(arg_430_1.leftNameTxt_.text)
				SetActive(arg_430_1.iconTrs_.gameObject, false)
				arg_430_1.callingController_:SetSelectedState("normal")

				local var_433_3 = arg_430_1:GetWordFromCfg(411051103)
				local var_433_4 = arg_430_1:FormatText(var_433_3.content)

				arg_430_1.text_.text = var_433_4

				LuaForUtil.ClearLinePrefixSymbol(arg_430_1.text_)

				local var_433_5 = 34
				local var_433_6 = utf8.len(var_433_4)
				local var_433_7 = var_433_5 <= 0 and var_433_1 or var_433_1 * (var_433_6 / var_433_5)

				if var_433_7 > 0 and var_433_1 < var_433_7 then
					arg_430_1.talkMaxDuration = var_433_7

					if var_433_7 + var_433_0 > arg_430_1.duration_ then
						arg_430_1.duration_ = var_433_7 + var_433_0
					end
				end

				arg_430_1.text_.text = var_433_4
				arg_430_1.typewritter.percent = 0

				arg_430_1.typewritter:SetDirty()
				arg_430_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051103", "story_v_out_411051.awb") ~= 0 then
					local var_433_8 = manager.audio:GetVoiceLength("story_v_out_411051", "411051103", "story_v_out_411051.awb") / 1000

					if var_433_8 + var_433_0 > arg_430_1.duration_ then
						arg_430_1.duration_ = var_433_8 + var_433_0
					end

					if var_433_3.prefab_name ~= "" and arg_430_1.actors_[var_433_3.prefab_name] ~= nil then
						local var_433_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_430_1.actors_[var_433_3.prefab_name].transform, "story_v_out_411051", "411051103", "story_v_out_411051.awb")

						arg_430_1:RecordAudio("411051103", var_433_9)
						arg_430_1:RecordAudio("411051103", var_433_9)
					else
						arg_430_1:AudioAction("play", "voice", "story_v_out_411051", "411051103", "story_v_out_411051.awb")
					end

					arg_430_1:RecordHistoryTalkVoice("story_v_out_411051", "411051103", "story_v_out_411051.awb")
				end

				arg_430_1:RecordContent(arg_430_1.text_.text)
			end

			local var_433_10 = math.max(var_433_1, arg_430_1.talkMaxDuration)

			if var_433_0 <= arg_430_1.time_ and arg_430_1.time_ < var_433_0 + var_433_10 then
				arg_430_1.typewritter.percent = (arg_430_1.time_ - var_433_0) / var_433_10

				arg_430_1.typewritter:SetDirty()
			end

			if arg_430_1.time_ >= var_433_0 + var_433_10 and arg_430_1.time_ < var_433_0 + var_433_10 + arg_433_0 then
				arg_430_1.typewritter.percent = 1

				arg_430_1.typewritter:SetDirty()
				arg_430_1:ShowNextGo(true)
			end
		end

		arg_430_1.nodeConfigList_ = {}

		arg_430_1:InitPlayNodeList()
	end,
	Play411051104 = function(arg_434_0, arg_434_1)
		arg_434_1.time_ = 0
		arg_434_1.frameCnt_ = 0
		arg_434_1.state_ = "playing"
		arg_434_1.curTalkId_ = 411051104
		arg_434_1.duration_ = 5

		SetActive(arg_434_1.tipsGo_, false)

		function arg_434_1.onSingleLineFinish_()
			arg_434_1.onSingleLineUpdate_ = nil
			arg_434_1.onSingleLineFinish_ = nil
			arg_434_1.state_ = "waiting"
		end

		function arg_434_1.playNext_(arg_436_0)
			if arg_436_0 == 1 then
				arg_434_0:Play411051105(arg_434_1)
			end
		end

		function arg_434_1.onSingleLineUpdate_(arg_437_0)
			local var_437_0 = arg_434_1.actors_["1095ui_story"]
			local var_437_1 = 0

			if var_437_1 < arg_434_1.time_ and arg_434_1.time_ <= var_437_1 + arg_437_0 and not isNil(var_437_0) and arg_434_1.var_.characterEffect1095ui_story == nil then
				arg_434_1.var_.characterEffect1095ui_story = var_437_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_437_2 = 0.200000002980232

			if var_437_1 <= arg_434_1.time_ and arg_434_1.time_ < var_437_1 + var_437_2 and not isNil(var_437_0) then
				local var_437_3 = (arg_434_1.time_ - var_437_1) / var_437_2

				if arg_434_1.var_.characterEffect1095ui_story and not isNil(var_437_0) then
					local var_437_4 = Mathf.Lerp(0, 0.5, var_437_3)

					arg_434_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_434_1.var_.characterEffect1095ui_story.fillRatio = var_437_4
				end
			end

			if arg_434_1.time_ >= var_437_1 + var_437_2 and arg_434_1.time_ < var_437_1 + var_437_2 + arg_437_0 and not isNil(var_437_0) and arg_434_1.var_.characterEffect1095ui_story then
				local var_437_5 = 0.5

				arg_434_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_434_1.var_.characterEffect1095ui_story.fillRatio = var_437_5
			end

			local var_437_6 = 0
			local var_437_7 = 1.05

			if var_437_6 < arg_434_1.time_ and arg_434_1.time_ <= var_437_6 + arg_437_0 then
				arg_434_1.talkMaxDuration = 0
				arg_434_1.dialogCg_.alpha = 1

				arg_434_1.dialog_:SetActive(true)
				SetActive(arg_434_1.leftNameGo_, false)

				arg_434_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_434_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_434_1:RecordName(arg_434_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_434_1.iconTrs_.gameObject, false)
				arg_434_1.callingController_:SetSelectedState("normal")

				local var_437_8 = arg_434_1:GetWordFromCfg(411051104)
				local var_437_9 = arg_434_1:FormatText(var_437_8.content)

				arg_434_1.text_.text = var_437_9

				LuaForUtil.ClearLinePrefixSymbol(arg_434_1.text_)

				local var_437_10 = 42
				local var_437_11 = utf8.len(var_437_9)
				local var_437_12 = var_437_10 <= 0 and var_437_7 or var_437_7 * (var_437_11 / var_437_10)

				if var_437_12 > 0 and var_437_7 < var_437_12 then
					arg_434_1.talkMaxDuration = var_437_12

					if var_437_12 + var_437_6 > arg_434_1.duration_ then
						arg_434_1.duration_ = var_437_12 + var_437_6
					end
				end

				arg_434_1.text_.text = var_437_9
				arg_434_1.typewritter.percent = 0

				arg_434_1.typewritter:SetDirty()
				arg_434_1:ShowNextGo(false)
				arg_434_1:RecordContent(arg_434_1.text_.text)
			end

			local var_437_13 = math.max(var_437_7, arg_434_1.talkMaxDuration)

			if var_437_6 <= arg_434_1.time_ and arg_434_1.time_ < var_437_6 + var_437_13 then
				arg_434_1.typewritter.percent = (arg_434_1.time_ - var_437_6) / var_437_13

				arg_434_1.typewritter:SetDirty()
			end

			if arg_434_1.time_ >= var_437_6 + var_437_13 and arg_434_1.time_ < var_437_6 + var_437_13 + arg_437_0 then
				arg_434_1.typewritter.percent = 1

				arg_434_1.typewritter:SetDirty()
				arg_434_1:ShowNextGo(true)
			end
		end

		arg_434_1.nodeConfigList_ = {}

		arg_434_1:InitPlayNodeList()
	end,
	Play411051105 = function(arg_438_0, arg_438_1)
		arg_438_1.time_ = 0
		arg_438_1.frameCnt_ = 0
		arg_438_1.state_ = "playing"
		arg_438_1.curTalkId_ = 411051105
		arg_438_1.duration_ = 2.43

		local var_438_0 = {
			zh = 2.433,
			ja = 1.999999999999
		}
		local var_438_1 = manager.audio:GetLocalizationFlag()

		if var_438_0[var_438_1] ~= nil then
			arg_438_1.duration_ = var_438_0[var_438_1]
		end

		SetActive(arg_438_1.tipsGo_, false)

		function arg_438_1.onSingleLineFinish_()
			arg_438_1.onSingleLineUpdate_ = nil
			arg_438_1.onSingleLineFinish_ = nil
			arg_438_1.state_ = "waiting"
		end

		function arg_438_1.playNext_(arg_440_0)
			if arg_440_0 == 1 then
				arg_438_0:Play411051106(arg_438_1)
			end
		end

		function arg_438_1.onSingleLineUpdate_(arg_441_0)
			local var_441_0 = arg_438_1.actors_["1095ui_story"]
			local var_441_1 = 0

			if var_441_1 < arg_438_1.time_ and arg_438_1.time_ <= var_441_1 + arg_441_0 and not isNil(var_441_0) and arg_438_1.var_.characterEffect1095ui_story == nil then
				arg_438_1.var_.characterEffect1095ui_story = var_441_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_441_2 = 0.200000002980232

			if var_441_1 <= arg_438_1.time_ and arg_438_1.time_ < var_441_1 + var_441_2 and not isNil(var_441_0) then
				local var_441_3 = (arg_438_1.time_ - var_441_1) / var_441_2

				if arg_438_1.var_.characterEffect1095ui_story and not isNil(var_441_0) then
					arg_438_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_438_1.time_ >= var_441_1 + var_441_2 and arg_438_1.time_ < var_441_1 + var_441_2 + arg_441_0 and not isNil(var_441_0) and arg_438_1.var_.characterEffect1095ui_story then
				arg_438_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_441_4 = 0

			if var_441_4 < arg_438_1.time_ and arg_438_1.time_ <= var_441_4 + arg_441_0 then
				arg_438_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action6_2")
			end

			local var_441_5 = 0

			if var_441_5 < arg_438_1.time_ and arg_438_1.time_ <= var_441_5 + arg_441_0 then
				arg_438_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_441_6 = 0
			local var_441_7 = 0.175

			if var_441_6 < arg_438_1.time_ and arg_438_1.time_ <= var_441_6 + arg_441_0 then
				arg_438_1.talkMaxDuration = 0
				arg_438_1.dialogCg_.alpha = 1

				arg_438_1.dialog_:SetActive(true)
				SetActive(arg_438_1.leftNameGo_, true)

				local var_441_8 = arg_438_1:FormatText(StoryNameCfg[471].name)

				arg_438_1.leftNameTxt_.text = var_441_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_438_1.leftNameTxt_.transform)

				arg_438_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_438_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_438_1:RecordName(arg_438_1.leftNameTxt_.text)
				SetActive(arg_438_1.iconTrs_.gameObject, false)
				arg_438_1.callingController_:SetSelectedState("normal")

				local var_441_9 = arg_438_1:GetWordFromCfg(411051105)
				local var_441_10 = arg_438_1:FormatText(var_441_9.content)

				arg_438_1.text_.text = var_441_10

				LuaForUtil.ClearLinePrefixSymbol(arg_438_1.text_)

				local var_441_11 = 7
				local var_441_12 = utf8.len(var_441_10)
				local var_441_13 = var_441_11 <= 0 and var_441_7 or var_441_7 * (var_441_12 / var_441_11)

				if var_441_13 > 0 and var_441_7 < var_441_13 then
					arg_438_1.talkMaxDuration = var_441_13

					if var_441_13 + var_441_6 > arg_438_1.duration_ then
						arg_438_1.duration_ = var_441_13 + var_441_6
					end
				end

				arg_438_1.text_.text = var_441_10
				arg_438_1.typewritter.percent = 0

				arg_438_1.typewritter:SetDirty()
				arg_438_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051105", "story_v_out_411051.awb") ~= 0 then
					local var_441_14 = manager.audio:GetVoiceLength("story_v_out_411051", "411051105", "story_v_out_411051.awb") / 1000

					if var_441_14 + var_441_6 > arg_438_1.duration_ then
						arg_438_1.duration_ = var_441_14 + var_441_6
					end

					if var_441_9.prefab_name ~= "" and arg_438_1.actors_[var_441_9.prefab_name] ~= nil then
						local var_441_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_438_1.actors_[var_441_9.prefab_name].transform, "story_v_out_411051", "411051105", "story_v_out_411051.awb")

						arg_438_1:RecordAudio("411051105", var_441_15)
						arg_438_1:RecordAudio("411051105", var_441_15)
					else
						arg_438_1:AudioAction("play", "voice", "story_v_out_411051", "411051105", "story_v_out_411051.awb")
					end

					arg_438_1:RecordHistoryTalkVoice("story_v_out_411051", "411051105", "story_v_out_411051.awb")
				end

				arg_438_1:RecordContent(arg_438_1.text_.text)
			end

			local var_441_16 = math.max(var_441_7, arg_438_1.talkMaxDuration)

			if var_441_6 <= arg_438_1.time_ and arg_438_1.time_ < var_441_6 + var_441_16 then
				arg_438_1.typewritter.percent = (arg_438_1.time_ - var_441_6) / var_441_16

				arg_438_1.typewritter:SetDirty()
			end

			if arg_438_1.time_ >= var_441_6 + var_441_16 and arg_438_1.time_ < var_441_6 + var_441_16 + arg_441_0 then
				arg_438_1.typewritter.percent = 1

				arg_438_1.typewritter:SetDirty()
				arg_438_1:ShowNextGo(true)
			end
		end

		arg_438_1.nodeConfigList_ = {}

		arg_438_1:InitPlayNodeList()
	end,
	Play411051106 = function(arg_442_0, arg_442_1)
		arg_442_1.time_ = 0
		arg_442_1.frameCnt_ = 0
		arg_442_1.state_ = "playing"
		arg_442_1.curTalkId_ = 411051106
		arg_442_1.duration_ = 4.17

		local var_442_0 = {
			zh = 1.9,
			ja = 4.166
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
				arg_442_0:Play411051107(arg_442_1)
			end
		end

		function arg_442_1.onSingleLineUpdate_(arg_445_0)
			local var_445_0 = arg_442_1.actors_["1095ui_story"]
			local var_445_1 = 0

			if var_445_1 < arg_442_1.time_ and arg_442_1.time_ <= var_445_1 + arg_445_0 and not isNil(var_445_0) and arg_442_1.var_.characterEffect1095ui_story == nil then
				arg_442_1.var_.characterEffect1095ui_story = var_445_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_445_2 = 0.200000002980232

			if var_445_1 <= arg_442_1.time_ and arg_442_1.time_ < var_445_1 + var_445_2 and not isNil(var_445_0) then
				local var_445_3 = (arg_442_1.time_ - var_445_1) / var_445_2

				if arg_442_1.var_.characterEffect1095ui_story and not isNil(var_445_0) then
					local var_445_4 = Mathf.Lerp(0, 0.5, var_445_3)

					arg_442_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_442_1.var_.characterEffect1095ui_story.fillRatio = var_445_4
				end
			end

			if arg_442_1.time_ >= var_445_1 + var_445_2 and arg_442_1.time_ < var_445_1 + var_445_2 + arg_445_0 and not isNil(var_445_0) and arg_442_1.var_.characterEffect1095ui_story then
				local var_445_5 = 0.5

				arg_442_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_442_1.var_.characterEffect1095ui_story.fillRatio = var_445_5
			end

			local var_445_6 = 0
			local var_445_7 = 0.275

			if var_445_6 < arg_442_1.time_ and arg_442_1.time_ <= var_445_6 + arg_445_0 then
				arg_442_1.talkMaxDuration = 0
				arg_442_1.dialogCg_.alpha = 1

				arg_442_1.dialog_:SetActive(true)
				SetActive(arg_442_1.leftNameGo_, true)

				local var_445_8 = arg_442_1:FormatText(StoryNameCfg[39].name)

				arg_442_1.leftNameTxt_.text = var_445_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_442_1.leftNameTxt_.transform)

				arg_442_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_442_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_442_1:RecordName(arg_442_1.leftNameTxt_.text)
				SetActive(arg_442_1.iconTrs_.gameObject, true)
				arg_442_1.iconController_:SetSelectedState("hero")

				arg_442_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10002a")

				arg_442_1.callingController_:SetSelectedState("normal")

				arg_442_1.keyicon_.color = Color.New(1, 1, 1)
				arg_442_1.icon_.color = Color.New(1, 1, 1)

				local var_445_9 = arg_442_1:GetWordFromCfg(411051106)
				local var_445_10 = arg_442_1:FormatText(var_445_9.content)

				arg_442_1.text_.text = var_445_10

				LuaForUtil.ClearLinePrefixSymbol(arg_442_1.text_)

				local var_445_11 = 11
				local var_445_12 = utf8.len(var_445_10)
				local var_445_13 = var_445_11 <= 0 and var_445_7 or var_445_7 * (var_445_12 / var_445_11)

				if var_445_13 > 0 and var_445_7 < var_445_13 then
					arg_442_1.talkMaxDuration = var_445_13

					if var_445_13 + var_445_6 > arg_442_1.duration_ then
						arg_442_1.duration_ = var_445_13 + var_445_6
					end
				end

				arg_442_1.text_.text = var_445_10
				arg_442_1.typewritter.percent = 0

				arg_442_1.typewritter:SetDirty()
				arg_442_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051106", "story_v_out_411051.awb") ~= 0 then
					local var_445_14 = manager.audio:GetVoiceLength("story_v_out_411051", "411051106", "story_v_out_411051.awb") / 1000

					if var_445_14 + var_445_6 > arg_442_1.duration_ then
						arg_442_1.duration_ = var_445_14 + var_445_6
					end

					if var_445_9.prefab_name ~= "" and arg_442_1.actors_[var_445_9.prefab_name] ~= nil then
						local var_445_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_442_1.actors_[var_445_9.prefab_name].transform, "story_v_out_411051", "411051106", "story_v_out_411051.awb")

						arg_442_1:RecordAudio("411051106", var_445_15)
						arg_442_1:RecordAudio("411051106", var_445_15)
					else
						arg_442_1:AudioAction("play", "voice", "story_v_out_411051", "411051106", "story_v_out_411051.awb")
					end

					arg_442_1:RecordHistoryTalkVoice("story_v_out_411051", "411051106", "story_v_out_411051.awb")
				end

				arg_442_1:RecordContent(arg_442_1.text_.text)
			end

			local var_445_16 = math.max(var_445_7, arg_442_1.talkMaxDuration)

			if var_445_6 <= arg_442_1.time_ and arg_442_1.time_ < var_445_6 + var_445_16 then
				arg_442_1.typewritter.percent = (arg_442_1.time_ - var_445_6) / var_445_16

				arg_442_1.typewritter:SetDirty()
			end

			if arg_442_1.time_ >= var_445_6 + var_445_16 and arg_442_1.time_ < var_445_6 + var_445_16 + arg_445_0 then
				arg_442_1.typewritter.percent = 1

				arg_442_1.typewritter:SetDirty()
				arg_442_1:ShowNextGo(true)
			end
		end

		arg_442_1.nodeConfigList_ = {}

		arg_442_1:InitPlayNodeList()
	end,
	Play411051107 = function(arg_446_0, arg_446_1)
		arg_446_1.time_ = 0
		arg_446_1.frameCnt_ = 0
		arg_446_1.state_ = "playing"
		arg_446_1.curTalkId_ = 411051107
		arg_446_1.duration_ = 11.93

		local var_446_0 = {
			zh = 11.933,
			ja = 9.2
		}
		local var_446_1 = manager.audio:GetLocalizationFlag()

		if var_446_0[var_446_1] ~= nil then
			arg_446_1.duration_ = var_446_0[var_446_1]
		end

		SetActive(arg_446_1.tipsGo_, false)

		function arg_446_1.onSingleLineFinish_()
			arg_446_1.onSingleLineUpdate_ = nil
			arg_446_1.onSingleLineFinish_ = nil
			arg_446_1.state_ = "waiting"
		end

		function arg_446_1.playNext_(arg_448_0)
			if arg_448_0 == 1 then
				arg_446_0:Play411051108(arg_446_1)
			end
		end

		function arg_446_1.onSingleLineUpdate_(arg_449_0)
			local var_449_0 = 0
			local var_449_1 = 1.225

			if var_449_0 < arg_446_1.time_ and arg_446_1.time_ <= var_449_0 + arg_449_0 then
				arg_446_1.talkMaxDuration = 0
				arg_446_1.dialogCg_.alpha = 1

				arg_446_1.dialog_:SetActive(true)
				SetActive(arg_446_1.leftNameGo_, true)

				local var_449_2 = arg_446_1:FormatText(StoryNameCfg[39].name)

				arg_446_1.leftNameTxt_.text = var_449_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_446_1.leftNameTxt_.transform)

				arg_446_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_446_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_446_1:RecordName(arg_446_1.leftNameTxt_.text)
				SetActive(arg_446_1.iconTrs_.gameObject, true)
				arg_446_1.iconController_:SetSelectedState("hero")

				arg_446_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10002a")

				arg_446_1.callingController_:SetSelectedState("normal")

				arg_446_1.keyicon_.color = Color.New(1, 1, 1)
				arg_446_1.icon_.color = Color.New(1, 1, 1)

				local var_449_3 = arg_446_1:GetWordFromCfg(411051107)
				local var_449_4 = arg_446_1:FormatText(var_449_3.content)

				arg_446_1.text_.text = var_449_4

				LuaForUtil.ClearLinePrefixSymbol(arg_446_1.text_)

				local var_449_5 = 49
				local var_449_6 = utf8.len(var_449_4)
				local var_449_7 = var_449_5 <= 0 and var_449_1 or var_449_1 * (var_449_6 / var_449_5)

				if var_449_7 > 0 and var_449_1 < var_449_7 then
					arg_446_1.talkMaxDuration = var_449_7

					if var_449_7 + var_449_0 > arg_446_1.duration_ then
						arg_446_1.duration_ = var_449_7 + var_449_0
					end
				end

				arg_446_1.text_.text = var_449_4
				arg_446_1.typewritter.percent = 0

				arg_446_1.typewritter:SetDirty()
				arg_446_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051107", "story_v_out_411051.awb") ~= 0 then
					local var_449_8 = manager.audio:GetVoiceLength("story_v_out_411051", "411051107", "story_v_out_411051.awb") / 1000

					if var_449_8 + var_449_0 > arg_446_1.duration_ then
						arg_446_1.duration_ = var_449_8 + var_449_0
					end

					if var_449_3.prefab_name ~= "" and arg_446_1.actors_[var_449_3.prefab_name] ~= nil then
						local var_449_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_446_1.actors_[var_449_3.prefab_name].transform, "story_v_out_411051", "411051107", "story_v_out_411051.awb")

						arg_446_1:RecordAudio("411051107", var_449_9)
						arg_446_1:RecordAudio("411051107", var_449_9)
					else
						arg_446_1:AudioAction("play", "voice", "story_v_out_411051", "411051107", "story_v_out_411051.awb")
					end

					arg_446_1:RecordHistoryTalkVoice("story_v_out_411051", "411051107", "story_v_out_411051.awb")
				end

				arg_446_1:RecordContent(arg_446_1.text_.text)
			end

			local var_449_10 = math.max(var_449_1, arg_446_1.talkMaxDuration)

			if var_449_0 <= arg_446_1.time_ and arg_446_1.time_ < var_449_0 + var_449_10 then
				arg_446_1.typewritter.percent = (arg_446_1.time_ - var_449_0) / var_449_10

				arg_446_1.typewritter:SetDirty()
			end

			if arg_446_1.time_ >= var_449_0 + var_449_10 and arg_446_1.time_ < var_449_0 + var_449_10 + arg_449_0 then
				arg_446_1.typewritter.percent = 1

				arg_446_1.typewritter:SetDirty()
				arg_446_1:ShowNextGo(true)
			end
		end

		arg_446_1.nodeConfigList_ = {}

		arg_446_1:InitPlayNodeList()
	end,
	Play411051108 = function(arg_450_0, arg_450_1)
		arg_450_1.time_ = 0
		arg_450_1.frameCnt_ = 0
		arg_450_1.state_ = "playing"
		arg_450_1.curTalkId_ = 411051108
		arg_450_1.duration_ = 12.5

		local var_450_0 = {
			zh = 12.5,
			ja = 6.7
		}
		local var_450_1 = manager.audio:GetLocalizationFlag()

		if var_450_0[var_450_1] ~= nil then
			arg_450_1.duration_ = var_450_0[var_450_1]
		end

		SetActive(arg_450_1.tipsGo_, false)

		function arg_450_1.onSingleLineFinish_()
			arg_450_1.onSingleLineUpdate_ = nil
			arg_450_1.onSingleLineFinish_ = nil
			arg_450_1.state_ = "waiting"
		end

		function arg_450_1.playNext_(arg_452_0)
			if arg_452_0 == 1 then
				arg_450_0:Play411051109(arg_450_1)
			end
		end

		function arg_450_1.onSingleLineUpdate_(arg_453_0)
			local var_453_0 = 0
			local var_453_1 = 1.375

			if var_453_0 < arg_450_1.time_ and arg_450_1.time_ <= var_453_0 + arg_453_0 then
				arg_450_1.talkMaxDuration = 0
				arg_450_1.dialogCg_.alpha = 1

				arg_450_1.dialog_:SetActive(true)
				SetActive(arg_450_1.leftNameGo_, true)

				local var_453_2 = arg_450_1:FormatText(StoryNameCfg[39].name)

				arg_450_1.leftNameTxt_.text = var_453_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_450_1.leftNameTxt_.transform)

				arg_450_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_450_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_450_1:RecordName(arg_450_1.leftNameTxt_.text)
				SetActive(arg_450_1.iconTrs_.gameObject, true)
				arg_450_1.iconController_:SetSelectedState("hero")

				arg_450_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10002a")

				arg_450_1.callingController_:SetSelectedState("normal")

				arg_450_1.keyicon_.color = Color.New(1, 1, 1)
				arg_450_1.icon_.color = Color.New(1, 1, 1)

				local var_453_3 = arg_450_1:GetWordFromCfg(411051108)
				local var_453_4 = arg_450_1:FormatText(var_453_3.content)

				arg_450_1.text_.text = var_453_4

				LuaForUtil.ClearLinePrefixSymbol(arg_450_1.text_)

				local var_453_5 = 55
				local var_453_6 = utf8.len(var_453_4)
				local var_453_7 = var_453_5 <= 0 and var_453_1 or var_453_1 * (var_453_6 / var_453_5)

				if var_453_7 > 0 and var_453_1 < var_453_7 then
					arg_450_1.talkMaxDuration = var_453_7

					if var_453_7 + var_453_0 > arg_450_1.duration_ then
						arg_450_1.duration_ = var_453_7 + var_453_0
					end
				end

				arg_450_1.text_.text = var_453_4
				arg_450_1.typewritter.percent = 0

				arg_450_1.typewritter:SetDirty()
				arg_450_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051108", "story_v_out_411051.awb") ~= 0 then
					local var_453_8 = manager.audio:GetVoiceLength("story_v_out_411051", "411051108", "story_v_out_411051.awb") / 1000

					if var_453_8 + var_453_0 > arg_450_1.duration_ then
						arg_450_1.duration_ = var_453_8 + var_453_0
					end

					if var_453_3.prefab_name ~= "" and arg_450_1.actors_[var_453_3.prefab_name] ~= nil then
						local var_453_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_450_1.actors_[var_453_3.prefab_name].transform, "story_v_out_411051", "411051108", "story_v_out_411051.awb")

						arg_450_1:RecordAudio("411051108", var_453_9)
						arg_450_1:RecordAudio("411051108", var_453_9)
					else
						arg_450_1:AudioAction("play", "voice", "story_v_out_411051", "411051108", "story_v_out_411051.awb")
					end

					arg_450_1:RecordHistoryTalkVoice("story_v_out_411051", "411051108", "story_v_out_411051.awb")
				end

				arg_450_1:RecordContent(arg_450_1.text_.text)
			end

			local var_453_10 = math.max(var_453_1, arg_450_1.talkMaxDuration)

			if var_453_0 <= arg_450_1.time_ and arg_450_1.time_ < var_453_0 + var_453_10 then
				arg_450_1.typewritter.percent = (arg_450_1.time_ - var_453_0) / var_453_10

				arg_450_1.typewritter:SetDirty()
			end

			if arg_450_1.time_ >= var_453_0 + var_453_10 and arg_450_1.time_ < var_453_0 + var_453_10 + arg_453_0 then
				arg_450_1.typewritter.percent = 1

				arg_450_1.typewritter:SetDirty()
				arg_450_1:ShowNextGo(true)
			end
		end

		arg_450_1.nodeConfigList_ = {}

		arg_450_1:InitPlayNodeList()
	end,
	Play411051109 = function(arg_454_0, arg_454_1)
		arg_454_1.time_ = 0
		arg_454_1.frameCnt_ = 0
		arg_454_1.state_ = "playing"
		arg_454_1.curTalkId_ = 411051109
		arg_454_1.duration_ = 15

		local var_454_0 = {
			zh = 15,
			ja = 11.066
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
				arg_454_0:Play411051110(arg_454_1)
			end
		end

		function arg_454_1.onSingleLineUpdate_(arg_457_0)
			local var_457_0 = 0
			local var_457_1 = 1.6

			if var_457_0 < arg_454_1.time_ and arg_454_1.time_ <= var_457_0 + arg_457_0 then
				arg_454_1.talkMaxDuration = 0
				arg_454_1.dialogCg_.alpha = 1

				arg_454_1.dialog_:SetActive(true)
				SetActive(arg_454_1.leftNameGo_, true)

				local var_457_2 = arg_454_1:FormatText(StoryNameCfg[39].name)

				arg_454_1.leftNameTxt_.text = var_457_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_454_1.leftNameTxt_.transform)

				arg_454_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_454_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_454_1:RecordName(arg_454_1.leftNameTxt_.text)
				SetActive(arg_454_1.iconTrs_.gameObject, true)
				arg_454_1.iconController_:SetSelectedState("hero")

				arg_454_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10002a")

				arg_454_1.callingController_:SetSelectedState("normal")

				arg_454_1.keyicon_.color = Color.New(1, 1, 1)
				arg_454_1.icon_.color = Color.New(1, 1, 1)

				local var_457_3 = arg_454_1:GetWordFromCfg(411051109)
				local var_457_4 = arg_454_1:FormatText(var_457_3.content)

				arg_454_1.text_.text = var_457_4

				LuaForUtil.ClearLinePrefixSymbol(arg_454_1.text_)

				local var_457_5 = 64
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

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051109", "story_v_out_411051.awb") ~= 0 then
					local var_457_8 = manager.audio:GetVoiceLength("story_v_out_411051", "411051109", "story_v_out_411051.awb") / 1000

					if var_457_8 + var_457_0 > arg_454_1.duration_ then
						arg_454_1.duration_ = var_457_8 + var_457_0
					end

					if var_457_3.prefab_name ~= "" and arg_454_1.actors_[var_457_3.prefab_name] ~= nil then
						local var_457_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_454_1.actors_[var_457_3.prefab_name].transform, "story_v_out_411051", "411051109", "story_v_out_411051.awb")

						arg_454_1:RecordAudio("411051109", var_457_9)
						arg_454_1:RecordAudio("411051109", var_457_9)
					else
						arg_454_1:AudioAction("play", "voice", "story_v_out_411051", "411051109", "story_v_out_411051.awb")
					end

					arg_454_1:RecordHistoryTalkVoice("story_v_out_411051", "411051109", "story_v_out_411051.awb")
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
	Play411051110 = function(arg_458_0, arg_458_1)
		arg_458_1.time_ = 0
		arg_458_1.frameCnt_ = 0
		arg_458_1.state_ = "playing"
		arg_458_1.curTalkId_ = 411051110
		arg_458_1.duration_ = 11.57

		local var_458_0 = {
			zh = 11.433,
			ja = 11.566
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
				arg_458_0:Play411051111(arg_458_1)
			end
		end

		function arg_458_1.onSingleLineUpdate_(arg_461_0)
			local var_461_0 = 0
			local var_461_1 = 1.125

			if var_461_0 < arg_458_1.time_ and arg_458_1.time_ <= var_461_0 + arg_461_0 then
				arg_458_1.talkMaxDuration = 0
				arg_458_1.dialogCg_.alpha = 1

				arg_458_1.dialog_:SetActive(true)
				SetActive(arg_458_1.leftNameGo_, true)

				local var_461_2 = arg_458_1:FormatText(StoryNameCfg[39].name)

				arg_458_1.leftNameTxt_.text = var_461_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_458_1.leftNameTxt_.transform)

				arg_458_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_458_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_458_1:RecordName(arg_458_1.leftNameTxt_.text)
				SetActive(arg_458_1.iconTrs_.gameObject, true)
				arg_458_1.iconController_:SetSelectedState("hero")

				arg_458_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10002a")

				arg_458_1.callingController_:SetSelectedState("normal")

				arg_458_1.keyicon_.color = Color.New(1, 1, 1)
				arg_458_1.icon_.color = Color.New(1, 1, 1)

				local var_461_3 = arg_458_1:GetWordFromCfg(411051110)
				local var_461_4 = arg_458_1:FormatText(var_461_3.content)

				arg_458_1.text_.text = var_461_4

				LuaForUtil.ClearLinePrefixSymbol(arg_458_1.text_)

				local var_461_5 = 45
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

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051110", "story_v_out_411051.awb") ~= 0 then
					local var_461_8 = manager.audio:GetVoiceLength("story_v_out_411051", "411051110", "story_v_out_411051.awb") / 1000

					if var_461_8 + var_461_0 > arg_458_1.duration_ then
						arg_458_1.duration_ = var_461_8 + var_461_0
					end

					if var_461_3.prefab_name ~= "" and arg_458_1.actors_[var_461_3.prefab_name] ~= nil then
						local var_461_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_458_1.actors_[var_461_3.prefab_name].transform, "story_v_out_411051", "411051110", "story_v_out_411051.awb")

						arg_458_1:RecordAudio("411051110", var_461_9)
						arg_458_1:RecordAudio("411051110", var_461_9)
					else
						arg_458_1:AudioAction("play", "voice", "story_v_out_411051", "411051110", "story_v_out_411051.awb")
					end

					arg_458_1:RecordHistoryTalkVoice("story_v_out_411051", "411051110", "story_v_out_411051.awb")
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
	Play411051111 = function(arg_462_0, arg_462_1)
		arg_462_1.time_ = 0
		arg_462_1.frameCnt_ = 0
		arg_462_1.state_ = "playing"
		arg_462_1.curTalkId_ = 411051111
		arg_462_1.duration_ = 8.63

		local var_462_0 = {
			zh = 4.133,
			ja = 8.633
		}
		local var_462_1 = manager.audio:GetLocalizationFlag()

		if var_462_0[var_462_1] ~= nil then
			arg_462_1.duration_ = var_462_0[var_462_1]
		end

		SetActive(arg_462_1.tipsGo_, false)

		function arg_462_1.onSingleLineFinish_()
			arg_462_1.onSingleLineUpdate_ = nil
			arg_462_1.onSingleLineFinish_ = nil
			arg_462_1.state_ = "waiting"
		end

		function arg_462_1.playNext_(arg_464_0)
			if arg_464_0 == 1 then
				arg_462_0:Play411051112(arg_462_1)
			end
		end

		function arg_462_1.onSingleLineUpdate_(arg_465_0)
			local var_465_0 = arg_462_1.actors_["1095ui_story"]
			local var_465_1 = 0

			if var_465_1 < arg_462_1.time_ and arg_462_1.time_ <= var_465_1 + arg_465_0 and not isNil(var_465_0) and arg_462_1.var_.characterEffect1095ui_story == nil then
				arg_462_1.var_.characterEffect1095ui_story = var_465_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_465_2 = 0.200000002980232

			if var_465_1 <= arg_462_1.time_ and arg_462_1.time_ < var_465_1 + var_465_2 and not isNil(var_465_0) then
				local var_465_3 = (arg_462_1.time_ - var_465_1) / var_465_2

				if arg_462_1.var_.characterEffect1095ui_story and not isNil(var_465_0) then
					arg_462_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_462_1.time_ >= var_465_1 + var_465_2 and arg_462_1.time_ < var_465_1 + var_465_2 + arg_465_0 and not isNil(var_465_0) and arg_462_1.var_.characterEffect1095ui_story then
				arg_462_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_465_4 = 0
			local var_465_5 = 0.45

			if var_465_4 < arg_462_1.time_ and arg_462_1.time_ <= var_465_4 + arg_465_0 then
				arg_462_1.talkMaxDuration = 0
				arg_462_1.dialogCg_.alpha = 1

				arg_462_1.dialog_:SetActive(true)
				SetActive(arg_462_1.leftNameGo_, true)

				local var_465_6 = arg_462_1:FormatText(StoryNameCfg[471].name)

				arg_462_1.leftNameTxt_.text = var_465_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_462_1.leftNameTxt_.transform)

				arg_462_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_462_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_462_1:RecordName(arg_462_1.leftNameTxt_.text)
				SetActive(arg_462_1.iconTrs_.gameObject, false)
				arg_462_1.callingController_:SetSelectedState("normal")

				local var_465_7 = arg_462_1:GetWordFromCfg(411051111)
				local var_465_8 = arg_462_1:FormatText(var_465_7.content)

				arg_462_1.text_.text = var_465_8

				LuaForUtil.ClearLinePrefixSymbol(arg_462_1.text_)

				local var_465_9 = 18
				local var_465_10 = utf8.len(var_465_8)
				local var_465_11 = var_465_9 <= 0 and var_465_5 or var_465_5 * (var_465_10 / var_465_9)

				if var_465_11 > 0 and var_465_5 < var_465_11 then
					arg_462_1.talkMaxDuration = var_465_11

					if var_465_11 + var_465_4 > arg_462_1.duration_ then
						arg_462_1.duration_ = var_465_11 + var_465_4
					end
				end

				arg_462_1.text_.text = var_465_8
				arg_462_1.typewritter.percent = 0

				arg_462_1.typewritter:SetDirty()
				arg_462_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051111", "story_v_out_411051.awb") ~= 0 then
					local var_465_12 = manager.audio:GetVoiceLength("story_v_out_411051", "411051111", "story_v_out_411051.awb") / 1000

					if var_465_12 + var_465_4 > arg_462_1.duration_ then
						arg_462_1.duration_ = var_465_12 + var_465_4
					end

					if var_465_7.prefab_name ~= "" and arg_462_1.actors_[var_465_7.prefab_name] ~= nil then
						local var_465_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_462_1.actors_[var_465_7.prefab_name].transform, "story_v_out_411051", "411051111", "story_v_out_411051.awb")

						arg_462_1:RecordAudio("411051111", var_465_13)
						arg_462_1:RecordAudio("411051111", var_465_13)
					else
						arg_462_1:AudioAction("play", "voice", "story_v_out_411051", "411051111", "story_v_out_411051.awb")
					end

					arg_462_1:RecordHistoryTalkVoice("story_v_out_411051", "411051111", "story_v_out_411051.awb")
				end

				arg_462_1:RecordContent(arg_462_1.text_.text)
			end

			local var_465_14 = math.max(var_465_5, arg_462_1.talkMaxDuration)

			if var_465_4 <= arg_462_1.time_ and arg_462_1.time_ < var_465_4 + var_465_14 then
				arg_462_1.typewritter.percent = (arg_462_1.time_ - var_465_4) / var_465_14

				arg_462_1.typewritter:SetDirty()
			end

			if arg_462_1.time_ >= var_465_4 + var_465_14 and arg_462_1.time_ < var_465_4 + var_465_14 + arg_465_0 then
				arg_462_1.typewritter.percent = 1

				arg_462_1.typewritter:SetDirty()
				arg_462_1:ShowNextGo(true)
			end
		end

		arg_462_1.nodeConfigList_ = {}

		arg_462_1:InitPlayNodeList()
	end,
	Play411051112 = function(arg_466_0, arg_466_1)
		arg_466_1.time_ = 0
		arg_466_1.frameCnt_ = 0
		arg_466_1.state_ = "playing"
		arg_466_1.curTalkId_ = 411051112
		arg_466_1.duration_ = 8.37

		local var_466_0 = {
			zh = 8.366,
			ja = 2.966
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
				arg_466_0:Play411051113(arg_466_1)
			end
		end

		function arg_466_1.onSingleLineUpdate_(arg_469_0)
			local var_469_0 = arg_466_1.actors_["1095ui_story"]
			local var_469_1 = 0

			if var_469_1 < arg_466_1.time_ and arg_466_1.time_ <= var_469_1 + arg_469_0 and not isNil(var_469_0) and arg_466_1.var_.characterEffect1095ui_story == nil then
				arg_466_1.var_.characterEffect1095ui_story = var_469_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_469_2 = 0.200000002980232

			if var_469_1 <= arg_466_1.time_ and arg_466_1.time_ < var_469_1 + var_469_2 and not isNil(var_469_0) then
				local var_469_3 = (arg_466_1.time_ - var_469_1) / var_469_2

				if arg_466_1.var_.characterEffect1095ui_story and not isNil(var_469_0) then
					local var_469_4 = Mathf.Lerp(0, 0.5, var_469_3)

					arg_466_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_466_1.var_.characterEffect1095ui_story.fillRatio = var_469_4
				end
			end

			if arg_466_1.time_ >= var_469_1 + var_469_2 and arg_466_1.time_ < var_469_1 + var_469_2 + arg_469_0 and not isNil(var_469_0) and arg_466_1.var_.characterEffect1095ui_story then
				local var_469_5 = 0.5

				arg_466_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_466_1.var_.characterEffect1095ui_story.fillRatio = var_469_5
			end

			local var_469_6 = 0
			local var_469_7 = 1

			if var_469_6 < arg_466_1.time_ and arg_466_1.time_ <= var_469_6 + arg_469_0 then
				arg_466_1.talkMaxDuration = 0
				arg_466_1.dialogCg_.alpha = 1

				arg_466_1.dialog_:SetActive(true)
				SetActive(arg_466_1.leftNameGo_, true)

				local var_469_8 = arg_466_1:FormatText(StoryNameCfg[39].name)

				arg_466_1.leftNameTxt_.text = var_469_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_466_1.leftNameTxt_.transform)

				arg_466_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_466_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_466_1:RecordName(arg_466_1.leftNameTxt_.text)
				SetActive(arg_466_1.iconTrs_.gameObject, true)
				arg_466_1.iconController_:SetSelectedState("hero")

				arg_466_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10002a")

				arg_466_1.callingController_:SetSelectedState("normal")

				arg_466_1.keyicon_.color = Color.New(1, 1, 1)
				arg_466_1.icon_.color = Color.New(1, 1, 1)

				local var_469_9 = arg_466_1:GetWordFromCfg(411051112)
				local var_469_10 = arg_466_1:FormatText(var_469_9.content)

				arg_466_1.text_.text = var_469_10

				LuaForUtil.ClearLinePrefixSymbol(arg_466_1.text_)

				local var_469_11 = 40
				local var_469_12 = utf8.len(var_469_10)
				local var_469_13 = var_469_11 <= 0 and var_469_7 or var_469_7 * (var_469_12 / var_469_11)

				if var_469_13 > 0 and var_469_7 < var_469_13 then
					arg_466_1.talkMaxDuration = var_469_13

					if var_469_13 + var_469_6 > arg_466_1.duration_ then
						arg_466_1.duration_ = var_469_13 + var_469_6
					end
				end

				arg_466_1.text_.text = var_469_10
				arg_466_1.typewritter.percent = 0

				arg_466_1.typewritter:SetDirty()
				arg_466_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051112", "story_v_out_411051.awb") ~= 0 then
					local var_469_14 = manager.audio:GetVoiceLength("story_v_out_411051", "411051112", "story_v_out_411051.awb") / 1000

					if var_469_14 + var_469_6 > arg_466_1.duration_ then
						arg_466_1.duration_ = var_469_14 + var_469_6
					end

					if var_469_9.prefab_name ~= "" and arg_466_1.actors_[var_469_9.prefab_name] ~= nil then
						local var_469_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_466_1.actors_[var_469_9.prefab_name].transform, "story_v_out_411051", "411051112", "story_v_out_411051.awb")

						arg_466_1:RecordAudio("411051112", var_469_15)
						arg_466_1:RecordAudio("411051112", var_469_15)
					else
						arg_466_1:AudioAction("play", "voice", "story_v_out_411051", "411051112", "story_v_out_411051.awb")
					end

					arg_466_1:RecordHistoryTalkVoice("story_v_out_411051", "411051112", "story_v_out_411051.awb")
				end

				arg_466_1:RecordContent(arg_466_1.text_.text)
			end

			local var_469_16 = math.max(var_469_7, arg_466_1.talkMaxDuration)

			if var_469_6 <= arg_466_1.time_ and arg_466_1.time_ < var_469_6 + var_469_16 then
				arg_466_1.typewritter.percent = (arg_466_1.time_ - var_469_6) / var_469_16

				arg_466_1.typewritter:SetDirty()
			end

			if arg_466_1.time_ >= var_469_6 + var_469_16 and arg_466_1.time_ < var_469_6 + var_469_16 + arg_469_0 then
				arg_466_1.typewritter.percent = 1

				arg_466_1.typewritter:SetDirty()
				arg_466_1:ShowNextGo(true)
			end
		end

		arg_466_1.nodeConfigList_ = {}

		arg_466_1:InitPlayNodeList()
	end,
	Play411051113 = function(arg_470_0, arg_470_1)
		arg_470_1.time_ = 0
		arg_470_1.frameCnt_ = 0
		arg_470_1.state_ = "playing"
		arg_470_1.curTalkId_ = 411051113
		arg_470_1.duration_ = 7.7

		local var_470_0 = {
			zh = 7.7,
			ja = 6.2
		}
		local var_470_1 = manager.audio:GetLocalizationFlag()

		if var_470_0[var_470_1] ~= nil then
			arg_470_1.duration_ = var_470_0[var_470_1]
		end

		SetActive(arg_470_1.tipsGo_, false)

		function arg_470_1.onSingleLineFinish_()
			arg_470_1.onSingleLineUpdate_ = nil
			arg_470_1.onSingleLineFinish_ = nil
			arg_470_1.state_ = "waiting"
		end

		function arg_470_1.playNext_(arg_472_0)
			if arg_472_0 == 1 then
				arg_470_0:Play411051114(arg_470_1)
			end
		end

		function arg_470_1.onSingleLineUpdate_(arg_473_0)
			local var_473_0 = 0
			local var_473_1 = 0.625

			if var_473_0 < arg_470_1.time_ and arg_470_1.time_ <= var_473_0 + arg_473_0 then
				arg_470_1.talkMaxDuration = 0
				arg_470_1.dialogCg_.alpha = 1

				arg_470_1.dialog_:SetActive(true)
				SetActive(arg_470_1.leftNameGo_, true)

				local var_473_2 = arg_470_1:FormatText(StoryNameCfg[39].name)

				arg_470_1.leftNameTxt_.text = var_473_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_470_1.leftNameTxt_.transform)

				arg_470_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_470_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_470_1:RecordName(arg_470_1.leftNameTxt_.text)
				SetActive(arg_470_1.iconTrs_.gameObject, true)
				arg_470_1.iconController_:SetSelectedState("hero")

				arg_470_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10002a")

				arg_470_1.callingController_:SetSelectedState("normal")

				arg_470_1.keyicon_.color = Color.New(1, 1, 1)
				arg_470_1.icon_.color = Color.New(1, 1, 1)

				local var_473_3 = arg_470_1:GetWordFromCfg(411051113)
				local var_473_4 = arg_470_1:FormatText(var_473_3.content)

				arg_470_1.text_.text = var_473_4

				LuaForUtil.ClearLinePrefixSymbol(arg_470_1.text_)

				local var_473_5 = 25
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

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051113", "story_v_out_411051.awb") ~= 0 then
					local var_473_8 = manager.audio:GetVoiceLength("story_v_out_411051", "411051113", "story_v_out_411051.awb") / 1000

					if var_473_8 + var_473_0 > arg_470_1.duration_ then
						arg_470_1.duration_ = var_473_8 + var_473_0
					end

					if var_473_3.prefab_name ~= "" and arg_470_1.actors_[var_473_3.prefab_name] ~= nil then
						local var_473_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_470_1.actors_[var_473_3.prefab_name].transform, "story_v_out_411051", "411051113", "story_v_out_411051.awb")

						arg_470_1:RecordAudio("411051113", var_473_9)
						arg_470_1:RecordAudio("411051113", var_473_9)
					else
						arg_470_1:AudioAction("play", "voice", "story_v_out_411051", "411051113", "story_v_out_411051.awb")
					end

					arg_470_1:RecordHistoryTalkVoice("story_v_out_411051", "411051113", "story_v_out_411051.awb")
				end

				arg_470_1:RecordContent(arg_470_1.text_.text)
			end

			local var_473_10 = math.max(var_473_1, arg_470_1.talkMaxDuration)

			if var_473_0 <= arg_470_1.time_ and arg_470_1.time_ < var_473_0 + var_473_10 then
				arg_470_1.typewritter.percent = (arg_470_1.time_ - var_473_0) / var_473_10

				arg_470_1.typewritter:SetDirty()
			end

			if arg_470_1.time_ >= var_473_0 + var_473_10 and arg_470_1.time_ < var_473_0 + var_473_10 + arg_473_0 then
				arg_470_1.typewritter.percent = 1

				arg_470_1.typewritter:SetDirty()
				arg_470_1:ShowNextGo(true)
			end
		end

		arg_470_1.nodeConfigList_ = {}

		arg_470_1:InitPlayNodeList()
	end,
	Play411051114 = function(arg_474_0, arg_474_1)
		arg_474_1.time_ = 0
		arg_474_1.frameCnt_ = 0
		arg_474_1.state_ = "playing"
		arg_474_1.curTalkId_ = 411051114
		arg_474_1.duration_ = 14.97

		local var_474_0 = {
			zh = 11.966,
			ja = 14.966
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
				arg_474_0:Play411051115(arg_474_1)
			end
		end

		function arg_474_1.onSingleLineUpdate_(arg_477_0)
			local var_477_0 = arg_474_1.actors_["1095ui_story"].transform
			local var_477_1 = 0

			if var_477_1 < arg_474_1.time_ and arg_474_1.time_ <= var_477_1 + arg_477_0 then
				arg_474_1.var_.moveOldPos1095ui_story = var_477_0.localPosition
			end

			local var_477_2 = 0.001

			if var_477_1 <= arg_474_1.time_ and arg_474_1.time_ < var_477_1 + var_477_2 then
				local var_477_3 = (arg_474_1.time_ - var_477_1) / var_477_2
				local var_477_4 = Vector3.New(0, -0.98, -6.1)

				var_477_0.localPosition = Vector3.Lerp(arg_474_1.var_.moveOldPos1095ui_story, var_477_4, var_477_3)

				local var_477_5 = manager.ui.mainCamera.transform.position - var_477_0.position

				var_477_0.forward = Vector3.New(var_477_5.x, var_477_5.y, var_477_5.z)

				local var_477_6 = var_477_0.localEulerAngles

				var_477_6.z = 0
				var_477_6.x = 0
				var_477_0.localEulerAngles = var_477_6
			end

			if arg_474_1.time_ >= var_477_1 + var_477_2 and arg_474_1.time_ < var_477_1 + var_477_2 + arg_477_0 then
				var_477_0.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_477_7 = manager.ui.mainCamera.transform.position - var_477_0.position

				var_477_0.forward = Vector3.New(var_477_7.x, var_477_7.y, var_477_7.z)

				local var_477_8 = var_477_0.localEulerAngles

				var_477_8.z = 0
				var_477_8.x = 0
				var_477_0.localEulerAngles = var_477_8
			end

			local var_477_9 = arg_474_1.actors_["1095ui_story"]
			local var_477_10 = 0

			if var_477_10 < arg_474_1.time_ and arg_474_1.time_ <= var_477_10 + arg_477_0 and not isNil(var_477_9) and arg_474_1.var_.characterEffect1095ui_story == nil then
				arg_474_1.var_.characterEffect1095ui_story = var_477_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_477_11 = 0.200000002980232

			if var_477_10 <= arg_474_1.time_ and arg_474_1.time_ < var_477_10 + var_477_11 and not isNil(var_477_9) then
				local var_477_12 = (arg_474_1.time_ - var_477_10) / var_477_11

				if arg_474_1.var_.characterEffect1095ui_story and not isNil(var_477_9) then
					arg_474_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_474_1.time_ >= var_477_10 + var_477_11 and arg_474_1.time_ < var_477_10 + var_477_11 + arg_477_0 and not isNil(var_477_9) and arg_474_1.var_.characterEffect1095ui_story then
				arg_474_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_477_13 = 0

			if var_477_13 < arg_474_1.time_ and arg_474_1.time_ <= var_477_13 + arg_477_0 then
				arg_474_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_477_14 = 0

			if var_477_14 < arg_474_1.time_ and arg_474_1.time_ <= var_477_14 + arg_477_0 then
				arg_474_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_477_15 = 0
			local var_477_16 = 1.5

			if var_477_15 < arg_474_1.time_ and arg_474_1.time_ <= var_477_15 + arg_477_0 then
				arg_474_1.talkMaxDuration = 0
				arg_474_1.dialogCg_.alpha = 1

				arg_474_1.dialog_:SetActive(true)
				SetActive(arg_474_1.leftNameGo_, true)

				local var_477_17 = arg_474_1:FormatText(StoryNameCfg[471].name)

				arg_474_1.leftNameTxt_.text = var_477_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_474_1.leftNameTxt_.transform)

				arg_474_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_474_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_474_1:RecordName(arg_474_1.leftNameTxt_.text)
				SetActive(arg_474_1.iconTrs_.gameObject, false)
				arg_474_1.callingController_:SetSelectedState("normal")

				local var_477_18 = arg_474_1:GetWordFromCfg(411051114)
				local var_477_19 = arg_474_1:FormatText(var_477_18.content)

				arg_474_1.text_.text = var_477_19

				LuaForUtil.ClearLinePrefixSymbol(arg_474_1.text_)

				local var_477_20 = 60
				local var_477_21 = utf8.len(var_477_19)
				local var_477_22 = var_477_20 <= 0 and var_477_16 or var_477_16 * (var_477_21 / var_477_20)

				if var_477_22 > 0 and var_477_16 < var_477_22 then
					arg_474_1.talkMaxDuration = var_477_22

					if var_477_22 + var_477_15 > arg_474_1.duration_ then
						arg_474_1.duration_ = var_477_22 + var_477_15
					end
				end

				arg_474_1.text_.text = var_477_19
				arg_474_1.typewritter.percent = 0

				arg_474_1.typewritter:SetDirty()
				arg_474_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051114", "story_v_out_411051.awb") ~= 0 then
					local var_477_23 = manager.audio:GetVoiceLength("story_v_out_411051", "411051114", "story_v_out_411051.awb") / 1000

					if var_477_23 + var_477_15 > arg_474_1.duration_ then
						arg_474_1.duration_ = var_477_23 + var_477_15
					end

					if var_477_18.prefab_name ~= "" and arg_474_1.actors_[var_477_18.prefab_name] ~= nil then
						local var_477_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_474_1.actors_[var_477_18.prefab_name].transform, "story_v_out_411051", "411051114", "story_v_out_411051.awb")

						arg_474_1:RecordAudio("411051114", var_477_24)
						arg_474_1:RecordAudio("411051114", var_477_24)
					else
						arg_474_1:AudioAction("play", "voice", "story_v_out_411051", "411051114", "story_v_out_411051.awb")
					end

					arg_474_1:RecordHistoryTalkVoice("story_v_out_411051", "411051114", "story_v_out_411051.awb")
				end

				arg_474_1:RecordContent(arg_474_1.text_.text)
			end

			local var_477_25 = math.max(var_477_16, arg_474_1.talkMaxDuration)

			if var_477_15 <= arg_474_1.time_ and arg_474_1.time_ < var_477_15 + var_477_25 then
				arg_474_1.typewritter.percent = (arg_474_1.time_ - var_477_15) / var_477_25

				arg_474_1.typewritter:SetDirty()
			end

			if arg_474_1.time_ >= var_477_15 + var_477_25 and arg_474_1.time_ < var_477_15 + var_477_25 + arg_477_0 then
				arg_474_1.typewritter.percent = 1

				arg_474_1.typewritter:SetDirty()
				arg_474_1:ShowNextGo(true)
			end
		end

		arg_474_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
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
	Play411051115 = function(arg_478_0, arg_478_1)
		arg_478_1.time_ = 0
		arg_478_1.frameCnt_ = 0
		arg_478_1.state_ = "playing"
		arg_478_1.curTalkId_ = 411051115
		arg_478_1.duration_ = 10.97

		local var_478_0 = {
			zh = 8.833,
			ja = 10.966
		}
		local var_478_1 = manager.audio:GetLocalizationFlag()

		if var_478_0[var_478_1] ~= nil then
			arg_478_1.duration_ = var_478_0[var_478_1]
		end

		SetActive(arg_478_1.tipsGo_, false)

		function arg_478_1.onSingleLineFinish_()
			arg_478_1.onSingleLineUpdate_ = nil
			arg_478_1.onSingleLineFinish_ = nil
			arg_478_1.state_ = "waiting"
		end

		function arg_478_1.playNext_(arg_480_0)
			if arg_480_0 == 1 then
				arg_478_0:Play411051116(arg_478_1)
			end
		end

		function arg_478_1.onSingleLineUpdate_(arg_481_0)
			local var_481_0 = 0
			local var_481_1 = 1.075

			if var_481_0 < arg_478_1.time_ and arg_478_1.time_ <= var_481_0 + arg_481_0 then
				arg_478_1.talkMaxDuration = 0
				arg_478_1.dialogCg_.alpha = 1

				arg_478_1.dialog_:SetActive(true)
				SetActive(arg_478_1.leftNameGo_, true)

				local var_481_2 = arg_478_1:FormatText(StoryNameCfg[471].name)

				arg_478_1.leftNameTxt_.text = var_481_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_478_1.leftNameTxt_.transform)

				arg_478_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_478_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_478_1:RecordName(arg_478_1.leftNameTxt_.text)
				SetActive(arg_478_1.iconTrs_.gameObject, false)
				arg_478_1.callingController_:SetSelectedState("normal")

				local var_481_3 = arg_478_1:GetWordFromCfg(411051115)
				local var_481_4 = arg_478_1:FormatText(var_481_3.content)

				arg_478_1.text_.text = var_481_4

				LuaForUtil.ClearLinePrefixSymbol(arg_478_1.text_)

				local var_481_5 = 43
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

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051115", "story_v_out_411051.awb") ~= 0 then
					local var_481_8 = manager.audio:GetVoiceLength("story_v_out_411051", "411051115", "story_v_out_411051.awb") / 1000

					if var_481_8 + var_481_0 > arg_478_1.duration_ then
						arg_478_1.duration_ = var_481_8 + var_481_0
					end

					if var_481_3.prefab_name ~= "" and arg_478_1.actors_[var_481_3.prefab_name] ~= nil then
						local var_481_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_478_1.actors_[var_481_3.prefab_name].transform, "story_v_out_411051", "411051115", "story_v_out_411051.awb")

						arg_478_1:RecordAudio("411051115", var_481_9)
						arg_478_1:RecordAudio("411051115", var_481_9)
					else
						arg_478_1:AudioAction("play", "voice", "story_v_out_411051", "411051115", "story_v_out_411051.awb")
					end

					arg_478_1:RecordHistoryTalkVoice("story_v_out_411051", "411051115", "story_v_out_411051.awb")
				end

				arg_478_1:RecordContent(arg_478_1.text_.text)
			end

			local var_481_10 = math.max(var_481_1, arg_478_1.talkMaxDuration)

			if var_481_0 <= arg_478_1.time_ and arg_478_1.time_ < var_481_0 + var_481_10 then
				arg_478_1.typewritter.percent = (arg_478_1.time_ - var_481_0) / var_481_10

				arg_478_1.typewritter:SetDirty()
			end

			if arg_478_1.time_ >= var_481_0 + var_481_10 and arg_478_1.time_ < var_481_0 + var_481_10 + arg_481_0 then
				arg_478_1.typewritter.percent = 1

				arg_478_1.typewritter:SetDirty()
				arg_478_1:ShowNextGo(true)
			end
		end

		arg_478_1.nodeConfigList_ = {}

		arg_478_1:InitPlayNodeList()
	end,
	Play411051116 = function(arg_482_0, arg_482_1)
		arg_482_1.time_ = 0
		arg_482_1.frameCnt_ = 0
		arg_482_1.state_ = "playing"
		arg_482_1.curTalkId_ = 411051116
		arg_482_1.duration_ = 8.6

		local var_482_0 = {
			zh = 8.2,
			ja = 8.6
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
				arg_482_0:Play411051117(arg_482_1)
			end
		end

		function arg_482_1.onSingleLineUpdate_(arg_485_0)
			local var_485_0 = arg_482_1.actors_["1095ui_story"]
			local var_485_1 = 0

			if var_485_1 < arg_482_1.time_ and arg_482_1.time_ <= var_485_1 + arg_485_0 and not isNil(var_485_0) and arg_482_1.var_.characterEffect1095ui_story == nil then
				arg_482_1.var_.characterEffect1095ui_story = var_485_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_485_2 = 0.200000002980232

			if var_485_1 <= arg_482_1.time_ and arg_482_1.time_ < var_485_1 + var_485_2 and not isNil(var_485_0) then
				local var_485_3 = (arg_482_1.time_ - var_485_1) / var_485_2

				if arg_482_1.var_.characterEffect1095ui_story and not isNil(var_485_0) then
					local var_485_4 = Mathf.Lerp(0, 0.5, var_485_3)

					arg_482_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_482_1.var_.characterEffect1095ui_story.fillRatio = var_485_4
				end
			end

			if arg_482_1.time_ >= var_485_1 + var_485_2 and arg_482_1.time_ < var_485_1 + var_485_2 + arg_485_0 and not isNil(var_485_0) and arg_482_1.var_.characterEffect1095ui_story then
				local var_485_5 = 0.5

				arg_482_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_482_1.var_.characterEffect1095ui_story.fillRatio = var_485_5
			end

			local var_485_6 = 0
			local var_485_7 = 0.65

			if var_485_6 < arg_482_1.time_ and arg_482_1.time_ <= var_485_6 + arg_485_0 then
				arg_482_1.talkMaxDuration = 0
				arg_482_1.dialogCg_.alpha = 1

				arg_482_1.dialog_:SetActive(true)
				SetActive(arg_482_1.leftNameGo_, true)

				local var_485_8 = arg_482_1:FormatText(StoryNameCfg[39].name)

				arg_482_1.leftNameTxt_.text = var_485_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_482_1.leftNameTxt_.transform)

				arg_482_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_482_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_482_1:RecordName(arg_482_1.leftNameTxt_.text)
				SetActive(arg_482_1.iconTrs_.gameObject, true)
				arg_482_1.iconController_:SetSelectedState("hero")

				arg_482_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10002a")

				arg_482_1.callingController_:SetSelectedState("normal")

				arg_482_1.keyicon_.color = Color.New(1, 1, 1)
				arg_482_1.icon_.color = Color.New(1, 1, 1)

				local var_485_9 = arg_482_1:GetWordFromCfg(411051116)
				local var_485_10 = arg_482_1:FormatText(var_485_9.content)

				arg_482_1.text_.text = var_485_10

				LuaForUtil.ClearLinePrefixSymbol(arg_482_1.text_)

				local var_485_11 = 26
				local var_485_12 = utf8.len(var_485_10)
				local var_485_13 = var_485_11 <= 0 and var_485_7 or var_485_7 * (var_485_12 / var_485_11)

				if var_485_13 > 0 and var_485_7 < var_485_13 then
					arg_482_1.talkMaxDuration = var_485_13

					if var_485_13 + var_485_6 > arg_482_1.duration_ then
						arg_482_1.duration_ = var_485_13 + var_485_6
					end
				end

				arg_482_1.text_.text = var_485_10
				arg_482_1.typewritter.percent = 0

				arg_482_1.typewritter:SetDirty()
				arg_482_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051116", "story_v_out_411051.awb") ~= 0 then
					local var_485_14 = manager.audio:GetVoiceLength("story_v_out_411051", "411051116", "story_v_out_411051.awb") / 1000

					if var_485_14 + var_485_6 > arg_482_1.duration_ then
						arg_482_1.duration_ = var_485_14 + var_485_6
					end

					if var_485_9.prefab_name ~= "" and arg_482_1.actors_[var_485_9.prefab_name] ~= nil then
						local var_485_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_482_1.actors_[var_485_9.prefab_name].transform, "story_v_out_411051", "411051116", "story_v_out_411051.awb")

						arg_482_1:RecordAudio("411051116", var_485_15)
						arg_482_1:RecordAudio("411051116", var_485_15)
					else
						arg_482_1:AudioAction("play", "voice", "story_v_out_411051", "411051116", "story_v_out_411051.awb")
					end

					arg_482_1:RecordHistoryTalkVoice("story_v_out_411051", "411051116", "story_v_out_411051.awb")
				end

				arg_482_1:RecordContent(arg_482_1.text_.text)
			end

			local var_485_16 = math.max(var_485_7, arg_482_1.talkMaxDuration)

			if var_485_6 <= arg_482_1.time_ and arg_482_1.time_ < var_485_6 + var_485_16 then
				arg_482_1.typewritter.percent = (arg_482_1.time_ - var_485_6) / var_485_16

				arg_482_1.typewritter:SetDirty()
			end

			if arg_482_1.time_ >= var_485_6 + var_485_16 and arg_482_1.time_ < var_485_6 + var_485_16 + arg_485_0 then
				arg_482_1.typewritter.percent = 1

				arg_482_1.typewritter:SetDirty()
				arg_482_1:ShowNextGo(true)
			end
		end

		arg_482_1.nodeConfigList_ = {}

		arg_482_1:InitPlayNodeList()
	end,
	Play411051117 = function(arg_486_0, arg_486_1)
		arg_486_1.time_ = 0
		arg_486_1.frameCnt_ = 0
		arg_486_1.state_ = "playing"
		arg_486_1.curTalkId_ = 411051117
		arg_486_1.duration_ = 6.4

		local var_486_0 = {
			zh = 4.266,
			ja = 6.4
		}
		local var_486_1 = manager.audio:GetLocalizationFlag()

		if var_486_0[var_486_1] ~= nil then
			arg_486_1.duration_ = var_486_0[var_486_1]
		end

		SetActive(arg_486_1.tipsGo_, false)

		function arg_486_1.onSingleLineFinish_()
			arg_486_1.onSingleLineUpdate_ = nil
			arg_486_1.onSingleLineFinish_ = nil
			arg_486_1.state_ = "waiting"
		end

		function arg_486_1.playNext_(arg_488_0)
			if arg_488_0 == 1 then
				arg_486_0:Play411051118(arg_486_1)
			end
		end

		function arg_486_1.onSingleLineUpdate_(arg_489_0)
			local var_489_0 = arg_486_1.actors_["1095ui_story"]
			local var_489_1 = 0

			if var_489_1 < arg_486_1.time_ and arg_486_1.time_ <= var_489_1 + arg_489_0 and not isNil(var_489_0) and arg_486_1.var_.characterEffect1095ui_story == nil then
				arg_486_1.var_.characterEffect1095ui_story = var_489_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_489_2 = 0.200000002980232

			if var_489_1 <= arg_486_1.time_ and arg_486_1.time_ < var_489_1 + var_489_2 and not isNil(var_489_0) then
				local var_489_3 = (arg_486_1.time_ - var_489_1) / var_489_2

				if arg_486_1.var_.characterEffect1095ui_story and not isNil(var_489_0) then
					arg_486_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_486_1.time_ >= var_489_1 + var_489_2 and arg_486_1.time_ < var_489_1 + var_489_2 + arg_489_0 and not isNil(var_489_0) and arg_486_1.var_.characterEffect1095ui_story then
				arg_486_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_489_4 = 0
			local var_489_5 = 0.55

			if var_489_4 < arg_486_1.time_ and arg_486_1.time_ <= var_489_4 + arg_489_0 then
				arg_486_1.talkMaxDuration = 0
				arg_486_1.dialogCg_.alpha = 1

				arg_486_1.dialog_:SetActive(true)
				SetActive(arg_486_1.leftNameGo_, true)

				local var_489_6 = arg_486_1:FormatText(StoryNameCfg[471].name)

				arg_486_1.leftNameTxt_.text = var_489_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_486_1.leftNameTxt_.transform)

				arg_486_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_486_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_486_1:RecordName(arg_486_1.leftNameTxt_.text)
				SetActive(arg_486_1.iconTrs_.gameObject, false)
				arg_486_1.callingController_:SetSelectedState("normal")

				local var_489_7 = arg_486_1:GetWordFromCfg(411051117)
				local var_489_8 = arg_486_1:FormatText(var_489_7.content)

				arg_486_1.text_.text = var_489_8

				LuaForUtil.ClearLinePrefixSymbol(arg_486_1.text_)

				local var_489_9 = 22
				local var_489_10 = utf8.len(var_489_8)
				local var_489_11 = var_489_9 <= 0 and var_489_5 or var_489_5 * (var_489_10 / var_489_9)

				if var_489_11 > 0 and var_489_5 < var_489_11 then
					arg_486_1.talkMaxDuration = var_489_11

					if var_489_11 + var_489_4 > arg_486_1.duration_ then
						arg_486_1.duration_ = var_489_11 + var_489_4
					end
				end

				arg_486_1.text_.text = var_489_8
				arg_486_1.typewritter.percent = 0

				arg_486_1.typewritter:SetDirty()
				arg_486_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051117", "story_v_out_411051.awb") ~= 0 then
					local var_489_12 = manager.audio:GetVoiceLength("story_v_out_411051", "411051117", "story_v_out_411051.awb") / 1000

					if var_489_12 + var_489_4 > arg_486_1.duration_ then
						arg_486_1.duration_ = var_489_12 + var_489_4
					end

					if var_489_7.prefab_name ~= "" and arg_486_1.actors_[var_489_7.prefab_name] ~= nil then
						local var_489_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_486_1.actors_[var_489_7.prefab_name].transform, "story_v_out_411051", "411051117", "story_v_out_411051.awb")

						arg_486_1:RecordAudio("411051117", var_489_13)
						arg_486_1:RecordAudio("411051117", var_489_13)
					else
						arg_486_1:AudioAction("play", "voice", "story_v_out_411051", "411051117", "story_v_out_411051.awb")
					end

					arg_486_1:RecordHistoryTalkVoice("story_v_out_411051", "411051117", "story_v_out_411051.awb")
				end

				arg_486_1:RecordContent(arg_486_1.text_.text)
			end

			local var_489_14 = math.max(var_489_5, arg_486_1.talkMaxDuration)

			if var_489_4 <= arg_486_1.time_ and arg_486_1.time_ < var_489_4 + var_489_14 then
				arg_486_1.typewritter.percent = (arg_486_1.time_ - var_489_4) / var_489_14

				arg_486_1.typewritter:SetDirty()
			end

			if arg_486_1.time_ >= var_489_4 + var_489_14 and arg_486_1.time_ < var_489_4 + var_489_14 + arg_489_0 then
				arg_486_1.typewritter.percent = 1

				arg_486_1.typewritter:SetDirty()
				arg_486_1:ShowNextGo(true)
			end
		end

		arg_486_1.nodeConfigList_ = {}

		arg_486_1:InitPlayNodeList()
	end,
	Play411051118 = function(arg_490_0, arg_490_1)
		arg_490_1.time_ = 0
		arg_490_1.frameCnt_ = 0
		arg_490_1.state_ = "playing"
		arg_490_1.curTalkId_ = 411051118
		arg_490_1.duration_ = 8.8

		local var_490_0 = {
			zh = 8.8,
			ja = 5.333
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
				arg_490_0:Play411051119(arg_490_1)
			end
		end

		function arg_490_1.onSingleLineUpdate_(arg_493_0)
			local var_493_0 = 0
			local var_493_1 = 1.075

			if var_493_0 < arg_490_1.time_ and arg_490_1.time_ <= var_493_0 + arg_493_0 then
				arg_490_1.talkMaxDuration = 0
				arg_490_1.dialogCg_.alpha = 1

				arg_490_1.dialog_:SetActive(true)
				SetActive(arg_490_1.leftNameGo_, true)

				local var_493_2 = arg_490_1:FormatText(StoryNameCfg[471].name)

				arg_490_1.leftNameTxt_.text = var_493_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_490_1.leftNameTxt_.transform)

				arg_490_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_490_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_490_1:RecordName(arg_490_1.leftNameTxt_.text)
				SetActive(arg_490_1.iconTrs_.gameObject, false)
				arg_490_1.callingController_:SetSelectedState("normal")

				local var_493_3 = arg_490_1:GetWordFromCfg(411051118)
				local var_493_4 = arg_490_1:FormatText(var_493_3.content)

				arg_490_1.text_.text = var_493_4

				LuaForUtil.ClearLinePrefixSymbol(arg_490_1.text_)

				local var_493_5 = 43
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

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051118", "story_v_out_411051.awb") ~= 0 then
					local var_493_8 = manager.audio:GetVoiceLength("story_v_out_411051", "411051118", "story_v_out_411051.awb") / 1000

					if var_493_8 + var_493_0 > arg_490_1.duration_ then
						arg_490_1.duration_ = var_493_8 + var_493_0
					end

					if var_493_3.prefab_name ~= "" and arg_490_1.actors_[var_493_3.prefab_name] ~= nil then
						local var_493_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_490_1.actors_[var_493_3.prefab_name].transform, "story_v_out_411051", "411051118", "story_v_out_411051.awb")

						arg_490_1:RecordAudio("411051118", var_493_9)
						arg_490_1:RecordAudio("411051118", var_493_9)
					else
						arg_490_1:AudioAction("play", "voice", "story_v_out_411051", "411051118", "story_v_out_411051.awb")
					end

					arg_490_1:RecordHistoryTalkVoice("story_v_out_411051", "411051118", "story_v_out_411051.awb")
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
	Play411051119 = function(arg_494_0, arg_494_1)
		arg_494_1.time_ = 0
		arg_494_1.frameCnt_ = 0
		arg_494_1.state_ = "playing"
		arg_494_1.curTalkId_ = 411051119
		arg_494_1.duration_ = 1.57

		local var_494_0 = {
			zh = 1.466,
			ja = 1.566
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
				arg_494_0:Play411051120(arg_494_1)
			end
		end

		function arg_494_1.onSingleLineUpdate_(arg_497_0)
			local var_497_0 = 0
			local var_497_1 = 0.125

			if var_497_0 < arg_494_1.time_ and arg_494_1.time_ <= var_497_0 + arg_497_0 then
				arg_494_1.talkMaxDuration = 0
				arg_494_1.dialogCg_.alpha = 1

				arg_494_1.dialog_:SetActive(true)
				SetActive(arg_494_1.leftNameGo_, true)

				local var_497_2 = arg_494_1:FormatText(StoryNameCfg[39].name)

				arg_494_1.leftNameTxt_.text = var_497_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_494_1.leftNameTxt_.transform)

				arg_494_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_494_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_494_1:RecordName(arg_494_1.leftNameTxt_.text)
				SetActive(arg_494_1.iconTrs_.gameObject, true)
				arg_494_1.iconController_:SetSelectedState("hero")

				arg_494_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10002a")

				arg_494_1.callingController_:SetSelectedState("normal")

				arg_494_1.keyicon_.color = Color.New(1, 1, 1)
				arg_494_1.icon_.color = Color.New(1, 1, 1)

				local var_497_3 = arg_494_1:GetWordFromCfg(411051119)
				local var_497_4 = arg_494_1:FormatText(var_497_3.content)

				arg_494_1.text_.text = var_497_4

				LuaForUtil.ClearLinePrefixSymbol(arg_494_1.text_)

				local var_497_5 = 5
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

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051119", "story_v_out_411051.awb") ~= 0 then
					local var_497_8 = manager.audio:GetVoiceLength("story_v_out_411051", "411051119", "story_v_out_411051.awb") / 1000

					if var_497_8 + var_497_0 > arg_494_1.duration_ then
						arg_494_1.duration_ = var_497_8 + var_497_0
					end

					if var_497_3.prefab_name ~= "" and arg_494_1.actors_[var_497_3.prefab_name] ~= nil then
						local var_497_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_494_1.actors_[var_497_3.prefab_name].transform, "story_v_out_411051", "411051119", "story_v_out_411051.awb")

						arg_494_1:RecordAudio("411051119", var_497_9)
						arg_494_1:RecordAudio("411051119", var_497_9)
					else
						arg_494_1:AudioAction("play", "voice", "story_v_out_411051", "411051119", "story_v_out_411051.awb")
					end

					arg_494_1:RecordHistoryTalkVoice("story_v_out_411051", "411051119", "story_v_out_411051.awb")
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
	Play411051120 = function(arg_498_0, arg_498_1)
		arg_498_1.time_ = 0
		arg_498_1.frameCnt_ = 0
		arg_498_1.state_ = "playing"
		arg_498_1.curTalkId_ = 411051120
		arg_498_1.duration_ = 8.43

		local var_498_0 = {
			zh = 8.433,
			ja = 6.9
		}
		local var_498_1 = manager.audio:GetLocalizationFlag()

		if var_498_0[var_498_1] ~= nil then
			arg_498_1.duration_ = var_498_0[var_498_1]
		end

		SetActive(arg_498_1.tipsGo_, false)

		function arg_498_1.onSingleLineFinish_()
			arg_498_1.onSingleLineUpdate_ = nil
			arg_498_1.onSingleLineFinish_ = nil
			arg_498_1.state_ = "waiting"
		end

		function arg_498_1.playNext_(arg_500_0)
			if arg_500_0 == 1 then
				arg_498_0:Play411051121(arg_498_1)
			end
		end

		function arg_498_1.onSingleLineUpdate_(arg_501_0)
			local var_501_0 = arg_498_1.actors_["1095ui_story"].transform
			local var_501_1 = 0

			if var_501_1 < arg_498_1.time_ and arg_498_1.time_ <= var_501_1 + arg_501_0 then
				arg_498_1.var_.moveOldPos1095ui_story = var_501_0.localPosition
			end

			local var_501_2 = 0.001

			if var_501_1 <= arg_498_1.time_ and arg_498_1.time_ < var_501_1 + var_501_2 then
				local var_501_3 = (arg_498_1.time_ - var_501_1) / var_501_2
				local var_501_4 = Vector3.New(0, -0.98, -6.1)

				var_501_0.localPosition = Vector3.Lerp(arg_498_1.var_.moveOldPos1095ui_story, var_501_4, var_501_3)

				local var_501_5 = manager.ui.mainCamera.transform.position - var_501_0.position

				var_501_0.forward = Vector3.New(var_501_5.x, var_501_5.y, var_501_5.z)

				local var_501_6 = var_501_0.localEulerAngles

				var_501_6.z = 0
				var_501_6.x = 0
				var_501_0.localEulerAngles = var_501_6
			end

			if arg_498_1.time_ >= var_501_1 + var_501_2 and arg_498_1.time_ < var_501_1 + var_501_2 + arg_501_0 then
				var_501_0.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_501_7 = manager.ui.mainCamera.transform.position - var_501_0.position

				var_501_0.forward = Vector3.New(var_501_7.x, var_501_7.y, var_501_7.z)

				local var_501_8 = var_501_0.localEulerAngles

				var_501_8.z = 0
				var_501_8.x = 0
				var_501_0.localEulerAngles = var_501_8
			end

			local var_501_9 = arg_498_1.actors_["1095ui_story"]
			local var_501_10 = 0

			if var_501_10 < arg_498_1.time_ and arg_498_1.time_ <= var_501_10 + arg_501_0 and not isNil(var_501_9) and arg_498_1.var_.characterEffect1095ui_story == nil then
				arg_498_1.var_.characterEffect1095ui_story = var_501_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_501_11 = 0.200000002980232

			if var_501_10 <= arg_498_1.time_ and arg_498_1.time_ < var_501_10 + var_501_11 and not isNil(var_501_9) then
				local var_501_12 = (arg_498_1.time_ - var_501_10) / var_501_11

				if arg_498_1.var_.characterEffect1095ui_story and not isNil(var_501_9) then
					arg_498_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_498_1.time_ >= var_501_10 + var_501_11 and arg_498_1.time_ < var_501_10 + var_501_11 + arg_501_0 and not isNil(var_501_9) and arg_498_1.var_.characterEffect1095ui_story then
				arg_498_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_501_13 = 0

			if var_501_13 < arg_498_1.time_ and arg_498_1.time_ <= var_501_13 + arg_501_0 then
				arg_498_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_501_14 = 0

			if var_501_14 < arg_498_1.time_ and arg_498_1.time_ <= var_501_14 + arg_501_0 then
				arg_498_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_501_15 = 0
			local var_501_16 = 0.875

			if var_501_15 < arg_498_1.time_ and arg_498_1.time_ <= var_501_15 + arg_501_0 then
				arg_498_1.talkMaxDuration = 0
				arg_498_1.dialogCg_.alpha = 1

				arg_498_1.dialog_:SetActive(true)
				SetActive(arg_498_1.leftNameGo_, true)

				local var_501_17 = arg_498_1:FormatText(StoryNameCfg[471].name)

				arg_498_1.leftNameTxt_.text = var_501_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_498_1.leftNameTxt_.transform)

				arg_498_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_498_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_498_1:RecordName(arg_498_1.leftNameTxt_.text)
				SetActive(arg_498_1.iconTrs_.gameObject, false)
				arg_498_1.callingController_:SetSelectedState("normal")

				local var_501_18 = arg_498_1:GetWordFromCfg(411051120)
				local var_501_19 = arg_498_1:FormatText(var_501_18.content)

				arg_498_1.text_.text = var_501_19

				LuaForUtil.ClearLinePrefixSymbol(arg_498_1.text_)

				local var_501_20 = 35
				local var_501_21 = utf8.len(var_501_19)
				local var_501_22 = var_501_20 <= 0 and var_501_16 or var_501_16 * (var_501_21 / var_501_20)

				if var_501_22 > 0 and var_501_16 < var_501_22 then
					arg_498_1.talkMaxDuration = var_501_22

					if var_501_22 + var_501_15 > arg_498_1.duration_ then
						arg_498_1.duration_ = var_501_22 + var_501_15
					end
				end

				arg_498_1.text_.text = var_501_19
				arg_498_1.typewritter.percent = 0

				arg_498_1.typewritter:SetDirty()
				arg_498_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051120", "story_v_out_411051.awb") ~= 0 then
					local var_501_23 = manager.audio:GetVoiceLength("story_v_out_411051", "411051120", "story_v_out_411051.awb") / 1000

					if var_501_23 + var_501_15 > arg_498_1.duration_ then
						arg_498_1.duration_ = var_501_23 + var_501_15
					end

					if var_501_18.prefab_name ~= "" and arg_498_1.actors_[var_501_18.prefab_name] ~= nil then
						local var_501_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_498_1.actors_[var_501_18.prefab_name].transform, "story_v_out_411051", "411051120", "story_v_out_411051.awb")

						arg_498_1:RecordAudio("411051120", var_501_24)
						arg_498_1:RecordAudio("411051120", var_501_24)
					else
						arg_498_1:AudioAction("play", "voice", "story_v_out_411051", "411051120", "story_v_out_411051.awb")
					end

					arg_498_1:RecordHistoryTalkVoice("story_v_out_411051", "411051120", "story_v_out_411051.awb")
				end

				arg_498_1:RecordContent(arg_498_1.text_.text)
			end

			local var_501_25 = math.max(var_501_16, arg_498_1.talkMaxDuration)

			if var_501_15 <= arg_498_1.time_ and arg_498_1.time_ < var_501_15 + var_501_25 then
				arg_498_1.typewritter.percent = (arg_498_1.time_ - var_501_15) / var_501_25

				arg_498_1.typewritter:SetDirty()
			end

			if arg_498_1.time_ >= var_501_15 + var_501_25 and arg_498_1.time_ < var_501_15 + var_501_25 + arg_501_0 then
				arg_498_1.typewritter.percent = 1

				arg_498_1.typewritter:SetDirty()
				arg_498_1:ShowNextGo(true)
			end
		end

		arg_498_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_498_1:InitPlayNodeList()
	end,
	Play411051121 = function(arg_502_0, arg_502_1)
		arg_502_1.time_ = 0
		arg_502_1.frameCnt_ = 0
		arg_502_1.state_ = "playing"
		arg_502_1.curTalkId_ = 411051121
		arg_502_1.duration_ = 8

		local var_502_0 = {
			zh = 8,
			ja = 6.266
		}
		local var_502_1 = manager.audio:GetLocalizationFlag()

		if var_502_0[var_502_1] ~= nil then
			arg_502_1.duration_ = var_502_0[var_502_1]
		end

		SetActive(arg_502_1.tipsGo_, false)

		function arg_502_1.onSingleLineFinish_()
			arg_502_1.onSingleLineUpdate_ = nil
			arg_502_1.onSingleLineFinish_ = nil
			arg_502_1.state_ = "waiting"
		end

		function arg_502_1.playNext_(arg_504_0)
			if arg_504_0 == 1 then
				arg_502_0:Play411051122(arg_502_1)
			end
		end

		function arg_502_1.onSingleLineUpdate_(arg_505_0)
			local var_505_0 = arg_502_1.actors_["1095ui_story"]
			local var_505_1 = 0

			if var_505_1 < arg_502_1.time_ and arg_502_1.time_ <= var_505_1 + arg_505_0 and not isNil(var_505_0) and arg_502_1.var_.characterEffect1095ui_story == nil then
				arg_502_1.var_.characterEffect1095ui_story = var_505_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_505_2 = 0.200000002980232

			if var_505_1 <= arg_502_1.time_ and arg_502_1.time_ < var_505_1 + var_505_2 and not isNil(var_505_0) then
				local var_505_3 = (arg_502_1.time_ - var_505_1) / var_505_2

				if arg_502_1.var_.characterEffect1095ui_story and not isNil(var_505_0) then
					local var_505_4 = Mathf.Lerp(0, 0.5, var_505_3)

					arg_502_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_502_1.var_.characterEffect1095ui_story.fillRatio = var_505_4
				end
			end

			if arg_502_1.time_ >= var_505_1 + var_505_2 and arg_502_1.time_ < var_505_1 + var_505_2 + arg_505_0 and not isNil(var_505_0) and arg_502_1.var_.characterEffect1095ui_story then
				local var_505_5 = 0.5

				arg_502_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_502_1.var_.characterEffect1095ui_story.fillRatio = var_505_5
			end

			local var_505_6 = 0
			local var_505_7 = 0.875

			if var_505_6 < arg_502_1.time_ and arg_502_1.time_ <= var_505_6 + arg_505_0 then
				arg_502_1.talkMaxDuration = 0
				arg_502_1.dialogCg_.alpha = 1

				arg_502_1.dialog_:SetActive(true)
				SetActive(arg_502_1.leftNameGo_, true)

				local var_505_8 = arg_502_1:FormatText(StoryNameCfg[39].name)

				arg_502_1.leftNameTxt_.text = var_505_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_502_1.leftNameTxt_.transform)

				arg_502_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_502_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_502_1:RecordName(arg_502_1.leftNameTxt_.text)
				SetActive(arg_502_1.iconTrs_.gameObject, true)
				arg_502_1.iconController_:SetSelectedState("hero")

				arg_502_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10002a")

				arg_502_1.callingController_:SetSelectedState("normal")

				arg_502_1.keyicon_.color = Color.New(1, 1, 1)
				arg_502_1.icon_.color = Color.New(1, 1, 1)

				local var_505_9 = arg_502_1:GetWordFromCfg(411051121)
				local var_505_10 = arg_502_1:FormatText(var_505_9.content)

				arg_502_1.text_.text = var_505_10

				LuaForUtil.ClearLinePrefixSymbol(arg_502_1.text_)

				local var_505_11 = 35
				local var_505_12 = utf8.len(var_505_10)
				local var_505_13 = var_505_11 <= 0 and var_505_7 or var_505_7 * (var_505_12 / var_505_11)

				if var_505_13 > 0 and var_505_7 < var_505_13 then
					arg_502_1.talkMaxDuration = var_505_13

					if var_505_13 + var_505_6 > arg_502_1.duration_ then
						arg_502_1.duration_ = var_505_13 + var_505_6
					end
				end

				arg_502_1.text_.text = var_505_10
				arg_502_1.typewritter.percent = 0

				arg_502_1.typewritter:SetDirty()
				arg_502_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051121", "story_v_out_411051.awb") ~= 0 then
					local var_505_14 = manager.audio:GetVoiceLength("story_v_out_411051", "411051121", "story_v_out_411051.awb") / 1000

					if var_505_14 + var_505_6 > arg_502_1.duration_ then
						arg_502_1.duration_ = var_505_14 + var_505_6
					end

					if var_505_9.prefab_name ~= "" and arg_502_1.actors_[var_505_9.prefab_name] ~= nil then
						local var_505_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_502_1.actors_[var_505_9.prefab_name].transform, "story_v_out_411051", "411051121", "story_v_out_411051.awb")

						arg_502_1:RecordAudio("411051121", var_505_15)
						arg_502_1:RecordAudio("411051121", var_505_15)
					else
						arg_502_1:AudioAction("play", "voice", "story_v_out_411051", "411051121", "story_v_out_411051.awb")
					end

					arg_502_1:RecordHistoryTalkVoice("story_v_out_411051", "411051121", "story_v_out_411051.awb")
				end

				arg_502_1:RecordContent(arg_502_1.text_.text)
			end

			local var_505_16 = math.max(var_505_7, arg_502_1.talkMaxDuration)

			if var_505_6 <= arg_502_1.time_ and arg_502_1.time_ < var_505_6 + var_505_16 then
				arg_502_1.typewritter.percent = (arg_502_1.time_ - var_505_6) / var_505_16

				arg_502_1.typewritter:SetDirty()
			end

			if arg_502_1.time_ >= var_505_6 + var_505_16 and arg_502_1.time_ < var_505_6 + var_505_16 + arg_505_0 then
				arg_502_1.typewritter.percent = 1

				arg_502_1.typewritter:SetDirty()
				arg_502_1:ShowNextGo(true)
			end
		end

		arg_502_1.nodeConfigList_ = {}

		arg_502_1:InitPlayNodeList()
	end,
	Play411051122 = function(arg_506_0, arg_506_1)
		arg_506_1.time_ = 0
		arg_506_1.frameCnt_ = 0
		arg_506_1.state_ = "playing"
		arg_506_1.curTalkId_ = 411051122
		arg_506_1.duration_ = 7.77

		local var_506_0 = {
			zh = 6.433,
			ja = 7.766
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
				arg_506_0:Play411051123(arg_506_1)
			end
		end

		function arg_506_1.onSingleLineUpdate_(arg_509_0)
			local var_509_0 = arg_506_1.actors_["1095ui_story"]
			local var_509_1 = 0

			if var_509_1 < arg_506_1.time_ and arg_506_1.time_ <= var_509_1 + arg_509_0 and not isNil(var_509_0) and arg_506_1.var_.characterEffect1095ui_story == nil then
				arg_506_1.var_.characterEffect1095ui_story = var_509_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_509_2 = 0.200000002980232

			if var_509_1 <= arg_506_1.time_ and arg_506_1.time_ < var_509_1 + var_509_2 and not isNil(var_509_0) then
				local var_509_3 = (arg_506_1.time_ - var_509_1) / var_509_2

				if arg_506_1.var_.characterEffect1095ui_story and not isNil(var_509_0) then
					arg_506_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_506_1.time_ >= var_509_1 + var_509_2 and arg_506_1.time_ < var_509_1 + var_509_2 + arg_509_0 and not isNil(var_509_0) and arg_506_1.var_.characterEffect1095ui_story then
				arg_506_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_509_4 = 0
			local var_509_5 = 0.575

			if var_509_4 < arg_506_1.time_ and arg_506_1.time_ <= var_509_4 + arg_509_0 then
				arg_506_1.talkMaxDuration = 0
				arg_506_1.dialogCg_.alpha = 1

				arg_506_1.dialog_:SetActive(true)
				SetActive(arg_506_1.leftNameGo_, true)

				local var_509_6 = arg_506_1:FormatText(StoryNameCfg[471].name)

				arg_506_1.leftNameTxt_.text = var_509_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_506_1.leftNameTxt_.transform)

				arg_506_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_506_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_506_1:RecordName(arg_506_1.leftNameTxt_.text)
				SetActive(arg_506_1.iconTrs_.gameObject, false)
				arg_506_1.callingController_:SetSelectedState("normal")

				local var_509_7 = arg_506_1:GetWordFromCfg(411051122)
				local var_509_8 = arg_506_1:FormatText(var_509_7.content)

				arg_506_1.text_.text = var_509_8

				LuaForUtil.ClearLinePrefixSymbol(arg_506_1.text_)

				local var_509_9 = 23
				local var_509_10 = utf8.len(var_509_8)
				local var_509_11 = var_509_9 <= 0 and var_509_5 or var_509_5 * (var_509_10 / var_509_9)

				if var_509_11 > 0 and var_509_5 < var_509_11 then
					arg_506_1.talkMaxDuration = var_509_11

					if var_509_11 + var_509_4 > arg_506_1.duration_ then
						arg_506_1.duration_ = var_509_11 + var_509_4
					end
				end

				arg_506_1.text_.text = var_509_8
				arg_506_1.typewritter.percent = 0

				arg_506_1.typewritter:SetDirty()
				arg_506_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051122", "story_v_out_411051.awb") ~= 0 then
					local var_509_12 = manager.audio:GetVoiceLength("story_v_out_411051", "411051122", "story_v_out_411051.awb") / 1000

					if var_509_12 + var_509_4 > arg_506_1.duration_ then
						arg_506_1.duration_ = var_509_12 + var_509_4
					end

					if var_509_7.prefab_name ~= "" and arg_506_1.actors_[var_509_7.prefab_name] ~= nil then
						local var_509_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_506_1.actors_[var_509_7.prefab_name].transform, "story_v_out_411051", "411051122", "story_v_out_411051.awb")

						arg_506_1:RecordAudio("411051122", var_509_13)
						arg_506_1:RecordAudio("411051122", var_509_13)
					else
						arg_506_1:AudioAction("play", "voice", "story_v_out_411051", "411051122", "story_v_out_411051.awb")
					end

					arg_506_1:RecordHistoryTalkVoice("story_v_out_411051", "411051122", "story_v_out_411051.awb")
				end

				arg_506_1:RecordContent(arg_506_1.text_.text)
			end

			local var_509_14 = math.max(var_509_5, arg_506_1.talkMaxDuration)

			if var_509_4 <= arg_506_1.time_ and arg_506_1.time_ < var_509_4 + var_509_14 then
				arg_506_1.typewritter.percent = (arg_506_1.time_ - var_509_4) / var_509_14

				arg_506_1.typewritter:SetDirty()
			end

			if arg_506_1.time_ >= var_509_4 + var_509_14 and arg_506_1.time_ < var_509_4 + var_509_14 + arg_509_0 then
				arg_506_1.typewritter.percent = 1

				arg_506_1.typewritter:SetDirty()
				arg_506_1:ShowNextGo(true)
			end
		end

		arg_506_1.nodeConfigList_ = {}

		arg_506_1:InitPlayNodeList()
	end,
	Play411051123 = function(arg_510_0, arg_510_1)
		arg_510_1.time_ = 0
		arg_510_1.frameCnt_ = 0
		arg_510_1.state_ = "playing"
		arg_510_1.curTalkId_ = 411051123
		arg_510_1.duration_ = 5.6

		local var_510_0 = {
			zh = 5.6,
			ja = 5.566
		}
		local var_510_1 = manager.audio:GetLocalizationFlag()

		if var_510_0[var_510_1] ~= nil then
			arg_510_1.duration_ = var_510_0[var_510_1]
		end

		SetActive(arg_510_1.tipsGo_, false)

		function arg_510_1.onSingleLineFinish_()
			arg_510_1.onSingleLineUpdate_ = nil
			arg_510_1.onSingleLineFinish_ = nil
			arg_510_1.state_ = "waiting"
		end

		function arg_510_1.playNext_(arg_512_0)
			if arg_512_0 == 1 then
				arg_510_0:Play411051124(arg_510_1)
			end
		end

		function arg_510_1.onSingleLineUpdate_(arg_513_0)
			local var_513_0 = arg_510_1.actors_["1095ui_story"]
			local var_513_1 = 0

			if var_513_1 < arg_510_1.time_ and arg_510_1.time_ <= var_513_1 + arg_513_0 and not isNil(var_513_0) and arg_510_1.var_.characterEffect1095ui_story == nil then
				arg_510_1.var_.characterEffect1095ui_story = var_513_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_513_2 = 0.200000002980232

			if var_513_1 <= arg_510_1.time_ and arg_510_1.time_ < var_513_1 + var_513_2 and not isNil(var_513_0) then
				local var_513_3 = (arg_510_1.time_ - var_513_1) / var_513_2

				if arg_510_1.var_.characterEffect1095ui_story and not isNil(var_513_0) then
					local var_513_4 = Mathf.Lerp(0, 0.5, var_513_3)

					arg_510_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_510_1.var_.characterEffect1095ui_story.fillRatio = var_513_4
				end
			end

			if arg_510_1.time_ >= var_513_1 + var_513_2 and arg_510_1.time_ < var_513_1 + var_513_2 + arg_513_0 and not isNil(var_513_0) and arg_510_1.var_.characterEffect1095ui_story then
				local var_513_5 = 0.5

				arg_510_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_510_1.var_.characterEffect1095ui_story.fillRatio = var_513_5
			end

			local var_513_6 = 0
			local var_513_7 = 0.5

			if var_513_6 < arg_510_1.time_ and arg_510_1.time_ <= var_513_6 + arg_513_0 then
				arg_510_1.talkMaxDuration = 0
				arg_510_1.dialogCg_.alpha = 1

				arg_510_1.dialog_:SetActive(true)
				SetActive(arg_510_1.leftNameGo_, true)

				local var_513_8 = arg_510_1:FormatText(StoryNameCfg[39].name)

				arg_510_1.leftNameTxt_.text = var_513_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_510_1.leftNameTxt_.transform)

				arg_510_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_510_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_510_1:RecordName(arg_510_1.leftNameTxt_.text)
				SetActive(arg_510_1.iconTrs_.gameObject, true)
				arg_510_1.iconController_:SetSelectedState("hero")

				arg_510_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10002a")

				arg_510_1.callingController_:SetSelectedState("normal")

				arg_510_1.keyicon_.color = Color.New(1, 1, 1)
				arg_510_1.icon_.color = Color.New(1, 1, 1)

				local var_513_9 = arg_510_1:GetWordFromCfg(411051123)
				local var_513_10 = arg_510_1:FormatText(var_513_9.content)

				arg_510_1.text_.text = var_513_10

				LuaForUtil.ClearLinePrefixSymbol(arg_510_1.text_)

				local var_513_11 = 20
				local var_513_12 = utf8.len(var_513_10)
				local var_513_13 = var_513_11 <= 0 and var_513_7 or var_513_7 * (var_513_12 / var_513_11)

				if var_513_13 > 0 and var_513_7 < var_513_13 then
					arg_510_1.talkMaxDuration = var_513_13

					if var_513_13 + var_513_6 > arg_510_1.duration_ then
						arg_510_1.duration_ = var_513_13 + var_513_6
					end
				end

				arg_510_1.text_.text = var_513_10
				arg_510_1.typewritter.percent = 0

				arg_510_1.typewritter:SetDirty()
				arg_510_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051123", "story_v_out_411051.awb") ~= 0 then
					local var_513_14 = manager.audio:GetVoiceLength("story_v_out_411051", "411051123", "story_v_out_411051.awb") / 1000

					if var_513_14 + var_513_6 > arg_510_1.duration_ then
						arg_510_1.duration_ = var_513_14 + var_513_6
					end

					if var_513_9.prefab_name ~= "" and arg_510_1.actors_[var_513_9.prefab_name] ~= nil then
						local var_513_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_510_1.actors_[var_513_9.prefab_name].transform, "story_v_out_411051", "411051123", "story_v_out_411051.awb")

						arg_510_1:RecordAudio("411051123", var_513_15)
						arg_510_1:RecordAudio("411051123", var_513_15)
					else
						arg_510_1:AudioAction("play", "voice", "story_v_out_411051", "411051123", "story_v_out_411051.awb")
					end

					arg_510_1:RecordHistoryTalkVoice("story_v_out_411051", "411051123", "story_v_out_411051.awb")
				end

				arg_510_1:RecordContent(arg_510_1.text_.text)
			end

			local var_513_16 = math.max(var_513_7, arg_510_1.talkMaxDuration)

			if var_513_6 <= arg_510_1.time_ and arg_510_1.time_ < var_513_6 + var_513_16 then
				arg_510_1.typewritter.percent = (arg_510_1.time_ - var_513_6) / var_513_16

				arg_510_1.typewritter:SetDirty()
			end

			if arg_510_1.time_ >= var_513_6 + var_513_16 and arg_510_1.time_ < var_513_6 + var_513_16 + arg_513_0 then
				arg_510_1.typewritter.percent = 1

				arg_510_1.typewritter:SetDirty()
				arg_510_1:ShowNextGo(true)
			end
		end

		arg_510_1.nodeConfigList_ = {}

		arg_510_1:InitPlayNodeList()
	end,
	Play411051124 = function(arg_514_0, arg_514_1)
		arg_514_1.time_ = 0
		arg_514_1.frameCnt_ = 0
		arg_514_1.state_ = "playing"
		arg_514_1.curTalkId_ = 411051124
		arg_514_1.duration_ = 4.1

		local var_514_0 = {
			zh = 3,
			ja = 4.1
		}
		local var_514_1 = manager.audio:GetLocalizationFlag()

		if var_514_0[var_514_1] ~= nil then
			arg_514_1.duration_ = var_514_0[var_514_1]
		end

		SetActive(arg_514_1.tipsGo_, false)

		function arg_514_1.onSingleLineFinish_()
			arg_514_1.onSingleLineUpdate_ = nil
			arg_514_1.onSingleLineFinish_ = nil
			arg_514_1.state_ = "waiting"
		end

		function arg_514_1.playNext_(arg_516_0)
			if arg_516_0 == 1 then
				arg_514_0:Play411051125(arg_514_1)
			end
		end

		function arg_514_1.onSingleLineUpdate_(arg_517_0)
			local var_517_0 = arg_514_1.actors_["1095ui_story"]
			local var_517_1 = 0

			if var_517_1 < arg_514_1.time_ and arg_514_1.time_ <= var_517_1 + arg_517_0 and not isNil(var_517_0) and arg_514_1.var_.characterEffect1095ui_story == nil then
				arg_514_1.var_.characterEffect1095ui_story = var_517_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_517_2 = 0.200000002980232

			if var_517_1 <= arg_514_1.time_ and arg_514_1.time_ < var_517_1 + var_517_2 and not isNil(var_517_0) then
				local var_517_3 = (arg_514_1.time_ - var_517_1) / var_517_2

				if arg_514_1.var_.characterEffect1095ui_story and not isNil(var_517_0) then
					arg_514_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_514_1.time_ >= var_517_1 + var_517_2 and arg_514_1.time_ < var_517_1 + var_517_2 + arg_517_0 and not isNil(var_517_0) and arg_514_1.var_.characterEffect1095ui_story then
				arg_514_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_517_4 = 0
			local var_517_5 = 0.375

			if var_517_4 < arg_514_1.time_ and arg_514_1.time_ <= var_517_4 + arg_517_0 then
				arg_514_1.talkMaxDuration = 0
				arg_514_1.dialogCg_.alpha = 1

				arg_514_1.dialog_:SetActive(true)
				SetActive(arg_514_1.leftNameGo_, true)

				local var_517_6 = arg_514_1:FormatText(StoryNameCfg[471].name)

				arg_514_1.leftNameTxt_.text = var_517_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_514_1.leftNameTxt_.transform)

				arg_514_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_514_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_514_1:RecordName(arg_514_1.leftNameTxt_.text)
				SetActive(arg_514_1.iconTrs_.gameObject, false)
				arg_514_1.callingController_:SetSelectedState("normal")

				local var_517_7 = arg_514_1:GetWordFromCfg(411051124)
				local var_517_8 = arg_514_1:FormatText(var_517_7.content)

				arg_514_1.text_.text = var_517_8

				LuaForUtil.ClearLinePrefixSymbol(arg_514_1.text_)

				local var_517_9 = 15
				local var_517_10 = utf8.len(var_517_8)
				local var_517_11 = var_517_9 <= 0 and var_517_5 or var_517_5 * (var_517_10 / var_517_9)

				if var_517_11 > 0 and var_517_5 < var_517_11 then
					arg_514_1.talkMaxDuration = var_517_11

					if var_517_11 + var_517_4 > arg_514_1.duration_ then
						arg_514_1.duration_ = var_517_11 + var_517_4
					end
				end

				arg_514_1.text_.text = var_517_8
				arg_514_1.typewritter.percent = 0

				arg_514_1.typewritter:SetDirty()
				arg_514_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051124", "story_v_out_411051.awb") ~= 0 then
					local var_517_12 = manager.audio:GetVoiceLength("story_v_out_411051", "411051124", "story_v_out_411051.awb") / 1000

					if var_517_12 + var_517_4 > arg_514_1.duration_ then
						arg_514_1.duration_ = var_517_12 + var_517_4
					end

					if var_517_7.prefab_name ~= "" and arg_514_1.actors_[var_517_7.prefab_name] ~= nil then
						local var_517_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_514_1.actors_[var_517_7.prefab_name].transform, "story_v_out_411051", "411051124", "story_v_out_411051.awb")

						arg_514_1:RecordAudio("411051124", var_517_13)
						arg_514_1:RecordAudio("411051124", var_517_13)
					else
						arg_514_1:AudioAction("play", "voice", "story_v_out_411051", "411051124", "story_v_out_411051.awb")
					end

					arg_514_1:RecordHistoryTalkVoice("story_v_out_411051", "411051124", "story_v_out_411051.awb")
				end

				arg_514_1:RecordContent(arg_514_1.text_.text)
			end

			local var_517_14 = math.max(var_517_5, arg_514_1.talkMaxDuration)

			if var_517_4 <= arg_514_1.time_ and arg_514_1.time_ < var_517_4 + var_517_14 then
				arg_514_1.typewritter.percent = (arg_514_1.time_ - var_517_4) / var_517_14

				arg_514_1.typewritter:SetDirty()
			end

			if arg_514_1.time_ >= var_517_4 + var_517_14 and arg_514_1.time_ < var_517_4 + var_517_14 + arg_517_0 then
				arg_514_1.typewritter.percent = 1

				arg_514_1.typewritter:SetDirty()
				arg_514_1:ShowNextGo(true)
			end
		end

		arg_514_1.nodeConfigList_ = {}

		arg_514_1:InitPlayNodeList()
	end,
	Play411051125 = function(arg_518_0, arg_518_1)
		arg_518_1.time_ = 0
		arg_518_1.frameCnt_ = 0
		arg_518_1.state_ = "playing"
		arg_518_1.curTalkId_ = 411051125
		arg_518_1.duration_ = 9.17

		local var_518_0 = {
			zh = 9.166,
			ja = 6.5
		}
		local var_518_1 = manager.audio:GetLocalizationFlag()

		if var_518_0[var_518_1] ~= nil then
			arg_518_1.duration_ = var_518_0[var_518_1]
		end

		SetActive(arg_518_1.tipsGo_, false)

		function arg_518_1.onSingleLineFinish_()
			arg_518_1.onSingleLineUpdate_ = nil
			arg_518_1.onSingleLineFinish_ = nil
			arg_518_1.state_ = "waiting"
		end

		function arg_518_1.playNext_(arg_520_0)
			if arg_520_0 == 1 then
				arg_518_0:Play411051126(arg_518_1)
			end
		end

		function arg_518_1.onSingleLineUpdate_(arg_521_0)
			local var_521_0 = arg_518_1.actors_["1095ui_story"]
			local var_521_1 = 0

			if var_521_1 < arg_518_1.time_ and arg_518_1.time_ <= var_521_1 + arg_521_0 and not isNil(var_521_0) and arg_518_1.var_.characterEffect1095ui_story == nil then
				arg_518_1.var_.characterEffect1095ui_story = var_521_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_521_2 = 0.200000002980232

			if var_521_1 <= arg_518_1.time_ and arg_518_1.time_ < var_521_1 + var_521_2 and not isNil(var_521_0) then
				local var_521_3 = (arg_518_1.time_ - var_521_1) / var_521_2

				if arg_518_1.var_.characterEffect1095ui_story and not isNil(var_521_0) then
					local var_521_4 = Mathf.Lerp(0, 0.5, var_521_3)

					arg_518_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_518_1.var_.characterEffect1095ui_story.fillRatio = var_521_4
				end
			end

			if arg_518_1.time_ >= var_521_1 + var_521_2 and arg_518_1.time_ < var_521_1 + var_521_2 + arg_521_0 and not isNil(var_521_0) and arg_518_1.var_.characterEffect1095ui_story then
				local var_521_5 = 0.5

				arg_518_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_518_1.var_.characterEffect1095ui_story.fillRatio = var_521_5
			end

			local var_521_6 = 0
			local var_521_7 = 0.95

			if var_521_6 < arg_518_1.time_ and arg_518_1.time_ <= var_521_6 + arg_521_0 then
				arg_518_1.talkMaxDuration = 0
				arg_518_1.dialogCg_.alpha = 1

				arg_518_1.dialog_:SetActive(true)
				SetActive(arg_518_1.leftNameGo_, true)

				local var_521_8 = arg_518_1:FormatText(StoryNameCfg[39].name)

				arg_518_1.leftNameTxt_.text = var_521_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_518_1.leftNameTxt_.transform)

				arg_518_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_518_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_518_1:RecordName(arg_518_1.leftNameTxt_.text)
				SetActive(arg_518_1.iconTrs_.gameObject, true)
				arg_518_1.iconController_:SetSelectedState("hero")

				arg_518_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10002a")

				arg_518_1.callingController_:SetSelectedState("normal")

				arg_518_1.keyicon_.color = Color.New(1, 1, 1)
				arg_518_1.icon_.color = Color.New(1, 1, 1)

				local var_521_9 = arg_518_1:GetWordFromCfg(411051125)
				local var_521_10 = arg_518_1:FormatText(var_521_9.content)

				arg_518_1.text_.text = var_521_10

				LuaForUtil.ClearLinePrefixSymbol(arg_518_1.text_)

				local var_521_11 = 38
				local var_521_12 = utf8.len(var_521_10)
				local var_521_13 = var_521_11 <= 0 and var_521_7 or var_521_7 * (var_521_12 / var_521_11)

				if var_521_13 > 0 and var_521_7 < var_521_13 then
					arg_518_1.talkMaxDuration = var_521_13

					if var_521_13 + var_521_6 > arg_518_1.duration_ then
						arg_518_1.duration_ = var_521_13 + var_521_6
					end
				end

				arg_518_1.text_.text = var_521_10
				arg_518_1.typewritter.percent = 0

				arg_518_1.typewritter:SetDirty()
				arg_518_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051125", "story_v_out_411051.awb") ~= 0 then
					local var_521_14 = manager.audio:GetVoiceLength("story_v_out_411051", "411051125", "story_v_out_411051.awb") / 1000

					if var_521_14 + var_521_6 > arg_518_1.duration_ then
						arg_518_1.duration_ = var_521_14 + var_521_6
					end

					if var_521_9.prefab_name ~= "" and arg_518_1.actors_[var_521_9.prefab_name] ~= nil then
						local var_521_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_518_1.actors_[var_521_9.prefab_name].transform, "story_v_out_411051", "411051125", "story_v_out_411051.awb")

						arg_518_1:RecordAudio("411051125", var_521_15)
						arg_518_1:RecordAudio("411051125", var_521_15)
					else
						arg_518_1:AudioAction("play", "voice", "story_v_out_411051", "411051125", "story_v_out_411051.awb")
					end

					arg_518_1:RecordHistoryTalkVoice("story_v_out_411051", "411051125", "story_v_out_411051.awb")
				end

				arg_518_1:RecordContent(arg_518_1.text_.text)
			end

			local var_521_16 = math.max(var_521_7, arg_518_1.talkMaxDuration)

			if var_521_6 <= arg_518_1.time_ and arg_518_1.time_ < var_521_6 + var_521_16 then
				arg_518_1.typewritter.percent = (arg_518_1.time_ - var_521_6) / var_521_16

				arg_518_1.typewritter:SetDirty()
			end

			if arg_518_1.time_ >= var_521_6 + var_521_16 and arg_518_1.time_ < var_521_6 + var_521_16 + arg_521_0 then
				arg_518_1.typewritter.percent = 1

				arg_518_1.typewritter:SetDirty()
				arg_518_1:ShowNextGo(true)
			end
		end

		arg_518_1.nodeConfigList_ = {}

		arg_518_1:InitPlayNodeList()
	end,
	Play411051126 = function(arg_522_0, arg_522_1)
		arg_522_1.time_ = 0
		arg_522_1.frameCnt_ = 0
		arg_522_1.state_ = "playing"
		arg_522_1.curTalkId_ = 411051126
		arg_522_1.duration_ = 14.3

		local var_522_0 = {
			zh = 14.3,
			ja = 4.766
		}
		local var_522_1 = manager.audio:GetLocalizationFlag()

		if var_522_0[var_522_1] ~= nil then
			arg_522_1.duration_ = var_522_0[var_522_1]
		end

		SetActive(arg_522_1.tipsGo_, false)

		function arg_522_1.onSingleLineFinish_()
			arg_522_1.onSingleLineUpdate_ = nil
			arg_522_1.onSingleLineFinish_ = nil
			arg_522_1.state_ = "waiting"
		end

		function arg_522_1.playNext_(arg_524_0)
			if arg_524_0 == 1 then
				arg_522_0:Play411051127(arg_522_1)
			end
		end

		function arg_522_1.onSingleLineUpdate_(arg_525_0)
			local var_525_0 = 0
			local var_525_1 = 1.425

			if var_525_0 < arg_522_1.time_ and arg_522_1.time_ <= var_525_0 + arg_525_0 then
				arg_522_1.talkMaxDuration = 0
				arg_522_1.dialogCg_.alpha = 1

				arg_522_1.dialog_:SetActive(true)
				SetActive(arg_522_1.leftNameGo_, true)

				local var_525_2 = arg_522_1:FormatText(StoryNameCfg[39].name)

				arg_522_1.leftNameTxt_.text = var_525_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_522_1.leftNameTxt_.transform)

				arg_522_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_522_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_522_1:RecordName(arg_522_1.leftNameTxt_.text)
				SetActive(arg_522_1.iconTrs_.gameObject, true)
				arg_522_1.iconController_:SetSelectedState("hero")

				arg_522_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10002a")

				arg_522_1.callingController_:SetSelectedState("normal")

				arg_522_1.keyicon_.color = Color.New(1, 1, 1)
				arg_522_1.icon_.color = Color.New(1, 1, 1)

				local var_525_3 = arg_522_1:GetWordFromCfg(411051126)
				local var_525_4 = arg_522_1:FormatText(var_525_3.content)

				arg_522_1.text_.text = var_525_4

				LuaForUtil.ClearLinePrefixSymbol(arg_522_1.text_)

				local var_525_5 = 57
				local var_525_6 = utf8.len(var_525_4)
				local var_525_7 = var_525_5 <= 0 and var_525_1 or var_525_1 * (var_525_6 / var_525_5)

				if var_525_7 > 0 and var_525_1 < var_525_7 then
					arg_522_1.talkMaxDuration = var_525_7

					if var_525_7 + var_525_0 > arg_522_1.duration_ then
						arg_522_1.duration_ = var_525_7 + var_525_0
					end
				end

				arg_522_1.text_.text = var_525_4
				arg_522_1.typewritter.percent = 0

				arg_522_1.typewritter:SetDirty()
				arg_522_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051126", "story_v_out_411051.awb") ~= 0 then
					local var_525_8 = manager.audio:GetVoiceLength("story_v_out_411051", "411051126", "story_v_out_411051.awb") / 1000

					if var_525_8 + var_525_0 > arg_522_1.duration_ then
						arg_522_1.duration_ = var_525_8 + var_525_0
					end

					if var_525_3.prefab_name ~= "" and arg_522_1.actors_[var_525_3.prefab_name] ~= nil then
						local var_525_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_522_1.actors_[var_525_3.prefab_name].transform, "story_v_out_411051", "411051126", "story_v_out_411051.awb")

						arg_522_1:RecordAudio("411051126", var_525_9)
						arg_522_1:RecordAudio("411051126", var_525_9)
					else
						arg_522_1:AudioAction("play", "voice", "story_v_out_411051", "411051126", "story_v_out_411051.awb")
					end

					arg_522_1:RecordHistoryTalkVoice("story_v_out_411051", "411051126", "story_v_out_411051.awb")
				end

				arg_522_1:RecordContent(arg_522_1.text_.text)
			end

			local var_525_10 = math.max(var_525_1, arg_522_1.talkMaxDuration)

			if var_525_0 <= arg_522_1.time_ and arg_522_1.time_ < var_525_0 + var_525_10 then
				arg_522_1.typewritter.percent = (arg_522_1.time_ - var_525_0) / var_525_10

				arg_522_1.typewritter:SetDirty()
			end

			if arg_522_1.time_ >= var_525_0 + var_525_10 and arg_522_1.time_ < var_525_0 + var_525_10 + arg_525_0 then
				arg_522_1.typewritter.percent = 1

				arg_522_1.typewritter:SetDirty()
				arg_522_1:ShowNextGo(true)
			end
		end

		arg_522_1.nodeConfigList_ = {}

		arg_522_1:InitPlayNodeList()
	end,
	Play411051127 = function(arg_526_0, arg_526_1)
		arg_526_1.time_ = 0
		arg_526_1.frameCnt_ = 0
		arg_526_1.state_ = "playing"
		arg_526_1.curTalkId_ = 411051127
		arg_526_1.duration_ = 4.4

		local var_526_0 = {
			zh = 4.4,
			ja = 3.1
		}
		local var_526_1 = manager.audio:GetLocalizationFlag()

		if var_526_0[var_526_1] ~= nil then
			arg_526_1.duration_ = var_526_0[var_526_1]
		end

		SetActive(arg_526_1.tipsGo_, false)

		function arg_526_1.onSingleLineFinish_()
			arg_526_1.onSingleLineUpdate_ = nil
			arg_526_1.onSingleLineFinish_ = nil
			arg_526_1.state_ = "waiting"
		end

		function arg_526_1.playNext_(arg_528_0)
			if arg_528_0 == 1 then
				arg_526_0:Play411051128(arg_526_1)
			end
		end

		function arg_526_1.onSingleLineUpdate_(arg_529_0)
			local var_529_0 = arg_526_1.actors_["1095ui_story"]
			local var_529_1 = 0

			if var_529_1 < arg_526_1.time_ and arg_526_1.time_ <= var_529_1 + arg_529_0 and not isNil(var_529_0) and arg_526_1.var_.characterEffect1095ui_story == nil then
				arg_526_1.var_.characterEffect1095ui_story = var_529_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_529_2 = 0.200000002980232

			if var_529_1 <= arg_526_1.time_ and arg_526_1.time_ < var_529_1 + var_529_2 and not isNil(var_529_0) then
				local var_529_3 = (arg_526_1.time_ - var_529_1) / var_529_2

				if arg_526_1.var_.characterEffect1095ui_story and not isNil(var_529_0) then
					arg_526_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_526_1.time_ >= var_529_1 + var_529_2 and arg_526_1.time_ < var_529_1 + var_529_2 + arg_529_0 and not isNil(var_529_0) and arg_526_1.var_.characterEffect1095ui_story then
				arg_526_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_529_4 = 0
			local var_529_5 = 0.525

			if var_529_4 < arg_526_1.time_ and arg_526_1.time_ <= var_529_4 + arg_529_0 then
				arg_526_1.talkMaxDuration = 0
				arg_526_1.dialogCg_.alpha = 1

				arg_526_1.dialog_:SetActive(true)
				SetActive(arg_526_1.leftNameGo_, true)

				local var_529_6 = arg_526_1:FormatText(StoryNameCfg[471].name)

				arg_526_1.leftNameTxt_.text = var_529_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_526_1.leftNameTxt_.transform)

				arg_526_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_526_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_526_1:RecordName(arg_526_1.leftNameTxt_.text)
				SetActive(arg_526_1.iconTrs_.gameObject, false)
				arg_526_1.callingController_:SetSelectedState("normal")

				local var_529_7 = arg_526_1:GetWordFromCfg(411051127)
				local var_529_8 = arg_526_1:FormatText(var_529_7.content)

				arg_526_1.text_.text = var_529_8

				LuaForUtil.ClearLinePrefixSymbol(arg_526_1.text_)

				local var_529_9 = 21
				local var_529_10 = utf8.len(var_529_8)
				local var_529_11 = var_529_9 <= 0 and var_529_5 or var_529_5 * (var_529_10 / var_529_9)

				if var_529_11 > 0 and var_529_5 < var_529_11 then
					arg_526_1.talkMaxDuration = var_529_11

					if var_529_11 + var_529_4 > arg_526_1.duration_ then
						arg_526_1.duration_ = var_529_11 + var_529_4
					end
				end

				arg_526_1.text_.text = var_529_8
				arg_526_1.typewritter.percent = 0

				arg_526_1.typewritter:SetDirty()
				arg_526_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051127", "story_v_out_411051.awb") ~= 0 then
					local var_529_12 = manager.audio:GetVoiceLength("story_v_out_411051", "411051127", "story_v_out_411051.awb") / 1000

					if var_529_12 + var_529_4 > arg_526_1.duration_ then
						arg_526_1.duration_ = var_529_12 + var_529_4
					end

					if var_529_7.prefab_name ~= "" and arg_526_1.actors_[var_529_7.prefab_name] ~= nil then
						local var_529_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_526_1.actors_[var_529_7.prefab_name].transform, "story_v_out_411051", "411051127", "story_v_out_411051.awb")

						arg_526_1:RecordAudio("411051127", var_529_13)
						arg_526_1:RecordAudio("411051127", var_529_13)
					else
						arg_526_1:AudioAction("play", "voice", "story_v_out_411051", "411051127", "story_v_out_411051.awb")
					end

					arg_526_1:RecordHistoryTalkVoice("story_v_out_411051", "411051127", "story_v_out_411051.awb")
				end

				arg_526_1:RecordContent(arg_526_1.text_.text)
			end

			local var_529_14 = math.max(var_529_5, arg_526_1.talkMaxDuration)

			if var_529_4 <= arg_526_1.time_ and arg_526_1.time_ < var_529_4 + var_529_14 then
				arg_526_1.typewritter.percent = (arg_526_1.time_ - var_529_4) / var_529_14

				arg_526_1.typewritter:SetDirty()
			end

			if arg_526_1.time_ >= var_529_4 + var_529_14 and arg_526_1.time_ < var_529_4 + var_529_14 + arg_529_0 then
				arg_526_1.typewritter.percent = 1

				arg_526_1.typewritter:SetDirty()
				arg_526_1:ShowNextGo(true)
			end
		end

		arg_526_1.nodeConfigList_ = {}

		arg_526_1:InitPlayNodeList()
	end,
	Play411051128 = function(arg_530_0, arg_530_1)
		arg_530_1.time_ = 0
		arg_530_1.frameCnt_ = 0
		arg_530_1.state_ = "playing"
		arg_530_1.curTalkId_ = 411051128
		arg_530_1.duration_ = 4.4

		local var_530_0 = {
			zh = 4.4,
			ja = 4.3
		}
		local var_530_1 = manager.audio:GetLocalizationFlag()

		if var_530_0[var_530_1] ~= nil then
			arg_530_1.duration_ = var_530_0[var_530_1]
		end

		SetActive(arg_530_1.tipsGo_, false)

		function arg_530_1.onSingleLineFinish_()
			arg_530_1.onSingleLineUpdate_ = nil
			arg_530_1.onSingleLineFinish_ = nil
			arg_530_1.state_ = "waiting"
		end

		function arg_530_1.playNext_(arg_532_0)
			if arg_532_0 == 1 then
				arg_530_0:Play411051129(arg_530_1)
			end
		end

		function arg_530_1.onSingleLineUpdate_(arg_533_0)
			local var_533_0 = 0
			local var_533_1 = 0.55

			if var_533_0 < arg_530_1.time_ and arg_530_1.time_ <= var_533_0 + arg_533_0 then
				arg_530_1.talkMaxDuration = 0
				arg_530_1.dialogCg_.alpha = 1

				arg_530_1.dialog_:SetActive(true)
				SetActive(arg_530_1.leftNameGo_, true)

				local var_533_2 = arg_530_1:FormatText(StoryNameCfg[471].name)

				arg_530_1.leftNameTxt_.text = var_533_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_530_1.leftNameTxt_.transform)

				arg_530_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_530_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_530_1:RecordName(arg_530_1.leftNameTxt_.text)
				SetActive(arg_530_1.iconTrs_.gameObject, false)
				arg_530_1.callingController_:SetSelectedState("normal")

				local var_533_3 = arg_530_1:GetWordFromCfg(411051128)
				local var_533_4 = arg_530_1:FormatText(var_533_3.content)

				arg_530_1.text_.text = var_533_4

				LuaForUtil.ClearLinePrefixSymbol(arg_530_1.text_)

				local var_533_5 = 22
				local var_533_6 = utf8.len(var_533_4)
				local var_533_7 = var_533_5 <= 0 and var_533_1 or var_533_1 * (var_533_6 / var_533_5)

				if var_533_7 > 0 and var_533_1 < var_533_7 then
					arg_530_1.talkMaxDuration = var_533_7

					if var_533_7 + var_533_0 > arg_530_1.duration_ then
						arg_530_1.duration_ = var_533_7 + var_533_0
					end
				end

				arg_530_1.text_.text = var_533_4
				arg_530_1.typewritter.percent = 0

				arg_530_1.typewritter:SetDirty()
				arg_530_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051128", "story_v_out_411051.awb") ~= 0 then
					local var_533_8 = manager.audio:GetVoiceLength("story_v_out_411051", "411051128", "story_v_out_411051.awb") / 1000

					if var_533_8 + var_533_0 > arg_530_1.duration_ then
						arg_530_1.duration_ = var_533_8 + var_533_0
					end

					if var_533_3.prefab_name ~= "" and arg_530_1.actors_[var_533_3.prefab_name] ~= nil then
						local var_533_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_530_1.actors_[var_533_3.prefab_name].transform, "story_v_out_411051", "411051128", "story_v_out_411051.awb")

						arg_530_1:RecordAudio("411051128", var_533_9)
						arg_530_1:RecordAudio("411051128", var_533_9)
					else
						arg_530_1:AudioAction("play", "voice", "story_v_out_411051", "411051128", "story_v_out_411051.awb")
					end

					arg_530_1:RecordHistoryTalkVoice("story_v_out_411051", "411051128", "story_v_out_411051.awb")
				end

				arg_530_1:RecordContent(arg_530_1.text_.text)
			end

			local var_533_10 = math.max(var_533_1, arg_530_1.talkMaxDuration)

			if var_533_0 <= arg_530_1.time_ and arg_530_1.time_ < var_533_0 + var_533_10 then
				arg_530_1.typewritter.percent = (arg_530_1.time_ - var_533_0) / var_533_10

				arg_530_1.typewritter:SetDirty()
			end

			if arg_530_1.time_ >= var_533_0 + var_533_10 and arg_530_1.time_ < var_533_0 + var_533_10 + arg_533_0 then
				arg_530_1.typewritter.percent = 1

				arg_530_1.typewritter:SetDirty()
				arg_530_1:ShowNextGo(true)
			end
		end

		arg_530_1.nodeConfigList_ = {}

		arg_530_1:InitPlayNodeList()
	end,
	Play411051129 = function(arg_534_0, arg_534_1)
		arg_534_1.time_ = 0
		arg_534_1.frameCnt_ = 0
		arg_534_1.state_ = "playing"
		arg_534_1.curTalkId_ = 411051129
		arg_534_1.duration_ = 2.3

		local var_534_0 = {
			zh = 2.3,
			ja = 2.133
		}
		local var_534_1 = manager.audio:GetLocalizationFlag()

		if var_534_0[var_534_1] ~= nil then
			arg_534_1.duration_ = var_534_0[var_534_1]
		end

		SetActive(arg_534_1.tipsGo_, false)

		function arg_534_1.onSingleLineFinish_()
			arg_534_1.onSingleLineUpdate_ = nil
			arg_534_1.onSingleLineFinish_ = nil
			arg_534_1.state_ = "waiting"
			arg_534_1.auto_ = false
		end

		function arg_534_1.playNext_(arg_536_0)
			arg_534_1.onStoryFinished_()
		end

		function arg_534_1.onSingleLineUpdate_(arg_537_0)
			local var_537_0 = arg_534_1.actors_["1095ui_story"]
			local var_537_1 = 0

			if var_537_1 < arg_534_1.time_ and arg_534_1.time_ <= var_537_1 + arg_537_0 and not isNil(var_537_0) and arg_534_1.var_.characterEffect1095ui_story == nil then
				arg_534_1.var_.characterEffect1095ui_story = var_537_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_537_2 = 0.200000002980232

			if var_537_1 <= arg_534_1.time_ and arg_534_1.time_ < var_537_1 + var_537_2 and not isNil(var_537_0) then
				local var_537_3 = (arg_534_1.time_ - var_537_1) / var_537_2

				if arg_534_1.var_.characterEffect1095ui_story and not isNil(var_537_0) then
					local var_537_4 = Mathf.Lerp(0, 0.5, var_537_3)

					arg_534_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_534_1.var_.characterEffect1095ui_story.fillRatio = var_537_4
				end
			end

			if arg_534_1.time_ >= var_537_1 + var_537_2 and arg_534_1.time_ < var_537_1 + var_537_2 + arg_537_0 and not isNil(var_537_0) and arg_534_1.var_.characterEffect1095ui_story then
				local var_537_5 = 0.5

				arg_534_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_534_1.var_.characterEffect1095ui_story.fillRatio = var_537_5
			end

			local var_537_6 = 0
			local var_537_7 = 0.2

			if var_537_6 < arg_534_1.time_ and arg_534_1.time_ <= var_537_6 + arg_537_0 then
				arg_534_1.talkMaxDuration = 0
				arg_534_1.dialogCg_.alpha = 1

				arg_534_1.dialog_:SetActive(true)
				SetActive(arg_534_1.leftNameGo_, true)

				local var_537_8 = arg_534_1:FormatText(StoryNameCfg[39].name)

				arg_534_1.leftNameTxt_.text = var_537_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_534_1.leftNameTxt_.transform)

				arg_534_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_534_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_534_1:RecordName(arg_534_1.leftNameTxt_.text)
				SetActive(arg_534_1.iconTrs_.gameObject, true)
				arg_534_1.iconController_:SetSelectedState("hero")

				arg_534_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10002a")

				arg_534_1.callingController_:SetSelectedState("normal")

				arg_534_1.keyicon_.color = Color.New(1, 1, 1)
				arg_534_1.icon_.color = Color.New(1, 1, 1)

				local var_537_9 = arg_534_1:GetWordFromCfg(411051129)
				local var_537_10 = arg_534_1:FormatText(var_537_9.content)

				arg_534_1.text_.text = var_537_10

				LuaForUtil.ClearLinePrefixSymbol(arg_534_1.text_)

				local var_537_11 = 8
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

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051129", "story_v_out_411051.awb") ~= 0 then
					local var_537_14 = manager.audio:GetVoiceLength("story_v_out_411051", "411051129", "story_v_out_411051.awb") / 1000

					if var_537_14 + var_537_6 > arg_534_1.duration_ then
						arg_534_1.duration_ = var_537_14 + var_537_6
					end

					if var_537_9.prefab_name ~= "" and arg_534_1.actors_[var_537_9.prefab_name] ~= nil then
						local var_537_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_534_1.actors_[var_537_9.prefab_name].transform, "story_v_out_411051", "411051129", "story_v_out_411051.awb")

						arg_534_1:RecordAudio("411051129", var_537_15)
						arg_534_1:RecordAudio("411051129", var_537_15)
					else
						arg_534_1:AudioAction("play", "voice", "story_v_out_411051", "411051129", "story_v_out_411051.awb")
					end

					arg_534_1:RecordHistoryTalkVoice("story_v_out_411051", "411051129", "story_v_out_411051.awb")
				end

				arg_534_1:RecordContent(arg_534_1.text_.text)
			end

			local var_537_16 = math.max(var_537_7, arg_534_1.talkMaxDuration)

			if var_537_6 <= arg_534_1.time_ and arg_534_1.time_ < var_537_6 + var_537_16 then
				arg_534_1.typewritter.percent = (arg_534_1.time_ - var_537_6) / var_537_16

				arg_534_1.typewritter:SetDirty()
			end

			if arg_534_1.time_ >= var_537_6 + var_537_16 and arg_534_1.time_ < var_537_6 + var_537_16 + arg_537_0 then
				arg_534_1.typewritter.percent = 1

				arg_534_1.typewritter:SetDirty()
				arg_534_1:ShowNextGo(true)
			end
		end

		arg_534_1.nodeConfigList_ = {}

		arg_534_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST74",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/ST03",
		"TextureConfig/Background/I07",
		"TextureConfig/Background/B10a"
	},
	voices = {
		"story_v_out_411051.awb"
	}
}
