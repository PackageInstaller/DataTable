return {
	Play319761001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 319761001
		arg_1_1.duration_ = 6.8

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play319761002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "I11o"

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
				local var_4_5 = arg_1_1.bgs_.I11o

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
					if iter_4_0 ~= "I11o" then
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

			local var_4_30 = 1.8
			local var_4_31 = 1.4

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

				local var_4_33 = arg_1_1:GetWordFromCfg(319761001)
				local var_4_34 = arg_1_1:FormatText(var_4_33.content)

				arg_1_1.text_.text = var_4_34

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_35 = 56
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
	Play319761002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 319761002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play319761003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 0
			local var_11_1 = 1.4

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

				local var_11_2 = arg_8_1:GetWordFromCfg(319761002)
				local var_11_3 = arg_8_1:FormatText(var_11_2.content)

				arg_8_1.text_.text = var_11_3

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_4 = 56
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
	Play319761003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 319761003
		arg_12_1.duration_ = 7.43

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play319761004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = "I11r"

			if arg_12_1.bgs_[var_15_0] == nil then
				local var_15_1 = Object.Instantiate(arg_12_1.paintGo_)

				var_15_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_15_0)
				var_15_1.name = var_15_0
				var_15_1.transform.parent = arg_12_1.stage_.transform
				var_15_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_12_1.bgs_[var_15_0] = var_15_1
			end

			local var_15_2 = 1

			if var_15_2 < arg_12_1.time_ and arg_12_1.time_ <= var_15_2 + arg_15_0 then
				local var_15_3 = manager.ui.mainCamera.transform.localPosition
				local var_15_4 = Vector3.New(0, 0, 10) + Vector3.New(var_15_3.x, var_15_3.y, 0)
				local var_15_5 = arg_12_1.bgs_.I11r

				var_15_5.transform.localPosition = var_15_4
				var_15_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_15_6 = var_15_5:GetComponent("SpriteRenderer")

				if var_15_6 and var_15_6.sprite then
					local var_15_7 = (var_15_5.transform.localPosition - var_15_3).z
					local var_15_8 = manager.ui.mainCameraCom_
					local var_15_9 = 2 * var_15_7 * Mathf.Tan(var_15_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_15_10 = var_15_9 * var_15_8.aspect
					local var_15_11 = var_15_6.sprite.bounds.size.x
					local var_15_12 = var_15_6.sprite.bounds.size.y
					local var_15_13 = var_15_10 / var_15_11
					local var_15_14 = var_15_9 / var_15_12
					local var_15_15 = var_15_14 < var_15_13 and var_15_13 or var_15_14

					var_15_5.transform.localScale = Vector3.New(var_15_15, var_15_15, 0)
				end

				for iter_15_0, iter_15_1 in pairs(arg_12_1.bgs_) do
					if iter_15_0 ~= "I11r" then
						iter_15_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_15_16 = 0

			if var_15_16 < arg_12_1.time_ and arg_12_1.time_ <= var_15_16 + arg_15_0 then
				arg_12_1.allBtn_.enabled = false
			end

			local var_15_17 = 0.3

			if arg_12_1.time_ >= var_15_16 + var_15_17 and arg_12_1.time_ < var_15_16 + var_15_17 + arg_15_0 then
				arg_12_1.allBtn_.enabled = true
			end

			local var_15_18 = 0

			if var_15_18 < arg_12_1.time_ and arg_12_1.time_ <= var_15_18 + arg_15_0 then
				arg_12_1.mask_.enabled = true
				arg_12_1.mask_.raycastTarget = true

				arg_12_1:SetGaussion(false)
			end

			local var_15_19 = 1

			if var_15_18 <= arg_12_1.time_ and arg_12_1.time_ < var_15_18 + var_15_19 then
				local var_15_20 = (arg_12_1.time_ - var_15_18) / var_15_19
				local var_15_21 = Color.New(0, 0, 0)

				var_15_21.a = Mathf.Lerp(0, 1, var_15_20)
				arg_12_1.mask_.color = var_15_21
			end

			if arg_12_1.time_ >= var_15_18 + var_15_19 and arg_12_1.time_ < var_15_18 + var_15_19 + arg_15_0 then
				local var_15_22 = Color.New(0, 0, 0)

				var_15_22.a = 1
				arg_12_1.mask_.color = var_15_22
			end

			local var_15_23 = 1

			if var_15_23 < arg_12_1.time_ and arg_12_1.time_ <= var_15_23 + arg_15_0 then
				arg_12_1.mask_.enabled = true
				arg_12_1.mask_.raycastTarget = true

				arg_12_1:SetGaussion(false)
			end

			local var_15_24 = 1.999999999999

			if var_15_23 <= arg_12_1.time_ and arg_12_1.time_ < var_15_23 + var_15_24 then
				local var_15_25 = (arg_12_1.time_ - var_15_23) / var_15_24
				local var_15_26 = Color.New(0, 0, 0)

				var_15_26.a = Mathf.Lerp(1, 0, var_15_25)
				arg_12_1.mask_.color = var_15_26
			end

			if arg_12_1.time_ >= var_15_23 + var_15_24 and arg_12_1.time_ < var_15_23 + var_15_24 + arg_15_0 then
				local var_15_27 = Color.New(0, 0, 0)
				local var_15_28 = 0

				arg_12_1.mask_.enabled = false
				var_15_27.a = var_15_28
				arg_12_1.mask_.color = var_15_27
			end

			if arg_12_1.frameCnt_ <= 1 then
				arg_12_1.dialog_:SetActive(false)
			end

			local var_15_29 = 2.43333333333333
			local var_15_30 = 1.325

			if var_15_29 < arg_12_1.time_ and arg_12_1.time_ <= var_15_29 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0

				arg_12_1.dialog_:SetActive(true)

				arg_12_1.dialogCg_.alpha = 0

				local var_15_31 = LeanTween.value(arg_12_1.dialog_, 0, 1, 0.3)

				var_15_31:setOnUpdate(LuaHelper.FloatAction(function(arg_16_0)
					arg_12_1.dialogCg_.alpha = arg_16_0
				end))
				var_15_31:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_12_1.dialog_)
					var_15_31:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_12_1.duration_ = arg_12_1.duration_ + 0.3

				SetActive(arg_12_1.leftNameGo_, false)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_32 = arg_12_1:GetWordFromCfg(319761003)
				local var_15_33 = arg_12_1:FormatText(var_15_32.content)

				arg_12_1.text_.text = var_15_33

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_34 = 53
				local var_15_35 = utf8.len(var_15_33)
				local var_15_36 = var_15_34 <= 0 and var_15_30 or var_15_30 * (var_15_35 / var_15_34)

				if var_15_36 > 0 and var_15_30 < var_15_36 then
					arg_12_1.talkMaxDuration = var_15_36
					var_15_29 = var_15_29 + 0.3

					if var_15_36 + var_15_29 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_36 + var_15_29
					end
				end

				arg_12_1.text_.text = var_15_33
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)
				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_37 = var_15_29 + 0.3
			local var_15_38 = math.max(var_15_30, arg_12_1.talkMaxDuration)

			if var_15_37 <= arg_12_1.time_ and arg_12_1.time_ < var_15_37 + var_15_38 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_37) / var_15_38

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_37 + var_15_38 and arg_12_1.time_ < var_15_37 + var_15_38 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play319761004 = function(arg_18_0, arg_18_1)
		arg_18_1.time_ = 0
		arg_18_1.frameCnt_ = 0
		arg_18_1.state_ = "playing"
		arg_18_1.curTalkId_ = 319761004
		arg_18_1.duration_ = 5

		SetActive(arg_18_1.tipsGo_, false)

		function arg_18_1.onSingleLineFinish_()
			arg_18_1.onSingleLineUpdate_ = nil
			arg_18_1.onSingleLineFinish_ = nil
			arg_18_1.state_ = "waiting"
		end

		function arg_18_1.playNext_(arg_20_0)
			if arg_20_0 == 1 then
				arg_18_0:Play319761005(arg_18_1)
			end
		end

		function arg_18_1.onSingleLineUpdate_(arg_21_0)
			local var_21_0 = 0
			local var_21_1 = 1.6

			if var_21_0 < arg_18_1.time_ and arg_18_1.time_ <= var_21_0 + arg_21_0 then
				arg_18_1.talkMaxDuration = 0
				arg_18_1.dialogCg_.alpha = 1

				arg_18_1.dialog_:SetActive(true)
				SetActive(arg_18_1.leftNameGo_, false)

				arg_18_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_18_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_18_1:RecordName(arg_18_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_18_1.iconTrs_.gameObject, false)
				arg_18_1.callingController_:SetSelectedState("normal")

				local var_21_2 = arg_18_1:GetWordFromCfg(319761004)
				local var_21_3 = arg_18_1:FormatText(var_21_2.content)

				arg_18_1.text_.text = var_21_3

				LuaForUtil.ClearLinePrefixSymbol(arg_18_1.text_)

				local var_21_4 = 64
				local var_21_5 = utf8.len(var_21_3)
				local var_21_6 = var_21_4 <= 0 and var_21_1 or var_21_1 * (var_21_5 / var_21_4)

				if var_21_6 > 0 and var_21_1 < var_21_6 then
					arg_18_1.talkMaxDuration = var_21_6

					if var_21_6 + var_21_0 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_6 + var_21_0
					end
				end

				arg_18_1.text_.text = var_21_3
				arg_18_1.typewritter.percent = 0

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(false)
				arg_18_1:RecordContent(arg_18_1.text_.text)
			end

			local var_21_7 = math.max(var_21_1, arg_18_1.talkMaxDuration)

			if var_21_0 <= arg_18_1.time_ and arg_18_1.time_ < var_21_0 + var_21_7 then
				arg_18_1.typewritter.percent = (arg_18_1.time_ - var_21_0) / var_21_7

				arg_18_1.typewritter:SetDirty()
			end

			if arg_18_1.time_ >= var_21_0 + var_21_7 and arg_18_1.time_ < var_21_0 + var_21_7 + arg_21_0 then
				arg_18_1.typewritter.percent = 1

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(true)
			end
		end

		arg_18_1.nodeConfigList_ = {}

		arg_18_1:InitPlayNodeList()
	end,
	Play319761005 = function(arg_22_0, arg_22_1)
		arg_22_1.time_ = 0
		arg_22_1.frameCnt_ = 0
		arg_22_1.state_ = "playing"
		arg_22_1.curTalkId_ = 319761005
		arg_22_1.duration_ = 6.87

		SetActive(arg_22_1.tipsGo_, false)

		function arg_22_1.onSingleLineFinish_()
			arg_22_1.onSingleLineUpdate_ = nil
			arg_22_1.onSingleLineFinish_ = nil
			arg_22_1.state_ = "waiting"
		end

		function arg_22_1.playNext_(arg_24_0)
			if arg_24_0 == 1 then
				arg_22_0:Play319761006(arg_22_1)
			end
		end

		function arg_22_1.onSingleLineUpdate_(arg_25_0)
			local var_25_0 = "I11l"

			if arg_22_1.bgs_[var_25_0] == nil then
				local var_25_1 = Object.Instantiate(arg_22_1.paintGo_)

				var_25_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_25_0)
				var_25_1.name = var_25_0
				var_25_1.transform.parent = arg_22_1.stage_.transform
				var_25_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_22_1.bgs_[var_25_0] = var_25_1
			end

			local var_25_2 = 1

			if var_25_2 < arg_22_1.time_ and arg_22_1.time_ <= var_25_2 + arg_25_0 then
				local var_25_3 = manager.ui.mainCamera.transform.localPosition
				local var_25_4 = Vector3.New(0, 0, 10) + Vector3.New(var_25_3.x, var_25_3.y, 0)
				local var_25_5 = arg_22_1.bgs_.I11l

				var_25_5.transform.localPosition = var_25_4
				var_25_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_25_6 = var_25_5:GetComponent("SpriteRenderer")

				if var_25_6 and var_25_6.sprite then
					local var_25_7 = (var_25_5.transform.localPosition - var_25_3).z
					local var_25_8 = manager.ui.mainCameraCom_
					local var_25_9 = 2 * var_25_7 * Mathf.Tan(var_25_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_25_10 = var_25_9 * var_25_8.aspect
					local var_25_11 = var_25_6.sprite.bounds.size.x
					local var_25_12 = var_25_6.sprite.bounds.size.y
					local var_25_13 = var_25_10 / var_25_11
					local var_25_14 = var_25_9 / var_25_12
					local var_25_15 = var_25_14 < var_25_13 and var_25_13 or var_25_14

					var_25_5.transform.localScale = Vector3.New(var_25_15, var_25_15, 0)
				end

				for iter_25_0, iter_25_1 in pairs(arg_22_1.bgs_) do
					if iter_25_0 ~= "I11l" then
						iter_25_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_25_16 = 0

			if var_25_16 < arg_22_1.time_ and arg_22_1.time_ <= var_25_16 + arg_25_0 then
				arg_22_1.allBtn_.enabled = false
			end

			local var_25_17 = 0.3

			if arg_22_1.time_ >= var_25_16 + var_25_17 and arg_22_1.time_ < var_25_16 + var_25_17 + arg_25_0 then
				arg_22_1.allBtn_.enabled = true
			end

			local var_25_18 = 0

			if var_25_18 < arg_22_1.time_ and arg_22_1.time_ <= var_25_18 + arg_25_0 then
				arg_22_1.mask_.enabled = true
				arg_22_1.mask_.raycastTarget = true

				arg_22_1:SetGaussion(false)
			end

			local var_25_19 = 1

			if var_25_18 <= arg_22_1.time_ and arg_22_1.time_ < var_25_18 + var_25_19 then
				local var_25_20 = (arg_22_1.time_ - var_25_18) / var_25_19
				local var_25_21 = Color.New(0, 0, 0)

				var_25_21.a = Mathf.Lerp(0, 1, var_25_20)
				arg_22_1.mask_.color = var_25_21
			end

			if arg_22_1.time_ >= var_25_18 + var_25_19 and arg_22_1.time_ < var_25_18 + var_25_19 + arg_25_0 then
				local var_25_22 = Color.New(0, 0, 0)

				var_25_22.a = 1
				arg_22_1.mask_.color = var_25_22
			end

			local var_25_23 = 1

			if var_25_23 < arg_22_1.time_ and arg_22_1.time_ <= var_25_23 + arg_25_0 then
				arg_22_1.mask_.enabled = true
				arg_22_1.mask_.raycastTarget = true

				arg_22_1:SetGaussion(false)
			end

			local var_25_24 = 1

			if var_25_23 <= arg_22_1.time_ and arg_22_1.time_ < var_25_23 + var_25_24 then
				local var_25_25 = (arg_22_1.time_ - var_25_23) / var_25_24
				local var_25_26 = Color.New(0, 0, 0)

				var_25_26.a = Mathf.Lerp(1, 0, var_25_25)
				arg_22_1.mask_.color = var_25_26
			end

			if arg_22_1.time_ >= var_25_23 + var_25_24 and arg_22_1.time_ < var_25_23 + var_25_24 + arg_25_0 then
				local var_25_27 = Color.New(0, 0, 0)
				local var_25_28 = 0

				arg_22_1.mask_.enabled = false
				var_25_27.a = var_25_28
				arg_22_1.mask_.color = var_25_27
			end

			if arg_22_1.frameCnt_ <= 1 then
				arg_22_1.dialog_:SetActive(false)
			end

			local var_25_29 = 1.86666666666667
			local var_25_30 = 1.225

			if var_25_29 < arg_22_1.time_ and arg_22_1.time_ <= var_25_29 + arg_25_0 then
				arg_22_1.talkMaxDuration = 0

				arg_22_1.dialog_:SetActive(true)

				arg_22_1.dialogCg_.alpha = 0

				local var_25_31 = LeanTween.value(arg_22_1.dialog_, 0, 1, 0.3)

				var_25_31:setOnUpdate(LuaHelper.FloatAction(function(arg_26_0)
					arg_22_1.dialogCg_.alpha = arg_26_0
				end))
				var_25_31:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_22_1.dialog_)
					var_25_31:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_22_1.duration_ = arg_22_1.duration_ + 0.3

				SetActive(arg_22_1.leftNameGo_, false)

				arg_22_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_22_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_22_1:RecordName(arg_22_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_22_1.iconTrs_.gameObject, false)
				arg_22_1.callingController_:SetSelectedState("normal")

				local var_25_32 = arg_22_1:GetWordFromCfg(319761005)
				local var_25_33 = arg_22_1:FormatText(var_25_32.content)

				arg_22_1.text_.text = var_25_33

				LuaForUtil.ClearLinePrefixSymbol(arg_22_1.text_)

				local var_25_34 = 49
				local var_25_35 = utf8.len(var_25_33)
				local var_25_36 = var_25_34 <= 0 and var_25_30 or var_25_30 * (var_25_35 / var_25_34)

				if var_25_36 > 0 and var_25_30 < var_25_36 then
					arg_22_1.talkMaxDuration = var_25_36
					var_25_29 = var_25_29 + 0.3

					if var_25_36 + var_25_29 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_36 + var_25_29
					end
				end

				arg_22_1.text_.text = var_25_33
				arg_22_1.typewritter.percent = 0

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(false)
				arg_22_1:RecordContent(arg_22_1.text_.text)
			end

			local var_25_37 = var_25_29 + 0.3
			local var_25_38 = math.max(var_25_30, arg_22_1.talkMaxDuration)

			if var_25_37 <= arg_22_1.time_ and arg_22_1.time_ < var_25_37 + var_25_38 then
				arg_22_1.typewritter.percent = (arg_22_1.time_ - var_25_37) / var_25_38

				arg_22_1.typewritter:SetDirty()
			end

			if arg_22_1.time_ >= var_25_37 + var_25_38 and arg_22_1.time_ < var_25_37 + var_25_38 + arg_25_0 then
				arg_22_1.typewritter.percent = 1

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(true)
			end
		end

		arg_22_1.nodeConfigList_ = {}

		arg_22_1:InitPlayNodeList()
	end,
	Play319761006 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 319761006
		arg_28_1.duration_ = 5

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play319761007(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = 0
			local var_31_1 = 1.7

			if var_31_0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_0 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, false)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_2 = arg_28_1:GetWordFromCfg(319761006)
				local var_31_3 = arg_28_1:FormatText(var_31_2.content)

				arg_28_1.text_.text = var_31_3

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_4 = 68
				local var_31_5 = utf8.len(var_31_3)
				local var_31_6 = var_31_4 <= 0 and var_31_1 or var_31_1 * (var_31_5 / var_31_4)

				if var_31_6 > 0 and var_31_1 < var_31_6 then
					arg_28_1.talkMaxDuration = var_31_6

					if var_31_6 + var_31_0 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_6 + var_31_0
					end
				end

				arg_28_1.text_.text = var_31_3
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)
				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_7 = math.max(var_31_1, arg_28_1.talkMaxDuration)

			if var_31_0 <= arg_28_1.time_ and arg_28_1.time_ < var_31_0 + var_31_7 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_0) / var_31_7

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_0 + var_31_7 and arg_28_1.time_ < var_31_0 + var_31_7 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play319761007 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 319761007
		arg_32_1.duration_ = 6.83

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play319761008(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = "ST74"

			if arg_32_1.bgs_[var_35_0] == nil then
				local var_35_1 = Object.Instantiate(arg_32_1.paintGo_)

				var_35_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_35_0)
				var_35_1.name = var_35_0
				var_35_1.transform.parent = arg_32_1.stage_.transform
				var_35_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_32_1.bgs_[var_35_0] = var_35_1
			end

			local var_35_2 = 1

			if var_35_2 < arg_32_1.time_ and arg_32_1.time_ <= var_35_2 + arg_35_0 then
				local var_35_3 = manager.ui.mainCamera.transform.localPosition
				local var_35_4 = Vector3.New(0, 0, 10) + Vector3.New(var_35_3.x, var_35_3.y, 0)
				local var_35_5 = arg_32_1.bgs_.ST74

				var_35_5.transform.localPosition = var_35_4
				var_35_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_35_6 = var_35_5:GetComponent("SpriteRenderer")

				if var_35_6 and var_35_6.sprite then
					local var_35_7 = (var_35_5.transform.localPosition - var_35_3).z
					local var_35_8 = manager.ui.mainCameraCom_
					local var_35_9 = 2 * var_35_7 * Mathf.Tan(var_35_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_35_10 = var_35_9 * var_35_8.aspect
					local var_35_11 = var_35_6.sprite.bounds.size.x
					local var_35_12 = var_35_6.sprite.bounds.size.y
					local var_35_13 = var_35_10 / var_35_11
					local var_35_14 = var_35_9 / var_35_12
					local var_35_15 = var_35_14 < var_35_13 and var_35_13 or var_35_14

					var_35_5.transform.localScale = Vector3.New(var_35_15, var_35_15, 0)
				end

				for iter_35_0, iter_35_1 in pairs(arg_32_1.bgs_) do
					if iter_35_0 ~= "ST74" then
						iter_35_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_35_16 = 0

			if var_35_16 < arg_32_1.time_ and arg_32_1.time_ <= var_35_16 + arg_35_0 then
				arg_32_1.allBtn_.enabled = false
			end

			local var_35_17 = 0.3

			if arg_32_1.time_ >= var_35_16 + var_35_17 and arg_32_1.time_ < var_35_16 + var_35_17 + arg_35_0 then
				arg_32_1.allBtn_.enabled = true
			end

			local var_35_18 = 0

			if var_35_18 < arg_32_1.time_ and arg_32_1.time_ <= var_35_18 + arg_35_0 then
				arg_32_1.mask_.enabled = true
				arg_32_1.mask_.raycastTarget = true

				arg_32_1:SetGaussion(false)
			end

			local var_35_19 = 1

			if var_35_18 <= arg_32_1.time_ and arg_32_1.time_ < var_35_18 + var_35_19 then
				local var_35_20 = (arg_32_1.time_ - var_35_18) / var_35_19
				local var_35_21 = Color.New(0, 0, 0)

				var_35_21.a = Mathf.Lerp(0, 1, var_35_20)
				arg_32_1.mask_.color = var_35_21
			end

			if arg_32_1.time_ >= var_35_18 + var_35_19 and arg_32_1.time_ < var_35_18 + var_35_19 + arg_35_0 then
				local var_35_22 = Color.New(0, 0, 0)

				var_35_22.a = 1
				arg_32_1.mask_.color = var_35_22
			end

			local var_35_23 = 1

			if var_35_23 < arg_32_1.time_ and arg_32_1.time_ <= var_35_23 + arg_35_0 then
				arg_32_1.mask_.enabled = true
				arg_32_1.mask_.raycastTarget = true

				arg_32_1:SetGaussion(false)
			end

			local var_35_24 = 0.966666666666667

			if var_35_23 <= arg_32_1.time_ and arg_32_1.time_ < var_35_23 + var_35_24 then
				local var_35_25 = (arg_32_1.time_ - var_35_23) / var_35_24
				local var_35_26 = Color.New(0, 0, 0)

				var_35_26.a = Mathf.Lerp(1, 0, var_35_25)
				arg_32_1.mask_.color = var_35_26
			end

			if arg_32_1.time_ >= var_35_23 + var_35_24 and arg_32_1.time_ < var_35_23 + var_35_24 + arg_35_0 then
				local var_35_27 = Color.New(0, 0, 0)
				local var_35_28 = 0

				arg_32_1.mask_.enabled = false
				var_35_27.a = var_35_28
				arg_32_1.mask_.color = var_35_27
			end

			if arg_32_1.frameCnt_ <= 1 then
				arg_32_1.dialog_:SetActive(false)
			end

			local var_35_29 = 1.83333333333333
			local var_35_30 = 1.225

			if var_35_29 < arg_32_1.time_ and arg_32_1.time_ <= var_35_29 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0

				arg_32_1.dialog_:SetActive(true)

				arg_32_1.dialogCg_.alpha = 0

				local var_35_31 = LeanTween.value(arg_32_1.dialog_, 0, 1, 0.3)

				var_35_31:setOnUpdate(LuaHelper.FloatAction(function(arg_36_0)
					arg_32_1.dialogCg_.alpha = arg_36_0
				end))
				var_35_31:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_32_1.dialog_)
					var_35_31:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_32_1.duration_ = arg_32_1.duration_ + 0.3

				SetActive(arg_32_1.leftNameGo_, false)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_32 = arg_32_1:GetWordFromCfg(319761007)
				local var_35_33 = arg_32_1:FormatText(var_35_32.content)

				arg_32_1.text_.text = var_35_33

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_34 = 49
				local var_35_35 = utf8.len(var_35_33)
				local var_35_36 = var_35_34 <= 0 and var_35_30 or var_35_30 * (var_35_35 / var_35_34)

				if var_35_36 > 0 and var_35_30 < var_35_36 then
					arg_32_1.talkMaxDuration = var_35_36
					var_35_29 = var_35_29 + 0.3

					if var_35_36 + var_35_29 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_36 + var_35_29
					end
				end

				arg_32_1.text_.text = var_35_33
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)
				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_37 = var_35_29 + 0.3
			local var_35_38 = math.max(var_35_30, arg_32_1.talkMaxDuration)

			if var_35_37 <= arg_32_1.time_ and arg_32_1.time_ < var_35_37 + var_35_38 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_37) / var_35_38

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_37 + var_35_38 and arg_32_1.time_ < var_35_37 + var_35_38 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play319761008 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 319761008
		arg_38_1.duration_ = 5

		SetActive(arg_38_1.tipsGo_, false)

		function arg_38_1.onSingleLineFinish_()
			arg_38_1.onSingleLineUpdate_ = nil
			arg_38_1.onSingleLineFinish_ = nil
			arg_38_1.state_ = "waiting"
		end

		function arg_38_1.playNext_(arg_40_0)
			if arg_40_0 == 1 then
				arg_38_0:Play319761009(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			local var_41_0 = 0
			local var_41_1 = 0.825

			if var_41_0 < arg_38_1.time_ and arg_38_1.time_ <= var_41_0 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0
				arg_38_1.dialogCg_.alpha = 1

				arg_38_1.dialog_:SetActive(true)
				SetActive(arg_38_1.leftNameGo_, false)

				arg_38_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_38_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_38_1:RecordName(arg_38_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_38_1.iconTrs_.gameObject, false)
				arg_38_1.callingController_:SetSelectedState("normal")

				local var_41_2 = arg_38_1:GetWordFromCfg(319761008)
				local var_41_3 = arg_38_1:FormatText(var_41_2.content)

				arg_38_1.text_.text = var_41_3

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_4 = 33
				local var_41_5 = utf8.len(var_41_3)
				local var_41_6 = var_41_4 <= 0 and var_41_1 or var_41_1 * (var_41_5 / var_41_4)

				if var_41_6 > 0 and var_41_1 < var_41_6 then
					arg_38_1.talkMaxDuration = var_41_6

					if var_41_6 + var_41_0 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_6 + var_41_0
					end
				end

				arg_38_1.text_.text = var_41_3
				arg_38_1.typewritter.percent = 0

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(false)
				arg_38_1:RecordContent(arg_38_1.text_.text)
			end

			local var_41_7 = math.max(var_41_1, arg_38_1.talkMaxDuration)

			if var_41_0 <= arg_38_1.time_ and arg_38_1.time_ < var_41_0 + var_41_7 then
				arg_38_1.typewritter.percent = (arg_38_1.time_ - var_41_0) / var_41_7

				arg_38_1.typewritter:SetDirty()
			end

			if arg_38_1.time_ >= var_41_0 + var_41_7 and arg_38_1.time_ < var_41_0 + var_41_7 + arg_41_0 then
				arg_38_1.typewritter.percent = 1

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(true)
			end
		end

		arg_38_1.nodeConfigList_ = {}

		arg_38_1:InitPlayNodeList()
	end,
	Play319761009 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 319761009
		arg_42_1.duration_ = 6.28

		local var_42_0 = {
			zh = 6.283,
			ja = 4.866666666666
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
				arg_42_0:Play319761010(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			local var_45_0 = "D02a"

			if arg_42_1.bgs_[var_45_0] == nil then
				local var_45_1 = Object.Instantiate(arg_42_1.paintGo_)

				var_45_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_45_0)
				var_45_1.name = var_45_0
				var_45_1.transform.parent = arg_42_1.stage_.transform
				var_45_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_42_1.bgs_[var_45_0] = var_45_1
			end

			local var_45_2 = 1

			if var_45_2 < arg_42_1.time_ and arg_42_1.time_ <= var_45_2 + arg_45_0 then
				local var_45_3 = manager.ui.mainCamera.transform.localPosition
				local var_45_4 = Vector3.New(0, 0, 10) + Vector3.New(var_45_3.x, var_45_3.y, 0)
				local var_45_5 = arg_42_1.bgs_.D02a

				var_45_5.transform.localPosition = var_45_4
				var_45_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_45_6 = var_45_5:GetComponent("SpriteRenderer")

				if var_45_6 and var_45_6.sprite then
					local var_45_7 = (var_45_5.transform.localPosition - var_45_3).z
					local var_45_8 = manager.ui.mainCameraCom_
					local var_45_9 = 2 * var_45_7 * Mathf.Tan(var_45_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_45_10 = var_45_9 * var_45_8.aspect
					local var_45_11 = var_45_6.sprite.bounds.size.x
					local var_45_12 = var_45_6.sprite.bounds.size.y
					local var_45_13 = var_45_10 / var_45_11
					local var_45_14 = var_45_9 / var_45_12
					local var_45_15 = var_45_14 < var_45_13 and var_45_13 or var_45_14

					var_45_5.transform.localScale = Vector3.New(var_45_15, var_45_15, 0)
				end

				for iter_45_0, iter_45_1 in pairs(arg_42_1.bgs_) do
					if iter_45_0 ~= "D02a" then
						iter_45_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_45_16 = 0

			if var_45_16 < arg_42_1.time_ and arg_42_1.time_ <= var_45_16 + arg_45_0 then
				arg_42_1.allBtn_.enabled = false
			end

			local var_45_17 = 0.3

			if arg_42_1.time_ >= var_45_16 + var_45_17 and arg_42_1.time_ < var_45_16 + var_45_17 + arg_45_0 then
				arg_42_1.allBtn_.enabled = true
			end

			local var_45_18 = 0

			if var_45_18 < arg_42_1.time_ and arg_42_1.time_ <= var_45_18 + arg_45_0 then
				arg_42_1.mask_.enabled = true
				arg_42_1.mask_.raycastTarget = true

				arg_42_1:SetGaussion(false)
			end

			local var_45_19 = 1

			if var_45_18 <= arg_42_1.time_ and arg_42_1.time_ < var_45_18 + var_45_19 then
				local var_45_20 = (arg_42_1.time_ - var_45_18) / var_45_19
				local var_45_21 = Color.New(0, 0, 0)

				var_45_21.a = Mathf.Lerp(0, 1, var_45_20)
				arg_42_1.mask_.color = var_45_21
			end

			if arg_42_1.time_ >= var_45_18 + var_45_19 and arg_42_1.time_ < var_45_18 + var_45_19 + arg_45_0 then
				local var_45_22 = Color.New(0, 0, 0)

				var_45_22.a = 1
				arg_42_1.mask_.color = var_45_22
			end

			local var_45_23 = 1

			if var_45_23 < arg_42_1.time_ and arg_42_1.time_ <= var_45_23 + arg_45_0 then
				arg_42_1.mask_.enabled = true
				arg_42_1.mask_.raycastTarget = true

				arg_42_1:SetGaussion(false)
			end

			local var_45_24 = 2

			if var_45_23 <= arg_42_1.time_ and arg_42_1.time_ < var_45_23 + var_45_24 then
				local var_45_25 = (arg_42_1.time_ - var_45_23) / var_45_24
				local var_45_26 = Color.New(0, 0, 0)

				var_45_26.a = Mathf.Lerp(1, 0, var_45_25)
				arg_42_1.mask_.color = var_45_26
			end

			if arg_42_1.time_ >= var_45_23 + var_45_24 and arg_42_1.time_ < var_45_23 + var_45_24 + arg_45_0 then
				local var_45_27 = Color.New(0, 0, 0)
				local var_45_28 = 0

				arg_42_1.mask_.enabled = false
				var_45_27.a = var_45_28
				arg_42_1.mask_.color = var_45_27
			end

			local var_45_29 = "1084ui_story"

			if arg_42_1.actors_[var_45_29] == nil then
				local var_45_30 = Asset.Load("Char/" .. "1084ui_story")

				if not isNil(var_45_30) then
					local var_45_31 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_42_1.stage_.transform)

					var_45_31.name = var_45_29
					var_45_31.transform.localPosition = Vector3.New(0, 100, 0)
					arg_42_1.actors_[var_45_29] = var_45_31

					local var_45_32 = var_45_31:GetComponentInChildren(typeof(CharacterEffect))

					var_45_32.enabled = true

					local var_45_33 = GameObjectTools.GetOrAddComponent(var_45_31, typeof(DynamicBoneHelper))

					if var_45_33 then
						var_45_33:EnableDynamicBone(false)
					end

					arg_42_1:ShowWeapon(var_45_32.transform, false)

					arg_42_1.var_[var_45_29 .. "Animator"] = var_45_32.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_42_1.var_[var_45_29 .. "Animator"].applyRootMotion = true
					arg_42_1.var_[var_45_29 .. "LipSync"] = var_45_32.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_45_34 = arg_42_1.actors_["1084ui_story"].transform
			local var_45_35 = 2.86666666666667

			if var_45_35 < arg_42_1.time_ and arg_42_1.time_ <= var_45_35 + arg_45_0 then
				arg_42_1.var_.moveOldPos1084ui_story = var_45_34.localPosition

				local var_45_36 = "1084ui_story"

				arg_42_1:ShowWeapon(arg_42_1.var_[var_45_36 .. "Animator"].transform, false)
			end

			local var_45_37 = 0.001

			if var_45_35 <= arg_42_1.time_ and arg_42_1.time_ < var_45_35 + var_45_37 then
				local var_45_38 = (arg_42_1.time_ - var_45_35) / var_45_37
				local var_45_39 = Vector3.New(0, -0.97, -6)

				var_45_34.localPosition = Vector3.Lerp(arg_42_1.var_.moveOldPos1084ui_story, var_45_39, var_45_38)

				local var_45_40 = manager.ui.mainCamera.transform.position - var_45_34.position

				var_45_34.forward = Vector3.New(var_45_40.x, var_45_40.y, var_45_40.z)

				local var_45_41 = var_45_34.localEulerAngles

				var_45_41.z = 0
				var_45_41.x = 0
				var_45_34.localEulerAngles = var_45_41
			end

			if arg_42_1.time_ >= var_45_35 + var_45_37 and arg_42_1.time_ < var_45_35 + var_45_37 + arg_45_0 then
				var_45_34.localPosition = Vector3.New(0, -0.97, -6)

				local var_45_42 = manager.ui.mainCamera.transform.position - var_45_34.position

				var_45_34.forward = Vector3.New(var_45_42.x, var_45_42.y, var_45_42.z)

				local var_45_43 = var_45_34.localEulerAngles

				var_45_43.z = 0
				var_45_43.x = 0
				var_45_34.localEulerAngles = var_45_43
			end

			local var_45_44 = arg_42_1.actors_["1084ui_story"]
			local var_45_45 = 2.86666666666667

			if var_45_45 < arg_42_1.time_ and arg_42_1.time_ <= var_45_45 + arg_45_0 and not isNil(var_45_44) and arg_42_1.var_.characterEffect1084ui_story == nil then
				arg_42_1.var_.characterEffect1084ui_story = var_45_44:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_45_46 = 0.200000002980232

			if var_45_45 <= arg_42_1.time_ and arg_42_1.time_ < var_45_45 + var_45_46 and not isNil(var_45_44) then
				local var_45_47 = (arg_42_1.time_ - var_45_45) / var_45_46

				if arg_42_1.var_.characterEffect1084ui_story and not isNil(var_45_44) then
					arg_42_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_42_1.time_ >= var_45_45 + var_45_46 and arg_42_1.time_ < var_45_45 + var_45_46 + arg_45_0 and not isNil(var_45_44) and arg_42_1.var_.characterEffect1084ui_story then
				arg_42_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_45_48 = 2.86666666666667

			if var_45_48 < arg_42_1.time_ and arg_42_1.time_ <= var_45_48 + arg_45_0 then
				arg_42_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_45_49 = 2.86666666666667

			if var_45_49 < arg_42_1.time_ and arg_42_1.time_ <= var_45_49 + arg_45_0 then
				arg_42_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			if arg_42_1.frameCnt_ <= 1 then
				arg_42_1.dialog_:SetActive(false)
			end

			local var_45_50 = 2.95
			local var_45_51 = 0.05

			if var_45_50 < arg_42_1.time_ and arg_42_1.time_ <= var_45_50 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0

				arg_42_1.dialog_:SetActive(true)

				arg_42_1.dialogCg_.alpha = 0

				local var_45_52 = LeanTween.value(arg_42_1.dialog_, 0, 1, 0.3)

				var_45_52:setOnUpdate(LuaHelper.FloatAction(function(arg_46_0)
					arg_42_1.dialogCg_.alpha = arg_46_0
				end))
				var_45_52:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_42_1.dialog_)
					var_45_52:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_42_1.duration_ = arg_42_1.duration_ + 0.3

				SetActive(arg_42_1.leftNameGo_, true)

				local var_45_53 = arg_42_1:FormatText(StoryNameCfg[6].name)

				arg_42_1.leftNameTxt_.text = var_45_53

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_42_1.leftNameTxt_.transform)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1.leftNameTxt_.text)
				SetActive(arg_42_1.iconTrs_.gameObject, false)
				arg_42_1.callingController_:SetSelectedState("normal")

				local var_45_54 = arg_42_1:GetWordFromCfg(319761009)
				local var_45_55 = arg_42_1:FormatText(var_45_54.content)

				arg_42_1.text_.text = var_45_55

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_56 = 2
				local var_45_57 = utf8.len(var_45_55)
				local var_45_58 = var_45_56 <= 0 and var_45_51 or var_45_51 * (var_45_57 / var_45_56)

				if var_45_58 > 0 and var_45_51 < var_45_58 then
					arg_42_1.talkMaxDuration = var_45_58
					var_45_50 = var_45_50 + 0.3

					if var_45_58 + var_45_50 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_58 + var_45_50
					end
				end

				arg_42_1.text_.text = var_45_55
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319761", "319761009", "story_v_out_319761.awb") ~= 0 then
					local var_45_59 = manager.audio:GetVoiceLength("story_v_out_319761", "319761009", "story_v_out_319761.awb") / 1000

					if var_45_59 + var_45_50 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_59 + var_45_50
					end

					if var_45_54.prefab_name ~= "" and arg_42_1.actors_[var_45_54.prefab_name] ~= nil then
						local var_45_60 = LuaForUtil.PlayVoiceWithCriLipsync(arg_42_1.actors_[var_45_54.prefab_name].transform, "story_v_out_319761", "319761009", "story_v_out_319761.awb")

						arg_42_1:RecordAudio("319761009", var_45_60)
						arg_42_1:RecordAudio("319761009", var_45_60)
					else
						arg_42_1:AudioAction("play", "voice", "story_v_out_319761", "319761009", "story_v_out_319761.awb")
					end

					arg_42_1:RecordHistoryTalkVoice("story_v_out_319761", "319761009", "story_v_out_319761.awb")
				end

				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_61 = var_45_50 + 0.3
			local var_45_62 = math.max(var_45_51, arg_42_1.talkMaxDuration)

			if var_45_61 <= arg_42_1.time_ and arg_42_1.time_ < var_45_61 + var_45_62 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - var_45_61) / var_45_62

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= var_45_61 + var_45_62 and arg_42_1.time_ < var_45_61 + var_45_62 + arg_45_0 then
				arg_42_1.typewritter.percent = 1

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(true)
			end
		end

		arg_42_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2.86666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_42_1:InitPlayNodeList()
	end,
	Play319761010 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 319761010
		arg_48_1.duration_ = 5

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play319761011(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = arg_48_1.actors_["1084ui_story"]
			local var_51_1 = 0

			if var_51_1 < arg_48_1.time_ and arg_48_1.time_ <= var_51_1 + arg_51_0 and not isNil(var_51_0) and arg_48_1.var_.characterEffect1084ui_story == nil then
				arg_48_1.var_.characterEffect1084ui_story = var_51_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_2 = 0.200000002980232

			if var_51_1 <= arg_48_1.time_ and arg_48_1.time_ < var_51_1 + var_51_2 and not isNil(var_51_0) then
				local var_51_3 = (arg_48_1.time_ - var_51_1) / var_51_2

				if arg_48_1.var_.characterEffect1084ui_story and not isNil(var_51_0) then
					local var_51_4 = Mathf.Lerp(0, 0.5, var_51_3)

					arg_48_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_48_1.var_.characterEffect1084ui_story.fillRatio = var_51_4
				end
			end

			if arg_48_1.time_ >= var_51_1 + var_51_2 and arg_48_1.time_ < var_51_1 + var_51_2 + arg_51_0 and not isNil(var_51_0) and arg_48_1.var_.characterEffect1084ui_story then
				local var_51_5 = 0.5

				arg_48_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_48_1.var_.characterEffect1084ui_story.fillRatio = var_51_5
			end

			local var_51_6 = 0
			local var_51_7 = 1.425

			if var_51_6 < arg_48_1.time_ and arg_48_1.time_ <= var_51_6 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, false)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_8 = arg_48_1:GetWordFromCfg(319761010)
				local var_51_9 = arg_48_1:FormatText(var_51_8.content)

				arg_48_1.text_.text = var_51_9

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_10 = 57
				local var_51_11 = utf8.len(var_51_9)
				local var_51_12 = var_51_10 <= 0 and var_51_7 or var_51_7 * (var_51_11 / var_51_10)

				if var_51_12 > 0 and var_51_7 < var_51_12 then
					arg_48_1.talkMaxDuration = var_51_12

					if var_51_12 + var_51_6 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_12 + var_51_6
					end
				end

				arg_48_1.text_.text = var_51_9
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)
				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_13 = math.max(var_51_7, arg_48_1.talkMaxDuration)

			if var_51_6 <= arg_48_1.time_ and arg_48_1.time_ < var_51_6 + var_51_13 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_6) / var_51_13

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_6 + var_51_13 and arg_48_1.time_ < var_51_6 + var_51_13 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play319761011 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 319761011
		arg_52_1.duration_ = 5

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play319761012(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = 0
			local var_55_1 = 0.65

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

				local var_55_2 = arg_52_1:GetWordFromCfg(319761011)
				local var_55_3 = arg_52_1:FormatText(var_55_2.content)

				arg_52_1.text_.text = var_55_3

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_4 = 26
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
	Play319761012 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 319761012
		arg_56_1.duration_ = 5

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play319761013(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = 0
			local var_59_1 = 1.075

			if var_59_0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_0 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, false)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_2 = arg_56_1:GetWordFromCfg(319761012)
				local var_59_3 = arg_56_1:FormatText(var_59_2.content)

				arg_56_1.text_.text = var_59_3

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_4 = 43
				local var_59_5 = utf8.len(var_59_3)
				local var_59_6 = var_59_4 <= 0 and var_59_1 or var_59_1 * (var_59_5 / var_59_4)

				if var_59_6 > 0 and var_59_1 < var_59_6 then
					arg_56_1.talkMaxDuration = var_59_6

					if var_59_6 + var_59_0 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_6 + var_59_0
					end
				end

				arg_56_1.text_.text = var_59_3
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)
				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_7 = math.max(var_59_1, arg_56_1.talkMaxDuration)

			if var_59_0 <= arg_56_1.time_ and arg_56_1.time_ < var_59_0 + var_59_7 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_0) / var_59_7

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_0 + var_59_7 and arg_56_1.time_ < var_59_0 + var_59_7 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play319761013 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 319761013
		arg_60_1.duration_ = 7.5

		local var_60_0 = {
			zh = 6,
			ja = 7.5
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
				arg_60_0:Play319761014(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = arg_60_1.actors_["1084ui_story"]
			local var_63_1 = 0

			if var_63_1 < arg_60_1.time_ and arg_60_1.time_ <= var_63_1 + arg_63_0 and not isNil(var_63_0) and arg_60_1.var_.characterEffect1084ui_story == nil then
				arg_60_1.var_.characterEffect1084ui_story = var_63_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_2 = 0.200000002980232

			if var_63_1 <= arg_60_1.time_ and arg_60_1.time_ < var_63_1 + var_63_2 and not isNil(var_63_0) then
				local var_63_3 = (arg_60_1.time_ - var_63_1) / var_63_2

				if arg_60_1.var_.characterEffect1084ui_story and not isNil(var_63_0) then
					arg_60_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_60_1.time_ >= var_63_1 + var_63_2 and arg_60_1.time_ < var_63_1 + var_63_2 + arg_63_0 and not isNil(var_63_0) and arg_60_1.var_.characterEffect1084ui_story then
				arg_60_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_63_4 = 0
			local var_63_5 = 0.5

			if var_63_4 < arg_60_1.time_ and arg_60_1.time_ <= var_63_4 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				local var_63_6 = arg_60_1:FormatText(StoryNameCfg[6].name)

				arg_60_1.leftNameTxt_.text = var_63_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_7 = arg_60_1:GetWordFromCfg(319761013)
				local var_63_8 = arg_60_1:FormatText(var_63_7.content)

				arg_60_1.text_.text = var_63_8

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_9 = 20
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

				if manager.audio:GetVoiceLength("story_v_out_319761", "319761013", "story_v_out_319761.awb") ~= 0 then
					local var_63_12 = manager.audio:GetVoiceLength("story_v_out_319761", "319761013", "story_v_out_319761.awb") / 1000

					if var_63_12 + var_63_4 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_12 + var_63_4
					end

					if var_63_7.prefab_name ~= "" and arg_60_1.actors_[var_63_7.prefab_name] ~= nil then
						local var_63_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_7.prefab_name].transform, "story_v_out_319761", "319761013", "story_v_out_319761.awb")

						arg_60_1:RecordAudio("319761013", var_63_13)
						arg_60_1:RecordAudio("319761013", var_63_13)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_319761", "319761013", "story_v_out_319761.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_319761", "319761013", "story_v_out_319761.awb")
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
	Play319761014 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 319761014
		arg_64_1.duration_ = 8.27

		local var_64_0 = {
			zh = 6.9,
			ja = 8.266
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
				arg_64_0:Play319761015(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = arg_64_1.actors_["1084ui_story"].transform
			local var_67_1 = 0

			if var_67_1 < arg_64_1.time_ and arg_64_1.time_ <= var_67_1 + arg_67_0 then
				arg_64_1.var_.moveOldPos1084ui_story = var_67_0.localPosition
			end

			local var_67_2 = 0.001

			if var_67_1 <= arg_64_1.time_ and arg_64_1.time_ < var_67_1 + var_67_2 then
				local var_67_3 = (arg_64_1.time_ - var_67_1) / var_67_2
				local var_67_4 = Vector3.New(0, -0.97, -6)

				var_67_0.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos1084ui_story, var_67_4, var_67_3)

				local var_67_5 = manager.ui.mainCamera.transform.position - var_67_0.position

				var_67_0.forward = Vector3.New(var_67_5.x, var_67_5.y, var_67_5.z)

				local var_67_6 = var_67_0.localEulerAngles

				var_67_6.z = 0
				var_67_6.x = 0
				var_67_0.localEulerAngles = var_67_6
			end

			if arg_64_1.time_ >= var_67_1 + var_67_2 and arg_64_1.time_ < var_67_1 + var_67_2 + arg_67_0 then
				var_67_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_67_7 = manager.ui.mainCamera.transform.position - var_67_0.position

				var_67_0.forward = Vector3.New(var_67_7.x, var_67_7.y, var_67_7.z)

				local var_67_8 = var_67_0.localEulerAngles

				var_67_8.z = 0
				var_67_8.x = 0
				var_67_0.localEulerAngles = var_67_8
			end

			local var_67_9 = arg_64_1.actors_["1084ui_story"]
			local var_67_10 = 0

			if var_67_10 < arg_64_1.time_ and arg_64_1.time_ <= var_67_10 + arg_67_0 and not isNil(var_67_9) and arg_64_1.var_.characterEffect1084ui_story == nil then
				arg_64_1.var_.characterEffect1084ui_story = var_67_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_11 = 0.200000002980232

			if var_67_10 <= arg_64_1.time_ and arg_64_1.time_ < var_67_10 + var_67_11 and not isNil(var_67_9) then
				local var_67_12 = (arg_64_1.time_ - var_67_10) / var_67_11

				if arg_64_1.var_.characterEffect1084ui_story and not isNil(var_67_9) then
					arg_64_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_64_1.time_ >= var_67_10 + var_67_11 and arg_64_1.time_ < var_67_10 + var_67_11 + arg_67_0 and not isNil(var_67_9) and arg_64_1.var_.characterEffect1084ui_story then
				arg_64_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_67_13 = 0

			if var_67_13 < arg_64_1.time_ and arg_64_1.time_ <= var_67_13 + arg_67_0 then
				arg_64_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action12_1")
			end

			local var_67_14 = 0

			if var_67_14 < arg_64_1.time_ and arg_64_1.time_ <= var_67_14 + arg_67_0 then
				arg_64_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_67_15 = 0
			local var_67_16 = 0.675

			if var_67_15 < arg_64_1.time_ and arg_64_1.time_ <= var_67_15 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				local var_67_17 = arg_64_1:FormatText(StoryNameCfg[6].name)

				arg_64_1.leftNameTxt_.text = var_67_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_18 = arg_64_1:GetWordFromCfg(319761014)
				local var_67_19 = arg_64_1:FormatText(var_67_18.content)

				arg_64_1.text_.text = var_67_19

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_20 = 27
				local var_67_21 = utf8.len(var_67_19)
				local var_67_22 = var_67_20 <= 0 and var_67_16 or var_67_16 * (var_67_21 / var_67_20)

				if var_67_22 > 0 and var_67_16 < var_67_22 then
					arg_64_1.talkMaxDuration = var_67_22

					if var_67_22 + var_67_15 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_22 + var_67_15
					end
				end

				arg_64_1.text_.text = var_67_19
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319761", "319761014", "story_v_out_319761.awb") ~= 0 then
					local var_67_23 = manager.audio:GetVoiceLength("story_v_out_319761", "319761014", "story_v_out_319761.awb") / 1000

					if var_67_23 + var_67_15 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_23 + var_67_15
					end

					if var_67_18.prefab_name ~= "" and arg_64_1.actors_[var_67_18.prefab_name] ~= nil then
						local var_67_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_18.prefab_name].transform, "story_v_out_319761", "319761014", "story_v_out_319761.awb")

						arg_64_1:RecordAudio("319761014", var_67_24)
						arg_64_1:RecordAudio("319761014", var_67_24)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_319761", "319761014", "story_v_out_319761.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_319761", "319761014", "story_v_out_319761.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_25 = math.max(var_67_16, arg_64_1.talkMaxDuration)

			if var_67_15 <= arg_64_1.time_ and arg_64_1.time_ < var_67_15 + var_67_25 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_15) / var_67_25

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_15 + var_67_25 and arg_64_1.time_ < var_67_15 + var_67_25 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {
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

		arg_64_1:InitPlayNodeList()
	end,
	Play319761015 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 319761015
		arg_68_1.duration_ = 5

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"
		end

		function arg_68_1.playNext_(arg_70_0)
			if arg_70_0 == 1 then
				arg_68_0:Play319761016(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = arg_68_1.actors_["1084ui_story"]
			local var_71_1 = 0

			if var_71_1 < arg_68_1.time_ and arg_68_1.time_ <= var_71_1 + arg_71_0 and not isNil(var_71_0) and arg_68_1.var_.characterEffect1084ui_story == nil then
				arg_68_1.var_.characterEffect1084ui_story = var_71_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_2 = 0.200000002980232

			if var_71_1 <= arg_68_1.time_ and arg_68_1.time_ < var_71_1 + var_71_2 and not isNil(var_71_0) then
				local var_71_3 = (arg_68_1.time_ - var_71_1) / var_71_2

				if arg_68_1.var_.characterEffect1084ui_story and not isNil(var_71_0) then
					local var_71_4 = Mathf.Lerp(0, 0.5, var_71_3)

					arg_68_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_68_1.var_.characterEffect1084ui_story.fillRatio = var_71_4
				end
			end

			if arg_68_1.time_ >= var_71_1 + var_71_2 and arg_68_1.time_ < var_71_1 + var_71_2 + arg_71_0 and not isNil(var_71_0) and arg_68_1.var_.characterEffect1084ui_story then
				local var_71_5 = 0.5

				arg_68_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_68_1.var_.characterEffect1084ui_story.fillRatio = var_71_5
			end

			local var_71_6 = 0
			local var_71_7 = 0.4

			if var_71_6 < arg_68_1.time_ and arg_68_1.time_ <= var_71_6 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, false)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_8 = arg_68_1:GetWordFromCfg(319761015)
				local var_71_9 = arg_68_1:FormatText(var_71_8.content)

				arg_68_1.text_.text = var_71_9

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_10 = 16
				local var_71_11 = utf8.len(var_71_9)
				local var_71_12 = var_71_10 <= 0 and var_71_7 or var_71_7 * (var_71_11 / var_71_10)

				if var_71_12 > 0 and var_71_7 < var_71_12 then
					arg_68_1.talkMaxDuration = var_71_12

					if var_71_12 + var_71_6 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_12 + var_71_6
					end
				end

				arg_68_1.text_.text = var_71_9
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)
				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_13 = math.max(var_71_7, arg_68_1.talkMaxDuration)

			if var_71_6 <= arg_68_1.time_ and arg_68_1.time_ < var_71_6 + var_71_13 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_6) / var_71_13

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_6 + var_71_13 and arg_68_1.time_ < var_71_6 + var_71_13 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {}

		arg_68_1:InitPlayNodeList()
	end,
	Play319761016 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 319761016
		arg_72_1.duration_ = 5

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play319761017(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = 0
			local var_75_1 = 1

			if var_75_0 < arg_72_1.time_ and arg_72_1.time_ <= var_75_0 + arg_75_0 then
				local var_75_2 = "play"
				local var_75_3 = "effect"

				arg_72_1:AudioAction(var_75_2, var_75_3, "se_story_130", "se_story_130_paper", "")
			end

			local var_75_4 = arg_72_1.actors_["1084ui_story"].transform
			local var_75_5 = 0

			if var_75_5 < arg_72_1.time_ and arg_72_1.time_ <= var_75_5 + arg_75_0 then
				arg_72_1.var_.moveOldPos1084ui_story = var_75_4.localPosition
			end

			local var_75_6 = 0.001

			if var_75_5 <= arg_72_1.time_ and arg_72_1.time_ < var_75_5 + var_75_6 then
				local var_75_7 = (arg_72_1.time_ - var_75_5) / var_75_6
				local var_75_8 = Vector3.New(0, 100, 0)

				var_75_4.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPos1084ui_story, var_75_8, var_75_7)

				local var_75_9 = manager.ui.mainCamera.transform.position - var_75_4.position

				var_75_4.forward = Vector3.New(var_75_9.x, var_75_9.y, var_75_9.z)

				local var_75_10 = var_75_4.localEulerAngles

				var_75_10.z = 0
				var_75_10.x = 0
				var_75_4.localEulerAngles = var_75_10
			end

			if arg_72_1.time_ >= var_75_5 + var_75_6 and arg_72_1.time_ < var_75_5 + var_75_6 + arg_75_0 then
				var_75_4.localPosition = Vector3.New(0, 100, 0)

				local var_75_11 = manager.ui.mainCamera.transform.position - var_75_4.position

				var_75_4.forward = Vector3.New(var_75_11.x, var_75_11.y, var_75_11.z)

				local var_75_12 = var_75_4.localEulerAngles

				var_75_12.z = 0
				var_75_12.x = 0
				var_75_4.localEulerAngles = var_75_12
			end

			local var_75_13 = 0
			local var_75_14 = 0.65

			if var_75_13 < arg_72_1.time_ and arg_72_1.time_ <= var_75_13 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, false)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_15 = arg_72_1:GetWordFromCfg(319761016)
				local var_75_16 = arg_72_1:FormatText(var_75_15.content)

				arg_72_1.text_.text = var_75_16

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_17 = 26
				local var_75_18 = utf8.len(var_75_16)
				local var_75_19 = var_75_17 <= 0 and var_75_14 or var_75_14 * (var_75_18 / var_75_17)

				if var_75_19 > 0 and var_75_14 < var_75_19 then
					arg_72_1.talkMaxDuration = var_75_19

					if var_75_19 + var_75_13 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_19 + var_75_13
					end
				end

				arg_72_1.text_.text = var_75_16
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)
				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_20 = math.max(var_75_14, arg_72_1.talkMaxDuration)

			if var_75_13 <= arg_72_1.time_ and arg_72_1.time_ < var_75_13 + var_75_20 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_13) / var_75_20

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_13 + var_75_20 and arg_72_1.time_ < var_75_13 + var_75_20 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {
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

		arg_72_1:InitPlayNodeList()
	end,
	Play319761017 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 319761017
		arg_76_1.duration_ = 5

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play319761018(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = 0
			local var_79_1 = 1.125

			if var_79_0 < arg_76_1.time_ and arg_76_1.time_ <= var_79_0 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, false)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_2 = arg_76_1:GetWordFromCfg(319761017)
				local var_79_3 = arg_76_1:FormatText(var_79_2.content)

				arg_76_1.text_.text = var_79_3

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_4 = 45
				local var_79_5 = utf8.len(var_79_3)
				local var_79_6 = var_79_4 <= 0 and var_79_1 or var_79_1 * (var_79_5 / var_79_4)

				if var_79_6 > 0 and var_79_1 < var_79_6 then
					arg_76_1.talkMaxDuration = var_79_6

					if var_79_6 + var_79_0 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_6 + var_79_0
					end
				end

				arg_76_1.text_.text = var_79_3
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)
				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_7 = math.max(var_79_1, arg_76_1.talkMaxDuration)

			if var_79_0 <= arg_76_1.time_ and arg_76_1.time_ < var_79_0 + var_79_7 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_0) / var_79_7

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_0 + var_79_7 and arg_76_1.time_ < var_79_0 + var_79_7 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {}

		arg_76_1:InitPlayNodeList()
	end,
	Play319761018 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 319761018
		arg_80_1.duration_ = 5.2

		local var_80_0 = {
			zh = 4.266,
			ja = 5.2
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
				arg_80_0:Play319761019(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = "ML0202"

			if arg_80_1.bgs_[var_83_0] == nil then
				local var_83_1 = Object.Instantiate(arg_80_1.paintGo_)

				var_83_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_83_0)
				var_83_1.name = var_83_0
				var_83_1.transform.parent = arg_80_1.stage_.transform
				var_83_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_80_1.bgs_[var_83_0] = var_83_1
			end

			local var_83_2 = 0.983333333333333

			if var_83_2 < arg_80_1.time_ and arg_80_1.time_ <= var_83_2 + arg_83_0 then
				local var_83_3 = manager.ui.mainCamera.transform.localPosition
				local var_83_4 = Vector3.New(0, 0, 10) + Vector3.New(var_83_3.x, var_83_3.y, 0)
				local var_83_5 = arg_80_1.bgs_.ML0202

				var_83_5.transform.localPosition = var_83_4
				var_83_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_83_6 = var_83_5:GetComponent("SpriteRenderer")

				if var_83_6 and var_83_6.sprite then
					local var_83_7 = (var_83_5.transform.localPosition - var_83_3).z
					local var_83_8 = manager.ui.mainCameraCom_
					local var_83_9 = 2 * var_83_7 * Mathf.Tan(var_83_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_83_10 = var_83_9 * var_83_8.aspect
					local var_83_11 = var_83_6.sprite.bounds.size.x
					local var_83_12 = var_83_6.sprite.bounds.size.y
					local var_83_13 = var_83_10 / var_83_11
					local var_83_14 = var_83_9 / var_83_12
					local var_83_15 = var_83_14 < var_83_13 and var_83_13 or var_83_14

					var_83_5.transform.localScale = Vector3.New(var_83_15, var_83_15, 0)
				end

				for iter_83_0, iter_83_1 in pairs(arg_80_1.bgs_) do
					if iter_83_0 ~= "ML0202" then
						iter_83_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_83_16 = 0

			if var_83_16 < arg_80_1.time_ and arg_80_1.time_ <= var_83_16 + arg_83_0 then
				arg_80_1.allBtn_.enabled = false
			end

			local var_83_17 = 0.3

			if arg_80_1.time_ >= var_83_16 + var_83_17 and arg_80_1.time_ < var_83_16 + var_83_17 + arg_83_0 then
				arg_80_1.allBtn_.enabled = true
			end

			local var_83_18 = 0

			if var_83_18 < arg_80_1.time_ and arg_80_1.time_ <= var_83_18 + arg_83_0 then
				arg_80_1.mask_.enabled = true
				arg_80_1.mask_.raycastTarget = true

				arg_80_1:SetGaussion(false)
			end

			local var_83_19 = 1

			if var_83_18 <= arg_80_1.time_ and arg_80_1.time_ < var_83_18 + var_83_19 then
				local var_83_20 = (arg_80_1.time_ - var_83_18) / var_83_19
				local var_83_21 = Color.New(0, 0, 0)

				var_83_21.a = Mathf.Lerp(0, 1, var_83_20)
				arg_80_1.mask_.color = var_83_21
			end

			if arg_80_1.time_ >= var_83_18 + var_83_19 and arg_80_1.time_ < var_83_18 + var_83_19 + arg_83_0 then
				local var_83_22 = Color.New(0, 0, 0)

				var_83_22.a = 1
				arg_80_1.mask_.color = var_83_22
			end

			local var_83_23 = 1

			if var_83_23 < arg_80_1.time_ and arg_80_1.time_ <= var_83_23 + arg_83_0 then
				arg_80_1.mask_.enabled = true
				arg_80_1.mask_.raycastTarget = true

				arg_80_1:SetGaussion(false)
			end

			local var_83_24 = 2

			if var_83_23 <= arg_80_1.time_ and arg_80_1.time_ < var_83_23 + var_83_24 then
				local var_83_25 = (arg_80_1.time_ - var_83_23) / var_83_24
				local var_83_26 = Color.New(0, 0, 0)

				var_83_26.a = Mathf.Lerp(1, 0, var_83_25)
				arg_80_1.mask_.color = var_83_26
			end

			if arg_80_1.time_ >= var_83_23 + var_83_24 and arg_80_1.time_ < var_83_23 + var_83_24 + arg_83_0 then
				local var_83_27 = Color.New(0, 0, 0)
				local var_83_28 = 0

				arg_80_1.mask_.enabled = false
				var_83_27.a = var_83_28
				arg_80_1.mask_.color = var_83_27
			end

			local var_83_29 = "10079ui_story"

			if arg_80_1.actors_[var_83_29] == nil then
				local var_83_30 = Asset.Load("Char/" .. "10079ui_story")

				if not isNil(var_83_30) then
					local var_83_31 = Object.Instantiate(Asset.Load("Char/" .. "10079ui_story"), arg_80_1.stage_.transform)

					var_83_31.name = var_83_29
					var_83_31.transform.localPosition = Vector3.New(0, 100, 0)
					arg_80_1.actors_[var_83_29] = var_83_31

					local var_83_32 = var_83_31:GetComponentInChildren(typeof(CharacterEffect))

					var_83_32.enabled = true

					local var_83_33 = GameObjectTools.GetOrAddComponent(var_83_31, typeof(DynamicBoneHelper))

					if var_83_33 then
						var_83_33:EnableDynamicBone(false)
					end

					arg_80_1:ShowWeapon(var_83_32.transform, false)

					arg_80_1.var_[var_83_29 .. "Animator"] = var_83_32.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_80_1.var_[var_83_29 .. "Animator"].applyRootMotion = true
					arg_80_1.var_[var_83_29 .. "LipSync"] = var_83_32.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_83_34 = arg_80_1.actors_["10079ui_story"].transform
			local var_83_35 = 0

			if var_83_35 < arg_80_1.time_ and arg_80_1.time_ <= var_83_35 + arg_83_0 then
				arg_80_1.var_.moveOldPos10079ui_story = var_83_34.localPosition
			end

			local var_83_36 = 0.001

			if var_83_35 <= arg_80_1.time_ and arg_80_1.time_ < var_83_35 + var_83_36 then
				local var_83_37 = (arg_80_1.time_ - var_83_35) / var_83_36
				local var_83_38 = Vector3.New(0, 100, 0)

				var_83_34.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPos10079ui_story, var_83_38, var_83_37)

				local var_83_39 = manager.ui.mainCamera.transform.position - var_83_34.position

				var_83_34.forward = Vector3.New(var_83_39.x, var_83_39.y, var_83_39.z)

				local var_83_40 = var_83_34.localEulerAngles

				var_83_40.z = 0
				var_83_40.x = 0
				var_83_34.localEulerAngles = var_83_40
			end

			if arg_80_1.time_ >= var_83_35 + var_83_36 and arg_80_1.time_ < var_83_35 + var_83_36 + arg_83_0 then
				var_83_34.localPosition = Vector3.New(0, 100, 0)

				local var_83_41 = manager.ui.mainCamera.transform.position - var_83_34.position

				var_83_34.forward = Vector3.New(var_83_41.x, var_83_41.y, var_83_41.z)

				local var_83_42 = var_83_34.localEulerAngles

				var_83_42.z = 0
				var_83_42.x = 0
				var_83_34.localEulerAngles = var_83_42
			end

			local var_83_43 = arg_80_1.actors_["10079ui_story"]
			local var_83_44 = 0

			if var_83_44 < arg_80_1.time_ and arg_80_1.time_ <= var_83_44 + arg_83_0 and not isNil(var_83_43) and arg_80_1.var_.characterEffect10079ui_story == nil then
				arg_80_1.var_.characterEffect10079ui_story = var_83_43:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_45 = 0.200000002980232

			if var_83_44 <= arg_80_1.time_ and arg_80_1.time_ < var_83_44 + var_83_45 and not isNil(var_83_43) then
				local var_83_46 = (arg_80_1.time_ - var_83_44) / var_83_45

				if arg_80_1.var_.characterEffect10079ui_story and not isNil(var_83_43) then
					arg_80_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_80_1.time_ >= var_83_44 + var_83_45 and arg_80_1.time_ < var_83_44 + var_83_45 + arg_83_0 and not isNil(var_83_43) and arg_80_1.var_.characterEffect10079ui_story then
				arg_80_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_83_47 = 0
			local var_83_48 = 0.2

			if var_83_47 < arg_80_1.time_ and arg_80_1.time_ <= var_83_47 + arg_83_0 then
				local var_83_49 = "play"
				local var_83_50 = "music"

				arg_80_1:AudioAction(var_83_49, var_83_50, "ui_battle", "ui_battle_stopbgm", "")

				local var_83_51 = ""
				local var_83_52 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_83_52 ~= "" then
					if arg_80_1.bgmTxt_.text ~= var_83_52 and arg_80_1.bgmTxt_.text ~= "" then
						if arg_80_1.bgmTxt2_.text ~= "" then
							arg_80_1.bgmTxt_.text = arg_80_1.bgmTxt2_.text
						end

						arg_80_1.bgmTxt2_.text = var_83_52

						arg_80_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_80_1.bgmTxt_.text = var_83_52
						arg_80_1.bgmTxt2_.text = var_83_52
					end

					if arg_80_1.bgmTimer then
						arg_80_1.bgmTimer:Stop()

						arg_80_1.bgmTimer = nil
					end

					if arg_80_1.settingData.show_music_name == 1 then
						arg_80_1.musicController:SetSelectedState("show")
						arg_80_1.musicAnimator_:Play("open", 0, 0)

						if arg_80_1.settingData.music_time ~= 0 then
							arg_80_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_80_1.settingData.music_time), function()
								if arg_80_1 == nil or isNil(arg_80_1.bgmTxt_) then
									return
								end

								arg_80_1.musicController:SetSelectedState("hide")
								arg_80_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_83_53 = 0.233333333333333
			local var_83_54 = 1

			if var_83_53 < arg_80_1.time_ and arg_80_1.time_ <= var_83_53 + arg_83_0 then
				local var_83_55 = "play"
				local var_83_56 = "music"

				arg_80_1:AudioAction(var_83_55, var_83_56, "bgm_activity_3_0_story_sad", "bgm_activity_3_0_story_sad", "bgm_activity_3_0_story_sad.awb")

				local var_83_57 = ""
				local var_83_58 = manager.audio:GetAudioName("bgm_activity_3_0_story_sad", "bgm_activity_3_0_story_sad")

				if var_83_58 ~= "" then
					if arg_80_1.bgmTxt_.text ~= var_83_58 and arg_80_1.bgmTxt_.text ~= "" then
						if arg_80_1.bgmTxt2_.text ~= "" then
							arg_80_1.bgmTxt_.text = arg_80_1.bgmTxt2_.text
						end

						arg_80_1.bgmTxt2_.text = var_83_58

						arg_80_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_80_1.bgmTxt_.text = var_83_58
						arg_80_1.bgmTxt2_.text = var_83_58
					end

					if arg_80_1.bgmTimer then
						arg_80_1.bgmTimer:Stop()

						arg_80_1.bgmTimer = nil
					end

					if arg_80_1.settingData.show_music_name == 1 then
						arg_80_1.musicController:SetSelectedState("show")
						arg_80_1.musicAnimator_:Play("open", 0, 0)

						if arg_80_1.settingData.music_time ~= 0 then
							arg_80_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_80_1.settingData.music_time), function()
								if arg_80_1 == nil or isNil(arg_80_1.bgmTxt_) then
									return
								end

								arg_80_1.musicController:SetSelectedState("hide")
								arg_80_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_83_59 = arg_80_1.bgs_.ML0202.transform
			local var_83_60 = 1

			if var_83_60 < arg_80_1.time_ and arg_80_1.time_ <= var_83_60 + arg_83_0 then
				arg_80_1.var_.moveOldPosML0202 = var_83_59.localPosition
			end

			local var_83_61 = 0.001

			if var_83_60 <= arg_80_1.time_ and arg_80_1.time_ < var_83_60 + var_83_61 then
				local var_83_62 = (arg_80_1.time_ - var_83_60) / var_83_61
				local var_83_63 = Vector3.New(0, 1, 9)

				var_83_59.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPosML0202, var_83_63, var_83_62)
			end

			if arg_80_1.time_ >= var_83_60 + var_83_61 and arg_80_1.time_ < var_83_60 + var_83_61 + arg_83_0 then
				var_83_59.localPosition = Vector3.New(0, 1, 9)
			end

			local var_83_64 = arg_80_1.bgs_.ML0202.transform
			local var_83_65 = 1.01666666666667

			if var_83_65 < arg_80_1.time_ and arg_80_1.time_ <= var_83_65 + arg_83_0 then
				arg_80_1.var_.moveOldPosML0202 = var_83_64.localPosition
			end

			local var_83_66 = 3.11666666666667

			if var_83_65 <= arg_80_1.time_ and arg_80_1.time_ < var_83_65 + var_83_66 then
				local var_83_67 = (arg_80_1.time_ - var_83_65) / var_83_66
				local var_83_68 = Vector3.New(0, 1, 10)

				var_83_64.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPosML0202, var_83_68, var_83_67)
			end

			if arg_80_1.time_ >= var_83_65 + var_83_66 and arg_80_1.time_ < var_83_65 + var_83_66 + arg_83_0 then
				var_83_64.localPosition = Vector3.New(0, 1, 10)
			end

			local var_83_69 = 1.01666666666667

			if var_83_69 < arg_80_1.time_ and arg_80_1.time_ <= var_83_69 + arg_83_0 then
				arg_80_1.allBtn_.enabled = false
			end

			local var_83_70 = 2.58333333333333

			if arg_80_1.time_ >= var_83_69 + var_83_70 and arg_80_1.time_ < var_83_69 + var_83_70 + arg_83_0 then
				arg_80_1.allBtn_.enabled = true
			end

			if arg_80_1.frameCnt_ <= 1 then
				arg_80_1.dialog_:SetActive(false)
			end

			local var_83_71 = 2.8
			local var_83_72 = 0.125

			if var_83_71 < arg_80_1.time_ and arg_80_1.time_ <= var_83_71 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0

				arg_80_1.dialog_:SetActive(true)

				arg_80_1.dialogCg_.alpha = 0

				local var_83_73 = LeanTween.value(arg_80_1.dialog_, 0, 1, 0.3)

				var_83_73:setOnUpdate(LuaHelper.FloatAction(function(arg_86_0)
					arg_80_1.dialogCg_.alpha = arg_86_0
				end))
				var_83_73:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_80_1.dialog_)
					var_83_73:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_80_1.duration_ = arg_80_1.duration_ + 0.3

				SetActive(arg_80_1.leftNameGo_, true)

				local var_83_74 = arg_80_1:FormatText(StoryNameCfg[6].name)

				arg_80_1.leftNameTxt_.text = var_83_74

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_75 = arg_80_1:GetWordFromCfg(319761018)
				local var_83_76 = arg_80_1:FormatText(var_83_75.content)

				arg_80_1.text_.text = var_83_76

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_77 = 5
				local var_83_78 = utf8.len(var_83_76)
				local var_83_79 = var_83_77 <= 0 and var_83_72 or var_83_72 * (var_83_78 / var_83_77)

				if var_83_79 > 0 and var_83_72 < var_83_79 then
					arg_80_1.talkMaxDuration = var_83_79
					var_83_71 = var_83_71 + 0.3

					if var_83_79 + var_83_71 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_79 + var_83_71
					end
				end

				arg_80_1.text_.text = var_83_76
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319761", "319761018", "story_v_out_319761.awb") ~= 0 then
					local var_83_80 = manager.audio:GetVoiceLength("story_v_out_319761", "319761018", "story_v_out_319761.awb") / 1000

					if var_83_80 + var_83_71 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_80 + var_83_71
					end

					if var_83_75.prefab_name ~= "" and arg_80_1.actors_[var_83_75.prefab_name] ~= nil then
						local var_83_81 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_75.prefab_name].transform, "story_v_out_319761", "319761018", "story_v_out_319761.awb")

						arg_80_1:RecordAudio("319761018", var_83_81)
						arg_80_1:RecordAudio("319761018", var_83_81)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_out_319761", "319761018", "story_v_out_319761.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_out_319761", "319761018", "story_v_out_319761.awb")
				end

				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_82 = var_83_71 + 0.3
			local var_83_83 = math.max(var_83_72, arg_80_1.talkMaxDuration)

			if var_83_82 <= arg_80_1.time_ and arg_80_1.time_ < var_83_82 + var_83_83 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_82) / var_83_83

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_82 + var_83_83 and arg_80_1.time_ < var_83_82 + var_83_83 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "ML0202",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "ML0202",
				changeDisplayLayer = false,
				needEase = false,
				duration = 3.11666666666667,
				className = "StoryMoveNode",
				startTime = 1.01666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_80_1:InitPlayNodeList()
	end,
	Play319761019 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 319761019
		arg_88_1.duration_ = 2.7

		local var_88_0 = {
			zh = 2.666,
			ja = 2.7
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
				arg_88_0:Play319761020(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = 0
			local var_91_1 = 0.2

			if var_91_0 < arg_88_1.time_ and arg_88_1.time_ <= var_91_0 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				local var_91_2 = arg_88_1:FormatText(StoryNameCfg[6].name)

				arg_88_1.leftNameTxt_.text = var_91_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_3 = arg_88_1:GetWordFromCfg(319761019)
				local var_91_4 = arg_88_1:FormatText(var_91_3.content)

				arg_88_1.text_.text = var_91_4

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_5 = 8
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

				if manager.audio:GetVoiceLength("story_v_out_319761", "319761019", "story_v_out_319761.awb") ~= 0 then
					local var_91_8 = manager.audio:GetVoiceLength("story_v_out_319761", "319761019", "story_v_out_319761.awb") / 1000

					if var_91_8 + var_91_0 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_8 + var_91_0
					end

					if var_91_3.prefab_name ~= "" and arg_88_1.actors_[var_91_3.prefab_name] ~= nil then
						local var_91_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_88_1.actors_[var_91_3.prefab_name].transform, "story_v_out_319761", "319761019", "story_v_out_319761.awb")

						arg_88_1:RecordAudio("319761019", var_91_9)
						arg_88_1:RecordAudio("319761019", var_91_9)
					else
						arg_88_1:AudioAction("play", "voice", "story_v_out_319761", "319761019", "story_v_out_319761.awb")
					end

					arg_88_1:RecordHistoryTalkVoice("story_v_out_319761", "319761019", "story_v_out_319761.awb")
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
	Play319761020 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 319761020
		arg_92_1.duration_ = 5

		SetActive(arg_92_1.tipsGo_, false)

		function arg_92_1.onSingleLineFinish_()
			arg_92_1.onSingleLineUpdate_ = nil
			arg_92_1.onSingleLineFinish_ = nil
			arg_92_1.state_ = "waiting"
		end

		function arg_92_1.playNext_(arg_94_0)
			if arg_94_0 == 1 then
				arg_92_0:Play319761021(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			local var_95_0 = 0
			local var_95_1 = 1.125

			if var_95_0 < arg_92_1.time_ and arg_92_1.time_ <= var_95_0 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, false)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_2 = arg_92_1:GetWordFromCfg(319761020)
				local var_95_3 = arg_92_1:FormatText(var_95_2.content)

				arg_92_1.text_.text = var_95_3

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_4 = 45
				local var_95_5 = utf8.len(var_95_3)
				local var_95_6 = var_95_4 <= 0 and var_95_1 or var_95_1 * (var_95_5 / var_95_4)

				if var_95_6 > 0 and var_95_1 < var_95_6 then
					arg_92_1.talkMaxDuration = var_95_6

					if var_95_6 + var_95_0 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_6 + var_95_0
					end
				end

				arg_92_1.text_.text = var_95_3
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)
				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_7 = math.max(var_95_1, arg_92_1.talkMaxDuration)

			if var_95_0 <= arg_92_1.time_ and arg_92_1.time_ < var_95_0 + var_95_7 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_0) / var_95_7

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_0 + var_95_7 and arg_92_1.time_ < var_95_0 + var_95_7 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {}

		arg_92_1:InitPlayNodeList()
	end,
	Play319761021 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 319761021
		arg_96_1.duration_ = 4.2

		local var_96_0 = {
			zh = 2.9,
			ja = 4.2
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
				arg_96_0:Play319761022(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			local var_99_0 = 0
			local var_99_1 = 0.25

			if var_99_0 < arg_96_1.time_ and arg_96_1.time_ <= var_99_0 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				local var_99_2 = arg_96_1:FormatText(StoryNameCfg[6].name)

				arg_96_1.leftNameTxt_.text = var_99_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_3 = arg_96_1:GetWordFromCfg(319761021)
				local var_99_4 = arg_96_1:FormatText(var_99_3.content)

				arg_96_1.text_.text = var_99_4

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_5 = 10
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

				if manager.audio:GetVoiceLength("story_v_out_319761", "319761021", "story_v_out_319761.awb") ~= 0 then
					local var_99_8 = manager.audio:GetVoiceLength("story_v_out_319761", "319761021", "story_v_out_319761.awb") / 1000

					if var_99_8 + var_99_0 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_8 + var_99_0
					end

					if var_99_3.prefab_name ~= "" and arg_96_1.actors_[var_99_3.prefab_name] ~= nil then
						local var_99_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_96_1.actors_[var_99_3.prefab_name].transform, "story_v_out_319761", "319761021", "story_v_out_319761.awb")

						arg_96_1:RecordAudio("319761021", var_99_9)
						arg_96_1:RecordAudio("319761021", var_99_9)
					else
						arg_96_1:AudioAction("play", "voice", "story_v_out_319761", "319761021", "story_v_out_319761.awb")
					end

					arg_96_1:RecordHistoryTalkVoice("story_v_out_319761", "319761021", "story_v_out_319761.awb")
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
	Play319761022 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 319761022
		arg_100_1.duration_ = 5

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play319761023(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			local var_103_0 = 0
			local var_103_1 = 0.425

			if var_103_0 < arg_100_1.time_ and arg_100_1.time_ <= var_103_0 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, false)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_2 = arg_100_1:GetWordFromCfg(319761022)
				local var_103_3 = arg_100_1:FormatText(var_103_2.content)

				arg_100_1.text_.text = var_103_3

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_4 = 17
				local var_103_5 = utf8.len(var_103_3)
				local var_103_6 = var_103_4 <= 0 and var_103_1 or var_103_1 * (var_103_5 / var_103_4)

				if var_103_6 > 0 and var_103_1 < var_103_6 then
					arg_100_1.talkMaxDuration = var_103_6

					if var_103_6 + var_103_0 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_6 + var_103_0
					end
				end

				arg_100_1.text_.text = var_103_3
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)
				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_7 = math.max(var_103_1, arg_100_1.talkMaxDuration)

			if var_103_0 <= arg_100_1.time_ and arg_100_1.time_ < var_103_0 + var_103_7 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_0) / var_103_7

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_0 + var_103_7 and arg_100_1.time_ < var_103_0 + var_103_7 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {}

		arg_100_1:InitPlayNodeList()
	end,
	Play319761023 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 319761023
		arg_104_1.duration_ = 4.4

		local var_104_0 = {
			zh = 4.166,
			ja = 4.4
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
				arg_104_0:Play319761024(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			local var_107_0 = 0
			local var_107_1 = 0.325

			if var_107_0 < arg_104_1.time_ and arg_104_1.time_ <= var_107_0 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				local var_107_2 = arg_104_1:FormatText(StoryNameCfg[6].name)

				arg_104_1.leftNameTxt_.text = var_107_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_3 = arg_104_1:GetWordFromCfg(319761023)
				local var_107_4 = arg_104_1:FormatText(var_107_3.content)

				arg_104_1.text_.text = var_107_4

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_5 = 13
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

				if manager.audio:GetVoiceLength("story_v_out_319761", "319761023", "story_v_out_319761.awb") ~= 0 then
					local var_107_8 = manager.audio:GetVoiceLength("story_v_out_319761", "319761023", "story_v_out_319761.awb") / 1000

					if var_107_8 + var_107_0 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_8 + var_107_0
					end

					if var_107_3.prefab_name ~= "" and arg_104_1.actors_[var_107_3.prefab_name] ~= nil then
						local var_107_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_104_1.actors_[var_107_3.prefab_name].transform, "story_v_out_319761", "319761023", "story_v_out_319761.awb")

						arg_104_1:RecordAudio("319761023", var_107_9)
						arg_104_1:RecordAudio("319761023", var_107_9)
					else
						arg_104_1:AudioAction("play", "voice", "story_v_out_319761", "319761023", "story_v_out_319761.awb")
					end

					arg_104_1:RecordHistoryTalkVoice("story_v_out_319761", "319761023", "story_v_out_319761.awb")
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
	Play319761024 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 319761024
		arg_108_1.duration_ = 8

		local var_108_0 = {
			zh = 7.333,
			ja = 8
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
				arg_108_0:Play319761025(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			local var_111_0 = 0
			local var_111_1 = 0.725

			if var_111_0 < arg_108_1.time_ and arg_108_1.time_ <= var_111_0 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				local var_111_2 = arg_108_1:FormatText(StoryNameCfg[6].name)

				arg_108_1.leftNameTxt_.text = var_111_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_3 = arg_108_1:GetWordFromCfg(319761024)
				local var_111_4 = arg_108_1:FormatText(var_111_3.content)

				arg_108_1.text_.text = var_111_4

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_5 = 29
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

				if manager.audio:GetVoiceLength("story_v_out_319761", "319761024", "story_v_out_319761.awb") ~= 0 then
					local var_111_8 = manager.audio:GetVoiceLength("story_v_out_319761", "319761024", "story_v_out_319761.awb") / 1000

					if var_111_8 + var_111_0 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_8 + var_111_0
					end

					if var_111_3.prefab_name ~= "" and arg_108_1.actors_[var_111_3.prefab_name] ~= nil then
						local var_111_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_108_1.actors_[var_111_3.prefab_name].transform, "story_v_out_319761", "319761024", "story_v_out_319761.awb")

						arg_108_1:RecordAudio("319761024", var_111_9)
						arg_108_1:RecordAudio("319761024", var_111_9)
					else
						arg_108_1:AudioAction("play", "voice", "story_v_out_319761", "319761024", "story_v_out_319761.awb")
					end

					arg_108_1:RecordHistoryTalkVoice("story_v_out_319761", "319761024", "story_v_out_319761.awb")
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
	Play319761025 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 319761025
		arg_112_1.duration_ = 11.77

		local var_112_0 = {
			zh = 7.9,
			ja = 11.766
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
				arg_112_0:Play319761026(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			local var_115_0 = 0
			local var_115_1 = 0.75

			if var_115_0 < arg_112_1.time_ and arg_112_1.time_ <= var_115_0 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				local var_115_2 = arg_112_1:FormatText(StoryNameCfg[6].name)

				arg_112_1.leftNameTxt_.text = var_115_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_3 = arg_112_1:GetWordFromCfg(319761025)
				local var_115_4 = arg_112_1:FormatText(var_115_3.content)

				arg_112_1.text_.text = var_115_4

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_5 = 30
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

				if manager.audio:GetVoiceLength("story_v_out_319761", "319761025", "story_v_out_319761.awb") ~= 0 then
					local var_115_8 = manager.audio:GetVoiceLength("story_v_out_319761", "319761025", "story_v_out_319761.awb") / 1000

					if var_115_8 + var_115_0 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_8 + var_115_0
					end

					if var_115_3.prefab_name ~= "" and arg_112_1.actors_[var_115_3.prefab_name] ~= nil then
						local var_115_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_112_1.actors_[var_115_3.prefab_name].transform, "story_v_out_319761", "319761025", "story_v_out_319761.awb")

						arg_112_1:RecordAudio("319761025", var_115_9)
						arg_112_1:RecordAudio("319761025", var_115_9)
					else
						arg_112_1:AudioAction("play", "voice", "story_v_out_319761", "319761025", "story_v_out_319761.awb")
					end

					arg_112_1:RecordHistoryTalkVoice("story_v_out_319761", "319761025", "story_v_out_319761.awb")
				end

				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_10 = math.max(var_115_1, arg_112_1.talkMaxDuration)

			if var_115_0 <= arg_112_1.time_ and arg_112_1.time_ < var_115_0 + var_115_10 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_0) / var_115_10

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_0 + var_115_10 and arg_112_1.time_ < var_115_0 + var_115_10 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {}

		arg_112_1:InitPlayNodeList()
	end,
	Play319761026 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 319761026
		arg_116_1.duration_ = 8.8

		local var_116_0 = {
			zh = 8.8,
			ja = 6.9
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
				arg_116_0:Play319761027(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			local var_119_0 = 0
			local var_119_1 = 0.725

			if var_119_0 < arg_116_1.time_ and arg_116_1.time_ <= var_119_0 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				local var_119_2 = arg_116_1:FormatText(StoryNameCfg[6].name)

				arg_116_1.leftNameTxt_.text = var_119_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_3 = arg_116_1:GetWordFromCfg(319761026)
				local var_119_4 = arg_116_1:FormatText(var_119_3.content)

				arg_116_1.text_.text = var_119_4

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_5 = 29
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

				if manager.audio:GetVoiceLength("story_v_out_319761", "319761026", "story_v_out_319761.awb") ~= 0 then
					local var_119_8 = manager.audio:GetVoiceLength("story_v_out_319761", "319761026", "story_v_out_319761.awb") / 1000

					if var_119_8 + var_119_0 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_8 + var_119_0
					end

					if var_119_3.prefab_name ~= "" and arg_116_1.actors_[var_119_3.prefab_name] ~= nil then
						local var_119_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_116_1.actors_[var_119_3.prefab_name].transform, "story_v_out_319761", "319761026", "story_v_out_319761.awb")

						arg_116_1:RecordAudio("319761026", var_119_9)
						arg_116_1:RecordAudio("319761026", var_119_9)
					else
						arg_116_1:AudioAction("play", "voice", "story_v_out_319761", "319761026", "story_v_out_319761.awb")
					end

					arg_116_1:RecordHistoryTalkVoice("story_v_out_319761", "319761026", "story_v_out_319761.awb")
				end

				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_10 = math.max(var_119_1, arg_116_1.talkMaxDuration)

			if var_119_0 <= arg_116_1.time_ and arg_116_1.time_ < var_119_0 + var_119_10 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_0) / var_119_10

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_0 + var_119_10 and arg_116_1.time_ < var_119_0 + var_119_10 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {}

		arg_116_1:InitPlayNodeList()
	end,
	Play319761027 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 319761027
		arg_120_1.duration_ = 5

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"
		end

		function arg_120_1.playNext_(arg_122_0)
			if arg_122_0 == 1 then
				arg_120_0:Play319761028(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			local var_123_0 = 0
			local var_123_1 = 0.45

			if var_123_0 < arg_120_1.time_ and arg_120_1.time_ <= var_123_0 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, false)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_2 = arg_120_1:GetWordFromCfg(319761027)
				local var_123_3 = arg_120_1:FormatText(var_123_2.content)

				arg_120_1.text_.text = var_123_3

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_4 = 18
				local var_123_5 = utf8.len(var_123_3)
				local var_123_6 = var_123_4 <= 0 and var_123_1 or var_123_1 * (var_123_5 / var_123_4)

				if var_123_6 > 0 and var_123_1 < var_123_6 then
					arg_120_1.talkMaxDuration = var_123_6

					if var_123_6 + var_123_0 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_6 + var_123_0
					end
				end

				arg_120_1.text_.text = var_123_3
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)
				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_7 = math.max(var_123_1, arg_120_1.talkMaxDuration)

			if var_123_0 <= arg_120_1.time_ and arg_120_1.time_ < var_123_0 + var_123_7 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_0) / var_123_7

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_0 + var_123_7 and arg_120_1.time_ < var_123_0 + var_123_7 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {}

		arg_120_1:InitPlayNodeList()
	end,
	Play319761028 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 319761028
		arg_124_1.duration_ = 6.6

		local var_124_0 = {
			zh = 4.833,
			ja = 6.6
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
				arg_124_0:Play319761029(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			local var_127_0 = 0
			local var_127_1 = 0.45

			if var_127_0 < arg_124_1.time_ and arg_124_1.time_ <= var_127_0 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				local var_127_2 = arg_124_1:FormatText(StoryNameCfg[6].name)

				arg_124_1.leftNameTxt_.text = var_127_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_3 = arg_124_1:GetWordFromCfg(319761028)
				local var_127_4 = arg_124_1:FormatText(var_127_3.content)

				arg_124_1.text_.text = var_127_4

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_5 = 18
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

				if manager.audio:GetVoiceLength("story_v_out_319761", "319761028", "story_v_out_319761.awb") ~= 0 then
					local var_127_8 = manager.audio:GetVoiceLength("story_v_out_319761", "319761028", "story_v_out_319761.awb") / 1000

					if var_127_8 + var_127_0 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_8 + var_127_0
					end

					if var_127_3.prefab_name ~= "" and arg_124_1.actors_[var_127_3.prefab_name] ~= nil then
						local var_127_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_124_1.actors_[var_127_3.prefab_name].transform, "story_v_out_319761", "319761028", "story_v_out_319761.awb")

						arg_124_1:RecordAudio("319761028", var_127_9)
						arg_124_1:RecordAudio("319761028", var_127_9)
					else
						arg_124_1:AudioAction("play", "voice", "story_v_out_319761", "319761028", "story_v_out_319761.awb")
					end

					arg_124_1:RecordHistoryTalkVoice("story_v_out_319761", "319761028", "story_v_out_319761.awb")
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
	Play319761029 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 319761029
		arg_128_1.duration_ = 3.83

		local var_128_0 = {
			zh = 3.833,
			ja = 2.133
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
				arg_128_0:Play319761030(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			local var_131_0 = 0
			local var_131_1 = 0.3

			if var_131_0 < arg_128_1.time_ and arg_128_1.time_ <= var_131_0 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				local var_131_2 = arg_128_1:FormatText(StoryNameCfg[6].name)

				arg_128_1.leftNameTxt_.text = var_131_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_3 = arg_128_1:GetWordFromCfg(319761029)
				local var_131_4 = arg_128_1:FormatText(var_131_3.content)

				arg_128_1.text_.text = var_131_4

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_5 = 12
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

				if manager.audio:GetVoiceLength("story_v_out_319761", "319761029", "story_v_out_319761.awb") ~= 0 then
					local var_131_8 = manager.audio:GetVoiceLength("story_v_out_319761", "319761029", "story_v_out_319761.awb") / 1000

					if var_131_8 + var_131_0 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_8 + var_131_0
					end

					if var_131_3.prefab_name ~= "" and arg_128_1.actors_[var_131_3.prefab_name] ~= nil then
						local var_131_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_3.prefab_name].transform, "story_v_out_319761", "319761029", "story_v_out_319761.awb")

						arg_128_1:RecordAudio("319761029", var_131_9)
						arg_128_1:RecordAudio("319761029", var_131_9)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_out_319761", "319761029", "story_v_out_319761.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_out_319761", "319761029", "story_v_out_319761.awb")
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
	Play319761030 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 319761030
		arg_132_1.duration_ = 1.7

		local var_132_0 = {
			zh = 1,
			ja = 1.7
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
				arg_132_0:Play319761031(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			local var_135_0 = 0
			local var_135_1 = 0.05

			if var_135_0 < arg_132_1.time_ and arg_132_1.time_ <= var_135_0 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				local var_135_2 = arg_132_1:FormatText(StoryNameCfg[6].name)

				arg_132_1.leftNameTxt_.text = var_135_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_3 = arg_132_1:GetWordFromCfg(319761030)
				local var_135_4 = arg_132_1:FormatText(var_135_3.content)

				arg_132_1.text_.text = var_135_4

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_5 = 2
				local var_135_6 = utf8.len(var_135_4)
				local var_135_7 = var_135_5 <= 0 and var_135_1 or var_135_1 * (var_135_6 / var_135_5)

				if var_135_7 > 0 and var_135_1 < var_135_7 then
					arg_132_1.talkMaxDuration = var_135_7

					if var_135_7 + var_135_0 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_7 + var_135_0
					end
				end

				arg_132_1.text_.text = var_135_4
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319761", "319761030", "story_v_out_319761.awb") ~= 0 then
					local var_135_8 = manager.audio:GetVoiceLength("story_v_out_319761", "319761030", "story_v_out_319761.awb") / 1000

					if var_135_8 + var_135_0 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_8 + var_135_0
					end

					if var_135_3.prefab_name ~= "" and arg_132_1.actors_[var_135_3.prefab_name] ~= nil then
						local var_135_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_3.prefab_name].transform, "story_v_out_319761", "319761030", "story_v_out_319761.awb")

						arg_132_1:RecordAudio("319761030", var_135_9)
						arg_132_1:RecordAudio("319761030", var_135_9)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_out_319761", "319761030", "story_v_out_319761.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_out_319761", "319761030", "story_v_out_319761.awb")
				end

				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_10 = math.max(var_135_1, arg_132_1.talkMaxDuration)

			if var_135_0 <= arg_132_1.time_ and arg_132_1.time_ < var_135_0 + var_135_10 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_0) / var_135_10

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_0 + var_135_10 and arg_132_1.time_ < var_135_0 + var_135_10 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {}

		arg_132_1:InitPlayNodeList()
	end,
	Play319761031 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 319761031
		arg_136_1.duration_ = 2.73

		local var_136_0 = {
			zh = 1.5,
			ja = 2.733
		}
		local var_136_1 = manager.audio:GetLocalizationFlag()

		if var_136_0[var_136_1] ~= nil then
			arg_136_1.duration_ = var_136_0[var_136_1]
		end

		SetActive(arg_136_1.tipsGo_, false)

		function arg_136_1.onSingleLineFinish_()
			arg_136_1.onSingleLineUpdate_ = nil
			arg_136_1.onSingleLineFinish_ = nil
			arg_136_1.state_ = "waiting"
		end

		function arg_136_1.playNext_(arg_138_0)
			if arg_138_0 == 1 then
				arg_136_0:Play319761032(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			local var_139_0 = 0
			local var_139_1 = 0.175

			if var_139_0 < arg_136_1.time_ and arg_136_1.time_ <= var_139_0 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				local var_139_2 = arg_136_1:FormatText(StoryNameCfg[6].name)

				arg_136_1.leftNameTxt_.text = var_139_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_3 = arg_136_1:GetWordFromCfg(319761031)
				local var_139_4 = arg_136_1:FormatText(var_139_3.content)

				arg_136_1.text_.text = var_139_4

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_5 = 7
				local var_139_6 = utf8.len(var_139_4)
				local var_139_7 = var_139_5 <= 0 and var_139_1 or var_139_1 * (var_139_6 / var_139_5)

				if var_139_7 > 0 and var_139_1 < var_139_7 then
					arg_136_1.talkMaxDuration = var_139_7

					if var_139_7 + var_139_0 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_7 + var_139_0
					end
				end

				arg_136_1.text_.text = var_139_4
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319761", "319761031", "story_v_out_319761.awb") ~= 0 then
					local var_139_8 = manager.audio:GetVoiceLength("story_v_out_319761", "319761031", "story_v_out_319761.awb") / 1000

					if var_139_8 + var_139_0 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_8 + var_139_0
					end

					if var_139_3.prefab_name ~= "" and arg_136_1.actors_[var_139_3.prefab_name] ~= nil then
						local var_139_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_136_1.actors_[var_139_3.prefab_name].transform, "story_v_out_319761", "319761031", "story_v_out_319761.awb")

						arg_136_1:RecordAudio("319761031", var_139_9)
						arg_136_1:RecordAudio("319761031", var_139_9)
					else
						arg_136_1:AudioAction("play", "voice", "story_v_out_319761", "319761031", "story_v_out_319761.awb")
					end

					arg_136_1:RecordHistoryTalkVoice("story_v_out_319761", "319761031", "story_v_out_319761.awb")
				end

				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_10 = math.max(var_139_1, arg_136_1.talkMaxDuration)

			if var_139_0 <= arg_136_1.time_ and arg_136_1.time_ < var_139_0 + var_139_10 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_0) / var_139_10

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_0 + var_139_10 and arg_136_1.time_ < var_139_0 + var_139_10 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {}

		arg_136_1:InitPlayNodeList()
	end,
	Play319761032 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 319761032
		arg_140_1.duration_ = 2.03

		local var_140_0 = {
			zh = 1,
			ja = 2.033
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
				arg_140_0:Play319761033(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			local var_143_0 = 0
			local var_143_1 = 0.05

			if var_143_0 < arg_140_1.time_ and arg_140_1.time_ <= var_143_0 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, true)

				local var_143_2 = arg_140_1:FormatText(StoryNameCfg[6].name)

				arg_140_1.leftNameTxt_.text = var_143_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_140_1.leftNameTxt_.transform)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1.leftNameTxt_.text)
				SetActive(arg_140_1.iconTrs_.gameObject, false)
				arg_140_1.callingController_:SetSelectedState("normal")

				local var_143_3 = arg_140_1:GetWordFromCfg(319761032)
				local var_143_4 = arg_140_1:FormatText(var_143_3.content)

				arg_140_1.text_.text = var_143_4

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_5 = 2
				local var_143_6 = utf8.len(var_143_4)
				local var_143_7 = var_143_5 <= 0 and var_143_1 or var_143_1 * (var_143_6 / var_143_5)

				if var_143_7 > 0 and var_143_1 < var_143_7 then
					arg_140_1.talkMaxDuration = var_143_7

					if var_143_7 + var_143_0 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_7 + var_143_0
					end
				end

				arg_140_1.text_.text = var_143_4
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319761", "319761032", "story_v_out_319761.awb") ~= 0 then
					local var_143_8 = manager.audio:GetVoiceLength("story_v_out_319761", "319761032", "story_v_out_319761.awb") / 1000

					if var_143_8 + var_143_0 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_8 + var_143_0
					end

					if var_143_3.prefab_name ~= "" and arg_140_1.actors_[var_143_3.prefab_name] ~= nil then
						local var_143_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_140_1.actors_[var_143_3.prefab_name].transform, "story_v_out_319761", "319761032", "story_v_out_319761.awb")

						arg_140_1:RecordAudio("319761032", var_143_9)
						arg_140_1:RecordAudio("319761032", var_143_9)
					else
						arg_140_1:AudioAction("play", "voice", "story_v_out_319761", "319761032", "story_v_out_319761.awb")
					end

					arg_140_1:RecordHistoryTalkVoice("story_v_out_319761", "319761032", "story_v_out_319761.awb")
				end

				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_10 = math.max(var_143_1, arg_140_1.talkMaxDuration)

			if var_143_0 <= arg_140_1.time_ and arg_140_1.time_ < var_143_0 + var_143_10 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_0) / var_143_10

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_0 + var_143_10 and arg_140_1.time_ < var_143_0 + var_143_10 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {}

		arg_140_1:InitPlayNodeList()
	end,
	Play319761033 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 319761033
		arg_144_1.duration_ = 7.47

		local var_144_0 = {
			zh = 4.97144020060077,
			ja = 7.47144020060077
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
				arg_144_0:Play319761034(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			local var_147_0 = arg_144_1.bgs_.ML0202.transform
			local var_147_1 = 0

			if var_147_1 < arg_144_1.time_ and arg_144_1.time_ <= var_147_1 + arg_147_0 then
				arg_144_1.var_.moveOldPosML0202 = var_147_0.localPosition
			end

			local var_147_2 = 0.001

			if var_147_1 <= arg_144_1.time_ and arg_144_1.time_ < var_147_1 + var_147_2 then
				local var_147_3 = (arg_144_1.time_ - var_147_1) / var_147_2
				local var_147_4 = Vector3.New(0, 1, 10)

				var_147_0.localPosition = Vector3.Lerp(arg_144_1.var_.moveOldPosML0202, var_147_4, var_147_3)
			end

			if arg_144_1.time_ >= var_147_1 + var_147_2 and arg_144_1.time_ < var_147_1 + var_147_2 + arg_147_0 then
				var_147_0.localPosition = Vector3.New(0, 1, 10)
			end

			local var_147_5 = arg_144_1.bgs_.ML0202.transform
			local var_147_6 = 0.034

			if var_147_6 < arg_144_1.time_ and arg_144_1.time_ <= var_147_6 + arg_147_0 then
				arg_144_1.var_.moveOldPosML0202 = var_147_5.localPosition
			end

			local var_147_7 = 3.266

			if var_147_6 <= arg_144_1.time_ and arg_144_1.time_ < var_147_6 + var_147_7 then
				local var_147_8 = (arg_144_1.time_ - var_147_6) / var_147_7
				local var_147_9 = Vector3.New(0, 1, 9.21)

				var_147_5.localPosition = Vector3.Lerp(arg_144_1.var_.moveOldPosML0202, var_147_9, var_147_8)
			end

			if arg_144_1.time_ >= var_147_6 + var_147_7 and arg_144_1.time_ < var_147_6 + var_147_7 + arg_147_0 then
				var_147_5.localPosition = Vector3.New(0, 1, 9.21)
			end

			local var_147_10 = 0

			if var_147_10 < arg_144_1.time_ and arg_144_1.time_ <= var_147_10 + arg_147_0 then
				arg_144_1.allBtn_.enabled = false
			end

			local var_147_11 = 3.43333333333333

			if arg_144_1.time_ >= var_147_10 + var_147_11 and arg_144_1.time_ < var_147_10 + var_147_11 + arg_147_0 then
				arg_144_1.allBtn_.enabled = true
			end

			if arg_144_1.frameCnt_ <= 1 then
				arg_144_1.dialog_:SetActive(false)
			end

			local var_147_12 = 2.27144020060077
			local var_147_13 = 0.225

			if var_147_12 < arg_144_1.time_ and arg_144_1.time_ <= var_147_12 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0

				arg_144_1.dialog_:SetActive(true)

				arg_144_1.dialogCg_.alpha = 0

				local var_147_14 = LeanTween.value(arg_144_1.dialog_, 0, 1, 0.3)

				var_147_14:setOnUpdate(LuaHelper.FloatAction(function(arg_148_0)
					arg_144_1.dialogCg_.alpha = arg_148_0
				end))
				var_147_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_144_1.dialog_)
					var_147_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_144_1.duration_ = arg_144_1.duration_ + 0.3

				SetActive(arg_144_1.leftNameGo_, true)

				local var_147_15 = arg_144_1:FormatText(StoryNameCfg[6].name)

				arg_144_1.leftNameTxt_.text = var_147_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, false)
				arg_144_1.callingController_:SetSelectedState("normal")

				local var_147_16 = arg_144_1:GetWordFromCfg(319761033)
				local var_147_17 = arg_144_1:FormatText(var_147_16.content)

				arg_144_1.text_.text = var_147_17

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_18 = 9
				local var_147_19 = utf8.len(var_147_17)
				local var_147_20 = var_147_18 <= 0 and var_147_13 or var_147_13 * (var_147_19 / var_147_18)

				if var_147_20 > 0 and var_147_13 < var_147_20 then
					arg_144_1.talkMaxDuration = var_147_20
					var_147_12 = var_147_12 + 0.3

					if var_147_20 + var_147_12 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_20 + var_147_12
					end
				end

				arg_144_1.text_.text = var_147_17
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319761", "319761033", "story_v_out_319761.awb") ~= 0 then
					local var_147_21 = manager.audio:GetVoiceLength("story_v_out_319761", "319761033", "story_v_out_319761.awb") / 1000

					if var_147_21 + var_147_12 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_21 + var_147_12
					end

					if var_147_16.prefab_name ~= "" and arg_144_1.actors_[var_147_16.prefab_name] ~= nil then
						local var_147_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_144_1.actors_[var_147_16.prefab_name].transform, "story_v_out_319761", "319761033", "story_v_out_319761.awb")

						arg_144_1:RecordAudio("319761033", var_147_22)
						arg_144_1:RecordAudio("319761033", var_147_22)
					else
						arg_144_1:AudioAction("play", "voice", "story_v_out_319761", "319761033", "story_v_out_319761.awb")
					end

					arg_144_1:RecordHistoryTalkVoice("story_v_out_319761", "319761033", "story_v_out_319761.awb")
				end

				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_23 = var_147_12 + 0.3
			local var_147_24 = math.max(var_147_13, arg_144_1.talkMaxDuration)

			if var_147_23 <= arg_144_1.time_ and arg_144_1.time_ < var_147_23 + var_147_24 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_23) / var_147_24

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_23 + var_147_24 and arg_144_1.time_ < var_147_23 + var_147_24 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "ML0202",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "ML0202",
				changeDisplayLayer = false,
				needEase = false,
				duration = 3.266,
				className = "StoryMoveNode",
				startTime = 0.034,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_144_1:InitPlayNodeList()
	end,
	Play319761034 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 319761034
		arg_150_1.duration_ = 4.47

		local var_150_0 = {
			zh = 3.633,
			ja = 4.466
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
				arg_150_0:Play319761035(arg_150_1)
			end
		end

		function arg_150_1.onSingleLineUpdate_(arg_153_0)
			if arg_150_1.frameCnt_ <= 1 then
				arg_150_1.dialog_:SetActive(false)
			end

			local var_153_0 = 1
			local var_153_1 = 0.225

			if var_153_0 < arg_150_1.time_ and arg_150_1.time_ <= var_153_0 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0

				arg_150_1.dialog_:SetActive(true)

				arg_150_1.dialogCg_.alpha = 0

				local var_153_2 = LeanTween.value(arg_150_1.dialog_, 0, 1, 0.3)

				var_153_2:setOnUpdate(LuaHelper.FloatAction(function(arg_154_0)
					arg_150_1.dialogCg_.alpha = arg_154_0
				end))
				var_153_2:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_150_1.dialog_)
					var_153_2:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_150_1.duration_ = arg_150_1.duration_ + 0.3

				SetActive(arg_150_1.leftNameGo_, true)

				local var_153_3 = arg_150_1:FormatText(StoryNameCfg[6].name)

				arg_150_1.leftNameTxt_.text = var_153_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_150_1.leftNameTxt_.transform)

				arg_150_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_150_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_150_1:RecordName(arg_150_1.leftNameTxt_.text)
				SetActive(arg_150_1.iconTrs_.gameObject, false)
				arg_150_1.callingController_:SetSelectedState("normal")

				local var_153_4 = arg_150_1:GetWordFromCfg(319761034)
				local var_153_5 = arg_150_1:FormatText(var_153_4.content)

				arg_150_1.text_.text = var_153_5

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_6 = 9
				local var_153_7 = utf8.len(var_153_5)
				local var_153_8 = var_153_6 <= 0 and var_153_1 or var_153_1 * (var_153_7 / var_153_6)

				if var_153_8 > 0 and var_153_1 < var_153_8 then
					arg_150_1.talkMaxDuration = var_153_8
					var_153_0 = var_153_0 + 0.3

					if var_153_8 + var_153_0 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_8 + var_153_0
					end
				end

				arg_150_1.text_.text = var_153_5
				arg_150_1.typewritter.percent = 0

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319761", "319761034", "story_v_out_319761.awb") ~= 0 then
					local var_153_9 = manager.audio:GetVoiceLength("story_v_out_319761", "319761034", "story_v_out_319761.awb") / 1000

					if var_153_9 + var_153_0 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_9 + var_153_0
					end

					if var_153_4.prefab_name ~= "" and arg_150_1.actors_[var_153_4.prefab_name] ~= nil then
						local var_153_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_150_1.actors_[var_153_4.prefab_name].transform, "story_v_out_319761", "319761034", "story_v_out_319761.awb")

						arg_150_1:RecordAudio("319761034", var_153_10)
						arg_150_1:RecordAudio("319761034", var_153_10)
					else
						arg_150_1:AudioAction("play", "voice", "story_v_out_319761", "319761034", "story_v_out_319761.awb")
					end

					arg_150_1:RecordHistoryTalkVoice("story_v_out_319761", "319761034", "story_v_out_319761.awb")
				end

				arg_150_1:RecordContent(arg_150_1.text_.text)
			end

			local var_153_11 = var_153_0 + 0.3
			local var_153_12 = math.max(var_153_1, arg_150_1.talkMaxDuration)

			if var_153_11 <= arg_150_1.time_ and arg_150_1.time_ < var_153_11 + var_153_12 then
				arg_150_1.typewritter.percent = (arg_150_1.time_ - var_153_11) / var_153_12

				arg_150_1.typewritter:SetDirty()
			end

			if arg_150_1.time_ >= var_153_11 + var_153_12 and arg_150_1.time_ < var_153_11 + var_153_12 + arg_153_0 then
				arg_150_1.typewritter.percent = 1

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(true)
			end
		end

		arg_150_1.nodeConfigList_ = {}

		arg_150_1:InitPlayNodeList()
	end,
	Play319761035 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 319761035
		arg_156_1.duration_ = 4.17

		local var_156_0 = {
			zh = 4.166,
			ja = 4
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
				arg_156_0:Play319761036(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			local var_159_0 = "STblack"

			if arg_156_1.bgs_[var_159_0] == nil then
				local var_159_1 = Object.Instantiate(arg_156_1.paintGo_)

				var_159_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_159_0)
				var_159_1.name = var_159_0
				var_159_1.transform.parent = arg_156_1.stage_.transform
				var_159_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_156_1.bgs_[var_159_0] = var_159_1
			end

			local var_159_2 = 1

			if var_159_2 < arg_156_1.time_ and arg_156_1.time_ <= var_159_2 + arg_159_0 then
				local var_159_3 = manager.ui.mainCamera.transform.localPosition
				local var_159_4 = Vector3.New(0, 0, 10) + Vector3.New(var_159_3.x, var_159_3.y, 0)
				local var_159_5 = arg_156_1.bgs_.STblack

				var_159_5.transform.localPosition = var_159_4
				var_159_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_159_6 = var_159_5:GetComponent("SpriteRenderer")

				if var_159_6 and var_159_6.sprite then
					local var_159_7 = (var_159_5.transform.localPosition - var_159_3).z
					local var_159_8 = manager.ui.mainCameraCom_
					local var_159_9 = 2 * var_159_7 * Mathf.Tan(var_159_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_159_10 = var_159_9 * var_159_8.aspect
					local var_159_11 = var_159_6.sprite.bounds.size.x
					local var_159_12 = var_159_6.sprite.bounds.size.y
					local var_159_13 = var_159_10 / var_159_11
					local var_159_14 = var_159_9 / var_159_12
					local var_159_15 = var_159_14 < var_159_13 and var_159_13 or var_159_14

					var_159_5.transform.localScale = Vector3.New(var_159_15, var_159_15, 0)
				end

				for iter_159_0, iter_159_1 in pairs(arg_156_1.bgs_) do
					if iter_159_0 ~= "STblack" then
						iter_159_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_159_16 = 0

			if var_159_16 < arg_156_1.time_ and arg_156_1.time_ <= var_159_16 + arg_159_0 then
				arg_156_1.allBtn_.enabled = false
			end

			local var_159_17 = 0.3

			if arg_156_1.time_ >= var_159_16 + var_159_17 and arg_156_1.time_ < var_159_16 + var_159_17 + arg_159_0 then
				arg_156_1.allBtn_.enabled = true
			end

			local var_159_18 = 0

			if var_159_18 < arg_156_1.time_ and arg_156_1.time_ <= var_159_18 + arg_159_0 then
				arg_156_1.mask_.enabled = true
				arg_156_1.mask_.raycastTarget = true

				arg_156_1:SetGaussion(false)
			end

			local var_159_19 = 1

			if var_159_18 <= arg_156_1.time_ and arg_156_1.time_ < var_159_18 + var_159_19 then
				local var_159_20 = (arg_156_1.time_ - var_159_18) / var_159_19
				local var_159_21 = Color.New(0, 0, 0)

				var_159_21.a = Mathf.Lerp(0, 1, var_159_20)
				arg_156_1.mask_.color = var_159_21
			end

			if arg_156_1.time_ >= var_159_18 + var_159_19 and arg_156_1.time_ < var_159_18 + var_159_19 + arg_159_0 then
				local var_159_22 = Color.New(0, 0, 0)

				var_159_22.a = 1
				arg_156_1.mask_.color = var_159_22
			end

			local var_159_23 = 1

			if var_159_23 < arg_156_1.time_ and arg_156_1.time_ <= var_159_23 + arg_159_0 then
				arg_156_1.mask_.enabled = true
				arg_156_1.mask_.raycastTarget = true

				arg_156_1:SetGaussion(false)
			end

			local var_159_24 = 1

			if var_159_23 <= arg_156_1.time_ and arg_156_1.time_ < var_159_23 + var_159_24 then
				local var_159_25 = (arg_156_1.time_ - var_159_23) / var_159_24
				local var_159_26 = Color.New(0, 0, 0)

				var_159_26.a = Mathf.Lerp(1, 0, var_159_25)
				arg_156_1.mask_.color = var_159_26
			end

			if arg_156_1.time_ >= var_159_23 + var_159_24 and arg_156_1.time_ < var_159_23 + var_159_24 + arg_159_0 then
				local var_159_27 = Color.New(0, 0, 0)
				local var_159_28 = 0

				arg_156_1.mask_.enabled = false
				var_159_27.a = var_159_28
				arg_156_1.mask_.color = var_159_27
			end

			if arg_156_1.frameCnt_ <= 1 then
				arg_156_1.dialog_:SetActive(false)
			end

			local var_159_29 = 1.9
			local var_159_30 = 0.1

			if var_159_29 < arg_156_1.time_ and arg_156_1.time_ <= var_159_29 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0

				arg_156_1.dialog_:SetActive(true)

				arg_156_1.dialogCg_.alpha = 0

				local var_159_31 = LeanTween.value(arg_156_1.dialog_, 0, 1, 0.3)

				var_159_31:setOnUpdate(LuaHelper.FloatAction(function(arg_160_0)
					arg_156_1.dialogCg_.alpha = arg_160_0
				end))
				var_159_31:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_156_1.dialog_)
					var_159_31:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_156_1.duration_ = arg_156_1.duration_ + 0.3

				SetActive(arg_156_1.leftNameGo_, true)

				local var_159_32 = arg_156_1:FormatText(StoryNameCfg[6].name)

				arg_156_1.leftNameTxt_.text = var_159_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_156_1.leftNameTxt_.transform)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1.leftNameTxt_.text)
				SetActive(arg_156_1.iconTrs_.gameObject, false)
				arg_156_1.callingController_:SetSelectedState("normal")

				local var_159_33 = arg_156_1:GetWordFromCfg(319761035)
				local var_159_34 = arg_156_1:FormatText(var_159_33.content)

				arg_156_1.text_.text = var_159_34

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_35 = 6
				local var_159_36 = utf8.len(var_159_34)
				local var_159_37 = var_159_35 <= 0 and var_159_30 or var_159_30 * (var_159_36 / var_159_35)

				if var_159_37 > 0 and var_159_30 < var_159_37 then
					arg_156_1.talkMaxDuration = var_159_37
					var_159_29 = var_159_29 + 0.3

					if var_159_37 + var_159_29 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_37 + var_159_29
					end
				end

				arg_156_1.text_.text = var_159_34
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319761", "319761035", "story_v_out_319761.awb") ~= 0 then
					local var_159_38 = manager.audio:GetVoiceLength("story_v_out_319761", "319761035", "story_v_out_319761.awb") / 1000

					if var_159_38 + var_159_29 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_38 + var_159_29
					end

					if var_159_33.prefab_name ~= "" and arg_156_1.actors_[var_159_33.prefab_name] ~= nil then
						local var_159_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_156_1.actors_[var_159_33.prefab_name].transform, "story_v_out_319761", "319761035", "story_v_out_319761.awb")

						arg_156_1:RecordAudio("319761035", var_159_39)
						arg_156_1:RecordAudio("319761035", var_159_39)
					else
						arg_156_1:AudioAction("play", "voice", "story_v_out_319761", "319761035", "story_v_out_319761.awb")
					end

					arg_156_1:RecordHistoryTalkVoice("story_v_out_319761", "319761035", "story_v_out_319761.awb")
				end

				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_40 = var_159_29 + 0.3
			local var_159_41 = math.max(var_159_30, arg_156_1.talkMaxDuration)

			if var_159_40 <= arg_156_1.time_ and arg_156_1.time_ < var_159_40 + var_159_41 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_40) / var_159_41

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_40 + var_159_41 and arg_156_1.time_ < var_159_40 + var_159_41 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {}

		arg_156_1:InitPlayNodeList()
	end,
	Play319761036 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 319761036
		arg_162_1.duration_ = 7

		SetActive(arg_162_1.tipsGo_, false)

		function arg_162_1.onSingleLineFinish_()
			arg_162_1.onSingleLineUpdate_ = nil
			arg_162_1.onSingleLineFinish_ = nil
			arg_162_1.state_ = "waiting"
		end

		function arg_162_1.playNext_(arg_164_0)
			if arg_164_0 == 1 then
				arg_162_0:Play319761037(arg_162_1)
			end
		end

		function arg_162_1.onSingleLineUpdate_(arg_165_0)
			local var_165_0 = 0

			if var_165_0 < arg_162_1.time_ and arg_162_1.time_ <= var_165_0 + arg_165_0 then
				local var_165_1 = manager.ui.mainCamera.transform.localPosition
				local var_165_2 = Vector3.New(0, 0, 10) + Vector3.New(var_165_1.x, var_165_1.y, 0)
				local var_165_3 = arg_162_1.bgs_.D02a

				var_165_3.transform.localPosition = var_165_2
				var_165_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_165_4 = var_165_3:GetComponent("SpriteRenderer")

				if var_165_4 and var_165_4.sprite then
					local var_165_5 = (var_165_3.transform.localPosition - var_165_1).z
					local var_165_6 = manager.ui.mainCameraCom_
					local var_165_7 = 2 * var_165_5 * Mathf.Tan(var_165_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_165_8 = var_165_7 * var_165_6.aspect
					local var_165_9 = var_165_4.sprite.bounds.size.x
					local var_165_10 = var_165_4.sprite.bounds.size.y
					local var_165_11 = var_165_8 / var_165_9
					local var_165_12 = var_165_7 / var_165_10
					local var_165_13 = var_165_12 < var_165_11 and var_165_11 or var_165_12

					var_165_3.transform.localScale = Vector3.New(var_165_13, var_165_13, 0)
				end

				for iter_165_0, iter_165_1 in pairs(arg_162_1.bgs_) do
					if iter_165_0 ~= "D02a" then
						iter_165_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_165_14 = 0

			if var_165_14 < arg_162_1.time_ and arg_162_1.time_ <= var_165_14 + arg_165_0 then
				arg_162_1.allBtn_.enabled = false
			end

			local var_165_15 = 0.3

			if arg_162_1.time_ >= var_165_14 + var_165_15 and arg_162_1.time_ < var_165_14 + var_165_15 + arg_165_0 then
				arg_162_1.allBtn_.enabled = true
			end

			local var_165_16 = 0

			if var_165_16 < arg_162_1.time_ and arg_162_1.time_ <= var_165_16 + arg_165_0 then
				arg_162_1.mask_.enabled = true
				arg_162_1.mask_.raycastTarget = true

				arg_162_1:SetGaussion(false)
			end

			local var_165_17 = 2

			if var_165_16 <= arg_162_1.time_ and arg_162_1.time_ < var_165_16 + var_165_17 then
				local var_165_18 = (arg_162_1.time_ - var_165_16) / var_165_17
				local var_165_19 = Color.New(0, 0, 0)

				var_165_19.a = Mathf.Lerp(1, 0, var_165_18)
				arg_162_1.mask_.color = var_165_19
			end

			if arg_162_1.time_ >= var_165_16 + var_165_17 and arg_162_1.time_ < var_165_16 + var_165_17 + arg_165_0 then
				local var_165_20 = Color.New(0, 0, 0)
				local var_165_21 = 0

				arg_162_1.mask_.enabled = false
				var_165_20.a = var_165_21
				arg_162_1.mask_.color = var_165_20
			end

			local var_165_22 = arg_162_1.actors_["10079ui_story"]
			local var_165_23 = 0

			if var_165_23 < arg_162_1.time_ and arg_162_1.time_ <= var_165_23 + arg_165_0 and not isNil(var_165_22) and arg_162_1.var_.characterEffect10079ui_story == nil then
				arg_162_1.var_.characterEffect10079ui_story = var_165_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_165_24 = 0.200000002980232

			if var_165_23 <= arg_162_1.time_ and arg_162_1.time_ < var_165_23 + var_165_24 and not isNil(var_165_22) then
				local var_165_25 = (arg_162_1.time_ - var_165_23) / var_165_24

				if arg_162_1.var_.characterEffect10079ui_story and not isNil(var_165_22) then
					local var_165_26 = Mathf.Lerp(0, 0.5, var_165_25)

					arg_162_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_162_1.var_.characterEffect10079ui_story.fillRatio = var_165_26
				end
			end

			if arg_162_1.time_ >= var_165_23 + var_165_24 and arg_162_1.time_ < var_165_23 + var_165_24 + arg_165_0 and not isNil(var_165_22) and arg_162_1.var_.characterEffect10079ui_story then
				local var_165_27 = 0.5

				arg_162_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_162_1.var_.characterEffect10079ui_story.fillRatio = var_165_27
			end

			local var_165_28 = 0
			local var_165_29 = 0.2

			if var_165_28 < arg_162_1.time_ and arg_162_1.time_ <= var_165_28 + arg_165_0 then
				local var_165_30 = "play"
				local var_165_31 = "music"

				arg_162_1:AudioAction(var_165_30, var_165_31, "ui_battle", "ui_battle_stopbgm", "")

				local var_165_32 = ""
				local var_165_33 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_165_33 ~= "" then
					if arg_162_1.bgmTxt_.text ~= var_165_33 and arg_162_1.bgmTxt_.text ~= "" then
						if arg_162_1.bgmTxt2_.text ~= "" then
							arg_162_1.bgmTxt_.text = arg_162_1.bgmTxt2_.text
						end

						arg_162_1.bgmTxt2_.text = var_165_33

						arg_162_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_162_1.bgmTxt_.text = var_165_33
						arg_162_1.bgmTxt2_.text = var_165_33
					end

					if arg_162_1.bgmTimer then
						arg_162_1.bgmTimer:Stop()

						arg_162_1.bgmTimer = nil
					end

					if arg_162_1.settingData.show_music_name == 1 then
						arg_162_1.musicController:SetSelectedState("show")
						arg_162_1.musicAnimator_:Play("open", 0, 0)

						if arg_162_1.settingData.music_time ~= 0 then
							arg_162_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_162_1.settingData.music_time), function()
								if arg_162_1 == nil or isNil(arg_162_1.bgmTxt_) then
									return
								end

								arg_162_1.musicController:SetSelectedState("hide")
								arg_162_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_162_1.frameCnt_ <= 1 then
				arg_162_1.dialog_:SetActive(false)
			end

			local var_165_34 = 2
			local var_165_35 = 1.075

			if var_165_34 < arg_162_1.time_ and arg_162_1.time_ <= var_165_34 + arg_165_0 then
				arg_162_1.talkMaxDuration = 0

				arg_162_1.dialog_:SetActive(true)

				arg_162_1.dialogCg_.alpha = 0

				local var_165_36 = LeanTween.value(arg_162_1.dialog_, 0, 1, 0.3)

				var_165_36:setOnUpdate(LuaHelper.FloatAction(function(arg_167_0)
					arg_162_1.dialogCg_.alpha = arg_167_0
				end))
				var_165_36:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_162_1.dialog_)
					var_165_36:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_162_1.duration_ = arg_162_1.duration_ + 0.3

				SetActive(arg_162_1.leftNameGo_, false)

				arg_162_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_162_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_162_1:RecordName(arg_162_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_162_1.iconTrs_.gameObject, false)
				arg_162_1.callingController_:SetSelectedState("normal")

				local var_165_37 = arg_162_1:GetWordFromCfg(319761036)
				local var_165_38 = arg_162_1:FormatText(var_165_37.content)

				arg_162_1.text_.text = var_165_38

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_39 = 43
				local var_165_40 = utf8.len(var_165_38)
				local var_165_41 = var_165_39 <= 0 and var_165_35 or var_165_35 * (var_165_40 / var_165_39)

				if var_165_41 > 0 and var_165_35 < var_165_41 then
					arg_162_1.talkMaxDuration = var_165_41
					var_165_34 = var_165_34 + 0.3

					if var_165_41 + var_165_34 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_41 + var_165_34
					end
				end

				arg_162_1.text_.text = var_165_38
				arg_162_1.typewritter.percent = 0

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(false)
				arg_162_1:RecordContent(arg_162_1.text_.text)
			end

			local var_165_42 = var_165_34 + 0.3
			local var_165_43 = math.max(var_165_35, arg_162_1.talkMaxDuration)

			if var_165_42 <= arg_162_1.time_ and arg_162_1.time_ < var_165_42 + var_165_43 then
				arg_162_1.typewritter.percent = (arg_162_1.time_ - var_165_42) / var_165_43

				arg_162_1.typewritter:SetDirty()
			end

			if arg_162_1.time_ >= var_165_42 + var_165_43 and arg_162_1.time_ < var_165_42 + var_165_43 + arg_165_0 then
				arg_162_1.typewritter.percent = 1

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(true)
			end
		end

		arg_162_1.nodeConfigList_ = {}

		arg_162_1:InitPlayNodeList()
	end,
	Play319761037 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 319761037
		arg_169_1.duration_ = 3.93

		local var_169_0 = {
			zh = 3.366,
			ja = 3.933
		}
		local var_169_1 = manager.audio:GetLocalizationFlag()

		if var_169_0[var_169_1] ~= nil then
			arg_169_1.duration_ = var_169_0[var_169_1]
		end

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play319761038(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = arg_169_1.actors_["1084ui_story"].transform
			local var_172_1 = 0

			if var_172_1 < arg_169_1.time_ and arg_169_1.time_ <= var_172_1 + arg_172_0 then
				arg_169_1.var_.moveOldPos1084ui_story = var_172_0.localPosition
			end

			local var_172_2 = 0.001

			if var_172_1 <= arg_169_1.time_ and arg_169_1.time_ < var_172_1 + var_172_2 then
				local var_172_3 = (arg_169_1.time_ - var_172_1) / var_172_2
				local var_172_4 = Vector3.New(0, -0.97, -6)

				var_172_0.localPosition = Vector3.Lerp(arg_169_1.var_.moveOldPos1084ui_story, var_172_4, var_172_3)

				local var_172_5 = manager.ui.mainCamera.transform.position - var_172_0.position

				var_172_0.forward = Vector3.New(var_172_5.x, var_172_5.y, var_172_5.z)

				local var_172_6 = var_172_0.localEulerAngles

				var_172_6.z = 0
				var_172_6.x = 0
				var_172_0.localEulerAngles = var_172_6
			end

			if arg_169_1.time_ >= var_172_1 + var_172_2 and arg_169_1.time_ < var_172_1 + var_172_2 + arg_172_0 then
				var_172_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_172_7 = manager.ui.mainCamera.transform.position - var_172_0.position

				var_172_0.forward = Vector3.New(var_172_7.x, var_172_7.y, var_172_7.z)

				local var_172_8 = var_172_0.localEulerAngles

				var_172_8.z = 0
				var_172_8.x = 0
				var_172_0.localEulerAngles = var_172_8
			end

			local var_172_9 = arg_169_1.actors_["1084ui_story"]
			local var_172_10 = 0

			if var_172_10 < arg_169_1.time_ and arg_169_1.time_ <= var_172_10 + arg_172_0 and not isNil(var_172_9) and arg_169_1.var_.characterEffect1084ui_story == nil then
				arg_169_1.var_.characterEffect1084ui_story = var_172_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_11 = 0.200000002980232

			if var_172_10 <= arg_169_1.time_ and arg_169_1.time_ < var_172_10 + var_172_11 and not isNil(var_172_9) then
				local var_172_12 = (arg_169_1.time_ - var_172_10) / var_172_11

				if arg_169_1.var_.characterEffect1084ui_story and not isNil(var_172_9) then
					arg_169_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_169_1.time_ >= var_172_10 + var_172_11 and arg_169_1.time_ < var_172_10 + var_172_11 + arg_172_0 and not isNil(var_172_9) and arg_169_1.var_.characterEffect1084ui_story then
				arg_169_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_172_13 = 0

			if var_172_13 < arg_169_1.time_ and arg_169_1.time_ <= var_172_13 + arg_172_0 then
				arg_169_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			local var_172_14 = 0

			if var_172_14 < arg_169_1.time_ and arg_169_1.time_ <= var_172_14 + arg_172_0 then
				arg_169_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_172_15 = 0
			local var_172_16 = 0.2

			if var_172_15 < arg_169_1.time_ and arg_169_1.time_ <= var_172_15 + arg_172_0 then
				local var_172_17 = "play"
				local var_172_18 = "music"

				arg_169_1:AudioAction(var_172_17, var_172_18, "ui_battle", "ui_battle_stopbgm", "")

				local var_172_19 = ""
				local var_172_20 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_172_20 ~= "" then
					if arg_169_1.bgmTxt_.text ~= var_172_20 and arg_169_1.bgmTxt_.text ~= "" then
						if arg_169_1.bgmTxt2_.text ~= "" then
							arg_169_1.bgmTxt_.text = arg_169_1.bgmTxt2_.text
						end

						arg_169_1.bgmTxt2_.text = var_172_20

						arg_169_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_169_1.bgmTxt_.text = var_172_20
						arg_169_1.bgmTxt2_.text = var_172_20
					end

					if arg_169_1.bgmTimer then
						arg_169_1.bgmTimer:Stop()

						arg_169_1.bgmTimer = nil
					end

					if arg_169_1.settingData.show_music_name == 1 then
						arg_169_1.musicController:SetSelectedState("show")
						arg_169_1.musicAnimator_:Play("open", 0, 0)

						if arg_169_1.settingData.music_time ~= 0 then
							arg_169_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_169_1.settingData.music_time), function()
								if arg_169_1 == nil or isNil(arg_169_1.bgmTxt_) then
									return
								end

								arg_169_1.musicController:SetSelectedState("hide")
								arg_169_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_172_21 = 0.233333333333333
			local var_172_22 = 1

			if var_172_21 < arg_169_1.time_ and arg_169_1.time_ <= var_172_21 + arg_172_0 then
				local var_172_23 = "play"
				local var_172_24 = "music"

				arg_169_1:AudioAction(var_172_23, var_172_24, "bgm_activity_3_0_story_quiet", "bgm_activity_3_0_story_quiet", "bgm_activity_3_0_story_quiet.awb")

				local var_172_25 = ""
				local var_172_26 = manager.audio:GetAudioName("bgm_activity_3_0_story_quiet", "bgm_activity_3_0_story_quiet")

				if var_172_26 ~= "" then
					if arg_169_1.bgmTxt_.text ~= var_172_26 and arg_169_1.bgmTxt_.text ~= "" then
						if arg_169_1.bgmTxt2_.text ~= "" then
							arg_169_1.bgmTxt_.text = arg_169_1.bgmTxt2_.text
						end

						arg_169_1.bgmTxt2_.text = var_172_26

						arg_169_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_169_1.bgmTxt_.text = var_172_26
						arg_169_1.bgmTxt2_.text = var_172_26
					end

					if arg_169_1.bgmTimer then
						arg_169_1.bgmTimer:Stop()

						arg_169_1.bgmTimer = nil
					end

					if arg_169_1.settingData.show_music_name == 1 then
						arg_169_1.musicController:SetSelectedState("show")
						arg_169_1.musicAnimator_:Play("open", 0, 0)

						if arg_169_1.settingData.music_time ~= 0 then
							arg_169_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_169_1.settingData.music_time), function()
								if arg_169_1 == nil or isNil(arg_169_1.bgmTxt_) then
									return
								end

								arg_169_1.musicController:SetSelectedState("hide")
								arg_169_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_172_27 = 0
			local var_172_28 = 0.325

			if var_172_27 < arg_169_1.time_ and arg_169_1.time_ <= var_172_27 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				local var_172_29 = arg_169_1:FormatText(StoryNameCfg[6].name)

				arg_169_1.leftNameTxt_.text = var_172_29

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_30 = arg_169_1:GetWordFromCfg(319761037)
				local var_172_31 = arg_169_1:FormatText(var_172_30.content)

				arg_169_1.text_.text = var_172_31

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_32 = 13
				local var_172_33 = utf8.len(var_172_31)
				local var_172_34 = var_172_32 <= 0 and var_172_28 or var_172_28 * (var_172_33 / var_172_32)

				if var_172_34 > 0 and var_172_28 < var_172_34 then
					arg_169_1.talkMaxDuration = var_172_34

					if var_172_34 + var_172_27 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_34 + var_172_27
					end
				end

				arg_169_1.text_.text = var_172_31
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319761", "319761037", "story_v_out_319761.awb") ~= 0 then
					local var_172_35 = manager.audio:GetVoiceLength("story_v_out_319761", "319761037", "story_v_out_319761.awb") / 1000

					if var_172_35 + var_172_27 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_35 + var_172_27
					end

					if var_172_30.prefab_name ~= "" and arg_169_1.actors_[var_172_30.prefab_name] ~= nil then
						local var_172_36 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_30.prefab_name].transform, "story_v_out_319761", "319761037", "story_v_out_319761.awb")

						arg_169_1:RecordAudio("319761037", var_172_36)
						arg_169_1:RecordAudio("319761037", var_172_36)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_319761", "319761037", "story_v_out_319761.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_319761", "319761037", "story_v_out_319761.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_37 = math.max(var_172_28, arg_169_1.talkMaxDuration)

			if var_172_27 <= arg_169_1.time_ and arg_169_1.time_ < var_172_27 + var_172_37 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_27) / var_172_37

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_27 + var_172_37 and arg_169_1.time_ < var_172_27 + var_172_37 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {
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

		arg_169_1:InitPlayNodeList()
	end,
	Play319761038 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 319761038
		arg_175_1.duration_ = 2.13

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play319761039(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = arg_175_1.actors_["1084ui_story"]
			local var_178_1 = 0

			if var_178_1 < arg_175_1.time_ and arg_175_1.time_ <= var_178_1 + arg_178_0 and not isNil(var_178_0) and arg_175_1.var_.characterEffect1084ui_story == nil then
				arg_175_1.var_.characterEffect1084ui_story = var_178_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_178_2 = 0.200000002980232

			if var_178_1 <= arg_175_1.time_ and arg_175_1.time_ < var_178_1 + var_178_2 and not isNil(var_178_0) then
				local var_178_3 = (arg_175_1.time_ - var_178_1) / var_178_2

				if arg_175_1.var_.characterEffect1084ui_story and not isNil(var_178_0) then
					local var_178_4 = Mathf.Lerp(0, 0.5, var_178_3)

					arg_175_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_175_1.var_.characterEffect1084ui_story.fillRatio = var_178_4
				end
			end

			if arg_175_1.time_ >= var_178_1 + var_178_2 and arg_175_1.time_ < var_178_1 + var_178_2 + arg_178_0 and not isNil(var_178_0) and arg_175_1.var_.characterEffect1084ui_story then
				local var_178_5 = 0.5

				arg_175_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_175_1.var_.characterEffect1084ui_story.fillRatio = var_178_5
			end

			local var_178_6 = 0
			local var_178_7 = 0.1

			if var_178_6 < arg_175_1.time_ and arg_175_1.time_ <= var_178_6 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				local var_178_8 = arg_175_1:FormatText(StoryNameCfg[36].name)

				arg_175_1.leftNameTxt_.text = var_178_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_9 = arg_175_1:GetWordFromCfg(319761038)
				local var_178_10 = arg_175_1:FormatText(var_178_9.content)

				arg_175_1.text_.text = var_178_10

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_11 = 4
				local var_178_12 = utf8.len(var_178_10)
				local var_178_13 = var_178_11 <= 0 and var_178_7 or var_178_7 * (var_178_12 / var_178_11)

				if var_178_13 > 0 and var_178_7 < var_178_13 then
					arg_175_1.talkMaxDuration = var_178_13

					if var_178_13 + var_178_6 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_13 + var_178_6
					end
				end

				arg_175_1.text_.text = var_178_10
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319761", "319761038", "story_v_out_319761.awb") ~= 0 then
					local var_178_14 = manager.audio:GetVoiceLength("story_v_out_319761", "319761038", "story_v_out_319761.awb") / 1000

					if var_178_14 + var_178_6 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_14 + var_178_6
					end

					if var_178_9.prefab_name ~= "" and arg_175_1.actors_[var_178_9.prefab_name] ~= nil then
						local var_178_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_9.prefab_name].transform, "story_v_out_319761", "319761038", "story_v_out_319761.awb")

						arg_175_1:RecordAudio("319761038", var_178_15)
						arg_175_1:RecordAudio("319761038", var_178_15)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_out_319761", "319761038", "story_v_out_319761.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_out_319761", "319761038", "story_v_out_319761.awb")
				end

				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_16 = math.max(var_178_7, arg_175_1.talkMaxDuration)

			if var_178_6 <= arg_175_1.time_ and arg_175_1.time_ < var_178_6 + var_178_16 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_6) / var_178_16

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_6 + var_178_16 and arg_175_1.time_ < var_178_6 + var_178_16 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {}

		arg_175_1:InitPlayNodeList()
	end,
	Play319761039 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 319761039
		arg_179_1.duration_ = 2

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play319761040(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = arg_179_1.actors_["1084ui_story"]
			local var_182_1 = 0

			if var_182_1 < arg_179_1.time_ and arg_179_1.time_ <= var_182_1 + arg_182_0 and not isNil(var_182_0) and arg_179_1.var_.characterEffect1084ui_story == nil then
				arg_179_1.var_.characterEffect1084ui_story = var_182_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_182_2 = 0.200000002980232

			if var_182_1 <= arg_179_1.time_ and arg_179_1.time_ < var_182_1 + var_182_2 and not isNil(var_182_0) then
				local var_182_3 = (arg_179_1.time_ - var_182_1) / var_182_2

				if arg_179_1.var_.characterEffect1084ui_story and not isNil(var_182_0) then
					arg_179_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_179_1.time_ >= var_182_1 + var_182_2 and arg_179_1.time_ < var_182_1 + var_182_2 + arg_182_0 and not isNil(var_182_0) and arg_179_1.var_.characterEffect1084ui_story then
				arg_179_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_182_4 = 0

			if var_182_4 < arg_179_1.time_ and arg_179_1.time_ <= var_182_4 + arg_182_0 then
				arg_179_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action434")
			end

			local var_182_5 = 0

			if var_182_5 < arg_179_1.time_ and arg_179_1.time_ <= var_182_5 + arg_182_0 then
				arg_179_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_182_6 = 0
			local var_182_7 = 0.075

			if var_182_6 < arg_179_1.time_ and arg_179_1.time_ <= var_182_6 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				local var_182_8 = arg_179_1:FormatText(StoryNameCfg[6].name)

				arg_179_1.leftNameTxt_.text = var_182_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_9 = arg_179_1:GetWordFromCfg(319761039)
				local var_182_10 = arg_179_1:FormatText(var_182_9.content)

				arg_179_1.text_.text = var_182_10

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_11 = 3
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

				if manager.audio:GetVoiceLength("story_v_out_319761", "319761039", "story_v_out_319761.awb") ~= 0 then
					local var_182_14 = manager.audio:GetVoiceLength("story_v_out_319761", "319761039", "story_v_out_319761.awb") / 1000

					if var_182_14 + var_182_6 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_14 + var_182_6
					end

					if var_182_9.prefab_name ~= "" and arg_179_1.actors_[var_182_9.prefab_name] ~= nil then
						local var_182_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_9.prefab_name].transform, "story_v_out_319761", "319761039", "story_v_out_319761.awb")

						arg_179_1:RecordAudio("319761039", var_182_15)
						arg_179_1:RecordAudio("319761039", var_182_15)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_out_319761", "319761039", "story_v_out_319761.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_out_319761", "319761039", "story_v_out_319761.awb")
				end

				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_16 = math.max(var_182_7, arg_179_1.talkMaxDuration)

			if var_182_6 <= arg_179_1.time_ and arg_179_1.time_ < var_182_6 + var_182_16 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_6) / var_182_16

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_6 + var_182_16 and arg_179_1.time_ < var_182_6 + var_182_16 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play319761040 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 319761040
		arg_183_1.duration_ = 1.3

		local var_183_0 = {
			zh = 0.999999999999,
			ja = 1.3
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
				arg_183_0:Play319761041(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = arg_183_1.actors_["1084ui_story"]
			local var_186_1 = 0

			if var_186_1 < arg_183_1.time_ and arg_183_1.time_ <= var_186_1 + arg_186_0 and not isNil(var_186_0) and arg_183_1.var_.characterEffect1084ui_story == nil then
				arg_183_1.var_.characterEffect1084ui_story = var_186_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_186_2 = 0.200000002980232

			if var_186_1 <= arg_183_1.time_ and arg_183_1.time_ < var_186_1 + var_186_2 and not isNil(var_186_0) then
				local var_186_3 = (arg_183_1.time_ - var_186_1) / var_186_2

				if arg_183_1.var_.characterEffect1084ui_story and not isNil(var_186_0) then
					local var_186_4 = Mathf.Lerp(0, 0.5, var_186_3)

					arg_183_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_183_1.var_.characterEffect1084ui_story.fillRatio = var_186_4
				end
			end

			if arg_183_1.time_ >= var_186_1 + var_186_2 and arg_183_1.time_ < var_186_1 + var_186_2 + arg_186_0 and not isNil(var_186_0) and arg_183_1.var_.characterEffect1084ui_story then
				local var_186_5 = 0.5

				arg_183_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_183_1.var_.characterEffect1084ui_story.fillRatio = var_186_5
			end

			local var_186_6 = 0
			local var_186_7 = 0.075

			if var_186_6 < arg_183_1.time_ and arg_183_1.time_ <= var_186_6 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				local var_186_8 = arg_183_1:FormatText(StoryNameCfg[36].name)

				arg_183_1.leftNameTxt_.text = var_186_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_9 = arg_183_1:GetWordFromCfg(319761040)
				local var_186_10 = arg_183_1:FormatText(var_186_9.content)

				arg_183_1.text_.text = var_186_10

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_11 = 3
				local var_186_12 = utf8.len(var_186_10)
				local var_186_13 = var_186_11 <= 0 and var_186_7 or var_186_7 * (var_186_12 / var_186_11)

				if var_186_13 > 0 and var_186_7 < var_186_13 then
					arg_183_1.talkMaxDuration = var_186_13

					if var_186_13 + var_186_6 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_13 + var_186_6
					end
				end

				arg_183_1.text_.text = var_186_10
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319761", "319761040", "story_v_out_319761.awb") ~= 0 then
					local var_186_14 = manager.audio:GetVoiceLength("story_v_out_319761", "319761040", "story_v_out_319761.awb") / 1000

					if var_186_14 + var_186_6 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_14 + var_186_6
					end

					if var_186_9.prefab_name ~= "" and arg_183_1.actors_[var_186_9.prefab_name] ~= nil then
						local var_186_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_9.prefab_name].transform, "story_v_out_319761", "319761040", "story_v_out_319761.awb")

						arg_183_1:RecordAudio("319761040", var_186_15)
						arg_183_1:RecordAudio("319761040", var_186_15)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_out_319761", "319761040", "story_v_out_319761.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_out_319761", "319761040", "story_v_out_319761.awb")
				end

				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_16 = math.max(var_186_7, arg_183_1.talkMaxDuration)

			if var_186_6 <= arg_183_1.time_ and arg_183_1.time_ < var_186_6 + var_186_16 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_6) / var_186_16

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_6 + var_186_16 and arg_183_1.time_ < var_186_6 + var_186_16 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {}

		arg_183_1:InitPlayNodeList()
	end,
	Play319761041 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 319761041
		arg_187_1.duration_ = 5

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play319761042(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = 0

			if var_190_0 < arg_187_1.time_ and arg_187_1.time_ <= var_190_0 + arg_190_0 then
				arg_187_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_190_1 = 0
			local var_190_2 = 0.825

			if var_190_1 < arg_187_1.time_ and arg_187_1.time_ <= var_190_1 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, false)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_3 = arg_187_1:GetWordFromCfg(319761041)
				local var_190_4 = arg_187_1:FormatText(var_190_3.content)

				arg_187_1.text_.text = var_190_4

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_5 = 33
				local var_190_6 = utf8.len(var_190_4)
				local var_190_7 = var_190_5 <= 0 and var_190_2 or var_190_2 * (var_190_6 / var_190_5)

				if var_190_7 > 0 and var_190_2 < var_190_7 then
					arg_187_1.talkMaxDuration = var_190_7

					if var_190_7 + var_190_1 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_7 + var_190_1
					end
				end

				arg_187_1.text_.text = var_190_4
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)
				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_8 = math.max(var_190_2, arg_187_1.talkMaxDuration)

			if var_190_1 <= arg_187_1.time_ and arg_187_1.time_ < var_190_1 + var_190_8 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_1) / var_190_8

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_1 + var_190_8 and arg_187_1.time_ < var_190_1 + var_190_8 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play319761042 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 319761042
		arg_191_1.duration_ = 4.33

		local var_191_0 = {
			zh = 3.266,
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
				arg_191_0:Play319761043(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = 0

			if var_194_0 < arg_191_1.time_ and arg_191_1.time_ <= var_194_0 + arg_194_0 then
				arg_191_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action4_2")
			end

			local var_194_1 = arg_191_1.actors_["1084ui_story"]
			local var_194_2 = 0

			if var_194_2 < arg_191_1.time_ and arg_191_1.time_ <= var_194_2 + arg_194_0 and not isNil(var_194_1) and arg_191_1.var_.characterEffect1084ui_story == nil then
				arg_191_1.var_.characterEffect1084ui_story = var_194_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_194_3 = 0.200000002980232

			if var_194_2 <= arg_191_1.time_ and arg_191_1.time_ < var_194_2 + var_194_3 and not isNil(var_194_1) then
				local var_194_4 = (arg_191_1.time_ - var_194_2) / var_194_3

				if arg_191_1.var_.characterEffect1084ui_story and not isNil(var_194_1) then
					arg_191_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_191_1.time_ >= var_194_2 + var_194_3 and arg_191_1.time_ < var_194_2 + var_194_3 + arg_194_0 and not isNil(var_194_1) and arg_191_1.var_.characterEffect1084ui_story then
				arg_191_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_194_5 = 0
			local var_194_6 = 0.35

			if var_194_5 < arg_191_1.time_ and arg_191_1.time_ <= var_194_5 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				local var_194_7 = arg_191_1:FormatText(StoryNameCfg[6].name)

				arg_191_1.leftNameTxt_.text = var_194_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_8 = arg_191_1:GetWordFromCfg(319761042)
				local var_194_9 = arg_191_1:FormatText(var_194_8.content)

				arg_191_1.text_.text = var_194_9

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_10 = 14
				local var_194_11 = utf8.len(var_194_9)
				local var_194_12 = var_194_10 <= 0 and var_194_6 or var_194_6 * (var_194_11 / var_194_10)

				if var_194_12 > 0 and var_194_6 < var_194_12 then
					arg_191_1.talkMaxDuration = var_194_12

					if var_194_12 + var_194_5 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_12 + var_194_5
					end
				end

				arg_191_1.text_.text = var_194_9
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319761", "319761042", "story_v_out_319761.awb") ~= 0 then
					local var_194_13 = manager.audio:GetVoiceLength("story_v_out_319761", "319761042", "story_v_out_319761.awb") / 1000

					if var_194_13 + var_194_5 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_13 + var_194_5
					end

					if var_194_8.prefab_name ~= "" and arg_191_1.actors_[var_194_8.prefab_name] ~= nil then
						local var_194_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_8.prefab_name].transform, "story_v_out_319761", "319761042", "story_v_out_319761.awb")

						arg_191_1:RecordAudio("319761042", var_194_14)
						arg_191_1:RecordAudio("319761042", var_194_14)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_out_319761", "319761042", "story_v_out_319761.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_out_319761", "319761042", "story_v_out_319761.awb")
				end

				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_15 = math.max(var_194_6, arg_191_1.talkMaxDuration)

			if var_194_5 <= arg_191_1.time_ and arg_191_1.time_ < var_194_5 + var_194_15 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_5) / var_194_15

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_5 + var_194_15 and arg_191_1.time_ < var_194_5 + var_194_15 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {}

		arg_191_1:InitPlayNodeList()
	end,
	Play319761043 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 319761043
		arg_195_1.duration_ = 2.97

		local var_195_0 = {
			zh = 2.966,
			ja = 2.466
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
				arg_195_0:Play319761044(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = "10066ui_story"

			if arg_195_1.actors_[var_198_0] == nil then
				local var_198_1 = Asset.Load("Char/" .. "10066ui_story")

				if not isNil(var_198_1) then
					local var_198_2 = Object.Instantiate(Asset.Load("Char/" .. "10066ui_story"), arg_195_1.stage_.transform)

					var_198_2.name = var_198_0
					var_198_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_195_1.actors_[var_198_0] = var_198_2

					local var_198_3 = var_198_2:GetComponentInChildren(typeof(CharacterEffect))

					var_198_3.enabled = true

					local var_198_4 = GameObjectTools.GetOrAddComponent(var_198_2, typeof(DynamicBoneHelper))

					if var_198_4 then
						var_198_4:EnableDynamicBone(false)
					end

					arg_195_1:ShowWeapon(var_198_3.transform, false)

					arg_195_1.var_[var_198_0 .. "Animator"] = var_198_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_195_1.var_[var_198_0 .. "Animator"].applyRootMotion = true
					arg_195_1.var_[var_198_0 .. "LipSync"] = var_198_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_198_5 = arg_195_1.actors_["10066ui_story"].transform
			local var_198_6 = 0

			if var_198_6 < arg_195_1.time_ and arg_195_1.time_ <= var_198_6 + arg_198_0 then
				arg_195_1.var_.moveOldPos10066ui_story = var_198_5.localPosition
			end

			local var_198_7 = 0.001

			if var_198_6 <= arg_195_1.time_ and arg_195_1.time_ < var_198_6 + var_198_7 then
				local var_198_8 = (arg_195_1.time_ - var_198_6) / var_198_7
				local var_198_9 = Vector3.New(0.7, -0.99, -5.83)

				var_198_5.localPosition = Vector3.Lerp(arg_195_1.var_.moveOldPos10066ui_story, var_198_9, var_198_8)

				local var_198_10 = manager.ui.mainCamera.transform.position - var_198_5.position

				var_198_5.forward = Vector3.New(var_198_10.x, var_198_10.y, var_198_10.z)

				local var_198_11 = var_198_5.localEulerAngles

				var_198_11.z = 0
				var_198_11.x = 0
				var_198_5.localEulerAngles = var_198_11
			end

			if arg_195_1.time_ >= var_198_6 + var_198_7 and arg_195_1.time_ < var_198_6 + var_198_7 + arg_198_0 then
				var_198_5.localPosition = Vector3.New(0.7, -0.99, -5.83)

				local var_198_12 = manager.ui.mainCamera.transform.position - var_198_5.position

				var_198_5.forward = Vector3.New(var_198_12.x, var_198_12.y, var_198_12.z)

				local var_198_13 = var_198_5.localEulerAngles

				var_198_13.z = 0
				var_198_13.x = 0
				var_198_5.localEulerAngles = var_198_13
			end

			local var_198_14 = arg_195_1.actors_["10066ui_story"]
			local var_198_15 = 0

			if var_198_15 < arg_195_1.time_ and arg_195_1.time_ <= var_198_15 + arg_198_0 and not isNil(var_198_14) and arg_195_1.var_.characterEffect10066ui_story == nil then
				arg_195_1.var_.characterEffect10066ui_story = var_198_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_198_16 = 0.200000002980232

			if var_198_15 <= arg_195_1.time_ and arg_195_1.time_ < var_198_15 + var_198_16 and not isNil(var_198_14) then
				local var_198_17 = (arg_195_1.time_ - var_198_15) / var_198_16

				if arg_195_1.var_.characterEffect10066ui_story and not isNil(var_198_14) then
					arg_195_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_195_1.time_ >= var_198_15 + var_198_16 and arg_195_1.time_ < var_198_15 + var_198_16 + arg_198_0 and not isNil(var_198_14) and arg_195_1.var_.characterEffect10066ui_story then
				arg_195_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_198_18 = 0

			if var_198_18 < arg_195_1.time_ and arg_195_1.time_ <= var_198_18 + arg_198_0 then
				arg_195_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action3_1")
			end

			local var_198_19 = 0

			if var_198_19 < arg_195_1.time_ and arg_195_1.time_ <= var_198_19 + arg_198_0 then
				arg_195_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_198_20 = arg_195_1.actors_["1084ui_story"].transform
			local var_198_21 = 0

			if var_198_21 < arg_195_1.time_ and arg_195_1.time_ <= var_198_21 + arg_198_0 then
				arg_195_1.var_.moveOldPos1084ui_story = var_198_20.localPosition
			end

			local var_198_22 = 0.001

			if var_198_21 <= arg_195_1.time_ and arg_195_1.time_ < var_198_21 + var_198_22 then
				local var_198_23 = (arg_195_1.time_ - var_198_21) / var_198_22
				local var_198_24 = Vector3.New(-0.7, -0.97, -6)

				var_198_20.localPosition = Vector3.Lerp(arg_195_1.var_.moveOldPos1084ui_story, var_198_24, var_198_23)

				local var_198_25 = manager.ui.mainCamera.transform.position - var_198_20.position

				var_198_20.forward = Vector3.New(var_198_25.x, var_198_25.y, var_198_25.z)

				local var_198_26 = var_198_20.localEulerAngles

				var_198_26.z = 0
				var_198_26.x = 0
				var_198_20.localEulerAngles = var_198_26
			end

			if arg_195_1.time_ >= var_198_21 + var_198_22 and arg_195_1.time_ < var_198_21 + var_198_22 + arg_198_0 then
				var_198_20.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_198_27 = manager.ui.mainCamera.transform.position - var_198_20.position

				var_198_20.forward = Vector3.New(var_198_27.x, var_198_27.y, var_198_27.z)

				local var_198_28 = var_198_20.localEulerAngles

				var_198_28.z = 0
				var_198_28.x = 0
				var_198_20.localEulerAngles = var_198_28
			end

			local var_198_29 = arg_195_1.actors_["1084ui_story"]
			local var_198_30 = 0

			if var_198_30 < arg_195_1.time_ and arg_195_1.time_ <= var_198_30 + arg_198_0 and not isNil(var_198_29) and arg_195_1.var_.characterEffect1084ui_story == nil then
				arg_195_1.var_.characterEffect1084ui_story = var_198_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_198_31 = 0.200000002980232

			if var_198_30 <= arg_195_1.time_ and arg_195_1.time_ < var_198_30 + var_198_31 and not isNil(var_198_29) then
				local var_198_32 = (arg_195_1.time_ - var_198_30) / var_198_31

				if arg_195_1.var_.characterEffect1084ui_story and not isNil(var_198_29) then
					local var_198_33 = Mathf.Lerp(0, 0.5, var_198_32)

					arg_195_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_195_1.var_.characterEffect1084ui_story.fillRatio = var_198_33
				end
			end

			if arg_195_1.time_ >= var_198_30 + var_198_31 and arg_195_1.time_ < var_198_30 + var_198_31 + arg_198_0 and not isNil(var_198_29) and arg_195_1.var_.characterEffect1084ui_story then
				local var_198_34 = 0.5

				arg_195_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_195_1.var_.characterEffect1084ui_story.fillRatio = var_198_34
			end

			local var_198_35 = 0
			local var_198_36 = 0.175

			if var_198_35 < arg_195_1.time_ and arg_195_1.time_ <= var_198_35 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				local var_198_37 = arg_195_1:FormatText(StoryNameCfg[640].name)

				arg_195_1.leftNameTxt_.text = var_198_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_38 = arg_195_1:GetWordFromCfg(319761043)
				local var_198_39 = arg_195_1:FormatText(var_198_38.content)

				arg_195_1.text_.text = var_198_39

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_40 = 7
				local var_198_41 = utf8.len(var_198_39)
				local var_198_42 = var_198_40 <= 0 and var_198_36 or var_198_36 * (var_198_41 / var_198_40)

				if var_198_42 > 0 and var_198_36 < var_198_42 then
					arg_195_1.talkMaxDuration = var_198_42

					if var_198_42 + var_198_35 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_42 + var_198_35
					end
				end

				arg_195_1.text_.text = var_198_39
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319761", "319761043", "story_v_out_319761.awb") ~= 0 then
					local var_198_43 = manager.audio:GetVoiceLength("story_v_out_319761", "319761043", "story_v_out_319761.awb") / 1000

					if var_198_43 + var_198_35 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_43 + var_198_35
					end

					if var_198_38.prefab_name ~= "" and arg_195_1.actors_[var_198_38.prefab_name] ~= nil then
						local var_198_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_38.prefab_name].transform, "story_v_out_319761", "319761043", "story_v_out_319761.awb")

						arg_195_1:RecordAudio("319761043", var_198_44)
						arg_195_1:RecordAudio("319761043", var_198_44)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_out_319761", "319761043", "story_v_out_319761.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_out_319761", "319761043", "story_v_out_319761.awb")
				end

				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_45 = math.max(var_198_36, arg_195_1.talkMaxDuration)

			if var_198_35 <= arg_195_1.time_ and arg_195_1.time_ < var_198_35 + var_198_45 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_35) / var_198_45

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_35 + var_198_45 and arg_195_1.time_ < var_198_35 + var_198_45 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
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

		arg_195_1:InitPlayNodeList()
	end,
	Play319761044 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 319761044
		arg_199_1.duration_ = 13.13

		local var_199_0 = {
			zh = 8.8,
			ja = 13.133
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
				arg_199_0:Play319761045(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = 0
			local var_202_1 = 0.875

			if var_202_0 < arg_199_1.time_ and arg_199_1.time_ <= var_202_0 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				local var_202_2 = arg_199_1:FormatText(StoryNameCfg[640].name)

				arg_199_1.leftNameTxt_.text = var_202_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_3 = arg_199_1:GetWordFromCfg(319761044)
				local var_202_4 = arg_199_1:FormatText(var_202_3.content)

				arg_199_1.text_.text = var_202_4

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_5 = 35
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

				if manager.audio:GetVoiceLength("story_v_out_319761", "319761044", "story_v_out_319761.awb") ~= 0 then
					local var_202_8 = manager.audio:GetVoiceLength("story_v_out_319761", "319761044", "story_v_out_319761.awb") / 1000

					if var_202_8 + var_202_0 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_8 + var_202_0
					end

					if var_202_3.prefab_name ~= "" and arg_199_1.actors_[var_202_3.prefab_name] ~= nil then
						local var_202_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_199_1.actors_[var_202_3.prefab_name].transform, "story_v_out_319761", "319761044", "story_v_out_319761.awb")

						arg_199_1:RecordAudio("319761044", var_202_9)
						arg_199_1:RecordAudio("319761044", var_202_9)
					else
						arg_199_1:AudioAction("play", "voice", "story_v_out_319761", "319761044", "story_v_out_319761.awb")
					end

					arg_199_1:RecordHistoryTalkVoice("story_v_out_319761", "319761044", "story_v_out_319761.awb")
				end

				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_10 = math.max(var_202_1, arg_199_1.talkMaxDuration)

			if var_202_0 <= arg_199_1.time_ and arg_199_1.time_ < var_202_0 + var_202_10 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_0) / var_202_10

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_0 + var_202_10 and arg_199_1.time_ < var_202_0 + var_202_10 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {}

		arg_199_1:InitPlayNodeList()
	end,
	Play319761045 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 319761045
		arg_203_1.duration_ = 10.3

		local var_203_0 = {
			zh = 5.333,
			ja = 10.3
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
				arg_203_0:Play319761046(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			local var_206_0 = arg_203_1.actors_["10066ui_story"]
			local var_206_1 = 0

			if var_206_1 < arg_203_1.time_ and arg_203_1.time_ <= var_206_1 + arg_206_0 and not isNil(var_206_0) and arg_203_1.var_.characterEffect10066ui_story == nil then
				arg_203_1.var_.characterEffect10066ui_story = var_206_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_206_2 = 0.200000002980232

			if var_206_1 <= arg_203_1.time_ and arg_203_1.time_ < var_206_1 + var_206_2 and not isNil(var_206_0) then
				local var_206_3 = (arg_203_1.time_ - var_206_1) / var_206_2

				if arg_203_1.var_.characterEffect10066ui_story and not isNil(var_206_0) then
					local var_206_4 = Mathf.Lerp(0, 0.5, var_206_3)

					arg_203_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_203_1.var_.characterEffect10066ui_story.fillRatio = var_206_4
				end
			end

			if arg_203_1.time_ >= var_206_1 + var_206_2 and arg_203_1.time_ < var_206_1 + var_206_2 + arg_206_0 and not isNil(var_206_0) and arg_203_1.var_.characterEffect10066ui_story then
				local var_206_5 = 0.5

				arg_203_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_203_1.var_.characterEffect10066ui_story.fillRatio = var_206_5
			end

			local var_206_6 = arg_203_1.actors_["1084ui_story"]
			local var_206_7 = 0

			if var_206_7 < arg_203_1.time_ and arg_203_1.time_ <= var_206_7 + arg_206_0 and not isNil(var_206_6) and arg_203_1.var_.characterEffect1084ui_story == nil then
				arg_203_1.var_.characterEffect1084ui_story = var_206_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_206_8 = 0.200000002980232

			if var_206_7 <= arg_203_1.time_ and arg_203_1.time_ < var_206_7 + var_206_8 and not isNil(var_206_6) then
				local var_206_9 = (arg_203_1.time_ - var_206_7) / var_206_8

				if arg_203_1.var_.characterEffect1084ui_story and not isNil(var_206_6) then
					arg_203_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_203_1.time_ >= var_206_7 + var_206_8 and arg_203_1.time_ < var_206_7 + var_206_8 + arg_206_0 and not isNil(var_206_6) and arg_203_1.var_.characterEffect1084ui_story then
				arg_203_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_206_10 = 0
			local var_206_11 = 0.725

			if var_206_10 < arg_203_1.time_ and arg_203_1.time_ <= var_206_10 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				local var_206_12 = arg_203_1:FormatText(StoryNameCfg[6].name)

				arg_203_1.leftNameTxt_.text = var_206_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_13 = arg_203_1:GetWordFromCfg(319761045)
				local var_206_14 = arg_203_1:FormatText(var_206_13.content)

				arg_203_1.text_.text = var_206_14

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_15 = 29
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

				if manager.audio:GetVoiceLength("story_v_out_319761", "319761045", "story_v_out_319761.awb") ~= 0 then
					local var_206_18 = manager.audio:GetVoiceLength("story_v_out_319761", "319761045", "story_v_out_319761.awb") / 1000

					if var_206_18 + var_206_10 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_18 + var_206_10
					end

					if var_206_13.prefab_name ~= "" and arg_203_1.actors_[var_206_13.prefab_name] ~= nil then
						local var_206_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_13.prefab_name].transform, "story_v_out_319761", "319761045", "story_v_out_319761.awb")

						arg_203_1:RecordAudio("319761045", var_206_19)
						arg_203_1:RecordAudio("319761045", var_206_19)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_out_319761", "319761045", "story_v_out_319761.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_out_319761", "319761045", "story_v_out_319761.awb")
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
	Play319761046 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 319761046
		arg_207_1.duration_ = 4.3

		local var_207_0 = {
			zh = 3.1,
			ja = 4.3
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
				arg_207_0:Play319761047(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			local var_210_0 = arg_207_1.actors_["10066ui_story"]
			local var_210_1 = 0

			if var_210_1 < arg_207_1.time_ and arg_207_1.time_ <= var_210_1 + arg_210_0 and not isNil(var_210_0) and arg_207_1.var_.characterEffect10066ui_story == nil then
				arg_207_1.var_.characterEffect10066ui_story = var_210_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_2 = 0.200000002980232

			if var_210_1 <= arg_207_1.time_ and arg_207_1.time_ < var_210_1 + var_210_2 and not isNil(var_210_0) then
				local var_210_3 = (arg_207_1.time_ - var_210_1) / var_210_2

				if arg_207_1.var_.characterEffect10066ui_story and not isNil(var_210_0) then
					arg_207_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_207_1.time_ >= var_210_1 + var_210_2 and arg_207_1.time_ < var_210_1 + var_210_2 + arg_210_0 and not isNil(var_210_0) and arg_207_1.var_.characterEffect10066ui_story then
				arg_207_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_210_4 = arg_207_1.actors_["1084ui_story"]
			local var_210_5 = 0

			if var_210_5 < arg_207_1.time_ and arg_207_1.time_ <= var_210_5 + arg_210_0 and not isNil(var_210_4) and arg_207_1.var_.characterEffect1084ui_story == nil then
				arg_207_1.var_.characterEffect1084ui_story = var_210_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_6 = 0.200000002980232

			if var_210_5 <= arg_207_1.time_ and arg_207_1.time_ < var_210_5 + var_210_6 and not isNil(var_210_4) then
				local var_210_7 = (arg_207_1.time_ - var_210_5) / var_210_6

				if arg_207_1.var_.characterEffect1084ui_story and not isNil(var_210_4) then
					local var_210_8 = Mathf.Lerp(0, 0.5, var_210_7)

					arg_207_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_207_1.var_.characterEffect1084ui_story.fillRatio = var_210_8
				end
			end

			if arg_207_1.time_ >= var_210_5 + var_210_6 and arg_207_1.time_ < var_210_5 + var_210_6 + arg_210_0 and not isNil(var_210_4) and arg_207_1.var_.characterEffect1084ui_story then
				local var_210_9 = 0.5

				arg_207_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_207_1.var_.characterEffect1084ui_story.fillRatio = var_210_9
			end

			local var_210_10 = 0
			local var_210_11 = 0.25

			if var_210_10 < arg_207_1.time_ and arg_207_1.time_ <= var_210_10 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				local var_210_12 = arg_207_1:FormatText(StoryNameCfg[640].name)

				arg_207_1.leftNameTxt_.text = var_210_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_13 = arg_207_1:GetWordFromCfg(319761046)
				local var_210_14 = arg_207_1:FormatText(var_210_13.content)

				arg_207_1.text_.text = var_210_14

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_15 = 10
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

				if manager.audio:GetVoiceLength("story_v_out_319761", "319761046", "story_v_out_319761.awb") ~= 0 then
					local var_210_18 = manager.audio:GetVoiceLength("story_v_out_319761", "319761046", "story_v_out_319761.awb") / 1000

					if var_210_18 + var_210_10 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_18 + var_210_10
					end

					if var_210_13.prefab_name ~= "" and arg_207_1.actors_[var_210_13.prefab_name] ~= nil then
						local var_210_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_207_1.actors_[var_210_13.prefab_name].transform, "story_v_out_319761", "319761046", "story_v_out_319761.awb")

						arg_207_1:RecordAudio("319761046", var_210_19)
						arg_207_1:RecordAudio("319761046", var_210_19)
					else
						arg_207_1:AudioAction("play", "voice", "story_v_out_319761", "319761046", "story_v_out_319761.awb")
					end

					arg_207_1:RecordHistoryTalkVoice("story_v_out_319761", "319761046", "story_v_out_319761.awb")
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
	Play319761047 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 319761047
		arg_211_1.duration_ = 6.3

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play319761048(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			local var_214_0 = 0

			if var_214_0 < arg_211_1.time_ and arg_211_1.time_ <= var_214_0 + arg_214_0 then
				arg_211_1.fswbg_:SetActive(true)
				arg_211_1.dialog_:SetActive(false)

				arg_211_1.fswtw_.percent = 0

				local var_214_1 = arg_211_1:GetWordFromCfg(319761047)
				local var_214_2 = arg_211_1:FormatText(var_214_1.content)

				arg_211_1.fswt_.text = var_214_2

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.fswt_)

				arg_211_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_211_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_211_1.fswtw_:SetDirty()

				arg_211_1.typewritterCharCountI18N = 0

				SetActive(arg_211_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_211_1:ShowNextGo(false)
			end

			local var_214_3 = 0.1

			if var_214_3 < arg_211_1.time_ and arg_211_1.time_ <= var_214_3 + arg_214_0 then
				arg_211_1.var_.oldValueTypewriter = arg_211_1.fswtw_.percent

				SetActive(arg_211_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_211_1:ShowNextGo(false)
			end

			local var_214_4 = 28
			local var_214_5 = 1.86666666666667
			local var_214_6 = arg_211_1:GetWordFromCfg(319761047)
			local var_214_7 = arg_211_1:FormatText(var_214_6.content)
			local var_214_8, var_214_9 = arg_211_1:GetPercentByPara(var_214_7, 1)

			if var_214_3 < arg_211_1.time_ and arg_211_1.time_ <= var_214_3 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0

				local var_214_10 = var_214_4 <= 0 and var_214_5 or var_214_5 * ((var_214_9 - arg_211_1.typewritterCharCountI18N) / var_214_4)

				if var_214_10 > 0 and var_214_5 < var_214_10 then
					arg_211_1.talkMaxDuration = var_214_10

					if var_214_10 + var_214_3 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_10 + var_214_3
					end
				end
			end

			local var_214_11 = 1.86666666666667
			local var_214_12 = math.max(var_214_11, arg_211_1.talkMaxDuration)

			if var_214_3 <= arg_211_1.time_ and arg_211_1.time_ < var_214_3 + var_214_12 then
				local var_214_13 = (arg_211_1.time_ - var_214_3) / var_214_12

				arg_211_1.fswtw_.percent = Mathf.Lerp(arg_211_1.var_.oldValueTypewriter, var_214_8, var_214_13)
				arg_211_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_211_1.fswtw_:SetDirty()
			end

			if arg_211_1.time_ >= var_214_3 + var_214_12 and arg_211_1.time_ < var_214_3 + var_214_12 + arg_214_0 then
				arg_211_1.fswtw_.percent = var_214_8

				arg_211_1.fswtw_:SetDirty()
				arg_211_1:ShowNextGo(true)

				arg_211_1.typewritterCharCountI18N = var_214_9
			end

			local var_214_14 = 0

			if var_214_14 < arg_211_1.time_ and arg_211_1.time_ <= var_214_14 + arg_214_0 then
				local var_214_15 = arg_211_1.fswbg_.transform:Find("textbox/adapt/content") or arg_211_1.fswbg_.transform:Find("textbox/content")
				local var_214_16 = arg_211_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_214_17 = var_214_15:GetComponent("Text")
				local var_214_18 = var_214_15:GetComponent("RectTransform")

				var_214_17.alignment = UnityEngine.TextAnchor.LowerCenter
				var_214_18.offsetMin = Vector2.New(0, 0)
				var_214_18.offsetMax = Vector2.New(0, 0)
			end

			local var_214_19 = 0

			if var_214_19 < arg_211_1.time_ and arg_211_1.time_ <= var_214_19 + arg_214_0 then
				local var_214_20 = manager.ui.mainCamera.transform.localPosition
				local var_214_21 = Vector3.New(0, 0, 10) + Vector3.New(var_214_20.x, var_214_20.y, 0)
				local var_214_22 = arg_211_1.bgs_.STblack

				var_214_22.transform.localPosition = var_214_21
				var_214_22.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_214_23 = var_214_22:GetComponent("SpriteRenderer")

				if var_214_23 and var_214_23.sprite then
					local var_214_24 = (var_214_22.transform.localPosition - var_214_20).z
					local var_214_25 = manager.ui.mainCameraCom_
					local var_214_26 = 2 * var_214_24 * Mathf.Tan(var_214_25.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_214_27 = var_214_26 * var_214_25.aspect
					local var_214_28 = var_214_23.sprite.bounds.size.x
					local var_214_29 = var_214_23.sprite.bounds.size.y
					local var_214_30 = var_214_27 / var_214_28
					local var_214_31 = var_214_26 / var_214_29
					local var_214_32 = var_214_31 < var_214_30 and var_214_30 or var_214_31

					var_214_22.transform.localScale = Vector3.New(var_214_32, var_214_32, 0)
				end

				for iter_214_0, iter_214_1 in pairs(arg_211_1.bgs_) do
					if iter_214_0 ~= "STblack" then
						iter_214_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_214_33 = arg_211_1.actors_["10066ui_story"].transform
			local var_214_34 = 0

			if var_214_34 < arg_211_1.time_ and arg_211_1.time_ <= var_214_34 + arg_214_0 then
				arg_211_1.var_.moveOldPos10066ui_story = var_214_33.localPosition
			end

			local var_214_35 = 0.001

			if var_214_34 <= arg_211_1.time_ and arg_211_1.time_ < var_214_34 + var_214_35 then
				local var_214_36 = (arg_211_1.time_ - var_214_34) / var_214_35
				local var_214_37 = Vector3.New(0, 100, 0)

				var_214_33.localPosition = Vector3.Lerp(arg_211_1.var_.moveOldPos10066ui_story, var_214_37, var_214_36)

				local var_214_38 = manager.ui.mainCamera.transform.position - var_214_33.position

				var_214_33.forward = Vector3.New(var_214_38.x, var_214_38.y, var_214_38.z)

				local var_214_39 = var_214_33.localEulerAngles

				var_214_39.z = 0
				var_214_39.x = 0
				var_214_33.localEulerAngles = var_214_39
			end

			if arg_211_1.time_ >= var_214_34 + var_214_35 and arg_211_1.time_ < var_214_34 + var_214_35 + arg_214_0 then
				var_214_33.localPosition = Vector3.New(0, 100, 0)

				local var_214_40 = manager.ui.mainCamera.transform.position - var_214_33.position

				var_214_33.forward = Vector3.New(var_214_40.x, var_214_40.y, var_214_40.z)

				local var_214_41 = var_214_33.localEulerAngles

				var_214_41.z = 0
				var_214_41.x = 0
				var_214_33.localEulerAngles = var_214_41
			end

			local var_214_42 = arg_211_1.actors_["1084ui_story"].transform
			local var_214_43 = 0

			if var_214_43 < arg_211_1.time_ and arg_211_1.time_ <= var_214_43 + arg_214_0 then
				arg_211_1.var_.moveOldPos1084ui_story = var_214_42.localPosition
			end

			local var_214_44 = 0.001

			if var_214_43 <= arg_211_1.time_ and arg_211_1.time_ < var_214_43 + var_214_44 then
				local var_214_45 = (arg_211_1.time_ - var_214_43) / var_214_44
				local var_214_46 = Vector3.New(0, 100, 0)

				var_214_42.localPosition = Vector3.Lerp(arg_211_1.var_.moveOldPos1084ui_story, var_214_46, var_214_45)

				local var_214_47 = manager.ui.mainCamera.transform.position - var_214_42.position

				var_214_42.forward = Vector3.New(var_214_47.x, var_214_47.y, var_214_47.z)

				local var_214_48 = var_214_42.localEulerAngles

				var_214_48.z = 0
				var_214_48.x = 0
				var_214_42.localEulerAngles = var_214_48
			end

			if arg_211_1.time_ >= var_214_43 + var_214_44 and arg_211_1.time_ < var_214_43 + var_214_44 + arg_214_0 then
				var_214_42.localPosition = Vector3.New(0, 100, 0)

				local var_214_49 = manager.ui.mainCamera.transform.position - var_214_42.position

				var_214_42.forward = Vector3.New(var_214_49.x, var_214_49.y, var_214_49.z)

				local var_214_50 = var_214_42.localEulerAngles

				var_214_50.z = 0
				var_214_50.x = 0
				var_214_42.localEulerAngles = var_214_50
			end

			local var_214_51 = 0.1
			local var_214_52 = 6.2
			local var_214_53 = manager.audio:GetVoiceLength("story_v_out_319761", "319761047", "story_v_out_319761.awb") / 1000

			if var_214_53 > 0 and var_214_52 < var_214_53 and var_214_53 + var_214_51 > arg_211_1.duration_ then
				local var_214_54 = var_214_53

				arg_211_1.duration_ = var_214_53 + var_214_51
			end

			if var_214_51 < arg_211_1.time_ and arg_211_1.time_ <= var_214_51 + arg_214_0 then
				local var_214_55 = "play"
				local var_214_56 = "voice"

				arg_211_1:AudioAction(var_214_55, var_214_56, "story_v_out_319761", "319761047", "story_v_out_319761.awb")
			end

			local var_214_57 = 0

			if var_214_57 < arg_211_1.time_ and arg_211_1.time_ <= var_214_57 + arg_214_0 then
				arg_211_1.cswbg_:SetActive(true)

				local var_214_58 = arg_211_1.cswt_:GetComponent("RectTransform")

				arg_211_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_214_58.offsetMin = Vector2.New(410, 330)
				var_214_58.offsetMax = Vector2.New(-400, -180)

				local var_214_59 = arg_211_1:GetWordFromCfg(419052)
				local var_214_60 = arg_211_1:FormatText(var_214_59.content)

				arg_211_1.cswt_.text = var_214_60

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.cswt_)

				arg_211_1.cswt_.fontSize = 175
				arg_211_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_211_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_211_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end
		end

		arg_211_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
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

		arg_211_1:InitPlayNodeList()
	end,
	Play319761048 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 319761048
		arg_215_1.duration_ = 1.77

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play319761049(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			local var_218_0 = 0

			if var_218_0 < arg_215_1.time_ and arg_215_1.time_ <= var_218_0 + arg_218_0 then
				arg_215_1.fswbg_:SetActive(true)
				arg_215_1.dialog_:SetActive(false)

				arg_215_1.fswtw_.percent = 0

				local var_218_1 = arg_215_1:GetWordFromCfg(319761048)
				local var_218_2 = arg_215_1:FormatText(var_218_1.content)

				arg_215_1.fswt_.text = var_218_2

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.fswt_)

				arg_215_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_215_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_215_1.fswtw_:SetDirty()

				arg_215_1.typewritterCharCountI18N = 0

				SetActive(arg_215_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_215_1:ShowNextGo(false)
			end

			local var_218_3 = 0.1

			if var_218_3 < arg_215_1.time_ and arg_215_1.time_ <= var_218_3 + arg_218_0 then
				arg_215_1.var_.oldValueTypewriter = arg_215_1.fswtw_.percent

				SetActive(arg_215_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_215_1:ShowNextGo(false)
			end

			local var_218_4 = 5
			local var_218_5 = 0.333333333333333
			local var_218_6 = arg_215_1:GetWordFromCfg(319761048)
			local var_218_7 = arg_215_1:FormatText(var_218_6.content)
			local var_218_8, var_218_9 = arg_215_1:GetPercentByPara(var_218_7, 1)

			if var_218_3 < arg_215_1.time_ and arg_215_1.time_ <= var_218_3 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0

				local var_218_10 = var_218_4 <= 0 and var_218_5 or var_218_5 * ((var_218_9 - arg_215_1.typewritterCharCountI18N) / var_218_4)

				if var_218_10 > 0 and var_218_5 < var_218_10 then
					arg_215_1.talkMaxDuration = var_218_10

					if var_218_10 + var_218_3 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_10 + var_218_3
					end
				end
			end

			local var_218_11 = 0.333333333333333
			local var_218_12 = math.max(var_218_11, arg_215_1.talkMaxDuration)

			if var_218_3 <= arg_215_1.time_ and arg_215_1.time_ < var_218_3 + var_218_12 then
				local var_218_13 = (arg_215_1.time_ - var_218_3) / var_218_12

				arg_215_1.fswtw_.percent = Mathf.Lerp(arg_215_1.var_.oldValueTypewriter, var_218_8, var_218_13)
				arg_215_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_215_1.fswtw_:SetDirty()
			end

			if arg_215_1.time_ >= var_218_3 + var_218_12 and arg_215_1.time_ < var_218_3 + var_218_12 + arg_218_0 then
				arg_215_1.fswtw_.percent = var_218_8

				arg_215_1.fswtw_:SetDirty()
				arg_215_1:ShowNextGo(true)

				arg_215_1.typewritterCharCountI18N = var_218_9
			end

			local var_218_14 = 0.1
			local var_218_15 = 1.666
			local var_218_16 = manager.audio:GetVoiceLength("story_v_out_319761", "319761048", "story_v_out_319761.awb") / 1000

			if var_218_16 > 0 and var_218_15 < var_218_16 and var_218_16 + var_218_14 > arg_215_1.duration_ then
				local var_218_17 = var_218_16

				arg_215_1.duration_ = var_218_16 + var_218_14
			end

			if var_218_14 < arg_215_1.time_ and arg_215_1.time_ <= var_218_14 + arg_218_0 then
				local var_218_18 = "play"
				local var_218_19 = "voice"

				arg_215_1:AudioAction(var_218_18, var_218_19, "story_v_out_319761", "319761048", "story_v_out_319761.awb")
			end
		end

		arg_215_1.nodeConfigList_ = {}

		arg_215_1:InitPlayNodeList()
	end,
	Play319761049 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 319761049
		arg_219_1.duration_ = 6.53

		local var_219_0 = {
			zh = 3.633,
			ja = 6.533
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
				arg_219_0:Play319761050(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			local var_222_0 = arg_219_1.actors_["1084ui_story"].transform
			local var_222_1 = 0

			if var_222_1 < arg_219_1.time_ and arg_219_1.time_ <= var_222_1 + arg_222_0 then
				arg_219_1.var_.moveOldPos1084ui_story = var_222_0.localPosition
			end

			local var_222_2 = 0.001

			if var_222_1 <= arg_219_1.time_ and arg_219_1.time_ < var_222_1 + var_222_2 then
				local var_222_3 = (arg_219_1.time_ - var_222_1) / var_222_2
				local var_222_4 = Vector3.New(0, -0.97, -6)

				var_222_0.localPosition = Vector3.Lerp(arg_219_1.var_.moveOldPos1084ui_story, var_222_4, var_222_3)

				local var_222_5 = manager.ui.mainCamera.transform.position - var_222_0.position

				var_222_0.forward = Vector3.New(var_222_5.x, var_222_5.y, var_222_5.z)

				local var_222_6 = var_222_0.localEulerAngles

				var_222_6.z = 0
				var_222_6.x = 0
				var_222_0.localEulerAngles = var_222_6
			end

			if arg_219_1.time_ >= var_222_1 + var_222_2 and arg_219_1.time_ < var_222_1 + var_222_2 + arg_222_0 then
				var_222_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_222_7 = manager.ui.mainCamera.transform.position - var_222_0.position

				var_222_0.forward = Vector3.New(var_222_7.x, var_222_7.y, var_222_7.z)

				local var_222_8 = var_222_0.localEulerAngles

				var_222_8.z = 0
				var_222_8.x = 0
				var_222_0.localEulerAngles = var_222_8
			end

			local var_222_9 = arg_219_1.actors_["1084ui_story"]
			local var_222_10 = 0

			if var_222_10 < arg_219_1.time_ and arg_219_1.time_ <= var_222_10 + arg_222_0 and not isNil(var_222_9) and arg_219_1.var_.characterEffect1084ui_story == nil then
				arg_219_1.var_.characterEffect1084ui_story = var_222_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_222_11 = 0.200000002980232

			if var_222_10 <= arg_219_1.time_ and arg_219_1.time_ < var_222_10 + var_222_11 and not isNil(var_222_9) then
				local var_222_12 = (arg_219_1.time_ - var_222_10) / var_222_11

				if arg_219_1.var_.characterEffect1084ui_story and not isNil(var_222_9) then
					arg_219_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_219_1.time_ >= var_222_10 + var_222_11 and arg_219_1.time_ < var_222_10 + var_222_11 + arg_222_0 and not isNil(var_222_9) and arg_219_1.var_.characterEffect1084ui_story then
				arg_219_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_222_13 = 0

			if var_222_13 < arg_219_1.time_ and arg_219_1.time_ <= var_222_13 + arg_222_0 then
				arg_219_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_222_14 = 0

			if var_222_14 < arg_219_1.time_ and arg_219_1.time_ <= var_222_14 + arg_222_0 then
				arg_219_1.fswbg_:SetActive(false)
				arg_219_1.dialog_:SetActive(false)
				SetActive(arg_219_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_219_1:ShowNextGo(false)
			end

			local var_222_15 = 0

			if var_222_15 < arg_219_1.time_ and arg_219_1.time_ <= var_222_15 + arg_222_0 then
				local var_222_16 = manager.ui.mainCamera.transform.localPosition
				local var_222_17 = Vector3.New(0, 0, 10) + Vector3.New(var_222_16.x, var_222_16.y, 0)
				local var_222_18 = arg_219_1.bgs_.D02a

				var_222_18.transform.localPosition = var_222_17
				var_222_18.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_222_19 = var_222_18:GetComponent("SpriteRenderer")

				if var_222_19 and var_222_19.sprite then
					local var_222_20 = (var_222_18.transform.localPosition - var_222_16).z
					local var_222_21 = manager.ui.mainCameraCom_
					local var_222_22 = 2 * var_222_20 * Mathf.Tan(var_222_21.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_222_23 = var_222_22 * var_222_21.aspect
					local var_222_24 = var_222_19.sprite.bounds.size.x
					local var_222_25 = var_222_19.sprite.bounds.size.y
					local var_222_26 = var_222_23 / var_222_24
					local var_222_27 = var_222_22 / var_222_25
					local var_222_28 = var_222_27 < var_222_26 and var_222_26 or var_222_27

					var_222_18.transform.localScale = Vector3.New(var_222_28, var_222_28, 0)
				end

				for iter_222_0, iter_222_1 in pairs(arg_219_1.bgs_) do
					if iter_222_0 ~= "D02a" then
						iter_222_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_222_29 = 0

			if var_222_29 < arg_219_1.time_ and arg_219_1.time_ <= var_222_29 + arg_222_0 then
				arg_219_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_222_30 = 0

			if var_222_30 < arg_219_1.time_ and arg_219_1.time_ <= var_222_30 + arg_222_0 then
				arg_219_1.cswbg_:SetActive(false)
			end

			local var_222_31 = 0
			local var_222_32 = 0.425

			if var_222_31 < arg_219_1.time_ and arg_219_1.time_ <= var_222_31 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0

				arg_219_1.dialog_:SetActive(true)

				arg_219_1.dialogCg_.alpha = 0

				local var_222_33 = LeanTween.value(arg_219_1.dialog_, 0, 1, 0.3)

				var_222_33:setOnUpdate(LuaHelper.FloatAction(function(arg_223_0)
					arg_219_1.dialogCg_.alpha = arg_223_0
				end))
				var_222_33:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_219_1.dialog_)
					var_222_33:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_219_1.duration_ = arg_219_1.duration_ + 0.3

				SetActive(arg_219_1.leftNameGo_, true)

				local var_222_34 = arg_219_1:FormatText(StoryNameCfg[6].name)

				arg_219_1.leftNameTxt_.text = var_222_34

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_35 = arg_219_1:GetWordFromCfg(319761049)
				local var_222_36 = arg_219_1:FormatText(var_222_35.content)

				arg_219_1.text_.text = var_222_36

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_37 = 17
				local var_222_38 = utf8.len(var_222_36)
				local var_222_39 = var_222_37 <= 0 and var_222_32 or var_222_32 * (var_222_38 / var_222_37)

				if var_222_39 > 0 and var_222_32 < var_222_39 then
					arg_219_1.talkMaxDuration = var_222_39
					var_222_31 = var_222_31 + 0.3

					if var_222_39 + var_222_31 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_39 + var_222_31
					end
				end

				arg_219_1.text_.text = var_222_36
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319761", "319761049", "story_v_out_319761.awb") ~= 0 then
					local var_222_40 = manager.audio:GetVoiceLength("story_v_out_319761", "319761049", "story_v_out_319761.awb") / 1000

					if var_222_40 + var_222_31 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_40 + var_222_31
					end

					if var_222_35.prefab_name ~= "" and arg_219_1.actors_[var_222_35.prefab_name] ~= nil then
						local var_222_41 = LuaForUtil.PlayVoiceWithCriLipsync(arg_219_1.actors_[var_222_35.prefab_name].transform, "story_v_out_319761", "319761049", "story_v_out_319761.awb")

						arg_219_1:RecordAudio("319761049", var_222_41)
						arg_219_1:RecordAudio("319761049", var_222_41)
					else
						arg_219_1:AudioAction("play", "voice", "story_v_out_319761", "319761049", "story_v_out_319761.awb")
					end

					arg_219_1:RecordHistoryTalkVoice("story_v_out_319761", "319761049", "story_v_out_319761.awb")
				end

				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_42 = var_222_31 + 0.3
			local var_222_43 = math.max(var_222_32, arg_219_1.talkMaxDuration)

			if var_222_42 <= arg_219_1.time_ and arg_219_1.time_ < var_222_42 + var_222_43 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_42) / var_222_43

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_42 + var_222_43 and arg_219_1.time_ < var_222_42 + var_222_43 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {
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

		arg_219_1:InitPlayNodeList()
	end,
	Play319761050 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 319761050
		arg_225_1.duration_ = 5

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play319761051(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = arg_225_1.actors_["1084ui_story"]
			local var_228_1 = 0

			if var_228_1 < arg_225_1.time_ and arg_225_1.time_ <= var_228_1 + arg_228_0 and not isNil(var_228_0) and arg_225_1.var_.characterEffect1084ui_story == nil then
				arg_225_1.var_.characterEffect1084ui_story = var_228_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_228_2 = 0.200000002980232

			if var_228_1 <= arg_225_1.time_ and arg_225_1.time_ < var_228_1 + var_228_2 and not isNil(var_228_0) then
				local var_228_3 = (arg_225_1.time_ - var_228_1) / var_228_2

				if arg_225_1.var_.characterEffect1084ui_story and not isNil(var_228_0) then
					local var_228_4 = Mathf.Lerp(0, 0.5, var_228_3)

					arg_225_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_225_1.var_.characterEffect1084ui_story.fillRatio = var_228_4
				end
			end

			if arg_225_1.time_ >= var_228_1 + var_228_2 and arg_225_1.time_ < var_228_1 + var_228_2 + arg_228_0 and not isNil(var_228_0) and arg_225_1.var_.characterEffect1084ui_story then
				local var_228_5 = 0.5

				arg_225_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_225_1.var_.characterEffect1084ui_story.fillRatio = var_228_5
			end

			local var_228_6 = arg_225_1.actors_["10066ui_story"].transform
			local var_228_7 = 0

			if var_228_7 < arg_225_1.time_ and arg_225_1.time_ <= var_228_7 + arg_228_0 then
				arg_225_1.var_.moveOldPos10066ui_story = var_228_6.localPosition
			end

			local var_228_8 = 0.001

			if var_228_7 <= arg_225_1.time_ and arg_225_1.time_ < var_228_7 + var_228_8 then
				local var_228_9 = (arg_225_1.time_ - var_228_7) / var_228_8
				local var_228_10 = Vector3.New(0, 100, 0)

				var_228_6.localPosition = Vector3.Lerp(arg_225_1.var_.moveOldPos10066ui_story, var_228_10, var_228_9)

				local var_228_11 = manager.ui.mainCamera.transform.position - var_228_6.position

				var_228_6.forward = Vector3.New(var_228_11.x, var_228_11.y, var_228_11.z)

				local var_228_12 = var_228_6.localEulerAngles

				var_228_12.z = 0
				var_228_12.x = 0
				var_228_6.localEulerAngles = var_228_12
			end

			if arg_225_1.time_ >= var_228_7 + var_228_8 and arg_225_1.time_ < var_228_7 + var_228_8 + arg_228_0 then
				var_228_6.localPosition = Vector3.New(0, 100, 0)

				local var_228_13 = manager.ui.mainCamera.transform.position - var_228_6.position

				var_228_6.forward = Vector3.New(var_228_13.x, var_228_13.y, var_228_13.z)

				local var_228_14 = var_228_6.localEulerAngles

				var_228_14.z = 0
				var_228_14.x = 0
				var_228_6.localEulerAngles = var_228_14
			end

			local var_228_15 = arg_225_1.actors_["1084ui_story"].transform
			local var_228_16 = 0

			if var_228_16 < arg_225_1.time_ and arg_225_1.time_ <= var_228_16 + arg_228_0 then
				arg_225_1.var_.moveOldPos1084ui_story = var_228_15.localPosition
			end

			local var_228_17 = 0.001

			if var_228_16 <= arg_225_1.time_ and arg_225_1.time_ < var_228_16 + var_228_17 then
				local var_228_18 = (arg_225_1.time_ - var_228_16) / var_228_17
				local var_228_19 = Vector3.New(0, 100, 0)

				var_228_15.localPosition = Vector3.Lerp(arg_225_1.var_.moveOldPos1084ui_story, var_228_19, var_228_18)

				local var_228_20 = manager.ui.mainCamera.transform.position - var_228_15.position

				var_228_15.forward = Vector3.New(var_228_20.x, var_228_20.y, var_228_20.z)

				local var_228_21 = var_228_15.localEulerAngles

				var_228_21.z = 0
				var_228_21.x = 0
				var_228_15.localEulerAngles = var_228_21
			end

			if arg_225_1.time_ >= var_228_16 + var_228_17 and arg_225_1.time_ < var_228_16 + var_228_17 + arg_228_0 then
				var_228_15.localPosition = Vector3.New(0, 100, 0)

				local var_228_22 = manager.ui.mainCamera.transform.position - var_228_15.position

				var_228_15.forward = Vector3.New(var_228_22.x, var_228_22.y, var_228_22.z)

				local var_228_23 = var_228_15.localEulerAngles

				var_228_23.z = 0
				var_228_23.x = 0
				var_228_15.localEulerAngles = var_228_23
			end

			local var_228_24 = 0
			local var_228_25 = 0.85

			if var_228_24 < arg_225_1.time_ and arg_225_1.time_ <= var_228_24 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0

				arg_225_1.dialog_:SetActive(true)

				arg_225_1.dialogCg_.alpha = 0

				local var_228_26 = LeanTween.value(arg_225_1.dialog_, 0, 1, 0.3)

				var_228_26:setOnUpdate(LuaHelper.FloatAction(function(arg_229_0)
					arg_225_1.dialogCg_.alpha = arg_229_0
				end))
				var_228_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_225_1.dialog_)
					var_228_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_225_1.duration_ = arg_225_1.duration_ + 0.3

				SetActive(arg_225_1.leftNameGo_, false)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_27 = arg_225_1:GetWordFromCfg(319761050)
				local var_228_28 = arg_225_1:FormatText(var_228_27.content)

				arg_225_1.text_.text = var_228_28

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_29 = 34
				local var_228_30 = utf8.len(var_228_28)
				local var_228_31 = var_228_29 <= 0 and var_228_25 or var_228_25 * (var_228_30 / var_228_29)

				if var_228_31 > 0 and var_228_25 < var_228_31 then
					arg_225_1.talkMaxDuration = var_228_31
					var_228_24 = var_228_24 + 0.3

					if var_228_31 + var_228_24 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_31 + var_228_24
					end
				end

				arg_225_1.text_.text = var_228_28
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)
				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_32 = var_228_24 + 0.3
			local var_228_33 = math.max(var_228_25, arg_225_1.talkMaxDuration)

			if var_228_32 <= arg_225_1.time_ and arg_225_1.time_ < var_228_32 + var_228_33 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_32) / var_228_33

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_32 + var_228_33 and arg_225_1.time_ < var_228_32 + var_228_33 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
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

		arg_225_1:InitPlayNodeList()
	end,
	Play319761051 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 319761051
		arg_231_1.duration_ = 6.63

		local var_231_0 = {
			zh = 2.233,
			ja = 6.633
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
				arg_231_0:Play319761052(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			local var_234_0 = arg_231_1.actors_["10066ui_story"].transform
			local var_234_1 = 0

			if var_234_1 < arg_231_1.time_ and arg_231_1.time_ <= var_234_1 + arg_234_0 then
				arg_231_1.var_.moveOldPos10066ui_story = var_234_0.localPosition
			end

			local var_234_2 = 0.001

			if var_234_1 <= arg_231_1.time_ and arg_231_1.time_ < var_234_1 + var_234_2 then
				local var_234_3 = (arg_231_1.time_ - var_234_1) / var_234_2
				local var_234_4 = Vector3.New(0, 100, 0)

				var_234_0.localPosition = Vector3.Lerp(arg_231_1.var_.moveOldPos10066ui_story, var_234_4, var_234_3)

				local var_234_5 = manager.ui.mainCamera.transform.position - var_234_0.position

				var_234_0.forward = Vector3.New(var_234_5.x, var_234_5.y, var_234_5.z)

				local var_234_6 = var_234_0.localEulerAngles

				var_234_6.z = 0
				var_234_6.x = 0
				var_234_0.localEulerAngles = var_234_6
			end

			if arg_231_1.time_ >= var_234_1 + var_234_2 and arg_231_1.time_ < var_234_1 + var_234_2 + arg_234_0 then
				var_234_0.localPosition = Vector3.New(0, 100, 0)

				local var_234_7 = manager.ui.mainCamera.transform.position - var_234_0.position

				var_234_0.forward = Vector3.New(var_234_7.x, var_234_7.y, var_234_7.z)

				local var_234_8 = var_234_0.localEulerAngles

				var_234_8.z = 0
				var_234_8.x = 0
				var_234_0.localEulerAngles = var_234_8
			end

			local var_234_9 = arg_231_1.actors_["1084ui_story"].transform
			local var_234_10 = 0

			if var_234_10 < arg_231_1.time_ and arg_231_1.time_ <= var_234_10 + arg_234_0 then
				arg_231_1.var_.moveOldPos1084ui_story = var_234_9.localPosition
			end

			local var_234_11 = 0.001

			if var_234_10 <= arg_231_1.time_ and arg_231_1.time_ < var_234_10 + var_234_11 then
				local var_234_12 = (arg_231_1.time_ - var_234_10) / var_234_11
				local var_234_13 = Vector3.New(-0.7, -0.97, -6)

				var_234_9.localPosition = Vector3.Lerp(arg_231_1.var_.moveOldPos1084ui_story, var_234_13, var_234_12)

				local var_234_14 = manager.ui.mainCamera.transform.position - var_234_9.position

				var_234_9.forward = Vector3.New(var_234_14.x, var_234_14.y, var_234_14.z)

				local var_234_15 = var_234_9.localEulerAngles

				var_234_15.z = 0
				var_234_15.x = 0
				var_234_9.localEulerAngles = var_234_15
			end

			if arg_231_1.time_ >= var_234_10 + var_234_11 and arg_231_1.time_ < var_234_10 + var_234_11 + arg_234_0 then
				var_234_9.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_234_16 = manager.ui.mainCamera.transform.position - var_234_9.position

				var_234_9.forward = Vector3.New(var_234_16.x, var_234_16.y, var_234_16.z)

				local var_234_17 = var_234_9.localEulerAngles

				var_234_17.z = 0
				var_234_17.x = 0
				var_234_9.localEulerAngles = var_234_17
			end

			local var_234_18 = arg_231_1.actors_["1084ui_story"]
			local var_234_19 = 0

			if var_234_19 < arg_231_1.time_ and arg_231_1.time_ <= var_234_19 + arg_234_0 and not isNil(var_234_18) and arg_231_1.var_.characterEffect1084ui_story == nil then
				arg_231_1.var_.characterEffect1084ui_story = var_234_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_234_20 = 0.200000002980232

			if var_234_19 <= arg_231_1.time_ and arg_231_1.time_ < var_234_19 + var_234_20 and not isNil(var_234_18) then
				local var_234_21 = (arg_231_1.time_ - var_234_19) / var_234_20

				if arg_231_1.var_.characterEffect1084ui_story and not isNil(var_234_18) then
					arg_231_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_231_1.time_ >= var_234_19 + var_234_20 and arg_231_1.time_ < var_234_19 + var_234_20 + arg_234_0 and not isNil(var_234_18) and arg_231_1.var_.characterEffect1084ui_story then
				arg_231_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_234_22 = 0

			if var_234_22 < arg_231_1.time_ and arg_231_1.time_ <= var_234_22 + arg_234_0 then
				arg_231_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action4128")
			end

			local var_234_23 = 0
			local var_234_24 = 0.3

			if var_234_23 < arg_231_1.time_ and arg_231_1.time_ <= var_234_23 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				local var_234_25 = arg_231_1:FormatText(StoryNameCfg[6].name)

				arg_231_1.leftNameTxt_.text = var_234_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_26 = arg_231_1:GetWordFromCfg(319761051)
				local var_234_27 = arg_231_1:FormatText(var_234_26.content)

				arg_231_1.text_.text = var_234_27

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_28 = 12
				local var_234_29 = utf8.len(var_234_27)
				local var_234_30 = var_234_28 <= 0 and var_234_24 or var_234_24 * (var_234_29 / var_234_28)

				if var_234_30 > 0 and var_234_24 < var_234_30 then
					arg_231_1.talkMaxDuration = var_234_30

					if var_234_30 + var_234_23 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_30 + var_234_23
					end
				end

				arg_231_1.text_.text = var_234_27
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319761", "319761051", "story_v_out_319761.awb") ~= 0 then
					local var_234_31 = manager.audio:GetVoiceLength("story_v_out_319761", "319761051", "story_v_out_319761.awb") / 1000

					if var_234_31 + var_234_23 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_31 + var_234_23
					end

					if var_234_26.prefab_name ~= "" and arg_231_1.actors_[var_234_26.prefab_name] ~= nil then
						local var_234_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_231_1.actors_[var_234_26.prefab_name].transform, "story_v_out_319761", "319761051", "story_v_out_319761.awb")

						arg_231_1:RecordAudio("319761051", var_234_32)
						arg_231_1:RecordAudio("319761051", var_234_32)
					else
						arg_231_1:AudioAction("play", "voice", "story_v_out_319761", "319761051", "story_v_out_319761.awb")
					end

					arg_231_1:RecordHistoryTalkVoice("story_v_out_319761", "319761051", "story_v_out_319761.awb")
				end

				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_33 = math.max(var_234_24, arg_231_1.talkMaxDuration)

			if var_234_23 <= arg_231_1.time_ and arg_231_1.time_ < var_234_23 + var_234_33 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_23) / var_234_33

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_23 + var_234_33 and arg_231_1.time_ < var_234_23 + var_234_33 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
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

		arg_231_1:InitPlayNodeList()
	end,
	Play319761052 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 319761052
		arg_235_1.duration_ = 9.87

		local var_235_0 = {
			zh = 9.866,
			ja = 6.033
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
				arg_235_0:Play319761053(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			local var_238_0 = arg_235_1.actors_["10066ui_story"].transform
			local var_238_1 = 0

			if var_238_1 < arg_235_1.time_ and arg_235_1.time_ <= var_238_1 + arg_238_0 then
				arg_235_1.var_.moveOldPos10066ui_story = var_238_0.localPosition
			end

			local var_238_2 = 0.001

			if var_238_1 <= arg_235_1.time_ and arg_235_1.time_ < var_238_1 + var_238_2 then
				local var_238_3 = (arg_235_1.time_ - var_238_1) / var_238_2
				local var_238_4 = Vector3.New(0.7, -0.99, -5.83)

				var_238_0.localPosition = Vector3.Lerp(arg_235_1.var_.moveOldPos10066ui_story, var_238_4, var_238_3)

				local var_238_5 = manager.ui.mainCamera.transform.position - var_238_0.position

				var_238_0.forward = Vector3.New(var_238_5.x, var_238_5.y, var_238_5.z)

				local var_238_6 = var_238_0.localEulerAngles

				var_238_6.z = 0
				var_238_6.x = 0
				var_238_0.localEulerAngles = var_238_6
			end

			if arg_235_1.time_ >= var_238_1 + var_238_2 and arg_235_1.time_ < var_238_1 + var_238_2 + arg_238_0 then
				var_238_0.localPosition = Vector3.New(0.7, -0.99, -5.83)

				local var_238_7 = manager.ui.mainCamera.transform.position - var_238_0.position

				var_238_0.forward = Vector3.New(var_238_7.x, var_238_7.y, var_238_7.z)

				local var_238_8 = var_238_0.localEulerAngles

				var_238_8.z = 0
				var_238_8.x = 0
				var_238_0.localEulerAngles = var_238_8
			end

			local var_238_9 = arg_235_1.actors_["10066ui_story"]
			local var_238_10 = 0

			if var_238_10 < arg_235_1.time_ and arg_235_1.time_ <= var_238_10 + arg_238_0 and not isNil(var_238_9) and arg_235_1.var_.characterEffect10066ui_story == nil then
				arg_235_1.var_.characterEffect10066ui_story = var_238_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_238_11 = 0.200000002980232

			if var_238_10 <= arg_235_1.time_ and arg_235_1.time_ < var_238_10 + var_238_11 and not isNil(var_238_9) then
				local var_238_12 = (arg_235_1.time_ - var_238_10) / var_238_11

				if arg_235_1.var_.characterEffect10066ui_story and not isNil(var_238_9) then
					arg_235_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_235_1.time_ >= var_238_10 + var_238_11 and arg_235_1.time_ < var_238_10 + var_238_11 + arg_238_0 and not isNil(var_238_9) and arg_235_1.var_.characterEffect10066ui_story then
				arg_235_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_238_13 = 0

			if var_238_13 < arg_235_1.time_ and arg_235_1.time_ <= var_238_13 + arg_238_0 then
				arg_235_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action3_2")
			end

			local var_238_14 = 0

			if var_238_14 < arg_235_1.time_ and arg_235_1.time_ <= var_238_14 + arg_238_0 then
				arg_235_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2202cva")
			end

			local var_238_15 = arg_235_1.actors_["1084ui_story"]
			local var_238_16 = 0

			if var_238_16 < arg_235_1.time_ and arg_235_1.time_ <= var_238_16 + arg_238_0 and not isNil(var_238_15) and arg_235_1.var_.characterEffect1084ui_story == nil then
				arg_235_1.var_.characterEffect1084ui_story = var_238_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_238_17 = 0.200000002980232

			if var_238_16 <= arg_235_1.time_ and arg_235_1.time_ < var_238_16 + var_238_17 and not isNil(var_238_15) then
				local var_238_18 = (arg_235_1.time_ - var_238_16) / var_238_17

				if arg_235_1.var_.characterEffect1084ui_story and not isNil(var_238_15) then
					local var_238_19 = Mathf.Lerp(0, 0.5, var_238_18)

					arg_235_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_235_1.var_.characterEffect1084ui_story.fillRatio = var_238_19
				end
			end

			if arg_235_1.time_ >= var_238_16 + var_238_17 and arg_235_1.time_ < var_238_16 + var_238_17 + arg_238_0 and not isNil(var_238_15) and arg_235_1.var_.characterEffect1084ui_story then
				local var_238_20 = 0.5

				arg_235_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_235_1.var_.characterEffect1084ui_story.fillRatio = var_238_20
			end

			local var_238_21 = 0
			local var_238_22 = 0.9

			if var_238_21 < arg_235_1.time_ and arg_235_1.time_ <= var_238_21 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				local var_238_23 = arg_235_1:FormatText(StoryNameCfg[640].name)

				arg_235_1.leftNameTxt_.text = var_238_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_24 = arg_235_1:GetWordFromCfg(319761052)
				local var_238_25 = arg_235_1:FormatText(var_238_24.content)

				arg_235_1.text_.text = var_238_25

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_26 = 36
				local var_238_27 = utf8.len(var_238_25)
				local var_238_28 = var_238_26 <= 0 and var_238_22 or var_238_22 * (var_238_27 / var_238_26)

				if var_238_28 > 0 and var_238_22 < var_238_28 then
					arg_235_1.talkMaxDuration = var_238_28

					if var_238_28 + var_238_21 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_28 + var_238_21
					end
				end

				arg_235_1.text_.text = var_238_25
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319761", "319761052", "story_v_out_319761.awb") ~= 0 then
					local var_238_29 = manager.audio:GetVoiceLength("story_v_out_319761", "319761052", "story_v_out_319761.awb") / 1000

					if var_238_29 + var_238_21 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_29 + var_238_21
					end

					if var_238_24.prefab_name ~= "" and arg_235_1.actors_[var_238_24.prefab_name] ~= nil then
						local var_238_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_235_1.actors_[var_238_24.prefab_name].transform, "story_v_out_319761", "319761052", "story_v_out_319761.awb")

						arg_235_1:RecordAudio("319761052", var_238_30)
						arg_235_1:RecordAudio("319761052", var_238_30)
					else
						arg_235_1:AudioAction("play", "voice", "story_v_out_319761", "319761052", "story_v_out_319761.awb")
					end

					arg_235_1:RecordHistoryTalkVoice("story_v_out_319761", "319761052", "story_v_out_319761.awb")
				end

				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_31 = math.max(var_238_22, arg_235_1.talkMaxDuration)

			if var_238_21 <= arg_235_1.time_ and arg_235_1.time_ < var_238_21 + var_238_31 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_21) / var_238_31

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_21 + var_238_31 and arg_235_1.time_ < var_238_21 + var_238_31 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_235_1:InitPlayNodeList()
	end,
	Play319761053 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 319761053
		arg_239_1.duration_ = 13.4

		local var_239_0 = {
			zh = 13.4,
			ja = 10.8
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
				arg_239_0:Play319761054(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			local var_242_0 = 0
			local var_242_1 = 1.35

			if var_242_0 < arg_239_1.time_ and arg_239_1.time_ <= var_242_0 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				local var_242_2 = arg_239_1:FormatText(StoryNameCfg[640].name)

				arg_239_1.leftNameTxt_.text = var_242_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_3 = arg_239_1:GetWordFromCfg(319761053)
				local var_242_4 = arg_239_1:FormatText(var_242_3.content)

				arg_239_1.text_.text = var_242_4

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_5 = 54
				local var_242_6 = utf8.len(var_242_4)
				local var_242_7 = var_242_5 <= 0 and var_242_1 or var_242_1 * (var_242_6 / var_242_5)

				if var_242_7 > 0 and var_242_1 < var_242_7 then
					arg_239_1.talkMaxDuration = var_242_7

					if var_242_7 + var_242_0 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_7 + var_242_0
					end
				end

				arg_239_1.text_.text = var_242_4
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319761", "319761053", "story_v_out_319761.awb") ~= 0 then
					local var_242_8 = manager.audio:GetVoiceLength("story_v_out_319761", "319761053", "story_v_out_319761.awb") / 1000

					if var_242_8 + var_242_0 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_8 + var_242_0
					end

					if var_242_3.prefab_name ~= "" and arg_239_1.actors_[var_242_3.prefab_name] ~= nil then
						local var_242_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_239_1.actors_[var_242_3.prefab_name].transform, "story_v_out_319761", "319761053", "story_v_out_319761.awb")

						arg_239_1:RecordAudio("319761053", var_242_9)
						arg_239_1:RecordAudio("319761053", var_242_9)
					else
						arg_239_1:AudioAction("play", "voice", "story_v_out_319761", "319761053", "story_v_out_319761.awb")
					end

					arg_239_1:RecordHistoryTalkVoice("story_v_out_319761", "319761053", "story_v_out_319761.awb")
				end

				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_10 = math.max(var_242_1, arg_239_1.talkMaxDuration)

			if var_242_0 <= arg_239_1.time_ and arg_239_1.time_ < var_242_0 + var_242_10 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_0) / var_242_10

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_0 + var_242_10 and arg_239_1.time_ < var_242_0 + var_242_10 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {}

		arg_239_1:InitPlayNodeList()
	end,
	Play319761054 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 319761054
		arg_243_1.duration_ = 4.63

		local var_243_0 = {
			zh = 4.633,
			ja = 3.466
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
				arg_243_0:Play319761055(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			local var_246_0 = 0

			if var_246_0 < arg_243_1.time_ and arg_243_1.time_ <= var_246_0 + arg_246_0 then
				arg_243_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action7_1")
			end

			local var_246_1 = 0

			if var_246_1 < arg_243_1.time_ and arg_243_1.time_ <= var_246_1 + arg_246_0 then
				arg_243_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1204cva")
			end

			local var_246_2 = 0
			local var_246_3 = 0.275

			if var_246_2 < arg_243_1.time_ and arg_243_1.time_ <= var_246_2 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				local var_246_4 = arg_243_1:FormatText(StoryNameCfg[640].name)

				arg_243_1.leftNameTxt_.text = var_246_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_5 = arg_243_1:GetWordFromCfg(319761054)
				local var_246_6 = arg_243_1:FormatText(var_246_5.content)

				arg_243_1.text_.text = var_246_6

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_7 = 11
				local var_246_8 = utf8.len(var_246_6)
				local var_246_9 = var_246_7 <= 0 and var_246_3 or var_246_3 * (var_246_8 / var_246_7)

				if var_246_9 > 0 and var_246_3 < var_246_9 then
					arg_243_1.talkMaxDuration = var_246_9

					if var_246_9 + var_246_2 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_9 + var_246_2
					end
				end

				arg_243_1.text_.text = var_246_6
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319761", "319761054", "story_v_out_319761.awb") ~= 0 then
					local var_246_10 = manager.audio:GetVoiceLength("story_v_out_319761", "319761054", "story_v_out_319761.awb") / 1000

					if var_246_10 + var_246_2 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_10 + var_246_2
					end

					if var_246_5.prefab_name ~= "" and arg_243_1.actors_[var_246_5.prefab_name] ~= nil then
						local var_246_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_243_1.actors_[var_246_5.prefab_name].transform, "story_v_out_319761", "319761054", "story_v_out_319761.awb")

						arg_243_1:RecordAudio("319761054", var_246_11)
						arg_243_1:RecordAudio("319761054", var_246_11)
					else
						arg_243_1:AudioAction("play", "voice", "story_v_out_319761", "319761054", "story_v_out_319761.awb")
					end

					arg_243_1:RecordHistoryTalkVoice("story_v_out_319761", "319761054", "story_v_out_319761.awb")
				end

				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_12 = math.max(var_246_3, arg_243_1.talkMaxDuration)

			if var_246_2 <= arg_243_1.time_ and arg_243_1.time_ < var_246_2 + var_246_12 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_2) / var_246_12

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_2 + var_246_12 and arg_243_1.time_ < var_246_2 + var_246_12 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {}

		arg_243_1:InitPlayNodeList()
	end,
	Play319761055 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 319761055
		arg_247_1.duration_ = 4.33

		local var_247_0 = {
			zh = 4.333,
			ja = 4.2
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
				arg_247_0:Play319761056(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			local var_250_0 = arg_247_1.actors_["1084ui_story"]
			local var_250_1 = 0

			if var_250_1 < arg_247_1.time_ and arg_247_1.time_ <= var_250_1 + arg_250_0 and not isNil(var_250_0) and arg_247_1.var_.characterEffect1084ui_story == nil then
				arg_247_1.var_.characterEffect1084ui_story = var_250_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_250_2 = 0.200000002980232

			if var_250_1 <= arg_247_1.time_ and arg_247_1.time_ < var_250_1 + var_250_2 and not isNil(var_250_0) then
				local var_250_3 = (arg_247_1.time_ - var_250_1) / var_250_2

				if arg_247_1.var_.characterEffect1084ui_story and not isNil(var_250_0) then
					arg_247_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_247_1.time_ >= var_250_1 + var_250_2 and arg_247_1.time_ < var_250_1 + var_250_2 + arg_250_0 and not isNil(var_250_0) and arg_247_1.var_.characterEffect1084ui_story then
				arg_247_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_250_4 = 0

			if var_250_4 < arg_247_1.time_ and arg_247_1.time_ <= var_250_4 + arg_250_0 then
				arg_247_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action8_2")
			end

			local var_250_5 = 0

			if var_250_5 < arg_247_1.time_ and arg_247_1.time_ <= var_250_5 + arg_250_0 then
				arg_247_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_250_6 = arg_247_1.actors_["10066ui_story"]
			local var_250_7 = 0

			if var_250_7 < arg_247_1.time_ and arg_247_1.time_ <= var_250_7 + arg_250_0 and not isNil(var_250_6) and arg_247_1.var_.characterEffect10066ui_story == nil then
				arg_247_1.var_.characterEffect10066ui_story = var_250_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_250_8 = 0.200000002980232

			if var_250_7 <= arg_247_1.time_ and arg_247_1.time_ < var_250_7 + var_250_8 and not isNil(var_250_6) then
				local var_250_9 = (arg_247_1.time_ - var_250_7) / var_250_8

				if arg_247_1.var_.characterEffect10066ui_story and not isNil(var_250_6) then
					local var_250_10 = Mathf.Lerp(0, 0.5, var_250_9)

					arg_247_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_247_1.var_.characterEffect10066ui_story.fillRatio = var_250_10
				end
			end

			if arg_247_1.time_ >= var_250_7 + var_250_8 and arg_247_1.time_ < var_250_7 + var_250_8 + arg_250_0 and not isNil(var_250_6) and arg_247_1.var_.characterEffect10066ui_story then
				local var_250_11 = 0.5

				arg_247_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_247_1.var_.characterEffect10066ui_story.fillRatio = var_250_11
			end

			local var_250_12 = 0
			local var_250_13 = 0.575

			if var_250_12 < arg_247_1.time_ and arg_247_1.time_ <= var_250_12 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				local var_250_14 = arg_247_1:FormatText(StoryNameCfg[6].name)

				arg_247_1.leftNameTxt_.text = var_250_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_15 = arg_247_1:GetWordFromCfg(319761055)
				local var_250_16 = arg_247_1:FormatText(var_250_15.content)

				arg_247_1.text_.text = var_250_16

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_17 = 23
				local var_250_18 = utf8.len(var_250_16)
				local var_250_19 = var_250_17 <= 0 and var_250_13 or var_250_13 * (var_250_18 / var_250_17)

				if var_250_19 > 0 and var_250_13 < var_250_19 then
					arg_247_1.talkMaxDuration = var_250_19

					if var_250_19 + var_250_12 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_19 + var_250_12
					end
				end

				arg_247_1.text_.text = var_250_16
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319761", "319761055", "story_v_out_319761.awb") ~= 0 then
					local var_250_20 = manager.audio:GetVoiceLength("story_v_out_319761", "319761055", "story_v_out_319761.awb") / 1000

					if var_250_20 + var_250_12 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_20 + var_250_12
					end

					if var_250_15.prefab_name ~= "" and arg_247_1.actors_[var_250_15.prefab_name] ~= nil then
						local var_250_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_247_1.actors_[var_250_15.prefab_name].transform, "story_v_out_319761", "319761055", "story_v_out_319761.awb")

						arg_247_1:RecordAudio("319761055", var_250_21)
						arg_247_1:RecordAudio("319761055", var_250_21)
					else
						arg_247_1:AudioAction("play", "voice", "story_v_out_319761", "319761055", "story_v_out_319761.awb")
					end

					arg_247_1:RecordHistoryTalkVoice("story_v_out_319761", "319761055", "story_v_out_319761.awb")
				end

				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_22 = math.max(var_250_13, arg_247_1.talkMaxDuration)

			if var_250_12 <= arg_247_1.time_ and arg_247_1.time_ < var_250_12 + var_250_22 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_12) / var_250_22

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_12 + var_250_22 and arg_247_1.time_ < var_250_12 + var_250_22 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {}

		arg_247_1:InitPlayNodeList()
	end,
	Play319761056 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 319761056
		arg_251_1.duration_ = 4.1

		local var_251_0 = {
			zh = 4.1,
			ja = 4
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
				arg_251_0:Play319761057(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			local var_254_0 = arg_251_1.actors_["10066ui_story"].transform
			local var_254_1 = 0

			if var_254_1 < arg_251_1.time_ and arg_251_1.time_ <= var_254_1 + arg_254_0 then
				arg_251_1.var_.moveOldPos10066ui_story = var_254_0.localPosition
			end

			local var_254_2 = 0.001

			if var_254_1 <= arg_251_1.time_ and arg_251_1.time_ < var_254_1 + var_254_2 then
				local var_254_3 = (arg_251_1.time_ - var_254_1) / var_254_2
				local var_254_4 = Vector3.New(0.7, -0.99, -5.83)

				var_254_0.localPosition = Vector3.Lerp(arg_251_1.var_.moveOldPos10066ui_story, var_254_4, var_254_3)

				local var_254_5 = manager.ui.mainCamera.transform.position - var_254_0.position

				var_254_0.forward = Vector3.New(var_254_5.x, var_254_5.y, var_254_5.z)

				local var_254_6 = var_254_0.localEulerAngles

				var_254_6.z = 0
				var_254_6.x = 0
				var_254_0.localEulerAngles = var_254_6
			end

			if arg_251_1.time_ >= var_254_1 + var_254_2 and arg_251_1.time_ < var_254_1 + var_254_2 + arg_254_0 then
				var_254_0.localPosition = Vector3.New(0.7, -0.99, -5.83)

				local var_254_7 = manager.ui.mainCamera.transform.position - var_254_0.position

				var_254_0.forward = Vector3.New(var_254_7.x, var_254_7.y, var_254_7.z)

				local var_254_8 = var_254_0.localEulerAngles

				var_254_8.z = 0
				var_254_8.x = 0
				var_254_0.localEulerAngles = var_254_8
			end

			local var_254_9 = arg_251_1.actors_["10066ui_story"]
			local var_254_10 = 0

			if var_254_10 < arg_251_1.time_ and arg_251_1.time_ <= var_254_10 + arg_254_0 and not isNil(var_254_9) and arg_251_1.var_.characterEffect10066ui_story == nil then
				arg_251_1.var_.characterEffect10066ui_story = var_254_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_254_11 = 0.200000002980232

			if var_254_10 <= arg_251_1.time_ and arg_251_1.time_ < var_254_10 + var_254_11 and not isNil(var_254_9) then
				local var_254_12 = (arg_251_1.time_ - var_254_10) / var_254_11

				if arg_251_1.var_.characterEffect10066ui_story and not isNil(var_254_9) then
					arg_251_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_251_1.time_ >= var_254_10 + var_254_11 and arg_251_1.time_ < var_254_10 + var_254_11 + arg_254_0 and not isNil(var_254_9) and arg_251_1.var_.characterEffect10066ui_story then
				arg_251_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_254_13 = 0

			if var_254_13 < arg_251_1.time_ and arg_251_1.time_ <= var_254_13 + arg_254_0 then
				arg_251_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_254_14 = arg_251_1.actors_["1084ui_story"]
			local var_254_15 = 0

			if var_254_15 < arg_251_1.time_ and arg_251_1.time_ <= var_254_15 + arg_254_0 and not isNil(var_254_14) and arg_251_1.var_.characterEffect1084ui_story == nil then
				arg_251_1.var_.characterEffect1084ui_story = var_254_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_254_16 = 0.200000002980232

			if var_254_15 <= arg_251_1.time_ and arg_251_1.time_ < var_254_15 + var_254_16 and not isNil(var_254_14) then
				local var_254_17 = (arg_251_1.time_ - var_254_15) / var_254_16

				if arg_251_1.var_.characterEffect1084ui_story and not isNil(var_254_14) then
					local var_254_18 = Mathf.Lerp(0, 0.5, var_254_17)

					arg_251_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_251_1.var_.characterEffect1084ui_story.fillRatio = var_254_18
				end
			end

			if arg_251_1.time_ >= var_254_15 + var_254_16 and arg_251_1.time_ < var_254_15 + var_254_16 + arg_254_0 and not isNil(var_254_14) and arg_251_1.var_.characterEffect1084ui_story then
				local var_254_19 = 0.5

				arg_251_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_251_1.var_.characterEffect1084ui_story.fillRatio = var_254_19
			end

			local var_254_20 = 0
			local var_254_21 = 0.375

			if var_254_20 < arg_251_1.time_ and arg_251_1.time_ <= var_254_20 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				local var_254_22 = arg_251_1:FormatText(StoryNameCfg[640].name)

				arg_251_1.leftNameTxt_.text = var_254_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, false)
				arg_251_1.callingController_:SetSelectedState("normal")

				local var_254_23 = arg_251_1:GetWordFromCfg(319761056)
				local var_254_24 = arg_251_1:FormatText(var_254_23.content)

				arg_251_1.text_.text = var_254_24

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_25 = 15
				local var_254_26 = utf8.len(var_254_24)
				local var_254_27 = var_254_25 <= 0 and var_254_21 or var_254_21 * (var_254_26 / var_254_25)

				if var_254_27 > 0 and var_254_21 < var_254_27 then
					arg_251_1.talkMaxDuration = var_254_27

					if var_254_27 + var_254_20 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_27 + var_254_20
					end
				end

				arg_251_1.text_.text = var_254_24
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319761", "319761056", "story_v_out_319761.awb") ~= 0 then
					local var_254_28 = manager.audio:GetVoiceLength("story_v_out_319761", "319761056", "story_v_out_319761.awb") / 1000

					if var_254_28 + var_254_20 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_28 + var_254_20
					end

					if var_254_23.prefab_name ~= "" and arg_251_1.actors_[var_254_23.prefab_name] ~= nil then
						local var_254_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_251_1.actors_[var_254_23.prefab_name].transform, "story_v_out_319761", "319761056", "story_v_out_319761.awb")

						arg_251_1:RecordAudio("319761056", var_254_29)
						arg_251_1:RecordAudio("319761056", var_254_29)
					else
						arg_251_1:AudioAction("play", "voice", "story_v_out_319761", "319761056", "story_v_out_319761.awb")
					end

					arg_251_1:RecordHistoryTalkVoice("story_v_out_319761", "319761056", "story_v_out_319761.awb")
				end

				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_30 = math.max(var_254_21, arg_251_1.talkMaxDuration)

			if var_254_20 <= arg_251_1.time_ and arg_251_1.time_ < var_254_20 + var_254_30 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_20) / var_254_30

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_20 + var_254_30 and arg_251_1.time_ < var_254_20 + var_254_30 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
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
	Play319761057 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 319761057
		arg_255_1.duration_ = 3.5

		local var_255_0 = {
			zh = 1.533,
			ja = 3.5
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
				arg_255_0:Play319761058(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			local var_258_0 = arg_255_1.actors_["10066ui_story"]
			local var_258_1 = 0

			if var_258_1 < arg_255_1.time_ and arg_255_1.time_ <= var_258_1 + arg_258_0 and not isNil(var_258_0) and arg_255_1.var_.characterEffect10066ui_story == nil then
				arg_255_1.var_.characterEffect10066ui_story = var_258_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_258_2 = 0.200000002980232

			if var_258_1 <= arg_255_1.time_ and arg_255_1.time_ < var_258_1 + var_258_2 and not isNil(var_258_0) then
				local var_258_3 = (arg_255_1.time_ - var_258_1) / var_258_2

				if arg_255_1.var_.characterEffect10066ui_story and not isNil(var_258_0) then
					local var_258_4 = Mathf.Lerp(0, 0.5, var_258_3)

					arg_255_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_255_1.var_.characterEffect10066ui_story.fillRatio = var_258_4
				end
			end

			if arg_255_1.time_ >= var_258_1 + var_258_2 and arg_255_1.time_ < var_258_1 + var_258_2 + arg_258_0 and not isNil(var_258_0) and arg_255_1.var_.characterEffect10066ui_story then
				local var_258_5 = 0.5

				arg_255_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_255_1.var_.characterEffect10066ui_story.fillRatio = var_258_5
			end

			local var_258_6 = arg_255_1.actors_["1084ui_story"]
			local var_258_7 = 0

			if var_258_7 < arg_255_1.time_ and arg_255_1.time_ <= var_258_7 + arg_258_0 and not isNil(var_258_6) and arg_255_1.var_.characterEffect1084ui_story == nil then
				arg_255_1.var_.characterEffect1084ui_story = var_258_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_258_8 = 0.200000002980232

			if var_258_7 <= arg_255_1.time_ and arg_255_1.time_ < var_258_7 + var_258_8 and not isNil(var_258_6) then
				local var_258_9 = (arg_255_1.time_ - var_258_7) / var_258_8

				if arg_255_1.var_.characterEffect1084ui_story and not isNil(var_258_6) then
					arg_255_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_255_1.time_ >= var_258_7 + var_258_8 and arg_255_1.time_ < var_258_7 + var_258_8 + arg_258_0 and not isNil(var_258_6) and arg_255_1.var_.characterEffect1084ui_story then
				arg_255_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_258_10 = 0
			local var_258_11 = 0.15

			if var_258_10 < arg_255_1.time_ and arg_255_1.time_ <= var_258_10 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, true)

				local var_258_12 = arg_255_1:FormatText(StoryNameCfg[6].name)

				arg_255_1.leftNameTxt_.text = var_258_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_255_1.leftNameTxt_.transform)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1.leftNameTxt_.text)
				SetActive(arg_255_1.iconTrs_.gameObject, false)
				arg_255_1.callingController_:SetSelectedState("normal")

				local var_258_13 = arg_255_1:GetWordFromCfg(319761057)
				local var_258_14 = arg_255_1:FormatText(var_258_13.content)

				arg_255_1.text_.text = var_258_14

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_15 = 6
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

				if manager.audio:GetVoiceLength("story_v_out_319761", "319761057", "story_v_out_319761.awb") ~= 0 then
					local var_258_18 = manager.audio:GetVoiceLength("story_v_out_319761", "319761057", "story_v_out_319761.awb") / 1000

					if var_258_18 + var_258_10 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_18 + var_258_10
					end

					if var_258_13.prefab_name ~= "" and arg_255_1.actors_[var_258_13.prefab_name] ~= nil then
						local var_258_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_255_1.actors_[var_258_13.prefab_name].transform, "story_v_out_319761", "319761057", "story_v_out_319761.awb")

						arg_255_1:RecordAudio("319761057", var_258_19)
						arg_255_1:RecordAudio("319761057", var_258_19)
					else
						arg_255_1:AudioAction("play", "voice", "story_v_out_319761", "319761057", "story_v_out_319761.awb")
					end

					arg_255_1:RecordHistoryTalkVoice("story_v_out_319761", "319761057", "story_v_out_319761.awb")
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
	Play319761058 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 319761058
		arg_259_1.duration_ = 7.3

		local var_259_0 = {
			zh = 7.3,
			ja = 5.2
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
				arg_259_0:Play319761059(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			local var_262_0 = arg_259_1.actors_["10066ui_story"]
			local var_262_1 = 0

			if var_262_1 < arg_259_1.time_ and arg_259_1.time_ <= var_262_1 + arg_262_0 and not isNil(var_262_0) and arg_259_1.var_.characterEffect10066ui_story == nil then
				arg_259_1.var_.characterEffect10066ui_story = var_262_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_262_2 = 0.200000002980232

			if var_262_1 <= arg_259_1.time_ and arg_259_1.time_ < var_262_1 + var_262_2 and not isNil(var_262_0) then
				local var_262_3 = (arg_259_1.time_ - var_262_1) / var_262_2

				if arg_259_1.var_.characterEffect10066ui_story and not isNil(var_262_0) then
					arg_259_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_259_1.time_ >= var_262_1 + var_262_2 and arg_259_1.time_ < var_262_1 + var_262_2 + arg_262_0 and not isNil(var_262_0) and arg_259_1.var_.characterEffect10066ui_story then
				arg_259_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_262_4 = arg_259_1.actors_["1084ui_story"]
			local var_262_5 = 0

			if var_262_5 < arg_259_1.time_ and arg_259_1.time_ <= var_262_5 + arg_262_0 and not isNil(var_262_4) and arg_259_1.var_.characterEffect1084ui_story == nil then
				arg_259_1.var_.characterEffect1084ui_story = var_262_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_262_6 = 0.200000002980232

			if var_262_5 <= arg_259_1.time_ and arg_259_1.time_ < var_262_5 + var_262_6 and not isNil(var_262_4) then
				local var_262_7 = (arg_259_1.time_ - var_262_5) / var_262_6

				if arg_259_1.var_.characterEffect1084ui_story and not isNil(var_262_4) then
					local var_262_8 = Mathf.Lerp(0, 0.5, var_262_7)

					arg_259_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_259_1.var_.characterEffect1084ui_story.fillRatio = var_262_8
				end
			end

			if arg_259_1.time_ >= var_262_5 + var_262_6 and arg_259_1.time_ < var_262_5 + var_262_6 + arg_262_0 and not isNil(var_262_4) and arg_259_1.var_.characterEffect1084ui_story then
				local var_262_9 = 0.5

				arg_259_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_259_1.var_.characterEffect1084ui_story.fillRatio = var_262_9
			end

			local var_262_10 = 0
			local var_262_11 = 0.75

			if var_262_10 < arg_259_1.time_ and arg_259_1.time_ <= var_262_10 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, true)

				local var_262_12 = arg_259_1:FormatText(StoryNameCfg[640].name)

				arg_259_1.leftNameTxt_.text = var_262_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_259_1.leftNameTxt_.transform)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1.leftNameTxt_.text)
				SetActive(arg_259_1.iconTrs_.gameObject, false)
				arg_259_1.callingController_:SetSelectedState("normal")

				local var_262_13 = arg_259_1:GetWordFromCfg(319761058)
				local var_262_14 = arg_259_1:FormatText(var_262_13.content)

				arg_259_1.text_.text = var_262_14

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_15 = 30
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

				if manager.audio:GetVoiceLength("story_v_out_319761", "319761058", "story_v_out_319761.awb") ~= 0 then
					local var_262_18 = manager.audio:GetVoiceLength("story_v_out_319761", "319761058", "story_v_out_319761.awb") / 1000

					if var_262_18 + var_262_10 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_18 + var_262_10
					end

					if var_262_13.prefab_name ~= "" and arg_259_1.actors_[var_262_13.prefab_name] ~= nil then
						local var_262_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_259_1.actors_[var_262_13.prefab_name].transform, "story_v_out_319761", "319761058", "story_v_out_319761.awb")

						arg_259_1:RecordAudio("319761058", var_262_19)
						arg_259_1:RecordAudio("319761058", var_262_19)
					else
						arg_259_1:AudioAction("play", "voice", "story_v_out_319761", "319761058", "story_v_out_319761.awb")
					end

					arg_259_1:RecordHistoryTalkVoice("story_v_out_319761", "319761058", "story_v_out_319761.awb")
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

		arg_259_1.nodeConfigList_ = {}

		arg_259_1:InitPlayNodeList()
	end,
	Play319761059 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 319761059
		arg_263_1.duration_ = 3.67

		local var_263_0 = {
			zh = 2.3,
			ja = 3.666
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
				arg_263_0:Play319761060(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			local var_266_0 = 0

			if var_266_0 < arg_263_1.time_ and arg_263_1.time_ <= var_266_0 + arg_266_0 then
				arg_263_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_1")
			end

			local var_266_1 = 0

			if var_266_1 < arg_263_1.time_ and arg_263_1.time_ <= var_266_1 + arg_266_0 then
				arg_263_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_266_2 = arg_263_1.actors_["10066ui_story"]
			local var_266_3 = 0

			if var_266_3 < arg_263_1.time_ and arg_263_1.time_ <= var_266_3 + arg_266_0 and not isNil(var_266_2) and arg_263_1.var_.characterEffect10066ui_story == nil then
				arg_263_1.var_.characterEffect10066ui_story = var_266_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_266_4 = 0.200000002980232

			if var_266_3 <= arg_263_1.time_ and arg_263_1.time_ < var_266_3 + var_266_4 and not isNil(var_266_2) then
				local var_266_5 = (arg_263_1.time_ - var_266_3) / var_266_4

				if arg_263_1.var_.characterEffect10066ui_story and not isNil(var_266_2) then
					local var_266_6 = Mathf.Lerp(0, 0.5, var_266_5)

					arg_263_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_263_1.var_.characterEffect10066ui_story.fillRatio = var_266_6
				end
			end

			if arg_263_1.time_ >= var_266_3 + var_266_4 and arg_263_1.time_ < var_266_3 + var_266_4 + arg_266_0 and not isNil(var_266_2) and arg_263_1.var_.characterEffect10066ui_story then
				local var_266_7 = 0.5

				arg_263_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_263_1.var_.characterEffect10066ui_story.fillRatio = var_266_7
			end

			local var_266_8 = arg_263_1.actors_["1084ui_story"]
			local var_266_9 = 0

			if var_266_9 < arg_263_1.time_ and arg_263_1.time_ <= var_266_9 + arg_266_0 and not isNil(var_266_8) and arg_263_1.var_.characterEffect1084ui_story == nil then
				arg_263_1.var_.characterEffect1084ui_story = var_266_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_266_10 = 0.200000002980232

			if var_266_9 <= arg_263_1.time_ and arg_263_1.time_ < var_266_9 + var_266_10 and not isNil(var_266_8) then
				local var_266_11 = (arg_263_1.time_ - var_266_9) / var_266_10

				if arg_263_1.var_.characterEffect1084ui_story and not isNil(var_266_8) then
					arg_263_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_263_1.time_ >= var_266_9 + var_266_10 and arg_263_1.time_ < var_266_9 + var_266_10 + arg_266_0 and not isNil(var_266_8) and arg_263_1.var_.characterEffect1084ui_story then
				arg_263_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_266_12 = 0
			local var_266_13 = 0.175

			if var_266_12 < arg_263_1.time_ and arg_263_1.time_ <= var_266_12 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, true)

				local var_266_14 = arg_263_1:FormatText(StoryNameCfg[6].name)

				arg_263_1.leftNameTxt_.text = var_266_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_263_1.leftNameTxt_.transform)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1.leftNameTxt_.text)
				SetActive(arg_263_1.iconTrs_.gameObject, false)
				arg_263_1.callingController_:SetSelectedState("normal")

				local var_266_15 = arg_263_1:GetWordFromCfg(319761059)
				local var_266_16 = arg_263_1:FormatText(var_266_15.content)

				arg_263_1.text_.text = var_266_16

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_17 = 7
				local var_266_18 = utf8.len(var_266_16)
				local var_266_19 = var_266_17 <= 0 and var_266_13 or var_266_13 * (var_266_18 / var_266_17)

				if var_266_19 > 0 and var_266_13 < var_266_19 then
					arg_263_1.talkMaxDuration = var_266_19

					if var_266_19 + var_266_12 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_19 + var_266_12
					end
				end

				arg_263_1.text_.text = var_266_16
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319761", "319761059", "story_v_out_319761.awb") ~= 0 then
					local var_266_20 = manager.audio:GetVoiceLength("story_v_out_319761", "319761059", "story_v_out_319761.awb") / 1000

					if var_266_20 + var_266_12 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_20 + var_266_12
					end

					if var_266_15.prefab_name ~= "" and arg_263_1.actors_[var_266_15.prefab_name] ~= nil then
						local var_266_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_263_1.actors_[var_266_15.prefab_name].transform, "story_v_out_319761", "319761059", "story_v_out_319761.awb")

						arg_263_1:RecordAudio("319761059", var_266_21)
						arg_263_1:RecordAudio("319761059", var_266_21)
					else
						arg_263_1:AudioAction("play", "voice", "story_v_out_319761", "319761059", "story_v_out_319761.awb")
					end

					arg_263_1:RecordHistoryTalkVoice("story_v_out_319761", "319761059", "story_v_out_319761.awb")
				end

				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_22 = math.max(var_266_13, arg_263_1.talkMaxDuration)

			if var_266_12 <= arg_263_1.time_ and arg_263_1.time_ < var_266_12 + var_266_22 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - var_266_12) / var_266_22

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= var_266_12 + var_266_22 and arg_263_1.time_ < var_266_12 + var_266_22 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {}

		arg_263_1:InitPlayNodeList()
	end,
	Play319761060 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 319761060
		arg_267_1.duration_ = 7.3

		local var_267_0 = {
			zh = 6.933,
			ja = 7.3
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
				arg_267_0:Play319761061(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			local var_270_0 = 0
			local var_270_1 = 0.85

			if var_270_0 < arg_267_1.time_ and arg_267_1.time_ <= var_270_0 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, true)

				local var_270_2 = arg_267_1:FormatText(StoryNameCfg[6].name)

				arg_267_1.leftNameTxt_.text = var_270_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_267_1.leftNameTxt_.transform)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1.leftNameTxt_.text)
				SetActive(arg_267_1.iconTrs_.gameObject, false)
				arg_267_1.callingController_:SetSelectedState("normal")

				local var_270_3 = arg_267_1:GetWordFromCfg(319761060)
				local var_270_4 = arg_267_1:FormatText(var_270_3.content)

				arg_267_1.text_.text = var_270_4

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_5 = 34
				local var_270_6 = utf8.len(var_270_4)
				local var_270_7 = var_270_5 <= 0 and var_270_1 or var_270_1 * (var_270_6 / var_270_5)

				if var_270_7 > 0 and var_270_1 < var_270_7 then
					arg_267_1.talkMaxDuration = var_270_7

					if var_270_7 + var_270_0 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_7 + var_270_0
					end
				end

				arg_267_1.text_.text = var_270_4
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319761", "319761060", "story_v_out_319761.awb") ~= 0 then
					local var_270_8 = manager.audio:GetVoiceLength("story_v_out_319761", "319761060", "story_v_out_319761.awb") / 1000

					if var_270_8 + var_270_0 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_8 + var_270_0
					end

					if var_270_3.prefab_name ~= "" and arg_267_1.actors_[var_270_3.prefab_name] ~= nil then
						local var_270_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_267_1.actors_[var_270_3.prefab_name].transform, "story_v_out_319761", "319761060", "story_v_out_319761.awb")

						arg_267_1:RecordAudio("319761060", var_270_9)
						arg_267_1:RecordAudio("319761060", var_270_9)
					else
						arg_267_1:AudioAction("play", "voice", "story_v_out_319761", "319761060", "story_v_out_319761.awb")
					end

					arg_267_1:RecordHistoryTalkVoice("story_v_out_319761", "319761060", "story_v_out_319761.awb")
				end

				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_10 = math.max(var_270_1, arg_267_1.talkMaxDuration)

			if var_270_0 <= arg_267_1.time_ and arg_267_1.time_ < var_270_0 + var_270_10 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - var_270_0) / var_270_10

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= var_270_0 + var_270_10 and arg_267_1.time_ < var_270_0 + var_270_10 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {}

		arg_267_1:InitPlayNodeList()
	end,
	Play319761061 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 319761061
		arg_271_1.duration_ = 5.17

		local var_271_0 = {
			zh = 2.6,
			ja = 5.166
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
				arg_271_0:Play319761062(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			local var_274_0 = arg_271_1.actors_["1084ui_story"]
			local var_274_1 = 0

			if var_274_1 < arg_271_1.time_ and arg_271_1.time_ <= var_274_1 + arg_274_0 and not isNil(var_274_0) and arg_271_1.var_.characterEffect1084ui_story == nil then
				arg_271_1.var_.characterEffect1084ui_story = var_274_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_274_2 = 0.200000002980232

			if var_274_1 <= arg_271_1.time_ and arg_271_1.time_ < var_274_1 + var_274_2 and not isNil(var_274_0) then
				local var_274_3 = (arg_271_1.time_ - var_274_1) / var_274_2

				if arg_271_1.var_.characterEffect1084ui_story and not isNil(var_274_0) then
					local var_274_4 = Mathf.Lerp(0, 0.5, var_274_3)

					arg_271_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_271_1.var_.characterEffect1084ui_story.fillRatio = var_274_4
				end
			end

			if arg_271_1.time_ >= var_274_1 + var_274_2 and arg_271_1.time_ < var_274_1 + var_274_2 + arg_274_0 and not isNil(var_274_0) and arg_271_1.var_.characterEffect1084ui_story then
				local var_274_5 = 0.5

				arg_271_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_271_1.var_.characterEffect1084ui_story.fillRatio = var_274_5
			end

			local var_274_6 = arg_271_1.actors_["10066ui_story"]
			local var_274_7 = 0

			if var_274_7 < arg_271_1.time_ and arg_271_1.time_ <= var_274_7 + arg_274_0 and not isNil(var_274_6) and arg_271_1.var_.characterEffect10066ui_story == nil then
				arg_271_1.var_.characterEffect10066ui_story = var_274_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_274_8 = 0.200000002980232

			if var_274_7 <= arg_271_1.time_ and arg_271_1.time_ < var_274_7 + var_274_8 and not isNil(var_274_6) then
				local var_274_9 = (arg_271_1.time_ - var_274_7) / var_274_8

				if arg_271_1.var_.characterEffect10066ui_story and not isNil(var_274_6) then
					arg_271_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_271_1.time_ >= var_274_7 + var_274_8 and arg_271_1.time_ < var_274_7 + var_274_8 + arg_274_0 and not isNil(var_274_6) and arg_271_1.var_.characterEffect10066ui_story then
				arg_271_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_274_10 = 0

			if var_274_10 < arg_271_1.time_ and arg_271_1.time_ <= var_274_10 + arg_274_0 then
				arg_271_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action7_2")
			end

			local var_274_11 = 0

			if var_274_11 < arg_271_1.time_ and arg_271_1.time_ <= var_274_11 + arg_274_0 then
				arg_271_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_274_12 = 0
			local var_274_13 = 0.275

			if var_274_12 < arg_271_1.time_ and arg_271_1.time_ <= var_274_12 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, true)

				local var_274_14 = arg_271_1:FormatText(StoryNameCfg[640].name)

				arg_271_1.leftNameTxt_.text = var_274_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_271_1.leftNameTxt_.transform)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1.leftNameTxt_.text)
				SetActive(arg_271_1.iconTrs_.gameObject, false)
				arg_271_1.callingController_:SetSelectedState("normal")

				local var_274_15 = arg_271_1:GetWordFromCfg(319761061)
				local var_274_16 = arg_271_1:FormatText(var_274_15.content)

				arg_271_1.text_.text = var_274_16

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_17 = 11
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

				if manager.audio:GetVoiceLength("story_v_out_319761", "319761061", "story_v_out_319761.awb") ~= 0 then
					local var_274_20 = manager.audio:GetVoiceLength("story_v_out_319761", "319761061", "story_v_out_319761.awb") / 1000

					if var_274_20 + var_274_12 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_20 + var_274_12
					end

					if var_274_15.prefab_name ~= "" and arg_271_1.actors_[var_274_15.prefab_name] ~= nil then
						local var_274_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_271_1.actors_[var_274_15.prefab_name].transform, "story_v_out_319761", "319761061", "story_v_out_319761.awb")

						arg_271_1:RecordAudio("319761061", var_274_21)
						arg_271_1:RecordAudio("319761061", var_274_21)
					else
						arg_271_1:AudioAction("play", "voice", "story_v_out_319761", "319761061", "story_v_out_319761.awb")
					end

					arg_271_1:RecordHistoryTalkVoice("story_v_out_319761", "319761061", "story_v_out_319761.awb")
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
	Play319761062 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 319761062
		arg_275_1.duration_ = 6.9

		local var_275_0 = {
			zh = 4.366,
			ja = 6.9
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
				arg_275_0:Play319761063(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			local var_278_0 = arg_275_1.actors_["10066ui_story"]
			local var_278_1 = 0

			if var_278_1 < arg_275_1.time_ and arg_275_1.time_ <= var_278_1 + arg_278_0 and not isNil(var_278_0) and arg_275_1.var_.characterEffect10066ui_story == nil then
				arg_275_1.var_.characterEffect10066ui_story = var_278_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_278_2 = 0.200000002980232

			if var_278_1 <= arg_275_1.time_ and arg_275_1.time_ < var_278_1 + var_278_2 and not isNil(var_278_0) then
				local var_278_3 = (arg_275_1.time_ - var_278_1) / var_278_2

				if arg_275_1.var_.characterEffect10066ui_story and not isNil(var_278_0) then
					local var_278_4 = Mathf.Lerp(0, 0.5, var_278_3)

					arg_275_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_275_1.var_.characterEffect10066ui_story.fillRatio = var_278_4
				end
			end

			if arg_275_1.time_ >= var_278_1 + var_278_2 and arg_275_1.time_ < var_278_1 + var_278_2 + arg_278_0 and not isNil(var_278_0) and arg_275_1.var_.characterEffect10066ui_story then
				local var_278_5 = 0.5

				arg_275_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_275_1.var_.characterEffect10066ui_story.fillRatio = var_278_5
			end

			local var_278_6 = arg_275_1.actors_["1084ui_story"]
			local var_278_7 = 0

			if var_278_7 < arg_275_1.time_ and arg_275_1.time_ <= var_278_7 + arg_278_0 and not isNil(var_278_6) and arg_275_1.var_.characterEffect1084ui_story == nil then
				arg_275_1.var_.characterEffect1084ui_story = var_278_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_278_8 = 0.200000002980232

			if var_278_7 <= arg_275_1.time_ and arg_275_1.time_ < var_278_7 + var_278_8 and not isNil(var_278_6) then
				local var_278_9 = (arg_275_1.time_ - var_278_7) / var_278_8

				if arg_275_1.var_.characterEffect1084ui_story and not isNil(var_278_6) then
					arg_275_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_275_1.time_ >= var_278_7 + var_278_8 and arg_275_1.time_ < var_278_7 + var_278_8 + arg_278_0 and not isNil(var_278_6) and arg_275_1.var_.characterEffect1084ui_story then
				arg_275_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_278_10 = 0
			local var_278_11 = 0.55

			if var_278_10 < arg_275_1.time_ and arg_275_1.time_ <= var_278_10 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, true)

				local var_278_12 = arg_275_1:FormatText(StoryNameCfg[6].name)

				arg_275_1.leftNameTxt_.text = var_278_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_275_1.leftNameTxt_.transform)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1.leftNameTxt_.text)
				SetActive(arg_275_1.iconTrs_.gameObject, false)
				arg_275_1.callingController_:SetSelectedState("normal")

				local var_278_13 = arg_275_1:GetWordFromCfg(319761062)
				local var_278_14 = arg_275_1:FormatText(var_278_13.content)

				arg_275_1.text_.text = var_278_14

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_15 = 22
				local var_278_16 = utf8.len(var_278_14)
				local var_278_17 = var_278_15 <= 0 and var_278_11 or var_278_11 * (var_278_16 / var_278_15)

				if var_278_17 > 0 and var_278_11 < var_278_17 then
					arg_275_1.talkMaxDuration = var_278_17

					if var_278_17 + var_278_10 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_17 + var_278_10
					end
				end

				arg_275_1.text_.text = var_278_14
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319761", "319761062", "story_v_out_319761.awb") ~= 0 then
					local var_278_18 = manager.audio:GetVoiceLength("story_v_out_319761", "319761062", "story_v_out_319761.awb") / 1000

					if var_278_18 + var_278_10 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_18 + var_278_10
					end

					if var_278_13.prefab_name ~= "" and arg_275_1.actors_[var_278_13.prefab_name] ~= nil then
						local var_278_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_275_1.actors_[var_278_13.prefab_name].transform, "story_v_out_319761", "319761062", "story_v_out_319761.awb")

						arg_275_1:RecordAudio("319761062", var_278_19)
						arg_275_1:RecordAudio("319761062", var_278_19)
					else
						arg_275_1:AudioAction("play", "voice", "story_v_out_319761", "319761062", "story_v_out_319761.awb")
					end

					arg_275_1:RecordHistoryTalkVoice("story_v_out_319761", "319761062", "story_v_out_319761.awb")
				end

				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_20 = math.max(var_278_11, arg_275_1.talkMaxDuration)

			if var_278_10 <= arg_275_1.time_ and arg_275_1.time_ < var_278_10 + var_278_20 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - var_278_10) / var_278_20

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= var_278_10 + var_278_20 and arg_275_1.time_ < var_278_10 + var_278_20 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {}

		arg_275_1:InitPlayNodeList()
	end,
	Play319761063 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 319761063
		arg_279_1.duration_ = 4.9

		local var_279_0 = {
			zh = 3.333,
			ja = 4.9
		}
		local var_279_1 = manager.audio:GetLocalizationFlag()

		if var_279_0[var_279_1] ~= nil then
			arg_279_1.duration_ = var_279_0[var_279_1]
		end

		SetActive(arg_279_1.tipsGo_, false)

		function arg_279_1.onSingleLineFinish_()
			arg_279_1.onSingleLineUpdate_ = nil
			arg_279_1.onSingleLineFinish_ = nil
			arg_279_1.state_ = "waiting"
		end

		function arg_279_1.playNext_(arg_281_0)
			if arg_281_0 == 1 then
				arg_279_0:Play319761064(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			local var_282_0 = arg_279_1.actors_["10066ui_story"]
			local var_282_1 = 0

			if var_282_1 < arg_279_1.time_ and arg_279_1.time_ <= var_282_1 + arg_282_0 and not isNil(var_282_0) and arg_279_1.var_.characterEffect10066ui_story == nil then
				arg_279_1.var_.characterEffect10066ui_story = var_282_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_282_2 = 0.200000002980232

			if var_282_1 <= arg_279_1.time_ and arg_279_1.time_ < var_282_1 + var_282_2 and not isNil(var_282_0) then
				local var_282_3 = (arg_279_1.time_ - var_282_1) / var_282_2

				if arg_279_1.var_.characterEffect10066ui_story and not isNil(var_282_0) then
					arg_279_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_279_1.time_ >= var_282_1 + var_282_2 and arg_279_1.time_ < var_282_1 + var_282_2 + arg_282_0 and not isNil(var_282_0) and arg_279_1.var_.characterEffect10066ui_story then
				arg_279_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_282_4 = arg_279_1.actors_["1084ui_story"]
			local var_282_5 = 0

			if var_282_5 < arg_279_1.time_ and arg_279_1.time_ <= var_282_5 + arg_282_0 and not isNil(var_282_4) and arg_279_1.var_.characterEffect1084ui_story == nil then
				arg_279_1.var_.characterEffect1084ui_story = var_282_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_282_6 = 0.200000002980232

			if var_282_5 <= arg_279_1.time_ and arg_279_1.time_ < var_282_5 + var_282_6 and not isNil(var_282_4) then
				local var_282_7 = (arg_279_1.time_ - var_282_5) / var_282_6

				if arg_279_1.var_.characterEffect1084ui_story and not isNil(var_282_4) then
					local var_282_8 = Mathf.Lerp(0, 0.5, var_282_7)

					arg_279_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_279_1.var_.characterEffect1084ui_story.fillRatio = var_282_8
				end
			end

			if arg_279_1.time_ >= var_282_5 + var_282_6 and arg_279_1.time_ < var_282_5 + var_282_6 + arg_282_0 and not isNil(var_282_4) and arg_279_1.var_.characterEffect1084ui_story then
				local var_282_9 = 0.5

				arg_279_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_279_1.var_.characterEffect1084ui_story.fillRatio = var_282_9
			end

			local var_282_10 = 0
			local var_282_11 = 0.3

			if var_282_10 < arg_279_1.time_ and arg_279_1.time_ <= var_282_10 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, true)

				local var_282_12 = arg_279_1:FormatText(StoryNameCfg[640].name)

				arg_279_1.leftNameTxt_.text = var_282_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_279_1.leftNameTxt_.transform)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1.leftNameTxt_.text)
				SetActive(arg_279_1.iconTrs_.gameObject, false)
				arg_279_1.callingController_:SetSelectedState("normal")

				local var_282_13 = arg_279_1:GetWordFromCfg(319761063)
				local var_282_14 = arg_279_1:FormatText(var_282_13.content)

				arg_279_1.text_.text = var_282_14

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_15 = 12
				local var_282_16 = utf8.len(var_282_14)
				local var_282_17 = var_282_15 <= 0 and var_282_11 or var_282_11 * (var_282_16 / var_282_15)

				if var_282_17 > 0 and var_282_11 < var_282_17 then
					arg_279_1.talkMaxDuration = var_282_17

					if var_282_17 + var_282_10 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_17 + var_282_10
					end
				end

				arg_279_1.text_.text = var_282_14
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319761", "319761063", "story_v_out_319761.awb") ~= 0 then
					local var_282_18 = manager.audio:GetVoiceLength("story_v_out_319761", "319761063", "story_v_out_319761.awb") / 1000

					if var_282_18 + var_282_10 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_18 + var_282_10
					end

					if var_282_13.prefab_name ~= "" and arg_279_1.actors_[var_282_13.prefab_name] ~= nil then
						local var_282_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_279_1.actors_[var_282_13.prefab_name].transform, "story_v_out_319761", "319761063", "story_v_out_319761.awb")

						arg_279_1:RecordAudio("319761063", var_282_19)
						arg_279_1:RecordAudio("319761063", var_282_19)
					else
						arg_279_1:AudioAction("play", "voice", "story_v_out_319761", "319761063", "story_v_out_319761.awb")
					end

					arg_279_1:RecordHistoryTalkVoice("story_v_out_319761", "319761063", "story_v_out_319761.awb")
				end

				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_20 = math.max(var_282_11, arg_279_1.talkMaxDuration)

			if var_282_10 <= arg_279_1.time_ and arg_279_1.time_ < var_282_10 + var_282_20 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - var_282_10) / var_282_20

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= var_282_10 + var_282_20 and arg_279_1.time_ < var_282_10 + var_282_20 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {}

		arg_279_1:InitPlayNodeList()
	end,
	Play319761064 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 319761064
		arg_283_1.duration_ = 9.43

		local var_283_0 = {
			zh = 9.433,
			ja = 5.666
		}
		local var_283_1 = manager.audio:GetLocalizationFlag()

		if var_283_0[var_283_1] ~= nil then
			arg_283_1.duration_ = var_283_0[var_283_1]
		end

		SetActive(arg_283_1.tipsGo_, false)

		function arg_283_1.onSingleLineFinish_()
			arg_283_1.onSingleLineUpdate_ = nil
			arg_283_1.onSingleLineFinish_ = nil
			arg_283_1.state_ = "waiting"
		end

		function arg_283_1.playNext_(arg_285_0)
			if arg_285_0 == 1 then
				arg_283_0:Play319761065(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			local var_286_0 = 0

			if var_286_0 < arg_283_1.time_ and arg_283_1.time_ <= var_286_0 + arg_286_0 then
				arg_283_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action6_1")
			end

			local var_286_1 = 0
			local var_286_2 = 0.95

			if var_286_1 < arg_283_1.time_ and arg_283_1.time_ <= var_286_1 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, true)

				local var_286_3 = arg_283_1:FormatText(StoryNameCfg[640].name)

				arg_283_1.leftNameTxt_.text = var_286_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_283_1.leftNameTxt_.transform)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1.leftNameTxt_.text)
				SetActive(arg_283_1.iconTrs_.gameObject, false)
				arg_283_1.callingController_:SetSelectedState("normal")

				local var_286_4 = arg_283_1:GetWordFromCfg(319761064)
				local var_286_5 = arg_283_1:FormatText(var_286_4.content)

				arg_283_1.text_.text = var_286_5

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_6 = 38
				local var_286_7 = utf8.len(var_286_5)
				local var_286_8 = var_286_6 <= 0 and var_286_2 or var_286_2 * (var_286_7 / var_286_6)

				if var_286_8 > 0 and var_286_2 < var_286_8 then
					arg_283_1.talkMaxDuration = var_286_8

					if var_286_8 + var_286_1 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_8 + var_286_1
					end
				end

				arg_283_1.text_.text = var_286_5
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319761", "319761064", "story_v_out_319761.awb") ~= 0 then
					local var_286_9 = manager.audio:GetVoiceLength("story_v_out_319761", "319761064", "story_v_out_319761.awb") / 1000

					if var_286_9 + var_286_1 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_9 + var_286_1
					end

					if var_286_4.prefab_name ~= "" and arg_283_1.actors_[var_286_4.prefab_name] ~= nil then
						local var_286_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_283_1.actors_[var_286_4.prefab_name].transform, "story_v_out_319761", "319761064", "story_v_out_319761.awb")

						arg_283_1:RecordAudio("319761064", var_286_10)
						arg_283_1:RecordAudio("319761064", var_286_10)
					else
						arg_283_1:AudioAction("play", "voice", "story_v_out_319761", "319761064", "story_v_out_319761.awb")
					end

					arg_283_1:RecordHistoryTalkVoice("story_v_out_319761", "319761064", "story_v_out_319761.awb")
				end

				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_11 = math.max(var_286_2, arg_283_1.talkMaxDuration)

			if var_286_1 <= arg_283_1.time_ and arg_283_1.time_ < var_286_1 + var_286_11 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - var_286_1) / var_286_11

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= var_286_1 + var_286_11 and arg_283_1.time_ < var_286_1 + var_286_11 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {}

		arg_283_1:InitPlayNodeList()
	end,
	Play319761065 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 319761065
		arg_287_1.duration_ = 6.03

		local var_287_0 = {
			zh = 3.833,
			ja = 6.033
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
				arg_287_0:Play319761066(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			local var_290_0 = 0

			if var_290_0 < arg_287_1.time_ and arg_287_1.time_ <= var_290_0 + arg_290_0 then
				arg_287_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action6_2")
			end

			local var_290_1 = 0
			local var_290_2 = 0.425

			if var_290_1 < arg_287_1.time_ and arg_287_1.time_ <= var_290_1 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, true)

				local var_290_3 = arg_287_1:FormatText(StoryNameCfg[640].name)

				arg_287_1.leftNameTxt_.text = var_290_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_287_1.leftNameTxt_.transform)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1.leftNameTxt_.text)
				SetActive(arg_287_1.iconTrs_.gameObject, false)
				arg_287_1.callingController_:SetSelectedState("normal")

				local var_290_4 = arg_287_1:GetWordFromCfg(319761065)
				local var_290_5 = arg_287_1:FormatText(var_290_4.content)

				arg_287_1.text_.text = var_290_5

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_6 = 17
				local var_290_7 = utf8.len(var_290_5)
				local var_290_8 = var_290_6 <= 0 and var_290_2 or var_290_2 * (var_290_7 / var_290_6)

				if var_290_8 > 0 and var_290_2 < var_290_8 then
					arg_287_1.talkMaxDuration = var_290_8

					if var_290_8 + var_290_1 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_8 + var_290_1
					end
				end

				arg_287_1.text_.text = var_290_5
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319761", "319761065", "story_v_out_319761.awb") ~= 0 then
					local var_290_9 = manager.audio:GetVoiceLength("story_v_out_319761", "319761065", "story_v_out_319761.awb") / 1000

					if var_290_9 + var_290_1 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_9 + var_290_1
					end

					if var_290_4.prefab_name ~= "" and arg_287_1.actors_[var_290_4.prefab_name] ~= nil then
						local var_290_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_287_1.actors_[var_290_4.prefab_name].transform, "story_v_out_319761", "319761065", "story_v_out_319761.awb")

						arg_287_1:RecordAudio("319761065", var_290_10)
						arg_287_1:RecordAudio("319761065", var_290_10)
					else
						arg_287_1:AudioAction("play", "voice", "story_v_out_319761", "319761065", "story_v_out_319761.awb")
					end

					arg_287_1:RecordHistoryTalkVoice("story_v_out_319761", "319761065", "story_v_out_319761.awb")
				end

				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_11 = math.max(var_290_2, arg_287_1.talkMaxDuration)

			if var_290_1 <= arg_287_1.time_ and arg_287_1.time_ < var_290_1 + var_290_11 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - var_290_1) / var_290_11

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= var_290_1 + var_290_11 and arg_287_1.time_ < var_290_1 + var_290_11 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {}

		arg_287_1:InitPlayNodeList()
	end,
	Play319761066 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 319761066
		arg_291_1.duration_ = 2.6

		local var_291_0 = {
			zh = 1.999999999999,
			ja = 2.6
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
				arg_291_0:Play319761067(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			local var_294_0 = 0

			if var_294_0 < arg_291_1.time_ and arg_291_1.time_ <= var_294_0 + arg_294_0 then
				arg_291_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_2")
			end

			local var_294_1 = 0

			if var_294_1 < arg_291_1.time_ and arg_291_1.time_ <= var_294_1 + arg_294_0 then
				arg_291_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_294_2 = arg_291_1.actors_["10066ui_story"]
			local var_294_3 = 0

			if var_294_3 < arg_291_1.time_ and arg_291_1.time_ <= var_294_3 + arg_294_0 and not isNil(var_294_2) and arg_291_1.var_.characterEffect10066ui_story == nil then
				arg_291_1.var_.characterEffect10066ui_story = var_294_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_294_4 = 0.200000002980232

			if var_294_3 <= arg_291_1.time_ and arg_291_1.time_ < var_294_3 + var_294_4 and not isNil(var_294_2) then
				local var_294_5 = (arg_291_1.time_ - var_294_3) / var_294_4

				if arg_291_1.var_.characterEffect10066ui_story and not isNil(var_294_2) then
					local var_294_6 = Mathf.Lerp(0, 0.5, var_294_5)

					arg_291_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_291_1.var_.characterEffect10066ui_story.fillRatio = var_294_6
				end
			end

			if arg_291_1.time_ >= var_294_3 + var_294_4 and arg_291_1.time_ < var_294_3 + var_294_4 + arg_294_0 and not isNil(var_294_2) and arg_291_1.var_.characterEffect10066ui_story then
				local var_294_7 = 0.5

				arg_291_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_291_1.var_.characterEffect10066ui_story.fillRatio = var_294_7
			end

			local var_294_8 = arg_291_1.actors_["1084ui_story"]
			local var_294_9 = 0

			if var_294_9 < arg_291_1.time_ and arg_291_1.time_ <= var_294_9 + arg_294_0 and not isNil(var_294_8) and arg_291_1.var_.characterEffect1084ui_story == nil then
				arg_291_1.var_.characterEffect1084ui_story = var_294_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_294_10 = 0.200000002980232

			if var_294_9 <= arg_291_1.time_ and arg_291_1.time_ < var_294_9 + var_294_10 and not isNil(var_294_8) then
				local var_294_11 = (arg_291_1.time_ - var_294_9) / var_294_10

				if arg_291_1.var_.characterEffect1084ui_story and not isNil(var_294_8) then
					arg_291_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_291_1.time_ >= var_294_9 + var_294_10 and arg_291_1.time_ < var_294_9 + var_294_10 + arg_294_0 and not isNil(var_294_8) and arg_291_1.var_.characterEffect1084ui_story then
				arg_291_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_294_12 = 0
			local var_294_13 = 0.2

			if var_294_12 < arg_291_1.time_ and arg_291_1.time_ <= var_294_12 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0
				arg_291_1.dialogCg_.alpha = 1

				arg_291_1.dialog_:SetActive(true)
				SetActive(arg_291_1.leftNameGo_, true)

				local var_294_14 = arg_291_1:FormatText(StoryNameCfg[6].name)

				arg_291_1.leftNameTxt_.text = var_294_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_291_1.leftNameTxt_.transform)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1.leftNameTxt_.text)
				SetActive(arg_291_1.iconTrs_.gameObject, false)
				arg_291_1.callingController_:SetSelectedState("normal")

				local var_294_15 = arg_291_1:GetWordFromCfg(319761066)
				local var_294_16 = arg_291_1:FormatText(var_294_15.content)

				arg_291_1.text_.text = var_294_16

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_17 = 8
				local var_294_18 = utf8.len(var_294_16)
				local var_294_19 = var_294_17 <= 0 and var_294_13 or var_294_13 * (var_294_18 / var_294_17)

				if var_294_19 > 0 and var_294_13 < var_294_19 then
					arg_291_1.talkMaxDuration = var_294_19

					if var_294_19 + var_294_12 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_19 + var_294_12
					end
				end

				arg_291_1.text_.text = var_294_16
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319761", "319761066", "story_v_out_319761.awb") ~= 0 then
					local var_294_20 = manager.audio:GetVoiceLength("story_v_out_319761", "319761066", "story_v_out_319761.awb") / 1000

					if var_294_20 + var_294_12 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_20 + var_294_12
					end

					if var_294_15.prefab_name ~= "" and arg_291_1.actors_[var_294_15.prefab_name] ~= nil then
						local var_294_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_291_1.actors_[var_294_15.prefab_name].transform, "story_v_out_319761", "319761066", "story_v_out_319761.awb")

						arg_291_1:RecordAudio("319761066", var_294_21)
						arg_291_1:RecordAudio("319761066", var_294_21)
					else
						arg_291_1:AudioAction("play", "voice", "story_v_out_319761", "319761066", "story_v_out_319761.awb")
					end

					arg_291_1:RecordHistoryTalkVoice("story_v_out_319761", "319761066", "story_v_out_319761.awb")
				end

				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_22 = math.max(var_294_13, arg_291_1.talkMaxDuration)

			if var_294_12 <= arg_291_1.time_ and arg_291_1.time_ < var_294_12 + var_294_22 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - var_294_12) / var_294_22

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= var_294_12 + var_294_22 and arg_291_1.time_ < var_294_12 + var_294_22 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end

		arg_291_1.nodeConfigList_ = {}

		arg_291_1:InitPlayNodeList()
	end,
	Play319761067 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 319761067
		arg_295_1.duration_ = 9.53

		local var_295_0 = {
			zh = 8.366,
			ja = 9.533
		}
		local var_295_1 = manager.audio:GetLocalizationFlag()

		if var_295_0[var_295_1] ~= nil then
			arg_295_1.duration_ = var_295_0[var_295_1]
		end

		SetActive(arg_295_1.tipsGo_, false)

		function arg_295_1.onSingleLineFinish_()
			arg_295_1.onSingleLineUpdate_ = nil
			arg_295_1.onSingleLineFinish_ = nil
			arg_295_1.state_ = "waiting"
		end

		function arg_295_1.playNext_(arg_297_0)
			if arg_297_0 == 1 then
				arg_295_0:Play319761068(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			local var_298_0 = arg_295_1.actors_["10066ui_story"].transform
			local var_298_1 = 0

			if var_298_1 < arg_295_1.time_ and arg_295_1.time_ <= var_298_1 + arg_298_0 then
				arg_295_1.var_.moveOldPos10066ui_story = var_298_0.localPosition
			end

			local var_298_2 = 0.001

			if var_298_1 <= arg_295_1.time_ and arg_295_1.time_ < var_298_1 + var_298_2 then
				local var_298_3 = (arg_295_1.time_ - var_298_1) / var_298_2
				local var_298_4 = Vector3.New(0.7, -0.99, -5.83)

				var_298_0.localPosition = Vector3.Lerp(arg_295_1.var_.moveOldPos10066ui_story, var_298_4, var_298_3)

				local var_298_5 = manager.ui.mainCamera.transform.position - var_298_0.position

				var_298_0.forward = Vector3.New(var_298_5.x, var_298_5.y, var_298_5.z)

				local var_298_6 = var_298_0.localEulerAngles

				var_298_6.z = 0
				var_298_6.x = 0
				var_298_0.localEulerAngles = var_298_6
			end

			if arg_295_1.time_ >= var_298_1 + var_298_2 and arg_295_1.time_ < var_298_1 + var_298_2 + arg_298_0 then
				var_298_0.localPosition = Vector3.New(0.7, -0.99, -5.83)

				local var_298_7 = manager.ui.mainCamera.transform.position - var_298_0.position

				var_298_0.forward = Vector3.New(var_298_7.x, var_298_7.y, var_298_7.z)

				local var_298_8 = var_298_0.localEulerAngles

				var_298_8.z = 0
				var_298_8.x = 0
				var_298_0.localEulerAngles = var_298_8
			end

			local var_298_9 = arg_295_1.actors_["10066ui_story"]
			local var_298_10 = 0

			if var_298_10 < arg_295_1.time_ and arg_295_1.time_ <= var_298_10 + arg_298_0 and not isNil(var_298_9) and arg_295_1.var_.characterEffect10066ui_story == nil then
				arg_295_1.var_.characterEffect10066ui_story = var_298_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_298_11 = 0.200000002980232

			if var_298_10 <= arg_295_1.time_ and arg_295_1.time_ < var_298_10 + var_298_11 and not isNil(var_298_9) then
				local var_298_12 = (arg_295_1.time_ - var_298_10) / var_298_11

				if arg_295_1.var_.characterEffect10066ui_story and not isNil(var_298_9) then
					arg_295_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_295_1.time_ >= var_298_10 + var_298_11 and arg_295_1.time_ < var_298_10 + var_298_11 + arg_298_0 and not isNil(var_298_9) and arg_295_1.var_.characterEffect10066ui_story then
				arg_295_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_298_13 = 0

			if var_298_13 < arg_295_1.time_ and arg_295_1.time_ <= var_298_13 + arg_298_0 then
				arg_295_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action2_1")
			end

			local var_298_14 = 0

			if var_298_14 < arg_295_1.time_ and arg_295_1.time_ <= var_298_14 + arg_298_0 then
				arg_295_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_298_15 = arg_295_1.actors_["1084ui_story"]
			local var_298_16 = 0

			if var_298_16 < arg_295_1.time_ and arg_295_1.time_ <= var_298_16 + arg_298_0 and not isNil(var_298_15) and arg_295_1.var_.characterEffect1084ui_story == nil then
				arg_295_1.var_.characterEffect1084ui_story = var_298_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_298_17 = 0.200000002980232

			if var_298_16 <= arg_295_1.time_ and arg_295_1.time_ < var_298_16 + var_298_17 and not isNil(var_298_15) then
				local var_298_18 = (arg_295_1.time_ - var_298_16) / var_298_17

				if arg_295_1.var_.characterEffect1084ui_story and not isNil(var_298_15) then
					local var_298_19 = Mathf.Lerp(0, 0.5, var_298_18)

					arg_295_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_295_1.var_.characterEffect1084ui_story.fillRatio = var_298_19
				end
			end

			if arg_295_1.time_ >= var_298_16 + var_298_17 and arg_295_1.time_ < var_298_16 + var_298_17 + arg_298_0 and not isNil(var_298_15) and arg_295_1.var_.characterEffect1084ui_story then
				local var_298_20 = 0.5

				arg_295_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_295_1.var_.characterEffect1084ui_story.fillRatio = var_298_20
			end

			local var_298_21 = 0
			local var_298_22 = 0.8

			if var_298_21 < arg_295_1.time_ and arg_295_1.time_ <= var_298_21 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, true)

				local var_298_23 = arg_295_1:FormatText(StoryNameCfg[640].name)

				arg_295_1.leftNameTxt_.text = var_298_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_295_1.leftNameTxt_.transform)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1.leftNameTxt_.text)
				SetActive(arg_295_1.iconTrs_.gameObject, false)
				arg_295_1.callingController_:SetSelectedState("normal")

				local var_298_24 = arg_295_1:GetWordFromCfg(319761067)
				local var_298_25 = arg_295_1:FormatText(var_298_24.content)

				arg_295_1.text_.text = var_298_25

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_26 = 32
				local var_298_27 = utf8.len(var_298_25)
				local var_298_28 = var_298_26 <= 0 and var_298_22 or var_298_22 * (var_298_27 / var_298_26)

				if var_298_28 > 0 and var_298_22 < var_298_28 then
					arg_295_1.talkMaxDuration = var_298_28

					if var_298_28 + var_298_21 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_28 + var_298_21
					end
				end

				arg_295_1.text_.text = var_298_25
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319761", "319761067", "story_v_out_319761.awb") ~= 0 then
					local var_298_29 = manager.audio:GetVoiceLength("story_v_out_319761", "319761067", "story_v_out_319761.awb") / 1000

					if var_298_29 + var_298_21 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_29 + var_298_21
					end

					if var_298_24.prefab_name ~= "" and arg_295_1.actors_[var_298_24.prefab_name] ~= nil then
						local var_298_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_295_1.actors_[var_298_24.prefab_name].transform, "story_v_out_319761", "319761067", "story_v_out_319761.awb")

						arg_295_1:RecordAudio("319761067", var_298_30)
						arg_295_1:RecordAudio("319761067", var_298_30)
					else
						arg_295_1:AudioAction("play", "voice", "story_v_out_319761", "319761067", "story_v_out_319761.awb")
					end

					arg_295_1:RecordHistoryTalkVoice("story_v_out_319761", "319761067", "story_v_out_319761.awb")
				end

				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_31 = math.max(var_298_22, arg_295_1.talkMaxDuration)

			if var_298_21 <= arg_295_1.time_ and arg_295_1.time_ < var_298_21 + var_298_31 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - var_298_21) / var_298_31

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= var_298_21 + var_298_31 and arg_295_1.time_ < var_298_21 + var_298_31 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
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
	Play319761068 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 319761068
		arg_299_1.duration_ = 6.63

		local var_299_0 = {
			zh = 4.8,
			ja = 6.633
		}
		local var_299_1 = manager.audio:GetLocalizationFlag()

		if var_299_0[var_299_1] ~= nil then
			arg_299_1.duration_ = var_299_0[var_299_1]
		end

		SetActive(arg_299_1.tipsGo_, false)

		function arg_299_1.onSingleLineFinish_()
			arg_299_1.onSingleLineUpdate_ = nil
			arg_299_1.onSingleLineFinish_ = nil
			arg_299_1.state_ = "waiting"
		end

		function arg_299_1.playNext_(arg_301_0)
			if arg_301_0 == 1 then
				arg_299_0:Play319761069(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			local var_302_0 = arg_299_1.actors_["1084ui_story"].transform
			local var_302_1 = 0

			if var_302_1 < arg_299_1.time_ and arg_299_1.time_ <= var_302_1 + arg_302_0 then
				arg_299_1.var_.moveOldPos1084ui_story = var_302_0.localPosition
			end

			local var_302_2 = 0.001

			if var_302_1 <= arg_299_1.time_ and arg_299_1.time_ < var_302_1 + var_302_2 then
				local var_302_3 = (arg_299_1.time_ - var_302_1) / var_302_2
				local var_302_4 = Vector3.New(-0.7, -0.97, -6)

				var_302_0.localPosition = Vector3.Lerp(arg_299_1.var_.moveOldPos1084ui_story, var_302_4, var_302_3)

				local var_302_5 = manager.ui.mainCamera.transform.position - var_302_0.position

				var_302_0.forward = Vector3.New(var_302_5.x, var_302_5.y, var_302_5.z)

				local var_302_6 = var_302_0.localEulerAngles

				var_302_6.z = 0
				var_302_6.x = 0
				var_302_0.localEulerAngles = var_302_6
			end

			if arg_299_1.time_ >= var_302_1 + var_302_2 and arg_299_1.time_ < var_302_1 + var_302_2 + arg_302_0 then
				var_302_0.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_302_7 = manager.ui.mainCamera.transform.position - var_302_0.position

				var_302_0.forward = Vector3.New(var_302_7.x, var_302_7.y, var_302_7.z)

				local var_302_8 = var_302_0.localEulerAngles

				var_302_8.z = 0
				var_302_8.x = 0
				var_302_0.localEulerAngles = var_302_8
			end

			local var_302_9 = arg_299_1.actors_["1084ui_story"]
			local var_302_10 = 0

			if var_302_10 < arg_299_1.time_ and arg_299_1.time_ <= var_302_10 + arg_302_0 and not isNil(var_302_9) and arg_299_1.var_.characterEffect1084ui_story == nil then
				arg_299_1.var_.characterEffect1084ui_story = var_302_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_302_11 = 0.200000002980232

			if var_302_10 <= arg_299_1.time_ and arg_299_1.time_ < var_302_10 + var_302_11 and not isNil(var_302_9) then
				local var_302_12 = (arg_299_1.time_ - var_302_10) / var_302_11

				if arg_299_1.var_.characterEffect1084ui_story and not isNil(var_302_9) then
					arg_299_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_299_1.time_ >= var_302_10 + var_302_11 and arg_299_1.time_ < var_302_10 + var_302_11 + arg_302_0 and not isNil(var_302_9) and arg_299_1.var_.characterEffect1084ui_story then
				arg_299_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_302_13 = 0

			if var_302_13 < arg_299_1.time_ and arg_299_1.time_ <= var_302_13 + arg_302_0 then
				arg_299_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action6_1")
			end

			local var_302_14 = 0

			if var_302_14 < arg_299_1.time_ and arg_299_1.time_ <= var_302_14 + arg_302_0 then
				arg_299_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_302_15 = arg_299_1.actors_["10066ui_story"]
			local var_302_16 = 0

			if var_302_16 < arg_299_1.time_ and arg_299_1.time_ <= var_302_16 + arg_302_0 and not isNil(var_302_15) and arg_299_1.var_.characterEffect10066ui_story == nil then
				arg_299_1.var_.characterEffect10066ui_story = var_302_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_302_17 = 0.200000002980232

			if var_302_16 <= arg_299_1.time_ and arg_299_1.time_ < var_302_16 + var_302_17 and not isNil(var_302_15) then
				local var_302_18 = (arg_299_1.time_ - var_302_16) / var_302_17

				if arg_299_1.var_.characterEffect10066ui_story and not isNil(var_302_15) then
					local var_302_19 = Mathf.Lerp(0, 0.5, var_302_18)

					arg_299_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_299_1.var_.characterEffect10066ui_story.fillRatio = var_302_19
				end
			end

			if arg_299_1.time_ >= var_302_16 + var_302_17 and arg_299_1.time_ < var_302_16 + var_302_17 + arg_302_0 and not isNil(var_302_15) and arg_299_1.var_.characterEffect10066ui_story then
				local var_302_20 = 0.5

				arg_299_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_299_1.var_.characterEffect10066ui_story.fillRatio = var_302_20
			end

			local var_302_21 = 0
			local var_302_22 = 0.5

			if var_302_21 < arg_299_1.time_ and arg_299_1.time_ <= var_302_21 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0
				arg_299_1.dialogCg_.alpha = 1

				arg_299_1.dialog_:SetActive(true)
				SetActive(arg_299_1.leftNameGo_, true)

				local var_302_23 = arg_299_1:FormatText(StoryNameCfg[6].name)

				arg_299_1.leftNameTxt_.text = var_302_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_299_1.leftNameTxt_.transform)

				arg_299_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_299_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_299_1:RecordName(arg_299_1.leftNameTxt_.text)
				SetActive(arg_299_1.iconTrs_.gameObject, false)
				arg_299_1.callingController_:SetSelectedState("normal")

				local var_302_24 = arg_299_1:GetWordFromCfg(319761068)
				local var_302_25 = arg_299_1:FormatText(var_302_24.content)

				arg_299_1.text_.text = var_302_25

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_26 = 20
				local var_302_27 = utf8.len(var_302_25)
				local var_302_28 = var_302_26 <= 0 and var_302_22 or var_302_22 * (var_302_27 / var_302_26)

				if var_302_28 > 0 and var_302_22 < var_302_28 then
					arg_299_1.talkMaxDuration = var_302_28

					if var_302_28 + var_302_21 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_28 + var_302_21
					end
				end

				arg_299_1.text_.text = var_302_25
				arg_299_1.typewritter.percent = 0

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319761", "319761068", "story_v_out_319761.awb") ~= 0 then
					local var_302_29 = manager.audio:GetVoiceLength("story_v_out_319761", "319761068", "story_v_out_319761.awb") / 1000

					if var_302_29 + var_302_21 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_29 + var_302_21
					end

					if var_302_24.prefab_name ~= "" and arg_299_1.actors_[var_302_24.prefab_name] ~= nil then
						local var_302_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_299_1.actors_[var_302_24.prefab_name].transform, "story_v_out_319761", "319761068", "story_v_out_319761.awb")

						arg_299_1:RecordAudio("319761068", var_302_30)
						arg_299_1:RecordAudio("319761068", var_302_30)
					else
						arg_299_1:AudioAction("play", "voice", "story_v_out_319761", "319761068", "story_v_out_319761.awb")
					end

					arg_299_1:RecordHistoryTalkVoice("story_v_out_319761", "319761068", "story_v_out_319761.awb")
				end

				arg_299_1:RecordContent(arg_299_1.text_.text)
			end

			local var_302_31 = math.max(var_302_22, arg_299_1.talkMaxDuration)

			if var_302_21 <= arg_299_1.time_ and arg_299_1.time_ < var_302_21 + var_302_31 then
				arg_299_1.typewritter.percent = (arg_299_1.time_ - var_302_21) / var_302_31

				arg_299_1.typewritter:SetDirty()
			end

			if arg_299_1.time_ >= var_302_21 + var_302_31 and arg_299_1.time_ < var_302_21 + var_302_31 + arg_302_0 then
				arg_299_1.typewritter.percent = 1

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(true)
			end
		end

		arg_299_1.nodeConfigList_ = {
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

		arg_299_1:InitPlayNodeList()
	end,
	Play319761069 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 319761069
		arg_303_1.duration_ = 8.27

		local var_303_0 = {
			zh = 4.633,
			ja = 8.266
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
				arg_303_0:Play319761070(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			local var_306_0 = arg_303_1.actors_["1084ui_story"]
			local var_306_1 = 0

			if var_306_1 < arg_303_1.time_ and arg_303_1.time_ <= var_306_1 + arg_306_0 and not isNil(var_306_0) and arg_303_1.var_.characterEffect1084ui_story == nil then
				arg_303_1.var_.characterEffect1084ui_story = var_306_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_306_2 = 0.200000002980232

			if var_306_1 <= arg_303_1.time_ and arg_303_1.time_ < var_306_1 + var_306_2 and not isNil(var_306_0) then
				local var_306_3 = (arg_303_1.time_ - var_306_1) / var_306_2

				if arg_303_1.var_.characterEffect1084ui_story and not isNil(var_306_0) then
					local var_306_4 = Mathf.Lerp(0, 0.5, var_306_3)

					arg_303_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_303_1.var_.characterEffect1084ui_story.fillRatio = var_306_4
				end
			end

			if arg_303_1.time_ >= var_306_1 + var_306_2 and arg_303_1.time_ < var_306_1 + var_306_2 + arg_306_0 and not isNil(var_306_0) and arg_303_1.var_.characterEffect1084ui_story then
				local var_306_5 = 0.5

				arg_303_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_303_1.var_.characterEffect1084ui_story.fillRatio = var_306_5
			end

			local var_306_6 = arg_303_1.actors_["10066ui_story"]
			local var_306_7 = 0

			if var_306_7 < arg_303_1.time_ and arg_303_1.time_ <= var_306_7 + arg_306_0 and not isNil(var_306_6) and arg_303_1.var_.characterEffect10066ui_story == nil then
				arg_303_1.var_.characterEffect10066ui_story = var_306_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_306_8 = 0.200000002980232

			if var_306_7 <= arg_303_1.time_ and arg_303_1.time_ < var_306_7 + var_306_8 and not isNil(var_306_6) then
				local var_306_9 = (arg_303_1.time_ - var_306_7) / var_306_8

				if arg_303_1.var_.characterEffect10066ui_story and not isNil(var_306_6) then
					arg_303_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_303_1.time_ >= var_306_7 + var_306_8 and arg_303_1.time_ < var_306_7 + var_306_8 + arg_306_0 and not isNil(var_306_6) and arg_303_1.var_.characterEffect10066ui_story then
				arg_303_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_306_10 = 0

			if var_306_10 < arg_303_1.time_ and arg_303_1.time_ <= var_306_10 + arg_306_0 then
				arg_303_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action2_2")
			end

			local var_306_11 = 0

			if var_306_11 < arg_303_1.time_ and arg_303_1.time_ <= var_306_11 + arg_306_0 then
				arg_303_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2202cva")
			end

			local var_306_12 = 0
			local var_306_13 = 0.425

			if var_306_12 < arg_303_1.time_ and arg_303_1.time_ <= var_306_12 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0
				arg_303_1.dialogCg_.alpha = 1

				arg_303_1.dialog_:SetActive(true)
				SetActive(arg_303_1.leftNameGo_, true)

				local var_306_14 = arg_303_1:FormatText(StoryNameCfg[640].name)

				arg_303_1.leftNameTxt_.text = var_306_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_303_1.leftNameTxt_.transform)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1.leftNameTxt_.text)
				SetActive(arg_303_1.iconTrs_.gameObject, false)
				arg_303_1.callingController_:SetSelectedState("normal")

				local var_306_15 = arg_303_1:GetWordFromCfg(319761069)
				local var_306_16 = arg_303_1:FormatText(var_306_15.content)

				arg_303_1.text_.text = var_306_16

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_17 = 17
				local var_306_18 = utf8.len(var_306_16)
				local var_306_19 = var_306_17 <= 0 and var_306_13 or var_306_13 * (var_306_18 / var_306_17)

				if var_306_19 > 0 and var_306_13 < var_306_19 then
					arg_303_1.talkMaxDuration = var_306_19

					if var_306_19 + var_306_12 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_19 + var_306_12
					end
				end

				arg_303_1.text_.text = var_306_16
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319761", "319761069", "story_v_out_319761.awb") ~= 0 then
					local var_306_20 = manager.audio:GetVoiceLength("story_v_out_319761", "319761069", "story_v_out_319761.awb") / 1000

					if var_306_20 + var_306_12 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_20 + var_306_12
					end

					if var_306_15.prefab_name ~= "" and arg_303_1.actors_[var_306_15.prefab_name] ~= nil then
						local var_306_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_303_1.actors_[var_306_15.prefab_name].transform, "story_v_out_319761", "319761069", "story_v_out_319761.awb")

						arg_303_1:RecordAudio("319761069", var_306_21)
						arg_303_1:RecordAudio("319761069", var_306_21)
					else
						arg_303_1:AudioAction("play", "voice", "story_v_out_319761", "319761069", "story_v_out_319761.awb")
					end

					arg_303_1:RecordHistoryTalkVoice("story_v_out_319761", "319761069", "story_v_out_319761.awb")
				end

				arg_303_1:RecordContent(arg_303_1.text_.text)
			end

			local var_306_22 = math.max(var_306_13, arg_303_1.talkMaxDuration)

			if var_306_12 <= arg_303_1.time_ and arg_303_1.time_ < var_306_12 + var_306_22 then
				arg_303_1.typewritter.percent = (arg_303_1.time_ - var_306_12) / var_306_22

				arg_303_1.typewritter:SetDirty()
			end

			if arg_303_1.time_ >= var_306_12 + var_306_22 and arg_303_1.time_ < var_306_12 + var_306_22 + arg_306_0 then
				arg_303_1.typewritter.percent = 1

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(true)
			end
		end

		arg_303_1.nodeConfigList_ = {}

		arg_303_1:InitPlayNodeList()
	end,
	Play319761070 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 319761070
		arg_307_1.duration_ = 5

		SetActive(arg_307_1.tipsGo_, false)

		function arg_307_1.onSingleLineFinish_()
			arg_307_1.onSingleLineUpdate_ = nil
			arg_307_1.onSingleLineFinish_ = nil
			arg_307_1.state_ = "waiting"
		end

		function arg_307_1.playNext_(arg_309_0)
			if arg_309_0 == 1 then
				arg_307_0:Play319761071(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			local var_310_0 = arg_307_1.actors_["10066ui_story"]
			local var_310_1 = 0

			if var_310_1 < arg_307_1.time_ and arg_307_1.time_ <= var_310_1 + arg_310_0 and not isNil(var_310_0) and arg_307_1.var_.characterEffect10066ui_story == nil then
				arg_307_1.var_.characterEffect10066ui_story = var_310_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_310_2 = 0.200000002980232

			if var_310_1 <= arg_307_1.time_ and arg_307_1.time_ < var_310_1 + var_310_2 and not isNil(var_310_0) then
				local var_310_3 = (arg_307_1.time_ - var_310_1) / var_310_2

				if arg_307_1.var_.characterEffect10066ui_story and not isNil(var_310_0) then
					local var_310_4 = Mathf.Lerp(0, 0.5, var_310_3)

					arg_307_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_307_1.var_.characterEffect10066ui_story.fillRatio = var_310_4
				end
			end

			if arg_307_1.time_ >= var_310_1 + var_310_2 and arg_307_1.time_ < var_310_1 + var_310_2 + arg_310_0 and not isNil(var_310_0) and arg_307_1.var_.characterEffect10066ui_story then
				local var_310_5 = 0.5

				arg_307_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_307_1.var_.characterEffect10066ui_story.fillRatio = var_310_5
			end

			local var_310_6 = 0

			if var_310_6 < arg_307_1.time_ and arg_307_1.time_ <= var_310_6 + arg_310_0 then
				arg_307_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action6_2")
			end

			local var_310_7 = 0
			local var_310_8 = 0.8

			if var_310_7 < arg_307_1.time_ and arg_307_1.time_ <= var_310_7 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0
				arg_307_1.dialogCg_.alpha = 1

				arg_307_1.dialog_:SetActive(true)
				SetActive(arg_307_1.leftNameGo_, false)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_307_1.iconTrs_.gameObject, false)
				arg_307_1.callingController_:SetSelectedState("normal")

				local var_310_9 = arg_307_1:GetWordFromCfg(319761070)
				local var_310_10 = arg_307_1:FormatText(var_310_9.content)

				arg_307_1.text_.text = var_310_10

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_11 = 32
				local var_310_12 = utf8.len(var_310_10)
				local var_310_13 = var_310_11 <= 0 and var_310_8 or var_310_8 * (var_310_12 / var_310_11)

				if var_310_13 > 0 and var_310_8 < var_310_13 then
					arg_307_1.talkMaxDuration = var_310_13

					if var_310_13 + var_310_7 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_13 + var_310_7
					end
				end

				arg_307_1.text_.text = var_310_10
				arg_307_1.typewritter.percent = 0

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(false)
				arg_307_1:RecordContent(arg_307_1.text_.text)
			end

			local var_310_14 = math.max(var_310_8, arg_307_1.talkMaxDuration)

			if var_310_7 <= arg_307_1.time_ and arg_307_1.time_ < var_310_7 + var_310_14 then
				arg_307_1.typewritter.percent = (arg_307_1.time_ - var_310_7) / var_310_14

				arg_307_1.typewritter:SetDirty()
			end

			if arg_307_1.time_ >= var_310_7 + var_310_14 and arg_307_1.time_ < var_310_7 + var_310_14 + arg_310_0 then
				arg_307_1.typewritter.percent = 1

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(true)
			end
		end

		arg_307_1.nodeConfigList_ = {}

		arg_307_1:InitPlayNodeList()
	end,
	Play319761071 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 319761071
		arg_311_1.duration_ = 8.77

		local var_311_0 = {
			zh = 5.833,
			ja = 8.766
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
				arg_311_0:Play319761072(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			local var_314_0 = arg_311_1.actors_["10066ui_story"].transform
			local var_314_1 = 0

			if var_314_1 < arg_311_1.time_ and arg_311_1.time_ <= var_314_1 + arg_314_0 then
				arg_311_1.var_.moveOldPos10066ui_story = var_314_0.localPosition
			end

			local var_314_2 = 0.001

			if var_314_1 <= arg_311_1.time_ and arg_311_1.time_ < var_314_1 + var_314_2 then
				local var_314_3 = (arg_311_1.time_ - var_314_1) / var_314_2
				local var_314_4 = Vector3.New(0.7, -0.99, -5.83)

				var_314_0.localPosition = Vector3.Lerp(arg_311_1.var_.moveOldPos10066ui_story, var_314_4, var_314_3)

				local var_314_5 = manager.ui.mainCamera.transform.position - var_314_0.position

				var_314_0.forward = Vector3.New(var_314_5.x, var_314_5.y, var_314_5.z)

				local var_314_6 = var_314_0.localEulerAngles

				var_314_6.z = 0
				var_314_6.x = 0
				var_314_0.localEulerAngles = var_314_6
			end

			if arg_311_1.time_ >= var_314_1 + var_314_2 and arg_311_1.time_ < var_314_1 + var_314_2 + arg_314_0 then
				var_314_0.localPosition = Vector3.New(0.7, -0.99, -5.83)

				local var_314_7 = manager.ui.mainCamera.transform.position - var_314_0.position

				var_314_0.forward = Vector3.New(var_314_7.x, var_314_7.y, var_314_7.z)

				local var_314_8 = var_314_0.localEulerAngles

				var_314_8.z = 0
				var_314_8.x = 0
				var_314_0.localEulerAngles = var_314_8
			end

			local var_314_9 = arg_311_1.actors_["10066ui_story"]
			local var_314_10 = 0

			if var_314_10 < arg_311_1.time_ and arg_311_1.time_ <= var_314_10 + arg_314_0 and not isNil(var_314_9) and arg_311_1.var_.characterEffect10066ui_story == nil then
				arg_311_1.var_.characterEffect10066ui_story = var_314_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_314_11 = 0.200000002980232

			if var_314_10 <= arg_311_1.time_ and arg_311_1.time_ < var_314_10 + var_314_11 and not isNil(var_314_9) then
				local var_314_12 = (arg_311_1.time_ - var_314_10) / var_314_11

				if arg_311_1.var_.characterEffect10066ui_story and not isNil(var_314_9) then
					arg_311_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_311_1.time_ >= var_314_10 + var_314_11 and arg_311_1.time_ < var_314_10 + var_314_11 + arg_314_0 and not isNil(var_314_9) and arg_311_1.var_.characterEffect10066ui_story then
				arg_311_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_314_13 = 0

			if var_314_13 < arg_311_1.time_ and arg_311_1.time_ <= var_314_13 + arg_314_0 then
				arg_311_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action3_1")
			end

			local var_314_14 = 0

			if var_314_14 < arg_311_1.time_ and arg_311_1.time_ <= var_314_14 + arg_314_0 then
				arg_311_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_314_15 = 0
			local var_314_16 = 0.525

			if var_314_15 < arg_311_1.time_ and arg_311_1.time_ <= var_314_15 + arg_314_0 then
				arg_311_1.talkMaxDuration = 0
				arg_311_1.dialogCg_.alpha = 1

				arg_311_1.dialog_:SetActive(true)
				SetActive(arg_311_1.leftNameGo_, true)

				local var_314_17 = arg_311_1:FormatText(StoryNameCfg[640].name)

				arg_311_1.leftNameTxt_.text = var_314_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_311_1.leftNameTxt_.transform)

				arg_311_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_311_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_311_1:RecordName(arg_311_1.leftNameTxt_.text)
				SetActive(arg_311_1.iconTrs_.gameObject, false)
				arg_311_1.callingController_:SetSelectedState("normal")

				local var_314_18 = arg_311_1:GetWordFromCfg(319761071)
				local var_314_19 = arg_311_1:FormatText(var_314_18.content)

				arg_311_1.text_.text = var_314_19

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_20 = 21
				local var_314_21 = utf8.len(var_314_19)
				local var_314_22 = var_314_20 <= 0 and var_314_16 or var_314_16 * (var_314_21 / var_314_20)

				if var_314_22 > 0 and var_314_16 < var_314_22 then
					arg_311_1.talkMaxDuration = var_314_22

					if var_314_22 + var_314_15 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_22 + var_314_15
					end
				end

				arg_311_1.text_.text = var_314_19
				arg_311_1.typewritter.percent = 0

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319761", "319761071", "story_v_out_319761.awb") ~= 0 then
					local var_314_23 = manager.audio:GetVoiceLength("story_v_out_319761", "319761071", "story_v_out_319761.awb") / 1000

					if var_314_23 + var_314_15 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_23 + var_314_15
					end

					if var_314_18.prefab_name ~= "" and arg_311_1.actors_[var_314_18.prefab_name] ~= nil then
						local var_314_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_311_1.actors_[var_314_18.prefab_name].transform, "story_v_out_319761", "319761071", "story_v_out_319761.awb")

						arg_311_1:RecordAudio("319761071", var_314_24)
						arg_311_1:RecordAudio("319761071", var_314_24)
					else
						arg_311_1:AudioAction("play", "voice", "story_v_out_319761", "319761071", "story_v_out_319761.awb")
					end

					arg_311_1:RecordHistoryTalkVoice("story_v_out_319761", "319761071", "story_v_out_319761.awb")
				end

				arg_311_1:RecordContent(arg_311_1.text_.text)
			end

			local var_314_25 = math.max(var_314_16, arg_311_1.talkMaxDuration)

			if var_314_15 <= arg_311_1.time_ and arg_311_1.time_ < var_314_15 + var_314_25 then
				arg_311_1.typewritter.percent = (arg_311_1.time_ - var_314_15) / var_314_25

				arg_311_1.typewritter:SetDirty()
			end

			if arg_311_1.time_ >= var_314_15 + var_314_25 and arg_311_1.time_ < var_314_15 + var_314_25 + arg_314_0 then
				arg_311_1.typewritter.percent = 1

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(true)
			end
		end

		arg_311_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
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
	Play319761072 = function(arg_315_0, arg_315_1)
		arg_315_1.time_ = 0
		arg_315_1.frameCnt_ = 0
		arg_315_1.state_ = "playing"
		arg_315_1.curTalkId_ = 319761072
		arg_315_1.duration_ = 6.9

		local var_315_0 = {
			zh = 5.366,
			ja = 6.9
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
				arg_315_0:Play319761073(arg_315_1)
			end
		end

		function arg_315_1.onSingleLineUpdate_(arg_318_0)
			local var_318_0 = arg_315_1.actors_["1084ui_story"].transform
			local var_318_1 = 0

			if var_318_1 < arg_315_1.time_ and arg_315_1.time_ <= var_318_1 + arg_318_0 then
				arg_315_1.var_.moveOldPos1084ui_story = var_318_0.localPosition
			end

			local var_318_2 = 0.001

			if var_318_1 <= arg_315_1.time_ and arg_315_1.time_ < var_318_1 + var_318_2 then
				local var_318_3 = (arg_315_1.time_ - var_318_1) / var_318_2
				local var_318_4 = Vector3.New(-0.7, -0.97, -6)

				var_318_0.localPosition = Vector3.Lerp(arg_315_1.var_.moveOldPos1084ui_story, var_318_4, var_318_3)

				local var_318_5 = manager.ui.mainCamera.transform.position - var_318_0.position

				var_318_0.forward = Vector3.New(var_318_5.x, var_318_5.y, var_318_5.z)

				local var_318_6 = var_318_0.localEulerAngles

				var_318_6.z = 0
				var_318_6.x = 0
				var_318_0.localEulerAngles = var_318_6
			end

			if arg_315_1.time_ >= var_318_1 + var_318_2 and arg_315_1.time_ < var_318_1 + var_318_2 + arg_318_0 then
				var_318_0.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_318_7 = manager.ui.mainCamera.transform.position - var_318_0.position

				var_318_0.forward = Vector3.New(var_318_7.x, var_318_7.y, var_318_7.z)

				local var_318_8 = var_318_0.localEulerAngles

				var_318_8.z = 0
				var_318_8.x = 0
				var_318_0.localEulerAngles = var_318_8
			end

			local var_318_9 = arg_315_1.actors_["1084ui_story"]
			local var_318_10 = 0

			if var_318_10 < arg_315_1.time_ and arg_315_1.time_ <= var_318_10 + arg_318_0 and not isNil(var_318_9) and arg_315_1.var_.characterEffect1084ui_story == nil then
				arg_315_1.var_.characterEffect1084ui_story = var_318_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_318_11 = 0.200000002980232

			if var_318_10 <= arg_315_1.time_ and arg_315_1.time_ < var_318_10 + var_318_11 and not isNil(var_318_9) then
				local var_318_12 = (arg_315_1.time_ - var_318_10) / var_318_11

				if arg_315_1.var_.characterEffect1084ui_story and not isNil(var_318_9) then
					arg_315_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_315_1.time_ >= var_318_10 + var_318_11 and arg_315_1.time_ < var_318_10 + var_318_11 + arg_318_0 and not isNil(var_318_9) and arg_315_1.var_.characterEffect1084ui_story then
				arg_315_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_318_13 = 0

			if var_318_13 < arg_315_1.time_ and arg_315_1.time_ <= var_318_13 + arg_318_0 then
				arg_315_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_318_14 = 0

			if var_318_14 < arg_315_1.time_ and arg_315_1.time_ <= var_318_14 + arg_318_0 then
				arg_315_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_318_15 = arg_315_1.actors_["10066ui_story"]
			local var_318_16 = 0

			if var_318_16 < arg_315_1.time_ and arg_315_1.time_ <= var_318_16 + arg_318_0 and not isNil(var_318_15) and arg_315_1.var_.characterEffect10066ui_story == nil then
				arg_315_1.var_.characterEffect10066ui_story = var_318_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_318_17 = 0.200000002980232

			if var_318_16 <= arg_315_1.time_ and arg_315_1.time_ < var_318_16 + var_318_17 and not isNil(var_318_15) then
				local var_318_18 = (arg_315_1.time_ - var_318_16) / var_318_17

				if arg_315_1.var_.characterEffect10066ui_story and not isNil(var_318_15) then
					local var_318_19 = Mathf.Lerp(0, 0.5, var_318_18)

					arg_315_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_315_1.var_.characterEffect10066ui_story.fillRatio = var_318_19
				end
			end

			if arg_315_1.time_ >= var_318_16 + var_318_17 and arg_315_1.time_ < var_318_16 + var_318_17 + arg_318_0 and not isNil(var_318_15) and arg_315_1.var_.characterEffect10066ui_story then
				local var_318_20 = 0.5

				arg_315_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_315_1.var_.characterEffect10066ui_story.fillRatio = var_318_20
			end

			local var_318_21 = 0
			local var_318_22 = 0.65

			if var_318_21 < arg_315_1.time_ and arg_315_1.time_ <= var_318_21 + arg_318_0 then
				arg_315_1.talkMaxDuration = 0
				arg_315_1.dialogCg_.alpha = 1

				arg_315_1.dialog_:SetActive(true)
				SetActive(arg_315_1.leftNameGo_, true)

				local var_318_23 = arg_315_1:FormatText(StoryNameCfg[6].name)

				arg_315_1.leftNameTxt_.text = var_318_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_315_1.leftNameTxt_.transform)

				arg_315_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_315_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_315_1:RecordName(arg_315_1.leftNameTxt_.text)
				SetActive(arg_315_1.iconTrs_.gameObject, false)
				arg_315_1.callingController_:SetSelectedState("normal")

				local var_318_24 = arg_315_1:GetWordFromCfg(319761072)
				local var_318_25 = arg_315_1:FormatText(var_318_24.content)

				arg_315_1.text_.text = var_318_25

				LuaForUtil.ClearLinePrefixSymbol(arg_315_1.text_)

				local var_318_26 = 26
				local var_318_27 = utf8.len(var_318_25)
				local var_318_28 = var_318_26 <= 0 and var_318_22 or var_318_22 * (var_318_27 / var_318_26)

				if var_318_28 > 0 and var_318_22 < var_318_28 then
					arg_315_1.talkMaxDuration = var_318_28

					if var_318_28 + var_318_21 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_28 + var_318_21
					end
				end

				arg_315_1.text_.text = var_318_25
				arg_315_1.typewritter.percent = 0

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319761", "319761072", "story_v_out_319761.awb") ~= 0 then
					local var_318_29 = manager.audio:GetVoiceLength("story_v_out_319761", "319761072", "story_v_out_319761.awb") / 1000

					if var_318_29 + var_318_21 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_29 + var_318_21
					end

					if var_318_24.prefab_name ~= "" and arg_315_1.actors_[var_318_24.prefab_name] ~= nil then
						local var_318_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_315_1.actors_[var_318_24.prefab_name].transform, "story_v_out_319761", "319761072", "story_v_out_319761.awb")

						arg_315_1:RecordAudio("319761072", var_318_30)
						arg_315_1:RecordAudio("319761072", var_318_30)
					else
						arg_315_1:AudioAction("play", "voice", "story_v_out_319761", "319761072", "story_v_out_319761.awb")
					end

					arg_315_1:RecordHistoryTalkVoice("story_v_out_319761", "319761072", "story_v_out_319761.awb")
				end

				arg_315_1:RecordContent(arg_315_1.text_.text)
			end

			local var_318_31 = math.max(var_318_22, arg_315_1.talkMaxDuration)

			if var_318_21 <= arg_315_1.time_ and arg_315_1.time_ < var_318_21 + var_318_31 then
				arg_315_1.typewritter.percent = (arg_315_1.time_ - var_318_21) / var_318_31

				arg_315_1.typewritter:SetDirty()
			end

			if arg_315_1.time_ >= var_318_21 + var_318_31 and arg_315_1.time_ < var_318_21 + var_318_31 + arg_318_0 then
				arg_315_1.typewritter.percent = 1

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(true)
			end
		end

		arg_315_1.nodeConfigList_ = {
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

		arg_315_1:InitPlayNodeList()
	end,
	Play319761073 = function(arg_319_0, arg_319_1)
		arg_319_1.time_ = 0
		arg_319_1.frameCnt_ = 0
		arg_319_1.state_ = "playing"
		arg_319_1.curTalkId_ = 319761073
		arg_319_1.duration_ = 5

		SetActive(arg_319_1.tipsGo_, false)

		function arg_319_1.onSingleLineFinish_()
			arg_319_1.onSingleLineUpdate_ = nil
			arg_319_1.onSingleLineFinish_ = nil
			arg_319_1.state_ = "waiting"
		end

		function arg_319_1.playNext_(arg_321_0)
			if arg_321_0 == 1 then
				arg_319_0:Play319761074(arg_319_1)
			end
		end

		function arg_319_1.onSingleLineUpdate_(arg_322_0)
			local var_322_0 = arg_319_1.actors_["1084ui_story"]
			local var_322_1 = 0

			if var_322_1 < arg_319_1.time_ and arg_319_1.time_ <= var_322_1 + arg_322_0 and not isNil(var_322_0) and arg_319_1.var_.characterEffect1084ui_story == nil then
				arg_319_1.var_.characterEffect1084ui_story = var_322_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_322_2 = 0.200000002980232

			if var_322_1 <= arg_319_1.time_ and arg_319_1.time_ < var_322_1 + var_322_2 and not isNil(var_322_0) then
				local var_322_3 = (arg_319_1.time_ - var_322_1) / var_322_2

				if arg_319_1.var_.characterEffect1084ui_story and not isNil(var_322_0) then
					local var_322_4 = Mathf.Lerp(0, 0.5, var_322_3)

					arg_319_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_319_1.var_.characterEffect1084ui_story.fillRatio = var_322_4
				end
			end

			if arg_319_1.time_ >= var_322_1 + var_322_2 and arg_319_1.time_ < var_322_1 + var_322_2 + arg_322_0 and not isNil(var_322_0) and arg_319_1.var_.characterEffect1084ui_story then
				local var_322_5 = 0.5

				arg_319_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_319_1.var_.characterEffect1084ui_story.fillRatio = var_322_5
			end

			local var_322_6 = 0
			local var_322_7 = 0.725

			if var_322_6 < arg_319_1.time_ and arg_319_1.time_ <= var_322_6 + arg_322_0 then
				arg_319_1.talkMaxDuration = 0
				arg_319_1.dialogCg_.alpha = 1

				arg_319_1.dialog_:SetActive(true)
				SetActive(arg_319_1.leftNameGo_, false)

				arg_319_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_319_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_319_1:RecordName(arg_319_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_319_1.iconTrs_.gameObject, false)
				arg_319_1.callingController_:SetSelectedState("normal")

				local var_322_8 = arg_319_1:GetWordFromCfg(319761073)
				local var_322_9 = arg_319_1:FormatText(var_322_8.content)

				arg_319_1.text_.text = var_322_9

				LuaForUtil.ClearLinePrefixSymbol(arg_319_1.text_)

				local var_322_10 = 29
				local var_322_11 = utf8.len(var_322_9)
				local var_322_12 = var_322_10 <= 0 and var_322_7 or var_322_7 * (var_322_11 / var_322_10)

				if var_322_12 > 0 and var_322_7 < var_322_12 then
					arg_319_1.talkMaxDuration = var_322_12

					if var_322_12 + var_322_6 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_12 + var_322_6
					end
				end

				arg_319_1.text_.text = var_322_9
				arg_319_1.typewritter.percent = 0

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(false)
				arg_319_1:RecordContent(arg_319_1.text_.text)
			end

			local var_322_13 = math.max(var_322_7, arg_319_1.talkMaxDuration)

			if var_322_6 <= arg_319_1.time_ and arg_319_1.time_ < var_322_6 + var_322_13 then
				arg_319_1.typewritter.percent = (arg_319_1.time_ - var_322_6) / var_322_13

				arg_319_1.typewritter:SetDirty()
			end

			if arg_319_1.time_ >= var_322_6 + var_322_13 and arg_319_1.time_ < var_322_6 + var_322_13 + arg_322_0 then
				arg_319_1.typewritter.percent = 1

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(true)
			end
		end

		arg_319_1.nodeConfigList_ = {}

		arg_319_1:InitPlayNodeList()
	end,
	Play319761074 = function(arg_323_0, arg_323_1)
		arg_323_1.time_ = 0
		arg_323_1.frameCnt_ = 0
		arg_323_1.state_ = "playing"
		arg_323_1.curTalkId_ = 319761074
		arg_323_1.duration_ = 7.73

		local var_323_0 = {
			zh = 3.733,
			ja = 7.733
		}
		local var_323_1 = manager.audio:GetLocalizationFlag()

		if var_323_0[var_323_1] ~= nil then
			arg_323_1.duration_ = var_323_0[var_323_1]
		end

		SetActive(arg_323_1.tipsGo_, false)

		function arg_323_1.onSingleLineFinish_()
			arg_323_1.onSingleLineUpdate_ = nil
			arg_323_1.onSingleLineFinish_ = nil
			arg_323_1.state_ = "waiting"
			arg_323_1.auto_ = false
		end

		function arg_323_1.playNext_(arg_325_0)
			arg_323_1.onStoryFinished_()
		end

		function arg_323_1.onSingleLineUpdate_(arg_326_0)
			local var_326_0 = arg_323_1.actors_["10066ui_story"]
			local var_326_1 = 0

			if var_326_1 < arg_323_1.time_ and arg_323_1.time_ <= var_326_1 + arg_326_0 and not isNil(var_326_0) and arg_323_1.var_.characterEffect10066ui_story == nil then
				arg_323_1.var_.characterEffect10066ui_story = var_326_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_326_2 = 0.200000002980232

			if var_326_1 <= arg_323_1.time_ and arg_323_1.time_ < var_326_1 + var_326_2 and not isNil(var_326_0) then
				local var_326_3 = (arg_323_1.time_ - var_326_1) / var_326_2

				if arg_323_1.var_.characterEffect10066ui_story and not isNil(var_326_0) then
					arg_323_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_323_1.time_ >= var_326_1 + var_326_2 and arg_323_1.time_ < var_326_1 + var_326_2 + arg_326_0 and not isNil(var_326_0) and arg_323_1.var_.characterEffect10066ui_story then
				arg_323_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_326_4 = 0

			if var_326_4 < arg_323_1.time_ and arg_323_1.time_ <= var_326_4 + arg_326_0 then
				arg_323_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_326_5 = 0
			local var_326_6 = 0.375

			if var_326_5 < arg_323_1.time_ and arg_323_1.time_ <= var_326_5 + arg_326_0 then
				arg_323_1.talkMaxDuration = 0
				arg_323_1.dialogCg_.alpha = 1

				arg_323_1.dialog_:SetActive(true)
				SetActive(arg_323_1.leftNameGo_, true)

				local var_326_7 = arg_323_1:FormatText(StoryNameCfg[640].name)

				arg_323_1.leftNameTxt_.text = var_326_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_323_1.leftNameTxt_.transform)

				arg_323_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_323_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_323_1:RecordName(arg_323_1.leftNameTxt_.text)
				SetActive(arg_323_1.iconTrs_.gameObject, false)
				arg_323_1.callingController_:SetSelectedState("normal")

				local var_326_8 = arg_323_1:GetWordFromCfg(319761074)
				local var_326_9 = arg_323_1:FormatText(var_326_8.content)

				arg_323_1.text_.text = var_326_9

				LuaForUtil.ClearLinePrefixSymbol(arg_323_1.text_)

				local var_326_10 = 15
				local var_326_11 = utf8.len(var_326_9)
				local var_326_12 = var_326_10 <= 0 and var_326_6 or var_326_6 * (var_326_11 / var_326_10)

				if var_326_12 > 0 and var_326_6 < var_326_12 then
					arg_323_1.talkMaxDuration = var_326_12

					if var_326_12 + var_326_5 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_12 + var_326_5
					end
				end

				arg_323_1.text_.text = var_326_9
				arg_323_1.typewritter.percent = 0

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319761", "319761074", "story_v_out_319761.awb") ~= 0 then
					local var_326_13 = manager.audio:GetVoiceLength("story_v_out_319761", "319761074", "story_v_out_319761.awb") / 1000

					if var_326_13 + var_326_5 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_13 + var_326_5
					end

					if var_326_8.prefab_name ~= "" and arg_323_1.actors_[var_326_8.prefab_name] ~= nil then
						local var_326_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_323_1.actors_[var_326_8.prefab_name].transform, "story_v_out_319761", "319761074", "story_v_out_319761.awb")

						arg_323_1:RecordAudio("319761074", var_326_14)
						arg_323_1:RecordAudio("319761074", var_326_14)
					else
						arg_323_1:AudioAction("play", "voice", "story_v_out_319761", "319761074", "story_v_out_319761.awb")
					end

					arg_323_1:RecordHistoryTalkVoice("story_v_out_319761", "319761074", "story_v_out_319761.awb")
				end

				arg_323_1:RecordContent(arg_323_1.text_.text)
			end

			local var_326_15 = math.max(var_326_6, arg_323_1.talkMaxDuration)

			if var_326_5 <= arg_323_1.time_ and arg_323_1.time_ < var_326_5 + var_326_15 then
				arg_323_1.typewritter.percent = (arg_323_1.time_ - var_326_5) / var_326_15

				arg_323_1.typewritter:SetDirty()
			end

			if arg_323_1.time_ >= var_326_5 + var_326_15 and arg_323_1.time_ < var_326_5 + var_326_15 + arg_326_0 then
				arg_323_1.typewritter.percent = 1

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(true)
			end
		end

		arg_323_1.nodeConfigList_ = {}

		arg_323_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/I11o",
		"TextureConfig/Background/I11r",
		"TextureConfig/Background/I11l",
		"TextureConfig/Background/ST74",
		"TextureConfig/Background/D02a",
		"TextureConfig/Background/ML0202",
		"TextureConfig/Background/STblack"
	},
	voices = {
		"story_v_out_319761.awb"
	}
}
