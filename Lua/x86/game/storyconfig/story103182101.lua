return {
	Play318211001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 318211001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play318211002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "STblack"

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
				local var_4_5 = arg_1_1.bgs_.STblack

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
					if iter_4_0 ~= "STblack" then
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
			local var_4_23 = 0.533333333333333

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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_28 = 2
			local var_4_29 = 0.825

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_30 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_30:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_30:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_30:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_31 = arg_1_1:GetWordFromCfg(318211001)
				local var_4_32 = arg_1_1:FormatText(var_4_31.content)

				arg_1_1.text_.text = var_4_32

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_33 = 33
				local var_4_34 = utf8.len(var_4_32)
				local var_4_35 = var_4_33 <= 0 and var_4_29 or var_4_29 * (var_4_34 / var_4_33)

				if var_4_35 > 0 and var_4_29 < var_4_35 then
					arg_1_1.talkMaxDuration = var_4_35
					var_4_28 = var_4_28 + 0.3

					if var_4_35 + var_4_28 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_35 + var_4_28
					end
				end

				arg_1_1.text_.text = var_4_32
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_36 = var_4_28 + 0.3
			local var_4_37 = math.max(var_4_29, arg_1_1.talkMaxDuration)

			if var_4_36 <= arg_1_1.time_ and arg_1_1.time_ < var_4_36 + var_4_37 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_36) / var_4_37

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_36 + var_4_37 and arg_1_1.time_ < var_4_36 + var_4_37 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play318211002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 318211002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play318211003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 0
			local var_11_1 = 1.275

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

				local var_11_2 = arg_8_1:GetWordFromCfg(318211002)
				local var_11_3 = arg_8_1:FormatText(var_11_2.content)

				arg_8_1.text_.text = var_11_3

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_4 = 51
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
	Play318211003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 318211003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play318211004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 0
			local var_15_1 = 0.525

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

				local var_15_2 = arg_12_1:GetWordFromCfg(318211003)
				local var_15_3 = arg_12_1:FormatText(var_15_2.content)

				arg_12_1.text_.text = var_15_3

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_4 = 24
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
	Play318211004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 318211004
		arg_16_1.duration_ = 2

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play318211005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = 0

			if var_19_0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_0 + arg_19_0 then
				arg_16_1.fswbg_:SetActive(true)
				arg_16_1.dialog_:SetActive(false)

				arg_16_1.fswtw_.percent = 0

				local var_19_1 = arg_16_1:GetWordFromCfg(318211004)
				local var_19_2 = arg_16_1:FormatText(var_19_1.content)

				arg_16_1.fswt_.text = var_19_2

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.fswt_)

				arg_16_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_16_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_16_1.fswtw_:SetDirty()

				arg_16_1.typewritterCharCountI18N = 0

				SetActive(arg_16_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_16_1:ShowNextGo(false)
			end

			local var_19_3 = 0.033

			if var_19_3 < arg_16_1.time_ and arg_16_1.time_ <= var_19_3 + arg_19_0 then
				arg_16_1.var_.oldValueTypewriter = arg_16_1.fswtw_.percent

				SetActive(arg_16_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_16_1:ShowNextGo(false)
			end

			local var_19_4 = 12
			local var_19_5 = 0.8
			local var_19_6 = arg_16_1:GetWordFromCfg(318211004)
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

			local var_19_11 = 0.8
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

			local var_19_14 = 0

			if var_19_14 < arg_16_1.time_ and arg_16_1.time_ <= var_19_14 + arg_19_0 then
				local var_19_15 = arg_16_1.fswbg_.transform:Find("textbox/adapt/content") or arg_16_1.fswbg_.transform:Find("textbox/content")
				local var_19_16 = arg_16_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_19_17 = var_19_15:GetComponent("Text")
				local var_19_18 = var_19_15:GetComponent("RectTransform")

				var_19_17.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_19_18.offsetMin = Vector2.New(0, 0)
				var_19_18.offsetMax = Vector2.New(0, 0)
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play318211005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 318211005
		arg_20_1.duration_ = 2

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play318211006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = 0

			if var_23_0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_0 + arg_23_0 then
				arg_20_1.fswbg_:SetActive(true)
				arg_20_1.dialog_:SetActive(false)

				arg_20_1.fswtw_.percent = 0

				local var_23_1 = arg_20_1:GetWordFromCfg(318211005)
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

			local var_23_3 = 0.033

			if var_23_3 < arg_20_1.time_ and arg_20_1.time_ <= var_23_3 + arg_23_0 then
				arg_20_1.var_.oldValueTypewriter = arg_20_1.fswtw_.percent

				SetActive(arg_20_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_20_1:ShowNextGo(false)
			end

			local var_23_4 = 16
			local var_23_5 = 1.06666666666667
			local var_23_6 = arg_20_1:GetWordFromCfg(318211005)
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

			local var_23_14 = 0

			if var_23_14 < arg_20_1.time_ and arg_20_1.time_ <= var_23_14 + arg_23_0 then
				local var_23_15 = arg_20_1.fswbg_.transform:Find("textbox/adapt/content") or arg_20_1.fswbg_.transform:Find("textbox/content")
				local var_23_16 = arg_20_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_23_17 = var_23_15:GetComponent("Text")
				local var_23_18 = var_23_15:GetComponent("RectTransform")

				var_23_17.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_23_18.offsetMin = Vector2.New(0, 0)
				var_23_18.offsetMax = Vector2.New(0, 0)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play318211006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 318211006
		arg_24_1.duration_ = 4.1

		local var_24_0 = {
			zh = 2.999999999999,
			ja = 4.1
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
				arg_24_0:Play318211007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = 1

			if var_27_0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_0 + arg_27_0 then
				local var_27_1 = manager.ui.mainCamera.transform.localPosition
				local var_27_2 = Vector3.New(0, 0, 10) + Vector3.New(var_27_1.x, var_27_1.y, 0)
				local var_27_3 = arg_24_1.bgs_.STblack

				var_27_3.transform.localPosition = var_27_2
				var_27_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_27_4 = var_27_3:GetComponent("SpriteRenderer")

				if var_27_4 and var_27_4.sprite then
					local var_27_5 = (var_27_3.transform.localPosition - var_27_1).z
					local var_27_6 = manager.ui.mainCameraCom_
					local var_27_7 = 2 * var_27_5 * Mathf.Tan(var_27_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_27_8 = var_27_7 * var_27_6.aspect
					local var_27_9 = var_27_4.sprite.bounds.size.x
					local var_27_10 = var_27_4.sprite.bounds.size.y
					local var_27_11 = var_27_8 / var_27_9
					local var_27_12 = var_27_7 / var_27_10
					local var_27_13 = var_27_12 < var_27_11 and var_27_11 or var_27_12

					var_27_3.transform.localScale = Vector3.New(var_27_13, var_27_13, 0)
				end

				for iter_27_0, iter_27_1 in pairs(arg_24_1.bgs_) do
					if iter_27_0 ~= "STblack" then
						iter_27_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_27_14 = "1199ui_story"

			if arg_24_1.actors_[var_27_14] == nil then
				local var_27_15 = Asset.Load("Char/" .. "1199ui_story")

				if not isNil(var_27_15) then
					local var_27_16 = Object.Instantiate(Asset.Load("Char/" .. "1199ui_story"), arg_24_1.stage_.transform)

					var_27_16.name = var_27_14
					var_27_16.transform.localPosition = Vector3.New(0, 100, 0)
					arg_24_1.actors_[var_27_14] = var_27_16

					local var_27_17 = var_27_16:GetComponentInChildren(typeof(CharacterEffect))

					var_27_17.enabled = true

					local var_27_18 = GameObjectTools.GetOrAddComponent(var_27_16, typeof(DynamicBoneHelper))

					if var_27_18 then
						var_27_18:EnableDynamicBone(false)
					end

					arg_24_1:ShowWeapon(var_27_17.transform, false)

					arg_24_1.var_[var_27_14 .. "Animator"] = var_27_17.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_24_1.var_[var_27_14 .. "Animator"].applyRootMotion = true
					arg_24_1.var_[var_27_14 .. "LipSync"] = var_27_17.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_27_19 = arg_24_1.actors_["1199ui_story"].transform
			local var_27_20 = 1

			if var_27_20 < arg_24_1.time_ and arg_24_1.time_ <= var_27_20 + arg_27_0 then
				arg_24_1.var_.moveOldPos1199ui_story = var_27_19.localPosition
			end

			local var_27_21 = 0.001

			if var_27_20 <= arg_24_1.time_ and arg_24_1.time_ < var_27_20 + var_27_21 then
				local var_27_22 = (arg_24_1.time_ - var_27_20) / var_27_21
				local var_27_23 = Vector3.New(0, -1.08, -5.9)

				var_27_19.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos1199ui_story, var_27_23, var_27_22)

				local var_27_24 = manager.ui.mainCamera.transform.position - var_27_19.position

				var_27_19.forward = Vector3.New(var_27_24.x, var_27_24.y, var_27_24.z)

				local var_27_25 = var_27_19.localEulerAngles

				var_27_25.z = 0
				var_27_25.x = 0
				var_27_19.localEulerAngles = var_27_25
			end

			if arg_24_1.time_ >= var_27_20 + var_27_21 and arg_24_1.time_ < var_27_20 + var_27_21 + arg_27_0 then
				var_27_19.localPosition = Vector3.New(0, -1.08, -5.9)

				local var_27_26 = manager.ui.mainCamera.transform.position - var_27_19.position

				var_27_19.forward = Vector3.New(var_27_26.x, var_27_26.y, var_27_26.z)

				local var_27_27 = var_27_19.localEulerAngles

				var_27_27.z = 0
				var_27_27.x = 0
				var_27_19.localEulerAngles = var_27_27
			end

			local var_27_28 = arg_24_1.actors_["1199ui_story"]
			local var_27_29 = 1

			if var_27_29 < arg_24_1.time_ and arg_24_1.time_ <= var_27_29 + arg_27_0 and not isNil(var_27_28) and arg_24_1.var_.characterEffect1199ui_story == nil then
				arg_24_1.var_.characterEffect1199ui_story = var_27_28:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_30 = 0.200000002980232

			if var_27_29 <= arg_24_1.time_ and arg_24_1.time_ < var_27_29 + var_27_30 and not isNil(var_27_28) then
				local var_27_31 = (arg_24_1.time_ - var_27_29) / var_27_30

				if arg_24_1.var_.characterEffect1199ui_story and not isNil(var_27_28) then
					arg_24_1.var_.characterEffect1199ui_story.fillFlat = false
				end
			end

			if arg_24_1.time_ >= var_27_29 + var_27_30 and arg_24_1.time_ < var_27_29 + var_27_30 + arg_27_0 and not isNil(var_27_28) and arg_24_1.var_.characterEffect1199ui_story then
				arg_24_1.var_.characterEffect1199ui_story.fillFlat = false
			end

			local var_27_32 = 1

			if var_27_32 < arg_24_1.time_ and arg_24_1.time_ <= var_27_32 + arg_27_0 then
				arg_24_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/story1199/story1199action/1199action5_1")
			end

			local var_27_33 = 1

			if var_27_33 < arg_24_1.time_ and arg_24_1.time_ <= var_27_33 + arg_27_0 then
				arg_24_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_27_34 = 1

			if var_27_34 < arg_24_1.time_ and arg_24_1.time_ <= var_27_34 + arg_27_0 then
				arg_24_1.fswbg_:SetActive(false)
				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_24_1:ShowNextGo(false)
			end

			local var_27_35 = 0

			if var_27_35 < arg_24_1.time_ and arg_24_1.time_ <= var_27_35 + arg_27_0 then
				arg_24_1.mask_.enabled = true
				arg_24_1.mask_.raycastTarget = true

				arg_24_1:SetGaussion(false)
			end

			local var_27_36 = 1

			if var_27_35 <= arg_24_1.time_ and arg_24_1.time_ < var_27_35 + var_27_36 then
				local var_27_37 = (arg_24_1.time_ - var_27_35) / var_27_36
				local var_27_38 = Color.New(0.0471698, 0.04516731, 0.04604959)

				var_27_38.a = Mathf.Lerp(0, 1, var_27_37)
				arg_24_1.mask_.color = var_27_38
			end

			if arg_24_1.time_ >= var_27_35 + var_27_36 and arg_24_1.time_ < var_27_35 + var_27_36 + arg_27_0 then
				local var_27_39 = Color.New(0.0471698, 0.04516731, 0.04604959)

				var_27_39.a = 1
				arg_24_1.mask_.color = var_27_39
			end

			local var_27_40 = 1

			if var_27_40 < arg_24_1.time_ and arg_24_1.time_ <= var_27_40 + arg_27_0 then
				arg_24_1.mask_.enabled = true
				arg_24_1.mask_.raycastTarget = true

				arg_24_1:SetGaussion(false)
			end

			local var_27_41 = 1

			if var_27_40 <= arg_24_1.time_ and arg_24_1.time_ < var_27_40 + var_27_41 then
				local var_27_42 = (arg_24_1.time_ - var_27_40) / var_27_41
				local var_27_43 = Color.New(0, 0, 0)

				var_27_43.a = Mathf.Lerp(1, 0, var_27_42)
				arg_24_1.mask_.color = var_27_43
			end

			if arg_24_1.time_ >= var_27_40 + var_27_41 and arg_24_1.time_ < var_27_40 + var_27_41 + arg_27_0 then
				local var_27_44 = Color.New(0, 0, 0)
				local var_27_45 = 0

				arg_24_1.mask_.enabled = false
				var_27_44.a = var_27_45
				arg_24_1.mask_.color = var_27_44
			end

			local var_27_46 = 1
			local var_27_47 = 0.075

			if var_27_46 < arg_24_1.time_ and arg_24_1.time_ <= var_27_46 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				local var_27_48 = arg_24_1:FormatText(StoryNameCfg[84].name)

				arg_24_1.leftNameTxt_.text = var_27_48

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_49 = arg_24_1:GetWordFromCfg(318211006)
				local var_27_50 = arg_24_1:FormatText(var_27_49.content)

				arg_24_1.text_.text = var_27_50

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_51 = 3
				local var_27_52 = utf8.len(var_27_50)
				local var_27_53 = var_27_51 <= 0 and var_27_47 or var_27_47 * (var_27_52 / var_27_51)

				if var_27_53 > 0 and var_27_47 < var_27_53 then
					arg_24_1.talkMaxDuration = var_27_53

					if var_27_53 + var_27_46 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_53 + var_27_46
					end
				end

				arg_24_1.text_.text = var_27_50
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318211", "318211006", "story_v_out_318211.awb") ~= 0 then
					local var_27_54 = manager.audio:GetVoiceLength("story_v_out_318211", "318211006", "story_v_out_318211.awb") / 1000

					if var_27_54 + var_27_46 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_54 + var_27_46
					end

					if var_27_49.prefab_name ~= "" and arg_24_1.actors_[var_27_49.prefab_name] ~= nil then
						local var_27_55 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_49.prefab_name].transform, "story_v_out_318211", "318211006", "story_v_out_318211.awb")

						arg_24_1:RecordAudio("318211006", var_27_55)
						arg_24_1:RecordAudio("318211006", var_27_55)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_318211", "318211006", "story_v_out_318211.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_318211", "318211006", "story_v_out_318211.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_56 = math.max(var_27_47, arg_24_1.talkMaxDuration)

			if var_27_46 <= arg_24_1.time_ and arg_24_1.time_ < var_27_46 + var_27_56 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_46) / var_27_56

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_46 + var_27_56 and arg_24_1.time_ < var_27_46 + var_27_56 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1199ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_24_1:InitPlayNodeList()
	end,
	Play318211007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 318211007
		arg_28_1.duration_ = 3.63

		local var_28_0 = {
			zh = 2.366,
			ja = 3.633
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
				arg_28_0:Play318211008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = 0
			local var_31_1 = 0.225

			if var_31_0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_0 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				local var_31_2 = arg_28_1:FormatText(StoryNameCfg[84].name)

				arg_28_1.leftNameTxt_.text = var_31_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_3 = arg_28_1:GetWordFromCfg(318211007)
				local var_31_4 = arg_28_1:FormatText(var_31_3.content)

				arg_28_1.text_.text = var_31_4

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_5 = 9
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

				if manager.audio:GetVoiceLength("story_v_out_318211", "318211007", "story_v_out_318211.awb") ~= 0 then
					local var_31_8 = manager.audio:GetVoiceLength("story_v_out_318211", "318211007", "story_v_out_318211.awb") / 1000

					if var_31_8 + var_31_0 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_8 + var_31_0
					end

					if var_31_3.prefab_name ~= "" and arg_28_1.actors_[var_31_3.prefab_name] ~= nil then
						local var_31_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_3.prefab_name].transform, "story_v_out_318211", "318211007", "story_v_out_318211.awb")

						arg_28_1:RecordAudio("318211007", var_31_9)
						arg_28_1:RecordAudio("318211007", var_31_9)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_318211", "318211007", "story_v_out_318211.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_318211", "318211007", "story_v_out_318211.awb")
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
	Play318211008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 318211008
		arg_32_1.duration_ = 7

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play318211009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = "ST69a"

			if arg_32_1.bgs_[var_35_0] == nil then
				local var_35_1 = Object.Instantiate(arg_32_1.paintGo_)

				var_35_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_35_0)
				var_35_1.name = var_35_0
				var_35_1.transform.parent = arg_32_1.stage_.transform
				var_35_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_32_1.bgs_[var_35_0] = var_35_1
			end

			local var_35_2 = 0

			if var_35_2 < arg_32_1.time_ and arg_32_1.time_ <= var_35_2 + arg_35_0 then
				local var_35_3 = manager.ui.mainCamera.transform.localPosition
				local var_35_4 = Vector3.New(0, 0, 10) + Vector3.New(var_35_3.x, var_35_3.y, 0)
				local var_35_5 = arg_32_1.bgs_.ST69a

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
					if iter_35_0 ~= "ST69a" then
						iter_35_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_35_16 = 0

			if var_35_16 < arg_32_1.time_ and arg_32_1.time_ <= var_35_16 + arg_35_0 then
				arg_32_1.mask_.enabled = true
				arg_32_1.mask_.raycastTarget = true

				arg_32_1:SetGaussion(false)
			end

			local var_35_17 = 2

			if var_35_16 <= arg_32_1.time_ and arg_32_1.time_ < var_35_16 + var_35_17 then
				local var_35_18 = (arg_32_1.time_ - var_35_16) / var_35_17
				local var_35_19 = Color.New(1, 1, 1)

				var_35_19.a = Mathf.Lerp(1, 0, var_35_18)
				arg_32_1.mask_.color = var_35_19
			end

			if arg_32_1.time_ >= var_35_16 + var_35_17 and arg_32_1.time_ < var_35_16 + var_35_17 + arg_35_0 then
				local var_35_20 = Color.New(1, 1, 1)
				local var_35_21 = 0

				arg_32_1.mask_.enabled = false
				var_35_20.a = var_35_21
				arg_32_1.mask_.color = var_35_20
			end

			local var_35_22 = arg_32_1.actors_["1199ui_story"].transform
			local var_35_23 = 0

			if var_35_23 < arg_32_1.time_ and arg_32_1.time_ <= var_35_23 + arg_35_0 then
				arg_32_1.var_.moveOldPos1199ui_story = var_35_22.localPosition
			end

			local var_35_24 = 0.001

			if var_35_23 <= arg_32_1.time_ and arg_32_1.time_ < var_35_23 + var_35_24 then
				local var_35_25 = (arg_32_1.time_ - var_35_23) / var_35_24
				local var_35_26 = Vector3.New(0, 100, 0)

				var_35_22.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos1199ui_story, var_35_26, var_35_25)

				local var_35_27 = manager.ui.mainCamera.transform.position - var_35_22.position

				var_35_22.forward = Vector3.New(var_35_27.x, var_35_27.y, var_35_27.z)

				local var_35_28 = var_35_22.localEulerAngles

				var_35_28.z = 0
				var_35_28.x = 0
				var_35_22.localEulerAngles = var_35_28
			end

			if arg_32_1.time_ >= var_35_23 + var_35_24 and arg_32_1.time_ < var_35_23 + var_35_24 + arg_35_0 then
				var_35_22.localPosition = Vector3.New(0, 100, 0)

				local var_35_29 = manager.ui.mainCamera.transform.position - var_35_22.position

				var_35_22.forward = Vector3.New(var_35_29.x, var_35_29.y, var_35_29.z)

				local var_35_30 = var_35_22.localEulerAngles

				var_35_30.z = 0
				var_35_30.x = 0
				var_35_22.localEulerAngles = var_35_30
			end

			local var_35_31 = arg_32_1.actors_["1199ui_story"]
			local var_35_32 = 0

			if var_35_32 < arg_32_1.time_ and arg_32_1.time_ <= var_35_32 + arg_35_0 and not isNil(var_35_31) and arg_32_1.var_.characterEffect1199ui_story == nil then
				arg_32_1.var_.characterEffect1199ui_story = var_35_31:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_33 = 0.200000002980232

			if var_35_32 <= arg_32_1.time_ and arg_32_1.time_ < var_35_32 + var_35_33 and not isNil(var_35_31) then
				local var_35_34 = (arg_32_1.time_ - var_35_32) / var_35_33

				if arg_32_1.var_.characterEffect1199ui_story and not isNil(var_35_31) then
					local var_35_35 = Mathf.Lerp(0, 0.5, var_35_34)

					arg_32_1.var_.characterEffect1199ui_story.fillFlat = true
					arg_32_1.var_.characterEffect1199ui_story.fillRatio = var_35_35
				end
			end

			if arg_32_1.time_ >= var_35_32 + var_35_33 and arg_32_1.time_ < var_35_32 + var_35_33 + arg_35_0 and not isNil(var_35_31) and arg_32_1.var_.characterEffect1199ui_story then
				local var_35_36 = 0.5

				arg_32_1.var_.characterEffect1199ui_story.fillFlat = true
				arg_32_1.var_.characterEffect1199ui_story.fillRatio = var_35_36
			end

			local var_35_37 = 0
			local var_35_38 = 0.533333333333333

			if var_35_37 < arg_32_1.time_ and arg_32_1.time_ <= var_35_37 + arg_35_0 then
				local var_35_39 = "play"
				local var_35_40 = "music"

				arg_32_1:AudioAction(var_35_39, var_35_40, "ui_battle", "ui_battle_stopbgm", "")

				local var_35_41 = ""
				local var_35_42 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_35_42 ~= "" then
					if arg_32_1.bgmTxt_.text ~= var_35_42 and arg_32_1.bgmTxt_.text ~= "" then
						if arg_32_1.bgmTxt2_.text ~= "" then
							arg_32_1.bgmTxt_.text = arg_32_1.bgmTxt2_.text
						end

						arg_32_1.bgmTxt2_.text = var_35_42

						arg_32_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_32_1.bgmTxt_.text = var_35_42
						arg_32_1.bgmTxt2_.text = var_35_42
					end

					if arg_32_1.bgmTimer then
						arg_32_1.bgmTimer:Stop()

						arg_32_1.bgmTimer = nil
					end

					if arg_32_1.settingData.show_music_name == 1 then
						arg_32_1.musicController:SetSelectedState("show")
						arg_32_1.musicAnimator_:Play("open", 0, 0)

						if arg_32_1.settingData.music_time ~= 0 then
							arg_32_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_32_1.settingData.music_time), function()
								if arg_32_1 == nil or isNil(arg_32_1.bgmTxt_) then
									return
								end

								arg_32_1.musicController:SetSelectedState("hide")
								arg_32_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_35_43 = 0.8
			local var_35_44 = 1

			if var_35_43 < arg_32_1.time_ and arg_32_1.time_ <= var_35_43 + arg_35_0 then
				local var_35_45 = "play"
				local var_35_46 = "music"

				arg_32_1:AudioAction(var_35_45, var_35_46, "bgm_activity_2_10_story_sasanamijyou", "bgm_activity_2_10_story_sasanamijyou", "bgm_activity_2_10_story_sasanamijyou.awb")

				local var_35_47 = ""
				local var_35_48 = manager.audio:GetAudioName("bgm_activity_2_10_story_sasanamijyou", "bgm_activity_2_10_story_sasanamijyou")

				if var_35_48 ~= "" then
					if arg_32_1.bgmTxt_.text ~= var_35_48 and arg_32_1.bgmTxt_.text ~= "" then
						if arg_32_1.bgmTxt2_.text ~= "" then
							arg_32_1.bgmTxt_.text = arg_32_1.bgmTxt2_.text
						end

						arg_32_1.bgmTxt2_.text = var_35_48

						arg_32_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_32_1.bgmTxt_.text = var_35_48
						arg_32_1.bgmTxt2_.text = var_35_48
					end

					if arg_32_1.bgmTimer then
						arg_32_1.bgmTimer:Stop()

						arg_32_1.bgmTimer = nil
					end

					if arg_32_1.settingData.show_music_name == 1 then
						arg_32_1.musicController:SetSelectedState("show")
						arg_32_1.musicAnimator_:Play("open", 0, 0)

						if arg_32_1.settingData.music_time ~= 0 then
							arg_32_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_32_1.settingData.music_time), function()
								if arg_32_1 == nil or isNil(arg_32_1.bgmTxt_) then
									return
								end

								arg_32_1.musicController:SetSelectedState("hide")
								arg_32_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_32_1.frameCnt_ <= 1 then
				arg_32_1.dialog_:SetActive(false)
			end

			local var_35_49 = 2
			local var_35_50 = 0.575

			if var_35_49 < arg_32_1.time_ and arg_32_1.time_ <= var_35_49 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0

				arg_32_1.dialog_:SetActive(true)

				arg_32_1.dialogCg_.alpha = 0

				local var_35_51 = LeanTween.value(arg_32_1.dialog_, 0, 1, 0.3)

				var_35_51:setOnUpdate(LuaHelper.FloatAction(function(arg_38_0)
					arg_32_1.dialogCg_.alpha = arg_38_0
				end))
				var_35_51:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_32_1.dialog_)
					var_35_51:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_32_1.duration_ = arg_32_1.duration_ + 0.3

				SetActive(arg_32_1.leftNameGo_, false)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_52 = arg_32_1:GetWordFromCfg(318211008)
				local var_35_53 = arg_32_1:FormatText(var_35_52.content)

				arg_32_1.text_.text = var_35_53

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_54 = 23
				local var_35_55 = utf8.len(var_35_53)
				local var_35_56 = var_35_54 <= 0 and var_35_50 or var_35_50 * (var_35_55 / var_35_54)

				if var_35_56 > 0 and var_35_50 < var_35_56 then
					arg_32_1.talkMaxDuration = var_35_56
					var_35_49 = var_35_49 + 0.3

					if var_35_56 + var_35_49 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_56 + var_35_49
					end
				end

				arg_32_1.text_.text = var_35_53
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)
				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_57 = var_35_49 + 0.3
			local var_35_58 = math.max(var_35_50, arg_32_1.talkMaxDuration)

			if var_35_57 <= arg_32_1.time_ and arg_32_1.time_ < var_35_57 + var_35_58 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_57) / var_35_58

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_57 + var_35_58 and arg_32_1.time_ < var_35_57 + var_35_58 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1199ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_32_1:InitPlayNodeList()
	end,
	Play318211009 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 318211009
		arg_40_1.duration_ = 2.97

		local var_40_0 = {
			zh = 1.999999999999,
			ja = 2.966
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
				arg_40_0:Play318211010(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = "1150ui_story"

			if arg_40_1.actors_[var_43_0] == nil then
				local var_43_1 = Asset.Load("Char/" .. "1150ui_story")

				if not isNil(var_43_1) then
					local var_43_2 = Object.Instantiate(Asset.Load("Char/" .. "1150ui_story"), arg_40_1.stage_.transform)

					var_43_2.name = var_43_0
					var_43_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_40_1.actors_[var_43_0] = var_43_2

					local var_43_3 = var_43_2:GetComponentInChildren(typeof(CharacterEffect))

					var_43_3.enabled = true

					local var_43_4 = GameObjectTools.GetOrAddComponent(var_43_2, typeof(DynamicBoneHelper))

					if var_43_4 then
						var_43_4:EnableDynamicBone(false)
					end

					arg_40_1:ShowWeapon(var_43_3.transform, false)

					arg_40_1.var_[var_43_0 .. "Animator"] = var_43_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_40_1.var_[var_43_0 .. "Animator"].applyRootMotion = true
					arg_40_1.var_[var_43_0 .. "LipSync"] = var_43_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_43_5 = arg_40_1.actors_["1150ui_story"].transform
			local var_43_6 = 0

			if var_43_6 < arg_40_1.time_ and arg_40_1.time_ <= var_43_6 + arg_43_0 then
				arg_40_1.var_.moveOldPos1150ui_story = var_43_5.localPosition
			end

			local var_43_7 = 0.001

			if var_43_6 <= arg_40_1.time_ and arg_40_1.time_ < var_43_6 + var_43_7 then
				local var_43_8 = (arg_40_1.time_ - var_43_6) / var_43_7
				local var_43_9 = Vector3.New(0, -1.01, -6.2)

				var_43_5.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos1150ui_story, var_43_9, var_43_8)

				local var_43_10 = manager.ui.mainCamera.transform.position - var_43_5.position

				var_43_5.forward = Vector3.New(var_43_10.x, var_43_10.y, var_43_10.z)

				local var_43_11 = var_43_5.localEulerAngles

				var_43_11.z = 0
				var_43_11.x = 0
				var_43_5.localEulerAngles = var_43_11
			end

			if arg_40_1.time_ >= var_43_6 + var_43_7 and arg_40_1.time_ < var_43_6 + var_43_7 + arg_43_0 then
				var_43_5.localPosition = Vector3.New(0, -1.01, -6.2)

				local var_43_12 = manager.ui.mainCamera.transform.position - var_43_5.position

				var_43_5.forward = Vector3.New(var_43_12.x, var_43_12.y, var_43_12.z)

				local var_43_13 = var_43_5.localEulerAngles

				var_43_13.z = 0
				var_43_13.x = 0
				var_43_5.localEulerAngles = var_43_13
			end

			local var_43_14 = arg_40_1.actors_["1150ui_story"]
			local var_43_15 = 0

			if var_43_15 < arg_40_1.time_ and arg_40_1.time_ <= var_43_15 + arg_43_0 and not isNil(var_43_14) and arg_40_1.var_.characterEffect1150ui_story == nil then
				arg_40_1.var_.characterEffect1150ui_story = var_43_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_16 = 0.200000002980232

			if var_43_15 <= arg_40_1.time_ and arg_40_1.time_ < var_43_15 + var_43_16 and not isNil(var_43_14) then
				local var_43_17 = (arg_40_1.time_ - var_43_15) / var_43_16

				if arg_40_1.var_.characterEffect1150ui_story and not isNil(var_43_14) then
					arg_40_1.var_.characterEffect1150ui_story.fillFlat = false
				end
			end

			if arg_40_1.time_ >= var_43_15 + var_43_16 and arg_40_1.time_ < var_43_15 + var_43_16 + arg_43_0 and not isNil(var_43_14) and arg_40_1.var_.characterEffect1150ui_story then
				arg_40_1.var_.characterEffect1150ui_story.fillFlat = false
			end

			local var_43_18 = 0

			if var_43_18 < arg_40_1.time_ and arg_40_1.time_ <= var_43_18 + arg_43_0 then
				arg_40_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/story1150/story1150action/1150action1_1")
			end

			local var_43_19 = 0

			if var_43_19 < arg_40_1.time_ and arg_40_1.time_ <= var_43_19 + arg_43_0 then
				arg_40_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_43_20 = 0
			local var_43_21 = 0.175

			if var_43_20 < arg_40_1.time_ and arg_40_1.time_ <= var_43_20 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				local var_43_22 = arg_40_1:FormatText(StoryNameCfg[74].name)

				arg_40_1.leftNameTxt_.text = var_43_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_23 = arg_40_1:GetWordFromCfg(318211009)
				local var_43_24 = arg_40_1:FormatText(var_43_23.content)

				arg_40_1.text_.text = var_43_24

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_25 = 7
				local var_43_26 = utf8.len(var_43_24)
				local var_43_27 = var_43_25 <= 0 and var_43_21 or var_43_21 * (var_43_26 / var_43_25)

				if var_43_27 > 0 and var_43_21 < var_43_27 then
					arg_40_1.talkMaxDuration = var_43_27

					if var_43_27 + var_43_20 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_27 + var_43_20
					end
				end

				arg_40_1.text_.text = var_43_24
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318211", "318211009", "story_v_out_318211.awb") ~= 0 then
					local var_43_28 = manager.audio:GetVoiceLength("story_v_out_318211", "318211009", "story_v_out_318211.awb") / 1000

					if var_43_28 + var_43_20 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_28 + var_43_20
					end

					if var_43_23.prefab_name ~= "" and arg_40_1.actors_[var_43_23.prefab_name] ~= nil then
						local var_43_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_23.prefab_name].transform, "story_v_out_318211", "318211009", "story_v_out_318211.awb")

						arg_40_1:RecordAudio("318211009", var_43_29)
						arg_40_1:RecordAudio("318211009", var_43_29)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_318211", "318211009", "story_v_out_318211.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_318211", "318211009", "story_v_out_318211.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_30 = math.max(var_43_21, arg_40_1.talkMaxDuration)

			if var_43_20 <= arg_40_1.time_ and arg_40_1.time_ < var_43_20 + var_43_30 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_20) / var_43_30

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_20 + var_43_30 and arg_40_1.time_ < var_43_20 + var_43_30 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1150ui_story",
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
	Play318211010 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 318211010
		arg_44_1.duration_ = 5

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play318211011(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = arg_44_1.actors_["1150ui_story"].transform
			local var_47_1 = 0

			if var_47_1 < arg_44_1.time_ and arg_44_1.time_ <= var_47_1 + arg_47_0 then
				arg_44_1.var_.moveOldPos1150ui_story = var_47_0.localPosition
			end

			local var_47_2 = 0.001

			if var_47_1 <= arg_44_1.time_ and arg_44_1.time_ < var_47_1 + var_47_2 then
				local var_47_3 = (arg_44_1.time_ - var_47_1) / var_47_2
				local var_47_4 = Vector3.New(0, 100, 0)

				var_47_0.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos1150ui_story, var_47_4, var_47_3)

				local var_47_5 = manager.ui.mainCamera.transform.position - var_47_0.position

				var_47_0.forward = Vector3.New(var_47_5.x, var_47_5.y, var_47_5.z)

				local var_47_6 = var_47_0.localEulerAngles

				var_47_6.z = 0
				var_47_6.x = 0
				var_47_0.localEulerAngles = var_47_6
			end

			if arg_44_1.time_ >= var_47_1 + var_47_2 and arg_44_1.time_ < var_47_1 + var_47_2 + arg_47_0 then
				var_47_0.localPosition = Vector3.New(0, 100, 0)

				local var_47_7 = manager.ui.mainCamera.transform.position - var_47_0.position

				var_47_0.forward = Vector3.New(var_47_7.x, var_47_7.y, var_47_7.z)

				local var_47_8 = var_47_0.localEulerAngles

				var_47_8.z = 0
				var_47_8.x = 0
				var_47_0.localEulerAngles = var_47_8
			end

			local var_47_9 = arg_44_1.actors_["1150ui_story"]
			local var_47_10 = 0

			if var_47_10 < arg_44_1.time_ and arg_44_1.time_ <= var_47_10 + arg_47_0 and not isNil(var_47_9) and arg_44_1.var_.characterEffect1150ui_story == nil then
				arg_44_1.var_.characterEffect1150ui_story = var_47_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_11 = 0.200000002980232

			if var_47_10 <= arg_44_1.time_ and arg_44_1.time_ < var_47_10 + var_47_11 and not isNil(var_47_9) then
				local var_47_12 = (arg_44_1.time_ - var_47_10) / var_47_11

				if arg_44_1.var_.characterEffect1150ui_story and not isNil(var_47_9) then
					local var_47_13 = Mathf.Lerp(0, 0.5, var_47_12)

					arg_44_1.var_.characterEffect1150ui_story.fillFlat = true
					arg_44_1.var_.characterEffect1150ui_story.fillRatio = var_47_13
				end
			end

			if arg_44_1.time_ >= var_47_10 + var_47_11 and arg_44_1.time_ < var_47_10 + var_47_11 + arg_47_0 and not isNil(var_47_9) and arg_44_1.var_.characterEffect1150ui_story then
				local var_47_14 = 0.5

				arg_44_1.var_.characterEffect1150ui_story.fillFlat = true
				arg_44_1.var_.characterEffect1150ui_story.fillRatio = var_47_14
			end

			local var_47_15 = 0
			local var_47_16 = 1.275

			if var_47_15 < arg_44_1.time_ and arg_44_1.time_ <= var_47_15 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, false)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_17 = arg_44_1:GetWordFromCfg(318211010)
				local var_47_18 = arg_44_1:FormatText(var_47_17.content)

				arg_44_1.text_.text = var_47_18

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_19 = 51
				local var_47_20 = utf8.len(var_47_18)
				local var_47_21 = var_47_19 <= 0 and var_47_16 or var_47_16 * (var_47_20 / var_47_19)

				if var_47_21 > 0 and var_47_16 < var_47_21 then
					arg_44_1.talkMaxDuration = var_47_21

					if var_47_21 + var_47_15 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_21 + var_47_15
					end
				end

				arg_44_1.text_.text = var_47_18
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)
				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_22 = math.max(var_47_16, arg_44_1.talkMaxDuration)

			if var_47_15 <= arg_44_1.time_ and arg_44_1.time_ < var_47_15 + var_47_22 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_15) / var_47_22

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_15 + var_47_22 and arg_44_1.time_ < var_47_15 + var_47_22 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_44_1:InitPlayNodeList()
	end,
	Play318211011 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 318211011
		arg_48_1.duration_ = 5

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play318211012(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = 0
			local var_51_1 = 0.7

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

				local var_51_2 = arg_48_1:GetWordFromCfg(318211011)
				local var_51_3 = arg_48_1:FormatText(var_51_2.content)

				arg_48_1.text_.text = var_51_3

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_4 = 28
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
	Play318211012 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 318211012
		arg_52_1.duration_ = 4.1

		local var_52_0 = {
			zh = 3.066,
			ja = 4.1
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
				arg_52_0:Play318211013(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = "1093ui_story"

			if arg_52_1.actors_[var_55_0] == nil then
				local var_55_1 = Asset.Load("Char/" .. "1093ui_story")

				if not isNil(var_55_1) then
					local var_55_2 = Object.Instantiate(Asset.Load("Char/" .. "1093ui_story"), arg_52_1.stage_.transform)

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

			local var_55_5 = arg_52_1.actors_["1093ui_story"].transform
			local var_55_6 = 0

			if var_55_6 < arg_52_1.time_ and arg_52_1.time_ <= var_55_6 + arg_55_0 then
				arg_52_1.var_.moveOldPos1093ui_story = var_55_5.localPosition
			end

			local var_55_7 = 0.001

			if var_55_6 <= arg_52_1.time_ and arg_52_1.time_ < var_55_6 + var_55_7 then
				local var_55_8 = (arg_52_1.time_ - var_55_6) / var_55_7
				local var_55_9 = Vector3.New(0, -1.11, -5.88)

				var_55_5.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPos1093ui_story, var_55_9, var_55_8)

				local var_55_10 = manager.ui.mainCamera.transform.position - var_55_5.position

				var_55_5.forward = Vector3.New(var_55_10.x, var_55_10.y, var_55_10.z)

				local var_55_11 = var_55_5.localEulerAngles

				var_55_11.z = 0
				var_55_11.x = 0
				var_55_5.localEulerAngles = var_55_11
			end

			if arg_52_1.time_ >= var_55_6 + var_55_7 and arg_52_1.time_ < var_55_6 + var_55_7 + arg_55_0 then
				var_55_5.localPosition = Vector3.New(0, -1.11, -5.88)

				local var_55_12 = manager.ui.mainCamera.transform.position - var_55_5.position

				var_55_5.forward = Vector3.New(var_55_12.x, var_55_12.y, var_55_12.z)

				local var_55_13 = var_55_5.localEulerAngles

				var_55_13.z = 0
				var_55_13.x = 0
				var_55_5.localEulerAngles = var_55_13
			end

			local var_55_14 = arg_52_1.actors_["1093ui_story"]
			local var_55_15 = 0

			if var_55_15 < arg_52_1.time_ and arg_52_1.time_ <= var_55_15 + arg_55_0 and not isNil(var_55_14) and arg_52_1.var_.characterEffect1093ui_story == nil then
				arg_52_1.var_.characterEffect1093ui_story = var_55_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_16 = 0.200000002980232

			if var_55_15 <= arg_52_1.time_ and arg_52_1.time_ < var_55_15 + var_55_16 and not isNil(var_55_14) then
				local var_55_17 = (arg_52_1.time_ - var_55_15) / var_55_16

				if arg_52_1.var_.characterEffect1093ui_story and not isNil(var_55_14) then
					arg_52_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_52_1.time_ >= var_55_15 + var_55_16 and arg_52_1.time_ < var_55_15 + var_55_16 + arg_55_0 and not isNil(var_55_14) and arg_52_1.var_.characterEffect1093ui_story then
				arg_52_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_55_18 = 0

			if var_55_18 < arg_52_1.time_ and arg_52_1.time_ <= var_55_18 + arg_55_0 then
				arg_52_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action8_1")
			end

			local var_55_19 = 0

			if var_55_19 < arg_52_1.time_ and arg_52_1.time_ <= var_55_19 + arg_55_0 then
				arg_52_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_55_20 = 0
			local var_55_21 = 0.35

			if var_55_20 < arg_52_1.time_ and arg_52_1.time_ <= var_55_20 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				local var_55_22 = arg_52_1:FormatText(StoryNameCfg[73].name)

				arg_52_1.leftNameTxt_.text = var_55_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_23 = arg_52_1:GetWordFromCfg(318211012)
				local var_55_24 = arg_52_1:FormatText(var_55_23.content)

				arg_52_1.text_.text = var_55_24

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_25 = 14
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

				if manager.audio:GetVoiceLength("story_v_out_318211", "318211012", "story_v_out_318211.awb") ~= 0 then
					local var_55_28 = manager.audio:GetVoiceLength("story_v_out_318211", "318211012", "story_v_out_318211.awb") / 1000

					if var_55_28 + var_55_20 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_28 + var_55_20
					end

					if var_55_23.prefab_name ~= "" and arg_52_1.actors_[var_55_23.prefab_name] ~= nil then
						local var_55_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_23.prefab_name].transform, "story_v_out_318211", "318211012", "story_v_out_318211.awb")

						arg_52_1:RecordAudio("318211012", var_55_29)
						arg_52_1:RecordAudio("318211012", var_55_29)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_318211", "318211012", "story_v_out_318211.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_318211", "318211012", "story_v_out_318211.awb")
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
				actorName = "1093ui_story",
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
	Play318211013 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 318211013
		arg_56_1.duration_ = 4.23

		local var_56_0 = {
			zh = 4,
			ja = 4.233
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
				arg_56_0:Play318211014(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = arg_56_1.actors_["1199ui_story"].transform
			local var_59_1 = 0

			if var_59_1 < arg_56_1.time_ and arg_56_1.time_ <= var_59_1 + arg_59_0 then
				arg_56_1.var_.moveOldPos1199ui_story = var_59_0.localPosition
			end

			local var_59_2 = 0.001

			if var_59_1 <= arg_56_1.time_ and arg_56_1.time_ < var_59_1 + var_59_2 then
				local var_59_3 = (arg_56_1.time_ - var_59_1) / var_59_2
				local var_59_4 = Vector3.New(0, -1.08, -5.9)

				var_59_0.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos1199ui_story, var_59_4, var_59_3)

				local var_59_5 = manager.ui.mainCamera.transform.position - var_59_0.position

				var_59_0.forward = Vector3.New(var_59_5.x, var_59_5.y, var_59_5.z)

				local var_59_6 = var_59_0.localEulerAngles

				var_59_6.z = 0
				var_59_6.x = 0
				var_59_0.localEulerAngles = var_59_6
			end

			if arg_56_1.time_ >= var_59_1 + var_59_2 and arg_56_1.time_ < var_59_1 + var_59_2 + arg_59_0 then
				var_59_0.localPosition = Vector3.New(0, -1.08, -5.9)

				local var_59_7 = manager.ui.mainCamera.transform.position - var_59_0.position

				var_59_0.forward = Vector3.New(var_59_7.x, var_59_7.y, var_59_7.z)

				local var_59_8 = var_59_0.localEulerAngles

				var_59_8.z = 0
				var_59_8.x = 0
				var_59_0.localEulerAngles = var_59_8
			end

			local var_59_9 = arg_56_1.actors_["1199ui_story"]
			local var_59_10 = 0

			if var_59_10 < arg_56_1.time_ and arg_56_1.time_ <= var_59_10 + arg_59_0 and not isNil(var_59_9) and arg_56_1.var_.characterEffect1199ui_story == nil then
				arg_56_1.var_.characterEffect1199ui_story = var_59_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_11 = 0.200000002980232

			if var_59_10 <= arg_56_1.time_ and arg_56_1.time_ < var_59_10 + var_59_11 and not isNil(var_59_9) then
				local var_59_12 = (arg_56_1.time_ - var_59_10) / var_59_11

				if arg_56_1.var_.characterEffect1199ui_story and not isNil(var_59_9) then
					arg_56_1.var_.characterEffect1199ui_story.fillFlat = false
				end
			end

			if arg_56_1.time_ >= var_59_10 + var_59_11 and arg_56_1.time_ < var_59_10 + var_59_11 + arg_59_0 and not isNil(var_59_9) and arg_56_1.var_.characterEffect1199ui_story then
				arg_56_1.var_.characterEffect1199ui_story.fillFlat = false
			end

			local var_59_13 = 0

			if var_59_13 < arg_56_1.time_ and arg_56_1.time_ <= var_59_13 + arg_59_0 then
				arg_56_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/story1199/story1199action/1199action1_1")
			end

			local var_59_14 = 0

			if var_59_14 < arg_56_1.time_ and arg_56_1.time_ <= var_59_14 + arg_59_0 then
				arg_56_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_59_15 = arg_56_1.actors_["1093ui_story"].transform
			local var_59_16 = 0

			if var_59_16 < arg_56_1.time_ and arg_56_1.time_ <= var_59_16 + arg_59_0 then
				arg_56_1.var_.moveOldPos1093ui_story = var_59_15.localPosition
			end

			local var_59_17 = 0.001

			if var_59_16 <= arg_56_1.time_ and arg_56_1.time_ < var_59_16 + var_59_17 then
				local var_59_18 = (arg_56_1.time_ - var_59_16) / var_59_17
				local var_59_19 = Vector3.New(0, 100, 0)

				var_59_15.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos1093ui_story, var_59_19, var_59_18)

				local var_59_20 = manager.ui.mainCamera.transform.position - var_59_15.position

				var_59_15.forward = Vector3.New(var_59_20.x, var_59_20.y, var_59_20.z)

				local var_59_21 = var_59_15.localEulerAngles

				var_59_21.z = 0
				var_59_21.x = 0
				var_59_15.localEulerAngles = var_59_21
			end

			if arg_56_1.time_ >= var_59_16 + var_59_17 and arg_56_1.time_ < var_59_16 + var_59_17 + arg_59_0 then
				var_59_15.localPosition = Vector3.New(0, 100, 0)

				local var_59_22 = manager.ui.mainCamera.transform.position - var_59_15.position

				var_59_15.forward = Vector3.New(var_59_22.x, var_59_22.y, var_59_22.z)

				local var_59_23 = var_59_15.localEulerAngles

				var_59_23.z = 0
				var_59_23.x = 0
				var_59_15.localEulerAngles = var_59_23
			end

			local var_59_24 = arg_56_1.actors_["1093ui_story"]
			local var_59_25 = 0

			if var_59_25 < arg_56_1.time_ and arg_56_1.time_ <= var_59_25 + arg_59_0 and not isNil(var_59_24) and arg_56_1.var_.characterEffect1093ui_story == nil then
				arg_56_1.var_.characterEffect1093ui_story = var_59_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_26 = 0.200000002980232

			if var_59_25 <= arg_56_1.time_ and arg_56_1.time_ < var_59_25 + var_59_26 and not isNil(var_59_24) then
				local var_59_27 = (arg_56_1.time_ - var_59_25) / var_59_26

				if arg_56_1.var_.characterEffect1093ui_story and not isNil(var_59_24) then
					local var_59_28 = Mathf.Lerp(0, 0.5, var_59_27)

					arg_56_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_56_1.var_.characterEffect1093ui_story.fillRatio = var_59_28
				end
			end

			if arg_56_1.time_ >= var_59_25 + var_59_26 and arg_56_1.time_ < var_59_25 + var_59_26 + arg_59_0 and not isNil(var_59_24) and arg_56_1.var_.characterEffect1093ui_story then
				local var_59_29 = 0.5

				arg_56_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_56_1.var_.characterEffect1093ui_story.fillRatio = var_59_29
			end

			local var_59_30 = 0
			local var_59_31 = 0.3

			if var_59_30 < arg_56_1.time_ and arg_56_1.time_ <= var_59_30 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				local var_59_32 = arg_56_1:FormatText(StoryNameCfg[84].name)

				arg_56_1.leftNameTxt_.text = var_59_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_33 = arg_56_1:GetWordFromCfg(318211013)
				local var_59_34 = arg_56_1:FormatText(var_59_33.content)

				arg_56_1.text_.text = var_59_34

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_35 = 12
				local var_59_36 = utf8.len(var_59_34)
				local var_59_37 = var_59_35 <= 0 and var_59_31 or var_59_31 * (var_59_36 / var_59_35)

				if var_59_37 > 0 and var_59_31 < var_59_37 then
					arg_56_1.talkMaxDuration = var_59_37

					if var_59_37 + var_59_30 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_37 + var_59_30
					end
				end

				arg_56_1.text_.text = var_59_34
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318211", "318211013", "story_v_out_318211.awb") ~= 0 then
					local var_59_38 = manager.audio:GetVoiceLength("story_v_out_318211", "318211013", "story_v_out_318211.awb") / 1000

					if var_59_38 + var_59_30 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_38 + var_59_30
					end

					if var_59_33.prefab_name ~= "" and arg_56_1.actors_[var_59_33.prefab_name] ~= nil then
						local var_59_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_33.prefab_name].transform, "story_v_out_318211", "318211013", "story_v_out_318211.awb")

						arg_56_1:RecordAudio("318211013", var_59_39)
						arg_56_1:RecordAudio("318211013", var_59_39)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_318211", "318211013", "story_v_out_318211.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_318211", "318211013", "story_v_out_318211.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_40 = math.max(var_59_31, arg_56_1.talkMaxDuration)

			if var_59_30 <= arg_56_1.time_ and arg_56_1.time_ < var_59_30 + var_59_40 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_30) / var_59_40

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_30 + var_59_40 and arg_56_1.time_ < var_59_30 + var_59_40 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1199ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_56_1:InitPlayNodeList()
	end,
	Play318211014 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 318211014
		arg_60_1.duration_ = 7.1

		local var_60_0 = {
			zh = 4.966,
			ja = 7.1
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
				arg_60_0:Play318211015(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = arg_60_1.actors_["1093ui_story"].transform
			local var_63_1 = 0

			if var_63_1 < arg_60_1.time_ and arg_60_1.time_ <= var_63_1 + arg_63_0 then
				arg_60_1.var_.moveOldPos1093ui_story = var_63_0.localPosition
			end

			local var_63_2 = 0.001

			if var_63_1 <= arg_60_1.time_ and arg_60_1.time_ < var_63_1 + var_63_2 then
				local var_63_3 = (arg_60_1.time_ - var_63_1) / var_63_2
				local var_63_4 = Vector3.New(0, -1.11, -5.88)

				var_63_0.localPosition = Vector3.Lerp(arg_60_1.var_.moveOldPos1093ui_story, var_63_4, var_63_3)

				local var_63_5 = manager.ui.mainCamera.transform.position - var_63_0.position

				var_63_0.forward = Vector3.New(var_63_5.x, var_63_5.y, var_63_5.z)

				local var_63_6 = var_63_0.localEulerAngles

				var_63_6.z = 0
				var_63_6.x = 0
				var_63_0.localEulerAngles = var_63_6
			end

			if arg_60_1.time_ >= var_63_1 + var_63_2 and arg_60_1.time_ < var_63_1 + var_63_2 + arg_63_0 then
				var_63_0.localPosition = Vector3.New(0, -1.11, -5.88)

				local var_63_7 = manager.ui.mainCamera.transform.position - var_63_0.position

				var_63_0.forward = Vector3.New(var_63_7.x, var_63_7.y, var_63_7.z)

				local var_63_8 = var_63_0.localEulerAngles

				var_63_8.z = 0
				var_63_8.x = 0
				var_63_0.localEulerAngles = var_63_8
			end

			local var_63_9 = arg_60_1.actors_["1093ui_story"]
			local var_63_10 = 0

			if var_63_10 < arg_60_1.time_ and arg_60_1.time_ <= var_63_10 + arg_63_0 and not isNil(var_63_9) and arg_60_1.var_.characterEffect1093ui_story == nil then
				arg_60_1.var_.characterEffect1093ui_story = var_63_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_11 = 0.200000002980232

			if var_63_10 <= arg_60_1.time_ and arg_60_1.time_ < var_63_10 + var_63_11 and not isNil(var_63_9) then
				local var_63_12 = (arg_60_1.time_ - var_63_10) / var_63_11

				if arg_60_1.var_.characterEffect1093ui_story and not isNil(var_63_9) then
					arg_60_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_60_1.time_ >= var_63_10 + var_63_11 and arg_60_1.time_ < var_63_10 + var_63_11 + arg_63_0 and not isNil(var_63_9) and arg_60_1.var_.characterEffect1093ui_story then
				arg_60_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_63_13 = 0

			if var_63_13 < arg_60_1.time_ and arg_60_1.time_ <= var_63_13 + arg_63_0 then
				arg_60_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093actionlink/1093action486")
			end

			local var_63_14 = 0

			if var_63_14 < arg_60_1.time_ and arg_60_1.time_ <= var_63_14 + arg_63_0 then
				arg_60_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_63_15 = arg_60_1.actors_["1199ui_story"].transform
			local var_63_16 = 0

			if var_63_16 < arg_60_1.time_ and arg_60_1.time_ <= var_63_16 + arg_63_0 then
				arg_60_1.var_.moveOldPos1199ui_story = var_63_15.localPosition
			end

			local var_63_17 = 0.001

			if var_63_16 <= arg_60_1.time_ and arg_60_1.time_ < var_63_16 + var_63_17 then
				local var_63_18 = (arg_60_1.time_ - var_63_16) / var_63_17
				local var_63_19 = Vector3.New(0, 100, 0)

				var_63_15.localPosition = Vector3.Lerp(arg_60_1.var_.moveOldPos1199ui_story, var_63_19, var_63_18)

				local var_63_20 = manager.ui.mainCamera.transform.position - var_63_15.position

				var_63_15.forward = Vector3.New(var_63_20.x, var_63_20.y, var_63_20.z)

				local var_63_21 = var_63_15.localEulerAngles

				var_63_21.z = 0
				var_63_21.x = 0
				var_63_15.localEulerAngles = var_63_21
			end

			if arg_60_1.time_ >= var_63_16 + var_63_17 and arg_60_1.time_ < var_63_16 + var_63_17 + arg_63_0 then
				var_63_15.localPosition = Vector3.New(0, 100, 0)

				local var_63_22 = manager.ui.mainCamera.transform.position - var_63_15.position

				var_63_15.forward = Vector3.New(var_63_22.x, var_63_22.y, var_63_22.z)

				local var_63_23 = var_63_15.localEulerAngles

				var_63_23.z = 0
				var_63_23.x = 0
				var_63_15.localEulerAngles = var_63_23
			end

			local var_63_24 = arg_60_1.actors_["1199ui_story"]
			local var_63_25 = 0

			if var_63_25 < arg_60_1.time_ and arg_60_1.time_ <= var_63_25 + arg_63_0 and not isNil(var_63_24) and arg_60_1.var_.characterEffect1199ui_story == nil then
				arg_60_1.var_.characterEffect1199ui_story = var_63_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_26 = 0.200000002980232

			if var_63_25 <= arg_60_1.time_ and arg_60_1.time_ < var_63_25 + var_63_26 and not isNil(var_63_24) then
				local var_63_27 = (arg_60_1.time_ - var_63_25) / var_63_26

				if arg_60_1.var_.characterEffect1199ui_story and not isNil(var_63_24) then
					local var_63_28 = Mathf.Lerp(0, 0.5, var_63_27)

					arg_60_1.var_.characterEffect1199ui_story.fillFlat = true
					arg_60_1.var_.characterEffect1199ui_story.fillRatio = var_63_28
				end
			end

			if arg_60_1.time_ >= var_63_25 + var_63_26 and arg_60_1.time_ < var_63_25 + var_63_26 + arg_63_0 and not isNil(var_63_24) and arg_60_1.var_.characterEffect1199ui_story then
				local var_63_29 = 0.5

				arg_60_1.var_.characterEffect1199ui_story.fillFlat = true
				arg_60_1.var_.characterEffect1199ui_story.fillRatio = var_63_29
			end

			local var_63_30 = 0
			local var_63_31 = 0.675

			if var_63_30 < arg_60_1.time_ and arg_60_1.time_ <= var_63_30 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				local var_63_32 = arg_60_1:FormatText(StoryNameCfg[73].name)

				arg_60_1.leftNameTxt_.text = var_63_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_33 = arg_60_1:GetWordFromCfg(318211014)
				local var_63_34 = arg_60_1:FormatText(var_63_33.content)

				arg_60_1.text_.text = var_63_34

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_35 = 27
				local var_63_36 = utf8.len(var_63_34)
				local var_63_37 = var_63_35 <= 0 and var_63_31 or var_63_31 * (var_63_36 / var_63_35)

				if var_63_37 > 0 and var_63_31 < var_63_37 then
					arg_60_1.talkMaxDuration = var_63_37

					if var_63_37 + var_63_30 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_37 + var_63_30
					end
				end

				arg_60_1.text_.text = var_63_34
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318211", "318211014", "story_v_out_318211.awb") ~= 0 then
					local var_63_38 = manager.audio:GetVoiceLength("story_v_out_318211", "318211014", "story_v_out_318211.awb") / 1000

					if var_63_38 + var_63_30 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_38 + var_63_30
					end

					if var_63_33.prefab_name ~= "" and arg_60_1.actors_[var_63_33.prefab_name] ~= nil then
						local var_63_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_33.prefab_name].transform, "story_v_out_318211", "318211014", "story_v_out_318211.awb")

						arg_60_1:RecordAudio("318211014", var_63_39)
						arg_60_1:RecordAudio("318211014", var_63_39)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_318211", "318211014", "story_v_out_318211.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_318211", "318211014", "story_v_out_318211.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_40 = math.max(var_63_31, arg_60_1.talkMaxDuration)

			if var_63_30 <= arg_60_1.time_ and arg_60_1.time_ < var_63_30 + var_63_40 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_30) / var_63_40

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_30 + var_63_40 and arg_60_1.time_ < var_63_30 + var_63_40 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1199ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_60_1:InitPlayNodeList()
	end,
	Play318211015 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 318211015
		arg_64_1.duration_ = 8.67

		local var_64_0 = {
			zh = 8.666,
			ja = 6.833
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
				arg_64_0:Play318211016(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = 0
			local var_67_1 = 1.1

			if var_67_0 < arg_64_1.time_ and arg_64_1.time_ <= var_67_0 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				local var_67_2 = arg_64_1:FormatText(StoryNameCfg[73].name)

				arg_64_1.leftNameTxt_.text = var_67_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_3 = arg_64_1:GetWordFromCfg(318211015)
				local var_67_4 = arg_64_1:FormatText(var_67_3.content)

				arg_64_1.text_.text = var_67_4

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_5 = 44
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

				if manager.audio:GetVoiceLength("story_v_out_318211", "318211015", "story_v_out_318211.awb") ~= 0 then
					local var_67_8 = manager.audio:GetVoiceLength("story_v_out_318211", "318211015", "story_v_out_318211.awb") / 1000

					if var_67_8 + var_67_0 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_8 + var_67_0
					end

					if var_67_3.prefab_name ~= "" and arg_64_1.actors_[var_67_3.prefab_name] ~= nil then
						local var_67_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_3.prefab_name].transform, "story_v_out_318211", "318211015", "story_v_out_318211.awb")

						arg_64_1:RecordAudio("318211015", var_67_9)
						arg_64_1:RecordAudio("318211015", var_67_9)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_318211", "318211015", "story_v_out_318211.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_318211", "318211015", "story_v_out_318211.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_10 = math.max(var_67_1, arg_64_1.talkMaxDuration)

			if var_67_0 <= arg_64_1.time_ and arg_64_1.time_ < var_67_0 + var_67_10 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_0) / var_67_10

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_0 + var_67_10 and arg_64_1.time_ < var_67_0 + var_67_10 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {}

		arg_64_1:InitPlayNodeList()
	end,
	Play318211016 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 318211016
		arg_68_1.duration_ = 4.2

		local var_68_0 = {
			zh = 3.033,
			ja = 4.2
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
				arg_68_0:Play318211017(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = arg_68_1.actors_["1199ui_story"].transform
			local var_71_1 = 0

			if var_71_1 < arg_68_1.time_ and arg_68_1.time_ <= var_71_1 + arg_71_0 then
				arg_68_1.var_.moveOldPos1199ui_story = var_71_0.localPosition
			end

			local var_71_2 = 0.001

			if var_71_1 <= arg_68_1.time_ and arg_68_1.time_ < var_71_1 + var_71_2 then
				local var_71_3 = (arg_68_1.time_ - var_71_1) / var_71_2
				local var_71_4 = Vector3.New(0, -1.08, -5.9)

				var_71_0.localPosition = Vector3.Lerp(arg_68_1.var_.moveOldPos1199ui_story, var_71_4, var_71_3)

				local var_71_5 = manager.ui.mainCamera.transform.position - var_71_0.position

				var_71_0.forward = Vector3.New(var_71_5.x, var_71_5.y, var_71_5.z)

				local var_71_6 = var_71_0.localEulerAngles

				var_71_6.z = 0
				var_71_6.x = 0
				var_71_0.localEulerAngles = var_71_6
			end

			if arg_68_1.time_ >= var_71_1 + var_71_2 and arg_68_1.time_ < var_71_1 + var_71_2 + arg_71_0 then
				var_71_0.localPosition = Vector3.New(0, -1.08, -5.9)

				local var_71_7 = manager.ui.mainCamera.transform.position - var_71_0.position

				var_71_0.forward = Vector3.New(var_71_7.x, var_71_7.y, var_71_7.z)

				local var_71_8 = var_71_0.localEulerAngles

				var_71_8.z = 0
				var_71_8.x = 0
				var_71_0.localEulerAngles = var_71_8
			end

			local var_71_9 = arg_68_1.actors_["1199ui_story"]
			local var_71_10 = 0

			if var_71_10 < arg_68_1.time_ and arg_68_1.time_ <= var_71_10 + arg_71_0 and not isNil(var_71_9) and arg_68_1.var_.characterEffect1199ui_story == nil then
				arg_68_1.var_.characterEffect1199ui_story = var_71_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_11 = 0.200000002980232

			if var_71_10 <= arg_68_1.time_ and arg_68_1.time_ < var_71_10 + var_71_11 and not isNil(var_71_9) then
				local var_71_12 = (arg_68_1.time_ - var_71_10) / var_71_11

				if arg_68_1.var_.characterEffect1199ui_story and not isNil(var_71_9) then
					arg_68_1.var_.characterEffect1199ui_story.fillFlat = false
				end
			end

			if arg_68_1.time_ >= var_71_10 + var_71_11 and arg_68_1.time_ < var_71_10 + var_71_11 + arg_71_0 and not isNil(var_71_9) and arg_68_1.var_.characterEffect1199ui_story then
				arg_68_1.var_.characterEffect1199ui_story.fillFlat = false
			end

			local var_71_13 = 0

			if var_71_13 < arg_68_1.time_ and arg_68_1.time_ <= var_71_13 + arg_71_0 then
				arg_68_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/story1199/story1199action/1199action1_1")
			end

			local var_71_14 = 0

			if var_71_14 < arg_68_1.time_ and arg_68_1.time_ <= var_71_14 + arg_71_0 then
				arg_68_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_71_15 = arg_68_1.actors_["1093ui_story"].transform
			local var_71_16 = 0

			if var_71_16 < arg_68_1.time_ and arg_68_1.time_ <= var_71_16 + arg_71_0 then
				arg_68_1.var_.moveOldPos1093ui_story = var_71_15.localPosition
			end

			local var_71_17 = 0.001

			if var_71_16 <= arg_68_1.time_ and arg_68_1.time_ < var_71_16 + var_71_17 then
				local var_71_18 = (arg_68_1.time_ - var_71_16) / var_71_17
				local var_71_19 = Vector3.New(0, 100, 0)

				var_71_15.localPosition = Vector3.Lerp(arg_68_1.var_.moveOldPos1093ui_story, var_71_19, var_71_18)

				local var_71_20 = manager.ui.mainCamera.transform.position - var_71_15.position

				var_71_15.forward = Vector3.New(var_71_20.x, var_71_20.y, var_71_20.z)

				local var_71_21 = var_71_15.localEulerAngles

				var_71_21.z = 0
				var_71_21.x = 0
				var_71_15.localEulerAngles = var_71_21
			end

			if arg_68_1.time_ >= var_71_16 + var_71_17 and arg_68_1.time_ < var_71_16 + var_71_17 + arg_71_0 then
				var_71_15.localPosition = Vector3.New(0, 100, 0)

				local var_71_22 = manager.ui.mainCamera.transform.position - var_71_15.position

				var_71_15.forward = Vector3.New(var_71_22.x, var_71_22.y, var_71_22.z)

				local var_71_23 = var_71_15.localEulerAngles

				var_71_23.z = 0
				var_71_23.x = 0
				var_71_15.localEulerAngles = var_71_23
			end

			local var_71_24 = arg_68_1.actors_["1093ui_story"]
			local var_71_25 = 0

			if var_71_25 < arg_68_1.time_ and arg_68_1.time_ <= var_71_25 + arg_71_0 and not isNil(var_71_24) and arg_68_1.var_.characterEffect1093ui_story == nil then
				arg_68_1.var_.characterEffect1093ui_story = var_71_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_26 = 0.200000002980232

			if var_71_25 <= arg_68_1.time_ and arg_68_1.time_ < var_71_25 + var_71_26 and not isNil(var_71_24) then
				local var_71_27 = (arg_68_1.time_ - var_71_25) / var_71_26

				if arg_68_1.var_.characterEffect1093ui_story and not isNil(var_71_24) then
					local var_71_28 = Mathf.Lerp(0, 0.5, var_71_27)

					arg_68_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_68_1.var_.characterEffect1093ui_story.fillRatio = var_71_28
				end
			end

			if arg_68_1.time_ >= var_71_25 + var_71_26 and arg_68_1.time_ < var_71_25 + var_71_26 + arg_71_0 and not isNil(var_71_24) and arg_68_1.var_.characterEffect1093ui_story then
				local var_71_29 = 0.5

				arg_68_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_68_1.var_.characterEffect1093ui_story.fillRatio = var_71_29
			end

			local var_71_30 = 0
			local var_71_31 = 0.25

			if var_71_30 < arg_68_1.time_ and arg_68_1.time_ <= var_71_30 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				local var_71_32 = arg_68_1:FormatText(StoryNameCfg[84].name)

				arg_68_1.leftNameTxt_.text = var_71_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_33 = arg_68_1:GetWordFromCfg(318211016)
				local var_71_34 = arg_68_1:FormatText(var_71_33.content)

				arg_68_1.text_.text = var_71_34

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_35 = 10
				local var_71_36 = utf8.len(var_71_34)
				local var_71_37 = var_71_35 <= 0 and var_71_31 or var_71_31 * (var_71_36 / var_71_35)

				if var_71_37 > 0 and var_71_31 < var_71_37 then
					arg_68_1.talkMaxDuration = var_71_37

					if var_71_37 + var_71_30 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_37 + var_71_30
					end
				end

				arg_68_1.text_.text = var_71_34
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318211", "318211016", "story_v_out_318211.awb") ~= 0 then
					local var_71_38 = manager.audio:GetVoiceLength("story_v_out_318211", "318211016", "story_v_out_318211.awb") / 1000

					if var_71_38 + var_71_30 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_38 + var_71_30
					end

					if var_71_33.prefab_name ~= "" and arg_68_1.actors_[var_71_33.prefab_name] ~= nil then
						local var_71_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_33.prefab_name].transform, "story_v_out_318211", "318211016", "story_v_out_318211.awb")

						arg_68_1:RecordAudio("318211016", var_71_39)
						arg_68_1:RecordAudio("318211016", var_71_39)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_318211", "318211016", "story_v_out_318211.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_318211", "318211016", "story_v_out_318211.awb")
				end

				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_40 = math.max(var_71_31, arg_68_1.talkMaxDuration)

			if var_71_30 <= arg_68_1.time_ and arg_68_1.time_ < var_71_30 + var_71_40 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_30) / var_71_40

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_30 + var_71_40 and arg_68_1.time_ < var_71_30 + var_71_40 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1199ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_68_1:InitPlayNodeList()
	end,
	Play318211017 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 318211017
		arg_72_1.duration_ = 4.8

		local var_72_0 = {
			zh = 4.4,
			ja = 4.8
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
				arg_72_0:Play318211018(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = arg_72_1.actors_["1093ui_story"].transform
			local var_75_1 = 0

			if var_75_1 < arg_72_1.time_ and arg_72_1.time_ <= var_75_1 + arg_75_0 then
				arg_72_1.var_.moveOldPos1093ui_story = var_75_0.localPosition
			end

			local var_75_2 = 0.001

			if var_75_1 <= arg_72_1.time_ and arg_72_1.time_ < var_75_1 + var_75_2 then
				local var_75_3 = (arg_72_1.time_ - var_75_1) / var_75_2
				local var_75_4 = Vector3.New(0, -1.11, -5.88)

				var_75_0.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPos1093ui_story, var_75_4, var_75_3)

				local var_75_5 = manager.ui.mainCamera.transform.position - var_75_0.position

				var_75_0.forward = Vector3.New(var_75_5.x, var_75_5.y, var_75_5.z)

				local var_75_6 = var_75_0.localEulerAngles

				var_75_6.z = 0
				var_75_6.x = 0
				var_75_0.localEulerAngles = var_75_6
			end

			if arg_72_1.time_ >= var_75_1 + var_75_2 and arg_72_1.time_ < var_75_1 + var_75_2 + arg_75_0 then
				var_75_0.localPosition = Vector3.New(0, -1.11, -5.88)

				local var_75_7 = manager.ui.mainCamera.transform.position - var_75_0.position

				var_75_0.forward = Vector3.New(var_75_7.x, var_75_7.y, var_75_7.z)

				local var_75_8 = var_75_0.localEulerAngles

				var_75_8.z = 0
				var_75_8.x = 0
				var_75_0.localEulerAngles = var_75_8
			end

			local var_75_9 = arg_72_1.actors_["1093ui_story"]
			local var_75_10 = 0

			if var_75_10 < arg_72_1.time_ and arg_72_1.time_ <= var_75_10 + arg_75_0 and not isNil(var_75_9) and arg_72_1.var_.characterEffect1093ui_story == nil then
				arg_72_1.var_.characterEffect1093ui_story = var_75_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_11 = 0.200000002980232

			if var_75_10 <= arg_72_1.time_ and arg_72_1.time_ < var_75_10 + var_75_11 and not isNil(var_75_9) then
				local var_75_12 = (arg_72_1.time_ - var_75_10) / var_75_11

				if arg_72_1.var_.characterEffect1093ui_story and not isNil(var_75_9) then
					arg_72_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_72_1.time_ >= var_75_10 + var_75_11 and arg_72_1.time_ < var_75_10 + var_75_11 + arg_75_0 and not isNil(var_75_9) and arg_72_1.var_.characterEffect1093ui_story then
				arg_72_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_75_13 = arg_72_1.actors_["1199ui_story"].transform
			local var_75_14 = 0

			if var_75_14 < arg_72_1.time_ and arg_72_1.time_ <= var_75_14 + arg_75_0 then
				arg_72_1.var_.moveOldPos1199ui_story = var_75_13.localPosition
			end

			local var_75_15 = 0.001

			if var_75_14 <= arg_72_1.time_ and arg_72_1.time_ < var_75_14 + var_75_15 then
				local var_75_16 = (arg_72_1.time_ - var_75_14) / var_75_15
				local var_75_17 = Vector3.New(0, 100, 0)

				var_75_13.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPos1199ui_story, var_75_17, var_75_16)

				local var_75_18 = manager.ui.mainCamera.transform.position - var_75_13.position

				var_75_13.forward = Vector3.New(var_75_18.x, var_75_18.y, var_75_18.z)

				local var_75_19 = var_75_13.localEulerAngles

				var_75_19.z = 0
				var_75_19.x = 0
				var_75_13.localEulerAngles = var_75_19
			end

			if arg_72_1.time_ >= var_75_14 + var_75_15 and arg_72_1.time_ < var_75_14 + var_75_15 + arg_75_0 then
				var_75_13.localPosition = Vector3.New(0, 100, 0)

				local var_75_20 = manager.ui.mainCamera.transform.position - var_75_13.position

				var_75_13.forward = Vector3.New(var_75_20.x, var_75_20.y, var_75_20.z)

				local var_75_21 = var_75_13.localEulerAngles

				var_75_21.z = 0
				var_75_21.x = 0
				var_75_13.localEulerAngles = var_75_21
			end

			local var_75_22 = arg_72_1.actors_["1199ui_story"]
			local var_75_23 = 0

			if var_75_23 < arg_72_1.time_ and arg_72_1.time_ <= var_75_23 + arg_75_0 and not isNil(var_75_22) and arg_72_1.var_.characterEffect1199ui_story == nil then
				arg_72_1.var_.characterEffect1199ui_story = var_75_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_24 = 0.200000002980232

			if var_75_23 <= arg_72_1.time_ and arg_72_1.time_ < var_75_23 + var_75_24 and not isNil(var_75_22) then
				local var_75_25 = (arg_72_1.time_ - var_75_23) / var_75_24

				if arg_72_1.var_.characterEffect1199ui_story and not isNil(var_75_22) then
					local var_75_26 = Mathf.Lerp(0, 0.5, var_75_25)

					arg_72_1.var_.characterEffect1199ui_story.fillFlat = true
					arg_72_1.var_.characterEffect1199ui_story.fillRatio = var_75_26
				end
			end

			if arg_72_1.time_ >= var_75_23 + var_75_24 and arg_72_1.time_ < var_75_23 + var_75_24 + arg_75_0 and not isNil(var_75_22) and arg_72_1.var_.characterEffect1199ui_story then
				local var_75_27 = 0.5

				arg_72_1.var_.characterEffect1199ui_story.fillFlat = true
				arg_72_1.var_.characterEffect1199ui_story.fillRatio = var_75_27
			end

			local var_75_28 = 0
			local var_75_29 = 0.5

			if var_75_28 < arg_72_1.time_ and arg_72_1.time_ <= var_75_28 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				local var_75_30 = arg_72_1:FormatText(StoryNameCfg[73].name)

				arg_72_1.leftNameTxt_.text = var_75_30

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_31 = arg_72_1:GetWordFromCfg(318211017)
				local var_75_32 = arg_72_1:FormatText(var_75_31.content)

				arg_72_1.text_.text = var_75_32

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_33 = 20
				local var_75_34 = utf8.len(var_75_32)
				local var_75_35 = var_75_33 <= 0 and var_75_29 or var_75_29 * (var_75_34 / var_75_33)

				if var_75_35 > 0 and var_75_29 < var_75_35 then
					arg_72_1.talkMaxDuration = var_75_35

					if var_75_35 + var_75_28 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_35 + var_75_28
					end
				end

				arg_72_1.text_.text = var_75_32
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318211", "318211017", "story_v_out_318211.awb") ~= 0 then
					local var_75_36 = manager.audio:GetVoiceLength("story_v_out_318211", "318211017", "story_v_out_318211.awb") / 1000

					if var_75_36 + var_75_28 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_36 + var_75_28
					end

					if var_75_31.prefab_name ~= "" and arg_72_1.actors_[var_75_31.prefab_name] ~= nil then
						local var_75_37 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_31.prefab_name].transform, "story_v_out_318211", "318211017", "story_v_out_318211.awb")

						arg_72_1:RecordAudio("318211017", var_75_37)
						arg_72_1:RecordAudio("318211017", var_75_37)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_318211", "318211017", "story_v_out_318211.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_318211", "318211017", "story_v_out_318211.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_38 = math.max(var_75_29, arg_72_1.talkMaxDuration)

			if var_75_28 <= arg_72_1.time_ and arg_72_1.time_ < var_75_28 + var_75_38 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_28) / var_75_38

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_28 + var_75_38 and arg_72_1.time_ < var_75_28 + var_75_38 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1199ui_story",
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
	Play318211018 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 318211018
		arg_76_1.duration_ = 4.5

		local var_76_0 = {
			zh = 2.3,
			ja = 4.5
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
				arg_76_0:Play318211019(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = arg_76_1.actors_["1093ui_story"].transform
			local var_79_1 = 0

			if var_79_1 < arg_76_1.time_ and arg_76_1.time_ <= var_79_1 + arg_79_0 then
				arg_76_1.var_.moveOldPos1093ui_story = var_79_0.localPosition
			end

			local var_79_2 = 0.001

			if var_79_1 <= arg_76_1.time_ and arg_76_1.time_ < var_79_1 + var_79_2 then
				local var_79_3 = (arg_76_1.time_ - var_79_1) / var_79_2
				local var_79_4 = Vector3.New(0, -1.11, -5.88)

				var_79_0.localPosition = Vector3.Lerp(arg_76_1.var_.moveOldPos1093ui_story, var_79_4, var_79_3)

				local var_79_5 = manager.ui.mainCamera.transform.position - var_79_0.position

				var_79_0.forward = Vector3.New(var_79_5.x, var_79_5.y, var_79_5.z)

				local var_79_6 = var_79_0.localEulerAngles

				var_79_6.z = 0
				var_79_6.x = 0
				var_79_0.localEulerAngles = var_79_6
			end

			if arg_76_1.time_ >= var_79_1 + var_79_2 and arg_76_1.time_ < var_79_1 + var_79_2 + arg_79_0 then
				var_79_0.localPosition = Vector3.New(0, -1.11, -5.88)

				local var_79_7 = manager.ui.mainCamera.transform.position - var_79_0.position

				var_79_0.forward = Vector3.New(var_79_7.x, var_79_7.y, var_79_7.z)

				local var_79_8 = var_79_0.localEulerAngles

				var_79_8.z = 0
				var_79_8.x = 0
				var_79_0.localEulerAngles = var_79_8
			end

			local var_79_9 = arg_76_1.actors_["1093ui_story"]
			local var_79_10 = 0

			if var_79_10 < arg_76_1.time_ and arg_76_1.time_ <= var_79_10 + arg_79_0 and not isNil(var_79_9) and arg_76_1.var_.characterEffect1093ui_story == nil then
				arg_76_1.var_.characterEffect1093ui_story = var_79_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_11 = 0.200000002980232

			if var_79_10 <= arg_76_1.time_ and arg_76_1.time_ < var_79_10 + var_79_11 and not isNil(var_79_9) then
				local var_79_12 = (arg_76_1.time_ - var_79_10) / var_79_11

				if arg_76_1.var_.characterEffect1093ui_story and not isNil(var_79_9) then
					arg_76_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_76_1.time_ >= var_79_10 + var_79_11 and arg_76_1.time_ < var_79_10 + var_79_11 + arg_79_0 and not isNil(var_79_9) and arg_76_1.var_.characterEffect1093ui_story then
				arg_76_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_79_13 = 0

			if var_79_13 < arg_76_1.time_ and arg_76_1.time_ <= var_79_13 + arg_79_0 then
				arg_76_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action6_2")
			end

			local var_79_14 = 0

			if var_79_14 < arg_76_1.time_ and arg_76_1.time_ <= var_79_14 + arg_79_0 then
				arg_76_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_79_15 = 0
			local var_79_16 = 0.275

			if var_79_15 < arg_76_1.time_ and arg_76_1.time_ <= var_79_15 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				local var_79_17 = arg_76_1:FormatText(StoryNameCfg[73].name)

				arg_76_1.leftNameTxt_.text = var_79_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_18 = arg_76_1:GetWordFromCfg(318211018)
				local var_79_19 = arg_76_1:FormatText(var_79_18.content)

				arg_76_1.text_.text = var_79_19

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_20 = 11
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

				if manager.audio:GetVoiceLength("story_v_out_318211", "318211018", "story_v_out_318211.awb") ~= 0 then
					local var_79_23 = manager.audio:GetVoiceLength("story_v_out_318211", "318211018", "story_v_out_318211.awb") / 1000

					if var_79_23 + var_79_15 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_23 + var_79_15
					end

					if var_79_18.prefab_name ~= "" and arg_76_1.actors_[var_79_18.prefab_name] ~= nil then
						local var_79_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_18.prefab_name].transform, "story_v_out_318211", "318211018", "story_v_out_318211.awb")

						arg_76_1:RecordAudio("318211018", var_79_24)
						arg_76_1:RecordAudio("318211018", var_79_24)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_318211", "318211018", "story_v_out_318211.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_318211", "318211018", "story_v_out_318211.awb")
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
				actorName = "1093ui_story",
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
	Play318211019 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 318211019
		arg_80_1.duration_ = 5.7

		local var_80_0 = {
			zh = 4.5,
			ja = 5.7
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
				arg_80_0:Play318211020(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = arg_80_1.actors_["1150ui_story"].transform
			local var_83_1 = 0

			if var_83_1 < arg_80_1.time_ and arg_80_1.time_ <= var_83_1 + arg_83_0 then
				arg_80_1.var_.moveOldPos1150ui_story = var_83_0.localPosition
			end

			local var_83_2 = 0.001

			if var_83_1 <= arg_80_1.time_ and arg_80_1.time_ < var_83_1 + var_83_2 then
				local var_83_3 = (arg_80_1.time_ - var_83_1) / var_83_2
				local var_83_4 = Vector3.New(0.7, -1.01, -6.2)

				var_83_0.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPos1150ui_story, var_83_4, var_83_3)

				local var_83_5 = manager.ui.mainCamera.transform.position - var_83_0.position

				var_83_0.forward = Vector3.New(var_83_5.x, var_83_5.y, var_83_5.z)

				local var_83_6 = var_83_0.localEulerAngles

				var_83_6.z = 0
				var_83_6.x = 0
				var_83_0.localEulerAngles = var_83_6
			end

			if arg_80_1.time_ >= var_83_1 + var_83_2 and arg_80_1.time_ < var_83_1 + var_83_2 + arg_83_0 then
				var_83_0.localPosition = Vector3.New(0.7, -1.01, -6.2)

				local var_83_7 = manager.ui.mainCamera.transform.position - var_83_0.position

				var_83_0.forward = Vector3.New(var_83_7.x, var_83_7.y, var_83_7.z)

				local var_83_8 = var_83_0.localEulerAngles

				var_83_8.z = 0
				var_83_8.x = 0
				var_83_0.localEulerAngles = var_83_8
			end

			local var_83_9 = arg_80_1.actors_["1150ui_story"]
			local var_83_10 = 0

			if var_83_10 < arg_80_1.time_ and arg_80_1.time_ <= var_83_10 + arg_83_0 and not isNil(var_83_9) and arg_80_1.var_.characterEffect1150ui_story == nil then
				arg_80_1.var_.characterEffect1150ui_story = var_83_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_11 = 0.200000002980232

			if var_83_10 <= arg_80_1.time_ and arg_80_1.time_ < var_83_10 + var_83_11 and not isNil(var_83_9) then
				local var_83_12 = (arg_80_1.time_ - var_83_10) / var_83_11

				if arg_80_1.var_.characterEffect1150ui_story and not isNil(var_83_9) then
					arg_80_1.var_.characterEffect1150ui_story.fillFlat = false
				end
			end

			if arg_80_1.time_ >= var_83_10 + var_83_11 and arg_80_1.time_ < var_83_10 + var_83_11 + arg_83_0 and not isNil(var_83_9) and arg_80_1.var_.characterEffect1150ui_story then
				arg_80_1.var_.characterEffect1150ui_story.fillFlat = false
			end

			local var_83_13 = 0

			if var_83_13 < arg_80_1.time_ and arg_80_1.time_ <= var_83_13 + arg_83_0 then
				arg_80_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/story1150/story1150action/1150action1_1")
			end

			local var_83_14 = 0

			if var_83_14 < arg_80_1.time_ and arg_80_1.time_ <= var_83_14 + arg_83_0 then
				arg_80_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_83_15 = arg_80_1.actors_["1093ui_story"].transform
			local var_83_16 = 0

			if var_83_16 < arg_80_1.time_ and arg_80_1.time_ <= var_83_16 + arg_83_0 then
				arg_80_1.var_.moveOldPos1093ui_story = var_83_15.localPosition
			end

			local var_83_17 = 0.001

			if var_83_16 <= arg_80_1.time_ and arg_80_1.time_ < var_83_16 + var_83_17 then
				local var_83_18 = (arg_80_1.time_ - var_83_16) / var_83_17
				local var_83_19 = Vector3.New(-0.7, -1.11, -5.88)

				var_83_15.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPos1093ui_story, var_83_19, var_83_18)

				local var_83_20 = manager.ui.mainCamera.transform.position - var_83_15.position

				var_83_15.forward = Vector3.New(var_83_20.x, var_83_20.y, var_83_20.z)

				local var_83_21 = var_83_15.localEulerAngles

				var_83_21.z = 0
				var_83_21.x = 0
				var_83_15.localEulerAngles = var_83_21
			end

			if arg_80_1.time_ >= var_83_16 + var_83_17 and arg_80_1.time_ < var_83_16 + var_83_17 + arg_83_0 then
				var_83_15.localPosition = Vector3.New(-0.7, -1.11, -5.88)

				local var_83_22 = manager.ui.mainCamera.transform.position - var_83_15.position

				var_83_15.forward = Vector3.New(var_83_22.x, var_83_22.y, var_83_22.z)

				local var_83_23 = var_83_15.localEulerAngles

				var_83_23.z = 0
				var_83_23.x = 0
				var_83_15.localEulerAngles = var_83_23
			end

			local var_83_24 = arg_80_1.actors_["1093ui_story"]
			local var_83_25 = 0

			if var_83_25 < arg_80_1.time_ and arg_80_1.time_ <= var_83_25 + arg_83_0 and not isNil(var_83_24) and arg_80_1.var_.characterEffect1093ui_story == nil then
				arg_80_1.var_.characterEffect1093ui_story = var_83_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_26 = 0.200000002980232

			if var_83_25 <= arg_80_1.time_ and arg_80_1.time_ < var_83_25 + var_83_26 and not isNil(var_83_24) then
				local var_83_27 = (arg_80_1.time_ - var_83_25) / var_83_26

				if arg_80_1.var_.characterEffect1093ui_story and not isNil(var_83_24) then
					local var_83_28 = Mathf.Lerp(0, 0.5, var_83_27)

					arg_80_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_80_1.var_.characterEffect1093ui_story.fillRatio = var_83_28
				end
			end

			if arg_80_1.time_ >= var_83_25 + var_83_26 and arg_80_1.time_ < var_83_25 + var_83_26 + arg_83_0 and not isNil(var_83_24) and arg_80_1.var_.characterEffect1093ui_story then
				local var_83_29 = 0.5

				arg_80_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_80_1.var_.characterEffect1093ui_story.fillRatio = var_83_29
			end

			local var_83_30 = 0
			local var_83_31 = 0.65

			if var_83_30 < arg_80_1.time_ and arg_80_1.time_ <= var_83_30 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				local var_83_32 = arg_80_1:FormatText(StoryNameCfg[74].name)

				arg_80_1.leftNameTxt_.text = var_83_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_33 = arg_80_1:GetWordFromCfg(318211019)
				local var_83_34 = arg_80_1:FormatText(var_83_33.content)

				arg_80_1.text_.text = var_83_34

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_35 = 26
				local var_83_36 = utf8.len(var_83_34)
				local var_83_37 = var_83_35 <= 0 and var_83_31 or var_83_31 * (var_83_36 / var_83_35)

				if var_83_37 > 0 and var_83_31 < var_83_37 then
					arg_80_1.talkMaxDuration = var_83_37

					if var_83_37 + var_83_30 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_37 + var_83_30
					end
				end

				arg_80_1.text_.text = var_83_34
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318211", "318211019", "story_v_out_318211.awb") ~= 0 then
					local var_83_38 = manager.audio:GetVoiceLength("story_v_out_318211", "318211019", "story_v_out_318211.awb") / 1000

					if var_83_38 + var_83_30 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_38 + var_83_30
					end

					if var_83_33.prefab_name ~= "" and arg_80_1.actors_[var_83_33.prefab_name] ~= nil then
						local var_83_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_33.prefab_name].transform, "story_v_out_318211", "318211019", "story_v_out_318211.awb")

						arg_80_1:RecordAudio("318211019", var_83_39)
						arg_80_1:RecordAudio("318211019", var_83_39)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_out_318211", "318211019", "story_v_out_318211.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_out_318211", "318211019", "story_v_out_318211.awb")
				end

				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_40 = math.max(var_83_31, arg_80_1.talkMaxDuration)

			if var_83_30 <= arg_80_1.time_ and arg_80_1.time_ < var_83_30 + var_83_40 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_30) / var_83_40

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_30 + var_83_40 and arg_80_1.time_ < var_83_30 + var_83_40 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_80_1:InitPlayNodeList()
	end,
	Play318211020 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 318211020
		arg_84_1.duration_ = 5

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play318211021(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = arg_84_1.actors_["1150ui_story"]
			local var_87_1 = 0

			if var_87_1 < arg_84_1.time_ and arg_84_1.time_ <= var_87_1 + arg_87_0 and not isNil(var_87_0) and arg_84_1.var_.characterEffect1150ui_story == nil then
				arg_84_1.var_.characterEffect1150ui_story = var_87_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_2 = 0.200000002980232

			if var_87_1 <= arg_84_1.time_ and arg_84_1.time_ < var_87_1 + var_87_2 and not isNil(var_87_0) then
				local var_87_3 = (arg_84_1.time_ - var_87_1) / var_87_2

				if arg_84_1.var_.characterEffect1150ui_story and not isNil(var_87_0) then
					local var_87_4 = Mathf.Lerp(0, 0.5, var_87_3)

					arg_84_1.var_.characterEffect1150ui_story.fillFlat = true
					arg_84_1.var_.characterEffect1150ui_story.fillRatio = var_87_4
				end
			end

			if arg_84_1.time_ >= var_87_1 + var_87_2 and arg_84_1.time_ < var_87_1 + var_87_2 + arg_87_0 and not isNil(var_87_0) and arg_84_1.var_.characterEffect1150ui_story then
				local var_87_5 = 0.5

				arg_84_1.var_.characterEffect1150ui_story.fillFlat = true
				arg_84_1.var_.characterEffect1150ui_story.fillRatio = var_87_5
			end

			local var_87_6 = 0
			local var_87_7 = 0.6

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

				local var_87_8 = arg_84_1:GetWordFromCfg(318211020)
				local var_87_9 = arg_84_1:FormatText(var_87_8.content)

				arg_84_1.text_.text = var_87_9

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_10 = 24
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
	Play318211021 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 318211021
		arg_88_1.duration_ = 7.37

		local var_88_0 = {
			zh = 5.766,
			ja = 7.366
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
				arg_88_0:Play318211022(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = arg_88_1.actors_["1150ui_story"]
			local var_91_1 = 0

			if var_91_1 < arg_88_1.time_ and arg_88_1.time_ <= var_91_1 + arg_91_0 and not isNil(var_91_0) and arg_88_1.var_.characterEffect1150ui_story == nil then
				arg_88_1.var_.characterEffect1150ui_story = var_91_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_2 = 0.200000002980232

			if var_91_1 <= arg_88_1.time_ and arg_88_1.time_ < var_91_1 + var_91_2 and not isNil(var_91_0) then
				local var_91_3 = (arg_88_1.time_ - var_91_1) / var_91_2

				if arg_88_1.var_.characterEffect1150ui_story and not isNil(var_91_0) then
					arg_88_1.var_.characterEffect1150ui_story.fillFlat = false
				end
			end

			if arg_88_1.time_ >= var_91_1 + var_91_2 and arg_88_1.time_ < var_91_1 + var_91_2 + arg_91_0 and not isNil(var_91_0) and arg_88_1.var_.characterEffect1150ui_story then
				arg_88_1.var_.characterEffect1150ui_story.fillFlat = false
			end

			local var_91_4 = 0

			if var_91_4 < arg_88_1.time_ and arg_88_1.time_ <= var_91_4 + arg_91_0 then
				arg_88_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/story1150/story1150action/1150action4_1")
			end

			local var_91_5 = 0
			local var_91_6 = 0.825

			if var_91_5 < arg_88_1.time_ and arg_88_1.time_ <= var_91_5 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				local var_91_7 = arg_88_1:FormatText(StoryNameCfg[74].name)

				arg_88_1.leftNameTxt_.text = var_91_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_8 = arg_88_1:GetWordFromCfg(318211021)
				local var_91_9 = arg_88_1:FormatText(var_91_8.content)

				arg_88_1.text_.text = var_91_9

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_10 = 33
				local var_91_11 = utf8.len(var_91_9)
				local var_91_12 = var_91_10 <= 0 and var_91_6 or var_91_6 * (var_91_11 / var_91_10)

				if var_91_12 > 0 and var_91_6 < var_91_12 then
					arg_88_1.talkMaxDuration = var_91_12

					if var_91_12 + var_91_5 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_12 + var_91_5
					end
				end

				arg_88_1.text_.text = var_91_9
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318211", "318211021", "story_v_out_318211.awb") ~= 0 then
					local var_91_13 = manager.audio:GetVoiceLength("story_v_out_318211", "318211021", "story_v_out_318211.awb") / 1000

					if var_91_13 + var_91_5 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_13 + var_91_5
					end

					if var_91_8.prefab_name ~= "" and arg_88_1.actors_[var_91_8.prefab_name] ~= nil then
						local var_91_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_88_1.actors_[var_91_8.prefab_name].transform, "story_v_out_318211", "318211021", "story_v_out_318211.awb")

						arg_88_1:RecordAudio("318211021", var_91_14)
						arg_88_1:RecordAudio("318211021", var_91_14)
					else
						arg_88_1:AudioAction("play", "voice", "story_v_out_318211", "318211021", "story_v_out_318211.awb")
					end

					arg_88_1:RecordHistoryTalkVoice("story_v_out_318211", "318211021", "story_v_out_318211.awb")
				end

				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_15 = math.max(var_91_6, arg_88_1.talkMaxDuration)

			if var_91_5 <= arg_88_1.time_ and arg_88_1.time_ < var_91_5 + var_91_15 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_5) / var_91_15

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_5 + var_91_15 and arg_88_1.time_ < var_91_5 + var_91_15 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {}

		arg_88_1:InitPlayNodeList()
	end,
	Play318211022 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 318211022
		arg_92_1.duration_ = 5.27

		local var_92_0 = {
			zh = 5.266,
			ja = 4.666
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
				arg_92_0:Play318211023(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			local var_95_0 = arg_92_1.actors_["1093ui_story"]
			local var_95_1 = 0

			if var_95_1 < arg_92_1.time_ and arg_92_1.time_ <= var_95_1 + arg_95_0 and not isNil(var_95_0) and arg_92_1.var_.characterEffect1093ui_story == nil then
				arg_92_1.var_.characterEffect1093ui_story = var_95_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_2 = 0.200000002980232

			if var_95_1 <= arg_92_1.time_ and arg_92_1.time_ < var_95_1 + var_95_2 and not isNil(var_95_0) then
				local var_95_3 = (arg_92_1.time_ - var_95_1) / var_95_2

				if arg_92_1.var_.characterEffect1093ui_story and not isNil(var_95_0) then
					arg_92_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_92_1.time_ >= var_95_1 + var_95_2 and arg_92_1.time_ < var_95_1 + var_95_2 + arg_95_0 and not isNil(var_95_0) and arg_92_1.var_.characterEffect1093ui_story then
				arg_92_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_95_4 = arg_92_1.actors_["1150ui_story"]
			local var_95_5 = 0

			if var_95_5 < arg_92_1.time_ and arg_92_1.time_ <= var_95_5 + arg_95_0 and not isNil(var_95_4) and arg_92_1.var_.characterEffect1150ui_story == nil then
				arg_92_1.var_.characterEffect1150ui_story = var_95_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_6 = 0.200000002980232

			if var_95_5 <= arg_92_1.time_ and arg_92_1.time_ < var_95_5 + var_95_6 and not isNil(var_95_4) then
				local var_95_7 = (arg_92_1.time_ - var_95_5) / var_95_6

				if arg_92_1.var_.characterEffect1150ui_story and not isNil(var_95_4) then
					local var_95_8 = Mathf.Lerp(0, 0.5, var_95_7)

					arg_92_1.var_.characterEffect1150ui_story.fillFlat = true
					arg_92_1.var_.characterEffect1150ui_story.fillRatio = var_95_8
				end
			end

			if arg_92_1.time_ >= var_95_5 + var_95_6 and arg_92_1.time_ < var_95_5 + var_95_6 + arg_95_0 and not isNil(var_95_4) and arg_92_1.var_.characterEffect1150ui_story then
				local var_95_9 = 0.5

				arg_92_1.var_.characterEffect1150ui_story.fillFlat = true
				arg_92_1.var_.characterEffect1150ui_story.fillRatio = var_95_9
			end

			local var_95_10 = 0
			local var_95_11 = 0.65

			if var_95_10 < arg_92_1.time_ and arg_92_1.time_ <= var_95_10 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				local var_95_12 = arg_92_1:FormatText(StoryNameCfg[73].name)

				arg_92_1.leftNameTxt_.text = var_95_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_13 = arg_92_1:GetWordFromCfg(318211022)
				local var_95_14 = arg_92_1:FormatText(var_95_13.content)

				arg_92_1.text_.text = var_95_14

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_15 = 26
				local var_95_16 = utf8.len(var_95_14)
				local var_95_17 = var_95_15 <= 0 and var_95_11 or var_95_11 * (var_95_16 / var_95_15)

				if var_95_17 > 0 and var_95_11 < var_95_17 then
					arg_92_1.talkMaxDuration = var_95_17

					if var_95_17 + var_95_10 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_17 + var_95_10
					end
				end

				arg_92_1.text_.text = var_95_14
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318211", "318211022", "story_v_out_318211.awb") ~= 0 then
					local var_95_18 = manager.audio:GetVoiceLength("story_v_out_318211", "318211022", "story_v_out_318211.awb") / 1000

					if var_95_18 + var_95_10 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_18 + var_95_10
					end

					if var_95_13.prefab_name ~= "" and arg_92_1.actors_[var_95_13.prefab_name] ~= nil then
						local var_95_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_13.prefab_name].transform, "story_v_out_318211", "318211022", "story_v_out_318211.awb")

						arg_92_1:RecordAudio("318211022", var_95_19)
						arg_92_1:RecordAudio("318211022", var_95_19)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_out_318211", "318211022", "story_v_out_318211.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_out_318211", "318211022", "story_v_out_318211.awb")
				end

				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_20 = math.max(var_95_11, arg_92_1.talkMaxDuration)

			if var_95_10 <= arg_92_1.time_ and arg_92_1.time_ < var_95_10 + var_95_20 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_10) / var_95_20

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_10 + var_95_20 and arg_92_1.time_ < var_95_10 + var_95_20 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {}

		arg_92_1:InitPlayNodeList()
	end,
	Play318211023 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 318211023
		arg_96_1.duration_ = 7.97

		local var_96_0 = {
			zh = 3.2,
			ja = 7.966
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
				arg_96_0:Play318211024(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			local var_99_0 = arg_96_1.actors_["1150ui_story"]
			local var_99_1 = 0

			if var_99_1 < arg_96_1.time_ and arg_96_1.time_ <= var_99_1 + arg_99_0 and not isNil(var_99_0) and arg_96_1.var_.characterEffect1150ui_story == nil then
				arg_96_1.var_.characterEffect1150ui_story = var_99_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_2 = 0.200000002980232

			if var_99_1 <= arg_96_1.time_ and arg_96_1.time_ < var_99_1 + var_99_2 and not isNil(var_99_0) then
				local var_99_3 = (arg_96_1.time_ - var_99_1) / var_99_2

				if arg_96_1.var_.characterEffect1150ui_story and not isNil(var_99_0) then
					arg_96_1.var_.characterEffect1150ui_story.fillFlat = false
				end
			end

			if arg_96_1.time_ >= var_99_1 + var_99_2 and arg_96_1.time_ < var_99_1 + var_99_2 + arg_99_0 and not isNil(var_99_0) and arg_96_1.var_.characterEffect1150ui_story then
				arg_96_1.var_.characterEffect1150ui_story.fillFlat = false
			end

			local var_99_4 = arg_96_1.actors_["1093ui_story"]
			local var_99_5 = 0

			if var_99_5 < arg_96_1.time_ and arg_96_1.time_ <= var_99_5 + arg_99_0 and not isNil(var_99_4) and arg_96_1.var_.characterEffect1093ui_story == nil then
				arg_96_1.var_.characterEffect1093ui_story = var_99_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_6 = 0.200000002980232

			if var_99_5 <= arg_96_1.time_ and arg_96_1.time_ < var_99_5 + var_99_6 and not isNil(var_99_4) then
				local var_99_7 = (arg_96_1.time_ - var_99_5) / var_99_6

				if arg_96_1.var_.characterEffect1093ui_story and not isNil(var_99_4) then
					local var_99_8 = Mathf.Lerp(0, 0.5, var_99_7)

					arg_96_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_96_1.var_.characterEffect1093ui_story.fillRatio = var_99_8
				end
			end

			if arg_96_1.time_ >= var_99_5 + var_99_6 and arg_96_1.time_ < var_99_5 + var_99_6 + arg_99_0 and not isNil(var_99_4) and arg_96_1.var_.characterEffect1093ui_story then
				local var_99_9 = 0.5

				arg_96_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_96_1.var_.characterEffect1093ui_story.fillRatio = var_99_9
			end

			local var_99_10 = 0
			local var_99_11 = 0.325

			if var_99_10 < arg_96_1.time_ and arg_96_1.time_ <= var_99_10 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				local var_99_12 = arg_96_1:FormatText(StoryNameCfg[74].name)

				arg_96_1.leftNameTxt_.text = var_99_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_13 = arg_96_1:GetWordFromCfg(318211023)
				local var_99_14 = arg_96_1:FormatText(var_99_13.content)

				arg_96_1.text_.text = var_99_14

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_15 = 13
				local var_99_16 = utf8.len(var_99_14)
				local var_99_17 = var_99_15 <= 0 and var_99_11 or var_99_11 * (var_99_16 / var_99_15)

				if var_99_17 > 0 and var_99_11 < var_99_17 then
					arg_96_1.talkMaxDuration = var_99_17

					if var_99_17 + var_99_10 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_17 + var_99_10
					end
				end

				arg_96_1.text_.text = var_99_14
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318211", "318211023", "story_v_out_318211.awb") ~= 0 then
					local var_99_18 = manager.audio:GetVoiceLength("story_v_out_318211", "318211023", "story_v_out_318211.awb") / 1000

					if var_99_18 + var_99_10 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_18 + var_99_10
					end

					if var_99_13.prefab_name ~= "" and arg_96_1.actors_[var_99_13.prefab_name] ~= nil then
						local var_99_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_96_1.actors_[var_99_13.prefab_name].transform, "story_v_out_318211", "318211023", "story_v_out_318211.awb")

						arg_96_1:RecordAudio("318211023", var_99_19)
						arg_96_1:RecordAudio("318211023", var_99_19)
					else
						arg_96_1:AudioAction("play", "voice", "story_v_out_318211", "318211023", "story_v_out_318211.awb")
					end

					arg_96_1:RecordHistoryTalkVoice("story_v_out_318211", "318211023", "story_v_out_318211.awb")
				end

				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_20 = math.max(var_99_11, arg_96_1.talkMaxDuration)

			if var_99_10 <= arg_96_1.time_ and arg_96_1.time_ < var_99_10 + var_99_20 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_10) / var_99_20

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_10 + var_99_20 and arg_96_1.time_ < var_99_10 + var_99_20 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {}

		arg_96_1:InitPlayNodeList()
	end,
	Play318211024 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 318211024
		arg_100_1.duration_ = 3.97

		local var_100_0 = {
			zh = 3.966,
			ja = 1.999999999999
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
				arg_100_0:Play318211025(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			local var_103_0 = arg_100_1.actors_["1199ui_story"].transform
			local var_103_1 = 0

			if var_103_1 < arg_100_1.time_ and arg_100_1.time_ <= var_103_1 + arg_103_0 then
				arg_100_1.var_.moveOldPos1199ui_story = var_103_0.localPosition
			end

			local var_103_2 = 0.001

			if var_103_1 <= arg_100_1.time_ and arg_100_1.time_ < var_103_1 + var_103_2 then
				local var_103_3 = (arg_100_1.time_ - var_103_1) / var_103_2
				local var_103_4 = Vector3.New(0, -1.08, -5.9)

				var_103_0.localPosition = Vector3.Lerp(arg_100_1.var_.moveOldPos1199ui_story, var_103_4, var_103_3)

				local var_103_5 = manager.ui.mainCamera.transform.position - var_103_0.position

				var_103_0.forward = Vector3.New(var_103_5.x, var_103_5.y, var_103_5.z)

				local var_103_6 = var_103_0.localEulerAngles

				var_103_6.z = 0
				var_103_6.x = 0
				var_103_0.localEulerAngles = var_103_6
			end

			if arg_100_1.time_ >= var_103_1 + var_103_2 and arg_100_1.time_ < var_103_1 + var_103_2 + arg_103_0 then
				var_103_0.localPosition = Vector3.New(0, -1.08, -5.9)

				local var_103_7 = manager.ui.mainCamera.transform.position - var_103_0.position

				var_103_0.forward = Vector3.New(var_103_7.x, var_103_7.y, var_103_7.z)

				local var_103_8 = var_103_0.localEulerAngles

				var_103_8.z = 0
				var_103_8.x = 0
				var_103_0.localEulerAngles = var_103_8
			end

			local var_103_9 = arg_100_1.actors_["1199ui_story"]
			local var_103_10 = 0

			if var_103_10 < arg_100_1.time_ and arg_100_1.time_ <= var_103_10 + arg_103_0 and not isNil(var_103_9) and arg_100_1.var_.characterEffect1199ui_story == nil then
				arg_100_1.var_.characterEffect1199ui_story = var_103_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_103_11 = 0.200000002980232

			if var_103_10 <= arg_100_1.time_ and arg_100_1.time_ < var_103_10 + var_103_11 and not isNil(var_103_9) then
				local var_103_12 = (arg_100_1.time_ - var_103_10) / var_103_11

				if arg_100_1.var_.characterEffect1199ui_story and not isNil(var_103_9) then
					arg_100_1.var_.characterEffect1199ui_story.fillFlat = false
				end
			end

			if arg_100_1.time_ >= var_103_10 + var_103_11 and arg_100_1.time_ < var_103_10 + var_103_11 + arg_103_0 and not isNil(var_103_9) and arg_100_1.var_.characterEffect1199ui_story then
				arg_100_1.var_.characterEffect1199ui_story.fillFlat = false
			end

			local var_103_13 = 0

			if var_103_13 < arg_100_1.time_ and arg_100_1.time_ <= var_103_13 + arg_103_0 then
				arg_100_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/story1199/story1199action/1199action1_1")
			end

			local var_103_14 = 0

			if var_103_14 < arg_100_1.time_ and arg_100_1.time_ <= var_103_14 + arg_103_0 then
				arg_100_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_103_15 = arg_100_1.actors_["1150ui_story"].transform
			local var_103_16 = 0

			if var_103_16 < arg_100_1.time_ and arg_100_1.time_ <= var_103_16 + arg_103_0 then
				arg_100_1.var_.moveOldPos1150ui_story = var_103_15.localPosition
			end

			local var_103_17 = 0.001

			if var_103_16 <= arg_100_1.time_ and arg_100_1.time_ < var_103_16 + var_103_17 then
				local var_103_18 = (arg_100_1.time_ - var_103_16) / var_103_17
				local var_103_19 = Vector3.New(0, 100, 0)

				var_103_15.localPosition = Vector3.Lerp(arg_100_1.var_.moveOldPos1150ui_story, var_103_19, var_103_18)

				local var_103_20 = manager.ui.mainCamera.transform.position - var_103_15.position

				var_103_15.forward = Vector3.New(var_103_20.x, var_103_20.y, var_103_20.z)

				local var_103_21 = var_103_15.localEulerAngles

				var_103_21.z = 0
				var_103_21.x = 0
				var_103_15.localEulerAngles = var_103_21
			end

			if arg_100_1.time_ >= var_103_16 + var_103_17 and arg_100_1.time_ < var_103_16 + var_103_17 + arg_103_0 then
				var_103_15.localPosition = Vector3.New(0, 100, 0)

				local var_103_22 = manager.ui.mainCamera.transform.position - var_103_15.position

				var_103_15.forward = Vector3.New(var_103_22.x, var_103_22.y, var_103_22.z)

				local var_103_23 = var_103_15.localEulerAngles

				var_103_23.z = 0
				var_103_23.x = 0
				var_103_15.localEulerAngles = var_103_23
			end

			local var_103_24 = arg_100_1.actors_["1150ui_story"]
			local var_103_25 = 0

			if var_103_25 < arg_100_1.time_ and arg_100_1.time_ <= var_103_25 + arg_103_0 and not isNil(var_103_24) and arg_100_1.var_.characterEffect1150ui_story == nil then
				arg_100_1.var_.characterEffect1150ui_story = var_103_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_103_26 = 0.200000002980232

			if var_103_25 <= arg_100_1.time_ and arg_100_1.time_ < var_103_25 + var_103_26 and not isNil(var_103_24) then
				local var_103_27 = (arg_100_1.time_ - var_103_25) / var_103_26

				if arg_100_1.var_.characterEffect1150ui_story and not isNil(var_103_24) then
					local var_103_28 = Mathf.Lerp(0, 0.5, var_103_27)

					arg_100_1.var_.characterEffect1150ui_story.fillFlat = true
					arg_100_1.var_.characterEffect1150ui_story.fillRatio = var_103_28
				end
			end

			if arg_100_1.time_ >= var_103_25 + var_103_26 and arg_100_1.time_ < var_103_25 + var_103_26 + arg_103_0 and not isNil(var_103_24) and arg_100_1.var_.characterEffect1150ui_story then
				local var_103_29 = 0.5

				arg_100_1.var_.characterEffect1150ui_story.fillFlat = true
				arg_100_1.var_.characterEffect1150ui_story.fillRatio = var_103_29
			end

			local var_103_30 = arg_100_1.actors_["1093ui_story"].transform
			local var_103_31 = 0

			if var_103_31 < arg_100_1.time_ and arg_100_1.time_ <= var_103_31 + arg_103_0 then
				arg_100_1.var_.moveOldPos1093ui_story = var_103_30.localPosition
			end

			local var_103_32 = 0.001

			if var_103_31 <= arg_100_1.time_ and arg_100_1.time_ < var_103_31 + var_103_32 then
				local var_103_33 = (arg_100_1.time_ - var_103_31) / var_103_32
				local var_103_34 = Vector3.New(0, 100, 0)

				var_103_30.localPosition = Vector3.Lerp(arg_100_1.var_.moveOldPos1093ui_story, var_103_34, var_103_33)

				local var_103_35 = manager.ui.mainCamera.transform.position - var_103_30.position

				var_103_30.forward = Vector3.New(var_103_35.x, var_103_35.y, var_103_35.z)

				local var_103_36 = var_103_30.localEulerAngles

				var_103_36.z = 0
				var_103_36.x = 0
				var_103_30.localEulerAngles = var_103_36
			end

			if arg_100_1.time_ >= var_103_31 + var_103_32 and arg_100_1.time_ < var_103_31 + var_103_32 + arg_103_0 then
				var_103_30.localPosition = Vector3.New(0, 100, 0)

				local var_103_37 = manager.ui.mainCamera.transform.position - var_103_30.position

				var_103_30.forward = Vector3.New(var_103_37.x, var_103_37.y, var_103_37.z)

				local var_103_38 = var_103_30.localEulerAngles

				var_103_38.z = 0
				var_103_38.x = 0
				var_103_30.localEulerAngles = var_103_38
			end

			local var_103_39 = 0
			local var_103_40 = 0.475

			if var_103_39 < arg_100_1.time_ and arg_100_1.time_ <= var_103_39 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				local var_103_41 = arg_100_1:FormatText(StoryNameCfg[84].name)

				arg_100_1.leftNameTxt_.text = var_103_41

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_42 = arg_100_1:GetWordFromCfg(318211024)
				local var_103_43 = arg_100_1:FormatText(var_103_42.content)

				arg_100_1.text_.text = var_103_43

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_44 = 19
				local var_103_45 = utf8.len(var_103_43)
				local var_103_46 = var_103_44 <= 0 and var_103_40 or var_103_40 * (var_103_45 / var_103_44)

				if var_103_46 > 0 and var_103_40 < var_103_46 then
					arg_100_1.talkMaxDuration = var_103_46

					if var_103_46 + var_103_39 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_46 + var_103_39
					end
				end

				arg_100_1.text_.text = var_103_43
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318211", "318211024", "story_v_out_318211.awb") ~= 0 then
					local var_103_47 = manager.audio:GetVoiceLength("story_v_out_318211", "318211024", "story_v_out_318211.awb") / 1000

					if var_103_47 + var_103_39 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_47 + var_103_39
					end

					if var_103_42.prefab_name ~= "" and arg_100_1.actors_[var_103_42.prefab_name] ~= nil then
						local var_103_48 = LuaForUtil.PlayVoiceWithCriLipsync(arg_100_1.actors_[var_103_42.prefab_name].transform, "story_v_out_318211", "318211024", "story_v_out_318211.awb")

						arg_100_1:RecordAudio("318211024", var_103_48)
						arg_100_1:RecordAudio("318211024", var_103_48)
					else
						arg_100_1:AudioAction("play", "voice", "story_v_out_318211", "318211024", "story_v_out_318211.awb")
					end

					arg_100_1:RecordHistoryTalkVoice("story_v_out_318211", "318211024", "story_v_out_318211.awb")
				end

				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_49 = math.max(var_103_40, arg_100_1.talkMaxDuration)

			if var_103_39 <= arg_100_1.time_ and arg_100_1.time_ < var_103_39 + var_103_49 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_39) / var_103_49

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_39 + var_103_49 and arg_100_1.time_ < var_103_39 + var_103_49 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1199ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_100_1:InitPlayNodeList()
	end,
	Play318211025 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 318211025
		arg_104_1.duration_ = 13.2

		local var_104_0 = {
			zh = 10.633,
			ja = 13.2
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
				arg_104_0:Play318211026(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			local var_107_0 = arg_104_1.actors_["1150ui_story"].transform
			local var_107_1 = 0

			if var_107_1 < arg_104_1.time_ and arg_104_1.time_ <= var_107_1 + arg_107_0 then
				arg_104_1.var_.moveOldPos1150ui_story = var_107_0.localPosition
			end

			local var_107_2 = 0.001

			if var_107_1 <= arg_104_1.time_ and arg_104_1.time_ < var_107_1 + var_107_2 then
				local var_107_3 = (arg_104_1.time_ - var_107_1) / var_107_2
				local var_107_4 = Vector3.New(0.7, -1.01, -6.2)

				var_107_0.localPosition = Vector3.Lerp(arg_104_1.var_.moveOldPos1150ui_story, var_107_4, var_107_3)

				local var_107_5 = manager.ui.mainCamera.transform.position - var_107_0.position

				var_107_0.forward = Vector3.New(var_107_5.x, var_107_5.y, var_107_5.z)

				local var_107_6 = var_107_0.localEulerAngles

				var_107_6.z = 0
				var_107_6.x = 0
				var_107_0.localEulerAngles = var_107_6
			end

			if arg_104_1.time_ >= var_107_1 + var_107_2 and arg_104_1.time_ < var_107_1 + var_107_2 + arg_107_0 then
				var_107_0.localPosition = Vector3.New(0.7, -1.01, -6.2)

				local var_107_7 = manager.ui.mainCamera.transform.position - var_107_0.position

				var_107_0.forward = Vector3.New(var_107_7.x, var_107_7.y, var_107_7.z)

				local var_107_8 = var_107_0.localEulerAngles

				var_107_8.z = 0
				var_107_8.x = 0
				var_107_0.localEulerAngles = var_107_8
			end

			local var_107_9 = arg_104_1.actors_["1150ui_story"]
			local var_107_10 = 0

			if var_107_10 < arg_104_1.time_ and arg_104_1.time_ <= var_107_10 + arg_107_0 and not isNil(var_107_9) and arg_104_1.var_.characterEffect1150ui_story == nil then
				arg_104_1.var_.characterEffect1150ui_story = var_107_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_107_11 = 0.200000002980232

			if var_107_10 <= arg_104_1.time_ and arg_104_1.time_ < var_107_10 + var_107_11 and not isNil(var_107_9) then
				local var_107_12 = (arg_104_1.time_ - var_107_10) / var_107_11

				if arg_104_1.var_.characterEffect1150ui_story and not isNil(var_107_9) then
					arg_104_1.var_.characterEffect1150ui_story.fillFlat = false
				end
			end

			if arg_104_1.time_ >= var_107_10 + var_107_11 and arg_104_1.time_ < var_107_10 + var_107_11 + arg_107_0 and not isNil(var_107_9) and arg_104_1.var_.characterEffect1150ui_story then
				arg_104_1.var_.characterEffect1150ui_story.fillFlat = false
			end

			local var_107_13 = 0

			if var_107_13 < arg_104_1.time_ and arg_104_1.time_ <= var_107_13 + arg_107_0 then
				arg_104_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/story1150/story1150action/1150action4_1")
			end

			local var_107_14 = 0

			if var_107_14 < arg_104_1.time_ and arg_104_1.time_ <= var_107_14 + arg_107_0 then
				arg_104_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_107_15 = arg_104_1.actors_["1199ui_story"].transform
			local var_107_16 = 0

			if var_107_16 < arg_104_1.time_ and arg_104_1.time_ <= var_107_16 + arg_107_0 then
				arg_104_1.var_.moveOldPos1199ui_story = var_107_15.localPosition
			end

			local var_107_17 = 0.001

			if var_107_16 <= arg_104_1.time_ and arg_104_1.time_ < var_107_16 + var_107_17 then
				local var_107_18 = (arg_104_1.time_ - var_107_16) / var_107_17
				local var_107_19 = Vector3.New(0, 100, 0)

				var_107_15.localPosition = Vector3.Lerp(arg_104_1.var_.moveOldPos1199ui_story, var_107_19, var_107_18)

				local var_107_20 = manager.ui.mainCamera.transform.position - var_107_15.position

				var_107_15.forward = Vector3.New(var_107_20.x, var_107_20.y, var_107_20.z)

				local var_107_21 = var_107_15.localEulerAngles

				var_107_21.z = 0
				var_107_21.x = 0
				var_107_15.localEulerAngles = var_107_21
			end

			if arg_104_1.time_ >= var_107_16 + var_107_17 and arg_104_1.time_ < var_107_16 + var_107_17 + arg_107_0 then
				var_107_15.localPosition = Vector3.New(0, 100, 0)

				local var_107_22 = manager.ui.mainCamera.transform.position - var_107_15.position

				var_107_15.forward = Vector3.New(var_107_22.x, var_107_22.y, var_107_22.z)

				local var_107_23 = var_107_15.localEulerAngles

				var_107_23.z = 0
				var_107_23.x = 0
				var_107_15.localEulerAngles = var_107_23
			end

			local var_107_24 = arg_104_1.actors_["1199ui_story"]
			local var_107_25 = 0

			if var_107_25 < arg_104_1.time_ and arg_104_1.time_ <= var_107_25 + arg_107_0 and not isNil(var_107_24) and arg_104_1.var_.characterEffect1199ui_story == nil then
				arg_104_1.var_.characterEffect1199ui_story = var_107_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_107_26 = 0.200000002980232

			if var_107_25 <= arg_104_1.time_ and arg_104_1.time_ < var_107_25 + var_107_26 and not isNil(var_107_24) then
				local var_107_27 = (arg_104_1.time_ - var_107_25) / var_107_26

				if arg_104_1.var_.characterEffect1199ui_story and not isNil(var_107_24) then
					local var_107_28 = Mathf.Lerp(0, 0.5, var_107_27)

					arg_104_1.var_.characterEffect1199ui_story.fillFlat = true
					arg_104_1.var_.characterEffect1199ui_story.fillRatio = var_107_28
				end
			end

			if arg_104_1.time_ >= var_107_25 + var_107_26 and arg_104_1.time_ < var_107_25 + var_107_26 + arg_107_0 and not isNil(var_107_24) and arg_104_1.var_.characterEffect1199ui_story then
				local var_107_29 = 0.5

				arg_104_1.var_.characterEffect1199ui_story.fillFlat = true
				arg_104_1.var_.characterEffect1199ui_story.fillRatio = var_107_29
			end

			local var_107_30 = arg_104_1.actors_["1093ui_story"].transform
			local var_107_31 = 0

			if var_107_31 < arg_104_1.time_ and arg_104_1.time_ <= var_107_31 + arg_107_0 then
				arg_104_1.var_.moveOldPos1093ui_story = var_107_30.localPosition
			end

			local var_107_32 = 0.001

			if var_107_31 <= arg_104_1.time_ and arg_104_1.time_ < var_107_31 + var_107_32 then
				local var_107_33 = (arg_104_1.time_ - var_107_31) / var_107_32
				local var_107_34 = Vector3.New(-0.7, -1.11, -5.88)

				var_107_30.localPosition = Vector3.Lerp(arg_104_1.var_.moveOldPos1093ui_story, var_107_34, var_107_33)

				local var_107_35 = manager.ui.mainCamera.transform.position - var_107_30.position

				var_107_30.forward = Vector3.New(var_107_35.x, var_107_35.y, var_107_35.z)

				local var_107_36 = var_107_30.localEulerAngles

				var_107_36.z = 0
				var_107_36.x = 0
				var_107_30.localEulerAngles = var_107_36
			end

			if arg_104_1.time_ >= var_107_31 + var_107_32 and arg_104_1.time_ < var_107_31 + var_107_32 + arg_107_0 then
				var_107_30.localPosition = Vector3.New(-0.7, -1.11, -5.88)

				local var_107_37 = manager.ui.mainCamera.transform.position - var_107_30.position

				var_107_30.forward = Vector3.New(var_107_37.x, var_107_37.y, var_107_37.z)

				local var_107_38 = var_107_30.localEulerAngles

				var_107_38.z = 0
				var_107_38.x = 0
				var_107_30.localEulerAngles = var_107_38
			end

			local var_107_39 = 0
			local var_107_40 = 1.1

			if var_107_39 < arg_104_1.time_ and arg_104_1.time_ <= var_107_39 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				local var_107_41 = arg_104_1:FormatText(StoryNameCfg[74].name)

				arg_104_1.leftNameTxt_.text = var_107_41

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_42 = arg_104_1:GetWordFromCfg(318211025)
				local var_107_43 = arg_104_1:FormatText(var_107_42.content)

				arg_104_1.text_.text = var_107_43

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_44 = 44
				local var_107_45 = utf8.len(var_107_43)
				local var_107_46 = var_107_44 <= 0 and var_107_40 or var_107_40 * (var_107_45 / var_107_44)

				if var_107_46 > 0 and var_107_40 < var_107_46 then
					arg_104_1.talkMaxDuration = var_107_46

					if var_107_46 + var_107_39 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_46 + var_107_39
					end
				end

				arg_104_1.text_.text = var_107_43
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318211", "318211025", "story_v_out_318211.awb") ~= 0 then
					local var_107_47 = manager.audio:GetVoiceLength("story_v_out_318211", "318211025", "story_v_out_318211.awb") / 1000

					if var_107_47 + var_107_39 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_47 + var_107_39
					end

					if var_107_42.prefab_name ~= "" and arg_104_1.actors_[var_107_42.prefab_name] ~= nil then
						local var_107_48 = LuaForUtil.PlayVoiceWithCriLipsync(arg_104_1.actors_[var_107_42.prefab_name].transform, "story_v_out_318211", "318211025", "story_v_out_318211.awb")

						arg_104_1:RecordAudio("318211025", var_107_48)
						arg_104_1:RecordAudio("318211025", var_107_48)
					else
						arg_104_1:AudioAction("play", "voice", "story_v_out_318211", "318211025", "story_v_out_318211.awb")
					end

					arg_104_1:RecordHistoryTalkVoice("story_v_out_318211", "318211025", "story_v_out_318211.awb")
				end

				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_49 = math.max(var_107_40, arg_104_1.talkMaxDuration)

			if var_107_39 <= arg_104_1.time_ and arg_104_1.time_ < var_107_39 + var_107_49 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_39) / var_107_49

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_39 + var_107_49 and arg_104_1.time_ < var_107_39 + var_107_49 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1199ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1093ui_story",
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
	Play318211026 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 318211026
		arg_108_1.duration_ = 4.43

		local var_108_0 = {
			zh = 1.966,
			ja = 4.433
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
				arg_108_0:Play318211027(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			local var_111_0 = 0
			local var_111_1 = 0.2

			if var_111_0 < arg_108_1.time_ and arg_108_1.time_ <= var_111_0 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				local var_111_2 = arg_108_1:FormatText(StoryNameCfg[74].name)

				arg_108_1.leftNameTxt_.text = var_111_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_3 = arg_108_1:GetWordFromCfg(318211026)
				local var_111_4 = arg_108_1:FormatText(var_111_3.content)

				arg_108_1.text_.text = var_111_4

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_5 = 8
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

				if manager.audio:GetVoiceLength("story_v_out_318211", "318211026", "story_v_out_318211.awb") ~= 0 then
					local var_111_8 = manager.audio:GetVoiceLength("story_v_out_318211", "318211026", "story_v_out_318211.awb") / 1000

					if var_111_8 + var_111_0 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_8 + var_111_0
					end

					if var_111_3.prefab_name ~= "" and arg_108_1.actors_[var_111_3.prefab_name] ~= nil then
						local var_111_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_108_1.actors_[var_111_3.prefab_name].transform, "story_v_out_318211", "318211026", "story_v_out_318211.awb")

						arg_108_1:RecordAudio("318211026", var_111_9)
						arg_108_1:RecordAudio("318211026", var_111_9)
					else
						arg_108_1:AudioAction("play", "voice", "story_v_out_318211", "318211026", "story_v_out_318211.awb")
					end

					arg_108_1:RecordHistoryTalkVoice("story_v_out_318211", "318211026", "story_v_out_318211.awb")
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
	Play318211027 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 318211027
		arg_112_1.duration_ = 9.4

		local var_112_0 = {
			zh = 6.1,
			ja = 9.4
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
				arg_112_0:Play318211028(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			local var_115_0 = arg_112_1.actors_["1093ui_story"]
			local var_115_1 = 0

			if var_115_1 < arg_112_1.time_ and arg_112_1.time_ <= var_115_1 + arg_115_0 and not isNil(var_115_0) and arg_112_1.var_.characterEffect1093ui_story == nil then
				arg_112_1.var_.characterEffect1093ui_story = var_115_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_115_2 = 0.200000002980232

			if var_115_1 <= arg_112_1.time_ and arg_112_1.time_ < var_115_1 + var_115_2 and not isNil(var_115_0) then
				local var_115_3 = (arg_112_1.time_ - var_115_1) / var_115_2

				if arg_112_1.var_.characterEffect1093ui_story and not isNil(var_115_0) then
					arg_112_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_112_1.time_ >= var_115_1 + var_115_2 and arg_112_1.time_ < var_115_1 + var_115_2 + arg_115_0 and not isNil(var_115_0) and arg_112_1.var_.characterEffect1093ui_story then
				arg_112_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_115_4 = 0

			if var_115_4 < arg_112_1.time_ and arg_112_1.time_ <= var_115_4 + arg_115_0 then
				arg_112_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action6_1")
			end

			local var_115_5 = 0

			if var_115_5 < arg_112_1.time_ and arg_112_1.time_ <= var_115_5 + arg_115_0 then
				arg_112_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_115_6 = arg_112_1.actors_["1150ui_story"]
			local var_115_7 = 0

			if var_115_7 < arg_112_1.time_ and arg_112_1.time_ <= var_115_7 + arg_115_0 and not isNil(var_115_6) and arg_112_1.var_.characterEffect1150ui_story == nil then
				arg_112_1.var_.characterEffect1150ui_story = var_115_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_115_8 = 0.200000002980232

			if var_115_7 <= arg_112_1.time_ and arg_112_1.time_ < var_115_7 + var_115_8 and not isNil(var_115_6) then
				local var_115_9 = (arg_112_1.time_ - var_115_7) / var_115_8

				if arg_112_1.var_.characterEffect1150ui_story and not isNil(var_115_6) then
					local var_115_10 = Mathf.Lerp(0, 0.5, var_115_9)

					arg_112_1.var_.characterEffect1150ui_story.fillFlat = true
					arg_112_1.var_.characterEffect1150ui_story.fillRatio = var_115_10
				end
			end

			if arg_112_1.time_ >= var_115_7 + var_115_8 and arg_112_1.time_ < var_115_7 + var_115_8 + arg_115_0 and not isNil(var_115_6) and arg_112_1.var_.characterEffect1150ui_story then
				local var_115_11 = 0.5

				arg_112_1.var_.characterEffect1150ui_story.fillFlat = true
				arg_112_1.var_.characterEffect1150ui_story.fillRatio = var_115_11
			end

			local var_115_12 = 0
			local var_115_13 = 0.8

			if var_115_12 < arg_112_1.time_ and arg_112_1.time_ <= var_115_12 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				local var_115_14 = arg_112_1:FormatText(StoryNameCfg[73].name)

				arg_112_1.leftNameTxt_.text = var_115_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_15 = arg_112_1:GetWordFromCfg(318211027)
				local var_115_16 = arg_112_1:FormatText(var_115_15.content)

				arg_112_1.text_.text = var_115_16

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_17 = 32
				local var_115_18 = utf8.len(var_115_16)
				local var_115_19 = var_115_17 <= 0 and var_115_13 or var_115_13 * (var_115_18 / var_115_17)

				if var_115_19 > 0 and var_115_13 < var_115_19 then
					arg_112_1.talkMaxDuration = var_115_19

					if var_115_19 + var_115_12 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_19 + var_115_12
					end
				end

				arg_112_1.text_.text = var_115_16
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318211", "318211027", "story_v_out_318211.awb") ~= 0 then
					local var_115_20 = manager.audio:GetVoiceLength("story_v_out_318211", "318211027", "story_v_out_318211.awb") / 1000

					if var_115_20 + var_115_12 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_20 + var_115_12
					end

					if var_115_15.prefab_name ~= "" and arg_112_1.actors_[var_115_15.prefab_name] ~= nil then
						local var_115_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_112_1.actors_[var_115_15.prefab_name].transform, "story_v_out_318211", "318211027", "story_v_out_318211.awb")

						arg_112_1:RecordAudio("318211027", var_115_21)
						arg_112_1:RecordAudio("318211027", var_115_21)
					else
						arg_112_1:AudioAction("play", "voice", "story_v_out_318211", "318211027", "story_v_out_318211.awb")
					end

					arg_112_1:RecordHistoryTalkVoice("story_v_out_318211", "318211027", "story_v_out_318211.awb")
				end

				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_22 = math.max(var_115_13, arg_112_1.talkMaxDuration)

			if var_115_12 <= arg_112_1.time_ and arg_112_1.time_ < var_115_12 + var_115_22 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_12) / var_115_22

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_12 + var_115_22 and arg_112_1.time_ < var_115_12 + var_115_22 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {}

		arg_112_1:InitPlayNodeList()
	end,
	Play318211028 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 318211028
		arg_116_1.duration_ = 9.3

		local var_116_0 = {
			zh = 7,
			ja = 9.3
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
				arg_116_0:Play318211029(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			local var_119_0 = arg_116_1.actors_["1199ui_story"].transform
			local var_119_1 = 0

			if var_119_1 < arg_116_1.time_ and arg_116_1.time_ <= var_119_1 + arg_119_0 then
				arg_116_1.var_.moveOldPos1199ui_story = var_119_0.localPosition
			end

			local var_119_2 = 0.001

			if var_119_1 <= arg_116_1.time_ and arg_116_1.time_ < var_119_1 + var_119_2 then
				local var_119_3 = (arg_116_1.time_ - var_119_1) / var_119_2
				local var_119_4 = Vector3.New(0, -1.08, -5.9)

				var_119_0.localPosition = Vector3.Lerp(arg_116_1.var_.moveOldPos1199ui_story, var_119_4, var_119_3)

				local var_119_5 = manager.ui.mainCamera.transform.position - var_119_0.position

				var_119_0.forward = Vector3.New(var_119_5.x, var_119_5.y, var_119_5.z)

				local var_119_6 = var_119_0.localEulerAngles

				var_119_6.z = 0
				var_119_6.x = 0
				var_119_0.localEulerAngles = var_119_6
			end

			if arg_116_1.time_ >= var_119_1 + var_119_2 and arg_116_1.time_ < var_119_1 + var_119_2 + arg_119_0 then
				var_119_0.localPosition = Vector3.New(0, -1.08, -5.9)

				local var_119_7 = manager.ui.mainCamera.transform.position - var_119_0.position

				var_119_0.forward = Vector3.New(var_119_7.x, var_119_7.y, var_119_7.z)

				local var_119_8 = var_119_0.localEulerAngles

				var_119_8.z = 0
				var_119_8.x = 0
				var_119_0.localEulerAngles = var_119_8
			end

			local var_119_9 = arg_116_1.actors_["1199ui_story"]
			local var_119_10 = 0

			if var_119_10 < arg_116_1.time_ and arg_116_1.time_ <= var_119_10 + arg_119_0 and not isNil(var_119_9) and arg_116_1.var_.characterEffect1199ui_story == nil then
				arg_116_1.var_.characterEffect1199ui_story = var_119_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_119_11 = 0.200000002980232

			if var_119_10 <= arg_116_1.time_ and arg_116_1.time_ < var_119_10 + var_119_11 and not isNil(var_119_9) then
				local var_119_12 = (arg_116_1.time_ - var_119_10) / var_119_11

				if arg_116_1.var_.characterEffect1199ui_story and not isNil(var_119_9) then
					arg_116_1.var_.characterEffect1199ui_story.fillFlat = false
				end
			end

			if arg_116_1.time_ >= var_119_10 + var_119_11 and arg_116_1.time_ < var_119_10 + var_119_11 + arg_119_0 and not isNil(var_119_9) and arg_116_1.var_.characterEffect1199ui_story then
				arg_116_1.var_.characterEffect1199ui_story.fillFlat = false
			end

			local var_119_13 = 0

			if var_119_13 < arg_116_1.time_ and arg_116_1.time_ <= var_119_13 + arg_119_0 then
				arg_116_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/story1199/story1199action/1199action4_1")
			end

			local var_119_14 = 0

			if var_119_14 < arg_116_1.time_ and arg_116_1.time_ <= var_119_14 + arg_119_0 then
				arg_116_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_119_15 = arg_116_1.actors_["1093ui_story"].transform
			local var_119_16 = 0

			if var_119_16 < arg_116_1.time_ and arg_116_1.time_ <= var_119_16 + arg_119_0 then
				arg_116_1.var_.moveOldPos1093ui_story = var_119_15.localPosition
			end

			local var_119_17 = 0.001

			if var_119_16 <= arg_116_1.time_ and arg_116_1.time_ < var_119_16 + var_119_17 then
				local var_119_18 = (arg_116_1.time_ - var_119_16) / var_119_17
				local var_119_19 = Vector3.New(0, 100, 0)

				var_119_15.localPosition = Vector3.Lerp(arg_116_1.var_.moveOldPos1093ui_story, var_119_19, var_119_18)

				local var_119_20 = manager.ui.mainCamera.transform.position - var_119_15.position

				var_119_15.forward = Vector3.New(var_119_20.x, var_119_20.y, var_119_20.z)

				local var_119_21 = var_119_15.localEulerAngles

				var_119_21.z = 0
				var_119_21.x = 0
				var_119_15.localEulerAngles = var_119_21
			end

			if arg_116_1.time_ >= var_119_16 + var_119_17 and arg_116_1.time_ < var_119_16 + var_119_17 + arg_119_0 then
				var_119_15.localPosition = Vector3.New(0, 100, 0)

				local var_119_22 = manager.ui.mainCamera.transform.position - var_119_15.position

				var_119_15.forward = Vector3.New(var_119_22.x, var_119_22.y, var_119_22.z)

				local var_119_23 = var_119_15.localEulerAngles

				var_119_23.z = 0
				var_119_23.x = 0
				var_119_15.localEulerAngles = var_119_23
			end

			local var_119_24 = arg_116_1.actors_["1093ui_story"]
			local var_119_25 = 0

			if var_119_25 < arg_116_1.time_ and arg_116_1.time_ <= var_119_25 + arg_119_0 and not isNil(var_119_24) and arg_116_1.var_.characterEffect1093ui_story == nil then
				arg_116_1.var_.characterEffect1093ui_story = var_119_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_119_26 = 0.200000002980232

			if var_119_25 <= arg_116_1.time_ and arg_116_1.time_ < var_119_25 + var_119_26 and not isNil(var_119_24) then
				local var_119_27 = (arg_116_1.time_ - var_119_25) / var_119_26

				if arg_116_1.var_.characterEffect1093ui_story and not isNil(var_119_24) then
					local var_119_28 = Mathf.Lerp(0, 0.5, var_119_27)

					arg_116_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_116_1.var_.characterEffect1093ui_story.fillRatio = var_119_28
				end
			end

			if arg_116_1.time_ >= var_119_25 + var_119_26 and arg_116_1.time_ < var_119_25 + var_119_26 + arg_119_0 and not isNil(var_119_24) and arg_116_1.var_.characterEffect1093ui_story then
				local var_119_29 = 0.5

				arg_116_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_116_1.var_.characterEffect1093ui_story.fillRatio = var_119_29
			end

			local var_119_30 = arg_116_1.actors_["1150ui_story"].transform
			local var_119_31 = 0

			if var_119_31 < arg_116_1.time_ and arg_116_1.time_ <= var_119_31 + arg_119_0 then
				arg_116_1.var_.moveOldPos1150ui_story = var_119_30.localPosition
			end

			local var_119_32 = 0.001

			if var_119_31 <= arg_116_1.time_ and arg_116_1.time_ < var_119_31 + var_119_32 then
				local var_119_33 = (arg_116_1.time_ - var_119_31) / var_119_32
				local var_119_34 = Vector3.New(0, 100, 0)

				var_119_30.localPosition = Vector3.Lerp(arg_116_1.var_.moveOldPos1150ui_story, var_119_34, var_119_33)

				local var_119_35 = manager.ui.mainCamera.transform.position - var_119_30.position

				var_119_30.forward = Vector3.New(var_119_35.x, var_119_35.y, var_119_35.z)

				local var_119_36 = var_119_30.localEulerAngles

				var_119_36.z = 0
				var_119_36.x = 0
				var_119_30.localEulerAngles = var_119_36
			end

			if arg_116_1.time_ >= var_119_31 + var_119_32 and arg_116_1.time_ < var_119_31 + var_119_32 + arg_119_0 then
				var_119_30.localPosition = Vector3.New(0, 100, 0)

				local var_119_37 = manager.ui.mainCamera.transform.position - var_119_30.position

				var_119_30.forward = Vector3.New(var_119_37.x, var_119_37.y, var_119_37.z)

				local var_119_38 = var_119_30.localEulerAngles

				var_119_38.z = 0
				var_119_38.x = 0
				var_119_30.localEulerAngles = var_119_38
			end

			local var_119_39 = 0
			local var_119_40 = 0.8

			if var_119_39 < arg_116_1.time_ and arg_116_1.time_ <= var_119_39 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				local var_119_41 = arg_116_1:FormatText(StoryNameCfg[84].name)

				arg_116_1.leftNameTxt_.text = var_119_41

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_42 = arg_116_1:GetWordFromCfg(318211028)
				local var_119_43 = arg_116_1:FormatText(var_119_42.content)

				arg_116_1.text_.text = var_119_43

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_44 = 32
				local var_119_45 = utf8.len(var_119_43)
				local var_119_46 = var_119_44 <= 0 and var_119_40 or var_119_40 * (var_119_45 / var_119_44)

				if var_119_46 > 0 and var_119_40 < var_119_46 then
					arg_116_1.talkMaxDuration = var_119_46

					if var_119_46 + var_119_39 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_46 + var_119_39
					end
				end

				arg_116_1.text_.text = var_119_43
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318211", "318211028", "story_v_out_318211.awb") ~= 0 then
					local var_119_47 = manager.audio:GetVoiceLength("story_v_out_318211", "318211028", "story_v_out_318211.awb") / 1000

					if var_119_47 + var_119_39 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_47 + var_119_39
					end

					if var_119_42.prefab_name ~= "" and arg_116_1.actors_[var_119_42.prefab_name] ~= nil then
						local var_119_48 = LuaForUtil.PlayVoiceWithCriLipsync(arg_116_1.actors_[var_119_42.prefab_name].transform, "story_v_out_318211", "318211028", "story_v_out_318211.awb")

						arg_116_1:RecordAudio("318211028", var_119_48)
						arg_116_1:RecordAudio("318211028", var_119_48)
					else
						arg_116_1:AudioAction("play", "voice", "story_v_out_318211", "318211028", "story_v_out_318211.awb")
					end

					arg_116_1:RecordHistoryTalkVoice("story_v_out_318211", "318211028", "story_v_out_318211.awb")
				end

				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_49 = math.max(var_119_40, arg_116_1.talkMaxDuration)

			if var_119_39 <= arg_116_1.time_ and arg_116_1.time_ < var_119_39 + var_119_49 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_39) / var_119_49

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_39 + var_119_49 and arg_116_1.time_ < var_119_39 + var_119_49 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1199ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1150ui_story",
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
	Play318211029 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 318211029
		arg_120_1.duration_ = 2.63

		local var_120_0 = {
			zh = 2.366,
			ja = 2.633
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
				arg_120_0:Play318211030(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			local var_123_0 = 0
			local var_123_1 = 0.275

			if var_123_0 < arg_120_1.time_ and arg_120_1.time_ <= var_123_0 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				local var_123_2 = arg_120_1:FormatText(StoryNameCfg[84].name)

				arg_120_1.leftNameTxt_.text = var_123_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_3 = arg_120_1:GetWordFromCfg(318211029)
				local var_123_4 = arg_120_1:FormatText(var_123_3.content)

				arg_120_1.text_.text = var_123_4

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_5 = 11
				local var_123_6 = utf8.len(var_123_4)
				local var_123_7 = var_123_5 <= 0 and var_123_1 or var_123_1 * (var_123_6 / var_123_5)

				if var_123_7 > 0 and var_123_1 < var_123_7 then
					arg_120_1.talkMaxDuration = var_123_7

					if var_123_7 + var_123_0 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_7 + var_123_0
					end
				end

				arg_120_1.text_.text = var_123_4
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318211", "318211029", "story_v_out_318211.awb") ~= 0 then
					local var_123_8 = manager.audio:GetVoiceLength("story_v_out_318211", "318211029", "story_v_out_318211.awb") / 1000

					if var_123_8 + var_123_0 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_8 + var_123_0
					end

					if var_123_3.prefab_name ~= "" and arg_120_1.actors_[var_123_3.prefab_name] ~= nil then
						local var_123_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_120_1.actors_[var_123_3.prefab_name].transform, "story_v_out_318211", "318211029", "story_v_out_318211.awb")

						arg_120_1:RecordAudio("318211029", var_123_9)
						arg_120_1:RecordAudio("318211029", var_123_9)
					else
						arg_120_1:AudioAction("play", "voice", "story_v_out_318211", "318211029", "story_v_out_318211.awb")
					end

					arg_120_1:RecordHistoryTalkVoice("story_v_out_318211", "318211029", "story_v_out_318211.awb")
				end

				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_10 = math.max(var_123_1, arg_120_1.talkMaxDuration)

			if var_123_0 <= arg_120_1.time_ and arg_120_1.time_ < var_123_0 + var_123_10 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_0) / var_123_10

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_0 + var_123_10 and arg_120_1.time_ < var_123_0 + var_123_10 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {}

		arg_120_1:InitPlayNodeList()
	end,
	Play318211030 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 318211030
		arg_124_1.duration_ = 5.87

		local var_124_0 = {
			zh = 5.1,
			ja = 5.866
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
				arg_124_0:Play318211031(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			local var_127_0 = arg_124_1.actors_["1093ui_story"].transform
			local var_127_1 = 0

			if var_127_1 < arg_124_1.time_ and arg_124_1.time_ <= var_127_1 + arg_127_0 then
				arg_124_1.var_.moveOldPos1093ui_story = var_127_0.localPosition
			end

			local var_127_2 = 0.001

			if var_127_1 <= arg_124_1.time_ and arg_124_1.time_ < var_127_1 + var_127_2 then
				local var_127_3 = (arg_124_1.time_ - var_127_1) / var_127_2
				local var_127_4 = Vector3.New(0.7, -1.11, -5.88)

				var_127_0.localPosition = Vector3.Lerp(arg_124_1.var_.moveOldPos1093ui_story, var_127_4, var_127_3)

				local var_127_5 = manager.ui.mainCamera.transform.position - var_127_0.position

				var_127_0.forward = Vector3.New(var_127_5.x, var_127_5.y, var_127_5.z)

				local var_127_6 = var_127_0.localEulerAngles

				var_127_6.z = 0
				var_127_6.x = 0
				var_127_0.localEulerAngles = var_127_6
			end

			if arg_124_1.time_ >= var_127_1 + var_127_2 and arg_124_1.time_ < var_127_1 + var_127_2 + arg_127_0 then
				var_127_0.localPosition = Vector3.New(0.7, -1.11, -5.88)

				local var_127_7 = manager.ui.mainCamera.transform.position - var_127_0.position

				var_127_0.forward = Vector3.New(var_127_7.x, var_127_7.y, var_127_7.z)

				local var_127_8 = var_127_0.localEulerAngles

				var_127_8.z = 0
				var_127_8.x = 0
				var_127_0.localEulerAngles = var_127_8
			end

			local var_127_9 = arg_124_1.actors_["1093ui_story"]
			local var_127_10 = 0

			if var_127_10 < arg_124_1.time_ and arg_124_1.time_ <= var_127_10 + arg_127_0 and not isNil(var_127_9) and arg_124_1.var_.characterEffect1093ui_story == nil then
				arg_124_1.var_.characterEffect1093ui_story = var_127_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_127_11 = 0.200000002980232

			if var_127_10 <= arg_124_1.time_ and arg_124_1.time_ < var_127_10 + var_127_11 and not isNil(var_127_9) then
				local var_127_12 = (arg_124_1.time_ - var_127_10) / var_127_11

				if arg_124_1.var_.characterEffect1093ui_story and not isNil(var_127_9) then
					arg_124_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_124_1.time_ >= var_127_10 + var_127_11 and arg_124_1.time_ < var_127_10 + var_127_11 + arg_127_0 and not isNil(var_127_9) and arg_124_1.var_.characterEffect1093ui_story then
				arg_124_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_127_13 = 0

			if var_127_13 < arg_124_1.time_ and arg_124_1.time_ <= var_127_13 + arg_127_0 then
				arg_124_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action1_1")
			end

			local var_127_14 = 0

			if var_127_14 < arg_124_1.time_ and arg_124_1.time_ <= var_127_14 + arg_127_0 then
				arg_124_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_127_15 = arg_124_1.actors_["1199ui_story"].transform
			local var_127_16 = 0

			if var_127_16 < arg_124_1.time_ and arg_124_1.time_ <= var_127_16 + arg_127_0 then
				arg_124_1.var_.moveOldPos1199ui_story = var_127_15.localPosition
			end

			local var_127_17 = 0.001

			if var_127_16 <= arg_124_1.time_ and arg_124_1.time_ < var_127_16 + var_127_17 then
				local var_127_18 = (arg_124_1.time_ - var_127_16) / var_127_17
				local var_127_19 = Vector3.New(-0.7, -1.08, -5.9)

				var_127_15.localPosition = Vector3.Lerp(arg_124_1.var_.moveOldPos1199ui_story, var_127_19, var_127_18)

				local var_127_20 = manager.ui.mainCamera.transform.position - var_127_15.position

				var_127_15.forward = Vector3.New(var_127_20.x, var_127_20.y, var_127_20.z)

				local var_127_21 = var_127_15.localEulerAngles

				var_127_21.z = 0
				var_127_21.x = 0
				var_127_15.localEulerAngles = var_127_21
			end

			if arg_124_1.time_ >= var_127_16 + var_127_17 and arg_124_1.time_ < var_127_16 + var_127_17 + arg_127_0 then
				var_127_15.localPosition = Vector3.New(-0.7, -1.08, -5.9)

				local var_127_22 = manager.ui.mainCamera.transform.position - var_127_15.position

				var_127_15.forward = Vector3.New(var_127_22.x, var_127_22.y, var_127_22.z)

				local var_127_23 = var_127_15.localEulerAngles

				var_127_23.z = 0
				var_127_23.x = 0
				var_127_15.localEulerAngles = var_127_23
			end

			local var_127_24 = arg_124_1.actors_["1199ui_story"]
			local var_127_25 = 0

			if var_127_25 < arg_124_1.time_ and arg_124_1.time_ <= var_127_25 + arg_127_0 and not isNil(var_127_24) and arg_124_1.var_.characterEffect1199ui_story == nil then
				arg_124_1.var_.characterEffect1199ui_story = var_127_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_127_26 = 0.200000002980232

			if var_127_25 <= arg_124_1.time_ and arg_124_1.time_ < var_127_25 + var_127_26 and not isNil(var_127_24) then
				local var_127_27 = (arg_124_1.time_ - var_127_25) / var_127_26

				if arg_124_1.var_.characterEffect1199ui_story and not isNil(var_127_24) then
					local var_127_28 = Mathf.Lerp(0, 0.5, var_127_27)

					arg_124_1.var_.characterEffect1199ui_story.fillFlat = true
					arg_124_1.var_.characterEffect1199ui_story.fillRatio = var_127_28
				end
			end

			if arg_124_1.time_ >= var_127_25 + var_127_26 and arg_124_1.time_ < var_127_25 + var_127_26 + arg_127_0 and not isNil(var_127_24) and arg_124_1.var_.characterEffect1199ui_story then
				local var_127_29 = 0.5

				arg_124_1.var_.characterEffect1199ui_story.fillFlat = true
				arg_124_1.var_.characterEffect1199ui_story.fillRatio = var_127_29
			end

			local var_127_30 = 0
			local var_127_31 = 0.7

			if var_127_30 < arg_124_1.time_ and arg_124_1.time_ <= var_127_30 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				local var_127_32 = arg_124_1:FormatText(StoryNameCfg[73].name)

				arg_124_1.leftNameTxt_.text = var_127_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_33 = arg_124_1:GetWordFromCfg(318211030)
				local var_127_34 = arg_124_1:FormatText(var_127_33.content)

				arg_124_1.text_.text = var_127_34

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_35 = 28
				local var_127_36 = utf8.len(var_127_34)
				local var_127_37 = var_127_35 <= 0 and var_127_31 or var_127_31 * (var_127_36 / var_127_35)

				if var_127_37 > 0 and var_127_31 < var_127_37 then
					arg_124_1.talkMaxDuration = var_127_37

					if var_127_37 + var_127_30 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_37 + var_127_30
					end
				end

				arg_124_1.text_.text = var_127_34
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318211", "318211030", "story_v_out_318211.awb") ~= 0 then
					local var_127_38 = manager.audio:GetVoiceLength("story_v_out_318211", "318211030", "story_v_out_318211.awb") / 1000

					if var_127_38 + var_127_30 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_38 + var_127_30
					end

					if var_127_33.prefab_name ~= "" and arg_124_1.actors_[var_127_33.prefab_name] ~= nil then
						local var_127_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_124_1.actors_[var_127_33.prefab_name].transform, "story_v_out_318211", "318211030", "story_v_out_318211.awb")

						arg_124_1:RecordAudio("318211030", var_127_39)
						arg_124_1:RecordAudio("318211030", var_127_39)
					else
						arg_124_1:AudioAction("play", "voice", "story_v_out_318211", "318211030", "story_v_out_318211.awb")
					end

					arg_124_1:RecordHistoryTalkVoice("story_v_out_318211", "318211030", "story_v_out_318211.awb")
				end

				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_40 = math.max(var_127_31, arg_124_1.talkMaxDuration)

			if var_127_30 <= arg_124_1.time_ and arg_124_1.time_ < var_127_30 + var_127_40 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_30) / var_127_40

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_30 + var_127_40 and arg_124_1.time_ < var_127_30 + var_127_40 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1199ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_124_1:InitPlayNodeList()
	end,
	Play318211031 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 318211031
		arg_128_1.duration_ = 5.33

		local var_128_0 = {
			zh = 5.333,
			ja = 4.766
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
				arg_128_0:Play318211032(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			local var_131_0 = arg_128_1.actors_["1093ui_story"]
			local var_131_1 = 0

			if var_131_1 < arg_128_1.time_ and arg_128_1.time_ <= var_131_1 + arg_131_0 and not isNil(var_131_0) and arg_128_1.var_.characterEffect1093ui_story == nil then
				arg_128_1.var_.characterEffect1093ui_story = var_131_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_131_2 = 0.200000002980232

			if var_131_1 <= arg_128_1.time_ and arg_128_1.time_ < var_131_1 + var_131_2 and not isNil(var_131_0) then
				local var_131_3 = (arg_128_1.time_ - var_131_1) / var_131_2

				if arg_128_1.var_.characterEffect1093ui_story and not isNil(var_131_0) then
					arg_128_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_128_1.time_ >= var_131_1 + var_131_2 and arg_128_1.time_ < var_131_1 + var_131_2 + arg_131_0 and not isNil(var_131_0) and arg_128_1.var_.characterEffect1093ui_story then
				arg_128_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_131_4 = 0
			local var_131_5 = 0.75

			if var_131_4 < arg_128_1.time_ and arg_128_1.time_ <= var_131_4 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				local var_131_6 = arg_128_1:FormatText(StoryNameCfg[73].name)

				arg_128_1.leftNameTxt_.text = var_131_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_7 = arg_128_1:GetWordFromCfg(318211031)
				local var_131_8 = arg_128_1:FormatText(var_131_7.content)

				arg_128_1.text_.text = var_131_8

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_9 = 30
				local var_131_10 = utf8.len(var_131_8)
				local var_131_11 = var_131_9 <= 0 and var_131_5 or var_131_5 * (var_131_10 / var_131_9)

				if var_131_11 > 0 and var_131_5 < var_131_11 then
					arg_128_1.talkMaxDuration = var_131_11

					if var_131_11 + var_131_4 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_11 + var_131_4
					end
				end

				arg_128_1.text_.text = var_131_8
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318211", "318211031", "story_v_out_318211.awb") ~= 0 then
					local var_131_12 = manager.audio:GetVoiceLength("story_v_out_318211", "318211031", "story_v_out_318211.awb") / 1000

					if var_131_12 + var_131_4 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_12 + var_131_4
					end

					if var_131_7.prefab_name ~= "" and arg_128_1.actors_[var_131_7.prefab_name] ~= nil then
						local var_131_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_7.prefab_name].transform, "story_v_out_318211", "318211031", "story_v_out_318211.awb")

						arg_128_1:RecordAudio("318211031", var_131_13)
						arg_128_1:RecordAudio("318211031", var_131_13)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_out_318211", "318211031", "story_v_out_318211.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_out_318211", "318211031", "story_v_out_318211.awb")
				end

				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_14 = math.max(var_131_5, arg_128_1.talkMaxDuration)

			if var_131_4 <= arg_128_1.time_ and arg_128_1.time_ < var_131_4 + var_131_14 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_4) / var_131_14

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_4 + var_131_14 and arg_128_1.time_ < var_131_4 + var_131_14 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {}

		arg_128_1:InitPlayNodeList()
	end,
	Play318211032 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 318211032
		arg_132_1.duration_ = 5.6

		local var_132_0 = {
			zh = 4.966,
			ja = 5.6
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
				arg_132_0:Play318211033(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			local var_135_0 = arg_132_1.actors_["1093ui_story"]
			local var_135_1 = 0

			if var_135_1 < arg_132_1.time_ and arg_132_1.time_ <= var_135_1 + arg_135_0 and not isNil(var_135_0) and arg_132_1.var_.characterEffect1093ui_story == nil then
				arg_132_1.var_.characterEffect1093ui_story = var_135_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_135_2 = 0.200000002980232

			if var_135_1 <= arg_132_1.time_ and arg_132_1.time_ < var_135_1 + var_135_2 and not isNil(var_135_0) then
				local var_135_3 = (arg_132_1.time_ - var_135_1) / var_135_2

				if arg_132_1.var_.characterEffect1093ui_story and not isNil(var_135_0) then
					arg_132_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_132_1.time_ >= var_135_1 + var_135_2 and arg_132_1.time_ < var_135_1 + var_135_2 + arg_135_0 and not isNil(var_135_0) and arg_132_1.var_.characterEffect1093ui_story then
				arg_132_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_135_4 = 0
			local var_135_5 = 0.55

			if var_135_4 < arg_132_1.time_ and arg_132_1.time_ <= var_135_4 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				local var_135_6 = arg_132_1:FormatText(StoryNameCfg[73].name)

				arg_132_1.leftNameTxt_.text = var_135_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_7 = arg_132_1:GetWordFromCfg(318211032)
				local var_135_8 = arg_132_1:FormatText(var_135_7.content)

				arg_132_1.text_.text = var_135_8

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_9 = 22
				local var_135_10 = utf8.len(var_135_8)
				local var_135_11 = var_135_9 <= 0 and var_135_5 or var_135_5 * (var_135_10 / var_135_9)

				if var_135_11 > 0 and var_135_5 < var_135_11 then
					arg_132_1.talkMaxDuration = var_135_11

					if var_135_11 + var_135_4 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_11 + var_135_4
					end
				end

				arg_132_1.text_.text = var_135_8
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318211", "318211032", "story_v_out_318211.awb") ~= 0 then
					local var_135_12 = manager.audio:GetVoiceLength("story_v_out_318211", "318211032", "story_v_out_318211.awb") / 1000

					if var_135_12 + var_135_4 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_12 + var_135_4
					end

					if var_135_7.prefab_name ~= "" and arg_132_1.actors_[var_135_7.prefab_name] ~= nil then
						local var_135_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_7.prefab_name].transform, "story_v_out_318211", "318211032", "story_v_out_318211.awb")

						arg_132_1:RecordAudio("318211032", var_135_13)
						arg_132_1:RecordAudio("318211032", var_135_13)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_out_318211", "318211032", "story_v_out_318211.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_out_318211", "318211032", "story_v_out_318211.awb")
				end

				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_14 = math.max(var_135_5, arg_132_1.talkMaxDuration)

			if var_135_4 <= arg_132_1.time_ and arg_132_1.time_ < var_135_4 + var_135_14 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_4) / var_135_14

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_4 + var_135_14 and arg_132_1.time_ < var_135_4 + var_135_14 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {}

		arg_132_1:InitPlayNodeList()
	end,
	Play318211033 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 318211033
		arg_136_1.duration_ = 5.07

		local var_136_0 = {
			zh = 3.566,
			ja = 5.066
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
				arg_136_0:Play318211034(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			local var_139_0 = arg_136_1.actors_["1199ui_story"]
			local var_139_1 = 0

			if var_139_1 < arg_136_1.time_ and arg_136_1.time_ <= var_139_1 + arg_139_0 and not isNil(var_139_0) and arg_136_1.var_.characterEffect1199ui_story == nil then
				arg_136_1.var_.characterEffect1199ui_story = var_139_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_139_2 = 0.200000002980232

			if var_139_1 <= arg_136_1.time_ and arg_136_1.time_ < var_139_1 + var_139_2 and not isNil(var_139_0) then
				local var_139_3 = (arg_136_1.time_ - var_139_1) / var_139_2

				if arg_136_1.var_.characterEffect1199ui_story and not isNil(var_139_0) then
					arg_136_1.var_.characterEffect1199ui_story.fillFlat = false
				end
			end

			if arg_136_1.time_ >= var_139_1 + var_139_2 and arg_136_1.time_ < var_139_1 + var_139_2 + arg_139_0 and not isNil(var_139_0) and arg_136_1.var_.characterEffect1199ui_story then
				arg_136_1.var_.characterEffect1199ui_story.fillFlat = false
			end

			local var_139_4 = arg_136_1.actors_["1093ui_story"]
			local var_139_5 = 0

			if var_139_5 < arg_136_1.time_ and arg_136_1.time_ <= var_139_5 + arg_139_0 and not isNil(var_139_4) and arg_136_1.var_.characterEffect1093ui_story == nil then
				arg_136_1.var_.characterEffect1093ui_story = var_139_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_139_6 = 0.200000002980232

			if var_139_5 <= arg_136_1.time_ and arg_136_1.time_ < var_139_5 + var_139_6 and not isNil(var_139_4) then
				local var_139_7 = (arg_136_1.time_ - var_139_5) / var_139_6

				if arg_136_1.var_.characterEffect1093ui_story and not isNil(var_139_4) then
					local var_139_8 = Mathf.Lerp(0, 0.5, var_139_7)

					arg_136_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_136_1.var_.characterEffect1093ui_story.fillRatio = var_139_8
				end
			end

			if arg_136_1.time_ >= var_139_5 + var_139_6 and arg_136_1.time_ < var_139_5 + var_139_6 + arg_139_0 and not isNil(var_139_4) and arg_136_1.var_.characterEffect1093ui_story then
				local var_139_9 = 0.5

				arg_136_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_136_1.var_.characterEffect1093ui_story.fillRatio = var_139_9
			end

			local var_139_10 = 0
			local var_139_11 = 0.4

			if var_139_10 < arg_136_1.time_ and arg_136_1.time_ <= var_139_10 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				local var_139_12 = arg_136_1:FormatText(StoryNameCfg[84].name)

				arg_136_1.leftNameTxt_.text = var_139_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_13 = arg_136_1:GetWordFromCfg(318211033)
				local var_139_14 = arg_136_1:FormatText(var_139_13.content)

				arg_136_1.text_.text = var_139_14

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_15 = 16
				local var_139_16 = utf8.len(var_139_14)
				local var_139_17 = var_139_15 <= 0 and var_139_11 or var_139_11 * (var_139_16 / var_139_15)

				if var_139_17 > 0 and var_139_11 < var_139_17 then
					arg_136_1.talkMaxDuration = var_139_17

					if var_139_17 + var_139_10 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_17 + var_139_10
					end
				end

				arg_136_1.text_.text = var_139_14
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318211", "318211033", "story_v_out_318211.awb") ~= 0 then
					local var_139_18 = manager.audio:GetVoiceLength("story_v_out_318211", "318211033", "story_v_out_318211.awb") / 1000

					if var_139_18 + var_139_10 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_18 + var_139_10
					end

					if var_139_13.prefab_name ~= "" and arg_136_1.actors_[var_139_13.prefab_name] ~= nil then
						local var_139_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_136_1.actors_[var_139_13.prefab_name].transform, "story_v_out_318211", "318211033", "story_v_out_318211.awb")

						arg_136_1:RecordAudio("318211033", var_139_19)
						arg_136_1:RecordAudio("318211033", var_139_19)
					else
						arg_136_1:AudioAction("play", "voice", "story_v_out_318211", "318211033", "story_v_out_318211.awb")
					end

					arg_136_1:RecordHistoryTalkVoice("story_v_out_318211", "318211033", "story_v_out_318211.awb")
				end

				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_20 = math.max(var_139_11, arg_136_1.talkMaxDuration)

			if var_139_10 <= arg_136_1.time_ and arg_136_1.time_ < var_139_10 + var_139_20 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_10) / var_139_20

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_10 + var_139_20 and arg_136_1.time_ < var_139_10 + var_139_20 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {}

		arg_136_1:InitPlayNodeList()
	end,
	Play318211034 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 318211034
		arg_140_1.duration_ = 5

		SetActive(arg_140_1.tipsGo_, false)

		function arg_140_1.onSingleLineFinish_()
			arg_140_1.onSingleLineUpdate_ = nil
			arg_140_1.onSingleLineFinish_ = nil
			arg_140_1.state_ = "waiting"
		end

		function arg_140_1.playNext_(arg_142_0)
			if arg_142_0 == 1 then
				arg_140_0:Play318211035(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			local var_143_0 = arg_140_1.actors_["1199ui_story"]
			local var_143_1 = 0

			if var_143_1 < arg_140_1.time_ and arg_140_1.time_ <= var_143_1 + arg_143_0 and not isNil(var_143_0) and arg_140_1.var_.characterEffect1199ui_story == nil then
				arg_140_1.var_.characterEffect1199ui_story = var_143_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_143_2 = 0.200000002980232

			if var_143_1 <= arg_140_1.time_ and arg_140_1.time_ < var_143_1 + var_143_2 and not isNil(var_143_0) then
				local var_143_3 = (arg_140_1.time_ - var_143_1) / var_143_2

				if arg_140_1.var_.characterEffect1199ui_story and not isNil(var_143_0) then
					local var_143_4 = Mathf.Lerp(0, 0.5, var_143_3)

					arg_140_1.var_.characterEffect1199ui_story.fillFlat = true
					arg_140_1.var_.characterEffect1199ui_story.fillRatio = var_143_4
				end
			end

			if arg_140_1.time_ >= var_143_1 + var_143_2 and arg_140_1.time_ < var_143_1 + var_143_2 + arg_143_0 and not isNil(var_143_0) and arg_140_1.var_.characterEffect1199ui_story then
				local var_143_5 = 0.5

				arg_140_1.var_.characterEffect1199ui_story.fillFlat = true
				arg_140_1.var_.characterEffect1199ui_story.fillRatio = var_143_5
			end

			local var_143_6 = 0
			local var_143_7 = 0.45

			if var_143_6 < arg_140_1.time_ and arg_140_1.time_ <= var_143_6 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, false)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_140_1.iconTrs_.gameObject, false)
				arg_140_1.callingController_:SetSelectedState("normal")

				local var_143_8 = arg_140_1:GetWordFromCfg(318211034)
				local var_143_9 = arg_140_1:FormatText(var_143_8.content)

				arg_140_1.text_.text = var_143_9

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_10 = 18
				local var_143_11 = utf8.len(var_143_9)
				local var_143_12 = var_143_10 <= 0 and var_143_7 or var_143_7 * (var_143_11 / var_143_10)

				if var_143_12 > 0 and var_143_7 < var_143_12 then
					arg_140_1.talkMaxDuration = var_143_12

					if var_143_12 + var_143_6 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_12 + var_143_6
					end
				end

				arg_140_1.text_.text = var_143_9
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)
				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_13 = math.max(var_143_7, arg_140_1.talkMaxDuration)

			if var_143_6 <= arg_140_1.time_ and arg_140_1.time_ < var_143_6 + var_143_13 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_6) / var_143_13

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_6 + var_143_13 and arg_140_1.time_ < var_143_6 + var_143_13 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {}

		arg_140_1:InitPlayNodeList()
	end,
	Play318211035 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 318211035
		arg_144_1.duration_ = 8.77

		local var_144_0 = {
			zh = 8.766,
			ja = 5.866
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
				arg_144_0:Play318211036(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			local var_147_0 = arg_144_1.actors_["1199ui_story"]
			local var_147_1 = 0

			if var_147_1 < arg_144_1.time_ and arg_144_1.time_ <= var_147_1 + arg_147_0 and not isNil(var_147_0) and arg_144_1.var_.characterEffect1199ui_story == nil then
				arg_144_1.var_.characterEffect1199ui_story = var_147_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_147_2 = 0.200000002980232

			if var_147_1 <= arg_144_1.time_ and arg_144_1.time_ < var_147_1 + var_147_2 and not isNil(var_147_0) then
				local var_147_3 = (arg_144_1.time_ - var_147_1) / var_147_2

				if arg_144_1.var_.characterEffect1199ui_story and not isNil(var_147_0) then
					arg_144_1.var_.characterEffect1199ui_story.fillFlat = false
				end
			end

			if arg_144_1.time_ >= var_147_1 + var_147_2 and arg_144_1.time_ < var_147_1 + var_147_2 + arg_147_0 and not isNil(var_147_0) and arg_144_1.var_.characterEffect1199ui_story then
				arg_144_1.var_.characterEffect1199ui_story.fillFlat = false
			end

			local var_147_4 = 0

			if var_147_4 < arg_144_1.time_ and arg_144_1.time_ <= var_147_4 + arg_147_0 then
				arg_144_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/story1199/story1199action/1199action4_2")
			end

			local var_147_5 = 0
			local var_147_6 = 1.025

			if var_147_5 < arg_144_1.time_ and arg_144_1.time_ <= var_147_5 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				local var_147_7 = arg_144_1:FormatText(StoryNameCfg[84].name)

				arg_144_1.leftNameTxt_.text = var_147_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, false)
				arg_144_1.callingController_:SetSelectedState("normal")

				local var_147_8 = arg_144_1:GetWordFromCfg(318211035)
				local var_147_9 = arg_144_1:FormatText(var_147_8.content)

				arg_144_1.text_.text = var_147_9

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_10 = 41
				local var_147_11 = utf8.len(var_147_9)
				local var_147_12 = var_147_10 <= 0 and var_147_6 or var_147_6 * (var_147_11 / var_147_10)

				if var_147_12 > 0 and var_147_6 < var_147_12 then
					arg_144_1.talkMaxDuration = var_147_12

					if var_147_12 + var_147_5 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_12 + var_147_5
					end
				end

				arg_144_1.text_.text = var_147_9
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318211", "318211035", "story_v_out_318211.awb") ~= 0 then
					local var_147_13 = manager.audio:GetVoiceLength("story_v_out_318211", "318211035", "story_v_out_318211.awb") / 1000

					if var_147_13 + var_147_5 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_13 + var_147_5
					end

					if var_147_8.prefab_name ~= "" and arg_144_1.actors_[var_147_8.prefab_name] ~= nil then
						local var_147_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_144_1.actors_[var_147_8.prefab_name].transform, "story_v_out_318211", "318211035", "story_v_out_318211.awb")

						arg_144_1:RecordAudio("318211035", var_147_14)
						arg_144_1:RecordAudio("318211035", var_147_14)
					else
						arg_144_1:AudioAction("play", "voice", "story_v_out_318211", "318211035", "story_v_out_318211.awb")
					end

					arg_144_1:RecordHistoryTalkVoice("story_v_out_318211", "318211035", "story_v_out_318211.awb")
				end

				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_15 = math.max(var_147_6, arg_144_1.talkMaxDuration)

			if var_147_5 <= arg_144_1.time_ and arg_144_1.time_ < var_147_5 + var_147_15 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_5) / var_147_15

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_5 + var_147_15 and arg_144_1.time_ < var_147_5 + var_147_15 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {}

		arg_144_1:InitPlayNodeList()
	end,
	Play318211036 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 318211036
		arg_148_1.duration_ = 7.73

		local var_148_0 = {
			zh = 4.333,
			ja = 7.733
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
				arg_148_0:Play318211037(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			local var_151_0 = 0
			local var_151_1 = 0.525

			if var_151_0 < arg_148_1.time_ and arg_148_1.time_ <= var_151_0 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, true)

				local var_151_2 = arg_148_1:FormatText(StoryNameCfg[84].name)

				arg_148_1.leftNameTxt_.text = var_151_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_148_1.leftNameTxt_.transform)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1.leftNameTxt_.text)
				SetActive(arg_148_1.iconTrs_.gameObject, false)
				arg_148_1.callingController_:SetSelectedState("normal")

				local var_151_3 = arg_148_1:GetWordFromCfg(318211036)
				local var_151_4 = arg_148_1:FormatText(var_151_3.content)

				arg_148_1.text_.text = var_151_4

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_5 = 21
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

				if manager.audio:GetVoiceLength("story_v_out_318211", "318211036", "story_v_out_318211.awb") ~= 0 then
					local var_151_8 = manager.audio:GetVoiceLength("story_v_out_318211", "318211036", "story_v_out_318211.awb") / 1000

					if var_151_8 + var_151_0 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_8 + var_151_0
					end

					if var_151_3.prefab_name ~= "" and arg_148_1.actors_[var_151_3.prefab_name] ~= nil then
						local var_151_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_148_1.actors_[var_151_3.prefab_name].transform, "story_v_out_318211", "318211036", "story_v_out_318211.awb")

						arg_148_1:RecordAudio("318211036", var_151_9)
						arg_148_1:RecordAudio("318211036", var_151_9)
					else
						arg_148_1:AudioAction("play", "voice", "story_v_out_318211", "318211036", "story_v_out_318211.awb")
					end

					arg_148_1:RecordHistoryTalkVoice("story_v_out_318211", "318211036", "story_v_out_318211.awb")
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
	Play318211037 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 318211037
		arg_152_1.duration_ = 5.73

		local var_152_0 = {
			zh = 5.733,
			ja = 3.166
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
			arg_152_1.auto_ = false
		end

		function arg_152_1.playNext_(arg_154_0)
			arg_152_1.onStoryFinished_()
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			local var_155_0 = 0
			local var_155_1 = 0.675

			if var_155_0 < arg_152_1.time_ and arg_152_1.time_ <= var_155_0 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, true)

				local var_155_2 = arg_152_1:FormatText(StoryNameCfg[84].name)

				arg_152_1.leftNameTxt_.text = var_155_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_152_1.leftNameTxt_.transform)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1.leftNameTxt_.text)
				SetActive(arg_152_1.iconTrs_.gameObject, false)
				arg_152_1.callingController_:SetSelectedState("normal")

				local var_155_3 = arg_152_1:GetWordFromCfg(318211037)
				local var_155_4 = arg_152_1:FormatText(var_155_3.content)

				arg_152_1.text_.text = var_155_4

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_5 = 27
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

				if manager.audio:GetVoiceLength("story_v_out_318211", "318211037", "story_v_out_318211.awb") ~= 0 then
					local var_155_8 = manager.audio:GetVoiceLength("story_v_out_318211", "318211037", "story_v_out_318211.awb") / 1000

					if var_155_8 + var_155_0 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_8 + var_155_0
					end

					if var_155_3.prefab_name ~= "" and arg_152_1.actors_[var_155_3.prefab_name] ~= nil then
						local var_155_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_152_1.actors_[var_155_3.prefab_name].transform, "story_v_out_318211", "318211037", "story_v_out_318211.awb")

						arg_152_1:RecordAudio("318211037", var_155_9)
						arg_152_1:RecordAudio("318211037", var_155_9)
					else
						arg_152_1:AudioAction("play", "voice", "story_v_out_318211", "318211037", "story_v_out_318211.awb")
					end

					arg_152_1:RecordHistoryTalkVoice("story_v_out_318211", "318211037", "story_v_out_318211.awb")
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
	assets = {
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/ST69a"
	},
	voices = {
		"story_v_out_318211.awb"
	}
}
