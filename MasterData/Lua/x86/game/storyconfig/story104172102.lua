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
			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1.cswbg_:SetActive(true)

				local var_4_0 = arg_1_1.cswt_:GetComponent("RectTransform")

				arg_1_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_4_0.offsetMin = Vector2.New(0, 0)
				var_4_0.offsetMax = Vector2.New(0, 0)
				arg_1_1.cswt_.text = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(419111).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.cswt_)

				arg_1_1.cswt_.fontSize = 120
				arg_1_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_1_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_1_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1.fswbg_:SetActive(true)
				arg_1_1.dialog_:SetActive(false)

				arg_1_1.fswtw_.percent = 0
				arg_1_1.fswt_.text = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(417212001).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.fswt_)

				arg_1_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_1_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_1_1.fswtw_:SetDirty()

				arg_1_1.typewritterCharCountI18N = 0

				SetActive(arg_1_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_1_1:ShowNextGo(false)
			end

			local var_4_1 = 1.96666666666667

			if 1.96666666666667 < arg_1_1.time_ and arg_1_1.time_ <= var_4_1 + arg_4_0 then
				arg_1_1.var_.oldValueTypewriter = arg_1_1.fswtw_.percent

				SetActive(arg_1_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_1_1:ShowNextGo(false)
			end

			local var_4_2 = 20
			local var_4_3 = 1.33333333333333
			local var_4_4, var_4_5 = arg_1_1:GetPercentByPara(arg_1_1:FormatText(arg_1_1:GetWordFromCfg(417212001).content), 1)

			if var_4_1 < arg_1_1.time_ and arg_1_1.time_ <= var_4_1 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				local var_4_6 = var_4_2 <= 0 and var_4_3 or var_4_3 * ((var_4_5 - arg_1_1.typewritterCharCountI18N) / var_4_2)

				if (var_4_2 <= 0 and var_4_3 or var_4_3 * ((var_4_5 - arg_1_1.typewritterCharCountI18N) / var_4_2)) > 0 and var_4_3 < var_4_6 then
					arg_1_1.talkMaxDuration = var_4_6

					if var_4_6 + var_4_1 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_6 + var_4_1
					end
				end
			end

			local var_4_7 = math.max(1.33333333333333, arg_1_1.talkMaxDuration)

			if var_4_1 <= arg_1_1.time_ and arg_1_1.time_ < var_4_1 + var_4_7 then
				arg_1_1.fswtw_.percent = Mathf.Lerp(arg_1_1.var_.oldValueTypewriter, var_4_4, (arg_1_1.time_ - var_4_1) / var_4_7)
				arg_1_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_1_1.fswtw_:SetDirty()
			end

			if arg_1_1.time_ >= var_4_1 + var_4_7 and arg_1_1.time_ < var_4_1 + var_4_7 + arg_4_0 then
				arg_1_1.fswtw_.percent = var_4_4

				arg_1_1.fswtw_:SetDirty()
				arg_1_1:ShowNextGo(true)

				arg_1_1.typewritterCharCountI18N = var_4_5
			end

			if 1.96666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 1.96666666666667 + arg_4_0 then
				local var_4_8 = arg_1_1.fswbg_.transform:Find("textbox/adapt/content") or arg_1_1.fswbg_.transform:Find("textbox/content")
				local var_4_9 = arg_1_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_4_10 = var_4_8:GetComponent("RectTransform")

				var_4_8:GetComponent("Text").alignment = UnityEngine.TextAnchor.LowerCenter
				var_4_10.offsetMin = Vector2.New(0, 0)
				var_4_10.offsetMax = Vector2.New(0, 0)
			end

			local var_4_11 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_11 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = false

				arg_1_1:SetGaussion(false)
			end

			local var_4_12 = 1

			if var_4_11 <= arg_1_1.time_ and arg_1_1.time_ < var_4_11 + var_4_12 then
				local var_4_13 = Color.New(0, 0, 0)

				var_4_13.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - var_4_11) / var_4_12)
				arg_1_1.mask_.color = var_4_13
			end

			if arg_1_1.time_ >= var_4_11 + var_4_12 and arg_1_1.time_ < var_4_11 + var_4_12 + arg_4_0 then
				local var_4_14 = Color.New(0, 0, 0)

				arg_1_1.mask_.enabled = false
				var_4_14.a = 0
				arg_1_1.mask_.color = var_4_14
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_17 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_17 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_17

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_17
						arg_1_1.bgmTxt2_.text = var_4_17
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

			if 0.05 < arg_1_1.time_ and arg_1_1.time_ <= 0.05 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_wind", "")
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
			if 0 < arg_6_1.time_ and arg_6_1.time_ <= 0 + arg_9_0 then
				arg_6_1.fswbg_:SetActive(true)
				arg_6_1.dialog_:SetActive(false)

				arg_6_1.fswtw_.percent = 0
				arg_6_1.fswt_.text = arg_6_1:FormatText(arg_6_1:GetWordFromCfg(417212002).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_6_1.fswt_)

				arg_6_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_6_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_6_1.fswtw_:SetDirty()

				arg_6_1.typewritterCharCountI18N = 0

				SetActive(arg_6_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_6_1:ShowNextGo(false)
			end

			local var_9_0 = 0.0999999999999999

			if 0.0999999999999999 < arg_6_1.time_ and arg_6_1.time_ <= var_9_0 + arg_9_0 then
				arg_6_1.var_.oldValueTypewriter = arg_6_1.fswtw_.percent

				SetActive(arg_6_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_6_1:ShowNextGo(false)
			end

			local var_9_1 = 48
			local var_9_2 = 3.2
			local var_9_3, var_9_4 = arg_6_1:GetPercentByPara(arg_6_1:FormatText(arg_6_1:GetWordFromCfg(417212002).content), 1)

			if var_9_0 < arg_6_1.time_ and arg_6_1.time_ <= var_9_0 + arg_9_0 then
				arg_6_1.talkMaxDuration = 0

				local var_9_5 = var_9_1 <= 0 and var_9_2 or var_9_2 * ((var_9_4 - arg_6_1.typewritterCharCountI18N) / var_9_1)

				if (var_9_1 <= 0 and var_9_2 or var_9_2 * ((var_9_4 - arg_6_1.typewritterCharCountI18N) / var_9_1)) > 0 and var_9_2 < var_9_5 then
					arg_6_1.talkMaxDuration = var_9_5

					if var_9_5 + var_9_0 > arg_6_1.duration_ then
						arg_6_1.duration_ = var_9_5 + var_9_0
					end
				end
			end

			local var_9_6 = math.max(3.2, arg_6_1.talkMaxDuration)

			if var_9_0 <= arg_6_1.time_ and arg_6_1.time_ < var_9_0 + var_9_6 then
				arg_6_1.fswtw_.percent = Mathf.Lerp(arg_6_1.var_.oldValueTypewriter, var_9_3, (arg_6_1.time_ - var_9_0) / var_9_6)
				arg_6_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_6_1.fswtw_:SetDirty()
			end

			if arg_6_1.time_ >= var_9_0 + var_9_6 and arg_6_1.time_ < var_9_0 + var_9_6 + arg_9_0 then
				arg_6_1.fswtw_.percent = var_9_3

				arg_6_1.fswtw_:SetDirty()
				arg_6_1:ShowNextGo(true)

				arg_6_1.typewritterCharCountI18N = var_9_4
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
			if 0 < arg_10_1.time_ and arg_10_1.time_ <= 0 + arg_13_0 then
				arg_10_1.fswbg_:SetActive(true)
				arg_10_1.dialog_:SetActive(false)

				arg_10_1.fswtw_.percent = 0
				arg_10_1.fswt_.text = arg_10_1:FormatText(arg_10_1:GetWordFromCfg(417212003).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_10_1.fswt_)

				arg_10_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_10_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_10_1.fswtw_:SetDirty()

				arg_10_1.typewritterCharCountI18N = 0

				SetActive(arg_10_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_10_1:ShowNextGo(false)
			end

			local var_13_0 = 0.0999999999999999

			if 0.0999999999999999 < arg_10_1.time_ and arg_10_1.time_ <= var_13_0 + arg_13_0 then
				arg_10_1.var_.oldValueTypewriter = arg_10_1.fswtw_.percent

				SetActive(arg_10_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_10_1:ShowNextGo(false)
			end

			local var_13_1 = 41
			local var_13_2 = 2.73333333333333
			local var_13_3, var_13_4 = arg_10_1:GetPercentByPara(arg_10_1:FormatText(arg_10_1:GetWordFromCfg(417212003).content), 1)

			if var_13_0 < arg_10_1.time_ and arg_10_1.time_ <= var_13_0 + arg_13_0 then
				arg_10_1.talkMaxDuration = 0

				local var_13_5 = var_13_1 <= 0 and var_13_2 or var_13_2 * ((var_13_4 - arg_10_1.typewritterCharCountI18N) / var_13_1)

				if (var_13_1 <= 0 and var_13_2 or var_13_2 * ((var_13_4 - arg_10_1.typewritterCharCountI18N) / var_13_1)) > 0 and var_13_2 < var_13_5 then
					arg_10_1.talkMaxDuration = var_13_5

					if var_13_5 + var_13_0 > arg_10_1.duration_ then
						arg_10_1.duration_ = var_13_5 + var_13_0
					end
				end
			end

			local var_13_6 = math.max(2.73333333333333, arg_10_1.talkMaxDuration)

			if var_13_0 <= arg_10_1.time_ and arg_10_1.time_ < var_13_0 + var_13_6 then
				arg_10_1.fswtw_.percent = Mathf.Lerp(arg_10_1.var_.oldValueTypewriter, var_13_3, (arg_10_1.time_ - var_13_0) / var_13_6)
				arg_10_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_10_1.fswtw_:SetDirty()
			end

			if arg_10_1.time_ >= var_13_0 + var_13_6 and arg_10_1.time_ < var_13_0 + var_13_6 + arg_13_0 then
				arg_10_1.fswtw_.percent = var_13_3

				arg_10_1.fswtw_:SetDirty()
				arg_10_1:ShowNextGo(true)

				arg_10_1.typewritterCharCountI18N = var_13_4
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
			if 0 < arg_14_1.time_ and arg_14_1.time_ <= 0 + arg_17_0 then
				arg_14_1.cswbg_:SetActive(true)

				local var_17_0 = arg_14_1.cswt_:GetComponent("RectTransform")

				arg_14_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_17_0.offsetMin = Vector2.New(0, 0)
				var_17_0.offsetMax = Vector2.New(0, 0)
				arg_14_1.cswt_.text = arg_14_1:FormatText(arg_14_1:GetWordFromCfg(419112).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_14_1.cswt_)

				arg_14_1.cswt_.fontSize = 120
				arg_14_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_14_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_14_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end

			if 0 < arg_14_1.time_ and arg_14_1.time_ <= 0 + arg_17_0 then
				arg_14_1.fswbg_:SetActive(true)
				arg_14_1.dialog_:SetActive(false)

				arg_14_1.fswtw_.percent = 0
				arg_14_1.fswt_.text = arg_14_1:FormatText(arg_14_1:GetWordFromCfg(417212004).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_14_1.fswt_)

				arg_14_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_14_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_14_1.fswtw_:SetDirty()

				arg_14_1.typewritterCharCountI18N = 0

				SetActive(arg_14_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_14_1:ShowNextGo(false)
			end

			local var_17_1 = 0.0999999999999998

			if 0.0999999999999998 < arg_14_1.time_ and arg_14_1.time_ <= var_17_1 + arg_17_0 then
				arg_14_1.var_.oldValueTypewriter = arg_14_1.fswtw_.percent

				SetActive(arg_14_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_14_1:ShowNextGo(false)
			end

			local var_17_2 = 20
			local var_17_3 = 1.33333333333333
			local var_17_4, var_17_5 = arg_14_1:GetPercentByPara(arg_14_1:FormatText(arg_14_1:GetWordFromCfg(417212004).content), 1)

			if var_17_1 < arg_14_1.time_ and arg_14_1.time_ <= var_17_1 + arg_17_0 then
				arg_14_1.talkMaxDuration = 0

				local var_17_6 = var_17_2 <= 0 and var_17_3 or var_17_3 * ((var_17_5 - arg_14_1.typewritterCharCountI18N) / var_17_2)

				if (var_17_2 <= 0 and var_17_3 or var_17_3 * ((var_17_5 - arg_14_1.typewritterCharCountI18N) / var_17_2)) > 0 and var_17_3 < var_17_6 then
					arg_14_1.talkMaxDuration = var_17_6

					if var_17_6 + var_17_1 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_6 + var_17_1
					end
				end
			end

			local var_17_7 = math.max(1.33333333333333, arg_14_1.talkMaxDuration)

			if var_17_1 <= arg_14_1.time_ and arg_14_1.time_ < var_17_1 + var_17_7 then
				arg_14_1.fswtw_.percent = Mathf.Lerp(arg_14_1.var_.oldValueTypewriter, var_17_4, (arg_14_1.time_ - var_17_1) / var_17_7)
				arg_14_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_14_1.fswtw_:SetDirty()
			end

			if arg_14_1.time_ >= var_17_1 + var_17_7 and arg_14_1.time_ < var_17_1 + var_17_7 + arg_17_0 then
				arg_14_1.fswtw_.percent = var_17_4

				arg_14_1.fswtw_:SetDirty()
				arg_14_1:ShowNextGo(true)

				arg_14_1.typewritterCharCountI18N = var_17_5
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
			if 0 < arg_18_1.time_ and arg_18_1.time_ <= 0 + arg_21_0 then
				arg_18_1.fswbg_:SetActive(true)
				arg_18_1.dialog_:SetActive(false)

				arg_18_1.fswtw_.percent = 0
				arg_18_1.fswt_.text = arg_18_1:FormatText(arg_18_1:GetWordFromCfg(417212005).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_18_1.fswt_)

				arg_18_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_18_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_18_1.fswtw_:SetDirty()

				arg_18_1.typewritterCharCountI18N = 0

				SetActive(arg_18_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_18_1:ShowNextGo(false)
			end

			local var_21_0 = 0.0999999999999996

			if 0.0999999999999996 < arg_18_1.time_ and arg_18_1.time_ <= var_21_0 + arg_21_0 then
				arg_18_1.var_.oldValueTypewriter = arg_18_1.fswtw_.percent

				SetActive(arg_18_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_18_1:ShowNextGo(false)
			end

			local var_21_1 = 59
			local var_21_2 = 3.93333333333333
			local var_21_3, var_21_4 = arg_18_1:GetPercentByPara(arg_18_1:FormatText(arg_18_1:GetWordFromCfg(417212005).content), 1)

			if var_21_0 < arg_18_1.time_ and arg_18_1.time_ <= var_21_0 + arg_21_0 then
				arg_18_1.talkMaxDuration = 0

				local var_21_5 = var_21_1 <= 0 and var_21_2 or var_21_2 * ((var_21_4 - arg_18_1.typewritterCharCountI18N) / var_21_1)

				if (var_21_1 <= 0 and var_21_2 or var_21_2 * ((var_21_4 - arg_18_1.typewritterCharCountI18N) / var_21_1)) > 0 and var_21_2 < var_21_5 then
					arg_18_1.talkMaxDuration = var_21_5

					if var_21_5 + var_21_0 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_5 + var_21_0
					end
				end
			end

			local var_21_6 = math.max(3.93333333333333, arg_18_1.talkMaxDuration)

			if var_21_0 <= arg_18_1.time_ and arg_18_1.time_ < var_21_0 + var_21_6 then
				arg_18_1.fswtw_.percent = Mathf.Lerp(arg_18_1.var_.oldValueTypewriter, var_21_3, (arg_18_1.time_ - var_21_0) / var_21_6)
				arg_18_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_18_1.fswtw_:SetDirty()
			end

			if arg_18_1.time_ >= var_21_0 + var_21_6 and arg_18_1.time_ < var_21_0 + var_21_6 + arg_21_0 then
				arg_18_1.fswtw_.percent = var_21_3

				arg_18_1.fswtw_:SetDirty()
				arg_18_1:ShowNextGo(true)

				arg_18_1.typewritterCharCountI18N = var_21_4
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
			if 0 < arg_22_1.time_ and arg_22_1.time_ <= 0 + arg_25_0 then
				arg_22_1.fswbg_:SetActive(true)
				arg_22_1.dialog_:SetActive(false)

				arg_22_1.fswtw_.percent = 0
				arg_22_1.fswt_.text = arg_22_1:FormatText(arg_22_1:GetWordFromCfg(417212006).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_22_1.fswt_)

				arg_22_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_22_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_22_1.fswtw_:SetDirty()

				arg_22_1.typewritterCharCountI18N = 0

				SetActive(arg_22_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_22_1:ShowNextGo(false)
			end

			local var_25_0 = 0.0999999999999999

			if 0.0999999999999999 < arg_22_1.time_ and arg_22_1.time_ <= var_25_0 + arg_25_0 then
				arg_22_1.var_.oldValueTypewriter = arg_22_1.fswtw_.percent

				SetActive(arg_22_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_22_1:ShowNextGo(false)
			end

			local var_25_1 = 45
			local var_25_2 = 3
			local var_25_3, var_25_4 = arg_22_1:GetPercentByPara(arg_22_1:FormatText(arg_22_1:GetWordFromCfg(417212006).content), 1)

			if var_25_0 < arg_22_1.time_ and arg_22_1.time_ <= var_25_0 + arg_25_0 then
				arg_22_1.talkMaxDuration = 0

				local var_25_5 = var_25_1 <= 0 and var_25_2 or var_25_2 * ((var_25_4 - arg_22_1.typewritterCharCountI18N) / var_25_1)

				if (var_25_1 <= 0 and var_25_2 or var_25_2 * ((var_25_4 - arg_22_1.typewritterCharCountI18N) / var_25_1)) > 0 and var_25_2 < var_25_5 then
					arg_22_1.talkMaxDuration = var_25_5

					if var_25_5 + var_25_0 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_5 + var_25_0
					end
				end
			end

			local var_25_6 = math.max(3, arg_22_1.talkMaxDuration)

			if var_25_0 <= arg_22_1.time_ and arg_22_1.time_ < var_25_0 + var_25_6 then
				arg_22_1.fswtw_.percent = Mathf.Lerp(arg_22_1.var_.oldValueTypewriter, var_25_3, (arg_22_1.time_ - var_25_0) / var_25_6)
				arg_22_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_22_1.fswtw_:SetDirty()
			end

			if arg_22_1.time_ >= var_25_0 + var_25_6 and arg_22_1.time_ < var_25_0 + var_25_6 + arg_25_0 then
				arg_22_1.fswtw_.percent = var_25_3

				arg_22_1.fswtw_:SetDirty()
				arg_22_1:ShowNextGo(true)

				arg_22_1.typewritterCharCountI18N = var_25_4
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
			if 3 < arg_26_1.time_ and arg_26_1.time_ <= 3 + arg_29_0 then
				arg_26_1.allBtn_.enabled = false
			end

			if arg_26_1.time_ >= 3 + 0.533333333333335 and arg_26_1.time_ < 3 + 0.533333333333335 + arg_29_0 then
				arg_26_1.allBtn_.enabled = true
			end

			local var_29_0 = "I16g"

			if arg_26_1.bgs_.I16g == nil then
				local var_29_1 = Object.Instantiate(arg_26_1.paintGo_)

				var_29_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_29_0)
				var_29_1.name = var_29_0
				var_29_1.transform.parent = arg_26_1.stage_.transform
				var_29_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_26_1.bgs_[var_29_0] = var_29_1
			end

			if 1 < arg_26_1.time_ and arg_26_1.time_ <= 1 + arg_29_0 then
				local var_29_2 = arg_26_1.bgs_.I16g

				arg_26_1.bgs_.I16g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_29_2.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_29_3 = var_29_2:GetComponent("SpriteRenderer")

				if var_29_3 and var_29_3.sprite then
					local var_29_4 = 2 * (var_29_2.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_29_2.transform.localScale = Vector3.New(var_29_4 / var_29_3.sprite.bounds.size.y < var_29_4 * manager.ui.mainCameraCom_.aspect / var_29_3.sprite.bounds.size.x and var_29_4 * manager.ui.mainCameraCom_.aspect / var_29_3.sprite.bounds.size.x or var_29_4 / var_29_3.sprite.bounds.size.y, var_29_4 / var_29_3.sprite.bounds.size.y < var_29_4 * manager.ui.mainCameraCom_.aspect / var_29_3.sprite.bounds.size.x and var_29_4 * manager.ui.mainCameraCom_.aspect / var_29_3.sprite.bounds.size.x or var_29_4 / var_29_3.sprite.bounds.size.y, 0)
				end

				for iter_29_0, iter_29_1 in pairs(arg_26_1.bgs_) do
					if iter_29_0 ~= "I16g" then
						iter_29_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_29_5 = 0

			if 0 < arg_26_1.time_ and arg_26_1.time_ <= var_29_5 + arg_29_0 then
				arg_26_1.mask_.enabled = true
				arg_26_1.mask_.raycastTarget = true

				arg_26_1:SetGaussion(false)
			end

			local var_29_6 = 1

			if var_29_5 <= arg_26_1.time_ and arg_26_1.time_ < var_29_5 + var_29_6 then
				local var_29_7 = Color.New(0, 0, 0)

				var_29_7.a = Mathf.Lerp(0, 1, (arg_26_1.time_ - var_29_5) / var_29_6)
				arg_26_1.mask_.color = var_29_7
			end

			if arg_26_1.time_ >= var_29_5 + var_29_6 and arg_26_1.time_ < var_29_5 + var_29_6 + arg_29_0 then
				local var_29_8 = Color.New(0, 0, 0)

				var_29_8.a = 1
				arg_26_1.mask_.color = var_29_8
			end

			local var_29_9 = 1

			if 1 < arg_26_1.time_ and arg_26_1.time_ <= var_29_9 + arg_29_0 then
				arg_26_1.mask_.enabled = true
				arg_26_1.mask_.raycastTarget = true

				arg_26_1:SetGaussion(false)
			end

			local var_29_10 = 2

			if var_29_9 <= arg_26_1.time_ and arg_26_1.time_ < var_29_9 + var_29_10 then
				local var_29_11 = Color.New(0, 0, 0)

				var_29_11.a = Mathf.Lerp(1, 0, (arg_26_1.time_ - var_29_9) / var_29_10)
				arg_26_1.mask_.color = var_29_11
			end

			if arg_26_1.time_ >= var_29_9 + var_29_10 and arg_26_1.time_ < var_29_9 + var_29_10 + arg_29_0 then
				local var_29_12 = Color.New(0, 0, 0)

				arg_26_1.mask_.enabled = false
				var_29_12.a = 0
				arg_26_1.mask_.color = var_29_12
			end

			if 0.833333333333334 < arg_26_1.time_ and arg_26_1.time_ <= 0.833333333333334 + arg_29_0 then
				arg_26_1.cswbg_:SetActive(false)
			end

			if 0.833333333333334 < arg_26_1.time_ and arg_26_1.time_ <= 0.833333333333334 + arg_29_0 then
				arg_26_1.fswbg_:SetActive(false)
				arg_26_1.dialog_:SetActive(false)
				SetActive(arg_26_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_26_1:ShowNextGo(false)
			end

			local var_29_13 = 1

			arg_26_1.isInRecall_ = true

			if var_29_13 < arg_26_1.time_ and arg_26_1.time_ <= var_29_13 + arg_29_0 then
				arg_26_1.screenFilterGo_:SetActive(true)

				arg_26_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_grey.asset")
				arg_26_1.hightColor1 = Color.New(0.8980392, 0.8980392, 0.8980392)
				arg_26_1.hightColor2 = Color.New(0.3411765, 0.3411765, 0.3411765)

				for iter_29_2, iter_29_3 in pairs(arg_26_1.actors_) do
					for iter_29_4, iter_29_5 in ipairs((iter_29_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_29_5.color = iter_29_5.color.r > 0.51 and Color.New(0.8980392, 0.8980392, 0.8980392) or Color.New(0.3411765, 0.3411765, 0.3411765)
					end
				end
			end

			local var_29_14 = 0.0666666666666667

			if var_29_13 <= arg_26_1.time_ and arg_26_1.time_ < var_29_13 + var_29_14 then
				arg_26_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, (arg_26_1.time_ - var_29_13) / var_29_14)
			end

			if arg_26_1.time_ >= var_29_13 + var_29_14 and arg_26_1.time_ < var_29_13 + var_29_14 + arg_29_0 then
				arg_26_1.screenFilterEffect_.weight = 1
			end

			if 0.05 < arg_26_1.time_ and arg_26_1.time_ <= 0.05 + arg_29_0 then
				arg_26_1:AudioAction("stop", "effect", "se_story_1310", "se_story_1310_wind", "")
			end

			if 0 < arg_26_1.time_ and arg_26_1.time_ <= 0 + arg_29_0 then
				arg_26_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_29_18 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_26_1.bgmTxt_.text ~= var_29_18 and arg_26_1.bgmTxt_.text ~= "" then
						if arg_26_1.bgmTxt2_.text ~= "" then
							arg_26_1.bgmTxt_.text = arg_26_1.bgmTxt2_.text
						end

						arg_26_1.bgmTxt2_.text = var_29_18

						arg_26_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_26_1.bgmTxt_.text = var_29_18
						arg_26_1.bgmTxt2_.text = var_29_18
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

			if 0.733333333333333 < arg_26_1.time_ and arg_26_1.time_ <= 0.733333333333333 + arg_29_0 then
				arg_26_1:AudioAction("play", "music", "bgm_activity_3_10_story_scheme_1", "bgm_activity_3_10_story_scheme_1", "bgm_activity_3_10_story_scheme_1.awb")

				local var_29_21 = manager.audio:GetAudioName("bgm_activity_3_10_story_scheme_1", "bgm_activity_3_10_story_scheme_1")

				if "" ~= "" then
					if arg_26_1.bgmTxt_.text ~= var_29_21 and arg_26_1.bgmTxt_.text ~= "" then
						if arg_26_1.bgmTxt2_.text ~= "" then
							arg_26_1.bgmTxt_.text = arg_26_1.bgmTxt2_.text
						end

						arg_26_1.bgmTxt2_.text = var_29_21

						arg_26_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_26_1.bgmTxt_.text = var_29_21
						arg_26_1.bgmTxt2_.text = var_29_21
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

			local var_29_22 = 3
			local var_29_23 = 1.05

			if 3 < arg_26_1.time_ and arg_26_1.time_ <= var_29_22 + arg_29_0 then
				arg_26_1.talkMaxDuration = 0

				arg_26_1.dialog_:SetActive(true)

				arg_26_1.dialogCg_.alpha = 0

				local var_29_24 = LeanTween.value(arg_26_1.dialog_, 0, 1, 0.3)

				var_29_24:setOnUpdate(LuaHelper.FloatAction(function(arg_32_0)
					arg_26_1.dialogCg_.alpha = arg_32_0
				end))
				var_29_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_26_1.dialog_)
					var_29_24:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_26_1.duration_ = arg_26_1.duration_ + 0.3

				SetActive(arg_26_1.leftNameGo_, false)

				arg_26_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_26_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_26_1:RecordName(arg_26_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_26_1.iconTrs_.gameObject, false)
				arg_26_1.callingController_:SetSelectedState("normal")

				local var_29_25 = arg_26_1:FormatText(arg_26_1:GetWordFromCfg(417212007).content)

				arg_26_1.text_.text = var_29_25

				LuaForUtil.ClearLinePrefixSymbol(arg_26_1.text_)

				local var_29_27 = 42 <= 0 and var_29_23 or var_29_23 * (utf8.len(var_29_25) / 42)

				if (42 <= 0 and var_29_23 or var_29_23 * (utf8.len(var_29_25) / 42)) > 0 and var_29_23 < var_29_27 then
					arg_26_1.talkMaxDuration = var_29_27
					var_29_22 = var_29_22 + 0.3

					if var_29_27 + var_29_22 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_27 + var_29_22
					end
				end

				arg_26_1.text_.text = var_29_25
				arg_26_1.typewritter.percent = 0

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(false)
				arg_26_1:RecordContent(arg_26_1.text_.text)
			end

			local var_29_28 = var_29_22 + 0.3
			local var_29_29 = math.max(var_29_23, arg_26_1.talkMaxDuration)

			if var_29_22 + 0.3 <= arg_26_1.time_ and arg_26_1.time_ < var_29_28 + var_29_29 then
				arg_26_1.typewritter.percent = (arg_26_1.time_ - var_29_28) / var_29_29

				arg_26_1.typewritter:SetDirty()
			end

			if arg_26_1.time_ >= var_29_28 + var_29_29 and arg_26_1.time_ < var_29_28 + var_29_29 + arg_29_0 then
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
			local var_37_0 = 1.325

			if 0 < arg_34_1.time_ and arg_34_1.time_ <= 0 + arg_37_0 then
				arg_34_1.talkMaxDuration = 0
				arg_34_1.dialogCg_.alpha = 1

				arg_34_1.dialog_:SetActive(true)
				SetActive(arg_34_1.leftNameGo_, false)

				arg_34_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_34_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_34_1:RecordName(arg_34_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_34_1.iconTrs_.gameObject, false)
				arg_34_1.callingController_:SetSelectedState("normal")

				local var_37_1 = arg_34_1:FormatText(arg_34_1:GetWordFromCfg(417212008).content)

				arg_34_1.text_.text = var_37_1

				LuaForUtil.ClearLinePrefixSymbol(arg_34_1.text_)

				local var_37_3 = 53 <= 0 and var_37_0 or var_37_0 * (utf8.len(var_37_1) / 53)

				if (53 <= 0 and var_37_0 or var_37_0 * (utf8.len(var_37_1) / 53)) > 0 and var_37_0 < var_37_3 then
					arg_34_1.talkMaxDuration = var_37_3

					if var_37_3 + 0 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_3 + 0
					end
				end

				arg_34_1.text_.text = var_37_1
				arg_34_1.typewritter.percent = 0

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(false)
				arg_34_1:RecordContent(arg_34_1.text_.text)
			end

			local var_37_4 = math.max(var_37_0, arg_34_1.talkMaxDuration)

			if 0 <= arg_34_1.time_ and arg_34_1.time_ < 0 + var_37_4 then
				arg_34_1.typewritter.percent = (arg_34_1.time_ - 0) / var_37_4

				arg_34_1.typewritter:SetDirty()
			end

			if arg_34_1.time_ >= 0 + var_37_4 and arg_34_1.time_ < 0 + var_37_4 + arg_37_0 then
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
			if arg_38_1.actors_["10113"] == nil then
				local var_41_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10113")

				if not isNil(var_41_0) then
					local var_41_1 = Object.Instantiate(var_41_0, arg_38_1.canvasGo_.transform)

					var_41_1.transform:SetSiblingIndex(1)

					var_41_1.name = "10113"
					var_41_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_38_1.actors_["10113"] = var_41_1

					if arg_38_1.isInRecall_ then
						for iter_41_0, iter_41_1 in ipairs((var_41_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_41_1.color = arg_38_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_41_2 = arg_38_1.actors_["10113"]

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= 0 + arg_41_0 and not isNil(var_41_2) and arg_38_1.var_.actorSpriteComps10113 == nil then
				arg_38_1.var_.actorSpriteComps10113 = var_41_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_41_3 = 0.2

			if 0 <= arg_38_1.time_ and arg_38_1.time_ < 0 + var_41_3 and not isNil(var_41_2) then
				if arg_38_1.var_.actorSpriteComps10113 then
					for iter_41_2, iter_41_3 in pairs(arg_38_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_41_3 then
							if arg_38_1.isInRecall_ then
								iter_41_3.color = Color.New(Mathf.Lerp(iter_41_3.color.r, arg_38_1.hightColor1.r, (arg_38_1.time_ - 0) / var_41_3), Mathf.Lerp(iter_41_3.color.g, arg_38_1.hightColor1.g, (arg_38_1.time_ - 0) / var_41_3), (Mathf.Lerp(iter_41_3.color.b, arg_38_1.hightColor1.b, (arg_38_1.time_ - 0) / var_41_3)))
							else
								local var_41_4 = Mathf.Lerp(iter_41_3.color.r, 1, (arg_38_1.time_ - 0) / var_41_3)

								iter_41_3.color = Color.New(var_41_4, var_41_4, var_41_4)
							end
						end
					end
				end
			end

			if arg_38_1.time_ >= 0 + var_41_3 and arg_38_1.time_ < 0 + var_41_3 + arg_41_0 and not isNil(var_41_2) and arg_38_1.var_.actorSpriteComps10113 then
				for iter_41_4, iter_41_5 in pairs(arg_38_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_41_5 then
						iter_41_5.color = arg_38_1.isInRecall_ and (arg_38_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_38_1.var_.actorSpriteComps10113 = nil
			end

			local var_41_5 = arg_38_1.actors_["10113"].transform

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= 0 + arg_41_0 then
				arg_38_1.var_.moveOldPos10113 = var_41_5.localPosition
				var_41_5.localScale = Vector3.New(1, 1, 1)

				arg_38_1:CheckSpriteTmpPos("10113", 3)

				for iter_41_6 = 0, var_41_5.childCount - 1 do
					local var_41_6 = var_41_5:GetChild(iter_41_6)

					if var_41_6.name == "split_6" or not string.find(var_41_6.name, "split") then
						var_41_6.gameObject:SetActive(true)
					else
						var_41_6.gameObject:SetActive(false)
					end
				end
			end

			local var_41_7 = 0.001

			if 0 <= arg_38_1.time_ and arg_38_1.time_ < 0 + var_41_7 then
				var_41_5.localPosition = Vector3.Lerp(arg_38_1.var_.moveOldPos10113, Vector3.New(-30.38, -328.4, -517.4), (arg_38_1.time_ - 0) / var_41_7)
			end

			if arg_38_1.time_ >= 0 + var_41_7 and arg_38_1.time_ < 0 + var_41_7 + arg_41_0 then
				var_41_5.localPosition = Vector3.New(-30.38, -328.4, -517.4)
			end

			local var_41_8 = 0
			local var_41_9 = 0.275

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= var_41_8 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0
				arg_38_1.dialogCg_.alpha = 1

				arg_38_1.dialog_:SetActive(true)
				SetActive(arg_38_1.leftNameGo_, true)

				arg_38_1.leftNameTxt_.text = arg_38_1:FormatText(StoryNameCfg[1117].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_38_1.leftNameTxt_.transform)

				arg_38_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_38_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_38_1:RecordName(arg_38_1.leftNameTxt_.text)
				SetActive(arg_38_1.iconTrs_.gameObject, false)
				arg_38_1.callingController_:SetSelectedState("normal")

				local var_41_10 = arg_38_1:GetWordFromCfg(417212009)
				local var_41_11 = arg_38_1:FormatText(var_41_10.content)

				arg_38_1.text_.text = var_41_11

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_13 = 11 <= 0 and var_41_9 or var_41_9 * (utf8.len(var_41_11) / 11)

				if (11 <= 0 and var_41_9 or var_41_9 * (utf8.len(var_41_11) / 11)) > 0 and var_41_9 < var_41_13 then
					arg_38_1.talkMaxDuration = var_41_13

					if var_41_13 + var_41_8 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_13 + var_41_8
					end
				end

				arg_38_1.text_.text = var_41_11
				arg_38_1.typewritter.percent = 0

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417212", "417212009", "story_v_out_417212.awb") ~= 0 then
					local var_41_14 = manager.audio:GetVoiceLength("story_v_out_417212", "417212009", "story_v_out_417212.awb") / 1000

					if var_41_14 + var_41_8 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_14 + var_41_8
					end

					if var_41_10.prefab_name ~= "" and arg_38_1.actors_[var_41_10.prefab_name] ~= nil then
						local var_41_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_38_1.actors_[var_41_10.prefab_name].transform, "story_v_out_417212", "417212009", "story_v_out_417212.awb")

						arg_38_1:RecordAudio("417212009", var_41_15)
						arg_38_1:RecordAudio("417212009", var_41_15)
					else
						arg_38_1:AudioAction("play", "voice", "story_v_out_417212", "417212009", "story_v_out_417212.awb")
					end

					arg_38_1:RecordHistoryTalkVoice("story_v_out_417212", "417212009", "story_v_out_417212.awb")
				end

				arg_38_1:RecordContent(arg_38_1.text_.text)
			end

			local var_41_16 = math.max(var_41_9, arg_38_1.talkMaxDuration)

			if var_41_8 <= arg_38_1.time_ and arg_38_1.time_ < var_41_8 + var_41_16 then
				arg_38_1.typewritter.percent = (arg_38_1.time_ - var_41_8) / var_41_16

				arg_38_1.typewritter:SetDirty()
			end

			if arg_38_1.time_ >= var_41_8 + var_41_16 and arg_38_1.time_ < var_41_8 + var_41_16 + arg_41_0 then
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
			if arg_42_1.actors_["10128"] == nil then
				local var_45_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10128")

				if not isNil(var_45_0) then
					local var_45_1 = Object.Instantiate(var_45_0, arg_42_1.canvasGo_.transform)

					var_45_1.transform:SetSiblingIndex(1)

					var_45_1.name = "10128"
					var_45_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_42_1.actors_["10128"] = var_45_1

					if arg_42_1.isInRecall_ then
						for iter_45_0, iter_45_1 in ipairs((var_45_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_45_1.color = arg_42_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_45_2 = arg_42_1.actors_["10128"]

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 and not isNil(var_45_2) and arg_42_1.var_.actorSpriteComps10128 == nil then
				arg_42_1.var_.actorSpriteComps10128 = var_45_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_45_3 = 0.2

			if 0 <= arg_42_1.time_ and arg_42_1.time_ < 0 + var_45_3 and not isNil(var_45_2) then
				if arg_42_1.var_.actorSpriteComps10128 then
					for iter_45_2, iter_45_3 in pairs(arg_42_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_45_3 then
							if arg_42_1.isInRecall_ then
								iter_45_3.color = Color.New(Mathf.Lerp(iter_45_3.color.r, arg_42_1.hightColor1.r, (arg_42_1.time_ - 0) / var_45_3), Mathf.Lerp(iter_45_3.color.g, arg_42_1.hightColor1.g, (arg_42_1.time_ - 0) / var_45_3), (Mathf.Lerp(iter_45_3.color.b, arg_42_1.hightColor1.b, (arg_42_1.time_ - 0) / var_45_3)))
							else
								local var_45_4 = Mathf.Lerp(iter_45_3.color.r, 1, (arg_42_1.time_ - 0) / var_45_3)

								iter_45_3.color = Color.New(var_45_4, var_45_4, var_45_4)
							end
						end
					end
				end
			end

			if arg_42_1.time_ >= 0 + var_45_3 and arg_42_1.time_ < 0 + var_45_3 + arg_45_0 and not isNil(var_45_2) and arg_42_1.var_.actorSpriteComps10128 then
				for iter_45_4, iter_45_5 in pairs(arg_42_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_45_5 then
						iter_45_5.color = arg_42_1.isInRecall_ and (arg_42_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_42_1.var_.actorSpriteComps10128 = nil
			end

			local var_45_5 = arg_42_1.actors_["10113"]

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 and not isNil(var_45_5) and arg_42_1.var_.actorSpriteComps10113 == nil then
				arg_42_1.var_.actorSpriteComps10113 = var_45_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_45_6 = 0.2

			if 0 <= arg_42_1.time_ and arg_42_1.time_ < 0 + var_45_6 and not isNil(var_45_5) then
				if arg_42_1.var_.actorSpriteComps10113 then
					for iter_45_6, iter_45_7 in pairs(arg_42_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_45_7 then
							if arg_42_1.isInRecall_ then
								iter_45_7.color = Color.New(Mathf.Lerp(iter_45_7.color.r, arg_42_1.hightColor2.r, (arg_42_1.time_ - 0) / var_45_6), Mathf.Lerp(iter_45_7.color.g, arg_42_1.hightColor2.g, (arg_42_1.time_ - 0) / var_45_6), (Mathf.Lerp(iter_45_7.color.b, arg_42_1.hightColor2.b, (arg_42_1.time_ - 0) / var_45_6)))
							else
								local var_45_7 = Mathf.Lerp(iter_45_7.color.r, 0.5, (arg_42_1.time_ - 0) / var_45_6)

								iter_45_7.color = Color.New(var_45_7, var_45_7, var_45_7)
							end
						end
					end
				end
			end

			if arg_42_1.time_ >= 0 + var_45_6 and arg_42_1.time_ < 0 + var_45_6 + arg_45_0 and not isNil(var_45_5) and arg_42_1.var_.actorSpriteComps10113 then
				for iter_45_8, iter_45_9 in pairs(arg_42_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_45_9 then
						iter_45_9.color = arg_42_1.isInRecall_ and (arg_42_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_42_1.var_.actorSpriteComps10113 = nil
			end

			local var_45_8 = arg_42_1.actors_["10113"].transform

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 then
				arg_42_1.var_.moveOldPos10113 = var_45_8.localPosition
				var_45_8.localScale = Vector3.New(1, 1, 1)

				arg_42_1:CheckSpriteTmpPos("10113", 2)

				for iter_45_10 = 0, var_45_8.childCount - 1 do
					local var_45_9 = var_45_8:GetChild(iter_45_10)

					if var_45_9.name == "" or not string.find(var_45_9.name, "split") then
						var_45_9.gameObject:SetActive(true)
					else
						var_45_9.gameObject:SetActive(false)
					end
				end
			end

			local var_45_10 = 0.001

			if 0 <= arg_42_1.time_ and arg_42_1.time_ < 0 + var_45_10 then
				var_45_8.localPosition = Vector3.Lerp(arg_42_1.var_.moveOldPos10113, Vector3.New(-403.26, -328.4, -517.4), (arg_42_1.time_ - 0) / var_45_10)
			end

			if arg_42_1.time_ >= 0 + var_45_10 and arg_42_1.time_ < 0 + var_45_10 + arg_45_0 then
				var_45_8.localPosition = Vector3.New(-403.26, -328.4, -517.4)
			end

			local var_45_11 = arg_42_1.actors_["10128"].transform

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 then
				arg_42_1.var_.moveOldPos10128 = var_45_11.localPosition
				var_45_11.localScale = Vector3.New(1, 1, 1)

				arg_42_1:CheckSpriteTmpPos("10128", 4)

				for iter_45_11 = 0, var_45_11.childCount - 1 do
					local var_45_12 = var_45_11:GetChild(iter_45_11)

					if var_45_12.name == "split_6" or not string.find(var_45_12.name, "split") then
						var_45_12.gameObject:SetActive(true)
					else
						var_45_12.gameObject:SetActive(false)
					end
				end
			end

			local var_45_13 = 0.001

			if 0 <= arg_42_1.time_ and arg_42_1.time_ < 0 + var_45_13 then
				var_45_11.localPosition = Vector3.Lerp(arg_42_1.var_.moveOldPos10128, Vector3.New(390, -347, -300), (arg_42_1.time_ - 0) / var_45_13)
			end

			if arg_42_1.time_ >= 0 + var_45_13 and arg_42_1.time_ < 0 + var_45_13 + arg_45_0 then
				var_45_11.localPosition = Vector3.New(390, -347, -300)
			end

			local var_45_14 = 0
			local var_45_15 = 0.5

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= var_45_14 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0
				arg_42_1.dialogCg_.alpha = 1

				arg_42_1.dialog_:SetActive(true)
				SetActive(arg_42_1.leftNameGo_, true)

				arg_42_1.leftNameTxt_.text = arg_42_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_42_1.leftNameTxt_.transform)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1.leftNameTxt_.text)
				SetActive(arg_42_1.iconTrs_.gameObject, false)
				arg_42_1.callingController_:SetSelectedState("normal")

				local var_45_16 = arg_42_1:GetWordFromCfg(417212010)
				local var_45_17 = arg_42_1:FormatText(var_45_16.content)

				arg_42_1.text_.text = var_45_17

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_19 = 20 <= 0 and var_45_15 or var_45_15 * (utf8.len(var_45_17) / 20)

				if (20 <= 0 and var_45_15 or var_45_15 * (utf8.len(var_45_17) / 20)) > 0 and var_45_15 < var_45_19 then
					arg_42_1.talkMaxDuration = var_45_19

					if var_45_19 + var_45_14 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_19 + var_45_14
					end
				end

				arg_42_1.text_.text = var_45_17
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417212", "417212010", "story_v_out_417212.awb") ~= 0 then
					local var_45_20 = manager.audio:GetVoiceLength("story_v_out_417212", "417212010", "story_v_out_417212.awb") / 1000

					if var_45_20 + var_45_14 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_20 + var_45_14
					end

					if var_45_16.prefab_name ~= "" and arg_42_1.actors_[var_45_16.prefab_name] ~= nil then
						local var_45_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_42_1.actors_[var_45_16.prefab_name].transform, "story_v_out_417212", "417212010", "story_v_out_417212.awb")

						arg_42_1:RecordAudio("417212010", var_45_21)
						arg_42_1:RecordAudio("417212010", var_45_21)
					else
						arg_42_1:AudioAction("play", "voice", "story_v_out_417212", "417212010", "story_v_out_417212.awb")
					end

					arg_42_1:RecordHistoryTalkVoice("story_v_out_417212", "417212010", "story_v_out_417212.awb")
				end

				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_22 = math.max(var_45_15, arg_42_1.talkMaxDuration)

			if var_45_14 <= arg_42_1.time_ and arg_42_1.time_ < var_45_14 + var_45_22 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - var_45_14) / var_45_22

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= var_45_14 + var_45_22 and arg_42_1.time_ < var_45_14 + var_45_22 + arg_45_0 then
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
			if 0 < arg_46_1.time_ and arg_46_1.time_ <= 0 + arg_49_0 and not isNil(arg_46_1.actors_["10113"]) and arg_46_1.var_.actorSpriteComps10113 == nil then
				arg_46_1.var_.actorSpriteComps10113 = arg_46_1.actors_["10113"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_49_0 = 0.2

			if 0 <= arg_46_1.time_ and arg_46_1.time_ < 0 + var_49_0 and not isNil(arg_46_1.actors_["10113"]) then
				if arg_46_1.var_.actorSpriteComps10113 then
					for iter_49_0, iter_49_1 in pairs(arg_46_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_49_1 then
							if arg_46_1.isInRecall_ then
								iter_49_1.color = Color.New(Mathf.Lerp(iter_49_1.color.r, arg_46_1.hightColor1.r, (arg_46_1.time_ - 0) / var_49_0), Mathf.Lerp(iter_49_1.color.g, arg_46_1.hightColor1.g, (arg_46_1.time_ - 0) / var_49_0), (Mathf.Lerp(iter_49_1.color.b, arg_46_1.hightColor1.b, (arg_46_1.time_ - 0) / var_49_0)))
							else
								local var_49_1 = Mathf.Lerp(iter_49_1.color.r, 1, (arg_46_1.time_ - 0) / var_49_0)

								iter_49_1.color = Color.New(var_49_1, var_49_1, var_49_1)
							end
						end
					end
				end
			end

			if arg_46_1.time_ >= 0 + var_49_0 and arg_46_1.time_ < 0 + var_49_0 + arg_49_0 and not isNil(arg_46_1.actors_["10113"]) and arg_46_1.var_.actorSpriteComps10113 then
				for iter_49_2, iter_49_3 in pairs(arg_46_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_49_3 then
						iter_49_3.color = arg_46_1.isInRecall_ and (arg_46_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_46_1.var_.actorSpriteComps10113 = nil
			end

			local var_49_2 = arg_46_1.actors_["10128"]

			if 0 < arg_46_1.time_ and arg_46_1.time_ <= 0 + arg_49_0 and not isNil(var_49_2) and arg_46_1.var_.actorSpriteComps10128 == nil then
				arg_46_1.var_.actorSpriteComps10128 = var_49_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_49_3 = 0.2

			if 0 <= arg_46_1.time_ and arg_46_1.time_ < 0 + var_49_3 and not isNil(var_49_2) then
				if arg_46_1.var_.actorSpriteComps10128 then
					for iter_49_4, iter_49_5 in pairs(arg_46_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_49_5 then
							if arg_46_1.isInRecall_ then
								iter_49_5.color = Color.New(Mathf.Lerp(iter_49_5.color.r, arg_46_1.hightColor2.r, (arg_46_1.time_ - 0) / var_49_3), Mathf.Lerp(iter_49_5.color.g, arg_46_1.hightColor2.g, (arg_46_1.time_ - 0) / var_49_3), (Mathf.Lerp(iter_49_5.color.b, arg_46_1.hightColor2.b, (arg_46_1.time_ - 0) / var_49_3)))
							else
								local var_49_4 = Mathf.Lerp(iter_49_5.color.r, 0.5, (arg_46_1.time_ - 0) / var_49_3)

								iter_49_5.color = Color.New(var_49_4, var_49_4, var_49_4)
							end
						end
					end
				end
			end

			if arg_46_1.time_ >= 0 + var_49_3 and arg_46_1.time_ < 0 + var_49_3 + arg_49_0 and not isNil(var_49_2) and arg_46_1.var_.actorSpriteComps10128 then
				for iter_49_6, iter_49_7 in pairs(arg_46_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_49_7 then
						iter_49_7.color = arg_46_1.isInRecall_ and (arg_46_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_46_1.var_.actorSpriteComps10128 = nil
			end

			local var_49_5 = 0
			local var_49_6 = 0.775

			if 0 < arg_46_1.time_ and arg_46_1.time_ <= var_49_5 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0
				arg_46_1.dialogCg_.alpha = 1

				arg_46_1.dialog_:SetActive(true)
				SetActive(arg_46_1.leftNameGo_, true)

				arg_46_1.leftNameTxt_.text = arg_46_1:FormatText(StoryNameCfg[1117].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_46_1.leftNameTxt_.transform)

				arg_46_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_46_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_46_1:RecordName(arg_46_1.leftNameTxt_.text)
				SetActive(arg_46_1.iconTrs_.gameObject, false)
				arg_46_1.callingController_:SetSelectedState("normal")

				local var_49_7 = arg_46_1:GetWordFromCfg(417212011)
				local var_49_8 = arg_46_1:FormatText(var_49_7.content)

				arg_46_1.text_.text = var_49_8

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_10 = 31 <= 0 and var_49_6 or var_49_6 * (utf8.len(var_49_8) / 31)

				if (31 <= 0 and var_49_6 or var_49_6 * (utf8.len(var_49_8) / 31)) > 0 and var_49_6 < var_49_10 then
					arg_46_1.talkMaxDuration = var_49_10

					if var_49_10 + var_49_5 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_10 + var_49_5
					end
				end

				arg_46_1.text_.text = var_49_8
				arg_46_1.typewritter.percent = 0

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417212", "417212011", "story_v_out_417212.awb") ~= 0 then
					local var_49_11 = manager.audio:GetVoiceLength("story_v_out_417212", "417212011", "story_v_out_417212.awb") / 1000

					if var_49_11 + var_49_5 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_11 + var_49_5
					end

					if var_49_7.prefab_name ~= "" and arg_46_1.actors_[var_49_7.prefab_name] ~= nil then
						local var_49_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_46_1.actors_[var_49_7.prefab_name].transform, "story_v_out_417212", "417212011", "story_v_out_417212.awb")

						arg_46_1:RecordAudio("417212011", var_49_12)
						arg_46_1:RecordAudio("417212011", var_49_12)
					else
						arg_46_1:AudioAction("play", "voice", "story_v_out_417212", "417212011", "story_v_out_417212.awb")
					end

					arg_46_1:RecordHistoryTalkVoice("story_v_out_417212", "417212011", "story_v_out_417212.awb")
				end

				arg_46_1:RecordContent(arg_46_1.text_.text)
			end

			local var_49_13 = math.max(var_49_6, arg_46_1.talkMaxDuration)

			if var_49_5 <= arg_46_1.time_ and arg_46_1.time_ < var_49_5 + var_49_13 then
				arg_46_1.typewritter.percent = (arg_46_1.time_ - var_49_5) / var_49_13

				arg_46_1.typewritter:SetDirty()
			end

			if arg_46_1.time_ >= var_49_5 + var_49_13 and arg_46_1.time_ < var_49_5 + var_49_13 + arg_49_0 then
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
			local var_53_0 = 0.975

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, true)

				arg_50_1.leftNameTxt_.text = arg_50_1:FormatText(StoryNameCfg[1117].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_50_1.leftNameTxt_.transform)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1.leftNameTxt_.text)
				SetActive(arg_50_1.iconTrs_.gameObject, false)
				arg_50_1.callingController_:SetSelectedState("normal")

				local var_53_1 = arg_50_1:GetWordFromCfg(417212012)
				local var_53_2 = arg_50_1:FormatText(var_53_1.content)

				arg_50_1.text_.text = var_53_2

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_4 = 39 <= 0 and var_53_0 or var_53_0 * (utf8.len(var_53_2) / 39)

				if (39 <= 0 and var_53_0 or var_53_0 * (utf8.len(var_53_2) / 39)) > 0 and var_53_0 < var_53_4 then
					arg_50_1.talkMaxDuration = var_53_4

					if var_53_4 + 0 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_4 + 0
					end
				end

				arg_50_1.text_.text = var_53_2
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417212", "417212012", "story_v_out_417212.awb") ~= 0 then
					local var_53_5 = manager.audio:GetVoiceLength("story_v_out_417212", "417212012", "story_v_out_417212.awb") / 1000

					if var_53_5 + 0 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_5 + 0
					end

					if var_53_1.prefab_name ~= "" and arg_50_1.actors_[var_53_1.prefab_name] ~= nil then
						local var_53_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_50_1.actors_[var_53_1.prefab_name].transform, "story_v_out_417212", "417212012", "story_v_out_417212.awb")

						arg_50_1:RecordAudio("417212012", var_53_6)
						arg_50_1:RecordAudio("417212012", var_53_6)
					else
						arg_50_1:AudioAction("play", "voice", "story_v_out_417212", "417212012", "story_v_out_417212.awb")
					end

					arg_50_1:RecordHistoryTalkVoice("story_v_out_417212", "417212012", "story_v_out_417212.awb")
				end

				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_7 = math.max(var_53_0, arg_50_1.talkMaxDuration)

			if 0 <= arg_50_1.time_ and arg_50_1.time_ < 0 + var_53_7 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - 0) / var_53_7

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= 0 + var_53_7 and arg_50_1.time_ < 0 + var_53_7 + arg_53_0 then
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
			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 then
				arg_54_1.var_.moveOldPos10113 = arg_54_1.actors_["10113"].transform.localPosition
				arg_54_1.actors_["10113"].transform.localScale = Vector3.New(1, 1, 1)

				arg_54_1:CheckSpriteTmpPos("10113", 2)

				for iter_57_0 = 0, arg_54_1.actors_["10113"].transform.childCount - 1 do
					local var_57_0 = arg_54_1.actors_["10113"].transform:GetChild(iter_57_0)

					if var_57_0.name == "split_3" or not string.find(var_57_0.name, "split") then
						var_57_0.gameObject:SetActive(true)
					else
						var_57_0.gameObject:SetActive(false)
					end
				end
			end

			local var_57_1 = 0.001

			if 0 <= arg_54_1.time_ and arg_54_1.time_ < 0 + var_57_1 then
				arg_54_1.actors_["10113"].transform.localPosition = Vector3.Lerp(arg_54_1.var_.moveOldPos10113, Vector3.New(-403.26, -328.4, -517.4), (arg_54_1.time_ - 0) / var_57_1)
			end

			if arg_54_1.time_ >= 0 + var_57_1 and arg_54_1.time_ < 0 + var_57_1 + arg_57_0 then
				arg_54_1.actors_["10113"].transform.localPosition = Vector3.New(-403.26, -328.4, -517.4)
			end

			local var_57_2 = 0
			local var_57_3 = 0.825

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= var_57_2 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, true)

				arg_54_1.leftNameTxt_.text = arg_54_1:FormatText(StoryNameCfg[1117].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_54_1.leftNameTxt_.transform)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1.leftNameTxt_.text)
				SetActive(arg_54_1.iconTrs_.gameObject, false)
				arg_54_1.callingController_:SetSelectedState("normal")

				local var_57_4 = arg_54_1:GetWordFromCfg(417212013)
				local var_57_5 = arg_54_1:FormatText(var_57_4.content)

				arg_54_1.text_.text = var_57_5

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_7 = 33 <= 0 and var_57_3 or var_57_3 * (utf8.len(var_57_5) / 33)

				if (33 <= 0 and var_57_3 or var_57_3 * (utf8.len(var_57_5) / 33)) > 0 and var_57_3 < var_57_7 then
					arg_54_1.talkMaxDuration = var_57_7

					if var_57_7 + var_57_2 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_7 + var_57_2
					end
				end

				arg_54_1.text_.text = var_57_5
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417212", "417212013", "story_v_out_417212.awb") ~= 0 then
					local var_57_8 = manager.audio:GetVoiceLength("story_v_out_417212", "417212013", "story_v_out_417212.awb") / 1000

					if var_57_8 + var_57_2 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_8 + var_57_2
					end

					if var_57_4.prefab_name ~= "" and arg_54_1.actors_[var_57_4.prefab_name] ~= nil then
						local var_57_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_54_1.actors_[var_57_4.prefab_name].transform, "story_v_out_417212", "417212013", "story_v_out_417212.awb")

						arg_54_1:RecordAudio("417212013", var_57_9)
						arg_54_1:RecordAudio("417212013", var_57_9)
					else
						arg_54_1:AudioAction("play", "voice", "story_v_out_417212", "417212013", "story_v_out_417212.awb")
					end

					arg_54_1:RecordHistoryTalkVoice("story_v_out_417212", "417212013", "story_v_out_417212.awb")
				end

				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_10 = math.max(var_57_3, arg_54_1.talkMaxDuration)

			if var_57_2 <= arg_54_1.time_ and arg_54_1.time_ < var_57_2 + var_57_10 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - var_57_2) / var_57_10

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= var_57_2 + var_57_10 and arg_54_1.time_ < var_57_2 + var_57_10 + arg_57_0 then
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
			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 and not isNil(arg_58_1.actors_["10128"]) and arg_58_1.var_.actorSpriteComps10128 == nil then
				arg_58_1.var_.actorSpriteComps10128 = arg_58_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_61_0 = 0.2

			if 0 <= arg_58_1.time_ and arg_58_1.time_ < 0 + var_61_0 and not isNil(arg_58_1.actors_["10128"]) then
				if arg_58_1.var_.actorSpriteComps10128 then
					for iter_61_0, iter_61_1 in pairs(arg_58_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_61_1 then
							if arg_58_1.isInRecall_ then
								iter_61_1.color = Color.New(Mathf.Lerp(iter_61_1.color.r, arg_58_1.hightColor1.r, (arg_58_1.time_ - 0) / var_61_0), Mathf.Lerp(iter_61_1.color.g, arg_58_1.hightColor1.g, (arg_58_1.time_ - 0) / var_61_0), (Mathf.Lerp(iter_61_1.color.b, arg_58_1.hightColor1.b, (arg_58_1.time_ - 0) / var_61_0)))
							else
								local var_61_1 = Mathf.Lerp(iter_61_1.color.r, 1, (arg_58_1.time_ - 0) / var_61_0)

								iter_61_1.color = Color.New(var_61_1, var_61_1, var_61_1)
							end
						end
					end
				end
			end

			if arg_58_1.time_ >= 0 + var_61_0 and arg_58_1.time_ < 0 + var_61_0 + arg_61_0 and not isNil(arg_58_1.actors_["10128"]) and arg_58_1.var_.actorSpriteComps10128 then
				for iter_61_2, iter_61_3 in pairs(arg_58_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_61_3 then
						iter_61_3.color = arg_58_1.isInRecall_ and (arg_58_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_58_1.var_.actorSpriteComps10128 = nil
			end

			local var_61_2 = arg_58_1.actors_["10113"]

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 and not isNil(var_61_2) and arg_58_1.var_.actorSpriteComps10113 == nil then
				arg_58_1.var_.actorSpriteComps10113 = var_61_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_61_3 = 0.2

			if 0 <= arg_58_1.time_ and arg_58_1.time_ < 0 + var_61_3 and not isNil(var_61_2) then
				if arg_58_1.var_.actorSpriteComps10113 then
					for iter_61_4, iter_61_5 in pairs(arg_58_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_61_5 then
							if arg_58_1.isInRecall_ then
								iter_61_5.color = Color.New(Mathf.Lerp(iter_61_5.color.r, arg_58_1.hightColor2.r, (arg_58_1.time_ - 0) / var_61_3), Mathf.Lerp(iter_61_5.color.g, arg_58_1.hightColor2.g, (arg_58_1.time_ - 0) / var_61_3), (Mathf.Lerp(iter_61_5.color.b, arg_58_1.hightColor2.b, (arg_58_1.time_ - 0) / var_61_3)))
							else
								local var_61_4 = Mathf.Lerp(iter_61_5.color.r, 0.5, (arg_58_1.time_ - 0) / var_61_3)

								iter_61_5.color = Color.New(var_61_4, var_61_4, var_61_4)
							end
						end
					end
				end
			end

			if arg_58_1.time_ >= 0 + var_61_3 and arg_58_1.time_ < 0 + var_61_3 + arg_61_0 and not isNil(var_61_2) and arg_58_1.var_.actorSpriteComps10113 then
				for iter_61_6, iter_61_7 in pairs(arg_58_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_61_7 then
						iter_61_7.color = arg_58_1.isInRecall_ and (arg_58_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_58_1.var_.actorSpriteComps10113 = nil
			end

			local var_61_5 = 0
			local var_61_6 = 0.525

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= var_61_5 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, true)

				arg_58_1.leftNameTxt_.text = arg_58_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, false)
				arg_58_1.callingController_:SetSelectedState("normal")

				local var_61_7 = arg_58_1:GetWordFromCfg(417212014)
				local var_61_8 = arg_58_1:FormatText(var_61_7.content)

				arg_58_1.text_.text = var_61_8

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_10 = 21 <= 0 and var_61_6 or var_61_6 * (utf8.len(var_61_8) / 21)

				if (21 <= 0 and var_61_6 or var_61_6 * (utf8.len(var_61_8) / 21)) > 0 and var_61_6 < var_61_10 then
					arg_58_1.talkMaxDuration = var_61_10

					if var_61_10 + var_61_5 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_10 + var_61_5
					end
				end

				arg_58_1.text_.text = var_61_8
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417212", "417212014", "story_v_out_417212.awb") ~= 0 then
					local var_61_11 = manager.audio:GetVoiceLength("story_v_out_417212", "417212014", "story_v_out_417212.awb") / 1000

					if var_61_11 + var_61_5 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_11 + var_61_5
					end

					if var_61_7.prefab_name ~= "" and arg_58_1.actors_[var_61_7.prefab_name] ~= nil then
						local var_61_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_58_1.actors_[var_61_7.prefab_name].transform, "story_v_out_417212", "417212014", "story_v_out_417212.awb")

						arg_58_1:RecordAudio("417212014", var_61_12)
						arg_58_1:RecordAudio("417212014", var_61_12)
					else
						arg_58_1:AudioAction("play", "voice", "story_v_out_417212", "417212014", "story_v_out_417212.awb")
					end

					arg_58_1:RecordHistoryTalkVoice("story_v_out_417212", "417212014", "story_v_out_417212.awb")
				end

				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_13 = math.max(var_61_6, arg_58_1.talkMaxDuration)

			if var_61_5 <= arg_58_1.time_ and arg_58_1.time_ < var_61_5 + var_61_13 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_5) / var_61_13

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_5 + var_61_13 and arg_58_1.time_ < var_61_5 + var_61_13 + arg_61_0 then
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
			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 and not isNil(arg_62_1.actors_["10113"]) and arg_62_1.var_.actorSpriteComps10113 == nil then
				arg_62_1.var_.actorSpriteComps10113 = arg_62_1.actors_["10113"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_65_0 = 0.2

			if 0 <= arg_62_1.time_ and arg_62_1.time_ < 0 + var_65_0 and not isNil(arg_62_1.actors_["10113"]) then
				if arg_62_1.var_.actorSpriteComps10113 then
					for iter_65_0, iter_65_1 in pairs(arg_62_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_65_1 then
							if arg_62_1.isInRecall_ then
								iter_65_1.color = Color.New(Mathf.Lerp(iter_65_1.color.r, arg_62_1.hightColor1.r, (arg_62_1.time_ - 0) / var_65_0), Mathf.Lerp(iter_65_1.color.g, arg_62_1.hightColor1.g, (arg_62_1.time_ - 0) / var_65_0), (Mathf.Lerp(iter_65_1.color.b, arg_62_1.hightColor1.b, (arg_62_1.time_ - 0) / var_65_0)))
							else
								local var_65_1 = Mathf.Lerp(iter_65_1.color.r, 1, (arg_62_1.time_ - 0) / var_65_0)

								iter_65_1.color = Color.New(var_65_1, var_65_1, var_65_1)
							end
						end
					end
				end
			end

			if arg_62_1.time_ >= 0 + var_65_0 and arg_62_1.time_ < 0 + var_65_0 + arg_65_0 and not isNil(arg_62_1.actors_["10113"]) and arg_62_1.var_.actorSpriteComps10113 then
				for iter_65_2, iter_65_3 in pairs(arg_62_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_65_3 then
						iter_65_3.color = arg_62_1.isInRecall_ and (arg_62_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_62_1.var_.actorSpriteComps10113 = nil
			end

			local var_65_2 = arg_62_1.actors_["10128"]

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 and not isNil(var_65_2) and arg_62_1.var_.actorSpriteComps10128 == nil then
				arg_62_1.var_.actorSpriteComps10128 = var_65_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_65_3 = 0.2

			if 0 <= arg_62_1.time_ and arg_62_1.time_ < 0 + var_65_3 and not isNil(var_65_2) then
				if arg_62_1.var_.actorSpriteComps10128 then
					for iter_65_4, iter_65_5 in pairs(arg_62_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_65_5 then
							if arg_62_1.isInRecall_ then
								iter_65_5.color = Color.New(Mathf.Lerp(iter_65_5.color.r, arg_62_1.hightColor2.r, (arg_62_1.time_ - 0) / var_65_3), Mathf.Lerp(iter_65_5.color.g, arg_62_1.hightColor2.g, (arg_62_1.time_ - 0) / var_65_3), (Mathf.Lerp(iter_65_5.color.b, arg_62_1.hightColor2.b, (arg_62_1.time_ - 0) / var_65_3)))
							else
								local var_65_4 = Mathf.Lerp(iter_65_5.color.r, 0.5, (arg_62_1.time_ - 0) / var_65_3)

								iter_65_5.color = Color.New(var_65_4, var_65_4, var_65_4)
							end
						end
					end
				end
			end

			if arg_62_1.time_ >= 0 + var_65_3 and arg_62_1.time_ < 0 + var_65_3 + arg_65_0 and not isNil(var_65_2) and arg_62_1.var_.actorSpriteComps10128 then
				for iter_65_6, iter_65_7 in pairs(arg_62_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_65_7 then
						iter_65_7.color = arg_62_1.isInRecall_ and (arg_62_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_62_1.var_.actorSpriteComps10128 = nil
			end

			local var_65_5 = arg_62_1.actors_["10113"].transform

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 then
				arg_62_1.var_.moveOldPos10113 = var_65_5.localPosition
				var_65_5.localScale = Vector3.New(1, 1, 1)

				arg_62_1:CheckSpriteTmpPos("10113", 2)

				for iter_65_8 = 0, var_65_5.childCount - 1 do
					local var_65_6 = var_65_5:GetChild(iter_65_8)

					if var_65_6.name == "split_1" or not string.find(var_65_6.name, "split") then
						var_65_6.gameObject:SetActive(true)
					else
						var_65_6.gameObject:SetActive(false)
					end
				end
			end

			local var_65_7 = 0.001

			if 0 <= arg_62_1.time_ and arg_62_1.time_ < 0 + var_65_7 then
				var_65_5.localPosition = Vector3.Lerp(arg_62_1.var_.moveOldPos10113, Vector3.New(-403.26, -328.4, -517.4), (arg_62_1.time_ - 0) / var_65_7)
			end

			if arg_62_1.time_ >= 0 + var_65_7 and arg_62_1.time_ < 0 + var_65_7 + arg_65_0 then
				var_65_5.localPosition = Vector3.New(-403.26, -328.4, -517.4)
			end

			local var_65_8 = 0
			local var_65_9 = 1.6

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= var_65_8 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, true)

				arg_62_1.leftNameTxt_.text = arg_62_1:FormatText(StoryNameCfg[1117].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_62_1.leftNameTxt_.transform)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1.leftNameTxt_.text)
				SetActive(arg_62_1.iconTrs_.gameObject, false)
				arg_62_1.callingController_:SetSelectedState("normal")

				local var_65_10 = arg_62_1:GetWordFromCfg(417212015)
				local var_65_11 = arg_62_1:FormatText(var_65_10.content)

				arg_62_1.text_.text = var_65_11

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_13 = 64 <= 0 and var_65_9 or var_65_9 * (utf8.len(var_65_11) / 64)

				if (64 <= 0 and var_65_9 or var_65_9 * (utf8.len(var_65_11) / 64)) > 0 and var_65_9 < var_65_13 then
					arg_62_1.talkMaxDuration = var_65_13

					if var_65_13 + var_65_8 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_13 + var_65_8
					end
				end

				arg_62_1.text_.text = var_65_11
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417212", "417212015", "story_v_out_417212.awb") ~= 0 then
					local var_65_14 = manager.audio:GetVoiceLength("story_v_out_417212", "417212015", "story_v_out_417212.awb") / 1000

					if var_65_14 + var_65_8 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_14 + var_65_8
					end

					if var_65_10.prefab_name ~= "" and arg_62_1.actors_[var_65_10.prefab_name] ~= nil then
						local var_65_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_62_1.actors_[var_65_10.prefab_name].transform, "story_v_out_417212", "417212015", "story_v_out_417212.awb")

						arg_62_1:RecordAudio("417212015", var_65_15)
						arg_62_1:RecordAudio("417212015", var_65_15)
					else
						arg_62_1:AudioAction("play", "voice", "story_v_out_417212", "417212015", "story_v_out_417212.awb")
					end

					arg_62_1:RecordHistoryTalkVoice("story_v_out_417212", "417212015", "story_v_out_417212.awb")
				end

				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_16 = math.max(var_65_9, arg_62_1.talkMaxDuration)

			if var_65_8 <= arg_62_1.time_ and arg_62_1.time_ < var_65_8 + var_65_16 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - var_65_8) / var_65_16

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= var_65_8 + var_65_16 and arg_62_1.time_ < var_65_8 + var_65_16 + arg_65_0 then
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
			local var_69_0 = 0.7

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				arg_66_1.leftNameTxt_.text = arg_66_1:FormatText(StoryNameCfg[1117].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_1 = arg_66_1:GetWordFromCfg(417212016)
				local var_69_2 = arg_66_1:FormatText(var_69_1.content)

				arg_66_1.text_.text = var_69_2

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_4 = 28 <= 0 and var_69_0 or var_69_0 * (utf8.len(var_69_2) / 28)

				if (28 <= 0 and var_69_0 or var_69_0 * (utf8.len(var_69_2) / 28)) > 0 and var_69_0 < var_69_4 then
					arg_66_1.talkMaxDuration = var_69_4

					if var_69_4 + 0 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_4 + 0
					end
				end

				arg_66_1.text_.text = var_69_2
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417212", "417212016", "story_v_out_417212.awb") ~= 0 then
					local var_69_5 = manager.audio:GetVoiceLength("story_v_out_417212", "417212016", "story_v_out_417212.awb") / 1000

					if var_69_5 + 0 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_5 + 0
					end

					if var_69_1.prefab_name ~= "" and arg_66_1.actors_[var_69_1.prefab_name] ~= nil then
						local var_69_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_66_1.actors_[var_69_1.prefab_name].transform, "story_v_out_417212", "417212016", "story_v_out_417212.awb")

						arg_66_1:RecordAudio("417212016", var_69_6)
						arg_66_1:RecordAudio("417212016", var_69_6)
					else
						arg_66_1:AudioAction("play", "voice", "story_v_out_417212", "417212016", "story_v_out_417212.awb")
					end

					arg_66_1:RecordHistoryTalkVoice("story_v_out_417212", "417212016", "story_v_out_417212.awb")
				end

				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_7 = math.max(var_69_0, arg_66_1.talkMaxDuration)

			if 0 <= arg_66_1.time_ and arg_66_1.time_ < 0 + var_69_7 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - 0) / var_69_7

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= 0 + var_69_7 and arg_66_1.time_ < 0 + var_69_7 + arg_69_0 then
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
			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 and not isNil(arg_70_1.actors_["10128"]) and arg_70_1.var_.actorSpriteComps10128 == nil then
				arg_70_1.var_.actorSpriteComps10128 = arg_70_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_73_0 = 0.2

			if 0 <= arg_70_1.time_ and arg_70_1.time_ < 0 + var_73_0 and not isNil(arg_70_1.actors_["10128"]) then
				if arg_70_1.var_.actorSpriteComps10128 then
					for iter_73_0, iter_73_1 in pairs(arg_70_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_73_1 then
							if arg_70_1.isInRecall_ then
								iter_73_1.color = Color.New(Mathf.Lerp(iter_73_1.color.r, arg_70_1.hightColor1.r, (arg_70_1.time_ - 0) / var_73_0), Mathf.Lerp(iter_73_1.color.g, arg_70_1.hightColor1.g, (arg_70_1.time_ - 0) / var_73_0), (Mathf.Lerp(iter_73_1.color.b, arg_70_1.hightColor1.b, (arg_70_1.time_ - 0) / var_73_0)))
							else
								local var_73_1 = Mathf.Lerp(iter_73_1.color.r, 1, (arg_70_1.time_ - 0) / var_73_0)

								iter_73_1.color = Color.New(var_73_1, var_73_1, var_73_1)
							end
						end
					end
				end
			end

			if arg_70_1.time_ >= 0 + var_73_0 and arg_70_1.time_ < 0 + var_73_0 + arg_73_0 and not isNil(arg_70_1.actors_["10128"]) and arg_70_1.var_.actorSpriteComps10128 then
				for iter_73_2, iter_73_3 in pairs(arg_70_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_73_3 then
						iter_73_3.color = arg_70_1.isInRecall_ and (arg_70_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_70_1.var_.actorSpriteComps10128 = nil
			end

			local var_73_2 = arg_70_1.actors_["10113"]

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 and not isNil(var_73_2) and arg_70_1.var_.actorSpriteComps10113 == nil then
				arg_70_1.var_.actorSpriteComps10113 = var_73_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_73_3 = 0.2

			if 0 <= arg_70_1.time_ and arg_70_1.time_ < 0 + var_73_3 and not isNil(var_73_2) then
				if arg_70_1.var_.actorSpriteComps10113 then
					for iter_73_4, iter_73_5 in pairs(arg_70_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_73_5 then
							if arg_70_1.isInRecall_ then
								iter_73_5.color = Color.New(Mathf.Lerp(iter_73_5.color.r, arg_70_1.hightColor2.r, (arg_70_1.time_ - 0) / var_73_3), Mathf.Lerp(iter_73_5.color.g, arg_70_1.hightColor2.g, (arg_70_1.time_ - 0) / var_73_3), (Mathf.Lerp(iter_73_5.color.b, arg_70_1.hightColor2.b, (arg_70_1.time_ - 0) / var_73_3)))
							else
								local var_73_4 = Mathf.Lerp(iter_73_5.color.r, 0.5, (arg_70_1.time_ - 0) / var_73_3)

								iter_73_5.color = Color.New(var_73_4, var_73_4, var_73_4)
							end
						end
					end
				end
			end

			if arg_70_1.time_ >= 0 + var_73_3 and arg_70_1.time_ < 0 + var_73_3 + arg_73_0 and not isNil(var_73_2) and arg_70_1.var_.actorSpriteComps10113 then
				for iter_73_6, iter_73_7 in pairs(arg_70_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_73_7 then
						iter_73_7.color = arg_70_1.isInRecall_ and (arg_70_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_70_1.var_.actorSpriteComps10113 = nil
			end

			local var_73_5 = 0
			local var_73_6 = 0.625

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= var_73_5 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, true)

				arg_70_1.leftNameTxt_.text = arg_70_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_70_1.leftNameTxt_.transform)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1.leftNameTxt_.text)
				SetActive(arg_70_1.iconTrs_.gameObject, false)
				arg_70_1.callingController_:SetSelectedState("normal")

				local var_73_7 = arg_70_1:GetWordFromCfg(417212017)
				local var_73_8 = arg_70_1:FormatText(var_73_7.content)

				arg_70_1.text_.text = var_73_8

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_10 = 25 <= 0 and var_73_6 or var_73_6 * (utf8.len(var_73_8) / 25)

				if (25 <= 0 and var_73_6 or var_73_6 * (utf8.len(var_73_8) / 25)) > 0 and var_73_6 < var_73_10 then
					arg_70_1.talkMaxDuration = var_73_10

					if var_73_10 + var_73_5 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_10 + var_73_5
					end
				end

				arg_70_1.text_.text = var_73_8
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417212", "417212017", "story_v_out_417212.awb") ~= 0 then
					local var_73_11 = manager.audio:GetVoiceLength("story_v_out_417212", "417212017", "story_v_out_417212.awb") / 1000

					if var_73_11 + var_73_5 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_11 + var_73_5
					end

					if var_73_7.prefab_name ~= "" and arg_70_1.actors_[var_73_7.prefab_name] ~= nil then
						local var_73_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_70_1.actors_[var_73_7.prefab_name].transform, "story_v_out_417212", "417212017", "story_v_out_417212.awb")

						arg_70_1:RecordAudio("417212017", var_73_12)
						arg_70_1:RecordAudio("417212017", var_73_12)
					else
						arg_70_1:AudioAction("play", "voice", "story_v_out_417212", "417212017", "story_v_out_417212.awb")
					end

					arg_70_1:RecordHistoryTalkVoice("story_v_out_417212", "417212017", "story_v_out_417212.awb")
				end

				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_13 = math.max(var_73_6, arg_70_1.talkMaxDuration)

			if var_73_5 <= arg_70_1.time_ and arg_70_1.time_ < var_73_5 + var_73_13 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_5) / var_73_13

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_5 + var_73_13 and arg_70_1.time_ < var_73_5 + var_73_13 + arg_73_0 then
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
			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 and not isNil(arg_74_1.actors_["10113"]) and arg_74_1.var_.actorSpriteComps10113 == nil then
				arg_74_1.var_.actorSpriteComps10113 = arg_74_1.actors_["10113"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_77_0 = 0.2

			if 0 <= arg_74_1.time_ and arg_74_1.time_ < 0 + var_77_0 and not isNil(arg_74_1.actors_["10113"]) then
				if arg_74_1.var_.actorSpriteComps10113 then
					for iter_77_0, iter_77_1 in pairs(arg_74_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_77_1 then
							if arg_74_1.isInRecall_ then
								iter_77_1.color = Color.New(Mathf.Lerp(iter_77_1.color.r, arg_74_1.hightColor1.r, (arg_74_1.time_ - 0) / var_77_0), Mathf.Lerp(iter_77_1.color.g, arg_74_1.hightColor1.g, (arg_74_1.time_ - 0) / var_77_0), (Mathf.Lerp(iter_77_1.color.b, arg_74_1.hightColor1.b, (arg_74_1.time_ - 0) / var_77_0)))
							else
								local var_77_1 = Mathf.Lerp(iter_77_1.color.r, 1, (arg_74_1.time_ - 0) / var_77_0)

								iter_77_1.color = Color.New(var_77_1, var_77_1, var_77_1)
							end
						end
					end
				end
			end

			if arg_74_1.time_ >= 0 + var_77_0 and arg_74_1.time_ < 0 + var_77_0 + arg_77_0 and not isNil(arg_74_1.actors_["10113"]) and arg_74_1.var_.actorSpriteComps10113 then
				for iter_77_2, iter_77_3 in pairs(arg_74_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_77_3 then
						iter_77_3.color = arg_74_1.isInRecall_ and (arg_74_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_74_1.var_.actorSpriteComps10113 = nil
			end

			local var_77_2 = arg_74_1.actors_["10128"]

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 and not isNil(var_77_2) and arg_74_1.var_.actorSpriteComps10128 == nil then
				arg_74_1.var_.actorSpriteComps10128 = var_77_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_77_3 = 0.2

			if 0 <= arg_74_1.time_ and arg_74_1.time_ < 0 + var_77_3 and not isNil(var_77_2) then
				if arg_74_1.var_.actorSpriteComps10128 then
					for iter_77_4, iter_77_5 in pairs(arg_74_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_77_5 then
							if arg_74_1.isInRecall_ then
								iter_77_5.color = Color.New(Mathf.Lerp(iter_77_5.color.r, arg_74_1.hightColor2.r, (arg_74_1.time_ - 0) / var_77_3), Mathf.Lerp(iter_77_5.color.g, arg_74_1.hightColor2.g, (arg_74_1.time_ - 0) / var_77_3), (Mathf.Lerp(iter_77_5.color.b, arg_74_1.hightColor2.b, (arg_74_1.time_ - 0) / var_77_3)))
							else
								local var_77_4 = Mathf.Lerp(iter_77_5.color.r, 0.5, (arg_74_1.time_ - 0) / var_77_3)

								iter_77_5.color = Color.New(var_77_4, var_77_4, var_77_4)
							end
						end
					end
				end
			end

			if arg_74_1.time_ >= 0 + var_77_3 and arg_74_1.time_ < 0 + var_77_3 + arg_77_0 and not isNil(var_77_2) and arg_74_1.var_.actorSpriteComps10128 then
				for iter_77_6, iter_77_7 in pairs(arg_74_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_77_7 then
						iter_77_7.color = arg_74_1.isInRecall_ and (arg_74_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_74_1.var_.actorSpriteComps10128 = nil
			end

			local var_77_5 = 0
			local var_77_6 = 0.675

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= var_77_5 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, true)

				arg_74_1.leftNameTxt_.text = arg_74_1:FormatText(StoryNameCfg[1117].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_74_1.leftNameTxt_.transform)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1.leftNameTxt_.text)
				SetActive(arg_74_1.iconTrs_.gameObject, false)
				arg_74_1.callingController_:SetSelectedState("normal")

				local var_77_7 = arg_74_1:GetWordFromCfg(417212018)
				local var_77_8 = arg_74_1:FormatText(var_77_7.content)

				arg_74_1.text_.text = var_77_8

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_10 = 27 <= 0 and var_77_6 or var_77_6 * (utf8.len(var_77_8) / 27)

				if (27 <= 0 and var_77_6 or var_77_6 * (utf8.len(var_77_8) / 27)) > 0 and var_77_6 < var_77_10 then
					arg_74_1.talkMaxDuration = var_77_10

					if var_77_10 + var_77_5 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_10 + var_77_5
					end
				end

				arg_74_1.text_.text = var_77_8
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417212", "417212018", "story_v_out_417212.awb") ~= 0 then
					local var_77_11 = manager.audio:GetVoiceLength("story_v_out_417212", "417212018", "story_v_out_417212.awb") / 1000

					if var_77_11 + var_77_5 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_11 + var_77_5
					end

					if var_77_7.prefab_name ~= "" and arg_74_1.actors_[var_77_7.prefab_name] ~= nil then
						local var_77_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_74_1.actors_[var_77_7.prefab_name].transform, "story_v_out_417212", "417212018", "story_v_out_417212.awb")

						arg_74_1:RecordAudio("417212018", var_77_12)
						arg_74_1:RecordAudio("417212018", var_77_12)
					else
						arg_74_1:AudioAction("play", "voice", "story_v_out_417212", "417212018", "story_v_out_417212.awb")
					end

					arg_74_1:RecordHistoryTalkVoice("story_v_out_417212", "417212018", "story_v_out_417212.awb")
				end

				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_13 = math.max(var_77_6, arg_74_1.talkMaxDuration)

			if var_77_5 <= arg_74_1.time_ and arg_74_1.time_ < var_77_5 + var_77_13 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_5) / var_77_13

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_5 + var_77_13 and arg_74_1.time_ < var_77_5 + var_77_13 + arg_77_0 then
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
			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 and not isNil(arg_78_1.actors_["10128"]) and arg_78_1.var_.actorSpriteComps10128 == nil then
				arg_78_1.var_.actorSpriteComps10128 = arg_78_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_81_0 = 0.2

			if 0 <= arg_78_1.time_ and arg_78_1.time_ < 0 + var_81_0 and not isNil(arg_78_1.actors_["10128"]) then
				if arg_78_1.var_.actorSpriteComps10128 then
					for iter_81_0, iter_81_1 in pairs(arg_78_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_81_1 then
							if arg_78_1.isInRecall_ then
								iter_81_1.color = Color.New(Mathf.Lerp(iter_81_1.color.r, arg_78_1.hightColor1.r, (arg_78_1.time_ - 0) / var_81_0), Mathf.Lerp(iter_81_1.color.g, arg_78_1.hightColor1.g, (arg_78_1.time_ - 0) / var_81_0), (Mathf.Lerp(iter_81_1.color.b, arg_78_1.hightColor1.b, (arg_78_1.time_ - 0) / var_81_0)))
							else
								local var_81_1 = Mathf.Lerp(iter_81_1.color.r, 1, (arg_78_1.time_ - 0) / var_81_0)

								iter_81_1.color = Color.New(var_81_1, var_81_1, var_81_1)
							end
						end
					end
				end
			end

			if arg_78_1.time_ >= 0 + var_81_0 and arg_78_1.time_ < 0 + var_81_0 + arg_81_0 and not isNil(arg_78_1.actors_["10128"]) and arg_78_1.var_.actorSpriteComps10128 then
				for iter_81_2, iter_81_3 in pairs(arg_78_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_81_3 then
						iter_81_3.color = arg_78_1.isInRecall_ and (arg_78_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_78_1.var_.actorSpriteComps10128 = nil
			end

			local var_81_2 = arg_78_1.actors_["10113"]

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 and not isNil(var_81_2) and arg_78_1.var_.actorSpriteComps10113 == nil then
				arg_78_1.var_.actorSpriteComps10113 = var_81_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_81_3 = 0.2

			if 0 <= arg_78_1.time_ and arg_78_1.time_ < 0 + var_81_3 and not isNil(var_81_2) then
				if arg_78_1.var_.actorSpriteComps10113 then
					for iter_81_4, iter_81_5 in pairs(arg_78_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_81_5 then
							if arg_78_1.isInRecall_ then
								iter_81_5.color = Color.New(Mathf.Lerp(iter_81_5.color.r, arg_78_1.hightColor2.r, (arg_78_1.time_ - 0) / var_81_3), Mathf.Lerp(iter_81_5.color.g, arg_78_1.hightColor2.g, (arg_78_1.time_ - 0) / var_81_3), (Mathf.Lerp(iter_81_5.color.b, arg_78_1.hightColor2.b, (arg_78_1.time_ - 0) / var_81_3)))
							else
								local var_81_4 = Mathf.Lerp(iter_81_5.color.r, 0.5, (arg_78_1.time_ - 0) / var_81_3)

								iter_81_5.color = Color.New(var_81_4, var_81_4, var_81_4)
							end
						end
					end
				end
			end

			if arg_78_1.time_ >= 0 + var_81_3 and arg_78_1.time_ < 0 + var_81_3 + arg_81_0 and not isNil(var_81_2) and arg_78_1.var_.actorSpriteComps10113 then
				for iter_81_6, iter_81_7 in pairs(arg_78_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_81_7 then
						iter_81_7.color = arg_78_1.isInRecall_ and (arg_78_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_78_1.var_.actorSpriteComps10113 = nil
			end

			local var_81_5 = 0
			local var_81_6 = 0.875

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= var_81_5 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, true)

				arg_78_1.leftNameTxt_.text = arg_78_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_78_1.leftNameTxt_.transform)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1.leftNameTxt_.text)
				SetActive(arg_78_1.iconTrs_.gameObject, false)
				arg_78_1.callingController_:SetSelectedState("normal")

				local var_81_7 = arg_78_1:GetWordFromCfg(417212019)
				local var_81_8 = arg_78_1:FormatText(var_81_7.content)

				arg_78_1.text_.text = var_81_8

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_10 = 35 <= 0 and var_81_6 or var_81_6 * (utf8.len(var_81_8) / 35)

				if (35 <= 0 and var_81_6 or var_81_6 * (utf8.len(var_81_8) / 35)) > 0 and var_81_6 < var_81_10 then
					arg_78_1.talkMaxDuration = var_81_10

					if var_81_10 + var_81_5 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_10 + var_81_5
					end
				end

				arg_78_1.text_.text = var_81_8
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417212", "417212019", "story_v_out_417212.awb") ~= 0 then
					local var_81_11 = manager.audio:GetVoiceLength("story_v_out_417212", "417212019", "story_v_out_417212.awb") / 1000

					if var_81_11 + var_81_5 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_11 + var_81_5
					end

					if var_81_7.prefab_name ~= "" and arg_78_1.actors_[var_81_7.prefab_name] ~= nil then
						local var_81_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_78_1.actors_[var_81_7.prefab_name].transform, "story_v_out_417212", "417212019", "story_v_out_417212.awb")

						arg_78_1:RecordAudio("417212019", var_81_12)
						arg_78_1:RecordAudio("417212019", var_81_12)
					else
						arg_78_1:AudioAction("play", "voice", "story_v_out_417212", "417212019", "story_v_out_417212.awb")
					end

					arg_78_1:RecordHistoryTalkVoice("story_v_out_417212", "417212019", "story_v_out_417212.awb")
				end

				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_13 = math.max(var_81_6, arg_78_1.talkMaxDuration)

			if var_81_5 <= arg_78_1.time_ and arg_78_1.time_ < var_81_5 + var_81_13 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_5) / var_81_13

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_5 + var_81_13 and arg_78_1.time_ < var_81_5 + var_81_13 + arg_81_0 then
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
			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 and not isNil(arg_82_1.actors_["10113"]) and arg_82_1.var_.actorSpriteComps10113 == nil then
				arg_82_1.var_.actorSpriteComps10113 = arg_82_1.actors_["10113"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_85_0 = 0.2

			if 0 <= arg_82_1.time_ and arg_82_1.time_ < 0 + var_85_0 and not isNil(arg_82_1.actors_["10113"]) then
				if arg_82_1.var_.actorSpriteComps10113 then
					for iter_85_0, iter_85_1 in pairs(arg_82_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_85_1 then
							if arg_82_1.isInRecall_ then
								iter_85_1.color = Color.New(Mathf.Lerp(iter_85_1.color.r, arg_82_1.hightColor1.r, (arg_82_1.time_ - 0) / var_85_0), Mathf.Lerp(iter_85_1.color.g, arg_82_1.hightColor1.g, (arg_82_1.time_ - 0) / var_85_0), (Mathf.Lerp(iter_85_1.color.b, arg_82_1.hightColor1.b, (arg_82_1.time_ - 0) / var_85_0)))
							else
								local var_85_1 = Mathf.Lerp(iter_85_1.color.r, 1, (arg_82_1.time_ - 0) / var_85_0)

								iter_85_1.color = Color.New(var_85_1, var_85_1, var_85_1)
							end
						end
					end
				end
			end

			if arg_82_1.time_ >= 0 + var_85_0 and arg_82_1.time_ < 0 + var_85_0 + arg_85_0 and not isNil(arg_82_1.actors_["10113"]) and arg_82_1.var_.actorSpriteComps10113 then
				for iter_85_2, iter_85_3 in pairs(arg_82_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_85_3 then
						iter_85_3.color = arg_82_1.isInRecall_ and (arg_82_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_82_1.var_.actorSpriteComps10113 = nil
			end

			local var_85_2 = arg_82_1.actors_["10128"]

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 and not isNil(var_85_2) and arg_82_1.var_.actorSpriteComps10128 == nil then
				arg_82_1.var_.actorSpriteComps10128 = var_85_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_85_3 = 0.2

			if 0 <= arg_82_1.time_ and arg_82_1.time_ < 0 + var_85_3 and not isNil(var_85_2) then
				if arg_82_1.var_.actorSpriteComps10128 then
					for iter_85_4, iter_85_5 in pairs(arg_82_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_85_5 then
							if arg_82_1.isInRecall_ then
								iter_85_5.color = Color.New(Mathf.Lerp(iter_85_5.color.r, arg_82_1.hightColor2.r, (arg_82_1.time_ - 0) / var_85_3), Mathf.Lerp(iter_85_5.color.g, arg_82_1.hightColor2.g, (arg_82_1.time_ - 0) / var_85_3), (Mathf.Lerp(iter_85_5.color.b, arg_82_1.hightColor2.b, (arg_82_1.time_ - 0) / var_85_3)))
							else
								local var_85_4 = Mathf.Lerp(iter_85_5.color.r, 0.5, (arg_82_1.time_ - 0) / var_85_3)

								iter_85_5.color = Color.New(var_85_4, var_85_4, var_85_4)
							end
						end
					end
				end
			end

			if arg_82_1.time_ >= 0 + var_85_3 and arg_82_1.time_ < 0 + var_85_3 + arg_85_0 and not isNil(var_85_2) and arg_82_1.var_.actorSpriteComps10128 then
				for iter_85_6, iter_85_7 in pairs(arg_82_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_85_7 then
						iter_85_7.color = arg_82_1.isInRecall_ and (arg_82_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_82_1.var_.actorSpriteComps10128 = nil
			end

			local var_85_5 = arg_82_1.actors_["10113"].transform

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 then
				arg_82_1.var_.moveOldPos10113 = var_85_5.localPosition
				var_85_5.localScale = Vector3.New(1, 1, 1)

				arg_82_1:CheckSpriteTmpPos("10113", 2)

				for iter_85_8 = 0, var_85_5.childCount - 1 do
					local var_85_6 = var_85_5:GetChild(iter_85_8)

					if var_85_6.name == "split_2" or not string.find(var_85_6.name, "split") then
						var_85_6.gameObject:SetActive(true)
					else
						var_85_6.gameObject:SetActive(false)
					end
				end
			end

			local var_85_7 = 0.001

			if 0 <= arg_82_1.time_ and arg_82_1.time_ < 0 + var_85_7 then
				var_85_5.localPosition = Vector3.Lerp(arg_82_1.var_.moveOldPos10113, Vector3.New(-403.26, -328.4, -517.4), (arg_82_1.time_ - 0) / var_85_7)
			end

			if arg_82_1.time_ >= 0 + var_85_7 and arg_82_1.time_ < 0 + var_85_7 + arg_85_0 then
				var_85_5.localPosition = Vector3.New(-403.26, -328.4, -517.4)
			end

			local var_85_8 = 0
			local var_85_9 = 0.625

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= var_85_8 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				arg_82_1.leftNameTxt_.text = arg_82_1:FormatText(StoryNameCfg[1117].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_10 = arg_82_1:GetWordFromCfg(417212020)
				local var_85_11 = arg_82_1:FormatText(var_85_10.content)

				arg_82_1.text_.text = var_85_11

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_13 = 25 <= 0 and var_85_9 or var_85_9 * (utf8.len(var_85_11) / 25)

				if (25 <= 0 and var_85_9 or var_85_9 * (utf8.len(var_85_11) / 25)) > 0 and var_85_9 < var_85_13 then
					arg_82_1.talkMaxDuration = var_85_13

					if var_85_13 + var_85_8 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_13 + var_85_8
					end
				end

				arg_82_1.text_.text = var_85_11
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417212", "417212020", "story_v_out_417212.awb") ~= 0 then
					local var_85_14 = manager.audio:GetVoiceLength("story_v_out_417212", "417212020", "story_v_out_417212.awb") / 1000

					if var_85_14 + var_85_8 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_14 + var_85_8
					end

					if var_85_10.prefab_name ~= "" and arg_82_1.actors_[var_85_10.prefab_name] ~= nil then
						local var_85_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_82_1.actors_[var_85_10.prefab_name].transform, "story_v_out_417212", "417212020", "story_v_out_417212.awb")

						arg_82_1:RecordAudio("417212020", var_85_15)
						arg_82_1:RecordAudio("417212020", var_85_15)
					else
						arg_82_1:AudioAction("play", "voice", "story_v_out_417212", "417212020", "story_v_out_417212.awb")
					end

					arg_82_1:RecordHistoryTalkVoice("story_v_out_417212", "417212020", "story_v_out_417212.awb")
				end

				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_16 = math.max(var_85_9, arg_82_1.talkMaxDuration)

			if var_85_8 <= arg_82_1.time_ and arg_82_1.time_ < var_85_8 + var_85_16 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_8) / var_85_16

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_8 + var_85_16 and arg_82_1.time_ < var_85_8 + var_85_16 + arg_85_0 then
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
			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 and not isNil(arg_86_1.actors_["10113"]) and arg_86_1.var_.actorSpriteComps10113 == nil then
				arg_86_1.var_.actorSpriteComps10113 = arg_86_1.actors_["10113"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_89_0 = 0.2

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_0 and not isNil(arg_86_1.actors_["10113"]) then
				if arg_86_1.var_.actorSpriteComps10113 then
					for iter_89_0, iter_89_1 in pairs(arg_86_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_89_1 then
							if arg_86_1.isInRecall_ then
								iter_89_1.color = Color.New(Mathf.Lerp(iter_89_1.color.r, arg_86_1.hightColor2.r, (arg_86_1.time_ - 0) / var_89_0), Mathf.Lerp(iter_89_1.color.g, arg_86_1.hightColor2.g, (arg_86_1.time_ - 0) / var_89_0), (Mathf.Lerp(iter_89_1.color.b, arg_86_1.hightColor2.b, (arg_86_1.time_ - 0) / var_89_0)))
							else
								local var_89_1 = Mathf.Lerp(iter_89_1.color.r, 0.5, (arg_86_1.time_ - 0) / var_89_0)

								iter_89_1.color = Color.New(var_89_1, var_89_1, var_89_1)
							end
						end
					end
				end
			end

			if arg_86_1.time_ >= 0 + var_89_0 and arg_86_1.time_ < 0 + var_89_0 + arg_89_0 and not isNil(arg_86_1.actors_["10113"]) and arg_86_1.var_.actorSpriteComps10113 then
				for iter_89_2, iter_89_3 in pairs(arg_86_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_89_3 then
						iter_89_3.color = arg_86_1.isInRecall_ and (arg_86_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_86_1.var_.actorSpriteComps10113 = nil
			end

			local var_89_2 = arg_86_1.actors_["10113"].transform

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 then
				arg_86_1.var_.moveOldPos10113 = var_89_2.localPosition
				var_89_2.localScale = Vector3.New(1, 1, 1)

				arg_86_1:CheckSpriteTmpPos("10113", 7)

				for iter_89_4 = 0, var_89_2.childCount - 1 do
					local var_89_3 = var_89_2:GetChild(iter_89_4)

					if var_89_3.name == "" or not string.find(var_89_3.name, "split") then
						var_89_3.gameObject:SetActive(true)
					else
						var_89_3.gameObject:SetActive(false)
					end
				end
			end

			local var_89_4 = 0.001

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_4 then
				var_89_2.localPosition = Vector3.Lerp(arg_86_1.var_.moveOldPos10113, Vector3.New(0, -2000, 0), (arg_86_1.time_ - 0) / var_89_4)
			end

			if arg_86_1.time_ >= 0 + var_89_4 and arg_86_1.time_ < 0 + var_89_4 + arg_89_0 then
				var_89_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_89_5 = arg_86_1.actors_["10128"].transform

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 then
				arg_86_1.var_.moveOldPos10128 = var_89_5.localPosition
				var_89_5.localScale = Vector3.New(1, 1, 1)

				arg_86_1:CheckSpriteTmpPos("10128", 7)

				for iter_89_5 = 0, var_89_5.childCount - 1 do
					local var_89_6 = var_89_5:GetChild(iter_89_5)

					if var_89_6.name == "" or not string.find(var_89_6.name, "split") then
						var_89_6.gameObject:SetActive(true)
					else
						var_89_6.gameObject:SetActive(false)
					end
				end
			end

			local var_89_7 = 0.001

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_7 then
				var_89_5.localPosition = Vector3.Lerp(arg_86_1.var_.moveOldPos10128, Vector3.New(0, -2000, -300), (arg_86_1.time_ - 0) / var_89_7)
			end

			if arg_86_1.time_ >= 0 + var_89_7 and arg_86_1.time_ < 0 + var_89_7 + arg_89_0 then
				var_89_5.localPosition = Vector3.New(0, -2000, -300)
			end

			local var_89_8 = 0
			local var_89_9 = 0.475

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= var_89_8 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, false)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_10 = arg_86_1:FormatText(arg_86_1:GetWordFromCfg(417212021).content)

				arg_86_1.text_.text = var_89_10

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_12 = 19 <= 0 and var_89_9 or var_89_9 * (utf8.len(var_89_10) / 19)

				if (19 <= 0 and var_89_9 or var_89_9 * (utf8.len(var_89_10) / 19)) > 0 and var_89_9 < var_89_12 then
					arg_86_1.talkMaxDuration = var_89_12

					if var_89_12 + var_89_8 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_12 + var_89_8
					end
				end

				arg_86_1.text_.text = var_89_10
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)
				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_13 = math.max(var_89_9, arg_86_1.talkMaxDuration)

			if var_89_8 <= arg_86_1.time_ and arg_86_1.time_ < var_89_8 + var_89_13 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_8) / var_89_13

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_8 + var_89_13 and arg_86_1.time_ < var_89_8 + var_89_13 + arg_89_0 then
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
			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 and not isNil(arg_90_1.actors_["10113"]) and arg_90_1.var_.actorSpriteComps10113 == nil then
				arg_90_1.var_.actorSpriteComps10113 = arg_90_1.actors_["10113"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_93_0 = 0.2

			if 0 <= arg_90_1.time_ and arg_90_1.time_ < 0 + var_93_0 and not isNil(arg_90_1.actors_["10113"]) then
				if arg_90_1.var_.actorSpriteComps10113 then
					for iter_93_0, iter_93_1 in pairs(arg_90_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_93_1 then
							if arg_90_1.isInRecall_ then
								iter_93_1.color = Color.New(Mathf.Lerp(iter_93_1.color.r, arg_90_1.hightColor1.r, (arg_90_1.time_ - 0) / var_93_0), Mathf.Lerp(iter_93_1.color.g, arg_90_1.hightColor1.g, (arg_90_1.time_ - 0) / var_93_0), (Mathf.Lerp(iter_93_1.color.b, arg_90_1.hightColor1.b, (arg_90_1.time_ - 0) / var_93_0)))
							else
								local var_93_1 = Mathf.Lerp(iter_93_1.color.r, 1, (arg_90_1.time_ - 0) / var_93_0)

								iter_93_1.color = Color.New(var_93_1, var_93_1, var_93_1)
							end
						end
					end
				end
			end

			if arg_90_1.time_ >= 0 + var_93_0 and arg_90_1.time_ < 0 + var_93_0 + arg_93_0 and not isNil(arg_90_1.actors_["10113"]) and arg_90_1.var_.actorSpriteComps10113 then
				for iter_93_2, iter_93_3 in pairs(arg_90_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_93_3 then
						iter_93_3.color = arg_90_1.isInRecall_ and (arg_90_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_90_1.var_.actorSpriteComps10113 = nil
			end

			local var_93_2 = arg_90_1.actors_["10113"].transform

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 then
				arg_90_1.var_.moveOldPos10113 = var_93_2.localPosition
				var_93_2.localScale = Vector3.New(1, 1, 1)

				arg_90_1:CheckSpriteTmpPos("10113", 3)

				for iter_93_4 = 0, var_93_2.childCount - 1 do
					local var_93_3 = var_93_2:GetChild(iter_93_4)

					if var_93_3.name == "" or not string.find(var_93_3.name, "split") then
						var_93_3.gameObject:SetActive(true)
					else
						var_93_3.gameObject:SetActive(false)
					end
				end
			end

			local var_93_4 = 0.001

			if 0 <= arg_90_1.time_ and arg_90_1.time_ < 0 + var_93_4 then
				var_93_2.localPosition = Vector3.Lerp(arg_90_1.var_.moveOldPos10113, Vector3.New(-30.38, -328.4, -517.4), (arg_90_1.time_ - 0) / var_93_4)
			end

			if arg_90_1.time_ >= 0 + var_93_4 and arg_90_1.time_ < 0 + var_93_4 + arg_93_0 then
				var_93_2.localPosition = Vector3.New(-30.38, -328.4, -517.4)
			end

			local var_93_5 = 0
			local var_93_6 = 0.325

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= var_93_5 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				arg_90_1.leftNameTxt_.text = arg_90_1:FormatText(StoryNameCfg[1117].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_7 = arg_90_1:GetWordFromCfg(417212022)
				local var_93_8 = arg_90_1:FormatText(var_93_7.content)

				arg_90_1.text_.text = var_93_8

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_10 = 13 <= 0 and var_93_6 or var_93_6 * (utf8.len(var_93_8) / 13)

				if (13 <= 0 and var_93_6 or var_93_6 * (utf8.len(var_93_8) / 13)) > 0 and var_93_6 < var_93_10 then
					arg_90_1.talkMaxDuration = var_93_10

					if var_93_10 + var_93_5 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_10 + var_93_5
					end
				end

				arg_90_1.text_.text = var_93_8
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417212", "417212022", "story_v_out_417212.awb") ~= 0 then
					local var_93_11 = manager.audio:GetVoiceLength("story_v_out_417212", "417212022", "story_v_out_417212.awb") / 1000

					if var_93_11 + var_93_5 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_11 + var_93_5
					end

					if var_93_7.prefab_name ~= "" and arg_90_1.actors_[var_93_7.prefab_name] ~= nil then
						local var_93_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_90_1.actors_[var_93_7.prefab_name].transform, "story_v_out_417212", "417212022", "story_v_out_417212.awb")

						arg_90_1:RecordAudio("417212022", var_93_12)
						arg_90_1:RecordAudio("417212022", var_93_12)
					else
						arg_90_1:AudioAction("play", "voice", "story_v_out_417212", "417212022", "story_v_out_417212.awb")
					end

					arg_90_1:RecordHistoryTalkVoice("story_v_out_417212", "417212022", "story_v_out_417212.awb")
				end

				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_13 = math.max(var_93_6, arg_90_1.talkMaxDuration)

			if var_93_5 <= arg_90_1.time_ and arg_90_1.time_ < var_93_5 + var_93_13 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_5) / var_93_13

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_5 + var_93_13 and arg_90_1.time_ < var_93_5 + var_93_13 + arg_93_0 then
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
