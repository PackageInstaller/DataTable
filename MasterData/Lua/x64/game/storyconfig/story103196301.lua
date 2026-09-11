return {
	Play319631001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 319631001
		arg_1_1.duration_ = 3.7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play319631002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_2 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_2 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_2

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_2
						arg_1_1.bgmTxt2_.text = var_4_2
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

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1.fswbg_:SetActive(true)
				arg_1_1.dialog_:SetActive(false)

				arg_1_1.fswtw_.percent = 0
				arg_1_1.fswt_.text = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(319631001).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.fswt_)

				arg_1_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_1_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_1_1.fswtw_:SetDirty()

				arg_1_1.typewritterCharCountI18N = 0

				SetActive(arg_1_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_1_1:ShowNextGo(false)
			end

			local var_4_3 = 0.2

			if 0.2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_3 + arg_4_0 then
				arg_1_1.var_.oldValueTypewriter = arg_1_1.fswtw_.percent

				SetActive(arg_1_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_1_1:ShowNextGo(false)
			end

			local var_4_4 = 14
			local var_4_5 = 0.933333333333333
			local var_4_6, var_4_7 = arg_1_1:GetPercentByPara(arg_1_1:FormatText(arg_1_1:GetWordFromCfg(319631001).content), 1)

			if var_4_3 < arg_1_1.time_ and arg_1_1.time_ <= var_4_3 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				local var_4_8 = var_4_4 <= 0 and var_4_5 or var_4_5 * ((var_4_7 - arg_1_1.typewritterCharCountI18N) / var_4_4)

				if (var_4_4 <= 0 and var_4_5 or var_4_5 * ((var_4_7 - arg_1_1.typewritterCharCountI18N) / var_4_4)) > 0 and var_4_5 < var_4_8 then
					arg_1_1.talkMaxDuration = var_4_8

					if var_4_8 + var_4_3 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_8 + var_4_3
					end
				end
			end

			local var_4_9 = math.max(0.933333333333333, arg_1_1.talkMaxDuration)

			if var_4_3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_3 + var_4_9 then
				arg_1_1.fswtw_.percent = Mathf.Lerp(arg_1_1.var_.oldValueTypewriter, var_4_6, (arg_1_1.time_ - var_4_3) / var_4_9)
				arg_1_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_1_1.fswtw_:SetDirty()
			end

			if arg_1_1.time_ >= var_4_3 + var_4_9 and arg_1_1.time_ < var_4_3 + var_4_9 + arg_4_0 then
				arg_1_1.fswtw_.percent = var_4_6

				arg_1_1.fswtw_:SetDirty()
				arg_1_1:ShowNextGo(true)

				arg_1_1.typewritterCharCountI18N = var_4_7
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_10 = arg_1_1.fswbg_.transform:Find("textbox/adapt/content") or arg_1_1.fswbg_.transform:Find("textbox/content")
				local var_4_11 = arg_1_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_4_12 = var_4_10:GetComponent("RectTransform")

				var_4_10:GetComponent("Text").alignment = UnityEngine.TextAnchor.LowerCenter
				var_4_12.offsetMin = Vector2.New(0, 0)
				var_4_12.offsetMax = Vector2.New(0, 0)
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1.cswbg_:SetActive(true)

				local var_4_13 = arg_1_1.cswt_:GetComponent("RectTransform")

				arg_1_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_4_13.offsetMin = Vector2.New(410, 330)
				var_4_13.offsetMax = Vector2.New(-400, -180)
				arg_1_1.cswt_.text = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(419033).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.cswt_)

				arg_1_1.cswt_.fontSize = 175
				arg_1_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_1_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_1_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end

			local var_4_14 = 0
			local var_4_15 = manager.audio:GetVoiceLength("story_v_out_319631", "319631001", "story_v_out_319631.awb") / 1000

			if var_4_15 > 0 and 3.7 < var_4_15 and var_4_15 + var_4_14 > arg_1_1.duration_ then
				arg_1_1.duration_ = var_4_15 + var_4_14
			end

			if var_4_14 < arg_1_1.time_ and arg_1_1.time_ <= var_4_14 + arg_4_0 then
				arg_1_1:AudioAction("play", "voice", "story_v_out_319631", "319631001", "story_v_out_319631.awb")
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play319631002 = function(arg_6_0, arg_6_1)
		arg_6_1.time_ = 0
		arg_6_1.frameCnt_ = 0
		arg_6_1.state_ = "playing"
		arg_6_1.curTalkId_ = 319631002
		arg_6_1.duration_ = 5.27

		SetActive(arg_6_1.tipsGo_, false)

		function arg_6_1.onSingleLineFinish_()
			arg_6_1.onSingleLineUpdate_ = nil
			arg_6_1.onSingleLineFinish_ = nil
			arg_6_1.state_ = "waiting"
		end

		function arg_6_1.playNext_(arg_8_0)
			if arg_8_0 == 1 then
				arg_6_0:Play319631003(arg_6_1)
			end
		end

		function arg_6_1.onSingleLineUpdate_(arg_9_0)
			if 0 < arg_6_1.time_ and arg_6_1.time_ <= 0 + arg_9_0 then
				local var_9_0 = arg_6_1.fswbg_.transform:Find("textbox/adapt/content") or arg_6_1.fswbg_.transform:Find("textbox/content")
				local var_9_1 = arg_6_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_9_2 = var_9_0:GetComponent("RectTransform")

				var_9_0:GetComponent("Text").alignment = UnityEngine.TextAnchor.LowerCenter
				var_9_2.offsetMin = Vector2.New(0, 0)
				var_9_2.offsetMax = Vector2.New(0, 0)
			end

			local var_9_3 = 0
			local var_9_4 = manager.audio:GetVoiceLength("story_v_out_319631", "319631002", "story_v_out_319631.awb") / 1000

			if var_9_4 > 0 and 5.266 < var_9_4 and var_9_4 + var_9_3 > arg_6_1.duration_ then
				arg_6_1.duration_ = var_9_4 + var_9_3
			end

			if var_9_3 < arg_6_1.time_ and arg_6_1.time_ <= var_9_3 + arg_9_0 then
				arg_6_1:AudioAction("play", "voice", "story_v_out_319631", "319631002", "story_v_out_319631.awb")
			end

			if 0 < arg_6_1.time_ and arg_6_1.time_ <= 0 + arg_9_0 then
				arg_6_1.fswbg_:SetActive(true)
				arg_6_1.dialog_:SetActive(false)

				arg_6_1.fswtw_.percent = 0
				arg_6_1.fswt_.text = arg_6_1:FormatText(arg_6_1:GetWordFromCfg(319631002).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_6_1.fswt_)

				arg_6_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_6_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_6_1.fswtw_:SetDirty()

				arg_6_1.typewritterCharCountI18N = 0

				SetActive(arg_6_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_6_1:ShowNextGo(false)
			end

			local var_9_6 = 0.2

			if 0.2 < arg_6_1.time_ and arg_6_1.time_ <= var_9_6 + arg_9_0 then
				arg_6_1.var_.oldValueTypewriter = arg_6_1.fswtw_.percent

				SetActive(arg_6_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_6_1:ShowNextGo(false)
			end

			local var_9_7 = 23
			local var_9_8 = 1.53333333333333
			local var_9_9, var_9_10 = arg_6_1:GetPercentByPara(arg_6_1:FormatText(arg_6_1:GetWordFromCfg(319631002).content), 1)

			if var_9_6 < arg_6_1.time_ and arg_6_1.time_ <= var_9_6 + arg_9_0 then
				arg_6_1.talkMaxDuration = 0

				local var_9_11 = var_9_7 <= 0 and var_9_8 or var_9_8 * ((var_9_10 - arg_6_1.typewritterCharCountI18N) / var_9_7)

				if (var_9_7 <= 0 and var_9_8 or var_9_8 * ((var_9_10 - arg_6_1.typewritterCharCountI18N) / var_9_7)) > 0 and var_9_8 < var_9_11 then
					arg_6_1.talkMaxDuration = var_9_11

					if var_9_11 + var_9_6 > arg_6_1.duration_ then
						arg_6_1.duration_ = var_9_11 + var_9_6
					end
				end
			end

			local var_9_12 = math.max(1.53333333333333, arg_6_1.talkMaxDuration)

			if var_9_6 <= arg_6_1.time_ and arg_6_1.time_ < var_9_6 + var_9_12 then
				arg_6_1.fswtw_.percent = Mathf.Lerp(arg_6_1.var_.oldValueTypewriter, var_9_9, (arg_6_1.time_ - var_9_6) / var_9_12)
				arg_6_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_6_1.fswtw_:SetDirty()
			end

			if arg_6_1.time_ >= var_9_6 + var_9_12 and arg_6_1.time_ < var_9_6 + var_9_12 + arg_9_0 then
				arg_6_1.fswtw_.percent = var_9_9

				arg_6_1.fswtw_:SetDirty()
				arg_6_1:ShowNextGo(true)

				arg_6_1.typewritterCharCountI18N = var_9_10
			end
		end

		arg_6_1.nodeConfigList_ = {}

		arg_6_1:InitPlayNodeList()
	end,
	Play319631003 = function(arg_10_0, arg_10_1)
		arg_10_1.time_ = 0
		arg_10_1.frameCnt_ = 0
		arg_10_1.state_ = "playing"
		arg_10_1.curTalkId_ = 319631003
		arg_10_1.duration_ = 2.57

		SetActive(arg_10_1.tipsGo_, false)

		function arg_10_1.onSingleLineFinish_()
			arg_10_1.onSingleLineUpdate_ = nil
			arg_10_1.onSingleLineFinish_ = nil
			arg_10_1.state_ = "waiting"
		end

		function arg_10_1.playNext_(arg_12_0)
			if arg_12_0 == 1 then
				arg_10_0:Play319631004(arg_10_1)
			end
		end

		function arg_10_1.onSingleLineUpdate_(arg_13_0)
			if 0 < arg_10_1.time_ and arg_10_1.time_ <= 0 + arg_13_0 then
				arg_10_1.fswbg_:SetActive(true)
				arg_10_1.dialog_:SetActive(false)

				arg_10_1.fswtw_.percent = 0
				arg_10_1.fswt_.text = arg_10_1:FormatText(arg_10_1:GetWordFromCfg(319631003).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_10_1.fswt_)

				arg_10_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_10_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_10_1.fswtw_:SetDirty()

				arg_10_1.typewritterCharCountI18N = 0

				SetActive(arg_10_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_10_1:ShowNextGo(false)
			end

			local var_13_0 = 0.2

			if 0.2 < arg_10_1.time_ and arg_10_1.time_ <= var_13_0 + arg_13_0 then
				arg_10_1.var_.oldValueTypewriter = arg_10_1.fswtw_.percent

				SetActive(arg_10_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_10_1:ShowNextGo(false)
			end

			local var_13_1 = 12
			local var_13_2 = 0.8
			local var_13_3, var_13_4 = arg_10_1:GetPercentByPara(arg_10_1:FormatText(arg_10_1:GetWordFromCfg(319631003).content), 1)

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

			local var_13_6 = math.max(0.8, arg_10_1.talkMaxDuration)

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

			local var_13_7 = 0
			local var_13_8 = manager.audio:GetVoiceLength("story_v_out_319631", "319631003", "story_v_out_319631.awb") / 1000

			if var_13_8 > 0 and 2.566 < var_13_8 and var_13_8 + var_13_7 > arg_10_1.duration_ then
				arg_10_1.duration_ = var_13_8 + var_13_7
			end

			if var_13_7 < arg_10_1.time_ and arg_10_1.time_ <= var_13_7 + arg_13_0 then
				arg_10_1:AudioAction("play", "voice", "story_v_out_319631", "319631003", "story_v_out_319631.awb")
			end
		end

		arg_10_1.nodeConfigList_ = {}

		arg_10_1:InitPlayNodeList()
	end,
	Play319631004 = function(arg_14_0, arg_14_1)
		arg_14_1.time_ = 0
		arg_14_1.frameCnt_ = 0
		arg_14_1.state_ = "playing"
		arg_14_1.curTalkId_ = 319631004
		arg_14_1.duration_ = 4.97

		SetActive(arg_14_1.tipsGo_, false)

		function arg_14_1.onSingleLineFinish_()
			arg_14_1.onSingleLineUpdate_ = nil
			arg_14_1.onSingleLineFinish_ = nil
			arg_14_1.state_ = "waiting"
		end

		function arg_14_1.playNext_(arg_16_0)
			if arg_16_0 == 1 then
				arg_14_0:Play319631005(arg_14_1)
			end
		end

		function arg_14_1.onSingleLineUpdate_(arg_17_0)
			if 0 < arg_14_1.time_ and arg_14_1.time_ <= 0 + arg_17_0 then
				arg_14_1.fswbg_:SetActive(true)
				arg_14_1.dialog_:SetActive(false)

				arg_14_1.fswtw_.percent = 0
				arg_14_1.fswt_.text = arg_14_1:FormatText(arg_14_1:GetWordFromCfg(319631004).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_14_1.fswt_)

				arg_14_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_14_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_14_1.fswtw_:SetDirty()

				arg_14_1.typewritterCharCountI18N = 0

				SetActive(arg_14_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_14_1:ShowNextGo(false)
			end

			local var_17_0 = 0.2

			if 0.2 < arg_14_1.time_ and arg_14_1.time_ <= var_17_0 + arg_17_0 then
				arg_14_1.var_.oldValueTypewriter = arg_14_1.fswtw_.percent

				SetActive(arg_14_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_14_1:ShowNextGo(false)
			end

			local var_17_1 = 19
			local var_17_2 = 0.933333333333333
			local var_17_3, var_17_4 = arg_14_1:GetPercentByPara(arg_14_1:FormatText(arg_14_1:GetWordFromCfg(319631004).content), 1)

			if var_17_0 < arg_14_1.time_ and arg_14_1.time_ <= var_17_0 + arg_17_0 then
				arg_14_1.talkMaxDuration = 0

				local var_17_5 = var_17_1 <= 0 and var_17_2 or var_17_2 * ((var_17_4 - arg_14_1.typewritterCharCountI18N) / var_17_1)

				if (var_17_1 <= 0 and var_17_2 or var_17_2 * ((var_17_4 - arg_14_1.typewritterCharCountI18N) / var_17_1)) > 0 and var_17_2 < var_17_5 then
					arg_14_1.talkMaxDuration = var_17_5

					if var_17_5 + var_17_0 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_5 + var_17_0
					end
				end
			end

			local var_17_6 = math.max(0.933333333333333, arg_14_1.talkMaxDuration)

			if var_17_0 <= arg_14_1.time_ and arg_14_1.time_ < var_17_0 + var_17_6 then
				arg_14_1.fswtw_.percent = Mathf.Lerp(arg_14_1.var_.oldValueTypewriter, var_17_3, (arg_14_1.time_ - var_17_0) / var_17_6)
				arg_14_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_14_1.fswtw_:SetDirty()
			end

			if arg_14_1.time_ >= var_17_0 + var_17_6 and arg_14_1.time_ < var_17_0 + var_17_6 + arg_17_0 then
				arg_14_1.fswtw_.percent = var_17_3

				arg_14_1.fswtw_:SetDirty()
				arg_14_1:ShowNextGo(true)

				arg_14_1.typewritterCharCountI18N = var_17_4
			end

			local var_17_7 = 0
			local var_17_8 = manager.audio:GetVoiceLength("story_v_out_319631", "319631004", "story_v_out_319631.awb") / 1000

			if var_17_8 > 0 and 4.966 < var_17_8 and var_17_8 + var_17_7 > arg_14_1.duration_ then
				arg_14_1.duration_ = var_17_8 + var_17_7
			end

			if var_17_7 < arg_14_1.time_ and arg_14_1.time_ <= var_17_7 + arg_17_0 then
				arg_14_1:AudioAction("play", "voice", "story_v_out_319631", "319631004", "story_v_out_319631.awb")
			end
		end

		arg_14_1.nodeConfigList_ = {}

		arg_14_1:InitPlayNodeList()
	end,
	Play319631005 = function(arg_18_0, arg_18_1)
		arg_18_1.time_ = 0
		arg_18_1.frameCnt_ = 0
		arg_18_1.state_ = "playing"
		arg_18_1.curTalkId_ = 319631005
		arg_18_1.duration_ = 1.27

		SetActive(arg_18_1.tipsGo_, false)

		function arg_18_1.onSingleLineFinish_()
			arg_18_1.onSingleLineUpdate_ = nil
			arg_18_1.onSingleLineFinish_ = nil
			arg_18_1.state_ = "waiting"
		end

		function arg_18_1.playNext_(arg_20_0)
			if arg_20_0 == 1 then
				arg_18_0:Play319631006(arg_18_1)
			end
		end

		function arg_18_1.onSingleLineUpdate_(arg_21_0)
			if 0 < arg_18_1.time_ and arg_18_1.time_ <= 0 + arg_21_0 then
				arg_18_1.fswbg_:SetActive(true)
				arg_18_1.dialog_:SetActive(false)

				arg_18_1.fswtw_.percent = 0
				arg_18_1.fswt_.text = arg_18_1:FormatText(arg_18_1:GetWordFromCfg(319631005).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_18_1.fswt_)

				arg_18_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_18_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_18_1.fswtw_:SetDirty()

				arg_18_1.typewritterCharCountI18N = 0

				SetActive(arg_18_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_18_1:ShowNextGo(false)
			end

			local var_21_0 = 0.2

			if 0.2 < arg_18_1.time_ and arg_18_1.time_ <= var_21_0 + arg_21_0 then
				arg_18_1.var_.oldValueTypewriter = arg_18_1.fswtw_.percent

				SetActive(arg_18_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_18_1:ShowNextGo(false)
			end

			local var_21_1 = 4
			local var_21_2 = 0.266666666666667
			local var_21_3, var_21_4 = arg_18_1:GetPercentByPara(arg_18_1:FormatText(arg_18_1:GetWordFromCfg(319631005).content), 1)

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

			local var_21_6 = math.max(0.266666666666667, arg_18_1.talkMaxDuration)

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

			local var_21_7 = 0
			local var_21_8 = manager.audio:GetVoiceLength("story_v_out_319631", "319631005", "story_v_out_319631.awb") / 1000

			if var_21_8 > 0 and 1.266 < var_21_8 and var_21_8 + var_21_7 > arg_18_1.duration_ then
				arg_18_1.duration_ = var_21_8 + var_21_7
			end

			if var_21_7 < arg_18_1.time_ and arg_18_1.time_ <= var_21_7 + arg_21_0 then
				arg_18_1:AudioAction("play", "voice", "story_v_out_319631", "319631005", "story_v_out_319631.awb")
			end
		end

		arg_18_1.nodeConfigList_ = {}

		arg_18_1:InitPlayNodeList()
	end,
	Play319631006 = function(arg_22_0, arg_22_1)
		arg_22_1.time_ = 0
		arg_22_1.frameCnt_ = 0
		arg_22_1.state_ = "playing"
		arg_22_1.curTalkId_ = 319631006
		arg_22_1.duration_ = 6.08

		SetActive(arg_22_1.tipsGo_, false)

		function arg_22_1.onSingleLineFinish_()
			arg_22_1.onSingleLineUpdate_ = nil
			arg_22_1.onSingleLineFinish_ = nil
			arg_22_1.state_ = "waiting"
		end

		function arg_22_1.playNext_(arg_24_0)
			if arg_24_0 == 1 then
				arg_22_0:Play319631007(arg_22_1)
			end
		end

		function arg_22_1.onSingleLineUpdate_(arg_25_0)
			if arg_22_1.bgs_.Z03f == nil then
				local var_25_0 = Object.Instantiate(arg_22_1.paintGo_)

				var_25_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "Z03f")
				var_25_0.name = "Z03f"
				var_25_0.transform.parent = arg_22_1.stage_.transform
				var_25_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_22_1.bgs_.Z03f = var_25_0
			end

			if 0 < arg_22_1.time_ and arg_22_1.time_ <= 0 + arg_25_0 then
				local var_25_1 = arg_22_1.bgs_.Z03f

				arg_22_1.bgs_.Z03f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_25_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_25_2 = var_25_1:GetComponent("SpriteRenderer")

				if var_25_2 and var_25_2.sprite then
					local var_25_3 = 2 * (var_25_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_25_1.transform.localScale = Vector3.New(var_25_3 / var_25_2.sprite.bounds.size.y < var_25_3 * manager.ui.mainCameraCom_.aspect / var_25_2.sprite.bounds.size.x and var_25_3 * manager.ui.mainCameraCom_.aspect / var_25_2.sprite.bounds.size.x or var_25_3 / var_25_2.sprite.bounds.size.y, var_25_3 / var_25_2.sprite.bounds.size.y < var_25_3 * manager.ui.mainCameraCom_.aspect / var_25_2.sprite.bounds.size.x and var_25_3 * manager.ui.mainCameraCom_.aspect / var_25_2.sprite.bounds.size.x or var_25_3 / var_25_2.sprite.bounds.size.y, 0)
				end

				for iter_25_0, iter_25_1 in pairs(arg_22_1.bgs_) do
					if iter_25_0 ~= "Z03f" then
						iter_25_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_25_4 = 0

			if 0 < arg_22_1.time_ and arg_22_1.time_ <= var_25_4 + arg_25_0 then
				arg_22_1.allBtn_.enabled = false
			end

			if arg_22_1.time_ >= var_25_4 + 0.3 and arg_22_1.time_ < var_25_4 + 0.3 + arg_25_0 then
				arg_22_1.allBtn_.enabled = true
			end

			local var_25_5 = 0

			if 0 < arg_22_1.time_ and arg_22_1.time_ <= var_25_5 + arg_25_0 then
				arg_22_1.mask_.enabled = true
				arg_22_1.mask_.raycastTarget = true

				arg_22_1:SetGaussion(false)
			end

			local var_25_6 = 0.2

			if var_25_5 <= arg_22_1.time_ and arg_22_1.time_ < var_25_5 + var_25_6 then
				local var_25_7 = Color.New(0, 0, 0)

				var_25_7.a = Mathf.Lerp(1, 0, (arg_22_1.time_ - var_25_5) / var_25_6)
				arg_22_1.mask_.color = var_25_7
			end

			if arg_22_1.time_ >= var_25_5 + var_25_6 and arg_22_1.time_ < var_25_5 + var_25_6 + arg_25_0 then
				local var_25_8 = Color.New(0, 0, 0)

				arg_22_1.mask_.enabled = false
				var_25_8.a = 0
				arg_22_1.mask_.color = var_25_8
			end

			if 0 < arg_22_1.time_ and arg_22_1.time_ <= 0 + arg_25_0 then
				arg_22_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_25_11 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_22_1.bgmTxt_.text ~= var_25_11 and arg_22_1.bgmTxt_.text ~= "" then
						if arg_22_1.bgmTxt2_.text ~= "" then
							arg_22_1.bgmTxt_.text = arg_22_1.bgmTxt2_.text
						end

						arg_22_1.bgmTxt2_.text = var_25_11

						arg_22_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_22_1.bgmTxt_.text = var_25_11
						arg_22_1.bgmTxt2_.text = var_25_11
					end

					if arg_22_1.bgmTimer then
						arg_22_1.bgmTimer:Stop()

						arg_22_1.bgmTimer = nil
					end

					if arg_22_1.settingData.show_music_name == 1 then
						arg_22_1.musicController:SetSelectedState("show")
						arg_22_1.musicAnimator_:Play("open", 0, 0)

						if arg_22_1.settingData.music_time ~= 0 then
							arg_22_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_22_1.settingData.music_time), function()
								if arg_22_1 == nil or isNil(arg_22_1.bgmTxt_) then
									return
								end

								arg_22_1.musicController:SetSelectedState("hide")
								arg_22_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.233333333333333 < arg_22_1.time_ and arg_22_1.time_ <= 0.233333333333333 + arg_25_0 then
				arg_22_1:AudioAction("play", "music", "bgm_activity_1_6_story_intense", "bgm_activity_1_6_story_intense", "bgm_activity_1_6_story_intense.awb")

				local var_25_14 = manager.audio:GetAudioName("bgm_activity_1_6_story_intense", "bgm_activity_1_6_story_intense")

				if "" ~= "" then
					if arg_22_1.bgmTxt_.text ~= var_25_14 and arg_22_1.bgmTxt_.text ~= "" then
						if arg_22_1.bgmTxt2_.text ~= "" then
							arg_22_1.bgmTxt_.text = arg_22_1.bgmTxt2_.text
						end

						arg_22_1.bgmTxt2_.text = var_25_14

						arg_22_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_22_1.bgmTxt_.text = var_25_14
						arg_22_1.bgmTxt2_.text = var_25_14
					end

					if arg_22_1.bgmTimer then
						arg_22_1.bgmTimer:Stop()

						arg_22_1.bgmTimer = nil
					end

					if arg_22_1.settingData.show_music_name == 1 then
						arg_22_1.musicController:SetSelectedState("show")
						arg_22_1.musicAnimator_:Play("open", 0, 0)

						if arg_22_1.settingData.music_time ~= 0 then
							arg_22_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_22_1.settingData.music_time), function()
								if arg_22_1 == nil or isNil(arg_22_1.bgmTxt_) then
									return
								end

								arg_22_1.musicController:SetSelectedState("hide")
								arg_22_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0 < arg_22_1.time_ and arg_22_1.time_ <= 0 + arg_25_0 then
				arg_22_1.fswbg_:SetActive(false)
				arg_22_1.dialog_:SetActive(false)
				SetActive(arg_22_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_22_1:ShowNextGo(false)
			end

			if 0.2 < arg_22_1.time_ and arg_22_1.time_ <= 0.2 + arg_25_0 then
				arg_22_1.fswbg_:SetActive(false)
				arg_22_1.dialog_:SetActive(false)
				SetActive(arg_22_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_22_1:ShowNextGo(false)
			end

			if 0 < arg_22_1.time_ and arg_22_1.time_ <= 0 + arg_25_0 then
				arg_22_1.cswbg_:SetActive(false)
			end

			if arg_22_1.frameCnt_ <= 1 then
				arg_22_1.dialog_:SetActive(false)
			end

			local var_25_15 = 1.075
			local var_25_16 = 0.925

			if 1.075 < arg_22_1.time_ and arg_22_1.time_ <= var_25_15 + arg_25_0 then
				arg_22_1.talkMaxDuration = 0

				arg_22_1.dialog_:SetActive(true)

				arg_22_1.dialogCg_.alpha = 0

				local var_25_17 = LeanTween.value(arg_22_1.dialog_, 0, 1, 0.3)

				var_25_17:setOnUpdate(LuaHelper.FloatAction(function(arg_28_0)
					arg_22_1.dialogCg_.alpha = arg_28_0
				end))
				var_25_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_22_1.dialog_)
					var_25_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_22_1.duration_ = arg_22_1.duration_ + 0.3

				SetActive(arg_22_1.leftNameGo_, false)

				arg_22_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_22_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_22_1:RecordName(arg_22_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_22_1.iconTrs_.gameObject, false)
				arg_22_1.callingController_:SetSelectedState("normal")

				local var_25_18 = arg_22_1:FormatText(arg_22_1:GetWordFromCfg(319631006).content)

				arg_22_1.text_.text = var_25_18

				LuaForUtil.ClearLinePrefixSymbol(arg_22_1.text_)

				local var_25_20 = 37 <= 0 and var_25_16 or var_25_16 * (utf8.len(var_25_18) / 37)

				if (37 <= 0 and var_25_16 or var_25_16 * (utf8.len(var_25_18) / 37)) > 0 and var_25_16 < var_25_20 then
					arg_22_1.talkMaxDuration = var_25_20
					var_25_15 = var_25_15 + 0.3

					if var_25_20 + var_25_15 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_20 + var_25_15
					end
				end

				arg_22_1.text_.text = var_25_18
				arg_22_1.typewritter.percent = 0

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(false)
				arg_22_1:RecordContent(arg_22_1.text_.text)
			end

			local var_25_21 = var_25_15 + 0.3
			local var_25_22 = math.max(var_25_16, arg_22_1.talkMaxDuration)

			if var_25_15 + 0.3 <= arg_22_1.time_ and arg_22_1.time_ < var_25_21 + var_25_22 then
				arg_22_1.typewritter.percent = (arg_22_1.time_ - var_25_21) / var_25_22

				arg_22_1.typewritter:SetDirty()
			end

			if arg_22_1.time_ >= var_25_21 + var_25_22 and arg_22_1.time_ < var_25_21 + var_25_22 + arg_25_0 then
				arg_22_1.typewritter.percent = 1

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(true)
			end
		end

		arg_22_1.nodeConfigList_ = {}

		arg_22_1:InitPlayNodeList()
	end,
	Play319631007 = function(arg_30_0, arg_30_1)
		arg_30_1.time_ = 0
		arg_30_1.frameCnt_ = 0
		arg_30_1.state_ = "playing"
		arg_30_1.curTalkId_ = 319631007
		arg_30_1.duration_ = 5

		SetActive(arg_30_1.tipsGo_, false)

		function arg_30_1.onSingleLineFinish_()
			arg_30_1.onSingleLineUpdate_ = nil
			arg_30_1.onSingleLineFinish_ = nil
			arg_30_1.state_ = "waiting"
		end

		function arg_30_1.playNext_(arg_32_0)
			if arg_32_0 == 1 then
				arg_30_0:Play319631008(arg_30_1)
			end
		end

		function arg_30_1.onSingleLineUpdate_(arg_33_0)
			local var_33_0 = 1.075

			if 0 < arg_30_1.time_ and arg_30_1.time_ <= 0 + arg_33_0 then
				arg_30_1.talkMaxDuration = 0
				arg_30_1.dialogCg_.alpha = 1

				arg_30_1.dialog_:SetActive(true)
				SetActive(arg_30_1.leftNameGo_, false)

				arg_30_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_30_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_30_1:RecordName(arg_30_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_30_1.iconTrs_.gameObject, false)
				arg_30_1.callingController_:SetSelectedState("normal")

				local var_33_1 = arg_30_1:FormatText(arg_30_1:GetWordFromCfg(319631007).content)

				arg_30_1.text_.text = var_33_1

				LuaForUtil.ClearLinePrefixSymbol(arg_30_1.text_)

				local var_33_3 = 43 <= 0 and var_33_0 or var_33_0 * (utf8.len(var_33_1) / 43)

				if (43 <= 0 and var_33_0 or var_33_0 * (utf8.len(var_33_1) / 43)) > 0 and var_33_0 < var_33_3 then
					arg_30_1.talkMaxDuration = var_33_3

					if var_33_3 + 0 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_3 + 0
					end
				end

				arg_30_1.text_.text = var_33_1
				arg_30_1.typewritter.percent = 0

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(false)
				arg_30_1:RecordContent(arg_30_1.text_.text)
			end

			local var_33_4 = math.max(var_33_0, arg_30_1.talkMaxDuration)

			if 0 <= arg_30_1.time_ and arg_30_1.time_ < 0 + var_33_4 then
				arg_30_1.typewritter.percent = (arg_30_1.time_ - 0) / var_33_4

				arg_30_1.typewritter:SetDirty()
			end

			if arg_30_1.time_ >= 0 + var_33_4 and arg_30_1.time_ < 0 + var_33_4 + arg_33_0 then
				arg_30_1.typewritter.percent = 1

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(true)
			end
		end

		arg_30_1.nodeConfigList_ = {}

		arg_30_1:InitPlayNodeList()
	end,
	Play319631008 = function(arg_34_0, arg_34_1)
		arg_34_1.time_ = 0
		arg_34_1.frameCnt_ = 0
		arg_34_1.state_ = "playing"
		arg_34_1.curTalkId_ = 319631008
		arg_34_1.duration_ = 3.4

		local var_34_0 = {
			zh = 3.4,
			ja = 3
		}
		local var_34_1 = manager.audio:GetLocalizationFlag()

		if var_34_0[var_34_1] ~= nil then
			arg_34_1.duration_ = var_34_0[var_34_1]
		end

		SetActive(arg_34_1.tipsGo_, false)

		function arg_34_1.onSingleLineFinish_()
			arg_34_1.onSingleLineUpdate_ = nil
			arg_34_1.onSingleLineFinish_ = nil
			arg_34_1.state_ = "waiting"
		end

		function arg_34_1.playNext_(arg_36_0)
			if arg_36_0 == 1 then
				arg_34_0:Play319631009(arg_34_1)
			end
		end

		function arg_34_1.onSingleLineUpdate_(arg_37_0)
			if arg_34_1.actors_["10079ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10079ui_story"))) then
				local var_37_0 = Object.Instantiate(Asset.Load("Char/" .. "10079ui_story"), arg_34_1.stage_.transform)

				var_37_0.name = "10079ui_story"
				var_37_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_34_1.actors_["10079ui_story"] = var_37_0

				local var_37_1 = var_37_0:GetComponentInChildren(typeof(CharacterEffect))

				var_37_1.enabled = true

				local var_37_2 = GameObjectTools.GetOrAddComponent(var_37_0, typeof(DynamicBoneHelper))

				if var_37_2 then
					var_37_2:EnableDynamicBone(false)
				end

				arg_34_1:ShowWeapon(var_37_1.transform, false)

				arg_34_1.var_["10079ui_story" .. "Animator"] = var_37_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_34_1.var_["10079ui_story" .. "Animator"].applyRootMotion = true
				arg_34_1.var_["10079ui_story" .. "LipSync"] = var_37_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_37_3 = arg_34_1.actors_["10079ui_story"].transform

			if 0 < arg_34_1.time_ and arg_34_1.time_ <= 0 + arg_37_0 then
				arg_34_1.var_.moveOldPos10079ui_story = var_37_3.localPosition

				arg_34_1:ShowWeapon(arg_34_1.var_["10079ui_story" .. "Animator"].transform, false)
			end

			local var_37_4 = 0.001

			if 0 <= arg_34_1.time_ and arg_34_1.time_ < 0 + var_37_4 then
				var_37_3.localPosition = Vector3.Lerp(arg_34_1.var_.moveOldPos10079ui_story, Vector3.New(0, -0.95, -6.05), (arg_34_1.time_ - 0) / var_37_4)
				var_37_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_37_3.position).x, (manager.ui.mainCamera.transform.position - var_37_3.position).y, (manager.ui.mainCamera.transform.position - var_37_3.position).z)
				var_37_3.localEulerAngles.z = 0
				var_37_3.localEulerAngles.x = 0
				var_37_3.localEulerAngles = var_37_3.localEulerAngles
			end

			if arg_34_1.time_ >= 0 + var_37_4 and arg_34_1.time_ < 0 + var_37_4 + arg_37_0 then
				var_37_3.localPosition = Vector3.New(0, -0.95, -6.05)
				var_37_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_37_3.position).x, (manager.ui.mainCamera.transform.position - var_37_3.position).y, (manager.ui.mainCamera.transform.position - var_37_3.position).z)
				var_37_3.localEulerAngles.z = 0
				var_37_3.localEulerAngles.x = 0
				var_37_3.localEulerAngles = var_37_3.localEulerAngles
			end

			local var_37_5 = arg_34_1.actors_["10079ui_story"]

			if 0 < arg_34_1.time_ and arg_34_1.time_ <= 0 + arg_37_0 and not isNil(var_37_5) and arg_34_1.var_.characterEffect10079ui_story == nil then
				arg_34_1.var_.characterEffect10079ui_story = var_37_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_37_6 = 0.200000002980232

			if 0 <= arg_34_1.time_ and arg_34_1.time_ < 0 + var_37_6 and not isNil(var_37_5) then
				if arg_34_1.var_.characterEffect10079ui_story and not isNil(var_37_5) then
					arg_34_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_34_1.time_ >= 0 + var_37_6 and arg_34_1.time_ < 0 + var_37_6 + arg_37_0 and not isNil(var_37_5) and arg_34_1.var_.characterEffect10079ui_story then
				arg_34_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			if 0 < arg_34_1.time_ and arg_34_1.time_ <= 0 + arg_37_0 then
				arg_34_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			if 0 < arg_34_1.time_ and arg_34_1.time_ <= 0 + arg_37_0 then
				arg_34_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_37_8 = 0
			local var_37_9 = 0.3

			if 0 < arg_34_1.time_ and arg_34_1.time_ <= var_37_8 + arg_37_0 then
				arg_34_1.talkMaxDuration = 0
				arg_34_1.dialogCg_.alpha = 1

				arg_34_1.dialog_:SetActive(true)
				SetActive(arg_34_1.leftNameGo_, true)

				arg_34_1.leftNameTxt_.text = arg_34_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_34_1.leftNameTxt_.transform)

				arg_34_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_34_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_34_1:RecordName(arg_34_1.leftNameTxt_.text)
				SetActive(arg_34_1.iconTrs_.gameObject, false)
				arg_34_1.callingController_:SetSelectedState("normal")

				local var_37_10 = arg_34_1:GetWordFromCfg(319631008)
				local var_37_11 = arg_34_1:FormatText(var_37_10.content)

				arg_34_1.text_.text = var_37_11

				LuaForUtil.ClearLinePrefixSymbol(arg_34_1.text_)

				local var_37_13 = 12 <= 0 and var_37_9 or var_37_9 * (utf8.len(var_37_11) / 12)

				if (12 <= 0 and var_37_9 or var_37_9 * (utf8.len(var_37_11) / 12)) > 0 and var_37_9 < var_37_13 then
					arg_34_1.talkMaxDuration = var_37_13

					if var_37_13 + var_37_8 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_13 + var_37_8
					end
				end

				arg_34_1.text_.text = var_37_11
				arg_34_1.typewritter.percent = 0

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319631", "319631008", "story_v_out_319631.awb") ~= 0 then
					local var_37_14 = manager.audio:GetVoiceLength("story_v_out_319631", "319631008", "story_v_out_319631.awb") / 1000

					if var_37_14 + var_37_8 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_14 + var_37_8
					end

					if var_37_10.prefab_name ~= "" and arg_34_1.actors_[var_37_10.prefab_name] ~= nil then
						local var_37_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_34_1.actors_[var_37_10.prefab_name].transform, "story_v_out_319631", "319631008", "story_v_out_319631.awb")

						arg_34_1:RecordAudio("319631008", var_37_15)
						arg_34_1:RecordAudio("319631008", var_37_15)
					else
						arg_34_1:AudioAction("play", "voice", "story_v_out_319631", "319631008", "story_v_out_319631.awb")
					end

					arg_34_1:RecordHistoryTalkVoice("story_v_out_319631", "319631008", "story_v_out_319631.awb")
				end

				arg_34_1:RecordContent(arg_34_1.text_.text)
			end

			local var_37_16 = math.max(var_37_9, arg_34_1.talkMaxDuration)

			if var_37_8 <= arg_34_1.time_ and arg_34_1.time_ < var_37_8 + var_37_16 then
				arg_34_1.typewritter.percent = (arg_34_1.time_ - var_37_8) / var_37_16

				arg_34_1.typewritter:SetDirty()
			end

			if arg_34_1.time_ >= var_37_8 + var_37_16 and arg_34_1.time_ < var_37_8 + var_37_16 + arg_37_0 then
				arg_34_1.typewritter.percent = 1

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(true)
			end
		end

		arg_34_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_34_1:InitPlayNodeList()
	end,
	Play319631009 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 319631009
		arg_38_1.duration_ = 5.3

		local var_38_0 = {
			zh = 5.3,
			ja = 3.033
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
				arg_38_0:Play319631010(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			local var_41_0 = 0.4

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= 0 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0
				arg_38_1.dialogCg_.alpha = 1

				arg_38_1.dialog_:SetActive(true)
				SetActive(arg_38_1.leftNameGo_, true)

				arg_38_1.leftNameTxt_.text = arg_38_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_38_1.leftNameTxt_.transform)

				arg_38_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_38_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_38_1:RecordName(arg_38_1.leftNameTxt_.text)
				SetActive(arg_38_1.iconTrs_.gameObject, false)
				arg_38_1.callingController_:SetSelectedState("normal")

				local var_41_1 = arg_38_1:GetWordFromCfg(319631009)
				local var_41_2 = arg_38_1:FormatText(var_41_1.content)

				arg_38_1.text_.text = var_41_2

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_4 = 16 <= 0 and var_41_0 or var_41_0 * (utf8.len(var_41_2) / 16)

				if (16 <= 0 and var_41_0 or var_41_0 * (utf8.len(var_41_2) / 16)) > 0 and var_41_0 < var_41_4 then
					arg_38_1.talkMaxDuration = var_41_4

					if var_41_4 + 0 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_4 + 0
					end
				end

				arg_38_1.text_.text = var_41_2
				arg_38_1.typewritter.percent = 0

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319631", "319631009", "story_v_out_319631.awb") ~= 0 then
					local var_41_5 = manager.audio:GetVoiceLength("story_v_out_319631", "319631009", "story_v_out_319631.awb") / 1000

					if var_41_5 + 0 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_5 + 0
					end

					if var_41_1.prefab_name ~= "" and arg_38_1.actors_[var_41_1.prefab_name] ~= nil then
						local var_41_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_38_1.actors_[var_41_1.prefab_name].transform, "story_v_out_319631", "319631009", "story_v_out_319631.awb")

						arg_38_1:RecordAudio("319631009", var_41_6)
						arg_38_1:RecordAudio("319631009", var_41_6)
					else
						arg_38_1:AudioAction("play", "voice", "story_v_out_319631", "319631009", "story_v_out_319631.awb")
					end

					arg_38_1:RecordHistoryTalkVoice("story_v_out_319631", "319631009", "story_v_out_319631.awb")
				end

				arg_38_1:RecordContent(arg_38_1.text_.text)
			end

			local var_41_7 = math.max(var_41_0, arg_38_1.talkMaxDuration)

			if 0 <= arg_38_1.time_ and arg_38_1.time_ < 0 + var_41_7 then
				arg_38_1.typewritter.percent = (arg_38_1.time_ - 0) / var_41_7

				arg_38_1.typewritter:SetDirty()
			end

			if arg_38_1.time_ >= 0 + var_41_7 and arg_38_1.time_ < 0 + var_41_7 + arg_41_0 then
				arg_38_1.typewritter.percent = 1

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(true)
			end
		end

		arg_38_1.nodeConfigList_ = {}

		arg_38_1:InitPlayNodeList()
	end,
	Play319631010 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 319631010
		arg_42_1.duration_ = 4.5

		local var_42_0 = {
			zh = 4,
			ja = 4.5
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
				arg_42_0:Play319631011(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			if arg_42_1.actors_["1095ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1095ui_story"))) then
				local var_45_0 = Object.Instantiate(Asset.Load("Char/" .. "1095ui_story"), arg_42_1.stage_.transform)

				var_45_0.name = "1095ui_story"
				var_45_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_42_1.actors_["1095ui_story"] = var_45_0

				local var_45_1 = var_45_0:GetComponentInChildren(typeof(CharacterEffect))

				var_45_1.enabled = true

				local var_45_2 = GameObjectTools.GetOrAddComponent(var_45_0, typeof(DynamicBoneHelper))

				if var_45_2 then
					var_45_2:EnableDynamicBone(false)
				end

				arg_42_1:ShowWeapon(var_45_1.transform, false)

				arg_42_1.var_["1095ui_story" .. "Animator"] = var_45_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_42_1.var_["1095ui_story" .. "Animator"].applyRootMotion = true
				arg_42_1.var_["1095ui_story" .. "LipSync"] = var_45_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_45_3 = arg_42_1.actors_["1095ui_story"].transform

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 then
				arg_42_1.var_.moveOldPos1095ui_story = var_45_3.localPosition
			end

			local var_45_4 = 0.001

			if 0 <= arg_42_1.time_ and arg_42_1.time_ < 0 + var_45_4 then
				var_45_3.localPosition = Vector3.Lerp(arg_42_1.var_.moveOldPos1095ui_story, Vector3.New(0.7, -0.98, -6.1), (arg_42_1.time_ - 0) / var_45_4)
				var_45_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_45_3.position).x, (manager.ui.mainCamera.transform.position - var_45_3.position).y, (manager.ui.mainCamera.transform.position - var_45_3.position).z)
				var_45_3.localEulerAngles.z = 0
				var_45_3.localEulerAngles.x = 0
				var_45_3.localEulerAngles = var_45_3.localEulerAngles
			end

			if arg_42_1.time_ >= 0 + var_45_4 and arg_42_1.time_ < 0 + var_45_4 + arg_45_0 then
				var_45_3.localPosition = Vector3.New(0.7, -0.98, -6.1)
				var_45_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_45_3.position).x, (manager.ui.mainCamera.transform.position - var_45_3.position).y, (manager.ui.mainCamera.transform.position - var_45_3.position).z)
				var_45_3.localEulerAngles.z = 0
				var_45_3.localEulerAngles.x = 0
				var_45_3.localEulerAngles = var_45_3.localEulerAngles
			end

			local var_45_5 = arg_42_1.actors_["1095ui_story"]

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 and not isNil(var_45_5) and arg_42_1.var_.characterEffect1095ui_story == nil then
				arg_42_1.var_.characterEffect1095ui_story = var_45_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_45_6 = 0.200000002980232

			if 0 <= arg_42_1.time_ and arg_42_1.time_ < 0 + var_45_6 and not isNil(var_45_5) then
				if arg_42_1.var_.characterEffect1095ui_story and not isNil(var_45_5) then
					arg_42_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_42_1.time_ >= 0 + var_45_6 and arg_42_1.time_ < 0 + var_45_6 + arg_45_0 and not isNil(var_45_5) and arg_42_1.var_.characterEffect1095ui_story then
				arg_42_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 then
				arg_42_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 then
				arg_42_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_45_8 = arg_42_1.actors_["10079ui_story"].transform

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 then
				arg_42_1.var_.moveOldPos10079ui_story = var_45_8.localPosition
			end

			local var_45_9 = 0.001

			if 0 <= arg_42_1.time_ and arg_42_1.time_ < 0 + var_45_9 then
				var_45_8.localPosition = Vector3.Lerp(arg_42_1.var_.moveOldPos10079ui_story, Vector3.New(-0.7, -0.95, -6.05), (arg_42_1.time_ - 0) / var_45_9)
				var_45_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_45_8.position).x, (manager.ui.mainCamera.transform.position - var_45_8.position).y, (manager.ui.mainCamera.transform.position - var_45_8.position).z)
				var_45_8.localEulerAngles.z = 0
				var_45_8.localEulerAngles.x = 0
				var_45_8.localEulerAngles = var_45_8.localEulerAngles
			end

			if arg_42_1.time_ >= 0 + var_45_9 and arg_42_1.time_ < 0 + var_45_9 + arg_45_0 then
				var_45_8.localPosition = Vector3.New(-0.7, -0.95, -6.05)
				var_45_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_45_8.position).x, (manager.ui.mainCamera.transform.position - var_45_8.position).y, (manager.ui.mainCamera.transform.position - var_45_8.position).z)
				var_45_8.localEulerAngles.z = 0
				var_45_8.localEulerAngles.x = 0
				var_45_8.localEulerAngles = var_45_8.localEulerAngles
			end

			local var_45_10 = arg_42_1.actors_["10079ui_story"]

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 and not isNil(var_45_10) and arg_42_1.var_.characterEffect10079ui_story == nil then
				arg_42_1.var_.characterEffect10079ui_story = var_45_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_45_11 = 0.200000002980232

			if 0 <= arg_42_1.time_ and arg_42_1.time_ < 0 + var_45_11 and not isNil(var_45_10) then
				if arg_42_1.var_.characterEffect10079ui_story and not isNil(var_45_10) then
					arg_42_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_42_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_42_1.time_ - 0) / var_45_11)
				end
			end

			if arg_42_1.time_ >= 0 + var_45_11 and arg_42_1.time_ < 0 + var_45_11 + arg_45_0 and not isNil(var_45_10) and arg_42_1.var_.characterEffect10079ui_story then
				arg_42_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_42_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			local var_45_12 = 0
			local var_45_13 = 0.4

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= var_45_12 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0
				arg_42_1.dialogCg_.alpha = 1

				arg_42_1.dialog_:SetActive(true)
				SetActive(arg_42_1.leftNameGo_, true)

				arg_42_1.leftNameTxt_.text = arg_42_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_42_1.leftNameTxt_.transform)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1.leftNameTxt_.text)
				SetActive(arg_42_1.iconTrs_.gameObject, false)
				arg_42_1.callingController_:SetSelectedState("normal")

				local var_45_14 = arg_42_1:GetWordFromCfg(319631010)
				local var_45_15 = arg_42_1:FormatText(var_45_14.content)

				arg_42_1.text_.text = var_45_15

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_17 = 16 <= 0 and var_45_13 or var_45_13 * (utf8.len(var_45_15) / 16)

				if (16 <= 0 and var_45_13 or var_45_13 * (utf8.len(var_45_15) / 16)) > 0 and var_45_13 < var_45_17 then
					arg_42_1.talkMaxDuration = var_45_17

					if var_45_17 + var_45_12 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_17 + var_45_12
					end
				end

				arg_42_1.text_.text = var_45_15
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319631", "319631010", "story_v_out_319631.awb") ~= 0 then
					local var_45_18 = manager.audio:GetVoiceLength("story_v_out_319631", "319631010", "story_v_out_319631.awb") / 1000

					if var_45_18 + var_45_12 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_18 + var_45_12
					end

					if var_45_14.prefab_name ~= "" and arg_42_1.actors_[var_45_14.prefab_name] ~= nil then
						local var_45_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_42_1.actors_[var_45_14.prefab_name].transform, "story_v_out_319631", "319631010", "story_v_out_319631.awb")

						arg_42_1:RecordAudio("319631010", var_45_19)
						arg_42_1:RecordAudio("319631010", var_45_19)
					else
						arg_42_1:AudioAction("play", "voice", "story_v_out_319631", "319631010", "story_v_out_319631.awb")
					end

					arg_42_1:RecordHistoryTalkVoice("story_v_out_319631", "319631010", "story_v_out_319631.awb")
				end

				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_20 = math.max(var_45_13, arg_42_1.talkMaxDuration)

			if var_45_12 <= arg_42_1.time_ and arg_42_1.time_ < var_45_12 + var_45_20 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - var_45_12) / var_45_20

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= var_45_12 + var_45_20 and arg_42_1.time_ < var_45_12 + var_45_20 + arg_45_0 then
				arg_42_1.typewritter.percent = 1

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(true)
			end
		end

		arg_42_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_42_1:InitPlayNodeList()
	end,
	Play319631011 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 319631011
		arg_46_1.duration_ = 5

		SetActive(arg_46_1.tipsGo_, false)

		function arg_46_1.onSingleLineFinish_()
			arg_46_1.onSingleLineUpdate_ = nil
			arg_46_1.onSingleLineFinish_ = nil
			arg_46_1.state_ = "waiting"
		end

		function arg_46_1.playNext_(arg_48_0)
			if arg_48_0 == 1 then
				arg_46_0:Play319631012(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			if 0 < arg_46_1.time_ and arg_46_1.time_ <= 0 + arg_49_0 and not isNil(arg_46_1.actors_["1095ui_story"]) and arg_46_1.var_.characterEffect1095ui_story == nil then
				arg_46_1.var_.characterEffect1095ui_story = arg_46_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_49_0 = 0.200000002980232

			if 0 <= arg_46_1.time_ and arg_46_1.time_ < 0 + var_49_0 and not isNil(arg_46_1.actors_["1095ui_story"]) then
				if arg_46_1.var_.characterEffect1095ui_story and not isNil(arg_46_1.actors_["1095ui_story"]) then
					arg_46_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_46_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_46_1.time_ - 0) / var_49_0)
				end
			end

			if arg_46_1.time_ >= 0 + var_49_0 and arg_46_1.time_ < 0 + var_49_0 + arg_49_0 and not isNil(arg_46_1.actors_["1095ui_story"]) and arg_46_1.var_.characterEffect1095ui_story then
				arg_46_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_46_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_49_1 = 0
			local var_49_2 = 1.35

			if 0 < arg_46_1.time_ and arg_46_1.time_ <= var_49_1 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0
				arg_46_1.dialogCg_.alpha = 1

				arg_46_1.dialog_:SetActive(true)
				SetActive(arg_46_1.leftNameGo_, false)

				arg_46_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_46_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_46_1:RecordName(arg_46_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_46_1.iconTrs_.gameObject, false)
				arg_46_1.callingController_:SetSelectedState("normal")

				local var_49_3 = arg_46_1:FormatText(arg_46_1:GetWordFromCfg(319631011).content)

				arg_46_1.text_.text = var_49_3

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_5 = 54 <= 0 and var_49_2 or var_49_2 * (utf8.len(var_49_3) / 54)

				if (54 <= 0 and var_49_2 or var_49_2 * (utf8.len(var_49_3) / 54)) > 0 and var_49_2 < var_49_5 then
					arg_46_1.talkMaxDuration = var_49_5

					if var_49_5 + var_49_1 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_5 + var_49_1
					end
				end

				arg_46_1.text_.text = var_49_3
				arg_46_1.typewritter.percent = 0

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(false)
				arg_46_1:RecordContent(arg_46_1.text_.text)
			end

			local var_49_6 = math.max(var_49_2, arg_46_1.talkMaxDuration)

			if var_49_1 <= arg_46_1.time_ and arg_46_1.time_ < var_49_1 + var_49_6 then
				arg_46_1.typewritter.percent = (arg_46_1.time_ - var_49_1) / var_49_6

				arg_46_1.typewritter:SetDirty()
			end

			if arg_46_1.time_ >= var_49_1 + var_49_6 and arg_46_1.time_ < var_49_1 + var_49_6 + arg_49_0 then
				arg_46_1.typewritter.percent = 1

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(true)
			end
		end

		arg_46_1.nodeConfigList_ = {}

		arg_46_1:InitPlayNodeList()
	end,
	Play319631012 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 319631012
		arg_50_1.duration_ = 3.47

		local var_50_0 = {
			zh = 1.999999999999,
			ja = 3.466
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
				arg_50_0:Play319631013(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 then
				arg_50_1.var_.moveOldPos10079ui_story = arg_50_1.actors_["10079ui_story"].transform.localPosition
			end

			local var_53_0 = 0.001

			if 0 <= arg_50_1.time_ and arg_50_1.time_ < 0 + var_53_0 then
				arg_50_1.actors_["10079ui_story"].transform.localPosition = Vector3.Lerp(arg_50_1.var_.moveOldPos10079ui_story, Vector3.New(-0.7, -0.95, -6.05), (arg_50_1.time_ - 0) / var_53_0)
				arg_50_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_50_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_50_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_50_1.actors_["10079ui_story"].transform.position).z)
				arg_50_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_50_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_50_1.actors_["10079ui_story"].transform.localEulerAngles = arg_50_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			if arg_50_1.time_ >= 0 + var_53_0 and arg_50_1.time_ < 0 + var_53_0 + arg_53_0 then
				arg_50_1.actors_["10079ui_story"].transform.localPosition = Vector3.New(-0.7, -0.95, -6.05)
				arg_50_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_50_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_50_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_50_1.actors_["10079ui_story"].transform.position).z)
				arg_50_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_50_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_50_1.actors_["10079ui_story"].transform.localEulerAngles = arg_50_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			local var_53_1 = arg_50_1.actors_["10079ui_story"]

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 and not isNil(var_53_1) and arg_50_1.var_.characterEffect10079ui_story == nil then
				arg_50_1.var_.characterEffect10079ui_story = var_53_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_53_2 = 0.200000002980232

			if 0 <= arg_50_1.time_ and arg_50_1.time_ < 0 + var_53_2 and not isNil(var_53_1) then
				if arg_50_1.var_.characterEffect10079ui_story and not isNil(var_53_1) then
					arg_50_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_50_1.time_ >= 0 + var_53_2 and arg_50_1.time_ < 0 + var_53_2 + arg_53_0 and not isNil(var_53_1) and arg_50_1.var_.characterEffect10079ui_story then
				arg_50_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 then
				arg_50_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_53_4 = 0
			local var_53_5 = 0.1

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= var_53_4 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, true)

				arg_50_1.leftNameTxt_.text = arg_50_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_50_1.leftNameTxt_.transform)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1.leftNameTxt_.text)
				SetActive(arg_50_1.iconTrs_.gameObject, false)
				arg_50_1.callingController_:SetSelectedState("normal")

				local var_53_6 = arg_50_1:GetWordFromCfg(319631012)
				local var_53_7 = arg_50_1:FormatText(var_53_6.content)

				arg_50_1.text_.text = var_53_7

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_9 = 4 <= 0 and var_53_5 or var_53_5 * (utf8.len(var_53_7) / 4)

				if (4 <= 0 and var_53_5 or var_53_5 * (utf8.len(var_53_7) / 4)) > 0 and var_53_5 < var_53_9 then
					arg_50_1.talkMaxDuration = var_53_9

					if var_53_9 + var_53_4 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_9 + var_53_4
					end
				end

				arg_50_1.text_.text = var_53_7
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319631", "319631012", "story_v_out_319631.awb") ~= 0 then
					local var_53_10 = manager.audio:GetVoiceLength("story_v_out_319631", "319631012", "story_v_out_319631.awb") / 1000

					if var_53_10 + var_53_4 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_10 + var_53_4
					end

					if var_53_6.prefab_name ~= "" and arg_50_1.actors_[var_53_6.prefab_name] ~= nil then
						local var_53_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_50_1.actors_[var_53_6.prefab_name].transform, "story_v_out_319631", "319631012", "story_v_out_319631.awb")

						arg_50_1:RecordAudio("319631012", var_53_11)
						arg_50_1:RecordAudio("319631012", var_53_11)
					else
						arg_50_1:AudioAction("play", "voice", "story_v_out_319631", "319631012", "story_v_out_319631.awb")
					end

					arg_50_1:RecordHistoryTalkVoice("story_v_out_319631", "319631012", "story_v_out_319631.awb")
				end

				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_12 = math.max(var_53_5, arg_50_1.talkMaxDuration)

			if var_53_4 <= arg_50_1.time_ and arg_50_1.time_ < var_53_4 + var_53_12 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - var_53_4) / var_53_12

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= var_53_4 + var_53_12 and arg_50_1.time_ < var_53_4 + var_53_12 + arg_53_0 then
				arg_50_1.typewritter.percent = 1

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(true)
			end
		end

		arg_50_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_50_1:InitPlayNodeList()
	end,
	Play319631013 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 319631013
		arg_54_1.duration_ = 5.17

		local var_54_0 = {
			zh = 4.333,
			ja = 5.166
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
				arg_54_0:Play319631014(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 then
				arg_54_1.var_.moveOldPos1095ui_story = arg_54_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_57_0 = 0.001

			if 0 <= arg_54_1.time_ and arg_54_1.time_ < 0 + var_57_0 then
				arg_54_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_54_1.var_.moveOldPos1095ui_story, Vector3.New(0.7, -0.98, -6.1), (arg_54_1.time_ - 0) / var_57_0)
				arg_54_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_54_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_54_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_54_1.actors_["1095ui_story"].transform.position).z)
				arg_54_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_54_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_54_1.actors_["1095ui_story"].transform.localEulerAngles = arg_54_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_54_1.time_ >= 0 + var_57_0 and arg_54_1.time_ < 0 + var_57_0 + arg_57_0 then
				arg_54_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0.7, -0.98, -6.1)
				arg_54_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_54_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_54_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_54_1.actors_["1095ui_story"].transform.position).z)
				arg_54_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_54_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_54_1.actors_["1095ui_story"].transform.localEulerAngles = arg_54_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_57_1 = arg_54_1.actors_["1095ui_story"]

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 and not isNil(var_57_1) and arg_54_1.var_.characterEffect1095ui_story == nil then
				arg_54_1.var_.characterEffect1095ui_story = var_57_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_57_2 = 0.200000002980232

			if 0 <= arg_54_1.time_ and arg_54_1.time_ < 0 + var_57_2 and not isNil(var_57_1) then
				if arg_54_1.var_.characterEffect1095ui_story and not isNil(var_57_1) then
					arg_54_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_54_1.time_ >= 0 + var_57_2 and arg_54_1.time_ < 0 + var_57_2 + arg_57_0 and not isNil(var_57_1) and arg_54_1.var_.characterEffect1095ui_story then
				arg_54_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 then
				arg_54_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 then
				arg_54_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_57_4 = arg_54_1.actors_["10079ui_story"]

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 and not isNil(var_57_4) and arg_54_1.var_.characterEffect10079ui_story == nil then
				arg_54_1.var_.characterEffect10079ui_story = var_57_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_57_5 = 0.200000002980232

			if 0 <= arg_54_1.time_ and arg_54_1.time_ < 0 + var_57_5 and not isNil(var_57_4) then
				if arg_54_1.var_.characterEffect10079ui_story and not isNil(var_57_4) then
					arg_54_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_54_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_54_1.time_ - 0) / var_57_5)
				end
			end

			if arg_54_1.time_ >= 0 + var_57_5 and arg_54_1.time_ < 0 + var_57_5 + arg_57_0 and not isNil(var_57_4) and arg_54_1.var_.characterEffect10079ui_story then
				arg_54_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_54_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			local var_57_6 = 0
			local var_57_7 = 0.45

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= var_57_6 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, true)

				arg_54_1.leftNameTxt_.text = arg_54_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_54_1.leftNameTxt_.transform)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1.leftNameTxt_.text)
				SetActive(arg_54_1.iconTrs_.gameObject, false)
				arg_54_1.callingController_:SetSelectedState("normal")

				local var_57_8 = arg_54_1:GetWordFromCfg(319631013)
				local var_57_9 = arg_54_1:FormatText(var_57_8.content)

				arg_54_1.text_.text = var_57_9

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_11 = 18 <= 0 and var_57_7 or var_57_7 * (utf8.len(var_57_9) / 18)

				if (18 <= 0 and var_57_7 or var_57_7 * (utf8.len(var_57_9) / 18)) > 0 and var_57_7 < var_57_11 then
					arg_54_1.talkMaxDuration = var_57_11

					if var_57_11 + var_57_6 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_11 + var_57_6
					end
				end

				arg_54_1.text_.text = var_57_9
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319631", "319631013", "story_v_out_319631.awb") ~= 0 then
					local var_57_12 = manager.audio:GetVoiceLength("story_v_out_319631", "319631013", "story_v_out_319631.awb") / 1000

					if var_57_12 + var_57_6 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_12 + var_57_6
					end

					if var_57_8.prefab_name ~= "" and arg_54_1.actors_[var_57_8.prefab_name] ~= nil then
						local var_57_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_54_1.actors_[var_57_8.prefab_name].transform, "story_v_out_319631", "319631013", "story_v_out_319631.awb")

						arg_54_1:RecordAudio("319631013", var_57_13)
						arg_54_1:RecordAudio("319631013", var_57_13)
					else
						arg_54_1:AudioAction("play", "voice", "story_v_out_319631", "319631013", "story_v_out_319631.awb")
					end

					arg_54_1:RecordHistoryTalkVoice("story_v_out_319631", "319631013", "story_v_out_319631.awb")
				end

				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_14 = math.max(var_57_7, arg_54_1.talkMaxDuration)

			if var_57_6 <= arg_54_1.time_ and arg_54_1.time_ < var_57_6 + var_57_14 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - var_57_6) / var_57_14

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= var_57_6 + var_57_14 and arg_54_1.time_ < var_57_6 + var_57_14 + arg_57_0 then
				arg_54_1.typewritter.percent = 1

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(true)
			end
		end

		arg_54_1.nodeConfigList_ = {
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

		arg_54_1:InitPlayNodeList()
	end,
	Play319631014 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 319631014
		arg_58_1.duration_ = 3.3

		local var_58_0 = {
			zh = 3.3,
			ja = 2.5
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
				arg_58_0:Play319631015(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 then
				arg_58_1.var_.moveOldPos10079ui_story = arg_58_1.actors_["10079ui_story"].transform.localPosition
			end

			local var_61_0 = 0.001

			if 0 <= arg_58_1.time_ and arg_58_1.time_ < 0 + var_61_0 then
				arg_58_1.actors_["10079ui_story"].transform.localPosition = Vector3.Lerp(arg_58_1.var_.moveOldPos10079ui_story, Vector3.New(-0.7, -0.95, -6.05), (arg_58_1.time_ - 0) / var_61_0)
				arg_58_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_58_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_58_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_58_1.actors_["10079ui_story"].transform.position).z)
				arg_58_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_58_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_58_1.actors_["10079ui_story"].transform.localEulerAngles = arg_58_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			if arg_58_1.time_ >= 0 + var_61_0 and arg_58_1.time_ < 0 + var_61_0 + arg_61_0 then
				arg_58_1.actors_["10079ui_story"].transform.localPosition = Vector3.New(-0.7, -0.95, -6.05)
				arg_58_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_58_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_58_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_58_1.actors_["10079ui_story"].transform.position).z)
				arg_58_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_58_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_58_1.actors_["10079ui_story"].transform.localEulerAngles = arg_58_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			local var_61_1 = arg_58_1.actors_["10079ui_story"]

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 and not isNil(var_61_1) and arg_58_1.var_.characterEffect10079ui_story == nil then
				arg_58_1.var_.characterEffect10079ui_story = var_61_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_61_2 = 0.200000002980232

			if 0 <= arg_58_1.time_ and arg_58_1.time_ < 0 + var_61_2 and not isNil(var_61_1) then
				if arg_58_1.var_.characterEffect10079ui_story and not isNil(var_61_1) then
					arg_58_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_58_1.time_ >= 0 + var_61_2 and arg_58_1.time_ < 0 + var_61_2 + arg_61_0 and not isNil(var_61_1) and arg_58_1.var_.characterEffect10079ui_story then
				arg_58_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 then
				arg_58_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			local var_61_4 = arg_58_1.actors_["1095ui_story"]

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 and not isNil(var_61_4) and arg_58_1.var_.characterEffect1095ui_story == nil then
				arg_58_1.var_.characterEffect1095ui_story = var_61_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_61_5 = 0.200000002980232

			if 0 <= arg_58_1.time_ and arg_58_1.time_ < 0 + var_61_5 and not isNil(var_61_4) then
				if arg_58_1.var_.characterEffect1095ui_story and not isNil(var_61_4) then
					arg_58_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_58_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_58_1.time_ - 0) / var_61_5)
				end
			end

			if arg_58_1.time_ >= 0 + var_61_5 and arg_58_1.time_ < 0 + var_61_5 + arg_61_0 and not isNil(var_61_4) and arg_58_1.var_.characterEffect1095ui_story then
				arg_58_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_58_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_61_6 = 0
			local var_61_7 = 0.175

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= var_61_6 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, true)

				arg_58_1.leftNameTxt_.text = arg_58_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, false)
				arg_58_1.callingController_:SetSelectedState("normal")

				local var_61_8 = arg_58_1:GetWordFromCfg(319631014)
				local var_61_9 = arg_58_1:FormatText(var_61_8.content)

				arg_58_1.text_.text = var_61_9

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_11 = 7 <= 0 and var_61_7 or var_61_7 * (utf8.len(var_61_9) / 7)

				if (7 <= 0 and var_61_7 or var_61_7 * (utf8.len(var_61_9) / 7)) > 0 and var_61_7 < var_61_11 then
					arg_58_1.talkMaxDuration = var_61_11

					if var_61_11 + var_61_6 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_11 + var_61_6
					end
				end

				arg_58_1.text_.text = var_61_9
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319631", "319631014", "story_v_out_319631.awb") ~= 0 then
					local var_61_12 = manager.audio:GetVoiceLength("story_v_out_319631", "319631014", "story_v_out_319631.awb") / 1000

					if var_61_12 + var_61_6 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_12 + var_61_6
					end

					if var_61_8.prefab_name ~= "" and arg_58_1.actors_[var_61_8.prefab_name] ~= nil then
						local var_61_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_58_1.actors_[var_61_8.prefab_name].transform, "story_v_out_319631", "319631014", "story_v_out_319631.awb")

						arg_58_1:RecordAudio("319631014", var_61_13)
						arg_58_1:RecordAudio("319631014", var_61_13)
					else
						arg_58_1:AudioAction("play", "voice", "story_v_out_319631", "319631014", "story_v_out_319631.awb")
					end

					arg_58_1:RecordHistoryTalkVoice("story_v_out_319631", "319631014", "story_v_out_319631.awb")
				end

				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_14 = math.max(var_61_7, arg_58_1.talkMaxDuration)

			if var_61_6 <= arg_58_1.time_ and arg_58_1.time_ < var_61_6 + var_61_14 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_6) / var_61_14

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_6 + var_61_14 and arg_58_1.time_ < var_61_6 + var_61_14 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_58_1:InitPlayNodeList()
	end,
	Play319631015 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 319631015
		arg_62_1.duration_ = 3.4

		SetActive(arg_62_1.tipsGo_, false)

		function arg_62_1.onSingleLineFinish_()
			arg_62_1.onSingleLineUpdate_ = nil
			arg_62_1.onSingleLineFinish_ = nil
			arg_62_1.state_ = "waiting"
		end

		function arg_62_1.playNext_(arg_64_0)
			if arg_64_0 == 1 then
				arg_62_0:Play319631016(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 then
				arg_62_1.fswbg_:SetActive(true)
				arg_62_1.dialog_:SetActive(false)

				arg_62_1.fswtw_.percent = 0
				arg_62_1.fswt_.text = arg_62_1:FormatText(arg_62_1:GetWordFromCfg(319631015).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.fswt_)

				arg_62_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_62_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_62_1.fswtw_:SetDirty()

				arg_62_1.typewritterCharCountI18N = 0

				SetActive(arg_62_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_62_1:ShowNextGo(false)
			end

			local var_65_0 = 0.2

			if 0.2 < arg_62_1.time_ and arg_62_1.time_ <= var_65_0 + arg_65_0 then
				arg_62_1.var_.oldValueTypewriter = arg_62_1.fswtw_.percent

				SetActive(arg_62_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_62_1:ShowNextGo(false)
			end

			local var_65_1 = 48
			local var_65_2 = 3.2
			local var_65_3, var_65_4 = arg_62_1:GetPercentByPara(arg_62_1:FormatText(arg_62_1:GetWordFromCfg(319631015).content), 1)

			if var_65_0 < arg_62_1.time_ and arg_62_1.time_ <= var_65_0 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0

				local var_65_5 = var_65_1 <= 0 and var_65_2 or var_65_2 * ((var_65_4 - arg_62_1.typewritterCharCountI18N) / var_65_1)

				if (var_65_1 <= 0 and var_65_2 or var_65_2 * ((var_65_4 - arg_62_1.typewritterCharCountI18N) / var_65_1)) > 0 and var_65_2 < var_65_5 then
					arg_62_1.talkMaxDuration = var_65_5

					if var_65_5 + var_65_0 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_5 + var_65_0
					end
				end
			end

			local var_65_6 = math.max(3.2, arg_62_1.talkMaxDuration)

			if var_65_0 <= arg_62_1.time_ and arg_62_1.time_ < var_65_0 + var_65_6 then
				arg_62_1.fswtw_.percent = Mathf.Lerp(arg_62_1.var_.oldValueTypewriter, var_65_3, (arg_62_1.time_ - var_65_0) / var_65_6)
				arg_62_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_62_1.fswtw_:SetDirty()
			end

			if arg_62_1.time_ >= var_65_0 + var_65_6 and arg_62_1.time_ < var_65_0 + var_65_6 + arg_65_0 then
				arg_62_1.fswtw_.percent = var_65_3

				arg_62_1.fswtw_:SetDirty()
				arg_62_1:ShowNextGo(true)

				arg_62_1.typewritterCharCountI18N = var_65_4
			end

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 then
				local var_65_7 = arg_62_1.fswbg_.transform:Find("textbox/adapt/content") or arg_62_1.fswbg_.transform:Find("textbox/content")
				local var_65_8 = arg_62_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_65_9 = var_65_7:GetComponent("RectTransform")

				var_65_7:GetComponent("Text").alignment = UnityEngine.TextAnchor.LowerCenter
				var_65_9.offsetMin = Vector2.New(0, 0)
				var_65_9.offsetMax = Vector2.New(0, 0)
			end

			local var_65_10 = "STblack"

			if arg_62_1.bgs_.STblack == nil then
				local var_65_11 = Object.Instantiate(arg_62_1.paintGo_)

				var_65_11:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_65_10)
				var_65_11.name = var_65_10
				var_65_11.transform.parent = arg_62_1.stage_.transform
				var_65_11.transform.localPosition = Vector3.New(0, 100, 0)
				arg_62_1.bgs_[var_65_10] = var_65_11
			end

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 then
				local var_65_12 = arg_62_1.bgs_.STblack

				arg_62_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_65_12.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_65_13 = var_65_12:GetComponent("SpriteRenderer")

				if var_65_13 and var_65_13.sprite then
					local var_65_14 = 2 * (var_65_12.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_65_12.transform.localScale = Vector3.New(var_65_14 / var_65_13.sprite.bounds.size.y < var_65_14 * manager.ui.mainCameraCom_.aspect / var_65_13.sprite.bounds.size.x and var_65_14 * manager.ui.mainCameraCom_.aspect / var_65_13.sprite.bounds.size.x or var_65_14 / var_65_13.sprite.bounds.size.y, var_65_14 / var_65_13.sprite.bounds.size.y < var_65_14 * manager.ui.mainCameraCom_.aspect / var_65_13.sprite.bounds.size.x and var_65_14 * manager.ui.mainCameraCom_.aspect / var_65_13.sprite.bounds.size.x or var_65_14 / var_65_13.sprite.bounds.size.y, 0)
				end

				for iter_65_0, iter_65_1 in pairs(arg_62_1.bgs_) do
					if iter_65_0 ~= "STblack" then
						iter_65_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_65_15 = arg_62_1.actors_["1095ui_story"].transform

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 then
				arg_62_1.var_.moveOldPos1095ui_story = var_65_15.localPosition
			end

			local var_65_16 = 0.001

			if 0 <= arg_62_1.time_ and arg_62_1.time_ < 0 + var_65_16 then
				var_65_15.localPosition = Vector3.Lerp(arg_62_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_62_1.time_ - 0) / var_65_16)
				var_65_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_65_15.position).x, (manager.ui.mainCamera.transform.position - var_65_15.position).y, (manager.ui.mainCamera.transform.position - var_65_15.position).z)
				var_65_15.localEulerAngles.z = 0
				var_65_15.localEulerAngles.x = 0
				var_65_15.localEulerAngles = var_65_15.localEulerAngles
			end

			if arg_62_1.time_ >= 0 + var_65_16 and arg_62_1.time_ < 0 + var_65_16 + arg_65_0 then
				var_65_15.localPosition = Vector3.New(0, 100, 0)
				var_65_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_65_15.position).x, (manager.ui.mainCamera.transform.position - var_65_15.position).y, (manager.ui.mainCamera.transform.position - var_65_15.position).z)
				var_65_15.localEulerAngles.z = 0
				var_65_15.localEulerAngles.x = 0
				var_65_15.localEulerAngles = var_65_15.localEulerAngles
			end

			local var_65_17 = arg_62_1.actors_["10079ui_story"].transform

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 then
				arg_62_1.var_.moveOldPos10079ui_story = var_65_17.localPosition
			end

			local var_65_18 = 0.001

			if 0 <= arg_62_1.time_ and arg_62_1.time_ < 0 + var_65_18 then
				var_65_17.localPosition = Vector3.Lerp(arg_62_1.var_.moveOldPos10079ui_story, Vector3.New(0, 100, 0), (arg_62_1.time_ - 0) / var_65_18)
				var_65_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_65_17.position).x, (manager.ui.mainCamera.transform.position - var_65_17.position).y, (manager.ui.mainCamera.transform.position - var_65_17.position).z)
				var_65_17.localEulerAngles.z = 0
				var_65_17.localEulerAngles.x = 0
				var_65_17.localEulerAngles = var_65_17.localEulerAngles
			end

			if arg_62_1.time_ >= 0 + var_65_18 and arg_62_1.time_ < 0 + var_65_18 + arg_65_0 then
				var_65_17.localPosition = Vector3.New(0, 100, 0)
				var_65_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_65_17.position).x, (manager.ui.mainCamera.transform.position - var_65_17.position).y, (manager.ui.mainCamera.transform.position - var_65_17.position).z)
				var_65_17.localEulerAngles.z = 0
				var_65_17.localEulerAngles.x = 0
				var_65_17.localEulerAngles = var_65_17.localEulerAngles
			end

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 then
				arg_62_1.cswbg_:SetActive(true)

				local var_65_19 = arg_62_1.cswt_:GetComponent("RectTransform")

				arg_62_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_65_19.offsetMin = Vector2.New(410, 330)
				var_65_19.offsetMax = Vector2.New(-400, -175)
				arg_62_1.cswt_.text = arg_62_1:FormatText(arg_62_1:GetWordFromCfg(419034).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.cswt_)

				arg_62_1.cswt_.fontSize = 180
				arg_62_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_62_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_62_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end
		end

		arg_62_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_62_1:InitPlayNodeList()
	end,
	Play319631016 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 319631016
		arg_66_1.duration_ = 1.13

		SetActive(arg_66_1.tipsGo_, false)

		function arg_66_1.onSingleLineFinish_()
			arg_66_1.onSingleLineUpdate_ = nil
			arg_66_1.onSingleLineFinish_ = nil
			arg_66_1.state_ = "waiting"
		end

		function arg_66_1.playNext_(arg_68_0)
			if arg_68_0 == 1 then
				arg_66_0:Play319631017(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 and not isNil(arg_66_1.actors_["10079ui_story"]) and arg_66_1.var_.characterEffect10079ui_story == nil then
				arg_66_1.var_.characterEffect10079ui_story = arg_66_1.actors_["10079ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_69_0 = 0.200000002980232

			if 0 <= arg_66_1.time_ and arg_66_1.time_ < 0 + var_69_0 and not isNil(arg_66_1.actors_["10079ui_story"]) then
				if arg_66_1.var_.characterEffect10079ui_story and not isNil(arg_66_1.actors_["10079ui_story"]) then
					arg_66_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_66_1.time_ >= 0 + var_69_0 and arg_66_1.time_ < 0 + var_69_0 + arg_69_0 and not isNil(arg_66_1.actors_["10079ui_story"]) and arg_66_1.var_.characterEffect10079ui_story then
				arg_66_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 then
				arg_66_1.fswbg_:SetActive(true)
				arg_66_1.dialog_:SetActive(false)

				arg_66_1.fswtw_.percent = 0
				arg_66_1.fswt_.text = arg_66_1:FormatText(arg_66_1:GetWordFromCfg(319631016).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.fswt_)

				arg_66_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_66_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_66_1.fswtw_:SetDirty()

				arg_66_1.typewritterCharCountI18N = 0

				SetActive(arg_66_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_66_1:ShowNextGo(false)
			end

			local var_69_2 = 0.3

			if 0.3 < arg_66_1.time_ and arg_66_1.time_ <= var_69_2 + arg_69_0 then
				arg_66_1.var_.oldValueTypewriter = arg_66_1.fswtw_.percent

				SetActive(arg_66_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_66_1:ShowNextGo(false)
			end

			local var_69_3 = 6
			local var_69_4 = 0.4
			local var_69_5, var_69_6 = arg_66_1:GetPercentByPara(arg_66_1:FormatText(arg_66_1:GetWordFromCfg(319631016).content), 1)

			if var_69_2 < arg_66_1.time_ and arg_66_1.time_ <= var_69_2 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0

				local var_69_7 = var_69_3 <= 0 and var_69_4 or var_69_4 * ((var_69_6 - arg_66_1.typewritterCharCountI18N) / var_69_3)

				if (var_69_3 <= 0 and var_69_4 or var_69_4 * ((var_69_6 - arg_66_1.typewritterCharCountI18N) / var_69_3)) > 0 and var_69_4 < var_69_7 then
					arg_66_1.talkMaxDuration = var_69_7

					if var_69_7 + var_69_2 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_7 + var_69_2
					end
				end
			end

			local var_69_8 = math.max(0.4, arg_66_1.talkMaxDuration)

			if var_69_2 <= arg_66_1.time_ and arg_66_1.time_ < var_69_2 + var_69_8 then
				arg_66_1.fswtw_.percent = Mathf.Lerp(arg_66_1.var_.oldValueTypewriter, var_69_5, (arg_66_1.time_ - var_69_2) / var_69_8)
				arg_66_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_66_1.fswtw_:SetDirty()
			end

			if arg_66_1.time_ >= var_69_2 + var_69_8 and arg_66_1.time_ < var_69_2 + var_69_8 + arg_69_0 then
				arg_66_1.fswtw_.percent = var_69_5

				arg_66_1.fswtw_:SetDirty()
				arg_66_1:ShowNextGo(true)

				arg_66_1.typewritterCharCountI18N = var_69_6
			end

			local var_69_9 = 0
			local var_69_10 = manager.audio:GetVoiceLength("story_v_out_319631", "319631016", "story_v_out_319631.awb") / 1000

			if var_69_10 > 0 and 1 < var_69_10 and var_69_10 + var_69_9 > arg_66_1.duration_ then
				arg_66_1.duration_ = var_69_10 + var_69_9
			end

			if var_69_9 < arg_66_1.time_ and arg_66_1.time_ <= var_69_9 + arg_69_0 then
				arg_66_1:AudioAction("play", "voice", "story_v_out_319631", "319631016", "story_v_out_319631.awb")
			end

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 then
				arg_66_1.cswbg_:SetActive(true)

				local var_69_12 = arg_66_1.cswt_:GetComponent("RectTransform")

				arg_66_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_69_12.offsetMin = Vector2.New(410, 330)
				var_69_12.offsetMax = Vector2.New(-400, -175)
				arg_66_1.cswt_.text = arg_66_1:FormatText(arg_66_1:GetWordFromCfg(419035).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.cswt_)

				arg_66_1.cswt_.fontSize = 180
				arg_66_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_66_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_66_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end
		end

		arg_66_1.nodeConfigList_ = {}

		arg_66_1:InitPlayNodeList()
	end,
	Play319631017 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 319631017
		arg_70_1.duration_ = 2.17

		SetActive(arg_70_1.tipsGo_, false)

		function arg_70_1.onSingleLineFinish_()
			arg_70_1.onSingleLineUpdate_ = nil
			arg_70_1.onSingleLineFinish_ = nil
			arg_70_1.state_ = "waiting"
		end

		function arg_70_1.playNext_(arg_72_0)
			if arg_72_0 == 1 then
				arg_70_0:Play319631018(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 then
				arg_70_1.var_.moveOldPos1095ui_story = arg_70_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_73_0 = 0.001

			if 0 <= arg_70_1.time_ and arg_70_1.time_ < 0 + var_73_0 then
				arg_70_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_70_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_70_1.time_ - 0) / var_73_0)
				arg_70_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_70_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_70_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_70_1.actors_["1095ui_story"].transform.position).z)
				arg_70_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_70_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_70_1.actors_["1095ui_story"].transform.localEulerAngles = arg_70_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_70_1.time_ >= 0 + var_73_0 and arg_70_1.time_ < 0 + var_73_0 + arg_73_0 then
				arg_70_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_70_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_70_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_70_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_70_1.actors_["1095ui_story"].transform.position).z)
				arg_70_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_70_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_70_1.actors_["1095ui_story"].transform.localEulerAngles = arg_70_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 then
				arg_70_1.fswbg_:SetActive(true)
				arg_70_1.dialog_:SetActive(false)

				arg_70_1.fswtw_.percent = 0
				arg_70_1.fswt_.text = arg_70_1:FormatText(arg_70_1:GetWordFromCfg(319631017).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.fswt_)

				arg_70_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_70_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_70_1.fswtw_:SetDirty()

				arg_70_1.typewritterCharCountI18N = 0

				SetActive(arg_70_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_70_1:ShowNextGo(false)
			end

			local var_73_1 = 0.0166666666666667

			if 0.0166666666666667 < arg_70_1.time_ and arg_70_1.time_ <= var_73_1 + arg_73_0 then
				arg_70_1.var_.oldValueTypewriter = arg_70_1.fswtw_.percent

				SetActive(arg_70_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_70_1:ShowNextGo(false)
			end

			local var_73_2 = 8
			local var_73_3 = 0.533333333333333
			local var_73_4, var_73_5 = arg_70_1:GetPercentByPara(arg_70_1:FormatText(arg_70_1:GetWordFromCfg(319631017).content), 1)

			if var_73_1 < arg_70_1.time_ and arg_70_1.time_ <= var_73_1 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0

				local var_73_6 = var_73_2 <= 0 and var_73_3 or var_73_3 * ((var_73_5 - arg_70_1.typewritterCharCountI18N) / var_73_2)

				if (var_73_2 <= 0 and var_73_3 or var_73_3 * ((var_73_5 - arg_70_1.typewritterCharCountI18N) / var_73_2)) > 0 and var_73_3 < var_73_6 then
					arg_70_1.talkMaxDuration = var_73_6

					if var_73_6 + var_73_1 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_6 + var_73_1
					end
				end
			end

			local var_73_7 = math.max(0.533333333333333, arg_70_1.talkMaxDuration)

			if var_73_1 <= arg_70_1.time_ and arg_70_1.time_ < var_73_1 + var_73_7 then
				arg_70_1.fswtw_.percent = Mathf.Lerp(arg_70_1.var_.oldValueTypewriter, var_73_4, (arg_70_1.time_ - var_73_1) / var_73_7)
				arg_70_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_70_1.fswtw_:SetDirty()
			end

			if arg_70_1.time_ >= var_73_1 + var_73_7 and arg_70_1.time_ < var_73_1 + var_73_7 + arg_73_0 then
				arg_70_1.fswtw_.percent = var_73_4

				arg_70_1.fswtw_:SetDirty()
				arg_70_1:ShowNextGo(true)

				arg_70_1.typewritterCharCountI18N = var_73_5
			end

			local var_73_8 = 0
			local var_73_9 = manager.audio:GetVoiceLength("story_v_out_319631", "319631017", "story_v_out_319631.awb") / 1000

			if var_73_9 > 0 and 2.166 < var_73_9 and var_73_9 + var_73_8 > arg_70_1.duration_ then
				arg_70_1.duration_ = var_73_9 + var_73_8
			end

			if var_73_8 < arg_70_1.time_ and arg_70_1.time_ <= var_73_8 + arg_73_0 then
				arg_70_1:AudioAction("play", "voice", "story_v_out_319631", "319631017", "story_v_out_319631.awb")
			end
		end

		arg_70_1.nodeConfigList_ = {
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

		arg_70_1:InitPlayNodeList()
	end,
	Play319631018 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 319631018
		arg_74_1.duration_ = 3.7

		local var_74_0 = {
			zh = 2.233,
			ja = 3.7
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
				arg_74_0:Play319631019(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 then
				arg_74_1.var_.moveOldPos1095ui_story = arg_74_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_77_0 = 0.001

			if 0 <= arg_74_1.time_ and arg_74_1.time_ < 0 + var_77_0 then
				arg_74_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_74_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_74_1.time_ - 0) / var_77_0)
				arg_74_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_74_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_74_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_74_1.actors_["1095ui_story"].transform.position).z)
				arg_74_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_74_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_74_1.actors_["1095ui_story"].transform.localEulerAngles = arg_74_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_74_1.time_ >= 0 + var_77_0 and arg_74_1.time_ < 0 + var_77_0 + arg_77_0 then
				arg_74_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_74_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_74_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_74_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_74_1.actors_["1095ui_story"].transform.position).z)
				arg_74_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_74_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_74_1.actors_["1095ui_story"].transform.localEulerAngles = arg_74_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_77_1 = arg_74_1.actors_["1095ui_story"]

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 and not isNil(var_77_1) and arg_74_1.var_.characterEffect1095ui_story == nil then
				arg_74_1.var_.characterEffect1095ui_story = var_77_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_77_2 = 0.200000002980232

			if 0 <= arg_74_1.time_ and arg_74_1.time_ < 0 + var_77_2 and not isNil(var_77_1) then
				if arg_74_1.var_.characterEffect1095ui_story and not isNil(var_77_1) then
					arg_74_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_74_1.time_ >= 0 + var_77_2 and arg_74_1.time_ < 0 + var_77_2 + arg_77_0 and not isNil(var_77_1) and arg_74_1.var_.characterEffect1095ui_story then
				arg_74_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 then
				arg_74_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 then
				arg_74_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_77_4 = arg_74_1.actors_["10079ui_story"]

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 and not isNil(var_77_4) and arg_74_1.var_.characterEffect10079ui_story == nil then
				arg_74_1.var_.characterEffect10079ui_story = var_77_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_77_5 = 0.200000002980232

			if 0 <= arg_74_1.time_ and arg_74_1.time_ < 0 + var_77_5 and not isNil(var_77_4) then
				if arg_74_1.var_.characterEffect10079ui_story and not isNil(var_77_4) then
					arg_74_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_74_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_74_1.time_ - 0) / var_77_5)
				end
			end

			if arg_74_1.time_ >= 0 + var_77_5 and arg_74_1.time_ < 0 + var_77_5 + arg_77_0 and not isNil(var_77_4) and arg_74_1.var_.characterEffect10079ui_story then
				arg_74_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_74_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			local var_77_6 = arg_74_1.actors_["10079ui_story"].transform

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 then
				arg_74_1.var_.moveOldPos10079ui_story = var_77_6.localPosition
			end

			local var_77_7 = 0.001

			if 0 <= arg_74_1.time_ and arg_74_1.time_ < 0 + var_77_7 then
				var_77_6.localPosition = Vector3.Lerp(arg_74_1.var_.moveOldPos10079ui_story, Vector3.New(0, 100, 0), (arg_74_1.time_ - 0) / var_77_7)
				var_77_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_77_6.position).x, (manager.ui.mainCamera.transform.position - var_77_6.position).y, (manager.ui.mainCamera.transform.position - var_77_6.position).z)
				var_77_6.localEulerAngles.z = 0
				var_77_6.localEulerAngles.x = 0
				var_77_6.localEulerAngles = var_77_6.localEulerAngles
			end

			if arg_74_1.time_ >= 0 + var_77_7 and arg_74_1.time_ < 0 + var_77_7 + arg_77_0 then
				var_77_6.localPosition = Vector3.New(0, 100, 0)
				var_77_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_77_6.position).x, (manager.ui.mainCamera.transform.position - var_77_6.position).y, (manager.ui.mainCamera.transform.position - var_77_6.position).z)
				var_77_6.localEulerAngles.z = 0
				var_77_6.localEulerAngles.x = 0
				var_77_6.localEulerAngles = var_77_6.localEulerAngles
			end

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 then
				arg_74_1.fswbg_:SetActive(false)
				arg_74_1.dialog_:SetActive(false)
				SetActive(arg_74_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_74_1:ShowNextGo(false)
			end

			if 0.0166666666666667 < arg_74_1.time_ and arg_74_1.time_ <= 0.0166666666666667 + arg_77_0 then
				arg_74_1.fswbg_:SetActive(false)
				arg_74_1.dialog_:SetActive(false)
				SetActive(arg_74_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_74_1:ShowNextGo(false)
			end

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 then
				arg_74_1.cswbg_:SetActive(false)
			end

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 then
				local var_77_8 = arg_74_1.bgs_.Z03f

				arg_74_1.bgs_.Z03f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_77_8.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_77_9 = var_77_8:GetComponent("SpriteRenderer")

				if var_77_9 and var_77_9.sprite then
					local var_77_10 = 2 * (var_77_8.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_77_8.transform.localScale = Vector3.New(var_77_10 / var_77_9.sprite.bounds.size.y < var_77_10 * manager.ui.mainCameraCom_.aspect / var_77_9.sprite.bounds.size.x and var_77_10 * manager.ui.mainCameraCom_.aspect / var_77_9.sprite.bounds.size.x or var_77_10 / var_77_9.sprite.bounds.size.y, var_77_10 / var_77_9.sprite.bounds.size.y < var_77_10 * manager.ui.mainCameraCom_.aspect / var_77_9.sprite.bounds.size.x and var_77_10 * manager.ui.mainCameraCom_.aspect / var_77_9.sprite.bounds.size.x or var_77_10 / var_77_9.sprite.bounds.size.y, 0)
				end

				for iter_77_0, iter_77_1 in pairs(arg_74_1.bgs_) do
					if iter_77_0 ~= "Z03f" then
						iter_77_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if arg_74_1.frameCnt_ <= 1 then
				arg_74_1.dialog_:SetActive(false)
			end

			local var_77_11 = 0.1
			local var_77_12 = 0.275

			if 0.1 < arg_74_1.time_ and arg_74_1.time_ <= var_77_11 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0

				arg_74_1.dialog_:SetActive(true)

				arg_74_1.dialogCg_.alpha = 0

				local var_77_13 = LeanTween.value(arg_74_1.dialog_, 0, 1, 0.3)

				var_77_13:setOnUpdate(LuaHelper.FloatAction(function(arg_78_0)
					arg_74_1.dialogCg_.alpha = arg_78_0
				end))
				var_77_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_74_1.dialog_)
					var_77_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_74_1.duration_ = arg_74_1.duration_ + 0.3

				SetActive(arg_74_1.leftNameGo_, true)

				arg_74_1.leftNameTxt_.text = arg_74_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_74_1.leftNameTxt_.transform)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1.leftNameTxt_.text)
				SetActive(arg_74_1.iconTrs_.gameObject, false)
				arg_74_1.callingController_:SetSelectedState("normal")

				local var_77_14 = arg_74_1:GetWordFromCfg(319631018)
				local var_77_15 = arg_74_1:FormatText(var_77_14.content)

				arg_74_1.text_.text = var_77_15

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_17 = 11 <= 0 and var_77_12 or var_77_12 * (utf8.len(var_77_15) / 11)

				if (11 <= 0 and var_77_12 or var_77_12 * (utf8.len(var_77_15) / 11)) > 0 and var_77_12 < var_77_17 then
					arg_74_1.talkMaxDuration = var_77_17
					var_77_11 = var_77_11 + 0.3

					if var_77_17 + var_77_11 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_17 + var_77_11
					end
				end

				arg_74_1.text_.text = var_77_15
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319631", "319631018", "story_v_out_319631.awb") ~= 0 then
					local var_77_18 = manager.audio:GetVoiceLength("story_v_out_319631", "319631018", "story_v_out_319631.awb") / 1000

					if var_77_18 + var_77_11 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_18 + var_77_11
					end

					if var_77_14.prefab_name ~= "" and arg_74_1.actors_[var_77_14.prefab_name] ~= nil then
						local var_77_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_74_1.actors_[var_77_14.prefab_name].transform, "story_v_out_319631", "319631018", "story_v_out_319631.awb")

						arg_74_1:RecordAudio("319631018", var_77_19)
						arg_74_1:RecordAudio("319631018", var_77_19)
					else
						arg_74_1:AudioAction("play", "voice", "story_v_out_319631", "319631018", "story_v_out_319631.awb")
					end

					arg_74_1:RecordHistoryTalkVoice("story_v_out_319631", "319631018", "story_v_out_319631.awb")
				end

				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_20 = var_77_11 + 0.3
			local var_77_21 = math.max(var_77_12, arg_74_1.talkMaxDuration)

			if var_77_11 + 0.3 <= arg_74_1.time_ and arg_74_1.time_ < var_77_20 + var_77_21 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_20) / var_77_21

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_20 + var_77_21 and arg_74_1.time_ < var_77_20 + var_77_21 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_74_1:InitPlayNodeList()
	end,
	Play319631019 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 319631019
		arg_80_1.duration_ = 5

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play319631020(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 and not isNil(arg_80_1.actors_["1095ui_story"]) and arg_80_1.var_.characterEffect1095ui_story == nil then
				arg_80_1.var_.characterEffect1095ui_story = arg_80_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_0 = 0.200000002980232

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_0 and not isNil(arg_80_1.actors_["1095ui_story"]) then
				if arg_80_1.var_.characterEffect1095ui_story and not isNil(arg_80_1.actors_["1095ui_story"]) then
					arg_80_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_80_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_80_1.time_ - 0) / var_83_0)
				end
			end

			if arg_80_1.time_ >= 0 + var_83_0 and arg_80_1.time_ < 0 + var_83_0 + arg_83_0 and not isNil(arg_80_1.actors_["1095ui_story"]) and arg_80_1.var_.characterEffect1095ui_story then
				arg_80_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_80_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_83_1 = 0
			local var_83_2 = 0.7

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= var_83_1 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, false)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_3 = arg_80_1:FormatText(arg_80_1:GetWordFromCfg(319631019).content)

				arg_80_1.text_.text = var_83_3

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_5 = 28 <= 0 and var_83_2 or var_83_2 * (utf8.len(var_83_3) / 28)

				if (28 <= 0 and var_83_2 or var_83_2 * (utf8.len(var_83_3) / 28)) > 0 and var_83_2 < var_83_5 then
					arg_80_1.talkMaxDuration = var_83_5

					if var_83_5 + var_83_1 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_5 + var_83_1
					end
				end

				arg_80_1.text_.text = var_83_3
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)
				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_6 = math.max(var_83_2, arg_80_1.talkMaxDuration)

			if var_83_1 <= arg_80_1.time_ and arg_80_1.time_ < var_83_1 + var_83_6 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_1) / var_83_6

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_1 + var_83_6 and arg_80_1.time_ < var_83_1 + var_83_6 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {}

		arg_80_1:InitPlayNodeList()
	end,
	Play319631020 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 319631020
		arg_84_1.duration_ = 7.2

		local var_84_0 = {
			zh = 5.466,
			ja = 7.2
		}
		local var_84_1 = manager.audio:GetLocalizationFlag()

		if var_84_0[var_84_1] ~= nil then
			arg_84_1.duration_ = var_84_0[var_84_1]
		end

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play319631021(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1.var_.moveOldPos10079ui_story = arg_84_1.actors_["10079ui_story"].transform.localPosition
			end

			local var_87_0 = 0.001

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_0 then
				arg_84_1.actors_["10079ui_story"].transform.localPosition = Vector3.Lerp(arg_84_1.var_.moveOldPos10079ui_story, Vector3.New(-0.7, -0.95, -6.05), (arg_84_1.time_ - 0) / var_87_0)
				arg_84_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_84_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_84_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_84_1.actors_["10079ui_story"].transform.position).z)
				arg_84_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_84_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_84_1.actors_["10079ui_story"].transform.localEulerAngles = arg_84_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			if arg_84_1.time_ >= 0 + var_87_0 and arg_84_1.time_ < 0 + var_87_0 + arg_87_0 then
				arg_84_1.actors_["10079ui_story"].transform.localPosition = Vector3.New(-0.7, -0.95, -6.05)
				arg_84_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_84_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_84_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_84_1.actors_["10079ui_story"].transform.position).z)
				arg_84_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_84_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_84_1.actors_["10079ui_story"].transform.localEulerAngles = arg_84_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			local var_87_1 = arg_84_1.actors_["10079ui_story"]

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 and not isNil(var_87_1) and arg_84_1.var_.characterEffect10079ui_story == nil then
				arg_84_1.var_.characterEffect10079ui_story = var_87_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_2 = 0.200000002980232

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_2 and not isNil(var_87_1) then
				if arg_84_1.var_.characterEffect10079ui_story and not isNil(var_87_1) then
					arg_84_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_84_1.time_ >= 0 + var_87_2 and arg_84_1.time_ < 0 + var_87_2 + arg_87_0 and not isNil(var_87_1) and arg_84_1.var_.characterEffect10079ui_story then
				arg_84_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_87_4 = arg_84_1.actors_["1095ui_story"].transform

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1.var_.moveOldPos1095ui_story = var_87_4.localPosition
			end

			local var_87_5 = 0.001

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_5 then
				var_87_4.localPosition = Vector3.Lerp(arg_84_1.var_.moveOldPos1095ui_story, Vector3.New(0.7, -0.98, -6.1), (arg_84_1.time_ - 0) / var_87_5)
				var_87_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_87_4.position).x, (manager.ui.mainCamera.transform.position - var_87_4.position).y, (manager.ui.mainCamera.transform.position - var_87_4.position).z)
				var_87_4.localEulerAngles.z = 0
				var_87_4.localEulerAngles.x = 0
				var_87_4.localEulerAngles = var_87_4.localEulerAngles
			end

			if arg_84_1.time_ >= 0 + var_87_5 and arg_84_1.time_ < 0 + var_87_5 + arg_87_0 then
				var_87_4.localPosition = Vector3.New(0.7, -0.98, -6.1)
				var_87_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_87_4.position).x, (manager.ui.mainCamera.transform.position - var_87_4.position).y, (manager.ui.mainCamera.transform.position - var_87_4.position).z)
				var_87_4.localEulerAngles.z = 0
				var_87_4.localEulerAngles.x = 0
				var_87_4.localEulerAngles = var_87_4.localEulerAngles
			end

			local var_87_6 = arg_84_1.actors_["1095ui_story"]

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 and not isNil(var_87_6) and arg_84_1.var_.characterEffect1095ui_story == nil then
				arg_84_1.var_.characterEffect1095ui_story = var_87_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_7 = 0.200000002980232

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_7 and not isNil(var_87_6) then
				if arg_84_1.var_.characterEffect1095ui_story and not isNil(var_87_6) then
					arg_84_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_84_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_84_1.time_ - 0) / var_87_7)
				end
			end

			if arg_84_1.time_ >= 0 + var_87_7 and arg_84_1.time_ < 0 + var_87_7 + arg_87_0 and not isNil(var_87_6) and arg_84_1.var_.characterEffect1095ui_story then
				arg_84_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_84_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_87_8 = 0
			local var_87_9 = 0.55

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= var_87_8 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				arg_84_1.leftNameTxt_.text = arg_84_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_10 = arg_84_1:GetWordFromCfg(319631020)
				local var_87_11 = arg_84_1:FormatText(var_87_10.content)

				arg_84_1.text_.text = var_87_11

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_13 = 22 <= 0 and var_87_9 or var_87_9 * (utf8.len(var_87_11) / 22)

				if (22 <= 0 and var_87_9 or var_87_9 * (utf8.len(var_87_11) / 22)) > 0 and var_87_9 < var_87_13 then
					arg_84_1.talkMaxDuration = var_87_13

					if var_87_13 + var_87_8 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_13 + var_87_8
					end
				end

				arg_84_1.text_.text = var_87_11
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319631", "319631020", "story_v_out_319631.awb") ~= 0 then
					local var_87_14 = manager.audio:GetVoiceLength("story_v_out_319631", "319631020", "story_v_out_319631.awb") / 1000

					if var_87_14 + var_87_8 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_14 + var_87_8
					end

					if var_87_10.prefab_name ~= "" and arg_84_1.actors_[var_87_10.prefab_name] ~= nil then
						local var_87_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_10.prefab_name].transform, "story_v_out_319631", "319631020", "story_v_out_319631.awb")

						arg_84_1:RecordAudio("319631020", var_87_15)
						arg_84_1:RecordAudio("319631020", var_87_15)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_out_319631", "319631020", "story_v_out_319631.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_out_319631", "319631020", "story_v_out_319631.awb")
				end

				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_16 = math.max(var_87_9, arg_84_1.talkMaxDuration)

			if var_87_8 <= arg_84_1.time_ and arg_84_1.time_ < var_87_8 + var_87_16 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_8) / var_87_16

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_8 + var_87_16 and arg_84_1.time_ < var_87_8 + var_87_16 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {
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
				actorName = "1095ui_story",
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
	Play319631021 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 319631021
		arg_88_1.duration_ = 5.8

		local var_88_0 = {
			zh = 3,
			ja = 5.8
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
				arg_88_0:Play319631022(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 and not isNil(arg_88_1.actors_["10079ui_story"]) and arg_88_1.var_.characterEffect10079ui_story == nil then
				arg_88_1.var_.characterEffect10079ui_story = arg_88_1.actors_["10079ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_0 = 0.200000002980232

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_0 and not isNil(arg_88_1.actors_["10079ui_story"]) then
				if arg_88_1.var_.characterEffect10079ui_story and not isNil(arg_88_1.actors_["10079ui_story"]) then
					arg_88_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_88_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_88_1.time_ - 0) / var_91_0)
				end
			end

			if arg_88_1.time_ >= 0 + var_91_0 and arg_88_1.time_ < 0 + var_91_0 + arg_91_0 and not isNil(arg_88_1.actors_["10079ui_story"]) and arg_88_1.var_.characterEffect10079ui_story then
				arg_88_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_88_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			local var_91_1 = arg_88_1.actors_["1095ui_story"]

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 and not isNil(var_91_1) and arg_88_1.var_.characterEffect1095ui_story == nil then
				arg_88_1.var_.characterEffect1095ui_story = var_91_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_2 = 0.200000002980232

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_2 and not isNil(var_91_1) then
				if arg_88_1.var_.characterEffect1095ui_story and not isNil(var_91_1) then
					arg_88_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_88_1.time_ >= 0 + var_91_2 and arg_88_1.time_ < 0 + var_91_2 + arg_91_0 and not isNil(var_91_1) and arg_88_1.var_.characterEffect1095ui_story then
				arg_88_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_91_4 = 0
			local var_91_5 = 0.225

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= var_91_4 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				arg_88_1.leftNameTxt_.text = arg_88_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_6 = arg_88_1:GetWordFromCfg(319631021)
				local var_91_7 = arg_88_1:FormatText(var_91_6.content)

				arg_88_1.text_.text = var_91_7

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_9 = 9 <= 0 and var_91_5 or var_91_5 * (utf8.len(var_91_7) / 9)

				if (9 <= 0 and var_91_5 or var_91_5 * (utf8.len(var_91_7) / 9)) > 0 and var_91_5 < var_91_9 then
					arg_88_1.talkMaxDuration = var_91_9

					if var_91_9 + var_91_4 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_9 + var_91_4
					end
				end

				arg_88_1.text_.text = var_91_7
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319631", "319631021", "story_v_out_319631.awb") ~= 0 then
					local var_91_10 = manager.audio:GetVoiceLength("story_v_out_319631", "319631021", "story_v_out_319631.awb") / 1000

					if var_91_10 + var_91_4 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_10 + var_91_4
					end

					if var_91_6.prefab_name ~= "" and arg_88_1.actors_[var_91_6.prefab_name] ~= nil then
						local var_91_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_88_1.actors_[var_91_6.prefab_name].transform, "story_v_out_319631", "319631021", "story_v_out_319631.awb")

						arg_88_1:RecordAudio("319631021", var_91_11)
						arg_88_1:RecordAudio("319631021", var_91_11)
					else
						arg_88_1:AudioAction("play", "voice", "story_v_out_319631", "319631021", "story_v_out_319631.awb")
					end

					arg_88_1:RecordHistoryTalkVoice("story_v_out_319631", "319631021", "story_v_out_319631.awb")
				end

				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_12 = math.max(var_91_5, arg_88_1.talkMaxDuration)

			if var_91_4 <= arg_88_1.time_ and arg_88_1.time_ < var_91_4 + var_91_12 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_4) / var_91_12

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_4 + var_91_12 and arg_88_1.time_ < var_91_4 + var_91_12 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {}

		arg_88_1:InitPlayNodeList()
	end,
	Play319631022 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 319631022
		arg_92_1.duration_ = 7.93

		local var_92_0 = {
			zh = 6.2,
			ja = 7.933
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
				arg_92_0:Play319631023(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_2")
			end

			local var_95_0 = arg_92_1.actors_["10079ui_story"]

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 and not isNil(var_95_0) and arg_92_1.var_.characterEffect10079ui_story == nil then
				arg_92_1.var_.characterEffect10079ui_story = var_95_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_1 = 0.200000002980232

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_1 and not isNil(var_95_0) then
				if arg_92_1.var_.characterEffect10079ui_story and not isNil(var_95_0) then
					arg_92_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_92_1.time_ >= 0 + var_95_1 and arg_92_1.time_ < 0 + var_95_1 + arg_95_0 and not isNil(var_95_0) and arg_92_1.var_.characterEffect10079ui_story then
				arg_92_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_95_3 = arg_92_1.actors_["1095ui_story"]

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 and not isNil(var_95_3) and arg_92_1.var_.characterEffect1095ui_story == nil then
				arg_92_1.var_.characterEffect1095ui_story = var_95_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_4 = 0.200000002980232

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_4 and not isNil(var_95_3) then
				if arg_92_1.var_.characterEffect1095ui_story and not isNil(var_95_3) then
					arg_92_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_92_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_92_1.time_ - 0) / var_95_4)
				end
			end

			if arg_92_1.time_ >= 0 + var_95_4 and arg_92_1.time_ < 0 + var_95_4 + arg_95_0 and not isNil(var_95_3) and arg_92_1.var_.characterEffect1095ui_story then
				arg_92_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_92_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_95_5 = 0
			local var_95_6 = 0.6

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= var_95_5 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				arg_92_1.leftNameTxt_.text = arg_92_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_7 = arg_92_1:GetWordFromCfg(319631022)
				local var_95_8 = arg_92_1:FormatText(var_95_7.content)

				arg_92_1.text_.text = var_95_8

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_10 = 24 <= 0 and var_95_6 or var_95_6 * (utf8.len(var_95_8) / 24)

				if (24 <= 0 and var_95_6 or var_95_6 * (utf8.len(var_95_8) / 24)) > 0 and var_95_6 < var_95_10 then
					arg_92_1.talkMaxDuration = var_95_10

					if var_95_10 + var_95_5 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_10 + var_95_5
					end
				end

				arg_92_1.text_.text = var_95_8
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319631", "319631022", "story_v_out_319631.awb") ~= 0 then
					local var_95_11 = manager.audio:GetVoiceLength("story_v_out_319631", "319631022", "story_v_out_319631.awb") / 1000

					if var_95_11 + var_95_5 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_11 + var_95_5
					end

					if var_95_7.prefab_name ~= "" and arg_92_1.actors_[var_95_7.prefab_name] ~= nil then
						local var_95_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_7.prefab_name].transform, "story_v_out_319631", "319631022", "story_v_out_319631.awb")

						arg_92_1:RecordAudio("319631022", var_95_12)
						arg_92_1:RecordAudio("319631022", var_95_12)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_out_319631", "319631022", "story_v_out_319631.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_out_319631", "319631022", "story_v_out_319631.awb")
				end

				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_13 = math.max(var_95_6, arg_92_1.talkMaxDuration)

			if var_95_5 <= arg_92_1.time_ and arg_92_1.time_ < var_95_5 + var_95_13 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_5) / var_95_13

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_5 + var_95_13 and arg_92_1.time_ < var_95_5 + var_95_13 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {}

		arg_92_1:InitPlayNodeList()
	end,
	Play319631023 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 319631023
		arg_96_1.duration_ = 5

		SetActive(arg_96_1.tipsGo_, false)

		function arg_96_1.onSingleLineFinish_()
			arg_96_1.onSingleLineUpdate_ = nil
			arg_96_1.onSingleLineFinish_ = nil
			arg_96_1.state_ = "waiting"
		end

		function arg_96_1.playNext_(arg_98_0)
			if arg_98_0 == 1 then
				arg_96_0:Play319631024(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				arg_96_1.var_.moveOldPos10079ui_story = arg_96_1.actors_["10079ui_story"].transform.localPosition
			end

			local var_99_0 = 0.001

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_0 then
				arg_96_1.actors_["10079ui_story"].transform.localPosition = Vector3.Lerp(arg_96_1.var_.moveOldPos10079ui_story, Vector3.New(0, 100, 0), (arg_96_1.time_ - 0) / var_99_0)
				arg_96_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_96_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_96_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_96_1.actors_["10079ui_story"].transform.position).z)
				arg_96_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_96_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_96_1.actors_["10079ui_story"].transform.localEulerAngles = arg_96_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			if arg_96_1.time_ >= 0 + var_99_0 and arg_96_1.time_ < 0 + var_99_0 + arg_99_0 then
				arg_96_1.actors_["10079ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_96_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_96_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_96_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_96_1.actors_["10079ui_story"].transform.position).z)
				arg_96_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_96_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_96_1.actors_["10079ui_story"].transform.localEulerAngles = arg_96_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			local var_99_1 = arg_96_1.actors_["10079ui_story"]

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 and not isNil(var_99_1) and arg_96_1.var_.characterEffect10079ui_story == nil then
				arg_96_1.var_.characterEffect10079ui_story = var_99_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_2 = 0.200000002980232

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_2 and not isNil(var_99_1) then
				if arg_96_1.var_.characterEffect10079ui_story and not isNil(var_99_1) then
					arg_96_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_96_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_96_1.time_ - 0) / var_99_2)
				end
			end

			if arg_96_1.time_ >= 0 + var_99_2 and arg_96_1.time_ < 0 + var_99_2 + arg_99_0 and not isNil(var_99_1) and arg_96_1.var_.characterEffect10079ui_story then
				arg_96_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_96_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			local var_99_3 = arg_96_1.actors_["1095ui_story"].transform

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				arg_96_1.var_.moveOldPos1095ui_story = var_99_3.localPosition
			end

			local var_99_4 = 0.001

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_4 then
				var_99_3.localPosition = Vector3.Lerp(arg_96_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_96_1.time_ - 0) / var_99_4)
				var_99_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_99_3.position).x, (manager.ui.mainCamera.transform.position - var_99_3.position).y, (manager.ui.mainCamera.transform.position - var_99_3.position).z)
				var_99_3.localEulerAngles.z = 0
				var_99_3.localEulerAngles.x = 0
				var_99_3.localEulerAngles = var_99_3.localEulerAngles
			end

			if arg_96_1.time_ >= 0 + var_99_4 and arg_96_1.time_ < 0 + var_99_4 + arg_99_0 then
				var_99_3.localPosition = Vector3.New(0, 100, 0)
				var_99_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_99_3.position).x, (manager.ui.mainCamera.transform.position - var_99_3.position).y, (manager.ui.mainCamera.transform.position - var_99_3.position).z)
				var_99_3.localEulerAngles.z = 0
				var_99_3.localEulerAngles.x = 0
				var_99_3.localEulerAngles = var_99_3.localEulerAngles
			end

			local var_99_5 = arg_96_1.actors_["1095ui_story"]

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 and not isNil(var_99_5) and arg_96_1.var_.characterEffect1095ui_story == nil then
				arg_96_1.var_.characterEffect1095ui_story = var_99_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_6 = 0.200000002980232

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_6 and not isNil(var_99_5) then
				if arg_96_1.var_.characterEffect1095ui_story and not isNil(var_99_5) then
					arg_96_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_96_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_96_1.time_ - 0) / var_99_6)
				end
			end

			if arg_96_1.time_ >= 0 + var_99_6 and arg_96_1.time_ < 0 + var_99_6 + arg_99_0 and not isNil(var_99_5) and arg_96_1.var_.characterEffect1095ui_story then
				arg_96_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_96_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_99_7 = 0
			local var_99_8 = 1.25

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= var_99_7 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, false)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_9 = arg_96_1:FormatText(arg_96_1:GetWordFromCfg(319631023).content)

				arg_96_1.text_.text = var_99_9

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_11 = 50 <= 0 and var_99_8 or var_99_8 * (utf8.len(var_99_9) / 50)

				if (50 <= 0 and var_99_8 or var_99_8 * (utf8.len(var_99_9) / 50)) > 0 and var_99_8 < var_99_11 then
					arg_96_1.talkMaxDuration = var_99_11

					if var_99_11 + var_99_7 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_11 + var_99_7
					end
				end

				arg_96_1.text_.text = var_99_9
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)
				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_12 = math.max(var_99_8, arg_96_1.talkMaxDuration)

			if var_99_7 <= arg_96_1.time_ and arg_96_1.time_ < var_99_7 + var_99_12 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_7) / var_99_12

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_7 + var_99_12 and arg_96_1.time_ < var_99_7 + var_99_12 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {
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
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_96_1:InitPlayNodeList()
	end,
	Play319631024 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 319631024
		arg_100_1.duration_ = 5.27

		local var_100_0 = {
			zh = 4.266,
			ja = 5.266
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
				arg_100_0:Play319631025(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			if arg_100_1.actors_["4037ui_story"] == nil and not isNil((Asset.Load("Char/" .. "4037ui_story"))) then
				local var_103_0 = Object.Instantiate(Asset.Load("Char/" .. "4037ui_story"), arg_100_1.stage_.transform)

				var_103_0.name = "4037ui_story"
				var_103_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_100_1.actors_["4037ui_story"] = var_103_0

				local var_103_1 = var_103_0:GetComponentInChildren(typeof(CharacterEffect))

				var_103_1.enabled = true

				local var_103_2 = GameObjectTools.GetOrAddComponent(var_103_0, typeof(DynamicBoneHelper))

				if var_103_2 then
					var_103_2:EnableDynamicBone(false)
				end

				arg_100_1:ShowWeapon(var_103_1.transform, false)

				arg_100_1.var_["4037ui_story" .. "Animator"] = var_103_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_100_1.var_["4037ui_story" .. "Animator"].applyRootMotion = true
				arg_100_1.var_["4037ui_story" .. "LipSync"] = var_103_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_103_3 = arg_100_1.actors_["4037ui_story"].transform

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				arg_100_1.var_.moveOldPos4037ui_story = var_103_3.localPosition
			end

			local var_103_4 = 0.001

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_4 then
				var_103_3.localPosition = Vector3.Lerp(arg_100_1.var_.moveOldPos4037ui_story, Vector3.New(0, -1.12, -6.2), (arg_100_1.time_ - 0) / var_103_4)
				var_103_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_103_3.position).x, (manager.ui.mainCamera.transform.position - var_103_3.position).y, (manager.ui.mainCamera.transform.position - var_103_3.position).z)
				var_103_3.localEulerAngles.z = 0
				var_103_3.localEulerAngles.x = 0
				var_103_3.localEulerAngles = var_103_3.localEulerAngles
			end

			if arg_100_1.time_ >= 0 + var_103_4 and arg_100_1.time_ < 0 + var_103_4 + arg_103_0 then
				var_103_3.localPosition = Vector3.New(0, -1.12, -6.2)
				var_103_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_103_3.position).x, (manager.ui.mainCamera.transform.position - var_103_3.position).y, (manager.ui.mainCamera.transform.position - var_103_3.position).z)
				var_103_3.localEulerAngles.z = 0
				var_103_3.localEulerAngles.x = 0
				var_103_3.localEulerAngles = var_103_3.localEulerAngles
			end

			local var_103_5 = arg_100_1.actors_["4037ui_story"]

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 and not isNil(var_103_5) and arg_100_1.var_.characterEffect4037ui_story == nil then
				arg_100_1.var_.characterEffect4037ui_story = var_103_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_103_6 = 0.200000002980232

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_6 and not isNil(var_103_5) then
				if arg_100_1.var_.characterEffect4037ui_story and not isNil(var_103_5) then
					arg_100_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_100_1.time_ >= 0 + var_103_6 and arg_100_1.time_ < 0 + var_103_6 + arg_103_0 and not isNil(var_103_5) and arg_100_1.var_.characterEffect4037ui_story then
				arg_100_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				arg_100_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action1_1")
			end

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				arg_100_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_103_8 = 0
			local var_103_9 = 0.5

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= var_103_8 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				arg_100_1.leftNameTxt_.text = arg_100_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_10 = arg_100_1:GetWordFromCfg(319631024)
				local var_103_11 = arg_100_1:FormatText(var_103_10.content)

				arg_100_1.text_.text = var_103_11

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_13 = 20 <= 0 and var_103_9 or var_103_9 * (utf8.len(var_103_11) / 20)

				if (20 <= 0 and var_103_9 or var_103_9 * (utf8.len(var_103_11) / 20)) > 0 and var_103_9 < var_103_13 then
					arg_100_1.talkMaxDuration = var_103_13

					if var_103_13 + var_103_8 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_13 + var_103_8
					end
				end

				arg_100_1.text_.text = var_103_11
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319631", "319631024", "story_v_out_319631.awb") ~= 0 then
					local var_103_14 = manager.audio:GetVoiceLength("story_v_out_319631", "319631024", "story_v_out_319631.awb") / 1000

					if var_103_14 + var_103_8 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_14 + var_103_8
					end

					if var_103_10.prefab_name ~= "" and arg_100_1.actors_[var_103_10.prefab_name] ~= nil then
						local var_103_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_100_1.actors_[var_103_10.prefab_name].transform, "story_v_out_319631", "319631024", "story_v_out_319631.awb")

						arg_100_1:RecordAudio("319631024", var_103_15)
						arg_100_1:RecordAudio("319631024", var_103_15)
					else
						arg_100_1:AudioAction("play", "voice", "story_v_out_319631", "319631024", "story_v_out_319631.awb")
					end

					arg_100_1:RecordHistoryTalkVoice("story_v_out_319631", "319631024", "story_v_out_319631.awb")
				end

				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_16 = math.max(var_103_9, arg_100_1.talkMaxDuration)

			if var_103_8 <= arg_100_1.time_ and arg_100_1.time_ < var_103_8 + var_103_16 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_8) / var_103_16

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_8 + var_103_16 and arg_100_1.time_ < var_103_8 + var_103_16 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {
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

		arg_100_1:InitPlayNodeList()
	end,
	Play319631025 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 319631025
		arg_104_1.duration_ = 8.93

		local var_104_0 = {
			zh = 8.933,
			ja = 6.666
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
				arg_104_0:Play319631026(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			if 0.633333333333333 < arg_104_1.time_ and arg_104_1.time_ <= 0.633333333333333 + arg_107_0 then
				arg_104_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action4_1")
			end

			local var_107_0 = 0
			local var_107_1 = 0.775

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= var_107_0 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				arg_104_1.leftNameTxt_.text = arg_104_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_2 = arg_104_1:GetWordFromCfg(319631025)
				local var_107_3 = arg_104_1:FormatText(var_107_2.content)

				arg_104_1.text_.text = var_107_3

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_5 = 31 <= 0 and var_107_1 or var_107_1 * (utf8.len(var_107_3) / 31)

				if (31 <= 0 and var_107_1 or var_107_1 * (utf8.len(var_107_3) / 31)) > 0 and var_107_1 < var_107_5 then
					arg_104_1.talkMaxDuration = var_107_5

					if var_107_5 + var_107_0 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_5 + var_107_0
					end
				end

				arg_104_1.text_.text = var_107_3
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319631", "319631025", "story_v_out_319631.awb") ~= 0 then
					local var_107_6 = manager.audio:GetVoiceLength("story_v_out_319631", "319631025", "story_v_out_319631.awb") / 1000

					if var_107_6 + var_107_0 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_6 + var_107_0
					end

					if var_107_2.prefab_name ~= "" and arg_104_1.actors_[var_107_2.prefab_name] ~= nil then
						local var_107_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_104_1.actors_[var_107_2.prefab_name].transform, "story_v_out_319631", "319631025", "story_v_out_319631.awb")

						arg_104_1:RecordAudio("319631025", var_107_7)
						arg_104_1:RecordAudio("319631025", var_107_7)
					else
						arg_104_1:AudioAction("play", "voice", "story_v_out_319631", "319631025", "story_v_out_319631.awb")
					end

					arg_104_1:RecordHistoryTalkVoice("story_v_out_319631", "319631025", "story_v_out_319631.awb")
				end

				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_8 = math.max(var_107_1, arg_104_1.talkMaxDuration)

			if var_107_0 <= arg_104_1.time_ and arg_104_1.time_ < var_107_0 + var_107_8 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_0) / var_107_8

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_0 + var_107_8 and arg_104_1.time_ < var_107_0 + var_107_8 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {}

		arg_104_1:InitPlayNodeList()
	end,
	Play319631026 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 319631026
		arg_108_1.duration_ = 2.13

		local var_108_0 = {
			zh = 1.999999999999,
			ja = 2.133
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
				arg_108_0:Play319631027(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 then
				arg_108_1.var_.moveOldPos10079ui_story = arg_108_1.actors_["10079ui_story"].transform.localPosition
			end

			local var_111_0 = 0.001

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_0 then
				arg_108_1.actors_["10079ui_story"].transform.localPosition = Vector3.Lerp(arg_108_1.var_.moveOldPos10079ui_story, Vector3.New(0, -0.95, -6.05), (arg_108_1.time_ - 0) / var_111_0)
				arg_108_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_108_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_108_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_108_1.actors_["10079ui_story"].transform.position).z)
				arg_108_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_108_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_108_1.actors_["10079ui_story"].transform.localEulerAngles = arg_108_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			if arg_108_1.time_ >= 0 + var_111_0 and arg_108_1.time_ < 0 + var_111_0 + arg_111_0 then
				arg_108_1.actors_["10079ui_story"].transform.localPosition = Vector3.New(0, -0.95, -6.05)
				arg_108_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_108_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_108_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_108_1.actors_["10079ui_story"].transform.position).z)
				arg_108_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_108_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_108_1.actors_["10079ui_story"].transform.localEulerAngles = arg_108_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			local var_111_1 = arg_108_1.actors_["10079ui_story"]

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 and not isNil(var_111_1) and arg_108_1.var_.characterEffect10079ui_story == nil then
				arg_108_1.var_.characterEffect10079ui_story = var_111_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_111_2 = 0.200000002980232

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_2 and not isNil(var_111_1) then
				if arg_108_1.var_.characterEffect10079ui_story and not isNil(var_111_1) then
					arg_108_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_108_1.time_ >= 0 + var_111_2 and arg_108_1.time_ < 0 + var_111_2 + arg_111_0 and not isNil(var_111_1) and arg_108_1.var_.characterEffect10079ui_story then
				arg_108_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 then
				arg_108_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 then
				arg_108_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_111_4 = arg_108_1.actors_["4037ui_story"].transform

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 then
				arg_108_1.var_.moveOldPos4037ui_story = var_111_4.localPosition
			end

			local var_111_5 = 0.001

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_5 then
				var_111_4.localPosition = Vector3.Lerp(arg_108_1.var_.moveOldPos4037ui_story, Vector3.New(0, 100, 0), (arg_108_1.time_ - 0) / var_111_5)
				var_111_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_111_4.position).x, (manager.ui.mainCamera.transform.position - var_111_4.position).y, (manager.ui.mainCamera.transform.position - var_111_4.position).z)
				var_111_4.localEulerAngles.z = 0
				var_111_4.localEulerAngles.x = 0
				var_111_4.localEulerAngles = var_111_4.localEulerAngles
			end

			if arg_108_1.time_ >= 0 + var_111_5 and arg_108_1.time_ < 0 + var_111_5 + arg_111_0 then
				var_111_4.localPosition = Vector3.New(0, 100, 0)
				var_111_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_111_4.position).x, (manager.ui.mainCamera.transform.position - var_111_4.position).y, (manager.ui.mainCamera.transform.position - var_111_4.position).z)
				var_111_4.localEulerAngles.z = 0
				var_111_4.localEulerAngles.x = 0
				var_111_4.localEulerAngles = var_111_4.localEulerAngles
			end

			local var_111_6 = arg_108_1.actors_["4037ui_story"]

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 and not isNil(var_111_6) and arg_108_1.var_.characterEffect4037ui_story == nil then
				arg_108_1.var_.characterEffect4037ui_story = var_111_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_111_7 = 0.200000002980232

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_7 and not isNil(var_111_6) then
				if arg_108_1.var_.characterEffect4037ui_story and not isNil(var_111_6) then
					arg_108_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_108_1.var_.characterEffect4037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_108_1.time_ - 0) / var_111_7)
				end
			end

			if arg_108_1.time_ >= 0 + var_111_7 and arg_108_1.time_ < 0 + var_111_7 + arg_111_0 and not isNil(var_111_6) and arg_108_1.var_.characterEffect4037ui_story then
				arg_108_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_108_1.var_.characterEffect4037ui_story.fillRatio = 0.5
			end

			local var_111_8 = 0
			local var_111_9 = 0.125

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= var_111_8 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				arg_108_1.leftNameTxt_.text = arg_108_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_10 = arg_108_1:GetWordFromCfg(319631026)
				local var_111_11 = arg_108_1:FormatText(var_111_10.content)

				arg_108_1.text_.text = var_111_11

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_13 = 5 <= 0 and var_111_9 or var_111_9 * (utf8.len(var_111_11) / 5)

				if (5 <= 0 and var_111_9 or var_111_9 * (utf8.len(var_111_11) / 5)) > 0 and var_111_9 < var_111_13 then
					arg_108_1.talkMaxDuration = var_111_13

					if var_111_13 + var_111_8 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_13 + var_111_8
					end
				end

				arg_108_1.text_.text = var_111_11
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319631", "319631026", "story_v_out_319631.awb") ~= 0 then
					local var_111_14 = manager.audio:GetVoiceLength("story_v_out_319631", "319631026", "story_v_out_319631.awb") / 1000

					if var_111_14 + var_111_8 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_14 + var_111_8
					end

					if var_111_10.prefab_name ~= "" and arg_108_1.actors_[var_111_10.prefab_name] ~= nil then
						local var_111_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_108_1.actors_[var_111_10.prefab_name].transform, "story_v_out_319631", "319631026", "story_v_out_319631.awb")

						arg_108_1:RecordAudio("319631026", var_111_15)
						arg_108_1:RecordAudio("319631026", var_111_15)
					else
						arg_108_1:AudioAction("play", "voice", "story_v_out_319631", "319631026", "story_v_out_319631.awb")
					end

					arg_108_1:RecordHistoryTalkVoice("story_v_out_319631", "319631026", "story_v_out_319631.awb")
				end

				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_16 = math.max(var_111_9, arg_108_1.talkMaxDuration)

			if var_111_8 <= arg_108_1.time_ and arg_108_1.time_ < var_111_8 + var_111_16 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_8) / var_111_16

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_8 + var_111_16 and arg_108_1.time_ < var_111_8 + var_111_16 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {
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
				actorName = "4037ui_story",
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
	Play319631027 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 319631027
		arg_112_1.duration_ = 9.67

		local var_112_0 = {
			zh = 5.866,
			ja = 9.666
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
				arg_112_0:Play319631028(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 then
				arg_112_1.var_.moveOldPos1095ui_story = arg_112_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_115_0 = 0.001

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_0 then
				arg_112_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_112_1.var_.moveOldPos1095ui_story, Vector3.New(0.7, -0.98, -6.1), (arg_112_1.time_ - 0) / var_115_0)
				arg_112_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_112_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_112_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_112_1.actors_["1095ui_story"].transform.position).z)
				arg_112_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_112_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_112_1.actors_["1095ui_story"].transform.localEulerAngles = arg_112_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_112_1.time_ >= 0 + var_115_0 and arg_112_1.time_ < 0 + var_115_0 + arg_115_0 then
				arg_112_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0.7, -0.98, -6.1)
				arg_112_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_112_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_112_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_112_1.actors_["1095ui_story"].transform.position).z)
				arg_112_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_112_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_112_1.actors_["1095ui_story"].transform.localEulerAngles = arg_112_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_115_1 = arg_112_1.actors_["1095ui_story"]

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 and not isNil(var_115_1) and arg_112_1.var_.characterEffect1095ui_story == nil then
				arg_112_1.var_.characterEffect1095ui_story = var_115_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_115_2 = 0.200000002980232

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_2 and not isNil(var_115_1) then
				if arg_112_1.var_.characterEffect1095ui_story and not isNil(var_115_1) then
					arg_112_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_112_1.time_ >= 0 + var_115_2 and arg_112_1.time_ < 0 + var_115_2 + arg_115_0 and not isNil(var_115_1) and arg_112_1.var_.characterEffect1095ui_story then
				arg_112_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 then
				arg_112_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_1")
			end

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 then
				arg_112_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_115_4 = arg_112_1.actors_["10079ui_story"].transform

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 then
				arg_112_1.var_.moveOldPos10079ui_story = var_115_4.localPosition
			end

			local var_115_5 = 0.001

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_5 then
				var_115_4.localPosition = Vector3.Lerp(arg_112_1.var_.moveOldPos10079ui_story, Vector3.New(-0.7, -0.95, -6.05), (arg_112_1.time_ - 0) / var_115_5)
				var_115_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_115_4.position).x, (manager.ui.mainCamera.transform.position - var_115_4.position).y, (manager.ui.mainCamera.transform.position - var_115_4.position).z)
				var_115_4.localEulerAngles.z = 0
				var_115_4.localEulerAngles.x = 0
				var_115_4.localEulerAngles = var_115_4.localEulerAngles
			end

			if arg_112_1.time_ >= 0 + var_115_5 and arg_112_1.time_ < 0 + var_115_5 + arg_115_0 then
				var_115_4.localPosition = Vector3.New(-0.7, -0.95, -6.05)
				var_115_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_115_4.position).x, (manager.ui.mainCamera.transform.position - var_115_4.position).y, (manager.ui.mainCamera.transform.position - var_115_4.position).z)
				var_115_4.localEulerAngles.z = 0
				var_115_4.localEulerAngles.x = 0
				var_115_4.localEulerAngles = var_115_4.localEulerAngles
			end

			local var_115_6 = arg_112_1.actors_["10079ui_story"]

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 and not isNil(var_115_6) and arg_112_1.var_.characterEffect10079ui_story == nil then
				arg_112_1.var_.characterEffect10079ui_story = var_115_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_115_7 = 0.200000002980232

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_7 and not isNil(var_115_6) then
				if arg_112_1.var_.characterEffect10079ui_story and not isNil(var_115_6) then
					arg_112_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_112_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_112_1.time_ - 0) / var_115_7)
				end
			end

			if arg_112_1.time_ >= 0 + var_115_7 and arg_112_1.time_ < 0 + var_115_7 + arg_115_0 and not isNil(var_115_6) and arg_112_1.var_.characterEffect10079ui_story then
				arg_112_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_112_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			local var_115_8 = 0
			local var_115_9 = 0.725

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= var_115_8 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				arg_112_1.leftNameTxt_.text = arg_112_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_10 = arg_112_1:GetWordFromCfg(319631027)
				local var_115_11 = arg_112_1:FormatText(var_115_10.content)

				arg_112_1.text_.text = var_115_11

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_13 = 29 <= 0 and var_115_9 or var_115_9 * (utf8.len(var_115_11) / 29)

				if (29 <= 0 and var_115_9 or var_115_9 * (utf8.len(var_115_11) / 29)) > 0 and var_115_9 < var_115_13 then
					arg_112_1.talkMaxDuration = var_115_13

					if var_115_13 + var_115_8 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_13 + var_115_8
					end
				end

				arg_112_1.text_.text = var_115_11
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319631", "319631027", "story_v_out_319631.awb") ~= 0 then
					local var_115_14 = manager.audio:GetVoiceLength("story_v_out_319631", "319631027", "story_v_out_319631.awb") / 1000

					if var_115_14 + var_115_8 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_14 + var_115_8
					end

					if var_115_10.prefab_name ~= "" and arg_112_1.actors_[var_115_10.prefab_name] ~= nil then
						local var_115_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_112_1.actors_[var_115_10.prefab_name].transform, "story_v_out_319631", "319631027", "story_v_out_319631.awb")

						arg_112_1:RecordAudio("319631027", var_115_15)
						arg_112_1:RecordAudio("319631027", var_115_15)
					else
						arg_112_1:AudioAction("play", "voice", "story_v_out_319631", "319631027", "story_v_out_319631.awb")
					end

					arg_112_1:RecordHistoryTalkVoice("story_v_out_319631", "319631027", "story_v_out_319631.awb")
				end

				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_16 = math.max(var_115_9, arg_112_1.talkMaxDuration)

			if var_115_8 <= arg_112_1.time_ and arg_112_1.time_ < var_115_8 + var_115_16 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_8) / var_115_16

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_8 + var_115_16 and arg_112_1.time_ < var_115_8 + var_115_16 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_112_1:InitPlayNodeList()
	end,
	Play319631028 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 319631028
		arg_116_1.duration_ = 7.47

		local var_116_0 = {
			zh = 4.6,
			ja = 7.466
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
				arg_116_0:Play319631029(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			local var_119_0 = 0.625

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				arg_116_1.leftNameTxt_.text = arg_116_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_1 = arg_116_1:GetWordFromCfg(319631028)
				local var_119_2 = arg_116_1:FormatText(var_119_1.content)

				arg_116_1.text_.text = var_119_2

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_4 = 25 <= 0 and var_119_0 or var_119_0 * (utf8.len(var_119_2) / 25)

				if (25 <= 0 and var_119_0 or var_119_0 * (utf8.len(var_119_2) / 25)) > 0 and var_119_0 < var_119_4 then
					arg_116_1.talkMaxDuration = var_119_4

					if var_119_4 + 0 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_4 + 0
					end
				end

				arg_116_1.text_.text = var_119_2
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319631", "319631028", "story_v_out_319631.awb") ~= 0 then
					local var_119_5 = manager.audio:GetVoiceLength("story_v_out_319631", "319631028", "story_v_out_319631.awb") / 1000

					if var_119_5 + 0 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_5 + 0
					end

					if var_119_1.prefab_name ~= "" and arg_116_1.actors_[var_119_1.prefab_name] ~= nil then
						local var_119_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_116_1.actors_[var_119_1.prefab_name].transform, "story_v_out_319631", "319631028", "story_v_out_319631.awb")

						arg_116_1:RecordAudio("319631028", var_119_6)
						arg_116_1:RecordAudio("319631028", var_119_6)
					else
						arg_116_1:AudioAction("play", "voice", "story_v_out_319631", "319631028", "story_v_out_319631.awb")
					end

					arg_116_1:RecordHistoryTalkVoice("story_v_out_319631", "319631028", "story_v_out_319631.awb")
				end

				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_7 = math.max(var_119_0, arg_116_1.talkMaxDuration)

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_7 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - 0) / var_119_7

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= 0 + var_119_7 and arg_116_1.time_ < 0 + var_119_7 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {}

		arg_116_1:InitPlayNodeList()
	end,
	Play319631029 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 319631029
		arg_120_1.duration_ = 5.53

		local var_120_0 = {
			zh = 1.999999999999,
			ja = 5.533
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
				arg_120_0:Play319631030(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 then
				arg_120_1.var_.moveOldPos10079ui_story = arg_120_1.actors_["10079ui_story"].transform.localPosition
			end

			local var_123_0 = 0.001

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_0 then
				arg_120_1.actors_["10079ui_story"].transform.localPosition = Vector3.Lerp(arg_120_1.var_.moveOldPos10079ui_story, Vector3.New(-0.7, -0.95, -6.05), (arg_120_1.time_ - 0) / var_123_0)
				arg_120_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_120_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_120_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_120_1.actors_["10079ui_story"].transform.position).z)
				arg_120_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_120_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_120_1.actors_["10079ui_story"].transform.localEulerAngles = arg_120_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			if arg_120_1.time_ >= 0 + var_123_0 and arg_120_1.time_ < 0 + var_123_0 + arg_123_0 then
				arg_120_1.actors_["10079ui_story"].transform.localPosition = Vector3.New(-0.7, -0.95, -6.05)
				arg_120_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_120_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_120_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_120_1.actors_["10079ui_story"].transform.position).z)
				arg_120_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_120_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_120_1.actors_["10079ui_story"].transform.localEulerAngles = arg_120_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			local var_123_1 = arg_120_1.actors_["10079ui_story"]

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 and not isNil(var_123_1) and arg_120_1.var_.characterEffect10079ui_story == nil then
				arg_120_1.var_.characterEffect10079ui_story = var_123_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_123_2 = 0.200000002980232

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_2 and not isNil(var_123_1) then
				if arg_120_1.var_.characterEffect10079ui_story and not isNil(var_123_1) then
					arg_120_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_120_1.time_ >= 0 + var_123_2 and arg_120_1.time_ < 0 + var_123_2 + arg_123_0 and not isNil(var_123_1) and arg_120_1.var_.characterEffect10079ui_story then
				arg_120_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 then
				arg_120_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action12_1")
			end

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 then
				arg_120_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_123_4 = arg_120_1.actors_["1095ui_story"]

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 and not isNil(var_123_4) and arg_120_1.var_.characterEffect1095ui_story == nil then
				arg_120_1.var_.characterEffect1095ui_story = var_123_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_123_5 = 0.200000002980232

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_5 and not isNil(var_123_4) then
				if arg_120_1.var_.characterEffect1095ui_story and not isNil(var_123_4) then
					arg_120_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_120_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_120_1.time_ - 0) / var_123_5)
				end
			end

			if arg_120_1.time_ >= 0 + var_123_5 and arg_120_1.time_ < 0 + var_123_5 + arg_123_0 and not isNil(var_123_4) and arg_120_1.var_.characterEffect1095ui_story then
				arg_120_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_120_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_123_6 = 0
			local var_123_7 = 0.225

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= var_123_6 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				arg_120_1.leftNameTxt_.text = arg_120_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_8 = arg_120_1:GetWordFromCfg(319631029)
				local var_123_9 = arg_120_1:FormatText(var_123_8.content)

				arg_120_1.text_.text = var_123_9

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_11 = 9 <= 0 and var_123_7 or var_123_7 * (utf8.len(var_123_9) / 9)

				if (9 <= 0 and var_123_7 or var_123_7 * (utf8.len(var_123_9) / 9)) > 0 and var_123_7 < var_123_11 then
					arg_120_1.talkMaxDuration = var_123_11

					if var_123_11 + var_123_6 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_11 + var_123_6
					end
				end

				arg_120_1.text_.text = var_123_9
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319631", "319631029", "story_v_out_319631.awb") ~= 0 then
					local var_123_12 = manager.audio:GetVoiceLength("story_v_out_319631", "319631029", "story_v_out_319631.awb") / 1000

					if var_123_12 + var_123_6 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_12 + var_123_6
					end

					if var_123_8.prefab_name ~= "" and arg_120_1.actors_[var_123_8.prefab_name] ~= nil then
						local var_123_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_120_1.actors_[var_123_8.prefab_name].transform, "story_v_out_319631", "319631029", "story_v_out_319631.awb")

						arg_120_1:RecordAudio("319631029", var_123_13)
						arg_120_1:RecordAudio("319631029", var_123_13)
					else
						arg_120_1:AudioAction("play", "voice", "story_v_out_319631", "319631029", "story_v_out_319631.awb")
					end

					arg_120_1:RecordHistoryTalkVoice("story_v_out_319631", "319631029", "story_v_out_319631.awb")
				end

				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_14 = math.max(var_123_7, arg_120_1.talkMaxDuration)

			if var_123_6 <= arg_120_1.time_ and arg_120_1.time_ < var_123_6 + var_123_14 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_6) / var_123_14

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_6 + var_123_14 and arg_120_1.time_ < var_123_6 + var_123_14 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_120_1:InitPlayNodeList()
	end,
	Play319631030 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 319631030
		arg_124_1.duration_ = 3.93

		local var_124_0 = {
			zh = 3.566,
			ja = 3.933
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
				arg_124_0:Play319631031(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			if arg_124_1.actors_["10037ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10037ui_story"))) then
				local var_127_0 = Object.Instantiate(Asset.Load("Char/" .. "10037ui_story"), arg_124_1.stage_.transform)

				var_127_0.name = "10037ui_story"
				var_127_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_124_1.actors_["10037ui_story"] = var_127_0

				local var_127_1 = var_127_0:GetComponentInChildren(typeof(CharacterEffect))

				var_127_1.enabled = true

				local var_127_2 = GameObjectTools.GetOrAddComponent(var_127_0, typeof(DynamicBoneHelper))

				if var_127_2 then
					var_127_2:EnableDynamicBone(false)
				end

				arg_124_1:ShowWeapon(var_127_1.transform, false)

				arg_124_1.var_["10037ui_story" .. "Animator"] = var_127_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_124_1.var_["10037ui_story" .. "Animator"].applyRootMotion = true
				arg_124_1.var_["10037ui_story" .. "LipSync"] = var_127_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_127_3 = arg_124_1.actors_["10037ui_story"].transform

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				arg_124_1.var_.moveOldPos10037ui_story = var_127_3.localPosition

				arg_124_1:ShowWeapon(arg_124_1.var_["10037ui_story" .. "Animator"].transform, false)
			end

			local var_127_4 = 0.001

			if 0 <= arg_124_1.time_ and arg_124_1.time_ < 0 + var_127_4 then
				var_127_3.localPosition = Vector3.Lerp(arg_124_1.var_.moveOldPos10037ui_story, Vector3.New(0, -1.13, -6.2), (arg_124_1.time_ - 0) / var_127_4)
				var_127_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_127_3.position).x, (manager.ui.mainCamera.transform.position - var_127_3.position).y, (manager.ui.mainCamera.transform.position - var_127_3.position).z)
				var_127_3.localEulerAngles.z = 0
				var_127_3.localEulerAngles.x = 0
				var_127_3.localEulerAngles = var_127_3.localEulerAngles
			end

			if arg_124_1.time_ >= 0 + var_127_4 and arg_124_1.time_ < 0 + var_127_4 + arg_127_0 then
				var_127_3.localPosition = Vector3.New(0, -1.13, -6.2)
				var_127_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_127_3.position).x, (manager.ui.mainCamera.transform.position - var_127_3.position).y, (manager.ui.mainCamera.transform.position - var_127_3.position).z)
				var_127_3.localEulerAngles.z = 0
				var_127_3.localEulerAngles.x = 0
				var_127_3.localEulerAngles = var_127_3.localEulerAngles
			end

			local var_127_5 = arg_124_1.actors_["10037ui_story"]

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 and not isNil(var_127_5) and arg_124_1.var_.characterEffect10037ui_story == nil then
				arg_124_1.var_.characterEffect10037ui_story = var_127_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_127_6 = 0.200000002980232

			if 0 <= arg_124_1.time_ and arg_124_1.time_ < 0 + var_127_6 and not isNil(var_127_5) then
				if arg_124_1.var_.characterEffect10037ui_story and not isNil(var_127_5) then
					arg_124_1.var_.characterEffect10037ui_story.fillFlat = false
				end
			end

			if arg_124_1.time_ >= 0 + var_127_6 and arg_124_1.time_ < 0 + var_127_6 + arg_127_0 and not isNil(var_127_5) and arg_124_1.var_.characterEffect10037ui_story then
				arg_124_1.var_.characterEffect10037ui_story.fillFlat = false
			end

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				arg_124_1:PlayTimeline("10037ui_story", "StoryTimeline/CharAction/story10037/story10037action/10037action1_1")
			end

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				arg_124_1:PlayTimeline("10037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_127_8 = arg_124_1.actors_["1095ui_story"].transform

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				arg_124_1.var_.moveOldPos1095ui_story = var_127_8.localPosition
			end

			local var_127_9 = 0.001

			if 0 <= arg_124_1.time_ and arg_124_1.time_ < 0 + var_127_9 then
				var_127_8.localPosition = Vector3.Lerp(arg_124_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_124_1.time_ - 0) / var_127_9)
				var_127_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_127_8.position).x, (manager.ui.mainCamera.transform.position - var_127_8.position).y, (manager.ui.mainCamera.transform.position - var_127_8.position).z)
				var_127_8.localEulerAngles.z = 0
				var_127_8.localEulerAngles.x = 0
				var_127_8.localEulerAngles = var_127_8.localEulerAngles
			end

			if arg_124_1.time_ >= 0 + var_127_9 and arg_124_1.time_ < 0 + var_127_9 + arg_127_0 then
				var_127_8.localPosition = Vector3.New(0, 100, 0)
				var_127_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_127_8.position).x, (manager.ui.mainCamera.transform.position - var_127_8.position).y, (manager.ui.mainCamera.transform.position - var_127_8.position).z)
				var_127_8.localEulerAngles.z = 0
				var_127_8.localEulerAngles.x = 0
				var_127_8.localEulerAngles = var_127_8.localEulerAngles
			end

			local var_127_10 = arg_124_1.actors_["1095ui_story"]

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 and not isNil(var_127_10) and arg_124_1.var_.characterEffect1095ui_story == nil then
				arg_124_1.var_.characterEffect1095ui_story = var_127_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_127_11 = 0.200000002980232

			if 0 <= arg_124_1.time_ and arg_124_1.time_ < 0 + var_127_11 and not isNil(var_127_10) then
				if arg_124_1.var_.characterEffect1095ui_story and not isNil(var_127_10) then
					arg_124_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_124_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_124_1.time_ - 0) / var_127_11)
				end
			end

			if arg_124_1.time_ >= 0 + var_127_11 and arg_124_1.time_ < 0 + var_127_11 + arg_127_0 and not isNil(var_127_10) and arg_124_1.var_.characterEffect1095ui_story then
				arg_124_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_124_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_127_12 = arg_124_1.actors_["10079ui_story"].transform

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				arg_124_1.var_.moveOldPos10079ui_story = var_127_12.localPosition
			end

			local var_127_13 = 0.001

			if 0 <= arg_124_1.time_ and arg_124_1.time_ < 0 + var_127_13 then
				var_127_12.localPosition = Vector3.Lerp(arg_124_1.var_.moveOldPos10079ui_story, Vector3.New(0, 100, 0), (arg_124_1.time_ - 0) / var_127_13)
				var_127_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_127_12.position).x, (manager.ui.mainCamera.transform.position - var_127_12.position).y, (manager.ui.mainCamera.transform.position - var_127_12.position).z)
				var_127_12.localEulerAngles.z = 0
				var_127_12.localEulerAngles.x = 0
				var_127_12.localEulerAngles = var_127_12.localEulerAngles
			end

			if arg_124_1.time_ >= 0 + var_127_13 and arg_124_1.time_ < 0 + var_127_13 + arg_127_0 then
				var_127_12.localPosition = Vector3.New(0, 100, 0)
				var_127_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_127_12.position).x, (manager.ui.mainCamera.transform.position - var_127_12.position).y, (manager.ui.mainCamera.transform.position - var_127_12.position).z)
				var_127_12.localEulerAngles.z = 0
				var_127_12.localEulerAngles.x = 0
				var_127_12.localEulerAngles = var_127_12.localEulerAngles
			end

			local var_127_14 = arg_124_1.actors_["10079ui_story"]

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 and not isNil(var_127_14) and arg_124_1.var_.characterEffect10079ui_story == nil then
				arg_124_1.var_.characterEffect10079ui_story = var_127_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_127_15 = 0.200000002980232

			if 0 <= arg_124_1.time_ and arg_124_1.time_ < 0 + var_127_15 and not isNil(var_127_14) then
				if arg_124_1.var_.characterEffect10079ui_story and not isNil(var_127_14) then
					arg_124_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_124_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_124_1.time_ - 0) / var_127_15)
				end
			end

			if arg_124_1.time_ >= 0 + var_127_15 and arg_124_1.time_ < 0 + var_127_15 + arg_127_0 and not isNil(var_127_14) and arg_124_1.var_.characterEffect10079ui_story then
				arg_124_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_124_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			local var_127_16 = 0
			local var_127_17 = 0.4

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= var_127_16 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				arg_124_1.leftNameTxt_.text = arg_124_1:FormatText(StoryNameCfg[383].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_18 = arg_124_1:GetWordFromCfg(319631030)
				local var_127_19 = arg_124_1:FormatText(var_127_18.content)

				arg_124_1.text_.text = var_127_19

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_21 = 16 <= 0 and var_127_17 or var_127_17 * (utf8.len(var_127_19) / 16)

				if (16 <= 0 and var_127_17 or var_127_17 * (utf8.len(var_127_19) / 16)) > 0 and var_127_17 < var_127_21 then
					arg_124_1.talkMaxDuration = var_127_21

					if var_127_21 + var_127_16 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_21 + var_127_16
					end
				end

				arg_124_1.text_.text = var_127_19
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319631", "319631030", "story_v_out_319631.awb") ~= 0 then
					local var_127_22 = manager.audio:GetVoiceLength("story_v_out_319631", "319631030", "story_v_out_319631.awb") / 1000

					if var_127_22 + var_127_16 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_22 + var_127_16
					end

					if var_127_18.prefab_name ~= "" and arg_124_1.actors_[var_127_18.prefab_name] ~= nil then
						local var_127_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_124_1.actors_[var_127_18.prefab_name].transform, "story_v_out_319631", "319631030", "story_v_out_319631.awb")

						arg_124_1:RecordAudio("319631030", var_127_23)
						arg_124_1:RecordAudio("319631030", var_127_23)
					else
						arg_124_1:AudioAction("play", "voice", "story_v_out_319631", "319631030", "story_v_out_319631.awb")
					end

					arg_124_1:RecordHistoryTalkVoice("story_v_out_319631", "319631030", "story_v_out_319631.awb")
				end

				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_24 = math.max(var_127_17, arg_124_1.talkMaxDuration)

			if var_127_16 <= arg_124_1.time_ and arg_124_1.time_ < var_127_16 + var_127_24 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_16) / var_127_24

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_16 + var_127_24 and arg_124_1.time_ < var_127_16 + var_127_24 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10079ui_story",
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
	Play319631031 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 319631031
		arg_128_1.duration_ = 12.87

		local var_128_0 = {
			zh = 12.866,
			ja = 11.566
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
				arg_128_0:Play319631032(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
				arg_128_1.var_.moveOldPos4037ui_story = arg_128_1.actors_["4037ui_story"].transform.localPosition
			end

			local var_131_0 = 0.001

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_0 then
				arg_128_1.actors_["4037ui_story"].transform.localPosition = Vector3.Lerp(arg_128_1.var_.moveOldPos4037ui_story, Vector3.New(0, -1.12, -6.2), (arg_128_1.time_ - 0) / var_131_0)
				arg_128_1.actors_["4037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_128_1.actors_["4037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_128_1.actors_["4037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_128_1.actors_["4037ui_story"].transform.position).z)
				arg_128_1.actors_["4037ui_story"].transform.localEulerAngles.z = 0
				arg_128_1.actors_["4037ui_story"].transform.localEulerAngles.x = 0
				arg_128_1.actors_["4037ui_story"].transform.localEulerAngles = arg_128_1.actors_["4037ui_story"].transform.localEulerAngles
			end

			if arg_128_1.time_ >= 0 + var_131_0 and arg_128_1.time_ < 0 + var_131_0 + arg_131_0 then
				arg_128_1.actors_["4037ui_story"].transform.localPosition = Vector3.New(0, -1.12, -6.2)
				arg_128_1.actors_["4037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_128_1.actors_["4037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_128_1.actors_["4037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_128_1.actors_["4037ui_story"].transform.position).z)
				arg_128_1.actors_["4037ui_story"].transform.localEulerAngles.z = 0
				arg_128_1.actors_["4037ui_story"].transform.localEulerAngles.x = 0
				arg_128_1.actors_["4037ui_story"].transform.localEulerAngles = arg_128_1.actors_["4037ui_story"].transform.localEulerAngles
			end

			local var_131_1 = arg_128_1.actors_["4037ui_story"]

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 and not isNil(var_131_1) and arg_128_1.var_.characterEffect4037ui_story == nil then
				arg_128_1.var_.characterEffect4037ui_story = var_131_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_131_2 = 0.200000002980232

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_2 and not isNil(var_131_1) then
				if arg_128_1.var_.characterEffect4037ui_story and not isNil(var_131_1) then
					arg_128_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_128_1.time_ >= 0 + var_131_2 and arg_128_1.time_ < 0 + var_131_2 + arg_131_0 and not isNil(var_131_1) and arg_128_1.var_.characterEffect4037ui_story then
				arg_128_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			local var_131_4 = arg_128_1.actors_["10037ui_story"].transform

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
				arg_128_1.var_.moveOldPos10037ui_story = var_131_4.localPosition
			end

			local var_131_5 = 0.001

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_5 then
				var_131_4.localPosition = Vector3.Lerp(arg_128_1.var_.moveOldPos10037ui_story, Vector3.New(0, 100, 0), (arg_128_1.time_ - 0) / var_131_5)
				var_131_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_131_4.position).x, (manager.ui.mainCamera.transform.position - var_131_4.position).y, (manager.ui.mainCamera.transform.position - var_131_4.position).z)
				var_131_4.localEulerAngles.z = 0
				var_131_4.localEulerAngles.x = 0
				var_131_4.localEulerAngles = var_131_4.localEulerAngles
			end

			if arg_128_1.time_ >= 0 + var_131_5 and arg_128_1.time_ < 0 + var_131_5 + arg_131_0 then
				var_131_4.localPosition = Vector3.New(0, 100, 0)
				var_131_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_131_4.position).x, (manager.ui.mainCamera.transform.position - var_131_4.position).y, (manager.ui.mainCamera.transform.position - var_131_4.position).z)
				var_131_4.localEulerAngles.z = 0
				var_131_4.localEulerAngles.x = 0
				var_131_4.localEulerAngles = var_131_4.localEulerAngles
			end

			local var_131_6 = arg_128_1.actors_["10037ui_story"]

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 and not isNil(var_131_6) and arg_128_1.var_.characterEffect10037ui_story == nil then
				arg_128_1.var_.characterEffect10037ui_story = var_131_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_131_7 = 0.200000002980232

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_7 and not isNil(var_131_6) then
				if arg_128_1.var_.characterEffect10037ui_story and not isNil(var_131_6) then
					arg_128_1.var_.characterEffect10037ui_story.fillFlat = true
					arg_128_1.var_.characterEffect10037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_128_1.time_ - 0) / var_131_7)
				end
			end

			if arg_128_1.time_ >= 0 + var_131_7 and arg_128_1.time_ < 0 + var_131_7 + arg_131_0 and not isNil(var_131_6) and arg_128_1.var_.characterEffect10037ui_story then
				arg_128_1.var_.characterEffect10037ui_story.fillFlat = true
				arg_128_1.var_.characterEffect10037ui_story.fillRatio = 0.5
			end

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
				arg_128_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action4_2")
			end

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
				arg_128_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_131_8 = 0
			local var_131_9 = 1.25

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= var_131_8 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				arg_128_1.leftNameTxt_.text = arg_128_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_10 = arg_128_1:GetWordFromCfg(319631031)
				local var_131_11 = arg_128_1:FormatText(var_131_10.content)

				arg_128_1.text_.text = var_131_11

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_13 = 50 <= 0 and var_131_9 or var_131_9 * (utf8.len(var_131_11) / 50)

				if (50 <= 0 and var_131_9 or var_131_9 * (utf8.len(var_131_11) / 50)) > 0 and var_131_9 < var_131_13 then
					arg_128_1.talkMaxDuration = var_131_13

					if var_131_13 + var_131_8 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_13 + var_131_8
					end
				end

				arg_128_1.text_.text = var_131_11
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319631", "319631031", "story_v_out_319631.awb") ~= 0 then
					local var_131_14 = manager.audio:GetVoiceLength("story_v_out_319631", "319631031", "story_v_out_319631.awb") / 1000

					if var_131_14 + var_131_8 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_14 + var_131_8
					end

					if var_131_10.prefab_name ~= "" and arg_128_1.actors_[var_131_10.prefab_name] ~= nil then
						local var_131_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_10.prefab_name].transform, "story_v_out_319631", "319631031", "story_v_out_319631.awb")

						arg_128_1:RecordAudio("319631031", var_131_15)
						arg_128_1:RecordAudio("319631031", var_131_15)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_out_319631", "319631031", "story_v_out_319631.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_out_319631", "319631031", "story_v_out_319631.awb")
				end

				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_16 = math.max(var_131_9, arg_128_1.talkMaxDuration)

			if var_131_8 <= arg_128_1.time_ and arg_128_1.time_ < var_131_8 + var_131_16 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_8) / var_131_16

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_8 + var_131_16 and arg_128_1.time_ < var_131_8 + var_131_16 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {
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
				actorName = "10037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_128_1:InitPlayNodeList()
	end,
	Play319631032 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 319631032
		arg_132_1.duration_ = 8.27

		local var_132_0 = {
			zh = 5.4,
			ja = 8.266
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
				arg_132_0:Play319631033(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			local var_135_0 = 0.625

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				arg_132_1.leftNameTxt_.text = arg_132_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_1 = arg_132_1:GetWordFromCfg(319631032)
				local var_135_2 = arg_132_1:FormatText(var_135_1.content)

				arg_132_1.text_.text = var_135_2

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_4 = 25 <= 0 and var_135_0 or var_135_0 * (utf8.len(var_135_2) / 25)

				if (25 <= 0 and var_135_0 or var_135_0 * (utf8.len(var_135_2) / 25)) > 0 and var_135_0 < var_135_4 then
					arg_132_1.talkMaxDuration = var_135_4

					if var_135_4 + 0 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_4 + 0
					end
				end

				arg_132_1.text_.text = var_135_2
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319631", "319631032", "story_v_out_319631.awb") ~= 0 then
					local var_135_5 = manager.audio:GetVoiceLength("story_v_out_319631", "319631032", "story_v_out_319631.awb") / 1000

					if var_135_5 + 0 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_5 + 0
					end

					if var_135_1.prefab_name ~= "" and arg_132_1.actors_[var_135_1.prefab_name] ~= nil then
						local var_135_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_1.prefab_name].transform, "story_v_out_319631", "319631032", "story_v_out_319631.awb")

						arg_132_1:RecordAudio("319631032", var_135_6)
						arg_132_1:RecordAudio("319631032", var_135_6)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_out_319631", "319631032", "story_v_out_319631.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_out_319631", "319631032", "story_v_out_319631.awb")
				end

				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_7 = math.max(var_135_0, arg_132_1.talkMaxDuration)

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_7 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - 0) / var_135_7

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= 0 + var_135_7 and arg_132_1.time_ < 0 + var_135_7 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {}

		arg_132_1:InitPlayNodeList()
	end,
	Play319631033 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 319631033
		arg_136_1.duration_ = 5

		SetActive(arg_136_1.tipsGo_, false)

		function arg_136_1.onSingleLineFinish_()
			arg_136_1.onSingleLineUpdate_ = nil
			arg_136_1.onSingleLineFinish_ = nil
			arg_136_1.state_ = "waiting"
		end

		function arg_136_1.playNext_(arg_138_0)
			if arg_138_0 == 1 then
				arg_136_0:Play319631034(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 and not isNil(arg_136_1.actors_["4037ui_story"]) and arg_136_1.var_.characterEffect4037ui_story == nil then
				arg_136_1.var_.characterEffect4037ui_story = arg_136_1.actors_["4037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_139_0 = 0.200000002980232

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_0 and not isNil(arg_136_1.actors_["4037ui_story"]) then
				if arg_136_1.var_.characterEffect4037ui_story and not isNil(arg_136_1.actors_["4037ui_story"]) then
					arg_136_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_136_1.var_.characterEffect4037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_136_1.time_ - 0) / var_139_0)
				end
			end

			if arg_136_1.time_ >= 0 + var_139_0 and arg_136_1.time_ < 0 + var_139_0 + arg_139_0 and not isNil(arg_136_1.actors_["4037ui_story"]) and arg_136_1.var_.characterEffect4037ui_story then
				arg_136_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_136_1.var_.characterEffect4037ui_story.fillRatio = 0.5
			end

			local var_139_1 = 0
			local var_139_2 = 0.725

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= var_139_1 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, false)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_3 = arg_136_1:FormatText(arg_136_1:GetWordFromCfg(319631033).content)

				arg_136_1.text_.text = var_139_3

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_5 = 29 <= 0 and var_139_2 or var_139_2 * (utf8.len(var_139_3) / 29)

				if (29 <= 0 and var_139_2 or var_139_2 * (utf8.len(var_139_3) / 29)) > 0 and var_139_2 < var_139_5 then
					arg_136_1.talkMaxDuration = var_139_5

					if var_139_5 + var_139_1 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_5 + var_139_1
					end
				end

				arg_136_1.text_.text = var_139_3
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)
				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_6 = math.max(var_139_2, arg_136_1.talkMaxDuration)

			if var_139_1 <= arg_136_1.time_ and arg_136_1.time_ < var_139_1 + var_139_6 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_1) / var_139_6

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_1 + var_139_6 and arg_136_1.time_ < var_139_1 + var_139_6 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {}

		arg_136_1:InitPlayNodeList()
	end,
	Play319631034 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 319631034
		arg_140_1.duration_ = 9.97

		local var_140_0 = {
			zh = 9.966,
			ja = 9.433
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
				arg_140_0:Play319631035(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 and not isNil(arg_140_1.actors_["4037ui_story"]) and arg_140_1.var_.characterEffect4037ui_story == nil then
				arg_140_1.var_.characterEffect4037ui_story = arg_140_1.actors_["4037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_143_0 = 0.200000002980232

			if 0 <= arg_140_1.time_ and arg_140_1.time_ < 0 + var_143_0 and not isNil(arg_140_1.actors_["4037ui_story"]) then
				if arg_140_1.var_.characterEffect4037ui_story and not isNil(arg_140_1.actors_["4037ui_story"]) then
					arg_140_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_140_1.time_ >= 0 + var_143_0 and arg_140_1.time_ < 0 + var_143_0 + arg_143_0 and not isNil(arg_140_1.actors_["4037ui_story"]) and arg_140_1.var_.characterEffect4037ui_story then
				arg_140_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			local var_143_2 = 0
			local var_143_3 = 1

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= var_143_2 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, true)

				arg_140_1.leftNameTxt_.text = arg_140_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_140_1.leftNameTxt_.transform)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1.leftNameTxt_.text)
				SetActive(arg_140_1.iconTrs_.gameObject, false)
				arg_140_1.callingController_:SetSelectedState("normal")

				local var_143_4 = arg_140_1:GetWordFromCfg(319631034)
				local var_143_5 = arg_140_1:FormatText(var_143_4.content)

				arg_140_1.text_.text = var_143_5

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_7 = 40 <= 0 and var_143_3 or var_143_3 * (utf8.len(var_143_5) / 40)

				if (40 <= 0 and var_143_3 or var_143_3 * (utf8.len(var_143_5) / 40)) > 0 and var_143_3 < var_143_7 then
					arg_140_1.talkMaxDuration = var_143_7

					if var_143_7 + var_143_2 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_7 + var_143_2
					end
				end

				arg_140_1.text_.text = var_143_5
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319631", "319631034", "story_v_out_319631.awb") ~= 0 then
					local var_143_8 = manager.audio:GetVoiceLength("story_v_out_319631", "319631034", "story_v_out_319631.awb") / 1000

					if var_143_8 + var_143_2 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_8 + var_143_2
					end

					if var_143_4.prefab_name ~= "" and arg_140_1.actors_[var_143_4.prefab_name] ~= nil then
						local var_143_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_140_1.actors_[var_143_4.prefab_name].transform, "story_v_out_319631", "319631034", "story_v_out_319631.awb")

						arg_140_1:RecordAudio("319631034", var_143_9)
						arg_140_1:RecordAudio("319631034", var_143_9)
					else
						arg_140_1:AudioAction("play", "voice", "story_v_out_319631", "319631034", "story_v_out_319631.awb")
					end

					arg_140_1:RecordHistoryTalkVoice("story_v_out_319631", "319631034", "story_v_out_319631.awb")
				end

				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_10 = math.max(var_143_3, arg_140_1.talkMaxDuration)

			if var_143_2 <= arg_140_1.time_ and arg_140_1.time_ < var_143_2 + var_143_10 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_2) / var_143_10

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_2 + var_143_10 and arg_140_1.time_ < var_143_2 + var_143_10 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {}

		arg_140_1:InitPlayNodeList()
	end,
	Play319631035 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 319631035
		arg_144_1.duration_ = 15.43

		local var_144_0 = {
			zh = 9.366,
			ja = 15.433
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
				arg_144_0:Play319631036(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			local var_147_0 = 0.95

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				arg_144_1.leftNameTxt_.text = arg_144_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, false)
				arg_144_1.callingController_:SetSelectedState("normal")

				local var_147_1 = arg_144_1:GetWordFromCfg(319631035)
				local var_147_2 = arg_144_1:FormatText(var_147_1.content)

				arg_144_1.text_.text = var_147_2

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_4 = 38 <= 0 and var_147_0 or var_147_0 * (utf8.len(var_147_2) / 38)

				if (38 <= 0 and var_147_0 or var_147_0 * (utf8.len(var_147_2) / 38)) > 0 and var_147_0 < var_147_4 then
					arg_144_1.talkMaxDuration = var_147_4

					if var_147_4 + 0 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_4 + 0
					end
				end

				arg_144_1.text_.text = var_147_2
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319631", "319631035", "story_v_out_319631.awb") ~= 0 then
					local var_147_5 = manager.audio:GetVoiceLength("story_v_out_319631", "319631035", "story_v_out_319631.awb") / 1000

					if var_147_5 + 0 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_5 + 0
					end

					if var_147_1.prefab_name ~= "" and arg_144_1.actors_[var_147_1.prefab_name] ~= nil then
						local var_147_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_144_1.actors_[var_147_1.prefab_name].transform, "story_v_out_319631", "319631035", "story_v_out_319631.awb")

						arg_144_1:RecordAudio("319631035", var_147_6)
						arg_144_1:RecordAudio("319631035", var_147_6)
					else
						arg_144_1:AudioAction("play", "voice", "story_v_out_319631", "319631035", "story_v_out_319631.awb")
					end

					arg_144_1:RecordHistoryTalkVoice("story_v_out_319631", "319631035", "story_v_out_319631.awb")
				end

				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_7 = math.max(var_147_0, arg_144_1.talkMaxDuration)

			if 0 <= arg_144_1.time_ and arg_144_1.time_ < 0 + var_147_7 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - 0) / var_147_7

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= 0 + var_147_7 and arg_144_1.time_ < 0 + var_147_7 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {}

		arg_144_1:InitPlayNodeList()
	end,
	Play319631036 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 319631036
		arg_148_1.duration_ = 9.43

		local var_148_0 = {
			zh = 9.433,
			ja = 8.9
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
				arg_148_0:Play319631037(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 then
				arg_148_1.var_.moveOldPos4037ui_story = arg_148_1.actors_["4037ui_story"].transform.localPosition
			end

			local var_151_0 = 0.001

			if 0 <= arg_148_1.time_ and arg_148_1.time_ < 0 + var_151_0 then
				arg_148_1.actors_["4037ui_story"].transform.localPosition = Vector3.Lerp(arg_148_1.var_.moveOldPos4037ui_story, Vector3.New(0, -1.12, -6.2), (arg_148_1.time_ - 0) / var_151_0)
				arg_148_1.actors_["4037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_148_1.actors_["4037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_148_1.actors_["4037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_148_1.actors_["4037ui_story"].transform.position).z)
				arg_148_1.actors_["4037ui_story"].transform.localEulerAngles.z = 0
				arg_148_1.actors_["4037ui_story"].transform.localEulerAngles.x = 0
				arg_148_1.actors_["4037ui_story"].transform.localEulerAngles = arg_148_1.actors_["4037ui_story"].transform.localEulerAngles
			end

			if arg_148_1.time_ >= 0 + var_151_0 and arg_148_1.time_ < 0 + var_151_0 + arg_151_0 then
				arg_148_1.actors_["4037ui_story"].transform.localPosition = Vector3.New(0, -1.12, -6.2)
				arg_148_1.actors_["4037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_148_1.actors_["4037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_148_1.actors_["4037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_148_1.actors_["4037ui_story"].transform.position).z)
				arg_148_1.actors_["4037ui_story"].transform.localEulerAngles.z = 0
				arg_148_1.actors_["4037ui_story"].transform.localEulerAngles.x = 0
				arg_148_1.actors_["4037ui_story"].transform.localEulerAngles = arg_148_1.actors_["4037ui_story"].transform.localEulerAngles
			end

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 then
				arg_148_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action3_1")
			end

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 then
				arg_148_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_151_1 = 0
			local var_151_2 = 0.95

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= var_151_1 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, true)

				arg_148_1.leftNameTxt_.text = arg_148_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_148_1.leftNameTxt_.transform)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1.leftNameTxt_.text)
				SetActive(arg_148_1.iconTrs_.gameObject, false)
				arg_148_1.callingController_:SetSelectedState("normal")

				local var_151_3 = arg_148_1:GetWordFromCfg(319631036)
				local var_151_4 = arg_148_1:FormatText(var_151_3.content)

				arg_148_1.text_.text = var_151_4

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_6 = 38 <= 0 and var_151_2 or var_151_2 * (utf8.len(var_151_4) / 38)

				if (38 <= 0 and var_151_2 or var_151_2 * (utf8.len(var_151_4) / 38)) > 0 and var_151_2 < var_151_6 then
					arg_148_1.talkMaxDuration = var_151_6

					if var_151_6 + var_151_1 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_6 + var_151_1
					end
				end

				arg_148_1.text_.text = var_151_4
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319631", "319631036", "story_v_out_319631.awb") ~= 0 then
					local var_151_7 = manager.audio:GetVoiceLength("story_v_out_319631", "319631036", "story_v_out_319631.awb") / 1000

					if var_151_7 + var_151_1 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_7 + var_151_1
					end

					if var_151_3.prefab_name ~= "" and arg_148_1.actors_[var_151_3.prefab_name] ~= nil then
						local var_151_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_148_1.actors_[var_151_3.prefab_name].transform, "story_v_out_319631", "319631036", "story_v_out_319631.awb")

						arg_148_1:RecordAudio("319631036", var_151_8)
						arg_148_1:RecordAudio("319631036", var_151_8)
					else
						arg_148_1:AudioAction("play", "voice", "story_v_out_319631", "319631036", "story_v_out_319631.awb")
					end

					arg_148_1:RecordHistoryTalkVoice("story_v_out_319631", "319631036", "story_v_out_319631.awb")
				end

				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_9 = math.max(var_151_2, arg_148_1.talkMaxDuration)

			if var_151_1 <= arg_148_1.time_ and arg_148_1.time_ < var_151_1 + var_151_9 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_1) / var_151_9

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_1 + var_151_9 and arg_148_1.time_ < var_151_1 + var_151_9 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {
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

		arg_148_1:InitPlayNodeList()
	end,
	Play319631037 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 319631037
		arg_152_1.duration_ = 5.4

		local var_152_0 = {
			zh = 4,
			ja = 5.4
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
				arg_152_0:Play319631038(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 then
				arg_152_1.var_.moveOldPos10079ui_story = arg_152_1.actors_["10079ui_story"].transform.localPosition
			end

			local var_155_0 = 0.001

			if 0 <= arg_152_1.time_ and arg_152_1.time_ < 0 + var_155_0 then
				arg_152_1.actors_["10079ui_story"].transform.localPosition = Vector3.Lerp(arg_152_1.var_.moveOldPos10079ui_story, Vector3.New(0, -0.95, -6.05), (arg_152_1.time_ - 0) / var_155_0)
				arg_152_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_152_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_152_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_152_1.actors_["10079ui_story"].transform.position).z)
				arg_152_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_152_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_152_1.actors_["10079ui_story"].transform.localEulerAngles = arg_152_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			if arg_152_1.time_ >= 0 + var_155_0 and arg_152_1.time_ < 0 + var_155_0 + arg_155_0 then
				arg_152_1.actors_["10079ui_story"].transform.localPosition = Vector3.New(0, -0.95, -6.05)
				arg_152_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_152_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_152_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_152_1.actors_["10079ui_story"].transform.position).z)
				arg_152_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_152_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_152_1.actors_["10079ui_story"].transform.localEulerAngles = arg_152_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			local var_155_1 = arg_152_1.actors_["10079ui_story"]

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 and not isNil(var_155_1) and arg_152_1.var_.characterEffect10079ui_story == nil then
				arg_152_1.var_.characterEffect10079ui_story = var_155_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_155_2 = 0.200000002980232

			if 0 <= arg_152_1.time_ and arg_152_1.time_ < 0 + var_155_2 and not isNil(var_155_1) then
				if arg_152_1.var_.characterEffect10079ui_story and not isNil(var_155_1) then
					arg_152_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_152_1.time_ >= 0 + var_155_2 and arg_152_1.time_ < 0 + var_155_2 + arg_155_0 and not isNil(var_155_1) and arg_152_1.var_.characterEffect10079ui_story then
				arg_152_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 then
				arg_152_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action12_2")
			end

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 then
				arg_152_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_155_4 = arg_152_1.actors_["4037ui_story"].transform

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 then
				arg_152_1.var_.moveOldPos4037ui_story = var_155_4.localPosition
			end

			local var_155_5 = 0.001

			if 0 <= arg_152_1.time_ and arg_152_1.time_ < 0 + var_155_5 then
				var_155_4.localPosition = Vector3.Lerp(arg_152_1.var_.moveOldPos4037ui_story, Vector3.New(0, 100, 0), (arg_152_1.time_ - 0) / var_155_5)
				var_155_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_155_4.position).x, (manager.ui.mainCamera.transform.position - var_155_4.position).y, (manager.ui.mainCamera.transform.position - var_155_4.position).z)
				var_155_4.localEulerAngles.z = 0
				var_155_4.localEulerAngles.x = 0
				var_155_4.localEulerAngles = var_155_4.localEulerAngles
			end

			if arg_152_1.time_ >= 0 + var_155_5 and arg_152_1.time_ < 0 + var_155_5 + arg_155_0 then
				var_155_4.localPosition = Vector3.New(0, 100, 0)
				var_155_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_155_4.position).x, (manager.ui.mainCamera.transform.position - var_155_4.position).y, (manager.ui.mainCamera.transform.position - var_155_4.position).z)
				var_155_4.localEulerAngles.z = 0
				var_155_4.localEulerAngles.x = 0
				var_155_4.localEulerAngles = var_155_4.localEulerAngles
			end

			local var_155_6 = arg_152_1.actors_["4037ui_story"]

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 and not isNil(var_155_6) and arg_152_1.var_.characterEffect4037ui_story == nil then
				arg_152_1.var_.characterEffect4037ui_story = var_155_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_155_7 = 0.200000002980232

			if 0 <= arg_152_1.time_ and arg_152_1.time_ < 0 + var_155_7 and not isNil(var_155_6) then
				if arg_152_1.var_.characterEffect4037ui_story and not isNil(var_155_6) then
					arg_152_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_152_1.var_.characterEffect4037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_152_1.time_ - 0) / var_155_7)
				end
			end

			if arg_152_1.time_ >= 0 + var_155_7 and arg_152_1.time_ < 0 + var_155_7 + arg_155_0 and not isNil(var_155_6) and arg_152_1.var_.characterEffect4037ui_story then
				arg_152_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_152_1.var_.characterEffect4037ui_story.fillRatio = 0.5
			end

			local var_155_8 = 0
			local var_155_9 = 0.4

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= var_155_8 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, true)

				arg_152_1.leftNameTxt_.text = arg_152_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_152_1.leftNameTxt_.transform)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1.leftNameTxt_.text)
				SetActive(arg_152_1.iconTrs_.gameObject, false)
				arg_152_1.callingController_:SetSelectedState("normal")

				local var_155_10 = arg_152_1:GetWordFromCfg(319631037)
				local var_155_11 = arg_152_1:FormatText(var_155_10.content)

				arg_152_1.text_.text = var_155_11

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_13 = 16 <= 0 and var_155_9 or var_155_9 * (utf8.len(var_155_11) / 16)

				if (16 <= 0 and var_155_9 or var_155_9 * (utf8.len(var_155_11) / 16)) > 0 and var_155_9 < var_155_13 then
					arg_152_1.talkMaxDuration = var_155_13

					if var_155_13 + var_155_8 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_13 + var_155_8
					end
				end

				arg_152_1.text_.text = var_155_11
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319631", "319631037", "story_v_out_319631.awb") ~= 0 then
					local var_155_14 = manager.audio:GetVoiceLength("story_v_out_319631", "319631037", "story_v_out_319631.awb") / 1000

					if var_155_14 + var_155_8 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_14 + var_155_8
					end

					if var_155_10.prefab_name ~= "" and arg_152_1.actors_[var_155_10.prefab_name] ~= nil then
						local var_155_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_152_1.actors_[var_155_10.prefab_name].transform, "story_v_out_319631", "319631037", "story_v_out_319631.awb")

						arg_152_1:RecordAudio("319631037", var_155_15)
						arg_152_1:RecordAudio("319631037", var_155_15)
					else
						arg_152_1:AudioAction("play", "voice", "story_v_out_319631", "319631037", "story_v_out_319631.awb")
					end

					arg_152_1:RecordHistoryTalkVoice("story_v_out_319631", "319631037", "story_v_out_319631.awb")
				end

				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_16 = math.max(var_155_9, arg_152_1.talkMaxDuration)

			if var_155_8 <= arg_152_1.time_ and arg_152_1.time_ < var_155_8 + var_155_16 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - var_155_8) / var_155_16

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= var_155_8 + var_155_16 and arg_152_1.time_ < var_155_8 + var_155_16 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {
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
				actorName = "4037ui_story",
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
	Play319631038 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 319631038
		arg_156_1.duration_ = 6.57

		local var_156_0 = {
			zh = 6.566,
			ja = 6.4
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
				arg_156_0:Play319631039(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 then
				arg_156_1.var_.moveOldPos4037ui_story = arg_156_1.actors_["4037ui_story"].transform.localPosition
			end

			local var_159_0 = 0.001

			if 0 <= arg_156_1.time_ and arg_156_1.time_ < 0 + var_159_0 then
				arg_156_1.actors_["4037ui_story"].transform.localPosition = Vector3.Lerp(arg_156_1.var_.moveOldPos4037ui_story, Vector3.New(-0.7, -1.12, -6.2), (arg_156_1.time_ - 0) / var_159_0)
				arg_156_1.actors_["4037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_156_1.actors_["4037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_156_1.actors_["4037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_156_1.actors_["4037ui_story"].transform.position).z)
				arg_156_1.actors_["4037ui_story"].transform.localEulerAngles.z = 0
				arg_156_1.actors_["4037ui_story"].transform.localEulerAngles.x = 0
				arg_156_1.actors_["4037ui_story"].transform.localEulerAngles = arg_156_1.actors_["4037ui_story"].transform.localEulerAngles
			end

			if arg_156_1.time_ >= 0 + var_159_0 and arg_156_1.time_ < 0 + var_159_0 + arg_159_0 then
				arg_156_1.actors_["4037ui_story"].transform.localPosition = Vector3.New(-0.7, -1.12, -6.2)
				arg_156_1.actors_["4037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_156_1.actors_["4037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_156_1.actors_["4037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_156_1.actors_["4037ui_story"].transform.position).z)
				arg_156_1.actors_["4037ui_story"].transform.localEulerAngles.z = 0
				arg_156_1.actors_["4037ui_story"].transform.localEulerAngles.x = 0
				arg_156_1.actors_["4037ui_story"].transform.localEulerAngles = arg_156_1.actors_["4037ui_story"].transform.localEulerAngles
			end

			local var_159_1 = arg_156_1.actors_["4037ui_story"]

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 and not isNil(var_159_1) and arg_156_1.var_.characterEffect4037ui_story == nil then
				arg_156_1.var_.characterEffect4037ui_story = var_159_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_159_2 = 0.200000002980232

			if 0 <= arg_156_1.time_ and arg_156_1.time_ < 0 + var_159_2 and not isNil(var_159_1) then
				if arg_156_1.var_.characterEffect4037ui_story and not isNil(var_159_1) then
					arg_156_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_156_1.time_ >= 0 + var_159_2 and arg_156_1.time_ < 0 + var_159_2 + arg_159_0 and not isNil(var_159_1) and arg_156_1.var_.characterEffect4037ui_story then
				arg_156_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			local var_159_4 = arg_156_1.actors_["10079ui_story"].transform

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 then
				arg_156_1.var_.moveOldPos10079ui_story = var_159_4.localPosition
			end

			local var_159_5 = 0.001

			if 0 <= arg_156_1.time_ and arg_156_1.time_ < 0 + var_159_5 then
				var_159_4.localPosition = Vector3.Lerp(arg_156_1.var_.moveOldPos10079ui_story, Vector3.New(0.7, -0.95, -6.05), (arg_156_1.time_ - 0) / var_159_5)
				var_159_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_159_4.position).x, (manager.ui.mainCamera.transform.position - var_159_4.position).y, (manager.ui.mainCamera.transform.position - var_159_4.position).z)
				var_159_4.localEulerAngles.z = 0
				var_159_4.localEulerAngles.x = 0
				var_159_4.localEulerAngles = var_159_4.localEulerAngles
			end

			if arg_156_1.time_ >= 0 + var_159_5 and arg_156_1.time_ < 0 + var_159_5 + arg_159_0 then
				var_159_4.localPosition = Vector3.New(0.7, -0.95, -6.05)
				var_159_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_159_4.position).x, (manager.ui.mainCamera.transform.position - var_159_4.position).y, (manager.ui.mainCamera.transform.position - var_159_4.position).z)
				var_159_4.localEulerAngles.z = 0
				var_159_4.localEulerAngles.x = 0
				var_159_4.localEulerAngles = var_159_4.localEulerAngles
			end

			local var_159_6 = arg_156_1.actors_["10079ui_story"]

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 and not isNil(var_159_6) and arg_156_1.var_.characterEffect10079ui_story == nil then
				arg_156_1.var_.characterEffect10079ui_story = var_159_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_159_7 = 0.200000002980232

			if 0 <= arg_156_1.time_ and arg_156_1.time_ < 0 + var_159_7 and not isNil(var_159_6) then
				if arg_156_1.var_.characterEffect10079ui_story and not isNil(var_159_6) then
					arg_156_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_156_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_156_1.time_ - 0) / var_159_7)
				end
			end

			if arg_156_1.time_ >= 0 + var_159_7 and arg_156_1.time_ < 0 + var_159_7 + arg_159_0 and not isNil(var_159_6) and arg_156_1.var_.characterEffect10079ui_story then
				arg_156_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_156_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			local var_159_8 = 0
			local var_159_9 = 0.55

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= var_159_8 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, true)

				arg_156_1.leftNameTxt_.text = arg_156_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_156_1.leftNameTxt_.transform)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1.leftNameTxt_.text)
				SetActive(arg_156_1.iconTrs_.gameObject, false)
				arg_156_1.callingController_:SetSelectedState("normal")

				local var_159_10 = arg_156_1:GetWordFromCfg(319631038)
				local var_159_11 = arg_156_1:FormatText(var_159_10.content)

				arg_156_1.text_.text = var_159_11

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_13 = 22 <= 0 and var_159_9 or var_159_9 * (utf8.len(var_159_11) / 22)

				if (22 <= 0 and var_159_9 or var_159_9 * (utf8.len(var_159_11) / 22)) > 0 and var_159_9 < var_159_13 then
					arg_156_1.talkMaxDuration = var_159_13

					if var_159_13 + var_159_8 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_13 + var_159_8
					end
				end

				arg_156_1.text_.text = var_159_11
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319631", "319631038", "story_v_out_319631.awb") ~= 0 then
					local var_159_14 = manager.audio:GetVoiceLength("story_v_out_319631", "319631038", "story_v_out_319631.awb") / 1000

					if var_159_14 + var_159_8 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_14 + var_159_8
					end

					if var_159_10.prefab_name ~= "" and arg_156_1.actors_[var_159_10.prefab_name] ~= nil then
						local var_159_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_156_1.actors_[var_159_10.prefab_name].transform, "story_v_out_319631", "319631038", "story_v_out_319631.awb")

						arg_156_1:RecordAudio("319631038", var_159_15)
						arg_156_1:RecordAudio("319631038", var_159_15)
					else
						arg_156_1:AudioAction("play", "voice", "story_v_out_319631", "319631038", "story_v_out_319631.awb")
					end

					arg_156_1:RecordHistoryTalkVoice("story_v_out_319631", "319631038", "story_v_out_319631.awb")
				end

				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_16 = math.max(var_159_9, arg_156_1.talkMaxDuration)

			if var_159_8 <= arg_156_1.time_ and arg_156_1.time_ < var_159_8 + var_159_16 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_8) / var_159_16

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_8 + var_159_16 and arg_156_1.time_ < var_159_8 + var_159_16 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {
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
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_156_1:InitPlayNodeList()
	end,
	Play319631039 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 319631039
		arg_160_1.duration_ = 9.3

		local var_160_0 = {
			zh = 5.533,
			ja = 9.3
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
				arg_160_0:Play319631040(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 then
				arg_160_1.var_.moveOldPos10079ui_story = arg_160_1.actors_["10079ui_story"].transform.localPosition
			end

			local var_163_0 = 0.001

			if 0 <= arg_160_1.time_ and arg_160_1.time_ < 0 + var_163_0 then
				arg_160_1.actors_["10079ui_story"].transform.localPosition = Vector3.Lerp(arg_160_1.var_.moveOldPos10079ui_story, Vector3.New(0.7, -0.95, -6.05), (arg_160_1.time_ - 0) / var_163_0)
				arg_160_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_160_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_160_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_160_1.actors_["10079ui_story"].transform.position).z)
				arg_160_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_160_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_160_1.actors_["10079ui_story"].transform.localEulerAngles = arg_160_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			if arg_160_1.time_ >= 0 + var_163_0 and arg_160_1.time_ < 0 + var_163_0 + arg_163_0 then
				arg_160_1.actors_["10079ui_story"].transform.localPosition = Vector3.New(0.7, -0.95, -6.05)
				arg_160_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_160_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_160_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_160_1.actors_["10079ui_story"].transform.position).z)
				arg_160_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_160_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_160_1.actors_["10079ui_story"].transform.localEulerAngles = arg_160_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			local var_163_1 = arg_160_1.actors_["10079ui_story"]

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 and not isNil(var_163_1) and arg_160_1.var_.characterEffect10079ui_story == nil then
				arg_160_1.var_.characterEffect10079ui_story = var_163_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_163_2 = 0.200000002980232

			if 0 <= arg_160_1.time_ and arg_160_1.time_ < 0 + var_163_2 and not isNil(var_163_1) then
				if arg_160_1.var_.characterEffect10079ui_story and not isNil(var_163_1) then
					arg_160_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_160_1.time_ >= 0 + var_163_2 and arg_160_1.time_ < 0 + var_163_2 + arg_163_0 and not isNil(var_163_1) and arg_160_1.var_.characterEffect10079ui_story then
				arg_160_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 then
				arg_160_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_1")
			end

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 then
				arg_160_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_163_4 = arg_160_1.actors_["4037ui_story"].transform

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 then
				arg_160_1.var_.moveOldPos4037ui_story = var_163_4.localPosition
			end

			local var_163_5 = 0.001

			if 0 <= arg_160_1.time_ and arg_160_1.time_ < 0 + var_163_5 then
				var_163_4.localPosition = Vector3.Lerp(arg_160_1.var_.moveOldPos4037ui_story, Vector3.New(-0.7, -1.12, -6.2), (arg_160_1.time_ - 0) / var_163_5)
				var_163_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_163_4.position).x, (manager.ui.mainCamera.transform.position - var_163_4.position).y, (manager.ui.mainCamera.transform.position - var_163_4.position).z)
				var_163_4.localEulerAngles.z = 0
				var_163_4.localEulerAngles.x = 0
				var_163_4.localEulerAngles = var_163_4.localEulerAngles
			end

			if arg_160_1.time_ >= 0 + var_163_5 and arg_160_1.time_ < 0 + var_163_5 + arg_163_0 then
				var_163_4.localPosition = Vector3.New(-0.7, -1.12, -6.2)
				var_163_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_163_4.position).x, (manager.ui.mainCamera.transform.position - var_163_4.position).y, (manager.ui.mainCamera.transform.position - var_163_4.position).z)
				var_163_4.localEulerAngles.z = 0
				var_163_4.localEulerAngles.x = 0
				var_163_4.localEulerAngles = var_163_4.localEulerAngles
			end

			local var_163_6 = arg_160_1.actors_["4037ui_story"]

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 and not isNil(var_163_6) and arg_160_1.var_.characterEffect4037ui_story == nil then
				arg_160_1.var_.characterEffect4037ui_story = var_163_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_163_7 = 0.200000002980232

			if 0 <= arg_160_1.time_ and arg_160_1.time_ < 0 + var_163_7 and not isNil(var_163_6) then
				if arg_160_1.var_.characterEffect4037ui_story and not isNil(var_163_6) then
					arg_160_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_160_1.var_.characterEffect4037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_160_1.time_ - 0) / var_163_7)
				end
			end

			if arg_160_1.time_ >= 0 + var_163_7 and arg_160_1.time_ < 0 + var_163_7 + arg_163_0 and not isNil(var_163_6) and arg_160_1.var_.characterEffect4037ui_story then
				arg_160_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_160_1.var_.characterEffect4037ui_story.fillRatio = 0.5
			end

			local var_163_8 = 0
			local var_163_9 = 0.525

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= var_163_8 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, true)

				arg_160_1.leftNameTxt_.text = arg_160_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_160_1.leftNameTxt_.transform)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1.leftNameTxt_.text)
				SetActive(arg_160_1.iconTrs_.gameObject, false)
				arg_160_1.callingController_:SetSelectedState("normal")

				local var_163_10 = arg_160_1:GetWordFromCfg(319631039)
				local var_163_11 = arg_160_1:FormatText(var_163_10.content)

				arg_160_1.text_.text = var_163_11

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_13 = 21 <= 0 and var_163_9 or var_163_9 * (utf8.len(var_163_11) / 21)

				if (21 <= 0 and var_163_9 or var_163_9 * (utf8.len(var_163_11) / 21)) > 0 and var_163_9 < var_163_13 then
					arg_160_1.talkMaxDuration = var_163_13

					if var_163_13 + var_163_8 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_13 + var_163_8
					end
				end

				arg_160_1.text_.text = var_163_11
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319631", "319631039", "story_v_out_319631.awb") ~= 0 then
					local var_163_14 = manager.audio:GetVoiceLength("story_v_out_319631", "319631039", "story_v_out_319631.awb") / 1000

					if var_163_14 + var_163_8 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_14 + var_163_8
					end

					if var_163_10.prefab_name ~= "" and arg_160_1.actors_[var_163_10.prefab_name] ~= nil then
						local var_163_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_160_1.actors_[var_163_10.prefab_name].transform, "story_v_out_319631", "319631039", "story_v_out_319631.awb")

						arg_160_1:RecordAudio("319631039", var_163_15)
						arg_160_1:RecordAudio("319631039", var_163_15)
					else
						arg_160_1:AudioAction("play", "voice", "story_v_out_319631", "319631039", "story_v_out_319631.awb")
					end

					arg_160_1:RecordHistoryTalkVoice("story_v_out_319631", "319631039", "story_v_out_319631.awb")
				end

				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_16 = math.max(var_163_9, arg_160_1.talkMaxDuration)

			if var_163_8 <= arg_160_1.time_ and arg_160_1.time_ < var_163_8 + var_163_16 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - var_163_8) / var_163_16

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= var_163_8 + var_163_16 and arg_160_1.time_ < var_163_8 + var_163_16 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {
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
				actorName = "4037ui_story",
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
	Play319631040 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 319631040
		arg_164_1.duration_ = 2.47

		local var_164_0 = {
			zh = 1.999999999999,
			ja = 2.466
		}
		local var_164_1 = manager.audio:GetLocalizationFlag()

		if var_164_0[var_164_1] ~= nil then
			arg_164_1.duration_ = var_164_0[var_164_1]
		end

		SetActive(arg_164_1.tipsGo_, false)

		function arg_164_1.onSingleLineFinish_()
			arg_164_1.onSingleLineUpdate_ = nil
			arg_164_1.onSingleLineFinish_ = nil
			arg_164_1.state_ = "waiting"
		end

		function arg_164_1.playNext_(arg_166_0)
			if arg_166_0 == 1 then
				arg_164_0:Play319631041(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			if 0 < arg_164_1.time_ and arg_164_1.time_ <= 0 + arg_167_0 then
				arg_164_1.var_.moveOldPos4037ui_story = arg_164_1.actors_["4037ui_story"].transform.localPosition
			end

			local var_167_0 = 0.001

			if 0 <= arg_164_1.time_ and arg_164_1.time_ < 0 + var_167_0 then
				arg_164_1.actors_["4037ui_story"].transform.localPosition = Vector3.Lerp(arg_164_1.var_.moveOldPos4037ui_story, Vector3.New(-0.7, -1.12, -6.2), (arg_164_1.time_ - 0) / var_167_0)
				arg_164_1.actors_["4037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_164_1.actors_["4037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_164_1.actors_["4037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_164_1.actors_["4037ui_story"].transform.position).z)
				arg_164_1.actors_["4037ui_story"].transform.localEulerAngles.z = 0
				arg_164_1.actors_["4037ui_story"].transform.localEulerAngles.x = 0
				arg_164_1.actors_["4037ui_story"].transform.localEulerAngles = arg_164_1.actors_["4037ui_story"].transform.localEulerAngles
			end

			if arg_164_1.time_ >= 0 + var_167_0 and arg_164_1.time_ < 0 + var_167_0 + arg_167_0 then
				arg_164_1.actors_["4037ui_story"].transform.localPosition = Vector3.New(-0.7, -1.12, -6.2)
				arg_164_1.actors_["4037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_164_1.actors_["4037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_164_1.actors_["4037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_164_1.actors_["4037ui_story"].transform.position).z)
				arg_164_1.actors_["4037ui_story"].transform.localEulerAngles.z = 0
				arg_164_1.actors_["4037ui_story"].transform.localEulerAngles.x = 0
				arg_164_1.actors_["4037ui_story"].transform.localEulerAngles = arg_164_1.actors_["4037ui_story"].transform.localEulerAngles
			end

			local var_167_1 = arg_164_1.actors_["4037ui_story"]

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= 0 + arg_167_0 and not isNil(var_167_1) and arg_164_1.var_.characterEffect4037ui_story == nil then
				arg_164_1.var_.characterEffect4037ui_story = var_167_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_167_2 = 0.200000002980232

			if 0 <= arg_164_1.time_ and arg_164_1.time_ < 0 + var_167_2 and not isNil(var_167_1) then
				if arg_164_1.var_.characterEffect4037ui_story and not isNil(var_167_1) then
					arg_164_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_164_1.time_ >= 0 + var_167_2 and arg_164_1.time_ < 0 + var_167_2 + arg_167_0 and not isNil(var_167_1) and arg_164_1.var_.characterEffect4037ui_story then
				arg_164_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= 0 + arg_167_0 then
				arg_164_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action3_2")
			end

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= 0 + arg_167_0 then
				arg_164_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_167_4 = arg_164_1.actors_["10079ui_story"].transform

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= 0 + arg_167_0 then
				arg_164_1.var_.moveOldPos10079ui_story = var_167_4.localPosition
			end

			local var_167_5 = 0.001

			if 0 <= arg_164_1.time_ and arg_164_1.time_ < 0 + var_167_5 then
				var_167_4.localPosition = Vector3.Lerp(arg_164_1.var_.moveOldPos10079ui_story, Vector3.New(0.7, -0.95, -6.05), (arg_164_1.time_ - 0) / var_167_5)
				var_167_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_167_4.position).x, (manager.ui.mainCamera.transform.position - var_167_4.position).y, (manager.ui.mainCamera.transform.position - var_167_4.position).z)
				var_167_4.localEulerAngles.z = 0
				var_167_4.localEulerAngles.x = 0
				var_167_4.localEulerAngles = var_167_4.localEulerAngles
			end

			if arg_164_1.time_ >= 0 + var_167_5 and arg_164_1.time_ < 0 + var_167_5 + arg_167_0 then
				var_167_4.localPosition = Vector3.New(0.7, -0.95, -6.05)
				var_167_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_167_4.position).x, (manager.ui.mainCamera.transform.position - var_167_4.position).y, (manager.ui.mainCamera.transform.position - var_167_4.position).z)
				var_167_4.localEulerAngles.z = 0
				var_167_4.localEulerAngles.x = 0
				var_167_4.localEulerAngles = var_167_4.localEulerAngles
			end

			local var_167_6 = arg_164_1.actors_["10079ui_story"]

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= 0 + arg_167_0 and not isNil(var_167_6) and arg_164_1.var_.characterEffect10079ui_story == nil then
				arg_164_1.var_.characterEffect10079ui_story = var_167_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_167_7 = 0.200000002980232

			if 0 <= arg_164_1.time_ and arg_164_1.time_ < 0 + var_167_7 and not isNil(var_167_6) then
				if arg_164_1.var_.characterEffect10079ui_story and not isNil(var_167_6) then
					arg_164_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_164_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_164_1.time_ - 0) / var_167_7)
				end
			end

			if arg_164_1.time_ >= 0 + var_167_7 and arg_164_1.time_ < 0 + var_167_7 + arg_167_0 and not isNil(var_167_6) and arg_164_1.var_.characterEffect10079ui_story then
				arg_164_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_164_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			local var_167_8 = 0
			local var_167_9 = 0.1

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= var_167_8 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0
				arg_164_1.dialogCg_.alpha = 1

				arg_164_1.dialog_:SetActive(true)
				SetActive(arg_164_1.leftNameGo_, true)

				arg_164_1.leftNameTxt_.text = arg_164_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_164_1.leftNameTxt_.transform)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1.leftNameTxt_.text)
				SetActive(arg_164_1.iconTrs_.gameObject, false)
				arg_164_1.callingController_:SetSelectedState("normal")

				local var_167_10 = arg_164_1:GetWordFromCfg(319631040)
				local var_167_11 = arg_164_1:FormatText(var_167_10.content)

				arg_164_1.text_.text = var_167_11

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_13 = 4 <= 0 and var_167_9 or var_167_9 * (utf8.len(var_167_11) / 4)

				if (4 <= 0 and var_167_9 or var_167_9 * (utf8.len(var_167_11) / 4)) > 0 and var_167_9 < var_167_13 then
					arg_164_1.talkMaxDuration = var_167_13

					if var_167_13 + var_167_8 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_13 + var_167_8
					end
				end

				arg_164_1.text_.text = var_167_11
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319631", "319631040", "story_v_out_319631.awb") ~= 0 then
					local var_167_14 = manager.audio:GetVoiceLength("story_v_out_319631", "319631040", "story_v_out_319631.awb") / 1000

					if var_167_14 + var_167_8 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_14 + var_167_8
					end

					if var_167_10.prefab_name ~= "" and arg_164_1.actors_[var_167_10.prefab_name] ~= nil then
						local var_167_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_164_1.actors_[var_167_10.prefab_name].transform, "story_v_out_319631", "319631040", "story_v_out_319631.awb")

						arg_164_1:RecordAudio("319631040", var_167_15)
						arg_164_1:RecordAudio("319631040", var_167_15)
					else
						arg_164_1:AudioAction("play", "voice", "story_v_out_319631", "319631040", "story_v_out_319631.awb")
					end

					arg_164_1:RecordHistoryTalkVoice("story_v_out_319631", "319631040", "story_v_out_319631.awb")
				end

				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_16 = math.max(var_167_9, arg_164_1.talkMaxDuration)

			if var_167_8 <= arg_164_1.time_ and arg_164_1.time_ < var_167_8 + var_167_16 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - var_167_8) / var_167_16

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= var_167_8 + var_167_16 and arg_164_1.time_ < var_167_8 + var_167_16 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {
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
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_164_1:InitPlayNodeList()
	end,
	Play319631041 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 319631041
		arg_168_1.duration_ = 4.3

		local var_168_0 = {
			zh = 4.3,
			ja = 3.2
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
				arg_168_0:Play319631042(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 and not isNil(arg_168_1.actors_["10079ui_story"]) and arg_168_1.var_.characterEffect10079ui_story == nil then
				arg_168_1.var_.characterEffect10079ui_story = arg_168_1.actors_["10079ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_171_0 = 0.200000002980232

			if 0 <= arg_168_1.time_ and arg_168_1.time_ < 0 + var_171_0 and not isNil(arg_168_1.actors_["10079ui_story"]) then
				if arg_168_1.var_.characterEffect10079ui_story and not isNil(arg_168_1.actors_["10079ui_story"]) then
					arg_168_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_168_1.time_ >= 0 + var_171_0 and arg_168_1.time_ < 0 + var_171_0 + arg_171_0 and not isNil(arg_168_1.actors_["10079ui_story"]) and arg_168_1.var_.characterEffect10079ui_story then
				arg_168_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 then
				arg_168_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_2")
			end

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 then
				arg_168_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_171_2 = arg_168_1.actors_["4037ui_story"]

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 and not isNil(var_171_2) and arg_168_1.var_.characterEffect4037ui_story == nil then
				arg_168_1.var_.characterEffect4037ui_story = var_171_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_171_3 = 0.200000002980232

			if 0 <= arg_168_1.time_ and arg_168_1.time_ < 0 + var_171_3 and not isNil(var_171_2) then
				if arg_168_1.var_.characterEffect4037ui_story and not isNil(var_171_2) then
					arg_168_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_168_1.var_.characterEffect4037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_168_1.time_ - 0) / var_171_3)
				end
			end

			if arg_168_1.time_ >= 0 + var_171_3 and arg_168_1.time_ < 0 + var_171_3 + arg_171_0 and not isNil(var_171_2) and arg_168_1.var_.characterEffect4037ui_story then
				arg_168_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_168_1.var_.characterEffect4037ui_story.fillRatio = 0.5
			end

			local var_171_4 = 0
			local var_171_5 = 0.45

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= var_171_4 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0
				arg_168_1.dialogCg_.alpha = 1

				arg_168_1.dialog_:SetActive(true)
				SetActive(arg_168_1.leftNameGo_, true)

				arg_168_1.leftNameTxt_.text = arg_168_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_168_1.leftNameTxt_.transform)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1.leftNameTxt_.text)
				SetActive(arg_168_1.iconTrs_.gameObject, false)
				arg_168_1.callingController_:SetSelectedState("normal")

				local var_171_6 = arg_168_1:GetWordFromCfg(319631041)
				local var_171_7 = arg_168_1:FormatText(var_171_6.content)

				arg_168_1.text_.text = var_171_7

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_9 = 18 <= 0 and var_171_5 or var_171_5 * (utf8.len(var_171_7) / 18)

				if (18 <= 0 and var_171_5 or var_171_5 * (utf8.len(var_171_7) / 18)) > 0 and var_171_5 < var_171_9 then
					arg_168_1.talkMaxDuration = var_171_9

					if var_171_9 + var_171_4 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_9 + var_171_4
					end
				end

				arg_168_1.text_.text = var_171_7
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319631", "319631041", "story_v_out_319631.awb") ~= 0 then
					local var_171_10 = manager.audio:GetVoiceLength("story_v_out_319631", "319631041", "story_v_out_319631.awb") / 1000

					if var_171_10 + var_171_4 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_10 + var_171_4
					end

					if var_171_6.prefab_name ~= "" and arg_168_1.actors_[var_171_6.prefab_name] ~= nil then
						local var_171_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_168_1.actors_[var_171_6.prefab_name].transform, "story_v_out_319631", "319631041", "story_v_out_319631.awb")

						arg_168_1:RecordAudio("319631041", var_171_11)
						arg_168_1:RecordAudio("319631041", var_171_11)
					else
						arg_168_1:AudioAction("play", "voice", "story_v_out_319631", "319631041", "story_v_out_319631.awb")
					end

					arg_168_1:RecordHistoryTalkVoice("story_v_out_319631", "319631041", "story_v_out_319631.awb")
				end

				arg_168_1:RecordContent(arg_168_1.text_.text)
			end

			local var_171_12 = math.max(var_171_5, arg_168_1.talkMaxDuration)

			if var_171_4 <= arg_168_1.time_ and arg_168_1.time_ < var_171_4 + var_171_12 then
				arg_168_1.typewritter.percent = (arg_168_1.time_ - var_171_4) / var_171_12

				arg_168_1.typewritter:SetDirty()
			end

			if arg_168_1.time_ >= var_171_4 + var_171_12 and arg_168_1.time_ < var_171_4 + var_171_12 + arg_171_0 then
				arg_168_1.typewritter.percent = 1

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(true)
			end
		end

		arg_168_1.nodeConfigList_ = {}

		arg_168_1:InitPlayNodeList()
	end,
	Play319631042 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 319631042
		arg_172_1.duration_ = 9.3

		local var_172_0 = {
			zh = 6.9,
			ja = 9.3
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
				arg_172_0:Play319631043(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 and not isNil(arg_172_1.actors_["4037ui_story"]) and arg_172_1.var_.characterEffect4037ui_story == nil then
				arg_172_1.var_.characterEffect4037ui_story = arg_172_1.actors_["4037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_175_0 = 0.200000002980232

			if 0 <= arg_172_1.time_ and arg_172_1.time_ < 0 + var_175_0 and not isNil(arg_172_1.actors_["4037ui_story"]) then
				if arg_172_1.var_.characterEffect4037ui_story and not isNil(arg_172_1.actors_["4037ui_story"]) then
					arg_172_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_172_1.time_ >= 0 + var_175_0 and arg_172_1.time_ < 0 + var_175_0 + arg_175_0 and not isNil(arg_172_1.actors_["4037ui_story"]) and arg_172_1.var_.characterEffect4037ui_story then
				arg_172_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 then
				arg_172_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action1_1")
			end

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 then
				arg_172_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_175_2 = arg_172_1.actors_["10079ui_story"]

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 and not isNil(var_175_2) and arg_172_1.var_.characterEffect10079ui_story == nil then
				arg_172_1.var_.characterEffect10079ui_story = var_175_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_175_3 = 0.200000002980232

			if 0 <= arg_172_1.time_ and arg_172_1.time_ < 0 + var_175_3 and not isNil(var_175_2) then
				if arg_172_1.var_.characterEffect10079ui_story and not isNil(var_175_2) then
					arg_172_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_172_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_172_1.time_ - 0) / var_175_3)
				end
			end

			if arg_172_1.time_ >= 0 + var_175_3 and arg_172_1.time_ < 0 + var_175_3 + arg_175_0 and not isNil(var_175_2) and arg_172_1.var_.characterEffect10079ui_story then
				arg_172_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_172_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			local var_175_4 = 0
			local var_175_5 = 0.775

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= var_175_4 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, true)

				arg_172_1.leftNameTxt_.text = arg_172_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_172_1.leftNameTxt_.transform)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1.leftNameTxt_.text)
				SetActive(arg_172_1.iconTrs_.gameObject, false)
				arg_172_1.callingController_:SetSelectedState("normal")

				local var_175_6 = arg_172_1:GetWordFromCfg(319631042)
				local var_175_7 = arg_172_1:FormatText(var_175_6.content)

				arg_172_1.text_.text = var_175_7

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_9 = 31 <= 0 and var_175_5 or var_175_5 * (utf8.len(var_175_7) / 31)

				if (31 <= 0 and var_175_5 or var_175_5 * (utf8.len(var_175_7) / 31)) > 0 and var_175_5 < var_175_9 then
					arg_172_1.talkMaxDuration = var_175_9

					if var_175_9 + var_175_4 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_9 + var_175_4
					end
				end

				arg_172_1.text_.text = var_175_7
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319631", "319631042", "story_v_out_319631.awb") ~= 0 then
					local var_175_10 = manager.audio:GetVoiceLength("story_v_out_319631", "319631042", "story_v_out_319631.awb") / 1000

					if var_175_10 + var_175_4 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_10 + var_175_4
					end

					if var_175_6.prefab_name ~= "" and arg_172_1.actors_[var_175_6.prefab_name] ~= nil then
						local var_175_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_172_1.actors_[var_175_6.prefab_name].transform, "story_v_out_319631", "319631042", "story_v_out_319631.awb")

						arg_172_1:RecordAudio("319631042", var_175_11)
						arg_172_1:RecordAudio("319631042", var_175_11)
					else
						arg_172_1:AudioAction("play", "voice", "story_v_out_319631", "319631042", "story_v_out_319631.awb")
					end

					arg_172_1:RecordHistoryTalkVoice("story_v_out_319631", "319631042", "story_v_out_319631.awb")
				end

				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_12 = math.max(var_175_5, arg_172_1.talkMaxDuration)

			if var_175_4 <= arg_172_1.time_ and arg_172_1.time_ < var_175_4 + var_175_12 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - var_175_4) / var_175_12

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= var_175_4 + var_175_12 and arg_172_1.time_ < var_175_4 + var_175_12 + arg_175_0 then
				arg_172_1.typewritter.percent = 1

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(true)
			end
		end

		arg_172_1.nodeConfigList_ = {}

		arg_172_1:InitPlayNodeList()
	end,
	Play319631043 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 319631043
		arg_176_1.duration_ = 13.3

		local var_176_0 = {
			zh = 7.4,
			ja = 13.3
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
				arg_176_0:Play319631044(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			local var_179_0 = 0.85

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0
				arg_176_1.dialogCg_.alpha = 1

				arg_176_1.dialog_:SetActive(true)
				SetActive(arg_176_1.leftNameGo_, true)

				arg_176_1.leftNameTxt_.text = arg_176_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_176_1.leftNameTxt_.transform)

				arg_176_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_176_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_176_1:RecordName(arg_176_1.leftNameTxt_.text)
				SetActive(arg_176_1.iconTrs_.gameObject, false)
				arg_176_1.callingController_:SetSelectedState("normal")

				local var_179_1 = arg_176_1:GetWordFromCfg(319631043)
				local var_179_2 = arg_176_1:FormatText(var_179_1.content)

				arg_176_1.text_.text = var_179_2

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.text_)

				local var_179_4 = 34 <= 0 and var_179_0 or var_179_0 * (utf8.len(var_179_2) / 34)

				if (34 <= 0 and var_179_0 or var_179_0 * (utf8.len(var_179_2) / 34)) > 0 and var_179_0 < var_179_4 then
					arg_176_1.talkMaxDuration = var_179_4

					if var_179_4 + 0 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_4 + 0
					end
				end

				arg_176_1.text_.text = var_179_2
				arg_176_1.typewritter.percent = 0

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319631", "319631043", "story_v_out_319631.awb") ~= 0 then
					local var_179_5 = manager.audio:GetVoiceLength("story_v_out_319631", "319631043", "story_v_out_319631.awb") / 1000

					if var_179_5 + 0 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_5 + 0
					end

					if var_179_1.prefab_name ~= "" and arg_176_1.actors_[var_179_1.prefab_name] ~= nil then
						local var_179_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_176_1.actors_[var_179_1.prefab_name].transform, "story_v_out_319631", "319631043", "story_v_out_319631.awb")

						arg_176_1:RecordAudio("319631043", var_179_6)
						arg_176_1:RecordAudio("319631043", var_179_6)
					else
						arg_176_1:AudioAction("play", "voice", "story_v_out_319631", "319631043", "story_v_out_319631.awb")
					end

					arg_176_1:RecordHistoryTalkVoice("story_v_out_319631", "319631043", "story_v_out_319631.awb")
				end

				arg_176_1:RecordContent(arg_176_1.text_.text)
			end

			local var_179_7 = math.max(var_179_0, arg_176_1.talkMaxDuration)

			if 0 <= arg_176_1.time_ and arg_176_1.time_ < 0 + var_179_7 then
				arg_176_1.typewritter.percent = (arg_176_1.time_ - 0) / var_179_7

				arg_176_1.typewritter:SetDirty()
			end

			if arg_176_1.time_ >= 0 + var_179_7 and arg_176_1.time_ < 0 + var_179_7 + arg_179_0 then
				arg_176_1.typewritter.percent = 1

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(true)
			end
		end

		arg_176_1.nodeConfigList_ = {}

		arg_176_1:InitPlayNodeList()
	end,
	Play319631044 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 319631044
		arg_180_1.duration_ = 6.43

		local var_180_0 = {
			zh = 6.433,
			ja = 5.066
		}
		local var_180_1 = manager.audio:GetLocalizationFlag()

		if var_180_0[var_180_1] ~= nil then
			arg_180_1.duration_ = var_180_0[var_180_1]
		end

		SetActive(arg_180_1.tipsGo_, false)

		function arg_180_1.onSingleLineFinish_()
			arg_180_1.onSingleLineUpdate_ = nil
			arg_180_1.onSingleLineFinish_ = nil
			arg_180_1.state_ = "waiting"
		end

		function arg_180_1.playNext_(arg_182_0)
			if arg_182_0 == 1 then
				arg_180_0:Play319631045(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 then
				arg_180_1.var_.moveOldPos1095ui_story = arg_180_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_183_0 = 0.001

			if 0 <= arg_180_1.time_ and arg_180_1.time_ < 0 + var_183_0 then
				arg_180_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_180_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_180_1.time_ - 0) / var_183_0)
				arg_180_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_180_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_180_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_180_1.actors_["1095ui_story"].transform.position).z)
				arg_180_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_180_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_180_1.actors_["1095ui_story"].transform.localEulerAngles = arg_180_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_180_1.time_ >= 0 + var_183_0 and arg_180_1.time_ < 0 + var_183_0 + arg_183_0 then
				arg_180_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_180_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_180_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_180_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_180_1.actors_["1095ui_story"].transform.position).z)
				arg_180_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_180_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_180_1.actors_["1095ui_story"].transform.localEulerAngles = arg_180_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_183_1 = arg_180_1.actors_["1095ui_story"]

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 and not isNil(var_183_1) and arg_180_1.var_.characterEffect1095ui_story == nil then
				arg_180_1.var_.characterEffect1095ui_story = var_183_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_183_2 = 0.200000002980232

			if 0 <= arg_180_1.time_ and arg_180_1.time_ < 0 + var_183_2 and not isNil(var_183_1) then
				if arg_180_1.var_.characterEffect1095ui_story and not isNil(var_183_1) then
					arg_180_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_180_1.time_ >= 0 + var_183_2 and arg_180_1.time_ < 0 + var_183_2 + arg_183_0 and not isNil(var_183_1) and arg_180_1.var_.characterEffect1095ui_story then
				arg_180_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 then
				arg_180_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_2")
			end

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 then
				arg_180_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_183_4 = arg_180_1.actors_["4037ui_story"].transform

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 then
				arg_180_1.var_.moveOldPos4037ui_story = var_183_4.localPosition
			end

			local var_183_5 = 0.001

			if 0 <= arg_180_1.time_ and arg_180_1.time_ < 0 + var_183_5 then
				var_183_4.localPosition = Vector3.Lerp(arg_180_1.var_.moveOldPos4037ui_story, Vector3.New(0, 100, 0), (arg_180_1.time_ - 0) / var_183_5)
				var_183_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_183_4.position).x, (manager.ui.mainCamera.transform.position - var_183_4.position).y, (manager.ui.mainCamera.transform.position - var_183_4.position).z)
				var_183_4.localEulerAngles.z = 0
				var_183_4.localEulerAngles.x = 0
				var_183_4.localEulerAngles = var_183_4.localEulerAngles
			end

			if arg_180_1.time_ >= 0 + var_183_5 and arg_180_1.time_ < 0 + var_183_5 + arg_183_0 then
				var_183_4.localPosition = Vector3.New(0, 100, 0)
				var_183_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_183_4.position).x, (manager.ui.mainCamera.transform.position - var_183_4.position).y, (manager.ui.mainCamera.transform.position - var_183_4.position).z)
				var_183_4.localEulerAngles.z = 0
				var_183_4.localEulerAngles.x = 0
				var_183_4.localEulerAngles = var_183_4.localEulerAngles
			end

			local var_183_6 = arg_180_1.actors_["4037ui_story"]

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 and not isNil(var_183_6) and arg_180_1.var_.characterEffect4037ui_story == nil then
				arg_180_1.var_.characterEffect4037ui_story = var_183_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_183_7 = 0.200000002980232

			if 0 <= arg_180_1.time_ and arg_180_1.time_ < 0 + var_183_7 and not isNil(var_183_6) then
				if arg_180_1.var_.characterEffect4037ui_story and not isNil(var_183_6) then
					arg_180_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_180_1.var_.characterEffect4037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_180_1.time_ - 0) / var_183_7)
				end
			end

			if arg_180_1.time_ >= 0 + var_183_7 and arg_180_1.time_ < 0 + var_183_7 + arg_183_0 and not isNil(var_183_6) and arg_180_1.var_.characterEffect4037ui_story then
				arg_180_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_180_1.var_.characterEffect4037ui_story.fillRatio = 0.5
			end

			local var_183_8 = arg_180_1.actors_["10079ui_story"].transform

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 then
				arg_180_1.var_.moveOldPos10079ui_story = var_183_8.localPosition
			end

			local var_183_9 = 0.001

			if 0 <= arg_180_1.time_ and arg_180_1.time_ < 0 + var_183_9 then
				var_183_8.localPosition = Vector3.Lerp(arg_180_1.var_.moveOldPos10079ui_story, Vector3.New(0, 100, 0), (arg_180_1.time_ - 0) / var_183_9)
				var_183_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_183_8.position).x, (manager.ui.mainCamera.transform.position - var_183_8.position).y, (manager.ui.mainCamera.transform.position - var_183_8.position).z)
				var_183_8.localEulerAngles.z = 0
				var_183_8.localEulerAngles.x = 0
				var_183_8.localEulerAngles = var_183_8.localEulerAngles
			end

			if arg_180_1.time_ >= 0 + var_183_9 and arg_180_1.time_ < 0 + var_183_9 + arg_183_0 then
				var_183_8.localPosition = Vector3.New(0, 100, 0)
				var_183_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_183_8.position).x, (manager.ui.mainCamera.transform.position - var_183_8.position).y, (manager.ui.mainCamera.transform.position - var_183_8.position).z)
				var_183_8.localEulerAngles.z = 0
				var_183_8.localEulerAngles.x = 0
				var_183_8.localEulerAngles = var_183_8.localEulerAngles
			end

			local var_183_10 = 0
			local var_183_11 = 0.725

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= var_183_10 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0
				arg_180_1.dialogCg_.alpha = 1

				arg_180_1.dialog_:SetActive(true)
				SetActive(arg_180_1.leftNameGo_, true)

				arg_180_1.leftNameTxt_.text = arg_180_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_180_1.leftNameTxt_.transform)

				arg_180_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_180_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_180_1:RecordName(arg_180_1.leftNameTxt_.text)
				SetActive(arg_180_1.iconTrs_.gameObject, false)
				arg_180_1.callingController_:SetSelectedState("normal")

				local var_183_12 = arg_180_1:GetWordFromCfg(319631044)
				local var_183_13 = arg_180_1:FormatText(var_183_12.content)

				arg_180_1.text_.text = var_183_13

				LuaForUtil.ClearLinePrefixSymbol(arg_180_1.text_)

				local var_183_15 = 29 <= 0 and var_183_11 or var_183_11 * (utf8.len(var_183_13) / 29)

				if (29 <= 0 and var_183_11 or var_183_11 * (utf8.len(var_183_13) / 29)) > 0 and var_183_11 < var_183_15 then
					arg_180_1.talkMaxDuration = var_183_15

					if var_183_15 + var_183_10 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_15 + var_183_10
					end
				end

				arg_180_1.text_.text = var_183_13
				arg_180_1.typewritter.percent = 0

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319631", "319631044", "story_v_out_319631.awb") ~= 0 then
					local var_183_16 = manager.audio:GetVoiceLength("story_v_out_319631", "319631044", "story_v_out_319631.awb") / 1000

					if var_183_16 + var_183_10 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_16 + var_183_10
					end

					if var_183_12.prefab_name ~= "" and arg_180_1.actors_[var_183_12.prefab_name] ~= nil then
						local var_183_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_180_1.actors_[var_183_12.prefab_name].transform, "story_v_out_319631", "319631044", "story_v_out_319631.awb")

						arg_180_1:RecordAudio("319631044", var_183_17)
						arg_180_1:RecordAudio("319631044", var_183_17)
					else
						arg_180_1:AudioAction("play", "voice", "story_v_out_319631", "319631044", "story_v_out_319631.awb")
					end

					arg_180_1:RecordHistoryTalkVoice("story_v_out_319631", "319631044", "story_v_out_319631.awb")
				end

				arg_180_1:RecordContent(arg_180_1.text_.text)
			end

			local var_183_18 = math.max(var_183_11, arg_180_1.talkMaxDuration)

			if var_183_10 <= arg_180_1.time_ and arg_180_1.time_ < var_183_10 + var_183_18 then
				arg_180_1.typewritter.percent = (arg_180_1.time_ - var_183_10) / var_183_18

				arg_180_1.typewritter:SetDirty()
			end

			if arg_180_1.time_ >= var_183_10 + var_183_18 and arg_180_1.time_ < var_183_10 + var_183_18 + arg_183_0 then
				arg_180_1.typewritter.percent = 1

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(true)
			end
		end

		arg_180_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
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
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_180_1:InitPlayNodeList()
	end,
	Play319631045 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 319631045
		arg_184_1.duration_ = 9.4

		local var_184_0 = {
			zh = 9.4,
			ja = 8.9
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
				arg_184_0:Play319631046(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 then
				arg_184_1.var_.moveOldPos4037ui_story = arg_184_1.actors_["4037ui_story"].transform.localPosition
			end

			local var_187_0 = 0.001

			if 0 <= arg_184_1.time_ and arg_184_1.time_ < 0 + var_187_0 then
				arg_184_1.actors_["4037ui_story"].transform.localPosition = Vector3.Lerp(arg_184_1.var_.moveOldPos4037ui_story, Vector3.New(0, -1.12, -6.2), (arg_184_1.time_ - 0) / var_187_0)
				arg_184_1.actors_["4037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_184_1.actors_["4037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_184_1.actors_["4037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_184_1.actors_["4037ui_story"].transform.position).z)
				arg_184_1.actors_["4037ui_story"].transform.localEulerAngles.z = 0
				arg_184_1.actors_["4037ui_story"].transform.localEulerAngles.x = 0
				arg_184_1.actors_["4037ui_story"].transform.localEulerAngles = arg_184_1.actors_["4037ui_story"].transform.localEulerAngles
			end

			if arg_184_1.time_ >= 0 + var_187_0 and arg_184_1.time_ < 0 + var_187_0 + arg_187_0 then
				arg_184_1.actors_["4037ui_story"].transform.localPosition = Vector3.New(0, -1.12, -6.2)
				arg_184_1.actors_["4037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_184_1.actors_["4037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_184_1.actors_["4037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_184_1.actors_["4037ui_story"].transform.position).z)
				arg_184_1.actors_["4037ui_story"].transform.localEulerAngles.z = 0
				arg_184_1.actors_["4037ui_story"].transform.localEulerAngles.x = 0
				arg_184_1.actors_["4037ui_story"].transform.localEulerAngles = arg_184_1.actors_["4037ui_story"].transform.localEulerAngles
			end

			local var_187_1 = arg_184_1.actors_["4037ui_story"]

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 and not isNil(var_187_1) and arg_184_1.var_.characterEffect4037ui_story == nil then
				arg_184_1.var_.characterEffect4037ui_story = var_187_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_187_2 = 0.200000002980232

			if 0 <= arg_184_1.time_ and arg_184_1.time_ < 0 + var_187_2 and not isNil(var_187_1) then
				if arg_184_1.var_.characterEffect4037ui_story and not isNil(var_187_1) then
					arg_184_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_184_1.time_ >= 0 + var_187_2 and arg_184_1.time_ < 0 + var_187_2 + arg_187_0 and not isNil(var_187_1) and arg_184_1.var_.characterEffect4037ui_story then
				arg_184_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 then
				arg_184_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action2_1")
			end

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 then
				arg_184_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_187_4 = arg_184_1.actors_["1095ui_story"].transform

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 then
				arg_184_1.var_.moveOldPos1095ui_story = var_187_4.localPosition
			end

			local var_187_5 = 0.001

			if 0 <= arg_184_1.time_ and arg_184_1.time_ < 0 + var_187_5 then
				var_187_4.localPosition = Vector3.Lerp(arg_184_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_184_1.time_ - 0) / var_187_5)
				var_187_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_187_4.position).x, (manager.ui.mainCamera.transform.position - var_187_4.position).y, (manager.ui.mainCamera.transform.position - var_187_4.position).z)
				var_187_4.localEulerAngles.z = 0
				var_187_4.localEulerAngles.x = 0
				var_187_4.localEulerAngles = var_187_4.localEulerAngles
			end

			if arg_184_1.time_ >= 0 + var_187_5 and arg_184_1.time_ < 0 + var_187_5 + arg_187_0 then
				var_187_4.localPosition = Vector3.New(0, 100, 0)
				var_187_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_187_4.position).x, (manager.ui.mainCamera.transform.position - var_187_4.position).y, (manager.ui.mainCamera.transform.position - var_187_4.position).z)
				var_187_4.localEulerAngles.z = 0
				var_187_4.localEulerAngles.x = 0
				var_187_4.localEulerAngles = var_187_4.localEulerAngles
			end

			local var_187_6 = arg_184_1.actors_["1095ui_story"]

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 and not isNil(var_187_6) and arg_184_1.var_.characterEffect1095ui_story == nil then
				arg_184_1.var_.characterEffect1095ui_story = var_187_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_187_7 = 0.200000002980232

			if 0 <= arg_184_1.time_ and arg_184_1.time_ < 0 + var_187_7 and not isNil(var_187_6) then
				if arg_184_1.var_.characterEffect1095ui_story and not isNil(var_187_6) then
					arg_184_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_184_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_184_1.time_ - 0) / var_187_7)
				end
			end

			if arg_184_1.time_ >= 0 + var_187_7 and arg_184_1.time_ < 0 + var_187_7 + arg_187_0 and not isNil(var_187_6) and arg_184_1.var_.characterEffect1095ui_story then
				arg_184_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_184_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_187_8 = 0
			local var_187_9 = 1

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= var_187_8 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0
				arg_184_1.dialogCg_.alpha = 1

				arg_184_1.dialog_:SetActive(true)
				SetActive(arg_184_1.leftNameGo_, true)

				arg_184_1.leftNameTxt_.text = arg_184_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_184_1.leftNameTxt_.transform)

				arg_184_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_184_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_184_1:RecordName(arg_184_1.leftNameTxt_.text)
				SetActive(arg_184_1.iconTrs_.gameObject, false)
				arg_184_1.callingController_:SetSelectedState("normal")

				local var_187_10 = arg_184_1:GetWordFromCfg(319631045)
				local var_187_11 = arg_184_1:FormatText(var_187_10.content)

				arg_184_1.text_.text = var_187_11

				LuaForUtil.ClearLinePrefixSymbol(arg_184_1.text_)

				local var_187_13 = 40 <= 0 and var_187_9 or var_187_9 * (utf8.len(var_187_11) / 40)

				if (40 <= 0 and var_187_9 or var_187_9 * (utf8.len(var_187_11) / 40)) > 0 and var_187_9 < var_187_13 then
					arg_184_1.talkMaxDuration = var_187_13

					if var_187_13 + var_187_8 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_13 + var_187_8
					end
				end

				arg_184_1.text_.text = var_187_11
				arg_184_1.typewritter.percent = 0

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319631", "319631045", "story_v_out_319631.awb") ~= 0 then
					local var_187_14 = manager.audio:GetVoiceLength("story_v_out_319631", "319631045", "story_v_out_319631.awb") / 1000

					if var_187_14 + var_187_8 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_14 + var_187_8
					end

					if var_187_10.prefab_name ~= "" and arg_184_1.actors_[var_187_10.prefab_name] ~= nil then
						local var_187_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_184_1.actors_[var_187_10.prefab_name].transform, "story_v_out_319631", "319631045", "story_v_out_319631.awb")

						arg_184_1:RecordAudio("319631045", var_187_15)
						arg_184_1:RecordAudio("319631045", var_187_15)
					else
						arg_184_1:AudioAction("play", "voice", "story_v_out_319631", "319631045", "story_v_out_319631.awb")
					end

					arg_184_1:RecordHistoryTalkVoice("story_v_out_319631", "319631045", "story_v_out_319631.awb")
				end

				arg_184_1:RecordContent(arg_184_1.text_.text)
			end

			local var_187_16 = math.max(var_187_9, arg_184_1.talkMaxDuration)

			if var_187_8 <= arg_184_1.time_ and arg_184_1.time_ < var_187_8 + var_187_16 then
				arg_184_1.typewritter.percent = (arg_184_1.time_ - var_187_8) / var_187_16

				arg_184_1.typewritter:SetDirty()
			end

			if arg_184_1.time_ >= var_187_8 + var_187_16 and arg_184_1.time_ < var_187_8 + var_187_16 + arg_187_0 then
				arg_184_1.typewritter.percent = 1

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(true)
			end
		end

		arg_184_1.nodeConfigList_ = {
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
				actorName = "1095ui_story",
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
	Play319631046 = function(arg_188_0, arg_188_1)
		arg_188_1.time_ = 0
		arg_188_1.frameCnt_ = 0
		arg_188_1.state_ = "playing"
		arg_188_1.curTalkId_ = 319631046
		arg_188_1.duration_ = 10.4

		local var_188_0 = {
			zh = 10.4,
			ja = 10.066
		}
		local var_188_1 = manager.audio:GetLocalizationFlag()

		if var_188_0[var_188_1] ~= nil then
			arg_188_1.duration_ = var_188_0[var_188_1]
		end

		SetActive(arg_188_1.tipsGo_, false)

		function arg_188_1.onSingleLineFinish_()
			arg_188_1.onSingleLineUpdate_ = nil
			arg_188_1.onSingleLineFinish_ = nil
			arg_188_1.state_ = "waiting"
		end

		function arg_188_1.playNext_(arg_190_0)
			if arg_190_0 == 1 then
				arg_188_0:Play319631047(arg_188_1)
			end
		end

		function arg_188_1.onSingleLineUpdate_(arg_191_0)
			local var_191_0 = 1.1

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 then
				arg_188_1.talkMaxDuration = 0
				arg_188_1.dialogCg_.alpha = 1

				arg_188_1.dialog_:SetActive(true)
				SetActive(arg_188_1.leftNameGo_, true)

				arg_188_1.leftNameTxt_.text = arg_188_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_188_1.leftNameTxt_.transform)

				arg_188_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_188_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_188_1:RecordName(arg_188_1.leftNameTxt_.text)
				SetActive(arg_188_1.iconTrs_.gameObject, false)
				arg_188_1.callingController_:SetSelectedState("normal")

				local var_191_1 = arg_188_1:GetWordFromCfg(319631046)
				local var_191_2 = arg_188_1:FormatText(var_191_1.content)

				arg_188_1.text_.text = var_191_2

				LuaForUtil.ClearLinePrefixSymbol(arg_188_1.text_)

				local var_191_4 = 44 <= 0 and var_191_0 or var_191_0 * (utf8.len(var_191_2) / 44)

				if (44 <= 0 and var_191_0 or var_191_0 * (utf8.len(var_191_2) / 44)) > 0 and var_191_0 < var_191_4 then
					arg_188_1.talkMaxDuration = var_191_4

					if var_191_4 + 0 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_4 + 0
					end
				end

				arg_188_1.text_.text = var_191_2
				arg_188_1.typewritter.percent = 0

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319631", "319631046", "story_v_out_319631.awb") ~= 0 then
					local var_191_5 = manager.audio:GetVoiceLength("story_v_out_319631", "319631046", "story_v_out_319631.awb") / 1000

					if var_191_5 + 0 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_5 + 0
					end

					if var_191_1.prefab_name ~= "" and arg_188_1.actors_[var_191_1.prefab_name] ~= nil then
						local var_191_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_188_1.actors_[var_191_1.prefab_name].transform, "story_v_out_319631", "319631046", "story_v_out_319631.awb")

						arg_188_1:RecordAudio("319631046", var_191_6)
						arg_188_1:RecordAudio("319631046", var_191_6)
					else
						arg_188_1:AudioAction("play", "voice", "story_v_out_319631", "319631046", "story_v_out_319631.awb")
					end

					arg_188_1:RecordHistoryTalkVoice("story_v_out_319631", "319631046", "story_v_out_319631.awb")
				end

				arg_188_1:RecordContent(arg_188_1.text_.text)
			end

			local var_191_7 = math.max(var_191_0, arg_188_1.talkMaxDuration)

			if 0 <= arg_188_1.time_ and arg_188_1.time_ < 0 + var_191_7 then
				arg_188_1.typewritter.percent = (arg_188_1.time_ - 0) / var_191_7

				arg_188_1.typewritter:SetDirty()
			end

			if arg_188_1.time_ >= 0 + var_191_7 and arg_188_1.time_ < 0 + var_191_7 + arg_191_0 then
				arg_188_1.typewritter.percent = 1

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(true)
			end
		end

		arg_188_1.nodeConfigList_ = {}

		arg_188_1:InitPlayNodeList()
	end,
	Play319631047 = function(arg_192_0, arg_192_1)
		arg_192_1.time_ = 0
		arg_192_1.frameCnt_ = 0
		arg_192_1.state_ = "playing"
		arg_192_1.curTalkId_ = 319631047
		arg_192_1.duration_ = 8

		local var_192_0 = {
			zh = 8,
			ja = 6.8
		}
		local var_192_1 = manager.audio:GetLocalizationFlag()

		if var_192_0[var_192_1] ~= nil then
			arg_192_1.duration_ = var_192_0[var_192_1]
		end

		SetActive(arg_192_1.tipsGo_, false)

		function arg_192_1.onSingleLineFinish_()
			arg_192_1.onSingleLineUpdate_ = nil
			arg_192_1.onSingleLineFinish_ = nil
			arg_192_1.state_ = "waiting"
		end

		function arg_192_1.playNext_(arg_194_0)
			if arg_194_0 == 1 then
				arg_192_0:Play319631048(arg_192_1)
			end
		end

		function arg_192_1.onSingleLineUpdate_(arg_195_0)
			local var_195_0 = 0.95

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= 0 + arg_195_0 then
				arg_192_1.talkMaxDuration = 0
				arg_192_1.dialogCg_.alpha = 1

				arg_192_1.dialog_:SetActive(true)
				SetActive(arg_192_1.leftNameGo_, true)

				arg_192_1.leftNameTxt_.text = arg_192_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_192_1.leftNameTxt_.transform)

				arg_192_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_192_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_192_1:RecordName(arg_192_1.leftNameTxt_.text)
				SetActive(arg_192_1.iconTrs_.gameObject, false)
				arg_192_1.callingController_:SetSelectedState("normal")

				local var_195_1 = arg_192_1:GetWordFromCfg(319631047)
				local var_195_2 = arg_192_1:FormatText(var_195_1.content)

				arg_192_1.text_.text = var_195_2

				LuaForUtil.ClearLinePrefixSymbol(arg_192_1.text_)

				local var_195_4 = 38 <= 0 and var_195_0 or var_195_0 * (utf8.len(var_195_2) / 38)

				if (38 <= 0 and var_195_0 or var_195_0 * (utf8.len(var_195_2) / 38)) > 0 and var_195_0 < var_195_4 then
					arg_192_1.talkMaxDuration = var_195_4

					if var_195_4 + 0 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_4 + 0
					end
				end

				arg_192_1.text_.text = var_195_2
				arg_192_1.typewritter.percent = 0

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319631", "319631047", "story_v_out_319631.awb") ~= 0 then
					local var_195_5 = manager.audio:GetVoiceLength("story_v_out_319631", "319631047", "story_v_out_319631.awb") / 1000

					if var_195_5 + 0 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_5 + 0
					end

					if var_195_1.prefab_name ~= "" and arg_192_1.actors_[var_195_1.prefab_name] ~= nil then
						local var_195_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_192_1.actors_[var_195_1.prefab_name].transform, "story_v_out_319631", "319631047", "story_v_out_319631.awb")

						arg_192_1:RecordAudio("319631047", var_195_6)
						arg_192_1:RecordAudio("319631047", var_195_6)
					else
						arg_192_1:AudioAction("play", "voice", "story_v_out_319631", "319631047", "story_v_out_319631.awb")
					end

					arg_192_1:RecordHistoryTalkVoice("story_v_out_319631", "319631047", "story_v_out_319631.awb")
				end

				arg_192_1:RecordContent(arg_192_1.text_.text)
			end

			local var_195_7 = math.max(var_195_0, arg_192_1.talkMaxDuration)

			if 0 <= arg_192_1.time_ and arg_192_1.time_ < 0 + var_195_7 then
				arg_192_1.typewritter.percent = (arg_192_1.time_ - 0) / var_195_7

				arg_192_1.typewritter:SetDirty()
			end

			if arg_192_1.time_ >= 0 + var_195_7 and arg_192_1.time_ < 0 + var_195_7 + arg_195_0 then
				arg_192_1.typewritter.percent = 1

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(true)
			end
		end

		arg_192_1.nodeConfigList_ = {}

		arg_192_1:InitPlayNodeList()
	end,
	Play319631048 = function(arg_196_0, arg_196_1)
		arg_196_1.time_ = 0
		arg_196_1.frameCnt_ = 0
		arg_196_1.state_ = "playing"
		arg_196_1.curTalkId_ = 319631048
		arg_196_1.duration_ = 4.87

		local var_196_0 = {
			zh = 1.999999999999,
			ja = 4.866
		}
		local var_196_1 = manager.audio:GetLocalizationFlag()

		if var_196_0[var_196_1] ~= nil then
			arg_196_1.duration_ = var_196_0[var_196_1]
		end

		SetActive(arg_196_1.tipsGo_, false)

		function arg_196_1.onSingleLineFinish_()
			arg_196_1.onSingleLineUpdate_ = nil
			arg_196_1.onSingleLineFinish_ = nil
			arg_196_1.state_ = "waiting"
		end

		function arg_196_1.playNext_(arg_198_0)
			if arg_198_0 == 1 then
				arg_196_0:Play319631049(arg_196_1)
			end
		end

		function arg_196_1.onSingleLineUpdate_(arg_199_0)
			if 0 < arg_196_1.time_ and arg_196_1.time_ <= 0 + arg_199_0 then
				arg_196_1.var_.moveOldPos1095ui_story = arg_196_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_199_0 = 0.001

			if 0 <= arg_196_1.time_ and arg_196_1.time_ < 0 + var_199_0 then
				arg_196_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_196_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_196_1.time_ - 0) / var_199_0)
				arg_196_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_196_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_196_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_196_1.actors_["1095ui_story"].transform.position).z)
				arg_196_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_196_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_196_1.actors_["1095ui_story"].transform.localEulerAngles = arg_196_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_196_1.time_ >= 0 + var_199_0 and arg_196_1.time_ < 0 + var_199_0 + arg_199_0 then
				arg_196_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_196_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_196_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_196_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_196_1.actors_["1095ui_story"].transform.position).z)
				arg_196_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_196_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_196_1.actors_["1095ui_story"].transform.localEulerAngles = arg_196_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_199_1 = arg_196_1.actors_["1095ui_story"]

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= 0 + arg_199_0 and not isNil(var_199_1) and arg_196_1.var_.characterEffect1095ui_story == nil then
				arg_196_1.var_.characterEffect1095ui_story = var_199_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_199_2 = 0.200000002980232

			if 0 <= arg_196_1.time_ and arg_196_1.time_ < 0 + var_199_2 and not isNil(var_199_1) then
				if arg_196_1.var_.characterEffect1095ui_story and not isNil(var_199_1) then
					arg_196_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_196_1.time_ >= 0 + var_199_2 and arg_196_1.time_ < 0 + var_199_2 + arg_199_0 and not isNil(var_199_1) and arg_196_1.var_.characterEffect1095ui_story then
				arg_196_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= 0 + arg_199_0 then
				arg_196_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_199_4 = arg_196_1.actors_["4037ui_story"].transform

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= 0 + arg_199_0 then
				arg_196_1.var_.moveOldPos4037ui_story = var_199_4.localPosition
			end

			local var_199_5 = 0.001

			if 0 <= arg_196_1.time_ and arg_196_1.time_ < 0 + var_199_5 then
				var_199_4.localPosition = Vector3.Lerp(arg_196_1.var_.moveOldPos4037ui_story, Vector3.New(0, 100, 0), (arg_196_1.time_ - 0) / var_199_5)
				var_199_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_199_4.position).x, (manager.ui.mainCamera.transform.position - var_199_4.position).y, (manager.ui.mainCamera.transform.position - var_199_4.position).z)
				var_199_4.localEulerAngles.z = 0
				var_199_4.localEulerAngles.x = 0
				var_199_4.localEulerAngles = var_199_4.localEulerAngles
			end

			if arg_196_1.time_ >= 0 + var_199_5 and arg_196_1.time_ < 0 + var_199_5 + arg_199_0 then
				var_199_4.localPosition = Vector3.New(0, 100, 0)
				var_199_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_199_4.position).x, (manager.ui.mainCamera.transform.position - var_199_4.position).y, (manager.ui.mainCamera.transform.position - var_199_4.position).z)
				var_199_4.localEulerAngles.z = 0
				var_199_4.localEulerAngles.x = 0
				var_199_4.localEulerAngles = var_199_4.localEulerAngles
			end

			local var_199_6 = arg_196_1.actors_["4037ui_story"]

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= 0 + arg_199_0 and not isNil(var_199_6) and arg_196_1.var_.characterEffect4037ui_story == nil then
				arg_196_1.var_.characterEffect4037ui_story = var_199_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_199_7 = 0.200000002980232

			if 0 <= arg_196_1.time_ and arg_196_1.time_ < 0 + var_199_7 and not isNil(var_199_6) then
				if arg_196_1.var_.characterEffect4037ui_story and not isNil(var_199_6) then
					arg_196_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_196_1.var_.characterEffect4037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_196_1.time_ - 0) / var_199_7)
				end
			end

			if arg_196_1.time_ >= 0 + var_199_7 and arg_196_1.time_ < 0 + var_199_7 + arg_199_0 and not isNil(var_199_6) and arg_196_1.var_.characterEffect4037ui_story then
				arg_196_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_196_1.var_.characterEffect4037ui_story.fillRatio = 0.5
			end

			local var_199_8 = 0
			local var_199_9 = 0.25

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= var_199_8 + arg_199_0 then
				arg_196_1.talkMaxDuration = 0
				arg_196_1.dialogCg_.alpha = 1

				arg_196_1.dialog_:SetActive(true)
				SetActive(arg_196_1.leftNameGo_, true)

				arg_196_1.leftNameTxt_.text = arg_196_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_196_1.leftNameTxt_.transform)

				arg_196_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_196_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_196_1:RecordName(arg_196_1.leftNameTxt_.text)
				SetActive(arg_196_1.iconTrs_.gameObject, false)
				arg_196_1.callingController_:SetSelectedState("normal")

				local var_199_10 = arg_196_1:GetWordFromCfg(319631048)
				local var_199_11 = arg_196_1:FormatText(var_199_10.content)

				arg_196_1.text_.text = var_199_11

				LuaForUtil.ClearLinePrefixSymbol(arg_196_1.text_)

				local var_199_13 = 10 <= 0 and var_199_9 or var_199_9 * (utf8.len(var_199_11) / 10)

				if (10 <= 0 and var_199_9 or var_199_9 * (utf8.len(var_199_11) / 10)) > 0 and var_199_9 < var_199_13 then
					arg_196_1.talkMaxDuration = var_199_13

					if var_199_13 + var_199_8 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_13 + var_199_8
					end
				end

				arg_196_1.text_.text = var_199_11
				arg_196_1.typewritter.percent = 0

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319631", "319631048", "story_v_out_319631.awb") ~= 0 then
					local var_199_14 = manager.audio:GetVoiceLength("story_v_out_319631", "319631048", "story_v_out_319631.awb") / 1000

					if var_199_14 + var_199_8 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_14 + var_199_8
					end

					if var_199_10.prefab_name ~= "" and arg_196_1.actors_[var_199_10.prefab_name] ~= nil then
						local var_199_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_196_1.actors_[var_199_10.prefab_name].transform, "story_v_out_319631", "319631048", "story_v_out_319631.awb")

						arg_196_1:RecordAudio("319631048", var_199_15)
						arg_196_1:RecordAudio("319631048", var_199_15)
					else
						arg_196_1:AudioAction("play", "voice", "story_v_out_319631", "319631048", "story_v_out_319631.awb")
					end

					arg_196_1:RecordHistoryTalkVoice("story_v_out_319631", "319631048", "story_v_out_319631.awb")
				end

				arg_196_1:RecordContent(arg_196_1.text_.text)
			end

			local var_199_16 = math.max(var_199_9, arg_196_1.talkMaxDuration)

			if var_199_8 <= arg_196_1.time_ and arg_196_1.time_ < var_199_8 + var_199_16 then
				arg_196_1.typewritter.percent = (arg_196_1.time_ - var_199_8) / var_199_16

				arg_196_1.typewritter:SetDirty()
			end

			if arg_196_1.time_ >= var_199_8 + var_199_16 and arg_196_1.time_ < var_199_8 + var_199_16 + arg_199_0 then
				arg_196_1.typewritter.percent = 1

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(true)
			end
		end

		arg_196_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
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
			}
		}

		arg_196_1:InitPlayNodeList()
	end,
	Play319631049 = function(arg_200_0, arg_200_1)
		arg_200_1.time_ = 0
		arg_200_1.frameCnt_ = 0
		arg_200_1.state_ = "playing"
		arg_200_1.curTalkId_ = 319631049
		arg_200_1.duration_ = 7.63

		local var_200_0 = {
			zh = 7.633,
			ja = 7.166
		}
		local var_200_1 = manager.audio:GetLocalizationFlag()

		if var_200_0[var_200_1] ~= nil then
			arg_200_1.duration_ = var_200_0[var_200_1]
		end

		SetActive(arg_200_1.tipsGo_, false)

		function arg_200_1.onSingleLineFinish_()
			arg_200_1.onSingleLineUpdate_ = nil
			arg_200_1.onSingleLineFinish_ = nil
			arg_200_1.state_ = "waiting"
		end

		function arg_200_1.playNext_(arg_202_0)
			if arg_202_0 == 1 then
				arg_200_0:Play319631050(arg_200_1)
			end
		end

		function arg_200_1.onSingleLineUpdate_(arg_203_0)
			if 0 < arg_200_1.time_ and arg_200_1.time_ <= 0 + arg_203_0 then
				arg_200_1.var_.moveOldPos4037ui_story = arg_200_1.actors_["4037ui_story"].transform.localPosition
			end

			local var_203_0 = 0.001

			if 0 <= arg_200_1.time_ and arg_200_1.time_ < 0 + var_203_0 then
				arg_200_1.actors_["4037ui_story"].transform.localPosition = Vector3.Lerp(arg_200_1.var_.moveOldPos4037ui_story, Vector3.New(0, -1.12, -6.2), (arg_200_1.time_ - 0) / var_203_0)
				arg_200_1.actors_["4037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_200_1.actors_["4037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_200_1.actors_["4037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_200_1.actors_["4037ui_story"].transform.position).z)
				arg_200_1.actors_["4037ui_story"].transform.localEulerAngles.z = 0
				arg_200_1.actors_["4037ui_story"].transform.localEulerAngles.x = 0
				arg_200_1.actors_["4037ui_story"].transform.localEulerAngles = arg_200_1.actors_["4037ui_story"].transform.localEulerAngles
			end

			if arg_200_1.time_ >= 0 + var_203_0 and arg_200_1.time_ < 0 + var_203_0 + arg_203_0 then
				arg_200_1.actors_["4037ui_story"].transform.localPosition = Vector3.New(0, -1.12, -6.2)
				arg_200_1.actors_["4037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_200_1.actors_["4037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_200_1.actors_["4037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_200_1.actors_["4037ui_story"].transform.position).z)
				arg_200_1.actors_["4037ui_story"].transform.localEulerAngles.z = 0
				arg_200_1.actors_["4037ui_story"].transform.localEulerAngles.x = 0
				arg_200_1.actors_["4037ui_story"].transform.localEulerAngles = arg_200_1.actors_["4037ui_story"].transform.localEulerAngles
			end

			local var_203_1 = arg_200_1.actors_["4037ui_story"]

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= 0 + arg_203_0 and not isNil(var_203_1) and arg_200_1.var_.characterEffect4037ui_story == nil then
				arg_200_1.var_.characterEffect4037ui_story = var_203_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_203_2 = 0.200000002980232

			if 0 <= arg_200_1.time_ and arg_200_1.time_ < 0 + var_203_2 and not isNil(var_203_1) then
				if arg_200_1.var_.characterEffect4037ui_story and not isNil(var_203_1) then
					arg_200_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_200_1.time_ >= 0 + var_203_2 and arg_200_1.time_ < 0 + var_203_2 + arg_203_0 and not isNil(var_203_1) and arg_200_1.var_.characterEffect4037ui_story then
				arg_200_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= 0 + arg_203_0 then
				arg_200_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action2_2")
			end

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= 0 + arg_203_0 then
				arg_200_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_203_4 = arg_200_1.actors_["1095ui_story"].transform

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= 0 + arg_203_0 then
				arg_200_1.var_.moveOldPos1095ui_story = var_203_4.localPosition
			end

			local var_203_5 = 0.001

			if 0 <= arg_200_1.time_ and arg_200_1.time_ < 0 + var_203_5 then
				var_203_4.localPosition = Vector3.Lerp(arg_200_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_200_1.time_ - 0) / var_203_5)
				var_203_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_203_4.position).x, (manager.ui.mainCamera.transform.position - var_203_4.position).y, (manager.ui.mainCamera.transform.position - var_203_4.position).z)
				var_203_4.localEulerAngles.z = 0
				var_203_4.localEulerAngles.x = 0
				var_203_4.localEulerAngles = var_203_4.localEulerAngles
			end

			if arg_200_1.time_ >= 0 + var_203_5 and arg_200_1.time_ < 0 + var_203_5 + arg_203_0 then
				var_203_4.localPosition = Vector3.New(0, 100, 0)
				var_203_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_203_4.position).x, (manager.ui.mainCamera.transform.position - var_203_4.position).y, (manager.ui.mainCamera.transform.position - var_203_4.position).z)
				var_203_4.localEulerAngles.z = 0
				var_203_4.localEulerAngles.x = 0
				var_203_4.localEulerAngles = var_203_4.localEulerAngles
			end

			local var_203_6 = arg_200_1.actors_["1095ui_story"]

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= 0 + arg_203_0 and not isNil(var_203_6) and arg_200_1.var_.characterEffect1095ui_story == nil then
				arg_200_1.var_.characterEffect1095ui_story = var_203_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_203_7 = 0.200000002980232

			if 0 <= arg_200_1.time_ and arg_200_1.time_ < 0 + var_203_7 and not isNil(var_203_6) then
				if arg_200_1.var_.characterEffect1095ui_story and not isNil(var_203_6) then
					arg_200_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_200_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_200_1.time_ - 0) / var_203_7)
				end
			end

			if arg_200_1.time_ >= 0 + var_203_7 and arg_200_1.time_ < 0 + var_203_7 + arg_203_0 and not isNil(var_203_6) and arg_200_1.var_.characterEffect1095ui_story then
				arg_200_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_200_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_203_8 = 0
			local var_203_9 = 0.9

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= var_203_8 + arg_203_0 then
				arg_200_1.talkMaxDuration = 0
				arg_200_1.dialogCg_.alpha = 1

				arg_200_1.dialog_:SetActive(true)
				SetActive(arg_200_1.leftNameGo_, true)

				arg_200_1.leftNameTxt_.text = arg_200_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_200_1.leftNameTxt_.transform)

				arg_200_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_200_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_200_1:RecordName(arg_200_1.leftNameTxt_.text)
				SetActive(arg_200_1.iconTrs_.gameObject, false)
				arg_200_1.callingController_:SetSelectedState("normal")

				local var_203_10 = arg_200_1:GetWordFromCfg(319631049)
				local var_203_11 = arg_200_1:FormatText(var_203_10.content)

				arg_200_1.text_.text = var_203_11

				LuaForUtil.ClearLinePrefixSymbol(arg_200_1.text_)

				local var_203_13 = 36 <= 0 and var_203_9 or var_203_9 * (utf8.len(var_203_11) / 36)

				if (36 <= 0 and var_203_9 or var_203_9 * (utf8.len(var_203_11) / 36)) > 0 and var_203_9 < var_203_13 then
					arg_200_1.talkMaxDuration = var_203_13

					if var_203_13 + var_203_8 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_13 + var_203_8
					end
				end

				arg_200_1.text_.text = var_203_11
				arg_200_1.typewritter.percent = 0

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319631", "319631049", "story_v_out_319631.awb") ~= 0 then
					local var_203_14 = manager.audio:GetVoiceLength("story_v_out_319631", "319631049", "story_v_out_319631.awb") / 1000

					if var_203_14 + var_203_8 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_14 + var_203_8
					end

					if var_203_10.prefab_name ~= "" and arg_200_1.actors_[var_203_10.prefab_name] ~= nil then
						local var_203_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_200_1.actors_[var_203_10.prefab_name].transform, "story_v_out_319631", "319631049", "story_v_out_319631.awb")

						arg_200_1:RecordAudio("319631049", var_203_15)
						arg_200_1:RecordAudio("319631049", var_203_15)
					else
						arg_200_1:AudioAction("play", "voice", "story_v_out_319631", "319631049", "story_v_out_319631.awb")
					end

					arg_200_1:RecordHistoryTalkVoice("story_v_out_319631", "319631049", "story_v_out_319631.awb")
				end

				arg_200_1:RecordContent(arg_200_1.text_.text)
			end

			local var_203_16 = math.max(var_203_9, arg_200_1.talkMaxDuration)

			if var_203_8 <= arg_200_1.time_ and arg_200_1.time_ < var_203_8 + var_203_16 then
				arg_200_1.typewritter.percent = (arg_200_1.time_ - var_203_8) / var_203_16

				arg_200_1.typewritter:SetDirty()
			end

			if arg_200_1.time_ >= var_203_8 + var_203_16 and arg_200_1.time_ < var_203_8 + var_203_16 + arg_203_0 then
				arg_200_1.typewritter.percent = 1

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(true)
			end
		end

		arg_200_1.nodeConfigList_ = {
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
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_200_1:InitPlayNodeList()
	end,
	Play319631050 = function(arg_204_0, arg_204_1)
		arg_204_1.time_ = 0
		arg_204_1.frameCnt_ = 0
		arg_204_1.state_ = "playing"
		arg_204_1.curTalkId_ = 319631050
		arg_204_1.duration_ = 7.4

		local var_204_0 = {
			zh = 7.4,
			ja = 3.933
		}
		local var_204_1 = manager.audio:GetLocalizationFlag()

		if var_204_0[var_204_1] ~= nil then
			arg_204_1.duration_ = var_204_0[var_204_1]
		end

		SetActive(arg_204_1.tipsGo_, false)

		function arg_204_1.onSingleLineFinish_()
			arg_204_1.onSingleLineUpdate_ = nil
			arg_204_1.onSingleLineFinish_ = nil
			arg_204_1.state_ = "waiting"
		end

		function arg_204_1.playNext_(arg_206_0)
			if arg_206_0 == 1 then
				arg_204_0:Play319631051(arg_204_1)
			end
		end

		function arg_204_1.onSingleLineUpdate_(arg_207_0)
			local var_207_0 = 0.525

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= 0 + arg_207_0 then
				arg_204_1.talkMaxDuration = 0
				arg_204_1.dialogCg_.alpha = 1

				arg_204_1.dialog_:SetActive(true)
				SetActive(arg_204_1.leftNameGo_, true)

				arg_204_1.leftNameTxt_.text = arg_204_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_204_1.leftNameTxt_.transform)

				arg_204_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_204_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_204_1:RecordName(arg_204_1.leftNameTxt_.text)
				SetActive(arg_204_1.iconTrs_.gameObject, false)
				arg_204_1.callingController_:SetSelectedState("normal")

				local var_207_1 = arg_204_1:GetWordFromCfg(319631050)
				local var_207_2 = arg_204_1:FormatText(var_207_1.content)

				arg_204_1.text_.text = var_207_2

				LuaForUtil.ClearLinePrefixSymbol(arg_204_1.text_)

				local var_207_4 = 21 <= 0 and var_207_0 or var_207_0 * (utf8.len(var_207_2) / 21)

				if (21 <= 0 and var_207_0 or var_207_0 * (utf8.len(var_207_2) / 21)) > 0 and var_207_0 < var_207_4 then
					arg_204_1.talkMaxDuration = var_207_4

					if var_207_4 + 0 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_4 + 0
					end
				end

				arg_204_1.text_.text = var_207_2
				arg_204_1.typewritter.percent = 0

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319631", "319631050", "story_v_out_319631.awb") ~= 0 then
					local var_207_5 = manager.audio:GetVoiceLength("story_v_out_319631", "319631050", "story_v_out_319631.awb") / 1000

					if var_207_5 + 0 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_5 + 0
					end

					if var_207_1.prefab_name ~= "" and arg_204_1.actors_[var_207_1.prefab_name] ~= nil then
						local var_207_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_204_1.actors_[var_207_1.prefab_name].transform, "story_v_out_319631", "319631050", "story_v_out_319631.awb")

						arg_204_1:RecordAudio("319631050", var_207_6)
						arg_204_1:RecordAudio("319631050", var_207_6)
					else
						arg_204_1:AudioAction("play", "voice", "story_v_out_319631", "319631050", "story_v_out_319631.awb")
					end

					arg_204_1:RecordHistoryTalkVoice("story_v_out_319631", "319631050", "story_v_out_319631.awb")
				end

				arg_204_1:RecordContent(arg_204_1.text_.text)
			end

			local var_207_7 = math.max(var_207_0, arg_204_1.talkMaxDuration)

			if 0 <= arg_204_1.time_ and arg_204_1.time_ < 0 + var_207_7 then
				arg_204_1.typewritter.percent = (arg_204_1.time_ - 0) / var_207_7

				arg_204_1.typewritter:SetDirty()
			end

			if arg_204_1.time_ >= 0 + var_207_7 and arg_204_1.time_ < 0 + var_207_7 + arg_207_0 then
				arg_204_1.typewritter.percent = 1

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(true)
			end
		end

		arg_204_1.nodeConfigList_ = {}

		arg_204_1:InitPlayNodeList()
	end,
	Play319631051 = function(arg_208_0, arg_208_1)
		arg_208_1.time_ = 0
		arg_208_1.frameCnt_ = 0
		arg_208_1.state_ = "playing"
		arg_208_1.curTalkId_ = 319631051
		arg_208_1.duration_ = 5

		SetActive(arg_208_1.tipsGo_, false)

		function arg_208_1.onSingleLineFinish_()
			arg_208_1.onSingleLineUpdate_ = nil
			arg_208_1.onSingleLineFinish_ = nil
			arg_208_1.state_ = "waiting"
		end

		function arg_208_1.playNext_(arg_210_0)
			if arg_210_0 == 1 then
				arg_208_0:Play319631052(arg_208_1)
			end
		end

		function arg_208_1.onSingleLineUpdate_(arg_211_0)
			if 0 < arg_208_1.time_ and arg_208_1.time_ <= 0 + arg_211_0 and not isNil(arg_208_1.actors_["4037ui_story"]) and arg_208_1.var_.characterEffect4037ui_story == nil then
				arg_208_1.var_.characterEffect4037ui_story = arg_208_1.actors_["4037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_211_0 = 0.200000002980232

			if 0 <= arg_208_1.time_ and arg_208_1.time_ < 0 + var_211_0 and not isNil(arg_208_1.actors_["4037ui_story"]) then
				if arg_208_1.var_.characterEffect4037ui_story and not isNil(arg_208_1.actors_["4037ui_story"]) then
					arg_208_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_208_1.var_.characterEffect4037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_208_1.time_ - 0) / var_211_0)
				end
			end

			if arg_208_1.time_ >= 0 + var_211_0 and arg_208_1.time_ < 0 + var_211_0 + arg_211_0 and not isNil(arg_208_1.actors_["4037ui_story"]) and arg_208_1.var_.characterEffect4037ui_story then
				arg_208_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_208_1.var_.characterEffect4037ui_story.fillRatio = 0.5
			end

			local var_211_1 = 0
			local var_211_2 = 1.275

			if 0 < arg_208_1.time_ and arg_208_1.time_ <= var_211_1 + arg_211_0 then
				arg_208_1.talkMaxDuration = 0
				arg_208_1.dialogCg_.alpha = 1

				arg_208_1.dialog_:SetActive(true)
				SetActive(arg_208_1.leftNameGo_, false)

				arg_208_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_208_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_208_1:RecordName(arg_208_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_208_1.iconTrs_.gameObject, false)
				arg_208_1.callingController_:SetSelectedState("normal")

				local var_211_3 = arg_208_1:FormatText(arg_208_1:GetWordFromCfg(319631051).content)

				arg_208_1.text_.text = var_211_3

				LuaForUtil.ClearLinePrefixSymbol(arg_208_1.text_)

				local var_211_5 = 51 <= 0 and var_211_2 or var_211_2 * (utf8.len(var_211_3) / 51)

				if (51 <= 0 and var_211_2 or var_211_2 * (utf8.len(var_211_3) / 51)) > 0 and var_211_2 < var_211_5 then
					arg_208_1.talkMaxDuration = var_211_5

					if var_211_5 + var_211_1 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_5 + var_211_1
					end
				end

				arg_208_1.text_.text = var_211_3
				arg_208_1.typewritter.percent = 0

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(false)
				arg_208_1:RecordContent(arg_208_1.text_.text)
			end

			local var_211_6 = math.max(var_211_2, arg_208_1.talkMaxDuration)

			if var_211_1 <= arg_208_1.time_ and arg_208_1.time_ < var_211_1 + var_211_6 then
				arg_208_1.typewritter.percent = (arg_208_1.time_ - var_211_1) / var_211_6

				arg_208_1.typewritter:SetDirty()
			end

			if arg_208_1.time_ >= var_211_1 + var_211_6 and arg_208_1.time_ < var_211_1 + var_211_6 + arg_211_0 then
				arg_208_1.typewritter.percent = 1

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(true)
			end
		end

		arg_208_1.nodeConfigList_ = {}

		arg_208_1:InitPlayNodeList()
	end,
	Play319631052 = function(arg_212_0, arg_212_1)
		arg_212_1.time_ = 0
		arg_212_1.frameCnt_ = 0
		arg_212_1.state_ = "playing"
		arg_212_1.curTalkId_ = 319631052
		arg_212_1.duration_ = 2

		SetActive(arg_212_1.tipsGo_, false)

		function arg_212_1.onSingleLineFinish_()
			arg_212_1.onSingleLineUpdate_ = nil
			arg_212_1.onSingleLineFinish_ = nil
			arg_212_1.state_ = "waiting"
		end

		function arg_212_1.playNext_(arg_214_0)
			if arg_214_0 == 1 then
				arg_212_0:Play319631053(arg_212_1)
			end
		end

		function arg_212_1.onSingleLineUpdate_(arg_215_0)
			if 0 < arg_212_1.time_ and arg_212_1.time_ <= 0 + arg_215_0 then
				arg_212_1.var_.moveOldPos10079ui_story = arg_212_1.actors_["10079ui_story"].transform.localPosition
			end

			local var_215_0 = 0.001

			if 0 <= arg_212_1.time_ and arg_212_1.time_ < 0 + var_215_0 then
				arg_212_1.actors_["10079ui_story"].transform.localPosition = Vector3.Lerp(arg_212_1.var_.moveOldPos10079ui_story, Vector3.New(0, -0.95, -6.05), (arg_212_1.time_ - 0) / var_215_0)
				arg_212_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_212_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_212_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_212_1.actors_["10079ui_story"].transform.position).z)
				arg_212_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_212_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_212_1.actors_["10079ui_story"].transform.localEulerAngles = arg_212_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			if arg_212_1.time_ >= 0 + var_215_0 and arg_212_1.time_ < 0 + var_215_0 + arg_215_0 then
				arg_212_1.actors_["10079ui_story"].transform.localPosition = Vector3.New(0, -0.95, -6.05)
				arg_212_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_212_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_212_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_212_1.actors_["10079ui_story"].transform.position).z)
				arg_212_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_212_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_212_1.actors_["10079ui_story"].transform.localEulerAngles = arg_212_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			local var_215_1 = arg_212_1.actors_["10079ui_story"]

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= 0 + arg_215_0 and not isNil(var_215_1) and arg_212_1.var_.characterEffect10079ui_story == nil then
				arg_212_1.var_.characterEffect10079ui_story = var_215_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_215_2 = 0.200000002980232

			if 0 <= arg_212_1.time_ and arg_212_1.time_ < 0 + var_215_2 and not isNil(var_215_1) then
				if arg_212_1.var_.characterEffect10079ui_story and not isNil(var_215_1) then
					arg_212_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_212_1.time_ >= 0 + var_215_2 and arg_212_1.time_ < 0 + var_215_2 + arg_215_0 and not isNil(var_215_1) and arg_212_1.var_.characterEffect10079ui_story then
				arg_212_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= 0 + arg_215_0 then
				arg_212_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= 0 + arg_215_0 then
				arg_212_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_215_4 = arg_212_1.actors_["4037ui_story"].transform

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= 0 + arg_215_0 then
				arg_212_1.var_.moveOldPos4037ui_story = var_215_4.localPosition
			end

			local var_215_5 = 0.001

			if 0 <= arg_212_1.time_ and arg_212_1.time_ < 0 + var_215_5 then
				var_215_4.localPosition = Vector3.Lerp(arg_212_1.var_.moveOldPos4037ui_story, Vector3.New(0, 100, 0), (arg_212_1.time_ - 0) / var_215_5)
				var_215_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_215_4.position).x, (manager.ui.mainCamera.transform.position - var_215_4.position).y, (manager.ui.mainCamera.transform.position - var_215_4.position).z)
				var_215_4.localEulerAngles.z = 0
				var_215_4.localEulerAngles.x = 0
				var_215_4.localEulerAngles = var_215_4.localEulerAngles
			end

			if arg_212_1.time_ >= 0 + var_215_5 and arg_212_1.time_ < 0 + var_215_5 + arg_215_0 then
				var_215_4.localPosition = Vector3.New(0, 100, 0)
				var_215_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_215_4.position).x, (manager.ui.mainCamera.transform.position - var_215_4.position).y, (manager.ui.mainCamera.transform.position - var_215_4.position).z)
				var_215_4.localEulerAngles.z = 0
				var_215_4.localEulerAngles.x = 0
				var_215_4.localEulerAngles = var_215_4.localEulerAngles
			end

			local var_215_6 = arg_212_1.actors_["4037ui_story"]

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= 0 + arg_215_0 and not isNil(var_215_6) and arg_212_1.var_.characterEffect4037ui_story == nil then
				arg_212_1.var_.characterEffect4037ui_story = var_215_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_215_7 = 0.200000002980232

			if 0 <= arg_212_1.time_ and arg_212_1.time_ < 0 + var_215_7 and not isNil(var_215_6) then
				if arg_212_1.var_.characterEffect4037ui_story and not isNil(var_215_6) then
					arg_212_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_212_1.var_.characterEffect4037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_212_1.time_ - 0) / var_215_7)
				end
			end

			if arg_212_1.time_ >= 0 + var_215_7 and arg_212_1.time_ < 0 + var_215_7 + arg_215_0 and not isNil(var_215_6) and arg_212_1.var_.characterEffect4037ui_story then
				arg_212_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_212_1.var_.characterEffect4037ui_story.fillRatio = 0.5
			end

			local var_215_8 = 0
			local var_215_9 = 0.175

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= var_215_8 + arg_215_0 then
				arg_212_1.talkMaxDuration = 0
				arg_212_1.dialogCg_.alpha = 1

				arg_212_1.dialog_:SetActive(true)
				SetActive(arg_212_1.leftNameGo_, true)

				arg_212_1.leftNameTxt_.text = arg_212_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_212_1.leftNameTxt_.transform)

				arg_212_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_212_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_212_1:RecordName(arg_212_1.leftNameTxt_.text)
				SetActive(arg_212_1.iconTrs_.gameObject, false)
				arg_212_1.callingController_:SetSelectedState("normal")

				local var_215_10 = arg_212_1:GetWordFromCfg(319631052)
				local var_215_11 = arg_212_1:FormatText(var_215_10.content)

				arg_212_1.text_.text = var_215_11

				LuaForUtil.ClearLinePrefixSymbol(arg_212_1.text_)

				local var_215_13 = 7 <= 0 and var_215_9 or var_215_9 * (utf8.len(var_215_11) / 7)

				if (7 <= 0 and var_215_9 or var_215_9 * (utf8.len(var_215_11) / 7)) > 0 and var_215_9 < var_215_13 then
					arg_212_1.talkMaxDuration = var_215_13

					if var_215_13 + var_215_8 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_13 + var_215_8
					end
				end

				arg_212_1.text_.text = var_215_11
				arg_212_1.typewritter.percent = 0

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319631", "319631052", "story_v_out_319631.awb") ~= 0 then
					local var_215_14 = manager.audio:GetVoiceLength("story_v_out_319631", "319631052", "story_v_out_319631.awb") / 1000

					if var_215_14 + var_215_8 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_14 + var_215_8
					end

					if var_215_10.prefab_name ~= "" and arg_212_1.actors_[var_215_10.prefab_name] ~= nil then
						local var_215_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_212_1.actors_[var_215_10.prefab_name].transform, "story_v_out_319631", "319631052", "story_v_out_319631.awb")

						arg_212_1:RecordAudio("319631052", var_215_15)
						arg_212_1:RecordAudio("319631052", var_215_15)
					else
						arg_212_1:AudioAction("play", "voice", "story_v_out_319631", "319631052", "story_v_out_319631.awb")
					end

					arg_212_1:RecordHistoryTalkVoice("story_v_out_319631", "319631052", "story_v_out_319631.awb")
				end

				arg_212_1:RecordContent(arg_212_1.text_.text)
			end

			local var_215_16 = math.max(var_215_9, arg_212_1.talkMaxDuration)

			if var_215_8 <= arg_212_1.time_ and arg_212_1.time_ < var_215_8 + var_215_16 then
				arg_212_1.typewritter.percent = (arg_212_1.time_ - var_215_8) / var_215_16

				arg_212_1.typewritter:SetDirty()
			end

			if arg_212_1.time_ >= var_215_8 + var_215_16 and arg_212_1.time_ < var_215_8 + var_215_16 + arg_215_0 then
				arg_212_1.typewritter.percent = 1

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(true)
			end
		end

		arg_212_1.nodeConfigList_ = {
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
				actorName = "4037ui_story",
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
	Play319631053 = function(arg_216_0, arg_216_1)
		arg_216_1.time_ = 0
		arg_216_1.frameCnt_ = 0
		arg_216_1.state_ = "playing"
		arg_216_1.curTalkId_ = 319631053
		arg_216_1.duration_ = 9.23

		local var_216_0 = {
			zh = 4.866,
			ja = 9.233
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
				arg_216_0:Play319631054(arg_216_1)
			end
		end

		function arg_216_1.onSingleLineUpdate_(arg_219_0)
			if 0 < arg_216_1.time_ and arg_216_1.time_ <= 0 + arg_219_0 then
				arg_216_1.var_.moveOldPos4037ui_story = arg_216_1.actors_["4037ui_story"].transform.localPosition
			end

			local var_219_0 = 0.001

			if 0 <= arg_216_1.time_ and arg_216_1.time_ < 0 + var_219_0 then
				arg_216_1.actors_["4037ui_story"].transform.localPosition = Vector3.Lerp(arg_216_1.var_.moveOldPos4037ui_story, Vector3.New(-0.7, -1.12, -6.2), (arg_216_1.time_ - 0) / var_219_0)
				arg_216_1.actors_["4037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_216_1.actors_["4037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_216_1.actors_["4037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_216_1.actors_["4037ui_story"].transform.position).z)
				arg_216_1.actors_["4037ui_story"].transform.localEulerAngles.z = 0
				arg_216_1.actors_["4037ui_story"].transform.localEulerAngles.x = 0
				arg_216_1.actors_["4037ui_story"].transform.localEulerAngles = arg_216_1.actors_["4037ui_story"].transform.localEulerAngles
			end

			if arg_216_1.time_ >= 0 + var_219_0 and arg_216_1.time_ < 0 + var_219_0 + arg_219_0 then
				arg_216_1.actors_["4037ui_story"].transform.localPosition = Vector3.New(-0.7, -1.12, -6.2)
				arg_216_1.actors_["4037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_216_1.actors_["4037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_216_1.actors_["4037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_216_1.actors_["4037ui_story"].transform.position).z)
				arg_216_1.actors_["4037ui_story"].transform.localEulerAngles.z = 0
				arg_216_1.actors_["4037ui_story"].transform.localEulerAngles.x = 0
				arg_216_1.actors_["4037ui_story"].transform.localEulerAngles = arg_216_1.actors_["4037ui_story"].transform.localEulerAngles
			end

			local var_219_1 = arg_216_1.actors_["4037ui_story"]

			if 0 < arg_216_1.time_ and arg_216_1.time_ <= 0 + arg_219_0 and not isNil(var_219_1) and arg_216_1.var_.characterEffect4037ui_story == nil then
				arg_216_1.var_.characterEffect4037ui_story = var_219_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_219_2 = 0.200000002980232

			if 0 <= arg_216_1.time_ and arg_216_1.time_ < 0 + var_219_2 and not isNil(var_219_1) then
				if arg_216_1.var_.characterEffect4037ui_story and not isNil(var_219_1) then
					arg_216_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_216_1.time_ >= 0 + var_219_2 and arg_216_1.time_ < 0 + var_219_2 + arg_219_0 and not isNil(var_219_1) and arg_216_1.var_.characterEffect4037ui_story then
				arg_216_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			if 0 < arg_216_1.time_ and arg_216_1.time_ <= 0 + arg_219_0 then
				arg_216_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action1_1")
			end

			if 0 < arg_216_1.time_ and arg_216_1.time_ <= 0 + arg_219_0 then
				arg_216_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_219_4 = arg_216_1.actors_["10079ui_story"].transform

			if 0 < arg_216_1.time_ and arg_216_1.time_ <= 0 + arg_219_0 then
				arg_216_1.var_.moveOldPos10079ui_story = var_219_4.localPosition
			end

			local var_219_5 = 0.001

			if 0 <= arg_216_1.time_ and arg_216_1.time_ < 0 + var_219_5 then
				var_219_4.localPosition = Vector3.Lerp(arg_216_1.var_.moveOldPos10079ui_story, Vector3.New(0.7, -0.95, -6.05), (arg_216_1.time_ - 0) / var_219_5)
				var_219_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_219_4.position).x, (manager.ui.mainCamera.transform.position - var_219_4.position).y, (manager.ui.mainCamera.transform.position - var_219_4.position).z)
				var_219_4.localEulerAngles.z = 0
				var_219_4.localEulerAngles.x = 0
				var_219_4.localEulerAngles = var_219_4.localEulerAngles
			end

			if arg_216_1.time_ >= 0 + var_219_5 and arg_216_1.time_ < 0 + var_219_5 + arg_219_0 then
				var_219_4.localPosition = Vector3.New(0.7, -0.95, -6.05)
				var_219_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_219_4.position).x, (manager.ui.mainCamera.transform.position - var_219_4.position).y, (manager.ui.mainCamera.transform.position - var_219_4.position).z)
				var_219_4.localEulerAngles.z = 0
				var_219_4.localEulerAngles.x = 0
				var_219_4.localEulerAngles = var_219_4.localEulerAngles
			end

			local var_219_6 = arg_216_1.actors_["10079ui_story"]

			if 0 < arg_216_1.time_ and arg_216_1.time_ <= 0 + arg_219_0 and not isNil(var_219_6) and arg_216_1.var_.characterEffect10079ui_story == nil then
				arg_216_1.var_.characterEffect10079ui_story = var_219_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_219_7 = 0.200000002980232

			if 0 <= arg_216_1.time_ and arg_216_1.time_ < 0 + var_219_7 and not isNil(var_219_6) then
				if arg_216_1.var_.characterEffect10079ui_story and not isNil(var_219_6) then
					arg_216_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_216_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_216_1.time_ - 0) / var_219_7)
				end
			end

			if arg_216_1.time_ >= 0 + var_219_7 and arg_216_1.time_ < 0 + var_219_7 + arg_219_0 and not isNil(var_219_6) and arg_216_1.var_.characterEffect10079ui_story then
				arg_216_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_216_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			local var_219_8 = 0
			local var_219_9 = 0.425

			if 0 < arg_216_1.time_ and arg_216_1.time_ <= var_219_8 + arg_219_0 then
				arg_216_1.talkMaxDuration = 0
				arg_216_1.dialogCg_.alpha = 1

				arg_216_1.dialog_:SetActive(true)
				SetActive(arg_216_1.leftNameGo_, true)

				arg_216_1.leftNameTxt_.text = arg_216_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_216_1.leftNameTxt_.transform)

				arg_216_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_216_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_216_1:RecordName(arg_216_1.leftNameTxt_.text)
				SetActive(arg_216_1.iconTrs_.gameObject, false)
				arg_216_1.callingController_:SetSelectedState("normal")

				local var_219_10 = arg_216_1:GetWordFromCfg(319631053)
				local var_219_11 = arg_216_1:FormatText(var_219_10.content)

				arg_216_1.text_.text = var_219_11

				LuaForUtil.ClearLinePrefixSymbol(arg_216_1.text_)

				local var_219_13 = 17 <= 0 and var_219_9 or var_219_9 * (utf8.len(var_219_11) / 17)

				if (17 <= 0 and var_219_9 or var_219_9 * (utf8.len(var_219_11) / 17)) > 0 and var_219_9 < var_219_13 then
					arg_216_1.talkMaxDuration = var_219_13

					if var_219_13 + var_219_8 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_13 + var_219_8
					end
				end

				arg_216_1.text_.text = var_219_11
				arg_216_1.typewritter.percent = 0

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319631", "319631053", "story_v_out_319631.awb") ~= 0 then
					local var_219_14 = manager.audio:GetVoiceLength("story_v_out_319631", "319631053", "story_v_out_319631.awb") / 1000

					if var_219_14 + var_219_8 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_14 + var_219_8
					end

					if var_219_10.prefab_name ~= "" and arg_216_1.actors_[var_219_10.prefab_name] ~= nil then
						local var_219_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_216_1.actors_[var_219_10.prefab_name].transform, "story_v_out_319631", "319631053", "story_v_out_319631.awb")

						arg_216_1:RecordAudio("319631053", var_219_15)
						arg_216_1:RecordAudio("319631053", var_219_15)
					else
						arg_216_1:AudioAction("play", "voice", "story_v_out_319631", "319631053", "story_v_out_319631.awb")
					end

					arg_216_1:RecordHistoryTalkVoice("story_v_out_319631", "319631053", "story_v_out_319631.awb")
				end

				arg_216_1:RecordContent(arg_216_1.text_.text)
			end

			local var_219_16 = math.max(var_219_9, arg_216_1.talkMaxDuration)

			if var_219_8 <= arg_216_1.time_ and arg_216_1.time_ < var_219_8 + var_219_16 then
				arg_216_1.typewritter.percent = (arg_216_1.time_ - var_219_8) / var_219_16

				arg_216_1.typewritter:SetDirty()
			end

			if arg_216_1.time_ >= var_219_8 + var_219_16 and arg_216_1.time_ < var_219_8 + var_219_16 + arg_219_0 then
				arg_216_1.typewritter.percent = 1

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(true)
			end
		end

		arg_216_1.nodeConfigList_ = {
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
				actorName = "10079ui_story",
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
	Play319631054 = function(arg_220_0, arg_220_1)
		arg_220_1.time_ = 0
		arg_220_1.frameCnt_ = 0
		arg_220_1.state_ = "playing"
		arg_220_1.curTalkId_ = 319631054
		arg_220_1.duration_ = 5.77

		local var_220_0 = {
			zh = 3.966,
			ja = 5.766
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
				arg_220_0:Play319631055(arg_220_1)
			end
		end

		function arg_220_1.onSingleLineUpdate_(arg_223_0)
			if 0 < arg_220_1.time_ and arg_220_1.time_ <= 0 + arg_223_0 and not isNil(arg_220_1.actors_["10079ui_story"]) and arg_220_1.var_.characterEffect10079ui_story == nil then
				arg_220_1.var_.characterEffect10079ui_story = arg_220_1.actors_["10079ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_223_0 = 0.200000002980232

			if 0 <= arg_220_1.time_ and arg_220_1.time_ < 0 + var_223_0 and not isNil(arg_220_1.actors_["10079ui_story"]) then
				if arg_220_1.var_.characterEffect10079ui_story and not isNil(arg_220_1.actors_["10079ui_story"]) then
					arg_220_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_220_1.time_ >= 0 + var_223_0 and arg_220_1.time_ < 0 + var_223_0 + arg_223_0 and not isNil(arg_220_1.actors_["10079ui_story"]) and arg_220_1.var_.characterEffect10079ui_story then
				arg_220_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= 0 + arg_223_0 then
				arg_220_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action5_1")
			end

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= 0 + arg_223_0 then
				arg_220_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_223_2 = arg_220_1.actors_["4037ui_story"]

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= 0 + arg_223_0 and not isNil(var_223_2) and arg_220_1.var_.characterEffect4037ui_story == nil then
				arg_220_1.var_.characterEffect4037ui_story = var_223_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_223_3 = 0.200000002980232

			if 0 <= arg_220_1.time_ and arg_220_1.time_ < 0 + var_223_3 and not isNil(var_223_2) then
				if arg_220_1.var_.characterEffect4037ui_story and not isNil(var_223_2) then
					arg_220_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_220_1.var_.characterEffect4037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_220_1.time_ - 0) / var_223_3)
				end
			end

			if arg_220_1.time_ >= 0 + var_223_3 and arg_220_1.time_ < 0 + var_223_3 + arg_223_0 and not isNil(var_223_2) and arg_220_1.var_.characterEffect4037ui_story then
				arg_220_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_220_1.var_.characterEffect4037ui_story.fillRatio = 0.5
			end

			local var_223_4 = 0
			local var_223_5 = 0.575

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= var_223_4 + arg_223_0 then
				arg_220_1.talkMaxDuration = 0
				arg_220_1.dialogCg_.alpha = 1

				arg_220_1.dialog_:SetActive(true)
				SetActive(arg_220_1.leftNameGo_, true)

				arg_220_1.leftNameTxt_.text = arg_220_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_220_1.leftNameTxt_.transform)

				arg_220_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_220_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_220_1:RecordName(arg_220_1.leftNameTxt_.text)
				SetActive(arg_220_1.iconTrs_.gameObject, false)
				arg_220_1.callingController_:SetSelectedState("normal")

				local var_223_6 = arg_220_1:GetWordFromCfg(319631054)
				local var_223_7 = arg_220_1:FormatText(var_223_6.content)

				arg_220_1.text_.text = var_223_7

				LuaForUtil.ClearLinePrefixSymbol(arg_220_1.text_)

				local var_223_9 = 23 <= 0 and var_223_5 or var_223_5 * (utf8.len(var_223_7) / 23)

				if (23 <= 0 and var_223_5 or var_223_5 * (utf8.len(var_223_7) / 23)) > 0 and var_223_5 < var_223_9 then
					arg_220_1.talkMaxDuration = var_223_9

					if var_223_9 + var_223_4 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_9 + var_223_4
					end
				end

				arg_220_1.text_.text = var_223_7
				arg_220_1.typewritter.percent = 0

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319631", "319631054", "story_v_out_319631.awb") ~= 0 then
					local var_223_10 = manager.audio:GetVoiceLength("story_v_out_319631", "319631054", "story_v_out_319631.awb") / 1000

					if var_223_10 + var_223_4 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_10 + var_223_4
					end

					if var_223_6.prefab_name ~= "" and arg_220_1.actors_[var_223_6.prefab_name] ~= nil then
						local var_223_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_220_1.actors_[var_223_6.prefab_name].transform, "story_v_out_319631", "319631054", "story_v_out_319631.awb")

						arg_220_1:RecordAudio("319631054", var_223_11)
						arg_220_1:RecordAudio("319631054", var_223_11)
					else
						arg_220_1:AudioAction("play", "voice", "story_v_out_319631", "319631054", "story_v_out_319631.awb")
					end

					arg_220_1:RecordHistoryTalkVoice("story_v_out_319631", "319631054", "story_v_out_319631.awb")
				end

				arg_220_1:RecordContent(arg_220_1.text_.text)
			end

			local var_223_12 = math.max(var_223_5, arg_220_1.talkMaxDuration)

			if var_223_4 <= arg_220_1.time_ and arg_220_1.time_ < var_223_4 + var_223_12 then
				arg_220_1.typewritter.percent = (arg_220_1.time_ - var_223_4) / var_223_12

				arg_220_1.typewritter:SetDirty()
			end

			if arg_220_1.time_ >= var_223_4 + var_223_12 and arg_220_1.time_ < var_223_4 + var_223_12 + arg_223_0 then
				arg_220_1.typewritter.percent = 1

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(true)
			end
		end

		arg_220_1.nodeConfigList_ = {}

		arg_220_1:InitPlayNodeList()
	end,
	Play319631055 = function(arg_224_0, arg_224_1)
		arg_224_1.time_ = 0
		arg_224_1.frameCnt_ = 0
		arg_224_1.state_ = "playing"
		arg_224_1.curTalkId_ = 319631055
		arg_224_1.duration_ = 5

		SetActive(arg_224_1.tipsGo_, false)

		function arg_224_1.onSingleLineFinish_()
			arg_224_1.onSingleLineUpdate_ = nil
			arg_224_1.onSingleLineFinish_ = nil
			arg_224_1.state_ = "waiting"
		end

		function arg_224_1.playNext_(arg_226_0)
			if arg_226_0 == 1 then
				arg_224_0:Play319631056(arg_224_1)
			end
		end

		function arg_224_1.onSingleLineUpdate_(arg_227_0)
			if 0 < arg_224_1.time_ and arg_224_1.time_ <= 0 + arg_227_0 then
				arg_224_1.var_.moveOldPos10079ui_story = arg_224_1.actors_["10079ui_story"].transform.localPosition
			end

			local var_227_0 = 0.001

			if 0 <= arg_224_1.time_ and arg_224_1.time_ < 0 + var_227_0 then
				arg_224_1.actors_["10079ui_story"].transform.localPosition = Vector3.Lerp(arg_224_1.var_.moveOldPos10079ui_story, Vector3.New(0, 100, 0), (arg_224_1.time_ - 0) / var_227_0)
				arg_224_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_224_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_224_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_224_1.actors_["10079ui_story"].transform.position).z)
				arg_224_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_224_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_224_1.actors_["10079ui_story"].transform.localEulerAngles = arg_224_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			if arg_224_1.time_ >= 0 + var_227_0 and arg_224_1.time_ < 0 + var_227_0 + arg_227_0 then
				arg_224_1.actors_["10079ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_224_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_224_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_224_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_224_1.actors_["10079ui_story"].transform.position).z)
				arg_224_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_224_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_224_1.actors_["10079ui_story"].transform.localEulerAngles = arg_224_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			local var_227_1 = arg_224_1.actors_["10079ui_story"]

			if 0 < arg_224_1.time_ and arg_224_1.time_ <= 0 + arg_227_0 and not isNil(var_227_1) and arg_224_1.var_.characterEffect10079ui_story == nil then
				arg_224_1.var_.characterEffect10079ui_story = var_227_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_227_2 = 0.200000002980232

			if 0 <= arg_224_1.time_ and arg_224_1.time_ < 0 + var_227_2 and not isNil(var_227_1) then
				if arg_224_1.var_.characterEffect10079ui_story and not isNil(var_227_1) then
					arg_224_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_224_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_224_1.time_ - 0) / var_227_2)
				end
			end

			if arg_224_1.time_ >= 0 + var_227_2 and arg_224_1.time_ < 0 + var_227_2 + arg_227_0 and not isNil(var_227_1) and arg_224_1.var_.characterEffect10079ui_story then
				arg_224_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_224_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			local var_227_3 = arg_224_1.actors_["4037ui_story"].transform

			if 0 < arg_224_1.time_ and arg_224_1.time_ <= 0 + arg_227_0 then
				arg_224_1.var_.moveOldPos4037ui_story = var_227_3.localPosition
			end

			local var_227_4 = 0.001

			if 0 <= arg_224_1.time_ and arg_224_1.time_ < 0 + var_227_4 then
				var_227_3.localPosition = Vector3.Lerp(arg_224_1.var_.moveOldPos4037ui_story, Vector3.New(0, 100, 0), (arg_224_1.time_ - 0) / var_227_4)
				var_227_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_227_3.position).x, (manager.ui.mainCamera.transform.position - var_227_3.position).y, (manager.ui.mainCamera.transform.position - var_227_3.position).z)
				var_227_3.localEulerAngles.z = 0
				var_227_3.localEulerAngles.x = 0
				var_227_3.localEulerAngles = var_227_3.localEulerAngles
			end

			if arg_224_1.time_ >= 0 + var_227_4 and arg_224_1.time_ < 0 + var_227_4 + arg_227_0 then
				var_227_3.localPosition = Vector3.New(0, 100, 0)
				var_227_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_227_3.position).x, (manager.ui.mainCamera.transform.position - var_227_3.position).y, (manager.ui.mainCamera.transform.position - var_227_3.position).z)
				var_227_3.localEulerAngles.z = 0
				var_227_3.localEulerAngles.x = 0
				var_227_3.localEulerAngles = var_227_3.localEulerAngles
			end

			local var_227_5 = 0
			local var_227_6 = 1.15

			if 0 < arg_224_1.time_ and arg_224_1.time_ <= var_227_5 + arg_227_0 then
				arg_224_1.talkMaxDuration = 0
				arg_224_1.dialogCg_.alpha = 1

				arg_224_1.dialog_:SetActive(true)
				SetActive(arg_224_1.leftNameGo_, false)

				arg_224_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_224_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_224_1:RecordName(arg_224_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_224_1.iconTrs_.gameObject, false)
				arg_224_1.callingController_:SetSelectedState("normal")

				local var_227_7 = arg_224_1:FormatText(arg_224_1:GetWordFromCfg(319631055).content)

				arg_224_1.text_.text = var_227_7

				LuaForUtil.ClearLinePrefixSymbol(arg_224_1.text_)

				local var_227_9 = 46 <= 0 and var_227_6 or var_227_6 * (utf8.len(var_227_7) / 46)

				if (46 <= 0 and var_227_6 or var_227_6 * (utf8.len(var_227_7) / 46)) > 0 and var_227_6 < var_227_9 then
					arg_224_1.talkMaxDuration = var_227_9

					if var_227_9 + var_227_5 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_9 + var_227_5
					end
				end

				arg_224_1.text_.text = var_227_7
				arg_224_1.typewritter.percent = 0

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(false)
				arg_224_1:RecordContent(arg_224_1.text_.text)
			end

			local var_227_10 = math.max(var_227_6, arg_224_1.talkMaxDuration)

			if var_227_5 <= arg_224_1.time_ and arg_224_1.time_ < var_227_5 + var_227_10 then
				arg_224_1.typewritter.percent = (arg_224_1.time_ - var_227_5) / var_227_10

				arg_224_1.typewritter:SetDirty()
			end

			if arg_224_1.time_ >= var_227_5 + var_227_10 and arg_224_1.time_ < var_227_5 + var_227_10 + arg_227_0 then
				arg_224_1.typewritter.percent = 1

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(true)
			end
		end

		arg_224_1.nodeConfigList_ = {
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
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_224_1:InitPlayNodeList()
	end,
	Play319631056 = function(arg_228_0, arg_228_1)
		arg_228_1.time_ = 0
		arg_228_1.frameCnt_ = 0
		arg_228_1.state_ = "playing"
		arg_228_1.curTalkId_ = 319631056
		arg_228_1.duration_ = 4.03

		local var_228_0 = {
			zh = 2.06666666666667,
			ja = 4.03266666666667
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
				arg_228_0:Play319631057(arg_228_1)
			end
		end

		function arg_228_1.onSingleLineUpdate_(arg_231_0)
			if 0 < arg_228_1.time_ and arg_228_1.time_ <= 0 + arg_231_0 then
				arg_228_1.var_.moveOldPos4037ui_story = arg_228_1.actors_["4037ui_story"].transform.localPosition
			end

			local var_231_0 = 0.001

			if 0 <= arg_228_1.time_ and arg_228_1.time_ < 0 + var_231_0 then
				arg_228_1.actors_["4037ui_story"].transform.localPosition = Vector3.Lerp(arg_228_1.var_.moveOldPos4037ui_story, Vector3.New(0, -1.12, -6.2), (arg_228_1.time_ - 0) / var_231_0)
				arg_228_1.actors_["4037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_228_1.actors_["4037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_228_1.actors_["4037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_228_1.actors_["4037ui_story"].transform.position).z)
				arg_228_1.actors_["4037ui_story"].transform.localEulerAngles.z = 0
				arg_228_1.actors_["4037ui_story"].transform.localEulerAngles.x = 0
				arg_228_1.actors_["4037ui_story"].transform.localEulerAngles = arg_228_1.actors_["4037ui_story"].transform.localEulerAngles
			end

			if arg_228_1.time_ >= 0 + var_231_0 and arg_228_1.time_ < 0 + var_231_0 + arg_231_0 then
				arg_228_1.actors_["4037ui_story"].transform.localPosition = Vector3.New(0, -1.12, -6.2)
				arg_228_1.actors_["4037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_228_1.actors_["4037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_228_1.actors_["4037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_228_1.actors_["4037ui_story"].transform.position).z)
				arg_228_1.actors_["4037ui_story"].transform.localEulerAngles.z = 0
				arg_228_1.actors_["4037ui_story"].transform.localEulerAngles.x = 0
				arg_228_1.actors_["4037ui_story"].transform.localEulerAngles = arg_228_1.actors_["4037ui_story"].transform.localEulerAngles
			end

			local var_231_1 = arg_228_1.actors_["4037ui_story"]

			if 0 < arg_228_1.time_ and arg_228_1.time_ <= 0 + arg_231_0 and not isNil(var_231_1) and arg_228_1.var_.characterEffect4037ui_story == nil then
				arg_228_1.var_.characterEffect4037ui_story = var_231_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_231_2 = 0.200000002980232

			if 0 <= arg_228_1.time_ and arg_228_1.time_ < 0 + var_231_2 and not isNil(var_231_1) then
				if arg_228_1.var_.characterEffect4037ui_story and not isNil(var_231_1) then
					arg_228_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_228_1.time_ >= 0 + var_231_2 and arg_228_1.time_ < 0 + var_231_2 + arg_231_0 and not isNil(var_231_1) and arg_228_1.var_.characterEffect4037ui_story then
				arg_228_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			if 0 < arg_228_1.time_ and arg_228_1.time_ <= 0 + arg_231_0 then
				arg_228_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action5_1")
			end

			if 0 < arg_228_1.time_ and arg_228_1.time_ <= 0 + arg_231_0 then
				arg_228_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if arg_228_1.frameCnt_ <= 1 then
				arg_228_1.dialog_:SetActive(false)
			end

			local var_231_4 = 0.666666666666667
			local var_231_5 = 0.1

			if 0.666666666666667 < arg_228_1.time_ and arg_228_1.time_ <= var_231_4 + arg_231_0 then
				arg_228_1.talkMaxDuration = 0

				arg_228_1.dialog_:SetActive(true)

				arg_228_1.dialogCg_.alpha = 0

				local var_231_6 = LeanTween.value(arg_228_1.dialog_, 0, 1, 0.3)

				var_231_6:setOnUpdate(LuaHelper.FloatAction(function(arg_232_0)
					arg_228_1.dialogCg_.alpha = arg_232_0
				end))
				var_231_6:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_228_1.dialog_)
					var_231_6:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_228_1.duration_ = arg_228_1.duration_ + 0.3

				SetActive(arg_228_1.leftNameGo_, true)

				arg_228_1.leftNameTxt_.text = arg_228_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_228_1.leftNameTxt_.transform)

				arg_228_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_228_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_228_1:RecordName(arg_228_1.leftNameTxt_.text)
				SetActive(arg_228_1.iconTrs_.gameObject, false)
				arg_228_1.callingController_:SetSelectedState("normal")

				local var_231_7 = arg_228_1:GetWordFromCfg(319631056)
				local var_231_8 = arg_228_1:FormatText(var_231_7.content)

				arg_228_1.text_.text = var_231_8

				LuaForUtil.ClearLinePrefixSymbol(arg_228_1.text_)

				local var_231_10 = 4 <= 0 and var_231_5 or var_231_5 * (utf8.len(var_231_8) / 4)

				if (4 <= 0 and var_231_5 or var_231_5 * (utf8.len(var_231_8) / 4)) > 0 and var_231_5 < var_231_10 then
					arg_228_1.talkMaxDuration = var_231_10
					var_231_4 = var_231_4 + 0.3

					if var_231_10 + var_231_4 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_10 + var_231_4
					end
				end

				arg_228_1.text_.text = var_231_8
				arg_228_1.typewritter.percent = 0

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319631", "319631056", "story_v_out_319631.awb") ~= 0 then
					local var_231_11 = manager.audio:GetVoiceLength("story_v_out_319631", "319631056", "story_v_out_319631.awb") / 1000

					if var_231_11 + var_231_4 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_11 + var_231_4
					end

					if var_231_7.prefab_name ~= "" and arg_228_1.actors_[var_231_7.prefab_name] ~= nil then
						local var_231_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_228_1.actors_[var_231_7.prefab_name].transform, "story_v_out_319631", "319631056", "story_v_out_319631.awb")

						arg_228_1:RecordAudio("319631056", var_231_12)
						arg_228_1:RecordAudio("319631056", var_231_12)
					else
						arg_228_1:AudioAction("play", "voice", "story_v_out_319631", "319631056", "story_v_out_319631.awb")
					end

					arg_228_1:RecordHistoryTalkVoice("story_v_out_319631", "319631056", "story_v_out_319631.awb")
				end

				arg_228_1:RecordContent(arg_228_1.text_.text)
			end

			local var_231_13 = var_231_4 + 0.3
			local var_231_14 = math.max(var_231_5, arg_228_1.talkMaxDuration)

			if var_231_4 + 0.3 <= arg_228_1.time_ and arg_228_1.time_ < var_231_13 + var_231_14 then
				arg_228_1.typewritter.percent = (arg_228_1.time_ - var_231_13) / var_231_14

				arg_228_1.typewritter:SetDirty()
			end

			if arg_228_1.time_ >= var_231_13 + var_231_14 and arg_228_1.time_ < var_231_13 + var_231_14 + arg_231_0 then
				arg_228_1.typewritter.percent = 1

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(true)
			end
		end

		arg_228_1.nodeConfigList_ = {
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

		arg_228_1:InitPlayNodeList()
	end,
	Play319631057 = function(arg_234_0, arg_234_1)
		arg_234_1.time_ = 0
		arg_234_1.frameCnt_ = 0
		arg_234_1.state_ = "playing"
		arg_234_1.curTalkId_ = 319631057
		arg_234_1.duration_ = 4.97

		local var_234_0 = {
			zh = 4.666,
			ja = 4.966
		}
		local var_234_1 = manager.audio:GetLocalizationFlag()

		if var_234_0[var_234_1] ~= nil then
			arg_234_1.duration_ = var_234_0[var_234_1]
		end

		SetActive(arg_234_1.tipsGo_, false)

		function arg_234_1.onSingleLineFinish_()
			arg_234_1.onSingleLineUpdate_ = nil
			arg_234_1.onSingleLineFinish_ = nil
			arg_234_1.state_ = "waiting"
		end

		function arg_234_1.playNext_(arg_236_0)
			if arg_236_0 == 1 then
				arg_234_0:Play319631058(arg_234_1)
			end
		end

		function arg_234_1.onSingleLineUpdate_(arg_237_0)
			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 then
				arg_234_1.var_.moveOldPos10037ui_story = arg_234_1.actors_["10037ui_story"].transform.localPosition
			end

			local var_237_0 = 0.001

			if 0 <= arg_234_1.time_ and arg_234_1.time_ < 0 + var_237_0 then
				arg_234_1.actors_["10037ui_story"].transform.localPosition = Vector3.Lerp(arg_234_1.var_.moveOldPos10037ui_story, Vector3.New(0.7, -1.13, -6.2), (arg_234_1.time_ - 0) / var_237_0)
				arg_234_1.actors_["10037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_234_1.actors_["10037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_234_1.actors_["10037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_234_1.actors_["10037ui_story"].transform.position).z)
				arg_234_1.actors_["10037ui_story"].transform.localEulerAngles.z = 0
				arg_234_1.actors_["10037ui_story"].transform.localEulerAngles.x = 0
				arg_234_1.actors_["10037ui_story"].transform.localEulerAngles = arg_234_1.actors_["10037ui_story"].transform.localEulerAngles
			end

			if arg_234_1.time_ >= 0 + var_237_0 and arg_234_1.time_ < 0 + var_237_0 + arg_237_0 then
				arg_234_1.actors_["10037ui_story"].transform.localPosition = Vector3.New(0.7, -1.13, -6.2)
				arg_234_1.actors_["10037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_234_1.actors_["10037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_234_1.actors_["10037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_234_1.actors_["10037ui_story"].transform.position).z)
				arg_234_1.actors_["10037ui_story"].transform.localEulerAngles.z = 0
				arg_234_1.actors_["10037ui_story"].transform.localEulerAngles.x = 0
				arg_234_1.actors_["10037ui_story"].transform.localEulerAngles = arg_234_1.actors_["10037ui_story"].transform.localEulerAngles
			end

			local var_237_1 = arg_234_1.actors_["10037ui_story"]

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 and not isNil(var_237_1) and arg_234_1.var_.characterEffect10037ui_story == nil then
				arg_234_1.var_.characterEffect10037ui_story = var_237_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_237_2 = 0.200000002980232

			if 0 <= arg_234_1.time_ and arg_234_1.time_ < 0 + var_237_2 and not isNil(var_237_1) then
				if arg_234_1.var_.characterEffect10037ui_story and not isNil(var_237_1) then
					arg_234_1.var_.characterEffect10037ui_story.fillFlat = false
				end
			end

			if arg_234_1.time_ >= 0 + var_237_2 and arg_234_1.time_ < 0 + var_237_2 + arg_237_0 and not isNil(var_237_1) and arg_234_1.var_.characterEffect10037ui_story then
				arg_234_1.var_.characterEffect10037ui_story.fillFlat = false
			end

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 then
				arg_234_1:PlayTimeline("10037ui_story", "StoryTimeline/CharAction/story10037/story10037action/10037action3_1")
			end

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 then
				arg_234_1:PlayTimeline("10037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_237_4 = arg_234_1.actors_["4037ui_story"].transform

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 then
				arg_234_1.var_.moveOldPos4037ui_story = var_237_4.localPosition
			end

			local var_237_5 = 0.001

			if 0 <= arg_234_1.time_ and arg_234_1.time_ < 0 + var_237_5 then
				var_237_4.localPosition = Vector3.Lerp(arg_234_1.var_.moveOldPos4037ui_story, Vector3.New(-0.7, -1.12, -6.2), (arg_234_1.time_ - 0) / var_237_5)
				var_237_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_237_4.position).x, (manager.ui.mainCamera.transform.position - var_237_4.position).y, (manager.ui.mainCamera.transform.position - var_237_4.position).z)
				var_237_4.localEulerAngles.z = 0
				var_237_4.localEulerAngles.x = 0
				var_237_4.localEulerAngles = var_237_4.localEulerAngles
			end

			if arg_234_1.time_ >= 0 + var_237_5 and arg_234_1.time_ < 0 + var_237_5 + arg_237_0 then
				var_237_4.localPosition = Vector3.New(-0.7, -1.12, -6.2)
				var_237_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_237_4.position).x, (manager.ui.mainCamera.transform.position - var_237_4.position).y, (manager.ui.mainCamera.transform.position - var_237_4.position).z)
				var_237_4.localEulerAngles.z = 0
				var_237_4.localEulerAngles.x = 0
				var_237_4.localEulerAngles = var_237_4.localEulerAngles
			end

			local var_237_6 = arg_234_1.actors_["4037ui_story"]

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 and not isNil(var_237_6) and arg_234_1.var_.characterEffect4037ui_story == nil then
				arg_234_1.var_.characterEffect4037ui_story = var_237_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_237_7 = 0.200000002980232

			if 0 <= arg_234_1.time_ and arg_234_1.time_ < 0 + var_237_7 and not isNil(var_237_6) then
				if arg_234_1.var_.characterEffect4037ui_story and not isNil(var_237_6) then
					arg_234_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_234_1.var_.characterEffect4037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_234_1.time_ - 0) / var_237_7)
				end
			end

			if arg_234_1.time_ >= 0 + var_237_7 and arg_234_1.time_ < 0 + var_237_7 + arg_237_0 and not isNil(var_237_6) and arg_234_1.var_.characterEffect4037ui_story then
				arg_234_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_234_1.var_.characterEffect4037ui_story.fillRatio = 0.5
			end

			local var_237_8 = 0
			local var_237_9 = 0.425

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= var_237_8 + arg_237_0 then
				arg_234_1.talkMaxDuration = 0
				arg_234_1.dialogCg_.alpha = 1

				arg_234_1.dialog_:SetActive(true)
				SetActive(arg_234_1.leftNameGo_, true)

				arg_234_1.leftNameTxt_.text = arg_234_1:FormatText(StoryNameCfg[383].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_234_1.leftNameTxt_.transform)

				arg_234_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_234_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_234_1:RecordName(arg_234_1.leftNameTxt_.text)
				SetActive(arg_234_1.iconTrs_.gameObject, false)
				arg_234_1.callingController_:SetSelectedState("normal")

				local var_237_10 = arg_234_1:GetWordFromCfg(319631057)
				local var_237_11 = arg_234_1:FormatText(var_237_10.content)

				arg_234_1.text_.text = var_237_11

				LuaForUtil.ClearLinePrefixSymbol(arg_234_1.text_)

				local var_237_13 = 17 <= 0 and var_237_9 or var_237_9 * (utf8.len(var_237_11) / 17)

				if (17 <= 0 and var_237_9 or var_237_9 * (utf8.len(var_237_11) / 17)) > 0 and var_237_9 < var_237_13 then
					arg_234_1.talkMaxDuration = var_237_13

					if var_237_13 + var_237_8 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_13 + var_237_8
					end
				end

				arg_234_1.text_.text = var_237_11
				arg_234_1.typewritter.percent = 0

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319631", "319631057", "story_v_out_319631.awb") ~= 0 then
					local var_237_14 = manager.audio:GetVoiceLength("story_v_out_319631", "319631057", "story_v_out_319631.awb") / 1000

					if var_237_14 + var_237_8 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_14 + var_237_8
					end

					if var_237_10.prefab_name ~= "" and arg_234_1.actors_[var_237_10.prefab_name] ~= nil then
						local var_237_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_234_1.actors_[var_237_10.prefab_name].transform, "story_v_out_319631", "319631057", "story_v_out_319631.awb")

						arg_234_1:RecordAudio("319631057", var_237_15)
						arg_234_1:RecordAudio("319631057", var_237_15)
					else
						arg_234_1:AudioAction("play", "voice", "story_v_out_319631", "319631057", "story_v_out_319631.awb")
					end

					arg_234_1:RecordHistoryTalkVoice("story_v_out_319631", "319631057", "story_v_out_319631.awb")
				end

				arg_234_1:RecordContent(arg_234_1.text_.text)
			end

			local var_237_16 = math.max(var_237_9, arg_234_1.talkMaxDuration)

			if var_237_8 <= arg_234_1.time_ and arg_234_1.time_ < var_237_8 + var_237_16 then
				arg_234_1.typewritter.percent = (arg_234_1.time_ - var_237_8) / var_237_16

				arg_234_1.typewritter:SetDirty()
			end

			if arg_234_1.time_ >= var_237_8 + var_237_16 and arg_234_1.time_ < var_237_8 + var_237_16 + arg_237_0 then
				arg_234_1.typewritter.percent = 1

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(true)
			end
		end

		arg_234_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10037ui_story",
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
			}
		}

		arg_234_1:InitPlayNodeList()
	end,
	Play319631058 = function(arg_238_0, arg_238_1)
		arg_238_1.time_ = 0
		arg_238_1.frameCnt_ = 0
		arg_238_1.state_ = "playing"
		arg_238_1.curTalkId_ = 319631058
		arg_238_1.duration_ = 10.3

		local var_238_0 = {
			zh = 8.266,
			ja = 10.3
		}
		local var_238_1 = manager.audio:GetLocalizationFlag()

		if var_238_0[var_238_1] ~= nil then
			arg_238_1.duration_ = var_238_0[var_238_1]
		end

		SetActive(arg_238_1.tipsGo_, false)

		function arg_238_1.onSingleLineFinish_()
			arg_238_1.onSingleLineUpdate_ = nil
			arg_238_1.onSingleLineFinish_ = nil
			arg_238_1.state_ = "waiting"
		end

		function arg_238_1.playNext_(arg_240_0)
			if arg_240_0 == 1 then
				arg_238_0:Play319631059(arg_238_1)
			end
		end

		function arg_238_1.onSingleLineUpdate_(arg_241_0)
			local var_241_0 = 0.75

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 then
				arg_238_1.talkMaxDuration = 0
				arg_238_1.dialogCg_.alpha = 1

				arg_238_1.dialog_:SetActive(true)
				SetActive(arg_238_1.leftNameGo_, true)

				arg_238_1.leftNameTxt_.text = arg_238_1:FormatText(StoryNameCfg[383].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_238_1.leftNameTxt_.transform)

				arg_238_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_238_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_238_1:RecordName(arg_238_1.leftNameTxt_.text)
				SetActive(arg_238_1.iconTrs_.gameObject, false)
				arg_238_1.callingController_:SetSelectedState("normal")

				local var_241_1 = arg_238_1:GetWordFromCfg(319631058)
				local var_241_2 = arg_238_1:FormatText(var_241_1.content)

				arg_238_1.text_.text = var_241_2

				LuaForUtil.ClearLinePrefixSymbol(arg_238_1.text_)

				local var_241_4 = 30 <= 0 and var_241_0 or var_241_0 * (utf8.len(var_241_2) / 30)

				if (30 <= 0 and var_241_0 or var_241_0 * (utf8.len(var_241_2) / 30)) > 0 and var_241_0 < var_241_4 then
					arg_238_1.talkMaxDuration = var_241_4

					if var_241_4 + 0 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_4 + 0
					end
				end

				arg_238_1.text_.text = var_241_2
				arg_238_1.typewritter.percent = 0

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319631", "319631058", "story_v_out_319631.awb") ~= 0 then
					local var_241_5 = manager.audio:GetVoiceLength("story_v_out_319631", "319631058", "story_v_out_319631.awb") / 1000

					if var_241_5 + 0 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_5 + 0
					end

					if var_241_1.prefab_name ~= "" and arg_238_1.actors_[var_241_1.prefab_name] ~= nil then
						local var_241_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_238_1.actors_[var_241_1.prefab_name].transform, "story_v_out_319631", "319631058", "story_v_out_319631.awb")

						arg_238_1:RecordAudio("319631058", var_241_6)
						arg_238_1:RecordAudio("319631058", var_241_6)
					else
						arg_238_1:AudioAction("play", "voice", "story_v_out_319631", "319631058", "story_v_out_319631.awb")
					end

					arg_238_1:RecordHistoryTalkVoice("story_v_out_319631", "319631058", "story_v_out_319631.awb")
				end

				arg_238_1:RecordContent(arg_238_1.text_.text)
			end

			local var_241_7 = math.max(var_241_0, arg_238_1.talkMaxDuration)

			if 0 <= arg_238_1.time_ and arg_238_1.time_ < 0 + var_241_7 then
				arg_238_1.typewritter.percent = (arg_238_1.time_ - 0) / var_241_7

				arg_238_1.typewritter:SetDirty()
			end

			if arg_238_1.time_ >= 0 + var_241_7 and arg_238_1.time_ < 0 + var_241_7 + arg_241_0 then
				arg_238_1.typewritter.percent = 1

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(true)
			end
		end

		arg_238_1.nodeConfigList_ = {}

		arg_238_1:InitPlayNodeList()
	end,
	Play319631059 = function(arg_242_0, arg_242_1)
		arg_242_1.time_ = 0
		arg_242_1.frameCnt_ = 0
		arg_242_1.state_ = "playing"
		arg_242_1.curTalkId_ = 319631059
		arg_242_1.duration_ = 2

		SetActive(arg_242_1.tipsGo_, false)

		function arg_242_1.onSingleLineFinish_()
			arg_242_1.onSingleLineUpdate_ = nil
			arg_242_1.onSingleLineFinish_ = nil
			arg_242_1.state_ = "waiting"
		end

		function arg_242_1.playNext_(arg_244_0)
			if arg_244_0 == 1 then
				arg_242_0:Play319631060(arg_242_1)
			end
		end

		function arg_242_1.onSingleLineUpdate_(arg_245_0)
			if 0 < arg_242_1.time_ and arg_242_1.time_ <= 0 + arg_245_0 then
				arg_242_1.var_.moveOldPos10079ui_story = arg_242_1.actors_["10079ui_story"].transform.localPosition
			end

			local var_245_0 = 0.001

			if 0 <= arg_242_1.time_ and arg_242_1.time_ < 0 + var_245_0 then
				arg_242_1.actors_["10079ui_story"].transform.localPosition = Vector3.Lerp(arg_242_1.var_.moveOldPos10079ui_story, Vector3.New(0, -0.95, -6.05), (arg_242_1.time_ - 0) / var_245_0)
				arg_242_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_242_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_242_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_242_1.actors_["10079ui_story"].transform.position).z)
				arg_242_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_242_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_242_1.actors_["10079ui_story"].transform.localEulerAngles = arg_242_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			if arg_242_1.time_ >= 0 + var_245_0 and arg_242_1.time_ < 0 + var_245_0 + arg_245_0 then
				arg_242_1.actors_["10079ui_story"].transform.localPosition = Vector3.New(0, -0.95, -6.05)
				arg_242_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_242_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_242_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_242_1.actors_["10079ui_story"].transform.position).z)
				arg_242_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_242_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_242_1.actors_["10079ui_story"].transform.localEulerAngles = arg_242_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			local var_245_1 = arg_242_1.actors_["10079ui_story"]

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= 0 + arg_245_0 and not isNil(var_245_1) and arg_242_1.var_.characterEffect10079ui_story == nil then
				arg_242_1.var_.characterEffect10079ui_story = var_245_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_245_2 = 0.200000002980232

			if 0 <= arg_242_1.time_ and arg_242_1.time_ < 0 + var_245_2 and not isNil(var_245_1) then
				if arg_242_1.var_.characterEffect10079ui_story and not isNil(var_245_1) then
					arg_242_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_242_1.time_ >= 0 + var_245_2 and arg_242_1.time_ < 0 + var_245_2 + arg_245_0 and not isNil(var_245_1) and arg_242_1.var_.characterEffect10079ui_story then
				arg_242_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= 0 + arg_245_0 then
				arg_242_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action453")
			end

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= 0 + arg_245_0 then
				arg_242_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2201cva")
			end

			local var_245_4 = arg_242_1.actors_["10037ui_story"].transform

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= 0 + arg_245_0 then
				arg_242_1.var_.moveOldPos10037ui_story = var_245_4.localPosition
			end

			local var_245_5 = 0.001

			if 0 <= arg_242_1.time_ and arg_242_1.time_ < 0 + var_245_5 then
				var_245_4.localPosition = Vector3.Lerp(arg_242_1.var_.moveOldPos10037ui_story, Vector3.New(0, 100, 0), (arg_242_1.time_ - 0) / var_245_5)
				var_245_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_245_4.position).x, (manager.ui.mainCamera.transform.position - var_245_4.position).y, (manager.ui.mainCamera.transform.position - var_245_4.position).z)
				var_245_4.localEulerAngles.z = 0
				var_245_4.localEulerAngles.x = 0
				var_245_4.localEulerAngles = var_245_4.localEulerAngles
			end

			if arg_242_1.time_ >= 0 + var_245_5 and arg_242_1.time_ < 0 + var_245_5 + arg_245_0 then
				var_245_4.localPosition = Vector3.New(0, 100, 0)
				var_245_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_245_4.position).x, (manager.ui.mainCamera.transform.position - var_245_4.position).y, (manager.ui.mainCamera.transform.position - var_245_4.position).z)
				var_245_4.localEulerAngles.z = 0
				var_245_4.localEulerAngles.x = 0
				var_245_4.localEulerAngles = var_245_4.localEulerAngles
			end

			local var_245_6 = arg_242_1.actors_["10037ui_story"]

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= 0 + arg_245_0 and not isNil(var_245_6) and arg_242_1.var_.characterEffect10037ui_story == nil then
				arg_242_1.var_.characterEffect10037ui_story = var_245_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_245_7 = 0.200000002980232

			if 0 <= arg_242_1.time_ and arg_242_1.time_ < 0 + var_245_7 and not isNil(var_245_6) then
				if arg_242_1.var_.characterEffect10037ui_story and not isNil(var_245_6) then
					arg_242_1.var_.characterEffect10037ui_story.fillFlat = true
					arg_242_1.var_.characterEffect10037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_242_1.time_ - 0) / var_245_7)
				end
			end

			if arg_242_1.time_ >= 0 + var_245_7 and arg_242_1.time_ < 0 + var_245_7 + arg_245_0 and not isNil(var_245_6) and arg_242_1.var_.characterEffect10037ui_story then
				arg_242_1.var_.characterEffect10037ui_story.fillFlat = true
				arg_242_1.var_.characterEffect10037ui_story.fillRatio = 0.5
			end

			local var_245_8 = arg_242_1.actors_["4037ui_story"].transform

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= 0 + arg_245_0 then
				arg_242_1.var_.moveOldPos4037ui_story = var_245_8.localPosition
			end

			local var_245_9 = 0.001

			if 0 <= arg_242_1.time_ and arg_242_1.time_ < 0 + var_245_9 then
				var_245_8.localPosition = Vector3.Lerp(arg_242_1.var_.moveOldPos4037ui_story, Vector3.New(0, 100, 0), (arg_242_1.time_ - 0) / var_245_9)
				var_245_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_245_8.position).x, (manager.ui.mainCamera.transform.position - var_245_8.position).y, (manager.ui.mainCamera.transform.position - var_245_8.position).z)
				var_245_8.localEulerAngles.z = 0
				var_245_8.localEulerAngles.x = 0
				var_245_8.localEulerAngles = var_245_8.localEulerAngles
			end

			if arg_242_1.time_ >= 0 + var_245_9 and arg_242_1.time_ < 0 + var_245_9 + arg_245_0 then
				var_245_8.localPosition = Vector3.New(0, 100, 0)
				var_245_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_245_8.position).x, (manager.ui.mainCamera.transform.position - var_245_8.position).y, (manager.ui.mainCamera.transform.position - var_245_8.position).z)
				var_245_8.localEulerAngles.z = 0
				var_245_8.localEulerAngles.x = 0
				var_245_8.localEulerAngles = var_245_8.localEulerAngles
			end

			local var_245_10 = arg_242_1.actors_["4037ui_story"]

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= 0 + arg_245_0 and not isNil(var_245_10) and arg_242_1.var_.characterEffect4037ui_story == nil then
				arg_242_1.var_.characterEffect4037ui_story = var_245_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_245_11 = 0.200000002980232

			if 0 <= arg_242_1.time_ and arg_242_1.time_ < 0 + var_245_11 and not isNil(var_245_10) then
				if arg_242_1.var_.characterEffect4037ui_story and not isNil(var_245_10) then
					arg_242_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_242_1.var_.characterEffect4037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_242_1.time_ - 0) / var_245_11)
				end
			end

			if arg_242_1.time_ >= 0 + var_245_11 and arg_242_1.time_ < 0 + var_245_11 + arg_245_0 and not isNil(var_245_10) and arg_242_1.var_.characterEffect4037ui_story then
				arg_242_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_242_1.var_.characterEffect4037ui_story.fillRatio = 0.5
			end

			if arg_242_1.frameCnt_ <= 1 then
				arg_242_1.dialog_:SetActive(false)
			end

			local var_245_12 = 0.433333333333333
			local var_245_13 = 0.075

			if 0.433333333333333 < arg_242_1.time_ and arg_242_1.time_ <= var_245_12 + arg_245_0 then
				arg_242_1.talkMaxDuration = 0

				arg_242_1.dialog_:SetActive(true)

				arg_242_1.dialogCg_.alpha = 0

				local var_245_14 = LeanTween.value(arg_242_1.dialog_, 0, 1, 0.3)

				var_245_14:setOnUpdate(LuaHelper.FloatAction(function(arg_246_0)
					arg_242_1.dialogCg_.alpha = arg_246_0
				end))
				var_245_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_242_1.dialog_)
					var_245_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_242_1.duration_ = arg_242_1.duration_ + 0.3

				SetActive(arg_242_1.leftNameGo_, true)

				arg_242_1.leftNameTxt_.text = arg_242_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_242_1.leftNameTxt_.transform)

				arg_242_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_242_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_242_1:RecordName(arg_242_1.leftNameTxt_.text)
				SetActive(arg_242_1.iconTrs_.gameObject, false)
				arg_242_1.callingController_:SetSelectedState("normal")

				local var_245_15 = arg_242_1:GetWordFromCfg(319631059)
				local var_245_16 = arg_242_1:FormatText(var_245_15.content)

				arg_242_1.text_.text = var_245_16

				LuaForUtil.ClearLinePrefixSymbol(arg_242_1.text_)

				local var_245_18 = 3 <= 0 and var_245_13 or var_245_13 * (utf8.len(var_245_16) / 3)

				if (3 <= 0 and var_245_13 or var_245_13 * (utf8.len(var_245_16) / 3)) > 0 and var_245_13 < var_245_18 then
					arg_242_1.talkMaxDuration = var_245_18
					var_245_12 = var_245_12 + 0.3

					if var_245_18 + var_245_12 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_18 + var_245_12
					end
				end

				arg_242_1.text_.text = var_245_16
				arg_242_1.typewritter.percent = 0

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319631", "319631059", "story_v_out_319631.awb") ~= 0 then
					local var_245_19 = manager.audio:GetVoiceLength("story_v_out_319631", "319631059", "story_v_out_319631.awb") / 1000

					if var_245_19 + var_245_12 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_19 + var_245_12
					end

					if var_245_15.prefab_name ~= "" and arg_242_1.actors_[var_245_15.prefab_name] ~= nil then
						local var_245_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_242_1.actors_[var_245_15.prefab_name].transform, "story_v_out_319631", "319631059", "story_v_out_319631.awb")

						arg_242_1:RecordAudio("319631059", var_245_20)
						arg_242_1:RecordAudio("319631059", var_245_20)
					else
						arg_242_1:AudioAction("play", "voice", "story_v_out_319631", "319631059", "story_v_out_319631.awb")
					end

					arg_242_1:RecordHistoryTalkVoice("story_v_out_319631", "319631059", "story_v_out_319631.awb")
				end

				arg_242_1:RecordContent(arg_242_1.text_.text)
			end

			local var_245_21 = var_245_12 + 0.3
			local var_245_22 = math.max(var_245_13, arg_242_1.talkMaxDuration)

			if var_245_12 + 0.3 <= arg_242_1.time_ and arg_242_1.time_ < var_245_21 + var_245_22 then
				arg_242_1.typewritter.percent = (arg_242_1.time_ - var_245_21) / var_245_22

				arg_242_1.typewritter:SetDirty()
			end

			if arg_242_1.time_ >= var_245_21 + var_245_22 and arg_242_1.time_ < var_245_21 + var_245_22 + arg_245_0 then
				arg_242_1.typewritter.percent = 1

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(true)
			end
		end

		arg_242_1.nodeConfigList_ = {
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
				actorName = "10037ui_story",
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
			}
		}

		arg_242_1:InitPlayNodeList()
	end,
	Play319631060 = function(arg_248_0, arg_248_1)
		arg_248_1.time_ = 0
		arg_248_1.frameCnt_ = 0
		arg_248_1.state_ = "playing"
		arg_248_1.curTalkId_ = 319631060
		arg_248_1.duration_ = 7.87

		SetActive(arg_248_1.tipsGo_, false)

		function arg_248_1.onSingleLineFinish_()
			arg_248_1.onSingleLineUpdate_ = nil
			arg_248_1.onSingleLineFinish_ = nil
			arg_248_1.state_ = "waiting"
		end

		function arg_248_1.playNext_(arg_250_0)
			if arg_250_0 == 1 then
				arg_248_0:Play319631061(arg_248_1)
			end
		end

		function arg_248_1.onSingleLineUpdate_(arg_251_0)
			if 2 < arg_248_1.time_ and arg_248_1.time_ <= 2 + arg_251_0 then
				local var_251_0 = arg_248_1.bgs_.STblack

				arg_248_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_251_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_251_1 = var_251_0:GetComponent("SpriteRenderer")

				if var_251_1 and var_251_1.sprite then
					local var_251_2 = 2 * (var_251_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_251_0.transform.localScale = Vector3.New(var_251_2 / var_251_1.sprite.bounds.size.y < var_251_2 * manager.ui.mainCameraCom_.aspect / var_251_1.sprite.bounds.size.x and var_251_2 * manager.ui.mainCameraCom_.aspect / var_251_1.sprite.bounds.size.x or var_251_2 / var_251_1.sprite.bounds.size.y, var_251_2 / var_251_1.sprite.bounds.size.y < var_251_2 * manager.ui.mainCameraCom_.aspect / var_251_1.sprite.bounds.size.x and var_251_2 * manager.ui.mainCameraCom_.aspect / var_251_1.sprite.bounds.size.x or var_251_2 / var_251_1.sprite.bounds.size.y, 0)
				end

				for iter_251_0, iter_251_1 in pairs(arg_248_1.bgs_) do
					if iter_251_0 ~= "STblack" then
						iter_251_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 2 < arg_248_1.time_ and arg_248_1.time_ <= 2 + arg_251_0 then
				arg_248_1.fswbg_:SetActive(true)
				arg_248_1.dialog_:SetActive(false)

				arg_248_1.fswtw_.percent = 0
				arg_248_1.fswt_.text = arg_248_1:FormatText(arg_248_1:GetWordFromCfg(319631060).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_248_1.fswt_)

				arg_248_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_248_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_248_1.fswtw_:SetDirty()

				arg_248_1.typewritterCharCountI18N = 0

				SetActive(arg_248_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_248_1:ShowNextGo(false)
			end

			local var_251_3 = 2.86666666666667

			if 2.86666666666667 < arg_248_1.time_ and arg_248_1.time_ <= var_251_3 + arg_251_0 then
				arg_248_1.var_.oldValueTypewriter = arg_248_1.fswtw_.percent

				SetActive(arg_248_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_248_1:ShowNextGo(false)
			end

			local var_251_4 = 14
			local var_251_5 = 0.533333333333333
			local var_251_6, var_251_7 = arg_248_1:GetPercentByPara(arg_248_1:FormatText(arg_248_1:GetWordFromCfg(319631060).content), 1)

			if var_251_3 < arg_248_1.time_ and arg_248_1.time_ <= var_251_3 + arg_251_0 then
				arg_248_1.talkMaxDuration = 0

				local var_251_8 = var_251_4 <= 0 and var_251_5 or var_251_5 * ((var_251_7 - arg_248_1.typewritterCharCountI18N) / var_251_4)

				if (var_251_4 <= 0 and var_251_5 or var_251_5 * ((var_251_7 - arg_248_1.typewritterCharCountI18N) / var_251_4)) > 0 and var_251_5 < var_251_8 then
					arg_248_1.talkMaxDuration = var_251_8

					if var_251_8 + var_251_3 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_8 + var_251_3
					end
				end
			end

			local var_251_9 = math.max(0.533333333333333, arg_248_1.talkMaxDuration)

			if var_251_3 <= arg_248_1.time_ and arg_248_1.time_ < var_251_3 + var_251_9 then
				arg_248_1.fswtw_.percent = Mathf.Lerp(arg_248_1.var_.oldValueTypewriter, var_251_6, (arg_248_1.time_ - var_251_3) / var_251_9)
				arg_248_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_248_1.fswtw_:SetDirty()
			end

			if arg_248_1.time_ >= var_251_3 + var_251_9 and arg_248_1.time_ < var_251_3 + var_251_9 + arg_251_0 then
				arg_248_1.fswtw_.percent = var_251_6

				arg_248_1.fswtw_:SetDirty()
				arg_248_1:ShowNextGo(true)

				arg_248_1.typewritterCharCountI18N = var_251_7
			end

			local var_251_10 = 0

			if 0 < arg_248_1.time_ and arg_248_1.time_ <= var_251_10 + arg_251_0 then
				arg_248_1.mask_.enabled = true
				arg_248_1.mask_.raycastTarget = true

				arg_248_1:SetGaussion(false)
			end

			local var_251_11 = 2

			if var_251_10 <= arg_248_1.time_ and arg_248_1.time_ < var_251_10 + var_251_11 then
				local var_251_12 = Color.New(0, 0, 0)

				var_251_12.a = Mathf.Lerp(0, 1, (arg_248_1.time_ - var_251_10) / var_251_11)
				arg_248_1.mask_.color = var_251_12
			end

			if arg_248_1.time_ >= var_251_10 + var_251_11 and arg_248_1.time_ < var_251_10 + var_251_11 + arg_251_0 then
				local var_251_13 = Color.New(0, 0, 0)

				var_251_13.a = 1
				arg_248_1.mask_.color = var_251_13
			end

			local var_251_14 = 2

			if 2 < arg_248_1.time_ and arg_248_1.time_ <= var_251_14 + arg_251_0 then
				arg_248_1.mask_.enabled = true
				arg_248_1.mask_.raycastTarget = true

				arg_248_1:SetGaussion(false)
			end

			local var_251_15 = 0.966333333333333

			if var_251_14 <= arg_248_1.time_ and arg_248_1.time_ < var_251_14 + var_251_15 then
				local var_251_16 = Color.New(0, 0, 0)

				var_251_16.a = Mathf.Lerp(1, 0, (arg_248_1.time_ - var_251_14) / var_251_15)
				arg_248_1.mask_.color = var_251_16
			end

			if arg_248_1.time_ >= var_251_14 + var_251_15 and arg_248_1.time_ < var_251_14 + var_251_15 + arg_251_0 then
				local var_251_17 = Color.New(0, 0, 0)

				arg_248_1.mask_.enabled = false
				var_251_17.a = 0
				arg_248_1.mask_.color = var_251_17
			end

			local var_251_18 = arg_248_1.actors_["10079ui_story"].transform

			if 2 < arg_248_1.time_ and arg_248_1.time_ <= 2 + arg_251_0 then
				arg_248_1.var_.moveOldPos10079ui_story = var_251_18.localPosition
			end

			local var_251_19 = 0.001

			if 2 <= arg_248_1.time_ and arg_248_1.time_ < 2 + var_251_19 then
				var_251_18.localPosition = Vector3.Lerp(arg_248_1.var_.moveOldPos10079ui_story, Vector3.New(0, 100, 0), (arg_248_1.time_ - 2) / var_251_19)
				var_251_18.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_251_18.position).x, (manager.ui.mainCamera.transform.position - var_251_18.position).y, (manager.ui.mainCamera.transform.position - var_251_18.position).z)
				var_251_18.localEulerAngles.z = 0
				var_251_18.localEulerAngles.x = 0
				var_251_18.localEulerAngles = var_251_18.localEulerAngles
			end

			if arg_248_1.time_ >= 2 + var_251_19 and arg_248_1.time_ < 2 + var_251_19 + arg_251_0 then
				var_251_18.localPosition = Vector3.New(0, 100, 0)
				var_251_18.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_251_18.position).x, (manager.ui.mainCamera.transform.position - var_251_18.position).y, (manager.ui.mainCamera.transform.position - var_251_18.position).z)
				var_251_18.localEulerAngles.z = 0
				var_251_18.localEulerAngles.x = 0
				var_251_18.localEulerAngles = var_251_18.localEulerAngles
			end

			local var_251_20 = arg_248_1.actors_["10079ui_story"]

			if 0 < arg_248_1.time_ and arg_248_1.time_ <= 0 + arg_251_0 and not isNil(var_251_20) and arg_248_1.var_.characterEffect10079ui_story == nil then
				arg_248_1.var_.characterEffect10079ui_story = var_251_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_251_21 = 0.200000002980232

			if 0 <= arg_248_1.time_ and arg_248_1.time_ < 0 + var_251_21 and not isNil(var_251_20) then
				if arg_248_1.var_.characterEffect10079ui_story and not isNil(var_251_20) then
					arg_248_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_248_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_248_1.time_ - 0) / var_251_21)
				end
			end

			if arg_248_1.time_ >= 0 + var_251_21 and arg_248_1.time_ < 0 + var_251_21 + arg_251_0 and not isNil(var_251_20) and arg_248_1.var_.characterEffect10079ui_story then
				arg_248_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_248_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			if 2.86666666666667 < arg_248_1.time_ and arg_248_1.time_ <= 2.86666666666667 + arg_251_0 then
				local var_251_22 = arg_248_1.fswbg_.transform:Find("textbox/adapt/content") or arg_248_1.fswbg_.transform:Find("textbox/content")
				local var_251_23 = arg_248_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_251_24 = var_251_22:GetComponent("RectTransform")

				var_251_22:GetComponent("Text").alignment = UnityEngine.TextAnchor.MiddleCenter
				var_251_24.offsetMin = Vector2.New(0, 0)
				var_251_24.offsetMax = Vector2.New(0, 0)
			end
		end

		arg_248_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_248_1:InitPlayNodeList()
	end,
	Play319631061 = function(arg_252_0, arg_252_1)
		arg_252_1.time_ = 0
		arg_252_1.frameCnt_ = 0
		arg_252_1.state_ = "playing"
		arg_252_1.curTalkId_ = 319631061
		arg_252_1.duration_ = 6.3

		local var_252_0 = {
			zh = 4.999999999999,
			ja = 6.30000000298023
		}
		local var_252_1 = manager.audio:GetLocalizationFlag()

		if var_252_0[var_252_1] ~= nil then
			arg_252_1.duration_ = var_252_0[var_252_1]
		end

		SetActive(arg_252_1.tipsGo_, false)

		function arg_252_1.onSingleLineFinish_()
			arg_252_1.onSingleLineUpdate_ = nil
			arg_252_1.onSingleLineFinish_ = nil
			arg_252_1.state_ = "waiting"
		end

		function arg_252_1.playNext_(arg_254_0)
			if arg_254_0 == 1 then
				arg_252_0:Play319631062(arg_252_1)
			end
		end

		function arg_252_1.onSingleLineUpdate_(arg_255_0)
			if 1 < arg_252_1.time_ and arg_252_1.time_ <= 1 + arg_255_0 then
				local var_255_0 = arg_252_1.bgs_.Z03f

				arg_252_1.bgs_.Z03f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_255_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_255_1 = var_255_0:GetComponent("SpriteRenderer")

				if var_255_1 and var_255_1.sprite then
					local var_255_2 = 2 * (var_255_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_255_0.transform.localScale = Vector3.New(var_255_2 / var_255_1.sprite.bounds.size.y < var_255_2 * manager.ui.mainCameraCom_.aspect / var_255_1.sprite.bounds.size.x and var_255_2 * manager.ui.mainCameraCom_.aspect / var_255_1.sprite.bounds.size.x or var_255_2 / var_255_1.sprite.bounds.size.y, var_255_2 / var_255_1.sprite.bounds.size.y < var_255_2 * manager.ui.mainCameraCom_.aspect / var_255_1.sprite.bounds.size.x and var_255_2 * manager.ui.mainCameraCom_.aspect / var_255_1.sprite.bounds.size.x or var_255_2 / var_255_1.sprite.bounds.size.y, 0)
				end

				for iter_255_0, iter_255_1 in pairs(arg_252_1.bgs_) do
					if iter_255_0 ~= "Z03f" then
						iter_255_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_255_3 = 0

			if 0 < arg_252_1.time_ and arg_252_1.time_ <= var_255_3 + arg_255_0 then
				arg_252_1.allBtn_.enabled = false
			end

			if arg_252_1.time_ >= var_255_3 + 0.3 and arg_252_1.time_ < var_255_3 + 0.3 + arg_255_0 then
				arg_252_1.allBtn_.enabled = true
			end

			local var_255_4 = 0

			if 0 < arg_252_1.time_ and arg_252_1.time_ <= var_255_4 + arg_255_0 then
				arg_252_1.mask_.enabled = true
				arg_252_1.mask_.raycastTarget = true

				arg_252_1:SetGaussion(false)
			end

			local var_255_5 = 1

			if var_255_4 <= arg_252_1.time_ and arg_252_1.time_ < var_255_4 + var_255_5 then
				local var_255_6 = Color.New(0, 0, 0)

				var_255_6.a = Mathf.Lerp(0, 1, (arg_252_1.time_ - var_255_4) / var_255_5)
				arg_252_1.mask_.color = var_255_6
			end

			if arg_252_1.time_ >= var_255_4 + var_255_5 and arg_252_1.time_ < var_255_4 + var_255_5 + arg_255_0 then
				local var_255_7 = Color.New(0, 0, 0)

				var_255_7.a = 1
				arg_252_1.mask_.color = var_255_7
			end

			local var_255_8 = 1

			if 1 < arg_252_1.time_ and arg_252_1.time_ <= var_255_8 + arg_255_0 then
				arg_252_1.mask_.enabled = true
				arg_252_1.mask_.raycastTarget = true

				arg_252_1:SetGaussion(false)
			end

			local var_255_9 = 2

			if var_255_8 <= arg_252_1.time_ and arg_252_1.time_ < var_255_8 + var_255_9 then
				local var_255_10 = Color.New(0, 0, 0)

				var_255_10.a = Mathf.Lerp(1, 0, (arg_252_1.time_ - var_255_8) / var_255_9)
				arg_252_1.mask_.color = var_255_10
			end

			if arg_252_1.time_ >= var_255_8 + var_255_9 and arg_252_1.time_ < var_255_8 + var_255_9 + arg_255_0 then
				local var_255_11 = Color.New(0, 0, 0)

				arg_252_1.mask_.enabled = false
				var_255_11.a = 0
				arg_252_1.mask_.color = var_255_11
			end

			local var_255_12 = arg_252_1.actors_["10079ui_story"].transform

			if 3 < arg_252_1.time_ and arg_252_1.time_ <= 3 + arg_255_0 then
				arg_252_1.var_.moveOldPos10079ui_story = var_255_12.localPosition
			end

			local var_255_13 = 0.001

			if 3 <= arg_252_1.time_ and arg_252_1.time_ < 3 + var_255_13 then
				var_255_12.localPosition = Vector3.Lerp(arg_252_1.var_.moveOldPos10079ui_story, Vector3.New(0, -0.95, -6.05), (arg_252_1.time_ - 3) / var_255_13)
				var_255_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_255_12.position).x, (manager.ui.mainCamera.transform.position - var_255_12.position).y, (manager.ui.mainCamera.transform.position - var_255_12.position).z)
				var_255_12.localEulerAngles.z = 0
				var_255_12.localEulerAngles.x = 0
				var_255_12.localEulerAngles = var_255_12.localEulerAngles
			end

			if arg_252_1.time_ >= 3 + var_255_13 and arg_252_1.time_ < 3 + var_255_13 + arg_255_0 then
				var_255_12.localPosition = Vector3.New(0, -0.95, -6.05)
				var_255_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_255_12.position).x, (manager.ui.mainCamera.transform.position - var_255_12.position).y, (manager.ui.mainCamera.transform.position - var_255_12.position).z)
				var_255_12.localEulerAngles.z = 0
				var_255_12.localEulerAngles.x = 0
				var_255_12.localEulerAngles = var_255_12.localEulerAngles
			end

			local var_255_14 = arg_252_1.actors_["10079ui_story"]

			if 3 < arg_252_1.time_ and arg_252_1.time_ <= 3 + arg_255_0 and not isNil(var_255_14) and arg_252_1.var_.characterEffect10079ui_story == nil then
				arg_252_1.var_.characterEffect10079ui_story = var_255_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_255_15 = 0.200000002980232

			if 3 <= arg_252_1.time_ and arg_252_1.time_ < 3 + var_255_15 and not isNil(var_255_14) then
				if arg_252_1.var_.characterEffect10079ui_story and not isNil(var_255_14) then
					arg_252_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_252_1.time_ >= 3 + var_255_15 and arg_252_1.time_ < 3 + var_255_15 + arg_255_0 and not isNil(var_255_14) and arg_252_1.var_.characterEffect10079ui_story then
				arg_252_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			if 3 < arg_252_1.time_ and arg_252_1.time_ <= 3 + arg_255_0 then
				arg_252_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if 1 < arg_252_1.time_ and arg_252_1.time_ <= 1 + arg_255_0 then
				arg_252_1.fswbg_:SetActive(false)
				arg_252_1.dialog_:SetActive(false)
				SetActive(arg_252_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_252_1:ShowNextGo(false)
			end

			if 1.033 < arg_252_1.time_ and arg_252_1.time_ <= 1.033 + arg_255_0 then
				arg_252_1.fswbg_:SetActive(false)
				arg_252_1.dialog_:SetActive(false)
				SetActive(arg_252_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_252_1:ShowNextGo(false)
			end

			if arg_252_1.frameCnt_ <= 1 then
				arg_252_1.dialog_:SetActive(false)
			end

			local var_255_17 = 3.20000000298023
			local var_255_18 = 0.2

			if 3.20000000298023 < arg_252_1.time_ and arg_252_1.time_ <= var_255_17 + arg_255_0 then
				arg_252_1.talkMaxDuration = 0

				arg_252_1.dialog_:SetActive(true)

				arg_252_1.dialogCg_.alpha = 0

				local var_255_19 = LeanTween.value(arg_252_1.dialog_, 0, 1, 0.3)

				var_255_19:setOnUpdate(LuaHelper.FloatAction(function(arg_256_0)
					arg_252_1.dialogCg_.alpha = arg_256_0
				end))
				var_255_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_252_1.dialog_)
					var_255_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_252_1.duration_ = arg_252_1.duration_ + 0.3

				SetActive(arg_252_1.leftNameGo_, true)

				arg_252_1.leftNameTxt_.text = arg_252_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_252_1.leftNameTxt_.transform)

				arg_252_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_252_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_252_1:RecordName(arg_252_1.leftNameTxt_.text)
				SetActive(arg_252_1.iconTrs_.gameObject, false)
				arg_252_1.callingController_:SetSelectedState("normal")

				local var_255_20 = arg_252_1:GetWordFromCfg(319631061)
				local var_255_21 = arg_252_1:FormatText(var_255_20.content)

				arg_252_1.text_.text = var_255_21

				LuaForUtil.ClearLinePrefixSymbol(arg_252_1.text_)

				local var_255_23 = 8 <= 0 and var_255_18 or var_255_18 * (utf8.len(var_255_21) / 8)

				if (8 <= 0 and var_255_18 or var_255_18 * (utf8.len(var_255_21) / 8)) > 0 and var_255_18 < var_255_23 then
					arg_252_1.talkMaxDuration = var_255_23
					var_255_17 = var_255_17 + 0.3

					if var_255_23 + var_255_17 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_23 + var_255_17
					end
				end

				arg_252_1.text_.text = var_255_21
				arg_252_1.typewritter.percent = 0

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319631", "319631061", "story_v_out_319631.awb") ~= 0 then
					local var_255_24 = manager.audio:GetVoiceLength("story_v_out_319631", "319631061", "story_v_out_319631.awb") / 1000

					if var_255_24 + var_255_17 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_24 + var_255_17
					end

					if var_255_20.prefab_name ~= "" and arg_252_1.actors_[var_255_20.prefab_name] ~= nil then
						local var_255_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_252_1.actors_[var_255_20.prefab_name].transform, "story_v_out_319631", "319631061", "story_v_out_319631.awb")

						arg_252_1:RecordAudio("319631061", var_255_25)
						arg_252_1:RecordAudio("319631061", var_255_25)
					else
						arg_252_1:AudioAction("play", "voice", "story_v_out_319631", "319631061", "story_v_out_319631.awb")
					end

					arg_252_1:RecordHistoryTalkVoice("story_v_out_319631", "319631061", "story_v_out_319631.awb")
				end

				arg_252_1:RecordContent(arg_252_1.text_.text)
			end

			local var_255_26 = var_255_17 + 0.3
			local var_255_27 = math.max(var_255_18, arg_252_1.talkMaxDuration)

			if var_255_17 + 0.3 <= arg_252_1.time_ and arg_252_1.time_ < var_255_26 + var_255_27 then
				arg_252_1.typewritter.percent = (arg_252_1.time_ - var_255_26) / var_255_27

				arg_252_1.typewritter:SetDirty()
			end

			if arg_252_1.time_ >= var_255_26 + var_255_27 and arg_252_1.time_ < var_255_26 + var_255_27 + arg_255_0 then
				arg_252_1.typewritter.percent = 1

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(true)
			end
		end

		arg_252_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_252_1:InitPlayNodeList()
	end,
	Play319631062 = function(arg_258_0, arg_258_1)
		arg_258_1.time_ = 0
		arg_258_1.frameCnt_ = 0
		arg_258_1.state_ = "playing"
		arg_258_1.curTalkId_ = 319631062
		arg_258_1.duration_ = 3.73

		local var_258_0 = {
			zh = 3.733,
			ja = 3.366
		}
		local var_258_1 = manager.audio:GetLocalizationFlag()

		if var_258_0[var_258_1] ~= nil then
			arg_258_1.duration_ = var_258_0[var_258_1]
		end

		SetActive(arg_258_1.tipsGo_, false)

		function arg_258_1.onSingleLineFinish_()
			arg_258_1.onSingleLineUpdate_ = nil
			arg_258_1.onSingleLineFinish_ = nil
			arg_258_1.state_ = "waiting"
		end

		function arg_258_1.playNext_(arg_260_0)
			if arg_260_0 == 1 then
				arg_258_0:Play319631063(arg_258_1)
			end
		end

		function arg_258_1.onSingleLineUpdate_(arg_261_0)
			if 0 < arg_258_1.time_ and arg_258_1.time_ <= 0 + arg_261_0 then
				arg_258_1.var_.moveOldPos4037ui_story = arg_258_1.actors_["4037ui_story"].transform.localPosition
			end

			local var_261_0 = 0.001

			if 0 <= arg_258_1.time_ and arg_258_1.time_ < 0 + var_261_0 then
				arg_258_1.actors_["4037ui_story"].transform.localPosition = Vector3.Lerp(arg_258_1.var_.moveOldPos4037ui_story, Vector3.New(-0.7, -1.12, -6.2), (arg_258_1.time_ - 0) / var_261_0)
				arg_258_1.actors_["4037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_258_1.actors_["4037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_258_1.actors_["4037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_258_1.actors_["4037ui_story"].transform.position).z)
				arg_258_1.actors_["4037ui_story"].transform.localEulerAngles.z = 0
				arg_258_1.actors_["4037ui_story"].transform.localEulerAngles.x = 0
				arg_258_1.actors_["4037ui_story"].transform.localEulerAngles = arg_258_1.actors_["4037ui_story"].transform.localEulerAngles
			end

			if arg_258_1.time_ >= 0 + var_261_0 and arg_258_1.time_ < 0 + var_261_0 + arg_261_0 then
				arg_258_1.actors_["4037ui_story"].transform.localPosition = Vector3.New(-0.7, -1.12, -6.2)
				arg_258_1.actors_["4037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_258_1.actors_["4037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_258_1.actors_["4037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_258_1.actors_["4037ui_story"].transform.position).z)
				arg_258_1.actors_["4037ui_story"].transform.localEulerAngles.z = 0
				arg_258_1.actors_["4037ui_story"].transform.localEulerAngles.x = 0
				arg_258_1.actors_["4037ui_story"].transform.localEulerAngles = arg_258_1.actors_["4037ui_story"].transform.localEulerAngles
			end

			local var_261_1 = arg_258_1.actors_["4037ui_story"]

			if 0 < arg_258_1.time_ and arg_258_1.time_ <= 0 + arg_261_0 and not isNil(var_261_1) and arg_258_1.var_.characterEffect4037ui_story == nil then
				arg_258_1.var_.characterEffect4037ui_story = var_261_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_261_2 = 0.200000002980232

			if 0 <= arg_258_1.time_ and arg_258_1.time_ < 0 + var_261_2 and not isNil(var_261_1) then
				if arg_258_1.var_.characterEffect4037ui_story and not isNil(var_261_1) then
					arg_258_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_258_1.time_ >= 0 + var_261_2 and arg_258_1.time_ < 0 + var_261_2 + arg_261_0 and not isNil(var_261_1) and arg_258_1.var_.characterEffect4037ui_story then
				arg_258_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			local var_261_4 = arg_258_1.actors_["10079ui_story"].transform

			if 0 < arg_258_1.time_ and arg_258_1.time_ <= 0 + arg_261_0 then
				arg_258_1.var_.moveOldPos10079ui_story = var_261_4.localPosition
			end

			local var_261_5 = 0.001

			if 0 <= arg_258_1.time_ and arg_258_1.time_ < 0 + var_261_5 then
				var_261_4.localPosition = Vector3.Lerp(arg_258_1.var_.moveOldPos10079ui_story, Vector3.New(0.7, -0.95, -6.05), (arg_258_1.time_ - 0) / var_261_5)
				var_261_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_261_4.position).x, (manager.ui.mainCamera.transform.position - var_261_4.position).y, (manager.ui.mainCamera.transform.position - var_261_4.position).z)
				var_261_4.localEulerAngles.z = 0
				var_261_4.localEulerAngles.x = 0
				var_261_4.localEulerAngles = var_261_4.localEulerAngles
			end

			if arg_258_1.time_ >= 0 + var_261_5 and arg_258_1.time_ < 0 + var_261_5 + arg_261_0 then
				var_261_4.localPosition = Vector3.New(0.7, -0.95, -6.05)
				var_261_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_261_4.position).x, (manager.ui.mainCamera.transform.position - var_261_4.position).y, (manager.ui.mainCamera.transform.position - var_261_4.position).z)
				var_261_4.localEulerAngles.z = 0
				var_261_4.localEulerAngles.x = 0
				var_261_4.localEulerAngles = var_261_4.localEulerAngles
			end

			local var_261_6 = arg_258_1.actors_["10079ui_story"]

			if 0 < arg_258_1.time_ and arg_258_1.time_ <= 0 + arg_261_0 and not isNil(var_261_6) and arg_258_1.var_.characterEffect10079ui_story == nil then
				arg_258_1.var_.characterEffect10079ui_story = var_261_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_261_7 = 0.200000002980232

			if 0 <= arg_258_1.time_ and arg_258_1.time_ < 0 + var_261_7 and not isNil(var_261_6) then
				if arg_258_1.var_.characterEffect10079ui_story and not isNil(var_261_6) then
					arg_258_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_258_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_258_1.time_ - 0) / var_261_7)
				end
			end

			if arg_258_1.time_ >= 0 + var_261_7 and arg_258_1.time_ < 0 + var_261_7 + arg_261_0 and not isNil(var_261_6) and arg_258_1.var_.characterEffect10079ui_story then
				arg_258_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_258_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			local var_261_8 = 0
			local var_261_9 = 0.3

			if 0 < arg_258_1.time_ and arg_258_1.time_ <= var_261_8 + arg_261_0 then
				arg_258_1.talkMaxDuration = 0
				arg_258_1.dialogCg_.alpha = 1

				arg_258_1.dialog_:SetActive(true)
				SetActive(arg_258_1.leftNameGo_, true)

				arg_258_1.leftNameTxt_.text = arg_258_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_258_1.leftNameTxt_.transform)

				arg_258_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_258_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_258_1:RecordName(arg_258_1.leftNameTxt_.text)
				SetActive(arg_258_1.iconTrs_.gameObject, false)
				arg_258_1.callingController_:SetSelectedState("normal")

				local var_261_10 = arg_258_1:GetWordFromCfg(319631062)
				local var_261_11 = arg_258_1:FormatText(var_261_10.content)

				arg_258_1.text_.text = var_261_11

				LuaForUtil.ClearLinePrefixSymbol(arg_258_1.text_)

				local var_261_13 = 12 <= 0 and var_261_9 or var_261_9 * (utf8.len(var_261_11) / 12)

				if (12 <= 0 and var_261_9 or var_261_9 * (utf8.len(var_261_11) / 12)) > 0 and var_261_9 < var_261_13 then
					arg_258_1.talkMaxDuration = var_261_13

					if var_261_13 + var_261_8 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_13 + var_261_8
					end
				end

				arg_258_1.text_.text = var_261_11
				arg_258_1.typewritter.percent = 0

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319631", "319631062", "story_v_out_319631.awb") ~= 0 then
					local var_261_14 = manager.audio:GetVoiceLength("story_v_out_319631", "319631062", "story_v_out_319631.awb") / 1000

					if var_261_14 + var_261_8 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_14 + var_261_8
					end

					if var_261_10.prefab_name ~= "" and arg_258_1.actors_[var_261_10.prefab_name] ~= nil then
						local var_261_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_258_1.actors_[var_261_10.prefab_name].transform, "story_v_out_319631", "319631062", "story_v_out_319631.awb")

						arg_258_1:RecordAudio("319631062", var_261_15)
						arg_258_1:RecordAudio("319631062", var_261_15)
					else
						arg_258_1:AudioAction("play", "voice", "story_v_out_319631", "319631062", "story_v_out_319631.awb")
					end

					arg_258_1:RecordHistoryTalkVoice("story_v_out_319631", "319631062", "story_v_out_319631.awb")
				end

				arg_258_1:RecordContent(arg_258_1.text_.text)
			end

			local var_261_16 = math.max(var_261_9, arg_258_1.talkMaxDuration)

			if var_261_8 <= arg_258_1.time_ and arg_258_1.time_ < var_261_8 + var_261_16 then
				arg_258_1.typewritter.percent = (arg_258_1.time_ - var_261_8) / var_261_16

				arg_258_1.typewritter:SetDirty()
			end

			if arg_258_1.time_ >= var_261_8 + var_261_16 and arg_258_1.time_ < var_261_8 + var_261_16 + arg_261_0 then
				arg_258_1.typewritter.percent = 1

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(true)
			end
		end

		arg_258_1.nodeConfigList_ = {
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
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_258_1:InitPlayNodeList()
	end,
	Play319631063 = function(arg_262_0, arg_262_1)
		arg_262_1.time_ = 0
		arg_262_1.frameCnt_ = 0
		arg_262_1.state_ = "playing"
		arg_262_1.curTalkId_ = 319631063
		arg_262_1.duration_ = 7.87

		local var_262_0 = {
			zh = 6.766,
			ja = 7.866
		}
		local var_262_1 = manager.audio:GetLocalizationFlag()

		if var_262_0[var_262_1] ~= nil then
			arg_262_1.duration_ = var_262_0[var_262_1]
		end

		SetActive(arg_262_1.tipsGo_, false)

		function arg_262_1.onSingleLineFinish_()
			arg_262_1.onSingleLineUpdate_ = nil
			arg_262_1.onSingleLineFinish_ = nil
			arg_262_1.state_ = "waiting"
		end

		function arg_262_1.playNext_(arg_264_0)
			if arg_264_0 == 1 then
				arg_262_0:Play319631064(arg_262_1)
			end
		end

		function arg_262_1.onSingleLineUpdate_(arg_265_0)
			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 and not isNil(arg_262_1.actors_["10079ui_story"]) and arg_262_1.var_.characterEffect10079ui_story == nil then
				arg_262_1.var_.characterEffect10079ui_story = arg_262_1.actors_["10079ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_265_0 = 0.200000002980232

			if 0 <= arg_262_1.time_ and arg_262_1.time_ < 0 + var_265_0 and not isNil(arg_262_1.actors_["10079ui_story"]) then
				if arg_262_1.var_.characterEffect10079ui_story and not isNil(arg_262_1.actors_["10079ui_story"]) then
					arg_262_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_262_1.time_ >= 0 + var_265_0 and arg_262_1.time_ < 0 + var_265_0 + arg_265_0 and not isNil(arg_262_1.actors_["10079ui_story"]) and arg_262_1.var_.characterEffect10079ui_story then
				arg_262_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_265_2 = arg_262_1.actors_["4037ui_story"]

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 and not isNil(var_265_2) and arg_262_1.var_.characterEffect4037ui_story == nil then
				arg_262_1.var_.characterEffect4037ui_story = var_265_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_265_3 = 0.200000002980232

			if 0 <= arg_262_1.time_ and arg_262_1.time_ < 0 + var_265_3 and not isNil(var_265_2) then
				if arg_262_1.var_.characterEffect4037ui_story and not isNil(var_265_2) then
					arg_262_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_262_1.var_.characterEffect4037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_262_1.time_ - 0) / var_265_3)
				end
			end

			if arg_262_1.time_ >= 0 + var_265_3 and arg_262_1.time_ < 0 + var_265_3 + arg_265_0 and not isNil(var_265_2) and arg_262_1.var_.characterEffect4037ui_story then
				arg_262_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_262_1.var_.characterEffect4037ui_story.fillRatio = 0.5
			end

			local var_265_4 = 0
			local var_265_5 = 0.875

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= var_265_4 + arg_265_0 then
				arg_262_1.talkMaxDuration = 0
				arg_262_1.dialogCg_.alpha = 1

				arg_262_1.dialog_:SetActive(true)
				SetActive(arg_262_1.leftNameGo_, true)

				arg_262_1.leftNameTxt_.text = arg_262_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_262_1.leftNameTxt_.transform)

				arg_262_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_262_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_262_1:RecordName(arg_262_1.leftNameTxt_.text)
				SetActive(arg_262_1.iconTrs_.gameObject, false)
				arg_262_1.callingController_:SetSelectedState("normal")

				local var_265_6 = arg_262_1:GetWordFromCfg(319631063)
				local var_265_7 = arg_262_1:FormatText(var_265_6.content)

				arg_262_1.text_.text = var_265_7

				LuaForUtil.ClearLinePrefixSymbol(arg_262_1.text_)

				local var_265_9 = 35 <= 0 and var_265_5 or var_265_5 * (utf8.len(var_265_7) / 35)

				if (35 <= 0 and var_265_5 or var_265_5 * (utf8.len(var_265_7) / 35)) > 0 and var_265_5 < var_265_9 then
					arg_262_1.talkMaxDuration = var_265_9

					if var_265_9 + var_265_4 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_9 + var_265_4
					end
				end

				arg_262_1.text_.text = var_265_7
				arg_262_1.typewritter.percent = 0

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319631", "319631063", "story_v_out_319631.awb") ~= 0 then
					local var_265_10 = manager.audio:GetVoiceLength("story_v_out_319631", "319631063", "story_v_out_319631.awb") / 1000

					if var_265_10 + var_265_4 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_10 + var_265_4
					end

					if var_265_6.prefab_name ~= "" and arg_262_1.actors_[var_265_6.prefab_name] ~= nil then
						local var_265_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_262_1.actors_[var_265_6.prefab_name].transform, "story_v_out_319631", "319631063", "story_v_out_319631.awb")

						arg_262_1:RecordAudio("319631063", var_265_11)
						arg_262_1:RecordAudio("319631063", var_265_11)
					else
						arg_262_1:AudioAction("play", "voice", "story_v_out_319631", "319631063", "story_v_out_319631.awb")
					end

					arg_262_1:RecordHistoryTalkVoice("story_v_out_319631", "319631063", "story_v_out_319631.awb")
				end

				arg_262_1:RecordContent(arg_262_1.text_.text)
			end

			local var_265_12 = math.max(var_265_5, arg_262_1.talkMaxDuration)

			if var_265_4 <= arg_262_1.time_ and arg_262_1.time_ < var_265_4 + var_265_12 then
				arg_262_1.typewritter.percent = (arg_262_1.time_ - var_265_4) / var_265_12

				arg_262_1.typewritter:SetDirty()
			end

			if arg_262_1.time_ >= var_265_4 + var_265_12 and arg_262_1.time_ < var_265_4 + var_265_12 + arg_265_0 then
				arg_262_1.typewritter.percent = 1

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(true)
			end
		end

		arg_262_1.nodeConfigList_ = {}

		arg_262_1:InitPlayNodeList()
	end,
	Play319631064 = function(arg_266_0, arg_266_1)
		arg_266_1.time_ = 0
		arg_266_1.frameCnt_ = 0
		arg_266_1.state_ = "playing"
		arg_266_1.curTalkId_ = 319631064
		arg_266_1.duration_ = 8.43

		local var_266_0 = {
			zh = 6.033,
			ja = 8.433
		}
		local var_266_1 = manager.audio:GetLocalizationFlag()

		if var_266_0[var_266_1] ~= nil then
			arg_266_1.duration_ = var_266_0[var_266_1]
		end

		SetActive(arg_266_1.tipsGo_, false)

		function arg_266_1.onSingleLineFinish_()
			arg_266_1.onSingleLineUpdate_ = nil
			arg_266_1.onSingleLineFinish_ = nil
			arg_266_1.state_ = "waiting"
		end

		function arg_266_1.playNext_(arg_268_0)
			if arg_268_0 == 1 then
				arg_266_0:Play319631065(arg_266_1)
			end
		end

		function arg_266_1.onSingleLineUpdate_(arg_269_0)
			if 0 < arg_266_1.time_ and arg_266_1.time_ <= 0 + arg_269_0 then
				arg_266_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_2")
			end

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= 0 + arg_269_0 then
				arg_266_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_269_0 = 0
			local var_269_1 = 0.775

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= var_269_0 + arg_269_0 then
				arg_266_1.talkMaxDuration = 0
				arg_266_1.dialogCg_.alpha = 1

				arg_266_1.dialog_:SetActive(true)
				SetActive(arg_266_1.leftNameGo_, true)

				arg_266_1.leftNameTxt_.text = arg_266_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_266_1.leftNameTxt_.transform)

				arg_266_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_266_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_266_1:RecordName(arg_266_1.leftNameTxt_.text)
				SetActive(arg_266_1.iconTrs_.gameObject, false)
				arg_266_1.callingController_:SetSelectedState("normal")

				local var_269_2 = arg_266_1:GetWordFromCfg(319631064)
				local var_269_3 = arg_266_1:FormatText(var_269_2.content)

				arg_266_1.text_.text = var_269_3

				LuaForUtil.ClearLinePrefixSymbol(arg_266_1.text_)

				local var_269_5 = 31 <= 0 and var_269_1 or var_269_1 * (utf8.len(var_269_3) / 31)

				if (31 <= 0 and var_269_1 or var_269_1 * (utf8.len(var_269_3) / 31)) > 0 and var_269_1 < var_269_5 then
					arg_266_1.talkMaxDuration = var_269_5

					if var_269_5 + var_269_0 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_5 + var_269_0
					end
				end

				arg_266_1.text_.text = var_269_3
				arg_266_1.typewritter.percent = 0

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319631", "319631064", "story_v_out_319631.awb") ~= 0 then
					local var_269_6 = manager.audio:GetVoiceLength("story_v_out_319631", "319631064", "story_v_out_319631.awb") / 1000

					if var_269_6 + var_269_0 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_6 + var_269_0
					end

					if var_269_2.prefab_name ~= "" and arg_266_1.actors_[var_269_2.prefab_name] ~= nil then
						local var_269_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_266_1.actors_[var_269_2.prefab_name].transform, "story_v_out_319631", "319631064", "story_v_out_319631.awb")

						arg_266_1:RecordAudio("319631064", var_269_7)
						arg_266_1:RecordAudio("319631064", var_269_7)
					else
						arg_266_1:AudioAction("play", "voice", "story_v_out_319631", "319631064", "story_v_out_319631.awb")
					end

					arg_266_1:RecordHistoryTalkVoice("story_v_out_319631", "319631064", "story_v_out_319631.awb")
				end

				arg_266_1:RecordContent(arg_266_1.text_.text)
			end

			local var_269_8 = math.max(var_269_1, arg_266_1.talkMaxDuration)

			if var_269_0 <= arg_266_1.time_ and arg_266_1.time_ < var_269_0 + var_269_8 then
				arg_266_1.typewritter.percent = (arg_266_1.time_ - var_269_0) / var_269_8

				arg_266_1.typewritter:SetDirty()
			end

			if arg_266_1.time_ >= var_269_0 + var_269_8 and arg_266_1.time_ < var_269_0 + var_269_8 + arg_269_0 then
				arg_266_1.typewritter.percent = 1

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(true)
			end
		end

		arg_266_1.nodeConfigList_ = {}

		arg_266_1:InitPlayNodeList()
	end,
	Play319631065 = function(arg_270_0, arg_270_1)
		arg_270_1.time_ = 0
		arg_270_1.frameCnt_ = 0
		arg_270_1.state_ = "playing"
		arg_270_1.curTalkId_ = 319631065
		arg_270_1.duration_ = 5.33

		local var_270_0 = {
			zh = 5.333,
			ja = 4.433
		}
		local var_270_1 = manager.audio:GetLocalizationFlag()

		if var_270_0[var_270_1] ~= nil then
			arg_270_1.duration_ = var_270_0[var_270_1]
		end

		SetActive(arg_270_1.tipsGo_, false)

		function arg_270_1.onSingleLineFinish_()
			arg_270_1.onSingleLineUpdate_ = nil
			arg_270_1.onSingleLineFinish_ = nil
			arg_270_1.state_ = "waiting"
		end

		function arg_270_1.playNext_(arg_272_0)
			if arg_272_0 == 1 then
				arg_270_0:Play319631066(arg_270_1)
			end
		end

		function arg_270_1.onSingleLineUpdate_(arg_273_0)
			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 and not isNil(arg_270_1.actors_["4037ui_story"]) and arg_270_1.var_.characterEffect4037ui_story == nil then
				arg_270_1.var_.characterEffect4037ui_story = arg_270_1.actors_["4037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_273_0 = 0.200000002980232

			if 0 <= arg_270_1.time_ and arg_270_1.time_ < 0 + var_273_0 and not isNil(arg_270_1.actors_["4037ui_story"]) then
				if arg_270_1.var_.characterEffect4037ui_story and not isNil(arg_270_1.actors_["4037ui_story"]) then
					arg_270_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_270_1.time_ >= 0 + var_273_0 and arg_270_1.time_ < 0 + var_273_0 + arg_273_0 and not isNil(arg_270_1.actors_["4037ui_story"]) and arg_270_1.var_.characterEffect4037ui_story then
				arg_270_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			local var_273_2 = arg_270_1.actors_["10079ui_story"]

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 and not isNil(var_273_2) and arg_270_1.var_.characterEffect10079ui_story == nil then
				arg_270_1.var_.characterEffect10079ui_story = var_273_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_273_3 = 0.200000002980232

			if 0 <= arg_270_1.time_ and arg_270_1.time_ < 0 + var_273_3 and not isNil(var_273_2) then
				if arg_270_1.var_.characterEffect10079ui_story and not isNil(var_273_2) then
					arg_270_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_270_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_270_1.time_ - 0) / var_273_3)
				end
			end

			if arg_270_1.time_ >= 0 + var_273_3 and arg_270_1.time_ < 0 + var_273_3 + arg_273_0 and not isNil(var_273_2) and arg_270_1.var_.characterEffect10079ui_story then
				arg_270_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_270_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			local var_273_4 = 0
			local var_273_5 = 0.525

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= var_273_4 + arg_273_0 then
				arg_270_1.talkMaxDuration = 0
				arg_270_1.dialogCg_.alpha = 1

				arg_270_1.dialog_:SetActive(true)
				SetActive(arg_270_1.leftNameGo_, true)

				arg_270_1.leftNameTxt_.text = arg_270_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_270_1.leftNameTxt_.transform)

				arg_270_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_270_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_270_1:RecordName(arg_270_1.leftNameTxt_.text)
				SetActive(arg_270_1.iconTrs_.gameObject, false)
				arg_270_1.callingController_:SetSelectedState("normal")

				local var_273_6 = arg_270_1:GetWordFromCfg(319631065)
				local var_273_7 = arg_270_1:FormatText(var_273_6.content)

				arg_270_1.text_.text = var_273_7

				LuaForUtil.ClearLinePrefixSymbol(arg_270_1.text_)

				local var_273_9 = 21 <= 0 and var_273_5 or var_273_5 * (utf8.len(var_273_7) / 21)

				if (21 <= 0 and var_273_5 or var_273_5 * (utf8.len(var_273_7) / 21)) > 0 and var_273_5 < var_273_9 then
					arg_270_1.talkMaxDuration = var_273_9

					if var_273_9 + var_273_4 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_9 + var_273_4
					end
				end

				arg_270_1.text_.text = var_273_7
				arg_270_1.typewritter.percent = 0

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319631", "319631065", "story_v_out_319631.awb") ~= 0 then
					local var_273_10 = manager.audio:GetVoiceLength("story_v_out_319631", "319631065", "story_v_out_319631.awb") / 1000

					if var_273_10 + var_273_4 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_10 + var_273_4
					end

					if var_273_6.prefab_name ~= "" and arg_270_1.actors_[var_273_6.prefab_name] ~= nil then
						local var_273_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_270_1.actors_[var_273_6.prefab_name].transform, "story_v_out_319631", "319631065", "story_v_out_319631.awb")

						arg_270_1:RecordAudio("319631065", var_273_11)
						arg_270_1:RecordAudio("319631065", var_273_11)
					else
						arg_270_1:AudioAction("play", "voice", "story_v_out_319631", "319631065", "story_v_out_319631.awb")
					end

					arg_270_1:RecordHistoryTalkVoice("story_v_out_319631", "319631065", "story_v_out_319631.awb")
				end

				arg_270_1:RecordContent(arg_270_1.text_.text)
			end

			local var_273_12 = math.max(var_273_5, arg_270_1.talkMaxDuration)

			if var_273_4 <= arg_270_1.time_ and arg_270_1.time_ < var_273_4 + var_273_12 then
				arg_270_1.typewritter.percent = (arg_270_1.time_ - var_273_4) / var_273_12

				arg_270_1.typewritter:SetDirty()
			end

			if arg_270_1.time_ >= var_273_4 + var_273_12 and arg_270_1.time_ < var_273_4 + var_273_12 + arg_273_0 then
				arg_270_1.typewritter.percent = 1

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(true)
			end
		end

		arg_270_1.nodeConfigList_ = {}

		arg_270_1:InitPlayNodeList()
	end,
	Play319631066 = function(arg_274_0, arg_274_1)
		arg_274_1.time_ = 0
		arg_274_1.frameCnt_ = 0
		arg_274_1.state_ = "playing"
		arg_274_1.curTalkId_ = 319631066
		arg_274_1.duration_ = 18.53

		local var_274_0 = {
			zh = 9.133,
			ja = 18.533
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
				arg_274_0:Play319631067(arg_274_1)
			end
		end

		function arg_274_1.onSingleLineUpdate_(arg_277_0)
			if 0 < arg_274_1.time_ and arg_274_1.time_ <= 0 + arg_277_0 then
				arg_274_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037actionlink/4037action453")
			end

			if 0 < arg_274_1.time_ and arg_274_1.time_ <= 0 + arg_277_0 then
				arg_274_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_277_0 = 0
			local var_277_1 = 1.075

			if 0 < arg_274_1.time_ and arg_274_1.time_ <= var_277_0 + arg_277_0 then
				arg_274_1.talkMaxDuration = 0
				arg_274_1.dialogCg_.alpha = 1

				arg_274_1.dialog_:SetActive(true)
				SetActive(arg_274_1.leftNameGo_, true)

				arg_274_1.leftNameTxt_.text = arg_274_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_274_1.leftNameTxt_.transform)

				arg_274_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_274_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_274_1:RecordName(arg_274_1.leftNameTxt_.text)
				SetActive(arg_274_1.iconTrs_.gameObject, false)
				arg_274_1.callingController_:SetSelectedState("normal")

				local var_277_2 = arg_274_1:GetWordFromCfg(319631066)
				local var_277_3 = arg_274_1:FormatText(var_277_2.content)

				arg_274_1.text_.text = var_277_3

				LuaForUtil.ClearLinePrefixSymbol(arg_274_1.text_)

				local var_277_5 = 43 <= 0 and var_277_1 or var_277_1 * (utf8.len(var_277_3) / 43)

				if (43 <= 0 and var_277_1 or var_277_1 * (utf8.len(var_277_3) / 43)) > 0 and var_277_1 < var_277_5 then
					arg_274_1.talkMaxDuration = var_277_5

					if var_277_5 + var_277_0 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_5 + var_277_0
					end
				end

				arg_274_1.text_.text = var_277_3
				arg_274_1.typewritter.percent = 0

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319631", "319631066", "story_v_out_319631.awb") ~= 0 then
					local var_277_6 = manager.audio:GetVoiceLength("story_v_out_319631", "319631066", "story_v_out_319631.awb") / 1000

					if var_277_6 + var_277_0 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_6 + var_277_0
					end

					if var_277_2.prefab_name ~= "" and arg_274_1.actors_[var_277_2.prefab_name] ~= nil then
						local var_277_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_274_1.actors_[var_277_2.prefab_name].transform, "story_v_out_319631", "319631066", "story_v_out_319631.awb")

						arg_274_1:RecordAudio("319631066", var_277_7)
						arg_274_1:RecordAudio("319631066", var_277_7)
					else
						arg_274_1:AudioAction("play", "voice", "story_v_out_319631", "319631066", "story_v_out_319631.awb")
					end

					arg_274_1:RecordHistoryTalkVoice("story_v_out_319631", "319631066", "story_v_out_319631.awb")
				end

				arg_274_1:RecordContent(arg_274_1.text_.text)
			end

			local var_277_8 = math.max(var_277_1, arg_274_1.talkMaxDuration)

			if var_277_0 <= arg_274_1.time_ and arg_274_1.time_ < var_277_0 + var_277_8 then
				arg_274_1.typewritter.percent = (arg_274_1.time_ - var_277_0) / var_277_8

				arg_274_1.typewritter:SetDirty()
			end

			if arg_274_1.time_ >= var_277_0 + var_277_8 and arg_274_1.time_ < var_277_0 + var_277_8 + arg_277_0 then
				arg_274_1.typewritter.percent = 1

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(true)
			end
		end

		arg_274_1.nodeConfigList_ = {}

		arg_274_1:InitPlayNodeList()
	end,
	Play319631067 = function(arg_278_0, arg_278_1)
		arg_278_1.time_ = 0
		arg_278_1.frameCnt_ = 0
		arg_278_1.state_ = "playing"
		arg_278_1.curTalkId_ = 319631067
		arg_278_1.duration_ = 3.63

		local var_278_0 = {
			zh = 3.466,
			ja = 3.633
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
				arg_278_0:Play319631068(arg_278_1)
			end
		end

		function arg_278_1.onSingleLineUpdate_(arg_281_0)
			if 0 < arg_278_1.time_ and arg_278_1.time_ <= 0 + arg_281_0 and not isNil(arg_278_1.actors_["10079ui_story"]) and arg_278_1.var_.characterEffect10079ui_story == nil then
				arg_278_1.var_.characterEffect10079ui_story = arg_278_1.actors_["10079ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_281_0 = 0.200000002980232

			if 0 <= arg_278_1.time_ and arg_278_1.time_ < 0 + var_281_0 and not isNil(arg_278_1.actors_["10079ui_story"]) then
				if arg_278_1.var_.characterEffect10079ui_story and not isNil(arg_278_1.actors_["10079ui_story"]) then
					arg_278_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_278_1.time_ >= 0 + var_281_0 and arg_278_1.time_ < 0 + var_281_0 + arg_281_0 and not isNil(arg_278_1.actors_["10079ui_story"]) and arg_278_1.var_.characterEffect10079ui_story then
				arg_278_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			if 0 < arg_278_1.time_ and arg_278_1.time_ <= 0 + arg_281_0 then
				arg_278_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			if 0 < arg_278_1.time_ and arg_278_1.time_ <= 0 + arg_281_0 then
				arg_278_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_281_2 = arg_278_1.actors_["4037ui_story"]

			if 0 < arg_278_1.time_ and arg_278_1.time_ <= 0 + arg_281_0 and not isNil(var_281_2) and arg_278_1.var_.characterEffect4037ui_story == nil then
				arg_278_1.var_.characterEffect4037ui_story = var_281_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_281_3 = 0.200000002980232

			if 0 <= arg_278_1.time_ and arg_278_1.time_ < 0 + var_281_3 and not isNil(var_281_2) then
				if arg_278_1.var_.characterEffect4037ui_story and not isNil(var_281_2) then
					arg_278_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_278_1.var_.characterEffect4037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_278_1.time_ - 0) / var_281_3)
				end
			end

			if arg_278_1.time_ >= 0 + var_281_3 and arg_278_1.time_ < 0 + var_281_3 + arg_281_0 and not isNil(var_281_2) and arg_278_1.var_.characterEffect4037ui_story then
				arg_278_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_278_1.var_.characterEffect4037ui_story.fillRatio = 0.5
			end

			local var_281_4 = 0
			local var_281_5 = 0.425

			if 0 < arg_278_1.time_ and arg_278_1.time_ <= var_281_4 + arg_281_0 then
				arg_278_1.talkMaxDuration = 0
				arg_278_1.dialogCg_.alpha = 1

				arg_278_1.dialog_:SetActive(true)
				SetActive(arg_278_1.leftNameGo_, true)

				arg_278_1.leftNameTxt_.text = arg_278_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_278_1.leftNameTxt_.transform)

				arg_278_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_278_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_278_1:RecordName(arg_278_1.leftNameTxt_.text)
				SetActive(arg_278_1.iconTrs_.gameObject, false)
				arg_278_1.callingController_:SetSelectedState("normal")

				local var_281_6 = arg_278_1:GetWordFromCfg(319631067)
				local var_281_7 = arg_278_1:FormatText(var_281_6.content)

				arg_278_1.text_.text = var_281_7

				LuaForUtil.ClearLinePrefixSymbol(arg_278_1.text_)

				local var_281_9 = 17 <= 0 and var_281_5 or var_281_5 * (utf8.len(var_281_7) / 17)

				if (17 <= 0 and var_281_5 or var_281_5 * (utf8.len(var_281_7) / 17)) > 0 and var_281_5 < var_281_9 then
					arg_278_1.talkMaxDuration = var_281_9

					if var_281_9 + var_281_4 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_9 + var_281_4
					end
				end

				arg_278_1.text_.text = var_281_7
				arg_278_1.typewritter.percent = 0

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319631", "319631067", "story_v_out_319631.awb") ~= 0 then
					local var_281_10 = manager.audio:GetVoiceLength("story_v_out_319631", "319631067", "story_v_out_319631.awb") / 1000

					if var_281_10 + var_281_4 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_10 + var_281_4
					end

					if var_281_6.prefab_name ~= "" and arg_278_1.actors_[var_281_6.prefab_name] ~= nil then
						local var_281_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_278_1.actors_[var_281_6.prefab_name].transform, "story_v_out_319631", "319631067", "story_v_out_319631.awb")

						arg_278_1:RecordAudio("319631067", var_281_11)
						arg_278_1:RecordAudio("319631067", var_281_11)
					else
						arg_278_1:AudioAction("play", "voice", "story_v_out_319631", "319631067", "story_v_out_319631.awb")
					end

					arg_278_1:RecordHistoryTalkVoice("story_v_out_319631", "319631067", "story_v_out_319631.awb")
				end

				arg_278_1:RecordContent(arg_278_1.text_.text)
			end

			local var_281_12 = math.max(var_281_5, arg_278_1.talkMaxDuration)

			if var_281_4 <= arg_278_1.time_ and arg_278_1.time_ < var_281_4 + var_281_12 then
				arg_278_1.typewritter.percent = (arg_278_1.time_ - var_281_4) / var_281_12

				arg_278_1.typewritter:SetDirty()
			end

			if arg_278_1.time_ >= var_281_4 + var_281_12 and arg_278_1.time_ < var_281_4 + var_281_12 + arg_281_0 then
				arg_278_1.typewritter.percent = 1

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(true)
			end
		end

		arg_278_1.nodeConfigList_ = {}

		arg_278_1:InitPlayNodeList()
	end,
	Play319631068 = function(arg_282_0, arg_282_1)
		arg_282_1.time_ = 0
		arg_282_1.frameCnt_ = 0
		arg_282_1.state_ = "playing"
		arg_282_1.curTalkId_ = 319631068
		arg_282_1.duration_ = 5

		SetActive(arg_282_1.tipsGo_, false)

		function arg_282_1.onSingleLineFinish_()
			arg_282_1.onSingleLineUpdate_ = nil
			arg_282_1.onSingleLineFinish_ = nil
			arg_282_1.state_ = "waiting"
		end

		function arg_282_1.playNext_(arg_284_0)
			if arg_284_0 == 1 then
				arg_282_0:Play319631069(arg_282_1)
			end
		end

		function arg_282_1.onSingleLineUpdate_(arg_285_0)
			if 0 < arg_282_1.time_ and arg_282_1.time_ <= 0 + arg_285_0 then
				arg_282_1.var_.moveOldPos10079ui_story = arg_282_1.actors_["10079ui_story"].transform.localPosition
			end

			local var_285_0 = 0.001

			if 0 <= arg_282_1.time_ and arg_282_1.time_ < 0 + var_285_0 then
				arg_282_1.actors_["10079ui_story"].transform.localPosition = Vector3.Lerp(arg_282_1.var_.moveOldPos10079ui_story, Vector3.New(0, 100, 0), (arg_282_1.time_ - 0) / var_285_0)
				arg_282_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_282_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_282_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_282_1.actors_["10079ui_story"].transform.position).z)
				arg_282_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_282_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_282_1.actors_["10079ui_story"].transform.localEulerAngles = arg_282_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			if arg_282_1.time_ >= 0 + var_285_0 and arg_282_1.time_ < 0 + var_285_0 + arg_285_0 then
				arg_282_1.actors_["10079ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_282_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_282_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_282_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_282_1.actors_["10079ui_story"].transform.position).z)
				arg_282_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_282_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_282_1.actors_["10079ui_story"].transform.localEulerAngles = arg_282_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			local var_285_1 = arg_282_1.actors_["10079ui_story"]

			if 0 < arg_282_1.time_ and arg_282_1.time_ <= 0 + arg_285_0 and not isNil(var_285_1) and arg_282_1.var_.characterEffect10079ui_story == nil then
				arg_282_1.var_.characterEffect10079ui_story = var_285_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_285_2 = 0.200000002980232

			if 0 <= arg_282_1.time_ and arg_282_1.time_ < 0 + var_285_2 and not isNil(var_285_1) then
				if arg_282_1.var_.characterEffect10079ui_story and not isNil(var_285_1) then
					arg_282_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_282_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_282_1.time_ - 0) / var_285_2)
				end
			end

			if arg_282_1.time_ >= 0 + var_285_2 and arg_282_1.time_ < 0 + var_285_2 + arg_285_0 and not isNil(var_285_1) and arg_282_1.var_.characterEffect10079ui_story then
				arg_282_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_282_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			local var_285_3 = arg_282_1.actors_["4037ui_story"].transform

			if 0 < arg_282_1.time_ and arg_282_1.time_ <= 0 + arg_285_0 then
				arg_282_1.var_.moveOldPos4037ui_story = var_285_3.localPosition
			end

			local var_285_4 = 0.001

			if 0 <= arg_282_1.time_ and arg_282_1.time_ < 0 + var_285_4 then
				var_285_3.localPosition = Vector3.Lerp(arg_282_1.var_.moveOldPos4037ui_story, Vector3.New(0, 100, 0), (arg_282_1.time_ - 0) / var_285_4)
				var_285_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_285_3.position).x, (manager.ui.mainCamera.transform.position - var_285_3.position).y, (manager.ui.mainCamera.transform.position - var_285_3.position).z)
				var_285_3.localEulerAngles.z = 0
				var_285_3.localEulerAngles.x = 0
				var_285_3.localEulerAngles = var_285_3.localEulerAngles
			end

			if arg_282_1.time_ >= 0 + var_285_4 and arg_282_1.time_ < 0 + var_285_4 + arg_285_0 then
				var_285_3.localPosition = Vector3.New(0, 100, 0)
				var_285_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_285_3.position).x, (manager.ui.mainCamera.transform.position - var_285_3.position).y, (manager.ui.mainCamera.transform.position - var_285_3.position).z)
				var_285_3.localEulerAngles.z = 0
				var_285_3.localEulerAngles.x = 0
				var_285_3.localEulerAngles = var_285_3.localEulerAngles
			end

			local var_285_5 = 0
			local var_285_6 = 0.95

			if 0 < arg_282_1.time_ and arg_282_1.time_ <= var_285_5 + arg_285_0 then
				arg_282_1.talkMaxDuration = 0
				arg_282_1.dialogCg_.alpha = 1

				arg_282_1.dialog_:SetActive(true)
				SetActive(arg_282_1.leftNameGo_, false)

				arg_282_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_282_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_282_1:RecordName(arg_282_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_282_1.iconTrs_.gameObject, false)
				arg_282_1.callingController_:SetSelectedState("normal")

				local var_285_7 = arg_282_1:FormatText(arg_282_1:GetWordFromCfg(319631068).content)

				arg_282_1.text_.text = var_285_7

				LuaForUtil.ClearLinePrefixSymbol(arg_282_1.text_)

				local var_285_9 = 38 <= 0 and var_285_6 or var_285_6 * (utf8.len(var_285_7) / 38)

				if (38 <= 0 and var_285_6 or var_285_6 * (utf8.len(var_285_7) / 38)) > 0 and var_285_6 < var_285_9 then
					arg_282_1.talkMaxDuration = var_285_9

					if var_285_9 + var_285_5 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_9 + var_285_5
					end
				end

				arg_282_1.text_.text = var_285_7
				arg_282_1.typewritter.percent = 0

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(false)
				arg_282_1:RecordContent(arg_282_1.text_.text)
			end

			local var_285_10 = math.max(var_285_6, arg_282_1.talkMaxDuration)

			if var_285_5 <= arg_282_1.time_ and arg_282_1.time_ < var_285_5 + var_285_10 then
				arg_282_1.typewritter.percent = (arg_282_1.time_ - var_285_5) / var_285_10

				arg_282_1.typewritter:SetDirty()
			end

			if arg_282_1.time_ >= var_285_5 + var_285_10 and arg_282_1.time_ < var_285_5 + var_285_10 + arg_285_0 then
				arg_282_1.typewritter.percent = 1

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(true)
			end
		end

		arg_282_1.nodeConfigList_ = {
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
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_282_1:InitPlayNodeList()
	end,
	Play319631069 = function(arg_286_0, arg_286_1)
		arg_286_1.time_ = 0
		arg_286_1.frameCnt_ = 0
		arg_286_1.state_ = "playing"
		arg_286_1.curTalkId_ = 319631069
		arg_286_1.duration_ = 9.27

		local var_286_0 = {
			zh = 8.2,
			ja = 9.266
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
				arg_286_0:Play319631070(arg_286_1)
			end
		end

		function arg_286_1.onSingleLineUpdate_(arg_289_0)
			if 0 < arg_286_1.time_ and arg_286_1.time_ <= 0 + arg_289_0 then
				arg_286_1.var_.moveOldPos4037ui_story = arg_286_1.actors_["4037ui_story"].transform.localPosition
			end

			local var_289_0 = 0.001

			if 0 <= arg_286_1.time_ and arg_286_1.time_ < 0 + var_289_0 then
				arg_286_1.actors_["4037ui_story"].transform.localPosition = Vector3.Lerp(arg_286_1.var_.moveOldPos4037ui_story, Vector3.New(0, -1.12, -6.2), (arg_286_1.time_ - 0) / var_289_0)
				arg_286_1.actors_["4037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_286_1.actors_["4037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_286_1.actors_["4037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_286_1.actors_["4037ui_story"].transform.position).z)
				arg_286_1.actors_["4037ui_story"].transform.localEulerAngles.z = 0
				arg_286_1.actors_["4037ui_story"].transform.localEulerAngles.x = 0
				arg_286_1.actors_["4037ui_story"].transform.localEulerAngles = arg_286_1.actors_["4037ui_story"].transform.localEulerAngles
			end

			if arg_286_1.time_ >= 0 + var_289_0 and arg_286_1.time_ < 0 + var_289_0 + arg_289_0 then
				arg_286_1.actors_["4037ui_story"].transform.localPosition = Vector3.New(0, -1.12, -6.2)
				arg_286_1.actors_["4037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_286_1.actors_["4037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_286_1.actors_["4037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_286_1.actors_["4037ui_story"].transform.position).z)
				arg_286_1.actors_["4037ui_story"].transform.localEulerAngles.z = 0
				arg_286_1.actors_["4037ui_story"].transform.localEulerAngles.x = 0
				arg_286_1.actors_["4037ui_story"].transform.localEulerAngles = arg_286_1.actors_["4037ui_story"].transform.localEulerAngles
			end

			local var_289_1 = arg_286_1.actors_["4037ui_story"]

			if 0 < arg_286_1.time_ and arg_286_1.time_ <= 0 + arg_289_0 and not isNil(var_289_1) and arg_286_1.var_.characterEffect4037ui_story == nil then
				arg_286_1.var_.characterEffect4037ui_story = var_289_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_289_2 = 0.200000002980232

			if 0 <= arg_286_1.time_ and arg_286_1.time_ < 0 + var_289_2 and not isNil(var_289_1) then
				if arg_286_1.var_.characterEffect4037ui_story and not isNil(var_289_1) then
					arg_286_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_286_1.time_ >= 0 + var_289_2 and arg_286_1.time_ < 0 + var_289_2 + arg_289_0 and not isNil(var_289_1) and arg_286_1.var_.characterEffect4037ui_story then
				arg_286_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			if 0 < arg_286_1.time_ and arg_286_1.time_ <= 0 + arg_289_0 then
				arg_286_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action3_2")
			end

			if 0 < arg_286_1.time_ and arg_286_1.time_ <= 0 + arg_289_0 then
				arg_286_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_289_4 = 0
			local var_289_5 = 0.8

			if 0 < arg_286_1.time_ and arg_286_1.time_ <= var_289_4 + arg_289_0 then
				arg_286_1.talkMaxDuration = 0
				arg_286_1.dialogCg_.alpha = 1

				arg_286_1.dialog_:SetActive(true)
				SetActive(arg_286_1.leftNameGo_, true)

				arg_286_1.leftNameTxt_.text = arg_286_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_286_1.leftNameTxt_.transform)

				arg_286_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_286_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_286_1:RecordName(arg_286_1.leftNameTxt_.text)
				SetActive(arg_286_1.iconTrs_.gameObject, false)
				arg_286_1.callingController_:SetSelectedState("normal")

				local var_289_6 = arg_286_1:GetWordFromCfg(319631069)
				local var_289_7 = arg_286_1:FormatText(var_289_6.content)

				arg_286_1.text_.text = var_289_7

				LuaForUtil.ClearLinePrefixSymbol(arg_286_1.text_)

				local var_289_9 = 32 <= 0 and var_289_5 or var_289_5 * (utf8.len(var_289_7) / 32)

				if (32 <= 0 and var_289_5 or var_289_5 * (utf8.len(var_289_7) / 32)) > 0 and var_289_5 < var_289_9 then
					arg_286_1.talkMaxDuration = var_289_9

					if var_289_9 + var_289_4 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_9 + var_289_4
					end
				end

				arg_286_1.text_.text = var_289_7
				arg_286_1.typewritter.percent = 0

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319631", "319631069", "story_v_out_319631.awb") ~= 0 then
					local var_289_10 = manager.audio:GetVoiceLength("story_v_out_319631", "319631069", "story_v_out_319631.awb") / 1000

					if var_289_10 + var_289_4 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_10 + var_289_4
					end

					if var_289_6.prefab_name ~= "" and arg_286_1.actors_[var_289_6.prefab_name] ~= nil then
						local var_289_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_286_1.actors_[var_289_6.prefab_name].transform, "story_v_out_319631", "319631069", "story_v_out_319631.awb")

						arg_286_1:RecordAudio("319631069", var_289_11)
						arg_286_1:RecordAudio("319631069", var_289_11)
					else
						arg_286_1:AudioAction("play", "voice", "story_v_out_319631", "319631069", "story_v_out_319631.awb")
					end

					arg_286_1:RecordHistoryTalkVoice("story_v_out_319631", "319631069", "story_v_out_319631.awb")
				end

				arg_286_1:RecordContent(arg_286_1.text_.text)
			end

			local var_289_12 = math.max(var_289_5, arg_286_1.talkMaxDuration)

			if var_289_4 <= arg_286_1.time_ and arg_286_1.time_ < var_289_4 + var_289_12 then
				arg_286_1.typewritter.percent = (arg_286_1.time_ - var_289_4) / var_289_12

				arg_286_1.typewritter:SetDirty()
			end

			if arg_286_1.time_ >= var_289_4 + var_289_12 and arg_286_1.time_ < var_289_4 + var_289_12 + arg_289_0 then
				arg_286_1.typewritter.percent = 1

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(true)
			end
		end

		arg_286_1.nodeConfigList_ = {
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

		arg_286_1:InitPlayNodeList()
	end,
	Play319631070 = function(arg_290_0, arg_290_1)
		arg_290_1.time_ = 0
		arg_290_1.frameCnt_ = 0
		arg_290_1.state_ = "playing"
		arg_290_1.curTalkId_ = 319631070
		arg_290_1.duration_ = 11.3

		local var_290_0 = {
			zh = 7.666,
			ja = 11.3
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
				arg_290_0:Play319631071(arg_290_1)
			end
		end

		function arg_290_1.onSingleLineUpdate_(arg_293_0)
			local var_293_0 = 0.95

			if 0 < arg_290_1.time_ and arg_290_1.time_ <= 0 + arg_293_0 then
				arg_290_1.talkMaxDuration = 0
				arg_290_1.dialogCg_.alpha = 1

				arg_290_1.dialog_:SetActive(true)
				SetActive(arg_290_1.leftNameGo_, true)

				arg_290_1.leftNameTxt_.text = arg_290_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_290_1.leftNameTxt_.transform)

				arg_290_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_290_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_290_1:RecordName(arg_290_1.leftNameTxt_.text)
				SetActive(arg_290_1.iconTrs_.gameObject, false)
				arg_290_1.callingController_:SetSelectedState("normal")

				local var_293_1 = arg_290_1:GetWordFromCfg(319631070)
				local var_293_2 = arg_290_1:FormatText(var_293_1.content)

				arg_290_1.text_.text = var_293_2

				LuaForUtil.ClearLinePrefixSymbol(arg_290_1.text_)

				local var_293_4 = 38 <= 0 and var_293_0 or var_293_0 * (utf8.len(var_293_2) / 38)

				if (38 <= 0 and var_293_0 or var_293_0 * (utf8.len(var_293_2) / 38)) > 0 and var_293_0 < var_293_4 then
					arg_290_1.talkMaxDuration = var_293_4

					if var_293_4 + 0 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_4 + 0
					end
				end

				arg_290_1.text_.text = var_293_2
				arg_290_1.typewritter.percent = 0

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319631", "319631070", "story_v_out_319631.awb") ~= 0 then
					local var_293_5 = manager.audio:GetVoiceLength("story_v_out_319631", "319631070", "story_v_out_319631.awb") / 1000

					if var_293_5 + 0 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_5 + 0
					end

					if var_293_1.prefab_name ~= "" and arg_290_1.actors_[var_293_1.prefab_name] ~= nil then
						local var_293_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_290_1.actors_[var_293_1.prefab_name].transform, "story_v_out_319631", "319631070", "story_v_out_319631.awb")

						arg_290_1:RecordAudio("319631070", var_293_6)
						arg_290_1:RecordAudio("319631070", var_293_6)
					else
						arg_290_1:AudioAction("play", "voice", "story_v_out_319631", "319631070", "story_v_out_319631.awb")
					end

					arg_290_1:RecordHistoryTalkVoice("story_v_out_319631", "319631070", "story_v_out_319631.awb")
				end

				arg_290_1:RecordContent(arg_290_1.text_.text)
			end

			local var_293_7 = math.max(var_293_0, arg_290_1.talkMaxDuration)

			if 0 <= arg_290_1.time_ and arg_290_1.time_ < 0 + var_293_7 then
				arg_290_1.typewritter.percent = (arg_290_1.time_ - 0) / var_293_7

				arg_290_1.typewritter:SetDirty()
			end

			if arg_290_1.time_ >= 0 + var_293_7 and arg_290_1.time_ < 0 + var_293_7 + arg_293_0 then
				arg_290_1.typewritter.percent = 1

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(true)
			end
		end

		arg_290_1.nodeConfigList_ = {}

		arg_290_1:InitPlayNodeList()
	end,
	Play319631071 = function(arg_294_0, arg_294_1)
		arg_294_1.time_ = 0
		arg_294_1.frameCnt_ = 0
		arg_294_1.state_ = "playing"
		arg_294_1.curTalkId_ = 319631071
		arg_294_1.duration_ = 11.13

		local var_294_0 = {
			zh = 10.533,
			ja = 11.133
		}
		local var_294_1 = manager.audio:GetLocalizationFlag()

		if var_294_0[var_294_1] ~= nil then
			arg_294_1.duration_ = var_294_0[var_294_1]
		end

		SetActive(arg_294_1.tipsGo_, false)

		function arg_294_1.onSingleLineFinish_()
			arg_294_1.onSingleLineUpdate_ = nil
			arg_294_1.onSingleLineFinish_ = nil
			arg_294_1.state_ = "waiting"
		end

		function arg_294_1.playNext_(arg_296_0)
			if arg_296_0 == 1 then
				arg_294_0:Play319631072(arg_294_1)
			end
		end

		function arg_294_1.onSingleLineUpdate_(arg_297_0)
			local var_297_0 = 0.75

			if 0 < arg_294_1.time_ and arg_294_1.time_ <= 0 + arg_297_0 then
				arg_294_1.talkMaxDuration = 0
				arg_294_1.dialogCg_.alpha = 1

				arg_294_1.dialog_:SetActive(true)
				SetActive(arg_294_1.leftNameGo_, true)

				arg_294_1.leftNameTxt_.text = arg_294_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_294_1.leftNameTxt_.transform)

				arg_294_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_294_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_294_1:RecordName(arg_294_1.leftNameTxt_.text)
				SetActive(arg_294_1.iconTrs_.gameObject, false)
				arg_294_1.callingController_:SetSelectedState("normal")

				local var_297_1 = arg_294_1:GetWordFromCfg(319631071)
				local var_297_2 = arg_294_1:FormatText(var_297_1.content)

				arg_294_1.text_.text = var_297_2

				LuaForUtil.ClearLinePrefixSymbol(arg_294_1.text_)

				local var_297_4 = 30 <= 0 and var_297_0 or var_297_0 * (utf8.len(var_297_2) / 30)

				if (30 <= 0 and var_297_0 or var_297_0 * (utf8.len(var_297_2) / 30)) > 0 and var_297_0 < var_297_4 then
					arg_294_1.talkMaxDuration = var_297_4

					if var_297_4 + 0 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_4 + 0
					end
				end

				arg_294_1.text_.text = var_297_2
				arg_294_1.typewritter.percent = 0

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319631", "319631071", "story_v_out_319631.awb") ~= 0 then
					local var_297_5 = manager.audio:GetVoiceLength("story_v_out_319631", "319631071", "story_v_out_319631.awb") / 1000

					if var_297_5 + 0 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_5 + 0
					end

					if var_297_1.prefab_name ~= "" and arg_294_1.actors_[var_297_1.prefab_name] ~= nil then
						local var_297_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_294_1.actors_[var_297_1.prefab_name].transform, "story_v_out_319631", "319631071", "story_v_out_319631.awb")

						arg_294_1:RecordAudio("319631071", var_297_6)
						arg_294_1:RecordAudio("319631071", var_297_6)
					else
						arg_294_1:AudioAction("play", "voice", "story_v_out_319631", "319631071", "story_v_out_319631.awb")
					end

					arg_294_1:RecordHistoryTalkVoice("story_v_out_319631", "319631071", "story_v_out_319631.awb")
				end

				arg_294_1:RecordContent(arg_294_1.text_.text)
			end

			local var_297_7 = math.max(var_297_0, arg_294_1.talkMaxDuration)

			if 0 <= arg_294_1.time_ and arg_294_1.time_ < 0 + var_297_7 then
				arg_294_1.typewritter.percent = (arg_294_1.time_ - 0) / var_297_7

				arg_294_1.typewritter:SetDirty()
			end

			if arg_294_1.time_ >= 0 + var_297_7 and arg_294_1.time_ < 0 + var_297_7 + arg_297_0 then
				arg_294_1.typewritter.percent = 1

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(true)
			end
		end

		arg_294_1.nodeConfigList_ = {}

		arg_294_1:InitPlayNodeList()
	end,
	Play319631072 = function(arg_298_0, arg_298_1)
		arg_298_1.time_ = 0
		arg_298_1.frameCnt_ = 0
		arg_298_1.state_ = "playing"
		arg_298_1.curTalkId_ = 319631072
		arg_298_1.duration_ = 13.54

		SetActive(arg_298_1.tipsGo_, false)

		function arg_298_1.onSingleLineFinish_()
			arg_298_1.onSingleLineUpdate_ = nil
			arg_298_1.onSingleLineFinish_ = nil
			arg_298_1.state_ = "waiting"
			arg_298_1.auto_ = false
		end

		function arg_298_1.playNext_(arg_300_0)
			arg_298_1.onStoryFinished_()
		end

		function arg_298_1.onSingleLineUpdate_(arg_301_0)
			if 0 < arg_298_1.time_ and arg_298_1.time_ <= 0 + arg_301_0 then
				arg_298_1.mask_.enabled = true
				arg_298_1.mask_.raycastTarget = true

				arg_298_1:SetGaussion(false)
			end

			local var_301_0 = 1

			if 0 <= arg_298_1.time_ and arg_298_1.time_ < 0 + var_301_0 then
				local var_301_1 = Color.New(0, 0, 0)

				var_301_1.a = Mathf.Lerp(0, 1, (arg_298_1.time_ - 0) / var_301_0)
				arg_298_1.mask_.color = var_301_1
			end

			if arg_298_1.time_ >= 0 + var_301_0 and arg_298_1.time_ < 0 + var_301_0 + arg_301_0 then
				local var_301_2 = Color.New(0, 0, 0)

				var_301_2.a = 1
				arg_298_1.mask_.color = var_301_2
			end

			local var_301_3 = 1

			if 1 < arg_298_1.time_ and arg_298_1.time_ <= var_301_3 + arg_301_0 then
				arg_298_1.mask_.enabled = true
				arg_298_1.mask_.raycastTarget = true

				arg_298_1:SetGaussion(false)
			end

			local var_301_4 = 0.1

			if var_301_3 <= arg_298_1.time_ and arg_298_1.time_ < var_301_3 + var_301_4 then
				local var_301_5 = Color.New(0, 0, 0)

				var_301_5.a = Mathf.Lerp(1, 0, (arg_298_1.time_ - var_301_3) / var_301_4)
				arg_298_1.mask_.color = var_301_5
			end

			if arg_298_1.time_ >= var_301_3 + var_301_4 and arg_298_1.time_ < var_301_3 + var_301_4 + arg_301_0 then
				local var_301_6 = Color.New(0, 0, 0)

				arg_298_1.mask_.enabled = false
				var_301_6.a = 0
				arg_298_1.mask_.color = var_301_6
			end

			local var_301_7 = 1

			if 1 < arg_298_1.time_ and arg_298_1.time_ <= var_301_7 + arg_301_0 then
				SetActive(arg_298_1.dialog_, false)
				SetActive(arg_298_1.allBtn_.gameObject, false)
				arg_298_1.hideBtnsController_:SetSelectedIndex(1)
				arg_298_1:StopAllVoice()

				arg_298_1.marker = "mlv06"

				manager.video:Play("SofdecAsset/story/story_1031963.usm", function(arg_302_0)
					arg_298_1:Skip(arg_302_0)
					manager.video:Dispose()
				end, nil, nil, function(arg_303_0)
					arg_298_1.state_ = arg_303_0 and "pause" or "playing"
				end, 1031963)
				manager.video.transform_:SetSiblingIndex(1)
			end

			local var_301_8 = 12.5416666666667

			if var_301_7 <= arg_298_1.time_ and arg_298_1.time_ < var_301_7 + var_301_8 then
				-- block empty
			end

			if arg_298_1.time_ >= var_301_7 + var_301_8 and arg_298_1.time_ < var_301_7 + var_301_8 + arg_301_0 then
				arg_298_1.marker = ""
			end
		end

		arg_298_1.nodeConfigList_ = {}

		arg_298_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/Z03f",
		"TextureConfig/Background/STblack",
		"SofdecAsset/story/story_1031963.usm"
	},
	voices = {
		"story_v_out_319631.awb"
	},
	skipMarkers = {
		319631072
	}
}
