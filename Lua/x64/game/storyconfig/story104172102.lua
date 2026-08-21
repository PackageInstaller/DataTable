return {
	Play417212001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 417212001
		arg_1_1.duration_ = 3.3

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play417212002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = 0

			if var_4_0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_0 + arg_4_0 then
				arg_1_1.cswbg_:SetActive(true)

				local var_4_1 = arg_1_1.cswt_:GetComponent("RectTransform")

				arg_1_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_4_1.offsetMin = Vector2.New(0, 0)
				var_4_1.offsetMax = Vector2.New(0, 0)

				local var_4_2 = arg_1_1:GetWordFromCfg(419111)
				local var_4_3 = arg_1_1:FormatText(var_4_2.content)

				arg_1_1.cswt_.text = var_4_3

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.cswt_)

				arg_1_1.cswt_.fontSize = 120
				arg_1_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_1_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_1_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end

			local var_4_4 = 0

			if var_4_4 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
				arg_1_1.fswbg_:SetActive(true)
				arg_1_1.dialog_:SetActive(false)

				arg_1_1.fswtw_.percent = 0

				local var_4_5 = arg_1_1:GetWordFromCfg(417212001)
				local var_4_6 = arg_1_1:FormatText(var_4_5.content)

				arg_1_1.fswt_.text = var_4_6

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.fswt_)

				arg_1_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_1_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_1_1.fswtw_:SetDirty()

				arg_1_1.typewritterCharCountI18N = 0

				SetActive(arg_1_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_1_1:ShowNextGo(false)
			end

			local var_4_7 = 1.96666666666667

			if var_4_7 < arg_1_1.time_ and arg_1_1.time_ <= var_4_7 + arg_4_0 then
				arg_1_1.var_.oldValueTypewriter = arg_1_1.fswtw_.percent

				SetActive(arg_1_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_1_1:ShowNextGo(false)
			end

			local var_4_8 = 20
			local var_4_9 = 1.33333333333333
			local var_4_10 = arg_1_1:GetWordFromCfg(417212001)
			local var_4_11 = arg_1_1:FormatText(var_4_10.content)
			local var_4_12, var_4_13 = arg_1_1:GetPercentByPara(var_4_11, 1)

			if var_4_7 < arg_1_1.time_ and arg_1_1.time_ <= var_4_7 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				local var_4_14 = var_4_8 <= 0 and var_4_9 or var_4_9 * ((var_4_13 - arg_1_1.typewritterCharCountI18N) / var_4_8)

				if var_4_14 > 0 and var_4_9 < var_4_14 then
					arg_1_1.talkMaxDuration = var_4_14

					if var_4_14 + var_4_7 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_14 + var_4_7
					end
				end
			end

			local var_4_15 = 1.33333333333333
			local var_4_16 = math.max(var_4_15, arg_1_1.talkMaxDuration)

			if var_4_7 <= arg_1_1.time_ and arg_1_1.time_ < var_4_7 + var_4_16 then
				local var_4_17 = (arg_1_1.time_ - var_4_7) / var_4_16

				arg_1_1.fswtw_.percent = Mathf.Lerp(arg_1_1.var_.oldValueTypewriter, var_4_12, var_4_17)
				arg_1_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_1_1.fswtw_:SetDirty()
			end

			if arg_1_1.time_ >= var_4_7 + var_4_16 and arg_1_1.time_ < var_4_7 + var_4_16 + arg_4_0 then
				arg_1_1.fswtw_.percent = var_4_12

				arg_1_1.fswtw_:SetDirty()
				arg_1_1:ShowNextGo(true)

				arg_1_1.typewritterCharCountI18N = var_4_13
			end

			local var_4_18 = 1.96666666666667

			if var_4_18 < arg_1_1.time_ and arg_1_1.time_ <= var_4_18 + arg_4_0 then
				local var_4_19 = arg_1_1.fswbg_.transform:Find("textbox/adapt/content") or arg_1_1.fswbg_.transform:Find("textbox/content")
				local var_4_20 = arg_1_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_4_21 = var_4_19:GetComponent("Text")
				local var_4_22 = var_4_19:GetComponent("RectTransform")

				var_4_21.alignment = UnityEngine.TextAnchor.LowerCenter
				var_4_22.offsetMin = Vector2.New(0, 0)
				var_4_22.offsetMax = Vector2.New(0, 0)
			end

			local var_4_23 = 0

			if var_4_23 < arg_1_1.time_ and arg_1_1.time_ <= var_4_23 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = false

				arg_1_1:SetGaussion(false)
			end

			local var_4_24 = 1

			if var_4_23 <= arg_1_1.time_ and arg_1_1.time_ < var_4_23 + var_4_24 then
				local var_4_25 = (arg_1_1.time_ - var_4_23) / var_4_24
				local var_4_26 = Color.New(0, 0, 0)

				var_4_26.a = Mathf.Lerp(1, 0, var_4_25)
				arg_1_1.mask_.color = var_4_26
			end

			if arg_1_1.time_ >= var_4_23 + var_4_24 and arg_1_1.time_ < var_4_23 + var_4_24 + arg_4_0 then
				local var_4_27 = Color.New(0, 0, 0)
				local var_4_28 = 0

				arg_1_1.mask_.enabled = false
				var_4_27.a = var_4_28
				arg_1_1.mask_.color = var_4_27
			end

			local var_4_29 = 0
			local var_4_30 = 0.2

			if var_4_29 < arg_1_1.time_ and arg_1_1.time_ <= var_4_29 + arg_4_0 then
				local var_4_31 = "play"
				local var_4_32 = "music"

				arg_1_1:AudioAction(var_4_31, var_4_32, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_33 = ""
				local var_4_34 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_34 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_34 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_34

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_34
						arg_1_1.bgmTxt2_.text = var_4_34
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

			local var_4_35 = 0.05
			local var_4_36 = 1

			if var_4_35 < arg_1_1.time_ and arg_1_1.time_ <= var_4_35 + arg_4_0 then
				local var_4_37 = "play"
				local var_4_38 = "effect"

				arg_1_1:AudioAction(var_4_37, var_4_38, "se_story_1310", "se_story_1310_wind", "")
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play417212002 = function(arg_6_0, arg_6_1)
		arg_6_1.time_ = 0
		arg_6_1.frameCnt_ = 0
		arg_6_1.state_ = "playing"
		arg_6_1.curTalkId_ = 417212002
		arg_6_1.duration_ = 3.3

		SetActive(arg_6_1.tipsGo_, false)

		function arg_6_1.onSingleLineFinish_()
			arg_6_1.onSingleLineUpdate_ = nil
			arg_6_1.onSingleLineFinish_ = nil
			arg_6_1.state_ = "waiting"
		end

		function arg_6_1.playNext_(arg_8_0)
			if arg_8_0 == 1 then
				arg_6_0:Play417212003(arg_6_1)
			end
		end

		function arg_6_1.onSingleLineUpdate_(arg_9_0)
			local var_9_0 = 0

			if var_9_0 < arg_6_1.time_ and arg_6_1.time_ <= var_9_0 + arg_9_0 then
				arg_6_1.fswbg_:SetActive(true)
				arg_6_1.dialog_:SetActive(false)

				arg_6_1.fswtw_.percent = 0

				local var_9_1 = arg_6_1:GetWordFromCfg(417212002)
				local var_9_2 = arg_6_1:FormatText(var_9_1.content)

				arg_6_1.fswt_.text = var_9_2

				LuaForUtil.ClearLinePrefixSymbol(arg_6_1.fswt_)

				arg_6_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_6_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_6_1.fswtw_:SetDirty()

				arg_6_1.typewritterCharCountI18N = 0

				SetActive(arg_6_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_6_1:ShowNextGo(false)
			end

			local var_9_3 = 0.0999999999999999

			if var_9_3 < arg_6_1.time_ and arg_6_1.time_ <= var_9_3 + arg_9_0 then
				arg_6_1.var_.oldValueTypewriter = arg_6_1.fswtw_.percent

				SetActive(arg_6_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_6_1:ShowNextGo(false)
			end

			local var_9_4 = 48
			local var_9_5 = 3.2
			local var_9_6 = arg_6_1:GetWordFromCfg(417212002)
			local var_9_7 = arg_6_1:FormatText(var_9_6.content)
			local var_9_8, var_9_9 = arg_6_1:GetPercentByPara(var_9_7, 1)

			if var_9_3 < arg_6_1.time_ and arg_6_1.time_ <= var_9_3 + arg_9_0 then
				arg_6_1.talkMaxDuration = 0

				local var_9_10 = var_9_4 <= 0 and var_9_5 or var_9_5 * ((var_9_9 - arg_6_1.typewritterCharCountI18N) / var_9_4)

				if var_9_10 > 0 and var_9_5 < var_9_10 then
					arg_6_1.talkMaxDuration = var_9_10

					if var_9_10 + var_9_3 > arg_6_1.duration_ then
						arg_6_1.duration_ = var_9_10 + var_9_3
					end
				end
			end

			local var_9_11 = 3.2
			local var_9_12 = math.max(var_9_11, arg_6_1.talkMaxDuration)

			if var_9_3 <= arg_6_1.time_ and arg_6_1.time_ < var_9_3 + var_9_12 then
				local var_9_13 = (arg_6_1.time_ - var_9_3) / var_9_12

				arg_6_1.fswtw_.percent = Mathf.Lerp(arg_6_1.var_.oldValueTypewriter, var_9_8, var_9_13)
				arg_6_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_6_1.fswtw_:SetDirty()
			end

			if arg_6_1.time_ >= var_9_3 + var_9_12 and arg_6_1.time_ < var_9_3 + var_9_12 + arg_9_0 then
				arg_6_1.fswtw_.percent = var_9_8

				arg_6_1.fswtw_:SetDirty()
				arg_6_1:ShowNextGo(true)

				arg_6_1.typewritterCharCountI18N = var_9_9
			end
		end

		arg_6_1.nodeConfigList_ = {}

		arg_6_1:InitPlayNodeList()
	end,
	Play417212003 = function(arg_10_0, arg_10_1)
		arg_10_1.time_ = 0
		arg_10_1.frameCnt_ = 0
		arg_10_1.state_ = "playing"
		arg_10_1.curTalkId_ = 417212003
		arg_10_1.duration_ = 2.83

		SetActive(arg_10_1.tipsGo_, false)

		function arg_10_1.onSingleLineFinish_()
			arg_10_1.onSingleLineUpdate_ = nil
			arg_10_1.onSingleLineFinish_ = nil
			arg_10_1.state_ = "waiting"
		end

		function arg_10_1.playNext_(arg_12_0)
			if arg_12_0 == 1 then
				arg_10_0:Play417212004(arg_10_1)
			end
		end

		function arg_10_1.onSingleLineUpdate_(arg_13_0)
			local var_13_0 = 0

			if var_13_0 < arg_10_1.time_ and arg_10_1.time_ <= var_13_0 + arg_13_0 then
				arg_10_1.fswbg_:SetActive(true)
				arg_10_1.dialog_:SetActive(false)

				arg_10_1.fswtw_.percent = 0

				local var_13_1 = arg_10_1:GetWordFromCfg(417212003)
				local var_13_2 = arg_10_1:FormatText(var_13_1.content)

				arg_10_1.fswt_.text = var_13_2

				LuaForUtil.ClearLinePrefixSymbol(arg_10_1.fswt_)

				arg_10_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_10_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_10_1.fswtw_:SetDirty()

				arg_10_1.typewritterCharCountI18N = 0

				SetActive(arg_10_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_10_1:ShowNextGo(false)
			end

			local var_13_3 = 0.0999999999999999

			if var_13_3 < arg_10_1.time_ and arg_10_1.time_ <= var_13_3 + arg_13_0 then
				arg_10_1.var_.oldValueTypewriter = arg_10_1.fswtw_.percent

				SetActive(arg_10_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_10_1:ShowNextGo(false)
			end

			local var_13_4 = 41
			local var_13_5 = 2.73333333333333
			local var_13_6 = arg_10_1:GetWordFromCfg(417212003)
			local var_13_7 = arg_10_1:FormatText(var_13_6.content)
			local var_13_8, var_13_9 = arg_10_1:GetPercentByPara(var_13_7, 1)

			if var_13_3 < arg_10_1.time_ and arg_10_1.time_ <= var_13_3 + arg_13_0 then
				arg_10_1.talkMaxDuration = 0

				local var_13_10 = var_13_4 <= 0 and var_13_5 or var_13_5 * ((var_13_9 - arg_10_1.typewritterCharCountI18N) / var_13_4)

				if var_13_10 > 0 and var_13_5 < var_13_10 then
					arg_10_1.talkMaxDuration = var_13_10

					if var_13_10 + var_13_3 > arg_10_1.duration_ then
						arg_10_1.duration_ = var_13_10 + var_13_3
					end
				end
			end

			local var_13_11 = 2.73333333333333
			local var_13_12 = math.max(var_13_11, arg_10_1.talkMaxDuration)

			if var_13_3 <= arg_10_1.time_ and arg_10_1.time_ < var_13_3 + var_13_12 then
				local var_13_13 = (arg_10_1.time_ - var_13_3) / var_13_12

				arg_10_1.fswtw_.percent = Mathf.Lerp(arg_10_1.var_.oldValueTypewriter, var_13_8, var_13_13)
				arg_10_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_10_1.fswtw_:SetDirty()
			end

			if arg_10_1.time_ >= var_13_3 + var_13_12 and arg_10_1.time_ < var_13_3 + var_13_12 + arg_13_0 then
				arg_10_1.fswtw_.percent = var_13_8

				arg_10_1.fswtw_:SetDirty()
				arg_10_1:ShowNextGo(true)

				arg_10_1.typewritterCharCountI18N = var_13_9
			end
		end

		arg_10_1.nodeConfigList_ = {}

		arg_10_1:InitPlayNodeList()
	end,
	Play417212004 = function(arg_14_0, arg_14_1)
		arg_14_1.time_ = 0
		arg_14_1.frameCnt_ = 0
		arg_14_1.state_ = "playing"
		arg_14_1.curTalkId_ = 417212004
		arg_14_1.duration_ = 1.43

		SetActive(arg_14_1.tipsGo_, false)

		function arg_14_1.onSingleLineFinish_()
			arg_14_1.onSingleLineUpdate_ = nil
			arg_14_1.onSingleLineFinish_ = nil
			arg_14_1.state_ = "waiting"
		end

		function arg_14_1.playNext_(arg_16_0)
			if arg_16_0 == 1 then
				arg_14_0:Play417212005(arg_14_1)
			end
		end

		function arg_14_1.onSingleLineUpdate_(arg_17_0)
			local var_17_0 = 0

			if var_17_0 < arg_14_1.time_ and arg_14_1.time_ <= var_17_0 + arg_17_0 then
				arg_14_1.cswbg_:SetActive(true)

				local var_17_1 = arg_14_1.cswt_:GetComponent("RectTransform")

				arg_14_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_17_1.offsetMin = Vector2.New(0, 0)
				var_17_1.offsetMax = Vector2.New(0, 0)

				local var_17_2 = arg_14_1:GetWordFromCfg(419112)
				local var_17_3 = arg_14_1:FormatText(var_17_2.content)

				arg_14_1.cswt_.text = var_17_3

				LuaForUtil.ClearLinePrefixSymbol(arg_14_1.cswt_)

				arg_14_1.cswt_.fontSize = 120
				arg_14_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_14_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_14_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end

			local var_17_4 = 0

			if var_17_4 < arg_14_1.time_ and arg_14_1.time_ <= var_17_4 + arg_17_0 then
				arg_14_1.fswbg_:SetActive(true)
				arg_14_1.dialog_:SetActive(false)

				arg_14_1.fswtw_.percent = 0

				local var_17_5 = arg_14_1:GetWordFromCfg(417212004)
				local var_17_6 = arg_14_1:FormatText(var_17_5.content)

				arg_14_1.fswt_.text = var_17_6

				LuaForUtil.ClearLinePrefixSymbol(arg_14_1.fswt_)

				arg_14_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_14_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_14_1.fswtw_:SetDirty()

				arg_14_1.typewritterCharCountI18N = 0

				SetActive(arg_14_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_14_1:ShowNextGo(false)
			end

			local var_17_7 = 0.0999999999999998

			if var_17_7 < arg_14_1.time_ and arg_14_1.time_ <= var_17_7 + arg_17_0 then
				arg_14_1.var_.oldValueTypewriter = arg_14_1.fswtw_.percent

				SetActive(arg_14_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_14_1:ShowNextGo(false)
			end

			local var_17_8 = 20
			local var_17_9 = 1.33333333333333
			local var_17_10 = arg_14_1:GetWordFromCfg(417212004)
			local var_17_11 = arg_14_1:FormatText(var_17_10.content)
			local var_17_12, var_17_13 = arg_14_1:GetPercentByPara(var_17_11, 1)

			if var_17_7 < arg_14_1.time_ and arg_14_1.time_ <= var_17_7 + arg_17_0 then
				arg_14_1.talkMaxDuration = 0

				local var_17_14 = var_17_8 <= 0 and var_17_9 or var_17_9 * ((var_17_13 - arg_14_1.typewritterCharCountI18N) / var_17_8)

				if var_17_14 > 0 and var_17_9 < var_17_14 then
					arg_14_1.talkMaxDuration = var_17_14

					if var_17_14 + var_17_7 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_14 + var_17_7
					end
				end
			end

			local var_17_15 = 1.33333333333333
			local var_17_16 = math.max(var_17_15, arg_14_1.talkMaxDuration)

			if var_17_7 <= arg_14_1.time_ and arg_14_1.time_ < var_17_7 + var_17_16 then
				local var_17_17 = (arg_14_1.time_ - var_17_7) / var_17_16

				arg_14_1.fswtw_.percent = Mathf.Lerp(arg_14_1.var_.oldValueTypewriter, var_17_12, var_17_17)
				arg_14_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_14_1.fswtw_:SetDirty()
			end

			if arg_14_1.time_ >= var_17_7 + var_17_16 and arg_14_1.time_ < var_17_7 + var_17_16 + arg_17_0 then
				arg_14_1.fswtw_.percent = var_17_12

				arg_14_1.fswtw_:SetDirty()
				arg_14_1:ShowNextGo(true)

				arg_14_1.typewritterCharCountI18N = var_17_13
			end
		end

		arg_14_1.nodeConfigList_ = {}

		arg_14_1:InitPlayNodeList()
	end,
	Play417212005 = function(arg_18_0, arg_18_1)
		arg_18_1.time_ = 0
		arg_18_1.frameCnt_ = 0
		arg_18_1.state_ = "playing"
		arg_18_1.curTalkId_ = 417212005
		arg_18_1.duration_ = 4.03

		SetActive(arg_18_1.tipsGo_, false)

		function arg_18_1.onSingleLineFinish_()
			arg_18_1.onSingleLineUpdate_ = nil
			arg_18_1.onSingleLineFinish_ = nil
			arg_18_1.state_ = "waiting"
		end

		function arg_18_1.playNext_(arg_20_0)
			if arg_20_0 == 1 then
				arg_18_0:Play417212006(arg_18_1)
			end
		end

		function arg_18_1.onSingleLineUpdate_(arg_21_0)
			local var_21_0 = 0

			if var_21_0 < arg_18_1.time_ and arg_18_1.time_ <= var_21_0 + arg_21_0 then
				arg_18_1.fswbg_:SetActive(true)
				arg_18_1.dialog_:SetActive(false)

				arg_18_1.fswtw_.percent = 0

				local var_21_1 = arg_18_1:GetWordFromCfg(417212005)
				local var_21_2 = arg_18_1:FormatText(var_21_1.content)

				arg_18_1.fswt_.text = var_21_2

				LuaForUtil.ClearLinePrefixSymbol(arg_18_1.fswt_)

				arg_18_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_18_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_18_1.fswtw_:SetDirty()

				arg_18_1.typewritterCharCountI18N = 0

				SetActive(arg_18_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_18_1:ShowNextGo(false)
			end

			local var_21_3 = 0.0999999999999996

			if var_21_3 < arg_18_1.time_ and arg_18_1.time_ <= var_21_3 + arg_21_0 then
				arg_18_1.var_.oldValueTypewriter = arg_18_1.fswtw_.percent

				SetActive(arg_18_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_18_1:ShowNextGo(false)
			end

			local var_21_4 = 59
			local var_21_5 = 3.93333333333333
			local var_21_6 = arg_18_1:GetWordFromCfg(417212005)
			local var_21_7 = arg_18_1:FormatText(var_21_6.content)
			local var_21_8, var_21_9 = arg_18_1:GetPercentByPara(var_21_7, 1)

			if var_21_3 < arg_18_1.time_ and arg_18_1.time_ <= var_21_3 + arg_21_0 then
				arg_18_1.talkMaxDuration = 0

				local var_21_10 = var_21_4 <= 0 and var_21_5 or var_21_5 * ((var_21_9 - arg_18_1.typewritterCharCountI18N) / var_21_4)

				if var_21_10 > 0 and var_21_5 < var_21_10 then
					arg_18_1.talkMaxDuration = var_21_10

					if var_21_10 + var_21_3 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_10 + var_21_3
					end
				end
			end

			local var_21_11 = 3.93333333333333
			local var_21_12 = math.max(var_21_11, arg_18_1.talkMaxDuration)

			if var_21_3 <= arg_18_1.time_ and arg_18_1.time_ < var_21_3 + var_21_12 then
				local var_21_13 = (arg_18_1.time_ - var_21_3) / var_21_12

				arg_18_1.fswtw_.percent = Mathf.Lerp(arg_18_1.var_.oldValueTypewriter, var_21_8, var_21_13)
				arg_18_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_18_1.fswtw_:SetDirty()
			end

			if arg_18_1.time_ >= var_21_3 + var_21_12 and arg_18_1.time_ < var_21_3 + var_21_12 + arg_21_0 then
				arg_18_1.fswtw_.percent = var_21_8

				arg_18_1.fswtw_:SetDirty()
				arg_18_1:ShowNextGo(true)

				arg_18_1.typewritterCharCountI18N = var_21_9
			end
		end

		arg_18_1.nodeConfigList_ = {}

		arg_18_1:InitPlayNodeList()
	end,
	Play417212006 = function(arg_22_0, arg_22_1)
		arg_22_1.time_ = 0
		arg_22_1.frameCnt_ = 0
		arg_22_1.state_ = "playing"
		arg_22_1.curTalkId_ = 417212006
		arg_22_1.duration_ = 3.1

		SetActive(arg_22_1.tipsGo_, false)

		function arg_22_1.onSingleLineFinish_()
			arg_22_1.onSingleLineUpdate_ = nil
			arg_22_1.onSingleLineFinish_ = nil
			arg_22_1.state_ = "waiting"
		end

		function arg_22_1.playNext_(arg_24_0)
			if arg_24_0 == 1 then
				arg_22_0:Play417212007(arg_22_1)
			end
		end

		function arg_22_1.onSingleLineUpdate_(arg_25_0)
			local var_25_0 = 0

			if var_25_0 < arg_22_1.time_ and arg_22_1.time_ <= var_25_0 + arg_25_0 then
				arg_22_1.fswbg_:SetActive(true)
				arg_22_1.dialog_:SetActive(false)

				arg_22_1.fswtw_.percent = 0

				local var_25_1 = arg_22_1:GetWordFromCfg(417212006)
				local var_25_2 = arg_22_1:FormatText(var_25_1.content)

				arg_22_1.fswt_.text = var_25_2

				LuaForUtil.ClearLinePrefixSymbol(arg_22_1.fswt_)

				arg_22_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_22_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_22_1.fswtw_:SetDirty()

				arg_22_1.typewritterCharCountI18N = 0

				SetActive(arg_22_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_22_1:ShowNextGo(false)
			end

			local var_25_3 = 0.0999999999999999

			if var_25_3 < arg_22_1.time_ and arg_22_1.time_ <= var_25_3 + arg_25_0 then
				arg_22_1.var_.oldValueTypewriter = arg_22_1.fswtw_.percent

				SetActive(arg_22_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_22_1:ShowNextGo(false)
			end

			local var_25_4 = 45
			local var_25_5 = 3
			local var_25_6 = arg_22_1:GetWordFromCfg(417212006)
			local var_25_7 = arg_22_1:FormatText(var_25_6.content)
			local var_25_8, var_25_9 = arg_22_1:GetPercentByPara(var_25_7, 1)

			if var_25_3 < arg_22_1.time_ and arg_22_1.time_ <= var_25_3 + arg_25_0 then
				arg_22_1.talkMaxDuration = 0

				local var_25_10 = var_25_4 <= 0 and var_25_5 or var_25_5 * ((var_25_9 - arg_22_1.typewritterCharCountI18N) / var_25_4)

				if var_25_10 > 0 and var_25_5 < var_25_10 then
					arg_22_1.talkMaxDuration = var_25_10

					if var_25_10 + var_25_3 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_10 + var_25_3
					end
				end
			end

			local var_25_11 = 3
			local var_25_12 = math.max(var_25_11, arg_22_1.talkMaxDuration)

			if var_25_3 <= arg_22_1.time_ and arg_22_1.time_ < var_25_3 + var_25_12 then
				local var_25_13 = (arg_22_1.time_ - var_25_3) / var_25_12

				arg_22_1.fswtw_.percent = Mathf.Lerp(arg_22_1.var_.oldValueTypewriter, var_25_8, var_25_13)
				arg_22_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_22_1.fswtw_:SetDirty()
			end

			if arg_22_1.time_ >= var_25_3 + var_25_12 and arg_22_1.time_ < var_25_3 + var_25_12 + arg_25_0 then
				arg_22_1.fswtw_.percent = var_25_8

				arg_22_1.fswtw_:SetDirty()
				arg_22_1:ShowNextGo(true)

				arg_22_1.typewritterCharCountI18N = var_25_9
			end
		end

		arg_22_1.nodeConfigList_ = {}

		arg_22_1:InitPlayNodeList()
	end,
	Play417212007 = function(arg_26_0, arg_26_1)
		arg_26_1.time_ = 0
		arg_26_1.frameCnt_ = 0
		arg_26_1.state_ = "playing"
		arg_26_1.curTalkId_ = 417212007
		arg_26_1.duration_ = 8

		SetActive(arg_26_1.tipsGo_, false)

		function arg_26_1.onSingleLineFinish_()
			arg_26_1.onSingleLineUpdate_ = nil
			arg_26_1.onSingleLineFinish_ = nil
			arg_26_1.state_ = "waiting"
		end

		function arg_26_1.playNext_(arg_28_0)
			if arg_28_0 == 1 then
				arg_26_0:Play417212008(arg_26_1)
			end
		end

		function arg_26_1.onSingleLineUpdate_(arg_29_0)
			local var_29_0 = 3

			if var_29_0 < arg_26_1.time_ and arg_26_1.time_ <= var_29_0 + arg_29_0 then
				arg_26_1.allBtn_.enabled = false
			end

			local var_29_1 = 0.533333333333335

			if arg_26_1.time_ >= var_29_0 + var_29_1 and arg_26_1.time_ < var_29_0 + var_29_1 + arg_29_0 then
				arg_26_1.allBtn_.enabled = true
			end

			local var_29_2 = "I16g"

			if arg_26_1.bgs_[var_29_2] == nil then
				local var_29_3 = Object.Instantiate(arg_26_1.paintGo_)

				var_29_3:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_29_2)
				var_29_3.name = var_29_2
				var_29_3.transform.parent = arg_26_1.stage_.transform
				var_29_3.transform.localPosition = Vector3.New(0, 100, 0)
				arg_26_1.bgs_[var_29_2] = var_29_3
			end

			local var_29_4 = 1

			if var_29_4 < arg_26_1.time_ and arg_26_1.time_ <= var_29_4 + arg_29_0 then
				local var_29_5 = manager.ui.mainCamera.transform.localPosition
				local var_29_6 = Vector3.New(0, 0, 10) + Vector3.New(var_29_5.x, var_29_5.y, 0)
				local var_29_7 = arg_26_1.bgs_.I16g

				var_29_7.transform.localPosition = var_29_6
				var_29_7.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_29_8 = var_29_7:GetComponent("SpriteRenderer")

				if var_29_8 and var_29_8.sprite then
					local var_29_9 = (var_29_7.transform.localPosition - var_29_5).z
					local var_29_10 = manager.ui.mainCameraCom_
					local var_29_11 = 2 * var_29_9 * Mathf.Tan(var_29_10.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_29_12 = var_29_11 * var_29_10.aspect
					local var_29_13 = var_29_8.sprite.bounds.size.x
					local var_29_14 = var_29_8.sprite.bounds.size.y
					local var_29_15 = var_29_12 / var_29_13
					local var_29_16 = var_29_11 / var_29_14
					local var_29_17 = var_29_16 < var_29_15 and var_29_15 or var_29_16

					var_29_7.transform.localScale = Vector3.New(var_29_17, var_29_17, 0)
				end

				for iter_29_0, iter_29_1 in pairs(arg_26_1.bgs_) do
					if iter_29_0 ~= "I16g" then
						iter_29_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_29_18 = 0

			if var_29_18 < arg_26_1.time_ and arg_26_1.time_ <= var_29_18 + arg_29_0 then
				arg_26_1.mask_.enabled = true
				arg_26_1.mask_.raycastTarget = true

				arg_26_1:SetGaussion(false)
			end

			local var_29_19 = 1

			if var_29_18 <= arg_26_1.time_ and arg_26_1.time_ < var_29_18 + var_29_19 then
				local var_29_20 = (arg_26_1.time_ - var_29_18) / var_29_19
				local var_29_21 = Color.New(0, 0, 0)

				var_29_21.a = Mathf.Lerp(0, 1, var_29_20)
				arg_26_1.mask_.color = var_29_21
			end

			if arg_26_1.time_ >= var_29_18 + var_29_19 and arg_26_1.time_ < var_29_18 + var_29_19 + arg_29_0 then
				local var_29_22 = Color.New(0, 0, 0)

				var_29_22.a = 1
				arg_26_1.mask_.color = var_29_22
			end

			local var_29_23 = 1

			if var_29_23 < arg_26_1.time_ and arg_26_1.time_ <= var_29_23 + arg_29_0 then
				arg_26_1.mask_.enabled = true
				arg_26_1.mask_.raycastTarget = true

				arg_26_1:SetGaussion(false)
			end

			local var_29_24 = 2

			if var_29_23 <= arg_26_1.time_ and arg_26_1.time_ < var_29_23 + var_29_24 then
				local var_29_25 = (arg_26_1.time_ - var_29_23) / var_29_24
				local var_29_26 = Color.New(0, 0, 0)

				var_29_26.a = Mathf.Lerp(1, 0, var_29_25)
				arg_26_1.mask_.color = var_29_26
			end

			if arg_26_1.time_ >= var_29_23 + var_29_24 and arg_26_1.time_ < var_29_23 + var_29_24 + arg_29_0 then
				local var_29_27 = Color.New(0, 0, 0)
				local var_29_28 = 0

				arg_26_1.mask_.enabled = false
				var_29_27.a = var_29_28
				arg_26_1.mask_.color = var_29_27
			end

			local var_29_29 = 0.833333333333334

			if var_29_29 < arg_26_1.time_ and arg_26_1.time_ <= var_29_29 + arg_29_0 then
				arg_26_1.cswbg_:SetActive(false)
			end

			local var_29_30 = 0.833333333333334

			if var_29_30 < arg_26_1.time_ and arg_26_1.time_ <= var_29_30 + arg_29_0 then
				arg_26_1.fswbg_:SetActive(false)
				arg_26_1.dialog_:SetActive(false)
				SetActive(arg_26_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_26_1:ShowNextGo(false)
			end

			local var_29_31 = 1

			arg_26_1.isInRecall_ = true

			if var_29_31 < arg_26_1.time_ and arg_26_1.time_ <= var_29_31 + arg_29_0 then
				arg_26_1.screenFilterGo_:SetActive(true)

				arg_26_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_grey.asset")
				arg_26_1.hightColor1 = Color.New(0.8980392, 0.8980392, 0.8980392)
				arg_26_1.hightColor2 = Color.New(0.3411765, 0.3411765, 0.3411765)

				for iter_29_2, iter_29_3 in pairs(arg_26_1.actors_) do
					local var_29_32 = iter_29_3:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_29_4, iter_29_5 in ipairs(var_29_32) do
						if iter_29_5.color.r > 0.51 then
							iter_29_5.color = Color.New(0.8980392, 0.8980392, 0.8980392)
						else
							iter_29_5.color = Color.New(0.3411765, 0.3411765, 0.3411765)
						end
					end
				end
			end

			local var_29_33 = 0.0666666666666667

			if var_29_31 <= arg_26_1.time_ and arg_26_1.time_ < var_29_31 + var_29_33 then
				local var_29_34 = (arg_26_1.time_ - var_29_31) / var_29_33

				arg_26_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, var_29_34)
			end

			if arg_26_1.time_ >= var_29_31 + var_29_33 and arg_26_1.time_ < var_29_31 + var_29_33 + arg_29_0 then
				arg_26_1.screenFilterEffect_.weight = 1
			end

			local var_29_35 = 0.05
			local var_29_36 = 1

			if var_29_35 < arg_26_1.time_ and arg_26_1.time_ <= var_29_35 + arg_29_0 then
				local var_29_37 = "stop"
				local var_29_38 = "effect"

				arg_26_1:AudioAction(var_29_37, var_29_38, "se_story_1310", "se_story_1310_wind", "")
			end

			local var_29_39 = 0
			local var_29_40 = 0.2

			if var_29_39 < arg_26_1.time_ and arg_26_1.time_ <= var_29_39 + arg_29_0 then
				local var_29_41 = "play"
				local var_29_42 = "music"

				arg_26_1:AudioAction(var_29_41, var_29_42, "ui_battle", "ui_battle_stopbgm", "")

				local var_29_43 = ""
				local var_29_44 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_29_44 ~= "" then
					if arg_26_1.bgmTxt_.text ~= var_29_44 and arg_26_1.bgmTxt_.text ~= "" then
						if arg_26_1.bgmTxt2_.text ~= "" then
							arg_26_1.bgmTxt_.text = arg_26_1.bgmTxt2_.text
						end

						arg_26_1.bgmTxt2_.text = var_29_44

						arg_26_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_26_1.bgmTxt_.text = var_29_44
						arg_26_1.bgmTxt2_.text = var_29_44
					end

					if arg_26_1.bgmTimer then
						arg_26_1.bgmTimer:Stop()

						arg_26_1.bgmTimer = nil
					end

					if arg_26_1.settingData.show_music_name == 1 then
						arg_26_1.musicController:SetSelectedState("show")
						arg_26_1.musicAnimator_:Play("open", 0, 0)

						if arg_26_1.settingData.music_time ~= 0 then
							arg_26_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_26_1.settingData.music_time), function()
								if arg_26_1 == nil or isNil(arg_26_1.bgmTxt_) then
									return
								end

								arg_26_1.musicController:SetSelectedState("hide")
								arg_26_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_29_45 = 0.733333333333333
			local var_29_46 = 1

			if var_29_45 < arg_26_1.time_ and arg_26_1.time_ <= var_29_45 + arg_29_0 then
				local var_29_47 = "play"
				local var_29_48 = "music"

				arg_26_1:AudioAction(var_29_47, var_29_48, "bgm_activity_3_10_story_scheme_1", "bgm_activity_3_10_story_scheme_1", "bgm_activity_3_10_story_scheme_1.awb")

				local var_29_49 = ""
				local var_29_50 = manager.audio:GetAudioName("bgm_activity_3_10_story_scheme_1", "bgm_activity_3_10_story_scheme_1")

				if var_29_50 ~= "" then
					if arg_26_1.bgmTxt_.text ~= var_29_50 and arg_26_1.bgmTxt_.text ~= "" then
						if arg_26_1.bgmTxt2_.text ~= "" then
							arg_26_1.bgmTxt_.text = arg_26_1.bgmTxt2_.text
						end

						arg_26_1.bgmTxt2_.text = var_29_50

						arg_26_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_26_1.bgmTxt_.text = var_29_50
						arg_26_1.bgmTxt2_.text = var_29_50
					end

					if arg_26_1.bgmTimer then
						arg_26_1.bgmTimer:Stop()

						arg_26_1.bgmTimer = nil
					end

					if arg_26_1.settingData.show_music_name == 1 then
						arg_26_1.musicController:SetSelectedState("show")
						arg_26_1.musicAnimator_:Play("open", 0, 0)

						if arg_26_1.settingData.music_time ~= 0 then
							arg_26_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_26_1.settingData.music_time), function()
								if arg_26_1 == nil or isNil(arg_26_1.bgmTxt_) then
									return
								end

								arg_26_1.musicController:SetSelectedState("hide")
								arg_26_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_26_1.frameCnt_ <= 1 then
				arg_26_1.dialog_:SetActive(false)
			end

			local var_29_51 = 3
			local var_29_52 = 1.05

			if var_29_51 < arg_26_1.time_ and arg_26_1.time_ <= var_29_51 + arg_29_0 then
				arg_26_1.talkMaxDuration = 0

				arg_26_1.dialog_:SetActive(true)

				arg_26_1.dialogCg_.alpha = 0

				local var_29_53 = LeanTween.value(arg_26_1.dialog_, 0, 1, 0.3)

				var_29_53:setOnUpdate(LuaHelper.FloatAction(function(arg_32_0)
					arg_26_1.dialogCg_.alpha = arg_32_0
				end))
				var_29_53:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_26_1.dialog_)
					var_29_53:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_26_1.duration_ = arg_26_1.duration_ + 0.3

				SetActive(arg_26_1.leftNameGo_, false)

				arg_26_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_26_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_26_1:RecordName(arg_26_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_26_1.iconTrs_.gameObject, false)
				arg_26_1.callingController_:SetSelectedState("normal")

				local var_29_54 = arg_26_1:GetWordFromCfg(417212007)
				local var_29_55 = arg_26_1:FormatText(var_29_54.content)

				arg_26_1.text_.text = var_29_55

				LuaForUtil.ClearLinePrefixSymbol(arg_26_1.text_)

				local var_29_56 = 42
				local var_29_57 = utf8.len(var_29_55)
				local var_29_58 = var_29_56 <= 0 and var_29_52 or var_29_52 * (var_29_57 / var_29_56)

				if var_29_58 > 0 and var_29_52 < var_29_58 then
					arg_26_1.talkMaxDuration = var_29_58
					var_29_51 = var_29_51 + 0.3

					if var_29_58 + var_29_51 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_58 + var_29_51
					end
				end

				arg_26_1.text_.text = var_29_55
				arg_26_1.typewritter.percent = 0

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(false)
				arg_26_1:RecordContent(arg_26_1.text_.text)
			end

			local var_29_59 = var_29_51 + 0.3
			local var_29_60 = math.max(var_29_52, arg_26_1.talkMaxDuration)

			if var_29_59 <= arg_26_1.time_ and arg_26_1.time_ < var_29_59 + var_29_60 then
				arg_26_1.typewritter.percent = (arg_26_1.time_ - var_29_59) / var_29_60

				arg_26_1.typewritter:SetDirty()
			end

			if arg_26_1.time_ >= var_29_59 + var_29_60 and arg_26_1.time_ < var_29_59 + var_29_60 + arg_29_0 then
				arg_26_1.typewritter.percent = 1

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(true)
			end
		end

		arg_26_1.nodeConfigList_ = {}

		arg_26_1:InitPlayNodeList()
	end,
	Play417212008 = function(arg_34_0, arg_34_1)
		arg_34_1.time_ = 0
		arg_34_1.frameCnt_ = 0
		arg_34_1.state_ = "playing"
		arg_34_1.curTalkId_ = 417212008
		arg_34_1.duration_ = 5

		SetActive(arg_34_1.tipsGo_, false)

		function arg_34_1.onSingleLineFinish_()
			arg_34_1.onSingleLineUpdate_ = nil
			arg_34_1.onSingleLineFinish_ = nil
			arg_34_1.state_ = "waiting"
		end

		function arg_34_1.playNext_(arg_36_0)
			if arg_36_0 == 1 then
				arg_34_0:Play417212009(arg_34_1)
			end
		end

		function arg_34_1.onSingleLineUpdate_(arg_37_0)
			local var_37_0 = 0
			local var_37_1 = 1.325

			if var_37_0 < arg_34_1.time_ and arg_34_1.time_ <= var_37_0 + arg_37_0 then
				arg_34_1.talkMaxDuration = 0
				arg_34_1.dialogCg_.alpha = 1

				arg_34_1.dialog_:SetActive(true)
				SetActive(arg_34_1.leftNameGo_, false)

				arg_34_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_34_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_34_1:RecordName(arg_34_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_34_1.iconTrs_.gameObject, false)
				arg_34_1.callingController_:SetSelectedState("normal")

				local var_37_2 = arg_34_1:GetWordFromCfg(417212008)
				local var_37_3 = arg_34_1:FormatText(var_37_2.content)

				arg_34_1.text_.text = var_37_3

				LuaForUtil.ClearLinePrefixSymbol(arg_34_1.text_)

				local var_37_4 = 53
				local var_37_5 = utf8.len(var_37_3)
				local var_37_6 = var_37_4 <= 0 and var_37_1 or var_37_1 * (var_37_5 / var_37_4)

				if var_37_6 > 0 and var_37_1 < var_37_6 then
					arg_34_1.talkMaxDuration = var_37_6

					if var_37_6 + var_37_0 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_6 + var_37_0
					end
				end

				arg_34_1.text_.text = var_37_3
				arg_34_1.typewritter.percent = 0

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(false)
				arg_34_1:RecordContent(arg_34_1.text_.text)
			end

			local var_37_7 = math.max(var_37_1, arg_34_1.talkMaxDuration)

			if var_37_0 <= arg_34_1.time_ and arg_34_1.time_ < var_37_0 + var_37_7 then
				arg_34_1.typewritter.percent = (arg_34_1.time_ - var_37_0) / var_37_7

				arg_34_1.typewritter:SetDirty()
			end

			if arg_34_1.time_ >= var_37_0 + var_37_7 and arg_34_1.time_ < var_37_0 + var_37_7 + arg_37_0 then
				arg_34_1.typewritter.percent = 1

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(true)
			end
		end

		arg_34_1.nodeConfigList_ = {}

		arg_34_1:InitPlayNodeList()
	end,
	Play417212009 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 417212009
		arg_38_1.duration_ = 8.67

		local var_38_0 = {
			zh = 3.133,
			ja = 8.666
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
				arg_38_0:Play417212010(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			local var_41_0 = "10113"

			if arg_38_1.actors_[var_41_0] == nil then
				local var_41_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10113")

				if not isNil(var_41_1) then
					local var_41_2 = Object.Instantiate(var_41_1, arg_38_1.canvasGo_.transform)

					var_41_2.transform:SetSiblingIndex(1)

					var_41_2.name = var_41_0
					var_41_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_38_1.actors_[var_41_0] = var_41_2

					local var_41_3 = var_41_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_38_1.isInRecall_ then
						for iter_41_0, iter_41_1 in ipairs(var_41_3) do
							iter_41_1.color = arg_38_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_41_4 = arg_38_1.actors_["10113"]
			local var_41_5 = 0

			if var_41_5 < arg_38_1.time_ and arg_38_1.time_ <= var_41_5 + arg_41_0 and not isNil(var_41_4) and arg_38_1.var_.actorSpriteComps10113 == nil then
				arg_38_1.var_.actorSpriteComps10113 = var_41_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_41_6 = 0.2

			if var_41_5 <= arg_38_1.time_ and arg_38_1.time_ < var_41_5 + var_41_6 and not isNil(var_41_4) then
				local var_41_7 = (arg_38_1.time_ - var_41_5) / var_41_6

				if arg_38_1.var_.actorSpriteComps10113 then
					for iter_41_2, iter_41_3 in pairs(arg_38_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_41_3 then
							if arg_38_1.isInRecall_ then
								local var_41_8 = Mathf.Lerp(iter_41_3.color.r, arg_38_1.hightColor1.r, var_41_7)
								local var_41_9 = Mathf.Lerp(iter_41_3.color.g, arg_38_1.hightColor1.g, var_41_7)
								local var_41_10 = Mathf.Lerp(iter_41_3.color.b, arg_38_1.hightColor1.b, var_41_7)

								iter_41_3.color = Color.New(var_41_8, var_41_9, var_41_10)
							else
								local var_41_11 = Mathf.Lerp(iter_41_3.color.r, 1, var_41_7)

								iter_41_3.color = Color.New(var_41_11, var_41_11, var_41_11)
							end
						end
					end
				end
			end

			if arg_38_1.time_ >= var_41_5 + var_41_6 and arg_38_1.time_ < var_41_5 + var_41_6 + arg_41_0 and not isNil(var_41_4) and arg_38_1.var_.actorSpriteComps10113 then
				for iter_41_4, iter_41_5 in pairs(arg_38_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_41_5 then
						if arg_38_1.isInRecall_ then
							iter_41_5.color = arg_38_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_41_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_38_1.var_.actorSpriteComps10113 = nil
			end

			local var_41_12 = arg_38_1.actors_["10113"].transform
			local var_41_13 = 0

			if var_41_13 < arg_38_1.time_ and arg_38_1.time_ <= var_41_13 + arg_41_0 then
				arg_38_1.var_.moveOldPos10113 = var_41_12.localPosition
				var_41_12.localScale = Vector3.New(1, 1, 1)

				arg_38_1:CheckSpriteTmpPos("10113", 3)

				local var_41_14 = var_41_12.childCount

				for iter_41_6 = 0, var_41_14 - 1 do
					local var_41_15 = var_41_12:GetChild(iter_41_6)

					if var_41_15.name == "split_6" or not string.find(var_41_15.name, "split") then
						var_41_15.gameObject:SetActive(true)
					else
						var_41_15.gameObject:SetActive(false)
					end
				end
			end

			local var_41_16 = 0.001

			if var_41_13 <= arg_38_1.time_ and arg_38_1.time_ < var_41_13 + var_41_16 then
				local var_41_17 = (arg_38_1.time_ - var_41_13) / var_41_16
				local var_41_18 = Vector3.New(-30.38, -328.4, -517.4)

				var_41_12.localPosition = Vector3.Lerp(arg_38_1.var_.moveOldPos10113, var_41_18, var_41_17)
			end

			if arg_38_1.time_ >= var_41_13 + var_41_16 and arg_38_1.time_ < var_41_13 + var_41_16 + arg_41_0 then
				var_41_12.localPosition = Vector3.New(-30.38, -328.4, -517.4)
			end

			local var_41_19 = 0
			local var_41_20 = 0.275

			if var_41_19 < arg_38_1.time_ and arg_38_1.time_ <= var_41_19 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0
				arg_38_1.dialogCg_.alpha = 1

				arg_38_1.dialog_:SetActive(true)
				SetActive(arg_38_1.leftNameGo_, true)

				local var_41_21 = arg_38_1:FormatText(StoryNameCfg[1117].name)

				arg_38_1.leftNameTxt_.text = var_41_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_38_1.leftNameTxt_.transform)

				arg_38_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_38_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_38_1:RecordName(arg_38_1.leftNameTxt_.text)
				SetActive(arg_38_1.iconTrs_.gameObject, false)
				arg_38_1.callingController_:SetSelectedState("normal")

				local var_41_22 = arg_38_1:GetWordFromCfg(417212009)
				local var_41_23 = arg_38_1:FormatText(var_41_22.content)

				arg_38_1.text_.text = var_41_23

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_24 = 11
				local var_41_25 = utf8.len(var_41_23)
				local var_41_26 = var_41_24 <= 0 and var_41_20 or var_41_20 * (var_41_25 / var_41_24)

				if var_41_26 > 0 and var_41_20 < var_41_26 then
					arg_38_1.talkMaxDuration = var_41_26

					if var_41_26 + var_41_19 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_26 + var_41_19
					end
				end

				arg_38_1.text_.text = var_41_23
				arg_38_1.typewritter.percent = 0

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417212", "417212009", "story_v_out_417212.awb") ~= 0 then
					local var_41_27 = manager.audio:GetVoiceLength("story_v_out_417212", "417212009", "story_v_out_417212.awb") / 1000

					if var_41_27 + var_41_19 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_27 + var_41_19
					end

					if var_41_22.prefab_name ~= "" and arg_38_1.actors_[var_41_22.prefab_name] ~= nil then
						local var_41_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_38_1.actors_[var_41_22.prefab_name].transform, "story_v_out_417212", "417212009", "story_v_out_417212.awb")

						arg_38_1:RecordAudio("417212009", var_41_28)
						arg_38_1:RecordAudio("417212009", var_41_28)
					else
						arg_38_1:AudioAction("play", "voice", "story_v_out_417212", "417212009", "story_v_out_417212.awb")
					end

					arg_38_1:RecordHistoryTalkVoice("story_v_out_417212", "417212009", "story_v_out_417212.awb")
				end

				arg_38_1:RecordContent(arg_38_1.text_.text)
			end

			local var_41_29 = math.max(var_41_20, arg_38_1.talkMaxDuration)

			if var_41_19 <= arg_38_1.time_ and arg_38_1.time_ < var_41_19 + var_41_29 then
				arg_38_1.typewritter.percent = (arg_38_1.time_ - var_41_19) / var_41_29

				arg_38_1.typewritter:SetDirty()
			end

			if arg_38_1.time_ >= var_41_19 + var_41_29 and arg_38_1.time_ < var_41_19 + var_41_29 + arg_41_0 then
				arg_38_1.typewritter.percent = 1

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(true)
			end
		end

		arg_38_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10113",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_38_1:InitPlayNodeList()
	end,
	Play417212010 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 417212010
		arg_42_1.duration_ = 5.1

		local var_42_0 = {
			zh = 4.066,
			ja = 5.1
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
				arg_42_0:Play417212011(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			local var_45_0 = "10128"

			if arg_42_1.actors_[var_45_0] == nil then
				local var_45_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10128")

				if not isNil(var_45_1) then
					local var_45_2 = Object.Instantiate(var_45_1, arg_42_1.canvasGo_.transform)

					var_45_2.transform:SetSiblingIndex(1)

					var_45_2.name = var_45_0
					var_45_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_42_1.actors_[var_45_0] = var_45_2

					local var_45_3 = var_45_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_42_1.isInRecall_ then
						for iter_45_0, iter_45_1 in ipairs(var_45_3) do
							iter_45_1.color = arg_42_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_45_4 = arg_42_1.actors_["10128"]
			local var_45_5 = 0

			if var_45_5 < arg_42_1.time_ and arg_42_1.time_ <= var_45_5 + arg_45_0 and not isNil(var_45_4) and arg_42_1.var_.actorSpriteComps10128 == nil then
				arg_42_1.var_.actorSpriteComps10128 = var_45_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_45_6 = 0.2

			if var_45_5 <= arg_42_1.time_ and arg_42_1.time_ < var_45_5 + var_45_6 and not isNil(var_45_4) then
				local var_45_7 = (arg_42_1.time_ - var_45_5) / var_45_6

				if arg_42_1.var_.actorSpriteComps10128 then
					for iter_45_2, iter_45_3 in pairs(arg_42_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_45_3 then
							if arg_42_1.isInRecall_ then
								local var_45_8 = Mathf.Lerp(iter_45_3.color.r, arg_42_1.hightColor1.r, var_45_7)
								local var_45_9 = Mathf.Lerp(iter_45_3.color.g, arg_42_1.hightColor1.g, var_45_7)
								local var_45_10 = Mathf.Lerp(iter_45_3.color.b, arg_42_1.hightColor1.b, var_45_7)

								iter_45_3.color = Color.New(var_45_8, var_45_9, var_45_10)
							else
								local var_45_11 = Mathf.Lerp(iter_45_3.color.r, 1, var_45_7)

								iter_45_3.color = Color.New(var_45_11, var_45_11, var_45_11)
							end
						end
					end
				end
			end

			if arg_42_1.time_ >= var_45_5 + var_45_6 and arg_42_1.time_ < var_45_5 + var_45_6 + arg_45_0 and not isNil(var_45_4) and arg_42_1.var_.actorSpriteComps10128 then
				for iter_45_4, iter_45_5 in pairs(arg_42_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_45_5 then
						if arg_42_1.isInRecall_ then
							iter_45_5.color = arg_42_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_45_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_42_1.var_.actorSpriteComps10128 = nil
			end

			local var_45_12 = arg_42_1.actors_["10113"]
			local var_45_13 = 0

			if var_45_13 < arg_42_1.time_ and arg_42_1.time_ <= var_45_13 + arg_45_0 and not isNil(var_45_12) and arg_42_1.var_.actorSpriteComps10113 == nil then
				arg_42_1.var_.actorSpriteComps10113 = var_45_12:GetComponentsInChildren(typeof(Image), true)
			end

			local var_45_14 = 0.2

			if var_45_13 <= arg_42_1.time_ and arg_42_1.time_ < var_45_13 + var_45_14 and not isNil(var_45_12) then
				local var_45_15 = (arg_42_1.time_ - var_45_13) / var_45_14

				if arg_42_1.var_.actorSpriteComps10113 then
					for iter_45_6, iter_45_7 in pairs(arg_42_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_45_7 then
							if arg_42_1.isInRecall_ then
								local var_45_16 = Mathf.Lerp(iter_45_7.color.r, arg_42_1.hightColor2.r, var_45_15)
								local var_45_17 = Mathf.Lerp(iter_45_7.color.g, arg_42_1.hightColor2.g, var_45_15)
								local var_45_18 = Mathf.Lerp(iter_45_7.color.b, arg_42_1.hightColor2.b, var_45_15)

								iter_45_7.color = Color.New(var_45_16, var_45_17, var_45_18)
							else
								local var_45_19 = Mathf.Lerp(iter_45_7.color.r, 0.5, var_45_15)

								iter_45_7.color = Color.New(var_45_19, var_45_19, var_45_19)
							end
						end
					end
				end
			end

			if arg_42_1.time_ >= var_45_13 + var_45_14 and arg_42_1.time_ < var_45_13 + var_45_14 + arg_45_0 and not isNil(var_45_12) and arg_42_1.var_.actorSpriteComps10113 then
				for iter_45_8, iter_45_9 in pairs(arg_42_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_45_9 then
						if arg_42_1.isInRecall_ then
							iter_45_9.color = arg_42_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_45_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_42_1.var_.actorSpriteComps10113 = nil
			end

			local var_45_20 = arg_42_1.actors_["10113"].transform
			local var_45_21 = 0

			if var_45_21 < arg_42_1.time_ and arg_42_1.time_ <= var_45_21 + arg_45_0 then
				arg_42_1.var_.moveOldPos10113 = var_45_20.localPosition
				var_45_20.localScale = Vector3.New(1, 1, 1)

				arg_42_1:CheckSpriteTmpPos("10113", 2)

				local var_45_22 = var_45_20.childCount

				for iter_45_10 = 0, var_45_22 - 1 do
					local var_45_23 = var_45_20:GetChild(iter_45_10)

					if var_45_23.name == "" or not string.find(var_45_23.name, "split") then
						var_45_23.gameObject:SetActive(true)
					else
						var_45_23.gameObject:SetActive(false)
					end
				end
			end

			local var_45_24 = 0.001

			if var_45_21 <= arg_42_1.time_ and arg_42_1.time_ < var_45_21 + var_45_24 then
				local var_45_25 = (arg_42_1.time_ - var_45_21) / var_45_24
				local var_45_26 = Vector3.New(-403.26, -328.4, -517.4)

				var_45_20.localPosition = Vector3.Lerp(arg_42_1.var_.moveOldPos10113, var_45_26, var_45_25)
			end

			if arg_42_1.time_ >= var_45_21 + var_45_24 and arg_42_1.time_ < var_45_21 + var_45_24 + arg_45_0 then
				var_45_20.localPosition = Vector3.New(-403.26, -328.4, -517.4)
			end

			local var_45_27 = arg_42_1.actors_["10128"].transform
			local var_45_28 = 0

			if var_45_28 < arg_42_1.time_ and arg_42_1.time_ <= var_45_28 + arg_45_0 then
				arg_42_1.var_.moveOldPos10128 = var_45_27.localPosition
				var_45_27.localScale = Vector3.New(1, 1, 1)

				arg_42_1:CheckSpriteTmpPos("10128", 4)

				local var_45_29 = var_45_27.childCount

				for iter_45_11 = 0, var_45_29 - 1 do
					local var_45_30 = var_45_27:GetChild(iter_45_11)

					if var_45_30.name == "split_6" or not string.find(var_45_30.name, "split") then
						var_45_30.gameObject:SetActive(true)
					else
						var_45_30.gameObject:SetActive(false)
					end
				end
			end

			local var_45_31 = 0.001

			if var_45_28 <= arg_42_1.time_ and arg_42_1.time_ < var_45_28 + var_45_31 then
				local var_45_32 = (arg_42_1.time_ - var_45_28) / var_45_31
				local var_45_33 = Vector3.New(390, -347, -300)

				var_45_27.localPosition = Vector3.Lerp(arg_42_1.var_.moveOldPos10128, var_45_33, var_45_32)
			end

			if arg_42_1.time_ >= var_45_28 + var_45_31 and arg_42_1.time_ < var_45_28 + var_45_31 + arg_45_0 then
				var_45_27.localPosition = Vector3.New(390, -347, -300)
			end

			local var_45_34 = 0
			local var_45_35 = 0.5

			if var_45_34 < arg_42_1.time_ and arg_42_1.time_ <= var_45_34 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0
				arg_42_1.dialogCg_.alpha = 1

				arg_42_1.dialog_:SetActive(true)
				SetActive(arg_42_1.leftNameGo_, true)

				local var_45_36 = arg_42_1:FormatText(StoryNameCfg[595].name)

				arg_42_1.leftNameTxt_.text = var_45_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_42_1.leftNameTxt_.transform)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1.leftNameTxt_.text)
				SetActive(arg_42_1.iconTrs_.gameObject, false)
				arg_42_1.callingController_:SetSelectedState("normal")

				local var_45_37 = arg_42_1:GetWordFromCfg(417212010)
				local var_45_38 = arg_42_1:FormatText(var_45_37.content)

				arg_42_1.text_.text = var_45_38

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_39 = 20
				local var_45_40 = utf8.len(var_45_38)
				local var_45_41 = var_45_39 <= 0 and var_45_35 or var_45_35 * (var_45_40 / var_45_39)

				if var_45_41 > 0 and var_45_35 < var_45_41 then
					arg_42_1.talkMaxDuration = var_45_41

					if var_45_41 + var_45_34 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_41 + var_45_34
					end
				end

				arg_42_1.text_.text = var_45_38
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417212", "417212010", "story_v_out_417212.awb") ~= 0 then
					local var_45_42 = manager.audio:GetVoiceLength("story_v_out_417212", "417212010", "story_v_out_417212.awb") / 1000

					if var_45_42 + var_45_34 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_42 + var_45_34
					end

					if var_45_37.prefab_name ~= "" and arg_42_1.actors_[var_45_37.prefab_name] ~= nil then
						local var_45_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_42_1.actors_[var_45_37.prefab_name].transform, "story_v_out_417212", "417212010", "story_v_out_417212.awb")

						arg_42_1:RecordAudio("417212010", var_45_43)
						arg_42_1:RecordAudio("417212010", var_45_43)
					else
						arg_42_1:AudioAction("play", "voice", "story_v_out_417212", "417212010", "story_v_out_417212.awb")
					end

					arg_42_1:RecordHistoryTalkVoice("story_v_out_417212", "417212010", "story_v_out_417212.awb")
				end

				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_44 = math.max(var_45_35, arg_42_1.talkMaxDuration)

			if var_45_34 <= arg_42_1.time_ and arg_42_1.time_ < var_45_34 + var_45_44 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - var_45_34) / var_45_44

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= var_45_34 + var_45_44 and arg_42_1.time_ < var_45_34 + var_45_44 + arg_45_0 then
				arg_42_1.typewritter.percent = 1

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(true)
			end
		end

		arg_42_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10113",
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

		arg_42_1:InitPlayNodeList()
	end,
	Play417212011 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 417212011
		arg_46_1.duration_ = 9.37

		local var_46_0 = {
			zh = 6.4,
			ja = 9.366
		}
		local var_46_1 = manager.audio:GetLocalizationFlag()

		if var_46_0[var_46_1] ~= nil then
			arg_46_1.duration_ = var_46_0[var_46_1]
		end

		SetActive(arg_46_1.tipsGo_, false)

		function arg_46_1.onSingleLineFinish_()
			arg_46_1.onSingleLineUpdate_ = nil
			arg_46_1.onSingleLineFinish_ = nil
			arg_46_1.state_ = "waiting"
		end

		function arg_46_1.playNext_(arg_48_0)
			if arg_48_0 == 1 then
				arg_46_0:Play417212012(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			local var_49_0 = arg_46_1.actors_["10113"]
			local var_49_1 = 0

			if var_49_1 < arg_46_1.time_ and arg_46_1.time_ <= var_49_1 + arg_49_0 and not isNil(var_49_0) and arg_46_1.var_.actorSpriteComps10113 == nil then
				arg_46_1.var_.actorSpriteComps10113 = var_49_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_49_2 = 0.2

			if var_49_1 <= arg_46_1.time_ and arg_46_1.time_ < var_49_1 + var_49_2 and not isNil(var_49_0) then
				local var_49_3 = (arg_46_1.time_ - var_49_1) / var_49_2

				if arg_46_1.var_.actorSpriteComps10113 then
					for iter_49_0, iter_49_1 in pairs(arg_46_1.var_.actorSpriteComps10113:ToTable()) do
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

			if arg_46_1.time_ >= var_49_1 + var_49_2 and arg_46_1.time_ < var_49_1 + var_49_2 + arg_49_0 and not isNil(var_49_0) and arg_46_1.var_.actorSpriteComps10113 then
				for iter_49_2, iter_49_3 in pairs(arg_46_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_49_3 then
						if arg_46_1.isInRecall_ then
							iter_49_3.color = arg_46_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_49_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_46_1.var_.actorSpriteComps10113 = nil
			end

			local var_49_8 = arg_46_1.actors_["10128"]
			local var_49_9 = 0

			if var_49_9 < arg_46_1.time_ and arg_46_1.time_ <= var_49_9 + arg_49_0 and not isNil(var_49_8) and arg_46_1.var_.actorSpriteComps10128 == nil then
				arg_46_1.var_.actorSpriteComps10128 = var_49_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_49_10 = 0.2

			if var_49_9 <= arg_46_1.time_ and arg_46_1.time_ < var_49_9 + var_49_10 and not isNil(var_49_8) then
				local var_49_11 = (arg_46_1.time_ - var_49_9) / var_49_10

				if arg_46_1.var_.actorSpriteComps10128 then
					for iter_49_4, iter_49_5 in pairs(arg_46_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_49_5 then
							if arg_46_1.isInRecall_ then
								local var_49_12 = Mathf.Lerp(iter_49_5.color.r, arg_46_1.hightColor2.r, var_49_11)
								local var_49_13 = Mathf.Lerp(iter_49_5.color.g, arg_46_1.hightColor2.g, var_49_11)
								local var_49_14 = Mathf.Lerp(iter_49_5.color.b, arg_46_1.hightColor2.b, var_49_11)

								iter_49_5.color = Color.New(var_49_12, var_49_13, var_49_14)
							else
								local var_49_15 = Mathf.Lerp(iter_49_5.color.r, 0.5, var_49_11)

								iter_49_5.color = Color.New(var_49_15, var_49_15, var_49_15)
							end
						end
					end
				end
			end

			if arg_46_1.time_ >= var_49_9 + var_49_10 and arg_46_1.time_ < var_49_9 + var_49_10 + arg_49_0 and not isNil(var_49_8) and arg_46_1.var_.actorSpriteComps10128 then
				for iter_49_6, iter_49_7 in pairs(arg_46_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_49_7 then
						if arg_46_1.isInRecall_ then
							iter_49_7.color = arg_46_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_49_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_46_1.var_.actorSpriteComps10128 = nil
			end

			local var_49_16 = 0
			local var_49_17 = 0.775

			if var_49_16 < arg_46_1.time_ and arg_46_1.time_ <= var_49_16 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0
				arg_46_1.dialogCg_.alpha = 1

				arg_46_1.dialog_:SetActive(true)
				SetActive(arg_46_1.leftNameGo_, true)

				local var_49_18 = arg_46_1:FormatText(StoryNameCfg[1117].name)

				arg_46_1.leftNameTxt_.text = var_49_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_46_1.leftNameTxt_.transform)

				arg_46_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_46_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_46_1:RecordName(arg_46_1.leftNameTxt_.text)
				SetActive(arg_46_1.iconTrs_.gameObject, false)
				arg_46_1.callingController_:SetSelectedState("normal")

				local var_49_19 = arg_46_1:GetWordFromCfg(417212011)
				local var_49_20 = arg_46_1:FormatText(var_49_19.content)

				arg_46_1.text_.text = var_49_20

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_21 = 31
				local var_49_22 = utf8.len(var_49_20)
				local var_49_23 = var_49_21 <= 0 and var_49_17 or var_49_17 * (var_49_22 / var_49_21)

				if var_49_23 > 0 and var_49_17 < var_49_23 then
					arg_46_1.talkMaxDuration = var_49_23

					if var_49_23 + var_49_16 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_23 + var_49_16
					end
				end

				arg_46_1.text_.text = var_49_20
				arg_46_1.typewritter.percent = 0

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417212", "417212011", "story_v_out_417212.awb") ~= 0 then
					local var_49_24 = manager.audio:GetVoiceLength("story_v_out_417212", "417212011", "story_v_out_417212.awb") / 1000

					if var_49_24 + var_49_16 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_24 + var_49_16
					end

					if var_49_19.prefab_name ~= "" and arg_46_1.actors_[var_49_19.prefab_name] ~= nil then
						local var_49_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_46_1.actors_[var_49_19.prefab_name].transform, "story_v_out_417212", "417212011", "story_v_out_417212.awb")

						arg_46_1:RecordAudio("417212011", var_49_25)
						arg_46_1:RecordAudio("417212011", var_49_25)
					else
						arg_46_1:AudioAction("play", "voice", "story_v_out_417212", "417212011", "story_v_out_417212.awb")
					end

					arg_46_1:RecordHistoryTalkVoice("story_v_out_417212", "417212011", "story_v_out_417212.awb")
				end

				arg_46_1:RecordContent(arg_46_1.text_.text)
			end

			local var_49_26 = math.max(var_49_17, arg_46_1.talkMaxDuration)

			if var_49_16 <= arg_46_1.time_ and arg_46_1.time_ < var_49_16 + var_49_26 then
				arg_46_1.typewritter.percent = (arg_46_1.time_ - var_49_16) / var_49_26

				arg_46_1.typewritter:SetDirty()
			end

			if arg_46_1.time_ >= var_49_16 + var_49_26 and arg_46_1.time_ < var_49_16 + var_49_26 + arg_49_0 then
				arg_46_1.typewritter.percent = 1

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(true)
			end
		end

		arg_46_1.nodeConfigList_ = {}

		arg_46_1:InitPlayNodeList()
	end,
	Play417212012 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 417212012
		arg_50_1.duration_ = 9.13

		local var_50_0 = {
			zh = 9.133,
			ja = 8.366
		}
		local var_50_1 = manager.audio:GetLocalizationFlag()

		if var_50_0[var_50_1] ~= nil then
			arg_50_1.duration_ = var_50_0[var_50_1]
		end

		SetActive(arg_50_1.tipsGo_, false)

		function arg_50_1.onSingleLineFinish_()
			arg_50_1.onSingleLineUpdate_ = nil
			arg_50_1.onSingleLineFinish_ = nil
			arg_50_1.state_ = "waiting"
		end

		function arg_50_1.playNext_(arg_52_0)
			if arg_52_0 == 1 then
				arg_50_0:Play417212013(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			local var_53_0 = 0
			local var_53_1 = 0.975

			if var_53_0 < arg_50_1.time_ and arg_50_1.time_ <= var_53_0 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, true)

				local var_53_2 = arg_50_1:FormatText(StoryNameCfg[1117].name)

				arg_50_1.leftNameTxt_.text = var_53_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_50_1.leftNameTxt_.transform)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1.leftNameTxt_.text)
				SetActive(arg_50_1.iconTrs_.gameObject, false)
				arg_50_1.callingController_:SetSelectedState("normal")

				local var_53_3 = arg_50_1:GetWordFromCfg(417212012)
				local var_53_4 = arg_50_1:FormatText(var_53_3.content)

				arg_50_1.text_.text = var_53_4

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_5 = 39
				local var_53_6 = utf8.len(var_53_4)
				local var_53_7 = var_53_5 <= 0 and var_53_1 or var_53_1 * (var_53_6 / var_53_5)

				if var_53_7 > 0 and var_53_1 < var_53_7 then
					arg_50_1.talkMaxDuration = var_53_7

					if var_53_7 + var_53_0 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_7 + var_53_0
					end
				end

				arg_50_1.text_.text = var_53_4
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417212", "417212012", "story_v_out_417212.awb") ~= 0 then
					local var_53_8 = manager.audio:GetVoiceLength("story_v_out_417212", "417212012", "story_v_out_417212.awb") / 1000

					if var_53_8 + var_53_0 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_8 + var_53_0
					end

					if var_53_3.prefab_name ~= "" and arg_50_1.actors_[var_53_3.prefab_name] ~= nil then
						local var_53_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_50_1.actors_[var_53_3.prefab_name].transform, "story_v_out_417212", "417212012", "story_v_out_417212.awb")

						arg_50_1:RecordAudio("417212012", var_53_9)
						arg_50_1:RecordAudio("417212012", var_53_9)
					else
						arg_50_1:AudioAction("play", "voice", "story_v_out_417212", "417212012", "story_v_out_417212.awb")
					end

					arg_50_1:RecordHistoryTalkVoice("story_v_out_417212", "417212012", "story_v_out_417212.awb")
				end

				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_10 = math.max(var_53_1, arg_50_1.talkMaxDuration)

			if var_53_0 <= arg_50_1.time_ and arg_50_1.time_ < var_53_0 + var_53_10 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - var_53_0) / var_53_10

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= var_53_0 + var_53_10 and arg_50_1.time_ < var_53_0 + var_53_10 + arg_53_0 then
				arg_50_1.typewritter.percent = 1

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(true)
			end
		end

		arg_50_1.nodeConfigList_ = {}

		arg_50_1:InitPlayNodeList()
	end,
	Play417212013 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 417212013
		arg_54_1.duration_ = 9.83

		local var_54_0 = {
			zh = 8.2,
			ja = 9.833
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
				arg_54_0:Play417212014(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			local var_57_0 = arg_54_1.actors_["10113"].transform
			local var_57_1 = 0

			if var_57_1 < arg_54_1.time_ and arg_54_1.time_ <= var_57_1 + arg_57_0 then
				arg_54_1.var_.moveOldPos10113 = var_57_0.localPosition
				var_57_0.localScale = Vector3.New(1, 1, 1)

				arg_54_1:CheckSpriteTmpPos("10113", 2)

				local var_57_2 = var_57_0.childCount

				for iter_57_0 = 0, var_57_2 - 1 do
					local var_57_3 = var_57_0:GetChild(iter_57_0)

					if var_57_3.name == "split_3" or not string.find(var_57_3.name, "split") then
						var_57_3.gameObject:SetActive(true)
					else
						var_57_3.gameObject:SetActive(false)
					end
				end
			end

			local var_57_4 = 0.001

			if var_57_1 <= arg_54_1.time_ and arg_54_1.time_ < var_57_1 + var_57_4 then
				local var_57_5 = (arg_54_1.time_ - var_57_1) / var_57_4
				local var_57_6 = Vector3.New(-403.26, -328.4, -517.4)

				var_57_0.localPosition = Vector3.Lerp(arg_54_1.var_.moveOldPos10113, var_57_6, var_57_5)
			end

			if arg_54_1.time_ >= var_57_1 + var_57_4 and arg_54_1.time_ < var_57_1 + var_57_4 + arg_57_0 then
				var_57_0.localPosition = Vector3.New(-403.26, -328.4, -517.4)
			end

			local var_57_7 = 0
			local var_57_8 = 0.825

			if var_57_7 < arg_54_1.time_ and arg_54_1.time_ <= var_57_7 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, true)

				local var_57_9 = arg_54_1:FormatText(StoryNameCfg[1117].name)

				arg_54_1.leftNameTxt_.text = var_57_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_54_1.leftNameTxt_.transform)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1.leftNameTxt_.text)
				SetActive(arg_54_1.iconTrs_.gameObject, false)
				arg_54_1.callingController_:SetSelectedState("normal")

				local var_57_10 = arg_54_1:GetWordFromCfg(417212013)
				local var_57_11 = arg_54_1:FormatText(var_57_10.content)

				arg_54_1.text_.text = var_57_11

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_12 = 33
				local var_57_13 = utf8.len(var_57_11)
				local var_57_14 = var_57_12 <= 0 and var_57_8 or var_57_8 * (var_57_13 / var_57_12)

				if var_57_14 > 0 and var_57_8 < var_57_14 then
					arg_54_1.talkMaxDuration = var_57_14

					if var_57_14 + var_57_7 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_14 + var_57_7
					end
				end

				arg_54_1.text_.text = var_57_11
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417212", "417212013", "story_v_out_417212.awb") ~= 0 then
					local var_57_15 = manager.audio:GetVoiceLength("story_v_out_417212", "417212013", "story_v_out_417212.awb") / 1000

					if var_57_15 + var_57_7 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_15 + var_57_7
					end

					if var_57_10.prefab_name ~= "" and arg_54_1.actors_[var_57_10.prefab_name] ~= nil then
						local var_57_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_54_1.actors_[var_57_10.prefab_name].transform, "story_v_out_417212", "417212013", "story_v_out_417212.awb")

						arg_54_1:RecordAudio("417212013", var_57_16)
						arg_54_1:RecordAudio("417212013", var_57_16)
					else
						arg_54_1:AudioAction("play", "voice", "story_v_out_417212", "417212013", "story_v_out_417212.awb")
					end

					arg_54_1:RecordHistoryTalkVoice("story_v_out_417212", "417212013", "story_v_out_417212.awb")
				end

				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_17 = math.max(var_57_8, arg_54_1.talkMaxDuration)

			if var_57_7 <= arg_54_1.time_ and arg_54_1.time_ < var_57_7 + var_57_17 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - var_57_7) / var_57_17

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= var_57_7 + var_57_17 and arg_54_1.time_ < var_57_7 + var_57_17 + arg_57_0 then
				arg_54_1.typewritter.percent = 1

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(true)
			end
		end

		arg_54_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10113",
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
	Play417212014 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 417212014
		arg_58_1.duration_ = 6.3

		local var_58_0 = {
			zh = 4.8,
			ja = 6.3
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
				arg_58_0:Play417212015(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			local var_61_0 = arg_58_1.actors_["10128"]
			local var_61_1 = 0

			if var_61_1 < arg_58_1.time_ and arg_58_1.time_ <= var_61_1 + arg_61_0 and not isNil(var_61_0) and arg_58_1.var_.actorSpriteComps10128 == nil then
				arg_58_1.var_.actorSpriteComps10128 = var_61_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_61_2 = 0.2

			if var_61_1 <= arg_58_1.time_ and arg_58_1.time_ < var_61_1 + var_61_2 and not isNil(var_61_0) then
				local var_61_3 = (arg_58_1.time_ - var_61_1) / var_61_2

				if arg_58_1.var_.actorSpriteComps10128 then
					for iter_61_0, iter_61_1 in pairs(arg_58_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_61_1 then
							if arg_58_1.isInRecall_ then
								local var_61_4 = Mathf.Lerp(iter_61_1.color.r, arg_58_1.hightColor1.r, var_61_3)
								local var_61_5 = Mathf.Lerp(iter_61_1.color.g, arg_58_1.hightColor1.g, var_61_3)
								local var_61_6 = Mathf.Lerp(iter_61_1.color.b, arg_58_1.hightColor1.b, var_61_3)

								iter_61_1.color = Color.New(var_61_4, var_61_5, var_61_6)
							else
								local var_61_7 = Mathf.Lerp(iter_61_1.color.r, 1, var_61_3)

								iter_61_1.color = Color.New(var_61_7, var_61_7, var_61_7)
							end
						end
					end
				end
			end

			if arg_58_1.time_ >= var_61_1 + var_61_2 and arg_58_1.time_ < var_61_1 + var_61_2 + arg_61_0 and not isNil(var_61_0) and arg_58_1.var_.actorSpriteComps10128 then
				for iter_61_2, iter_61_3 in pairs(arg_58_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_61_3 then
						if arg_58_1.isInRecall_ then
							iter_61_3.color = arg_58_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_61_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_58_1.var_.actorSpriteComps10128 = nil
			end

			local var_61_8 = arg_58_1.actors_["10113"]
			local var_61_9 = 0

			if var_61_9 < arg_58_1.time_ and arg_58_1.time_ <= var_61_9 + arg_61_0 and not isNil(var_61_8) and arg_58_1.var_.actorSpriteComps10113 == nil then
				arg_58_1.var_.actorSpriteComps10113 = var_61_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_61_10 = 0.2

			if var_61_9 <= arg_58_1.time_ and arg_58_1.time_ < var_61_9 + var_61_10 and not isNil(var_61_8) then
				local var_61_11 = (arg_58_1.time_ - var_61_9) / var_61_10

				if arg_58_1.var_.actorSpriteComps10113 then
					for iter_61_4, iter_61_5 in pairs(arg_58_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_61_5 then
							if arg_58_1.isInRecall_ then
								local var_61_12 = Mathf.Lerp(iter_61_5.color.r, arg_58_1.hightColor2.r, var_61_11)
								local var_61_13 = Mathf.Lerp(iter_61_5.color.g, arg_58_1.hightColor2.g, var_61_11)
								local var_61_14 = Mathf.Lerp(iter_61_5.color.b, arg_58_1.hightColor2.b, var_61_11)

								iter_61_5.color = Color.New(var_61_12, var_61_13, var_61_14)
							else
								local var_61_15 = Mathf.Lerp(iter_61_5.color.r, 0.5, var_61_11)

								iter_61_5.color = Color.New(var_61_15, var_61_15, var_61_15)
							end
						end
					end
				end
			end

			if arg_58_1.time_ >= var_61_9 + var_61_10 and arg_58_1.time_ < var_61_9 + var_61_10 + arg_61_0 and not isNil(var_61_8) and arg_58_1.var_.actorSpriteComps10113 then
				for iter_61_6, iter_61_7 in pairs(arg_58_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_61_7 then
						if arg_58_1.isInRecall_ then
							iter_61_7.color = arg_58_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_61_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_58_1.var_.actorSpriteComps10113 = nil
			end

			local var_61_16 = 0
			local var_61_17 = 0.525

			if var_61_16 < arg_58_1.time_ and arg_58_1.time_ <= var_61_16 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, true)

				local var_61_18 = arg_58_1:FormatText(StoryNameCfg[595].name)

				arg_58_1.leftNameTxt_.text = var_61_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, false)
				arg_58_1.callingController_:SetSelectedState("normal")

				local var_61_19 = arg_58_1:GetWordFromCfg(417212014)
				local var_61_20 = arg_58_1:FormatText(var_61_19.content)

				arg_58_1.text_.text = var_61_20

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_21 = 21
				local var_61_22 = utf8.len(var_61_20)
				local var_61_23 = var_61_21 <= 0 and var_61_17 or var_61_17 * (var_61_22 / var_61_21)

				if var_61_23 > 0 and var_61_17 < var_61_23 then
					arg_58_1.talkMaxDuration = var_61_23

					if var_61_23 + var_61_16 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_23 + var_61_16
					end
				end

				arg_58_1.text_.text = var_61_20
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417212", "417212014", "story_v_out_417212.awb") ~= 0 then
					local var_61_24 = manager.audio:GetVoiceLength("story_v_out_417212", "417212014", "story_v_out_417212.awb") / 1000

					if var_61_24 + var_61_16 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_24 + var_61_16
					end

					if var_61_19.prefab_name ~= "" and arg_58_1.actors_[var_61_19.prefab_name] ~= nil then
						local var_61_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_58_1.actors_[var_61_19.prefab_name].transform, "story_v_out_417212", "417212014", "story_v_out_417212.awb")

						arg_58_1:RecordAudio("417212014", var_61_25)
						arg_58_1:RecordAudio("417212014", var_61_25)
					else
						arg_58_1:AudioAction("play", "voice", "story_v_out_417212", "417212014", "story_v_out_417212.awb")
					end

					arg_58_1:RecordHistoryTalkVoice("story_v_out_417212", "417212014", "story_v_out_417212.awb")
				end

				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_26 = math.max(var_61_17, arg_58_1.talkMaxDuration)

			if var_61_16 <= arg_58_1.time_ and arg_58_1.time_ < var_61_16 + var_61_26 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_16) / var_61_26

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_16 + var_61_26 and arg_58_1.time_ < var_61_16 + var_61_26 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {}

		arg_58_1:InitPlayNodeList()
	end,
	Play417212015 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 417212015
		arg_62_1.duration_ = 15.77

		local var_62_0 = {
			zh = 15.766,
			ja = 14.666
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
				arg_62_0:Play417212016(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			local var_65_0 = arg_62_1.actors_["10113"]
			local var_65_1 = 0

			if var_65_1 < arg_62_1.time_ and arg_62_1.time_ <= var_65_1 + arg_65_0 and not isNil(var_65_0) and arg_62_1.var_.actorSpriteComps10113 == nil then
				arg_62_1.var_.actorSpriteComps10113 = var_65_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_65_2 = 0.2

			if var_65_1 <= arg_62_1.time_ and arg_62_1.time_ < var_65_1 + var_65_2 and not isNil(var_65_0) then
				local var_65_3 = (arg_62_1.time_ - var_65_1) / var_65_2

				if arg_62_1.var_.actorSpriteComps10113 then
					for iter_65_0, iter_65_1 in pairs(arg_62_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_65_1 then
							if arg_62_1.isInRecall_ then
								local var_65_4 = Mathf.Lerp(iter_65_1.color.r, arg_62_1.hightColor1.r, var_65_3)
								local var_65_5 = Mathf.Lerp(iter_65_1.color.g, arg_62_1.hightColor1.g, var_65_3)
								local var_65_6 = Mathf.Lerp(iter_65_1.color.b, arg_62_1.hightColor1.b, var_65_3)

								iter_65_1.color = Color.New(var_65_4, var_65_5, var_65_6)
							else
								local var_65_7 = Mathf.Lerp(iter_65_1.color.r, 1, var_65_3)

								iter_65_1.color = Color.New(var_65_7, var_65_7, var_65_7)
							end
						end
					end
				end
			end

			if arg_62_1.time_ >= var_65_1 + var_65_2 and arg_62_1.time_ < var_65_1 + var_65_2 + arg_65_0 and not isNil(var_65_0) and arg_62_1.var_.actorSpriteComps10113 then
				for iter_65_2, iter_65_3 in pairs(arg_62_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_65_3 then
						if arg_62_1.isInRecall_ then
							iter_65_3.color = arg_62_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_65_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_62_1.var_.actorSpriteComps10113 = nil
			end

			local var_65_8 = arg_62_1.actors_["10128"]
			local var_65_9 = 0

			if var_65_9 < arg_62_1.time_ and arg_62_1.time_ <= var_65_9 + arg_65_0 and not isNil(var_65_8) and arg_62_1.var_.actorSpriteComps10128 == nil then
				arg_62_1.var_.actorSpriteComps10128 = var_65_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_65_10 = 0.2

			if var_65_9 <= arg_62_1.time_ and arg_62_1.time_ < var_65_9 + var_65_10 and not isNil(var_65_8) then
				local var_65_11 = (arg_62_1.time_ - var_65_9) / var_65_10

				if arg_62_1.var_.actorSpriteComps10128 then
					for iter_65_4, iter_65_5 in pairs(arg_62_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_65_5 then
							if arg_62_1.isInRecall_ then
								local var_65_12 = Mathf.Lerp(iter_65_5.color.r, arg_62_1.hightColor2.r, var_65_11)
								local var_65_13 = Mathf.Lerp(iter_65_5.color.g, arg_62_1.hightColor2.g, var_65_11)
								local var_65_14 = Mathf.Lerp(iter_65_5.color.b, arg_62_1.hightColor2.b, var_65_11)

								iter_65_5.color = Color.New(var_65_12, var_65_13, var_65_14)
							else
								local var_65_15 = Mathf.Lerp(iter_65_5.color.r, 0.5, var_65_11)

								iter_65_5.color = Color.New(var_65_15, var_65_15, var_65_15)
							end
						end
					end
				end
			end

			if arg_62_1.time_ >= var_65_9 + var_65_10 and arg_62_1.time_ < var_65_9 + var_65_10 + arg_65_0 and not isNil(var_65_8) and arg_62_1.var_.actorSpriteComps10128 then
				for iter_65_6, iter_65_7 in pairs(arg_62_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_65_7 then
						if arg_62_1.isInRecall_ then
							iter_65_7.color = arg_62_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_65_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_62_1.var_.actorSpriteComps10128 = nil
			end

			local var_65_16 = arg_62_1.actors_["10113"].transform
			local var_65_17 = 0

			if var_65_17 < arg_62_1.time_ and arg_62_1.time_ <= var_65_17 + arg_65_0 then
				arg_62_1.var_.moveOldPos10113 = var_65_16.localPosition
				var_65_16.localScale = Vector3.New(1, 1, 1)

				arg_62_1:CheckSpriteTmpPos("10113", 2)

				local var_65_18 = var_65_16.childCount

				for iter_65_8 = 0, var_65_18 - 1 do
					local var_65_19 = var_65_16:GetChild(iter_65_8)

					if var_65_19.name == "split_1" or not string.find(var_65_19.name, "split") then
						var_65_19.gameObject:SetActive(true)
					else
						var_65_19.gameObject:SetActive(false)
					end
				end
			end

			local var_65_20 = 0.001

			if var_65_17 <= arg_62_1.time_ and arg_62_1.time_ < var_65_17 + var_65_20 then
				local var_65_21 = (arg_62_1.time_ - var_65_17) / var_65_20
				local var_65_22 = Vector3.New(-403.26, -328.4, -517.4)

				var_65_16.localPosition = Vector3.Lerp(arg_62_1.var_.moveOldPos10113, var_65_22, var_65_21)
			end

			if arg_62_1.time_ >= var_65_17 + var_65_20 and arg_62_1.time_ < var_65_17 + var_65_20 + arg_65_0 then
				var_65_16.localPosition = Vector3.New(-403.26, -328.4, -517.4)
			end

			local var_65_23 = 0
			local var_65_24 = 1.6

			if var_65_23 < arg_62_1.time_ and arg_62_1.time_ <= var_65_23 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, true)

				local var_65_25 = arg_62_1:FormatText(StoryNameCfg[1117].name)

				arg_62_1.leftNameTxt_.text = var_65_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_62_1.leftNameTxt_.transform)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1.leftNameTxt_.text)
				SetActive(arg_62_1.iconTrs_.gameObject, false)
				arg_62_1.callingController_:SetSelectedState("normal")

				local var_65_26 = arg_62_1:GetWordFromCfg(417212015)
				local var_65_27 = arg_62_1:FormatText(var_65_26.content)

				arg_62_1.text_.text = var_65_27

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_28 = 64
				local var_65_29 = utf8.len(var_65_27)
				local var_65_30 = var_65_28 <= 0 and var_65_24 or var_65_24 * (var_65_29 / var_65_28)

				if var_65_30 > 0 and var_65_24 < var_65_30 then
					arg_62_1.talkMaxDuration = var_65_30

					if var_65_30 + var_65_23 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_30 + var_65_23
					end
				end

				arg_62_1.text_.text = var_65_27
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417212", "417212015", "story_v_out_417212.awb") ~= 0 then
					local var_65_31 = manager.audio:GetVoiceLength("story_v_out_417212", "417212015", "story_v_out_417212.awb") / 1000

					if var_65_31 + var_65_23 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_31 + var_65_23
					end

					if var_65_26.prefab_name ~= "" and arg_62_1.actors_[var_65_26.prefab_name] ~= nil then
						local var_65_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_62_1.actors_[var_65_26.prefab_name].transform, "story_v_out_417212", "417212015", "story_v_out_417212.awb")

						arg_62_1:RecordAudio("417212015", var_65_32)
						arg_62_1:RecordAudio("417212015", var_65_32)
					else
						arg_62_1:AudioAction("play", "voice", "story_v_out_417212", "417212015", "story_v_out_417212.awb")
					end

					arg_62_1:RecordHistoryTalkVoice("story_v_out_417212", "417212015", "story_v_out_417212.awb")
				end

				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_33 = math.max(var_65_24, arg_62_1.talkMaxDuration)

			if var_65_23 <= arg_62_1.time_ and arg_62_1.time_ < var_65_23 + var_65_33 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - var_65_23) / var_65_33

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= var_65_23 + var_65_33 and arg_62_1.time_ < var_65_23 + var_65_33 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10113",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_62_1:InitPlayNodeList()
	end,
	Play417212016 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 417212016
		arg_66_1.duration_ = 8.93

		local var_66_0 = {
			zh = 6.566,
			ja = 8.933
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
				arg_66_0:Play417212017(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			local var_69_0 = 0
			local var_69_1 = 0.7

			if var_69_0 < arg_66_1.time_ and arg_66_1.time_ <= var_69_0 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				local var_69_2 = arg_66_1:FormatText(StoryNameCfg[1117].name)

				arg_66_1.leftNameTxt_.text = var_69_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_3 = arg_66_1:GetWordFromCfg(417212016)
				local var_69_4 = arg_66_1:FormatText(var_69_3.content)

				arg_66_1.text_.text = var_69_4

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_5 = 28
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

				if manager.audio:GetVoiceLength("story_v_out_417212", "417212016", "story_v_out_417212.awb") ~= 0 then
					local var_69_8 = manager.audio:GetVoiceLength("story_v_out_417212", "417212016", "story_v_out_417212.awb") / 1000

					if var_69_8 + var_69_0 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_8 + var_69_0
					end

					if var_69_3.prefab_name ~= "" and arg_66_1.actors_[var_69_3.prefab_name] ~= nil then
						local var_69_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_66_1.actors_[var_69_3.prefab_name].transform, "story_v_out_417212", "417212016", "story_v_out_417212.awb")

						arg_66_1:RecordAudio("417212016", var_69_9)
						arg_66_1:RecordAudio("417212016", var_69_9)
					else
						arg_66_1:AudioAction("play", "voice", "story_v_out_417212", "417212016", "story_v_out_417212.awb")
					end

					arg_66_1:RecordHistoryTalkVoice("story_v_out_417212", "417212016", "story_v_out_417212.awb")
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
	Play417212017 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 417212017
		arg_70_1.duration_ = 7.27

		local var_70_0 = {
			zh = 6.3,
			ja = 7.266
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
				arg_70_0:Play417212018(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			local var_73_0 = arg_70_1.actors_["10128"]
			local var_73_1 = 0

			if var_73_1 < arg_70_1.time_ and arg_70_1.time_ <= var_73_1 + arg_73_0 and not isNil(var_73_0) and arg_70_1.var_.actorSpriteComps10128 == nil then
				arg_70_1.var_.actorSpriteComps10128 = var_73_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_73_2 = 0.2

			if var_73_1 <= arg_70_1.time_ and arg_70_1.time_ < var_73_1 + var_73_2 and not isNil(var_73_0) then
				local var_73_3 = (arg_70_1.time_ - var_73_1) / var_73_2

				if arg_70_1.var_.actorSpriteComps10128 then
					for iter_73_0, iter_73_1 in pairs(arg_70_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_73_1 then
							if arg_70_1.isInRecall_ then
								local var_73_4 = Mathf.Lerp(iter_73_1.color.r, arg_70_1.hightColor1.r, var_73_3)
								local var_73_5 = Mathf.Lerp(iter_73_1.color.g, arg_70_1.hightColor1.g, var_73_3)
								local var_73_6 = Mathf.Lerp(iter_73_1.color.b, arg_70_1.hightColor1.b, var_73_3)

								iter_73_1.color = Color.New(var_73_4, var_73_5, var_73_6)
							else
								local var_73_7 = Mathf.Lerp(iter_73_1.color.r, 1, var_73_3)

								iter_73_1.color = Color.New(var_73_7, var_73_7, var_73_7)
							end
						end
					end
				end
			end

			if arg_70_1.time_ >= var_73_1 + var_73_2 and arg_70_1.time_ < var_73_1 + var_73_2 + arg_73_0 and not isNil(var_73_0) and arg_70_1.var_.actorSpriteComps10128 then
				for iter_73_2, iter_73_3 in pairs(arg_70_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_73_3 then
						if arg_70_1.isInRecall_ then
							iter_73_3.color = arg_70_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_73_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_70_1.var_.actorSpriteComps10128 = nil
			end

			local var_73_8 = arg_70_1.actors_["10113"]
			local var_73_9 = 0

			if var_73_9 < arg_70_1.time_ and arg_70_1.time_ <= var_73_9 + arg_73_0 and not isNil(var_73_8) and arg_70_1.var_.actorSpriteComps10113 == nil then
				arg_70_1.var_.actorSpriteComps10113 = var_73_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_73_10 = 0.2

			if var_73_9 <= arg_70_1.time_ and arg_70_1.time_ < var_73_9 + var_73_10 and not isNil(var_73_8) then
				local var_73_11 = (arg_70_1.time_ - var_73_9) / var_73_10

				if arg_70_1.var_.actorSpriteComps10113 then
					for iter_73_4, iter_73_5 in pairs(arg_70_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_73_5 then
							if arg_70_1.isInRecall_ then
								local var_73_12 = Mathf.Lerp(iter_73_5.color.r, arg_70_1.hightColor2.r, var_73_11)
								local var_73_13 = Mathf.Lerp(iter_73_5.color.g, arg_70_1.hightColor2.g, var_73_11)
								local var_73_14 = Mathf.Lerp(iter_73_5.color.b, arg_70_1.hightColor2.b, var_73_11)

								iter_73_5.color = Color.New(var_73_12, var_73_13, var_73_14)
							else
								local var_73_15 = Mathf.Lerp(iter_73_5.color.r, 0.5, var_73_11)

								iter_73_5.color = Color.New(var_73_15, var_73_15, var_73_15)
							end
						end
					end
				end
			end

			if arg_70_1.time_ >= var_73_9 + var_73_10 and arg_70_1.time_ < var_73_9 + var_73_10 + arg_73_0 and not isNil(var_73_8) and arg_70_1.var_.actorSpriteComps10113 then
				for iter_73_6, iter_73_7 in pairs(arg_70_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_73_7 then
						if arg_70_1.isInRecall_ then
							iter_73_7.color = arg_70_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_73_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_70_1.var_.actorSpriteComps10113 = nil
			end

			local var_73_16 = 0
			local var_73_17 = 0.625

			if var_73_16 < arg_70_1.time_ and arg_70_1.time_ <= var_73_16 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, true)

				local var_73_18 = arg_70_1:FormatText(StoryNameCfg[595].name)

				arg_70_1.leftNameTxt_.text = var_73_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_70_1.leftNameTxt_.transform)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1.leftNameTxt_.text)
				SetActive(arg_70_1.iconTrs_.gameObject, false)
				arg_70_1.callingController_:SetSelectedState("normal")

				local var_73_19 = arg_70_1:GetWordFromCfg(417212017)
				local var_73_20 = arg_70_1:FormatText(var_73_19.content)

				arg_70_1.text_.text = var_73_20

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_21 = 25
				local var_73_22 = utf8.len(var_73_20)
				local var_73_23 = var_73_21 <= 0 and var_73_17 or var_73_17 * (var_73_22 / var_73_21)

				if var_73_23 > 0 and var_73_17 < var_73_23 then
					arg_70_1.talkMaxDuration = var_73_23

					if var_73_23 + var_73_16 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_23 + var_73_16
					end
				end

				arg_70_1.text_.text = var_73_20
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417212", "417212017", "story_v_out_417212.awb") ~= 0 then
					local var_73_24 = manager.audio:GetVoiceLength("story_v_out_417212", "417212017", "story_v_out_417212.awb") / 1000

					if var_73_24 + var_73_16 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_24 + var_73_16
					end

					if var_73_19.prefab_name ~= "" and arg_70_1.actors_[var_73_19.prefab_name] ~= nil then
						local var_73_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_70_1.actors_[var_73_19.prefab_name].transform, "story_v_out_417212", "417212017", "story_v_out_417212.awb")

						arg_70_1:RecordAudio("417212017", var_73_25)
						arg_70_1:RecordAudio("417212017", var_73_25)
					else
						arg_70_1:AudioAction("play", "voice", "story_v_out_417212", "417212017", "story_v_out_417212.awb")
					end

					arg_70_1:RecordHistoryTalkVoice("story_v_out_417212", "417212017", "story_v_out_417212.awb")
				end

				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_26 = math.max(var_73_17, arg_70_1.talkMaxDuration)

			if var_73_16 <= arg_70_1.time_ and arg_70_1.time_ < var_73_16 + var_73_26 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_16) / var_73_26

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_16 + var_73_26 and arg_70_1.time_ < var_73_16 + var_73_26 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {}

		arg_70_1:InitPlayNodeList()
	end,
	Play417212018 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 417212018
		arg_74_1.duration_ = 13.6

		local var_74_0 = {
			zh = 6.233,
			ja = 13.6
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
				arg_74_0:Play417212019(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			local var_77_0 = arg_74_1.actors_["10113"]
			local var_77_1 = 0

			if var_77_1 < arg_74_1.time_ and arg_74_1.time_ <= var_77_1 + arg_77_0 and not isNil(var_77_0) and arg_74_1.var_.actorSpriteComps10113 == nil then
				arg_74_1.var_.actorSpriteComps10113 = var_77_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_77_2 = 0.2

			if var_77_1 <= arg_74_1.time_ and arg_74_1.time_ < var_77_1 + var_77_2 and not isNil(var_77_0) then
				local var_77_3 = (arg_74_1.time_ - var_77_1) / var_77_2

				if arg_74_1.var_.actorSpriteComps10113 then
					for iter_77_0, iter_77_1 in pairs(arg_74_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_77_1 then
							if arg_74_1.isInRecall_ then
								local var_77_4 = Mathf.Lerp(iter_77_1.color.r, arg_74_1.hightColor1.r, var_77_3)
								local var_77_5 = Mathf.Lerp(iter_77_1.color.g, arg_74_1.hightColor1.g, var_77_3)
								local var_77_6 = Mathf.Lerp(iter_77_1.color.b, arg_74_1.hightColor1.b, var_77_3)

								iter_77_1.color = Color.New(var_77_4, var_77_5, var_77_6)
							else
								local var_77_7 = Mathf.Lerp(iter_77_1.color.r, 1, var_77_3)

								iter_77_1.color = Color.New(var_77_7, var_77_7, var_77_7)
							end
						end
					end
				end
			end

			if arg_74_1.time_ >= var_77_1 + var_77_2 and arg_74_1.time_ < var_77_1 + var_77_2 + arg_77_0 and not isNil(var_77_0) and arg_74_1.var_.actorSpriteComps10113 then
				for iter_77_2, iter_77_3 in pairs(arg_74_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_77_3 then
						if arg_74_1.isInRecall_ then
							iter_77_3.color = arg_74_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_77_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_74_1.var_.actorSpriteComps10113 = nil
			end

			local var_77_8 = arg_74_1.actors_["10128"]
			local var_77_9 = 0

			if var_77_9 < arg_74_1.time_ and arg_74_1.time_ <= var_77_9 + arg_77_0 and not isNil(var_77_8) and arg_74_1.var_.actorSpriteComps10128 == nil then
				arg_74_1.var_.actorSpriteComps10128 = var_77_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_77_10 = 0.2

			if var_77_9 <= arg_74_1.time_ and arg_74_1.time_ < var_77_9 + var_77_10 and not isNil(var_77_8) then
				local var_77_11 = (arg_74_1.time_ - var_77_9) / var_77_10

				if arg_74_1.var_.actorSpriteComps10128 then
					for iter_77_4, iter_77_5 in pairs(arg_74_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_77_5 then
							if arg_74_1.isInRecall_ then
								local var_77_12 = Mathf.Lerp(iter_77_5.color.r, arg_74_1.hightColor2.r, var_77_11)
								local var_77_13 = Mathf.Lerp(iter_77_5.color.g, arg_74_1.hightColor2.g, var_77_11)
								local var_77_14 = Mathf.Lerp(iter_77_5.color.b, arg_74_1.hightColor2.b, var_77_11)

								iter_77_5.color = Color.New(var_77_12, var_77_13, var_77_14)
							else
								local var_77_15 = Mathf.Lerp(iter_77_5.color.r, 0.5, var_77_11)

								iter_77_5.color = Color.New(var_77_15, var_77_15, var_77_15)
							end
						end
					end
				end
			end

			if arg_74_1.time_ >= var_77_9 + var_77_10 and arg_74_1.time_ < var_77_9 + var_77_10 + arg_77_0 and not isNil(var_77_8) and arg_74_1.var_.actorSpriteComps10128 then
				for iter_77_6, iter_77_7 in pairs(arg_74_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_77_7 then
						if arg_74_1.isInRecall_ then
							iter_77_7.color = arg_74_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_77_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_74_1.var_.actorSpriteComps10128 = nil
			end

			local var_77_16 = 0
			local var_77_17 = 0.675

			if var_77_16 < arg_74_1.time_ and arg_74_1.time_ <= var_77_16 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, true)

				local var_77_18 = arg_74_1:FormatText(StoryNameCfg[1117].name)

				arg_74_1.leftNameTxt_.text = var_77_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_74_1.leftNameTxt_.transform)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1.leftNameTxt_.text)
				SetActive(arg_74_1.iconTrs_.gameObject, false)
				arg_74_1.callingController_:SetSelectedState("normal")

				local var_77_19 = arg_74_1:GetWordFromCfg(417212018)
				local var_77_20 = arg_74_1:FormatText(var_77_19.content)

				arg_74_1.text_.text = var_77_20

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_21 = 27
				local var_77_22 = utf8.len(var_77_20)
				local var_77_23 = var_77_21 <= 0 and var_77_17 or var_77_17 * (var_77_22 / var_77_21)

				if var_77_23 > 0 and var_77_17 < var_77_23 then
					arg_74_1.talkMaxDuration = var_77_23

					if var_77_23 + var_77_16 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_23 + var_77_16
					end
				end

				arg_74_1.text_.text = var_77_20
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417212", "417212018", "story_v_out_417212.awb") ~= 0 then
					local var_77_24 = manager.audio:GetVoiceLength("story_v_out_417212", "417212018", "story_v_out_417212.awb") / 1000

					if var_77_24 + var_77_16 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_24 + var_77_16
					end

					if var_77_19.prefab_name ~= "" and arg_74_1.actors_[var_77_19.prefab_name] ~= nil then
						local var_77_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_74_1.actors_[var_77_19.prefab_name].transform, "story_v_out_417212", "417212018", "story_v_out_417212.awb")

						arg_74_1:RecordAudio("417212018", var_77_25)
						arg_74_1:RecordAudio("417212018", var_77_25)
					else
						arg_74_1:AudioAction("play", "voice", "story_v_out_417212", "417212018", "story_v_out_417212.awb")
					end

					arg_74_1:RecordHistoryTalkVoice("story_v_out_417212", "417212018", "story_v_out_417212.awb")
				end

				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_26 = math.max(var_77_17, arg_74_1.talkMaxDuration)

			if var_77_16 <= arg_74_1.time_ and arg_74_1.time_ < var_77_16 + var_77_26 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_16) / var_77_26

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_16 + var_77_26 and arg_74_1.time_ < var_77_16 + var_77_26 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {}

		arg_74_1:InitPlayNodeList()
	end,
	Play417212019 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 417212019
		arg_78_1.duration_ = 9.63

		local var_78_0 = {
			zh = 6.433,
			ja = 9.633
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
				arg_78_0:Play417212020(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			local var_81_0 = arg_78_1.actors_["10128"]
			local var_81_1 = 0

			if var_81_1 < arg_78_1.time_ and arg_78_1.time_ <= var_81_1 + arg_81_0 and not isNil(var_81_0) and arg_78_1.var_.actorSpriteComps10128 == nil then
				arg_78_1.var_.actorSpriteComps10128 = var_81_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_81_2 = 0.2

			if var_81_1 <= arg_78_1.time_ and arg_78_1.time_ < var_81_1 + var_81_2 and not isNil(var_81_0) then
				local var_81_3 = (arg_78_1.time_ - var_81_1) / var_81_2

				if arg_78_1.var_.actorSpriteComps10128 then
					for iter_81_0, iter_81_1 in pairs(arg_78_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_81_1 then
							if arg_78_1.isInRecall_ then
								local var_81_4 = Mathf.Lerp(iter_81_1.color.r, arg_78_1.hightColor1.r, var_81_3)
								local var_81_5 = Mathf.Lerp(iter_81_1.color.g, arg_78_1.hightColor1.g, var_81_3)
								local var_81_6 = Mathf.Lerp(iter_81_1.color.b, arg_78_1.hightColor1.b, var_81_3)

								iter_81_1.color = Color.New(var_81_4, var_81_5, var_81_6)
							else
								local var_81_7 = Mathf.Lerp(iter_81_1.color.r, 1, var_81_3)

								iter_81_1.color = Color.New(var_81_7, var_81_7, var_81_7)
							end
						end
					end
				end
			end

			if arg_78_1.time_ >= var_81_1 + var_81_2 and arg_78_1.time_ < var_81_1 + var_81_2 + arg_81_0 and not isNil(var_81_0) and arg_78_1.var_.actorSpriteComps10128 then
				for iter_81_2, iter_81_3 in pairs(arg_78_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_81_3 then
						if arg_78_1.isInRecall_ then
							iter_81_3.color = arg_78_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_81_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_78_1.var_.actorSpriteComps10128 = nil
			end

			local var_81_8 = arg_78_1.actors_["10113"]
			local var_81_9 = 0

			if var_81_9 < arg_78_1.time_ and arg_78_1.time_ <= var_81_9 + arg_81_0 and not isNil(var_81_8) and arg_78_1.var_.actorSpriteComps10113 == nil then
				arg_78_1.var_.actorSpriteComps10113 = var_81_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_81_10 = 0.2

			if var_81_9 <= arg_78_1.time_ and arg_78_1.time_ < var_81_9 + var_81_10 and not isNil(var_81_8) then
				local var_81_11 = (arg_78_1.time_ - var_81_9) / var_81_10

				if arg_78_1.var_.actorSpriteComps10113 then
					for iter_81_4, iter_81_5 in pairs(arg_78_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_81_5 then
							if arg_78_1.isInRecall_ then
								local var_81_12 = Mathf.Lerp(iter_81_5.color.r, arg_78_1.hightColor2.r, var_81_11)
								local var_81_13 = Mathf.Lerp(iter_81_5.color.g, arg_78_1.hightColor2.g, var_81_11)
								local var_81_14 = Mathf.Lerp(iter_81_5.color.b, arg_78_1.hightColor2.b, var_81_11)

								iter_81_5.color = Color.New(var_81_12, var_81_13, var_81_14)
							else
								local var_81_15 = Mathf.Lerp(iter_81_5.color.r, 0.5, var_81_11)

								iter_81_5.color = Color.New(var_81_15, var_81_15, var_81_15)
							end
						end
					end
				end
			end

			if arg_78_1.time_ >= var_81_9 + var_81_10 and arg_78_1.time_ < var_81_9 + var_81_10 + arg_81_0 and not isNil(var_81_8) and arg_78_1.var_.actorSpriteComps10113 then
				for iter_81_6, iter_81_7 in pairs(arg_78_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_81_7 then
						if arg_78_1.isInRecall_ then
							iter_81_7.color = arg_78_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_81_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_78_1.var_.actorSpriteComps10113 = nil
			end

			local var_81_16 = 0
			local var_81_17 = 0.875

			if var_81_16 < arg_78_1.time_ and arg_78_1.time_ <= var_81_16 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, true)

				local var_81_18 = arg_78_1:FormatText(StoryNameCfg[595].name)

				arg_78_1.leftNameTxt_.text = var_81_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_78_1.leftNameTxt_.transform)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1.leftNameTxt_.text)
				SetActive(arg_78_1.iconTrs_.gameObject, false)
				arg_78_1.callingController_:SetSelectedState("normal")

				local var_81_19 = arg_78_1:GetWordFromCfg(417212019)
				local var_81_20 = arg_78_1:FormatText(var_81_19.content)

				arg_78_1.text_.text = var_81_20

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_21 = 35
				local var_81_22 = utf8.len(var_81_20)
				local var_81_23 = var_81_21 <= 0 and var_81_17 or var_81_17 * (var_81_22 / var_81_21)

				if var_81_23 > 0 and var_81_17 < var_81_23 then
					arg_78_1.talkMaxDuration = var_81_23

					if var_81_23 + var_81_16 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_23 + var_81_16
					end
				end

				arg_78_1.text_.text = var_81_20
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417212", "417212019", "story_v_out_417212.awb") ~= 0 then
					local var_81_24 = manager.audio:GetVoiceLength("story_v_out_417212", "417212019", "story_v_out_417212.awb") / 1000

					if var_81_24 + var_81_16 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_24 + var_81_16
					end

					if var_81_19.prefab_name ~= "" and arg_78_1.actors_[var_81_19.prefab_name] ~= nil then
						local var_81_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_78_1.actors_[var_81_19.prefab_name].transform, "story_v_out_417212", "417212019", "story_v_out_417212.awb")

						arg_78_1:RecordAudio("417212019", var_81_25)
						arg_78_1:RecordAudio("417212019", var_81_25)
					else
						arg_78_1:AudioAction("play", "voice", "story_v_out_417212", "417212019", "story_v_out_417212.awb")
					end

					arg_78_1:RecordHistoryTalkVoice("story_v_out_417212", "417212019", "story_v_out_417212.awb")
				end

				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_26 = math.max(var_81_17, arg_78_1.talkMaxDuration)

			if var_81_16 <= arg_78_1.time_ and arg_78_1.time_ < var_81_16 + var_81_26 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_16) / var_81_26

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_16 + var_81_26 and arg_78_1.time_ < var_81_16 + var_81_26 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {}

		arg_78_1:InitPlayNodeList()
	end,
	Play417212020 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 417212020
		arg_82_1.duration_ = 8.03

		local var_82_0 = {
			zh = 5.733,
			ja = 8.033
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
				arg_82_0:Play417212021(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			local var_85_0 = arg_82_1.actors_["10113"]
			local var_85_1 = 0

			if var_85_1 < arg_82_1.time_ and arg_82_1.time_ <= var_85_1 + arg_85_0 and not isNil(var_85_0) and arg_82_1.var_.actorSpriteComps10113 == nil then
				arg_82_1.var_.actorSpriteComps10113 = var_85_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_85_2 = 0.2

			if var_85_1 <= arg_82_1.time_ and arg_82_1.time_ < var_85_1 + var_85_2 and not isNil(var_85_0) then
				local var_85_3 = (arg_82_1.time_ - var_85_1) / var_85_2

				if arg_82_1.var_.actorSpriteComps10113 then
					for iter_85_0, iter_85_1 in pairs(arg_82_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_85_1 then
							if arg_82_1.isInRecall_ then
								local var_85_4 = Mathf.Lerp(iter_85_1.color.r, arg_82_1.hightColor1.r, var_85_3)
								local var_85_5 = Mathf.Lerp(iter_85_1.color.g, arg_82_1.hightColor1.g, var_85_3)
								local var_85_6 = Mathf.Lerp(iter_85_1.color.b, arg_82_1.hightColor1.b, var_85_3)

								iter_85_1.color = Color.New(var_85_4, var_85_5, var_85_6)
							else
								local var_85_7 = Mathf.Lerp(iter_85_1.color.r, 1, var_85_3)

								iter_85_1.color = Color.New(var_85_7, var_85_7, var_85_7)
							end
						end
					end
				end
			end

			if arg_82_1.time_ >= var_85_1 + var_85_2 and arg_82_1.time_ < var_85_1 + var_85_2 + arg_85_0 and not isNil(var_85_0) and arg_82_1.var_.actorSpriteComps10113 then
				for iter_85_2, iter_85_3 in pairs(arg_82_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_85_3 then
						if arg_82_1.isInRecall_ then
							iter_85_3.color = arg_82_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_85_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_82_1.var_.actorSpriteComps10113 = nil
			end

			local var_85_8 = arg_82_1.actors_["10128"]
			local var_85_9 = 0

			if var_85_9 < arg_82_1.time_ and arg_82_1.time_ <= var_85_9 + arg_85_0 and not isNil(var_85_8) and arg_82_1.var_.actorSpriteComps10128 == nil then
				arg_82_1.var_.actorSpriteComps10128 = var_85_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_85_10 = 0.2

			if var_85_9 <= arg_82_1.time_ and arg_82_1.time_ < var_85_9 + var_85_10 and not isNil(var_85_8) then
				local var_85_11 = (arg_82_1.time_ - var_85_9) / var_85_10

				if arg_82_1.var_.actorSpriteComps10128 then
					for iter_85_4, iter_85_5 in pairs(arg_82_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_85_5 then
							if arg_82_1.isInRecall_ then
								local var_85_12 = Mathf.Lerp(iter_85_5.color.r, arg_82_1.hightColor2.r, var_85_11)
								local var_85_13 = Mathf.Lerp(iter_85_5.color.g, arg_82_1.hightColor2.g, var_85_11)
								local var_85_14 = Mathf.Lerp(iter_85_5.color.b, arg_82_1.hightColor2.b, var_85_11)

								iter_85_5.color = Color.New(var_85_12, var_85_13, var_85_14)
							else
								local var_85_15 = Mathf.Lerp(iter_85_5.color.r, 0.5, var_85_11)

								iter_85_5.color = Color.New(var_85_15, var_85_15, var_85_15)
							end
						end
					end
				end
			end

			if arg_82_1.time_ >= var_85_9 + var_85_10 and arg_82_1.time_ < var_85_9 + var_85_10 + arg_85_0 and not isNil(var_85_8) and arg_82_1.var_.actorSpriteComps10128 then
				for iter_85_6, iter_85_7 in pairs(arg_82_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_85_7 then
						if arg_82_1.isInRecall_ then
							iter_85_7.color = arg_82_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_85_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_82_1.var_.actorSpriteComps10128 = nil
			end

			local var_85_16 = arg_82_1.actors_["10113"].transform
			local var_85_17 = 0

			if var_85_17 < arg_82_1.time_ and arg_82_1.time_ <= var_85_17 + arg_85_0 then
				arg_82_1.var_.moveOldPos10113 = var_85_16.localPosition
				var_85_16.localScale = Vector3.New(1, 1, 1)

				arg_82_1:CheckSpriteTmpPos("10113", 2)

				local var_85_18 = var_85_16.childCount

				for iter_85_8 = 0, var_85_18 - 1 do
					local var_85_19 = var_85_16:GetChild(iter_85_8)

					if var_85_19.name == "split_2" or not string.find(var_85_19.name, "split") then
						var_85_19.gameObject:SetActive(true)
					else
						var_85_19.gameObject:SetActive(false)
					end
				end
			end

			local var_85_20 = 0.001

			if var_85_17 <= arg_82_1.time_ and arg_82_1.time_ < var_85_17 + var_85_20 then
				local var_85_21 = (arg_82_1.time_ - var_85_17) / var_85_20
				local var_85_22 = Vector3.New(-403.26, -328.4, -517.4)

				var_85_16.localPosition = Vector3.Lerp(arg_82_1.var_.moveOldPos10113, var_85_22, var_85_21)
			end

			if arg_82_1.time_ >= var_85_17 + var_85_20 and arg_82_1.time_ < var_85_17 + var_85_20 + arg_85_0 then
				var_85_16.localPosition = Vector3.New(-403.26, -328.4, -517.4)
			end

			local var_85_23 = 0
			local var_85_24 = 0.625

			if var_85_23 < arg_82_1.time_ and arg_82_1.time_ <= var_85_23 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				local var_85_25 = arg_82_1:FormatText(StoryNameCfg[1117].name)

				arg_82_1.leftNameTxt_.text = var_85_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_26 = arg_82_1:GetWordFromCfg(417212020)
				local var_85_27 = arg_82_1:FormatText(var_85_26.content)

				arg_82_1.text_.text = var_85_27

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_28 = 25
				local var_85_29 = utf8.len(var_85_27)
				local var_85_30 = var_85_28 <= 0 and var_85_24 or var_85_24 * (var_85_29 / var_85_28)

				if var_85_30 > 0 and var_85_24 < var_85_30 then
					arg_82_1.talkMaxDuration = var_85_30

					if var_85_30 + var_85_23 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_30 + var_85_23
					end
				end

				arg_82_1.text_.text = var_85_27
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417212", "417212020", "story_v_out_417212.awb") ~= 0 then
					local var_85_31 = manager.audio:GetVoiceLength("story_v_out_417212", "417212020", "story_v_out_417212.awb") / 1000

					if var_85_31 + var_85_23 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_31 + var_85_23
					end

					if var_85_26.prefab_name ~= "" and arg_82_1.actors_[var_85_26.prefab_name] ~= nil then
						local var_85_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_82_1.actors_[var_85_26.prefab_name].transform, "story_v_out_417212", "417212020", "story_v_out_417212.awb")

						arg_82_1:RecordAudio("417212020", var_85_32)
						arg_82_1:RecordAudio("417212020", var_85_32)
					else
						arg_82_1:AudioAction("play", "voice", "story_v_out_417212", "417212020", "story_v_out_417212.awb")
					end

					arg_82_1:RecordHistoryTalkVoice("story_v_out_417212", "417212020", "story_v_out_417212.awb")
				end

				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_33 = math.max(var_85_24, arg_82_1.talkMaxDuration)

			if var_85_23 <= arg_82_1.time_ and arg_82_1.time_ < var_85_23 + var_85_33 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_23) / var_85_33

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_23 + var_85_33 and arg_82_1.time_ < var_85_23 + var_85_33 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10113",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_82_1:InitPlayNodeList()
	end,
	Play417212021 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 417212021
		arg_86_1.duration_ = 5

		SetActive(arg_86_1.tipsGo_, false)

		function arg_86_1.onSingleLineFinish_()
			arg_86_1.onSingleLineUpdate_ = nil
			arg_86_1.onSingleLineFinish_ = nil
			arg_86_1.state_ = "waiting"
		end

		function arg_86_1.playNext_(arg_88_0)
			if arg_88_0 == 1 then
				arg_86_0:Play417212022(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			local var_89_0 = arg_86_1.actors_["10113"]
			local var_89_1 = 0

			if var_89_1 < arg_86_1.time_ and arg_86_1.time_ <= var_89_1 + arg_89_0 and not isNil(var_89_0) and arg_86_1.var_.actorSpriteComps10113 == nil then
				arg_86_1.var_.actorSpriteComps10113 = var_89_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_89_2 = 0.2

			if var_89_1 <= arg_86_1.time_ and arg_86_1.time_ < var_89_1 + var_89_2 and not isNil(var_89_0) then
				local var_89_3 = (arg_86_1.time_ - var_89_1) / var_89_2

				if arg_86_1.var_.actorSpriteComps10113 then
					for iter_89_0, iter_89_1 in pairs(arg_86_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_89_1 then
							if arg_86_1.isInRecall_ then
								local var_89_4 = Mathf.Lerp(iter_89_1.color.r, arg_86_1.hightColor2.r, var_89_3)
								local var_89_5 = Mathf.Lerp(iter_89_1.color.g, arg_86_1.hightColor2.g, var_89_3)
								local var_89_6 = Mathf.Lerp(iter_89_1.color.b, arg_86_1.hightColor2.b, var_89_3)

								iter_89_1.color = Color.New(var_89_4, var_89_5, var_89_6)
							else
								local var_89_7 = Mathf.Lerp(iter_89_1.color.r, 0.5, var_89_3)

								iter_89_1.color = Color.New(var_89_7, var_89_7, var_89_7)
							end
						end
					end
				end
			end

			if arg_86_1.time_ >= var_89_1 + var_89_2 and arg_86_1.time_ < var_89_1 + var_89_2 + arg_89_0 and not isNil(var_89_0) and arg_86_1.var_.actorSpriteComps10113 then
				for iter_89_2, iter_89_3 in pairs(arg_86_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_89_3 then
						if arg_86_1.isInRecall_ then
							iter_89_3.color = arg_86_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_89_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_86_1.var_.actorSpriteComps10113 = nil
			end

			local var_89_8 = arg_86_1.actors_["10113"].transform
			local var_89_9 = 0

			if var_89_9 < arg_86_1.time_ and arg_86_1.time_ <= var_89_9 + arg_89_0 then
				arg_86_1.var_.moveOldPos10113 = var_89_8.localPosition
				var_89_8.localScale = Vector3.New(1, 1, 1)

				arg_86_1:CheckSpriteTmpPos("10113", 7)

				local var_89_10 = var_89_8.childCount

				for iter_89_4 = 0, var_89_10 - 1 do
					local var_89_11 = var_89_8:GetChild(iter_89_4)

					if var_89_11.name == "" or not string.find(var_89_11.name, "split") then
						var_89_11.gameObject:SetActive(true)
					else
						var_89_11.gameObject:SetActive(false)
					end
				end
			end

			local var_89_12 = 0.001

			if var_89_9 <= arg_86_1.time_ and arg_86_1.time_ < var_89_9 + var_89_12 then
				local var_89_13 = (arg_86_1.time_ - var_89_9) / var_89_12
				local var_89_14 = Vector3.New(0, -2000, 0)

				var_89_8.localPosition = Vector3.Lerp(arg_86_1.var_.moveOldPos10113, var_89_14, var_89_13)
			end

			if arg_86_1.time_ >= var_89_9 + var_89_12 and arg_86_1.time_ < var_89_9 + var_89_12 + arg_89_0 then
				var_89_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_89_15 = arg_86_1.actors_["10128"].transform
			local var_89_16 = 0

			if var_89_16 < arg_86_1.time_ and arg_86_1.time_ <= var_89_16 + arg_89_0 then
				arg_86_1.var_.moveOldPos10128 = var_89_15.localPosition
				var_89_15.localScale = Vector3.New(1, 1, 1)

				arg_86_1:CheckSpriteTmpPos("10128", 7)

				local var_89_17 = var_89_15.childCount

				for iter_89_5 = 0, var_89_17 - 1 do
					local var_89_18 = var_89_15:GetChild(iter_89_5)

					if var_89_18.name == "" or not string.find(var_89_18.name, "split") then
						var_89_18.gameObject:SetActive(true)
					else
						var_89_18.gameObject:SetActive(false)
					end
				end
			end

			local var_89_19 = 0.001

			if var_89_16 <= arg_86_1.time_ and arg_86_1.time_ < var_89_16 + var_89_19 then
				local var_89_20 = (arg_86_1.time_ - var_89_16) / var_89_19
				local var_89_21 = Vector3.New(0, -2000, -300)

				var_89_15.localPosition = Vector3.Lerp(arg_86_1.var_.moveOldPos10128, var_89_21, var_89_20)
			end

			if arg_86_1.time_ >= var_89_16 + var_89_19 and arg_86_1.time_ < var_89_16 + var_89_19 + arg_89_0 then
				var_89_15.localPosition = Vector3.New(0, -2000, -300)
			end

			local var_89_22 = 0
			local var_89_23 = 0.475

			if var_89_22 < arg_86_1.time_ and arg_86_1.time_ <= var_89_22 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, false)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_24 = arg_86_1:GetWordFromCfg(417212021)
				local var_89_25 = arg_86_1:FormatText(var_89_24.content)

				arg_86_1.text_.text = var_89_25

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_26 = 19
				local var_89_27 = utf8.len(var_89_25)
				local var_89_28 = var_89_26 <= 0 and var_89_23 or var_89_23 * (var_89_27 / var_89_26)

				if var_89_28 > 0 and var_89_23 < var_89_28 then
					arg_86_1.talkMaxDuration = var_89_28

					if var_89_28 + var_89_22 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_28 + var_89_22
					end
				end

				arg_86_1.text_.text = var_89_25
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)
				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_29 = math.max(var_89_23, arg_86_1.talkMaxDuration)

			if var_89_22 <= arg_86_1.time_ and arg_86_1.time_ < var_89_22 + var_89_29 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_22) / var_89_29

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_22 + var_89_29 and arg_86_1.time_ < var_89_22 + var_89_29 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10113",
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

		arg_86_1:InitPlayNodeList()
	end,
	Play417212022 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 417212022
		arg_90_1.duration_ = 4.3

		local var_90_0 = {
			zh = 3.9,
			ja = 4.3
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
			arg_90_1.auto_ = false
		end

		function arg_90_1.playNext_(arg_92_0)
			arg_90_1.onStoryFinished_()
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			local var_93_0 = arg_90_1.actors_["10113"]
			local var_93_1 = 0

			if var_93_1 < arg_90_1.time_ and arg_90_1.time_ <= var_93_1 + arg_93_0 and not isNil(var_93_0) and arg_90_1.var_.actorSpriteComps10113 == nil then
				arg_90_1.var_.actorSpriteComps10113 = var_93_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_93_2 = 0.2

			if var_93_1 <= arg_90_1.time_ and arg_90_1.time_ < var_93_1 + var_93_2 and not isNil(var_93_0) then
				local var_93_3 = (arg_90_1.time_ - var_93_1) / var_93_2

				if arg_90_1.var_.actorSpriteComps10113 then
					for iter_93_0, iter_93_1 in pairs(arg_90_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_93_1 then
							if arg_90_1.isInRecall_ then
								local var_93_4 = Mathf.Lerp(iter_93_1.color.r, arg_90_1.hightColor1.r, var_93_3)
								local var_93_5 = Mathf.Lerp(iter_93_1.color.g, arg_90_1.hightColor1.g, var_93_3)
								local var_93_6 = Mathf.Lerp(iter_93_1.color.b, arg_90_1.hightColor1.b, var_93_3)

								iter_93_1.color = Color.New(var_93_4, var_93_5, var_93_6)
							else
								local var_93_7 = Mathf.Lerp(iter_93_1.color.r, 1, var_93_3)

								iter_93_1.color = Color.New(var_93_7, var_93_7, var_93_7)
							end
						end
					end
				end
			end

			if arg_90_1.time_ >= var_93_1 + var_93_2 and arg_90_1.time_ < var_93_1 + var_93_2 + arg_93_0 and not isNil(var_93_0) and arg_90_1.var_.actorSpriteComps10113 then
				for iter_93_2, iter_93_3 in pairs(arg_90_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_93_3 then
						if arg_90_1.isInRecall_ then
							iter_93_3.color = arg_90_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_93_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_90_1.var_.actorSpriteComps10113 = nil
			end

			local var_93_8 = arg_90_1.actors_["10113"].transform
			local var_93_9 = 0

			if var_93_9 < arg_90_1.time_ and arg_90_1.time_ <= var_93_9 + arg_93_0 then
				arg_90_1.var_.moveOldPos10113 = var_93_8.localPosition
				var_93_8.localScale = Vector3.New(1, 1, 1)

				arg_90_1:CheckSpriteTmpPos("10113", 3)

				local var_93_10 = var_93_8.childCount

				for iter_93_4 = 0, var_93_10 - 1 do
					local var_93_11 = var_93_8:GetChild(iter_93_4)

					if var_93_11.name == "" or not string.find(var_93_11.name, "split") then
						var_93_11.gameObject:SetActive(true)
					else
						var_93_11.gameObject:SetActive(false)
					end
				end
			end

			local var_93_12 = 0.001

			if var_93_9 <= arg_90_1.time_ and arg_90_1.time_ < var_93_9 + var_93_12 then
				local var_93_13 = (arg_90_1.time_ - var_93_9) / var_93_12
				local var_93_14 = Vector3.New(-30.38, -328.4, -517.4)

				var_93_8.localPosition = Vector3.Lerp(arg_90_1.var_.moveOldPos10113, var_93_14, var_93_13)
			end

			if arg_90_1.time_ >= var_93_9 + var_93_12 and arg_90_1.time_ < var_93_9 + var_93_12 + arg_93_0 then
				var_93_8.localPosition = Vector3.New(-30.38, -328.4, -517.4)
			end

			local var_93_15 = 0
			local var_93_16 = 0.325

			if var_93_15 < arg_90_1.time_ and arg_90_1.time_ <= var_93_15 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				local var_93_17 = arg_90_1:FormatText(StoryNameCfg[1117].name)

				arg_90_1.leftNameTxt_.text = var_93_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_18 = arg_90_1:GetWordFromCfg(417212022)
				local var_93_19 = arg_90_1:FormatText(var_93_18.content)

				arg_90_1.text_.text = var_93_19

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_20 = 13
				local var_93_21 = utf8.len(var_93_19)
				local var_93_22 = var_93_20 <= 0 and var_93_16 or var_93_16 * (var_93_21 / var_93_20)

				if var_93_22 > 0 and var_93_16 < var_93_22 then
					arg_90_1.talkMaxDuration = var_93_22

					if var_93_22 + var_93_15 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_22 + var_93_15
					end
				end

				arg_90_1.text_.text = var_93_19
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417212", "417212022", "story_v_out_417212.awb") ~= 0 then
					local var_93_23 = manager.audio:GetVoiceLength("story_v_out_417212", "417212022", "story_v_out_417212.awb") / 1000

					if var_93_23 + var_93_15 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_23 + var_93_15
					end

					if var_93_18.prefab_name ~= "" and arg_90_1.actors_[var_93_18.prefab_name] ~= nil then
						local var_93_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_90_1.actors_[var_93_18.prefab_name].transform, "story_v_out_417212", "417212022", "story_v_out_417212.awb")

						arg_90_1:RecordAudio("417212022", var_93_24)
						arg_90_1:RecordAudio("417212022", var_93_24)
					else
						arg_90_1:AudioAction("play", "voice", "story_v_out_417212", "417212022", "story_v_out_417212.awb")
					end

					arg_90_1:RecordHistoryTalkVoice("story_v_out_417212", "417212022", "story_v_out_417212.awb")
				end

				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_25 = math.max(var_93_16, arg_90_1.talkMaxDuration)

			if var_93_15 <= arg_90_1.time_ and arg_90_1.time_ < var_93_15 + var_93_25 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_15) / var_93_25

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_15 + var_93_25 and arg_90_1.time_ < var_93_15 + var_93_25 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10113",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_90_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/I16g"
	},
	voices = {
		"story_v_out_417212.awb"
	}
}
