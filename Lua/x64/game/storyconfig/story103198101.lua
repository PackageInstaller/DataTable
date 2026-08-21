return {
	Play319811001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 319811001
		arg_1_1.duration_ = 6.87

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play319811002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "I11m"

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
				local var_4_5 = arg_1_1.bgs_.I11m

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
					if iter_4_0 ~= "I11m" then
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
			local var_4_25 = 0.2

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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_30 = 1.86666666666667
			local var_4_31 = 0.85

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_32 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_32:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_32:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_32:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_33 = arg_1_1:GetWordFromCfg(319811001)
				local var_4_34 = arg_1_1:FormatText(var_4_33.content)

				arg_1_1.text_.text = var_4_34

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_35 = 34
				local var_4_36 = utf8.len(var_4_34)
				local var_4_37 = var_4_35 <= 0 and var_4_31 or var_4_31 * (var_4_36 / var_4_35)

				if var_4_37 > 0 and var_4_31 < var_4_37 then
					arg_1_1.talkMaxDuration = var_4_37
					var_4_30 = var_4_30 + 0.3

					if var_4_37 + var_4_30 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_37 + var_4_30
					end
				end

				arg_1_1.text_.text = var_4_34
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_38 = var_4_30 + 0.3
			local var_4_39 = math.max(var_4_31, arg_1_1.talkMaxDuration)

			if var_4_38 <= arg_1_1.time_ and arg_1_1.time_ < var_4_38 + var_4_39 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_38) / var_4_39

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_38 + var_4_39 and arg_1_1.time_ < var_4_38 + var_4_39 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play319811002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 319811002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play319811003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 0
			local var_11_1 = 0.775

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

				local var_11_2 = arg_8_1:GetWordFromCfg(319811002)
				local var_11_3 = arg_8_1:FormatText(var_11_2.content)

				arg_8_1.text_.text = var_11_3

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_4 = 31
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
	Play319811003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 319811003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play319811004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 0
			local var_15_1 = 1.075

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

				local var_15_2 = arg_12_1:GetWordFromCfg(319811003)
				local var_15_3 = arg_12_1:FormatText(var_15_2.content)

				arg_12_1.text_.text = var_15_3

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_4 = 43
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
	Play319811004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 319811004
		arg_16_1.duration_ = 5

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play319811005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = 0
			local var_19_1 = 1.325

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

				local var_19_2 = arg_16_1:GetWordFromCfg(319811004)
				local var_19_3 = arg_16_1:FormatText(var_19_2.content)

				arg_16_1.text_.text = var_19_3

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_4 = 53
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
	Play319811005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 319811005
		arg_20_1.duration_ = 5

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play319811006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = 0
			local var_23_1 = 0.875

			if var_23_0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_0 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, false)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_2 = arg_20_1:GetWordFromCfg(319811005)
				local var_23_3 = arg_20_1:FormatText(var_23_2.content)

				arg_20_1.text_.text = var_23_3

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_4 = 35
				local var_23_5 = utf8.len(var_23_3)
				local var_23_6 = var_23_4 <= 0 and var_23_1 or var_23_1 * (var_23_5 / var_23_4)

				if var_23_6 > 0 and var_23_1 < var_23_6 then
					arg_20_1.talkMaxDuration = var_23_6

					if var_23_6 + var_23_0 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_6 + var_23_0
					end
				end

				arg_20_1.text_.text = var_23_3
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)
				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_7 = math.max(var_23_1, arg_20_1.talkMaxDuration)

			if var_23_0 <= arg_20_1.time_ and arg_20_1.time_ < var_23_0 + var_23_7 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_0) / var_23_7

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_0 + var_23_7 and arg_20_1.time_ < var_23_0 + var_23_7 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play319811006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 319811006
		arg_24_1.duration_ = 7.57

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play319811007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = "ST72a"

			if arg_24_1.bgs_[var_27_0] == nil then
				local var_27_1 = Object.Instantiate(arg_24_1.paintGo_)

				var_27_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_27_0)
				var_27_1.name = var_27_0
				var_27_1.transform.parent = arg_24_1.stage_.transform
				var_27_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_24_1.bgs_[var_27_0] = var_27_1
			end

			local var_27_2 = 1

			if var_27_2 < arg_24_1.time_ and arg_24_1.time_ <= var_27_2 + arg_27_0 then
				local var_27_3 = manager.ui.mainCamera.transform.localPosition
				local var_27_4 = Vector3.New(0, 0, 10) + Vector3.New(var_27_3.x, var_27_3.y, 0)
				local var_27_5 = arg_24_1.bgs_.ST72a

				var_27_5.transform.localPosition = var_27_4
				var_27_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_27_6 = var_27_5:GetComponent("SpriteRenderer")

				if var_27_6 and var_27_6.sprite then
					local var_27_7 = (var_27_5.transform.localPosition - var_27_3).z
					local var_27_8 = manager.ui.mainCameraCom_
					local var_27_9 = 2 * var_27_7 * Mathf.Tan(var_27_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_27_10 = var_27_9 * var_27_8.aspect
					local var_27_11 = var_27_6.sprite.bounds.size.x
					local var_27_12 = var_27_6.sprite.bounds.size.y
					local var_27_13 = var_27_10 / var_27_11
					local var_27_14 = var_27_9 / var_27_12
					local var_27_15 = var_27_14 < var_27_13 and var_27_13 or var_27_14

					var_27_5.transform.localScale = Vector3.New(var_27_15, var_27_15, 0)
				end

				for iter_27_0, iter_27_1 in pairs(arg_24_1.bgs_) do
					if iter_27_0 ~= "ST72a" then
						iter_27_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_27_16 = 0

			if var_27_16 < arg_24_1.time_ and arg_24_1.time_ <= var_27_16 + arg_27_0 then
				arg_24_1.allBtn_.enabled = false
			end

			local var_27_17 = 0.3

			if arg_24_1.time_ >= var_27_16 + var_27_17 and arg_24_1.time_ < var_27_16 + var_27_17 + arg_27_0 then
				arg_24_1.allBtn_.enabled = true
			end

			local var_27_18 = 0

			if var_27_18 < arg_24_1.time_ and arg_24_1.time_ <= var_27_18 + arg_27_0 then
				arg_24_1.mask_.enabled = true
				arg_24_1.mask_.raycastTarget = true

				arg_24_1:SetGaussion(false)
			end

			local var_27_19 = 1

			if var_27_18 <= arg_24_1.time_ and arg_24_1.time_ < var_27_18 + var_27_19 then
				local var_27_20 = (arg_24_1.time_ - var_27_18) / var_27_19
				local var_27_21 = Color.New(0, 0, 0)

				var_27_21.a = Mathf.Lerp(0, 1, var_27_20)
				arg_24_1.mask_.color = var_27_21
			end

			if arg_24_1.time_ >= var_27_18 + var_27_19 and arg_24_1.time_ < var_27_18 + var_27_19 + arg_27_0 then
				local var_27_22 = Color.New(0, 0, 0)

				var_27_22.a = 1
				arg_24_1.mask_.color = var_27_22
			end

			local var_27_23 = 1

			if var_27_23 < arg_24_1.time_ and arg_24_1.time_ <= var_27_23 + arg_27_0 then
				arg_24_1.mask_.enabled = true
				arg_24_1.mask_.raycastTarget = true

				arg_24_1:SetGaussion(false)
			end

			local var_27_24 = 2

			if var_27_23 <= arg_24_1.time_ and arg_24_1.time_ < var_27_23 + var_27_24 then
				local var_27_25 = (arg_24_1.time_ - var_27_23) / var_27_24
				local var_27_26 = Color.New(0, 0, 0)

				var_27_26.a = Mathf.Lerp(1, 0, var_27_25)
				arg_24_1.mask_.color = var_27_26
			end

			if arg_24_1.time_ >= var_27_23 + var_27_24 and arg_24_1.time_ < var_27_23 + var_27_24 + arg_27_0 then
				local var_27_27 = Color.New(0, 0, 0)
				local var_27_28 = 0

				arg_24_1.mask_.enabled = false
				var_27_27.a = var_27_28
				arg_24_1.mask_.color = var_27_27
			end

			local var_27_29 = 0
			local var_27_30 = 0.2

			if var_27_29 < arg_24_1.time_ and arg_24_1.time_ <= var_27_29 + arg_27_0 then
				local var_27_31 = "play"
				local var_27_32 = "music"

				arg_24_1:AudioAction(var_27_31, var_27_32, "ui_battle", "ui_battle_stopbgm", "")

				local var_27_33 = ""
				local var_27_34 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_27_34 ~= "" then
					if arg_24_1.bgmTxt_.text ~= var_27_34 and arg_24_1.bgmTxt_.text ~= "" then
						if arg_24_1.bgmTxt2_.text ~= "" then
							arg_24_1.bgmTxt_.text = arg_24_1.bgmTxt2_.text
						end

						arg_24_1.bgmTxt2_.text = var_27_34

						arg_24_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_24_1.bgmTxt_.text = var_27_34
						arg_24_1.bgmTxt2_.text = var_27_34
					end

					if arg_24_1.bgmTimer then
						arg_24_1.bgmTimer:Stop()

						arg_24_1.bgmTimer = nil
					end

					if arg_24_1.settingData.show_music_name == 1 then
						arg_24_1.musicController:SetSelectedState("show")
						arg_24_1.musicAnimator_:Play("open", 0, 0)

						if arg_24_1.settingData.music_time ~= 0 then
							arg_24_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_24_1.settingData.music_time), function()
								if arg_24_1 == nil or isNil(arg_24_1.bgmTxt_) then
									return
								end

								arg_24_1.musicController:SetSelectedState("hide")
								arg_24_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_27_35 = 0.233333333333333
			local var_27_36 = 1

			if var_27_35 < arg_24_1.time_ and arg_24_1.time_ <= var_27_35 + arg_27_0 then
				local var_27_37 = "play"
				local var_27_38 = "music"

				arg_24_1:AudioAction(var_27_37, var_27_38, "bgm_activity_3_0_story_sad", "bgm_activity_3_0_story_sad", "bgm_activity_3_0_story_sad.awb")

				local var_27_39 = ""
				local var_27_40 = manager.audio:GetAudioName("bgm_activity_3_0_story_sad", "bgm_activity_3_0_story_sad")

				if var_27_40 ~= "" then
					if arg_24_1.bgmTxt_.text ~= var_27_40 and arg_24_1.bgmTxt_.text ~= "" then
						if arg_24_1.bgmTxt2_.text ~= "" then
							arg_24_1.bgmTxt_.text = arg_24_1.bgmTxt2_.text
						end

						arg_24_1.bgmTxt2_.text = var_27_40

						arg_24_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_24_1.bgmTxt_.text = var_27_40
						arg_24_1.bgmTxt2_.text = var_27_40
					end

					if arg_24_1.bgmTimer then
						arg_24_1.bgmTimer:Stop()

						arg_24_1.bgmTimer = nil
					end

					if arg_24_1.settingData.show_music_name == 1 then
						arg_24_1.musicController:SetSelectedState("show")
						arg_24_1.musicAnimator_:Play("open", 0, 0)

						if arg_24_1.settingData.music_time ~= 0 then
							arg_24_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_24_1.settingData.music_time), function()
								if arg_24_1 == nil or isNil(arg_24_1.bgmTxt_) then
									return
								end

								arg_24_1.musicController:SetSelectedState("hide")
								arg_24_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_24_1.frameCnt_ <= 1 then
				arg_24_1.dialog_:SetActive(false)
			end

			local var_27_41 = 2.56666666666667
			local var_27_42 = 1.45

			if var_27_41 < arg_24_1.time_ and arg_24_1.time_ <= var_27_41 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0

				arg_24_1.dialog_:SetActive(true)

				arg_24_1.dialogCg_.alpha = 0

				local var_27_43 = LeanTween.value(arg_24_1.dialog_, 0, 1, 0.3)

				var_27_43:setOnUpdate(LuaHelper.FloatAction(function(arg_30_0)
					arg_24_1.dialogCg_.alpha = arg_30_0
				end))
				var_27_43:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_24_1.dialog_)
					var_27_43:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_24_1.duration_ = arg_24_1.duration_ + 0.3

				SetActive(arg_24_1.leftNameGo_, false)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_44 = arg_24_1:GetWordFromCfg(319811006)
				local var_27_45 = arg_24_1:FormatText(var_27_44.content)

				arg_24_1.text_.text = var_27_45

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_46 = 58
				local var_27_47 = utf8.len(var_27_45)
				local var_27_48 = var_27_46 <= 0 and var_27_42 or var_27_42 * (var_27_47 / var_27_46)

				if var_27_48 > 0 and var_27_42 < var_27_48 then
					arg_24_1.talkMaxDuration = var_27_48
					var_27_41 = var_27_41 + 0.3

					if var_27_48 + var_27_41 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_48 + var_27_41
					end
				end

				arg_24_1.text_.text = var_27_45
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)
				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_49 = var_27_41 + 0.3
			local var_27_50 = math.max(var_27_42, arg_24_1.talkMaxDuration)

			if var_27_49 <= arg_24_1.time_ and arg_24_1.time_ < var_27_49 + var_27_50 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_49) / var_27_50

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_49 + var_27_50 and arg_24_1.time_ < var_27_49 + var_27_50 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play319811007 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 319811007
		arg_32_1.duration_ = 5

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play319811008(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = 0
			local var_35_1 = 0.45

			if var_35_0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_0 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				local var_35_2 = arg_32_1:FormatText(StoryNameCfg[698].name)

				arg_32_1.leftNameTxt_.text = var_35_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, true)
				arg_32_1.iconController_:SetSelectedState("hero")

				arg_32_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_32_1.callingController_:SetSelectedState("normal")

				arg_32_1.keyicon_.color = Color.New(1, 1, 1)
				arg_32_1.icon_.color = Color.New(1, 1, 1)

				local var_35_3 = arg_32_1:GetWordFromCfg(319811007)
				local var_35_4 = arg_32_1:FormatText(var_35_3.content)

				arg_32_1.text_.text = var_35_4

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_5 = 18
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
				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_8 = math.max(var_35_1, arg_32_1.talkMaxDuration)

			if var_35_0 <= arg_32_1.time_ and arg_32_1.time_ < var_35_0 + var_35_8 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_0) / var_35_8

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_0 + var_35_8 and arg_32_1.time_ < var_35_0 + var_35_8 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play319811008 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 319811008
		arg_36_1.duration_ = 2.03

		local var_36_0 = {
			zh = 1.999999999999,
			ja = 2.033
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
				arg_36_0:Play319811009(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = "10069ui_story"

			if arg_36_1.actors_[var_39_0] == nil then
				local var_39_1 = Asset.Load("Char/" .. "10069ui_story")

				if not isNil(var_39_1) then
					local var_39_2 = Object.Instantiate(Asset.Load("Char/" .. "10069ui_story"), arg_36_1.stage_.transform)

					var_39_2.name = var_39_0
					var_39_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_36_1.actors_[var_39_0] = var_39_2

					local var_39_3 = var_39_2:GetComponentInChildren(typeof(CharacterEffect))

					var_39_3.enabled = true

					local var_39_4 = GameObjectTools.GetOrAddComponent(var_39_2, typeof(DynamicBoneHelper))

					if var_39_4 then
						var_39_4:EnableDynamicBone(false)
					end

					arg_36_1:ShowWeapon(var_39_3.transform, false)

					arg_36_1.var_[var_39_0 .. "Animator"] = var_39_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_36_1.var_[var_39_0 .. "Animator"].applyRootMotion = true
					arg_36_1.var_[var_39_0 .. "LipSync"] = var_39_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_39_5 = arg_36_1.actors_["10069ui_story"].transform
			local var_39_6 = 0

			if var_39_6 < arg_36_1.time_ and arg_36_1.time_ <= var_39_6 + arg_39_0 then
				arg_36_1.var_.moveOldPos10069ui_story = var_39_5.localPosition
			end

			local var_39_7 = 0.001

			if var_39_6 <= arg_36_1.time_ and arg_36_1.time_ < var_39_6 + var_39_7 then
				local var_39_8 = (arg_36_1.time_ - var_39_6) / var_39_7
				local var_39_9 = Vector3.New(0, -1.08, -6.33)

				var_39_5.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos10069ui_story, var_39_9, var_39_8)

				local var_39_10 = manager.ui.mainCamera.transform.position - var_39_5.position

				var_39_5.forward = Vector3.New(var_39_10.x, var_39_10.y, var_39_10.z)

				local var_39_11 = var_39_5.localEulerAngles

				var_39_11.z = 0
				var_39_11.x = 0
				var_39_5.localEulerAngles = var_39_11
			end

			if arg_36_1.time_ >= var_39_6 + var_39_7 and arg_36_1.time_ < var_39_6 + var_39_7 + arg_39_0 then
				var_39_5.localPosition = Vector3.New(0, -1.08, -6.33)

				local var_39_12 = manager.ui.mainCamera.transform.position - var_39_5.position

				var_39_5.forward = Vector3.New(var_39_12.x, var_39_12.y, var_39_12.z)

				local var_39_13 = var_39_5.localEulerAngles

				var_39_13.z = 0
				var_39_13.x = 0
				var_39_5.localEulerAngles = var_39_13
			end

			local var_39_14 = arg_36_1.actors_["10069ui_story"]
			local var_39_15 = 0

			if var_39_15 < arg_36_1.time_ and arg_36_1.time_ <= var_39_15 + arg_39_0 and not isNil(var_39_14) and arg_36_1.var_.characterEffect10069ui_story == nil then
				arg_36_1.var_.characterEffect10069ui_story = var_39_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_16 = 0.200000002980232

			if var_39_15 <= arg_36_1.time_ and arg_36_1.time_ < var_39_15 + var_39_16 and not isNil(var_39_14) then
				local var_39_17 = (arg_36_1.time_ - var_39_15) / var_39_16

				if arg_36_1.var_.characterEffect10069ui_story and not isNil(var_39_14) then
					arg_36_1.var_.characterEffect10069ui_story.fillFlat = false
				end
			end

			if arg_36_1.time_ >= var_39_15 + var_39_16 and arg_36_1.time_ < var_39_15 + var_39_16 + arg_39_0 and not isNil(var_39_14) and arg_36_1.var_.characterEffect10069ui_story then
				arg_36_1.var_.characterEffect10069ui_story.fillFlat = false
			end

			local var_39_18 = 0

			if var_39_18 < arg_36_1.time_ and arg_36_1.time_ <= var_39_18 + arg_39_0 then
				arg_36_1:PlayTimeline("10069ui_story", "StoryTimeline/CharAction/story10056/story10056action/10056action1_1")
			end

			local var_39_19 = 0

			if var_39_19 < arg_36_1.time_ and arg_36_1.time_ <= var_39_19 + arg_39_0 then
				arg_36_1:PlayTimeline("10069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_39_20 = 0
			local var_39_21 = 0.075

			if var_39_20 < arg_36_1.time_ and arg_36_1.time_ <= var_39_20 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				local var_39_22 = arg_36_1:FormatText(StoryNameCfg[693].name)

				arg_36_1.leftNameTxt_.text = var_39_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_23 = arg_36_1:GetWordFromCfg(319811008)
				local var_39_24 = arg_36_1:FormatText(var_39_23.content)

				arg_36_1.text_.text = var_39_24

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_25 = 3
				local var_39_26 = utf8.len(var_39_24)
				local var_39_27 = var_39_25 <= 0 and var_39_21 or var_39_21 * (var_39_26 / var_39_25)

				if var_39_27 > 0 and var_39_21 < var_39_27 then
					arg_36_1.talkMaxDuration = var_39_27

					if var_39_27 + var_39_20 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_27 + var_39_20
					end
				end

				arg_36_1.text_.text = var_39_24
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319811", "319811008", "story_v_out_319811.awb") ~= 0 then
					local var_39_28 = manager.audio:GetVoiceLength("story_v_out_319811", "319811008", "story_v_out_319811.awb") / 1000

					if var_39_28 + var_39_20 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_28 + var_39_20
					end

					if var_39_23.prefab_name ~= "" and arg_36_1.actors_[var_39_23.prefab_name] ~= nil then
						local var_39_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_23.prefab_name].transform, "story_v_out_319811", "319811008", "story_v_out_319811.awb")

						arg_36_1:RecordAudio("319811008", var_39_29)
						arg_36_1:RecordAudio("319811008", var_39_29)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_319811", "319811008", "story_v_out_319811.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_319811", "319811008", "story_v_out_319811.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_30 = math.max(var_39_21, arg_36_1.talkMaxDuration)

			if var_39_20 <= arg_36_1.time_ and arg_36_1.time_ < var_39_20 + var_39_30 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_20) / var_39_30

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_20 + var_39_30 and arg_36_1.time_ < var_39_20 + var_39_30 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_36_1:InitPlayNodeList()
	end,
	Play319811009 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 319811009
		arg_40_1.duration_ = 5

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play319811010(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = arg_40_1.actors_["10069ui_story"].transform
			local var_43_1 = 0

			if var_43_1 < arg_40_1.time_ and arg_40_1.time_ <= var_43_1 + arg_43_0 then
				arg_40_1.var_.moveOldPos10069ui_story = var_43_0.localPosition
			end

			local var_43_2 = 0.001

			if var_43_1 <= arg_40_1.time_ and arg_40_1.time_ < var_43_1 + var_43_2 then
				local var_43_3 = (arg_40_1.time_ - var_43_1) / var_43_2
				local var_43_4 = Vector3.New(0, 100, 0)

				var_43_0.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos10069ui_story, var_43_4, var_43_3)

				local var_43_5 = manager.ui.mainCamera.transform.position - var_43_0.position

				var_43_0.forward = Vector3.New(var_43_5.x, var_43_5.y, var_43_5.z)

				local var_43_6 = var_43_0.localEulerAngles

				var_43_6.z = 0
				var_43_6.x = 0
				var_43_0.localEulerAngles = var_43_6
			end

			if arg_40_1.time_ >= var_43_1 + var_43_2 and arg_40_1.time_ < var_43_1 + var_43_2 + arg_43_0 then
				var_43_0.localPosition = Vector3.New(0, 100, 0)

				local var_43_7 = manager.ui.mainCamera.transform.position - var_43_0.position

				var_43_0.forward = Vector3.New(var_43_7.x, var_43_7.y, var_43_7.z)

				local var_43_8 = var_43_0.localEulerAngles

				var_43_8.z = 0
				var_43_8.x = 0
				var_43_0.localEulerAngles = var_43_8
			end

			local var_43_9 = arg_40_1.actors_["10069ui_story"]
			local var_43_10 = 0

			if var_43_10 < arg_40_1.time_ and arg_40_1.time_ <= var_43_10 + arg_43_0 and not isNil(var_43_9) and arg_40_1.var_.characterEffect10069ui_story == nil then
				arg_40_1.var_.characterEffect10069ui_story = var_43_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_11 = 0.200000002980232

			if var_43_10 <= arg_40_1.time_ and arg_40_1.time_ < var_43_10 + var_43_11 and not isNil(var_43_9) then
				local var_43_12 = (arg_40_1.time_ - var_43_10) / var_43_11

				if arg_40_1.var_.characterEffect10069ui_story and not isNil(var_43_9) then
					local var_43_13 = Mathf.Lerp(0, 0.5, var_43_12)

					arg_40_1.var_.characterEffect10069ui_story.fillFlat = true
					arg_40_1.var_.characterEffect10069ui_story.fillRatio = var_43_13
				end
			end

			if arg_40_1.time_ >= var_43_10 + var_43_11 and arg_40_1.time_ < var_43_10 + var_43_11 + arg_43_0 and not isNil(var_43_9) and arg_40_1.var_.characterEffect10069ui_story then
				local var_43_14 = 0.5

				arg_40_1.var_.characterEffect10069ui_story.fillFlat = true
				arg_40_1.var_.characterEffect10069ui_story.fillRatio = var_43_14
			end

			local var_43_15 = 0
			local var_43_16 = 1.025

			if var_43_15 < arg_40_1.time_ and arg_40_1.time_ <= var_43_15 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, false)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_17 = arg_40_1:GetWordFromCfg(319811009)
				local var_43_18 = arg_40_1:FormatText(var_43_17.content)

				arg_40_1.text_.text = var_43_18

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_19 = 41
				local var_43_20 = utf8.len(var_43_18)
				local var_43_21 = var_43_19 <= 0 and var_43_16 or var_43_16 * (var_43_20 / var_43_19)

				if var_43_21 > 0 and var_43_16 < var_43_21 then
					arg_40_1.talkMaxDuration = var_43_21

					if var_43_21 + var_43_15 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_21 + var_43_15
					end
				end

				arg_40_1.text_.text = var_43_18
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)
				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_22 = math.max(var_43_16, arg_40_1.talkMaxDuration)

			if var_43_15 <= arg_40_1.time_ and arg_40_1.time_ < var_43_15 + var_43_22 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_15) / var_43_22

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_15 + var_43_22 and arg_40_1.time_ < var_43_15 + var_43_22 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_40_1:InitPlayNodeList()
	end,
	Play319811010 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 319811010
		arg_44_1.duration_ = 5

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play319811011(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = 0
			local var_47_1 = 0.725

			if var_47_0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_0 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, false)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_2 = arg_44_1:GetWordFromCfg(319811010)
				local var_47_3 = arg_44_1:FormatText(var_47_2.content)

				arg_44_1.text_.text = var_47_3

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_4 = 29
				local var_47_5 = utf8.len(var_47_3)
				local var_47_6 = var_47_4 <= 0 and var_47_1 or var_47_1 * (var_47_5 / var_47_4)

				if var_47_6 > 0 and var_47_1 < var_47_6 then
					arg_44_1.talkMaxDuration = var_47_6

					if var_47_6 + var_47_0 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_6 + var_47_0
					end
				end

				arg_44_1.text_.text = var_47_3
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)
				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_7 = math.max(var_47_1, arg_44_1.talkMaxDuration)

			if var_47_0 <= arg_44_1.time_ and arg_44_1.time_ < var_47_0 + var_47_7 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_0) / var_47_7

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_0 + var_47_7 and arg_44_1.time_ < var_47_0 + var_47_7 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play319811011 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 319811011
		arg_48_1.duration_ = 5

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play319811012(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = 0
			local var_51_1 = 1.125

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

				local var_51_2 = arg_48_1:GetWordFromCfg(319811011)
				local var_51_3 = arg_48_1:FormatText(var_51_2.content)

				arg_48_1.text_.text = var_51_3

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_4 = 45
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
	Play319811012 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 319811012
		arg_52_1.duration_ = 3.23

		local var_52_0 = {
			zh = 1.999999999999,
			ja = 3.233
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
				arg_52_0:Play319811013(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = "10058ui_story"

			if arg_52_1.actors_[var_55_0] == nil then
				local var_55_1 = Asset.Load("Char/" .. "10058ui_story")

				if not isNil(var_55_1) then
					local var_55_2 = Object.Instantiate(Asset.Load("Char/" .. "10058ui_story"), arg_52_1.stage_.transform)

					var_55_2.name = var_55_0
					var_55_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_52_1.actors_[var_55_0] = var_55_2

					local var_55_3 = var_55_2:GetComponentInChildren(typeof(CharacterEffect))

					var_55_3.enabled = true

					local var_55_4 = GameObjectTools.GetOrAddComponent(var_55_2, typeof(DynamicBoneHelper))

					if var_55_4 then
						var_55_4:EnableDynamicBone(false)
					end

					arg_52_1:ShowWeapon(var_55_3.transform, false)

					arg_52_1.var_[var_55_0 .. "Animator"] = var_55_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_52_1.var_[var_55_0 .. "Animator"].applyRootMotion = true
					arg_52_1.var_[var_55_0 .. "LipSync"] = var_55_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_55_5 = arg_52_1.actors_["10058ui_story"].transform
			local var_55_6 = 0

			if var_55_6 < arg_52_1.time_ and arg_52_1.time_ <= var_55_6 + arg_55_0 then
				arg_52_1.var_.moveOldPos10058ui_story = var_55_5.localPosition
			end

			local var_55_7 = 0.001

			if var_55_6 <= arg_52_1.time_ and arg_52_1.time_ < var_55_6 + var_55_7 then
				local var_55_8 = (arg_52_1.time_ - var_55_6) / var_55_7
				local var_55_9 = Vector3.New(0, -0.98, -6.1)

				var_55_5.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPos10058ui_story, var_55_9, var_55_8)

				local var_55_10 = manager.ui.mainCamera.transform.position - var_55_5.position

				var_55_5.forward = Vector3.New(var_55_10.x, var_55_10.y, var_55_10.z)

				local var_55_11 = var_55_5.localEulerAngles

				var_55_11.z = 0
				var_55_11.x = 0
				var_55_5.localEulerAngles = var_55_11
			end

			if arg_52_1.time_ >= var_55_6 + var_55_7 and arg_52_1.time_ < var_55_6 + var_55_7 + arg_55_0 then
				var_55_5.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_55_12 = manager.ui.mainCamera.transform.position - var_55_5.position

				var_55_5.forward = Vector3.New(var_55_12.x, var_55_12.y, var_55_12.z)

				local var_55_13 = var_55_5.localEulerAngles

				var_55_13.z = 0
				var_55_13.x = 0
				var_55_5.localEulerAngles = var_55_13
			end

			local var_55_14 = arg_52_1.actors_["10058ui_story"]
			local var_55_15 = 0

			if var_55_15 < arg_52_1.time_ and arg_52_1.time_ <= var_55_15 + arg_55_0 and not isNil(var_55_14) and arg_52_1.var_.characterEffect10058ui_story == nil then
				arg_52_1.var_.characterEffect10058ui_story = var_55_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_16 = 0.200000002980232

			if var_55_15 <= arg_52_1.time_ and arg_52_1.time_ < var_55_15 + var_55_16 and not isNil(var_55_14) then
				local var_55_17 = (arg_52_1.time_ - var_55_15) / var_55_16

				if arg_52_1.var_.characterEffect10058ui_story and not isNil(var_55_14) then
					arg_52_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_52_1.time_ >= var_55_15 + var_55_16 and arg_52_1.time_ < var_55_15 + var_55_16 + arg_55_0 and not isNil(var_55_14) and arg_52_1.var_.characterEffect10058ui_story then
				arg_52_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_55_18 = 0

			if var_55_18 < arg_52_1.time_ and arg_52_1.time_ <= var_55_18 + arg_55_0 then
				arg_52_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_55_19 = 0

			if var_55_19 < arg_52_1.time_ and arg_52_1.time_ <= var_55_19 + arg_55_0 then
				arg_52_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2202cva")
			end

			local var_55_20 = 0
			local var_55_21 = 0.225

			if var_55_20 < arg_52_1.time_ and arg_52_1.time_ <= var_55_20 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				local var_55_22 = arg_52_1:FormatText(StoryNameCfg[471].name)

				arg_52_1.leftNameTxt_.text = var_55_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_23 = arg_52_1:GetWordFromCfg(319811012)
				local var_55_24 = arg_52_1:FormatText(var_55_23.content)

				arg_52_1.text_.text = var_55_24

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_25 = 9
				local var_55_26 = utf8.len(var_55_24)
				local var_55_27 = var_55_25 <= 0 and var_55_21 or var_55_21 * (var_55_26 / var_55_25)

				if var_55_27 > 0 and var_55_21 < var_55_27 then
					arg_52_1.talkMaxDuration = var_55_27

					if var_55_27 + var_55_20 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_27 + var_55_20
					end
				end

				arg_52_1.text_.text = var_55_24
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319811", "319811012", "story_v_out_319811.awb") ~= 0 then
					local var_55_28 = manager.audio:GetVoiceLength("story_v_out_319811", "319811012", "story_v_out_319811.awb") / 1000

					if var_55_28 + var_55_20 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_28 + var_55_20
					end

					if var_55_23.prefab_name ~= "" and arg_52_1.actors_[var_55_23.prefab_name] ~= nil then
						local var_55_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_23.prefab_name].transform, "story_v_out_319811", "319811012", "story_v_out_319811.awb")

						arg_52_1:RecordAudio("319811012", var_55_29)
						arg_52_1:RecordAudio("319811012", var_55_29)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_319811", "319811012", "story_v_out_319811.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_319811", "319811012", "story_v_out_319811.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_30 = math.max(var_55_21, arg_52_1.talkMaxDuration)

			if var_55_20 <= arg_52_1.time_ and arg_52_1.time_ < var_55_20 + var_55_30 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_20) / var_55_30

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_20 + var_55_30 and arg_52_1.time_ < var_55_20 + var_55_30 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {
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

		arg_52_1:InitPlayNodeList()
	end,
	Play319811013 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 319811013
		arg_56_1.duration_ = 5

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play319811014(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = arg_56_1.actors_["10058ui_story"]
			local var_59_1 = 0

			if var_59_1 < arg_56_1.time_ and arg_56_1.time_ <= var_59_1 + arg_59_0 and not isNil(var_59_0) and arg_56_1.var_.characterEffect10058ui_story == nil then
				arg_56_1.var_.characterEffect10058ui_story = var_59_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_2 = 0.200000002980232

			if var_59_1 <= arg_56_1.time_ and arg_56_1.time_ < var_59_1 + var_59_2 and not isNil(var_59_0) then
				local var_59_3 = (arg_56_1.time_ - var_59_1) / var_59_2

				if arg_56_1.var_.characterEffect10058ui_story and not isNil(var_59_0) then
					local var_59_4 = Mathf.Lerp(0, 0.5, var_59_3)

					arg_56_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_56_1.var_.characterEffect10058ui_story.fillRatio = var_59_4
				end
			end

			if arg_56_1.time_ >= var_59_1 + var_59_2 and arg_56_1.time_ < var_59_1 + var_59_2 + arg_59_0 and not isNil(var_59_0) and arg_56_1.var_.characterEffect10058ui_story then
				local var_59_5 = 0.5

				arg_56_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_56_1.var_.characterEffect10058ui_story.fillRatio = var_59_5
			end

			local var_59_6 = 0
			local var_59_7 = 0.125

			if var_59_6 < arg_56_1.time_ and arg_56_1.time_ <= var_59_6 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				local var_59_8 = arg_56_1:FormatText(StoryNameCfg[698].name)

				arg_56_1.leftNameTxt_.text = var_59_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, true)
				arg_56_1.iconController_:SetSelectedState("hero")

				arg_56_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_56_1.callingController_:SetSelectedState("normal")

				arg_56_1.keyicon_.color = Color.New(1, 1, 1)
				arg_56_1.icon_.color = Color.New(1, 1, 1)

				local var_59_9 = arg_56_1:GetWordFromCfg(319811013)
				local var_59_10 = arg_56_1:FormatText(var_59_9.content)

				arg_56_1.text_.text = var_59_10

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_11 = 5
				local var_59_12 = utf8.len(var_59_10)
				local var_59_13 = var_59_11 <= 0 and var_59_7 or var_59_7 * (var_59_12 / var_59_11)

				if var_59_13 > 0 and var_59_7 < var_59_13 then
					arg_56_1.talkMaxDuration = var_59_13

					if var_59_13 + var_59_6 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_13 + var_59_6
					end
				end

				arg_56_1.text_.text = var_59_10
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)
				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_14 = math.max(var_59_7, arg_56_1.talkMaxDuration)

			if var_59_6 <= arg_56_1.time_ and arg_56_1.time_ < var_59_6 + var_59_14 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_6) / var_59_14

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_6 + var_59_14 and arg_56_1.time_ < var_59_6 + var_59_14 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play319811014 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 319811014
		arg_60_1.duration_ = 6.03

		local var_60_0 = {
			zh = 3.6,
			ja = 6.033
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
				arg_60_0:Play319811015(arg_60_1)
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
					arg_60_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_60_1.time_ >= var_63_1 + var_63_2 and arg_60_1.time_ < var_63_1 + var_63_2 + arg_63_0 and not isNil(var_63_0) and arg_60_1.var_.characterEffect10058ui_story then
				arg_60_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_63_4 = 0
			local var_63_5 = 0.375

			if var_63_4 < arg_60_1.time_ and arg_60_1.time_ <= var_63_4 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				local var_63_6 = arg_60_1:FormatText(StoryNameCfg[471].name)

				arg_60_1.leftNameTxt_.text = var_63_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_7 = arg_60_1:GetWordFromCfg(319811014)
				local var_63_8 = arg_60_1:FormatText(var_63_7.content)

				arg_60_1.text_.text = var_63_8

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_9 = 15
				local var_63_10 = utf8.len(var_63_8)
				local var_63_11 = var_63_9 <= 0 and var_63_5 or var_63_5 * (var_63_10 / var_63_9)

				if var_63_11 > 0 and var_63_5 < var_63_11 then
					arg_60_1.talkMaxDuration = var_63_11

					if var_63_11 + var_63_4 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_11 + var_63_4
					end
				end

				arg_60_1.text_.text = var_63_8
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319811", "319811014", "story_v_out_319811.awb") ~= 0 then
					local var_63_12 = manager.audio:GetVoiceLength("story_v_out_319811", "319811014", "story_v_out_319811.awb") / 1000

					if var_63_12 + var_63_4 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_12 + var_63_4
					end

					if var_63_7.prefab_name ~= "" and arg_60_1.actors_[var_63_7.prefab_name] ~= nil then
						local var_63_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_7.prefab_name].transform, "story_v_out_319811", "319811014", "story_v_out_319811.awb")

						arg_60_1:RecordAudio("319811014", var_63_13)
						arg_60_1:RecordAudio("319811014", var_63_13)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_319811", "319811014", "story_v_out_319811.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_319811", "319811014", "story_v_out_319811.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_14 = math.max(var_63_5, arg_60_1.talkMaxDuration)

			if var_63_4 <= arg_60_1.time_ and arg_60_1.time_ < var_63_4 + var_63_14 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_4) / var_63_14

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_4 + var_63_14 and arg_60_1.time_ < var_63_4 + var_63_14 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play319811015 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 319811015
		arg_64_1.duration_ = 5

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play319811016(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = arg_64_1.actors_["10058ui_story"]
			local var_67_1 = 0

			if var_67_1 < arg_64_1.time_ and arg_64_1.time_ <= var_67_1 + arg_67_0 and not isNil(var_67_0) and arg_64_1.var_.characterEffect10058ui_story == nil then
				arg_64_1.var_.characterEffect10058ui_story = var_67_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_2 = 0.200000002980232

			if var_67_1 <= arg_64_1.time_ and arg_64_1.time_ < var_67_1 + var_67_2 and not isNil(var_67_0) then
				local var_67_3 = (arg_64_1.time_ - var_67_1) / var_67_2

				if arg_64_1.var_.characterEffect10058ui_story and not isNil(var_67_0) then
					local var_67_4 = Mathf.Lerp(0, 0.5, var_67_3)

					arg_64_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_64_1.var_.characterEffect10058ui_story.fillRatio = var_67_4
				end
			end

			if arg_64_1.time_ >= var_67_1 + var_67_2 and arg_64_1.time_ < var_67_1 + var_67_2 + arg_67_0 and not isNil(var_67_0) and arg_64_1.var_.characterEffect10058ui_story then
				local var_67_5 = 0.5

				arg_64_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_64_1.var_.characterEffect10058ui_story.fillRatio = var_67_5
			end

			local var_67_6 = 0
			local var_67_7 = 0.45

			if var_67_6 < arg_64_1.time_ and arg_64_1.time_ <= var_67_6 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				local var_67_8 = arg_64_1:FormatText(StoryNameCfg[698].name)

				arg_64_1.leftNameTxt_.text = var_67_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, true)
				arg_64_1.iconController_:SetSelectedState("hero")

				arg_64_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_64_1.callingController_:SetSelectedState("normal")

				arg_64_1.keyicon_.color = Color.New(1, 1, 1)
				arg_64_1.icon_.color = Color.New(1, 1, 1)

				local var_67_9 = arg_64_1:GetWordFromCfg(319811015)
				local var_67_10 = arg_64_1:FormatText(var_67_9.content)

				arg_64_1.text_.text = var_67_10

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_11 = 18
				local var_67_12 = utf8.len(var_67_10)
				local var_67_13 = var_67_11 <= 0 and var_67_7 or var_67_7 * (var_67_12 / var_67_11)

				if var_67_13 > 0 and var_67_7 < var_67_13 then
					arg_64_1.talkMaxDuration = var_67_13

					if var_67_13 + var_67_6 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_13 + var_67_6
					end
				end

				arg_64_1.text_.text = var_67_10
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)
				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_14 = math.max(var_67_7, arg_64_1.talkMaxDuration)

			if var_67_6 <= arg_64_1.time_ and arg_64_1.time_ < var_67_6 + var_67_14 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_6) / var_67_14

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_6 + var_67_14 and arg_64_1.time_ < var_67_6 + var_67_14 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {}

		arg_64_1:InitPlayNodeList()
	end,
	Play319811016 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 319811016
		arg_68_1.duration_ = 7.77

		local var_68_0 = {
			zh = 3.466,
			ja = 7.766
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
				arg_68_0:Play319811017(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = arg_68_1.actors_["10058ui_story"]
			local var_71_1 = 0

			if var_71_1 < arg_68_1.time_ and arg_68_1.time_ <= var_71_1 + arg_71_0 and not isNil(var_71_0) and arg_68_1.var_.characterEffect10058ui_story == nil then
				arg_68_1.var_.characterEffect10058ui_story = var_71_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_2 = 0.200000002980232

			if var_71_1 <= arg_68_1.time_ and arg_68_1.time_ < var_71_1 + var_71_2 and not isNil(var_71_0) then
				local var_71_3 = (arg_68_1.time_ - var_71_1) / var_71_2

				if arg_68_1.var_.characterEffect10058ui_story and not isNil(var_71_0) then
					arg_68_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_68_1.time_ >= var_71_1 + var_71_2 and arg_68_1.time_ < var_71_1 + var_71_2 + arg_71_0 and not isNil(var_71_0) and arg_68_1.var_.characterEffect10058ui_story then
				arg_68_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_71_4 = 0

			if var_71_4 < arg_68_1.time_ and arg_68_1.time_ <= var_71_4 + arg_71_0 then
				arg_68_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action3_1")
			end

			local var_71_5 = 0

			if var_71_5 < arg_68_1.time_ and arg_68_1.time_ <= var_71_5 + arg_71_0 then
				arg_68_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_71_6 = 0
			local var_71_7 = 0.45

			if var_71_6 < arg_68_1.time_ and arg_68_1.time_ <= var_71_6 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				local var_71_8 = arg_68_1:FormatText(StoryNameCfg[471].name)

				arg_68_1.leftNameTxt_.text = var_71_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_9 = arg_68_1:GetWordFromCfg(319811016)
				local var_71_10 = arg_68_1:FormatText(var_71_9.content)

				arg_68_1.text_.text = var_71_10

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_11 = 18
				local var_71_12 = utf8.len(var_71_10)
				local var_71_13 = var_71_11 <= 0 and var_71_7 or var_71_7 * (var_71_12 / var_71_11)

				if var_71_13 > 0 and var_71_7 < var_71_13 then
					arg_68_1.talkMaxDuration = var_71_13

					if var_71_13 + var_71_6 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_13 + var_71_6
					end
				end

				arg_68_1.text_.text = var_71_10
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319811", "319811016", "story_v_out_319811.awb") ~= 0 then
					local var_71_14 = manager.audio:GetVoiceLength("story_v_out_319811", "319811016", "story_v_out_319811.awb") / 1000

					if var_71_14 + var_71_6 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_14 + var_71_6
					end

					if var_71_9.prefab_name ~= "" and arg_68_1.actors_[var_71_9.prefab_name] ~= nil then
						local var_71_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_9.prefab_name].transform, "story_v_out_319811", "319811016", "story_v_out_319811.awb")

						arg_68_1:RecordAudio("319811016", var_71_15)
						arg_68_1:RecordAudio("319811016", var_71_15)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_319811", "319811016", "story_v_out_319811.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_319811", "319811016", "story_v_out_319811.awb")
				end

				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_16 = math.max(var_71_7, arg_68_1.talkMaxDuration)

			if var_71_6 <= arg_68_1.time_ and arg_68_1.time_ < var_71_6 + var_71_16 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_6) / var_71_16

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_6 + var_71_16 and arg_68_1.time_ < var_71_6 + var_71_16 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {}

		arg_68_1:InitPlayNodeList()
	end,
	Play319811017 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 319811017
		arg_72_1.duration_ = 5

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play319811018(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = arg_72_1.actors_["10058ui_story"]
			local var_75_1 = 0

			if var_75_1 < arg_72_1.time_ and arg_72_1.time_ <= var_75_1 + arg_75_0 and not isNil(var_75_0) and arg_72_1.var_.characterEffect10058ui_story == nil then
				arg_72_1.var_.characterEffect10058ui_story = var_75_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_2 = 0.200000002980232

			if var_75_1 <= arg_72_1.time_ and arg_72_1.time_ < var_75_1 + var_75_2 and not isNil(var_75_0) then
				local var_75_3 = (arg_72_1.time_ - var_75_1) / var_75_2

				if arg_72_1.var_.characterEffect10058ui_story and not isNil(var_75_0) then
					local var_75_4 = Mathf.Lerp(0, 0.5, var_75_3)

					arg_72_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_72_1.var_.characterEffect10058ui_story.fillRatio = var_75_4
				end
			end

			if arg_72_1.time_ >= var_75_1 + var_75_2 and arg_72_1.time_ < var_75_1 + var_75_2 + arg_75_0 and not isNil(var_75_0) and arg_72_1.var_.characterEffect10058ui_story then
				local var_75_5 = 0.5

				arg_72_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_72_1.var_.characterEffect10058ui_story.fillRatio = var_75_5
			end

			local var_75_6 = 0
			local var_75_7 = 0.225

			if var_75_6 < arg_72_1.time_ and arg_72_1.time_ <= var_75_6 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				local var_75_8 = arg_72_1:FormatText(StoryNameCfg[698].name)

				arg_72_1.leftNameTxt_.text = var_75_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, true)
				arg_72_1.iconController_:SetSelectedState("hero")

				arg_72_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_72_1.callingController_:SetSelectedState("normal")

				arg_72_1.keyicon_.color = Color.New(1, 1, 1)
				arg_72_1.icon_.color = Color.New(1, 1, 1)

				local var_75_9 = arg_72_1:GetWordFromCfg(319811017)
				local var_75_10 = arg_72_1:FormatText(var_75_9.content)

				arg_72_1.text_.text = var_75_10

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_11 = 9
				local var_75_12 = utf8.len(var_75_10)
				local var_75_13 = var_75_11 <= 0 and var_75_7 or var_75_7 * (var_75_12 / var_75_11)

				if var_75_13 > 0 and var_75_7 < var_75_13 then
					arg_72_1.talkMaxDuration = var_75_13

					if var_75_13 + var_75_6 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_13 + var_75_6
					end
				end

				arg_72_1.text_.text = var_75_10
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)
				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_14 = math.max(var_75_7, arg_72_1.talkMaxDuration)

			if var_75_6 <= arg_72_1.time_ and arg_72_1.time_ < var_75_6 + var_75_14 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_6) / var_75_14

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_6 + var_75_14 and arg_72_1.time_ < var_75_6 + var_75_14 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {}

		arg_72_1:InitPlayNodeList()
	end,
	Play319811018 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 319811018
		arg_76_1.duration_ = 6

		local var_76_0 = {
			zh = 6,
			ja = 5.5
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
				arg_76_0:Play319811019(arg_76_1)
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
			local var_79_14 = 0.55

			if var_79_13 < arg_76_1.time_ and arg_76_1.time_ <= var_79_13 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				local var_79_15 = arg_76_1:FormatText(StoryNameCfg[471].name)

				arg_76_1.leftNameTxt_.text = var_79_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_16 = arg_76_1:GetWordFromCfg(319811018)
				local var_79_17 = arg_76_1:FormatText(var_79_16.content)

				arg_76_1.text_.text = var_79_17

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_18 = 22
				local var_79_19 = utf8.len(var_79_17)
				local var_79_20 = var_79_18 <= 0 and var_79_14 or var_79_14 * (var_79_19 / var_79_18)

				if var_79_20 > 0 and var_79_14 < var_79_20 then
					arg_76_1.talkMaxDuration = var_79_20

					if var_79_20 + var_79_13 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_20 + var_79_13
					end
				end

				arg_76_1.text_.text = var_79_17
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319811", "319811018", "story_v_out_319811.awb") ~= 0 then
					local var_79_21 = manager.audio:GetVoiceLength("story_v_out_319811", "319811018", "story_v_out_319811.awb") / 1000

					if var_79_21 + var_79_13 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_21 + var_79_13
					end

					if var_79_16.prefab_name ~= "" and arg_76_1.actors_[var_79_16.prefab_name] ~= nil then
						local var_79_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_16.prefab_name].transform, "story_v_out_319811", "319811018", "story_v_out_319811.awb")

						arg_76_1:RecordAudio("319811018", var_79_22)
						arg_76_1:RecordAudio("319811018", var_79_22)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_319811", "319811018", "story_v_out_319811.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_319811", "319811018", "story_v_out_319811.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_23 = math.max(var_79_14, arg_76_1.talkMaxDuration)

			if var_79_13 <= arg_76_1.time_ and arg_76_1.time_ < var_79_13 + var_79_23 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_13) / var_79_23

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_13 + var_79_23 and arg_76_1.time_ < var_79_13 + var_79_23 + arg_79_0 then
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
	Play319811019 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 319811019
		arg_80_1.duration_ = 5

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play319811020(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = arg_80_1.actors_["10058ui_story"]
			local var_83_1 = 0

			if var_83_1 < arg_80_1.time_ and arg_80_1.time_ <= var_83_1 + arg_83_0 and not isNil(var_83_0) and arg_80_1.var_.characterEffect10058ui_story == nil then
				arg_80_1.var_.characterEffect10058ui_story = var_83_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_2 = 0.200000002980232

			if var_83_1 <= arg_80_1.time_ and arg_80_1.time_ < var_83_1 + var_83_2 and not isNil(var_83_0) then
				local var_83_3 = (arg_80_1.time_ - var_83_1) / var_83_2

				if arg_80_1.var_.characterEffect10058ui_story and not isNil(var_83_0) then
					local var_83_4 = Mathf.Lerp(0, 0.5, var_83_3)

					arg_80_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_80_1.var_.characterEffect10058ui_story.fillRatio = var_83_4
				end
			end

			if arg_80_1.time_ >= var_83_1 + var_83_2 and arg_80_1.time_ < var_83_1 + var_83_2 + arg_83_0 and not isNil(var_83_0) and arg_80_1.var_.characterEffect10058ui_story then
				local var_83_5 = 0.5

				arg_80_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_80_1.var_.characterEffect10058ui_story.fillRatio = var_83_5
			end

			local var_83_6 = 0
			local var_83_7 = 0.225

			if var_83_6 < arg_80_1.time_ and arg_80_1.time_ <= var_83_6 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				local var_83_8 = arg_80_1:FormatText(StoryNameCfg[698].name)

				arg_80_1.leftNameTxt_.text = var_83_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, true)
				arg_80_1.iconController_:SetSelectedState("hero")

				arg_80_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_80_1.callingController_:SetSelectedState("normal")

				arg_80_1.keyicon_.color = Color.New(1, 1, 1)
				arg_80_1.icon_.color = Color.New(1, 1, 1)

				local var_83_9 = arg_80_1:GetWordFromCfg(319811019)
				local var_83_10 = arg_80_1:FormatText(var_83_9.content)

				arg_80_1.text_.text = var_83_10

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_11 = 9
				local var_83_12 = utf8.len(var_83_10)
				local var_83_13 = var_83_11 <= 0 and var_83_7 or var_83_7 * (var_83_12 / var_83_11)

				if var_83_13 > 0 and var_83_7 < var_83_13 then
					arg_80_1.talkMaxDuration = var_83_13

					if var_83_13 + var_83_6 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_13 + var_83_6
					end
				end

				arg_80_1.text_.text = var_83_10
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)
				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_14 = math.max(var_83_7, arg_80_1.talkMaxDuration)

			if var_83_6 <= arg_80_1.time_ and arg_80_1.time_ < var_83_6 + var_83_14 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_6) / var_83_14

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_6 + var_83_14 and arg_80_1.time_ < var_83_6 + var_83_14 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {}

		arg_80_1:InitPlayNodeList()
	end,
	Play319811020 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 319811020
		arg_84_1.duration_ = 5

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play319811021(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = 0
			local var_87_1 = 0.925

			if var_87_0 < arg_84_1.time_ and arg_84_1.time_ <= var_87_0 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				local var_87_2 = arg_84_1:FormatText(StoryNameCfg[698].name)

				arg_84_1.leftNameTxt_.text = var_87_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, true)
				arg_84_1.iconController_:SetSelectedState("hero")

				arg_84_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_84_1.callingController_:SetSelectedState("normal")

				arg_84_1.keyicon_.color = Color.New(1, 1, 1)
				arg_84_1.icon_.color = Color.New(1, 1, 1)

				local var_87_3 = arg_84_1:GetWordFromCfg(319811020)
				local var_87_4 = arg_84_1:FormatText(var_87_3.content)

				arg_84_1.text_.text = var_87_4

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_5 = 37
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
				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_8 = math.max(var_87_1, arg_84_1.talkMaxDuration)

			if var_87_0 <= arg_84_1.time_ and arg_84_1.time_ < var_87_0 + var_87_8 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_0) / var_87_8

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_0 + var_87_8 and arg_84_1.time_ < var_87_0 + var_87_8 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {}

		arg_84_1:InitPlayNodeList()
	end,
	Play319811021 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 319811021
		arg_88_1.duration_ = 5

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play319811022(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = 0
			local var_91_1 = 0.9

			if var_91_0 < arg_88_1.time_ and arg_88_1.time_ <= var_91_0 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				local var_91_2 = arg_88_1:FormatText(StoryNameCfg[698].name)

				arg_88_1.leftNameTxt_.text = var_91_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, true)
				arg_88_1.iconController_:SetSelectedState("hero")

				arg_88_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_88_1.callingController_:SetSelectedState("normal")

				arg_88_1.keyicon_.color = Color.New(1, 1, 1)
				arg_88_1.icon_.color = Color.New(1, 1, 1)

				local var_91_3 = arg_88_1:GetWordFromCfg(319811021)
				local var_91_4 = arg_88_1:FormatText(var_91_3.content)

				arg_88_1.text_.text = var_91_4

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_5 = 36
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
				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_8 = math.max(var_91_1, arg_88_1.talkMaxDuration)

			if var_91_0 <= arg_88_1.time_ and arg_88_1.time_ < var_91_0 + var_91_8 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_0) / var_91_8

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_0 + var_91_8 and arg_88_1.time_ < var_91_0 + var_91_8 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {}

		arg_88_1:InitPlayNodeList()
	end,
	Play319811022 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 319811022
		arg_92_1.duration_ = 7.63

		local var_92_0 = {
			zh = 3.9,
			ja = 7.633
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
				arg_92_0:Play319811023(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			local var_95_0 = arg_92_1.actors_["10058ui_story"]
			local var_95_1 = 0

			if var_95_1 < arg_92_1.time_ and arg_92_1.time_ <= var_95_1 + arg_95_0 and not isNil(var_95_0) and arg_92_1.var_.characterEffect10058ui_story == nil then
				arg_92_1.var_.characterEffect10058ui_story = var_95_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_2 = 0.200000002980232

			if var_95_1 <= arg_92_1.time_ and arg_92_1.time_ < var_95_1 + var_95_2 and not isNil(var_95_0) then
				local var_95_3 = (arg_92_1.time_ - var_95_1) / var_95_2

				if arg_92_1.var_.characterEffect10058ui_story and not isNil(var_95_0) then
					arg_92_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_92_1.time_ >= var_95_1 + var_95_2 and arg_92_1.time_ < var_95_1 + var_95_2 + arg_95_0 and not isNil(var_95_0) and arg_92_1.var_.characterEffect10058ui_story then
				arg_92_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_95_4 = 0

			if var_95_4 < arg_92_1.time_ and arg_92_1.time_ <= var_95_4 + arg_95_0 then
				arg_92_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action3_2")
			end

			local var_95_5 = 0

			if var_95_5 < arg_92_1.time_ and arg_92_1.time_ <= var_95_5 + arg_95_0 then
				arg_92_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_95_6 = 0
			local var_95_7 = 0.4

			if var_95_6 < arg_92_1.time_ and arg_92_1.time_ <= var_95_6 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				local var_95_8 = arg_92_1:FormatText(StoryNameCfg[471].name)

				arg_92_1.leftNameTxt_.text = var_95_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_9 = arg_92_1:GetWordFromCfg(319811022)
				local var_95_10 = arg_92_1:FormatText(var_95_9.content)

				arg_92_1.text_.text = var_95_10

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_11 = 16
				local var_95_12 = utf8.len(var_95_10)
				local var_95_13 = var_95_11 <= 0 and var_95_7 or var_95_7 * (var_95_12 / var_95_11)

				if var_95_13 > 0 and var_95_7 < var_95_13 then
					arg_92_1.talkMaxDuration = var_95_13

					if var_95_13 + var_95_6 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_13 + var_95_6
					end
				end

				arg_92_1.text_.text = var_95_10
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319811", "319811022", "story_v_out_319811.awb") ~= 0 then
					local var_95_14 = manager.audio:GetVoiceLength("story_v_out_319811", "319811022", "story_v_out_319811.awb") / 1000

					if var_95_14 + var_95_6 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_14 + var_95_6
					end

					if var_95_9.prefab_name ~= "" and arg_92_1.actors_[var_95_9.prefab_name] ~= nil then
						local var_95_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_9.prefab_name].transform, "story_v_out_319811", "319811022", "story_v_out_319811.awb")

						arg_92_1:RecordAudio("319811022", var_95_15)
						arg_92_1:RecordAudio("319811022", var_95_15)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_out_319811", "319811022", "story_v_out_319811.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_out_319811", "319811022", "story_v_out_319811.awb")
				end

				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_16 = math.max(var_95_7, arg_92_1.talkMaxDuration)

			if var_95_6 <= arg_92_1.time_ and arg_92_1.time_ < var_95_6 + var_95_16 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_6) / var_95_16

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_6 + var_95_16 and arg_92_1.time_ < var_95_6 + var_95_16 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {}

		arg_92_1:InitPlayNodeList()
	end,
	Play319811023 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 319811023
		arg_96_1.duration_ = 5

		SetActive(arg_96_1.tipsGo_, false)

		function arg_96_1.onSingleLineFinish_()
			arg_96_1.onSingleLineUpdate_ = nil
			arg_96_1.onSingleLineFinish_ = nil
			arg_96_1.state_ = "waiting"
		end

		function arg_96_1.playNext_(arg_98_0)
			if arg_98_0 == 1 then
				arg_96_0:Play319811024(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			local var_99_0 = arg_96_1.actors_["10058ui_story"]
			local var_99_1 = 0

			if var_99_1 < arg_96_1.time_ and arg_96_1.time_ <= var_99_1 + arg_99_0 and not isNil(var_99_0) and arg_96_1.var_.characterEffect10058ui_story == nil then
				arg_96_1.var_.characterEffect10058ui_story = var_99_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_2 = 0.200000002980232

			if var_99_1 <= arg_96_1.time_ and arg_96_1.time_ < var_99_1 + var_99_2 and not isNil(var_99_0) then
				local var_99_3 = (arg_96_1.time_ - var_99_1) / var_99_2

				if arg_96_1.var_.characterEffect10058ui_story and not isNil(var_99_0) then
					local var_99_4 = Mathf.Lerp(0, 0.5, var_99_3)

					arg_96_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_96_1.var_.characterEffect10058ui_story.fillRatio = var_99_4
				end
			end

			if arg_96_1.time_ >= var_99_1 + var_99_2 and arg_96_1.time_ < var_99_1 + var_99_2 + arg_99_0 and not isNil(var_99_0) and arg_96_1.var_.characterEffect10058ui_story then
				local var_99_5 = 0.5

				arg_96_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_96_1.var_.characterEffect10058ui_story.fillRatio = var_99_5
			end

			local var_99_6 = 0
			local var_99_7 = 0.75

			if var_99_6 < arg_96_1.time_ and arg_96_1.time_ <= var_99_6 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				local var_99_8 = arg_96_1:FormatText(StoryNameCfg[698].name)

				arg_96_1.leftNameTxt_.text = var_99_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, true)
				arg_96_1.iconController_:SetSelectedState("hero")

				arg_96_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_96_1.callingController_:SetSelectedState("normal")

				arg_96_1.keyicon_.color = Color.New(1, 1, 1)
				arg_96_1.icon_.color = Color.New(1, 1, 1)

				local var_99_9 = arg_96_1:GetWordFromCfg(319811023)
				local var_99_10 = arg_96_1:FormatText(var_99_9.content)

				arg_96_1.text_.text = var_99_10

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_11 = 30
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
	Play319811024 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 319811024
		arg_100_1.duration_ = 5

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play319811025(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			local var_103_0 = 0
			local var_103_1 = 1.05

			if var_103_0 < arg_100_1.time_ and arg_100_1.time_ <= var_103_0 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				local var_103_2 = arg_100_1:FormatText(StoryNameCfg[698].name)

				arg_100_1.leftNameTxt_.text = var_103_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, true)
				arg_100_1.iconController_:SetSelectedState("hero")

				arg_100_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_100_1.callingController_:SetSelectedState("normal")

				arg_100_1.keyicon_.color = Color.New(1, 1, 1)
				arg_100_1.icon_.color = Color.New(1, 1, 1)

				local var_103_3 = arg_100_1:GetWordFromCfg(319811024)
				local var_103_4 = arg_100_1:FormatText(var_103_3.content)

				arg_100_1.text_.text = var_103_4

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_5 = 42
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
				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_8 = math.max(var_103_1, arg_100_1.talkMaxDuration)

			if var_103_0 <= arg_100_1.time_ and arg_100_1.time_ < var_103_0 + var_103_8 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_0) / var_103_8

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_0 + var_103_8 and arg_100_1.time_ < var_103_0 + var_103_8 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {}

		arg_100_1:InitPlayNodeList()
	end,
	Play319811025 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 319811025
		arg_104_1.duration_ = 14.33

		local var_104_0 = {
			zh = 8.466,
			ja = 14.333
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
				arg_104_0:Play319811026(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			local var_107_0 = arg_104_1.actors_["10058ui_story"].transform
			local var_107_1 = 0

			if var_107_1 < arg_104_1.time_ and arg_104_1.time_ <= var_107_1 + arg_107_0 then
				arg_104_1.var_.moveOldPos10058ui_story = var_107_0.localPosition
			end

			local var_107_2 = 0.001

			if var_107_1 <= arg_104_1.time_ and arg_104_1.time_ < var_107_1 + var_107_2 then
				local var_107_3 = (arg_104_1.time_ - var_107_1) / var_107_2
				local var_107_4 = Vector3.New(0, -0.98, -6.1)

				var_107_0.localPosition = Vector3.Lerp(arg_104_1.var_.moveOldPos10058ui_story, var_107_4, var_107_3)

				local var_107_5 = manager.ui.mainCamera.transform.position - var_107_0.position

				var_107_0.forward = Vector3.New(var_107_5.x, var_107_5.y, var_107_5.z)

				local var_107_6 = var_107_0.localEulerAngles

				var_107_6.z = 0
				var_107_6.x = 0
				var_107_0.localEulerAngles = var_107_6
			end

			if arg_104_1.time_ >= var_107_1 + var_107_2 and arg_104_1.time_ < var_107_1 + var_107_2 + arg_107_0 then
				var_107_0.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_107_7 = manager.ui.mainCamera.transform.position - var_107_0.position

				var_107_0.forward = Vector3.New(var_107_7.x, var_107_7.y, var_107_7.z)

				local var_107_8 = var_107_0.localEulerAngles

				var_107_8.z = 0
				var_107_8.x = 0
				var_107_0.localEulerAngles = var_107_8
			end

			local var_107_9 = arg_104_1.actors_["10058ui_story"]
			local var_107_10 = 0

			if var_107_10 < arg_104_1.time_ and arg_104_1.time_ <= var_107_10 + arg_107_0 and not isNil(var_107_9) and arg_104_1.var_.characterEffect10058ui_story == nil then
				arg_104_1.var_.characterEffect10058ui_story = var_107_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_107_11 = 0.200000002980232

			if var_107_10 <= arg_104_1.time_ and arg_104_1.time_ < var_107_10 + var_107_11 and not isNil(var_107_9) then
				local var_107_12 = (arg_104_1.time_ - var_107_10) / var_107_11

				if arg_104_1.var_.characterEffect10058ui_story and not isNil(var_107_9) then
					arg_104_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_104_1.time_ >= var_107_10 + var_107_11 and arg_104_1.time_ < var_107_10 + var_107_11 + arg_107_0 and not isNil(var_107_9) and arg_104_1.var_.characterEffect10058ui_story then
				arg_104_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_107_13 = 0
			local var_107_14 = 0.925

			if var_107_13 < arg_104_1.time_ and arg_104_1.time_ <= var_107_13 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				local var_107_15 = arg_104_1:FormatText(StoryNameCfg[471].name)

				arg_104_1.leftNameTxt_.text = var_107_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_16 = arg_104_1:GetWordFromCfg(319811025)
				local var_107_17 = arg_104_1:FormatText(var_107_16.content)

				arg_104_1.text_.text = var_107_17

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_18 = 37
				local var_107_19 = utf8.len(var_107_17)
				local var_107_20 = var_107_18 <= 0 and var_107_14 or var_107_14 * (var_107_19 / var_107_18)

				if var_107_20 > 0 and var_107_14 < var_107_20 then
					arg_104_1.talkMaxDuration = var_107_20

					if var_107_20 + var_107_13 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_20 + var_107_13
					end
				end

				arg_104_1.text_.text = var_107_17
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319811", "319811025", "story_v_out_319811.awb") ~= 0 then
					local var_107_21 = manager.audio:GetVoiceLength("story_v_out_319811", "319811025", "story_v_out_319811.awb") / 1000

					if var_107_21 + var_107_13 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_21 + var_107_13
					end

					if var_107_16.prefab_name ~= "" and arg_104_1.actors_[var_107_16.prefab_name] ~= nil then
						local var_107_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_104_1.actors_[var_107_16.prefab_name].transform, "story_v_out_319811", "319811025", "story_v_out_319811.awb")

						arg_104_1:RecordAudio("319811025", var_107_22)
						arg_104_1:RecordAudio("319811025", var_107_22)
					else
						arg_104_1:AudioAction("play", "voice", "story_v_out_319811", "319811025", "story_v_out_319811.awb")
					end

					arg_104_1:RecordHistoryTalkVoice("story_v_out_319811", "319811025", "story_v_out_319811.awb")
				end

				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_23 = math.max(var_107_14, arg_104_1.talkMaxDuration)

			if var_107_13 <= arg_104_1.time_ and arg_104_1.time_ < var_107_13 + var_107_23 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_13) / var_107_23

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_13 + var_107_23 and arg_104_1.time_ < var_107_13 + var_107_23 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {
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

		arg_104_1:InitPlayNodeList()
	end,
	Play319811026 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 319811026
		arg_108_1.duration_ = 5

		SetActive(arg_108_1.tipsGo_, false)

		function arg_108_1.onSingleLineFinish_()
			arg_108_1.onSingleLineUpdate_ = nil
			arg_108_1.onSingleLineFinish_ = nil
			arg_108_1.state_ = "waiting"
		end

		function arg_108_1.playNext_(arg_110_0)
			if arg_110_0 == 1 then
				arg_108_0:Play319811027(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			local var_111_0 = arg_108_1.actors_["10058ui_story"].transform
			local var_111_1 = 0

			if var_111_1 < arg_108_1.time_ and arg_108_1.time_ <= var_111_1 + arg_111_0 then
				arg_108_1.var_.moveOldPos10058ui_story = var_111_0.localPosition
			end

			local var_111_2 = 0.001

			if var_111_1 <= arg_108_1.time_ and arg_108_1.time_ < var_111_1 + var_111_2 then
				local var_111_3 = (arg_108_1.time_ - var_111_1) / var_111_2
				local var_111_4 = Vector3.New(0, 100, 0)

				var_111_0.localPosition = Vector3.Lerp(arg_108_1.var_.moveOldPos10058ui_story, var_111_4, var_111_3)

				local var_111_5 = manager.ui.mainCamera.transform.position - var_111_0.position

				var_111_0.forward = Vector3.New(var_111_5.x, var_111_5.y, var_111_5.z)

				local var_111_6 = var_111_0.localEulerAngles

				var_111_6.z = 0
				var_111_6.x = 0
				var_111_0.localEulerAngles = var_111_6
			end

			if arg_108_1.time_ >= var_111_1 + var_111_2 and arg_108_1.time_ < var_111_1 + var_111_2 + arg_111_0 then
				var_111_0.localPosition = Vector3.New(0, 100, 0)

				local var_111_7 = manager.ui.mainCamera.transform.position - var_111_0.position

				var_111_0.forward = Vector3.New(var_111_7.x, var_111_7.y, var_111_7.z)

				local var_111_8 = var_111_0.localEulerAngles

				var_111_8.z = 0
				var_111_8.x = 0
				var_111_0.localEulerAngles = var_111_8
			end

			local var_111_9 = arg_108_1.actors_["10058ui_story"]
			local var_111_10 = 0

			if var_111_10 < arg_108_1.time_ and arg_108_1.time_ <= var_111_10 + arg_111_0 and not isNil(var_111_9) and arg_108_1.var_.characterEffect10058ui_story == nil then
				arg_108_1.var_.characterEffect10058ui_story = var_111_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_111_11 = 0.200000002980232

			if var_111_10 <= arg_108_1.time_ and arg_108_1.time_ < var_111_10 + var_111_11 and not isNil(var_111_9) then
				local var_111_12 = (arg_108_1.time_ - var_111_10) / var_111_11

				if arg_108_1.var_.characterEffect10058ui_story and not isNil(var_111_9) then
					local var_111_13 = Mathf.Lerp(0, 0.5, var_111_12)

					arg_108_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_108_1.var_.characterEffect10058ui_story.fillRatio = var_111_13
				end
			end

			if arg_108_1.time_ >= var_111_10 + var_111_11 and arg_108_1.time_ < var_111_10 + var_111_11 + arg_111_0 and not isNil(var_111_9) and arg_108_1.var_.characterEffect10058ui_story then
				local var_111_14 = 0.5

				arg_108_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_108_1.var_.characterEffect10058ui_story.fillRatio = var_111_14
			end

			local var_111_15 = 0
			local var_111_16 = 0.725

			if var_111_15 < arg_108_1.time_ and arg_108_1.time_ <= var_111_15 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, false)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_17 = arg_108_1:GetWordFromCfg(319811026)
				local var_111_18 = arg_108_1:FormatText(var_111_17.content)

				arg_108_1.text_.text = var_111_18

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_19 = 29
				local var_111_20 = utf8.len(var_111_18)
				local var_111_21 = var_111_19 <= 0 and var_111_16 or var_111_16 * (var_111_20 / var_111_19)

				if var_111_21 > 0 and var_111_16 < var_111_21 then
					arg_108_1.talkMaxDuration = var_111_21

					if var_111_21 + var_111_15 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_21 + var_111_15
					end
				end

				arg_108_1.text_.text = var_111_18
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)
				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_22 = math.max(var_111_16, arg_108_1.talkMaxDuration)

			if var_111_15 <= arg_108_1.time_ and arg_108_1.time_ < var_111_15 + var_111_22 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_15) / var_111_22

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_15 + var_111_22 and arg_108_1.time_ < var_111_15 + var_111_22 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {
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

		arg_108_1:InitPlayNodeList()
	end,
	Play319811027 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 319811027
		arg_112_1.duration_ = 5

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
		end

		function arg_112_1.playNext_(arg_114_0)
			if arg_114_0 == 1 then
				arg_112_0:Play319811028(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			local var_115_0 = 0
			local var_115_1 = 0.675

			if var_115_0 < arg_112_1.time_ and arg_112_1.time_ <= var_115_0 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				local var_115_2 = arg_112_1:FormatText(StoryNameCfg[698].name)

				arg_112_1.leftNameTxt_.text = var_115_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, true)
				arg_112_1.iconController_:SetSelectedState("hero")

				arg_112_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_112_1.callingController_:SetSelectedState("normal")

				arg_112_1.keyicon_.color = Color.New(1, 1, 1)
				arg_112_1.icon_.color = Color.New(1, 1, 1)

				local var_115_3 = arg_112_1:GetWordFromCfg(319811027)
				local var_115_4 = arg_112_1:FormatText(var_115_3.content)

				arg_112_1.text_.text = var_115_4

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_5 = 27
				local var_115_6 = utf8.len(var_115_4)
				local var_115_7 = var_115_5 <= 0 and var_115_1 or var_115_1 * (var_115_6 / var_115_5)

				if var_115_7 > 0 and var_115_1 < var_115_7 then
					arg_112_1.talkMaxDuration = var_115_7

					if var_115_7 + var_115_0 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_7 + var_115_0
					end
				end

				arg_112_1.text_.text = var_115_4
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)
				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_8 = math.max(var_115_1, arg_112_1.talkMaxDuration)

			if var_115_0 <= arg_112_1.time_ and arg_112_1.time_ < var_115_0 + var_115_8 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_0) / var_115_8

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_0 + var_115_8 and arg_112_1.time_ < var_115_0 + var_115_8 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {}

		arg_112_1:InitPlayNodeList()
	end,
	Play319811028 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 319811028
		arg_116_1.duration_ = 4.5

		local var_116_0 = {
			zh = 2.2,
			ja = 4.5
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
				arg_116_0:Play319811029(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			local var_119_0 = "1084ui_story"

			if arg_116_1.actors_[var_119_0] == nil then
				local var_119_1 = Asset.Load("Char/" .. "1084ui_story")

				if not isNil(var_119_1) then
					local var_119_2 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_116_1.stage_.transform)

					var_119_2.name = var_119_0
					var_119_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_116_1.actors_[var_119_0] = var_119_2

					local var_119_3 = var_119_2:GetComponentInChildren(typeof(CharacterEffect))

					var_119_3.enabled = true

					local var_119_4 = GameObjectTools.GetOrAddComponent(var_119_2, typeof(DynamicBoneHelper))

					if var_119_4 then
						var_119_4:EnableDynamicBone(false)
					end

					arg_116_1:ShowWeapon(var_119_3.transform, false)

					arg_116_1.var_[var_119_0 .. "Animator"] = var_119_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_116_1.var_[var_119_0 .. "Animator"].applyRootMotion = true
					arg_116_1.var_[var_119_0 .. "LipSync"] = var_119_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_119_5 = arg_116_1.actors_["1084ui_story"].transform
			local var_119_6 = 0

			if var_119_6 < arg_116_1.time_ and arg_116_1.time_ <= var_119_6 + arg_119_0 then
				arg_116_1.var_.moveOldPos1084ui_story = var_119_5.localPosition

				local var_119_7 = "1084ui_story"

				arg_116_1:ShowWeapon(arg_116_1.var_[var_119_7 .. "Animator"].transform, false)
			end

			local var_119_8 = 0.001

			if var_119_6 <= arg_116_1.time_ and arg_116_1.time_ < var_119_6 + var_119_8 then
				local var_119_9 = (arg_116_1.time_ - var_119_6) / var_119_8
				local var_119_10 = Vector3.New(0, -0.97, -6)

				var_119_5.localPosition = Vector3.Lerp(arg_116_1.var_.moveOldPos1084ui_story, var_119_10, var_119_9)

				local var_119_11 = manager.ui.mainCamera.transform.position - var_119_5.position

				var_119_5.forward = Vector3.New(var_119_11.x, var_119_11.y, var_119_11.z)

				local var_119_12 = var_119_5.localEulerAngles

				var_119_12.z = 0
				var_119_12.x = 0
				var_119_5.localEulerAngles = var_119_12
			end

			if arg_116_1.time_ >= var_119_6 + var_119_8 and arg_116_1.time_ < var_119_6 + var_119_8 + arg_119_0 then
				var_119_5.localPosition = Vector3.New(0, -0.97, -6)

				local var_119_13 = manager.ui.mainCamera.transform.position - var_119_5.position

				var_119_5.forward = Vector3.New(var_119_13.x, var_119_13.y, var_119_13.z)

				local var_119_14 = var_119_5.localEulerAngles

				var_119_14.z = 0
				var_119_14.x = 0
				var_119_5.localEulerAngles = var_119_14
			end

			local var_119_15 = arg_116_1.actors_["1084ui_story"]
			local var_119_16 = 0

			if var_119_16 < arg_116_1.time_ and arg_116_1.time_ <= var_119_16 + arg_119_0 and not isNil(var_119_15) and arg_116_1.var_.characterEffect1084ui_story == nil then
				arg_116_1.var_.characterEffect1084ui_story = var_119_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_119_17 = 0.200000002980232

			if var_119_16 <= arg_116_1.time_ and arg_116_1.time_ < var_119_16 + var_119_17 and not isNil(var_119_15) then
				local var_119_18 = (arg_116_1.time_ - var_119_16) / var_119_17

				if arg_116_1.var_.characterEffect1084ui_story and not isNil(var_119_15) then
					arg_116_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_116_1.time_ >= var_119_16 + var_119_17 and arg_116_1.time_ < var_119_16 + var_119_17 + arg_119_0 and not isNil(var_119_15) and arg_116_1.var_.characterEffect1084ui_story then
				arg_116_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_119_19 = 0

			if var_119_19 < arg_116_1.time_ and arg_116_1.time_ <= var_119_19 + arg_119_0 then
				arg_116_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			local var_119_20 = 0

			if var_119_20 < arg_116_1.time_ and arg_116_1.time_ <= var_119_20 + arg_119_0 then
				arg_116_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_119_21 = 0
			local var_119_22 = 0.275

			if var_119_21 < arg_116_1.time_ and arg_116_1.time_ <= var_119_21 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				local var_119_23 = arg_116_1:FormatText(StoryNameCfg[6].name)

				arg_116_1.leftNameTxt_.text = var_119_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_24 = arg_116_1:GetWordFromCfg(319811028)
				local var_119_25 = arg_116_1:FormatText(var_119_24.content)

				arg_116_1.text_.text = var_119_25

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_26 = 11
				local var_119_27 = utf8.len(var_119_25)
				local var_119_28 = var_119_26 <= 0 and var_119_22 or var_119_22 * (var_119_27 / var_119_26)

				if var_119_28 > 0 and var_119_22 < var_119_28 then
					arg_116_1.talkMaxDuration = var_119_28

					if var_119_28 + var_119_21 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_28 + var_119_21
					end
				end

				arg_116_1.text_.text = var_119_25
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319811", "319811028", "story_v_out_319811.awb") ~= 0 then
					local var_119_29 = manager.audio:GetVoiceLength("story_v_out_319811", "319811028", "story_v_out_319811.awb") / 1000

					if var_119_29 + var_119_21 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_29 + var_119_21
					end

					if var_119_24.prefab_name ~= "" and arg_116_1.actors_[var_119_24.prefab_name] ~= nil then
						local var_119_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_116_1.actors_[var_119_24.prefab_name].transform, "story_v_out_319811", "319811028", "story_v_out_319811.awb")

						arg_116_1:RecordAudio("319811028", var_119_30)
						arg_116_1:RecordAudio("319811028", var_119_30)
					else
						arg_116_1:AudioAction("play", "voice", "story_v_out_319811", "319811028", "story_v_out_319811.awb")
					end

					arg_116_1:RecordHistoryTalkVoice("story_v_out_319811", "319811028", "story_v_out_319811.awb")
				end

				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_31 = math.max(var_119_22, arg_116_1.talkMaxDuration)

			if var_119_21 <= arg_116_1.time_ and arg_116_1.time_ < var_119_21 + var_119_31 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_21) / var_119_31

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_21 + var_119_31 and arg_116_1.time_ < var_119_21 + var_119_31 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {
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

		arg_116_1:InitPlayNodeList()
	end,
	Play319811029 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 319811029
		arg_120_1.duration_ = 5

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"
		end

		function arg_120_1.playNext_(arg_122_0)
			if arg_122_0 == 1 then
				arg_120_0:Play319811030(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			local var_123_0 = arg_120_1.actors_["1084ui_story"]
			local var_123_1 = 0

			if var_123_1 < arg_120_1.time_ and arg_120_1.time_ <= var_123_1 + arg_123_0 and not isNil(var_123_0) and arg_120_1.var_.characterEffect1084ui_story == nil then
				arg_120_1.var_.characterEffect1084ui_story = var_123_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_123_2 = 0.200000002980232

			if var_123_1 <= arg_120_1.time_ and arg_120_1.time_ < var_123_1 + var_123_2 and not isNil(var_123_0) then
				local var_123_3 = (arg_120_1.time_ - var_123_1) / var_123_2

				if arg_120_1.var_.characterEffect1084ui_story and not isNil(var_123_0) then
					local var_123_4 = Mathf.Lerp(0, 0.5, var_123_3)

					arg_120_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_120_1.var_.characterEffect1084ui_story.fillRatio = var_123_4
				end
			end

			if arg_120_1.time_ >= var_123_1 + var_123_2 and arg_120_1.time_ < var_123_1 + var_123_2 + arg_123_0 and not isNil(var_123_0) and arg_120_1.var_.characterEffect1084ui_story then
				local var_123_5 = 0.5

				arg_120_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_120_1.var_.characterEffect1084ui_story.fillRatio = var_123_5
			end

			local var_123_6 = 0
			local var_123_7 = 0.85

			if var_123_6 < arg_120_1.time_ and arg_120_1.time_ <= var_123_6 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, false)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_8 = arg_120_1:GetWordFromCfg(319811029)
				local var_123_9 = arg_120_1:FormatText(var_123_8.content)

				arg_120_1.text_.text = var_123_9

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_10 = 34
				local var_123_11 = utf8.len(var_123_9)
				local var_123_12 = var_123_10 <= 0 and var_123_7 or var_123_7 * (var_123_11 / var_123_10)

				if var_123_12 > 0 and var_123_7 < var_123_12 then
					arg_120_1.talkMaxDuration = var_123_12

					if var_123_12 + var_123_6 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_12 + var_123_6
					end
				end

				arg_120_1.text_.text = var_123_9
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)
				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_13 = math.max(var_123_7, arg_120_1.talkMaxDuration)

			if var_123_6 <= arg_120_1.time_ and arg_120_1.time_ < var_123_6 + var_123_13 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_6) / var_123_13

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_6 + var_123_13 and arg_120_1.time_ < var_123_6 + var_123_13 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {}

		arg_120_1:InitPlayNodeList()
	end,
	Play319811030 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 319811030
		arg_124_1.duration_ = 5

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play319811031(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			local var_127_0 = 0
			local var_127_1 = 0.825

			if var_127_0 < arg_124_1.time_ and arg_124_1.time_ <= var_127_0 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				local var_127_2 = arg_124_1:FormatText(StoryNameCfg[698].name)

				arg_124_1.leftNameTxt_.text = var_127_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, true)
				arg_124_1.iconController_:SetSelectedState("hero")

				arg_124_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_124_1.callingController_:SetSelectedState("normal")

				arg_124_1.keyicon_.color = Color.New(1, 1, 1)
				arg_124_1.icon_.color = Color.New(1, 1, 1)

				local var_127_3 = arg_124_1:GetWordFromCfg(319811030)
				local var_127_4 = arg_124_1:FormatText(var_127_3.content)

				arg_124_1.text_.text = var_127_4

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_5 = 33
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
				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_8 = math.max(var_127_1, arg_124_1.talkMaxDuration)

			if var_127_0 <= arg_124_1.time_ and arg_124_1.time_ < var_127_0 + var_127_8 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_0) / var_127_8

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_0 + var_127_8 and arg_124_1.time_ < var_127_0 + var_127_8 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {}

		arg_124_1:InitPlayNodeList()
	end,
	Play319811031 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 319811031
		arg_128_1.duration_ = 5

		SetActive(arg_128_1.tipsGo_, false)

		function arg_128_1.onSingleLineFinish_()
			arg_128_1.onSingleLineUpdate_ = nil
			arg_128_1.onSingleLineFinish_ = nil
			arg_128_1.state_ = "waiting"
		end

		function arg_128_1.playNext_(arg_130_0)
			if arg_130_0 == 1 then
				arg_128_0:Play319811032(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			local var_131_0 = 0
			local var_131_1 = 0.55

			if var_131_0 < arg_128_1.time_ and arg_128_1.time_ <= var_131_0 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				local var_131_2 = arg_128_1:FormatText(StoryNameCfg[698].name)

				arg_128_1.leftNameTxt_.text = var_131_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, true)
				arg_128_1.iconController_:SetSelectedState("hero")

				arg_128_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_128_1.callingController_:SetSelectedState("normal")

				arg_128_1.keyicon_.color = Color.New(1, 1, 1)
				arg_128_1.icon_.color = Color.New(1, 1, 1)

				local var_131_3 = arg_128_1:GetWordFromCfg(319811031)
				local var_131_4 = arg_128_1:FormatText(var_131_3.content)

				arg_128_1.text_.text = var_131_4

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_5 = 22
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
				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_8 = math.max(var_131_1, arg_128_1.talkMaxDuration)

			if var_131_0 <= arg_128_1.time_ and arg_128_1.time_ < var_131_0 + var_131_8 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_0) / var_131_8

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_0 + var_131_8 and arg_128_1.time_ < var_131_0 + var_131_8 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {}

		arg_128_1:InitPlayNodeList()
	end,
	Play319811032 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 319811032
		arg_132_1.duration_ = 4.9

		local var_132_0 = {
			zh = 1.999999999999,
			ja = 4.9
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
				arg_132_0:Play319811033(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			local var_135_0 = arg_132_1.actors_["1084ui_story"].transform
			local var_135_1 = 0

			if var_135_1 < arg_132_1.time_ and arg_132_1.time_ <= var_135_1 + arg_135_0 then
				arg_132_1.var_.moveOldPos1084ui_story = var_135_0.localPosition
			end

			local var_135_2 = 0.001

			if var_135_1 <= arg_132_1.time_ and arg_132_1.time_ < var_135_1 + var_135_2 then
				local var_135_3 = (arg_132_1.time_ - var_135_1) / var_135_2
				local var_135_4 = Vector3.New(0, -0.97, -6)

				var_135_0.localPosition = Vector3.Lerp(arg_132_1.var_.moveOldPos1084ui_story, var_135_4, var_135_3)

				local var_135_5 = manager.ui.mainCamera.transform.position - var_135_0.position

				var_135_0.forward = Vector3.New(var_135_5.x, var_135_5.y, var_135_5.z)

				local var_135_6 = var_135_0.localEulerAngles

				var_135_6.z = 0
				var_135_6.x = 0
				var_135_0.localEulerAngles = var_135_6
			end

			if arg_132_1.time_ >= var_135_1 + var_135_2 and arg_132_1.time_ < var_135_1 + var_135_2 + arg_135_0 then
				var_135_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_135_7 = manager.ui.mainCamera.transform.position - var_135_0.position

				var_135_0.forward = Vector3.New(var_135_7.x, var_135_7.y, var_135_7.z)

				local var_135_8 = var_135_0.localEulerAngles

				var_135_8.z = 0
				var_135_8.x = 0
				var_135_0.localEulerAngles = var_135_8
			end

			local var_135_9 = arg_132_1.actors_["1084ui_story"]
			local var_135_10 = 0

			if var_135_10 < arg_132_1.time_ and arg_132_1.time_ <= var_135_10 + arg_135_0 and not isNil(var_135_9) and arg_132_1.var_.characterEffect1084ui_story == nil then
				arg_132_1.var_.characterEffect1084ui_story = var_135_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_135_11 = 0.200000002980232

			if var_135_10 <= arg_132_1.time_ and arg_132_1.time_ < var_135_10 + var_135_11 and not isNil(var_135_9) then
				local var_135_12 = (arg_132_1.time_ - var_135_10) / var_135_11

				if arg_132_1.var_.characterEffect1084ui_story and not isNil(var_135_9) then
					arg_132_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_132_1.time_ >= var_135_10 + var_135_11 and arg_132_1.time_ < var_135_10 + var_135_11 + arg_135_0 and not isNil(var_135_9) and arg_132_1.var_.characterEffect1084ui_story then
				arg_132_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_135_13 = 0

			if var_135_13 < arg_132_1.time_ and arg_132_1.time_ <= var_135_13 + arg_135_0 then
				arg_132_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_2")
			end

			local var_135_14 = 0

			if var_135_14 < arg_132_1.time_ and arg_132_1.time_ <= var_135_14 + arg_135_0 then
				arg_132_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2201cva")
			end

			local var_135_15 = 0
			local var_135_16 = 0.1

			if var_135_15 < arg_132_1.time_ and arg_132_1.time_ <= var_135_15 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				local var_135_17 = arg_132_1:FormatText(StoryNameCfg[6].name)

				arg_132_1.leftNameTxt_.text = var_135_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_18 = arg_132_1:GetWordFromCfg(319811032)
				local var_135_19 = arg_132_1:FormatText(var_135_18.content)

				arg_132_1.text_.text = var_135_19

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_20 = 4
				local var_135_21 = utf8.len(var_135_19)
				local var_135_22 = var_135_20 <= 0 and var_135_16 or var_135_16 * (var_135_21 / var_135_20)

				if var_135_22 > 0 and var_135_16 < var_135_22 then
					arg_132_1.talkMaxDuration = var_135_22

					if var_135_22 + var_135_15 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_22 + var_135_15
					end
				end

				arg_132_1.text_.text = var_135_19
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319811", "319811032", "story_v_out_319811.awb") ~= 0 then
					local var_135_23 = manager.audio:GetVoiceLength("story_v_out_319811", "319811032", "story_v_out_319811.awb") / 1000

					if var_135_23 + var_135_15 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_23 + var_135_15
					end

					if var_135_18.prefab_name ~= "" and arg_132_1.actors_[var_135_18.prefab_name] ~= nil then
						local var_135_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_18.prefab_name].transform, "story_v_out_319811", "319811032", "story_v_out_319811.awb")

						arg_132_1:RecordAudio("319811032", var_135_24)
						arg_132_1:RecordAudio("319811032", var_135_24)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_out_319811", "319811032", "story_v_out_319811.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_out_319811", "319811032", "story_v_out_319811.awb")
				end

				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_25 = math.max(var_135_16, arg_132_1.talkMaxDuration)

			if var_135_15 <= arg_132_1.time_ and arg_132_1.time_ < var_135_15 + var_135_25 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_15) / var_135_25

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_15 + var_135_25 and arg_132_1.time_ < var_135_15 + var_135_25 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {
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

		arg_132_1:InitPlayNodeList()
	end,
	Play319811033 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 319811033
		arg_136_1.duration_ = 5

		SetActive(arg_136_1.tipsGo_, false)

		function arg_136_1.onSingleLineFinish_()
			arg_136_1.onSingleLineUpdate_ = nil
			arg_136_1.onSingleLineFinish_ = nil
			arg_136_1.state_ = "waiting"
		end

		function arg_136_1.playNext_(arg_138_0)
			if arg_138_0 == 1 then
				arg_136_0:Play319811034(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			local var_139_0 = arg_136_1.actors_["1084ui_story"]
			local var_139_1 = 0

			if var_139_1 < arg_136_1.time_ and arg_136_1.time_ <= var_139_1 + arg_139_0 and not isNil(var_139_0) and arg_136_1.var_.characterEffect1084ui_story == nil then
				arg_136_1.var_.characterEffect1084ui_story = var_139_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_139_2 = 0.200000002980232

			if var_139_1 <= arg_136_1.time_ and arg_136_1.time_ < var_139_1 + var_139_2 and not isNil(var_139_0) then
				local var_139_3 = (arg_136_1.time_ - var_139_1) / var_139_2

				if arg_136_1.var_.characterEffect1084ui_story and not isNil(var_139_0) then
					local var_139_4 = Mathf.Lerp(0, 0.5, var_139_3)

					arg_136_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_136_1.var_.characterEffect1084ui_story.fillRatio = var_139_4
				end
			end

			if arg_136_1.time_ >= var_139_1 + var_139_2 and arg_136_1.time_ < var_139_1 + var_139_2 + arg_139_0 and not isNil(var_139_0) and arg_136_1.var_.characterEffect1084ui_story then
				local var_139_5 = 0.5

				arg_136_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_136_1.var_.characterEffect1084ui_story.fillRatio = var_139_5
			end

			local var_139_6 = 0
			local var_139_7 = 0.125

			if var_139_6 < arg_136_1.time_ and arg_136_1.time_ <= var_139_6 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				local var_139_8 = arg_136_1:FormatText(StoryNameCfg[698].name)

				arg_136_1.leftNameTxt_.text = var_139_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, true)
				arg_136_1.iconController_:SetSelectedState("hero")

				arg_136_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_136_1.callingController_:SetSelectedState("normal")

				arg_136_1.keyicon_.color = Color.New(1, 1, 1)
				arg_136_1.icon_.color = Color.New(1, 1, 1)

				local var_139_9 = arg_136_1:GetWordFromCfg(319811033)
				local var_139_10 = arg_136_1:FormatText(var_139_9.content)

				arg_136_1.text_.text = var_139_10

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_11 = 5
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
	Play319811034 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 319811034
		arg_140_1.duration_ = 5

		SetActive(arg_140_1.tipsGo_, false)

		function arg_140_1.onSingleLineFinish_()
			arg_140_1.onSingleLineUpdate_ = nil
			arg_140_1.onSingleLineFinish_ = nil
			arg_140_1.state_ = "waiting"
		end

		function arg_140_1.playNext_(arg_142_0)
			if arg_142_0 == 1 then
				arg_140_0:Play319811035(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			local var_143_0 = arg_140_1.actors_["1084ui_story"].transform
			local var_143_1 = 0

			if var_143_1 < arg_140_1.time_ and arg_140_1.time_ <= var_143_1 + arg_143_0 then
				arg_140_1.var_.moveOldPos1084ui_story = var_143_0.localPosition
			end

			local var_143_2 = 0.001

			if var_143_1 <= arg_140_1.time_ and arg_140_1.time_ < var_143_1 + var_143_2 then
				local var_143_3 = (arg_140_1.time_ - var_143_1) / var_143_2
				local var_143_4 = Vector3.New(0, 100, 0)

				var_143_0.localPosition = Vector3.Lerp(arg_140_1.var_.moveOldPos1084ui_story, var_143_4, var_143_3)

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
			local var_143_10 = 0.7

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

				local var_143_11 = arg_140_1:GetWordFromCfg(319811034)
				local var_143_12 = arg_140_1:FormatText(var_143_11.content)

				arg_140_1.text_.text = var_143_12

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_13 = 28
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
				actorName = "1084ui_story",
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
	Play319811035 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 319811035
		arg_144_1.duration_ = 9.07

		local var_144_0 = {
			zh = 6.133,
			ja = 9.066
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
				arg_144_0:Play319811036(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			local var_147_0 = arg_144_1.actors_["1084ui_story"]
			local var_147_1 = 0

			if var_147_1 < arg_144_1.time_ and arg_144_1.time_ <= var_147_1 + arg_147_0 and not isNil(var_147_0) and arg_144_1.var_.characterEffect1084ui_story == nil then
				arg_144_1.var_.characterEffect1084ui_story = var_147_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_147_2 = 0.200000002980232

			if var_147_1 <= arg_144_1.time_ and arg_144_1.time_ < var_147_1 + var_147_2 and not isNil(var_147_0) then
				local var_147_3 = (arg_144_1.time_ - var_147_1) / var_147_2

				if arg_144_1.var_.characterEffect1084ui_story and not isNil(var_147_0) then
					arg_144_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_144_1.time_ >= var_147_1 + var_147_2 and arg_144_1.time_ < var_147_1 + var_147_2 + arg_147_0 and not isNil(var_147_0) and arg_144_1.var_.characterEffect1084ui_story then
				arg_144_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_147_4 = arg_144_1.actors_["1084ui_story"].transform
			local var_147_5 = 0

			if var_147_5 < arg_144_1.time_ and arg_144_1.time_ <= var_147_5 + arg_147_0 then
				arg_144_1.var_.moveOldPos1084ui_story = var_147_4.localPosition
			end

			local var_147_6 = 0.001

			if var_147_5 <= arg_144_1.time_ and arg_144_1.time_ < var_147_5 + var_147_6 then
				local var_147_7 = (arg_144_1.time_ - var_147_5) / var_147_6
				local var_147_8 = Vector3.New(0, -0.97, -6)

				var_147_4.localPosition = Vector3.Lerp(arg_144_1.var_.moveOldPos1084ui_story, var_147_8, var_147_7)

				local var_147_9 = manager.ui.mainCamera.transform.position - var_147_4.position

				var_147_4.forward = Vector3.New(var_147_9.x, var_147_9.y, var_147_9.z)

				local var_147_10 = var_147_4.localEulerAngles

				var_147_10.z = 0
				var_147_10.x = 0
				var_147_4.localEulerAngles = var_147_10
			end

			if arg_144_1.time_ >= var_147_5 + var_147_6 and arg_144_1.time_ < var_147_5 + var_147_6 + arg_147_0 then
				var_147_4.localPosition = Vector3.New(0, -0.97, -6)

				local var_147_11 = manager.ui.mainCamera.transform.position - var_147_4.position

				var_147_4.forward = Vector3.New(var_147_11.x, var_147_11.y, var_147_11.z)

				local var_147_12 = var_147_4.localEulerAngles

				var_147_12.z = 0
				var_147_12.x = 0
				var_147_4.localEulerAngles = var_147_12
			end

			local var_147_13 = arg_144_1.actors_["1084ui_story"]
			local var_147_14 = 0

			if var_147_14 < arg_144_1.time_ and arg_144_1.time_ <= var_147_14 + arg_147_0 and not isNil(var_147_13) and arg_144_1.var_.characterEffect1084ui_story == nil then
				arg_144_1.var_.characterEffect1084ui_story = var_147_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_147_15 = 0.200000002980232

			if var_147_14 <= arg_144_1.time_ and arg_144_1.time_ < var_147_14 + var_147_15 and not isNil(var_147_13) then
				local var_147_16 = (arg_144_1.time_ - var_147_14) / var_147_15

				if arg_144_1.var_.characterEffect1084ui_story and not isNil(var_147_13) then
					arg_144_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_144_1.time_ >= var_147_14 + var_147_15 and arg_144_1.time_ < var_147_14 + var_147_15 + arg_147_0 and not isNil(var_147_13) and arg_144_1.var_.characterEffect1084ui_story then
				arg_144_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_147_17 = 0

			if var_147_17 < arg_144_1.time_ and arg_144_1.time_ <= var_147_17 + arg_147_0 then
				arg_144_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action5_1")
			end

			local var_147_18 = 0

			if var_147_18 < arg_144_1.time_ and arg_144_1.time_ <= var_147_18 + arg_147_0 then
				arg_144_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2202cva")
			end

			local var_147_19 = 0
			local var_147_20 = 0.825

			if var_147_19 < arg_144_1.time_ and arg_144_1.time_ <= var_147_19 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				local var_147_21 = arg_144_1:FormatText(StoryNameCfg[6].name)

				arg_144_1.leftNameTxt_.text = var_147_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, false)
				arg_144_1.callingController_:SetSelectedState("normal")

				local var_147_22 = arg_144_1:GetWordFromCfg(319811035)
				local var_147_23 = arg_144_1:FormatText(var_147_22.content)

				arg_144_1.text_.text = var_147_23

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_24 = 33
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

				if manager.audio:GetVoiceLength("story_v_out_319811", "319811035", "story_v_out_319811.awb") ~= 0 then
					local var_147_27 = manager.audio:GetVoiceLength("story_v_out_319811", "319811035", "story_v_out_319811.awb") / 1000

					if var_147_27 + var_147_19 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_27 + var_147_19
					end

					if var_147_22.prefab_name ~= "" and arg_144_1.actors_[var_147_22.prefab_name] ~= nil then
						local var_147_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_144_1.actors_[var_147_22.prefab_name].transform, "story_v_out_319811", "319811035", "story_v_out_319811.awb")

						arg_144_1:RecordAudio("319811035", var_147_28)
						arg_144_1:RecordAudio("319811035", var_147_28)
					else
						arg_144_1:AudioAction("play", "voice", "story_v_out_319811", "319811035", "story_v_out_319811.awb")
					end

					arg_144_1:RecordHistoryTalkVoice("story_v_out_319811", "319811035", "story_v_out_319811.awb")
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
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_144_1:InitPlayNodeList()
	end,
	Play319811036 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 319811036
		arg_148_1.duration_ = 9.07

		local var_148_0 = {
			zh = 7.966,
			ja = 9.066
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
				arg_148_0:Play319811037(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			local var_151_0 = 0
			local var_151_1 = 1

			if var_151_0 < arg_148_1.time_ and arg_148_1.time_ <= var_151_0 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, true)

				local var_151_2 = arg_148_1:FormatText(StoryNameCfg[6].name)

				arg_148_1.leftNameTxt_.text = var_151_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_148_1.leftNameTxt_.transform)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1.leftNameTxt_.text)
				SetActive(arg_148_1.iconTrs_.gameObject, false)
				arg_148_1.callingController_:SetSelectedState("normal")

				local var_151_3 = arg_148_1:GetWordFromCfg(319811036)
				local var_151_4 = arg_148_1:FormatText(var_151_3.content)

				arg_148_1.text_.text = var_151_4

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_5 = 40
				local var_151_6 = utf8.len(var_151_4)
				local var_151_7 = var_151_5 <= 0 and var_151_1 or var_151_1 * (var_151_6 / var_151_5)

				if var_151_7 > 0 and var_151_1 < var_151_7 then
					arg_148_1.talkMaxDuration = var_151_7

					if var_151_7 + var_151_0 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_7 + var_151_0
					end
				end

				arg_148_1.text_.text = var_151_4
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319811", "319811036", "story_v_out_319811.awb") ~= 0 then
					local var_151_8 = manager.audio:GetVoiceLength("story_v_out_319811", "319811036", "story_v_out_319811.awb") / 1000

					if var_151_8 + var_151_0 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_8 + var_151_0
					end

					if var_151_3.prefab_name ~= "" and arg_148_1.actors_[var_151_3.prefab_name] ~= nil then
						local var_151_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_148_1.actors_[var_151_3.prefab_name].transform, "story_v_out_319811", "319811036", "story_v_out_319811.awb")

						arg_148_1:RecordAudio("319811036", var_151_9)
						arg_148_1:RecordAudio("319811036", var_151_9)
					else
						arg_148_1:AudioAction("play", "voice", "story_v_out_319811", "319811036", "story_v_out_319811.awb")
					end

					arg_148_1:RecordHistoryTalkVoice("story_v_out_319811", "319811036", "story_v_out_319811.awb")
				end

				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_10 = math.max(var_151_1, arg_148_1.talkMaxDuration)

			if var_151_0 <= arg_148_1.time_ and arg_148_1.time_ < var_151_0 + var_151_10 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_0) / var_151_10

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_0 + var_151_10 and arg_148_1.time_ < var_151_0 + var_151_10 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {}

		arg_148_1:InitPlayNodeList()
	end,
	Play319811037 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 319811037
		arg_152_1.duration_ = 6.93

		local var_152_0 = {
			zh = 6.933,
			ja = 6.633
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
				arg_152_0:Play319811038(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			local var_155_0 = 0

			if var_155_0 < arg_152_1.time_ and arg_152_1.time_ <= var_155_0 + arg_155_0 then
				arg_152_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action5_2")
			end

			local var_155_1 = 0

			if var_155_1 < arg_152_1.time_ and arg_152_1.time_ <= var_155_1 + arg_155_0 then
				arg_152_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_155_2 = 0
			local var_155_3 = 0.875

			if var_155_2 < arg_152_1.time_ and arg_152_1.time_ <= var_155_2 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, true)

				local var_155_4 = arg_152_1:FormatText(StoryNameCfg[6].name)

				arg_152_1.leftNameTxt_.text = var_155_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_152_1.leftNameTxt_.transform)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1.leftNameTxt_.text)
				SetActive(arg_152_1.iconTrs_.gameObject, false)
				arg_152_1.callingController_:SetSelectedState("normal")

				local var_155_5 = arg_152_1:GetWordFromCfg(319811037)
				local var_155_6 = arg_152_1:FormatText(var_155_5.content)

				arg_152_1.text_.text = var_155_6

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_7 = 35
				local var_155_8 = utf8.len(var_155_6)
				local var_155_9 = var_155_7 <= 0 and var_155_3 or var_155_3 * (var_155_8 / var_155_7)

				if var_155_9 > 0 and var_155_3 < var_155_9 then
					arg_152_1.talkMaxDuration = var_155_9

					if var_155_9 + var_155_2 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_9 + var_155_2
					end
				end

				arg_152_1.text_.text = var_155_6
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319811", "319811037", "story_v_out_319811.awb") ~= 0 then
					local var_155_10 = manager.audio:GetVoiceLength("story_v_out_319811", "319811037", "story_v_out_319811.awb") / 1000

					if var_155_10 + var_155_2 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_10 + var_155_2
					end

					if var_155_5.prefab_name ~= "" and arg_152_1.actors_[var_155_5.prefab_name] ~= nil then
						local var_155_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_152_1.actors_[var_155_5.prefab_name].transform, "story_v_out_319811", "319811037", "story_v_out_319811.awb")

						arg_152_1:RecordAudio("319811037", var_155_11)
						arg_152_1:RecordAudio("319811037", var_155_11)
					else
						arg_152_1:AudioAction("play", "voice", "story_v_out_319811", "319811037", "story_v_out_319811.awb")
					end

					arg_152_1:RecordHistoryTalkVoice("story_v_out_319811", "319811037", "story_v_out_319811.awb")
				end

				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_12 = math.max(var_155_3, arg_152_1.talkMaxDuration)

			if var_155_2 <= arg_152_1.time_ and arg_152_1.time_ < var_155_2 + var_155_12 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - var_155_2) / var_155_12

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= var_155_2 + var_155_12 and arg_152_1.time_ < var_155_2 + var_155_12 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {}

		arg_152_1:InitPlayNodeList()
	end,
	Play319811038 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 319811038
		arg_156_1.duration_ = 8.67

		local var_156_0 = {
			zh = 6.5,
			ja = 8.666
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
				arg_156_0:Play319811039(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			local var_159_0 = 0
			local var_159_1 = 0.825

			if var_159_0 < arg_156_1.time_ and arg_156_1.time_ <= var_159_0 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, true)

				local var_159_2 = arg_156_1:FormatText(StoryNameCfg[6].name)

				arg_156_1.leftNameTxt_.text = var_159_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_156_1.leftNameTxt_.transform)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1.leftNameTxt_.text)
				SetActive(arg_156_1.iconTrs_.gameObject, false)
				arg_156_1.callingController_:SetSelectedState("normal")

				local var_159_3 = arg_156_1:GetWordFromCfg(319811038)
				local var_159_4 = arg_156_1:FormatText(var_159_3.content)

				arg_156_1.text_.text = var_159_4

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_5 = 33
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

				if manager.audio:GetVoiceLength("story_v_out_319811", "319811038", "story_v_out_319811.awb") ~= 0 then
					local var_159_8 = manager.audio:GetVoiceLength("story_v_out_319811", "319811038", "story_v_out_319811.awb") / 1000

					if var_159_8 + var_159_0 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_8 + var_159_0
					end

					if var_159_3.prefab_name ~= "" and arg_156_1.actors_[var_159_3.prefab_name] ~= nil then
						local var_159_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_156_1.actors_[var_159_3.prefab_name].transform, "story_v_out_319811", "319811038", "story_v_out_319811.awb")

						arg_156_1:RecordAudio("319811038", var_159_9)
						arg_156_1:RecordAudio("319811038", var_159_9)
					else
						arg_156_1:AudioAction("play", "voice", "story_v_out_319811", "319811038", "story_v_out_319811.awb")
					end

					arg_156_1:RecordHistoryTalkVoice("story_v_out_319811", "319811038", "story_v_out_319811.awb")
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
	Play319811039 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 319811039
		arg_160_1.duration_ = 4.87

		local var_160_0 = {
			zh = 3.533,
			ja = 4.866
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
				arg_160_0:Play319811040(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			local var_163_0 = arg_160_1.actors_["1084ui_story"].transform
			local var_163_1 = 0

			if var_163_1 < arg_160_1.time_ and arg_160_1.time_ <= var_163_1 + arg_163_0 then
				arg_160_1.var_.moveOldPos1084ui_story = var_163_0.localPosition
			end

			local var_163_2 = 0.001

			if var_163_1 <= arg_160_1.time_ and arg_160_1.time_ < var_163_1 + var_163_2 then
				local var_163_3 = (arg_160_1.time_ - var_163_1) / var_163_2
				local var_163_4 = Vector3.New(0, -0.97, -6)

				var_163_0.localPosition = Vector3.Lerp(arg_160_1.var_.moveOldPos1084ui_story, var_163_4, var_163_3)

				local var_163_5 = manager.ui.mainCamera.transform.position - var_163_0.position

				var_163_0.forward = Vector3.New(var_163_5.x, var_163_5.y, var_163_5.z)

				local var_163_6 = var_163_0.localEulerAngles

				var_163_6.z = 0
				var_163_6.x = 0
				var_163_0.localEulerAngles = var_163_6
			end

			if arg_160_1.time_ >= var_163_1 + var_163_2 and arg_160_1.time_ < var_163_1 + var_163_2 + arg_163_0 then
				var_163_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_163_7 = manager.ui.mainCamera.transform.position - var_163_0.position

				var_163_0.forward = Vector3.New(var_163_7.x, var_163_7.y, var_163_7.z)

				local var_163_8 = var_163_0.localEulerAngles

				var_163_8.z = 0
				var_163_8.x = 0
				var_163_0.localEulerAngles = var_163_8
			end

			local var_163_9 = 0

			if var_163_9 < arg_160_1.time_ and arg_160_1.time_ <= var_163_9 + arg_163_0 then
				arg_160_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			local var_163_10 = 0
			local var_163_11 = 0.525

			if var_163_10 < arg_160_1.time_ and arg_160_1.time_ <= var_163_10 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, true)

				local var_163_12 = arg_160_1:FormatText(StoryNameCfg[6].name)

				arg_160_1.leftNameTxt_.text = var_163_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_160_1.leftNameTxt_.transform)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1.leftNameTxt_.text)
				SetActive(arg_160_1.iconTrs_.gameObject, false)
				arg_160_1.callingController_:SetSelectedState("normal")

				local var_163_13 = arg_160_1:GetWordFromCfg(319811039)
				local var_163_14 = arg_160_1:FormatText(var_163_13.content)

				arg_160_1.text_.text = var_163_14

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_15 = 21
				local var_163_16 = utf8.len(var_163_14)
				local var_163_17 = var_163_15 <= 0 and var_163_11 or var_163_11 * (var_163_16 / var_163_15)

				if var_163_17 > 0 and var_163_11 < var_163_17 then
					arg_160_1.talkMaxDuration = var_163_17

					if var_163_17 + var_163_10 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_17 + var_163_10
					end
				end

				arg_160_1.text_.text = var_163_14
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319811", "319811039", "story_v_out_319811.awb") ~= 0 then
					local var_163_18 = manager.audio:GetVoiceLength("story_v_out_319811", "319811039", "story_v_out_319811.awb") / 1000

					if var_163_18 + var_163_10 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_18 + var_163_10
					end

					if var_163_13.prefab_name ~= "" and arg_160_1.actors_[var_163_13.prefab_name] ~= nil then
						local var_163_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_160_1.actors_[var_163_13.prefab_name].transform, "story_v_out_319811", "319811039", "story_v_out_319811.awb")

						arg_160_1:RecordAudio("319811039", var_163_19)
						arg_160_1:RecordAudio("319811039", var_163_19)
					else
						arg_160_1:AudioAction("play", "voice", "story_v_out_319811", "319811039", "story_v_out_319811.awb")
					end

					arg_160_1:RecordHistoryTalkVoice("story_v_out_319811", "319811039", "story_v_out_319811.awb")
				end

				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_20 = math.max(var_163_11, arg_160_1.talkMaxDuration)

			if var_163_10 <= arg_160_1.time_ and arg_160_1.time_ < var_163_10 + var_163_20 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - var_163_10) / var_163_20

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= var_163_10 + var_163_20 and arg_160_1.time_ < var_163_10 + var_163_20 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {
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

		arg_160_1:InitPlayNodeList()
	end,
	Play319811040 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 319811040
		arg_164_1.duration_ = 5

		SetActive(arg_164_1.tipsGo_, false)

		function arg_164_1.onSingleLineFinish_()
			arg_164_1.onSingleLineUpdate_ = nil
			arg_164_1.onSingleLineFinish_ = nil
			arg_164_1.state_ = "waiting"
		end

		function arg_164_1.playNext_(arg_166_0)
			if arg_166_0 == 1 then
				arg_164_0:Play319811041(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			local var_167_0 = arg_164_1.actors_["1084ui_story"]
			local var_167_1 = 0

			if var_167_1 < arg_164_1.time_ and arg_164_1.time_ <= var_167_1 + arg_167_0 and not isNil(var_167_0) and arg_164_1.var_.characterEffect1084ui_story == nil then
				arg_164_1.var_.characterEffect1084ui_story = var_167_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_167_2 = 0.200000002980232

			if var_167_1 <= arg_164_1.time_ and arg_164_1.time_ < var_167_1 + var_167_2 and not isNil(var_167_0) then
				local var_167_3 = (arg_164_1.time_ - var_167_1) / var_167_2

				if arg_164_1.var_.characterEffect1084ui_story and not isNil(var_167_0) then
					local var_167_4 = Mathf.Lerp(0, 0.5, var_167_3)

					arg_164_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_164_1.var_.characterEffect1084ui_story.fillRatio = var_167_4
				end
			end

			if arg_164_1.time_ >= var_167_1 + var_167_2 and arg_164_1.time_ < var_167_1 + var_167_2 + arg_167_0 and not isNil(var_167_0) and arg_164_1.var_.characterEffect1084ui_story then
				local var_167_5 = 0.5

				arg_164_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_164_1.var_.characterEffect1084ui_story.fillRatio = var_167_5
			end

			local var_167_6 = 0
			local var_167_7 = 1.05

			if var_167_6 < arg_164_1.time_ and arg_164_1.time_ <= var_167_6 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0
				arg_164_1.dialogCg_.alpha = 1

				arg_164_1.dialog_:SetActive(true)
				SetActive(arg_164_1.leftNameGo_, false)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_164_1.iconTrs_.gameObject, false)
				arg_164_1.callingController_:SetSelectedState("normal")

				local var_167_8 = arg_164_1:GetWordFromCfg(319811040)
				local var_167_9 = arg_164_1:FormatText(var_167_8.content)

				arg_164_1.text_.text = var_167_9

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_10 = 42
				local var_167_11 = utf8.len(var_167_9)
				local var_167_12 = var_167_10 <= 0 and var_167_7 or var_167_7 * (var_167_11 / var_167_10)

				if var_167_12 > 0 and var_167_7 < var_167_12 then
					arg_164_1.talkMaxDuration = var_167_12

					if var_167_12 + var_167_6 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_12 + var_167_6
					end
				end

				arg_164_1.text_.text = var_167_9
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)
				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_13 = math.max(var_167_7, arg_164_1.talkMaxDuration)

			if var_167_6 <= arg_164_1.time_ and arg_164_1.time_ < var_167_6 + var_167_13 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - var_167_6) / var_167_13

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= var_167_6 + var_167_13 and arg_164_1.time_ < var_167_6 + var_167_13 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {}

		arg_164_1:InitPlayNodeList()
	end,
	Play319811041 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 319811041
		arg_168_1.duration_ = 10.33

		local var_168_0 = {
			zh = 5.5,
			ja = 10.333
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
				arg_168_0:Play319811042(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			local var_171_0 = arg_168_1.actors_["10058ui_story"].transform
			local var_171_1 = 0

			if var_171_1 < arg_168_1.time_ and arg_168_1.time_ <= var_171_1 + arg_171_0 then
				arg_168_1.var_.moveOldPos10058ui_story = var_171_0.localPosition
			end

			local var_171_2 = 0.001

			if var_171_1 <= arg_168_1.time_ and arg_168_1.time_ < var_171_1 + var_171_2 then
				local var_171_3 = (arg_168_1.time_ - var_171_1) / var_171_2
				local var_171_4 = Vector3.New(0.7, -0.98, -6.1)

				var_171_0.localPosition = Vector3.Lerp(arg_168_1.var_.moveOldPos10058ui_story, var_171_4, var_171_3)

				local var_171_5 = manager.ui.mainCamera.transform.position - var_171_0.position

				var_171_0.forward = Vector3.New(var_171_5.x, var_171_5.y, var_171_5.z)

				local var_171_6 = var_171_0.localEulerAngles

				var_171_6.z = 0
				var_171_6.x = 0
				var_171_0.localEulerAngles = var_171_6
			end

			if arg_168_1.time_ >= var_171_1 + var_171_2 and arg_168_1.time_ < var_171_1 + var_171_2 + arg_171_0 then
				var_171_0.localPosition = Vector3.New(0.7, -0.98, -6.1)

				local var_171_7 = manager.ui.mainCamera.transform.position - var_171_0.position

				var_171_0.forward = Vector3.New(var_171_7.x, var_171_7.y, var_171_7.z)

				local var_171_8 = var_171_0.localEulerAngles

				var_171_8.z = 0
				var_171_8.x = 0
				var_171_0.localEulerAngles = var_171_8
			end

			local var_171_9 = arg_168_1.actors_["10058ui_story"]
			local var_171_10 = 0

			if var_171_10 < arg_168_1.time_ and arg_168_1.time_ <= var_171_10 + arg_171_0 and not isNil(var_171_9) and arg_168_1.var_.characterEffect10058ui_story == nil then
				arg_168_1.var_.characterEffect10058ui_story = var_171_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_171_11 = 0.200000002980232

			if var_171_10 <= arg_168_1.time_ and arg_168_1.time_ < var_171_10 + var_171_11 and not isNil(var_171_9) then
				local var_171_12 = (arg_168_1.time_ - var_171_10) / var_171_11

				if arg_168_1.var_.characterEffect10058ui_story and not isNil(var_171_9) then
					arg_168_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_168_1.time_ >= var_171_10 + var_171_11 and arg_168_1.time_ < var_171_10 + var_171_11 + arg_171_0 and not isNil(var_171_9) and arg_168_1.var_.characterEffect10058ui_story then
				arg_168_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_171_13 = 0

			if var_171_13 < arg_168_1.time_ and arg_168_1.time_ <= var_171_13 + arg_171_0 then
				arg_168_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_171_14 = 0

			if var_171_14 < arg_168_1.time_ and arg_168_1.time_ <= var_171_14 + arg_171_0 then
				arg_168_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_171_15 = arg_168_1.actors_["1084ui_story"].transform
			local var_171_16 = 0

			if var_171_16 < arg_168_1.time_ and arg_168_1.time_ <= var_171_16 + arg_171_0 then
				arg_168_1.var_.moveOldPos1084ui_story = var_171_15.localPosition
			end

			local var_171_17 = 0.001

			if var_171_16 <= arg_168_1.time_ and arg_168_1.time_ < var_171_16 + var_171_17 then
				local var_171_18 = (arg_168_1.time_ - var_171_16) / var_171_17
				local var_171_19 = Vector3.New(-0.7, -0.97, -6)

				var_171_15.localPosition = Vector3.Lerp(arg_168_1.var_.moveOldPos1084ui_story, var_171_19, var_171_18)

				local var_171_20 = manager.ui.mainCamera.transform.position - var_171_15.position

				var_171_15.forward = Vector3.New(var_171_20.x, var_171_20.y, var_171_20.z)

				local var_171_21 = var_171_15.localEulerAngles

				var_171_21.z = 0
				var_171_21.x = 0
				var_171_15.localEulerAngles = var_171_21
			end

			if arg_168_1.time_ >= var_171_16 + var_171_17 and arg_168_1.time_ < var_171_16 + var_171_17 + arg_171_0 then
				var_171_15.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_171_22 = manager.ui.mainCamera.transform.position - var_171_15.position

				var_171_15.forward = Vector3.New(var_171_22.x, var_171_22.y, var_171_22.z)

				local var_171_23 = var_171_15.localEulerAngles

				var_171_23.z = 0
				var_171_23.x = 0
				var_171_15.localEulerAngles = var_171_23
			end

			local var_171_24 = 0
			local var_171_25 = 0.6

			if var_171_24 < arg_168_1.time_ and arg_168_1.time_ <= var_171_24 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0
				arg_168_1.dialogCg_.alpha = 1

				arg_168_1.dialog_:SetActive(true)
				SetActive(arg_168_1.leftNameGo_, true)

				local var_171_26 = arg_168_1:FormatText(StoryNameCfg[471].name)

				arg_168_1.leftNameTxt_.text = var_171_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_168_1.leftNameTxt_.transform)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1.leftNameTxt_.text)
				SetActive(arg_168_1.iconTrs_.gameObject, false)
				arg_168_1.callingController_:SetSelectedState("normal")

				local var_171_27 = arg_168_1:GetWordFromCfg(319811041)
				local var_171_28 = arg_168_1:FormatText(var_171_27.content)

				arg_168_1.text_.text = var_171_28

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_29 = 24
				local var_171_30 = utf8.len(var_171_28)
				local var_171_31 = var_171_29 <= 0 and var_171_25 or var_171_25 * (var_171_30 / var_171_29)

				if var_171_31 > 0 and var_171_25 < var_171_31 then
					arg_168_1.talkMaxDuration = var_171_31

					if var_171_31 + var_171_24 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_31 + var_171_24
					end
				end

				arg_168_1.text_.text = var_171_28
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319811", "319811041", "story_v_out_319811.awb") ~= 0 then
					local var_171_32 = manager.audio:GetVoiceLength("story_v_out_319811", "319811041", "story_v_out_319811.awb") / 1000

					if var_171_32 + var_171_24 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_32 + var_171_24
					end

					if var_171_27.prefab_name ~= "" and arg_168_1.actors_[var_171_27.prefab_name] ~= nil then
						local var_171_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_168_1.actors_[var_171_27.prefab_name].transform, "story_v_out_319811", "319811041", "story_v_out_319811.awb")

						arg_168_1:RecordAudio("319811041", var_171_33)
						arg_168_1:RecordAudio("319811041", var_171_33)
					else
						arg_168_1:AudioAction("play", "voice", "story_v_out_319811", "319811041", "story_v_out_319811.awb")
					end

					arg_168_1:RecordHistoryTalkVoice("story_v_out_319811", "319811041", "story_v_out_319811.awb")
				end

				arg_168_1:RecordContent(arg_168_1.text_.text)
			end

			local var_171_34 = math.max(var_171_25, arg_168_1.talkMaxDuration)

			if var_171_24 <= arg_168_1.time_ and arg_168_1.time_ < var_171_24 + var_171_34 then
				arg_168_1.typewritter.percent = (arg_168_1.time_ - var_171_24) / var_171_34

				arg_168_1.typewritter:SetDirty()
			end

			if arg_168_1.time_ >= var_171_24 + var_171_34 and arg_168_1.time_ < var_171_24 + var_171_34 + arg_171_0 then
				arg_168_1.typewritter.percent = 1

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(true)
			end
		end

		arg_168_1.nodeConfigList_ = {
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
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_168_1:InitPlayNodeList()
	end,
	Play319811042 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 319811042
		arg_172_1.duration_ = 2.33

		local var_172_0 = {
			zh = 2.333,
			ja = 1.999999999999
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
				arg_172_0:Play319811043(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			local var_175_0 = arg_172_1.actors_["10058ui_story"]
			local var_175_1 = 0

			if var_175_1 < arg_172_1.time_ and arg_172_1.time_ <= var_175_1 + arg_175_0 and not isNil(var_175_0) and arg_172_1.var_.characterEffect10058ui_story == nil then
				arg_172_1.var_.characterEffect10058ui_story = var_175_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_175_2 = 0.200000002980232

			if var_175_1 <= arg_172_1.time_ and arg_172_1.time_ < var_175_1 + var_175_2 and not isNil(var_175_0) then
				local var_175_3 = (arg_172_1.time_ - var_175_1) / var_175_2

				if arg_172_1.var_.characterEffect10058ui_story and not isNil(var_175_0) then
					local var_175_4 = Mathf.Lerp(0, 0.5, var_175_3)

					arg_172_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_172_1.var_.characterEffect10058ui_story.fillRatio = var_175_4
				end
			end

			if arg_172_1.time_ >= var_175_1 + var_175_2 and arg_172_1.time_ < var_175_1 + var_175_2 + arg_175_0 and not isNil(var_175_0) and arg_172_1.var_.characterEffect10058ui_story then
				local var_175_5 = 0.5

				arg_172_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_172_1.var_.characterEffect10058ui_story.fillRatio = var_175_5
			end

			local var_175_6 = arg_172_1.actors_["1084ui_story"]
			local var_175_7 = 0

			if var_175_7 < arg_172_1.time_ and arg_172_1.time_ <= var_175_7 + arg_175_0 and not isNil(var_175_6) and arg_172_1.var_.characterEffect1084ui_story == nil then
				arg_172_1.var_.characterEffect1084ui_story = var_175_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_175_8 = 0.200000002980232

			if var_175_7 <= arg_172_1.time_ and arg_172_1.time_ < var_175_7 + var_175_8 and not isNil(var_175_6) then
				local var_175_9 = (arg_172_1.time_ - var_175_7) / var_175_8

				if arg_172_1.var_.characterEffect1084ui_story and not isNil(var_175_6) then
					arg_172_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_172_1.time_ >= var_175_7 + var_175_8 and arg_172_1.time_ < var_175_7 + var_175_8 + arg_175_0 and not isNil(var_175_6) and arg_172_1.var_.characterEffect1084ui_story then
				arg_172_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_175_10 = 0

			if var_175_10 < arg_172_1.time_ and arg_172_1.time_ <= var_175_10 + arg_175_0 then
				arg_172_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_175_11 = 0
			local var_175_12 = 0.225

			if var_175_11 < arg_172_1.time_ and arg_172_1.time_ <= var_175_11 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, true)

				local var_175_13 = arg_172_1:FormatText(StoryNameCfg[6].name)

				arg_172_1.leftNameTxt_.text = var_175_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_172_1.leftNameTxt_.transform)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1.leftNameTxt_.text)
				SetActive(arg_172_1.iconTrs_.gameObject, false)
				arg_172_1.callingController_:SetSelectedState("normal")

				local var_175_14 = arg_172_1:GetWordFromCfg(319811042)
				local var_175_15 = arg_172_1:FormatText(var_175_14.content)

				arg_172_1.text_.text = var_175_15

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_16 = 9
				local var_175_17 = utf8.len(var_175_15)
				local var_175_18 = var_175_16 <= 0 and var_175_12 or var_175_12 * (var_175_17 / var_175_16)

				if var_175_18 > 0 and var_175_12 < var_175_18 then
					arg_172_1.talkMaxDuration = var_175_18

					if var_175_18 + var_175_11 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_18 + var_175_11
					end
				end

				arg_172_1.text_.text = var_175_15
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319811", "319811042", "story_v_out_319811.awb") ~= 0 then
					local var_175_19 = manager.audio:GetVoiceLength("story_v_out_319811", "319811042", "story_v_out_319811.awb") / 1000

					if var_175_19 + var_175_11 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_19 + var_175_11
					end

					if var_175_14.prefab_name ~= "" and arg_172_1.actors_[var_175_14.prefab_name] ~= nil then
						local var_175_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_172_1.actors_[var_175_14.prefab_name].transform, "story_v_out_319811", "319811042", "story_v_out_319811.awb")

						arg_172_1:RecordAudio("319811042", var_175_20)
						arg_172_1:RecordAudio("319811042", var_175_20)
					else
						arg_172_1:AudioAction("play", "voice", "story_v_out_319811", "319811042", "story_v_out_319811.awb")
					end

					arg_172_1:RecordHistoryTalkVoice("story_v_out_319811", "319811042", "story_v_out_319811.awb")
				end

				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_21 = math.max(var_175_12, arg_172_1.talkMaxDuration)

			if var_175_11 <= arg_172_1.time_ and arg_172_1.time_ < var_175_11 + var_175_21 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - var_175_11) / var_175_21

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= var_175_11 + var_175_21 and arg_172_1.time_ < var_175_11 + var_175_21 + arg_175_0 then
				arg_172_1.typewritter.percent = 1

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(true)
			end
		end

		arg_172_1.nodeConfigList_ = {}

		arg_172_1:InitPlayNodeList()
	end,
	Play319811043 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 319811043
		arg_176_1.duration_ = 6.8

		local var_176_0 = {
			zh = 6.466,
			ja = 6.8
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
				arg_176_0:Play319811044(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			local var_179_0 = arg_176_1.actors_["10058ui_story"]
			local var_179_1 = 0

			if var_179_1 < arg_176_1.time_ and arg_176_1.time_ <= var_179_1 + arg_179_0 and not isNil(var_179_0) and arg_176_1.var_.characterEffect10058ui_story == nil then
				arg_176_1.var_.characterEffect10058ui_story = var_179_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_179_2 = 0.200000002980232

			if var_179_1 <= arg_176_1.time_ and arg_176_1.time_ < var_179_1 + var_179_2 and not isNil(var_179_0) then
				local var_179_3 = (arg_176_1.time_ - var_179_1) / var_179_2

				if arg_176_1.var_.characterEffect10058ui_story and not isNil(var_179_0) then
					arg_176_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_176_1.time_ >= var_179_1 + var_179_2 and arg_176_1.time_ < var_179_1 + var_179_2 + arg_179_0 and not isNil(var_179_0) and arg_176_1.var_.characterEffect10058ui_story then
				arg_176_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_179_4 = 0

			if var_179_4 < arg_176_1.time_ and arg_176_1.time_ <= var_179_4 + arg_179_0 then
				arg_176_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action7_1")
			end

			local var_179_5 = 0

			if var_179_5 < arg_176_1.time_ and arg_176_1.time_ <= var_179_5 + arg_179_0 then
				arg_176_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_179_6 = arg_176_1.actors_["1084ui_story"].transform
			local var_179_7 = 0

			if var_179_7 < arg_176_1.time_ and arg_176_1.time_ <= var_179_7 + arg_179_0 then
				arg_176_1.var_.moveOldPos1084ui_story = var_179_6.localPosition
			end

			local var_179_8 = 0.001

			if var_179_7 <= arg_176_1.time_ and arg_176_1.time_ < var_179_7 + var_179_8 then
				local var_179_9 = (arg_176_1.time_ - var_179_7) / var_179_8
				local var_179_10 = Vector3.New(-0.7, -0.97, -6)

				var_179_6.localPosition = Vector3.Lerp(arg_176_1.var_.moveOldPos1084ui_story, var_179_10, var_179_9)

				local var_179_11 = manager.ui.mainCamera.transform.position - var_179_6.position

				var_179_6.forward = Vector3.New(var_179_11.x, var_179_11.y, var_179_11.z)

				local var_179_12 = var_179_6.localEulerAngles

				var_179_12.z = 0
				var_179_12.x = 0
				var_179_6.localEulerAngles = var_179_12
			end

			if arg_176_1.time_ >= var_179_7 + var_179_8 and arg_176_1.time_ < var_179_7 + var_179_8 + arg_179_0 then
				var_179_6.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_179_13 = manager.ui.mainCamera.transform.position - var_179_6.position

				var_179_6.forward = Vector3.New(var_179_13.x, var_179_13.y, var_179_13.z)

				local var_179_14 = var_179_6.localEulerAngles

				var_179_14.z = 0
				var_179_14.x = 0
				var_179_6.localEulerAngles = var_179_14
			end

			local var_179_15 = arg_176_1.actors_["1084ui_story"]
			local var_179_16 = 0

			if var_179_16 < arg_176_1.time_ and arg_176_1.time_ <= var_179_16 + arg_179_0 and not isNil(var_179_15) and arg_176_1.var_.characterEffect1084ui_story == nil then
				arg_176_1.var_.characterEffect1084ui_story = var_179_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_179_17 = 0.200000002980232

			if var_179_16 <= arg_176_1.time_ and arg_176_1.time_ < var_179_16 + var_179_17 and not isNil(var_179_15) then
				local var_179_18 = (arg_176_1.time_ - var_179_16) / var_179_17

				if arg_176_1.var_.characterEffect1084ui_story and not isNil(var_179_15) then
					local var_179_19 = Mathf.Lerp(0, 0.5, var_179_18)

					arg_176_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_176_1.var_.characterEffect1084ui_story.fillRatio = var_179_19
				end
			end

			if arg_176_1.time_ >= var_179_16 + var_179_17 and arg_176_1.time_ < var_179_16 + var_179_17 + arg_179_0 and not isNil(var_179_15) and arg_176_1.var_.characterEffect1084ui_story then
				local var_179_20 = 0.5

				arg_176_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_176_1.var_.characterEffect1084ui_story.fillRatio = var_179_20
			end

			local var_179_21 = 0
			local var_179_22 = 0.8

			if var_179_21 < arg_176_1.time_ and arg_176_1.time_ <= var_179_21 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0
				arg_176_1.dialogCg_.alpha = 1

				arg_176_1.dialog_:SetActive(true)
				SetActive(arg_176_1.leftNameGo_, true)

				local var_179_23 = arg_176_1:FormatText(StoryNameCfg[471].name)

				arg_176_1.leftNameTxt_.text = var_179_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_176_1.leftNameTxt_.transform)

				arg_176_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_176_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_176_1:RecordName(arg_176_1.leftNameTxt_.text)
				SetActive(arg_176_1.iconTrs_.gameObject, false)
				arg_176_1.callingController_:SetSelectedState("normal")

				local var_179_24 = arg_176_1:GetWordFromCfg(319811043)
				local var_179_25 = arg_176_1:FormatText(var_179_24.content)

				arg_176_1.text_.text = var_179_25

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.text_)

				local var_179_26 = 32
				local var_179_27 = utf8.len(var_179_25)
				local var_179_28 = var_179_26 <= 0 and var_179_22 or var_179_22 * (var_179_27 / var_179_26)

				if var_179_28 > 0 and var_179_22 < var_179_28 then
					arg_176_1.talkMaxDuration = var_179_28

					if var_179_28 + var_179_21 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_28 + var_179_21
					end
				end

				arg_176_1.text_.text = var_179_25
				arg_176_1.typewritter.percent = 0

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319811", "319811043", "story_v_out_319811.awb") ~= 0 then
					local var_179_29 = manager.audio:GetVoiceLength("story_v_out_319811", "319811043", "story_v_out_319811.awb") / 1000

					if var_179_29 + var_179_21 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_29 + var_179_21
					end

					if var_179_24.prefab_name ~= "" and arg_176_1.actors_[var_179_24.prefab_name] ~= nil then
						local var_179_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_176_1.actors_[var_179_24.prefab_name].transform, "story_v_out_319811", "319811043", "story_v_out_319811.awb")

						arg_176_1:RecordAudio("319811043", var_179_30)
						arg_176_1:RecordAudio("319811043", var_179_30)
					else
						arg_176_1:AudioAction("play", "voice", "story_v_out_319811", "319811043", "story_v_out_319811.awb")
					end

					arg_176_1:RecordHistoryTalkVoice("story_v_out_319811", "319811043", "story_v_out_319811.awb")
				end

				arg_176_1:RecordContent(arg_176_1.text_.text)
			end

			local var_179_31 = math.max(var_179_22, arg_176_1.talkMaxDuration)

			if var_179_21 <= arg_176_1.time_ and arg_176_1.time_ < var_179_21 + var_179_31 then
				arg_176_1.typewritter.percent = (arg_176_1.time_ - var_179_21) / var_179_31

				arg_176_1.typewritter:SetDirty()
			end

			if arg_176_1.time_ >= var_179_21 + var_179_31 and arg_176_1.time_ < var_179_21 + var_179_31 + arg_179_0 then
				arg_176_1.typewritter.percent = 1

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(true)
			end
		end

		arg_176_1.nodeConfigList_ = {
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

		arg_176_1:InitPlayNodeList()
	end,
	Play319811044 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 319811044
		arg_180_1.duration_ = 5

		SetActive(arg_180_1.tipsGo_, false)

		function arg_180_1.onSingleLineFinish_()
			arg_180_1.onSingleLineUpdate_ = nil
			arg_180_1.onSingleLineFinish_ = nil
			arg_180_1.state_ = "waiting"
		end

		function arg_180_1.playNext_(arg_182_0)
			if arg_182_0 == 1 then
				arg_180_0:Play319811045(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			local var_183_0 = arg_180_1.actors_["10058ui_story"]
			local var_183_1 = 0

			if var_183_1 < arg_180_1.time_ and arg_180_1.time_ <= var_183_1 + arg_183_0 and not isNil(var_183_0) and arg_180_1.var_.characterEffect10058ui_story == nil then
				arg_180_1.var_.characterEffect10058ui_story = var_183_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_183_2 = 0.200000002980232

			if var_183_1 <= arg_180_1.time_ and arg_180_1.time_ < var_183_1 + var_183_2 and not isNil(var_183_0) then
				local var_183_3 = (arg_180_1.time_ - var_183_1) / var_183_2

				if arg_180_1.var_.characterEffect10058ui_story and not isNil(var_183_0) then
					local var_183_4 = Mathf.Lerp(0, 0.5, var_183_3)

					arg_180_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_180_1.var_.characterEffect10058ui_story.fillRatio = var_183_4
				end
			end

			if arg_180_1.time_ >= var_183_1 + var_183_2 and arg_180_1.time_ < var_183_1 + var_183_2 + arg_183_0 and not isNil(var_183_0) and arg_180_1.var_.characterEffect10058ui_story then
				local var_183_5 = 0.5

				arg_180_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_180_1.var_.characterEffect10058ui_story.fillRatio = var_183_5
			end

			local var_183_6 = 0
			local var_183_7 = 0.35

			if var_183_6 < arg_180_1.time_ and arg_180_1.time_ <= var_183_6 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0
				arg_180_1.dialogCg_.alpha = 1

				arg_180_1.dialog_:SetActive(true)
				SetActive(arg_180_1.leftNameGo_, true)

				local var_183_8 = arg_180_1:FormatText(StoryNameCfg[698].name)

				arg_180_1.leftNameTxt_.text = var_183_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_180_1.leftNameTxt_.transform)

				arg_180_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_180_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_180_1:RecordName(arg_180_1.leftNameTxt_.text)
				SetActive(arg_180_1.iconTrs_.gameObject, true)
				arg_180_1.iconController_:SetSelectedState("hero")

				arg_180_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_180_1.callingController_:SetSelectedState("normal")

				arg_180_1.keyicon_.color = Color.New(1, 1, 1)
				arg_180_1.icon_.color = Color.New(1, 1, 1)

				local var_183_9 = arg_180_1:GetWordFromCfg(319811044)
				local var_183_10 = arg_180_1:FormatText(var_183_9.content)

				arg_180_1.text_.text = var_183_10

				LuaForUtil.ClearLinePrefixSymbol(arg_180_1.text_)

				local var_183_11 = 14
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
				arg_180_1:RecordContent(arg_180_1.text_.text)
			end

			local var_183_14 = math.max(var_183_7, arg_180_1.talkMaxDuration)

			if var_183_6 <= arg_180_1.time_ and arg_180_1.time_ < var_183_6 + var_183_14 then
				arg_180_1.typewritter.percent = (arg_180_1.time_ - var_183_6) / var_183_14

				arg_180_1.typewritter:SetDirty()
			end

			if arg_180_1.time_ >= var_183_6 + var_183_14 and arg_180_1.time_ < var_183_6 + var_183_14 + arg_183_0 then
				arg_180_1.typewritter.percent = 1

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(true)
			end
		end

		arg_180_1.nodeConfigList_ = {}

		arg_180_1:InitPlayNodeList()
	end,
	Play319811045 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 319811045
		arg_184_1.duration_ = 5.27

		local var_184_0 = {
			zh = 3.7,
			ja = 5.266
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
				arg_184_0:Play319811046(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			local var_187_0 = arg_184_1.actors_["10058ui_story"].transform
			local var_187_1 = 0

			if var_187_1 < arg_184_1.time_ and arg_184_1.time_ <= var_187_1 + arg_187_0 then
				arg_184_1.var_.moveOldPos10058ui_story = var_187_0.localPosition
			end

			local var_187_2 = 0.001

			if var_187_1 <= arg_184_1.time_ and arg_184_1.time_ < var_187_1 + var_187_2 then
				local var_187_3 = (arg_184_1.time_ - var_187_1) / var_187_2
				local var_187_4 = Vector3.New(0.7, -0.98, -6.1)

				var_187_0.localPosition = Vector3.Lerp(arg_184_1.var_.moveOldPos10058ui_story, var_187_4, var_187_3)

				local var_187_5 = manager.ui.mainCamera.transform.position - var_187_0.position

				var_187_0.forward = Vector3.New(var_187_5.x, var_187_5.y, var_187_5.z)

				local var_187_6 = var_187_0.localEulerAngles

				var_187_6.z = 0
				var_187_6.x = 0
				var_187_0.localEulerAngles = var_187_6
			end

			if arg_184_1.time_ >= var_187_1 + var_187_2 and arg_184_1.time_ < var_187_1 + var_187_2 + arg_187_0 then
				var_187_0.localPosition = Vector3.New(0.7, -0.98, -6.1)

				local var_187_7 = manager.ui.mainCamera.transform.position - var_187_0.position

				var_187_0.forward = Vector3.New(var_187_7.x, var_187_7.y, var_187_7.z)

				local var_187_8 = var_187_0.localEulerAngles

				var_187_8.z = 0
				var_187_8.x = 0
				var_187_0.localEulerAngles = var_187_8
			end

			local var_187_9 = arg_184_1.actors_["10058ui_story"]
			local var_187_10 = 0

			if var_187_10 < arg_184_1.time_ and arg_184_1.time_ <= var_187_10 + arg_187_0 and not isNil(var_187_9) and arg_184_1.var_.characterEffect10058ui_story == nil then
				arg_184_1.var_.characterEffect10058ui_story = var_187_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_187_11 = 0.200000002980232

			if var_187_10 <= arg_184_1.time_ and arg_184_1.time_ < var_187_10 + var_187_11 and not isNil(var_187_9) then
				local var_187_12 = (arg_184_1.time_ - var_187_10) / var_187_11

				if arg_184_1.var_.characterEffect10058ui_story and not isNil(var_187_9) then
					arg_184_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_184_1.time_ >= var_187_10 + var_187_11 and arg_184_1.time_ < var_187_10 + var_187_11 + arg_187_0 and not isNil(var_187_9) and arg_184_1.var_.characterEffect10058ui_story then
				arg_184_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_187_13 = 0

			if var_187_13 < arg_184_1.time_ and arg_184_1.time_ <= var_187_13 + arg_187_0 then
				arg_184_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action7_2")
			end

			local var_187_14 = 0

			if var_187_14 < arg_184_1.time_ and arg_184_1.time_ <= var_187_14 + arg_187_0 then
				arg_184_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_187_15 = 0
			local var_187_16 = 0.325

			if var_187_15 < arg_184_1.time_ and arg_184_1.time_ <= var_187_15 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0
				arg_184_1.dialogCg_.alpha = 1

				arg_184_1.dialog_:SetActive(true)
				SetActive(arg_184_1.leftNameGo_, true)

				local var_187_17 = arg_184_1:FormatText(StoryNameCfg[471].name)

				arg_184_1.leftNameTxt_.text = var_187_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_184_1.leftNameTxt_.transform)

				arg_184_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_184_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_184_1:RecordName(arg_184_1.leftNameTxt_.text)
				SetActive(arg_184_1.iconTrs_.gameObject, false)
				arg_184_1.callingController_:SetSelectedState("normal")

				local var_187_18 = arg_184_1:GetWordFromCfg(319811045)
				local var_187_19 = arg_184_1:FormatText(var_187_18.content)

				arg_184_1.text_.text = var_187_19

				LuaForUtil.ClearLinePrefixSymbol(arg_184_1.text_)

				local var_187_20 = 13
				local var_187_21 = utf8.len(var_187_19)
				local var_187_22 = var_187_20 <= 0 and var_187_16 or var_187_16 * (var_187_21 / var_187_20)

				if var_187_22 > 0 and var_187_16 < var_187_22 then
					arg_184_1.talkMaxDuration = var_187_22

					if var_187_22 + var_187_15 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_22 + var_187_15
					end
				end

				arg_184_1.text_.text = var_187_19
				arg_184_1.typewritter.percent = 0

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319811", "319811045", "story_v_out_319811.awb") ~= 0 then
					local var_187_23 = manager.audio:GetVoiceLength("story_v_out_319811", "319811045", "story_v_out_319811.awb") / 1000

					if var_187_23 + var_187_15 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_23 + var_187_15
					end

					if var_187_18.prefab_name ~= "" and arg_184_1.actors_[var_187_18.prefab_name] ~= nil then
						local var_187_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_184_1.actors_[var_187_18.prefab_name].transform, "story_v_out_319811", "319811045", "story_v_out_319811.awb")

						arg_184_1:RecordAudio("319811045", var_187_24)
						arg_184_1:RecordAudio("319811045", var_187_24)
					else
						arg_184_1:AudioAction("play", "voice", "story_v_out_319811", "319811045", "story_v_out_319811.awb")
					end

					arg_184_1:RecordHistoryTalkVoice("story_v_out_319811", "319811045", "story_v_out_319811.awb")
				end

				arg_184_1:RecordContent(arg_184_1.text_.text)
			end

			local var_187_25 = math.max(var_187_16, arg_184_1.talkMaxDuration)

			if var_187_15 <= arg_184_1.time_ and arg_184_1.time_ < var_187_15 + var_187_25 then
				arg_184_1.typewritter.percent = (arg_184_1.time_ - var_187_15) / var_187_25

				arg_184_1.typewritter:SetDirty()
			end

			if arg_184_1.time_ >= var_187_15 + var_187_25 and arg_184_1.time_ < var_187_15 + var_187_25 + arg_187_0 then
				arg_184_1.typewritter.percent = 1

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(true)
			end
		end

		arg_184_1.nodeConfigList_ = {
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

		arg_184_1:InitPlayNodeList()
	end,
	Play319811046 = function(arg_188_0, arg_188_1)
		arg_188_1.time_ = 0
		arg_188_1.frameCnt_ = 0
		arg_188_1.state_ = "playing"
		arg_188_1.curTalkId_ = 319811046
		arg_188_1.duration_ = 5

		SetActive(arg_188_1.tipsGo_, false)

		function arg_188_1.onSingleLineFinish_()
			arg_188_1.onSingleLineUpdate_ = nil
			arg_188_1.onSingleLineFinish_ = nil
			arg_188_1.state_ = "waiting"
		end

		function arg_188_1.playNext_(arg_190_0)
			if arg_190_0 == 1 then
				arg_188_0:Play319811047(arg_188_1)
			end
		end

		function arg_188_1.onSingleLineUpdate_(arg_191_0)
			local var_191_0 = arg_188_1.actors_["10058ui_story"]
			local var_191_1 = 0

			if var_191_1 < arg_188_1.time_ and arg_188_1.time_ <= var_191_1 + arg_191_0 and not isNil(var_191_0) and arg_188_1.var_.characterEffect10058ui_story == nil then
				arg_188_1.var_.characterEffect10058ui_story = var_191_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_191_2 = 0.200000002980232

			if var_191_1 <= arg_188_1.time_ and arg_188_1.time_ < var_191_1 + var_191_2 and not isNil(var_191_0) then
				local var_191_3 = (arg_188_1.time_ - var_191_1) / var_191_2

				if arg_188_1.var_.characterEffect10058ui_story and not isNil(var_191_0) then
					local var_191_4 = Mathf.Lerp(0, 0.5, var_191_3)

					arg_188_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_188_1.var_.characterEffect10058ui_story.fillRatio = var_191_4
				end
			end

			if arg_188_1.time_ >= var_191_1 + var_191_2 and arg_188_1.time_ < var_191_1 + var_191_2 + arg_191_0 and not isNil(var_191_0) and arg_188_1.var_.characterEffect10058ui_story then
				local var_191_5 = 0.5

				arg_188_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_188_1.var_.characterEffect10058ui_story.fillRatio = var_191_5
			end

			local var_191_6 = 0
			local var_191_7 = 0.25

			if var_191_6 < arg_188_1.time_ and arg_188_1.time_ <= var_191_6 + arg_191_0 then
				arg_188_1.talkMaxDuration = 0
				arg_188_1.dialogCg_.alpha = 1

				arg_188_1.dialog_:SetActive(true)
				SetActive(arg_188_1.leftNameGo_, true)

				local var_191_8 = arg_188_1:FormatText(StoryNameCfg[698].name)

				arg_188_1.leftNameTxt_.text = var_191_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_188_1.leftNameTxt_.transform)

				arg_188_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_188_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_188_1:RecordName(arg_188_1.leftNameTxt_.text)
				SetActive(arg_188_1.iconTrs_.gameObject, true)
				arg_188_1.iconController_:SetSelectedState("hero")

				arg_188_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_188_1.callingController_:SetSelectedState("normal")

				arg_188_1.keyicon_.color = Color.New(1, 1, 1)
				arg_188_1.icon_.color = Color.New(1, 1, 1)

				local var_191_9 = arg_188_1:GetWordFromCfg(319811046)
				local var_191_10 = arg_188_1:FormatText(var_191_9.content)

				arg_188_1.text_.text = var_191_10

				LuaForUtil.ClearLinePrefixSymbol(arg_188_1.text_)

				local var_191_11 = 10
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
				arg_188_1:RecordContent(arg_188_1.text_.text)
			end

			local var_191_14 = math.max(var_191_7, arg_188_1.talkMaxDuration)

			if var_191_6 <= arg_188_1.time_ and arg_188_1.time_ < var_191_6 + var_191_14 then
				arg_188_1.typewritter.percent = (arg_188_1.time_ - var_191_6) / var_191_14

				arg_188_1.typewritter:SetDirty()
			end

			if arg_188_1.time_ >= var_191_6 + var_191_14 and arg_188_1.time_ < var_191_6 + var_191_14 + arg_191_0 then
				arg_188_1.typewritter.percent = 1

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(true)
			end
		end

		arg_188_1.nodeConfigList_ = {}

		arg_188_1:InitPlayNodeList()
	end,
	Play319811047 = function(arg_192_0, arg_192_1)
		arg_192_1.time_ = 0
		arg_192_1.frameCnt_ = 0
		arg_192_1.state_ = "playing"
		arg_192_1.curTalkId_ = 319811047
		arg_192_1.duration_ = 5.9

		SetActive(arg_192_1.tipsGo_, false)

		function arg_192_1.onSingleLineFinish_()
			arg_192_1.onSingleLineUpdate_ = nil
			arg_192_1.onSingleLineFinish_ = nil
			arg_192_1.state_ = "waiting"
		end

		function arg_192_1.playNext_(arg_194_0)
			if arg_194_0 == 1 then
				arg_192_0:Play319811048(arg_192_1)
			end
		end

		function arg_192_1.onSingleLineUpdate_(arg_195_0)
			local var_195_0 = arg_192_1.actors_["10058ui_story"].transform
			local var_195_1 = 0

			if var_195_1 < arg_192_1.time_ and arg_192_1.time_ <= var_195_1 + arg_195_0 then
				arg_192_1.var_.moveOldPos10058ui_story = var_195_0.localPosition
			end

			local var_195_2 = 0.001

			if var_195_1 <= arg_192_1.time_ and arg_192_1.time_ < var_195_1 + var_195_2 then
				local var_195_3 = (arg_192_1.time_ - var_195_1) / var_195_2
				local var_195_4 = Vector3.New(0, 100, 0)

				var_195_0.localPosition = Vector3.Lerp(arg_192_1.var_.moveOldPos10058ui_story, var_195_4, var_195_3)

				local var_195_5 = manager.ui.mainCamera.transform.position - var_195_0.position

				var_195_0.forward = Vector3.New(var_195_5.x, var_195_5.y, var_195_5.z)

				local var_195_6 = var_195_0.localEulerAngles

				var_195_6.z = 0
				var_195_6.x = 0
				var_195_0.localEulerAngles = var_195_6
			end

			if arg_192_1.time_ >= var_195_1 + var_195_2 and arg_192_1.time_ < var_195_1 + var_195_2 + arg_195_0 then
				var_195_0.localPosition = Vector3.New(0, 100, 0)

				local var_195_7 = manager.ui.mainCamera.transform.position - var_195_0.position

				var_195_0.forward = Vector3.New(var_195_7.x, var_195_7.y, var_195_7.z)

				local var_195_8 = var_195_0.localEulerAngles

				var_195_8.z = 0
				var_195_8.x = 0
				var_195_0.localEulerAngles = var_195_8
			end

			local var_195_9 = arg_192_1.actors_["1084ui_story"].transform
			local var_195_10 = 0

			if var_195_10 < arg_192_1.time_ and arg_192_1.time_ <= var_195_10 + arg_195_0 then
				arg_192_1.var_.moveOldPos1084ui_story = var_195_9.localPosition
			end

			local var_195_11 = 0.001

			if var_195_10 <= arg_192_1.time_ and arg_192_1.time_ < var_195_10 + var_195_11 then
				local var_195_12 = (arg_192_1.time_ - var_195_10) / var_195_11
				local var_195_13 = Vector3.New(0, 100, 0)

				var_195_9.localPosition = Vector3.Lerp(arg_192_1.var_.moveOldPos1084ui_story, var_195_13, var_195_12)

				local var_195_14 = manager.ui.mainCamera.transform.position - var_195_9.position

				var_195_9.forward = Vector3.New(var_195_14.x, var_195_14.y, var_195_14.z)

				local var_195_15 = var_195_9.localEulerAngles

				var_195_15.z = 0
				var_195_15.x = 0
				var_195_9.localEulerAngles = var_195_15
			end

			if arg_192_1.time_ >= var_195_10 + var_195_11 and arg_192_1.time_ < var_195_10 + var_195_11 + arg_195_0 then
				var_195_9.localPosition = Vector3.New(0, 100, 0)

				local var_195_16 = manager.ui.mainCamera.transform.position - var_195_9.position

				var_195_9.forward = Vector3.New(var_195_16.x, var_195_16.y, var_195_16.z)

				local var_195_17 = var_195_9.localEulerAngles

				var_195_17.z = 0
				var_195_17.x = 0
				var_195_9.localEulerAngles = var_195_17
			end

			local var_195_18 = 0

			if var_195_18 < arg_192_1.time_ and arg_192_1.time_ <= var_195_18 + arg_195_0 then
				arg_192_1.mask_.enabled = true
				arg_192_1.mask_.raycastTarget = false

				arg_192_1:SetGaussion(false)
			end

			local var_195_19 = 0.666666666666667

			if var_195_18 <= arg_192_1.time_ and arg_192_1.time_ < var_195_18 + var_195_19 then
				local var_195_20 = (arg_192_1.time_ - var_195_18) / var_195_19
				local var_195_21 = Color.New(1, 1, 1)

				var_195_21.a = Mathf.Lerp(1, 0, var_195_20)
				arg_192_1.mask_.color = var_195_21
			end

			if arg_192_1.time_ >= var_195_18 + var_195_19 and arg_192_1.time_ < var_195_18 + var_195_19 + arg_195_0 then
				local var_195_22 = Color.New(1, 1, 1)
				local var_195_23 = 0

				arg_192_1.mask_.enabled = false
				var_195_22.a = var_195_23
				arg_192_1.mask_.color = var_195_22
			end

			if arg_192_1.frameCnt_ <= 1 then
				arg_192_1.dialog_:SetActive(false)
			end

			local var_195_24 = 0.9
			local var_195_25 = 1.05

			if var_195_24 < arg_192_1.time_ and arg_192_1.time_ <= var_195_24 + arg_195_0 then
				arg_192_1.talkMaxDuration = 0

				arg_192_1.dialog_:SetActive(true)

				arg_192_1.dialogCg_.alpha = 0

				local var_195_26 = LeanTween.value(arg_192_1.dialog_, 0, 1, 0.3)

				var_195_26:setOnUpdate(LuaHelper.FloatAction(function(arg_196_0)
					arg_192_1.dialogCg_.alpha = arg_196_0
				end))
				var_195_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_192_1.dialog_)
					var_195_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_192_1.duration_ = arg_192_1.duration_ + 0.3

				SetActive(arg_192_1.leftNameGo_, false)

				arg_192_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_192_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_192_1:RecordName(arg_192_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_192_1.iconTrs_.gameObject, false)
				arg_192_1.callingController_:SetSelectedState("normal")

				local var_195_27 = arg_192_1:GetWordFromCfg(319811047)
				local var_195_28 = arg_192_1:FormatText(var_195_27.content)

				arg_192_1.text_.text = var_195_28

				LuaForUtil.ClearLinePrefixSymbol(arg_192_1.text_)

				local var_195_29 = 42
				local var_195_30 = utf8.len(var_195_28)
				local var_195_31 = var_195_29 <= 0 and var_195_25 or var_195_25 * (var_195_30 / var_195_29)

				if var_195_31 > 0 and var_195_25 < var_195_31 then
					arg_192_1.talkMaxDuration = var_195_31
					var_195_24 = var_195_24 + 0.3

					if var_195_31 + var_195_24 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_31 + var_195_24
					end
				end

				arg_192_1.text_.text = var_195_28
				arg_192_1.typewritter.percent = 0

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(false)
				arg_192_1:RecordContent(arg_192_1.text_.text)
			end

			local var_195_32 = var_195_24 + 0.3
			local var_195_33 = math.max(var_195_25, arg_192_1.talkMaxDuration)

			if var_195_32 <= arg_192_1.time_ and arg_192_1.time_ < var_195_32 + var_195_33 then
				arg_192_1.typewritter.percent = (arg_192_1.time_ - var_195_32) / var_195_33

				arg_192_1.typewritter:SetDirty()
			end

			if arg_192_1.time_ >= var_195_32 + var_195_33 and arg_192_1.time_ < var_195_32 + var_195_33 + arg_195_0 then
				arg_192_1.typewritter.percent = 1

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(true)
			end
		end

		arg_192_1.nodeConfigList_ = {
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
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_192_1:InitPlayNodeList()
	end,
	Play319811048 = function(arg_198_0, arg_198_1)
		arg_198_1.time_ = 0
		arg_198_1.frameCnt_ = 0
		arg_198_1.state_ = "playing"
		arg_198_1.curTalkId_ = 319811048
		arg_198_1.duration_ = 2.17

		SetActive(arg_198_1.tipsGo_, false)

		function arg_198_1.onSingleLineFinish_()
			arg_198_1.onSingleLineUpdate_ = nil
			arg_198_1.onSingleLineFinish_ = nil
			arg_198_1.state_ = "waiting"
		end

		function arg_198_1.playNext_(arg_200_0)
			if arg_200_0 == 1 then
				arg_198_0:Play319811049(arg_198_1)
			end
		end

		function arg_198_1.onSingleLineUpdate_(arg_201_0)
			local var_201_0 = 0

			if var_201_0 < arg_198_1.time_ and arg_198_1.time_ <= var_201_0 + arg_201_0 then
				local var_201_1 = arg_198_1.fswbg_.transform:Find("textbox/adapt/content") or arg_198_1.fswbg_.transform:Find("textbox/content")
				local var_201_2 = arg_198_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_201_3 = var_201_1:GetComponent("Text")
				local var_201_4 = var_201_1:GetComponent("RectTransform")

				var_201_3.alignment = UnityEngine.TextAnchor.LowerCenter
				var_201_4.offsetMin = Vector2.New(0, 0)
				var_201_4.offsetMax = Vector2.New(0, 0)
			end

			local var_201_5 = 0

			if var_201_5 < arg_198_1.time_ and arg_198_1.time_ <= var_201_5 + arg_201_0 then
				arg_198_1.fswbg_:SetActive(true)
				arg_198_1.dialog_:SetActive(false)

				arg_198_1.fswtw_.percent = 0

				local var_201_6 = arg_198_1:GetWordFromCfg(319811048)
				local var_201_7 = arg_198_1:FormatText(var_201_6.content)

				arg_198_1.fswt_.text = var_201_7

				LuaForUtil.ClearLinePrefixSymbol(arg_198_1.fswt_)

				arg_198_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_198_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_198_1.fswtw_:SetDirty()

				arg_198_1.typewritterCharCountI18N = 0

				SetActive(arg_198_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_198_1:ShowNextGo(false)
			end

			local var_201_8 = 0.733333333333333

			if var_201_8 < arg_198_1.time_ and arg_198_1.time_ <= var_201_8 + arg_201_0 then
				arg_198_1.var_.oldValueTypewriter = arg_198_1.fswtw_.percent

				SetActive(arg_198_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_198_1:ShowNextGo(false)
			end

			local var_201_9 = 4
			local var_201_10 = 0.266666666666667
			local var_201_11 = arg_198_1:GetWordFromCfg(319811048)
			local var_201_12 = arg_198_1:FormatText(var_201_11.content)
			local var_201_13, var_201_14 = arg_198_1:GetPercentByPara(var_201_12, 1)

			if var_201_8 < arg_198_1.time_ and arg_198_1.time_ <= var_201_8 + arg_201_0 then
				arg_198_1.talkMaxDuration = 0

				local var_201_15 = var_201_9 <= 0 and var_201_10 or var_201_10 * ((var_201_14 - arg_198_1.typewritterCharCountI18N) / var_201_9)

				if var_201_15 > 0 and var_201_10 < var_201_15 then
					arg_198_1.talkMaxDuration = var_201_15

					if var_201_15 + var_201_8 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_15 + var_201_8
					end
				end
			end

			local var_201_16 = 0.266666666666667
			local var_201_17 = math.max(var_201_16, arg_198_1.talkMaxDuration)

			if var_201_8 <= arg_198_1.time_ and arg_198_1.time_ < var_201_8 + var_201_17 then
				local var_201_18 = (arg_198_1.time_ - var_201_8) / var_201_17

				arg_198_1.fswtw_.percent = Mathf.Lerp(arg_198_1.var_.oldValueTypewriter, var_201_13, var_201_18)
				arg_198_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_198_1.fswtw_:SetDirty()
			end

			if arg_198_1.time_ >= var_201_8 + var_201_17 and arg_198_1.time_ < var_201_8 + var_201_17 + arg_201_0 then
				arg_198_1.fswtw_.percent = var_201_13

				arg_198_1.fswtw_:SetDirty()
				arg_198_1:ShowNextGo(true)

				arg_198_1.typewritterCharCountI18N = var_201_14
			end

			local var_201_19 = "STblack"

			if arg_198_1.bgs_[var_201_19] == nil then
				local var_201_20 = Object.Instantiate(arg_198_1.paintGo_)

				var_201_20:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_201_19)
				var_201_20.name = var_201_19
				var_201_20.transform.parent = arg_198_1.stage_.transform
				var_201_20.transform.localPosition = Vector3.New(0, 100, 0)
				arg_198_1.bgs_[var_201_19] = var_201_20
			end

			local var_201_21 = 0

			if var_201_21 < arg_198_1.time_ and arg_198_1.time_ <= var_201_21 + arg_201_0 then
				local var_201_22 = manager.ui.mainCamera.transform.localPosition
				local var_201_23 = Vector3.New(0, 0, 10) + Vector3.New(var_201_22.x, var_201_22.y, 0)
				local var_201_24 = arg_198_1.bgs_.STblack

				var_201_24.transform.localPosition = var_201_23
				var_201_24.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_201_25 = var_201_24:GetComponent("SpriteRenderer")

				if var_201_25 and var_201_25.sprite then
					local var_201_26 = (var_201_24.transform.localPosition - var_201_22).z
					local var_201_27 = manager.ui.mainCameraCom_
					local var_201_28 = 2 * var_201_26 * Mathf.Tan(var_201_27.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_201_29 = var_201_28 * var_201_27.aspect
					local var_201_30 = var_201_25.sprite.bounds.size.x
					local var_201_31 = var_201_25.sprite.bounds.size.y
					local var_201_32 = var_201_29 / var_201_30
					local var_201_33 = var_201_28 / var_201_31
					local var_201_34 = var_201_33 < var_201_32 and var_201_32 or var_201_33

					var_201_24.transform.localScale = Vector3.New(var_201_34, var_201_34, 0)
				end

				for iter_201_0, iter_201_1 in pairs(arg_198_1.bgs_) do
					if iter_201_0 ~= "STblack" then
						iter_201_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_201_35 = 0.733333333333333
			local var_201_36 = 1.433
			local var_201_37 = manager.audio:GetVoiceLength("story_v_out_319811", "319811048", "story_v_out_319811.awb") / 1000

			if var_201_37 > 0 and var_201_36 < var_201_37 and var_201_37 + var_201_35 > arg_198_1.duration_ then
				local var_201_38 = var_201_37

				arg_198_1.duration_ = var_201_37 + var_201_35
			end

			if var_201_35 < arg_198_1.time_ and arg_198_1.time_ <= var_201_35 + arg_201_0 then
				local var_201_39 = "play"
				local var_201_40 = "voice"

				arg_198_1:AudioAction(var_201_39, var_201_40, "story_v_out_319811", "319811048", "story_v_out_319811.awb")
			end

			local var_201_41 = 0

			if var_201_41 < arg_198_1.time_ and arg_198_1.time_ <= var_201_41 + arg_201_0 then
				arg_198_1.cswbg_:SetActive(true)

				local var_201_42 = arg_198_1.cswt_:GetComponent("RectTransform")

				arg_198_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_201_42.offsetMin = Vector2.New(410, 330)
				var_201_42.offsetMax = Vector2.New(-400, -180)

				local var_201_43 = arg_198_1:GetWordFromCfg(419056)
				local var_201_44 = arg_198_1:FormatText(var_201_43.content)

				arg_198_1.cswt_.text = var_201_44

				LuaForUtil.ClearLinePrefixSymbol(arg_198_1.cswt_)

				arg_198_1.cswt_.fontSize = 175
				arg_198_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_198_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_198_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end
		end

		arg_198_1.nodeConfigList_ = {}

		arg_198_1:InitPlayNodeList()
	end,
	Play319811049 = function(arg_202_0, arg_202_1)
		arg_202_1.time_ = 0
		arg_202_1.frameCnt_ = 0
		arg_202_1.state_ = "playing"
		arg_202_1.curTalkId_ = 319811049
		arg_202_1.duration_ = 4.1

		SetActive(arg_202_1.tipsGo_, false)

		function arg_202_1.onSingleLineFinish_()
			arg_202_1.onSingleLineUpdate_ = nil
			arg_202_1.onSingleLineFinish_ = nil
			arg_202_1.state_ = "waiting"
		end

		function arg_202_1.playNext_(arg_204_0)
			if arg_204_0 == 1 then
				arg_202_0:Play319811050(arg_202_1)
			end
		end

		function arg_202_1.onSingleLineUpdate_(arg_205_0)
			local var_205_0 = 0

			if var_205_0 < arg_202_1.time_ and arg_202_1.time_ <= var_205_0 + arg_205_0 then
				arg_202_1.fswbg_:SetActive(true)
				arg_202_1.dialog_:SetActive(false)

				arg_202_1.fswtw_.percent = 0

				local var_205_1 = arg_202_1:GetWordFromCfg(319811049)
				local var_205_2 = arg_202_1:FormatText(var_205_1.content)

				arg_202_1.fswt_.text = var_205_2

				LuaForUtil.ClearLinePrefixSymbol(arg_202_1.fswt_)

				arg_202_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_202_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_202_1.fswtw_:SetDirty()

				arg_202_1.typewritterCharCountI18N = 0

				SetActive(arg_202_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_202_1:ShowNextGo(false)
			end

			local var_205_3 = 0.266666666666667

			if var_205_3 < arg_202_1.time_ and arg_202_1.time_ <= var_205_3 + arg_205_0 then
				arg_202_1.var_.oldValueTypewriter = arg_202_1.fswtw_.percent

				SetActive(arg_202_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_202_1:ShowNextGo(false)
			end

			local var_205_4 = 18
			local var_205_5 = 1.2
			local var_205_6 = arg_202_1:GetWordFromCfg(319811049)
			local var_205_7 = arg_202_1:FormatText(var_205_6.content)
			local var_205_8, var_205_9 = arg_202_1:GetPercentByPara(var_205_7, 1)

			if var_205_3 < arg_202_1.time_ and arg_202_1.time_ <= var_205_3 + arg_205_0 then
				arg_202_1.talkMaxDuration = 0

				local var_205_10 = var_205_4 <= 0 and var_205_5 or var_205_5 * ((var_205_9 - arg_202_1.typewritterCharCountI18N) / var_205_4)

				if var_205_10 > 0 and var_205_5 < var_205_10 then
					arg_202_1.talkMaxDuration = var_205_10

					if var_205_10 + var_205_3 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_10 + var_205_3
					end
				end
			end

			local var_205_11 = 1.2
			local var_205_12 = math.max(var_205_11, arg_202_1.talkMaxDuration)

			if var_205_3 <= arg_202_1.time_ and arg_202_1.time_ < var_205_3 + var_205_12 then
				local var_205_13 = (arg_202_1.time_ - var_205_3) / var_205_12

				arg_202_1.fswtw_.percent = Mathf.Lerp(arg_202_1.var_.oldValueTypewriter, var_205_8, var_205_13)
				arg_202_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_202_1.fswtw_:SetDirty()
			end

			if arg_202_1.time_ >= var_205_3 + var_205_12 and arg_202_1.time_ < var_205_3 + var_205_12 + arg_205_0 then
				arg_202_1.fswtw_.percent = var_205_8

				arg_202_1.fswtw_:SetDirty()
				arg_202_1:ShowNextGo(true)

				arg_202_1.typewritterCharCountI18N = var_205_9
			end

			local var_205_14 = 0.266666666666667
			local var_205_15 = 3.833
			local var_205_16 = manager.audio:GetVoiceLength("story_v_out_319811", "319811049", "story_v_out_319811.awb") / 1000

			if var_205_16 > 0 and var_205_15 < var_205_16 and var_205_16 + var_205_14 > arg_202_1.duration_ then
				local var_205_17 = var_205_16

				arg_202_1.duration_ = var_205_16 + var_205_14
			end

			if var_205_14 < arg_202_1.time_ and arg_202_1.time_ <= var_205_14 + arg_205_0 then
				local var_205_18 = "play"
				local var_205_19 = "voice"

				arg_202_1:AudioAction(var_205_18, var_205_19, "story_v_out_319811", "319811049", "story_v_out_319811.awb")
			end
		end

		arg_202_1.nodeConfigList_ = {}

		arg_202_1:InitPlayNodeList()
	end,
	Play319811050 = function(arg_206_0, arg_206_1)
		arg_206_1.time_ = 0
		arg_206_1.frameCnt_ = 0
		arg_206_1.state_ = "playing"
		arg_206_1.curTalkId_ = 319811050
		arg_206_1.duration_ = 6.23

		SetActive(arg_206_1.tipsGo_, false)

		function arg_206_1.onSingleLineFinish_()
			arg_206_1.onSingleLineUpdate_ = nil
			arg_206_1.onSingleLineFinish_ = nil
			arg_206_1.state_ = "waiting"
		end

		function arg_206_1.playNext_(arg_208_0)
			if arg_208_0 == 1 then
				arg_206_0:Play319811051(arg_206_1)
			end
		end

		function arg_206_1.onSingleLineUpdate_(arg_209_0)
			local var_209_0 = 0

			if var_209_0 < arg_206_1.time_ and arg_206_1.time_ <= var_209_0 + arg_209_0 then
				local var_209_1 = manager.ui.mainCamera.transform.localPosition
				local var_209_2 = Vector3.New(0, 0, 10) + Vector3.New(var_209_1.x, var_209_1.y, 0)
				local var_209_3 = arg_206_1.bgs_.ST72a

				var_209_3.transform.localPosition = var_209_2
				var_209_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_209_4 = var_209_3:GetComponent("SpriteRenderer")

				if var_209_4 and var_209_4.sprite then
					local var_209_5 = (var_209_3.transform.localPosition - var_209_1).z
					local var_209_6 = manager.ui.mainCameraCom_
					local var_209_7 = 2 * var_209_5 * Mathf.Tan(var_209_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_209_8 = var_209_7 * var_209_6.aspect
					local var_209_9 = var_209_4.sprite.bounds.size.x
					local var_209_10 = var_209_4.sprite.bounds.size.y
					local var_209_11 = var_209_8 / var_209_9
					local var_209_12 = var_209_7 / var_209_10
					local var_209_13 = var_209_12 < var_209_11 and var_209_11 or var_209_12

					var_209_3.transform.localScale = Vector3.New(var_209_13, var_209_13, 0)
				end

				for iter_209_0, iter_209_1 in pairs(arg_206_1.bgs_) do
					if iter_209_0 ~= "ST72a" then
						iter_209_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_209_14 = 0

			if var_209_14 < arg_206_1.time_ and arg_206_1.time_ <= var_209_14 + arg_209_0 then
				arg_206_1.allBtn_.enabled = false
			end

			local var_209_15 = 0.3

			if arg_206_1.time_ >= var_209_14 + var_209_15 and arg_206_1.time_ < var_209_14 + var_209_15 + arg_209_0 then
				arg_206_1.allBtn_.enabled = true
			end

			local var_209_16 = 0

			if var_209_16 < arg_206_1.time_ and arg_206_1.time_ <= var_209_16 + arg_209_0 then
				arg_206_1.mask_.enabled = true
				arg_206_1.mask_.raycastTarget = true

				arg_206_1:SetGaussion(false)
			end

			local var_209_17 = 1.66666666666667

			if var_209_16 <= arg_206_1.time_ and arg_206_1.time_ < var_209_16 + var_209_17 then
				local var_209_18 = (arg_206_1.time_ - var_209_16) / var_209_17
				local var_209_19 = Color.New(0, 0, 0)

				var_209_19.a = Mathf.Lerp(1, 0, var_209_18)
				arg_206_1.mask_.color = var_209_19
			end

			if arg_206_1.time_ >= var_209_16 + var_209_17 and arg_206_1.time_ < var_209_16 + var_209_17 + arg_209_0 then
				local var_209_20 = Color.New(0, 0, 0)
				local var_209_21 = 0

				arg_206_1.mask_.enabled = false
				var_209_20.a = var_209_21
				arg_206_1.mask_.color = var_209_20
			end

			local var_209_22 = 0

			if var_209_22 < arg_206_1.time_ and arg_206_1.time_ <= var_209_22 + arg_209_0 then
				arg_206_1.fswbg_:SetActive(false)
				arg_206_1.dialog_:SetActive(false)
				SetActive(arg_206_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_206_1:ShowNextGo(false)
			end

			local var_209_23 = 0.1

			if var_209_23 < arg_206_1.time_ and arg_206_1.time_ <= var_209_23 + arg_209_0 then
				arg_206_1.fswbg_:SetActive(false)
				arg_206_1.dialog_:SetActive(false)
				SetActive(arg_206_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_206_1:ShowNextGo(false)
			end

			local var_209_24 = 0

			if var_209_24 < arg_206_1.time_ and arg_206_1.time_ <= var_209_24 + arg_209_0 then
				arg_206_1.cswbg_:SetActive(false)
			end

			if arg_206_1.frameCnt_ <= 1 then
				arg_206_1.dialog_:SetActive(false)
			end

			local var_209_25 = 1.23333333333333
			local var_209_26 = 1.4

			if var_209_25 < arg_206_1.time_ and arg_206_1.time_ <= var_209_25 + arg_209_0 then
				arg_206_1.talkMaxDuration = 0

				arg_206_1.dialog_:SetActive(true)

				arg_206_1.dialogCg_.alpha = 0

				local var_209_27 = LeanTween.value(arg_206_1.dialog_, 0, 1, 0.3)

				var_209_27:setOnUpdate(LuaHelper.FloatAction(function(arg_210_0)
					arg_206_1.dialogCg_.alpha = arg_210_0
				end))
				var_209_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_206_1.dialog_)
					var_209_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_206_1.duration_ = arg_206_1.duration_ + 0.3

				SetActive(arg_206_1.leftNameGo_, false)

				arg_206_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_206_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_206_1:RecordName(arg_206_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_206_1.iconTrs_.gameObject, false)
				arg_206_1.callingController_:SetSelectedState("normal")

				local var_209_28 = arg_206_1:GetWordFromCfg(319811050)
				local var_209_29 = arg_206_1:FormatText(var_209_28.content)

				arg_206_1.text_.text = var_209_29

				LuaForUtil.ClearLinePrefixSymbol(arg_206_1.text_)

				local var_209_30 = 56
				local var_209_31 = utf8.len(var_209_29)
				local var_209_32 = var_209_30 <= 0 and var_209_26 or var_209_26 * (var_209_31 / var_209_30)

				if var_209_32 > 0 and var_209_26 < var_209_32 then
					arg_206_1.talkMaxDuration = var_209_32
					var_209_25 = var_209_25 + 0.3

					if var_209_32 + var_209_25 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_32 + var_209_25
					end
				end

				arg_206_1.text_.text = var_209_29
				arg_206_1.typewritter.percent = 0

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(false)
				arg_206_1:RecordContent(arg_206_1.text_.text)
			end

			local var_209_33 = var_209_25 + 0.3
			local var_209_34 = math.max(var_209_26, arg_206_1.talkMaxDuration)

			if var_209_33 <= arg_206_1.time_ and arg_206_1.time_ < var_209_33 + var_209_34 then
				arg_206_1.typewritter.percent = (arg_206_1.time_ - var_209_33) / var_209_34

				arg_206_1.typewritter:SetDirty()
			end

			if arg_206_1.time_ >= var_209_33 + var_209_34 and arg_206_1.time_ < var_209_33 + var_209_34 + arg_209_0 then
				arg_206_1.typewritter.percent = 1

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(true)
			end
		end

		arg_206_1.nodeConfigList_ = {}

		arg_206_1:InitPlayNodeList()
	end,
	Play319811051 = function(arg_212_0, arg_212_1)
		arg_212_1.time_ = 0
		arg_212_1.frameCnt_ = 0
		arg_212_1.state_ = "playing"
		arg_212_1.curTalkId_ = 319811051
		arg_212_1.duration_ = 8.17

		local var_212_0 = {
			zh = 7.166,
			ja = 8.166
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
				arg_212_0:Play319811052(arg_212_1)
			end
		end

		function arg_212_1.onSingleLineUpdate_(arg_215_0)
			local var_215_0 = "10037ui_story"

			if arg_212_1.actors_[var_215_0] == nil then
				local var_215_1 = Asset.Load("Char/" .. "10037ui_story")

				if not isNil(var_215_1) then
					local var_215_2 = Object.Instantiate(Asset.Load("Char/" .. "10037ui_story"), arg_212_1.stage_.transform)

					var_215_2.name = var_215_0
					var_215_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_212_1.actors_[var_215_0] = var_215_2

					local var_215_3 = var_215_2:GetComponentInChildren(typeof(CharacterEffect))

					var_215_3.enabled = true

					local var_215_4 = GameObjectTools.GetOrAddComponent(var_215_2, typeof(DynamicBoneHelper))

					if var_215_4 then
						var_215_4:EnableDynamicBone(false)
					end

					arg_212_1:ShowWeapon(var_215_3.transform, false)

					arg_212_1.var_[var_215_0 .. "Animator"] = var_215_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_212_1.var_[var_215_0 .. "Animator"].applyRootMotion = true
					arg_212_1.var_[var_215_0 .. "LipSync"] = var_215_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_215_5 = arg_212_1.actors_["10037ui_story"].transform
			local var_215_6 = 0

			if var_215_6 < arg_212_1.time_ and arg_212_1.time_ <= var_215_6 + arg_215_0 then
				arg_212_1.var_.moveOldPos10037ui_story = var_215_5.localPosition

				local var_215_7 = "10037ui_story"

				arg_212_1:ShowWeapon(arg_212_1.var_[var_215_7 .. "Animator"].transform, false)
			end

			local var_215_8 = 0.001

			if var_215_6 <= arg_212_1.time_ and arg_212_1.time_ < var_215_6 + var_215_8 then
				local var_215_9 = (arg_212_1.time_ - var_215_6) / var_215_8
				local var_215_10 = Vector3.New(0, -1.13, -6.2)

				var_215_5.localPosition = Vector3.Lerp(arg_212_1.var_.moveOldPos10037ui_story, var_215_10, var_215_9)

				local var_215_11 = manager.ui.mainCamera.transform.position - var_215_5.position

				var_215_5.forward = Vector3.New(var_215_11.x, var_215_11.y, var_215_11.z)

				local var_215_12 = var_215_5.localEulerAngles

				var_215_12.z = 0
				var_215_12.x = 0
				var_215_5.localEulerAngles = var_215_12
			end

			if arg_212_1.time_ >= var_215_6 + var_215_8 and arg_212_1.time_ < var_215_6 + var_215_8 + arg_215_0 then
				var_215_5.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_215_13 = manager.ui.mainCamera.transform.position - var_215_5.position

				var_215_5.forward = Vector3.New(var_215_13.x, var_215_13.y, var_215_13.z)

				local var_215_14 = var_215_5.localEulerAngles

				var_215_14.z = 0
				var_215_14.x = 0
				var_215_5.localEulerAngles = var_215_14
			end

			local var_215_15 = arg_212_1.actors_["10037ui_story"]
			local var_215_16 = 0

			if var_215_16 < arg_212_1.time_ and arg_212_1.time_ <= var_215_16 + arg_215_0 and not isNil(var_215_15) and arg_212_1.var_.characterEffect10037ui_story == nil then
				arg_212_1.var_.characterEffect10037ui_story = var_215_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_215_17 = 0.200000002980232

			if var_215_16 <= arg_212_1.time_ and arg_212_1.time_ < var_215_16 + var_215_17 and not isNil(var_215_15) then
				local var_215_18 = (arg_212_1.time_ - var_215_16) / var_215_17

				if arg_212_1.var_.characterEffect10037ui_story and not isNil(var_215_15) then
					arg_212_1.var_.characterEffect10037ui_story.fillFlat = false
				end
			end

			if arg_212_1.time_ >= var_215_16 + var_215_17 and arg_212_1.time_ < var_215_16 + var_215_17 + arg_215_0 and not isNil(var_215_15) and arg_212_1.var_.characterEffect10037ui_story then
				arg_212_1.var_.characterEffect10037ui_story.fillFlat = false
			end

			local var_215_19 = 0

			if var_215_19 < arg_212_1.time_ and arg_212_1.time_ <= var_215_19 + arg_215_0 then
				arg_212_1:PlayTimeline("10037ui_story", "StoryTimeline/CharAction/story10037/story10037action/10037action1_1")
			end

			local var_215_20 = 0

			if var_215_20 < arg_212_1.time_ and arg_212_1.time_ <= var_215_20 + arg_215_0 then
				arg_212_1:PlayTimeline("10037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_215_21 = 0
			local var_215_22 = 0.625

			if var_215_21 < arg_212_1.time_ and arg_212_1.time_ <= var_215_21 + arg_215_0 then
				arg_212_1.talkMaxDuration = 0
				arg_212_1.dialogCg_.alpha = 1

				arg_212_1.dialog_:SetActive(true)
				SetActive(arg_212_1.leftNameGo_, true)

				local var_215_23 = arg_212_1:FormatText(StoryNameCfg[383].name)

				arg_212_1.leftNameTxt_.text = var_215_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_212_1.leftNameTxt_.transform)

				arg_212_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_212_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_212_1:RecordName(arg_212_1.leftNameTxt_.text)
				SetActive(arg_212_1.iconTrs_.gameObject, false)
				arg_212_1.callingController_:SetSelectedState("normal")

				local var_215_24 = arg_212_1:GetWordFromCfg(319811051)
				local var_215_25 = arg_212_1:FormatText(var_215_24.content)

				arg_212_1.text_.text = var_215_25

				LuaForUtil.ClearLinePrefixSymbol(arg_212_1.text_)

				local var_215_26 = 25
				local var_215_27 = utf8.len(var_215_25)
				local var_215_28 = var_215_26 <= 0 and var_215_22 or var_215_22 * (var_215_27 / var_215_26)

				if var_215_28 > 0 and var_215_22 < var_215_28 then
					arg_212_1.talkMaxDuration = var_215_28

					if var_215_28 + var_215_21 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_28 + var_215_21
					end
				end

				arg_212_1.text_.text = var_215_25
				arg_212_1.typewritter.percent = 0

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319811", "319811051", "story_v_out_319811.awb") ~= 0 then
					local var_215_29 = manager.audio:GetVoiceLength("story_v_out_319811", "319811051", "story_v_out_319811.awb") / 1000

					if var_215_29 + var_215_21 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_29 + var_215_21
					end

					if var_215_24.prefab_name ~= "" and arg_212_1.actors_[var_215_24.prefab_name] ~= nil then
						local var_215_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_212_1.actors_[var_215_24.prefab_name].transform, "story_v_out_319811", "319811051", "story_v_out_319811.awb")

						arg_212_1:RecordAudio("319811051", var_215_30)
						arg_212_1:RecordAudio("319811051", var_215_30)
					else
						arg_212_1:AudioAction("play", "voice", "story_v_out_319811", "319811051", "story_v_out_319811.awb")
					end

					arg_212_1:RecordHistoryTalkVoice("story_v_out_319811", "319811051", "story_v_out_319811.awb")
				end

				arg_212_1:RecordContent(arg_212_1.text_.text)
			end

			local var_215_31 = math.max(var_215_22, arg_212_1.talkMaxDuration)

			if var_215_21 <= arg_212_1.time_ and arg_212_1.time_ < var_215_21 + var_215_31 then
				arg_212_1.typewritter.percent = (arg_212_1.time_ - var_215_21) / var_215_31

				arg_212_1.typewritter:SetDirty()
			end

			if arg_212_1.time_ >= var_215_21 + var_215_31 and arg_212_1.time_ < var_215_21 + var_215_31 + arg_215_0 then
				arg_212_1.typewritter.percent = 1

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(true)
			end
		end

		arg_212_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10037ui_story",
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
	Play319811052 = function(arg_216_0, arg_216_1)
		arg_216_1.time_ = 0
		arg_216_1.frameCnt_ = 0
		arg_216_1.state_ = "playing"
		arg_216_1.curTalkId_ = 319811052
		arg_216_1.duration_ = 3.5

		local var_216_0 = {
			zh = 1.999999999999,
			ja = 3.5
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
				arg_216_0:Play319811053(arg_216_1)
			end
		end

		function arg_216_1.onSingleLineUpdate_(arg_219_0)
			local var_219_0 = arg_216_1.actors_["10058ui_story"].transform
			local var_219_1 = 0

			if var_219_1 < arg_216_1.time_ and arg_216_1.time_ <= var_219_1 + arg_219_0 then
				arg_216_1.var_.moveOldPos10058ui_story = var_219_0.localPosition
			end

			local var_219_2 = 0.001

			if var_219_1 <= arg_216_1.time_ and arg_216_1.time_ < var_219_1 + var_219_2 then
				local var_219_3 = (arg_216_1.time_ - var_219_1) / var_219_2
				local var_219_4 = Vector3.New(0, -0.98, -6.1)

				var_219_0.localPosition = Vector3.Lerp(arg_216_1.var_.moveOldPos10058ui_story, var_219_4, var_219_3)

				local var_219_5 = manager.ui.mainCamera.transform.position - var_219_0.position

				var_219_0.forward = Vector3.New(var_219_5.x, var_219_5.y, var_219_5.z)

				local var_219_6 = var_219_0.localEulerAngles

				var_219_6.z = 0
				var_219_6.x = 0
				var_219_0.localEulerAngles = var_219_6
			end

			if arg_216_1.time_ >= var_219_1 + var_219_2 and arg_216_1.time_ < var_219_1 + var_219_2 + arg_219_0 then
				var_219_0.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_219_7 = manager.ui.mainCamera.transform.position - var_219_0.position

				var_219_0.forward = Vector3.New(var_219_7.x, var_219_7.y, var_219_7.z)

				local var_219_8 = var_219_0.localEulerAngles

				var_219_8.z = 0
				var_219_8.x = 0
				var_219_0.localEulerAngles = var_219_8
			end

			local var_219_9 = arg_216_1.actors_["10058ui_story"]
			local var_219_10 = 0

			if var_219_10 < arg_216_1.time_ and arg_216_1.time_ <= var_219_10 + arg_219_0 and not isNil(var_219_9) and arg_216_1.var_.characterEffect10058ui_story == nil then
				arg_216_1.var_.characterEffect10058ui_story = var_219_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_219_11 = 0.200000002980232

			if var_219_10 <= arg_216_1.time_ and arg_216_1.time_ < var_219_10 + var_219_11 and not isNil(var_219_9) then
				local var_219_12 = (arg_216_1.time_ - var_219_10) / var_219_11

				if arg_216_1.var_.characterEffect10058ui_story and not isNil(var_219_9) then
					arg_216_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_216_1.time_ >= var_219_10 + var_219_11 and arg_216_1.time_ < var_219_10 + var_219_11 + arg_219_0 and not isNil(var_219_9) and arg_216_1.var_.characterEffect10058ui_story then
				arg_216_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_219_13 = 0

			if var_219_13 < arg_216_1.time_ and arg_216_1.time_ <= var_219_13 + arg_219_0 then
				arg_216_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_219_14 = 0

			if var_219_14 < arg_216_1.time_ and arg_216_1.time_ <= var_219_14 + arg_219_0 then
				arg_216_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_219_15 = arg_216_1.actors_["10037ui_story"].transform
			local var_219_16 = 0

			if var_219_16 < arg_216_1.time_ and arg_216_1.time_ <= var_219_16 + arg_219_0 then
				arg_216_1.var_.moveOldPos10037ui_story = var_219_15.localPosition
			end

			local var_219_17 = 0.001

			if var_219_16 <= arg_216_1.time_ and arg_216_1.time_ < var_219_16 + var_219_17 then
				local var_219_18 = (arg_216_1.time_ - var_219_16) / var_219_17
				local var_219_19 = Vector3.New(0, 100, 0)

				var_219_15.localPosition = Vector3.Lerp(arg_216_1.var_.moveOldPos10037ui_story, var_219_19, var_219_18)

				local var_219_20 = manager.ui.mainCamera.transform.position - var_219_15.position

				var_219_15.forward = Vector3.New(var_219_20.x, var_219_20.y, var_219_20.z)

				local var_219_21 = var_219_15.localEulerAngles

				var_219_21.z = 0
				var_219_21.x = 0
				var_219_15.localEulerAngles = var_219_21
			end

			if arg_216_1.time_ >= var_219_16 + var_219_17 and arg_216_1.time_ < var_219_16 + var_219_17 + arg_219_0 then
				var_219_15.localPosition = Vector3.New(0, 100, 0)

				local var_219_22 = manager.ui.mainCamera.transform.position - var_219_15.position

				var_219_15.forward = Vector3.New(var_219_22.x, var_219_22.y, var_219_22.z)

				local var_219_23 = var_219_15.localEulerAngles

				var_219_23.z = 0
				var_219_23.x = 0
				var_219_15.localEulerAngles = var_219_23
			end

			local var_219_24 = arg_216_1.actors_["10037ui_story"]
			local var_219_25 = 0

			if var_219_25 < arg_216_1.time_ and arg_216_1.time_ <= var_219_25 + arg_219_0 and not isNil(var_219_24) and arg_216_1.var_.characterEffect10037ui_story == nil then
				arg_216_1.var_.characterEffect10037ui_story = var_219_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_219_26 = 0.200000002980232

			if var_219_25 <= arg_216_1.time_ and arg_216_1.time_ < var_219_25 + var_219_26 and not isNil(var_219_24) then
				local var_219_27 = (arg_216_1.time_ - var_219_25) / var_219_26

				if arg_216_1.var_.characterEffect10037ui_story and not isNil(var_219_24) then
					local var_219_28 = Mathf.Lerp(0, 0.5, var_219_27)

					arg_216_1.var_.characterEffect10037ui_story.fillFlat = true
					arg_216_1.var_.characterEffect10037ui_story.fillRatio = var_219_28
				end
			end

			if arg_216_1.time_ >= var_219_25 + var_219_26 and arg_216_1.time_ < var_219_25 + var_219_26 + arg_219_0 and not isNil(var_219_24) and arg_216_1.var_.characterEffect10037ui_story then
				local var_219_29 = 0.5

				arg_216_1.var_.characterEffect10037ui_story.fillFlat = true
				arg_216_1.var_.characterEffect10037ui_story.fillRatio = var_219_29
			end

			local var_219_30 = 0
			local var_219_31 = 0.1

			if var_219_30 < arg_216_1.time_ and arg_216_1.time_ <= var_219_30 + arg_219_0 then
				arg_216_1.talkMaxDuration = 0
				arg_216_1.dialogCg_.alpha = 1

				arg_216_1.dialog_:SetActive(true)
				SetActive(arg_216_1.leftNameGo_, true)

				local var_219_32 = arg_216_1:FormatText(StoryNameCfg[471].name)

				arg_216_1.leftNameTxt_.text = var_219_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_216_1.leftNameTxt_.transform)

				arg_216_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_216_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_216_1:RecordName(arg_216_1.leftNameTxt_.text)
				SetActive(arg_216_1.iconTrs_.gameObject, false)
				arg_216_1.callingController_:SetSelectedState("normal")

				local var_219_33 = arg_216_1:GetWordFromCfg(319811052)
				local var_219_34 = arg_216_1:FormatText(var_219_33.content)

				arg_216_1.text_.text = var_219_34

				LuaForUtil.ClearLinePrefixSymbol(arg_216_1.text_)

				local var_219_35 = 4
				local var_219_36 = utf8.len(var_219_34)
				local var_219_37 = var_219_35 <= 0 and var_219_31 or var_219_31 * (var_219_36 / var_219_35)

				if var_219_37 > 0 and var_219_31 < var_219_37 then
					arg_216_1.talkMaxDuration = var_219_37

					if var_219_37 + var_219_30 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_37 + var_219_30
					end
				end

				arg_216_1.text_.text = var_219_34
				arg_216_1.typewritter.percent = 0

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319811", "319811052", "story_v_out_319811.awb") ~= 0 then
					local var_219_38 = manager.audio:GetVoiceLength("story_v_out_319811", "319811052", "story_v_out_319811.awb") / 1000

					if var_219_38 + var_219_30 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_38 + var_219_30
					end

					if var_219_33.prefab_name ~= "" and arg_216_1.actors_[var_219_33.prefab_name] ~= nil then
						local var_219_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_216_1.actors_[var_219_33.prefab_name].transform, "story_v_out_319811", "319811052", "story_v_out_319811.awb")

						arg_216_1:RecordAudio("319811052", var_219_39)
						arg_216_1:RecordAudio("319811052", var_219_39)
					else
						arg_216_1:AudioAction("play", "voice", "story_v_out_319811", "319811052", "story_v_out_319811.awb")
					end

					arg_216_1:RecordHistoryTalkVoice("story_v_out_319811", "319811052", "story_v_out_319811.awb")
				end

				arg_216_1:RecordContent(arg_216_1.text_.text)
			end

			local var_219_40 = math.max(var_219_31, arg_216_1.talkMaxDuration)

			if var_219_30 <= arg_216_1.time_ and arg_216_1.time_ < var_219_30 + var_219_40 then
				arg_216_1.typewritter.percent = (arg_216_1.time_ - var_219_30) / var_219_40

				arg_216_1.typewritter:SetDirty()
			end

			if arg_216_1.time_ >= var_219_30 + var_219_40 and arg_216_1.time_ < var_219_30 + var_219_40 + arg_219_0 then
				arg_216_1.typewritter.percent = 1

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(true)
			end
		end

		arg_216_1.nodeConfigList_ = {
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
				actorName = "10037ui_story",
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
	Play319811053 = function(arg_220_0, arg_220_1)
		arg_220_1.time_ = 0
		arg_220_1.frameCnt_ = 0
		arg_220_1.state_ = "playing"
		arg_220_1.curTalkId_ = 319811053
		arg_220_1.duration_ = 3.67

		local var_220_0 = {
			zh = 3.566,
			ja = 3.666
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
				arg_220_0:Play319811054(arg_220_1)
			end
		end

		function arg_220_1.onSingleLineUpdate_(arg_223_0)
			local var_223_0 = "4037ui_story"

			if arg_220_1.actors_[var_223_0] == nil then
				local var_223_1 = Asset.Load("Char/" .. "4037ui_story")

				if not isNil(var_223_1) then
					local var_223_2 = Object.Instantiate(Asset.Load("Char/" .. "4037ui_story"), arg_220_1.stage_.transform)

					var_223_2.name = var_223_0
					var_223_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_220_1.actors_[var_223_0] = var_223_2

					local var_223_3 = var_223_2:GetComponentInChildren(typeof(CharacterEffect))

					var_223_3.enabled = true

					local var_223_4 = GameObjectTools.GetOrAddComponent(var_223_2, typeof(DynamicBoneHelper))

					if var_223_4 then
						var_223_4:EnableDynamicBone(false)
					end

					arg_220_1:ShowWeapon(var_223_3.transform, false)

					arg_220_1.var_[var_223_0 .. "Animator"] = var_223_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_220_1.var_[var_223_0 .. "Animator"].applyRootMotion = true
					arg_220_1.var_[var_223_0 .. "LipSync"] = var_223_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_223_5 = arg_220_1.actors_["4037ui_story"].transform
			local var_223_6 = 0

			if var_223_6 < arg_220_1.time_ and arg_220_1.time_ <= var_223_6 + arg_223_0 then
				arg_220_1.var_.moveOldPos4037ui_story = var_223_5.localPosition
			end

			local var_223_7 = 0.001

			if var_223_6 <= arg_220_1.time_ and arg_220_1.time_ < var_223_6 + var_223_7 then
				local var_223_8 = (arg_220_1.time_ - var_223_6) / var_223_7
				local var_223_9 = Vector3.New(0.7, -1.12, -6.2)

				var_223_5.localPosition = Vector3.Lerp(arg_220_1.var_.moveOldPos4037ui_story, var_223_9, var_223_8)

				local var_223_10 = manager.ui.mainCamera.transform.position - var_223_5.position

				var_223_5.forward = Vector3.New(var_223_10.x, var_223_10.y, var_223_10.z)

				local var_223_11 = var_223_5.localEulerAngles

				var_223_11.z = 0
				var_223_11.x = 0
				var_223_5.localEulerAngles = var_223_11
			end

			if arg_220_1.time_ >= var_223_6 + var_223_7 and arg_220_1.time_ < var_223_6 + var_223_7 + arg_223_0 then
				var_223_5.localPosition = Vector3.New(0.7, -1.12, -6.2)

				local var_223_12 = manager.ui.mainCamera.transform.position - var_223_5.position

				var_223_5.forward = Vector3.New(var_223_12.x, var_223_12.y, var_223_12.z)

				local var_223_13 = var_223_5.localEulerAngles

				var_223_13.z = 0
				var_223_13.x = 0
				var_223_5.localEulerAngles = var_223_13
			end

			local var_223_14 = arg_220_1.actors_["4037ui_story"]
			local var_223_15 = 0

			if var_223_15 < arg_220_1.time_ and arg_220_1.time_ <= var_223_15 + arg_223_0 and not isNil(var_223_14) and arg_220_1.var_.characterEffect4037ui_story == nil then
				arg_220_1.var_.characterEffect4037ui_story = var_223_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_223_16 = 0.200000002980232

			if var_223_15 <= arg_220_1.time_ and arg_220_1.time_ < var_223_15 + var_223_16 and not isNil(var_223_14) then
				local var_223_17 = (arg_220_1.time_ - var_223_15) / var_223_16

				if arg_220_1.var_.characterEffect4037ui_story and not isNil(var_223_14) then
					arg_220_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_220_1.time_ >= var_223_15 + var_223_16 and arg_220_1.time_ < var_223_15 + var_223_16 + arg_223_0 and not isNil(var_223_14) and arg_220_1.var_.characterEffect4037ui_story then
				arg_220_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			local var_223_18 = 0

			if var_223_18 < arg_220_1.time_ and arg_220_1.time_ <= var_223_18 + arg_223_0 then
				arg_220_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action2_1")
			end

			local var_223_19 = 0

			if var_223_19 < arg_220_1.time_ and arg_220_1.time_ <= var_223_19 + arg_223_0 then
				arg_220_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_223_20 = arg_220_1.actors_["10058ui_story"].transform
			local var_223_21 = 0

			if var_223_21 < arg_220_1.time_ and arg_220_1.time_ <= var_223_21 + arg_223_0 then
				arg_220_1.var_.moveOldPos10058ui_story = var_223_20.localPosition
			end

			local var_223_22 = 0.001

			if var_223_21 <= arg_220_1.time_ and arg_220_1.time_ < var_223_21 + var_223_22 then
				local var_223_23 = (arg_220_1.time_ - var_223_21) / var_223_22
				local var_223_24 = Vector3.New(-0.7, -0.98, -6.1)

				var_223_20.localPosition = Vector3.Lerp(arg_220_1.var_.moveOldPos10058ui_story, var_223_24, var_223_23)

				local var_223_25 = manager.ui.mainCamera.transform.position - var_223_20.position

				var_223_20.forward = Vector3.New(var_223_25.x, var_223_25.y, var_223_25.z)

				local var_223_26 = var_223_20.localEulerAngles

				var_223_26.z = 0
				var_223_26.x = 0
				var_223_20.localEulerAngles = var_223_26
			end

			if arg_220_1.time_ >= var_223_21 + var_223_22 and arg_220_1.time_ < var_223_21 + var_223_22 + arg_223_0 then
				var_223_20.localPosition = Vector3.New(-0.7, -0.98, -6.1)

				local var_223_27 = manager.ui.mainCamera.transform.position - var_223_20.position

				var_223_20.forward = Vector3.New(var_223_27.x, var_223_27.y, var_223_27.z)

				local var_223_28 = var_223_20.localEulerAngles

				var_223_28.z = 0
				var_223_28.x = 0
				var_223_20.localEulerAngles = var_223_28
			end

			local var_223_29 = arg_220_1.actors_["10058ui_story"]
			local var_223_30 = 0

			if var_223_30 < arg_220_1.time_ and arg_220_1.time_ <= var_223_30 + arg_223_0 and not isNil(var_223_29) and arg_220_1.var_.characterEffect10058ui_story == nil then
				arg_220_1.var_.characterEffect10058ui_story = var_223_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_223_31 = 0.200000002980232

			if var_223_30 <= arg_220_1.time_ and arg_220_1.time_ < var_223_30 + var_223_31 and not isNil(var_223_29) then
				local var_223_32 = (arg_220_1.time_ - var_223_30) / var_223_31

				if arg_220_1.var_.characterEffect10058ui_story and not isNil(var_223_29) then
					local var_223_33 = Mathf.Lerp(0, 0.5, var_223_32)

					arg_220_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_220_1.var_.characterEffect10058ui_story.fillRatio = var_223_33
				end
			end

			if arg_220_1.time_ >= var_223_30 + var_223_31 and arg_220_1.time_ < var_223_30 + var_223_31 + arg_223_0 and not isNil(var_223_29) and arg_220_1.var_.characterEffect10058ui_story then
				local var_223_34 = 0.5

				arg_220_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_220_1.var_.characterEffect10058ui_story.fillRatio = var_223_34
			end

			local var_223_35 = 0
			local var_223_36 = 0.35

			if var_223_35 < arg_220_1.time_ and arg_220_1.time_ <= var_223_35 + arg_223_0 then
				arg_220_1.talkMaxDuration = 0
				arg_220_1.dialogCg_.alpha = 1

				arg_220_1.dialog_:SetActive(true)
				SetActive(arg_220_1.leftNameGo_, true)

				local var_223_37 = arg_220_1:FormatText(StoryNameCfg[453].name)

				arg_220_1.leftNameTxt_.text = var_223_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_220_1.leftNameTxt_.transform)

				arg_220_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_220_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_220_1:RecordName(arg_220_1.leftNameTxt_.text)
				SetActive(arg_220_1.iconTrs_.gameObject, false)
				arg_220_1.callingController_:SetSelectedState("normal")

				local var_223_38 = arg_220_1:GetWordFromCfg(319811053)
				local var_223_39 = arg_220_1:FormatText(var_223_38.content)

				arg_220_1.text_.text = var_223_39

				LuaForUtil.ClearLinePrefixSymbol(arg_220_1.text_)

				local var_223_40 = 14
				local var_223_41 = utf8.len(var_223_39)
				local var_223_42 = var_223_40 <= 0 and var_223_36 or var_223_36 * (var_223_41 / var_223_40)

				if var_223_42 > 0 and var_223_36 < var_223_42 then
					arg_220_1.talkMaxDuration = var_223_42

					if var_223_42 + var_223_35 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_42 + var_223_35
					end
				end

				arg_220_1.text_.text = var_223_39
				arg_220_1.typewritter.percent = 0

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319811", "319811053", "story_v_out_319811.awb") ~= 0 then
					local var_223_43 = manager.audio:GetVoiceLength("story_v_out_319811", "319811053", "story_v_out_319811.awb") / 1000

					if var_223_43 + var_223_35 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_43 + var_223_35
					end

					if var_223_38.prefab_name ~= "" and arg_220_1.actors_[var_223_38.prefab_name] ~= nil then
						local var_223_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_220_1.actors_[var_223_38.prefab_name].transform, "story_v_out_319811", "319811053", "story_v_out_319811.awb")

						arg_220_1:RecordAudio("319811053", var_223_44)
						arg_220_1:RecordAudio("319811053", var_223_44)
					else
						arg_220_1:AudioAction("play", "voice", "story_v_out_319811", "319811053", "story_v_out_319811.awb")
					end

					arg_220_1:RecordHistoryTalkVoice("story_v_out_319811", "319811053", "story_v_out_319811.awb")
				end

				arg_220_1:RecordContent(arg_220_1.text_.text)
			end

			local var_223_45 = math.max(var_223_36, arg_220_1.talkMaxDuration)

			if var_223_35 <= arg_220_1.time_ and arg_220_1.time_ < var_223_35 + var_223_45 then
				arg_220_1.typewritter.percent = (arg_220_1.time_ - var_223_35) / var_223_45

				arg_220_1.typewritter:SetDirty()
			end

			if arg_220_1.time_ >= var_223_35 + var_223_45 and arg_220_1.time_ < var_223_35 + var_223_45 + arg_223_0 then
				arg_220_1.typewritter.percent = 1

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(true)
			end
		end

		arg_220_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_220_1:InitPlayNodeList()
	end,
	Play319811054 = function(arg_224_0, arg_224_1)
		arg_224_1.time_ = 0
		arg_224_1.frameCnt_ = 0
		arg_224_1.state_ = "playing"
		arg_224_1.curTalkId_ = 319811054
		arg_224_1.duration_ = 2.8

		local var_224_0 = {
			zh = 1.999999999999,
			ja = 2.8
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
				arg_224_0:Play319811055(arg_224_1)
			end
		end

		function arg_224_1.onSingleLineUpdate_(arg_227_0)
			local var_227_0 = arg_224_1.actors_["10058ui_story"]
			local var_227_1 = 0

			if var_227_1 < arg_224_1.time_ and arg_224_1.time_ <= var_227_1 + arg_227_0 and not isNil(var_227_0) and arg_224_1.var_.characterEffect10058ui_story == nil then
				arg_224_1.var_.characterEffect10058ui_story = var_227_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_227_2 = 0.200000002980232

			if var_227_1 <= arg_224_1.time_ and arg_224_1.time_ < var_227_1 + var_227_2 and not isNil(var_227_0) then
				local var_227_3 = (arg_224_1.time_ - var_227_1) / var_227_2

				if arg_224_1.var_.characterEffect10058ui_story and not isNil(var_227_0) then
					arg_224_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_224_1.time_ >= var_227_1 + var_227_2 and arg_224_1.time_ < var_227_1 + var_227_2 + arg_227_0 and not isNil(var_227_0) and arg_224_1.var_.characterEffect10058ui_story then
				arg_224_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_227_4 = 0

			if var_227_4 < arg_224_1.time_ and arg_224_1.time_ <= var_227_4 + arg_227_0 then
				arg_224_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_227_5 = 0

			if var_227_5 < arg_224_1.time_ and arg_224_1.time_ <= var_227_5 + arg_227_0 then
				arg_224_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_227_6 = arg_224_1.actors_["4037ui_story"]
			local var_227_7 = 0

			if var_227_7 < arg_224_1.time_ and arg_224_1.time_ <= var_227_7 + arg_227_0 and not isNil(var_227_6) and arg_224_1.var_.characterEffect4037ui_story == nil then
				arg_224_1.var_.characterEffect4037ui_story = var_227_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_227_8 = 0.200000002980232

			if var_227_7 <= arg_224_1.time_ and arg_224_1.time_ < var_227_7 + var_227_8 and not isNil(var_227_6) then
				local var_227_9 = (arg_224_1.time_ - var_227_7) / var_227_8

				if arg_224_1.var_.characterEffect4037ui_story and not isNil(var_227_6) then
					local var_227_10 = Mathf.Lerp(0, 0.5, var_227_9)

					arg_224_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_224_1.var_.characterEffect4037ui_story.fillRatio = var_227_10
				end
			end

			if arg_224_1.time_ >= var_227_7 + var_227_8 and arg_224_1.time_ < var_227_7 + var_227_8 + arg_227_0 and not isNil(var_227_6) and arg_224_1.var_.characterEffect4037ui_story then
				local var_227_11 = 0.5

				arg_224_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_224_1.var_.characterEffect4037ui_story.fillRatio = var_227_11
			end

			local var_227_12 = 0
			local var_227_13 = 0.15

			if var_227_12 < arg_224_1.time_ and arg_224_1.time_ <= var_227_12 + arg_227_0 then
				arg_224_1.talkMaxDuration = 0
				arg_224_1.dialogCg_.alpha = 1

				arg_224_1.dialog_:SetActive(true)
				SetActive(arg_224_1.leftNameGo_, true)

				local var_227_14 = arg_224_1:FormatText(StoryNameCfg[471].name)

				arg_224_1.leftNameTxt_.text = var_227_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_224_1.leftNameTxt_.transform)

				arg_224_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_224_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_224_1:RecordName(arg_224_1.leftNameTxt_.text)
				SetActive(arg_224_1.iconTrs_.gameObject, false)
				arg_224_1.callingController_:SetSelectedState("normal")

				local var_227_15 = arg_224_1:GetWordFromCfg(319811054)
				local var_227_16 = arg_224_1:FormatText(var_227_15.content)

				arg_224_1.text_.text = var_227_16

				LuaForUtil.ClearLinePrefixSymbol(arg_224_1.text_)

				local var_227_17 = 6
				local var_227_18 = utf8.len(var_227_16)
				local var_227_19 = var_227_17 <= 0 and var_227_13 or var_227_13 * (var_227_18 / var_227_17)

				if var_227_19 > 0 and var_227_13 < var_227_19 then
					arg_224_1.talkMaxDuration = var_227_19

					if var_227_19 + var_227_12 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_19 + var_227_12
					end
				end

				arg_224_1.text_.text = var_227_16
				arg_224_1.typewritter.percent = 0

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319811", "319811054", "story_v_out_319811.awb") ~= 0 then
					local var_227_20 = manager.audio:GetVoiceLength("story_v_out_319811", "319811054", "story_v_out_319811.awb") / 1000

					if var_227_20 + var_227_12 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_20 + var_227_12
					end

					if var_227_15.prefab_name ~= "" and arg_224_1.actors_[var_227_15.prefab_name] ~= nil then
						local var_227_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_224_1.actors_[var_227_15.prefab_name].transform, "story_v_out_319811", "319811054", "story_v_out_319811.awb")

						arg_224_1:RecordAudio("319811054", var_227_21)
						arg_224_1:RecordAudio("319811054", var_227_21)
					else
						arg_224_1:AudioAction("play", "voice", "story_v_out_319811", "319811054", "story_v_out_319811.awb")
					end

					arg_224_1:RecordHistoryTalkVoice("story_v_out_319811", "319811054", "story_v_out_319811.awb")
				end

				arg_224_1:RecordContent(arg_224_1.text_.text)
			end

			local var_227_22 = math.max(var_227_13, arg_224_1.talkMaxDuration)

			if var_227_12 <= arg_224_1.time_ and arg_224_1.time_ < var_227_12 + var_227_22 then
				arg_224_1.typewritter.percent = (arg_224_1.time_ - var_227_12) / var_227_22

				arg_224_1.typewritter:SetDirty()
			end

			if arg_224_1.time_ >= var_227_12 + var_227_22 and arg_224_1.time_ < var_227_12 + var_227_22 + arg_227_0 then
				arg_224_1.typewritter.percent = 1

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(true)
			end
		end

		arg_224_1.nodeConfigList_ = {}

		arg_224_1:InitPlayNodeList()
	end,
	Play319811055 = function(arg_228_0, arg_228_1)
		arg_228_1.time_ = 0
		arg_228_1.frameCnt_ = 0
		arg_228_1.state_ = "playing"
		arg_228_1.curTalkId_ = 319811055
		arg_228_1.duration_ = 8.23

		local var_228_0 = {
			zh = 6.133,
			ja = 8.233
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
				arg_228_0:Play319811056(arg_228_1)
			end
		end

		function arg_228_1.onSingleLineUpdate_(arg_231_0)
			local var_231_0 = arg_228_1.actors_["4037ui_story"]
			local var_231_1 = 0

			if var_231_1 < arg_228_1.time_ and arg_228_1.time_ <= var_231_1 + arg_231_0 and not isNil(var_231_0) and arg_228_1.var_.characterEffect4037ui_story == nil then
				arg_228_1.var_.characterEffect4037ui_story = var_231_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_231_2 = 0.200000002980232

			if var_231_1 <= arg_228_1.time_ and arg_228_1.time_ < var_231_1 + var_231_2 and not isNil(var_231_0) then
				local var_231_3 = (arg_228_1.time_ - var_231_1) / var_231_2

				if arg_228_1.var_.characterEffect4037ui_story and not isNil(var_231_0) then
					arg_228_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_228_1.time_ >= var_231_1 + var_231_2 and arg_228_1.time_ < var_231_1 + var_231_2 + arg_231_0 and not isNil(var_231_0) and arg_228_1.var_.characterEffect4037ui_story then
				arg_228_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			local var_231_4 = arg_228_1.actors_["10058ui_story"]
			local var_231_5 = 0

			if var_231_5 < arg_228_1.time_ and arg_228_1.time_ <= var_231_5 + arg_231_0 and not isNil(var_231_4) and arg_228_1.var_.characterEffect10058ui_story == nil then
				arg_228_1.var_.characterEffect10058ui_story = var_231_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_231_6 = 0.200000002980232

			if var_231_5 <= arg_228_1.time_ and arg_228_1.time_ < var_231_5 + var_231_6 and not isNil(var_231_4) then
				local var_231_7 = (arg_228_1.time_ - var_231_5) / var_231_6

				if arg_228_1.var_.characterEffect10058ui_story and not isNil(var_231_4) then
					local var_231_8 = Mathf.Lerp(0, 0.5, var_231_7)

					arg_228_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_228_1.var_.characterEffect10058ui_story.fillRatio = var_231_8
				end
			end

			if arg_228_1.time_ >= var_231_5 + var_231_6 and arg_228_1.time_ < var_231_5 + var_231_6 + arg_231_0 and not isNil(var_231_4) and arg_228_1.var_.characterEffect10058ui_story then
				local var_231_9 = 0.5

				arg_228_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_228_1.var_.characterEffect10058ui_story.fillRatio = var_231_9
			end

			local var_231_10 = 0
			local var_231_11 = 0.675

			if var_231_10 < arg_228_1.time_ and arg_228_1.time_ <= var_231_10 + arg_231_0 then
				arg_228_1.talkMaxDuration = 0
				arg_228_1.dialogCg_.alpha = 1

				arg_228_1.dialog_:SetActive(true)
				SetActive(arg_228_1.leftNameGo_, true)

				local var_231_12 = arg_228_1:FormatText(StoryNameCfg[453].name)

				arg_228_1.leftNameTxt_.text = var_231_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_228_1.leftNameTxt_.transform)

				arg_228_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_228_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_228_1:RecordName(arg_228_1.leftNameTxt_.text)
				SetActive(arg_228_1.iconTrs_.gameObject, false)
				arg_228_1.callingController_:SetSelectedState("normal")

				local var_231_13 = arg_228_1:GetWordFromCfg(319811055)
				local var_231_14 = arg_228_1:FormatText(var_231_13.content)

				arg_228_1.text_.text = var_231_14

				LuaForUtil.ClearLinePrefixSymbol(arg_228_1.text_)

				local var_231_15 = 27
				local var_231_16 = utf8.len(var_231_14)
				local var_231_17 = var_231_15 <= 0 and var_231_11 or var_231_11 * (var_231_16 / var_231_15)

				if var_231_17 > 0 and var_231_11 < var_231_17 then
					arg_228_1.talkMaxDuration = var_231_17

					if var_231_17 + var_231_10 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_17 + var_231_10
					end
				end

				arg_228_1.text_.text = var_231_14
				arg_228_1.typewritter.percent = 0

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319811", "319811055", "story_v_out_319811.awb") ~= 0 then
					local var_231_18 = manager.audio:GetVoiceLength("story_v_out_319811", "319811055", "story_v_out_319811.awb") / 1000

					if var_231_18 + var_231_10 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_18 + var_231_10
					end

					if var_231_13.prefab_name ~= "" and arg_228_1.actors_[var_231_13.prefab_name] ~= nil then
						local var_231_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_228_1.actors_[var_231_13.prefab_name].transform, "story_v_out_319811", "319811055", "story_v_out_319811.awb")

						arg_228_1:RecordAudio("319811055", var_231_19)
						arg_228_1:RecordAudio("319811055", var_231_19)
					else
						arg_228_1:AudioAction("play", "voice", "story_v_out_319811", "319811055", "story_v_out_319811.awb")
					end

					arg_228_1:RecordHistoryTalkVoice("story_v_out_319811", "319811055", "story_v_out_319811.awb")
				end

				arg_228_1:RecordContent(arg_228_1.text_.text)
			end

			local var_231_20 = math.max(var_231_11, arg_228_1.talkMaxDuration)

			if var_231_10 <= arg_228_1.time_ and arg_228_1.time_ < var_231_10 + var_231_20 then
				arg_228_1.typewritter.percent = (arg_228_1.time_ - var_231_10) / var_231_20

				arg_228_1.typewritter:SetDirty()
			end

			if arg_228_1.time_ >= var_231_10 + var_231_20 and arg_228_1.time_ < var_231_10 + var_231_20 + arg_231_0 then
				arg_228_1.typewritter.percent = 1

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(true)
			end
		end

		arg_228_1.nodeConfigList_ = {}

		arg_228_1:InitPlayNodeList()
	end,
	Play319811056 = function(arg_232_0, arg_232_1)
		arg_232_1.time_ = 0
		arg_232_1.frameCnt_ = 0
		arg_232_1.state_ = "playing"
		arg_232_1.curTalkId_ = 319811056
		arg_232_1.duration_ = 4.8

		local var_232_0 = {
			zh = 1.999999999999,
			ja = 4.8
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
				arg_232_0:Play319811057(arg_232_1)
			end
		end

		function arg_232_1.onSingleLineUpdate_(arg_235_0)
			local var_235_0 = arg_232_1.actors_["1084ui_story"].transform
			local var_235_1 = 0

			if var_235_1 < arg_232_1.time_ and arg_232_1.time_ <= var_235_1 + arg_235_0 then
				arg_232_1.var_.moveOldPos1084ui_story = var_235_0.localPosition
			end

			local var_235_2 = 0.001

			if var_235_1 <= arg_232_1.time_ and arg_232_1.time_ < var_235_1 + var_235_2 then
				local var_235_3 = (arg_232_1.time_ - var_235_1) / var_235_2
				local var_235_4 = Vector3.New(0, -0.97, -6)

				var_235_0.localPosition = Vector3.Lerp(arg_232_1.var_.moveOldPos1084ui_story, var_235_4, var_235_3)

				local var_235_5 = manager.ui.mainCamera.transform.position - var_235_0.position

				var_235_0.forward = Vector3.New(var_235_5.x, var_235_5.y, var_235_5.z)

				local var_235_6 = var_235_0.localEulerAngles

				var_235_6.z = 0
				var_235_6.x = 0
				var_235_0.localEulerAngles = var_235_6
			end

			if arg_232_1.time_ >= var_235_1 + var_235_2 and arg_232_1.time_ < var_235_1 + var_235_2 + arg_235_0 then
				var_235_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_235_7 = manager.ui.mainCamera.transform.position - var_235_0.position

				var_235_0.forward = Vector3.New(var_235_7.x, var_235_7.y, var_235_7.z)

				local var_235_8 = var_235_0.localEulerAngles

				var_235_8.z = 0
				var_235_8.x = 0
				var_235_0.localEulerAngles = var_235_8
			end

			local var_235_9 = arg_232_1.actors_["1084ui_story"]
			local var_235_10 = 0

			if var_235_10 < arg_232_1.time_ and arg_232_1.time_ <= var_235_10 + arg_235_0 and not isNil(var_235_9) and arg_232_1.var_.characterEffect1084ui_story == nil then
				arg_232_1.var_.characterEffect1084ui_story = var_235_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_235_11 = 0.200000002980232

			if var_235_10 <= arg_232_1.time_ and arg_232_1.time_ < var_235_10 + var_235_11 and not isNil(var_235_9) then
				local var_235_12 = (arg_232_1.time_ - var_235_10) / var_235_11

				if arg_232_1.var_.characterEffect1084ui_story and not isNil(var_235_9) then
					arg_232_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_232_1.time_ >= var_235_10 + var_235_11 and arg_232_1.time_ < var_235_10 + var_235_11 + arg_235_0 and not isNil(var_235_9) and arg_232_1.var_.characterEffect1084ui_story then
				arg_232_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_235_13 = 0

			if var_235_13 < arg_232_1.time_ and arg_232_1.time_ <= var_235_13 + arg_235_0 then
				arg_232_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_2")
			end

			local var_235_14 = 0

			if var_235_14 < arg_232_1.time_ and arg_232_1.time_ <= var_235_14 + arg_235_0 then
				arg_232_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_235_15 = arg_232_1.actors_["4037ui_story"].transform
			local var_235_16 = 0

			if var_235_16 < arg_232_1.time_ and arg_232_1.time_ <= var_235_16 + arg_235_0 then
				arg_232_1.var_.moveOldPos4037ui_story = var_235_15.localPosition
			end

			local var_235_17 = 0.001

			if var_235_16 <= arg_232_1.time_ and arg_232_1.time_ < var_235_16 + var_235_17 then
				local var_235_18 = (arg_232_1.time_ - var_235_16) / var_235_17
				local var_235_19 = Vector3.New(0, 100, 0)

				var_235_15.localPosition = Vector3.Lerp(arg_232_1.var_.moveOldPos4037ui_story, var_235_19, var_235_18)

				local var_235_20 = manager.ui.mainCamera.transform.position - var_235_15.position

				var_235_15.forward = Vector3.New(var_235_20.x, var_235_20.y, var_235_20.z)

				local var_235_21 = var_235_15.localEulerAngles

				var_235_21.z = 0
				var_235_21.x = 0
				var_235_15.localEulerAngles = var_235_21
			end

			if arg_232_1.time_ >= var_235_16 + var_235_17 and arg_232_1.time_ < var_235_16 + var_235_17 + arg_235_0 then
				var_235_15.localPosition = Vector3.New(0, 100, 0)

				local var_235_22 = manager.ui.mainCamera.transform.position - var_235_15.position

				var_235_15.forward = Vector3.New(var_235_22.x, var_235_22.y, var_235_22.z)

				local var_235_23 = var_235_15.localEulerAngles

				var_235_23.z = 0
				var_235_23.x = 0
				var_235_15.localEulerAngles = var_235_23
			end

			local var_235_24 = arg_232_1.actors_["4037ui_story"]
			local var_235_25 = 0

			if var_235_25 < arg_232_1.time_ and arg_232_1.time_ <= var_235_25 + arg_235_0 and not isNil(var_235_24) and arg_232_1.var_.characterEffect4037ui_story == nil then
				arg_232_1.var_.characterEffect4037ui_story = var_235_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_235_26 = 0.200000002980232

			if var_235_25 <= arg_232_1.time_ and arg_232_1.time_ < var_235_25 + var_235_26 and not isNil(var_235_24) then
				local var_235_27 = (arg_232_1.time_ - var_235_25) / var_235_26

				if arg_232_1.var_.characterEffect4037ui_story and not isNil(var_235_24) then
					local var_235_28 = Mathf.Lerp(0, 0.5, var_235_27)

					arg_232_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_232_1.var_.characterEffect4037ui_story.fillRatio = var_235_28
				end
			end

			if arg_232_1.time_ >= var_235_25 + var_235_26 and arg_232_1.time_ < var_235_25 + var_235_26 + arg_235_0 and not isNil(var_235_24) and arg_232_1.var_.characterEffect4037ui_story then
				local var_235_29 = 0.5

				arg_232_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_232_1.var_.characterEffect4037ui_story.fillRatio = var_235_29
			end

			local var_235_30 = arg_232_1.actors_["10058ui_story"].transform
			local var_235_31 = 0

			if var_235_31 < arg_232_1.time_ and arg_232_1.time_ <= var_235_31 + arg_235_0 then
				arg_232_1.var_.moveOldPos10058ui_story = var_235_30.localPosition
			end

			local var_235_32 = 0.001

			if var_235_31 <= arg_232_1.time_ and arg_232_1.time_ < var_235_31 + var_235_32 then
				local var_235_33 = (arg_232_1.time_ - var_235_31) / var_235_32
				local var_235_34 = Vector3.New(0, 100, 0)

				var_235_30.localPosition = Vector3.Lerp(arg_232_1.var_.moveOldPos10058ui_story, var_235_34, var_235_33)

				local var_235_35 = manager.ui.mainCamera.transform.position - var_235_30.position

				var_235_30.forward = Vector3.New(var_235_35.x, var_235_35.y, var_235_35.z)

				local var_235_36 = var_235_30.localEulerAngles

				var_235_36.z = 0
				var_235_36.x = 0
				var_235_30.localEulerAngles = var_235_36
			end

			if arg_232_1.time_ >= var_235_31 + var_235_32 and arg_232_1.time_ < var_235_31 + var_235_32 + arg_235_0 then
				var_235_30.localPosition = Vector3.New(0, 100, 0)

				local var_235_37 = manager.ui.mainCamera.transform.position - var_235_30.position

				var_235_30.forward = Vector3.New(var_235_37.x, var_235_37.y, var_235_37.z)

				local var_235_38 = var_235_30.localEulerAngles

				var_235_38.z = 0
				var_235_38.x = 0
				var_235_30.localEulerAngles = var_235_38
			end

			local var_235_39 = 0
			local var_235_40 = 0.225

			if var_235_39 < arg_232_1.time_ and arg_232_1.time_ <= var_235_39 + arg_235_0 then
				arg_232_1.talkMaxDuration = 0
				arg_232_1.dialogCg_.alpha = 1

				arg_232_1.dialog_:SetActive(true)
				SetActive(arg_232_1.leftNameGo_, true)

				local var_235_41 = arg_232_1:FormatText(StoryNameCfg[6].name)

				arg_232_1.leftNameTxt_.text = var_235_41

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_232_1.leftNameTxt_.transform)

				arg_232_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_232_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_232_1:RecordName(arg_232_1.leftNameTxt_.text)
				SetActive(arg_232_1.iconTrs_.gameObject, false)
				arg_232_1.callingController_:SetSelectedState("normal")

				local var_235_42 = arg_232_1:GetWordFromCfg(319811056)
				local var_235_43 = arg_232_1:FormatText(var_235_42.content)

				arg_232_1.text_.text = var_235_43

				LuaForUtil.ClearLinePrefixSymbol(arg_232_1.text_)

				local var_235_44 = 9
				local var_235_45 = utf8.len(var_235_43)
				local var_235_46 = var_235_44 <= 0 and var_235_40 or var_235_40 * (var_235_45 / var_235_44)

				if var_235_46 > 0 and var_235_40 < var_235_46 then
					arg_232_1.talkMaxDuration = var_235_46

					if var_235_46 + var_235_39 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_46 + var_235_39
					end
				end

				arg_232_1.text_.text = var_235_43
				arg_232_1.typewritter.percent = 0

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319811", "319811056", "story_v_out_319811.awb") ~= 0 then
					local var_235_47 = manager.audio:GetVoiceLength("story_v_out_319811", "319811056", "story_v_out_319811.awb") / 1000

					if var_235_47 + var_235_39 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_47 + var_235_39
					end

					if var_235_42.prefab_name ~= "" and arg_232_1.actors_[var_235_42.prefab_name] ~= nil then
						local var_235_48 = LuaForUtil.PlayVoiceWithCriLipsync(arg_232_1.actors_[var_235_42.prefab_name].transform, "story_v_out_319811", "319811056", "story_v_out_319811.awb")

						arg_232_1:RecordAudio("319811056", var_235_48)
						arg_232_1:RecordAudio("319811056", var_235_48)
					else
						arg_232_1:AudioAction("play", "voice", "story_v_out_319811", "319811056", "story_v_out_319811.awb")
					end

					arg_232_1:RecordHistoryTalkVoice("story_v_out_319811", "319811056", "story_v_out_319811.awb")
				end

				arg_232_1:RecordContent(arg_232_1.text_.text)
			end

			local var_235_49 = math.max(var_235_40, arg_232_1.talkMaxDuration)

			if var_235_39 <= arg_232_1.time_ and arg_232_1.time_ < var_235_39 + var_235_49 then
				arg_232_1.typewritter.percent = (arg_232_1.time_ - var_235_39) / var_235_49

				arg_232_1.typewritter:SetDirty()
			end

			if arg_232_1.time_ >= var_235_39 + var_235_49 and arg_232_1.time_ < var_235_39 + var_235_49 + arg_235_0 then
				arg_232_1.typewritter.percent = 1

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(true)
			end
		end

		arg_232_1.nodeConfigList_ = {
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
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_232_1:InitPlayNodeList()
	end,
	Play319811057 = function(arg_236_0, arg_236_1)
		arg_236_1.time_ = 0
		arg_236_1.frameCnt_ = 0
		arg_236_1.state_ = "playing"
		arg_236_1.curTalkId_ = 319811057
		arg_236_1.duration_ = 3.2

		local var_236_0 = {
			zh = 3,
			ja = 3.2
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
				arg_236_0:Play319811058(arg_236_1)
			end
		end

		function arg_236_1.onSingleLineUpdate_(arg_239_0)
			local var_239_0 = arg_236_1.actors_["4037ui_story"].transform
			local var_239_1 = 0

			if var_239_1 < arg_236_1.time_ and arg_236_1.time_ <= var_239_1 + arg_239_0 then
				arg_236_1.var_.moveOldPos4037ui_story = var_239_0.localPosition
			end

			local var_239_2 = 0.001

			if var_239_1 <= arg_236_1.time_ and arg_236_1.time_ < var_239_1 + var_239_2 then
				local var_239_3 = (arg_236_1.time_ - var_239_1) / var_239_2
				local var_239_4 = Vector3.New(0, -1.12, -6.2)

				var_239_0.localPosition = Vector3.Lerp(arg_236_1.var_.moveOldPos4037ui_story, var_239_4, var_239_3)

				local var_239_5 = manager.ui.mainCamera.transform.position - var_239_0.position

				var_239_0.forward = Vector3.New(var_239_5.x, var_239_5.y, var_239_5.z)

				local var_239_6 = var_239_0.localEulerAngles

				var_239_6.z = 0
				var_239_6.x = 0
				var_239_0.localEulerAngles = var_239_6
			end

			if arg_236_1.time_ >= var_239_1 + var_239_2 and arg_236_1.time_ < var_239_1 + var_239_2 + arg_239_0 then
				var_239_0.localPosition = Vector3.New(0, -1.12, -6.2)

				local var_239_7 = manager.ui.mainCamera.transform.position - var_239_0.position

				var_239_0.forward = Vector3.New(var_239_7.x, var_239_7.y, var_239_7.z)

				local var_239_8 = var_239_0.localEulerAngles

				var_239_8.z = 0
				var_239_8.x = 0
				var_239_0.localEulerAngles = var_239_8
			end

			local var_239_9 = arg_236_1.actors_["4037ui_story"]
			local var_239_10 = 0

			if var_239_10 < arg_236_1.time_ and arg_236_1.time_ <= var_239_10 + arg_239_0 and not isNil(var_239_9) and arg_236_1.var_.characterEffect4037ui_story == nil then
				arg_236_1.var_.characterEffect4037ui_story = var_239_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_239_11 = 0.200000002980232

			if var_239_10 <= arg_236_1.time_ and arg_236_1.time_ < var_239_10 + var_239_11 and not isNil(var_239_9) then
				local var_239_12 = (arg_236_1.time_ - var_239_10) / var_239_11

				if arg_236_1.var_.characterEffect4037ui_story and not isNil(var_239_9) then
					arg_236_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_236_1.time_ >= var_239_10 + var_239_11 and arg_236_1.time_ < var_239_10 + var_239_11 + arg_239_0 and not isNil(var_239_9) and arg_236_1.var_.characterEffect4037ui_story then
				arg_236_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			local var_239_13 = 0

			if var_239_13 < arg_236_1.time_ and arg_236_1.time_ <= var_239_13 + arg_239_0 then
				arg_236_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037actionlink/4037action423")
			end

			local var_239_14 = 0

			if var_239_14 < arg_236_1.time_ and arg_236_1.time_ <= var_239_14 + arg_239_0 then
				arg_236_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_239_15 = arg_236_1.actors_["1084ui_story"]
			local var_239_16 = 0

			if var_239_16 < arg_236_1.time_ and arg_236_1.time_ <= var_239_16 + arg_239_0 and not isNil(var_239_15) and arg_236_1.var_.characterEffect1084ui_story == nil then
				arg_236_1.var_.characterEffect1084ui_story = var_239_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_239_17 = 0.200000002980232

			if var_239_16 <= arg_236_1.time_ and arg_236_1.time_ < var_239_16 + var_239_17 and not isNil(var_239_15) then
				local var_239_18 = (arg_236_1.time_ - var_239_16) / var_239_17

				if arg_236_1.var_.characterEffect1084ui_story and not isNil(var_239_15) then
					local var_239_19 = Mathf.Lerp(0, 0.5, var_239_18)

					arg_236_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_236_1.var_.characterEffect1084ui_story.fillRatio = var_239_19
				end
			end

			if arg_236_1.time_ >= var_239_16 + var_239_17 and arg_236_1.time_ < var_239_16 + var_239_17 + arg_239_0 and not isNil(var_239_15) and arg_236_1.var_.characterEffect1084ui_story then
				local var_239_20 = 0.5

				arg_236_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_236_1.var_.characterEffect1084ui_story.fillRatio = var_239_20
			end

			local var_239_21 = arg_236_1.actors_["1084ui_story"].transform
			local var_239_22 = 0

			if var_239_22 < arg_236_1.time_ and arg_236_1.time_ <= var_239_22 + arg_239_0 then
				arg_236_1.var_.moveOldPos1084ui_story = var_239_21.localPosition
			end

			local var_239_23 = 0.001

			if var_239_22 <= arg_236_1.time_ and arg_236_1.time_ < var_239_22 + var_239_23 then
				local var_239_24 = (arg_236_1.time_ - var_239_22) / var_239_23
				local var_239_25 = Vector3.New(0, 100, 0)

				var_239_21.localPosition = Vector3.Lerp(arg_236_1.var_.moveOldPos1084ui_story, var_239_25, var_239_24)

				local var_239_26 = manager.ui.mainCamera.transform.position - var_239_21.position

				var_239_21.forward = Vector3.New(var_239_26.x, var_239_26.y, var_239_26.z)

				local var_239_27 = var_239_21.localEulerAngles

				var_239_27.z = 0
				var_239_27.x = 0
				var_239_21.localEulerAngles = var_239_27
			end

			if arg_236_1.time_ >= var_239_22 + var_239_23 and arg_236_1.time_ < var_239_22 + var_239_23 + arg_239_0 then
				var_239_21.localPosition = Vector3.New(0, 100, 0)

				local var_239_28 = manager.ui.mainCamera.transform.position - var_239_21.position

				var_239_21.forward = Vector3.New(var_239_28.x, var_239_28.y, var_239_28.z)

				local var_239_29 = var_239_21.localEulerAngles

				var_239_29.z = 0
				var_239_29.x = 0
				var_239_21.localEulerAngles = var_239_29
			end

			local var_239_30 = 0
			local var_239_31 = 0.2

			if var_239_30 < arg_236_1.time_ and arg_236_1.time_ <= var_239_30 + arg_239_0 then
				arg_236_1.talkMaxDuration = 0
				arg_236_1.dialogCg_.alpha = 1

				arg_236_1.dialog_:SetActive(true)
				SetActive(arg_236_1.leftNameGo_, true)

				local var_239_32 = arg_236_1:FormatText(StoryNameCfg[453].name)

				arg_236_1.leftNameTxt_.text = var_239_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_236_1.leftNameTxt_.transform)

				arg_236_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_236_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_236_1:RecordName(arg_236_1.leftNameTxt_.text)
				SetActive(arg_236_1.iconTrs_.gameObject, false)
				arg_236_1.callingController_:SetSelectedState("normal")

				local var_239_33 = arg_236_1:GetWordFromCfg(319811057)
				local var_239_34 = arg_236_1:FormatText(var_239_33.content)

				arg_236_1.text_.text = var_239_34

				LuaForUtil.ClearLinePrefixSymbol(arg_236_1.text_)

				local var_239_35 = 8
				local var_239_36 = utf8.len(var_239_34)
				local var_239_37 = var_239_35 <= 0 and var_239_31 or var_239_31 * (var_239_36 / var_239_35)

				if var_239_37 > 0 and var_239_31 < var_239_37 then
					arg_236_1.talkMaxDuration = var_239_37

					if var_239_37 + var_239_30 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_37 + var_239_30
					end
				end

				arg_236_1.text_.text = var_239_34
				arg_236_1.typewritter.percent = 0

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319811", "319811057", "story_v_out_319811.awb") ~= 0 then
					local var_239_38 = manager.audio:GetVoiceLength("story_v_out_319811", "319811057", "story_v_out_319811.awb") / 1000

					if var_239_38 + var_239_30 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_38 + var_239_30
					end

					if var_239_33.prefab_name ~= "" and arg_236_1.actors_[var_239_33.prefab_name] ~= nil then
						local var_239_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_236_1.actors_[var_239_33.prefab_name].transform, "story_v_out_319811", "319811057", "story_v_out_319811.awb")

						arg_236_1:RecordAudio("319811057", var_239_39)
						arg_236_1:RecordAudio("319811057", var_239_39)
					else
						arg_236_1:AudioAction("play", "voice", "story_v_out_319811", "319811057", "story_v_out_319811.awb")
					end

					arg_236_1:RecordHistoryTalkVoice("story_v_out_319811", "319811057", "story_v_out_319811.awb")
				end

				arg_236_1:RecordContent(arg_236_1.text_.text)
			end

			local var_239_40 = math.max(var_239_31, arg_236_1.talkMaxDuration)

			if var_239_30 <= arg_236_1.time_ and arg_236_1.time_ < var_239_30 + var_239_40 then
				arg_236_1.typewritter.percent = (arg_236_1.time_ - var_239_30) / var_239_40

				arg_236_1.typewritter:SetDirty()
			end

			if arg_236_1.time_ >= var_239_30 + var_239_40 and arg_236_1.time_ < var_239_30 + var_239_40 + arg_239_0 then
				arg_236_1.typewritter.percent = 1

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(true)
			end
		end

		arg_236_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4037ui_story",
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

		arg_236_1:InitPlayNodeList()
	end,
	Play319811058 = function(arg_240_0, arg_240_1)
		arg_240_1.time_ = 0
		arg_240_1.frameCnt_ = 0
		arg_240_1.state_ = "playing"
		arg_240_1.curTalkId_ = 319811058
		arg_240_1.duration_ = 5

		SetActive(arg_240_1.tipsGo_, false)

		function arg_240_1.onSingleLineFinish_()
			arg_240_1.onSingleLineUpdate_ = nil
			arg_240_1.onSingleLineFinish_ = nil
			arg_240_1.state_ = "waiting"
		end

		function arg_240_1.playNext_(arg_242_0)
			if arg_242_0 == 1 then
				arg_240_0:Play319811059(arg_240_1)
			end
		end

		function arg_240_1.onSingleLineUpdate_(arg_243_0)
			local var_243_0 = arg_240_1.actors_["4037ui_story"].transform
			local var_243_1 = 0

			if var_243_1 < arg_240_1.time_ and arg_240_1.time_ <= var_243_1 + arg_243_0 then
				arg_240_1.var_.moveOldPos4037ui_story = var_243_0.localPosition
			end

			local var_243_2 = 0.001

			if var_243_1 <= arg_240_1.time_ and arg_240_1.time_ < var_243_1 + var_243_2 then
				local var_243_3 = (arg_240_1.time_ - var_243_1) / var_243_2
				local var_243_4 = Vector3.New(0, 100, 0)

				var_243_0.localPosition = Vector3.Lerp(arg_240_1.var_.moveOldPos4037ui_story, var_243_4, var_243_3)

				local var_243_5 = manager.ui.mainCamera.transform.position - var_243_0.position

				var_243_0.forward = Vector3.New(var_243_5.x, var_243_5.y, var_243_5.z)

				local var_243_6 = var_243_0.localEulerAngles

				var_243_6.z = 0
				var_243_6.x = 0
				var_243_0.localEulerAngles = var_243_6
			end

			if arg_240_1.time_ >= var_243_1 + var_243_2 and arg_240_1.time_ < var_243_1 + var_243_2 + arg_243_0 then
				var_243_0.localPosition = Vector3.New(0, 100, 0)

				local var_243_7 = manager.ui.mainCamera.transform.position - var_243_0.position

				var_243_0.forward = Vector3.New(var_243_7.x, var_243_7.y, var_243_7.z)

				local var_243_8 = var_243_0.localEulerAngles

				var_243_8.z = 0
				var_243_8.x = 0
				var_243_0.localEulerAngles = var_243_8
			end

			local var_243_9 = arg_240_1.actors_["4037ui_story"]
			local var_243_10 = 0

			if var_243_10 < arg_240_1.time_ and arg_240_1.time_ <= var_243_10 + arg_243_0 and not isNil(var_243_9) and arg_240_1.var_.characterEffect4037ui_story == nil then
				arg_240_1.var_.characterEffect4037ui_story = var_243_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_243_11 = 0.200000002980232

			if var_243_10 <= arg_240_1.time_ and arg_240_1.time_ < var_243_10 + var_243_11 and not isNil(var_243_9) then
				local var_243_12 = (arg_240_1.time_ - var_243_10) / var_243_11

				if arg_240_1.var_.characterEffect4037ui_story and not isNil(var_243_9) then
					local var_243_13 = Mathf.Lerp(0, 0.5, var_243_12)

					arg_240_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_240_1.var_.characterEffect4037ui_story.fillRatio = var_243_13
				end
			end

			if arg_240_1.time_ >= var_243_10 + var_243_11 and arg_240_1.time_ < var_243_10 + var_243_11 + arg_243_0 and not isNil(var_243_9) and arg_240_1.var_.characterEffect4037ui_story then
				local var_243_14 = 0.5

				arg_240_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_240_1.var_.characterEffect4037ui_story.fillRatio = var_243_14
			end

			local var_243_15 = 0
			local var_243_16 = 1.125

			if var_243_15 < arg_240_1.time_ and arg_240_1.time_ <= var_243_15 + arg_243_0 then
				arg_240_1.talkMaxDuration = 0
				arg_240_1.dialogCg_.alpha = 1

				arg_240_1.dialog_:SetActive(true)
				SetActive(arg_240_1.leftNameGo_, false)

				arg_240_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_240_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_240_1:RecordName(arg_240_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_240_1.iconTrs_.gameObject, false)
				arg_240_1.callingController_:SetSelectedState("normal")

				local var_243_17 = arg_240_1:GetWordFromCfg(319811058)
				local var_243_18 = arg_240_1:FormatText(var_243_17.content)

				arg_240_1.text_.text = var_243_18

				LuaForUtil.ClearLinePrefixSymbol(arg_240_1.text_)

				local var_243_19 = 45
				local var_243_20 = utf8.len(var_243_18)
				local var_243_21 = var_243_19 <= 0 and var_243_16 or var_243_16 * (var_243_20 / var_243_19)

				if var_243_21 > 0 and var_243_16 < var_243_21 then
					arg_240_1.talkMaxDuration = var_243_21

					if var_243_21 + var_243_15 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_21 + var_243_15
					end
				end

				arg_240_1.text_.text = var_243_18
				arg_240_1.typewritter.percent = 0

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(false)
				arg_240_1:RecordContent(arg_240_1.text_.text)
			end

			local var_243_22 = math.max(var_243_16, arg_240_1.talkMaxDuration)

			if var_243_15 <= arg_240_1.time_ and arg_240_1.time_ < var_243_15 + var_243_22 then
				arg_240_1.typewritter.percent = (arg_240_1.time_ - var_243_15) / var_243_22

				arg_240_1.typewritter:SetDirty()
			end

			if arg_240_1.time_ >= var_243_15 + var_243_22 and arg_240_1.time_ < var_243_15 + var_243_22 + arg_243_0 then
				arg_240_1.typewritter.percent = 1

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(true)
			end
		end

		arg_240_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_240_1:InitPlayNodeList()
	end,
	Play319811059 = function(arg_244_0, arg_244_1)
		arg_244_1.time_ = 0
		arg_244_1.frameCnt_ = 0
		arg_244_1.state_ = "playing"
		arg_244_1.curTalkId_ = 319811059
		arg_244_1.duration_ = 4.33

		local var_244_0 = {
			zh = 3.566,
			ja = 4.333
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
				arg_244_0:Play319811060(arg_244_1)
			end
		end

		function arg_244_1.onSingleLineUpdate_(arg_247_0)
			local var_247_0 = arg_244_1.actors_["1084ui_story"].transform
			local var_247_1 = 0

			if var_247_1 < arg_244_1.time_ and arg_244_1.time_ <= var_247_1 + arg_247_0 then
				arg_244_1.var_.moveOldPos1084ui_story = var_247_0.localPosition
			end

			local var_247_2 = 0.001

			if var_247_1 <= arg_244_1.time_ and arg_244_1.time_ < var_247_1 + var_247_2 then
				local var_247_3 = (arg_244_1.time_ - var_247_1) / var_247_2
				local var_247_4 = Vector3.New(0, -0.97, -6)

				var_247_0.localPosition = Vector3.Lerp(arg_244_1.var_.moveOldPos1084ui_story, var_247_4, var_247_3)

				local var_247_5 = manager.ui.mainCamera.transform.position - var_247_0.position

				var_247_0.forward = Vector3.New(var_247_5.x, var_247_5.y, var_247_5.z)

				local var_247_6 = var_247_0.localEulerAngles

				var_247_6.z = 0
				var_247_6.x = 0
				var_247_0.localEulerAngles = var_247_6
			end

			if arg_244_1.time_ >= var_247_1 + var_247_2 and arg_244_1.time_ < var_247_1 + var_247_2 + arg_247_0 then
				var_247_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_247_7 = manager.ui.mainCamera.transform.position - var_247_0.position

				var_247_0.forward = Vector3.New(var_247_7.x, var_247_7.y, var_247_7.z)

				local var_247_8 = var_247_0.localEulerAngles

				var_247_8.z = 0
				var_247_8.x = 0
				var_247_0.localEulerAngles = var_247_8
			end

			local var_247_9 = arg_244_1.actors_["1084ui_story"]
			local var_247_10 = 0

			if var_247_10 < arg_244_1.time_ and arg_244_1.time_ <= var_247_10 + arg_247_0 and not isNil(var_247_9) and arg_244_1.var_.characterEffect1084ui_story == nil then
				arg_244_1.var_.characterEffect1084ui_story = var_247_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_247_11 = 0.200000002980232

			if var_247_10 <= arg_244_1.time_ and arg_244_1.time_ < var_247_10 + var_247_11 and not isNil(var_247_9) then
				local var_247_12 = (arg_244_1.time_ - var_247_10) / var_247_11

				if arg_244_1.var_.characterEffect1084ui_story and not isNil(var_247_9) then
					arg_244_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_244_1.time_ >= var_247_10 + var_247_11 and arg_244_1.time_ < var_247_10 + var_247_11 + arg_247_0 and not isNil(var_247_9) and arg_244_1.var_.characterEffect1084ui_story then
				arg_244_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_247_13 = 0

			if var_247_13 < arg_244_1.time_ and arg_244_1.time_ <= var_247_13 + arg_247_0 then
				arg_244_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action12_1")
			end

			local var_247_14 = 0

			if var_247_14 < arg_244_1.time_ and arg_244_1.time_ <= var_247_14 + arg_247_0 then
				arg_244_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_247_15 = 0
			local var_247_16 = 0.5

			if var_247_15 < arg_244_1.time_ and arg_244_1.time_ <= var_247_15 + arg_247_0 then
				arg_244_1.talkMaxDuration = 0
				arg_244_1.dialogCg_.alpha = 1

				arg_244_1.dialog_:SetActive(true)
				SetActive(arg_244_1.leftNameGo_, true)

				local var_247_17 = arg_244_1:FormatText(StoryNameCfg[6].name)

				arg_244_1.leftNameTxt_.text = var_247_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_244_1.leftNameTxt_.transform)

				arg_244_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_244_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_244_1:RecordName(arg_244_1.leftNameTxt_.text)
				SetActive(arg_244_1.iconTrs_.gameObject, false)
				arg_244_1.callingController_:SetSelectedState("normal")

				local var_247_18 = arg_244_1:GetWordFromCfg(319811059)
				local var_247_19 = arg_244_1:FormatText(var_247_18.content)

				arg_244_1.text_.text = var_247_19

				LuaForUtil.ClearLinePrefixSymbol(arg_244_1.text_)

				local var_247_20 = 20
				local var_247_21 = utf8.len(var_247_19)
				local var_247_22 = var_247_20 <= 0 and var_247_16 or var_247_16 * (var_247_21 / var_247_20)

				if var_247_22 > 0 and var_247_16 < var_247_22 then
					arg_244_1.talkMaxDuration = var_247_22

					if var_247_22 + var_247_15 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_22 + var_247_15
					end
				end

				arg_244_1.text_.text = var_247_19
				arg_244_1.typewritter.percent = 0

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319811", "319811059", "story_v_out_319811.awb") ~= 0 then
					local var_247_23 = manager.audio:GetVoiceLength("story_v_out_319811", "319811059", "story_v_out_319811.awb") / 1000

					if var_247_23 + var_247_15 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_23 + var_247_15
					end

					if var_247_18.prefab_name ~= "" and arg_244_1.actors_[var_247_18.prefab_name] ~= nil then
						local var_247_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_244_1.actors_[var_247_18.prefab_name].transform, "story_v_out_319811", "319811059", "story_v_out_319811.awb")

						arg_244_1:RecordAudio("319811059", var_247_24)
						arg_244_1:RecordAudio("319811059", var_247_24)
					else
						arg_244_1:AudioAction("play", "voice", "story_v_out_319811", "319811059", "story_v_out_319811.awb")
					end

					arg_244_1:RecordHistoryTalkVoice("story_v_out_319811", "319811059", "story_v_out_319811.awb")
				end

				arg_244_1:RecordContent(arg_244_1.text_.text)
			end

			local var_247_25 = math.max(var_247_16, arg_244_1.talkMaxDuration)

			if var_247_15 <= arg_244_1.time_ and arg_244_1.time_ < var_247_15 + var_247_25 then
				arg_244_1.typewritter.percent = (arg_244_1.time_ - var_247_15) / var_247_25

				arg_244_1.typewritter:SetDirty()
			end

			if arg_244_1.time_ >= var_247_15 + var_247_25 and arg_244_1.time_ < var_247_15 + var_247_25 + arg_247_0 then
				arg_244_1.typewritter.percent = 1

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(true)
			end
		end

		arg_244_1.nodeConfigList_ = {
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

		arg_244_1:InitPlayNodeList()
	end,
	Play319811060 = function(arg_248_0, arg_248_1)
		arg_248_1.time_ = 0
		arg_248_1.frameCnt_ = 0
		arg_248_1.state_ = "playing"
		arg_248_1.curTalkId_ = 319811060
		arg_248_1.duration_ = 8.07

		local var_248_0 = {
			zh = 3.166,
			ja = 8.066
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
				arg_248_0:Play319811061(arg_248_1)
			end
		end

		function arg_248_1.onSingleLineUpdate_(arg_251_0)
			local var_251_0 = arg_248_1.actors_["4037ui_story"].transform
			local var_251_1 = 0

			if var_251_1 < arg_248_1.time_ and arg_248_1.time_ <= var_251_1 + arg_251_0 then
				arg_248_1.var_.moveOldPos4037ui_story = var_251_0.localPosition
			end

			local var_251_2 = 0.001

			if var_251_1 <= arg_248_1.time_ and arg_248_1.time_ < var_251_1 + var_251_2 then
				local var_251_3 = (arg_248_1.time_ - var_251_1) / var_251_2
				local var_251_4 = Vector3.New(0.7, -1.12, -6.2)

				var_251_0.localPosition = Vector3.Lerp(arg_248_1.var_.moveOldPos4037ui_story, var_251_4, var_251_3)

				local var_251_5 = manager.ui.mainCamera.transform.position - var_251_0.position

				var_251_0.forward = Vector3.New(var_251_5.x, var_251_5.y, var_251_5.z)

				local var_251_6 = var_251_0.localEulerAngles

				var_251_6.z = 0
				var_251_6.x = 0
				var_251_0.localEulerAngles = var_251_6
			end

			if arg_248_1.time_ >= var_251_1 + var_251_2 and arg_248_1.time_ < var_251_1 + var_251_2 + arg_251_0 then
				var_251_0.localPosition = Vector3.New(0.7, -1.12, -6.2)

				local var_251_7 = manager.ui.mainCamera.transform.position - var_251_0.position

				var_251_0.forward = Vector3.New(var_251_7.x, var_251_7.y, var_251_7.z)

				local var_251_8 = var_251_0.localEulerAngles

				var_251_8.z = 0
				var_251_8.x = 0
				var_251_0.localEulerAngles = var_251_8
			end

			local var_251_9 = arg_248_1.actors_["4037ui_story"]
			local var_251_10 = 0

			if var_251_10 < arg_248_1.time_ and arg_248_1.time_ <= var_251_10 + arg_251_0 and not isNil(var_251_9) and arg_248_1.var_.characterEffect4037ui_story == nil then
				arg_248_1.var_.characterEffect4037ui_story = var_251_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_251_11 = 0.200000002980232

			if var_251_10 <= arg_248_1.time_ and arg_248_1.time_ < var_251_10 + var_251_11 and not isNil(var_251_9) then
				local var_251_12 = (arg_248_1.time_ - var_251_10) / var_251_11

				if arg_248_1.var_.characterEffect4037ui_story and not isNil(var_251_9) then
					arg_248_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_248_1.time_ >= var_251_10 + var_251_11 and arg_248_1.time_ < var_251_10 + var_251_11 + arg_251_0 and not isNil(var_251_9) and arg_248_1.var_.characterEffect4037ui_story then
				arg_248_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			local var_251_13 = arg_248_1.actors_["1084ui_story"].transform
			local var_251_14 = 0

			if var_251_14 < arg_248_1.time_ and arg_248_1.time_ <= var_251_14 + arg_251_0 then
				arg_248_1.var_.moveOldPos1084ui_story = var_251_13.localPosition
			end

			local var_251_15 = 0.001

			if var_251_14 <= arg_248_1.time_ and arg_248_1.time_ < var_251_14 + var_251_15 then
				local var_251_16 = (arg_248_1.time_ - var_251_14) / var_251_15
				local var_251_17 = Vector3.New(-0.7, -0.97, -6)

				var_251_13.localPosition = Vector3.Lerp(arg_248_1.var_.moveOldPos1084ui_story, var_251_17, var_251_16)

				local var_251_18 = manager.ui.mainCamera.transform.position - var_251_13.position

				var_251_13.forward = Vector3.New(var_251_18.x, var_251_18.y, var_251_18.z)

				local var_251_19 = var_251_13.localEulerAngles

				var_251_19.z = 0
				var_251_19.x = 0
				var_251_13.localEulerAngles = var_251_19
			end

			if arg_248_1.time_ >= var_251_14 + var_251_15 and arg_248_1.time_ < var_251_14 + var_251_15 + arg_251_0 then
				var_251_13.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_251_20 = manager.ui.mainCamera.transform.position - var_251_13.position

				var_251_13.forward = Vector3.New(var_251_20.x, var_251_20.y, var_251_20.z)

				local var_251_21 = var_251_13.localEulerAngles

				var_251_21.z = 0
				var_251_21.x = 0
				var_251_13.localEulerAngles = var_251_21
			end

			local var_251_22 = arg_248_1.actors_["1084ui_story"]
			local var_251_23 = 0

			if var_251_23 < arg_248_1.time_ and arg_248_1.time_ <= var_251_23 + arg_251_0 and not isNil(var_251_22) and arg_248_1.var_.characterEffect1084ui_story == nil then
				arg_248_1.var_.characterEffect1084ui_story = var_251_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_251_24 = 0.200000002980232

			if var_251_23 <= arg_248_1.time_ and arg_248_1.time_ < var_251_23 + var_251_24 and not isNil(var_251_22) then
				local var_251_25 = (arg_248_1.time_ - var_251_23) / var_251_24

				if arg_248_1.var_.characterEffect1084ui_story and not isNil(var_251_22) then
					local var_251_26 = Mathf.Lerp(0, 0.5, var_251_25)

					arg_248_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_248_1.var_.characterEffect1084ui_story.fillRatio = var_251_26
				end
			end

			if arg_248_1.time_ >= var_251_23 + var_251_24 and arg_248_1.time_ < var_251_23 + var_251_24 + arg_251_0 and not isNil(var_251_22) and arg_248_1.var_.characterEffect1084ui_story then
				local var_251_27 = 0.5

				arg_248_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_248_1.var_.characterEffect1084ui_story.fillRatio = var_251_27
			end

			local var_251_28 = 0

			if var_251_28 < arg_248_1.time_ and arg_248_1.time_ <= var_251_28 + arg_251_0 then
				arg_248_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action3_2")
			end

			local var_251_29 = 0

			if var_251_29 < arg_248_1.time_ and arg_248_1.time_ <= var_251_29 + arg_251_0 then
				arg_248_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_251_30 = 0
			local var_251_31 = 0.3

			if var_251_30 < arg_248_1.time_ and arg_248_1.time_ <= var_251_30 + arg_251_0 then
				arg_248_1.talkMaxDuration = 0
				arg_248_1.dialogCg_.alpha = 1

				arg_248_1.dialog_:SetActive(true)
				SetActive(arg_248_1.leftNameGo_, true)

				local var_251_32 = arg_248_1:FormatText(StoryNameCfg[453].name)

				arg_248_1.leftNameTxt_.text = var_251_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_248_1.leftNameTxt_.transform)

				arg_248_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_248_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_248_1:RecordName(arg_248_1.leftNameTxt_.text)
				SetActive(arg_248_1.iconTrs_.gameObject, false)
				arg_248_1.callingController_:SetSelectedState("normal")

				local var_251_33 = arg_248_1:GetWordFromCfg(319811060)
				local var_251_34 = arg_248_1:FormatText(var_251_33.content)

				arg_248_1.text_.text = var_251_34

				LuaForUtil.ClearLinePrefixSymbol(arg_248_1.text_)

				local var_251_35 = 12
				local var_251_36 = utf8.len(var_251_34)
				local var_251_37 = var_251_35 <= 0 and var_251_31 or var_251_31 * (var_251_36 / var_251_35)

				if var_251_37 > 0 and var_251_31 < var_251_37 then
					arg_248_1.talkMaxDuration = var_251_37

					if var_251_37 + var_251_30 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_37 + var_251_30
					end
				end

				arg_248_1.text_.text = var_251_34
				arg_248_1.typewritter.percent = 0

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319811", "319811060", "story_v_out_319811.awb") ~= 0 then
					local var_251_38 = manager.audio:GetVoiceLength("story_v_out_319811", "319811060", "story_v_out_319811.awb") / 1000

					if var_251_38 + var_251_30 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_38 + var_251_30
					end

					if var_251_33.prefab_name ~= "" and arg_248_1.actors_[var_251_33.prefab_name] ~= nil then
						local var_251_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_248_1.actors_[var_251_33.prefab_name].transform, "story_v_out_319811", "319811060", "story_v_out_319811.awb")

						arg_248_1:RecordAudio("319811060", var_251_39)
						arg_248_1:RecordAudio("319811060", var_251_39)
					else
						arg_248_1:AudioAction("play", "voice", "story_v_out_319811", "319811060", "story_v_out_319811.awb")
					end

					arg_248_1:RecordHistoryTalkVoice("story_v_out_319811", "319811060", "story_v_out_319811.awb")
				end

				arg_248_1:RecordContent(arg_248_1.text_.text)
			end

			local var_251_40 = math.max(var_251_31, arg_248_1.talkMaxDuration)

			if var_251_30 <= arg_248_1.time_ and arg_248_1.time_ < var_251_30 + var_251_40 then
				arg_248_1.typewritter.percent = (arg_248_1.time_ - var_251_30) / var_251_40

				arg_248_1.typewritter:SetDirty()
			end

			if arg_248_1.time_ >= var_251_30 + var_251_40 and arg_248_1.time_ < var_251_30 + var_251_40 + arg_251_0 then
				arg_248_1.typewritter.percent = 1

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(true)
			end
		end

		arg_248_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4037ui_story",
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

		arg_248_1:InitPlayNodeList()
	end,
	Play319811061 = function(arg_252_0, arg_252_1)
		arg_252_1.time_ = 0
		arg_252_1.frameCnt_ = 0
		arg_252_1.state_ = "playing"
		arg_252_1.curTalkId_ = 319811061
		arg_252_1.duration_ = 2

		SetActive(arg_252_1.tipsGo_, false)

		function arg_252_1.onSingleLineFinish_()
			arg_252_1.onSingleLineUpdate_ = nil
			arg_252_1.onSingleLineFinish_ = nil
			arg_252_1.state_ = "waiting"
		end

		function arg_252_1.playNext_(arg_254_0)
			if arg_254_0 == 1 then
				arg_252_0:Play319811062(arg_252_1)
			end
		end

		function arg_252_1.onSingleLineUpdate_(arg_255_0)
			local var_255_0 = arg_252_1.actors_["1084ui_story"]
			local var_255_1 = 0

			if var_255_1 < arg_252_1.time_ and arg_252_1.time_ <= var_255_1 + arg_255_0 and not isNil(var_255_0) and arg_252_1.var_.characterEffect1084ui_story == nil then
				arg_252_1.var_.characterEffect1084ui_story = var_255_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_255_2 = 0.200000002980232

			if var_255_1 <= arg_252_1.time_ and arg_252_1.time_ < var_255_1 + var_255_2 and not isNil(var_255_0) then
				local var_255_3 = (arg_252_1.time_ - var_255_1) / var_255_2

				if arg_252_1.var_.characterEffect1084ui_story and not isNil(var_255_0) then
					arg_252_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_252_1.time_ >= var_255_1 + var_255_2 and arg_252_1.time_ < var_255_1 + var_255_2 + arg_255_0 and not isNil(var_255_0) and arg_252_1.var_.characterEffect1084ui_story then
				arg_252_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_255_4 = 0

			if var_255_4 < arg_252_1.time_ and arg_252_1.time_ <= var_255_4 + arg_255_0 then
				arg_252_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action12_2")
			end

			local var_255_5 = 0

			if var_255_5 < arg_252_1.time_ and arg_252_1.time_ <= var_255_5 + arg_255_0 then
				arg_252_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2202cva")
			end

			local var_255_6 = arg_252_1.actors_["4037ui_story"]
			local var_255_7 = 0

			if var_255_7 < arg_252_1.time_ and arg_252_1.time_ <= var_255_7 + arg_255_0 and not isNil(var_255_6) and arg_252_1.var_.characterEffect4037ui_story == nil then
				arg_252_1.var_.characterEffect4037ui_story = var_255_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_255_8 = 0.200000002980232

			if var_255_7 <= arg_252_1.time_ and arg_252_1.time_ < var_255_7 + var_255_8 and not isNil(var_255_6) then
				local var_255_9 = (arg_252_1.time_ - var_255_7) / var_255_8

				if arg_252_1.var_.characterEffect4037ui_story and not isNil(var_255_6) then
					local var_255_10 = Mathf.Lerp(0, 0.5, var_255_9)

					arg_252_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_252_1.var_.characterEffect4037ui_story.fillRatio = var_255_10
				end
			end

			if arg_252_1.time_ >= var_255_7 + var_255_8 and arg_252_1.time_ < var_255_7 + var_255_8 + arg_255_0 and not isNil(var_255_6) and arg_252_1.var_.characterEffect4037ui_story then
				local var_255_11 = 0.5

				arg_252_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_252_1.var_.characterEffect4037ui_story.fillRatio = var_255_11
			end

			local var_255_12 = 0
			local var_255_13 = 0.05

			if var_255_12 < arg_252_1.time_ and arg_252_1.time_ <= var_255_12 + arg_255_0 then
				arg_252_1.talkMaxDuration = 0
				arg_252_1.dialogCg_.alpha = 1

				arg_252_1.dialog_:SetActive(true)
				SetActive(arg_252_1.leftNameGo_, true)

				local var_255_14 = arg_252_1:FormatText(StoryNameCfg[6].name)

				arg_252_1.leftNameTxt_.text = var_255_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_252_1.leftNameTxt_.transform)

				arg_252_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_252_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_252_1:RecordName(arg_252_1.leftNameTxt_.text)
				SetActive(arg_252_1.iconTrs_.gameObject, false)
				arg_252_1.callingController_:SetSelectedState("normal")

				local var_255_15 = arg_252_1:GetWordFromCfg(319811061)
				local var_255_16 = arg_252_1:FormatText(var_255_15.content)

				arg_252_1.text_.text = var_255_16

				LuaForUtil.ClearLinePrefixSymbol(arg_252_1.text_)

				local var_255_17 = 2
				local var_255_18 = utf8.len(var_255_16)
				local var_255_19 = var_255_17 <= 0 and var_255_13 or var_255_13 * (var_255_18 / var_255_17)

				if var_255_19 > 0 and var_255_13 < var_255_19 then
					arg_252_1.talkMaxDuration = var_255_19

					if var_255_19 + var_255_12 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_19 + var_255_12
					end
				end

				arg_252_1.text_.text = var_255_16
				arg_252_1.typewritter.percent = 0

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319811", "319811061", "story_v_out_319811.awb") ~= 0 then
					local var_255_20 = manager.audio:GetVoiceLength("story_v_out_319811", "319811061", "story_v_out_319811.awb") / 1000

					if var_255_20 + var_255_12 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_20 + var_255_12
					end

					if var_255_15.prefab_name ~= "" and arg_252_1.actors_[var_255_15.prefab_name] ~= nil then
						local var_255_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_252_1.actors_[var_255_15.prefab_name].transform, "story_v_out_319811", "319811061", "story_v_out_319811.awb")

						arg_252_1:RecordAudio("319811061", var_255_21)
						arg_252_1:RecordAudio("319811061", var_255_21)
					else
						arg_252_1:AudioAction("play", "voice", "story_v_out_319811", "319811061", "story_v_out_319811.awb")
					end

					arg_252_1:RecordHistoryTalkVoice("story_v_out_319811", "319811061", "story_v_out_319811.awb")
				end

				arg_252_1:RecordContent(arg_252_1.text_.text)
			end

			local var_255_22 = math.max(var_255_13, arg_252_1.talkMaxDuration)

			if var_255_12 <= arg_252_1.time_ and arg_252_1.time_ < var_255_12 + var_255_22 then
				arg_252_1.typewritter.percent = (arg_252_1.time_ - var_255_12) / var_255_22

				arg_252_1.typewritter:SetDirty()
			end

			if arg_252_1.time_ >= var_255_12 + var_255_22 and arg_252_1.time_ < var_255_12 + var_255_22 + arg_255_0 then
				arg_252_1.typewritter.percent = 1

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(true)
			end
		end

		arg_252_1.nodeConfigList_ = {}

		arg_252_1:InitPlayNodeList()
	end,
	Play319811062 = function(arg_256_0, arg_256_1)
		arg_256_1.time_ = 0
		arg_256_1.frameCnt_ = 0
		arg_256_1.state_ = "playing"
		arg_256_1.curTalkId_ = 319811062
		arg_256_1.duration_ = 4.8

		local var_256_0 = {
			zh = 1.999999999999,
			ja = 4.8
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
				arg_256_0:Play319811063(arg_256_1)
			end
		end

		function arg_256_1.onSingleLineUpdate_(arg_259_0)
			local var_259_0 = arg_256_1.actors_["4037ui_story"].transform
			local var_259_1 = 0

			if var_259_1 < arg_256_1.time_ and arg_256_1.time_ <= var_259_1 + arg_259_0 then
				arg_256_1.var_.moveOldPos4037ui_story = var_259_0.localPosition
			end

			local var_259_2 = 0.001

			if var_259_1 <= arg_256_1.time_ and arg_256_1.time_ < var_259_1 + var_259_2 then
				local var_259_3 = (arg_256_1.time_ - var_259_1) / var_259_2
				local var_259_4 = Vector3.New(0, -1.12, -6.2)

				var_259_0.localPosition = Vector3.Lerp(arg_256_1.var_.moveOldPos4037ui_story, var_259_4, var_259_3)

				local var_259_5 = manager.ui.mainCamera.transform.position - var_259_0.position

				var_259_0.forward = Vector3.New(var_259_5.x, var_259_5.y, var_259_5.z)

				local var_259_6 = var_259_0.localEulerAngles

				var_259_6.z = 0
				var_259_6.x = 0
				var_259_0.localEulerAngles = var_259_6
			end

			if arg_256_1.time_ >= var_259_1 + var_259_2 and arg_256_1.time_ < var_259_1 + var_259_2 + arg_259_0 then
				var_259_0.localPosition = Vector3.New(0, -1.12, -6.2)

				local var_259_7 = manager.ui.mainCamera.transform.position - var_259_0.position

				var_259_0.forward = Vector3.New(var_259_7.x, var_259_7.y, var_259_7.z)

				local var_259_8 = var_259_0.localEulerAngles

				var_259_8.z = 0
				var_259_8.x = 0
				var_259_0.localEulerAngles = var_259_8
			end

			local var_259_9 = arg_256_1.actors_["4037ui_story"]
			local var_259_10 = 0

			if var_259_10 < arg_256_1.time_ and arg_256_1.time_ <= var_259_10 + arg_259_0 and not isNil(var_259_9) and arg_256_1.var_.characterEffect4037ui_story == nil then
				arg_256_1.var_.characterEffect4037ui_story = var_259_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_259_11 = 0.200000002980232

			if var_259_10 <= arg_256_1.time_ and arg_256_1.time_ < var_259_10 + var_259_11 and not isNil(var_259_9) then
				local var_259_12 = (arg_256_1.time_ - var_259_10) / var_259_11

				if arg_256_1.var_.characterEffect4037ui_story and not isNil(var_259_9) then
					arg_256_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_256_1.time_ >= var_259_10 + var_259_11 and arg_256_1.time_ < var_259_10 + var_259_11 + arg_259_0 and not isNil(var_259_9) and arg_256_1.var_.characterEffect4037ui_story then
				arg_256_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			local var_259_13 = 0

			if var_259_13 < arg_256_1.time_ and arg_256_1.time_ <= var_259_13 + arg_259_0 then
				arg_256_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2201cva")
			end

			local var_259_14 = arg_256_1.actors_["1084ui_story"].transform
			local var_259_15 = 0

			if var_259_15 < arg_256_1.time_ and arg_256_1.time_ <= var_259_15 + arg_259_0 then
				arg_256_1.var_.moveOldPos1084ui_story = var_259_14.localPosition
			end

			local var_259_16 = 0.001

			if var_259_15 <= arg_256_1.time_ and arg_256_1.time_ < var_259_15 + var_259_16 then
				local var_259_17 = (arg_256_1.time_ - var_259_15) / var_259_16
				local var_259_18 = Vector3.New(0, 100, 0)

				var_259_14.localPosition = Vector3.Lerp(arg_256_1.var_.moveOldPos1084ui_story, var_259_18, var_259_17)

				local var_259_19 = manager.ui.mainCamera.transform.position - var_259_14.position

				var_259_14.forward = Vector3.New(var_259_19.x, var_259_19.y, var_259_19.z)

				local var_259_20 = var_259_14.localEulerAngles

				var_259_20.z = 0
				var_259_20.x = 0
				var_259_14.localEulerAngles = var_259_20
			end

			if arg_256_1.time_ >= var_259_15 + var_259_16 and arg_256_1.time_ < var_259_15 + var_259_16 + arg_259_0 then
				var_259_14.localPosition = Vector3.New(0, 100, 0)

				local var_259_21 = manager.ui.mainCamera.transform.position - var_259_14.position

				var_259_14.forward = Vector3.New(var_259_21.x, var_259_21.y, var_259_21.z)

				local var_259_22 = var_259_14.localEulerAngles

				var_259_22.z = 0
				var_259_22.x = 0
				var_259_14.localEulerAngles = var_259_22
			end

			local var_259_23 = arg_256_1.actors_["1084ui_story"]
			local var_259_24 = 0

			if var_259_24 < arg_256_1.time_ and arg_256_1.time_ <= var_259_24 + arg_259_0 and not isNil(var_259_23) and arg_256_1.var_.characterEffect1084ui_story == nil then
				arg_256_1.var_.characterEffect1084ui_story = var_259_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_259_25 = 0.200000002980232

			if var_259_24 <= arg_256_1.time_ and arg_256_1.time_ < var_259_24 + var_259_25 and not isNil(var_259_23) then
				local var_259_26 = (arg_256_1.time_ - var_259_24) / var_259_25

				if arg_256_1.var_.characterEffect1084ui_story and not isNil(var_259_23) then
					local var_259_27 = Mathf.Lerp(0, 0.5, var_259_26)

					arg_256_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_256_1.var_.characterEffect1084ui_story.fillRatio = var_259_27
				end
			end

			if arg_256_1.time_ >= var_259_24 + var_259_25 and arg_256_1.time_ < var_259_24 + var_259_25 + arg_259_0 and not isNil(var_259_23) and arg_256_1.var_.characterEffect1084ui_story then
				local var_259_28 = 0.5

				arg_256_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_256_1.var_.characterEffect1084ui_story.fillRatio = var_259_28
			end

			local var_259_29 = 0
			local var_259_30 = 0.075

			if var_259_29 < arg_256_1.time_ and arg_256_1.time_ <= var_259_29 + arg_259_0 then
				arg_256_1.talkMaxDuration = 0
				arg_256_1.dialogCg_.alpha = 1

				arg_256_1.dialog_:SetActive(true)
				SetActive(arg_256_1.leftNameGo_, true)

				local var_259_31 = arg_256_1:FormatText(StoryNameCfg[453].name)

				arg_256_1.leftNameTxt_.text = var_259_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_256_1.leftNameTxt_.transform)

				arg_256_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_256_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_256_1:RecordName(arg_256_1.leftNameTxt_.text)
				SetActive(arg_256_1.iconTrs_.gameObject, false)
				arg_256_1.callingController_:SetSelectedState("normal")

				local var_259_32 = arg_256_1:GetWordFromCfg(319811062)
				local var_259_33 = arg_256_1:FormatText(var_259_32.content)

				arg_256_1.text_.text = var_259_33

				LuaForUtil.ClearLinePrefixSymbol(arg_256_1.text_)

				local var_259_34 = 3
				local var_259_35 = utf8.len(var_259_33)
				local var_259_36 = var_259_34 <= 0 and var_259_30 or var_259_30 * (var_259_35 / var_259_34)

				if var_259_36 > 0 and var_259_30 < var_259_36 then
					arg_256_1.talkMaxDuration = var_259_36

					if var_259_36 + var_259_29 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_36 + var_259_29
					end
				end

				arg_256_1.text_.text = var_259_33
				arg_256_1.typewritter.percent = 0

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319811", "319811062", "story_v_out_319811.awb") ~= 0 then
					local var_259_37 = manager.audio:GetVoiceLength("story_v_out_319811", "319811062", "story_v_out_319811.awb") / 1000

					if var_259_37 + var_259_29 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_37 + var_259_29
					end

					if var_259_32.prefab_name ~= "" and arg_256_1.actors_[var_259_32.prefab_name] ~= nil then
						local var_259_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_256_1.actors_[var_259_32.prefab_name].transform, "story_v_out_319811", "319811062", "story_v_out_319811.awb")

						arg_256_1:RecordAudio("319811062", var_259_38)
						arg_256_1:RecordAudio("319811062", var_259_38)
					else
						arg_256_1:AudioAction("play", "voice", "story_v_out_319811", "319811062", "story_v_out_319811.awb")
					end

					arg_256_1:RecordHistoryTalkVoice("story_v_out_319811", "319811062", "story_v_out_319811.awb")
				end

				arg_256_1:RecordContent(arg_256_1.text_.text)
			end

			local var_259_39 = math.max(var_259_30, arg_256_1.talkMaxDuration)

			if var_259_29 <= arg_256_1.time_ and arg_256_1.time_ < var_259_29 + var_259_39 then
				arg_256_1.typewritter.percent = (arg_256_1.time_ - var_259_29) / var_259_39

				arg_256_1.typewritter:SetDirty()
			end

			if arg_256_1.time_ >= var_259_29 + var_259_39 and arg_256_1.time_ < var_259_29 + var_259_39 + arg_259_0 then
				arg_256_1.typewritter.percent = 1

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(true)
			end
		end

		arg_256_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4037ui_story",
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

		arg_256_1:InitPlayNodeList()
	end,
	Play319811063 = function(arg_260_0, arg_260_1)
		arg_260_1.time_ = 0
		arg_260_1.frameCnt_ = 0
		arg_260_1.state_ = "playing"
		arg_260_1.curTalkId_ = 319811063
		arg_260_1.duration_ = 3.1

		local var_260_0 = {
			zh = 3.1,
			ja = 2.033
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
				arg_260_0:Play319811064(arg_260_1)
			end
		end

		function arg_260_1.onSingleLineUpdate_(arg_263_0)
			local var_263_0 = 0
			local var_263_1 = 0.25

			if var_263_0 < arg_260_1.time_ and arg_260_1.time_ <= var_263_0 + arg_263_0 then
				arg_260_1.talkMaxDuration = 0
				arg_260_1.dialogCg_.alpha = 1

				arg_260_1.dialog_:SetActive(true)
				SetActive(arg_260_1.leftNameGo_, true)

				local var_263_2 = arg_260_1:FormatText(StoryNameCfg[453].name)

				arg_260_1.leftNameTxt_.text = var_263_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_260_1.leftNameTxt_.transform)

				arg_260_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_260_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_260_1:RecordName(arg_260_1.leftNameTxt_.text)
				SetActive(arg_260_1.iconTrs_.gameObject, false)
				arg_260_1.callingController_:SetSelectedState("normal")

				local var_263_3 = arg_260_1:GetWordFromCfg(319811063)
				local var_263_4 = arg_260_1:FormatText(var_263_3.content)

				arg_260_1.text_.text = var_263_4

				LuaForUtil.ClearLinePrefixSymbol(arg_260_1.text_)

				local var_263_5 = 10
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

				if manager.audio:GetVoiceLength("story_v_out_319811", "319811063", "story_v_out_319811.awb") ~= 0 then
					local var_263_8 = manager.audio:GetVoiceLength("story_v_out_319811", "319811063", "story_v_out_319811.awb") / 1000

					if var_263_8 + var_263_0 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_8 + var_263_0
					end

					if var_263_3.prefab_name ~= "" and arg_260_1.actors_[var_263_3.prefab_name] ~= nil then
						local var_263_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_260_1.actors_[var_263_3.prefab_name].transform, "story_v_out_319811", "319811063", "story_v_out_319811.awb")

						arg_260_1:RecordAudio("319811063", var_263_9)
						arg_260_1:RecordAudio("319811063", var_263_9)
					else
						arg_260_1:AudioAction("play", "voice", "story_v_out_319811", "319811063", "story_v_out_319811.awb")
					end

					arg_260_1:RecordHistoryTalkVoice("story_v_out_319811", "319811063", "story_v_out_319811.awb")
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
	Play319811064 = function(arg_264_0, arg_264_1)
		arg_264_1.time_ = 0
		arg_264_1.frameCnt_ = 0
		arg_264_1.state_ = "playing"
		arg_264_1.curTalkId_ = 319811064
		arg_264_1.duration_ = 5

		SetActive(arg_264_1.tipsGo_, false)

		function arg_264_1.onSingleLineFinish_()
			arg_264_1.onSingleLineUpdate_ = nil
			arg_264_1.onSingleLineFinish_ = nil
			arg_264_1.state_ = "waiting"
		end

		function arg_264_1.playNext_(arg_266_0)
			if arg_266_0 == 1 then
				arg_264_0:Play319811065(arg_264_1)
			end
		end

		function arg_264_1.onSingleLineUpdate_(arg_267_0)
			local var_267_0 = arg_264_1.actors_["4037ui_story"].transform
			local var_267_1 = 0

			if var_267_1 < arg_264_1.time_ and arg_264_1.time_ <= var_267_1 + arg_267_0 then
				arg_264_1.var_.moveOldPos4037ui_story = var_267_0.localPosition
			end

			local var_267_2 = 0.001

			if var_267_1 <= arg_264_1.time_ and arg_264_1.time_ < var_267_1 + var_267_2 then
				local var_267_3 = (arg_264_1.time_ - var_267_1) / var_267_2
				local var_267_4 = Vector3.New(0, 100, 0)

				var_267_0.localPosition = Vector3.Lerp(arg_264_1.var_.moveOldPos4037ui_story, var_267_4, var_267_3)

				local var_267_5 = manager.ui.mainCamera.transform.position - var_267_0.position

				var_267_0.forward = Vector3.New(var_267_5.x, var_267_5.y, var_267_5.z)

				local var_267_6 = var_267_0.localEulerAngles

				var_267_6.z = 0
				var_267_6.x = 0
				var_267_0.localEulerAngles = var_267_6
			end

			if arg_264_1.time_ >= var_267_1 + var_267_2 and arg_264_1.time_ < var_267_1 + var_267_2 + arg_267_0 then
				var_267_0.localPosition = Vector3.New(0, 100, 0)

				local var_267_7 = manager.ui.mainCamera.transform.position - var_267_0.position

				var_267_0.forward = Vector3.New(var_267_7.x, var_267_7.y, var_267_7.z)

				local var_267_8 = var_267_0.localEulerAngles

				var_267_8.z = 0
				var_267_8.x = 0
				var_267_0.localEulerAngles = var_267_8
			end

			local var_267_9 = arg_264_1.actors_["4037ui_story"]
			local var_267_10 = 0

			if var_267_10 < arg_264_1.time_ and arg_264_1.time_ <= var_267_10 + arg_267_0 and not isNil(var_267_9) and arg_264_1.var_.characterEffect4037ui_story == nil then
				arg_264_1.var_.characterEffect4037ui_story = var_267_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_267_11 = 0.200000002980232

			if var_267_10 <= arg_264_1.time_ and arg_264_1.time_ < var_267_10 + var_267_11 and not isNil(var_267_9) then
				local var_267_12 = (arg_264_1.time_ - var_267_10) / var_267_11

				if arg_264_1.var_.characterEffect4037ui_story and not isNil(var_267_9) then
					local var_267_13 = Mathf.Lerp(0, 0.5, var_267_12)

					arg_264_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_264_1.var_.characterEffect4037ui_story.fillRatio = var_267_13
				end
			end

			if arg_264_1.time_ >= var_267_10 + var_267_11 and arg_264_1.time_ < var_267_10 + var_267_11 + arg_267_0 and not isNil(var_267_9) and arg_264_1.var_.characterEffect4037ui_story then
				local var_267_14 = 0.5

				arg_264_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_264_1.var_.characterEffect4037ui_story.fillRatio = var_267_14
			end

			local var_267_15 = 0
			local var_267_16 = 0.875

			if var_267_15 < arg_264_1.time_ and arg_264_1.time_ <= var_267_15 + arg_267_0 then
				arg_264_1.talkMaxDuration = 0
				arg_264_1.dialogCg_.alpha = 1

				arg_264_1.dialog_:SetActive(true)
				SetActive(arg_264_1.leftNameGo_, false)

				arg_264_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_264_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_264_1:RecordName(arg_264_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_264_1.iconTrs_.gameObject, false)
				arg_264_1.callingController_:SetSelectedState("normal")

				local var_267_17 = arg_264_1:GetWordFromCfg(319811064)
				local var_267_18 = arg_264_1:FormatText(var_267_17.content)

				arg_264_1.text_.text = var_267_18

				LuaForUtil.ClearLinePrefixSymbol(arg_264_1.text_)

				local var_267_19 = 35
				local var_267_20 = utf8.len(var_267_18)
				local var_267_21 = var_267_19 <= 0 and var_267_16 or var_267_16 * (var_267_20 / var_267_19)

				if var_267_21 > 0 and var_267_16 < var_267_21 then
					arg_264_1.talkMaxDuration = var_267_21

					if var_267_21 + var_267_15 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_21 + var_267_15
					end
				end

				arg_264_1.text_.text = var_267_18
				arg_264_1.typewritter.percent = 0

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(false)
				arg_264_1:RecordContent(arg_264_1.text_.text)
			end

			local var_267_22 = math.max(var_267_16, arg_264_1.talkMaxDuration)

			if var_267_15 <= arg_264_1.time_ and arg_264_1.time_ < var_267_15 + var_267_22 then
				arg_264_1.typewritter.percent = (arg_264_1.time_ - var_267_15) / var_267_22

				arg_264_1.typewritter:SetDirty()
			end

			if arg_264_1.time_ >= var_267_15 + var_267_22 and arg_264_1.time_ < var_267_15 + var_267_22 + arg_267_0 then
				arg_264_1.typewritter.percent = 1

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(true)
			end
		end

		arg_264_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_264_1:InitPlayNodeList()
	end,
	Play319811065 = function(arg_268_0, arg_268_1)
		arg_268_1.time_ = 0
		arg_268_1.frameCnt_ = 0
		arg_268_1.state_ = "playing"
		arg_268_1.curTalkId_ = 319811065
		arg_268_1.duration_ = 7.47

		SetActive(arg_268_1.tipsGo_, false)

		function arg_268_1.onSingleLineFinish_()
			arg_268_1.onSingleLineUpdate_ = nil
			arg_268_1.onSingleLineFinish_ = nil
			arg_268_1.state_ = "waiting"
		end

		function arg_268_1.playNext_(arg_270_0)
			if arg_270_0 == 1 then
				arg_268_0:Play319811066(arg_268_1)
			end
		end

		function arg_268_1.onSingleLineUpdate_(arg_271_0)
			local var_271_0 = 1

			if var_271_0 < arg_268_1.time_ and arg_268_1.time_ <= var_271_0 + arg_271_0 then
				local var_271_1 = manager.ui.mainCamera.transform.localPosition
				local var_271_2 = Vector3.New(0, 0, 10) + Vector3.New(var_271_1.x, var_271_1.y, 0)
				local var_271_3 = arg_268_1.bgs_.ST72a

				var_271_3.transform.localPosition = var_271_2
				var_271_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_271_4 = var_271_3:GetComponent("SpriteRenderer")

				if var_271_4 and var_271_4.sprite then
					local var_271_5 = (var_271_3.transform.localPosition - var_271_1).z
					local var_271_6 = manager.ui.mainCameraCom_
					local var_271_7 = 2 * var_271_5 * Mathf.Tan(var_271_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_271_8 = var_271_7 * var_271_6.aspect
					local var_271_9 = var_271_4.sprite.bounds.size.x
					local var_271_10 = var_271_4.sprite.bounds.size.y
					local var_271_11 = var_271_8 / var_271_9
					local var_271_12 = var_271_7 / var_271_10
					local var_271_13 = var_271_12 < var_271_11 and var_271_11 or var_271_12

					var_271_3.transform.localScale = Vector3.New(var_271_13, var_271_13, 0)
				end

				for iter_271_0, iter_271_1 in pairs(arg_268_1.bgs_) do
					if iter_271_0 ~= "ST72a" then
						iter_271_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_271_14 = 0

			if var_271_14 < arg_268_1.time_ and arg_268_1.time_ <= var_271_14 + arg_271_0 then
				arg_268_1.mask_.enabled = true
				arg_268_1.mask_.raycastTarget = true

				arg_268_1:SetGaussion(false)
			end

			local var_271_15 = 1

			if var_271_14 <= arg_268_1.time_ and arg_268_1.time_ < var_271_14 + var_271_15 then
				local var_271_16 = (arg_268_1.time_ - var_271_14) / var_271_15
				local var_271_17 = Color.New(0, 0, 0)

				var_271_17.a = Mathf.Lerp(0, 1, var_271_16)
				arg_268_1.mask_.color = var_271_17
			end

			if arg_268_1.time_ >= var_271_14 + var_271_15 and arg_268_1.time_ < var_271_14 + var_271_15 + arg_271_0 then
				local var_271_18 = Color.New(0, 0, 0)

				var_271_18.a = 1
				arg_268_1.mask_.color = var_271_18
			end

			local var_271_19 = 1

			if var_271_19 < arg_268_1.time_ and arg_268_1.time_ <= var_271_19 + arg_271_0 then
				arg_268_1.mask_.enabled = true
				arg_268_1.mask_.raycastTarget = true

				arg_268_1:SetGaussion(false)
			end

			local var_271_20 = 1.66666666666667

			if var_271_19 <= arg_268_1.time_ and arg_268_1.time_ < var_271_19 + var_271_20 then
				local var_271_21 = (arg_268_1.time_ - var_271_19) / var_271_20
				local var_271_22 = Color.New(0, 0, 0)

				var_271_22.a = Mathf.Lerp(1, 0, var_271_21)
				arg_268_1.mask_.color = var_271_22
			end

			if arg_268_1.time_ >= var_271_19 + var_271_20 and arg_268_1.time_ < var_271_19 + var_271_20 + arg_271_0 then
				local var_271_23 = Color.New(0, 0, 0)
				local var_271_24 = 0

				arg_268_1.mask_.enabled = false
				var_271_23.a = var_271_24
				arg_268_1.mask_.color = var_271_23
			end

			if arg_268_1.frameCnt_ <= 1 then
				arg_268_1.dialog_:SetActive(false)
			end

			local var_271_25 = 2.46666666666667
			local var_271_26 = 1.175

			if var_271_25 < arg_268_1.time_ and arg_268_1.time_ <= var_271_25 + arg_271_0 then
				arg_268_1.talkMaxDuration = 0

				arg_268_1.dialog_:SetActive(true)

				arg_268_1.dialogCg_.alpha = 0

				local var_271_27 = LeanTween.value(arg_268_1.dialog_, 0, 1, 0.3)

				var_271_27:setOnUpdate(LuaHelper.FloatAction(function(arg_272_0)
					arg_268_1.dialogCg_.alpha = arg_272_0
				end))
				var_271_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_268_1.dialog_)
					var_271_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_268_1.duration_ = arg_268_1.duration_ + 0.3

				SetActive(arg_268_1.leftNameGo_, false)

				arg_268_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_268_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_268_1:RecordName(arg_268_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_268_1.iconTrs_.gameObject, false)
				arg_268_1.callingController_:SetSelectedState("normal")

				local var_271_28 = arg_268_1:GetWordFromCfg(319811065)
				local var_271_29 = arg_268_1:FormatText(var_271_28.content)

				arg_268_1.text_.text = var_271_29

				LuaForUtil.ClearLinePrefixSymbol(arg_268_1.text_)

				local var_271_30 = 47
				local var_271_31 = utf8.len(var_271_29)
				local var_271_32 = var_271_30 <= 0 and var_271_26 or var_271_26 * (var_271_31 / var_271_30)

				if var_271_32 > 0 and var_271_26 < var_271_32 then
					arg_268_1.talkMaxDuration = var_271_32
					var_271_25 = var_271_25 + 0.3

					if var_271_32 + var_271_25 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_32 + var_271_25
					end
				end

				arg_268_1.text_.text = var_271_29
				arg_268_1.typewritter.percent = 0

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(false)
				arg_268_1:RecordContent(arg_268_1.text_.text)
			end

			local var_271_33 = var_271_25 + 0.3
			local var_271_34 = math.max(var_271_26, arg_268_1.talkMaxDuration)

			if var_271_33 <= arg_268_1.time_ and arg_268_1.time_ < var_271_33 + var_271_34 then
				arg_268_1.typewritter.percent = (arg_268_1.time_ - var_271_33) / var_271_34

				arg_268_1.typewritter:SetDirty()
			end

			if arg_268_1.time_ >= var_271_33 + var_271_34 and arg_268_1.time_ < var_271_33 + var_271_34 + arg_271_0 then
				arg_268_1.typewritter.percent = 1

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(true)
			end
		end

		arg_268_1.nodeConfigList_ = {}

		arg_268_1:InitPlayNodeList()
	end,
	Play319811066 = function(arg_274_0, arg_274_1)
		arg_274_1.time_ = 0
		arg_274_1.frameCnt_ = 0
		arg_274_1.state_ = "playing"
		arg_274_1.curTalkId_ = 319811066
		arg_274_1.duration_ = 10.23

		local var_274_0 = {
			zh = 7.333,
			ja = 10.233
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
				arg_274_0:Play319811067(arg_274_1)
			end
		end

		function arg_274_1.onSingleLineUpdate_(arg_277_0)
			local var_277_0 = arg_274_1.actors_["10058ui_story"].transform
			local var_277_1 = 0

			if var_277_1 < arg_274_1.time_ and arg_274_1.time_ <= var_277_1 + arg_277_0 then
				arg_274_1.var_.moveOldPos10058ui_story = var_277_0.localPosition
			end

			local var_277_2 = 0.001

			if var_277_1 <= arg_274_1.time_ and arg_274_1.time_ < var_277_1 + var_277_2 then
				local var_277_3 = (arg_274_1.time_ - var_277_1) / var_277_2
				local var_277_4 = Vector3.New(0, -0.98, -6.1)

				var_277_0.localPosition = Vector3.Lerp(arg_274_1.var_.moveOldPos10058ui_story, var_277_4, var_277_3)

				local var_277_5 = manager.ui.mainCamera.transform.position - var_277_0.position

				var_277_0.forward = Vector3.New(var_277_5.x, var_277_5.y, var_277_5.z)

				local var_277_6 = var_277_0.localEulerAngles

				var_277_6.z = 0
				var_277_6.x = 0
				var_277_0.localEulerAngles = var_277_6
			end

			if arg_274_1.time_ >= var_277_1 + var_277_2 and arg_274_1.time_ < var_277_1 + var_277_2 + arg_277_0 then
				var_277_0.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_277_7 = manager.ui.mainCamera.transform.position - var_277_0.position

				var_277_0.forward = Vector3.New(var_277_7.x, var_277_7.y, var_277_7.z)

				local var_277_8 = var_277_0.localEulerAngles

				var_277_8.z = 0
				var_277_8.x = 0
				var_277_0.localEulerAngles = var_277_8
			end

			local var_277_9 = arg_274_1.actors_["10058ui_story"]
			local var_277_10 = 0

			if var_277_10 < arg_274_1.time_ and arg_274_1.time_ <= var_277_10 + arg_277_0 and not isNil(var_277_9) and arg_274_1.var_.characterEffect10058ui_story == nil then
				arg_274_1.var_.characterEffect10058ui_story = var_277_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_277_11 = 0.200000002980232

			if var_277_10 <= arg_274_1.time_ and arg_274_1.time_ < var_277_10 + var_277_11 and not isNil(var_277_9) then
				local var_277_12 = (arg_274_1.time_ - var_277_10) / var_277_11

				if arg_274_1.var_.characterEffect10058ui_story and not isNil(var_277_9) then
					arg_274_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_274_1.time_ >= var_277_10 + var_277_11 and arg_274_1.time_ < var_277_10 + var_277_11 + arg_277_0 and not isNil(var_277_9) and arg_274_1.var_.characterEffect10058ui_story then
				arg_274_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_277_13 = 0

			if var_277_13 < arg_274_1.time_ and arg_274_1.time_ <= var_277_13 + arg_277_0 then
				arg_274_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action3_1")
			end

			local var_277_14 = 0

			if var_277_14 < arg_274_1.time_ and arg_274_1.time_ <= var_277_14 + arg_277_0 then
				arg_274_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_277_15 = 0
			local var_277_16 = 0.675

			if var_277_15 < arg_274_1.time_ and arg_274_1.time_ <= var_277_15 + arg_277_0 then
				arg_274_1.talkMaxDuration = 0
				arg_274_1.dialogCg_.alpha = 1

				arg_274_1.dialog_:SetActive(true)
				SetActive(arg_274_1.leftNameGo_, true)

				local var_277_17 = arg_274_1:FormatText(StoryNameCfg[471].name)

				arg_274_1.leftNameTxt_.text = var_277_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_274_1.leftNameTxt_.transform)

				arg_274_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_274_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_274_1:RecordName(arg_274_1.leftNameTxt_.text)
				SetActive(arg_274_1.iconTrs_.gameObject, false)
				arg_274_1.callingController_:SetSelectedState("normal")

				local var_277_18 = arg_274_1:GetWordFromCfg(319811066)
				local var_277_19 = arg_274_1:FormatText(var_277_18.content)

				arg_274_1.text_.text = var_277_19

				LuaForUtil.ClearLinePrefixSymbol(arg_274_1.text_)

				local var_277_20 = 27
				local var_277_21 = utf8.len(var_277_19)
				local var_277_22 = var_277_20 <= 0 and var_277_16 or var_277_16 * (var_277_21 / var_277_20)

				if var_277_22 > 0 and var_277_16 < var_277_22 then
					arg_274_1.talkMaxDuration = var_277_22

					if var_277_22 + var_277_15 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_22 + var_277_15
					end
				end

				arg_274_1.text_.text = var_277_19
				arg_274_1.typewritter.percent = 0

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319811", "319811066", "story_v_out_319811.awb") ~= 0 then
					local var_277_23 = manager.audio:GetVoiceLength("story_v_out_319811", "319811066", "story_v_out_319811.awb") / 1000

					if var_277_23 + var_277_15 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_23 + var_277_15
					end

					if var_277_18.prefab_name ~= "" and arg_274_1.actors_[var_277_18.prefab_name] ~= nil then
						local var_277_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_274_1.actors_[var_277_18.prefab_name].transform, "story_v_out_319811", "319811066", "story_v_out_319811.awb")

						arg_274_1:RecordAudio("319811066", var_277_24)
						arg_274_1:RecordAudio("319811066", var_277_24)
					else
						arg_274_1:AudioAction("play", "voice", "story_v_out_319811", "319811066", "story_v_out_319811.awb")
					end

					arg_274_1:RecordHistoryTalkVoice("story_v_out_319811", "319811066", "story_v_out_319811.awb")
				end

				arg_274_1:RecordContent(arg_274_1.text_.text)
			end

			local var_277_25 = math.max(var_277_16, arg_274_1.talkMaxDuration)

			if var_277_15 <= arg_274_1.time_ and arg_274_1.time_ < var_277_15 + var_277_25 then
				arg_274_1.typewritter.percent = (arg_274_1.time_ - var_277_15) / var_277_25

				arg_274_1.typewritter:SetDirty()
			end

			if arg_274_1.time_ >= var_277_15 + var_277_25 and arg_274_1.time_ < var_277_15 + var_277_25 + arg_277_0 then
				arg_274_1.typewritter.percent = 1

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(true)
			end
		end

		arg_274_1.nodeConfigList_ = {
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

		arg_274_1:InitPlayNodeList()
	end,
	Play319811067 = function(arg_278_0, arg_278_1)
		arg_278_1.time_ = 0
		arg_278_1.frameCnt_ = 0
		arg_278_1.state_ = "playing"
		arg_278_1.curTalkId_ = 319811067
		arg_278_1.duration_ = 4.7

		local var_278_0 = {
			zh = 2.933,
			ja = 4.7
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
				arg_278_0:Play319811068(arg_278_1)
			end
		end

		function arg_278_1.onSingleLineUpdate_(arg_281_0)
			local var_281_0 = arg_278_1.actors_["1084ui_story"].transform
			local var_281_1 = 0

			if var_281_1 < arg_278_1.time_ and arg_278_1.time_ <= var_281_1 + arg_281_0 then
				arg_278_1.var_.moveOldPos1084ui_story = var_281_0.localPosition
			end

			local var_281_2 = 0.001

			if var_281_1 <= arg_278_1.time_ and arg_278_1.time_ < var_281_1 + var_281_2 then
				local var_281_3 = (arg_278_1.time_ - var_281_1) / var_281_2
				local var_281_4 = Vector3.New(0.7, -0.97, -6)

				var_281_0.localPosition = Vector3.Lerp(arg_278_1.var_.moveOldPos1084ui_story, var_281_4, var_281_3)

				local var_281_5 = manager.ui.mainCamera.transform.position - var_281_0.position

				var_281_0.forward = Vector3.New(var_281_5.x, var_281_5.y, var_281_5.z)

				local var_281_6 = var_281_0.localEulerAngles

				var_281_6.z = 0
				var_281_6.x = 0
				var_281_0.localEulerAngles = var_281_6
			end

			if arg_278_1.time_ >= var_281_1 + var_281_2 and arg_278_1.time_ < var_281_1 + var_281_2 + arg_281_0 then
				var_281_0.localPosition = Vector3.New(0.7, -0.97, -6)

				local var_281_7 = manager.ui.mainCamera.transform.position - var_281_0.position

				var_281_0.forward = Vector3.New(var_281_7.x, var_281_7.y, var_281_7.z)

				local var_281_8 = var_281_0.localEulerAngles

				var_281_8.z = 0
				var_281_8.x = 0
				var_281_0.localEulerAngles = var_281_8
			end

			local var_281_9 = arg_278_1.actors_["1084ui_story"]
			local var_281_10 = 0

			if var_281_10 < arg_278_1.time_ and arg_278_1.time_ <= var_281_10 + arg_281_0 and not isNil(var_281_9) and arg_278_1.var_.characterEffect1084ui_story == nil then
				arg_278_1.var_.characterEffect1084ui_story = var_281_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_281_11 = 0.200000002980232

			if var_281_10 <= arg_278_1.time_ and arg_278_1.time_ < var_281_10 + var_281_11 and not isNil(var_281_9) then
				local var_281_12 = (arg_278_1.time_ - var_281_10) / var_281_11

				if arg_278_1.var_.characterEffect1084ui_story and not isNil(var_281_9) then
					arg_278_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_278_1.time_ >= var_281_10 + var_281_11 and arg_278_1.time_ < var_281_10 + var_281_11 + arg_281_0 and not isNil(var_281_9) and arg_278_1.var_.characterEffect1084ui_story then
				arg_278_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_281_13 = 0

			if var_281_13 < arg_278_1.time_ and arg_278_1.time_ <= var_281_13 + arg_281_0 then
				arg_278_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			local var_281_14 = 0

			if var_281_14 < arg_278_1.time_ and arg_278_1.time_ <= var_281_14 + arg_281_0 then
				arg_278_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2202cva")
			end

			local var_281_15 = arg_278_1.actors_["10058ui_story"].transform
			local var_281_16 = 0

			if var_281_16 < arg_278_1.time_ and arg_278_1.time_ <= var_281_16 + arg_281_0 then
				arg_278_1.var_.moveOldPos10058ui_story = var_281_15.localPosition
			end

			local var_281_17 = 0.001

			if var_281_16 <= arg_278_1.time_ and arg_278_1.time_ < var_281_16 + var_281_17 then
				local var_281_18 = (arg_278_1.time_ - var_281_16) / var_281_17
				local var_281_19 = Vector3.New(-0.7, -0.98, -6.1)

				var_281_15.localPosition = Vector3.Lerp(arg_278_1.var_.moveOldPos10058ui_story, var_281_19, var_281_18)

				local var_281_20 = manager.ui.mainCamera.transform.position - var_281_15.position

				var_281_15.forward = Vector3.New(var_281_20.x, var_281_20.y, var_281_20.z)

				local var_281_21 = var_281_15.localEulerAngles

				var_281_21.z = 0
				var_281_21.x = 0
				var_281_15.localEulerAngles = var_281_21
			end

			if arg_278_1.time_ >= var_281_16 + var_281_17 and arg_278_1.time_ < var_281_16 + var_281_17 + arg_281_0 then
				var_281_15.localPosition = Vector3.New(-0.7, -0.98, -6.1)

				local var_281_22 = manager.ui.mainCamera.transform.position - var_281_15.position

				var_281_15.forward = Vector3.New(var_281_22.x, var_281_22.y, var_281_22.z)

				local var_281_23 = var_281_15.localEulerAngles

				var_281_23.z = 0
				var_281_23.x = 0
				var_281_15.localEulerAngles = var_281_23
			end

			local var_281_24 = arg_278_1.actors_["10058ui_story"]
			local var_281_25 = 0

			if var_281_25 < arg_278_1.time_ and arg_278_1.time_ <= var_281_25 + arg_281_0 and not isNil(var_281_24) and arg_278_1.var_.characterEffect10058ui_story == nil then
				arg_278_1.var_.characterEffect10058ui_story = var_281_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_281_26 = 0.200000002980232

			if var_281_25 <= arg_278_1.time_ and arg_278_1.time_ < var_281_25 + var_281_26 and not isNil(var_281_24) then
				local var_281_27 = (arg_278_1.time_ - var_281_25) / var_281_26

				if arg_278_1.var_.characterEffect10058ui_story and not isNil(var_281_24) then
					local var_281_28 = Mathf.Lerp(0, 0.5, var_281_27)

					arg_278_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_278_1.var_.characterEffect10058ui_story.fillRatio = var_281_28
				end
			end

			if arg_278_1.time_ >= var_281_25 + var_281_26 and arg_278_1.time_ < var_281_25 + var_281_26 + arg_281_0 and not isNil(var_281_24) and arg_278_1.var_.characterEffect10058ui_story then
				local var_281_29 = 0.5

				arg_278_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_278_1.var_.characterEffect10058ui_story.fillRatio = var_281_29
			end

			local var_281_30 = 0
			local var_281_31 = 0.425

			if var_281_30 < arg_278_1.time_ and arg_278_1.time_ <= var_281_30 + arg_281_0 then
				arg_278_1.talkMaxDuration = 0
				arg_278_1.dialogCg_.alpha = 1

				arg_278_1.dialog_:SetActive(true)
				SetActive(arg_278_1.leftNameGo_, true)

				local var_281_32 = arg_278_1:FormatText(StoryNameCfg[6].name)

				arg_278_1.leftNameTxt_.text = var_281_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_278_1.leftNameTxt_.transform)

				arg_278_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_278_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_278_1:RecordName(arg_278_1.leftNameTxt_.text)
				SetActive(arg_278_1.iconTrs_.gameObject, false)
				arg_278_1.callingController_:SetSelectedState("normal")

				local var_281_33 = arg_278_1:GetWordFromCfg(319811067)
				local var_281_34 = arg_278_1:FormatText(var_281_33.content)

				arg_278_1.text_.text = var_281_34

				LuaForUtil.ClearLinePrefixSymbol(arg_278_1.text_)

				local var_281_35 = 17
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

				if manager.audio:GetVoiceLength("story_v_out_319811", "319811067", "story_v_out_319811.awb") ~= 0 then
					local var_281_38 = manager.audio:GetVoiceLength("story_v_out_319811", "319811067", "story_v_out_319811.awb") / 1000

					if var_281_38 + var_281_30 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_38 + var_281_30
					end

					if var_281_33.prefab_name ~= "" and arg_278_1.actors_[var_281_33.prefab_name] ~= nil then
						local var_281_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_278_1.actors_[var_281_33.prefab_name].transform, "story_v_out_319811", "319811067", "story_v_out_319811.awb")

						arg_278_1:RecordAudio("319811067", var_281_39)
						arg_278_1:RecordAudio("319811067", var_281_39)
					else
						arg_278_1:AudioAction("play", "voice", "story_v_out_319811", "319811067", "story_v_out_319811.awb")
					end

					arg_278_1:RecordHistoryTalkVoice("story_v_out_319811", "319811067", "story_v_out_319811.awb")
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
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_278_1:InitPlayNodeList()
	end,
	Play319811068 = function(arg_282_0, arg_282_1)
		arg_282_1.time_ = 0
		arg_282_1.frameCnt_ = 0
		arg_282_1.state_ = "playing"
		arg_282_1.curTalkId_ = 319811068
		arg_282_1.duration_ = 4.2

		local var_282_0 = {
			zh = 1.666,
			ja = 4.2
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
				arg_282_0:Play319811069(arg_282_1)
			end
		end

		function arg_282_1.onSingleLineUpdate_(arg_285_0)
			local var_285_0 = 0
			local var_285_1 = 0.25

			if var_285_0 < arg_282_1.time_ and arg_282_1.time_ <= var_285_0 + arg_285_0 then
				arg_282_1.talkMaxDuration = 0
				arg_282_1.dialogCg_.alpha = 1

				arg_282_1.dialog_:SetActive(true)
				SetActive(arg_282_1.leftNameGo_, true)

				local var_285_2 = arg_282_1:FormatText(StoryNameCfg[6].name)

				arg_282_1.leftNameTxt_.text = var_285_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_282_1.leftNameTxt_.transform)

				arg_282_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_282_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_282_1:RecordName(arg_282_1.leftNameTxt_.text)
				SetActive(arg_282_1.iconTrs_.gameObject, false)
				arg_282_1.callingController_:SetSelectedState("normal")

				local var_285_3 = arg_282_1:GetWordFromCfg(319811068)
				local var_285_4 = arg_282_1:FormatText(var_285_3.content)

				arg_282_1.text_.text = var_285_4

				LuaForUtil.ClearLinePrefixSymbol(arg_282_1.text_)

				local var_285_5 = 10
				local var_285_6 = utf8.len(var_285_4)
				local var_285_7 = var_285_5 <= 0 and var_285_1 or var_285_1 * (var_285_6 / var_285_5)

				if var_285_7 > 0 and var_285_1 < var_285_7 then
					arg_282_1.talkMaxDuration = var_285_7

					if var_285_7 + var_285_0 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_7 + var_285_0
					end
				end

				arg_282_1.text_.text = var_285_4
				arg_282_1.typewritter.percent = 0

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319811", "319811068", "story_v_out_319811.awb") ~= 0 then
					local var_285_8 = manager.audio:GetVoiceLength("story_v_out_319811", "319811068", "story_v_out_319811.awb") / 1000

					if var_285_8 + var_285_0 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_8 + var_285_0
					end

					if var_285_3.prefab_name ~= "" and arg_282_1.actors_[var_285_3.prefab_name] ~= nil then
						local var_285_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_282_1.actors_[var_285_3.prefab_name].transform, "story_v_out_319811", "319811068", "story_v_out_319811.awb")

						arg_282_1:RecordAudio("319811068", var_285_9)
						arg_282_1:RecordAudio("319811068", var_285_9)
					else
						arg_282_1:AudioAction("play", "voice", "story_v_out_319811", "319811068", "story_v_out_319811.awb")
					end

					arg_282_1:RecordHistoryTalkVoice("story_v_out_319811", "319811068", "story_v_out_319811.awb")
				end

				arg_282_1:RecordContent(arg_282_1.text_.text)
			end

			local var_285_10 = math.max(var_285_1, arg_282_1.talkMaxDuration)

			if var_285_0 <= arg_282_1.time_ and arg_282_1.time_ < var_285_0 + var_285_10 then
				arg_282_1.typewritter.percent = (arg_282_1.time_ - var_285_0) / var_285_10

				arg_282_1.typewritter:SetDirty()
			end

			if arg_282_1.time_ >= var_285_0 + var_285_10 and arg_282_1.time_ < var_285_0 + var_285_10 + arg_285_0 then
				arg_282_1.typewritter.percent = 1

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(true)
			end
		end

		arg_282_1.nodeConfigList_ = {}

		arg_282_1:InitPlayNodeList()
	end,
	Play319811069 = function(arg_286_0, arg_286_1)
		arg_286_1.time_ = 0
		arg_286_1.frameCnt_ = 0
		arg_286_1.state_ = "playing"
		arg_286_1.curTalkId_ = 319811069
		arg_286_1.duration_ = 7.33

		local var_286_0 = {
			zh = 6.6,
			ja = 7.333
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
				arg_286_0:Play319811070(arg_286_1)
			end
		end

		function arg_286_1.onSingleLineUpdate_(arg_289_0)
			local var_289_0 = arg_286_1.actors_["10058ui_story"].transform
			local var_289_1 = 0

			if var_289_1 < arg_286_1.time_ and arg_286_1.time_ <= var_289_1 + arg_289_0 then
				arg_286_1.var_.moveOldPos10058ui_story = var_289_0.localPosition
			end

			local var_289_2 = 0.001

			if var_289_1 <= arg_286_1.time_ and arg_286_1.time_ < var_289_1 + var_289_2 then
				local var_289_3 = (arg_286_1.time_ - var_289_1) / var_289_2
				local var_289_4 = Vector3.New(-0.7, -0.98, -6.1)

				var_289_0.localPosition = Vector3.Lerp(arg_286_1.var_.moveOldPos10058ui_story, var_289_4, var_289_3)

				local var_289_5 = manager.ui.mainCamera.transform.position - var_289_0.position

				var_289_0.forward = Vector3.New(var_289_5.x, var_289_5.y, var_289_5.z)

				local var_289_6 = var_289_0.localEulerAngles

				var_289_6.z = 0
				var_289_6.x = 0
				var_289_0.localEulerAngles = var_289_6
			end

			if arg_286_1.time_ >= var_289_1 + var_289_2 and arg_286_1.time_ < var_289_1 + var_289_2 + arg_289_0 then
				var_289_0.localPosition = Vector3.New(-0.7, -0.98, -6.1)

				local var_289_7 = manager.ui.mainCamera.transform.position - var_289_0.position

				var_289_0.forward = Vector3.New(var_289_7.x, var_289_7.y, var_289_7.z)

				local var_289_8 = var_289_0.localEulerAngles

				var_289_8.z = 0
				var_289_8.x = 0
				var_289_0.localEulerAngles = var_289_8
			end

			local var_289_9 = arg_286_1.actors_["10058ui_story"]
			local var_289_10 = 0

			if var_289_10 < arg_286_1.time_ and arg_286_1.time_ <= var_289_10 + arg_289_0 and not isNil(var_289_9) and arg_286_1.var_.characterEffect10058ui_story == nil then
				arg_286_1.var_.characterEffect10058ui_story = var_289_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_289_11 = 0.200000002980232

			if var_289_10 <= arg_286_1.time_ and arg_286_1.time_ < var_289_10 + var_289_11 and not isNil(var_289_9) then
				local var_289_12 = (arg_286_1.time_ - var_289_10) / var_289_11

				if arg_286_1.var_.characterEffect10058ui_story and not isNil(var_289_9) then
					arg_286_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_286_1.time_ >= var_289_10 + var_289_11 and arg_286_1.time_ < var_289_10 + var_289_11 + arg_289_0 and not isNil(var_289_9) and arg_286_1.var_.characterEffect10058ui_story then
				arg_286_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_289_13 = arg_286_1.actors_["1084ui_story"]
			local var_289_14 = 0

			if var_289_14 < arg_286_1.time_ and arg_286_1.time_ <= var_289_14 + arg_289_0 and not isNil(var_289_13) and arg_286_1.var_.characterEffect1084ui_story == nil then
				arg_286_1.var_.characterEffect1084ui_story = var_289_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_289_15 = 0.200000002980232

			if var_289_14 <= arg_286_1.time_ and arg_286_1.time_ < var_289_14 + var_289_15 and not isNil(var_289_13) then
				local var_289_16 = (arg_286_1.time_ - var_289_14) / var_289_15

				if arg_286_1.var_.characterEffect1084ui_story and not isNil(var_289_13) then
					local var_289_17 = Mathf.Lerp(0, 0.5, var_289_16)

					arg_286_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_286_1.var_.characterEffect1084ui_story.fillRatio = var_289_17
				end
			end

			if arg_286_1.time_ >= var_289_14 + var_289_15 and arg_286_1.time_ < var_289_14 + var_289_15 + arg_289_0 and not isNil(var_289_13) and arg_286_1.var_.characterEffect1084ui_story then
				local var_289_18 = 0.5

				arg_286_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_286_1.var_.characterEffect1084ui_story.fillRatio = var_289_18
			end

			local var_289_19 = 0
			local var_289_20 = 0.725

			if var_289_19 < arg_286_1.time_ and arg_286_1.time_ <= var_289_19 + arg_289_0 then
				arg_286_1.talkMaxDuration = 0
				arg_286_1.dialogCg_.alpha = 1

				arg_286_1.dialog_:SetActive(true)
				SetActive(arg_286_1.leftNameGo_, true)

				local var_289_21 = arg_286_1:FormatText(StoryNameCfg[471].name)

				arg_286_1.leftNameTxt_.text = var_289_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_286_1.leftNameTxt_.transform)

				arg_286_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_286_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_286_1:RecordName(arg_286_1.leftNameTxt_.text)
				SetActive(arg_286_1.iconTrs_.gameObject, false)
				arg_286_1.callingController_:SetSelectedState("normal")

				local var_289_22 = arg_286_1:GetWordFromCfg(319811069)
				local var_289_23 = arg_286_1:FormatText(var_289_22.content)

				arg_286_1.text_.text = var_289_23

				LuaForUtil.ClearLinePrefixSymbol(arg_286_1.text_)

				local var_289_24 = 29
				local var_289_25 = utf8.len(var_289_23)
				local var_289_26 = var_289_24 <= 0 and var_289_20 or var_289_20 * (var_289_25 / var_289_24)

				if var_289_26 > 0 and var_289_20 < var_289_26 then
					arg_286_1.talkMaxDuration = var_289_26

					if var_289_26 + var_289_19 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_26 + var_289_19
					end
				end

				arg_286_1.text_.text = var_289_23
				arg_286_1.typewritter.percent = 0

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319811", "319811069", "story_v_out_319811.awb") ~= 0 then
					local var_289_27 = manager.audio:GetVoiceLength("story_v_out_319811", "319811069", "story_v_out_319811.awb") / 1000

					if var_289_27 + var_289_19 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_27 + var_289_19
					end

					if var_289_22.prefab_name ~= "" and arg_286_1.actors_[var_289_22.prefab_name] ~= nil then
						local var_289_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_286_1.actors_[var_289_22.prefab_name].transform, "story_v_out_319811", "319811069", "story_v_out_319811.awb")

						arg_286_1:RecordAudio("319811069", var_289_28)
						arg_286_1:RecordAudio("319811069", var_289_28)
					else
						arg_286_1:AudioAction("play", "voice", "story_v_out_319811", "319811069", "story_v_out_319811.awb")
					end

					arg_286_1:RecordHistoryTalkVoice("story_v_out_319811", "319811069", "story_v_out_319811.awb")
				end

				arg_286_1:RecordContent(arg_286_1.text_.text)
			end

			local var_289_29 = math.max(var_289_20, arg_286_1.talkMaxDuration)

			if var_289_19 <= arg_286_1.time_ and arg_286_1.time_ < var_289_19 + var_289_29 then
				arg_286_1.typewritter.percent = (arg_286_1.time_ - var_289_19) / var_289_29

				arg_286_1.typewritter:SetDirty()
			end

			if arg_286_1.time_ >= var_289_19 + var_289_29 and arg_286_1.time_ < var_289_19 + var_289_29 + arg_289_0 then
				arg_286_1.typewritter.percent = 1

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(true)
			end
		end

		arg_286_1.nodeConfigList_ = {
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

		arg_286_1:InitPlayNodeList()
	end,
	Play319811070 = function(arg_290_0, arg_290_1)
		arg_290_1.time_ = 0
		arg_290_1.frameCnt_ = 0
		arg_290_1.state_ = "playing"
		arg_290_1.curTalkId_ = 319811070
		arg_290_1.duration_ = 9.37

		local var_290_0 = {
			zh = 6.633,
			ja = 9.366
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
				arg_290_0:Play319811071(arg_290_1)
			end
		end

		function arg_290_1.onSingleLineUpdate_(arg_293_0)
			local var_293_0 = 0

			if var_293_0 < arg_290_1.time_ and arg_290_1.time_ <= var_293_0 + arg_293_0 then
				arg_290_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action3_2")
			end

			local var_293_1 = 0

			if var_293_1 < arg_290_1.time_ and arg_290_1.time_ <= var_293_1 + arg_293_0 then
				arg_290_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_293_2 = 0
			local var_293_3 = 0.7

			if var_293_2 < arg_290_1.time_ and arg_290_1.time_ <= var_293_2 + arg_293_0 then
				arg_290_1.talkMaxDuration = 0
				arg_290_1.dialogCg_.alpha = 1

				arg_290_1.dialog_:SetActive(true)
				SetActive(arg_290_1.leftNameGo_, true)

				local var_293_4 = arg_290_1:FormatText(StoryNameCfg[471].name)

				arg_290_1.leftNameTxt_.text = var_293_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_290_1.leftNameTxt_.transform)

				arg_290_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_290_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_290_1:RecordName(arg_290_1.leftNameTxt_.text)
				SetActive(arg_290_1.iconTrs_.gameObject, false)
				arg_290_1.callingController_:SetSelectedState("normal")

				local var_293_5 = arg_290_1:GetWordFromCfg(319811070)
				local var_293_6 = arg_290_1:FormatText(var_293_5.content)

				arg_290_1.text_.text = var_293_6

				LuaForUtil.ClearLinePrefixSymbol(arg_290_1.text_)

				local var_293_7 = 28
				local var_293_8 = utf8.len(var_293_6)
				local var_293_9 = var_293_7 <= 0 and var_293_3 or var_293_3 * (var_293_8 / var_293_7)

				if var_293_9 > 0 and var_293_3 < var_293_9 then
					arg_290_1.talkMaxDuration = var_293_9

					if var_293_9 + var_293_2 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_9 + var_293_2
					end
				end

				arg_290_1.text_.text = var_293_6
				arg_290_1.typewritter.percent = 0

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319811", "319811070", "story_v_out_319811.awb") ~= 0 then
					local var_293_10 = manager.audio:GetVoiceLength("story_v_out_319811", "319811070", "story_v_out_319811.awb") / 1000

					if var_293_10 + var_293_2 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_10 + var_293_2
					end

					if var_293_5.prefab_name ~= "" and arg_290_1.actors_[var_293_5.prefab_name] ~= nil then
						local var_293_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_290_1.actors_[var_293_5.prefab_name].transform, "story_v_out_319811", "319811070", "story_v_out_319811.awb")

						arg_290_1:RecordAudio("319811070", var_293_11)
						arg_290_1:RecordAudio("319811070", var_293_11)
					else
						arg_290_1:AudioAction("play", "voice", "story_v_out_319811", "319811070", "story_v_out_319811.awb")
					end

					arg_290_1:RecordHistoryTalkVoice("story_v_out_319811", "319811070", "story_v_out_319811.awb")
				end

				arg_290_1:RecordContent(arg_290_1.text_.text)
			end

			local var_293_12 = math.max(var_293_3, arg_290_1.talkMaxDuration)

			if var_293_2 <= arg_290_1.time_ and arg_290_1.time_ < var_293_2 + var_293_12 then
				arg_290_1.typewritter.percent = (arg_290_1.time_ - var_293_2) / var_293_12

				arg_290_1.typewritter:SetDirty()
			end

			if arg_290_1.time_ >= var_293_2 + var_293_12 and arg_290_1.time_ < var_293_2 + var_293_12 + arg_293_0 then
				arg_290_1.typewritter.percent = 1

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(true)
			end
		end

		arg_290_1.nodeConfigList_ = {}

		arg_290_1:InitPlayNodeList()
	end,
	Play319811071 = function(arg_294_0, arg_294_1)
		arg_294_1.time_ = 0
		arg_294_1.frameCnt_ = 0
		arg_294_1.state_ = "playing"
		arg_294_1.curTalkId_ = 319811071
		arg_294_1.duration_ = 5

		SetActive(arg_294_1.tipsGo_, false)

		function arg_294_1.onSingleLineFinish_()
			arg_294_1.onSingleLineUpdate_ = nil
			arg_294_1.onSingleLineFinish_ = nil
			arg_294_1.state_ = "waiting"
		end

		function arg_294_1.playNext_(arg_296_0)
			if arg_296_0 == 1 then
				arg_294_0:Play319811072(arg_294_1)
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
					arg_294_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_294_1.time_ >= var_297_1 + var_297_2 and arg_294_1.time_ < var_297_1 + var_297_2 + arg_297_0 and not isNil(var_297_0) and arg_294_1.var_.characterEffect10058ui_story then
				arg_294_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_297_4 = arg_294_1.actors_["1084ui_story"].transform
			local var_297_5 = 0

			if var_297_5 < arg_294_1.time_ and arg_294_1.time_ <= var_297_5 + arg_297_0 then
				arg_294_1.var_.moveOldPos1084ui_story = var_297_4.localPosition
			end

			local var_297_6 = 0.001

			if var_297_5 <= arg_294_1.time_ and arg_294_1.time_ < var_297_5 + var_297_6 then
				local var_297_7 = (arg_294_1.time_ - var_297_5) / var_297_6
				local var_297_8 = Vector3.New(0, 100, 0)

				var_297_4.localPosition = Vector3.Lerp(arg_294_1.var_.moveOldPos1084ui_story, var_297_8, var_297_7)

				local var_297_9 = manager.ui.mainCamera.transform.position - var_297_4.position

				var_297_4.forward = Vector3.New(var_297_9.x, var_297_9.y, var_297_9.z)

				local var_297_10 = var_297_4.localEulerAngles

				var_297_10.z = 0
				var_297_10.x = 0
				var_297_4.localEulerAngles = var_297_10
			end

			if arg_294_1.time_ >= var_297_5 + var_297_6 and arg_294_1.time_ < var_297_5 + var_297_6 + arg_297_0 then
				var_297_4.localPosition = Vector3.New(0, 100, 0)

				local var_297_11 = manager.ui.mainCamera.transform.position - var_297_4.position

				var_297_4.forward = Vector3.New(var_297_11.x, var_297_11.y, var_297_11.z)

				local var_297_12 = var_297_4.localEulerAngles

				var_297_12.z = 0
				var_297_12.x = 0
				var_297_4.localEulerAngles = var_297_12
			end

			local var_297_13 = arg_294_1.actors_["10058ui_story"].transform
			local var_297_14 = 0

			if var_297_14 < arg_294_1.time_ and arg_294_1.time_ <= var_297_14 + arg_297_0 then
				arg_294_1.var_.moveOldPos10058ui_story = var_297_13.localPosition
			end

			local var_297_15 = 0.001

			if var_297_14 <= arg_294_1.time_ and arg_294_1.time_ < var_297_14 + var_297_15 then
				local var_297_16 = (arg_294_1.time_ - var_297_14) / var_297_15
				local var_297_17 = Vector3.New(0, 100, 0)

				var_297_13.localPosition = Vector3.Lerp(arg_294_1.var_.moveOldPos10058ui_story, var_297_17, var_297_16)

				local var_297_18 = manager.ui.mainCamera.transform.position - var_297_13.position

				var_297_13.forward = Vector3.New(var_297_18.x, var_297_18.y, var_297_18.z)

				local var_297_19 = var_297_13.localEulerAngles

				var_297_19.z = 0
				var_297_19.x = 0
				var_297_13.localEulerAngles = var_297_19
			end

			if arg_294_1.time_ >= var_297_14 + var_297_15 and arg_294_1.time_ < var_297_14 + var_297_15 + arg_297_0 then
				var_297_13.localPosition = Vector3.New(0, 100, 0)

				local var_297_20 = manager.ui.mainCamera.transform.position - var_297_13.position

				var_297_13.forward = Vector3.New(var_297_20.x, var_297_20.y, var_297_20.z)

				local var_297_21 = var_297_13.localEulerAngles

				var_297_21.z = 0
				var_297_21.x = 0
				var_297_13.localEulerAngles = var_297_21
			end

			local var_297_22 = 0
			local var_297_23 = 0.65

			if var_297_22 < arg_294_1.time_ and arg_294_1.time_ <= var_297_22 + arg_297_0 then
				arg_294_1.talkMaxDuration = 0
				arg_294_1.dialogCg_.alpha = 1

				arg_294_1.dialog_:SetActive(true)
				SetActive(arg_294_1.leftNameGo_, false)

				arg_294_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_294_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_294_1:RecordName(arg_294_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_294_1.iconTrs_.gameObject, false)
				arg_294_1.callingController_:SetSelectedState("normal")

				local var_297_24 = arg_294_1:GetWordFromCfg(319811071)
				local var_297_25 = arg_294_1:FormatText(var_297_24.content)

				arg_294_1.text_.text = var_297_25

				LuaForUtil.ClearLinePrefixSymbol(arg_294_1.text_)

				local var_297_26 = 26
				local var_297_27 = utf8.len(var_297_25)
				local var_297_28 = var_297_26 <= 0 and var_297_23 or var_297_23 * (var_297_27 / var_297_26)

				if var_297_28 > 0 and var_297_23 < var_297_28 then
					arg_294_1.talkMaxDuration = var_297_28

					if var_297_28 + var_297_22 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_28 + var_297_22
					end
				end

				arg_294_1.text_.text = var_297_25
				arg_294_1.typewritter.percent = 0

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(false)
				arg_294_1:RecordContent(arg_294_1.text_.text)
			end

			local var_297_29 = math.max(var_297_23, arg_294_1.talkMaxDuration)

			if var_297_22 <= arg_294_1.time_ and arg_294_1.time_ < var_297_22 + var_297_29 then
				arg_294_1.typewritter.percent = (arg_294_1.time_ - var_297_22) / var_297_29

				arg_294_1.typewritter:SetDirty()
			end

			if arg_294_1.time_ >= var_297_22 + var_297_29 and arg_294_1.time_ < var_297_22 + var_297_29 + arg_297_0 then
				arg_294_1.typewritter.percent = 1

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(true)
			end
		end

		arg_294_1.nodeConfigList_ = {
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
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_294_1:InitPlayNodeList()
	end,
	Play319811072 = function(arg_298_0, arg_298_1)
		arg_298_1.time_ = 0
		arg_298_1.frameCnt_ = 0
		arg_298_1.state_ = "playing"
		arg_298_1.curTalkId_ = 319811072
		arg_298_1.duration_ = 5

		SetActive(arg_298_1.tipsGo_, false)

		function arg_298_1.onSingleLineFinish_()
			arg_298_1.onSingleLineUpdate_ = nil
			arg_298_1.onSingleLineFinish_ = nil
			arg_298_1.state_ = "waiting"
		end

		function arg_298_1.playNext_(arg_300_0)
			if arg_300_0 == 1 then
				arg_298_0:Play319811073(arg_298_1)
			end
		end

		function arg_298_1.onSingleLineUpdate_(arg_301_0)
			local var_301_0 = 0
			local var_301_1 = 1

			if var_301_0 < arg_298_1.time_ and arg_298_1.time_ <= var_301_0 + arg_301_0 then
				local var_301_2 = "play"
				local var_301_3 = "effect"

				arg_298_1:AudioAction(var_301_2, var_301_3, "se_story_130", "se_story_130_didi", "")
			end

			local var_301_4 = 0
			local var_301_5 = 1.1

			if var_301_4 < arg_298_1.time_ and arg_298_1.time_ <= var_301_4 + arg_301_0 then
				arg_298_1.talkMaxDuration = 0
				arg_298_1.dialogCg_.alpha = 1

				arg_298_1.dialog_:SetActive(true)
				SetActive(arg_298_1.leftNameGo_, false)

				arg_298_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_298_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_298_1:RecordName(arg_298_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_298_1.iconTrs_.gameObject, false)
				arg_298_1.callingController_:SetSelectedState("normal")

				local var_301_6 = arg_298_1:GetWordFromCfg(319811072)
				local var_301_7 = arg_298_1:FormatText(var_301_6.content)

				arg_298_1.text_.text = var_301_7

				LuaForUtil.ClearLinePrefixSymbol(arg_298_1.text_)

				local var_301_8 = 44
				local var_301_9 = utf8.len(var_301_7)
				local var_301_10 = var_301_8 <= 0 and var_301_5 or var_301_5 * (var_301_9 / var_301_8)

				if var_301_10 > 0 and var_301_5 < var_301_10 then
					arg_298_1.talkMaxDuration = var_301_10

					if var_301_10 + var_301_4 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_10 + var_301_4
					end
				end

				arg_298_1.text_.text = var_301_7
				arg_298_1.typewritter.percent = 0

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(false)
				arg_298_1:RecordContent(arg_298_1.text_.text)
			end

			local var_301_11 = math.max(var_301_5, arg_298_1.talkMaxDuration)

			if var_301_4 <= arg_298_1.time_ and arg_298_1.time_ < var_301_4 + var_301_11 then
				arg_298_1.typewritter.percent = (arg_298_1.time_ - var_301_4) / var_301_11

				arg_298_1.typewritter:SetDirty()
			end

			if arg_298_1.time_ >= var_301_4 + var_301_11 and arg_298_1.time_ < var_301_4 + var_301_11 + arg_301_0 then
				arg_298_1.typewritter.percent = 1

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(true)
			end
		end

		arg_298_1.nodeConfigList_ = {}

		arg_298_1:InitPlayNodeList()
	end,
	Play319811073 = function(arg_302_0, arg_302_1)
		arg_302_1.time_ = 0
		arg_302_1.frameCnt_ = 0
		arg_302_1.state_ = "playing"
		arg_302_1.curTalkId_ = 319811073
		arg_302_1.duration_ = 6.2

		local var_302_0 = {
			zh = 6.2,
			ja = 6
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
			arg_302_1.auto_ = false
		end

		function arg_302_1.playNext_(arg_304_0)
			arg_302_1.onStoryFinished_()
		end

		function arg_302_1.onSingleLineUpdate_(arg_305_0)
			local var_305_0 = arg_302_1.actors_["10058ui_story"].transform
			local var_305_1 = 0

			if var_305_1 < arg_302_1.time_ and arg_302_1.time_ <= var_305_1 + arg_305_0 then
				arg_302_1.var_.moveOldPos10058ui_story = var_305_0.localPosition
			end

			local var_305_2 = 0.001

			if var_305_1 <= arg_302_1.time_ and arg_302_1.time_ < var_305_1 + var_305_2 then
				local var_305_3 = (arg_302_1.time_ - var_305_1) / var_305_2
				local var_305_4 = Vector3.New(0, -0.98, -6.1)

				var_305_0.localPosition = Vector3.Lerp(arg_302_1.var_.moveOldPos10058ui_story, var_305_4, var_305_3)

				local var_305_5 = manager.ui.mainCamera.transform.position - var_305_0.position

				var_305_0.forward = Vector3.New(var_305_5.x, var_305_5.y, var_305_5.z)

				local var_305_6 = var_305_0.localEulerAngles

				var_305_6.z = 0
				var_305_6.x = 0
				var_305_0.localEulerAngles = var_305_6
			end

			if arg_302_1.time_ >= var_305_1 + var_305_2 and arg_302_1.time_ < var_305_1 + var_305_2 + arg_305_0 then
				var_305_0.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_305_7 = manager.ui.mainCamera.transform.position - var_305_0.position

				var_305_0.forward = Vector3.New(var_305_7.x, var_305_7.y, var_305_7.z)

				local var_305_8 = var_305_0.localEulerAngles

				var_305_8.z = 0
				var_305_8.x = 0
				var_305_0.localEulerAngles = var_305_8
			end

			local var_305_9 = arg_302_1.actors_["10058ui_story"]
			local var_305_10 = 0

			if var_305_10 < arg_302_1.time_ and arg_302_1.time_ <= var_305_10 + arg_305_0 and not isNil(var_305_9) and arg_302_1.var_.characterEffect10058ui_story == nil then
				arg_302_1.var_.characterEffect10058ui_story = var_305_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_305_11 = 0.200000002980232

			if var_305_10 <= arg_302_1.time_ and arg_302_1.time_ < var_305_10 + var_305_11 and not isNil(var_305_9) then
				local var_305_12 = (arg_302_1.time_ - var_305_10) / var_305_11

				if arg_302_1.var_.characterEffect10058ui_story and not isNil(var_305_9) then
					arg_302_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_302_1.time_ >= var_305_10 + var_305_11 and arg_302_1.time_ < var_305_10 + var_305_11 + arg_305_0 and not isNil(var_305_9) and arg_302_1.var_.characterEffect10058ui_story then
				arg_302_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_305_13 = 0

			if var_305_13 < arg_302_1.time_ and arg_302_1.time_ <= var_305_13 + arg_305_0 then
				arg_302_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_305_14 = 0

			if var_305_14 < arg_302_1.time_ and arg_302_1.time_ <= var_305_14 + arg_305_0 then
				arg_302_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_305_15 = 0
			local var_305_16 = 1

			if var_305_15 < arg_302_1.time_ and arg_302_1.time_ <= var_305_15 + arg_305_0 then
				local var_305_17 = "stop"
				local var_305_18 = "effect"

				arg_302_1:AudioAction(var_305_17, var_305_18, "se_story_130", "se_story_130_didi", "")
			end

			local var_305_19 = 0
			local var_305_20 = 0.625

			if var_305_19 < arg_302_1.time_ and arg_302_1.time_ <= var_305_19 + arg_305_0 then
				arg_302_1.talkMaxDuration = 0
				arg_302_1.dialogCg_.alpha = 1

				arg_302_1.dialog_:SetActive(true)
				SetActive(arg_302_1.leftNameGo_, true)

				local var_305_21 = arg_302_1:FormatText(StoryNameCfg[471].name)

				arg_302_1.leftNameTxt_.text = var_305_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_302_1.leftNameTxt_.transform)

				arg_302_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_302_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_302_1:RecordName(arg_302_1.leftNameTxt_.text)
				SetActive(arg_302_1.iconTrs_.gameObject, false)
				arg_302_1.callingController_:SetSelectedState("normal")

				local var_305_22 = arg_302_1:GetWordFromCfg(319811073)
				local var_305_23 = arg_302_1:FormatText(var_305_22.content)

				arg_302_1.text_.text = var_305_23

				LuaForUtil.ClearLinePrefixSymbol(arg_302_1.text_)

				local var_305_24 = 25
				local var_305_25 = utf8.len(var_305_23)
				local var_305_26 = var_305_24 <= 0 and var_305_20 or var_305_20 * (var_305_25 / var_305_24)

				if var_305_26 > 0 and var_305_20 < var_305_26 then
					arg_302_1.talkMaxDuration = var_305_26

					if var_305_26 + var_305_19 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_26 + var_305_19
					end
				end

				arg_302_1.text_.text = var_305_23
				arg_302_1.typewritter.percent = 0

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319811", "319811073", "story_v_out_319811.awb") ~= 0 then
					local var_305_27 = manager.audio:GetVoiceLength("story_v_out_319811", "319811073", "story_v_out_319811.awb") / 1000

					if var_305_27 + var_305_19 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_27 + var_305_19
					end

					if var_305_22.prefab_name ~= "" and arg_302_1.actors_[var_305_22.prefab_name] ~= nil then
						local var_305_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_302_1.actors_[var_305_22.prefab_name].transform, "story_v_out_319811", "319811073", "story_v_out_319811.awb")

						arg_302_1:RecordAudio("319811073", var_305_28)
						arg_302_1:RecordAudio("319811073", var_305_28)
					else
						arg_302_1:AudioAction("play", "voice", "story_v_out_319811", "319811073", "story_v_out_319811.awb")
					end

					arg_302_1:RecordHistoryTalkVoice("story_v_out_319811", "319811073", "story_v_out_319811.awb")
				end

				arg_302_1:RecordContent(arg_302_1.text_.text)
			end

			local var_305_29 = math.max(var_305_20, arg_302_1.talkMaxDuration)

			if var_305_19 <= arg_302_1.time_ and arg_302_1.time_ < var_305_19 + var_305_29 then
				arg_302_1.typewritter.percent = (arg_302_1.time_ - var_305_19) / var_305_29

				arg_302_1.typewritter:SetDirty()
			end

			if arg_302_1.time_ >= var_305_19 + var_305_29 and arg_302_1.time_ < var_305_19 + var_305_29 + arg_305_0 then
				arg_302_1.typewritter.percent = 1

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(true)
			end
		end

		arg_302_1.nodeConfigList_ = {
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

		arg_302_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/I11m",
		"TextureConfig/Background/ST72a",
		"TextureConfig/Background/STblack"
	},
	voices = {
		"story_v_out_319811.awb"
	}
}
