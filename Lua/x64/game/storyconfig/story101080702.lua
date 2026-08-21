return {
	Play108072001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 108072001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play108072002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "S0804"

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
				local var_4_5 = arg_1_1.bgs_.S0804

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
					if iter_4_0 ~= "S0804" then
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
			local var_4_23 = 1

			if var_4_22 < arg_1_1.time_ and arg_1_1.time_ <= var_4_22 + arg_4_0 then
				local var_4_24 = "play"
				local var_4_25 = "music"

				arg_1_1:AudioAction(var_4_24, var_4_25, "bgm_story_scheme", "bgm_story_scheme", "bgm_story_scheme.awb")

				local var_4_26 = ""
				local var_4_27 = manager.audio:GetAudioName("bgm_story_scheme", "bgm_story_scheme")

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

			local var_4_28 = 0

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_29 = 2

			if arg_1_1.time_ >= var_4_28 + var_4_29 and arg_1_1.time_ < var_4_28 + var_4_29 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_30 = 2
			local var_4_31 = 0.55

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

				local var_4_33 = arg_1_1:GetWordFromCfg(108072001)
				local var_4_34 = arg_1_1:FormatText(var_4_33.content)

				arg_1_1.text_.text = var_4_34

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_35 = 22
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
	Play108072002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 108072002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play108072003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 0
			local var_11_1 = 0.85

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

				local var_11_2 = arg_8_1:GetWordFromCfg(108072002)
				local var_11_3 = arg_8_1:FormatText(var_11_2.content)

				arg_8_1.text_.text = var_11_3

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_4 = 34
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
	Play108072003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 108072003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play108072004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 0
			local var_15_1 = 0.725

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

				local var_15_2 = arg_12_1:GetWordFromCfg(108072003)
				local var_15_3 = arg_12_1:FormatText(var_15_2.content)

				arg_12_1.text_.text = var_15_3

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_4 = 29
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
	Play108072004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 108072004
		arg_16_1.duration_ = 6.2

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play108072006(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = 2

			if var_19_0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_0 + arg_19_0 then
				arg_16_1.fswbg_:SetActive(true)
				arg_16_1.dialog_:SetActive(false)

				arg_16_1.fswtw_.percent = 0

				local var_19_1 = arg_16_1:GetWordFromCfg(108072004)
				local var_19_2 = arg_16_1:FormatText(var_19_1.content)

				arg_16_1.fswt_.text = var_19_2

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.fswt_)

				arg_16_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_16_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_16_1.fswtw_:SetDirty()

				arg_16_1.typewritterCharCountI18N = 0

				SetActive(arg_16_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_16_1:ShowNextGo(false)
			end

			local var_19_3 = 2.01666666666667

			if var_19_3 < arg_16_1.time_ and arg_16_1.time_ <= var_19_3 + arg_19_0 then
				arg_16_1.var_.oldValueTypewriter = arg_16_1.fswtw_.percent

				SetActive(arg_16_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_16_1:ShowNextGo(false)
			end

			local var_19_4 = 19
			local var_19_5 = 0.96
			local var_19_6 = arg_16_1:GetWordFromCfg(108072004)
			local var_19_7 = arg_16_1:FormatText(var_19_6.content)
			local var_19_8, var_19_9 = arg_16_1:GetPercentByPara(var_19_7, 1)

			if var_19_3 < arg_16_1.time_ and arg_16_1.time_ <= var_19_3 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0

				local var_19_10 = var_19_4 <= 0 and var_19_5 or var_19_5 * ((var_19_9 - arg_16_1.typewritterCharCountI18N) / var_19_4)

				if var_19_10 > 0 and var_19_5 < var_19_10 then
					arg_16_1.talkMaxDuration = var_19_10

					if var_19_10 + var_19_3 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_10 + var_19_3
					end
				end
			end

			local var_19_11 = 0.96
			local var_19_12 = math.max(var_19_11, arg_16_1.talkMaxDuration)

			if var_19_3 <= arg_16_1.time_ and arg_16_1.time_ < var_19_3 + var_19_12 then
				local var_19_13 = (arg_16_1.time_ - var_19_3) / var_19_12

				arg_16_1.fswtw_.percent = Mathf.Lerp(arg_16_1.var_.oldValueTypewriter, var_19_8, var_19_13)
				arg_16_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_16_1.fswtw_:SetDirty()
			end

			if arg_16_1.time_ >= var_19_3 + var_19_12 and arg_16_1.time_ < var_19_3 + var_19_12 + arg_19_0 then
				arg_16_1.fswtw_.percent = var_19_8

				arg_16_1.fswtw_:SetDirty()
				arg_16_1:ShowNextGo(true)

				arg_16_1.typewritterCharCountI18N = var_19_9
			end

			local var_19_14 = 2
			local var_19_15 = 4.201
			local var_19_16 = manager.audio:GetVoiceLength("story_v_out_108072", "108072004", "story_v_out_108072.awb") / 1000

			if var_19_16 > 0 and var_19_15 < var_19_16 and var_19_16 + var_19_14 > arg_16_1.duration_ then
				local var_19_17 = var_19_16

				arg_16_1.duration_ = var_19_16 + var_19_14
			end

			if var_19_14 < arg_16_1.time_ and arg_16_1.time_ <= var_19_14 + arg_19_0 then
				local var_19_18 = "play"
				local var_19_19 = "voice"

				arg_16_1:AudioAction(var_19_18, var_19_19, "story_v_out_108072", "108072004", "story_v_out_108072.awb")
			end

			local var_19_20 = 0

			if var_19_20 < arg_16_1.time_ and arg_16_1.time_ <= var_19_20 + arg_19_0 then
				arg_16_1.mask_.enabled = true
				arg_16_1.mask_.raycastTarget = true

				arg_16_1:SetGaussion(false)
			end

			local var_19_21 = 2

			if var_19_20 <= arg_16_1.time_ and arg_16_1.time_ < var_19_20 + var_19_21 then
				local var_19_22 = (arg_16_1.time_ - var_19_20) / var_19_21
				local var_19_23 = Color.New(0, 0, 0)

				var_19_23.a = Mathf.Lerp(0, 1, var_19_22)
				arg_16_1.mask_.color = var_19_23
			end

			if arg_16_1.time_ >= var_19_20 + var_19_21 and arg_16_1.time_ < var_19_20 + var_19_21 + arg_19_0 then
				local var_19_24 = Color.New(0, 0, 0)

				var_19_24.a = 1
				arg_16_1.mask_.color = var_19_24
			end

			local var_19_25 = 2

			if var_19_25 < arg_16_1.time_ and arg_16_1.time_ <= var_19_25 + arg_19_0 then
				arg_16_1.mask_.enabled = true
				arg_16_1.mask_.raycastTarget = true

				arg_16_1:SetGaussion(false)
			end

			local var_19_26 = 2

			if var_19_25 <= arg_16_1.time_ and arg_16_1.time_ < var_19_25 + var_19_26 then
				local var_19_27 = (arg_16_1.time_ - var_19_25) / var_19_26
				local var_19_28 = Color.New(0, 0, 0)

				var_19_28.a = Mathf.Lerp(1, 0, var_19_27)
				arg_16_1.mask_.color = var_19_28
			end

			if arg_16_1.time_ >= var_19_25 + var_19_26 and arg_16_1.time_ < var_19_25 + var_19_26 + arg_19_0 then
				local var_19_29 = Color.New(0, 0, 0)
				local var_19_30 = 0

				arg_16_1.mask_.enabled = false
				var_19_29.a = var_19_30
				arg_16_1.mask_.color = var_19_29
			end

			local var_19_31 = "S0809"

			if arg_16_1.bgs_[var_19_31] == nil then
				local var_19_32 = Object.Instantiate(arg_16_1.paintGo_)

				var_19_32:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_19_31)
				var_19_32.name = var_19_31
				var_19_32.transform.parent = arg_16_1.stage_.transform
				var_19_32.transform.localPosition = Vector3.New(0, 100, 0)
				arg_16_1.bgs_[var_19_31] = var_19_32
			end

			local var_19_33 = 2

			if var_19_33 < arg_16_1.time_ and arg_16_1.time_ <= var_19_33 + arg_19_0 then
				local var_19_34 = manager.ui.mainCamera.transform.localPosition
				local var_19_35 = Vector3.New(0, 0, 10) + Vector3.New(var_19_34.x, var_19_34.y, 0)
				local var_19_36 = arg_16_1.bgs_.S0809

				var_19_36.transform.localPosition = var_19_35
				var_19_36.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_19_37 = var_19_36:GetComponent("SpriteRenderer")

				if var_19_37 and var_19_37.sprite then
					local var_19_38 = (var_19_36.transform.localPosition - var_19_34).z
					local var_19_39 = manager.ui.mainCameraCom_
					local var_19_40 = 2 * var_19_38 * Mathf.Tan(var_19_39.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_19_41 = var_19_40 * var_19_39.aspect
					local var_19_42 = var_19_37.sprite.bounds.size.x
					local var_19_43 = var_19_37.sprite.bounds.size.y
					local var_19_44 = var_19_41 / var_19_42
					local var_19_45 = var_19_40 / var_19_43
					local var_19_46 = var_19_45 < var_19_44 and var_19_44 or var_19_45

					var_19_36.transform.localScale = Vector3.New(var_19_46, var_19_46, 0)
				end

				for iter_19_0, iter_19_1 in pairs(arg_16_1.bgs_) do
					if iter_19_0 ~= "S0809" then
						iter_19_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play108072006 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 108072006
		arg_20_1.duration_ = 3.05

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play108072007(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = 0

			if var_23_0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_0 + arg_23_0 then
				arg_20_1.var_.oldValueTypewriter = arg_20_1.fswtw_.percent

				SetActive(arg_20_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_20_1:ShowNextGo(false)
			end

			local var_23_1 = 13
			local var_23_2 = 0.66
			local var_23_3 = arg_20_1:GetWordFromCfg(108072004)
			local var_23_4 = arg_20_1:FormatText(var_23_3.content)
			local var_23_5, var_23_6 = arg_20_1:GetPercentByPara(var_23_4, 2)

			if var_23_0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_0 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0

				local var_23_7 = var_23_1 <= 0 and var_23_2 or var_23_2 * ((var_23_6 - arg_20_1.typewritterCharCountI18N) / var_23_1)

				if var_23_7 > 0 and var_23_2 < var_23_7 then
					arg_20_1.talkMaxDuration = var_23_7

					if var_23_7 + var_23_0 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_7 + var_23_0
					end
				end
			end

			local var_23_8 = 0.66
			local var_23_9 = math.max(var_23_8, arg_20_1.talkMaxDuration)

			if var_23_0 <= arg_20_1.time_ and arg_20_1.time_ < var_23_0 + var_23_9 then
				local var_23_10 = (arg_20_1.time_ - var_23_0) / var_23_9

				arg_20_1.fswtw_.percent = Mathf.Lerp(arg_20_1.var_.oldValueTypewriter, var_23_5, var_23_10)
				arg_20_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_20_1.fswtw_:SetDirty()
			end

			if arg_20_1.time_ >= var_23_0 + var_23_9 and arg_20_1.time_ < var_23_0 + var_23_9 + arg_23_0 then
				arg_20_1.fswtw_.percent = var_23_5

				arg_20_1.fswtw_:SetDirty()
				arg_20_1:ShowNextGo(true)

				arg_20_1.typewritterCharCountI18N = var_23_6
			end

			local var_23_11 = 0
			local var_23_12 = 3.053
			local var_23_13 = manager.audio:GetVoiceLength("story_v_out_108072", "108072006", "story_v_out_108072.awb") / 1000

			if var_23_13 > 0 and var_23_12 < var_23_13 and var_23_13 + var_23_11 > arg_20_1.duration_ then
				local var_23_14 = var_23_13

				arg_20_1.duration_ = var_23_13 + var_23_11
			end

			if var_23_11 < arg_20_1.time_ and arg_20_1.time_ <= var_23_11 + arg_23_0 then
				local var_23_15 = "play"
				local var_23_16 = "voice"

				arg_20_1:AudioAction(var_23_15, var_23_16, "story_v_out_108072", "108072006", "story_v_out_108072.awb")
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play108072007 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 108072007
		arg_24_1.duration_ = 8.4

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play108072008(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = 0

			if var_27_0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_0 + arg_27_0 then
				arg_24_1.var_.oldValueTypewriter = arg_24_1.fswtw_.percent

				SetActive(arg_24_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_24_1:ShowNextGo(false)
			end

			local var_27_1 = 40
			local var_27_2 = 2.28
			local var_27_3 = arg_24_1:GetWordFromCfg(108072004)
			local var_27_4 = arg_24_1:FormatText(var_27_3.content)
			local var_27_5, var_27_6 = arg_24_1:GetPercentByPara(var_27_4, 3)

			if var_27_0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_0 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0

				local var_27_7 = var_27_1 <= 0 and var_27_2 or var_27_2 * ((var_27_6 - arg_24_1.typewritterCharCountI18N) / var_27_1)

				if var_27_7 > 0 and var_27_2 < var_27_7 then
					arg_24_1.talkMaxDuration = var_27_7

					if var_27_7 + var_27_0 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_7 + var_27_0
					end
				end
			end

			local var_27_8 = 2.28
			local var_27_9 = math.max(var_27_8, arg_24_1.talkMaxDuration)

			if var_27_0 <= arg_24_1.time_ and arg_24_1.time_ < var_27_0 + var_27_9 then
				local var_27_10 = (arg_24_1.time_ - var_27_0) / var_27_9

				arg_24_1.fswtw_.percent = Mathf.Lerp(arg_24_1.var_.oldValueTypewriter, var_27_5, var_27_10)
				arg_24_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_24_1.fswtw_:SetDirty()
			end

			if arg_24_1.time_ >= var_27_0 + var_27_9 and arg_24_1.time_ < var_27_0 + var_27_9 + arg_27_0 then
				arg_24_1.fswtw_.percent = var_27_5

				arg_24_1.fswtw_:SetDirty()
				arg_24_1:ShowNextGo(true)

				arg_24_1.typewritterCharCountI18N = var_27_6
			end

			local var_27_11 = 0
			local var_27_12 = 8.396
			local var_27_13 = manager.audio:GetVoiceLength("story_v_out_108072", "108072007", "story_v_out_108072.awb") / 1000

			if var_27_13 > 0 and var_27_12 < var_27_13 and var_27_13 + var_27_11 > arg_24_1.duration_ then
				local var_27_14 = var_27_13

				arg_24_1.duration_ = var_27_13 + var_27_11
			end

			if var_27_11 < arg_24_1.time_ and arg_24_1.time_ <= var_27_11 + arg_27_0 then
				local var_27_15 = "play"
				local var_27_16 = "voice"

				arg_24_1:AudioAction(var_27_15, var_27_16, "story_v_out_108072", "108072007", "story_v_out_108072.awb")
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play108072008 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 108072008
		arg_28_1.duration_ = 5.87

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play108072009(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = 0

			if var_31_0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_0 + arg_31_0 then
				arg_28_1.var_.oldValueTypewriter = arg_28_1.fswtw_.percent

				SetActive(arg_28_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_28_1:ShowNextGo(false)
			end

			local var_31_1 = 26
			local var_31_2 = 1.5
			local var_31_3 = arg_28_1:GetWordFromCfg(108072004)
			local var_31_4 = arg_28_1:FormatText(var_31_3.content)
			local var_31_5, var_31_6 = arg_28_1:GetPercentByPara(var_31_4, 4)

			if var_31_0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_0 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0

				local var_31_7 = var_31_1 <= 0 and var_31_2 or var_31_2 * ((var_31_6 - arg_28_1.typewritterCharCountI18N) / var_31_1)

				if var_31_7 > 0 and var_31_2 < var_31_7 then
					arg_28_1.talkMaxDuration = var_31_7

					if var_31_7 + var_31_0 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_7 + var_31_0
					end
				end
			end

			local var_31_8 = 1.5
			local var_31_9 = math.max(var_31_8, arg_28_1.talkMaxDuration)

			if var_31_0 <= arg_28_1.time_ and arg_28_1.time_ < var_31_0 + var_31_9 then
				local var_31_10 = (arg_28_1.time_ - var_31_0) / var_31_9

				arg_28_1.fswtw_.percent = Mathf.Lerp(arg_28_1.var_.oldValueTypewriter, var_31_5, var_31_10)
				arg_28_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_28_1.fswtw_:SetDirty()
			end

			if arg_28_1.time_ >= var_31_0 + var_31_9 and arg_28_1.time_ < var_31_0 + var_31_9 + arg_31_0 then
				arg_28_1.fswtw_.percent = var_31_5

				arg_28_1.fswtw_:SetDirty()
				arg_28_1:ShowNextGo(true)

				arg_28_1.typewritterCharCountI18N = var_31_6
			end

			local var_31_11 = 0
			local var_31_12 = 5.866
			local var_31_13 = manager.audio:GetVoiceLength("story_v_out_108072", "108072008", "story_v_out_108072.awb") / 1000

			if var_31_13 > 0 and var_31_12 < var_31_13 and var_31_13 + var_31_11 > arg_28_1.duration_ then
				local var_31_14 = var_31_13

				arg_28_1.duration_ = var_31_13 + var_31_11
			end

			if var_31_11 < arg_28_1.time_ and arg_28_1.time_ <= var_31_11 + arg_31_0 then
				local var_31_15 = "play"
				local var_31_16 = "voice"

				arg_28_1:AudioAction(var_31_15, var_31_16, "story_v_out_108072", "108072008", "story_v_out_108072.awb")
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play108072009 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 108072009
		arg_32_1.duration_ = 2.6

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play108072010(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = 0

			if var_35_0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_0 + arg_35_0 then
				arg_32_1.var_.oldValueTypewriter = arg_32_1.fswtw_.percent

				SetActive(arg_32_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_32_1:ShowNextGo(false)
			end

			local var_35_1 = 15
			local var_35_2 = 0.72
			local var_35_3 = arg_32_1:GetWordFromCfg(108072004)
			local var_35_4 = arg_32_1:FormatText(var_35_3.content)
			local var_35_5, var_35_6 = arg_32_1:GetPercentByPara(var_35_4, 5)

			if var_35_0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_0 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0

				local var_35_7 = var_35_1 <= 0 and var_35_2 or var_35_2 * ((var_35_6 - arg_32_1.typewritterCharCountI18N) / var_35_1)

				if var_35_7 > 0 and var_35_2 < var_35_7 then
					arg_32_1.talkMaxDuration = var_35_7

					if var_35_7 + var_35_0 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_7 + var_35_0
					end
				end
			end

			local var_35_8 = 0.72
			local var_35_9 = math.max(var_35_8, arg_32_1.talkMaxDuration)

			if var_35_0 <= arg_32_1.time_ and arg_32_1.time_ < var_35_0 + var_35_9 then
				local var_35_10 = (arg_32_1.time_ - var_35_0) / var_35_9

				arg_32_1.fswtw_.percent = Mathf.Lerp(arg_32_1.var_.oldValueTypewriter, var_35_5, var_35_10)
				arg_32_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_32_1.fswtw_:SetDirty()
			end

			if arg_32_1.time_ >= var_35_0 + var_35_9 and arg_32_1.time_ < var_35_0 + var_35_9 + arg_35_0 then
				arg_32_1.fswtw_.percent = var_35_5

				arg_32_1.fswtw_:SetDirty()
				arg_32_1:ShowNextGo(true)

				arg_32_1.typewritterCharCountI18N = var_35_6
			end

			local var_35_11 = 0
			local var_35_12 = 2.598
			local var_35_13 = manager.audio:GetVoiceLength("story_v_out_108072", "108072009", "story_v_out_108072.awb") / 1000

			if var_35_13 > 0 and var_35_12 < var_35_13 and var_35_13 + var_35_11 > arg_32_1.duration_ then
				local var_35_14 = var_35_13

				arg_32_1.duration_ = var_35_13 + var_35_11
			end

			if var_35_11 < arg_32_1.time_ and arg_32_1.time_ <= var_35_11 + arg_35_0 then
				local var_35_15 = "play"
				local var_35_16 = "voice"

				arg_32_1:AudioAction(var_35_15, var_35_16, "story_v_out_108072", "108072009", "story_v_out_108072.awb")
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play108072010 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 108072010
		arg_36_1.duration_ = 13.99

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play108072011(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = 0

			if var_39_0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_0 + arg_39_0 then
				arg_36_1.var_.oldValueTypewriter = arg_36_1.fswtw_.percent

				SetActive(arg_36_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_36_1:ShowNextGo(false)
			end

			local var_39_1 = 51
			local var_39_2 = 2.28
			local var_39_3 = arg_36_1:GetWordFromCfg(108072004)
			local var_39_4 = arg_36_1:FormatText(var_39_3.content)
			local var_39_5, var_39_6 = arg_36_1:GetPercentByPara(var_39_4, 6)

			if var_39_0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_0 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0

				local var_39_7 = var_39_1 <= 0 and var_39_2 or var_39_2 * ((var_39_6 - arg_36_1.typewritterCharCountI18N) / var_39_1)

				if var_39_7 > 0 and var_39_2 < var_39_7 then
					arg_36_1.talkMaxDuration = var_39_7

					if var_39_7 + var_39_0 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_7 + var_39_0
					end
				end
			end

			local var_39_8 = 2.28
			local var_39_9 = math.max(var_39_8, arg_36_1.talkMaxDuration)

			if var_39_0 <= arg_36_1.time_ and arg_36_1.time_ < var_39_0 + var_39_9 then
				local var_39_10 = (arg_36_1.time_ - var_39_0) / var_39_9

				arg_36_1.fswtw_.percent = Mathf.Lerp(arg_36_1.var_.oldValueTypewriter, var_39_5, var_39_10)
				arg_36_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_36_1.fswtw_:SetDirty()
			end

			if arg_36_1.time_ >= var_39_0 + var_39_9 and arg_36_1.time_ < var_39_0 + var_39_9 + arg_39_0 then
				arg_36_1.fswtw_.percent = var_39_5

				arg_36_1.fswtw_:SetDirty()
				arg_36_1:ShowNextGo(true)

				arg_36_1.typewritterCharCountI18N = var_39_6
			end

			local var_39_11 = 0
			local var_39_12 = 13.991
			local var_39_13 = manager.audio:GetVoiceLength("story_v_out_108072", "108072010", "story_v_out_108072.awb") / 1000

			if var_39_13 > 0 and var_39_12 < var_39_13 and var_39_13 + var_39_11 > arg_36_1.duration_ then
				local var_39_14 = var_39_13

				arg_36_1.duration_ = var_39_13 + var_39_11
			end

			if var_39_11 < arg_36_1.time_ and arg_36_1.time_ <= var_39_11 + arg_39_0 then
				local var_39_15 = "play"
				local var_39_16 = "voice"

				arg_36_1:AudioAction(var_39_15, var_39_16, "story_v_out_108072", "108072010", "story_v_out_108072.awb")
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play108072011 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 108072011
		arg_40_1.duration_ = 7.98

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play108072013(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = 0

			if var_43_0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_0 + arg_43_0 then
				arg_40_1.fswbg_:SetActive(true)
				arg_40_1.dialog_:SetActive(false)

				arg_40_1.fswtw_.percent = 0

				local var_43_1 = arg_40_1:GetWordFromCfg(108072011)
				local var_43_2 = arg_40_1:FormatText(var_43_1.content)

				arg_40_1.fswt_.text = var_43_2

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.fswt_)

				arg_40_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_40_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_40_1.fswtw_:SetDirty()

				arg_40_1.typewritterCharCountI18N = 0

				SetActive(arg_40_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_40_1:ShowNextGo(false)
			end

			local var_43_3 = 0.0166666666666667

			if var_43_3 < arg_40_1.time_ and arg_40_1.time_ <= var_43_3 + arg_43_0 then
				arg_40_1.var_.oldValueTypewriter = arg_40_1.fswtw_.percent

				SetActive(arg_40_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_40_1:ShowNextGo(false)
			end

			local var_43_4 = 28
			local var_43_5 = 1.5
			local var_43_6 = arg_40_1:GetWordFromCfg(108072011)
			local var_43_7 = arg_40_1:FormatText(var_43_6.content)
			local var_43_8, var_43_9 = arg_40_1:GetPercentByPara(var_43_7, 1)

			if var_43_3 < arg_40_1.time_ and arg_40_1.time_ <= var_43_3 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0

				local var_43_10 = var_43_4 <= 0 and var_43_5 or var_43_5 * ((var_43_9 - arg_40_1.typewritterCharCountI18N) / var_43_4)

				if var_43_10 > 0 and var_43_5 < var_43_10 then
					arg_40_1.talkMaxDuration = var_43_10

					if var_43_10 + var_43_3 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_10 + var_43_3
					end
				end
			end

			local var_43_11 = 1.5
			local var_43_12 = math.max(var_43_11, arg_40_1.talkMaxDuration)

			if var_43_3 <= arg_40_1.time_ and arg_40_1.time_ < var_43_3 + var_43_12 then
				local var_43_13 = (arg_40_1.time_ - var_43_3) / var_43_12

				arg_40_1.fswtw_.percent = Mathf.Lerp(arg_40_1.var_.oldValueTypewriter, var_43_8, var_43_13)
				arg_40_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_40_1.fswtw_:SetDirty()
			end

			if arg_40_1.time_ >= var_43_3 + var_43_12 and arg_40_1.time_ < var_43_3 + var_43_12 + arg_43_0 then
				arg_40_1.fswtw_.percent = var_43_8

				arg_40_1.fswtw_:SetDirty()
				arg_40_1:ShowNextGo(true)

				arg_40_1.typewritterCharCountI18N = var_43_9
			end

			local var_43_14 = 0
			local var_43_15 = 7.977
			local var_43_16 = manager.audio:GetVoiceLength("story_v_out_108072", "108072011", "story_v_out_108072.awb") / 1000

			if var_43_16 > 0 and var_43_15 < var_43_16 and var_43_16 + var_43_14 > arg_40_1.duration_ then
				local var_43_17 = var_43_16

				arg_40_1.duration_ = var_43_16 + var_43_14
			end

			if var_43_14 < arg_40_1.time_ and arg_40_1.time_ <= var_43_14 + arg_43_0 then
				local var_43_18 = "play"
				local var_43_19 = "voice"

				arg_40_1:AudioAction(var_43_18, var_43_19, "story_v_out_108072", "108072011", "story_v_out_108072.awb")
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play108072013 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 108072013
		arg_44_1.duration_ = 14.42

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play108072014(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = 0

			if var_47_0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_0 + arg_47_0 then
				arg_44_1.var_.oldValueTypewriter = arg_44_1.fswtw_.percent

				SetActive(arg_44_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_44_1:ShowNextGo(false)
			end

			local var_47_1 = 40
			local var_47_2 = 2.22
			local var_47_3 = arg_44_1:GetWordFromCfg(108072011)
			local var_47_4 = arg_44_1:FormatText(var_47_3.content)
			local var_47_5, var_47_6 = arg_44_1:GetPercentByPara(var_47_4, 2)

			if var_47_0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_0 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0

				local var_47_7 = var_47_1 <= 0 and var_47_2 or var_47_2 * ((var_47_6 - arg_44_1.typewritterCharCountI18N) / var_47_1)

				if var_47_7 > 0 and var_47_2 < var_47_7 then
					arg_44_1.talkMaxDuration = var_47_7

					if var_47_7 + var_47_0 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_7 + var_47_0
					end
				end
			end

			local var_47_8 = 2.22
			local var_47_9 = math.max(var_47_8, arg_44_1.talkMaxDuration)

			if var_47_0 <= arg_44_1.time_ and arg_44_1.time_ < var_47_0 + var_47_9 then
				local var_47_10 = (arg_44_1.time_ - var_47_0) / var_47_9

				arg_44_1.fswtw_.percent = Mathf.Lerp(arg_44_1.var_.oldValueTypewriter, var_47_5, var_47_10)
				arg_44_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_44_1.fswtw_:SetDirty()
			end

			if arg_44_1.time_ >= var_47_0 + var_47_9 and arg_44_1.time_ < var_47_0 + var_47_9 + arg_47_0 then
				arg_44_1.fswtw_.percent = var_47_5

				arg_44_1.fswtw_:SetDirty()
				arg_44_1:ShowNextGo(true)

				arg_44_1.typewritterCharCountI18N = var_47_6
			end

			local var_47_11 = 0
			local var_47_12 = 14.425
			local var_47_13 = manager.audio:GetVoiceLength("story_v_out_108072", "108072013", "story_v_out_108072.awb") / 1000

			if var_47_13 > 0 and var_47_12 < var_47_13 and var_47_13 + var_47_11 > arg_44_1.duration_ then
				local var_47_14 = var_47_13

				arg_44_1.duration_ = var_47_13 + var_47_11
			end

			if var_47_11 < arg_44_1.time_ and arg_44_1.time_ <= var_47_11 + arg_47_0 then
				local var_47_15 = "play"
				local var_47_16 = "voice"

				arg_44_1:AudioAction(var_47_15, var_47_16, "story_v_out_108072", "108072013", "story_v_out_108072.awb")
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play108072014 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 108072014
		arg_48_1.duration_ = 5.56

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play108072015(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = 0

			if var_51_0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_0 + arg_51_0 then
				arg_48_1.var_.oldValueTypewriter = arg_48_1.fswtw_.percent

				SetActive(arg_48_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_48_1:ShowNextGo(false)
			end

			local var_51_1 = 20
			local var_51_2 = 1.08
			local var_51_3 = arg_48_1:GetWordFromCfg(108072011)
			local var_51_4 = arg_48_1:FormatText(var_51_3.content)
			local var_51_5, var_51_6 = arg_48_1:GetPercentByPara(var_51_4, 3)

			if var_51_0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_0 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0

				local var_51_7 = var_51_1 <= 0 and var_51_2 or var_51_2 * ((var_51_6 - arg_48_1.typewritterCharCountI18N) / var_51_1)

				if var_51_7 > 0 and var_51_2 < var_51_7 then
					arg_48_1.talkMaxDuration = var_51_7

					if var_51_7 + var_51_0 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_7 + var_51_0
					end
				end
			end

			local var_51_8 = 1.08
			local var_51_9 = math.max(var_51_8, arg_48_1.talkMaxDuration)

			if var_51_0 <= arg_48_1.time_ and arg_48_1.time_ < var_51_0 + var_51_9 then
				local var_51_10 = (arg_48_1.time_ - var_51_0) / var_51_9

				arg_48_1.fswtw_.percent = Mathf.Lerp(arg_48_1.var_.oldValueTypewriter, var_51_5, var_51_10)
				arg_48_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_48_1.fswtw_:SetDirty()
			end

			if arg_48_1.time_ >= var_51_0 + var_51_9 and arg_48_1.time_ < var_51_0 + var_51_9 + arg_51_0 then
				arg_48_1.fswtw_.percent = var_51_5

				arg_48_1.fswtw_:SetDirty()
				arg_48_1:ShowNextGo(true)

				arg_48_1.typewritterCharCountI18N = var_51_6
			end

			local var_51_11 = 0
			local var_51_12 = 5.56
			local var_51_13 = manager.audio:GetVoiceLength("story_v_out_108072", "108072014", "story_v_out_108072.awb") / 1000

			if var_51_13 > 0 and var_51_12 < var_51_13 and var_51_13 + var_51_11 > arg_48_1.duration_ then
				local var_51_14 = var_51_13

				arg_48_1.duration_ = var_51_13 + var_51_11
			end

			if var_51_11 < arg_48_1.time_ and arg_48_1.time_ <= var_51_11 + arg_51_0 then
				local var_51_15 = "play"
				local var_51_16 = "voice"

				arg_48_1:AudioAction(var_51_15, var_51_16, "story_v_out_108072", "108072014", "story_v_out_108072.awb")
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play108072015 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 108072015
		arg_52_1.duration_ = 10.19

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play108072017(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = 0

			if var_55_0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_0 + arg_55_0 then
				arg_52_1.var_.oldValueTypewriter = arg_52_1.fswtw_.percent

				SetActive(arg_52_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_52_1:ShowNextGo(false)
			end

			local var_55_1 = 30
			local var_55_2 = 1.68
			local var_55_3 = arg_52_1:GetWordFromCfg(108072011)
			local var_55_4 = arg_52_1:FormatText(var_55_3.content)
			local var_55_5, var_55_6 = arg_52_1:GetPercentByPara(var_55_4, 4)

			if var_55_0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_0 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0

				local var_55_7 = var_55_1 <= 0 and var_55_2 or var_55_2 * ((var_55_6 - arg_52_1.typewritterCharCountI18N) / var_55_1)

				if var_55_7 > 0 and var_55_2 < var_55_7 then
					arg_52_1.talkMaxDuration = var_55_7

					if var_55_7 + var_55_0 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_7 + var_55_0
					end
				end
			end

			local var_55_8 = 1.68
			local var_55_9 = math.max(var_55_8, arg_52_1.talkMaxDuration)

			if var_55_0 <= arg_52_1.time_ and arg_52_1.time_ < var_55_0 + var_55_9 then
				local var_55_10 = (arg_52_1.time_ - var_55_0) / var_55_9

				arg_52_1.fswtw_.percent = Mathf.Lerp(arg_52_1.var_.oldValueTypewriter, var_55_5, var_55_10)
				arg_52_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_52_1.fswtw_:SetDirty()
			end

			if arg_52_1.time_ >= var_55_0 + var_55_9 and arg_52_1.time_ < var_55_0 + var_55_9 + arg_55_0 then
				arg_52_1.fswtw_.percent = var_55_5

				arg_52_1.fswtw_:SetDirty()
				arg_52_1:ShowNextGo(true)

				arg_52_1.typewritterCharCountI18N = var_55_6
			end

			local var_55_11 = 0
			local var_55_12 = 10.19
			local var_55_13 = manager.audio:GetVoiceLength("story_v_out_108072", "108072015", "story_v_out_108072.awb") / 1000

			if var_55_13 > 0 and var_55_12 < var_55_13 and var_55_13 + var_55_11 > arg_52_1.duration_ then
				local var_55_14 = var_55_13

				arg_52_1.duration_ = var_55_13 + var_55_11
			end

			if var_55_11 < arg_52_1.time_ and arg_52_1.time_ <= var_55_11 + arg_55_0 then
				local var_55_15 = "play"
				local var_55_16 = "voice"

				arg_52_1:AudioAction(var_55_15, var_55_16, "story_v_out_108072", "108072015", "story_v_out_108072.awb")
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play108072017 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 108072017
		arg_56_1.duration_ = 12.87

		local var_56_0 = {
			ja = 11.266,
			ko = 8.633,
			zh = 9.766,
			en = 12.866
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
				arg_56_0:Play108072018(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = 2

			if var_59_0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_0 + arg_59_0 then
				local var_59_1 = manager.ui.mainCamera.transform.localPosition
				local var_59_2 = Vector3.New(0, 0, 10) + Vector3.New(var_59_1.x, var_59_1.y, 0)
				local var_59_3 = arg_56_1.bgs_.S0804

				var_59_3.transform.localPosition = var_59_2
				var_59_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_59_4 = var_59_3:GetComponent("SpriteRenderer")

				if var_59_4 and var_59_4.sprite then
					local var_59_5 = (var_59_3.transform.localPosition - var_59_1).z
					local var_59_6 = manager.ui.mainCameraCom_
					local var_59_7 = 2 * var_59_5 * Mathf.Tan(var_59_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_59_8 = var_59_7 * var_59_6.aspect
					local var_59_9 = var_59_4.sprite.bounds.size.x
					local var_59_10 = var_59_4.sprite.bounds.size.y
					local var_59_11 = var_59_8 / var_59_9
					local var_59_12 = var_59_7 / var_59_10
					local var_59_13 = var_59_12 < var_59_11 and var_59_11 or var_59_12

					var_59_3.transform.localScale = Vector3.New(var_59_13, var_59_13, 0)
				end

				for iter_59_0, iter_59_1 in pairs(arg_56_1.bgs_) do
					if iter_59_0 ~= "S0804" then
						iter_59_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_59_14 = 0

			if var_59_14 < arg_56_1.time_ and arg_56_1.time_ <= var_59_14 + arg_59_0 then
				arg_56_1.fswbg_:SetActive(false)
				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_56_1:ShowNextGo(false)
			end

			local var_59_15 = 0

			if var_59_15 < arg_56_1.time_ and arg_56_1.time_ <= var_59_15 + arg_59_0 then
				arg_56_1.mask_.enabled = true
				arg_56_1.mask_.raycastTarget = true

				arg_56_1:SetGaussion(false)
			end

			local var_59_16 = 2

			if var_59_15 <= arg_56_1.time_ and arg_56_1.time_ < var_59_15 + var_59_16 then
				local var_59_17 = (arg_56_1.time_ - var_59_15) / var_59_16
				local var_59_18 = Color.New(0, 0, 0)

				var_59_18.a = Mathf.Lerp(0, 1, var_59_17)
				arg_56_1.mask_.color = var_59_18
			end

			if arg_56_1.time_ >= var_59_15 + var_59_16 and arg_56_1.time_ < var_59_15 + var_59_16 + arg_59_0 then
				local var_59_19 = Color.New(0, 0, 0)

				var_59_19.a = 1
				arg_56_1.mask_.color = var_59_19
			end

			local var_59_20 = 2

			if var_59_20 < arg_56_1.time_ and arg_56_1.time_ <= var_59_20 + arg_59_0 then
				arg_56_1.mask_.enabled = true
				arg_56_1.mask_.raycastTarget = true

				arg_56_1:SetGaussion(false)
			end

			local var_59_21 = 2

			if var_59_20 <= arg_56_1.time_ and arg_56_1.time_ < var_59_20 + var_59_21 then
				local var_59_22 = (arg_56_1.time_ - var_59_20) / var_59_21
				local var_59_23 = Color.New(0, 0, 0)

				var_59_23.a = Mathf.Lerp(1, 0, var_59_22)
				arg_56_1.mask_.color = var_59_23
			end

			if arg_56_1.time_ >= var_59_20 + var_59_21 and arg_56_1.time_ < var_59_20 + var_59_21 + arg_59_0 then
				local var_59_24 = Color.New(0, 0, 0)
				local var_59_25 = 0

				arg_56_1.mask_.enabled = false
				var_59_24.a = var_59_25
				arg_56_1.mask_.color = var_59_24
			end

			if arg_56_1.frameCnt_ <= 1 then
				arg_56_1.dialog_:SetActive(false)
			end

			local var_59_26 = 4
			local var_59_27 = 0.225

			if var_59_26 < arg_56_1.time_ and arg_56_1.time_ <= var_59_26 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0

				arg_56_1.dialog_:SetActive(true)

				arg_56_1.dialogCg_.alpha = 0

				local var_59_28 = LeanTween.value(arg_56_1.dialog_, 0, 1, 0.3)

				var_59_28:setOnUpdate(LuaHelper.FloatAction(function(arg_60_0)
					arg_56_1.dialogCg_.alpha = arg_60_0
				end))
				var_59_28:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_56_1.dialog_)
					var_59_28:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_56_1.duration_ = arg_56_1.duration_ + 0.3

				SetActive(arg_56_1.leftNameGo_, true)

				local var_59_29 = arg_56_1:FormatText(StoryNameCfg[96].name)

				arg_56_1.leftNameTxt_.text = var_59_29

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_30 = arg_56_1:GetWordFromCfg(108072017)
				local var_59_31 = arg_56_1:FormatText(var_59_30.content)

				arg_56_1.text_.text = var_59_31

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_32 = 9
				local var_59_33 = utf8.len(var_59_31)
				local var_59_34 = var_59_32 <= 0 and var_59_27 or var_59_27 * (var_59_33 / var_59_32)

				if var_59_34 > 0 and var_59_27 < var_59_34 then
					arg_56_1.talkMaxDuration = var_59_34
					var_59_26 = var_59_26 + 0.3

					if var_59_34 + var_59_26 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_34 + var_59_26
					end
				end

				arg_56_1.text_.text = var_59_31
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108072", "108072017", "story_v_out_108072.awb") ~= 0 then
					local var_59_35 = manager.audio:GetVoiceLength("story_v_out_108072", "108072017", "story_v_out_108072.awb") / 1000

					if var_59_35 + var_59_26 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_35 + var_59_26
					end

					if var_59_30.prefab_name ~= "" and arg_56_1.actors_[var_59_30.prefab_name] ~= nil then
						local var_59_36 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_30.prefab_name].transform, "story_v_out_108072", "108072017", "story_v_out_108072.awb")

						arg_56_1:RecordAudio("108072017", var_59_36)
						arg_56_1:RecordAudio("108072017", var_59_36)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_108072", "108072017", "story_v_out_108072.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_108072", "108072017", "story_v_out_108072.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_37 = var_59_26 + 0.3
			local var_59_38 = math.max(var_59_27, arg_56_1.talkMaxDuration)

			if var_59_37 <= arg_56_1.time_ and arg_56_1.time_ < var_59_37 + var_59_38 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_37) / var_59_38

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_37 + var_59_38 and arg_56_1.time_ < var_59_37 + var_59_38 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play108072018 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 108072018
		arg_62_1.duration_ = 10.07

		local var_62_0 = {
			ja = 10.066,
			ko = 6.8,
			zh = 6.5,
			en = 7.6
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
				arg_62_0:Play108072019(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			local var_65_0 = 0
			local var_65_1 = 0.65

			if var_65_0 < arg_62_1.time_ and arg_62_1.time_ <= var_65_0 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, true)

				local var_65_2 = arg_62_1:FormatText(StoryNameCfg[96].name)

				arg_62_1.leftNameTxt_.text = var_65_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_62_1.leftNameTxt_.transform)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1.leftNameTxt_.text)
				SetActive(arg_62_1.iconTrs_.gameObject, false)
				arg_62_1.callingController_:SetSelectedState("normal")

				local var_65_3 = arg_62_1:GetWordFromCfg(108072018)
				local var_65_4 = arg_62_1:FormatText(var_65_3.content)

				arg_62_1.text_.text = var_65_4

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_5 = 18
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

				if manager.audio:GetVoiceLength("story_v_out_108072", "108072018", "story_v_out_108072.awb") ~= 0 then
					local var_65_8 = manager.audio:GetVoiceLength("story_v_out_108072", "108072018", "story_v_out_108072.awb") / 1000

					if var_65_8 + var_65_0 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_8 + var_65_0
					end

					if var_65_3.prefab_name ~= "" and arg_62_1.actors_[var_65_3.prefab_name] ~= nil then
						local var_65_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_62_1.actors_[var_65_3.prefab_name].transform, "story_v_out_108072", "108072018", "story_v_out_108072.awb")

						arg_62_1:RecordAudio("108072018", var_65_9)
						arg_62_1:RecordAudio("108072018", var_65_9)
					else
						arg_62_1:AudioAction("play", "voice", "story_v_out_108072", "108072018", "story_v_out_108072.awb")
					end

					arg_62_1:RecordHistoryTalkVoice("story_v_out_108072", "108072018", "story_v_out_108072.awb")
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
	Play108072019 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 108072019
		arg_66_1.duration_ = 6.33

		local var_66_0 = {
			ja = 5,
			ko = 5.5,
			zh = 6.333,
			en = 6.2
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
				arg_66_0:Play108072020(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			local var_69_0 = 0
			local var_69_1 = 0.55

			if var_69_0 < arg_66_1.time_ and arg_66_1.time_ <= var_69_0 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				local var_69_2 = arg_66_1:FormatText(StoryNameCfg[74].name)

				arg_66_1.leftNameTxt_.text = var_69_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, true)
				arg_66_1.iconController_:SetSelectedState("hero")

				arg_66_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1050")

				arg_66_1.callingController_:SetSelectedState("normal")

				arg_66_1.keyicon_.color = Color.New(1, 1, 1)
				arg_66_1.icon_.color = Color.New(1, 1, 1)

				local var_69_3 = arg_66_1:GetWordFromCfg(108072019)
				local var_69_4 = arg_66_1:FormatText(var_69_3.content)

				arg_66_1.text_.text = var_69_4

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_5 = 22
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

				if manager.audio:GetVoiceLength("story_v_out_108072", "108072019", "story_v_out_108072.awb") ~= 0 then
					local var_69_8 = manager.audio:GetVoiceLength("story_v_out_108072", "108072019", "story_v_out_108072.awb") / 1000

					if var_69_8 + var_69_0 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_8 + var_69_0
					end

					if var_69_3.prefab_name ~= "" and arg_66_1.actors_[var_69_3.prefab_name] ~= nil then
						local var_69_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_66_1.actors_[var_69_3.prefab_name].transform, "story_v_out_108072", "108072019", "story_v_out_108072.awb")

						arg_66_1:RecordAudio("108072019", var_69_9)
						arg_66_1:RecordAudio("108072019", var_69_9)
					else
						arg_66_1:AudioAction("play", "voice", "story_v_out_108072", "108072019", "story_v_out_108072.awb")
					end

					arg_66_1:RecordHistoryTalkVoice("story_v_out_108072", "108072019", "story_v_out_108072.awb")
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
	Play108072020 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 108072020
		arg_70_1.duration_ = 3.37

		local var_70_0 = {
			ja = 2.9,
			ko = 2.9,
			zh = 3.2,
			en = 3.366
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
				arg_70_0:Play108072021(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			local var_73_0 = 0
			local var_73_1 = 0.25

			if var_73_0 < arg_70_1.time_ and arg_70_1.time_ <= var_73_0 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, true)

				local var_73_2 = arg_70_1:FormatText(StoryNameCfg[84].name)

				arg_70_1.leftNameTxt_.text = var_73_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_70_1.leftNameTxt_.transform)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1.leftNameTxt_.text)
				SetActive(arg_70_1.iconTrs_.gameObject, true)
				arg_70_1.iconController_:SetSelectedState("hero")

				arg_70_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1099")

				arg_70_1.callingController_:SetSelectedState("normal")

				arg_70_1.keyicon_.color = Color.New(1, 1, 1)
				arg_70_1.icon_.color = Color.New(1, 1, 1)

				local var_73_3 = arg_70_1:GetWordFromCfg(108072020)
				local var_73_4 = arg_70_1:FormatText(var_73_3.content)

				arg_70_1.text_.text = var_73_4

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_5 = 10
				local var_73_6 = utf8.len(var_73_4)
				local var_73_7 = var_73_5 <= 0 and var_73_1 or var_73_1 * (var_73_6 / var_73_5)

				if var_73_7 > 0 and var_73_1 < var_73_7 then
					arg_70_1.talkMaxDuration = var_73_7

					if var_73_7 + var_73_0 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_7 + var_73_0
					end
				end

				arg_70_1.text_.text = var_73_4
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108072", "108072020", "story_v_out_108072.awb") ~= 0 then
					local var_73_8 = manager.audio:GetVoiceLength("story_v_out_108072", "108072020", "story_v_out_108072.awb") / 1000

					if var_73_8 + var_73_0 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_8 + var_73_0
					end

					if var_73_3.prefab_name ~= "" and arg_70_1.actors_[var_73_3.prefab_name] ~= nil then
						local var_73_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_70_1.actors_[var_73_3.prefab_name].transform, "story_v_out_108072", "108072020", "story_v_out_108072.awb")

						arg_70_1:RecordAudio("108072020", var_73_9)
						arg_70_1:RecordAudio("108072020", var_73_9)
					else
						arg_70_1:AudioAction("play", "voice", "story_v_out_108072", "108072020", "story_v_out_108072.awb")
					end

					arg_70_1:RecordHistoryTalkVoice("story_v_out_108072", "108072020", "story_v_out_108072.awb")
				end

				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_10 = math.max(var_73_1, arg_70_1.talkMaxDuration)

			if var_73_0 <= arg_70_1.time_ and arg_70_1.time_ < var_73_0 + var_73_10 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_0) / var_73_10

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_0 + var_73_10 and arg_70_1.time_ < var_73_0 + var_73_10 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {}

		arg_70_1:InitPlayNodeList()
	end,
	Play108072021 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 108072021
		arg_74_1.duration_ = 9.8

		local var_74_0 = {
			ja = 8.866,
			ko = 6.5,
			zh = 9.8,
			en = 7
		}
		local var_74_1 = manager.audio:GetLocalizationFlag()

		if var_74_0[var_74_1] ~= nil then
			arg_74_1.duration_ = var_74_0[var_74_1]
		end

		SetActive(arg_74_1.tipsGo_, false)

		function arg_74_1.onSingleLineFinish_()
			arg_74_1.onSingleLineUpdate_ = nil
			arg_74_1.onSingleLineFinish_ = nil
			arg_74_1.state_ = "waiting"
		end

		function arg_74_1.playNext_(arg_76_0)
			if arg_76_0 == 1 then
				arg_74_0:Play108072022(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			local var_77_0 = 0
			local var_77_1 = 0.675

			if var_77_0 < arg_74_1.time_ and arg_74_1.time_ <= var_77_0 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, true)

				local var_77_2 = arg_74_1:FormatText(StoryNameCfg[96].name)

				arg_74_1.leftNameTxt_.text = var_77_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_74_1.leftNameTxt_.transform)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1.leftNameTxt_.text)
				SetActive(arg_74_1.iconTrs_.gameObject, false)
				arg_74_1.callingController_:SetSelectedState("normal")

				local var_77_3 = arg_74_1:GetWordFromCfg(108072021)
				local var_77_4 = arg_74_1:FormatText(var_77_3.content)

				arg_74_1.text_.text = var_77_4

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_5 = 27
				local var_77_6 = utf8.len(var_77_4)
				local var_77_7 = var_77_5 <= 0 and var_77_1 or var_77_1 * (var_77_6 / var_77_5)

				if var_77_7 > 0 and var_77_1 < var_77_7 then
					arg_74_1.talkMaxDuration = var_77_7

					if var_77_7 + var_77_0 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_7 + var_77_0
					end
				end

				arg_74_1.text_.text = var_77_4
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108072", "108072021", "story_v_out_108072.awb") ~= 0 then
					local var_77_8 = manager.audio:GetVoiceLength("story_v_out_108072", "108072021", "story_v_out_108072.awb") / 1000

					if var_77_8 + var_77_0 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_8 + var_77_0
					end

					if var_77_3.prefab_name ~= "" and arg_74_1.actors_[var_77_3.prefab_name] ~= nil then
						local var_77_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_74_1.actors_[var_77_3.prefab_name].transform, "story_v_out_108072", "108072021", "story_v_out_108072.awb")

						arg_74_1:RecordAudio("108072021", var_77_9)
						arg_74_1:RecordAudio("108072021", var_77_9)
					else
						arg_74_1:AudioAction("play", "voice", "story_v_out_108072", "108072021", "story_v_out_108072.awb")
					end

					arg_74_1:RecordHistoryTalkVoice("story_v_out_108072", "108072021", "story_v_out_108072.awb")
				end

				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_10 = math.max(var_77_1, arg_74_1.talkMaxDuration)

			if var_77_0 <= arg_74_1.time_ and arg_74_1.time_ < var_77_0 + var_77_10 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_0) / var_77_10

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_0 + var_77_10 and arg_74_1.time_ < var_77_0 + var_77_10 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {}

		arg_74_1:InitPlayNodeList()
	end,
	Play108072022 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 108072022
		arg_78_1.duration_ = 19.3

		local var_78_0 = {
			ja = 19.3,
			ko = 10.333,
			zh = 15.9,
			en = 12.666
		}
		local var_78_1 = manager.audio:GetLocalizationFlag()

		if var_78_0[var_78_1] ~= nil then
			arg_78_1.duration_ = var_78_0[var_78_1]
		end

		SetActive(arg_78_1.tipsGo_, false)

		function arg_78_1.onSingleLineFinish_()
			arg_78_1.onSingleLineUpdate_ = nil
			arg_78_1.onSingleLineFinish_ = nil
			arg_78_1.state_ = "waiting"
		end

		function arg_78_1.playNext_(arg_80_0)
			if arg_80_0 == 1 then
				arg_78_0:Play108072023(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			local var_81_0 = 0
			local var_81_1 = 1.075

			if var_81_0 < arg_78_1.time_ and arg_78_1.time_ <= var_81_0 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, true)

				local var_81_2 = arg_78_1:FormatText(StoryNameCfg[96].name)

				arg_78_1.leftNameTxt_.text = var_81_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_78_1.leftNameTxt_.transform)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1.leftNameTxt_.text)
				SetActive(arg_78_1.iconTrs_.gameObject, false)
				arg_78_1.callingController_:SetSelectedState("normal")

				local var_81_3 = arg_78_1:GetWordFromCfg(108072022)
				local var_81_4 = arg_78_1:FormatText(var_81_3.content)

				arg_78_1.text_.text = var_81_4

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_5 = 39
				local var_81_6 = utf8.len(var_81_4)
				local var_81_7 = var_81_5 <= 0 and var_81_1 or var_81_1 * (var_81_6 / var_81_5)

				if var_81_7 > 0 and var_81_1 < var_81_7 then
					arg_78_1.talkMaxDuration = var_81_7

					if var_81_7 + var_81_0 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_7 + var_81_0
					end
				end

				arg_78_1.text_.text = var_81_4
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108072", "108072022", "story_v_out_108072.awb") ~= 0 then
					local var_81_8 = manager.audio:GetVoiceLength("story_v_out_108072", "108072022", "story_v_out_108072.awb") / 1000

					if var_81_8 + var_81_0 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_8 + var_81_0
					end

					if var_81_3.prefab_name ~= "" and arg_78_1.actors_[var_81_3.prefab_name] ~= nil then
						local var_81_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_78_1.actors_[var_81_3.prefab_name].transform, "story_v_out_108072", "108072022", "story_v_out_108072.awb")

						arg_78_1:RecordAudio("108072022", var_81_9)
						arg_78_1:RecordAudio("108072022", var_81_9)
					else
						arg_78_1:AudioAction("play", "voice", "story_v_out_108072", "108072022", "story_v_out_108072.awb")
					end

					arg_78_1:RecordHistoryTalkVoice("story_v_out_108072", "108072022", "story_v_out_108072.awb")
				end

				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_10 = math.max(var_81_1, arg_78_1.talkMaxDuration)

			if var_81_0 <= arg_78_1.time_ and arg_78_1.time_ < var_81_0 + var_81_10 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_0) / var_81_10

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_0 + var_81_10 and arg_78_1.time_ < var_81_0 + var_81_10 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {}

		arg_78_1:InitPlayNodeList()
	end,
	Play108072023 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 108072023
		arg_82_1.duration_ = 8.73

		local var_82_0 = {
			ja = 8.2,
			ko = 7.4,
			zh = 7.7,
			en = 8.733
		}
		local var_82_1 = manager.audio:GetLocalizationFlag()

		if var_82_0[var_82_1] ~= nil then
			arg_82_1.duration_ = var_82_0[var_82_1]
		end

		SetActive(arg_82_1.tipsGo_, false)

		function arg_82_1.onSingleLineFinish_()
			arg_82_1.onSingleLineUpdate_ = nil
			arg_82_1.onSingleLineFinish_ = nil
			arg_82_1.state_ = "waiting"
		end

		function arg_82_1.playNext_(arg_84_0)
			if arg_84_0 == 1 then
				arg_82_0:Play108072024(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			local var_85_0 = 0
			local var_85_1 = 0.3

			if var_85_0 < arg_82_1.time_ and arg_82_1.time_ <= var_85_0 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				local var_85_2 = arg_82_1:FormatText(StoryNameCfg[96].name)

				arg_82_1.leftNameTxt_.text = var_85_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_3 = arg_82_1:GetWordFromCfg(108072023)
				local var_85_4 = arg_82_1:FormatText(var_85_3.content)

				arg_82_1.text_.text = var_85_4

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_5 = 12
				local var_85_6 = utf8.len(var_85_4)
				local var_85_7 = var_85_5 <= 0 and var_85_1 or var_85_1 * (var_85_6 / var_85_5)

				if var_85_7 > 0 and var_85_1 < var_85_7 then
					arg_82_1.talkMaxDuration = var_85_7

					if var_85_7 + var_85_0 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_7 + var_85_0
					end
				end

				arg_82_1.text_.text = var_85_4
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108072", "108072023", "story_v_out_108072.awb") ~= 0 then
					local var_85_8 = manager.audio:GetVoiceLength("story_v_out_108072", "108072023", "story_v_out_108072.awb") / 1000

					if var_85_8 + var_85_0 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_8 + var_85_0
					end

					if var_85_3.prefab_name ~= "" and arg_82_1.actors_[var_85_3.prefab_name] ~= nil then
						local var_85_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_82_1.actors_[var_85_3.prefab_name].transform, "story_v_out_108072", "108072023", "story_v_out_108072.awb")

						arg_82_1:RecordAudio("108072023", var_85_9)
						arg_82_1:RecordAudio("108072023", var_85_9)
					else
						arg_82_1:AudioAction("play", "voice", "story_v_out_108072", "108072023", "story_v_out_108072.awb")
					end

					arg_82_1:RecordHistoryTalkVoice("story_v_out_108072", "108072023", "story_v_out_108072.awb")
				end

				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_10 = math.max(var_85_1, arg_82_1.talkMaxDuration)

			if var_85_0 <= arg_82_1.time_ and arg_82_1.time_ < var_85_0 + var_85_10 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_0) / var_85_10

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_0 + var_85_10 and arg_82_1.time_ < var_85_0 + var_85_10 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {}

		arg_82_1:InitPlayNodeList()
	end,
	Play108072024 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 108072024
		arg_86_1.duration_ = 13.4

		local var_86_0 = {
			ja = 13.4,
			ko = 9.866,
			zh = 11.233,
			en = 8.6
		}
		local var_86_1 = manager.audio:GetLocalizationFlag()

		if var_86_0[var_86_1] ~= nil then
			arg_86_1.duration_ = var_86_0[var_86_1]
		end

		SetActive(arg_86_1.tipsGo_, false)

		function arg_86_1.onSingleLineFinish_()
			arg_86_1.onSingleLineUpdate_ = nil
			arg_86_1.onSingleLineFinish_ = nil
			arg_86_1.state_ = "waiting"
		end

		function arg_86_1.playNext_(arg_88_0)
			if arg_88_0 == 1 then
				arg_86_0:Play108072025(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			local var_89_0 = 0
			local var_89_1 = 0.425

			if var_89_0 < arg_86_1.time_ and arg_86_1.time_ <= var_89_0 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, true)

				local var_89_2 = arg_86_1:FormatText(StoryNameCfg[96].name)

				arg_86_1.leftNameTxt_.text = var_89_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_3 = arg_86_1:GetWordFromCfg(108072024)
				local var_89_4 = arg_86_1:FormatText(var_89_3.content)

				arg_86_1.text_.text = var_89_4

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_5 = 17
				local var_89_6 = utf8.len(var_89_4)
				local var_89_7 = var_89_5 <= 0 and var_89_1 or var_89_1 * (var_89_6 / var_89_5)

				if var_89_7 > 0 and var_89_1 < var_89_7 then
					arg_86_1.talkMaxDuration = var_89_7

					if var_89_7 + var_89_0 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_7 + var_89_0
					end
				end

				arg_86_1.text_.text = var_89_4
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108072", "108072024", "story_v_out_108072.awb") ~= 0 then
					local var_89_8 = manager.audio:GetVoiceLength("story_v_out_108072", "108072024", "story_v_out_108072.awb") / 1000

					if var_89_8 + var_89_0 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_8 + var_89_0
					end

					if var_89_3.prefab_name ~= "" and arg_86_1.actors_[var_89_3.prefab_name] ~= nil then
						local var_89_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_86_1.actors_[var_89_3.prefab_name].transform, "story_v_out_108072", "108072024", "story_v_out_108072.awb")

						arg_86_1:RecordAudio("108072024", var_89_9)
						arg_86_1:RecordAudio("108072024", var_89_9)
					else
						arg_86_1:AudioAction("play", "voice", "story_v_out_108072", "108072024", "story_v_out_108072.awb")
					end

					arg_86_1:RecordHistoryTalkVoice("story_v_out_108072", "108072024", "story_v_out_108072.awb")
				end

				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_10 = math.max(var_89_1, arg_86_1.talkMaxDuration)

			if var_89_0 <= arg_86_1.time_ and arg_86_1.time_ < var_89_0 + var_89_10 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_0) / var_89_10

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_0 + var_89_10 and arg_86_1.time_ < var_89_0 + var_89_10 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {}

		arg_86_1:InitPlayNodeList()
	end,
	Play108072025 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 108072025
		arg_90_1.duration_ = 2.87

		local var_90_0 = {
			ja = 1.333,
			ko = 2.866,
			zh = 1.4,
			en = 1.5
		}
		local var_90_1 = manager.audio:GetLocalizationFlag()

		if var_90_0[var_90_1] ~= nil then
			arg_90_1.duration_ = var_90_0[var_90_1]
		end

		SetActive(arg_90_1.tipsGo_, false)

		function arg_90_1.onSingleLineFinish_()
			arg_90_1.onSingleLineUpdate_ = nil
			arg_90_1.onSingleLineFinish_ = nil
			arg_90_1.state_ = "waiting"
		end

		function arg_90_1.playNext_(arg_92_0)
			if arg_92_0 == 1 then
				arg_90_0:Play108072026(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			local var_93_0 = 0
			local var_93_1 = 0.05

			if var_93_0 < arg_90_1.time_ and arg_90_1.time_ <= var_93_0 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				local var_93_2 = arg_90_1:FormatText(StoryNameCfg[96].name)

				arg_90_1.leftNameTxt_.text = var_93_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_3 = arg_90_1:GetWordFromCfg(108072025)
				local var_93_4 = arg_90_1:FormatText(var_93_3.content)

				arg_90_1.text_.text = var_93_4

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_5 = 2
				local var_93_6 = utf8.len(var_93_4)
				local var_93_7 = var_93_5 <= 0 and var_93_1 or var_93_1 * (var_93_6 / var_93_5)

				if var_93_7 > 0 and var_93_1 < var_93_7 then
					arg_90_1.talkMaxDuration = var_93_7

					if var_93_7 + var_93_0 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_7 + var_93_0
					end
				end

				arg_90_1.text_.text = var_93_4
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108072", "108072025", "story_v_out_108072.awb") ~= 0 then
					local var_93_8 = manager.audio:GetVoiceLength("story_v_out_108072", "108072025", "story_v_out_108072.awb") / 1000

					if var_93_8 + var_93_0 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_8 + var_93_0
					end

					if var_93_3.prefab_name ~= "" and arg_90_1.actors_[var_93_3.prefab_name] ~= nil then
						local var_93_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_90_1.actors_[var_93_3.prefab_name].transform, "story_v_out_108072", "108072025", "story_v_out_108072.awb")

						arg_90_1:RecordAudio("108072025", var_93_9)
						arg_90_1:RecordAudio("108072025", var_93_9)
					else
						arg_90_1:AudioAction("play", "voice", "story_v_out_108072", "108072025", "story_v_out_108072.awb")
					end

					arg_90_1:RecordHistoryTalkVoice("story_v_out_108072", "108072025", "story_v_out_108072.awb")
				end

				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_10 = math.max(var_93_1, arg_90_1.talkMaxDuration)

			if var_93_0 <= arg_90_1.time_ and arg_90_1.time_ < var_93_0 + var_93_10 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_0) / var_93_10

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_0 + var_93_10 and arg_90_1.time_ < var_93_0 + var_93_10 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {}

		arg_90_1:InitPlayNodeList()
	end,
	Play108072026 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 108072026
		arg_94_1.duration_ = 5

		SetActive(arg_94_1.tipsGo_, false)

		function arg_94_1.onSingleLineFinish_()
			arg_94_1.onSingleLineUpdate_ = nil
			arg_94_1.onSingleLineFinish_ = nil
			arg_94_1.state_ = "waiting"
		end

		function arg_94_1.playNext_(arg_96_0)
			if arg_96_0 == 1 then
				arg_94_0:Play108072027(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			local var_97_0 = 0
			local var_97_1 = 0.25

			if var_97_0 < arg_94_1.time_ and arg_94_1.time_ <= var_97_0 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, false)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_2 = arg_94_1:GetWordFromCfg(108072026)
				local var_97_3 = arg_94_1:FormatText(var_97_2.content)

				arg_94_1.text_.text = var_97_3

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_4 = 10
				local var_97_5 = utf8.len(var_97_3)
				local var_97_6 = var_97_4 <= 0 and var_97_1 or var_97_1 * (var_97_5 / var_97_4)

				if var_97_6 > 0 and var_97_1 < var_97_6 then
					arg_94_1.talkMaxDuration = var_97_6

					if var_97_6 + var_97_0 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_6 + var_97_0
					end
				end

				arg_94_1.text_.text = var_97_3
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)
				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_7 = math.max(var_97_1, arg_94_1.talkMaxDuration)

			if var_97_0 <= arg_94_1.time_ and arg_94_1.time_ < var_97_0 + var_97_7 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_0) / var_97_7

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_0 + var_97_7 and arg_94_1.time_ < var_97_0 + var_97_7 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {}

		arg_94_1:InitPlayNodeList()
	end,
	Play108072027 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 108072027
		arg_98_1.duration_ = 6.5

		SetActive(arg_98_1.tipsGo_, false)

		function arg_98_1.onSingleLineFinish_()
			arg_98_1.onSingleLineUpdate_ = nil
			arg_98_1.onSingleLineFinish_ = nil
			arg_98_1.state_ = "waiting"
		end

		function arg_98_1.playNext_(arg_100_0)
			if arg_100_0 == 1 then
				arg_98_0:Play108072028(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			local var_101_0 = "C04"

			if arg_98_1.bgs_[var_101_0] == nil then
				local var_101_1 = Object.Instantiate(arg_98_1.paintGo_)

				var_101_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_101_0)
				var_101_1.name = var_101_0
				var_101_1.transform.parent = arg_98_1.stage_.transform
				var_101_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_98_1.bgs_[var_101_0] = var_101_1
			end

			local var_101_2 = 1.5

			if var_101_2 < arg_98_1.time_ and arg_98_1.time_ <= var_101_2 + arg_101_0 then
				local var_101_3 = manager.ui.mainCamera.transform.localPosition
				local var_101_4 = Vector3.New(0, 0, 10) + Vector3.New(var_101_3.x, var_101_3.y, 0)
				local var_101_5 = arg_98_1.bgs_.C04

				var_101_5.transform.localPosition = var_101_4
				var_101_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_101_6 = var_101_5:GetComponent("SpriteRenderer")

				if var_101_6 and var_101_6.sprite then
					local var_101_7 = (var_101_5.transform.localPosition - var_101_3).z
					local var_101_8 = manager.ui.mainCameraCom_
					local var_101_9 = 2 * var_101_7 * Mathf.Tan(var_101_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_101_10 = var_101_9 * var_101_8.aspect
					local var_101_11 = var_101_6.sprite.bounds.size.x
					local var_101_12 = var_101_6.sprite.bounds.size.y
					local var_101_13 = var_101_10 / var_101_11
					local var_101_14 = var_101_9 / var_101_12
					local var_101_15 = var_101_14 < var_101_13 and var_101_13 or var_101_14

					var_101_5.transform.localScale = Vector3.New(var_101_15, var_101_15, 0)
				end

				for iter_101_0, iter_101_1 in pairs(arg_98_1.bgs_) do
					if iter_101_0 ~= "C04" then
						iter_101_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_101_16 = arg_98_1.bgs_.S0804
			local var_101_17 = 0

			if var_101_17 < arg_98_1.time_ and arg_98_1.time_ <= var_101_17 + arg_101_0 then
				local var_101_18 = var_101_16:GetComponent("SpriteRenderer")

				if var_101_18 then
					arg_98_1.var_.alphaOldValueS0804 = var_101_18.color.a
					arg_98_1.var_.alphaMatValueS0804 = var_101_18
				end

				arg_98_1.var_.alphaOldValueS0804 = 1
			end

			local var_101_19 = 1.5

			if var_101_17 <= arg_98_1.time_ and arg_98_1.time_ < var_101_17 + var_101_19 then
				local var_101_20 = (arg_98_1.time_ - var_101_17) / var_101_19
				local var_101_21 = Mathf.Lerp(arg_98_1.var_.alphaOldValueS0804, 0, var_101_20)

				if arg_98_1.var_.alphaMatValueS0804 then
					local var_101_22 = arg_98_1.var_.alphaMatValueS0804.color

					var_101_22.a = var_101_21
					arg_98_1.var_.alphaMatValueS0804.color = var_101_22
				end
			end

			if arg_98_1.time_ >= var_101_17 + var_101_19 and arg_98_1.time_ < var_101_17 + var_101_19 + arg_101_0 and arg_98_1.var_.alphaMatValueS0804 then
				local var_101_23 = arg_98_1.var_.alphaMatValueS0804
				local var_101_24 = var_101_23.color

				var_101_24.a = 0
				var_101_23.color = var_101_24
			end

			local var_101_25 = arg_98_1.bgs_.C04
			local var_101_26 = 1.5

			if var_101_26 < arg_98_1.time_ and arg_98_1.time_ <= var_101_26 + arg_101_0 then
				local var_101_27 = var_101_25:GetComponent("SpriteRenderer")

				if var_101_27 then
					arg_98_1.var_.alphaOldValueC04 = var_101_27.color.a
					arg_98_1.var_.alphaMatValueC04 = var_101_27
				end

				arg_98_1.var_.alphaOldValueC04 = 0
			end

			local var_101_28 = 1.5

			if var_101_26 <= arg_98_1.time_ and arg_98_1.time_ < var_101_26 + var_101_28 then
				local var_101_29 = (arg_98_1.time_ - var_101_26) / var_101_28
				local var_101_30 = Mathf.Lerp(arg_98_1.var_.alphaOldValueC04, 1, var_101_29)

				if arg_98_1.var_.alphaMatValueC04 then
					local var_101_31 = arg_98_1.var_.alphaMatValueC04.color

					var_101_31.a = var_101_30
					arg_98_1.var_.alphaMatValueC04.color = var_101_31
				end
			end

			if arg_98_1.time_ >= var_101_26 + var_101_28 and arg_98_1.time_ < var_101_26 + var_101_28 + arg_101_0 and arg_98_1.var_.alphaMatValueC04 then
				local var_101_32 = arg_98_1.var_.alphaMatValueC04
				local var_101_33 = var_101_32.color

				var_101_33.a = 1
				var_101_32.color = var_101_33
			end

			local var_101_34 = 0

			if var_101_34 < arg_98_1.time_ and arg_98_1.time_ <= var_101_34 + arg_101_0 then
				arg_98_1.allBtn_.enabled = false
			end

			local var_101_35 = 1.5

			if arg_98_1.time_ >= var_101_34 + var_101_35 and arg_98_1.time_ < var_101_34 + var_101_35 + arg_101_0 then
				arg_98_1.allBtn_.enabled = true
			end

			local var_101_36 = 1.5
			local var_101_37 = 0.65

			if var_101_36 < arg_98_1.time_ and arg_98_1.time_ <= var_101_36 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, false)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_38 = arg_98_1:GetWordFromCfg(108072027)
				local var_101_39 = arg_98_1:FormatText(var_101_38.content)

				arg_98_1.text_.text = var_101_39

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_40 = 26
				local var_101_41 = utf8.len(var_101_39)
				local var_101_42 = var_101_40 <= 0 and var_101_37 or var_101_37 * (var_101_41 / var_101_40)

				if var_101_42 > 0 and var_101_37 < var_101_42 then
					arg_98_1.talkMaxDuration = var_101_42

					if var_101_42 + var_101_36 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_42 + var_101_36
					end
				end

				arg_98_1.text_.text = var_101_39
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)
				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_43 = math.max(var_101_37, arg_98_1.talkMaxDuration)

			if var_101_36 <= arg_98_1.time_ and arg_98_1.time_ < var_101_36 + var_101_43 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_36) / var_101_43

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_36 + var_101_43 and arg_98_1.time_ < var_101_36 + var_101_43 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {}

		arg_98_1:InitPlayNodeList()
	end,
	Play108072028 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 108072028
		arg_102_1.duration_ = 5

		SetActive(arg_102_1.tipsGo_, false)

		function arg_102_1.onSingleLineFinish_()
			arg_102_1.onSingleLineUpdate_ = nil
			arg_102_1.onSingleLineFinish_ = nil
			arg_102_1.state_ = "waiting"
		end

		function arg_102_1.playNext_(arg_104_0)
			if arg_104_0 == 1 then
				arg_102_0:Play108072029(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			local var_105_0 = 0
			local var_105_1 = 0.675

			if var_105_0 < arg_102_1.time_ and arg_102_1.time_ <= var_105_0 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, false)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_2 = arg_102_1:GetWordFromCfg(108072028)
				local var_105_3 = arg_102_1:FormatText(var_105_2.content)

				arg_102_1.text_.text = var_105_3

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_4 = 27
				local var_105_5 = utf8.len(var_105_3)
				local var_105_6 = var_105_4 <= 0 and var_105_1 or var_105_1 * (var_105_5 / var_105_4)

				if var_105_6 > 0 and var_105_1 < var_105_6 then
					arg_102_1.talkMaxDuration = var_105_6

					if var_105_6 + var_105_0 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_6 + var_105_0
					end
				end

				arg_102_1.text_.text = var_105_3
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)
				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_7 = math.max(var_105_1, arg_102_1.talkMaxDuration)

			if var_105_0 <= arg_102_1.time_ and arg_102_1.time_ < var_105_0 + var_105_7 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_0) / var_105_7

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_0 + var_105_7 and arg_102_1.time_ < var_105_0 + var_105_7 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {}

		arg_102_1:InitPlayNodeList()
	end,
	Play108072029 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 108072029
		arg_106_1.duration_ = 7.13

		local var_106_0 = {
			ja = 3.366,
			ko = 6.1,
			zh = 5.933,
			en = 7.133
		}
		local var_106_1 = manager.audio:GetLocalizationFlag()

		if var_106_0[var_106_1] ~= nil then
			arg_106_1.duration_ = var_106_0[var_106_1]
		end

		SetActive(arg_106_1.tipsGo_, false)

		function arg_106_1.onSingleLineFinish_()
			arg_106_1.onSingleLineUpdate_ = nil
			arg_106_1.onSingleLineFinish_ = nil
			arg_106_1.state_ = "waiting"
		end

		function arg_106_1.playNext_(arg_108_0)
			if arg_108_0 == 1 then
				arg_106_0:Play108072030(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			local var_109_0 = "1099ui_story"

			if arg_106_1.actors_[var_109_0] == nil then
				local var_109_1 = Asset.Load("Char/" .. "1099ui_story")

				if not isNil(var_109_1) then
					local var_109_2 = Object.Instantiate(Asset.Load("Char/" .. "1099ui_story"), arg_106_1.stage_.transform)

					var_109_2.name = var_109_0
					var_109_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_106_1.actors_[var_109_0] = var_109_2

					local var_109_3 = var_109_2:GetComponentInChildren(typeof(CharacterEffect))

					var_109_3.enabled = true

					local var_109_4 = GameObjectTools.GetOrAddComponent(var_109_2, typeof(DynamicBoneHelper))

					if var_109_4 then
						var_109_4:EnableDynamicBone(false)
					end

					arg_106_1:ShowWeapon(var_109_3.transform, false)

					arg_106_1.var_[var_109_0 .. "Animator"] = var_109_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_106_1.var_[var_109_0 .. "Animator"].applyRootMotion = true
					arg_106_1.var_[var_109_0 .. "LipSync"] = var_109_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_109_5 = arg_106_1.actors_["1099ui_story"].transform
			local var_109_6 = 0

			if var_109_6 < arg_106_1.time_ and arg_106_1.time_ <= var_109_6 + arg_109_0 then
				arg_106_1.var_.moveOldPos1099ui_story = var_109_5.localPosition
			end

			local var_109_7 = 0.001

			if var_109_6 <= arg_106_1.time_ and arg_106_1.time_ < var_109_6 + var_109_7 then
				local var_109_8 = (arg_106_1.time_ - var_109_6) / var_109_7
				local var_109_9 = Vector3.New(0, -1.08, -5.9)

				var_109_5.localPosition = Vector3.Lerp(arg_106_1.var_.moveOldPos1099ui_story, var_109_9, var_109_8)

				local var_109_10 = manager.ui.mainCamera.transform.position - var_109_5.position

				var_109_5.forward = Vector3.New(var_109_10.x, var_109_10.y, var_109_10.z)

				local var_109_11 = var_109_5.localEulerAngles

				var_109_11.z = 0
				var_109_11.x = 0
				var_109_5.localEulerAngles = var_109_11
			end

			if arg_106_1.time_ >= var_109_6 + var_109_7 and arg_106_1.time_ < var_109_6 + var_109_7 + arg_109_0 then
				var_109_5.localPosition = Vector3.New(0, -1.08, -5.9)

				local var_109_12 = manager.ui.mainCamera.transform.position - var_109_5.position

				var_109_5.forward = Vector3.New(var_109_12.x, var_109_12.y, var_109_12.z)

				local var_109_13 = var_109_5.localEulerAngles

				var_109_13.z = 0
				var_109_13.x = 0
				var_109_5.localEulerAngles = var_109_13
			end

			local var_109_14 = arg_106_1.actors_["1099ui_story"]
			local var_109_15 = 0

			if var_109_15 < arg_106_1.time_ and arg_106_1.time_ <= var_109_15 + arg_109_0 and not isNil(var_109_14) and arg_106_1.var_.characterEffect1099ui_story == nil then
				arg_106_1.var_.characterEffect1099ui_story = var_109_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_109_16 = 0.2

			if var_109_15 <= arg_106_1.time_ and arg_106_1.time_ < var_109_15 + var_109_16 and not isNil(var_109_14) then
				local var_109_17 = (arg_106_1.time_ - var_109_15) / var_109_16

				if arg_106_1.var_.characterEffect1099ui_story and not isNil(var_109_14) then
					arg_106_1.var_.characterEffect1099ui_story.fillFlat = false
				end
			end

			if arg_106_1.time_ >= var_109_15 + var_109_16 and arg_106_1.time_ < var_109_15 + var_109_16 + arg_109_0 and not isNil(var_109_14) and arg_106_1.var_.characterEffect1099ui_story then
				arg_106_1.var_.characterEffect1099ui_story.fillFlat = false
			end

			local var_109_18 = 0

			if var_109_18 < arg_106_1.time_ and arg_106_1.time_ <= var_109_18 + arg_109_0 then
				arg_106_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/story1099/story1099action/1099action4_1")
			end

			local var_109_19 = 0

			if var_109_19 < arg_106_1.time_ and arg_106_1.time_ <= var_109_19 + arg_109_0 then
				arg_106_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_109_20 = 0
			local var_109_21 = 0.725

			if var_109_20 < arg_106_1.time_ and arg_106_1.time_ <= var_109_20 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				local var_109_22 = arg_106_1:FormatText(StoryNameCfg[84].name)

				arg_106_1.leftNameTxt_.text = var_109_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_23 = arg_106_1:GetWordFromCfg(108072029)
				local var_109_24 = arg_106_1:FormatText(var_109_23.content)

				arg_106_1.text_.text = var_109_24

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_25 = 29
				local var_109_26 = utf8.len(var_109_24)
				local var_109_27 = var_109_25 <= 0 and var_109_21 or var_109_21 * (var_109_26 / var_109_25)

				if var_109_27 > 0 and var_109_21 < var_109_27 then
					arg_106_1.talkMaxDuration = var_109_27

					if var_109_27 + var_109_20 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_27 + var_109_20
					end
				end

				arg_106_1.text_.text = var_109_24
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108072", "108072029", "story_v_out_108072.awb") ~= 0 then
					local var_109_28 = manager.audio:GetVoiceLength("story_v_out_108072", "108072029", "story_v_out_108072.awb") / 1000

					if var_109_28 + var_109_20 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_28 + var_109_20
					end

					if var_109_23.prefab_name ~= "" and arg_106_1.actors_[var_109_23.prefab_name] ~= nil then
						local var_109_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_106_1.actors_[var_109_23.prefab_name].transform, "story_v_out_108072", "108072029", "story_v_out_108072.awb")

						arg_106_1:RecordAudio("108072029", var_109_29)
						arg_106_1:RecordAudio("108072029", var_109_29)
					else
						arg_106_1:AudioAction("play", "voice", "story_v_out_108072", "108072029", "story_v_out_108072.awb")
					end

					arg_106_1:RecordHistoryTalkVoice("story_v_out_108072", "108072029", "story_v_out_108072.awb")
				end

				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_30 = math.max(var_109_21, arg_106_1.talkMaxDuration)

			if var_109_20 <= arg_106_1.time_ and arg_106_1.time_ < var_109_20 + var_109_30 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_20) / var_109_30

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_20 + var_109_30 and arg_106_1.time_ < var_109_20 + var_109_30 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1099ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_106_1:InitPlayNodeList()
	end,
	Play108072030 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 108072030
		arg_110_1.duration_ = 11.93

		local var_110_0 = {
			ja = 11.933,
			ko = 3.733,
			zh = 5.3,
			en = 5.466
		}
		local var_110_1 = manager.audio:GetLocalizationFlag()

		if var_110_0[var_110_1] ~= nil then
			arg_110_1.duration_ = var_110_0[var_110_1]
		end

		SetActive(arg_110_1.tipsGo_, false)

		function arg_110_1.onSingleLineFinish_()
			arg_110_1.onSingleLineUpdate_ = nil
			arg_110_1.onSingleLineFinish_ = nil
			arg_110_1.state_ = "waiting"
			arg_110_1.auto_ = false
		end

		function arg_110_1.playNext_(arg_112_0)
			arg_110_1.onStoryFinished_()
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			local var_113_0 = 0

			if var_113_0 < arg_110_1.time_ and arg_110_1.time_ <= var_113_0 + arg_113_0 then
				arg_110_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0203cva")
			end

			local var_113_1 = 0
			local var_113_2 = 0.5

			if var_113_1 < arg_110_1.time_ and arg_110_1.time_ <= var_113_1 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				local var_113_3 = arg_110_1:FormatText(StoryNameCfg[84].name)

				arg_110_1.leftNameTxt_.text = var_113_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, false)
				arg_110_1.callingController_:SetSelectedState("normal")

				local var_113_4 = arg_110_1:GetWordFromCfg(108072030)
				local var_113_5 = arg_110_1:FormatText(var_113_4.content)

				arg_110_1.text_.text = var_113_5

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_6 = 20
				local var_113_7 = utf8.len(var_113_5)
				local var_113_8 = var_113_6 <= 0 and var_113_2 or var_113_2 * (var_113_7 / var_113_6)

				if var_113_8 > 0 and var_113_2 < var_113_8 then
					arg_110_1.talkMaxDuration = var_113_8

					if var_113_8 + var_113_1 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_8 + var_113_1
					end
				end

				arg_110_1.text_.text = var_113_5
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108072", "108072030", "story_v_out_108072.awb") ~= 0 then
					local var_113_9 = manager.audio:GetVoiceLength("story_v_out_108072", "108072030", "story_v_out_108072.awb") / 1000

					if var_113_9 + var_113_1 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_9 + var_113_1
					end

					if var_113_4.prefab_name ~= "" and arg_110_1.actors_[var_113_4.prefab_name] ~= nil then
						local var_113_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_110_1.actors_[var_113_4.prefab_name].transform, "story_v_out_108072", "108072030", "story_v_out_108072.awb")

						arg_110_1:RecordAudio("108072030", var_113_10)
						arg_110_1:RecordAudio("108072030", var_113_10)
					else
						arg_110_1:AudioAction("play", "voice", "story_v_out_108072", "108072030", "story_v_out_108072.awb")
					end

					arg_110_1:RecordHistoryTalkVoice("story_v_out_108072", "108072030", "story_v_out_108072.awb")
				end

				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_11 = math.max(var_113_2, arg_110_1.talkMaxDuration)

			if var_113_1 <= arg_110_1.time_ and arg_110_1.time_ < var_113_1 + var_113_11 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_1) / var_113_11

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_1 + var_113_11 and arg_110_1.time_ < var_113_1 + var_113_11 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {}

		arg_110_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/S0804",
		"TextureConfig/Background/S0809",
		"TextureConfig/Background/C04"
	},
	voices = {
		"story_v_out_108072.awb"
	}
}
